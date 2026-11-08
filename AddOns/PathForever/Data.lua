-- Data.lua
-- Reference data for PathForever - dungeons, zones, and profession pacing.
-- Nothing here is pulled live from the server; it's static data that gets
-- updated as things are confirmed in-game or against a source. Read this
-- top-to-bottom once, then check the [SOURCE ...] tag directly above each
-- dungeon's own block for where THAT dungeon's data came from and how
-- current it is - that's the fast way back in after time away.
--
-- ---- Q() - quest entries -------------------------------------------
-- Q(name, id, faction, extra)
--   id      : real Wowhead quest ID (see "ID policy" below - never guess)
--   faction : nil (both factions), "Alliance", or "Horde"
--   extra   : optional table - level, requires, xp, pickup, pickupZone,
--             turnin, turninZone, mapID, x, y, chainStart, key
--     key      = a sentence for a quest that opens the way into the dungeon or
--                an attunement ("Part of the key to City of Dalaran"): the quest
--                list shows a key after its name with this as its tooltip.
--     level    = the quest's displayed/recommended level
--     requires = the actual minimum level you can obtain it at (these two
--                differ - see UI.lua's "Obtainable at" / "Quest level"
--                lines, don't collapse them back into one field). The quest
--                list's "Quest Available" / "Not available" status is judged
--                on this; without it the dungeon's levelMin stands in.
--     xp         = the full XP the quest gives (a character 6+ levels above
--                  the quest gets less). On Wowhead it's base xp x Forever's
--                  multiplier (`setupScalingRewards` on the quest page), and
--                  the game shows it rounded to the nearest 50.
--                  Forever's 2026-10-01 patch halved the bonus part (the
--                  multiplier above 1): x2.9 became x1.95, so the new XP is
--                  base x (1 + (multiplier - 1) / 2), rounded to 50. Patch
--                  notes said "50% decrease in the bonus xp"; it matches the
--                  three quests seen in game at level 20 (Serpentbloom 3300,
--                  Deviate Hides 3100, In Nightmares 2000 at x1) and Excavation
--                  Site's new quests (x1.95 and x2.2). Wowhead's older quests
--                  still showed the old multipliers on 2026-10-02, so their
--                  values here were worked out with that formula.
--     class      = nil (every class), a class token ("WARLOCK"), or a list of
--                  tokens ({ "WARRIOR", "PALADIN" }): only those classes see
--                  the quest. From the "Class:" line on its Wowhead page.
--     part       = "1 of 2" for quests the game gives the same name, as steps of
--                  one chain (Allegiance to the Old Gods): shown on the row and
--                  in the panel so the two don't read as a duplicate.
--     races      = nil (every race of its faction) or a list of race IDs, as
--                  UnitRace's third return and Wowhead's [race=N]: 1 Human,
--                  2 Orc, 3 Dwarf, 4 Night Elf, 5 Undead, 6 Tauren, 7 Gnome,
--                  8 Troll. Only set when it really leaves a race out (Compendium
--                  of the Fallen: not Undead); a class quest's usual races are not.
--     pickup     = free text: who/what starts it and where
--     pickupZone = the zone (or city, or dungeon) it starts in, exactly as
--                  the game names it - shown as "Pick up in <zone>". Only
--                  set it from a source; nil shows nothing.
--     turninZone = where it's turned in (the End NPC's zone on the quest's
--                  wowhead.com/forever page) - shown as "Complete in <zone>"
--                  while the quest is in your log. nil shows nothing.
--     mapID/x/y = 0-1 normalized map coordinates for the "show on map"
--                 pin (see ShowQuestOnMap in UI.lua)
--     chainStart = { name = "...", pickup = "...", zone = "..." } - for a quest that's
--                a late link in a longer prerequisite chain (example:
--                Leaders of the Fang in Wailing Caverns comes after
--                Hamuul Runetotem, from Tonga Runetotem in The Barrens),
--                the FIRST quest in that chain and where it starts. The
--                source is the quest's wowhead.com/forever "Series" table:
--                its first entry, with the zone from that quest's start
--                NPC (or start item). Every quest in the level-30 scope was
--                checked on 2026-09-29 (verified.chains); above that, nil
--                only means "not checked yet".
--
-- ---- Dungeon art (the `art` field on a dungeon) ---------------------
--   art       : FileDataID of the dungeon's loading-screen image, drawn faded
--               behind its row while the dungeon is relevant (see UI.lua,
--               ShowDungeonArt). Read from Forever's own Map -> LoadingScreens
--               DB2 tables (exported with wow.export from wow_classic_beta
--               1.60.1.70009, 2026-09-28): a Map row's LoadingScreenID leads to
--               a LoadingScreens row. Classic dungeons use its
--               NarrowScreenFileDataID (4:3 images); Forever-new ones use its
--               MainImageFileDataID (Forever's newer loading-screen style).
--   artAspect : the image's width / height (default 4 / 3, classic screens).
--               Forever's main images measure 2992 x 1684 (checked in wow.export
--               on 7963781, Hall of Thanes; the other three are the same style).
--   artY      : optional 0-1, which horizontal band of the image to show
--               (0 = top, 1 = bottom; default 0.5, the middle).
--   A dungeon without `art` simply shows none; /pf art lists every dungeon's.
--
-- ---- Boss portraits (npcID / displayID on a boss loot group) --------
--   npcID     : the boss's wowhead.com/forever NPC ID (found by exact name;
--               where Wowhead has two same-named NPCs in one dungeon, the
--               classic one - the high-numbered copy is a Season of
--               Discovery raid version, which Forever doesn't use).
--   displayID : its creature display ID, from that NPC page's model viewer.
--               UI.lua draws it with SetPortraitTextureFromCreatureDisplayID
--               as a square face left of the boss's name. nil = no portrait.
--   encounterID : the client's DungeonEncounter ID for the boss (research/db2/DungeonEncounter.csv),
--               which ENCOUNTER_END reports. Kill counts match on it first, then on the boss's name.
--               The client's encounter NAMES are internal and can be stale (Infurnus is Magmatus,
--               The Butcher is the Baron, Balnazzar is Grand Crusader Dathrohan), so the ID is what
--               makes those match. nil = not in the client's table (Excavation Site, ...): the name
--               is used. Never guess one; match by order or loot as in the daily-update skill.
--   tip       : one line for the boss's side panel, shown dim after "Classic tip:" under the loot.
--               Written in our own words from ForeverDB's Classic-tagged tips (mechanics only, no
--               numbers: Forever retuned encounters). nil = no tip. Never copied from another addon.
--
-- ---- Item() - loot entries ------------------------------------------
-- Item(name, slot, dropPct, id)
--   dropPct : drop chance as a whole number (16 = 16%), or nil if unknown
--   id      : real Wowhead item ID, or nil (same "never guess" policy)
--
-- ---- ID policy (applies to every id/questID/dropPct in this file) --
-- Every ID here is confirmed on wowhead.com/forever (or carried over from
-- the classic item database, whose IDs Forever keeps unchanged). A wrong ID
-- silently links to the WRONG real item or quest in-game - worse than no
-- link at all - so `id = nil` is a valid, intentional state, not a bug to
-- "complete." Never fill one in from memory or a guess.
--
-- WOWHEAD WINS. When sources disagree, wowhead.com/forever is taken as the
-- most accurate. Other addons are never a source for anything in this file.
--
-- ---- The sourcing methods in use ------------------------------------
-- 1. CLASSIC DUNGEONS: classic item/quest IDs carry over to Forever
--    unchanged (confirmed: Thrash Blade is item=17705 on both
--    wowhead.com/classic and wowhead.com/forever). The "wow-classic-items"
--    npm package (registry.npmjs.org) ships a full classic item database
--    with real IDs, bosses, and drop rates - install locally with
--    `npm install wow-classic-items`, data lands at
--    node_modules/wow-classic-items/data/json/data.json. This only covers
--    the CLASSIC baseline though - any Forever-specific additions on top
--    (new items, new quests) still need method #2.
-- 2. FOREVER-SPECIFIC: Wowhead's own Forever pages - a zone page's
--    comments section, or a "Dungeon Overview" guide where one exists
--    (both embed real item/quest IDs right in their URLs).
--    Quest rewards: the quest's own page lists them under "Rewards". A quest
--    in a chain often shares its name with later steps, and the reward is
--    on the LAST step (e.g. Hidden Enemies: the weapons are on 5730).
-- 3. PER-QUEST FACTS (level, requires, faction, pickup/turnin, pickupZone):
--    the quest's own wowhead.com/forever/quest=ID page. Its Quick Facts box
--    gives "Level", "Requires level", "Side" and the Start/End NPC; the NPC's
--    page says "This NPC can be found in <zone>". The page title doubles as
--    a check that the ID is the quest named here. Item/object starts often
--    have no zone on Wowhead - leave pickupZone nil rather than guess.
-- 4. BOSS LOOT IN FOREVER: wowtbc.gg/warcraftforever/loot-tables/dungeons/
--    lists each dungeon's bosses and their drops (Forever-new items marked
--    NEW), but no IDs. Use it for WHICH BOSS drops an item (Forever moved some,
--    e.g. the Deathsworn Captain now lives in Ruins of Lordaeron), then find
--    the ID by name on wowhead.com/forever and confirm name and slot there.
--    Wowhead also shows when an item was renamed (its search still finds the
--    old name): update the name here, never the ID.
--
-- ---- Level cap and verification flags -------------------------------
-- PathForeverData.LevelCap (bottom of this file) is the beta's player level
-- cap (60 since launch; it was 30 in the beta). While the "Show content above the level cap" option is off, dungeons
-- and zones that start above it, and quests that can't be picked up at or
-- below it, are hidden. Forever launches with a level cap of 60, so set it to
-- 60 at launch.
--
-- Dungeon level ranges (levelMin / levelMax) follow wowtbc.gg's WoW Forever
-- dungeon list (wowtbc.gg/warcraftforever/loot-tables/dungeons/, 2026-09-28).
-- They drive sorting, the dungeon art and "New quests available", so keep
-- them in step with that list.
--
-- A dungeon's lifecycle: `comingSoon = true` while it isn't in the game (listed
-- as Coming soon, not openable); `discovering = true` once it's live but its
-- quests and loot are still being recorded (shown and openable with whatever is
-- known; tools/coverage.lua reports it but the release gate skips it); neither
-- once its data is complete.
--
-- A dungeon may carry a `verified` table recording which parts have been
-- checked against a real source (a date string, or true). tools/coverage.lua
-- reads it, so a missing key means "not yet verified", never "assumed fine".
--   levelRange  the [min-max] range matches wowtbc.gg's Forever dungeon list
--               (or the Forever client itself, which wins if they differ)
--   bosses      the boss list and its order were checked against an
--               independent source
--   chains      every quest was checked for prerequisite quests (chainStart)
-- Update it in the same edit as the [SOURCE] tag above the dungeon.
--
-- ---- Quest eligibility (the `faction` argument) ---------------------
-- The best source is the quest's own wowhead.com/forever page ("Side:" in
-- Quick Facts; no Side means both). Every quest in a dungeon starting at or
-- below the level-30 cap was checked there on 2026-09-28; that pass found
-- Gnomeregan and Razorfen Kraul have quests for BOTH factions (they used to
-- be tagged as one-faction dungeons here), and fixed 19 quest tags.
-- Where a quest hasn't been checked yet: a single-faction dungeon's quests
-- carry that faction; otherwise a quest is tagged when the giver stands in
-- a faction capital or it's class-locked (Paladin = Alliance, Shaman =
-- Horde) in classic, and open-world/neutral givers are left shared.
--
-- ---- Updating after a Forever patch ---------------------------------
-- Classic-sourced data (the bulk of this file) is low-risk - Blizzard
-- patching Forever doesn't rewrite 20-year-old Classic data. Forever-
-- specific content (new items/quests layered on top) is what actually
-- moves during beta. If something looks wrong: check this dungeon's
-- [SOURCE] tag below, re-fetch from that same source rather than
-- re-researching from scratch, and update just that dungeon's tag + data.

PathForeverData = {}

local function Q(name, id, faction, extra)
    extra = extra or {}
    return {
        name = name, id = id, faction = faction, class = extra.class, races = extra.races, part = extra.part,
        level = extra.level, requires = extra.requires, xp = extra.xp,
        pickup = extra.pickup, pickupZone = extra.pickupZone, turnin = extra.turnin, turninZone = extra.turninZone,
        mapID = extra.mapID, x = extra.x, y = extra.y,
        chainStart = extra.chainStart, key = extra.key,
    }
end

local function Item(name, slot, dropPct, id)
    return { name = name, slot = slot, dropPct = dropPct, id = id }
end

-- ============================================================
-- DUNGEONS
-- ============================================================
PathForeverData.Dungeons = {

    -- New Forever dungeons
-- [SOURCE 2026-09-27] Wowhead Dungeon Overview guide (Forever-specific) + zone page comments. Fully verified: all quests, all boss loot, all quest rewards. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28.
    {
        name = "Hall of Thanes", art = 7963781, artAspect = 2992 / 1684, zone = "Dun Morogh (under Ironforge)",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        levelMin = 13, levelMax = 18, faction = "Alliance", status = "new",
        quests = {
            Q("Important Heirlooms", 96403, "Alliance", { level = 15, requires = 10, xp = 2950, pickup = "Thom Filch, by the bridge/vault entrance in Ironforge", pickupZone = "Ironforge", turnin = "Thom Filch, near the dungeon entrance", turninZone = "Ironforge" }),
            Q("The Restless Dead", 96394, "Alliance", { level = 15, requires = 10, xp = 2300, pickup = "Afadra Dunwall, Ironforge", pickupZone = "Ironforge", turnin = "Afadra Dunwall, Ironforge", turninZone = "Ironforge" }),
            Q("Old Ironforge Incursion", 96393, "Alliance", { level = 16, requires = 9, xp = 3200, pickup = "Earthseer Farsen, Dun Morogh (after the Underground Map)", pickupZone = "Dun Morogh", turnin = "King Magni Bronzebeard, Ironforge", turninZone = "Ironforge", chainStart = { name = "Underground Map", pickup = "Item start: Dark Iron Map, dropped by Dark Iron Spies and Captain Beld", zone = "Dun Morogh" } }),
            Q("The Treaty of Understanding", 98423, "Alliance", { level = 16, requires = 9, xp = 2550, pickup = "Stone tablet inside a vault in the Reliquary of Kings (Durgen Dirgehammer's room)", turnin = "King Magni Bronzebeard, Ironforge", turninZone = "Ironforge" }),
            Q("An Ancient Grudge", 96395, nil, { level = 15, requires = 10, xp = 2300, pickup = "Ghostly Attendant, inside Hall of Thanes, after the first room", pickupZone = "Hall of Thanes", turnin = "Ghostly Attendant, inside the dungeon", turninZone = "Hall of Thanes" }),
        },
        -- Item IDs verified 2026-09-26 via Wowhead's Hall of Thanes Dungeon
        -- Overview guide (wowhead.com/forever/guide/hall-of-thanes-dungeon-
        -- overview-location-rewards). That guide also confirmed only An
        -- Ancient Grudge and Important Heirlooms are open to both factions -
        -- everything else here is Alliance-only.
        lootGroups = {
            { title = "Faldrim Anvilmar", kind = "boss", encounterID = 3493, npcID = 261306, displayID = 142826, items = {
                Item("Ephemeral Choker", "Neck", nil, 270227),
                Item("Aetherwisp Bracers", "Wrist, Cloth", nil, 271096),
                Item("Spiritwraith Drape", "Back, Cloth", nil, 271097),
            }},
            { title = "Magmatus", kind = "boss", encounterID = 3495, npcID = 261316, displayID = 1070, items = {
                Item("Kindlegem Girdle", "Waist, Mail", nil, 270230),
                Item("Flamefist Grips", "Hands, Leather", nil, 270231),
                Item("Fang of Magmatus", "Main Hand, Dagger", nil, 271095),
            }},
            { title = "Plunder", kind = "boss", encounterID = 3494, npcID = 261311, displayID = 142840, items = {
                Item("Golemheart Stave", "Two-Hand, Staff", nil, 270228),
                Item("Treads of the Protector Golem", "Feet, Mail", nil, 270229),
                Item("Golemguard Chest", "Chest, Mail", nil, 271098),
            }},
            { title = "Durgen Dirgehammer", kind = "boss", encounterID = 3496, npcID = 261319, displayID = 142837, items = {
                Item("Durgen's Crescent Axe", "Main Hand, Axe", nil, 270256),
                Item("Direhammer Leggings", "Legs, Leather", nil, 270260),
                Item("Robes of the Disgraced Thane", "Chest, Cloth", nil, 270261),
            }},
            { title = "Old Ironforge Incursion", kind = "quest", faction = "Alliance", items = {
                Item("Calibrated Blunderbuss", "Ranged, Gun", nil, 279894),
                Item("Ironforge Greathammer", "Two-Hand, Mace", nil, 279895),
                Item("Deepblaze", "Ranged, Wand", nil, 279896),
            }},
            { title = "An Ancient Grudge", kind = "quest", items = {
                Item("Catacomb Cloak", "Back, Cloth", nil, 279899),
                Item("Deepgrave Trousers", "Legs, Leather", nil, 279900),
            }},
            { title = "Important Heirlooms", kind = "quest", faction = "Alliance", items = {
                Item("Dwarven Tome", "Held In Off-hand", nil, 279898),
                Item("Tomb Robber's Gloves", "Hands, Cloth", nil, 280096),
            }},
            { title = "The Restless Dead", kind = "quest", faction = "Alliance", items = {
                Item("Dusty Belt", "Waist, Leather", nil, 279897),
                Item("Cryptwalker Bracers", "Wrist, Mail", nil, 280095),
            }},
        },
        notableLoot = { "Direhammer Leggings (leather, Str/Agi) - off Durgen Dirgehammer" },
        notes = "Some previews suggest Horde can reach it via a workaround - unconfirmed.",
    },
-- [SOURCE 2026-10-26] A Frightened Request rewards (Edward's Knife 251485, Tabitha's Cuffs 251486): ForeverDB, seen in Forever by 2 players, ids found in the client's item table. [earlier] Wowhead zone page comments (boss loot) + quest rewards checked against each quest's wowhead.com/forever page (2026-09-28). Corrected: 2 quests originally mis-tagged as shared/unfactioned were actually faction-locked. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28. Boss loot cross-checked 2026-09-28 against wowtbc.gg's WoW Forever dungeon loot tables (which boss drops what; items marked NEW there), with every added ID, name and slot confirmed on wowhead.com/forever.
    {
        name = "Ruins of Lordaeron", art = 7963782, artAspect = 2992 / 1684, zone = "Tirisfal Glades",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        levelMin = 15, levelMax = 20, faction = "Both", status = "new",
        -- Corrected 2026-09-27 via the zone page's comments (wowhead.com/
        -- forever/zone=16611/ruins-of-lordaeron): this dungeon actually has
        -- two PARALLEL quest chains, not a mostly-Horde chain with a few
        -- Alliance side quests as originally assumed. Horde: A Frightened
        -- Request, The Wrath of Rath'mael, Light's Justice, The New Plague,
        -- Unending Torment, and one of the two Crest of Lordaeron quests.
        -- Alliance: Remember That I Love You, Abominable Creatures,
        -- Bloodied Insignia, and the other Crest of Lordaeron quest.
        quests = {
            Q("A Frightened Request", 92401, "Horde", { level = 22, requires = 15, xp = 4600, pickup = "Tabitha Heartweaver, The Sepulcher, Silverpine Forest", pickupZone = "Silverpine Forest", turnin = "Tabitha Heartweaver, The Sepulcher, Silverpine Forest", turninZone = "Silverpine Forest", mapID = 1421, x = 0.445, y = 0.43 }),
            Q("The Wrath of Rath'mael", 92422, "Horde", { level = 22, requires = 15, pickup = "Deathguard Kristof, Brill, Tirisfal Glades", pickupZone = "Tirisfal Glades", turnin = "Deathguard Kristof, Brill", turninZone = "Tirisfal Glades", mapID = 1420, x = 0.652, y = 0.602 }),
            Q("Light's Justice", 92421, "Horde", { level = 22, requires = 15, xp = 4600, pickup = "Morbin Lightbane, Undercity", pickupZone = "Undercity", turnin = "Morbin Lightbane, Undercity", turninZone = "Undercity", mapID = 1458, x = 0.579, y = 0.895 }),
            Q("The New Plague", 95216, "Horde", { level = 22, requires = 16, xp = 5450, pickup = "Theodore Griffs, Undercity", pickupZone = "Undercity", turnin = "Theodore Griffs, Undercity", turninZone = "Undercity", mapID = 1458, x = 0.465, y = 0.716 }),
            Q("Unending Torment", 97288, "Horde", { level = 21, requires = 16, xp = 3450, pickup = "Item start: Abominable Head, inside Ruins of Lordaeron", pickupZone = "Ruins of Lordaeron", turnin = "Master Apothecary Faranell, Undercity", turninZone = "Undercity" }),
            Q("Crest of Lordaeron", 95189, "Alliance", { level = 22, requires = 16, xp = 6200, pickup = "Item start: Crest of Lordaeron, inside Ruins of Lordaeron", pickupZone = "Ruins of Lordaeron", turnin = "Lady Dena Kennedy, Stormwind City", turninZone = "Stormwind City" }),
            Q("Remember That I Love You", 92415, "Alliance", { level = 22, requires = 15, xp = 6200, pickup = "Item start: Blood-Stained Letter, graveyard inside Ruins of Lordaeron", pickupZone = "Ruins of Lordaeron", turnin = "Orphan Matron Nightingale, Stormwind City", turninZone = "Stormwind City" }),
            Q("Abominable Creatures", 95250, "Alliance", { level = 21, requires = 16, xp = 3900, pickup = "Captain Truman, just inside Ruins of Lordaeron (left of the entrance)", pickupZone = "Ruins of Lordaeron", turnin = "Captain Truman, just inside Ruins of Lordaeron", turninZone = "Ruins of Lordaeron", mapID = 1420, x = 0.716, y = 0.114 }),
            Q("Bloodied Insignia", 95195, "Alliance", { level = 22, requires = 16, xp = 6200, pickup = "Item start: Bloodied Insignia, inside Ruins of Lordaeron", pickupZone = "Ruins of Lordaeron", turnin = "General Marcus Jonathan, Stormwind City", turninZone = "Stormwind City" }),
            Q("Crest of Lordaeron", 95204, "Horde", { level = 22, requires = 16, xp = 5450, pickup = "Item start: Crest of Lordaeron, inside Ruins of Lordaeron", pickupZone = "Ruins of Lordaeron", turnin = "Oran Snakewrithe, Undercity", turninZone = "Undercity" }),
        },
        -- Item IDs verified via the same zone page's comments (user
        -- Sammyx3's boss loot table, checked 2026-09-27).
        lootGroups = {
            { title = "The Baron", kind = "boss", encounterID = 3355, npcID = 250660, displayID = 144188, items = {
                Item("Meathook Slicer", "One-Hand, Dagger", nil, 271204),
                Item("Abomination Bones", "Chest, Mail", nil, 271205),
                Item("Leftover Abomination Skin", "Chest, Cloth", nil, 271206),
            }},
            { title = "Witherfang", kind = "boss", encounterID = 3353, npcID = 250483, displayID = 144189, items = {
                Item("Atrophic Girdle", "Waist, Mail", nil, 271201),
                Item("Witherbite Bracers", "Wrist, Leather", nil, 271202),
                Item("Segmented Spider Leg", "Two-Hand, Staff", nil, 271203),
            }},
            { title = "The Abandoned", kind = "boss", encounterID = 3357, npcID = 250631, displayID = 138667, items = {
                Item("Rotmender's Leggings", "Legs, Cloth", nil, 271207), -- renamed in Forever (was "Wispcloth Leggings")
                Item("Grip of Fear", "Hands, Mail", nil, 271208),
                Item("Scepter of the Abandoned", "Main Hand, Mace", nil, 271216),
            }},
            { title = "Bjork", kind = "boss", encounterID = 3412, npcID = 256097, displayID = 144170, items = {
                Item("Bonerust Leggings", "Legs, Mail", nil, 271209),
                Item("Tuskwrap Belt", "Waist, Cloth", nil, 271210),
                Item("Corpse Chopper", "Two-Hand, Axe", nil, 271217),
            }},
            { title = "Rath'mael", kind = "boss", encounterID = 3354, npcID = 250657, displayID = 144175, items = {
                Item("Mirror of Rath'mael", "Off Hand, Shield", nil, 271213),
                Item("Rotmender's Treads", "Feet, Cloth", nil, 271214), -- renamed in Forever (was "Frostbane Treads")
                Item("Coldspire Staff", "Two-Hand, Staff", nil, 271215),
            }},
            -- A rare spawn that was in Shadowfang Keep in classic. Forever moved it here:
            -- wowtbc.gg's Forever loot tables list it in Ruins of Lordaeron, and their
            -- Shadowfang Keep table no longer has it.
            -- (Wowhead confirms these two items drop from npc 3872, Deathsworn Captain.)
            { title = "Deathsworn Captain", kind = "boss", npcID = 3872, displayID = 3224, items = {
                Item("Haunting Blade", "Two-Hand, Sword", 58, 6641),
                Item("Phantom Armor", "Chest, Mail", 34, 6642),
            }},
            { title = "Viktor the Vile", kind = "boss", encounterID = 3411, npcID = 256035, displayID = 139455, items = {
                Item("Vilewalkers", "Feet, Mail", nil, 271211),
                Item("Bloodied Chestwraps", "Chest, Leather", nil, 271212),
                Item("Vileblood Scimitar", "One-Hand, Sword", nil, 271218),
            }},
            { title = "A Frightened Request", kind = "quest", faction = "Horde", items = {
                Item("Edward's Knife", "One-Hand, Dagger", nil, 251485),
                Item("Tabitha's Cuffs", "Wrist, Cloth", nil, 251486),
            }},
            { title = "The Wrath of Rath'mael", kind = "quest", faction = "Horde", items = {
                Item("Forsaken Greataxe", "Two-Hand, Axe", nil, 251533),
                Item("Gnarled Necromancer's Staff", "Two-Hand, Staff", nil, 251534),
            }},
            { title = "Remember That I Love You", kind = "quest", faction = "Alliance", items = {
                Item("Tarnished Locket", "Neck", nil, 279870),
            }},
            { title = "Abominable Creatures", kind = "quest", faction = "Alliance", items = {
                Item("Monstrous Cleaver", "Two-Hand, Sword", nil, 279864),
                Item("Grave Shroud", "Back, Cloth", nil, 279865),
                Item("Slain Baron's Signet", "Finger", nil, 279867),
            }},
            { title = "Bloodied Insignia", kind = "quest", faction = "Alliance", items = {
                Item("Duty Bound Leggings", "Legs, Leather", nil, 279868),
                Item("Remembrance Armor", "Chest, Mail", nil, 279869),
            }},
            { title = "Light's Justice", kind = "quest", faction = "Horde", items = {
                Item("The Stitcher", "Main Hand, Mace", nil, 279874),
                Item("Spare Part Bindings", "Wrist, Leather", nil, 279875),
            }},
            { title = "The New Plague", kind = "quest", faction = "Horde", items = {
                Item("Plaguefang", "One-Hand, Sword", nil, 279876),
                Item("Blight Gloves", "Hands, Cloth", nil, 279877),
            }},
            { title = "Crest of Lordaeron", kind = "quest", faction = "Alliance", items = {
                Item("Small Sack of Gems", "", nil, 280567),
            }},
            { title = "Crest of Lordaeron", kind = "quest", faction = "Horde", items = {
                Item("Small Sack of Gems", "", nil, 280567),
            }},
        },
        notableLoot = { "Crest of Lordaeron (quest item, drops inside)" },
        notes = "Two parallel quest chains, one per faction. Item IDs confirmed on wowhead.com/forever.",
    },
-- [SOURCE 2026-10-05, DISCOVERING] Live in the game since the 2026-10-01 patch (the level-30 cap). Quests
-- and boss loot from Wowhead's Excavation Site Dungeon Overview guide (updated 2026-10-04); every quest's
-- level, required level, Side, start/end NPC (with zone and map position) and XP (base x multiplier,
-- rounded to 50 as the game shows it) checked on its wowhead.com/forever page on 2026-10-05, every item's
-- name, slot and ID on its own page. NPC and display IDs from wowhead.com/forever/npc=260322, 260325,
-- 260326. Level range 24-29: Blizzard's own list (Wowhead news, 2026-09-14), Wowhead's Dungeons Overview
-- and wowtbc.gg all say 29 (the dungeon guide said 30). Fallen in the Fen from wowtbc.gg's quest list, its
-- ID, rewards and turn-in on Wowhead. Highland Hides says no Side on Wowhead, but it follows Daily
-- Delivery, which is Alliance-only, so it's tagged Alliance. Open the Maw has no Side on Wowhead (wowtbc.gg
-- lists it as Horde). Songblade Search has no Side on Wowhead either, but its giver, Dorin Songblade
-- (npc=956, Stormwind faction, Lakeshire), reacts friendly to Alliance only, so it's tagged Alliance
-- (checked 2026-10-05). Still unknown: where Heartwoven and Fallen in the Fen start (inside the dungeon), and
-- where Songblade Search and Lost in the Thicket Things end. Drop `discovering` once those are in.
    {
        name = "Excavation Site", art = 7963777, artAspect = 2992 / 1684, zone = "Wetlands",
        levelMin = 24, levelMax = 29, faction = "Both", status = "new", discovering = true,
        verified = { bosses = "2026-10-01", levelRange = "2026-10-05" },
        quests = {
            Q("Changing Tastes", 95697, "Horde", { level = 31, requires = 24, xp = 6950, pickup = "Borstan, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Borstan, Orgrimmar", turninZone = "Orgrimmar", mapID = 1454, x = 0.574, y = 0.534 }),
            Q("Elder Knowledge", 95664, "Horde", { level = 31, requires = 24, xp = 1400, pickup = "Item start: Titan Relic, dropped by Relic Guardian", pickupZone = "Excavation Site", turnin = "Bashana Runetotem, The Elder Rise, Thunder Bluff", turninZone = "Thunder Bluff" }),
            Q("Earthen Echo", 98823, "Horde", { level = 31, requires = 24, xp = 6950, pickup = "Bashana Runetotem, The Elder Rise, Thunder Bluff", pickupZone = "Thunder Bluff", turnin = "Muln Earthfury, Mulgore", turninZone = "Mulgore", mapID = 1456, x = 0.708, y = 0.338, chainStart = { name = "Elder Knowledge", pickup = "Item start: Titan Relic, dropped by Relic Guardian", zone = "Excavation Site" } }),
            Q("Open the Maw", 95682, nil, { level = 31, requires = 24, xp = 6950, pickup = "Deathstalker Agent, hiding in the hills by the entrance", pickupZone = "Wetlands", turnin = "Deathstalker Agent, by the entrance", turninZone = "Wetlands", mapID = 1437, x = 0.514, y = 0.592 }),
            Q("Highland Hides", 98815, "Alliance", { level = 28, requires = 24, xp = 1150, pickup = "James Halloran, Menethil Harbor, Wetlands", pickupZone = "Wetlands", turnin = "James Halloran, Menethil Harbor, Wetlands", turninZone = "Wetlands", mapID = 1437, x = 0.08, y = 0.55, chainStart = { name = "Daily Delivery", pickup = "Einar Stonegrip, for James Halloran in Menethil Harbor" } }),
            Q("Songblade Search", 95772, "Alliance", { level = 31, requires = 24, xp = 6150, pickup = "Dorin Songblade, Redridge Mountains", pickupZone = "Redridge Mountains", mapID = 1433, x = 0.256, y = 0.466 }),
            Q("Horrors in the Highland", 95646, "Alliance", { level = 31, requires = 24, xp = 6150, pickup = "Rethiel the Greenwarden, Wetlands", pickupZone = "Wetlands", turnin = "Rethiel the Greenwarden, Wetlands", turninZone = "Wetlands", mapID = 1437, x = 0.562, y = 0.406 }),
            Q("Fallen in the Fen", 95795, "Alliance", { level = 31, requires = 24, xp = 6150, turnin = "Dorin Songblade, Lakeshire, Redridge Mountains", turninZone = "Redridge Mountains" }),
            Q("Lost in the Thicket Things", 95647, "Alliance", { level = 31, requires = 24, xp = 4900, pickup = "Caitlin Grassman, Menethil Harbor, Wetlands", pickupZone = "Wetlands", mapID = 1437, x = 0.118, y = 0.586, chainStart = { name = "Seeking Caitlin", pickup = "Llana, Astranaar, Ashenvale", zone = "Ashenvale" } }),
            Q("Heartwoven", 95809, "Alliance", { level = 31, requires = 24, xp = 6150, turnin = "Caitlin Grassman, Menethil Harbor, Wetlands", turninZone = "Wetlands", chainStart = { name = "Seeking Caitlin", pickup = "Llana, Astranaar, Ashenvale", zone = "Ashenvale" } }),
            Q("Lost Relic Carry", 95810, "Alliance", { level = 31, requires = 24, xp = 1250, pickup = "Item start: Titan Relic, dropped by Relic Guardian", pickupZone = "Excavation Site", turnin = "Prospector Whelgar, Whelgar's Excavation Site, Wetlands", turninZone = "Wetlands" }),
            Q("Prehistoric Prism", 98824, "Alliance", { level = 31, requires = 24, xp = 6150, pickup = "Prospector Whelgar, Whelgar's Excavation Site, Wetlands", pickupZone = "Wetlands", turnin = "High Explorer Magellas, Hall of Explorers, Ironforge", turninZone = "Ironforge", mapID = 1437, x = 0.388, y = 0.522, chainStart = { name = "Lost Relic Carry", pickup = "Item start: Titan Relic, dropped by Relic Guardian", zone = "Excavation Site" } }),
        },
        notableLoot = { "Titan Relic (starts a quest) - off Relic Guardian" },
        lootGroups = {
            { title = "Saltspine", kind = "boss", npcID = 260322, displayID = 144209, items = {
                Item("Glinteye Slippers", "Feet, Cloth", nil, 273024),
                Item("Saltscale Girdle", "Waist, Mail", nil, 273023),
                Item("Supple Bellyskin Leggings", "Legs, Leather", nil, 273022),
            }},
            { title = "Shadetooth", kind = "boss", npcID = 260325, displayID = 144210, items = {
                Item("Raptorclaw Greaves", "Feet, Mail", nil, 273025),
                Item("Raptor's Gaze", "Held In Off-hand", nil, 273027),
            }},
            { title = "Relic Guardian", kind = "boss", npcID = 260326, displayID = 144224, items = {
                Item("Ring of Power Regulation", "Finger", nil, 273030),
                Item("Golemsight Long Gun", "Ranged, Gun", nil, 273029),
                Item("Reliquary Mantle", "Shoulder, Mail", nil, 273028),
            }},
            { title = "Changing Tastes", kind = "quest", faction = "Horde", items = {
                Item("Satchel of Potions", "Trinket", nil, 280766),
                Item("Serrated Raptor Claw", "One-Hand, Dagger", nil, 280805),
                Item("Recipe: Twice-Spiced Raptor Slice", "Non-equippable, Cooking", nil, 250185),
            }},
            { title = "Earthen Echo", kind = "quest", faction = "Horde", items = {
                Item("Heavehammer", "Two-Hand, Mace", nil, 271766),
                Item("Healer's Staff", "Two-Hand, Staff", nil, 271767),
                Item("Furs of the Earthen Ring", "Back, Cloth", nil, 271719),
            }},
            { title = "Open the Maw", kind = "quest", items = {
                Item("Knife-Polishing Rag", "Wrist, Cloth", nil, 271740),
                Item("Dirt-Heavy Bracers", "Wrist, Leather", nil, 271732),
            }},
            { title = "Horrors in the Highland", kind = "quest", faction = "Alliance", items = {
                Item("Ironwood Destroyer", "Two-Hand, Mace", nil, 271667),
                Item("Curl of Life", "Finger", nil, 271670),
                Item("Hornbeam Heft", "One-Hand, Axe", nil, 271664),
            }},
            { title = "Fallen in the Fen", kind = "quest", faction = "Alliance", items = {
                Item("Songblade Stabilizer", "Waist, Mail", nil, 271768),
                Item("Daewyn's Girdle", "Waist, Cloth", nil, 271769),
            }},
            { title = "Heartwoven", kind = "quest", faction = "Alliance", items = {
                Item("Satchel of Potions", "Trinket", nil, 280766),
            }},
            { title = "Prehistoric Prism", kind = "quest", faction = "Alliance", items = {
                Item("Explorer's League Dustcover", "Back, Cloth", nil, 271716),
                Item("Healer's Staff", "Two-Hand, Staff", nil, 271767),
                Item("Heavehammer", "Two-Hand, Mace", nil, 271766),
            }},
        },
    },
-- [SOURCE 2026-10-05, DISCOVERING] Bosses from Wowhead's City of Dalaran Dungeon Strategy Guide (updated
-- 2026-10-01; fights written up from play), each boss's NPC and display ID on wowhead.com/forever/npc=. Its
-- quests from wowtbc.gg's quest list, each one's ID, level, required level, Side, start NPC (with zone and
-- map position), XP (3950 x2.375, rounded to 50) and rewards checked on its wowhead.com/forever page on
-- 2026-10-05, every reward's name and slot on its own page. Level range 28-33 (Blizzard's list, wowtbc.gg).
-- No boss drops are known yet (wowtbc.gg agrees, 2026-10-07). Givers re-checked 2026-10-07: Starving Arcane
-- and the Alliance Heart of Disruption start at the Image of Archmage Modera (one NPC, Silverpine Forest, both
-- factions), A Green Sample at Shylamiir (Herbalism trainer, Stormwind City, Wowhead 2026-10-08). Wowhead 2026-10-09 now
-- lists turn-ins: Starving Arcane and the Alliance Heart of Disruption end at Modera, the Horde one at Magus Wordeen Voidglare
-- (Tarren Mill); the series continue with Friend of the Kirin Tor (Alliance) and Shrewd Negotiations (Horde). Power Overwhelming and Source of Power turn in at their givers (quest text on foreverdb.net/dungeon/2959,
-- seen in Forever, 2026-10-08). ForeverDB's client now lists 9 bosses and Power Overwhelming asks for the Mana Elemental, so the
-- 7-boss list is probably short; the three Mana NPC IDs are not confirmed, so it is left as is.
-- UPDATE 2026-10-20: An Alarming Request (92432, L33, req 30, Alliance) added: Wowhead start Emissary Jacques, end Image of Archmage Modera; Blizzard's dungeon post puts Jacques in Southshore. No XP shown. The Alliance chain is not a key: user confirmed 2026-10-20 that Alliance walk in (ForeverDB's route: gate opens without a key), so these carry no key note.
-- UPDATE 2026-10-09 (Horde key chain): Prison Break In (544), Dalaran Patrols (545), Key to the City (93680) and Blood in the Streets
-- (92434) added from their Wowhead pages and the guide; Wowhead shows XP 270 for Blood in the Streets and none for Key to the City, left blank.
-- UPDATE 2026-10-09: Wowhead's City of Dalaran guide now lists 8 bosses with their drops (loot tabs read on the guide, slots from
-- the page's own item data); Mana Devourer (npc 246008) is added, display ID 129895 added 2026-10-10 from npc=246008. Mana Elemental and Mana Wraith are not on the
-- guide. Opportunistic Education (Horde, quest 96987, Rexxie Copperclutch inside the dungeon) added from its Wowhead page.
-- ForeverDB's client list names 9 bosses (adds Mana Devourer, Mana Elemental, Mana Wraith; no Arcanic
-- Enigma); Wowhead and wowtbc.gg list these 7, so they stand until someone sees it in game. The Heart of Disruption quests follow An Alarming Request
-- (Alliance) and Blood in the Streets (Horde), which lead to the Image of Archmage Modera.
    {
        name = "City of Dalaran", art = 7963775, artAspect = 2992 / 1684, zone = "Alterac Mountains",
        levelMin = 28, levelMax = 33, faction = "Both", status = "new", discovering = true,
        verified = { bosses = "2026-10-09", levelRange = "2026-10-05" },
        quests = {
            Q("Prison Break In", 544, "Horde", { level = 33, requires = 30, xp = 3300, pickup = "Magus Wordeen Voidglare, Tarren Mill", pickupZone = "Hillsbrad Foothills", turnin = "Magus Wordeen Voidglare, Tarren Mill", turninZone = "Hillsbrad Foothills", key = "Part of the key to City of Dalaran" }),
            Q("Key to the City", 93680, "Horde", { level = 33, requires = 30, pickup = "Magus Wordeen Voidglare, Tarren Mill", pickupZone = "Hillsbrad Foothills", turnin = "Magus Wordeen Voidglare, Tarren Mill", turninZone = "Hillsbrad Foothills", key = "Part of the key to City of Dalaran" }),
            Q("Dalaran Patrols", 545, "Horde", { level = 35, requires = 30, xp = 2050, pickup = "Magus Wordeen Voidglare, Tarren Mill", pickupZone = "Hillsbrad Foothills", turnin = "Magus Wordeen Voidglare, Tarren Mill", turninZone = "Hillsbrad Foothills", key = "Part of the key to City of Dalaran" }),
            Q("Blood in the Streets", 92434, "Horde", { level = 34, requires = 30, pickup = "Magus Wordeen Voidglare, Tarren Mill", pickupZone = "Hillsbrad Foothills", turnin = "Image of Archmage Modera, Silverpine Forest", turninZone = "Silverpine Forest", key = "Part of the key to City of Dalaran" }),
            Q("Starving Arcane", 92457, nil, { level = 33, requires = 24, xp = 9400, pickup = "Image of Archmage Modera, Silverpine Forest", pickupZone = "Silverpine Forest", turnin = "Image of Archmage Modera, Silverpine Forest", turninZone = "Silverpine Forest", mapID = 1421, x = 0.686, y = 0.452 }),
            Q("A Green Sample", 92456, "Alliance", { level = 33, requires = 24, xp = 9400, pickup = "Shylamiir, Stormwind City", pickupZone = "Stormwind City", turnin = "Shylamiir, Stormwind City", turninZone = "Stormwind City" }),
            Q("An Alarming Request", 92432, "Alliance", { level = 33, requires = 30, pickup = "Emissary Jacques, Southshore", pickupZone = "Hillsbrad Foothills", turnin = "Image of Archmage Modera, Silverpine Forest", turninZone = "Silverpine Forest" }),
            Q("Heart of Disruption", 92458, "Alliance", { level = 33, requires = 24, xp = 9400, pickup = "Image of Archmage Modera, Silverpine Forest", pickupZone = "Silverpine Forest", turnin = "Image of Archmage Modera, Silverpine Forest", turninZone = "Silverpine Forest", mapID = 1421, x = 0.686, y = 0.452, chainStart = { name = "An Alarming Request", pickup = "Emissary Jacques" } }),
            Q("Power Overwhelming", 92489, "Alliance", { level = 33, requires = 24, xp = 9400, pickup = "High Sorcerer Andromath, Stormwind City", pickupZone = "Stormwind City", mapID = 1453, x = 0.376, y = 0.816, turnin = "High Sorcerer Andromath, Stormwind City", turninZone = "Stormwind City" }),
            Q("Heart of Disruption", 96984, "Horde", { level = 33, requires = 24, xp = 9400, pickup = "Image of Archmage Modera, Silverpine Forest", pickupZone = "Silverpine Forest", turnin = "Magus Wordeen Voidglare, Tarren Mill", turninZone = "Hillsbrad Foothills", mapID = 1421, x = 0.686, y = 0.452, chainStart = { name = "Blood in the Streets", pickup = "Magus Wordeen Voidglare" }, key = "Part of the key to City of Dalaran" }),
            Q("Shrewd Negotiations", 97287, "Horde", { level = 33, requires = 24, pickup = "Magus Wordeen Voidglare, Tarren Mill", pickupZone = "Hillsbrad Foothills", turnin = "Archmage Celindra", key = "Part of the key to City of Dalaran" }),
            Q("The Grave Knight", 96986, "Horde", { level = 33, requires = 24, xp = 9400, pickup = "Melisara, Hillsbrad Foothills", pickupZone = "Hillsbrad Foothills", turnin = "Melisara, Hillsbrad Foothills", turninZone = "Hillsbrad Foothills", mapID = 1424, x = 0.626, y = 0.206 }),
            Q("Opportunistic Education", 96987, "Horde", { level = 33, requires = 24, xp = 9400, pickup = "Rexxie Copperclutch, inside City of Dalaran", pickupZone = "City of Dalaran" }),
            Q("Source of Power", 96988, "Horde", { level = 33, requires = 24, xp = 9400, pickup = "Doctor Martin Felben, Undercity", pickupZone = "Undercity", mapID = 1458, x = 0.466, y = 0.744, turnin = "Doctor Martin Felben, Undercity", turninZone = "Undercity" }),
        },
        lootGroups = {
            { title = "Atrexis the Grave Knight", kind = "boss", encounterID = 3311, npcID = 247126, displayID = 145787, items = {
                Item("Graveweave Bindings", "Wrist, Cloth", nil, 273036),
                Item("Bonebinder's Signet", "Finger, Miscellaneous", nil, 273032),
                Item("Gravespike Repeater", "Ranged, Crossbow", nil, 273033),
            } },
            { title = "Arcane Anomaly", kind = "boss", encounterID = 3298, npcID = 245999, displayID = 129891, items = {
                Item("Ephemeral Grips", "Hands, Cloth", nil, 273034),
                Item("Runemender's Seal", "Finger, Miscellaneous", nil, 273031),
                Item("Mana-Warped Chain Shirt", "Chest, Mail", nil, 273035),
            } },
            { title = "Arcanic Enigma", kind = "boss", npcID = 246016, displayID = 129900, items = {
                Item("Violet Sorcerer's Robes", "Chest, Cloth", nil, 273044),
                Item("Drape of Shifting Energy", "Back, Cloth", nil, 273045),
                Item("Wand of Mana Concentration", "Ranged, Wand", nil, 273043),
            } },
            { title = "Unstable Sentinel", kind = "boss", encounterID = 3302, npcID = 246017, displayID = 129954, items = {
                Item("Guardian's Dualblade", "Two-Hand, Axe", nil, 273046),
                Item("Unstable Crystalline Shoulderpads", "Shoulder, Leather", nil, 273047),
                Item("Refractory Scaleguards", "Legs, Mail", nil, 273048),
                Item("Blueprint: Spinning Wheel", "Non-equippable, Tailoring", nil, 273099),
            } },
            { title = "Mana Devourer", kind = "boss", encounterID = 3300, npcID = 246008, displayID = 129895, items = {
                Item("Slitherwrap Girdle", "Waist, Leather", nil, 273041),
                Item("Manascale Treads", "Feet, Mail", nil, 273042),
                Item("Refractory Scaleguards", "Legs, Mail", nil, 273048),
                Item("Spine of the Devourer", "Two-Hand, Staff", nil, 273040),
            }},
            { title = "Fel Ancient", kind = "boss", encounterID = 3299, npcID = 246003, displayID = 129894, items = {
                Item("Felbough Arm", "Two-Hand, Polearm", nil, 273037),
                Item("Garb of Fallen Felbark", "Chest, Leather", nil, 273038),
                Item("Blightleaf Rope", "Waist, Cloth", nil, 273039),
            } },
            { title = "Lyn the Ignored", kind = "boss", encounterID = 3310, npcID = 247032, displayID = 130235, items = {
                Item("Cartilage Shapers", "Hands, Leather", nil, 273054),
                Item("Bonepile Gaze", "Off Hand, Shield", nil, 273055),
                Item("Tendonscraper Dagger", "Main Hand, Dagger", nil, 273053),
            } },
            { title = "Shade of the Archmage", kind = "boss", encounterID = 3303, npcID = 246020, displayID = 130061, items = {
                Item("Archmagister's Faceted Pendant", "Neck, Miscellaneous", nil, 273049),
                Item("Violet Sorcerer's Mantle", "Shoulder, Cloth", nil, 273051),
                Item("Ponderous Orb", "Held In Off-hand, Miscellaneous", nil, 273052),
                Item("Blueprint: Arcane Salvager", "Non-equippable, Enchanting", nil, 273103),
            } },
            { title = "Starving Arcane", kind = "quest", items = {
                Item("Fallen Guard's Pendant", "Neck", nil, 279837),
                Item("Arcane Infused Rod", "Held In Off-hand", nil, 279838),
            }},
            { title = "A Green Sample", kind = "quest", faction = "Alliance", items = {
                Item("Vine Pruner's Cloak", "Back, Cloth", nil, 279835),
                Item("Thorn Protecting Girdle", "Waist, Mail", nil, 279836),
            }},
            { title = "Heart of Disruption", kind = "quest", faction = "Alliance", items = {
                Item("Spellguard Pauldrons", "Shoulder, Mail", nil, 279839),
                Item("Renewing Footpads", "Feet, Leather", nil, 279840),
                Item("Defender of Dalaran", "Two-Hand, Mace", nil, 279841),
            }},
            { title = "Power Overwhelming", kind = "quest", faction = "Alliance", items = {
                Item("Violet Sash", "Waist, Cloth", nil, 251962),
                Item("Runebound Gloves", "Hands, Leather", nil, 279849),
            }},
            { title = "Heart of Disruption", kind = "quest", faction = "Horde", items = {
                Item("Battle Spaulders", "Shoulder, Mail", nil, 279842),
                Item("Enchanted Sandals", "Feet, Cloth", nil, 279843),
                Item("Striking Staff", "Two-Hand, Staff", nil, 279844),
            }},
            { title = "The Grave Knight", kind = "quest", faction = "Horde", items = {
                Item("Gravewalker Boots", "Feet, Leather", nil, 251963),
                Item("Undead Knight's Bracers", "Wrist, Mail", nil, 251965),
            }},
            { title = "Source of Power", kind = "quest", faction = "Horde", items = {
                Item("Unstable Power Core", "Ranged, Wand", nil, 279847),
                Item("Construct Cloak", "Back, Cloth", nil, 279848),
            }},
            { title = "Opportunistic Education", kind = "quest", faction = "Horde", items = {
                Item("Solid Gold Band", "Finger", nil, 279845),
                Item("Larcenist's Belt", "Waist", nil, 279846),
            }},
        },
    },
-- [SOURCE - NO LINK YET] No zone page exists for this dungeon yet.
    {
        name = "The Drowned City", zone = "Stranglethorn Vale",
        levelMin = 35, levelMax = 40, faction = "Both", status = "new", comingSoon = true,
        quests = {}, notableLoot = {},
        notes = "No verifiable data yet.",
    },
-- [SOURCE - NO LINK YET] No zone page exists for this dungeon yet.
    {
        name = "Krol'dok Stronghold", zone = "Riverglades",
        levelMin = 40, levelMax = 45, faction = "Both", status = "new", comingSoon = true,
        quests = {}, notableLoot = {},
        notes = "No verifiable data yet.",
    },
-- [SOURCE - NO LINK YET] No zone page exists for this dungeon yet.
    {
        name = "Alcaz Prison", zone = "Dustwallow Marsh",
        levelMin = 48, levelMax = 53, faction = "Both", status = "new", comingSoon = true,
        quests = {}, notableLoot = {},
        notes = "No verifiable data yet.",
    },
-- [SOURCE - NO LINK YET] No zone page exists for this dungeon yet.
    {
        name = "Blackmaw Hold", zone = "Azshara",
        levelMin = 55, levelMax = 60, faction = "Both", status = "new", comingSoon = true,
        quests = {}, notableLoot = {},
        notes = "No verifiable data yet.",
    },
-- [SOURCE - NO LINK YET] No zone page exists for this dungeon yet.
    {
        name = "Shaper's Terrace", zone = "Un'Goro Crater",
        levelMin = 58, levelMax = 60, faction = "Both", status = "new", comingSoon = true,
        quests = {}, notableLoot = {},
        notes = "No verifiable data yet.",
    },

    -- Returning classic dungeons, with quests verified against Wowhead's
    -- Forever dungeon quest guide (see file header)
-- [SOURCE 2026-09-27] npm classic-items db (zone=2437) for boss loot + quest rewards; the 2 Forever-new bosses (Oggleflint, Bazzalan) and their items from wowtbc.gg's Forever loot tables, IDs confirmed on wowhead.com/forever (2026-09-28). Boss order verified and corrected. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28.
    {
        name = "Ragefire Chasm", art = 131862, zone = "Orgrimmar", levelMin = 13, levelMax = 18, faction = "Horde", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("Slaying the Beast", 5761, "Horde", { level = 16, requires = 9, xp = 2350, pickup = "Neeru Fireblade, Cleft of Shadow, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Neeru Fireblade, Cleft of Shadow, Orgrimmar", turninZone = "Orgrimmar", mapID = 1454, x = 0.496, y = 0.506 }),
            Q("The Power to Destroy...", 5725, "Horde", { level = 16, requires = 9, xp = 2950, pickup = "Varimathras, Royal Quarter, Undercity", pickupZone = "Undercity", turnin = "Varimathras, Royal Quarter, Undercity", turninZone = "Undercity", mapID = 1458, x = 0.562, y = 0.926 }),
            Q("Testing an Enemy's Strength", 5723, "Horde", { level = 15, requires = 9, xp = 2150, pickup = "Rahauro, Elder Rise, Thunder Bluff", pickupZone = "Thunder Bluff", turnin = "Rahauro, Elder Rise, Thunder Bluff", turninZone = "Thunder Bluff", mapID = 1456, x = 0.704, y = 0.322 }),
            Q("Searching for the Lost Satchel", 5722, "Horde", { level = 16, requires = 9, xp = 1800, pickup = "Rahauro, Elder Rise, Thunder Bluff", pickupZone = "Thunder Bluff", turnin = "Maur Grimtotem's corpse, inside Ragefire Chasm", turninZone = "Ragefire Chasm", mapID = 1456, x = 0.704, y = 0.322 }),
            Q("Returning the Lost Satchel", 5724, "Horde", { level = 16, requires = 9, xp = 2950, pickup = "Grimtotem Satchel, from Maur Grimtotem's corpse inside Ragefire Chasm", pickupZone = "Ragefire Chasm", turnin = "Rahauro, Elder Rise, Thunder Bluff", turninZone = "Thunder Bluff", chainStart = { name = "Searching for the Lost Satchel", pickup = "Rahauro, Elder Rise, Thunder Bluff", zone = "Thunder Bluff" } }),
            Q("Hidden Enemies", 5728, "Horde", { level = 16, requires = 9, xp = 2350, pickup = "Thrall, Valley of Wisdom, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Thrall, Valley of Wisdom, Orgrimmar", turninZone = "Orgrimmar", mapID = 1454, x = 0.32, y = 0.378, chainStart = { name = "Hidden Enemies", pickup = "Thrall, Orgrimmar", zone = "Orgrimmar" } }),
        },
                lootGroups = {
            { title = "Taragaman the Hungerer", kind = "boss", encounterID = 2733, npcID = 11520, displayID = 7970, items = {
                Item("Cursed Felblade", "One-Hand, Sword", 16, 14145),
                Item("Subterranean Cape", "Back, Cloth", 33, 14149),
                Item("Crystalline Cuffs", "Wrist, Cloth", 31, 14148),
            }},
            { title = "Oggleflint", kind = "boss", encounterID = 2732, npcID = 11517, displayID = 11611, items = {
                Item("Trogg Scepter", "Main Hand, Mace", nil, 272996),
                Item("Bone Knuckles", "Main Hand, Fist Weapon", nil, 272998),
                Item("Barbaric Crossbow", "Ranged, Crossbow", nil, 272999),
            }},
            { title = "Jergosh the Invoker", kind = "boss", encounterID = 2734, npcID = 11518, displayID = 11429, items = {
                Item("Cavedweller Bracers", "Wrist, Mail", 34, 14147),
                Item("Robe of Evocation", "Chest, Cloth", 36, 14150),
                Item("Chanting Blade", "One-Hand, Dagger", 16, 14151),
            }},
            { title = "Bazzalan", kind = "boss", encounterID = 2735, npcID = 11519, displayID = 2007, items = {
                Item("Searing Dagger", "Main Hand, Dagger", nil, 273003),
                Item("Satyrskin Cloak", "Back, Cloth", nil, 273005),
                Item("Chasm Walkers", "Feet, Leather", nil, 273007),
            }},
            { title = "The Power to Destroy...", kind = "quest", faction = "Horde", items = {
                Item("Dredgemire Leggings", "Legs, Leather", nil, 15450),
                Item("Ghastly Trousers", "Legs, Cloth", nil, 15449),
                Item("Gargoyle Leggings", "Legs, Mail", nil, 15451),
            }},
            { title = "Returning the Lost Satchel", kind = "quest", faction = "Horde", items = {
                Item("Featherbead Bracers", "Wrist, Cloth", nil, 15452),
                Item("Savannah Bracers", "Wrist, Leather", nil, 15453),
                Item("Garrison Cuffs", "Wrist, Mail", nil, 270003),
            }},
            { title = "Hidden Enemies", kind = "quest", faction = "Horde", items = {
                Item("Axe of Orgrimmar", "Two-Hand, Axe", nil, 15424),
                Item("Hammer of Orgrimmar", "One-Hand, Mace", nil, 15445),
                Item("Staff of Orgrimmar", "Two-Hand, Staff", nil, 15444),
                Item("Kris of Orgrimmar", "One-Hand, Dagger", nil, 15443),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=1581) for boss loot + quest rewards; Forever-new bonus items from wowtbc.gg's Forever loot tables with IDs confirmed on wowhead.com/forever, and quest rewards checked against each quest's wowhead.com/forever page (2026-09-28). Boss order verified: 9 trash entries (Defias Miner/Watchman/etc.) removed, real order confirmed. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28.
    {
        name = "The Deadmines", art = 131833, zone = "Westfall", levelMin = 18, levelMax = 23, faction = "Alliance", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("Collecting Memories", 168, "Alliance", { level = 18, requires = 14, xp = 1350, pickup = "Wilder Thistlenettle, the Dwarven District, Stormwind", pickupZone = "Stormwind City", turnin = "Wilder Thistlenettle, Stormwind", turninZone = "Stormwind City", mapID = 1453, x = 0.668, y = 0.438 }),
            Q("Oh Brother...", 167, "Alliance", { level = 20, requires = 15, xp = 1550, pickup = "Wilder Thistlenettle, the Dwarven District, Stormwind", pickupZone = "Stormwind City", turnin = "Wilder Thistlenettle, Stormwind", turninZone = "Stormwind City", mapID = 1453, x = 0.668, y = 0.438 }),
            Q("Underground Assault", 2040, "Alliance", { level = 20, requires = 15, xp = 3700, pickup = "Shoni the Shilent, the Dwarven District, Stormwind", pickupZone = "Stormwind City", turnin = "Shoni the Shilent, Stormwind", turninZone = "Stormwind City", mapID = 1453, x = 0.63, y = 0.34, chainStart = { name = "Speak with Shoni", pickup = "Gnoarn, Ironforge", zone = "Ironforge" } }),
            Q("The Unsent Letter", 373, "Alliance", { level = 22, requires = 16, xp = 2050, pickup = "Use An Unsent Letter, looted from Edwin VanCleef", pickupZone = "The Deadmines", turnin = "Baros Alexston, City Hall, Cathedral Square, Stormwind", turninZone = "Stormwind City" }),
            Q("Red Silk Bandanas", 214, "Alliance", { level = 17, requires = 14, xp = 2950, pickup = "Scout Riell, Sentinel Hill tower, Westfall", pickupZone = "Westfall", turnin = "Scout Riell, Sentinel Hill tower, Westfall", turninZone = "Westfall", mapID = 1436, x = 0.5667, y = 0.4735 }),
            Q("The Defias Brotherhood", 166, "Alliance", { level = 22, requires = 14, xp = 6200, pickup = "Gryan Stoutmantle, Sentinel Hill tower, Westfall", pickupZone = "Westfall", turnin = "Gryan Stoutmantle, Sentinel Hill, Westfall", turninZone = "Westfall", mapID = 1436, x = 0.564, y = 0.475, chainStart = { name = "The Defias Brotherhood", pickup = "The Defias Traitor, Westfall", zone = "Westfall" } }),
            Q("The Test of Righteousness", 1654, "Alliance", { class = "PALADIN", level = 22, requires = 20, xp = 870, pickup = "Jordan Stilwell, Dun Morogh", pickupZone = "Dun Morogh", turnin = "Jordan Stilwell, Dun Morogh", turninZone = "Dun Morogh", chainStart = { name = "The Tome of Valor", pickup = "Daphne Stilwell, Westfall", zone = "Westfall" } }),
            Q("Destruction in Deadmines", 92753, "Alliance", { level = 18, requires = 9, xp = 2700, pickup = "Alba Fairmoon, Westfall", pickupZone = "Westfall", turnin = "Alba Fairmoon, hills behind Moonbrook near the Deadmines exit", turninZone = "Westfall", mapID = 1436, x = 0.524, y = 0.53 }),
        },
                lootGroups = {
            { title = "Rhahk'Zor", kind = "boss", encounterID = 2741, tip = "Stuns the tank every so often. Keep the tank topped up through it.", npcID = 644, displayID = 14403, items = {
                Item("Rockslicer", "Two-Hand, Axe", 4, 872),
                Item("Rhahk'Zor's Hammer", "Two-Hand, Mace", 76, 5187),
                Item("Ogre Loincloth", "Legs, Cloth", nil, 273289),
            }},
            { title = "Miner Johnson", kind = "boss", encounterID = 3676, tip = "Strips the tank's armor for a while, so expect more damage on the tank.", npcID = 3586, displayID = 556, items = {
                Item("Gold-plated Buckler", "Off Hand, Shield", 41, 5443),
                Item("Miner's Cape", "Back, Cloth", 55, 5444),
            }},
            { title = "Sneed's Shredder", kind = "boss", npcID = 642, displayID = 1269, items = {
                Item("Buzz Saw", "One-Hand, Sword", 10, 1937),
                Item("Buzzer Blade", "One-Hand, Dagger", 57, 2169),
                Item("Dull Sawblade", "Thrown", nil, 285292),
            }},
            { title = "Sneed", kind = "boss", encounterID = 2742, tip = "Disarms the tank for a few seconds.", npcID = 643, displayID = 7125, items = {
                Item("Gold-flecked Gloves", "Hands, Cloth", 68, 5195),
                Item("Taskmaster Axe", "Two-Hand, Axe", 28, 5194),
                Item("Bandsaw Wristbands", "Wrist, Mail", nil, 273293),
                Item("Schematic: Shredder Autosalvage Unit", "Non-equippable, Engineering", nil, 210178),
                Item("Blueprint: Repair Bot", "Non-equippable, Engineering", nil, 273092),
            }},
            { title = "Gilnid", kind = "boss", encounterID = 2743, tip = "Burns and slows the tank. Healers keep a heal ready.", npcID = 1763, displayID = 7124, items = {
                Item("Lavishly Jeweled Ring", "Finger, Miscellaneous", 37, 1156),
                Item("Smelting Pants", "Legs, Leather", 57, 5199),
                Item("Goblin Hammer", "Main Hand, Mace", nil, 273297),
                Item("Blueprint: Anvil", "Non-equippable, Blacksmithing", nil, 273086),
            }},
            { title = "Mr. Smite", kind = "boss", encounterID = 2745, tip = "Two guards join at the start. He stuns everyone once, around two thirds health, so top the group up first.", npcID = 646, displayID = 2026, items = {
                Item("Thief's Blade", "One-Hand, Sword", 38, 5192),
                Item("Smite's Reaver", "One-Hand, Axe", 38, 5196),
                Item("Smite's Mighty Hammer", "Two-Hand, Mace", 19, 7230),
                Item("First Mate Band", "Finger", nil, 284715),
            }},
            { title = "Cookie", kind = "boss", encounterID = 2746, tip = "Interrupt his self heal. Ranged players stay out of melee range of his acid.", npcID = 645, displayID = 1305, items = {
                Item("Cookie's Tenderizer", "One-Hand, Mace", 55, 5197),
                Item("Cookie's Stirring Rod", "Ranged, Wand", 34, 5198),
                Item("Lookie's Spyglass", "Trinket", nil, 273298),
                Item("Blueprint: Cookie's Feast", "Non-equippable, Cooking", nil, 273102),
            }},
            { title = "Captain Greenskin", kind = "boss", encounterID = 2744, tip = "Face him away from the group, interrupt the harpoon, and handle the two adds that join at the start.", npcID = 647, displayID = 7113, items = {
                Item("Impaling Harpoon", "Two-Hand, Polearm", 28, 5200),
                Item("Emberstone Staff", "Two-Hand, Staff", 38, 5201),
                Item("Blackened Defias Belt", "Waist, Leather", 26, 10403),
            }},
            { title = "Edwin VanCleef", kind = "boss", encounterID = 2747, tip = "Two guards join at the start and two more at half health. Control or kill them.", npcID = 639, displayID = 2029, items = {
                Item("Cruel Barb", "One-Hand, Sword", 16, 5191),
                Item("Cape of the Brotherhood", "Back, Cloth", 23, 5193),
                Item("Corsair's Overshirt", "Chest, Cloth", 24, 5202),
                Item("Blackened Defias Armor", "Chest, Leather", 16, 10399),
            }},
            -- Trash: items that drop from a dungeon's ordinary mobs, never from a boss (and not world drops). Which mob is deliberately not recorded.
            { title = "Trash drops", kind = "trash", items = {
                Item("Blackened Defias Leggings", "Legs, Leather", nil, 10400),
                Item("Blackened Defias Boots", "Feet, Leather", nil, 10402),
            }},
            { title = "Collecting Memories", kind = "quest", faction = "Alliance", items = {
                Item("Dusty Mining Gloves", "Hands, Leather", nil, 2036),
                Item("Tunneler's Boots", "Feet, Mail", nil, 2037),
                Item("Worn Miner's Waistcord", "Waist, Cloth", nil, 270007),
            }},
            { title = "Oh Brother...", kind = "quest", faction = "Alliance", items = {
                Item("Miner's Revenge", "Two-Hand, Axe", nil, 1893),
                Item("Miner's Workgloves", "Hands, Cloth", nil, 270012),
                Item("Miner's Workboots", "Feet, Leather", nil, 270013),
            }},
            { title = "Underground Assault", kind = "quest", faction = "Alliance", items = {
                Item("Polar Gauntlets", "Hands, Mail", nil, 7606),
                Item("Sable Wand", "Ranged, Wand", nil, 7607),
                Item("Bravo's Armbands", "Wrist, Leather", nil, 270015),
                Item("Dreamer's Leggings", "Legs, Leather", nil, 270016),
            }},
            { title = "Red Silk Bandanas", kind = "quest", faction = "Alliance", items = {
                Item("Solid Shortblade", "One-Hand, Sword", nil, 2074),
                Item("Scrimshaw Dagger", "One-Hand, Dagger", nil, 2089),
                Item("Piercing Axe", "Two-Hand, Axe", nil, 6094),
                Item("Monastic Hammer", "One-Hand, Mace", nil, 270005),
            }},
            { title = "The Defias Brotherhood", kind = "quest", faction = "Alliance", items = {
                Item("Staff of Westfall", "Two-Hand, Staff", nil, 2042),
                Item("Tunic of Westfall", "Chest, Leather", nil, 2041),
                Item("Chausses of Westfall", "Legs, Mail", nil, 6087),
            }},
            { title = "The Test of Righteousness", kind = "quest", faction = "Alliance", items = {
                Item("Verigan's Fist", "Two-Hand, Mace", nil, 6953),
            }},
        },
        notes = "Destruction in Deadmines (per a Wowhead comment on the Forever guide) may be a Forever-specific addition - lower confidence than the rest of this list.",
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=718) for boss loot + quest rewards, Wowhead zone page comments (found a missing quest, In Nightmares); Forever-new bonus items from wowtbc.gg's Forever loot tables with IDs confirmed on wowhead.com/forever (2026-09-28). Boss order verified. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28.
    {
        name = "Wailing Caverns", art = 131882, zone = "The Barrens", levelMin = 15, levelMax = 25, faction = "Both", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("Serpentbloom", 962, "Horde", { level = 18, requires = 14, xp = 3300, pickup = "Apothecary Zamah, Thunder Bluff", pickupZone = "Thunder Bluff", turnin = "Apothecary Zamah, Thunder Bluff", turninZone = "Thunder Bluff", mapID = 1456, x = 0.23, y = 0.21 }),
            Q("Smart Drinks", 1491, nil, { level = 18, requires = 13, xp = 2650, pickup = "Mebok Mizzyrix, Ratchet, The Barrens", pickupZone = "The Barrens", turnin = "Mebok Mizzyrix, Ratchet, The Barrens", turninZone = "The Barrens", mapID = 1413, x = 0.628, y = 0.367, chainStart = { name = "Raptor Horns", pickup = "Ratchet, The Barrens", zone = "The Barrens" } }),
            Q("Trouble at the Docks", 959, nil, { level = 18, requires = 14, xp = 2650, pickup = "Crane Operator Bigglefuzz, Ratchet, The Barrens", pickupZone = "The Barrens", turnin = "Crane Operator Bigglefuzz, Ratchet, The Barrens", turninZone = "The Barrens", mapID = 1413, x = 0.639, y = 0.383 }),
            Q("Deviate Hides", 1486, nil, { level = 17, requires = 13, xp = 3100, pickup = "Nalpak, above the entrance to Wailing Caverns, The Barrens", pickupZone = "The Barrens", turnin = "Nalpak, above the entrance to Wailing Caverns, The Barrens", turninZone = "The Barrens", mapID = 1413, x = 0.466, y = 0.363 }),
            Q("Deviate Eradication", 1487, nil, { level = 21, requires = 15, xp = 4000, pickup = "Ebru, above the entrance to Wailing Caverns, The Barrens", pickupZone = "The Barrens", turnin = "Ebru, above the entrance to Wailing Caverns, The Barrens", turninZone = "The Barrens", mapID = 1413, x = 0.466, y = 0.357 }),
            Q("The Glowing Shard", 6981, nil, { level = 26, requires = 15, xp = 5150, pickup = "Item start: Glowing Shard, dropped by Mutanus the Devourer", pickupZone = "Wailing Caverns", turnin = "Follow the quest directions beginning in Ratchet", turninZone = "The Barrens" }),
            Q("In Nightmares", 3369, "Horde", { level = 25, requires = 10, xp = 2000, pickup = "Falla Sagewind, The Barrens", pickupZone = "The Barrens", turnin = "Arch Druid Hamuul Runetotem, Thunder Bluff", turninZone = "Thunder Bluff" }),
            Q("Leaders of the Fang", 914, "Horde", { level = 22, requires = 10, xp = 4300, pickup = "Nara Wildmane, Thunder Bluff", pickupZone = "Thunder Bluff", turnin = "Nara Wildmane, Thunder Bluff", turninZone = "Thunder Bluff", mapID = 1456, x = 0.753, y = 0.313, chainStart = { name = "Hamuul Runetotem", pickup = "Tonga Runetotem, The Barrens", zone = "The Barrens" } }),
        },
                lootGroups = {
            { title = "Lord Cobrahn", kind = "boss", encounterID = 586, tip = "A sleep curse lands on a random player now and then: dispel it if you can. Interrupt his self heal.", npcID = 3669, displayID = 4213, items = {
                Item("Cobrahn's Grasp", "Waist, Mail", 18, 6460),
                Item("Robe of the Moccasin", "Chest, Cloth", 55, 6465),
                Item("Leggings of the Fang", "Legs, Leather", 18, 10410),
            }},
            { title = "Lady Anacondra", kind = "boss", encounterID = 585, tip = "Sleep lands on someone other than the tank now and then: dispel it. Interrupt her self heal.", npcID = 3671, displayID = 4313, items = {
                Item("Serpent's Shoulders", "Shoulder, Leather", 47, 5404),
                Item("Snakeskin Bag", "Bag, Bag", 5, 6446),
                Item("Belt of the Fang", "Waist, Leather", 10, 10412),
                Item("Snake Eye Kaleidoscope", "Neck", nil, 273088),
                Item("Blueprint: Field Guide", "Non-equippable, Book", nil, 273098),
            }},
            { title = "Lord Pythas", kind = "boss", encounterID = 588, tip = "Sleeps a player now and then, so dispel it, and thunders everyone close by: ranged players stay back. Interrupt his self heal.", npcID = 3670, displayID = 4214, items = {
                Item("Stinging Viper", "One-Hand, Mace", 30, 6472),
                Item("Armor of the Fang", "Chest, Leather", 55, 6473),
                Item("Slither Cord", "Waist, Cloth", nil, 273089),
            }},
            { title = "Lord Serpentis", kind = "boss", encounterID = 590, tip = "Sleeps a player other than the tank now and then, so dispel it. Interrupt his self heal.", npcID = 3673, displayID = 4215, items = {
                Item("Serpent Gloves", "Hands, Cloth", 20, 5970),
                Item("Savage Trodders", "Feet, Mail", 23, 6459),
                Item("Venomstrike", "Ranged, Bow", 17, 6469),
                Item("Footpads of the Fang", "Feet, Leather", 21, 10411),
                Item("Blueprint: Journeyman Campfire", "Non-equippable, Cooking", nil, 273087),
            }},
            { title = "Kresh", kind = "boss", encounterID = 587, npcID = 3653, displayID = 5126, items = {
                Item("Worn Turtle Shell Shield", "Off Hand, Shield", 70, 6447),
                Item("Kresh's Back", "Off Hand, Shield", 13, 13245),
                Item("Cloak of Hermitic Bliss", "Back, Cloth", nil, 273084),
            }},
            { title = "Skum", kind = "boss", encounterID = 589, tip = "Interrupt his chained bolt.", npcID = 3674, displayID = 4203, items = {
                Item("Tail Spike", "One-Hand, Dagger", 47, 6448),
                Item("Glowing Lizardscale Cloak", "Back, Cloth", 46, 6449),
                Item("Skum's Bucket", "Held In Off-hand", nil, 273137),
            }},
            { title = "Verdan the Everliving", kind = "boss", encounterID = 591, tip = "His vines hit everyone close to him, so ranged players stay back.", npcID = 5775, displayID = 4256, items = {
                Item("Sporid Cape", "Back, Cloth", 19, 6629),
                Item("Seedcloud Buckler", "Off Hand, Shield", 39, 6630),
                Item("Living Root", "Two-Hand, Staff", 38, 6631),
            }},
            { title = "Mutanus the Devourer", kind = "boss", encounterID = 592, tip = "Fears random players now and then. He takes over one player: control them, don't hurt them.", npcID = 3654, displayID = 4088, items = {
                Item("Slime-encrusted Pads", "Shoulder, Cloth", 29, 6461),
                Item("Deep Fathom Ring", "Finger, Miscellaneous", 30, 6463),
                Item("Mutant Scale Breastplate", "Chest, Mail", 23, 6627),
            }},
            { title = "Deviate Faerie Dragon", kind = "boss", npcID = 5912, displayID = 1267, items = {
                Item("Firebelcher", "Ranged, Wand", 42, 5243),
                Item("Feyscale Cloak", "Back, Cloth", 45, 6632),
            }},
            { title = "Serpentbloom", kind = "quest", faction = "Horde", items = {
                Item("Apothecary Gloves", "Hands, Cloth", nil, 10919),
                Item("Heat Resistant Mitts", "Hands, Leather", nil, 270008),
                Item("Safety Boots", "Feet, Mail", nil, 270009),
            }},
            { title = "Deviate Hides", kind = "quest", items = {
                Item("Deviate Hide Pack", "Bag, Bag", nil, 918),
                Item("Slick Deviate Leggings", "Legs, Leather", nil, 6480),
            }},
            { title = "Deviate Eradication", kind = "quest", items = {
                Item("Pattern: Deviate Scale Belt", "Non-equippable, Leatherworking", nil, 6476),
                Item("Dagmire Gauntlets", "Hands, Mail", nil, 6481),
                Item("Sizzle Stick", "Ranged, Wand", nil, 8071),
            }},
            { title = "In Nightmares", kind = "quest", faction = "Horde", items = {
                Item("Talbar Mantle", "Shoulder, Cloth", nil, 10657),
                Item("Quagmire Galoshes", "Feet, Mail", nil, 10658),
            }},
            { title = "Leaders of the Fang", kind = "quest", faction = "Horde", items = {
                Item("Crescent Staff", "Two-Hand, Staff", nil, 6505),
                Item("Wingblade", "One-Hand, Sword", nil, 6504),
                Item("Hammerbone", "Two-Hand, Mace", nil, 270018),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=209) for boss loot + quest rewards; Forever-new bonus items from wowtbc.gg's Forever loot tables with IDs confirmed on wowhead.com/forever (2026-09-28). Boss order verified: 1 unrecognized entry ("Sever") removed. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28. Boss loot cross-checked 2026-09-28 against wowtbc.gg's WoW Forever dungeon loot tables (which boss drops what; items marked NEW there), with every added ID, name and slot confirmed on wowhead.com/forever.
    {
        name = "Shadowfang Keep", art = 131869, zone = "Silverpine Forest", levelMin = 22, levelMax = 30, faction = "Both", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("The Book of Ur", 1013, "Horde", { level = 26, requires = 16, xp = 5600, pickup = "Keeper Bel'dugur, Apothecarium, Undercity", pickupZone = "Undercity", turnin = "Keeper Bel'dugur, Apothecarium, Undercity", turninZone = "Undercity", mapID = 1458, x = 0.537, y = 0.545 }),
            Q("Deathstalkers in Shadowfang", 1098, "Horde", { level = 25, requires = 18, xp = 5350, pickup = "High Executor Hadrec, The Sepulcher, Silverpine Forest", pickupZone = "Silverpine Forest", turnin = "Deathstalker Vincent, inside Shadowfang Keep", turninZone = "Shadowfang Keep", mapID = 1421, x = 0.434, y = 0.409 }),
            Q("Arugal Must Die", 1014, "Horde", { level = 27, requires = 18, xp = 8850, pickup = "Dalar Dawnweaver, The Sepulcher, Silverpine Forest", pickupZone = "Silverpine Forest", turnin = "Dalar Dawnweaver, The Sepulcher, Silverpine Forest", turninZone = "Silverpine Forest", mapID = 1421, x = 0.442, y = 0.398 }),
            Q("The Orb of Soran'ruk", 1740, nil, { class = "WARLOCK", level = 25, requires = 20, xp = 5100, pickup = "Doan Karhan, The Barrens", pickupZone = "The Barrens", turnin = "Doan Karhan, The Barrens", turninZone = "The Barrens", mapID = 1413, x = 0.493, y = 0.572 }),
            Q("The Test of Righteousness", 1654, "Alliance", { class = "PALADIN", level = 22, requires = 20, xp = 870, pickup = "Jordan Stilwell, Dun Morogh", pickupZone = "Dun Morogh", turnin = "Jordan Stilwell, Dun Morogh", turninZone = "Dun Morogh", chainStart = { name = "The Tome of Valor", pickup = "Daphne Stilwell, Westfall", zone = "Westfall" } }),
        },
                lootGroups = {
            { title = "Rethilgore", kind = "boss", encounterID = 2748, tip = "Puts a magic debuff on the tank. Dispel it if you can.", npcID = 3914, displayID = 524, items = {
                Item("Rugged Spaulders", "Shoulder, Leather", 86, 5254),
                Item("Sorcerer Collar", "Neck", nil, 273457),
                Item("Cell Keeper's Claws", "Main Hand, Fist Weapon", nil, 273456),
            }},
            { title = "Fel Steed", kind = "boss", npcID = 3864, displayID = 1951, items = {
                Item("Fel Steed Saddlebags", "Bag, Bag", 17, 932),
                Item("Eerie Stable Lantern", "Held In Off-hand", nil, 6341),
            }},
            { title = "Wolf Master Nandos", kind = "boss", encounterID = 2754, tip = "Worgs keep joining the fight. Kill or control each one as it arrives.", npcID = 3927, displayID = 11179, items = {
                Item("Feline Mantle", "Shoulder, Cloth", 57, 3748),
                Item("Wolfmaster Cape", "Back, Cloth", 38, 6314),
                Item("Worgpelt Leggings", "Legs, Leather", nil, 273647),
            }},
            { title = "Fenrus the Devourer", kind = "boss", encounterID = 2753, tip = "Poisons random players. Cure it if you can.", npcID = 4274, displayID = 2352, items = {
                Item("Black Wolf Bracers", "Wrist, Leather", 17, 3230),
                Item("Fenrus' Hide", "Back, Cloth", 74, 6340),
                Item("Half-Eaten Boots", "Feet, Mail", nil, 273646),
            }},
            { title = "Razorclaw the Butcher", kind = "boss", encounterID = 2749, npcID = 3886, displayID = 524, items = {
                Item("Butcher's Cleaver", "One-Hand, Axe", 9, 1292),
                Item("Bloody Apron", "Chest, Cloth", 42, 6226),
                Item("Butcher's Slicer", "One-Hand, Sword", 40, 6633),
                Item("Blueprint: Tanning Rack", "Non-equippable, Leatherworking", nil, 273096),
            }},
            { title = "Baron Silverlaine", kind = "boss", encounterID = 2750, tip = "Cuts healing sharply for a few seconds. Heal ahead of it.", npcID = 3887, displayID = 3222, items = {
                Item("Baron's Scepter", "One-Hand, Mace", 38, 6323),
                Item("Silverlaine's Family Seal", "Finger, Miscellaneous", 19, 6321),
                Item("Blade of Silverlaine", "Main Hand, Sword", nil, 273637),
            }},
            { title = "Commander Springvale", kind = "boss", encounterID = 2751, tip = "Interrupt his self heal and dispel the stun on the tank.", npcID = 4278, displayID = 3223, items = {
                Item("Arced War Axe", "Two-Hand, Axe", 36, 3191),
                Item("Commander's Crest", "Off Hand, Shield", 30, 6320),
                Item("Worgenbane Talisman", "Trinket", nil, 273643),
                Item("Blueprint: Toxin Study", "Non-equippable, First Aid", nil, 273105),
            }},
            { title = "Odo the Blindwatcher", kind = "boss", encounterID = 2752, tip = "A Blood Seeker and a Vile Bat join at the start. Kill or control them.", npcID = 4279, displayID = 522, items = {
                Item("Girdle of the Blindwatcher", "Waist, Leather", 58, 6319),
                Item("Odo's Ley Staff", "Two-Hand, Staff", 33, 6318),
                Item("Blindwatcher's Sight", "Head", nil, 273645),
            }},
            { title = "Arugal's Voidwalker", kind = "boss", npcID = 4627, displayID = 1131, items = {
                Item("Rift Bracers", "Wrist, Mail", 2, 5943),
                Item("Broken Binding Bracer", "Non-equippable, Junk", 17, 6439),
                Item("Dull Elemental Bracer", "Non-equippable, Junk", 39, 6438),
            }},
            { title = "Archmage Arugal", kind = "boss", encounterID = 2755, tip = "Ranged players stay out of melee range of his shockwave. Control, don't hurt, anyone he curses.", npcID = 4275, displayID = 2353, items = {
                Item("Meteor Shard", "One-Hand, Dagger", 18, 6220),
                Item("Robes of Arugal", "Chest, Cloth", 35, 6324),
                Item("Belt of Arugal", "Waist, Cloth", 35, 6392),
            }},
            { title = "The Book of Ur", kind = "quest", faction = "Horde", items = {
                Item("Steel-clasped Bracers", "Wrist, Mail", nil, 4534),
                Item("Grizzled Boots", "Feet, Leather", nil, 6335),
                Item("Tattered Mittens", "Hands, Cloth", nil, 270030),
            }},
            { title = "Deathstalkers in Shadowfang", kind = "quest", faction = "Horde", items = {
                Item("Ghostly Mantle", "Shoulder, Cloth", nil, 3324),
                Item("Tanned Shoulderpads", "Shoulder, Leather", nil, 270023),
                Item("Bronzed Shoulderguards", "Shoulder, Mail", nil, 270024),
            }},
            { title = "Arugal Must Die", kind = "quest", faction = "Horde", items = {
                Item("Seal of Sylvanas", "Finger, Miscellaneous", nil, 6414),
            }},
            { title = "The Orb of Soran'ruk", kind = "quest", items = {
                Item("Orb of Soran'ruk", "Held In Off-hand, Miscellaneous", nil, 6898),
                Item("Staff of Soran'ruk", "Two-Hand, Staff", nil, 15109),
            }},
            { title = "The Test of Righteousness", kind = "quest", faction = "Alliance", items = {
                Item("Verigan's Fist", "Two-Hand, Mace", nil, 6953),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=719) for boss loot + quest rewards; quest rewards checked against each quest's wowhead.com/forever page (2026-09-28). Corrected a real error: a "Baron Aquanis" quest (6922) that doesn't actually exist - replaced with 2 real quests that were missing. Boss order verified. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28. Boss loot cross-checked 2026-09-28 against wowtbc.gg's WoW Forever dungeon loot tables (which boss drops what; items marked NEW there), with every added ID, name and slot confirmed on wowhead.com/forever.
    {
        name = "Blackfathom Deeps", art = 131823, zone = "Ashenvale", levelMin = 24, levelMax = 32, faction = "Both", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            -- Horde
            Q("The Essence of Aku'Mai", 6563, "Horde", { level = 22, requires = 17, xp = 1750, pickup = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", pickupZone = "Ashenvale", turnin = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", turninZone = "Ashenvale", mapID = 1440, x = 0.12, y = 0.34, chainStart = { name = "Trouble in the Deeps", pickup = "Tsunaman, Stonetalon Mountains", zone = "Stonetalon Mountains" } }),
            Q("Baron Aquanis", 6922, "Horde", { level = 30, requires = 21, xp = 7250, pickup = "Item start: Strange Water Globe, dropped by Baron Aquanis", pickupZone = "Blackfathom Deeps", turnin = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", turninZone = "Ashenvale" }),
            Q("Blackfathom Villainy", 6561, "Horde", { level = 27, requires = 18, xp = 7850, pickup = "Argent Guard Thaelrid, inside Blackfathom Deeps", pickupZone = "Blackfathom Deeps", turnin = "Bashana Runetotem, Thunder Bluff", turninZone = "Thunder Bluff" }),
            Q("Amongst the Ruins", 6921, "Horde", { level = 27, requires = 21, xp = 6550, pickup = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", pickupZone = "Ashenvale", turnin = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", turninZone = "Ashenvale", mapID = 1440, x = 0.12, y = 0.34 }),
            Q("Trouble in the Deeps", 6562, "Horde", { level = 22, requires = 17, xp = 435, pickup = "Tsunaman, Stonetalon Mountains", pickupZone = "Stonetalon Mountains", turnin = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", turninZone = "Ashenvale" }),
            Q("Allegiance to the Old Gods", 6564, "Horde", { part = "1 of 2", level = 22, requires = 17, xp = 1300, pickup = "Use the Damp Note dropped by Blackfathom Tide Priestesses", pickupZone = "Blackfathom Deeps", turnin = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", turninZone = "Ashenvale" }),
            Q("Allegiance to the Old Gods", 6565, "Horde", { part = "2 of 2", level = 26, requires = 17, xp = 6300, pickup = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", pickupZone = "Ashenvale", turnin = "Je'neu Sancrea, Zoram'gar Outpost, Ashenvale", turninZone = "Ashenvale", mapID = 1440, x = 0.12, y = 0.34, chainStart = { name = "Allegiance to the Old Gods", pickup = "Item start: Damp Note, dropped by Blackfathom Tide Priestesses", zone = "Blackfathom Deeps" } }),
            -- Alliance
            Q("Knowledge in the Deeps", 971, "Alliance", { level = 23, requires = 10, xp = 6550, pickup = "Gerrig Bonegrip, Forlorn Cavern, Ironforge", pickupZone = "Ironforge", turnin = "Gerrig Bonegrip, Forlorn Cavern, Ironforge", turninZone = "Ironforge", mapID = 1455, x = 0.5083, y = 0.0561 }),
            Q("Researching the Corruption", 1275, "Alliance", { level = 24, requires = 18, xp = 2400, pickup = "Gershala Nightwhisper, Auberdine, Darkshore", pickupZone = "Darkshore", turnin = "Gershala Nightwhisper, Auberdine, Darkshore", turninZone = "Darkshore", mapID = 1439, x = 0.383, y = 0.431, chainStart = { name = "The Corruption Abroad", pickup = "Argos Nightwhisper, Stormwind City", zone = "Stormwind City" } }),
            Q("Twilight Falls", 1199, "Alliance", { level = 25, requires = 20, xp = 6050, pickup = "Argent Guard Manados, Craftsmen's Terrace, Darnassus", pickupZone = "Darnassus", turnin = "Argent Guard Manados, Craftsmen's Terrace, Darnassus", turninZone = "Darnassus", mapID = 1457, x = 0.55, y = 0.24 }),
            Q("In Search of Thaelrid", 1198, "Alliance", { level = 24, requires = 18, xp = 5700, pickup = "Dawnwatcher Shaedlass, Craftsmen's Terrace, Darnassus", pickupZone = "Darnassus", turnin = "Argent Guard Thaelrid, inside Blackfathom Deeps", turninZone = "Blackfathom Deeps", mapID = 1457, x = 0.55, y = 0.24 }),
            Q("Blackfathom Villainy", 1200, "Alliance", { level = 27, requires = 18, xp = 7850, pickup = "Argent Guard Thaelrid, inside Blackfathom Deeps", pickupZone = "Blackfathom Deeps", turnin = "Dawnwatcher Selgorm, Darnassus", turninZone = "Darnassus", chainStart = { name = "In Search of Thaelrid", pickup = "Dawnwatcher Shaedlass, Craftsmen's Terrace, Darnassus", zone = "Darnassus" } }),
            -- Shared
            Q("The Orb of Soran'ruk", 1740, nil, { class = "WARLOCK", level = 25, requires = 20, xp = 5100, pickup = "Doan Karhan, The Barrens", pickupZone = "The Barrens", turnin = "Doan Karhan, The Barrens", turninZone = "The Barrens", mapID = 1413, x = 0.493, y = 0.572 }),
            Q("The Test of Righteousness", 1654, "Alliance", { class = "PALADIN", level = 22, requires = 20, xp = 870, pickup = "Jordan Stilwell, Dun Morogh", pickupZone = "Dun Morogh", turnin = "Jordan Stilwell, Dun Morogh", turninZone = "Dun Morogh", chainStart = { name = "The Tome of Valor", pickup = "Daphne Stilwell, Westfall", zone = "Westfall" } }),
        },
                lootGroups = {
            { title = "Ghamoo-ra", kind = "boss", encounterID = 2916, tip = "His stomp hits everyone close to him, so ranged players stay back.", npcID = 4887, displayID = 5027, items = {
                Item("Tortoise Armor", "Chest, Mail", 37, 6907),
                Item("Ghamoo-ra's Bind", "Waist, Cloth", 57, 6908),
                Item("Spiked Shell Band", "Finger", nil, 273839),
            }},
            { title = "Gelihast", kind = "boss", encounterID = 2704, tip = "Nets the tank often, and it can't be removed. Keep the tank topped up.", npcID = 6243, displayID = 1773, items = {
                Item("Murloc Skin Bag", "Bag, Bag", 11, 1470),
                Item("Algae Fists", "Hands, Mail", 45, 6906),
                Item("Reef Axe", "Two-Hand, Axe", 47, 6905),
                Item("Cursed Murloc Eye", "Trinket", nil, 273840),
                Item("Blueprint: Fishing Rack", "Non-equippable, Fishing", nil, 273141),
                Item("Pattern: Filigreed Pearly Circlet", "Non-equippable, Tailoring", nil, 253984),
            }},
            { title = "Lady Sarevess", kind = "boss", encounterID = 2915, tip = "Face her away from the group, as her lightning hits a cone in front. Ranged players stay back from her frost nova.", npcID = 4831, displayID = 4979, items = {
                Item("Naga Battle Gloves", "Hands, Leather", 38, 888),
                Item("Naga Heartpiercer", "Ranged, Bow", 19, 3078),
                Item("Darkwater Talwar", "One-Hand, Sword", 38, 11121),
                Item("Pattern: Brawler's Leather Hood", "Leatherworking Recipe", nil, 252798),
            }},
            { title = "Old Serra'kis", kind = "boss", encounterID = 2912, npcID = 4830, displayID = 1816, items = {
                Item("Bands of Serra'kis", "Wrist, Leather", 33, 6902),
                Item("Bite of Serra'kis", "One-Hand, Dagger", 21, 6904),
                Item("Glowing Thresher Cape", "Back, Cloth", 40, 6901),
            }},
            { title = "Twilight Lord Kelris", kind = "boss", encounterID = 2911, tip = "Sleeps everyone now and then, so dispel it. Mind blasts hit the tank.", npcID = 4832, displayID = 4939, items = {
                Item("Rod of the Sleepwalker", "Two-Hand, Staff", 49, 1155),
                Item("Gaze Dreamer Pants", "Legs, Cloth", 34, 6903),
                Item("Twilight Lord Girdle", "Waist, Mail", nil, 273846),
                Item("Head of Kelris", "Non-equippable, Quest", nil, 5881),
            }},
            { title = "Lorgus Jett", kind = "boss", encounterID = 2913, tip = "Lightning bolts hit the tank. Keep the tank topped up.", npcID = 12902, displayID = 12822, items = {
                Item("Fallenroot Longbow", "Ranged, Bow", nil, 273843),
                Item("Twilight Maul", "Two-Hand, Mace", nil, 273841),
                Item("Treacherous Treads", "Feet, Mail", nil, 273842),
            }},
            { title = "Aku'mai", kind = "boss", encounterID = 2910, tip = "Hits harder when enraged, so save defensive cooldowns. A poison cloud lands on everyone: cure it if you can.", npcID = 4829, displayID = 2837, items = {
                Item("Moss Cinch", "Waist, Leather", 38, 6911),
                Item("Strike of the Hydra", "Two-Hand, Sword", 20, 6909),
                Item("Leech Pants", "Legs, Cloth", 37, 6910),
            }},
            { title = "Blackfathom Villainy", kind = "quest", faction = "Horde", items = {
                Item("Gravestone Scepter", "Ranged, Wand", nil, 7001),
                Item("Arctic Buckler", "Off Hand, Shield", nil, 7002),
                Item("Dark Ritual Leggings", "Legs, Leather", nil, 270031),
                Item("Cultist's Armguards", "Wrist, Leather", nil, 270032),
            }},
            { title = "Allegiance to the Old Gods", kind = "quest", faction = "Horde", items = {
                Item("Band of the Fist", "Finger, Miscellaneous", nil, 17694),
                Item("Chestnut Mantle", "Shoulder, Cloth", nil, 17695),
            }},
            { title = "Knowledge in the Deeps", kind = "quest", faction = "Alliance", items = {
                Item("Sustaining Ring", "Finger, Miscellaneous", nil, 6743),
            }},
            { title = "Researching the Corruption", kind = "quest", faction = "Alliance", items = {
                Item("Beetle Clasps", "Wrist, Mail", nil, 7003),
                Item("Prelacy Cape", "Back, Cloth", nil, 7004),
                Item("Staghide Armguards", "Wrist, Leather", nil, 270021),
            }},
            { title = "Twilight Falls", kind = "quest", faction = "Alliance", items = {
                Item("Heartwood Girdle", "Waist, Leather", nil, 7000),
                Item("Nimbus Boots", "Feet, Cloth", nil, 6998),
                Item("Silvered Gauntlets", "Hands, Mail", nil, 270025),
            }},
            { title = "Blackfathom Villainy", kind = "quest", faction = "Alliance", items = {
                Item("Gravestone Scepter", "Ranged, Wand", nil, 7001),
                Item("Arctic Buckler", "Off Hand, Shield", nil, 7002),
                Item("Dark Ritual Leggings", "Legs, Leather", nil, 270031),
                Item("Cultist's Armguards", "Wrist, Leather", nil, 270032),
            }},
            { title = "The Orb of Soran'ruk", kind = "quest", items = {
                Item("Orb of Soran'ruk", "Held In Off-hand, Miscellaneous", nil, 6898),
                Item("Staff of Soran'ruk", "Two-Hand, Staff", nil, 15109),
            }},
            { title = "The Test of Righteousness", kind = "quest", faction = "Alliance", items = {
                Item("Verigan's Fist", "Two-Hand, Mace", nil, 6953),
            }},
        },
    },
-- [SOURCE 2026-09-29] npm classic-items db (zone=717) for boss loot + quest rewards. Boss list and order checked 2026-09-29 against wowtbc.gg's Forever Stockade loot table (Kam Deepfury, Bruegal Ironknuckle, Targorr the Dread, Hamhock, Bazil Thredd); Dextren Ward is left out because he has no loot there. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28. Boss loot cross-checked 2026-09-28 against wowtbc.gg's WoW Forever dungeon loot tables (which boss drops what; items marked NEW there), with every added ID, name and slot confirmed on wowhead.com/forever.
-- [SOURCE 2026-10-26] Dextren Ward (a real boss in the client's encounter table, missing here) added with Boneslicer (273819, seen in Forever on ForeverDB). Bruegal Ironknuckle stays as the optional rare.
    {
        name = "The Stockade", art = 131870, zone = "Stormwind", levelMin = 22, levelMax = 30, faction = "Alliance", status = "classic",
        verified = { bosses = "2026-09-29", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("Quell the Uprising", 387, "Alliance", { level = 26, requires = 22, xp = 5550, pickup = "Warden Thelwater, Stormwind City", pickupZone = "Stormwind City", turnin = "Warden Thelwater, Stormwind City", turninZone = "Stormwind City" }),
            Q("The Color of Blood", 388, "Alliance", { level = 26, requires = 22, xp = 5550, pickup = "Nikova Raskol, Stormwind City", pickupZone = "Stormwind City", turnin = "Nikova Raskol, Stormwind City", turninZone = "Stormwind City" }),
            Q("Crime and Punishment", 377, "Alliance", { level = 26, requires = 22, xp = 4400, pickup = "Councilman Millstipe, Duskwood", pickupZone = "Duskwood", turnin = "Councilman Millstipe, Duskwood", turninZone = "Duskwood" }),
            Q("What Comes Around...", 386, "Alliance", { level = 25, requires = 22, xp = 4200, pickup = "Guard Berton, Redridge Mountains", pickupZone = "Redridge Mountains", turnin = "Guard Berton, Redridge Mountains", turninZone = "Redridge Mountains" }),
            Q("The Fury Runs Deep", 378, "Alliance", { level = 27, requires = 22, xp = 2750, pickup = "Motley Garmason, Wetlands", pickupZone = "Wetlands", turnin = "Motley Garmason, Wetlands", turninZone = "Wetlands" }),
            Q("The Stockade Riots", 391, "Alliance", { level = 29, requires = 16, xp = 4950, pickup = "Warden Thelwater, Stormwind City", pickupZone = "Stormwind City", turnin = "Warden Thelwater, Stormwind City", turninZone = "Stormwind City", chainStart = { name = "The Unsent Letter", pickup = "Item drop off Edwin VanCleef, The Deadmines", zone = "The Deadmines" } }),
        },
        lootGroups = {
            { title = "Kam Deepfury", kind = "boss", tip = "Shield Slam hits the tank now and then. Keep the tank topped up.", npcID = 1666, displayID = 825, items = {
                Item("Kam's Walking Stick", "Two-Hand, Staff", 1, 2280),
                Item("Bridgebreaker Bindings", "Wrist, Cloth", nil, 273808),
                Item("Demolition Girdle", "Waist, Leather", nil, 273807),
            }},
            { title = "Bruegal Ironknuckle", kind = "boss", npcID = 1720, displayID = 2142, items = {
                Item("Prison Shank", "One-Hand, Dagger", 19, 2941),
                Item("Iron Knuckles", "One-Hand, Fist Weapon", 18, 2942),
                Item("Jimmied Handcuffs", "Wrist, Mail", 56, 3228),
            }},
            { title = "Targorr the Dread", kind = "boss", tip = "Hits harder when low on health, so save defensive cooldowns for the end.", npcID = 1696, displayID = 517, items = {
                Item("Executioner Mantle", "Shoulder, Leather", nil, 273804),
                Item("Blackrock Harness", "Chest, Leather", nil, 273805),
                Item("Dark Horde Band", "Finger", nil, 273806),
            }},
            { title = "Hamhock", kind = "boss", tip = "Chain Lightning hits the tank now and then. Keep the tank topped up.", npcID = 1717, displayID = 3250, items = {
                Item("Hamhock's Cleaver", "Main Hand, Axe", nil, 273809),
                Item("Ogre Grips", "Hands, Mail", nil, 273810),
                Item("Repurposed Rack", "Off Hand, Shield", nil, 273811),
            }},
            { title = "Dextren Ward", kind = "boss", tip = "Fears melee players now and then, and strikes the tank. Keep the tank topped up.", items = {
                Item("Boneslicer", "Two-Hand, Polearm", nil, 273819),
            }},
            { title = "Bazil Thredd", kind = "boss", tip = "A smoke bomb puts a magic debuff on everyone: dispel it if you can.", npcID = 1716, displayID = 1621, items = {
                Item("Defias Jailbreakers", "Hands, Leather", nil, 273824),
                Item("Red Wool Cloak", "Back, Cloth", nil, 273825),
                Item("Debt Collector", "Main Hand, Sword", nil, 273827),
                Item("Concealed Hand Crossbow", "Ranged, Crossbow", nil, 273829),
            }},
            { title = "Crime and Punishment", kind = "quest", faction = "Alliance", items = {
                Item("Ambassador's Boots", "Feet, Leather", nil, 2033),
                Item("Darkshire Mail Leggings", "Legs, Mail", nil, 2906),
                Item("Town Clerk's Mittens", "Hands, Cloth", nil, 270029),
            }},
            { title = "What Comes Around...", kind = "quest", faction = "Alliance", items = {
                Item("Hardened Root Staff", "Two-Hand, Staff", nil, 1317),
                Item("Lucine Longsword", "One-Hand, Sword", nil, 3400),
                Item("Ursine Hammer", "Two-Hand, Mace", nil, 270027),
            }},
            { title = "The Fury Runs Deep", kind = "quest", faction = "Alliance", items = {
                Item("Headbasher", "Two-Hand, Mace", nil, 1264),
                Item("Belt of Vindication", "Waist, Leather", nil, 3562),
                Item("Magistrate's Pantaloons", "Legs, Cloth", nil, 270036),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=721) for boss loot + quest rewards. Boss order web-search-verified: confirmed Crowd Pummeler 9-60 and Dark Iron Ambassador are real despite looking dubious from memory, and removed Blastmaster Emi Shortfuse (she's the NPC who summons Grubbis, not a lootable boss). Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28.
    {
        name = "Gnomeregan", art = 131841, zone = "Dun Morogh", levelMin = 29, levelMax = 38, faction = "Both", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("Rig Wars", 2841, "Horde", { level = 35, requires = 25, xp = 2750, pickup = "Nogg, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Nogg, Orgrimmar", turninZone = "Orgrimmar" }),
            Q("Chief Engineer Scooty", 2842, "Horde", { level = 35, requires = 20, xp = 275, pickup = "Sovik, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Scooty, Stranglethorn Vale", turninZone = "Stranglethorn Vale" }),
            Q("Gnomer-gooooone!", 2843, "Horde", { level = 35, requires = 20, pickup = "Scooty, Stranglethorn Vale", pickupZone = "Stranglethorn Vale", turnin = "Scooty, Stranglethorn Vale", turninZone = "Stranglethorn Vale", chainStart = { name = "Chief Engineer Scooty", pickup = "Sovik, Orgrimmar", zone = "Orgrimmar" } }),
            Q("Save Techbot's Brain!", 2922, "Alliance", { level = 26, requires = 20, xp = 4750, pickup = "Tinkmaster Overspark, Ironforge", pickupZone = "Ironforge", turnin = "Tinkmaster Overspark, Ironforge", turninZone = "Ironforge", chainStart = { name = "Tinkmaster Overspark", pickup = "Brother Sarno, Stormwind City", zone = "Stormwind City" } }),
            Q("Gyrodrillmatic Excavationators", 2928, "Alliance", { level = 30, requires = 20, xp = 4400, pickup = "Shoni the Shilent, Stormwind City", pickupZone = "Stormwind City", turnin = "Shoni the Shilent, Stormwind City", turninZone = "Stormwind City" }),
            Q("Essential Artificials", 2924, "Alliance", { level = 30, requires = 24, xp = 3050, pickup = "Klockmort Spannerspan, Ironforge", pickupZone = "Ironforge", turnin = "Klockmort Spannerspan, Ironforge", turninZone = "Ironforge", chainStart = { name = "Klockmort's Essentials", pickup = "Mathiel, Darnassus", zone = "Darnassus" } }),
            Q("Data Rescue", 2930, "Alliance", { level = 30, requires = 25, xp = 3650, pickup = "Master Mechanic Castpipe, Ironforge", pickupZone = "Ironforge", turnin = "Master Mechanic Castpipe, Ironforge", turninZone = "Ironforge", chainStart = { name = "Castpipe's Task", pickup = "Gaxim Rustfizzle, Stonetalon Mountains", zone = "Stonetalon Mountains" } }),
            Q("The Grand Betrayal", 2929, "Alliance", { level = 35, requires = 25, xp = 2750, pickup = "High Tinker Mekkatorque, Ironforge", pickupZone = "Ironforge", turnin = "High Tinker Mekkatorque, Ironforge", turninZone = "Ironforge" }),
            Q("Gnogaine", 2926, "Alliance", { level = 27, requires = 20, xp = 3950, pickup = "Ozzie Togglevolt, Dun Morogh", pickupZone = "Dun Morogh", turnin = "Ozzie Togglevolt, Dun Morogh", turninZone = "Dun Morogh" }),
            Q("The Only Cure is More Green Glow", 2962, "Alliance", { level = 30, requires = 20, xp = 4400, pickup = "Ozzie Togglevolt, Dun Morogh", pickupZone = "Dun Morogh", turnin = "Ozzie Togglevolt, Dun Morogh", turninZone = "Dun Morogh" }),
            Q("The Sparklematic 5200!", 2951, nil, { level = 30, requires = 25, pickup = "The Sparklematic 5200, Gnomeregan", pickupZone = "Gnomeregan", turnin = "The Sparklematic 5200, Gnomeregan", turninZone = "Gnomeregan" }),
            Q("A Fine Mess", 2904, nil, { level = 30, requires = 20, xp = 5800, pickup = "Kernobee, Gnomeregan", pickupZone = "Gnomeregan", turnin = "Scooty, Stranglethorn Vale", turninZone = "Stranglethorn Vale" }),
            Q("Grime-Encrusted Ring", 2945, nil, { level = 34, requires = 28, xp = 2700, pickup = "Item start: Grime-Encrusted Ring, dropped by Dark Iron Agents", pickupZone = "Gnomeregan", turnin = "The Sparklematic 5200, Gnomeregan", turninZone = "Gnomeregan" }),
        },
                lootGroups = {
            { title = "Grubbis", kind = "boss", encounterID = 2925, npcID = 7361, displayID = 144378, items = {
                Item("Grubbis Paws", "Hands, Mail", 8, 9445),
                Item("Skullduggery Belt", "Waist, Leather", nil, 274042),
                Item("Irradiated Shield", "Off Hand, Shield", nil, 274043),
            }},
            { title = "Viscous Fallout", kind = "boss", encounterID = 2928, npcID = 7079, displayID = 5497, items = {
                Item("Hydrocane", "Two-Hand, Staff", 19, 9452),
                Item("Toxic Revenger", "One-Hand, Dagger", 18, 9453),
                Item("Acidic Walkers", "Feet, Cloth", 60, 9454),
            }},
            { title = "Electrocutioner 6000", kind = "boss", encounterID = 2927, tip = "Face him away from the group, as his megavolt hits a cone in front. Attack from behind or the side, and interrupt his chain bolt.", npcID = 6235, displayID = 6915, items = {
                Item("Workshop Key", "Non-equippable, Key", 81, 6893),
                Item("Electrocutioner Leg", "One-Hand, Sword", 16, 9446),
                Item("Electrocutioner Lagnut", "Finger, Miscellaneous", 32, 9447),
                Item("Spidertank Oilrag", "Wrist, Cloth", 40, 9448),
            }},
            { title = "Crowd Pummeler 9-60", kind = "boss", encounterID = 2899, tip = "Face him away from the group, as his smash hits a cone in front. Ranged players stay back from his stomp and pummel.", npcID = 6229, displayID = 6774, items = {
                Item("Gnomebot Operating Boots", "Feet, Leather", 65, 9450),
                Item("Manual Crowd Pummeler", "Two-Hand, Mace", 33, 9449),
                Item("Schematic: 9-60 Battery Pack", "Non-equippable, Engineering", nil, 274049),
                Item("Thermaplugg Medal of Honor", "Neck, Miscellaneous", nil, 274068),
            }},
            { title = "Dark Iron Ambassador", kind = "boss", npcID = 6228, displayID = 6669, items = {
                Item("Glass Shooter", "Ranged, Gun", 33, 9456),
                Item("Emissary Cuffs", "Wrist, Leather", 43, 9455),
                Item("Royal Diplomatic Scepter", "One-Hand, Mace", 20, 9457),
            }},
            { title = "Mekgineer Thermaplugg", kind = "boss", encounterID = 2940, tip = "Knocks the tank back, so stand with your back to a wall. Ranged players stay back.", npcID = 7800, displayID = 6980, items = {
                Item("Schematic: Discombobulator Ray", "Non-equippable, Engineering", 1, 4413),
                Item("Schematic: Flame Deflector", "Non-equippable, Engineering", 1, 4411),
                Item("Schematic: Gnomish Universal Remote", "Non-equippable, Engineering", 0, 7560),
                Item("Schematic: Goblin Jumper Cables", "Non-equippable, Engineering", 0, 7561),
                Item("Thermaplugg's Safe Combination", "Non-equippable, Key", 19, 9299),
                Item("Thermaplugg's Left Arm", "Two-Hand, Axe", 18, 9459),
                Item("Charged Gear", "Finger, Miscellaneous", 33, 9461),
                Item("Thermaplugg's Central Core", "Off Hand, Shield", 32, 9458),
                Item("Electromagnetic Gigaflux Reactivator", "Head, Cloth", 10, 9492),
                Item("Fluorescent Green Mechanostrider", "Non-equippable, Mount", nil, 13325),
            }},
            { title = "Rig Wars", kind = "quest", faction = "Horde", items = {
                Item("Dual Reinforced Leggings", "Legs, Mail", nil, 9625),
                Item("Triprunner Dungarees", "Legs, Leather", nil, 9624),
                Item("Civinad Robes", "Chest, Cloth", nil, 9623),
            }},
            { title = "Gyrodrillmatic Excavationators", kind = "quest", faction = "Alliance", items = {
                Item("Shoni's Disarming Tool", "Off Hand, Axe", nil, 9608),
                Item("Shilly Mitts", "Hands, Cloth", nil, 9609),
                Item("Operator's Gloves", "Hands, Leather", nil, 270045),
            }},
            { title = "Data Rescue", kind = "quest", faction = "Alliance", items = {
                Item("Mechanic's Pipehammer", "Two-Hand, Mace", nil, 9604),
                Item("Repairman's Cape", "Back, Cloth", nil, 9605),
            }},
            { title = "The Grand Betrayal", kind = "quest", faction = "Alliance", items = {
                Item("Dual Reinforced Leggings", "Legs, Mail", nil, 9625),
                Item("Triprunner Dungarees", "Legs, Leather", nil, 9624),
                Item("Civinad Robes", "Chest, Cloth", nil, 9623),
            }},
            { title = "A Fine Mess", kind = "quest", items = {
                Item("Fairywing Mantle", "Shoulder, Cloth", nil, 9536),
                Item("Fire-welded Bracers", "Wrist, Mail", nil, 9535),
                Item("Technician's Bracers", "Wrist, Leather", nil, 270042),
            }},
        },
    },
-- [SOURCE 2026-10-26] Boss loot re-read from wowhead.com/forever/zone=491: 5 Forever-new drops added (274149, 274155, 274159, 274160, 274161) and Death Prophet Spine moved from Agathelos to Aggem Thorncurse (Wowhead). [earlier: 2026-09-27] npm classic-items db (zone=491) for boss loot + quest rewards. Boss order web-search-verified: 3 trash entries removed (Death's Head Priest/Ward Keeper, Razorfen Spearhide), real 8-boss order confirmed. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28. Boss loot cross-checked 2026-09-28 against wowtbc.gg's WoW Forever dungeon loot tables (which boss drops what; items marked NEW there), with every added ID, name and slot confirmed on wowhead.com/forever.
    {
        name = "Razorfen Kraul", art = 131865, zone = "The Barrens", levelMin = 30, levelMax = 40, faction = "Both", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("A Vengeful Fate", 1102, "Horde", { level = 34, requires = 29, xp = 4050, pickup = "Auld Stonespire, Thunder Bluff", pickupZone = "Thunder Bluff", turnin = "Auld Stonespire, Thunder Bluff", turninZone = "Thunder Bluff" }),
            Q("Going, Going, Guano!", 1109, "Horde", { level = 33, requires = 30, xp = 3300, pickup = "Master Apothecary Faranell, Undercity", pickupZone = "Undercity", turnin = "Master Apothecary Faranell, Undercity", turninZone = "Undercity" }),
            Q("An Unholy Alliance", 6522, "Horde", { level = 36, requires = 28, xp = 2800, pickup = "Item start: Small Scroll, dropped by Charlga Razorflank", pickupZone = "Razorfen Kraul", turnin = "Varimathras, Undercity", turninZone = "Undercity" }),
            Q("The Crone of the Kraul", 1101, "Alliance", { level = 34, requires = 29, xp = 3350, pickup = "Falfindel Waywarder, Feralas", pickupZone = "Feralas", turnin = "Falfindel Waywarder, Feralas", turninZone = "Feralas", chainStart = { name = "Lonebrow's Journal", pickup = "Item start: Henrig Lonebrow's Journal, found in Thousand Needles", zone = "Thousand Needles" } }),
            Q("Mortality Wanes", 1142, "Alliance", { level = 30, requires = 25, xp = 3050, pickup = "Heralath Fallowbrook, Razorfen Kraul", pickupZone = "Razorfen Kraul", turnin = "Treshala Fallowbrook, Darnassus", turninZone = "Darnassus" }),
            Q("Blueleaf Tubers", 1221, nil, { level = 26, requires = 20, xp = 5000, pickup = "Mebok Mizzyrix, The Barrens", pickupZone = "The Barrens", turnin = "Mebok Mizzyrix, The Barrens", turninZone = "The Barrens" }),
            Q("Willix the Importer", 1144, nil, { level = 30, requires = 22, xp = 7250, pickup = "Willix the Importer, Razorfen Kraul", pickupZone = "Razorfen Kraul", turnin = "Willix the Importer, Razorfen Kraul", turninZone = "Razorfen Kraul" }),
        },
                lootGroups = {
            { title = "Roogug", kind = "boss", encounterID = 2773, tip = "Lightning bolts hit the tank. Keep the tank topped up.", npcID = 6168, displayID = 6110, items = {
                Item("Vial of Phlogiston", "Non-equippable, Consumable", 64, 6841),
                Item("Roogug's Severed Head", "Trinket", nil, 274152),
                Item("Thornweaver Drape", "Back, Cloth", nil, 274149),
                Item("Geomancer Headdress", "Head, Leather", nil, 274155),
            }},
            { title = "Aggem Thorncurse", kind = "boss", encounterID = 2774, tip = "A boar spirit joins every so often. Pick it up, or kill or control it.", npcID = 4424, displayID = 6097, items = {
                Item("Thornspike", "One-Hand, Dagger", 53, 6681),
                Item("Death Prophet Spine", "Two-Hand, Staff", nil, 274158),
                Item("Thorncursed Grips", "Hands, Leather", nil, 274159),
            }},
            { title = "Death Speaker Jargba", kind = "boss", encounterID = 2775, tip = "Two adds join at the start. He takes over a player: control them, don't hurt them. Shadow bolts hit the tank.", npcID = 4428, displayID = 4644, items = {
                Item("Death Speaker Scepter", "Main Hand, Mace", 10, 2816),
                Item("Death Speaker Mantle", "Shoulder, Cloth", 44, 6685),
                Item("Death Speaker Robes", "Chest, Cloth", 43, 6682),
            }},
            { title = "Overlord Ramtusk", kind = "boss", encounterID = 2776, tip = "Thunderclap hits everyone close by, so ranged players stay back.", npcID = 4420, displayID = 4652, items = {
                Item("Tusken Helm", "Head, Mail", 62, 6686),
                Item("Quillord Mail Leggings", "Legs, Mail", nil, 274161),
                Item("Corpsemaker", "Two-Hand, Axe", 34, 6687),
            }},
            { title = "Earthcaller Halmgar", kind = "boss", npcID = 4842, displayID = 6102, items = {
                Item("Wind Spirit Staff", "Two-Hand, Staff", 48, 6689),
                Item("Whisperwind Headdress", "Head, Leather", 46, 6688),
            }},
            { title = "Agathelos the Raging", kind = "boss", encounterID = 2777, tip = "Enrages when low on health, so save defensive cooldowns. Ranged players stay back from his rampage.", npcID = 4422, displayID = 2450, items = {
                Item("Ferine Leggings", "Legs, Leather", 63, 6690),
                Item("Swinetusk Shank", "One-Hand, Dagger", 33, 6691),
                Item("Quilrager Throwing Axe", "Thrown, Thrown", nil, 274160),
            }},
            { title = "Blind Hunter", kind = "boss", npcID = 4425, displayID = 4735, items = {
                Item("Stygian Bone Amulet", "Neck, Miscellaneous", 27, 6695),
                Item("Batwing Mantle", "Shoulder, Cloth", 34, 6697),
                Item("Nightstalker Bow", "Ranged, Bow", 33, 6696),
            }},
            { title = "Charlga Razorflank", kind = "boss", encounterID = 2778, tip = "Chain bolts hit the tank often. Keep the tank topped up.", npcID = 4421, displayID = 4642, items = {
                Item("Pronged Reaver", "One-Hand, Axe", 18, 6692),
                Item("Agamaggan's Clutch", "Finger, Miscellaneous", 35, 6693),
                Item("Heart of Agamaggan", "Off Hand, Shield", 34, 6694),
                Item("Small Scroll", "Non-equippable, Junk", 45, 17008),
            }},
            { title = "A Vengeful Fate", kind = "quest", faction = "Horde", items = {
                Item("Berylline Pads", "Shoulder, Cloth", nil, 4197),
                Item("Marbled Buckler", "Off Hand, Shield", nil, 6725),
                Item("Stonefist Girdle", "Waist, Mail", nil, 6742),
            }},
            { title = "An Unholy Alliance", kind = "quest", faction = "Horde", items = {
                Item("Skullbreaker", "One-Hand, Mace", nil, 17039), -- the reward of the chain's last step (quest 6521)
            }},
            { title = "The Crone of the Kraul", kind = "quest", faction = "Alliance", items = {
                Item("Berylline Pads", "Shoulder, Cloth", nil, 4197),
                Item("Marbled Buckler", "Off Hand, Shield", nil, 6725),
                Item("Stonefist Girdle", "Waist, Mail", nil, 6742),
                Item("\"Mage-Eye\" Blunderbuss", "Ranged, Gun", nil, 3041),
            }},
            { title = "Mortality Wanes", kind = "quest", faction = "Alliance", items = {
                Item("Lancer Boots", "Feet, Leather", nil, 6752),
            }},
            { title = "Blueleaf Tubers", kind = "quest", items = {
                Item("A Small Container of Gems", "Non-equippable, Junk", nil, 6755),
            }},
            { title = "Willix the Importer", kind = "quest", items = {
                Item("Monkey Ring", "Finger, Miscellaneous", nil, 6748),
                Item("Snake Hoop", "Finger, Miscellaneous", nil, 6750),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=796, shared by all 4 wings) manually split per-wing and web-search-verified after an earlier wrong "cross-contamination" call was corrected (Bloodmage Thalnos, Fallen Champion, Azshir the Sleepless, Ironspine are all genuinely here). Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28.
    {
        name = "Scarlet Monastery: Graveyard", art = 131852, zone = "Tirisfal Glades", levelMin = 28, levelMax = 38, faction = "Both", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("Into The Scarlet Monastery", 1048, "Horde", { level = 42, requires = 33, xp = 5150, pickup = "Varimathras, Undercity", pickupZone = "Undercity", turnin = "Varimathras, Undercity", turninZone = "Undercity" }),
            Q("In the Name of the Light", 1053, "Alliance", { level = 40, requires = 34, xp = 4700, pickup = "Raleigh the Devout, Hillsbrad Foothills", pickupZone = "Hillsbrad Foothills", turnin = "Raleigh the Devout, Hillsbrad Foothills", turninZone = "Hillsbrad Foothills" }),
            Q("Vorrel's Revenge", 1051, "Horde", { level = 33, requires = 25, xp = 3300, pickup = "Vorrel Sengutz, Scarlet Monastery", pickupZone = "Scarlet Monastery", turnin = "Monika Sengutz, Hillsbrad Foothills", turninZone = "Hillsbrad Foothills" }),
            Q("Hearts of Zeal", 1113, "Horde", { level = 33, requires = 30, xp = 3300, pickup = "Master Apothecary Faranell, Undercity", pickupZone = "Undercity", turnin = "Master Apothecary Faranell, Undercity", turninZone = "Undercity", chainStart = { name = "Going, Going, Guano!", pickup = "Master Apothecary Faranell, Undercity", zone = "Undercity" } }),
        },
        lootGroups = {
            { title = "Interrogator Vishas", kind = "boss", encounterID = 444, npcID = 3983, displayID = 2044, items = {
                Item("Torturing Poker", "One-Hand, Dagger", 6, 7682),
                Item("Bloody Brass Knuckles", "One-Hand, Fist Weapon", 55, 7683),
            }},
            { title = "Bloodmage Thalnos", kind = "boss", encounterID = 2779, npcID = 4543, displayID = 11396, items = {
                Item("Bloodmage Mantle", "Shoulder, Cloth", 48, 7684),
                Item("Orb of the Forgotten Seer", "Held In Off-hand, Miscellaneous", 50, 7685),
            }},
            { title = "Fallen Champion", kind = "boss", npcID = 6488, displayID = 5230, items = {
                Item("Morbid Dawn", "Two-Hand, Sword", 18, 7689),
                Item("Ebon Vise", "Hands, Leather", 39, 7690),
                Item("Embalmed Shroud", "Head, Cloth", 39, 7691),
            }},
            { title = "Azshir the Sleepless", kind = "boss", npcID = 6490, displayID = 5534, items = {
                Item("Necrotic Wand", "Ranged, Wand", 32, 7708),
                Item("Blighted Leggings", "Legs, Cloth", 31, 7709),
                Item("Ghostshard Talisman", "Neck, Miscellaneous", 34, 7731),
            }},
            { title = "Ironspine", kind = "boss", npcID = 6489, displayID = 5231, items = {
                Item("Ironspine's Ribcage", "Chest, Mail", 36, 7688),
                Item("Ironspine's Fist", "One-Hand, Mace", 20, 7687),
                Item("Ironspine's Eye", "Finger, Miscellaneous", 40, 7686),
            }},
        },
    },
-- [SOURCE 2026-09-27] Same pass as Scarlet Monastery: Graveyard - see that block's tag for the full story. Quest levels, required levels, start/end NPCs + zones and faction (Side) checked on wowhead.com/forever quest pages 2026-09-28.
-- UPDATE 2026-10-20: Past Due (96800, Alliance, L38, req 30, Magus Olvek starts and ends it; Wowhead has no location for him) added here: it asks for The Lost Magic of the Runemasters, a book like Mythology of the Titans, but Wowhead and ForeverDB only say "Scarlet Monastery", so the wing is a guess. Rewards from Wowhead, slots from ForeverDB. No XP shown.
    {
        name = "Scarlet Monastery: Library", art = 131852, zone = "Tirisfal Glades", levelMin = 29, levelMax = 39, faction = "Both", status = "classic",
        verified = { bosses = "2026-09-27", levelRange = "2026-09-28", chains = "2026-09-29" },
        quests = {
            Q("Compendium of the Fallen", 1049, "Horde", { races = { 2, 6, 8 }, level = 38, requires = 28, xp = 3550, pickup = "Sage Truthseeker, Thunder Bluff", pickupZone = "Thunder Bluff", turnin = "Sage Truthseeker, Thunder Bluff", turninZone = "Thunder Bluff" }),
            Q("Test of Lore", 1160, "Horde", { level = 36, requires = 25, xp = 2100, pickup = "Parqual Fintallas, Undercity", pickupZone = "Undercity", turnin = "Parqual Fintallas, Undercity", turninZone = "Undercity", chainStart = { name = "Test of Faith", pickup = "Dorn Plainstalker, Thousand Needles", zone = "Thousand Needles" } }),
            Q("Mythology of the Titans", 1050, "Alliance", { level = 38, requires = 28, xp = 3550, pickup = "Librarian Mae Paledust, Ironforge", pickupZone = "Ironforge", turnin = "Librarian Mae Paledust, Ironforge", turninZone = "Ironforge" }),
            Q("Past Due", 96800, "Alliance", { level = 38, requires = 30, pickup = "Magus Olvek", turnin = "Magus Olvek" }),
            Q("Rituals of Power", 1951, nil, { class = "MAGE", level = 40, requires = 30, xp = 3150, pickup = "Magus Tirth", turnin = "Tabetha", chainStart = { name = "Hidden Secrets", pickup = "Tabetha, Dustwallow Marsh", zone = "Dustwallow Marsh" } }),
        },
        lootGroups = {
            { title = "Houndmaster Loksey", kind = "boss", encounterID = 446, npcID = 3974, displayID = 2040, items = {
                Item("Dog Whistle", "Non-equippable, Consumable", 25, 3456),
                Item("Loksey's Training Stick", "Two-Hand, Staff", 14, 7710),
                Item("Dog Training Gloves", "Hands, Leather", 56, 7756),
            }},
            { title = "Arcanist Doan", kind = "boss", encounterID = 447, npcID = 6487, displayID = 5266, items = {
                Item("Mantle of Doan", "Shoulder, Cloth", 47, 7712),
                Item("Hypnotic Blade", "Main Hand, Dagger", 47, 7714),
                Item("Robe of Doan", "Chest, Cloth", 46, 7711),
                Item("Illusionary Rod", "Two-Hand, Staff", 47, 7713),
            }},
            { title = "Past Due", kind = "quest", faction = "Alliance", items = {
                Item("Salve and Salvation", "Held In Off-hand", nil, 276898),
                Item("Knucklebound Thimble", "Finger", nil, 276899),
            }},
        },
    },
-- [SOURCE 2026-10-07] Same pass as Scarlet Monastery: Graveyard. Bosses and drops re-checked on Wowhead's Forever zone 796 drops and wowtbc.gg's Armory page: Herod's Shoulder (7718) is not in Forever's item database (its Wowhead page doesn't exist), so it's left out. Quests and chains are Graveyard's, checked there.
    {
        name = "Scarlet Monastery: Armory", art = 131852, zone = "Tirisfal Glades", levelMin = 32, levelMax = 42, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-07", levelRange = "2026-10-07", chains = "2026-10-07" },
        quests = {
            Q("Into The Scarlet Monastery", 1048, "Horde", { level = 42, requires = 33, xp = 5150, pickup = "Varimathras, Undercity", pickupZone = "Undercity", turnin = "Varimathras, Undercity", turninZone = "Undercity" }),
            Q("In the Name of the Light", 1053, "Alliance", { level = 40, requires = 34, xp = 4700, pickup = "Raleigh the Devout, Hillsbrad Foothills", pickupZone = "Hillsbrad Foothills", turnin = "Raleigh the Devout, Hillsbrad Foothills", turninZone = "Hillsbrad Foothills" }),
        },
        notes = "Into The Scarlet Monastery and In the Name of the Light need Herod (here), Loksey, Mograine and Whitemane (Wowhead's Every Dungeon Quest guide, 2026-10-02).",
        lootGroups = {
            { title = "Herod", kind = "boss", encounterID = 448, items = {
                Item("Ravager", "Two-Hand, Axe", 14, 7717),
                Item("Raging Berserker's Helm", "Head, Mail", 32, 7719),
            }},
            { title = "Scarlet Champion", kind = "boss", items = {
                Item("Scarlet Chestpiece", "Chest, Mail", 0, 10328),
            }},
            { title = "Scarlet Centurion", kind = "boss", items = {
                Item("Scarlet Gauntlets", "Hands, Mail", 2, 10331),
            }},
        },
    },
-- [SOURCE 2026-10-07] Same pass as Scarlet Monastery: Graveyard. Bosses and drops re-checked on Wowhead's Forever zone 796 drops and wowtbc.gg's Cathedral page: Whitemane's Chapeau (7720) and Triune Amulet (7722) are not in Forever's item database, so they're left out. Quests and chains are Graveyard's, checked there.
    {
        name = "Scarlet Monastery: Cathedral", art = 131852, zone = "Tirisfal Glades", levelMin = 35, levelMax = 45, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-07", levelRange = "2026-10-07", chains = "2026-10-07" },
        quests = {
            Q("Into The Scarlet Monastery", 1048, "Horde", { level = 42, requires = 33, xp = 5150, pickup = "Varimathras, Undercity", pickupZone = "Undercity", turnin = "Varimathras, Undercity", turninZone = "Undercity" }),
            Q("In the Name of the Light", 1053, "Alliance", { level = 40, requires = 34, xp = 4700, pickup = "Raleigh the Devout, Hillsbrad Foothills", pickupZone = "Hillsbrad Foothills", turnin = "Raleigh the Devout, Hillsbrad Foothills", turninZone = "Hillsbrad Foothills" }),
        },
        notes = "Into The Scarlet Monastery and In the Name of the Light need Mograine and Whitemane (here), Herod and Loksey (Wowhead's Every Dungeon Quest guide, 2026-10-02).",
        lootGroups = {
            { title = "High Inquisitor Whitemane", kind = "boss", encounterID = 450, items = {
                Item("Hand of Righteousness", "Main Hand, Mace", 19, 7721),
            }},
            { title = "Scarlet Commander Mograine", kind = "boss", items = {
                Item("Mograine's Might", "Two-Hand, Mace", 19, 7723),
                Item("Gauntlets of Divinity", "Hands, Mail", 20, 7724),
                Item("Aegis of the Scarlet Commander", "Off Hand, Shield", 42, 7726),
            }},
            { title = "High Inquisitor Fairbanks", kind = "boss", encounterID = 449, items = {
                Item("Inquisitor's Shawl", "Shoulder, Cloth", 34, 19507),
                Item("Branded Leather Bracers", "Wrist, Leather", 32, 19508),
                Item("Dusty Mail Boots", "Feet, Mail", 32, 19509),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=722) for boss loot + quest rewards. Boss order web-search-verified: removed Lady Falther'ess (tied to a 2008 Scourge Invasion world event, not standard content), real 6-boss order confirmed.
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): all 6 present.
    {
        name = "Razorfen Downs", art = 131864, zone = "The Barrens", levelMin = 40, levelMax = 50, faction = "Horde", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            Q("Bring the End", 3341, "Horde", { level = 42, requires = 37, xp = 4300, pickup = "Andrew Brownell, Undercity", pickupZone = "Undercity", turnin = "Andrew Brownell, Undercity", turninZone = "Undercity" }),
            Q("An Unholy Alliance", 6521, "Horde", { level = 36, requires = 28, xp = 3500, pickup = "Varimathras, Undercity", pickupZone = "Undercity", turnin = "Varimathras, Undercity", turninZone = "Undercity" }),
            Q("Bring the Light", 3636, "Alliance", { level = 42, requires = 39, xp = 4300, pickup = "Archbishop Benedictus, Stormwind City", pickupZone = "Stormwind City", turnin = "Archbishop Benedictus, Stormwind City", turninZone = "Stormwind City" }),
            Q("A Host of Evil", 6626, nil, { level = 35, requires = 28, xp = 3450, pickup = "Myriam Moonsinger, The Barrens", pickupZone = "The Barrens", turnin = "Myriam Moonsinger, The Barrens", turninZone = "The Barrens" }),
            Q("Scourge of the Downs", 3523, nil, { level = 37, requires = 32, xp = 285, pickup = "Belnistrasz, Razorfen Downs", pickupZone = "Razorfen Downs", turnin = "Belnistrasz, Razorfen Downs", turninZone = "Razorfen Downs" }),
            Q("Extinguishing the Idol", 3525, nil, { level = 37, requires = 32, xp = 4250, pickup = "Belnistrasz, Razorfen Downs", pickupZone = "Razorfen Downs", turnin = "Belnistrasz's Brazier" }),
        },
                lootGroups = {
            { title = "Tuten'kash", kind = "boss", encounterID = 2780, items = {
                Item("Carapace of Tuten'kash", "Chest, Plate", 32, 10775),
                Item("Silky Spider Cape", "Back, Cloth", 34, 10776),
                Item("Arachnid Gloves", "Hands, Leather", 30, 10777),
            }},
            { title = "Mordresh Fire Eye", kind = "boss", encounterID = 2782, items = {
                Item("Deathmage Sash", "Waist, Cloth", 32, 10771),
                Item("Glowing Eye of Mordresh", "Neck, Miscellaneous", 32, 10769),
                Item("Mordresh's Lifeless Skull", "Held In Off-hand, Miscellaneous", 33, 10770),
            }},
            { title = "Glutton", kind = "boss", encounterID = 2784, items = {
                Item("Glutton's Cleaver", "One-Hand, Axe", 50, 10772),
                Item("Fleshhide Shoulders", "Shoulder, Leather", 48, 10774),
            }},
            { title = "Ragglesnout", kind = "boss", encounterID = 2783, items = {
                Item("X'caliboar", "Two-Hand, Sword", 20, 10758),
                Item("Boar Champion's Belt", "Waist, Mail", 38, 10768),
                Item("Savage Boar's Guard", "Off Hand, Shield", 40, 10767),
            }},
            { title = "Plaguemaw the Rotting", kind = "boss", encounterID = 2781, items = {
                Item("Swine Fists", "Hands, Leather", 63, 10760),
                Item("Plaguerot Sprig", "Ranged, Wand", 33, 10766),
            }},
            { title = "Amnennar the Coldbringer", kind = "boss", encounterID = 2785, items = {
                Item("Coldrage Dagger", "One-Hand, Dagger", 19, 10761),
                Item("Robes of the Lich", "Chest, Cloth", 39, 10762),
                Item("Icemetal Barbute", "Head, Plate", 37, 10763),
                Item("Deathchill Armor", "Chest, Mail", 29, 10764),
                Item("Bonefingers", "Hands, Leather", 27, 10765),
            }},
            { title = "Bring the End", kind = "quest", faction = "Horde", items = {
                Item("Vanquisher's Sword", "One-Hand, Sword", nil, 10823),
                Item("Amberglow Talisman", "Neck, Miscellaneous", nil, 10824),
            }},
            { title = "An Unholy Alliance", kind = "quest", faction = "Horde", items = {
                Item("Skullbreaker", "One-Hand, Mace", nil, 17039), -- the reward of the chain's last step (quest 6521)
            }},
            { title = "Bring the Light", kind = "quest", faction = "Alliance", items = {
                Item("Vanquisher's Sword", "One-Hand, Sword", nil, 10823),
                Item("Amberglow Talisman", "Neck, Miscellaneous", nil, 10824),
            }},
            { title = "Extinguishing the Idol", kind = "quest", items = {
                Item("Dragonclaw Ring", "Finger, Miscellaneous", nil, 10710),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=1337) for boss loot + quest rewards. Boss order web-search-verified: removed Stonevault Brawler (an add during the Grimlok fight, not a boss), kept Ancient Stone Keeper despite looking dubious from memory (confirmed real), real order set.
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): Obsidian Sentinel added (no loot recorded yet); The Lost Dwarves are Olaf and Baelog.
    {
        name = "Uldaman", art = 131876, zone = "Badlands", levelMin = 42, levelMax = 52, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            Q("Reclaimed Treasures", 2342, "Horde", { level = 43, requires = 33, xp = 3600, pickup = "Patrick Garrett, Undercity", pickupZone = "Undercity", turnin = "Patrick Garrett, Undercity", turninZone = "Undercity" }),
            Q("Uldaman Reagent Run", 2202, "Horde", { level = 42, requires = 36, xp = 3450, pickup = "Jarkal Mossmeld, Badlands", pickupZone = "Badlands", turnin = "Jarkal Mossmeld, Badlands", turninZone = "Badlands" }),
            Q("Necklace Recovery", 2283, "Horde", { level = 41, requires = 37, xp = 2450, pickup = "Dran Droffers, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Dran Droffers, Orgrimmar", turninZone = "Orgrimmar" }),
            Q("Reclaimed Treasures", 1360, "Alliance", { level = 43, requires = 33, xp = 3600, pickup = "Krom Stoutarm, Ironforge", pickupZone = "Ironforge", turnin = "Krom Stoutarm, Ironforge", turninZone = "Ironforge" }),
            Q("The Lost Dwarves", 2398, "Alliance", { level = 40, requires = 35, xp = 315, pickup = "Prospector Stormpike, Ironforge", pickupZone = "Ironforge", turnin = "Baelog, Uldaman", turninZone = "Uldaman" }),
            Q("The Hidden Chamber", 2240, "Alliance", { level = 40, requires = 35, xp = 3900, pickup = "Baelog, Uldaman", pickupZone = "Uldaman", turnin = "Prospector Stormpike, Ironforge", turninZone = "Ironforge" }),
            Q("Uldaman Reagent Run", 17, "Alliance", { level = 42, requires = 38, xp = 3450, pickup = "Ghak Healtouch, Loch Modan", pickupZone = "Loch Modan", turnin = "Ghak Healtouch, Loch Modan", turninZone = "Loch Modan" }),
            Q("Agmond's Fate", 704, "Alliance", { level = 38, requires = 30, xp = 2850, pickup = "Prospector Ironband, Loch Modan", pickupZone = "Loch Modan", turnin = "Prospector Ironband, Loch Modan", turninZone = "Loch Modan" }),
            Q("The Lost Tablets of Will", 1139, "Alliance", { level = 45, requires = 35, xp = 5850, pickup = "Advisor Belgrum, Ironforge", pickupZone = "Ironforge", turnin = "Advisor Belgrum, Ironforge", turninZone = "Ironforge" }),
            Q("The Shattered Necklace", 2198, "Alliance", { level = 41, requires = 37, xp = 3300, turnin = "Talvash del Kissel, Ironforge", turninZone = "Ironforge" }),
            Q("Power Stones", 2418, nil, { level = 36, requires = 30, xp = 3500, pickup = "Rigglefuzz, Badlands", pickupZone = "Badlands", turnin = "Rigglefuzz, Badlands", turninZone = "Badlands" }),
            Q("Solution to Doom", 709, nil, { level = 40, requires = 30, xp = 3150, pickup = "Theldurin the Lost, Badlands", pickupZone = "Badlands", turnin = "Theldurin the Lost, Badlands", turninZone = "Badlands" }),
            Q("The Platinum Discs", 2278, nil, { level = 47, requires = 40, xp = 4200, pickup = "The Discs of Norgannon", turnin = "The Discs of Norgannon" }),
            Q("Power in Uldaman", 1956, nil, { class = "MAGE", level = 40, requires = 35, xp = 3900, pickup = "Tabetha, Dustwallow Marsh", pickupZone = "Dustwallow Marsh", turnin = "Tabetha, Dustwallow Marsh", turninZone = "Dustwallow Marsh" }),
        },
                lootGroups = {
            { title = "Revelosh", kind = "boss", encounterID = 547, items = {
                Item("Revelosh's Spaulders", "Shoulder, Leather", 23, 9389),
                Item("Revelosh's Boots", "Feet, Plate", 23, 9387),
                Item("Revelosh's Armguards", "Wrist, Mail", 21, 9388),
                Item("Revelosh's Gloves", "Hands, Cloth", 22, 9390),
            }},
            { title = "Olaf", kind = "boss", items = {
                Item("Light Armor Kit", "Non-equippable, Item Enhancement", 27, 2304),
                Item("Battered Viking Shield", "Off Hand, Shield", 79, 9403),
                Item("Olaf's All Purpose Shield", "Off Hand, Shield", 12, 9404),
            }},
            { title = "Baelog", kind = "boss", items = {
                Item("Baelog's Shortbow", "Ranged, Bow", 44, 9400),
                Item("Precision Arrow", "Ammo, Arrow", 88, 9399),
                Item("Nordic Longshank", "One-Hand, Sword", 9, 9401),
            }},
            { title = "Eric \"The Swift\"", kind = "boss", items = {
                Item("Horned Viking Helmet", "Head, Plate", 8, 9394),
                Item("Worn Running Boots", "Feet, Leather", 80, 9398),
            }},
            { title = "Ironaya", kind = "boss", encounterID = 549, items = {
                Item("Stoneweaver Leggings", "Legs, Cloth", 38, 9407),
                Item("Ironshod Bludgeon", "Two-Hand, Staff", 20, 9408),
                Item("Ironaya's Bracers", "Wrist, Mail", 38, 9409),
            }},
            { title = "Obsidian Sentinel", kind = "boss", encounterID = 1887, items = {} },
            { title = "Ancient Stone Keeper", kind = "boss", encounterID = 551, items = {
                Item("Cragfists", "Hands, Plate", 48, 9410),
                Item("Rockshard Pauldrons", "Shoulder, Mail", 47, 9411),
            }},
            { title = "Galgann Firehammer", kind = "boss", encounterID = 552, items = {
                Item("Galgann's Fireblaster", "Ranged, Gun", 18, 9412),
                Item("Galgann's Firehammer", "One-Hand, Mace", 20, 9419),
                Item("Flameseer Mantle", "Shoulder, Cloth", 20, 11310),
                Item("Emberscale Cape", "Back, Cloth", 38, 11311),
            }},
            { title = "Grimlok", kind = "boss", encounterID = 553, items = {
                Item("Grimlok's Charge", "Two-Hand, Polearm", 19, 9416),
                Item("Oilskin Leggings", "Legs, Leather", 30, 9414),
                Item("Grimlok's Tribal Vestments", "Chest, Cloth", 40, 9415),
            }},
            { title = "Archaedas", kind = "boss", encounterID = 554, items = {
                Item("The Rockpounder", "Two-Hand, Mace", 14, 9413),
                Item("Stoneslayer", "Two-Hand, Sword", 14, 9418),
                Item("Archaedic Stone", "Finger, Miscellaneous", 62, 11118),
            }},
            { title = "Uldaman Reagent Run", kind = "quest", faction = "Alliance", items = {
                Item("Restorative Potion", "Non-equippable, Potion", nil, 9030),
            }},
            { title = "The Hidden Chamber", kind = "quest", faction = "Alliance", items = {
                Item("Dwarven Charge", "Two-Hand, Axe", nil, 9626),
                Item("Explorers' League Lodestar", "Held In Off-hand, Miscellaneous", nil, 9627),
            }},
            { title = "Uldaman Reagent Run", kind = "quest", faction = "Horde", items = {
                Item("Restorative Potion", "Non-equippable, Potion", nil, 9030),
            }},
            { title = "Agmond's Fate", kind = "quest", faction = "Alliance", items = {
                Item("Prospector Gloves", "Hands, Leather", nil, 4980),
            }},
            { title = "The Lost Tablets of Will", kind = "quest", faction = "Alliance", items = {
                Item("Medal of Courage", "Neck, Miscellaneous", nil, 6723),
            }},
            { title = "Power Stones", kind = "quest", items = {
                Item("Energized Stone Circle", "Off Hand, Shield", nil, 9522),
                Item("Duracin Bracers", "Wrist, Mail", nil, 10358),
                Item("Everlast Boots", "Feet, Cloth", nil, 10359),
            }},
            { title = "Solution to Doom", kind = "quest", items = {
                Item("Doomsayer's Robe", "Chest, Cloth", nil, 4746),
            }},
            { title = "The Platinum Discs", kind = "quest", items = {
                Item("Superior Healing Potion", "Non-equippable, Potion", nil, 3928),
                Item("Greater Mana Potion", "Non-equippable, Potion", nil, 6149),
                Item("Thawpelt Sack", "Bag, Bag", nil, 9587),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=2100) for boss loot + quest rewards. All 9 entries confirmed as real bosses from memory (high confidence, not independently web-verified); reordered with Princess Theradras last as the final boss.
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): all 8 present (Meshlok is an optional extra).
    {
        name = "Maraudon", art = 131850, zone = "Desolace", levelMin = 46, levelMax = 55, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            Q("Shadowshard Fragments", 7068, "Horde", { level = 42, requires = 39, xp = 3450, pickup = "Uthel'nay, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Uthel'nay, Orgrimmar", turninZone = "Orgrimmar" }),
            Q("Vyletongue Corruption", 7029, "Horde", { level = 47, requires = 41, xp = 5250, pickup = "Vark Battlescar, Desolace", pickupZone = "Desolace", turnin = "Vark Battlescar, Desolace", turninZone = "Desolace" }),
            Q("Corruption of Earth and Seed", 7064, "Horde", { level = 51, requires = 45, xp = 6100, pickup = "Selendra, Desolace", pickupZone = "Desolace", turnin = "Selendra, Desolace", turninZone = "Desolace" }),
            Q("Shadowshard Fragments", 7070, "Alliance", { level = 42, requires = 39, xp = 3450, pickup = "Archmage Tervosh, Dustwallow Marsh", pickupZone = "Dustwallow Marsh", turnin = "Archmage Tervosh, Dustwallow Marsh", turninZone = "Dustwallow Marsh" }),
            Q("Vyletongue Corruption", 7041, "Alliance", { level = 47, requires = 41, xp = 5250, pickup = "Talendria, Desolace", pickupZone = "Desolace", turnin = "Talendria, Desolace", turninZone = "Desolace" }),
            Q("Corruption of Earth and Seed", 7065, "Alliance", { level = 51, requires = 45, xp = 6100, pickup = "Keeper Marandis, Desolace", pickupZone = "Desolace", turnin = "Keeper Marandis, Desolace", turninZone = "Desolace" }),
            Q("Twisted Evils", 7028, nil, { level = 47, requires = 41, xp = 5250, pickup = "Willow, Desolace", pickupZone = "Desolace", turnin = "Willow, Desolace", turninZone = "Desolace" }),
            Q("Legends of Maraudon", 7044, nil, { level = 49, requires = 41, xp = 3400, pickup = "Cavindra", turnin = "Celebras the Redeemed, Maraudon", turninZone = "Maraudon" }),
            Q("Seed of Life", 7066, nil, { level = 51, requires = 39, xp = 6100, pickup = "Zaetar's Spirit, Maraudon", pickupZone = "Maraudon", turnin = "Keeper Remulos, Moonglade", turninZone = "Moonglade" }),
            Q("The Pariah's Instructions", 7067, nil, { level = 48, requires = 39, xp = 5450, pickup = "Centaur Pariah, Desolace", pickupZone = "Desolace", turnin = "Centaur Pariah, Desolace", turninZone = "Desolace" }),
            Q("The Scepter of Celebras", 7046, nil, { level = 49, requires = 41, xp = 5700, pickup = "Celebras the Redeemed, Maraudon", pickupZone = "Maraudon", turnin = "Celebras the Redeemed, Maraudon", turninZone = "Maraudon" }),
        },
                lootGroups = {
            { title = "Noxxion", kind = "boss", encounterID = 422, items = {
                Item("Heart of Noxxion", "Trinket, Miscellaneous", 36, 17744),
                Item("Noxious Shooter", "Ranged, Wand", 18, 17745),
                Item("Noxxion's Shackles", "Wrist, Plate", 36, 17746),
            }},
            { title = "Razorlash", kind = "boss", encounterID = 423, items = {
                Item("Phytoskin Spaulders", "Shoulder, Leather", 25, 17749),
                Item("Vinerot Sandals", "Feet, Cloth", 24, 17748),
                Item("Chloromesh Girdle", "Waist, Cloth", 24, 17750),
                Item("Razorlash Root", "Non-equippable, Other", 5, 17747),
                Item("Brusslehide Leggings", "Legs, Leather", 24, 17751),
            }},
            { title = "Lord Vyletongue", kind = "boss", encounterID = 424, items = {
                Item("Satyr's Lash", "One-Hand, Dagger", 29, 17752),
                Item("Infernal Trickster Leggings", "Legs, Mail", 29, 17754),
                Item("Satyrmane Sash", "Waist, Cloth", 27, 17755),
            }},
            { title = "Landslide", kind = "boss", encounterID = 426, items = {
                Item("Helm of the Mountain", "Head, Plate", 23, 17734),
                Item("Rockgrip Gauntlets", "Hands, Mail", 24, 17736),
                Item("Cloud Stone", "Held In Off-hand, Miscellaneous", 24, 17737),
                Item("Fist of Stone", "One-Hand, Mace", 26, 17943),
            }},
            { title = "Tinkerer Gizlock", kind = "boss", encounterID = 427, items = {
                Item("Megashot Rifle", "Ranged, Gun", 33, 17717),
                Item("Inventor's Focal Sword", "One-Hand, Sword", 33, 17719),
                Item("Gizlock's Hypertech Buckler", "Off Hand, Shield", 33, 17718),
            }},
            { title = "Rotgrip", kind = "boss", encounterID = 428, items = {
                Item("Albino Crocscale Boots", "Feet, Leather", 35, 17728),
                Item("Gatorbite Axe", "Two-Hand, Axe", 24, 17730),
                Item("Rotgrip Mantle", "Shoulder, Cloth", 36, 17732),
            }},
            { title = "Celebras the Cursed", kind = "boss", encounterID = 425, items = {
                Item("Claw of Celebras", "Off Hand, Fist Weapon", 32, 17738),
                Item("Grovekeeper's Drape", "Back, Cloth", 32, 17739),
                Item("Soothsayer's Headdress", "Head, Leather", 30, 17740),
            }},
            { title = "Meshlok the Harvester", kind = "boss", items = {
                Item("Nature's Embrace", "Chest, Cloth", 29, 17741),
                Item("Fungus Shroud Armor", "Chest, Leather", 28, 17742),
                Item("Bloomsprout Headpiece", "Head, Mail", 29, 17767),
            }},
            { title = "Princess Theradras", kind = "boss", encounterID = 429, items = {
                Item("Elemental Rockridge Leggings", "Legs, Plate", 19, 17711),
                Item("Gemshard Heart", "Neck, Miscellaneous", 20, 17707),
                Item("Charstone Dirk", "One-Hand, Dagger", 19, 17710),
                Item("Bracers of the Stone Princess", "Wrist, Mail", 24, 17714),
                Item("Blackstone Ring", "Finger, Miscellaneous", 24, 17713),
                Item("Eye of Theradras", "Head, Cloth", 19, 17715),
                Item("Princess Theradras' Scepter", "Two-Hand, Mace", 20, 17766),
                Item("Blade of Eternal Darkness", "One-Hand, Dagger", 0, 17780),
            }},
            { title = "Shadowshard Fragments", kind = "quest", faction = "Horde", items = {
                Item("Zealous Shadowshard Pendant", "Neck, Miscellaneous", nil, 17772),
                Item("Prodigious Shadowshard Pendant", "Neck, Miscellaneous", nil, 17773),
            }},
            { title = "Vyletongue Corruption", kind = "quest", faction = "Horde", items = {
                Item("Woodseed Hoop", "Finger, Miscellaneous", nil, 17768),
                Item("Branchclaw Gauntlets", "Hands, Plate", nil, 17770),
                Item("Sagebrush Girdle", "Waist, Leather", nil, 17778),
            }},
            { title = "Corruption of Earth and Seed", kind = "quest", faction = "Horde", items = {
                Item("Thrash Blade", "One-Hand, Sword", nil, 17705),
                Item("Resurgence Rod", "Two-Hand, Staff", nil, 17743),
                Item("Verdant Keeper's Aim", "Ranged, Bow", nil, 17753),
            }},
            { title = "Shadowshard Fragments", kind = "quest", faction = "Alliance", items = {
                Item("Zealous Shadowshard Pendant", "Neck, Miscellaneous", nil, 17772),
                Item("Prodigious Shadowshard Pendant", "Neck, Miscellaneous", nil, 17773),
            }},
            { title = "Vyletongue Corruption", kind = "quest", faction = "Alliance", items = {
                Item("Woodseed Hoop", "Finger, Miscellaneous", nil, 17768),
                Item("Branchclaw Gauntlets", "Hands, Plate", nil, 17770),
                Item("Sagebrush Girdle", "Waist, Leather", nil, 17778),
            }},
            { title = "Corruption of Earth and Seed", kind = "quest", faction = "Alliance", items = {
                Item("Thrash Blade", "One-Hand, Sword", nil, 17705),
                Item("Resurgence Rod", "Two-Hand, Staff", nil, 17743),
                Item("Verdant Keeper's Aim", "Ranged, Bow", nil, 17753),
            }},
            { title = "Twisted Evils", kind = "quest", items = {
                Item("Acumen Robes", "Chest, Cloth", nil, 17775),
                Item("Sprightring Helm", "Head, Leather", nil, 17776),
                Item("Relentless Chain", "Chest, Mail", nil, 17777),
                Item("Hulkstone Pauldrons", "Shoulder, Plate", nil, 17779),
            }},
            { title = "The Pariah's Instructions", kind = "quest", items = {
                Item("Mark of the Chosen", "Trinket, Miscellaneous", nil, 17774),
            }},
            { title = "The Scepter of Celebras", kind = "quest", items = {
                Item("Scepter of Celebras", "Two-Hand, Staff", nil, 17191),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=1176) for boss loot + quest rewards. All 9 entries confirmed as real bosses from memory (high confidence, not independently web-verified); reordered by dungeon progression.
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): Hydromancer Velratha, Theka the Martyr and Nekrum Gutchewer added (no loot recorded yet).
    {
        name = "Zul'Farrak", art = 131885, zone = "Tanaris", levelMin = 44, levelMax = 54, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            Q("The Spider God", 2936, "Horde", { level = 45, requires = 40, xp = 4850, pickup = "Master Gadrin, Durotar", pickupZone = "Durotar", turnin = "Master Gadrin, Durotar", turninZone = "Durotar" }),
            Q("Nekrum's Medallion", 2991, "Alliance", { level = 47, requires = 40, xp = 5250, pickup = "Thadius Grimshade, Blasted Lands", pickupZone = "Blasted Lands", turnin = "Thadius Grimshade, Blasted Lands", turninZone = "Blasted Lands" }),
            Q("Divino-matic Rod", 2768, nil, { level = 47, requires = 40, xp = 6300, pickup = "Chief Engineer Bilgewhizzle, Tanaris", pickupZone = "Tanaris", turnin = "Chief Engineer Bilgewhizzle, Tanaris", turninZone = "Tanaris" }),
            Q("Scarab Shells", 2865, nil, { level = 45, requires = 40, xp = 3900, pickup = "Tran'rek, Tanaris", pickupZone = "Tanaris", turnin = "Tran'rek, Tanaris", turninZone = "Tanaris" }),
            Q("Troll Temper", 3042, nil, { level = 45, requires = 40, xp = 3900, pickup = "Trenton Lighthammer, Tanaris", pickupZone = "Tanaris", turnin = "Trenton Lighthammer, Tanaris", turninZone = "Tanaris" }),
            Q("Tiara of the Deep", 2846, nil, { level = 46, requires = 40, xp = 6050, pickup = "Tabetha, Dustwallow Marsh", pickupZone = "Dustwallow Marsh", turnin = "Tabetha, Dustwallow Marsh", turninZone = "Dustwallow Marsh" }),
            Q("Gahz'rilla", 2770, nil, { level = 50, requires = 40, xp = 7100, pickup = "Wizzle Brassbolts, Thousand Needles", pickupZone = "Thousand Needles", turnin = "Wizzle Brassbolts, Thousand Needles", turninZone = "Thousand Needles" }),
            Q("The Prophecy of Mosh'aru", 3527, nil, { level = 47, requires = 40, xp = 5250, pickup = "Yeh'kinya, Tanaris", pickupZone = "Tanaris", turnin = "Yeh'kinya, Tanaris", turninZone = "Tanaris" }),
        },
                lootGroups = {
            { title = "Sergeant Bly", kind = "boss", items = {
                Item("Gutwrencher", "One-Hand, Dagger", 0, 5616),
                Item("Divino-matic Rod", "Non-equippable, Consumable", 67, 8548),
            }},
            { title = "Chief Ukorz Sandscalp", kind = "boss", encounterID = 600, items = {
                Item("Big Bad Pauldrons", "Shoulder, Plate", 32, 9476),
                Item("The Chief's Enforcer", "Two-Hand, Staff", 23, 9477),
                Item("Ripsaw", "One-Hand, Axe", 23, 9478),
                Item("Embrace of the Lycan", "Head, Leather", 11, 9479),
                Item("Jang'thraze the Protector", "Main Hand, Sword", 3, 11086),
            }},
            { title = "Theka the Martyr", kind = "boss", encounterID = 596, items = {} },
            { title = "Witch Doctor Zum'rah", kind = "boss", encounterID = 597, items = {
                Item("Jumanza Grips", "Hands, Cloth", 35, 18083),
                Item("Zum'rah's Vexing Cane", "Two-Hand, Staff", 15, 18082),
            }},
            { title = "Antu'sul", kind = "boss", encounterID = 595, items = {
                Item("Sang'thraze the Deflector", "One-Hand, Sword", 3, 9379),
                Item("Vice Grips", "Hands, Plate", 32, 9640),
                Item("The Hand of Antu'sul", "One-Hand, Mace", 18, 9639),
                Item("Lifeblood Amulet", "Neck, Miscellaneous", 34, 9641),
            }},
            { title = "Hydromancer Velratha", kind = "boss", encounterID = 593, items = {} },
            { title = "Gahz'rilla", kind = "boss", encounterID = 594, items = {
                Item("Gahz'rilla Fang", "One-Hand, Dagger", 46, 9467),
                Item("Gahz'rilla Scale Armor", "Chest, Mail", 45, 9469),
            }},
            { title = "Dustwraith", kind = "boss", items = {
                Item("Desertwalker Cane", "Held In Off-hand, Miscellaneous", 21, 12471),
            }},
            { title = "Zerillis", kind = "boss", items = {
                Item("Sandstalker Ankleguards", "Feet, Leather", 18, 12470),
            }},
            { title = "Nekrum Gutchewer", kind = "boss", encounterID = 598, items = {} },
            { title = "Shadowpriest Sezz'ziz", kind = "boss", encounterID = 599, items = {
                Item("Bad Mojo Mask", "Head, Cloth", 23, 9470),
                Item("Jinxed Hoodoo Kilt", "Legs, Leather", 22, 9474),
                Item("Jinxed Hoodoo Skin", "Chest, Leather", 22, 9473),
                Item("Diabolic Skiver", "Two-Hand, Polearm", 22, 9475),
            }},
            { title = "Sandfury Executioner", kind = "boss", items = {
                Item("Executioner's Key", "Non-equippable, Other", 78, 8444),
            }},
            { title = "Divino-matic Rod", kind = "quest", items = {
                Item("Engineer's Guild Headpiece", "Head, Leather", nil, 9534),
                Item("Masons Fraternity Ring", "Finger, Miscellaneous", nil, 9533),
            }},
            { title = "Tiara of the Deep", kind = "quest", items = {
                Item("Spellshifter Rod", "Two-Hand, Staff", nil, 9527),
                Item("Gemshale Pauldrons", "Shoulder, Plate", nil, 9531),
            }},
            { title = "Gahz'rilla", kind = "quest", items = {
                Item("Carrot on a Stick", "Trinket, Miscellaneous", nil, 11122),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=1477) for boss loot + quest rewards. Reordered, but 2 entries (Hakkari Bloodkeeper, Atal'ai Witch Doctor) were kept without independent verification - moderate confidence only, worth a closer look later.
    {
        name = "Temple of Atal'Hakkar", art = 131872, zone = "Swamp of Sorrows", levelMin = 50, levelMax = 60, faction = "Both", status = "classic",
        verified = { levelRange = "2026-10-07" },
        quests = {
            Q("The Temple of Atal'Hakkar", 1445, "Horde", { level = 50, requires = 38, xp = 5900, pickup = "Fel'zerul, Swamp of Sorrows", pickupZone = "Swamp of Sorrows", turnin = "Fel'zerul, Swamp of Sorrows", turninZone = "Swamp of Sorrows" }),
            Q("Zapper Fuel", 4146, "Horde", { level = 52, requires = 47, xp = 5100, pickup = "Liv Rizzlefix, The Barrens", pickupZone = "The Barrens", turnin = "Larion, Un'Goro Crater", turninZone = "Un'Goro Crater" }),
            Q("Haze of Evil", 4143, "Alliance", { level = 52, requires = 47, xp = 5100, pickup = "Gregan Brewspewer, Feralas", pickupZone = "Feralas", turnin = "Muigin, Un'Goro Crater", turninZone = "Un'Goro Crater" }),
            Q("Into The Temple of Atal'Hakkar", 1475, "Alliance", { level = 50, requires = 38, xp = 7100, pickup = "Brohann Caskbelly, Stormwind City", pickupZone = "Stormwind City", turnin = "Brohann Caskbelly, Stormwind City", turninZone = "Stormwind City" }),
            Q("Jammal'an the Prophet", 1446, nil, { level = 53, requires = 38, xp = 6550, pickup = "Atal'ai Exile, The Hinterlands", pickupZone = "The Hinterlands", turnin = "Atal'ai Exile, The Hinterlands", turninZone = "The Hinterlands" }),
            Q("The Essence of Eranikus", 3373, nil, { level = 55, requires = 48, xp = 2800, turnin = "Essence Font" }),
            Q("Into the Depths", 3446, nil, { level = 51, requires = 46, xp = 4900, pickup = "Marvon Rivetseeker, Tanaris", pickupZone = "Tanaris", turnin = "Altar of Hakkar, inside the Temple" }),
            Q("Secret of the Circle", 3447, nil, { level = 51, requires = 46, xp = 6100, pickup = "Marvon Rivetseeker, Tanaris", pickupZone = "Tanaris", turnin = "Idol of Hakkar" }),
            Q("The God Hakkar", 3528, nil, { level = 53, requires = 40, xp = 7900, pickup = "Yeh'kinya, Tanaris", pickupZone = "Tanaris", turnin = "Yeh'kinya, Tanaris", turninZone = "Tanaris" }),
        },
                lootGroups = {
            { title = "Jammal'an the Prophet", kind = "boss", items = {
                Item("Kilt of the Atal'ai Prophet", "Legs, Cloth", 27, 10807),
                Item("Gloves of the Atal'ai Prophet", "Hands, Cloth", 30, 10808),
                Item("Vestments of the Atal'ai Prophet", "Chest, Cloth", 27, 10806),
            }},
            { title = "Hakkari Bloodkeeper", kind = "boss", items = {
                Item("Hakkari Blood", "Non-equippable, Key", 86, 10460),
            }},
            { title = "Atal'ai Witch Doctor", kind = "boss", items = {
                Item("Formula: Enchant Cloak - Greater Resistance", "Non-equippable, Enchanting", 1, 16216),
            }},
            { title = "Murk Worm", kind = "boss", items = {
                Item("Pattern: Green Dragonscale Leggings", "Non-equippable, Leatherworking", 2, 15733),
            }},
            { title = "Ogom the Wretched", kind = "boss", items = {
                Item("Blade of the Wretched", "One-Hand, Sword", 30, 10803),
                Item("Fist of the Damned", "One-Hand, Mace", 31, 10804),
                Item("Eater of the Dead", "One-Hand, Axe", 30, 10805),
            }},
            { title = "Atal'alarion", kind = "boss", items = {
                Item("Atal'alarion's Tusk Ring", "Waist, Plate", 37, 10798),
                Item("Headspike", "Two-Hand, Polearm", 18, 10799),
                Item("Darkwater Bracers", "Wrist, Leather", 38, 10800),
                Item("Putrid Vine", "Non-equippable, Junk", 4, 22444),
            }},
            { title = "Spawn of Hakkar", kind = "boss", items = {
                Item("Wingveil Cloak", "Back, Cloth", 24, 10802),
                Item("Slitherscale Boots", "Feet, Leather", 47, 10801),
            }},
            { title = "Shade of Eranikus", kind = "boss", items = {
                Item("The Dragon's Eye", "Neck, Miscellaneous", 32, 10829),
                Item("Dire Nail", "One-Hand, Dagger", 17, 10828),
                Item("Crest of Supremacy", "Off Hand, Shield", 29, 10835),
                Item("Horns of Eranikus", "Head, Mail", 32, 10833),
                Item("Rod of Corrosion", "Ranged, Wand", 27, 10836),
                Item("Tooth of Eranikus", "One-Hand, Axe", 14, 10837),
                Item("Dragon's Call", "One-Hand, Sword", 0, 10847),
            }},
            { title = "Shade of Hakkar", kind = "boss", items = {
                Item("Embrace of the Wind Serpent", "Chest, Cloth", 0, 12462),
            }},
            { title = "Morphaz", kind = "boss", items = {
                Item("Tooth of Morphaz", "Non-equippable, Junk", 6, 20019),
                Item("Azure Key", "Non-equippable, Junk", 4, 20022),
                Item("Arcane Shard", "Non-equippable, Junk", 6, 20085),
            }},
            { title = "The Temple of Atal'Hakkar", kind = "quest", faction = "Horde", items = {
                Item("Guardian Talisman", "Trinket, Miscellaneous", nil, 1490),
            }},
            { title = "Into The Temple of Atal'Hakkar", kind = "quest", faction = "Alliance", items = {
                Item("Guardian Talisman", "Trinket, Miscellaneous", nil, 1490),
            }},
            { title = "Jammal'an the Prophet", kind = "quest", items = {
                Item("Rainstrider Leggings", "Legs, Cloth", nil, 11123),
                Item("Helm of Exile", "Head, Mail", nil, 11124),
            }},
            { title = "The Essence of Eranikus", kind = "quest", items = {
                Item("Chained Essence of Eranikus", "Trinket, Miscellaneous", nil, 10455),
            }},
            { title = "Secret of the Circle", kind = "quest", items = {
                Item("Hakkari Urn", "Non-equippable, Junk", nil, 10773),
            }},
            { title = "The God Hakkar", kind = "quest", items = {
                Item("Essence of Hakkar", "Non-equippable, Consumable", nil, 10663),
                Item("Avenguard Helm", "Head, Plate", nil, 10749),
                Item("Gemburst Circlet", "Head, Cloth", nil, 10751),
                Item("Lifeforce Dirk", "One-Hand, Dagger", nil, 10750),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=1584) for boss loot + quest rewards. Boss order web-search-verified against a comprehensive 24-boss encounter list: removed 11 entries with no independent confirmation (including Coren Direbrew, who is actually a later Brewfest holiday-event boss, and Princess Moira Bronzebeard, a quest NPC not a killable boss in original vanilla).
    {
        name = "Blackrock Depths", art = 131824, zone = "Blackrock Mountain", levelMin = 52, levelMax = 60, faction = "Both", status = "classic",
        verified = { levelRange = "2026-10-07" },
        quests = {
            -- Horde
            Q("KILL ON SIGHT: Dark Iron Dwarves", 4081, "Horde", { level = 52, requires = 48, xp = 5100, pickup = "WANTED", turnin = "Warlord Goretooth, Badlands", turninZone = "Badlands" }),
            Q("Lost Thunderbrew Recipe", 4134, "Horde", { level = 55, requires = 50, xp = 5650, pickup = "Shadowmage Vivian Lagrave, Badlands", pickupZone = "Badlands", turnin = "Shadowmage Vivian Lagrave, Badlands", turninZone = "Badlands" }),
            Q("KILL ON SIGHT: High Ranking Dark Iron Officials", 4082, "Horde", { level = 54, requires = 50, xp = 5450, pickup = "KILL ON SIGHT", turnin = "Warlord Goretooth, Badlands", turninZone = "Badlands" }),
            Q("The Rise of the Machines", 4063, "Horde", { level = 58, requires = 52, xp = 6200, pickup = "Lotwil Veriatus, Badlands", pickupZone = "Badlands", turnin = "Lotwil Veriatus, Badlands", turninZone = "Badlands" }),
            Q("Disharmony of Flame", 3906, "Horde", { level = 52, requires = 48, xp = 5100, pickup = "Thunderheart, Badlands", pickupZone = "Badlands", turnin = "Thunderheart, Badlands", turninZone = "Badlands" }),
            Q("Disharmony of Fire", 3907, "Horde", { level = 56, requires = 48, xp = 7300, pickup = "Thunderheart, Badlands", pickupZone = "Badlands", turnin = "Thunderheart, Badlands", turninZone = "Badlands" }),
            Q("Commander Gor'shak", 3981, "Horde", { level = 52, requires = 48, xp = 5100, pickup = "Galamav the Marksman, Badlands", pickupZone = "Badlands", turnin = "Commander Gor'shak, Blackrock Depths", turninZone = "Blackrock Depths" }),
            Q("The Last Element", 7201, "Horde", { level = 54, requires = 48, xp = 5450, pickup = "Shadowmage Vivian Lagrave, Badlands", pickupZone = "Badlands", turnin = "Shadowmage Vivian Lagrave, Badlands", turninZone = "Badlands" }),
            Q("Operation: Death to Angerforge", 4132, "Horde", { level = 58, requires = 52, xp = 7750, pickup = "Warlord Goretooth, Badlands", pickupZone = "Badlands", turnin = "Warlord Goretooth, Badlands", turninZone = "Badlands" }),
            Q("The Royal Rescue", 4003, nil, { level = 59, requires = 48, xp = 8050, pickup = "Thrall, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Princess Moira Bronzebeard, Blackrock Depths", turninZone = "Blackrock Depths" }),
            -- Alliance
            Q("Overmaster Pyron", 4262, "Alliance", { level = 52, requires = 48, xp = 5100, pickup = "Jalinda Sprig, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Jalinda Sprig, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Incendius!", 4263, "Alliance", { level = 56, requires = 48, xp = 5800, pickup = "Jalinda Sprig, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Jalinda Sprig, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("The Good Stuff", 4286, "Alliance", { level = 56, requires = 50, xp = 5800, pickup = "Oralius, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Oralius, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Hurley Blackbreath", 4126, "Alliance", { level = 55, requires = 50, xp = 7050, pickup = "Ragnar Thunderbrew, Dun Morogh", pickupZone = "Dun Morogh", turnin = "Ragnar Thunderbrew, Dun Morogh", turninZone = "Dun Morogh" }),
            Q("Kharan Mighthammer", 4341, "Alliance", { level = 59, requires = 50, xp = 6400, pickup = "King Magni Bronzebeard, Ironforge", pickupZone = "Ironforge", turnin = "Kharan Mighthammer, Blackrock Depths", turninZone = "Blackrock Depths" }),
            Q("The Fate of the Kingdom", 4362, "Alliance", { level = 59, requires = 50, xp = 8050, pickup = "King Magni Bronzebeard, Ironforge", pickupZone = "Ironforge", turnin = "Princess Moira Bronzebeard, Blackrock Depths", turninZone = "Blackrock Depths" }),
            Q("Marshal Windsor", 4241, "Alliance", { level = 54, requires = 48, xp = 5450, pickup = "Marshal Maxwell, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Marshal Windsor, Blackrock Depths", turninZone = "Blackrock Depths" }),
            Q("A Shred of Hope", 4282, "Alliance", { level = 58, requires = 50, xp = 6200, pickup = "Marshal Windsor, Blackrock Depths", pickupZone = "Blackrock Depths", turnin = "Marshal Windsor, Blackrock Depths", turninZone = "Blackrock Depths" }),
            Q("Jail Break!", 4322, "Alliance", { level = 58, requires = 50, xp = 7750, pickup = "Marshal Windsor, Blackrock Depths", pickupZone = "Blackrock Depths", turnin = "Marshal Maxwell, Burning Steppes", turninZone = "Burning Steppes" }),
            -- Neutral
            Q("Ribbly Screwspigot", 4136, nil, { level = 53, requires = 48, xp = 2650, pickup = "Yuka Screwspigot, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Yuka Screwspigot, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("The Heart of the Mountain", 4123, nil, { level = 55, requires = 50, xp = 5650, pickup = "Maxwort Uberglint, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Maxwort Uberglint, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Attunement to the Core", 7848, nil, { level = 60, requires = 55, xp = 6600, pickup = "Lothos Riftwaker, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Lothos Riftwaker, Burning Steppes", turninZone = "Burning Steppes", key = "Molten Core attunement" }),
            Q("Dark Iron Legacy", 3802, nil, { level = 52, requires = 48, xp = 5100, pickup = "Franclorn Forgewright", turnin = "Monument of Franclorn Forgewright" }),
            Q("The Love Potion", 4201, nil, { level = 54, requires = 50, xp = 5450, pickup = "Mistress Nagmara, Blackrock Depths", pickupZone = "Blackrock Depths", turnin = "Mistress Nagmara, Blackrock Depths", turninZone = "Blackrock Depths" }),
            Q("A Taste of Flame", 4024, nil, { level = 58, requires = 52, xp = 6200, pickup = "Cyrus Therepentous, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Cyrus Therepentous, Burning Steppes", turninZone = "Burning Steppes" }),
        },
                lootGroups = {
            { title = "Lord Roccor", kind = "boss", encounterID = 228, items = {
                Item("Stoneshell Guard", "Off Hand, Shield", 23, 11631),
                Item("Rockshard Pellets", "Ammo, Bullet", 16, 11630),
                Item("Earthslag Shoulders", "Shoulder, Plate", 23, 11632),
                Item("Formula: Smoking Heart of the Mountain", "Non-equippable, Enchanting", 17, 11813),
                Item("Mantle of Lost Hope", "Shoulder, Cloth", 22, 22234),
                Item("Idol of Ferocity", "Relic, Idol", 22, 22397),
            }},
            { title = "High Interrogator Gerstahn", kind = "boss", encounterID = 227, items = {
                Item("Prison Cell Key", "Non-equippable, Key", 49, 11140),
                Item("Enthralled Sphere", "Held In Off-hand, Miscellaneous", 19, 11625),
                Item("Kentic Amice", "Shoulder, Cloth", 22, 11624),
                Item("Blackveil Cape", "Back, Cloth", 17, 11626),
                Item("Greaves of Withering Despair", "Feet, Mail", 18, 22240),
            }},
            { title = "Houndmaster Grebmar", kind = "boss", encounterID = 229, items = {
                Item("Spritecaster Cape", "Back, Cloth", 30, 11623),
                Item("Fleetfoot Greaves", "Feet, Mail", 35, 11627),
                Item("Houndmaster's Rifle", "Ranged, Gun", 13, 11629),
                Item("Houndmaster's Bow", "Ranged, Bow", 13, 11628),
            }},
            { title = "Hedrum the Creeper", kind = "boss", items = {
                Item("Spiderfang Carapace", "Chest, Plate", 31, 11633),
                Item("Silkweb Gloves", "Hands, Cloth", 28, 11634),
                Item("Hookfang Shanker", "One-Hand, Dagger", 21, 11635),
                Item("Savage Gladiator Helm", "Head, Mail", 14, 11729),
            }},
            { title = "Gorosh the Dervish", kind = "boss", items = {
                Item("Savage Gladiator Chain", "Chest, Mail", 16, 11726),
                Item("Bloodclot Band", "Finger, Miscellaneous", 23, 22257),
                Item("Flarethorn", "One-Hand, Dagger", 17, 22266),
                Item("Leggings of Frenzied Magic", "Legs, Leather", 21, 22271),
            }},
            { title = "Anub'shiah", kind = "boss", items = {
                Item("Graverot Cape", "Back, Cloth", 31, 11677),
                Item("Carapace of Anub'shiah", "Chest, Plate", 19, 11678),
                Item("Shadefiend Boots", "Feet, Leather", 33, 11675),
                Item("Savage Gladiator Greaves", "Feet, Mail", 12, 11731),
            }},
            { title = "Ok'thor the Breaker", kind = "boss", items = {
                Item("Ogreseer Fists", "Hands, Leather", 29, 11665),
                Item("Ban'thok Sash", "Waist, Cloth", 31, 11662),
                Item("Savage Gladiator Leggings", "Legs, Mail", 17, 11728),
                Item("Cyclopean Band", "Finger, Miscellaneous", 20, 11824),
            }},
            { title = "Eviscerator", kind = "boss", items = {
                Item("Rubicund Armguards", "Wrist, Mail", 30, 11679),
                Item("Splinthide Shoulders", "Shoulder, Leather", 29, 11685),
                Item("Girdle of Beastial Fury", "Waist, Leather", 20, 11686),
                Item("Savage Gladiator Grips", "Hands, Mail", 18, 11730),
            }},
            { title = "Grizzle", kind = "boss", items = {
                Item("Plans: Dark Iron Pulverizer", "Non-equippable, Blacksmithing", 93, 11610),
                Item("Stonewall Girdle", "Waist, Plate", 30, 11703),
                Item("Dregmetal Spaulders", "Shoulder, Mail", 20, 11722),
                Item("Grizzle's Skinner", "One-Hand, Axe", 30, 11702),
                Item("Entrenching Boots", "Feet, Plate", 16, 22270),
            }},
            { title = "Pyromancer Loregrain", kind = "boss", encounterID = 231, items = {
                Item("Formula: Enchant Weapon - Fiery Weapon", "Non-equippable, Enchanting", 40, 11207),
                Item("Pyric Caduceus", "Ranged, Wand", 29, 11748),
                Item("Flamestrider Robes", "Chest, Leather", 24, 11747),
                Item("Searingscale Leggings", "Legs, Mail", 24, 11749),
                Item("Kindling Stave", "Two-Hand, Staff", 20, 11750),
            }},
            { title = "Golem Lord Argelmach", kind = "boss", encounterID = 237, items = {
                Item("Naglering", "Finger, Miscellaneous", 11, 11669),
                Item("Second Wind", "Trinket, Miscellaneous", 9, 11819),
                Item("Omnicast Boots", "Feet, Cloth", 36, 11822),
                Item("Luminary Kilt", "Legs, Leather", 36, 11823),
                Item("Design: Dark Iron Scorpid", "Non-equippable, Jewelcrafting", 0, 21956),
            }},
            { title = "Hurley Blackbreath", kind = "boss", encounterID = 238, items = {
                Item("Ragefury Eyepatch", "Head, Leather", 9, 11735),
                Item("Coal Miner Boots", "Feet, Leather", 24, 18043),
                Item("Hurley's Tankard", "One-Hand, Mace", 26, 18044),
                Item("Firemoss Boots", "Feet, Leather", 23, 22275),
            }},
            { title = "Phalanx", kind = "boss", encounterID = 239, items = {
                Item("Fists of Phalanx", "Hands, Plate", 31, 11745),
                Item("Bloodfist", "One-Hand, Fist Weapon", 31, 11744),
                Item("Rockfist", "One-Hand, Fist Weapon", 3, 11743),
                Item("Golem Fitted Pauldrons", "Shoulder, Mail", 29, 22212),
            }},
            { title = "Lord Incendius", kind = "boss", encounterID = 232, items = {
                Item("Flameweave Cuffs", "Wrist, Cloth", 14, 11766),
                Item("Pyremail Wristguards", "Wrist, Mail", 14, 11765),
                Item("Incendic Bracers", "Wrist, Cloth", 41, 11768),
                Item("Emberplate Armguards", "Wrist, Plate", 14, 11767),
                Item("Cinderhide Armsplints", "Wrist, Leather", 14, 11764),
            }},
            { title = "Warder Stilgiss", kind = "boss", encounterID = 233, items = {
                Item("Chillsteel Girdle", "Waist, Mail", 25, 11783),
                Item("Boreal Mantle", "Shoulder, Cloth", 23, 11782),
                Item("Arbiter's Blade", "Main Hand, Sword", 23, 11784),
                Item("Dark Warder's Pauldrons", "Shoulder, Leather", 22, 22241),
            }},
            { title = "Fineous Darkvire", kind = "boss", encounterID = 234, items = {
                Item("Chief Architect's Monocle", "Head, Cloth", 21, 11839),
                Item("Senior Designer's Pantaloons", "Legs, Cloth", 24, 11841),
                Item("Lead Surveyor's Mantle", "Shoulder, Mail", 23, 11842),
                Item("Master Builder's Shirt", "Shirt, Miscellaneous", 3, 11840),
                Item("Foreman's Head Protector", "Head, Plate", 19, 22223),
            }},
            { title = "Bael'Gar", kind = "boss", encounterID = 235, items = {
                Item("Lavacrest Leggings", "Legs, Plate", 35, 11802),
                Item("Rubidium Hammer", "One-Hand, Mace", 7, 11805),
                Item("Force of Magma", "Two-Hand, Mace", 33, 11803),
                Item("Sash of the Burning Heart", "Waist, Cloth", 19, 11807),
            }},
            { title = "General Angerforge", kind = "boss", encounterID = 236, items = {
                Item("Angerforge's Battle Axe", "Two-Hand, Axe", 23, 11816),
                Item("Force of Will", "Trinket, Miscellaneous", 11, 11810),
                Item("Lord General's Sword", "One-Hand, Sword", 13, 11817),
                Item("Royal Decorated Armor", "Chest, Mail", 23, 11820),
                Item("Warstrife Leggings", "Legs, Leather", 15, 11821),
            }},
            { title = "Plugger Spazzring", kind = "boss", encounterID = 241, items = {
                Item("Grim Guzzler Key", "Non-equippable, Key", 0, 11602),
                Item("Mixologist's Tunic", "Chest, Leather", 30, 12793),
                Item("Barman Shanker", "One-Hand, Dagger", 10, 12791),
                Item("Schematic: Goblin Jumper Cables XL", "Non-equippable, Engineering", 17, 18653),
            }},
            { title = "Ribbly Screwspigot", kind = "boss", encounterID = 240, items = {
                Item("Ribbly's Bandolier", "Bag, Ammo Pouch", 10, 2663),
                Item("Plans: Dark Iron Plate", "Non-equippable, Blacksmithing", 14, 11612),
                Item("Wayfarer's Knapsack", "Bag, Bag", 15, 11742),
                Item("Ribbly's Quiver", "Bag, Quiver", 10, 2662),
            }},
            { title = "Ambassador Flamelash", kind = "boss", encounterID = 242, items = {
                Item("Cape of the Fire Salamander", "Back, Cloth", 38, 11812),
                Item("Circle of Flame", "Head, Cloth", 0, 11808),
                Item("Flame Wrath", "Two-Hand, Polearm", 11, 11809),
                Item("Molten Fists", "Hands, Mail", 37, 11814),
                Item("Burst of Knowledge", "Trinket, Miscellaneous", 10, 11832),
            }},
            { title = "Magmus", kind = "boss", encounterID = 244, items = {
                Item("Magmus Stone", "Held In Off-hand, Miscellaneous", 21, 11935),
                Item("Lavastone Hammer", "Two-Hand, Mace", 22, 22208),
                Item("Totem of Rage", "Relic, Totem", 12, 22395),
                Item("Libram of Truth", "Relic, Libram", 15, 22400),
            }},
            { title = "Panzor the Invincible", kind = "boss", items = {
                Item("Stone of the Earth", "Two-Hand, Sword", 24, 11786),
                Item("Rock Golem Bulwark", "Off Hand, Shield", 23, 11785),
                Item("Shalehusk Boots", "Feet, Plate", 29, 11787),
                Item("Soot Encrusted Footwear", "Feet, Cloth", 20, 22245),
            }},
            { title = "Emperor Dagran Thaurissan", kind = "boss", encounterID = 2790, items = {
                Item("Ironfoe", "One-Hand, Mace", 1, 11684),
                Item("Hand of Justice", "Trinket, Miscellaneous", 15, 11815),
                Item("Robes of the Royal Crown", "Chest, Cloth", 19, 11924),
                Item("Thaurissan's Royal Scepter", "Held In Off-hand, Miscellaneous", 18, 11928),
                Item("The Emperor's New Cape", "Back, Cloth", 19, 11930),
                Item("Dreadforge Retaliator", "Two-Hand, Axe", 18, 11931),
                Item("Emperor's Seal", "Finger, Miscellaneous", 18, 11934),
                Item("Guiding Stave of Wisdom", "Two-Hand, Staff", 18, 11932),
                Item("Imperial Jewel", "Neck, Miscellaneous", 17, 11933),
                Item("Thaurissan Family Jewels", "Non-equippable, Junk", 2, 12033),
                Item("Wristguards of Renown", "Wrist, Leather", 19, 22204),
                Item("Sash of the Grand Hunt", "Waist, Mail", 18, 22207),
            }},
            { title = "Lost Thunderbrew Recipe", kind = "quest", faction = "Horde", items = {
                Item("Superior Healing Potion", "Non-equippable, Potion", nil, 3928),
                Item("Greater Mana Potion", "Non-equippable, Potion", nil, 6149),
                Item("Swiftstrike Cudgel", "One-Hand, Mace", nil, 11964),
                Item("Limb Cleaver", "Two-Hand, Axe", nil, 12000),
            }},
            { title = "The Rise of the Machines", kind = "quest", faction = "Horde", items = {
                Item("Azure Moon Amice", "Shoulder, Cloth", nil, 12109),
                Item("Lavaplate Gauntlets", "Hands, Plate", nil, 12111),
                Item("Raincaster Drape", "Back, Cloth", nil, 12110),
                Item("Basaltscale Armor", "Chest, Mail", nil, 12108),
            }},
            { title = "Disharmony of Fire", kind = "quest", faction = "Horde", items = {
                Item("Nightfall Gloves", "Hands, Leather", nil, 12114),
                Item("Crypt Demon Bracers", "Wrist, Mail", nil, 12112),
                Item("Stalwart Clutch", "Waist, Plate", nil, 12115),
                Item("Sunborne Cape", "Back, Cloth", nil, 12113),
            }},
            { title = "The Last Element", kind = "quest", faction = "Horde", items = {
                Item("Lagrave's Seal", "Finger, Miscellaneous", nil, 12038),
            }},
            { title = "Operation: Death to Angerforge", kind = "quest", faction = "Horde", items = {
                Item("Conqueror's Medallion", "Neck, Miscellaneous", nil, 12059),
            }},
            { title = "Incendius!", kind = "quest", faction = "Alliance", items = {
                Item("Nightfall Gloves", "Hands, Leather", nil, 12114),
                Item("Crypt Demon Bracers", "Wrist, Mail", nil, 12112),
                Item("Stalwart Clutch", "Waist, Plate", nil, 12115),
                Item("Sunborne Cape", "Back, Cloth", nil, 12113),
            }},
            { title = "The Good Stuff", kind = "quest", faction = "Alliance", items = {
                Item("A Dingy Fanny Pack", "Non-equippable, Junk", nil, 11883),
            }},
            { title = "Hurley Blackbreath", kind = "quest", faction = "Alliance", items = {
                Item("Swiftstrike Cudgel", "One-Hand, Mace", nil, 11964),
                Item("Limb Cleaver", "Two-Hand, Axe", nil, 12000),
                Item("Dark Dwarven Lager", "Non-equippable, Food & Drink", nil, 12003),
            }},
            { title = "Jail Break!", kind = "quest", faction = "Alliance", items = {
                Item("Blade of Reckoning", "One-Hand, Sword", nil, 12061),
                Item("Skilled Fighting Blade", "One-Hand, Dagger", nil, 12062),
                Item("Ward of the Elements", "Trinket, Miscellaneous", nil, 12065),
            }},
            { title = "Ribbly Screwspigot", kind = "quest", items = {
                Item("Rancor Boots", "Feet, Cloth", nil, 11865),
                Item("Penance Spaulders", "Shoulder, Leather", nil, 11963),
                Item("Splintsteel Armor", "Chest, Mail", nil, 12049),
            }},
            { title = "Dark Iron Legacy", kind = "quest", items = {
                Item("Shadowforge Key", "Non-equippable, Key", nil, 11000),
            }},
            { title = "The Love Potion", kind = "quest", items = {
                Item("Nagmara's Whipping Belt", "Waist, Leather", nil, 11866),
                Item("Manacle Cuffs", "Wrist, Cloth", nil, 11962),
            }},
            { title = "A Taste of Flame", kind = "quest", items = {
                Item("Shaleskin Cape", "Back, Cloth", nil, 12066),
                Item("Wyrmhide Spaulders", "Shoulder, Leather", nil, 12082),
                Item("Valconian Sash", "Waist, Cloth", nil, 12083),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=1583, shared with Upper Spire) manually split LBRS/UBRS and web-search-verified.
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): all present (with the Upper Spire).
    {
        name = "Lower Blackrock Spire", art = 131825, zone = "Blackrock Mountain", levelMin = 55, levelMax = 60, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            Q("The Pack Mistress", 4724, "Horde", { level = 59, requires = 55, xp = 6400, pickup = "Galamav the Marksman, Badlands", pickupZone = "Badlands", turnin = "Galamav the Marksman, Badlands", turninZone = "Badlands" }),
            Q("Operative Bijou", 4981, "Horde", { level = 59, requires = 55, xp = 6400, pickup = "Lexlort, Badlands", pickupZone = "Badlands", turnin = "Bijou, Blackrock Spire", turninZone = "Blackrock Spire" }),
            Q("Warlord's Command", 4903, "Horde", { level = 60, requires = 55, xp = 8300, turnin = "Warlord Goretooth, Badlands", turninZone = "Badlands" }),
            Q("Put Her Down", 4701, "Alliance", { level = 59, requires = 55, xp = 6400, pickup = "Helendis Riverhorn, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Helendis Riverhorn, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("General Drakkisath's Command", 5089, "Alliance", { level = 60, requires = 55, xp = 6600, turnin = "Marshal Maxwell, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Bijou's Belongings", 4982, "Horde", { level = 59, requires = 55, xp = 6400, pickup = "Bijou, Blackrock Spire", pickupZone = "Blackrock Spire", turnin = "Bijou, Blackrock Spire", turninZone = "Blackrock Spire" }),
            Q("Bijou's Belongings", 5001, "Alliance", { level = 59, requires = 55, xp = 6400, pickup = "Bijou, Blackrock Spire", pickupZone = "Blackrock Spire", turnin = "Bijou, Blackrock Spire", turninZone = "Blackrock Spire" }),
            Q("En-Ay-Es-Tee-Why", 4862, nil, { level = 59, requires = 55, xp = 6400, pickup = "Kibler, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Kibler, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Kibler's Exotic Pets", 4729, nil, { level = 59, requires = 55, xp = 6400, pickup = "Kibler, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Kibler, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Mother's Milk", 4866, nil, { level = 60, requires = 55, xp = 9950, pickup = "Ragged John, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Ragged John, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Seal of Ascension", 4742, nil, { level = 60, requires = 57, xp = 8300, pickup = "Scarshield Infiltrator, Blackrock Spire", pickupZone = "Blackrock Spire", turnin = "Scarshield Infiltrator, Blackrock Spire", turninZone = "Blackrock Spire", key = "Gives the key to Upper Blackrock Spire" }),
            Q("Urok Doomhowl", 4867, nil, { level = 60, requires = 55, xp = 9950, pickup = "Warosh, Blackrock Spire", pickupZone = "Blackrock Spire", turnin = "Warosh, Blackrock Spire", turninZone = "Blackrock Spire" }),
            Q("The Final Tablets", 4788, nil, { level = 58, requires = 40, xp = 7750, pickup = "Prospector Ironboot, Tanaris", pickupZone = "Tanaris", turnin = "Prospector Ironboot, Tanaris", turninZone = "Tanaris" }),
        },
        lootGroups = {
            { title = "Highlord Omokk", kind = "boss", items = {
                Item("Slamshot Shoulders", "Shoulder, Plate", 13, 13166),
                Item("Fist of Omokk", "Two-Hand, Mace", 13, 13167),
                Item("Tressermane Leggings", "Legs, Leather", 13, 13169),
                Item("Plate of the Shaman King", "Chest, Plate", 13, 13168),
                Item("Skyshroud Leggings", "Legs, Cloth", 13, 13170),
                Item("Boots of Elements", "Feet, Mail", 16, 16670),
            }},
            { title = "Shadow Hunter Vosh'gajin", kind = "boss", items = {
                Item("Funeral Cuffs", "Wrist, Cloth", 19, 12626),
                Item("Doomshot", "Ammo, Arrow", 28, 12654),
                Item("Blackcrow", "Ranged, Crossbow", 7, 12651),
                Item("Riphook", "Ranged, Bow", 7, 12653),
                Item("Trueaim Gauntlets", "Hands, Mail", 34, 13255),
                Item("Demonic Runed Spaulders", "Shoulder, Leather", 8, 13257),
                Item("Shadowcraft Gloves", "Hands, Leather", 17, 16712),
            }},
            { title = "War Master Voone", kind = "boss", items = {
                Item("Keris of Zul'Serak", "One-Hand, Dagger", 14, 12582),
                Item("Broken Flightblade Throwing Axe", "Non-equippable, Junk", 75, 13173),
                Item("Voone's Twitchbow", "Ranged, Bow", 1, 13175),
                Item("Talisman of Evasion", "Neck, Miscellaneous", 19, 13177),
                Item("Brazecore Armguards", "Wrist, Mail", 20, 13179),
                Item("Beaststalker's Gloves", "Hands, Mail", 19, 16676),
                Item("Kayser's Boots of Precision", "Feet, Cloth", 17, 22231),
                Item("Flightblade Throwing Axe", "Thrown, Thrown", 16, 28972),
            }},
            { title = "Mother Smolderweb", kind = "boss", items = {
                Item("Venomspitter", "One-Hand, Mace", 4, 13183),
                Item("Smolderweb's Eye", "Trinket, Miscellaneous", 14, 13213),
                Item("Gilded Gauntlets", "Hands, Mail", 27, 13244),
                Item("Wildheart Boots", "Feet, Leather", 16, 16715),
            }},
            { title = "Overlord Wyrmthalak", kind = "boss", items = {
                Item("Mark of the Dragon Lord", "Finger, Miscellaneous", 5, 13143),
                Item("Chillpike", "Two-Hand, Polearm", 1, 13148),
                Item("Trindlehaven Staff", "Two-Hand, Staff", 15, 13161),
                Item("Reiver Claws", "Hands, Plate", 15, 13162),
                Item("Heart of the Scale", "Trinket, Miscellaneous", 1, 13164),
                Item("Relentless Scythe", "Two-Hand, Sword", 15, 13163),
                Item("Beaststalker's Mantle", "Shoulder, Mail", 16, 16679),
                Item("Heart of Wyrmthalak", "Trinket, Miscellaneous", 16, 22321),
            }},
            { title = "Urok Doomhowl", kind = "boss", items = {
                Item("Warosh's Mojo", "Non-equippable, Consumable", 47, 12712),
                Item("Rosewine Circle", "Finger, Miscellaneous", 19, 13178),
                Item("Slaghide Gauntlets", "Hands, Leather", 20, 13258),
                Item("Ribsteel Footguards", "Feet, Plate", 23, 13259),
                Item("Marksman's Girdle", "Waist, Mail", 20, 22232),
            }},
            { title = "Quartermaster Zigris", kind = "boss", items = {
                Item("Plans: Annihilator", "Non-equippable, Blacksmithing", 13, 12835),
                Item("Quartermaster Zigris' Footlocker", "Non-equippable, Junk", 10, 13247),
                Item("Hands of Power", "Hands, Cloth", 18, 13253),
                Item("Cloudrunner Girdle", "Waist, Leather", 19, 13252),
                Item("Design: Black Diamond Crab", "Non-equippable, Jewelcrafting", 3, 21955),
            }},
            { title = "Halycon", kind = "boss", items = {
                Item("Pads of the Dread Wolf", "Feet, Leather", 17, 13210),
                Item("Slashclaw Bracers", "Wrist, Mail", 26, 13211),
                Item("Halycon's Spiked Collar", "Neck, Miscellaneous", 26, 13212),
                Item("Ironweave Bracers", "Wrist, Cloth", 21, 22313),
            }},
            { title = "Gizrul the Slavener", kind = "boss", items = {
                Item("Wolfshear Leggings", "Legs, Cloth", 26, 13206),
                Item("Rhombeard Protector", "Off Hand, Shield", 25, 13205),
                Item("Bleak Howler Armguards", "Wrist, Leather", 24, 13208),
                Item("Wildheart Spaulders", "Shoulder, Leather", 18, 16718),
            }},
            { title = "Bannok Grimaxe", kind = "boss", items = {
                Item("Demonfork", "One-Hand, Axe", 29, 12621),
                Item("Chiselbrand Girdle", "Waist, Mail", 32, 12634),
                Item("Backusarian Gauntlets", "Hands, Plate", 32, 12637),
                Item("Plans: Arcanite Reaper", "Non-equippable, Blacksmithing", 8, 12838),
            }},
            { title = "Crystal Fang", kind = "boss", items = {
                Item("Fallbrush Handgrips", "Hands, Leather", 33, 13184),
                Item("Sunderseer Mantle", "Shoulder, Cloth", 33, 13185),
                Item("Fang of the Crystal Spider", "One-Hand, Dagger", 15, 13218),
            }},
            { title = "Spirestone Lord Magus", kind = "boss", items = {
                Item("Ogreseer Tower Boots", "Feet, Cloth", 25, 13282),
                Item("Globe of D'sak", "Held In Off-hand, Miscellaneous", 22, 13261),
                Item("Magus Ring", "Finger, Miscellaneous", 47, 13283),
            }},
            { title = "Spirestone Battle Lord", kind = "boss", items = {
                Item("Swiftdart Battleboots", "Feet, Mail", 57, 13284),
                Item("The Blackrock Slicer", "Two-Hand, Axe", 38, 13285),
            }},
            { title = "Ghok Bashguud", kind = "boss", items = {
                Item("Bashguuder", "One-Hand, Mace", 34, 13204),
                Item("Hurd Smasher", "One-Hand, Fist Weapon", 23, 13198),
                Item("Armswake Cloak", "Back, Cloth", 38, 13203),
            }},
            { title = "Spirestone Butcher", kind = "boss", items = {
                Item("Butcher's Apron", "Back, Cloth", 58, 12608),
                Item("Rivenspike", "One-Hand, Axe", 38, 13286),
            }},
            { title = "Burning Felguard", kind = "boss", items = {
                Item("Demonskin Gloves", "Hands, Cloth", 29, 13181),
                Item("Phase Blade", "One-Hand, Sword", 29, 13182),
            }},
        },
    },
-- [SOURCE 2026-09-27] Same pass as Lower Blackrock Spire - zone=1583 manually split, web-search-verified.
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): all present (with the Lower Spire).
    {
        name = "Upper Blackrock Spire", art = 131825, zone = "Blackrock Mountain", levelMin = 58, levelMax = 60, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            Q("The Darkstone Tablet", 4768, "Horde", { level = 60, requires = 57, xp = 8300, pickup = "Shadowmage Vivian Lagrave, Badlands", pickupZone = "Badlands", turnin = "Shadowmage Vivian Lagrave, Badlands", turninZone = "Badlands" }),
            Q("For The Horde!", 4974, "Horde", { level = 60, requires = 55, xp = 9950, pickup = "Thrall, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Thrall, Orgrimmar", turninZone = "Orgrimmar" }),
            Q("Blood of the Black Dragon Champion", 6602, "Horde", { level = 60, requires = 55, xp = 9950, pickup = "Rexxar, Desolace, Feralas and Stonetalon Mountains", pickupZone = "Desolace, Feralas and Stonetalon Mountains", turnin = "Rexxar, Desolace, Feralas and Stonetalon Mountains", turninZone = "Desolace, Feralas and Stonetalon Mountains" }),
            Q("Doomrigger's Clasp", 4764, "Alliance", { level = 60, requires = 57, xp = 1650, pickup = "Mayara Brightwing, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Mayara Brightwing, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("General Drakkisath's Demise", 5102, "Alliance", { level = 60, requires = 55, xp = 9950, pickup = "Marshal Maxwell, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Marshal Maxwell, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Drakefire Amulet", 6502, "Alliance", { level = 60, requires = 50, xp = 8300, pickup = "Haleh, Winterspring", pickupZone = "Winterspring", turnin = "Haleh, Winterspring", turninZone = "Winterspring" }),
            Q("Blackhand's Command", 7761, nil, { level = 60, requires = 55, xp = 6600, turnin = "Drakkisath's Brand", key = "Blackwing Lair attunement" }),
            Q("The Matron Protectorate", 5160, nil, { level = 60, requires = 57, xp = 6600, pickup = "Awbee, Blackrock Spire", pickupZone = "Blackrock Spire", turnin = "Haleh, Winterspring", turninZone = "Winterspring" }),
            Q("Finkle Einhorn, At Your Service!", 5047, nil, { level = 60, requires = 57, xp = 6600, pickup = "Pip Quickwit, Blackrock Spire", pickupZone = "Blackrock Spire", turnin = "Malyfous Darkhammer, Winterspring", turninZone = "Winterspring" }),
            Q("Egg Freezing", 4734, nil, { level = 60, requires = 57, xp = 8300, pickup = "Tinkee Steamboil, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Tinkee Steamboil, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Egg Collection", 4735, nil, { level = 60, requires = 57, xp = 9950, pickup = "Tinkee Steamboil, Burning Steppes", pickupZone = "Burning Steppes", turnin = "Tinkee Steamboil, Burning Steppes", turninZone = "Burning Steppes" }),
            Q("Eye of the Emberseer", 6821, nil, { level = 60, requires = 55, xp = 8300, pickup = "Duke Hydraxis, Azshara", pickupZone = "Azshara", turnin = "Duke Hydraxis, Azshara", turninZone = "Azshara" }),
            Q("The Demon Forge", 5127, nil, { class = { "WARRIOR", "PALADIN" }, level = 60, requires = 55, xp = 8300, pickup = "Lorax, Winterspring", pickupZone = "Winterspring", turnin = "Lorax, Winterspring", turninZone = "Winterspring" }),
        },
        lootGroups = {
            { title = "Pyroguard Emberseer", kind = "boss", items = {
                Item("Wildfire Cape", "Back, Cloth", 26, 12905),
                Item("Flaming Band", "Finger, Miscellaneous", 27, 12926),
                Item("Truestrike Shoulders", "Shoulder, Leather", 12, 12927),
                Item("Emberfury Talisman", "Neck, Miscellaneous", 13, 12929),
                Item("Gauntlets of Elements", "Hands, Mail", 18, 16672),
                Item("Tablet of Flame Shock VI", "Non-equippable, Book", 0, 23320),
            }},
            { title = "Solakar Flamewreath", kind = "boss", items = {
                Item("Dustfeather Sash", "Waist, Cloth", 19, 12589),
                Item("Nightbrace Tunic", "Chest, Leather", 18, 12603),
                Item("Crystallized Girdle", "Waist, Leather", 17, 12606),
                Item("Polychromatic Visionwrap", "Chest, Cloth", 18, 12609),
                Item("Devout Mantle", "Shoulder, Cloth", 19, 16695),
                Item("Schematic: Hyper-Radiant Flame Reflector", "Non-equippable, Engineering", 8, 18657),
            }},
            { title = "Goraluk Anvilcrack", kind = "boss", items = {
                Item("Plans: Arcanite Champion", "Non-equippable, Blacksmithing", 9, 12834),
                Item("Plans: Masterwork Stormhammer", "Non-equippable, Blacksmithing", 9, 12837),
                Item("Handcrafted Mastersmith Leggings", "Legs, Plate", 28, 13498),
                Item("Handcrafted Mastersmith Girdle", "Waist, Plate", 8, 13502),
                Item("Flame Walkers", "Feet, Mail", 17, 18047),
                Item("Mastersmith's Hammer", "Main Hand, Mace", 23, 18048),
            }},
            { title = "Warchief Rend Blackhand", kind = "boss", items = {
                Item("Blackhand Doomsaw", "Two-Hand, Polearm", 9, 12583),
                Item("Eye of Rend", "Head, Leather", 19, 12587),
                Item("Felstriker", "One-Hand, Dagger", 2, 12590),
                Item("Bonespike Shoulder", "Shoulder, Mail", 1, 12588),
                Item("Warmaster Legguards", "Legs, Plate", 22, 12935),
                Item("Battleborn Armbraces", "Wrist, Plate", 19, 12936),
                Item("Dal'Rend's Tribal Guardian", "Off Hand, Sword", 11, 12939),
                Item("Dal'Rend's Sacred Charge", "Main Hand, Sword", 12, 12940),
                Item("Spaulders of Valor", "Shoulder, Plate", 20, 16733),
                Item("Band of Rumination", "Finger, Miscellaneous", 19, 18103),
                Item("Dragonrider Boots", "Feet, Cloth", 21, 18102),
                Item("Feralsurge Girdle", "Waist, Mail", 18, 18104),
                Item("Faith Healer's Boots", "Feet, Cloth", 16, 22247),
            }},
            { title = "The Beast", kind = "boss", items = {
                Item("Pip's Skinner", "One-Hand, Dagger", 14, 12709),
                Item("Blademaster Leggings", "Legs, Leather", 20, 12963),
                Item("Tristam Legguards", "Legs, Mail", 27, 12964),
                Item("Blackmist Armguards", "Wrist, Leather", 20, 12966),
                Item("Bloodmoon Cloak", "Back, Cloth", 25, 12967),
                Item("Spiritshroud Leggings", "Legs, Cloth", 20, 12965),
                Item("Seeping Willow", "Two-Hand, Mace", 14, 12969),
                Item("Frostweaver Cape", "Back, Cloth", 20, 12968),
                Item("Lightforge Spaulders", "Shoulder, Plate", 18, 16729),
                Item("Ironweave Boots", "Feet, Cloth", 18, 22311),
                Item("Book of Ferocious Bite V", "Non-equippable, Book", 6, 24101),
            }},
            { title = "General Drakkisath", kind = "boss", items = {
                Item("Blackblade of Shahram", "Two-Hand, Sword", 2, 12592),
                Item("Draconian Deflector", "Off Hand, Shield", 22, 12602),
                Item("Painweaver Band", "Finger, Miscellaneous", 23, 13098),
                Item("Tooth of Gnarr", "Neck, Miscellaneous", 28, 13141),
                Item("Brigam Girdle", "Waist, Plate", 22, 13142),
                Item("Recipe: Flask of the Titans", "Non-equippable, Alchemy", 4, 13519),
                Item("Pattern: Red Dragonscale Breastplate", "Non-equippable, Leatherworking", 5, 15730),
                Item("Vest of Elements", "Chest, Mail", 6, 16666),
                Item("Beaststalker's Tunic", "Chest, Mail", 11, 16674),
                Item("Magister's Robes", "Chest, Cloth", 11, 16688),
                Item("Devout Robe", "Chest, Cloth", 11, 16690),
                Item("Dreadmist Robe", "Chest, Cloth", 12, 16700),
                Item("Wildheart Vest", "Chest, Leather", 12, 16706),
                Item("Shadowcraft Tunic", "Chest, Leather", 10, 16721),
                Item("Lightforge Breastplate", "Chest, Plate", 7, 16726),
                Item("Breastplate of Valor", "Chest, Plate", 12, 16730),
                Item("Tome of the Lost", "Held In Off-hand, Miscellaneous", 26, 22253),
                Item("Spellweaver's Turban", "Head, Cloth", 24, 22267),
                Item("Draconic Infused Emblem", "Trinket, Miscellaneous", 8, 22268),
                Item("Shadow Prowler's Cloak", "Back, Cloth", 21, 22269),
            }},
            { title = "Jed Runewatcher", kind = "boss", items = {
                Item("Starfire Tiara", "Head, Cloth", 33, 12604),
                Item("Serpentine Skuller", "Ranged, Wand", 33, 12605),
                Item("Briarwood Reed", "Trinket, Miscellaneous", 30, 12930),
            }},
            { title = "Lord Valthalak", kind = "boss", items = {
                Item("Ironweave Cowl", "Head, Cloth", 22, 22302),
                Item("Lord Valthalak's Staff of Command", "Two-Hand, Staff", 26, 22335),
                Item("Draconian Aegis of the Legion", "Off Hand, Shield", 23, 22336),
                Item("Shroud of Domination", "Back, Cloth", 26, 22337),
                Item("Rune Band of Wizardry", "Finger, Miscellaneous", 24, 22339),
                Item("Pendant of Celerity", "Neck, Miscellaneous", 23, 22340),
                Item("Leggings of Torment", "Legs, Cloth", 22, 22342),
                Item("Handguards of Savagery", "Hands, Mail", 25, 22343),
            }},
        },
        notes = "Added to the tracker per the Forever dungeon quest guide - wasn't in the original dungeon list.",
    },
-- [SOURCE - PARTIAL] Quest names/IDs only, from Wowhead's master "every dungeon quest" guide. No zone link exists yet for Dire Maul, so there's no boss loot data at all.
    {
        name = "Dire Maul: East", art = 131835, zone = "Feralas", levelMin = 58, levelMax = 60, faction = "Both", status = "classic",
        verified = { levelRange = "2026-10-07" },
        quests = {
            Q("Lethtendris's Web", 7489, "Horde", { level = 57, requires = 54, xp = 7550, pickup = "Talo Thornhoof, Feralas", pickupZone = "Feralas", turnin = "Talo Thornhoof, Feralas", turninZone = "Feralas" }),
            Q("Lethtendris's Web", 7488, "Alliance", { level = 57, requires = 54, xp = 7550, pickup = "Latronicus Moonspear, Feralas", pickupZone = "Feralas", turnin = "Latronicus Moonspear, Feralas", turninZone = "Feralas" }),
            Q("Pusillin and the Elder Azj'Tordin", 7441, nil, { level = 58, requires = 54, xp = 7750, pickup = "Azj'Tordin, Feralas", pickupZone = "Feralas", turnin = "Azj'Tordin, Feralas", turninZone = "Feralas" }),
            Q("Shards of the Felvine", 5526, nil, { level = 60, requires = 56, xp = 8300, pickup = "Rabine Saturna, Moonglade", pickupZone = "Moonglade", turnin = "Rabine Saturna, Moonglade", turninZone = "Moonglade" }),
            Q("Arcane Refreshment", 7463, nil, { class = "MAGE", level = 60, requires = 60, xp = 6600, pickup = "Lorekeeper Lydros, Dire Maul", pickupZone = "Dire Maul", turnin = "Lorekeeper Lydros, Dire Maul", turninZone = "Dire Maul" }),
        },
    },
-- [SOURCE - PARTIAL] Same as Dire Maul: East - quest data only, no zone link/loot data yet.
    {
        name = "Dire Maul: West", art = 131835, zone = "Feralas", levelMin = 58, levelMax = 60, faction = "Both", status = "classic",
        verified = { levelRange = "2026-10-07" },
        quests = {
            Q("The Madness Within", 7461, nil, { level = 60, requires = 56, xp = 9950, pickup = "Shen'dralar Ancient, Dire Maul", pickupZone = "Dire Maul", turnin = "Shen'dralar Ancient, Dire Maul", turninZone = "Dire Maul" }),
            Q("Foror's Compendium", 7507, nil, { level = 60, requires = 60, xp = 9950, turnin = "Lorekeeper Lydros, Dire Maul", turninZone = "Dire Maul" }),
        },
    },
-- [SOURCE - PARTIAL] Same as Dire Maul: East - quest data only, no zone link/loot data yet.
    {
        name = "Dire Maul: North", art = 131835, zone = "Feralas", levelMin = 58, levelMax = 60, faction = "Both", status = "classic",
        verified = { levelRange = "2026-10-07" },
        quests = {
            Q("Elven Legends", 7481, "Horde", { level = 60, requires = 54, xp = 8300, pickup = "Sage Korolusk, Feralas", pickupZone = "Feralas", turnin = "Sage Korolusk, Feralas", turninZone = "Feralas" }),
            Q("Elven Legends", 7482, "Alliance", { level = 60, requires = 54, xp = 8300, pickup = "Scholar Runethorn, Feralas", pickupZone = "Feralas", turnin = "Scholar Runethorn, Feralas", turninZone = "Feralas" }),
            Q("Free Knot!", 5525, nil, { level = 60, requires = 56, xp = 6600, pickup = "Knot Thimblejack, Dire Maul", pickupZone = "Dire Maul", turnin = "Knot Thimblejack, Dire Maul", turninZone = "Dire Maul" }),
            Q("The Gordok Ogre Suit", 5518, nil, { level = 60, requires = 56, xp = 6600, pickup = "Knot Thimblejack, Dire Maul", pickupZone = "Dire Maul", turnin = "Knot Thimblejack, Dire Maul", turninZone = "Dire Maul" }),
            Q("The Gordok Taste Test", 5528, nil, { level = 60, requires = 56, pickup = "Stomper Kreeg, Dire Maul", pickupZone = "Dire Maul", turnin = "Stomper Kreeg, Dire Maul", turninZone = "Dire Maul" }),
            Q("Unfinished Gordok Business", 7703, nil, { level = 60, requires = 56, xp = 8300, pickup = "Captain Kromcrush, Dire Maul", pickupZone = "Dire Maul", turnin = "Captain Kromcrush, Dire Maul", turninZone = "Dire Maul" }),
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=2057) for boss loot + quest rewards. Removed 3 generic-pattern trash entries (Scholomance Adept/Dark Summoner, Spectral Researcher); the rest confirmed as real bosses from memory (high confidence, not independently web-verified).
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): Instructor Malicia, Lorekeeper Polkelt, The Ravenian, Lord Alexei Barov and Lady Illucia Barov added (no loot recorded yet).
    {
        name = "Scholomance", art = 131868, zone = "Western Plaguelands", levelMin = 58, levelMax = 60, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            Q("Barov Family Fortune", 5341, "Horde", { level = 60, requires = 52, xp = 6600, pickup = "Alexi Barov, Tirisfal Glades", pickupZone = "Tirisfal Glades", turnin = "Alexi Barov, Tirisfal Glades", turninZone = "Tirisfal Glades" }),
            Q("The Darkreaver Menace", 7668, "Horde", { class = "SHAMAN", level = 60, requires = 58, xp = 9950, pickup = "Sagorne Creststrider, Orgrimmar", pickupZone = "Orgrimmar", turnin = "Sagorne Creststrider, Orgrimmar", turninZone = "Orgrimmar" }),
            Q("Barov Family Fortune", 5343, "Alliance", { level = 60, requires = 52, xp = 6600, pickup = "Weldon Barov, Western Plaguelands", pickupZone = "Western Plaguelands", turnin = "Weldon Barov, Western Plaguelands", turninZone = "Western Plaguelands" }),
            Q("Plagued Hatchlings", 5529, nil, { level = 58, requires = 55, xp = 6200, pickup = "Betina Bigglezink, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Betina Bigglezink, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("Healthy Dragon Scale", 5582, nil, { level = 58, requires = 55, turnin = "Betina Bigglezink, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("Doctor Theolen Krastinov, the Butcher", 5382, nil, { level = 60, requires = 55, xp = 6600, pickup = "Eva Sarkhoff, Western Plaguelands", pickupZone = "Western Plaguelands", turnin = "Eva Sarkhoff, Western Plaguelands", turninZone = "Western Plaguelands" }),
            Q("Krastinov's Bag of Horrors", 5515, nil, { level = 60, requires = 55, xp = 6600, pickup = "Eva Sarkhoff, Western Plaguelands", pickupZone = "Western Plaguelands", turnin = "Eva Sarkhoff, Western Plaguelands", turninZone = "Western Plaguelands" }),
            Q("Kirtonos the Herald", 5384, nil, { level = 60, requires = 55, xp = 8300, pickup = "Eva Sarkhoff, Western Plaguelands", pickupZone = "Western Plaguelands", turnin = "Eva Sarkhoff, Western Plaguelands", turninZone = "Western Plaguelands" }),
            Q("Dawn's Gambit", 4771, nil, { level = 60, requires = 57, xp = 9950, pickup = "Betina Bigglezink, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Betina Bigglezink, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("The Lich, Ras Frostwhisper", 5466, nil, { level = 60, requires = 57, xp = 9950, pickup = "Magistrate Marduke, Western Plaguelands", pickupZone = "Western Plaguelands", turnin = "Magistrate Marduke, Western Plaguelands", turninZone = "Western Plaguelands" }),
        },
                lootGroups = {
            { title = "Kirtonos the Herald", kind = "boss", encounterID = 2805, items = {
                Item("Stoneform Shoulders", "Shoulder, Plate", 18, 13955),
                Item("Clutch of Andros", "Waist, Cloth", 19, 13956),
                Item("Gargoyle Slashers", "Hands, Leather", 19, 13957),
                Item("Windreaver Greaves", "Feet, Mail", 19, 13967),
                Item("Heart of the Fiend", "Neck, Miscellaneous", 19, 13960),
                Item("Gravestone War Axe", "Two-Hand, Axe", 14, 13983),
                Item("Loomguard Armbraces", "Wrist, Mail", 19, 13969),
                Item("Frightalon", "One-Hand, Dagger", 18, 14024),
                Item("Boots of Valor", "Feet, Plate", 19, 16734),
            }},
            { title = "Jandice Barov", kind = "boss", encounterID = 2804, items = {
                Item("Darkshade Gloves", "Hands, Cloth", 1, 14543),
                Item("Ghostloom Leggings", "Legs, Leather", 13, 14545),
                Item("Barovian Family Sword", "Two-Hand, Sword", 10, 14541),
                Item("Royal Cap Spaulders", "Shoulder, Mail", 12, 14548),
                Item("Dreadmist Mantle", "Shoulder, Cloth", 16, 16701),
                Item("Wraithplate Leggings", "Legs, Plate", 12, 18690),
                Item("Phantasmal Cloak", "Back, Cloth", 10, 18689),
                Item("Staff of Metanoia", "Two-Hand, Staff", 11, 22394),
            }},
            { title = "Rattlegore", kind = "boss", encounterID = 2811, items = {
                Item("Viewing Room Key", "Non-equippable, Key", 28, 13873),
                Item("Rattlecage Buckler", "Off Hand, Shield", 12, 14528),
                Item("Frightskull Shaft", "Two-Hand, Mace", 12, 14531),
                Item("Bone Ring Helm", "Head, Leather", 12, 14539),
                Item("Corpselight Greaves", "Feet, Plate", 12, 14537),
                Item("Deadwalker Mantle", "Shoulder, Cloth", 12, 14538),
                Item("Shadowcraft Boots", "Feet, Leather", 18, 16711),
                Item("Bone Golem Shoulders", "Shoulder, Mail", 12, 18686),
            }},
            { title = "Ras Frostwhisper", kind = "boss", encounterID = 2810, items = {
                Item("Alanna's Embrace", "Chest, Cloth", 1, 13314),
                Item("Recipe: Flask of Supreme Power", "Non-equippable, Alchemy", 4, 13521),
                Item("Iceblade Hacker", "One-Hand, Axe", 15, 13952),
                Item("Freezing Lich Robes", "Chest, Cloth", 14, 14340),
                Item("Bonechill Hammer", "One-Hand, Mace", 16, 14487),
                Item("Frostbite Girdle", "Waist, Leather", 16, 14502),
                Item("Death's Clutch", "Shoulder, Leather", 14, 14503),
                Item("Boneclenched Gauntlets", "Hands, Plate", 15, 14525),
                Item("Maelstrom Leggings", "Legs, Mail", 15, 14522),
                Item("Magister's Mantle", "Shoulder, Cloth", 19, 16689),
                Item("Spellbound Tome", "Held In Off-hand, Miscellaneous", 15, 18695),
                Item("Shivery Handwraps", "Hands, Cloth", 15, 18693),
                Item("Shadowy Mail Greaves", "Feet, Mail", 16, 18694),
                Item("Intricately Runed Shield", "Off Hand, Shield", 16, 18696),
            }},
            { title = "Marduk Blackpool", kind = "boss", encounterID = 2809, items = {
                Item("Ebon Hilt of Marduk", "One-Hand, Sword", 7, 14576),
                Item("Death Knight Sabatons", "Feet, Plate", 7, 18692),
            }},
            { title = "Vectus", kind = "boss", encounterID = 2813, items = {
                Item("Skullsmoke Pants", "Legs, Cloth", 8, 14577),
                Item("Dark Advisor's Pendant", "Neck, Miscellaneous", 7, 18691),
            }},
            { title = "Kormok", kind = "boss", encounterID = 3055, items = {
                Item("Ironweave Pants", "Legs, Cloth", 15, 22303),
                Item("Amalgam's Band", "Finger, Miscellaneous", 11, 22326),
                Item("Band of the Steadfast Hero", "Finger, Miscellaneous", 15, 22331),
                Item("Blade of Necromancy", "One-Hand, Sword", 14, 22332),
                Item("Hammer of Divine Might", "Two-Hand, Mace", 32, 22333),
            }},
            { title = "Death Knight Darkreaver", kind = "boss", items = {
                Item("Malicious Axe", "Two-Hand, Axe", 22, 18759),
                Item("Specter's Blade", "One-Hand, Dagger", 24, 18758),
                Item("Necromantic Band", "Finger, Miscellaneous", 24, 18760),
                Item("Oblivion's Touch", "Ranged, Wand", 24, 18761),
            }},
            { title = "Instructor Malicia", kind = "boss", encounterID = 2803, items = {} },
            { title = "Doctor Theolen Krastinov", kind = "boss", encounterID = 2802, items = {
                Item("Sawbones Shirt", "Shirt, Miscellaneous", 1, 14617),
            }},
            { title = "Lord Blackwood", kind = "boss", items = {
                Item("Lord Blackwood's Blade", "One-Hand, Sword", 30, 23132),
                Item("Lord Blackwood's Buckler", "Off Hand, Shield", 29, 23139),
                Item("Blackwood's Thigh", "Held In Off-hand, Miscellaneous", 26, 23156),
            }},
            { title = "Lorekeeper Polkelt", kind = "boss", encounterID = 2808, items = {} },
            { title = "The Ravenian", kind = "boss", encounterID = 2812, items = {} },
            { title = "Lord Alexei Barov", kind = "boss", encounterID = 2807, items = {} },
            { title = "Lady Illucia Barov", kind = "boss", encounterID = 2806, items = {} },
            { title = "Darkmaster Gandling", kind = "boss", encounterID = 2801, items = {
                Item("Boots of the Shrieker", "Feet, Leather", 13, 13398),
                Item("Headmaster's Charge", "Two-Hand, Staff", 2, 13937),
                Item("Bonecreeper Stylus", "Ranged, Wand", 13, 13938),
                Item("Tombstone Breastplate", "Chest, Leather", 13, 13944),
                Item("Detention Strap", "Waist, Mail", 1, 13950),
                Item("Vigorsteel Vambraces", "Wrist, Plate", 14, 13951),
                Item("Silent Fang", "One-Hand, Sword", 13, 13953),
                Item("Witchblade", "Main Hand, Dagger", 13, 13964),
                Item("Pattern: Robe of the Void", "Non-equippable, Tailoring", 9, 14514),
                Item("Coif of Elements", "Head, Mail", 6, 16667),
                Item("Beaststalker's Cap", "Head, Mail", 12, 16677),
                Item("Magister's Crown", "Head, Cloth", 13, 16686),
                Item("Devout Crown", "Head, Cloth", 11, 16693),
                Item("Dreadmist Mask", "Head, Cloth", 11, 16698),
                Item("Shadowcraft Cap", "Head, Leather", 11, 16707),
                Item("Wildheart Cowl", "Head, Leather", 11, 16720),
                Item("Lightforge Helm", "Head, Plate", 7, 16727),
                Item("Helm of Valor", "Head, Plate", 12, 16731),
                Item("Don Mauricio's Band of Domination", "Finger, Miscellaneous", 14, 22433),
            }},
            { title = "The Darkreaver Menace", kind = "quest", faction = "Horde", items = {
                Item("Helm of Latent Power", "Head, Mail", nil, 18807),
                Item("Skyfury Helm", "Head, Mail", nil, 20134),
            }},
            { title = "Kirtonos the Herald", kind = "quest", items = {
                Item("Spectral Essence", "Trinket, Miscellaneous", nil, 13544),
                Item("Penelope's Rose", "Held In Off-hand, Miscellaneous", nil, 15805),
                Item("Mirah's Song", "One-Hand, Sword", nil, 15806),
            }},
            { title = "Dawn's Gambit", kind = "quest", items = {
                Item("Dancing Sliver", "Two-Hand, Staff", nil, 15854),
                Item("Windreaper", "One-Hand, Axe", nil, 15853),
            }},
            { title = "The Lich, Ras Frostwhisper", kind = "quest", items = {
                Item("Darrowspike", "One-Hand, Dagger", nil, 13984),
                Item("Warblade of Caer Darrow", "Two-Hand, Sword", nil, 13982),
                Item("Crown of Caer Darrow", "Head, Cloth", nil, 13986),
                Item("Darrowshire Strongguard", "Off Hand, Shield", nil, 14002),
            }},
        },
    },
-- [SOURCE 2026-09-27] npm classic-items db (zone=2017) for boss loot + quest rewards. Boss order web-search-verified: removed 9 entries with no independent confirmation (including Balzaphon, tied to the same 2008 Scourge Invasion event flagged on Razorfen Downs), real 13-boss order confirmed across both Live and Undead sides.
-- [SOURCE 2026-10-26] Boss list checked against the client's DungeonEncounter table (build 70532): Malor the Zealous, The Unforgiven, Black Guard Swordsmith, Crimson Hammersmith, Ezra Grimm and Skul added (no loot recorded yet); Balnazzar is Grand Crusader Dathrohan.
    {
        name = "Stratholme", art = 131871, zone = "Eastern Plaguelands", levelMin = 58, levelMax = 60, faction = "Both", status = "classic",
        verified = { bosses = "2026-10-26", levelRange = "2026-10-07" },
        quests = {
            -- Live side
            Q("The Great Fras Siabi", 5214, nil, { level = 60, requires = 55, xp = 8300, pickup = "Smokey LaRue, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Smokey LaRue, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("The Archivist", 5251, nil, { level = 60, requires = 55, xp = 8300, pickup = "Duke Nicholas Zverenhoff, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Duke Nicholas Zverenhoff, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("The Restless Souls", 5282, nil, { level = 60, requires = 55, xp = 8300, pickup = "Egan, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Egan, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("The Medallion of Faith", 5122, nil, { level = 60, requires = 55, pickup = "Aurius, Stratholme", pickupZone = "Stratholme", turnin = "Aurius, Stratholme", turninZone = "Stratholme" }),
            Q("The Truth Comes Crashing Down", 5262, nil, { level = 60, requires = 55, xp = 8300, turnin = "Duke Nicholas Zverenhoff, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("Of Love and Family", 5848, nil, { level = 60, requires = 52, xp = 6600, pickup = "Artist Renfray, Western Plaguelands", pickupZone = "Western Plaguelands", turnin = "Tirion Fordring, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            -- Undead side
            Q("Ramstein", 6163, "Horde", { level = 60, requires = 56, xp = 6600, pickup = "Nathanos Blightcaller, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Nathanos Blightcaller, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("Houses of the Holy", 5243, nil, { level = 60, requires = 55, xp = 6600, pickup = "Leonid Barthalomew the Revered, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Leonid Barthalomew the Revered, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("The Flesh Does Not Lie", 5212, nil, { level = 60, requires = 55, xp = 6600, pickup = "Betina Bigglezink, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Betina Bigglezink, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("The Active Agent", 5213, nil, { level = 60, requires = 55, xp = 6600, pickup = "Betina Bigglezink, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Betina Bigglezink, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("Aurius' Reckoning", 5125, nil, { level = 60, requires = 55, xp = 9950, pickup = "Aurius, Stratholme", pickupZone = "Stratholme", turnin = "Aurius, Stratholme", turninZone = "Stratholme" }),
            Q("Above and Beyond", 5263, nil, { level = 60, requires = 55, xp = 8300, pickup = "Duke Nicholas Zverenhoff, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Duke Nicholas Zverenhoff, Eastern Plaguelands", turninZone = "Eastern Plaguelands" }),
            Q("Menethil's Gift", 5463, nil, { level = 60, requires = 57, xp = 6600, pickup = "Leonid Barthalomew the Revered, Eastern Plaguelands", pickupZone = "Eastern Plaguelands", turnin = "Menethil's Gift" }),
            Q("Dead Man's Plea", 8945, nil, { level = 60, requires = 58, xp = 8300, pickup = "Anthion Harmon", turnin = "Ysida Harmon, Stratholme", turninZone = "Stratholme" }),
        },
                lootGroups = {
            { title = "Malor the Zealous", kind = "boss", encounterID = 476, items = {} },
            { title = "Cannon Master Willey", kind = "boss", encounterID = 475, items = {
                Item("Plans: Heartseeker", "Non-equippable, Blacksmithing", 9, 12839),
                Item("Scarlet Cannonball", "Non-equippable, Key", 9, 12973),
                Item("Miniature Cannon Balls", "Ammo, Bullet", 92, 13377),
                Item("Willey's Portable Howitzer", "Ranged, Gun", 19, 13380),
                Item("Master Cannoneer Boots", "Feet, Plate", 18, 13381),
                Item("Cannonball Runner", "Trinket, Miscellaneous", 18, 13382),
                Item("Shadowcraft Spaulders", "Shoulder, Leather", 16, 16708),
                Item("Barrage Girdle", "Waist, Mail", 19, 18721),
                Item("Nacreous Shell Necklace", "Neck, Miscellaneous", 23, 22403),
                Item("Willey's Back Scratcher", "Main Hand, Fist Weapon", 11, 22404),
                Item("Mantle of the Scarlet Crusade", "Shoulder, Cloth", 19, 22405),
                Item("Redemption", "Two-Hand, Staff", 9, 22406),
                Item("Helm of the New Moon", "Head, Leather", 22, 22407),
            }},
            { title = "Hearthsinger Forresten", kind = "boss", encounterID = 473, items = {
                Item("Piccolo of the Flaming Fire", "Trinket, Miscellaneous", 14, 13379),
                Item("Songbird Blouse", "Chest, Leather", 15, 13378),
                Item("Woollies of the Prancing Minstrel", "Legs, Mail", 14, 13383),
                Item("Rainbow Girdle", "Waist, Plate", 14, 13384),
                Item("Magister's Boots", "Feet, Cloth", 14, 16682),
            }},
            { title = "Archivist Galford", kind = "boss", encounterID = 477, items = {
                Item("Archivist Cape", "Back, Cloth", 21, 13386),
                Item("Tome of Knowledge", "Held In Off-hand, Miscellaneous", 14, 13385),
                Item("Foresight Girdle", "Waist, Mail", 21, 13387),
                Item("Devout Gloves", "Hands, Cloth", 18, 16692),
                Item("Ash Covered Boots", "Feet, Leather", 21, 18716),
                Item("Tome of Conjure Food VII", "Non-equippable, Book", 1, 22897),
            }},
            { title = "Black Guard Swordsmith", kind = "boss", encounterID = 2795, items = {} },
            { title = "Crimson Hammersmith", kind = "boss", encounterID = 2796, items = {} },
            { title = "Ezra Grimm", kind = "boss", encounterID = 2797, items = {} },
            { title = "Postmaster Malown", kind = "boss", encounterID = 2798, items = {
                Item("The Postmaster's Tunic", "Chest, Cloth", 23, 13388),
                Item("The Postmaster's Trousers", "Legs, Cloth", 13, 13389),
                Item("Malown's Slam", "Two-Hand, Mace", 17, 13393),
                Item("The Postmaster's Seal", "Finger, Miscellaneous", 18, 13392),
                Item("The Postmaster's Band", "Head, Cloth", 6, 13390),
                Item("The Postmaster's Treads", "Feet, Cloth", 15, 13391),
            }},
            { title = "Timmy the Cruel", kind = "boss", encounterID = 474, items = {
                Item("The Cruel Hand of Timmy", "One-Hand, Mace", 19, 13401),
                Item("Vambraces of the Sadist", "Wrist, Plate", 20, 13400),
                Item("Grimgore Noose", "Waist, Cloth", 19, 13403),
                Item("Timmy's Galoshes", "Feet, Mail", 19, 13402),
            }},
            { title = "Grand Crusader Dathrohan", kind = "boss", encounterID = 478, items = {
                Item("Book of the Dead", "Held In Off-hand, Miscellaneous", 2, 13353),
                Item("Band of Mending", "Finger, Miscellaneous", 2, 22334),
            }},
            { title = "Nerub'enkan", kind = "boss", encounterID = 480, items = {
                Item("Eye of Arachnida", "Non-equippable, Consumable", 9, 13508),
                Item("Acid-etched Pauldrons", "Shoulder, Plate", 11, 13533),
                Item("Darkspinner Claws", "Hands, Mail", 11, 13532),
                Item("Fangdrip Runners", "Feet, Cloth", 11, 13530),
                Item("Crypt Stalker Leggings", "Legs, Leather", 11, 13531),
                Item("Husk of Nerub'enkan", "Off Hand, Shield", 18, 13529),
                Item("Beaststalker's Boots", "Feet, Mail", 18, 16675),
                Item("Carapace Spine Crossbow", "Ranged, Crossbow", 18, 18738),
                Item("Chitinous Plate Legguards", "Legs, Plate", 18, 18739),
                Item("Thuzadin Sash", "Waist, Cloth", 18, 18740),
            }},
            { title = "Maleki the Pallid", kind = "boss", encounterID = 481, items = {
                Item("Plans: Hammer of the Titans", "Non-equippable, Blacksmithing", 8, 12833),
                Item("Clutch of Foresight", "Non-equippable, Consumable", 9, 13509),
                Item("Skull of Burning Shadows", "Held In Off-hand, Miscellaneous", 18, 13524),
                Item("Darkbind Fingers", "Hands, Cloth", 11, 13525),
                Item("Flamescarred Girdle", "Waist, Leather", 11, 13526),
                Item("Twilight Void Bracers", "Wrist, Mail", 11, 13528),
                Item("Lavawalker Greaves", "Feet, Plate", 11, 13527),
                Item("Devout Sandals", "Feet, Cloth", 18, 16691),
                Item("Pale Moon Cloak", "Back, Cloth", 18, 18734),
                Item("Maleki's Footwraps", "Feet, Cloth", 18, 18735),
                Item("Bone Slicing Hatchet", "One-Hand, Axe", 18, 18737),
            }},
            { title = "The Unforgiven", kind = "boss", encounterID = 472, items = {} },
            { title = "Baroness Anastari", kind = "boss", encounterID = 479, items = {
                Item("Wail of the Banshee", "Non-equippable, Consumable", 9, 13514),
                Item("Windshrieker Pauldrons", "Shoulder, Mail", 10, 13538),
                Item("Banshee Finger", "Ranged, Wand", 18, 13534),
                Item("Coldtouch Phantom Wraps", "Chest, Cloth", 11, 13535),
                Item("Chillhide Bracers", "Wrist, Leather", 11, 13537),
                Item("Banshee's Touch", "Hands, Plate", 11, 13539),
                Item("Dreadmist Sandals", "Feet, Cloth", 18, 16704),
                Item("Screeching Bow", "Ranged, Bow", 17, 18729),
                Item("Anastari Heirloom", "Neck, Miscellaneous", 18, 18728),
                Item("Shadowy Laced Handwraps", "Hands, Cloth", 18, 18730),
            }},
            { title = "Magistrate Barthilas", kind = "boss", encounterID = 482, items = {
                Item("Key to the City", "Non-equippable, Key", 94, 12382),
                Item("Royal Tribunal Cloak", "Back, Cloth", 15, 13376),
                Item("Death Grips", "Hands, Plate", 15, 18722),
                Item("Peacemaker", "Two-Hand, Polearm", 15, 18725),
                Item("Magistrate's Cuffs", "Wrist, Leather", 14, 18726),
                Item("Crimson Felt Hat", "Head, Cloth", 15, 18727),
                Item("Idol of Brutality", "Relic, Idol", 4, 23198),
            }},
            { title = "Ramstein the Gorger", kind = "boss", encounterID = 483, items = {
                Item("Crest of Retribution", "Off Hand, Shield", 12, 13375),
                Item("Soulstealer Mantle", "Shoulder, Cloth", 12, 13374),
                Item("Slavedriver's Cane", "Two-Hand, Staff", 12, 13372),
                Item("Band of Flesh", "Finger, Miscellaneous", 12, 13373),
                Item("Ramstein's Lightning Bolts", "Trinket, Miscellaneous", 12, 13515),
                Item("Gauntlets of Valor", "Hands, Plate", 17, 16737),
                Item("Animated Chain Necklace", "Neck, Miscellaneous", 12, 18723),
            }},
            { title = "Skul", kind = "boss", encounterID = 2799, items = {} },
            { title = "Stonespine", kind = "boss", encounterID = 2800, items = {
                Item("Stoneskin Gargoyle Cape", "Back, Cloth", 31, 13397),
                Item("Gargoyle Shredder Talons", "Off Hand, Fist Weapon", 34, 13399),
                Item("Verdant Footpads", "Feet, Leather", 29, 13954),
            }},
            { title = "Baron Rivendare", kind = "boss", encounterID = 484, items = {
                Item("Cape of the Black Baron", "Back, Cloth", 15, 13340),
                Item("Seal of Rivendare", "Finger, Miscellaneous", 14, 13345),
                Item("Robes of the Exalted", "Chest, Cloth", 14, 13346),
                Item("Dracorian Gauntlets", "Hands, Mail", 14, 13344),
                Item("Scepter of the Unholy", "One-Hand, Mace", 15, 13349),
                Item("Skullforge Reaver", "One-Hand, Sword", 7, 13361),
                Item("Bonescraper", "One-Hand, Dagger", 7, 13368),
                Item("Runeblade of Baron Rivendare", "Two-Hand, Sword", 0, 13505),
                Item("Kilt of Elements", "Legs, Mail", 6, 16668),
                Item("Beaststalker's Pants", "Legs, Mail", 10, 16678),
                Item("Magister's Leggings", "Legs, Cloth", 11, 16687),
                Item("Devout Skirt", "Legs, Cloth", 11, 16694),
                Item("Dreadmist Leggings", "Legs, Cloth", 11, 16699),
                Item("Shadowcraft Pants", "Legs, Leather", 11, 16709),
                Item("Wildheart Kilt", "Legs, Leather", 10, 16719),
                Item("Lightforge Legplates", "Legs, Plate", 7, 16728),
                Item("Legplates of Valor", "Legs, Plate", 10, 16732),
                Item("Ritssyn's Wand of Bad Mojo", "Ranged, Wand", 18, 22408),
                Item("Tunic of the Crescent Moon", "Chest, Leather", 18, 22409),
                Item("Gauntlets of Deftness", "Hands, Mail", 16, 22410),
                Item("Helm of the Executioner", "Head, Plate", 16, 22411),
                Item("Thuzadin Mantle", "Shoulder, Cloth", 17, 22412),
            }},
            { title = "Ramstein", kind = "quest", faction = "Horde", items = {
                Item("Elemental Circle", "Finger, Miscellaneous", nil, 17001),
                Item("Royal Seal of Alexis", "Finger, Miscellaneous", nil, 18022),
            }},
            { title = "Houses of the Holy", kind = "quest", items = {
                Item("Superior Healing Potion", "Non-equippable, Potion", nil, 3928),
                Item("Greater Mana Potion", "Non-equippable, Potion", nil, 6149),
                Item("Crown of the Penitent", "Head, Cloth", nil, 13216),
                Item("Band of the Penitent", "Finger, Miscellaneous", nil, 13217),
            }},
            { title = "The Active Agent", kind = "quest", items = {
                Item("Seal of the Dawn", "Trinket, Miscellaneous", nil, 13209),
                Item("Rune of the Dawn", "Trinket, Miscellaneous", nil, 19812),
            }},
            { title = "Aurius' Reckoning", kind = "quest", items = {
                Item("Will of the Martyr", "Neck, Miscellaneous", nil, 17044),
                Item("Blood of the Martyr", "Finger, Miscellaneous", nil, 17045),
            }},
            { title = "Dead Man's Plea", kind = "quest", items = {
                Item("Ysida's Satchel", "Non-equippable, Junk", nil, 22137),
            }},
        },
    },
}

-- ============================================================
-- ZONES (unchanged)
-- ============================================================
PathForeverData.Zones = {
    { name = "Elwynn Forest", faction = "Alliance", levelMin = 1, levelMax = 10, status = "classic" },
    { name = "Dun Morogh", faction = "Alliance", levelMin = 1, levelMax = 10, status = "classic" },
    { name = "Teldrassil", faction = "Alliance", levelMin = 1, levelMax = 10, status = "classic" },
    { name = "Durotar", faction = "Horde", levelMin = 1, levelMax = 10, status = "classic" },
    { name = "Mulgore", faction = "Horde", levelMin = 1, levelMax = 10, status = "classic" },
    { name = "Tirisfal Glades", faction = "Horde", levelMin = 1, levelMax = 10, status = "classic" },
    { name = "Zephras Isle", faction = "Both", levelMin = nil, levelMax = nil, status = "new", notes = "Skyborne starting zone - range not confirmed yet." },
    { name = "Westfall", faction = "Alliance", levelMin = 10, levelMax = 20, status = "classic" },
    { name = "Loch Modan", faction = "Alliance", levelMin = 10, levelMax = 20, status = "classic" },
    { name = "Darkshore", faction = "Alliance", levelMin = 10, levelMax = 20, status = "classic" },
    { name = "The Barrens", faction = "Horde", levelMin = 10, levelMax = 25, status = "classic" },
    { name = "Silverpine Forest", faction = "Horde", levelMin = 10, levelMax = 20, status = "classic" },
    { name = "Riverglades", faction = "Both", levelMin = nil, levelMax = nil, status = "new", notes = "New Forever zone - range not confirmed yet." },
    { name = "Shen'dralas", faction = "Both", levelMin = nil, levelMax = nil, status = "new", notes = "New Forever zone - range not confirmed yet." },
    { name = "Redridge Mountains", faction = "Alliance", levelMin = 15, levelMax = 25, status = "classic" },
    { name = "Ashenvale", faction = "Both", levelMin = 18, levelMax = 30, status = "classic" },
    { name = "Stonetalon Mountains", faction = "Both", levelMin = 15, levelMax = 25, status = "classic" },
    { name = "Duskwood", faction = "Alliance", levelMin = 18, levelMax = 30, status = "classic" },
    { name = "Wetlands", faction = "Alliance", levelMin = 20, levelMax = 30, status = "classic" },
    { name = "Thousand Needles", faction = "Horde", levelMin = 25, levelMax = 35, status = "classic" },
    { name = "Alterac Mountains", faction = "Both", levelMin = 30, levelMax = 40, status = "classic" },
    { name = "Desolace", faction = "Both", levelMin = 30, levelMax = 40, status = "classic" },
    { name = "Stranglethorn Vale", faction = "Both", levelMin = 30, levelMax = 45, status = "classic" },
    { name = "Dustwallow Marsh", faction = "Both", levelMin = 35, levelMax = 45, status = "classic" },
    { name = "Badlands", faction = "Both", levelMin = 35, levelMax = 45, status = "classic" },
    { name = "Swamp of Sorrows", faction = "Both", levelMin = 35, levelMax = 45, status = "classic" },
    { name = "Arathi Highlands", faction = "Both", levelMin = 35, levelMax = 45, status = "classic" },
    { name = "Feralas", faction = "Both", levelMin = 40, levelMax = 50, status = "classic" },
    { name = "Tanaris", faction = "Both", levelMin = 40, levelMax = 50, status = "classic" },
    { name = "Azshara", faction = "Both", levelMin = 45, levelMax = 55, status = "classic" },
    { name = "Felwood", faction = "Both", levelMin = 45, levelMax = 55, status = "classic" },
    { name = "Un'Goro Crater", faction = "Both", levelMin = 45, levelMax = 55, status = "classic" },
    { name = "Blasted Lands", faction = "Both", levelMin = 45, levelMax = 55, status = "classic" },
    { name = "Western Plaguelands", faction = "Both", levelMin = 50, levelMax = 60, status = "classic" },
    { name = "Eastern Plaguelands", faction = "Both", levelMin = 50, levelMax = 60, status = "classic" },
    { name = "Burning Steppes", faction = "Both", levelMin = 50, levelMax = 58, status = "classic" },
    { name = "Winterspring", faction = "Both", levelMin = 55, levelMax = 60, status = "classic" },
    { name = "Silithus", faction = "Both", levelMin = 55, levelMax = 60, status = "classic" },
}

-- ============================================================
-- PROFESSION PACING
-- ~5 skill points per character level, capped at 300, with no
-- expectation before ProfessionGraceLevel.
-- ============================================================
PathForeverData.ProfessionGraceLevel = 6
PathForeverData.ProfessionSkillPerLevel = 5
PathForeverData.ProfessionSkillCap = 300

-- ============================================================
-- PROFESSION RANKS (the profession pop-out on the Professions tab)
-- Classic's ranks: each raises the skill cap, and is trained once the skill
-- and the character's level are both high enough. Not yet confirmed on
-- Forever.
-- ============================================================
PathForeverData.ProfessionRanks = {
    { name = "Apprentice", cap = 75, skill = 0, level = 5 },
    { name = "Journeyman", cap = 150, skill = 50, level = 10 },
    { name = "Expert", cap = 225, skill = 125, level = 20 },
    { name = "Artisan", cap = 300, skill = 200, level = 35 },
}
-- Where the secondary professions' ranks come from when it isn't the trainer:
-- Expert from a book a vendor sells, Artisan from a quest. One source per faction
-- (`both` when it's the same for everyone). `skill` and `level` replace the rank's
-- own requirements. [SOURCE 2026-10-05] wowhead.com/forever: the books' "Sold by"
-- lists and tooltips (Requires), the quests' pages (level 35; skill 225 from their
-- comments), and each NPC's map (uiMapID and coordinates).
PathForeverData.ProfessionRankSources = {
    ["First Aid"] = {
        Expert = { book = "Expert First Aid - Under Wraps", item = 16084, skill = 125, level = 0, cost = 10526,
            Alliance = { npc = "Deneb Walker", place = "Stromgarde Keep", zone = "Arathi Highlands", mapID = 1417, x = 0.270, y = 0.588 },
            Horde = { npc = "Balai Lok'Wein", place = "Brackenwall Village", zone = "Dustwallow Marsh", mapID = 1445, x = 0.364, y = 0.304 } },
        Artisan = { quest = "Triage", skill = 225, level = 35,
            Alliance = { id = 6624, npc = "Doctor Gustaf VanHowzen", place = "Theramore Isle", zone = "Dustwallow Marsh", mapID = 1445, x = 0.676, y = 0.488 },
            Horde = { id = 6622, npc = "Doctor Gregory Victor", place = "Hammerfall", zone = "Arathi Highlands", mapID = 1417, x = 0.734, y = 0.364 } },
    },
    ["Fishing"] = {
        Expert = { book = "Expert Fishing - The Bass and You", item = 16083, skill = 125, level = 20, cost = 10000,
            both = { npc = "Old Man Heming", place = "Booty Bay", zone = "Stranglethorn Vale", mapID = 1434, x = 0.274, y = 0.770 } },
        Artisan = { quest = "Nat Pagle, Angler Extreme", skill = 225, level = 35,
            both = { id = 6607, npc = "Nat Pagle", zone = "Dustwallow Marsh", mapID = 1445, x = 0.584, y = 0.600 } },
    },
    ["Cooking"] = {
        Expert = { book = "Expert Cookbook", item = 16072, skill = 125, level = 0, cost = 10526,
            Alliance = { npc = "Shandrina", zone = "Ashenvale", mapID = 1440, x = 0.494, y = 0.670 },
            Horde = { npc = "Wulan", place = "Shadowprey Village", zone = "Desolace", mapID = 1443, x = 0.262, y = 0.698 } },
        Artisan = { quest = "Clamlette Surprise", skill = 225, level = 35,
            both = { id = 6610, npc = "Dirge Quikcleave", place = "Gadgetzan", zone = "Tanaris", mapID = 1446, x = 0.526, y = 0.280 } },
    },
}

-- ============================================================
-- GATHERING NODES (the Mining and Herbalism pop-outs)
-- Skill needed to gather each node, and the zones with the most of it, most
-- first. [SOURCE 2026-10-05] wowhead.com/forever object lists (mining-nodes,
-- herbs) and each object's map counts. Forever's new nodes (Poor Copper Vein,
-- the Amber chunks, Stunted Silverleaf, Wilted Peacebloom, Tomb Weed) are in;
-- Season of Discovery's event nodes and the ooze-covered copies are left out.
-- ============================================================
-- ============================================================
-- LIBRARY BOOKS (the Journey's Discover panel, levels 10 to 40)
-- Books found around Azeroth are handed in one by one to your faction's librarian,
-- and at 10, 20 and 25 books the librarian offers a reward. [SOURCE 2026-10-06]
-- wowhead.com/forever: the news post "New Library Book Return Quest Unlocked at Level
-- 30" and the guide "Collecting Library Books: Locations and Rewards" (updated
-- 2026-10-05; locations from Wowhead's looter and its mage rune guide), each reward
-- quest's page (levels, XP: base x1, rounded to 50) and each item's tooltip. Each
-- book's hand-in quest ID is from the guide's links, or Wowhead's search by its exact
-- name; The Liminal and the Arcane's isn't known (nil). The guide's table also puts
-- Nar'thalas Almanac in the Barrens, Loch Modan and Stonetalon, at other books'
-- coordinates; only its Darkshore spot is described, so only that one is listed.
-- Coordinates are in percent, as /way gives them.
-- ============================================================
PathForeverData.LibraryBooks = {
    librarians = {
        Alliance = { npc = "Garion Wendell", place = "Mage Tower", zone = "Stormwind City", x = 49.0, y = 86.4 },
        Horde = { npc = "Owen Thadd", place = "The Magic Quarter", zone = "Undercity", x = 74.0, y = 32.4 },
    },
    -- the rewards: books needed, the quest, its level, the level to take it (Wowhead says 1
    -- for the first, which needs only the books), XP, and the items to choose from
    quests = {
        { books = 10, id = 78150, name = "Friend of the Library", level = 20, xp = 150,
          rewards = { { 277203, "Scholarly Pendant", "Neck" }, { 277204, "Erudite's Amulet", "Neck" } } },
        { books = 20, id = 79536, name = "Greater Friend of the Library", level = 35, requires = 20, xp = 300,
          rewards = { { 281634, "Field Researcher's Loop", "Finger" }, { 281635, "Philanthropist's Ring", "Finger" } } },
        { books = 25, id = 82208, name = "Greater Friend of the Library", level = 45, requires = 30, xp = 400,
          rewards = { { 277254, "Truthseeker's Bow", "Bow" }, { 277258, "Crest of Elucidation", "Shield, Lv 40" },
                      { 277260, "Researcher's Night Light", "Held in off-hand, Lv 40" } } },
    },
    -- { name, hand-in quest, what it's in, zone, x, y, faction or nil, note or nil, the book's item }
    -- (the book is a unique item, picked up and kept until it's handed in; item IDs from
    -- the guide's links, or Wowhead's search by the exact name)
    books = {
        { "Defensive Magics 101", 79948, "Manual", "Alterac Mountains", 48.4, 57.7, nil, "First tower of the ogre fortress", 215815 },
        { "A Web of Lies: Debunking Myths and Legends", 79949, "Scrolls", "Arathi Highlands", 73.6, 65.2, nil, "Witherbark Village", 215816 },
        { "Everyday Etiquette", 81952, "Book", "Azshara", 20.8, 62.0, nil, nil, 220348 },
        { "Mummies: A Guide to the Unsavory Undead", 79951, "Scrolls", "Badlands", 56.7, 39.9, nil, "The crypt above the dwarven camp", 215820 },
        { "Arcanic Systems Manual", 78145, "Manual", "The Barrens", 56.3, 8.8, nil, "Top of the oil rig, The Sludge Fen", 209847 },
        { "Baxtan: On Destructive Magics", 79097, "Goblin Tome", "The Barrens", 62.7, 36.3, nil, "Ratchet, next to Gazlowe", 208800 },
        { "Secrets of the Dreamers", 78143, "Scrolls", "The Barrens", 52.8, 54.7, nil, "Cavern of Mists, by Wailing Caverns", 209846 },
        { "Stonewrought Design", 81953, "Book", "Burning Steppes", 29.1, 28.9, nil, "Blackrock Mountain's center vault", 220349 },
        { "Magma or Lava?", 84396, "Book", "Blackrock Mountain", 48.4, 63.6, nil, "Past Lothos Riftwaker; not in the instance", 228133 },
        { "Conjurer's Codex", 81956, "Book", "Blasted Lands", 55.4, 32.2, nil, nil, 220353 },
        { "Nar'thalas Almanac, Vol. 74", 78124, "Scrolls", "Darkshore", 59.6, 22.2, nil, "Ruins of Mathystra, third landing", 209843 },
        { "Demons and You", 79950, "Mysterious Book", "Desolace", 55.1, 26.2, nil, "Thunder Axe Fortress", 215817 },
        { "Crimes Against Anatomy", 78147, "Spellbook", "Duskwood", 16.4, 28.4, nil, "Raven Hill crypt; high-level mobs", 209849 },
        { "RwlRwlRwlRwl!", 79952, "Waterlogged Book", "Dustwallow Marsh", 57.2, 20.8, nil, "Witch Hill murloc camp", 215822 },
        { "A Study of the Light", 84398, "Book", "Eastern Plaguelands", 81.7, 57.8, nil, "Light's Hope Chapel", 228135 },
        { "The Knight and the Lady", 84400, "Book", "Eastern Plaguelands", 54.5, 50.8, nil, nil, 228138 },
        { "Scourge: Undead Menace or Misunderstood?", 84401, "Book", "Eastern Plaguelands", 31.3, 21.0, nil, "Outside Stratholme, before the bridge", 228140 },
        { "Archmage Theocritus' Research Journal", 79092, "Library Book", "Elwynn Forest", 65.4, 70.1, "Alliance", "Tower of Azora", 203755 },
        { "Archmage Antonidas: The Unabridged Autobiography", 79091, "Library Book", "Ironforge", 75.4, 11.0, "Alliance", "Hall of Explorers", 203754 },
        { "Northern Kalimdor - A Comprehensive Guide", 84397, "Book", "Felwood", 65.2, 3.2, nil, "Inside Timbermaw Hold", 228134 },
        { "The Liminal and the Arcane", nil, "Book", "Feralas", 50.6, 15.7, nil, nil, 220347 },
        { "Venomous Journeys", 81954, "Book", "The Hinterlands", 36.0, 72.8, nil, nil, 220350 },
        { "Rumi of Gnomeregan: The Collected Works", 79093, "Gnomish Tome", "Loch Modan", 35.6, 48.9, "Alliance", "Thelsamar inn, upstairs", 208860 },
        { "Rumi of Gnomeregan: The Collected Works", 79093, "Gnomish Tome", "Westfall", 52.7, 53.8, "Alliance", "Sentinel Hill inn", 208860 },
        { "Runes of the Sorcerer-Kings", 78148, "Scrolls", "Loch Modan", 77.4, 14.0, nil, "Mo'grosh Stronghold, the ogre cave", 209850 },
        { "The Lessons of Ta'zo", 79094, "Mural", "Orgrimmar", 38.7, 78.4, "Horde", "Valley of Spirits, before Darkbriar Lodge", 207972 },
        { "A Mind of Metal", 81955, "Book", "Searing Gorge", 37.8, 49.3, nil, nil, 220352 },
        { "The Dalaran Digest, Vol. 23", 78127, "Dalaran Digest", "Silverpine Forest", 63.4, 63.1, nil, "Amber Mill, main hall", 209844 },
        { "Ataeric: On Arcane Curiosities", 79096, "Arcane Secrets", "Silverpine Forest", 43.4, 41.2, "Horde", "The Sepulcher, by Sebastian Meloche", 210177 },
        { "Fury of the Land", 78149, "Scrolls", "Stonetalon Mountains", 74.4, 85.7, nil, "Grimtotem Camp", 209851 },
        { "Basilisks: Should Petrification be Feared?", 79535, "Research Notes", "Stranglethorn Vale", 41.4, 50.9, nil, "Crystalvein Mine entrance", 213165 },
        { "Sanguine Sorcery", 81947, "Book", "Swamp of Sorrows", 70.1, 51.8, nil, nil, 220345 },
        { "A Luddite's Guide to Caring for Your Demonic Pet", 79953, "Book", "Swamp of Sorrows", 61.0, 22.0, nil, "In a cage: a Rusted Cage Key from the Lost Ones", 215824 },
        { "Legends of the Tidesages", 81949, "Book", "Tanaris", 72.6, 47.8, nil, nil, 220346 },
        { "Geomancy: The Stone-Cold Truth", 79947, "Scrolls", "Thousand Needles", 34.4, 40.1, nil, "Darkcloud Pinnacle, the largest hut", 215683 },
        { "The Apothecary's Metaphysical Primer", 79095, "Apothecary Society Primer", "Tirisfal Glades", 59.4, 52.3, "Horde", "Brill alchemy shop", 208185 },
        { "Undead Potatoes", 84395, "Book", "Western Plaguelands", 38.3, 54.6, nil, "Felstone farmhouse, upstairs", 228132 },
        { "Necromancy 101", 84402, "Book", "Western Plaguelands", 69.4, 72.8, nil, "Top of Scholomance's building; not in the instance", 228141 },
        { "Bewitchments and Glamours", 78142, "Spellbook", "Westfall", 45.4, 70.4, nil, "Moonbrook, the first house on the left", 209845 },
        { "Bewitchments and Glamours", 78142, "Spellbook", "Zephras Isle", 35.6, 24.1, nil, nil, 209845 },
        { "Goaz Scrolls", 78146, "Scrolls", "Wetlands", 33.6, 47.9, nil, "Whelgar's Excavation Site, lowest level", 209848 },
        { "Ka-Boom!", 84399, "Book", "Winterspring", 60.7, 37.7, nil, "Everlook alchemy shop", 228136 },
    },
}

-- ============================================================
-- COZY SLEEPING BAG (the Journey's Discover panel, from level 14)
-- A hidden six-step quest line across Westfall, The Barrens, Stonetalon Mountains,
-- Loch Modan and Hillsbrad Foothills; the last quest gives the Cozy Sleeping Bag.
-- [SOURCE 2026-10-10] Each quest's page on wowhead.com/forever (ID, level, XP as the page
-- shows it, start and end, rewards; the Series box gives the order), the places and
-- coordinates from Warcraft Tavern's guide (warcrafttavern.com/forever/guides/cozy-sleeping-bag).
-- The first two steps swap by faction (Alliance starts in Westfall, Horde in The Barrens),
-- so each place is given per faction. Coordinates are in percent, as /way gives them; the
-- places with none were not given. Reward items without a confirmed ID are left out.
-- ============================================================
do
    local plank = { place = "Nailed Plank, Alexston Farmstead", zone = "Westfall", x = 37.0, y = 50.0 }
    local remains = { place = "Burned-Out Remains, ruined tower", zone = "The Barrens", x = 46.0, y = 74.0 }
    local litter = { place = "Pocket Litter, a camp in the hills near Sun Rock Retreat", zone = "Stonetalon Mountains" }
    local mound = { place = "Mound of Dirt, in the hillside a little east of the camp", zone = "Stonetalon Mountains" }
    local figurine = { place = "Carved Figurine, on a ledge of Stonewrought Dam", zone = "Loch Modan", x = 49.0, y = 12.0 }
    local bag = { place = "Messenger Bag, on top of the Thoradin Wall (climb the cart in the wall's northern gap)", zone = "Hillsbrad Foothills" }
    local satchel = { place = "Hastily Rolled-Up Satchel, under the Messenger Bag", zone = "Hillsbrad Foothills" }
    PathForeverData.SleepingBag = {
        minLevel = 14,
        item = 211527,
        steps = {
            { name = "... and that note you found", id = { Alliance = 79008, Horde = 79007 }, level = 22, xp = 1750,
              from = { Alliance = plank, Horde = remains }, to = { Alliance = remains, Horde = plank } },
            { name = "Stepping Stones", id = 79192, level = 24, xp = 1950,
              from = { Alliance = remains, Horde = plank }, to = litter },
            { name = "Scramble", id = 79980, level = 24, xp = 200, from = litter, to = mound },
            { name = "Wet Job", id = 79974, level = 32, xp = 2550, from = mound, to = figurine },
            { name = "Eagle's Fist", id = 79975, level = 32, xp = 2550, from = figurine, to = bag },
            { name = "This Must Be the Place", id = 79976, level = 32, xp = 1950, from = bag, to = satchel,
              rewards = { { 211527, "Cozy Sleeping Bag", "Non-equippable" }, { 216619, "Student Fodder", "Consumable" } } },
        },
    }
end

PathForeverData.Gathering = {
    Mining = {
        { name = "Chunk of Amber", skill = 1, zones = { "Teldrassil" } },
        { name = "Copper Vein", skill = 1, zones = { "The Barrens", "Zephras Isle", "Mulgore", "Dun Morogh", "Elwynn Forest" } },
        { name = "Large Chunk of Amber", skill = 1, zones = { "Teldrassil" } },
        { name = "Poor Copper Vein", skill = 1, zones = { "Durotar", "Mulgore", "Elwynn Forest", "Tirisfal Glades", "Dun Morogh" } },
        { name = "Tin Vein", skill = 65, zones = { "The Barrens", "Redridge Mountains", "Ashenvale", "Hillsbrad Foothills", "Loch Modan" } },
        { name = "Silver Vein", skill = 75, zones = { "Arathi Highlands", "Thousand Needles", "The Barrens", "Hillsbrad Foothills", "Stranglethorn Vale" } },
        { name = "Iron Deposit", skill = 125, zones = { "Arathi Highlands", "Desolace", "Stranglethorn Vale", "Thousand Needles", "Alterac Mountains" } },
        { name = "Gold Vein", skill = 155, zones = { "Arathi Highlands", "Badlands", "Stranglethorn Vale", "Tanaris", "The Hinterlands" } },
        { name = "Mithril Deposit", skill = 175, zones = { "The Hinterlands", "Tanaris", "Azshara", "Desolace", "Badlands" } },
        { name = "Dark Iron Deposit", skill = 230, zones = { "Burning Steppes", "Searing Gorge" } },
        { name = "Truesilver Deposit", skill = 230, zones = { "Winterspring", "The Hinterlands", "Burning Steppes", "Eastern Plaguelands", "Un'Goro Crater" } },
        { name = "Small Thorium Vein", skill = 245, zones = { "Un'Goro Crater", "Silithus", "Burning Steppes", "Winterspring", "Western Plaguelands" } },
        { name = "Rich Thorium Vein", skill = 275, zones = { "Winterspring", "Eastern Plaguelands", "Azshara", "Burning Steppes", "Un'Goro Crater" } },
    },
    Herbalism = {
        { name = "Peacebloom", skill = 1, zones = { "Zephras Isle", "Mulgore", "Tirisfal Glades", "Teldrassil", "Durotar" } },
        { name = "Silverleaf", skill = 1, zones = { "Mulgore", "Zephras Isle", "Tirisfal Glades", "Elwynn Forest", "Teldrassil" } },
        { name = "Stunted Silverleaf", skill = 1, zones = { "Mulgore", "Teldrassil", "Durotar", "Tirisfal Glades", "Elwynn Forest" } },
        { name = "Tomb Weed", skill = 1, zones = { "Tirisfal Glades" } },
        { name = "Wilted Peacebloom", skill = 1, zones = { "Mulgore", "Teldrassil", "Durotar", "Dun Morogh", "Elwynn Forest" } },
        { name = "Earthroot", skill = 15, zones = { "Mulgore", "The Barrens", "Zephras Isle", "Tirisfal Glades", "Teldrassil" } },
        { name = "Mageroyal", skill = 50, zones = { "The Barrens", "Silverpine Forest", "Loch Modan", "Westfall", "Redridge Mountains" } },
        { name = "Briarthorn", skill = 70, zones = { "The Barrens", "Duskwood", "Silverpine Forest", "Redridge Mountains", "Westfall" } },
        { name = "Stranglekelp", skill = 85, zones = { "Wetlands", "Stranglethorn Vale", "Ashenvale", "Desolace", "Westfall" } },
        { name = "Bruiseweed", skill = 100, zones = { "Stonetalon Mountains", "The Barrens", "Ashenvale", "Duskwood", "Redridge Mountains" } },
        { name = "Wild Steelbloom", skill = 115, zones = { "Stranglethorn Vale", "Stonetalon Mountains", "Arathi Highlands", "Wetlands", "Thousand Needles" } },
        { name = "Grave Moss", skill = 120, zones = { "Desolace", "Duskwood", "Wetlands", "Arathi Highlands", "Eastern Plaguelands" } },
        { name = "Kingsblood", skill = 125, zones = { "Stranglethorn Vale", "Wetlands", "Hillsbrad Foothills", "Ashenvale", "Stonetalon Mountains" } },
        { name = "Liferoot", skill = 150, zones = { "Dustwallow Marsh", "Stranglethorn Vale", "Swamp of Sorrows", "Wetlands", "Alterac Mountains" } },
        { name = "Fadeleaf", skill = 160, zones = { "Dustwallow Marsh", "Stranglethorn Vale", "Arathi Highlands", "Alterac Mountains", "Swamp of Sorrows" } },
        { name = "Goldthorn", skill = 170, zones = { "Stranglethorn Vale", "Feralas", "Arathi Highlands", "Dustwallow Marsh", "Swamp of Sorrows" } },
        { name = "Khadgar's Whisker", skill = 185, zones = { "Stranglethorn Vale", "Feralas", "Arathi Highlands", "Dustwallow Marsh", "Swamp of Sorrows" } },
        { name = "Wintersbite", skill = 195, zones = { "Alterac Mountains" } },
        { name = "Firebloom", skill = 205, zones = { "Tanaris", "Searing Gorge", "Blasted Lands", "Badlands" } },
        { name = "Purple Lotus", skill = 210, zones = { "Azshara", "The Hinterlands", "Feralas", "Tanaris", "Stranglethorn Vale" } },
        { name = "Arthas' Tears", skill = 220, zones = { "Eastern Plaguelands", "Western Plaguelands", "Felwood" } },
        { name = "Sungrass", skill = 230, zones = { "Feralas", "Azshara", "The Hinterlands", "Un'Goro Crater", "Western Plaguelands" } },
        { name = "Blindweed", skill = 235, zones = { "Swamp of Sorrows", "Un'Goro Crater" } },
        { name = "Ghost Mushroom", skill = 245, zones = { "The Hinterlands", "Desolace" } },
        { name = "Gromsblood", skill = 250, zones = { "Felwood", "Blasted Lands", "Desolace", "Ashenvale" } },
        { name = "Golden Sansam", skill = 260, zones = { "Azshara", "Un'Goro Crater", "Eastern Plaguelands", "Felwood", "Burning Steppes" } },
        { name = "Dreamfoil", skill = 270, zones = { "Azshara", "Eastern Plaguelands", "Un'Goro Crater", "Felwood", "Burning Steppes" } },
        { name = "Mountain Silversage", skill = 280, zones = { "Winterspring", "Eastern Plaguelands", "Azshara", "Un'Goro Crater", "Burning Steppes" } },
        { name = "Plaguebloom", skill = 285, zones = { "Eastern Plaguelands", "Western Plaguelands", "Felwood" } },
        { name = "Icecap", skill = 290, zones = { "Winterspring" } },
        { name = "Black Lotus", skill = 300, zones = { "Burning Steppes", "Silithus", "Winterspring", "Eastern Plaguelands" } },
    },
}

-- The player level cap (see "Level cap and verification flags" at the top).
-- Forever launches with a cap of 60 (it was 30 during the beta), so every
-- dungeon and quest is in reach and nothing is hidden.
PathForeverData.LevelCap = 60

-- ============================================================
-- NOTABLE RECIPES - scaffolding only, deliberately empty.
-- ============================================================
PathForeverData.NotableRecipes = {}

-- 2026-10-26: five links added that players saw in Forever (ForeverDB's quest chain boxes, 1 player each): Heart of Disruption -> Friend of the Kirin Tor,
-- Neeru Fireblade -> Slaying the Beast, Deepmoss Spider Eggs -> Smart Drinks, The Glowing Shard -> In Nightmares. Re-check at the 2.0.0 release (tools/chain_check.py).
-- [SOURCE 2026-10-04] Dungeon quest chains, from the "Series" box on each dungeon quest's
-- wowhead.com/forever page: the quests the game offers one after another, so a quest's
-- side panel can list every step of its chain (UI.lua's DungeonChainSteps). A chain is
-- { row, row, ... }, a row { { questID, name [, requires] }, ... } (several when the game has more
-- than one version of that step). Steps outside the dungeon are listed by name and ID
-- only. Highland Hides' series, which mixes in unrelated Wetlands quests, is left out.
PathForeverData.QuestChains = {
    -- 2026-11-05: prerequisites added at Forever's launch, from Wowhead comments (several players confirmed) and each quest's Series box.
    -- Toxic Soil (11 parts; part count from ForeverDB, names and order from the Series box of Destruction in Deadmines).
    { { { 92742, "Testing the Wells" } }, { { 92744, "Murloc Gills" } }, { { 92745, "The State of the Mines" } }, { { 92747, "Moonbrook Espionage" } }, { { 92748, "Explosive Consultation" } }, { { 92749, "A Dynamite Plan" } }, { { 92750, "Detonation at a Distance" } }, { { 92751, "Detonation at a Distance" } }, { { 92752, "Explosive Consultation" } }, { { 92753, "Destruction in Deadmines" } }, { { 92819, "Destruction in Deadmines" } } },
    { { { 356, "Rear Guard Patrol" } }, { { 99156, "Rear Guard Patrol" } }, { { 92422, "The Wrath of Rath'mael" } } },
    { { { 447, "A Recipe For Death" } }, { { 450, "A Recipe For Death" } }, { { 451, "A Recipe For Death" } }, { { 95216, "The New Plague" } } },
    { { { 155, "The Defias Brotherhood" } }, { { 166, "The Defias Brotherhood" } } },
    { { { 373, "The Unsent Letter" } }, { { 389, "Bazil Thredd" } }, { { 391, "The Stockade Riots" } }, { { 392, "The Curious Visitor" } }, { { 393, "Shadow of the Past" } }, { { 350, "Look to an Old Friend" } }, { { 2745, "Infiltrating the Castle" } }, { { 2746, "Items of Some Consequence" } } },
    { { { 707, "Ironband Wants You!" } }, { { 738, "Find Agmond" } }, { { 739, "Murdaloc" } }, { { 704, "Agmond's Fate" } } },
    { { { 1489, "Hamuul Runetotem" } }, { { 1490, "Nara Wildmane" } }, { { 914, "Leaders of the Fang" } } },
    { { { 1100, "Lonebrow's Journal" } }, { { 1101, "The Crone of the Kraul" } } },
    { { { 1109, "Going, Going, Guano!" } }, { { 1113, "Hearts of Zeal" } } },
    { { { 1149, "Test of Faith" } }, { { 1150, "Test of Endurance" } }, { { 1151, "Test of Strength" } }, { { 1152, "Test of Lore" } }, { { 1154, "Test of Lore" } }, { { 6627, "Test of Lore" } }, { { 1159, "Test of Lore" } }, { { 1160, "Test of Lore" } }, { { 6628, "Test of Lore" } }, { { 1394, "Final Passage" } } },
    { { { 1198, "In Search of Thaelrid" } }, { { 1200, "Blackfathom Villainy" } } },
    { { { 3765, "The Corruption Abroad" } }, { { 1275, "Researching the Corruption" } } },
    { { { 1424, "Pool of Tears" } }, { { 1429, "The Atal'ai Exile" } }, { { 1444, "Return to Fel'Zerul" } }, { { 1445, "The Temple of Atal'Hakkar" } } },
    { { { 1469, "Rhapsody's Tale" } }, { { 1475, "Into The Temple of Atal'Hakkar" } } },
    { { { 1651, "The Tome of Valor" } }, { { 1652, "The Tome of Valor" } }, { { 1653, "The Test of Righteousness" } }, { { 1654, "The Test of Righteousness" } }, { { 1806, "The Test of Righteousness" } } },
    { { { 1949, "Hidden Secrets" } }, { { 1950, "Get the Scoop" } }, { { 1951, "Rituals of Power" } } },
    { { { 1953, "Return to the Marsh" } }, { { 1954, "The Infernal Orb" } }, { { 1955, "The Exorcism" } }, { { 1956, "Power in Uldaman" } }, { { 1957, "Mana Surges" } } },
    { { { 2041, "Speak with Shoni" } }, { { 2040, "Underground Assault" } } },
    { { { 2198, "The Shattered Necklace" } }, { { 2199, "Lore for a Price" } }, { { 2200, "Back to Uldaman" } }, { { 2201, "Find the Gems" } }, { { 2204, "Restoring the Necklace" } } },
    { { { 2258, "Badlands Reagent Run" } }, { { 2202, "Uldaman Reagent Run" } } },
    { { { 2398, "The Lost Dwarves" } }, { { 2240, "The Hidden Chamber" } } },
    { { { 2283, "Necklace Recovery" } }, { { 2284, "Necklace Recovery, Take 2" } }, { { 2318, "Translating the Journal" } }, { { 2338, "Translating the Journal" } } },
    { { { 2769, "The Brassbolts Brothers" } }, { { 2770, "Gahz'rilla" } } },
    { { { 2842, "Chief Engineer Scooty" } }, { { 2843, "Gnomer-gooooone!" } } },
    { { { 2861, "Tabetha's Task" } }, { { 2846, "Tiara of the Deep" } } },
    { { { 2864, "Tran'rek" } }, { { 2865, "Scarab Shells" } } },
    { { { 2923, "Tinkmaster Overspark" } }, { { 2922, "Save Techbot's Brain!" } } },
    { { { 2925, "Klockmort's Essentials" } }, { { 2924, "Essential Artificials" } } },
    { { { 2931, "Castpipe's Task" } }, { { 2930, "Data Rescue" } } },
    { { { 2933, "Venom Bottles" } }, { { 2934, "Undamaged Venom Sac" } }, { { 2935, "Consult Master Gadrin" } }, { { 2936, "The Spider God" } }, { { 2937, "Summoning Shadra" } } },
    { { { 2988, "Witherbark Cages" } }, { { 2989, "The Altar of Zul" } }, { { 2990, "Thadius Grimshade" } }, { { 2991, "Nekrum's Medallion" } }, { { 2992, "The Divination" } }, { { 2993, "Return to the Hinterlands" } }, { { 2994, "Saving Sharpbeak" } } },
    { { { 3523, "Scourge of the Downs" } }, { { 3525, "Extinguishing the Idol" } } },
    { { { 3520, "Screecher Spirits" } }, { { 3527, "The Prophecy of Mosh'aru" } }, { { 4787, "The Ancient Egg" } }, { { 3528, "The God Hakkar" } } },
    { { { 3801, "Dark Iron Legacy" } }, { { 3802, "Dark Iron Legacy" } } },
    { { { 3906, "Disharmony of Flame" } }, { { 3907, "Disharmony of Fire" } } },
    { { { 3981, "Commander Gor'shak" } }, { { 3982, "What Is Going On?" } }, { { 4001, "What Is Going On?" } }, { { 4002, "The Eastern Kingdoms" } }, { { 4003, "The Royal Rescue" } }, { { 4004, "The Princess Saved?" } } },
    { { { 4022, "A Taste of Flame" }, { 4023, "A Taste of Flame" } }, { { 4024, "A Taste of Flame" } } },
    { { { 4061, "The Rise of the Machines" } }, { { 4062, "The Rise of the Machines" } }, { { 4063, "The Rise of the Machines" } } },
    { { { 4128, "Ragnar Thunderbrew" } }, { { 4126, "Hurley Blackbreath" } } },
    { { { 4133, "Vivian Lagrave" } }, { { 4134, "Lost Thunderbrew Recipe" } } },
    { { { 4324, "Yuka Screwspigot" } }, { { 4136, "Ribbly Screwspigot" } } },
    { { { 4141, "Muigin and Larion" } }, { { 4142, "A Visit to Gregan" } }, { { 4143, "Haze of Evil" } } },
    { { { 4145, "Larion and Muigin" } }, { { 4147, "Marvon's Workshop" } }, { { 4146, "Zapper Fuel" } } },
    { { { 4182, "Dragonkin Menace" } }, { { 4183, "The True Masters" } }, { { 4184, "The True Masters" } }, { { 4185, "The True Masters" } }, { { 4186, "The True Masters" } }, { { 4223, "The True Masters" } }, { { 4224, "The True Masters" } }, { { 4241, "Marshal Windsor" } }, { { 4242, "Abandoned Hope" } } },
    { { { 4262, "Overmaster Pyron" } }, { { 4263, "Incendius!" } } },
    { { { 4322, "Jail Break!" } }, { { 6402, "Stormwind Rendezvous" } } },
    { { { 4342, "Kharan's Tale" } }, { { 4361, "The Bearer of Bad News" } }, { { 4362, "The Fate of the Kingdom" } }, { { 4363, "The Princess's Surprise" } } },
    { { { 4742, "Seal of Ascension" } }, { { 4743, "Seal of Ascension" } } },
    { { { 4766, "Mayara Brightwing" } }, { { 4764, "Doomrigger's Clasp" } }, { { 4765, "Delivery to Ridgewell" } } },
    { { { 4769, "Vivian Lagrave and the Darkstone Tablet" } }, { { 4768, "The Darkstone Tablet" } } },
    { { { 5522, "Leonid Barthalomew" } }, { { 5531, "Betina Bigglezink" } }, { { 4771, "Dawn's Gambit" } } },
    { { { 5065, "The Lost Tablets of Mosh'aru" } }, { { 4788, "The Final Tablets" } } },
    { { { 4903, "Warlord's Command" } }, { { 4941, "Eitrigg's Wisdom" } }, { { 4974, "For The Horde!" } } },
    { { { 4981, "Operative Bijou" } }, { { 4982, "Bijou's Belongings" } }, { { 4983, "Bijou's Reconnaissance Report" } } },
    { { { 5001, "Bijou's Belongings" } }, { { 5002, "Message to Maxwell" } }, { { 5081, "Maxwell's Mission" } } },
    { { { 5089, "General Drakkisath's Command" } }, { { 5102, "General Drakkisath's Demise" } } },
    { { { 5160, "The Matron Protectorate" } }, { { 5161, "Wrath of the Blue Flight" } }, { { 5162, "Wrath of the Blue Flight" } }, { { 5164, "Catalogue of the Wayward" } } },
    { { { 5212, "The Flesh Does Not Lie" } }, { { 5213, "The Active Agent" } } },
    { { { 5262, "The Truth Comes Crashing Down" } }, { { 5263, "Above and Beyond" } } },
    { { { 5281, "The Restless Souls" } }, { { 5282, "The Restless Souls" } } },
    { { { 5341, "Barov Family Fortune" } }, { { 5342, "The Last Barov" } } },
    { { { 5343, "Barov Family Fortune" } }, { { 5344, "The Last Barov" } } },
    { { { 5382, "Doctor Theolen Krastinov, the Butcher" } }, { { 5515, "Krastinov's Bag of Horrors" } }, { { 5384, "Kirtonos the Herald" } } },
    { { { 5461, "The Human, Ras Frostwhisper" } }, { { 5462, "The Dying, Ras Frostwhisper" } }, { { 5463, "Menethil's Gift" } }, { { 5464, "Menethil's Gift" } }, { { 5465, "Soulbound Keepsake" } }, { { 5466, "The Lich, Ras Frostwhisper" } } },
    { { { 5527, "A Reliquary of Purity" } }, { { 5526, "Shards of the Felvine" } } },
    { { { 5722, "Searching for the Lost Satchel" } }, { { 5724, "Returning the Lost Satchel" } } },
    { { { 5727, "Hidden Enemies", 9 } }, { { 5728, "Hidden Enemies" } }, { { 5729, "Hidden Enemies", 9 } }, { { 5730, "Hidden Enemies", 9 } } },
    { { { 5742, "Redemption" } }, { { 5781, "Of Forgotten Memories" } }, { { 5845, "Of Lost Honor" } }, { { 5846, "Of Love and Family" } }, { { 5848, "Of Love and Family" } }, { { 5861, "Find Myranda" } }, { { 5862, "Scarlet Subterfuge" } } },
    { { { 6403, "The Great Masquerade" } }, { { 6501, "The Dragon's Eye" } }, { { 6502, "Drakefire Amulet" } } },
    { { { 6522, "An Unholy Alliance" } }, { { 6521, "An Unholy Alliance" } } },
    { { { 6562, "Trouble in the Deeps" } }, { { 6563, "The Essence of Aku'Mai" } } },
    { { { 6564, "Allegiance to the Old Gods" } }, { { 6565, "Allegiance to the Old Gods" } } },
    { { { 6585, "The Test of Skulls, Axtroz" } }, { { 6601, "Ascension..." } }, { { 6602, "Blood of the Black Dragon Champion" } } },
    { { { 6821, "Eye of the Emberseer" } }, { { 6822, "The Molten Core" } }, { { 6823, "Agent of Hydraxis" } }, { { 6824, "Hands of the Enemy" } } },
    { { { 7461, "The Madness Within" } }, { { 7877, "The Treasure of the Shen'dralar" } } },
    { { { 7494, "Feathermoon Stronghold" } }, { { 7488, "Lethtendris's Web" } } },
    { { { 7492, "Camp Mojache" } }, { { 7489, "Lethtendris's Web" } } },
    { { { 8929, "In Search of Anthion" }, { 8930, "In Search of Anthion" } }, { { 8945, "Dead Man's Plea" } }, { { 8946, "Proof of Life" } }, { { 8947, "Anthion's Strange Request" } }, { { 8948, "Anthion's Old Friend" } }, { { 8949, "Falrin's Vendetta" } }, { { 8950, "The Instigator's Enchantment" } } },
    { { { 92415, "Remember That I Love You" } }, { { 95161, "Remember That I Love You" } } },
    { { { 95663, "Dragonmaw Rumors" } }, { { 95682, "Open the Maw" } } },
    { { { 95647, "Lost in the Thicket Things" } }, { { 95809, "Heartwoven" } } },
    { { { 96391, "Underground Map" } }, { { 96393, "Old Ironforge Incursion" } } },
    { { { 97288, "Unending Torment" } }, { { 97289, "Unending Torment" } }, { { 97290, "Unending Torment" } }, { { 97291, "Unending Torment" } }, { { 97292, "Unending Torment" } } },
    { { { 95664, "Elder Knowledge" } }, { { 98823, "Earthen Echo" } } },
    { { { 95810, "Lost Relic Carry" } }, { { 98824, "Prehistoric Prism" } } },
    { { { 92432, "An Alarming Request" } }, { { 92458, "Heart of Disruption" } }, { { 92459, "Friend of the Kirin Tor" } } },
    { { { 829, "Neeru Fireblade" } }, { { 5761, "Slaying the Beast" } } },
    { { { 1069, "Deepmoss Spider Eggs" } }, { { 1491, "Smart Drinks" } } },
    { { { 6981, "The Glowing Shard" } }, { { 3369, "In Nightmares" } } },
    { { { 544, "Prison Break In" } }, { { 545, "Dalaran Patrols" } }, { { 92434, "Blood in the Streets" } }, { { 96984, "Heart of Disruption" } }, { { 97287, "Shrewd Negotiations" } } },
}
