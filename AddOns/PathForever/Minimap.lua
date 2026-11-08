-- Minimap.lua
-- A small, dependency-free minimap button. Deliberately plain: no badges,
-- no notifications, no pings - just an icon that opens and closes the
-- main window, since the earlier notification system was removed at your
-- request for being too intrusive. This is a different, lower-risk
-- feature: it does nothing on its own until you click it.

local PF = PathForever

local button = CreateFrame("Button", "PathForeverMinimapButton", Minimap)
button:SetSize(31, 31)
button:SetFrameStrata("MEDIUM")
button:SetFrameLevel(8)
button:RegisterForClicks("LeftButtonUp")
button:RegisterForDrag("LeftButton")

local icon = button:CreateTexture(nil, "BACKGROUND")
icon:SetSize(20, 20)
icon:SetPoint("CENTER")
icon:SetTexture(PF.ICON) -- also the AddOns-list icon: ## IconTexture in the TOC

local border = button:CreateTexture(nil, "OVERLAY")
border:SetSize(54, 54)
border:SetPoint("TOPLEFT")
border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

local function UpdatePosition()
    local angle = math.rad(PathForeverDB and PathForeverDB.minimapAngle or 215)
    local dx, dy = math.cos(angle), math.sin(angle)
    -- The button's centre sits on the map's edge: its rim, plus 10 for the button's own
    -- border. A square minimap (other addons make them) is followed round its corners.
    local half = ((Minimap.GetWidth and Minimap:GetWidth()) or 140) / 2
    local halfH = ((Minimap.GetHeight and Minimap:GetHeight()) or 140) / 2
    if not (half > 0) then half = 70 end
    if not (halfH > 0) then halfH = half end
    local square = false
    if GetMinimapShape then
        local ok, shape = pcall(GetMinimapShape)
        square = ok and shape == "SQUARE"
    end
    local x, y
    if square then
        local scale = math.min(half / math.max(math.abs(dx), 0.0001), halfH / math.max(math.abs(dy), 0.0001))
        x, y = dx * scale, dy * scale
    else
        x, y = dx * half, dy * halfH
    end
    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", x + dx * 10, y + dy * 10)
end

button:SetScript("OnDragStart", function(self)
    self:SetScript("OnUpdate", function()
        local mx, my = Minimap:GetCenter()
        local px, py = GetCursorPosition()
        local scale = Minimap:GetEffectiveScale()
        px, py = px / scale, py / scale
        local angle = math.deg(math.atan2(py - my, px - mx))
        if PathForeverDB then PathForeverDB.minimapAngle = angle end
        UpdatePosition()
    end)
end)

button:SetScript("OnDragStop", function(self)
    self:SetScript("OnUpdate", nil)
end)

button:SetScript("OnClick", function()
    if PF.ToggleUI then PF:ToggleUI() end
end)

button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("PathForever")
    GameTooltip:AddLine("Click to open your leveling planner.", 0.6, 0.6, 0.6, true)
    GameTooltip:Show()
end)
button:SetScript("OnLeave", function() GameTooltip:Hide() end)

-- Shown unless the "Show minimap button" option is off. The window still
-- opens with /pf. The button is our own plain frame, so this is safe in combat.
function PF:UpdateMinimapButton()
    local options = PathForeverDB and PathForeverDB.options
    if options and options.showMinimap == false then
        button:Hide()
    else
        UpdatePosition()
        button:Show()
    end
end

-- Position needs SavedVariables loaded, so wait for that rather than
-- reading PathForeverDB at file-load time (it may not exist yet).
local waiter = CreateFrame("Frame")
waiter:RegisterEvent("PLAYER_LOGIN")
waiter:SetScript("OnEvent", function()
    PF:UpdateMinimapButton()
end)
