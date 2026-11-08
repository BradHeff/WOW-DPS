-- PathForever: the dungeon history (PF.History), drawn as the History page (UI.lua's
-- PF:RenderHistoryTab).
--
-- A run journal. Walking into a dungeon starts a run; leaving it ends the run and saves
-- how long it took, the XP you gained, the gold you made or spent, and the green and
-- better items you looted. The page lists each dungeon you have run with your runs, the
-- average time and the XP per hour, best first, so you can see which dungeon pays most at
-- your level, then your latest runs. A line in chat sums up each run.
--
-- Everything is read from events and plain APIs (IsInInstance, GetInstanceInfo, UnitXP,
-- GetMoney, CHAT_MSG_LOOT); nothing here is protected and it never touches Blizzard's
-- windows. Runs shorter than two minutes are dropped (a walk in to look, a reset). The run
-- in progress is saved every few seconds, so a /reload or a disconnect inside a dungeon
-- doesn't lose it. Dying doesn't end a run: a ghost outside the dungeon is running back, so the run
-- waits (up to half an hour) and carries on when you walk in again; the time you spend running
-- back counts, and deaths are counted.
--
-- Saved in PathForeverDB.history: { runs = { run, ... }, current = run }, where a run is
-- { name, guid, char, level, start, finish, xp, money, green, rare, other, deaths, items }, where items
-- is the green and better loot as { { id, n, q } } (q: 2 green, 3 rare or better).

local PF = PathForever
local History = {}
PF.History = History

local MAX_RUNS = 200           -- runs kept; the oldest go first
local MIN_RUN = 120            -- seconds; a shorter stay is not a run
local MAX_ITEMS = 30           -- different green and better items kept per run
local SHOWN_ITEMS = 20         -- items listed in a summary
local AWAY_ALIVE = 600         -- seconds a run waits for you to come back after you step outside
local AWAY_DEAD = 1800         -- ... and after you died (running back takes longer)
local TICK = 10                -- seconds between saves of the run in progress
local LISTED = 40              -- runs listed on the page, newest first
local PREFIX = "|cff3fc7ebPathForever|r "

-- Item link colours by quality, for links written as |cffRRGGBB (newer clients write |cnIQ2:).
local HEX_QUALITY = { ["9d9d9d"] = 0, ["ffffff"] = 1, ["1eff00"] = 2, ["0070dd"] = 3, ["a335ee"] = 4,
    ["ff8000"] = 5, ["e6cc80"] = 6, ["00ccff"] = 7 }
local stats = { seen = 0, counted = 0, errors = 0 } -- what the loot messages did (/pf runs debug)
History.stats = stats

local current                  -- the run in progress (also kept in the saved variable)
local lastXP, lastXPMax        -- the XP baseline, for turning updates into gains
local fresh = true             -- the first look after loading: a stale saved run ends at its last save

local function Now()
    if time then return time() end
    return GetTime and GetTime() or 0
end

local function DB()
    if type(PathForeverDB) ~= "table" then return { runs = {} } end
    if type(PathForeverDB.history) ~= "table" then PathForeverDB.history = {} end
    local db = PathForeverDB.history
    if type(db.runs) ~= "table" then db.runs = {} end
    return db
end

-- ---------- Formatting ----------
local function Duration(secs)
    secs = math.max(0, math.floor((secs or 0) + 0.5))
    local h, m, s = math.floor(secs / 3600), math.floor(secs % 3600 / 60), secs % 60
    if h > 0 then return string.format("%d:%02d:%02d", h, m, s) end
    return string.format("%d:%02d", m, s)
end

local function Thousands(n)
    n = math.floor((n or 0) + 0.5)
    if n >= 10000 then return string.format("%.1fk", n / 1000) end
    local out = tostring(n):reverse():gsub("(%d%d%d)", "%1,"):reverse()
    return (out:gsub("^,", ""))
end

local function Coin(copper)
    copper = math.floor(copper or 0)
    local sign = copper < 0 and "-" or ""
    copper = math.abs(copper)
    local g, s = math.floor(copper / 10000), math.floor(copper % 10000 / 100)
    if g > 0 then return string.format("%s%dg %ds", sign, g, s) end
    return string.format("%s%ds", sign, s)
end
History.Duration, History.Coin, History.Thousands = Duration, Coin, Thousands

-- ---------- The runs ----------
local function Valid(r)
    return type(r) == "table" and type(r.name) == "string" and type(r.start) == "number" and type(r.finish) == "number"
end

-- Whether the page lists every character's runs (Options-style switch on the page itself).
function History:AccountWide()
    return PathForeverDB and PathForeverDB.options and PathForeverDB.options.historyAccount == true
end

-- A run belongs to this character when its guid is yours (runs saved without one are account-wide only).
local function Mine(r)
    return UnitGUID ~= nil and r.guid ~= nil and r.guid == UnitGUID("player")
end

-- The character that ran it: the name saved with the run, else the saved character for its guid.
function History:CharName(r)
    if type(r.char) == "string" and r.char ~= "" then return r.char end
    local c = type(r.guid) == "string" and PathForeverDB and PathForeverDB.characters and PathForeverDB.characters[r.guid]
    if type(c) == "table" and type(c.name) == "string" and c.name ~= "" then return c.name end
    return nil
end

-- The latest runs, newest first (each is the saved run itself: do not change it).
-- This character's, or everyone's while the account-wide switch is on.
function History:Recent(n)
    local runs, out, all = DB().runs, {}, History:AccountWide()
    for i = #runs, 1, -1 do
        if Valid(runs[i]) and (all or Mine(runs[i])) then out[#out + 1] = runs[i] end
        if #out >= (n or LISTED) then break end
    end
    return out
end

-- The details of one run as a line: "21:14 - 4,200 XP (11,900/h) - 1g 20s - 2 green, 1 rare or better".
function History:Describe(r, withName)
    local parts = {}
    if withName then parts[1] = r.name end
    parts[#parts + 1] = Duration(r.finish - r.start)
    if (r.xp or 0) > 0 then
        parts[#parts + 1] = string.format("%s XP (%s/h)", Thousands(r.xp), Thousands(r.xp / ((r.finish - r.start) / 3600)))
    end
    if (r.money or 0) ~= 0 then parts[#parts + 1] = Coin(r.money) end
    if (r.green or 0) + (r.rare or 0) > 0 then
        parts[#parts + 1] = string.format("%d green, %d rare or better", r.green or 0, r.rare or 0)
    end
    if (r.deaths or 0) > 0 then parts[#parts + 1] = string.format("%d %s", r.deaths, r.deaths == 1 and "death" or "deaths") end
    return table.concat(parts, " - ")
end

function History:Count()
    local runs, n, all = DB().runs, 0, History:AccountWide()
    for i = 1, #runs do
        if Valid(runs[i]) and (all or Mine(runs[i])) then n = n + 1 end
    end
    return n
end
function History:Clear() DB().runs = {} end

-- The run in progress, or nil: { name, start, ... }.
function History:Current() return current end
function History:Elapsed() return current and ((current.away or Now()) - current.start) or nil end

-- ---------- Recording ----------
local function Changed()
    if PF.RequestRefresh then PF:RequestRefresh("history") end
end

local function Save()
    DB().current = current
end

local function Finish(finishTime, live)
    if not current then return end
    local r = current
    current = nil
    if live and GetMoney then r.moneyNow = GetMoney() end
    r.finish = finishTime
    r.money = (r.moneyNow or r.money0 or 0) - (r.money0 or 0)
    r.moneyNow, r.money0, r.last, r.away, r.awayDead, r.awayMoney = nil, nil, nil, nil, nil, nil
    local db = DB()
    db.current = nil
    if r.finish - r.start >= MIN_RUN then
        db.runs[#db.runs + 1] = r
        while #db.runs > MAX_RUNS do table.remove(db.runs, 1) end
        print(PREFIX .. History:Describe(r, true))
    end
    Changed()
end

-- Ends the run that is waiting for you to come back (the page offers it).
function History:EndRun()
    if current and current.away then Finish(current.away, false) end
end

local function Start(name)
    current = {
        name = name, guid = UnitGUID and UnitGUID("player"), char = UnitName and UnitName("player"), level = UnitLevel and UnitLevel("player") or 0,
        start = Now(), last = Now(), xp = 0, green = 0, rare = 0, other = 0, deaths = 0, items = {},
        money0 = GetMoney and GetMoney() or 0,
    }
    current.moneyNow = current.money0
    Save()
    Changed()
end

-- Where you stand: in a dungeon or raid (its name), or nil.
local function Where()
    if not IsInInstance then return nil end
    local inside, kind = IsInInstance()
    if not inside or (kind ~= "party" and kind ~= "raid") then return nil end
    local name = GetInstanceInfo and GetInstanceInfo()
    if type(name) ~= "string" or name == "" then return nil end
    return name
end

local function ReadXP()
    lastXP = UnitXP and UnitXP("player") or nil
    lastXPMax = UnitXPMax and UnitXPMax("player") or nil
end

local function Evaluate()
    local name = Where()
    if fresh then
        fresh = false
        local saved = DB().current
        if type(saved) == "table" and type(saved.name) == "string" and type(saved.start) == "number" then
            current = saved
            current.items = type(current.items) == "table" and current.items or {}
            if name ~= saved.name and not saved.away then
                Finish(saved.last or saved.start, false) -- it ended while we were away
            end
            -- (the same dungeon: a /reload or reconnect inside it, so the run carries on)
        end
    end
    if current then
        if name == current.name then
            if current.away then -- back inside: the time and gold outside don't count, except a corpse run's time
                if not current.awayDead then current.start = current.start + (Now() - current.away) end
                local m = GetMoney and GetMoney()
                if m and current.awayMoney then current.money0 = (current.money0 or 0) + (m - current.awayMoney) end
                current.moneyNow = m or current.moneyNow
                current.away, current.awayDead, current.awayMoney = nil, nil, nil
                Save()
            end
        elseif current.away then
            -- stepped outside (to summon someone, or after a death): ends if you go to another
            -- dungeon or take too long
            if name or Now() - current.away > (current.awayDead and AWAY_DEAD or AWAY_ALIVE) then Finish(current.away, false) end
        else
            -- the run waits: you may be back in a moment
            current.away = Now()
            current.awayDead = (UnitIsDeadOrGhost and UnitIsDeadOrGhost("player")) and true or false
            current.awayMoney = GetMoney and GetMoney() or nil
            current.moneyNow = current.awayMoney or current.moneyNow
            Save()
        end
    end
    if name and not current then Start(name) end
    ReadXP()
end

local function OnXP()
    if not (UnitXP and UnitXPMax) then return end
    local xp, max = UnitXP("player"), UnitXPMax("player")
    if lastXP and current and not current.away and type(xp) == "number" then
        local gain
        if xp >= lastXP then gain = xp - lastXP else gain = (lastXPMax or 0) - lastXP + xp end -- a level-up wraps the bar
        if gain > 0 then current.xp = current.xp + gain end
    end
    lastXP, lastXPMax = xp, max
end

-- The quality of a looted item: from the link's colour, else from the client.
local function QualityOf(text, id)
    local n = text:match("|cnIQ(%d+)")
    if n then return tonumber(n) end
    local hex = text:match("|cff(%x%x%x%x%x%x)|Hitem:")
    if hex and HEX_QUALITY[hex] then return HEX_QUALITY[hex] end
    if C_Item and C_Item.GetItemQualityByID then
        local ok, q = pcall(C_Item.GetItemQualityByID, id)
        if ok and type(q) == "number" then return q end
    end
    if C_Item and C_Item.GetItemInfo then
        local ok, _, _, q = pcall(C_Item.GetItemInfo, id)
        if ok and type(q) == "number" then return q end
    end
end

-- Whether a loot message is about you: its guid, else the game's own "You receive loot: " wording.
local function IsMine(text, guid)
    if UnitGUID and guid and guid == UnitGUID("player") then return true end
    for _, fmt in ipairs({ LOOT_ITEM_SELF, LOOT_ITEM_PUSHED_SELF, LOOT_ITEM_CREATED_SELF }) do
        if type(fmt) == "string" and text:find((fmt:gsub("%%s.*$", "")), 1, true) == 1 then return true end
    end
    return false
end

local function OnLoot(text, guid)
    if not (current and not current.away and type(text) == "string") then return end
    stats.lastText = text
    if not IsMine(text, guid) then return end
    local id = tonumber(text:match("|Hitem:(%d+)"))
    if not id then return end
    local n = tonumber(text:match("|h|rx(%d+)")) or 1
    local quality = QualityOf(text, id)
    if not quality then return end
    stats.counted = stats.counted + 1
    if quality < 2 then
        current.other = (current.other or 0) + n
        return
    end
    local q = quality == 2 and 2 or 3
    if q == 2 then current.green = current.green + 1 else current.rare = current.rare + 1 end
    for _, it in ipairs(current.items) do
        if it.id == id then it.n = it.n + n return end
    end
    if #current.items < MAX_ITEMS then current.items[#current.items + 1] = { id = id, n = n, q = q } end
end

-- ---------- One run's summary, in the side panel ----------
local subject = { sections = {} }
function History:ShowRun(r)
    if not (PF.UI and PF.UI.ShowInfo) or not Valid(r) then return end
    wipe(subject.sections)
    local function add(header, body) subject.sections[#subject.sections + 1] = { header, body } end
    local len = math.max(0, r.finish - r.start)
    subject.title = r.name
    local when = date and date("%d %b, %H:%M", r.finish) or nil
    subject.subtitle = when and ("Run ended " .. when) or "Run"

    local who = History:CharName(r)
    if who then add("Character", who) end

    local time = { Duration(len) }
    if (r.deaths or 0) > 0 then time[#time + 1] = string.format("%d %s", r.deaths, r.deaths == 1 and "death" or "deaths") end
    add("Time", table.concat(time, "\n"))

    if (r.xp or 0) > 0 then
        local xp = Thousands(r.xp) .. " XP"
        if len > 0 then xp = xp .. "\n" .. Thousands(r.xp / len * 3600) .. " XP an hour" end
        add("Experience", xp)
    else
        add("Experience", "No XP recorded")
    end

    add("Gold", (r.money or 0) >= 0 and (Coin(r.money or 0) .. " made") or (Coin(-(r.money or 0)) .. " spent"))

    local loot = string.format("%d green, %d rare or better", r.green or 0, r.rare or 0)
    if (r.other or 0) > 0 then loot = loot .. string.format("\n%d grey and white", r.other) end
    add("Loot", loot)

    local items = {}
    local list = type(r.items) == "table" and r.items or {}
    for i = 1, math.min(SHOWN_ITEMS, #list) do
        items[#items + 1] = { id = list[i].id, slot = (list[i].n or 1) > 1 and ("x" .. list[i].n) or "" }
    end
    table.sort(items, function(a, b)
        local qa, qb = 0, 0
        for _, it in ipairs(list) do
            if it.id == a.id then qa = it.q or 0 end
            if it.id == b.id then qb = it.q or 0 end
        end
        if qa ~= qb then return qa > qb end
        return a.id < b.id
    end)
    if #items > 0 then
        subject.items, subject.itemsLabel = items, "Loot received"
    else
        subject.items, subject.itemsLabel = nil, nil
    end
    PF.UI.ShowInfo(subject)
end

-- ---------- Resetting the dungeons ends a run that is waiting ----------
-- "Reset all instances" makes a fresh dungeon, so the paused run is over. Two ways to notice:
-- the system message "<dungeon> has been reset." (INSTANCE_RESET_SUCCESS) for that dungeon, and
-- the reset button itself (a post-hook on ResetInstances, which never changes what it does).
local resetPattern
do
    local fmt = INSTANCE_RESET_SUCCESS
    if type(fmt) == "string" then
        resetPattern = "^" .. fmt:gsub("([%^%$%(%)%.%[%]%*%+%-%?])", "%%%1"):gsub("%%s", "(.+)") .. "$"
    end
end

local function OnResetMessage(text)
    if not (current and current.away and resetPattern and type(text) == "string") then return end
    local name = text:match(resetPattern)
    if name and name == current.name then Finish(current.away, false) end
end

local function OnResetButton()
    if not (current and current.away) then return end
    -- only the party leader can reset; anyone else's click does nothing
    if IsInGroup and IsInGroup() and UnitIsGroupLeader and not UnitIsGroupLeader("player") then return end
    Finish(current.away, false)
end
History.OnResetButton = OnResetButton -- (for the tests)

if hooksecurefunc and type(ResetInstances) == "function" then
    pcall(hooksecurefunc, "ResetInstances", OnResetButton)
end

function History:Debug()
    local inside, kind = false, "none"
    if IsInInstance then inside, kind = IsInInstance() end
    print(PREFIX .. string.format("history: inside %s (%s), instance name %q, run in progress %s, %d saved run(s)",
        tostring(inside), tostring(kind), tostring(GetInstanceInfo and (GetInstanceInfo()) or ""),
        current and current.name or "none", #DB().runs))
    print(PREFIX .. string.format("  loot messages: %d seen, %d counted, %d errors%s", stats.seen, stats.counted, stats.errors,
        stats.lastError and (" (last: " .. stats.lastError .. ")") or ""))
    if stats.lastText then print(PREFIX .. "  last loot message in a run: " .. (stats.lastText:gsub("|", "||"))) end
    if current then
        print(PREFIX .. string.format("  %s so far, %d XP, %s, %d green, %d rare or better",
            Duration(Now() - current.start), current.xp, Coin((current.moneyNow or 0) - (current.money0 or 0)),
            current.green, current.rare))
    end
end

-- ---------- Watching ----------
local events = CreateFrame("Frame")
History.eventFrame = events -- (lets the tests drive it)
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_XP_UPDATE")
events:RegisterEvent("PLAYER_MONEY")
events:RegisterEvent("PLAYER_DEAD")
events:RegisterEvent("CHAT_MSG_SYSTEM")
events:RegisterEvent("CHAT_MSG_LOOT")
events:SetScript("OnEvent", function(_, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        Evaluate()
        -- Forever's character data arrives late after a login: take the XP baseline again shortly.
        if C_Timer and C_Timer.After then C_Timer.After(5, ReadXP) end
    elseif event == "PLAYER_XP_UPDATE" then
        pcall(OnXP)
    elseif event == "CHAT_MSG_SYSTEM" then
        pcall(OnResetMessage, (...))
    elseif event == "PLAYER_DEAD" then
        if current then current.deaths = (current.deaths or 0) + 1; Save() end
    elseif event == "PLAYER_MONEY" then
        if current and not current.away and GetMoney then current.moneyNow = GetMoney() end
    elseif event == "CHAT_MSG_LOOT" then
        stats.seen = stats.seen + 1
        local ok, err = pcall(OnLoot, (...), select(12, ...))
        if not ok then stats.errors, stats.lastError = stats.errors + 1, tostring(err) end
    end
end)

-- Save the run in progress every few seconds (with its time, for a crash), and redraw the
-- page's running clock if it is open.
events.tick, events.clock = 0, 0
events:SetScript("OnUpdate", function(self, elapsed)
    if not current then return end
    -- the page's running clock, every second
    self.clock = self.clock + elapsed
    if self.clock >= 1 then
        self.clock = 0
        if PF.UpdateHistoryClock then PF.UpdateHistoryClock() end
    end
    self.tick = self.tick + elapsed
    if self.tick < TICK then return end
    self.tick = 0
    if current.away then
        if Now() - current.away > (current.awayDead and AWAY_DEAD or AWAY_ALIVE) then Finish(current.away, false) end -- never came back
        return
    end
    current.last = Now()
    if GetMoney then current.moneyNow = GetMoney() end
    Save()
    Changed()
end)
