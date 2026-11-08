-- Spotter.lua - the enemy player spotter (PF.Spotter)
-- A thin coloured bar docked to the left (or, once dragged, right) screen edge, off by default
-- (Options > Enemy spotter, or /pf spotter). The bar takes the colour of the most dangerous enemy
-- player in sight and shows how many enemy players are around as a number. Hovering it slides out
-- a list, one line per player (class icon, level, name).
--   red     enemy 5 or more levels above you, or level ?? (always the most dangerous colour)
--   orange  4 below to 4 above
--   green   5 to 9 below
--   (left out of the colours) 10 or more levels below; they still count in the number
-- A new red player makes the bar pulse once. Drag the bar up or down; it snaps to the nearer edge.
-- A player who comes into sight at orange or above (not green) also slides out of the bar as a
-- card with their name, level and class, for a few seconds, then fades. The card shows the most
-- recent arrival; the bar keeps the colour of the most dangerous player, so a less dangerous
-- arrival does not change it. Clicking the card targets them (a secure button, out of combat only,
-- under UIParent in a holder that hides in combat: taint rule 8). At most three cards wait in
-- line, newest first; the same player is not announced again within a minute. Hovering the bar
-- shows the full list instead of a card.
--
-- An addon cannot list every player nearby. Players are seen only through enemy nameplates, your
-- target and the mouseover, so the nameplates for enemy players must be on. (The combat log is not
-- used: retail 12 forbids addons from registering it, and Forever shares that client, 2026-11-04.
-- /who does not work on the other faction either.) With the spotter on and enemy nameplates off, a
-- zone change into a PvP zone, or while you are flagged, prints one reminder.
-- A player whose level is not known (Spotter.Feed with no level) is counted and listed ("Lv ?",
-- grey) but gets no card and does not colour the bar until a level arrives.
-- Reading units and showing our own frames works in combat; only the card's click to target is
-- secure. The unit calls are wrapped in pcall in case a value is withheld in combat.
-- Text follows UI.lua's "How text is laid out": TOPLEFT anchors, an explicit width, never a height.

local PF = PathForever
local Spotter = {}
PF.Spotter = Spotter

local Theme = PF.Theme
local STRIP_W, STRIP_H = 16, 40  -- the bar, as tall as the card
local HIT_PAD = 6                   -- extra width on the screen side, so the bar is easy to hit
local FRAME_W = STRIP_W + HIT_PAD
local LIST_W = 164
local PAD = 8
local ROW_H = 16
local MAX_ROWS = 8
local EXTRA_ROWS = 2        -- "+N more" and "N far below you"
local EXPIRE = 20           -- seconds a player seen only by target or mouseover stays listed
local PULSE = 1.6           -- seconds the strip pulses on a new red or skull
local DEFAULT_Y_FRACTION = 0.05 -- docked on the left, in the top 5% of the screen (above the party and raid frames), until it is dragged
local ICONS = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES"

local RED, ORANGE, GREEN = 3, 2, 1
local COLORS = {
    [RED] = { 0.92, 0.22, 0.22 },
    [ORANGE] = { 1, 0.55, 0.12 },
    [GREEN] = { 0.32, 0.85, 0.36 },
}

local frame, list
local entries = {}          -- guid -> { name, level, class, seen, plate, alerted }
local shown = {}            -- the sorted list the last Refresh drew
local pulseUntil = 0

local ANNOUNCE_FROM = ORANGE -- the lowest threat that slides out as a card
local CARD_W, CARD_H = 172, STRIP_H
local SLIDE, HOLD, FADE = 0.25, 4, 1 -- seconds: sliding out, staying, fading
local REANNOUNCE = 60       -- seconds before the same player is announced again
local QUEUE_MAX = 3
local card, cardButton, secureHolder
local queue = {}            -- players waiting for the card: { guid, name, level, class, threat }
local announcedAt = {}      -- guid -> when it was last announced
local unknowns = {}         -- the players whose level is not known, as the last Refresh saw them
local lastHintZone          -- the zone the nameplate reminder last went out for

local function OptionOn()
    return PathForeverDB ~= nil and PathForeverDB.options ~= nil and PathForeverDB.options.enemySpotter == true
end

local function SpotterDB()
    local db = PathForeverDB
    if type(db) ~= "table" then return nil end
    if type(db.spotter) ~= "table" then db.spotter = {} end
    return db.spotter
end

local function Now() return GetTime and GetTime() or 0 end

-- Whether the mouse is over a frame. The frame's own IsMouseOver (what UI.lua uses) comes first: the
-- old global MouseIsOver is gone from newer clients, and without it the bar never saw the mouse.
local function Over(f)
    if f.IsMouseOver then
        local ok, r = pcall(f.IsMouseOver, f)
        if ok then return r and true or false end
    end
    if MouseIsOver then
        local ok, r = pcall(MouseIsOver, f)
        if ok then return r and true or false end
    end
    return false
end

-- The threat of an enemy level against yours: 0 (left out), 1 green, 2 orange, 3 red.
function Spotter.Threat(level, mine)
    if type(level) ~= "number" or type(mine) ~= "number" then return 0 end
    if level <= 0 then return RED end -- the game reports ?? as -1
    local d = level - mine
    if d >= 5 then return RED end
    if d >= -4 then return ORANGE end
    if d >= -9 then return GREEN end
    return 0
end

-- ---------- Seeing players ----------

-- Notes a player as seen (the unit events below call this; so does the retail demo). A player
-- fed with plate = true stays until Spotter.Drop, the others expire.
-- Since the Forever launch the client can hand addons "secret" values (units in combat, instances,
-- some PvP): a secret string cannot be a table key or be compared, so every read is checked first.
local issecret = issecretvalue or function() return false end

function Spotter.Feed(guid, name, level, class, plate)
    if type(guid) ~= "string" or issecret(guid) then return end
    if issecret(name) then name = nil end
    if issecret(level) then level = nil end
    if issecret(class) then class = nil end
    local e = entries[guid]
    if not e then e = {}; entries[guid] = e end
    if type(name) == "string" then e.name = name elseif not e.name then e.name = "Unknown" end
    if type(level) == "number" then e.level = level end -- nil = not known yet; a known level is kept
    if type(class) == "string" then e.class = class end
    e.seen = Now()
    e.guid = guid
    if plate then e.plate = true end
end

function Spotter.Drop(guid)
    if type(guid) ~= "string" or issecret(guid) then return end
    entries[guid] = nil
end

function Spotter.Clear()
    for guid in pairs(entries) do entries[guid] = nil end
    for guid in pairs(announcedAt) do announcedAt[guid] = nil end
    for i = #queue, 1, -1 do queue[i] = nil end
    if Spotter.HideCard then Spotter.HideCard() end
end

-- The reminder: only with the spotter on, enemy nameplates off, and on a zone change into a PvP
-- zone or while flagged. At most once per zone.
local PVP_ZONES = { combat = true, contested = true, hostile = true, arena = true }

function Spotter.CheckNameplates()
    if not OptionOn() then return end
    local okCvar, cvar = pcall(GetCVar, "nameplateShowEnemies")
    if not (okCvar and cvar == "0") then return end
    local okZone, pvpType = pcall(GetZonePVPInfo)
    local flagged = UnitIsPVP and UnitIsPVP("player")
    if not (flagged or (okZone and PVP_ZONES[pvpType])) then return end
    local zone = GetRealZoneText and GetRealZoneText() or ""
    if zone == lastHintZone then return end
    lastHintZone = zone
    -- name the player's own key for the enemy nameplates toggle (V by default), else the menu
    local how = "in Options, under Nameplates"
    local okKey, key = pcall(GetBindingKey, "NAMEPLATES")
    if okKey and type(key) == "string" and key ~= "" then
        local okText, text = pcall(GetBindingText, key)
        how = "press " .. ((okText and type(text) == "string" and text ~= "") and text or key)
    end
    local msg = "Enemy spotter: turn on enemy nameplates (" .. how .. "). "
        .. "Without them it only sees players you target or mouse over."
    Spotter.lastHint = msg
    print("|cff3fc7ebPathForever|r " .. msg)
end

local function Consider(unit, plate)
    if not (UnitExists and UnitExists(unit)) then return end
    if not (UnitIsPlayer and UnitIsPlayer(unit)) then return end
    if not (UnitCanAttack and UnitCanAttack("player", unit)) then return end
    if UnitIsDeadOrGhost and UnitIsDeadOrGhost(unit) then return end
    local ok, guid, level, name, _, class = pcall(function()
        local _, c = UnitClass(unit)
        return UnitGUID(unit), UnitLevel(unit), UnitName(unit), nil, c
    end)
    if not ok or type(guid) ~= "string" or issecret(guid) or type(level) ~= "number" or issecret(level) then return end
    Spotter.Feed(guid, name, level, class, plate)
end

local function Forget(unit)
    local ok, guid = pcall(UnitGUID, unit)
    if ok and type(guid) == "string" and not issecret(guid) then Spotter.Drop(guid) end
end

-- ---------- The strip and the list ----------

-- Puts a slide-out frame (the list or the card) beside the bar. off is how far it is still tucked
-- behind the bar.
local function Anchor(f, off)
    local db = SpotterDB()
    f:ClearAllPoints()
    if db and db.side == "RIGHT" then
        f:SetPoint("TOPRIGHT", frame, "TOPLEFT", off, 0)
    else
        f:SetPoint("TOPLEFT", frame, "TOPRIGHT", -off, 0)
    end
end

local function PositionFrame()
    local db = SpotterDB()
    local side = (db and db.side == "RIGHT") and "RIGHT" or "LEFT"
    local y = db and tonumber(db.y)
    if not y then
        local h = UIParent.GetHeight and UIParent:GetHeight() or 0
        y = -(h > 0 and h or 1000) * DEFAULT_Y_FRACTION
    end
    frame:ClearAllPoints()
    frame:SetPoint("TOP" .. side, UIParent, "TOP" .. side, 0, y)
    -- the coloured bar sits on the screen edge, the spare width on the inside
    frame.strip:ClearAllPoints()
    frame.count:ClearAllPoints()
    if side == "RIGHT" then
        frame.strip:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
        frame.strip:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
        frame.count:SetPoint("TOPLEFT", frame, "TOPLEFT", HIT_PAD, -14)
    else
        frame.strip:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        frame.strip:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
        frame.count:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -14)
    end
    Anchor(list, 0)
end

-- 0 to 1 over the slide, easing out
local function Ease(age)
    local p = age >= SLIDE and 1 or age / SLIDE
    return 1 - (1 - p) * (1 - p)
end

-- ---------- The card ----------

local function ClassName(class)
    if not class then return "" end
    local n = LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[class]
    return n or (class:sub(1, 1) .. class:sub(2):lower())
end

-- The click-to-target button. Created out of combat only (a secure frame cannot be made in combat);
-- the holder hides in combat by itself, and the button is only shown or placed out of combat.
local function EnsureSecure()
    if secureHolder then return true end
    if InCombatLockdown() then return false end
    secureHolder = CreateFrame("Frame", "PathForeverSpotterSecure", UIParent)
    secureHolder:SetFrameStrata("HIGH")
    RegisterStateDriver(secureHolder, "visibility", "[combat] hide; show")
    cardButton = CreateFrame("Button", "PathForeverSpotterTarget", secureHolder, "SecureActionButtonTemplate")
    cardButton:RegisterForClicks("AnyUp", "AnyDown")
    cardButton:SetAttribute("type", "macro")
    cardButton:HookScript("OnEnter", function(self)
        if not GameTooltip then return end
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("Click to target", Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
        GameTooltip:Show()
    end)
    cardButton:HookScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
    cardButton:HookScript("PostClick", function() Spotter.HideCard() end)
    cardButton:Hide()
    return true
end
Spotter.EnsureSecure = EnsureSecure

-- The button goes over the card once it has finished sliding, by screen position (never inside
-- the card: that frame would become protected).
local function PlaceButton()
    if InCombatLockdown() or not EnsureSecure() then return end
    local l, t = card:GetLeft(), card:GetTop()
    if not (l and t) then return end
    local s = card:GetEffectiveScale() / secureHolder:GetEffectiveScale()
    cardButton:ClearAllPoints()
    cardButton:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", l * s, t * s)
    cardButton:SetSize(CARD_W * s, CARD_H * s)
    cardButton:SetAttribute("macrotext", "/targetexact " .. card.name)
    cardButton:Show()
    card.placed = true
end

function Spotter.HideCard()
    if card then card:Hide(); card.placed = false; card.guid = nil end
    if cardButton and not InCombatLockdown() then cardButton:Hide() end
end

local function ShowCard(item)
    local c = COLORS[item.threat]
    card.guid, card.name, card.age, card.placed = item.guid, item.name, 0, false
    card.nameText:SetText(item.name)
    card.nameText:SetTextColor(c[1], c[2], c[3])
    local lv = item.level > 0 and tostring(item.level) or "??"
    card.sub:SetText("Lv " .. lv .. "  " .. ClassName(item.class))
    local tc = CLASS_ICON_TCOORDS and item.class and CLASS_ICON_TCOORDS[item.class]
    if tc then
        card.icon:SetTexCoord(tc[1], tc[2], tc[3], tc[4])
        card.icon:Show()
    else
        card.icon:Hide()
    end
    card:SetBackdropBorderColor(c[1], c[2], c[3], 0.9)
    Anchor(card, CARD_W + 12)
    card:SetAlpha(0)
    card:Show()
end

-- Called when a player comes into sight at ANNOUNCE_FROM or above.
function Spotter.Announce(e)
    local now = Now()
    if announcedAt[e.guid] and now - announcedAt[e.guid] < REANNOUNCE then return end
    announcedAt[e.guid] = now
    -- newest first: the card shows the most recent arrival
    local item = { guid = e.guid, name = e.name, level = e.level, class = e.class, threat = e.threat }
    table.insert(queue, 1, item)
    for i = #queue, QUEUE_MAX + 1, -1 do queue[i] = nil end
end

-- Runs every frame from the strip's OnUpdate.
function Spotter.TickCard(dt)
    if not card then return end
    if frame.hover or frame.dragging then
        if card:IsShown() then Spotter.HideCard() end
        return
    end
    if not card:IsShown() then
        if #queue > 0 then ShowCard(table.remove(queue, 1)) end
        return
    end
    local over = Over(card) -- the mouse on the card holds it
    if not (over and card.age >= SLIDE) then card.age = card.age + dt end
    local age = card.age
    local hold = #queue >= 1 and 1.5 or HOLD -- someone is waiting: move on sooner
    if age < SLIDE then
        local e = Ease(age)
        Anchor(card, (1 - e) * (CARD_W + 12))
        card:SetAlpha(e)
        return
    end
    if not card.placed then
        Anchor(card, 0)
        PlaceButton()
    end
    if age > hold + FADE then
        Spotter.HideCard()
    elseif age > hold then
        card:SetAlpha(1 - (age - hold) / FADE)
    else
        card:SetAlpha(1)
    end
end

local function CreateFrames()
    frame = CreateFrame("Frame", "PathForeverSpotterFrame", UIParent)
    frame:SetSize(FRAME_W, STRIP_H)
    frame:SetFrameStrata("MEDIUM")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame.strip = frame:CreateTexture(nil, "ARTWORK")
    frame.strip:SetWidth(STRIP_W)
    frame.strip:SetColorTexture(1, 1, 1, 1)
    frame.count = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.count:SetWidth(STRIP_W)
    frame.count:SetJustifyH("CENTER")

    list = CreateFrame("Frame", "PathForeverSpotterList", frame, "BackdropTemplate")
    list:SetSize(LIST_W, 40)
    list:SetFrameStrata("MEDIUM")
    Theme.StyleWindow(list)
    list.rows = {}
    for i = 1, MAX_ROWS + EXTRA_ROWS do
        local row = {}
        row.icon = list:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(14, 14)
        row.icon:SetPoint("TOPLEFT", list, "TOPLEFT", PAD, -(PAD - 1 + (i - 1) * ROW_H))
        row.icon:SetTexture(ICONS)
        row.text = list:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.text:SetPoint("TOPLEFT", list, "TOPLEFT", PAD + 19, -(PAD + (i - 1) * ROW_H))
        row.text:SetWidth(LIST_W - 2 * PAD - 19)
        row.text:SetJustifyH("LEFT")
        list.rows[i] = row
    end
    list:Hide()
    list.age = SLIDE

    card = CreateFrame("Frame", "PathForeverSpotterCard", frame, "BackdropTemplate")
    card:SetSize(CARD_W, CARD_H)
    card:SetFrameStrata("MEDIUM")
    Theme.StyleWindow(card)
    card.icon = card:CreateTexture(nil, "ARTWORK")
    card.icon:SetSize(24, 24)
    card.icon:SetPoint("TOPLEFT", card, "TOPLEFT", PAD, -8)
    card.icon:SetTexture(ICONS)
    card.nameText = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    card.nameText:SetPoint("TOPLEFT", card, "TOPLEFT", PAD + 30, -7)
    card.nameText:SetWidth(CARD_W - 2 * PAD - 30)
    card.nameText:SetJustifyH("LEFT")
    card.sub = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    card.sub:SetPoint("TOPLEFT", card, "TOPLEFT", PAD + 30, -23)
    card.sub:SetWidth(CARD_W - 2 * PAD - 30)
    card.sub:SetJustifyH("LEFT")
    card.age = 0
    card:Hide()

    frame:SetScript("OnDragStart", function(self) Spotter.HideCard(); self:StartMoving(); self.dragging = true end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        self.dragging = nil
        -- snap to the nearer edge and keep only the height
        local left, top = self:GetLeft(), self:GetTop()
        local db = SpotterDB()
        if left and top and db and UIParent.GetWidth and UIParent.GetHeight then
            local scale = self:GetEffectiveScale() / UIParent:GetEffectiveScale()
            db.side = (left * scale + FRAME_W / 2) < UIParent:GetWidth() / 2 and "LEFT" or "RIGHT"
            db.y = math.min(0, math.max(-(UIParent:GetHeight() - STRIP_H), top * scale - UIParent:GetHeight()))
        end
        PositionFrame()
    end)

    frame.tick = 0
    frame:SetScript("OnUpdate", function(self, elapsed)
        self.tick = self.tick + elapsed
        local now = Now()
        -- the pulse eases the strip's alpha up and down; it needs a smooth step, the rest a slow one
        if now < pulseUntil then
            local a = 0.65 + 0.35 * math.sin((pulseUntil - now) * 9)
            self.strip:SetAlpha(a)
        end
        if list:IsShown() and list.age < SLIDE then
            list.age = list.age + elapsed
            local e = Ease(list.age)
            Anchor(list, (1 - e) * (LIST_W + 12))
            list:SetAlpha(e)
        end
        local hover = Over(self) or (list:IsShown() and Over(list))
        if hover ~= self.hover and not self.dragging then
            self.hover = hover
            Spotter:Refresh()
        end
        Spotter.TickCard(elapsed)
        if self.tick < 0.5 then return end
        self.tick = 0
        Spotter:Refresh()
    end)
    PositionFrame()
    frame:Hide()
end

local function Wording(e)
    local lv = "?" -- not known yet
    if e.level then lv = e.level > 0 and tostring(e.level) or "??" end
    return "Lv " .. lv .. "  " .. e.name
end

function Spotter:Refresh()
    if not (frame and frame:IsShown()) then return end
    local now = Now()
    local mine = UnitLevel and UnitLevel("player") or 0
    for guid, e in pairs(entries) do
        if not e.plate and now - e.seen > EXPIRE then entries[guid] = nil end
    end
    for i = #shown, 1, -1 do shown[i] = nil end
    for i = #unknowns, 1, -1 do unknowns[i] = nil end
    local top, total = 0, 0
    for _, e in pairs(entries) do
        total = total + 1
        local t = Spotter.Threat(e.level, mine)
        e.threat = t
        if e.level == nil then
            unknowns[#unknowns + 1] = e -- counted and listed, but no card and no colour
        elseif t > 0 then
            shown[#shown + 1] = e
            if t > top then top = t end
            if t >= RED and not e.alerted then e.alerted = true; pulseUntil = now + PULSE end
            if t >= ANNOUNCE_FROM and not e.announced then e.announced = true; Spotter.Announce(e) end
        end
    end
    local low = total - #shown - #unknowns -- 10 or more levels below you: counted, not coloured
    table.sort(unknowns, function(a, b) return a.name < b.name end)
    table.sort(shown, function(a, b)
        if a.threat ~= b.threat then return a.threat > b.threat end
        if a.level ~= b.level then return a.level > b.level end
        return a.name < b.name
    end)
    frame.top = top

    -- The bar always carries the most dangerous colour nearby, and the number of enemy players.
    local strip = frame.strip
    if top > 0 then
        local c = COLORS[top]
        strip:SetColorTexture(c[1], c[2], c[3], 1)
        if now >= pulseUntil then strip:SetAlpha(1) end
    else
        strip:SetColorTexture(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3], 1)
        strip:SetAlpha(total > 0 and 0.6 or 0.35) -- only unknown or far-below players: dim, still counted
    end
    if total > 0 then
        frame.count:SetText(tostring(math.min(total, 99)))
        if top == RED then frame.count:SetTextColor(1, 1, 1) else frame.count:SetTextColor(0.04, 0.11, 0.19) end
    else
        frame.count:SetText("")
    end

    if not frame.hover then
        list:Hide()
        if frame:GetHeight() ~= STRIP_H then frame:SetHeight(STRIP_H) end
        return
    end
    local rows = list.rows
    for i = 1, MAX_ROWS + EXTRA_ROWS do rows[i].icon:Hide(); rows[i].text:SetText("") end
    local n = 0
    local function note(text)
        n = n + 1
        rows[n].text:SetText(text)
        rows[n].text:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    end
    local nData = #shown + #unknowns
    for i = 1, math.min(nData, MAX_ROWS) do
        local e = i <= #shown and shown[i] or unknowns[i - #shown]
        n = n + 1
        local row, c = rows[n], COLORS[e.threat] or Theme.MUTED
        row.text:SetText(Wording(e))
        row.text:SetTextColor(c[1], c[2], c[3])
        local tc = CLASS_ICON_TCOORDS and e.class and CLASS_ICON_TCOORDS[e.class]
        if tc then
            row.icon:SetTexCoord(tc[1], tc[2], tc[3], tc[4])
            row.icon:Show()
        end
    end
    if nData > MAX_ROWS then note("+" .. (nData - MAX_ROWS) .. " more") end
    if low > 0 then note(low .. " far below you") end
    if n == 0 then note("No enemy players") end
    local h = math.max(STRIP_H, 2 * PAD + n * ROW_H)
    list:SetHeight(h)
    frame:SetHeight(h) -- the bar grows to the list's height
    if not list:IsShown() then
        list.age = 0
        Anchor(list, LIST_W + 12)
        list:SetAlpha(0)
    end
    list:Show()
end

-- ---------- Showing it ----------

local events = CreateFrame("Frame")
Spotter.eventFrame = events -- (lets the tests drive it)

local EVENTS = { "NAME_PLATE_UNIT_ADDED", "NAME_PLATE_UNIT_REMOVED", "PLAYER_TARGET_CHANGED",
    "UPDATE_MOUSEOVER_UNIT", "PLAYER_ENTERING_WORLD", "PLAYER_REGEN_ENABLED", "ZONE_CHANGED_NEW_AREA" }

local function Apply()
    if OptionOn() then
        if not frame then CreateFrames() end
        EnsureSecure()
        for _, ev in ipairs(EVENTS) do events:RegisterEvent(ev) end
        if not frame:IsShown() then frame:Show() end
        Spotter:Refresh()
    else
        for _, ev in ipairs(EVENTS) do events:UnregisterEvent(ev) end
        Spotter.Clear()
        if frame and frame:IsShown() then frame:Hide() end
    end
end

function Spotter:IsShown() return frame ~= nil and frame:IsShown() end

-- The option's switch and /pf spotter come here.
function Spotter:SetEnabled(on)
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.enemySpotter = on and true or false
    Apply()
    if PF.RefreshUI then PF:RefreshUI() end
end

function Spotter:Toggle() self:SetEnabled(not OptionOn()) end

events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", function(_, event, unit)
    if event == "PLAYER_LOGIN" then
        Apply()
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        C_Timer.After(3, Spotter.CheckNameplates) -- the zone's PvP status is known a moment later
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        if unit then Consider(unit, true) end
    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        if unit then Forget(unit) end
    elseif event == "PLAYER_TARGET_CHANGED" then
        Consider("target")
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        Consider("mouseover")
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- a card that ended during combat could not hide its button then
        if cardButton and card and not card:IsShown() then cardButton:Hide() end
        if not cardButton and frame then EnsureSecure() end
    elseif event == "PLAYER_ENTERING_WORLD" then
        Spotter.Clear()
        Apply()
        C_Timer.After(3, Spotter.CheckNameplates)
    end
end)
