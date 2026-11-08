-- Camping.lua - PathForever Camping
-- A small draggable window for Forever's campsites. When a campfire is near
-- (you are sitting by one and its benefits reach you) it opens and lists what
-- the camp gives: "Campfire available", then each camp object with its buff,
-- and how many objects of the camp's slots are used.
--
-- How a camp is seen: an addon can't list the game objects around you, so
-- this reads what the client does tell us, your own buffs. A campfire
-- shows as a buff (Campfire Nearby, Welcoming Campfire, Camp Benefits or the
-- campfire's own name) and each camp object that reaches you as a buff named
-- after the object (Mana Well, Sharpening Wheel...). The numbers come from the
-- buff's own description, so they are the game's. Objects with no buff
-- (anvils, bots, vendors) can't be seen this way. The buffs arrive after about
-- a minute of sitting, so the window may wait that long.
-- /pf camp debug prints every buff you have that looks camp-related, and any
-- camp-like API this client has, so the detection can be corrected from a report.
--
-- A campsite holds a few profession objects: 3 with a Basic Campfire, 5 with a
-- Journeyman one (cooking 90) and 10 with an Expert one (cooking 200). The buffs
-- don't say which campfire it is, so 3 is assumed until more objects show.
--
-- Nothing here is protected or secure; showing our own frame is allowed in
-- combat. Text follows UI.lua's "How text is laid out": TOPLEFT anchors, an
-- explicit width, and never an explicit height.

local PF = PathForever
local Camping = {}
PF.Camping = Camping

local Theme = PF.Theme
local WIDTH = 252
local PAD = 12
local TEXT_W = WIDTH - 2 * PAD
local ROW_GAP = 6
local TITLE_H = 30
local HEAD_W = 96            -- the left part of a section's header line; the right part is right-aligned
local MAX_ROWS = 10          -- the largest campfire holds 10 objects
local DEFAULT_SLOTS = 3
local LEAVE_GRACE = 8        -- seconds out of range before a window that opened itself closes
local AWAY_RESET = 60        -- seconds out of range before a window you closed may open again
local SCAN_DELAY = 0.25      -- aura events come in bursts; look once after they settle

-- The buffs that say a campfire is in range, by lower-case name. Camp Benefits is not one of
-- them: it is the 1-hour buff you carry away from a camp, so it must not keep the window open.
local CAMPFIRES = {
    ["campfire nearby"] = true,     -- within 100 yards of a campfire
    ["welcoming campfire"] = true,  -- sitting there; counts down 60 seconds
}

-- `abbr` is the short label under the object's box (4 characters at most): MP5, STR, INT...
-- Camp objects by name: profession, tier, the item that places it (its ID is from
-- the client's item table; the window shows that item's icon) and what it is for.
-- `effect` is the fallback text when nothing better can be read.
local FEATURES = {}
local FEATURE_LIST = {}   -- the same objects, best tier of each profession first
do
    local function add(prof, effect, abbr, ...)
        local list = { ... }
        for tier, e in ipairs(list) do
            FEATURES[e[1]:lower()] = { name = e[1], itemID = e[2], prof = prof, tier = tier, effect = effect, abbr = abbr }
        end
        for tier = #list, 1, -1 do FEATURE_LIST[#FEATURE_LIST + 1] = FEATURES[list[tier][1]:lower()] end
    end
    add("Alchemy", "Mana regeneration", "MP5", { "Mana Well", 279956 }, { "Fermenter", 279970 }, { "Alchemy Laboratory", 279990 })
    add("Blacksmithing", "Increased Strength", "STR", { "Sharpening Wheel", 279944 }, { "Anvil", 279988 }, { "Master Forge", 279955 })
    add("Enchanting", "Armor, all stats and resistances", "ARM", { "Enchanted Lute", 279976 }, { "Arcane Salvager", 279985 }, { "Arcane Forge", 279987 })
    add("Herbalism", "Increased Intellect", "INT", { "Incense Candle", 279962 }, { "Greenhouse", 279964 }, { "Seed Hybridizer", 279947 })
    add("Leatherworking", "Rested XP", "RXP", { "Camp Tent", 279978 }, { "Tanning Rack", 279941 }, { "Sewing Machine", 279945 })
    add("Mining", "Increased melee Attack Power", "AP", { "Lodestone", 279960 }, { "Rock Garden", 279948 }, { "Molten Foundry", 279952 })
    add("Skinning", "2% Critical Strike", "CRIT", { "Camp Chair", 279979 }, { "Field Guide", 279969 }, { "Trapper's Workbench", 279938 })
    add("Tailoring", "Increased Spirit", "SPI", { "Faction Banner", 279972 }, { "Spinning Wheel", 279943 }, { "Loom", 279959 })
    add("First Aid", "Increased Stamina", "STA", { "First Aid Kit", 279968 }, { "Toxin Study", 279940 }, { "Plague Doctor's Laboratory", 279951 })
    add("Fishing", "8% increased stats", "STAT", { "Fish Bowl", 279967 }, { "Fishing Rack", 279965 }, { "Fishing Hut", 279966 })
    add("Cooking", "Stamina-boosting food", "STA", { "Cookie's Feast", 279957 }, { "Iron Oven", 279982 })
    add("Engineering", "Reagents and repairs", "REAG", { "Reagent Bot", 279950 }, { "Repair Bot", 279949 }, { "Anarchist's Workbench", 279989 })
end

local window
local campfire = nil          -- the campfire buff's name, or nil when none is in range
local slots = DEFAULT_SLOTS
local mine = { n = 0, seen = {} }    -- your current Camp Benefits, read from the buff's tooltip: { name, prof, tier, text, itemID, static, abbr }
local offer = { n = 0, seen = {} }   -- the camp's objects you pointed at, in the same shape
local haveBuffs = false       -- the 1-hour Camp Benefits buff is on you
local phase = nil             -- "nearby" (Campfire Nearby), "sitting" (Welcoming Campfire), or nil
local welcomeEnds = nil       -- GetTime() when Welcoming Campfire turns into the benefits
local buffEnds = nil          -- GetTime() when the Camp Benefits buff runs out
local benefitsLeft = nil      -- the Camp Benefits tooltip's "18 minutes remaining" line
local benefitLines = {}       -- the text lines of the Camp Benefits buff's tooltip
local seenObjects = {}        -- lower-case object name -> GetTime() you last pointed at that camp object
local SEEN_KEEP = 600         -- seconds a pointed-at object is remembered while a campfire buff is on you
local autoOpened = false      -- the window opened itself, so it may close itself
local dismissed = false       -- the player closed it; it stays shut until they have been out of range for a minute
local scanQueued = false
local awayToken = 0           -- counts the times you came into range or left it; timers started out of range check it
local awayStarted = false     -- the out-of-range timers are running
local lastRange = false       -- what the Journey's campfire button was last told

local function CampDB()
    local db = PathForeverDB
    if type(db) ~= "table" then return nil end
    if type(db.camping) ~= "table" then db.camping = {} end
    return db.camping
end

local function OptionOn()
    return not (PathForeverDB and PathForeverDB.options and PathForeverDB.options.campWindow == false)
end

-- ---------- Reading buffs ----------
-- Only what the game has been seen to show is read (screenshots, 2026-10-28): the buffs
-- Campfire Nearby (within 100 yards; plain flavor text), Welcoming Campfire (while you
-- sit: "after 1 min spent sitting", with a countdown) and Camp Benefits (1 hour). The
-- Camp Benefits tooltip reads "Gained the following camp benefits:", then one line per
-- benefit, such as "Fish Bowl: All stats increased by 8%.", then "18 minutes remaining".
-- It only appears after the minute of sitting: the camp's own objects can only be listed
-- from what you point at (see OnObjectTooltip).

-- One of the player's buffs: name, aura instance ID, end time.
-- Handles the newer aura API and the old one.
local function ReadBuff(i)
    if C_UnitAuras and C_UnitAuras.GetAuraDataByIndex then
        local ok, data = pcall(C_UnitAuras.GetAuraDataByIndex, "player", i, "HELPFUL")
        if ok and type(data) == "table" then return data.name, data.auraInstanceID, data.expirationTime end
        return nil
    end
    if UnitBuff then
        local ok, name, _, _, _, _, expires = pcall(UnitBuff, "player", i)
        if ok then return name, nil, expires end
    end
    return nil
end

-- The text lines of one buff's tooltip, into `into`.
local function ReadBuffTooltip(i, auraInstanceID, into)
    if not C_TooltipInfo then return end
    local data
    if auraInstanceID and C_TooltipInfo.GetUnitBuffByAuraInstanceID then
        local ok, d = pcall(C_TooltipInfo.GetUnitBuffByAuraInstanceID, "player", auraInstanceID)
        if ok then data = d end
    end
    if not data and C_TooltipInfo.GetUnitAura then
        local ok, d = pcall(C_TooltipInfo.GetUnitAura, "player", i, "HELPFUL")
        if ok then data = d end
    end
    if type(data) == "table" and type(data.lines) == "table" then
        for _, line in ipairs(data.lines) do
            local text = type(line) == "table" and line.leftText
            if type(text) == "string" and text ~= "" then
                into[#into + 1] = (text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))
            end
        end
    end
end

-- The label for a line that names no known object: its first four letters and digits.
local function Abbrev(text)
    return (tostring(text):gsub("[^%w]", ""):sub(1, 4):upper())
end

local function Clear(list)
    for i = 1, list.n do list[i].name = nil end
    list.n = 0
    for key in pairs(list.seen) do list.seen[key] = nil end
end

-- A camp object (feature), or with no feature a plain line of the tooltip. One object per
-- profession in a list.
local function Add(list, feature, name, text, static)
    if list.n >= MAX_ROWS then return end
    if feature then
        if list.seen[feature.prof] then return end
        list.seen[feature.prof] = true
    end
    list.n = list.n + 1
    local entry = list[list.n]
    if not entry then entry = {}; list[list.n] = entry end
    entry.name, entry.prof, entry.tier, entry.text = name, feature and feature.prof, feature and feature.tier, text
    entry.itemID, entry.static = feature and feature.itemID, static
    entry.abbr = feature and feature.abbr or Abbrev(name)
end

-- A tooltip line cut into one piece per camp object it names (new lines count as cuts too).
local function SplitBenefit(line)
    local pieces = {}
    for part in (line:gsub("|n", "\n") .. "\n"):gmatch("(.-)\n") do
        if part:find("%S") then
            local lower = part:lower()
            local hits = {}
            for _, feature in ipairs(FEATURE_LIST) do
                local at = lower:find(feature.name:lower(), 1, true)
                if at then hits[#hits + 1] = at end
            end
            table.sort(hits)
            if #hits < 2 then
                pieces[#pieces + 1] = part
            else
                if hits[1] > 1 and part:sub(1, hits[1] - 1):find("%w") then pieces[#pieces + 1] = part:sub(1, hits[1] - 1) end
                for k = 1, #hits do
                    local piece = part:sub(hits[k], (hits[k + 1] or #part + 1) - 1)
                    piece = piece:gsub("[%s,;]+$", "")
                    if piece ~= "" then pieces[#pieces + 1] = piece end
                end
            end
        end
    end
    return pieces
end

-- Looks at the buffs and fills `campfire`, `phase`, `slots`, and the two lists.
local function Scan()
    Clear(mine)
    Clear(offer)
    for i = #benefitLines, 1, -1 do benefitLines[i] = nil end
    local newFire, have, sitting, ends, buffEndsAt = nil, false, false, nil, nil
    for i = 1, 60 do
        local name, instanceID, expires = ReadBuff(i)
        if not name then break end
        local lower = tostring(name):lower()
        if CAMPFIRES[lower] then newFire = newFire or name end
        if lower == "camp benefits" then
            have = true
            if type(expires) == "number" and expires > 0 then buffEndsAt = expires end
            ReadBuffTooltip(i, instanceID, benefitLines)
        elseif lower == "welcoming campfire" then
            sitting, ends = true, expires
        end
    end
    -- The Camp Benefits tooltip: a line naming a camp object is that object; any other
    -- line (but its title, its header and its time left) is shown as it is. One tooltip line
    -- can hold several objects ("Fish Bowl: ... Anvil: ..."): each is listed on its own.
    benefitsLeft = nil
    for _, rawLine in ipairs(benefitLines) do
        local lowerRaw = rawLine:lower()
        if lowerRaw:find("remaining$") then benefitsLeft = rawLine end
        if lowerRaw ~= "camp benefits" and not lowerRaw:find("remaining$") and not lowerRaw:find(":$") then
            for _, line in ipairs(SplitBenefit(rawLine)) do
                local lowerLine = line:lower()
                local matched = false
                for _, feature in ipairs(FEATURE_LIST) do
                    local want = feature.name:lower()
                    if lowerLine:find(want, 1, true) then
                        matched = true
                        -- the game's lines read "Fish Bowl: All stats increased by 8%.": keep what follows the name
                        local text = line
                        if lowerLine:sub(1, #want + 2) == want .. ": " then text = line:sub(#want + 3) end
                        Add(mine, feature, feature.name, (lowerLine == want) and feature.effect or text, lowerLine == want)
                        break
                    end
                end
                if not matched then
                    local label, rest = line:match("^([^:]+):%s*(.+)$")
                    if label and #label <= 32 then Add(mine, nil, label, rest) else Add(mine, nil, line, nil) end
                end
            end
        end
    end
    -- The camp's objects you pointed at (the game's object tooltip is just the object's
    -- name): listed with what they do. Leaving the camp forgets them.
    if not newFire then
        for key in pairs(seenObjects) do seenObjects[key] = nil end
    else
        local now = GetTime()
        for _, feature in ipairs(FEATURE_LIST) do
            local at = seenObjects[feature.name:lower()]
            if at and now - at < SEEN_KEEP then Add(offer, feature, feature.name, feature.effect, true) end
        end
    end
    -- The campfire's size isn't shown: 3 places (a basic campfire), or 5 (Journeyman) or 10
    -- (Expert) once more objects than that show. Objects are never cut off.
    local count = math.max(mine.n, offer.n)
    local newSlots = DEFAULT_SLOTS
    if count > newSlots then newSlots = (count <= 5) and 5 or 10 end
    campfire, slots, welcomeEnds, buffEnds, haveBuffs = newFire, newSlots, ends, buffEndsAt, have
    if sitting then phase = "sitting"
    elseif newFire then phase = "nearby"
    else phase = nil end
end

-- ---------- The window ----------

-- ---------- The dock: food, camp items and the professions button ----------
-- A second panel under the window, styled like PathForever Fishing's tackle box:
-- boxes with the item's icon and its count under it. Food is any Food and Drink
-- consumable in your bags; camp items are the game's camp objects and campfire
-- kits (item IDs from the client's item table, CAMP_ITEM_RANGES). Clicking a box
-- uses the item. That takes secure buttons, so the same rule as the tackle box
-- applies (CLAUDE.md, taint rule 8): they live in a holder under UIParent, hidden
-- in combat by a state driver, and are placed over the boxes by screen position,
-- never parented or anchored to the window. The professions button is a plain button.
local DOCK_SLOTS = 6
local SLOT_SIZE = 32
local SLOT_GAP = 6
local CAMP_ITEM_RANGES = { { 279938, 279938 }, { 279940, 279941 }, { 279943, 279945 }, { 279947, 279952 },
    { 279955, 279957 }, { 279959, 279962 }, { 279964, 279970 }, { 279972, 279974 }, { 279976, 279976 },
    { 279978, 279979 }, { 279981, 279982 }, { 279985, 279985 }, { 279987, 279990 } }
local FOOD_CLASS = (Enum and Enum.ItemClass and Enum.ItemClass.Consumable) or 0
local FOOD_SUBCLASS = 5 -- Food and Drink
-- Pouch of Violet Dust (ForeverDB item 289439, 2026-11-05): a toy from the launch Twitch Drop. Thrown
-- into a campfire it turns the flames purple and doubles the camp's benefits. A toy isn't in the bags
-- (Forever keeps toys in its own window), so it is added to the camp items, used as a toy.
local TOY_ID = 289439
local itemKind = {}          -- itemID -> "camp", "food" or false (items don't change)
local foodList, campList = {}, {}   -- { itemID, icon, bag, slot, count }, reused every scan
local dockButtons = {}
local secureHolder
local dockTooltip

-- Whether to list the toy: it is shown unless the client says you don't have it. A client with
-- no toy box API (or one that errors) shows it anyway; the button then simply does nothing.
local function HasToy()
    if C_ToyBox and C_ToyBox.PlayerHasToy then
        local ok, has = pcall(C_ToyBox.PlayerHasToy, TOY_ID)
        if ok then return has and true or false end
    end
    return true
end

local function IsCampItem(itemID)
    for _, r in ipairs(CAMP_ITEM_RANGES) do
        if itemID >= r[1] and itemID <= r[2] then return true end
    end
    return false
end

local function KindOf(itemID)
    local cached = itemKind[itemID]
    if cached ~= nil then return cached end
    local kind = false
    if IsCampItem(itemID) then
        kind = "camp"
    elseif C_Item and C_Item.GetItemInfoInstant then
        local ok, _, _, _, _, _, classID, subClassID = pcall(C_Item.GetItemInfoInstant, itemID)
        if not ok or classID == nil then return false end -- not known yet: ask again next scan
        if classID == FOOD_CLASS and subClassID == FOOD_SUBCLASS then kind = "food" end
    end
    itemKind[itemID] = kind
    return kind
end

local function ByCount(a, b)
    if a.count ~= b.count then return a.count > b.count end
    return a.itemID < b.itemID
end
local function ByItemID(a, b) return a.itemID < b.itemID end

local function Fill(list, source, sorter)
    local n = 0
    for _, e in pairs(source) do
        n = n + 1
        local slot = list[n]
        if not slot then slot = {}; list[n] = slot end
        slot.itemID, slot.icon, slot.bag, slot.slot, slot.count = e.itemID, e.icon, e.bag, e.slot, e.count
    end
    for i = #list, n + 1, -1 do list[i] = nil end
    table.sort(list, sorter)
    for i = #list, DOCK_SLOTS + 1, -1 do list[i] = nil end
end

local foodSeen, campSeen = {}, {}
local toyEntry = { itemID = TOY_ID, toy = true, count = 1 }
local function ScanBags()
    wipe(foodSeen); wipe(campSeen)
    if C_Container and C_Container.GetContainerNumSlots then
        for bag = 0, 5 do
            local numSlots = C_Container.GetContainerNumSlots(bag) or 0
            for slot = 1, numSlots do
                local info = C_Container.GetContainerItemInfo(bag, slot)
                local itemID = info and info.itemID
                if itemID then
                    local kind = KindOf(itemID)
                    local set = (kind == "food" and foodSeen) or (kind == "camp" and campSeen) or nil
                    if set then
                        local e = set[itemID]
                        if e then
                            e.count = e.count + (info.stackCount or 1)
                        else
                            set[itemID] = { itemID = itemID, icon = info.iconFileID, bag = bag, slot = slot, count = info.stackCount or 1 }
                        end
                    end
                end
            end
        end
    end
    Fill(foodList, foodSeen, ByCount)
    Fill(campList, campSeen, ByItemID)
    if HasToy() then
        -- first among the camp items; the last box makes room for it
        if #campList >= DOCK_SLOTS then campList[#campList] = nil end
        table.insert(campList, 1, toyEntry)
    end
end

local function EnsureHolder()
    if secureHolder or InCombatLockdown() then return secureHolder end
    secureHolder = CreateFrame("Frame", "PathForeverCampSecure", UIParent)
    secureHolder:SetFrameStrata("HIGH")
    RegisterStateDriver(secureHolder, "visibility", "[combat] hide; show")
    return secureHolder
end

local function DockTooltip()
    if not dockTooltip then
        dockTooltip = CreateFrame("GameTooltip", "PathForeverCampingTooltip", UIParent, "GameTooltipTemplate")
    end
    return dockTooltip
end

local function DockButtonEnter(self)
    if self.slotFrame then self.slotFrame.highlight:Show() end
    if not self.itemID then return end
    local tip = DockTooltip()
    tip:SetOwner(self, "ANCHOR_RIGHT")
    if not (self.bag and pcall(tip.SetBagItem, tip, self.bag, self.slot)) then
        pcall(tip.SetItemByID, tip, self.itemID)
    end
    tip:Show()
end
local function DockButtonLeave(self)
    if self.slotFrame then self.slotFrame.highlight:Hide() end
    DockTooltip():Hide()
end

local function AcquireDockButton(n)
    local btn = dockButtons[n]
    if btn then return btn end
    btn = CreateFrame("Button", "PathForeverDock" .. n, EnsureHolder(), "SecureActionButtonTemplate")
    btn:RegisterForClicks("AnyUp", "AnyDown") -- the client acts on one, per "cast on key down"
    btn:SetAttribute("type", "macro")
    btn:HookScript("OnEnter", DockButtonEnter)
    btn:HookScript("OnLeave", DockButtonLeave)
    dockButtons[n] = btn
    return btn
end

local function DockShowing()
    return window and window:IsShown() and window.dock and window.dock:IsShown() and not window.isMoving
end

-- Places a button over each filled box and hides the rest. Out of combat only;
-- combat ending runs it again.
local function SyncDockButtons()
    if InCombatLockdown() then return end
    local n = 0
    if DockShowing() and EnsureHolder() then
        local holderScale = secureHolder:GetEffectiveScale()
        for _, group in ipairs({ window.dock.food, window.dock.camp }) do
            for i = 1, DOCK_SLOTS do
                local slot = group[i]
                if slot and slot:IsShown() and slot.entry then
                    local l, t = slot:GetLeft(), slot:GetTop()
                    if l and t then
                        n = n + 1
                        local btn = AcquireDockButton(n)
                        local s = slot:GetEffectiveScale() / holderScale
                        btn:ClearAllPoints()
                        btn:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", l * s, t * s)
                        btn:SetSize(slot:GetWidth() * s, slot:GetHeight() * s)
                        if slot.entry.toy then
                            btn:SetAttribute("type", "toy")
                            btn:SetAttribute("toy", slot.entry.itemID)
                        else
                            btn:SetAttribute("type", "macro")
                            btn:SetAttribute("macrotext", "/use item:" .. slot.entry.itemID)
                        end
                        btn.itemID, btn.bag, btn.slot, btn.slotFrame = slot.entry.itemID, slot.entry.bag, slot.entry.slot, slot
                        btn:Show()
                    end
                end
            end
        end
    end
    for i = n + 1, #dockButtons do
        dockButtons[i]:Hide()
        dockButtons[i].slotFrame = nil
    end
end

-- Whether a button is missing, or more than a pixel off its box. The dock's
-- once-a-second tick re-places them if so (the boxes move when the window's height changes).
local function DockButtonsOutOfPlace()
    if not DockShowing() then return false end
    local n = 0
    for _, group in ipairs({ window.dock.food, window.dock.camp }) do
        for i = 1, DOCK_SLOTS do
            local slot = group[i]
            if slot and slot:IsShown() and slot.entry then
                n = n + 1
                local btn = dockButtons[n]
                if not (btn and btn:IsShown() and btn.slotFrame == slot) then return true end
                local sl, st, bl, bt = slot:GetLeft(), slot:GetTop(), btn:GetLeft(), btn:GetTop()
                if sl and st and bl and bt then
                    local ss, bs = slot:GetEffectiveScale(), btn:GetEffectiveScale()
                    if math.abs(sl * ss - bl * bs) > 1 or math.abs(st * ss - bt * bs) > 1 then return true end
                end
            end
        end
    end
    local extra = dockButtons[n + 1]
    return extra ~= nil and extra:IsShown()
end

-- The professions button. All of a character's professions share one window on
-- Forever, in tabs, so opening any one of them opens that window. Out of combat
-- only, and every call is guarded: opening professions from addon code failed
-- before (docs/forever-client.md), so a failure is reported, not hidden.
local function FirstProfessionSkillLine()
    if not GetProfessions then return nil end
    local list = { GetProfessions() } -- prof1, prof2, archaeology, fishing, cooking, first aid
    for _, index in ipairs({ list[1] or false, list[2] or false, list[5] or false, list[6] or false, list[4] or false }) do
        if index then
            local ok, _, _, _, _, _, _, skillLine = pcall(GetProfessionInfo, index)
            if ok and skillLine then return skillLine end
        end
    end
    return nil
end

local function ToggleProfessions()
    local prefix = "|cff3fc7ebPathForever Camping:|r "
    if InCombatLockdown() then print(prefix .. "professions can't be opened in combat.") return end
    if not (C_TradeSkillUI and C_TradeSkillUI.OpenTradeSkill) then print(prefix .. "this client has no professions window to open.") return end
    if ProfessionsFrame and ProfessionsFrame:IsShown() and C_TradeSkillUI.CloseTradeSkill then
        pcall(C_TradeSkillUI.CloseTradeSkill)
        return
    end
    local skillLine = FirstProfessionSkillLine()
    if not skillLine then print(prefix .. "you have no professions to open.") return end
    local ok, err = pcall(C_TradeSkillUI.OpenTradeSkill, skillLine)
    if not ok then print(prefix .. "the professions window did not open (" .. tostring(err) .. ").") end
end

local function CreateSlot(parent, ar, ag, ab)
    local slot = CreateFrame("Frame", nil, parent)
    slot:SetSize(SLOT_SIZE, SLOT_SIZE)
    slot.border = slot:CreateTexture(nil, "BACKGROUND")
    slot.border:SetAllPoints()
    slot.border:SetColorTexture(ar, ag, ab, 0.35)
    slot.fill = slot:CreateTexture(nil, "BORDER")
    slot.fill:SetPoint("TOPLEFT", slot, "TOPLEFT", 1, -1)
    slot.fill:SetSize(SLOT_SIZE - 2, SLOT_SIZE - 2)
    slot.fill:SetColorTexture(0, 0, 0, 0.55)
    slot.icon = slot:CreateTexture(nil, "ARTWORK")
    slot.icon:SetPoint("TOPLEFT", slot, "TOPLEFT", 2, -2)
    slot.icon:SetSize(SLOT_SIZE - 4, SLOT_SIZE - 4)
    slot.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    slot.highlight = slot:CreateTexture(nil, "OVERLAY")
    slot.highlight:SetAllPoints()
    slot.highlight:SetColorTexture(1, 1, 1, 0.15)
    slot.highlight:Hide()
    -- how many you have ("x3"), under the box
    slot.count = slot:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    slot.count:SetPoint("TOPLEFT", slot, "TOPLEFT", 0, -(SLOT_SIZE + 2))
    slot.count:SetWidth(SLOT_SIZE)
    slot.count:SetJustifyH("CENTER")
    slot:Hide()
    return slot
end

local RefreshDock -- defined below; the dock's small button calls it
local function CreateDock(parent)
    local ar, ag, ab = Theme.GetAccentColor()
    local d = CreateFrame("Frame", "PathForeverCampDock", parent, "BackdropTemplate")
    d:SetSize(WIDTH, 100)
    d:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -4)
    d:SetFrameStrata("MEDIUM")
    Theme.StyleWindow(d)
    d.foodHeader = d:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    d.foodHeader:SetJustifyH("LEFT")
    d.foodHeader:SetTextColor(ar, ag, ab)
    d.foodHeader:SetText("Food")
    d.foodNote = d:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    d.foodNote:SetJustifyH("LEFT")
    d.foodNote:SetText("No food in your bags")
    d.campHeader = d:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    d.campHeader:SetJustifyH("LEFT")
    d.campHeader:SetTextColor(ar, ag, ab)
    d.campHeader:SetText("Camp items")
    d.campNote = d:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    d.campNote:SetJustifyH("LEFT")
    d.campNote:SetText("No camp items in your bags")
    d.food, d.camp = {}, {}
    for i = 1, DOCK_SLOTS do
        d.food[i] = CreateSlot(d, ar, ag, ab)
        d.camp[i] = CreateSlot(d, ar, ag, ab)
    end
    d.profession = CreateFrame("Button", nil, d)
    d.profession:SetSize(TEXT_W - 30, 24)
    d.profession.text = d.profession:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    d.profession.text:SetPoint("CENTER")
    d.profession.text:SetText("Professions")
    d.profession.text:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
    d.profession:SetScript("OnClick", ToggleProfessions)
    Theme.StyleOutlineButton(d.profession)
    -- the small button beside it opens or closes the food and camp items; closed by default
    d.toggle = CreateFrame("Button", nil, d)
    d.toggle:SetSize(24, 24)
    d.toggle.text = d.toggle:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    d.toggle.text:SetPoint("CENTER")
    d.toggle.text:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
    d.toggle:SetScript("OnClick", function()
        local db = CampDB()
        if db then db.dockOpen = not db.dockOpen end
        RefreshDock()
    end)
    d.toggle:SetScript("OnEnter", function(self)
        local tip = DockTooltip()
        tip:SetOwner(self, "ANCHOR_RIGHT")
        tip:AddLine("Food and camp items", Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
        tip:Show()
    end)
    d.toggle:SetScript("OnLeave", function() DockTooltip():Hide() end)
    Theme.StyleOutlineButton(d.toggle)
    d:SetScript("OnHide", SyncDockButtons)
    -- every second: put any button that fell out of step back over its box
    d.tick = 0
    d:SetScript("OnUpdate", function(self, elapsed)
        self.tick = self.tick + elapsed
        if self.tick < 1 then return end
        self.tick = 0
        if not InCombatLockdown() and DockButtonsOutOfPlace() then SyncDockButtons() end
    end)
    return d
end

local function LayoutGroup(d, header, note, slots, list, y)
    header:ClearAllPoints()
    header:SetPoint("TOPLEFT", d, "TOPLEFT", PAD, -y)
    header:SetWidth(TEXT_W)
    y = y + header:GetStringHeight() + 4
    if #list == 0 then
        note:ClearAllPoints()
        note:SetPoint("TOPLEFT", d, "TOPLEFT", PAD, -y)
        note:SetWidth(TEXT_W)
        note:Show()
        y = y + note:GetStringHeight() + ROW_GAP + 4
    else
        note:Hide()
    end
    for i = 1, DOCK_SLOTS do
        local slot, e = slots[i], list[i]
        if e then
            slot:ClearAllPoints()
            slot:SetPoint("TOPLEFT", d, "TOPLEFT", PAD + (i - 1) * (SLOT_SIZE + SLOT_GAP), -y)
            slot.entry = e
            slot.icon:SetTexture(e.toy and Camping.ItemIcon(e.itemID) or e.icon)
            slot.count:SetText(e.count > 1 and ("x" .. e.count) or "")
            slot:Show()
        else
            slot.entry = nil
            slot:Hide()
        end
    end
    if #list > 0 then y = y + SLOT_SIZE + 2 + 14 + ROW_GAP end
    return y
end

-- Closed (the default), the dock is just the Professions button and the small button that opens it.
local function HideGroup(header, note, group)
    header:Hide()
    note:Hide()
    for i = 1, DOCK_SLOTS do
        group[i].entry = nil
        group[i]:Hide()
    end
end

function RefreshDock()
    local d = window and window.dock
    if not (d and d:IsShown()) then return end
    local db = CampDB()
    local open = db and db.dockOpen
    local y = 10
    if open then
        ScanBags()
        d.foodHeader:Show()
        d.campHeader:Show()
        y = LayoutGroup(d, d.foodHeader, d.foodNote, d.food, foodList, y)
        y = LayoutGroup(d, d.campHeader, d.campNote, d.camp, campList, y)
    else
        HideGroup(d.foodHeader, d.foodNote, d.food)
        HideGroup(d.campHeader, d.campNote, d.camp)
    end
    d.toggle.text:SetText(open and "-" or "+")
    d.toggle:ClearAllPoints()
    d.toggle:SetPoint("TOPLEFT", d, "TOPLEFT", PAD + TEXT_W - 24, -y)
    d.profession:ClearAllPoints()
    d.profession:SetPoint("TOPLEFT", d, "TOPLEFT", PAD, -y)
    y = y + 24 + 12
    d:SetHeight(y)
    SyncDockButtons()
    C_Timer.After(0, SyncDockButtons) -- the window may have changed height this frame
end

local function PositionWindow(f)
    local db = CampDB()
    local p = db and db.point
    f:ClearAllPoints()
    if type(p) == "table" and type(p[1]) == "string" then
        f:SetPoint(p[1], UIParent, p[3] or p[1], tonumber(p[4]) or 0, tonumber(p[5]) or 0)
    else
        f:SetPoint("TOPLEFT", UIParent, "CENTER", 170, -40)
    end
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

-- Each camp object is a box with its item's icon; hovering shows what the buff does.
local iconCache = {}
local function ItemIcon(itemID)
    if not itemID then return 134400 end -- the question mark
    local cached = iconCache[itemID]
    if cached then return cached end
    local icon
    if C_Item and C_Item.GetItemIconByID then
        local ok, result = pcall(C_Item.GetItemIconByID, itemID)
        if ok then icon = result end
    end
    if not icon and C_Item and C_Item.GetItemInfoInstant then
        local ok, _, _, _, _, result = pcall(C_Item.GetItemInfoInstant, itemID)
        if ok then icon = result end
    end
    if icon then iconCache[itemID] = icon end
    return icon or 134400
end

-- The tooltip: the text from the Camp Benefits tooltip; if it only named the object, the
-- item's own tooltip, which says what the object does.
local function ObjectEnter(self)
    local e = self.entry
    if not e then return end
    self.highlight:Show()
    local tip = DockTooltip()
    tip:SetOwner(self, "ANCHOR_RIGHT")
    local done = false
    if e.static and e.itemID and tip.SetItemByID then
        done = pcall(tip.SetItemByID, tip, e.itemID) and true or false
    end
    if not done then
        local ar, ag, ab = Theme.GetAccentColor()
        tip:AddLine(e.name, ar, ag, ab)
        if e.prof then tip:AddLine(e.prof, Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3]) end
        if e.text then tip:AddLine(e.text, 1, 1, 1, true) end
    end
    tip:Show()
end
local function ObjectLeave(self)
    self.highlight:Hide()
    DockTooltip():Hide()
end

-- The boxes scale with the camp: up to 3 objects (a basic campfire) are a little bigger
-- and left aligned, 4 to 6 sit on one centered line, and more fill two centered lines of 5.
local function ObjectLayout(n)
    if n <= 3 then return 36, 6, 6, false end
    if n <= 6 then return 32, 6, 6, true end
    return 32, 6, 5, true
end
local LABEL_H = 12 -- the abbreviation under a box

-- A box of another size than the dock's: the pieces CreateSlot sized follow it.
local function ResizeSlot(slot, size)
    slot:SetSize(size, size)
    slot.fill:SetSize(size - 2, size - 2)
    slot.icon:SetSize(size - 4, size - 4)
    slot.count:ClearAllPoints()
    slot.count:SetPoint("TOPLEFT", slot, "TOPLEFT", 0, -(size + 2))
    slot.count:SetWidth(size)
end

local function AcquireBox(pool, n)
    local slot = pool[n]
    if slot then return slot end
    local ar, ag, ab = Theme.GetAccentColor()
    slot = CreateSlot(window, ar, ag, ab)
    slot:EnableMouse(true)
    slot:SetScript("OnEnter", ObjectEnter)
    slot:SetScript("OnLeave", ObjectLeave)
    pool[n] = slot
    return slot
end

-- Lays a list out as boxes from `y` down (hiding the pool's spare boxes); returns the y below them.
local function LayoutBoxes(pool, list, y)
    local shown = list.n
    local size, gap, perRow, centered = ObjectLayout(shown)
    local rowStep = size + 2 + LABEL_H + 4
    for n = 1, math.max(shown, #pool) do
        local slot = pool[n]
        if n <= shown then
            local e = list[n]
            slot = slot or AcquireBox(pool, n)
            local line = math.floor((n - 1) / perRow)
            local col = (n - 1) - line * perRow
            local inLine = math.min(perRow, shown - line * perRow)
            local x = PAD + col * (size + gap)
            if centered then x = x + (TEXT_W - (inLine * size + (inLine - 1) * gap)) / 2 end
            ResizeSlot(slot, size)
            slot:ClearAllPoints()
            slot:SetPoint("TOPLEFT", window, "TOPLEFT", x, -(y + line * rowStep))
            slot.entry = e
            slot.icon:SetTexture(ItemIcon(e.itemID))
            slot.count:SetText(e.abbr or "")
            slot:Show()
        elseif slot then
            slot.entry = nil
            slot:Hide()
        end
    end
    if shown > 0 then y = y + math.ceil(shown / perRow) * rowStep end
    return y
end

Camping.ItemIcon = ItemIcon

local function CreateWindow()
    local f = CreateFrame("Frame", "PathForeverCampingFrame", UIParent, "BackdropTemplate")
    f:SetSize(WIDTH, 100)
    PositionWindow(f)
    f:SetFrameStrata("MEDIUM") -- the main window's layer; see its note on SetToplevel
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        self:Raise()
        self.isMoving = true
        SyncDockButtons() -- the item buttons can't follow a moving window
        self:StartMoving()
    end)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        self.isMoving = nil
        -- Kept by its top-left corner, so a change of height grows the window downwards.
        local left, top = self:GetLeft(), self:GetTop()
        local db = CampDB()
        if left and top then
            local scale = self:GetEffectiveScale() / UIParent:GetEffectiveScale()
            left, top = left * scale, top * scale
            self:ClearAllPoints()
            self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
            if db then db.point = { "TOPLEFT", "UIParent", "BOTTOMLEFT", left, top } end
        end
        SyncDockButtons()
    end)
    Theme.StyleWindow(f)
    f.objects = {}     -- the boxes of "This camp"
    f.mineBoxes = {}   -- the boxes of "Your buffs"
    f.dock = CreateDock(f)
    f:SetScript("OnShow", function() RefreshDock() end)
    -- However it was closed (the x, Escape, the button), a window closed while a campfire is in
    -- range stays shut until you have been away for a minute. Hiding it in code is not that:
    -- leaving the camp has no campfire, and turning the option off clears it again.
    f:SetScript("OnHide", function()
        if campfire then dismissed = true end
        SyncDockButtons()
    end)
    f.titleLine = { Theme.AddFadedLine(f, TITLE_H, 0, 0.4) }

    -- The title bar says where you stand: "Campfire nearby", "Sitting - 42 s", "No campfire nearby".
    local logo = f:CreateTexture(nil, "ARTWORK")
    logo:SetSize(16, 16)
    logo:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -8)
    logo:SetTexture(PF.ICON)
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.title:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + 22, -9)
    f.title:SetWidth(TEXT_W - 22 - 24)
    f.title:SetJustifyH("LEFT")
    f.close = CloseButton(f, function()
        f:Hide() -- OnHide notes that the player closed it
        Theme.PlayUISound("IG_CHARACTER_INFO_CLOSE")
    end)

    local function Text(font, justify)
        local fs = f:CreateFontString(nil, "OVERLAY", font)
        fs:SetJustifyH(justify)
        return fs
    end
    f.mineHeader, f.mineTime = Text("GameFontNormalSmall", "LEFT"), Text("GameFontHighlightSmall", "RIGHT")
    f.campHeader, f.campCount = Text("GameFontNormalSmall", "LEFT"), Text("GameFontHighlightSmall", "RIGHT")
    f.hint = Text("GameFontHighlightSmall", "LEFT")
    f.hint:SetWidth(TEXT_W)

    -- Redraw once a second while Welcoming Campfire counts down, every 15 s for the time left.
    f.tick = 0
    f:SetScript("OnUpdate", function(self, elapsed)
        local every = (phase == "sitting") and 1 or (buffEnds and 15)
        if not every then return end
        self.tick = self.tick + elapsed
        if self.tick < every then return end
        self.tick = 0
        Camping:Refresh()
    end)

    -- Escape closes it, like the other windows.
    if type(UISpecialFrames) == "table" then table.insert(UISpecialFrames, "PathForeverCampingFrame") end
    f:Hide()
    return f
end

-- "42 min left" for the 1-hour buff: from the buff's end time, else from its tooltip.
local function TimeLeft()
    if buffEnds then
        local secs = buffEnds - GetTime()
        if secs <= 0 then return nil end
        if secs < 60 then return "under 1 min left" end
        return math.ceil(secs / 60) .. " min left"
    end
    if benefitsLeft then return (benefitsLeft:gsub("[Rr]emaining", "left")) end
    return nil
end

-- A section's header line: the name on the left, a note in white on the right.
local function PlaceHeader(left, right, y, leftText, rightText)
    left:ClearAllPoints()
    left:SetPoint("TOPLEFT", window, "TOPLEFT", PAD, -y)
    left:SetWidth(HEAD_W)
    left:SetText(leftText)
    left:Show()
    right:ClearAllPoints()
    right:SetPoint("TOPLEFT", window, "TOPLEFT", PAD + HEAD_W, -y)
    right:SetWidth(TEXT_W - HEAD_W)
    right:SetText(rightText or "")
    right:Show()
end
local HEADER_H = 16

function Camping:Refresh()
    if not (window and window:IsShown()) then return end
    local ar, ag, ab = Theme.GetAccentColor()
    if phase == "sitting" then
        local left = welcomeEnds and math.max(0, math.ceil(welcomeEnds - GetTime()))
        window.title:SetText(left and ("Sitting - " .. left .. " s") or "Sitting by the campfire")
    elseif campfire then
        window.title:SetText("Campfire nearby")
    else
        window.title:SetText("No campfire nearby")
    end
    if campfire then
        window.title:SetTextColor(ar, ag, ab)
    else
        window.title:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    end
    window.mineHeader:SetTextColor(ar, ag, ab)
    window.campHeader:SetTextColor(ar, ag, ab)
    window.mineTime:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    window.campCount:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    window.hint:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    local y = TITLE_H + 8
    local hint = nil

    -- Your buffs: what you carry now, with the time left, to weigh against the camp's.
    if haveBuffs then
        PlaceHeader(window.mineHeader, window.mineTime, y, "Your buffs", TimeLeft())
        y = LayoutBoxes(window.mineBoxes, mine, y + HEADER_H) + ROW_GAP
    else
        window.mineHeader:Hide()
        window.mineTime:Hide()
        LayoutBoxes(window.mineBoxes, mine, y) -- empty: hides its boxes
    end

    -- This camp: the objects you have pointed at.
    if campfire then
        PlaceHeader(window.campHeader, window.campCount, y, "This camp", offer.n > 0 and (offer.n .. " seen") or nil)
        y = y + HEADER_H
        if offer.n == 0 then hint = "Point at the camp's objects to list them." end
    else
        window.campHeader:Hide()
        window.campCount:Hide()
        if not haveBuffs then hint = "Walk up to a campfire to see its buffs." end
    end
    y = LayoutBoxes(window.objects, offer, y)

    if hint then
        window.hint:ClearAllPoints()
        window.hint:SetPoint("TOPLEFT", window, "TOPLEFT", PAD, -y)
        window.hint:SetWidth(TEXT_W)
        window.hint:SetText(hint)
        window.hint:Show()
        y = y + window.hint:GetStringHeight() + 2
    else
        window.hint:Hide()
    end
    window:SetHeight(y + 8)
    RefreshDock()
end

function Camping:IsShown() return window ~= nil and window:IsShown() end

-- Whether a campfire is in range (the Journey's campfire button asks).
function Camping:InRange() return campfire ~= nil end

function Camping:Toggle()
    if not window then window = CreateWindow() end
    autoOpened = false -- by hand: it stays until closed by hand
    if window:IsShown() then
        window:Hide()
    else
        dismissed = false
        Scan()
        window:Show()
        window:Raise()
        Camping:Refresh()
    end
end

function Camping:OptionChanged()
    if not OptionOn() and window and window:IsShown() and autoOpened then
        window:Hide()
        dismissed = false -- switching the option off is not closing the window
    end
end

-- ---------- Watching ----------

-- Tells the Journey's campfire button when a campfire comes into range or leaves it.
local function NotifyRange()
    local near = campfire ~= nil
    if near == lastRange then return end
    lastRange = near
    if PF.Journey and PF.Journey.UpdateCampButton then PF.Journey:UpdateCampButton() end
end

local function Evaluate()
    scanQueued = false
    Scan()
    if campfire then
        awayStarted = false
        awayToken = awayToken + 1 -- any out-of-range timer still waiting is void
        if OptionOn() and not dismissed and not (window and window:IsShown()) then
            if not window then window = CreateWindow() end
            autoOpened = true
            window:Show()
        end
    elseif not awayStarted then
        -- Out of range, started once (not on every aura event): a window that opened itself
        -- closes soon, and one the player closed may open again after a minute away.
        awayStarted = true
        awayToken = awayToken + 1
        local token = awayToken
        C_Timer.After(LEAVE_GRACE, function()
            if token == awayToken and not campfire and window and window:IsShown() and autoOpened then window:Hide() end
        end)
        C_Timer.After(AWAY_RESET, function()
            if token == awayToken and not campfire then dismissed = false end
        end)
    end
    NotifyRange()
    Camping:Refresh()
end

local function QueueScan()
    if scanQueued then return end
    scanQueued = true
    C_Timer.After(SCAN_DELAY, Evaluate)
end

-- /pf camp debug
local function PrintDebug()
    local prefix = "|cff3fc7ebPathForever Camping:|r "
    print(prefix .. "camp buffs on you:")
    local n = 0
    for i = 1, 60 do
        local name = ReadBuff(i)
        if not name then break end
        if tostring(name):lower():find("camp", 1, true) then
            n = n + 1
            print("  " .. tostring(name))
        end
    end
    if n == 0 then print("  none. Sit by a campfire for a minute, then try again.") end
    print(string.format(prefix .. "seen: campfire %s, phase %s, your buffs %d, camp objects seen %d, %d place(s)",
        tostring(campfire), tostring(phase), mine.n, offer.n, slots))
    print(prefix .. "Camp Benefits tooltip (" .. #benefitLines .. " lines):")
    for _, line in ipairs(benefitLines) do print("  " .. line) end
    local apis = {}
    for key, value in pairs(_G) do
        if type(key) == "string" and type(value) == "table" and key:match("^C_Camp") then
            local fns = {}
            for fname in pairs(value) do fns[#fns + 1] = tostring(fname) end
            table.sort(fns)
            apis[#apis + 1] = key .. ": " .. table.concat(fns, ", ")
        end
    end
    if #apis == 0 then
        print(prefix .. "no camp API found (no global table starting with C_Camp).")
    else
        table.sort(apis)
        for _, line in ipairs(apis) do print("  " .. line) end
    end
end

function Camping:Debug() PrintDebug() end

-- ---------- Camp objects you point at ----------
-- The camp objects can be pointed at in the world, and their tooltip is just their name
-- ("Sharpening Wheel"). Pointing at one adds it to the window, with what it does, before the
-- minute of sitting is over. Only object tooltips are read, and only their first line.
local function OnObjectTooltip(_, data)
    if not campfire or type(data) ~= "table" or type(data.lines) ~= "table" then return end
    local first = data.lines[1]
    local name = type(first) == "table" and first.leftText
    if type(name) ~= "string" then return end
    local lower = (name:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")):lower()
    if FEATURES[lower] and not (seenObjects[lower] and GetTime() - seenObjects[lower] < 1) then
        seenObjects[lower] = GetTime()
        QueueScan()
    end
end
Camping.OnObjectTooltip = OnObjectTooltip -- (for the tests)
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum and Enum.TooltipDataType
    and Enum.TooltipDataType.Object then
    -- Guarded: it runs on every object tooltip, and a bad read (or a protected tooltip in
    -- combat) must never raise an error inside the game's own tooltip code.
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Object, function(...)
        if InCombatLockdown() then return end
        pcall(OnObjectTooltip, ...)
    end)
end

local events = CreateFrame("Frame")
Camping.eventFrame = events -- (lets the tests drive it)
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterUnitEvent("UNIT_AURA", "player")
events:RegisterEvent("BAG_UPDATE_DELAYED")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(_, event)
    if event == "BAG_UPDATE_DELAYED" or event == "PLAYER_REGEN_ENABLED" then
        RefreshDock() -- bags changed, or anything that changed during combat
        return
    end
    QueueScan()
    if event == "PLAYER_ENTERING_WORLD" then
        -- buffs can arrive late after a login or reload: look again shortly
        C_Timer.After(3, QueueScan)
    end
end)
