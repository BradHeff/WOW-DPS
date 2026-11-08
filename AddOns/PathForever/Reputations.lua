-- PathForever: the Reputations page (a Journey module, PF.Reputations).
--
-- Reads the character's own reputations from the client and lists them under the client's
-- own headers, each with its standing and a progress bar; nothing is assumed about which
-- ones a character has. Clicking one opens a popout with where the character stands and
-- how to raise it (ReputationData.lua, looked up by the client's faction ID).
--
-- Reading: C_Reputation.GetFactionDataByIndex (or the old GetFactionInfo), all in pcall.
-- The client lists only the factions under headers that are expanded, so collapsed headers
-- are opened for the read and closed again (never in combat, and the player's own
-- reputation window ends as it was). The Journey's third tile is this module.
--
-- Plain data and calls only, nothing protected.

local PF = PathForever
local Rep = {}
PF.Reputations = Rep
local Journey = PF.Journey

local LABELS = { "Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted" }
-- standings from the bottom of Hated: the points to the next step are what is left of each range
local EXALTED_AT = 42000

local function Theme() return PF.Theme end

local function Label(standing)
    local g = _G["FACTION_STANDING_LABEL" .. tostring(standing)]
    return (type(g) == "string" and g ~= "") and g or LABELS[standing] or "Unknown"
end
Rep.Label = Label

-- red for the bad standings, then yellow, then greens for the good ones
local function StandingColor(standing)
    local T = Theme()
    if standing <= 2 then return { 0.86, 0.30, 0.25 }
    elseif standing == 3 then return { 0.93, 0.55, 0.25 }
    elseif standing == 4 then return { 0.92, 0.80, 0.35 }
    end
    return T.GOOD or { 0.45, 0.8, 0.45 }
end

local function Count()
    if C_Reputation and C_Reputation.GetNumFactions then
        local ok, n = pcall(C_Reputation.GetNumFactions)
        if ok then return tonumber(n) or 0 end
    end
    if GetNumFactions then
        local ok, n = pcall(GetNumFactions)
        if ok then return tonumber(n) or 0 end
    end
    return 0
end

-- One line of the client's list as { name, id, standing, min, max, value, isHeader, hasRep, isChild, collapsed, atWar }.
local function Line(i)
    if C_Reputation and C_Reputation.GetFactionDataByIndex then
        local ok, d = pcall(C_Reputation.GetFactionDataByIndex, i)
        if ok and type(d) == "table" then
            return { name = d.name, id = d.factionID, standing = tonumber(d.reaction) or 4,
                     min = tonumber(d.currentReactionThreshold) or 0, max = tonumber(d.nextReactionThreshold) or 0,
                     value = tonumber(d.currentStanding) or 0, isHeader = d.isHeader and true or false,
                     hasRep = (not d.isHeader) or d.isHeaderWithRep, isChild = d.isChild and true or false,
                     collapsed = d.isCollapsed and true or false, atWar = d.atWarWith and true or false }
        end
    end
    if GetFactionInfo then
        local ok, name, _, standing, min, max, value, atWar, _, isHeader, collapsed, hasRep, _, isChild, id = pcall(GetFactionInfo, i)
        if ok and name then
            return { name = name, id = id, standing = tonumber(standing) or 4, min = tonumber(min) or 0, max = tonumber(max) or 0,
                     value = tonumber(value) or 0, isHeader = isHeader and true or false,
                     hasRep = (not isHeader) or hasRep, isChild = isChild and true or false,
                     collapsed = collapsed and true or false, atWar = atWar and true or false }
        end
    end
end

local function Expand(i, open)
    local fn
    if C_Reputation then fn = open and C_Reputation.ExpandFactionHeader or C_Reputation.CollapseFactionHeader end
    fn = fn or (open and ExpandFactionHeader or CollapseFactionHeader)
    if fn then pcall(fn, i) end
end

-- The character's reputations: { { header = name, list = { entries } } } in the client's order,
-- and the total count.
function Rep:Read()
    local reopened = {}
    Rep.readAt = GetTime and GetTime() or 0
    local inCombat = InCombatLockdown and InCombatLockdown()
    if not inCombat then
        for i = Count(), 1, -1 do -- last first, so the indexes still to visit do not move
            local l = Line(i)
            if l and l.isHeader and l.collapsed then
                Expand(i, true)
                reopened[l.name] = true
            end
        end
    end
    local groups, byName, total = {}, {}, 0
    local header = "Other"
    for i = 1, Count() do
        local l = Line(i)
        if l and l.name then
            if l.isHeader and not l.isChild then header = l.name end
            if l.hasRep and l.max > l.min or (l.hasRep and l.standing == 8) then
                local g = byName[header]
                if not g then g = { header = header, list = {} }; byName[header] = g; groups[#groups + 1] = g end
                g.list[#g.list + 1] = l
                total = total + 1
            end
        end
    end
    if next(reopened) then
        for i = Count(), 1, -1 do
            local l = Line(i)
            if l and l.isHeader and reopened[l.name] then Expand(i, false) end
        end
    end
    Rep.lastTotal = total
    Rep.readAt = GetTime and GetTime() or 0 -- opening and closing headers fires UPDATE_FACTION: not a change
    return groups, total
end

local function Number(n) return (BreakUpLargeNumbers and BreakUpLargeNumbers(n)) or tostring(n) end

-- "1,200 / 6,000" within the current standing, or just the standing at the top
local function Progress(l)
    if l.standing >= 8 then return Label(8), 1 end
    local span = l.max - l.min
    local into = l.value - l.min
    if span <= 0 then return Label(l.standing), 0 end
    return string.format("%s  %s / %s", Label(l.standing), Number(into), Number(span)), math.max(0, math.min(1, into / span))
end

local function Hex(c) return string.format("|cff%02x%02x%02x", math.floor(c[1] * 255 + 0.5), math.floor(c[2] * 255 + 0.5), math.floor(c[3] * 255 + 0.5)) end

local STANDING_OF = {}
for i, n in ipairs(LABELS) do STANDING_OF[n] = i end
local subjects = {}
-- The popout: where you stand, then the guide for this faction.
function Rep:OpenGuide(l)
    if not (PF.UI and PF.UI.ShowInfo) then return end
    local T = Theme()
    local key = l.id or l.name
    local s = subjects[key]
    if not s then s = { sections = {} }; subjects[key] = s end
    wipe(s.sections)
    s.title, s.subtitle = l.name, Label(l.standing)
    s.mapID, s.x, s.y, s.pickup, s.pickupZone, s.mapSection, s.mapLabel = nil, nil, nil, nil, nil, nil, nil
    s.items, s.itemsLabel = nil, nil

    local text, muted = Hex(T.TEXT), Hex(T.MUTED)
    local lines = {}
    if l.standing >= 8 then
        lines[#lines + 1] = Hex(StandingColor(8)) .. "Exalted|r"
    else
        local span, into = l.max - l.min, l.value - l.min
        lines[#lines + 1] = string.format("%s%s|r\n%s%s / %s|r", Hex(StandingColor(l.standing)), Label(l.standing), text, Number(into), Number(span))
        lines[#lines + 1] = string.format("%s%s more to %s|r", muted, Number(math.max(0, l.max - l.value)), Label(l.standing + 1))
        if l.value < EXALTED_AT then
            lines[#lines + 1] = string.format("%s%s more to Exalted|r", muted, Number(EXALTED_AT - l.value))
        end
    end
    if l.atWar then lines[#lines + 1] = Hex(StandingColor(1)) .. "At war|r" end
    s.sections[#s.sections + 1] = { "Where you stand", table.concat(lines, "\n") }

    local g = PathForeverData and PathForeverData.Reputations and PathForeverData.Reputations[l.id]
    if g then
        for _, sec in ipairs(g.sections or {}) do
            if sec[1] ~= "Earn it" and sec[1] ~= "Good to know" then s.sections[#s.sections + 1] = { sec[1], sec[2] } end
        end
        -- who sells the rewards: the first vendor with a place on the map gets the Mark on map button
        local vendors = g.vendors
        if vendors and #vendors > 0 then
            local lines = {}
            for _, v in ipairs(vendors) do
                lines[#lines + 1] = text .. v.name .. "|r"
                lines[#lines + 1] = muted .. v.zone .. "|r"
            end
            s.sections[#s.sections + 1] = { "Vendor", table.concat(lines, "\n") }
            local v = vendors[1]
            if v.map and v.x and v.y then
                s.mapID, s.x, s.y, s.pickup, s.pickupZone = v.map, v.x, v.y, v.name, v.zone
                s.mapSection, s.mapLabel = "Vendor", "Mark vendor on map"
            end
        end
        if g.rewards and #g.rewards > 0 then
            s.items, s.itemsLabel = {}, "Rewards"
            for _, rw in ipairs(g.rewards) do
                local reached = l.standing >= (STANDING_OF[rw[1]] or 9)
                s.items[#s.items + 1] = { name = rw[2], id = rw[3],
                    slot = (reached and Hex(StandingColor(5)) or muted) .. rw[1] .. "|r" }
            end
        end
    end
    if T.PlayUISound then T.PlayUISound("IG_QUEST_LIST_SELECT") end
    PF.UI.ShowInfo(s)
end

-- ---------- the module ----------
local Module = { id = "reputation", label = "Reputations", priority = 0, mini = true }
function Module:IsRelevant() return true end
function Module:IsComplete() return false end

function Module:Summary()
    local total = Rep.lastTotal
    if not total then local _, t = Rep:Read(); total = t end
    if total == 0 then return "None yet" end
    return total .. (total == 1 and " reputation" or " reputations")
end

local function OpenEntry(l) Rep:OpenGuide(l) end

function Module:Render(p)
    local groups, total = Rep:Read()
    if total == 0 then
        p:AddNote("No reputations yet.")
        return
    end
    for _, g in ipairs(groups) do
        p:AddHeader(g.header)
        for _, l in ipairs(g.list) do
            local sub, frac = Progress(l)
            p:AddRow(l.name, nil, sub, nil, nil, OpenEntry, l, nil, nil, frac)
        end
    end
end

Journey:RegisterModule(Module)
Journey.PAGE_OF.reputation = "Reputations"
Journey.PAGES.Reputations = "reputation"

-- standings change as you play
local events = CreateFrame("Frame")
events:RegisterEvent("UPDATE_FACTION")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_ENTERING_WORLD" then
        Rep.lastTotal = nil -- another character, or a fresh login: read again when asked
        return
    end
    -- our own header opening and closing also fires this; redrawing then would rebuild the rows under the mouse
    if Rep.readAt and GetTime and GetTime() - Rep.readAt < 1 then return end
    if PF.RequestRefresh then PF:RequestRefresh("reputation") end
end)
