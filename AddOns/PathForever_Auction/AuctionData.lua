-- AuctionData.lua - PathForever Auction: what gear disenchants into.
--
-- [SOURCE 2026-10-30] The shape of the tables (which item level gives which dust, essence or
-- shard, the chance of each and how many) is Warcraft Wiki's "Disenchanting tables", whose
-- note says they are from before Battle for Azeroth: the vanilla rows (item levels 5 to 65)
-- are used. Forever has not been checked against them, and its retuned items may differ; a
-- disenchant seen in game that does not fit should change a row here. Every material's ID
-- was confirmed on foreverdb.net (2026-10-30).
--
-- Rows are { lowest item level, highest item level, { { itemID, chance %, least, most }, ... } }.
-- The item level is the item's own level, not the level it needs.

PathForeverAuctionData = {}
local D = PathForeverAuctionData

D.NAMES = {
    [10940] = "Strange Dust", [11083] = "Soul Dust", [11137] = "Vision Dust", [11176] = "Dream Dust", [16204] = "Illusion Dust",
    [10938] = "Lesser Magic Essence", [10939] = "Greater Magic Essence", [10998] = "Lesser Astral Essence",
    [11082] = "Greater Astral Essence", [11134] = "Lesser Mystic Essence", [11135] = "Greater Mystic Essence",
    [11174] = "Lesser Nether Essence", [11175] = "Greater Nether Essence", [16202] = "Lesser Eternal Essence",
    [16203] = "Greater Eternal Essence",
    [10978] = "Small Glimmering Shard", [11084] = "Large Glimmering Shard", [11138] = "Small Glowing Shard",
    [11139] = "Large Glowing Shard", [11177] = "Small Radiant Shard", [11178] = "Large Radiant Shard",
    [14343] = "Small Brilliant Shard", [14344] = "Large Brilliant Shard", [20725] = "Nexus Crystal",
}

local STRANGE, SOUL, VISION, DREAM, ILLUSION = 10940, 11083, 11137, 11176, 16204
local L_MAGIC, G_MAGIC, L_ASTRAL, G_ASTRAL, L_MYSTIC, G_MYSTIC = 10938, 10939, 10998, 11082, 11134, 11135
local L_NETHER, G_NETHER, L_ETERNAL, G_ETERNAL = 11174, 11175, 16202, 16203
local S_GLIM, L_GLIM, S_GLOW, L_GLOW, S_RAD, L_RAD, S_BRIL, L_BRIL, NEXUS = 10978, 11084, 11138, 11139, 11177, 11178, 14343, 14344, 20725

-- uncommon armor: mostly dust
D.UNCOMMON_ARMOR = {
    { 5, 15, { { STRANGE, 80, 1, 2 }, { L_MAGIC, 20, 1, 2 } } },
    { 16, 20, { { STRANGE, 75, 2, 3 }, { G_MAGIC, 20, 1, 2 }, { S_GLIM, 5, 1, 1 } } },
    { 21, 25, { { STRANGE, 75, 4, 6 }, { L_ASTRAL, 15, 1, 2 }, { S_GLIM, 10, 1, 1 } } },
    { 26, 30, { { SOUL, 75, 1, 2 }, { G_ASTRAL, 20, 1, 2 }, { L_GLIM, 5, 1, 1 } } },
    { 31, 35, { { SOUL, 75, 2, 5 }, { L_MYSTIC, 20, 1, 2 }, { S_GLOW, 5, 1, 1 } } },
    { 36, 40, { { VISION, 75, 1, 2 }, { G_MYSTIC, 20, 1, 2 }, { L_GLOW, 5, 1, 1 } } },
    { 41, 45, { { VISION, 75, 2, 5 }, { L_NETHER, 20, 1, 2 }, { S_RAD, 5, 1, 1 } } },
    { 46, 50, { { DREAM, 75, 1, 2 }, { G_NETHER, 20, 1, 2 }, { L_RAD, 5, 1, 1 } } },
    { 51, 55, { { DREAM, 75, 2, 5 }, { L_ETERNAL, 20, 1, 2 }, { S_BRIL, 5, 1, 1 } } },
    { 56, 60, { { ILLUSION, 75, 1, 2 }, { G_ETERNAL, 20, 1, 2 }, { L_BRIL, 5, 1, 1 } } },
    { 61, 65, { { ILLUSION, 75, 2, 5 }, { G_ETERNAL, 20, 2, 3 }, { L_BRIL, 5, 1, 1 } } },
}

-- uncommon weapons: mostly essence
D.UNCOMMON_WEAPON = {
    { 6, 15, { { STRANGE, 20, 1, 2 }, { L_MAGIC, 80, 1, 2 } } },
    { 16, 20, { { STRANGE, 20, 2, 3 }, { G_MAGIC, 75, 1, 2 }, { S_GLIM, 5, 1, 1 } } },
    { 21, 25, { { STRANGE, 15, 4, 6 }, { L_ASTRAL, 75, 1, 2 }, { S_GLIM, 10, 1, 1 } } },
    { 26, 30, { { SOUL, 20, 1, 2 }, { G_ASTRAL, 75, 1, 2 }, { L_GLIM, 5, 1, 1 } } },
    { 31, 35, { { SOUL, 20, 2, 5 }, { L_MYSTIC, 75, 1, 2 }, { S_GLOW, 5, 1, 1 } } },
    { 36, 40, { { VISION, 20, 1, 2 }, { G_MYSTIC, 75, 1, 2 }, { L_GLOW, 5, 1, 1 } } },
    { 41, 45, { { VISION, 20, 2, 5 }, { L_NETHER, 75, 1, 2 }, { S_RAD, 5, 1, 1 } } },
    { 46, 50, { { DREAM, 20, 1, 2 }, { G_NETHER, 75, 1, 2 }, { L_RAD, 5, 1, 1 } } },
    { 51, 55, { { DREAM, 22, 2, 5 }, { L_ETERNAL, 75, 1, 2 }, { S_BRIL, 3, 1, 1 } } },
    { 56, 60, { { ILLUSION, 22, 1, 2 }, { G_ETERNAL, 75, 1, 2 }, { L_BRIL, 3, 1, 1 } } },
    { 61, 65, { { ILLUSION, 22, 2, 5 }, { G_ETERNAL, 75, 2, 3 }, { L_BRIL, 3, 1, 1 } } },
}

-- rare gear: a shard
D.RARE = {
    { 1, 25, { { S_GLIM, 100, 1, 1 } } },
    { 26, 30, { { L_GLIM, 100, 1, 1 } } },
    { 31, 35, { { S_GLOW, 100, 1, 1 } } },
    { 36, 40, { { L_GLOW, 100, 1, 1 } } },
    { 41, 45, { { S_RAD, 100, 1, 1 } } },
    { 46, 50, { { L_RAD, 100, 1, 1 } } },
    { 51, 55, { { S_BRIL, 100, 1, 1 } } },
    { 56, 65, { { L_BRIL, 99.5, 1, 1 }, { NEXUS, 0.5, 1, 1 } } },
}

-- epic gear: shards, then a Nexus Crystal
D.EPIC = {
    { 40, 45, { { S_RAD, 100, 2, 4 } } },
    { 46, 50, { { L_RAD, 100, 2, 4 } } },
    { 51, 55, { { S_BRIL, 100, 2, 4 } } },
    { 56, 60, { { NEXUS, 100, 1, 1 } } },
}

local function Find(rows, ilvl)
    for _, r in ipairs(rows) do
        if ilvl >= r[1] and ilvl <= r[2] then return r[3] end
    end
end

-- What an item disenchants into: a list of { itemID, chance, least, most }, or nil when it
-- cannot be told (an item level the tables do not cover). quality 2 is uncommon, 3 rare, 4 epic.
function D.Outcomes(quality, isWeapon, ilvl)
    ilvl = tonumber(ilvl)
    if not ilvl then return nil end
    if quality == 2 then return Find(isWeapon and D.UNCOMMON_WEAPON or D.UNCOMMON_ARMOR, ilvl) end
    if quality == 3 then return Find(D.RARE, ilvl) end
    if quality == 4 then return Find(D.EPIC, ilvl) end
end

-- The worth of a disenchant at the roll "low", "average" or "high", given `price(itemID)` (copper
-- for one, or nil when it is not known). Low is the least you can get: the cheapest of the
-- possible results, as few as can drop. High is the best of them, as many as can drop. Average is
-- each result's chance times its average number. A result with no price counts as nothing, so a
-- roll never promises more than the scans back up. Returns nil when no result has a price.
function D.Value(outcomes, roll, price)
    if not outcomes then return nil end
    local low, high, sum, total, any = nil, 0, 0, 0, false
    for _, o in ipairs(outcomes) do
        local p = price(o[1])
        if p then any = true end
        p = p or 0
        local lo, hi = p * o[3], p * o[4]
        if not low or lo < low then low = lo end
        if hi > high then high = hi end
        sum = sum + o[2] * (lo + hi) / 2
        total = total + o[2]
    end
    if not any then return nil end
    if roll == "low" then return math.floor(low or 0) end
    if roll == "high" then return math.floor(high) end
    return math.floor(total > 0 and sum / total or 0)
end
