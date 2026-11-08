-- Mail.lua - PathForever Mail
-- A small window beside the mail window's Send Mail tab: "Send to..." and the last ten people
-- you mailed. Fill in the items and gold as usual, then click a name: it goes in the To box and
-- the mail is sent, so a regular recipient costs one click.
--
-- The window is ours, anchored to the mail window (never its child). Clicking a name writes the
-- name into the mail window's own To box and clicks its own Send button, so every rule the game
-- has about a mail (an empty mail, a missing subject, cash on delivery) still applies; if the
-- Send button is not ready, nothing is sent and a line in chat says so. The names are learned
-- from the game's own send (a secure hook on SendMail, which cannot taint it) once it reports
-- success (MAIL_SEND_SUCCESS), whether the mail was sent from here or by hand.
-- Unverified on Forever (docs/launch-checklist.md): the mail window's frame names, and whether
-- a click on our row lets Send run. Every call is in a pcall. Out of combat only.
-- Text follows UI.lua's "How text is laid out": TOPLEFT anchors, an explicit width, never an
-- explicit height.

local PF = PathForever
local Mail = {}
PF.Mail = Mail

local Theme = PF.Theme
local WIDTH = 200
local PAD = 12
local ROW_H = 26
local TITLE_H = 36
local MAX_NAMES = 10

local function DB()
    if type(PathForeverMailDB) ~= "table" then PathForeverMailDB = {} end
    local db = PathForeverMailDB
    if type(db.recent) ~= "table" then db.recent = {} end
    return db
end

local function Say(text) print("|cff3fc7ebPathForever Mail:|r " .. text) end

-- The most recent first. Names are for display and for the To box only.
function Mail:Recent()
    return DB().recent
end

function Mail:Remember(name)
    if type(name) ~= "string" then return end
    name = name:match("^%s*(.-)%s*$")
    if name == "" then return end
    local list = DB().recent
    local key = name:lower()
    for i = #list, 1, -1 do
        if type(list[i]) ~= "string" or list[i]:lower() == key then table.remove(list, i) end
    end
    table.insert(list, 1, name)
    while #list > MAX_NAMES do list[#list] = nil end
    Mail.version = (Mail.version or 0) + 1
end

-- Press the mail window's Send button if it is ready. The game works out whether Send may be
-- pressed from the boxes, and may do it a moment after a box changes, so it is asked to work it
-- out again first. True once pressed.
local RETRY_EVERY, RETRY_TIMES = 0.1, 10
local function Press(name)
    local send = _G.SendMailMailButton
    if not send then return false end
    if _G.SendMailFrame_CanSend then pcall(_G.SendMailFrame_CanSend) end
    if not send:IsEnabled() then return false end
    Mail.pending = name
    local ok, err = pcall(send.Click, send)
    if not ok then Say("The mail window would not send it: " .. tostring(err)) end
    return true
end

-- Put the name in the To box and send the mail the player filled in.
function Mail:SendTo(name)
    if InCombatLockdown and InCombatLockdown() then Say("Not in combat.") return end
    local box, subject, send = _G.SendMailNameEditBox, _G.SendMailSubjectEditBox, _G.SendMailMailButton
    if not (box and send) then return end
    pcall(box.SetText, box, name)
    -- an item gives the mail its subject; gold alone needs one
    if subject and (subject:GetText() or "") == "" and not send:IsEnabled() then
        pcall(subject.SetText, subject, "Mail")
    end
    if Press(name) then Mail.retry = nil return end
    -- the button may take a moment to catch up with the boxes: look again for a second
    Mail.retry = { name = name, left = RETRY_TIMES, t = 0 }
end

local function Retry(elapsed)
    local r = Mail.retry
    if not r then return end
    r.t = r.t + elapsed
    if r.t < RETRY_EVERY then return end
    r.t = 0
    r.left = r.left - 1
    if Press(r.name) then
        Mail.retry = nil
    elseif r.left <= 0 then
        Mail.retry = nil
        Say("Add something to send first.")
    end
end

-- ---------- the window ----------
local window, rows = nil, {}

local function RowOnClick(self)
    if self.name then
        Theme.PlayUISound("IG_MAINMENU_OPTION_CHECKBOX_ON")
        Mail:SendTo(self.name)
    end
end

local function AcquireRow(i)
    local r = rows[i]
    if not r then
        r = CreateFrame("Button", nil, window)
        -- well above the window's own border and line frames, which can sit over part of a row
        r:SetFrameLevel(window:GetFrameLevel() + 20)
        r:EnableMouse(true)
        r:RegisterForClicks("LeftButtonUp")
        r.glow = Theme.CreateGlow and Theme.CreateGlow(r, "LEFT", 0.20)
        r.text = r:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        r.text:SetPoint("TOPLEFT", r, "TOPLEFT", 10, -6)
        r.text:SetWidth(WIDTH - 2 * PAD - 8)
        r.text:SetJustifyH("LEFT")
        r:SetScript("OnClick", RowOnClick)
        r:SetScript("OnEnter", function(self) if self.glow then self.glow:Show() end end)
        r:SetScript("OnLeave", function(self) if self.glow then self.glow:Hide() end end)
        rows[i] = r
    end
    return r
end

local function Render()
    if not window then return end
    local list = Mail:Recent()
    local y = TITLE_H + 4
    for i = 1, math.max(#list, #rows) do
        local name = list[i]
        if name then
            local r = AcquireRow(i)
            r:ClearAllPoints()
            r:SetPoint("TOPLEFT", window, "TOPLEFT", PAD - 4, -y)
            r:SetSize(WIDTH - 2 * PAD + 8, ROW_H)
            r.name = name
            r.text:SetText(name)
            if r.glow then r.glow:Hide() end
            r:Show()
            y = y + ROW_H
        elseif rows[i] then
            rows[i].name = nil
            rows[i]:Hide()
        end
    end
    if #list == 0 then
        window.empty:Show()
        y = y + 22
    else
        window.empty:Hide()
    end
    window:SetHeight(y + 12)
    window.drawn = Mail.version
end

local function CreateWindow()
    local f = CreateFrame("Frame", "PathForeverMailFrame", UIParent, "BackdropTemplate")
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
    f.title:SetText("Send to...")
    local close = CreateFrame("Button", nil, f)
    close:SetSize(24, 24)
    close:SetPoint("TOPRIGHT", -6, -6)
    local ct = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    ct:SetPoint("CENTER")
    ct:SetText("\195\151")
    ct:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    close:SetScript("OnClick", function()
        f:Hide()
        Mail.dismissed = true
        Theme.PlayUISound("IG_CHARACTER_INFO_CLOSE")
    end)
    close:SetScript("OnEnter", function() ct:SetTextColor(Theme.TEXT[1], Theme.TEXT[2], Theme.TEXT[3]) end)
    close:SetScript("OnLeave", function() ct:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3]) end)
    f.empty = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    f.empty:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -(TITLE_H + 6))
    f.empty:SetWidth(WIDTH - 2 * PAD)
    f.empty:SetJustifyH("LEFT")
    f.empty:SetText("Nobody yet")
    f.empty:SetTextColor(Theme.MUTED[1], Theme.MUTED[2], Theme.MUTED[3])
    f:Hide()
    return f
end

local function Shown(f) return f and f.IsShown and f:IsShown() end

-- Beside the mail window while its Send Mail tab shows.
local function Sync()
    local mf = _G.MailFrame
    local want = Mail.open and not Mail.dismissed and Shown(mf) and Shown(_G.SendMailFrame)
    if not want then
        if window and window:IsShown() then window:Hide() end
        return
    end
    if not window then window = CreateWindow() end
    if not window:IsShown() then
        window:ClearAllPoints()
        window:SetPoint("TOPLEFT", mf, "TOPRIGHT", 4, 0)
        window:Show()
        window:Raise()
        Render()
    elseif window.drawn ~= Mail.version then
        Render()
    end
end

-- ---------- events ----------
local events = CreateFrame("Frame")
Mail.eventFrame = events
for _, e in ipairs({ "MAIL_SHOW", "MAIL_CLOSED", "MAIL_SEND_SUCCESS", "MAIL_FAILED" }) do
    pcall(events.RegisterEvent, events, e)
end

-- what the game is asked to send, by hand or from here
local function Hooked(name)
    if type(name) == "string" then Mail.pending = name end
end
if hooksecurefunc then
    if _G.SendMail then pcall(hooksecurefunc, "SendMail", Hooked) end
    if _G.C_Mail and C_Mail.SendMail then pcall(hooksecurefunc, C_Mail, "SendMail", Hooked) end
end

events.tick = 0
events:SetScript("OnUpdate", function(self, elapsed)
    Retry(elapsed)
    self.tick = self.tick + elapsed
    if self.tick < 0.3 then return end
    self.tick = 0
    Sync()
end)
events:SetScript("OnEvent", function(_, event)
    if event == "MAIL_SHOW" then
        Mail.open, Mail.dismissed = true, false
        Sync()
    elseif event == "MAIL_CLOSED" then
        Mail.open, Mail.pending = false, nil
        Sync()
    elseif event == "MAIL_SEND_SUCCESS" then
        if Mail.pending then Mail:Remember(Mail.pending) end
        Mail.pending = nil
        Sync()
    elseif event == "MAIL_FAILED" then
        Mail.pending = nil
    end
end)

-- for the tests
Mail.GetWindow = function() return window end
Mail.Sync = Sync
