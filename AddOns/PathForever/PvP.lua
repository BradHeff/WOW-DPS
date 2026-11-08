-- PathForever: the PvP page (a Journey module, PF.PvP).
--
-- Three cards on top (Honor, Rank with its badge, Marks of Honor), then Forever's four
-- battlegrounds with the character's standing with the faction its side earns there (read
-- through PF.Reputations), the rank ladder and the battlemasters. A battleground opens a
-- popout with the character's current bracket, how it is played, how its reputation is
-- earned, the vendor if one is known (Mark on map), and its rewards sorted by the standing
-- they need (the lists live in ReputationData.lua, by faction ID, so the reputation page
-- shows the same). The rank ladder opens a popout with every rank's title and reward; the
-- battlemasters one lists the cities and, per side, where each battleground's portal is.
--
-- [SOURCE 2026-10-30] wowhead.com/forever/guide/pvp-overview-ranking-rewards (updated
-- 2026-10-24): ranks, titles and rewards, brackets, battlemasters, Darkspear Islands vendors,
-- world PvP; the reputation lists are from foreverdb.net (see ReputationData.lua).
-- Honor, marks (counted as items) and the character's own rank are read through pcall'd
-- calls: whether Forever's client exposes them is unchecked (docs/launch-checklist.md).
--
-- Plain data and calls only, nothing protected.

local PF = PathForever
local PvP = {}
PF.PvP = PvP
local Journey = PF.Journey

local function Theme() return PF.Theme end
local function Hex(c) return Theme().ColorHex(c) end

-- Reward per rank, and each side's title. 14 ranks; each rank's reward is bought from the
-- rank vendor in Stormwind or Orgrimmar.
PvP.RANKS = {
    { "Private", "Scout", "Private's Tabard / Scout's Tabard" },
    { "Corporal", "Grunt", "Insignia Trinket" },
    { "Sergeant", "Sergeant", "Faction Cloak" },
    { "Master Sergeant", "Senior Sergeant", "Faction Necklace" },
    { "Sergeant Major", "First Sergeant", "Combat Mana Potion, Combat Healing Potion" },
    { "Knight", "Stone Guard", "Knight's Colors / Stone Guard's Herald" },
    { "Knight-Lieutenant", "Blood Guard", "Battle Standard" },
    { "Knight-Captain", "Legionnaire", "Premier Emboldened Wrist Seal and Belt Seal" },
    { "Knight-Champion", "Centurion", "Premier Emboldened Feet Seal" },
    { "Lieutenant Commander", "Champion", "Premier Emboldened Hands Seal" },
    { "Commander", "Lieutenant General", "Black War Mounts" },
    { "Marshal", "General", "Premier Emboldened Shoulder Seal and Legs Seal" },
    { "Field Marshal", "Warlord", "Premier Emboldened Head Seal and Chest Seal" },
    { "Grand Marshal", "High Warlord", "Epic-quality PvP weapons" },
}

-- The ranks' rewards that have item IDs (Wowhead's guide, 2026-10-30): { rank, Alliance name,
-- Alliance ID, Horde name, Horde ID }; with no Horde name, the same item for both. The rest
-- (trinket, cloak, necklace, mounts, weapons) are not itemised in the guide. The two seals of
-- a rank are in the guide's order (wrist then belt, shoulder then legs, head then chest).
PvP.RANK_ITEMS = {
    { 1, "Private's Tabard", 15196, "Scout's Tabard", 15197 },
    { 5, "Combat Mana Potion", 18841 },
    { 5, "Combat Healing Potion", 18839 },
    { 6, "Knight's Colors", 15198, "Stone Guard's Herald", 15199 },
    { 7, "Alliance Battle Standard", 18606, "Horde Battle Standard", 18607 },
    { 8, "Premier Emboldened Wrist Seal", 275240 },
    { 8, "Premier Emboldened Belt Seal", 275244 },
    { 9, "Premier Emboldened Feet Seal", 275243 },
    { 10, "Premier Emboldened Hands Seal", 275239 },
    { 12, "Premier Emboldened Shoulder Seal", 275229 },
    { 12, "Premier Emboldened Legs Seal", 275242 },
    { 13, "Premier Emboldened Head Seal", 275241 },
    { 13, "Premier Emboldened Chest Seal", 275238 },
}

-- The battlegrounds: brackets as the guide lists them, the faction each side earns, and a
-- line on how it is played. `vendor` is per side, for the reputation gear.
PvP.BATTLEGROUNDS = {
    { name = "Warsong Gulch", min = 10, brackets = "10-19, 20-29, 30-39, 40-49, 50-59, 60",
      factions = { Alliance = 890, Horde = 889 },
      play = "Capture the enemy flag and bring it back to your own." },
    { name = "Arathi Basin", min = 20, brackets = "20-29, 30-39, 40-49, 50-59, 60",
      factions = { Alliance = 509, Horde = 510 },
      play = "Hold bases around the map to score resources, and win when your side has gathered the most." },
    { name = "Darkspear Islands", min = 30, brackets = "30-39, 40-49, 50-59, 60",
      factions = { Alliance = 2799, Horde = 2798 },
      play = "New in Forever, 15 against 15. Capture positions around the map for points over time. The flag in the middle gives immediate points when you return it to a position you hold." },
    { name = "Alterac Valley", min = 51, brackets = "51-60",
      factions = { Alliance = 730, Horde = 729 },
      play = "Fight up the valley: kill enemy NPCs, destroy towers and take graveyards." },
}

-- Where the battlemasters stand (uiMapID, x, y in 0-1), per city.
PvP.BATTLEMASTERS = {
    Alliance = {
        { "Stormwind City", "In the throne room of Stormwind Keep", 1453, 0.800, 0.385 },
        { "Ironforge", "In the Military Ward", 1455, 0.700, 0.880 },
        { "Darnassus", "On the Warrior's Terrace", 1457, 0.590, 0.405 },
    },
    Horde = {
        { "Orgrimmar", "In the Valley of Honor", 1454, 0.790, 0.305 },
        { "Undercity", "Around the throne room", 1458, 0.570, 0.910 },
        { "Thunder Bluff", "On Hunter Rise", 1456, 0.570, 0.780 },
    },
}

-- The bracket a level plays in, from a list such as "10-19, 20-29, 60": nil when the level is
-- below the first.
function PvP.Bracket(brackets, level)
    for lo, hi in string.gmatch(brackets, "(%d+)%-?(%d*)") do
        lo = tonumber(lo)
        hi = tonumber(hi) or lo
        if level >= lo and level <= hi then return lo == hi and tostring(lo) or (lo .. "-" .. hi) end
    end
end

-- Marks of Honor are items, one kind per battleground.
PvP.MARKS = { { "Warsong Gulch", 20558 }, { "Arathi Basin", 20559 }, { "Alterac Valley", 20560 } }

-- Where each side finds a battleground's portal in the open world. A pin only where the spot
-- is known; the others are named and wait for coordinates from the game (docs/launch-checklist.md).
-- { battleground, place, map, x, y }
PvP.PORTALS = {
    Alliance = {
        { "Warsong Gulch", "Silverwing Grove, Ashenvale" },
        { "Arathi Basin", "Refuge Pointe, Arathi Highlands", 1417, 0.458, 0.472 },
        { "Alterac Valley", "Northern Hillsbrad Foothills" },
    },
    Horde = {
        { "Warsong Gulch", "Mor'shan Base Camp, The Barrens" },
        { "Arathi Basin", "Hammerfall, Arathi Highlands", 1417, 0.732, 0.324 },
        { "Alterac Valley", "Northern Hillsbrad Foothills" },
    },
}

local function Side()
    local f = UnitFactionGroup and UnitFactionGroup("player")
    return f == "Horde" and "Horde" or "Alliance"
end

local STANDING_OF = { Neutral = 4, Friendly = 5, Honored = 6, Revered = 7, Exalted = 8 }

local subjects = {}
local function Subject(key)
    local s = subjects[key]
    if not s then s = { sections = {} }; subjects[key] = s end
    wipe(s.sections)
    s.mapID, s.x, s.y, s.pickup, s.pickupZone, s.mapSection, s.mapLabel = nil, nil, nil, nil, nil, nil, nil
    s.items, s.itemsLabel, s.marks = nil, nil, nil
    return s
end

local function Show(s)
    if Theme().PlayUISound then Theme().PlayUISound("IG_QUEST_LIST_SELECT") end
    PF.UI.ShowInfo(s)
end

-- the character's standing with a faction, from the reputation page's read: { standing, into, span } or nil
local function Standings()
    local out = {}
    if PF.Reputations and PF.Reputations.Read then
        local groups = PF.Reputations:Read()
        for _, g in ipairs(groups or {}) do
            for _, l in ipairs(g.list) do
                if l.id then out[l.id] = l end
            end
        end
    end
    return out
end

-- ---------- popouts ----------
function PvP:OpenBattleground(bg)
    if not (PF.UI and PF.UI.ShowInfo) then return end
    local T = Theme()
    local muted, text = Hex(T.MUTED), Hex(T.TEXT)
    local side = Side()
    local fid = bg.factions[side]
    local g = PathForeverData and PathForeverData.Reputations and PathForeverData.Reputations[fid]
    local line = Standings()[fid]
    local s = Subject("bg:" .. bg.name)
    s.title = bg.name
    s.subtitle = "Lv " .. bg.min .. " and up"

    local level = UnitLevel and UnitLevel("player") or 1
    local bracket = PvP.Bracket(bg.brackets, level)
    s.sections[#s.sections + 1] = { "Current bracket", bracket and text .. bracket .. "|r" or (muted .. "Opens at Lv " .. bg.min .. "|r") }
    local rep = PF.Reputations
    local stand
    if line and rep and rep.Label then
        stand = text .. rep.Label(line.standing) .. "|r"
        if line.standing < 8 and line.max > line.min then
            stand = stand .. string.format("  %s%d / %d|r", muted, math.max(0, line.value - line.min), line.max - line.min)
        end
    else
        stand = muted .. "Not met yet|r"
    end
    s.sections[#s.sections + 1] = { "Your reputation", text .. (g and PvP.FactionName(fid) or "") .. "|r\n" .. stand }

    if g then
        for _, sec in ipairs(g.sections or {}) do
            if sec[1] ~= "Who" and sec[1] ~= "Earn it" and sec[1] ~= "Good to know" then
                s.sections[#s.sections + 1] = { sec[1], sec[2] }
            end
        end
        local v = g.vendors and g.vendors[1]
        if v then
            s.sections[#s.sections + 1] = { "Vendor", text .. v.name .. "|r\n" .. muted .. v.zone .. "|r" }
            if v.map and v.x and v.y then
                s.mapID, s.x, s.y, s.pickup, s.pickupZone = v.map, v.x, v.y, v.name, v.zone
                s.mapSection, s.mapLabel = "Vendor", "Mark vendor on map"
            end
        end
        if g.rewards and #g.rewards > 0 then
            s.items, s.itemsLabel = {}, "Rewards"
            for _, rw in ipairs(g.rewards) do -- already in the order of the standing they need
                local reached = line and line.standing >= (STANDING_OF[rw[1]] or 9)
                s.items[#s.items + 1] = { name = rw[2], id = rw[3],
                    slot = (reached and Hex(T.GOOD or { 0.45, 0.8, 0.45 }) or muted) .. rw[1] .. "|r" }
            end
        else
            s.sections[#s.sections + 1] = { "Rewards", muted .. "No rewards known yet.|r" }
        end
    end
    Show(s)
end

-- the faction's name, from the client's own list when it has it
function PvP.FactionName(fid)
    local names = PvP.FACTION_NAMES
    return names and names[fid] or ""
end
PvP.FACTION_NAMES = {
    [890] = "Silverwing Sentinels", [889] = "Warsong Outriders", [509] = "The League of Arathor",
    [510] = "The Defilers", [2799] = "Theramore Expeditionary Force", [2798] = "Darkspear Raiders",
    [730] = "Stormpike Guard", [729] = "Frostwolf Clan",
}

function PvP:OpenRanks()
    if not (PF.UI and PF.UI.ShowInfo) then return end
    local T = Theme()
    local muted, text = Hex(T.MUTED), Hex(T.TEXT)
    local horde = Side() == "Horde"
    local s = Subject("ranks")
    s.title = "PvP ranks"
    s.subtitle = "14 ranks, " .. PvP.RANKS[1][horde and 2 or 1] .. " to " .. PvP.RANKS[14][horde and 2 or 1]
    local mine, number = PvP:OwnRank()
    if mine then
        local body = text .. mine .. "|r"
        local nextRank = number and PvP.RANKS[number + 1]
        if nextRank then
            body = body .. "\n" .. muted .. "Next: " .. nextRank[horde and 2 or 1] .. "|r"
        end
        s.sections[#s.sections + 1] = { "Your rank", body }
    end
    s.items, s.itemsLabel = {}, "Rank rewards"
    local itemised = {}
    for _, it in ipairs(PvP.RANK_ITEMS) do
        local name, id = it[2], it[3]
        if horde and it[5] then name, id = it[4], it[5] end
        itemised[it[1]] = true
        s.items[#s.items + 1] = { name = name, id = id, slot = muted .. "Rank " .. it[1] .. "|r" }
    end
    -- the rewards the guide does not itemise, one line each
    local lines = {}
    for n, r in ipairs(PvP.RANKS) do
        if not itemised[n] then lines[#lines + 1] = muted .. "Rank " .. n .. "|r  " .. text .. r[3] .. "|r" end
    end
    if #lines > 0 then s.sections[#s.sections + 1] = { "Other rewards", table.concat(lines, "\n") } end
    s.sections[#s.sections + 1] = { "Vendor", text .. (horde and "Orgrimmar" or "Stormwind City") .. "|r" }
    Show(s)
end

-- the character's own rank title and number, if the client reports one (unverified on
-- Forever: pcall)
function PvP:OwnRank()
    if not (UnitPVPRank and GetPVPRankInfo) then return nil end
    local ok, n = pcall(UnitPVPRank, "player")
    if not ok or type(n) ~= "number" or n <= 0 then return nil end
    local ok2, name, number = pcall(GetPVPRankInfo, n)
    if ok2 and type(name) == "string" and name ~= "" then return name, type(number) == "number" and number or nil end
end

-- The game's rank badge for a rank number (1 to 14), or nil
function PvP.RankIcon(number)
    if type(number) ~= "number" or number < 1 or number > 14 then return nil end
    return string.format("Interface\\PvPRankBadges\\PvPRank%02d", number)
end

-- The honor the character has, if the client says (unverified on Forever: every way is tried
-- inside a pcall)
function PvP:Honor()
    local tries = {
        function() return GetHonorCurrency and GetHonorCurrency() end,
        function() return UnitHonor and UnitHonor("player") end,
        function()
            if not (C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo) then return nil end
            for _, id in ipairs({ 1901, 1792 }) do
                local info = C_CurrencyInfo.GetCurrencyInfo(id)
                if type(info) == "table" and type(info.quantity) == "number" then return info.quantity end
            end
        end,
    }
    for _, f in ipairs(tries) do
        local ok, v = pcall(f)
        if ok and type(v) == "number" then return v end
    end
end

-- Marks of Honor in your bags and bank: the total and one { battleground, count } each
function PvP:Marks()
    local total, list = 0, {}
    local count = (C_Item and C_Item.GetItemCount) or GetItemCount
    for _, m in ipairs(PvP.MARKS) do
        local n = 0
        if count then
            local ok, v = pcall(count, m[2], true)
            if ok and type(v) == "number" then n = v end
        end
        total = total + n
        list[#list + 1] = { m[1], n }
    end
    return total, list
end

function PvP:OpenBattlemasters()
    if not (PF.UI and PF.UI.ShowInfo) then return end
    local T = Theme()
    local muted, text = Hex(T.MUTED), Hex(T.TEXT)
    local list = PvP.BATTLEMASTERS[Side()]
    local s = Subject("battlemasters")
    s.title, s.subtitle = "Battlemasters", "Where to queue"
    local lines = {}
    for _, c in ipairs(list) do
        lines[#lines + 1] = text .. c[1] .. "|r\n" .. muted .. c[2] .. "|r"
    end
    s.sections[#s.sections + 1] = { "In the cities", table.concat(lines, "\n") }
    local lines2, marks = {}, {}
    for _, w in ipairs(PvP.PORTALS[Side()]) do
        lines2[#lines2 + 1] = text .. w[1] .. "|r\n" .. muted .. w[2] .. "|r"
        if w[3] then
            marks[#marks + 1] = { label = "Mark " .. w[1] .. " on map", mapID = w[3], x = w[4], y = w[5], pickup = w[1] .. " portal", pickupZone = w[2] }
        end
    end
    s.sections[#s.sections + 1] = { "In the world", table.concat(lines2, "\n") }
    s.marks = { ["In the world"] = #marks > 0 and marks or nil }
    local c = list[1]
    s.mapID, s.x, s.y, s.pickup, s.pickupZone = c[3], c[4], c[5], "Battlemaster", c[1]
    s.mapSection, s.mapLabel = "In the cities", "Mark " .. c[1] .. " on map"
    Show(s)
end

-- ---------- the module ----------
local Module = { id = "pvp", label = "PvP", priority = 0 }
function Module:IsRelevant() return false end -- a page only: never takes a Journey card
function Module:IsComplete() return false end
function Module:Summary() return "" end

local function OpenBattleground(bg) PvP:OpenBattleground(bg) end
local function OpenRanks() PvP:OpenRanks() end
local function OpenBattlemasters() PvP:OpenBattlemasters() end

function Module:Render(p)
    local side = Side()
    local horde = side == "Horde"
    local level = UnitLevel and UnitLevel("player") or 1

    -- the three cards
    local honor = PvP:Honor()
    local rankName, rankNumber = PvP:OwnRank()
    local marks, markList = PvP:Marks()
    local markTip = { "Marks of Honor" }
    for _, m in ipairs(markList) do markTip[#markTip + 1] = m[1] .. ": " .. m[2] end
    p:AddCards({
        { "Honor", honor and tostring(honor) or "-" },
        { "Rank", rankName or "Unranked", PvP.RankIcon(rankNumber) },
        { "Marks", tostring(marks), nil, markTip },
    })

    p:AddHeader("Battlegrounds")
    local stand = Standings()
    for _, bg in ipairs(PvP.BATTLEGROUNDS) do
        local l = stand[bg.factions[side]]
        local sub = (level >= bg.min and "" or ("From Lv " .. bg.min .. ", ")) .. PvP.FactionName(bg.factions[side])
        local frac
        if l and PF.Reputations and PF.Reputations.Label then
            sub = sub .. ", " .. PF.Reputations.Label(l.standing)
            if l.standing >= 8 then frac = 1
            elseif l.max > l.min then frac = math.max(0, math.min(1, (l.value - l.min) / (l.max - l.min))) end
        end
        p:AddRow(bg.name, nil, sub, nil, nil, OpenBattleground, bg, nil, level < bg.min, frac)
    end

    p:AddHeader("Ranking")
    p:AddRow("Ranks", nil, rankName and ("You are a " .. rankName) or
        (PvP.RANKS[1][horde and 2 or 1] .. " to " .. PvP.RANKS[14][horde and 2 or 1]), nil, nil, OpenRanks, nil)

    p:AddHeader("Queue")
    p:AddRow("Battlemasters", nil, "Cities and portals", nil, nil, OpenBattlemasters, nil)
end

Journey:RegisterModule(Module)
Journey.PAGE_OF.pvp = "PvP"
Journey.PAGES.PvP = "pvp"
