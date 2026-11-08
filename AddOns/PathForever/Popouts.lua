-- PathForever: the popouts.
--
-- Windows open outward from the main window, one beyond the other:
--
--     sidebar | core window | popout 1 | popout 2 ...
--
-- A level is a clipping slot to the right of the one before it (the first sits beside the
-- main window), holding one panel at a time: the quest and boss side panel and the
-- Journey's small windows share level 1 and take turns. A slot's width slides between 0
-- and its panel's width, so a panel slides out from behind its neighbour. A
-- chevron inside the popout, on its left edge, closes it and everything beyond it with the
-- same slide. With "Slide popouts" off in Options the slots jump.
--
-- Plain frames only, nothing protected. Panels call Attach once; showing and hiding them
-- is theirs (OnShow and OnHide are hooked). Step(dt) is the animation, public for tests.

local PF = PathForever
local Popouts = {}
PF.Popouts = Popouts

local GAP = 18        -- between one window and the next
local CHEVRON_W, CHEVRON_H = 14, 48
local DURATION = 0.2  -- seconds for a slot to open or close
Popouts.GAP = GAP

local main
local levels = {}
local driver

local function Slides()
    local o = PathForeverDB and PathForeverDB.options
    return not (o and o.slidePopouts == false)
end

local function Theme() return PF.Theme end

-- The chevron sits inside the popout, on its left edge, centered; a click closes the
-- popout (and any beyond it) with the slide.
local function MakeChevron(level, panel)
    local T = Theme()
    local e = CreateFrame("Button", nil, panel)
    e:SetSize(CHEVRON_W, CHEVRON_H)
    e:SetPoint("LEFT", panel, "LEFT", 1, 0)
    e:SetFrameLevel(panel:GetFrameLevel() + 10)
    e.glyph = e:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    e.glyph:SetPoint("CENTER", 0, 0)
    e.glyph:SetText("<")
    e.glyph:SetTextColor(unpack(T.MUTED))
    e:SetScript("OnEnter", function(self) self.glyph:SetTextColor(T.GetAccentColor()) end)
    e:SetScript("OnLeave", function(self) self.glyph:SetTextColor(unpack(Theme().MUTED)) end)
    e:SetScript("OnClick", function()
        Theme().PlayUISound("IG_CHARACTER_INFO_TAB")
        Popouts:Close(level)
    end)
    panel.chevron = e
    return e
end

local function Level(n)
    local L = levels[n]
    if L then return L end
    assert(main, "Popouts: no main window yet")
    L = { panels = {}, width = 0, target = 0 }
    local anchor = n == 1 and main or Level(n - 1).slot
    L.slot = CreateFrame("Frame", nil, main)
    L.slot:SetPoint("TOPLEFT", anchor, "TOPRIGHT", GAP, 0)
    L.slot:SetPoint("BOTTOMLEFT", anchor, "BOTTOMRIGHT", GAP, 0)
    L.slot:SetWidth(1)
    L.slot:SetFrameLevel(main:GetFrameLevel() + 2)
    if L.slot.SetClipsChildren then pcall(L.slot.SetClipsChildren, L.slot, true) end
    -- never hidden: a hidden parent stops its child's OnShow from firing in the client
    levels[n] = L
    return L
end

local function Shown(L)
    for panel in pairs(L.panels) do
        if panel:IsShown() then return panel end
    end
end

local function SetWidthNow(L, w)
    L.width = w
    L.slot:SetWidth(math.max(w, 1))
    -- the slot is never hidden (see Level), so a shut one is invisible instead: no sliver of
    -- the panel's edge is left behind
    L.slot:SetAlpha(w > 1 and 1 or 0)
end

-- A new target starts a fresh tween from where the slot is now.
local function SetTarget(L, v)
    if L.target ~= v then
        L.target = v
        L.from, L.t = L.width, 0
    end
end

local function Apply(n)
    local L = levels[n]
    if not L then return end
    local panel = Shown(L)
    L.current = panel
    if not panel then
        L.closing = false
        L.target = 0
        SetWidthNow(L, 0)
    else
        SetTarget(L, L.closing and 0 or L.panels[panel])
        if not Slides() then SetWidthNow(L, L.target) end
    end
    Popouts:Wake()
end

local function Finish(L)
    local panel = L.current
    L.closing = false
    if not panel then return end
    if panel.onPopoutClose then panel.onPopoutClose() else panel:Hide() end
end

-- Registers `panel` (a frame) to show at `level` with the given width. Calling it again for
-- the same panel does nothing.
function Popouts:Attach(level, panel, width)
    local L = Level(level)
    if L.panels[panel] then
        L.panels[panel] = width
        return
    end
    L.panels[panel] = width
    panel:SetParent(L.slot)
    panel:SetFrameLevel(L.slot:GetFrameLevel() + 1)
    panel:ClearAllPoints()
    panel:SetPoint("TOPRIGHT", L.slot, "TOPRIGHT", 0, 0)
    panel:SetPoint("BOTTOMRIGHT", L.slot, "BOTTOMRIGHT", 0, 0)
    panel:SetWidth(width)
    MakeChevron(level, panel)
    panel:HookScript("OnShow", function()
        L.closing = false
        Apply(level)
    end)
    panel:HookScript("OnHide", function() Apply(level) end)
    if panel:IsShown() then Apply(level) end
end

function Popouts:Init(frame)
    main = frame
end

-- Closes the level and every one beyond it: they slide shut, then their panels are hidden
-- (through the panel's onPopoutClose when it has one, so its own state is reset too).
function Popouts:Close(level)
    local slides = Slides()
    for n, L in pairs(levels) do
        if n >= level and L.current then
            L.closing = true
            SetTarget(L, 0)
        end
    end
    if not slides then
        local todo = {}
        for n, L in pairs(levels) do
            if n >= level and L.closing then todo[#todo + 1] = L end
        end
        for _, L in ipairs(todo) do SetWidthNow(L, 0); Finish(L) end
        return
    end
    Popouts:Wake()
end

-- Closes the level `panel` is attached to, with the slide (what the chevron does). Returns
-- false when the panel is not in a level, and the caller hides it itself.
function Popouts:ClosePanel(panel)
    for n, L in pairs(levels) do
        if L.panels[panel] and L.current == panel then
            Popouts:Close(n)
            return true
        end
    end
    return false
end

-- The farthest level with a panel showing and not already closing, or nil.
function Popouts:Outermost()
    local best
    for n, L in pairs(levels) do
        if L.current and not L.closing and (not best or n > best) then best = n end
    end
    return best
end

function Popouts:IsOpen(level)
    local L = levels[level]
    return L ~= nil and L.current ~= nil and not L.closing
end

function Popouts:GetWidth(level)
    local L = levels[level]
    return L and L.width or 0
end

-- One animation step of `dt` seconds. Returns true while anything is still moving.
function Popouts:Step(dt)
    local moving = false
    local toFinish = {}
    for _, L in pairs(levels) do
        if L.width ~= L.target then
            -- eased (smoothstep) over DURATION; a long frame can't jump the slide
            L.t = math.min(1, (L.t or 0) + math.min(dt, 0.05) / DURATION)
            local e = L.t * L.t * (3 - 2 * L.t)
            SetWidthNow(L, L.t >= 1 and L.target or (L.from or 0) + (L.target - (L.from or 0)) * e)
            if L.width ~= L.target then moving = true
            elseif L.closing then toFinish[#toFinish + 1] = L end
        elseif L.closing then
            toFinish[#toFinish + 1] = L
        end
    end
    for _, L in ipairs(toFinish) do Finish(L) end
    return moving
end

-- The driver runs only while a slot is moving.
function Popouts:Wake()
    local moving = false
    for _, L in pairs(levels) do
        if L.width ~= L.target then moving = true end
    end
    if not moving then
        if driver and driver:GetScript("OnUpdate") then driver:SetScript("OnUpdate", nil) end
        return
    end
    if not Slides() then
        for _, L in pairs(levels) do SetWidthNow(L, L.target) end
        return
    end
    if not driver then
        driver = CreateFrame("Frame")
    end
    if not driver:GetScript("OnUpdate") then
        driver:SetScript("OnUpdate", function(_, elapsed)
            if not Popouts:Step(elapsed or 0) then driver:SetScript("OnUpdate", nil) end
        end)
    end
end
