local name,ZGV = ...

ZGV.TalentAdvisor = {}

local TA = ZGV.TalentAdvisor
local CHAIN = ZGV.ChainCall

function TA.Initialise()
	if TA.Initialised then return end
	-- hook functions
	PlayerSpellsFrame.TalentsFrame:HookScript("OnShow",function() TA.SetTalents() end)
	--ZGV:AddEventHandler("TRAIT_NODE_CHANGED",TA.DelayedSetTalents)
	ZGV:AddEventHandler("TRAIT_TREE_CURRENCY_INFO_UPDATED",TA.DelayedSetTalents)

	-- set up icons
	TA.IconPool = CreateFramePool("BUTTON",nil,"ZygorTalentIconButton")
	TA.IconSelectionPool = CreateFramePool("BUTTON",nil,"ZygorTalentIconButton")

	TA.SpecIcon  = CHAIN(CreateFrame("Button"))
		:SetSize(30,30)
		:SetPoint("TOPRIGHT")
		:SetNormalTexture(ZGV.DIR.."\\Skins\\zygor-round")
		:SetFrameStrata("HIGH")
		:SetFrameLevel(76)	
		:SetScript("OnEnter", function() TA.ShowTooltip(TA.SpecIcon) end)
		:SetScript("OnLeave", function() GameTooltip:Hide() end)
		:Hide()
	.__END
	TA.SpecIcon:GetNormalTexture():SetTexCoord(0,0,0,1/2 , 1,0,1,1/2)

	-- add menu button
	local mapbuttonsize=20

	TA.MenuButton = ZGV.ChainCall(CreateFrame("BUTTON",nil,PlayerSpellsFrame.TalentsFrame,"ZygorSpecialButton_Template"))
		:ApplySkin()
		:SetSize(32,32)
		:SetPoint("RIGHT",PlayerSpellsFrame.TalentsFrame.ApplyButton,"LEFT", -20, 0)
		:SetFrameLevel(611)

		:SetScript("OnClick", function() TA:ShowMenu() end)
		:Show()
	.__END

	-- record class
	TA.PlayerClass = select(2,UnitClass("player"))
	TA.ClassBuilds = TA.Builds[TA.PlayerClass]
	
	TA.Initialised = true

	-- strip TalentNodes, do reverse mapping
	TA.TalentNodes = TA.TalentNodes[TA.PlayerClass]
	TA.TalentNodesLookup = {}
	for name,node in pairs(TA.TalentNodes) do
		if type(node)=="table" then
			for _,variant in ipairs(node) do
				TA.TalentNodesLookup[variant]=name
			end
		else
			TA.TalentNodesLookup[node]=name
		end
	end

	ZGV:ScheduleRepeatingTimer(function() 
		if TA.Learning then
			TA:LearnNextTalent()
		end
	end,0.1)
end

function TA.ShowTooltip(object)
	GameTooltip:SetOwner(object,"ANCHOR_TOP")
	GameTooltip:SetText("Zygor recommendation")
	GameTooltip:Show()
end

function TA.DelayedSetTalents() 
	-- TRAIT_TREE_CURRENCY_INFO_UPDATED can now fire outside of talent frame, make sure we are loaded first
	if not (PlayerSpellsFrame and PlayerSpellsFrame.TalentsFrame:IsVisible()) then return end
	if not TA.Initialised then return end 
	C_Timer.After(0,function() TA.SetTalents()  end)
end

local function getNodeEntries(nodeInfo)
	local entries = {}
	for _,entry in ipairs(nodeInfo.entryIDs) do table.insert(entries,entry) end
	if nodeInfo.type==0 then entries[2]=nil end -- some nodes have split entries eventhough they are single talent ones

	return entries
end

function TA.SetTalents(ident) 
	if not ZGV.db.profile.talenton then return end
	if not ZGV.db.profile.ta_toggle_icons then return end

	-- map blizzard talent buttons to entryIDs
	TA.NodeToEntry = {}
	TA.blizzbuttons = {}
	TA.entrytonode = {}
	TA.export = PlayerSpellsFrame.TalentsFrame.nodeIDToButton
	for _,blizzbutton in pairs(PlayerSpellsFrame.TalentsFrame.nodeIDToButton) do
		local nodeInfo = blizzbutton.nodeInfo
		for entryNum,entryID in ipairs(getNodeEntries(nodeInfo)) do
			TA.blizzbuttons[entryID] = blizzbutton
			TA.entrytonode[entryID] = nodeInfo
			TA.NodeToEntry[("%s,%s,%s"):format(nodeInfo.posX,nodeInfo.posY,entryNum)]=entryID
		end
	end

	ident = ident or ZGV.db.char.talentbuilds

	-- get build
	TA.ActiveBuild = TA:GetBuild(ident) 
	if not TA.ActiveBuild then return end

	-- get build status
	local status = TA:GetBuildStatus() 

	-- for each talent in build, find node, show icons
	TA.IconPool:ReleaseAll()
	for entryID,data in pairs(status) do
		local blizzbutton = TA.blizzbuttons[entryID]
		if blizzbutton and data~="GOOD" then
			local nodeinfo = blizzbutton.nodeInfo
			local available = nodeinfo.meetsEdgeRequirements
			local value = data

			if type(data)=="table" then
				value = data[1]
				available = not data[2] and available
			end

			local zygorbutton = TA.IconPool:Acquire()
			CHAIN(zygorbutton)
				:SetParent(blizzbutton)
				:SetPoint("TOPRIGHT",blizzbutton,"TOPRIGHT",18,18)
				:SetFrameStrata("MEDIUM")
				:SetFrameLevel(1900)
				:SetValue(value)
				:Show()

			-- sets desaturation if node can't be reached, or paid for
			zygorbutton:SetAvailable(available and blizzbutton:CanAfford())
		end
	end
end

function TA:ParseLines(text)
	local array={}
	local index=1
	local st,en,line
	text = text .. "\n"
	local count

	if not TA.TalentNodes then return array end

	local TalentNodes = TA.TalentNodes

	while (index<#text) do
		st,en,line=string.find(text,"(.-)\n",index)
		if not en then break end
		index = en + 1
		line = line:gsub("//.*$",""):gsub("%-%-.*$","")  -- comments away
		line = line:gsub("^[%s	]+",""):gsub("[%s	]+$","")  -- whitespace away
		line = line:gsub("||","|")
		line = line:gsub("/[0-9]+","")  -- /3 are just fluff, remove

		if line~="" then tinsert(array,line) end
	end
	return array
end

local function GetConfigID()
	return PlayerSpellsFrame.TalentsFrame.configurationInfo.ID
end

function TA:GetBuild(ident) 
	-- get build data
	local build
	
	for i,v in pairs(TA.ClassBuilds) do
		if v.ident == ident then
			build = v
		end
	end
	if not build then
		for i,v in pairs(TA.ClassBuilds) do
			if v.spec == spec and v.suggested then
				build = v
			end
		end
	end
	
	if not build then return end
	ZGV.db.char.talentbuilds = build.ident

	-- parse build, explode to one point per entry
	local talentFrame = PlayerSpellsFrame.TalentsFrame
	
	local configID = GetConfigID()
	local currencyToTree={}
	for i,v in pairs(talentFrame.treeCurrencyInfo) do currencyToTree[v.traitCurrencyID] = i end

	if not build.parsed then 
		build.talents = TA:ParseLines(build.talents) 
	end
	
	build.parsed = true
	return build
end

local function getEntryIDbyTalent(talent)
	if not TA.ActiveBuild then return false end
	local node = TA.TalentNodes[talent]
	if type(node)=="table" then
		local returns={}
		for _,multinode in ipairs(node) do
			table.insert(returns,TA.NodeToEntry[multinode])
		end
		return returns
	end
	return TA.NodeToEntry[node]
end

function TA:GetBuildStatus()
	local build = TA.ActiveBuild
	local status = {}

	if not build then return status end
	
	local currencyInfo = PlayerSpellsFrame.TalentsFrame.treeCurrencyInfo
	if not currencyInfo then return status end
	
	local total_points = {}
	for _,talent in ipairs(build.talents) do
		local entryID = getEntryIDbyTalent(talent)
		if entryID then
			if type(entryID)=="table" then
				for i,multiEntryID  in pairs(entryID) do
					total_points[multiEntryID] = (total_points[multiEntryID] or 0) + 1
				end
			else
				total_points[entryID] = (total_points[entryID] or 0) + 1
			end
		end
	end
	
	-- check if nodes have correct amount of points spent
	for _,blizzbutton in pairs(PlayerSpellsFrame.TalentsFrame.nodeIDToButton) do
		local nodeInfo = blizzbutton.nodeInfo
		local activeEntry = nodeInfo.activeEntry 
		local entryInfo = blizzbutton.entryInfo 
		local activeEntryID = activeEntry and activeEntry.entryID
		local isCapstoneNode = entryInfo and (entryInfo.type == Enum.TraitNodeEntryType.SpendCapstoneCircle or entryInfo.type == Enum.TraitNodeEntryType.SpendCapstoneSquare);
		local currentRank = activeEntry and activeEntry.rank or nodeInfo.activeRank
		if isCapstoneNode then currentRank = activeEntry.entryID==blizzbutton.entryID and nodeInfo.activeRank or 0 end
		
		if activeEntryID then
			if (nodeInfo.currentRank or 0)>(nodeInfo.ranksPurchased or 0) then
				-- talent learned automatically, cannot be unlearned
				status[activeEntryID] = "GOOD"
			elseif not total_points[activeEntryID] then
				if currentRank>0 then
					status[activeEntryID] = "BAD"
				end
			elseif total_points[activeEntryID]==currentRank then
				status[activeEntryID] = "GOOD"
			elseif total_points[activeEntryID]<currentRank then
				status[activeEntryID] = "BAD"
			else
				status[activeEntryID] = total_points[activeEntryID] - currentRank
			end
		else
			for _,entryID in ipairs(getNodeEntries(nodeInfo)) do
				if not total_points[entryID] then
					if currentRank>0 then
						status[entryID] = "BAD"
					end
				elseif total_points[entryID]==currentRank  then
					status[entryID] = "GOOD"
				elseif total_points[entryID]<currentRank then
					status[entryID] = "BAD"
				else
					status[entryID] = total_points[entryID] - currentRank
				end
			end
		end
	end

	local points_at_level = {}
	local foundNext = false
	for i,talent in ipairs(build.talents) do
		local entryID = getEntryIDbyTalent(talent)
		if not entryID then 
			ZGV:Error("Talent Advisor: Talent "..talent.." not found")
			break
		end
		
		local node = TA.entrytonode[entryID]
		points_at_level[entryID] = (points_at_level[entryID] or 0) + 1
		
		local activeEntry = node.activeEntry 
		local node_entryID = activeEntry and activeEntry.entryID or node.entryIDs[1]
		local currentRank = activeEntry and activeEntry.rank or node.activeRank or 0

		if tonumber(status[entryID]) then
			if points_at_level[entryID] > currentRank then
				status[entryID] = {tonumber(status[entryID]), foundNext}
				foundNext = true
			end
		end
	end

	-- return array of etries-status for current level
	return status
end

function TA:LearnBuild()
	local build = TA.ActiveBuild
	if not build then return end

	local talentsframe = PlayerSpellsFrame.TalentsFrame

	local configID = GetConfigID()
	local treeID = talentsframe.talentTreeID
	C_Traits.ResetTree(configID,treeID)

	local currencyToTree={}
	for i,v in pairs(talentsframe.treeCurrencyInfo) do currencyToTree[v.traitCurrencyID] = i end

	-- wait till next frame, so that blizz data for nodes refreshes into reset state
	ZGV:ScheduleTimer(function() TA.Learning = true end,0)
end

function logerror(index,name,spell,reason)
	ZGV:Debug(("&talentadvisor Failed to learn %s %s##%s : %s"):format(index,name or "?",spell or "?",reason))
end

function TA:LearnNextTalent()
	local build = TA.ActiveBuild
	if not build then return end

	local configID = GetConfigID()
	local treeID = PlayerSpellsFrame.TalentsFrame.talentTreeID

	local points_at_level = {}
	local currencyInfo = PlayerSpellsFrame.TalentsFrame.treeCurrencyInfo
	
	local pointsMax = currencyInfo[1].maxQuantity
	local builddata = build.talents
	for i=1,pointsMax do
		if builddata[i] then
			local spellID = builddata[i]
			local entryID = spellID and getEntryIDbyTalent(builddata[i])
			if spellID and entryID then
				local node = TA.entrytonode[entryID]
				
				points_at_level[entryID] = (points_at_level[entryID] or 0) + 1

				if node then 
					if not node.meetsEdgeRequirements then
						logerror(i,builddata[i].name,spellID,"requirements not met")
						TA.Learning = false
						return
					end
					local activeEntry = node.activeEntry 
					local node_entryID = activeEntry and activeEntry.entryID or node.entryIDs[1]
					local currentRank = activeEntry and activeEntry.rank or node.activeRank or 0

					if node_entryID~=entryID or points_at_level[entryID] > currentRank then
						node.activeEntry = node.activeEntry or {}
						node.activeEntry.entryID = entryID
						node.activeEntry.rank = points_at_level[entryID]
						if #node.entryIDs>1 and not node.nextEntry then
							C_Traits.SetSelection(configID,node.ID,entryID)
						else
							C_Traits.PurchaseRank(configID,node.ID)
						end
						return
					end
				else
					logerror(i,builddata[i].name,entryID,"node doesn't exist")
					TA.Learning = false
					return
				end
			else
				logerror(i,builddata[i].name,spellID,"entry doesn't exist")
				TA.Learning = false
				return
			end
		end
	end

	TA.Learning = false
	return
end

function TA:Toggle(mode)
	-- show/hide icons
	if not TA.Initialised then return end

	if mode then
		TA.SetSpec()
		TA.SetTalents()
		TA.SpecIcon:Show()
		TA.MenuButton:Show()
	else
		TA.IconPool:ReleaseAll()
		TA.IconSelectionPool:ReleaseAll()
		TA.SpecIcon:Hide()
		TA.MenuButton:Hide()
	end
end

function TA:ShowMenu()
	local L=ZygorGuidesViewer_L("zta")
	local parent=TA.MenuButton
	if not TA.MenuDropdown then TA.MenuDropdown = CreateFrame("FRAME",nil,TA.MenuButton,"UIDropDownForkTemplate") end
	if DropDownForkList1 and DropDownForkList1:IsShown() and DropDownForkList1.dropdown==TA.MenuDropdown then CloseDropDownForks() return end
	UIDropDownFork_SetAnchor(TA.MenuDropdown, 0, 0, "BOTTOMLEFT", TA.MenuButton, "BOTTOMRIGHT")

	local menu = {
		{ 
			text = L['ta_toggle_icons'],
			keepShownOnClick=true, 
			checked = function() return ZGV.db.profile.ta_toggle_icons end, 
			func = function() 
				ZGV.db.profile.ta_toggle_icons = not ZGV.db.profile.ta_toggle_icons
				TA:Toggle(ZGV.db.profile.ta_toggle_icons)
				UIDropDownFork_Refresh(TA.MenuDropdown) 
			end 
		},
		{
			text = L['ta_select_suggested'],
			func = function() TA:LearnBuild() end,
			notCheckable=0,
		},
		UIDropDownFork_separatorInfo,
	}


	if TA.ClassBuilds then
		for _,build in ipairs(TA.ClassBuilds) do
			table.insert(menu,{
				text = build.name,
				func = function() TA.SetTalents(build.ident) UIDropDownFork_RefreshAll(TA.MenuDropdown) end,
				checked = function() 
					return ZGV.db.char.talentbuilds==build.ident 
				end,
				keepShownOnClick = true,
			})
		end
	end

	if ZGV.DEV then
		table.insert(menu,UIDropDownFork_separatorInfo)
		table.insert(menu,{
			text = "DEV: Live record build",
			func = function() ZGV.Testing.RecordTalents() end,
			notCheckable=0,
		})
		table.insert(menu,{
			text = "DEV: Dump talents",
			func = function() ZGV.Testing.dumpCurrentSpec("nonext",nil,"skiphero") end,
			notCheckable=0,
		})
		table.insert(menu,{
			text = "DEV: Export current build",
			func = function() ZGV.Testing.ExportCurrentBuild() end,
			notCheckable=0,
		})
		table.insert(menu,{
			text = "DEV: Check for talent changes",
			func = function() ZGV.Testing.CheckForChanges() end,
			notCheckable=0,
		})
	end


	

	EasyFork(menu,TA.MenuDropdown,nil,0,0,"MENU",false)
	UIDropDownFork_SetWidth(TA.MenuDropdown, 300)
end

ZygorTalentIconButton_Mixin = {}
function ZygorTalentIconButton_Mixin:SetValue(value)
	self:EnableMouse(false)	
	self.currentvalue = value
	ZGV.IconSets.TalentPoints[value]:AssignToTexture(self:GetNormalTexture())
end

function ZygorTalentIconButton_Mixin:SetAvailable(mode)
	self.playAnimation = false
	self.glow:Hide()
	self:SetScript("OnUpdate",nil)

	local mode = mode or self.currentvalue=="BAD" -- bad is always highlighted
	if mode then
		if self.currentvalue=="GOOD" then
			self:SetAlpha(0.5)
		else
			self:SetAlpha(1)
			if self.currentvalue~="BAD" then
				self.playAnimation = true
				self.glow:Show()
				self.el = 0
				self.animcycle = 0
				self:SetScript("OnUpdate",self.HandleAnimation)
			end
		end
	else
		self:SetAlpha(0.5)
	end
	self:GetNormalTexture():SetDesaturated(not mode)
end

function ZygorTalentIconButton_Mixin:HandleAnimation(elapsed)
	if not self.playAnimation then return end
	
	self.el = self.el + elapsed
	if self.el>0.1 then
		self.el = 0
		self.animcycle = self.animcycle + 1
		if self.animcycle>8 then self.animcycle=1 end
		local texkey = "ANIM" .. self.animcycle
		ZGV.IconSets.TalentPoints[texkey]:AssignToTexture(self.glow.tex)
	end
end

tinsert(ZGV.startups,{"Talent Advisor",function(self)
	EventUtil.ContinueOnAddOnLoaded("Blizzard_PlayerSpells", TA.Initialise);
end})