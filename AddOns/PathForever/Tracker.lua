-- Tracker.lua - the leveling tracker (PF.Tracker)
-- A small draggable window for power leveling, off by default (Options > Leveling tracker, or
-- /pf tracker). It counts from the moment it starts, reset by right-clicking it:
--   XP per hour, the time to the next level at that pace, the XP and kills so far,
--   gold per hour (only what you take in, so repairs and purchases don't drag it down) and
--   the session time. The title shows the level and how far into it you are.
--
-- XP comes from PLAYER_XP_UPDATE gains (a level-up wraps the bar, as in History.lua); gold from
-- PLAYER_MONEY rises. Forever's data arrives late after a login (docs/forever-client.md), so the
-- start values are read five seconds after entering the world, and nothing before that counts.
-- Nothing is read at logout. Nothing here is protected; showing our own frame is allowed in combat.
-- Text follows UI.lua's "How text is laid out": TOPLEFT anchors, an explicit width, never a height.

local PF = PathForever
local Tracker = {}
PF.Tracker = Tracker

local Theme = PF.Theme
local WIDTH = 196
local PAD = 10
local TEXT_W = WIDTH - 2 * PAD
local TITLE_H = 26
local ROW_H = 15
local LABEL_W = 96
local START_DELAY = 5       -- seconds after entering the world before the start values are read
local MIN_SECONDS = 60      -- rates need a minute of play to mean anything
local FADE_ALPHA = 0.45   -- the faded look's black fill
local ROWS = { "XP per hour", "Next level", "XP gained", "Kills", "Gold per hour", "Time" }

local window
local ready = false         -- the start values have been read
local startedAt = nil       -- GetTime() of the start
local lastXP, lastXPMax = nil, nil
local xpGained, kills, goldGained = 0, 0, 0
local lastMoney = nil

local function TrackerDB()
    local db = PathForeverDB
    if type(db) ~= "table" then return nil end
    if type(db.tracker) ~= "table" then db.tracker = {} end
    return db.tracker
end

local function OptionOn()
    return PathForeverDB ~= nil and PathForeverDB.options ~= nil and PathForeverDB.options.levelTracker == true
end

local function Now() return GetTime and GetTime() or 0 end

-- ---------- Counting ----------

local function ReadStart()
    lastXP = UnitXP and UnitXP("player") or nil
    lastXPMax = UnitXPMax and UnitXPMax("player") or nil
    lastMoney = GetMoney and GetMoney() or nil
    startedAt = Now()
    xpGained, kills, goldGained = 0, 0, 0
    ready = true
end

local function OnXP()
    if not (ready and UnitXP and UnitXPMax) then return end
    local xp, max = UnitXP("player"), UnitXPMax("player")
    if type(xp) ~= "number" then return end
    if lastXP then
        local gain
        if xp >= lastXP then gain = xp - lastXP else gain = (lastXPMax or 0) - lastXP + xp end -- a level-up wraps the bar
        if gain > 0 then xpGained = xpGained + gain end
    end
    lastXP, lastXPMax = xp, max
end

local function OnMoney()
    if not (ready and GetMoney) then return end
    local m = GetMoney()
    if type(m) ~= "number" then return end
    if lastMoney and m > lastMoney then goldGained = goldGained + (m - lastMoney) end
    lastMoney = m
end

-- A kill that gave experience: the combat log line "X dies, you gain N experience" arrives as
-- CHAT_MSG_COMBAT_XP_GAIN, and quest turn-ins don't send it.
local function OnKillXP()
    if ready then kills = kills + 1 end
end

function Tracker:Reset()
    if not ready then return end
    ReadStart()
    self:Refresh()
end

-- ---------- Wording ----------

local function Duration(secs)
    secs = math.floor(secs + 0.5)
    if secs >= 3600 then return string.format("%dh %02dm", math.floor(secs / 3600), math.floor((secs % 3600) / 60)) end
    if secs >= 60 then return string.format("%d min", math.floor(secs / 60)) end
    return secs .. " s"
end

local function Number(n)
    n = math.floor(n + 0.5)
    local s = tostring(n)
    while true do
        local replaced
        s, replaced = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if replaced == 0 then break end
    end
    return s
end

local function Gold(copper)
    if copper >= 10000 then return string.format("%.1fg", copper / 10000) end
    if copper >= 100 then return string.format("%ds", math.floor(copper / 100)) end
    return string.format("%dc", math.floor(copper))
end

local function AtMaxLevel()
    local cap = PathForeverData and PathForeverData.LevelCap
    return cap ~= nil and UnitLevel and UnitLevel("player") >= cap
end

-- ---------- The window ----------

local function PositionWindow(f)
    local db = TrackerDB()
    local p = db and db.point
    f:ClearAllPoints()
    if type(p) == "table" and type(p[1]) == "string" then
        f:SetPoint(p[1], UIParent, p[3] or p[1], tonumber(p[4]) or 0, tonumber(p[5]) or 0)
    else
        f:SetPoint("TOPLEFT", UIParent, "CENTER", 260, 200)
    end
end

local function CreateWindow()
    local f = CreateFrame("Frame", "PathForeverTrackerFrame", UIParent, "BackdropTemplate")
    f:SetSize(WIDTH, 100)
    PositionWindow(f)
    f:SetFrameStrata("MEDIUM")
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) self:Raise(); self.dragged = true; self:StartMoving() end)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        -- Kept by its top-left corner, so a change of height grows the window downwards.
        local left, top = self:GetLeft(), self:GetTop()
        local db = TrackerDB()
        if left and top then
            local scale = self:GetEffectiveScale() / UIParent:GetEffectiveScale()
            left, top = left * scale, top * scale
            self:ClearAllPoints()
            self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
            if db then db.point = { "TOPLEFT", "UIParent", "BOTTOMLEFT", left, top } end
        end
    end)
    Theme.StyleWindow(f)
    f.titleLine = { Theme.AddFadedLine(f, TITLE_H, 0, 0.4) }

    local logo = f:CreateTexture(nil, "ARTWORK")
    logo:SetSize(14, 14)
    logo:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -6)
    logo:SetTexture(PF.ICON)
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.title:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + 20, -7)
    f.title:SetWidth(TEXT_W - 20 - 22)
    f.title:SetJustifyH("LEFT")

    -- The x turns the option off, so the switch in Options always says what is on screen.
    local close = CreateFrame("Button", nil, f)
    close:SetSize(20, 20)
    close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -6, -4)
    local closeText = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    closeText:SetPoint("CENTER")
    closeText:SetText("\195\151")
    closeText:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    close:SetScript("OnClick", function()
        Tracker:SetEnabled(false)
        Theme.PlayUISound("IG_CHARACTER_INFO_CLOSE")
    end)
    close:SetScript("OnEnter", function() closeText:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    close:SetScript("OnLeave", function() closeText:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3]) end)
    f.close = close

    f.labels, f.values = {}, {}
    for i, name in ipairs(ROWS) do
        local label = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -(TITLE_H + 6 + (i - 1) * ROW_H))
        label:SetWidth(LABEL_W)
        label:SetJustifyH("LEFT")
        label:SetText(name)
        local value = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        value:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + LABEL_W, -(TITLE_H + 6 + (i - 1) * ROW_H))
        value:SetWidth(TEXT_W - LABEL_W)
        value:SetJustifyH("RIGHT")
        f.labels[i], f.values[i] = label, value
    end
    f:SetHeight(TITLE_H + 6 + #ROWS * ROW_H + 8)

    -- the faded look: a plain semi-transparent black fill, no border, logo or x
    f.fade = f:CreateTexture(nil, "BACKGROUND", nil, -6)
    f.fade:SetPoint("TOPLEFT", 1, -1)
    f.fade:SetPoint("BOTTOMRIGHT", -1, 1)
    f.fade:SetColorTexture(0, 0, 0, FADE_ALPHA)
    f.fade:Hide()
    f.logo = logo

    -- Double-click (two left clicks within 0.4 s that did not drag) swaps the two looks.
    f:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" then Tracker:Reset() return end
        if button ~= "LeftButton" then return end
        if self.dragged then self.dragged, self.lastClick = nil, nil return end
        local now = Now()
        if self.lastClick and now - self.lastClick < 0.4 then
            self.lastClick = nil
            Tracker:SetFaded(not Tracker:IsFaded())
        else
            self.lastClick = now
        end
    end)
    f:SetScript("OnEnter", function(self)
        if not GameTooltip then return end
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:AddLine("Leveling tracker", Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3])
        GameTooltip:AddLine("Double-click to fade it", Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
        GameTooltip:AddLine("Right-click to start over", Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
        GameTooltip:Show()
    end)
    f:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

    f.tick = 0
    f:SetScript("OnUpdate", function(self, elapsed)
        self.tick = self.tick + elapsed
        if self.tick < 1 then return end
        self.tick = 0
        Tracker:Refresh()
    end)
    f:Hide()
    return f
end

function Tracker:IsFaded()
    local db = TrackerDB()
    return db ~= nil and db.faded == true
end

-- Swaps the window between its two looks. The size never changes, so nothing moves.
local function ApplyLook()
    local f = window
    if not f then return end
    local faded = Tracker:IsFaded()
    local ar, ag, ab = Theme.GetAccentColor()
    local function show(tex, on) if tex then if on then tex:Show() else tex:Hide() end end end
    show(f.pfBg, not faded)
    show(f.pfTexture, not faded)
    for _, t in ipairs(f.pfCorners or {}) do show(t, not faded) end
    for _, t in ipairs(f.pfVignette or {}) do show(t, not faded) end
    for _, t in ipairs(f.titleLine) do show(t, not faded) end
    f:SetBackdropBorderColor(ar, ag, ab, faded and 0 or 0.55)
    show(f.fade, faded)
    show(f.logo, not faded)
    if faded then f.close:Hide() else f.close:Show() end
end

function Tracker:SetFaded(on)
    local db = TrackerDB()
    if db then db.faded = on and true or false end
    ApplyLook()
    self:Refresh()
end

function Tracker:Refresh()
    if not (window and window:IsShown()) then return end
    local ar, ag, ab = Theme.GetAccentColor()
    for _, label in ipairs(window.labels) do label:SetTextColor(ar, ag, ab) end
    local v = window.values
    local level = UnitLevel and UnitLevel("player") or 0
    local xp, max = UnitXP and UnitXP("player"), UnitXPMax and UnitXPMax("player")
    if type(xp) == "number" and type(max) == "number" and max > 0 and not AtMaxLevel() then
        window.title:SetText(string.format("Lv %d - %d%%", level, math.floor(xp / max * 100)))
    else
        window.title:SetText("Lv " .. level)
    end
    window.title:SetTextColor(ar, ag, ab)
    if not ready then
        for i = 1, #ROWS do v[i]:SetText("") end
        v[1]:SetText("Starting...")
        return
    end
    local secs = Now() - startedAt
    local hours = secs / 3600
    local enough = secs >= MIN_SECONDS
    local atMax = AtMaxLevel()
    if atMax then
        v[1]:SetText("Max level")
        v[2]:SetText("-")
        v[3]:SetText("-")
        v[4]:SetText("-")
    else
        v[1]:SetText((enough and xpGained > 0) and Number(xpGained / hours) or "-")
        if enough and xpGained > 0 and type(xp) == "number" and type(max) == "number" and max > xp then
            v[2]:SetText(Duration((max - xp) / (xpGained / secs)))
        else
            v[2]:SetText("-")
        end
        v[3]:SetText(Number(xpGained))
        v[4]:SetText(tostring(kills))
    end
    v[5]:SetText(enough and Gold(goldGained / hours) or "-")
    v[6]:SetText(Duration(secs))
    -- the text stays in full colour in both looks; faded, the values are gold too
    for i = 1, #ROWS do
        if Tracker:IsFaded() then v[i]:SetTextColor(ar, ag, ab) else v[i]:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end
    end
end

-- ---------- Showing it ----------

local function Apply()
    if OptionOn() then
        if not window then window = CreateWindow(); ApplyLook() end
        if not window:IsShown() then window:Show() end
        Tracker:Refresh()
    elseif window and window:IsShown() then
        window:Hide()
    end
end

function Tracker:IsShown() return window ~= nil and window:IsShown() end

-- The option's switch, the window's x and /pf tracker all come here.
function Tracker:SetEnabled(on)
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.levelTracker = on and true or false
    -- (counting never depends on the option: turning it off and on again only hides and shows the window)
    Apply()
    if PF.RefreshUI then PF:RefreshUI() end
end

function Tracker:Toggle() self:SetEnabled(not OptionOn()) end

-- ---------- Events ----------

local events = CreateFrame("Frame")
Tracker.eventFrame = events -- (lets the tests drive it)
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_XP_UPDATE")
events:RegisterEvent("PLAYER_MONEY")
events:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
events:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_ENTERING_WORLD" then
        if not ready then
            -- the first entry: wait for the character's data to arrive, then start counting
            C_Timer.After(START_DELAY, function()
                if not ready then ReadStart() end
                Apply()
            end)
        end
        Apply()
    elseif event == "PLAYER_XP_UPDATE" then
        OnXP()
    elseif event == "PLAYER_MONEY" then
        OnMoney()
    elseif event == "CHAT_MSG_COMBAT_XP_GAIN" then
        OnKillXP()
    end
end)
