-- Core.lua
-- Event handling, slash commands, and the logic that turns PathForeverData
-- into "here's what matters right now" for your current character.
--
-- Note on the profession API: this uses GetProfessions() / GetProfessionInfo(),
-- the classic-style tradeskill calls. Forever is built on retail's 12.1.5 UI
-- architecture, and I'm assuming it keeps the old skill-level system for its
-- vanilla-style professions rather than the Dragonflight talent-tree revamp -
-- but that's an assumption, not something verified against the Forever
-- client. If the Professions tab comes up empty in-game, this is the first
-- place to check against wiki.gg or the WoW UI Dev Discord.

PathForever = CreateFrame("Frame")
local PF = PathForever
-- The PathForever logo (Media/icon.tga, 64x64): the minimap button, the window's title
-- and, through ## IconTexture in the TOC, the AddOns list.
PF.ICON = "Interface\\AddOns\\PathForever\\Media\\icon"
-- Where to find the author (Options > About, the Follow logos). Logos: Media/follow-*.tga.
PF.FOLLOW = {
    { name = "Twitch", url = "https://twitch.tv/oheyspun", icon = "Interface\\AddOns\\PathForever\\Media\\follow-twitch" },
    { name = "YouTube", url = "https://youtube.com/oheyspun", icon = "Interface\\AddOns\\PathForever\\Media\\follow-youtube" },
    { name = "X", url = "https://x.com/oheyspun", icon = "Interface\\AddOns\\PathForever\\Media\\follow-x" },
}
PF.frame = CreateFrame("Frame")

-- ---------- Versioning ----------
-- The addon version lives in exactly one place: the "## Version:" line of
-- PathForever.toc. Everything that shows or uses it (window header, Options
-- tab, /pf version, the build script) reads it from there.
local function ReadAddonVersion()
    local getMeta = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
    return (getMeta and getMeta("PathForever", "Version")) or "unknown"
end
PF.version = ReadAddonVersion()

-- Version of the SAVED DATA's shape, independent of the addon version. Bump
-- it whenever PathForeverDB's structure changes, and add a migration below.
PF.DB_VERSION = 9

-- Session-only counters (never saved). /pf memory prints them, so a report can
-- say how much redrawing and saving the addon really did.
PF.stats = { refreshes = 0, skipped = 0, saves = 0, savesSkipped = 0 }

-- ---------- Saved variables ----------
-- Each entry upgrades saved data FROM the previous schema version TO its own
-- number. Never edit a shipped migration; add a new one and bump DB_VERSION.
local migrations = {
    -- 2: alt-character data used to be keyed "Name-Realm"; it is now keyed by
    -- GUID. Flag the old entries. Each one is replaced automatically the next
    -- time that character logs in (see SaveCurrentCharacterProfessions).
    [2] = function(db)
        for key, data in pairs(db.characters or {}) do
            if type(key) == "string" and not key:find("^Player%-") and type(data) == "table" then
                data.legacy = true
            end
        end
    end,

    -- 3: characters were identified by first name + realm. Forever is realmless and
    -- gives characters a first AND last name, so different characters can share a
    -- first name; identifying by name merged them into one entry, and later
    -- deleted or hid the others. Entries keyed exactly "<name>-<realm>" (the old
    -- format) can't be attributed to a single character, so they are dropped; each
    -- character re-saves under its GUID the next time it logs in. GUID-keyed
    -- entries are kept. This deliberately does NOT try to recognise a GUID by its
    -- shape, and it clears the "legacy" flag migration 2 may have put on them.
    [3] = function(db)
        local chars = db.characters
        if type(chars) ~= "table" then return end
        for key, data in pairs(chars) do
            if type(data) == "table" then
                if type(data.name) == "string" and type(data.realm) == "string"
                    and key == data.name .. "-" .. data.realm then
                    chars[key] = nil
                else
                    data.legacy = nil
                end
            end
        end
    end,

    -- 4: characters can be hidden from the Professions tab's alt list.
    -- hiddenCharacters is a set of GUIDs (GUID -> true), kept apart from
    -- `characters` because a character's own entry is rebuilt on every save.
    [4] = function(db)
        if type(db.hiddenCharacters) ~= "table" then db.hiddenCharacters = {} end
    end,

    -- 5: PathForever Fishing saves catches per zone (Fishing.lua):
    -- fishing.zones[<map ID>] = { name =, fish = { [itemID] = { name, icon, quality, count } } }
    [5] = function(db)
        if type(db.fishing) ~= "table" then db.fishing = { zones = {} } end
    end,

    -- 6: the Journey tab (Journey.lua) keeps class trainers' real prices per class,
    -- and per character (by GUID) the quests turned in per zone:
    -- journey = { trainer = { [CLASS] = { ["Name|rank"] = copper } }, chars = { [guid] = { zones = { [zone] = n } } } }
    [6] = function(db)
        if type(db.journey) ~= "table" then db.journey = { trainer = {}, chars = {} } end
    end,

    -- 7: the item wishlist (stars on boss loot), per character by GUID:
    -- wishlist[guid][itemID] = { name, dungeon, boss, added, got }; `got` is when the
    -- character was first seen to have the item.
    [7] = function(db)
        if type(db.wishlist) ~= "table" then db.wishlist = {} end
    end,

    -- 8: PathForever Camping (Camping.lua) saves where its window was dragged to:
    -- camping = { point = { "TOPLEFT", "UIParent", "BOTTOMLEFT", x, y } }
    [8] = function(db)
        if type(db.camping) ~= "table" then db.camping = {} end
    end,

    -- 9: boss kill counts, per character by GUID: kills[guid]["<dungeon>|<boss>"] = number
    [9] = function(db)
        if type(db.kills) ~= "table" then db.kills = {} end
    end,
}

local function MigrateDB(db)
    local from = db.dbVersion or 1
    if from > PF.DB_VERSION then return end -- saved by a NEWER build; leave it alone
    for v = from + 1, PF.DB_VERSION do
        if migrations[v] then migrations[v](db) end
        db.dbVersion = v
    end
end

local function InitDB()
    if not PathForeverDB then
        PathForeverDB = {
            dbVersion = PF.DB_VERSION,
            point = { "CENTER", "UIParent", "CENTER", 0, 0 },
            activeTab = "Journey",
            hiddenCharacters = {},
            fishing = { zones = {} },
            journey = { trainer = {}, chars = {} },
            wishlist = {},
            camping = {},
            kills = {},
        }
    else
        MigrateDB(PathForeverDB)
    end
    PathForeverDB.options = PathForeverDB.options or {}
    if PathForeverDB.options.altTracking == nil then
        PathForeverDB.options.altTracking = true -- default on
    end
    -- Forever has no cap below 60 and everything in the game is reachable: nothing is hidden
    PathForeverDB.options.showAboveCap = true
    if PathForeverDB.options.showMinimap == nil then
        PathForeverDB.options.showMinimap = true
    end
    if PathForeverDB.options.levelUpMessages == nil then
        PathForeverDB.options.levelUpMessages = true -- the chat lines on PLAYER_LEVEL_UP
    end
    if PathForeverDB.options.trainerReminders == nil then
        PathForeverDB.options.trainerReminders = true -- a chat line in cities and inns when skills wait at the trainer
    end
    if PathForeverDB.options.fishingWindow == nil then
        PathForeverDB.options.fishingWindow = true -- PathForever Fishing opens with a fishing pole
    end
    if PathForeverDB.options.campWindow == nil then
        PathForeverDB.options.campWindow = true -- PathForever Camping opens at a campfire
    end
    if PathForeverDB.options.levelTracker == nil then
        PathForeverDB.options.levelTracker = false -- the leveling tracker window (Tracker.lua) is opt-in
    end
    if PathForeverDB.options.enemySpotter == nil then
        PathForeverDB.options.enemySpotter = false -- the enemy spotter strip (Spotter.lua) is opt-in
    end
    PathForeverDB.lastVersion = PF.version -- which build last touched this data

    -- Saved character data that isn't even a table can't be shown or repaired.
    if type(PathForeverDB.characters) == "table" then
        for key, data in pairs(PathForeverDB.characters) do
            if type(data) ~= "table" then PathForeverDB.characters[key] = nil end
        end
    end
end

-- ---------- Dungeon lookups ----------
-- Kept for anything that wants a "near my level" slice - the Dungeons tab
-- itself shows everything, colored by state, but this is still used for
-- level-up detection below.
function PF:GetRelevantDungeons(level, near)
    near = near or 2
    local results = {}
    for _, d in ipairs(PathForeverData.Dungeons) do
        if level >= (d.levelMin - near) and level <= (d.levelMax + near) then
            table.insert(results, d)
        end
    end
    table.sort(results, function(a, b) return a.levelMin < b.levelMin end)
    return results
end

-- ---------- Level cap ----------
-- The beta caps players at PathForeverData.LevelCap. Unless the player has
-- turned on "Show content above the level cap", anything that can't be
-- reached at or below it is hidden, so the lists only show what a player can
-- actually do right now. A nil cap means no limit (the full game).
function PF:GetActiveLevelCap()
    local cap = PathForeverData.LevelCap
    if not cap then return nil end
    if PathForeverDB and PathForeverDB.options and PathForeverDB.options.showAboveCap then return nil end
    return cap
end

function PF:IsDungeonBeyondCap(d)
    local cap = self:GetActiveLevelCap()
    return cap ~= nil and d.levelMin ~= nil and d.levelMin > cap
end

function PF:IsZoneBeyondCap(z)
    local cap = self:GetActiveLevelCap()
    return cap ~= nil and z.levelMin ~= nil and z.levelMin > cap
end

-- Only quests whose minimum level is KNOWN to be above the cap are hidden.
-- A quest with no `requires` on file can't be judged, so it stays visible.
function PF:IsQuestBeyondCap(q)
    local cap = self:GetActiveLevelCap()
    return cap ~= nil and q.requires ~= nil and q.requires > cap
end

-- Whether this character can pick the quest up at all: its faction (nil = both),
-- its class and its race. `class` is nil (every class), a class token
-- ("WARLOCK"), or a list of tokens; `races` is nil (every race) or a list of race
-- IDs (UnitRace's third return), from the "Class:" and "Races:" lines of the
-- quest's wowhead.com/forever page. Allocates nothing: it runs on every redraw.
function PF:IsQuestForPlayer(q, playerFaction, playerClass, playerRace)
    if q.faction and q.faction ~= playerFaction then return false end
    local c = q.class
    if c then
        if type(c) == "string" then
            if c ~= playerClass then return false end
        else
            local found = false
            for i = 1, #c do
                if c[i] == playerClass then found = true break end
            end
            if not found then return false end
        end
    end
    local r = q.races
    if r and playerRace then
        for i = 1, #r do
            if r[i] == playerRace then return true end
        end
        return false
    end
    return true
end

function PF:GetHiddenQuestCount(d)
    local hidden = 0
    if not d.quests then return 0 end
    local playerFaction = UnitFactionGroup("player")
    local _, playerClass = UnitClass("player")
    local _, _, playerRace = UnitRace("player")
    for _, q in ipairs(d.quests) do
        if self:IsQuestForPlayer(q, playerFaction, playerClass, playerRace) and self:IsQuestBeyondCap(q) then
            hidden = hidden + 1
        end
    end
    return hidden
end

function PF:GetRelevantZones(level, near)
    near = near or 3
    local results = {}
    for _, z in ipairs(PathForeverData.Zones) do
        if self:IsZoneBeyondCap(z) then
            -- hidden by the level cap
        elseif z.levelMin == nil then
            table.insert(results, z)
        elseif level >= (z.levelMin - near) and level <= (z.levelMax + near) then
            table.insert(results, z)
        end
    end
    table.sort(results, function(a, b)
        return (a.levelMin or 999) < (b.levelMin or 999)
    end)
    return results
end

-- ---------- Dungeon state (grey / green / red) ----------
-- Filters a dungeon's quest list down to what THIS character can actually
-- pick up: quests with no faction tag are available to everyone, quests
-- tagged "Horde" or "Alliance" only show for that faction, and class quests
-- only for that class (see IsQuestForPlayer).
function PF:GetEffectiveQuests(d)
    local results = {}
    if not d.quests then return results end
    local playerFaction = UnitFactionGroup("player")
    local _, playerClass = UnitClass("player")
    local _, _, playerRace = UnitRace("player")
    for _, q in ipairs(d.quests) do
        if self:IsQuestForPlayer(q, playerFaction, playerClass, playerRace) and not self:IsQuestBeyondCap(q) then
            table.insert(results, q)
        end
    end
    return results
end

-- "done" requires every quest THIS FACTION can pick up to have a known
-- quest ID AND be flagged completed. A dungeon with no IDs on file can
-- never show as done - that's intentional, it means "not tracked yet,"
-- not "not done."
-- Whether the quest is currently in the player's quest log (accepted but
-- not yet turned in) - separate from IsQuestFlaggedCompleted.
function PF:IsQuestInLog(questID)
    if not questID or not C_QuestLog.IsOnQuest then return false end
    return C_QuestLog.IsOnQuest(questID)
end

-- One pass over a dungeon's quests that allocates nothing (unlike
-- GetEffectiveQuests, which builds a list): returns how many quests THIS
-- character can pick up (its faction, and not hidden by the level cap), how
-- many of those are flagged complete, and whether the dungeon counts as done.
function PF:GetDungeonQuestCounts(d)
    if not d.quests then return 0, 0, false end
    local total, completed, allDone = 0, 0, true
    local playerFaction = UnitFactionGroup("player")
    local _, playerClass = UnitClass("player")
    local _, _, playerRace = UnitRace("player")
    for _, q in ipairs(d.quests) do
        if self:IsQuestForPlayer(q, playerFaction, playerClass, playerRace) and not self:IsQuestBeyondCap(q) then
            total = total + 1
            if q.id and C_QuestLog.IsQuestFlaggedCompleted(q.id) then
                completed = completed + 1
            else
                allDone = false -- no ID on file, or not completed yet
            end
        end
    end
    return total, completed, total > 0 and allDone
end

function PF:GetDungeonQuestCompletion(d)
    local _, _, allDone = self:GetDungeonQuestCounts(d)
    return allDone
end

-- `allDone` may be passed in by a caller that already counted the quests.
function PF:GetDungeonState(d, level, allDone)
    if allDone == nil then allDone = self:GetDungeonQuestCompletion(d) end
    if allDone then return "done" end
    if level >= d.levelMin and level <= d.levelMax then return "ready" end
    return "locked"
end

-- Whether a quest in the log has all its objectives done (the yellow "?" in
-- the game). Unverified on Forever, so it's wrapped: false if the client can't say.
function PF:IsQuestReadyToTurnIn(questID)
    if not questID or not (C_QuestLog and C_QuestLog.IsComplete) then return false end
    local ok, done = pcall(C_QuestLog.IsComplete, questID)
    return ok and done == true
end

-- The level a quest can be picked up at. Most quests have `requires` on file;
-- until the rest are researched, the dungeon's own minimum level stands in.
function PF:GetQuestRequiredLevel(q, d)
    return q.requires or (d and d.levelMin) or 1
end

-- One quest's status for THIS character, used by every place that shows it:
--   "untracked"   no quest ID on file, so completion can't be checked
--   "completed"   flagged complete
--   "inprogress"  in the quest log now
--   "available"   can be picked up at the character's level
--   "unavailable" the character is below the quest's minimum level
function PF:GetQuestStatus(q, d, level)
    if not q.id then return "untracked" end
    if C_QuestLog.IsQuestFlaggedCompleted(q.id) then return "completed" end
    if self:IsQuestInLog(q.id) then return "inprogress" end
    if (level or UnitLevel("player")) >= self:GetQuestRequiredLevel(q, d) then return "available" end
    return "unavailable"
end

-- Whether the character is inside the dungeon's level range OR its quest range:
-- from the lowest level any of its quests can be picked up at (this faction,
-- not hidden by the cap), up to the dungeon's maximum. Wailing Caverns is
-- 17-24 but has quests at 10, so this is true from 10 to 24. Completion
-- doesn't matter, just as a finished dungeon still counts as "in range".
-- Decides which dungeons float to the top of the list, which show their art,
-- and where "New Quests Available!" can appear; allocates nothing.
function PF:IsInDungeonOrQuestRange(d, level)
    if d.comingSoon or level > d.levelMax then return false end
    if level >= d.levelMin then return true end
    if not d.quests then return false end
    local playerFaction = UnitFactionGroup("player")
    local _, playerClass = UnitClass("player")
    local _, _, playerRace = UnitRace("player")
    for _, q in ipairs(d.quests) do
        if self:IsQuestForPlayer(q, playerFaction, playerClass, playerRace) and not self:IsQuestBeyondCap(q)
            and level >= self:GetQuestRequiredLevel(q, d) then
            return true
        end
    end
    return false
end

-- How many quests in a dungeon this character could go and pick up right now:
-- only within the dungeon's quest range (see IsInDungeonOrQuestRange - the
-- same rule that floats it to the top of the list), and only quests that are
-- "available" (not completed, not already in the log). An available quest is
-- by definition at or below your level, so the only extra limit needed here is
-- the dungeon's maximum. Like GetDungeonQuestCounts it allocates nothing - it
-- runs on every list redraw.
function PF:GetDungeonNewQuestCount(d, level)
    if not d.quests or d.comingSoon or level > d.levelMax then return 0 end
    local count = 0
    local playerFaction = UnitFactionGroup("player")
    local _, playerClass = UnitClass("player")
    local _, _, playerRace = UnitRace("player")
    for _, q in ipairs(d.quests) do
        if self:IsQuestForPlayer(q, playerFaction, playerClass, playerRace) and not self:IsQuestBeyondCap(q)
            and self:GetQuestStatus(q, d, level) == "available" then
            count = count + 1
        end
    end
    return count
end

-- ---------- Current instance detection ----------
-- Returns the dungeon entries matching the instance you're currently in,
-- for opening the addon straight to "here." Some complexes are one single
-- instance with several wings chosen at the door (Scarlet Monastery's 4,
-- Dire Maul's 3) - the game reports one instance name for all of them, so
-- this can return more than one match. The caller decides what to do with
-- an ambiguous result rather than this function guessing for you.
function PF:GetCurrentDungeonMatches()
    local inInstance, instanceType = IsInInstance()
    if not inInstance or instanceType ~= "party" then return nil end

    local name = GetInstanceInfo()
    if not name then return nil end

    local matches = {}
    for _, d in ipairs(PathForeverData.Dungeons) do
        if d.name == name then
            table.insert(matches, d)
        end
    end

    if #matches == 0 then return nil end
    return matches
end

-- ---------- Quest XP (live-first, cached fallback) ----------
-- Kicks off a load for the quest's data (needed before the client can
-- answer for a quest not currently in your log) and tries the live API.
-- Untested against Forever's actual client - if GetQuestLogRewardXP
-- doesn't behave as documented here, this just falls through to the
-- researched xp number with no error, so the feature degrades safely.
function PF:GetQuestXP(q)
    if q.id then
        if C_QuestLog and C_QuestLog.RequestLoadQuestByID then
            C_QuestLog.RequestLoadQuestByID(q.id)
        end
        if GetQuestLogRewardXP then
            local ok, liveXP = pcall(GetQuestLogRewardXP, q.id)
            if ok and liveXP and liveXP > 0 then
                return liveXP, true -- true = confirmed live
            end
        end
    end
    return q.xp, false
end

-- ---------- Zone map IDs, by name ----------
-- The map ID of a zone (or city) the game names `name`, read from the game's own
-- map tree the first time it's needed: the world the player is in, and every zone
-- under it. Data that names a zone (the Journey's class quests) gets a map pin
-- this way without any map ID on file. nil until the client can answer.
local zoneMapIDs
function PF:GetZoneMapID(name)
    if not name then return nil end
    if not zoneMapIDs then
        if not (C_Map and C_Map.GetBestMapForUnit and C_Map.GetMapInfo and C_Map.GetMapChildrenInfo) then return nil end
        local ok, mapID = pcall(C_Map.GetBestMapForUnit, "player")
        if not ok or not mapID then return nil end
        -- up to the top of the map tree
        for _ = 1, 8 do
            local okI, info = pcall(C_Map.GetMapInfo, mapID)
            if not okI or not info or not info.parentMapID or info.parentMapID == 0 then break end
            mapID = info.parentMapID
        end
        local okC, children = pcall(C_Map.GetMapChildrenInfo, mapID, nil, true)
        if not okC or type(children) ~= "table" then return nil end
        zoneMapIDs = {}
        for _, child in ipairs(children) do
            -- zones (3) first; a dungeon or sub-zone map of the same name never wins
            if child.name and (not zoneMapIDs[child.name] or child.mapType == 3) then
                zoneMapIDs[child.name] = child.mapID
            end
        end
    end
    return zoneMapIDs[name]
end

-- ---------- Professions ----------
local function GetExpectedSkill(level)
    if level < PathForeverData.ProfessionGraceLevel then
        return 0
    end
    local expected = level * PathForeverData.ProfessionSkillPerLevel
    return math.min(expected, PathForeverData.ProfessionSkillCap)
end
function PF:GetExpectedSkill(level) return GetExpectedSkill(tonumber(level) or 1) end

-- isPrimary marks the two main crafting/gathering slots (prof1/prof2) as
-- opposed to cooking/fishing/first aid/archaeology, since several features
-- (alt tracking, training prompts) only care about primaries.
-- `level` defaults to the character's (the level-up event passes the new one,
-- since UnitLevel can still report the old level then).
function PF:GetProfessionStatus(level)
    level = level or UnitLevel("player")
    local expected = GetExpectedSkill(level)
    local results = {}

    if GetProfessions then
        local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()
        local slots = {
            { index = prof1, isPrimary = true }, { index = prof2, isPrimary = true },
            { index = cooking, isPrimary = false }, { index = fishing, isPrimary = false },
            { index = firstAid, isPrimary = false }, { index = archaeology, isPrimary = false },
        }
        for _, slot in ipairs(slots) do
            if slot.index then
                local name, icon, skillLevel, maxSkillLevel, _, _, skillLine = GetProfessionInfo(slot.index)
                if name then
                    table.insert(results, {
                        name = name,
                        icon = icon,
                        skillLine = skillLine,
                        skillLevel = skillLevel,
                        maxSkillLevel = maxSkillLevel,
                        expected = expected,
                        behind = skillLevel < expected,
                        isPrimary = slot.isPrimary,
                    })
                end
            end
        end
    end

    return results
end

-- How many primary profession slots are filled (0-2), and whether the
-- three secondary tradeskills are trained at all - used for the "train
-- your tradeskills" prompts.
function PF:GetProfessionSlotSummary()
    local primaryCount, hasCooking, hasFishing, hasFirstAid = 0, false, false, false
    for _, p in ipairs(self:GetProfessionStatus()) do
        if p.isPrimary then
            primaryCount = primaryCount + 1
        elseif p.name == COOKING then
            hasCooking = true
        elseif p.name == FISHING then
            hasFishing = true
        elseif p.name == FIRST_AID then
            hasFirstAid = true
        end
    end
    return primaryCount, hasCooking, hasFishing, hasFirstAid
end

-- Scans all bags for any of the given item IDs. Used for the "you trained
-- Mining/Skinning but don't have the tool" nudge. Classic-era item IDs
-- carry over to Forever unchanged (confirmed elsewhere in this project),
-- so these are the same IDs that work in Classic.
function PF:HasAnyItemInBags(itemIDs)
    if not C_Container or not C_Container.GetContainerNumSlots then return true end -- can't check, don't warn
    local wanted = {}
    for _, id in ipairs(itemIDs) do wanted[id] = true end
    local bags = { 0, 1, 2, 3, 4, (Enum.BagIndex and Enum.BagIndex.ReagentBag) or 5 }
    for _, bag in ipairs(bags) do
        local slots = C_Container.GetContainerNumSlots(bag) or 0
        for slot = 1, slots do
            local itemID = C_Container.GetContainerItemID(bag, slot)
            if itemID and wanted[itemID] then
                return true
            end
        end
    end
    return false
end

-- ---------- Alt character profession tracking ----------
-- Saved once per login/skill-change under an account-wide table keyed by
-- GUID, primary professions only (cooking/fishing/first aid are
-- deliberately left out so the alt list doesn't get cluttered).
-- The character's full display name ("First Last"). Forever gives characters a
-- first and a last name, and GetUnitName("player", true) returns both. If it
-- doesn't, assemble the name from UnitName, whose second return can carry the
-- last name. Returns nil while the unit hasn't finished loading, so the caller
-- just skips that save pass instead of storing "Unknown Entity".
function PF:GetPlayerFullName()
    local unknown = UNKNOWNOBJECT or "Unknown Entity"
    local full = GetUnitName and GetUnitName("player", true)
    if type(full) == "string" and full ~= "" and full ~= unknown then return full end
    local first, second = UnitName("player")
    if type(first) ~= "string" or first == "" or first == unknown then return nil end
    if type(second) == "string" and second ~= "" then return first .. " " .. second end
    return first
end

-- True when the saved entry already says everything the live character does,
-- so a save can be skipped instead of rebuilding an identical entry.
local function SameCharacterData(old, name, class, className, level, professions)
    if type(old) ~= "table" then return false end
    if old.name ~= name or old.class ~= class or old.className ~= className or old.level ~= level then return false end
    local oldProfs = old.professions
    if type(oldProfs) ~= "table" or #oldProfs ~= #professions then return false end
    for i, p in ipairs(professions) do
        local o = oldProfs[i]
        if type(o) ~= "table" or o.name ~= p.name or o.skillLevel ~= p.skillLevel or o.maxSkillLevel ~= p.maxSkillLevel then
            return false
        end
    end
    return true
end

-- Saved entries can be incomplete (older builds, interrupted saves), so read
-- them defensively: a bad entry is skipped or repaired here, and can never
-- stop the rest of the list from showing.
local function SanitizeProfessions(list)
    local out = {}
    if type(list) ~= "table" then return out end
    for _, p in ipairs(list) do
        if type(p) == "table" and type(p.name) == "string" then
            table.insert(out, {
                name = p.name,
                skillLevel = tonumber(p.skillLevel) or 0,
                maxSkillLevel = tonumber(p.maxSkillLevel) or 0,
            })
        end
    end
    return out
end

-- A character is identified by its GUID and nothing else. Names are display
-- only: they are NOT unique (Forever lets characters share a first name), and
-- nothing here may ever match, delete or hide a character by name.
function PF:SaveCurrentCharacterProfessions()
    if not PathForeverDB then return end
    if not PathForeverDB.options or PathForeverDB.options.altTracking == false then return end
    PathForeverDB.characters = PathForeverDB.characters or {}
    local guid = UnitGUID("player")
    local fullName = self:GetPlayerFullName()
    if not guid or not fullName then return end -- not fully loaded yet, skip this pass

    local className, classToken = UnitClass("player")
    local level = UnitLevel("player")
    local old = PathForeverDB.characters[guid]
    local statuses = self:GetProfessionStatus()
    local primaries = {}
    if #statuses == 0 and type(old) == "table" then
        -- GetProfessions() returns nothing until the client has loaded skill
        -- data (early at login) and can return nothing again during logout.
        -- A scan that found no professions at all - not even cooking or
        -- fishing - is not proof of "none trained", so keep what was saved
        -- rather than wiping the alt's list. Any scan that finds a profession
        -- is trusted as-is, so a dropped profession still clears.
        primaries = SanitizeProfessions(old.professions)
    else
        for _, p in ipairs(statuses) do
            if p.isPrimary then
                table.insert(primaries, {
                    name = p.name,
                    skillLevel = tonumber(p.skillLevel) or 0,
                    maxSkillLevel = tonumber(p.maxSkillLevel) or 0,
                })
            end
        end
    end

    if SameCharacterData(old, fullName, classToken, className, level, primaries) then
        PF.stats.savesSkipped = PF.stats.savesSkipped + 1
        return
    end
    PF.stats.saves = PF.stats.saves + 1
    PathForeverDB.characters[guid] = {
        name = fullName,
        class = classToken,
        className = className,
        level = level,
        professions = primaries,
    }
end

-- Skill-ups can fire SKILL_LINES_CHANGED many times in a burst. Collapse a
-- burst into one save a moment later (logout still saves immediately).
local saveScheduled = false
local function FlushScheduledSave()
    saveScheduled = false
    PF:SaveCurrentCharacterProfessions()
end
function PF:ScheduleSave()
    if saveScheduled then return end
    saveScheduled = true
    C_Timer.After(1, FlushScheduledSave)
end

-- Every saved character except the one currently logged in, as fresh tables
-- (the saved data itself is never modified).
function PF:GetOtherCharacters()
    local results = {}
    local chars = PathForeverDB and PathForeverDB.characters
    if type(chars) ~= "table" then return results end
    local currentGUID = UnitGUID("player")
    for key, data in pairs(chars) do
        if key ~= currentGUID and type(data) == "table" and type(data.name) == "string" and data.name ~= "" then
            table.insert(results, {
                key = key,
                name = data.name,
                class = data.class,
                className = data.className,
                level = tonumber(data.level) or 0,
                professions = SanitizeProfessions(data.professions),
            })
        end
    end
    table.sort(results, function(a, b)
        if a.name ~= b.name then return a.name < b.name end
        return tostring(a.key) < tostring(b.key)
    end)
    return results
end

-- Manual removal only - see the note in chat about why this doesn't prune
-- by inactivity automatically.
function PF:RemoveCharacter(key)
    if PathForeverDB and PathForeverDB.characters then
        PathForeverDB.characters[key] = nil
    end
    if PathForeverDB and type(PathForeverDB.hiddenCharacters) == "table" then
        PathForeverDB.hiddenCharacters[key] = nil
    end
end

-- Hiding only takes a character off the alt list; its data is kept and still
-- saved when it logs in. Keyed by GUID like everything else about characters.
function PF:IsCharacterHidden(key)
    local hidden = PathForeverDB and PathForeverDB.hiddenCharacters
    return type(hidden) == "table" and hidden[key] == true
end

function PF:HideCharacter(key)
    if not PathForeverDB then return end
    if type(PathForeverDB.hiddenCharacters) ~= "table" then PathForeverDB.hiddenCharacters = {} end
    PathForeverDB.hiddenCharacters[key] = true
end

function PF:RestoreHiddenCharacters()
    if PathForeverDB then PathForeverDB.hiddenCharacters = {} end
end

-- ---------- Spec (the talent tree with the most points) ----------
-- NOT VERIFIED ON FOREVER (docs/launch-checklist.md): the client's talent API is not
-- known, so every call is guarded and several layouts are tried. Whatever goes wrong,
-- the answer is "per class" (key = the class token), which is also what a character
-- with no talent points, or a tie between trees, gets. A spec's key is "CLASS:tree".
do
local TREES = {
    WARRIOR = { "Arms", "Fury", "Protection" },
    PALADIN = { "Holy", "Protection", "Retribution" },
    HUNTER = { "Beast Mastery", "Marksmanship", "Survival" },
    ROGUE = { "Assassination", "Combat", "Subtlety" },
    PRIEST = { "Discipline", "Holy", "Shadow" },
    SHAMAN = { "Elemental", "Enhancement", "Restoration" },
    MAGE = { "Arcane", "Fire", "Frost" },
    WARLOCK = { "Affliction", "Demonology", "Destruction" },
    DRUID = { "Balance", "Feral Combat", "Restoration" },
}
PF.SPEC_TREES = TREES

-- One talent tab's name and points. The classic call returns name, icon, points; the
-- retail one id, name, description, icon, points.
local function ReadTab(i)
    if type(GetTalentTabInfo) ~= "function" then return end
    local ok, a, b, c, d, e = pcall(GetTalentTabInfo, i)
    if not ok then return end
    if type(a) == "number" and type(b) == "string" then
        return b, type(e) == "number" and e or 0
    elseif type(a) == "string" then
        return a, type(c) == "number" and c or 0
    end
end

-- Returns { class, key, name, points, total, source }. `source` is "talents" (counted
-- from the tabs), "specialization" (the client named one) or "class" (nothing to go on).
function PF:GetSpec()
    local _, class = UnitClass("player")
    local out = { class = class, key = class, points = {}, total = 0, source = "class" }
    if type(GetNumTalentTabs) == "function" then
        local ok, n = pcall(GetNumTalentTabs)
        if ok and type(n) == "number" and n > 0 and n <= 4 then
            local best, bestPoints, tied = nil, 0, false
            for i = 1, n do
                local name, points = ReadTab(i)
                if name then
                    out.points[i] = points
                    out.total = out.total + points
                    if points > bestPoints then
                        best, bestPoints, tied = i, points, false
                        out.name = name
                    elseif points == bestPoints and points > 0 then
                        tied = true
                    end
                end
            end
            if best and not tied then
                out.key = class .. ":" .. best
                out.source = "talents"
                out.name = out.name or (TREES[class] and TREES[class][best])
                return out
            end
            out.name = nil
            return out
        end
    end
    if type(GetSpecialization) == "function" and type(GetSpecializationInfo) == "function" then
        local ok, index = pcall(GetSpecialization)
        if ok and type(index) == "number" and index > 0 then
            local ok2, _, name = pcall(GetSpecializationInfo, index)
            out.key = class .. ":" .. index
            out.name = ok2 and type(name) == "string" and name or (TREES[class] and TREES[class][index])
            out.source = "specialization"
        end
    end
    return out
end
end -- do (Spec)

-- ---------- Wishlist (stars on boss loot, UI.lua; the Discover list, Journey.lua) ----------
-- Per character, by GUID. An item counts as received once the character is seen to
-- have it (bags, bank or worn) and stays received after it is sold or replaced.
do
local function WishTable(create)
    local guid = UnitGUID and UnitGUID("player")
    local db = PathForeverDB
    if not (db and guid) then return end
    if type(db.wishlist) ~= "table" then
        if not create then return end
        db.wishlist = {}
    end
    local t = db.wishlist[guid]
    if type(t) ~= "table" then
        if not create then return end
        t = {}
        db.wishlist[guid] = t
    end
    return t
end

local function Owned(id)
    if not (C_Item and C_Item.GetItemCount) then return false end
    local ok, n = pcall(C_Item.GetItemCount, id, true)
    return ok and type(n) == "number" and n > 0
end

-- The wishlist entry for an item, or nil.
function PF:GetWish(id)
    local t = WishTable(false)
    local e = t and id and t[id]
    if type(e) == "table" then return e end
end

-- Stars or unstars an item ({ id, name }) dropped by `boss` in `dungeon`; true if it is
-- on the list now. An item the character already has counts as received at once.
function PF:ToggleWish(item, dungeon, boss)
    if not (item and item.id) then return false end
    local t = WishTable(true)
    if not t then return false end
    if t[item.id] then
        t[item.id] = nil
        return false
    end
    local e = { name = item.name, slot = item.slot, dungeon = dungeon, boss = boss, added = time and time() or 0 }
    if Owned(item.id) then e.got = e.added end
    t[item.id] = e
    return true
end

-- The slot text ("Mace, One-Handed") of a dungeon item, from Data.lua, for wishes saved
-- without one.
local slotByID
local function SlotOf(id)
    if not slotByID then
        slotByID = {}
        for _, d in ipairs(PathForeverData and PathForeverData.Dungeons or {}) do
            for _, g in ipairs(d.lootGroups or {}) do
                for _, it in ipairs(g.items or {}) do
                    if it.id and it.slot and not slotByID[it.id] then slotByID[it.id] = it.slot end
                end
            end
        end
    end
    return slotByID[id]
end

-- Every wished item as { id, name, slot, dungeon, boss, got }: still to find first, by
-- dungeon, boss and name; received ones after, newest first.
function PF:WishlistEntries()
    local out = {}
    for id, e in pairs(WishTable(false) or {}) do
        if type(id) == "number" and type(e) == "table" then
            out[#out + 1] = { id = id, name = e.name, slot = e.slot or SlotOf(id), dungeon = e.dungeon, boss = e.boss, got = e.got }
        end
    end
    table.sort(out, function(a, b)
        if (a.got ~= nil) ~= (b.got ~= nil) then return a.got == nil end
        if a.got and b.got and a.got ~= b.got then return a.got > b.got end
        if (a.dungeon or "") ~= (b.dungeon or "") then return (a.dungeon or "") < (b.dungeon or "") end
        if (a.boss or "") ~= (b.boss or "") then return (a.boss or "") < (b.boss or "") end
        return (a.name or "") < (b.name or "")
    end)
    return out
end

-- Empties this character's wishlist.
function PF:ClearWishlist()
    local t = WishTable(false)
    if t then wipe(t) end
end

-- Takes the received items off the list.
function PF:ClearReceivedWishes()
    local t = WishTable(false)
    if not t then return end
    for id, e in pairs(t) do
        if type(e) == "table" and e.got then t[id] = nil end
    end
end

-- Marks the wished items the character now has, and says so once in chat.
function PF:CheckWishlist()
    local t = WishTable(false)
    if not t then return end
    for id, e in pairs(t) do
        if type(e) == "table" and not e.got and Owned(id) then
            e.got = time and time() or 0
            local _, link = C_Item.GetItemInfo(id)
            print("|cff3fc7ebPathForever:|r You got " .. (link or e.name or "an item") .. " from your wishlist"
                .. (e.boss and (", dropped by " .. e.boss) or "") .. ".")
            if PF.Theme and PF.Theme.PlayUISound then PF.Theme.PlayUISound("UI_EPICLOOT_TOAST") end
            if PF.RefreshSidePanel then PF:RefreshSidePanel(id) end
            if PF.Journey and PF.Journey.Refresh then PF.Journey:Refresh() end
            if PF.RequestRefresh then PF:RequestRefresh("wishlist") end
        end
    end
end

-- On entering a dungeon: the wished items that drop there and are still missing.
local function BaseName(n) return (n or ""):lower():gsub("^the ", "") end
function PF:AnnounceWishlistHere()
    if not (IsInInstance and GetInstanceInfo) then return end
    local inside, kind = IsInInstance()
    if not inside or (kind ~= "party" and kind ~= "raid") then return end
    local here = BaseName((GetInstanceInfo()))
    if here == "" then return end
    local mine = {}
    for _, w in ipairs(PF:WishlistEntries()) do
        local d = BaseName(w.dungeon)
        if not w.got and d ~= "" and (d:sub(1, #here) == here or here:sub(1, #d) == d) then mine[#mine + 1] = w end
    end
    if #mine == 0 then return end
    print(string.format("|cff3fc7ebPathForever:|r You have %d %s on your wishlist from this dungeon:", #mine, #mine == 1 and "item" or "items"))
    for _, w in ipairs(mine) do
        local _, link = C_Item.GetItemInfo(w.id)
        print("  " .. (link or w.name or ("Item " .. w.id)) .. (w.boss and ("  -  " .. w.boss) or ""))
    end
end

local checkQueued = false
function PF:QueueWishlistCheck(delay)
    if checkQueued or not WishTable(false) then return end
    checkQueued = true
    C_Timer.After(delay or 1, function()
        checkQueued = false
        PF:CheckWishlist()
    end)
end
end -- do (Wishlist)

-- ---------- Boss kill counts (the Dungeons tab, under each boss's name) ----------
-- Per character, by GUID, counted from when PathForever is installed (the game keeps no
-- history). ENCOUNTER_END reports the client's encounter ID and name; the ID is matched
-- against the boss's `encounterID` in Data.lua, else the name against the boss's title,
-- among the dungeons that share the instance's name (Scarlet Monastery's four wings).
-- NOT VERIFIED ON FOREVER (docs/launch-checklist.md).
do
local function Key(dungeon, group) return dungeon.name .. "|" .. group.title end
local function Norm(n) return (tostring(n or ""):lower():gsub("^the ", ""):gsub("[^%w]", "")) end

local function KillTable(create)
    local guid = UnitGUID and UnitGUID("player")
    local db = PathForeverDB
    if not (db and guid) then return end
    if type(db.kills) ~= "table" then
        if not create then return end
        db.kills = {}
    end
    local t = db.kills[guid]
    if type(t) ~= "table" then
        if not create then return end
        t = {}
        db.kills[guid] = t
    end
    return t
end

-- How many times this character has killed the boss (0 when never or unknown).
function PF:GetBossKills(dungeon, group)
    local t = KillTable(false)
    local n = t and dungeon and group and t[Key(dungeon, group)]
    return type(n) == "number" and n or 0
end

-- "Killed once" / "Killed 4 times", or nil before the first kill.
function PF:BossKillText(dungeon, group)
    local n = PF:GetBossKills(dungeon, group)
    if n <= 0 then return nil end
    return n == 1 and "Killed once" or ("Killed " .. n .. " times")
end

-- The dungeon and boss group an ENCOUNTER_END belongs to, or nil.
function PF:FindEncounterBoss(encounterID, encounterName)
    if not (GetInstanceInfo and PathForeverData and PathForeverData.Dungeons) then return end
    local here = Norm((GetInstanceInfo()))
    if here == "" then return end
    local byName
    local wanted = Norm(encounterName)
    for _, d in ipairs(PathForeverData.Dungeons) do
        local dn = Norm(d.name)
        if d.lootGroups and (dn:sub(1, #here) == here or here:sub(1, #dn) == dn) then
            for _, g in ipairs(d.lootGroups) do
                if g.kind == "boss" and not g.faction then
                    if encounterID and g.encounterID == encounterID then return d, g end
                    if not byName and wanted ~= "" and Norm(g.title) == wanted then byName = { d, g } end
                end
            end
        end
    end
    if byName then return byName[1], byName[2] end
end

-- ENCOUNTER_END(encounterID, encounterName, difficultyID, groupSize, success): a kill counts
-- only when success is 1. Returns the dungeon and boss counted, if any.
function PF:RecordBossKill(encounterID, encounterName, success)
    if success ~= 1 and success ~= true then return end
    local d, g = PF:FindEncounterBoss(tonumber(encounterID), encounterName)
    if not d then return end
    local t = KillTable(true)
    if not t then return end
    local key = Key(d, g)
    t[key] = (type(t[key]) == "number" and t[key] or 0) + 1
    if PF.RequestRefresh then PF:RequestRefresh("kills") end
    return d, g
end
end -- do (Kills)

-- ---------- Events ----------
-- No notification queue or badges here - this addon only speaks up via a
-- couple of chat lines on level-up, the minimap button (Minimap.lua,
-- plain open/close, no alerts of its own), and keeping the open window
-- current. Nothing pings or interrupts you.
-- Skills waiting at the trainer, mentioned in cities and inns (Journey.lua decides what to say).
function PF:MaybeTrainerReminder()
    if PathForeverDB and PathForeverDB.options and PathForeverDB.options.trainerReminders == false then return end
    if not (IsResting and IsResting()) then return end
    local line = PF.Journey and PF.Journey.TrainerReminder and PF.Journey:TrainerReminder()
    if line then print("|cff3fc7ebPathForever:|r " .. line) end
end

PF.frame:RegisterEvent("ADDON_LOADED")
PF.frame:RegisterEvent("PLAYER_LOGIN")
PF.frame:RegisterEvent("PLAYER_LOGOUT")
PF.frame:RegisterEvent("PLAYER_LEVEL_UP")
PF.frame:RegisterEvent("SKILL_LINES_CHANGED")
PF.frame:RegisterEvent("QUEST_TURNED_IN")
PF.frame:RegisterEvent("QUEST_ACCEPTED")
PF.frame:RegisterEvent("QUEST_REMOVED")
PF.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
PF.frame:RegisterEvent("BAG_UPDATE_DELAYED")
PF.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
PF.frame:RegisterEvent("PLAYER_UPDATE_RESTING")
PF.frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
pcall(PF.frame.RegisterEvent, PF.frame, "ENCOUNTER_END") -- boss kill counts
PF.frame:RegisterEvent("ADDON_ACTION_BLOCKED")
PF.frame:RegisterEvent("ADDON_ACTION_FORBIDDEN")

PF.frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "PathForever" then
            InitDB()
        end

    elseif event == "PLAYER_LOGIN" then
        PF:SaveCurrentCharacterProfessions()
        -- bag and item data arrive late after a login: look again a few seconds on
        PF:QueueWishlistCheck(5)
        if not PathForeverDB.hasSeenWelcome then
            PathForeverDB.hasSeenWelcome = true
            if PF.ShowWelcome then PF:ShowWelcome() end
        end

    elseif event == "PLAYER_ENTERING_WORLD" then
        -- a moment after the loading screen, so item names and links have arrived
        C_Timer.After(2, function() PF:AnnounceWishlistHere() end)
        C_Timer.After(5, function() PF:MaybeTrainerReminder() end)

    elseif event == "ENCOUNTER_END" then
        local encounterID, encounterName, _, _, success = ...
        PF:RecordBossKill(encounterID, encounterName, success)

    elseif event == "PLAYER_UPDATE_RESTING" then
        C_Timer.After(1.5, function() PF:MaybeTrainerReminder() end)

    elseif event == "BAG_UPDATE_DELAYED" or event == "PLAYER_EQUIPMENT_CHANGED" then
        PF:QueueWishlistCheck(1)

    elseif event == "PLAYER_LOGOUT" then
        PF:SaveCurrentCharacterProfessions()

    elseif event == "PLAYER_LEVEL_UP" then
        local newLevel = ...

        -- The level-up message: how the last level went, skills at the trainer,
        -- dungeons that opened up, and one line for every profession (Journey.lua).
        -- The level's stats are closed either way; the option only silences chat.
        local lines = PF.Journey and PF.Journey.OnLevelUp and PF.Journey:OnLevelUp(newLevel)
        if lines and not (PathForeverDB.options and PathForeverDB.options.levelUpMessages == false) then
            for i, line in ipairs(lines) do
                print((i == 1 and "|cff3fc7ebPathForever:|r " or "  ") .. line)
            end
        end

        PF:ScheduleSave()
        if PF.RefreshUI then PF:RefreshUI() end -- a level change affects every tab

    elseif event == "SKILL_LINES_CHANGED" then
        -- Skill-ups (weapon skills too) can fire this constantly. It can only
        -- change the profession data, so save once per burst and redraw only
        -- if the Professions tab is what's showing.
        PF:ScheduleSave()
        if PF.RequestRefresh then PF:RequestRefresh("professions") end

    elseif event == "QUEST_TURNED_IN" or event == "QUEST_ACCEPTED" or event == "QUEST_REMOVED" then
        -- Only the dungeon list/detail (red/green state, quest counts, and
        -- "In progress" / "New Quests Available!") care. QUEST_REMOVED also
        -- covers abandoning a quest.
        if PF.RequestRefresh then PF:RequestRefresh("quests") end

    elseif event == "GET_ITEM_INFO_RECEIVED" then
        -- An item's data (name, quality, icon...) finished loading after
        -- we asked for it - recolor/refresh the open panel if it's still
        -- showing something that needed it.
        local itemID = ...
        if PF.RefreshSidePanel then PF:RefreshSidePanel(itemID) end
        if PF.RequestRefresh then PF:RequestRefresh("wishlist"); PF:RequestRefresh("upgrades"); PF:RequestRefresh("bank") end -- the Wishlist tab colors names by rarity; the Upgrades tab reads item levels

    elseif event == "ADDON_ACTION_BLOCKED" or event == "ADDON_ACTION_FORBIDDEN" then
        -- Blizzard tells every addon when ANY addon trips a protected
        -- action. Only record ours, with the exact function named, so a
        -- future report can say precisely what happened (/pf taint).
        local addonName, funcName = ...
        if addonName == "PathForever" and PathForeverDB then
            PathForeverDB.taintLog = PathForeverDB.taintLog or {}
            local key = event .. ": " .. tostring(funcName)
            PathForeverDB.taintLog[key] = (PathForeverDB.taintLog[key] or 0) + 1
        end
    end
end)

-- ---------- Memory report (/pf memory) ----------
-- Reports this addon's memory before and after a garbage collection. Lua memory
-- includes garbage that hasn't been collected yet, so the two numbers show
-- whether a high reading is real usage or just waiting to be cleaned up.
function PF:PrintMemoryReport()
    local tag = "|cff3fc7ebPathForever|r "
    local update = UpdateAddOnMemoryUsage or (C_AddOns and C_AddOns.UpdateAddOnMemoryUsage)
    local get = (C_AddOns and C_AddOns.GetAddOnMemoryUsage) or GetAddOnMemoryUsage
    local perAddon = update ~= nil and get ~= nil

    local function read()
        if perAddon then
            local ok = pcall(update)
            local value = ok and get("PathForever")
            if type(value) == "number" then return value end
        end
        return collectgarbage("count") -- whole-game Lua memory, as a fallback
    end

    local before = read()
    collectgarbage("collect")
    local after = read()
    local scope = perAddon and "this addon" or "the WHOLE GAME (a per-addon reading isn't available here)"
    print(string.format("%smemory for %s: %.0f KB now, %.0f KB after cleanup (%.0f KB was uncollected garbage)",
        tag, scope, before, after, math.max(before - after, 0)))

    local s = PF.stats
    print(string.format("%sredraws: %d done, %d skipped (window closed or another tab showing)  |  saves: %d written, %d skipped (nothing changed)",
        tag, s.refreshes, s.skipped, s.saves, s.savesSkipped))
    if PF.GetUICounts then
        local rows, itemRows = PF:GetUICounts()
        print(string.format("%swindow pieces kept for reuse: %d rows, %d panel item rows", tag, rows, itemRows))
    end
end

-- ---------- Slash commands ----------
SLASH_PATHFOREVER1 = "/pathforever"
SLASH_PATHFOREVER2 = "/pf"
SlashCmdList["PATHFOREVER"] = function(msg)
    local cmd, arg = (msg or ""):lower():match("^%s*(%S*)%s*(%S*)")
    if cmd == "version" or cmd == "v" then
        -- Paste this into bug reports.
        local gameVersion, build = GetBuildInfo()
        print(string.format("|cff3fc7ebPathForever|r v%s  |  saved-data schema %s  |  game %s (build %s)",
            tostring(PF.version), tostring(PathForeverDB and PathForeverDB.dbVersion or "?"),
            tostring(gameVersion), tostring(build)))
        return
    elseif cmd == "memory" or cmd == "mem" then
        PF:PrintMemoryReport()
        return
    elseif cmd == "layout" then
        if PF.PrintLayoutReport then
            PF:PrintLayoutReport(arg == "all")
        else
            print("|cff3fc7ebPathForever|r the window hasn't been opened yet - open it with /pf first.")
        end
        return
    elseif cmd == "art" then
        if PF.PrintArtReport then PF:PrintArtReport() end
        return
    elseif cmd == "fishing" or cmd == "fish" then
        if PF.Fishing then
            if arg == "debug" then PF.Fishing:ToggleDebug() else PF.Fishing:Toggle() end
        end
        return
    elseif cmd == "campfire" or cmd == "fire" or cmd == "camp" or cmd == "camping" then
        if PF.Camping then
            if arg == "debug" then PF.Camping:Debug() else PF.Camping:Toggle() end
        end
        return
    elseif cmd == "tracker" then
        if PF.Tracker then PF.Tracker:Toggle() end
        return
    elseif cmd == "spotter" then
        if PF.Spotter then PF.Spotter:Toggle() end
        return
    elseif cmd == "runs" or cmd == "history" then
        if arg == "debug" then PF.History:Debug() else PF:OpenTab("History") end
        return
    elseif cmd == "chars" then
        -- Everything saved for alt tracking, including anything malformed.
        local chars = PathForeverDB and PathForeverDB.characters
        if type(chars) ~= "table" or next(chars) == nil then
            print("|cff3fc7ebPathForever|r no characters saved yet.")
            return
        end
        local keys = {}
        for key in pairs(chars) do keys[#keys + 1] = tostring(key) end
        table.sort(keys)
        print(string.format("|cff3fc7ebPathForever|r saved characters (%d):", #keys))
        local currentGUID = UnitGUID("player")
        for _, key in ipairs(keys) do
            local data = chars[key]
            local here = (key == currentGUID) and "  <- this character" or ""
            if PF:IsCharacterHidden(key) then here = here .. "  (hidden)" end
            if type(data) ~= "table" or type(data.name) ~= "string" then
                print("  " .. key .. "  MALFORMED (no name)" .. here)
            else
                local count = type(data.professions) == "table" and (#data.professions .. " professions")
                    or "NO PROFESSIONS LIST"
                print(string.format("  %s - %s - level %s - %s  [%s]%s", data.name,
                    tostring(data.className or data.class or "class not saved yet"),
                    tostring(data.level or "?"), count, key, here))
            end
        end
        return
    elseif cmd == "atlas" then
        if PF.PrintAtlasSearch then PF:PrintAtlasSearch((msg or ""):match("^%s*%S+%s*(.-)%s*$")) end
        return
    elseif cmd == "flights" then
        if PF.FlightMap and PF.FlightMap.Report then PF.FlightMap:Report() end
        return
    elseif cmd == "tour" then
        if PF.Tour then PF.Tour:Start() end
        return
    elseif cmd == "help" or cmd == "?" then
        print("|cff3fc7ebPathForever|r commands:")
        print("  /pf              open or close the window")
        print("  /pf tour         a short tour of the window")
        print("  /pf fishing      open or close PathForever Fishing")
        print("  /pf fishing debug  show what PathForever Fishing sees in each loot window")
        print("  /pf campfire     open or close PathForever Camping (also /pf camp)")
        print("  /pf campfire debug   show the camp buffs PathForever Camping sees on you")
        print("  /pf tracker      show or hide the leveling tracker (XP per hour and more)")
        print("  /pf runs         open the dungeon history (also /pf history)")
        print("  /pf version      show version info (include this in bug reports)")
        print("  /pf chars        list the characters saved for alt tracking")
        print("  /pf art          preview every dungeon's art, and list where each image comes from")
        print("  /pf atlas <words>  list the client's icon names that contain the words (to find an icon)")
        print("  /pf memory       show the addon's memory use (before and after cleanup)")
        print("  /pf layout       show how the window's text is being sized (for text cut-off reports)")
        print("  /pf flights      show what the client reports for the flight points of the map in front of you")
        print("  /pf taint        list blocked-action events attributed to PathForever")
        print("  /pf taint clear  reset that list")
        return
    end
    if cmd == "taint" then
        -- Diagnostic: lists any blocked-action events Blizzard attributed
        -- to PathForever, with counts. "/pf taint clear" resets it.
        local log = PathForeverDB and PathForeverDB.taintLog
        if arg == "clear" then
            if PathForeverDB then PathForeverDB.taintLog = nil end
            print("|cff3fc7ebPathForever:|r blocked-action log cleared.")
            return
        end
        if not log or next(log) == nil then
            print("|cff3fc7ebPathForever:|r no blocked actions recorded.")
            return
        end
        print("|cff3fc7ebPathForever:|r blocked actions recorded:")
        for key, count in pairs(log) do
            print("  " .. key .. "  x" .. count)
        end
        return
    end
    if PF.ToggleUI then
        PF:ToggleUI()
    end
end
