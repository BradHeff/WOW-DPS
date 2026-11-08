-- Auction.lua - PathForever Auction
-- A panel that opens beside the auction house window (same size and look as PathForever's
-- popouts) and changes with the window's tab:
--   Buy      - scan the auction house, gear listed for less than it disenchants into (priced
--              from your scans, at a roll you pick), settings for buying, price check
--   Sell     - price check, a suggested price with an undercut you set, what in your bags is worth listing
--   Auctions - your own auctions, each marked: lowest, undercut, priced above typical
-- Prices are learned three ways: a full scan, whatever the auction window itself shows you
-- while you browse, and an item you open there. Item tooltips then show the price, its age,
-- how many are listed, what your bags hold, and how it compares with the usual.
--
-- Prices live in PathForeverAuctionDB (its own saved variable: a scan holds thousands of
-- items). Per item: the lowest unit price (p), units listed (q), auctions (n), when seen (t) and
-- a short history of lowest prices (h). Nothing older than two weeks is used.
--
-- Nothing here is protected or secure. The auction window's own frames are only read, and only
-- by pcall (a frame that is missing changes nothing); our panel is its own frame, anchored to
-- theirs, never a child of it. A purchase is PlaceBid on an auction a search has just found,
-- and the game wants a click for it: the first click on a deal searches, the second places the
-- bid (the row says so once the auction is found).
--
-- Unverified on Forever (docs/launch-checklist.md): every C_AuctionHouse call below, the
-- replicate list's field order and whether its price is per unit or per stack, and the
-- window's frame names. Each is in a pcall and the panel says so when something is missing.

local PF = PathForever
local Auction = {}
PF.Auction = Auction

local Theme = PF.Theme
local D = PathForeverAuctionData

local WIDTH = 300
local PAD = 16
local CHILD_W = 266
local TEXT_W = CHILD_W - 2 * 8
local ROW_H = 20
local MAX_AGE = 14 * 86400     -- a price older than this is not used
local HISTORY_GAP = 6 * 3600   -- one history point per this many seconds
local HISTORY_MAX = 12
local CHUNK = 500              -- replicate rows read per frame
local WAIT_LIMIT = 30          -- seconds to wait for the auction house to answer a scan
local AH_CUT = 0.05
local DEAL_LIST = 1000
local DEAL_KEEP = 300
local BAG_LIST = 8

local DEFAULTS = {
    roll = "average",   -- low (safe), average or high (risky)
    cut = true,         -- count the auction house's cut off what the materials sell for
    confirm = false,    -- ask before buying
    minProfit = 0,      -- copper
    maxPrice = 0,       -- copper, 0 for no limit
    undercut = 1,       -- percent
    floor = 70,         -- percent of the typical price
    basis = "lowest",   -- lowest or typical
    view = "deals",     -- the Buy tab shows deals, shopping or recent
    resaleBelow = 75,   -- percent of the usual price a resale deal must be listed under
    confirmPct = 10,    -- ask before a buy this big a share of your gold (0 for never)
    match = false,      -- list at the lowest price instead of under it
}
local CHART_H = 36           -- height of the price history chart
local SALES_MAX = 30
local SALES_SHOWN = 5
local STALE = 6 * 3600     -- a scan older than this is called old
local RECENT_MAX = 8
local OTHER_LIST = 1000     -- resale and vendor deals shown each

local function Now() return GetServerTime and GetServerTime() or 0 end

local function DB()
    if type(PathForeverAuctionDB) ~= "table" then PathForeverAuctionDB = {} end
    local db = PathForeverAuctionDB
    if type(db.prices) ~= "table" then db.prices = {} end
    if type(db.deals) ~= "table" then db.deals = {} end
    if type(db.options) ~= "table" then db.options = {} end
    if type(db.shopping) ~= "table" then db.shopping = {} end
    if type(db.recent) ~= "table" then db.recent = {} end
    for _, k in ipairs({ "memory", "sales", "bought", "owned", "soldSeen" }) do
        if type(db[k]) ~= "table" then db[k] = {} end
    end
    for k, v in pairs(DEFAULTS) do
        if db.options[k] == nil then db.options[k] = v end
    end
    return db
end
Auction.DB = DB

local function Money(c)
    local J = PF.Journey
    return J and J.FormatMoney and J.FormatMoney(c) or tostring(math.floor(c or 0))
end

local function Say(text) print("|cff3fc7ebPathForever Auction:|r " .. text) end

local function Hex(c) return Theme.ColorHex(c) end

local function QualityHex(q)
    local c = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[q]
    return c and Hex({ c.r, c.g, c.b }) or Hex(Theme.TEXT)
end

local function Ago(t)
    local s = Now() - (t or 0)
    if s < 90 then return "just now" end
    if s < 3600 then return math.floor(s / 60) .. " min ago" end
    if s < 86400 then return math.floor(s / 3600) .. " h ago" end
    return math.floor(s / 86400) .. " d ago"
end

-- ---------- prices ----------
-- The record for an item, or nil when there is none or it is too old.
function Auction:Price(id)
    local r = DB().prices[id]
    if r and r.p and r.t and Now() - r.t <= MAX_AGE then return r end
end

local function PriceOf(id)
    local r = Auction:Price(id)
    return r and r.p or nil
end

local function Record(db, id, p, q, n, now)
    if type(id) ~= "number" or type(p) ~= "number" or p <= 0 then return end
    local r = db.prices[id]
    if not r then r = {}; db.prices[id] = r end
    Auction.priceStamp = (Auction.priceStamp or 0) + 1 -- the resale and vendor lists are worked out again
    r.p, r.q, r.t = p, q or r.q, now
    if n then r.n = n end
    local h = r.h
    if type(h) ~= "table" then h = {}; r.h = h end
    local last = h[#h]
    if not last or now - last[1] >= HISTORY_GAP then
        h[#h + 1] = { now, p }
        if #h > HISTORY_MAX then table.remove(h, 1) end
    else
        last[2] = p
    end
end

-- Forget what is too old.
local function Prune(db)
    local now = Now()
    for id, r in pairs(db.prices) do
        if type(r) ~= "table" or not r.t or now - r.t > MAX_AGE then db.prices[id] = nil end
    end
    for aid, t in pairs(db.soldSeen) do
        if type(t) ~= "number" or now - t > 7 * 86400 then db.soldSeen[aid] = nil end
    end
end

-- The usual price: the middle of the lowest prices seen over time. Needs three points.
function Auction:Typical(id)
    local r = DB().prices[id]
    local h = r and r.h
    if type(h) ~= "table" or #h < 3 then return nil, #(h or {}) end
    local list = {}
    for i, pt in ipairs(h) do list[i] = pt[2] end
    table.sort(list)
    local n = #list
    local mid = (n % 2 == 1) and list[(n + 1) / 2] or (list[n / 2] + list[n / 2 + 1]) / 2
    return math.floor(mid), n
end

-- cheap, fair or pricey against the usual, or nil
local function Verdict(now, typical)
    if not (now and typical and typical > 0) then return nil end
    local ratio = now / typical
    if ratio <= 0.85 then return "cheap", ratio end
    if ratio >= 1.15 then return "pricey", ratio end
    return "fair", ratio
end

local VERDICT_TEXT = { cheap = "Cheap now", fair = "Fair", pricey = "Pricey now" }
local function VerdictColor(v)
    if v == "cheap" then return Theme.GOOD end
    if v == "pricey" then return Theme.BAD end
    return Theme.TEXT
end

-- ---------- disenchant deals ----------
local function IsGear(id)
    Auction.gearKind = Auction.gearKind or {}
    local k = Auction.gearKind[id]
    if k ~= nil then return k end
    k = false
    local ok, _, _, _, loc, _, classID = pcall(C_Item.GetItemInfoInstant, id)
    if ok then
        if classID == 2 then
            k = "weapon"
        elseif classID == 4 and type(loc) == "string" and loc ~= "" and loc ~= "INVTYPE_BODY" and loc ~= "INVTYPE_TABARD" then
            k = "armor"
        end
    end
    Auction.gearKind[id] = k
    return k
end

-- What a deal's materials are worth at the chosen roll, after the auction house's cut when
-- that is switched on; nil when no result has a price yet.
function Auction:DealValue(d, roll)
    local o = DB().options
    local out = D.Outcomes(d.q, d.w, d.l)
    local v = D.Value(out, roll or o.roll, PriceOf)
    if v and o.cut then v = math.floor(v * (1 - AH_CUT)) end
    return v
end

-- The deals worth showing now: bought for less than they disenchant into, best profit first.
function Auction:Deals()
    local o = DB().options
    local list = {}
    for _, d in ipairs(DB().deals) do
        local v = Auction:DealValue(d)
        if v then
            local profit = v - d.b
            if profit > 0 and profit >= (o.minProfit or 0) and (not o.maxPrice or o.maxPrice <= 0 or d.b <= o.maxPrice) then
                list[#list + 1] = { d = d, value = v, profit = profit }
            end
        end
    end
    table.sort(list, function(a, b) return a.profit > b.profit end)
    return list
end

-- ---------- scanning ----------
local scan = { active = false }
local window, bar, pop

-- What the bar says while it works: the real steps of each phase, with a line of fun between.
local STEPS = {
    wait = { "Asking the auction house", "Waiting for the auctioneer to find the list", "Dusting off the ledgers" },
    read = { "Reading the listings", "Writing down the prices", "Sorting the gear from the junk",
             "Weighing the dust against the gear", "Working out the disenchants" },
}
local FUN = {
    "Making a deal with a goblin", "Haggling with a gnome", "Bribing the auctioneer", "Counting the copper twice",
    "Polishing the gold", "Asking a murloc what it is worth", "Shaking down the Booty Bay brokers",
    "Checking the dwarf's math", "Teaching an ogre to count", "Reading the fine print in Orcish",
    "Feeding the auction house cat", "Sharpening the pencils",
}
local MESSAGE_MIN, MESSAGE_MAX = 2, 5 -- a line stays up a random time between these, in seconds

local function NextMessage()
    local list = STEPS[scan.phase] or STEPS.wait
    scan.n = (scan.n or 0) + 1
    -- a real step, then a joke, so what it is doing and a bit of fun take turns
    if scan.n % 2 == 1 then
        scan.stepIx = ((scan.stepIx or 0) % #list) + 1
        return list[scan.stepIx]
    end
    scan.funIx = ((scan.funIx or math.random(#FUN)) % #FUN) + 1
    return FUN[scan.funIx]
end

local function ShowBar(text, frac)
    if not bar then return end
    bar:Show()
    bar.label:SetText(text)
    frac = math.max(0, math.min(1, frac or 0))
    -- never back: the bar only moves forward within a scan
    scan.shown = math.max(scan.shown or 0, frac)
    bar.fill:SetWidth(math.max(1, math.floor((bar:GetWidth() - 24) * scan.shown)))
end

-- Redraws the bar: the line changes every few seconds and the fill moves on. Waiting for the
-- auction house has no real progress to show, so it creeps towards a third of the bar and
-- never gets there; reading fills the rest as rows are read.
local function TickBar(elapsed)
    scan.msgT = (scan.msgT or 0) + elapsed
    if not scan.msgAt or scan.msgT >= scan.msgAt then
        scan.msgT = 0
        scan.msgAt = MESSAGE_MIN + math.random() * (MESSAGE_MAX - MESSAGE_MIN)
        scan.msg = NextMessage()
    end
    local frac
    if scan.phase == "wait" then
        frac = 0.30 * (1 - 1 / (1 + (scan.waited or 0) / 4))
    else
        frac = 0.30 + 0.70 * (scan.total > 0 and scan.i / scan.total or 1)
    end
    ShowBar(string.format("%s  %d%%", scan.msg or "Working", math.floor(math.max(scan.shown or 0, frac) * 100)), frac)
end

local function EndScan(message, ok)
    scan.active = false
    -- a scan that ended without finishing leaves its reason on the panel, not only in chat
    Auction.scanNote = (not ok) and message or nil
    if bar then bar:Hide() end
    if message then Say(message) end
    Auction:Render()
end

local function FinishScan()
    local db = DB()
    local now = Now()
    local count = 0
    for id, a in pairs(scan.agg) do
        Record(db, id, a.p, a.q, a.n, now)
        count = count + 1
    end
    -- the gear worth a second look: could pay for itself at the best roll
    local keep = {}
    for _, c in ipairs(scan.cand) do
        local hi = D.Value(D.Outcomes(c.q, c.w, c.l), "high", PriceOf)
        if hi and hi * (1 - AH_CUT) > c.b then keep[#keep + 1] = c end
    end
    table.sort(keep, function(a, b) return a.b < b.b end)
    while #keep > DEAL_KEEP do keep[#keep] = nil end
    db.deals = keep
    db.lastScan = { t = now, items = count, rows = scan.total }
    Prune(db)
    EndScan(string.format("Scanned %d items from %d auctions.", count, scan.total), true)
end

local function ReadRows(upTo)
    local get = C_AuctionHouse.GetReplicateItemInfo
    for i = scan.i + 1, upTo do
        local ok, name, _, count, quality, _, _, _, _, _, buyout, _, _, _, _, _, saleStatus, itemID =
            pcall(get, i)
        if ok and type(itemID) == "number" and type(buyout) == "number" and buyout > 0 and saleStatus ~= 1 then
            count = (type(count) == "number" and count > 0) and count or 1
            local unit = buyout / count
            local a = scan.agg[itemID]
            if not a then a = { p = unit, q = 0, n = 0 }; scan.agg[itemID] = a end
            if unit < a.p then a.p = unit end
            a.q, a.n = a.q + count, a.n + 1
            if count == 1 and type(quality) == "number" and quality >= 2 and quality <= 4 then
                local kind = IsGear(itemID)
                if kind then
                    local link = C_AuctionHouse.GetReplicateItemLink and C_AuctionHouse.GetReplicateItemLink(i)
                    local ilvl
                    if C_Item.GetDetailedItemLevelInfo then
                        local okL, v = pcall(C_Item.GetDetailedItemLevelInfo, link or itemID)
                        if okL then ilvl = v end
                    end
                    if not ilvl then
                        local okI, _, _, _, base = pcall(C_Item.GetItemInfo, itemID)
                        if okI then ilvl = base end
                    end
                    if D.Outcomes(quality, kind == "weapon", ilvl) then
                        scan.cand[#scan.cand + 1] = { id = itemID, n = name, l = ilvl, q = quality, w = kind == "weapon", b = buyout }
                    end
                end
            end
        elseif not ok or not itemID then
            scan.skipped = scan.skipped + 1
        end
    end
    scan.i = upTo
end

local OnReplicate
local function ScanStep(elapsed)
    if not scan.active then return end
    if scan.phase == "wait" then
        scan.waited = (scan.waited or 0) + elapsed
        -- some clients fill the list without saying so: look now and then once it has had a while
        if scan.waited > 6 then
            scan.pollT = (scan.pollT or 0) + elapsed
            if scan.pollT >= 1 then
                scan.pollT = 0
                local ok, n = pcall(C_AuctionHouse.GetNumReplicateItems)
                if ok and type(n) == "number" and n > 0 then OnReplicate() end
            end
        end
        if scan.phase == "wait" and scan.waited > WAIT_LIMIT then
            EndScan("The auction house did not answer the scan. A full scan can be asked for about every 15 minutes.")
            return
        end
        if scan.active then TickBar(elapsed) end
        return
    end
    local upTo = math.min(scan.total, scan.i + CHUNK)
    ReadRows(upTo)
    TickBar(elapsed)
    if scan.i >= scan.total then FinishScan() end
end

function Auction:StartScan()
    if scan.active then return end
    if not Auction.ahOpen then Say("Open the auction house first.") return end
    if not (C_AuctionHouse and C_AuctionHouse.ReplicateItems and C_AuctionHouse.GetNumReplicateItems
        and C_AuctionHouse.GetReplicateItemInfo) then
        Say("This auction house cannot be scanned. Browsing still teaches prices.")
        return
    end
    scan = { active = true, phase = "wait", waited = 0, i = 0, total = 0, agg = {}, cand = {}, skipped = 0 }
    scan.msg = STEPS.wait[1]
    ShowBar(scan.msg, 0)
    local ok = pcall(C_AuctionHouse.ReplicateItems)
    if not ok then EndScan("The scan could not start.") end
    Auction:Render()
end

function Auction:CancelScan()
    if scan.active then EndScan("Scan cancelled.") end
end

function Auction:ScanActive() return scan.active end

function OnReplicate()
    if not (scan.active and scan.phase == "wait") then return end
    local ok, n = pcall(C_AuctionHouse.GetNumReplicateItems)
    if not ok or type(n) ~= "number" then EndScan("The scan could not be read.") return end
    scan.total, scan.phase = n, "read"
    if n == 0 then EndScan("The auction house returned nothing. A full scan can be asked for about every 15 minutes.") end
end

-- ---------- what browsing teaches ----------
-- A search made in the auction window goes on the recent list with its cheapest result.
local function AddRecent(text, cheapest, now)
    local list = DB().recent
    local key = text:lower()
    for i = #list, 1, -1 do
        if type(list[i]) ~= "table" or (list[i].s or ""):lower() == key then table.remove(list, i) end
    end
    table.insert(list, 1, { s = text, p = cheapest, t = now })
    while #list > RECENT_MAX do list[#list] = nil end
end

local function LearnBrowse()
    if not (C_AuctionHouse and C_AuctionHouse.GetBrowseResults) then return end
    local ok, results = pcall(C_AuctionHouse.GetBrowseResults)
    if not ok or type(results) ~= "table" then return end
    local db, now = DB(), Now()
    local cheapest
    -- gear comes as one result per item level of the same item: one price for the item is the
    -- lowest of them (the last one read must not win), with the quantities added up
    local lowest, total = {}, {}
    for i = 1, math.min(#results, 1000) do
        local r = results[i]
        if type(r) == "table" and type(r.itemKey) == "table" and r.itemKey.itemID then
            local id, p = r.itemKey.itemID, r.minPrice
            if type(p) == "number" and p > 0 then
                if not lowest[id] or p < lowest[id] then lowest[id] = p end
                if not cheapest or p < cheapest then cheapest = p end
            end
            total[id] = (total[id] or 0) + (tonumber(r.totalQuantity) or 0)
        end
    end
    for id, p in pairs(lowest) do
        Record(db, id, p, total[id] > 0 and total[id] or nil, nil, now)
    end
    local ah = _G.AuctionHouseFrame
    local okT, text = pcall(function() return ah.SearchBar.SearchBox:GetText() end)
    if okT and type(text) == "string" and text ~= "" then AddRecent(text, cheapest, now) end
end

local function LearnItemSearch(itemKey)
    if not (C_AuctionHouse and C_AuctionHouse.GetNumItemSearchResults and type(itemKey) == "table") then return end
    local ok, info = pcall(C_AuctionHouse.GetItemSearchResultInfo, itemKey, 1)
    if ok and type(info) == "table" and info.buyoutAmount then
        Record(DB(), itemKey.itemID, info.buyoutAmount, nil, nil, Now())
        Auction:CheckSnipe(itemKey.itemID, info.buyoutAmount)
    end
end

local function LearnCommodity(itemID)
    if not (C_AuctionHouse and C_AuctionHouse.GetCommoditySearchResultInfo) then return end
    local ok, info = pcall(C_AuctionHouse.GetCommoditySearchResultInfo, itemID, 1)
    if ok and type(info) == "table" and info.unitPrice then
        Record(DB(), itemID, info.unitPrice, nil, nil, Now())
        Auction:CheckSnipe(itemID, info.unitPrice)
    end
end

-- ---------- searching and buying ----------
function Auction:Search(name)
    if not (Auction.ahOpen and type(name) == "string" and name ~= "") then return end
    local ah = _G.AuctionHouseFrame
    local sb = ah and ah.SearchBar
    if sb then
        pcall(function() sb.SearchBox:SetText(name) end)
        -- the bar's own search, as if Enter was pressed in it, so its results show in the window
        if pcall(function() sb:StartSearch() end) then return end
        if sb.SearchButton and pcall(function() sb.SearchButton:Click() end) then return end
    end
    if C_AuctionHouse and C_AuctionHouse.SendBrowseQuery then
        pcall(C_AuctionHouse.SendBrowseQuery, { searchString = name, sorts = {}, filters = {}, itemClassFilters = {} })
    end
end

local function TryBid(d)
    local ok = pcall(C_AuctionHouse.PlaceBid, d.auctionID, d.b)
    return ok
end

-- A bid or a cancel that the game may refuse without an error: the call only asks, so the
-- result is told when the game answers (its purchase and cancel events, or the gold leaving
-- or the auction leaving the owned list), and a line says so if it never does.
local ANSWER_WAIT = 6
local function Mono() return GetTime and GetTime() or 0 end

local function Bought(d)
    Auction.bidding = nil
    Say("Bought " .. (d.n or "an item") .. " for " .. Money(d.b) .. ".")
    local db = DB()
    local cost = db.bought[d.id]
    if type(cost) ~= "table" then cost = { n = 0, total = 0 }; db.bought[d.id] = cost end
    cost.n, cost.total = cost.n + 1, cost.total + d.b
    for i, x in ipairs(db.deals) do
        if x == d or (x.id == d.id and x.b == d.b) then table.remove(db.deals, i) break end
    end
    Auction.pending = nil
    Auction:Render()
end

local function StartBuy(d)
    if not (C_AuctionHouse and C_AuctionHouse.SendSearchQuery and C_AuctionHouse.PlaceBid) then
        Say("This auction house cannot be bought from here.")
        return
    end
    if GetMoney and GetMoney() < d.b then Say("You cannot afford that.") return end
    if d.auctionID then -- found by an earlier click: this click is the one the game wants
        if Auction.bidding then Say("Still waiting for the last purchase.") return end
        if TryBid(d) then
            Auction.bidding = { d = d, money = GetMoney and GetMoney() or nil, at = Mono() }
            Say("Buying " .. (d.n or "the item") .. "...")
        else
            Say("The purchase did not go through.")
        end
        return
    end
    local key = C_AuctionHouse.MakeItemKey and C_AuctionHouse.MakeItemKey(d.id, d.l) or { itemID = d.id, itemLevel = d.l }
    Auction.pending = { d = d, key = key }
    pcall(C_AuctionHouse.SendSearchQuery, key, {}, true)
    Say("Looking for " .. (d.n or "the item") .. "...")
end

local function OnItemSearch(itemKey)
    local p = Auction.pending
    LearnItemSearch(itemKey)
    if not (p and type(itemKey) == "table" and itemKey.itemID == p.d.id) then return end
    local ok, num = pcall(C_AuctionHouse.GetNumItemSearchResults, itemKey)
    if not ok or type(num) ~= "number" then return end
    for i = 1, num do
        local okI, info = pcall(C_AuctionHouse.GetItemSearchResultInfo, itemKey, i)
        if okI and type(info) == "table" and info.buyoutAmount == p.d.b and info.auctionID then
            -- the game wants a click for the bid, and this runs on an event: the row now says so
            p.d.auctionID = info.auctionID
            Say("Found it. Click it again to buy.")
            Auction.pending = nil
            Auction:Render()
            return
        end
    end
    Say("That listing is gone.")
    Auction.pending = nil
end

local function ConfirmBuy(d)
    local o = DB().options
    -- always when asked to, and for a buy that is a big share of your gold
    local gold = GetMoney and GetMoney() or 0
    local big = (o.confirmPct or 0) > 0 and gold > 0 and d.b >= gold * o.confirmPct / 100
    if (o.confirm or big) and gold >= d.b and PF.ShowDialog then -- what you cannot afford is told so, not asked about
        local share = gold > 0 and string.format(" That is %d%% of your gold.", math.floor(d.b / gold * 100 + 0.5)) or ""
        PF:ShowDialog({ title = "Buy " .. (d.n or "item"), text = "Buy it for " .. Money(d.b) .. "?" .. share,
            buttons = { { text = "Buy", onClick = function() StartBuy(d) end }, { text = "Cancel" } } })
    else
        StartBuy(d)
    end
end

-- ---------- the panel ----------
local pools = {}
local content   -- the frame everything is drawn on
-- This module never scrolls: a view that does not fit shows what fits and says how many more
-- there are, so a view that overflows has too much on it. `budget` is the room below the title.
local budget, skipped = 480, 0
local function SetBudget(frame)
    local h = frame and frame.GetHeight and tonumber(frame:GetHeight()) or 0
    budget = h > 300 and (h - 38 - 12) or 480
    skipped = 0
end
local y = 0

local function Pool(kind)
    local p = pools[kind]
    if not p then p = { used = 0 }; pools[kind] = p end
    return p
end

local function ResetPools()
    for _, p in pairs(pools) do
        for i = 1, #p do p[i]:Hide() end
        p.used = 0
    end
    y = 0
end

local function Text(str, font, color, x, width)
    local p = Pool("text")
    p.used = p.used + 1
    local fs = p[p.used]
    if not fs then
        fs = content:CreateFontString(nil, "OVERLAY", font or "GameFontHighlightSmall")
        fs:SetJustifyH("LEFT")
        p[p.used] = fs
    end
    fs:SetFontObject(font or "GameFontHighlightSmall")
    fs:ClearAllPoints()
    fs:SetPoint("TOPLEFT", content, "TOPLEFT", x or 8, -y)
    fs:SetWidth(width or TEXT_W)
    fs:SetJustifyH("LEFT")
    local c = color or Theme.MUTED
    fs:SetTextColor(c[1], c[2], c[3])
    fs:SetText(str)
    fs:Show()
    local h = fs:GetStringHeight() or 12
    y = y + h + 4
    return fs
end

local function MoreLine()
    if skipped > 0 then
        Text(skipped .. " more not shown. Narrow it down.", "GameFontDisableSmall", Theme.MUTED)
        skipped = 0
    end
end

local function Header(str)
    if y > 0 then y = y + 8 end
    local r, g, b = Theme.GetAccentColor()
    Text(string.upper(str), "GameFontNormalSmall", { r, g, b })
end

local function RowOnClick(self)
    if self.onClick then self.onClick(self.data) end
end
local function RowOnEnter(self)
    if self.glow then self.glow:Show() end
    if self.tip then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        local ok = pcall(self.tip, GameTooltip, self.data)
        if ok then GameTooltip:Show() else GameTooltip:Hide() end
    end
end
local function RowOnLeave(self)
    if self.glow then self.glow:Hide() end
    GameTooltip:Hide()
end

-- A row: a name on the left (colored by `hex` when given), a value on the right, and a dim line
-- under it when there is `sub`.
local function Row(o)
    if y + 36 > budget - 26 then skipped = skipped + 1 return end
    local p = Pool("row")
    p.used = p.used + 1
    local r = p[p.used]
    if not r then
        r = CreateFrame("Button", nil, content)
        r.glow = Theme.CreateGlow and Theme.CreateGlow(r, "LEFT", 0.20)
        r.title = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        r.title:SetJustifyH("LEFT")
        r.right = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        r.right:SetJustifyH("RIGHT")
        r.sub = r:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        r.sub:SetJustifyH("LEFT")
        r:SetScript("OnClick", RowOnClick)
        r:SetScript("OnEnter", RowOnEnter)
        r:SetScript("OnLeave", RowOnLeave)
        p[p.used] = r
    end
    r:ClearAllPoints()
    r:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -y)
    r.onClick, r.data, r.tip = o.onClick, o.data, o.tip
    r:EnableMouse(o.onClick ~= nil or o.tip ~= nil)
    if r.glow then r.glow:Hide() end
    r.title:ClearAllPoints()
    r.title:SetPoint("TOPLEFT", r, "TOPLEFT", 8, -4)
    r.title:SetWidth(o.right and 160 or TEXT_W)
    r.title:SetText((o.hex or "") .. o.title .. (o.hex and "|r" or ""))
    r.right:ClearAllPoints()
    r.right:SetPoint("TOPLEFT", r, "TOPLEFT", 172, -4)
    r.right:SetWidth(CHILD_W - 172 - 8)
    r.right:SetText(o.right or "")
    -- a long name or line wraps, so the row is as tall as its text (never an explicit FontString height)
    local th = math.max(r.title:GetStringHeight() or 12, 12)
    r.sub:ClearAllPoints()
    r.sub:SetPoint("TOPLEFT", r, "TOPLEFT", 8, -(4 + th + 3))
    r.sub:SetWidth(TEXT_W)
    r.sub:SetText(o.sub or "")
    r.sub:SetShown(o.sub ~= nil)
    local h = ROW_H
    if o.sub then h = math.max(34, 4 + th + 3 + math.max(r.sub:GetStringHeight() or 12, 12) + 5) else h = math.max(ROW_H, th + 8) end
    r:SetSize(CHILD_W, h)
    r:Show()
    y = y + h + 2
    return r
end

local function ButtonOnClick(self)
    if self.onClick then self.onClick(self.data) end
end

-- A button `w` wide at x; `on` draws it in the accent (a chosen option).
local function Button(label, x, w, onClick, data, on)
    local p = Pool("button")
    p.used = p.used + 1
    local b = p[p.used]
    if not b then
        b = CreateFrame("Button", nil, content)
        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        b.text:SetPoint("CENTER")
        b:SetScript("OnClick", ButtonOnClick)
        Theme.StyleOutlineButton(b)
        p[p.used] = b
    end
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", content, "TOPLEFT", x, -y)
    b:SetSize(w, 22)
    b.onClick, b.data = onClick, data
    b.text:SetText(label)
    local c = on and { Theme.GetAccentColor() } or Theme.TEXT
    b.text:SetTextColor(c[1], c[2], c[3])
    b:Show()
    return b
end

local function RowEnd() y = y + 28 end

-- A label above a row of choices: { { value, text }, ... } for option `key`.
local function Choice(label, key, choices)
    if label then Text(label, "GameFontHighlightSmall", Theme.TEXT) end
    local o = DB().options
    local w = math.floor((CHILD_W - 16 - (#choices - 1) * 4) / #choices)
    for i, c in ipairs(choices) do
        Button(c[2], 8 + (i - 1) * (w + 4), w, function()
            o[key] = c[1]
            Auction:Render()
        end, nil, o[key] == c[1])
    end
    RowEnd()
end

-- A label with a value and - / + buttons.
-- A small (i) just after a label; hovering it explains the setting.
local function Info(label, x, top, hint)
    local p = Pool("info")
    p.used = p.used + 1
    local b = p[p.used]
    if not b then
        b = CreateFrame("Button", nil, content)
        b:SetSize(14, 14)
        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        b.text:SetPoint("CENTER", b, "CENTER", 0, 0)
        b.text:SetText("i")
        b.ring = b:CreateTexture(nil, "BORDER")
        b.ring:SetAllPoints()
        b.ring:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
        b.ring:SetVertexColor(0.35, 0.35, 0.4)
        b:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(self.label or "", 1, 1, 1)
            GameTooltip:AddLine(self.hint or "", nil, nil, nil, true)
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function() GameTooltip:Hide() end)
        p[p.used] = b
    end
    b.label, b.hint = label, hint
    b:ClearAllPoints()
    b:SetPoint("TOPLEFT", content, "TOPLEFT", x, -top)
    b:SetFrameLevel(content:GetFrameLevel() + 5)
    b:Show()
end

local function Stepper(label, key, step, min, max, format, hint)
    local o = DB().options
    local fs = Text(label, "GameFontHighlightSmall", Theme.TEXT, 8, TEXT_W - 24)
    if hint then Info(label, 8 + (fs:GetStringWidth() or 100) - 4, y - (fs:GetStringHeight() or 12) - 6, hint) end
    local top = y
    Button("-", 8, 26, function()
        o[key] = math.max(min, (o[key] or 0) - step)
        Auction:Render()
    end)
    Button("+", 8 + 30, 26, function()
        o[key] = math.min(max, (o[key] or 0) + step)
        Auction:Render()
    end)
    y = top + 4
    Text(format(o[key] or 0), "GameFontHighlightSmall", Theme.TEXT, 8 + 66, TEXT_W - 66)
    y = top + 28
end

-- A label with an on/off switch.
local function Toggle(label, key, hint)
    local p = Pool("toggle")
    p.used = p.used + 1
    local t = p[p.used]
    if not t then
        t = CreateFrame("Button", nil, content)
        Theme.CreateSwitch(t)
        t.cbBorder:SetPoint("RIGHT", t, "RIGHT", -8, 0)
        t.label = t:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        t.label:SetPoint("TOPLEFT", t, "TOPLEFT", 8, -5)
        t.label:SetWidth(CHILD_W - 60)
        t.label:SetJustifyH("LEFT")
        t:SetScript("OnClick", function(self)
            local o = DB().options
            o[self.key] = not o[self.key]
            if Theme.PlayCheckboxSound then Theme.PlayCheckboxSound(o[self.key]) end
            Auction:Render()
        end)
        p[p.used] = t
    end
    t:ClearAllPoints()
    t:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -y)
    t:SetSize(CHILD_W, 22)
    t.key = key
    t.label:SetText(label)
    Theme.SetSwitch(t, DB().options[key] and true or false)
    t:Show()
    if hint then Info(label, 8 + (t.label:GetStringWidth() or 100) - 4, y + 2, hint) end
    y = y + 24
end

-- ---------- tooltips ----------
-- An item the client has not loaded yet is asked for once; ITEM_DATA_LOAD_RESULT redraws the
-- window when its name arrives.
local askedName = {}
local function ItemName(id)
    local ok, name = pcall(C_Item.GetItemInfo, id)
    if ok and type(name) == "string" then return name end
    if D.NAMES[id] then return D.NAMES[id] end
    if not askedName[id] and C_Item and C_Item.RequestLoadItemDataByID then
        askedName[id] = true
        pcall(C_Item.RequestLoadItemDataByID, id)
    end
    return "Item " .. tostring(id)
end

local function BagCount(id)
    local n = 0
    if C_Item and C_Item.GetItemCount then
        local ok, c = pcall(C_Item.GetItemCount, id)
        if ok and type(c) == "number" then n = c end
    end
    return n
end

local function IsUnsellable(id)
    local ok, _, _, _, _, _, _, _, _, _, _, _, _, _, bind = pcall(C_Item.GetItemInfo, id)
    return ok and (bind == 1 or bind == 4)
end

-- What gear disenchants into, at the roll chosen on the Buy tab (after the cut when that is on).
local function AddDisenchant(tip, id)
    local kind = IsGear(id)
    if not kind then return end
    local ok, _, link, quality, ilvl = pcall(C_Item.GetItemInfo, id)
    if not ok or type(quality) ~= "number" then return end
    if C_Item.GetDetailedItemLevelInfo then
        local okL, v = pcall(C_Item.GetDetailedItemLevelInfo, link or id)
        if okL and type(v) == "number" then ilvl = v end
    end
    local o = DB().options
    local v = D.Value(D.Outcomes(quality, kind == "weapon", ilvl), o.roll, PriceOf)
    if not v then return end
    if o.cut then v = math.floor(v * (1 - AH_CUT)) end
    tip:AddDoubleLine("Disenchants (" .. o.roll .. ")", Money(v), 0.6, 0.6, 0.6)
end

-- What it costs to craft an item from the profession last opened, and the profit.
local function AddCraft(tip, id)
    if not Auction.craft then return end
    Auction:CraftList()
    local e = Auction.craftByProduct and Auction.craftByProduct[id]
    if not e then return end
    local result = e.profit and ("  " .. (e.profit >= 0 and "profit " or "loss ") .. Money(math.abs(e.profit))) or ""
    tip:AddDoubleLine("Crafting cost", Money(e.cost) .. result, 0.6, 0.6, 0.6)
end

local function AddToTooltip(tip, id)
    if type(id) ~= "number" or not tip or not tip.AddLine then return end
    local r = Auction:Price(id)
    -- a price on file means the item was seen listed, so it can be sold whatever its tooltip says it binds as
    if not r then AddDisenchant(tip, id); AddCraft(tip, id) return end
    -- only an item with a price takes over the price check, so hovering other things leaves it be
    Auction.lastItem = id
    local c = Theme.GOLD or { 1, 0.82, 0 }
    tip:AddDoubleLine("Auction house", Money(r.p) .. " |cff9d9d9d(" .. Ago(r.t) .. ")|r", c[1], c[2], c[3])
    if r.n or r.q then
        local parts = {}
        if r.n then parts[#parts + 1] = r.n .. (r.n == 1 and " auction" or " auctions") end
        if r.q then parts[#parts + 1] = r.q .. (r.q == 1 and " unit" or " units") end
        tip:AddLine(table.concat(parts, ", "), 0.6, 0.6, 0.6)
    end
    local held = BagCount(id)
    if held > 1 then tip:AddDoubleLine(held .. " in bags", Money(r.p * held), 0.6, 0.6, 0.6) end
    local typical, n = Auction:Typical(id)
    if typical then
        local v = Verdict(r.p, typical)
        tip:AddDoubleLine("Usual price (" .. n .. " scans)", Money(typical) .. (v and ("  " .. VERDICT_TEXT[v]) or ""), 0.6, 0.6, 0.6)
    end
    AddDisenchant(tip, id)
    AddCraft(tip, id)
end
Auction.AddToTooltip = AddToTooltip

if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum and Enum.TooltipDataType then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tip, data)
        if type(data) == "table" and data.id then pcall(AddToTooltip, tip, data.id) end
    end)
end

-- ---------- the tabs ----------
local function Shown(f) return f and f.IsShown and f:IsShown() end

-- "buy", "sell" or "auctions", from which of the window's frames is showing.
function Auction:CurrentTab()
    local ah = _G.AuctionHouseFrame
    if not ah then return "buy" end
    if Shown(ah.AuctionsFrame) then return "auctions" end
    if Shown(ah.ItemSellFrame) or Shown(ah.CommoditiesSellFrame) then return "sell" end
    return "buy"
end

local function ScanBlock()
    local db = DB()
    if scan.active then
        Text("Scanning...", "GameFontHighlightSmall", Theme.TEXT)
        Button("Cancel scan", 8, CHILD_W - 16, function() Auction:CancelScan() end)
        RowEnd()
        return
    end
    local last = db.lastScan
    Text(last and string.format("Last scan %s, %d items", Ago(last.t), last.items or 0) or "No scan yet",
        "GameFontHighlightSmall", Theme.MUTED)
    if last and Now() - (last.t or 0) > STALE then
        Text("These prices are old. Scan again before you buy.", "GameFontDisableSmall", Theme.WARN)
    end
    if Auction.scanNote then Text(Auction.scanNote, "GameFontDisableSmall", Theme.WARN) end
    Button("Scan the auction house", 8, CHILD_W - 16, function() Auction:StartScan() end)
    RowEnd()
end

-- Bars for a short history of { time, price }, oldest first, the newest in the accent.
local function Chart(points)
    local pool = Pool("chart")
    pool.used = pool.used + 1
    local f = pool[pool.used]
    if not f then
        f = CreateFrame("Frame", nil, content)
        f.bars = {}
        pool[pool.used] = f
    end
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", content, "TOPLEFT", 8, -y)
    f:SetSize(TEXT_W, CHART_H)
    local n, lo, hi = #points, math.huge, 0
    for _, pt in ipairs(points) do
        lo, hi = math.min(lo, pt[2]), math.max(hi, pt[2])
    end
    local gap = 3
    local w = math.max(4, math.min(24, math.floor((TEXT_W - (n - 1) * gap) / n)))
    local ar, ag, ab = Theme.GetAccentColor()
    for i = 1, math.max(n, #f.bars) do
        local b = f.bars[i]
        if i <= n then
            if not b then b = f:CreateTexture(nil, "ARTWORK"); f.bars[i] = b end
            local frac = hi > lo and (points[i][2] - lo) / (hi - lo) or 0.5
            b:ClearAllPoints()
            b:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (i - 1) * (w + gap), 0)
            b:SetSize(w, math.floor(4 + frac * (CHART_H - 4)))
            if i == n then b:SetColorTexture(ar, ag, ab, 0.9) else b:SetColorTexture(1, 1, 1, 0.3) end
            b:Show()
        elseif b then
            b:Hide()
        end
    end
    f:Show()
    y = y + CHART_H + 4
    return lo, hi
end

local function PriceCheck()
    local id = Auction.lastItem
    local r = id and Auction:Price(id)
    if not r then
        Text("Hover an item you have seen at the auction house to check its price.", "GameFontDisableSmall", Theme.MUTED)
        return nil
    end
    local typical, n = Auction:Typical(id)
    local v, ratio = Verdict(r.p, typical)
    local name = ItemName(id)
    Row({ title = name, right = Money(r.p), sub = "Lowest listing, " .. Ago(r.t),
        onClick = function() Auction:Search(name) end })
    if typical then
        Row({ title = "Usual price", right = Money(typical), sub = n .. " scans" })
        if v then
            Row({ title = VERDICT_TEXT[v], hex = Hex(VerdictColor(v)), right = string.format("%d%% of usual", math.floor(ratio * 100 + 0.5)) })
        end
    else
        Text("The usual price needs three scans of this item.", "GameFontDisableSmall", Theme.MUTED)
    end
    local h = DB().prices[id].h
    if type(h) == "table" and #h >= 3 then
        local lo, hi = Chart(h)
        Text(string.format("Low %s, high %s over %d scans, newest on the right", Money(lo), Money(hi), #h),
            "GameFontDisableSmall", Theme.MUTED)
    end
    return id, r, typical
end

local function DealTip(tip, d)
    local def = d.d
    tip:SetHyperlink("item:" .. def.id)
    tip:AddLine(" ")
    tip:AddLine("Listed for " .. Money(def.b), 1, 1, 1)
    local typical = Auction:Typical(def.id)
    if typical and typical > 0 then
        tip:AddLine(string.format("%d%% of the usual price, %s", math.floor(def.b / typical * 100 + 0.5), Money(typical)), 0.8, 0.8, 0.8)
    end
    for _, roll in ipairs({ "low", "average", "high" }) do
        local v = Auction:DealValue(def, roll)
        tip:AddDoubleLine(roll == "low" and "Low (safe)" or roll == "high" and "High (risky)" or "Average",
            v and Money(v) or "no prices yet", 0.8, 0.8, 0.8)
    end
    local out = D.Outcomes(def.q, def.w, def.l)
    for _, o in ipairs(out or {}) do
        tip:AddLine(string.format("%s%% %s, %d to %d", tostring(o[2]), D.NAMES[o[1]] or "?", o[3], o[4]), 0.6, 0.6, 0.6)
    end
    tip:AddLine("Shift-click to search for it", 0.6, 0.6, 0.6)
end

local function DealClick(d)
    if IsShiftKeyDown and IsShiftKeyDown() then Auction:Search(d.d.n or ItemName(d.d.id)) return end
    ConfirmBuy(d.d)
end

-- ---------- resale and vendor deals ----------
local function VendorPrice(id)
    Auction.vendorSell = Auction.vendorSell or {}
    local cached = Auction.vendorSell[id]
    if cached ~= nil then return cached or nil end
    -- a lookup of an item the client has not loaded can be slow: only ask about cached ones
    if C_Item.IsItemDataCachedByID then
        local okC, cachedItem = pcall(C_Item.IsItemDataCachedByID, id)
        if okC and not cachedItem then return end
    end
    local ok, name, _, _, _, _, _, _, _, _, _, sell = pcall(C_Item.GetItemInfo, id)
    if ok and name then -- an item the client has not loaded yet is asked again next time
        local v = type(sell) == "number" and sell > 0 and sell or false
        Auction.vendorSell[id] = v
        return v or nil
    end
end

-- Items listed well under their usual price (resale) and under what a vendor pays (vendor), from
-- the prices on file, best profit each first. A full scan leaves tens of thousands of prices, so the
-- list is worked out a slice at a time (OtherStep, a few frames' worth of items each) and never
-- while a scan runs or right after the window opens. This returns what is ready and whether it is
-- still working; pass true to work it all out at once (the tests do).
local OTHER_BATCH = 400   -- most prices looked at per frame
local OTHER_MS = 1.5      -- and no more than this many milliseconds of a frame, where the client can time it
local OTHER_HOLD = 1.5    -- seconds after the window opens before any of it starts
local OTHER_DEBOUNCE = 4  -- seconds between one pass and the next when prices keep changing
local otherCache = { hold = OTHER_HOLD }

local function OtherKey()
    local o = DB().options
    return table.concat({ Auction.priceStamp or 0, o.resaleBelow, o.cut and 1 or 0, o.minProfit, o.maxPrice }, "|")
end

local function OtherNew()
    local o = DB().options
    return { key = OtherKey(), resale = {}, vendor = {}, now = Now(), cut = o.cut,
        below = o.resaleBelow or 75, floorProfit = math.max(1, o.minProfit or 0),
        cap = (o.maxPrice or 0) > 0 and o.maxPrice or nil }
end

local function OtherLook(job, id, r)
    if type(r) == "table" and r.p and r.t and job.now - r.t <= MAX_AGE and (not job.cap or r.p <= job.cap) then
        local typical = Auction:Typical(id)
        if typical and r.p <= typical * job.below / 100 then
            local profit = math.floor((job.cut and typical * (1 - AH_CUT) or typical) - r.p)
            if profit >= job.floorProfit then job.resale[#job.resale + 1] = { id = id, p = r.p, typical = typical, profit = profit } end
        end
        local vp = VendorPrice(id)
        if vp and r.p < vp and vp - r.p >= job.floorProfit then
            job.vendor[#job.vendor + 1] = { id = id, p = r.p, vendor = vp, profit = vp - r.p }
        end
    end
end

local function byProfit(a, b) return a.profit > b.profit end

local function OtherFinish(job)
    table.sort(job.resale, byProfit)
    table.sort(job.vendor, byProfit)
    otherCache.key, otherCache.resale, otherCache.vendor, otherCache.job = job.key, job.resale, job.vendor, nil
end

-- One slice. Returns true when it finished a list.
local function OtherSlice(job, count, ms)
    local prices = DB().prices
    local clock = ms and debugprofilestop
    local t0 = clock and clock()
    for i = 1, count do
        if t0 and clock() - t0 > ms then return end
        local id, r = next(prices, job.last)
        if id == nil then OtherFinish(job) return true end
        job.last = id
        OtherLook(job, id, r)
    end
end

function Auction:OtherDeals(all)
    if all then
        local job = OtherNew()
        OtherSlice(job, math.huge)
        return otherCache.resale, otherCache.vendor, false
    end
    return otherCache.resale or {}, otherCache.vendor or {}, otherCache.job ~= nil or otherCache.key ~= OtherKey()
end

-- Called every frame while the auction house is open.
local function OtherStep(elapsed)
    if not (Auction.ahOpen and window and window:IsShown() and not scan.active) then return end
    if Auction.tab ~= "buy" or (DB().options.view ~= "deals" and not Auction.popout) then return end
    if otherCache.hold > 0 then otherCache.hold = otherCache.hold - elapsed return end
    local job = otherCache.job
    if not job then
        if otherCache.key == OtherKey() then return end
        job = OtherNew()
        otherCache.job = job
    end
    local ok, done = pcall(OtherSlice, job, OTHER_BATCH, OTHER_MS)
    if not ok then -- a price was added while walking the table: try again from the start a bit later
        otherCache.job, otherCache.hold = nil, OTHER_DEBOUNCE
    elseif done then
        otherCache.hold = OTHER_DEBOUNCE
        Auction:Render()
    end
end

local function OtherTip(tip, e)
    tip:SetHyperlink("item:" .. e.id)
    tip:AddLine(" ")
    tip:AddLine("Lowest listing " .. Money(e.p), 1, 1, 1)
    if e.typical then tip:AddLine("Usual price " .. Money(e.typical), 0.8, 0.8, 0.8) end
    if e.vendor then tip:AddLine("A vendor pays " .. Money(e.vendor), 0.8, 0.8, 0.8) end
end

local function OtherClick(e)
    Auction:Search(ItemName(e.id))
end

local function OtherRows(list, subFor, emptyText)
    if #list == 0 and emptyText then Text(emptyText, "GameFontDisableSmall", Theme.MUTED) end
    for i = 1, math.min(#list, OTHER_LIST) do
        local e = list[i]
        Row({ title = ItemName(e.id), right = Money(e.p), sub = subFor(e), data = e, onClick = OtherClick, tip = OtherTip })
    end
end

-- ---------- shopping list and recent searches ----------
local function ShoppingIndex(id)
    for i, e in ipairs(DB().shopping) do
        if type(e) == "table" and e.id == id then return i end
    end
end

-- The price to aim for when an item goes on the list: a bit under the usual, else under today's.
local function DefaultMax(id, r)
    local typical = Auction:Typical(id)
    return math.max(1, math.floor((typical or r.p) * 0.9))
end

local function MaxStep(v)
    if v < 1000 then return 10 elseif v < 10000 then return 100 elseif v < 100000 then return 1000 end
    return 10000
end

local function ShopClick(e)
    Auction.shopSel = e
    Auction:Search(ItemName(e.id))
    Auction:Render()
end

local function ShopTip(tip, e)
    tip:SetHyperlink("item:" .. e.id)
end

-- ---------- the live sniper ----------
-- While it is on, one item of the shopping list is searched every few seconds with the auction
-- house's own search; a price under that item's max gets a sound and a line in chat.
local SNIPE_EVERY = 6

function Auction:CheckSnipe(id, price)
    if not Auction.sniping or type(price) ~= "number" then return end
    local i = ShoppingIndex(id)
    local e = i and DB().shopping[i]
    if not (e and e.max and price <= e.max) then return end
    local now = Now()
    if e.hit and e.hit.p <= price and now - e.hit.t < 300 then return end -- told about it already
    e.hit = { p = price, t = now }
    Say(string.format("%s is up for %s, under your max of %s.", ItemName(id), Money(price), Money(e.max)))
    if PlaySound and SOUNDKIT and SOUNDKIT.RAID_WARNING then pcall(PlaySound, SOUNDKIT.RAID_WARNING) end
    if FlashClientIcon then pcall(FlashClientIcon) end
    Auction:Render()
end

function Auction:SetSniping(on)
    Auction.sniping = on and true or false
    Auction.snipeT, Auction.snipeIx = SNIPE_EVERY, 0
    Auction:Render()
end

local function SnipeStep(elapsed)
    if not (Auction.sniping and Auction.ahOpen) or scan.active or Auction.pending then return end
    Auction.snipeT = (Auction.snipeT or 0) + elapsed
    if Auction.snipeT < SNIPE_EVERY then return end
    local list = DB().shopping
    if #list == 0 then return end
    if C_AuctionHouse.IsThrottledMessageSystemReady then
        local ok, ready = pcall(C_AuctionHouse.IsThrottledMessageSystemReady)
        if ok and ready == false then return end
    end
    Auction.snipeT = 0
    Auction.snipeIx = ((Auction.snipeIx or 0) % #list) + 1
    local e = list[Auction.snipeIx]
    if type(e) ~= "table" or not e.id then return end
    local key = C_AuctionHouse.MakeItemKey and C_AuctionHouse.MakeItemKey(e.id) or { itemID = e.id }
    pcall(C_AuctionHouse.SendSearchQuery, key, {}, true)
end

local function RenderShopping()
    local db = DB()
    Header("Shopping list")
    Button(Auction.sniping and "Watching the list: on" or "Watch the list for deals", 8, CHILD_W - 16,
        function() Auction:SetSniping(not Auction.sniping) end, nil, Auction.sniping)
    RowEnd()
    if Auction.sniping then
        Text("Looking up one item every few seconds with the window's own search, so the window may flip to these items. A price under your max makes a sound.",
            "GameFontDisableSmall", Theme.MUTED)
    end
    if #db.shopping == 0 then
        Text("Add items you buy often. Each shows its cheapest price from your scans next to the most you want to pay.",
            "GameFontDisableSmall", Theme.MUTED)
    end
    for _, e in ipairs(db.shopping) do
        if type(e) == "table" and e.id then
            local r = Auction:Price(e.id)
            local under = r and r.p <= e.max
            Row({ title = ItemName(e.id), hex = under and Hex(Theme.GOOD) or nil, right = r and Money(r.p) or "no price",
                sub = (e.hit and Now() - e.hit.t < 600) and ("Seen at " .. Money(e.hit.p) .. ", " .. Ago(e.hit.t))
                    or ((under and "Under " or "Over ") .. "your max of " .. Money(e.max or 0) .. (r and (", " .. Ago(r.t)) or "")),
                data = e, onClick = ShopClick, tip = ShopTip })
        end
    end
    local sel = Auction.shopSel
    if sel and ShoppingIndex(sel.id) then
        Header("Most to pay")
        Text(ItemName(sel.id), "GameFontHighlightSmall", Theme.TEXT)
        local top = y
        Button("-", 8, 26, function() sel.max = math.max(1, sel.max - MaxStep(sel.max)); Auction:Render() end)
        Button("+", 38, 26, function() sel.max = sel.max + MaxStep(sel.max); Auction:Render() end)
        y = top + 4
        Text(Money(sel.max), "GameFontHighlightSmall", Theme.TEXT, 8 + 66, TEXT_W - 66)
        y = top + 28
        Button("Remove from the list", 8, CHILD_W - 16, function()
            table.remove(db.shopping, ShoppingIndex(sel.id))
            Auction.shopSel = nil
            Auction:Render()
        end)
        RowEnd()
    end
    Header("Price check")
    local id, r = PriceCheck()
    if id and not ShoppingIndex(id) then
        Button("Add to the shopping list", 8, CHILD_W - 16, function()
            db.shopping[#db.shopping + 1] = { id = id, max = DefaultMax(id, r) }
            Auction.shopSel = db.shopping[#db.shopping]
            Auction:Render()
        end)
        RowEnd()
    end
end

local function RecentClick(e)
    Auction:Search(e.s)
end

local function RenderRecent()
    local list = DB().recent
    Header("Recent searches")
    if #list == 0 then
        Text("Searches you make in the auction window show up here with their cheapest price.", "GameFontDisableSmall", Theme.MUTED)
    end
    for _, e in ipairs(list) do
        if type(e) == "table" and e.s then
            Row({ title = e.s, right = e.p and Money(e.p) or "", sub = Ago(e.t), data = e, onClick = RecentClick })
        end
    end
end

-- ---------- recipes: what crafting costs and what it sells for ----------
-- Read from the profession that is open (the client only has a profession's recipes loaded while
-- its window is up) and kept for the session, so the Recipes view works with the window closed.
-- Costs come from the prices on file: a material with no price leaves its recipe without a profit.
function Auction:ReadRecipes()
    local T = C_TradeSkillUI
    if not (T and T.GetAllRecipeIDs and T.GetRecipeSchematic and T.GetRecipeInfo) then
        Auction.craftNote = "This client has no recipe data to read."
        return
    end
    local ok, ids = pcall(T.GetAllRecipeIDs)
    if not ok or type(ids) ~= "table" or #ids == 0 then return end -- no profession open
    local profName
    local okB, base = pcall(function() return T.GetBaseProfessionInfo() end)
    if okB and type(base) == "table" then profName = base.professionName or base.name end
    local c = Auction.craft
    if c and c.n == #ids and c.prof == profName then return end
    Auction.schem = Auction.schem or {}
    local basicType = Enum and Enum.CraftingReagentType and Enum.CraftingReagentType.Basic or 1
    local recipes = {}
    for _, id in ipairs(ids) do
        local r = Auction.schem[id]
        if r == nil then
            local okI, info = pcall(T.GetRecipeInfo, id)
            if okI and type(info) == "table" and info.learned ~= false then
                r = false
                local okS, sc = pcall(T.GetRecipeSchematic, id, false)
                if okS and type(sc) == "table" then
                    local reagents = {}
                    for _, slot in ipairs(sc.reagentSlotSchematics or {}) do
                        local first = type(slot.reagents) == "table" and slot.reagents[1]
                        if (slot.reagentType == nil or slot.reagentType == basicType) and first and first.itemID
                            and (slot.quantityRequired or 0) > 0 then
                            reagents[#reagents + 1] = { id = first.itemID, qty = slot.quantityRequired }
                        end
                    end
                    local product
                    if T.GetRecipeOutputItemData then
                        local okO, out = pcall(T.GetRecipeOutputItemData, id)
                        if okO and type(out) == "table" then product = out.itemID end
                    end
                    product = product or sc.outputItemID
                    r = { id = id, name = info.name or ("Recipe " .. id), reagents = reagents, product = product,
                        qty = ((sc.quantityMin or 1) + (sc.quantityMax or 1)) / 2 }
                    Auction.schem[id] = r
                end
            end
        end
        if r and #r.reagents > 0 then recipes[#recipes + 1] = r end
    end
    Auction.craft = { recipes = recipes, n = #ids, prof = profName, name = profName or "Profession" }
    Auction.craftSel = nil
end

-- The recipes with their cost and profit, best profit first; worked out again only when a price
-- or a setting changed.
function Auction:CraftList()
    local c = Auction.craft
    if not c then return {} end
    local o = DB().options
    local key = (Auction.priceStamp or 0) .. "|" .. (o.cut and 1 or 0) .. "|" .. c.n
    if c.key == key then return c.list end
    local list, byProduct = {}, {}
    for _, r in ipairs(c.recipes) do
        local cost, missing = 0, 0
        for _, m in ipairs(r.reagents) do
            local pr = Auction:Price(m.id)
            if pr then cost = cost + pr.p * m.qty else missing = missing + 1 end
        end
        local e = { r = r, cost = cost, missing = missing }
        local pp = r.product and Auction:Price(r.product)
        if pp then
            e.gross = pp.p * r.qty
            e.net = math.floor(o.cut and e.gross * (1 - AH_CUT) or e.gross)
            if missing == 0 then e.profit = math.floor(e.net - cost) end
        end
        if r.product and missing == 0 then byProduct[r.product] = e end
        list[#list + 1] = e
    end
    table.sort(list, function(a, b)
        if a.profit and b.profit then return a.profit > b.profit end
        if a.profit then return true end
        if b.profit then return false end
        return a.r.name < b.r.name
    end)
    c.key, c.list = key, list
    Auction.craftByProduct = byProduct
    return list
end

local function RecipeClick(e)
    Auction.craftSel = e.r
    Auction:Render()
end

local function SearchItemClick(id)
    Auction:Search(ItemName(id))
end

local function RenderRecipes()
    Auction:ReadRecipes()
    local c = Auction.craft
    Header(c and c.name or "Recipes")
    if not c then
        Text(Auction.craftNote or "Open one of your professions and its recipes show up here with what they cost to make and what they sell for.",
            "GameFontDisableSmall", Theme.MUTED)
        return
    end
    local list = Auction:CraftList()
    local shown = 0
    for _, e in ipairs(list) do
        if shown >= 10 then break end
        shown = shown + 1
        local profit = e.profit and (e.profit >= 0 and (Hex(Theme.GOOD) .. Money(e.profit) .. "|r") or (Hex(Theme.BAD) .. "-" .. Money(-e.profit) .. "|r"))
        Row({ title = e.r.name, right = profit or "no price", data = e, onClick = RecipeClick,
            sub = e.missing > 0 and (e.missing .. (e.missing == 1 and " material has" or " materials have") .. " no price")
                or ("Materials " .. Money(e.cost) .. (e.net and (", sells for " .. Money(e.net)) or ", product has no price")) })
    end
    if #list > shown then Text((#list - shown) .. " more recipes.", "GameFontDisableSmall", Theme.MUTED) end
    local r = Auction.craftSel
    if r then
        local sel
        for _, e in ipairs(list) do if e.r == r then sel = e break end end
        if sel then
            Header(r.name)
            if r.product then
                Row({ title = ItemName(r.product) .. (r.qty > 1 and (" x" .. r.qty) or ""), right = sel.net and Money(sel.net) or "no price",
                    sub = "What it sells for" .. (DB().options.cut and ", after the cut" or ""), data = r.product, onClick = SearchItemClick })
            end
            for _, m in ipairs(r.reagents) do
                local pr = Auction:Price(m.id)
                Row({ title = ItemName(m.id) .. " x" .. m.qty, right = pr and Money(pr.p * m.qty) or "no price",
                    sub = pr and (Money(pr.p) .. " each, " .. Ago(pr.t)) or "Not seen at the auction house", data = m.id, onClick = SearchItemClick })
            end
            if sel.profit then
                Text((sel.profit >= 0 and "Profit " or "Loss ") .. Money(math.abs(sel.profit)) .. " for one craft.",
                    "GameFontHighlightSmall", sel.profit >= 0 and Theme.GOOD or Theme.BAD)
            end
        end
    end
end

-- The deal lists are long, so they live in a second window beside the panel (RenderPopout).
local POPS = {
    { "deals", "Disenchant deals" }, { "resale", "Resale deals" }, { "vendor", "Vendor flips" },
    { "settings", "Settings" },
}

local function PopClick(key)
    Auction.popout = Auction.popout ~= key and key or nil
    Auction:Render()
end

local function RenderDeals()
    Header("Deals")
    local resale, vendor, working = Auction:OtherDeals()
    -- a count that is still being worked out reads "...": nothing is added or removed, so the
    -- buttons below stay where they are
    local counts = { deals = #Auction:Deals(), resale = working and "..." or #resale, vendor = working and "..." or #vendor }
    for _, pp in ipairs(POPS) do
        Button(counts[pp[1]] and (pp[2] .. " (" .. counts[pp[1]] .. ")") or pp[2], 8, CHILD_W - 16, PopClick, pp[1], Auction.popout == pp[1])
        RowEnd()
    end

    Header("Price check")
    PriceCheck()
end

local function RenderPopSettings()
    Header("Deal settings")
    Stepper("Smallest profit", "minProfit", 5000, 0, 1000000, function(v) return v == 0 and "No minimum" or Money(v) end,
        "Hide deals that would earn you less than this on each item.")
    Stepper("Highest price", "maxPrice", 50000, 0, 10000000, function(v) return v == 0 and "No limit" or Money(v) end,
        "Hide items that cost more than this each.")
    Stepper("Resale deals: price at most", "resaleBelow", 5, 30, 95, function(v) return v .. "% of usual" end,
        "Resale deals are items listed this far under their usual price.")
    Toggle("Subtract the auction house's cut", "cut", "Profits are shown after the " .. math.floor(AH_CUT * 100 + 0.5) .. "% the auction house takes.")

    Header("Buying")
    Stepper("Ask before a buy that costs", "confirmPct", 5, 0, 100, function(v) return v == 0 and "Never" or (v .. "% of your gold") end)
    Toggle("Ask before every buy", "confirm")
end

local function RenderPopDeals()
    Choice("Roll", "roll", { { "low", "Low (safe)" }, { "average", "Average" }, { "high", "High (risky)" } })
    local list = Auction:Deals()
    if #list == 0 then
        Text(#DB().deals == 0 and "Scan to find gear listed for less than it disenchants into."
            or "Nothing beats its disenchant at this roll.", "GameFontDisableSmall", Theme.MUTED)
    end
    for i = 1, math.min(#list, DEAL_LIST) do
        local e = list[i]
        local d = e.d
        Row({ title = d.n or ItemName(d.id), hex = QualityHex(d.q), right = Money(d.b),
            sub = d.auctionID and "Found it: click to buy"
                or string.format("Item level %d, worth %s, profit %s", d.l, Money(e.value), Money(e.profit)),
            data = e, onClick = DealClick, tip = DealTip })
    end
end

local function RenderPopResale()
    local resale, _, working = Auction:OtherDeals()
    OtherRows(resale, function(e)
        return string.format("%d%% of usual, %s each", math.floor(e.p / e.typical * 100 + 0.5), Money(e.profit))
    end, not working and "Items listed well under their usual price. The usual price needs three scans at least six hours apart." or nil)
end

local function RenderPopVendor()
    local _, vendor, working = Auction:OtherDeals()
    OtherRows(vendor, function(e)
        return string.format("Vendor pays %s, %s each", Money(e.vendor), Money(e.profit))
    end, not working and "Nothing is listed under what a vendor pays." or nil)
end

local RENDER_POP = { settings = RenderPopSettings, deals = RenderPopDeals, resale = RenderPopResale, vendor = RenderPopVendor }
local TITLE_POP = { deals = "Disenchant deals", resale = "Resale deals", vendor = "Vendor flips", settings = "Settings" }

local function RenderBuy()
    ScanBlock()
    Choice(nil, "view", { { "deals", "Deals" }, { "shopping", "Shopping" }, { "recent", "Recent" }, { "recipes", "Recipes" } })
    local view = DB().options.view
    if view == "recipes" then RenderRecipes()
    elseif view == "shopping" then RenderShopping()
    elseif view == "recent" then RenderRecent()
    else RenderDeals() end
end

local function SuggestedPrice(id, r, typical)
    local o = DB().options
    local base = (o.basis == "typical" and typical) or r.p
    local price = base * (1 - (o.match and 0 or (o.undercut or 0)) / 100)
    if typical and o.floor then price = math.max(price, typical * o.floor / 100) end
    return math.max(1, math.floor(price))
end

local function SellFrame()
    local ah = _G.AuctionHouseFrame
    local frames = ah and { ah.ItemSellFrame, ah.CommoditiesSellFrame } or {}
    for _, f in ipairs(frames) do
        if Shown(f) then return f end
    end
end

local function SetSellPrice(price)
    local f = SellFrame()
    if f and f.PriceInput and f.PriceInput.SetAmount then
        return pcall(f.PriceInput.SetAmount, f.PriceInput, price) and true or false
    end
    return false
end

-- The item the Sell tab has ready to post, or nil.
function Auction:SellItemID()
    local f = SellFrame()
    if not (f and f.GetItem) then return nil end
    local ok, loc = pcall(f.GetItem, f)
    if not ok or not loc then return nil end
    if C_Item and C_Item.GetItemID then
        local okI, id = pcall(C_Item.GetItemID, loc)
        if okI and type(id) == "number" then return id end
    end
    return nil
end

-- Puts the price on the sell frame whenever the item or a setting changed since the last time;
-- what the player types afterwards stays until one of them changes again.
function Auction:AutoPrice(id, price)
    local o = DB().options
    local key = table.concat({ id, price, o.undercut or 0, o.floor or 0, o.basis or "", o.match and 1 or 0 }, "|")
    if key == Auction.appliedKey then return end
    if Auction:SellItemID() == id and SetSellPrice(price) then Auction.appliedKey = key end
end

-- The quantity the sell frame holds, or nil.
local function ReadQuantity()
    local f = SellFrame()
    local q = f and f.QuantityInput
    if q and q.GetQuantity then
        local ok, v = pcall(q.GetQuantity, q)
        if ok and type(v) == "number" then return v end
    end
end

local function WriteQuantity(n)
    local f = SellFrame()
    local q = f and f.QuantityInput
    return q and q.SetQuantity and pcall(q.SetQuantity, q, n) or false
end

-- Looked at every tick of the Sell tab: a new item gets the stack size you used last time, and a
-- change you make to the quantity is remembered for that item. The frame sets its own quantity a
-- moment after an item arrives, so for the first second a different number is put right, not learned.
function Auction:WatchStack(id)
    local mem = DB().memory
    local q = ReadQuantity()
    if not q then return end
    local m = mem[id]
    if Auction.stackItem ~= id then
        Auction.stackItem, Auction.stackGrace = id, 4
        if m and m.stack and m.stack ~= q and WriteQuantity(m.stack) then q = ReadQuantity() or m.stack end
        Auction.stackSeen = q
        return
    end
    if q == Auction.stackSeen then
        if Auction.stackGrace > 0 then Auction.stackGrace = Auction.stackGrace - 1 end
        return
    end
    if Auction.stackGrace > 0 then
        Auction.stackGrace = Auction.stackGrace - 1
        if m and m.stack and WriteQuantity(m.stack) then q = ReadQuantity() or m.stack end
        Auction.stackSeen = q
        return
    end
    Auction.stackSeen = q
    if type(m) ~= "table" then m = {}; mem[id] = m end
    m.stack = q
end

local function BagWorth()
    local list, seen = {}, {}
    local C = C_Container
    if not (C and C.GetContainerNumSlots and C.GetContainerItemInfo) then return list end
    for bag = 0, 5 do
        local okN, slots = pcall(C.GetContainerNumSlots, bag)
        if okN and type(slots) == "number" then
            for slot = 1, slots do
                local ok, info = pcall(C.GetContainerItemInfo, bag, slot)
                if ok and type(info) == "table" and info.itemID and not info.isBound then
                    local e = seen[info.itemID]
                    if not e then
                        e = { id = info.itemID, count = 0, bag = bag, slot = slot, stack = info.stackCount or 1 }
                        seen[info.itemID] = e
                        list[#list + 1] = e
                    end
                    e.count = e.count + (info.stackCount or 1)
                end
            end
        end
    end
    local out = {}
    for _, e in ipairs(list) do
        local r = Auction:Price(e.id)
        if r and not IsUnsellable(e.id) then
            e.r = r
            e.total = r.p * e.count
            out[#out + 1] = e
        end
    end
    table.sort(out, function(a, b) return a.total > b.total end)
    return out
end

local function BagClick(e)
    if IsShiftKeyDown and IsShiftKeyDown() then Auction:Search(ItemName(e.id)) return end
    Auction:Prepare(e)
end

-- Lists an item from the bags: it goes into the Sell tab with its quantity and the suggested
-- price, and the player has only to press Create Auction.
function Auction:Prepare(e)
    local ah = _G.AuctionHouseFrame
    Auction.lastItem = e.id
    Auction.appliedKey = nil
    if not (ah and ah.SetPostItem and ItemLocation and e.bag and e.slot) then
        Say("Put the item in the Sell tab, and the price will be filled in.")
        Auction:Render()
        return
    end
    if not pcall(function() ah:SetPostItem(ItemLocation:CreateFromBagAndSlot(e.bag, e.slot)) end) then
        Say("The item could not be put in the Sell tab.")
    end
    local function finish()
        local m = DB().memory[e.id]
        local want = m and m.stack or e.stack
        if want then WriteQuantity(math.min(want, math.max(e.count or want, 1))) end
        Auction.stackItem = nil -- the next tick takes the quantity as the starting point
        Auction:Render() -- RenderSell applies the price once the frame holds the item
    end
    finish()
    if C_Timer and C_Timer.After then C_Timer.After(0.25, finish) end -- the frame fills in a moment later
end

local function RenderSell()
    ScanBlock()
    Header("Price check")
    -- the item in the Sell tab is the one checked, unless it has no price on file
    local selling = Auction:SellItemID()
    if selling and Auction:Price(selling) then Auction.lastItem = selling end
    local id, r, typical = PriceCheck()
    if id then
        local price = SuggestedPrice(id, r, typical)
        Auction:AutoPrice(id, price)
        Row({ title = "Suggested price", right = Money(price),
            sub = string.format("%s the %s%s", DB().options.match and "At" or (tostring(DB().options.undercut) .. "% under"),
                DB().options.basis == "typical" and "usual price" or "lowest listing",
                typical and string.format(", not below %s%% of usual", tostring(DB().options.floor)) or "") })
        Button("Set the price", 8, CHILD_W - 16, function()
            if not SetSellPrice(price) then Say("Open the item in the Sell tab first.") end
        end)
        RowEnd()
    end

    Header("Selling")
    Toggle("Match the lowest, do not undercut", "match")
    if not DB().options.match then
        Stepper("Undercut by", "undercut", 1, 0, 20, function(v) return v .. "%" end)
    end
    Stepper("Never below, of the usual price", "floor", 5, 50, 100, function(v) return v .. "%" end)
    Choice("Price from", "basis", { { "lowest", "Lowest listing" }, { "typical", "Usual price" } })

    Header("In your bags")
    local bag = BagWorth()
    if #bag == 0 then Text("Nothing in your bags has a price yet.", "GameFontDisableSmall", Theme.MUTED) end
    for i = 1, math.min(#bag, BAG_LIST) do
        local e = bag[i]
        Row({ title = ItemName(e.id), right = Money(e.total),
            sub = e.count .. " at " .. Money(e.r.p), data = e, onClick = BagClick })
    end
end

-- How an auction of yours stands: a text, a color and whether it is a problem.
local function Standing(unit, id)
    local r = Auction:Price(id)
    if not r then return "No price on file for it", Theme.MUTED end
    if r.p < unit * 0.999 then
        return string.format("Undercut: lowest is %s (%d%% less)", Money(r.p), math.floor((unit - r.p) / unit * 100 + 0.5)), Theme.BAD, true, "undercut"
    end
    local typical = Auction:Typical(id)
    if typical and unit > typical * 1.15 then return "Priced above the usual: may be slow", Theme.WARN, true end
    if r.n and r.n >= 20 then return "Lowest, but " .. r.n .. " listings compete", Theme.WARN end
    return "Lowest listing: likely to sell", Theme.GOOD
end
Auction.Standing = Standing

local function OwnedUnit(info, id)
    local total = tonumber(info.buyoutAmount) or 0
    local qty = math.max(tonumber(info.quantity) or 1, 1)
    if qty == 1 then return total end
    -- a commodity's buyout may be the unit price, an item's the stack's: the one nearer the price on file
    local r = Auction:Price(id)
    if r and math.abs(total - r.p) < math.abs(total / qty - r.p) then return total end
    return total / qty
end

local function CostOf(id)
    local b = DB().bought[id]
    if type(b) == "table" and b.n and b.n > 0 then return b.total / b.n end
end

Auction.summary = { sold = 0, gold = 0, gone = 0 }
Auction.cancelled = {}

-- Reads your auctions: a sale not seen before goes in the sales log (net of the cut, with the
-- profit when you bought the item through here), and an auction that was up last time and is not
-- now (and did not sell, nor was cancelled here) counts as gone.
local function UpdateOwned()
    if not (C_AuctionHouse and C_AuctionHouse.GetOwnedAuctions) then return end
    local ok, list = pcall(C_AuctionHouse.GetOwnedAuctions)
    if not ok or type(list) ~= "table" then return end
    local db, now, sum = DB(), Now(), Auction.summary
    local soldStatus = Enum and Enum.AuctionStatus and Enum.AuctionStatus.Sold or 1
    local cur = {}
    for _, info in ipairs(list) do
        local id = type(info.itemKey) == "table" and info.itemKey.itemID
        local aid = info.auctionID
        if id and aid then
            if info.status == soldStatus then
                if not db.soldSeen[aid] then
                    db.soldSeen[aid] = now
                    local qty = math.max(tonumber(info.quantity) or 1, 1)
                    local net = math.floor(OwnedUnit(info, id) * qty * (1 - AH_CUT))
                    local cost = CostOf(id)
                    table.insert(db.sales, 1, { id = id, t = now, qty = qty, net = net, profit = cost and math.floor(net - cost * qty) or nil })
                    while #db.sales > SALES_MAX do db.sales[#db.sales] = nil end
                    sum.sold, sum.gold = sum.sold + 1, sum.gold + net
                end
            elseif info.status == nil or info.status == (Enum and Enum.AuctionStatus and Enum.AuctionStatus.Active or 0) then
                cur[aid] = id
            end
        end
    end
    if #list > 0 then
        for aid in pairs(db.owned) do
            if not cur[aid] and not db.soldSeen[aid] and not Auction.cancelled[aid] then sum.gone = sum.gone + 1 end
        end
    end
    db.owned = cur
end

local function CancelNext(rows)
    for _, e in ipairs(rows) do
        if e.undercut and e.auctionID then
            Auction.cancelled[e.auctionID] = true
            if pcall(C_AuctionHouse.CancelAuction, e.auctionID) then
                Auction.cancelling = { aid = e.auctionID, id = e.id, at = Mono() }
                Say("Cancelling " .. ItemName(e.id) .. "...")
            else
                Say("That auction could not be cancelled.")
            end
            pcall(function() C_AuctionHouse.QueryOwnedAuctions({}) end)
            return
        end
    end
end

local function RenderAuctions()
    ScanBlock()
    local sum = Auction.summary
    if sum.sold > 0 or sum.gone > 0 then
        Header("Since you came in")
        Text(string.format("%d sold for %s. %d no longer up.", sum.sold, Money(sum.gold), sum.gone),
            "GameFontHighlightSmall", sum.sold > 0 and Theme.GOOD or Theme.MUTED)
    end
    Header("Your auctions")
    local ok, list = pcall(C_AuctionHouse.GetOwnedAuctions)
    if not ok or type(list) ~= "table" then
        Text("Your auctions are not loaded yet.", "GameFontDisableSmall", Theme.MUTED)
        return
    end
    local active = Enum and Enum.AuctionStatus and Enum.AuctionStatus.Active or 0
    local rows, problems = {}, 0
    for _, info in ipairs(list) do
        local id = type(info.itemKey) == "table" and info.itemKey.itemID
        if id and (info.status == nil or info.status == active) then
            local unit = OwnedUnit(info, id)
            local text, color, bad, kind = Standing(unit, id)
            if bad then problems = problems + 1 end
            rows[#rows + 1] = { id = id, unit = unit, text = text, color = color, auctionID = info.auctionID, undercut = kind == "undercut" }
        end
    end
    if #rows == 0 then
        Text("You have no auctions up.", "GameFontDisableSmall", Theme.MUTED)
        return
    end
    Text(string.format("%d up, %d to look at", #rows, problems), "GameFontHighlightSmall", problems > 0 and Theme.WARN or Theme.GOOD)
    for _, e in ipairs(rows) do
        local name = ItemName(e.id)
        Row({ title = name, right = Money(e.unit),
            sub = Hex(e.color) .. e.text .. "|r", data = name,
            onClick = function(n) Auction:Search(n) end })
    end
    Text("Click one to search for it.", "GameFontDisableSmall", Theme.MUTED)
    local undercut = 0
    for _, e in ipairs(rows) do if e.undercut and e.auctionID then undercut = undercut + 1 end end
    if undercut > 0 then
        Button(string.format("Cancel next undercut (%d)", undercut), 8, CHILD_W - 16, function() CancelNext(rows) end)
        RowEnd()
    end

    local sales = DB().sales
    if #sales > 0 then
        Header("Sold lately")
        for i = 1, math.min(#sales, SALES_SHOWN) do
            local e = sales[i]
            local profit = e.profit and (e.profit >= 0 and ("Profit " .. Money(e.profit)) or ("Loss " .. Money(-e.profit))) or "Cost not known"
            Row({ title = (e.qty > 1 and (e.qty .. " x ") or "") .. ItemName(e.id), right = Money(e.net),
                sub = profit .. ", " .. Ago(e.t) })
        end
    end
end

local RENDER = { buy = RenderBuy, sell = RenderSell, auctions = RenderAuctions }
local TITLE = { buy = "Auction - buy", sell = "Auction - sell", auctions = "Auction - your auctions" }

function Auction:Render()
    if not (window and window:IsShown()) then return end
    local tab = Auction:CurrentTab()
    Auction.tab = tab
    window.title:SetText(TITLE[tab])
    ResetPools()
    SetBudget(window)
    local ok, err = pcall(RENDER[tab])
    if not ok then Text("Something went wrong drawing this tab.", "GameFontDisableSmall", Theme.MUTED); Auction.lastError = err end
    MoreLine()
    content:SetHeight(math.max(y + 12, 1))
    Auction:RenderPopout()
end

-- ---------- the window ----------
local function CreateBar()
    local f = CreateFrame("Frame", "PathForeverAuctionScan", UIParent, "BackdropTemplate")
    f:SetSize(280, 58)
    f:SetFrameStrata("DIALOG")
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 120)
    Theme.StyleWindow(f)
    f.label = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.label:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -12)
    f.label:SetWidth(256)
    f.label:SetJustifyH("LEFT")
    f.track = f:CreateTexture(nil, "ARTWORK")
    f.track:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -34)
    f.track:SetSize(256, 8)
    f.track:SetColorTexture(1, 1, 1, 0.12)
    f.fill = f:CreateTexture(nil, "OVERLAY")
    f.fill:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -34)
    f.fill:SetSize(1, 8)
    local r, g, b = Theme.GetAccentColor()
    f.fill:SetColorTexture(r, g, b, 0.9)
    f:Hide()
    return f
end

local function CreateWindow()
    local f = CreateFrame("Frame", "PathForeverAuctionFrame", UIParent, "BackdropTemplate")
    f:SetWidth(WIDTH)
    f:SetFrameStrata("MEDIUM")
    f:SetToplevel(true)
    f:EnableMouse(true)
    Theme.StyleWindow(f)
    f.titleLine = { Theme.AddFadedLine(f, 34, 0, 0.4) }
    local logo = f:CreateTexture(nil, "ARTWORK")
    logo:SetSize(16, 16)
    logo:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -9)
    logo:SetTexture(PF.ICON)
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.title:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + 22, -10)
    f.title:SetWidth(WIDTH - 2 * PAD - 22 - 24)
    f.title:SetJustifyH("LEFT")
    local close = CreateFrame("Button", nil, f)
    close:SetSize(24, 24)
    close:SetPoint("TOPRIGHT", -8, -8)
    local ct = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    ct:SetPoint("CENTER")
    ct:SetText("\195\151")
    ct:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    close:SetScript("OnClick", function()
        f:Hide()
        Auction.dismissed = true
        Theme.PlayUISound("IG_CHARACTER_INFO_CLOSE")
    end)
    close:SetScript("OnEnter", function() ct:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    close:SetScript("OnLeave", function() ct:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3]) end)
    f.close = close

    content = CreateFrame("Frame", nil, f)
    content:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -38)
    content:SetSize(CHILD_W, 1)
    f.content = content

    -- the tab can change without an event we hear: look every so often while shown
    f.tick = 0
    f:SetScript("OnUpdate", function(self, elapsed)
        self.tick = self.tick + elapsed
        if self.tick < 0.3 then return end
        self.tick = 0
        -- "Last scan 3 min ago" and the prices' ages move on while the panel stays open
        self.age = (self.age or 0) + 0.3
        if self.age >= 20 and not Auction:ScanActive() then
            self.age = 0
            Auction:Render()
            return
        end
        local tab = Auction:CurrentTab()
        if Auction.dirty then
            Auction.dirty = false
            Auction:Render()
        elseif tab ~= Auction.tab then
            Auction:Render()
        elseif tab == "sell" then
            local id = Auction:SellItemID()
            if id then Auction:WatchStack(id) end
            if id ~= Auction.sellSeen then Auction.sellSeen = id; Auction:Render() end
        end
    end)
    f:Hide()
    return f
end

-- The second window: the deal lists, beside the panel. It has its own pools and scroll child, so
-- drawing it swaps those in for the panel's for a moment.
local function CreatePop()
    local f = CreateFrame("Frame", "PathForeverAuctionPopout", UIParent, "BackdropTemplate")
    f:SetWidth(WIDTH)
    f:SetFrameStrata("MEDIUM")
    f:SetToplevel(true)
    f:EnableMouse(true)
    Theme.StyleWindow(f)
    f.titleLine = { Theme.AddFadedLine(f, 34, 0, 0.4) }
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.title:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -10)
    f.title:SetWidth(WIDTH - 2 * PAD - 24)
    f.title:SetJustifyH("LEFT")
    local close = CreateFrame("Button", nil, f)
    close:SetSize(24, 24)
    close:SetPoint("TOPRIGHT", -8, -8)
    local ct = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    ct:SetPoint("CENTER")
    ct:SetText("\195\151")
    ct:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    close:SetScript("OnClick", function()
        Auction.popout = nil
        Auction:Render()
        Theme.PlayUISound("IG_CHARACTER_INFO_CLOSE")
    end)
    close:SetScript("OnEnter", function() ct:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    close:SetScript("OnLeave", function() ct:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3]) end)
    local c = CreateFrame("Frame", nil, f)
    c:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -38)
    c:SetSize(CHILD_W, 1)
    f.content, f.pools = c, {}
    f:Hide()
    return f
end

function Auction:RenderPopout()
    local draw = Auction.popout and RENDER_POP[Auction.popout]
    if not (draw and window and window:IsShown() and Auction.tab == "buy") then
        if pop then pop:Hide() end
        return
    end
    if not pop then pop = CreatePop() end
    pop:ClearAllPoints()
    pop:SetPoint("TOPLEFT", window, "TOPRIGHT", 4, 0)
    pop:SetPoint("BOTTOMLEFT", window, "BOTTOMRIGHT", 4, 0)
    pop.title:SetText(TITLE_POP[Auction.popout])
    local sp, sc, sy = pools, content, y
    pools, content = pop.pools, pop.content
    ResetPools()
    SetBudget(pop)
    local ok, err = pcall(draw)
    if not ok then Text("Something went wrong drawing this list.", "GameFontDisableSmall", Theme.MUTED); Auction.lastError = err end
    MoreLine()
    content:SetHeight(math.max(y + 12, 1))
    pools, content, y = sp, sc, sy
    pop:Show()
    pop:Raise()
end

-- Anchored to the auction window's right edge, as tall as it is.
local function Place()
    local ah = _G.AuctionHouseFrame
    if not (window and ah) then return false end
    window:ClearAllPoints()
    window:SetPoint("TOPLEFT", ah, "TOPRIGHT", 4, 0)
    window:SetPoint("BOTTOMLEFT", ah, "BOTTOMRIGHT", 4, 0)
    return true
end

function Auction:Show()
    if not window then window = CreateWindow() end
    if not bar then bar = CreateBar() end
    if not Place() then return end
    window:Show()
    window:Raise()
    Auction:Render()
end

function Auction:Hide()
    if window then window:Hide() end
    if pop then pop:Hide() end
end

-- ---------- events ----------
local events = CreateFrame("Frame")
Auction.eventFrame = events
for _, e in ipairs({ "ADDON_LOADED", "AUCTION_HOUSE_SHOW", "AUCTION_HOUSE_CLOSED", "REPLICATE_ITEM_LIST_UPDATE",
    "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED", "AUCTION_HOUSE_BROWSE_RESULTS_ADDED", "ITEM_SEARCH_RESULTS_UPDATED",
    "COMMODITY_SEARCH_RESULTS_UPDATED", "OWNED_AUCTIONS_UPDATED", "AUCTION_HOUSE_PURCHASE_COMPLETED",
    "TRADE_SKILL_SHOW", "TRADE_SKILL_LIST_UPDATE", "ITEM_DATA_LOAD_RESULT", "PLAYER_MONEY", "AUCTION_CANCELED" }) do
    pcall(events.RegisterEvent, events, e)
end
-- No answer from the game in time: say so instead of leaving the click without a word.
local function AnswerStep()
    local b, c = Auction.bidding, Auction.cancelling
    if b and Mono() - b.at > ANSWER_WAIT then
        Auction.bidding = nil
        Say("No answer for the purchase. Check the auction house before trying again.")
    end
    if c and Mono() - c.at > ANSWER_WAIT then
        Auction.cancelling = nil
        Say("No answer for the cancel. It may not have gone through.")
    end
end
local function Cancelled(c)
    Auction.cancelling = nil
    Say("Cancelled " .. ItemName(c.id) .. ". It comes back by mail, and the deposit is not returned.")
end
events:SetScript("OnUpdate", function(_, elapsed) ScanStep(elapsed); SnipeStep(elapsed); OtherStep(elapsed); AnswerStep() end)
events:SetScript("OnEvent", function(_, event, a1)
    if event == "ADDON_LOADED" then
        if a1 == "PathForever_Auction" then Prune(DB()) end
    elseif event == "AUCTION_HOUSE_SHOW" then
        Auction.ahOpen, Auction.dismissed = true, false
        Auction.summary = { sold = 0, gold = 0, gone = 0 }
        otherCache.hold = OTHER_HOLD -- leave the window's own opening alone for a moment
        pcall(function() C_AuctionHouse.QueryOwnedAuctions({}) end)
        Auction:Show()
    elseif event == "AUCTION_HOUSE_CLOSED" then
        Auction.ahOpen = false
        Auction.pending, Auction.bidding, Auction.cancelling = nil, nil, nil
        Auction.sniping = false
        Auction.popout = nil
        if scan.active then EndScan("The auction house closed, so the scan stopped.") end
        Auction:Hide()
    elseif event == "REPLICATE_ITEM_LIST_UPDATE" then
        OnReplicate()
    elseif event == "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" or event == "AUCTION_HOUSE_BROWSE_RESULTS_ADDED" then
        LearnBrowse()
        Auction.dirty = true -- drawn by the window's next tick: browse results come in bursts
    elseif event == "ITEM_SEARCH_RESULTS_UPDATED" then
        OnItemSearch(a1)
        Auction:Render()
    elseif event == "COMMODITY_SEARCH_RESULTS_UPDATED" then
        LearnCommodity(a1)
        Auction:Render()
    elseif event == "OWNED_AUCTIONS_UPDATED" then
        UpdateOwned()
        local c = Auction.cancelling
        if c and not (DB().owned and DB().owned[c.aid]) then Cancelled(c) end -- it left the list
        Auction:Render()
    elseif event == "AUCTION_CANCELED" then
        local c = Auction.cancelling
        if c and (a1 == nil or a1 == c.aid) then Cancelled(c) end
    elseif event == "PLAYER_MONEY" then
        local b = Auction.bidding
        if b and b.money and GetMoney and GetMoney() <= b.money - b.d.b then Bought(b.d) end
    elseif event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_LIST_UPDATE" then
        -- a profession was opened: read its recipes while the client has them
        pcall(Auction.ReadRecipes, Auction)
        if Auction.ahOpen and DB().options.view == "recipes" then Auction:Render() end
    elseif event == "ITEM_DATA_LOAD_RESULT" then
        if askedName[a1] then Auction.dirty = true end
    elseif event == "AUCTION_HOUSE_PURCHASE_COMPLETED" then
        local b = Auction.bidding or Auction.pending
        if b then Bought(b.d) end
    end
end)

-- for the tests
Auction.Record, Auction.Verdict, Auction.SuggestedPrice = Record, Verdict, SuggestedPrice
Auction.GetWindow = function() return window end
Auction.GetBar = function() return bar end
