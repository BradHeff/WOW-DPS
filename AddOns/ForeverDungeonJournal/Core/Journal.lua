local ADDON_NAME, FDJ = ...
FDJ = FDJ or _G.ForeverDungeonJournal_NS

local function L(key, ...)
    if FDJ and FDJ.L then return FDJ.L(key, ...) end
    return key
end

local function DungeonName(name)
    return FDJ.LocalizeDungeonName and FDJ.LocalizeDungeonName(name) or name
end

local function DungeonField(name, field, fallback)
    return FDJ.LocalizeDungeonField and FDJ.LocalizeDungeonField(name, field, fallback) or fallback
end

local function QuestField(questID, field, fallback)
    return FDJ.LocalizeQuestField and FDJ.LocalizeQuestField(questID, field, fallback) or fallback
end

local function BossName(name)
    return FDJ.LocalizeBossName and FDJ.LocalizeBossName(name) or name
end

local function ItemSlot(text)
    return FDJ.LocalizeItemSlot and FDJ.LocalizeItemSlot(text) or text
end

local function FreeText(text)
    return FDJ.LocalizeFreeText and FDJ.LocalizeFreeText(text) or text
end

local DB = FDJ.DB
local ORDER = FDJ.ORDER
local BOSS_LEVELS = FDJ.BOSS_LEVELS
local QUEST_START_MAPS = FDJ.QUEST_START_MAPS or {}
local THEMES = FDJ.THEMES
local FOREVER_QUEST_XP_FALLBACK = FDJ.FOREVER_QUEST_XP_FALLBACK
local FOREVER_QUEST_BASE_XP = FDJ.FOREVER_QUEST_BASE_XP
local QUEST_PREREQ_CHAINS = FDJ.QUEST_PREREQ_CHAINS
local QUEST_PREREQ_DETAILS = FDJ.QUEST_PREREQ_DETAILS
local PREREQ_REWARD_ITEMS_FALLBACK = FDJ.PREREQ_REWARD_ITEMS_FALLBACK
local PREREQ_REWARD_MONEY_FALLBACK = FDJ.PREREQ_REWARD_MONEY_FALLBACK
local STATIC_DISPLAY_IDS = FDJ.STATIC_DISPLAY_IDS
local EQUIP_LOC_SLOTS = FDJ.EQUIP_LOC_SLOTS
local STAT_DELTA_ORDER = FDJ.STAT_DELTA_ORDER
local STAT_DELTA_FALLBACK_LABELS = FDJ.STAT_DELTA_FALLBACK_LABELS
local DUNGEON_HOME_ART = FDJ.DUNGEON_HOME_ART
local DUNGEON_HOME_TEXCOORD = FDJ.DUNGEON_HOME_TEXCOORD
local DUNGEON_PAGE_ART = FDJ.DUNGEON_PAGE_ART
local DUNGEON_PAGE_TEXCOORD = FDJ.DUNGEON_PAGE_TEXCOORD

local ShowRecordedLocationOnMap = FDJ.MapMarkers.ShowRecordedLocationOnMap
local ShowRouteOnMap = FDJ.MapMarkers.ShowRouteOnMap
local ShowQuestStartOnMap = FDJ.MapMarkers.ShowQuestStartOnMap

-- Deadmines: beta cache quests and observed loot; see SOURCES.txt.

-- Blackfathom Deeps: Forever beta quest cache + observed/Classic loot assignments.

-- Ragefire Chasm: current Forever beta quest cache + observed loot.

-- v1.0.26: verified boss levels. Values are deliberately static rather than
-- guessed from the dungeon range. Returning-dungeon values use Classic Era
-- creature data (the Forever beta currently retains those boss levels).
-- Forever-exclusive values are only included where current beta reporting or
-- an in-game sighting confirms them. Durgen is confirmed level 16 from an in-game screenshot.
local function BossLevelText(dungeonName, boss)
    local byDungeon = BOSS_LEVELS[(boss and boss.fdjDungeon) or dungeonName]
    if not byDungeon or not boss then return nil end
    return byDungeon[boss.name]
end

-- Fit multi-level ranges (for example 24-25) cleanly inside the circular
-- medallion without shrinking normal two-digit boss levels.
local function FitBossLevelText(fontString, text)
    if not fontString or not text then return end

    if not fontString.fdjBaseFontPath then
        local fontPath, fontSize, fontFlags = fontString:GetFont()
        fontString.fdjBaseFontPath = fontPath
        fontString.fdjBaseFontSize = fontSize
        fontString.fdjBaseFontFlags = fontFlags or ""
    end

    local fontPath = fontString.fdjBaseFontPath
    local baseSize = fontString.fdjBaseFontSize or 10
    local flags = fontString.fdjBaseFontFlags or ""
    if not fontPath then return end

    if tostring(text):find("%-") then
        -- Ranges need substantially less width than the normal two-digit label.
        fontString:SetFont(fontPath, math.max(7, math.floor(baseSize * 0.67 + 0.5)), flags)
    else
        fontString:SetFont(fontPath, baseSize, flags)
    end
end


-- Known quest-start coordinates. Coordinates are normalized (0-1) for the
-- Classic/Forever world-map canvas. Forever uses the Classic UIMapIDs here
-- (Westfall 1436, Stormwind City 1453), not the Retail IDs 52 / 84.
local selectedDungeon = ForeverDungeonJournalDB.lastDungeon or ORDER[1]
local selectedBoss = ForeverDungeonJournalDB.lastBoss or 1
local selectedQuest = ForeverDungeonJournalDB.lastQuest or 1
local allowHiddenQuestSelection = false
local selectedMode = ForeverDungeonJournalDB.lastMode or "bosses"
local selectedQuestFaction = ForeverDungeonJournalDB.questFaction or "Alliance"
local selectedPrereqStep = nil
local selectedPrereqParentQuestName = nil
local selectedPrereqParentQuestID = nil
local sessionLastView = "home"

local frame
local minimapButton
local itemTooltip

-- Reuse native Blizzard UI sounds so the journal feels like part of the client.
-- Numeric fallbacks keep this working on Forever/Classic builds where a SOUNDKIT
-- constant may not be exposed even though the underlying sound kit exists.
local function PlayJournalPaperSound()
    if PlaySound then
        PlaySound((SOUNDKIT and SOUNDKIT.IG_ABILITY_PAGE_TURN) or 836)
    end
end

local function PlayJournalOptionSound()
    if PlaySound then
        PlaySound((SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION) or 852)
    end
end

-- Header language picker. Display names intentionally use each language's own
-- name so the menu is easy to recognize regardless of the active UI locale.
local LANGUAGE_CHOICES = {
    { code = "en", locale = "enUS", label = "English" },
    { code = "de", locale = "deDE", label = "Deutsch" },
    { code = "fr", locale = "frFR", label = "Français" },
    { code = "es", locale = "esES", label = "Español" },
    { code = "it", locale = "itIT", label = "Italiano" },
    { code = "pt", locale = "ptBR", label = "Português" },
    { code = "ru", locale = "ruRU", label = "Русский" },
    { code = "ko", locale = "koKR", label = "한국어" },
    { code = "zh", locale = "zhCN", label = "简体中文" },
    { code = "zhtw", locale = "zhTW", label = "繁體中文" },
}

local RAGEFIRE_MAP = {
    uiMapID = 213,
    bosses = {
        -- Aligned to the four native encounter symbols visible on the Ragefire
        -- parchment (same layout used by established dungeon-map addons).
        -- Coordinates normalized against the native 3:2 Ragefire parchment.
        -- These align with the labeled Classic dungeon map, not the tile grid.
        { name = "Oggleflint", x = 0.885, y = 0.585 },
        { name = "Taragaman the Hungerer", x = 0.435, y = 0.515 },
        { name = "Jergosh the Invoker", x = 0.350, y = 0.825 },
        { name = "Bazzalan", x = 0.485, y = 0.885 },
    },
}

-- Custom dungeon map pages. Only dungeons listed here get the "Map" tab.
-- texture: power-of-two TGA in Media; the art occupies texCoord (right/bottom)
-- of it; aspect is the art's width/height. Boss x/y are normalized to the art.
-- (Stored on FDJ, not as a file local: Journal.lua is at Lua 5.1's
-- 200-locals-per-chunk limit.)
FDJ.DUNGEON_MAPS = {
    -- Custom parchments shipped in Media (art sits in the top part of a
    -- 1024x1024 TGA). Classic dungeons use the client's own map tiles
    -- (Interface\WorldMap\<Name>\<Name><floor>_1..12, a 4x3 grid of 256px
    -- tiles whose visible part is 1002x668).
    -- entrance.angle: direction (degrees, 0 = right, 90 = up) from the
    -- entrance to where the arrow and its "Entrance" label sit.
    ["Hall of Thanes"] = {
        floors = { { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\HallOfThanesMap", texBottom = 683 / 1024 } },
        entrance = { floor = 1, x = 0.510, y = 0.944, angle = 0 },
        bosses = {
            { name = "Faldrim Anvilmar",   x = 0.509, y = 0.668 },
            { name = "Magmatus",           x = 0.748, y = 0.478 },
            { name = "Plunder",            x = 0.510, y = 0.515 },
            { name = "Durgen Dirgehammer", x = 0.509, y = 0.170 },
        },
    },
    ["Ruins of Lordaeron"] = {
        floors = { { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\RuinsOfLordaeronMap", texBottom = 683 / 1024 } },
        entrance = { floor = 1, x = 0.612, y = 0.214, angle = 180 },
        -- NPCs who take quests inside the dungeon (quest tracker's ? button):
        -- Captain Truman stands just inside, by the entrance.
        turnins = {
            { npc = "Captain Truman", x = 0.612, y = 0.272 },
        },
        -- Positions follow the published run order: Witherfang in the long
        -- hallway east of the entrance (King's Alley), The Baron in the
        -- indoor courtyard after it, then the U-shaped path, The Abandoned's
        -- statue event, Bjork in the foggy area below Market Street and
        -- Rath'mael on the purple rune in the south-west.
        bosses = {
            { name = "Witherfang",        x = 0.668, y = 0.360 },
            { name = "The Baron",         x = 0.615, y = 0.650 }, -- from the author's minimap screenshot (King's Alley, curved road)
            { name = "Viktor the Vile",   x = 0.437, y = 0.788 }, -- beside Lordaeron Graveyard (author's black dot, 6 Nov 2026)
            { name = "The Abandoned",     x = 0.395, y = 0.665 },
            { name = "Bjork",             x = 0.345, y = 0.220 },
            { name = "Rath'mael",         x = 0.520, y = 0.600 },
            { name = "Lordaeron Captain", x = 0.500, y = 0.300 },
        },
    },

    ["City of Dalaran"] = {
        -- Level 1 is the Underbelly (where the dungeon starts), Level 2 the city.
        floors = {
            { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\DalaranUnderbellyMap", texBottom = 1365 / 2048 },
            { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\DalaranCityMap", texBottom = 1365 / 2048 },
        },
        -- The dungeon starts at the portal at the end of the Underbelly pipe.
        entrance = { floor = 1, x = 0.190, y = 0.838, angle = 0 },
        transitions = {
            { floor = 1, to = 2, x = 0.778, y = 0.564 },
        },
        -- Only bosses whose spot is known are placed.
        bosses = {
            { name = "Atrexis the Grave Knight", floor = 1, x = 0.535, y = 0.505 },
            { name = "Lyn the Ignored",          floor = 1, x = 0.680, y = 0.177 },
            { name = "Mana Devourer",            floor = 2, x = 0.416, y = 0.730 },
            { name = "Fel Ancient",              floor = 2, x = 0.513, y = 0.549 },
            { name = "Unstable Sentinel",        floor = 2, x = 0.614, y = 0.413 },
            { name = "Arcanic Enigma",           floor = 2, x = 0.669, y = 0.503 },
            { name = "Arcane Anomaly",           floor = 2, x = 0.527, y = 0.843 },
            { name = "Shade of the Archmage",    floor = 2, x = 0.520, y = 0.240 },
        },
    },

    -- No boss positions known yet.
    ["The Drowned City"] = {
        floors = { { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\DrownedCityMap", texBottom = 683 / 1024 } },
        entrance = { floor = 1, x = 0.846, y = 0.521, angle = 0 }, -- the swirl in Sunken Hollow
        bosses = {},
    },
    -- Announced dungeons (no boss data yet): the map is their only page.
    ["Krol'dok Stronghold"] = {
        floors = { { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\KroldokMap", texBottom = 683 / 1024 } },
        entrance = { floor = 1, x = 0.205, y = 0.807, angle = 180 }, -- the swirl where the trail comes in (south-west)
        bosses = {},
    },
    ["Shaper's Terrace"] = {
        floors = { { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\ShapersTerraceMap", texBottom = 683 / 1024 } },
        bosses = {},
    },

    ["Gnomeregan"] = {
        -- Cataclysm-era client art; its skulls are patched out and our own
        -- portraits mark the Classic/Forever boss rooms instead.
        floors = {
            { uiMapID = 226, tiles = "Interface\\WorldMap\\Gnomeregan\\Gnomeregan1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Gnomeregan1_s1", x0 = 0.7595, y0 = 0.6452, x1 = 0.7934, y1 = 0.6961 } } },
            { uiMapID = 227, tiles = "Interface\\WorldMap\\Gnomeregan\\Gnomeregan2_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Gnomeregan2_s1", x0 = 0.7435, y0 = 0.4431, x1 = 0.7774, y1 = 0.4940 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Gnomeregan2_s2", x0 = 0.2275, y0 = 0.6587, x1 = 0.2615, y1 = 0.7096 } } },
            { uiMapID = 228, tiles = "Interface\\WorldMap\\Gnomeregan\\Gnomeregan3_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Gnomeregan3_s1", x0 = 0.4172, y0 = 0.8578, x1 = 0.4511, y1 = 0.9087 } } },
            { uiMapID = 229, tiles = "Interface\\WorldMap\\Gnomeregan\\Gnomeregan4_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Gnomeregan4_s1", x0 = 0.2984, y0 = 0.2740, x1 = 0.3323, y1 = 0.3249 } } },
        },
        entrance = { floor = 1, x = 0.642, y = 0.278, angle = 0 },
        -- Ladders: where each level continues (shared rooms between maps).
        transitions = {
            { floor = 1, to = 2, x = 0.545, y = 0.409, labelKey = "MAP_JUMP_LEVEL" }, -- Hall of Gears: jump down
            { floor = 1, to = 2, x = 0.487, y = 0.877 }, -- The Dormitory
            { floor = 2, to = 3, x = 0.435, y = 0.813 }, -- end of the corridor below the Launch Bay
            { floor = 3, to = 4, x = 0.370, y = 0.720 }, -- Engineering Labs
            { floor = 4, to = 3, x = 0.440, y = 0.726 }, -- corridor bend between Tinkers' Court and the Engineering Labs
        },
        bosses = {
            { name = "Grubbis",               floor = 1, x = 0.776, y = 0.671 },
            { name = "Viscous Fallout",       floor = 2, x = 0.760, y = 0.469 },
            { name = "Electrocutioner 6000",  floor = 2, x = 0.245, y = 0.684 },
            { name = "Crowd Pummeler 9-60",   floor = 3, x = 0.434, y = 0.883 },
            { name = "Mekgineer Thermaplugg", floor = 4, x = 0.315, y = 0.299 },
        },
    },
    ["Razorfen Kraul"] = {
        floors = { { uiMapID = 301, tiles = "Interface\\WorldMap\\RazorfenKraul\\RazorfenKraul1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\RazorfenKraul1_s1", x0 = 0.2036, y0 = 0.2874, x1 = 0.2375, y1 = 0.3383 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\RazorfenKraul1_s2", x0 = 0.5589, y0 = 0.2874, x1 = 0.5928, y1 = 0.3383 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\RazorfenKraul1_s3", x0 = 0.8593, y0 = 0.3937, x1 = 0.8932, y1 = 0.4446 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\RazorfenKraul1_s4", x0 = 0.7914, y0 = 0.4955, x1 = 0.8253, y1 = 0.5464 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\RazorfenKraul1_s5", x0 = 0.0649, y0 = 0.6602, x1 = 0.0988, y1 = 0.7111 } } } },
        entrance = { floor = 1, x = 0.714, y = 0.840, angle = 180 },
        -- Ladder notes (no level change): how to get across to Roogug.
        transitions = {
            { floor = 1, x = 0.606, y = 0.725, note = true, labelKey = "MAP_RFK_WALLJUMP" },
            { floor = 1, x = 0.626, y = 0.562, note = true, labelKey = "MAP_RFK_VINE" },
        },
        bosses = {
            -- Roogug: alcove across the vine, first left after the entrance.
            { name = "Roogug",                 x = 0.646, y = 0.430 },
            { name = "Aggem Thorncurse",       x = 0.808, y = 0.521 },
            { name = "Death Speaker Jargba",   x = 0.876, y = 0.419 },
            { name = "Earthcaller Halmgar",    x = 0.498, y = 0.473 }, -- author's green mark
            { name = "Overlord Ramtusk",       x = 0.576, y = 0.313 },
            { name = "Charlga Razorflank",     x = 0.221, y = 0.313 },
            { name = "Agathelos the Raging",  x = 0.082, y = 0.686 },
        },
    },
    -- Loksey from Wowhead (zone 796 floor 2). Arcanist Doan has no published coordinates yet.
    ["Scarlet Monastery: Library"] = {
        floors = { { uiMapID = 303, tiles = "Interface\\WorldMap\\ScarletMonastery\\ScarletMonastery2_" } },
        bosses = {
            { name = "Houndmaster Loksey", x = 0.302, y = 0.846 },
            { name = "Arcanist Doan",      x = 0.835, y = 0.740 },
        },
    },
    -- Boss spots from Wowhead's map data (the same map art and coordinates the
    -- client uses). Whitemane waits in the round room behind the altar.
    ["Scarlet Monastery: Armory"] = {
        floors = { { uiMapID = 304, tiles = "Interface\\WorldMap\\ScarletMonastery\\ScarletMonastery3_" } },
        entrance = { floor = 1, x = 0.610, y = 0.945, angle = 0 },
        bosses = {
            { name = "Herod", x = 0.785, y = 0.118 },
        },
    },
    ["Scarlet Monastery: Cathedral"] = {
        floors = { { uiMapID = 305, tiles = "Interface\\WorldMap\\ScarletMonastery\\ScarletMonastery4_" } },
        entrance = { floor = 1, x = 0.618, y = 0.915, angle = 0 },
        bosses = {
            { name = "High Inquisitor Fairbanks",  x = 0.555, y = 0.250 },
            { name = "Scarlet Commander Mograine", x = 0.490, y = 0.285 },
            { name = "High Inquisitor Whitemane",  x = 0.490, y = 0.165 },
        },
    },
    -- Spots taken from the same encounters on Wowhead's map of this instance
    -- (Tuten'kash by the gong, Mordresh at the Bone Pile, Glutton on the
    -- spiral path, Amnennar on top of the Spiral of Thorns).
    ["Razorfen Downs"] = {
        floors = { { uiMapID = 300, tiles = "Interface\\WorldMap\\RazorfenDowns\\RazorfenDowns1_" } },
        entrance = { floor = 1, x = 0.234, y = 0.185, angle = 90 },
        bosses = {
            { name = "Tuten'kash",               x = 0.589, y = 0.342 },
            { name = "Mordresh Fire Eye",        x = 0.860, y = 0.467 },
            { name = "Glutton",                  x = 0.345, y = 0.664 },
            { name = "Amnennar the Coldbringer", x = 0.455, y = 0.582 },
        },
    },
    -- Uldaman and Zul'Farrak: boss spots from Wowhead's map data (same map art
    -- and coordinates as the client).
    ["Blackrock Depths"] = {
        floors = {
            { uiMapID = 242, tiles = "Interface\\WorldMap\\BlackrockDepths\\BlackrockDepths1_" },
            { uiMapID = 243, tiles = "Interface\\WorldMap\\BlackrockDepths\\BlackrockDepths2_" },
        },
        entrance = { floor = 1, x = 0.329, y = 0.794, angle = 0 }, -- the swirl in the Dark Iron Highway
        bosses = {
            { name = "High Interrogator Gerstahn", floor = 1, x = 0.474, y = 0.922 },
            { name = "Lord Roccor",                floor = 1, x = 0.556, y = 0.670 },
            { name = "Houndmaster Grebmar",        floor = 1, x = 0.535, y = 0.573 },
            { name = "Bael'Gar",                   floor = 1, x = 0.251, y = 0.534 },
            { name = "Lord Incendius",             floor = 1, x = 0.564, y = 0.311 },
            { name = "Fineous Darkvire",           floor = 1, x = 0.635, y = 0.211 },
            { name = "Gorosh the Dervish",         floor = 2, x = 0.530, y = 0.868 },
            { name = "Grizzle",                    floor = 2, x = 0.547, y = 0.883 },
            { name = "Eviscerator",                floor = 2, x = 0.547, y = 0.913 },
            { name = "Ok'thor the Breaker",        floor = 2, x = 0.530, y = 0.928 },
            { name = "Anub'shiah",                 floor = 2, x = 0.513, y = 0.913 },
            { name = "Hedrum the Creeper",         floor = 2, x = 0.513, y = 0.883 },
            { name = "Pyromancer Loregrain",       floor = 2, x = 0.549, y = 0.948 },
            { name = "Warder Stilgiss",            floor = 2, x = 0.602, y = 0.659 },
            { name = "General Angerforge",         floor = 2, x = 0.363, y = 0.823 },
            { name = "Golem Lord Argelmach",       floor = 2, x = 0.364, y = 0.651 },
            { name = "Hurley Blackbreath",         floor = 2, x = 0.505, y = 0.704 },
            { name = "Plugger Spazzring",          floor = 2, x = 0.477, y = 0.657 },
            { name = "Phalanx",                    floor = 2, x = 0.458, y = 0.564 },
            { name = "Ambassador Flamelash",       floor = 2, x = 0.538, y = 0.485 },
            { name = "The Seven",                  floor = 2, x = 0.538, y = 0.247 },
            { name = "Magmus",                     floor = 2, x = 0.796, y = 0.118 },
            { name = "Princess Moira Bronzebeard", floor = 2, x = 0.920, y = 0.110 },
            { name = "Emperor Dagran Thaurissan",  floor = 2, x = 0.909, y = 0.118 },
        },
    },
    ["Uldaman"] = {
        floors = {
            { uiMapID = 230, tiles = "Interface\\WorldMap\\Uldaman\\Uldaman1_" },
            { uiMapID = 231, tiles = "Interface\\WorldMap\\Uldaman\\Uldaman2_" },
        },
        entrance = { floor = 1, x = 0.679, y = 0.725, angle = 0 }, -- the swirl right of the Hall of the Keepers
        bosses = {
            { name = "The Lost Dwarves",     floor = 1, x = 0.584, y = 0.920 },
            { name = "Revelosh",             floor = 1, x = 0.534, y = 0.725 },
            { name = "Ironaya",              floor = 1, x = 0.372, y = 0.739 },
            { name = "Ancient Stone Keeper", floor = 1, x = 0.475, y = 0.440 },
            { name = "Galgann Firehammer",   floor = 1, x = 0.267, y = 0.327 },
            { name = "Grimlok",              floor = 1, x = 0.219, y = 0.256 },
            { name = "Archaedas",            floor = 2, x = 0.553, y = 0.504 },
        },
    },
    ["Zul'Farrak"] = {
        -- This client has no Zul'Farrak map, so the game's map art is bundled.
        floors = { { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\ZulFarrakMap", texBottom = 683 / 1024 } },
        entrance = { floor = 1, x = 0.552, y = 0.880, angle = 0 },
        bosses = {
            { name = "Antu'sul",              x = 0.646, y = 0.276 },
            { name = "Witch Doctor Zum'rah",  x = 0.442, y = 0.176 },
            { name = "Shadowpriest Sezz'ziz", x = 0.296, y = 0.174 },
            { name = "Gahz'rilla",            x = 0.312, y = 0.414 },
            { name = "Zerillis",              x = 0.548, y = 0.401 },
            { name = "Sandarr Dunereaver",    x = 0.524, y = 0.428 },
            { name = "Dustwraith",            x = 0.310, y = 0.160 },
            { name = "Ruuzlu",                x = 0.432, y = 0.342 },
            { name = "Chief Ukorz Sandscalp", x = 0.422, y = 0.329 },
        },
    },
    ["Scarlet Monastery: Graveyard"] = {
        floors = { { uiMapID = 302, tiles = "Interface\\WorldMap\\ScarletMonastery\\ScarletMonastery1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\ScarletMonastery1_s1", x0 = 0.2285, y0 = 0.5404, x1 = 0.2625, y1 = 0.5913 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\ScarletMonastery1_s2", x0 = 0.7066, y0 = 0.5749, x1 = 0.7405, y1 = 0.6257 } } } },
        entrance = { floor = 1, x = 0.841, y = 0.831, angle = 180 },
        bosses = {
            { name = "Interrogator Vishas", x = 0.724, y = 0.600 },
            { name = "Bloodmage Thalnos",   x = 0.246, y = 0.566 },
        },
    },
    ["Excavation Site: Wetlands"] = {
        floors = { { texture = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\ExcavationSiteMap", texBottom = 683 / 1024 } },
        entrance = { floor = 1, x = 0.888, y = 0.258, angle = 180, labelPos = "top" }, -- the swirl at the right of the map
        -- Boss spots as marked by Exehn on the map (2026-10-06).
        bosses = {
            { name = "Saltspine",       x = 0.550, y = 0.361 },
            { name = "Shadetooth",      x = 0.305, y = 0.484 },
            { name = "Relic Guardian",  x = 0.324, y = 0.687 },
        },
    },
    ["Ragefire Chasm"] = {
        floors = { { uiMapID = 213, tiles = "Interface\\WorldMap\\Ragefire\\Ragefire1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Ragefire1_s1", x0 = 0.5259, y0 = 0.2725, x1 = 0.5599, y1 = 0.3234 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Ragefire1_s2", x0 = 0.3752, y0 = 0.5584, x1 = 0.4092, y1 = 0.6093 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Ragefire1_s3", x0 = 0.6806, y0 = 0.6213, x1 = 0.7146, y1 = 0.6722 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Ragefire1_s4", x0 = 0.3253, y0 = 0.7904, x1 = 0.3593, y1 = 0.8413 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\Ragefire1_1", x0 = 0.0150, y0 = 0.0120, x1 = 0.5948, y1 = 0.1497 } } } },
        entrance = { floor = 1, x = 0.610, y = 0.075, angle = 200 },
        bosses = {
            { name = "Oggleflint",             x = 0.561, y = 0.378 },
            { name = "Taragaman the Hungerer", x = 0.405, y = 0.570 },
            { name = "Jergosh the Invoker",    x = 0.340, y = 0.815 },
            { name = "Bazzalan",               x = 0.422, y = 0.842 },
        },
    },
    ["The Deadmines"] = {
        -- Green "go to next level" arrows: where each level continues.
        transitions = {
            { floor = 1, to = 2, x = 0.615, y = 0.610 },
        },
        floors = {
            { uiMapID = 291, tiles = "Interface\\WorldMap\\TheDeadmines\\TheDeadmines1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\TheDeadmines1_s1", x0 = 0.3313, y0 = 0.5898, x1 = 0.3653, y1 = 0.6407 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\TheDeadmines1_s2", x0 = 0.4721, y0 = 0.8413, x1 = 0.5060, y1 = 0.8922 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\TheDeadmines1_1", x0 = 0.3194, y0 = 0.0150, x1 = 0.6996, y1 = 0.1347 } } },
            { uiMapID = 292, tiles = "Interface\\WorldMap\\TheDeadmines\\TheDeadmines2_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\TheDeadmines2_s1", x0 = 0.1088, y0 = 0.7365, x1 = 0.1427, y1 = 0.7874 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\TheDeadmines2_s2", x0 = 0.5908, y0 = 0.3428, x1 = 0.6248, y1 = 0.3937 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\TheDeadmines2_s3", x0 = 0.5650, y0 = 0.4160, x1 = 0.6110, y1 = 0.4840, alpha = 1.0 } } },
        },
        entrance = { floor = 1, x = 0.295, y = 0.135, angle = -15 },
        bosses = {
            { name = "Rhahk'Zor",         floor = 1, x = 0.365, y = 0.610 },
            { name = "Miner Johnson",     floor = 1, x = 0.535, y = 0.520 },
            { name = "Sneed's Shredder",  floor = 1, x = 0.475, y = 0.865 },
            { name = "Sneed",             floor = 1, x = 0.535, y = 0.865 },
            { name = "Gilnid",            floor = 2, x = 0.122, y = 0.755 },
            { name = "Mr. Smite",         floor = 2, x = 0.515, y = 0.170 },
            { name = "Captain Greenskin", floor = 2, x = 0.575, y = 0.350 },
            { name = "Edwin VanCleef",    floor = 2, x = 0.605, y = 0.452 },
            { name = "Cookie",            floor = 2, x = 0.665, y = 0.430 },
        },
    },
    ["Wailing Caverns"] = {
        floors = { { uiMapID = 279, tiles = "Interface\\WorldMap\\WailingCaverns\\WailingCaverns1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\WailingCaverns1_s2", x0 = 0.1786, y0 = 0.3783, x1 = 0.1998, y1 = 0.4186 } } } }, -- hides one printed skull west of Lady Anacondra
        entrance = { floor = 1, x = 0.465, y = 0.590, angle = 200 },
        -- Route: Anacondra on the west side of the first big chamber, drop
        -- into the ravine west to Cobrahn, back through the river (Kresh),
        -- then east: Pythas, Skum, the Faerie Dragon's caves and the Crag of
        -- the Everliving where Serpentis stands right before Verdan. Mutanus
        -- appears at Naralex after the escort.
        bosses = {
            { name = "Lady Anacondra",        x = 0.310, y = 0.430 },
            { name = "Kresh",                 x = 0.385, y = 0.350 },
            { name = "Lord Cobrahn",          x = 0.155, y = 0.570 },
            { name = "Lord Pythas",           x = 0.620, y = 0.657 },
            { name = "Skum",                  x = 0.622, y = 0.734 },
            { name = "Deviate Faerie Dragon", x = 0.580, y = 0.600 },
            { name = "Lord Serpentis",        x = 0.615, y = 0.535 },
            { name = "Verdan the Everliving", x = 0.545, y = 0.460 },
            { name = "Mutanus the Devourer",  x = 0.345, y = 0.130 },
        },
    },
    ["Shadowfang Keep"] = {
        -- Three levels are shown: The Courtyard, The Wall Walk and Arugal's Chamber
        -- (map tiles 1, 7, 6). The Dining Hall page was removed at the author's request.
        -- Ladder positions are approximate.
        transitions = {
            { floor = 1, to = 2, x = 0.145, y = 0.864, dir = "up" }, -- stairs behind Baron Silverlaine, up to the wall walk
            { floor = 2, to = 3, x = 0.515, y = 0.915, dir = "up" }, -- from the terrace into the tower
        },
        floors = {
            { uiMapID = 310, tiles = "Interface\\WorldMap\\ShadowfangKeep\\ShadowfangKeep1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\ShadowfangKeep1_s1", x0 = 0.2525, y0 = 0.5554, x1 = 0.2864, y1 = 0.6063 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\ShadowfangKeep1_s2", x0 = 0.6497, y0 = 0.6961, x1 = 0.6836, y1 = 0.7470 } } },
            { uiMapID = 316, tiles = "Interface\\WorldMap\\ShadowfangKeep\\ShadowfangKeep7_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\ShadowfangKeep7_s1", x0 = 0.5659, y0 = 0.8024, x1 = 0.5998, y1 = 0.8533 } } },
            { uiMapID = 315, tiles = "Interface\\WorldMap\\ShadowfangKeep\\ShadowfangKeep6_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\ShadowfangKeep6_s1", x0 = 0.6677, y0 = 0.3084, x1 = 0.7016, y1 = 0.3593 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\ShadowfangKeep6_s2", x0 = 0.5289, y0 = 0.6018, x1 = 0.5629, y1 = 0.6527 } } },
        },
        entrance = { floor = 1, x = 0.705, y = 0.605, angle = 0 },
        -- Deathstalkers in Shadowfang is handed in to Deathstalker Vincent,
        -- lying just inside the courtyard, right of the steps up from
        -- Rethilgore's jail (straight ahead of the entrance, past the gate).
        turnins = {
            { npc = "Deathstalker Vincent", floor = 1, x = 0.558, y = 0.622 },
        },
        -- Pins on a printed map marker sit exactly on it; the rest follow the
        -- boss positions published for the Forever client.
        bosses = {
            { name = "Rethilgore",                 floor = 1, x = 0.670, y = 0.715 },
            { name = "Fel Steed / Shadow Charger", floor = 1, x = 0.345, y = 0.635 },
            { name = "Razorclaw the Butcher",      floor = 1, x = 0.327, y = 0.447 },
            { name = "Baron Silverlaine",          floor = 1, x = 0.162, y = 0.807 },
            { name = "Deathsworn Captain",         floor = 2, x = 0.630, y = 0.525 },
            { name = "Odo the Blindwatcher",       floor = 2, x = 0.583, y = 0.828 },
            { name = "Fenrus the Devourer",        floor = 3, x = 0.546, y = 0.627 },
            { name = "Arugal's Voidwalker",        floor = 3, x = 0.492, y = 0.710 },
            { name = "Wolf Master Nandos",         floor = 3, x = 0.590, y = 0.533 },
            { name = "Archmage Arugal",            floor = 3, x = 0.685, y = 0.334 },
        },
    },
    ["The Stockade"] = {
        floors = { { uiMapID = 225, tiles = "Interface\\WorldMap\\TheStockade\\TheStockade1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\TheStockade1_s1", x0 = 0.7685, y0 = 0.4311, x1 = 0.8024, y1 = 0.4820 } } } },
        entrance = { floor = 1, x = 0.500, y = 0.815, angle = 0 },
        bosses = {
            { name = "Targorr the Dread",   x = 0.440, y = 0.445 },
            { name = "Kam Deepfury",        x = 0.320, y = 0.380 },
            { name = "Hamhock",             x = 0.780, y = 0.455 },
            { name = "Bazil Thredd",        x = 0.215, y = 0.255 },
            { name = "Dextren Ward",        x = 0.735, y = 0.575 },
            { name = "Bruegal Ironknuckle", x = 0.500, y = 0.190 },
        },
    },
    ["Blackfathom Deeps"] = {
        transitions = {
            { floor = 1, to = 2, x = 0.615, y = 0.700 },
            { floor = 2, to = 3, x = 0.470, y = 0.700, labelKey = "MAP_SWIM_LEVEL" },
        },
        floors = {
            { uiMapID = 221, tiles = "Interface\\WorldMap\\BlackFathomDeeps\\BlackFathomDeeps1_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps1_s1", x0 = 0.0818, y0 = 0.3728, x1 = 0.1158, y1 = 0.4237 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps1_s2", x0 = 0.3114, y0 = 0.5793, x1 = 0.3453, y1 = 0.6302 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps1_s3", x0 = 0.5289, y0 = 0.5479, x1 = 0.5629, y1 = 0.5988 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps1_1", x0 = 0.2146, y0 = 0.0075, x1 = 0.4391, y1 = 0.1093 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps1_2", x0 = 0.4691, y0 = 0.0075, x1 = 0.8044, y1 = 0.1093 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps1_3", x0 = 0.4242, y0 = 0.0075, x1 = 0.4890, y1 = 0.0719 } } },
            { uiMapID = 222, tiles = "Interface\\WorldMap\\BlackFathomDeeps\\BlackFathomDeeps2_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps2_s1", x0 = 0.5090, y0 = 0.7934, x1 = 0.5429, y1 = 0.8443 }, { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps2_s2", x0 = 0.8263, y0 = 0.8398, x1 = 0.8603, y1 = 0.8907 } } },
            { uiMapID = 223, tiles = "Interface\\WorldMap\\BlackFathomDeeps\\BlackFathomDeeps3_", patches = { { tex = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\MapPatches\\BlackFathomDeeps3_s1", x0 = 0.5569, y0 = 0.2799, x1 = 0.5908, y1 = 0.3308 } } },
        },
        entrance = { floor = 1, x = 0.455, y = 0.085, angle = -20 },
        -- Quest objectives you click or loot on the spot (not kills / drops):
        -- now FDJ.MAP_QUEST_PINS (Data/QuestMaps.lua), with the other quests'.
        -- objectives = {
        --     { floor = 1, x = 0.330, y = 0.413, questID = 971, quest = "Knowledge in the Deeps", textKey = "MAP_OBJ_BFD_CHEST" },
        --     { floor = 2, x = 0.414, y = 0.754, questID = 6921, quest = "Amongst the Ruins", textKey = "MAP_OBJ_BFD_FATHOM" },
        -- },
        bosses = {
            { name = "Ghamoo-ra",            floor = 1, x = 0.325, y = 0.605 },
            { name = "Lady Sarevess",        floor = 1, x = 0.110, y = 0.385 },
            { name = "Gelihast",             floor = 1, x = 0.540, y = 0.575 },
            { name = "Lorgus Jett",          floor = 2, x = 0.325, y = 0.700 },
            { name = "Baron Aquanis",        floor = 2, x = 0.420, y = 0.720, npcID = 12876 }, -- not a journal boss: portrait from its NPC ID
            { name = "Twilight Lord Kelris", floor = 2, x = 0.525, y = 0.810 },
            { name = "Aku'mai",              floor = 2, x = 0.855, y = 0.860 },
            { name = "Old Serra'kis",        floor = 3, x = 0.585, y = 0.290 },
        },
    },
    -- Maps added 1.6.5: client map art by UiMapID (floor order and boss spots
    -- from Wowhead's map data and the Classic spawn database, converted with
    -- the client's own UiMapAssignment regions).
    ["Dire Maul: North"] = {
        entrance = { floor = 1, x = 0.717, y = 0.924, angle = 0 },
        floors = { { uiMapID = 235, tiles = "Interface\\WorldMap\\DireMaul\\DireMaul1_" } }, -- Gordok Commons
        bosses = {
            { name = "Guard Mol'dar",          x = 0.695, y = 0.760 },
            { name = "Stomper Kreeg",          x = 0.612, y = 0.692 },
            { name = "Guard Fengus",           x = 0.494, y = 0.780 },
            { name = "Guard Slip'kik",         x = 0.266, y = 0.571 },
            { name = "Captain Kromcrush",      x = 0.318, y = 0.506 },
            { name = "Cho'Rush the Observer",  x = 0.300, y = 0.290 },
            { name = "King Gordok",            x = 0.319, y = 0.229 },
        },
    },
    ["Dire Maul: West"] = {
        entrance = { floor = 1, x = 0.935, y = 0.507, angle = 180, labelPos = "top" },
        floors = {
            { uiMapID = 236, tiles = "Interface\\WorldMap\\DireMaul\\DireMaul2_" }, -- Capital Gardens
            { uiMapID = 237, tiles = "Interface\\WorldMap\\DireMaul\\DireMaul3_" }, -- Court of the Highborne
            { uiMapID = 238, tiles = "Interface\\WorldMap\\DireMaul\\DireMaul4_" }, -- Prison of Immol'thar
        },
        bosses = {
            { name = "Tendris Warpwood",   floor = 1, x = 0.336, y = 0.536 },
            { name = "Illyanna Ravenoak",  floor = 1, x = 0.203, y = 0.776 },
            { name = "Magister Kalendris", floor = 2, x = 0.338, y = 0.450 },
            { name = "Tsu'zee",            floor = 2, x = 0.322, y = 0.143 },
            { name = "Immol'thar",         floor = 3, x = 0.349, y = 0.575 },
            { name = "Prince Tortheldrin", floor = 3, x = 0.622, y = 0.231 },
        },
    },
    ["Dire Maul: East"] = {
        entrance = { floor = 1, x = 0.281, y = 0.554, angle = 180 },
        floors = {
            { uiMapID = 240, tiles = "Interface\\WorldMap\\DireMaul\\DireMaul6_" }, -- The Shrine of Eldretharr
            { uiMapID = 239, tiles = "Interface\\WorldMap\\DireMaul\\DireMaul5_" }, -- Warpwood Quarter
        },
        bosses = {
            { name = "Lethtendris",           floor = 2, x = 0.438, y = 0.481 },
            { name = "Zevrim Thornhoof",      floor = 1, x = 0.575, y = 0.743 },
            { name = "Hydrospawn",            floor = 1, x = 0.536, y = 0.715 },
            { name = "Alzzin the Wildshaper", floor = 1, x = 0.566, y = 0.288 },
        },
    },
    ["Maraudon"] = {
        -- Two entrances (both on level 1), labelled by their portal colour.
        entrance = { floor = 1, x = 0.618, y = 0.281, angle = 0 },
        entrances = {
            { floor = 1, x = 0.618, y = 0.281, angle = 0, labelKey = "MAP_ENTRANCE_ORANGE", color = { 1.00, 0.55, 0.10 } },
            { floor = 1, x = 0.764, y = 0.659, angle = 0, labelKey = "MAP_ENTRANCE_PURPLE", color = { 0.78, 0.45, 1.00 } },
        },
        floors = {
            { uiMapID = 280, tiles = "Interface\\WorldMap\\Maraudon\\Maraudon1_" },
            { uiMapID = 281, tiles = "Interface\\WorldMap\\Maraudon\\Maraudon2_" },
        },
        bosses = {
            { name = "Noxxion",               floor = 1, x = 0.362, y = 0.098 },
            { name = "Razorlash",             floor = 1, x = 0.166, y = 0.344 },
            { name = "Lord Vyletongue",       floor = 1, x = 0.378, y = 0.704 },
            { name = "Meshlok the Harvester", floor = 1, x = 0.246, y = 0.874 },
            { name = "Celebras the Cursed",   floor = 2, x = 0.245, y = 0.143 },
            { name = "Landslide",             floor = 2, x = 0.408, y = 0.487 },
            { name = "Tinkerer Gizlock",      floor = 2, x = 0.484, y = 0.686 },
            { name = "Rotgrip",               floor = 2, x = 0.413, y = 0.817 },
            { name = "Princess Theradras",    floor = 2, x = 0.258, y = 0.788 },
        },
    },
    ["Stratholme: Living"] = {
        entrance = { floor = 1, x = 0.675, y = 0.877, angle = 0 },
        floors = { { uiMapID = 317, tiles = "Interface\\WorldMap\\Stratholme\\Stratholme1_" } },
        bosses = {
            { name = "Skul",                   x = 0.574, y = 0.652 },
            { name = "Hearthsinger Forresten", x = 0.605, y = 0.327 },
            { name = "The Unforgiven",         x = 0.734, y = 0.204 },
            { name = "Timmy the Cruel",        x = 0.495, y = 0.180 },
            { name = "Postmaster Malown",      x = 0.558, y = 0.684 },
            { name = "Cannon Master Willey",   x = 0.042, y = 0.510 },
            { name = "Archivist Galford",      x = 0.272, y = 0.750 },
            { name = "Balnazzar",              x = 0.204, y = 0.818 },
        },
    },
    ["Stratholme: Undead"] = {
        entrance = { floor = 1, x = 0.658, y = 0.902, angle = 0 },
        floors = { { uiMapID = 318, tiles = "Interface\\WorldMap\\Stratholme\\Stratholme2_" } },
        bosses = {
            { name = "Magistrate Barthilas", x = 0.566, y = 0.161 },
            { name = "Stonespine",           x = 0.649, y = 0.489 },
            { name = "Nerub'enkan",          x = 0.572, y = 0.461 },
            { name = "Baroness Anastari",    x = 0.745, y = 0.469 },
            { name = "Maleki the Pallid",    x = 0.674, y = 0.227 },
            { name = "Ramstein the Gorger",  x = 0.456, y = 0.198 },
            { name = "Baron Rivendare",      x = 0.372, y = 0.199 },
        },
    },
    ["Sunken Temple"] = {
        floors = { { uiMapID = 220, tiles = "Interface\\WorldMap\\TheTempleOfAtalHakkar\\TheTempleOfAtalHakkar1_" } },
        bosses = {
            { name = "Avatar of Hakkar",       x = 0.243, y = 0.459 },
            { name = "Jammal'an the Prophet",  x = 0.760, y = 0.370 },
            { name = "Ogom the Wretched",      x = 0.780, y = 0.385 },
            -- The four dragonkin wait together on the same ledge.
            { name = "Dreamscythe",            x = 0.430, y = 0.865 },
            { name = "Weaver",                 x = 0.478, y = 0.830 },
            { name = "Morphaz",                x = 0.461, y = 0.845 },
            { name = "Hazzas",                 x = 0.448, y = 0.851 },
            { name = "Shade of Eranikus",      x = 0.686, y = 0.874 },
        },
    },
}

local function LanguageDisplayName(locale)
    for _, info in ipairs(LANGUAGE_CHOICES) do
        if info.locale == locale then return info.label end
    end
    return "English"
end

local function GetLanguageIndex(locale)
    for i, info in ipairs(LANGUAGE_CHOICES) do
        if info.locale == locale then return i end
    end
    return 1
end

local function UpdateLanguageControl()
    if not frame or not frame.languageSelectorText then return end
    local active = FDJ.GetLanguage and FDJ.GetLanguage() or "enUS"
    frame.languageSelectorText:SetText(LanguageDisplayName(active))
end


local function UpdateQuestActionButtonSizes()
    if not frame then return end

    if frame.questMapButton then
        local mapText = L(frame.questMapButton.fdjLabelKey or "SHOW_ON_MAP") or ""
        frame.questMapButton:SetText(mapText)
        local fs = frame.questMapButton:GetFontString()
        local textWidth = fs and fs:GetStringWidth() or 0
        local iconPad = (frame.questMapButton.icon and frame.questMapButton.icon:IsShown()) and 20 or 0
        local width = math.max(96, math.min(frame.questMapButton.fdjLabelKey and 210 or 150, math.ceil(textWidth + 24 + iconPad)))
        frame.questMapButton:SetWidth(width)
    end

    if frame.questTurninMapButton then
        frame.questTurninMapButton:SetText(L("SHOW_TURN_IN") or "")
        local fs = frame.questTurninMapButton:GetFontString()
        local textWidth = fs and fs:GetStringWidth() or 0
        frame.questTurninMapButton:SetWidth(math.max(96, math.min(210, math.ceil(textWidth + 24 + 20))))
    end

    if frame.questChainButton then
        local chainText = L("SHOW_QUEST_CHAIN") or ""
        frame.questChainButton:SetText(chainText)
        local fs = frame.questChainButton:GetFontString()
        local textWidth = fs and fs:GetStringWidth() or 0
        local width = math.max(112, math.min(170, math.ceil(textWidth + 40)))
        frame.questChainButton:SetWidth(width)
        if frame.questChainButton.icon then
            frame.questChainButton.icon:ClearAllPoints()
            frame.questChainButton.icon:SetPoint("RIGHT", -7, 0)
        end
        if fs then
            fs:ClearAllPoints()
            fs:SetPoint("CENTER", frame.questChainButton, "CENTER", -9, 0)
        end
    end
end

local function ApplyLocaleFontTree(root)
    -- Intentionally left as a no-op. All localized FontStrings now keep their
    -- native Blizzard font objects. Previous runtime font swapping for Chinese
    -- could leak font file/size state into other languages after switching.
    -- With Chinese disabled for this release, mutating fonts at runtime is both
    -- unnecessary and less stable than leaving Blizzard's font objects intact.
    return
end

local compareTooltip1
local compareTooltip2
local dungeonTabs = {}
local bossButtons = {}
local lootRows = {}
local questButtons = {}
local questRewardButtons = {}
local questNoteRewardButtons = {}
local visibleQuestIndexes = {}
local journalCache = {}
-- v0.7.0 could save a previous creature's display under the next NPC's ID.
-- Discard only that derived cache once; keep all user settings.
if ForeverDungeonJournalDB.portraitCacheVersion ~= 2 then
    ForeverDungeonJournalDB.displayIDs = {}
    ForeverDungeonJournalDB.portraitCacheVersion = 2
end
ForeverDungeonJournalDB.displayIDs = ForeverDungeonJournalDB.displayIDs or {}

local displayIDCache = ForeverDungeonJournalDB.displayIDs

-- Exact 2D unit portraits captured from the client, keyed ONLY by numeric NPC ID.
-- This avoids comparing UnitName() values (which can be secret strings in Forever)
-- and cannot accidentally assign one boss portrait to another boss by name.
ForeverDungeonJournalDB.portraitTexturesByNpcID = ForeverDungeonJournalDB.portraitTexturesByNpcID or {}
local portraitTexturesByNpcID = ForeverDungeonJournalDB.portraitTexturesByNpcID
-- v1.0.21 removes live target/mouseover boss learning entirely.
-- Clear the two stale learning tables so an old bad portrait (notably Lordaeron Captain)
-- can never override the deterministic bundled portrait again.
ForeverDungeonJournalDB.learnedNpcIDs = nil
ForeverDungeonJournalDB.portraitFileIDs = nil

local function BossNpcID(boss)
    if not boss then return nil end
    -- Boss identity is deterministic: only IDs bundled in the addon are used.
    -- We no longer learn NPC IDs from target/mouseover/nameplates.
    return boss.npcID
end

-- Portraits are deterministic in v1.0.22. Legacy bosses use bundled
-- CreatureDisplayIDs; Forever bosses use Blizzard Encounter Journal display data
-- when available, plus bundled fallback art where needed. No live unit learning.
local portraitResolver
local portraitResolveQueue = {}
local portraitResolveQueued = {}
local portraitResolveCurrent
local portraitResolveSerial = 0
local portraitModels = {}
local portraitRetryAt = {}
local portraitResolveBlockedUntil = 0

-- Direct 2D boss portraits. These CreatureDisplayIDs are bundled with the
-- addon so legacy dungeon bosses never need PlayerModel:SetCreature() or any
-- hidden 3D model work. Forever-specific bosses use Encounter Journal display
-- data or explicit bundled portrait art.
-- ============================================================
-- BASIC HELPERS
-- ============================================================

local function SetBackdrop(f, bg, border, edge, inset)
    f:SetBackdrop({
        bgFile = bg,
        edgeFile = border,
        tile = true,
        tileSize = 16,
        edgeSize = edge or 12,
        insets = {
            left = inset or 3,
            right = inset or 3,
            top = inset or 3,
            bottom = inset or 3,
        },
    })
end

local function AddClassicParchment(frameObj, alpha, r, g, b)
    local tex = frameObj:CreateTexture(nil, "BACKGROUND", nil, -2)
    tex:SetPoint("TOPLEFT", 3, -3)
    tex:SetPoint("BOTTOMRIGHT", -3, 3)
    tex:SetTexture("Interface\\QuestFrame\\QuestBG")
    tex:SetTexCoord(0, 1, 0, 1)
    tex:SetVertexColor(r or 1, g or 0.96, b or 0.84)
    tex:SetAlpha(alpha or 0.16)
    return tex
end

local function ItemInfo(id)
    if C_Item and C_Item.GetItemInfo then
        return C_Item.GetItemInfo(id)
    end
end

local function ItemIcon(id)
    if C_Item and C_Item.GetItemInfoInstant then
        local _, _, _, _, icon = C_Item.GetItemInfoInstant(id)
        if icon then return icon end
    end

    if C_Item and C_Item.GetItemIconByID then
        local icon = C_Item.GetItemIconByID(id)
        if icon then return icon end
    end

    return "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function QualityColor(q)
    if GetItemQualityColor then
        local r, g, b = GetItemQualityColor(q or 3)
        if r then return r, g, b end
    end
    return 0, 0.44, 0.87
end

FDJ.StartsInsideDungeon = function(pickupText)
    if type(pickupText) ~= "string" then return false end
    local text = string.lower(pickupText)
    return text:find("inside ", 1, true) ~= nil
end

-- A quest started by an item that drops in the dungeon (from one of its
-- bosses or its trash) starts inside too, whatever its text says.
FDJ.StartItemDropsIn = function(quest, dungeonName)
    local item = type(quest) == "table" and quest.startItem
    local id = type(item) == "table" and item[1]
    local dungeon = id and dungeonName and DB[dungeonName]
    if type(dungeon) ~= "table" then return false end
    for _, boss in ipairs(dungeon.bosses or {}) do
        for _, loot in ipairs(type(boss) == "table" and boss.loot or {}) do
            if type(loot) == "table" and loot[1] == id then return true end
        end
    end
    return false
end

-- A quest that needs a chain first is picked up where its chain starts:
-- the chain's first step (pendingOnly, for the tracker: the first step not
-- handed in yet). True/false; nil without a chain, or with every step done.
FDJ.ChainStartsInside = function(quest, dungeonName, pendingOnly)
    local chain = type(quest) == "table" and quest.id and QUEST_PREREQ_CHAINS[quest.id]
    if type(chain) ~= "table" or #chain == 0 then return nil end
    for _, step in ipairs(chain) do
        if type(step) == "table" and step.id ~= quest.id and not (pendingOnly and step.id
            and not step.itemStep and FDJ.QuestTurnedIn and FDJ.QuestTurnedIn(step.id)) then
            local details = (step.id and QUEST_PREREQ_DETAILS[step.id]) or {}
            return details.startsInDungeon == true or FDJ.StartsInsideDungeon(details.pickup)
                or FDJ.StartItemDropsIn(details, dungeonName)
        end
    end
    return nil
end

-- Quest list rows: a small dungeon icon after "Available from Level X" for
-- quests that are picked up inside the dungeon (same icon as the quest page).
FDJ.SetRowDungeonIcon = function(button, show, offsetX)
    local icon = button.dungeonStartIcon
    if not show then
        if icon then icon:Hide() end
        return
    end
    if not icon then
        icon = CreateFrame("Frame", nil, button)
        button.dungeonStartIcon = icon
        icon:SetSize(26, 26)
        icon:SetFrameLevel(button:GetFrameLevel() + 6)
        icon:EnableMouse(true)
        icon.tex = icon:CreateTexture(nil, "OVERLAY")
        icon.tex:SetAllPoints()
        local ok = icon.tex.SetAtlas and pcall(icon.tex.SetAtlas, icon.tex, "Dungeon", false)
        if not ok then
            icon.tex:SetTexture("Interface\\Icons\\INV_Misc_Rune_01")
            icon.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        end
        icon:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(L("IN_DUNGEON"))
            GameTooltip:Show()
        end)
        icon:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    icon:ClearAllPoints()
    icon:SetPoint("LEFT", button.meta, "LEFT", offsetX, 0)
    icon:Show()
end

FDJ.PositionInDungeonIcon = function()
    if not frame or not frame.questStartDungeonIcon or not frame.questStartsHeader then return end
    frame.questStartDungeonIcon:ClearAllPoints()
    frame.questStartDungeonIcon:SetPoint("LEFT", frame.questStartsHeader, "RIGHT", 6, 0)
    frame.questStartDungeonIcon:Show()
end

local function ItemLinkColor(link)
    if type(link) ~= "string" then return nil end
    local hex = link:match("|cff(%x%x%x%x%x%x)")
    if not hex then return nil end
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    if not r or not g or not b then return nil end
    return r / 255, g / 255, b / 255
end

local itemTooltipQualityCache = {}
local qualityScanTooltip

local function ExtractRGB(color)
    if not color then return nil end
    if type(color) == "table" then
        if type(color.GetRGB) == "function" then
            local ok, r, g, b = pcall(color.GetRGB, color)
            if ok and type(r) == "number" and type(g) == "number" and type(b) == "number" then
                return r, g, b
            end
        end
        if type(color.r) == "number" and type(color.g) == "number" and type(color.b) == "number" then
            return color.r, color.g, color.b
        end
    end
    return nil
end

local function GetTooltipRenderedItemColor(itemID)
    if not itemID then return nil end

    local cached = itemTooltipQualityCache[itemID]
    if cached then return cached[1], cached[2], cached[3] end

    -- Best source: the same tooltip-data pipeline WoW uses to draw the item.
    -- This deliberately avoids trusting stale Forever item-quality metadata.
    if C_TooltipInfo and type(C_TooltipInfo.GetItemByID) == "function" then
        local ok, data = pcall(C_TooltipInfo.GetItemByID, itemID)
        if ok and type(data) == "table" and type(data.lines) == "table" and data.lines[1] then
            local line = data.lines[1]
            local r, g, b = ExtractRGB(line.leftColor or line.color)
            -- Not loaded yet: the title is the red "Retrieving item
            -- information" placeholder. Never cache that colour.
            local text = line.leftText or line.text
            if RETRIEVING_ITEM_INFO and text == RETRIEVING_ITEM_INFO then r = nil end
            if r then
                itemTooltipQualityCache[itemID] = {r, g, b}
                return r, g, b
            end
        end
    end

    -- Fallback for Forever builds where C_TooltipInfo does not expose colors:
    -- render the item into an invisible GameTooltip and read the title color.
    if CreateFrame and UIParent then
        if not qualityScanTooltip then
            qualityScanTooltip = CreateFrame(
                "GameTooltip",
                "ForeverDungeonJournalQualityScanTooltip",
                UIParent,
                "GameTooltipTemplate"
            )
        end

        qualityScanTooltip:Hide()
        qualityScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        if qualityScanTooltip.ClearLines then qualityScanTooltip:ClearLines() end

        local ok = pcall(qualityScanTooltip.SetHyperlink, qualityScanTooltip, "item:" .. tostring(itemID))
        if ok then
            local line = _G["ForeverDungeonJournalQualityScanTooltipTextLeft1"]
            if line and line.GetTextColor and line.GetText and line:GetText() and line:GetText() ~= ""
                and not (RETRIEVING_ITEM_INFO and line:GetText() == RETRIEVING_ITEM_INFO) then
                local r, g, b = line:GetTextColor()
                qualityScanTooltip:Hide()
                if type(r) == "number" and type(g) == "number" and type(b) == "number" then
                    itemTooltipQualityCache[itemID] = {r, g, b}
                    return r, g, b
                end
            end
        end
        qualityScanTooltip:Hide()
    end

    if C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
        pcall(C_Item.RequestLoadItemDataByID, itemID)
    end
    return nil
end

local function GetAuthoritativeItemQuality(itemID, link, apiQuality, fallbackQuality)
    -- The journal should match the color the actual in-game tooltip renders.
    -- This is authoritative for ALL loot/reward items, including Forever
    -- quality changes that differ from Classic-era databases or item links.
    -- The tooltip color is authoritative (Forever's own shades of green etc.
    -- differ from the stock quality colors), except RED: no item quality is
    -- red, so a red title means something else tinted it (another addon, or a
    -- weapon the character cannot use). Then fall back to the item's quality.
    local tr, tg, tb = GetTooltipRenderedItemColor(itemID)
    if tr then
        local isRed = tr > 0.8 and tg < 0.45 and tb < 0.45
        if not isRed then return tr, tg, tb end
        itemTooltipQualityCache[itemID] = nil
    end

    -- Deviate Hide Pack (918) is Common/white. The Forever tooltip is the
    -- authority above; this is only a safe fallback while item data loads.
    if itemID == 918 then
        return 1.00, 1.00, 1.00
    end

    -- Confirmed in the Forever client: Fel Steed Saddlebags (932) is Uncommon/green.
    -- Force the journal row to match the actual item tooltip instead of stale quality cache data.
    if itemID == 932 then
        return 0.12, 1.00, 0.00
    end

    -- Confirmed Forever override: Small Sack of Gems (280567) is Common/white.
    -- Some Forever beta caches have exposed an incorrect higher-quality color.
    if itemID == 280567 then
        return 1.00, 1.00, 1.00
    end

    -- Confirmed Forever override: Snakeskin Bag (6446) is Uncommon/green.
    -- Some beta caches have reported a stale Rare color for this item.
    if itemID == 6446 then
        -- Do not route this override back through GetItemQualityColor().
        -- The Forever beta has returned inconsistent quality metadata for
        -- this legacy item across sessions.  The item itself is Uncommon,
        -- so force the standard WoW uncommon green for the journal row.
        return 0.12, 1.00, 0.00
    end

    -- Prefer the actual item-quality value returned by the client.  Some
    -- Forever beta item links can carry stale Classic/TBC color codes, so the
    -- link color must not override the numeric quality.
    if type(apiQuality) == "number" then
        return QualityColor(apiQuality)
    end

    if C_Item and type(C_Item.GetItemQualityByID) == "function" then
        local ok, value = pcall(C_Item.GetItemQualityByID, itemID)
        if ok and type(value) == "number" then
            return QualityColor(value)
        end
    end

    local lr, lg, lb = ItemLinkColor(link)
    if lr then return lr, lg, lb end

    return QualityColor(fallbackQuality or 1)
end

-- Reuse the exact same quality-colour logic outside Journal.lua (for example
-- the Favourites popup) so an item cannot be Rare/blue in a boss loot table
-- but Uncommon/green in Favourites because of stale Forever item metadata.
FDJ.GetAuthoritativeItemQuality = GetAuthoritativeItemQuality

local function NormalizeDungeonName(name)
    if type(name) ~= "string" then return nil end

    local n = name:lower()
    if n:find("ragefire chasm", 1, true) then
        return "Ragefire Chasm"
    end
    if n:find("hall of thanes", 1, true) then
        return "Hall of Thanes"
    end
    if n:find("deadmines", 1, true) then
        return "The Deadmines"
    end
    if n:find("wailing caverns", 1, true) then
        return "Wailing Caverns"
    end
    if n:find("shadowfang keep", 1, true) or n:find("shadowfang", 1, true) then
        return "Shadowfang Keep"
    end
    if n:find("ruins of lordaeron", 1, true) then
        return "Ruins of Lordaeron"
    end
    if n:find("blackfathom deeps", 1, true) or n:find("blackfathom depths", 1, true) then
        return "Blackfathom Deeps"
    end
    if n:find("stockade", 1, true) then
        return "The Stockade"
    end
    if n:find("excavation site", 1, true) and n:find("wetlands", 1, true) then
        return "Excavation Site: Wetlands"
    end
    if n:find("city of dalaran", 1, true) then
        return "City of Dalaran"
    end
    if n:find("gnomeregan", 1, true) then
        return "Gnomeregan"
    end
    if n:find("razorfen kraul", 1, true) then
        return "Razorfen Kraul"
    end
    if n:find("scarlet monastery", 1, true) and n:find("graveyard", 1, true) then
        return "Scarlet Monastery: Graveyard"
    end
    if n:find("scarlet monastery", 1, true) and n:find("library", 1, true) then
        return "Scarlet Monastery: Library"
    end
    if n:find("scarlet monastery", 1, true) and n:find("armory", 1, true) then
        return "Scarlet Monastery: Armory"
    end
    if n:find("scarlet monastery", 1, true) and n:find("cathedral", 1, true) then
        return "Scarlet Monastery: Cathedral"
    end
    if n:find("razorfen downs", 1, true) then
        return "Razorfen Downs"
    end
    if n:find("uldaman", 1, true) then
        return "Uldaman"
    end
    if n:find("zul'farrak", 1, true) or n:find("zulfarrak", 1, true) then
        return "Zul'Farrak"
    end
    if n:find("sunken temple", 1, true) or n:find("atal'hakkar", 1, true) then
        return "Sunken Temple"
    end
    if n:find("scholomance", 1, true) then
        return "Scholomance"
    end
    if n:find("maraudon", 1, true) then
        return "Maraudon"
    end
    if n:find("blackrock depths", 1, true) or n:find("shadowforge city", 1, true) or n:find("detention block", 1, true) then
        return "Blackrock Depths"
    end
    -- Dire Maul and Stratholme wings share one instance each: the wing comes
    -- from the full name ("Dire Maul - East") or from the room (subzone) name.
    if FDJ.WingFromText then
        local wing = FDJ.WingFromText(n)
        if wing then return wing end
    end
end

FDJ.INSTANCE_ID_TO_DUNGEON = {
    [389] = "Ragefire Chasm", [36] = "The Deadmines", [43] = "Wailing Caverns", [33] = "Shadowfang Keep",
    [34] = "The Stockade", [48] = "Blackfathom Deeps", [90] = "Gnomeregan", [47] = "Razorfen Kraul",
    [189] = "Scarlet Monastery", [2999] = "Ruins of Lordaeron", [2959] = "City of Dalaran",
    [2998] = "Excavation Site: Wetlands", [3065] = "Hall of Thanes", [129] = "Razorfen Downs", [70] = "Uldaman", [209] = "Zul'Farrak", [109] = "Sunken Temple", [289] = "Scholomance", [349] = "Maraudon", [230] = "Blackrock Depths",
}
FDJ.SCARLET_WING_MAPS = { [302] = "Scarlet Monastery: Graveyard", [303] = "Scarlet Monastery: Library",
    [304] = "Scarlet Monastery: Armory", [305] = "Scarlet Monastery: Cathedral" }

local function CurrentDungeon()
    -- Only auto-select a dungeon while the player is actually inside an
    -- instance. This prevents similarly named outdoor zones from hijacking the
    -- journal when it opens.
    if type(IsInInstance) == "function" then
        local inInstance = IsInInstance()
        if not inInstance then return nil end
    end

    -- Language-independent detection first: the numeric instance ID is the same
    -- on every client, so non-English clients are recognised too.
    if GetInstanceInfo then
        local instanceID = select(8, GetInstanceInfo())
        local byID = FDJ.INSTANCE_ID_TO_DUNGEON[tonumber(instanceID) or -1]
        if byID and byID ~= "Scarlet Monastery" and DB[byID] then
            return byID
        end
    end

    -- The Scarlet wings share one instance; see Systems/ScarletWing.lua.
    if FDJ.InScarletMonastery and FDJ.ResolveScarletWing then
        local okIn, inScarlet = pcall(FDJ.InScarletMonastery)
        if okIn and inScarlet then
            local okWing, wing = pcall(FDJ.ResolveScarletWing)
            if okWing and wing and DB[wing] then return wing end
        end
    end

    local instanceName = GetInstanceInfo and GetInstanceInfo()
    local n = NormalizeDungeonName(instanceName)
    if n then return n end
    -- Localised instance name: compare with the journal's own translations.
    if type(instanceName) == "string" and instanceName ~= "" then
        local wanted = instanceName:lower()
        for _, content in pairs(FDJ.ContentLocales or {}) do
            for internal, entry in pairs(content.dungeons or {}) do
                if DB[internal] and type(entry.name) == "string" and entry.name:lower() == wanted then return internal end
            end
        end
    end


    local zone = GetRealZoneText and GetRealZoneText()
    n = NormalizeDungeonName(zone)
    if n then return n end

    -- Scarlet Monastery may report the shared instance name rather than the
    -- wing name. Use the subzone only to disambiguate Graveyard; never assume
    -- another Scarlet wing is Graveyard.
    local subZone = GetSubZoneText and GetSubZoneText()
    if type(instanceName) == "string" and instanceName:lower():find("scarlet monastery", 1, true)
        and type(subZone) == "string" and subZone:lower():find("graveyard", 1, true)
    then
        return "Scarlet Monastery: Graveyard"
    end
    if type(instanceName) == "string" and instanceName:lower():find("scarlet monastery", 1, true)
        and type(subZone) == "string" and subZone:lower():find("library", 1, true)
    then
        return "Scarlet Monastery: Library"
    end

    local bySubZone = NormalizeDungeonName(subZone)
    if bySubZone then return bySubZone end
    -- Lower and Upper Blackrock Spire share instance 229; the room decides
    -- above, and you zone in on the Lower side.
    if GetInstanceInfo and tonumber((select(8, GetInstanceInfo()))) == 229 and DB["Lower Blackrock Spire"] then
        return "Lower Blackrock Spire"
    end
    return nil
end
FDJ.CurrentDungeon = CurrentDungeon

-- Profession quests: only for characters with that profession (unless
-- "Show All Profession Quests" is on). The profession names come from the
-- client's own (localized) spell names, compared with the skill list.
FDJ.PROFESSION_SPELLS = {
    BLACKSMITHING = 2018, MINING = 2575, LEATHERWORKING = 2108, TAILORING = 3908,
    ALCHEMY = 2259, ENGINEERING = 4036, ENCHANTING = 7411, SKINNING = 8613, HERBALISM = 2366,
}
function FDJ.PlayerHasProfession(token)
    token = tostring(token or ""):upper()
    if type(GetNumSkillLines) ~= "function" or type(GetSkillLineInfo) ~= "function" then return true end
    local wanted = {}
    local spell = FDJ.PROFESSION_SPELLS[token]
    if spell and type(GetSpellInfo) == "function" then
        local ok, name = pcall(GetSpellInfo, spell)
        if ok and type(name) == "string" then wanted[name:lower()] = true end
    end
    wanted[token:lower()] = true
    local okCount, count = pcall(GetNumSkillLines)
    if not okCount or type(count) ~= "number" or count == 0 then return true end -- not loaded yet
    for i = 1, count do
        local ok, name, isHeader = pcall(GetSkillLineInfo, i)
        if ok and not isHeader and type(name) == "string" and wanted[name:lower()] then return true end
    end
    return false
end

local function QuestMatchesFaction(quest, faction)
    if not quest then return false end
    local forFaction = quest.faction == "Both"
        or quest.faction == "Neutral"
        or quest.faction == faction
    if not forFaction then return false end
    -- Class quests only show for that class, unless the player turned on
    -- "Show All Class Quests" in the options.
    if quest.classOnly and not ForeverDungeonJournalDB.showAllClassQuests then
        local playerClass
        if UnitClass then
            local ok, _, token = pcall(UnitClass, "player")
            if ok then playerClass = token end
        end
        if type(issecretvalue) == "function" and issecretvalue(playerClass) then playerClass = nil end
        if type(playerClass) == "string" and playerClass ~= ""
            and tostring(quest.classOnly):upper() ~= playerClass then
            return false
        end
    end
    if quest.profession and not ForeverDungeonJournalDB.showAllProfessionQuests
        and not FDJ.PlayerHasProfession(quest.profession) then
        return false
    end
    return true
end

local function IsSecret(v)
    return type(issecretvalue) == "function" and issecretvalue(v)
end

local function FormatNumber(value)
    if type(value) ~= "number" then return nil end

    if type(BreakUpLargeNumbers) == "function" then
        local ok, formatted = pcall(BreakUpLargeNumbers, value)
        if ok and type(formatted) == "string" then
            return formatted
        end
    end

    local s = tostring(math.floor(value + 0.5))
    local formatted = s
    while true do
        local changed
        formatted, changed = formatted:gsub("^(%-?%d+)(%d%d%d)", "%1,%2")
        if changed == 0 then break end
    end
    return formatted
end

-- Mark BEFORE the API call: cached data may fire its event synchronously.
-- Failed requests can retry after a cooldown, never from inside the event.
local questDataRequests = {}
local function RequestQuestRewardData(questID)
    if type(questID) ~= "number" then return end
    local request = questDataRequests[questID]
    local now = GetTime and GetTime() or 0
    if request and (request.state ~= "failed" or now < request.retryAt) then return end
    if C_QuestLog and type(C_QuestLog.RequestLoadQuestByID) == "function" then
        questDataRequests[questID] = {state = "pending"}
        local ok = pcall(C_QuestLog.RequestLoadQuestByID, questID)
        if not ok then
            questDataRequests[questID] = {state = "failed", retryAt = now + 30}
        end
    end
end

-- Current client rewards take precedence over all offline fallbacks.
-- A zero is authoritative only after successful quest-data loading; otherwise
-- it can mean that the client has not cached the quest yet.
local function GetLiveQuestXP(quest)
    if not quest then return nil end
    if not quest.id then return quest.liveXPFallback end
    if type(GetQuestLogRewardXP) == "function" then
        local ok, xp = pcall(GetQuestLogRewardXP, quest.id)
        if ok and not IsSecret(xp) and type(xp) == "number" then
            -- Forever 1.60.1 currently exposes stale/base quest-log XP for a few
            -- BFD quests while the server/turn-in frame awards the values below.
            -- Only replace the exact stale amount; any level-scaled value is left alone.
            local correctedBFDXP = {
                [6565] = { stale = 6300, current = 6489 }, -- Allegiance to the Old Gods
                [6921] = { stale = 6550, current = 6746 }, -- Amongst the Ruins
                [6922] = { stale = 7250, current = 7468 }, -- Baron Aquanis
            }
            local correction = correctedBFDXP[quest.id]
            if correction and xp == correction.stale then
                return correction.current
            end
            if xp > 0 then return xp end
            local request = questDataRequests[quest.id]
            if xp == 0 and request and request.state == "loaded" then return 0 end
        end
    end
    local request = questDataRequests[quest.id]
    if request and request.state == "pending" then return nil end
    return FOREVER_QUEST_XP_FALLBACK[quest.id] or quest.liveXPFallback
end

local function GetQuestRewardExtrasText(quest)
    if not quest then return "" end

    local summary = quest.rewardSummary or quest.rewards or ""

    -- Remove the old cached/base XP token. Live/current XP is rendered in the
    -- dedicated XP reward box, matching Blizzard's quest-log layout.
    summary = summary:gsub("^%s*[%d,%.]+%s*XP%s*[•|]*%s*", "")
    summary = summary:gsub("^%s*XP%s*[%d,%.]+%s*[•|]*%s*", "")
    return summary
end

local function ParseQuestRewardExtras(quest)
    local raw = FreeText(GetQuestRewardExtrasText(quest))
    local money = 0
    local kept = {}

    -- Items already shown as reward buttons must not be repeated as text
    -- underneath (e.g. "Nogg's Gold Ring" under the Nogg's Gold Ring button).
    local shownItems = {}
    if type(quest) == "table" then
        for _, list in ipairs({ quest.rewardItems, quest.additionalRewardItems, quest.noteRewardItems }) do
            for _, item in ipairs(type(list) == "table" and list or {}) do
                if type(item[2]) == "string" then shownItems[item[2]:lower()] = true end
                if type(item[1]) == "number" and item[1] > 0 and GetItemInfo then
                    local ok, liveName = pcall(GetItemInfo, item[1])
                    if ok and type(liveName) == "string" and not IsSecret(liveName) then
                        shownItems[liveName:lower()] = true
                    end
                end
            end
        end
    end

    for token in raw:gmatch("[^•|]+") do
        token = token:gsub("^%s+", ""):gsub("%s+$", "")
        -- "Nogg's Gold Ring" or "Nogg's Gold Ring x2": already a button.
        local bare = token:gsub("%s*[xX]%s*%d+$", ""):lower()
        if shownItems[bare] then token = "" end
        if token ~= "" then
            local remainder = token:gsub("%d+%s*[gsc]", ""):gsub("%s+", "")
            if remainder == "" and token:find("%d+%s*[gsc]") then
                for amount, unit in token:gmatch("(%d+)%s*([gsc])") do
                    local value = tonumber(amount) or 0
                    if unit == "g" then
                        money = money + value * 10000
                    elseif unit == "s" then
                        money = money + value * 100
                    else
                        money = money + value
                    end
                end
            else
                -- Reputation rewards are stored as "Faction Name +Amount".
                -- Translate only the faction name, then preserve the numeric
                -- reputation amount exactly as authored.
                local repName, repAmount = token:match("^(.-)%s+([%+%-]%d+)$")
                if repName and repAmount then
                    repName = repName:gsub("^%s+", ""):gsub("%s+$", "")
                    if FDJ.LocalizeReputationName then
                        repName = FDJ.LocalizeReputationName(repName) or repName
                    else
                        repName = FreeText(repName)
                    end
                    token = repName .. " " .. repAmount
                end
                table.insert(kept, token)
            end
        end
    end

    return table.concat(kept, "  •  "), money
end

local function GetQuestRewardMoneyCopper(quest)
    local _, money = ParseQuestRewardExtras(quest)
    return money or 0
end

local function FormatQuestMoney(copper)
    copper = math.max(0, math.floor(tonumber(copper) or 0))
    local gold = math.floor(copper / 10000)
    local silver = math.floor((copper % 10000) / 100)
    local coin = copper % 100
    local parts = {}

    if gold > 0 then
        table.insert(parts, gold .. " |TInterface\\MoneyFrame\\UI-GoldIcon:14:14:2:0|t")
    end
    if silver > 0 or gold > 0 then
        table.insert(parts, silver .. " |TInterface\\MoneyFrame\\UI-SilverIcon:14:14:2:0|t")
    end
    if coin > 0 then
        table.insert(parts, coin .. " |TInterface\\MoneyFrame\\UI-CopperIcon:14:14:2:0|t")
    end

    return table.concat(parts, "  ")
end

-- Reputation reward pills: a green "+100" badge followed by the faction name,
-- styled like the XP and money reward pills. Lays the pills out in rows from
-- (0, -y) inside the quest detail content and returns the height used.
FDJ.LayoutRepPills = function(reps, y, maxWidth)
    if not frame or not frame.questDetailContent then return 0 end
    frame.questRepPills = frame.questRepPills or {}
    local pool = frame.questRepPills
    local x, rows = 0, 0
    for i, rep in ipairs(reps) do
        local pill = pool[i]
        if not pill then
            pill = CreateFrame("Frame", nil, frame.questDetailContent, "BackdropTemplate")
            pool[i] = pill
            pill:SetHeight(26)
            pill:SetBackdrop({
                bgFile = "Interface\\Buttons\\WHITE8X8",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeSize = 9,
                insets = { left = 2, right = 2, top = 2, bottom = 2 },
            })
            pill:SetBackdropColor(0.07, 0.13, 0.06, 0.95)
            pill:SetBackdropBorderColor(0.30, 0.50, 0.24, 1)
            pill.badge = pill:CreateTexture(nil, "ARTWORK")
            pill.badge:SetHeight(18)
            pill.badge:SetPoint("LEFT", 5, 0)
            pill.badge:SetColorTexture(0.16, 0.48, 0.14, 0.95)
            pill.amount = pill:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            pill.amount:SetPoint("CENTER", pill.badge, "CENTER", 0, 0)
            pill.amount:SetTextColor(0.80, 1.00, 0.70)
            pill.name = pill:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            pill.name:SetPoint("LEFT", pill.badge, "RIGHT", 7, 0)
            pill.name:SetTextColor(1.00, 0.92, 0.72)
        end
        pill.amount:SetText("+" .. tostring(rep[2]))
        pill.name:SetText(tostring(rep[1]))
        local badgeWidth = math.ceil((pill.amount:GetStringWidth() or 24) + 8)
        pill.badge:SetWidth(badgeWidth)
        local width = 5 + badgeWidth + 7 + math.ceil(pill.name:GetStringWidth() or 60) + 9
        if rows == 0 then rows = 1 end
        if x > 0 and x + width > maxWidth then
            x = 0
            rows = rows + 1
        end
        pill:SetWidth(width)
        pill:ClearAllPoints()
        pill:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", x, -(y + (rows - 1) * 30))
        pill:Show()
        x = x + width + 8
    end
    for i = #reps + 1, #pool do pool[i]:Hide() end
    return rows * 30
end

local function BuildQuestRewardSummary(quest, includeXP)
    if not quest then return "" end

    local summary = ParseQuestRewardExtras(quest)
    local xp = GetLiveQuestXP(quest)
    if includeXP ~= false and xp and xp > 0 then
        local xpText = FormatNumber(xp) .. " XP"
        if summary ~= "" then
            return xpText .. "  •  " .. summary
        end
        return xpText
    end

    return summary
end

local function IsQuestFinished(questID)
    if not questID then return false end

    -- A permanently completed quest is always complete.
    if C_QuestLog and type(C_QuestLog.IsQuestFlaggedCompleted) == "function" then
        local ok, value = pcall(C_QuestLog.IsQuestFlaggedCompleted, questID)
        if ok and value == true then
            return true
        end
    elseif type(IsQuestFlaggedCompleted) == "function" then
        local ok, value = pcall(IsQuestFlaggedCompleted, questID)
        if ok and value == true then
            return true
        end
    end

    -- Do not use ReadyForTurnIn() here. On the Forever client some active
    -- dungeon quests can report ready state before their real objective is done.
    -- Only show the green completion state for an active quest when the quest
    -- log itself reports it complete.
    local inLog = false

    if C_QuestLog and type(C_QuestLog.GetLogIndexForQuestID) == "function" then
        local ok, index = pcall(C_QuestLog.GetLogIndexForQuestID, questID)
        inLog = ok and type(index) == "number" and index > 0
    elseif type(GetQuestLogIndexByID) == "function" then
        local ok, index = pcall(GetQuestLogIndexByID, questID)
        inLog = ok and type(index) == "number" and index > 0
    end

    if not inLog then
        return false
    end

    -- A quest with no objectives (talk to someone / deliver this) is reported
    -- complete by the quest log the moment it is accepted: it is ready to hand
    -- in, as the game itself shows it (the journal draws its ? until it is
    -- handed in, not the green tick).
    local objectiveCount
    if C_QuestLog and type(C_QuestLog.GetQuestObjectives) == "function" then
        local ok, objectives = pcall(C_QuestLog.GetQuestObjectives, questID)
        if ok and type(objectives) == "table" then objectiveCount = #objectives end
    end
    if objectiveCount == nil and type(GetQuestLogIndexByID) == "function" and type(GetNumQuestLeaderBoards) == "function" then
        local okIndex, index = pcall(GetQuestLogIndexByID, questID)
        if okIndex and type(index) == "number" and index > 0 then
            local okCount, count = pcall(GetNumQuestLeaderBoards, index)
            if okCount and type(count) == "number" then objectiveCount = count end
        end
    end
    if C_QuestLog and type(C_QuestLog.IsComplete) == "function" then
        local ok, value = pcall(C_QuestLog.IsComplete, questID)
        if ok then
            return value == true
        end
    end

    return false
end

local function IsQuestInLog(questID)
    if not questID then return false end

    if C_QuestLog and type(C_QuestLog.GetLogIndexForQuestID) == "function" then
        local ok, index = pcall(C_QuestLog.GetLogIndexForQuestID, questID)
        if ok and type(index) == "number" and index > 0 then
            return true
        end
    end

    if type(GetQuestLogIndexByID) == "function" then
        local ok, index = pcall(GetQuestLogIndexByID, questID)
        if ok and type(index) == "number" and index > 0 then
            return true
        end
    end

    -- Classic-style fallback for clients that do not expose the helpers above.
    if type(GetNumQuestLogEntries) == "function" and type(GetQuestLogTitle) == "function" then
        local ok, numEntries = pcall(GetNumQuestLogEntries)
        if ok and type(numEntries) == "number" then
            for i = 1, numEntries do
                local title, _, _, isHeader, _, _, _, id = GetQuestLogTitle(i)
                if not isHeader and id == questID then
                    return true
                end
            end
        end
    end

    return false
end

FDJ.IsQuestShareable = function(questID)
    -- This answers whether the quest itself is designed to be shareable.
    -- Prefer our audited dungeon data so browsing an unaccepted quest gives
    -- stable information. Unknown/new beta quests still use Forever's native
    -- predicate rather than being guessed.
    if type(questID) ~= "number" then
        return false
    end

    local audited = FDJ.QUEST_SHAREABILITY_AUDIT and FDJ.QUEST_SHAREABILITY_AUDIT[questID]
    if audited ~= nil then
        return audited == true
    end

    if C_QuestLog and type(C_QuestLog.IsPushableQuest) == "function" then
        local ok, value = pcall(C_QuestLog.IsPushableQuest, questID)
        return ok and value == true
    end
    return false
end

FDJ.IsQuestShareableNow = function(questID)
    -- Actually pushing a quest still requires it to be in our quest log.
    return IsQuestInLog(questID) and FDJ.IsQuestShareable(questID)
end

FDJ.ShareQuestByID = function(questID)
    if not FDJ.IsQuestShareableNow(questID) then return end

    -- Forever uses the modern quest predicate but still exposes the standard
    -- quest-share action on supported builds. Select the journal quest first
    -- when that API is available, then invoke the share action from this click.
    if C_QuestLog and type(C_QuestLog.SetSelectedQuest) == "function" then
        pcall(C_QuestLog.SetSelectedQuest, questID)
    elseif type(SelectQuestLogEntry) == "function" then
        local logIndex
        if C_QuestLog and type(C_QuestLog.GetLogIndexForQuestID) == "function" then
            local ok, index = pcall(C_QuestLog.GetLogIndexForQuestID, questID)
            if ok and type(index) == "number" and index > 0 then logIndex = index end
        elseif type(GetQuestLogIndexByID) == "function" then
            local ok, index = pcall(GetQuestLogIndexByID, questID)
            if ok and type(index) == "number" and index > 0 then logIndex = index end
        end
        if logIndex then pcall(SelectQuestLogEntry, logIndex) end
    end

    if type(QuestLogPushQuest) == "function" then
        pcall(QuestLogPushQuest)
    elseif QuestFramePushQuestButton and type(QuestFramePushQuestButton.Click) == "function" then
        pcall(QuestFramePushQuestButton.Click, QuestFramePushQuestButton)
    end
end

FDJ.SetQuestShareButtonVisual = function(button, shareable, canShareNow)
    if not button then return end
    button._fdjShareableQuest = shareable == true
    button._fdjShareEnabled = canShareNow == true

    -- Match the compact gold-bordered selector style used elsewhere in the
    -- journal. Shareable quests use a green fill. Quests that cannot be
    -- shared are visually greyed out but remain mouse-enabled so their
    -- explanatory tooltip still works.
    if button._fdjShareableQuest then
        button:SetBackdropColor(0.10, 0.34, 0.16, 0.98)
        button:SetBackdropBorderColor(0.48, 0.40, 0.27, 1.00)
        if button.text then button.text:SetTextColor(1.00, 0.82, 0.27) end
    else
        button:SetBackdropColor(0.18, 0.18, 0.18, 0.96)
        button:SetBackdropBorderColor(0.34, 0.34, 0.34, 1.00)
        if button.text then button.text:SetTextColor(0.55, 0.55, 0.55) end
    end
end

local function QuestNeedsSameStepShareNote(questID)
    if type(questID) ~= "number" then return false end

    -- The dungeon/final quest itself is a gated chain step.
    if QUEST_PREREQ_CHAINS[questID] ~= nil then
        return true
    end

    -- The first prerequisite can be picked up normally. Every later step is
    -- only useful to players who have progressed to that same point in the
    -- chain, so flag steps 2+ for the more precise share tooltip.
    for _, chain in pairs(QUEST_PREREQ_CHAINS) do
        if type(chain) == "table" then
            for index, step in ipairs(chain) do
                if step and step.id == questID then
                    return index > 1 and step.shareNormally ~= true
                end
            end
        end
    end

    return false
end

FDJ.UpdateQuestShareButton = function(questID, classLabel)
    if not frame or not frame.questShareButton then return 48 end
    local button = frame.questShareButton

    if type(questID) ~= "number" or questID <= 0 then
        button.questID = nil
        button:Hide()
        return 48
    end

    button.questID = questID
    button._fdjClassLabel = classLabel
    button.text:SetText(L("SHARE"))
    local textWidth = button.text:GetStringWidth() or 0
    local width = math.max(70, math.min(104, math.ceil(textWidth + 24)))
    button:SetWidth(width)
    local shareable = FDJ.IsQuestShareable(questID)
    local canShareNow = IsQuestInLog(questID) and shareable
    -- Final dungeon chain quests and every prerequisite step after step 1
    -- should tell the reader that sharing only helps players on that step.
    button._fdjSameStepOnly = QuestNeedsSameStepShareNote(questID)
    FDJ.SetQuestShareButtonVisual(button, shareable, canShareNow)

    button:ClearAllPoints()
    if classLabel then
        -- Class restriction text occupies the far-right header area. Keep the
        -- share control to its left and leave the completion tick unobstructed.
        button:SetPoint("TOPRIGHT", frame.questTextInset, "TOPRIGHT", -174, -10)
        button:Show()
        return 182 + width
    end

    -- Leave room at the far right for the green completion tick.
    button:SetPoint("TOPRIGHT", frame.questTextInset, "TOPRIGHT", -48, -10)
    button:Show()
    return 56 + width
end


-- Prerequisite quests shown by the expandable chain control in the quest list.
-- Only verified prerequisite relationships are included here.
-- Static details for prerequisite quests. These are used when the client has
-- not cached an older quest's text. The data is intentionally concise and
-- mirrors the actual quest objective/start/turn-in rather than relying on the
-- local quest cache.


local expandedQuestChains = {}

local function GetQuestPrereqChain(quest)
    if not quest or not quest.id then return nil end
    local chain = QUEST_PREREQ_CHAINS[quest.id]
    if chain and #chain > 0 then
        return chain
    end
    return nil
end

-- Profession quests show their profession icon where class quests show the class.
local PROFESSION_QUEST_ICONS = {
    BLACKSMITHING = "Interface\\Icons\\Trade_BlackSmithing",
    MINING = "Interface\\Icons\\Trade_Mining",
    LEATHERWORKING = "Interface\\Icons\\Trade_LeatherWorking",
    TAILORING = "Interface\\Icons\\Trade_Tailoring",
    ALCHEMY = "Interface\\Icons\\Trade_Alchemy",
    ENGINEERING = "Interface\\Icons\\Trade_Engineering",
    ENCHANTING = "Interface\\Icons\\Trade_Engraving",
}
FDJ.PROFESSION_QUEST_ICONS = PROFESSION_QUEST_ICONS
-- Raid attunement quests show the raid's icon in the same spot.
FDJ.ATTUNEMENT_QUEST_ICONS = {
    ONYXIA = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\OnyxiaAttuneIcon",
}
-- Every quest of an attunement chain that has its own journal entry.
FDJ.ATTUNEMENT_QUEST_IDS = {
    [4322] = "ONYXIA", [6502] = "ONYXIA",                                   -- Alliance
    [4903] = "ONYXIA", [4974] = "ONYXIA", [6569] = "ONYXIA", [6602] = "ONYXIA", -- Horde
}
local function SetQuestRestrictionIcon(texture, token)
    local attune = type(token) == "string" and token:match("^ATTUNE:(.+)$")
    if attune then
        texture:SetTexture(FDJ.ATTUNEMENT_QUEST_ICONS[attune] or "Interface\\Icons\\INV_Misc_QuestionMark")
        texture:SetTexCoord(0, 1, 0, 1)
        return
    end
    local prof = type(token) == "string" and token:match("^PROF:(.+)$")
    if prof then
        texture:SetTexture(PROFESSION_QUEST_ICONS[prof] or "Interface\\Icons\\INV_Misc_QuestionMark")
        texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        return
    end
    local coords = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[token]
    texture:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    if coords then
        texture:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
    else
        texture:SetTexCoord(0, 1, 0, 1)
    end
end

local function GetQuestClassRestriction(quest)
    if quest and not quest.classOnly and quest.profession then
        local prof = tostring(quest.profession):upper()
        local name = L("PROF_" .. prof)
        if name == "PROF_" .. prof then name = prof end
        return string.upper(name), 0.96, 0.78, 0.45, "PROF:" .. prof
    end
    local attunement = quest and (quest.attunement or (FDJ.ATTUNEMENT_QUEST_IDS and FDJ.ATTUNEMENT_QUEST_IDS[quest.id]))
    if quest and not quest.classOnly and attunement then
        local raid = tostring(attunement):upper()
        local name = L("ATTUNE_" .. raid)
        if name == "ATTUNE_" .. raid then name = raid end
        return string.upper(name), 0.80, 0.55, 1.00, "ATTUNE:" .. raid
    end
    if not quest or not quest.classOnly then return nil end

    local token = tostring(quest.classOnly):upper()
    local className = token:sub(1, 1) .. token:sub(2):lower()
    local r, g, b = 1, 1, 1

    if RAID_CLASS_COLORS and RAID_CLASS_COLORS[token] then
        local color = RAID_CLASS_COLORS[token]
        r, g, b = color.r or r, color.g or g, color.b or b
    elseif token == "WARLOCK" then
        r, g, b = 0.53, 0.53, 0.93
    end

    return L("CLASS_ONLY", string.upper(className)), r, g, b, token
end

local function GetScrollBar(scrollFrame)
    if not scrollFrame then return nil end
    if scrollFrame.ScrollBar then return scrollFrame.ScrollBar end

    local name = scrollFrame.GetName and scrollFrame:GetName()
    if name then
        return _G[name .. "ScrollBar"]
    end
end

local function SetFrameShownSafe(obj, shown)
    if obj and obj.SetShown then
        obj:SetShown(shown)
    elseif obj then
        if shown and obj.Show then
            obj:Show()
        elseif not shown and obj.Hide then
            obj:Hide()
        end
    end
end

local function UpdateScrollBarVisibility(scrollFrame, contentHeight)
    if not scrollFrame then return end

    local viewportHeight = scrollFrame:GetHeight() or 0
    local needsScroll = viewportHeight > 0 and contentHeight > viewportHeight + 4
    local scrollBar = GetScrollBar(scrollFrame)

    SetFrameShownSafe(scrollBar, needsScroll)

    if scrollBar then
        SetFrameShownSafe(scrollBar.ScrollUpButton, needsScroll)
        SetFrameShownSafe(scrollBar.ScrollDownButton, needsScroll)
        SetFrameShownSafe(scrollBar.ThumbTexture, needsScroll)
    end

    local name = scrollFrame.GetName and scrollFrame:GetName()
    if name then
        SetFrameShownSafe(_G[name .. "ScrollBar"], needsScroll)
        SetFrameShownSafe(_G[name .. "ScrollBarScrollUpButton"], needsScroll)
        SetFrameShownSafe(_G[name .. "ScrollBarScrollDownButton"], needsScroll)
        SetFrameShownSafe(_G[name .. "ScrollBarThumbTexture"], needsScroll)
    end

    if not needsScroll then
        -- Quest detail pages are rebuilt asynchronously as quest/item data arrives.
        -- Do not destroy their remembered scroll position during a transient short
        -- redraw; ApplyQuestDetailScroll handles page changes and restoration.
        if not (frame and scrollFrame == frame.questDetailScroll) then
            scrollFrame:SetVerticalScroll(0)
        end
    end
end

local RefreshAll
local ApplyLocalization
local RefreshHomeDungeonCards
local RefreshBossList
local RefreshLoot
local RefreshQuestList
local RefreshQuestDetail
local SetMode
local SelectBoss
local SelectQuest
local SelectQuestByID
local SetQuestFaction
local ShowDungeonMap
local HideDungeonMap
local SelectDungeon
local ShowHomePage
local ShowDungeonPage
local ShowRouteGuide

local function ApplySelectedLanguage(code)
    local wasRouteOpen = frame and frame.routePanel and frame.routePanel:IsShown()
    local wasMapOpen = frame and frame.dungeonMapPanel and frame.dungeonMapPanel:IsShown()
    local mapFloor = frame and frame.dungeonMapFloor
    if FDJ.SetLanguage then FDJ.SetLanguage(code) end
    UpdateLanguageControl()
    if ApplyLocalization then ApplyLocalization() end
    if frame and frame.RefreshSearchResults and frame.searchEditBox then
        frame.RefreshSearchResults(frame.searchEditBox:GetText() or "")
    end
    if frame then
        if frame.currentView == "home" then
            RefreshHomeDungeonCards()
        else
            FDJ.keepQuestState = true
            local okRefresh, refreshError = pcall(RefreshAll)
            FDJ.keepQuestState = nil
            if not okRefresh then error(refreshError, 0) end
            if wasRouteOpen and ShowRouteGuide then
                ShowRouteGuide()
            end
            -- Stay on the map (and the same floor) when it was open.
            if wasMapOpen and not wasRouteOpen and ShowDungeonMap and FDJ.DUNGEON_MAPS[selectedDungeon] then
                ShowDungeonMap()
                if mapFloor and FDJ.RenderCustomDungeonMap then
                    FDJ.RenderCustomDungeonMap(FDJ.DUNGEON_MAPS[selectedDungeon], mapFloor)
                end
            end
        end
        ApplyLocaleFontTree(frame)
    end
end

-- ============================================================
-- ENCOUNTER JOURNAL PORTRAITS
-- ============================================================
--
-- v0.2.0's portrait scan passed the journal instance ID to
-- EJ_GetEncounterInfoByIndex() before selecting an Encounter Journal
-- instance. Blizzard's API has a quirk where that can return nil.
--
-- v0.7.0 explicitly selects each instance first and THEN enumerates its
-- encounters. We prefer the creature display ID, exactly like Blizzard's
-- portrait utilities do.
-- ============================================================

local function ScanEncounterJournal()
    wipe(journalCache)

    if type(EJ_GetInstanceByIndex) ~= "function"
        or type(EJ_SelectInstance) ~= "function"
        or type(EJ_GetEncounterInfoByIndex) ~= "function"
        or type(EJ_GetCreatureInfo) ~= "function"
    then
        return
    end

    -- Forever adds its new dungeons in a separate Encounter Journal tier.
    -- v1.0.21 only scanned whichever tier Blizzard happened to have selected,
    -- which is why Ruins/Hall portraits could all become question marks.
    -- Scan every available tier, then every dungeon in that tier.
    local tiers = { nil }
    if type(EJ_GetNumTiers) == "function" and type(EJ_SelectTier) == "function" then
        local ok, numTiers = pcall(EJ_GetNumTiers)
        if ok and type(numTiers) == "number" and numTiers > 0 then
            tiers = {}
            for tier = 1, numTiers do
                tiers[#tiers + 1] = tier
            end
        end
    end

    for _, tier in ipairs(tiers) do
        if tier and type(EJ_SelectTier) == "function" then
            pcall(EJ_SelectTier, tier)
        end

        for instanceIndex = 1, 200 do
            local okInstance, instanceID, instanceName = pcall(EJ_GetInstanceByIndex, instanceIndex, false)
            if not okInstance or not instanceID then
                break
            end

            local dungeonName = NormalizeDungeonName(instanceName)

            if dungeonName and DB[dungeonName] then
                pcall(EJ_SelectInstance, instanceID)

                local cache = journalCache[dungeonName] or {
                    instanceID = instanceID,
                    encounters = {},
                }
                journalCache[dungeonName] = cache

                for encounterIndex = 1, 40 do
                    -- Different Classic branches disagree on whether instanceID
                    -- is required here, so try the explicit form first and fall
                    -- back to the selected-instance form.
                    local okEncounter, encounterName, encounterDescription, encounterID =
                        pcall(EJ_GetEncounterInfoByIndex, encounterIndex, instanceID)

                    if (not okEncounter) or not encounterName or not encounterID then
                        okEncounter, encounterName, encounterDescription, encounterID =
                            pcall(EJ_GetEncounterInfoByIndex, encounterIndex)
                    end

                    if (not okEncounter) or not encounterName or not encounterID then
                        break
                    end

                    local okCreature,
                          creatureID,
                          creatureName,
                          creatureDescription,
                          displayInfo,
                          iconImage,
                          uiModelSceneID = pcall(EJ_GetCreatureInfo, 1, encounterID)

                    if okCreature then
                        local data = {
                            encounterID = encounterID,
                            name = encounterName,
                            description = encounterDescription,
                            creatureID = creatureID,
                            creatureName = creatureName,
                            creatureDescription = creatureDescription,
                            displayInfo = displayInfo,
                            iconImage = iconImage,
                            uiModelSceneID = uiModelSceneID,
                        }

                        if type(encounterName) == "string" and encounterName ~= "" then
                            cache.encounters[encounterName:lower()] = data
                        end

                        if type(creatureName) == "string" and creatureName ~= "" then
                            cache.encounters[creatureName:lower()] = data
                        end
                    end
                end
            end
        end
    end
end

local function GetBossJournalData(dungeonName, boss)
    local cache = journalCache[dungeonName]
    if not cache or not boss then return nil end

    local aliases = boss.aliases or { boss.name }

    for _, alias in ipairs(aliases) do
        local data = cache.encounters[alias:lower()]
        if data then return data end
    end
end

local function RefreshPortraitPanels()
    if not frame or not frame:IsShown() then
        return
    end

    if frame.currentView == "home" and ShowHomePage then
        ShowHomePage()
        return
    end

    if RefreshBossList then
        RefreshBossList()
    end

    if RefreshLoot then
        RefreshLoot()
    end
end

-- Legacy bosses and any already-known Forever boss remain purely 2D.  The
-- resolver below is only a one-time bootstrap for a Forever-only NPC whose
-- display ID is otherwise unavailable. It never preloads or runs while zoning.
local function FinishPortraitResolve(request, displayID)
    if portraitResolveCurrent ~= request or request.serial ~= portraitResolveSerial then return end

    if type(displayID) == "number" and displayID > 0 then
        displayIDCache[request.npcID] = displayID
        portraitRetryAt[request.npcID] = nil
        if FDJ.WarmPortraitDisplay then pcall(FDJ.WarmPortraitDisplay, displayID) end
    else
        -- Uncached creatures often need a second request: try again in two
        -- seconds by itself (up to five times), not only on the next click.
        portraitRetryAt[request.npcID] = (GetTime and GetTime() or 0) + 2
        FDJ.portraitResolveTries = FDJ.portraitResolveTries or {}
        local npcID = request.npcID
        local tries = (FDJ.portraitResolveTries[npcID] or 0) + 1
        FDJ.portraitResolveTries[npcID] = tries
        if tries < 5 and C_Timer and C_Timer.After then
            C_Timer.After(2.05, function()
                if FDJ.QueuePortraitResolve then FDJ.QueuePortraitResolve(npcID) end
            end)
        end
    end

    request.model:SetScript("OnModelLoaded", nil)
    if request.model.ClearModel then
        pcall(request.model.ClearModel, request.model)
    end
    request.model:Hide()

    portraitResolveQueued[request.npcID] = nil
    portraitResolveCurrent = nil
    RefreshPortraitPanels()
end

local function StartNextPortraitResolve()
    if portraitResolveCurrent or not portraitResolver then return end
    -- While the journal is open, or in the background once the portrait
    -- warm-up has started; never during a loading screen.
    if not frame or not (frame:IsShown() or FDJ.portraitWarmup) or FDJ.portraitZoning then return end

    local now = GetTime and GetTime() or 0
    if now < (portraitResolveBlockedUntil or 0) then return end

    local npcID = table.remove(portraitResolveQueue, 1)
    if not npcID then return end

    local model = portraitModels[npcID]
    if not model then
        model = CreateFrame("PlayerModel", nil, UIParent)
        model:SetSize(1, 1)
        model:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        model:SetAlpha(0)
        portraitModels[npcID] = model
    end

    portraitResolveSerial = portraitResolveSerial + 1
    local request = {
        npcID = npcID,
        model = model,
        serial = portraitResolveSerial,
        elapsed = 0,
    }
    portraitResolveCurrent = request

    model:SetScript("OnModelLoaded", nil)
    model:Show()
    if model.ClearModel then pcall(model.ClearModel, model) end

    local ok, previousID = pcall(model.GetDisplayInfo, model)
    request.previousID = ok and previousID or nil

    model:SetScript("OnModelLoaded", function()
        if portraitResolveCurrent == request and request.serial == portraitResolveSerial then
            request.loaded = true
        end
    end)

    local started = pcall(model.SetCreature, model, npcID)
    if not started then request.failed = true end
end

local function QueuePortraitResolve(npcID)
    if not npcID or displayIDCache[npcID] or portraitResolveQueued[npcID] then return end
    if not frame or not (frame:IsShown() or FDJ.portraitWarmup) then return end

    local now = GetTime and GetTime() or 0
    if now < (portraitResolveBlockedUntil or 0) then return end
    if portraitRetryAt[npcID] and now < portraitRetryAt[npcID] then return end

    portraitResolveQueued[npcID] = true
    table.insert(portraitResolveQueue, npcID)
    if portraitResolver then portraitResolver:Show() end
end
FDJ.QueuePortraitResolve = QueuePortraitResolve

local function CreatePortraitResolver()
    portraitResolver = CreateFrame("Frame")
    portraitResolver:SetScript("OnUpdate", function(self, elapsed)
        if not portraitResolveCurrent then
            if #portraitResolveQueue == 0 then
                self:Hide()
                return
            end
            StartNextPortraitResolve()
            return
        end

        local request = portraitResolveCurrent
        request.elapsed = request.elapsed + elapsed

        if request.failed then
            FinishPortraitResolve(request, nil)
            return
        end

        if request.loaded or request.elapsed >= 0.10 then
            local ok, displayID = pcall(request.model.GetDisplayInfo, request.model)
            if ok and type(displayID) == "number" and displayID > 0
                and (request.loaded or displayID ~= request.previousID)
            then
                FinishPortraitResolve(request, displayID)
                return
            end
        end

        if request.elapsed >= 3.0 then
            FinishPortraitResolve(request, nil)
        end
    end)
    portraitResolver:Hide()
end

-- v1.0.24: initialize the resolver. v1.0.23 defined the queue/OnUpdate
-- machinery but never actually created this frame, so Forever-only bosses with
-- numeric NPC IDs were queued forever and stayed as question marks.
CreatePortraitResolver()

local function ResetPortraitResolver()
    portraitResolveSerial = portraitResolveSerial + 1
    for _, model in pairs(portraitModels) do
        model:SetScript("OnModelLoaded", nil)
        if model.ClearModel then pcall(model.ClearModel, model) end
        model:Hide()
    end
    wipe(portraitResolveQueue)
    wipe(portraitResolveQueued)
    wipe(portraitRetryAt)
    portraitResolveCurrent = nil
    if portraitResolver then portraitResolver:Hide() end
end

-- Creature portraits go through Systems/PortraitPool.lua, which renders each
-- one off-screen and only moves it into view once it has loaded.
local function TrySetDisplayPortrait(texture, displayID)
    if not FDJ.AcquirePortrait then return false end
    local ok, shown = pcall(FDJ.AcquirePortrait, texture, displayID)
    return ok and shown == true
end

local function SetBossPortrait(texture, dungeonName, boss)
    if boss and boss.fdjDungeon then dungeonName = boss.fdjDungeon end
    -- Never allow a portrait from the previously selected boss to bleed into
    -- this render while a lookup fails or data is still loading. A portrait
    -- drawn from a display ID is kept until we know the new one differs.
    -- (The pooled portrait is handed back here; asking for the same one again
    -- just below puts it straight back without redrawing it.)
    if FDJ.ReleasePortrait then pcall(FDJ.ReleasePortrait, texture) end
    texture:SetTexture(nil)
    texture:SetAlpha(1)
    texture:SetTexCoord(0, 1, 0, 1)

    -- Trash Drops uses a custom bag-only icon with no background.
    -- Keep this synthetic row on a simple 2D texture so it never touches the
    -- NPC/model portrait resolver.
    if boss and boss.recipeTab then
        texture:SetTexture("Interface\\Icons\\INV_Scroll_05")
        texture:SetTexCoord(0, 1, 0, 1)
        return true
    end
    if boss and boss.trash then
        texture:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\TrashDropsIcon")
        texture:SetTexCoord(0, 1, 0, 1)
        return true
    end

    local npcID = BossNpcID(boss)
    local data = GetBossJournalData(dungeonName, boss)

    -- Forever-only records may not have a hand-entered NPC ID yet. The
    -- Encounter Journal creature ID is numeric and safe to use as identity.
    if (not npcID) and data and type(data.creatureID) == "number" and data.creatureID > 0 then
        npcID = data.creatureID
    end
    -- A creature with the boss's look, used for the picture only (The
    -- Drowned City's bosses are known by their test copies so far).
    if (not npcID) and boss and type(boss.portraitNpcID) == "number" then
        npcID = boss.portraitNpcID
    end

    -- 1) Explicit bundled portrait art. Used only when we have a verified clean
    -- asset (currently Lordaeron Captain). Put this before journal/model lookup so
    -- a bad or missing Forever display never overrides the intended portrait.
    if boss.customIcon then
        texture:SetTexture(boss.customIcon)
        texture:SetTexCoord(0, 1, 0, 1)
        return true
    end

    -- 2) Explicit display ID on the boss record.
    if TrySetDisplayPortrait(texture, boss.displayID) then
        return true
    end

    -- 2) Blizzard's current Encounter Journal display is the cleanest source
    -- for Forever bosses and updates automatically when the beta model changes.
    if data and TrySetDisplayPortrait(texture, data.displayInfo) then
        return true
    end

    -- 3) Exact 2D portrait captured from the live unit, keyed by numeric NPC ID.
    -- No UnitName comparisons are involved, so this is safe with secret strings.
    local livePortrait = npcID and portraitTexturesByNpcID[npcID]
    if livePortrait then
        texture:SetTexture(livePortrait)
        texture:SetTexCoord(0.04, 0.96, 0.04, 0.96)
        return true
    end

    -- 4) Verified bundled Classic display IDs. Prefer these to any saved
    -- derived cache so an old bad cache entry can never override known data.
    if npcID and TrySetDisplayPortrait(texture, STATIC_DISPLAY_IDS[npcID]) then
        return true
    end

    -- 5) Reuse a display ID resolved by earlier addon versions for bosses that
    -- do not have a verified bundled Classic display ID.
    if npcID and not STATIC_DISPLAY_IDS[npcID]
        and TrySetDisplayPortrait(texture, displayIDCache[npcID]) then
        return true
    end

    -- 6) Forever bosses often have a numeric NPC ID but no journal portrait.
    -- Resolve the CreatureDisplayID directly from that numeric ID with a tiny
    -- hidden PlayerModel. This never touches UnitGUID(), UnitName(), or any
    -- secret-string value, so it is safe on the Forever client. Once resolved,
    -- the display ID is cached and all future draws are plain 2D portraits.
    if npcID then
        QueuePortraitResolve(npcID)
    end


    if data and data.iconImage and data.iconImage ~= 0 then
        texture:SetTexture(data.iconImage)
        return true
    end

    texture:SetTexture(nil)
    return false
end

-- Right-click on any empty part of the journal goes back one page:
-- route guide / map -> the tab it was opened from, quests <-> bosses back to
-- the previously used tab, dungeon page -> dungeon list.
FDJ.GoBackPage = function()
    if not frame or not frame:IsShown() then return end
    if frame.routePanel and frame.routePanel:IsShown() then
        SetMode(selectedMode); return
    end
    if frame.dungeonMapPanel and frame.dungeonMapPanel:IsShown() then
        SetMode(selectedMode); return
    end
    if frame.currentView == "dungeon" then
        local prev = frame.fdjPrevMode
        frame.fdjPrevMode = nil
        if prev and prev ~= selectedMode then
            SetMode(prev)
        else
            ShowHomePage()
        end
    end
end

FDJ.InstallRightClickBack = function()
    if not frame or frame.fdjRightClickBack then return end
    frame.fdjRightClickBack = true
    local skip = { Button = true, CheckButton = true, EditBox = true, Slider = true }
    local function onUp(_, button)
        if button == "RightButton" then FDJ.GoBackPage() end
    end
    local function walk(f)
        local t = f.GetObjectType and f:GetObjectType()
        if not skip[t] then
            if f.IsMouseEnabled and f:IsMouseEnabled() and f.HookScript then
                f:HookScript("OnMouseUp", onUp)
            end
            for _, child in ipairs({ f:GetChildren() }) do walk(child) end
        end
    end
    frame:EnableMouse(true)
    walk(frame)
end

-- Every boss portrait, prepared in the background once per session: it
-- starts 6 s after logging in (or when the journal first opens, if that is
-- sooner), a few bosses per frame, and waits out combat and loading screens.
-- Bundled pictures cost nothing; portraits the game has to draw are rendered
-- off-screen and kept (Systems/PortraitPool.lua), and Forever bosses whose
-- display is not known yet are looked up and saved, so the journal shows
-- them at once.
local prewarmTexture
FDJ.PrewarmBossPortraits = function()
    if not frame or FDJ.portraitsPrewarmed then return end
    FDJ.portraitsPrewarmed = true
    FDJ.portraitWarmup = true
    if not prewarmTexture then
        prewarmTexture = frame:CreateTexture(nil, "BACKGROUND")
        prewarmTexture:SetSize(1, 1)
        prewarmTexture:Hide()
    end
    local work = {}
    for _, dungeonName in ipairs(FDJ.ORDER or {}) do
        local dungeon = DB[dungeonName]
        for _, boss in ipairs((dungeon and dungeon.bosses) or {}) do
            if not boss.trash then work[#work + 1] = { dungeonName, boss } end
        end
    end
    -- The mobs drawn on Trash Drops rows.
    for _, displayID in pairs(FDJ.TRASH_MOB_DISPLAY_IDS or {}) do
        work[#work + 1] = { nil, nil, displayID }
    end
    local index = 0
    local function Step()
        if FDJ.portraitZoning or (type(InCombatLockdown) == "function" and InCombatLockdown()) then
            if C_Timer and C_Timer.After then C_Timer.After(1, Step) end
            return
        end
        for _ = 1, 6 do
            index = index + 1
            local job = work[index]
            if not job then break end
            if job[3] then
                TrySetDisplayPortrait(prewarmTexture, job[3])
            else
                pcall(SetBossPortrait, prewarmTexture, job[1], job[2])
            end
        end
        if portraitResolver and #portraitResolveQueue > 0 then portraitResolver:Show() end
        if work[index + 1] and C_Timer and C_Timer.After then C_Timer.After(0.05, Step) end
    end
    Step()
end
-- A display found by the background lookup: render it now.
FDJ.WarmPortraitDisplay = function(displayID)
    if prewarmTexture then TrySetDisplayPortrait(prewarmTexture, displayID) end
end

-- v1.0.23: live unit portrait capture intentionally removed.
-- Forever marks UnitGUID()/UnitName() as secret strings in this build, so
-- parsing or comparing them can taint execution. Portrait resolution now uses
-- only addon-owned numeric NPC IDs and Encounter Journal numeric data.


-- ============================================================
-- TOOLTIP
-- ============================================================

local function CreateItemTooltip()
    -- Item hovers use the game's own GameTooltip, so other tooltip addons
    -- (Pawn upgrade scores, vendor prices, bag counts, ...) add their lines
    -- exactly as on any other item tooltip. A private tooltip frame is not
    -- hooked by them.
    itemTooltip = GameTooltip or CreateFrame(
        "GameTooltip",
        "ForeverDungeonJournalItemTooltip",
        UIParent,
        "GameTooltipTemplate"
    )

    compareTooltip1 = CreateFrame(
        "GameTooltip",
        "ForeverDungeonJournalCompareTooltip1",
        UIParent,
        "GameTooltipTemplate"
    )

    compareTooltip2 = CreateFrame(
        "GameTooltip",
        "ForeverDungeonJournalCompareTooltip2",
        UIParent,
        "GameTooltipTemplate"
    )
    -- Solid backing so journal text underneath does not show through.
    for _, tip in ipairs({ itemTooltip, compareTooltip1, compareTooltip2 }) do
        if tip and tip ~= GameTooltip and tip.CreateTexture and not tip.fdjSolidBackground then
            local bg = tip:CreateTexture(nil, "BACKGROUND", nil, -8)
            bg:SetPoint("TOPLEFT", 3, -3)
            bg:SetPoint("BOTTOMRIGHT", -3, 3)
            bg:SetColorTexture(0.03, 0.03, 0.04, 1)
            tip.fdjSolidBackground = bg
        end
    end
end

local function HideComparisonTooltips()
    if compareTooltip1 then compareTooltip1:Hide() end
    if compareTooltip2 then compareTooltip2:Hide() end
end

local function WantsItemComparison()
    -- Compare only while the player is physically holding Shift over the item.
    -- Do not use the COMPAREITEMS modified-click binding here: Shift-click is
    -- reserved for WoW's normal chat-link behavior.
    return IsShiftKeyDown and IsShiftKeyDown() or false
end

local function ClampTooltipTop(top, height)
    local screenTop = (UIParent and UIParent.GetTop and UIParent:GetTop()) or 768
    local minTop = (height or 1) + 12
    local maxTop = screenTop - 12
    if top < minTop then top = minTop end
    if top > maxTop then top = maxTop end
    return top
end

local function PositionPrimaryItemTooltip(owner)
    if not itemTooltip or not owner then return end

    -- Anchor directly to the hovered row. The journal can be scaled independently
    -- from UIParent, so converting owner coordinates into UIParent coordinates
    -- can push the tooltip far away from the item. A relative anchor lets WoW
    -- handle the effective-scale conversion and keeps the tooltip immediately
    -- above the row without covering its text.
    if itemTooltip.SetClampedToScreen then
        itemTooltip:SetClampedToScreen(true)
    end
    itemTooltip:ClearAllPoints()
    local anchor = owner.icon or owner
    itemTooltip:SetPoint("BOTTOMLEFT", anchor, "TOPRIGHT", 4, 4)
end

local function GetItemEquipLocation(itemID)
    local _, _, _, _, _, _, _, _, equipLoc = ItemInfo(itemID)
    if type(equipLoc) == "string" and equipLoc ~= "" then
        return equipLoc
    end

    if C_Item and type(C_Item.GetItemInfoInstant) == "function" then
        local ok, _, _, _, instantEquipLoc = pcall(C_Item.GetItemInfoInstant, itemID)
        if ok and type(instantEquipLoc) == "string" and instantEquipLoc ~= "" then
            return instantEquipLoc
        end
    end

    return nil
end

local function GetEquippedComparisonEntries(itemID)
    local equipLoc = GetItemEquipLocation(itemID)
    if not equipLoc then return {} end

    local slots = EQUIP_LOC_SLOTS[equipLoc]

    -- A generic one-hand weapon can replace the main hand. If the player is
    -- actually dual-wielding a one-hand/off-hand weapon, also compare against
    -- that real equipped weapon. Never compare it against a shield/holdable.
    if equipLoc == "INVTYPE_WEAPON" then
        slots = {16}
        local offLink = GetInventoryItemLink and GetInventoryItemLink("player", 17)
        if offLink then
            local offEquipLoc
            if C_Item and type(C_Item.GetItemInfoInstant) == "function" then
                local ok, _, _, _, value = pcall(C_Item.GetItemInfoInstant, offLink)
                if ok then offEquipLoc = value end
            end
            if offEquipLoc == "INVTYPE_WEAPON" or offEquipLoc == "INVTYPE_WEAPONOFFHAND" then
                slots = {16, 17}
            end
        end
    end

    -- Bags/quivers deliberately have no mapping. The character has four bag
    -- slots and presenting four comparison tooltips is more noise than value.
    if not slots then return {} end

    local entries = {}
    for _, slot in ipairs(slots) do
        local link = GetInventoryItemLink and GetInventoryItemLink("player", slot)
        if link then
            table.insert(entries, { slot = slot, link = link })
        end
    end
    return entries
end

local function PositionTooltipGroup(owner, comparisons)
    if not itemTooltip or not owner then return end

    comparisons = comparisons or {}
    local gap = 6

    -- Keep the hovered item tooltip locked directly above its row. Comparison
    -- tooltips extend to the right of it, preserving the same local anchor and
    -- avoiding UIParent/journal scale mismatches.
    if itemTooltip.SetClampedToScreen then
        itemTooltip:SetClampedToScreen(true)
    end
    itemTooltip:ClearAllPoints()
    local anchor = owner.icon or owner
    itemTooltip:SetPoint("BOTTOMLEFT", anchor, "TOPRIGHT", 4, 4)

    local previous = itemTooltip
    for _, tooltip in ipairs(comparisons) do
        if tooltip.SetClampedToScreen then
            tooltip:SetClampedToScreen(true)
        end
        tooltip:ClearAllPoints()
        tooltip:SetPoint("TOPLEFT", previous, "TOPRIGHT", gap, 0)
        previous = tooltip
    end
end

local STAT_DELTA_ORDER_INDEX = {}
for index, key in ipairs(STAT_DELTA_ORDER) do
    STAT_DELTA_ORDER_INDEX[key] = index
end

local function IsUsableStatLabel(text)
    return type(text) == "string"
        and text ~= ""
        and not string.find(text, "%%[%d%$%.]*[dsf]")
end

local function StatDeltaLabel(key)
    if type(key) ~= "string" then return tostring(key or "Stat") end

    local label = _G[key]
    if IsUsableStatLabel(label) then
        return label
    end

    if not string.find(key, "_SHORT$") then
        label = _G[key .. "_SHORT"]
        if IsUsableStatLabel(label) then
            return label
        end
    end

    label = STAT_DELTA_FALLBACK_LABELS[key]
    if label then return label end

    -- Some Forever builds may return an already-localized string as the key.
    if not string.find(key, "^ITEM_MOD_") and not string.find(key, "^RESISTANCE%d_NAME$") then
        return key
    end

    local cleaned = key
    cleaned = string.gsub(cleaned, "^ITEM_MOD_", "")
    cleaned = string.gsub(cleaned, "_SHORT$", "")
    cleaned = string.gsub(cleaned, "_RATING$", "")
    cleaned = string.gsub(cleaned, "_", " ")
    cleaned = string.lower(cleaned)
    cleaned = string.gsub(cleaned, "(%a)([%w']*)", function(a, b)
        return string.upper(a) .. b
    end)
    return cleaned
end

local function FormatStatDeltaValue(key, value)
    local absValue = math.abs(value)
    local precision = 0
    if key == "ITEM_MOD_DAMAGE_PER_SECOND_SHORT" then
        precision = 1
    elseif math.abs(absValue - math.floor(absValue + 0.5)) > 0.001 then
        precision = 1
    end

    if precision == 1 then
        return string.format("%+.1f", value)
    end
    local rounded
    if value >= 0 then
        rounded = math.floor(value + 0.5)
    else
        rounded = math.ceil(value - 0.5)
    end
    return string.format("%+d", rounded)
end

local function AddStatDeltaBlock(tooltip, equippedLink, newLink)
    if not tooltip or not equippedLink or not newLink then return end
    if not C_Item or type(C_Item.GetItemStatDelta) ~= "function" then return end

    local ok, deltas = pcall(C_Item.GetItemStatDelta, newLink, equippedLink)
    if not ok or type(deltas) ~= "table" then return end

    local entries = {}
    for key, value in pairs(deltas) do
        if type(value) == "number" and math.abs(value) > 0.0001 then
            table.insert(entries, {
                key = key,
                value = value,
                order = STAT_DELTA_ORDER_INDEX[key] or 10000,
                label = StatDeltaLabel(key),
            })
        end
    end

    if #entries == 0 then return end

    table.sort(entries, function(a, b)
        if a.order ~= b.order then return a.order < b.order end
        return tostring(a.label) < tostring(b.label)
    end)

    tooltip:AddLine(" ")
    tooltip:AddLine(
        ITEM_DELTA_DESCRIPTION or "If you replace this item, the following stat changes will occur:",
        1, 0.82, 0,
        true
    )

    local seenLabels = {}
    for _, entry in ipairs(entries) do
        -- Forever can return the same resistance/armor stat under both a
        -- canonical token and an already-localized alias. Show it once.
        local labelKey = string.lower(tostring(entry.label or entry.key or ""))
        labelKey = string.gsub(labelKey, "%s+", " ")
        labelKey = string.gsub(labelKey, "^%s+", "")
        labelKey = string.gsub(labelKey, "%s+$", "")
        if not seenLabels[labelKey] then
            seenLabels[labelKey] = true
            local valueText = FormatStatDeltaValue(entry.key, entry.value)
            local text = valueText .. " " .. entry.label
            if entry.value > 0 then
                tooltip:AddLine(text, 0.10, 1.00, 0.10)
            else
                tooltip:AddLine(text, 1.00, 0.15, 0.15)
            end
        end
    end
end

local function FillComparisonTooltip(tooltip, owner, comparison, newLink)
    if not tooltip or not owner or not comparison or not comparison.link then return false end

    local link = comparison.link
    tooltip:Hide()
    tooltip:SetOwner(owner, "ANCHOR_NONE")
    if tooltip.ClearLines then tooltip:ClearLines() end

    -- SetInventoryItem is important here. A plain hyperlink does not carry the
    -- instance's current binding state, so an already-equipped Soulbound item
    -- could incorrectly render its template text (for example "Binds to Account
    -- until equipped"). Reading the actual equipped slot matches the normal
    -- character-sheet tooltip.
    local populated = false
    if comparison.slot and tooltip.SetInventoryItem then
        local ok = pcall(tooltip.SetInventoryItem, tooltip, "player", comparison.slot)
        populated = ok
    end
    if not populated then
        tooltip:SetHyperlink(link)
    end

    -- Replacement delta = hovered/new item minus the currently equipped item.
    AddStatDeltaBlock(tooltip, link, newLink)

    if tooltip.NumLines and tooltip:NumLines() <= 0 then
        tooltip:Hide()
        return false
    end

    tooltip:Show()
    return true
end

local function ShowComparisonTooltips(owner)
    if not itemTooltip or not owner or not owner.item then return end

    HideComparisonTooltips()

    local comparisons = GetEquippedComparisonEntries(owner.item[1])
    if #comparisons == 0 then
        PositionPrimaryItemTooltip(owner)
        return
    end

    local _, newLink = ItemInfo(owner.item[1])
    newLink = newLink or ("item:" .. owner.item[1])

    local shown = {}
    if comparisons[1] and FillComparisonTooltip(compareTooltip1, owner, comparisons[1], newLink) then
        table.insert(shown, compareTooltip1)
    end
    if comparisons[2] and FillComparisonTooltip(compareTooltip2, owner, comparisons[2], newLink) then
        table.insert(shown, compareTooltip2)
    end

    PositionTooltipGroup(owner, shown)
end

local function UpdateItemComparison(owner)
    if not itemTooltip or not owner or not owner.item then return end
    if not itemTooltip.IsOwned or not itemTooltip:IsOwned(owner) then return end

    local compare = WantsItemComparison()
    if owner.fdjComparing == compare then return end
    owner.fdjComparing = compare

    if compare then
        ShowComparisonTooltips(owner)
    else
        HideComparisonTooltips()
        PositionPrimaryItemTooltip(owner)
    end
end

local function InsertTooltipLineBeforeRequiredLevel(tooltip, text, r, g, b)
    if not tooltip or not text or text == "" or not tooltip.GetName or not tooltip.NumLines then return false end
    local tipName = tooltip:GetName()
    if not tipName or tipName == "" then return false end

    local requiredNeedle = tostring(_G.ITEM_MIN_LEVEL or "Requires Level %d")
    requiredNeedle = requiredNeedle:gsub("%%d", ""):gsub("%%s", "")
    requiredNeedle = requiredNeedle:gsub("^%s+", ""):gsub("%s+$", "")

    local lineCount = tooltip:NumLines() or 0
    local requiredIndex
    for i = 1, lineCount do
        local left = _G[tipName .. "TextLeft" .. i]
        local lineText = left and left:GetText()
        if type(lineText) == "string" and requiredNeedle ~= "" and lineText:find(requiredNeedle, 1, true) then
            requiredIndex = i
            break
        end
    end
    if not requiredIndex then return false end

    -- Add one native tooltip row, then shift the existing Required Level line
    -- and everything below it down by one slot. This preserves the tooltip's
    -- normal spacing while placing our custom stat exactly above Required Level.
    tooltip:AddLine(" ")
    for i = lineCount, requiredIndex, -1 do
        local srcL = _G[tipName .. "TextLeft" .. i]
        local srcR = _G[tipName .. "TextRight" .. i]
        local dstL = _G[tipName .. "TextLeft" .. (i + 1)]
        local dstR = _G[tipName .. "TextRight" .. (i + 1)]
        if srcL and dstL then
            dstL:SetText(srcL:GetText() or "")
            local cr, cg, cb, ca = srcL:GetTextColor()
            dstL:SetTextColor(cr or 1, cg or 1, cb or 1, ca or 1)
        end
        if srcR and dstR then
            dstR:SetText(srcR:GetText() or "")
            local cr, cg, cb, ca = srcR:GetTextColor()
            dstR:SetTextColor(cr or 1, cg or 1, cb or 1, ca or 1)
        end
    end

    local targetL = _G[tipName .. "TextLeft" .. requiredIndex]
    local targetR = _G[tipName .. "TextRight" .. requiredIndex]
    if targetL then
        targetL:SetText(text)
        targetL:SetTextColor(r or 0.10, g or 1.00, b or 0.10, 1)
    end
    if targetR then targetR:SetText("") end
    return true
end

-- Items the Forever server has not sent to this client yet show only a red
-- "Retrieving item information" line. Explain why under that line. The game
-- rebuilds the tooltip once the data arrives, which removes the note again.
function FDJ.AddUnseenItemHint(tooltip)
    if not tooltip or not tooltip.GetName or not tooltip:GetName() then return false end
    local first = _G[tooltip:GetName() .. "TextLeft1"]
    local text = first and first:IsShown() and first:GetText()
    if not text then return false end
    if text ~= (RETRIEVING_ITEM_INFO or "Retrieving item information") and text ~= "Retrieving item information" then return false end
    tooltip:AddLine(" ")
    tooltip:AddLine(L("ITEM_UNSEEN_TITLE"), 1.00, 0.82, 0.10)
    tooltip:AddLine(L("ITEM_UNSEEN_TIP"), 0.85, 0.85, 0.85, true)
    return true
end

local function ShowItemTooltip(row)
    if not row.item then return end

    HideComparisonTooltips()
    row.fdjComparing = nil

    -- SetOwner must happen BEFORE SetHyperlink. Re-setting the owner after the
    -- hyperlink is populated clears the tooltip on the Forever client.
    itemTooltip:Hide()
    itemTooltip:SetOwner(row, "ANCHOR_NONE")
    if itemTooltip.ClearLines then itemTooltip:ClearLines() end
    if not row.item[1] or row.item[1] <= 0 then
        local r, g, b = QualityColor(tonumber(row.item[4]) or tonumber(row.item[3]) or 1)
        itemTooltip:AddLine(row.item[2] or L("ITEM"), r, g, b)
        for _, line in ipairs(type(row.item.tip) == "table" and row.item.tip or {}) do -- drownedloot
            if type(line) == "table" then
                itemTooltip:AddDoubleLine(line[1], line[2], 1, 1, 1, 1, 1, 1)
            else
                itemTooltip:AddLine(line, 1, 1, 1, true)
            end
        end
        itemTooltip:Show()
        if FDJ.RefreshTooltipBacking then FDJ.RefreshTooltipBacking() end
        PositionPrimaryItemTooltip(row)
        return
    end
    local _, liveLink = ItemInfo(row.item[1])
    itemTooltip:SetHyperlink(liveLink or ("item:" .. row.item[1]))
    FDJ.AddUnseenItemHint(itemTooltip)
    -- Some loot entries need a short Journal-only stat hint that the base item
    -- hyperlink cannot show. Charged Gear, for example, rolls a random enchant
    -- when it drops, while the static item ID has no suffix attached to it.
    if type(row.item[6]) == "string" and row.item[6] ~= "" then
        local statText = L(row.item[6])
        if not InsertTooltipLineBeforeRequiredLevel(itemTooltip, statText, 0.10, 1.00, 0.10) then
            itemTooltip:AddLine(statText, 0.10, 1.00, 0.10, true)
        end
    end
    if row.fdjSourceText and row.fdjSourceText ~= "" then
        itemTooltip:AddLine(" ")
        itemTooltip:AddLine(row.fdjSourceText, 1.00, 0.82, 0.10, true)
    end
    if row.fdjMapLocation then
        itemTooltip:AddLine(L("ITEM_CLICK_MAP"), 0.35, 1.00, 0.35, true)
    end
    itemTooltip:Show()
    if FDJ.RefreshTooltipBacking then FDJ.RefreshTooltipBacking() end
    PositionPrimaryItemTooltip(row)

    -- Handles Shift already being held when the mouse enters the item.
    UpdateItemComparison(row)
end

-- ============================================================
-- UI CREATION
-- ============================================================

-- Temporary emphasis used only when an item was opened from the global search.
-- It deliberately disappears as soon as the player hovers the item, and normal
-- page refreshes clear it as well.
local function HideSearchItemHighlight(button)
    if button and button.fdjSearchGlow then
        button.fdjSearchGlow:Hide()
    end
end

local function ShowSearchItemHighlight(button)
    if not button then return end
    if not button.fdjSearchGlow then
        local glow = CreateFrame("Frame", nil, button, "BackdropTemplate")
        glow:SetPoint("TOPLEFT", button, "TOPLEFT", -3, 3)
        glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -3)
        glow:SetFrameLevel(button:GetFrameLevel() + 6)
        glow:EnableMouse(false)
        SetBackdrop(glow, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 9, 2)
        glow:SetBackdropColor(1.00, 0.78, 0.08, 0.12)
        glow:SetBackdropBorderColor(1.00, 0.82, 0.12, 1.00)

        glow.flash = glow:CreateTexture(nil, "OVERLAY")
        glow.flash:SetAllPoints()
        glow.flash:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
        glow.flash:SetBlendMode("ADD")
        glow.flash:SetAlpha(0.28)
        glow:Hide()
        button.fdjSearchGlow = glow
    end
    button.fdjSearchGlow:Show()
end

-- A list refresh (for example when the server sends item data while the
-- mouse is on a row) repaints rows with their normal colour. Keep the hover
-- colour on the row under the mouse.
local function KeepHoverColor(self)
    local c = self.fdjHoverColor
    if not c then return end
    if not self:IsMouseOver() then return end
    local r, g, b = self:GetBackdropColor()
    if r and (math.abs(r - c[1]) > 0.01 or math.abs(g - c[2]) > 0.01 or math.abs(b - c[3]) > 0.01) then
        self:SetBackdropColor(c[1], c[2], c[3], 1)
    end
end

local function MakeLootRow(parent)
    local row = CreateFrame("Button", nil, parent, "BackdropTemplate")
    row:SetSize(388, 52)
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    SetBackdrop(
        row,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        10,
        2
    )
    row:SetBackdropColor(0.25, 0.16, 0.07, 0.93) -- recolored on refresh
    row:SetBackdropBorderColor(0.46, 0.30, 0.12, 1)

    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(38, 38)
    row.icon:SetPoint("LEFT", 10, 0)
    row.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    row.name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    row.name:SetPoint("TOPLEFT", row.icon, "TOPRIGHT", 10, -4)
    row.name:SetPoint("RIGHT", -10, 0)
    row.name:SetJustifyH("LEFT")
    -- One line only: names too long for the row end in "..." (matters most
    -- in the two-column layout).
    row.name:SetWordWrap(false)

    row.slot = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.slot:SetPoint("TOPLEFT", row.name, "BOTTOMLEFT", 0, -5)
    row.slot:SetPoint("RIGHT", -10, 0)
    row.slot:SetJustifyH("LEFT")
    row.slot:SetWordWrap(false)
    row.slot:SetTextColor(0.27, 0.18, 0.08)

    -- Small right-hand label for shared boss loot, styled like the RARE tag
    -- on rare bosses. Sits left of the favourite star.
    row.sharedText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.sharedText:SetPoint("RIGHT", row, "RIGHT", -28, 0)
    row.sharedText:SetJustifyH("RIGHT")
    row.sharedText:SetText("Shared Loot, low %")
    row.sharedText:SetTextColor(1.00, 0.82, 0.00)
    row.sharedText:Hide()

    row:SetScript("OnEnter", function(self)
        HideSearchItemHighlight(self)
        local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
        local c = theme.rowSelected
        self.fdjHoverColor = { c[1], c[2], c[3] }
        self:SetBackdropColor(c[1], c[2], c[3], 1)
        ShowItemTooltip(self)
    end)

    row:SetScript("OnLeave", function(self)
        local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
        self.fdjHoverColor = nil
        self:SetBackdropColor(unpack(theme.lootRow))
        self.fdjComparing = nil
        if itemTooltip then itemTooltip:Hide() end
        HideComparisonTooltips()
    end)

    -- Poll the modifier while hovered so comparison appears/disappears
    -- immediately when Shift is pressed/released, without moving the mouse.
    row:SetScript("OnUpdate", function(self)
        KeepHoverColor(self)
        UpdateItemComparison(self)
    end)

    row:SetScript("OnClick", function(self, button)
        if not self.item then return end

        if button == "RightButton" and FDJ.ShowItemFavouriteMenu then
            FDJ.ShowItemFavouriteMenu(self, self.item, self.fdjDungeonName, self.fdjBossName)
            return
        end

        local _, link = ItemInfo(self.item[1])

        if link
            and IsModifiedClick
            and IsModifiedClick("CHATLINK")
            and ChatEdit_InsertLink
        then
            -- Preserve normal Shift-click chat linking when an edit box is active.
            local used = ChatEdit_InsertLink(link)
            if used then return end
        end

        if link
            and IsModifiedClick
            and IsModifiedClick("DRESSUP")
            and DressUpItemLink
        then
            DressUpItemLink(link)
        end
    end)

    return row
end

local function MakeBossButton(parent)
    local button = CreateFrame("Button", nil, parent, "BackdropTemplate")
    button:SetSize(315, 55)

    SetBackdrop(
        button,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        10,
        2
    )

    button.portrait = button:CreateTexture(nil, "ARTWORK")
    button.portrait:SetSize(44, 44)
    button.portrait:SetPoint("LEFT", 7, 0)
    button.portrait:SetTexCoord(0.05, 0.95, 0.05, 0.95)

    button.rareBorder = button:CreateTexture(nil, "OVERLAY")
    button.rareBorder:SetSize(64, 64)
    button.rareBorder:SetPoint("CENTER", button.portrait, "CENTER", 0, 0)
    button.rareBorder:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\RarePortraitDragonFrame.tga")
    button.rareBorder:SetTexCoord(0, 1, 0, 1)
    button.rareBorder:Hide()

    button.question = button:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    button.question:SetPoint("CENTER", button.portrait, "CENTER", 0, 0)
    button.question:SetText("?")
    button.question:SetTextColor(0.92, 0.72, 0.22)
    button.question:Hide()

    -- Level medallion: same visual language as the player/target level badge,
    -- tucked over the lower-left of the portrait.
    button.levelBadge = button:CreateTexture(nil, "OVERLAY", nil, 6)
    button.levelBadge:SetSize(28, 28)
    button.levelBadge:SetPoint("CENTER", button.portrait, "BOTTOMLEFT", 8, 2)
    button.levelBadge:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\BossLevelBadge.tga")
    button.levelBadge:Hide()

    button.levelText = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    button.levelText:SetPoint("CENTER", button.levelBadge, "CENTER", 0, 0)
    button.levelText:SetTextColor(1, 1, 1)
    button.levelText:SetShadowColor(0, 0, 0, 1)
    button.levelText:SetShadowOffset(1, -1)
    button.levelText:Hide()

    button.name = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    button.name:SetPoint("LEFT", button.portrait, "RIGHT", 11, 1)
    button.name:SetPoint("RIGHT", -10, 0)
    button.name:SetJustifyH("LEFT")

    button.rare = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    button.rare:SetPoint("RIGHT", button, "RIGHT", -20, 1)
    button.rare:SetText(L("RARE"))
    button.rare:SetTextColor(1.00, 0.82, 0.00)
    button.rare:Hide()

    button:SetScript("OnClick", function(self)
        SelectBoss(self.index)
    end)

    return button
end


local function FactionColor(faction)
    if faction == "Alliance" then
        return "|cff5b8ff9"
    elseif faction == "Horde" then
        return "|cffff5a4f"
    end
    return "|cffffd34e"
end

local ALLIANCE_ICON = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\Alliance.tga"
local HORDE_ICON = "Interface\\AddOns\\ForeverDungeonJournal\\Media\\Horde.tga"

local function FactionLabel(faction)
    local alliance = "|T" .. ALLIANCE_ICON .. ":24:24:0:0|t"
    local horde = "|T" .. HORDE_ICON .. ":24:24:0:0|t"

    if faction == "Both" or faction == "Neutral" then
        return alliance .. " " .. horde
    elseif faction == "Alliance" then
        return alliance
    elseif faction == "Horde" then
        return horde
    end
    return ""
end

local function ApplyQuestFont(fontString, preferred, fallback)
    if not fontString then return end

    local fontObject = _G[preferred]
    if not fontObject and fallback then
        fontObject = _G[fallback]
    end

    if fontObject and fontString.SetFontObject then
        fontString:SetFontObject(fontObject)
    end
end

local function ApplyRewardSummaryFont(fontString)
    if not fontString then return end
    -- Reward summaries can contain localized reputation names. On an English
    -- client the parchment QuestFont can miss individual Cyrillic glyphs even
    -- while larger quest-body text appears fine. Use the standard Blizzard UI
    -- font object here, which is the same family successfully used by the
    -- Russian journal headers/list labels and keeps Cyrillic intact.
    local fontObject = _G.GameFontNormalSmall or _G.GameFontNormal
    if fontObject and fontString.SetFontObject then
        fontString:SetFontObject(fontObject)
    end
end

local function MakeQuestButton(parent)
    local button = CreateFrame("Button", nil, parent, "BackdropTemplate")
    button:SetSize(296, 48)

    SetBackdrop(
        button,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        10,
        2
    )

    button.completeGlow = CreateFrame("Frame", nil, button, "BackdropTemplate")
    button.completeGlow:SetPoint("TOPLEFT", -2, 2)
    button.completeGlow:SetPoint("BOTTOMRIGHT", 2, -2)
    SetBackdrop(
        button.completeGlow,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        12,
        2
    )
    button.completeGlow:SetBackdropColor(0.05, 0.35, 0.08, 0.16)
    button.completeGlow:SetBackdropBorderColor(0.12, 1.00, 0.25, 0.90)
    button.completeGlow:EnableMouse(false)
    button.completeGlow:Hide()

    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetSize(24, 24)
    button.icon:SetPoint("TOPLEFT", 9, -8)
    button.icon:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon")

    button.check = button:CreateTexture(nil, "OVERLAY")
    button.check:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
    button.check:SetSize(22, 22)

    -- Keep the MAIN QUEST completion tick fixed beside the main quest header.
    -- Do not anchor it to the vertical center of the whole button, because the
    -- button becomes taller when prerequisite rows are expanded.
    button.check:SetPoint("TOPRIGHT", button, "TOPRIGHT", -8, -8)
    button.check:Hide()

    -- Ready to hand in: the quest tracker's round ? in place of the tick (a
    -- click shows where to hand the quest in).
    if FDJ.CreateTurnInButton then
        -- bigready: big and on its own (no faction icons) so nobody misses it.
        button.turnIn = FDJ.CreateTurnInButton(button, 44)
        button.turnIn:SetPoint("CENTER", button, "TOPRIGHT", -26, -24)
        button.turnIn:SetFrameLevel(button:GetFrameLevel() + 6)
    end
    -- turninlabel: "Turn in" left of the ?, in the quest tracker's green.
    if button.turnIn then
        button.turnInLabel = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        button.turnInLabel:SetPoint("RIGHT", button.turnIn, "LEFT", 3, 0)
        button.turnInLabel:SetJustifyH("RIGHT")
        button.turnInLabel:SetTextColor(0.30, 1.00, 0.36)
        button.turnInLabel:Hide()
    end

    button.allianceIcon = button:CreateTexture(nil, "OVERLAY")
    button.allianceIcon:SetSize(20, 20)
    button.allianceIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -50, -8)
    button.allianceIcon:SetTexture(ALLIANCE_ICON)
    button.allianceIcon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
    button.allianceIcon:Hide()

    button.hordeIcon = button:CreateTexture(nil, "OVERLAY")
    button.hordeIcon:SetSize(20, 20)
    button.hordeIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -28, -8)
    button.hordeIcon:SetTexture(HORDE_ICON)
    button.hordeIcon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
    button.hordeIcon:Hide()

    button.classIcon = button:CreateTexture(nil, "OVERLAY")
    button.classIcon:SetSize(20, 20)
    button.classIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    button.classIcon:Hide()

    button.haveIt = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    -- Status sits cleanly between the top border and the faction/class icons.
    -- Keep enough width for longer locales such as German, then shrink the
    -- font slightly only when the translated label still does not fit.
    button.haveIt:SetPoint("TOPRIGHT", -7, -7)
    button.haveIt:SetWidth(92)
    button.haveIt:SetJustifyH("RIGHT")
    button.haveIt:SetText(L("YOU_HAVE_IT"))
    button.haveIt:SetTextColor(1.00, 0.82, 0.10)
    button.haveIt:SetShadowColor(0, 0, 0, 0.72)
    button.haveIt:SetShadowOffset(1, -1)
    button.haveIt:Hide()

    button.UpdateHaveItLabel = function(self)
        local fs = self.haveIt
        if not fs then return end

        -- Always restore the Blizzard font object itself. Re-applying the raw
        -- font file from GetFont() breaks Cyrillic on non-Russian clients.
        -- Scaling the FontString preserves Blizzard's glyph fallback while
        -- still letting longer labels such as German fit in the status area.
        fs:SetFontObject("GameFontNormalSmall")
        fs:SetScale(1)
        fs:SetText(L("YOU_HAVE_IT"))

        local width = fs:GetStringWidth() or 0
        if width > 88 and width > 0 then
            local scale = 88 / width
            if scale < 0.80 then scale = 0.80 end
            fs:SetScale(scale)
        end
    end
    button:UpdateHaveItLabel()

    button.name = button:CreateFontString(nil, "OVERLAY")
    ApplyQuestFont(button.name, "QuestFont", "GameFontNormal")
    button.name:SetPoint("TOPLEFT", button, "TOPLEFT", 42, -9)
    button.name:SetWidth(182)
    button.name:SetWordWrap(true)
    button.name:SetJustifyH("LEFT")

    button.meta = button:CreateFontString(nil, "OVERLAY")
    ApplyQuestFont(button.meta, "QuestFontNormalSmall", "GameFontHighlightSmall")
    button.meta:SetPoint("TOPLEFT", button.name, "BOTTOMLEFT", 0, -5)
    button.meta:SetWidth(182)
    button.meta:SetWordWrap(true)
    button.meta:SetJustifyH("LEFT")

    button.chainToggle = CreateFrame("Button", nil, button)
    button.chainToggle:SetSize(16, 16)
    -- Keep the chain control inside the visible quest row and away from the title.
    button.chainToggle:SetPoint("RIGHT", button, "RIGHT", -86, -9)
    button.chainToggle:SetFrameLevel(button:GetFrameLevel() + 6)
    button.chainToggle:RegisterForClicks("LeftButtonUp")
    button.chainToggle:Hide()

    button.chainIcon = button.chainToggle:CreateTexture(nil, "OVERLAY")
    button.chainIcon:SetAllPoints()
    button.chainIcon:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\QuestChain.tga")
    button.chainIcon:SetTexCoord(0, 1, 0, 1)
    button.chainIcon:SetVertexColor(1, 1, 1)
    button.chainIcon:SetAlpha(1)

    button.chainToggle:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(L("REQUIRED_QUESTS"), 1, 0.82, 0.25)
        GameTooltip:AddLine(L("SHOW_WHOLE_CHAIN"), 0.85, 0.85, 0.85)
        GameTooltip:Show()
    end)
    button.chainToggle:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    button.chainToggle:SetScript("OnClick", function(self)
        local owner = self:GetParent()
        if not owner or not owner.questID then return end
        expandedQuestChains[owner.questID] = not expandedQuestChains[owner.questID]
        RefreshQuestList()
    end)

    button.chainPanel = CreateFrame("Frame", nil, button, "BackdropTemplate")
    button.chainPanel:SetPoint("TOPLEFT", button, "TOPLEFT", 39, -50)
    button.chainPanel:SetPoint("RIGHT", button, "RIGHT", -8, 0)
    SetBackdrop(
        button.chainPanel,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        8,
        1
    )
    button.chainPanel:SetBackdropColor(0.04, 0.035, 0.03, 0.72)
    button.chainPanel:SetBackdropBorderColor(0.34, 0.27, 0.16, 0.85)
    button.chainPanel:Hide()
    button.chainRows = {}

    button:SetScript("OnClick", function(self)
        -- Shift-click with a chat box open links the quest instead of selecting it.
        if not self.fdjRPGHidden and FDJ.TryLinkQuest and FDJ.TryLinkQuest(self.questID, self.fdjQuestName, self.fdjQuestLevel) then return end
        SelectQuest(self.questIndex)
    end)

    return button
end

local function MakeQuestRewardButton(parent)
    local button = CreateFrame("Button", nil, parent, "BackdropTemplate")
    button:SetSize(176, 46)

    SetBackdrop(
        button,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        9,
        2
    )

    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetSize(34, 34)
    button.icon:SetPoint("LEFT", 7, 0)
    button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    button.name = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    button.name:SetPoint("LEFT", button.icon, "RIGHT", 8, 0)
    button.name:SetPoint("RIGHT", -6, 0)
    button.name:SetJustifyH("LEFT")
    button.name:SetWordWrap(true)

    button:SetScript("OnEnter", function(self)
        HideSearchItemHighlight(self)
        if not self.item then return end
        self.fdjHoverColor = { 0.30, 0.22, 0.10 }
        self:SetBackdropColor(0.30, 0.22, 0.10, 1)
        ShowItemTooltip(self)
    end)

    button:SetScript("OnLeave", function(self)
        local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
        self.fdjHoverColor = nil
        self:SetBackdropColor(unpack(theme.lootRow))
        self.fdjComparing = nil
        if itemTooltip then itemTooltip:Hide() end
        HideComparisonTooltips()
    end)

    button:SetScript("OnUpdate", function(self)
        KeepHoverColor(self)
        UpdateItemComparison(self)
    end)

    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:SetScript("OnClick", function(self, mouseButton)
        if not self.item then return end
        if not self.item[1] or self.item[1] <= 0 then return end

        -- Right-click: add to / remove from Favourites, remembering the quest.
        if mouseButton == "RightButton" then
            if FDJ.ShowItemFavouriteMenu then
                local quests = DB[selectedDungeon] and DB[selectedDungeon].quests or {}
                local quest = quests[selectedQuest]
                local favItem = { self.item[1], self.item[2], nil, tonumber(self.item[3]) }
                FDJ.ShowItemFavouriteMenu(self, favItem, selectedDungeon, nil,
                    quest and { id = quest.id, name = quest.name } or nil)
            end
            return
        end

        -- An item with a recorded place (for example a quest object): a plain
        -- click marks that place on the map, like Show on Map.
        if self.fdjMapLocation and not (IsModifiedClick and (IsModifiedClick("CHATLINK") or IsModifiedClick("DRESSUP"))) then
            if itemTooltip then itemTooltip:Hide() end
            HideComparisonTooltips()
            local src = self.fdjMapLocation
            if src.dungeon and FDJ.ShowQuestSpotOnDungeonMap then -- mapquests: a spot in a dungeon
                FDJ.ShowQuestSpotOnDungeonMap(src)
                return
            end
            local loc = {
                mapID = src.mapID, x = src.x, y = src.y, markerType = src.markerType,
                label = FDJ.LocalizeFreeText and FDJ.LocalizeFreeText(src.label) or src.label,
                detail = FDJ.LocalizeFreeText and FDJ.LocalizeFreeText(src.detail) or src.detail,
            }
            ShowRecordedLocationOnMap(loc, loc.label)
            return
        end

        local _, link = ItemInfo(self.item[1])
        if link and IsModifiedClick and IsModifiedClick("CHATLINK") and ChatEdit_InsertLink then
            local used = ChatEdit_InsertLink(link)
            if used then return end
        end
        if link and IsModifiedClick and IsModifiedClick("DRESSUP") and DressUpItemLink then
            DressUpItemLink(link)
        end
    end)

    return button
end


local function MakeQuestNoteRewardButton(parent)
    -- Follow-up rewards use the exact same visual/tooltip behavior as normal
    -- quest rewards: icon + quality-colored name, full item tooltip on hover,
    -- Shift-hover comparison, and normal Shift-click chat linking.
    return MakeQuestRewardButton(parent)
end


local function CreateModeButton(parent, label, x)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetSize(96, 22)
    button:SetPoint("TOPRIGHT", x, -18)
    button:SetText(label)
    button.text = button.GetFontString and button:GetFontString() or nil
    if button.text then
        button.text:SetTextColor(1.00, 0.82, 0.27)
    end
    return button
end

local function UpdateModeTabs()
    if not frame or not frame.bossesTab or not frame.questsTab then return end
    local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
    local mapActive = frame.dungeonMapPanel and frame.dungeonMapPanel:IsShown() or false
    local routeActive = frame.routePanel and frame.routePanel:IsShown() or false
    local function style(tab, active)
        if not tab then return end
        if active then
            if tab.Disable then tab:Disable() end
            tab:SetAlpha(1)
            if tab.text then tab.text:SetTextColor(unpack(theme.title)) end
        else
            if tab.Enable then tab:Enable() end
            tab:SetAlpha(0.95)
            if tab.text then tab.text:SetTextColor(1.00, 0.82, 0.27) end
        end
    end
    style(frame.bossesTab, (not mapActive) and (not routeActive) and selectedMode == "bosses")
    style(frame.questsTab, (not mapActive) and (not routeActive) and selectedMode == "quests")
    if frame.mapTab and frame.mapTab:IsShown() then style(frame.mapTab, mapActive) end
    if frame.dungeonRouteButton and frame.dungeonRouteButton:IsShown() then
        style(frame.dungeonRouteButton, routeActive)
    end
    if FDJ.RPGStyleMapTab then FDJ.RPGStyleMapTab(frame.mapTab, selectedDungeon) end -- rpgpartial: greyed out
end

local function UpdateDungeonHeaderTabs()
    if not frame or not frame.bossesTab or not frame.questsTab then return end

    local currentDungeon = DB[selectedDungeon]
    if currentDungeon and (currentDungeon.recipeSearch or currentDungeon.lootFilterPage) then
        frame.questsTab:Hide()
        frame.bossesTab:Show()
        frame.bossesTab:ClearAllPoints()
        frame.bossesTab:SetSize(108, 30)
        frame.bossesTab:SetPoint("TOPRIGHT", -13, -14)
        if frame.mapTab then frame.mapTab:Hide() end
        if frame.dungeonRouteButton then frame.dungeonRouteButton:Hide() end
        return
    end

    -- sleepingbag: a page that is one quest chain has its Quests tab only.
    if currentDungeon and currentDungeon.questChainPage then
        frame.bossesTab:Hide()
        frame.questsTab:Show()
        frame.questsTab:ClearAllPoints()
        frame.questsTab:SetSize(108, 30)
        frame.questsTab:SetPoint("TOPRIGHT", -13, -14)
        if frame.mapTab then frame.mapTab:Hide() end
        if frame.dungeonRouteButton then frame.dungeonRouteButton:Hide() end
        if frame.dungeonMapPanel then frame.dungeonMapPanel:Hide() end
        return
    end

    -- Restore both normal tabs after leaving a hidden recipe-source page.
    frame.questsTab:Show()
    frame.bossesTab:Show()

    -- All dungeons now use the same larger two-tab layout.  The experimental
    -- dungeon-map tab is disabled for now until the map presentation is ready.
    frame.questsTab:ClearAllPoints()
    frame.questsTab:SetSize(108, 30)
    frame.questsTab:SetPoint("TOPRIGHT", -13, -14)

    frame.bossesTab:ClearAllPoints()
    frame.bossesTab:SetSize(108, 30)
    frame.bossesTab:SetPoint("TOPRIGHT", -127, -14)

    if frame.dungeonRouteButton and frame.dungeonRouteButton:IsShown() then
        frame.dungeonRouteButton:ClearAllPoints()
        frame.dungeonRouteButton:SetSize(96, 30)
        frame.dungeonRouteButton:SetPoint("LEFT", (frame.lfgButton and frame.lfgButton:IsShown()) and frame.lfgButton or frame.dungeonLocationButton, "RIGHT", 3, 0)
    end

    if frame.dungeonMapPanel then frame.dungeonMapPanel:Hide() end
    if frame.mapTab then
        if FDJ.DUNGEON_MAPS[selectedDungeon] then
            frame.mapTab:ClearAllPoints()
            frame.mapTab:SetSize(108, 30)
            -- Keep Map in its original tab slot: immediately left of Bosses.
            -- Route stays by the entrance/location button near the dungeon title.
            frame.mapTab:SetPoint("TOPRIGHT", -241, -14)
            frame.mapTab:SetText(L("MAP"))
            frame.mapTab:Show()
        else
            frame.mapTab:Hide()
        end
    end
    -- Announced dungeons: no boss or quest pages, so Map is the only tab.
    if currentDungeon and currentDungeon.previewOnly and frame.mapTab and FDJ.DUNGEON_MAPS[selectedDungeon] then
        frame.bossesTab:Hide()
        frame.questsTab:Hide()
        frame.mapTab:ClearAllPoints()
        frame.mapTab:SetPoint("TOPRIGHT", -13, -14)
    end
    -- Keep "Items Data TBD" just left of the leftmost visible header button,
    -- clear of the title and its Show Location icon.
    if frame.stockadeItemsTBD then
        -- Sits on the level line under the title ("LV 30-38   Items Data TBD"),
        -- which is always free, so long dungeon names never collide with it.
        frame.stockadeItemsTBD:ClearAllPoints()
        if frame.dungeonMeta then
            frame.stockadeItemsTBD:SetPoint("LEFT", frame.dungeonMeta, "RIGHT", 14, 0)
        else
            frame.stockadeItemsTBD:SetPoint("RIGHT", frame.bossesTab, "LEFT", -12, 0)
        end
    end

    -- UIPanelButtonTemplate normally swaps font objects on hover/disabled.
    -- Force the same object in every state so the labels never resize.
    for _, tab in ipairs({ frame.bossesTab, frame.questsTab, frame.mapTab }) do
        if tab.SetNormalFontObject then tab:SetNormalFontObject("GameFontNormal") end
        if tab.SetHighlightFontObject then tab:SetHighlightFontObject("GameFontNormal") end
        if tab.SetDisabledFontObject then tab:SetDisabledFontObject("GameFontNormal") end
        if tab.text then tab.text:SetFontObject("GameFontNormal") end
    end

    -- Boss icon: oversized skull that slightly overflows the button, matching
    -- the Forever quest-tab treatment.
    if not frame.bossesTab.fdjIcon then
        frame.bossesTab.fdjIcon = frame.bossesTab:CreateTexture(nil, "OVERLAY")
    end
    frame.bossesTab.fdjIcon:SetSize(26, 26)
    frame.bossesTab.fdjIcon:ClearAllPoints()
    frame.bossesTab.fdjIcon:SetPoint("LEFT", 3, 0)
    frame.bossesTab.fdjIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_8")
    frame.bossesTab.fdjIcon:Show()
    if frame.bossesTab.text then
        frame.bossesTab.text:ClearAllPoints()
        frame.bossesTab.text:SetPoint("CENTER", frame.bossesTab, "CENTER", 7, 0)
    end

    -- Quest icon: use the current Forever/Blizzard quest atlas when available.
    if not frame.questsTab.fdjIcon then
        frame.questsTab.fdjIcon = frame.questsTab:CreateTexture(nil, "OVERLAY")
    end
    frame.questsTab.fdjIcon:SetSize(27, 27)
    frame.questsTab.fdjIcon:ClearAllPoints()
    frame.questsTab.fdjIcon:SetPoint("LEFT", 3, 0)
    local atlasOK = false
    if frame.questsTab.fdjIcon.SetAtlas then
        atlasOK = pcall(frame.questsTab.fdjIcon.SetAtlas, frame.questsTab.fdjIcon, "QuestNormal", true)
    end
    if not atlasOK then
        frame.questsTab.fdjIcon:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon")
    end
    frame.questsTab.fdjIcon:Show()
    if frame.questsTab.text then
        frame.questsTab.text:ClearAllPoints()
        frame.questsTab.text:SetPoint("CENTER", frame.questsTab, "CENTER", 7, 0)
    end

    -- Map icon: use the supplied parchment-map icon in the same oversized
    -- left-side style as the Bosses skull and Quests exclamation mark.
    if frame.mapTab then
        if not frame.mapTab.fdjIcon then
            frame.mapTab.fdjIcon = frame.mapTab:CreateTexture(nil, "OVERLAY")
        end
        -- Same icon as the Bloody Map item (Ability_Spy), edges trimmed.
        frame.mapTab.fdjIcon:SetSize(24, 24)
        frame.mapTab.fdjIcon:ClearAllPoints()
        frame.mapTab.fdjIcon:SetPoint("LEFT", 5, 0)
        frame.mapTab.fdjIcon:SetTexture("Interface\\Icons\\Ability_Spy")
        frame.mapTab.fdjIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        -- Thin black frame around the icon.
        if not frame.mapTab.fdjIconBorder then
            frame.mapTab.fdjIconBorder = frame.mapTab:CreateTexture(nil, "ARTWORK", nil, 7)
            frame.mapTab.fdjIconBorder:SetColorTexture(0, 0, 0, 1)
        end
        frame.mapTab.fdjIconBorder:ClearAllPoints()
        frame.mapTab.fdjIconBorder:SetPoint("TOPLEFT", frame.mapTab.fdjIcon, "TOPLEFT", -1.5, 1.5)
        frame.mapTab.fdjIconBorder:SetPoint("BOTTOMRIGHT", frame.mapTab.fdjIcon, "BOTTOMRIGHT", 1.5, -1.5)
        frame.mapTab.fdjIconBorder:Show()
        frame.mapTab.fdjIcon:Show()
        if frame.mapTab.text then
            frame.mapTab.text:ClearAllPoints()
            frame.mapTab.text:SetPoint("CENTER", frame.mapTab, "CENTER", 7, 0)
        end
    end
    if FDJ.RPGStyleMapTab then FDJ.RPGStyleMapTab(frame.mapTab, selectedDungeon) end -- rpgpartial: greyed out
end

local function UpdateFactionButtons()
    if not frame or not frame.allianceQuestButton or not frame.hordeQuestButton then
        return
    end

    local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]

    local function Style(button, active, faction)
        if active then
            button:SetBackdropColor(unpack(theme.rowSelected))
            button:SetBackdropBorderColor(unpack(theme.title))
            button.icon:SetAlpha(1)
        else
            button:SetBackdropColor(unpack(theme.row))
            button:SetBackdropBorderColor(unpack(theme.border))
            button.icon:SetAlpha(0.55)
        end
    end

    Style(frame.allianceQuestButton, selectedQuestFaction == "Alliance", "Alliance")
    Style(frame.hordeQuestButton, selectedQuestFaction == "Horde", "Horde")
    -- sleepingbag: a quest chain page shows the character's faction only.
    local single = DB[selectedDungeon] and DB[selectedDungeon].questChainPage
    frame.allianceQuestButton:SetShown(not single)
    frame.hordeQuestButton:SetShown(not single)
end

local function BuildVisibleQuestIndexes()
    wipe(visibleQuestIndexes)

    local dungeon = DB[selectedDungeon]
    local quests = dungeon.quests or {}

    -- Repeatable quests (librams...) sit under a folded divider at the end of
    -- the list and never count towards the quest totals.
    local repeatables = {}
    for index, quest in ipairs(quests) do
        if QuestMatchesFaction(quest, selectedQuestFaction) and not quest.hideFromMainList then
            if quest.repeatable then
                repeatables[#repeatables + 1] = index
            else
                table.insert(visibleQuestIndexes, index)
            end
        end
    end
    FDJ.questMainCount = #visibleQuestIndexes
    FDJ.questRepeatCount = #repeatables
    if FDJ.questRepeatExpanded then
        for _, index in ipairs(repeatables) do table.insert(visibleQuestIndexes, index) end
    end

    local selectedVisible = false
    for _, index in ipairs(visibleQuestIndexes) do
        if index == selectedQuest then
            selectedVisible = true
            break
        end
    end

    -- Hidden quests may still be opened deliberately through an in-journal
    -- quest link (for optional/breadcrumb pages). Keep that page selected
    -- without adding it back to the normal quest list.
    if not selectedVisible and allowHiddenQuestSelection then
        local selected = quests[selectedQuest]
        if selected and selected.hideFromMainList and QuestMatchesFaction(selected, selectedQuestFaction) then
            selectedVisible = true
        end
    end

    if not selectedVisible then
        allowHiddenQuestSelection = false
        selectedQuest = visibleQuestIndexes[1] or 1
        for _, index in ipairs(visibleQuestIndexes) do -- rpgpartial: an unlocked one first
            if not (FDJ.RPGQuestHidden and FDJ.RPGQuestHidden(selectedDungeon, quests[index])) then
                selectedQuest = index
                break
            end
        end
        ForeverDungeonJournalDB.lastQuest = selectedQuest
    end
end

RefreshQuestList = function()
    if not frame or not frame.questContent then return end

    local dungeon = DB[selectedDungeon]
    local quests = dungeon.quests or {}
    local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]

    BuildVisibleQuestIndexes()
    UpdateFactionButtons()

    frame.questListTitle:SetText(L("QUESTS") .. "  |  " .. (FDJ.questMainCount or #visibleQuestIndexes))

    local contentHeight = 0
    local mainCount = FDJ.questMainCount or #visibleQuestIndexes
    local repeatCount = FDJ.questRepeatCount or 0
    local repeatLine = frame.questRepeatLine
    if repeatCount > 0 and not repeatLine then
        repeatLine = CreateFrame("Button", nil, frame.questContent)
        frame.questRepeatLine = repeatLine
        repeatLine:SetHeight(24)
        repeatLine.rule = repeatLine:CreateTexture(nil, "BACKGROUND")
        repeatLine.rule:SetHeight(1)
        repeatLine.rule:SetPoint("BOTTOMLEFT", 0, 0)
        repeatLine.rule:SetPoint("BOTTOMRIGHT", 0, 0)
        repeatLine.rule:SetColorTexture(0.48, 0.40, 0.27, 0.6)
        repeatLine.icon = repeatLine:CreateTexture(nil, "ARTWORK")
        repeatLine.icon:SetSize(16, 16)
        repeatLine.icon:SetPoint("LEFT", 4, 0)
        repeatLine.text = repeatLine:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        repeatLine.text:SetPoint("LEFT", repeatLine.icon, "RIGHT", 6, 0)
        repeatLine.text:SetJustifyH("LEFT")
        repeatLine:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
        repeatLine:SetScript("OnClick", function()
            FDJ.questRepeatExpanded = not FDJ.questRepeatExpanded
            RefreshQuestList()
        end)
    end
    for displayIndex = 1, math.max(#questButtons, #visibleQuestIndexes) do
        local button = questButtons[displayIndex]
        local questIndex = visibleQuestIndexes[displayIndex]

        if questIndex then
            if not button then
                button = MakeQuestButton(frame.questContent)
                questButtons[displayIndex] = button
            end
            -- Anchored every refresh: the first repeatable quest hangs under
            -- the "Repeatable Quests" divider instead of the quest above it.
            button:ClearAllPoints()
            if displayIndex == 1 then
                button:SetPoint("TOPLEFT", frame.questContent, "TOPLEFT", 0, 0)
            elseif displayIndex == mainCount + 1 and repeatLine then
                button:SetPoint("TOPLEFT", repeatLine, "BOTTOMLEFT", 0, -3)
            else
                button:SetPoint("TOPLEFT", questButtons[displayIndex - 1], "BOTTOMLEFT", 0, -3)
            end

            local quest = quests[questIndex]
            -- rpgpartial: RPG Mode, a quest not unlocked yet is a ??? row.
            local rpgHidden = FDJ.RPGQuestHidden and FDJ.RPGQuestHidden(selectedDungeon, quest) or false
            button.fdjRPGHidden = rpgHidden
            local complete = IsQuestFinished(quest.id)
            local inLog = IsQuestInLog(quest.id)
            local ready = complete and inLog and not FDJ.QuestTurnedIn(quest.id)

            button.questIndex = questIndex
            -- turninlabel: ready to hand in, "Turn in" beside the ?, the
            -- quest's name kept clear of it.
            if button.turnInLabel then
                button.turnInLabel:SetText(L("TURN_IN_LABEL"))
                button.turnInLabel:SetShown(ready == true)
                button.fdjTextRoom = ready and math.max(120, math.min(182, 203 - (button.turnInLabel:GetStringWidth() or 0))) or 182
                button.name:SetWidth(button.fdjTextRoom)
                button.meta:SetWidth(button.fdjTextRoom)
            end
            button.name:SetText(rpgHidden and "???" or QuestField(quest.id, "name", quest.name))
            button.meta:SetText(rpgHidden and "" or L("AVAILABLE_FROM_LEVEL", quest.requires))
            local titleHeight = math.max(14, button.name:GetStringHeight() or 14)
            local metaHeight = math.max(12, button.meta:GetStringHeight() or 12)
            local baseRowHeight = math.max(48, 9 + titleHeight + 5 + metaHeight + 10)
            local rowHeight = baseRowHeight

            button.questID = quest.id
            button.fdjQuestName = quest.name
            button.fdjQuestLevel = quest.level
            local rawChain = (not rpgHidden) and GetQuestPrereqChain(quest) or nil
            local chain = rawChain

            local chainExpanded = chain and expandedQuestChains[quest.id] == true

            if button.chainToggle then
                button.chainToggle:SetShown(chain ~= nil)
                button.chainToggle:ClearAllPoints()
                -- Keep the chain control directly to the right of the
                -- "Available from Level X" text. This keeps it away from long
                -- quest titles while leaving the faction/class icons on the far right.
                local metaWidth = button.meta:GetStringWidth() or 0
                button.chainToggle:SetPoint("LEFT", button.meta, "LEFT", metaWidth + 6, 0)
            end
            -- startsInDungeon = true on a quest forces the icon even when the
            -- quest has a chain (its chain starts inside the dungeon); the icon
            -- then sits to the right of the chain control.
            local rowIconOffset = (button.meta:GetStringWidth() or 0) + 6
            if chain and button.chainToggle then rowIconOffset = rowIconOffset + (button.chainToggle:GetWidth() or 20) + 4 end
            FDJ.SetRowDungeonIcon(button, (not rpgHidden) and (quest.startsInDungeon or ((not chain) and (FDJ.StartsInsideDungeon(quest.pickup)
                or FDJ.StartItemDropsIn(quest, selectedDungeon)))
                or (chain and FDJ.ChainStartsInside(quest, selectedDungeon) == true)), rowIconOffset)
            -- With a chain control, the faction icons leave no room to its
            -- right: stack the dungeon icon on top of the chain control.
            if chain and button.chainToggle and button.dungeonStartIcon and button.dungeonStartIcon:IsShown() then
                button.dungeonStartIcon:ClearAllPoints()
                button.dungeonStartIcon:SetPoint("BOTTOM", button.chainToggle, "TOP", 0, -2)
            end

            if chain and chainExpanded and button.chainPanel then
                local lineHeight = 18
                local panelHeight = 10 + (#chain * lineHeight) + 7
                button.chainPanel:ClearAllPoints()
                button.chainPanel:SetPoint("TOPLEFT", button, "TOPLEFT", 39, -baseRowHeight + 2)
                button.chainPanel:SetPoint("RIGHT", button, "RIGHT", -8, 0)
                button.chainPanel:SetHeight(panelHeight)
                button.chainPanel:Show()

                for chainIndex, step in ipairs(chain) do
                    local row = button.chainRows[chainIndex]
                    if not row then
                        row = CreateFrame("Button", nil, button.chainPanel)
                        row:SetHeight(lineHeight)
                        row:SetPoint("TOPLEFT", button.chainPanel, "TOPLEFT", 8, -5 - ((chainIndex - 1) * lineHeight))
                        row:SetPoint("RIGHT", button.chainPanel, "RIGHT", -6, 0)
                        row:RegisterForClicks("LeftButtonUp")

                        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                        row.text:SetPoint("LEFT", 0, 0)
                        row.text:SetJustifyH("LEFT")
                        if row.text.SetWordWrap then row.text:SetWordWrap(false) end

                        -- This is a SEPARATE completion tick for the prerequisite.
                        -- It is anchored directly after the prerequisite title.
                        -- The main quest's original completion tick is untouched.
                        row.statusIcon = row:CreateTexture(nil, "OVERLAY")
                        row.statusIcon:SetSize(12, 12)
                        row.statusIcon:Hide()

                        -- "YOU HAVE IT" when this step is in the quest log.
                        row.haveIt = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                        row.haveIt:SetPoint("RIGHT", row, "RIGHT", -2, 0)
                        row.haveIt:SetJustifyH("RIGHT")
                        row.haveIt:SetTextColor(1.00, 0.82, 0.10)
                        row.haveIt:SetShadowColor(0, 0, 0, 0.72)
                        row.haveIt:SetShadowOffset(1, -1)
                        row.haveIt:Hide()

                        row.selected = row:CreateTexture(nil, "BACKGROUND")
                        row.selected:SetAllPoints()
                        row.selected:SetTexture("Interface\\Buttons\\WHITE8X8")
                        row.selected:SetColorTexture(1, 0.82, 0.25, 0.18)
                        row.selected:Hide()

                        row.highlight = row:CreateTexture(nil, "HIGHLIGHT")
                        row.highlight:SetAllPoints()
                        row.highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
                        row.highlight:SetColorTexture(1, 0.82, 0.25, 0.10)

                        row:SetScript("OnClick", function(self)
                            if not self.step then return end
                            do
                                local d = self.step.id and QUEST_PREREQ_DETAILS[self.step.id]
                                if FDJ.TryLinkQuest and FDJ.TryLinkQuest(self.step.id, self.step.name, d and d.level) then return end
                            end
                            selectedPrereqStep = self.step
                            selectedPrereqParentQuestName = self.parentQuestName
                            selectedPrereqParentQuestID = self.parentQuestID
                            if self.step.id then RequestQuestRewardData(self.step.id) end
                            RefreshQuestList()
                            RefreshQuestDetail()
                        end)
                        row:SetScript("OnEnter", nil)
                        row:SetScript("OnLeave", nil)

                        button.chainRows[chainIndex] = row
                    end

                    row.step = step
                    row.parentQuestName = quest.name
                    row.parentQuestID = quest.id

                    if row.selected then
                        local isSelected = selectedPrereqStep
                            and selectedPrereqStep.id
                            and step.id
                            and selectedPrereqStep.id == step.id
                        row.selected:SetShown(isSelected == true)
                    end

                    if row.statusIcon then
                        row.statusIcon:Hide()
                        row.statusIcon:SetTexture(nil)
                    end

                    local prefix = tostring(chainIndex) .. ". "
                    if step.id and IsQuestFinished(step.id) then
                        if row.statusIcon then
                            -- Still to hand in: the quest ? instead of the tick.
                            row.statusIcon:SetTexture(FDJ.QuestTurnedIn(step.id) and "Interface\\RaidFrame\\ReadyCheck-Ready"
                                or "Interface\\GossipFrame\\ActiveQuestIcon")
                            row.statusIcon:SetTexCoord(0, 1, 0, 1)
                            row.statusIcon:Show()
                        end
                        if FDJ.QuestTurnedIn(step.id) then
                            row.text:SetTextColor(0.45, 0.95, 0.50)
                        else
                            row.text:SetTextColor(1.00, 0.83, 0.28)
                        end
                    elseif step.id and IsQuestInLog(step.id) then
                        row.text:SetTextColor(1.00, 0.83, 0.28)
                    else
                        row.text:SetTextColor(0.78, 0.74, 0.66)
                    end
                    row.text:SetText(prefix .. QuestField(step.id, "name", step.name))
                    if row.haveIt then
                        row.text:SetWidth(0)
                        if step.id and not IsQuestFinished(step.id) and IsQuestInLog(step.id) then
                            -- Same label as the quest rows; shrink long translations a little.
                            row.haveIt:SetFontObject("GameFontNormalSmall")
                            row.haveIt:SetScale(1)
                            row.haveIt:SetText(L("YOU_HAVE_IT"))
                            local labelWidth = row.haveIt:GetStringWidth() or 0
                            if labelWidth > 88 then
                                row.haveIt:SetScale(math.max(0.80, 88 / labelWidth))
                                labelWidth = 88
                            end
                            row.haveIt:Show()
                            -- Keep a long step title clear of the label.
                            local room = (row:GetWidth() or 0) - labelWidth - 8
                            if room > 40 and (row.text:GetStringWidth() or 0) > room then
                                row.text:SetWidth(room)
                            end
                        else
                            row.haveIt:Hide()
                        end
                    end

                    -- Put the prerequisite tick literally beside its title.
                    -- Example: "1. Underground Map  ✓"
                    -- Because row.text now has only a LEFT anchor, its RIGHT edge
                    -- tracks the actual rendered text instead of the full row width.
                    if row.statusIcon and row.statusIcon:IsShown() then
                        row.statusIcon:ClearAllPoints()
                        row.statusIcon:SetPoint("LEFT", row.text, "RIGHT", 5, 0)
                    end

                    row:Show()
                end

                for chainIndex = #chain + 1, #button.chainRows do
                    button.chainRows[chainIndex]:Hide()
                end

                rowHeight = baseRowHeight + panelHeight + 4
            else
                if button.chainPanel then button.chainPanel:Hide() end
                if button.chainRows then
                    for _, row in ipairs(button.chainRows) do row:Hide() end
                end
            end

            button:SetHeight(rowHeight)
            contentHeight = contentHeight + rowHeight + 3
            if displayIndex == mainCount and repeatLine and repeatCount > 0 then
                contentHeight = contentHeight + 27 -- the divider line below
            end

            local both = quest.faction == "Both" or quest.faction == "Neutral"
            local iconTopY = (inLog and not complete) and -27 or -8
            local _, _, _, _, questClassToken = GetQuestClassRestriction(quest)
            button.allianceIcon:SetShown(both or quest.faction == "Alliance")
            button.hordeIcon:SetShown(both or quest.faction == "Horde")

            if button.classIcon then
                if questClassToken then
                    SetQuestRestrictionIcon(button.classIcon, questClassToken)
                    button.classIcon:Show()
                else
                    button.classIcon:Hide()
                end
            end

            if both then
                button.allianceIcon:ClearAllPoints()
                button.hordeIcon:ClearAllPoints()
                if button.classIcon and button.classIcon:IsShown() then
                    button.allianceIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -72, iconTopY)
                    button.hordeIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -50, iconTopY)
                    button.classIcon:ClearAllPoints()
                    button.classIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -28, iconTopY)
                else
                    button.allianceIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -50, iconTopY)
                    button.hordeIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -28, iconTopY)
                end
            elseif quest.faction == "Alliance" then
                button.allianceIcon:ClearAllPoints()
                if button.classIcon and button.classIcon:IsShown() then
                    button.allianceIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -50, iconTopY)
                    button.classIcon:ClearAllPoints()
                    button.classIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -28, iconTopY)
                else
                    button.allianceIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -31, iconTopY)
                end
            elseif quest.faction == "Horde" then
                button.hordeIcon:ClearAllPoints()
                if button.classIcon and button.classIcon:IsShown() then
                    button.hordeIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -50, iconTopY)
                    button.classIcon:ClearAllPoints()
                    button.classIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -28, iconTopY)
                else
                    button.hordeIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -31, iconTopY)
                end
            else
                if button.classIcon and button.classIcon:IsShown() then
                    button.classIcon:ClearAllPoints()
                    button.classIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -31, iconTopY)
                end
            end
            if rpgHidden then -- rpgpartial: nothing to tell it by
                button.allianceIcon:Hide()
                button.hordeIcon:Hide()
                if button.classIcon then button.classIcon:Hide() end
            end
            if button.icon and button.icon.SetDesaturated then button.icon:SetDesaturated(rpgHidden) end
            -- bigready: ready to hand in, the big ? alone; a class quest's
            -- icon moves to its left. Handed in: the tick and faction icons.
            if ready and button.turnIn then
                button.allianceIcon:Hide()
                button.hordeIcon:Hide()
                if button.classIcon and button.classIcon:IsShown() then
                    button.classIcon:ClearAllPoints()
                    button.classIcon:SetPoint("TOPRIGHT", button, "TOPRIGHT", -52, iconTopY)
                end
            end

            if selectedQuest == questIndex then
                button:SetBackdropColor(unpack(theme.rowSelected))
                button:SetBackdropBorderColor(unpack(theme.border))
                button.name:SetTextColor(unpack(theme.title))
            else
                button:SetBackdropColor(unpack(theme.row))
                button:SetBackdropBorderColor(unpack(theme.border))
                button.name:SetTextColor(unpack(theme.muted))
            end

            button.meta:SetTextColor(unpack(theme.muted))
            button.completeGlow:SetShown(complete and not ready)
            button.check:SetShown(complete and not (ready and button.turnIn))
            if button.turnIn then
                FDJ.SetTurnInButton(button.turnIn, ready and quest or nil, QuestField(quest.id, "name", quest.name))
            end
            if button.UpdateHaveItLabel then button:UpdateHaveItLabel() end
            button.haveIt:SetShown(inLog and not complete)

            if complete and not ready then
                button.name:SetTextColor(0.30, 1.00, 0.36)
            end

            button:Show()
        elseif button then
            button:Hide()
        end
    end

    if repeatLine then
        if repeatCount > 0 then
            local open = FDJ.questRepeatExpanded and true or false
            repeatLine.text:SetText(L(open and "REPEAT_HIDE" or "REPEAT_SHOW", repeatCount))
            repeatLine.icon:SetTexture(open and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
            repeatLine:ClearAllPoints()
            if mainCount > 0 and questButtons[mainCount] then
                repeatLine:SetPoint("TOPLEFT", questButtons[mainCount], "BOTTOMLEFT", 0, -3)
            else
                repeatLine:SetPoint("TOPLEFT", frame.questContent, "TOPLEFT", 0, 0)
                if mainCount == 0 then contentHeight = contentHeight + 27 end
            end
            repeatLine:SetWidth((questButtons[1] and questButtons[1]:GetWidth()) or 296)
            repeatLine:Show()
        else
            repeatLine:Hide()
        end
    end

    contentHeight = math.max(1, contentHeight - 3)
    frame.questContent:SetHeight(contentHeight)
    UpdateScrollBarVisibility(frame.questListScroll, contentHeight)
    if FDJ.UpdateQuestTrackButton then FDJ.UpdateQuestTrackButton(selectedDungeon) end -- questtracker
end

local function GetQuestLogIndexForQuestIDSafe(questID)
    if type(questID) ~= "number" then return nil end
    if type(GetQuestLogIndexByID) == "function" then
        local ok, index = pcall(GetQuestLogIndexByID, questID)
        if ok and type(index) == "number" and index > 0 then return index end
    end
    if C_QuestLog and type(C_QuestLog.GetLogIndexForQuestID) == "function" then
        local ok, index = pcall(C_QuestLog.GetLogIndexForQuestID, questID)
        if ok and type(index) == "number" and index > 0 then return index end
    end
    return nil
end

local function GetLoadedQuestTitle(questID, fallback)
    local localizedFallback = QuestField(questID, "name", fallback or "Required quest")
    local canUseClient = not FDJ.CanUseClientLocalizedText or FDJ.CanUseClientLocalizedText()
    if canUseClient and type(questID) == "number" and C_QuestLog then
        local getter = C_QuestLog.GetTitleForQuestID or C_QuestLog.GetQuestInfo
        if type(getter) == "function" then
            local ok, title = pcall(getter, questID)
            if ok and not IsSecret(title) and type(title) == "string" and title ~= "" then
                return title
            end
        end
    end
    return localizedFallback
end

-- Returns the rewards to show first, whether they are a choice, and the fixed
-- rewards that come on top of a choice ("You will also receive").
local function GetPrerequisiteRewardItems(questID)
    local fixed, choices = {}, {}

    local function addRewards(countFunc, infoFunc, list)
        if type(countFunc) ~= "function" or type(infoFunc) ~= "function" then return end
        local okCount, count = pcall(countFunc, questID)
        if not okCount or type(count) ~= "number" then return end

        for i = 1, count do
            local ok, name, texture, numItems, quality, isUsable, itemID = pcall(infoFunc, i, questID)
            if ok and type(itemID) == "number" and itemID > 0 then
                list[#list + 1] = { itemID, name or ("Item " .. itemID), quality or 1 }
            end
        end
    end

    addRewards(GetNumQuestLogRewards, GetQuestLogRewardInfo, fixed)
    addRewards(GetNumQuestLogChoices, GetQuestLogChoiceInfo, choices)

    if #fixed == 0 and #choices == 0 then
        local fallback = PREREQ_REWARD_ITEMS_FALLBACK[questID]
        if fallback and fallback.items then
            local list = fallback.choice and choices or fixed
            for _, item in ipairs(fallback.items) do list[#list + 1] = item end
            for _, item in ipairs(fallback.also or {}) do fixed[#fixed + 1] = item end
        end
    end

    if #choices > 0 then return choices, true, fixed end
    return fixed, false, {}
end

local function GetPrerequisiteRewardXP(questID)
    return GetLiveQuestXP({ id = questID })
end

local function GetPrerequisiteRewardMoney(questID)
    local fallback = PREREQ_REWARD_MONEY_FALLBACK[questID]
    if type(fallback) == "number" and fallback > 0 then
        return fallback
    end
    if type(GetQuestLogRewardMoney) ~= "function" then return 0 end
    local ok, value = pcall(GetQuestLogRewardMoney, questID)
    if ok and not IsSecret(value) and type(value) == "number" and value > 0 then
        return value
    end
    return 0
end

local function SelectPrerequisiteStepByOffset(offset)
    local chain = selectedPrereqParentQuestID and QUEST_PREREQ_CHAINS[selectedPrereqParentQuestID]
    if not chain or not selectedPrereqStep then return end
    local currentIndex
    for i, chainStep in ipairs(chain) do
        if chainStep == selectedPrereqStep or (chainStep.id and selectedPrereqStep.id and chainStep.id == selectedPrereqStep.id) then
            currentIndex = i
            break
        end
    end
    if not currentIndex then return end
    local target = chain[currentIndex + offset]
    if not target then return end
    selectedPrereqStep = target
    if target.id then RequestQuestRewardData(target.id) end
    RefreshQuestList()
    RefreshQuestDetail()
end

local function UpdatePrerequisiteNavButtons()
    if not frame or not frame.questPrevStepButton or not frame.questNextStepButton then return end
    local chain = selectedPrereqParentQuestID and QUEST_PREREQ_CHAINS[selectedPrereqParentQuestID]
    if not chain or not selectedPrereqStep then
        frame.questPrevStepButton:Hide()
        frame.questNextStepButton:Hide()
        return
    end
    local currentIndex
    for i, chainStep in ipairs(chain) do
        if chainStep == selectedPrereqStep or (chainStep.id and selectedPrereqStep.id and chainStep.id == selectedPrereqStep.id) then
            currentIndex = i
            break
        end
    end
    frame.questPrevStepButton:SetShown(currentIndex and currentIndex > 1 or false)
    frame.questNextStepButton:SetShown(currentIndex and currentIndex < #chain or false)
end

-- Keep the reader's scroll position when the SAME quest page is redrawn.
-- The page is rebuilt whenever item or quest data arrives or the quest log
-- changes; resetting to the top on every rebuild made the view jump back up
-- while the player was reading the rewards. Only a different page starts at
-- the top. Stored on FDJ to stay under Lua's 200-locals limit for this file.
FDJ.ApplyQuestDetailScroll = function(pageKey, contentHeight)
    local scroll = frame and frame.questDetailScroll
    if not scroll then return end
    FDJ._questDetailScrollByPage = FDJ._questDetailScrollByPage or {}
    if FDJ._questDetailPageKey ~= pageKey then
        FDJ._questDetailPageKey = pageKey
        FDJ._questDetailScrollByPage[pageKey] = 0
    end
    local desired = FDJ._questDetailScrollByPage[pageKey] or 0
    local maxScroll = math.max(0, (contentHeight or 0) - (scroll:GetHeight() or 0))
    local target = math.max(0, math.min(desired, maxScroll))
    FDJ._restoringQuestDetailScroll = true
    scroll:SetVerticalScroll(target)
    local scrollBar = GetScrollBar(scroll)
    if scrollBar then
        if scrollBar.SetMinMaxValues then scrollBar:SetMinMaxValues(0, maxScroll) end
        if scrollBar.SetValue then scrollBar:SetValue(target) end
    end
    FDJ._restoringQuestDetailScroll = nil
end

-- Item rows on a chain-step page: the items the step asks for and the item the
-- quest giver hands over. Each row is a normal item button, so hovering shows the
-- item tooltip followed by where the item comes from.
-- Shift-click quest linking. Returns true when something was put in the chat box.
FDJ.TryLinkQuest = function(questID, name, level)
    if type(questID) ~= "number" or questID <= 0 or not IsModifiedClick or not IsModifiedClick("CHATLINK") then return false end
    if not ChatEdit_InsertLink then return false end
    if type(ChatEdit_GetActiveWindow) == "function" and not ChatEdit_GetActiveWindow() then return false end
    local title = name
    if C_QuestLog and type(C_QuestLog.GetQuestInfo) == "function" then
        local ok, live = pcall(C_QuestLog.GetQuestInfo, questID)
        if ok and type(live) == "string" and live ~= "" then title = live end
    end
    title = title or ("Quest " .. tostring(questID))
    local link
    if type(GetQuestLink) == "function" then
        local ok, live = pcall(GetQuestLink, questID)
        if ok and type(live) == "string" and live ~= "" then link = live end
    end
    if not link then
        local questLevel = tonumber(level) or -1
        link = "|cffffff00|Hquest:" .. tostring(questID) .. ":" .. tostring(questLevel) .. "|h[" .. title .. "]|h|r"
    end
    if ChatEdit_InsertLink(link) then return true end
    -- The client refused the hyperlink: fall back to plain text.
    return ChatEdit_InsertLink("[" .. title .. "]") and true or false
end

FDJ.QuestTurnedIn = function(questID)
    if not questID then return false end
    if C_QuestLog and type(C_QuestLog.IsQuestFlaggedCompleted) == "function" then
        local ok, value = pcall(C_QuestLog.IsQuestFlaggedCompleted, questID)
        return ok and value == true
    elseif type(IsQuestFlaggedCompleted) == "function" then
        local ok, value = pcall(IsQuestFlaggedCompleted, questID)
        return ok and value == true
    end
    return false
end

FDJ.HideStepItemButtons = function()
    if not frame then return end
    for _, button in ipairs(frame.questStepItemButtons or {}) do
        button.item = nil
        button.fdjSourceText = nil
        button.fdjMapLocation = nil
        button:Hide()
    end
    if frame.questProvidedItemHeader then frame.questProvidedItemHeader:Hide() end
    if frame.questChainNotice then frame.questChainNotice:Hide() end
    if frame.questWarningText then frame.questWarningText:Hide() end
end

FDJ.PlaceStepItemButtons = function(items, startIndex, cursorY, width)
    frame.questStepItemButtons = frame.questStepItemButtons or {}
    local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
    for i, item in ipairs(items) do
        local index = startIndex + i
        local button = frame.questStepItemButtons[index]
        if not button then
            button = MakeQuestRewardButton(frame.questDetailContent)
            frame.questStepItemButtons[index] = button
        end
        button.item = item
        if FDJ.UpdateFavouriteIndicator then FDJ.UpdateFavouriteIndicator(button, item[1]) end
        button.fdjSourceText = item[4] and FreeText(item[4]) or nil
        button.fdjMapLocation = item.map
        button:SetSize(width, 42)
        button.icon:SetTexture(ItemIcon(item[1]))
        if C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
            pcall(C_Item.RequestLoadItemDataByID, item[1])
        end
        local itemName, itemLink, quality = ItemInfo(item[1])
        local r, g, b = GetAuthoritativeItemQuality(item[1], itemLink, quality, item[3] or 1)
        button.name:SetText(itemName or item[2])
        button.name:SetTextColor(r, g, b)
        button:SetBackdropColor(unpack(theme.lootRow))
        button:SetBackdropBorderColor(unpack(theme.border))
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        button:Show()
        cursorY = cursorY + 46
    end
    return cursorY
end

local function RefreshPrerequisiteQuestDetail(step)
    if not frame or not step then return false end

    local questID = step.id
    -- Item steps (e.g. the Data Rescue punch cards) are not real quests:
    -- never query the quest API for their placeholder IDs.
    local isItemStep = step.itemStep
    if questID and not isItemStep then RequestQuestRewardData(questID) end

    local title = isItemStep and QuestField(questID, "name", step.name) or GetLoadedQuestTitle(questID, step.name)
    local complete = (questID and not isItemStep and IsQuestFinished(questID)) or false
    local inLog = (questID and not isItemStep and IsQuestInLog(questID)) or false
    local logIndex = (questID and not isItemStep and GetQuestLogIndexForQuestIDSafe(questID)) or nil
    local details = (questID and QUEST_PREREQ_DETAILS[questID]) or {}
    local level = step.level or details.level
    local requiredLevel = step.requires or details.requires
    local description = QuestField(questID, "description", details.description)
    local objectiveText = QuestField(questID, "objective", details.objective)
    if details.suppressDescription then description = nil end
    local canUseClientQuestText = not FDJ.CanUseClientLocalizedText or FDJ.CanUseClientLocalizedText()

    if logIndex and canUseClientQuestText then
        if C_QuestLog and type(C_QuestLog.GetInfo) == "function" then
            local ok, info = pcall(C_QuestLog.GetInfo, logIndex)
            if ok and type(info) == "table" and type(info.level) == "number" and info.level > 0 then
                level = info.level
            end
        end
        if type(GetQuestLogQuestText) == "function" then
            local ok, desc, obj = pcall(GetQuestLogQuestText, logIndex)
            if ok then
                -- The game's quest description (story text) is left out on purpose.
                if not IsSecret(obj) and type(obj) == "string" and obj ~= "" then objectiveText = obj end
            end
        end
    end

    if inLog and canUseClientQuestText and questID and C_QuestLog and type(C_QuestLog.GetQuestObjectives) == "function" then
        local ok, objectives = pcall(C_QuestLog.GetQuestObjectives, questID)
        if ok and type(objectives) == "table" and #objectives > 0 then
            local parts = {}
            for _, objective in ipairs(objectives) do
                if type(objective) == "table" and not IsSecret(objective.text)
                    and type(objective.text) == "string" and objective.text ~= "" then
                    parts[#parts + 1] = objective.text
                end
            end
            if #parts > 0 then objectiveText = table.concat(parts, "\n") end
        end
    end

    if frame.questDetailScroll then frame.questDetailScroll:Show() end
    if frame.noQuestMessage then frame.noQuestMessage:Hide() end

    frame.selectedQuestName:SetText(title)
    frame.selectedQuestName:SetTextColor(1.00, 0.78, 0.16)
    frame.selectedQuestName:ClearAllPoints()
    frame.selectedQuestName:SetPoint("TOPLEFT", frame.questTextInset, "TOPLEFT", 16, -15)
    frame.selectedQuestName:SetPoint("RIGHT", frame.questTextInset, "RIGHT", -92, 0)

    local meta = L("REQUIRED_PREREQUISITE")
    if requiredLevel then
        meta = meta .. "  |  " .. L("AVAILABLE_FROM_LEVEL", tostring(requiredLevel))
    end
    frame.selectedQuestMeta:SetText(meta)
    frame.selectedQuestMeta:SetTextColor(0.25, 0.16, 0.08)
    if frame.selectedQuestClass then frame.selectedQuestClass:Hide() end
    if frame.selectedQuestClassIcon then frame.selectedQuestClassIcon:Hide() end
    if frame.selectedQuestMetaClassIcon then frame.selectedQuestMetaClassIcon:Hide() end
    local stepReady = complete and not FDJ.QuestTurnedIn(questID)
    frame.selectedQuestComplete:SetShown(complete and not (stepReady and frame.selectedQuestTurnIn))
    if frame.selectedQuestTurnIn then
        FDJ.SetTurnInButton(frame.selectedQuestTurnIn, stepReady and { id = questID, turnin = details.turnin, turninMap = details.turninMap } or nil, title)
    end
    UpdatePrerequisiteNavButtons()

    -- Prerequisite/quest-chain steps use the same shareability control as
    -- normal dungeon quests. Keep it to the left of the chain navigation
    -- arrows so neither control overlaps the other.
    local prereqShareInset = 92
    if questID and frame.questShareButton then
        FDJ.UpdateQuestShareButton(questID, nil)
        local shareWidth = frame.questShareButton:GetWidth() or 76
        frame.questShareButton:ClearAllPoints()
        frame.questShareButton:SetPoint("TOPRIGHT", frame.questTextInset, "TOPRIGHT", -82, -10)
        prereqShareInset = 94 + shareWidth
    elseif frame.questShareButton then
        frame.questShareButton.questID = nil
        frame.questShareButton:Hide()
    end

    frame.selectedQuestName:ClearAllPoints()
    frame.selectedQuestName:SetPoint("TOPLEFT", frame.questTextInset, "TOPLEFT", 16, -15)
    frame.selectedQuestName:SetPoint("RIGHT", frame.questTextInset, "RIGHT", -prereqShareInset, 0)
    -- Placed here, after the title got its final width (the Share button narrows it).
    -- Chain step pages: the step arrows sit top right, so the tick goes
    -- directly after the title text instead.
    frame.selectedQuestComplete:ClearAllPoints()
    do
        local title = frame.selectedQuestName
        if not frame.fdjTitleMeasure then
            frame.fdjTitleMeasure = frame:CreateFontString(nil, "BACKGROUND")
            frame.fdjTitleMeasure:Hide()
        end
        do
            local fontFile, fontSize, fontFlags = title:GetFont()
            if fontFile then frame.fdjTitleMeasure:SetFont(fontFile, fontSize, fontFlags) end
            frame.fdjTitleMeasure:SetText(title:GetText() or "")
        end
        local textWidth = frame.fdjTitleMeasure:GetStringWidth() or 0
        local boxWidth = title:GetWidth() or 0
        if boxWidth > 0 and textWidth > boxWidth then
            -- The title wraps: put the tick after the end of its LAST line, so it
            -- never sits under the Share button. The wrap is re-created word by
            -- word with a hidden measuring string in the same font.
            if not frame.fdjTitleMeasure then
                frame.fdjTitleMeasure = frame:CreateFontString(nil, "BACKGROUND")
                frame.fdjTitleMeasure:Hide()
            end
            local measure = frame.fdjTitleMeasure
            local fontFile, fontSize, fontFlags = title:GetFont()
            if fontFile then measure:SetFont(fontFile, fontSize, fontFlags) end
            local line, lastWidth = "", 0
            for word in tostring(title:GetText() or ""):gmatch("%S+") do
                local try = (line == "") and word or (line .. " " .. word)
                measure:SetText(try)
                local w = measure:GetStringWidth() or 0
                if line ~= "" and w > boxWidth then
                    line = word
                    measure:SetText(word)
                    lastWidth = measure:GetStringWidth() or 0
                else
                    line, lastWidth = try, w
                end
            end
            if lastWidth > boxWidth - 22 then lastWidth = boxWidth - 22 end
            frame.selectedQuestComplete:SetPoint("BOTTOMLEFT", title, "BOTTOMLEFT", lastWidth + 6, -2)
        else
            frame.selectedQuestComplete:SetPoint("LEFT", title, "LEFT", textWidth + 6, 0)
        end
    end

    local detailWidth = math.max(260, (frame.questDetailScroll:GetWidth() or 350) - 4)
    frame.questDetailContent:SetWidth(detailWidth)
    frame.questDetailText:SetWidth(detailWidth)
    frame.questNotesText:SetWidth(detailWidth)
    if FDJ.HideQuestDescription then FDJ.HideQuestDescription(frame) end

    if frame.questStartsHeader then frame.questStartsHeader:Hide() end
    if frame.questTurninHeader then frame.questTurninHeader:Hide() end
    if frame.questMapButton then
        frame.questMapButton.quest = nil
        frame.questMapButton.prereqLocation = nil
        frame.questMapButton.fdjLabelKey = nil
        if frame.questMapButton.icon then frame.questMapButton.icon:Hide() end
        frame.questMapButton:Hide()
    end
    if frame.questChainButton then
        frame.questChainButton.questID = nil
        frame.questChainButton.parentQuestName = nil
        frame.questChainButton:Hide()
    end
    if frame.questStartLinkButton then
        frame.questStartLinkButton.questID = nil
        frame.questStartLinkButton:Hide()
    end
    if frame.questLeadsToButton then
        frame.questLeadsToButton.questID = nil
        frame.questLeadsToButton:Hide()
    end
    if frame.questStartItemButton then frame.questStartItemButton.item = nil; frame.questStartItemButton:Hide() end
    if frame.questRequiredItemsHeader then frame.questRequiredItemsHeader:Hide() end
    if frame.questRequiredItemButton then frame.questRequiredItemButton.item = nil; frame.questRequiredItemButton:Hide() end
    if frame.questNoteItemButton then frame.questNoteItemButton.item = nil; frame.questNoteItemButton:Hide() end
    FDJ.HideStepItemButtons()
    if frame.questStartsText then frame.questStartsText:SetText(""); frame.questStartsText:Hide() end
    if frame.questStartDungeonIcon then frame.questStartDungeonIcon:Hide() end
    if frame.questTurninText then frame.questTurninText:SetText(""); frame.questTurninText:Hide() end

    for _, button in ipairs(questRewardButtons) do button.item = nil; button:Hide() end
    for _, button in ipairs(questNoteRewardButtons) do button.item = nil; button:Hide() end
    if frame.questAdditionalRewardButtons then
        for _, button in ipairs(frame.questAdditionalRewardButtons) do button.item = nil; button:Hide() end
    end
    if frame.questXPReward then frame.questXPReward:Hide() end
    if frame.questMoneyReward then frame.questMoneyReward:Hide() end
    if frame.questAlsoReceiveHeader then frame.questAlsoReceiveHeader:Hide() end
    frame.questRewardHeader:SetText("")
    frame.questRewardSummary:SetText("")
    if FDJ.LayoutRepPills then FDJ.LayoutRepPills({}, 0, 0) end

    local cursorY = 0
    frame.questObjectiveHeader:ClearAllPoints()
    frame.questObjectiveHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
    frame.questObjectiveHeader:Show()
    cursorY = cursorY + (frame.questObjectiveHeader:GetStringHeight() or 18) + 4

    frame.questDetailText:ClearAllPoints()
    frame.questDetailText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
    local body = objectiveText or description
    if not body or body == "" then
        if inLog then
            body = L("QUEST_IN_LOG")
        elseif complete then
            body = L("QUEST_COMPLETED")
        else
            body = L("QUEST_NOT_CACHED")
        end
    elseif description and objectiveText and description ~= objectiveText then
        body = objectiveText .. "\n\n" .. description
    end
    frame.questDetailText:SetText(body)
    frame.questDetailText:SetTextColor(0.10, 0.065, 0.025)
    frame.questDetailText:Show()
    cursorY = cursorY + (frame.questDetailText:GetStringHeight() or 40) + 14

    local stepRequired = details.requiredItems
    -- Required-item cards are only useful when we can tell the player where the
    -- item comes from. Bare item icons duplicate the quest objective and waste
    -- a large amount of vertical space.
    if stepRequired and #stepRequired > 0 and frame.questRequiredItemsHeader then
        local usefulRequired = {}
        for _, requiredItem in ipairs(stepRequired) do
            if type(requiredItem[4]) == "string" and requiredItem[4] ~= "" then
                usefulRequired[#usefulRequired + 1] = requiredItem
            end
        end
        if #usefulRequired > 0 then
            frame.questRequiredItemsHeader:ClearAllPoints()
            frame.questRequiredItemsHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questRequiredItemsHeader:Show()
            cursorY = cursorY + (frame.questRequiredItemsHeader:GetStringHeight() or 18) + 4
            cursorY = FDJ.PlaceStepItemButtons(usefulRequired, 0, cursorY, math.min(300, detailWidth)) + 8
        else
            frame.questRequiredItemsHeader:Hide()
        end
    end
    if details.providedItem and frame.questProvidedItemHeader then
        frame.questProvidedItemHeader:ClearAllPoints()
        frame.questProvidedItemHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questProvidedItemHeader:Show()
        cursorY = cursorY + (frame.questProvidedItemHeader:GetStringHeight() or 18) + 4
        cursorY = FDJ.PlaceStepItemButtons({ details.providedItem }, stepRequired and #stepRequired or 0, cursorY, math.min(300, detailWidth)) + 8
    end


    if details.pickup and details.pickup ~= "" then
        frame.questStartsHeader:ClearAllPoints()
        frame.questStartsHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questStartsHeader:Show()
        cursorY = cursorY + (frame.questStartsHeader:GetStringHeight() or 18) + 3

        if details.startObject and not details.startItem and frame.questStartItemButton then
            -- Pre-quest started by a world object: same card as a start item.
            local obj = details.startObject
            frame.questStartsText:SetText("")
            frame.questStartsText:Hide()
            frame.questStartItemButton.item = nil
            frame.questStartItemButton.fdjSourceText = nil
            frame.questStartItemButton.fdjObject = { FreeText(obj[1]), FreeText(obj[3]) }
            frame.questStartItemButton.icon:SetTexture(obj[2] or "Interface\\Icons\\INV_Misc_QuestionMark")
            frame.questStartItemButton.name:SetText(FreeText(obj[1]))
            frame.questStartItemButton.name:SetTextColor(1, 1, 1)
            local objTheme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
            frame.questStartItemButton:SetBackdropColor(unpack(objTheme.lootRow))
            frame.questStartItemButton:SetBackdropBorderColor(unpack(objTheme.border))
            frame.questStartItemButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questStartItemButton:Show()
            -- FDJ_START_CARD_DUNGEON_ICON
            if frame.questStartDungeonIcon then
                frame.questStartDungeonIcon:Hide()
                if details.startsInDungeon or FDJ.StartsInsideDungeon(details.pickup) then FDJ.PositionInDungeonIcon() end
            end
            cursorY = cursorY + 48
        elseif details.startItem and frame.questStartItemButton then
            local startItem = details.startItem
            frame.questStartItemButton.fdjObject = nil
            frame.questStartsText:SetText("")
            frame.questStartsText:Hide()

            frame.questStartItemButton.item = startItem
            frame.questStartItemButton.fdjSourceText = FreeText(startItem[4])
            frame.questStartItemButton.icon:SetTexture(ItemIcon(startItem[1]))
            local itemName = ItemInfo(startItem[1])
            frame.questStartItemButton.name:SetText(itemName or startItem[2])
            frame.questStartItemButton.name:SetTextColor(1, 1, 1)
            local itemTheme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
            frame.questStartItemButton:SetBackdropColor(unpack(itemTheme.lootRow))
            frame.questStartItemButton:SetBackdropBorderColor(unpack(itemTheme.border))
            frame.questStartItemButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questStartItemButton:Show()
            if frame.questStartDungeonIcon then
                frame.questStartDungeonIcon:Hide()
                if details.startsInDungeon or FDJ.StartsInsideDungeon(details.pickup)
                    or FDJ.StartItemDropsIn(details, selectedDungeon) then FDJ.PositionInDungeonIcon() end
            end
            cursorY = cursorY + 48
        else
            frame.questStartsText:ClearAllPoints()
            frame.questStartsText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            local pickupText = QuestField(questID, "pickup", details.pickup)
            frame.questStartsText:SetText(pickupText)
            frame.questStartsText:SetTextColor(0.10, 0.065, 0.025)
            frame.questStartsText:Show()
            if frame.questStartDungeonIcon then
                frame.questStartDungeonIcon:Hide()
                if details.startsInDungeon or FDJ.StartsInsideDungeon(details.pickup) or FDJ.StartsInsideDungeon(pickupText) then
                    FDJ.PositionInDungeonIcon()
                end
            end
            cursorY = cursorY + (frame.questStartsText:GetStringHeight() or 24) + 7
        end

        if details.map and frame.questMapButton then
            frame.questMapButton:ClearAllPoints()
            frame.questMapButton.quest = nil
            frame.questMapButton.prereqLocation = (FDJ.LocalizeMapLocation and FDJ.LocalizeMapLocation(details.map)) or details.map
            frame.questMapButton.fdjQuestTitle = QuestField(questID, "name", step.name)
            frame.questMapButton.fdjLabelKey = nil
            if frame.questMapButton.icon then frame.questMapButton.icon:Hide() end
            UpdateQuestActionButtonSizes()
            if FDJ.MapMarkers and FDJ.MapMarkers.ConfigureTargetAndMarkAction then
                FDJ.MapMarkers.ConfigureTargetAndMarkAction(frame.questMapButton, frame.questMapButton.prereqLocation, true)
            end
            frame.questMapButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questMapButton:Show()
            cursorY = cursorY + 31
        end
    end

    if details.turnin and details.turnin ~= "" then
        frame.questTurninHeader:ClearAllPoints()
        frame.questTurninHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questTurninHeader:Show()
        cursorY = cursorY + (frame.questTurninHeader:GetStringHeight() or 18) + 3
        frame.questTurninText:ClearAllPoints()
        frame.questTurninText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questTurninText:SetText(QuestField(questID, "turnin", details.turnin))
        frame.questTurninText:SetTextColor(0.10, 0.065, 0.025)
        frame.questTurninText:Show()
        cursorY = cursorY + (frame.questTurninText:GetStringHeight() or 24) + 8

        local startMap, turninMap = details.map, details.turninMap
        local sameNPC = startMap and turninMap and startMap.mapID == turninMap.mapID
            and math.abs((startMap.x or 0) - (turninMap.x or 0)) < 0.01
            and math.abs((startMap.y or 0) - (turninMap.y or 0)) < 0.01
        local turninButton = frame.questTurninMapButton or (not startMap and frame.questMapButton) or nil
        if turninMap and not sameNPC and turninButton then
            turninButton:ClearAllPoints()
            turninButton.quest = nil
            turninButton.prereqLocation = (FDJ.LocalizeMapLocation and FDJ.LocalizeMapLocation(turninMap)) or turninMap
            turninButton.fdjQuestTitle = QuestField(questID, "name", step.name)
            turninButton.fdjLabelKey = "SHOW_TURN_IN"
            if turninButton.icon then turninButton.icon:Show() end
            if FDJ.MapMarkers and FDJ.MapMarkers.ConfigureTargetAndMarkAction then
                FDJ.MapMarkers.ConfigureTargetAndMarkAction(turninButton, turninButton.prereqLocation, true)
            end
            UpdateQuestActionButtonSizes()
            turninButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            turninButton:Show()
            cursorY = cursorY + 34
        end
    end

    local prereqWarning = QuestField(questID, "warning", details.warning)
    if prereqWarning and prereqWarning ~= "" then
        if not frame.questWarningText then
            frame.questWarningText = frame.questDetailContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            frame.questWarningText:SetJustifyH("LEFT")
        end
        frame.questWarningText:ClearAllPoints()
        frame.questWarningText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questWarningText:SetWidth(math.max(120, (frame.questDetailContent:GetWidth() or 360) - 8))
        frame.questWarningText:SetText(prereqWarning)
        frame.questWarningText:SetTextColor(0.62, 0.10, 0.05)
        frame.questWarningText:Show()
        cursorY = cursorY + (frame.questWarningText:GetStringHeight() or 22) + 12
    elseif frame.questWarningText then
        frame.questWarningText:Hide()
    end

    local usefulNote = QuestField(questID, "note", details.note)
    if usefulNote and usefulNote ~= "" then
        frame.questNotesHeader:ClearAllPoints()
        frame.questNotesHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questNotesHeader:Show()
        cursorY = cursorY + (frame.questNotesHeader:GetStringHeight() or 18) + 4

        frame.questNotesText:ClearAllPoints()
        frame.questNotesText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questNotesText:SetText(usefulNote)
        frame.questNotesText:SetTextColor(0.10, 0.065, 0.025)
        frame.questNotesText:Show()
        cursorY = cursorY + (frame.questNotesText:GetStringHeight() or 30) + 18
    else
        frame.questNotesHeader:Hide()
        frame.questNotesText:SetText("")
        frame.questNotesText:Hide()
    end

    local prereqRewardItems, prereqRewardChoice, prereqAlsoItems = GetPrerequisiteRewardItems(questID)
    prereqAlsoItems = prereqAlsoItems or {}
    local prereqXP = GetPrerequisiteRewardXP(questID)
    local prereqMoney = GetPrerequisiteRewardMoney(questID)
    local hasPrereqRewards = (#prereqRewardItems > 0) or (#prereqAlsoItems > 0) or (prereqXP and prereqXP > 0) or (prereqMoney > 0)
    if frame.questRewardAlsoHeader then frame.questRewardAlsoHeader:Hide() end

    if hasPrereqRewards then
        frame.questRewardHeader:ClearAllPoints()
        frame.questRewardHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        if #prereqRewardItems > 0 and prereqRewardChoice then
            frame.questRewardHeader:SetText("|cffffd36b" .. L("CHOOSE_ONE_REWARD") .. "|r")
        elseif #prereqRewardItems == 1 then
            frame.questRewardHeader:SetText("|cffffd36b" .. L("REWARD") .. "|r")
        else
            frame.questRewardHeader:SetText("|cffffd36b" .. L("REWARDS") .. "|r")
        end
        cursorY = cursorY + 22

        local rewardWidth = math.floor((detailWidth - 10) / 2)
        local buttonsUsed = 0
        -- Two-column grid of item cards; the fixed rewards of a choice quest
        -- get their own grid under "You will also receive".
        local function PlaceRewardGrid(list)
            local rowsUsed = 0
            for i, item in ipairs(list) do
                buttonsUsed = buttonsUsed + 1
                local button = questRewardButtons[buttonsUsed]
                if not button then
                    button = MakeQuestRewardButton(frame.questDetailContent)
                    questRewardButtons[buttonsUsed] = button
                end

                button:SetWidth(rewardWidth)
                button.item = item
                if FDJ.UpdateFavouriteIndicator then FDJ.UpdateFavouriteIndicator(button, item[1]) end
                button.icon:SetTexture(ItemIcon(item[1]))
                if C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
                    pcall(C_Item.RequestLoadItemDataByID, item[1])
                end

                local itemName, itemLink, quality = ItemInfo(item[1])
                local r, g, b = GetAuthoritativeItemQuality(item[1], itemLink, quality, item[3] or 1)
                button.name:SetText(itemName or item[2])
                button.name:SetTextColor(r, g, b)
                local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
                button:SetBackdropColor(unpack(theme.lootRow))
                button:SetBackdropBorderColor(unpack(theme.border))

                local col = (i - 1) % 2
                local row = math.floor((i - 1) / 2)
                button:ClearAllPoints()
                button:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT",
                    col * (rewardWidth + 10), -(cursorY + row * 54))
                button:Show()
                rowsUsed = math.max(rowsUsed, row + 1)
            end
            if rowsUsed > 0 then cursorY = cursorY + rowsUsed * 54 + 4 end
        end
        PlaceRewardGrid(prereqRewardItems)
        if #prereqAlsoItems > 0 and frame.questRewardAlsoHeader then
            frame.questRewardAlsoHeader:SetText(L("ALSO_RECEIVE"))
            frame.questRewardAlsoHeader:ClearAllPoints()
            frame.questRewardAlsoHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questRewardAlsoHeader:Show()
            cursorY = cursorY + (frame.questRewardAlsoHeader:GetStringHeight() or 18) + 4
            PlaceRewardGrid(prereqAlsoItems)
        end
        for i = buttonsUsed + 1, #questRewardButtons do
            local button = questRewardButtons[i]
            if button then
                button.item = nil
                button:Hide()
            end
        end

        local hasBar = false
        if frame.questXPReward and prereqXP and prereqXP > 0 then
            frame.questXPReward:ClearAllPoints()
            frame.questXPReward:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questXPReward.text:SetText(FormatNumber(prereqXP) .. " XP")
            frame.questXPReward:Show()
            hasBar = true
        elseif frame.questXPReward then
            frame.questXPReward:Hide()
        end

        if frame.questMoneyReward and prereqMoney > 0 then
            frame.questMoneyReward:ClearAllPoints()
            if hasBar and frame.questXPReward then
                frame.questMoneyReward:SetPoint("LEFT", frame.questXPReward, "RIGHT", 8, 0)
            else
                frame.questMoneyReward:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            end
            frame.questMoneyReward.text:SetText(FormatQuestMoney(prereqMoney))
            local moneyWidth = math.ceil((frame.questMoneyReward.text:GetStringWidth() or 0) + 16)
            frame.questMoneyReward:SetWidth(math.max(40, math.min(120, moneyWidth)))
            frame.questMoneyReward:Show()
            hasBar = true
        elseif frame.questMoneyReward then
            frame.questMoneyReward:Hide()
        end

        if hasBar then cursorY = cursorY + 32 end
    else
        frame.questRewardHeader:SetText("")
        if frame.questXPReward then frame.questXPReward:Hide() end
        if frame.questMoneyReward then frame.questMoneyReward:Hide() end
    end

    frame.questDetailContent:SetHeight(math.max(1, cursorY))
    FDJ.ApplyQuestDetailScroll("step:" .. tostring(selectedDungeon) .. ":" .. tostring(selectedPrereqParentQuestID) .. ":" .. tostring(step.id or step.name), cursorY)
    UpdateScrollBarVisibility(frame.questDetailScroll, cursorY)
    return true
end

RefreshQuestDetail = function()
    for _, button in ipairs(questRewardButtons) do HideSearchItemHighlight(button) end
    for _, button in ipairs(questNoteRewardButtons) do HideSearchItemHighlight(button) end
    if frame and frame.questNoteItemButton then HideSearchItemHighlight(frame.questNoteItemButton) end
    if not frame or not frame.questDetailText then return end
    if frame.questTurninMapButton then
        frame.questTurninMapButton.prereqLocation = nil
        frame.questTurninMapButton:Hide()
    end
    if frame.questRewardAlsoHeader then frame.questRewardAlsoHeader:Hide() end

    if selectedPrereqStep then
        if RefreshPrerequisiteQuestDetail(selectedPrereqStep) then return end
    end
    FDJ.HideStepItemButtons()
    if frame.questPrevStepButton then frame.questPrevStepButton:Hide() end
    if frame.questNextStepButton then frame.questNextStepButton:Hide() end

    local dungeon = DB[selectedDungeon]
    local quest = dungeon.quests and dungeon.quests[selectedQuest]
    if not quest or not QuestMatchesFaction(quest, selectedQuestFaction) then
        BuildVisibleQuestIndexes()
        quest = dungeon.quests and dungeon.quests[selectedQuest]
    end
    -- rpgpartial: a quest not unlocked yet shows nothing but how to unlock it.
    local rpgHiddenQuest = quest and QuestMatchesFaction(quest, selectedQuestFaction)
        and FDJ.RPGQuestHidden and FDJ.RPGQuestHidden(selectedDungeon, quest) or false
    if not quest or not QuestMatchesFaction(quest, selectedQuestFaction) or rpgHiddenQuest then
        frame.selectedQuestName:SetText(rpgHiddenQuest and "???" or L("NO_QUESTS"))
        frame.selectedQuestMeta:SetText("")
        if frame.selectedQuestClass then frame.selectedQuestClass:Hide() end
        if frame.selectedQuestClassIcon then frame.selectedQuestClassIcon:Hide() end
        if frame.selectedQuestMetaClassIcon then frame.selectedQuestMetaClassIcon:Hide() end
        frame.selectedQuestComplete:Hide()
        if frame.selectedQuestTurnIn then frame.selectedQuestTurnIn:Hide() end
        if frame.questShareButton then frame.questShareButton.questID = nil; frame.questShareButton:Hide() end
        if frame.questDetailScroll then frame.questDetailScroll:Hide() end
        if frame.noQuestMessage then
            frame.noQuestMessage:SetText(rpgHiddenQuest and L("RPG_QUEST_HIDDEN") or L("NO_FACTION_QUESTS", selectedQuestFaction))
            frame.noQuestMessage:Show()
        end
        frame.questDetailText:SetText("")
        if frame.questStartsText then frame.questStartsText:SetText("") end
        if frame.questNotesText then frame.questNotesText:SetText("") end
        if frame.questObjectiveHeader then frame.questObjectiveHeader:Hide() end
        if frame.questStartsHeader then frame.questStartsHeader:Hide() end
        if frame.questTurninHeader then frame.questTurninHeader:Hide() end
        if frame.questNotesHeader then frame.questNotesHeader:Hide() end
        if frame.questMapButton then frame.questMapButton.quest = nil; frame.questMapButton:Hide() end
        if frame.questStartLinkButton then frame.questStartLinkButton.questID = nil; frame.questStartLinkButton:Hide() end
        if frame.questLeadsToButton then frame.questLeadsToButton.questID = nil; frame.questLeadsToButton:Hide() end
        if frame.questStartItemButton then frame.questStartItemButton.item = nil; frame.questStartItemButton:Hide() end
        if frame.questRequiredItemsHeader then frame.questRequiredItemsHeader:Hide() end
        if frame.questRequiredItemButton then frame.questRequiredItemButton.item = nil; frame.questRequiredItemButton:Hide() end
        if frame.questNoteItemButton then frame.questNoteItemButton.item = nil; frame.questNoteItemButton:Hide() end
        if frame.questStartDungeonIcon then frame.questStartDungeonIcon:Hide() end
        if frame.questTurninText then frame.questTurninText:SetText("") end
        frame.questRewardHeader:SetText("")
        if frame.questXPReward then frame.questXPReward:Hide() end
        if frame.questMoneyReward then frame.questMoneyReward:Hide() end
        frame.questRewardSummary:SetText("")
        if FDJ.LayoutRepPills then FDJ.LayoutRepPills({}, 0, 0) end
        for _, button in ipairs(questRewardButtons) do button.item = nil; button:Hide() end
        for _, button in ipairs(questNoteRewardButtons) do button.item = nil; button:Hide() end
        if frame.questAdditionalRewardButtons then
            for _, button in ipairs(frame.questAdditionalRewardButtons) do button.item = nil; button:Hide() end
        end
        frame.questDetailContent:SetHeight(1)
        return
    end

    if frame.questDetailScroll then frame.questDetailScroll:Show() end
    if frame.noQuestMessage then frame.noQuestMessage:Hide() end
    if frame.questStartDungeonIcon then frame.questStartDungeonIcon:Hide() end

    local detailWidth = math.max(260, (frame.questDetailScroll:GetWidth() or 350) - 4)
    frame.questDetailContent:SetWidth(detailWidth)
    frame.questDetailText:SetWidth(detailWidth)
    if frame.questStartsText then frame.questStartsText:SetWidth(detailWidth) end
    if frame.questTurninText then frame.questTurninText:SetWidth(detailWidth) end
    if frame.questNotesText then frame.questNotesText:SetWidth(detailWidth) end
    local rewardWidth = math.floor((detailWidth - 10) / 2)
    local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
    local complete = IsQuestFinished(quest.id)

    frame.selectedQuestName:SetText(QuestField(quest.id, "name", quest.name))
    frame.selectedQuestName:SetTextColor(1.00, 0.78, 0.16)
    frame.selectedQuestName:SetShadowColor(0, 0, 0, 1)
    frame.selectedQuestName:SetShadowOffset(1, -1)

    local classLabel, classR, classG, classB, classToken = GetQuestClassRestriction(quest)
    if classLabel and frame.selectedQuestClass then
        frame.selectedQuestClass:SetText(classLabel)
        frame.selectedQuestClass:SetTextColor(classR, classG, classB)
        -- Light black edge so the class colour reads on the parchment: a
        -- solid one-pixel shadow (a full font outline looked too heavy).
        local font, size = frame.selectedQuestClass:GetFont()
        if font and size then frame.selectedQuestClass:SetFont(font, size, "") end
        frame.selectedQuestClass:SetShadowColor(0, 0, 0, 1)
        frame.selectedQuestClass:SetShadowOffset(1, -1)
        frame.selectedQuestClass:Show()

        if frame.selectedQuestClassIcon then
            SetQuestRestrictionIcon(frame.selectedQuestClassIcon, classToken)
            -- Centre the icon under the words themselves, not under the
            -- (wider, right-aligned) text box.
            local textWidth = math.min(frame.selectedQuestClass:GetStringWidth() or 0,
                frame.selectedQuestClass:GetWidth() or 118)
            frame.selectedQuestClassIcon:ClearAllPoints()
            frame.selectedQuestClassIcon:SetPoint("TOP", frame.selectedQuestClass, "BOTTOMRIGHT", -textWidth / 2, -3)
            frame.selectedQuestClassIcon:Show()
        end

        frame.selectedQuestComplete:ClearAllPoints()
        frame.selectedQuestComplete:SetPoint("RIGHT", frame.selectedQuestClass, "LEFT", -6, 0)
    else
        if frame.selectedQuestClass then frame.selectedQuestClass:Hide() end
        if frame.selectedQuestClassIcon then frame.selectedQuestClassIcon:Hide() end
        frame.selectedQuestComplete:ClearAllPoints()
        frame.selectedQuestComplete:SetPoint("TOPRIGHT", frame.questTextInset, "TOPRIGHT", -16, -11)
    end

    local shareTitleInset = FDJ.UpdateQuestShareButton(quest.id, classLabel)
    frame.selectedQuestName:ClearAllPoints()
    frame.selectedQuestName:SetPoint("TOPLEFT", frame.questTextInset, "TOPLEFT", 16, -15)
    frame.selectedQuestName:SetPoint("RIGHT", frame.questTextInset, "RIGHT", -shareTitleInset, 0)

    frame.selectedQuestMeta:SetText(
        L("AVAILABLE_FROM_LEVEL", quest.requires)
        .. "     " .. FactionLabel(quest.faction)

    )
    frame.selectedQuestMeta:SetTextColor(0.25, 0.16, 0.08)

    if frame.selectedQuestMetaClassIcon then
        frame.selectedQuestMetaClassIcon:Hide()
    end

    -- Keep multi-line quest titles and faction icons above the body separator.
    local headerHeight = math.max(classLabel and 78 or 58, 15 + frame.selectedQuestName:GetStringHeight()
        + 5 + math.max(24, frame.selectedQuestMeta:GetStringHeight()) + 8)
    frame.questHeaderSeparator:ClearAllPoints()
    frame.questHeaderSeparator:SetPoint("TOPLEFT", 14, -headerHeight)
    frame.questHeaderSeparator:SetPoint("TOPRIGHT", -14, -headerHeight)
    frame.questDetailScroll:ClearAllPoints()
    frame.questDetailScroll:SetPoint("TOPLEFT", 16, -(headerHeight + 14))
    frame.questDetailScroll:SetPoint("BOTTOMRIGHT", -31, 16)

    if frame.selectedQuestComplete then
        local ready = complete and not FDJ.QuestTurnedIn(quest.id)
        frame.selectedQuestComplete:SetShown(complete and not (ready and frame.selectedQuestTurnIn))
        if frame.selectedQuestTurnIn then
            FDJ.SetTurnInButton(frame.selectedQuestTurnIn, ready and quest or nil, QuestField(quest.id, "name", quest.name))
        end
    end

    -- Keep the body text identical to Blizzard's parchment quest text. Only
    -- the section labels use white outlined text for visibility.
    local cursorY = 0

    local function PlaceHeader(header, y)
        header:ClearAllPoints()
        header:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -y)
        header:Show()
        return y + math.max(14, header:GetStringHeight() or 14) + 3
    end

    -- Optional red disclaimer shown first, right under the title area.
    if quest.warning and quest.warning ~= "" then
        if not frame.questWarningText then
            frame.questWarningText = frame.questDetailContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            frame.questWarningText:SetJustifyH("LEFT")
        end
        frame.questWarningText:ClearAllPoints()
        frame.questWarningText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questWarningText:SetWidth(math.max(120, (frame.questDetailContent:GetWidth() or 360) - 8))

        -- Quest warnings can have quest-specific localized text (for example
        -- Baron Aquanis). Prefer the localized quest field first, then fall back
        -- to generic free-text localization.
        local warningText = QuestField(quest.id, "warning", quest.warning)
        -- Rig Wars warning contains quest titles. Build it from the localized
        -- client/addon quest names so the titles never remain in English on
        -- non-English clients.
        if quest.id == 2841 then
            local template = FreeText("Accept %s before %s. If %s disappears, abandon %s and it will reappear.")
            local rigWarsTitle = GetLoadedQuestTitle(2841, "Rig Wars")
            local scootyTitle = GetLoadedQuestTitle(2842, "Chief Engineer Scooty")
            local ok, formatted = pcall(string.format, template, rigWarsTitle, scootyTitle, rigWarsTitle, scootyTitle)
            if ok and type(formatted) == "string" and formatted ~= "" then
                warningText = formatted
            end
        end
        frame.questWarningText:SetText(warningText)
        frame.questWarningText:SetTextColor(0.62, 0.10, 0.05)
        frame.questWarningText:Show()
        cursorY = cursorY + (frame.questWarningText:GetStringHeight() or 28) + 10
    elseif frame.questWarningText then
        frame.questWarningText:Hide()
    end

    cursorY = PlaceHeader(frame.questObjectiveHeader, cursorY)
    frame.questDetailText:ClearAllPoints()
    frame.questDetailText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
    -- Real quest text from the game when known (see Systems/QuestText.lua).
    if FDJ.QuestPageText then
        frame.fdjObjText, frame.fdjDescText = FDJ.QuestPageText(quest.id, QuestField(quest.id, "objective", quest.objective))
    else
        frame.fdjObjText, frame.fdjDescText = QuestField(quest.id, "objective", quest.objective), nil
    end
    frame.questDetailText:SetText(frame.fdjObjText)
    frame.questDetailText:SetTextColor(0.10, 0.065, 0.025)
    cursorY = cursorY + (frame.questDetailText:GetStringHeight() or 30) + 13
    if FDJ.PlaceQuestDescription then cursorY = FDJ.PlaceQuestDescription(frame, frame.fdjDescText, cursorY, PlaceHeader) end

    -- Normal dungeon-quest required items use field 5 for Journal-only source
    -- information (field 4 is the stack count). Only render the large item card
    -- when that source information is actually useful to the player.
    if quest.requiredItem and type(quest.requiredItem[5]) == "string" and quest.requiredItem[5] ~= "" and frame.questRequiredItemButton then
        cursorY = PlaceHeader(frame.questRequiredItemsHeader, cursorY)
        frame.questRequiredItemButton.item = quest.requiredItem
        frame.questRequiredItemButton.fdjMapLocation = FDJ.MapQuestItemSpot and FDJ.MapQuestItemSpot(quest.id, quest.requiredItem[1]) or nil -- mapquests
        frame.questRequiredItemButton.fdjSourceText = FreeText(quest.requiredItem[5])
        frame.questRequiredItemButton:SetWidth(math.min(260, rewardWidth))
        frame.questRequiredItemButton.icon:SetTexture(ItemIcon(quest.requiredItem[1]))
        if C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
            pcall(C_Item.RequestLoadItemDataByID, quest.requiredItem[1])
        end
        do
            local itemName, itemLink, quality = ItemInfo(quest.requiredItem[1])
            local r, g, b = GetAuthoritativeItemQuality(quest.requiredItem[1], itemLink, quality, quest.requiredItem[3] or 1)
            local countText = quest.requiredItem[4] and quest.requiredItem[4] > 1 and (" ×" .. tostring(quest.requiredItem[4])) or ""
            frame.questRequiredItemButton.name:SetText((itemName or quest.requiredItem[2] or L("ITEM")) .. countText)
            frame.questRequiredItemButton.name:SetTextColor(r, g, b)
        end
        frame.questRequiredItemButton:SetBackdropColor(unpack(theme.lootRow))
        frame.questRequiredItemButton:SetBackdropBorderColor(unpack(theme.border))
        frame.questRequiredItemButton:ClearAllPoints()
        frame.questRequiredItemButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questRequiredItemButton:Show()
        cursorY = cursorY + 54
    else
        if frame.questRequiredItemsHeader then frame.questRequiredItemsHeader:Hide() end
        if frame.questRequiredItemButton then
            frame.questRequiredItemButton.item = nil
            frame.questRequiredItemButton.fdjSourceText = nil
            frame.questRequiredItemButton.fdjMapLocation = nil -- mapquests
            frame.questRequiredItemButton:Hide()
        end
    end

    -- Several required items, each with where it comes from (for example
    -- the three Seal of Ascension gemstones): same cards as on chain steps.
    local questRequiredList = quest.requiredItems
    if questRequiredList and #questRequiredList > 0 and frame.questRequiredItemsHeader then
        cursorY = PlaceHeader(frame.questRequiredItemsHeader, cursorY)
        cursorY = FDJ.PlaceStepItemButtons(questRequiredList, 0, cursorY, math.min(300, detailWidth)) + 8
    end

    -- Some Forever quests provide an item when accepted (for example the
    -- Dalaran Sewer Key for Heart of Disruption). Render it just like a
    -- prerequisite-step provided item so the journal mirrors Blizzard's log.
    if quest.providedItem and frame.questProvidedItemHeader then
        frame.questProvidedItemHeader:ClearAllPoints()
        frame.questProvidedItemHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questProvidedItemHeader:Show()
        cursorY = cursorY + (frame.questProvidedItemHeader:GetStringHeight() or 18) + 4
        cursorY = FDJ.PlaceStepItemButtons({ quest.providedItem }, (questRequiredList and #questRequiredList) or 0, cursorY, math.min(300, detailWidth)) + 8
    elseif frame.questProvidedItemHeader then
        frame.questProvidedItemHeader:Hide()
    end

    cursorY = PlaceHeader(frame.questStartsHeader, cursorY)
    frame.questStartsText:ClearAllPoints()
    frame.questStartItemButton:ClearAllPoints()

    if quest.startObject and not quest.startItem then
        -- Quest started by a world object (not an item): same button as a
        -- quest-start item, with a plain tooltip saying where the object is.
        -- startObject = {name, icon texture, where to find it}
        local obj = quest.startObject
        frame.questStartsText:SetText("")
        frame.questStartsText:Hide()
        frame.questStartItemButton.item = nil
        frame.questStartItemButton.fdjSourceText = nil
        frame.questStartItemButton.fdjObject = { FreeText(obj[1]), FreeText(obj[3]) }
        frame.questStartItemButton.icon:SetTexture(obj[2] or "Interface\\Icons\\INV_Misc_QuestionMark")
        frame.questStartItemButton.name:SetText(FreeText(obj[1]))
        frame.questStartItemButton.name:SetTextColor(1.00, 1.00, 1.00)
        frame.questStartItemButton:SetBackdropColor(unpack(theme.lootRow))
        frame.questStartItemButton:SetBackdropBorderColor(unpack(theme.border))
        frame.questStartItemButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questStartItemButton:Show()
        if frame.questStartDungeonIcon then
            frame.questStartDungeonIcon:Hide()
            if quest.startsInDungeon or ((FDJ.StartsInsideDungeon(quest.pickup) or FDJ.StartItemDropsIn(quest, selectedDungeon))
                and not QUEST_PREREQ_CHAINS[quest.id]) then FDJ.PositionInDungeonIcon() end
        end
        cursorY = cursorY + 44
    elseif quest.startItem then
        frame.questStartsText:SetText("")
        frame.questStartsText:Hide()

        local startItem = quest.startItem
        frame.questStartItemButton.fdjObject = nil
        frame.questStartItemButton.item = startItem
        frame.questStartItemButton.fdjSourceText = FreeText(startItem[4])
        frame.questStartItemButton.icon:SetTexture(ItemIcon(startItem[1]))
        local itemName = ItemInfo(startItem[1])
        frame.questStartItemButton.name:SetText(itemName or startItem[2])
        -- Quest-start items use white text in the journal regardless of item quality.
        frame.questStartItemButton.name:SetTextColor(1.00, 1.00, 1.00)
        frame.questStartItemButton:SetBackdropColor(unpack(theme.lootRow))
        frame.questStartItemButton:SetBackdropBorderColor(unpack(theme.border))
        frame.questStartItemButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questStartItemButton:Show()
        if frame.questStartDungeonIcon then
            frame.questStartDungeonIcon:Hide()
            if quest.startsInDungeon or ((FDJ.StartsInsideDungeon(quest.pickup) or FDJ.StartItemDropsIn(quest, selectedDungeon))
                and not QUEST_PREREQ_CHAINS[quest.id]) then FDJ.PositionInDungeonIcon() end
        end
        cursorY = cursorY + 44
    else
        frame.questStartItemButton.item = nil
        frame.questStartItemButton.fdjSourceText = nil
        frame.questStartItemButton:Hide()
        frame.questStartsText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        local pickupText = QuestField(quest.id, "pickup", quest.pickup)
        frame.questStartsText:SetText(pickupText)
        frame.questStartsText:SetTextColor(0.10, 0.065, 0.025)
        frame.questStartsText:Show()
        if frame.questStartDungeonIcon then
            frame.questStartDungeonIcon:Hide()
            if quest.startsInDungeon or (FDJ.StartsInsideDungeon(pickupText) and not QUEST_PREREQ_CHAINS[quest.id]) then
                FDJ.PositionInDungeonIcon()
            end
        end
        cursorY = cursorY + (frame.questStartsText:GetStringHeight() or 30) + 8
    end

    local loc = quest.startMap or QUEST_START_MAPS[quest.id]
    local hasChain = QUEST_PREREQ_CHAINS[quest.id] ~= nil

    frame.questMapButton:ClearAllPoints()
    frame.questMapButton.prereqLocation = quest.startMap
    frame.questMapButton.quest = quest
    if frame.questMapButton.icon then frame.questMapButton.icon:Hide() end

    if frame.questStartLinkButton then
        frame.questStartLinkButton.questID = nil
        frame.questStartLinkButton:Hide()
    end
    if frame.questLeadsToButton then
        frame.questLeadsToButton.questID = nil
        frame.questLeadsToButton:Hide()
    end

    -- Render a direct link to the previous quest AFTER reset/cleanup.
    if quest.startQuestLink and frame.questStartLinkButton then
        frame.questStartLinkButton:ClearAllPoints()
        frame.questStartLinkButton.questID = quest.startQuestLink.id
        frame.questStartLinkButton:SetText(QuestField(quest.startQuestLink.id, "name", quest.startQuestLink.name or L("PREVIOUS_QUEST")))
        frame.questStartLinkButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questStartLinkButton:Show()
        cursorY = cursorY + 31
    end

    if frame.questChainButton then
        frame.questChainButton:ClearAllPoints()
        frame.questChainButton.questID = hasChain and quest.id or nil
        frame.questChainButton.parentQuestName = hasChain and quest.name or nil
    end

    -- Chain awareness: while an earlier step of the chain is still open, say so
    -- and lead with the chain button. Show on Map still points at this quest.
    local pendingStep, pendingIndex, chainLength
    if hasChain and not IsQuestInLog(quest.id) and not FDJ.QuestTurnedIn(quest.id) then
        local chain = QUEST_PREREQ_CHAINS[quest.id]
        chainLength = #chain
        for i, step in ipairs(chain) do
            if step.id and not FDJ.QuestTurnedIn(step.id) then
                if step.id ~= quest.id then pendingStep, pendingIndex = step, i end
                break
            end
        end
    end
    if hasChain then
        if not frame.questChainNotice then
            frame.questChainNotice = frame.questDetailContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            frame.questChainNotice:SetJustifyH("LEFT")
        end
        frame.questChainNotice:ClearAllPoints()
        frame.questChainNotice:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questChainNotice:SetWidth(math.max(120, (frame.questDetailContent:GetWidth() or 360) - 8))
        -- Only name a step once the chain is under way: an earlier step is
        -- turned in, or the open step is in the quest log.
        local noticeText = L("CHAIN_REQUIRED")
        if pendingStep and (pendingIndex > 1 or IsQuestInLog(pendingStep.id)) then
            noticeText = noticeText .. " " .. L("CHAIN_STEP", pendingIndex, chainLength)
        end
        frame.questChainNotice:SetText(noticeText)
        frame.questChainNotice:SetTextColor(0.62, 0.10, 0.05)
        frame.questChainNotice:Show()
        cursorY = cursorY + (frame.questChainNotice:GetStringHeight() or 14) + 8
        if not pendingStep then frame.questMapButton.fdjLabelKey = nil end
    else
        frame.questMapButton.fdjLabelKey = nil
        if frame.questChainNotice then frame.questChainNotice:Hide() end
    end

    UpdateQuestActionButtonSizes()

    local showMap = loc and not quest.startItem
    if FDJ.MapMarkers and FDJ.MapMarkers.ConfigureTargetAndMarkAction then
        frame.questMapButton.fdjQuestTitle = QuestField(quest.id, "name", quest.name)
        FDJ.MapMarkers.ConfigureTargetAndMarkAction(frame.questMapButton, showMap and loc or nil, true)
    end
    -- Show Quest Chain always comes first, then Show on Map.
    local chainShown = (pendingStep or hasChain) and frame.questChainButton
    if chainShown then
        frame.questChainButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        frame.questChainButton:Show()
    elseif frame.questChainButton then
        frame.questChainButton:Hide()
    end
    if showMap then
        if chainShown then
            frame.questMapButton:SetPoint("LEFT", frame.questChainButton, "RIGHT", 8, 0)
        else
            frame.questMapButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
        end
        frame.questMapButton:Show()
    else
        frame.questMapButton:Hide()
    end

    if showMap or hasChain then
        cursorY = cursorY + 31
    end

    cursorY = PlaceHeader(frame.questTurninHeader, cursorY)
    frame.questTurninText:ClearAllPoints()
    frame.questTurninText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
    frame.questTurninText:SetText(QuestField(quest.id, "turnin", quest.turnin))
    frame.questTurninText:SetTextColor(0.10, 0.065, 0.025)
    frame.questTurninText:Show()
    cursorY = cursorY + (frame.questTurninText:GetStringHeight() or 24)

    for _, button in ipairs(questNoteRewardButtons) do
        button.item = nil
        button:Hide()
    end

    -- FDJ_BREADCRUMB_LINK_FILTER: hide an optional-introduction link whose quest is for the other
    -- faction or another class (e.g. an Alliance-only referral on a quest both factions can take).
    local noteQuestLink = quest.noteQuestLink
    local noteText = quest.note
    if noteQuestLink and noteQuestLink.id then
        local linked
        for _, other in ipairs((DB[selectedDungeon] and DB[selectedDungeon].quests) or {}) do
            if other.id == noteQuestLink.id then linked = other break end
        end
        -- Compare with the faction tab being browsed, not the character's faction.
        local viewFaction = selectedQuestFaction
        if linked and (viewFaction == "Alliance" or viewFaction == "Horde")
            and not QuestMatchesFaction(linked, viewFaction) then
            noteQuestLink = nil
            if type(noteText) == "string" then
                noteText = noteText:gsub("%s*Optional introductory quest:%s*$", "")
            end
        end
    end
    if (noteText and noteText ~= "") or quest.leadsToQuestLink or noteQuestLink then
        cursorY = cursorY + 13
        cursorY = PlaceHeader(frame.questNotesHeader, cursorY)

        if noteText and noteText ~= "" then
            frame.questNotesText:ClearAllPoints()
            frame.questNotesText:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questNotesText:SetText(noteText == quest.note and QuestField(quest.id, "note", quest.note) or noteText)
            frame.questNotesText:SetTextColor(0.10, 0.065, 0.025)
            frame.questNotesText:Show()
            cursorY = cursorY + (frame.questNotesText:GetStringHeight() or 24)
        else
            frame.questNotesText:SetText("")
            frame.questNotesText:Hide()
        end

        local noteLink = noteQuestLink
        local leadsLink = quest.leadsToQuestLink
        if (noteLink or leadsLink) and frame.questLeadsToButton then
            if noteText and noteText ~= "" then cursorY = cursorY + 7 end
            local link = noteLink or leadsLink
            frame.questLeadsToButton:ClearAllPoints()
            frame.questLeadsToButton.questID = link.id
            if noteLink then
                -- Optional/breadcrumb quest links in Notes show the localized
                -- quest title itself instead of implying a required chain.
                frame.questLeadsToButton:SetText(GetLoadedQuestTitle(link.id, link.name or L("QUEST")))
            else
                frame.questLeadsToButton:SetText(L("LEADS_TO", QuestField(link.id, "name", link.name or L("NEXT_QUEST"))))
            end
            frame.questLeadsToButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questLeadsToButton:Show()
            cursorY = cursorY + 31
        elseif frame.questLeadsToButton then
            frame.questLeadsToButton.questID = nil
            frame.questLeadsToButton:Hide()
        end

        if quest.noteItem then
            cursorY = cursorY + 7
            local noteItem = quest.noteItem
            frame.questNoteItemButton.item = noteItem
            frame.questNoteItemButton.fdjSourceText = FreeText(noteItem[4])
            frame.questNoteItemButton.mapLocation = quest.noteItemMap
                or (FDJ.MapQuestItemSpot and FDJ.MapQuestItemSpot(quest.id, noteItem[1])) or nil -- mapquests
            frame.questNoteItemButton.icon:SetTexture(ItemIcon(noteItem[1]))
            local itemName = ItemInfo(noteItem[1])
            frame.questNoteItemButton.name:SetText(itemName or noteItem[2])
            -- Quest-related note items use white text in the journal.
            frame.questNoteItemButton.name:SetTextColor(1.00, 1.00, 1.00)
            frame.questNoteItemButton:SetBackdropColor(unpack(theme.lootRow))
            frame.questNoteItemButton:SetBackdropBorderColor(unpack(theme.border))
            frame.questNoteItemButton:ClearAllPoints()
            frame.questNoteItemButton:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -cursorY)
            frame.questNoteItemButton:Show()
            cursorY = cursorY + 38
        else
            frame.questNoteItemButton.item = nil
            frame.questNoteItemButton.fdjSourceText = nil
            frame.questNoteItemButton.mapLocation = nil
            frame.questNoteItemButton:Hide()
        end

        local noteRewardItems = quest.noteRewardItems or {}
        if #noteRewardItems > 0 then
            cursorY = cursorY + 7
            local noteRewardWidth = math.floor((detailWidth - 10) / 2)
            local rowsUsed = 0
            for i, noteRewardItem in ipairs(noteRewardItems) do
                local button = questNoteRewardButtons[i]
                if not button then
                    button = MakeQuestNoteRewardButton(frame.questDetailContent)
                    questNoteRewardButtons[i] = button
                end

                button:SetWidth(noteRewardWidth)
                button.item = noteRewardItem
                button.icon:SetTexture(ItemIcon(noteRewardItem[1]))
                if C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
                    pcall(C_Item.RequestLoadItemDataByID, noteRewardItem[1])
                end

                local itemName, itemLink, quality = ItemInfo(noteRewardItem[1])
                local r, g, b = GetAuthoritativeItemQuality(
                    noteRewardItem[1],
                    itemLink,
                    quality,
                    noteRewardItem[3] or 1
                )
                button.name:SetText(itemName or noteRewardItem[2] or "Item")
                button.name:SetTextColor(r, g, b)
                button:SetBackdropColor(unpack(theme.lootRow))
                button:SetBackdropBorderColor(unpack(theme.border))

                local col = (i - 1) % 2
                local row = math.floor((i - 1) / 2)
                button:ClearAllPoints()
                button:SetPoint(
                    "TOPLEFT",
                    frame.questDetailContent,
                    "TOPLEFT",
                    col * (noteRewardWidth + 10),
                    -(cursorY + row * 54)
                )
                button:Show()
                rowsUsed = math.max(rowsUsed, row + 1)
            end
            cursorY = cursorY + rowsUsed * 54
        end
    else
        frame.questNotesHeader:Hide()
        frame.questNotesText:SetText("")
        frame.questNotesText:Hide()
        frame.questNoteItemButton.item = nil
        frame.questNoteItemButton.fdjSourceText = nil
        frame.questNoteItemButton.mapLocation = nil
        frame.questNoteItemButton:Hide()
    end

    if frame.questAdditionalRewardButtons then
        for _, button in ipairs(frame.questAdditionalRewardButtons) do
            button.item = nil
            button:Hide()
        end
    end
    if frame.questAlsoReceiveHeader then frame.questAlsoReceiveHeader:Hide() end

    local rewardY = cursorY + 22
    local rewardItems = quest.rewardItems or {}

    frame.questRewardHeader:ClearAllPoints()
    frame.questRewardHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -rewardY)

    if quest.rewardHeader and quest.rewardHeader ~= "" then
        frame.questRewardHeader:SetText("|cffffd36b" .. quest.rewardHeader .. "|r")
    elseif #rewardItems > 0 then
        if quest.rewardChoice and #rewardItems > 1 then
            frame.questRewardHeader:SetText("|cffffd36b" .. L("CHOOSE_ONE_REWARD") .. "|r")
        else
            frame.questRewardHeader:SetText("|cffffd36b" .. L("REWARD") .. "|r")
        end
    else
        frame.questRewardHeader:SetText("|cffffd36b" .. L("REWARDS") .. "|r")
    end

    local firstRewardY = rewardY + 20
    local rowsUsed = 0

    for i = 1, math.max(#questRewardButtons, #rewardItems) do
        local button = questRewardButtons[i]

        if i <= #rewardItems then
            if not button then
                button = MakeQuestRewardButton(frame.questDetailContent)
                questRewardButtons[i] = button
            end

            button:SetWidth(rewardWidth)
            local item = rewardItems[i]
            button.item = item
            if FDJ.UpdateFavouriteIndicator then FDJ.UpdateFavouriteIndicator(button, item[1]) end
            button.icon:SetTexture(item[5] or ItemIcon(item[1]))
            if item[1] and item[1] > 0 and C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
                pcall(C_Item.RequestLoadItemDataByID, item[1])
            end

            local itemName, itemLink, quality
            if item[1] and item[1] > 0 then itemName, itemLink, quality = ItemInfo(item[1]) end
            local r, g, b
            if item[1] and item[1] > 0 then
                r, g, b = GetAuthoritativeItemQuality(item[1], itemLink, quality, item[3] or 3)
            else
                r, g, b = QualityColor(item[3] or 3)
            end
            button.name:SetText(itemName or item[2])
            button.name:SetTextColor(r, g, b)
            button:SetBackdropColor(unpack(theme.lootRow))
            button:SetBackdropBorderColor(unpack(theme.border))

            local col = (i - 1) % 2
            local row = math.floor((i - 1) / 2)
            button:ClearAllPoints()
            button:SetPoint(
                "TOPLEFT",
                frame.questDetailContent,
                "TOPLEFT",
                col * (rewardWidth + 10),
                -(firstRewardY + row * 54)
            )
            button:Show()
            rowsUsed = math.max(rowsUsed, row + 1)
        elseif button then
            button.item = nil
            button:Hide()
        end
    end

    local summaryY = firstRewardY
    if #rewardItems > 0 then
        summaryY = firstRewardY + rowsUsed * 54 + 4
    end

    local xp = GetLiveQuestXP(quest)
    local money = GetQuestRewardMoneyCopper(quest)
    local hasRewardBar = false

    -- Same layout as the in-game quest window: "Choose one of these rewards"
    -- for the choice items, then "You will also receive:" above the XP,
    -- money and any items everyone gets.
    local hasExtras = (xp and xp > 0) or (money and money > 0)
        or (quest.additionalRewardItems and #quest.additionalRewardItems > 0)
    -- This header is only meaningful when the quest first offers a choice
    -- reward and then has additional rewards below it. Always hide the reused
    -- font string first so it cannot leak from the previously viewed quest.
    if frame.questAlsoReceiveHeader then
        frame.questAlsoReceiveHeader:Hide()
    end
    if quest.rewardChoice and #rewardItems > 1 and hasExtras then
        if not frame.questAlsoReceiveHeader then
            frame.questAlsoReceiveHeader = frame.questDetailContent:CreateFontString(nil, "OVERLAY", "GameFontBlack")
            frame.questAlsoReceiveHeader:SetJustifyH("LEFT")
        end
        frame.questAlsoReceiveHeader:SetText(L("ALSO_RECEIVE"))
        frame.questAlsoReceiveHeader:ClearAllPoints()
        frame.questAlsoReceiveHeader:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -summaryY)
        frame.questAlsoReceiveHeader:Show()
        summaryY = summaryY + 20
    end

    local showXP = xp and (xp > 0 or (xp == 0 and quest.showZeroXP))
    if frame.questXPReward and showXP then
        frame.questXPReward:ClearAllPoints()
        frame.questXPReward:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -summaryY)
        frame.questXPReward.text:SetText(FormatNumber(xp) .. " XP")
        frame.questXPReward:Show()
        hasRewardBar = true
    elseif frame.questXPReward then
        frame.questXPReward:Hide()
    end

    if frame.questMoneyReward and money and money > 0 then
        frame.questMoneyReward:ClearAllPoints()
        if showXP and frame.questXPReward then
            frame.questMoneyReward:SetPoint("LEFT", frame.questXPReward, "RIGHT", 8, 0)
        else
            frame.questMoneyReward:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -summaryY)
        end
        frame.questMoneyReward.text:SetText(FormatQuestMoney(money))
        local moneyWidth = math.ceil((frame.questMoneyReward.text:GetStringWidth() or 0) + 16)
        frame.questMoneyReward:SetWidth(math.max(40, math.min(120, moneyWidth)))
        frame.questMoneyReward:Show()
        hasRewardBar = true
    elseif frame.questMoneyReward then
        frame.questMoneyReward:Hide()
    end

    if hasRewardBar then
        summaryY = summaryY + 34
    end

    if quest.additionalRewardItems and #quest.additionalRewardItems > 0 then
        frame.questAdditionalRewardButtons = frame.questAdditionalRewardButtons or {}
        for i, item in ipairs(quest.additionalRewardItems) do
            if not frame.questAdditionalRewardButtons[i] then
                frame.questAdditionalRewardButtons[i] = MakeQuestRewardButton(frame.questDetailContent)
            end
            frame.questAdditionalRewardButtons[i]:SetWidth(rewardWidth)
            frame.questAdditionalRewardButtons[i].item = item
            frame.questAdditionalRewardButtons[i].icon:SetTexture(item[5] or ItemIcon(item[1]))
            if item[1] and item[1] > 0 and C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
                pcall(C_Item.RequestLoadItemDataByID, item[1])
            end
            do
                local itemName, itemLink, quality
                if item[1] and item[1] > 0 then itemName, itemLink, quality = ItemInfo(item[1]) end
                local r, g, b = GetAuthoritativeItemQuality(item[1], itemLink, quality, item[3] or 1)
                local countText = item[4] and item[4] > 1 and (" ×" .. tostring(item[4])) or ""
                frame.questAdditionalRewardButtons[i].name:SetText((itemName or item[2]) .. countText)
                frame.questAdditionalRewardButtons[i].name:SetTextColor(r, g, b)
            end
            frame.questAdditionalRewardButtons[i]:SetBackdropColor(unpack(theme.lootRow))
            frame.questAdditionalRewardButtons[i]:SetBackdropBorderColor(unpack(theme.border))
            frame.questAdditionalRewardButtons[i]:ClearAllPoints()
            frame.questAdditionalRewardButtons[i]:SetPoint(
                "TOPLEFT",
                frame.questDetailContent,
                "TOPLEFT",
                ((i - 1) % 2) * (rewardWidth + 10),
                -(summaryY + math.floor((i - 1) / 2) * 54)
            )
            frame.questAdditionalRewardButtons[i]:Show()
        end
        summaryY = summaryY + (math.floor((#quest.additionalRewardItems - 1) / 2) + 1) * 54 + 4
    end

    frame.questRewardSummary:ClearAllPoints()
    frame.questRewardSummary:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -summaryY)
    frame.questRewardSummary:SetPoint("RIGHT", frame.questDetailContent, "RIGHT", -8, 0)
    ApplyRewardSummaryFont(frame.questRewardSummary)
    -- Reputation gains ("Ironforge +100") are drawn as pills like the XP and
    -- money rewards; anything else in the summary stays as text below them.
    do
        local raw = BuildQuestRewardSummary(quest, false) or ""
        local reps, rest = {}, {}
        for part in (raw .. "\226\128\162"):gmatch("(.-)\226\128\162") do
            part = part:gsub("^%s+", ""):gsub("%s+$", "")
            if part ~= "" then
                local name, amount = part:match("^(.-)%s*%+(%d+)$")
                if name and name ~= "" then
                    reps[#reps + 1] = { name, amount }
                else
                    rest[#rest + 1] = part
                end
            end
        end
        local repHeight = FDJ.LayoutRepPills(reps, summaryY, (frame.questDetailContent:GetWidth() or 350) - 8)
        if repHeight > 0 then
            summaryY = summaryY + repHeight + 4
            frame.questRewardSummary:ClearAllPoints()
            frame.questRewardSummary:SetPoint("TOPLEFT", frame.questDetailContent, "TOPLEFT", 0, -summaryY)
            frame.questRewardSummary:SetPoint("RIGHT", frame.questDetailContent, "RIGHT", -8, 0)
        end
        frame.questRewardSummary:SetText(table.concat(rest, "  \226\128\162  "))
    end
    frame.questRewardSummary:SetTextColor(0.10, 0.065, 0.025)

    local summaryHeight = 0
    local summaryText = frame.questRewardSummary:GetText() or ""
    if summaryText ~= "" then
        summaryHeight = frame.questRewardSummary:GetStringHeight() or 18
    end
    local totalHeight = summaryY + summaryHeight + 18

    frame.questDetailContent:SetHeight(math.max(1, totalHeight))
    FDJ.ApplyQuestDetailScroll("quest:" .. tostring(selectedDungeon) .. ":" .. tostring(selectedQuestFaction) .. ":" .. tostring(quest.id or quest.name), totalHeight)
    UpdateScrollBarVisibility(frame.questDetailScroll, totalHeight)
end

SetQuestFaction = function(faction)
    if faction ~= "Alliance" and faction ~= "Horde" then return end

    selectedQuestFaction = faction
    selectedPrereqStep = nil
    selectedPrereqParentQuestName = nil
    selectedPrereqParentQuestID = nil
    ForeverDungeonJournalDB.questFaction = faction
    frame.questListScroll:SetVerticalScroll(0)

    BuildVisibleQuestIndexes()
    RefreshQuestList()
    RefreshQuestDetail()
end


local function HideRouteGuide()
    if not frame or not frame.routePanel then return end
    frame.routePanel:Hide()
end

ShowRouteGuide = function()
    if not frame then return end
    local dungeon = DB[selectedDungeon]
    local route = dungeon and dungeon.routeGuide
    if not route or not frame.routePanel then return end

    local lang = FDJ.GetLanguage and FDJ.GetLanguage() or "enUS"
    local localizedRoute = route.locales and (route.locales[lang] or route.locales.enUS) or route

    frame.leftPanel:Hide()
    frame.rightPanel:Hide()
    frame.questLeftPanel:Hide()
    frame.questRightPanel:Hide()

    if frame.routeFactionIcon then
        frame.routeFactionIcon:SetTexture(route.faction == "Horde" and HORDE_ICON or ALLIANCE_ICON)
    end
    local hasRouteMap = route.mapRoute and ShowRouteOnMap
    -- A step flagged `showRoute = true` carries the route button itself (e.g.
    -- "2. Follow the road from Southshore"), so the header button is hidden.
    local routeOnStep = false
    for _, step in ipairs(localizedRoute.steps or route.steps or {}) do
        if step.showRoute then routeOnStep = true break end
    end
    if routeOnStep then hasRouteMap = false end
    if frame.routeMapButton then
        frame.routeMapButton:SetShown(hasRouteMap and true or false)
        frame.routeMapButton:SetText(L("SHOW_ON_MAP"))
        frame.routeMapButton:ClearAllPoints()
    end
    frame.routeTitle:ClearAllPoints()
    frame.routeTitle:SetPoint("TOPLEFT", frame.routeFactionIcon, "TOPRIGHT", 10, -1)
    frame.routeTitle:SetText(localizedRoute.title or L("HOW_TO_GET_THERE"))
    if hasRouteMap and frame.routeMapButton then
        frame.routeMapButton:SetPoint("LEFT", frame.routeTitle, "RIGHT", 10, 0)
    elseif frame.routeMapButton then
        frame.routeMapButton:SetPoint("TOPRIGHT", -34, -20)
    end
    frame.routeSubtitle:SetText(localizedRoute.subtitle or (route.faction == "Horde" and "Horde route" or L("ALLIANCE_ROUTE")))

    frame.routeSteps:SetText("")
    frame.routeShortcutTitle:SetText("")
    frame.routeShortcut:SetText("")
    frame.routeWarning:SetText("")

    if frame.routeStepRows and frame.routeStepContent then
        for _, row in ipairs(frame.routeStepRows) do
            row:Hide()
        end

        local y = 0
        local stepNumber = 0
        for i, step in ipairs(localizedRoute.steps or route.steps or {}) do
            local row = frame.routeStepRows[i]
            if not row then
                row = CreateFrame("Frame", nil, frame.routeStepContent)
                row.title = row:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
                row.title:SetPoint("TOPLEFT", 0, 0)
                row.title:SetJustifyH("LEFT")
                row.title:SetTextColor(1.00, 0.82, 0.27)

                row.body = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                row.body:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -5)
                row.body:SetJustifyH("LEFT")
                row.body:SetJustifyV("TOP")
                row.body:SetWordWrap(true)
                row.body:SetTextColor(0.96, 0.90, 0.78)

                row.mapButton = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
                row.mapButton:SetSize(112, 22)
                row.mapButton:SetText(L("SHOW_ON_MAP"))
                row.mapButton:SetScript("OnClick", function(self)
                    if self.showsRoute then
                        local d = DB[selectedDungeon]
                        local r = d and d.routeGuide
                        if r and r.mapRoute and ShowRouteOnMap then ShowRouteOnMap(r.mapRoute) end
                    elseif self.mapLocation then
                        ShowRecordedLocationOnMap(self.mapLocation, self.mapLocation.label)
                    end
                end)
                row.mapButton:Hide()

                frame.routeStepRows[i] = row
            end

            local contentW = math.max(420, (frame.routeStepScroll:GetWidth() or 560) - 8)
            frame.routeStepContent:SetWidth(contentW)

            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", 0, -y)
            row:SetWidth(contentW)

            row.title:ClearAllPoints()
            row.title:SetPoint("TOPLEFT", 0, 0)
            row.body:ClearAllPoints()
            row.body:SetPoint("TOPLEFT", row.title, "BOTTOMLEFT", 0, -5)

            -- Optional route notes (such as the Orgrimmar zeppelin tip) are
            -- intentionally unnumbered so the numbered travel steps still begin at 1.
            if step.unnumbered then
                row.title:SetText(step.title or "")
                row.title:SetTextColor(0.55, 0.85, 1.00)
            else
                stepNumber = stepNumber + 1
                row.title:SetText(tostring(stepNumber) .. ". " .. (step.title or ""))
                row.title:SetTextColor(1.00, 0.82, 0.27)
            end
            row.body:SetText(step.text or "")

            row.mapButton.mapLocation = step.map
            row.mapButton.showsRoute = (step.showRoute and route.mapRoute and ShowRouteOnMap) and true or false
            if step.map or row.mapButton.showsRoute then
                row.mapButton:ClearAllPoints()
                local titleWidth = math.ceil(row.title:GetStringWidth() or 0)
                row.mapButton:SetPoint("TOPLEFT", row, "TOPLEFT", titleWidth + 10, 2)
                row.mapButton:SetText(L("SHOW_ON_MAP"))
                row.mapButton:Show()
                row.title:SetWidth(math.min(titleWidth + 2, contentW - 130))
            else
                row.mapButton:Hide()
                row.title:SetWidth(contentW - 8)
            end
            row.body:SetWidth(contentW - 8)
            row:Show()

            local titleH = math.max(18, row.title:GetStringHeight() or 18)
            local rowH
            if (step.text or "") == "" then
                rowH = titleH
            else
                local bodyH = math.max(20, row.body:GetStringHeight() or 20)
                rowH = titleH + 7 + bodyH
            end
            row:SetHeight(rowH)
            y = y + rowH + 18
        end

        frame.routeStepContent:SetHeight(math.max(y, 1))
        frame.routeStepScroll:SetVerticalScroll(0)
        if frame.routeStepScroll.ScrollBar then frame.routeStepScroll.ScrollBar:SetValue(0) end
        UpdateScrollBarVisibility(frame.routeStepScroll, y)
    end

    frame.routePanel:Show()
    UpdateModeTabs()
end

local function ClearDungeonMapArt()
    if not frame then return end
    for _, tex in ipairs(frame.dungeonMapArtTiles or {}) do tex:Hide() end
    for _, marker in ipairs(frame.dungeonMapBossMarkers or {}) do marker:Hide() end
end

local function RenderRagefireMap()
    if not frame or not frame.dungeonMapArtHolder then return end
    ClearDungeonMapArt()

    local data = RAGEFIRE_MAP
    local holder = frame.dungeonMapArtHolder

    -- Ragefire Chasm's Classic map art is present in the client under the
    -- historical "Ragefire" WorldMap folder. Unlike newer C_Map-backed maps,
    -- this Classic dungeon uses 12 fixed 256x256 tiles named Ragefire1_1 ...
    -- Ragefire1_12. Loading those files directly is reliable even while the
    -- player is outside the instance.
    -- The visible client parchment is 3:2.  Previous builds forced the 4x3
    -- texture tile grid into a 2:1 rectangle, visibly stretching the map and
    -- making normalized boss coordinates look wrong.  Keep the actual visible
    -- parchment aspect ratio and use almost the entire map page.
    local artW, artH = 480, 320
    local scaleX, scaleY = artW / 1024, artH / 768
    holder:ClearAllPoints()
    holder:SetSize(artW, artH)
    holder:SetPoint("CENTER", frame.dungeonMapPanel, "CENTER", 0, 0)
    if frame.dungeonMapCanvas then
        frame.dungeonMapCanvas:ClearAllPoints()
        frame.dungeonMapCanvas:SetSize(artW, artH)
        frame.dungeonMapCanvas:SetPoint("CENTER", frame.dungeonMapPanel, "CENTER", 0, 0)
        frame.dungeonMapCanvas:SetBackdropColor(0, 0, 0, 0)
        frame.dungeonMapCanvas:SetBackdropBorderColor(0, 0, 0, 0)
    end

    local index = 1
    for row = 1, 3 do
        for col = 1, 4 do
            local tex = frame.dungeonMapArtTiles[index]
            if not tex then
                tex = holder:CreateTexture(nil, "ARTWORK")
                frame.dungeonMapArtTiles[index] = tex
            end
            tex:ClearAllPoints()
            tex:SetSize(256 * scaleX, 256 * scaleY)
            tex:SetPoint("TOPLEFT", holder, "TOPLEFT", (col - 1) * 256 * scaleX, -((row - 1) * 256 * scaleY))
            tex:SetTexture("Interface\\Worldmap\\Ragefire\\Ragefire1_" .. index)
            tex:SetTexCoord(0, 1, 0, 1)
            tex:Show()
            index = index + 1
        end
    end

    local dungeon = DB[selectedDungeon]
    for i, mapBoss in ipairs(data.bosses) do
        local marker = frame.dungeonMapBossMarkers[i]
        if not marker then
            marker = CreateFrame("Button", nil, holder)
            marker:SetSize(22, 22)
            marker.portrait = marker:CreateTexture(nil, "ARTWORK")
            marker.portrait:SetAllPoints()
            marker.portrait:SetTexCoord(0.12, 0.88, 0.12, 0.88)
            marker.border = marker:CreateTexture(nil, "OVERLAY")
            marker.border:SetSize(26, 26)
            marker.border:SetPoint("CENTER")
            marker.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
            marker:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.bossName or "")
                GameTooltip:Show()
            end)
            marker:SetScript("OnLeave", function() GameTooltip:Hide() end)
            frame.dungeonMapBossMarkers[i] = marker
        end
        local bossRecord
        for _, candidate in ipairs((dungeon and dungeon.bosses) or {}) do
            if candidate.name == mapBoss.name then bossRecord = candidate break end
        end
        if bossRecord then
            local hasPortrait = SetBossPortrait(marker.portrait, selectedDungeon, bossRecord)
            if not hasPortrait then
                marker.portrait:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                marker.portrait:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            end
            marker.bossName = BossName(bossRecord.name)
        else
            marker.portrait:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            marker.portrait:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            marker.bossName = mapBoss.name
        end
        marker:ClearAllPoints()
        marker:SetPoint("CENTER", holder, "TOPLEFT", mapBoss.x * artW, -(mapBoss.y * artH))
        marker:Show()
    end
end

-- Zoom (mouse wheel) and pan (left-drag) for the dungeon map page.
FDJ.ResetDungeonMapView = function()
    if not frame then return end
    frame.dungeonMapZoom = 1
    frame.dungeonMapPanX, frame.dungeonMapPanY = 0, 0
end

FDJ.PositionDungeonMapHolder = function()
    local holder, panel = frame and frame.dungeonMapArtHolder, frame and frame.dungeonMapPanel
    if not holder or not panel then return end
    local pw, ph = panel:GetWidth() or 0, panel:GetHeight() or 0
    local hw, hh = holder:GetWidth() or 0, holder:GetHeight() or 0
    -- Zoomed in: the map can be dragged until its edge reaches the middle of
    -- the page, so every corner can be brought into view. Not zoomed: centred.
    local maxX, maxY = 0, 0
    if (frame.dungeonMapZoom or 1) > 1.001 then
        maxX, maxY = hw / 2, hh / 2
    end
    frame.dungeonMapPanX = math.max(-maxX, math.min(maxX, frame.dungeonMapPanX or 0))
    frame.dungeonMapPanY = math.max(-maxY, math.min(maxY, frame.dungeonMapPanY or 0))
    holder:ClearAllPoints()
    holder:SetPoint("CENTER", panel, "CENTER", frame.dungeonMapPanX, frame.dungeonMapPanY)
end

FDJ.SetupDungeonMapZoom = function()
    local panel = frame and frame.dungeonMapPanel
    if not panel or panel.fdjZoomReady then return end
    panel.fdjZoomReady = true
    panel:EnableMouse(true)
    panel:EnableMouseWheel(true)
    panel:SetScript("OnMouseWheel", function(self, delta)
        local data = FDJ.DUNGEON_MAPS[selectedDungeon]
        if not data then return end
        local old = frame.dungeonMapZoom or 1
        local new = math.max(1, math.min(4, old * (delta > 0 and 1.25 or 0.8)))
        if math.abs(new - old) < 0.001 then return end
        -- Zoom around the cursor: keep the map point under it in place.
        local scale = self:GetEffectiveScale()
        local cx, cy = GetCursorPosition()
        local left, bottom = self:GetLeft() or 0, self:GetBottom() or 0
        local mx = cx / scale - left - (self:GetWidth() or 0) / 2
        local my = cy / scale - bottom - (self:GetHeight() or 0) / 2
        local k = new / old
        frame.dungeonMapPanX = mx - (mx - (frame.dungeonMapPanX or 0)) * k
        frame.dungeonMapPanY = my - (my - (frame.dungeonMapPanY or 0)) * k
        if new <= 1.001 then frame.dungeonMapPanX, frame.dungeonMapPanY = 0, 0 end
        frame.dungeonMapZoom = new
        FDJ.RenderCustomDungeonMap(data, frame.dungeonMapFloor)
    end)
    -- Left-click and hold to drag the zoomed map around. The drag ends on
    -- mouse up (also when released outside the map) or when the map hides.
    local function StopDrag(self)
        if not self.fdjDrag then return end
        self.fdjDrag = nil
        if ResetCursor then pcall(ResetCursor) end
    end
    panel:SetScript("OnMouseDown", function(self, button)
        if button ~= "LeftButton" or (frame.dungeonMapZoom or 1) <= 1.001 then return end
        local scale = self:GetEffectiveScale()
        local cx, cy = GetCursorPosition()
        self.fdjDrag = { x = cx / scale, y = cy / scale, px = frame.dungeonMapPanX or 0, py = frame.dungeonMapPanY or 0 }
        if SetCursor then pcall(SetCursor, "Interface\\CURSOR\\UI-Cursor-Move") end
    end)
    panel:HookScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then StopDrag(self) end
    end)
    panel:HookScript("OnHide", StopDrag)
    if panel.RegisterEvent then pcall(panel.RegisterEvent, panel, "GLOBAL_MOUSE_UP") end
    panel:SetScript("OnEvent", function(self, event, button)
        if event == "GLOBAL_MOUSE_UP" and (button == nil or button == "LeftButton") then StopDrag(self) end
    end)
    panel:SetScript("OnUpdate", function(self)
        local d = self.fdjDrag
        if not d then return end
        local scale = self:GetEffectiveScale()
        local cx, cy = GetCursorPosition()
        frame.dungeonMapPanX = d.px + (cx / scale - d.x)
        frame.dungeonMapPanY = d.py + (cy / scale - d.y)
        FDJ.PositionDungeonMapHolder()
    end)
end

-- Floor to open a dungeon's map on: the one last looked at, else the entrance floor.
FDJ.SavedMapFloor = function(dungeonName, data)
    local floors = data and data.floors or {}
    local saved = ForeverDungeonJournalDB.mapFloors and ForeverDungeonJournalDB.mapFloors[dungeonName]
    if type(saved) == "number" and saved >= 1 and saved <= #floors then return saved end
    return data and data.entrance and data.entrance.floor or 1
end

FDJ.RenderCustomDungeonMap = function(data, floorIndex)
    if not frame or not frame.dungeonMapArtHolder or not data then return end
    ClearDungeonMapArt()
    local holder = frame.dungeonMapArtHolder
    local panel = frame.dungeonMapPanel
    local floors = data.floors or {}
    floorIndex = math.max(1, math.min(#floors, floorIndex or (data.entrance and data.entrance.floor) or 1))
    frame.dungeonMapFloor = floorIndex
    -- Remember the floor per dungeon so the map reopens where it was left.
    if selectedDungeon and DB[selectedDungeon] then
        ForeverDungeonJournalDB.mapFloors = ForeverDungeonJournalDB.mapFloors or {}
        ForeverDungeonJournalDB.mapFloors[selectedDungeon] = floorIndex
    end
    local floorData = floors[floorIndex]
    if not floorData then return end

    -- Fit the 3:2 map art into the page without stretching (centred), then
    -- apply the current zoom (mouse wheel) and pan (drag).
    local aspect = 3 / 2
    local availW = math.max(200, (panel:GetWidth() or 760) - 16)
    local availH = math.max(140, (panel:GetHeight() or 380) - 16)
    local baseW, baseH = availW, availW / aspect
    if baseH > availH then baseH = availH; baseW = availH * aspect end
    baseW, baseH = math.floor(baseW), math.floor(baseH)
    local zoom = frame.dungeonMapZoom or 1
    local artW, artH = math.floor(baseW * zoom), math.floor(baseH * zoom)
    frame.dungeonMapBaseW, frame.dungeonMapBaseH = baseW, baseH

    holder:SetSize(artW, artH)
    FDJ.PositionDungeonMapHolder()
    if holder.SetClipsChildren then holder:SetClipsChildren(true) end
    if frame.dungeonMapCanvas then
        frame.dungeonMapCanvas:ClearAllPoints()
        frame.dungeonMapCanvas:SetAllPoints(panel)
        frame.dungeonMapCanvas:SetBackdropColor(0, 0, 0, 0)
        frame.dungeonMapCanvas:SetBackdropBorderColor(0, 0, 0, 0)
    end

    local tiles = frame.dungeonMapArtTiles
    local function Tile(i)
        local t = tiles[i]
        if not t then t = holder:CreateTexture(nil, "ARTWORK"); tiles[i] = t end
        t:ClearAllPoints()
        return t
    end
    if floorData.texture then
        if FDJ.CheckMapTiles then pcall(FDJ.CheckMapTiles, panel, nil) end
        local t = Tile(1)
        t:SetAllPoints(holder)
        t:SetTexture(floorData.texture)
        t:SetTexCoord(0, floorData.texRight or 1, 0, floorData.texBottom or 1)
        t:Show()
    else
        -- Prefer C_Map's numeric FileDataIDs when a UIMapID is supplied.
        -- FileDataIDs are locale-independent, unlike some legacy Interface\WorldMap
        -- texture aliases which are missing on certain localized Forever clients.
        local apiTextures, apiLayer
        frame.dungeonMapArtMissing = false
        frame.dungeonMapArtCopy = false
        if floorData.uiMapID and C_Map and C_Map.GetMapArtLayers and C_Map.GetMapArtLayerTextures then
            -- The stored map ID first; if this client has no art under it, the
            -- map found by the dungeon's name (see Systems/MapArtFinder.lua).
            for attempt = 1, 2 do
                local mapID = floorData.uiMapID
                if attempt == 2 then mapID = FDJ.FindMapArtID and FDJ.FindMapArtID(selectedDungeon, floorData) end
                if not mapID or (attempt == 2 and mapID == floorData.uiMapID) then break end
                local okLayers, layers = pcall(C_Map.GetMapArtLayers, mapID)
                if okLayers and type(layers) == "table" and layers[1] then
                    local okTextures, textures = pcall(C_Map.GetMapArtLayerTextures, mapID, 1)
                    if okTextures and type(textures) == "table" and #textures > 0 then
                        apiLayer, apiTextures = layers[1], textures
                        break
                    end
                end
            end
        end

        if apiTextures and apiLayer then
            local layerW = tonumber(apiLayer.layerWidth) or 1002
            local layerH = tonumber(apiLayer.layerHeight) or 668
            local tileW = tonumber(apiLayer.tileWidth) or 256
            local tileH = tonumber(apiLayer.tileHeight) or 256
            local cols = math.max(1, math.ceil(layerW / tileW))
            local scaleX, scaleY = artW / layerW, artH / layerH
            local unloaded = false
            for i = 1, #apiTextures do
                local col, row = (i - 1) % cols, math.floor((i - 1) / cols)
                local t = Tile(i)
                t:SetSize(tileW * scaleX, tileH * scaleY)
                t:SetPoint("TOPLEFT", holder, "TOPLEFT", col * tileW * scaleX, -row * tileH * scaleY)
                -- If a file ID does not load on this client, try the tile's path.
                local loaded = t:SetTexture(apiTextures[i])
                if loaded == false and floorData.tiles then loaded = t:SetTexture(floorData.tiles .. i) end
                if loaded == false then unloaded = true end
                t:SetTexCoord(0, 1, 0, 1)
                t:SetDrawLayer("ARTWORK", 0)
                t:Show()
            end
            -- The game lists the map's pictures but this client cannot load
            -- them: the journal's own copy of the map instead.
            local copy = unloaded and FDJ.MapArtCopy and FDJ.MapArtCopy(floorData)
            if copy then
                for i = 2, #apiTextures do Tile(i):Hide() end
                local t = Tile(1)
                t:SetAllPoints(holder)
                t:SetTexture(copy)
                t:SetTexCoord(0, 1002 / 1024, 0, 668 / 1024)
                t:Show()
                frame.dungeonMapArtCopy = true
            end
        else
            -- Legacy fallback for clients where the map-art API is unavailable.
            -- Some localized clients (ruRU) do not have these map files at all:
            -- the file name then has no file ID. The journal then shows its own
            -- copy of the map (Media\Maps, the patches already on it); a map
            -- without a copy gets a plain parchment instead of black/green
            -- tiles, so the boss pins stay readable.
            local scale = artW / 1002
            local first = Tile(1)
            first:SetTexture(floorData.tiles .. 1)
            frame.dungeonMapArtMissing = FDJ.forceMissingMapArt
                or (first.GetTextureFileID and not first:GetTextureFileID()) or false
            local copy = frame.dungeonMapArtMissing and FDJ.MapArtCopy and FDJ.MapArtCopy(floorData)
            if copy then
                frame.dungeonMapArtMissing = false
                frame.dungeonMapArtCopy = true
            end
            for i = 1, 12 do
                local col, row = (i - 1) % 4, math.floor((i - 1) / 4)
                local t = Tile(i)
                t:ClearAllPoints()
                if copy or frame.dungeonMapArtMissing then
                    if i == 1 then
                        t:SetAllPoints(holder)
                        if copy then
                            -- 1002x668 map, top-left in a 1024x1024 texture.
                            t:SetTexture(copy)
                            t:SetTexCoord(0, 1002 / 1024, 0, 668 / 1024)
                        else
                            t:SetColorTexture(0.42, 0.33, 0.20, 1)
                        end
                        t:SetDrawLayer("ARTWORK", 0)
                        t:Show()
                    else
                        t:Hide()
                    end
                else
                    t:SetSize(256 * scale, 256 * scale)
                    t:SetPoint("TOPLEFT", holder, "TOPLEFT", col * 256 * scale, -row * 256 * scale)
                    t:SetTexture(floorData.tiles .. i)
                    t:SetTexCoord(0, 1, 0, 1)
                    t:SetDrawLayer("ARTWORK", 0)
                    t:Show()
                end
            end
        end
        if FDJ.CheckMapTiles then
            pcall(FDJ.CheckMapTiles, panel, tiles, apiTextures and #apiTextures or 12, floorData, apiTextures, apiLayer,
                frame.dungeonMapArtMissing and not apiTextures)
        end
        -- Parchment patches that cover the map's printed title banner.
        for p, patch in ipairs((not (frame.dungeonMapArtMissing and not apiTextures)) and not frame.dungeonMapArtCopy
            and floorData.patches or {}) do
            local t = Tile(12 + p)
            t:SetDrawLayer("ARTWORK", 1)
            t:SetPoint("TOPLEFT", holder, "TOPLEFT", patch.x0 * artW, -patch.y0 * artH)
            t:SetPoint("BOTTOMRIGHT", holder, "TOPLEFT", patch.x1 * artW, -patch.y1 * artH)
            t:SetTexture(patch.tex)
            t:SetTexCoord(0, 1, 0, 1)
            t:SetAlpha(patch.alpha or 1)
            t:Show()
        end
    end

    -- Floor selector (only for multi-level dungeons).
    frame.dungeonMapFloorButtons = frame.dungeonMapFloorButtons or {}
    for i = 1, math.max(#floors, #frame.dungeonMapFloorButtons) do
        local btn = frame.dungeonMapFloorButtons[i]
        if i <= #floors and #floors > 1 then
            if not btn then
                btn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
                btn:SetScript("OnClick", function(self)
                    FDJ.ResetDungeonMapView()
                    FDJ.RenderCustomDungeonMap(FDJ.DUNGEON_MAPS[selectedDungeon], self.floorIndex)
                end)
                frame.dungeonMapFloorButtons[i] = btn
            end
            btn.floorIndex = i
            btn:SetText(L("MAP_FLOOR", i))
            local fs = btn:GetFontString()
            btn:SetSize(math.max(70, math.ceil((fs and fs:GetStringWidth() or 50) + 20)), 22)
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", panel, "TOPLEFT", 10, -10 - (i - 1) * 24)
            btn:SetFrameLevel(holder:GetFrameLevel() + 30)
            if i == floorIndex then btn:Disable() else btn:Enable() end
            btn:Show()
        elseif btn then
            btn:Hide()
        end
    end

    if FDJ.UpdateMapBossSizer then pcall(FDJ.UpdateMapBossSizer, panel, holder, frame.dungeonMapFloorButtons) end
    local dungeon = DB[selectedDungeon]
    local size = math.floor(math.max(26, math.floor(baseH * 0.095)) * (FDJ.MapBossScale and FDJ.MapBossScale() or 1))
    local shown = 0
    for _, mapBoss in ipairs(data.bosses or {}) do
        if (mapBoss.floor or 1) == floorIndex then
            shown = shown + 1
            local marker = frame.dungeonMapBossMarkers[shown]
            if not marker then
                marker = CreateFrame("Button", nil, holder)
                marker.portrait = marker:CreateTexture(nil, "ARTWORK")
                marker.portrait:SetAllPoints()
                marker.border = marker:CreateTexture(nil, "OVERLAY")
                marker.border:SetPoint("CENTER")
                marker.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
                marker.border:SetTexCoord(0, 0.6, 0, 0.6)
                marker:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText(self.bossName or "")
                    GameTooltip:Show()
                end)
                marker:SetScript("OnLeave", function() GameTooltip:Hide() end)
                frame.dungeonMapBossMarkers[shown] = marker
            end
            if marker:GetParent() ~= holder then marker:SetParent(holder) end
            marker:SetSize(size, size)
            marker.border:SetSize(size * 1.55, size * 1.55)
            marker:SetFrameLevel(holder:GetFrameLevel() + 10)

            local bossRecord, bossIndex
            for idx, candidate in ipairs((dungeon and dungeon.bosses) or {}) do
                if candidate.name == mapBoss.name then bossRecord, bossIndex = candidate, idx break end
            end
            marker.portrait:SetTexCoord(0, 1, 0, 1)
            local rpgHidden = FDJ.RPGMapBossHidden and FDJ.RPGMapBossHidden(selectedDungeon, bossRecord) or false -- rpgpartial
            local portraitRecord = (not rpgHidden) and (bossRecord or (mapBoss.npcID and { name = mapBoss.name, npcID = mapBoss.npcID })) or nil
            if not (portraitRecord and SetBossPortrait(marker.portrait, selectedDungeon, portraitRecord)) then
                marker.portrait:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                marker.portrait:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            end
            marker.bossName = rpgHidden and "???" or (bossRecord and BossName(bossRecord.name) or mapBoss.name)
            local markerDungeon = selectedDungeon
            marker:SetScript("OnClick", function()
                if not bossIndex then return end
                -- On the world map (dungeon map shown over the M map): close
                -- the world map and open the journal on this boss's loot page.
                if FDJ.IsWorldMapOverlayAttached and FDJ.IsWorldMapOverlayAttached() and FDJ.OpenBossFromWorldMap then
                    FDJ.OpenBossFromWorldMap(markerDungeon, bossIndex)
                    return
                end
                if SetMode and SelectBoss then
                    SetMode("bosses")
                    SelectBoss(bossIndex)
                end
            end)
            marker:ClearAllPoints()
            marker:SetPoint("CENTER", holder, "TOPLEFT", mapBoss.x * artW, -(mapBoss.y * artH))
            marker:SetShown(size > 0) -- boss icon size 0% hides them
        end
    end
    for i = shown + 1, #frame.dungeonMapBossMarkers do
        frame.dungeonMapBossMarkers[i]:Hide()
    end

    -- Entrance: the usual instance-portal icon with a yellow, black-outlined
    -- "Entrance" label next to it.
    -- data.entrances (several, each with its own labelKey / color) replaces
    -- the single data.entrance when present.
    local entList = data.entrances or (data.entrance and { data.entrance }) or {}
    frame.dungeonMapEntrances = frame.dungeonMapEntrances or {}
    local function EntranceFrame(i)
        local e = frame.dungeonMapEntrances[i]
        if e then return e end
        e = CreateFrame("Frame", nil, holder)
        e.icon = e:CreateTexture(nil, "OVERLAY")
        e.icon:SetAllPoints()
        local ok = e.icon.SetAtlas and pcall(e.icon.SetAtlas, e.icon, "Dungeon", false)
        if not ok then
            e.icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_01")
            e.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        end
        -- Font objects only (never SetFont with a raw file): Blizzard's font
        -- families carry the Korean/Cyrillic glyph fallbacks.
        e.label = e:CreateFontString(nil, "OVERLAY", _G.SystemFont_Shadow_Large_Outline and "SystemFont_Shadow_Large_Outline" or "GameFontNormalLarge")
        e.label:SetShadowColor(0, 0, 0, 1)
        e.label:SetShadowOffset(1, -1)
        frame.dungeonMapEntrances[i] = e
        return e
    end
    local entShown = 0
    for _, ent in ipairs(entList) do
        if (ent.floor or 1) == floorIndex then
            entShown = entShown + 1
            local e = EntranceFrame(entShown)
            if e:GetParent() ~= holder then e:SetParent(holder) end
            local iconSize = math.max(22, math.floor(baseH * 0.075))
            e:SetSize(iconSize, iconSize)
            e:SetFrameLevel(holder:GetFrameLevel() + 15)
            e:ClearAllPoints()
            e:SetPoint("CENTER", holder, "TOPLEFT", ent.x * artW, -(ent.y * artH))
            -- Label goes on the side given by the old arrow angle (default right).
            local rad = math.rad(ent.angle or 0)
            e.label:SetText(L(ent.labelKey or "MAP_ENTRANCE"))
            local c = ent.color
            if c then e.label:SetTextColor(c[1], c[2], c[3]) else e.label:SetTextColor(1.00, 0.82, 0.00) end
            e.label:ClearAllPoints()
            if ent.labelPos == "top" then
                e.label:SetPoint("BOTTOM", e, "TOP", 0, 1)
            elseif math.cos(rad) < -0.3 then
                e.label:SetPoint("RIGHT", e, "LEFT", -3, 0)
            else
                e.label:SetPoint("LEFT", e, "RIGHT", 3, 0)
            end
            e:Show()
        end
    end
    for i = entShown + 1, #frame.dungeonMapEntrances do
        frame.dungeonMapEntrances[i]:Hide()
    end
    frame.dungeonMapEntrance = frame.dungeonMapEntrances[1]

    -- Green arrows showing where to go down/up to the next level. Clicking
    -- one switches the map to that level.
    frame.dungeonMapTransitions = frame.dungeonMapTransitions or {}
    local used = 0
    for _, tr in ipairs(data.transitions or {}) do
        if tr.floor == floorIndex and (floors[tr.to] or tr.note) then
            used = used + 1
            local t = frame.dungeonMapTransitions[used]
            if not t then
                t = CreateFrame("Button", nil, holder)
                -- Ladder icon marking where to change level.
                t.arrow = t:CreateTexture(nil, "OVERLAY")
                t.arrow:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\LevelLadder")
                t.arrow:SetTexCoord(0, 1, 0, 1)
                t.arrow:SetAllPoints()
                t.label = t:CreateFontString(nil, "OVERLAY", _G.SystemFont_Outline and "SystemFont_Outline" or "GameFontNormal")
                t.label:SetShadowColor(0, 0, 0, 1)
                t.label:SetShadowOffset(1, -1)
                t.label:SetTextColor(0.35, 1.00, 0.35)
                t.label:SetPoint("BOTTOM", t, "TOP", 0, 1)
                t:SetScript("OnClick", function(self)
                    if not self.toFloor then return end
                    FDJ.ResetDungeonMapView()
                    FDJ.RenderCustomDungeonMap(FDJ.DUNGEON_MAPS[selectedDungeon], self.toFloor)
                end)
                t:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText(self.toFloor and L("MAP_FLOOR", self.toFloor) or self.noteText or "", 0.35, 1, 0.35)
                    GameTooltip:Show()
                end)
                t:SetScript("OnLeave", function() GameTooltip:Hide() end)
                frame.dungeonMapTransitions[used] = t
            end
            if t:GetParent() ~= holder then t:SetParent(holder) end
            t.toFloor = tr.to
            local len = math.max(28, math.floor(baseH * 0.10))
            t:SetSize(len, len)
            t:SetFrameLevel(holder:GetFrameLevel() + 14)
            t:ClearAllPoints()
            t:SetPoint("CENTER", holder, "TOPLEFT", tr.x * artW, -(tr.y * artH))
            -- Notes (no level change) only show their text on hover.
            t.noteText = tr.note and L(tr.labelKey) or nil
            t.label:SetText(tr.note and "" or L(tr.labelKey or "MAP_FLOOR", tr.to))
            t:Show()
        end
    end
    for i = used + 1, #frame.dungeonMapTransitions do
        frame.dungeonMapTransitions[i]:Hide()
    end

    -- Yellow "?" where a quest objective is picked up or clicked on the spot.
    frame.dungeonMapObjectives = frame.dungeonMapObjectives or {}
    local nObj = 0
    for _, ob in ipairs(data.objectives or {}) do
        if (ob.floor or 1) == floorIndex then
            nObj = nObj + 1
            local q = frame.dungeonMapObjectives[nObj]
            if not q then
                q = CreateFrame("Frame", nil, holder)
                q:EnableMouse(true)
                q.icon = q:CreateTexture(nil, "OVERLAY")
                q.icon:SetAllPoints()
                q.icon:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon")
                q:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText(self.title or "", 1, 0.82, 0)
                    if self.body then GameTooltip:AddLine(self.body, 1, 1, 1, true) end
                    GameTooltip:Show()
                end)
                q:SetScript("OnLeave", function() GameTooltip:Hide() end)
                frame.dungeonMapObjectives[nObj] = q
            end
            if q:GetParent() ~= holder then q:SetParent(holder) end
            q.title = QuestField(ob.questID, "name", ob.quest)
            q.body = ob.textKey and L(ob.textKey) or nil
            local size = math.max(22, math.floor(baseH * 0.07))
            q:SetSize(size, size)
            q:SetFrameLevel(holder:GetFrameLevel() + 15)
            q:ClearAllPoints()
            q:SetPoint("CENTER", holder, "TOPLEFT", ob.x * artW, -(ob.y * artH))
            q:Show()
        end
    end
    for i = nObj + 1, #frame.dungeonMapObjectives do
        frame.dungeonMapObjectives[i]:Hide()
    end

    -- Yellow ? on the NPC a quest is handed in to, set by the quest tracker's
    -- ? button; stays until the quest leaves the log or it is right-clicked.
    -- The tracker's ! puts a yellow ! on the giver instead, until the quest
    -- is taken.
    local turnIn = FDJ.dungeonTurnIns and FDJ.dungeonTurnIns[data]
    if turnIn and turnIn.questID then
        local gone
        if turnIn.start then
            gone = IsQuestInLog(turnIn.questID) or FDJ.QuestTurnedIn(turnIn.questID)
        else
            gone = not IsQuestInLog(turnIn.questID)
        end
        if gone then
            FDJ.dungeonTurnIns[data] = nil
            turnIn = nil
        end
    end
    local mark = frame.dungeonMapTurnIn
    if turnIn and turnIn.floor == floorIndex and turnIn.x and turnIn.y then
        if not mark then
            mark = CreateFrame("Button", nil, holder)
            mark:RegisterForClicks("RightButtonUp")
            mark.icon = mark:CreateTexture(nil, "OVERLAY")
            mark.icon:SetAllPoints()
            mark.icon:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon")
            mark:SetScript("OnEnter", function(self)
                local t = self.turnIn
                if not t then return end
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                local text = (FDJ.LocalizeFreeText and FDJ.LocalizeFreeText(t.npc)) or t.npc or ""
                if type(t.title) == "string" and t.title ~= "" then text = text .. " \226\128\148 " .. t.title end
                GameTooltip:SetText(text)
                GameTooltip:AddLine(L(t.start and "QUEST_STARTS_HERE" or "TURN_IN_HERE"), 1, 0.82, 0.05)
                GameTooltip:AddLine(L("MAP_RIGHT_REMOVE"), 1, 1, 1)
                GameTooltip:Show()
            end)
            mark:SetScript("OnLeave", function() GameTooltip:Hide() end)
            mark:SetScript("OnClick", function(self, button)
                if button ~= "RightButton" then return end
                for key, value in pairs(FDJ.dungeonTurnIns or {}) do
                    if value == self.turnIn then FDJ.dungeonTurnIns[key] = nil end
                end
                self.turnIn = nil
                self:Hide()
                GameTooltip:Hide()
                if FDJ.RefreshMapQuestPins then pcall(FDJ.RefreshMapQuestPins) end -- mapquests
            end)
            frame.dungeonMapTurnIn = mark
        end
        if mark:GetParent() ~= holder then mark:SetParent(holder) end
        mark.turnIn = turnIn
        mark.icon:SetTexture(turnIn.start and "Interface\\GossipFrame\\AvailableQuestIcon" or "Interface\\GossipFrame\\ActiveQuestIcon")
        local size = math.max(24, math.floor(baseH * 0.08))
        mark:SetSize(size, size)
        if FDJ.StrokeIcon then FDJ.StrokeIcon(mark, mark.icon, size) end -- mapquests: a black edge
        mark:SetFrameLevel(holder:GetFrameLevel() + 16)
        mark:ClearAllPoints()
        mark:SetPoint("CENTER", holder, "TOPLEFT", turnIn.x * artW, -(turnIn.y * artH))
        mark:Show()
    elseif mark then
        mark.turnIn = nil
        mark:Hide()
    end

    -- mapquests: the quests' spots on this level (Systems/MapMarkers.lua).
    if FDJ.RenderMapQuestPins then
        pcall(FDJ.RenderMapQuestPins, selectedDungeon, floorIndex, holder, artW, artH, baseH, selectedQuestFaction)
    end
end

HideDungeonMap = function()
    if frame and frame.dungeonMapPanel then frame.dungeonMapPanel:Hide() end
end

ShowDungeonMap = function()
    if not frame or not FDJ.DUNGEON_MAPS[selectedDungeon] then return end
    if FDJ.IsDungeonMapLocked and FDJ.IsDungeonMapLocked(selectedDungeon) then return end -- rpgpartial
    -- The map panel may be lent to the world map (M): take it back first.
    if FDJ.DetachWorldMapOverlay then pcall(FDJ.DetachWorldMapOverlay) end
    HideRouteGuide()
    frame.leftPanel:Hide()
    frame.rightPanel:Hide()
    frame.questLeftPanel:Hide()
    frame.questRightPanel:Hide()
    frame.dungeonMapTitle:SetText("")
    frame.dungeonMapPanel:Show()
    local mapData = FDJ.DUNGEON_MAPS[selectedDungeon]
    FDJ.SetupDungeonMapZoom()
    FDJ.ResetDungeonMapView()
    FDJ.RenderCustomDungeonMap(mapData, FDJ.SavedMapFloor(selectedDungeon, mapData))
    UpdateModeTabs()
end

SetMode = function(mode)
    if mode ~= "bosses" and mode ~= "quests" then return end
    HideRouteGuide()
    if HideDungeonMap then HideDungeonMap() end

    if mode ~= "bosses" and ResetPortraitResolver then
        ResetPortraitResolver()
    end

    selectedMode = mode
    ForeverDungeonJournalDB.lastMode = mode

    -- Every time the quest tab is opened, start on the player's own faction.
    -- The faction buttons can still be used manually afterwards.
    if mode == "quests" and FDJ.keepQuestState then
        -- Language change: keep the faction, quest and chain step being viewed.
        BuildVisibleQuestIndexes()
    elseif mode == "quests" and UnitFactionGroup then
        local playerFaction = UnitFactionGroup("player")
        if playerFaction == "Horde" then
            selectedQuestFaction = "Horde"
        elseif playerFaction == "Alliance" then
            selectedQuestFaction = "Alliance"
        end
        ForeverDungeonJournalDB.questFaction = selectedQuestFaction
        selectedPrereqStep = nil
        selectedPrereqParentQuestName = nil
        selectedPrereqParentQuestID = nil
        if frame and frame.questListScroll then
            frame.questListScroll:SetVerticalScroll(0)
        end
        BuildVisibleQuestIndexes()
    end

    local bosses = mode == "bosses"
    frame.leftPanel:SetShown(bosses)
    frame.rightPanel:SetShown(bosses)
    frame.questLeftPanel:SetShown(not bosses)
    frame.questRightPanel:SetShown(not bosses)

    UpdateModeTabs()

    if bosses then
        RefreshBossList()
        RefreshLoot()
    else
        local quests = DB[selectedDungeon].quests or {}
        if selectedQuest > #quests then selectedQuest = 1 end

        for _, quest in ipairs(quests) do
            RequestQuestRewardData(quest.id)
        end

        RefreshQuestList()
        RefreshQuestDetail()
    end
end

SelectQuest = function(index, allowHidden)
    local quests = DB[selectedDungeon].quests or {}
    if not quests[index] then return end

    allowHiddenQuestSelection = allowHidden == true
    selectedPrereqStep = nil
    selectedPrereqParentQuestName = nil
    selectedPrereqParentQuestID = nil
    RequestQuestRewardData(quests[index].id)

    selectedQuest = index
    ForeverDungeonJournalDB.lastQuest = index
    RefreshQuestList()
    RefreshQuestDetail()
end

SelectQuestByID = function(questID)
    if not questID then return end
    local quests = DB[selectedDungeon].quests or {}
    for index, quest in ipairs(quests) do
        if quest.id == questID then
            SelectQuest(index, quest.hideFromMainList == true)
            return
        end
    end
end

local function MakeDungeonTab(parent, dungeonName, x)
    local button = CreateFrame("Button", nil, parent, "BackdropTemplate")
    button:SetSize(180, 31)
    button:SetPoint("TOPLEFT", x, -50)

    SetBackdrop(
        button,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        9,
        2
    )

    button.text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    button.text:SetPoint("CENTER")
    button.text:SetText(DungeonName(dungeonName))

    button:SetScript("OnClick", function()
        local dungeon = DB[dungeonName]
        if dungeon and dungeon.previewOnly and not FDJ.DUNGEON_MAPS[dungeonName] then return end
        SelectDungeon(dungeonName)
    end)

    dungeonTabs[dungeonName] = button
end

local function UpdateTabs()
    for name, tab in pairs(dungeonTabs) do
        if name == selectedDungeon then
            tab:SetBackdropColor(0.43, 0.23, 0.07, 1)
            tab.text:SetTextColor(1, 0.82, 0.27)
        else
            tab:SetBackdropColor(0.07, 0.065, 0.055, 0.98)
            tab.text:SetTextColor(0.77, 0.71, 0.62)
        end
    end
end


-- Loading screens have the World of Warcraft logo baked into the upper area.
-- Crop Deadmines/BFD lower so the home cards show only dungeon artwork.
FDJ.HomeLevelText = function(level)
    local value = tostring(level or "")
    value = value:gsub("%++$", "+")
    return "LV " .. value
end

local homeDungeonCards = {}
local homeEditMode = false
-- Dungeons hidden by hand are stored per character (ForeverDungeonJournalCharacterDB).
-- Older versions kept one account-wide list; the first character to log in
-- after the update takes it over and the account-wide copy is removed.
FDJ.HiddenDungeons = function()
    ForeverDungeonJournalCharacterDB = ForeverDungeonJournalCharacterDB or {}
    local char = ForeverDungeonJournalCharacterDB
    if not char.hiddenDungeons then
        local old = ForeverDungeonJournalDB and ForeverDungeonJournalDB.hiddenDungeons
        char.hiddenDungeons = {}
        if type(old) == "table" then
            for k, v in pairs(old) do char.hiddenDungeons[k] = v end
            ForeverDungeonJournalDB.hiddenDungeons = nil
        end
    end
    return char.hiddenDungeons
end


local function MakeHomeDungeonCard(parent, dungeonName)
    local button = CreateFrame("Button", nil, parent, "BackdropTemplate")
    button.dungeonName = dungeonName
    button:SetSize(352, 126)

    SetBackdrop(
        button,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        12,
        3
    )
    button:SetBackdropColor(0.02, 0.02, 0.02, 0.45)
    button:SetBackdropBorderColor(0.34, 0.34, 0.34, 1)

    button.art = button:CreateTexture(nil, "ARTWORK", nil, 1)
    button.art:SetPoint("TOPLEFT", 4, -4)
    button.art:SetPoint("BOTTOMRIGHT", -4, 4)
    button.art:SetTexture(DUNGEON_HOME_ART[dungeonName])
    local crop = DUNGEON_HOME_TEXCOORD[dungeonName] or { 0.03, 0.97, 0.05, 0.95 }
    button.art:SetTexCoord(crop[1], crop[2], crop[3], crop[4])
    button.art:SetVertexColor(1, 1, 1, 1)
    button.art:SetAlpha(1)

    button.topShade = button:CreateTexture(nil, "ARTWORK", nil, 2)
    button.topShade:SetTexture("Interface\\Buttons\\WHITE8X8")
    button.topShade:SetPoint("TOPLEFT", 4, -4)
    button.topShade:SetPoint("TOPRIGHT", -4, -4)
    button.topShade:SetHeight(42)
    button.topShade:SetColorTexture(0, 0, 0, 0.42)

    button.fullShade = button:CreateTexture(nil, "ARTWORK", nil, 0)
    button.fullShade:SetTexture("Interface\\Buttons\\WHITE8X8")
    button.fullShade:SetPoint("TOPLEFT", 4, -4)
    button.fullShade:SetPoint("BOTTOMRIGHT", -4, 4)
    button.fullShade:SetColorTexture(0.02, 0.02, 0.02, 0.10)

    button.previewIcon = button:CreateTexture(nil, "ARTWORK", nil, 2)
    button.previewIcon:SetSize(62, 62)
    button.previewIcon:SetPoint("CENTER", 0, -5)
    button.previewIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    button.previewIcon:SetAlpha(0.55)
    button.previewIcon:Hide()

    button.innerGlow = button:CreateTexture(nil, "ARTWORK", nil, 3)
    button.innerGlow:SetTexture("Interface\\Buttons\\WHITE8X8")
    button.innerGlow:SetPoint("TOPLEFT", 4, -4)
    button.innerGlow:SetPoint("TOPRIGHT", -4, -4)
    button.innerGlow:SetHeight(1)
    button.innerGlow:SetColorTexture(1.0, 0.84, 0.25, 0.30)

    button.highlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
    button.highlight:SetPoint("TOPLEFT", 4, -4)
    button.highlight:SetPoint("BOTTOMRIGHT", -4, 4)
    button.highlight:SetColorTexture(1, 1, 1, 0.08)

    button.title = button:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    button.title:SetPoint("TOPLEFT", 16, -14)
    button.title:SetWidth(220)
    button.title:SetJustifyH("LEFT")
    button.title:SetJustifyV("TOP")
    button.title:SetText(DungeonName(dungeonName))
    button.title:SetTextColor(1.00, 0.88, 0.24)
    button.title:SetShadowColor(0, 0, 0, 1)
    button.title:SetShadowOffset(1, -1)

    button.meta = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    button.meta:SetPoint("BOTTOMLEFT", 14, 10)
    button.meta:SetPoint("RIGHT", -16, 0)
    button.meta:SetJustifyH("LEFT")
    button.meta:SetTextColor(1.00, 0.95, 0.82)
    button.meta:SetShadowColor(0, 0, 0, 1)
    button.meta:SetShadowOffset(1, -1)

    button.counts = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    button.counts:SetPoint("TOPRIGHT", -14, -11)
    button.counts:SetJustifyH("RIGHT")
    button.counts:SetTextColor(0.97, 0.89, 0.54)
    button.counts:SetShadowColor(0, 0, 0, 1)
    button.counts:SetShadowOffset(1, -1)

    button.coverBorder = button:CreateTexture(nil, "OVERLAY", nil, 4)
    button.coverBorder:SetTexture("Interface\\Buttons\\WHITE8X8")
    button.coverBorder:SetPoint("LEFT", 4, 0)
    button.coverBorder:SetPoint("RIGHT", -4, 0)
    button.coverBorder:SetHeight(1)
    button.coverBorder:SetColorTexture(1, 1, 1, 0.04)

    -- Edit-mode treatment. The cyan wash mirrors Blizzard's Edit Mode selection
    -- without replacing the dungeon artwork underneath.
    button.editOverlay = button:CreateTexture(nil, "OVERLAY", nil, 5)
    button.editOverlay:SetPoint("TOPLEFT", 4, -4)
    button.editOverlay:SetPoint("BOTTOMRIGHT", -4, 4)
    button.editOverlay:SetColorTexture(0.20, 0.78, 1.00, 0.18)
    button.editOverlay:Hide()

    button.editBorder = button:CreateTexture(nil, "OVERLAY", nil, 6)
    button.editBorder:SetTexture("Interface\\Buttons\\WHITE8X8")
    button.editBorder:SetPoint("TOPLEFT", 4, -4)
    button.editBorder:SetPoint("BOTTOMRIGHT", -4, 4)
    button.editBorder:SetColorTexture(0.35, 0.86, 1.00, 0.12)
    button.editBorder:Hide()

    button.hiddenShade = button:CreateTexture(nil, "OVERLAY", nil, 7)
    button.hiddenShade:SetPoint("TOPLEFT", 4, -4)
    button.hiddenShade:SetPoint("BOTTOMRIGHT", -4, 4)
    button.hiddenShade:SetColorTexture(0.02, 0.05, 0.08, 0.58)
    button.hiddenShade:Hide()

    button.hiddenText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    button.hiddenText:SetPoint("CENTER", 0, 0)
    button.hiddenText:SetTextColor(1.00, 1.00, 1.00)
    button.hiddenText:SetShadowColor(0, 0, 0, 1)
    button.hiddenText:SetShadowOffset(1, -1)
    button.hiddenText:Hide()

    button:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(1.00, 0.76, 0.22, 1)
        self.fullShade:SetColorTexture(1, 0.82, 0.18, 0.08)
        local activeDungeonName = self.dungeonName
        local dungeon = DB[activeDungeonName]
        if not homeEditMode and FDJ.RPGLockedTooltip and FDJ.IsDungeonLocked and FDJ.IsDungeonLocked(activeDungeonName) then
            pcall(FDJ.RPGLockedTooltip, self, activeDungeonName)
            return
        end
        -- Normal cards need no tooltip (the card already shows the name and
        -- clicking it is obvious); only Hide Dungeons mode and preview-only
        -- dungeons still explain themselves.
        if not homeEditMode and not (dungeon and dungeon.previewOnly) then return end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(DungeonName(activeDungeonName))
        if homeEditMode then
            if FDJ.HiddenDungeons()[activeDungeonName] then
                GameTooltip:AddLine(L("CLICK_RESTORE_DUNGEON"), 1, 1, 1)
            else
                GameTooltip:AddLine(L("CLICK_HIDE_DUNGEON"), 1, 1, 1)
            end
        elseif dungeon and dungeon.previewOnly then
            GameTooltip:AddLine(L("PREVIEW_DATA_SOON"), 0.82, 0.78, 0.68, true)
            if FDJ.DUNGEON_MAPS[activeDungeonName] then GameTooltip:AddLine(L("PREVIEW_MAP_CLICK"), 1, 1, 1) end
        else
            GameTooltip:AddLine(L("CLICK_DUNGEON"), 1, 1, 1)
        end
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(0.34, 0.34, 0.34, 1)
        self.fullShade:SetColorTexture(0.02, 0.02, 0.02, 0.10)
        GameTooltip:Hide()
    end)

    button:SetScript("OnClick", function(self)
        local activeDungeonName = self.dungeonName
        if not activeDungeonName then return end
        if homeEditMode then
            FDJ.HiddenDungeons()[activeDungeonName] = not FDJ.HiddenDungeons()[activeDungeonName] or nil
            PlayJournalOptionSound()
            RefreshHomeDungeonCards()
            return
        end
        SelectDungeon(activeDungeonName)
    end)

    return button
end

-- Used by Systems/SettingsPanel.lua.
FDJ.IsQuestFinished = IsQuestFinished
-- questtracker: the on-screen quest tracker (Systems/QuestText.lua) reads
-- the quest log and the list's faction/class filter through these.
FDJ.IsQuestInLog = IsQuestInLog
FDJ.QuestMatchesFaction = QuestMatchesFaction
FDJ.RefreshHomeCards = function()
    if RefreshHomeDungeonCards then RefreshHomeDungeonCards() end
end

RefreshHomeDungeonCards = function()
    if not frame or not frame.homeCardsContent or not frame.homeScroll then return end

    local shownDungeons = {}
    for _, dungeonName in ipairs(ORDER) do
        -- RPG Mode: locked dungeons always show (as sketches) and can't be
        -- hidden, so the hide editor only lists unlocked ones.
        local rpgLocked = FDJ.IsDungeonLocked and FDJ.IsDungeonLocked(dungeonName)
        if not homeEditMode and FDJ.HomeFilterHides and FDJ.HomeFilterHides(dungeonName) then
            -- WoW Forever emblem filter: only Forever's new dungeons.
        elseif rpgLocked then
            if not homeEditMode then shownDungeons[#shownDungeons + 1] = dungeonName end
        elseif homeEditMode or not (FDJ.HiddenDungeons()[dungeonName]
            or (FDJ.IsDungeonAutoHidden and FDJ.IsDungeonAutoHidden(dungeonName))) then
            shownDungeons[#shownDungeons + 1] = dungeonName
        end
    end

    local rows = math.max(1, math.ceil(#shownDungeons / 2))
    local rowStep = 138
    local contentHeight = (#shownDungeons == 0) and 126 or (rows * rowStep - 12)
    local viewportHeight = frame.homeScroll:GetHeight() or 0
    local needsScroll = viewportHeight > 0 and contentHeight > viewportHeight + 4

    -- Do not reserve a dead scrollbar gutter when every dungeon already fits.
    frame.homeScroll:ClearAllPoints()
    frame.homeScroll:SetPoint("TOPLEFT", frame.homePanel, "TOPLEFT", 18, -72)
    frame.homeScroll:SetPoint("BOTTOMRIGHT", frame.homePanel, "BOTTOMRIGHT", needsScroll and -31 or -15, 15)

    local contentWidth = math.max(700, (frame.homeScroll:GetWidth() or 760) - 2)
    local gap = 12
    local cardWidth = math.floor((contentWidth - gap) / 2)
    frame.homeCardsContent:SetWidth(contentWidth)

    for i, dungeonName in ipairs(shownDungeons) do
        local dungeon = DB[dungeonName]
        local card = homeDungeonCards[i]

        if not card then
            card = MakeHomeDungeonCard(frame.homeCardsContent, dungeonName)
            homeDungeonCards[i] = card
        end

        local col = (i - 1) % 2
        local row = math.floor((i - 1) / 2)
        card.dungeonName = dungeonName

        -- Every dungeon tile keeps exactly the same dimensions. If the final
        -- row has an odd number of dungeons, the unused slot simply stays empty.
        card:SetWidth(cardWidth)
        card:ClearAllPoints()
        card:SetPoint("TOPLEFT", frame.homeCardsContent, "TOPLEFT", col * (cardWidth + gap), -row * rowStep)

        card.title:SetText(DungeonName(dungeonName))
        card.meta:SetText(FDJ.HomeLevelText(dungeon.level))
        local playerFaction = "Alliance"
        if UnitFactionGroup then
            local detectedFaction = UnitFactionGroup("player")
            if detectedFaction == "Horde" then playerFaction = "Horde" end
        end

        local factionQuestCount, finishedCount = 0, 0
        for _, quest in ipairs(dungeon.quests or {}) do
            if QuestMatchesFaction(quest, playerFaction) and not quest.hideFromMainList and not quest.repeatable then
                factionQuestCount = factionQuestCount + 1
                -- questdone: handed in only (ready to turn in is not done yet).
                if quest.id and FDJ.QuestTurnedIn(quest.id) then finishedCount = finishedCount + 1 end
            end
        end

        -- Green tick in front when every quest of this dungeon is done.
        local allDone = factionQuestCount > 0 and finishedCount == factionQuestCount
            and not ForeverDungeonJournalDB.hideDoneTick
        if not card.doneTick then
            card.doneGlow = card:CreateTexture(nil, "OVERLAY", nil, 5)
            card.doneGlow:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\TickGlow")
            card.doneGlow:SetBlendMode("ADD")
            card.doneGlow:SetAlpha(0.55)
            card.doneGlow:SetSize(34, 34)
            -- Open ring around the tick; its long stroke leaves through the gap.
            card.doneRing = card:CreateTexture(nil, "OVERLAY", nil, 6)
            card.doneRing:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\TickRing")
            card.doneRing:SetSize(22, 22)
            card.doneRing:SetPoint("RIGHT", card.counts, "LEFT", -3, 0)

            card.doneTick = card:CreateTexture(nil, "OVERLAY", nil, 7)
            card.doneTick:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
            card.doneTick:SetSize(17, 17)
            card.doneTick:SetPoint("CENTER", card.doneRing, "CENTER", 2, 2)
            card.doneGlow:SetPoint("CENTER", card.doneRing, "CENTER", 0, 0)
            if FDJ.AttachDoneTickTooltip then FDJ.AttachDoneTickTooltip(card) end
        end
        card.doneRing:SetShown(allDone)
        card.doneTick:SetShown(allDone)
        card.doneGlow:SetShown(allDone)
        local factionIcon = playerFaction == "Horde" and HORDE_ICON or ALLIANCE_ICON
        card.counts:SetText(
            "|T" .. factionIcon .. ":22:22:0:0|t "
            -- "2/6 quests" once at least one is done; just "6 quests" before that.
            .. ((finishedCount > 0) and (finishedCount .. "/" .. factionQuestCount) or tostring(factionQuestCount))
            .. " " .. (factionQuestCount == 1 and L("QUEST") or L("QUESTS_LOWER"))
        )
        local art = DUNGEON_HOME_ART[dungeonName]
        if art then
            card.art:SetTexture(art)
            card.art:SetVertexColor(1, 1, 1, 1)
        else
            card.art:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock")
            card.art:SetVertexColor(0.42, 0.36, 0.28, 1)
        end
        local crop = DUNGEON_HOME_TEXCOORD[dungeonName] or { 0.03, 0.97, 0.05, 0.95 }
        card.art:SetTexCoord(crop[1], crop[2], crop[3], crop[4])
        if FDJ.ApplyHomeBottomBand then pcall(FDJ.ApplyHomeBottomBand, card, dungeonName) end
        if card.previewIcon then card.previewIcon:Hide() end
        -- Announced dungeons: a centred "Coming Soon" instead of art and counts.
        if dungeon.previewOnly and not card.comingSoon then
            card.comingSoon = card:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
            card.comingSoon:SetPoint("CENTER", 0, -6)
            card.comingSoon:SetTextColor(1.00, 0.82, 0.20)
            card.comingSoon:SetShadowColor(0, 0, 0, 1)
            card.comingSoon:SetShadowOffset(1, -1)
        end
        if card.comingSoon then
            card.comingSoon:SetText(L("COMING_SOON"))
            card.comingSoon:SetShown(dungeon.previewOnly == true)
        end
        if dungeon.previewOnly then
            card.counts:SetText("")
            if art then card.art:SetVertexColor(0.8, 0.8, 0.8, 1) end
        end

        local isHidden = FDJ.HiddenDungeons()[dungeonName] == true
            or (FDJ.IsDungeonAutoHidden and FDJ.IsDungeonAutoHidden(dungeonName)) or false
        if card.editOverlay then card.editOverlay:SetShown(homeEditMode) end
        if card.editBorder then card.editBorder:SetShown(homeEditMode) end
        if card.hiddenShade then card.hiddenShade:SetShown(homeEditMode and isHidden) end
        if card.hiddenText then
            card.hiddenText:SetText(L("HIDDEN"))
            card.hiddenText:SetShown(homeEditMode and isHidden)
        end
        if homeEditMode then
            card:SetBackdropBorderColor(0.34, 0.82, 1.00, 1)
        else
            card:SetBackdropBorderColor(0.34, 0.34, 0.34, 1)
        end
        if FDJ.ApplyRPGCard then pcall(FDJ.ApplyRPGCard, card, dungeonName, homeEditMode) end
        card:Show()
    end

    for i = #shownDungeons + 1, #homeDungeonCards do
        if homeDungeonCards[i] then homeDungeonCards[i]:Hide() end
    end

    if frame.homeEmptyText then
        frame.homeEmptyText:SetText(L("ALL_DUNGEONS_HIDDEN"))
        frame.homeEmptyText:SetShown(#shownDungeons == 0 and not homeEditMode)
    end

    frame.homeCardsContent:SetHeight(contentHeight)
    UpdateScrollBarVisibility(frame.homeScroll, contentHeight)
    if FDJ.UpdateRPGHeader then pcall(FDJ.UpdateRPGHeader, frame) end
end

RefreshBossList = function()
    local dungeon = DB[selectedDungeon]

    for i = 1, math.max(#bossButtons, #dungeon.bosses) do
        local button = bossButtons[i]

        if i <= #dungeon.bosses then
            if not button then
                button = MakeBossButton(frame.bossContent)
                bossButtons[i] = button

                if i == 1 then
                    button:SetPoint("TOPLEFT", frame.bossContent, "TOPLEFT", 0, 0)
                else
                    button:SetPoint(
                        "TOPLEFT",
                        bossButtons[i - 1],
                        "BOTTOMLEFT",
                        0,
                        -6
                    )
                end
            end

            -- rpgpartial: RPG Mode, a boss not killed yet is a ? ("???").
            local boss = FDJ.RPGBossView and FDJ.RPGBossView(selectedDungeon, dungeon.bosses[i]) or dungeon.bosses[i]
            button.index = i
            if boss.fdjDungeon then
                -- Loot Filter page: bosses from every dungeon share one list.
                button.name:SetText(BossName(boss.name) .. "\n|cffb8ab94" .. DungeonName(boss.fdjDungeon) .. "|r")
            else
                button.name:SetText(BossName(boss.name))
            end

            local isRare = boss.rare == true
            button.rare:SetShown(isRare)
            -- v1.0.29: rares use a dedicated silver-dragon portrait overlay.
            -- Bosses with a fully bundled custom portrait (currently Lordaeron Captain)
            -- already include the dragon frame in the art, so do not overlay a second one.
            button.rareBorder:SetShown(isRare)
            button.name:ClearAllPoints()
            button.name:SetPoint("LEFT", button.portrait, "RIGHT", 11, 1)
            if isRare then
                button.name:SetPoint("RIGHT", button.rare, "LEFT", -8, 0)
            else
                button.name:SetPoint("RIGHT", -10, 0)
            end
            if FDJ.ApplyBossFactionTag then FDJ.ApplyBossFactionTag(button, boss, isRare) end

            local hasPortrait = SetBossPortrait(
                button.portrait,
                selectedDungeon,
                boss
            )
            button.question:SetShown(not hasPortrait)

            local bossLevel = BossLevelText(selectedDungeon, boss)
            if bossLevel then
                button.levelText:SetText(bossLevel)
                FitBossLevelText(button.levelText, bossLevel)
                button.levelBadge:Show()
                button.levelText:Show()
            else
                button.levelBadge:Hide()
                button.levelText:Hide()
            end

            local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]

            if selectedBoss == i then
                button:SetBackdropColor(unpack(theme.rowSelected))
                button:SetBackdropBorderColor(unpack(theme.border))
                button.name:SetTextColor(unpack(theme.title))
            else
                button:SetBackdropColor(unpack(theme.row))
                button:SetBackdropBorderColor(unpack(theme.border))
                button.name:SetTextColor(unpack(theme.muted))
            end


            button:Show()
        elseif button then
            button:Hide()
        end
    end

    local contentHeight = math.max(1, #dungeon.bosses * 61)
    frame.bossContent:SetHeight(contentHeight)
    UpdateScrollBarVisibility(frame.bossListScroll, contentHeight)
end

-- "Items Data TBD": dungeons flagged in the data plus every dungeon that has no loot entered
-- yet (the new level-30 dungeons). Stored on FDJ to stay under Lua's
-- 200-locals limit for this file.
FDJ.ShowsItemsTBD = function(name)
    local d = DB[name]
    if not d then return false end
    if d.questChainPage then return false end -- sleepingbag: no loot to list
    if d.itemsTBD or d.fullItemsTBD then return true end -- loot only partly known
    for _, boss in ipairs(d.bosses or {}) do
        if boss.loot and #boss.loot > 0 then return false end
    end
    return true
end

-- Text of the red disclaimer: "Full Items Data TBD" where some loot is listed
-- but the table is not complete yet, otherwise "Items Data TBD".
FDJ.ItemsTBDText = function(name)
    local d = DB[name]
    if d and d.fullItemsTBD then return "Full Items Data TBD" end
    return "Items Data TBD"
end

RefreshLoot = function()
    for _, row in ipairs(lootRows) do HideSearchItemHighlight(row) end
    local dungeon = DB[selectedDungeon]
    local boss = dungeon.bosses[selectedBoss]
    if FDJ.FilterBossLoot then
        boss = FDJ.FilterBossLootForPage(boss)
        FDJ.UpdateLootFilterNote(frame)
    end

    local isStockade = FDJ.ShowsItemsTBD(selectedDungeon)
    -- "Full Items Data TBD" stays under the dungeon title; the boss loot page
    -- shows its own copy for dungeons with no loot data yet, and for any boss
    -- of a TBD dungeon that has no loot listed (before the loot filter).
    local rawBoss = dungeon.bosses[selectedBoss]
    local bossHasLoot = rawBoss and rawBoss.loot and #rawBoss.loot > 0
    local lootTBD = isStockade and (not (dungeon and dungeon.fullItemsTBD) or not bossHasLoot)
    if frame.stockadeItemsTBD then
        frame.stockadeItemsTBD:SetText(FDJ.ItemsTBDText(selectedDungeon))
        frame.stockadeItemsTBD:SetShown(isStockade)
    end
    if frame.stockadeLootTBD then
        frame.stockadeLootTBD:SetText(FDJ.ItemsTBDText(selectedDungeon))
        frame.stockadeLootTBD:SetShown(lootTBD)
    end

    frame.selectedBossName:SetText(BossName(boss.name))
    if frame.selectedBossRareBorder then
        frame.selectedBossRareBorder:SetShown(boss.rare == true)
    end
    if frame.selectedBossType then
        if boss.fdjDungeon then
            frame.selectedBossType:SetText(DungeonName(boss.fdjDungeon))
            frame.selectedBossType:Show()
        elseif boss.recipeTab then
            frame.selectedBossType:SetText("")
            frame.selectedBossType:Hide()
        elseif boss.trash then
            frame.selectedBossType:SetText(L("UNIQUE_TRASH"))
            frame.selectedBossType:Show()
        else
            frame.selectedBossType:SetText("")
            frame.selectedBossType:Hide()
        end
    end

    if FDJ.UpdateBossSummon then pcall(FDJ.UpdateBossSummon, frame, boss) end

    local hasPortrait = SetBossPortrait(
        frame.selectedBossPortrait,
        selectedDungeon,
        boss
    )
    frame.selectedBossQuestion:SetShown(not hasPortrait)

    local bossLevel = BossLevelText(selectedDungeon, boss)
    if frame.selectedBossLevelBadge and frame.selectedBossLevelText then
        if bossLevel then
            frame.selectedBossLevelText:SetText(bossLevel)
            FitBossLevelText(frame.selectedBossLevelText, bossLevel)
            frame.selectedBossLevelBadge:Show()
            frame.selectedBossLevelText:Show()
        else
            frame.selectedBossLevelBadge:Hide()
            frame.selectedBossLevelText:Hide()
        end
    end

    frame.selectedBossDescription:SetText("")
    frame.selectedBossDescription:Hide()
    if boss.fdjRPGHint then -- rpgpartial: how to reveal this boss
        frame.selectedBossDescription:SetText(boss.fdjRPGHint)
        frame.selectedBossDescription:Show()
    end
    frame.lootTitle:SetText("")
    frame.lootTitle:Hide()
    frame.lootScroll:ClearAllPoints()
    frame.lootScroll:SetPoint("TOPLEFT", 12, lootTBD and -124 or -102)
    frame.lootScroll:SetPoint("BOTTOMRIGHT", -29, 11)

    -- The rows shown: the boss's (filtered) loot, then - when this boss has
    -- shared loot and the "Show Shared Loot" divider is open - those items.
    local loot = {}
    for _, item in ipairs(boss.loot) do loot[#loot + 1] = item end
    local ownCount = #loot
    local sharedList = FDJ.GetBossSharedLoot and FDJ.GetBossSharedLoot(selectedDungeon, boss) or nil
    local sharedCount = sharedList and #sharedList or 0
    if sharedCount > 0 and FDJ.lootSharedExpanded then
        for _, item in ipairs(sharedList) do loot[#loot + 1] = item end
    end
    -- probableloot: then, under "Not confirmed, but probable drop" (open),
    -- the items very likely from this boss that nobody has seen drop yet.
    local sharedEnd = #loot
    local probableList = type(boss.probableLoot) == "table" and boss.probableLoot or nil
    local probableCount = probableList and #probableList or 0
    if probableCount > 0 and FDJ.lootProbableExpanded then
        for _, item in ipairs(probableList) do loot[#loot + 1] = item end
    end

    -- Sections, top to bottom: gear, "Recipes & Patterns" (when split off),
    -- "Shared Loot" (when the boss has any). Each divider line sits between.
    local ROW_STEP, LINE_STEP, COL_GAP, SINGLE_WIDTH = 59, 31, 8, 388
    local recipeSplit = FDJ.lootRecipeSplit
    local sections = {}
    sections[#sections + 1] = { first = 1, last = recipeSplit or ownCount }
    if recipeSplit then sections[#sections + 1] = { line = "recipe", first = recipeSplit + 1, last = ownCount } end
    if sharedCount > 0 then sections[#sections + 1] = { line = "shared", first = ownCount + 1, last = sharedEnd } end
    if probableCount > 0 then sections[#sections + 1] = { line = "probable", first = sharedEnd + 1, last = #loot } end

    -- One column normally. When the list would need scrolling, use two
    -- columns (items read left, right, next line) so far less scrolling is
    -- needed. Pages whose rows carry trash-mob portraits stay one column,
    -- because the portraits need the full row width.
    local function HasMobPortraits()
        if not boss.trash or not FDJ.TRASH_MOB_DISPLAY_IDS then return false end
        for _, item in ipairs(loot) do
            local source = item[5]
            if type(source) == "string" and source ~= "" then
                local all, any = true, false
                for name in (source .. " / "):gmatch("(.-) / ") do
                    name = name:gsub("^%s+", ""):gsub("%s+$", "")
                    if name ~= "" then
                        any = true
                        if not FDJ.TRASH_MOB_DISPLAY_IDS[name] then all = false end
                    end
                end
                if any and all then return true end
            end
        end
        return false
    end
    -- Compact view: offered when even the two-column layout would need
    -- scrolling. Smaller rows with the item name only (like AtlasLoot),
    -- toggled with the button on the "N items" line and remembered.
    do
        local vp = frame.lootScroll:GetHeight() or 0
        local many = false
        if vp > 0 and #loot > 1 and not HasMobPortraits() then
            local h = (#sections - 1) * LINE_STEP
            for _, sec in ipairs(sections) do h = h + math.ceil(math.max(0, sec.last - sec.first + 1) / 2) * ROW_STEP end
            many = h > vp + 4
        end
        FDJ.lootManyItems = many
        FDJ.lootCompact = many and ForeverDungeonJournalDB and ForeverDungeonJournalDB.compactLoot == true or false
        if FDJ.lootCompact then ROW_STEP = 31 end
    end
    local singleHeight = #loot * ROW_STEP + (#sections - 1) * LINE_STEP
    local viewport = frame.lootScroll:GetHeight() or 0
    local twoColumns = viewport > 0 and singleHeight > viewport + 4 and #loot > 1 and not HasMobPortraits()
    local availableWidth = math.max(SINGLE_WIDTH, math.floor(frame.lootScroll:GetWidth() or SINGLE_WIDTH))
    local rowWidth = twoColumns and math.floor((availableWidth - COL_GAP) / 2) or SINGLE_WIDTH
    frame.lootContent:SetWidth(twoColumns and availableWidth or SINGLE_WIDTH)
    FDJ.lootTwoColumns = twoColumns

    local rowPos, lineY = {}, {}
    local cursorY = 0
    for _, section in ipairs(sections) do
        if section.line then
            lineY[section.line] = cursorY
            cursorY = cursorY + LINE_STEP
        end
        local count = math.max(0, section.last - section.first + 1)
        for k = 0, count - 1 do
            if twoColumns then
                rowPos[section.first + k] = { (k % 2) * (rowWidth + COL_GAP), cursorY + math.floor(k / 2) * ROW_STEP }
            else
                rowPos[section.first + k] = { 0, cursorY + k * ROW_STEP }
            end
        end
        cursorY = cursorY + (twoColumns and math.ceil(count / 2) or count) * ROW_STEP
    end
    local layoutHeight = cursorY

    for i = 1, math.max(#lootRows, #loot) do
        local row = lootRows[i]

        if i <= #loot then
            if not row then
                row = MakeLootRow(frame.lootContent)
                lootRows[i] = row

            end
            -- Rows are placed by offset so the recipe divider can sit between
            -- the gear rows and the recipe rows.
            row:ClearAllPoints()
            local rowX, rowY = rowPos[i][1], rowPos[i][2]
            row:SetWidth(rowWidth)
            row:SetPoint("TOPLEFT", frame.lootContent, "TOPLEFT", rowX, -rowY)
            do
                local compact = FDJ.lootCompact
                row:SetHeight(compact and 28 or 52)
                row.icon:SetSize(compact and 22 or 38, compact and 22 or 38)
                row.icon:ClearAllPoints()
                row.icon:SetPoint("LEFT", compact and 5 or 10, 0)
                row.name:ClearAllPoints()
                if compact then
                    row.name:SetPoint("LEFT", row.icon, "RIGHT", 7, 0)
                else
                    row.name:SetPoint("TOPLEFT", row.icon, "TOPRIGHT", 10, -4)
                end
                row.name:SetFontObject(compact and "GameFontNormalSmall" or "GameFontNormal")
                row.slot:SetShown(not compact)
            end

            local item = loot[i]
            row.item = item
            row.fdjDungeonName = selectedDungeon
            row.fdjBossName = boss.name
            row.icon:SetTexture(ItemIcon(item[1]))
            if FDJ.UpdateFavouriteIndicator then FDJ.UpdateFavouriteIndicator(row, item[1]) end
            -- Shared loot is marked on the item-type line (see below), so the
            -- old right-hand label is no longer used.
            if row.sharedText then row.sharedText:Hide() end
            if C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
                pcall(C_Item.RequestLoadItemDataByID, item[1])
            end

            local itemName, itemLink, quality = ItemInfo(item[1])

            local r, g, b
            if item[3] == "Quest Item" or item[4] == 1 then
                -- Quest objectives should read as normal/white here, even if
                -- the beta's item cache currently flags the object as Rare.
                r, g, b = 1, 1, 1
            else
                r, g, b = GetAuthoritativeItemQuality(item[1], itemLink, quality, item[4])
            end

            row.name:SetText(itemName or item[2])
            row.name:SetTextColor(r, g, b)

            local trashSource = boss.trash and item[5]
            local showTrashSource = false
            if type(trashSource) == "string" and trashSource ~= "" then
                local sourceLower = string.lower(trashSource)
                -- Only surface a source when it gives the player actionable
                -- information (for example "Druid of the Fang" or
                -- "Defias Overseer / Defias Taskmaster"). Generic labels such
                -- as "Shadowfang Keep trash" / "zone drop" are redundant.
                if not string.find(sourceLower, "zone drop", 1, true)
                    and not string.find(sourceLower, " trash", 1, true)
                    and sourceLower ~= "trash" then
                    showTrashSource = true
                end
            end

            if showTrashSource then
                row.slot:SetText(ItemSlot(item[3]) .. "  |  " .. FreeText(trashSource))
                row.fdjSourceText = L("DROPS_FROM", FreeText(trashSource))
            else
                row.slot:SetText(ItemSlot(item[3]))
                row.fdjSourceText = nil
            end
            -- Named trash mobs are shown as hoverable portraits instead of text.
            if FDJ.SetRowMobs and FDJ.SetRowMobs(row, showTrashSource and trashSource or nil) then
                row.slot:SetText(ItemSlot(item[3]))
            end

            -- Keep the name and type clear of the trash mob portraits.
            do
                local inset = -10
                local mobs = 0
                for _, button in ipairs(row.fdjMobButtons or {}) do
                    if button:IsShown() then mobs = mobs + 1 end
                end
                if mobs > 0 then inset = math.min(inset, -(14 + mobs * 38)) end
                row.name:SetPoint("RIGHT", inset, 0)
                row.slot:SetPoint("RIGHT", inset, 0)
            end

            local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]
            row:SetBackdropColor(unpack(theme.lootRow))
            row:SetBackdropBorderColor(unpack(theme.border))
            row.slot:SetTextColor(unpack(theme.muted))
            -- Items the Loot Filter rules out stay listed but blacked out.
            local dimmed = FDJ.lootFilterDimmed and FDJ.lootFilterDimmed[item]
            row:SetAlpha(dimmed and 0.28 or 1)
            if row.icon.SetDesaturated then row.icon:SetDesaturated(dimmed and true or false) end
            row:Show()
        elseif row then
            row.item = nil
            row.fdjDungeonName = nil
            row.fdjBossName = nil
            row.fdjSourceText = nil
            if row.fdjFavouriteStar then row.fdjFavouriteStar:Hide() end
            row:Hide()
            if FDJ.SetRowMobs then FDJ.SetRowMobs(row, nil) end
        end
    end

    -- Recipe section divider ("Recipes & Patterns (N)"): sits after the gear
    -- rows; clicking it folds / unfolds the recipe rows below it.
    local recipeLineHeight = 0
    do
        local split = FDJ.lootRecipeSplit
        local line = frame.lootRecipeLine
        if split and not line then
            line = CreateFrame("Button", nil, frame.lootContent)
            frame.lootRecipeLine = line
            line:SetHeight(24)
            line.rule = line:CreateTexture(nil, "BACKGROUND")
            line.rule:SetHeight(1)
            line.rule:SetPoint("BOTTOMLEFT", 0, 0)
            line.rule:SetPoint("BOTTOMRIGHT", 0, 0)
            line.rule:SetColorTexture(0.48, 0.40, 0.27, 0.6)
            line.icon = line:CreateTexture(nil, "ARTWORK")
            line.icon:SetSize(16, 16)
            line.icon:SetPoint("LEFT", 4, 0)
            line.text = line:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            line.text:SetPoint("LEFT", line.icon, "RIGHT", 6, 0)
            line.text:SetJustifyH("LEFT")
            line:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
            line:SetScript("OnClick", function()
                FDJ.lootRecipesExpanded = not FDJ.lootRecipesExpanded
                RefreshLoot()
            end)
        end
        if line then
            if split then
                line.text:SetText(L("RECIPES_SECTION", FDJ.lootRecipeCount or 0))
                line.icon:SetTexture(FDJ.lootRecipesExpanded and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
                line:ClearAllPoints()
                line:SetPoint("TOPLEFT", frame.lootContent, "TOPLEFT", 0, -(lineY.recipe or 0))
                line:SetPoint("RIGHT", frame.lootContent, "RIGHT", 0, 0)
                line:Show()
                recipeLineHeight = 31
            else
                line:Hide()
            end
        end
    end

    -- "Show Shared Loot (N)" divider: only for bosses with shared loot.
    -- Folded by default; clicking it shows / hides those items below.
    do
        local line = frame.lootSharedLine
        if sharedCount > 0 and not line then
            line = CreateFrame("Button", nil, frame.lootContent)
            frame.lootSharedLine = line
            line:SetHeight(24)
            line.rule = line:CreateTexture(nil, "BACKGROUND")
            line.rule:SetHeight(1)
            line.rule:SetPoint("BOTTOMLEFT", 0, 0)
            line.rule:SetPoint("BOTTOMRIGHT", 0, 0)
            line.rule:SetColorTexture(0.48, 0.40, 0.27, 0.6)
            line.icon = line:CreateTexture(nil, "ARTWORK")
            line.icon:SetSize(16, 16)
            line.icon:SetPoint("LEFT", 4, 0)
            line.text = line:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            line.text:SetPoint("LEFT", line.icon, "RIGHT", 6, 0)
            line.text:SetJustifyH("LEFT")
            line.note = line:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            line.note:SetPoint("LEFT", line.text, "RIGHT", 8, 0)
            line.note:SetTextColor(0.68, 0.62, 0.52)
            line:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
            line:SetScript("OnClick", function()
                FDJ.lootSharedExpanded = not FDJ.lootSharedExpanded
                RefreshLoot()
            end)
        end
        if line then
            if sharedCount > 0 then
                local open = FDJ.lootSharedExpanded and true or false
                line.text:SetText(L(open and "SHARED_HIDE" or "SHARED_SHOW", sharedCount))
                line.note:SetText(L("SHARED_NOTE"))
                line.icon:SetTexture(open and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
                line:ClearAllPoints()
                line:SetPoint("TOPLEFT", frame.lootContent, "TOPLEFT", 0, -(lineY.shared or 0))
                line:SetPoint("RIGHT", frame.lootContent, "RIGHT", 0, 0)
                line:Show()
            else
                line:Hide()
            end
        end
    end

    -- probableloot: the "Not confirmed, but probable drop (N)" divider, as
    -- Shared Loot's: folded by default, a click shows / hides the items.
    do
        local line = frame.lootProbableLine
        if probableCount > 0 and not line then
            line = CreateFrame("Button", nil, frame.lootContent)
            frame.lootProbableLine = line
            line:SetHeight(24)
            line.rule = line:CreateTexture(nil, "BACKGROUND")
            line.rule:SetHeight(1)
            line.rule:SetPoint("BOTTOMLEFT", 0, 0)
            line.rule:SetPoint("BOTTOMRIGHT", 0, 0)
            line.rule:SetColorTexture(0.48, 0.40, 0.27, 0.6)
            line.icon = line:CreateTexture(nil, "ARTWORK")
            line.icon:SetSize(16, 16)
            line.icon:SetPoint("LEFT", 4, 0)
            line.text = line:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            line.text:SetPoint("LEFT", line.icon, "RIGHT", 6, 0)
            line.text:SetJustifyH("LEFT")
            line:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
            line:SetScript("OnClick", function()
                FDJ.lootProbableExpanded = not FDJ.lootProbableExpanded
                RefreshLoot()
            end)
        end
        if line then
            if probableCount > 0 then
                local open = FDJ.lootProbableExpanded and true or false
                line.text:SetText(L("PROBABLE_LOOT", probableCount))
                line.icon:SetTexture(open and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
                line:ClearAllPoints()
                line:SetPoint("TOPLEFT", frame.lootContent, "TOPLEFT", 0, -(lineY.probable or 0))
                line:SetPoint("RIGHT", frame.lootContent, "RIGHT", 0, 0)
                line:Show()
            else
                line:Hide()
            end
        end
    end

    local contentHeight = math.max(1, layoutHeight)
    frame.lootContent:SetHeight(contentHeight)
    local viewportHeight = frame.lootScroll:GetHeight() or 0
    local needsScroll = viewportHeight > 0 and contentHeight > viewportHeight + 4
    -- Compact / detailed toggle on the "N items" line.
    if FDJ.lootManyItems and not frame.lootCompactButton then
        local b = CreateFrame("Button", nil, frame.lootTitle:GetParent(), "BackdropTemplate")
        frame.lootCompactButton = b
        b:SetSize(104, 20)
        SetBackdrop(b, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 9, 2)
        b:SetBackdropColor(0.12, 0.10, 0.08, 0.95)
        b:SetBackdropBorderColor(0.52, 0.33, 0.11, 1)
        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        b.text:SetPoint("CENTER")
        b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
        b:SetScript("OnClick", function()
            ForeverDungeonJournalDB.compactLoot = not ForeverDungeonJournalDB.compactLoot or nil
            PlayJournalOptionSound()
            RefreshLoot()
        end)
        b:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L(ForeverDungeonJournalDB.compactLoot and "LOOT_DETAILED_TIP" or "LOOT_COMPACT_TIP"), 1, 1, 1, true)
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    if frame.lootCompactButton then
        frame.lootCompactButton:SetShown(FDJ.lootManyItems and true or false)
        frame.lootCompactButton.text:SetText(L(FDJ.lootCompact and "LOOT_DETAILED" or "LOOT_COMPACT"))
        frame.lootCompactButton:ClearAllPoints()
        frame.lootCompactButton:SetPoint("TOPRIGHT", frame.lootTitle:GetParent(), "TOPRIGHT", -30, lootTBD and -120 or -98)
    end
    if needsScroll or FDJ.lootManyItems then
        frame.lootTitle:SetText(tostring(#boss.loot) .. " " .. L("ITEMS"))
        frame.lootTitle:ClearAllPoints()
        frame.lootTitle:SetPoint("TOPLEFT", 14, lootTBD and -124 or -102)
        frame.lootTitle:Show()
        frame.lootScroll:ClearAllPoints()
        frame.lootScroll:SetPoint("TOPLEFT", 12, lootTBD and -146 or -124)
        frame.lootScroll:SetPoint("BOTTOMRIGHT", -29, 11)
    else
        frame.lootTitle:SetText("")
        frame.lootTitle:ClearAllPoints()
        frame.lootTitle:SetPoint("TOPLEFT", 14, -102)
        frame.lootTitle:Hide()
    end
    UpdateScrollBarVisibility(frame.lootScroll, contentHeight)

    -- Item names/slot text can arrive asynchronously after GET_ITEM_INFO_RECEIVED.
    -- Re-evaluate fonts after the row text is populated so CJK strings never
    -- fall back to the western client font and render as squares.
    ApplyLocaleFontTree(frame.lootContent)
end

local function ApplyTheme()
    if not frame then return end

    local theme = THEMES[selectedDungeon] or THEMES["Hall of Thanes"]

    frame:SetBackdropColor(unpack(theme.frame))
    frame.contentPanel:SetBackdropColor(unpack(theme.content))
    frame.contentPanel:SetBackdropBorderColor(unpack(theme.border))
    frame.headerPanel:SetBackdropColor(unpack(theme.header))
    frame.leftPanel:SetBackdropColor(unpack(theme.left))
    frame.rightPanel:SetBackdropColor(unpack(theme.right))

    if frame.homePanel then
        frame.homePanel:SetBackdropColor(0.16, 0.12, 0.07, 0.96)
        frame.homePanel:SetBackdropBorderColor(0.47, 0.34, 0.16, 1)
    end
    if frame.homeParchment then
        frame.homeParchment:SetVertexColor(1.00, 0.95, 0.84)
        frame.homeParchment:SetAlpha(0.18)
    end
    if frame.contentParchment then
        frame.contentParchment:SetVertexColor(1.00, 0.95, 0.84)
        frame.contentParchment:SetAlpha(0.18)
    end
    if frame.headerParchment then frame.headerParchment:SetAlpha(0.16) end
    if frame.leftParchment then frame.leftParchment:SetAlpha(0.13) end
    if frame.rightParchment then frame.rightParchment:SetAlpha(0.13) end
    if frame.questLeftParchment then frame.questLeftParchment:SetAlpha(0.13) end
    if frame.questRightParchment then frame.questRightParchment:SetAlpha(0.10) end

    if frame.questLeftPanel then
        frame.questLeftPanel:SetBackdropColor(unpack(theme.left))
        frame.questLeftPanel:SetBackdropBorderColor(unpack(theme.border))
    end
    if frame.questRightPanel then
        frame.questRightPanel:SetBackdropColor(unpack(theme.right))
        frame.questRightPanel:SetBackdropBorderColor(unpack(theme.border))
    end

    frame.dungeonTitle:SetTextColor(unpack(theme.title))
    frame.dungeonMeta:SetTextColor(unpack(theme.muted))

    frame.selectedBossName:SetTextColor(unpack(theme.text))
    frame.selectedBossDescription:SetTextColor(unpack(theme.text))
    frame.lootTitle:SetTextColor(unpack(theme.text))
    if frame.bossListTitle then frame.bossListTitle:SetTextColor(unpack(theme.text)) end
    if frame.questListTitle then frame.questListTitle:SetTextColor(unpack(theme.text)) end

    local ruins = selectedDungeon == "Ruins of Lordaeron"
    local hall = selectedDungeon == "Hall of Thanes"
    local bfd = selectedDungeon == "Blackfathom Deeps"

    if frame.dungeonBackgroundArt then
        local bg = DUNGEON_PAGE_ART[selectedDungeon]
        local crop = DUNGEON_PAGE_TEXCOORD[selectedDungeon] or { 0.03, 0.97, 0.05, 0.95 }
        if bg then
            frame.dungeonBackgroundArt:SetTexture(bg)
            frame.dungeonBackgroundArt:SetTexCoord(crop[1], crop[2], crop[3], crop[4])
            frame.dungeonBackgroundArt:SetAlpha(0.16)
            frame.dungeonBackgroundArt:Show()
        else
            frame.dungeonBackgroundArt:Hide()
        end
    end

    if frame.questInsetEdges then
        for _, edge in ipairs(frame.questInsetEdges) do
            edge:SetColorTexture(0.36, 0.23, 0.09, 0.98)
        end
    end

    if frame.questTextInset then
        frame.questTextInset:SetBackdropColor(0.70, 0.58, 0.39, 1.00)
        frame.questTextInset:SetBackdropBorderColor(0.36, 0.23, 0.09, 1)

        if frame.questParchment then
            frame.questParchment:SetVertexColor(1.00, 0.96, 0.84, 1.00)
            frame.questParchment:SetAlpha(1)
        end

        frame.selectedQuestName:SetTextColor(1.00, 0.78, 0.16)
        frame.selectedQuestMeta:SetTextColor(0.25, 0.16, 0.08)
        frame.questDetailText:SetTextColor(0.10, 0.065, 0.025)
        if frame.questTurninText then frame.questTurninText:SetTextColor(0.10, 0.065, 0.025) end
        frame.questRewardSummary:SetTextColor(0.10, 0.065, 0.025)
    end

    if frame.atmosphere then
        if ruins then
            frame.atmosphere:SetColorTexture(0.06, 0.08, 0.05, 0.05)
        elseif bfd then
            frame.atmosphere:SetColorTexture(0.04, 0.07, 0.08, 0.05)
        else
            frame.atmosphere:SetColorTexture(0.10, 0.07, 0.03, 0.04)
        end
    end

    if frame.mistTop then
        frame.mistTop:SetShown(false)
    end

    for _, tab in pairs(dungeonTabs) do
        if tab then
            tab:SetBackdropBorderColor(unpack(theme.border))
        end
    end

    UpdateModeTabs()
    UpdateFactionButtons()
end

ApplyLocalization = function()
    if not frame then return end

    UpdateLanguageControl()
    if frame.mainTitle then frame.mainTitle:SetText(L("DUNGEON_JOURNAL")) end
    if frame.UpdateSearchPlaceholder then frame.UpdateSearchPlaceholder() end
    if frame.RefreshSearchResults and frame.searchEditBox and (frame.searchEditBox:GetText() or "") ~= "" then
        frame.RefreshSearchResults(frame.searchEditBox:GetText())
    end
    if frame.backButton then frame.backButton:SetText(L("DUNGEONS")) end
    if frame.sourceLabel then frame.sourceLabel:SetText(L("FOREVER_BETA_DATA")) end
    if frame.dungeonRouteButton then frame.dungeonRouteButton:SetText(L("ROUTE")) end
    if frame.routeBackButton then frame.routeBackButton:SetText(L("BACK_TO_DUNGEON")) end
    if frame.routeMapButton then frame.routeMapButton:SetText(L("SHOW_ON_MAP")) end
    if frame.homeTitle then frame.homeTitle:SetText(L("BROWSE_DUNGEONS")) end
    if frame.homeSubtitle then frame.homeSubtitle:SetText(L("HOME_SUBTITLE")) end
    if FDJ.RelocalizeLootFilter then FDJ.RelocalizeLootFilter(frame) end
    if frame.hideDungeonsButton and frame.hideDungeonsButtonText then
        local label = homeEditMode and L("DONE") or L("HIDE_DUNGEONS")
        frame.hideDungeonsButtonText:SetText(label)
        if frame.hideDungeonsButtonText then
            frame.hideDungeonsButtonText:ClearAllPoints()
            frame.hideDungeonsButtonText:SetPoint("CENTER", homeEditMode and -8 or 0, 0)
        end
        if frame.hideDungeonsDoneCheck then
            frame.hideDungeonsDoneCheck:SetShown(homeEditMode)
        end
        local extra = homeEditMode and 44 or 26
        local width = math.max(126, math.min(180, math.ceil((frame.hideDungeonsButtonText:GetStringWidth() or 100) + extra)))
        frame.hideDungeonsButton:SetWidth(width)
    end
    if frame.bossesTab then frame.bossesTab:SetText(L("BOSSES")) end
    if frame.questsTab then frame.questsTab:SetText(L("QUESTS")) end
    if frame.mapTab then frame.mapTab:SetText(L("MAP")) end
    if frame.bossListTitle then frame.bossListTitle:SetText(L("BOSSES")) end
    if frame.questListTitle then frame.questListTitle:SetText(L("QUESTS")) end
    if frame.questObjectiveHeader then frame.questObjectiveHeader:SetText(L("OBJECTIVE")) end
    if frame.questDescHeader then frame.questDescHeader:SetText(L("DESCRIPTION")) end
    if frame.questRequiredItemsHeader then frame.questRequiredItemsHeader:SetText(L("REQUIRED_ITEMS")) end
    if frame.questProvidedItemHeader then frame.questProvidedItemHeader:SetText(L("PROVIDED_ITEM")) end
    if frame.questStartsHeader then frame.questStartsHeader:SetText(L("STARTS_AT")) end
    if frame.questTurninHeader then frame.questTurninHeader:SetText(L("TURN_IN")) end
    if frame.questNotesHeader then frame.questNotesHeader:SetText(L("NOTES")) end
    if frame.questShareButton and frame.questShareButton.questID then
        FDJ.UpdateQuestShareButton(frame.questShareButton.questID, frame.questShareButton._fdjClassLabel)
    end
    UpdateQuestActionButtonSizes()
    if frame.questRewardSummary then ApplyRewardSummaryFont(frame.questRewardSummary) end
    if frame.questRewardHeader and frame.questRewardHeader:GetText() ~= "" then
        frame.questRewardHeader:SetText(L("REWARDS"):upper())
    end

    -- Existing pooled rows/buttons may have been created under the previous
    -- language, so update their static labels as well.
    for _, button in ipairs(questButtons) do
        if button and button.UpdateHaveItLabel then
            button:UpdateHaveItLabel()
        elseif button and button.haveIt then
            button.haveIt:SetText(L("YOU_HAVE_IT"))
        end
    end
    for _, button in ipairs(bossButtons) do
        if button and button.rare then button.rare:SetText(L("RARE")) end
    end
end

ShowDungeonPage = function()
    if not frame then return end
    if frame.homePanel then frame.homePanel:Hide() end
    if frame.contentPanel then frame.contentPanel:Show() end
    if frame.backButton then frame.backButton:Show() end
    frame.currentView = "dungeon"
    ForeverDungeonJournalDB.lastView = "dungeon"
end

ShowHomePage = function()
    if not frame then return end
    if frame.contentPanel then frame.contentPanel:Hide() end
    if frame.homePanel then frame.homePanel:Show() end
    if frame.backButton then frame.backButton:Hide() end
    frame.currentView = "home"
    ForeverDungeonJournalDB.lastView = "home"
    RefreshHomeDungeonCards()
end

RefreshAll = function()
    ApplyLocalization()
    local dungeon = DB[selectedDungeon]

    ApplyTheme()

    frame.dungeonTitle:SetText(dungeon.recipeSearchTitle or DungeonName(selectedDungeon))
    -- "Matching loot" has no level line: larger title, centred in the header box.
    do
        local t = frame.dungeonTitle
        if not t.fdjFont then t.fdjFont = { t:GetFont() } end
        local font, size, flags = t.fdjFont[1], t.fdjFont[2], t.fdjFont[3]
        t:ClearAllPoints()
        if dungeon.lootFilterPage and font then
            t:SetFont(font, (size or 20) + 6, flags)
            t:SetPoint("LEFT", t:GetParent(), "LEFT", 18, 0)
        else
            if font then t:SetFont(font, size, flags) end
            t:SetPoint("TOPLEFT", 15, -10)
        end
    end
    if dungeon.recipeSearch or not dungeon.level or dungeon.level == "" then
        frame.dungeonMeta:SetText("")
    else
        frame.dungeonMeta:SetText(FDJ.HomeLevelText(dungeon.level))
    end
    if frame.dungeonLocationButton then
        frame.dungeonLocationButton:SetShown(dungeon.entrance ~= nil)
    end
    if FDJ.UpdateLFGButton then FDJ.UpdateLFGButton(frame, selectedDungeon, dungeon) end
    if frame.dungeonRouteButton then
        local route = dungeon.routeGuide
        local playerFaction = UnitFactionGroup and UnitFactionGroup("player") or nil
        local allowed = route and (not route.faction or route.faction == playerFaction)
        frame.dungeonRouteButton:SetShown(allowed and true or false)
        if frame.dungeonRouteButton.icon then
            -- The Horde crest gets a thin black outline here so it stands out
            -- on the red button.
            local routeIcon = (route and route.faction == "Horde")
                and "Interface\\AddOns\\ForeverDungeonJournal\\Media\\HordeOutlined.tga" or ALLIANCE_ICON
            frame.dungeonRouteButton.icon:SetTexture(routeIcon)
        end
        if allowed then frame.dungeonRouteButton:SetText(L("ROUTE")) end
    end
    if frame.stockadeItemsTBD then
        frame.stockadeItemsTBD:SetText(FDJ.ItemsTBDText(selectedDungeon))
        frame.stockadeItemsTBD:SetShown(FDJ.ShowsItemsTBD(selectedDungeon))
    end

    UpdateDungeonHeaderTabs()
    UpdateTabs()

    local quests = dungeon.quests or {}
    if selectedQuest > #quests then selectedQuest = 1 end
    if selectedBoss > #dungeon.bosses then selectedBoss = 1 end

    if dungeon.previewOnly and FDJ.DUNGEON_MAPS[selectedDungeon] and ShowDungeonMap then
        ShowDungeonMap()
        return
    end
    -- sleepingbag: a quest chain page opens on its quests; the next
    -- dungeon opens on the tab used before it.
    if dungeon.questChainPage then
        if selectedMode ~= "quests" then FDJ.modeBeforeQuestChain = selectedMode end
        selectedMode = "quests"
    elseif FDJ.modeBeforeQuestChain then
        selectedMode = FDJ.modeBeforeQuestChain
        FDJ.modeBeforeQuestChain = nil
    end
    SetMode(selectedMode)
end

FDJ.GetSelectedDungeon = function() return selectedDungeon, selectedBoss end
-- Used by the world-map overlay: point the map renderer at a dungeon without
-- touching the journal window.
FDJ.SetMapDungeon = function(name) if DB[name] then selectedDungeon = name end end
FDJ.ReopenDungeonMap = function(dungeonName)
    if dungeonName == selectedDungeon and FDJ.DUNGEON_MAPS[dungeonName] then
        pcall(ShowDungeonMap)
    end
end

SelectBoss = function(index)
    local dungeon = DB[selectedDungeon]
    if not dungeon or not dungeon.bosses[index] then return end

    selectedBoss = index
    ForeverDungeonJournalDB.lastBoss = index

    -- Stay on the SAME page. Only refresh highlight + right-side loot pane.
    RefreshBossList()
    RefreshLoot()
end

SelectDungeon = function(name)
    if not DB[name] then return end
    if DB[name].previewOnly and not FDJ.DUNGEON_MAPS[name] then return end
    -- RPG Mode: a dungeon stays locked until its final boss has been defeated.
    if FDJ.IsDungeonLocked and FDJ.IsDungeonLocked(name) then
        if FDJ.RPGLockedNotice then FDJ.RPGLockedNotice(name) end
        if frame and frame:IsShown() and ShowHomePage and frame.currentView ~= "home" then ShowHomePage() end
        return
    end

    ShowDungeonPage()
    selectedDungeon = name
    selectedBoss = 1
    selectedQuest = 1

    local hasCurrentFaction = false
    local fallbackFaction = nil
    for _, q in ipairs(DB[name].quests or {}) do
        if QuestMatchesFaction(q, selectedQuestFaction) then
            hasCurrentFaction = true
            break
        end
        if q.faction == "Alliance" or q.faction == "Horde" then
            fallbackFaction = fallbackFaction or q.faction
        end
    end
    if not hasCurrentFaction and fallbackFaction then
        selectedQuestFaction = fallbackFaction
        ForeverDungeonJournalDB.questFaction = selectedQuestFaction
    end
    ForeverDungeonJournalDB.lastDungeon = name
    ForeverDungeonJournalDB.lastBoss = 1
    ForeverDungeonJournalDB.lastQuest = 1
    frame.questListScroll:SetVerticalScroll(0)
    frame.bossListScroll:SetVerticalScroll(0)

    RefreshAll()

    if FDJ.DUNGEON_MAPS[name] and #(DB[name].bosses or {}) == 0 and #(DB[name].quests or {}) == 0 then
        ShowDungeonMap()
    end
end


local function CreateGlobalSearchUI()
    -- ============================================================
    -- GLOBAL SEARCH
    -- ============================================================
    -- Search is deliberately available from every journal page. Results include
    -- dungeons and every item already recorded in boss loot or quest data.
    local searchBox = CreateFrame("EditBox", nil, frame, "BackdropTemplate")
    frame.searchEditBox = searchBox
    searchBox:SetSize(265, 26)
    searchBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -14)
    searchBox:SetAutoFocus(false)
    searchBox:SetMaxLetters(80)
    searchBox:SetFontObject("GameFontHighlightLarge")
    searchBox:SetTextInsets(27, 22, 0, 0)
    searchBox:SetJustifyH("LEFT")
    SetBackdrop(searchBox, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 10, 3)
    searchBox:SetBackdropColor(0.045, 0.043, 0.040, 0.98)
    searchBox:SetBackdropBorderColor(0.34, 0.31, 0.27, 1)

    local searchIcon = searchBox:CreateTexture(nil, "ARTWORK")
    searchIcon:SetSize(14, 14)
    searchIcon:SetPoint("LEFT", 7, 0)
    searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
    searchIcon:SetVertexColor(0.72, 0.70, 0.66)

    local searchPlaceholder = searchBox:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.searchPlaceholder = searchPlaceholder
    searchPlaceholder:SetPoint("LEFT", 28, 0)
    searchPlaceholder:SetTextColor(0.48, 0.47, 0.44)

    local searchClear = CreateFrame("Button", nil, searchBox)
    frame.searchClearButton = searchClear
    searchClear:SetSize(16, 16)
    searchClear:SetPoint("RIGHT", -5, 0)
    searchClear:SetNormalTexture("Interface\\Buttons\\UI-StopButton")
    searchClear:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    searchClear:Hide()

    local searchResults = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    frame.searchResultsFrame = searchResults
    searchResults:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", 0, -3)
    searchResults:SetSize(340, 40)
    searchResults:SetFrameStrata("TOOLTIP")
    searchResults:SetFrameLevel(frame:GetFrameLevel() + 60)
    SetBackdrop(searchResults, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 10, 3)
    searchResults:SetBackdropColor(0.045, 0.042, 0.037, 0.995)
    searchResults:SetBackdropBorderColor(0.48, 0.40, 0.27, 1)
    searchResults:Hide()

    local searchRows = {}
    local currentSearchResults = {}
    local searchResultOffset = 0
    local MAX_VISIBLE_SEARCH_RESULTS = 6
    local MAX_SEARCH_RESULTS = 80

    -- Common Classic dungeon shorthand plus aliases for the two Forever dungeons.
    -- Deadmines is commonly called both DM and VC; Stockade is commonly "Stocks".
    -- RoL is already in use for Ruins of Lordaeron. Hall of Thanes is new, so
    -- support both natural initialisms players are likely to type (HoT / HT).
    local DUNGEON_SEARCH_ALIASES = {
        ["Hall of Thanes"] = { "hot", "ht", "halls of thanes", "halls" },
        ["Ragefire Chasm"] = { "rfc" },
        ["Ruins of Lordaeron"] = { "rol", "rl" },
        ["The Deadmines"] = { "dm", "vc", "deadmines" },
        ["Wailing Caverns"] = { "wc" },
        ["Shadowfang Keep"] = { "sfk" },
        ["The Stockade"] = { "stocks", "stockades", "stockade", "sw stocks" },
        ["Blackfathom Deeps"] = { "bfd" },
        ["Gnomeregan"] = { "gnomer", "gnomergan" },
        ["Razorfen Kraul"] = { "rfk", "kraul" },
        ["City of Dalaran"] = { "dala", "dal", "dalaran" },
        ["Excavation Site: Wetlands"] = { "excavation", "exca", "wetlands" },
        ["Scarlet Monastery: Graveyard"] = { "smgy", "gy", "sm gy", "sm graveyard" },
        ["Scarlet Monastery: Library"] = { "smlib", "lib", "sm lib", "sm library" },
        ["Scarlet Monastery: Armory"] = { "smarm", "arm", "armory", "sm arm", "sm armory" },
        ["Scarlet Monastery: Cathedral"] = { "smcath", "cath", "cathedral", "sm cath", "sm cathedral" },
        ["Razorfen Downs"] = { "rfd", "downs" },
        ["Uldaman"] = { "ulda", "uld" },
        ["Zul'Farrak"] = { "zf", "zul", "zulfarrak", "zul farrak" },
        ["Sunken Temple"] = { "st", "sunken", "atal'hakkar", "temple of atal'hakkar" },
        ["Scholomance"] = { "scholo", "scholomance" },
        ["Maraudon"] = { "mara", "maraudon" },
        ["Blackrock Depths"] = { "brd", "depths", "blackrock depths" },
        ["Lower Blackrock Spire"] = { "lbrs", "lower blackrock", "lower spire", "blackrock spire" },
        ["Upper Blackrock Spire"] = { "ubrs", "upper blackrock", "upper spire" },
        ["Dire Maul: East"] = { "dme", "dm east", "dire maul east", "dmeast" },
        ["Dire Maul: West"] = { "dmw", "dm west", "dire maul west", "dmwest" },
        ["Dire Maul: North"] = { "dmn", "dm north", "dire maul north", "dmnorth", "tribute" },
        ["Stratholme: Living"] = { "strat", "strat live", "strat living", "stratlive" },
        ["Stratholme: Undead"] = { "strat ud", "strat undead", "stratud", "baron" },
    }

    -- Search speed: lower-cased strings, item names and filtered loot lists
    -- are cached, so each keystroke only does plain string matching.
    local searchLowerCache, searchLowerCount = {}, 0
    local searchNameCache = {}
    local searchLootCache = setmetatable({}, { __mode = "k" })
    local function SearchText(value)
        local raw = tostring(value or "")
        local cached = searchLowerCache[raw]
        if cached then return cached end
        local s = raw:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        s = string.lower(s)
        if searchLowerCount > 20000 then searchLowerCache, searchLowerCount = {}, 0 end
        searchLowerCache[raw] = s
        searchLowerCount = searchLowerCount + 1
        return s
    end
    local function SearchableLoot(boss)
        local list = searchLootCache[boss]
        if not list then
            list = (FDJ.SearchableBossLoot and FDJ.SearchableBossLoot(boss)) or boss.loot or {}
            searchLootCache[boss] = list
        end
        return list
    end
    FDJ.ResetSearchCache = function() searchLootCache = setmetatable({}, { __mode = "k" }) end

    local function SearchMatchScore(query, ...)
        local best
        for i = 1, select("#", ...) do
            local value = select(i, ...)
            if value and value ~= "" then
                local raw = tostring(value)
                local lowered = SearchText(raw)
                local pos = string.find(lowered, query, 1, true)
                -- string.lower is ASCII-only on this client. Also try the raw
                -- UTF-8 string so localized names remain searchable when typed
                -- with their displayed capitalization.
                if not pos then
                    pos = string.find(raw, query, 1, true)
                end
                if pos then
                    local score = (pos == 1 and 0 or (20 + pos)) + math.min(#raw, 80) * 0.001
                    if not best or score < best then best = score end
                end
            end
        end
        return best
    end

    local function SearchItemDisplayName(item)
        if not item then return "" end
        local id, fallback = item[1], item[2]
        local known = id and searchNameCache[id]
        if known then return known end
        local liveName = id and ItemInfo(id)
        if liveName and liveName ~= "" then
            searchNameCache[id] = liveName
            return liveName
        end
        return FreeText(fallback or "")
    end

    local function AddSearchCandidate(results, candidate, query, baseScore, ...)
        local score = SearchMatchScore(query, ...)
        if not score then return end
        candidate.score = score + (baseScore or 0)
        results[#results + 1] = candidate
    end

    -- Recipe search results show the profession and the profession-skill level
    -- required to learn the recipe (for example: "Tailoring (125)"). The
    -- profession comes from our static loot tuple; the numeric requirement is
    -- read from the live item tooltip so Forever-specific values stay accurate.
    FDJ.recipeSearchRequirementCache = FDJ.recipeSearchRequirementCache or {}
    FDJ.GetRecipeSearchRequirement = FDJ.GetRecipeSearchRequirement or function(itemID, slotText)
        itemID = tonumber(itemID)
        local profession = tostring(slotText or ""):match("[Rr]ecipe,%s*(.+)")
        if not profession or profession == "" then
            profession = tostring(slotText or ""):match("(.+)%s+[Rr]ecipe")
        end
        profession = profession and profession:gsub("^%s+", ""):gsub("%s+$", "") or ""

        if itemID and FDJ.recipeSearchRequirementCache[itemID] then
            local cached = FDJ.recipeSearchRequirementCache[itemID]
            if profession ~= "" and cached.skill then
                return profession .. " (" .. tostring(cached.skill) .. ")"
            end
            return profession ~= "" and profession or (cached.text or "")
        end

        local skill
        if itemID and C_TooltipInfo and type(C_TooltipInfo.GetItemByID) == "function" then
            local ok, data = pcall(C_TooltipInfo.GetItemByID, itemID)
            if ok and type(data) == "table" and type(data.lines) == "table" then
                -- Scan from the BOTTOM of the tooltip. Recipe material lines often
                -- contain counts such as "Bolt of Woolen Cloth (8)"; the actual
                -- profession requirement (for example "Requires Tailoring (75)")
                -- appears later in the tooltip, immediately above the sell price.
                -- Reading bottom-up prevents reagent counts from being mistaken
                -- for the profession skill requirement.
                for i = #data.lines, 1, -1 do
                    local line = data.lines[i]
                    local lineText = line and (line.leftText or line.text)
                    if type(lineText) == "string" then
                        local value = lineText:match("%((%d+)%)")
                        if value then
                            skill = tonumber(value)
                            break
                        end
                    end
                end
            end
        end

        -- Fallback for clients where C_TooltipInfo does not expose line text.
        if itemID and not skill and CreateFrame and UIParent then
            if not FDJ.recipeSearchScanTooltip then
                local ok, tip = pcall(CreateFrame, "GameTooltip", "ForeverDungeonJournalRecipeSearchTooltip", UIParent, "GameTooltipTemplate")
                if ok then FDJ.recipeSearchScanTooltip = tip end
            end
            local tip = FDJ.recipeSearchScanTooltip
            if tip then
                tip:Hide()
                tip:SetOwner(UIParent, "ANCHOR_NONE")
                if tip.ClearLines then tip:ClearLines() end
                local ok = pcall(tip.SetHyperlink, tip, "item:" .. tostring(itemID))
                if ok then
                    local count = (tip.NumLines and tip:NumLines()) or 0
                    -- Same bottom-up rule as above: the profession requirement
                    -- is below the recipe's reagent list, so the first parenthesized
                    -- number found from the bottom is the skill requirement rather
                    -- than a material quantity.
                    for i = count, 2, -1 do
                        local fs = _G["ForeverDungeonJournalRecipeSearchTooltipTextLeft" .. i]
                        local lineText = fs and fs.GetText and fs:GetText()
                        if type(lineText) == "string" then
                            local value = lineText:match("%((%d+)%)")
                            if value then
                                skill = tonumber(value)
                                break
                            end
                        end
                    end
                end
                tip:Hide()
            end
        end

        if itemID and skill then
            FDJ.recipeSearchRequirementCache[itemID] = { skill = skill }
        elseif itemID and C_Item and type(C_Item.RequestLoadItemDataByID) == "function" then
            pcall(C_Item.RequestLoadItemDataByID, itemID)
        end

        if profession ~= "" and skill then
            return profession .. " (" .. tostring(skill) .. ")"
        end
        return profession
    end

    -- rpgsearch: dungeons the search leaves out - locked pages, and in RPG
    -- Mode the "coming soon" ones too (blank pages there).
    local function SearchSkipsDungeon(dungeonName)
        if FDJ.IsDungeonLocked and FDJ.IsDungeonLocked(dungeonName) then return true end
        local dungeon = DB[dungeonName]
        return (dungeon and dungeon.previewOnly and FDJ.IsRPGMode and FDJ.IsRPGMode()) and true or false
    end

    local function BuildSearchResults(queryText)
        local query = SearchText(queryText):gsub("^%s+", ""):gsub("%s+$", "")
        local results = {}
        -- Recipe tabs repeat the same pattern/plan in every dungeon where it
        -- can drop. Search presents each recipe only once; clicking that one
        -- result opens a hidden source page containing every boss that drops it.
        local recipeCandidates = {}

        -- Clicking an empty search box acts as a dungeon browser. Keep the
        -- journal's normal dungeon order and let the dropdown scroll if needed.
        if query == "" then
            for _, dungeonName in ipairs(ORDER or {}) do
                local dungeon = DB[dungeonName]
                if dungeon and not SearchSkipsDungeon(dungeonName) then
                    results[#results + 1] = {
                        kind = "dungeon",
                        dungeonName = dungeonName,
                        displayName = DungeonName(dungeonName),
                        subText = DungeonField(dungeonName, "location", dungeon.location or ""),
                        icon = DUNGEON_HOME_ART[dungeonName] or dungeon.icon,
                        texCoord = DUNGEON_HOME_TEXCOORD[dungeonName],
                        score = 0,
                    }
                end
            end
            return results
        end

        -- One letter only matches dungeon names; items and quests need two.
        for _, dungeonName in ipairs(ORDER or {}) do
            local dungeon = DB[dungeonName]
            if dungeon and not SearchSkipsDungeon(dungeonName) then
                local localizedDungeon = DungeonName(dungeonName)
                local aliases = DUNGEON_SEARCH_ALIASES[dungeonName]
                local aliasText = aliases and table.concat(aliases, " ") or ""
                AddSearchCandidate(results, {
                    kind = "dungeon",
                    dungeonName = dungeonName,
                    displayName = localizedDungeon,
                    subText = DungeonField(dungeonName, "location", dungeon.location or ""),
                    icon = DUNGEON_HOME_ART[dungeonName] or dungeon.icon,
                    texCoord = DUNGEON_HOME_TEXCOORD[dungeonName],
                }, query, -30, localizedDungeon, dungeonName, aliasText)

                for bossIndex, boss in ipairs((#query >= 2) and dungeon.bosses or {}) do
                    -- Search follows the Loot Filter: hidden items are not offered
                    -- (blueprints are always shown on boss pages, so always offered).
                    for _, item in ipairs(SearchableLoot(boss)) do
                        local itemName = SearchItemDisplayName(item)
                        -- Match first; build the result (icon, tooltip-read
                        -- recipe skill, labels) only for items that match.
                        local matchScore = SearchMatchScore(query, itemName, item[2])
                        if not matchScore then
                            -- no match: nothing to build
                        elseif boss.recipeTab then
                            -- The Recipes & Patterns pseudo-boss exists once per
                            -- dungeon. Collapse those repeated rows into one global
                            -- search result per actual recipe item.
                            local recipeID = tonumber(item[1])
                            if recipeID and not recipeCandidates[recipeID] then
                                recipeCandidates[recipeID] = true
                                results[#results + 1] = {
                                    kind = "item",
                                    mode = "recipe",
                                    dungeonName = dungeonName,
                                    itemID = recipeID,
                                    displayName = itemName,
                                    subText = FDJ.GetRecipeSearchRequirement(recipeID, item[3]),
                                    icon = ItemIcon(recipeID),
                                    score = matchScore,
                                }
                            end
                        else
                            results[#results + 1] = {
                                score = matchScore,
                                kind = "item",
                                mode = "bosses",
                                dungeonName = dungeonName,
                                bossIndex = bossIndex,
                                itemID = item[1],
                                displayName = itemName,
                                subText = localizedDungeon .. "  -  " .. BossName(boss.name),
                                -- Boss-loot tuple field 5 is optional source/mob text,
                                -- not an icon path. Always resolve the search icon from
                                -- the actual item ID so trash drops never try to use
                                -- strings such as "Defias Strip Miner" as textures.
                                icon = ItemIcon(item[1]),
                            }
                        end
                    end
                end

                for questIndex, quest in ipairs((#query >= 2) and dungeon.quests or {}) do
                    local questName = QuestField(quest.id, "name", quest.name or "")

                    local questItems = {}
                    local function AddQuestSearchItem(item)
                        if item and item[1] and item[1] > 0 then questItems[#questItems + 1] = item end
                    end
                    for _, item in ipairs(quest.rewardItems or {}) do AddQuestSearchItem(item) end
                    for _, item in ipairs(quest.additionalRewardItems or {}) do AddQuestSearchItem(item) end
                    for _, item in ipairs(quest.noteRewardItems or {}) do AddQuestSearchItem(item) end
                    AddQuestSearchItem(quest.requiredItem)
                    AddQuestSearchItem(quest.startItem)
                    AddQuestSearchItem(quest.noteItem)

                    for _, item in ipairs((FDJ.RPGQuestHidden and FDJ.RPGQuestHidden(dungeonName, quest)) and {} or questItems) do
                        local itemName = SearchItemDisplayName(item)
                        local matchScore = SearchMatchScore(query, itemName, item[2])
                        if matchScore then results[#results + 1] = {
                            score = matchScore + 4,
                            kind = "item",
                            mode = "quests",
                            dungeonName = dungeonName,
                            questIndex = questIndex,
                            questFaction = quest.faction,
                            faction = quest.faction,
                            itemID = item[1],
                            displayName = itemName,
                            subText = localizedDungeon .. "  -  " .. questName,
                            icon = ItemIcon(item[1]),
                        } end
                    end
                end
            end
        end

        table.sort(results, function(a, b)
            if a.score ~= b.score then return a.score < b.score end
            return tostring(a.displayName or "") < tostring(b.displayName or "")
        end)

        -- The same static item can be referenced more than once by a quest/data
        -- entry. Keep one result per actual source location so the dropdown never
        -- shows duplicate rows such as Gravestone Scepter twice for one quest.
        local unique, seen = {}, {}
        for _, result in ipairs(results) do
            local sourceIndex = result.mode == "bosses" and result.bossIndex or result.questIndex
            local key
            if result.kind == "dungeon" then
                key = "d|" .. tostring(result.dungeonName)
            elseif result.kind == "quest" then
                key = "q|" .. tostring(result.dungeonName) .. "|" .. tostring(result.questIndex or "")
            elseif result.mode == "recipe" then
                key = "r|" .. tostring(result.itemID or "")
            else
                key = table.concat({
                    "i",
                    tostring(result.itemID or ""),
                    tostring(result.dungeonName or ""),
                    tostring(result.mode or ""),
                    tostring(sourceIndex or ""),
                }, "|")
            end
            if not seen[key] then
                seen[key] = true
                unique[#unique + 1] = result
                if #unique >= MAX_SEARCH_RESULTS then break end
            end
        end
        return unique
    end

    local function FindVisibleSearchItemButton(result)
        if not result or not result.itemID then return nil end
        if result.mode == "bosses" then
            for _, row in ipairs(lootRows) do
                if row:IsShown() and row.item and tonumber(row.item[1]) == tonumber(result.itemID) then
                    return row, frame.lootScroll, frame.lootContent
                end
            end
        elseif result.mode == "quests" then
            for _, button in ipairs(questRewardButtons) do
                if button:IsShown() and button.item and tonumber(button.item[1]) == tonumber(result.itemID) then
                    return button, frame.questDetailScroll, frame.questDetailContent
                end
            end
            for _, button in ipairs(questNoteRewardButtons) do
                if button:IsShown() and button.item and tonumber(button.item[1]) == tonumber(result.itemID) then
                    return button, frame.questDetailScroll, frame.questDetailContent
                end
            end
            local noteButton = frame.questNoteItemButton
            if noteButton and noteButton:IsShown() and noteButton.item
                and tonumber(noteButton.item[1]) == tonumber(result.itemID) then
                return noteButton, frame.questDetailScroll, frame.questDetailContent
            end
        end
        return nil
    end

    local function FocusSearchItem(result)
        local function ApplyFocus()
            local button, scroll, content = FindVisibleSearchItemButton(result)
            if not button then return end

            if scroll and content then
                local contentTop = content:GetTop()
                local buttonTop = button:GetTop()
                local viewportHeight = scroll:GetHeight() or 0
                local contentHeight = content:GetHeight() or 0
                if contentTop and buttonTop and viewportHeight > 0 then
                    local itemOffset = math.max(0, contentTop - buttonTop)
                    local maxScroll = math.max(0, contentHeight - viewportHeight)
                    -- Put the searched item near the upper third of the visible
                    -- page so the surrounding Reward/Boss context remains clear.
                    local desired = itemOffset - math.max(12, viewportHeight * 0.28)
                    desired = math.max(0, math.min(maxScroll, desired))
                    scroll:SetVerticalScroll(desired)
                    if scroll.ScrollBar then scroll.ScrollBar:SetValue(desired) end
                end
            end
            ShowSearchItemHighlight(button)
        end

        if C_Timer and type(C_Timer.After) == "function" then
            C_Timer.After(0.03, ApplyFocus)
        else
            ApplyFocus()
        end
    end

    -- Favourites uses the same focus/highlight path as global search. Export the
    -- helper here, while FocusSearchItem is actually in lexical scope.
    FDJ.FocusBossLootItem = function(itemID)
        itemID = tonumber(itemID)
        if not itemID then return end
        FocusSearchItem({ kind = "item", mode = "bosses", itemID = itemID })
    end

    local function OpenRecipeSearchResult(result)
        local itemID = result and tonumber(result.itemID)
        if not itemID then return false end

        local sourceBosses, seenSources = {}, {}
        for _, sourceDungeonName in ipairs(ORDER or {}) do
            local sourceDungeon = DB[sourceDungeonName]
            if sourceDungeon and not (FDJ.IsDungeonLocked and FDJ.IsDungeonLocked(sourceDungeonName)) then
                for _, sourceBoss in ipairs(sourceDungeon.bosses or {}) do
                    -- Recipe-tab rows are synthetic duplicates. Build this hidden
                    -- page from the real bosses only.
                    if not sourceBoss.recipeTab and not sourceBoss.trash
                        and not (FDJ.RPGBossHidden and FDJ.RPGBossHidden(sourceDungeonName, sourceBoss)) then
                        for _, sourceItem in ipairs(sourceBoss.loot or {}) do
                            if tonumber(sourceItem[1]) == itemID then
                                local sourceKey = tostring(sourceDungeonName) .. "|" .. tostring(sourceBoss.name)
                                if not seenSources[sourceKey] then
                                    seenSources[sourceKey] = true
                                    sourceBosses[#sourceBosses + 1] = setmetatable({
                                        fdjDungeon = sourceDungeonName,
                                        loot = { sourceItem },
                                    }, { __index = sourceBoss })
                                end
                                break
                            end
                        end
                    end
                end
            end
        end

        if #sourceBosses == 0 then return false end

        local pageKey = "__FDJ_RECIPE_SEARCH__"
        DB[pageKey] = {
            recipeSearch = true,
            recipeSearchTitle = result.displayName or SearchItemDisplayName({ itemID, "Recipe" }),
            bosses = sourceBosses,
            quests = {},
        }

        -- This page intentionally is not added to ORDER and never becomes a
        -- normal dungeon tile. It only exists for the current recipe search.
        ShowDungeonPage()
        selectedDungeon = pageKey
        selectedBoss = 1
        selectedQuest = 1
        selectedMode = "bosses"
        if frame.bossListScroll then frame.bossListScroll:SetVerticalScroll(0) end
        if frame.lootScroll then frame.lootScroll:SetVerticalScroll(0) end
        RefreshAll()
        return true
    end

    local function OpenSearchResult(result)
        if not result or not result.dungeonName then return end
        searchBox:ClearFocus()
        searchBox:SetText("")
        searchResults:Hide()
        if result.kind == "item" and result.mode == "recipe" then
            OpenRecipeSearchResult(result)
            return
        end
        SelectDungeon(result.dungeonName)
        if result.kind == "item" and result.mode == "bosses" then
            SetMode("bosses")
            if result.bossIndex then SelectBoss(result.bossIndex) end
            FocusSearchItem(result)
        elseif (result.kind == "item" or result.kind == "quest") and result.mode == "quests" then
            SetMode("quests")
            if (result.questFaction == "Alliance" or result.questFaction == "Horde") and SetQuestFaction then
                SetQuestFaction(result.questFaction)
            end
            if result.questIndex then SelectQuest(result.questIndex) end
            if result.kind == "item" then FocusSearchItem(result) end
        end
    end

    -- Used by Systems/ItemSource.lua to jump to an item from a tooltip.
    FDJ.OpenSearchResult = OpenSearchResult

    local function EnsureSearchRow(index)
        local row = searchRows[index]
        if row then return row end

        row = CreateFrame("Button", nil, searchResults)
        row:SetHeight(39)
        row:SetPoint("LEFT", 5, 0)
        row:SetPoint("RIGHT", -5, 0)
        row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")

        row.factionIcon = row:CreateTexture(nil, "OVERLAY")
        row.factionIcon:SetSize(18, 18)
        row.factionIcon:SetPoint("RIGHT", -5, 0)
        row.factionIcon:Hide()

        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(28, 28)
        row.icon:SetPoint("LEFT", 7, 0)
        row.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        row.name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.name:SetPoint("TOPLEFT", row.icon, "TOPRIGHT", 9, -3)
        row.name:SetPoint("RIGHT", row, "RIGHT", -9, 0)
        row.name:SetJustifyH("LEFT")
        row.name:SetTextColor(1.00, 0.82, 0.27)

        row.source = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.source:SetPoint("TOPLEFT", row.name, "BOTTOMLEFT", 0, -2)
        row.source:SetPoint("RIGHT", row, "RIGHT", -9, 0)
        row.source:SetJustifyH("LEFT")
        row.source:SetTextColor(0.68, 0.66, 0.61)

        row:SetScript("OnClick", function(self)
            PlayJournalOptionSound()
            OpenSearchResult(self.searchResult)
        end)

        -- Item tooltip on hover, placed to the RIGHT of the results list so it
        -- never covers the other results.
        row:SetScript("OnEnter", function(self)
            local result = self.searchResult
            if not result or result.kind ~= "item" or not result.itemID or not itemTooltip then return end
            itemTooltip:Hide()
            itemTooltip:SetOwner(self, "ANCHOR_NONE")
            if itemTooltip.ClearLines then itemTooltip:ClearLines() end
            local _, liveLink = ItemInfo(result.itemID)
            itemTooltip:SetHyperlink(liveLink or ("item:" .. result.itemID))
            FDJ.AddUnseenItemHint(itemTooltip)
            itemTooltip:Show()
            if FDJ.RefreshTooltipBacking then FDJ.RefreshTooltipBacking() end
            itemTooltip:ClearAllPoints()
            itemTooltip:SetPoint("TOPLEFT", searchResults, "TOPRIGHT", 4, 0)
        end)
        row:SetScript("OnLeave", function()
            if itemTooltip then itemTooltip:Hide() end
        end)

        searchRows[index] = row
        return row
    end

    local function RefreshSearchResults(queryText, preserveOffset)
        currentSearchResults = BuildSearchResults(queryText or "")
        local hasQuery = SearchText(queryText or ""):match("%S") ~= nil
        local browsingDungeons = not hasQuery and searchBox:HasFocus()
        searchClear:SetShown(hasQuery)

        if not preserveOffset then searchResultOffset = 0 end
        local maxOffset = math.max(0, #currentSearchResults - MAX_VISIBLE_SEARCH_RESULTS)
        searchResultOffset = math.max(0, math.min(maxOffset, searchResultOffset))

        for _, row in ipairs(searchRows) do row:Hide() end
        if not hasQuery and not browsingDungeons then
            searchResults:Hide()
            return
        end

        if #currentSearchResults == 0 then
            local row = EnsureSearchRow(1)
            row.factionIcon:Hide()
            row.icon:ClearAllPoints()
            row.icon:SetPoint("LEFT", 7, 0)
            row.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            row.icon:SetSize(28, 28)
            row.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            row.name:SetText(L("SEARCH_NO_RESULTS"))
            row.source:SetText("")
            row.searchResult = nil
            row:EnableMouse(false)
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", searchResults, "TOPLEFT", 5, -5)
            row:SetPoint("TOPRIGHT", searchResults, "TOPRIGHT", -5, -5)
            row:Show()
            searchResults:SetHeight(49)
            searchResults:Show()
            return
        end

        local visibleCount = math.min(MAX_VISIBLE_SEARCH_RESULTS, #currentSearchResults - searchResultOffset)
        for visibleIndex = 1, visibleCount do
            local result = currentSearchResults[searchResultOffset + visibleIndex]
            local row = EnsureSearchRow(visibleIndex)
            row:EnableMouse(true)
            row.searchResult = result

            row.factionIcon:Hide()
            row.icon:ClearAllPoints()
            row.icon:SetPoint("LEFT", 7, 0)
            local hasFactionIcon = false
            if result.kind == "item" and result.faction == "Alliance" then
                row.factionIcon:SetTexture(ALLIANCE_ICON)
                row.factionIcon:Show()
                hasFactionIcon = true
            elseif result.kind == "item" and result.faction == "Horde" then
                row.factionIcon:SetTexture(HORDE_ICON)
                row.factionIcon:Show()
                hasFactionIcon = true
            end

            row.name:ClearAllPoints()
            -- All item results, including recipes, use the two-line layout so
            -- recipes can show their profession + required skill underneath.
            row.name:SetPoint("TOPLEFT", row.icon, "TOPRIGHT", 9, -3)
            row.name:SetPoint("RIGHT", row, "RIGHT", hasFactionIcon and -30 or -9, 0)
            row.source:ClearAllPoints()
            row.source:SetPoint("TOPLEFT", row.name, "BOTTOMLEFT", 0, -2)
            row.source:SetPoint("RIGHT", row, "RIGHT", hasFactionIcon and -30 or -9, 0)

            row.icon:SetTexture(result.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
            if result.kind == "dungeon" then
                row.icon:SetSize(44, 28)
                local tc = result.texCoord
                if tc then
                    row.icon:SetTexCoord(tc[1], tc[2], tc[3], tc[4])
                else
                    row.icon:SetTexCoord(0.08, 0.92, 0.18, 0.82)
                end
            else
                row.icon:SetSize(28, 28)
                row.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            end
            row.name:SetText(result.displayName or "")
            row.source:SetText(result.subText or "")
            row:ClearAllPoints()
            local rowY = -5 - ((visibleIndex - 1) * 39)
            row:SetPoint("TOPLEFT", searchResults, "TOPLEFT", 5, rowY)
            row:SetPoint("TOPRIGHT", searchResults, "TOPRIGHT", -5, rowY)
            row:Show()
        end
        searchResults:SetHeight(10 + (visibleCount * 39))
        searchResults:Show()
        ApplyLocaleFontTree(searchResults)
    end

    frame.RefreshSearchResults = RefreshSearchResults
    frame.UpdateSearchPlaceholder = function()
        searchPlaceholder:SetText(L("SEARCH"))
        searchPlaceholder:SetShown((searchBox:GetText() or "") == "" and not searchBox:HasFocus())
    end

    -- Typing waits a moment before searching, so fast typing runs one search
    -- instead of one per letter.
    local searchToken = 0
    searchBox:SetScript("OnTextChanged", function(self, userInput)
        searchPlaceholder:SetShown((self:GetText() or "") == "" and not self:HasFocus())
        searchToken = searchToken + 1
        local token = searchToken
        if userInput and C_Timer and type(C_Timer.After) == "function" and (self:GetText() or "") ~= "" then
            C_Timer.After(0.18, function()
                if token == searchToken then RefreshSearchResults(self:GetText() or "") end
            end)
        else
            RefreshSearchResults(self:GetText() or "")
        end
    end)
    searchBox:SetScript("OnEditFocusGained", function(self)
        searchPlaceholder:Hide()
        -- New search session: re-read the loot lists (the Loot Filter may have changed).
        if FDJ.ResetSearchCache then FDJ.ResetSearchCache() end
        RefreshSearchResults(self:GetText() or "")
    end)
    searchBox:SetScript("OnEditFocusLost", function(self)
        local function ResetIfClickedAway()
            if searchResults:IsMouseOver() or searchBox:IsMouseOver() then
                searchPlaceholder:SetShown((self:GetText() or "") == "")
                return
            end
            self:SetText("")
            searchResultOffset = 0
            searchResults:Hide()
            searchClear:Hide()
            searchPlaceholder:Show()
        end
        if C_Timer and type(C_Timer.After) == "function" then
            C_Timer.After(0, ResetIfClickedAway)
        else
            ResetIfClickedAway()
        end
    end)
    searchResults:EnableMouseWheel(true)
    searchResults:SetScript("OnMouseWheel", function(_, delta)
        local maxOffset = math.max(0, #currentSearchResults - MAX_VISIBLE_SEARCH_RESULTS)
        if maxOffset <= 0 then return end
        if delta < 0 then
            searchResultOffset = math.min(maxOffset, searchResultOffset + 1)
        elseif delta > 0 then
            searchResultOffset = math.max(0, searchResultOffset - 1)
        end
        RefreshSearchResults(searchBox:GetText() or "", true)
    end)
    searchBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        searchResults:Hide()
    end)
    searchBox:SetScript("OnEnterPressed", function(self)
        if currentSearchResults[1] then
            PlayJournalOptionSound()
            OpenSearchResult(currentSearchResults[1])
        else
            self:ClearFocus()
        end
    end)
    searchClear:SetScript("OnClick", function()
        searchBox:SetText("")
        searchBox:SetFocus()
    end)
    frame.UpdateSearchPlaceholder()
end

local function CreateMainFrame()
    frame = CreateFrame(
        "Frame",
        "ForeverDungeonJournalFrame",
        UIParent,
        "BackdropTemplate"
    )

    frame:SetSize(850, 590)
    frame:SetPoint("CENTER", 0, 10)
    frame:SetFrameStrata("DIALOG")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    SetBackdrop(
        frame,
        "Interface\\FrameGeneral\\UI-Background-Rock",
        "Interface\\DialogFrame\\UI-DialogBox-Border",
        24,
        6
    )
    frame:SetBackdropColor(0.045, 0.042, 0.037, 0.99)

    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    local top = frame:CreateTexture(nil, "BACKGROUND")
    top:SetTexture("Interface\\Buttons\\WHITE8X8")
    top:SetColorTexture(0.14, 0.10, 0.055, 0.96)
    top:SetPoint("TOPLEFT", 12, -10)
    top:SetPoint("TOPRIGHT", -12, -10)
    top:SetHeight(34)
    frame.topStrip = top

    local topLine = frame:CreateTexture(nil, "ARTWORK")
    topLine:SetTexture("Interface\\Buttons\\WHITE8X8")
    topLine:SetPoint("TOPLEFT", top, "TOPLEFT", 0, 0)
    topLine:SetPoint("TOPRIGHT", top, "TOPRIGHT", 0, 0)
    topLine:SetHeight(1)
    topLine:SetColorTexture(0.68, 0.52, 0.20, 0.65)
    frame.topStripLine = topLine

    local bottomLine = frame:CreateTexture(nil, "ARTWORK")
    bottomLine:SetTexture("Interface\\Buttons\\WHITE8X8")
    bottomLine:SetPoint("BOTTOMLEFT", top, "BOTTOMLEFT", 0, 0)
    bottomLine:SetPoint("BOTTOMRIGHT", top, "BOTTOMRIGHT", 0, 0)
    bottomLine:SetHeight(1)
    bottomLine:SetColorTexture(0.68, 0.52, 0.20, 0.45)
    frame.topStripBottomLine = bottomLine

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.mainTitle = title
    title:SetPoint("TOP", 0, -18)
    title:SetText(L("DUNGEON_JOURNAL"))
    title:SetTextColor(0.96, 0.79, 0.25)

    -- Compact language selector beside the journal title. The selected language
    -- and the familiar page arrows make the control self-explanatory, so the
    -- old "Languages" label is intentionally omitted.
    local function StyleLanguageArrowButton(button, direction)
        local isLeft = direction == "LEFT"
        -- Use Blizzard's native spellbook page buttons. These are the same
        -- clean, gold triangular arrows used by classic-era Blizzard UI.
        local normal = isLeft and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"
        local pushed = isLeft and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down"
        local disabled = isLeft and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled"
        button:SetNormalTexture(normal)
        button:SetPushedTexture(pushed)
        button:SetDisabledTexture(disabled)
        local normalTex = button:GetNormalTexture()
        if normalTex then normalTex:SetAllPoints(button) end
        local pushedTex = button:GetPushedTexture()
        if pushedTex then pushedTex:SetAllPoints(button) end
        local disabledTex = button:GetDisabledTexture()
        if disabledTex then disabledTex:SetAllPoints(button) end
        local highlight = button:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
        highlight:SetBlendMode("ADD")
        highlight:SetAllPoints(button)
    end

    local languageSelector = CreateFrame("Button", nil, frame, "BackdropTemplate")
    frame.languageSelectorButton = languageSelector
    frame.languageSelectorButton = languageSelector
    languageSelector:SetSize(110, 24)
    languageSelector:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -49, -15)
    SetBackdrop(languageSelector, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 12, 4)
    languageSelector:SetBackdropColor(0.12, 0.115, 0.105, 0.98)
    languageSelector:SetBackdropBorderColor(0.48, 0.40, 0.27, 1)
    languageSelector:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")

    -- Small down arrow: shows the box opens a list of languages.
    local languageCaret = languageSelector:CreateTexture(nil, "OVERLAY")
    languageCaret:SetTexture("Interface\\Buttons\\Arrow-Down-Up")
    languageCaret:SetSize(12, 12)
    languageCaret:SetPoint("RIGHT", languageSelector, "RIGHT", -7, -3)

    local languageSelectorText = languageSelector:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.languageSelectorText = languageSelectorText
    languageSelectorText:SetPoint("LEFT", 8, 0)
    languageSelectorText:SetPoint("RIGHT", -20, 0)
    languageSelectorText:SetJustifyH("CENTER")
    languageSelectorText:SetTextColor(1.00, 0.82, 0.27)

    local languageMenu = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    frame.languageMenu = languageMenu
    languageMenu:SetSize(158, (#LANGUAGE_CHOICES * 24) + 10)
    languageMenu:SetPoint("TOPLEFT", languageSelector, "BOTTOMLEFT", -4, -4)
    languageMenu:SetFrameStrata("TOOLTIP")
    languageMenu:SetFrameLevel(frame:GetFrameLevel() + 30)
    SetBackdrop(languageMenu, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 12, 4)
    languageMenu:SetBackdropColor(0.055, 0.05, 0.043, 0.99)
    languageMenu:SetBackdropBorderColor(0.57, 0.43, 0.20, 1)
    languageMenu:Hide()

    for i, info in ipairs(LANGUAGE_CHOICES) do
        local option = CreateFrame("Button", nil, languageMenu)
        option:SetPoint("TOPLEFT", 6, -5 - ((i - 1) * 22))
        option:SetPoint("TOPRIGHT", -6, -5 - ((i - 1) * 22))
        option:SetHeight(21)
        option:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
        local optionText = option:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        optionText:SetPoint("LEFT", 10, 0)
        optionText:SetText(info.label)
        optionText:SetTextColor(0.95, 0.83, 0.53)

        option:SetScript("OnClick", function()
            PlayJournalOptionSound()
            languageMenu:Hide()
            ApplySelectedLanguage(info.code)
        end)
    end

    local function ToggleLanguageMenu()
        PlayJournalOptionSound()
        languageMenu:SetShown(not languageMenu:IsShown())
    end

    languageSelector:SetScript("OnClick", ToggleLanguageMenu)
    UpdateLanguageControl()

    CreateGlobalSearchUI()

    ApplyLocaleFontTree(frame)

    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -3, -3)
    frame.closeButton = close

    frame.backButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.backButton:SetSize(120, 24)
    frame.backButton:SetPoint("TOPLEFT", 28, -54)
    frame.backButton:SetText(L("DUNGEONS"))
    frame.backButton.text = frame.backButton.GetFontString and frame.backButton:GetFontString() or nil
    if frame.backButton.text then
        frame.backButton.text:SetTextColor(1.00, 0.82, 0.27)
    end
    frame.backButton:SetScript("OnClick", function()
        ShowHomePage()
    end)
    frame.backButton:Hide()

    frame.sourceLabel = nil

    local home = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    frame.homePanel = home
    home:SetPoint("TOPLEFT", 18, -52)
    home:SetPoint("BOTTOMRIGHT", -18, 18)
    SetBackdrop(
        home,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        14,
        4
    )
    home:SetBackdropColor(0.16, 0.12, 0.07, 0.96)
    home:SetBackdropBorderColor(0.47, 0.34, 0.16, 1)
    frame.homeParchment = AddClassicParchment(home, 0.18, 1.00, 0.95, 0.84)

    local homeTitle = home:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.homeTitle = homeTitle
    homeTitle:SetPoint("TOPLEFT", 18, -16)
    homeTitle:SetText(L("BROWSE_DUNGEONS"))
    homeTitle:SetTextColor(1.00, 0.78, 0.20)

    local homeSubtitle = home:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    frame.homeSubtitle = homeSubtitle
    homeSubtitle:SetPoint("TOPLEFT", homeTitle, "BOTTOMLEFT", 1, -5)
    homeSubtitle:SetText(L("HOME_SUBTITLE"))
    homeSubtitle:SetTextColor(0.72, 0.67, 0.58)

    local hideDungeonsButton = CreateFrame("Button", nil, home, "BackdropTemplate")
    frame.hideDungeonsButton = hideDungeonsButton
    hideDungeonsButton:SetSize(142, 28)
    hideDungeonsButton:SetPoint("TOP", frame.languageSelectorButton, "BOTTOM", 0, -26)
    SetBackdrop(hideDungeonsButton, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 12, 4)
    hideDungeonsButton:SetBackdropColor(0.12, 0.115, 0.105, 0.98)
    hideDungeonsButton:SetBackdropBorderColor(0.48, 0.40, 0.27, 1)
    hideDungeonsButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")

    local hideDungeonsButtonText = hideDungeonsButton:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.hideDungeonsButtonText = hideDungeonsButtonText
    hideDungeonsButtonText:SetPoint("CENTER", 0, 0)
    hideDungeonsButtonText:SetTextColor(1.00, 0.82, 0.27)
    hideDungeonsButtonText:SetText(L("HIDE_DUNGEONS"))

    local hideDungeonsDoneCheck = hideDungeonsButton:CreateTexture(nil, "OVERLAY")
    frame.hideDungeonsDoneCheck = hideDungeonsDoneCheck
    hideDungeonsDoneCheck:SetSize(16, 16)
    hideDungeonsDoneCheck:SetPoint("RIGHT", hideDungeonsButton, "RIGHT", -8, 0)
    hideDungeonsDoneCheck:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
    hideDungeonsDoneCheck:SetTexCoord(0, 1, 0, 1)
    hideDungeonsDoneCheck:Hide()

    hideDungeonsButton:SetScript("OnClick", function()
        PlayJournalOptionSound()
        homeEditMode = not homeEditMode
        -- Keep the action button in the normal dark/gold journal style in both
        -- modes. Edit mode is communicated by the dungeon-card treatment; the
        -- Done state gets a small green confirmation check instead of a blue button.
        hideDungeonsButton:SetBackdropColor(0.12, 0.115, 0.105, 0.98)
        hideDungeonsButton:SetBackdropBorderColor(0.48, 0.40, 0.27, 1)
        hideDungeonsButtonText:SetTextColor(1.00, 0.82, 0.27)
        hideDungeonsButtonText:SetText(homeEditMode and L("DONE") or L("HIDE_DUNGEONS"))
        hideDungeonsButtonText:ClearAllPoints()
        hideDungeonsButtonText:SetPoint("CENTER", homeEditMode and -8 or 0, 0)
        if hideDungeonsDoneCheck then
            hideDungeonsDoneCheck:SetShown(homeEditMode)
        end
        local extra = homeEditMode and 44 or 26
        local width = math.max(126, math.min(180, math.ceil((hideDungeonsButtonText:GetStringWidth() or 100) + extra)))
        hideDungeonsButton:SetWidth(width)
        RefreshHomeDungeonCards()
    end)

    FDJ.OpenBossPage = function(dungeonName, bossIndex)
        if not DB[dungeonName] then return end
        SelectDungeon(dungeonName)
        SetMode("bosses")
        if bossIndex then SelectBoss(bossIndex) end
    end
    -- Quest tracker: the ? of a quest handed in inside a dungeon opens that
    -- dungeon's map on the NPC's level, with a yellow ? on the NPC (start:
    -- the ! of a quest picked up there, a yellow ! on the giver).
    FDJ.ShowTurnInOnDungeonMap = function(dungeonName, spot, questTitle, questID, start)
        local mapData = FDJ.DUNGEON_MAPS[dungeonName]
        if not DB[dungeonName] or not mapData or type(spot) ~= "table" then return end
        -- rpgpartial: the map still locked: the quest's page instead.
        if FDJ.IsDungeonMapLocked and FDJ.IsDungeonMapLocked(dungeonName) then
            if FDJ.RPGMapLockedNotice then FDJ.RPGMapLockedNotice(dungeonName) end
            if questID and FDJ.OpenQuestPage then FDJ.OpenQuestPage(dungeonName, questID) end
            return
        end
        local floor = spot.floor or 1
        FDJ.dungeonTurnIns = FDJ.dungeonTurnIns or {}
        FDJ.dungeonTurnIns[mapData] = { floor = floor, x = spot.x, y = spot.y, npc = spot.npc, title = questTitle, questID = questID, start = start and true or nil }
        SelectDungeon(dungeonName)
        if selectedDungeon ~= dungeonName then return end
        ShowDungeonMap()
        if frame.dungeonMapFloor ~= floor then
            FDJ.ResetDungeonMapView()
            FDJ.RenderCustomDungeonMap(mapData, floor)
        end
    end
    -- mapquests: a quest item lying on one of the map's quest spots (the
    -- item's click on the quest page): that dungeon map, on its level.
    FDJ.ShowQuestSpotOnDungeonMap = function(spot)
        local name = type(spot) == "table" and spot.dungeon or nil
        local mapData = name and FDJ.DUNGEON_MAPS[name]
        if not name or not DB[name] or not mapData then return end
        if FDJ.IsDungeonMapLocked and FDJ.IsDungeonMapLocked(name) then
            if FDJ.RPGMapLockedNotice then FDJ.RPGMapLockedNotice(name) end
            return
        end
        SelectDungeon(name)
        if selectedDungeon ~= name then return end
        ShowDungeonMap()
        local floor = spot.floor or 1
        if frame.dungeonMapFloor ~= floor then
            FDJ.ResetDungeonMapView()
            FDJ.RenderCustomDungeonMap(mapData, floor)
        end
    end
    FDJ.OpenQuestPage = function(dungeonName, questID)
        if not DB[dungeonName] then return end
        SelectDungeon(dungeonName)
        SetMode("quests")
        if SelectQuestByID then SelectQuestByID(questID) end
    end
    -- rpgpartial: the "Dungeon Map Unlocked" popup opens the map.
    FDJ.OpenDungeonMap = function(dungeonName)
        if not DB[dungeonName] then return end
        SelectDungeon(dungeonName)
        if selectedDungeon == dungeonName and ShowDungeonMap then ShowDungeonMap() end
    end
    -- questtracker: a chain step clicked in the quest tracker opens that
    -- step's page, with the quest's chain unfolded in the list (what Show
    -- Quest Chain does, for the given step).
    FDJ.OpenQuestChainStep = function(dungeonName, questID, stepID)
        if not DB[dungeonName] then return end
        SelectDungeon(dungeonName)
        if selectedDungeon ~= dungeonName then return end
        SetMode("quests")
        if SelectQuestByID then SelectQuestByID(questID) end
        local chain = questID and QUEST_PREREQ_CHAINS[questID]
        if type(chain) ~= "table" then return end
        local target
        for _, step in ipairs(chain) do
            if step.id and step.id == stepID then target = step break end
        end
        if not target then return end
        local parentName
        for _, quest in ipairs(DB[dungeonName].quests or {}) do
            if quest.id == questID then parentName = quest.name break end
        end
        expandedQuestChains[questID] = true
        selectedPrereqStep = target
        selectedPrereqParentQuestName = parentName
        selectedPrereqParentQuestID = questID
        if target.id then RequestQuestRewardData(target.id) end
        RefreshQuestList()
        RefreshQuestDetail()
    end
    -- sleepingbag: a quest with its chain unfolded in the list; with a
    -- step, that step's page.
    FDJ.OpenQuestChain = function(dungeonName, questID, stepID)
        if stepID then return FDJ.OpenQuestChainStep(dungeonName, questID, stepID) end
        FDJ.OpenQuestPage(dungeonName, questID)
        if selectedDungeon ~= dungeonName or not QUEST_PREREQ_CHAINS[questID] then return end
        expandedQuestChains[questID] = true
        RefreshQuestList()
    end
    FDJ.RefreshLootNow = function()
        if selectedDungeon and DB[selectedDungeon] and frame.lootContent then pcall(RefreshLoot) end
    end
    if FDJ.CreateLootFilterButton then FDJ.CreateLootFilterButton(frame, home, hideDungeonsButton) end
    if FDJ.CreateBugReportButton then FDJ.CreateBugReportButton(frame, frame, frame.languageSelectorButton) end

    local homeEmptyText = home:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    frame.homeEmptyText = homeEmptyText
    homeEmptyText:SetPoint("CENTER", home, "CENTER", 0, -15)
    homeEmptyText:SetWidth(560)
    homeEmptyText:SetJustifyH("CENTER")
    homeEmptyText:SetTextColor(0.75, 0.72, 0.66)
    homeEmptyText:Hide()

    local homeLine = home:CreateTexture(nil, "ARTWORK")
    frame.homeLine = homeLine
    homeLine:SetTexture("Interface\\Buttons\\WHITE8X8")
    homeLine:SetPoint("TOPLEFT", 18, -58)
    homeLine:SetPoint("TOPRIGHT", -31, -58)
    homeLine:SetHeight(1)
    homeLine:SetColorTexture(0.48, 0.34, 0.16, 0.75)

    frame.homeScroll = CreateFrame(
        "ScrollFrame",
        "ForeverDungeonJournalHomeScroll",
        home,
        "UIPanelScrollFrameTemplate"
    )
    frame.homeScroll:SetPoint("TOPLEFT", 18, -72)
    frame.homeScroll:SetPoint("BOTTOMRIGHT", -31, 15)

    frame.homeCardsContent = CreateFrame("Frame", nil, frame.homeScroll)
    frame.homeCardsContent:SetSize(747, 1)
    frame.homeScroll:SetScrollChild(frame.homeCardsContent)

    local content = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    frame.contentPanel = content
    content:SetPoint("TOPLEFT", 18, -90)
    content:SetPoint("BOTTOMRIGHT", -18, 18)

    SetBackdrop(
        content,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        14,
        4
    )
    content:SetBackdropColor(0.17, 0.12, 0.07, 0.96)
    content:SetBackdropBorderColor(0.47, 0.34, 0.16, 1)
    frame.contentParchment = AddClassicParchment(content, 0.18, 1.00, 0.95, 0.84)

    frame.dungeonBackgroundArt = content:CreateTexture(nil, "BACKGROUND", nil, -4)
    frame.dungeonBackgroundArt:SetAllPoints(content)
    frame.dungeonBackgroundArt:SetTexture(
        "Interface\\AddOns\\ForeverDungeonJournal\\Media\\HallOfThanes.tga"
    )
    frame.dungeonBackgroundArt:SetTexCoord(0, 1, 0, 1)
    frame.dungeonBackgroundArt:SetAlpha(0)

    -- Dungeon-specific atmosphere overlays. These are abstract color/fog
    -- layers, not copies of either loading screen.
    frame.atmosphere = content:CreateTexture(nil, "BACKGROUND", nil, -7)
    frame.atmosphere:SetTexture("Interface\\Buttons\\WHITE8X8")
    frame.atmosphere:SetAllPoints(content)
    frame.atmosphere:SetColorTexture(0.08, 0.22, 0.19, 0)

    frame.mistTop = content:CreateTexture(nil, "BACKGROUND", nil, -6)
    frame.mistTop:SetTexture("Interface\\Buttons\\WHITE8X8")
    frame.mistTop:SetPoint("TOPLEFT", 4, -4)
    frame.mistTop:SetPoint("TOPRIGHT", -4, -4)
    frame.mistTop:SetHeight(95)
    frame.mistTop:SetColorTexture(0.18, 0.42, 0.36, 0.14)

    -- Header
    local header = CreateFrame("Frame", nil, content, "BackdropTemplate")
    frame.headerPanel = header
    header:SetPoint("TOPLEFT", 14, -12)
    header:SetPoint("TOPRIGHT", -14, -12)
    header:SetHeight(62)

    SetBackdrop(
        header,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        10,
        2
    )
    header:SetBackdropColor(0.24, 0.17, 0.09, 0.94)
    header:SetBackdropBorderColor(0.52, 0.33, 0.11, 1)
    frame.headerParchment = AddClassicParchment(header, 0.16, 1.00, 0.94, 0.82)

    frame.dungeonTitle = header:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.dungeonTitle:SetPoint("TOPLEFT", 15, -10)
    frame.dungeonTitle:SetTextColor(1, 0.82, 0.27)

    frame.dungeonLocationButton = CreateFrame("Button", nil, header)
    frame.dungeonLocationButton:SetSize(38, 38)
    frame.dungeonLocationButton:SetPoint("LEFT", frame.dungeonTitle, "RIGHT", 5, 1)
    frame.dungeonLocationButton:SetFrameLevel(header:GetFrameLevel() + 4)
    frame.dungeonLocationButton.icon = frame.dungeonLocationButton:CreateTexture(nil, "ARTWORK")
    frame.dungeonLocationButton.icon:SetPoint("CENTER")
    frame.dungeonLocationButton.icon:SetSize(36, 36)
    local dungeonAtlasOK = false
    if frame.dungeonLocationButton.icon.SetAtlas then
        dungeonAtlasOK = pcall(frame.dungeonLocationButton.icon.SetAtlas, frame.dungeonLocationButton.icon, "Dungeon", false)
    end
    if not dungeonAtlasOK then
        frame.dungeonLocationButton.icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_01")
        frame.dungeonLocationButton.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    frame.dungeonLocationButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    frame.dungeonLocationButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L("SHOW_LOCATION"))
        GameTooltip:Show()
    end)
    frame.dungeonLocationButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.dungeonLocationButton:SetScript("OnClick", function()
        local dungeon = DB[selectedDungeon]
        local entrance = dungeon and dungeon.entrance
        if entrance and FDJ.MapMarkers and FDJ.MapMarkers.ShowRecordedLocationOnMap then
            FDJ.MapMarkers.ShowRecordedLocationOnMap(entrance, DungeonName(selectedDungeon))
        end
    end)
    if FDJ.CreateLFGButton then FDJ.CreateLFGButton(frame, header, frame.dungeonLocationButton) end

    frame.dungeonRouteButton = CreateFrame("Button", nil, header, "UIPanelButtonTemplate")
    frame.dungeonRouteButton:SetSize(96, 30)
    frame.dungeonRouteButton:SetPoint("LEFT", frame.lfgButton or frame.dungeonLocationButton, "RIGHT", 3, 0)
    frame.dungeonRouteButton:SetText(L("ROUTE"))
    frame.dungeonRouteButton.text = frame.dungeonRouteButton:GetFontString()
    if frame.dungeonRouteButton.text then
        frame.dungeonRouteButton.text:ClearAllPoints()
        frame.dungeonRouteButton.text:SetPoint("CENTER", 10, 0)
        frame.dungeonRouteButton.text:SetTextColor(1.00, 0.82, 0.27)
    end
    frame.dungeonRouteButton.icon = frame.dungeonRouteButton:CreateTexture(nil, "OVERLAY")
    frame.dungeonRouteButton.icon:SetSize(23, 23)
    frame.dungeonRouteButton.icon:SetPoint("LEFT", 5, 0)
    frame.dungeonRouteButton.icon:SetTexture(ALLIANCE_ICON)
    frame.dungeonRouteButton:SetScript("OnClick", ShowRouteGuide)
    frame.dungeonRouteButton:Hide()

    frame.dungeonMeta = header:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    frame.dungeonMeta:SetPoint("TOPLEFT", frame.dungeonTitle, "BOTTOMLEFT", 0, -4)
    frame.dungeonMeta:SetTextColor(0.88, 0.80, 0.66)

    -- Stockade loot data is still being verified. Keep this notice in the
    -- dungeon header so it clearly applies to both the Bosses and Quests tabs.
    frame.stockadeItemsTBD = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.stockadeItemsTBD:SetText("Items Data TBD")
    frame.stockadeItemsTBD:SetTextColor(1.00, 0.10, 0.10)
    frame.stockadeItemsTBD:SetShadowColor(0, 0, 0, 1)
    frame.stockadeItemsTBD:SetShadowOffset(1, -1)
    frame.stockadeItemsTBD:Hide()

    -- Sub-tabs live inside the dungeon header, to the right of the dungeon name.
    frame.questsTab = CreateModeButton(header, L("QUESTS"), -13)
    frame.bossesTab = CreateModeButton(header, L("BOSSES"), -127)
    frame.mapTab = CreateModeButton(header, L("MAP"), -241)
    frame.mapTab:Hide()
    -- Keep the Stockade "Items Data TBD" note left of the Map button so it
    -- never overlaps the header buttons.
    frame.stockadeItemsTBD:SetPoint("RIGHT", frame.bossesTab, "LEFT", -12, 0)
    frame.stockadeItemsTBD:SetFontObject("GameFontNormal")
    frame.stockadeItemsTBD:SetTextColor(1.00, 0.10, 0.10)
    frame.bossesTab:SetScript("OnClick", function() SetMode("bosses") end)
    frame.questsTab:SetScript("OnClick", function() SetMode("quests") end)
    frame.mapTab:SetScript("OnClick", function() if ShowDungeonMap then ShowDungeonMap() end end)

    -- LEFT: boss list remains visible at all times.
    local left = CreateFrame("Frame", nil, content, "BackdropTemplate")
    frame.leftPanel = left
    left:SetPoint("TOPLEFT", 14, -84)
    left:SetPoint("BOTTOMLEFT", 14, 14)
    left:SetWidth(344)

    SetBackdrop(
        left,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        12,
        3
    )
    left:SetBackdropColor(0.19, 0.13, 0.07, 0.94)
    left:SetBackdropBorderColor(0.39, 0.24, 0.08, 1)
    frame.leftParchment = AddClassicParchment(left, 0.13, 1.00, 0.94, 0.82)

    local encounters = left:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.bossListTitle = encounters
    encounters:SetPoint("TOPLEFT", 12, -10)
    encounters:SetText(L("BOSSES"))
    encounters:SetTextColor(0.25, 0.12, 0.035)

    local bossScroll = CreateFrame(
        "ScrollFrame",
        "ForeverDungeonJournalBossListScroll",
        left,
        "UIPanelScrollFrameTemplate"
    )
    frame.bossListScroll = bossScroll
    bossScroll:SetPoint("TOPLEFT", 10, -40)
    bossScroll:SetPoint("BOTTOMRIGHT", -28, 10)

    frame.bossContent = CreateFrame("Frame", nil, bossScroll)
    frame.bossContent:SetSize(315, 1)
    bossScroll:SetScrollChild(frame.bossContent)

    -- RIGHT: selected boss + loot, while the full boss list stays visible.
    local right = CreateFrame("Frame", nil, content, "BackdropTemplate")
    frame.rightPanel = right
    right:SetPoint("TOPLEFT", left, "TOPRIGHT", 12, 0)
    right:SetPoint("BOTTOMRIGHT", -14, 14)

    SetBackdrop(
        right,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        12,
        3
    )
    right:SetBackdropColor(0.21, 0.15, 0.08, 0.94)
    right:SetBackdropBorderColor(0.42, 0.27, 0.10, 1)
    frame.rightParchment = AddClassicParchment(right, 0.13, 1.00, 0.94, 0.82)

    frame.selectedBossPortrait = right:CreateTexture(nil, "ARTWORK")
    frame.selectedBossPortrait:SetSize(68, 68)
    frame.selectedBossPortrait:SetPoint("TOPLEFT", 16, -16)
    frame.selectedBossPortrait:SetTexCoord(0.04, 0.96, 0.04, 0.96)

    frame.selectedBossRareBorder = right:CreateTexture(nil, "OVERLAY")
    frame.selectedBossRareBorder:SetSize(98, 98)
    frame.selectedBossRareBorder:SetPoint("CENTER", frame.selectedBossPortrait, "CENTER", 0, 0)
    frame.selectedBossRareBorder:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\RarePortraitDragonFrame.tga")
    frame.selectedBossRareBorder:SetTexCoord(0, 1, 0, 1)
    frame.selectedBossRareBorder:Hide()

    frame.selectedBossQuestion = right:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormalHuge"
    )
    frame.selectedBossQuestion:SetPoint(
        "CENTER",
        frame.selectedBossPortrait,
        "CENTER",
        0,
        0
    )
    frame.selectedBossQuestion:SetText("?")
    frame.selectedBossQuestion:SetTextColor(0.48, 0.25, 0.05)
    frame.selectedBossQuestion:Hide()

    frame.selectedBossLevelBadge = right:CreateTexture(nil, "OVERLAY", nil, 6)
    frame.selectedBossLevelBadge:SetSize(36, 36)
    frame.selectedBossLevelBadge:SetPoint("CENTER", frame.selectedBossPortrait, "BOTTOMLEFT", 8, 3)
    frame.selectedBossLevelBadge:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\BossLevelBadge.tga")
    frame.selectedBossLevelBadge:Hide()

    frame.selectedBossLevelText = right:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.selectedBossLevelText:SetPoint("CENTER", frame.selectedBossLevelBadge, "CENTER", 0, 0)
    frame.selectedBossLevelText:SetTextColor(1, 1, 1)
    frame.selectedBossLevelText:SetShadowColor(0, 0, 0, 1)
    frame.selectedBossLevelText:SetShadowOffset(1, -1)
    frame.selectedBossLevelText:Hide()


    frame.selectedBossName = right:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.selectedBossName:SetPoint(
        "LEFT",
        frame.selectedBossPortrait,
        "RIGHT",
        16,
        7
    )
    frame.selectedBossName:SetPoint("RIGHT", -14, 0)
    frame.selectedBossName:SetJustifyH("LEFT")
    frame.selectedBossName:SetTextColor(0.29, 0.13, 0.035)

    frame.selectedBossType = right:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.selectedBossType:SetPoint(
        "TOPLEFT",
        frame.selectedBossName,
        "BOTTOMLEFT",
        0,
        -4
    )
    frame.selectedBossType:Hide()

    frame.selectedBossDescription = right:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )
    frame.selectedBossDescription:SetPoint(
        "TOPLEFT",
        frame.selectedBossType,
        "BOTTOMLEFT",
        0,
        -7
    )
    frame.selectedBossDescription:SetPoint("RIGHT", -12, 0)
    frame.selectedBossDescription:SetHeight(35)
    frame.selectedBossDescription:SetJustifyH("LEFT")
    frame.selectedBossDescription:SetJustifyV("TOP")
    frame.selectedBossDescription:SetWordWrap(true)
    frame.selectedBossDescription:SetTextColor(0.22, 0.13, 0.06)
    frame.selectedBossDescription:Hide()

    frame.lootTitle = right:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.lootTitle:SetPoint("TOPLEFT", 14, -102)
    frame.lootTitle:SetTextColor(0.27, 0.13, 0.04)
    frame.lootTitle:Hide()

    -- Repeat the Stockade warning directly above the boss loot list so players
    -- do not mistake the currently incomplete beta item data for final loot.
    frame.stockadeLootTBD = right:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.stockadeLootTBD:SetPoint("TOP", right, "TOP", 0, -91)
    frame.stockadeLootTBD:SetText("Items Data TBD")
    frame.stockadeLootTBD:SetTextColor(1.00, 0.10, 0.10)
    frame.stockadeLootTBD:SetShadowColor(0, 0, 0, 1)
    frame.stockadeLootTBD:SetShadowOffset(1, -1)
    frame.stockadeLootTBD:Hide()

    local lootScroll = CreateFrame(
        "ScrollFrame",
        "ForeverDungeonJournalLootScroll",
        right,
        "UIPanelScrollFrameTemplate"
    )
    frame.lootScroll = lootScroll
    lootScroll:SetPoint("TOPLEFT", 12, -102)
    lootScroll:SetPoint("BOTTOMRIGHT", -29, 11)

    frame.lootContent = CreateFrame("Frame", nil, lootScroll)
    frame.lootContent:SetSize(388, 1)
    lootScroll:SetScrollChild(frame.lootContent)
    -- Resizing the window can change how many loot columns fit. React to
    -- width changes only (the item-count title changes the height).
    lootScroll:HookScript("OnSizeChanged", function(self, width)
        width = math.floor(width or 0)
        if width == self.fdjLastWidth then return end
        self.fdjLastWidth = width
        if frame:IsShown() and FDJ.RefreshLootNow then FDJ.RefreshLootNow() end
    end)

    -- QUEST MODE: mirrors the fast boss workflow. All quests remain visible on
    -- the left; clicking one updates the details on the right with no extra page.
    local questLeft = CreateFrame("Frame", nil, content, "BackdropTemplate")
    frame.questLeftPanel = questLeft
    questLeft:SetPoint("TOPLEFT", 14, -84)
    questLeft:SetPoint("BOTTOMLEFT", 14, 14)
    questLeft:SetWidth(344)
    SetBackdrop(
        questLeft,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        12,
        3
    )
    frame.questLeftParchment = AddClassicParchment(questLeft, 0.13, 1.00, 0.94, 0.82)

    frame.questListTitle = questLeft:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.questListTitle:SetPoint("TOPLEFT", 12, -10)
    frame.questListTitle:SetText(L("QUESTS"))

    local function CreateFactionButton(faction, x, texturePath)
        local b = CreateFrame("Button", nil, questLeft, "BackdropTemplate")
        b:SetSize(50, 38)
        b:SetPoint("TOPRIGHT", x, -7)
        SetBackdrop(
            b,
            "Interface\\Buttons\\WHITE8X8",
            "Interface\\Tooltips\\UI-Tooltip-Border",
            8,
            2
        )

        b.faction = faction
        b.icon = b:CreateTexture(nil, "ARTWORK")
        b.icon:SetSize(31, 31)
        b.icon:SetPoint("CENTER")
        b.icon:SetTexture(texturePath)
        b.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)

        b:SetScript("OnClick", function()
            SetQuestFaction(faction)
        end)

        b:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L("FACTION_QUESTS", faction))
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        return b
    end

    frame.hordeQuestButton = CreateFactionButton("Horde", -10, HORDE_ICON)
    frame.allianceQuestButton = CreateFactionButton("Alliance", -66, ALLIANCE_ICON)
    if FDJ.CreateQuestTrackButton then FDJ.CreateQuestTrackButton(frame, questLeft) end -- questtracker

    local questScroll = CreateFrame(
        "ScrollFrame",
        "ForeverDungeonJournalQuestListScroll",
        questLeft,
        "UIPanelScrollFrameTemplate"
    )
    frame.questListScroll = questScroll
    questScroll:SetPoint("TOPLEFT", 10, -56)
    questScroll:SetPoint("BOTTOMRIGHT", -28, 10)

    frame.questContent = CreateFrame("Frame", nil, questScroll)
    frame.questContent:SetSize(296, 1)
    questScroll:SetScrollChild(frame.questContent)

    local questRight = CreateFrame("Frame", nil, content, "BackdropTemplate")
    frame.questRightPanel = questRight
    questRight:SetPoint("TOPLEFT", questLeft, "TOPRIGHT", 12, 0)
    questRight:SetPoint("BOTTOMRIGHT", -14, 14)
    SetBackdrop(
        questRight,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        12,
        3
    )
    frame.questRightParchment = AddClassicParchment(questRight, 0.10, 1.00, 0.94, 0.82)

    local questInset = CreateFrame("Frame", nil, questRight, "BackdropTemplate")
    frame.questTextInset = questInset
    questInset:SetPoint("TOPLEFT", 8, -8)
    questInset:SetPoint("BOTTOMRIGHT", -14, 8)
    SetBackdrop(
        questInset,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        10,
        3
    )
    questInset:SetBackdropColor(0.70, 0.58, 0.39, 1)
    questInset:SetBackdropBorderColor(0.36, 0.23, 0.09, 1)

    frame.questParchment = questInset:CreateTexture(nil, "BACKGROUND", nil, -3)
    frame.questParchment:SetPoint("TOPLEFT", 4, -4)
    frame.questParchment:SetPoint("BOTTOMRIGHT", -4, 4)
    frame.questParchment:SetTexture("Interface\\QuestFrame\\QuestBG")
    frame.questParchment:SetTexCoord(0, 1, 0, 1)
    frame.questParchment:SetVertexColor(1.00, 0.96, 0.84, 1.00)

    -- Explicit edge lines guarantee the quest-detail rectangle is closed on
    -- all four sides, even if this beta clips a Backdrop edge.
    frame.questInsetEdges = {}
    local function MakeQuestInsetEdge()
        local edge = questInset:CreateTexture(nil, "OVERLAY", nil, 7)
        edge:SetTexture("Interface\\Buttons\\WHITE8X8")
        edge:SetColorTexture(0.42, 0.29, 0.13, 0.95)
        table.insert(frame.questInsetEdges, edge)
        return edge
    end

    local topEdge = MakeQuestInsetEdge()
    topEdge:SetPoint("TOPLEFT", 3, -3)
    topEdge:SetPoint("TOPRIGHT", -3, -3)
    topEdge:SetHeight(3)

    local bottomEdge = MakeQuestInsetEdge()
    bottomEdge:SetPoint("BOTTOMLEFT", 3, 3)
    bottomEdge:SetPoint("BOTTOMRIGHT", -3, 3)
    bottomEdge:SetHeight(3)

    local leftEdge = MakeQuestInsetEdge()
    leftEdge:SetPoint("TOPLEFT", 3, -3)
    leftEdge:SetPoint("BOTTOMLEFT", 3, 3)
    leftEdge:SetWidth(3)

    local rightEdge = MakeQuestInsetEdge()
    rightEdge:SetPoint("TOPRIGHT", -3, -3)
    rightEdge:SetPoint("BOTTOMRIGHT", -3, 3)
    rightEdge:SetWidth(3)

    frame.selectedQuestName = questInset:CreateFontString(nil, "OVERLAY")
    frame.selectedQuestName:SetPoint("TOPLEFT", 16, -15)
    frame.selectedQuestName:SetPoint("RIGHT", -48, 0)
    frame.selectedQuestName:SetJustifyH("LEFT")
    ApplyQuestFont(frame.selectedQuestName, "QuestTitleFont", "QuestFont")
    frame.selectedQuestName:SetTextColor(1.00, 0.78, 0.16)
    frame.selectedQuestName:SetShadowColor(0, 0, 0, 0.82)
    frame.selectedQuestName:SetShadowOffset(1, -1)

    frame.selectedQuestComplete = questInset:CreateTexture(nil, "OVERLAY")
    frame.selectedQuestComplete:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
    frame.selectedQuestComplete:SetSize(24, 24)
    frame.selectedQuestComplete:SetPoint("TOPRIGHT", -16, -11)
    frame.selectedQuestComplete:Hide()
    -- Ready to hand in: the round ? (shows where) in place of the tick.
    if FDJ.CreateTurnInButton then
        frame.selectedQuestTurnIn = FDJ.CreateTurnInButton(questInset, 34)
        frame.selectedQuestTurnIn:SetPoint("CENTER", frame.selectedQuestComplete, "CENTER", 0, 0)
        frame.selectedQuestTurnIn:SetFrameLevel(questInset:GetFrameLevel() + 8)
    end

    frame.questShareButton = CreateFrame("Button", nil, questInset, "BackdropTemplate")
    frame.questShareButton:SetSize(76, 24)
    SetBackdrop(frame.questShareButton, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 12, 4)
    frame.questShareButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
    frame.questShareButton.text = frame.questShareButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.questShareButton.text:SetPoint("CENTER", 0, 0)
    frame.questShareButton.text:SetText(L("SHARE"))
    frame.questShareButton:SetScript("OnClick", function(self)
        if self._fdjShareEnabled and self.questID then
            FDJ.ShareQuestByID(self.questID)
        end
    end)
    frame.questShareButton:SetScript("OnEnter", function(self)
        if not self._fdjShareableQuest then
            -- Keep this button mouse-enabled instead of calling :Disable();
            -- disabled WoW buttons do not reliably receive OnEnter, so the
            -- grey state is visual while the red tooltip remains available.
            self:SetBackdropColor(0.22, 0.22, 0.22, 1.00)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(L("NOT_SHAREABLE"), 1.00, 0.15, 0.15)
            GameTooltip:Show()
            return
        end

        self:SetBackdropColor(0.13, 0.40, 0.19, 1.00)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L("SHAREABLE_QUEST"), 0.25, 1.00, 0.25)

        -- Chain-step restrictions describe who can receive the quest, so the
        -- note must remain visible even after the player accepts the quest.
        -- For ordinary shareable quests, only show the pickup reminder while
        -- the quest is not yet in the player's log.
        if self._fdjSameStepOnly then
            GameTooltip:AddLine(L("SHAREABLE_SAME_STEP"), 1.00, 1.00, 1.00, true)
        elseif not self._fdjShareEnabled then
            GameTooltip:AddLine(L("ACCEPT_TO_SHARE"), 1.00, 1.00, 1.00, true)
        end
        GameTooltip:Show()
    end)
    frame.questShareButton:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        FDJ.SetQuestShareButtonVisual(self, self._fdjShareableQuest, self._fdjShareEnabled)
    end)
    frame.questShareButton:Hide()

    frame.selectedQuestClass = questInset:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.selectedQuestClass:SetPoint("TOPRIGHT", -16, -18)
    frame.selectedQuestClass:SetWidth(118)
    frame.selectedQuestClass:SetJustifyH("RIGHT")
    frame.selectedQuestClass:SetShadowColor(0, 0, 0, 0.72)
    frame.selectedQuestClass:SetShadowOffset(1, -1)
    frame.selectedQuestClass:Hide()

    frame.selectedQuestClassIcon = questInset:CreateTexture(nil, "OVERLAY")
    frame.selectedQuestClassIcon:SetSize(27, 27)
    frame.selectedQuestClassIcon:SetPoint("TOP", frame.selectedQuestClass, "BOTTOM", 0, -3)
    frame.selectedQuestClassIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    frame.selectedQuestClassIcon:Hide()

    frame.selectedQuestMeta = questInset:CreateFontString(nil, "OVERLAY")
    frame.selectedQuestMeta:SetPoint("TOPLEFT", frame.selectedQuestName, "BOTTOMLEFT", 0, -5)
    frame.selectedQuestMeta:SetPoint("RIGHT", -16, 0)
    frame.selectedQuestMeta:SetJustifyH("LEFT")
    ApplyQuestFont(frame.selectedQuestMeta, "QuestFontNormalSmall", "GameFontHighlightSmall")

    -- Class quests also get the class icon on the metadata row, immediately
    -- after the Alliance/Horde faction icon(s). The existing class marker in
    -- the top-right remains intact.
    frame.selectedQuestMetaClassIcon = questInset:CreateTexture(nil, "OVERLAY")
    frame.selectedQuestMetaClassIcon:SetSize(24, 24)
    frame.selectedQuestMetaClassIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    frame.selectedQuestMetaClassIcon:Hide()

    local sep = questInset:CreateTexture(nil, "ARTWORK")
    frame.questHeaderSeparator = sep
    sep:SetTexture("Interface\\Buttons\\WHITE8X8")
    sep:SetPoint("TOPLEFT", 14, -58)
    sep:SetPoint("TOPRIGHT", -14, -58)
    sep:SetHeight(1)
    sep:SetColorTexture(0.45, 0.35, 0.20, 0.55)

    frame.questDetailScroll = CreateFrame(
        "ScrollFrame",
        "ForeverDungeonJournalQuestDetailScroll",
        questInset,
        "UIPanelScrollFrameTemplate"
    )
    frame.questDetailScroll:SetPoint("TOPLEFT", 16, -72)
    frame.questDetailScroll:SetPoint("BOTTOMRIGHT", -31, 16)

    frame.questDetailContent = CreateFrame("Frame", nil, frame.questDetailScroll)
    frame.questDetailContent:SetSize(380, 1)
    frame.questDetailScroll:SetScrollChild(frame.questDetailContent)
    frame.questDetailScroll:HookScript("OnVerticalScroll", function(self, offset)
        if FDJ._restoringQuestDetailScroll then return end
        local key = FDJ._questDetailPageKey
        if not key then return end
        local contentHeight = frame.questDetailContent and (frame.questDetailContent:GetHeight() or 0) or 0
        local viewportHeight = self:GetHeight() or 0
        local maxScroll = math.max(0, contentHeight - viewportHeight)
        local requested = offset or self:GetVerticalScroll() or 0
        local clamped = math.max(0, math.min(requested, maxScroll))
        if math.abs(clamped - requested) > 0.5 then
            FDJ._restoringQuestDetailScroll = true
            self:SetVerticalScroll(clamped)
            local scrollBar = GetScrollBar(self)
            if scrollBar then
                if scrollBar.SetMinMaxValues then scrollBar:SetMinMaxValues(0, maxScroll) end
                if scrollBar.SetValue then scrollBar:SetValue(clamped) end
            end
            FDJ._restoringQuestDetailScroll = nil
        end
        FDJ._questDetailScrollByPage = FDJ._questDetailScrollByPage or {}
        FDJ._questDetailScrollByPage[key] = clamped
    end)

    frame.questDetailText = frame.questDetailContent:CreateFontString(
        nil,
        "OVERLAY"
    )
    frame.questDetailText:SetPoint("TOPLEFT", 0, 0)
    frame.questDetailText:SetWidth(365)
    frame.questDetailText:SetJustifyH("LEFT")
    frame.questDetailText:SetJustifyV("TOP")
    frame.questDetailText:SetWordWrap(true)
    ApplyQuestFont(frame.questDetailText, "QuestFont", "GameFontHighlight")

    local function MakeQuestSectionHeader(label)
        local fs = frame.questDetailContent:CreateFontString(nil, "OVERLAY")

        -- Keep the Blizzard FontObject intact. Converting QuestFont to its raw
        -- font file with GetFont()/SetFont() strips Blizzard's locale glyph
        -- fallback on non-Russian clients, which turns Cyrillic section labels
        -- such as Цель / Начинается у / Сдать into square boxes. The normal
        -- black shadow keeps the header readable on parchment without breaking
        -- Russian (and remains safe when switching languages at runtime).
        ApplyQuestFont(fs, "QuestFont", "GameFontNormal")
        fs:SetText(label)
        fs:SetTextColor(1, 1, 1)
        fs:SetShadowColor(0, 0, 0, 1)
        fs:SetShadowOffset(1, -1)
        fs:SetJustifyH("LEFT")
        return fs
    end

    frame.questObjectiveHeader = MakeQuestSectionHeader(L("OBJECTIVE"))
    frame.questRequiredItemsHeader = MakeQuestSectionHeader(L("REQUIRED_ITEMS"))
    frame.questProvidedItemHeader = MakeQuestSectionHeader(L("PROVIDED_ITEM"))
    frame.questStartsHeader = MakeQuestSectionHeader(L("STARTS_AT"))
    frame.questTurninHeader = MakeQuestSectionHeader(L("TURN_IN"))
    frame.questNotesHeader = MakeQuestSectionHeader(L("NOTES"))
    frame.questRewardAlsoHeader = MakeQuestSectionHeader(L("ALSO_RECEIVE"))
    frame.questRewardAlsoHeader:Hide()
    frame.questDescHeader = MakeQuestSectionHeader(L("DESCRIPTION"))
    frame.questDescHeader:Hide()
    frame.questDescText = frame.questDetailContent:CreateFontString(nil, "OVERLAY")
    frame.questDescText:SetWidth(365)
    frame.questDescText:SetJustifyH("LEFT")
    frame.questDescText:SetJustifyV("TOP")
    frame.questDescText:SetWordWrap(true)
    ApplyQuestFont(frame.questDescText, "QuestFont", "GameFontHighlight")
    frame.questDescText:Hide()

    frame.questStartsText = frame.questDetailContent:CreateFontString(nil, "OVERLAY")
    frame.questStartsText:SetWidth(365)
    frame.questStartsText:SetJustifyH("LEFT")
    frame.questStartsText:SetJustifyV("TOP")
    frame.questStartsText:SetWordWrap(true)
    ApplyQuestFont(frame.questStartsText, "QuestFont", "GameFontHighlight")

    -- Item-start quests show the actual quest-start item instead of a map
    -- button. Hovering it gives the item tooltip plus the recorded drop source.
    frame.questStartItemButton = CreateFrame("Button", nil, frame.questDetailContent, "BackdropTemplate")
    frame.questStartItemButton:SetSize(230, 38)
    SetBackdrop(frame.questStartItemButton, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 9, 2)
    frame.questStartItemButton.icon = frame.questStartItemButton:CreateTexture(nil, "ARTWORK")
    frame.questStartItemButton.icon:SetSize(28, 28)
    frame.questStartItemButton.icon:SetPoint("LEFT", 6, 0)
    frame.questStartItemButton.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    frame.questStartItemButton.name = frame.questStartItemButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.questStartItemButton.name:SetPoint("LEFT", frame.questStartItemButton.icon, "RIGHT", 8, 0)
    frame.questStartItemButton.name:SetPoint("RIGHT", -6, 0)
    frame.questStartItemButton.name:SetJustifyH("LEFT")
    frame.questStartItemButton:SetScript("OnEnter", function(self)
        if self.item then
            ShowItemTooltip(self)
        elseif self.fdjObject then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(self.fdjObject[1], 1, 1, 1)
            if self.fdjObject[2] and self.fdjObject[2] ~= "" then
                GameTooltip:AddLine(self.fdjObject[2], 1.00, 0.82, 0.00, true)
            end
            GameTooltip:Show()
        end
    end)
    frame.questStartItemButton:SetScript("OnLeave", function(self)
        self.fdjComparing = nil
        if not self.item and GameTooltip:IsOwned(self) then GameTooltip:Hide() end
        if itemTooltip then itemTooltip:Hide() end
        HideComparisonTooltips()
    end)
    frame.questStartItemButton:SetScript("OnClick", function(self)
        if not self.item then return end

        local _, link = ItemInfo(self.item[1])
        if link and IsModifiedClick and IsModifiedClick("CHATLINK") and ChatEdit_InsertLink then
            ChatEdit_InsertLink(link)
            return
        end

        -- Normal click keeps the tooltip open and includes the custom source
        -- line (drop NPC/location) for world/dungeon quest-start items.
        ShowItemTooltip(self)
    end)
    frame.questStartItemButton:Hide()

    frame.questRequiredItemButton = MakeQuestRewardButton(frame.questDetailContent)
    frame.questRequiredItemButton:SetSize(230, 46)
    frame.questRequiredItemButton:Hide()
    frame.questRequiredItemsHeader:Hide()
    frame.questProvidedItemHeader:Hide()

    frame.questStartDungeonIcon = CreateFrame("Button", nil, frame.questDetailContent)
    frame.questStartDungeonIcon:SetSize(26, 26)
    frame.questStartDungeonIcon.icon = frame.questStartDungeonIcon:CreateTexture(nil, "ARTWORK")
    frame.questStartDungeonIcon.icon:SetAllPoints()
    local questDungeonAtlasOK = false
    if frame.questStartDungeonIcon.icon.SetAtlas then
        questDungeonAtlasOK = pcall(frame.questStartDungeonIcon.icon.SetAtlas, frame.questStartDungeonIcon.icon, "Dungeon", false)
    end
    if not questDungeonAtlasOK then
        frame.questStartDungeonIcon.icon:SetTexture("Interface\\Icons\\INV_Misc_Rune_01")
        frame.questStartDungeonIcon.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    frame.questStartDungeonIcon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    frame.questStartDungeonIcon:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L("IN_DUNGEON"))
        GameTooltip:Show()
    end)
    frame.questStartDungeonIcon:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.questStartDungeonIcon:Hide()

    frame.questNotesText = frame.questDetailContent:CreateFontString(nil, "OVERLAY")
    frame.questNotesText:SetWidth(365)
    frame.questNotesText:SetJustifyH("LEFT")
    frame.questNotesText:SetJustifyV("TOP")
    frame.questNotesText:SetWordWrap(true)
    ApplyQuestFont(frame.questNotesText, "QuestFont", "GameFontHighlight")

    frame.questNoteItemButton = CreateFrame("Button", nil, frame.questDetailContent, "BackdropTemplate")
    frame.questNoteItemButton:SetSize(210, 34)
    SetBackdrop(frame.questNoteItemButton, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 9, 2)
    frame.questNoteItemButton.icon = frame.questNoteItemButton:CreateTexture(nil, "ARTWORK")
    frame.questNoteItemButton.icon:SetSize(26, 26)
    frame.questNoteItemButton.icon:SetPoint("LEFT", 5, 0)
    frame.questNoteItemButton.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    frame.questNoteItemButton.name = frame.questNoteItemButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.questNoteItemButton.name:SetPoint("LEFT", frame.questNoteItemButton.icon, "RIGHT", 7, 0)
    frame.questNoteItemButton.name:SetPoint("RIGHT", -6, 0)
    frame.questNoteItemButton.name:SetJustifyH("LEFT")
    frame.questNoteItemButton:SetScript("OnEnter", function(self)
        HideSearchItemHighlight(self)
        if self.item then ShowItemTooltip(self) end
    end)
    frame.questNoteItemButton:SetScript("OnLeave", function(self)
        self.fdjComparing = nil
        if itemTooltip then itemTooltip:Hide() end
        HideComparisonTooltips()
    end)
    frame.questNoteItemButton:SetScript("OnClick", function(self)
        if self.mapLocation then
            if itemTooltip then itemTooltip:Hide() end
            HideComparisonTooltips()
            if self.mapLocation.dungeon and FDJ.ShowQuestSpotOnDungeonMap then -- mapquests
                FDJ.ShowQuestSpotOnDungeonMap(self.mapLocation)
                return
            end
            ShowRecordedLocationOnMap(self.mapLocation, self.mapLocation.label)
            return
        end
    end)
    frame.questNoteItemButton:Hide()

    frame.noQuestMessage = questInset:CreateFontString(nil, "OVERLAY")
    frame.noQuestMessage:SetPoint("TOPLEFT", 16, -82)
    frame.noQuestMessage:SetPoint("RIGHT", -16, 0)
    frame.noQuestMessage:SetJustifyH("LEFT")
    frame.noQuestMessage:SetJustifyV("TOP")
    frame.noQuestMessage:SetWordWrap(true)
    ApplyQuestFont(frame.noQuestMessage, "QuestFont", "GameFontHighlight")
    frame.noQuestMessage:SetTextColor(0.10, 0.065, 0.025)
    frame.noQuestMessage:Hide()

    do
        local ok, button = pcall(CreateFrame, "Button", nil, frame.questDetailContent, "UIPanelButtonTemplate,InsecureActionButtonTemplate")
        if ok and button then
            frame.questMapButton = button
            frame.questMapButton._fdjCanTarget = true
        else
            frame.questMapButton = CreateFrame("Button", nil, frame.questDetailContent, "UIPanelButtonTemplate")
            frame.questMapButton._fdjCanTarget = false
        end
    end
    frame.questMapButton:SetSize(104, 24)
    frame.questMapButton:SetText(L("SHOW_ON_MAP"))
    frame.questMapButton.icon = frame.questMapButton:CreateTexture(nil, "OVERLAY")
    frame.questMapButton.icon:SetSize(17, 17)
    frame.questMapButton.icon:SetPoint("RIGHT", -7, 0)
    frame.questMapButton.icon:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon")
    frame.questMapButton.icon:Hide()
    frame.questMapButton:RegisterForClicks("LeftButtonUp")
    if frame.questMapButton._fdjCanTarget then
        frame.questMapButton:SetAttribute("useOnKeyDown", false)
    end
    local function QuestMapButtonOpenMap(self)
        local loc = self.prereqLocation or (self.quest and QUEST_START_MAPS[self.quest.id])
        -- Targeting and raid marking, when the quest giver is nearby, are handled
        -- by the secure hardware-click macro configured for this button.
        FDJ.pendingMarkerQuestTitle = self.fdjQuestTitle
        FDJ.pendingMarkerTurnIn = (self == frame.questTurninMapButton) or nil
        if self.prereqLocation then
            ShowRecordedLocationOnMap(self.prereqLocation, self.prereqLocation.label)
        else
            ShowQuestStartOnMap(self.quest)
        end
    end
    -- Keep the protected target/mark action intact, then open the map afterwards.
    if frame.questMapButton._fdjCanTarget then
        frame.questMapButton:SetScript("PostClick", QuestMapButtonOpenMap)
    else
        frame.questMapButton:SetScript("OnClick", QuestMapButtonOpenMap)
    end
    frame.questMapButton:SetScript("OnEnter", function(self)
        local loc = self.prereqLocation or (self.quest and QUEST_START_MAPS[self.quest.id])
        if FDJ.MapMarkers and FDJ.MapMarkers.ConfigureTargetAndMarkAction then
            -- Only auto-target/mark from Show on Map when the player is actually
            -- close to the recorded NPC. This avoids clearing a distant target.
            FDJ.MapMarkers.ConfigureTargetAndMarkAction(self, loc, true)
        end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L("SHOW_GIVER_ON_MAP"))
        GameTooltip:AddLine(L("MAP_TOOLTIP"), 1, 1, 1, true)
        GameTooltip:Show()
    end)
    frame.questMapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.questMapButton:Hide()

    -- Chain steps: "Show Turn In" under Turn in, next to "Show on Map" under
    -- Starts at, when the turn-in NPC stands somewhere else.
    do
        local ok, button = pcall(CreateFrame, "Button", nil, frame.questDetailContent, "UIPanelButtonTemplate,InsecureActionButtonTemplate")
        if ok and button then
            button._fdjCanTarget = true
        else
            button = CreateFrame("Button", nil, frame.questDetailContent, "UIPanelButtonTemplate")
            button._fdjCanTarget = false
        end
        frame.questTurninMapButton = button
        button:SetSize(120, 24)
        button.fdjLabelKey = "SHOW_TURN_IN"
        button:SetText(L("SHOW_TURN_IN"))
        button.icon = button:CreateTexture(nil, "OVERLAY")
        button.icon:SetSize(17, 17)
        button.icon:SetPoint("RIGHT", -7, 0)
        button.icon:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon")
        button:RegisterForClicks("LeftButtonUp")
        local openMap = frame.questMapButton:GetScript("PostClick") or frame.questMapButton:GetScript("OnClick")
        if button._fdjCanTarget then
            button:SetAttribute("useOnKeyDown", false)
            button:SetScript("PostClick", openMap)
        else
            button:SetScript("OnClick", openMap)
        end
        button:SetScript("OnEnter", frame.questMapButton:GetScript("OnEnter"))
        button:SetScript("OnLeave", frame.questMapButton:GetScript("OnLeave"))
        button:Hide()
    end

    frame.questChainButton = CreateFrame("Button", nil, frame.questDetailContent, "UIPanelButtonTemplate")
    frame.questChainButton:SetSize(132, 24)
    frame.questChainButton:SetText(L("SHOW_QUEST_CHAIN"))
    frame.questChainButton.icon = frame.questChainButton:CreateTexture(nil, "OVERLAY")
    frame.questChainButton.icon:SetSize(17, 17)
    frame.questChainButton.icon:SetPoint("RIGHT", -7, 0)
    frame.questChainButton.icon:SetTexture("Interface\\AddOns\\ForeverDungeonJournal\\Media\\QuestChain.tga")
    frame.questChainButton.icon:SetTexCoord(0, 1, 0, 1)
    do
        local fs = frame.questChainButton:GetFontString()
        if fs then
            fs:ClearAllPoints()
            fs:SetPoint("CENTER", frame.questChainButton, "CENTER", -9, 0)
        end
    end
    frame.questChainButton:SetScript("OnClick", function(self)
        local questID = self.questID
        local chain = questID and QUEST_PREREQ_CHAINS[questID]
        if not chain then return end

        -- The detail-panel "Show Quest Chain" button is OPEN/NAVIGATE only.
        -- It must never collapse an already-open chain. Collapsing is reserved
        -- exclusively for the small chain icon beside the quest in the left list.
        expandedQuestChains[questID] = true

        -- Open the step the player is currently on when possible. Otherwise
        -- open the first incomplete prerequisite; if every step is complete,
        -- open the final prerequisite.
        local target = nil
        for _, step in ipairs(chain) do
            if step.id and IsQuestInLog(step.id) then
                target = step
                break
            end
        end
        if not target then
            for _, step in ipairs(chain) do
                if not (step.id and IsQuestFinished(step.id)) then
                    target = step
                    break
                end
            end
        end
        if not target then
            target = chain[#chain] or chain[1]
        end

        selectedPrereqStep = target
        selectedPrereqParentQuestName = self.parentQuestName
        selectedPrereqParentQuestID = questID
        if target and target.id then RequestQuestRewardData(target.id) end

        RefreshQuestList()
        RefreshQuestDetail()
    end)
    frame.questChainButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L("REQUIRED_QUESTS"))
        GameTooltip:AddLine(L("OPEN_REQUIRED_CHAIN"), 1, 1, 1, true)
        GameTooltip:Show()
    end)
    frame.questChainButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
    frame.questChainButton:Hide()

    UpdateQuestActionButtonSizes()

    frame.questStartLinkButton = CreateFrame("Button", nil, frame.questDetailContent, "UIPanelButtonTemplate")
    frame.questStartLinkButton:SetSize(232, 24)
    frame.questStartLinkButton:SetScript("OnClick", function(self)
        if self.questID then SelectQuestByID(self.questID) end
    end)
    frame.questStartLinkButton:Hide()

    frame.questLeadsToButton = CreateFrame("Button", nil, frame.questDetailContent, "UIPanelButtonTemplate")
    frame.questLeadsToButton:SetSize(270, 24)
    frame.questLeadsToButton:SetScript("OnClick", function(self)
        if self.questID then SelectQuestByID(self.questID) end
    end)
    frame.questLeadsToButton:Hide()

    local function StyleQuestNavArrow(button, direction)
        local isLeft = direction == "LEFT"
        button:SetSize(28, 28)

        -- Use the same native Forever/Classic page arrows as the language control.
        local normal = isLeft and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"
        local pushed = isLeft and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down"
        local disabled = isLeft and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled"

        button:SetNormalTexture(normal)
        button:SetPushedTexture(pushed)
        button:SetDisabledTexture(disabled)

        local normalTex = button:GetNormalTexture()
        if normalTex then normalTex:SetAllPoints(button) end
        local pushedTex = button:GetPushedTexture()
        if pushedTex then pushedTex:SetAllPoints(button) end
        local disabledTex = button:GetDisabledTexture()
        if disabledTex then disabledTex:SetAllPoints(button) end

        local highlight = button:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
        highlight:SetBlendMode("ADD")
        highlight:SetAllPoints(button)
    end

    frame.questNextStepButton = CreateFrame("Button", nil, frame.questTextInset)
    frame.questNextStepButton:SetPoint("TOPRIGHT", frame.questTextInset, "TOPRIGHT", -12, -10)
    StyleQuestNavArrow(frame.questNextStepButton, "RIGHT")
    frame.questNextStepButton:SetScript("OnClick", function() SelectPrerequisiteStepByOffset(1) end)
    frame.questNextStepButton:Hide()

    frame.questPrevStepButton = CreateFrame("Button", nil, frame.questTextInset)
    frame.questPrevStepButton:SetPoint("RIGHT", frame.questNextStepButton, "LEFT", -5, 0)
    StyleQuestNavArrow(frame.questPrevStepButton, "LEFT")
    frame.questPrevStepButton:SetScript("OnClick", function() SelectPrerequisiteStepByOffset(-1) end)
    frame.questPrevStepButton:Hide()

    frame.questTurninText = frame.questDetailContent:CreateFontString(nil, "OVERLAY")
    frame.questTurninText:SetWidth(365)
    frame.questTurninText:SetJustifyH("LEFT")
    frame.questTurninText:SetJustifyV("TOP")
    frame.questTurninText:SetWordWrap(true)
    ApplyQuestFont(frame.questTurninText, "QuestFont", "GameFontHighlight")

    frame.questRewardHeader = frame.questDetailContent:CreateFontString(
        nil,
        "OVERLAY"
    )
    ApplyQuestFont(frame.questRewardHeader, "QuestTitleFont", "GameFontNormal")
    frame.questRewardHeader:SetTextColor(0.82, 0.52, 0.10)
    frame.questRewardHeader:SetShadowColor(0, 0, 0, 0.85)
    frame.questRewardHeader:SetShadowOffset(1, -1)
    frame.questRewardHeader:SetText(L("REWARDS"):upper())

    frame.questXPReward = CreateFrame("Frame", nil, frame.questDetailContent, "BackdropTemplate")
    frame.questXPReward:SetSize(116, 28)
    SetBackdrop(
        frame.questXPReward,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        9,
        2
    )
    frame.questXPReward:SetBackdropColor(0.26, 0.17, 0.42, 0.95)
    frame.questXPReward:SetBackdropBorderColor(0.45, 0.32, 0.62, 1)
    frame.questXPReward.badge = frame.questXPReward:CreateTexture(nil, "ARTWORK")
    frame.questXPReward.badge:SetTexture("Interface\\Buttons\\WHITE8X8")
    frame.questXPReward.badge:SetSize(22, 20)
    frame.questXPReward.badge:SetPoint("LEFT", 6, 0)
    frame.questXPReward.badge:SetColorTexture(0.45, 0.20, 0.80, 0.95)
    frame.questXPReward.badgeLabel = frame.questXPReward:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.questXPReward.badgeLabel:SetPoint("CENTER", frame.questXPReward.badge, "CENTER", 0, 0)
    frame.questXPReward.badgeLabel:SetText("XP")
    frame.questXPReward.badgeLabel:SetTextColor(1.00, 0.93, 0.50)
    frame.questXPReward.text = frame.questXPReward:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.questXPReward.text:SetPoint("LEFT", frame.questXPReward.badge, "RIGHT", 8, 0)
    frame.questXPReward.text:SetPoint("RIGHT", -8, 0)
    frame.questXPReward.text:SetJustifyH("LEFT")
    frame.questXPReward.text:SetTextColor(1, 1, 1)
    frame.questXPReward:Hide()

    -- Money reward, laid out beside XP like Blizzard's quest log.
    frame.questMoneyReward = CreateFrame("Frame", nil, frame.questDetailContent, "BackdropTemplate")
    frame.questMoneyReward:SetSize(72, 26)
    SetBackdrop(
        frame.questMoneyReward,
        "Interface\\Buttons\\WHITE8X8",
        "Interface\\Tooltips\\UI-Tooltip-Border",
        9,
        2
    )
    frame.questMoneyReward:SetBackdropColor(0.10, 0.07, 0.025, 0.94)
    frame.questMoneyReward:SetBackdropBorderColor(0.45, 0.30, 0.11, 1)
    frame.questMoneyReward.text = frame.questMoneyReward:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.questMoneyReward.text:SetPoint("LEFT", 6, 0)
    frame.questMoneyReward.text:SetPoint("RIGHT", -4, 0)
    frame.questMoneyReward.text:SetJustifyH("LEFT")
    frame.questMoneyReward.text:SetTextColor(1.00, 0.92, 0.72)
    frame.questMoneyReward:Hide()

    frame.questRewardSummary = frame.questDetailContent:CreateFontString(
        nil,
        "OVERLAY"
    )
    ApplyRewardSummaryFont(frame.questRewardSummary)
    frame.questRewardSummary:SetJustifyH("LEFT")
    frame.questRewardSummary:SetJustifyV("TOP")
    frame.questRewardSummary:SetWordWrap(true)

    -- Full-width interior dungeon map page. Ragefire Chasm is the first
    -- dungeon using it; other dungeons can opt in later with their own map data.
    frame.dungeonMapPanel = CreateFrame("Frame", nil, content, "BackdropTemplate")
    frame.dungeonMapPanel:SetPoint("TOPLEFT", 14, -84)
    frame.dungeonMapPanel:SetPoint("BOTTOMRIGHT", -14, 14)
    SetBackdrop(frame.dungeonMapPanel, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 12, 3)
    frame.dungeonMapPanel:SetBackdropColor(0.055, 0.04, 0.025, 0.98)
    frame.dungeonMapPanel:SetBackdropBorderColor(0.52, 0.34, 0.13, 1)
    if frame.dungeonMapPanel.SetClipsChildren then frame.dungeonMapPanel:SetClipsChildren(true) end

    frame.dungeonMapTitle = frame.dungeonMapPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.dungeonMapTitle:SetPoint("TOPLEFT", 20, -18)
    frame.dungeonMapTitle:SetTextColor(1.00, 0.82, 0.27)
    frame.dungeonMapTitle:Hide()

    frame.dungeonMapCanvas = CreateFrame("Frame", nil, frame.dungeonMapPanel, "BackdropTemplate")
    frame.dungeonMapCanvas:SetPoint("TOPLEFT", 12, -12)
    frame.dungeonMapCanvas:SetPoint("BOTTOMRIGHT", -12, 12)
    SetBackdrop(frame.dungeonMapCanvas, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 10, 2)
    frame.dungeonMapCanvas:SetBackdropColor(0.035, 0.025, 0.018, 0.96)
    frame.dungeonMapCanvas:SetBackdropBorderColor(0.43, 0.30, 0.14, 1)
    if frame.dungeonMapCanvas.SetClipsChildren then frame.dungeonMapCanvas:SetClipsChildren(true) end

    frame.dungeonMapArtHolder = CreateFrame("Frame", nil, frame.dungeonMapCanvas)
    frame.dungeonMapArtHolder:SetPoint("CENTER")
    frame.dungeonMapArtTiles = {}
    frame.dungeonMapBossMarkers = {}

    frame.dungeonMapPanel:Hide()

    -- Full-width travel guide page for faction-specific approaches.
    frame.routePanel = CreateFrame("Frame", nil, content, "BackdropTemplate")
    frame.routePanel:SetPoint("TOPLEFT", 14, -84)
    frame.routePanel:SetPoint("BOTTOMRIGHT", -14, 14)
    SetBackdrop(frame.routePanel, "Interface\\Buttons\\WHITE8X8", "Interface\\Tooltips\\UI-Tooltip-Border", 12, 3)
    frame.routePanel:SetBackdropColor(0.18, 0.13, 0.075, 0.98)
    frame.routePanel:SetBackdropBorderColor(0.52, 0.34, 0.13, 1)
    AddClassicParchment(frame.routePanel, 0.18, 1.00, 0.94, 0.82)

    frame.routeFactionIcon = frame.routePanel:CreateTexture(nil, "ARTWORK")
    frame.routeFactionIcon:SetSize(34, 34)
    frame.routeFactionIcon:SetPoint("TOPLEFT", 20, -18)
    frame.routeFactionIcon:SetTexture(ALLIANCE_ICON)

    frame.routeTitle = frame.routePanel:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.routeTitle:SetPoint("TOPLEFT", frame.routeFactionIcon, "TOPRIGHT", 10, -1)
    frame.routeTitle:SetPoint("RIGHT", -24, 0)
    frame.routeTitle:SetJustifyH("LEFT")
    frame.routeTitle:SetTextColor(1.00, 0.82, 0.27)

    frame.routeSubtitle = frame.routePanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    frame.routeSubtitle:SetPoint("TOPLEFT", frame.routeTitle, "BOTTOMLEFT", 0, -3)
    frame.routeSubtitle:SetTextColor(0.82, 0.82, 0.82)

    frame.routeBackButton = CreateFrame("Button", nil, frame.routePanel, "UIPanelButtonTemplate")
    frame.routeBackButton:SetSize(1, 1)
    frame.routeBackButton:Hide()

    frame.routeMapButton = CreateFrame("Button", nil, frame.routePanel, "UIPanelButtonTemplate")
    frame.routeMapButton:SetSize(142, 24)
    frame.routeMapButton:SetPoint("TOPRIGHT", -118, -20)
    frame.routeMapButton:SetText(L("SHOW_ON_MAP"))
    frame.routeMapButton:SetScript("OnClick", function()
        local dungeon = DB[selectedDungeon]
        local route = dungeon and dungeon.routeGuide
        if route and route.mapRoute and ShowRouteOnMap then
            ShowRouteOnMap(route.mapRoute)
        end
    end)
    frame.routeMapButton:Hide()

    local divider = frame.routePanel:CreateTexture(nil, "ARTWORK")
    divider:SetTexture("Interface\\Buttons\\WHITE8X8")
    divider:SetPoint("TOPLEFT", 20, -65)
    divider:SetPoint("TOPRIGHT", -20, -65)
    divider:SetHeight(1)
    divider:SetColorTexture(0.62, 0.43, 0.17, 0.65)

    frame.routeSteps = frame.routePanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.routeSteps:Hide()

    frame.routeStepScroll = CreateFrame("ScrollFrame", nil, frame.routePanel, "UIPanelScrollFrameTemplate")
    frame.routeStepScroll:SetPoint("TOPLEFT", 24, -80)
    frame.routeStepScroll:SetPoint("BOTTOMRIGHT", -34, 18)
    frame.routeStepContent = CreateFrame("Frame", nil, frame.routeStepScroll)
    frame.routeStepContent:SetSize(560, 1)
    frame.routeStepScroll:SetScrollChild(frame.routeStepContent)
    frame.routeStepContent:SetPoint("TOPLEFT", frame.routeStepScroll, "TOPLEFT", 0, 0)
    frame.routeStepScroll:SetScript("OnSizeChanged", function(self, width)
        if frame.routeStepContent and width and width > 20 then
            frame.routeStepContent:SetWidth(width - 6)
        end
    end)
    frame.routeStepRows = {}

    frame.routeShortcutTitle = frame.routePanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.routeShortcutTitle:SetPoint("TOPLEFT", 24, -285)
    frame.routeShortcutTitle:SetTextColor(0.45, 0.72, 1.00)
    frame.routeShortcutTitle:Hide()
    frame.routeShortcut = frame.routePanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    frame.routeShortcut:SetPoint("TOPLEFT", frame.routeShortcutTitle, "BOTTOMLEFT", 0, -5)
    frame.routeShortcut:SetPoint("RIGHT", -24, 0)
    frame.routeShortcut:SetJustifyH("LEFT")
    frame.routeShortcut:SetWordWrap(true)
    frame.routeShortcut:SetTextColor(0.88, 0.90, 0.95)
    frame.routeShortcut:Hide()

    frame.routeWarning = frame.routePanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    frame.routeWarning:SetPoint("BOTTOMLEFT", 24, 18)
    frame.routeWarning:SetPoint("RIGHT", -24, 0)
    frame.routeWarning:SetJustifyH("LEFT")
    frame.routeWarning:SetWordWrap(true)
    frame.routeWarning:SetTextColor(1.00, 0.62, 0.30)
    frame.routeWarning:Hide()
    frame.routePanel:Hide()

    questLeft:Hide()
    questRight:Hide()

    tinsert(UISpecialFrames, frame:GetName())

    -- Remember the tab the player came from so right-click can return to it.
    frame.bossesTab:SetScript("PreClick", function() frame.fdjPrevMode = selectedMode end)
    frame.questsTab:SetScript("PreClick", function() frame.fdjPrevMode = selectedMode end)

    frame:SetScript("OnShow", function()
        if FDJ.InstallRightClickBack then FDJ.InstallRightClickBack() end
        PlayJournalPaperSound()
        -- Warm the portraits once per session, on a later frame and never in
        -- combat: doing all of it inside OnShow can exceed the client's script
        -- time limit when the journal is opened mid-fight.
        if FDJ.PrewarmBossPortraits and not FDJ.portraitsPrewarmed then
            local function prewarm() pcall(FDJ.PrewarmBossPortraits) end
            if C_Timer and C_Timer.After then C_Timer.After(0.1, prewarm) else prewarm() end
        end

        -- If the player opens the journal while physically inside a dungeon,
        -- always jump straight to that dungeon's page. Outside an instance, keep
        -- the normal session behavior (last open dungeon, otherwise Home).
        local currentDungeon = CurrentDungeon()
        if currentDungeon and DB[currentDungeon] and not DB[currentDungeon].previewOnly then
            SelectDungeon(currentDungeon)
        elseif sessionLastView == "dungeon" and DB[selectedDungeon] then
            ShowDungeonPage()
            RefreshAll()
        else
            ShowHomePage()
        end
        -- Reopen on the map if that is where this dungeon was left.
        if FDJ.mapOpenForDungeon and frame.currentView == "dungeon" and FDJ.ReopenDungeonMap then
            FDJ.ReopenDungeonMap(FDJ.mapOpenForDungeon)
        end
    end)
    frame:SetScript("OnHide", function()
        -- The Favourites window is parented to UIParent so it can stay open
        -- while navigating inside the journal. When the journal itself closes,
        -- explicitly close the popup as well (including during combat).
        if frame and frame.favouritesWindow and frame.favouritesWindow:IsShown() then
            frame.favouritesWindow:Hide()
        end
        if FDJ.HideItemFavouriteMenu then FDJ.HideItemFavouriteMenu() end

        if frame and frame.currentView then
            sessionLastView = frame.currentView
        end
        FDJ.mapOpenForDungeon = nil
        if frame.currentView == "dungeon" and frame.dungeonMapPanel and frame.dungeonMapPanel:IsShown() and FDJ.GetSelectedDungeon then
            FDJ.mapOpenForDungeon = (FDJ.GetSelectedDungeon())
        end
        homeEditMode = false
        if frame.hideDungeonsButton then
            frame.hideDungeonsButton:SetBackdropColor(0.12, 0.115, 0.105, 0.98)
            frame.hideDungeonsButton:SetBackdropBorderColor(0.48, 0.40, 0.27, 1)
        end
        if frame.hideDungeonsButtonText then
            frame.hideDungeonsButtonText:SetText(L("HIDE_DUNGEONS"))
            frame.hideDungeonsButtonText:SetTextColor(1.00, 0.82, 0.27)
        end
        if frame.hideDungeonsDoneCheck then
            frame.hideDungeonsDoneCheck:Hide()
        end
        if ResetPortraitResolver then ResetPortraitResolver() end
    end)

    frame:Hide()
end

-- ============================================================
-- MINIMAP
-- ============================================================

FDJ._minimapUsingLibDBIcon = FDJ._minimapUsingLibDBIcon or false
FDJ._minimapIconLib = FDJ._minimapIconLib or nil
FDJ._minimapDataObject = FDJ._minimapDataObject or nil

local function PositionMinimap()
    if not minimapButton or not Minimap or FDJ._minimapUsingLibDBIcon then return end

    local angle = math.rad(ForeverDungeonJournalDB.minimapAngle or 225)
    local radius = (
        math.max(Minimap:GetWidth() or 140, Minimap:GetHeight() or 140) * 0.5
    ) + 8

    minimapButton:ClearAllPoints()
    minimapButton:SetPoint(
        "CENTER",
        Minimap,
        "CENTER",
        math.cos(angle) * radius,
        math.sin(angle) * radius
    )
end

local function ToggleJournal()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

FDJ.ToggleJournal = ToggleJournal
_G.ForeverDungeonJournal_Toggle = function()
    if FDJ.ToggleJournal then
        FDJ.ToggleJournal()
    end
end

local function HideMinimapButton()
    ForeverDungeonJournalDB.minimapHidden = true
    ForeverDungeonJournalDB.minimap = ForeverDungeonJournalDB.minimap or {}
    ForeverDungeonJournalDB.minimap.hide = true

    if FDJ._minimapUsingLibDBIcon and FDJ._minimapIconLib then
        FDJ._minimapIconLib:Hide("ForeverDungeonJournal")
    elseif minimapButton then
        minimapButton:Hide()
    end

    print("|cffd8a83cDungeonJournal|r " .. L("MINIMAP_HIDDEN"))
end

-- Right-clicking the minimap button asks first: many players hid it by accident.
FDJ.HideMinimapButton = HideMinimapButton
FDJ.ConfirmHideMinimapButton = function()
    if not StaticPopupDialogs or not StaticPopup_Show then
        HideMinimapButton()
        return
    end
    StaticPopupDialogs["FOREVERDUNGEONJOURNAL_HIDE_MINIMAP"] = {
        text = L("MINIMAP_HIDE_CONFIRM"),
        button1 = YES or "Yes",
        button2 = NO or "No",
        OnAccept = function() HideMinimapButton() end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("FOREVERDUNGEONJOURNAL_HIDE_MINIMAP")
end

function FDJ.ShowMinimapButton()
    ForeverDungeonJournalDB.minimapHidden = false
    ForeverDungeonJournalDB.minimap = ForeverDungeonJournalDB.minimap or {}
    ForeverDungeonJournalDB.minimap.hide = false

    if FDJ._minimapUsingLibDBIcon and FDJ._minimapIconLib then
        FDJ._minimapIconLib:Show("ForeverDungeonJournal")
        minimapButton = _G["LibDBIcon10_ForeverDungeonJournal"] or minimapButton
    elseif minimapButton then
        minimapButton:Show()
        PositionMinimap()
    end
end

function FDJ.SetupLibDBIconMinimap()
    if not _G.LibStub then return false end

    local ldb = _G.LibStub("LibDataBroker-1.1", true)
    local iconLib = _G.LibStub("LibDBIcon-1.0", true)
    if not ldb or not iconLib then return false end

    ForeverDungeonJournalDB.minimap = ForeverDungeonJournalDB.minimap or {}
    local db = ForeverDungeonJournalDB.minimap

    -- Migrate the old position once. LibDBIcon stores the same angular value in
    -- minimapPos, while the previous FDJ button used minimapAngle.
    if db.minimapPos == nil then
        db.minimapPos = ForeverDungeonJournalDB.minimapAngle or 225
    end
    db.hide = ForeverDungeonJournalDB.minimapHidden and true or false

    local object = ldb:GetDataObjectByName("ForeverDungeonJournal")
    if not object then
        object = ldb:NewDataObject("ForeverDungeonJournal", {
            type = "launcher",
            text = "DungeonJournal",
            icon = "Interface\\Icons\\INV_Misc_Book_09",
            OnClick = function(_, button)
                if button == "LeftButton" then
                    ToggleJournal()
                elseif button == "RightButton" then
                    if FDJ.ToggleSettingsPanel then FDJ.ToggleSettingsPanel() else FDJ.ConfirmHideMinimapButton() end
                end
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine("DungeonJournal", 1, 0.82, 0.25)
                tooltip:AddLine(L("MINIMAP_LEFT"), 1, 1, 1)
                tooltip:AddLine(L("MINIMAP_DRAG"), 0.8, 0.8, 0.8)
                tooltip:AddLine(L("MINIMAP_OPTIONS"), 0.8, 0.8, 0.8)
            end,
        })
    end

    FDJ._minimapDataObject = object
    FDJ._minimapIconLib = iconLib

    if not iconLib:IsRegistered("ForeverDungeonJournal") then
        iconLib:Register("ForeverDungeonJournal", object, db)
    end

    minimapButton = _G["LibDBIcon10_ForeverDungeonJournal"]
    if minimapButton then
        -- These fields are present on a normal LibDBIcon button and are also
        -- useful to minimap-button collectors that inspect the frame directly.
        minimapButton.dataObject = object
        minimapButton.db = db
    end

    FDJ._minimapUsingLibDBIcon = true

    if db.hide then
        iconLib:Hide("ForeverDungeonJournal")
    else
        iconLib:Show("ForeverDungeonJournal")
    end

    return true
end

-- While RPG Mode is on the minimap book turns white: the same book icon,
-- desaturated, with a brightening copy added on top (no extra image needed,
-- so it stays a crisp book at minimap size).
FDJ.UpdateMinimapIcon = function()
    local rpg = FDJ.IsRPGMode and FDJ.IsRPGMode() or false
    local book = "Interface\\Icons\\INV_Misc_Book_09"
    if FDJ._minimapDataObject and FDJ._minimapDataObject.icon ~= book then FDJ._minimapDataObject.icon = book end
    local button = _G["LibDBIcon10_ForeverDungeonJournal"]
    local icon = button and button.icon
    if not icon or not icon.SetDesaturated then return end
    icon:SetDesaturated(rpg)
    if not button.fdjWhite then
        local w = button:CreateTexture(nil, "ARTWORK", nil, 7)
        w:SetTexture(book)
        w:SetDesaturated(true)
        w:SetBlendMode("ADD")
        w:SetAlpha(0.6)
        button.fdjWhite = w
    end
    local w = button.fdjWhite
    w:ClearAllPoints()
    w:SetAllPoints(icon)
    if icon.GetTexCoord then w:SetTexCoord(icon:GetTexCoord()) end
    w:SetShown(rpg)
end

function FDJ.CreateFallbackMinimap()
    FDJ._minimapUsingLibDBIcon = false

    minimapButton = _G["LibDBIcon10_ForeverDungeonJournal"]
        or CreateFrame("Button", "LibDBIcon10_ForeverDungeonJournal", Minimap)

    minimapButton:SetParent(Minimap)
    minimapButton:SetSize(31, 31)
    minimapButton:SetFrameStrata("MEDIUM")
    minimapButton:SetFrameLevel((Minimap:GetFrameLevel() or 0) + 8)
    minimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    minimapButton:RegisterForDrag("LeftButton")

    -- Match the public shape of a normal LibDBIcon button as closely as possible
    -- for collectors even when no shared LibDBIcon library is available.
    ForeverDungeonJournalDB.minimap = ForeverDungeonJournalDB.minimap or {}
    minimapButton.db = ForeverDungeonJournalDB.minimap
    minimapButton.dataObject = minimapButton.dataObject or {
        type = "launcher",
        text = "DungeonJournal",
        icon = "Interface\\Icons\\INV_Misc_Book_09",
    }

    if not minimapButton.fdjInitialized then
        local bg = minimapButton:CreateTexture(nil, "BACKGROUND")
        bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
        bg:SetSize(20, 20)
        bg:SetPoint("CENTER")

        local icon = minimapButton:CreateTexture(nil, "ARTWORK")
        icon:SetTexture("Interface\\Icons\\INV_Misc_Book_09")
        icon:SetSize(20, 20)
        icon:SetPoint("CENTER")
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        minimapButton.icon = icon

        local border = minimapButton:CreateTexture(nil, "OVERLAY")
        border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
        border:SetSize(54, 54)
        border:SetPoint("TOPLEFT", -1, 1)
        minimapButton.border = border

        minimapButton:SetScript("OnClick", function(_, button)
            if button == "LeftButton" then
                ToggleJournal()
            elseif button == "RightButton" then
                if FDJ.ToggleSettingsPanel then FDJ.ToggleSettingsPanel() else FDJ.ConfirmHideMinimapButton() end
            end
        end)

        minimapButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            GameTooltip:AddLine("DungeonJournal", 1, 0.82, 0.25)
            GameTooltip:AddLine(L("MINIMAP_LEFT"), 1, 1, 1)
            GameTooltip:AddLine(L("MINIMAP_DRAG"), 0.8, 0.8, 0.8)
            GameTooltip:AddLine(L("MINIMAP_OPTIONS"), 0.8, 0.8, 0.8)
            GameTooltip:Show()
        end)

        minimapButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        minimapButton:SetScript("OnDragStart", function(self)
            self:SetScript("OnUpdate", function()
                local mx, my = Minimap:GetCenter()
                if not mx or not my then return end

                local x, y = GetCursorPosition()
                local scale = UIParent:GetEffectiveScale()
                x, y = x / scale, y / scale

                ForeverDungeonJournalDB.minimapAngle =
                    math.deg(math.atan2(y - my, x - mx))

                PositionMinimap()
            end)
        end)

        minimapButton:SetScript("OnDragStop", function(self)
            self:SetScript("OnUpdate", nil)
        end)

        minimapButton.fdjInitialized = true
    end

    PositionMinimap()

    if ForeverDungeonJournalDB.minimapHidden then
        minimapButton:Hide()
    else
        minimapButton:Show()
    end
end

function FDJ.CreateMinimap()
    -- Prefer the real shared LibDataBroker/LibDBIcon libraries when another
    -- enabled addon (including Leatrix Plus) provides them. This makes FDJ a
    -- genuinely registered LibDBIcon launcher instead of only imitating the
    -- frame name, which is required by collectors that use the library registry.
    if FDJ.SetupLibDBIconMinimap() then
        return
    end

    -- Keep a standalone fallback so FDJ still has a minimap button when no
    -- broker/icon library exists in the user's addon set.
    FDJ.CreateFallbackMinimap()
end

-- ============================================================
-- COMMANDS / EVENTS
-- ============================================================

SLASH_FOREVERDUNGEONJOURNAL1 = "/dj"
SLASH_FOREVERDUNGEONJOURNAL2 = nil

SlashCmdList.FOREVERDUNGEONJOURNAL = function(msg)
    msg = strtrim(msg or ""):lower()

    if msg == "lang" or msg == "language" then
        local active = FDJ.GetLanguage and FDJ.GetLanguage() or "enUS"
        local saved = ForeverDungeonJournalDB.language or "auto"
        local display = saved == "auto" and L("LANGUAGE_AUTO", active) or active
        print("|cffd8a83cDungeonJournal|r " .. L("LANGUAGE_CURRENT", display))
        print("|cffd8a83cDungeonJournal|r " .. L("LANGUAGE_HELP"))
        return
    end

    local langArg = msg:match("^lang%s+(%S+)$") or msg:match("^language%s+(%S+)$")
    if langArg then
        ApplySelectedLanguage(langArg)
        local active, saved = FDJ.SetLanguage(langArg)
        local display = saved == "auto" and L("LANGUAGE_AUTO", active) or active
        print("|cffd8a83cDungeonJournal|r " .. L("LANGUAGE_SET", display))
        return
    end

    if msg:match("^wing") then
        local wing = FDJ.ScarletWingFromWord and FDJ.ScarletWingFromWord(msg:match("^wing%s+(%S+)") or "")
        if wing and FDJ.SetScarletWing and FDJ.SetScarletWing(wing) then
            print("|cffffd100Dungeon Journal|r " .. wing)
        else
            print("|cffffd100Dungeon Journal|r /dj wing graveyard  |  /dj wing library")
        end
        return
    end
    if msg == "options" or msg == "settings" or msg == "config" then
        if FDJ.ToggleSettingsPanel then FDJ.ToggleSettingsPanel() end
        return
    end
    if msg == "newids" then
        if FDJ.PrintLearnedItemIDs then FDJ.PrintLearnedItemIDs() end
        return
    end
    if msg == "itemtip" then
        local on = FDJ.ToggleItemSourceStrip and FDJ.ToggleItemSourceStrip()
        print("|cffffd100Dungeon Journal|r item source on tooltips: " .. (on and "ON" or "OFF"))
        return
    end
    if msg == "mode" then
        if FDJ.ShowModeChooser then FDJ.ShowModeChooser(true) end
        return
    end
    if msg == "worldmap" then
        local on = FDJ.ToggleWorldMapOverlay and FDJ.ToggleWorldMapOverlay()
        print("|cffd8a83cDungeonJournal|r " .. L("WM_DUNGEON_MAP") .. " (M): " .. (on and "ON" or "OFF"))
        return
    end

    if msg:match("^scale") then
        local value = tonumber(msg:match("^scale%s+([%d%.]+)"))
        local scale = FDJ.SetJournalScale and FDJ.SetJournalScale(value or 1)
        print("|cffd8a83cDungeonJournal|r scale: " .. tostring(scale))
        return
    end

    if msg == "minimap" then
        FDJ.ShowMinimapButton()
        return
    end

    if msg == "rfc" or msg == "ragefire" or msg == "ragefirechasm" then
        frame:Show()
        SelectDungeon("Ragefire Chasm")
        return
    end

    if msg == "hall" or msg == "hot" then
        frame:Show()
        SelectDungeon("Hall of Thanes")
        return
    end

    if msg == "dm" or msg == "vc" or msg == "deadmines" then
        frame:Show()
        SelectDungeon("The Deadmines")
        return
    end

    if msg == "ruins" or msg == "rol" or msg == "lordaeron" then
        frame:Show()
        SelectDungeon("Ruins of Lordaeron")
        return
    end

    if msg == "wc" or msg == "wailing" or msg == "wailingcaverns" then
        frame:Show()
        SelectDungeon("Wailing Caverns")
        return
    end

    if msg == "sfk" or msg == "shadowfang" or msg == "shadowfangkeep" then
        frame:Show()
        SelectDungeon("Shadowfang Keep")
        return
    end

    if msg == "bfd" or msg == "blackfathom" or msg == "blackfathomdeeps" or msg == "blackfathomdepths" then
        frame:Show()
        SelectDungeon("Blackfathom Deeps")
        return
    end

    -- Shortcuts for the dungeons added later (/dj smlib, /dj gnomer, ...).
    do
        local shortcuts = {
            stocks = "The Stockade", stockade = "The Stockade", stockades = "The Stockade",
            gnomer = "Gnomeregan", gnomeregan = "Gnomeregan",
            rfk = "Razorfen Kraul", kraul = "Razorfen Kraul", razorfenkraul = "Razorfen Kraul",
            dala = "City of Dalaran", dal = "City of Dalaran", dalaran = "City of Dalaran", cityofdalaran = "City of Dalaran",
            exca = "Excavation Site: Wetlands", excavation = "Excavation Site: Wetlands", wetlands = "Excavation Site: Wetlands",
            smgy = "Scarlet Monastery: Graveyard", gy = "Scarlet Monastery: Graveyard", graveyard = "Scarlet Monastery: Graveyard",
            smlib = "Scarlet Monastery: Library", lib = "Scarlet Monastery: Library", library = "Scarlet Monastery: Library",
            smarm = "Scarlet Monastery: Armory", arm = "Scarlet Monastery: Armory", armory = "Scarlet Monastery: Armory",
            smcath = "Scarlet Monastery: Cathedral", cath = "Scarlet Monastery: Cathedral", cathedral = "Scarlet Monastery: Cathedral",
            rfd = "Razorfen Downs", downs = "Razorfen Downs", razorfendowns = "Razorfen Downs",
            ulda = "Uldaman", uld = "Uldaman", uldaman = "Uldaman",
            zf = "Zul'Farrak", zulfarrak = "Zul'Farrak",
            st = "Sunken Temple", sunken = "Sunken Temple", sunkentemple = "Sunken Temple",
            scholo = "Scholomance", scholomance = "Scholomance", mara = "Maraudon", maraudon = "Maraudon",
            brd = "Blackrock Depths", depths = "Blackrock Depths", blackrockdepths = "Blackrock Depths",
            ubrs = "Upper Blackrock Spire", upperspire = "Upper Blackrock Spire",
            lbrs = "Lower Blackrock Spire", lowerspire = "Lower Blackrock Spire",
            dme = "Dire Maul: East", dmeast = "Dire Maul: East", dmw = "Dire Maul: West", dmwest = "Dire Maul: West",
            dmn = "Dire Maul: North", dmnorth = "Dire Maul: North", tribute = "Dire Maul: North",
            strat = "Stratholme: Living", stratlive = "Stratholme: Living", stratliving = "Stratholme: Living",
            stratud = "Stratholme: Undead", stratundead = "Stratholme: Undead", baron = "Stratholme: Undead",
        }
        local key = msg:gsub("[%s:%-']", "")
        local target = shortcuts[key]
        if target and DB[target] then
            frame:Show()
            SelectDungeon(target)
            return
        end
    end

    ToggleJournal()
end

FDJ.events = FDJ.events or CreateFrame("Frame")
FDJ.events:RegisterEvent("PLAYER_LOGIN")
FDJ.events:RegisterEvent("PLAYER_LEAVING_WORLD")
FDJ.events:RegisterEvent("PLAYER_ENTERING_WORLD")
FDJ.events:RegisterEvent("ZONE_CHANGED_NEW_AREA")
FDJ.events:RegisterEvent("QUEST_LOG_UPDATE")
FDJ.events:RegisterEvent("QUEST_TURNED_IN")
FDJ.events:RegisterEvent("QUEST_ACCEPTED")
FDJ.events:RegisterEvent("QUEST_REMOVED")
FDJ.events:RegisterEvent("QUEST_DATA_LOAD_RESULT")
FDJ.events:RegisterEvent("PLAYER_LEVEL_UP")
FDJ.events:RegisterEvent("GET_ITEM_INFO_RECEIVED")

-- Coalesce event bursts and refresh on the next frame, outside API callbacks.
FDJ.questRefreshPending = false
FDJ.questRefreshWorker = FDJ.questRefreshWorker or CreateFrame("Frame")
FDJ.questRefreshWorker:Hide()
function FDJ.ScheduleQuestRefresh()
    if FDJ.questRefreshPending then return end
    FDJ.questRefreshPending = true
    FDJ.questRefreshWorker:SetScript("OnUpdate", function(self)
        self:SetScript("OnUpdate", nil)
        self:Hide()
        FDJ.questRefreshPending = false
        if frame and frame:IsShown() then
            if frame.currentView == "home" then
                RefreshHomeDungeonCards()
            elseif selectedMode == "quests" then
                RefreshQuestList()
                RefreshQuestDetail()
            end
        end
    end)
    FDJ.questRefreshWorker:Show()
end

-- rpgpartial: something revealed (RPG Mode): redraw the open page.
function FDJ.RefreshRPGPage()
    if not frame or not frame:IsShown() or frame.currentView == "home" then return end
    if not selectedDungeon or not DB[selectedDungeon] then return end
    if FDJ.IsDungeonLocked and FDJ.IsDungeonLocked(selectedDungeon) then return end
    UpdateModeTabs()
    if selectedMode == "quests" then
        RefreshQuestList()
        RefreshQuestDetail()
    else
        RefreshBossList()
        RefreshLoot()
    end
end

FDJ.events:SetScript("OnEvent", function(_, event, arg1, arg2)
    local questID, success = arg1, arg2
    if event == "PLAYER_LOGIN" then
        -- SavedVariables load after this file runs, so the display-ID cache
        -- captured at load time was a throwaway table. Rebind it to the real
        -- saved table so resolved portraits persist between sessions.
        ForeverDungeonJournalDB.displayIDs = ForeverDungeonJournalDB.displayIDs or {}
        if displayIDCache ~= ForeverDungeonJournalDB.displayIDs then
            for k, v in pairs(displayIDCache) do
                if ForeverDungeonJournalDB.displayIDs[k] == nil then ForeverDungeonJournalDB.displayIDs[k] = v end
            end
            displayIDCache = ForeverDungeonJournalDB.displayIDs
        end
        if UnitFactionGroup then
            local playerFaction = UnitFactionGroup("player")
            if playerFaction == "Horde" then
                selectedQuestFaction = "Horde"
            elseif playerFaction == "Alliance" then
                selectedQuestFaction = "Alliance"
            end
            ForeverDungeonJournalDB.questFaction = selectedQuestFaction
        end

        ScanEncounterJournal()
        CreateItemTooltip()
        CreateMainFrame()
        FDJ.CreateMinimap()

        -- Boss portraits use journal data or numeric NPC-ID display resolution; no live unit-string parsing.

        RefreshAll()

        local addonVersion
        if C_AddOns and C_AddOns.GetAddOnMetadata then
            addonVersion = C_AddOns.GetAddOnMetadata("ForeverDungeonJournal", "Version")
        elseif GetAddOnMetadata then
            addonVersion = GetAddOnMetadata("ForeverDungeonJournal", "Version")
        end
        addonVersion = (addonVersion and tostring(addonVersion)) or "1.7.1"
        print("|cffd8a83cDungeon Journal by Exehn|r |cffffffffv" .. addonVersion .. "|r")
        return
    end

    if event == "PLAYER_LEAVING_WORLD" then
        -- No portrait work during zoning: the warm-up and the lookups wait.
        FDJ.portraitZoning = true
        FDJ.portraitZoneSerial = (FDJ.portraitZoneSerial or 0) + 1
        return
    end

    if event == "QUEST_DATA_LOAD_RESULT" then
        if not questDataRequests[questID] then return end
        questDataRequests[questID] = success == false
            and {state = "failed", retryAt = (GetTime and GetTime() or 0) + 30}
            or {state = "loaded"}
        FDJ.ScheduleQuestRefresh()
        return
    end

    if event == "GET_ITEM_INFO_RECEIVED" then
        if itemTooltipQualityCache and questID then
            itemTooltipQualityCache[questID] = nil
        end
        if frame and frame:IsShown() then
            if selectedMode == "bosses" then
                RefreshLoot()
            elseif selectedMode == "quests" then
                RefreshQuestDetail()
                ApplyLocaleFontTree(frame)
            end
            -- Forever custom-item metadata may become available after the
            -- search dropdown was already built. Refresh it in-place so names
            -- and icons update without making the player retype the query.
            if frame.RefreshSearchResults and frame.searchEditBox
                and frame.searchResultsFrame and frame.searchResultsFrame:IsShown() then
                frame.RefreshSearchResults(frame.searchEditBox:GetText() or "", true)
            end
        end
        return
    end

    if event == "QUEST_LOG_UPDATE"
        or event == "QUEST_TURNED_IN"
        or event == "QUEST_ACCEPTED"
        or event == "QUEST_REMOVED"
        or event == "PLAYER_LEVEL_UP"
    then
        FDJ.ScheduleQuestRefresh()
        return
    end

    if event == "PLAYER_ENTERING_WORLD" then
        -- Keep the loading transition clean: no hidden tooltip scans and no
        -- model work synchronously on PLAYER_ENTERING_WORLD. Select the
        -- current dungeon immediately, but refresh visible UI only after the
        -- world has settled.
        local current = CurrentDungeon()
        if current and DB[current] then
            selectedDungeon = current
            ForeverDungeonJournalDB.lastDungeon = current
            if selectedBoss > #DB[current].bosses then
                selectedBoss = 1
                ForeverDungeonJournalDB.lastBoss = 1
            end
        end

        if C_Timer and type(C_Timer.After) == "function" then
            C_Timer.After(2.25, function()
                if frame and frame:IsShown() then
                    RefreshAll()
                end
            end)
            -- Portrait work resumes once the world has settled; the first
            -- time, the warm-up starts a few seconds later.
            local serial = FDJ.portraitZoneSerial
            C_Timer.After(2, function()
                if FDJ.portraitZoneSerial ~= serial then return end
                FDJ.portraitZoning = false
                if portraitResolver and #portraitResolveQueue > 0 then portraitResolver:Show() end
            end)
            if not FDJ.portraitsPrewarmed then
                C_Timer.After(6, function()
                    if FDJ.PrewarmBossPortraits then pcall(FDJ.PrewarmBossPortraits) end
                end)
            end
        end
        return
    end

    local current = CurrentDungeon()

    if current and DB[current] then
        selectedDungeon = current
        ForeverDungeonJournalDB.lastDungeon = current

        if selectedBoss > #DB[current].bosses then
            selectedBoss = 1
            ForeverDungeonJournalDB.lastBoss = 1
        end

        if frame and frame:IsShown() then
            RefreshAll()
        end
    end
end)
