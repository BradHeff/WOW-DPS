-- PathForever: the sidebar.
--
-- The feature list down the left side of the main window, in place of the old row of
-- tabs. A page entry switches the window's page (the same names the tabs had, kept in
-- UI.lua's tabButtons so RefreshUI and the tests work unchanged; Skills, Class quests and
-- Zones are Journey modules drawn as pages); an action entry opens something that isn't a
-- page (the Fishing and Camping windows).
--
-- The sidebar is a frame of its own, a child of the main window hanging off its left
-- edge, so the window's content (420 wide) and everything laid out against it stay as
-- they were. It overlaps the window's border by a pixel, so the two read as one window.
-- Plain frames only, nothing protected.

local PF = PathForever
local Sidebar = {}
PF.Sidebar = Sidebar

local WIDTH = 132
local ROW_H = 21
local TOP_H = 50
Sidebar.WIDTH = WIDTH

-- { header, { entries } }. `page` is a tab name (UI.lua's tabButtons), `action` a key in ACTIONS.
local SECTIONS = {
    { nil, {
        { page = "Journey", label = "Journey" },
        { page = "Discover", label = "Discover" },
    } },
    { "ADVENTURE", {
        { page = "Dungeons", label = "Dungeons" },
        { page = "History", label = "History" },
        { page = "Raids", label = "Raids" },
        { page = "PvP", label = "PvP" },
        { page = "Upgrades", label = "Upgrades" },
        { page = "Wishlist", label = "Wishlist" },
        { page = "Zones", label = "Zones" },
    } },
    { "CHARACTER", {
        { page = "Skills", label = "Skills" },
        { page = "ClassQuests", label = "Class quests" },
        { page = "Professions", label = "Professions" },
        { page = "Reputations", label = "Reputations" },
        { page = "Bank", label = "Bank" },
        { page = "Gold", label = "Gold" },
        { page = "XP", label = "XP" },
    } },
    { "TOOLS", {
        { action = "fishing", label = "Fishing", module = "Fishing" },
        { action = "camping", label = "Camping", module = "Camping" },
    } },
}
local OPTIONS = { page = "Options", label = "Options" }

local ACTIONS = {
    fishing = function() if PF.Fishing and PF.Fishing.Toggle then PF.Fishing:Toggle() end end,
    camping = function() if PF.Camping and PF.Camping.Toggle then PF.Camping:Toggle() end end,
}

local function Entry(sb, entry, y, tabButtons, pick)
    local T = PF.Theme
    local btn = CreateFrame("Button", nil, sb)
    btn:SetPoint("TOPLEFT", sb, "TOPLEFT", 1, -y)
    btn:SetSize(WIDTH - 2, ROW_H)

    -- the selected entry: a faint wash and a small gold dot left of its name (no thick bar); hovering another
    -- brightens its word and washes it lighter (flat textures, never an animated gradient)
    btn.glow = btn:CreateTexture(nil, "BACKGROUND")
    btn.glow:SetAllPoints()
    btn.glow:Hide()
    btn.hoverGlow = btn:CreateTexture(nil, "BACKGROUND")
    btn.hoverGlow:SetAllPoints()
    btn.hoverGlow:SetColorTexture(1, 1, 1, 0.045)
    btn.hoverGlow:Hide()
    btn.marker = btn:CreateTexture(nil, "ARTWORK")
    btn.marker:SetSize(4, 4)
    btn.marker:SetPoint("LEFT", btn, "LEFT", 9, 0)
    btn.marker:Hide()

    btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    btn.text:SetPoint("LEFT", btn, "LEFT", 20, 0)
    btn.text:SetWidth(WIDTH - 34)
    btn.text:SetJustifyH("LEFT")
    btn.text:SetText(entry.label)
    btn.text:SetTextColor(unpack(T.MUTED))

    local ar, ag, ab = T.GetAccentColor()
    btn.glow:SetColorTexture(ar, ag, ab, 0.14)

    btn:SetScript("OnEnter", function(self)
        if not self.active then
            self.text:SetTextColor(0.78, 0.78, 0.80)
            self.hoverGlow:Show()
        end
    end)
    btn:SetScript("OnLeave", function(self)
        self.hoverGlow:Hide()
        if not self.active then self.text:SetTextColor(unpack(T.MUTED)) end
    end)
    if entry.page then
        btn.page = entry.page
        btn:SetScript("OnClick", function() pick(entry.page) end)
        tabButtons[entry.page] = btn
    else
        btn.action = entry.action
        btn:SetScript("OnClick", function()
            T.PlayUISound("IG_CHARACTER_INFO_TAB")
            local run = ACTIONS[entry.action]
            if run then run() end
        end)
    end
    return btn
end

-- Builds the sidebar on `parent` (the main window). `tabButtons` is filled with one
-- button per page; `pick(pageName)` switches to it. Returns the sidebar frame.
function Sidebar:Create(parent, tabButtons, pick)
    local T = PF.Theme
    local sb = CreateFrame("Frame", "PathForeverSidebar", parent, "BackdropTemplate")
    sb:SetWidth(WIDTH)
    sb:SetPoint("TOPRIGHT", parent, "TOPLEFT", 1, 0)
    sb:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", 1, 0)
    T.StyleWindow(sb)
    sb:EnableMouse(true)

    -- the logo and name, which also move the window
    local head = CreateFrame("Frame", nil, sb)
    head:SetPoint("TOPLEFT", 0, 0)
    head:SetPoint("TOPRIGHT", 0, 0)
    head:SetHeight(TOP_H)
    head:EnableMouse(true)
    head:RegisterForDrag("LeftButton")
    local dragged
    local function DragStart()
        dragged = true
        parent:Raise()
        parent:StartMoving()
    end
    local function DragStop()
        parent:StopMovingOrSizing()
        local point, _, _, x, y = parent:GetPoint()
        PathForeverDB.point = { point, "UIParent", point, x, y }
        if PF.Dock then PF.Dock:SyncToWindow(parent) end -- the icon goes where the window is
        -- the click that ends a drag is not a click on the logo; the flag must not outlive it
        C_Timer.After(0.1, function() dragged = nil end)
    end
    head:SetScript("OnDragStart", DragStart)
    head:SetScript("OnDragStop", DragStop)
    local icon = head:CreateTexture(nil, "ARTWORK")
    icon:SetSize(26, 26)
    icon:SetPoint("TOPLEFT", 12, -12)
    icon:SetTexture(PF.ICON)
    -- the logo is the dock icon's twin: clicking it minimizes the window (it still drags it)
    local logo = CreateFrame("Button", nil, head)
    logo:SetAllPoints(icon)
    logo:RegisterForDrag("LeftButton")
    logo:SetScript("OnDragStart", DragStart)
    logo:SetScript("OnDragStop", DragStop)
    logo:SetScript("OnClick", function()
        if dragged then dragged = nil return end
        T.PlayUISound("IG_CHARACTER_INFO_TAB")
        PF:CloseUI()
    end)
    logo:SetScript("OnEnter", function(self)
        icon:SetVertexColor(1.25, 1.2, 1.05)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Minimize")
        GameTooltip:Show()
    end)
    logo:SetScript("OnLeave", function()
        icon:SetVertexColor(1, 1, 1)
        GameTooltip:Hide()
    end)
    sb.logoButton = logo
    local title = head:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", icon, "RIGHT", 7, 0)
    title:SetWidth(WIDTH - 52)
    title:SetJustifyH("LEFT")
    title:SetText("PathForever")
    title:SetTextColor(unpack(T.TEXT))
    sb.title = title
    sb.titleLine = { T.AddFadedLine(sb, TOP_H, 0, 0.45) }

    sb.entries = {}
    local y = TOP_H + 8
    for _, section in ipairs(SECTIONS) do
        -- a tool whose addon is turned off (PathForever Fishing, PathForever Camping) has no entry,
        -- and a section left with none has no header
        local shown = {}
        for _, entry in ipairs(section[2]) do
            if not entry.module or PF[entry.module] then shown[#shown + 1] = entry end
        end
        if #shown > 0 and section[1] then
            y = y + 4
            local label = sb:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            label:SetPoint("TOPLEFT", sb, "TOPLEFT", 12, -y)
            label:SetJustifyH("LEFT")
            label:SetText(section[1])
            label:SetTextColor(0.33, 0.37, 0.43)
            y = y + (label:GetStringHeight() or 10) + 5
        end
        for _, entry in ipairs(shown) do
            sb.entries[#sb.entries + 1] = Entry(sb, entry, y, tabButtons, pick)
            y = y + ROW_H
        end
    end

    -- Options at the foot
    local foot = Entry(sb, OPTIONS, 0, tabButtons, pick)
    foot:ClearAllPoints()
    foot:SetPoint("BOTTOMLEFT", sb, "BOTTOMLEFT", 1, 12)
    sb.entries[#sb.entries + 1] = foot
    sb.footLine = { T.AddFadedLine(sb, 0, 0, 0.3) }
    for _, part in ipairs(sb.footLine) do
        part:ClearAllPoints()
    end
    sb.footLine[1]:SetPoint("BOTTOMLEFT", foot, "TOPLEFT", 0, 4)
    sb.footLine[1]:SetPoint("TOPRIGHT", foot, "TOP", 0, 5)
    sb.footLine[2]:SetPoint("BOTTOMLEFT", foot, "TOP", 0, 4)
    sb.footLine[2]:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 5)
    Sidebar.frame = sb
    return sb
end
