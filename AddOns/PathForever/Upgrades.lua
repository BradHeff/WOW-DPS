-- PathForever: the upgrade finder (PF.Upgrades).
--
-- Looks through the gear PathForever knows about (boss and trash loot and quest rewards in
-- Data.lua, class quest rewards in JourneyData.lua) for pieces that beat what the character
-- wears. Which items exist and where they drop is static; how good an item is comes from
-- the client at run time (item level, level to wear, stats), because Forever's own items
-- are in no export. Item data arrives late, so an item the client has not sent yet is asked
-- for once and counted as "reading", and the page redraws when GET_ITEM_INFO_RECEIVED says
-- it came (Core.lua).
--
-- An item is offered when
--   * the character can wear it: the class's armor type for the level (plate at 40, mail at
--     40 for hunters and shamans), the class's weapons, shields and ranged weapons, and the
--     level to wear it is at most 3 above the character's;
--   * its stats suit the spec: a physical spec skips gear that is only Intellect, a caster
--     skips gear that is only Strength or Agility (stamina-only gear suits everyone);
--   * and it is better than what is worn in that slot: a higher item level without being
--     worse on stats, or a lower one (by up to 10) with clearly more stats ("More stats");
--     an empty slot takes anything usable.
-- The spec is read from the talent points (PF:GetSpec) and can be set by hand on the page,
-- saved per character; with neither, every spec of the class is tried and the best fit
-- counts. The stat weights are a rule of thumb, not a guide's numbers.
--
-- Plain data and calls only, nothing protected. Every client call goes through pcall.

local PF = PathForever
local Upgrades = {}
PF.Upgrades = Upgrades

local LEVEL_LEEWAY = 3  -- items asked for up to this many levels above the character
local STATS_MARGIN = 1.25 -- "More stats": this much better ...
local STATS_MIN_GAIN = 3  -- ... and at least this many points ahead
local ILVL_FLOOR = 10     -- ... on an item at most this far below in item level
local PER_SLOT = 4

-- ---------- what a class can wear and wield ----------
-- weapon subclass ids (the item's subClassID): 0 axe, 1 2h axe, 2 bow, 3 gun, 4 mace, 5 2h mace,
-- 6 polearm, 7 sword, 8 2h sword, 10 staff, 13 fist weapon, 15 dagger, 16 thrown, 18 crossbow, 19 wand
local function Set(list) local t = {} for _, v in ipairs(list) do t[v] = true end return t end
local WEAPONS = {
    WARRIOR = Set({ 0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 13, 15, 16, 18 }),
    PALADIN = Set({ 0, 1, 4, 5, 6, 7, 8 }),
    HUNTER = Set({ 0, 1, 2, 3, 6, 7, 8, 10, 13, 15, 16, 18 }),
    ROGUE = Set({ 2, 3, 4, 7, 13, 15, 16, 18 }),
    PRIEST = Set({ 4, 10, 15, 19 }),
    SHAMAN = Set({ 0, 1, 4, 5, 10, 13, 15 }),
    MAGE = Set({ 7, 10, 15, 19 }),
    WARLOCK = Set({ 7, 10, 15, 19 }),
    DRUID = Set({ 4, 5, 6, 10, 13, 15 }),
}
local SHIELDS = Set({ "WARRIOR", "PALADIN", "SHAMAN" })
local RELICS = { DRUID = "Idol", SHAMAN = "Totem", PALADIN = "Libram" }

local function BestArmor(class, level)
    if class == "WARRIOR" or class == "PALADIN" then return level >= 40 and "Plate" or "Mail" end
    if class == "HUNTER" or class == "SHAMAN" then return level >= 40 and "Mail" or "Leather" end
    if class == "ROGUE" or class == "DRUID" then return "Leather" end
    return "Cloth"
end

-- the weapon subclass of a Data.lua slot text ("One-Hand, Sword", "Two-Hand, Axe", "Ranged, Bow")
local WEAPON_NAMES = {
    Axe = { 0, 1 }, Mace = { 4, 5 }, Sword = { 7, 8 }, Polearm = { 6, 6 }, Staff = { 10, 10 }, ["Fist Weapon"] = { 13, 13 },
    Dagger = { 15, 15 }, Bow = { 2, 2 }, Gun = { 3, 3 }, Crossbow = { 18, 18 }, Wand = { 19, 19 }, Thrown = { 16, 16 },
}

-- ---------- places (slots) ----------
-- place -> inventory slot ids and the name of its group on the page
local PLACES = {
    head = { { 1 }, "Head", 1 }, neck = { { 2 }, "Neck", 2 }, shoulder = { { 3 }, "Shoulders", 3 },
    back = { { 15 }, "Back", 4 }, chest = { { 5 }, "Chest", 5 }, wrist = { { 9 }, "Wrists", 6 },
    hands = { { 10 }, "Hands", 7 }, waist = { { 6 }, "Waist", 8 }, legs = { { 7 }, "Legs", 9 },
    feet = { { 8 }, "Feet", 10 }, finger = { { 11, 12 }, "Rings", 11 }, trinket = { { 13, 14 }, "Trinkets", 12 },
    hand = { { 16 }, "Weapons", 13 }, two = { { 16 }, "Weapons", 13 }, off = { { 17 }, "Off hand", 14 },
    ranged = { { 18 }, "Ranged", 15 },
}
local ARMOR_PLACES = { head = true, shoulder = true, chest = true, wrist = true, hands = true, waist = true, legs = true, feet = true }

local SLOT_WORDS = {
    Head = "head", Neck = "neck", Shoulder = "shoulder", Back = "back", Chest = "chest", Wrist = "wrist",
    Hands = "hands", Waist = "waist", Legs = "legs", Feet = "feet", Finger = "finger", Trinket = "trinket",
    ["One-Hand"] = "hand", ["Main Hand"] = "hand", ["Two-Hand"] = "two", ["Off Hand"] = "off",
    ["Held In Off-hand"] = "off", Ranged = "ranged", Thrown = "ranged", Relic = "ranged",
}

local EQUIP_LOC = {
    INVTYPE_HEAD = "head", INVTYPE_NECK = "neck", INVTYPE_SHOULDER = "shoulder", INVTYPE_CLOAK = "back",
    INVTYPE_CHEST = "chest", INVTYPE_ROBE = "chest", INVTYPE_WRIST = "wrist", INVTYPE_HAND = "hands",
    INVTYPE_WAIST = "waist", INVTYPE_LEGS = "legs", INVTYPE_FEET = "feet", INVTYPE_FINGER = "finger",
    INVTYPE_TRINKET = "trinket", INVTYPE_WEAPON = "hand", INVTYPE_WEAPONMAINHAND = "hand",
    INVTYPE_2HWEAPON = "two", INVTYPE_WEAPONOFFHAND = "off", INVTYPE_SHIELD = "off", INVTYPE_HOLDABLE = "off",
    INVTYPE_RANGED = "ranged", INVTYPE_RANGEDRIGHT = "ranged", INVTYPE_THROWN = "ranged", INVTYPE_RELIC = "ranged",
}

-- ---------- what a spec wants ----------
-- role "melee" counts Strength/Agility (with these weights) and attack power; "caster" counts
-- Intellect, spirit and spell power. Stamina counts for everyone.
local STR, AGI, INT = "ITEM_MOD_STRENGTH_SHORT", "ITEM_MOD_AGILITY_SHORT", "ITEM_MOD_INTELLECT_SHORT"
local function Melee(s, a) return { role = "melee", w = { [STR] = s, [AGI] = a } } end
local CASTER = { role = "caster", w = { [INT] = 1 } }
local SPECS = {
    WARRIOR = { Melee(1, 0.5), Melee(1, 0.5), Melee(1, 0.5) },
    PALADIN = { CASTER, Melee(1, 0.4), Melee(1, 0.4) },
    HUNTER = { Melee(0.3, 1), Melee(0.3, 1), Melee(0.3, 1) },
    ROGUE = { Melee(0.3, 1), Melee(0.3, 1), Melee(0.3, 1) },
    PRIEST = { CASTER, CASTER, CASTER },
    SHAMAN = { CASTER, Melee(1, 1), CASTER },
    MAGE = { CASTER, CASTER, CASTER },
    WARLOCK = { CASTER, CASTER, CASTER },
    DRUID = { CASTER, Melee(1, 1), CASTER },
}

local function Stat(stats, key) return tonumber(stats[key]) or 0 end

-- Whether a spec can use gear with these stats.
local function Suits(spec, stats)
    local physical = Stat(stats, STR) + Stat(stats, AGI)
    local intellect = Stat(stats, INT)
    if spec.role == "melee" then return not (intellect > 0 and physical == 0) end
    return not (physical > 0 and intellect == 0)
end

-- How good these stats are for a spec, a rule-of-thumb number.
local function Score(spec, stats)
    local s = 0
    for key, w in pairs(spec.w) do s = s + w * Stat(stats, key) end
    s = s + 0.5 * Stat(stats, "ITEM_MOD_STAMINA_SHORT")
    if spec.role == "melee" then
        s = s + 0.5 * Stat(stats, "ITEM_MOD_ATTACK_POWER_SHORT")
    else
        s = s + 0.3 * Stat(stats, "ITEM_MOD_SPIRIT_SHORT") + 0.7 * Stat(stats, "ITEM_MOD_SPELL_POWER_SHORT")
    end
    s = s + 3 * Stat(stats, "ITEM_MOD_DAMAGE_PER_SECOND_SHORT") + 0.05 * Stat(stats, "RESISTANCE0_NAME")
    return s
end

-- ---------- the chosen spec ----------
local function GUID() return UnitGUID and UnitGUID("player") end

-- The tree number the player picked by hand on the page, or nil for automatic.
function Upgrades:GetChoice()
    local t = PathForeverDB and PathForeverDB.upgradeSpec
    local g = GUID()
    local v = type(t) == "table" and g and t[g]
    if type(v) == "number" and v >= 1 and v <= 3 then return v end
end

function Upgrades:SetChoice(index)
    local g = GUID()
    if not (PathForeverDB and g) then return end
    if type(PathForeverDB.upgradeSpec) ~= "table" then PathForeverDB.upgradeSpec = {} end
    PathForeverDB.upgradeSpec[g] = index
end

-- The next choice in the picker: automatic, then each tree.
function Upgrades:CycleChoice()
    local cur = self:GetChoice()
    local nxt
    if cur == nil then nxt = 1 elseif cur >= 3 then nxt = nil else nxt = cur + 1 end
    self:SetChoice(nxt)
    return nxt
end

-- { class, specs = { the specs to try }, label, hand = true when picked by hand }
function Upgrades:ResolveSpec()
    local _, class = UnitClass("player")
    local all = SPECS[class] or { CASTER }
    local trees = PF.SPEC_TREES and PF.SPEC_TREES[class] or {}
    local choice = self:GetChoice()
    if choice and all[choice] then
        return { class = class, specs = { all[choice] }, index = choice, label = trees[choice] or ("Tree " .. choice), hand = true }
    end
    local ok, auto = pcall(PF.GetSpec, PF)
    local index = ok and auto and auto.key and tonumber(tostring(auto.key):match(":(%d+)$"))
    if index and all[index] then
        return { class = class, specs = { all[index] }, index = index, label = auto.name or trees[index] or ("Tree " .. index), auto = true }
    end
    return { class = class, specs = all, label = "any " .. ((class or ""):lower()) .. " spec", fallback = true }
end

-- The icon and name of talent tree `i` for the spec picker (the classic call returns name, icon,
-- points; the retail one id, name, description, icon, points).
function Upgrades:SpecIcon(i)
    local _, class = UnitClass("player")
    local name = PF.SPEC_TREES and PF.SPEC_TREES[class] and PF.SPEC_TREES[class][i]
    local icon
    if type(GetTalentTabInfo) == "function" then
        local ok, a, b, _, d = pcall(GetTalentTabInfo, i)
        if ok then
            if type(a) == "string" then name, icon = a, b elseif type(b) == "string" then name, icon = b, d end
        end
    end
    if not icon and type(GetSpecializationInfo) == "function" then
        local ok, _, n, _, ic = pcall(GetSpecializationInfo, i)
        if ok then name, icon = n or name, ic end
    end
    return name or ("Tree " .. i), icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- ---------- the candidates (static) ----------
local candidates, byID

local function Descriptor(slotText)
    local place, sub = (slotText or ""):match("^([^,]+),?%s*(.*)$")
    place = SLOT_WORDS[place or ""]
    if not place then return end
    local d = { place = place }
    if ARMOR_PLACES[place] then
        d.armor = sub
    elseif place == "hand" or place == "two" or place == "off" or place == "ranged" then
        if sub == "Shield" then d.shield = true
        elseif sub == "Idol" or sub == "Totem" or sub == "Libram" then d.relic = sub
        elseif WEAPON_NAMES[sub] then
            local pair = WEAPON_NAMES[sub]
            d.weapon = (place == "two") and pair[2] or pair[1]
        end
    end
    return d
end

local function Faction() return UnitFactionGroup and UnitFactionGroup("player") end

-- Every dungeon item and class quest reward with an id, once. Not filtered by class: the
-- character can change.
local function Collect()
    if candidates then return candidates end
    candidates, byID = {}, {}
    local Data = PathForeverData or {}
    for _, d in ipairs(Data.Dungeons or {}) do
        if not d.comingSoon then
            for _, g in ipairs(d.lootGroups or {}) do
                for _, it in ipairs(g.items or {}) do
                    if it.id and not byID[it.id] and it.slot and not it.slot:find("^Non%-equippable") then
                        local desc = Descriptor(it.slot)
                        if desc then
                            local c = { id = it.id, name = it.name, slot = it.slot, desc = desc, dungeon = d, group = g,
                                        faction = g.faction or (d.faction ~= "Both" and d.faction or nil) }
                            byID[it.id] = c
                            candidates[#candidates + 1] = c
                        end
                    end
                end
            end
        end
    end
    for class, quests in pairs(Data.ClassQuests or {}) do
        for _, q in ipairs(quests) do
            for _, id in ipairs(q[6] or {}) do
                if not byID[id] then
                    local c = { id = id, classQuest = q, class = class, faction = q[5] }
                    byID[id] = c
                    candidates[#candidates + 1] = c
                end
            end
        end
    end
    return candidates
end

function Upgrades:GetCandidates() return Collect() end

-- ---------- the client's item data ----------
local info, stats, asked = {}, {}, {}

local function GetInfo(id)
    local i = info[id]
    if i then return i end
    if not (C_Item and C_Item.GetItemInfo) then return end
    local ok, name, link, quality, ilvl, minLevel, _, _, _, equipLoc, icon, _, classID, subClassID = pcall(C_Item.GetItemInfo, id)
    if not (ok and name) then
        if C_Item.RequestLoadItemDataByID and not asked[id] then
            asked[id] = true
            pcall(C_Item.RequestLoadItemDataByID, id)
        end
        return
    end
    local level = ilvl
    if GetDetailedItemLevelInfo then
        local ok2, eff = pcall(GetDetailedItemLevelInfo, link)
        if ok2 and type(eff) == "number" and eff > 0 then level = eff end
    end
    i = { name = name, link = link, quality = quality, ilvl = tonumber(level) or 0, minLevel = tonumber(minLevel) or 0,
          equipLoc = equipLoc, icon = icon, classID = classID, subClassID = subClassID }
    info[id] = i
    return i
end

local function GetStats(link, id)
    local s = stats[id or link]
    if s then return s end
    local fn = (C_Item and C_Item.GetItemStats) or GetItemStats
    if not fn then return {} end
    local ok, t = pcall(fn, link)
    s = (ok and type(t) == "table") and t or {}
    if id then stats[id] = s end
    return s
end

-- What the character wears in an inventory slot: { ilvl, stats, link }, or nil when it is empty.
local function Worn(slot)
    if not GetInventoryItemLink then return end
    local ok, link = pcall(GetInventoryItemLink, "player", slot)
    if not (ok and link) then return end
    local ilvl
    if GetDetailedItemLevelInfo then
        local ok2, eff = pcall(GetDetailedItemLevelInfo, link)
        if ok2 and type(eff) == "number" then ilvl = eff end
    end
    if not ilvl and C_Item and C_Item.GetItemInfo then
        local ok2, _, _, _, lv = pcall(C_Item.GetItemInfo, link)
        ilvl = ok2 and tonumber(lv) or 0
    end
    return { ilvl = ilvl or 0, stats = GetStats(link), link = link }
end

local function Owned(id)
    if not (C_Item and C_Item.GetItemCount) then return false end
    local ok, n = pcall(C_Item.GetItemCount, id, true)
    return ok and type(n) == "number" and n > 0
end

-- ---------- judging one item ----------
-- Fills in what the client says about the item (its place and kind) over the static guess.
local function Resolve(c, i)
    local d = c.desc and {} or nil
    if c.desc then for k, v in pairs(c.desc) do d[k] = v end end
    local place = EQUIP_LOC[i.equipLoc or ""]
    if place then
        d = d or {}
        d.place = place
    end
    if not d then return end
    if i.classID == 4 then
        local sc = i.subClassID
        d.armor = ({ [1] = "Cloth", [2] = "Leather", [3] = "Mail", [4] = "Plate" })[sc] or d.armor
        if sc == 6 then d.shield = true end
        if sc == 7 then d.relic = "Libram" elseif sc == 8 then d.relic = "Idol" elseif sc == 9 then d.relic = "Totem" end
    elseif i.classID == 2 and type(i.subClassID) == "number" then
        d.weapon = i.subClassID
    end
    return d
end

-- Whether the class can use the item (kind of armor or weapon), at this level.
local function Usable(d, class, level)
    if ARMOR_PLACES[d.place] and d.armor and d.armor ~= "" then
        return d.armor == BestArmor(class, level)
    end
    if d.shield then return SHIELDS[class] == true end
    if d.relic then return RELICS[class] == d.relic end
    if d.weapon then return WEAPONS[class] and WEAPONS[class][d.weapon] == true end
    if d.place == "ranged" and not d.weapon then return false end -- ammo, quivers and the like
    return true
end

local function Lowest(slots)
    local worst
    for _, s in ipairs(slots) do
        local w = Worn(s)
        if not w then return nil end -- an empty slot takes anything
        if not worst or w.ilvl < worst.ilvl then worst = w end
    end
    return worst
end

-- Judges one candidate. Returns nil for not an upgrade or not usable, "pending" when the
-- client has not sent the item yet, or { gain, text, ilvl, ... }.
function Upgrades:Judge(c, spec, level)
    local i = GetInfo(c.id)
    if not i then return "pending" end
    local d = Resolve(c, i)
    if not (d and PLACES[d.place]) then return end
    if not Usable(d, spec.class, level) then return end
    if i.minLevel > level + LEVEL_LEEWAY then return end
    if Owned(c.id) then return end
    local st = GetStats(i.link, c.id)
    local worn = Lowest(PLACES[d.place][1])
    local best
    for _, s in ipairs(spec.specs) do
        if Suits(s, st) then
            local cs = Score(s, st)
            local verdict
            if not worn then
                verdict = { gain = i.ilvl, text = "Empty slot" }
            else
                local ws = Score(s, worn.stats)
                if i.ilvl > worn.ilvl and cs >= ws * 0.9 then
                    verdict = { gain = i.ilvl - worn.ilvl, text = "+" .. (i.ilvl - worn.ilvl) }
                elseif cs >= ws * STATS_MARGIN and cs - ws >= STATS_MIN_GAIN and i.ilvl >= worn.ilvl - ILVL_FLOOR then
                    verdict = { gain = (cs - ws) * 0.5, text = "More stats", stats = true }
                end
            end
            if verdict and (not best or verdict.gain > best.gain) then best = verdict end
        end
    end
    if not best then return end
    best.id, best.name, best.link, best.quality, best.icon = c.id, i.name, i.link, i.quality, i.icon
    best.ilvl, best.minLevel, best.place = i.ilvl, i.minLevel, d.place
    best.c = c
    return best
end

-- The candidates that could still matter to this character, before any item data is needed.
local function Considered(c, spec, level)
    if c.class and c.class ~= spec.class then return false end
    local f = Faction()
    if c.faction and f and c.faction ~= f then return false end
    if c.dungeon and c.dungeon.faction and c.dungeon.faction ~= "Both" and f and c.dungeon.faction ~= f then return false end
    if c.desc then
        if not Usable(c.desc, spec.class, level) then return false end
    end
    return true
end

-- Everything for the page: { spec, groups = { { name, items = { verdicts } } }, pending, considered }.
function Upgrades:Compute()
    local spec = self:ResolveSpec()
    local level = (UnitLevel and UnitLevel("player")) or 1
    local pending, considered = 0, 0
    local bySlot = {}
    for _, c in ipairs(Collect()) do
        if Considered(c, spec, level) then
            considered = considered + 1
            local v = self:Judge(c, spec, level)
            if v == "pending" then
                pending = pending + 1
            elseif v then
                local p = PLACES[v.place]
                local g = bySlot[p[2]]
                if not g then g = { name = p[2], order = p[3], items = {} }; bySlot[p[2]] = g end
                g.items[#g.items + 1] = v
            end
        end
    end
    local groups = {}
    for _, g in pairs(bySlot) do
        table.sort(g.items, function(a, b)
            if a.gain ~= b.gain then return a.gain > b.gain end
            return (a.name or "") < (b.name or "")
        end)
        g.total = #g.items
        for n = #g.items, PER_SLOT + 1, -1 do g.items[n] = nil end
        groups[#groups + 1] = g
    end
    table.sort(groups, function(a, b) return a.order < b.order end)
    return { spec = spec, groups = groups, pending = pending, considered = considered, level = level }
end

-- Where an item comes from, one fact per line: "Boss" then "Dungeon", or "Quest: name" then "Dungeon".
function Upgrades:SourceText(v)
    local c = v.c
    if c.classQuest then return "Class quest\n" .. tostring(c.classQuest[2]) end
    local g, d = c.group, c.dungeon
    if g and g.kind == "quest" then return "Quest: " .. tostring(g.title) .. "\n" .. d.name end
    return tostring(g and g.title or "?") .. "\n" .. d.name
end

-- Forgets what was read (the character changed gear or level, or a test wants a fresh start).
function Upgrades:Reset()
    wipe(info); wipe(stats); wipe(asked)
end

-- Gear or level changed: the page is worth drawing again.
local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
events:RegisterEvent("PLAYER_LEVEL_UP")
events:SetScript("OnEvent", function()
    if PF.RequestRefresh then PF:RequestRefresh("upgrades") end
end)
