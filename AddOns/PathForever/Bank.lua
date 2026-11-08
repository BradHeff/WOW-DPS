-- PathForever: the bank browser (PF.Bank).
--
-- The game only lets a character read its bank while standing at a banker, so PathForever
-- writes down what is in it each time the bank is open (the items and how many, nothing
-- else) and the Bank page shows it for any character that has been seen at a bank, chosen
-- from a list at the top. Saved account-wide in PathForeverDB.banks[guid] = { name, class,
-- time, items = { { id, count } } }, by GUID like every character. Each character's entry
-- is replaced as a whole on every look, so it can never go stale in part.
--
-- Reading is plain container calls inside pcall; nothing here is protected.

local PF = PathForever
local Bank = {}
PF.Bank = Bank

local open = false -- a banker is open right now

local function Containers()
    local list = {}
    local main = (Enum and Enum.BagIndex and Enum.BagIndex.Bank) or BANK_CONTAINER or -1
    list[#list + 1] = main
    local first = (NUM_BAG_SLOTS or 4) + 1
    local last = (NUM_BAG_SLOTS or 4) + (NUM_BANKBAGSLOTS or 7)
    for b = first, last do list[#list + 1] = b end
    return list
end

-- Writes down the bank as it is now. Does nothing unless a banker is open, so a closed
-- bank (which reads as empty) never wipes a saved one.
function Bank:Snapshot(closing)
    if not open or not (C_Container and C_Container.GetContainerNumSlots) then return false end
    local guid = UnitGUID and UnitGUID("player")
    local name = PF.GetPlayerFullName and PF:GetPlayerFullName()
    if not (guid and name and PathForeverDB) then return false end
    local counts, order, slots = {}, {}, 0
    for _, bag in ipairs(Containers()) do
        local ok, n = pcall(C_Container.GetContainerNumSlots, bag)
        n = ok and tonumber(n) or 0
        slots = slots + n
        for slot = 1, n do
            local ok2, info = pcall(C_Container.GetContainerItemInfo, bag, slot)
            if ok2 and type(info) == "table" and info.itemID then
                if not counts[info.itemID] then order[#order + 1] = info.itemID; counts[info.itemID] = 0 end
                counts[info.itemID] = counts[info.itemID] + (tonumber(info.stackCount) or 1)
            end
        end
    end
    if slots == 0 then return false end -- the bank did not answer: keep what was saved
    -- as the window closes the client may already read the bank as empty: keep what was saved
    if closing and #order == 0 then return false end
    local items = {}
    for _, id in ipairs(order) do items[#items + 1] = { id = id, count = counts[id] } end
    if type(PathForeverDB.banks) ~= "table" then PathForeverDB.banks = {} end
    local _, class = UnitClass("player")
    PathForeverDB.banks[guid] = { name = name, class = class, time = time and time() or 0, items = items }
    if PF.RequestRefresh then PF:RequestRefresh("bank") end
    return true
end

function Bank:IsOpen() return open end
function Bank:SetOpen(v) open = v and true or false end

-- Every character with a saved bank, as { guid, name, class, time, items }: the current
-- character first, then by name. Entries are read defensively.
function Bank:Characters()
    local out = {}
    local me = UnitGUID and UnitGUID("player")
    for guid, e in pairs((PathForeverDB and PathForeverDB.banks) or {}) do
        if type(e) == "table" and type(e.name) == "string" and type(e.items) == "table" then
            out[#out + 1] = { guid = guid, name = e.name, class = e.class, time = tonumber(e.time) or 0, items = e.items }
        end
    end
    table.sort(out, function(a, b)
        if (a.guid == me) ~= (b.guid == me) then return a.guid == me end
        if a.name ~= b.name then return a.name < b.name end
        return tostring(a.guid) < tostring(b.guid)
    end)
    return out
end

-- The character whose bank the page shows: the one picked, else the current one, else the
-- first with a bank.
local selected
function Bank:GetSelected()
    local list = self:Characters()
    for _, c in ipairs(list) do if c.guid == selected then return c, list end end
    return list[1], list
end
function Bank:Select(guid) selected = guid end

local function IsBanker(kind)
    local t = Enum and Enum.PlayerInteractionType
    return t ~= nil and kind == t.Banker
end

local function Event(_, event, kind)
    if (event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" or event == "PLAYER_INTERACTION_MANAGER_FRAME_HIDE") and not IsBanker(kind) then
        return -- some other window (a merchant, the mailbox)
    end
    if event == "BANKFRAME_OPENED" or event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
        open = true
        C_Timer.After(0.3, function() Bank:Snapshot() end) -- the slots fill a moment after opening
    elseif event == "BANKFRAME_CLOSED" or event == "PLAYER_INTERACTION_MANAGER_FRAME_HIDE" then
        if open then Bank:Snapshot(true) end
        open = false
    elseif event == "BAG_UPDATE_DELAYED" or event == "PLAYERBANKSLOTS_CHANGED" then
        if open then Bank:Snapshot() end
    end
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", Event)
-- newer clients drop some of these names, and registering one that does not exist is an error
for _, e in ipairs({ "BANKFRAME_OPENED", "BANKFRAME_CLOSED", "BAG_UPDATE_DELAYED", "PLAYERBANKSLOTS_CHANGED",
                     "PLAYER_INTERACTION_MANAGER_FRAME_SHOW", "PLAYER_INTERACTION_MANAGER_FRAME_HIDE" }) do
    pcall(frame.RegisterEvent, frame, e)
end
