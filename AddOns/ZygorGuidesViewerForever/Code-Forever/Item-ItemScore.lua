local ItemScore = ZGV.ItemScore

function ItemScore:GetEquipmentSkills()
	table.wipe(ItemScore.Skills)
	table.wipe(ItemScore.ItemCache) -- since items that were rejected due to skill may be valid now

	for i=1, C_SkillInfo.GetNumSkillLines() do
		local skillInfo = C_SkillInfo.GetSkillLineInfo(i);
		local skillTag = ItemScore.SkillNamesByID[skillInfo.skillID]
		if skillTag then
			ItemScore.Skills[skillTag] = skillInfo.rank
		end
	end
end


function ItemScore:SetDualWield()
	self.playerDualWield, self.playerDualTwohanders = ItemScore:CanPlayerDualWield()
end

-- checks if given character can dualwield
-- params:
--	name - string optional
--	spec - int optional
-- returns:
--	dualwield - boolean
--	titansgrip - boolean
function ItemScore:CanPlayerDualWield(name,spec)
	local playerclass = self.playerclass
	local playerspec = self.playerspec
	local playerlevel = self.playerlevel
	if name then
		local ruleset = self.ActiveRuleSets[name][spec]
		playerclass = ruleset.class
		playerlevel = ruleset.characterlevel
		playerspec = spec
	end
	if playerlevel>=10 then
		if playerclass=="DEATHKNIGHT" and playerspec==2 then-- Frost DK
			return true,false
		elseif playerclass=="ROGUE" then -- Rogue
			return true,false
		elseif playerclass=="DEMONHUNTER" then -- Demon Hunter
			return true,false
		elseif playerclass=="WARRIOR" and playerspec==2 and playerlevel>=14 then -- Fury Warriors
			return true,true
		elseif playerclass=="MONK" and playerspec==3 then -- Windwalker Monks
			return true,false
		elseif playerclass=="SHAMAN" and playerspec==2 then -- Enhancement Shaman
			return true,false
		elseif playerclass=="DRUID" and (playerspec==2 or playerspec==3) then -- Feral/Guardian Druid
			return true,false
		end
	end
	return false,false
end


-- checks what slots can this item be equipped to. automatically called as part of GetItemDetails, but may be called as standalone
-- params:
--	item - array - item object
-- returns:
--	first slot - int/false - main slot for this item
--	second slot - int/false - optional second slot for the item (offhand, rings, trinkets)
--	twohander - bool - is item twohander
local function get_slots_by_type(type)
	if type=="INVTYPE_WEAPON" then return INVSLOT_MAINHAND,INVSLOT_OFFHAND end
	if type=="INVTYPE_2HWEAPON" then return INVSLOT_MAINHAND,INVSLOT_OFFHAND end
	if type=="INVTYPE_FINGER" then return INVSLOT_FINGER1,INVSLOT_FINGER2 end
	if type=="INVTYPE_TRINKET" then return false,false end
	if type=="INVTYPE_RANGED" then return INVSLOT_RANGED,false end
	if type=="INVTYPE_RANGEDRIGHT" then return INVSLOT_RANGED,false end
	if type=="INVTYPE_THROWN" then return INVSLOT_RANGED,false end
	return ItemScore.TypeToSlot[type], false
end

function ItemScore:GetValidSlots(item,name,spec)
	if not item then return end

	local playerDualWield = self.playerDualWield
	local playerDualTwohanders = self.playerDualTwohanders
	if name and spec then
		playerDualWield, playerDualTwohanders = ItemScore:CanPlayerDualWield(name,spec)
	end

	
	local s1, s2 = get_slots_by_type(item.type)

	if item.type=="INVTYPE_WEAPON" and playerDualWield then -- dual wield, 1 handed weapons are valid in offhand
		return s1, s2, false
	end
	if item.type=="INVTYPE_2HWEAPON" then -- two handed items go into main hand slot
		return s1, false, true
	end
	if item.type=="INVTYPE_WEAPON" and not playerDualWield then -- no dual wield, 1 handed weapons are valid only in mainhand
		return s1, false, false
	end

	if item.type=="INVTYPE_WEAPONOFFHAND" and not playerDualWield then -- no dual wield, offhand weapons are no good
		return false, false, false
	end

	-- rest is valid in proper slots
	return s1, s2, false
end

function ItemScore:SetData()
	ItemScore.Builds={}
	for class,classData in pairs(ItemScore.rules) do
		ItemScore.Builds[class] = {}
		for buildid,builddata in pairs(classData) do
			ItemScore.Builds[class][buildid] = builddata.name
		end
	end

	-- Build simpler defaults table for use in options
	ItemScore.Defaults = {}
	for class,specs in pairs(ItemScore.rules) do
		ZGV.ItemScore.Defaults[class] = {}
		for spec,data in pairs(specs) do
			ZGV.ItemScore.Defaults[class][spec] = {}

			for name,v in pairs(data.stats) do
				table.insert(ZGV.ItemScore.Defaults[class][spec],{name=name,weight=v})
			end
			sort(ZGV.ItemScore.Defaults[class][spec],function(a,b) return a.name<b.name end)
		end
	end 
end

ItemScore:SetData()