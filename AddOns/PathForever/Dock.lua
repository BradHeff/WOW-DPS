-- PathForever: the dock icon.
--
-- While the window is closed a small icon of the logo sits on the screen (the "Minimize to
-- an icon" option, on by default): drag it anywhere, click it to open the window. Closing the
-- window shrinks it into the icon. Its place is saved in PathForeverDB.options.dockPoint;
-- with none saved it sits on the left edge of the screen.
--
-- Plain frames only, nothing protected. Step(dt) is the shrink, public for tests.

local PF = PathForever
local Dock = {}
PF.Dock = Dock

local SIZE = 38
local DURATION = 0.22
local END_SCALE = 0.08

local button, anim, driver

local function Enabled()
    local o = PathForeverDB and PathForeverDB.options
    return not (o and o.dockIcon == false)
end
Dock.Enabled = Enabled

local function Slides()
    local o = PathForeverDB and PathForeverDB.options
    return not (o and o.slidePopouts == false)
end

local function Place()
    button:ClearAllPoints()
    local o = PathForeverDB and PathForeverDB.options
    local p = o and o.dockPoint
    if type(p) == "table" and type(p[1]) == "string" and tonumber(p[2]) and tonumber(p[3]) then
        button:SetPoint(p[1], UIParent, p[1], p[2], p[3])
    else
        button:SetPoint("LEFT", UIParent, "LEFT", 16, 0)
    end
end

local function MainFrame() return _G.PathForeverFrame end

-- Shown while the window is closed (and the option is on).
function Dock:Update()
    if not button then return end
    local main = MainFrame()
    button:SetShown(Enabled() and not (main and main:IsShown()))
end

function Dock:Create()
    if button then return button end
    local T = PF.Theme
    local ar, ag, ab = T.GetAccentColor()
    button = CreateFrame("Button", "PathForeverDock", UIParent, "BackdropTemplate")
    button:SetSize(SIZE, SIZE)
    button:SetFrameStrata("MEDIUM")
    button:SetToplevel(true)
    button:SetMovable(true)
    button:SetClampedToScreen(true)
    button:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
    local nf = T.NAVY_FILL or { 0.04, 0.09, 0.15 }
    button:SetBackdropColor(nf[1], nf[2], nf[3], 0.92)
    button:SetBackdropBorderColor(ar, ag, ab, 0.55)
    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetPoint("TOPLEFT", 4, -4)
    button.icon:SetPoint("BOTTOMRIGHT", -4, 4)
    button.icon:SetTexture(PF.ICON)
    if T.CreateGlow then button.glow = T.CreateGlow(button, "BOTTOM", 0.3, "BACKGROUND", 1) end

    button:RegisterForDrag("LeftButton")
    button:SetScript("OnDragStart", function(self)
        self.dragging = true
        self:StartMoving()
    end)
    button:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        self.dragging = nil
        local point, _, _, x, y = self:GetPoint()
        PathForeverDB.options = PathForeverDB.options or {}
        PathForeverDB.options.dockPoint = { point, x, y }
    end)
    button:SetScript("OnClick", function(self)
        if self.dragging then return end
        T.PlayUISound("IG_CHARACTER_INFO_OPEN")
        PF:ToggleUI()
    end)
    button:SetScript("OnEnter", function(self)
        if self.glow then self.glow:Show() end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("PathForever")
        GameTooltip:AddLine("Click to open. Drag to move.", 0.6, 0.6, 0.6, true)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function(self)
        if self.glow then self.glow:Hide() end
        GameTooltip:Hide()
    end)
    Place()
    Dock:Update()
    return button
end

-- Keeps the icon in step with the window it stands in for.
function Dock:Hook(main)
    main:HookScript("OnShow", function() Dock:Update() end)
    main:HookScript("OnHide", function() Dock:Update() end)
end

local function Smooth(t) return t * t * (3 - 2 * t) end

-- The icon is the window's anchor: the window opens with the sidebar's top left corner on the
-- icon's top left corner (the sidebar hangs SIDEBAR_OFFSET left of the window), growing out
-- of it, and moving the window moves the icon to match. So the window never reopens where it
-- was closed, but where the icon is.
local SIDEBAR_OFFSET = 131 -- Sidebar.WIDTH - 1

local function ScreenSize()
    return (UIParent:GetWidth() or 1920), (UIParent:GetHeight() or 1080)
end

local function Finish()
    local a = anim
    anim = nil
    if driver then driver:SetScript("OnUpdate", nil) end
    local f = a.f
    f:SetScale(a.scale)
    f:SetAlpha(1)
    f:ClearAllPoints()
    f:SetPoint(unpack(a.finalPoint))
    if a.closing then f:Hide() end -- its OnHide shows the icon
    button:SetAlpha(1)
    Dock:Update()
end

-- One step of the shrink or growth, `dt` seconds. Returns true while it is still running.
function Dock:Step(dt)
    local a = anim
    if not a then return false end
    a.t = math.min(1, a.t + math.min(dt, 0.05) / DURATION)
    local e = Smooth(a.t)
    local s = a.s0 + (a.s1 - a.s0) * e
    local cx, cy = a.x0 + (a.x1 - a.x0) * e, a.y0 + (a.y1 - a.y0) * e
    a.f:SetScale(s)
    a.f:SetAlpha(a.a0 + (a.a1 - a.a0) * e)
    a.f:ClearAllPoints()
    -- offsets are in the frame's own (scaled) units
    a.f:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cx / s, cy / s)
    if a.t >= 1 then
        Finish()
        return false
    end
    return true
end

function Dock:IsMinimizing() return anim ~= nil and anim.closing end
function Dock:IsAnimating() return anim ~= nil end

local function Run()
    driver = driver or CreateFrame("Frame")
    driver:SetScript("OnUpdate", function(_, elapsed) Dock:Step(elapsed or 0) end)
end

-- Closes `f` by shrinking it into the icon. Returns false when that isn't happening (option
-- off, no animation wanted, the geometry unknown), and the caller hides the window itself.
function Dock:Minimize(f)
    if anim then return anim.closing end
    if not (Enabled() and f:IsShown()) then return false end
    if not button then Dock:Create() end
    if not Slides() then return false end
    -- the icon needs a place to be measured: it is there, but see-through, until the end
    button:SetAlpha(0)
    button:Show()
    local fx, fy = f:GetCenter()
    local bx, by = button:GetCenter()
    if not (fx and fy and bx and by) then
        button:SetAlpha(1)
        Dock:Update()
        return false
    end
    local p1, rel, p2, x, y = f:GetPoint()
    local scale = f:GetScale() or 1
    anim = { f = f, closing = true, t = 0, scale = scale, finalPoint = { p1, rel, p2, x, y },
             x0 = fx, y0 = fy, x1 = bx, y1 = by, s0 = scale, s1 = END_SCALE, a0 = 1, a1 = 0 }
    Run()
    return true
end

-- Opens `f` (hidden now) out of the icon: anchors it to the icon, shows it, and grows it.
-- Returns false when the icon isn't in use, and the caller shows the window itself.
function Dock:Open(f)
    if anim then Finish() end -- a shrink still running ends at once
    if f:IsShown() or not Enabled() or not button then return false end
    local left, top = button:GetLeft(), button:GetTop()
    if not (left and top) then return false end
    local sw, sh = ScreenSize()
    local w, h = f:GetWidth() or 420, f:GetHeight() or 500
    -- keep the window on the screen when the icon is near an edge
    local x = math.max(SIDEBAR_OFFSET, math.min(left + SIDEBAR_OFFSET, sw - w - 20))
    local y = math.max(h, math.min(top, sh))
    local bx, by = left + SIZE / 2, top - SIZE / 2
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
    PathForeverDB.point = { "TOPLEFT", "UIParent", "BOTTOMLEFT", x, y }
    f:Show() -- its OnShow hides the icon
    if not Slides() then return true end
    local scale = f:GetScale() or 1
    anim = { f = f, closing = false, t = 0, scale = scale, finalPoint = { "TOPLEFT", UIParent, "BOTTOMLEFT", x, y },
             x0 = bx, y0 = by, x1 = x + w / 2, y1 = y - h / 2, s0 = END_SCALE, s1 = scale, a0 = 0, a1 = 1 }
    -- Not shrunk yet: the caller lays the window out right after this, at full size (text laid
    -- out at a tiny scale came out too tall). It is invisible until the first step, next frame.
    f:SetAlpha(0)
    Run()
    return true
end

-- Called when the window has been moved: the icon goes to the window's place.
function Dock:SyncToWindow(f)
    local left, top = f:GetLeft(), f:GetTop()
    if not (left and top) then return end
    local _, sh = ScreenSize()
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.dockPoint = { "TOPLEFT", left - SIDEBAR_OFFSET, top - sh }
    if button then Place() end
end

local waiter = CreateFrame("Frame")
waiter:RegisterEvent("PLAYER_LOGIN")
waiter:SetScript("OnEvent", function() Dock:Create() end)
