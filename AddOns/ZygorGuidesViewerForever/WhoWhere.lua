local name,ZGV=...

local WW={}
ZGV.WhoWhere=WW

local HBD = ZGV.HBD

local hide_timer_main = 0
local hide_timer_proff = 0

local ui = ZGV.UI
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local L = ZGV.L

local SkinData = ZGV.UI.SkinData

local LibRover = LibStub("LibRover-1.0")

WW.Types = {}

function WW:SetupMenuArray()
	local _, playerclass = UnitClass("player")

	local Tradeskills = {
		{text="Alchemy",		iconkey="ALCHEMY"},
		{text="Archaeology",	iconkey="ARCHAEOLOGY"},
		{text="Bandages",		iconkey="FIRSTAID"},
		{text="Blacksmithing",	iconkey="BLACKSMITHING"},
		{text="Cooking",		iconkey="COOKING"},
		{text="Enchanting",		iconkey="ENCHANTING"},
		{text="Engineering",	iconkey="ENGINEERING"},
		{text="First Aid",		iconkey="FIRSTAID"},
		{text="Fishing",		iconkey="FISHING"},
		{text="Herbalism",		iconkey="HERBALISM"},
		{text="Inscription",	iconkey="INSCRIPTION"},
		{text="Jewelcrafting",	iconkey="JEWELCRAFTING"},
		{text="Leatherworking",	iconkey="LEATHERWORKING"},
		{text="Mining",			iconkey="MINING"},
		{text="Skinning",		iconkey="SKINNING"},
		{text="Tailoring",		iconkey="TAILORING"},
	}

	if ZGV.IsRetail then
		table.remove(Tradeskills,8) -- first aid
	elseif ZGV.IsClassicMOP then
		table.remove(Tradeskills,3) -- bandages
	elseif ZGV.IsClassicTBC then
		table.remove(Tradeskills,11) -- inscription
		table.remove(Tradeskills,3) -- bandages
	elseif ZGV.IsClassicWOTLK then
		table.remove(Tradeskills,3) -- bandages
	elseif ZGV.IsClassic or ZGV.IsForever then
		table.remove(Tradeskills,12) -- jewelcrafting
		table.remove(Tradeskills,11) -- inscription
		table.remove(Tradeskills,3) -- bandages
	end

	for i,v in ipairs(Tradeskills) do
		v.func = v.func or function() ZGV.WhoWhere:FindNPC("Trainer"..(v.type or v.text)) CloseDropDownForks() end 
		v.notCheckable = 1
		v.iconset = ZGV.IconSets.WorldQuest
		--if ZGV.Professions.SkillsKnown[v.text] then v.colorCode = "|cfffe6100" end
	end

	local Tradeskills_Workshops
	if ZGV.IsRetail then
		Tradeskills_Workshops = ZGV.F.DeepCopy(Tradeskills)
		table.remove(Tradeskills_Workshops,14) -- skinning
		table.remove(Tradeskills_Workshops,13) -- mining
		table.remove(Tradeskills_Workshops,9) -- herbalism
		table.remove(Tradeskills_Workshops,8) -- fishing
		table.remove(Tradeskills_Workshops,5) -- cooking
		table.remove(Tradeskills_Workshops,3) -- bandages
		table.remove(Tradeskills_Workshops,2) -- arch
		for i,v in ipairs(Tradeskills_Workshops) do v.func = function() ZGV.WhoWhere:FindNPC("Trainer"..(v.type or v.text).."Workshop") CloseDropDownForks() end  end
	end

	local Classes = {
		{text="Druid"},
		{text="Hunter"},
		{text="Hunter pets",overicon="Hunter"},
		{text="Mage"},
		{text="Paladin"},
		{text="Priest"},
		{text="Rogue"},
		{text="Shaman"},
		{text="Warlock"},
		{text="Warrior"}
	}

	for i,v in ipairs(Classes) do
		v.func = v.func or function() WW:FindNPC("Class"..(v.type or v.text)) CloseDropDownForks() end 
		v.notCheckable = 1
		v.icon = "Interface\\TargetingFrame\\UI-Classes-Circles"
		local texcoord=CLASS_ICON_TCOORDS[(v.overicon or v.text):upper()]
		v.tCoordLeft = texcoord[1]
		v.tCoordRight = texcoord[2]
		v.tCoordTop = texcoord[3]
		v.tCoordBottom = texcoord[4]
		--if v.text:upper()==playerclass or (v.overicon and v.overicon:upper()==playerclass)  then v.colorCode = "|cfffe6100" end 
	end


	WW.Types = {
		{text="Auctioneer",icon="Interface\\Minimap\\Tracking\\Auctioneer"},
		{text="Banker",icon="Interface\\Minimap\\Tracking\\Banker"},
		{text="Barber",iconset=ZGV.IconSets.WorldQuest,iconkey="BARBER"},
		{text="Class Trainers",icon="Interface\\Minimap\\Tracking\\Profession", nofunc = true, hasArrow = true, menuList = Classes},
		{text="Innkeeper",icon="Interface\\Minimap\\Tracking\\Innkeeper"},
		{text="Flightmaster",icon="Interface\\Minimap\\Tracking\\flightmaster"},
		{text="Mailbox",icon="Interface\\Minimap\\Tracking\\Mailbox",func = function() ZGV.WhoWhere:FindMailbox() CloseDropDownForks() end},
		{text="Profession Trainers",icon="Interface\\Minimap\\Tracking\\Profession", nofunc = true, hasArrow = true, menuList = Tradeskills},
		{text="Profession Workshops",icon="Interface\\Minimap\\Tracking\\Profession", nofunc = true, hasArrow = true, menuList = Tradeskills_Workshops},
		{text="Repair",icon="Interface\\Minimap\\Tracking\\Repair"},
		{text="Riding Trainer",icon="Interface\\Minimap\\Tracking\\StableMaster", type="TrainerRiding"},
		{text="Stable Master",icon="Interface\\Minimap\\Tracking\\StableMaster"},
		{text="Transmogrifier",icon="Interface\\Minimap\\Tracking\\Transmogrifier"},
		{text="Vendor",icon="Interface\\Minimap\\Tracking\\Food"},
		--{text="Void Storage",iconset=ZGV.IconSets.WorldQuest,iconkey="VOID"},
		--{text="Main City",icon="Interface\\Minimap\\Tracking\\Banker"},
	}
	
	local SpecialVendors = {
		{text="Any",type="Vendor", icon="Interface\\Minimap\\Tracking\\Food"},
		{text="Arrows",icon=136451},
		{text="Bullets",icon=132383},
		{text="Reagents",icon="interface/minimap/tracking/reagents"},
	}
	if playerclass=="ROGUE" then
		table.insert(SpecialVendors,{text="Poisons",icon=136462})
	end
	
	for i,v in ipairs(SpecialVendors) do
		if not v.nofunc then v.func = v.func or function() WW:FindNPC(v.type or v.text) CloseDropDownForks()  end end
		v.notCheckable = 1
	end

	if ZGV.IsClassic  or ZGV.IsForever then
		WW.Types[14] = 	{text="Vendor",icon="Interface\\Minimap\\Tracking\\Food", nofunc = true, hasArrow = true, menuList = SpecialVendors}
	end

	if ZGV.IsRetail then
		table.remove(WW.Types ,4) -- class trainers
	elseif ZGV.IsClassic or ZGV.IsClassicTBC or ZGV.IsClassicWOTLK then
		table.remove(WW.Types ,13) -- transmog
		table.remove(WW.Types ,11) -- riding
		table.remove(WW.Types ,9) -- prof. workshop
		table.remove(WW.Types ,3) -- barber
	elseif ZGV.IsClassicCATA then
		table.remove(WW.Types ,11) -- riding
		table.remove(WW.Types ,9) -- prof. workshop
		table.remove(WW.Types ,3) -- barber
	elseif ZGV.IsClassicMOP then
		table.remove(WW.Types ,11) -- riding
		table.remove(WW.Types ,9) -- prof. workshop
	elseif ZGV.IsForever then
		table.remove(WW.Types ,11) -- riding
		table.remove(WW.Types ,9) -- prof. workshop
	end

	for i,v in ipairs(WW.Types) do
		if not v.nofunc then v.func = v.func or function() WW:FindNPC(v.type or v.text) CloseDropDownForks()  end end
		v.notCheckable = 1
	end


end

function WW:SetWaypoint(map,x,y,targetident,w,region)
	local name,desc,found = ZGV.Localizers:GetTranslatedNPC(targetident)
	local title = type(targetident)=="string" and targetident or ZGV.L['stepgoal_talk to']:format(name or "(#"..targetident..")")
	if w then
		title = title .. "\n".. (w=="1" and L["whowhere_walks"] or w)
	end

	WW.CurrentWay = ZGV.Pointer:SetWaypoint(map,x,y,{
		title=title,
		type="manual",
		cleartype=not IsControlKeyDown(),
		icon=ZGV.Pointer.Icons.greendotbig,
		onminimap="always",
		overworld=true,
		showonedge=true,
		findpath=true,
		manualnpcid = targetident,
		waypoint_region=region,
	})
	if not found and targetident~="Mailbox" then
		function WW.CurrentWay:UpdateText()
			local name,desc,found = ZGV.Localizers:GetTranslatedNPC(targetident)
			if found then
				WW.CurrentWay.title = ZGV.L['stepgoal_talk to']:format(name)
				ZGV:ShowWaypoints()
				ZGV:CancelTimer(WW.UpdateTextTimer)
			end
		end
		WW.UpdateTextTimer = ZGV:ScheduleRepeatingTimer(function()
			if WW.CurrentWay and WW.CurrentWay.UpdateText then
				WW.CurrentWay:UpdateText()
			else
				ZGV:CancelTimer(WW.UpdateTextTimer)
			end
		end,1)
	end
end

function WW:CreateWorkerFrame()
	if self.WorkerFrame then return end
	self.WorkerFrame=CreateFrame("FRAME")
	self.WorkerFrame:Show()
end

local function CalcStep()
	if WW.thread then
		coroutine.resume(WW.thread)
		if coroutine.status(WW.thread)=="dead" then
			WW.thread=nil
			WW.WorkerFrame:SetScript("OnUpdate",nil)
		end
	end
end


local function CalcThread_Direct()
	local typ,m,x,y=WW.typ,WW.m,WW.x,WW.y
	if not m then x,y,m=LibRover:GetPlayerPosition() end
	local parse=ZGV.NPCData.parseNPC
	local mindist,minid,minm,minf,minx,miny=999999
	local count=0
	for id,data in ZGV.NPCData:iterate(typ) do
		local npc=parse(data)
		if tonumber(npc.m) and npc.m>0 then
			npc.x=npc.x*0.01
			npc.y=npc.y*0.01
			local dist=HBD:GetZoneDistance(m,x,y,npc.m,npc.x,npc.y)

			if dist and dist<mindist then
				mindist=dist
				minid,minm,minx,miny=tonumber(id),npc.m,npc.x,npc.y
				minw,minr = npc.w, npc.region
			end
		end
		count=count+1
		if count%100==0 then coroutine.yield() end
	end
	if minid then
		WW:SetWaypoint(minm,minx,miny,minid,minw,minr)
	end

end

function WW:FindNPC(typ,m,f,x,y)
	WW.debuglast = {typ,m,f,x,y}
	WW.debugtrace = debugstack()
	if (typ=="Innkeeper" or typ=="Flightmaster") or not ZGV.db.profile.pathfinding then
		WW:FindNPC_Direct(typ)
	elseif typ then
		WW:FindNPC_Smart(typ)
	end
end

function WW:FindNPC_Direct(typ,m,f,x,y)
	self.typ,self.m,self.f,self.x,self.y=typ,m,f,x,y

	self.WorkerFrame:SetScript("OnUpdate",CalcStep)
	self.thread = coroutine.create(CalcThread_Direct)
end

function WW:FindNPC_Smart(typ,goal,handler)
	local parse=ZGV.NPCData.parseNPC
	local multiple_ends = {}

	local current_continent = ZGV.GetCurrentMapContinent()

	for id,data in ZGV.NPCData:iterate(typ) do
		local temp = parse(data)
		if (not temp.c or temp.c()) and temp.m>0 then
			if typ=="Vendor" then
				local npc_continent = ZGV.GetMapContinent(temp.m)
				if current_continent==npc_continent then
					table.insert(multiple_ends,{m=temp.m, x=temp.x/100, y=temp.y/100, title=tostring(id), region=temp.r, w=temp.w, noskip=true})
				end
			else
				table.insert(multiple_ends,{m=temp.m, x=temp.x/100, y=temp.y/100, title=tostring(id), region=temp.r, w=temp.w, noskip=true})
			end
		end
	end

	if #multiple_ends==0 then return false end

	-- -1 for map,x,y is so that librover will not return standard destination as a result, and instead will be forced to use multiple_ends, so we get
	-- title/npcid that we can then use to pull npc name later in pointer
	LibRover:QueueFindPath(0,0,0, -1,-1,-1, handler or WW.PathFoundHandler, {goal=goal, direct=not ZGV.db.profile.pathfinding, multiple_ends=multiple_ends })
	--LibRover:UpdateNow()
	ZGV.Pointer:ShowWaiting(1)
end

-- WW:FindTaxi() removed, we have access to Flightmaster entry via leeched data (later in code)

function WW.PathFoundHandler(state,path,ext,reason)
	--if state=="progress" then ZGV.Pointer:ShowWaiting(0) end
	if state~="success" then return end
	local last
	for i,node in ipairs(path) do
		if node.type=="end" then 
			last = node
		end
	end

	if last then
		WW:SetWaypoint(last.m,last.x,last.y,tonumber(last.title) or last.title or "NPC",last.w,last.region)
	end
end

--------------------------------------------------------------------------------

local function CalcMailboxThread()
	local m, x, y =  WW.m, WW.x, WW.y

	local parse=ZGV.MailboxData.parseMailbox
	local mindist,minid,minm,minf,minx,miny,minw,minr=999999
	local count=0
	for id,data in ZGV.MailboxData:iterate() do
		local mailbox=parse(data)
		if (not mailbox.c or mailbox.c()) and mailbox.m>0 then
			mailbox.x=mailbox.x*0.01
			mailbox.y=mailbox.y*0.01
			local dist = HBD:GetZoneDistance(m,x,y,mailbox.m,mailbox.x,mailbox.y)

			if dist and dist<mindist then
				mindist=dist
				minid,minm,minx,miny=tonumber(id),mailbox.m,mailbox.x,mailbox.y
				minw,minr = mailbox.w, mailbox.region
			end
		end
		count=count+1
		if count%100==0 then coroutine.yield() end
	end
	if minid then
		WW:SetWaypoint(minm,minx,miny,"Mailbox",minw,minr)
	end

end



function WW:FindMailbox()
	self.x, self.y, self.m = LibRover:GetPlayerPosition() 
	self.WorkerFrame:SetScript("OnUpdate",CalcStep)
	self.thread = coroutine.create(CalcMailboxThread)
end

-- NPCData_parse.lua
local NPCcached={}
local function parseNPC(s)
	wipe(NPCcached)
	local grab=function(k,v)
		NPCcached[k]=v
	end
	s = s:gsub("[ *]--(.*)","")
	s:gsub("(%w)([^|]+)",grab)
	NPCcached.x=tonumber(NPCcached.x)
	NPCcached.y=tonumber(NPCcached.y)
	NPCcached.m=tonumber(NPCcached.m)
	NPCcached.f=tonumber(NPCcached.f)
		if NPCcached.c then 
			local fun,err,cond_procd = ZGV.Parser.MakeCondition(NPCcached.c,true)
			if not fun then error(err) end
			NPCcached.raw = NPCcached.c
			NPCcached.c = fun
		end
	return NPCcached
end

-- de-hostilize

local badfact
if UnitFactionGroup("player")=="Alliance" then badfact="H"
elseif UnitFactionGroup("player")=="Horde" then badfact="A"
end

function WW:Initialise()
	-- Clean up
	for t,d in pairs(ZGV._NPCData) do ZGV._NPCData[t]=d:gsub("\t","") end

	-- Remove hostiles
	if badfact then for t,d in pairs(ZGV._NPCData) do ZGV._NPCData[t]=d:gsub("%d+=s"..badfact..".-\n","") end end

	-- Remove commented out
	for t,d in pairs(ZGV._NPCData) do ZGV._NPCData[t]=d:gsub("%-%-.-\n","\n") end

	-- localize

	local data=ZGV._NPCData
	assert(data,"NPCData missing")
	ZGV.NPCData={}  setmetatable(ZGV.NPCData,{__index=function(t,k) if type(k)~='number' then return end local d=data:match('\n'..k..'=(.+)') if not d then return end  return parseNPC(d)  end})
	ZGV.NPCData.parseNPC=parseNPC  -- store it, in case someone wants it
	ZGV.NPCData.raw=data
	function ZGV.NPCData:iterate(typ)
		return data[typ]:gmatch("(%d+)=([^\n]+)\n")
	end
	ZGV._NPCData=nil
end

-- Mailboxes --
if badfact then ZGV._MailboxData=ZGV._MailboxData:gsub("s"..badfact..".-\n","") end
local MailboxCached={}
local function parseMailbox(s)
	wipe(MailboxCached)
	local grab=function(k,v)
		MailboxCached[k]=v
	end
	s = s:gsub("[ *]--(.*)","")
	s:gsub("(%w)([^|]+)",grab)
	MailboxCached.x=tonumber(MailboxCached.x)
	MailboxCached.y=tonumber(MailboxCached.y)
	MailboxCached.m=tonumber(MailboxCached.m)
	MailboxCached.f=tonumber(MailboxCached.f)
		if MailboxCached.c then 
			local fun,err,cond_procd = ZGV.Parser.MakeCondition(MailboxCached.c,true)
			if not fun then error(err) end
			MailboxCached.raw = MailboxCached.c
			MailboxCached.c = fun
		end
	return MailboxCached
end

-- iterator

local mailboxData=ZGV._MailboxData
assert(mailboxData,"MailboxData missing")
ZGV.MailboxData={}
setmetatable(ZGV.MailboxData,{__index=function(t,k)
	local d=mailboxData:match('\ns(.+)')
	if not d then return end
	return parseMailbox(d)
end})
ZGV.MailboxData.parseMailbox=parseMailbox  -- store it, in case someone wants it

local matcher = nil
local matcherIndex = 1
function ZGV.MailboxData:iterate()
	if not matcher then
		matcher = mailboxData:gmatch("\n([^\n]-|tM)")
		matcherIndex = 1
	end
	matcherIndex = matcherIndex + 1
	
	return function()
		local match = matcher()
		if match then
			return tostring(matcherIndex), match
		else
			matcher = nil
			matcherIndex = 1
		end
	end
end
ZGV._MailboxData=nil


function WW:LeechLibRover()
	local enemyfac = UnitFactionGroup("player")=="Alliance" and "H" or "A"
	local myfac = UnitFactionGroup("player"):sub(1,1)
	local formatter = "%d=s%s|m%d|x%s|y%s\n"

	local data = ZGV.NPCData and ZGV.NPCData.raw or ZGV._NPCData

	data.Flightmaster = ""
	for ni,node in pairs(LibRover.nodes.taxi) do
		if node.npcid and not node.taxioperator then
			data.Flightmaster = data.Flightmaster .. formatter:format(node.npcid,myfac,node.m,node.x*100,node.y*100)
		end
	end

	data.Innkeeper = ""
	for ni,node in pairs(LibRover.nodes.inn) do
		if node.npcid then
			data.Innkeeper = data.Innkeeper .. formatter:format(node.npcid,myfac,node.m,node.x*100,node.y*100)
		end
	end
end

function WW:InteractionStart(_,interactionID)
	if interactionID==Enum.PlayerInteractionType.MailInfo then	
		WW.ActiveNPC = "Mailbox"
	else
		WW.ActiveNPC = ZGV.GetUnitId("NPC")
	end
end

function WW:InteractionEnd() 
	if not (WW.ActiveNPC and (type(WW.ActiveNPC)=="string" or WW.ActiveNPC>0)) then return end
	local lastNPC = WW.ActiveNPC
	WW.ActiveNPC = nil

	-- called when player closes interaction with npc
	if not LibRover.RESULTS then return end
	local point = LibRover.RESULTS[#LibRover.RESULTS]
	if not (point and point.waypoint and point.waypoint.manualnpcid) then return end
	if point.waypoint.manualnpcid==lastNPC then
		ZGV.Pointer:ClearWaypoints("manual")  
		ZGV:ShowWaypoints()
	end
end

local FavouriteLocations = {}
function WW:SetLocationWaypoint(entry)
	if not entry then return end
	ZGV.Pointer:SetWaypoint(entry.m,entry.x,entry.y,{
		title=entry.name,
		type="manual",
		cleartype=not IsControlKeyDown(),
		icon=ZGV.Pointer.Icons.greendotbig,
		onminimap="always",
		overworld=true,
		showonedge=true,
		findpath=true,
	})
end

function WW:GetFavouriteLocations()
	table.wipe(FavouriteLocations)

	local list = ZGV.db.char.savedLocations
	if not list then return FavouriteLocations end
	
	for _,entry in ipairs(list) do
		table.insert(FavouriteLocations,{
			text=entry.name,
			notCheckable=true, 
			func=function() WW:SetLocationWaypoint(entry) CloseDropDownForks() end
			}
		)
	end

	table.insert(FavouriteLocations,UIDropDownFork_separatorInfo)
	table.insert(FavouriteLocations,{
		text="Record",
		notCheckable=true, 
		iconset=ZGV.IconSets.GuideIconsSmall,
		iconkey="STAR",		
		func=function() WW:RecordLocation() CloseDropDownForks() end,
		--tooltipTitle = "Title", --L["widget_locations_recordtooltip"],
		tooltipTitle = L["widget_locations_recordtooltip"],
		}
	)
	
	return FavouriteLocations		
end

function WW:RecordLocation()
	local x,y,mapID = LibRover:GetPlayerPosition()
	if not mapID then return false end
	local mapName = ZGV.GetMapNameByID(mapID)
	if not mapName then return false end

	ZGV.db.char.savedLocations = ZGV.db.char.savedLocations or {}
	
	for _,loc in ipairs(ZGV.db.char.savedLocations) do
		if loc.m==mapID and loc.x==x and loc.y==y then return end
	end

	table.insert(ZGV.db.char.savedLocations,1,{
		m = mapID,
		mapName = mapName or mapID,
		x = x,
		y = y,
		name = ("%s %.2f, %.2f"):format(mapName,x*100,y*100),
		timestamp = time(),
	})
	
	local widget = ZGV.Widgets.Registered.locations
	
	if widget and widget.frame:IsVisible() then
		widget:Update()
		if widget.popup:IsVisible() then widget:OnPopup() end

		-- New entries are always inserted at index 1, so row 1 is always the one
		-- to rename. Abort any edit already in progress there, then open fresh.
		local row = widget.buttons[1]
		-- unless popup is visible, then we go after its first row
		if widget.popup:IsVisible() then row = widget.popup.scrolltable.rows[1] end
			
		if row and row.editbox and row.entry then
			if row.editbox:IsShown() then FinishRename(widget,row,false) end
			ZGV.ChainCall(row.editbox)
				:SetText(row.entry.name)
				:Show()
				:SetFocus()
				:HighlightText()
		end
	else
		ZGV:Print(L["widget_locations_recorderrename"])
	end
end


tinsert(ZGV.startups,{"WhoWhere",function(self)
	WW:SetupMenuArray()
	WW:CreateWorkerFrame()
	WW:Initialise()

	ZGV:AddMessageHandler("LIBROVER_INITIALISED",WW.LeechLibRover)

	ZGV:AddEventHandler("PLAYER_INTERACTION_MANAGER_FRAME_SHOW",WW.InteractionStart)
	ZGV:AddEventHandler("PLAYER_INTERACTION_MANAGER_FRAME_HIDE",WW.InteractionEnd)
end})
