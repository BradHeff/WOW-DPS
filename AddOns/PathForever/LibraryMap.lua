-- PathForever: library books on the world map.
--
-- A "Books" button beside the world map (like the Journey's button beside the
-- spellbook) turns the library's books on and off on the map: a book icon at each
-- book on the zone on show, the ones you're carrying with the game's "ready to turn
-- in" mark. A book you already have (carried or handed in) is greyed and faded, so
-- the ones still to find stand out. Hovering one names it; clicking one puts the
-- game's own map pin on it (UI.lua's Mark on map). The setting is saved
-- (PathForeverDB.options.mapBooks, off until turned on).
--
-- The world map is Blizzard's, so this follows the map pin's rules (UI.lua, "Map
-- pin"): PathForever never opens the map or changes its zone; the pins are its own
-- frames on the map's canvas, placed by a throttled timer that does nothing in
-- combat and only re-places them when the zone on show or the canvas size changes
-- (or the books do); the button is parented to UIParent and only follows the map
-- through HookScript after-hooks. It lives in this file alone, so taking it out of
-- the TOC removes it.

local PF = PathForever
local LibraryMap = {}
PF.LibraryMap = LibraryMap

local PIN_SIZE = 22
local THROTTLE = 0.2       -- seconds between checks while the map is open
local REFRESH = 2          -- and a full re-read of the books (bags, hand-ins) this often
local BOOK_ICON = "Interface\\GossipFrame\\TrainerGossipIcon" -- a book on a clear background
local HELD_ICON = "Interface\\GossipFrame\\ActiveQuestIcon"

local pins = {}
local button, driver
local hooked = false
local lastMap, lastW, lastH, sinceRead = nil, nil, nil, 0

-- Options' "Library books" (on unless turned off) allows the button at all.
local function Allowed()
    return not (PathForeverDB and PathForeverDB.options and PathForeverDB.options.libraryBooks == false)
end
local function Enabled()
    return Allowed() and PathForeverDB.options and PathForeverDB.options.mapBooks and true or false
end

local function HidePins()
    for _, p in ipairs(pins) do p:Hide() end
    lastMap = nil
end

-- ---------- The pins ----------
local function PinEnter(self)
    local b = self.book
    if not (b and GameTooltip) then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(b.name, 1, 1, 1, 1, true)
    GameTooltip:AddLine(b.container .. " (" .. b.coords .. ")", 0.75, 0.75, 0.78)
    if b.note then GameTooltip:AddLine(b.note, 0.75, 0.75, 0.78, true) end
    if b.done then
        GameTooltip:AddLine("Handed in", 0.75, 0.75, 0.78)
    elseif b.held then
        GameTooltip:AddLine("Picked up - hand it in to " .. (b.librarian or "the librarian"), 1, 0.55, 0.15, true)
    end
    GameTooltip:Show()
end
local function PinLeave() if GameTooltip then GameTooltip:Hide() end end
local function PinClick(self)
    if self.book and PF.UI and PF.UI.MarkOnMap then PF.UI.MarkOnMap(self.book) end
end

local function AcquirePin(i, canvas)
    local p = pins[i]
    if p then return p end
    p = CreateFrame("Button", nil, canvas)
    p:SetSize(PIN_SIZE, PIN_SIZE)
    p:SetFrameStrata("FULLSCREEN_DIALOG")
    p:SetFrameLevel(canvas:GetFrameLevel() + 40)
    -- the book, drawn on a clear background (no box)
    p.icon = p:CreateTexture(nil, "ARTWORK")
    p.icon:SetAllPoints()
    p.icon:SetTexture(BOOK_ICON)
    p.held = p:CreateTexture(nil, "OVERLAY")
    p.held:SetSize(14, 14)
    p.held:SetPoint("BOTTOMRIGHT", p, "BOTTOMRIGHT", 5, -5)
    p.held:SetTexture(HELD_ICON)
    p.held:Hide()
    p:SetScript("OnEnter", PinEnter)
    p:SetScript("OnLeave", PinLeave)
    p:SetScript("OnClick", PinClick)
    pins[i] = p
    return p
end

-- Puts a pin on each book of the zone on show; `force` re-reads the books.
function LibraryMap:Update(force)
    if InCombatLockdown() then return end -- nothing on the map in combat
    local map = _G.WorldMapFrame
    if not (map and map:IsShown() and Enabled()) then HidePins() return end
    local canvas = map.GetCanvas and map:GetCanvas()
    if not canvas then return end
    local w, h = canvas:GetSize()
    if not w or w <= 0 or not h or h <= 0 then return end
    local mapID = map:GetMapID()
    if not force and mapID == lastMap and w == lastW and h == lastH then return end
    lastMap, lastW, lastH, sinceRead = mapID, w, h, 0
    local list = PF.Journey and PF.Journey.LibraryBooks and PF.Journey:LibraryBooks()
    local n = 0
    for _, b in ipairs(list and list.books or {}) do
        if b.mapID and b.mapID == mapID and b.x and b.y then
            n = n + 1
            local p = AcquirePin(n, canvas)
            p.book = b
            -- one you have (in your bags or handed in) is grey and faded
            local have = (b.done or b.held) and true or false
            if p.icon.SetDesaturated then p.icon:SetDesaturated(have) end
            p.icon:SetAlpha(have and 0.55 or 1)
            p.held:SetShown((b.held and not b.done) and true or false)
            p:ClearAllPoints()
            p:SetPoint("CENTER", canvas, "TOPLEFT", b.x * w, -b.y * h)
            p:Show()
        end
    end
    for i = n + 1, #pins do pins[i]:Hide() end
end

-- ---------- The driver: while the map is open and the books are on ----------
local function DriverTick(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed < THROTTLE then return end
    sinceRead = sinceRead + self.elapsed
    self.elapsed = 0
    LibraryMap:Update(sinceRead >= REFRESH)
end
local function StartDriver()
    driver = driver or CreateFrame("Frame")
    driver:SetScript("OnUpdate", DriverTick)
    driver:Show()
end
local function StopDriver()
    if driver then driver:Hide() end
    HidePins()
end

-- ---------- The button beside the map ----------
local function ButtonVisual()
    if not button then return end
    local on = Enabled()
    button.glow:SetShown(on)
    button.border:SetAlpha(on and 1 or 0.55)
end
local function ButtonClick()
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.mapBooks = not Enabled()
    PF.Theme.PlayCheckboxSound(PathForeverDB.options.mapBooks)
    ButtonVisual()
    if Enabled() then
        StartDriver()
        LibraryMap:Update(true)
    else
        HidePins()
    end
end
local function ButtonEnter(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Library books", 1, 1, 1)
    GameTooltip:AddLine(Enabled() and "Where to find them is shown on the map."
        or "Show where to find them on the map.", nil, nil, nil, true)
    GameTooltip:Show()
end
local function ButtonLeave() if GameTooltip then GameTooltip:Hide() end end

local function CreateButton()
    local b = CreateFrame("Button", "PathForeverMapBooksButton", UIParent)
    b:SetSize(36, 36)
    PF.Theme.StyleMapTile(b)
    b.icon:SetTexture(BOOK_ICON)
    b.glow = PF.Theme.CreateGlow(b, "BOTTOM", 0.45, "OVERLAY")
    b.hl = b:CreateTexture(nil, "HIGHLIGHT")
    b.hl:SetAllPoints()
    b.hl:SetColorTexture(1, 1, 1, 0.15)
    b:SetScript("OnClick", ButtonClick)
    b:SetScript("OnEnter", ButtonEnter)
    b:SetScript("OnLeave", ButtonLeave)
    b:Hide()
    return b
end

-- Beside the map's top-right corner, on its layer (like the spellbook button).
local function MapShown(map)
    if not Allowed() then
        if button then button:Hide() end
        HidePins()
        return
    end
    button = button or CreateButton()
    button:ClearAllPoints()
    button:SetPoint("TOPLEFT", map, "TOPRIGHT", 5, -48)
    if map.GetFrameStrata then button:SetFrameStrata(map:GetFrameStrata()) end
    if map.GetFrameLevel then button:SetFrameLevel(map:GetFrameLevel() + 10) end
    ButtonVisual()
    button:Show()
    if Enabled() then
        StartDriver()
        LibraryMap:Update(true)
    end
end
local function MapHidden()
    if button then button:Hide() end
    StopDriver()
end

-- After the Options switch: show or hide the button (and pins) on an open map.
function LibraryMap:Refresh()
    local map = _G.WorldMapFrame
    if map and map:IsShown() then MapShown(map) end
end

function LibraryMap:Hook()
    local map = _G.WorldMapFrame
    if hooked or type(map) ~= "table" or not map.HookScript then return end
    hooked = true
    map:HookScript("OnShow", MapShown)
    map:HookScript("OnHide", MapHidden)
    if map.IsShown and map:IsShown() then MapShown(map) end
end

-- The world map may load after PathForever: hook at login and whenever an addon loads.
local events = CreateFrame("Frame")
LibraryMap.eventFrame = events
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", function() LibraryMap:Hook() end)
