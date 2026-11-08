-- PathForever: flight paths on the world map, with whether you have unlocked them.
--
-- A "Flight paths" button beside the world map (under the Entrances button) turns
-- the flight points on and off: a pin at each flight master of the map on show, in
-- the same flight icon in yellow when you have found it, and in grey when you
-- haven't (hover for the name and which it is; click an unfound one to mark it with
-- the game's own map pin, UI.lua's Mark on map). Flight points of the other faction
-- are left out. The setting is saved (PathForeverDB.options.mapFlights, off until
-- turned on); Options' "Flight paths" (on unless turned off) allows the button.
--
-- The flight points are the client's own (C_TaxiMap.GetTaxiNodesForMap lists the
-- whole continent), read in pcall and only out of combat. That list does not say
-- which you have found (every entry reads isUndiscovered = false on the Forever
-- client), but the flight master's own window lists only the ones you know, so
-- PathForever reads that when you open one (TAXIMAP_OPENED: NumTaxiNodes,
-- TaxiNodeName, TaxiNodeGetType; reads only) and keeps the names per character
-- (PathForeverDB.flightPoints[guid]) with the continents it has seen. On a continent
-- it has not seen yet, the flight points are drawn as they are (neither found nor
-- missing) and the tooltip says to open a flight master's map. `/pf flights` prints
-- what the client reports and what has been learned.
--
-- The world map is Blizzard's, so this follows the map pin's rules (UI.lua, "Map
-- pin") exactly as LibraryMap.lua does: PathForever never opens the map or changes
-- its zone; the pins are its own frames on the map's canvas, placed by a throttled
-- timer that does nothing in combat and only re-places them when the zone on show
-- or the canvas size changes (and re-reads the flight points every few seconds, for
-- a newly found one); the button is parented to UIParent and only follows the map
-- through HookScript after-hooks. Nothing here uses a taxi or flight master window.

local PF = PathForever
local FlightMap = {}
PF.FlightMap = FlightMap

local PIN_SIZE = 20
local THROTTLE = 0.2       -- seconds between checks while the map is open
local REFRESH = 3          -- and a full re-read of the flight points this often
-- The retail map's own flight point icons are atlases; a client without them gets
-- a bird-of-prey icon file, coloured by the pin's rim.
local ATLAS = { Alliance = "TaxiNode_Alliance", Horde = "TaxiNode_Horde", Neutral = "TaxiNode_Neutral" }
FlightMap.ATLAS = ATLAS
local FALLBACK_ICON = "Interface\\Icons\\Ability_Hunter_EagleEye"

local GREEN = { 0.35, 0.85, 0.40 } -- the tooltip's "Found" line

local pins = {}
local button, driver
local hooked = false
local lastMap, lastW, lastH, sinceRead = nil, nil, nil, 0

local function Allowed()
    return not (PathForeverDB and PathForeverDB.options and PathForeverDB.options.flightMap == false)
end
local function Enabled()
    return Allowed() and PathForeverDB.options and PathForeverDB.options.mapFlights and true or false
end

local function HidePins()
    for _, p in ipairs(pins) do p:Hide() end
    lastMap = nil
end

-- The enum values, with the numbers the client uses if the enums are missing.
local function State(name, fallback)
    local e = Enum and Enum.FlightPathState
    return e and e[name] or fallback
end
local function Faction(name, fallback)
    local e = Enum and Enum.FlightPathFaction
    return e and e[name] or fallback
end

-- The continent map a map belongs to (itself, if it is one).
local function ContinentOf(mapID)
    if not (mapID and C_Map and C_Map.GetMapInfo) then return end
    local id = mapID
    for _ = 1, 6 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if not ok or type(info) ~= "table" then return end
        if info.mapType == 2 then return id end
        id = info.parentMapID
        if not id or id == 0 then return end
    end
end

-- What this character has learned at flight masters (nil until it has).
local function Learned()
    local guid = UnitGUID and UnitGUID("player")
    local all = PathForeverDB and PathForeverDB.flightPoints
    local r = guid and type(all) == "table" and all[guid]
    if type(r) == "table" and r.v == 2 and type(r.names) == "table" and type(r.scanned) == "table" then return r end
end

-- "found", "missing" (not found yet) or "unknown" (not learned for this continent).
local function Status(node, mapID)
    if node.isUndiscovered == true then return "missing" end
    local r, cont = Learned(), ContinentOf(mapID)
    if r and cont and r.scanned[cont] then
        return r.names[node.name] and "found" or "missing"
    end
    if node.isUndiscovered == nil and node.state == State("Unreachable", 2) then return "missing" end
    return "unknown"
end

-- "Alliance", "Horde" or "Neutral" for a node.
local function FactionOf(node)
    if node.faction == Faction("Alliance", 1) then return "Alliance" end
    if node.faction == Faction("Horde", 2) then return "Horde" end
    return "Neutral"
end

local function NodePosition(node)
    local pos = node.position
    if type(pos) ~= "table" then return end
    if pos.x and pos.y then return pos.x, pos.y end
    if pos.GetXY then
        local ok, x, y = pcall(pos.GetXY, pos)
        if ok then return x, y end
    end
end

-- One of the client's two lists for a map, read safely (nil if it can't say).
local function ReadList(fnName, mapID)
    local fn = C_TaxiMap and C_TaxiMap[fnName]
    if not (fn and mapID) then return end
    local ok, nodes = pcall(fn, mapID)
    if ok and type(nodes) == "table" then return nodes end
end

-- Every flight point of a map: the full list if the client gives one for it, else
-- the ones it shows on that map.
local function ReadNodes(mapID)
    local all = ReadList("GetAllTaxiNodes", mapID)
    if all and #all > 0 then return all end
    return ReadList("GetTaxiNodesForMap", mapID) or all
end

-- ---------- The pins ----------
local function PinEnter(self)
    local n = self.node
    if not (n and GameTooltip) then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(n.name or "Flight point", 1, 1, 1, 1, true)
    if self.status == "found" then
        GameTooltip:AddLine("Found - you can fly from here", GREEN[1], GREEN[2], GREEN[3])
    elseif self.status == "unknown" then
        GameTooltip:AddLine("Open any flight master's map on this continent, and PathForever learns which you have found", 0.75, 0.75, 0.78, true)
    else
        GameTooltip:AddLine("Not found yet", 1, 0.55, 0.15)
        GameTooltip:AddLine("Talk to its flight master to learn it", 0.75, 0.75, 0.78, true)
        GameTooltip:AddLine("Click to mark it on your map", 0.9, 0.72, 0.36)
    end
    GameTooltip:Show()
end
local function PinLeave() if GameTooltip then GameTooltip:Hide() end end
local function PinClick(self)
    if self.status ~= "missing" or not self.mark then return end
    if PF.UI and PF.UI.MarkOnMap then PF.UI.MarkOnMap(self.mark) end
end

local function AcquirePin(i, canvas)
    local p = pins[i]
    if p then return p end
    p = CreateFrame("Button", nil, canvas)
    p:SetSize(PIN_SIZE, PIN_SIZE)
    p:SetFrameStrata("FULLSCREEN_DIALOG")
    p:SetFrameLevel(canvas:GetFrameLevel() + 30)
    p.icon = p:CreateTexture(nil, "ARTWORK")
    p.icon:SetAllPoints()
    p:SetScript("OnEnter", PinEnter)
    p:SetScript("OnLeave", PinLeave)
    p:SetScript("OnClick", PinClick)
    pins[i] = p
    return p
end

local function HasAtlas(name)
    if not (C_Texture and C_Texture.GetAtlasInfo) then return false end
    local ok, info = pcall(C_Texture.GetAtlasInfo, name)
    return ok and info and true or false
end

-- One icon for every flight point (the faction icons are red, blue and grey, which
-- read as good or bad), stripped of its own colour and tinted by what you have done:
-- yellow for found, one fixed grey for not found, plain for not yet learned.
local TINT = {
    found = { 1.00, 0.88, 0.10 }, -- a saturated yellow: the muted accent gold came out brown on the grey icon
    missing = { 0.45, 0.47, 0.50 },
    unknown = { 1, 1, 1 },
}
local function Paint(p, status)
    local name = ATLAS.Neutral
    if name and HasAtlas(name) then
        p.icon:SetAtlas(name)
    else
        p.icon:SetTexture(FALLBACK_ICON)
        p.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    local c = TINT[status] or TINT.unknown
    if p.icon.SetDesaturated then p.icon:SetDesaturated(true) end
    p.icon:SetVertexColor(c[1], c[2], c[3])
    p.icon:SetAlpha(status == "missing" and 0.75 or 1)
end

local playerFaction
-- Puts a pin on each flight point of the map on show; `force` re-reads them.
function FlightMap:Update(force)
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
    -- none on the map of the whole world (or above): you cannot fly between continents
    local okInfo, info = pcall(C_Map.GetMapInfo, mapID)
    if okInfo and type(info) == "table" and info.mapType and info.mapType <= 1 then
        for i = 1, #pins do pins[i]:Hide() end
        return
    end
    playerFaction = playerFaction or (UnitFactionGroup and UnitFactionGroup("player"))
    local n = 0
    for _, node in ipairs(ReadNodes(mapID) or {}) do
        local x, y = NodePosition(node)
        local side = FactionOf(node)
        -- the other faction's flight points are no use to you
        if x and y and (side == "Neutral" or side == playerFaction or not playerFaction) then
            n = n + 1
            local p = AcquirePin(n, canvas)
            local status = Status(node, mapID)
            local found = status ~= "missing"
            p.node, p.found, p.status = node, found, status
            p.mark = (not found) and { name = node.name, mapID = mapID, x = x, y = y } or nil
            Paint(p, status)
            p:ClearAllPoints()
            p:SetPoint("CENTER", canvas, "TOPLEFT", x * w, -y * h)
            p:Show()
        end
    end
    for i = n + 1, #pins do pins[i]:Hide() end
end

-- The flight points a character can use on a continent map (its own faction's and the
-- neutral ones) as { node, x, y, status }. Nothing if the client can't say.
local function UsableNodes(mapID)
    local out = {}
    if not (mapID and C_TaxiMap) then return out end
    local faction = UnitFactionGroup and UnitFactionGroup("player")
    for _, node in ipairs(ReadNodes(mapID) or {}) do
        local x, y = NodePosition(node)
        local side = FactionOf(node)
        if x and y and (side == "Neutral" or side == faction or not faction) then
            out[#out + 1] = { node = node, x = x, y = y, status = Status(node, mapID) }
        end
    end
    return out
end

-- The zone a flight point's name ends with ("Sentinel Hill, Westfall" -> "Westfall").
local function NodeZone(name)
    return type(name) == "string" and name:match(",%s*(.+)$") or nil
end
-- Zone names differ in length between the map and the flight master ("Tirisfal
-- Glades" and "Tirisfal"): the same zone if one starts with the other.
local function SameZone(a, b)
    if not (a and b) or a == "" or b == "" then return false end
    a, b = a:lower(), b:lower()
    return a:sub(1, #b) == b or b:sub(1, #a) == a
end

-- The flight points of the zone the player is in, for this character:
-- { zone, found, total, missing = { names } }, or nil when there are none, the client
-- can't say, or nothing is known about the continent yet.
function FlightMap:ZoneProgress()
    if not (C_Map and C_Map.GetBestMapForUnit and C_Map.GetMapInfo) then return end
    local okMap, mapID = pcall(C_Map.GetBestMapForUnit, "player")
    if not okMap or not mapID then return end
    -- up from a sub-area to the zone map (map type 3)
    local zone, id
    id = mapID
    for _ = 1, 4 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if not ok or type(info) ~= "table" then return end
        if info.mapType == 3 then zone = info.name break end
        id = info.parentMapID
        if not id or id == 0 then return end
    end
    local cont = ContinentOf(mapID)
    if not (zone and cont) then return end
    local found, total, missing = 0, 0, {}
    for _, e in ipairs(UsableNodes(cont)) do
        if e.status ~= "unknown" and SameZone(NodeZone(e.node.name), zone) then
            total = total + 1
            if e.status == "found" then found = found + 1 else missing[#missing + 1] = e.node.name:match("^(.-),") or e.node.name end
        end
    end
    if total == 0 then return end
    return { zone = zone, found = found, total = total, missing = missing }
end

-- How many flight points of each continent this character has found, for the
-- continents it has opened a flight master's window on: { { name, found, total } }.
function FlightMap:Counts()
    local out = {}
    for _, c in ipairs({ { 1414, "Kalimdor" }, { 1415, "Eastern Kingdoms" } }) do
        local found, total, known = 0, 0, false
        for _, e in ipairs(UsableNodes(c[1])) do
            total = total + 1
            if e.status == "found" then found = found + 1 end
            if e.status ~= "unknown" then known = true end
        end
        if total > 0 and known then out[#out + 1] = { name = c[2], found = found, total = total } end
    end
    return out
end

-- What the client reports for the map in front of you (/pf flights).
function FlightMap:Report()
    local tag = "|cff3fc7ebPathForever|r "
    local map = _G.WorldMapFrame
    local mapID = map and map:IsShown() and map:GetMapID()
        or (C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player"))
    print(string.format("%sflight points: C_TaxiMap %s, map %s", tag,
        (C_TaxiMap and (C_TaxiMap.GetAllTaxiNodes and "GetAllTaxiNodes" or C_TaxiMap.GetTaxiNodesForMap and "GetTaxiNodesForMap")) or "MISSING",
        tostring(mapID)))
    -- both of the client's lists, for this map and for the continent above it
    local chain, id = {}, mapID
    for _ = 1, 4 do
        if not id or id == 0 then break end
        chain[#chain + 1] = id
        local info = C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(id)
        id = info and info.parentMapID
    end
    for _, m in ipairs(chain) do
        local a, f = ReadList("GetAllTaxiNodes", m), ReadList("GetTaxiNodesForMap", m)
        print(string.format("  map %s: GetAllTaxiNodes %s, GetTaxiNodesForMap %s", tostring(m),
            a and #a or "nothing", f and #f or "nothing"))
    end
    local nodes = ReadNodes(mapID)
    if not nodes then print("  the client gave no list for this map") return end
    local found, notFound, other, unknown = 0, 0, 0, 0
    for _, node in ipairs(nodes) do
        local side = FactionOf(node)
        if side == "Neutral" or side == (UnitFactionGroup and UnitFactionGroup("player")) then
            local s = Status(node, mapID)
            if s == "missing" then notFound = notFound + 1 else found = found + 1 end
            if s == "unknown" then unknown = unknown + 1 end
        else
            other = other + 1
        end
    end
    print(string.format("  %d listed: %d found, %d not found, %d of the other faction%s", #nodes, found, notFound, other,
        unknown > 0 and (" (" .. unknown .. " not learned yet: open a flight master's map)") or ""))
    local r = Learned()
    local known, conts = 0, {}
    if r then
        for _ in pairs(r.names) do known = known + 1 end
        for c in pairs(r.scanned) do conts[#conts + 1] = tostring(c) end
    end
    if r and r.dbg then
        local t = {}
        for k, v in pairs(r.dbg.types or {}) do t[#t + 1] = k .. "=" .. v end
        table.sort(t)
        print(string.format("  last window: %d in its list (types %s), %d from GetAllTaxiNodes, %d of those undiscovered",
            r.dbg.window or 0, #t > 0 and table.concat(t, " ") or "none", r.dbg.all or 0, r.dbg.undiscovered or 0))
    end
    print(string.format("  learned at flight masters: %d flight points, continents %s; taxi window: %s",
        known, #conts > 0 and table.concat(conts, ", ") or "none yet",
        (NumTaxiNodes and TaxiNodeName) and "readable" or "NumTaxiNodes missing"))
    -- every field of a few entries (to see what tells found from not found)
    local function Dump(v)
        if type(v) ~= "table" then return tostring(v) end
        local parts = {}
        for k, x in pairs(v) do parts[#parts + 1] = tostring(k) .. "=" .. (type(x) == "table" and "{...}" or tostring(x)) end
        table.sort(parts)
        return "{" .. table.concat(parts, ", ") .. "}"
    end
    for i = 1, math.min(#nodes, 3) do print("  " .. Dump(nodes[i])) end
    local states = {}
    for _, node in ipairs(nodes) do
        local s = tostring(node.state)
        states[s] = (states[s] or 0) + 1
    end
    for s, n in pairs(states) do print(string.format("  state %s: %d", s, n)) end
    print("  C_TaxiMap: " .. Dump(C_TaxiMap):gsub("=function: [%w]+", "=fn"))
    if C_TaxiMap and C_TaxiMap.IsTaxiNodeKnown then print("  IsTaxiNodeKnown exists") end
    for _, name in pairs(ATLAS) do
        print(string.format("  atlas %s: %s", name, HasAtlas(name) and "found" or "MISSING (icon file used)"))
    end
end

-- ---------- Learning which you have found: the flight master's window ----------
-- Reads the window's own list (only the flight points you know are in it); the
-- reads change nothing and Blizzard's window is never touched.
local DATA_VERSION = 2 -- 1 took everything in the window's old-style list as found; it lists the ones you haven't found too

function FlightMap:Scan()
    local guid = UnitGUID and UnitGUID("player")
    if not (guid and PathForeverDB) then return false end
    local best = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
    -- 1. the full list, which the client gives while the window is open (nothing outside it)
    local nodes, id = nil, best
    for _ = 1, 4 do
        if not id or id == 0 then break end
        local list = ReadList("GetAllTaxiNodes", id)
        if list and #list > 0 then nodes = list break end
        local ok, info = pcall(C_Map.GetMapInfo, id)
        id = ok and type(info) == "table" and info.parentMapID or nil
    end
    -- 2. the window's old-style list: what each entry's type is, and which are flyable
    local types, flyable, count = {}, {}, 0
    if NumTaxiNodes and TaxiNodeName then
        local okN, n = pcall(NumTaxiNodes)
        count = okN and type(n) == "number" and n or 0
        for i = 1, count do
            local okName, name = pcall(TaxiNodeName, i)
            local okType, kind = true, nil
            if TaxiNodeGetType then okType, kind = pcall(TaxiNodeGetType, i) end
            kind = tostring(kind)
            types[kind] = (types[kind] or 0) + 1
            if okName and type(name) == "string" and name ~= "" and (kind == "REACHABLE" or kind == "CURRENT") then
                flyable[name] = true
            end
        end
    end
    if not nodes and count <= 0 then return false end
    -- the flight master you are talking to is known, whatever the list says (it can
    -- still call a flight point you have only just found undiscovered)
    local here = {}
    if NumTaxiNodes and TaxiNodeName and TaxiNodeGetType then
        for i = 1, count do
            local okType, kind = pcall(TaxiNodeGetType, i)
            if okType and kind == "CURRENT" then
                local okName, name = pcall(TaxiNodeName, i)
                if okName and type(name) == "string" and name ~= "" then here[name] = true end
            end
        end
    end
    PathForeverDB.flightPoints = type(PathForeverDB.flightPoints) == "table" and PathForeverDB.flightPoints or {}
    local r = PathForeverDB.flightPoints[guid]
    if type(r) ~= "table" or r.v ~= DATA_VERSION then
        r = { v = DATA_VERSION, names = {}, scanned = {} }
        PathForeverDB.flightPoints[guid] = r
    end
    if type(r.names) ~= "table" then r.names = {} end
    if type(r.scanned) ~= "table" then r.scanned = {} end
    local seen, undiscovered = 0, 0
    if nodes then
        for _, node in ipairs(nodes) do
            local no = node.isUndiscovered
            if no == nil then no = (node.state == State("Unreachable", 2)) end
            if no then
                undiscovered = undiscovered + 1
            elseif type(node.name) == "string" then
                r.names[node.name] = true
                seen = seen + 1
            end
        end
    else
        for name in pairs(flyable) do r.names[name] = true; seen = seen + 1 end
    end
    for name in pairs(here) do
        if not r.names[name] then seen = seen + 1 end
        r.names[name] = true
    end
    r.dbg = { types = types, window = count, all = nodes and #nodes or 0, undiscovered = undiscovered }
    local cont = ContinentOf(best)
    if cont and (nodes or count > 0) then r.scanned[cont] = true end
    sinceRead = REFRESH -- the map redraws at its next tick
    lastMap = nil
    return seen > 0
end

-- ---------- The driver: while the map is open and the flight points are on ----------
local function DriverTick(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed < THROTTLE then return end
    sinceRead = sinceRead + self.elapsed
    self.elapsed = 0
    FlightMap:Update(sinceRead >= REFRESH)
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
    PathForeverDB.options.mapFlights = not Enabled()
    PF.Theme.PlayCheckboxSound(PathForeverDB.options.mapFlights)
    ButtonVisual()
    if Enabled() then
        StartDriver()
        FlightMap:Update(true)
    else
        HidePins()
    end
end
local function ButtonEnter(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Flight paths", 1, 1, 1)
    GameTooltip:AddLine(Enabled() and "Flight points are shown on the map: green ones you have found, grey ones you have not."
        or "Show the flight points on the map, and which you have found.", nil, nil, nil, true)
    GameTooltip:Show()
end
local function ButtonLeave() if GameTooltip then GameTooltip:Hide() end end

local function CreateButton()
    local b = CreateFrame("Button", "PathForeverMapFlightsButton", UIParent)
    b:SetSize(36, 36)
    PF.Theme.StyleMapTile(b)
    if HasAtlas(ATLAS.Neutral) then
        b.icon:SetAtlas(ATLAS.Neutral)
    else
        b.icon:SetTexture(FALLBACK_ICON)
        b.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
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

-- Beside the map's top-right corner, under the Entrances button, on the map's layer.
local function MapShown(map)
    if not Allowed() then
        if button then button:Hide() end
        HidePins()
        return
    end
    button = button or CreateButton()
    button:ClearAllPoints()
    button:SetPoint("TOPLEFT", map, "TOPRIGHT", 5, -136)
    if map.GetFrameStrata then button:SetFrameStrata(map:GetFrameStrata()) end
    if map.GetFrameLevel then button:SetFrameLevel(map:GetFrameLevel() + 10) end
    ButtonVisual()
    button:Show()
    if Enabled() then
        StartDriver()
        FlightMap:Update(true)
    end
end
local function MapHidden()
    if button then button:Hide() end
    StopDriver()
end

-- After the Options switch: show or hide the button (and pins) on an open map.
function FlightMap:Refresh()
    local map = _G.WorldMapFrame
    if map and map:IsShown() then MapShown(map) end
end

function FlightMap:Hook()
    local map = _G.WorldMapFrame
    if hooked or type(map) ~= "table" or not map.HookScript then return end
    hooked = true
    map:HookScript("OnShow", MapShown)
    map:HookScript("OnHide", MapHidden)
    if map.IsShown and map:IsShown() then MapShown(map) end
end

-- The world map may load after PathForever: hook at login and whenever an addon loads.
local events = CreateFrame("Frame")
FlightMap.eventFrame = events
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("TAXIMAP_OPENED")
events:SetScript("OnEvent", function(_, event)
    if event == "TAXIMAP_OPENED" then
        FlightMap:Scan()
        -- the window's list can fill a moment after it opens: once more
        if C_Timer and C_Timer.After then
            C_Timer.After(0.5, function() FlightMap:Scan() end)
            C_Timer.After(2, function() FlightMap:Scan() end)
        end
        return
    end
    FlightMap:Hook()
end)
