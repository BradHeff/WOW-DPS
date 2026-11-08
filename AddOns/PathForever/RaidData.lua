-- PathForever: the raids for the Raids tab (UI.lua's PF:RenderRaidsTab).
--
-- PathForeverData.Raids is a list shaped like Data.lua's Dungeons so the tab can grow into a copy of the
-- Dungeons tab (quests, attunements, bosses and loot):
--   name, zone, levelMin, levelMax, players, art (a loading screen's file ID), comingSoon.
-- Raids are listed by tier. Every raid is comingSoon for now: Forever opens its raids on 2026-12-09 (Barrow Deeps, Hyjal Summit
-- and Onyxia's Lair are the three Blizzard's raid overview named). A comingSoon raid is listed with its
-- art, "Coming Soon!" in red and no click. Where it starts on the world map is EntranceData.lua's (its
-- green raid icon), for the raids whose entrance is known.
--
-- [SOURCE 2026-10-30] The classic raids' names, sizes and loading screens (the NarrowScreenFileDataID
-- of the map's LoadingScreens row, the same field the dungeon art uses) are read from the exported
-- client's Map and LoadingScreens tables (research/db2). Barrow Deeps and Hyjal Summit are the new
-- raids named in Blizzard's raid overview, as read on foreverdb.net (2026-10-19); the client has no
-- map for them yet, so they have no art, no zone for Barrow Deeps and no level or size.

-- tier = the order the raids are expected to open. Tier 1 is what Blizzard's raid overview named for
-- 2026-12-09 (Barrow Deeps, Hyjal Summit, Onyxia's Lair). The later tiers are an assumption: Forever
-- is expected to follow the classic release schedule (Molten Core, Blackwing Lair, Zul'Gurub, the two
-- Ahn'Qiraj raids, Naxxramas). Change them when Blizzard says otherwise.
PathForeverData.RaidTiers = { "Opens first", "Expected next", "Expected after that", "Expected later", "Expected later still", "Expected last" }

PathForeverData.Raids = {
    { name = "Barrow Deeps", tier = 1, comingSoon = true, new = true },
    { name = "Hyjal Summit", zone = "Mount Hyjal", tier = 1, comingSoon = true, new = true },
    { name = "Onyxia's Lair", zone = "Dustwallow Marsh", tier = 1, levelMin = 60, levelMax = 60, players = 40, art = 131863, comingSoon = true },
    { name = "Molten Core", zone = "Blackrock Mountain", tier = 2, levelMin = 60, levelMax = 60, players = 40, art = 131851, comingSoon = true },
    { name = "Blackwing Lair", zone = "Blackrock Mountain", tier = 3, levelMin = 60, levelMax = 60, players = 40, art = 131827, comingSoon = true },
    { name = "Zul'Gurub", zone = "Stranglethorn Vale", tier = 4, levelMin = 60, levelMax = 60, players = 20, art = 131886, comingSoon = true },
    { name = "Ruins of Ahn'Qiraj", zone = "Silithus", tier = 5, levelMin = 60, levelMax = 60, players = 20, art = 131818, comingSoon = true },
    { name = "Temple of Ahn'Qiraj", zone = "Silithus", tier = 5, levelMin = 60, levelMax = 60, players = 40, art = 131819, comingSoon = true },
    { name = "Naxxramas", zone = "Eastern Plaguelands", tier = 6, levelMin = 60, levelMax = 60, players = 40, art = 131854, comingSoon = true },
}
