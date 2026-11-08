-- Fishing.lua - PathForever Fishing
-- A small companion window for fishing. It opens when a fishing pole goes into
-- the main hand (unless turned off in Options) and closes when it comes out.
-- /pf fishing opens and closes it by hand. It shows:
--   * your Fishing skill,
--   * how long this fishing session has run,
--   * your 5 latest catches in this zone, each with its all-time count here and
--     this session's; "Show all catches" opens a side panel with the zone's whole log.
--
-- Catches are saved per zone in PathForeverDB.fishing.zones[<map ID>], with each
-- item's name, icon and quality recorded when it's caught, so the list never
-- waits for item data to load. `last` is a running catch number (fishing.serial),
-- so "latest" survives reloads; entries saved before it existed count as oldest.
--
-- A session starts when you equip a pole, or with your first catch (the retail
-- client lets you fish without one). Swapping to a weapon for a fight doesn't
-- end it: it ends once the pole has been off for SESSION_GRACE seconds.
--
-- Nothing here is protected or secure. Showing and hiding our own frame, and
-- reading loot and equipment, are allowed at any time, in combat too.
-- Text follows the rules in UI.lua's "How text is laid out": TOPLEFT anchors,
-- an explicit width, and never an explicit height.

local PF = PathForever
local Fishing = {}
PF.Fishing = Fishing

local Theme = PF.Theme
local WIDTH = 300
local PAD = 14
local TEXT_W = WIDTH - 2 * PAD
local ICON_SIZE = 16
local COUNT_W = 44         -- the all-time count, right-aligned in its own column
local RECENT_COUNT = 5     -- the window lists this many latest catches; the rest are in the side panel
local POPOUT_W = 300       -- the "all catches" side panel
local POPOUT_MAX_LIST_H = 360 -- taller than this and the panel's list scrolls
local SCROLLBAR_W = 24     -- room the scroll bar takes, right of a list, when it's needed
local ROW_GAP = 5
local SESSION_GRACE = 300  -- seconds the pole can be off before the session ends
local MAIN_HAND = INVSLOT_MAINHAND or 16
local POLE_CLASS = (Enum and Enum.ItemClass and Enum.ItemClass.Weapon) or 2
local POLE_SUBCLASS = (Enum and Enum.ItemWeaponSubclass and Enum.ItemWeaponSubclass.Fishingpole) or 20

local window
local rows = {}          -- pooled catch rows (the window)
local list = {}          -- item IDs to show, reused every redraw
local popout             -- the side panel: all catches, history, or options
local popoutRows, popoutList = {}, {}
local interfaceHidden = false -- see "Hide the interface while fishing"
local HISTORY_MAX = 100   -- catches kept for the History panel
local WEIGHT_W = 56       -- the History panel's weight column
local holdingPole = false
local session = { start = nil, poleOffAt = nil, catches = {} } -- catches[zoneKey][itemID] = count

-- ---------- Data ----------
local function FishingDB()
    local db = PathForeverDB and PathForeverDB.fishing
    if type(db) ~= "table" then return nil end
    if type(db.zones) ~= "table" then db.zones = {} end
    return db
end

local function OptionOn()
    return not (PathForeverDB and PathForeverDB.options and PathForeverDB.options.fishingWindow == false)
end

-- The zone you're in: its key in the saved data (the map ID) and its name.
local function CurrentZone()
    local mapID, name
    if C_Map and C_Map.GetBestMapForUnit then
        local ok, id = pcall(C_Map.GetBestMapForUnit, "player")
        if ok then mapID = id end
    end
    if mapID and C_Map.GetMapInfo then
        local ok, info = pcall(C_Map.GetMapInfo, mapID)
        if ok and type(info) == "table" then name = info.name end
    end
    if not name and GetRealZoneText then name = GetRealZoneText() end
    return mapID or name, name or "this zone"
end

local function IsFishingPole(itemID)
    if not itemID then return false end
    local getInfo = (C_Item and C_Item.GetItemInfoInstant) or GetItemInfoInstant
    if not getInfo then return false end
    local ok, _, _, _, _, _, classID, subclassID = pcall(getInfo, itemID)
    return ok and classID == POLE_CLASS and subclassID == POLE_SUBCLASS
end

-- Current Fishing skill, its maximum and any bonus (a lure, a pole), or nil if
-- Fishing isn't learned.
local function FishingSkill()
    if not (GetProfessions and GetProfessionInfo) then return nil end
    local _, _, _, fishing = GetProfessions()
    if not fishing then return nil end
    local _, _, level, maxLevel, _, _, _, bonus = GetProfessionInfo(fishing)
    return level, maxLevel, bonus
end

local function StartSession()
    session.start = GetTime()
    session.poleOffAt = nil
    wipe(session.catches)
end

-- `weight` (pounds) is given for a fish, nil for junk; it's decided once per
-- catch, so the pop-up, History and "Largest caught" all agree.
local function RecordCatch(itemID, name, icon, quality, count, weight)
    local key, zoneName = CurrentZone()
    if not key then return end
    local db = FishingDB()
    if db then
        local zone = db.zones[key]
        if type(zone) ~= "table" then
            zone = { fish = {} }
            db.zones[key] = zone
        end
        if type(zone.fish) ~= "table" then zone.fish = {} end
        zone.name = zoneName
        local fish = zone.fish[itemID]
        if type(fish) ~= "table" then
            fish = { count = 0 }
            zone.fish[itemID] = fish
        end
        fish.name = name or fish.name
        fish.icon = icon or fish.icon
        fish.quality = quality or fish.quality
        fish.count = (tonumber(fish.count) or 0) + count
        db.serial = (tonumber(db.serial) or 0) + 1
        fish.last = db.serial

        -- History: newest first, the last HISTORY_MAX catches, any zone.
        if type(db.history) ~= "table" then db.history = {} end
        table.insert(db.history, 1, { id = itemID, name = name, icon = icon, quality = quality,
            zone = zoneName, weight = weight })
        while #db.history > HISTORY_MAX do table.remove(db.history) end
        -- "Largest caught", per item, in every zone
        if weight then
            if type(db.largest) ~= "table" then db.largest = {} end
            if weight > (tonumber(db.largest[itemID]) or 0) then db.largest[itemID] = weight end
        end
    end
    local here = session.catches[key]
    if not here then
        here = {}
        session.catches[key] = here
    end
    here[itemID] = (here[itemID] or 0) + count
end

-- ---------- Window ----------
local function FormatDuration(seconds)
    seconds = math.max(0, math.floor(seconds))
    local h, m, s = math.floor(seconds / 3600), math.floor(seconds / 60) % 60, seconds % 60
    if h > 0 then return string.format("%d:%02d:%02d", h, m, s) end
    return string.format("%d:%02d", m, s)
end

-- How long the session has run, in seconds, or nil before one starts. (The
-- window no longer shows a session timer; the session still sets what counts
-- as "this session".)
function Fishing:SessionAge()
    return session.start and (GetTime() - session.start) or nil
end

-- The lure on the pole: its time left, colored by how much of it is left
-- (green, then orange from 25%, red from 5%), or "No bait" in red. Only while
-- holding a pole: the main hand's enchant is the lure then. A lure's full time
-- is learned when it goes on (the time left jumps up), rounded up to whole
-- 5 minutes, so it's right after a reload too (lures last 5 or 10 minutes).
local lureTimer = { total = nil, lastLeft = nil }
local LURE_GOOD, LURE_LOW, LURE_OUT = "66d973", "ff8c26", "e6524d"

local function LureText()
    if not holdingPole or not GetWeaponEnchantInfo then return nil end
    local ok, hasLure, msLeft = pcall(GetWeaponEnchantInfo)
    if not ok or not hasLure or not tonumber(msLeft) or msLeft <= 0 then
        lureTimer.total, lureTimer.lastLeft = nil, nil
        return "|cff" .. LURE_OUT .. "No bait|r"
    end
    local left = msLeft / 1000
    if not lureTimer.total or left > (lureTimer.lastLeft or 0) + 5 then -- a lure just went on
        lureTimer.total = math.max(math.ceil(left / 300) * 300, left)
    end
    lureTimer.lastLeft = left
    local share = left / lureTimer.total
    local color = (share <= 0.05 and LURE_OUT) or (share <= 0.25 and LURE_LOW) or LURE_GOOD
    return string.format("|cff%s%s left|r", color, FormatDuration(left))
end

local function SkillText()
    local level, maxLevel, bonus = FishingSkill()
    if not level then return "Fishing not learned yet" end
    local text = string.format("Fishing skill %d / %d", level, maxLevel or 0)
    local bonusText = (bonus and bonus > 0) and string.format("+%d", bonus) or nil
    local lure = LureText()
    if bonusText and lure then
        text = text .. " (" .. bonusText .. ", " .. lure .. ")"
    elseif bonusText or lure then
        text = text .. " (" .. (bonusText or lure) .. ")"
    end
    return text
end

-- Places one text at (x, y) from `parent`'s top-left, `w` wide, and returns
-- the y below it.
local function PlaceText(fs, parent, x, y, w, text)
    fs:ClearAllPoints()
    fs:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
    fs:SetWidth(w)
    fs:SetText(text)
    fs:Show()
    return y + (fs:GetStringHeight() or 12)
end

-- PathForever Fishing's own tooltip. GameTooltip belongs to UIParent, so it
-- vanished with the interface hidden; this one follows the interface to
-- WorldFrame and back. It's an ordinary GameTooltip otherwise ("Largest caught"
-- is added to it like to any other).
local tooltip
local function Tooltip()
    if not tooltip then
        tooltip = CreateFrame("GameTooltip", "PathForeverFishingTooltip", UIParent, "GameTooltipTemplate")
    end
    local home = interfaceHidden and WorldFrame or UIParent
    if tooltip:GetParent() ~= home then
        tooltip:SetParent(home)
        tooltip:SetScale(interfaceHidden and UIParent:GetScale() or 1)
    end
    tooltip:SetFrameStrata("TOOLTIP")
    return tooltip
end
Fishing.Tooltip = Tooltip -- (for the tests)

local function RowEnter(self)
    if not self.itemID then return end
    local tip = Tooltip()
    tip:SetOwner(self, "ANCHOR_RIGHT")
    if not pcall(tip.SetItemByID, tip, self.itemID) then
        tip:SetText(self.name:GetText() or "", 1, 1, 1)
    end
    tip:Show()
end
local function RowLeave() Tooltip():Hide() end

-- Catch rows are pooled per list (`pool`), and created once each.
local function AcquireRow(pool, parent, n)
    local row = pool[n]
    if row then return row end
    row = CreateFrame("Frame", nil, parent)
    row:EnableMouse(true)
    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(ICON_SIZE, ICON_SIZE)
    row.icon:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -1)
    row.name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    row.name:SetJustifyH("LEFT")
    row.count = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    row.count:SetJustifyH("RIGHT")
    row.sub = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    row.sub:SetJustifyH("LEFT")
    row:SetScript("OnEnter", RowEnter)
    row:SetScript("OnLeave", RowLeave)
    pool[n] = row
    return row
end

-- One catch: icon, name in its quality's color, `right` in a column on the
-- right (`rightW` wide), and `sub` underneath when there is one. `y` is from the
-- top of `parent`, `w` the row width.
local function LayoutRow(row, parent, y, w, itemID, entry, right, rightW, sub)
    row.itemID = itemID
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -y)
    row:SetWidth(w)
    row.icon:SetTexture(entry.icon or 134400) -- the question-mark icon when none was recorded
    local left = ICON_SIZE + 6
    local nameW = w - left - rightW - 6
    row.name:ClearAllPoints()
    row.name:SetPoint("TOPLEFT", row, "TOPLEFT", left, -1)
    row.name:SetWidth(nameW)
    row.name:SetText(entry.name or ("Item " .. itemID))
    local color = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[tonumber(entry.quality) or 1]
    if color then row.name:SetTextColor(color.r, color.g, color.b) else row.name:SetTextColor(1, 1, 1) end
    row.count:ClearAllPoints()
    row.count:SetPoint("TOPLEFT", row, "TOPLEFT", w - rightW, -1)
    row.count:SetWidth(rightW)
    row.count:SetText(right or "")
    local h = 1 + (row.name:GetStringHeight() or 12)
    if sub then
        row.sub:ClearAllPoints()
        row.sub:SetPoint("TOPLEFT", row, "TOPLEFT", left, -(h + 1))
        row.sub:SetWidth(nameW)
        row.sub:SetText(sub)
        row.sub:Show()
        h = h + 1 + (row.sub:GetStringHeight() or 10)
    else
        row.sub:Hide()
        row.sub:SetText("")
    end
    h = math.max(h, ICON_SIZE + 2)
    row:SetHeight(h)
    row:Show()
    return h
end

local function HideRowsFrom(pool, first)
    for n = first, #pool do
        pool[n]:Hide()
        pool[n].itemID = nil
    end
end

-- Lays out the first `count` of `ids` in `parent` (the all-time count on the
-- right, this session's underneath), hides the pool's other rows, and returns
-- the list's height.
local function LayoutList(pool, parent, ids, fishTable, sessionHere, w, count)
    local y = 0
    for n = 1, count do
        local itemID = ids[n]
        local fish = fishTable[itemID]
        local here = sessionHere and sessionHere[itemID]
        y = y + LayoutRow(AcquireRow(pool, parent, n), parent, y, w, itemID, fish,
            tostring(tonumber(fish.count) or 0), COUNT_W, (here and here > 0) and (here .. " this session") or nil)
        if n < count then y = y + ROW_GAP end
    end
    HideRowsFrom(pool, count + 1)
    return y
end

-- The History list: newest first, the zone underneath, a fish's weight on the right.
local function LayoutHistory(pool, parent, history, w)
    local y, n = 0, 0
    for _, entry in ipairs(history) do
        if type(entry) == "table" and tonumber(entry.id) then
            n = n + 1
            if n > 1 then y = y + ROW_GAP end
            local weight = tonumber(entry.weight)
            y = y + LayoutRow(AcquireRow(pool, parent, n), parent, y, w, entry.id, entry,
                weight and string.format("%.1f lb", weight) or "", WEIGHT_W,
                type(entry.zone) == "string" and entry.zone or nil)
        end
    end
    HideRowsFrom(pool, n + 1)
    return y
end

-- Orders for the lists. `sortFish` is set just before sorting, so the
-- comparisons don't need a new closure on every redraw.
local sortFish
local function ByCount(a, b) -- most caught first, then by name (the side panel)
    local fa, fb = sortFish[a], sortFish[b]
    local ca, cb = tonumber(fa.count) or 0, tonumber(fb.count) or 0
    if ca ~= cb then return ca > cb end
    return tostring(fa.name) < tostring(fb.name)
end
local function ByLatest(a, b) -- latest catch first (the window)
    local la, lb = tonumber(sortFish[a].last) or 0, tonumber(sortFish[b].last) or 0
    if la ~= lb then return la > lb end
    return ByCount(a, b)
end

-- The zone's saved catches, or nil.
local function ZoneFish(key)
    local db = FishingDB()
    local zone = db and key and db.zones[key]
    return type(zone) == "table" and type(zone.fish) == "table" and zone.fish or nil
end

-- Fills `out` with the item IDs of `fishTable`'s well-formed entries, sorted.
local function SortedCatches(out, fishTable, order)
    wipe(out)
    if not fishTable then return out end
    for itemID, fish in pairs(fishTable) do
        if type(fish) == "table" and tonumber(fish.count) then out[#out + 1] = itemID end
    end
    sortFish = fishTable
    table.sort(out, order)
    sortFish = nil
    return out
end

local function ScrollBarOf(scroll)
    local bar = scroll.ScrollBar or _G[scroll:GetName() .. "ScrollBar"]
    return type(bar) == "table" and bar or nil
end

local function CloseButton(parent, onClick)
    local close = CreateFrame("Button", nil, parent)
    close:SetSize(22, 22)
    close:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -8, -7)
    local closeText = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    closeText:SetPoint("CENTER")
    closeText:SetText("\195\151")
    closeText:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    close:SetScript("OnClick", onClick)
    close:SetScript("OnEnter", function() closeText:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    close:SetScript("OnLeave", function() closeText:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3]) end)
    return close
end

local function StylePanel(f)
    Theme.StyleWindow(f)
end

-- ---------- Options (the fishing window's own) ----------
-- Saved in PathForeverDB.fishing.options; a missing key means its default.
local OPTION_DEFAULTS = { doubleClick = false, hideUI = false, tackleBox = true, popups = true, announce = false }
local FISH_OPTIONS = {
    { key = "doubleClick", title = "Double-click to cast",
      sub = "With a fishing pole equipped, double right-click the ground to cast" },
    { key = "hideUI", title = "Hide the interface while fishing",
      sub = "Casting hides everything but this window. It comes back when you put the pole away or enter combat" },
    { key = "tackleBox", title = "Tackle box",
      sub = "Your lures under your catches. Click one to put it on your pole" },
    { key = "popups", title = "Catch pop-ups",
      sub = "What you catch floats up from your cursor, with each fish's weight" },
}

local function FishOption(key)
    local db = FishingDB()
    local value
    if db and type(db.options) == "table" then value = db.options[key] end
    if value == nil then return OPTION_DEFAULTS[key] end -- never saved: the default
    return value and true or false
end

local function SetFishOption(key, value)
    local db = FishingDB()
    if not db then return end
    if type(db.options) ~= "table" then db.options = {} end
    db.options[key] = value and true or false
end

-- The Fishing spell's name in the client's language (the profession's name).
local function FishingSpellName()
    if GetProfessions and GetProfessionInfo then
        local _, _, _, fishing = GetProfessions()
        local name = fishing and GetProfessionInfo(fishing)
        if name then return name end
    end
    return "Fishing"
end

-- ---------- Tackle box: the lures in your bags ----------
-- A lure is anything whose tooltip has a "Use:" line about Fishing (Shiny
-- Bauble: "Use: When applied to your fishing pole, increases Fishing by 25 for
-- 10 min."), so no item IDs are hard-coded. Its strength is the first number on
-- that line. The best TACKLE_SLOTS kinds show, strongest first.
local TACKLE_SLOTS = 5
local TACKLE_SIZE = 32
local TACKLE_GAP = 8
local lureCache = {}  -- itemID -> strength, or false for "not a lure" (items don't change)
local lures = {}      -- the lures to show: { itemID, icon, bag, slot, strength }

-- Remembering "not a lure" too early emptied the tackle box twice (2026-09-30):
-- right after a login an item's tooltip can be just its name, and even once the
-- item has loaded, its "Use:" line (the lure's spell text) can still be missing.
-- So a lure is remembered as soon as it's recognised, but "not a lure" only when
-- a "Use:" line has been read that isn't about fishing (a potion, say): that
-- text has clearly loaded. Anything else is read again on the next scan, which
-- only happens when the bags change. Items that haven't loaded are also asked
-- for, and the bags are read again when they arrive (GET_ITEM_INFO_RECEIVED).
local pendingItems = {}  -- item IDs asked for, not loaded yet
local unreadItems = {}   -- this scan's items with no "Use:" line read (for /pf fishing debug)

-- true/false when the client can say whether an item's data has loaded, nil if it can't.
local function ItemDataLoaded(itemID)
    if C_Item and C_Item.IsItemDataCachedByID then
        local ok, loaded = pcall(C_Item.IsItemDataCachedByID, itemID)
        if ok then return loaded and true or false end
    end
    return nil
end

local function LureStrength(bag, slot, itemID)
    local cached = lureCache[itemID]
    if cached ~= nil then return cached end
    local strength, sawUseLine = false, false
    if C_TooltipInfo and C_TooltipInfo.GetBagItem then
        local ok, data = pcall(C_TooltipInfo.GetBagItem, bag, slot)
        if ok and type(data) == "table" and type(data.lines) == "table" then
            for _, line in ipairs(data.lines) do
                local text = type(line) == "table" and line.leftText
                if type(text) == "string" and text:find("^Use:") then
                    sawUseLine = true
                    if text:lower():find("fishing", 1, true) then
                        strength = tonumber(text:match("(%d+)")) or 1
                        break
                    end
                end
            end
        end
    end
    if strength or sawUseLine then
        lureCache[itemID] = strength -- a lure, or clearly not one
        pendingItems[itemID] = nil
    else
        unreadItems[#unreadItems + 1] = itemID
        if ItemDataLoaded(itemID) == false and not pendingItems[itemID] then -- ask for it once
            pendingItems[itemID] = true
            if C_Item and C_Item.RequestLoadItemDataByID then pcall(C_Item.RequestLoadItemDataByID, itemID) end
        end
    end
    return strength
end


local function ByStrength(a, b)
    if a.strength ~= b.strength then return a.strength > b.strength end
    return a.itemID < b.itemID
end

-- Rebuilds `lures` from the bags (on opening and when the bags change).
local function ScanLures()
    wipe(lures)
    wipe(unreadItems)
    if not (C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerItemInfo) then return end
    local seen = {} -- itemID -> its entry in `lures`, or false for "not a lure"
    for bag = 0, NUM_BAG_SLOTS or 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) or 0 do
            local ok, info = pcall(C_Container.GetContainerItemInfo, bag, slot)
            local itemID = ok and type(info) == "table" and info.itemID
            if itemID then
                local stack = math.max(tonumber(info.stackCount) or 1, 1)
                local entry = seen[itemID]
                if entry == nil then
                    local strength = LureStrength(bag, slot, itemID)
                    if strength then
                        entry = { itemID = itemID, icon = info.iconFileID, bag = bag, slot = slot, strength = strength, count = 0 }
                        lures[#lures + 1] = entry
                    else
                        entry = false
                    end
                    seen[itemID] = entry
                end
                if entry then entry.count = entry.count + stack end -- every stack, in every bag
            end
        end
    end
    table.sort(lures, ByStrength)
end

-- An item we were waiting for has loaded: read the bags again, once per burst.
local rescanQueued = false
local function RescanLures()
    rescanQueued = false
    ScanLures()
    if Fishing:IsShown() then Fishing:Refresh() end
end

-- After the window opens, items whose tooltips couldn't be read yet are tried
-- again a few times, so a lure that's still loading shows up without waiting
-- for the bags to change. (Most bags always hold some items with no "Use:"
-- line, like fish, hence the limit.)
local UNREAD_RETRIES, UNREAD_RETRY_DELAY = 5, 2
local unreadRetries = 0
local function RetryUnread()
    if not Fishing:IsShown() or not FishOption("tackleBox") then return end
    RescanLures()
    if #unreadItems > 0 and unreadRetries < UNREAD_RETRIES then
        unreadRetries = unreadRetries + 1
        C_Timer.After(UNREAD_RETRY_DELAY, RetryUnread)
    end
end

-- ---------- Secure buttons: lures and the double-click cast ----------
-- Putting a lure on the pole and casting Fishing are protected: only the
-- player's own click on a secure action button may do them. Those buttons
-- follow the rules the profession buttons taught (see docs/forever-client.md):
--   * they are never part of the fishing window (a frame holding or anchoring
--     a secure frame becomes protected, and the window must still close and
--     move in combat). They live in `secureHolder`, under WorldFrame, so they
--     also stay usable while "Hide the interface" has hidden UIParent;
--   * a state driver hides the holder in combat (the game does it, not us);
--   * they are placed, shown and hidden only out of combat.
-- The lure buttons sit over the tackle box's slots, placed by screen position.
-- The holder is one strata above the window, so the window coming forward when
-- clicked can't cover them. It lives under UIParent, like the rest of the
-- interface, and moves to WorldFrame only while "Hide the interface" has hidden
-- UIParent. (Under WorldFrame all the time, the lure buttons showed but clicks
-- did nothing in game, 2026-09-30.)
local secureHolder
local tackleButtons = {}
local castButton
local debugLoot = false       -- /pf fishing debug

local function EnsureSecureHolder()
    if secureHolder or InCombatLockdown() then return secureHolder end
    secureHolder = CreateFrame("Frame", "PathForeverFishingSecure", UIParent)
    secureHolder:SetFrameStrata("HIGH")
    RegisterStateDriver(secureHolder, "visibility", "[combat] hide; show")
    return secureHolder
end

local function TackleButtonEnter(self)
    local slot = self.slotFrame
    if slot then slot.highlight:Show() end
    if not self.bag then return end
    local tip = Tooltip()
    tip:SetOwner(self, "ANCHOR_RIGHT")
    if not pcall(tip.SetBagItem, tip, self.bag, self.slot) then
        pcall(tip.SetItemByID, tip, self.itemID)
    end
    tip:Show()
end
local function TackleButtonLeave(self)
    if self.slotFrame then self.slotFrame.highlight:Hide() end
    Tooltip():Hide()
end

local function AcquireTackleButton(n)
    local btn = tackleButtons[n]
    if btn then return btn end
    btn = CreateFrame("Button", "PathForeverTackle" .. n, EnsureSecureHolder(), "SecureActionButtonTemplate")
    btn:RegisterForClicks("AnyUp", "AnyDown") -- the client acts on one, per "cast on key down"
    btn:SetAttribute("type", "macro")
    btn:HookScript("OnEnter", TackleButtonEnter)
    btn:HookScript("OnLeave", TackleButtonLeave)
    btn:HookScript("PreClick", function(self, mouseButton, down)
        if debugLoot then
            print(string.format("|cff3fc7ebPathForever Fishing:|r lure clicked (%s, %s): %s",
                tostring(mouseButton), down and "press" or "release", tostring(self:GetAttribute("macrotext")):gsub("\n", " ; ")))
        end
    end)
    tackleButtons[n] = btn
    return btn
end

-- Places a lure button over each filled tackle slot, and hides the rest. Out of
-- combat only; combat ending runs it again.
local function SyncTackleButtons()
    if InCombatLockdown() then return end
    local n = 0
    local showing = window and window:IsShown() and not window.isMoving and window.tackle
        and window.tackle.shown and EnsureSecureHolder()
    if showing then
        local home = interfaceHidden and WorldFrame or UIParent
        if secureHolder:GetParent() ~= home then
            secureHolder:SetParent(home)
            -- Re-parenting can hand a frame its new parent's strata, which put the
            -- lure buttons under the window: they showed but took no hover or
            -- click until a reload (2026-09-30, after "Show UI"). Put it back.
            secureHolder:SetFrameStrata("HIGH")
        end
        local holderScale = secureHolder:GetEffectiveScale()
        for i = 1, TACKLE_SLOTS do
            local slot, lure = window.tackle[i], lures[i]
            local l, t = slot:GetLeft(), slot:GetTop()
            if lure and l and t then
                n = n + 1
                local btn = AcquireTackleButton(n)
                local s = slot:GetEffectiveScale() / holderScale
                btn:ClearAllPoints()
                btn:SetPoint("TOPLEFT", home, "BOTTOMLEFT", l * s, t * s)
                btn:SetSize(TACKLE_SIZE * s, TACKLE_SIZE * s)
                -- use the lure, then the main-hand item (the pole) takes it
                btn:SetAttribute("macrotext", "/use item:" .. lure.itemID .. "\n/use " .. MAIN_HAND)
                btn.itemID, btn.bag, btn.slot, btn.slotFrame = lure.itemID, lure.bag, lure.slot, slot
                btn:Show()
            end
        end
    end
    for i = n + 1, #tackleButtons do
        tackleButtons[i]:Hide()
        tackleButtons[i].slotFrame = nil
    end
end

-- Whether the lure buttons are out of step with their boxes: one missing, or
-- more than a pixel off (the boxes move when the window's height changes).
-- The window's once-a-second tick re-places them if so, which fixes whatever
-- knocked them out of place (they stopped working after a few catches,
-- 2026-09-30).
local function TackleButtonsOutOfPlace()
    if not (window and window.tackle and window.tackle.shown) or window.isMoving then return false end
    for i = 1, TACKLE_SLOTS do
        local slot, btn = window.tackle[i], tackleButtons[i]
        if lures[i] then
            if not (btn and btn:IsShown() and btn.slotFrame == slot) then return true end
            local sl, st = slot:GetLeft(), slot:GetTop()
            local bl, bt = btn:GetLeft(), btn:GetTop()
            if sl and st and bl and bt then
                local ss, bs = slot:GetEffectiveScale(), btn:GetEffectiveScale()
                if math.abs(sl * ss - bl * bs) > 1 or math.abs(st * ss - bt * bs) > 1 then return true end
            end
        elseif btn and btn:IsShown() then
            return true
        end
    end
    return false
end

-- Double-click to cast: a double right-click on open ground (not on a unit)
-- while holding a pole points the right mouse button, for that one release,
-- at `castButton`, which casts Fishing. The binding is cleared right after.
-- This is how fishing addons have long done it; out of combat only, since
-- bindings can't change in combat.
local DOUBLE_CLICK_TIME = 0.4
local lastRightDown

local function ClearCastBinding()
    if castButton and not InCombatLockdown() then ClearOverrideBindings(castButton) end
end

local function EnsureCastButton()
    if castButton or InCombatLockdown() then return castButton end
    castButton = CreateFrame("Button", "PathForeverFishingCast", WorldFrame, "SecureActionButtonTemplate")
    castButton:SetSize(1, 1)
    castButton:SetPoint("BOTTOMLEFT", WorldFrame, "BOTTOMLEFT", 0, 0)
    castButton:EnableMouse(false) -- never clicked by the mouse, only through the binding
    castButton:RegisterForClicks("AnyUp", "AnyDown")
    -- The binding is set during the second press, so only its release reaches
    -- the button: cast on release as well as on press.
    castButton:SetAttribute("type", "spell")
    castButton:SetAttribute("typerelease", "spell")
    castButton:SetScript("PostClick", ClearCastBinding)
    return castButton
end

local function OnWorldMouseDown(_, button)
    if button ~= "RightButton" then return end
    if not (holdingPole and FishOption("doubleClick")) or InCombatLockdown()
        or (UnitExists and UnitExists("mouseover")) or (CursorHasItem and CursorHasItem()) then
        lastRightDown = nil
        return
    end
    local now = GetTime()
    if lastRightDown and now - lastRightDown <= DOUBLE_CLICK_TIME then
        lastRightDown = nil
        local btn = EnsureCastButton()
        if not btn then return end
        btn:SetAttribute("spell", FishingSpellName())
        SetOverrideBindingClick(btn, true, "BUTTON2", btn:GetName())
        C_Timer.After(1, ClearCastBinding) -- in case the release never reached it
    else
        lastRightDown = now
    end
end
if WorldFrame and WorldFrame.HookScript then WorldFrame:HookScript("OnMouseDown", OnWorldMouseDown) end

-- /pf fishing debug: where the lure buttons are, next to their slots.
local function PrintTackleDebug()
    local tag = "|cff3fc7ebPathForever Fishing:|r "
    if not (window and window.tackle and window.tackle.shown) then
        print(tag .. "tackle box: not showing")
        return
    end
    print(tag .. string.format("tackle box: %d lure(s) found; buttons in %s", #lures,
        secureHolder and (secureHolder:GetParent() == WorldFrame and "WorldFrame" or "UIParent") or "nothing yet"))
    if #unreadItems > 0 then
        print(string.format("  %d item(s) with no \"Use:\" line yet, read again when the bags change: %s",
            #unreadItems, table.concat(unreadItems, ", ", 1, math.min(#unreadItems, 12))))
    end
    for i = 1, TACKLE_SLOTS do
        local slot, btn = window.tackle[i], tackleButtons[i]
        if lures[i] then
            local s = slot:GetEffectiveScale()
            local bs = btn and btn:GetEffectiveScale() or 0
            print(string.format("  slot %d: item %d at %s,%s; button %s at %s,%s", i, lures[i].itemID,
                tostring(slot:GetLeft() and math.floor(slot:GetLeft() * s)), tostring(slot:GetTop() and math.floor(slot:GetTop() * s)),
                btn and (btn:IsShown() and "shown" or "hidden") or "missing",
                tostring(btn and btn:GetLeft() and math.floor(btn:GetLeft() * bs)), tostring(btn and btn:GetTop() and math.floor(btn:GetTop() * bs))))
        end
    end
end

-- ---------- Hide the interface while fishing ----------
-- Casting Fishing with a pole hides UIParent (everything but this window, which
-- moves to WorldFrame meanwhile). It comes back when the pole comes off, combat
-- starts (PLAYER_REGEN_DISABLED fires just before combat lockdown, so UIParent
-- can still be shown then), this window closes, the option is turned off, or
-- the player clicks the small "Show UI" button at the top of the screen. The
-- next cast hides it again while the option is on ("Show UI" is always there to
-- bring it back).
local showUIButton

local SHOW_UI_ALPHA = 0.45 -- faded until the mouse is over it

local function CreateShowUIButton()
    -- Under WorldFrame, since UIParent is hidden while it shows. A plain button
    -- (nothing protected), so it can come and go in combat.
    local b = CreateFrame("Button", "PathForeverShowUI", WorldFrame, "BackdropTemplate")
    b:SetSize(72, 20)
    b:SetFrameStrata("HIGH")
    b:SetPoint("TOP", WorldFrame, "TOP", 0, -12)
    StylePanel(b)
    b.text = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    b.text:SetPoint("TOPLEFT", b, "TOPLEFT", 0, -4)
    b.text:SetWidth(72)
    b.text:SetJustifyH("CENTER")
    b.text:SetText("Show UI")
    b:SetAlpha(SHOW_UI_ALPHA)
    b:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
    b:SetScript("OnLeave", function(self) self:SetAlpha(SHOW_UI_ALPHA) end)
    b:SetScript("OnClick", function() Fishing:ShowInterface() end)
    b:Hide()
    return b
end

local function ShowInterface()
    if showUIButton then showUIButton:Hide() end
    if not interfaceHidden then return end
    interfaceHidden = false
    local wasOpen = window and window:IsShown()
    if window then -- home first, so the interface coming back sees it as one of its own
        window:SetParent(UIParent)
        window:SetScale(1)
        window:SetFrameStrata("MEDIUM") -- (re-parenting can change it; see SyncTackleButtons)
    end
    pcall(UIParent.Show, UIParent)
    -- The interface coming back closes the windows Escape would close (as after
    -- Alt+Z), this one included, but the player was fishing in it: reopen it.
    if wasOpen and not window:IsShown() then
        window:Show()
        window:Raise()
        Fishing:Refresh()
    end
    if tooltip then Tooltip():Hide() end -- back under UIParent, for next time
    SyncTackleButtons()
end

local function HideInterface()
    if interfaceHidden or not window or not window:IsShown() or InCombatLockdown()
        or not FishOption("hideUI") or not holdingPole then return end
    interfaceHidden = true
    window:SetParent(WorldFrame) -- stays visible, the same size as before
    window:SetFrameStrata("MEDIUM") -- (re-parenting can change it; see SyncTackleButtons)
    window:SetScale(UIParent:GetScale())
    UIParent:Hide()
    if not showUIButton then showUIButton = CreateShowUIButton() end
    showUIButton:SetScale(UIParent:GetScale()) -- the interface's size, not WorldFrame's
    showUIButton:SetAlpha(SHOW_UI_ALPHA)
    showUIButton:Show()
    SyncTackleButtons()
end

-- (the "Show UI" button's click, and the tests)
function Fishing:ShowInterface() ShowInterface() end

-- ---------- The "all catches" side panel ----------
-- Like the main window's quest/boss panel: the same border, beside its window,
-- and part of it (it moves, layers and closes with it).
local function CreatePopout()
    local p = CreateFrame("Frame", "PathForeverFishingAll", window, "BackdropTemplate")
    p:SetWidth(POPOUT_W)
    StylePanel(p)
    p.close = CloseButton(p, function()
        p:Hide()
        Fishing:Refresh() -- the window's line goes back to "Show all catches"
    end)
    p.title = p:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    p.title:SetJustifyH("LEFT")
    p.title:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
    p.subtitle = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.subtitle:SetJustifyH("LEFT")
    p.subtitle:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])

    p.scroll = CreateFrame("ScrollFrame", "PathForeverFishingAllScroll", p, "UIPanelScrollFrameTemplate")
    if Theme.StyleScrollBar then Theme.StyleScrollBar(p.scroll) end
    p.list = CreateFrame("Frame", nil, p.scroll)
    p.list:SetSize(POPOUT_W - 2 * PAD, 1)
    p.scroll:SetScrollChild(p.list)
    -- The scroll bar shows only when the list is taller than the panel allows.
    -- The template decides for itself whenever the scroll range changes, so our
    -- decision is applied again after it.
    p.scroll:HookScript("OnScrollRangeChanged", function(self)
        local bar = ScrollBarOf(self)
        if bar then bar:SetShown(self.needsBar and true or false) end
    end)

    -- The panel's other mode: the fishing options, as switch rows like the main
    -- window's Options tab, glowing on hover.
    p.optionRows = {}
    for i = 1, #FISH_OPTIONS do
        local row = CreateFrame("Button", nil, p)
        row.glow = Theme.CreateGlow(row, "LEFT", 0.22)
        Theme.CreateSwitch(row)
        row.cbBorder:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, -2)
        row.title = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.title:SetJustifyH("LEFT")
        row.title:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
        row.sub = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.sub:SetJustifyH("LEFT")
        row.key = FISH_OPTIONS[i].key
        row:SetScript("OnClick", function(self)
            local on = not FishOption(self.key)
            SetFishOption(self.key, on)
            Theme.PlayCheckboxSound(on)
            Fishing:OptionToggled(self.key)
        end)
        row:SetScript("OnEnter", function(self) self.glow:Show() end)
        row:SetScript("OnLeave", function(self) self.glow:Hide() end)
        row:Hide()
        p.optionRows[i] = row
    end
    p:Hide()
    return p
end

-- Beside the window, on whichever side has room on screen (the window opens
-- right of center, so the right side can run off the edge).
local function PlacePopout()
    popout:ClearAllPoints()
    local right, room = window:GetRight(), UIParent:GetWidth()
    if right and room and right + 8 + POPOUT_W > room then
        popout:SetPoint("TOPRIGHT", window, "TOPLEFT", -8, 0)
    else
        popout:SetPoint("TOPLEFT", window, "TOPRIGHT", 8, 0)
    end
end

-- The panel in its options mode.
local function RefreshOptionsPanel()
    local w = POPOUT_W - 2 * PAD
    popout.scroll:Hide()
    for _, row in ipairs(popoutRows) do row:Hide() end
    local y = PlaceText(popout.title, popout, PAD, 13, w - 24, "Options") + 2
    y = PlaceText(popout.subtitle, popout, PAD, y, w, "PathForever Fishing") + 12
    for i, row in ipairs(popout.optionRows) do
        local spec = FISH_OPTIONS[i]
        local on = FishOption(spec.key)
        Theme.SetSwitch(row, on)
        -- the switch is on the right, so the text starts at the left and stops short of it
        local textX, textW = 0, w - 30 - 10
        row.title:ClearAllPoints()
        row.title:SetPoint("TOPLEFT", row, "TOPLEFT", textX, -2)
        row.title:SetWidth(textW)
        row.title:SetText(spec.title)
        local h = 2 + (row.title:GetStringHeight() or 12)
        row.sub:ClearAllPoints()
        row.sub:SetPoint("TOPLEFT", row, "TOPLEFT", textX, -(h + 2))
        row.sub:SetWidth(textW)
        row.sub:SetText(spec.sub)
        h = h + 2 + (row.sub:GetStringHeight() or 10) + 6
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", popout, "TOPLEFT", PAD, -y)
        row:SetSize(w, h)
        row:Show()
        y = y + h + 6
    end
    popout:SetHeight(y + PAD - 6)
end

-- The panel's scrolling list, below `y`: `layout(width)` lays it out and returns
-- its height. A new `listKey` (another zone, or History) starts at the top.
local function ShowPanelList(y, listKey, layout)
    for _, row in ipairs(popout.optionRows) do row:Hide() end
    popout.scroll:Show()
    local w = POPOUT_W - 2 * PAD
    local listH = layout(w)
    local needsBar = listH > POPOUT_MAX_LIST_H
    local listW = needsBar and (w - SCROLLBAR_W) or w
    if needsBar then -- again, narrower, to leave room for the scroll bar
        listH = layout(listW)
    end
    popout.list:SetSize(listW, math.max(listH, 1))
    local visible = math.min(listH, POPOUT_MAX_LIST_H)
    popout.scroll:ClearAllPoints()
    popout.scroll:SetPoint("TOPLEFT", popout, "TOPLEFT", PAD, -y)
    popout.scroll:SetSize(listW, visible)
    popout.scroll.needsBar = needsBar
    local bar = ScrollBarOf(popout.scroll)
    if bar then bar:SetShown(needsBar) end
    if popout.zoneKey ~= listKey then
        popout.zoneKey = listKey
        popout.scroll:SetVerticalScroll(0)
    end
    popout:SetHeight(y + visible + PAD)
end

local function RefreshPopout(key, zoneName, fishTable, sessionHere)
    if not (popout and popout:IsShown()) then return end
    if popout.mode == "options" then return RefreshOptionsPanel() end
    local w = POPOUT_W - 2 * PAD
    if popout.mode == "history" then
        local db = FishingDB()
        local history = db and type(db.history) == "table" and db.history or {}
        local y = PlaceText(popout.title, popout, PAD, 13, w - 24, "History") + 2
        y = PlaceText(popout.subtitle, popout, PAD, y, w, #history > 0 and "Your latest catches" or "Nothing caught yet") + 10
        return ShowPanelList(y, "history", function(listW) return LayoutHistory(popoutRows, popout.list, history, listW) end)
    end
    local y = PlaceText(popout.title, popout, PAD, 13, w - 24, "All catches") + 2
    y = PlaceText(popout.subtitle, popout, PAD, y, w, zoneName) + 10
    SortedCatches(popoutList, fishTable, ByCount)
    ShowPanelList(y, key, function(listW)
        return LayoutList(popoutRows, popout.list, popoutList, fishTable, sessionHere, listW, #popoutList)
    end)
end

-- ---------- The window ----------
local function CreateWindow()
    local ar, ag, ab = Theme.GetAccentColor()
    local f = CreateFrame("Frame", "PathForeverFishingFrame", UIParent, "BackdropTemplate")
    f:SetSize(WIDTH, 120)
    local db = FishingDB()
    local p = db and db.point
    if type(p) == "table" and type(p[1]) == "string" then
        f:SetPoint(p[1], UIParent, p[3] or p[1], tonumber(p[4]) or 0, tonumber(p[5]) or 0)
    else
        f:SetPoint("TOPLEFT", UIParent, "CENTER", 170, 150)
    end
    f:SetFrameStrata("MEDIUM") -- the main window's layer; see its note on SetToplevel
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        self:Raise()
        self.isMoving = true
        SyncTackleButtons() -- the lure buttons can't follow a moving window
        self:StartMoving()
    end)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        self.isMoving = nil
        -- Kept by its top-left corner, so a change of height grows the window
        -- downwards and its top (and the tackle box) doesn't jump.
        local left, top = self:GetLeft(), self:GetTop()
        local fdb = FishingDB()
        if left and top then
            local scale = self:GetEffectiveScale() / UIParent:GetEffectiveScale()
            left, top = left * scale, top * scale
            self:ClearAllPoints()
            self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
            if fdb then fdb.point = { "TOPLEFT", "UIParent", "BOTTOMLEFT", left, top } end
        end
        if popout and popout:IsShown() then PlacePopout() end
        SyncTackleButtons()
    end)
    -- Closing the window by any route closes its side panel, brings the
    -- interface back if it was hidden, and takes the lure buttons away.
    f:SetScript("OnHide", function()
        if popout then popout:Hide() end
        ShowInterface()
        SyncTackleButtons()
    end)
    StylePanel(f)
    -- the faded gold line under the title bar, like every PathForever window's
    f.titleLine = { Theme.AddFadedLine(f, 34, 0, 0.4) }

    local logo = f:CreateTexture(nil, "ARTWORK")
    logo:SetSize(18, 18)
    logo:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -11)
    logo:SetTexture(PF.ICON)
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.title:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + 24, -13)
    f.title:SetWidth(TEXT_W - 24 - 24 - 56) -- room for "Options" and the close button
    f.title:SetJustifyH("LEFT")
    f.title:SetText("PathForever Fishing")
    f.title:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
    f.close = CloseButton(f, function()
        f:Hide()
        Theme.PlayUISound("IG_CHARACTER_INFO_CLOSE")
    end)
    -- "Options": the fishing window's own settings, in its side panel.
    f.optionsButton = CreateFrame("Button", nil, f)
    f.optionsButton.text = f.optionsButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.optionsButton.text:SetPoint("TOPLEFT", f.optionsButton, "TOPLEFT", 0, -4)
    f.optionsButton.text:SetWidth(58)
    f.optionsButton.text:SetJustifyH("CENTER")
    f.optionsButton.text:SetText("Options")
    f.optionsButton.text:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    f.optionsButton:SetSize(58, 18)
    f.optionsButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", -34, -8)
    f.optionsButton:SetScript("OnClick", function() Fishing:ToggleOptions() end)

    -- "History", at the bottom right: the latest catches, in the side panel.
    f.historyButton = CreateFrame("Button", nil, f)
    f.historyButton.text = f.historyButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.historyButton.text:SetPoint("TOPLEFT", f.historyButton, "TOPLEFT", 0, -4)
    f.historyButton.text:SetWidth(60)
    f.historyButton.text:SetJustifyH("CENTER")
    f.historyButton.text:SetText("History")
    f.historyButton.text:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    f.historyButton:SetSize(60, 18)
    f.historyButton:SetScript("OnClick", function() Fishing:ToggleHistory() end)
    f.historyButton:SetScript("OnEnter", function(self) self.text:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    f.historyButton:SetScript("OnLeave", function(self)
        local open = popout and popout:IsShown() and popout.mode == "history"
        local c = open and Theme.TEXT or Theme.MUTED
        self.text:SetTextColor(c[1], c[2], c[3])
    end)

    -- "Announce to party", bottom left: a small switch, in the History button's
    -- style. Off by default, since it speaks for the player.
    f.announce = CreateFrame("Button", nil, f)
    Theme.CreateSwitch(f.announce, 22, 12)
    f.announce.cbBorder:SetPoint("TOPLEFT", f.announce, "TOPLEFT", 0, -3)
    f.announce.text = f.announce:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.announce.text:SetPoint("TOPLEFT", f.announce, "TOPLEFT", 28, -3)
    f.announce.text:SetWidth(120)
    f.announce.text:SetJustifyH("LEFT")
    f.announce.text:SetText("Announce to party")
    f.announce.text:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    f.announce:SetSize(150, 18)
    f.announce:SetScript("OnClick", function(self)
        local on = not FishOption("announce")
        SetFishOption("announce", on)
        Theme.PlayCheckboxSound(on)
        Theme.SetSwitch(self, on)
    end)
    f.announce:SetScript("OnEnter", function(self) self.text:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    f.announce:SetScript("OnLeave", function(self) self.text:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3]) end)
    f.optionsButton:SetScript("OnEnter", function(self) self.text:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    f.optionsButton:SetScript("OnLeave", function(self)
        local open = popout and popout:IsShown() and popout.mode == "options"
        local c = open and Theme.TEXT or Theme.MUTED
        self.text:SetTextColor(c[1], c[2], c[3])
    end)
    -- outlined, after their own scripts (SetScript would drop the style's hooks)
    Theme.StyleOutlineButton(f.optionsButton)
    Theme.StyleOutlineButton(f.historyButton)

    f.skill = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    f.skill:SetJustifyH("LEFT")
    f.header = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.header:SetJustifyH("LEFT")
    f.header:SetTextColor(ar, ag, ab)
    f.note = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    f.note:SetJustifyH("LEFT")
    f.list = CreateFrame("Frame", nil, f) -- the latest catches

    -- The tackle box: TACKLE_SLOTS boxes in a row, filled with your best lures.
    f.tackleHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.tackleHeader:SetJustifyH("LEFT")
    f.tackleHeader:SetTextColor(ar, ag, ab)
    f.tackle = {}
    for i = 1, TACKLE_SLOTS do
        local slot = CreateFrame("Frame", nil, f)
        slot:SetSize(TACKLE_SIZE, TACKLE_SIZE)
        slot.border = slot:CreateTexture(nil, "BACKGROUND")
        slot.border:SetAllPoints()
        slot.border:SetColorTexture(ar, ag, ab, 0.35)
        slot.fill = slot:CreateTexture(nil, "BORDER")
        slot.fill:SetPoint("TOPLEFT", slot, "TOPLEFT", 1, -1)
        slot.fill:SetSize(TACKLE_SIZE - 2, TACKLE_SIZE - 2)
        slot.fill:SetColorTexture(0, 0, 0, 0.55)
        slot.icon = slot:CreateTexture(nil, "ARTWORK")
        slot.icon:SetPoint("TOPLEFT", slot, "TOPLEFT", 2, -2)
        slot.icon:SetSize(TACKLE_SIZE - 4, TACKLE_SIZE - 4)
        slot.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        slot.highlight = slot:CreateTexture(nil, "OVERLAY")
        slot.highlight:SetAllPoints()
        slot.highlight:SetColorTexture(1, 1, 1, 0.15)
        slot.highlight:Hide()
        -- how many of that lure you have ("x3"), under the box
        slot.count = slot:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        slot.count:SetPoint("TOPLEFT", slot, "TOPLEFT", 0, -(TACKLE_SIZE + 2))
        slot.count:SetWidth(TACKLE_SIZE)
        slot.count:SetJustifyH("CENTER")
        slot:Hide()
        f.tackle[i] = slot
    end

    -- "Show all catches (N)": a line of text that opens the side panel, like
    -- the main window's "Show completed quests".
    f.more = CreateFrame("Button", nil, f)
    f.more.text = f.more:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.more.text:SetPoint("TOPLEFT", f.more, "TOPLEFT", 0, -2)
    f.more.text:SetJustifyH("LEFT")
    f.more.text:SetTextColor(ar, ag, ab)
    f.more:SetScript("OnClick", function() Fishing:ToggleAllCatches() end)
    f.more:SetScript("OnEnter", function(self) self.text:SetTextColor(1, 1, 1) end)
    f.more:SetScript("OnLeave", function(self) self.text:SetTextColor(ar, ag, ab) end)

    -- Once a second while the window is open: the lure's time left, and a pole
    -- the login check may have missed.
    f.elapsed = 0
    f:SetScript("OnUpdate", function(self, elapsed)
        self.elapsed = self.elapsed + (elapsed or 0)
        if self.elapsed < 1 then return end
        self.elapsed = 0
        self.skill:SetText(SkillText()) -- the lure's time left
        if not holdingPole then Fishing:CheckPole() end -- a pole the login check missed
        -- a drag whose end the client never reported would keep the lure buttons away
        if self.isMoving and IsMouseButtonDown and not IsMouseButtonDown("LeftButton") then
            self.isMoving = nil
            SyncTackleButtons()
        end
        if not InCombatLockdown() and TackleButtonsOutOfPlace() then SyncTackleButtons() end
    end)

    -- Escape closes it, like the main window.
    if type(UISpecialFrames) == "table" then table.insert(UISpecialFrames, "PathForeverFishingFrame") end
    f:Hide()
    return f
end

function Fishing:Refresh()
    if not (window and window:IsShown()) then return end
    local y = 40 -- below the title bar
    y = PlaceText(window.skill, window, PAD, y, TEXT_W, SkillText()) + 14

    local key, zoneName = CurrentZone()
    y = PlaceText(window.header, window, PAD, y, TEXT_W, ("Caught in " .. zoneName):upper()) + 8

    local fishTable = ZoneFish(key)
    local sessionHere = key and session.catches[key]
    SortedCatches(list, fishTable, ByLatest)
    if #list == 0 then
        window.list:Hide()
        y = PlaceText(window.note, window, PAD, y, TEXT_W, "Nothing caught here yet") + 4
    else
        window.note:Hide()
        window.note:SetText("")
        local listH = LayoutList(rows, window.list, list, fishTable, sessionHere, TEXT_W, math.min(#list, RECENT_COUNT))
        window.list:ClearAllPoints()
        window.list:SetPoint("TOPLEFT", window, "TOPLEFT", PAD, -y)
        window.list:SetSize(TEXT_W, math.max(listH, 1))
        window.list:Show()
        y = y + listH + 6
    end

    if #list > RECENT_COUNT then
        local open = popout and popout:IsShown() and popout.mode == "catches"
        local more = window.more
        more.text:SetWidth(TEXT_W)
        more.text:SetText(open and "Hide all catches" or string.format("Show all catches (%d)", #list))
        local h = (more.text:GetStringHeight() or 12) + 4
        more:ClearAllPoints()
        more:SetPoint("TOPLEFT", window, "TOPLEFT", PAD, -y)
        more:SetSize(TEXT_W, h)
        more:Show()
        y = y + h
    else
        window.more:Hide()
        -- everything is in the window already
        if popout and popout.mode == "catches" then popout:Hide() end
    end

    local tackle = window.tackle
    tackle.shown = FishOption("tackleBox")
    if tackle.shown then
        y = PlaceText(window.tackleHeader, window, PAD, y + 8, TEXT_W, "TACKLE BOX") + 6
        for i = 1, TACKLE_SLOTS do
            local slot, lure = tackle[i], lures[i]
            slot:ClearAllPoints()
            slot:SetPoint("TOPLEFT", window, "TOPLEFT", PAD + (i - 1) * (TACKLE_SIZE + TACKLE_GAP), -y)
            slot.icon:SetTexture(lure and lure.icon or nil)
            slot.icon:SetShown(lure ~= nil)
            slot.count:SetText(lure and ("x" .. lure.count) or "")
            slot.count:SetShown(lure ~= nil)
            slot:Show()
        end
        y = y + TACKLE_SIZE + 2 + 12 -- the boxes, and the counts under them
    else
        window.tackleHeader:Hide()
        for i = 1, TACKLE_SLOTS do tackle[i]:Hide() end
    end

    -- "Announce to party" bottom left, "History" bottom right
    local announce = window.announce
    announce:ClearAllPoints()
    announce:SetPoint("TOPLEFT", window, "TOPLEFT", PAD, -(y + 6))
    Theme.SetSwitch(announce, FishOption("announce"))
    local historyButton = window.historyButton
    historyButton:ClearAllPoints()
    historyButton:SetPoint("TOPLEFT", window, "TOPLEFT", WIDTH - PAD - 60, -(y + 6))
    y = y + 6 + 18

    window:SetHeight(y + PAD - 4)
    local panelMode = popout and popout:IsShown() and popout.mode
    local c = panelMode == "options" and Theme.TEXT or Theme.MUTED
    window.optionsButton.text:SetTextColor(c[1], c[2], c[3])
    c = panelMode == "history" and Theme.TEXT or Theme.MUTED
    historyButton.text:SetTextColor(c[1], c[2], c[3])
    RefreshPopout(key, zoneName, fishTable, sessionHere)
    SyncTackleButtons()
    -- and once more next frame: freshly moved slots may not report their
    -- final screen position until the client has laid them out
    if tackle.shown then C_Timer.After(0, SyncTackleButtons) end
end

-- The side panel shows one of two things: "catches" (every catch in the zone)
-- or "options". Asking for the one that's showing closes it; asking for the
-- other switches to it.
local function TogglePanel(mode)
    if not window then return end
    if not popout then popout = CreatePopout() end
    if popout:IsShown() and popout.mode == mode then
        popout:Hide()
    else
        popout.mode = mode
        PlacePopout()
        popout.zoneKey = nil -- opening starts at the top of the list
        popout:Show()
    end
    Fishing:Refresh()
end

-- "Show all catches" / "Hide all catches"
function Fishing:ToggleAllCatches() TogglePanel("catches") end

-- The "Options" button
function Fishing:ToggleOptions() TogglePanel("options") end

-- The "History" button
function Fishing:ToggleHistory() TogglePanel("history") end

-- A fishing option was ticked or unticked.
function Fishing:OptionToggled(key)
    if key == "hideUI" and not FishOption("hideUI") then ShowInterface() end
    if key == "tackleBox" and FishOption("tackleBox") then ScanLures() end
    if key == "doubleClick" and not FishOption("doubleClick") then ClearCastBinding() end
    self:Refresh()
end

function Fishing:Show()
    if not window then window = CreateWindow() end
    ScanLures()
    if #unreadItems > 0 and unreadRetries == 0 then -- (0: not already retrying)
        unreadRetries = 1
        C_Timer.After(UNREAD_RETRY_DELAY, RetryUnread)
    end
    window:Show()
    window:Raise()
    self:Refresh()
end

function Fishing:Hide()
    if window then window:Hide() end
end

function Fishing:IsShown()
    return window ~= nil and window:IsShown()
end

-- /pf fishing
function Fishing:Toggle()
    if self:IsShown() then
        self:Hide()
        Theme.PlayUISound("IG_CHARACTER_INFO_CLOSE")
    else
        self:Show()
        Theme.PlayUISound("IG_CHARACTER_INFO_OPEN")
    end
end

-- The Options checkbox changed.
function Fishing:OptionChanged()
    if not OptionOn() then
        self:Hide()
    elseif holdingPole then
        self:Show()
    end
end

-- ---------- Catch pop-ups ----------
-- Each catch floats up from the cursor (where the bobber was clicked) and fades,
-- like scrolling combat text: a fish's name with a weight, or a junk item's name.
-- Under WorldFrame, so it shows while "Hide the interface" has UIParent hidden.
--
-- A fish is an item whose name has a fish species in it (below), or starts with
-- "Raw "; anything else is junk. Each species has its real-world typical weight
-- range in pounds, and a catch's weight is drawn from it, weighted towards the
-- light end (big ones are rare). The patterns are Lua patterns on the lowercased
-- name; %f[...] keeps short words whole ("cod", not "codex"). First match wins.
local FISH_WEIGHTS = {
    { "smallfish", 0.2, 1.5 },   -- sunfish-sized
    { "redgill", 0.2, 1.5 },     -- bluegill
    { "mackerel", 0.5, 2.5 },    -- Atlantic mackerel
    { "frenzy", 0.5, 3 },        -- piranha-like
    { "squid", 0.3, 3 },
    { "lobster", 0.8, 6 },
    { "deviate", 1, 5 },
    { "sagefish", 1, 6 },        -- whitefish
    { "trout", 0.5, 10 },        -- rainbow trout
    { "%f[%a]bass%f[%A]", 0.8, 10 }, -- largemouth bass
    { "%f[%a]eel%f[%A]", 1, 12 },    -- conger eel
    { "blackmouth", 3, 12 },     -- young chinook salmon
    { "salmon", 3, 30 },
    { "snapper", 1.5, 15 },      -- red snapper ("Mud Snapper", "Mudsnapper")
    { "catfish", 1.5, 25 },      -- channel catfish
    { "%f[%a]cod%f[%A]", 3, 40 },    -- Atlantic cod
    { "yellowtail", 8, 40 },     -- amberjack
    { "armorfish", 5, 40 },      -- sturgeon
    { "albacore", 15, 60 },      -- albacore tuna
    { "mightfish", 10, 60 },     -- grouper
}
local ANY_FISH_WEIGHT = { nil, 0.5, 4 } -- a "Raw ..." fish without a species match

local function FishWeightRange(name)
    if type(name) ~= "string" then return nil end
    local lower = name:lower()
    for _, entry in ipairs(FISH_WEIGHTS) do
        if lower:find(entry[1]) then return entry[2], entry[3] end
    end
    if lower:find("^raw ") then return ANY_FISH_WEIGHT[2], ANY_FISH_WEIGHT[3] end
    return nil -- not a fish: junk
end

-- A random weight for a catch called `name`, in pounds, or nil for junk.
-- One catch in 100 is a trophy, somewhere in the top quarter of the range; the
-- rest fall in the lower three quarters, leaning light (a squared random number).
local TROPHY_CHANCE = 0.01
local function FishWeight(name)
    local low, high = FishWeightRange(name)
    if not low then return nil end
    local share
    if math.random() < TROPHY_CHANCE then
        share = 0.75 + 0.25 * math.random()
    else
        local r = math.random()
        share = 0.75 * r * r
    end
    return low + (high - low) * share
end
Fishing.FishWeight = FishWeight -- (for the tests)

local POPUP_TIME = 1.6   -- seconds a pop-up lives
local POPUP_RISE = 50    -- how far it drifts up
local POPUP_W = 340
local POPUP_LINE = 22    -- several items from one catch stack this far apart
local popupFrame
local popups = {}        -- pooled FontStrings

local function PopupUpdate(self, elapsed)
    local active = false
    for _, fs in ipairs(popups) do
        if fs.age then
            fs.age = fs.age + (elapsed or 0)
            local progress = fs.age / POPUP_TIME
            if progress >= 1 then
                fs.age = nil
                fs:Hide()
            else
                active = true
                fs:ClearAllPoints()
                fs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", fs.x, fs.y + POPUP_RISE * progress)
                -- full strength, then fading over the last 40%
                fs:SetAlpha(progress < 0.6 and 1 or (1 - (progress - 0.6) / 0.4))
            end
        end
    end
    if not active then self:Hide() end -- no OnUpdate while nothing is showing
end

local function AcquirePopup()
    for _, fs in ipairs(popups) do
        if not fs.age then return fs end
    end
    local fs = popupFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    fs:SetWidth(POPUP_W)
    fs:SetJustifyH("CENTER")
    pcall(function()
        local font = fs:GetFont()
        if font then fs:SetFont(font, 18, "OUTLINE") end
    end)
    popups[#popups + 1] = fs
    return fs
end

-- Shows `text` floating up from the cursor; `line` stacks several at once.
local function ShowPopup(text, line)
    if not popupFrame then
        popupFrame = CreateFrame("Frame", "PathForeverFishingPopups", WorldFrame)
        popupFrame:SetAllPoints(WorldFrame)
        popupFrame:SetFrameStrata("HIGH")
        popupFrame:SetScript("OnUpdate", PopupUpdate)
    end
    popupFrame:SetScale(UIParent:GetScale()) -- the interface's text size
    local x, y = 0, 0
    if GetCursorPosition then x, y = GetCursorPosition() end
    local scale = popupFrame:GetEffectiveScale()
    local fs = AcquirePopup()
    fs.x = x / scale - POPUP_W / 2
    fs.y = y / scale + 20 - (line - 1) * POPUP_LINE
    fs.age = 0
    fs:SetText(text)
    fs:SetAlpha(1)
    fs:ClearAllPoints()
    fs:SetPoint("TOPLEFT", popupFrame, "BOTTOMLEFT", fs.x, fs.y)
    fs:Show()
    popupFrame:Show()
end

-- "Announce to party": "I just caught a 1.1 lb [Raw Brilliant Smallfish]!" (no
-- weight for junk), with the item as a real link. Party chat, or instance chat
-- in an instance group; nothing outside a group. Addons may send to these
-- channels without a click (unlike /say and /yell).
local function AnnounceCatch(link, weight)
    if not FishOption("announce") or type(link) ~= "string" or not IsInGroup then return end
    local channel
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE or 2) then
        channel = "INSTANCE_CHAT"
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME or 1) then
        channel = "PARTY"
    end
    if not channel then return end
    local text = weight and string.format("I just caught a %.1f lb %s!", weight, link)
        or ("I just caught a " .. link .. "!")
    local send = (C_ChatInfo and C_ChatInfo.SendChatMessage) or SendChatMessage
    if send then pcall(send, text, channel) end
end

-- One catch: its name in its quality's color, and a fish's weight.
local function ShowCatchPopup(name, quality, line, weight)
    if not FishOption("popups") or type(name) ~= "string" then return end
    local color = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[tonumber(quality) or 1]
    local hex = color and string.format("|cff%02x%02x%02x", math.floor(color.r * 255 + 0.5),
        math.floor(color.g * 255 + 0.5), math.floor(color.b * 255 + 0.5)) or "|cffffffff"
    local text = hex .. name .. "|r"
    if weight then text = text .. string.format("|cffffd100 - %.1f lb|r", weight) end
    ShowPopup(text, line)
end

-- When no catch comes of a cast, the game says why in its red error text:
-- clicking the bobber too late ("Your fish got away!") or before anything bit
-- ("No fish are hooked."). Its own strings are used where the client has them,
-- so this works in any language; the English text is the fallback.
local GOT_AWAY_TEXT = ERR_FISH_ESCAPED or "Your fish got away!"
local NOTHING_TEXT = ERR_FISH_NOT_HOOKED or "No fish are hooked."
local HEARING_THINGS_CHANCE = 50 -- one time in this many, "nothing" gets a joke instead

local function OnGameMessage(message)
    if not FishOption("popups") or type(message) ~= "string" then return end
    if message == GOT_AWAY_TEXT then
        ShowPopup("|cffc8c8c8The fish got away.|r", 1)
    elseif message == NOTHING_TEXT then
        local joke = math.random(HEARING_THINGS_CHANCE) == 1
        ShowPopup(joke and "|cffc8c8c8Are you hearing things?|r" or "|cffc8c8c8There was nothing.|r", 1)
    end
end

-- ---------- "Largest caught" on item tooltips ----------
-- Every item tooltip in the game (bags, links, this window) gets the heaviest
-- one you've caught of that fish. The client's tooltip post-call hook adds a
-- line without touching Blizzard's own code, so it's taint-free.
local function AddLargestCaught(tip, itemID)
    local db = FishingDB()
    local weight = db and type(db.largest) == "table" and tonumber(db.largest[tonumber(itemID) or 0])
    if weight and tip and tip.AddLine then
        tip:AddLine(string.format("Largest caught: %.1f pounds", weight), 1, 0.82, 0)
    end
end
Fishing.AddLargestCaught = AddLargestCaught -- (for the tests)

if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum and Enum.TooltipDataType then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tip, data)
        if type(data) == "table" and data.id then AddLargestCaught(tip, data.id) end
    end)
elseif GameTooltip and GameTooltip.HookScript then -- older clients
    GameTooltip:HookScript("OnTooltipSetItem", function(tip)
        local _, link = tip:GetItem()
        local itemID = type(link) == "string" and tonumber(link:match("item:(%d+)"))
        if itemID then AddLargestCaught(tip, itemID) end
    end)
end

-- ---------- Events ----------
local function UpdatePole()
    local now = IsFishingPole(GetInventoryItemID and GetInventoryItemID("player", MAIN_HAND))
    if now == holdingPole then return end
    holdingPole = now
    if now then
        if not session.start or (session.poleOffAt and GetTime() - session.poleOffAt > SESSION_GRACE) then
            StartSession()
        end
        session.poleOffAt = nil
        if OptionOn() then Fishing:Show() end
    else
        session.poleOffAt = GetTime()
        unreadRetries = 0 -- the next time it opens, try again
        ShowInterface()
        Fishing:Hide()
    end
end

function Fishing:CheckPole() UpdatePole() end

-- Reading a catch. Two things made catches go unrecorded in game (2026-09-30):
--  * with auto loot, the item can be taken before LOOT_OPENED, leaving an empty
--    window to read. LOOT_READY comes first, while the loot is still there, so
--    the loot is read at whichever comes first with items in it, once per
--    loot window (LOOT_CLOSED starts the next one);
--  * whether IsFishingLoot() answers on Forever is unverified. Loot also counts
--    as a catch while you're channeling Fishing, or within FISHING_CAST_WINDOW
--    seconds of the channel ending (clicking the bobber ends it).
-- /pf fishing debug prints what each loot window looked like.
local FISHING_CAST_WINDOW = 5
local fishingChannel = { active = false, endedAt = nil }
local lootHandled = false

local function IsFishingSpell(spellID)
    if not spellID then return false end
    local name
    if C_Spell and C_Spell.GetSpellInfo then
        local ok, info = pcall(C_Spell.GetSpellInfo, spellID)
        if ok and type(info) == "table" then name = info.name end
    elseif GetSpellInfo then
        local ok, n = pcall(GetSpellInfo, spellID)
        if ok then name = n end
    end
    if not name then return false end
    local fishingName -- the profession's name, in the client's language
    if GetProfessions and GetProfessionInfo then
        local _, _, _, fishing = GetProfessions()
        if fishing then fishingName = GetProfessionInfo(fishing) end
    end
    return name == fishingName or name == "Fishing"
end

local function ReadLoot(event)
    if lootHandled then return end
    local count = GetNumLootItems and GetNumLootItems() or 0
    if count == 0 and event == "LOOT_READY" then return end -- nothing yet; LOOT_OPENED may have it
    lootHandled = true

    local api = "missing"
    if IsFishingLoot then
        local ok, result = pcall(IsFishingLoot)
        api = ok and (result and true or false) or "error"
    end
    local recent = fishingChannel.active
        or (fishingChannel.endedAt ~= nil and GetTime() - fishingChannel.endedAt <= FISHING_CAST_WINDOW)
    local counted = 0
    if api == true or recent then
        if not session.start then StartSession() end
        for slot = 1, count do
            local icon, name, quantity, _, quality = GetLootSlotInfo(slot)
            local link = GetLootSlotLink and GetLootSlotLink(slot)
            local itemID = type(link) == "string" and tonumber(link:match("item:(%d+)"))
            if itemID then -- coins have no item link
                local weight = FishWeight(name) -- nil for junk
                RecordCatch(itemID, name, icon, quality, math.max(tonumber(quantity) or 1, 1), weight)
                counted = counted + 1
                ShowCatchPopup(name, quality, counted, weight)
                AnnounceCatch(link, weight)
            end
        end
        fishingChannel.endedAt = nil -- that cast is used up; later loot needs a new one
        Fishing:Refresh()
    end
    if debugLoot then
        print(string.format("|cff3fc7ebPathForever Fishing:|r %s - %d item(s); IsFishingLoot: %s; casting Fishing: %s; counted %d",
            event, count, tostring(api), tostring(recent and true or false), counted))
    end
end

-- /pf fishing debug
function Fishing:ToggleDebug()
    debugLoot = not debugLoot
    print("|cff3fc7ebPathForever Fishing:|r loot details " .. (debugLoot and "on - loot something to see them." or "off."))
    if debugLoot then PrintTackleDebug() end
end

local events = CreateFrame("Frame")
Fishing.eventFrame = events -- (lets the tests drive it)
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
events:RegisterEvent("LOOT_READY")
events:RegisterEvent("LOOT_OPENED")
events:RegisterEvent("LOOT_CLOSED")
events:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
events:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
events:RegisterEvent("SKILL_LINES_CHANGED")
events:RegisterEvent("BAG_UPDATE_DELAYED")
events:RegisterEvent("GET_ITEM_INFO_RECEIVED")
events:RegisterEvent("PLAYER_REGEN_DISABLED")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:RegisterEvent("ZONE_CHANGED_NEW_AREA")
events:RegisterEvent("ZONE_CHANGED")
events:RegisterEvent("UI_ERROR_MESSAGE")
events:RegisterEvent("UI_INFO_MESSAGE")
events:SetScript("OnEvent", function(_, event, arg1, arg2, arg3)
    if event == "PLAYER_EQUIPMENT_CHANGED" then
        if arg1 == MAIN_HAND then UpdatePole() end
    elseif event == "PLAYER_ENTERING_WORLD" then
        -- Right after a reload the equipment may not be readable yet (the pole
        -- went unseen until re-equipped, 2026-09-30): look again shortly.
        UpdatePole()
        Fishing:Refresh()
        C_Timer.After(1, UpdatePole)
        C_Timer.After(3, UpdatePole)
    elseif event == "GET_ITEM_INFO_RECEIVED" then
        if pendingItems[arg1] and not rescanQueued then
            rescanQueued = true
            C_Timer.After(0.2, RescanLures)
        end
    elseif event == "LOOT_READY" or event == "LOOT_OPENED" then
        ReadLoot(event)
    elseif event == "LOOT_CLOSED" then
        lootHandled = false
    elseif event == "UI_ERROR_MESSAGE" or event == "UI_INFO_MESSAGE" then
        -- (messageType, message) on this client; older clients sent just (message)
        OnGameMessage(type(arg2) == "string" and arg2 or arg1)
    elseif event == "BAG_UPDATE_DELAYED" then -- a lure used up, bought or moved
        if Fishing:IsShown() and FishOption("tackleBox") then
            ScanLures()
            Fishing:Refresh()
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        -- Combat is starting; this runs just before the lockdown, so the
        -- interface can still come back and the cast binding be cleared.
        ShowInterface()
        ClearCastBinding()
        lastRightDown = nil
    elseif event == "PLAYER_REGEN_ENABLED" then
        SyncTackleButtons() -- anything that changed during combat
    elseif event == "UNIT_SPELLCAST_CHANNEL_START" then -- (unit, castGUID, spellID)
        if arg1 == "player" and IsFishingSpell(arg3) then
            fishingChannel.active, fishingChannel.endedAt = true, nil
            HideInterface()
        end
    elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
        if arg1 == "player" and fishingChannel.active then
            fishingChannel.active, fishingChannel.endedAt = false, GetTime()
        end
    else -- a skill-up or a new zone: only matters while the window is open
        Fishing:Refresh()
    end
end)
