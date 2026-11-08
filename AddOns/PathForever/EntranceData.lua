-- PathForever: dungeon and raid entrances for the world map (EntranceMap.lua).
--
-- [SOURCE 2026-10-11] The "Entrance: Zone (x, y)" line of each dungeon's page on
-- foreverdb.net, which reads it from the Forever client (build 1.60.1.70338); for
-- the Classic dungeons it matches the position in the game files' Map table
-- (checked for Ragefire Chasm, Deadmines and Wailing Caverns). Excavation Site's was set from a
-- screenshot of the map in game (2026-10-11; ForeverDB's 24.5, 73.4 was wrong). Stratholme's Undead side was read off a
-- screenshot of the map (2026-10-11). City of Dalaran's is
-- the Horde gate in Silverpine Forest, from the Wowhead quest data.
--
-- Entrances[i] = {
--   name   : what the pin is called (a complex such as Scarlet Monastery is one pin)
--   kind   : "dungeon" or "raid"
--   map, x, y   : the zone's UiMap ID and the spot on it (0-1, from the top left)
--   cmap, cx, cy: the same spot on the continent map (1414 Kalimdor, 1415 Eastern
--                 Kingdoms), worked out from the zones' map bounds in the game files
--   dungeons: names of the dungeons in Dungeons that start here (all its wings)
--   others  : { name, level, players } for what PathForever has no page for yet
--             (raids; Caverns of Time, whose level is 0 = not given)
--   note    : one extra line for the tooltip
-- }
-- Dungeons without a known entrance (Drowned City, Krol'dok Stronghold, Alcaz
-- Prison, Blackmaw Hold, Shaper's Terrace) are left off until it is known.

PathForeverData = PathForeverData or {}

PathForeverData.Entrances = {
    { name = "Ragefire Chasm", kind = "dungeon", map = 1454, x = 0.530, y = 0.489, cmap = 1414, cx = 0.584, cy = 0.448, dungeons = { "Ragefire Chasm" } },
    { name = "The Deadmines", kind = "dungeon", map = 1436, x = 0.382, y = 0.775, cmap = 1415, cx = 0.407, cy = 0.796, dungeons = { "The Deadmines" } },
    { name = "Wailing Caverns", kind = "dungeon", map = 1413, x = 0.477, y = 0.350, cmap = 1414, cx = 0.524, cy = 0.552, dungeons = { "Wailing Caverns" } },
    { name = "Shadowfang Keep", kind = "dungeon", map = 1421, x = 0.447, y = 0.678, cmap = 1415, cx = 0.410, cy = 0.328, dungeons = { "Shadowfang Keep" } },
    { name = "Blackfathom Deeps", kind = "dungeon", map = 1440, x = 0.165, y = 0.110, cmap = 1414, cx = 0.443, cy = 0.348, dungeons = { "Blackfathom Deeps" } },
    { name = "The Stockade", kind = "dungeon", map = 1453, x = 0.504, y = 0.662, cmap = 1415, cx = 0.430, cy = 0.692, dungeons = { "The Stockade" } },
    { name = "Gnomeregan", kind = "dungeon", map = 1426, x = 0.177, y = 0.391, cmap = 1415, cx = 0.428, cy = 0.538, dungeons = { "Gnomeregan" } },
    { name = "Razorfen Kraul", kind = "dungeon", map = 1413, x = 0.423, y = 0.899, cmap = 1414, cx = 0.509, cy = 0.704, dungeons = { "Razorfen Kraul" } },
    { name = "Scarlet Monastery", kind = "dungeon", map = 1420, x = 0.851, y = 0.314, cmap = 1415, cx = 0.478, cy = 0.195, dungeons = { "Scarlet Monastery: Graveyard", "Scarlet Monastery: Library", "Scarlet Monastery: Armory", "Scarlet Monastery: Cathedral" } },
    { name = "Razorfen Downs", kind = "dungeon", map = 1413, x = 0.509, y = 0.929, cmap = 1414, cx = 0.533, cy = 0.712, dungeons = { "Razorfen Downs" } },
    { name = "Uldaman", kind = "dungeon", map = 1418, x = 0.352, y = 0.103, cmap = 1415, cx = 0.538, cy = 0.576, dungeons = { "Uldaman" } },
    { name = "Maraudon", kind = "dungeon", map = 1443, x = 0.291, y = 0.629, cmap = 1414, cx = 0.384, cy = 0.580, dungeons = { "Maraudon" } },
    { name = "Zul'Farrak", kind = "dungeon", map = 1446, x = 0.387, y = 0.199, cmap = 1414, cx = 0.542, cy = 0.799, dungeons = { "Zul'Farrak" } },
    { name = "Temple of Atal'Hakkar", kind = "dungeon", map = 1435, x = 0.773, y = 0.359, cmap = 1415, cx = 0.568, cy = 0.752, dungeons = { "Temple of Atal'Hakkar" } },
    { name = "Blackrock Depths", kind = "dungeon", map = 1427, x = 0.271, y = 0.725, cmap = 1415, cx = 0.481, cy = 0.624, dungeons = { "Blackrock Depths" } },
    { name = "Blackrock Spire", kind = "dungeon", map = 1428, x = 0.330, y = 0.252, cmap = 1415, cx = 0.490, cy = 0.639, dungeons = { "Lower Blackrock Spire", "Upper Blackrock Spire" } },
    { name = "Dire Maul", kind = "dungeon", map = 1444, x = 0.620, y = 0.333, cmap = 1414, cx = 0.433, cy = 0.681, dungeons = { "Dire Maul: East", "Dire Maul: West", "Dire Maul: North" } },
    { name = "Scholomance", kind = "dungeon", map = 1422, x = 0.690, y = 0.730, cmap = 1415, cx = 0.527, cy = 0.264, dungeons = { "Scholomance" } },
    { name = "Stratholme (Live side)", kind = "dungeon", map = 1423, x = 0.261, y = 0.104, cmap = 1415, cx = 0.551, cy = 0.174, dungeons = { "Stratholme" } },
    { name = "Stratholme (Undead side)", kind = "dungeon", map = 1423, x = 0.476, y = 0.240, cmap = 1415, cx = 0.577, cy = 0.190, dungeons = { "Stratholme" }, note = "The service entrance, east of the city." },
    { name = "Hall of Thanes", kind = "dungeon", map = 1455, x = 0.771, y = 0.513, cmap = 1415, cx = 0.492, cy = 0.524, dungeons = { "Hall of Thanes" } },
    { name = "Ruins of Lordaeron", kind = "dungeon", map = 1420, x = 0.633, y = 0.675, cmap = 1415, cx = 0.450, cy = 0.241, dungeons = { "Ruins of Lordaeron" } },
    { name = "Excavation Site", kind = "dungeon", map = 1437, x = 0.488, y = 0.597, cmap = 1415, cx = 0.523, cy = 0.480, dungeons = { "Excavation Site" } },
    { name = "City of Dalaran", kind = "dungeon", map = 1421, x = 0.696, y = 0.461, cmap = 1415, cx = 0.440, cy = 0.302, dungeons = { "City of Dalaran" }, note = "Horde entrance; the gate needs a Dalaran Sewer Key. The Alliance enter from the Underbelly tavern in Stormwind." },
    { name = "Molten Core", kind = "raid", map = 1428, x = 0.263, y = 0.246, cmap = 1415, cx = 0.484, cy = 0.638, others = { { "Molten Core", 60, 40 } } },
    { name = "Blackwing Lair", kind = "raid", map = 1428, x = 0.325, y = 0.324, cmap = 1415, cx = 0.489, cy = 0.645, others = { { "Blackwing Lair", 60, 40 } } },
    { name = "Onyxia's Lair", kind = "raid", map = 1445, x = 0.529, y = 0.777, cmap = 1414, cx = 0.566, cy = 0.715, others = { { "Onyxia's Lair", 60, 40 } } },
    { name = "Zul'Gurub", kind = "raid", map = 1434, x = 0.540, y = 0.176, cmap = 1415, cx = 0.489, cy = 0.826, others = { { "Zul'Gurub", 60, 20 } } },
    { name = "Ahn'Qiraj", kind = "raid", map = 1451, x = 0.290, y = 0.928, cmap = 1414, cx = 0.422, cy = 0.852, others = { { "Ruins of Ahn'Qiraj", 60, 20 }, { "Temple of Ahn'Qiraj", 60, 40 } } },
    { name = "Caverns of Time", kind = "dungeon", map = 1446, x = 0.644, y = 0.506, cmap = 1414, cx = 0.590, cy = 0.856, others = { { "Caverns of Time", 0, 10 } } },
}
