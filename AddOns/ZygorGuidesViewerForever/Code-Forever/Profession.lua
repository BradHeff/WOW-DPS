-- GLOBAL debug,ZygorGuidesViewer
if debug then
	ZygorGuidesViewer={startups={}}
	ZygorGuidesViewer_L=function() end
	GetLocale=function() return "enUS" end
	tinsert=table.insert
	ERR_LEARN_RECIPE_S = "Learn %s"
	hooksecurefunc=function() end
end

local name,ZGV = ...


ZGV.Professions = {}
local ZGVP = ZGV.Professions

local faction=UnitFactionGroup("player")  --maybe?

ZGVP.tradeskills = {
	[171] = {name="Alchemy",crafting=true},
	[164] = {name="Blacksmithing",crafting=true},
	[333] = {name="Enchanting",crafting=true},
	[202] = {name="Engineering",crafting=true},
	[129] = {name="First Aid",crafting=true},
	[773] = {name="Inscription",crafting=true},
	[755] = {name="Jewelcrafting",crafting=true},
	[165] = {name="Leatherworking",crafting=true},
	[197] = {name="Tailoring",crafting=true},
	[182] = {name="Herbalism"},
	[186] = {name="Mining",crafting=true},
	[393] = {name="Skinning"},
	[794] = {name="Archaeology"},
	[185] = {name="Cooking",crafting=true},
	[356] = {name="Fishing"},
	[762] = {name="Riding"},
}

ZGVP.skillLocale = {
	[129]={deDE="Erste Hilfe",	esES="Primeros auxilios",frFR="Secourisme",	ptBR="Primeiros Socorros",ruRU="Первая помощь",	koKR="응급치료",	zhCN="急救",	zhTW="急救",	esMX="Primeros auxilios"},
	[164]={deDE="Schmiedekunst",	esES="Herrería",	frFR="Forge",		ptBR="Ferraria",	ruRU="Кузнечное дело",	koKR="대장기술",	zhCN="锻造",	zhTW="锻造",	esMX="Herrería"},
	[165]={deDE="Lederverarbeitung",esES="Peletería",	frFR="Travail du cuir",	ptBR="Couraria",	ruRU="Кожевничество",	koKR="가죽 세공",	zhCN="制皮",	zhTW="制皮",	esMX="Peletería"},
	[171]={deDE="Alchemie",		esES="Alquimia",	frFR="Alchimie",	ptBR="Alquimia",	ruRU="Алхимия",		koKR="연금술",	zhCN="炼金术",	zhTW="炼金术",	esMX="Alquimia"},
	[182]={deDE="Kräuterkunde",	esES="Herboristería",	frFR="Herboristerie",	ptBR="Herborismo",	ruRU="Травничество",	koKR="약초 채집",	zhCN="草药学",	zhTW="草药学",	esMX="Herboristería"},
	[185]={deDE="Kochkunst",	esES="Cocina",		frFR="Cuisine",		ptBR="Culinária",	ruRU="Кулинария",	koKR="요리",	zhCN="烹饪",	zhTW="烹饪",	esMX="Cocina"},
	[186]={deDE="Bergbau",		esES="Minería",		frFR="Minage",		ptBR="Mineração",	ruRU="Горное дело",	koKR="채광",	zhCN="采矿",	zhTW="采矿",	esMX="Minería"},
	[197]={deDE="Schneiderei",	esES="Sastrería",	frFR="Couture",		ptBR="Alfaiataria",	ruRU="Портняжное дело",	koKR="재봉술",	zhCN="裁缝",	zhTW="裁缝",	esMX="裁缝"},
	[202]={deDE="Ingenieurskunst",	esES="Ingeniería",	frFR="Ingénierie",	ptBR="Engenharia",	ruRU="Инженерное дело",	koKR="기계공학",	zhCN="工程学",	zhTW="工程学",	esMX="Ingeniería"},
	[333]={deDE="Verzauberkunst",	esES="Encantamiento",	frFR="Enchantement",	ptBR="Encantamento",	ruRU="Наложение чар",	koKR="마법부여",	zhCN="附魔",	zhTW="附魔",	esMX="Encantamiento"},
	[356]={deDE="Angeln",		esES="Pesca",		frFR="Pêche",		ptBR="Pesca",		ruRU="Рыбная ловля",	koKR="낚시",	zhCN="钓鱼",	zhTW="钓鱼",	esMX="Pesca"},
	[393]={deDE="Kürschnerei",	esES="Desuello",	frFR="Dépeçage",	ptBR="Esfolamento",	ruRU="Снятие шкур",	koKR="무두질",	zhCN="剥皮",	zhTW="剥皮",	esMX="Desuello"},
	[762]={deDE="Reiten",		esES="Equitación",	frFR="Monte",		ptBR="Montaria",	ruRU="Верховая езда",	koKR="타기",	zhCN="骑术",	zhTW="骑术",	esMX="Equitación"},
	[633]={deDE="Schlossknacken",	esES="Ganzúa",		frFR="Crochetage",	ptBR="Arrombamento",	ruRU="Вскрытие замков",	koKR="자물쇠 따기",zhCN="开锁",	zhTW="开锁",	esMX="Ganzúa"},
	[794]={deDE="Archäologie",	esES="Arqueología",	frFR="Archéologie",	ptBR="Arqueologia",	ruRU="Археология",	koKR="고고학",	zhCN="考古学",	zhTW="考古學",	esMX="Arqueología"},
} -- GETS TRIMMED.
for id,data in pairs(ZGVP.skillLocale) do ZGVP.skillLocale[id]=data[GetLocale()] end

ZGV.Professions.LocaleSkills={}
setmetatable(ZGV.Professions.LocaleSkills,{__index=function(t,skill) return ZGV.Professions.skillLocale[ZGVP.tradeskillsIdByName[skill] or 0] or skill end})
ZGV.Professions.LocaleSkillsR={}
setmetatable(ZGV.Professions.LocaleSkillsR,{__index=function(t,q) return q end})

-- Map ids by english names
ZGVP.tradeskillsIdByName = {}
for id,data in pairs(ZGVP.tradeskills) do 
	ZGVP.tradeskillsIdByName[data.name] = id 
end

function ZGV:CacheSkills()
	if ZGVP.CS_Timer then ZGV:CancelTimer(ZGVP.CS_Timer) end
	ZGVP.CS_Timer = ZGV:ScheduleTimer(function() 
		ZGV:CacheSkills_Queued()
	end, 1)
end

local cacheskill_profs = {}
local cacheskill_lines = {}
local cacheskill_core = {}
function ZGV:CacheSkills_Queued()
	local current_time = debugprofilestop()
	if (current_time - (ZGV.last_cached_skills or 0)) < 1000 then return end

	ZGV.last_cached_skills = current_time	

	-- reset goldguide crafting skill knowledge
	local Goldguide = ZGV.Goldguide
	if Goldguide then Goldguide.knows_crafting = false end

	-- update tradeskill knowledge
	table.wipe(cacheskill_lines)
	table.wipe(cacheskill_profs)
	table.wipe(cacheskill_core)
	cacheskill_profs.prof1, cacheskill_profs.prof2, cacheskill_profs.arch, cacheskill_profs.fish, cacheskill_profs.cook, cacheskill_profs.firstAid = GetProfessions()

	for i,prof in pairs(cacheskill_profs) do
		-- core skills
		local name, icon, rank, maxRank, numSpells, spelloffset, skillline, rankModifier, specializationIndex, specializationOffset, skillLineName = GetProfessionInfo(prof)

		if Goldguide and ZGVP.tradeskills[skillline] and ZGVP.tradeskills[skillline].crafting then Goldguide.knows_crafting = true end-- this is a crafting skill, mark for gold guide that user can craft something

		if ZGVP.tradeskills[skillline] then
			local name = ZGVP.tradeskills[skillline] and ZGVP.tradeskills[skillline].name
			ZGVP.SkillsKnown[name] = ZGVP.SkillsKnown[name] or {}
			local pro = ZGVP.SkillsKnown[name]
			pro.level = rank
			pro.max = maxRank
			pro.active = true
			pro.skillID = skillline
			pro.name = name

			cacheskill_lines[skillline] = true
			cacheskill_core[skillline] = true
		end
	end

	-- 1) If user no longer has some profession, remove its subskills from known 
	for lineid,linedata in pairs(ZGV.db.char.RecipesKnown) do
		if not cacheskill_core[lineid] then
			ZGV.db.char.RecipesKnown[lineid]=nil
		end
	end
	for name,linedata in pairs(ZGVP.SkillsKnown) do
		if not linedata.placeholder and not cacheskill_core[linedata.parentskillID or linedata.skillID] then
			ZGVP.SkillsKnown[name] = nil
		end
	end
	--self:CacheRecipes(profs)  -- or try to, anyway. --Do Cooking masteries too
end

function ZGV:CacheRecipes(profs)
	local data = ProfessionsFrame and ProfessionsFrame:GetProfessionInfo()
	local skill = data and data.professionID
	if not skill then return end

	if ZGVP.CR_Timer then return end -- we already have scheduled refresh, wait for it
	if ZGVP.LastRecipeCheckLine~=skill then ZGV:CacheRecipes_Queued(profs) return end -- we changed skill line, grab recipes now
	if ZGVP.LastRecipeCheckTime and (debugprofilestop()-ZGVP.LastRecipeCheckTime)>1000 then ZGV:CacheRecipes_Queued(profs) return end -- over 1 second snce last refresh, grab now as we are not spamming
	ZGVP.CR_Timer = ZGV:ScheduleTimer(function() ZGV:CacheRecipes_Queued(profs) end, 1)
end

function ZGV:CacheRecipes_Queued(profs)
	if ZGVP.CR_Timer then ZGV:CancelTimer(ZGVP.CR_Timer) ZGVP.CR_Timer=nil end

	if not C_TradeSkillUI.IsTradeSkillReady() then return end -- prevents missing reagents in recipes
	if C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsTradeSkillLinked() then return end

	local data = ProfessionsFrame and ProfessionsFrame:GetProfessionInfo()
	local skill = data and data.professionID
	if not skill then return end

	self.db.char.RecipesKnown=self.db.char.RecipesKnown or {}
	self.db.char.RecipesKnown[skill]=self.db.char.RecipesKnown[skill] or {}

	local recipes = self.db.char.RecipesKnown[skill]

	local all_recipes = C_TradeSkillUI.GetAllRecipeIDs()

	table.wipe(recipes)

	local difficulties = {
		[0] = "optimal",
		[1] = "medium",
		[2] = "easy",
		[3] = "trivial",
	}

	for _,recipeid in pairs(all_recipes) do
		local api_recipe = C_TradeSkillUI.GetRecipeInfo(recipeid)
		local api_schematic = C_TradeSkillUI.GetRecipeSchematic(recipeid,false)
		local recipe = {
			nummade = {api_schematic.quantityMin,api_schematic.quantityMax},
			spell = recipeid,
			learned = api_recipe.learned,
			skill = skill,
			numSkillUps = api_recipe.numSkillUps,
			difficulty = difficulties[api_recipe.relativeDifficulty],
			numAvailable = C_TradeSkillUI.GetCraftableCount(recipeid),
			source = C_TradeSkillUI.GetRecipeSourceText(recipeid),
			name = api_recipe.name
			}
		local productlink = C_TradeSkillUI.GetRecipeItemLink(recipeid)
		recipe.producttype,recipe.productid = productlink:match("|H(%w+):(%d+)")
		recipe.productid = tonumber(recipe.productid)
		recipe.variants = C_TradeSkillUI.GetRecipeQualityItemIDs(recipeid)

		
		local reagents,currencies={},{}
		for _,reagentInfo in ipairs(api_schematic.reagentSlotSchematics) do
			local count = reagentInfo.quantityRequired
			local itemid = reagentInfo.reagents[1].itemID
			local currencyID = reagentInfo.reagents[1].currencyID
			
			if itemid then reagents[itemid]=count end
			if currencyID then currencies[currencyID]=count end
		end
		recipe.reagents = reagents
		recipe.currencies = currencies

		recipes[recipeid]=recipe
	end

	ZGVP.LastRecipeCheckLine = skill
	ZGVP.LastRecipeCheckTime = debugprofilestop()
end

function ZGVP:GetSkill(name)
	if not name then 
		ZGV.db.char.SkillsKnown[""].parentname="Unknown skill"
		return ZGV.db.char.SkillsKnown[""] 
	end

	-- handle aliases : legion_alchemy => Legion Alchemy
	name = name:gsub("_"," "):gsub("(%a)([%w]*)", function(first,rest) return first:upper()..rest:lower() end)


	if ZGV.db.profile.fakeskills[name] then
		return ZGV.db.profile.fakeskills[name] -- faked value
	elseif ZGV.db.char.SkillsKnown[name] then
		return ZGV.db.char.SkillsKnown[name]
	else
		local parent = name
		if name:find(" ") then parent = name:gsub("([%w]*) ([%w]*)","%2") end
		ZGV.db.char.SkillsKnown[""].parentname=parent
		return ZGV.db.char.SkillsKnown[""] -- proper value or empty placeholer
	end
end

function ZGVP:GetSkillDataByName(name)
	for id,data in pairs(ZGVP.tradeskills) do 
		for sid,sdata in pairs(data.subs) do
			if sdata.name==name then return sdata end
		end
	end
end



function ZGV:Profession_NEW_RECIPE_LEARNED(event,spell)
	for skill,skilltable in pairs(ZGV.db.char.RecipesKnown) do
		if skilltable[spell] then
			skilltable[spell].learned=true
		end
	end
end

local ERR_LEARN_RECIPE_S_fmt = ERR_LEARN_RECIPE_S:gsub("%.","%%."):gsub("%%s","(.+)")
--local TRADESKILL_LOG_FIRSTPERSON_fmt = TRADESKILL_LOG_FIRSTPERSON:gsub("%%s","(.-)")

function ZGV:Profession_CHAT_MSG_SYSTEM(event,text)
	if ZGV.IsSecret(text) then return end
	local _,_,item = text:find(ERR_LEARN_RECIPE_S_fmt)
	if item then
		self.recentlyLearnedRecipes[item]=true
	end
end





function ZGV:PerformTradeSkillGoal(goal)
	if not goal then return end
	if not goal.spellid then return end

	if goal.count then
		-- total based
		self:PerformTradeSkill(goal.spellid,goal.count-C_Item.GetItemCount(goal.targetid))
	elseif goal.skillnum and goal.skillnum>0 then
		-- skillup-based
		self:PerformTradeSkill(goal.spellid,goal.skillnum)
	else
		-- no count, completable by quest, do single craft
		self:PerformTradeSkill(goal.spellid,1)
	end
end

function ZGV:PerformTradeSkill(id,count)
	if not count then count=1 end
	if count<=0 then return end
	local rec = ZGVP:GetRecipe(id)
	if not rec then return end
	if not (ProfessionsFrame and ProfessionsFrame:IsVisible()) then
		C_TradeSkillUI.OpenTradeSkill(rec.skill) 
		return
	end

	C_TradeSkillUI.OpenTradeSkill(rec.skill)
	if ProfessionsFrame then 
		local api_recipe = C_TradeSkillUI.GetRecipeInfo(id)
		if not api_recipe then return end
		ProfessionsFrame.CraftingPage:SelectRecipe(api_recipe) 
	end

	local transaction = (ProfessionsFrame and ProfessionsFrame.CraftingPage and ProfessionsFrame.CraftingPage.SchematicForm) and ProfessionsFrame.CraftingPage.SchematicForm:GetTransaction()
	local craftingReagentTbl = transaction and transaction:CreateCraftingReagentInfoTbl()

	-- dragonflight crafting with quality reagents and more than one item at once
	-- we need to craft one by one, and update craftingReagentTbl as it changes
	if craftingReagentTbl then count = 1 end
	
	C_TradeSkillUI.CraftRecipe(id, count, craftingReagentTbl)
end

function ZGVP:GetRecipe(spellid)
	local RK = ZGV.db.char.RecipesKnown
	if not RK or not next(RK) then return false,"no data" end
	for skillid,recipes in pairs(RK) do
		if recipes[spellid] then return recipes[spellid] end
	end
	return false,"not found"
end

function ZGVP:KnowsRecipe(spellid)
	local ret,error = ZGVP:GetRecipe(spellid)
	if ret then
		return ret.learned,true
	else
		return false,false
	end
end


local pattern = "Skill (%d+) increased from (%d+) to (%d+)"
local function UpdateSkillConsole(_,_,msg)
	local id,from,to = msg:match(pattern)

	if id and to then
		id=tonumber(id)
		to=tonumber(to)

		for name,skill in pairs(ZGV.db.char.SkillsKnown) do
			if skill.skillID==id then
				skill.level = to
				return
			end
		end

		if to>0 then
			if ZGVP.tradeskills[id] then
				local name = ZGVP.tradeskills[id] and ZGVP.tradeskills[id].name
				ZGVP.SkillsKnown[name] = ZGVP.SkillsKnown[name] or {}
				local pro = ZGVP.SkillsKnown[name]
				pro.level = to
				pro.max = pro.max or 300
				pro.active = true
				pro.skillID = id
				pro.name = name
			end
		else
			local name = ZGVP.tradeskills[id] and ZGVP.tradeskills[id].name
			if name then
				ZGVP.SkillsKnown[name] = nil
			end
		end
	end
end

function ZGVP:HasProfessionSlot()
	local p1, p2, arch, fish, cook, first = GetProfessions()
	return not (p1 and p2)
end

function ZGVP:HasProfessionUnscanned(name)
	cacheskill_profs.prof1, cacheskill_profs.prof2, cacheskill_profs.arch, cacheskill_profs.fish, cacheskill_profs.cook, cacheskill_profs.firstAid = GetProfessions()

	for i,prof in pairs(cacheskill_profs) do
		local _, _, _, _, _, _, skillline = GetProfessionInfo(prof)
		if ZGVP.tradeskills[skillline] and ZGVP.tradeskills[skillline].name==name then 
			if ZGVP.SkillsKnown[name] and ZGV.db.char.RecipesKnown[skillline] then
				-- we know everything, skill is NOT unscanned
				return false
			else
				-- player has it, but we do not have both data sets
				return true
	end
		end
	end
	return false
end


function ZGVP:KnowsProfessionRecipes(name)
	cacheskill_profs.prof1, cacheskill_profs.prof2, cacheskill_profs.arch, cacheskill_profs.fish, cacheskill_profs.cook, cacheskill_profs.firstAid = GetProfessions()

	for i,prof in pairs(cacheskill_profs) do
		local _, _, _, _, _, _, skillline = GetProfessionInfo(prof)
		if ZGVP.tradeskills[skillline] and ZGVP.tradeskills[skillline].name==name then 
			if ZGV.db.char.RecipesKnown[skillline] then return true end
		end
	end
	return false
end

function ZGVP:GoalRecipe(skill,spellid,loud)
	if not (ProfessionsFrame and ProfessionsFrame:IsVisible()) then return nil,"closed" end
	if not skill or not spellid then return nil,"no_data" end
	local skilldata = ZGV.Professions:GetSkill(skill)
	if not skilldata then return nil,"no_prof" end

	local professionInfo = ProfessionsFrame:GetProfessionInfo()
	if skilldata.parentskillID~=professionInfo.parentProfessionID then return nil,"closed" end -- open, but on wrong skill

	local skillid = skilldata.parentskillID or skilldata.skillID
	if not ZGV.db.char.RecipesKnown[skillid] then return nil,"no_prof" end
	local recipe = ZGV.db.char.RecipesKnown[skillid][spellid]
	if not recipe then return nil,"unknown" end
	if not recipe.learned then return nil,"unknown" end
	if not recipe.difficulty or not recipe.numAvailable then return nil,"unknown" end
	return recipe
end


tinsert(ZGV.startups,{"Professions setup",function(self)
	--self:AddEventHandler("PLAYER_ENTERING_WORLD","CacheSkills") don't cache at start, load saved instead
	self:AddEventHandler("SKILL_LINES_CHANGED","CacheSkills")
	--self:AddEventHandler("CHAT_MSG_SKILL","CacheSkills")
	self:AddEventHandler("CONSOLE_MESSAGE",UpdateSkillConsole) -- replaces CHAT_MSG_SKILL for our needs
	self:AddEventHandler("TRADE_SKILL_SHOW","CacheSkills")
	self:AddEventHandler("TRADE_SKILL_DATA_SOURCE_CHANGED","CacheSkills")

	EventRegistry:RegisterCallback("ProfessionsFrame.Show",function()
		ZGV:CacheSkills()
	end)

	--[[ bfa alpha change
	self:AddEventHandler("TRADE_SKILL_UPDATE","CacheSkills")
	--]]
	self:AddEventHandler("CHAT_MSG_SYSTEM","Profession_CHAT_MSG_SYSTEM")
	self:AddEventHandler("NEW_RECIPE_LEARNED","Profession_NEW_RECIPE_LEARNED")

	self:AddEventHandler("TRADE_SKILL_LIST_UPDATE","CacheRecipes")

	--self:AddEventHandler("CHAT_MSG_COMBAT_FACTION_CHANGE","CHAT_MSG_COMBAT_FACTION_CHANGE_Faction")

	if not ZGV.db.char.SkillsKnown then
		ZGV.db.char.SkillsKnown = {}
		ZGV:CacheSkills()
	end

	ZGV.db.char.SkillsKnown[""] = {active=false,level=0,max=0,placeholder=true}

	ZGVP.SkillsKnown = ZGV.db.char.SkillsKnown
end})
