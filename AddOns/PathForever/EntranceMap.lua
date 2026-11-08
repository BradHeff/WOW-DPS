-- PathForever: dungeon and raid entrances on the world map.
--
-- An "Entrances" button beside the world map (under the library's Books button)
-- turns the entrances on and off: a key at each dungeon's entrance and a skull at
-- each raid's, on the zone on show and on the continent map. Hovering one names it
-- with its level range; clicking one opens PathForever on that dungeon (a complex
-- with several wings, such as Scarlet Monastery, opens the list of its wings). The
-- setting is saved (PathForeverDB.options.mapEntrances, off until turned on), and
-- Options' "Dungeon entrances" (on unless turned off) allows the button at all.
--
-- The world map is Blizzard's, so this follows the map pin's rules (UI.lua, "Map
-- pin") exactly as LibraryMap.lua does: PathForever never opens the map or changes
-- its zone; the pins are its own frames on the map's canvas, placed by a throttled
-- timer that does nothing in combat and only re-places them when the zone on show or
-- the canvas size changes; the button is parented to UIParent and only follows the
-- map through HookScript after-hooks. Clicking a pin only opens PathForever's own
-- window. The places are in EntranceData.lua; this file alone can be taken out of
-- the TOC to remove the feature.

local PF = PathForever
local EntranceMap = {}
PF.EntranceMap = EntranceMap

local PIN_SIZE = 20
local THROTTLE = 0.2       -- seconds between checks while the map is open
-- The retail map's own entrance icons are atlases: a blue swirl for a dungeon, a
-- green one for a raid. A client without them gets a key and a skull instead.
EntranceMap.ATLAS = { dungeon = "Dungeon", raid = "Raid" }
local FALLBACK = {
    dungeon = "Interface\\Icons\\INV_Misc_Key_03",
    raid = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01",
}

local pins = {}
local button, driver
local hooked = false
local lastMap, lastW, lastH = nil, nil, nil
local byName

local function Allowed()
    return not (PathForeverDB and PathForeverDB.options and PathForeverDB.options.entranceMap == false)
end
local function Enabled()
    return Allowed() and PathForeverDB.options and PathForeverDB.options.mapEntrances and true or false
end

local function HidePins()
    for _, p in ipairs(pins) do p:Hide() end
    lastMap = nil
end

-- The dungeon tables of an entrance, looked up by name (once; Dungeons is static).
local function Dungeon(name)
    if not byName then
        byName = {}
        for _, d in ipairs(PathForeverData and PathForeverData.Dungeons or {}) do
            byName[d.name] = d
        end
    end
    return byName[name]
end

local function HasAtlas(name)
    if not (C_Texture and C_Texture.GetAtlasInfo) then return false end
    local ok, info = pcall(C_Texture.GetAtlasInfo, name)
    return ok and info and true or false
end

-- Puts the entrance icon of `kind` on a pin or button face; `border` is the plain
-- square behind a file icon (an atlas swirl has no square corners to frame).
local function SetIcon(face, border, kind)
    local name = EntranceMap.ATLAS[kind]
    if name and HasAtlas(name) then
        face:SetAtlas(name)
        if border then border:Hide() end
    else
        face:SetTexture(FALLBACK[kind])
        if border then border:Show() end
    end
end

local function LevelText(lo, hi)
    if not lo or lo <= 0 then return nil end
    if hi and hi ~= lo then return "Lv " .. lo .. "-" .. hi end
    return "Lv " .. lo
end

-- ---------- The pins ----------
local GREY = 0.75
local function PinEnter(self)
    local e = self.entrance
    if not (e and GameTooltip) then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(e.name, 1, 1, 1, 1, true)
    local clickable = false
    for _, dn in ipairs(e.dungeons or {}) do
        local d = Dungeon(dn)
        if d then
            clickable = true
            local lv = LevelText(d.levelMin, d.levelMax)
            local label = (#e.dungeons > 1 and dn or "Dungeon")
            GameTooltip:AddDoubleLine(label, lv or "", GREY, GREY, GREY, 1, 1, 1)
        end
    end
    for _, o in ipairs(e.others or {}) do
        local lv = LevelText(o[2], o[2])
        local kind = e.kind == "raid" and ("Raid, " .. o[3] .. " players") or (o[3] .. " players")
        GameTooltip:AddDoubleLine(o[1] .. " - " .. kind, lv or "", GREY, GREY, GREY, 1, 1, 1)
    end
    if e.note then GameTooltip:AddLine(e.note, GREY, GREY, 0.78, true) end
    if clickable then
        GameTooltip:AddLine("Click to open in PathForever", 0.9, 0.72, 0.36)
    end
    GameTooltip:Show()
end
local function PinLeave() if GameTooltip then GameTooltip:Hide() end end
local function PinClick(self)
    local e = self.entrance
    if not (e and PF.OpenTab) then return end
    local list = {}
    for _, dn in ipairs(e.dungeons or {}) do
        local d = Dungeon(dn)
        if d then list[#list + 1] = d end
    end
    if #list == 1 then
        PF:OpenTab("Dungeons", list[1])
    elseif #list > 1 then
        PF:OpenTab("Dungeons", nil, list)
    end
end

local function AcquirePin(i, canvas)
    local p = pins[i]
    if p then return p end
    p = CreateFrame("Button", nil, canvas)
    p:SetSize(PIN_SIZE, PIN_SIZE)
    p:SetFrameStrata("FULLSCREEN_DIALOG")
    p:SetFrameLevel(canvas:GetFrameLevel() + 40)
    p.border = p:CreateTexture(nil, "ARTWORK", nil, -1)
    p.border:SetPoint("TOPLEFT", -2, 2)
    p.border:SetPoint("BOTTOMRIGHT", 2, -2)
    local ar, ag, ab = PF.Theme.GetAccentColor()
    p.border:SetColorTexture(ar, ag, ab, 0.9)
    p.icon = p:CreateTexture(nil, "ARTWORK")
    p.icon:SetAllPoints()
    p:SetScript("OnEnter", PinEnter)
    p:SetScript("OnLeave", PinLeave)
    p:SetScript("OnClick", PinClick)
    pins[i] = p
    return p
end

-- Puts a pin on each entrance of the map on show (zone or continent).
function EntranceMap:Update(force)
    if InCombatLockdown() then return end -- nothing on the map in combat
    local map = _G.WorldMapFrame
    if not (map and map:IsShown() and Enabled()) then HidePins() return end
    local canvas = map.GetCanvas and map:GetCanvas()
    if not canvas then return end
    local w, h = canvas:GetSize()
    if not w or w <= 0 or not h or h <= 0 then return end
    local mapID = map:GetMapID()
    if not force and mapID == lastMap and w == lastW and h == lastH then return end
    lastMap, lastW, lastH = mapID, w, h
    local n = 0
    for _, e in ipairs(PathForeverData and PathForeverData.Entrances or {}) do
        local x, y
        if e.map == mapID then x, y = e.x, e.y
        elseif e.cmap == mapID then x, y = e.cx, e.cy end
        if x and y then
            n = n + 1
            local p = AcquirePin(n, canvas)
            p.entrance = e
            SetIcon(p.icon, p.border, e.kind == "raid" and "raid" or "dungeon")
            p:ClearAllPoints()
            p:SetPoint("CENTER", canvas, "TOPLEFT", x * w, -y * h)
            p:Show()
        end
    end
    for i = n + 1, #pins do pins[i]:Hide() end
end

-- ---------- The driver: while the map is open and the entrances are on ----------
local function DriverTick(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed < THROTTLE then return end
    self.elapsed = 0
    EntranceMap:Update(false)
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
    button.icon:SetAlpha(on and 1 or 0.7)
end
local function ButtonClick()
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.mapEntrances = not Enabled()
    PF.Theme.PlayCheckboxSound(PathForeverDB.options.mapEntrances)
    ButtonVisual()
    if Enabled() then
        StartDriver()
        EntranceMap:Update(true)
    else
        HidePins()
    end
end
local function ButtonEnter(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Dungeon entrances", 1, 1, 1)
    GameTooltip:AddLine(Enabled() and "Every dungeon and raid entrance is shown on the map."
        or "Show every dungeon and raid entrance on the map.", nil, nil, nil, true)
    GameTooltip:Show()
end
local function ButtonLeave() if GameTooltip then GameTooltip:Hide() end end

local function CreateButton()
    local b = CreateFrame("Button", "PathForeverMapEntrancesButton", UIParent)
    b:SetSize(36, 36)
    PF.Theme.StyleMapTile(b)
    SetIcon(b.icon, nil, "dungeon")
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

-- Beside the map's top-right corner, under the Books button, on the map's layer.
local function MapShown(map)
    if not Allowed() then
        if button then button:Hide() end
        HidePins()
        return
    end
    button = button or CreateButton()
    button:ClearAllPoints()
    button:SetPoint("TOPLEFT", map, "TOPRIGHT", 5, -92)
    if map.GetFrameStrata then button:SetFrameStrata(map:GetFrameStrata()) end
    if map.GetFrameLevel then button:SetFrameLevel(map:GetFrameLevel() + 10) end
    ButtonVisual()
    button:Show()
    if Enabled() then
        StartDriver()
        EntranceMap:Update(true)
    end
end
local function MapHidden()
    if button then button:Hide() end
    StopDriver()
end

-- After the Options switch: show or hide the button (and pins) on an open map.
function EntranceMap:Refresh()
    local map = _G.WorldMapFrame
    if map and map:IsShown() then MapShown(map) end
end

function EntranceMap:Hook()
    local map = _G.WorldMapFrame
    if hooked or type(map) ~= "table" or not map.HookScript then return end
    hooked = true
    map:HookScript("OnShow", MapShown)
    map:HookScript("OnHide", MapHidden)
    if map.IsShown and map:IsShown() then MapShown(map) end
end

-- The world map may load after PathForever: hook at login and whenever an addon loads.
local events = CreateFrame("Frame")
EntranceMap.eventFrame = events
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", function() EntranceMap:Hook() end)
