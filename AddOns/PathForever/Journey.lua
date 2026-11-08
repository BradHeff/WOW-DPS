-- PathForever: the Journey tab.
--
-- The home page: the leveling character on the left (name, level and class over the
-- model, which turns when dragged), a "Next up" list on the right where each row is a
-- module's live summary (a click opens its page), and Gold, XP and Discover tiles along
-- the bottom (Gold and XP open their window beside the main one, Discover its page).
--
-- A module is { id, label, priority, default = true for the three cards it starts
-- with, IsRelevant(ctx), IsComplete(ctx), Summary(ctx) -> text, Render(panel, ctx) }.
-- When a default module is complete (every skill trained, every class quest done),
-- its card goes to the highest-priority relevant module that isn't complete or
-- already showing. ctx is one table, refilled on every render (allocates nothing).
--
-- Everything here is the addon's own frames and plain reads of the game's state:
-- nothing protected, so it behaves the same in and out of combat. Quest details
-- open in UI.lua's side panel, the same one the Dungeons tab uses.

local PF = PathForever
local Journey = {}
PF.Journey = Journey

local Data = PathForeverData

-- Layout. The window is 420 x 580 and the page area starts below its header (46); the sidebar hangs off its left edge.
local CARD_COUNT = 5
local CARD_H = 58 -- a row of the Next up list
local CARD_ROW_GAP = 4
local MODEL_W = 184
local RIGHT_X = 208 -- the Next up column
local RIGHT_W = 200
local LIST_TOP = 36
-- The tiles along the bottom: Gold, XP, Reputations, each with a live value.
local MINI_H = 44
local MINI_LABELS = { "Gold", "XP", "Reputations" }
local MINI_IDS = { "gold", "xp", "reputation" }
local CARD_GAP = 8
local MINI_BOTTOM = 12
local SIDE_PAD = 12
local HEADER_H = 52
local POPUP_ROW_PAD = 6

local DEFAULT_SLOTS = { "quests", "skills", "zones", "dungeons", "wishlist" }

local container, nameText, infoText, model
local art -- the faction emblem behind the model
local cards = {}
local miniCards = {}
local popup
local openModule -- the module whose panel is open, or nil
local popout -- the small cards' window beside the main one
local openMini -- the small card's module shown in it, or nil
local POPOUT_W = 340
local modules, moduleByID = {}, {}
local slots = {}
local used = {}

-- Theme (UI.lua loads first and exports it).
local function Theme() return PF.Theme end
local function Hex(c) return Theme().ColorHex(c) end

-- ---------- The character, read once per render ----------
local ctx = {}
local function ReadCharacter()
    ctx.level = UnitLevel("player") or 1
    local className, classToken = UnitClass("player")
    ctx.className, ctx.class = className, classToken
    ctx.faction = UnitFactionGroup("player")
    local _, _, raceID = UnitRace("player")
    ctx.race = raceID
    ctx.money = (GetMoney and GetMoney()) or 0
    ctx.guid = UnitGUID("player")
    return ctx
end

-- Saved data: PathForeverDB.journey (migration 6).
local function JourneyDB()
    if type(PathForeverDB) ~= "table" then return nil end
    local db = PathForeverDB.journey
    if type(db) ~= "table" then db = {}; PathForeverDB.journey = db end
    if type(db.trainer) ~= "table" then db.trainer = {} end
    if type(db.chars) ~= "table" then db.chars = {} end
    return db
end

local function CharDB()
    local db = JourneyDB()
    local guid = UnitGUID("player")
    if not (db and guid) then return nil end
    local c = db.chars[guid]
    if type(c) ~= "table" then c = {}; db.chars[guid] = c end
    return c
end

-- "3g 20s", in the game's coin colors; nothing for zero.
local function FormatMoney(copper)
    copper = math.floor(tonumber(copper) or 0)
    local g, s, c = math.floor(copper / 10000), math.floor(copper / 100) % 100, copper % 100
    local out = ""
    if g > 0 then out = out .. g .. "|cffffd100g|r " end
    if s > 0 or g > 0 then out = out .. s .. "|cffc7c7cfs|r " end
    if g == 0 and (c > 0 or copper < 100) then out = out .. c .. "|cffeda55fc|r" end
    return (out:gsub(" $", ""))
end
Journey.FormatMoney = FormatMoney

-- ---------- Module registry ----------
function Journey:RegisterModule(m)
    modules[#modules + 1] = m
    moduleByID[m.id] = m
end

-- Which module each card shows: its default, unless that one is complete and a
-- relevant module that isn't is waiting. Allocates nothing.
local function ResolveSlots()
    wipe(used)
    for i = 1, CARD_COUNT do
        local m = moduleByID[DEFAULT_SLOTS[i]]
        if m and m:IsComplete(ctx) then
            local best
            for _, c in ipairs(modules) do
                if not c.default and not c.mini and not used[c.id] and c:IsRelevant(ctx) and not c:IsComplete(ctx)
                    and (not best or c.priority > best.priority) then
                    best = c
                end
            end
            if best then m = best end
        end
        slots[i] = m
        if m then used[m.id] = true end
    end
    -- the small cards' modules are always there
    for _, m in ipairs(modules) do
        if m.mini then used[m.id] = true end
    end
end

-- ---------- The pop-up panel ----------
-- One pooled list: headers, rows (title, a line under it, a value on the right,
-- an optional icon) and notes. Modules fill it through panel:AddRow and friends.
local function PopupRowOnClick(self)
    if self.onClick then self.onClick(self.data) end
end
local function PopupRowOnEnter(self)
    if self.onClick then self.hl:Show() end
    if self.tooltip and GameTooltip then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if type(self.tooltip) == "table" then
            -- { spell = id }: the game's own spell tooltip (what it does)
            local ok = self.tooltip.spell and GameTooltip.SetSpellByID and pcall(GameTooltip.SetSpellByID, GameTooltip, self.tooltip.spell)
            if not ok then GameTooltip:SetText(self.title:GetText() or "", 1, 1, 1) end
        else
            GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
        end
        GameTooltip:Show()
    end
end
local function PopupRowOnLeave(self)
    self.hl:Hide()
    if self.tooltip and GameTooltip then GameTooltip:Hide() end
end

local function AcquirePopupRow(p)
    p.rowsUsed = p.rowsUsed + 1
    local row = p.rows[p.rowsUsed]
    if not row then
        row = CreateFrame("Button", nil, p.scrollChild)
        row.hl = Theme().CreateGlow(row, "LEFT", 0.20)
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(16, 16)
        row.title = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.title:SetJustifyH("LEFT")
        row.sub = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.sub:SetJustifyH("LEFT")
        row.right = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.right:SetJustifyH("RIGHT")
        row:SetScript("OnClick", PopupRowOnClick)
        row:SetScript("OnEnter", PopupRowOnEnter)
        row:SetScript("OnLeave", PopupRowOnLeave)
        p.rows[p.rowsUsed] = row
    end
    row.onClick, row.data, row.tooltip = nil, nil, nil
    row.hl:Hide()
    row:Show()
    return row
end

local function AcquirePopupText(p)
    p.textsUsed = p.textsUsed + 1
    local fs = p.texts[p.textsUsed]
    if not fs then
        fs = p.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fs:SetJustifyH("LEFT")
        p.texts[p.textsUsed] = fs
    end
    fs:Show()
    return fs
end

-- A section header in the accent color, or a muted note.
local function PanelText(p, text, isHeader)
    local fs = AcquirePopupText(p)
    fs:SetFontObject(isHeader and "GameFontNormalSmall" or "GameFontDisableSmall")
    if isHeader then
        local r, g, b = Theme().GetAccentColor()
        fs:SetTextColor(r, g, b)
    else
        local m = Theme().MUTED
        fs:SetTextColor(m[1], m[2], m[3])
    end
    fs:ClearAllPoints()
    fs:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", 4, -p.y)
    fs:SetWidth(p.contentW - 8)
    fs:SetText(isHeader and string.upper(text) or text)
    p.y = p.y + (fs:GetStringHeight() or 12) + (isHeader and 6 or 10)
end

-- Rows under a header sit on a group panel (PF.Theme.AddGroupPanel): a header
-- closes the group before it and opens its own; FillPanel closes the last one.
local function CloseGroup(p)
    local top = p.groupTop
    p.groupTop = nil
    if top and p.y > top and Theme().AddGroupPanel then
        Theme().AddGroupPanel(p.groups, p.scrollChild, 0, top, p.contentW, p.y + 2)
        p.y = p.y + 2
    end
end
local function PanelAddHeader(p, text)
    CloseGroup(p)
    if p.y > 0 then p.y = p.y + 10 end
    PanelText(p, text, true)
    p.groupTop = p.y - 2
end
local function PanelAddNote(p, text) PanelText(p, text, false) end

-- title (with an optional color), sub (a line under it), right (a short value),
-- icon (a texture path), onClick(data), a tooltip, and iconGrey (a greyed icon).
local function PanelAddRow(p, title, titleColor, sub, right, icon, onClick, data, tooltip, iconGrey, progress)
    local row = AcquirePopupRow(p)
    local w = p.contentW
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", 0, -p.y)
    row:SetWidth(w)

    local textX = 4
    if icon then
        row.icon:SetTexture(icon)
        row.icon:SetDesaturated(iconGrey and true or false)
        row.icon:ClearAllPoints()
        row.icon:SetPoint("TOPLEFT", row, "TOPLEFT", 4, -POPUP_ROW_PAD)
        row.icon:Show()
        textX = 26
    else
        row.icon:Hide()
    end
    local rightW = right and 70 or 0
    local textW = w - textX - rightW - 4

    row.title:ClearAllPoints()
    row.title:SetPoint("TOPLEFT", row, "TOPLEFT", textX, -POPUP_ROW_PAD)
    row.title:SetWidth(textW)
    row.title:SetText(title)
    local c = titleColor or Theme().TEXT
    row.title:SetTextColor(c[1], c[2], c[3])
    local h = POPUP_ROW_PAD + (row.title:GetStringHeight() or 14)

    if sub and sub ~= "" then
        row.sub:ClearAllPoints()
        row.sub:SetPoint("TOPLEFT", row, "TOPLEFT", textX, -(h + 2))
        row.sub:SetWidth(textW)
        row.sub:SetText(sub)
        row.sub:Show()
        h = h + 2 + (row.sub:GetStringHeight() or 10)
    else
        row.sub:SetText("")
        row.sub:Hide()
    end

    if right then
        row.right:ClearAllPoints()
        row.right:SetPoint("TOPLEFT", row, "TOPLEFT", w - rightW - 4, -POPUP_ROW_PAD)
        row.right:SetWidth(rightW)
        row.right:SetText(right)
        row.right:Show()
    else
        row.right:SetText("")
        row.right:Hide()
    end

    -- a thin progress bar under the text (0-1), in plain color textures
    if progress then
        if not row.barBg then
            row.barBg = row:CreateTexture(nil, "ARTWORK")
            row.barBg:SetHeight(3)
            row.barBg:SetColorTexture(1, 1, 1, 0.10)
            row.bar = row:CreateTexture(nil, "OVERLAY")
            row.bar:SetHeight(3)
        end
        local barW = w - textX - 4
        local frac = math.max(0, math.min(1, progress))
        row.barBg:ClearAllPoints()
        row.barBg:SetPoint("TOPLEFT", row, "TOPLEFT", textX, -(h + 5))
        row.barBg:SetWidth(barW)
        row.barBg:Show()
        local ar, ag, ab = Theme().GetAccentColor()
        row.bar:SetColorTexture(ar, ag, ab, 0.9)
        row.bar:ClearAllPoints()
        row.bar:SetPoint("TOPLEFT", row, "TOPLEFT", textX, -(h + 5))
        row.bar:SetWidth(math.max(1, barW * frac))
        row.bar:SetShown(frac > 0)
        h = h + 10
    elseif row.barBg then
        row.barBg:Hide()
        row.bar:Hide()
    end

    h = h + POPUP_ROW_PAD
    row:SetHeight(h)
    row.onClick, row.data, row.tooltip = onClick, data, tooltip
    row:EnableMouse(onClick ~= nil or tooltip ~= nil)
    p.y = p.y + h
    return row
end

-- A row of stat cards (up to three) across a page: { label, value, icon, tooltip } each. The
-- value is large, the icon (a texture path) sits left of it, a tooltip is a list of lines. A
-- field of Journey, not a local: this file is at Lua's limit of 200 locals.
function Journey.PanelAddCards(p, list)
    CloseGroup(p)
    if p.y > 0 then p.y = p.y + 4 end
    p.cards = p.cards or {}
    local T = Theme()
    local n = #list
    local gap = 6
    local w = math.floor((p.contentW - (n - 1) * gap) / math.max(n, 1))
    local h = 52
    local ar, ag, ab = T.GetAccentColor()
    for i, c in ipairs(list) do
        p.cardsUsed = (p.cardsUsed or 0) + 1
        local f = p.cards[p.cardsUsed]
        if not f then
            f = CreateFrame("Button", nil, p.scrollChild)
            f.bg = f:CreateTexture(nil, "BACKGROUND")
            f.bg:SetAllPoints()
            f.bg:SetColorTexture(1, 1, 1, 0.06)
            f.top = f:CreateTexture(nil, "ARTWORK")
            f.top:SetPoint("TOPLEFT", 0, 0)
            f.top:SetPoint("TOPRIGHT", 0, 0)
            f.top:SetHeight(1)
            f.icon = f:CreateTexture(nil, "ARTWORK")
            f.icon:SetSize(24, 24)
            f.label = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            f.label:SetJustifyH("LEFT")
            f.value = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            f.value:SetJustifyH("LEFT")
            f:SetScript("OnEnter", function(self)
                if not self.tooltip or not GameTooltip then return end
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                for k, line in ipairs(self.tooltip) do
                    if k == 1 then GameTooltip:SetText(line, 1, 1, 1) else GameTooltip:AddLine(line, 0.8, 0.8, 0.8) end
                end
                GameTooltip:Show()
            end)
            f:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)
            p.cards[p.cardsUsed] = f
        end
        f:ClearAllPoints()
        f:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", (i - 1) * (w + gap), -p.y)
        f:SetSize(w, h)
        f.top:SetColorTexture(ar, ag, ab, 0.5)
        f.label:ClearAllPoints()
        f.label:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -7)
        f.label:SetWidth(w - 16)
        f.label:SetTextColor(ar, ag, ab)
        f.label:SetText(c[1])
        local x = 8
        if c[3] then
            f.icon:ClearAllPoints()
            f.icon:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -21)
            f.icon:SetTexture(c[3])
            f.icon:Show()
            x = 38
        else
            f.icon:Hide()
        end
        f.value:ClearAllPoints()
        f.value:SetPoint("TOPLEFT", f, "TOPLEFT", x, -23)
        f.value:SetWidth(w - x - 6)
        f.value:SetText(c[2] or "")
        f.tooltip = c[4]
        f:EnableMouse(c[4] ~= nil)
        f:Show()
    end
    p.y = p.y + h + 10
end

local function ClosePopup()
    openModule = nil
    if popup then popup:Hide() end
end

local function CloseMini()
    openMini = nil
    if popout then popout:Hide() end
end

-- The big cards' panel lies over the character model. The small cards' (Gold, XP,
-- Discover) hold more, so theirs is a window of its own beside the main one
-- (isPopout), as tall as it, on the right like every other panel. It takes turns
-- with the quest side panel there: each one opening closes the other.
local function CreatePopup(isPopout, host)
    local T = Theme()
    local ar, ag, ab = T.GetAccentColor()
    local w = isPopout and POPOUT_W or (420 - 16)
    local parent = isPopout and Journey.mainFrame or host
    local p = CreateFrame("Frame", isPopout and "PathForeverJourneyPopout" or nil, parent, "BackdropTemplate")
    local styled = T.StyleWindow ~= nil
    if isPopout then
        PF.Popouts:Init(parent)
        PF.Popouts:Attach(1, p, w) -- popout 1, taking turns with the quest side panel
        p.onPopoutClose = function() CloseMini(); Journey:Refresh() end
    else
        -- a page of the core window: fills it, no window frame of its own
        p:SetPoint("TOPLEFT", host, "TOPLEFT", 8, -4)
        p:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", -8, 8)
    end
    if not isPopout then
        -- no frame of its own
    elseif styled then
        T.StyleWindow(p, 0.96)
    elseif p.SetBackdrop then
        p:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
        p:SetBackdropColor(0.04, 0.04, 0.05, 0.96)
        p:SetBackdropBorderColor(ar, ag, ab, 0.55)
    end
    p:EnableMouse(true)

    -- the faded gold line under the title, like every PathForever window's
    if T.AddFadedLine and isPopout then p.titleLine = { T.AddFadedLine(p, 37, 0, 0.4) } end
    p.title = p:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    p.title:SetPoint("TOPLEFT", 14, -12)
    p.title:SetWidth(w - 60)
    p.title:SetJustifyH("LEFT")
    p.title:SetTextColor(T.TEXT[1], T.TEXT[2], T.TEXT[3])
    if not isPopout then p.title:Hide() end -- the window's header names the page

    local close = CreateFrame("Button", nil, p)
    close:SetSize(22, 22)
    close:SetPoint("TOPRIGHT", -6, -6)
    if not isPopout then close:Hide() end
    close.text = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    close.text:SetPoint("CENTER")
    close.text:SetText("\195\151")
    close.text:SetTextColor(T.MUTED[1], T.MUTED[2], T.MUTED[3])
    close:SetScript("OnClick", function()
        T.PlayUISound("IG_CHARACTER_INFO_TAB")
        if isPopout then
            if PF.Popouts and PF.Popouts:ClosePanel(p) then return end -- slides shut, then onPopoutClose
            CloseMini()
        else
            ClosePopup()
        end
        Journey:Refresh()
    end)
    close:SetScript("OnEnter", function(self) self.text:SetTextColor(T.TEXT[1], T.TEXT[2], T.TEXT[3]) end)
    close:SetScript("OnLeave", function(self) self.text:SetTextColor(T.MUTED[1], T.MUTED[2], T.MUTED[3]) end)
    p.close = close

    p.scroll = CreateFrame("ScrollFrame", isPopout and "PathForeverJourneyPopoutScroll" or "PathForeverJourneyScroll",
        p, "UIPanelScrollFrameTemplate")
    if T.StyleScrollBar then T.StyleScrollBar(p.scroll) end
    p.scroll:SetPoint("TOPLEFT", 10, isPopout and -40 or -6)
    p.scroll:SetPoint("BOTTOMRIGHT", -28, 10)
    p.contentW = w - 10 - 28
    p.scrollChild = CreateFrame("Frame", nil, p.scroll)
    p.scrollChild:SetSize(p.contentW, 1)
    p.scroll:SetScrollChild(p.scrollChild)

    p.rows, p.rowsUsed = {}, 0
    p.texts, p.textsUsed = {}, 0
    p.AddRow, p.AddHeader, p.AddNote = PanelAddRow, PanelAddHeader, PanelAddNote
    p.AddCards = Journey.PanelAddCards
    p:Hide()
    return p
end

local function FillPanel(p, m)
    for i = 1, p.rowsUsed do p.rows[i]:Hide() end
    for i = 1, p.textsUsed do p.texts[i]:Hide() end
    for i = 1, (p.cardsUsed or 0) do p.cards[i]:Hide() end
    p.rowsUsed, p.textsUsed, p.cardsUsed, p.y = 0, 0, 0, 0
    p.groups = p.groups or {}
    if Theme().ResetGroupPanels then Theme().ResetGroupPanels(p.groups) end
    p.groupTop = nil
    p.title:SetText(m.label)
    m:Render(p, ctx)
    CloseGroup(p)
    p.scrollChild:SetHeight(math.max(p.y, 1))
    p:Show()
end

-- Popout 1 (PF.Popouts) is where the quest side panel opens too: that one closes.
local function PlacePopout()
    if PF.UI and PF.UI.HideSidePanel then PF.UI.HideSidePanel() end
end

local function RenderPopup()
    if openMini then
        popout = popout or CreatePopup(true)
        PlacePopout()
        FillPanel(popout, openMini)
    elseif popout then
        popout:Hide()
    end
end

-- ---------- The cards ----------
local function CardOnClick(self)
    local m = self.module
    if not m then return end
    Theme().PlayUISound("IG_CHARACTER_INFO_TAB")
    Journey:OpenModule(m.id)
end
local function CardOnEnter(self) if self.glow then self.glow:Show() end end
local function CardOnLeave(self)
    if self.glow then self.glow:Hide() end
end

local function CreateCard(i)
    local T = Theme()
    local ar, ag, ab = T.GetAccentColor()
    local w = RIGHT_W
    local c = CreateFrame("Button", nil, container)
    c:SetSize(w, CARD_H)
    c:SetPoint("TOPLEFT", container, "TOPLEFT", RIGHT_X, -(LIST_TOP + (i - 1) * (CARD_H + CARD_ROW_GAP)))
    c:SetFrameLevel(container:GetFrameLevel() + 10)
    c.bg = c:CreateTexture(nil, "BACKGROUND")
    c.bg:SetAllPoints()
    c.bg:SetColorTexture(1, 1, 1, 0)
    -- an accent glow rising from the bottom on hover
    c.glow = T.CreateGlow and T.CreateGlow(c, "BOTTOM", 0.30)
    -- a hairline under the row
    c.top = c:CreateTexture(nil, "BORDER")
    c.top:SetPoint("BOTTOMLEFT", 0, 0)
    c.top:SetPoint("BOTTOMRIGHT", 0, 0)
    c.top:SetHeight(1)
    c.top:SetColorTexture(1, 1, 1, 0.07)
    c.title = c:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    c.title:SetPoint("TOPLEFT", 10, -9)
    c.title:SetWidth(w - 36)
    c.title:SetJustifyH("LEFT")
    c.title:SetTextColor(ar, ag, ab)
    c.body = c:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    c.body:SetWidth(w - 20)
    c.body:SetJustifyH("LEFT")
    c.right = c:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    c.right:SetJustifyH("RIGHT")
    -- the game's own "!" when the module wants attention (skills waiting at the trainer)
    c.badge = c:CreateTexture(nil, "OVERLAY")
    c.badge:SetSize(14, 14)
    c.badge:SetPoint("TOPRIGHT", -6, -6)
    c.badge:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon")
    c.badge:Hide()
    c:SetScript("OnClick", CardOnClick)
    c:SetScript("OnEnter", CardOnEnter)
    c:SetScript("OnLeave", CardOnLeave)
    c.width = w
    return c
end

-- The small cards: a darker backing than the big ones, since they sit over the
-- character, and the same accent line along the top.
local function MiniOnClick(self)
    local m = moduleByID[MINI_IDS[self.index]]
    if not m then return end
    Theme().PlayUISound("IG_CHARACTER_INFO_TAB")
    if Journey.PAGE_OF[m.id] then Journey:OpenModule(m.id) return end -- Discover has a page
    if openMini == m then CloseMini() else openMini = m end
    Journey:Refresh()
end
local function MiniOnEnter(self) self.hl:Show() end
local function MiniOnLeave(self)
    local m = moduleByID[MINI_IDS[self.index]]
    self.hl:SetShown(m ~= nil and openMini == m)
end

local function CreateMiniCard(i)
    local T = Theme()
    local ar, ag, ab = T.GetAccentColor()
    local w = math.floor((420 - 2 * SIDE_PAD - 2 * CARD_GAP) / 3)
    local c = CreateFrame("Button", nil, container)
    c:SetSize(w, MINI_H)
    c:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", SIDE_PAD + (i - 1) * (w + CARD_GAP), MINI_BOTTOM)
    c:SetFrameLevel(container:GetFrameLevel() + 10)
    c.bg = c:CreateTexture(nil, "BACKGROUND")
    c.bg:SetAllPoints()
    -- the icon's navy, a little see-through over the character
    local nf = T.NAVY_FILL or { 0.06, 0.06, 0.07 }
    c.bg:SetColorTexture(1, 1, 1, 0)
    -- the same glow as the rows, on hover and while its window is open
    if T.CreateGlow then
        c.hl = T.CreateGlow(c, "BOTTOM", 0.35, "BORDER")
    else
        c.hl = c:CreateTexture(nil, "BORDER")
        c.hl:SetAllPoints()
        c.hl:SetColorTexture(1, 1, 1, 0.08)
        c.hl:Hide()
    end
    c.top = c:CreateTexture(nil, "ARTWORK")
    c.top:SetPoint("TOPLEFT", 0, 0)
    c.top:SetPoint("TOPRIGHT", 0, 0)
    c.top:SetHeight(1)
    c.top:SetColorTexture(1, 1, 1, 0.12)
    c.title = c:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    c.title:SetWidth(w - 16)
    c.title:SetJustifyH("LEFT")
    c.title:SetTextColor(ar, ag, ab)
    c.title:SetText(MINI_LABELS[i])
    c.title:SetPoint("TOPLEFT", c, "TOPLEFT", 8, -7)
    -- the live value under the name (Summary of the tile's module)
    c.value = c:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    c.value:SetWidth(w - 16)
    c.value:SetJustifyH("LEFT")
    c.value:SetPoint("TOPLEFT", c, "TOPLEFT", 8, -22)
    c.index = i
    c:SetScript("OnClick", MiniOnClick)
    c:SetScript("OnEnter", MiniOnEnter)
    c:SetScript("OnLeave", MiniOnLeave)
    return c
end

local function LayoutCard(c, m)
    c.module = m
    if not m then c:Hide() return end
    c.title:SetText(m.label)
    local titleH = c.title:GetStringHeight() or 14
    c.body:ClearAllPoints()
    c.body:SetPoint("TOPLEFT", c, "TOPLEFT", 10, -(9 + titleH + 3))
    c.body:SetText(m:Summary(ctx) or "")
    c.right:ClearAllPoints()
    c.right:SetPoint("TOPRIGHT", c, "TOPRIGHT", -10, -(9 + titleH + 3))
    c.right:SetText(m.SummaryRight and m:SummaryRight(ctx) or "")
    c.badge:SetShown(m.WantsAttention and m:WantsAttention(ctx) or false)
    c.bg:SetColorTexture(1, 1, 1, 0)
    if c.glow then c.glow:Hide() end
    c:Show()
end

-- ---------- Turning the character ----------
-- Dragging the model with the left button turns it; the right button faces it forward again.
-- The cursor is read while the button is down (the mouse can leave the model mid-drag).
local SPIN_PER_PIXEL = 0.012
function Journey.SetupSpin(m)
    m.facing = 0
    m:EnableMouse(true)
    m:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" then
            self.facing = 0
            pcall(self.SetFacing, self, 0)
        elseif button == "LeftButton" and GetCursorPosition then
            self.spinX, self.spinFrom = GetCursorPosition(), self.facing
        end
    end)
    m:SetScript("OnMouseUp", function(self) self.spinX = nil end)
    m:SetScript("OnHide", function(self) self.spinX = nil end)
    m:SetScript("OnUpdate", function(self)
        if not self.spinX then return end
        if not (IsMouseButtonDown and IsMouseButtonDown("LeftButton")) then self.spinX = nil return end
        self.facing = self.spinFrom + (GetCursorPosition() - self.spinX) * SPIN_PER_PIXEL
        pcall(self.SetFacing, self, self.facing)
    end)
end
function Journey:GetFacing() return model and model.facing end

-- ---------- The tab ----------
local function CreateContainer(parent)
    local T = Theme()
    container = CreateFrame("Frame", "PathForeverJourney", parent)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -47)
    container:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0)

    -- Behind the character: the faction emblem centred over the character's head
    -- (2026-10-30: it floated in the corner), under the model. (A class or spec background was tried on 2026-10-04 and dropped: the
    -- class icon is only 128 px, and Forever's client has no talent readout to pick
    -- spec art with - see the git history.)
    art = CreateFrame("Frame", "PathForeverJourneyArt", container)
    art:SetPoint("TOPLEFT", container, "TOPLEFT", 1, 0)
    art:SetPoint("BOTTOMRIGHT", container, "BOTTOMLEFT", SIDE_PAD + MODEL_W, MINI_BOTTOM + MINI_H + CARD_GAP)
    art:SetFrameLevel(container:GetFrameLevel())
    if art.SetClipsChildren then art:SetClipsChildren(true) end
    art.faction = art:CreateTexture(nil, "ARTWORK")
    -- to the right of the name and level, level with them (tried above the head, as a watermark and
    -- under the feet on 2026-10-31; those crowded the character)
    art.faction:SetPoint("TOPRIGHT", art, "TOPLEFT", SIDE_PAD + MODEL_W, -6)
    art.faction:SetSize(76, 76)
    art.faction:SetAlpha(0.9)

    -- The character, filling the space between the name and the cards. A model
    -- frame is a plain widget: safe to show and update at any time.
    model = CreateFrame("PlayerModel", "PathForeverJourneyModel", container)
    model:SetPoint("TOPLEFT", container, "TOPLEFT", SIDE_PAD, -30)
    model:SetPoint("BOTTOMRIGHT", container, "BOTTOMLEFT", SIDE_PAD + MODEL_W, MINI_BOTTOM + MINI_H + CARD_GAP)
    model:SetFrameLevel(container:GetFrameLevel() + 1)
    Journey.SetupSpin(model)

    nameText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    nameText:SetPoint("TOPLEFT", container, "TOPLEFT", 16, -12)
    nameText:SetWidth(MODEL_W)
    nameText:SetJustifyH("LEFT")
    nameText:SetTextColor(T.TEXT[1], T.TEXT[2], T.TEXT[3])
    infoText = container:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    infoText:SetWidth(MODEL_W)
    infoText:SetJustifyH("LEFT")
    -- the texts sit above the model
    local overlay = CreateFrame("Frame", nil, container)
    overlay:SetAllPoints(container)
    overlay:SetFrameLevel(container:GetFrameLevel() + 5)
    nameText:SetParent(overlay)
    infoText:SetParent(overlay)

    local nextUp = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    nextUp:SetPoint("TOPLEFT", container, "TOPLEFT", RIGHT_X + 2, -14)
    nextUp:SetText("NEXT UP")
    nextUp:SetTextColor(0.42, 0.46, 0.52)
    for i = 1, CARD_COUNT do cards[i] = CreateCard(i) end
    for i = 1, #MINI_LABELS do miniCards[i] = CreateMiniCard(i) end
    Journey:CreateCampButton(container)
    container:Hide()
end

-- The faction emblem: the first atlas of the list that this client has (checked
-- with C_Texture.GetAtlasInfo), else a plain file.
local FACTION_ART = {
    Alliance = { atlases = { "AllianceEmblem", "Faction-Alliance" }, file = "Interface\\Timer\\Alliance-Logo" },
    Horde = { atlases = { "HordeEmblem", "Faction-Horde" }, file = "Interface\\Timer\\Horde-Logo" },
}

local function HasAtlas(name)
    if not (C_Texture and C_Texture.GetAtlasInfo) then return false end
    local ok, info = pcall(C_Texture.GetAtlasInfo, name)
    return ok and info ~= nil
end

local function SetArt(tex, atlases, fmtArg, file, coords)
    for _, a in ipairs(atlases) do
        local name = fmtArg and string.format(a, fmtArg) or a
        if HasAtlas(name) then
            tex:SetTexCoord(0, 1, 0, 1)
            -- smooth scaling where the client takes a filter mode, else its default
            if not pcall(tex.SetAtlas, tex, name, false, "TRILINEAR") then tex:SetAtlas(name) end
            tex.source = name
            return
        end
    end
    tex:SetTexture(file)
    if coords then tex:SetTexCoord(coords[1], coords[2], coords[3], coords[4]) else tex:SetTexCoord(0, 1, 0, 1) end
    tex.source = file
end

local artFaction
local function UpdateArt(c)
    if c.faction ~= artFaction then
        artFaction = c.faction
        local f = FACTION_ART[c.faction or ""]
        if f then
            SetArt(art.faction, f.atlases, nil, f.file)
            art.faction:Show()
        else
            art.faction:Hide()
        end
    end
end

local modelDirty = true
function Journey:MarkModelDirty() modelDirty = true end

function Journey:Render(parent)
    Journey.mainFrame = parent
    if not container then CreateContainer(parent) end
    if self.pageHost then self.pageHost:Hide() end
    ReadCharacter()
    -- Opening the tab, the model would replay whatever the character was doing (a
    -- swing, a run, flying) for a moment: it's set again and put straight into its
    -- standing pose below, before it's drawn. (Hiding it for a moment instead was
    -- tried on 2026-10-05 and looked worse.)
    if not container:IsVisible() then modelDirty = true end
    container:Show()

    nameText:SetText(PF:GetPlayerFullName() or UnitName("player") or "")
    local nameH = nameText:GetStringHeight() or 16
    infoText:ClearAllPoints()
    infoText:SetPoint("TOPLEFT", container, "TOPLEFT", 16, -(12 + nameH + 2))
    local classColor = Theme().ClassColorHex(ctx.class) or Hex(Theme().TEXT)
    infoText:SetText(string.format("Lv %d %s%s|r", ctx.level, classColor, ctx.className or ""))

    UpdateArt(ctx)
    if modelDirty and model.SetUnit then
        modelDirty = false
        pcall(model.SetUnit, model, "player")
        if model.SetAnimation then pcall(model.SetAnimation, model, 0) end -- standing
        model.facing = 0
    end

    ResolveSlots()
    ClosePopup()
    for i = 1, CARD_COUNT do LayoutCard(cards[i], slots[i]) end
    for i, mc in ipairs(miniCards) do
        local m = moduleByID[MINI_IDS[i]]
        mc.hl:SetShown(m ~= nil and openMini == m)
        mc.value:SetText(m and m:Summary(ctx) or "")
    end
    RenderPopup()
end

-- The campfire button: a small icon above the cards' left end, there only while a campfire is
-- in range (PathForever Camping tells us). It opens or closes the camping window, which also
-- works with the window's option off. The icon is the Campfire Nearby spell's own.
function Journey:CreateCampButton(parent)
    local T = Theme()
    local ar, ag, ab = T.GetAccentColor()
    local b = CreateFrame("Button", "PathForeverJourneyCampfire", parent)
    b:SetSize(26, 26)
    b:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", SIDE_PAD, MINI_BOTTOM + MINI_H + CARD_GAP)
    b:SetFrameLevel(parent:GetFrameLevel() + 10)
    b.bg = b:CreateTexture(nil, "BACKGROUND")
    b.bg:SetAllPoints()
    local nf = T.NAVY_FILL or { 0.06, 0.06, 0.07 }
    b.bg:SetColorTexture(nf[1], nf[2], nf[3], 0.85)
    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:SetSize(20, 20)
    b.icon:SetPoint("CENTER")
    b.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    local texture
    if C_Spell and C_Spell.GetSpellTexture then
        for _, id in ipairs({ 1283391, 818 }) do -- Campfire Nearby, Basic Campfire
            local ok, t = pcall(C_Spell.GetSpellTexture, id)
            if ok and t then texture = t break end
        end
    end
    b.icon:SetTexture(texture or "Interface\\Icons\\Spell_Fire_Fire")
    b.top = b:CreateTexture(nil, "OVERLAY")
    b.top:SetPoint("TOPLEFT", 0, 0)
    b.top:SetPoint("TOPRIGHT", 0, 0)
    b.top:SetHeight(1)
    b.top:SetColorTexture(ar, ag, ab, 0.6)
    if T.CreateGlow then b.hl = T.CreateGlow(b, "BOTTOM", 0.35, "BORDER") end
    b:SetScript("OnClick", function()
        T.PlayUISound("IG_CHARACTER_INFO_TAB")
        if PF.Camping then PF.Camping:Toggle() end
    end)
    b:SetScript("OnEnter", function(self)
        if self.hl then self.hl:Show() end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine("Campfire nearby", ar, ag, ab)
        GameTooltip:AddLine("Open the camping window", T.MUTED[1], T.MUTED[2], T.MUTED[3])
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", function(self)
        if self.hl then self.hl:Hide() end
        GameTooltip:Hide()
    end)
    b:Hide()
    self.campButton = b
end

function Journey:UpdateCampButton()
    local b = self.campButton
    if not b then return end
    b:SetShown((PF.Camping and PF.Camping.InRange and PF.Camping:InRange()) and true or false)
end

function Journey:Hide()
    if container then container:Hide() end
    ClosePopup()
    if self.pageHost then self.pageHost:Hide() end
    CloseMini()
end

-- The big cards' modules are pages of the core window (sidebar entries): the tab name for
-- each, and the module a tab shows.
Journey.PAGE_OF = { skills = "Skills", quests = "ClassQuests", zones = "Zones", dungeons = "Dungeons", wishlist = "Wishlist", discover = "Discover", gold = "Gold", xp = "XP" }
Journey.PAGES = { Skills = "skills", ClassQuests = "quests", Zones = "zones", Discover = "discover", Gold = "gold", XP = "xp" }

-- Draws module `id` as the whole content of the core window.
function Journey:RenderPage(parent, id)
    local m = moduleByID[id]
    if not m then return end
    ReadCharacter()
    Journey.mainFrame = parent
    if container then container:Hide() end
    if id ~= "discover" then CloseMini() end -- Gold and XP open their window beside Discover
    if not self.pageHost then
        local host = CreateFrame("Frame", "PathForeverJourneyPage", parent)
        host:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -47)
        host:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0)
        self.pageHost = host
    end
    self.pageHost:Show()
    popup = popup or CreatePopup(false, self.pageHost)
    openModule = m
    FillPanel(popup, m)
    if id == "discover" then RenderPopup() end
    -- the cards keep their summaries current for when the Journey is shown again
    if container then
        ResolveSlots()
        for i = 1, CARD_COUNT do LayoutCard(cards[i], slots[i]) end
    end
end

function Journey:Refresh()
    if self.pageHost and self.pageHost:IsShown() and openModule then
        self:RenderPage(self.pageHost:GetParent(), openModule.id)
    elseif container and container:IsShown() and container:GetParent() then
        self:Render(container:GetParent())
    end
end

function Journey:ClosePanel() ClosePopup(); CloseMini() end
function Journey:GetOpenModuleID() return openModule and openModule.id end
function Journey:GetOpenMiniID() return openMini and openMini.id end
-- The quest side panel opening on the right closes the small cards' window. Returns
-- the closed module's id, for the side panel's Back button.
function Journey:CloseMiniPanel()
    if not openMini then return nil end
    local id = openMini.id
    CloseMini()
    for _, mc in ipairs(miniCards) do mc.hl:Hide() end
    return id
end
function Journey:OpenModule(id)
    local m = moduleByID[id]
    if not m then return end
    if PF.OpenTab and Journey.PAGE_OF[id] then
        PF:OpenTab(Journey.PAGE_OF[id])
    elseif m.mini then
        openMini = m
        self:Refresh()
    end
end
-- for tests and /pf: which module each card shows
function Journey:GetSlotIDs()
    local a, b, c = slots[1], slots[2], slots[3]
    return a and a.id, b and b.id, c and c.id
end
function Journey:GetCard(i) return cards[i] end
function Journey:GetMiniCard(i) return miniCards[i] end
function Journey:GetPopup() return popup end
function Journey:GetPopout() return popout end
function Journey:GetContext() return ReadCharacter() end

-- =====================================================================
-- Skills: every class ability the trainer teaches, by level.
-- =====================================================================
-- A spell is learned when the game says the character knows it. A higher rank
-- implies the lower ones. A rank above 1 is only shown when the rank before it is
-- learned or trainable: that keeps talent abilities (whose rank 1 is the talent)
-- and other races' racial abilities out until the character has rank 1. Where the
-- trainer doesn't teach rank 1 (a class's starting spells: Heroic Strike, Smite;
-- talents; racials), the game is asked whether the character knows the spell by name.
local skillState = {} -- index in ClassSkills[class] -> "learned" / "available" / "locked" (nil = not for this character)
local maxKnown, chainTo = {}, {}
local firstRank = {} -- class -> { [name] = lowest rank the trainer teaches }
local skillSummary = { available = 0, cost = 0, nextLevel = nil, behind = false, locked = 0, learned = 0 }

local function Knows(spellID)
    if IsPlayerSpell then
        local ok, known = pcall(IsPlayerSpell, spellID)
        if ok and known then return true end
    end
    if IsSpellKnown then
        local ok, known = pcall(IsSpellKnown, spellID)
        if ok and known then return true end
    end
    return false
end

-- Whether the character knows any rank of a spell, asked by name (the game looks
-- it up in the spellbook). nil when the client can't say.
local function KnowsByName(name)
    local getInfo = (C_Spell and C_Spell.GetSpellInfo) or GetSpellInfo
    if not getInfo then return nil end
    local ok, info = pcall(getInfo, name)
    if not ok then return nil end
    return info ~= nil
end

local function FirstRanks(class, list)
    local t = firstRank[class]
    if t then return t end
    t = {}
    for _, s in ipairs(list) do
        if not t[s[2]] or s[3] < t[s[2]] then t[s[2]] = s[3] end
    end
    firstRank[class] = t
    return t
end

-- The trainer's own price for this character, when one was seen (it includes
-- reputation discounts), else Wowhead's.
local function SkillCost(class, s)
    local db = JourneyDB()
    local cache = db and db.trainer[class]
    local seen = cache and cache[s[2] .. "|" .. s[3]]
    return seen or s[5]
end

local function ComputeSkills(c)
    local list = Data.ClassSkills and Data.ClassSkills[c.class]
    local sum = skillSummary
    sum.available, sum.cost, sum.nextLevel, sum.behind, sum.locked, sum.learned = 0, 0, nil, false, 0, 0
    wipe(skillState)
    if not list then return list end
    wipe(maxKnown)
    wipe(chainTo)
    for _, s in ipairs(list) do
        if Knows(s[1]) and (maxKnown[s[2]] or -1) < s[3] then maxKnown[s[2]] = s[3] end
    end
    -- spells whose rank 1 the trainer doesn't teach: known by name means the rank
    -- before the trainer's first one is known (a client that can't say shows them)
    for name, first in pairs(FirstRanks(c.class, list)) do
        if first > 1 and not maxKnown[name] then
            local known = KnowsByName(name)
            if known ~= false then maxKnown[name] = first - 1 end
        end
    end
    for i, s in ipairs(list) do
        local name, rank, level = s[2], s[3], s[4]
        local st
        if s[6] and s[6] ~= c.faction then
            st = nil
        elseif rank <= (maxKnown[name] or -1) then
            st = "learned"
        elseif rank <= 1 or (chainTo[name] or maxKnown[name] or -1) >= rank - 1 then
            st = (level <= c.level) and "available" or "locked"
            chainTo[name] = rank
        end
        skillState[i] = st
        if st == "available" then
            sum.available = sum.available + 1
            sum.cost = sum.cost + SkillCost(c.class, s)
            if level <= c.level - 3 then sum.behind = true end
        elseif st == "locked" then
            sum.locked = sum.locked + 1
            if not sum.nextLevel or level < sum.nextLevel then sum.nextLevel = level end
        elseif st == "learned" then
            sum.learned = sum.learned + 1
        end
    end
    return list
end

local function SkillName(s)
    return s[3] > 0 and string.format("%s (Rank %d)", s[2], s[3]) or s[2]
end

local Skills = { id = "skills", label = "Skills", priority = 100, default = true }
-- The spell's own icon, from the client (asked once per spell); nil when it has none
Skills.icons = {}
function Skills:IconOf(s)
    local id = s[1]
    local icon = self.icons[id]
    if icon == nil then
        icon = false
        local get = (C_Spell and C_Spell.GetSpellTexture) or GetSpellTexture
        if get and id then
            local ok, tex = pcall(get, id)
            if ok and tex then icon = tex end
            if not icon and s[2] then -- a rank the client lacks: the spell by name
                ok, tex = pcall(get, s[2])
                if ok and tex then icon = tex end
            end
        end
        -- still none: a plain placeholder, so the rows stay lined up
        self.icons[id] = icon or "Interface\\Icons\\INV_Misc_QuestionMark"
        icon = self.icons[id]
    end
    return icon
end
-- one tooltip table per spell, so a redraw makes no garbage
Skills.tips = {}
function Skills:TipOf(s)
    local t = self.tips[s[1]]
    if not t then t = { spell = s[1] }; self.tips[s[1]] = t end
    return t
end
function Skills:IsRelevant(c) return Data.ClassSkills and Data.ClassSkills[c.class] ~= nil end
function Skills:IsComplete(c)
    ComputeSkills(c)
    return skillSummary.available == 0 and skillSummary.locked == 0 and skillSummary.learned > 0
end
function Skills:WantsAttention(c)
    ComputeSkills(c)
    return skillSummary.behind
end
-- the cost, drawn at the card's right edge on the summary's line
function Skills:SummaryRight(c)
    ComputeSkills(c)
    return skillSummary.available > 0 and FormatMoney(skillSummary.cost) or nil
end
function Skills:Summary(c)
    ComputeSkills(c)
    local sum = skillSummary
    if sum.available > 0 then
        return string.format("%d %s to train", sum.available, sum.available == 1 and "skill" or "skills")
    elseif sum.nextLevel then
        return "Next skill at Lv " .. sum.nextLevel
    end
    return "All skills learned"
end

-- Shows learned skills too, once asked (per session).
local showLearned = false
local function ToggleLearned()
    showLearned = not showLearned
    Journey:Refresh()
end

function Skills:Render(p, c)
    local list = ComputeSkills(c)
    local T = Theme()
    if not list then
        p:AddNote("No skills on file for this class.")
        return
    end
    local sum = skillSummary
    if sum.available > 0 then
        local note = string.format("%d to train, %s in all.", sum.available, FormatMoney(sum.cost))
        if c.money < sum.cost then note = note .. " You have " .. FormatMoney(c.money) .. "." end
        p:AddNote(note)
        p:AddHeader("Available now")
        for i, s in ipairs(list) do
            if skillState[i] == "available" then
                p:AddRow(SkillName(s), T.GOOD, "Lv " .. s[4] .. (s[3] > 1 and "  -  rank upgrade" or "  -  new ability"), FormatMoney(SkillCost(c.class, s)), self:IconOf(s), nil, nil, self:TipOf(s))
            end
        end
    end
    if sum.locked > 0 then
        p:AddHeader("Coming up")
        local first = true
        for i, s in ipairs(list) do
            if skillState[i] == "locked" then
                local color = (first or s[4] == sum.nextLevel) and T.TEXT or T.MUTED
                p:AddRow(SkillName(s), color, "Lv " .. s[4] .. (s[3] > 1 and "  -  rank upgrade" or "  -  new ability"), FormatMoney(SkillCost(c.class, s)), self:IconOf(s), nil, nil, self:TipOf(s), color == T.MUTED)
                first = false
            end
        end
    end
    if sum.learned > 0 then
        p:AddHeader(showLearned and "Learned" or ("Learned (" .. sum.learned .. ")"))
        if showLearned then
            for i, s in ipairs(list) do
                if skillState[i] == "learned" then
                    p:AddRow(SkillName(s), T.MUTED, "Lv " .. s[4], nil, self:IconOf(s) or "Interface\\RaidFrame\\ReadyCheck-Ready", nil, nil, self:TipOf(s), true)
                end
            end
        end
        p:AddRow(showLearned and "Hide learned skills" or "Show learned skills", T.MUTED, nil, nil, nil, ToggleLearned, nil)
    end
end

Journey:RegisterModule(Skills)

-- What a profession trainer charges for each rank (Apprentice, Journeyman, ...), read when one
-- opens. The rank is the service's first word ("Journeyman Blacksmith"); the price is kept per
-- rank, not per profession, as Classic charges the same for all. Nothing is guessed: a rank
-- not seen at a trainer yet has no price.
function Journey:ReadRankPrices()
    local db = JourneyDB()
    if not db then return end
    local okN, n = pcall(GetNumTrainerServices)
    if not okN or type(n) ~= "number" then return end
    local known = {}
    for _, r in ipairs(PathForeverData.ProfessionRanks or {}) do known[r.name] = true end
    for i = 1, n do
        local ok, name = pcall(GetTrainerServiceInfo, i)
        local okC, cost = pcall(GetTrainerServiceCost, i)
        local rank = ok and type(name) == "string" and name:match("^(%a+)")
        if rank and known[rank] and okC and type(cost) == "number" and cost > 0 then
            if type(db.rankCosts) ~= "table" then db.rankCosts = {} end
            db.rankCosts[rank] = cost
        end
    end
end

-- The trainer price seen for a rank, or nil.
function Journey:RankCost(rank)
    local db = JourneyDB()
    local c = db and type(db.rankCosts) == "table" and db.rankCosts[rank]
    return type(c) == "number" and c or nil
end

-- Real prices, read from the trainer window whenever a class trainer opens.
-- Classic-style trainer API, wrapped: a client without it just keeps Wowhead's.
function Journey:ReadTrainer()
    if not (GetNumTrainerServices and GetTrainerServiceInfo and GetTrainerServiceCost) then return end
    if IsTradeskillTrainer then
        local ok, isTrade = pcall(IsTradeskillTrainer)
        if ok and isTrade then
            self:ReadRankPrices()
            return
        end
    end
    local db = JourneyDB()
    local _, classToken = UnitClass("player")
    if not (db and classToken) then return end
    local okN, n = pcall(GetNumTrainerServices)
    if not okN or type(n) ~= "number" then return end
    local cache = db.trainer[classToken]
    if type(cache) ~= "table" then cache = {}; db.trainer[classToken] = cache end
    for i = 1, n do
        local ok, name, rankText = pcall(GetTrainerServiceInfo, i)
        local okC, cost = pcall(GetTrainerServiceCost, i)
        if ok and okC and type(name) == "string" and type(cost) == "number" then
            local rank = tonumber(type(rankText) == "string" and rankText:match("(%d+)") or "") or 0
            cache[name .. "|" .. rank] = cost
        end
    end
end

-- =====================================================================
-- Quests: the class's own quests (Forever added many).
-- =====================================================================
-- Each quest's details (who starts and ends it, where, its XP, its races) are in
-- ClassQuestDetails; the order the game gives them in, and what each needs first,
-- in ClassQuestLines (see BuildLines).
local classLines = {}   -- class -> list of lines
local versionGroups = {} -- "class|version" -> the lines that are versions of one quest
local nameByID = {}     -- class -> questID -> name
local classDungeon = {} -- class -> the "dungeon" the side panel shows them under
local detailCaches = {} -- "faction|race" -> questID -> the details as quest fields

-- The capitals' factions, and each race's home capital, for quests several
-- trainers give (one per capital): only the character's own faction's are shown,
-- its race's home first (that one's zone and map pin are the quest's).
local CITY_FACTION = {
    ["Stormwind City"] = "Alliance", ["Ironforge"] = "Alliance", ["Darnassus"] = "Alliance",
    ["Orgrimmar"] = "Horde", ["Thunder Bluff"] = "Horde", ["Undercity"] = "Horde",
}
local HOME_CITY = {
    [1] = "Stormwind City", [3] = "Ironforge", [4] = "Darnassus", [7] = "Ironforge",
    [2] = "Orgrimmar", [5] = "Undercity", [6] = "Thunder Bluff", [8] = "Orgrimmar",
}
local HOME_ZONE = {
    [1] = "Elwynn Forest", [3] = "Dun Morogh", [4] = "Teldrassil", [7] = "Dun Morogh",
    [2] = "Durotar", [5] = "Tirisfal Glades", [6] = "Mulgore", [8] = "Durotar",
}

-- The starters this character would go to, best first: the faction's own (by
-- their zone, when it's a capital), the race's home capital first.
local function StartersFor(list, faction, race)
    local mine = {}
    for _, st in ipairs(list) do
        local f = st[2] and CITY_FACTION[st[2]]
        if not f or not faction or f == faction then mine[#mine + 1] = st end
    end
    if #mine == 0 then mine = list end
    local home = race and HOME_CITY[race]
    if home then
        for i, st in ipairs(mine) do
            if st[2] == home and i > 1 then
                table.remove(mine, i)
                table.insert(mine, 1, st)
                break
            end
        end
    end
    return mine
end

local function Details(id)
    local _, _, race = UnitRace("player")
    local faction = UnitFactionGroup("player")
    local key = tostring(faction) .. "|" .. tostring(race)
    local detailCache = detailCaches[key]
    if not detailCache then detailCache = {}; detailCaches[key] = detailCache end
    local cached = detailCache[id]
    if cached ~= nil then return cached or nil end
    local d = Data.ClassQuestDetails and Data.ClassQuestDetails[id]
    if not d then detailCache[id] = false return nil end
    local out = { xp = d.xp, races = d.races }
    if d.item then
        out.pickup = "Item start: " .. d.item
    elseif d.s and d.s[1] then
        -- one starter: "Name, Zone"; several: "Name (Zone), Name (Zone) or Name (Zone)"
        local starters = StartersFor(d.s, faction, race)
        local first = starters[1]
        if #starters == 1 then
            out.pickup = first[1] .. (first[2] and (", " .. first[2]) or "")
        else
            local parts = {}
            for i, st in ipairs(starters) do
                parts[i] = st[1] .. (st[2] and (" (" .. st[2] .. ")") or "")
            end
            out.pickup = table.concat(parts, ", ", 1, #parts - 1) .. " or " .. parts[#parts]
        end
        out.pickupZone = first[2]
        out.x, out.y = first[3] and first[3] / 100, first[4] and first[4] / 100
    end
    if d.e then
        out.turnin = d.e[1] .. (d.e[2] and (", " .. d.e[2]) or "")
        out.turninZone = d.e[2]
    end
    detailCache[id] = out
    return out
end

-- The Skyborne are one race in two factions: High Order (95, Alliance) and Windshaper
-- (96, Horde), both starting on Zephras Isle. Wowhead lists only 95 on Zephras Isle's
-- quests, which hid the Windshaper hunter's pet quests (in game 2026-10-05), so either
-- ID allows both; the quest's own faction still keeps the other side's quests out.
local SKYBORNE = { [95] = true, [96] = true }
local function RaceAllows(races, race)
    if not (races and race) then return true end
    for _, r in ipairs(races) do
        if r == race or (SKYBORNE[r] and SKYBORNE[race]) then return true end
    end
    return false
end

local function Done(id) return C_QuestLog.IsQuestFlaggedCompleted(id) end

-- One quest's own table for the side panel (built once per quest ID), with its
-- details applied. The map ID is looked up again until the game can answer (it
-- can't on a loading screen).
local stepQuests = {} -- "faction|race|questID" -> the quest's table
local function StepQuest(e, class)
    local id = e[1]
    local _, _, race = UnitRace("player")
    local key = tostring(UnitFactionGroup("player")) .. "|" .. tostring(race) .. "|" .. id
    local q = stepQuests[key]
    if not q then
        local d = Details(id)
        q = { name = e[2], id = id, faction = e[5], level = e[3], requires = e[4], class = class }
        if d then
            q.pickup, q.pickupZone, q.turnin, q.turninZone = d.pickup, d.pickupZone, d.turnin, d.turninZone
            q.xp = d.xp
            q.mapX, q.mapY = d.x, d.y
        end
        stepQuests[key] = q
    end
    if not q.mapID and q.pickupZone and q.mapX then
        q.mapID = PF:GetZoneMapID(q.pickupZone)
        if q.mapID then q.x, q.y = q.mapX, q.mapY end
    end
    return q
end

-- A class's quests as lines (ClassQuestLines, JourneyData.lua). A line's steps come
-- in the order the game gives them, each one needing the step before; a step can be
-- a set of copies (one per race or starting zone), any one of which counts. A line
-- can need other quests done first (after: every one of them; afterAny: one) and can
-- be only some races' (races). An extra line (a quest that replaces a lost quest item)
-- shows only while it's in the log. Each line is one row, named after the step it's at.
-- A quest on no line is a line of its own (the smoke test keeps that from happening).
local function BuildLines(class)
    if classLines[class] then return classLines[class] end
    local list = Data.ClassQuests and Data.ClassQuests[class] or {}
    local byID, lootGroups = {}, {}
    for _, e in ipairs(list) do
        byID[e[1]] = e
        if e[6] then
            local items = {}
            for _, itemID in ipairs(e[6]) do
                local info = Data.ClassQuestItems and Data.ClassQuestItems[itemID] or {}
                items[#items + 1] = { name = info[1], slot = info[2], id = itemID }
            end
            lootGroups[#lootGroups + 1] = { title = e[2], kind = "quest", faction = e[5], items = items }
        end
    end
    local lines, placed, lineOf = {}, {}, {}
    for _, src in ipairs(Data.ClassQuestLines and Data.ClassQuestLines[class] or {}) do
        local line = { steps = {}, races = src.races, after = src.after, afterAny = src.afterAny, extra = src.extra }
        if src.version then
            local key = class .. "|" .. src.version
            local g = versionGroups[key]
            if not g then g = {}; versionGroups[key] = g end
            g[#g + 1] = line
            line.group = g
        end
        for _, step in ipairs(src) do
            local copies = {}
            for _, id in ipairs(type(step) == "table" and step or { step }) do
                if byID[id] then
                    copies[#copies + 1] = byID[id]
                    placed[id], lineOf[id] = true, line
                end
            end
            if #copies > 0 then line.steps[#line.steps + 1] = copies end
        end
        -- Steps in a row with the same name are one quest in parts (pick up at the Dead
        -- Drop, then hand it back; an Undead paladin's seven "A Lesson in Divinity"):
        -- shown and counted as one step. part[i] is step i's number among those.
        line.part, line.parts = {}, 0
        local prevName
        for i, copies in ipairs(line.steps) do
            local name = copies[1][2]
            if name ~= prevName then line.parts = line.parts + 1 end
            line.part[i], prevName = line.parts, name
        end
        if #line.steps > 0 then lines[#lines + 1] = line end
    end
    for _, e in ipairs(list) do
        if not placed[e[1]] then
            local line = { steps = { { e } }, part = { 1 }, parts = 1 }
            lineOf[e[1]] = line
            lines[#lines + 1] = line
        end
    end
    -- each line's first quest overall: back through `after` to a line that needs nothing
    for _, line in ipairs(lines) do
        local root, seen = line, {}
        while not seen[root] do
            seen[root] = true
            local before = root.after or (root.afterAny and root.afterAny[1])
            if type(before) == "table" then before = before[1] end
            local prev = before and lineOf[before]
            if not prev then break end
            root = prev
        end
        line.root = root
        -- and the lines that follow it (their `after` is one of its quests)
        local before = line.after or (line.afterAny and line.afterAny[1])
        if type(before) == "table" then before = before[1] end
        local prev = before and lineOf[before]
        if prev and prev ~= line then
            prev.children = prev.children or {}
            prev.children[#prev.children + 1] = line
        end
    end
    classLines[class] = lines
    nameByID[class] = {}
    for _, e in ipairs(list) do nameByID[class][e[1]] = e[2] end
    classDungeon[class] = { name = "Class quests", levelMin = 1, levelMax = 60, quests = {}, lootGroups = lootGroups }
    return lines
end

-- The copy of a step for this character: its faction's and race's (Wowhead's race
-- list for that copy, unless the line has its own), the one given in its race's home
-- city or starting zone when several are (each trainer has a copy that sends you
-- home), or nil when none is.
local function StartsIn(d, zone)
    if not (zone and d and d.s) then return false end
    for _, st in ipairs(d.s) do if st[2] == zone then return true end end
    return false
end
local function StepCopy(copies, c, line)
    local first, inZone
    for _, e in ipairs(copies) do
        local d = Data.ClassQuestDetails and Data.ClassQuestDetails[e[1]]
        if (not e[5] or e[5] == c.faction) and (line.races or RaceAllows(d and d.races, c.race)) then
            if StartsIn(d, HOME_CITY[c.race or 0]) then return e end
            if StartsIn(d, HOME_ZONE[c.race or 0]) then inZone = inZone or e end
            first = first or e
        end
    end
    return inZone or first
end
local function StepDone(copies)
    for _, e in ipairs(copies) do if Done(e[1]) then return e end end
end
local function StepInLog(copies)
    for _, e in ipairs(copies) do if PF:IsQuestInLog(e[1]) then return e end end
end

-- Whether the quests a line needs first are done; if not, the one to name.
local function AfterMet(line)
    local after = line.after
    if type(after) == "table" then
        for _, id in ipairs(after) do if not Done(id) then return false, id end end
    elseif after and not Done(after) then
        return false, after
    end
    if line.afterAny then
        for _, id in ipairs(line.afterAny) do if Done(id) then return true end end
        return false, line.afterAny[1]
    end
    return true
end

-- A line whose last quest is done but not the step before it was done in another
-- version: Defensive Stance has one per home city, any race can do any of them, and
-- finishing one makes the game mark the others' last quest done (an Undead warrior
-- who did Ulag the Cleaver has Path of Defense done, not Veteran Uzzek; in game
-- 2026-10-04). Steps that aren't for the character's race don't count.
local function DoneByAnotherVersion(line, c)
    local steps = line.steps
    local n = #steps
    if n < 2 or not StepDone(steps[n]) then return false end
    for i = n - 1, 1, -1 do
        if StepDone(steps[i]) then return false end
        if StepCopy(steps[i], c, line) then return true end
    end
    return false
end

-- Whether this character can take the line: a step for its faction and race (Wowhead's
-- race lists; a line's own races, if any), not done in another version, within the
-- level cap. A line with a quest in the log is always the character's.
local function LineForPlayer(line, c)
    for _, copies in ipairs(line.steps) do
        for _, e in ipairs(copies) do
            if (not e[5] or e[5] == c.faction) and PF:IsQuestInLog(e[1]) then return true end
        end
    end
    if not RaceAllows(line.races, c.race) then return false end
    local first
    for _, copies in ipairs(line.steps) do
        first = StepCopy(copies, c, line)
        if first then break end
    end
    if not first or DoneByAnotherVersion(line, c) then return false end
    return not PF:IsQuestBeyondCap({ requires = first[4] })
end

-- Where a line stands: the step to show, its place, its status ("inprogress" for a
-- step in the log; "completed" when nothing's left; else for the next step after the
-- last one done, passing over steps that aren't for the character's race (a skipped
-- lead-in, like a trainer's "go and see Duthorian", doesn't hold it back either):
-- "locked" while the quests the line needs first aren't done, "available" or
-- "unavailable" by level), and for "locked" the quest still needed.
local function LineState(line, c)
    local steps = line.steps
    for i, copies in ipairs(steps) do
        local e = StepInLog(copies)
        if e then return e, i, "inprogress" end
    end
    local nextStep, lastDone = 1, nil
    for i = #steps, 1, -1 do
        lastDone = StepDone(steps[i])
        if lastDone then nextStep = i + 1 break end
    end
    local e
    while nextStep <= #steps do
        e = StepCopy(steps[nextStep], c, line)
        if e then break end
        nextStep = nextStep + 1
    end
    if not e then
        return lastDone or steps[#steps][1], #steps, "completed"
    end
    if nextStep == 1 or not lastDone then
        local ok, need = AfterMet(line)
        if not ok then return e, nextStep, "locked", need end
    end
    return e, nextStep, ((e[4] or 1) <= c.level) and "available" or "unavailable"
end

local questSummary = { available = 0, inLog = 0, done = 0, total = 0, nextLevel = nil }

local function HasProgress(line)
    for _, copies in ipairs(line.steps) do
        if StepDone(copies) or StepInLog(copies) then return true end
    end
    return false
end

-- How close a version starts to the character's home: 0 in its home city, 1 in its
-- starting zone, 2 elsewhere.
local function HomeRank(line, c)
    local d = Data.ClassQuestDetails and Data.ClassQuestDetails[line.q.id]
    if StartsIn(d, HOME_CITY[c.race or 0]) then return 0 end
    if StartsIn(d, HOME_ZONE[c.race or 0]) then return 1 end
    return 2
end

-- Versions of one quest (lines with the same `version`; a warrior's Defensive Stance
-- has one per home city) share a row: once one is in the log or under way, only that
-- one; before that, every version still open, nearest home first, as one row ("Speak
-- with Dillinger or Veteran Uzzek"). The lead row keeps the others in .alts.
local function MergeVersions(lines, c)
    for _, line in ipairs(lines) do line.alts, line.merged = nil, nil end
    for _, line in ipairs(lines) do
        local g = line.group
        if g and not g.seen then
            g.seen = true
            local chosen
            for _, l in ipairs(g) do
                if l.status and HasProgress(l) and (l.status == "inprogress" or not chosen) then chosen = l end
            end
            if chosen then
                for _, l in ipairs(g) do
                    if l ~= chosen and l.status then l.merged = true end
                end
            else
                local open = {}
                for _, l in ipairs(g) do
                    if l.status then open[#open + 1] = l end
                end
                if #open > 1 then
                    table.sort(open, function(x, y)
                        local rx, ry = HomeRank(x, c), HomeRank(y, c)
                        if rx ~= ry then return rx < ry end
                        return x.order < y.order
                    end)
                    open[1].alts = {}
                    for i = 2, #open do
                        open[1].alts[i - 1] = open[i]
                        open[i].merged = true
                    end
                end
            end
        end
    end
    for _, line in ipairs(lines) do
        if line.group then line.group.seen = nil end
        if line.merged then line.status = nil end
    end
end

local function ComputeQuests(c)
    local sum = questSummary
    sum.available, sum.inLog, sum.done, sum.total, sum.nextLevel = 0, 0, 0, 0, nil
    if not c.class then return nil end
    local lines = BuildLines(c.class)
    for i, line in ipairs(lines) do
        line.status, line.order = nil, i
        local e, index, status, need
        if LineForPlayer(line, c) then e, index, status, need = LineState(line, c) end
        if status and (status == "inprogress" or not line.extra) then
            line.status, line.index, line.need = status, index, need
            local q = StepQuest(e, c.class)
            line.q = q
            -- the chain's start, for the side panel, when this isn't it
            local rootFirst = StepCopy(line.root.steps[1], c, line.root) or line.root.steps[1][1]
            if rootFirst[1] == e[1] then
                q.chainStart, q.chainStartID = nil, nil
            elseif q.chainStartID ~= rootFirst[1] then
                local rq = StepQuest(rootFirst, c.class)
                q.chainStart, q.chainStartID = { name = rq.name, pickup = rq.pickup, zone = rq.pickupZone }, rq.id
            end
        end
    end
    MergeVersions(lines, c)
    for _, line in ipairs(lines) do
        local status, q = line.status, line.q
        if status then
            -- the other versions, for the side panel's "Or instead"
            local orInstead
            if line.alts then
                local parts = {}
                for i, alt in ipairs(line.alts) do
                    parts[i] = Hex(Theme().TEXT) .. alt.q.name .. "|r"
                        .. (alt.q.pickup and ("\n" .. Hex(Theme().MUTED) .. alt.q.pickup .. "|r") or "")
                end
                orInstead = table.concat(parts, "\n")
            end
            q.orInstead = orInstead
            sum.total = sum.total + 1
            if status == "completed" then sum.done = sum.done + 1
            elseif status == "inprogress" then sum.inLog = sum.inLog + 1
            elseif status == "available" then sum.available = sum.available + 1
            elseif status == "unavailable" and (not sum.nextLevel or q.requires < sum.nextLevel) then sum.nextLevel = q.requires
            end
        end
    end
    return lines
end

-- Every step of a line's whole chain, for the side panel: from the chain's first line
-- through the lines that follow it (indented one level per line they follow), each
-- step as { q, status, depth } for this character. Status: "completed", "inprogress",
-- "available" or "unavailable" for the step a line is at, "later" for steps after it
-- or in lines still waiting. Steps not for the character's race are left out, and so
-- are lines another version took the place of. Built when a quest is opened.
-- Of the parts of one quest (same-named steps in a row), the one to show: one in the
-- log, else the one that's next, else the first not done, else the last.
local PART_RANK = { inprogress = 1, available = 2, unavailable = 2, later = 3, completed = 4 }
local function AddChainSteps(out, line, c, depth)
    if not LineForPlayer(line, c) then return end
    local _, index, status = LineState(line, c)
    local runPart
    for i, copies in ipairs(line.steps) do
        local e = StepInLog(copies) or StepDone(copies) or StepCopy(copies, c, line)
        if e then
            local st
            if Done(e[1]) then st = "completed"
            elseif PF:IsQuestInLog(e[1]) then st = "inprogress"
            elseif i == index and (status == "available" or status == "unavailable") then st = status
            else st = "later" end
            local entry = { q = StepQuest(e, c.class), status = st, depth = depth }
            local prev = out[#out]
            if runPart == line.part[i] and prev then
                -- another part of the same quest: one row, the part that matters
                local better = PART_RANK[st] < PART_RANK[prev.status]
                if prev.status == "completed" and st == "completed" then better = true end -- the last part done
                if better then out[#out] = entry end
            else
                out[#out + 1] = entry
            end
            runPart = line.part[i]
        end
    end
    for _, child in ipairs(line.children or {}) do AddChainSteps(out, child, c, depth + 1) end
end

local function OpenQuest(line)
    if not (PF.UI and PF.UI.ShowQuestPanel and line.q) then return end
    local c = ReadCharacter()
    local steps = {}
    AddChainSteps(steps, line.root, c, 0)
    -- every step opened from the list shows the same list
    if #steps > 1 then
        for _, s in ipairs(steps) do s.q.chainSteps = steps end
    else
        line.q.chainSteps = nil
    end
    PF.UI.ShowQuestPanel(line.q, classDungeon[line.q.class])
end

local Quests = { id = "quests", label = "Quests", priority = 90, default = true }
function Quests:IsRelevant(c) return Data.ClassQuests and Data.ClassQuests[c.class] ~= nil end
function Quests:IsComplete(c)
    ComputeQuests(c)
    return questSummary.total > 0 and questSummary.done == questSummary.total
end
function Quests:Summary(c)
    ComputeQuests(c)
    local sum = questSummary
    local lines = {}
    if sum.available > 0 then
        lines[#lines + 1] = string.format("%d class %s available", sum.available, sum.available == 1 and "quest" or "quests")
    end
    if sum.inLog > 0 then
        lines[#lines + 1] = string.format("%d class %s in your log", sum.inLog, sum.inLog == 1 and "quest" or "quests")
    end
    if sum.nextLevel then
        lines[#lines + 1] = "Next at Lv " .. sum.nextLevel
    end
    if #lines == 0 then
        return sum.total > 0 and "All class quests done" or "No class quests"
    end
    return table.concat(lines, "\n")
end

-- One row per line, read like the Dungeons tab's quest rows: the game's quest icons,
-- the status, where to go and the level. The row is named after the step it's at,
-- and a line of several steps says which step that is. A line waiting on another
-- quest says which ("After Brutal Armor") under Coming up.
local QUEST_SECTIONS = {
    { "inprogress", "In progress" },
    { "available", "Available" },
    { "unavailable", "Coming up" },
    { "completed", "Done" },
}
local sectionOf = { locked = "unavailable" }
function Quests:Render(p, c)
    local lines = ComputeQuests(c)
    local sum = questSummary
    if not lines or sum.total == 0 then
        p:AddNote("No class quests on file for this class.")
        return
    end
    p:AddNote(string.format("%d of %d done.", sum.done, sum.total))
    local describe = PF.UI and PF.UI.DescribeQuest
    local d = classDungeon[c.class]
    local names = nameByID[c.class]
    -- each section in level order (the data is grouped by chain, which put a low-level
    -- quest after higher ones), then in the data's order
    local ordered = {}
    for _, line in ipairs(lines) do if line.status then ordered[#ordered + 1] = line end end
    table.sort(ordered, function(a, b)
        local ra, rb = a.q.requires or 0, b.q.requires or 0
        if ra ~= rb then return ra < rb end
        return a.order < b.order
    end)
    for _, sec in ipairs(QUEST_SECTIONS) do
        local header = false
        for _, line in ipairs(ordered) do
            local status = line.status
            if status and (sectionOf[status] or status) == sec[1] then
                if not header then p:AddHeader(sec[2]); header = true end
                local q = line.q
                local icon, text, color, grey
                if describe then
                    icon, text, color, grey = describe(q, d, c.level, status == "locked" and "unavailable" or status, true)
                end
                if status == "locked" then text = "After " .. (names[line.need] or "an earlier quest") end
                local title = q.name
                local n = line.parts or #line.steps
                if line.alts then
                    -- "Speak with Dillinger or Veteran Uzzek", picked up in either place
                    local zones = { q.pickupZone }
                    for _, alt in ipairs(line.alts) do
                        title = title .. " or " .. alt.q.name
                        local z, seen = alt.q.pickupZone, false
                        for _, have in ipairs(zones) do if have == z then seen = true end end
                        if z and not seen then zones[#zones + 1] = z end
                    end
                    local from = q.pickupZone and ("Pick up in " .. q.pickupZone)
                    local at = from and text and text:find(from, 1, true)
                    if at then
                        text = text:sub(1, at - 1) .. "Pick up in " .. table.concat(zones, " or ") .. text:sub(at + #from)
                    end
                elseif n > 1 and status ~= "completed" then
                    local step = string.format("Step %d of %d", line.part and line.part[line.index] or line.index, n)
                    text = text and (step .. "\n" .. text) or step
                elseif n > 1 then
                    text = string.format("%d steps done", n)
                end
                p:AddRow(title, color, text, "Lv " .. q.requires, icon, OpenQuest, line, nil, grey)
            end
        end
    end
end

Journey:RegisterModule(Quests)

-- =====================================================================
-- Zones: where to quest at this level; a zone opens on the world map.
-- =====================================================================
-- (Rough quest counts per zone were shown here until 2026-10-06; they were dropped
-- at the user's request, with their estimates and the per-zone turn-in tally.)
local zoneRows = {}

-- The game's own difficulty colors for a zone, judged by its middle level.
local function ZoneColor(z, c)
    local T = Theme()
    if not z.levelMin then return T.TEXT end
    local mid = math.floor((z.levelMin + z.levelMax) / 2)
    local diff = mid - c.level
    if diff >= 5 then return T.BAD
    elseif diff >= 3 then return T.WARN
    elseif diff >= -2 then return T.GOLD
    elseif c.level <= z.levelMax then return T.GOOD
    end
    return T.MUTED
end

local function ComputeZones(c)
    wipe(zoneRows)
    for _, z in ipairs(PF:GetRelevantZones(c.level, 2)) do
        if z.levelMin and (z.faction == "Both" or z.faction == c.faction) and c.level <= z.levelMax + 2 then
            zoneRows[#zoneRows + 1] = z
        end
    end
    return zoneRows
end

local function CurrentZoneName()
    if not (C_Map and C_Map.GetBestMapForUnit and C_Map.GetMapInfo) then return nil end
    local ok, mapID = pcall(C_Map.GetBestMapForUnit, "player")
    if not ok or not mapID then return nil end
    -- walk up from a sub-zone or dungeon map to the zone (map type 3)
    for _ = 1, 5 do
        local okI, info = pcall(C_Map.GetMapInfo, mapID)
        if not okI or not info then return nil end
        if info.mapType == nil or info.mapType <= 3 or not info.parentMapID or info.parentMapID == 0 then
            return info.name
        end
        mapID = info.parentMapID
    end
end

-- Opens the zone on the world map with the client's own call (C_Map.OpenWorldMap,
-- as Mark on map does: never the interface's OpenWorldMap, see taint rule 2), out of
-- combat only.
local function OpenZoneMap(z)
    if InCombatLockdown() then
        print("|cff3fc7ebPathForever:|r the map can't be opened in combat.")
        return
    end
    local mapID = PF.GetZoneMapID and PF:GetZoneMapID(z.name)
    if mapID and C_Map and C_Map.OpenWorldMap then
        Theme().PlayUISound("IG_QUEST_LIST_SELECT")
        pcall(C_Map.OpenWorldMap, mapID)
    end
end

local Zones = { id = "zones", label = "Zones", priority = 80, default = true }
function Zones:IsRelevant() return true end
function Zones:IsComplete() return false end

-- ---------- The zone guide ----------
-- Everything PathForever already knows about a zone, gathered for the Zones panel
-- and the side panel's "zone" mode: its dungeons, the class quests that start there,
-- the library books in it, the gathering nodes there for your Mining or Herbalism,
-- and what you've fished there. (Functions on Zones rather than locals: Journey.lua
-- is at Lua's 200-locals limit.)

-- Quests in the character's log by zone: the log lists them under their zone's name.
-- (A function on Zones, like the rest, for the locals limit.)
function Zones.LogCounts()
    local out = {}
    local q = C_QuestLog
    if not (q and q.GetNumQuestLogEntries and q.GetInfo) then return out end
    local ok, n = pcall(q.GetNumQuestLogEntries)
    if not ok then return out end
    local zone
    for i = 1, tonumber(n) or 0 do
        local ok2, info = pcall(q.GetInfo, i)
        if ok2 and type(info) == "table" then
            if info.isHeader then
                zone = info.title
            elseif zone and not info.isHidden and not info.isTask then
                out[zone] = (out[zone] or 0) + 1
            end
        end
    end
    return out
end

-- The parts of a zone that matter to this character, counted (for the rows and the
-- card) and listed (for the guide). One pass over each source per redraw: `idx` is
-- built once by Zones.Index and shared by every zone.
function Zones.Index(c)
    local idx = { quests = {}, books = {}, dungeons = {}, logged = Zones.LogCounts() }
    for _, d in ipairs(Data.Dungeons or {}) do
        if d.zone and not d.comingSoon and (not d.faction or d.faction == "Both" or d.faction == c.faction) then
            local zone = d.zone:match("^(.-) %(") or d.zone -- "Dun Morogh (under Ironforge)"
            local list = idx.dungeons[zone] or {}
            idx.dungeons[zone] = list
            list[#list + 1] = d
        end
    end
    local lines = Data.ClassQuests and Data.ClassQuests[c.class] and ComputeQuests(c) or {}
    for _, line in ipairs(lines) do
        local st, q = line.status, line.q
        if q and q.pickupZone and (st == "available" or st == "unavailable" or st == "inprogress" or st == "locked") then
            local list = idx.quests[q.pickupZone] or {}
            idx.quests[q.pickupZone] = list
            list[#list + 1] = line
        end
    end
    if Journey.LibraryOn and Journey.LibraryOn() and Journey.LibraryBooks then
        for _, b in ipairs(Journey:LibraryBooks().books) do
            if not b.done then
                local list = idx.books[b.zone] or {}
                idx.books[b.zone] = list
                list[#list + 1] = b
            end
        end
    end
    idx.gather = {}
    for _, pr in ipairs(PF.GetProfessionStatus and PF:GetProfessionStatus() or {}) do
        if (pr.name == "Mining" or pr.name == "Herbalism") and Data.Gathering and Data.Gathering[pr.name] then
            idx.gather[#idx.gather + 1] = { name = pr.name, skill = pr.skillLevel or 0, nodes = Data.Gathering[pr.name] }
        end
    end
    return idx
end

-- Nodes in this zone you can gather now, and the next one here (per profession).
function Zones.Gathering(z, idx)
    local out = {}
    for _, g in ipairs(idx.gather) do
        local can, nextNode = {}, nil
        for _, n in ipairs(g.nodes) do
            local here = false
            for _, zn in ipairs(n.zones) do if zn == z.name then here = true end end
            if here then
                if n.skill <= g.skill then can[#can + 1] = n.name
                elseif not nextNode then nextNode = n end
            end
        end
        if #can > 0 or nextNode then out[#out + 1] = { prof = g.name, skill = g.skill, can = can, nextNode = nextNode } end
    end
    return out
end

-- What PathForever Fishing has seen caught in this zone.
function Zones.Fishing(z)
    local fishing = PathForeverDB and PathForeverDB.fishing
    local total, topName, topCount = 0, nil, 0
    for _, zone in pairs(type(fishing) == "table" and type(fishing.zones) == "table" and fishing.zones or {}) do
        if type(zone) == "table" and zone.name == z.name and type(zone.fish) == "table" then
            for _, f in pairs(zone.fish) do
                local n = type(f) == "table" and tonumber(f.count) or 0
                total = total + n
                if n > topCount and f.name then topName, topCount = f.name, n end
            end
        end
    end
    return total, topName
end

-- "1 dungeon", "2 class quests", "3 books", "2 herbs": what's here for you, one fact per line.
function Zones.Lines(z, idx)
    local parts = {}
    local function add(n, one, many) if n > 0 then parts[#parts + 1] = string.format("%d %s", n, n == 1 and one or many) end end
    add(idx.logged[z.name] or 0, "quest in your log", "quests in your log")
    add(#(idx.dungeons[z.name] or {}), "dungeon", "dungeons")
    add(#(idx.quests[z.name] or {}), "class quest", "class quests")
    add(#(idx.books[z.name] or {}), "book", "books")
    for _, g in ipairs(Zones.Gathering(z, idx)) do
        if g.prof == "Herbalism" then add(#g.can, "herb", "herbs") else add(#g.can, "ore node", "ore nodes") end
    end
    return parts
end
function Zones.Line(z, idx)
    local parts = Zones.Lines(z, idx)
    return #parts > 0 and table.concat(parts, "\n") or nil
end

-- The guide for one zone, as the side panel's "zone" subject (one table per zone, so
-- a second click closes it).
Zones.guides = {}
function Zones.Guide(z, c, idx)
    local g = Zones.guides[z.name] or { zone = z.name }
    Zones.guides[z.name] = g
    g.title = z.name
    local who = (z.faction == "Both" or not z.faction) and "contested" or (z.faction .. " only")
    g.subtitle = string.format("Lv %d-%d, %s", z.levelMin, z.levelMax, who)
    -- dungeons: open in the Dungeons tab
    g.dungeons = {}
    for _, d in ipairs(idx.dungeons[z.name] or {}) do
        local total, done = 0, 0
        if PF.GetDungeonQuestCounts then total, done = PF:GetDungeonQuestCounts(d) end
        local st = (d.levelMin and d.levelMin > c.level) and "unavailable" or ((total or 0) > (done or 0) and "available" or "completed")
        g.dungeons[#g.dungeons + 1] = {
            q = { name = d.name, requires = d.levelMin }, status = st, depth = 0,
            onClick = function() if PF.OpenTab then PF:OpenTab("Dungeons", d) end end,
        }
    end
    -- class quests that start here: open with their chain, as on the Quests card
    g.quests = {}
    for _, line in ipairs(idx.quests[z.name] or {}) do
        local st = line.status == "locked" and "unavailable" or line.status
        g.quests[#g.quests + 1] = { q = line.q, status = st, depth = 0, onClick = function() OpenQuest(line) end }
    end
    g.books = idx.books[z.name] or {}
    -- gathering and fishing, as text
    local lines = {}
    for _, gat in ipairs(Zones.Gathering(z, idx)) do
        local what = gat.prof == "Herbalism" and "Herbs" or "Ore"
        if #gat.can > 0 then lines[#lines + 1] = string.format("%s you can gather: %s", what, table.concat(gat.can, ", ")) end
        if gat.nextNode then
            lines[#lines + 1] = string.format("Next here: %s at %d (%d to go)", gat.nextNode.name, gat.nextNode.skill, gat.nextNode.skill - gat.skill)
        end
    end
    g.gathering = #lines > 0 and table.concat(lines, "\n") or nil
    local caught, top = Zones.Fishing(z)
    g.fishing = caught > 0 and string.format("%d caught here%s", caught, top and (", mostly " .. top) or "") or nil
    return g
end

-- A zone's guide in the side panel.
function Zones.OpenGuide(z)
    local c = ReadCharacter()
    local g = Zones.Guide(z, c, Zones.Index(c))
    if PF.UI and PF.UI.ShowZone then
        Theme().PlayUISound("IG_QUEST_LIST_SELECT")
        PF.UI.ShowZone(g)
    end
end
Journey.OpenZoneMap = function(name) OpenZoneMap({ name = name }) end

function Zones:Summary(c)
    local rows = ComputeZones(c)
    if #rows == 0 then return "No zones for your level" end
    local here = CurrentZoneName()
    local best = rows[1]
    for _, z in ipairs(rows) do if z.name == here then best = z end end
    local parts = Zones.Lines(best, Zones.Index(c))
    -- the card has room for two facts under the name
    local line = #parts > 0 and table.concat(parts, "\n", 1, math.min(#parts, 2)) or nil
    return string.format("%s (Lv %d-%d)\n%s", best.name, best.levelMin, best.levelMax,
        line or string.format("%d %s for your level", #rows, #rows == 1 and "zone" or "zones"))
end
function Zones:Render(p, c)
    local rows = ComputeZones(c)
    if #rows == 0 then
        p:AddNote("No zones on file for your level.")
        return
    end
    local idx = Zones.Index(c)
    local here = CurrentZoneName()
    local listed = {}
    for _, z in ipairs(rows) do
        listed[z.name] = true
        local sub = Zones.Line(z, idx)
        if z.name == here then sub = sub and ("You're here\n" .. sub) or "You're here" end
        p:AddRow(z.name, ZoneColor(z, c), sub, string.format("Lv %d-%d", z.levelMin, z.levelMax), nil, Zones.OpenGuide, z)
    end
    -- where to next: zones you'll grow into over the next few levels
    local header = false
    for _, z in ipairs(PF:GetRelevantZones(c.level + 4, 4)) do
        if z.levelMin and not listed[z.name] and z.levelMin > c.level and z.levelMin <= c.level + 8
            and (z.faction == "Both" or z.faction == c.faction) then
            if not header then p:AddHeader("Where to next"); header = true end
            p:AddRow(z.name, ZoneColor(z, c), Zones.Line(z, idx), string.format("Lv %d-%d", z.levelMin, z.levelMax), nil, Zones.OpenGuide, z)
        end
    end
end

Journey:RegisterModule(Zones)

-- Dungeons and the wishlist are rows of the Next up list that open their own pages.
do
    local function DungeonsInRange(c)
        local n, first = 0, nil
        for _, d in ipairs(Data.Dungeons or {}) do
            if not d.comingSoon and d.levelMin and d.levelMin <= c.level and (d.levelMax or 60) >= c.level
                and (not d.faction or d.faction == "Both" or d.faction == c.faction) then
                n = n + 1
                first = first or d.name
            end
        end
        return n, first
    end
    local Dungeons = { id = "dungeons", label = "Dungeons", priority = 70, default = true }
    function Dungeons:IsRelevant() return true end
    function Dungeons:IsComplete() return false end
    function Dungeons:Summary(c)
        local n, first = DungeonsInRange(c)
        if n == 0 then return "No dungeons in your level range" end
        return string.format("%d %s in your level range", n, n == 1 and "dungeon" or "dungeons")
    end
    Journey:RegisterModule(Dungeons)

    local Wishlist = { id = "wishlist", label = "Wishlist", priority = 60, default = true }
    function Wishlist:IsRelevant() return true end
    function Wishlist:IsComplete() return false end
    function Wishlist:Summary()
        local missing, total = 0, 0
        for _, e in ipairs(PF.WishlistEntries and PF:WishlistEntries() or {}) do
            total = total + 1
            if not e.got then missing = missing + 1 end
        end
        if total == 0 then return "Plan your BiS" end
        return string.format("%d of %d found", total - missing, total)
    end
    Journey:RegisterModule(Wishlist)
end

-- =====================================================================
-- Level stats: how each level went, for the level-up message and later reviews.
-- =====================================================================
-- Per character (journey.chars[guid]): `level` is the level being played now,
-- { level, seconds, earned, quests, kills, xpMax, partial }, and `history[level]`
-- keeps each finished one. Time counts while logged in (GetTime between marks);
-- /played (TIME_PLAYED_MSG) replaces it with the game's own "time played this
-- level". Gold earned adds up every rise in money. Kills are the game's own
-- "<mob> dies, you gain N experience" lines (the combat log isn't needed). A level
-- that began before tracking did is `partial`: its time isn't the whole level.
local timeMark -- GetTime() when the current stretch of play began, or nil
local lastMoney
local KILL_PATTERN -- from the game's own message, e.g. "%s dies, you gain %d experience."

local function LevelData()
    local cdb = CharDB()
    if not cdb then return nil end
    local level = UnitLevel("player") or 1
    local cur = cdb.level
    -- Around a level-up UnitLevel and the record can be a level apart either way
    -- (the level can change before PLAYER_LEVEL_UP arrives, or UnitLevel can lag
    -- after it), so a record within one level is still the current one: only
    -- OnLevelUp closes it.
    if type(cur) ~= "table" or type(cur.level) ~= "number" or math.abs(cur.level - level) > 1 then
        cur = { level = level, seconds = 0, earned = 0, quests = 0, kills = 0, partial = true }
        if UnitXPMax then
            local ok, max = pcall(UnitXPMax, "player")
            cur.xpMax = ok and max or nil
        end
        cdb.level = cur
    end
    return cur, cdb
end

-- Adds the time since the last mark to the current level.
local function Accrue()
    local cur = LevelData()
    local now = GetTime and GetTime()
    if cur and now then
        if timeMark then cur.seconds = (tonumber(cur.seconds) or 0) + math.max(0, now - timeMark) end
        timeMark = now
    end
end

local function KillPattern()
    if KILL_PATTERN == nil then
        local fmt = COMBATLOG_XPGAIN_FIRSTPERSON
        if type(fmt) == "string" then
            -- "%s dies, you gain %d experience." -> "^(.+) dies, you gain (%d+) experience"
            local p = fmt:gsub("([%(%)%.%+%-%*%?%[%]%^%$])", "%%%1")
            p = p:gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)")
            KILL_PATTERN = "^" .. p
        else
            KILL_PATTERN = false
        end
    end
    return KILL_PATTERN
end

function Journey:OnStatsEvent(event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        timeMark = GetTime and GetTime() or nil
        lastMoney = GetMoney and GetMoney() or nil
        LevelData()
    elseif event == "PLAYER_LOGOUT" then
        Accrue()
    elseif event == "PLAYER_MONEY" then
        local now = GetMoney and GetMoney()
        if now and lastMoney and now > lastMoney then
            local cur = LevelData()
            if cur then cur.earned = (tonumber(cur.earned) or 0) + (now - lastMoney) end
        end
        if now and lastMoney and Journey.OnMoneyChange then Journey:OnMoneyChange(now - lastMoney) end
        lastMoney = now
    elseif event == "QUEST_TURNED_IN" then
        local cur = LevelData()
        if cur then cur.quests = (tonumber(cur.quests) or 0) + 1 end
    elseif event == "CHAT_MSG_COMBAT_XP_GAIN" then
        local msg = ...
        local pattern = KillPattern()
        if pattern and type(msg) == "string" and msg:match(pattern) then
            local cur = LevelData()
            if cur then cur.kills = (tonumber(cur.kills) or 0) + 1 end
            local _, amount = msg:match(pattern)
            if Journey.OnGoldXPEvent then Journey:OnGoldXPEvent("KILL_XP", tonumber(amount)) end
        end
    elseif event == "TIME_PLAYED_MSG" then
        local total, atLevel = ...
        Journey:NotePlayed(total)
        local cur = LevelData()
        if cur and type(atLevel) == "number" then
            cur.seconds, cur.partial = atLevel, nil
            timeMark = GetTime and GetTime() or nil
        end
    end
end

-- 3725 -> "1h 2m", 95 -> "1m 35s"
local function FormatDuration(seconds)
    seconds = math.floor(tonumber(seconds) or 0)
    local h, m, s = math.floor(seconds / 3600), math.floor(seconds / 60) % 60, seconds % 60
    if h > 0 then return string.format("%dh %dm", h, m) end
    if m > 0 then return string.format("%dm %ds", m, s) end
    return string.format("%ds", s)
end

local function Thousands(n)
    local s = tostring(math.floor(n))
    local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    return (out:gsub("^,", ""))
end

-- Skills the trainer has for this character at `level` (the level-up event comes
-- before UnitLevel catches up): how many, and what they cost.
function Journey:SkillsReadyAt(level)
    local c = ReadCharacter()
    c.level = level or c.level
    ComputeSkills(c)
    return skillSummary.available, skillSummary.cost
end

-- Trainer reminders: Core calls this when you reach a rested area (a city or an inn) and
-- at login. Returns one chat line when skills wait at the trainer, else nil. The same
-- level and count is only mentioned again after half an hour, so walking in and out of
-- a city doesn't repeat it.
do
    local lastKey, lastAt
    function Journey:TrainerReminder()
        local c = ReadCharacter()
        ComputeSkills(c)
        local ready, cost = skillSummary.available, skillSummary.cost
        if ready <= 0 then lastKey = nil; return nil end
        local key = c.level .. ":" .. ready
        local now = time and time() or 0
        if key == lastKey and lastAt and now - lastAt < 1800 then return nil end
        lastKey, lastAt = key, now
        local line = string.format("%d %s ready at your trainer (%s).", ready, ready == 1 and "skill" or "skills", FormatMoney(cost))
        local money = GetMoney and GetMoney() or 0
        if money < cost then
            line = line .. " You have " .. FormatMoney(money) .. "."
        end
        return line
    end
end

-- Called by Core on PLAYER_LEVEL_UP: closes the level just finished, starts the new
-- one, and returns the level-up message's lines (without the "PathForever:" tag).
function Journey:OnLevelUp(newLevel)
    Accrue()
    local cdb = CharDB()
    local lines = {}
    local done = cdb and cdb.level
    if cdb then
        cdb.history = type(cdb.history) == "table" and cdb.history or {}
        if type(done) == "table" and done.level then cdb.history[done.level] = done end
        local xpMax
        if UnitXPMax then
            local ok, max = pcall(UnitXPMax, "player")
            xpMax = ok and max or nil
        end
        cdb.level = { level = newLevel, seconds = 0, earned = 0, quests = 0, kills = 0, xpMax = xpMax }
    end

    -- How the finished level went
    if type(done) == "table" and done.level == newLevel - 1 then
        local head = string.format("Level %d. Level %d took %s%s", newLevel, done.level,
            FormatDuration(done.seconds), done.partial and " (since tracking began)" or "")
        lines[#lines + 1] = head .. "."
        local parts = {}
        if (tonumber(done.earned) or 0) > 0 then parts[#parts + 1] = FormatMoney(done.earned) .. " earned" end
        parts[#parts + 1] = string.format("%d %s", done.quests or 0, (done.quests == 1) and "quest" or "quests")
        parts[#parts + 1] = string.format("%d %s", done.kills or 0, (done.kills == 1) and "kill" or "kills")
        if not done.partial and done.xpMax and (tonumber(done.seconds) or 0) >= 60 then
            parts[#parts + 1] = Thousands(done.xpMax * 3600 / done.seconds) .. " XP an hour"
        end
        lines[#lines + 1] = table.concat(parts, "  -  ")
    else
        lines[#lines + 1] = string.format("Level %d.", newLevel)
    end

    self:NoteProfessions(true)

    -- Skills waiting at the trainer
    local ready, cost = self:SkillsReadyAt(newLevel)
    if ready and ready > 0 then
        lines[#lines + 1] = string.format("%d %s ready at your trainer (%s).", ready, ready == 1 and "skill" or "skills", FormatMoney(cost))
    end

    -- Dungeons that just opened up
    for _, d in ipairs(Data.Dungeons or {}) do
        if newLevel == d.levelMin and not d.comingSoon then
            lines[#lines + 1] = string.format("%s (Lv %d-%d) just opened up in %s.", d.name, d.levelMin, d.levelMax, d.zone)
        end
    end

    -- One line for every profession
    local profs = PF.GetProfessionStatus and PF:GetProfessionStatus(newLevel) or {}
    if #profs > 0 then
        local behind = 0
        for _, p in ipairs(profs) do if p.behind then behind = behind + 1 end end
        if behind == 0 then
            lines[#lines + 1] = "All professions are on track."
        else
            lines[#lines + 1] = string.format("You have %d %s falling behind.", behind, behind == 1 and "profession" or "professions")
        end
    end
    return lines
end

-- ---------- The spellbook button ----------
-- A small PathForever button beside the game's spellbook, opening the Journey's
-- Skills panel. The button is the addon's own (parented to UIParent, only placed
-- next to the book), and it follows the book through HookScript's after-hooks, so
-- nothing of Blizzard's spellbook is changed. Forever's client may have the classic
-- SpellBookFrame or the retail PlayerSpellsFrame (loaded on demand); whichever
-- exists gets it.
local spellbookButton
local hookedBooks = {}

local function OpenSkillsFromSpellbook()
    Theme().PlayUISound("IG_CHARACTER_INFO_TAB")
    Journey:OpenModule("skills")
end

local function SpellbookButtonEnter(self)
    if not GameTooltip then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Upcoming skills", 1, 1, 1)
    GameTooltip:AddLine("What you can train now and what's coming, in PathForever.", nil, nil, nil, true)
    GameTooltip:Show()
end
local function SpellbookButtonLeave()
    if GameTooltip then GameTooltip:Hide() end
end

local function CreateSpellbookButton()
    local T = Theme()
    local ar, ag, ab = T.GetAccentColor()
    local b = CreateFrame("Button", "PathForeverSpellbookButton", UIParent)
    b:SetSize(32, 32)
    b.border = b:CreateTexture(nil, "BACKGROUND")
    b.border:SetPoint("TOPLEFT", -1, 1)
    b.border:SetPoint("BOTTOMRIGHT", 1, -1)
    b.border:SetColorTexture(ar, ag, ab, 0.8)
    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:SetAllPoints()
    b.icon:SetTexture(PF.ICON)
    b.hl = b:CreateTexture(nil, "HIGHLIGHT")
    b.hl:SetAllPoints()
    b.hl:SetColorTexture(1, 1, 1, 0.15)
    b:SetScript("OnClick", OpenSkillsFromSpellbook)
    b:SetScript("OnEnter", SpellbookButtonEnter)
    b:SetScript("OnLeave", SpellbookButtonLeave)
    b:Hide()
    return b
end

-- Beside the book's top-right corner, on its layer.
local function PlaceSpellbookButton(book)
    spellbookButton = spellbookButton or CreateSpellbookButton()
    spellbookButton:ClearAllPoints()
    spellbookButton:SetPoint("TOPLEFT", book, "TOPRIGHT", 4, -48)
    if book.GetFrameStrata then spellbookButton:SetFrameStrata(book:GetFrameStrata()) end
    if book.GetFrameLevel then spellbookButton:SetFrameLevel(book:GetFrameLevel() + 10) end
    spellbookButton:Show()
end
local function HideSpellbookButton()
    if spellbookButton then spellbookButton:Hide() end
end

local function AttachToSpellbook(book)
    if type(book) ~= "table" or hookedBooks[book] or not book.HookScript then return end
    hookedBooks[book] = true
    book:HookScript("OnShow", PlaceSpellbookButton)
    book:HookScript("OnHide", HideSpellbookButton)
    if book.IsShown and book:IsShown() then PlaceSpellbookButton(book) end
end

function Journey:HookSpellbooks()
    AttachToSpellbook(_G.SpellBookFrame)
    AttachToSpellbook(_G.PlayerSpellsFrame)
end

-- ---------- Events ----------
-- Only what can change a card: learned spells, money, quests, the model, and a
-- class trainer opening (its prices). Each asks for a coalesced redraw.
-- =====================================================================
-- Gold, XP and Discover: the panels behind the small cards.
-- =====================================================================
-- Where gold comes from and goes, sorted by the window that's open when the money
-- changes (the way bookkeeping addons such as Accountant do it): a quest turn-in's
-- reward (QUEST_TURNED_IN says how much), repairs (the repair bill dropping at a
-- merchant), the class or profession trainer, a flight master, the auction house,
-- the mailbox, a merchant, a loot window or a trade, else "other". A window still
-- counts for a moment after it closes, because the money can change just after (a
-- flight is paid as the map closes). Kept per character (journey.chars[guid].gold:
-- income and spent by kind, since when) and for this session.
local GOLD_IN = { "loot", "quests", "vendor", "auction", "mail", "trade", "other" }
local GOLD_OUT = { "training", "repairs", "vendor", "flights", "auction", "mail", "trade", "other" }
local GOLD_LABEL = {
    loot = "Looted", quests = "Quest rewards", vendor = "Merchants", auction = "Auction house",
    mail = "Mail", trade = "Trades", other = "Other", training = "Training", repairs = "Repairs",
    flights = "Flights",
}
local WINDOW_GRACE = 2
local openWindows = {} -- kind -> true while open, or the GetTime() it closed
local repairCost = 0
local questMoneyPending, questMoneyAt = 0, nil
-- This session: kept with the character (journey.chars[guid].session), so a reload
-- or loading screen carries on with it; it starts over once the character has been
-- logged out for more than SESSION_GAP. `seconds` is time played in it before this
-- login (or reload), `seen` the last moment it was known to be in use (time()).
-- Until it's loaded at the first PLAYER_ENTERING_WORLD, counts go into a blank one
-- that's then added in.
local SESSION_GAP = 30 * 60
local function NewSession() return { income = {}, spent = {}, xp = 0, kills = 0, quests = 0, seconds = 0, prof = {} } end
local session = NewSession()
local sessionLoaded, sessionMark = false, nil
local lastXP, lastXPMax

local function Now() return GetTime and GetTime() or 0 end
local function Clock() return time and time() or 0 end

local function LoadSession()
    local cdb = CharDB()
    local saved = cdb and cdb.session
    local s
    if type(saved) == "table" and type(saved.seen) == "number" and Clock() - saved.seen <= SESSION_GAP then
        s = saved
        if type(s.income) ~= "table" then s.income = {} end
        if type(s.spent) ~= "table" then s.spent = {} end
        if type(s.prof) ~= "table" then s.prof = {} end
        for _, k in ipairs({ "xp", "kills", "quests", "seconds" }) do s[k] = tonumber(s[k]) or 0 end
    else
        s = NewSession()
    end
    -- whatever this login counted before now
    for kind, v in pairs(session.income) do s.income[kind] = (tonumber(s.income[kind]) or 0) + v end
    for kind, v in pairs(session.spent) do s.spent[kind] = (tonumber(s.spent[kind]) or 0) + v end
    s.xp, s.kills, s.quests = s.xp + session.xp, s.kills + session.kills, s.quests + session.quests
    for name, v in pairs(session.prof) do if s.prof[name] == nil then s.prof[name] = v end end
    s.seen = Clock()
    if cdb then cdb.session = s end
    session, sessionLoaded, sessionMark = s, true, Now()
end

-- Time played this session: earlier logins (and before a reload) plus this one.
local function SessionSeconds()
    return (tonumber(session.seconds) or 0) + (sessionMark and (Now() - sessionMark) or 0)
end

-- At logout (and a reload): bank this login's time and mark when it stopped.
local function SaveSession()
    if not sessionLoaded then return end
    session.seconds = SessionSeconds()
    sessionMark = Now()
    session.seen = Clock()
end

local function WindowActive(kind)
    local v = openWindows[kind]
    if v == true then return true end
    return v ~= nil and (Now() - v) <= WINDOW_GRACE
end

local function RepairCost()
    if not GetRepairAllCost then return 0 end
    local ok, cost = pcall(GetRepairAllCost)
    return ok and tonumber(cost) or 0
end

local function GoldDB()
    local cdb = CharDB()
    if not cdb then return nil end
    if type(cdb.gold) ~= "table" then cdb.gold = {} end
    local g = cdb.gold
    if type(g.income) ~= "table" then g.income = {} end
    if type(g.spent) ~= "table" then g.spent = {} end
    if type(g.since) ~= "number" and time then g.since = time() end
    return g
end

local function Classify(gain)
    if gain then
        if WindowActive("mail") then return "mail" end
        if WindowActive("auction") then return "auction" end
        if WindowActive("merchant") then return "vendor" end
        if WindowActive("trade") then return "trade" end
        if WindowActive("loot") then return "loot" end
        return "other"
    end
    if WindowActive("merchant") and RepairCost() < repairCost then return "repairs" end
    if WindowActive("trainer") then return "training" end
    if WindowActive("taxi") then return "flights" end
    if WindowActive("auction") then return "auction" end
    if WindowActive("mail") then return "mail" end
    if WindowActive("merchant") then return "vendor" end
    if WindowActive("trade") then return "trade" end
    return "other"
end

local function AddTo(book, kind, amount)
    book[kind] = (tonumber(book[kind]) or 0) + amount
end

local function RecordMoney(delta)
    if delta == 0 then return end
    local g = GoldDB()
    if delta > 0 then
        -- a quest reward first (it can arrive a moment before or after the turn-in)
        if questMoneyPending > 0 and questMoneyAt and Now() - questMoneyAt <= WINDOW_GRACE then
            local q = math.min(delta, questMoneyPending)
            questMoneyPending = questMoneyPending - q
            delta = delta - q
            AddTo(session.income, "quests", q)
            if g then AddTo(g.income, "quests", q) end
        end
        if delta > 0 then
            local kind = Classify(true)
            AddTo(session.income, kind, delta)
            if g then AddTo(g.income, kind, delta) end
        end
    else
        local kind = Classify(false)
        AddTo(session.spent, kind, -delta)
        if g then AddTo(g.spent, kind, -delta) end
    end
    repairCost = RepairCost()
end

-- The windows: opened, closed (with the time, for WINDOW_GRACE).
local WINDOW_EVENTS = {
    MERCHANT_SHOW = { "merchant", true }, MERCHANT_CLOSED = { "merchant", false },
    TRAINER_SHOW = { "trainer", true }, TRAINER_CLOSED = { "trainer", false },
    TAXIMAP_OPENED = { "taxi", true }, TAXIMAP_CLOSED = { "taxi", false },
    AUCTION_HOUSE_SHOW = { "auction", true }, AUCTION_HOUSE_CLOSED = { "auction", false },
    MAIL_SHOW = { "mail", true }, MAIL_CLOSED = { "mail", false },
    LOOT_OPENED = { "loot", true }, LOOT_CLOSED = { "loot", false },
    TRADE_SHOW = { "trade", true }, TRADE_CLOSED = { "trade", false },
}

function Journey:OnWindowEvent(event)
    local w = WINDOW_EVENTS[event]
    if not w then return end
    openWindows[w[1]] = w[2] and true or Now()
    if w[1] == "merchant" then repairCost = RepairCost() end
end

-- XP: what the session gained (PLAYER_XP_UPDATE, across a level-up too), and on the
-- level's record, the XP from kills and from quests (to work out kills or quests left).
local function ReadXP()
    local xp = UnitXP and UnitXP("player") or 0
    local max = UnitXPMax and UnitXPMax("player") or 0
    return tonumber(xp) or 0, tonumber(max) or 0
end

function Journey:OnXPUpdate()
    local xp, max = ReadXP()
    if lastXP then
        local gained = xp - lastXP
        if gained < 0 and lastXPMax then gained = (lastXPMax - lastXP) + xp end -- a level-up
        if gained > 0 then session.xp = session.xp + gained end
    end
    lastXP, lastXPMax = xp, max
end

function Journey:OnGoldXPEvent(event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        if not sessionLoaded then LoadSession() else session.seen = Clock() end
        lastXP, lastXPMax = ReadXP()
        repairCost = RepairCost()
        local cdb = CharDB()
        if cdb then
            cdb.name = PF.GetPlayerFullName and PF:GetPlayerFullName() or UnitName("player")
        end
        Journey:TakeSnapshot()
        Journey:NoteProfessions()
        if Journey.LibraryFinished then Journey.LibraryFinished(nil) end -- (Library is further down)
    elseif event == "PLAYER_LOGOUT" then
        SaveSession()
        Journey:TakeSnapshot(true)
    elseif event == "ZONE_CHANGED_NEW_AREA" or event == "TRAINER_CLOSED" then
        Journey:TakeSnapshot()
    elseif event == "PLAYER_UPDATE_RESTING" then
        Journey:SnapshotXP()
    elseif event == "SKILL_LINES_CHANGED" then
        Journey:NoteProfessions()
    elseif event == "QUEST_TURNED_IN" then
        local _, xp, money = ...
        session.quests = session.quests + 1
        if (tonumber(money) or 0) > 0 then
            questMoneyPending, questMoneyAt = questMoneyPending + money, Now()
        end
        local cur = LevelData()
        if cur and (tonumber(xp) or 0) > 0 then cur.questXP = (tonumber(cur.questXP) or 0) + xp end
    elseif event == "KILL_XP" then
        local amount = ...
        session.kills = session.kills + 1
        local cur = LevelData()
        if cur and amount then cur.killXP = (tonumber(cur.killXP) or 0) + amount end
    elseif event == "UPDATE_INVENTORY_DURABILITY" then
        if not WindowActive("merchant") then repairCost = RepairCost() end
    end
end

-- ---------- What the Professions tab shows about this character later ----------
-- A snapshot for the alt pop-out: where the character is, its rested XP (and whether
-- it's resting, which decides how fast more builds while logged out), what's waiting
-- at the trainer and in class quests, and when this was. journey.chars[guid].snap; the
-- alt's money is journey.chars[guid].money.
-- It's kept up to date while playing (login, zone changes, resting, XP, quests, the
-- trainer, level-ups), because at logout the game reports 0 gold and 0 XP: a snapshot
-- read then wiped an alt's gold (in game 2026-10-05). So logout (atLogout) only
-- records when the character left, and the readings are trusted only when they look
-- loaded (an XP bar of 0, or 0 gold where some was seen, is skipped; a real drop to 0
-- gold comes through PLAYER_MONEY).
function Journey:TakeSnapshot(atLogout)
    local cdb = CharDB()
    if not cdb then return end
    local snap = type(cdb.snap) == "table" and cdb.snap or {}
    cdb.snap = snap
    snap.seen = time and time() or snap.seen
    if atLogout then return end
    local c = ReadCharacter()
    local raceName = UnitRace("player")
    if (tonumber(c.level) or 0) > 0 then snap.level = c.level end
    snap.race, snap.raceName, snap.faction = c.race or snap.race, raceName or snap.raceName, c.faction or snap.faction
    local zone = GetRealZoneText and GetRealZoneText() or (GetZoneText and GetZoneText())
    if type(zone) == "string" and zone ~= "" then snap.zone = zone end
    self:SnapshotXP(snap)
    if Data.ClassSkills and Data.ClassSkills[c.class] then
        ComputeSkills(c)
        snap.skillsReady, snap.skillsCost = skillSummary.available, skillSummary.cost
    end
    if Data.ClassQuests and Data.ClassQuests[c.class] then
        ComputeQuests(c)
        snap.questsReady = questSummary.available
    end
    local money = GetMoney and tonumber(GetMoney())
    if money and (money > 0 or not tonumber(cdb.money)) then cdb.money = money end
    cdb.name = PF.GetPlayerFullName and PF:GetPlayerFullName() or cdb.name
end

-- XP, rested XP and resting, only once the XP bar has loaded.
function Journey:SnapshotXP(snap)
    if not snap then
        local cdb = CharDB()
        snap = cdb and type(cdb.snap) == "table" and cdb.snap
        if not snap then return end
    end
    local xp, max = ReadXP()
    if max <= 0 then return end
    snap.xp, snap.xpMax = xp, max
    snap.rested = GetXPExhaustion and tonumber(GetXPExhaustion()) or 0
    snap.resting = IsResting and IsResting() and true or false
end

-- For tests: forget the loaded session, as a fresh login (or /reload) does.
function Journey:ResetSessionForTest()
    session, sessionLoaded, sessionMark = NewSession(), false, nil
end
function Journey:GetSessionSeconds() return SessionSeconds() end

-- Profession skill at the start of this session and this level, for "gained this
-- level / this session". The first reading of a profession sets them (at login the
-- skills arrive with the first SKILL_LINES_CHANGED); a level-up resets the level's.
function Journey:NoteProfessions(levelUp)
    local cdb = CharDB()
    local list = PF.GetProfessionStatus and PF:GetProfessionStatus() or {}
    if cdb and (levelUp or type(cdb.profAtLevel) ~= "table") then cdb.profAtLevel = {} end
    for _, p in ipairs(list) do
        if p.name and p.skillLevel then
            if session.prof[p.name] == nil then session.prof[p.name] = p.skillLevel end
            if cdb and cdb.profAtLevel[p.name] == nil then cdb.profAtLevel[p.name] = p.skillLevel end
        end
    end
end

-- Skill points gained this level and this session (nil when not known).
function Journey:ProfessionGains(name, skill)
    local cdb = CharDB()
    local atLevel = cdb and type(cdb.profAtLevel) == "table" and cdb.profAtLevel[name]
    local atSession = tonumber(session.prof[name])
    return atLevel and (skill - atLevel) or nil, atSession and (skill - atSession) or nil
end

-- The level's and the game's own time played (TIME_PLAYED_MSG, from /played).
function Journey:NotePlayed(total)
    local cdb = CharDB()
    if cdb and tonumber(total) then cdb.played, cdb.playedAt = total, time and time() or nil end
end

-- Another character's saved Journey record (its snapshot, money, gold book, level
-- history), for the Professions tab's alt pop-out. nil when it has none.
function Journey:GetCharRecord(guid)
    local db = JourneyDB()
    local c = db and type(db.chars) == "table" and db.chars[guid]
    return type(c) == "table" and c or nil
end
Journey.FormatDuration = function(seconds) return FormatDuration(seconds) end

-- Rested XP an alt has built up since its snapshot: 5% of a level every 8 hours in
-- an inn or city, a quarter of that outside, never more than a level and a half.
-- Returns the estimate and the level's XP (both nil without a snapshot).
function Journey:EstimateRested(snap, now)
    if type(snap) ~= "table" then return nil end
    local max = tonumber(snap.xpMax) or 0
    if max <= 0 then return nil end
    local hours = math.max(0, ((now or (time and time()) or 0) - (tonumber(snap.seen) or 0)) / 3600)
    local rate = (snap.resting and 1 or 0.25) * 0.05 * max / 8
    local rested = math.min((tonumber(snap.rested) or 0) + hours * rate, max * 1.5)
    return math.floor(rested), max
end

-- Called with each change of money (from OnStatsEvent's PLAYER_MONEY).
function Journey:OnMoneyChange(delta)
    RecordMoney(delta)
    local cdb = CharDB()
    if cdb and GetMoney then cdb.money = GetMoney() end
end

-- "1,234"
local function Num(n) return Thousands(tonumber(n) or 0) end

-- Money in a row's value column; "-" for none.
local function MoneyOrDash(c) return (tonumber(c) or 0) > 0 and FormatMoney(c) or "-" end

local function SumBook(book, kinds)
    local total = 0
    for _, k in ipairs(kinds) do total = total + (tonumber(book[k]) or 0) end
    return total
end

local function PerHour(amount, seconds)
    seconds = tonumber(seconds) or 0
    if seconds < 60 then return nil end
    return amount * 3600 / seconds
end

-- Rows for one book (income or spent), largest first, empty kinds left out.
local sortedKinds = {}
local function AddBookRows(p, book, kinds)
    wipe(sortedKinds)
    for _, k in ipairs(kinds) do
        if (tonumber(book[k]) or 0) > 0 then sortedKinds[#sortedKinds + 1] = k end
    end
    table.sort(sortedKinds, function(a, b) return (book[a] or 0) > (book[b] or 0) end)
    if #sortedKinds == 0 then p:AddNote("Nothing yet.") return end
    for _, k in ipairs(sortedKinds) do p:AddRow(GOLD_LABEL[k], nil, nil, FormatMoney(book[k])) end
end

-- The trainer's bill for the next few levels (skills not learned yet, by level).
local function UpcomingTraining(c, levels)
    local list = Data.ClassSkills and Data.ClassSkills[c.class]
    local out = {}
    if not list then return out end
    ComputeSkills(c)
    for i, s in ipairs(list) do
        local st = skillState[i]
        if st == "locked" and s[4] > c.level and s[4] <= c.level + levels then
            local row = out[s[4]]
            if not row then row = { level = s[4], count = 0, cost = 0 }; out[s[4]] = row end
            row.count = row.count + 1
            row.cost = row.cost + SkillCost(c.class, s)
        end
    end
    return out
end

local Gold = { id = "gold", label = "Gold", priority = 0, mini = true }
function Gold:IsRelevant() return true end
function Gold:IsComplete() return false end
function Gold:Summary(c) return FormatMoney(c.money or 0) end
function Gold:Render(p, c)
    local onHand = GetMoney and GetMoney() or 0
    local all, chars = 0, 0
    local db = JourneyDB()
    for guid, cd in pairs(db and db.chars or {}) do
        if type(cd) == "table" and tonumber(cd.money) then
            all = all + (guid == c.guid and onHand or cd.money)
            chars = chars + 1
        end
    end
    p:AddRow("On hand", nil, nil, FormatMoney(onHand))
    if chars > 1 then p:AddRow("All your characters", nil, chars .. " characters", FormatMoney(all)) end

    p:AddHeader("This session")
    local earned, spent = SumBook(session.income, GOLD_IN), SumBook(session.spent, GOLD_OUT)
    local secs = SessionSeconds()
    p:AddRow("Earned", nil, nil, MoneyOrDash(earned))
    p:AddRow("Spent", nil, nil, MoneyOrDash(spent))
    local per = PerHour(earned, secs)
    if per then p:AddRow("Earned an hour", nil, FormatDuration(secs) .. " played", FormatMoney(per)) end

    local cur = LevelData()
    -- everything this character has earned: its finished levels' records plus this one's
    local total, partial = cur and (tonumber(cur.earned) or 0) or 0, cur and cur.partial
    local cdb = CharDB()
    for _, h in pairs(cdb and type(cdb.history) == "table" and cdb.history or {}) do
        if type(h) == "table" then
            total = total + (tonumber(h.earned) or 0)
            if h.partial then partial = true end
        end
    end
    if cur and (tonumber(cur.earned) or 0) > 0 then
        p:AddHeader("This level")
        p:AddRow("Earned", nil, cur.partial and "Since tracking began" or nil, FormatMoney(cur.earned))
        local lp = PerHour(cur.earned, cur.seconds)
        if lp then p:AddRow("Earned an hour", nil, FormatDuration(cur.seconds) .. " at this level", FormatMoney(lp)) end
    end
    if total > 0 then
        p:AddHeader("Totals")
        p:AddRow("Earned", nil, partial and "On this character, since tracking began" or "On this character",
            FormatMoney(total))
    end

    local g = GoldDB()
    p:AddHeader("Where it came from")
    AddBookRows(p, g and g.income or session.income, GOLD_IN)
    p:AddHeader("Where it went")
    AddBookRows(p, g and g.spent or session.spent, GOLD_OUT)
    if g and g.since and date then p:AddNote("Since " .. date("%d %b %Y", g.since) .. ".") end

    -- What's coming up to spend on: the trainer, now and at the next levels
    p:AddHeader("Coming up")
    ComputeSkills(c)
    local any = false
    if skillSummary.available > 0 then
        any = true
        p:AddRow(string.format("Train now: %d %s", skillSummary.available, skillSummary.available == 1 and "skill" or "skills"),
            nil, nil, FormatMoney(skillSummary.cost), nil, Journey.OpenModule and function() Journey:OpenModule("skills") end or nil)
    end
    local upcoming = UpcomingTraining(c, 4)
    local total, lastLv = 0, nil
    for lv = c.level + 1, c.level + 4 do
        local row = upcoming[lv]
        if row then
            any, lastLv = true, lv
            total = total + row.cost
            p:AddRow(string.format("Lv %d: %d %s", lv, row.count, row.count == 1 and "skill" or "skills"), nil, nil, FormatMoney(row.cost))
        end
    end
    if not any then
        p:AddNote("Nothing at the trainer for the next few levels.")
    elseif total + skillSummary.cost > onHand then
        -- named by the last level that has training (class skills come every other level)
        local short = FormatMoney(total + skillSummary.cost - onHand)
        if lastLv then
            p:AddNote(string.format("The training above, up to Lv %d, costs %s more than you have.", lastLv, short))
        else
            p:AddNote(string.format("Training now costs %s more than you have.", short))
        end
    end
end

local Experience = { id = "xp", label = "XP", priority = 0, mini = true }
function Experience:IsRelevant() return true end
function Experience:IsComplete() return false end
function Experience:Summary(c)
    local cur, max = ReadXP()
    if max > 0 then return string.format("%d%% to Lv %d", math.floor(cur / max * 100), (c.level or 1) + 1) end
    return "Lv " .. (c.level or 1)
end
function Experience:Render(p, c)
    local xp, max = ReadXP()
    local cap = PathForeverData.LevelCap
    if cap and c.level >= cap then
        p:AddNote(string.format("Lv %d, the level cap.", c.level))
    elseif max > 0 then
        p:AddRow(string.format("Lv %d: %s / %s XP", c.level, Num(xp), Num(max)), nil,
            string.format("%d%% to Lv %d\n%s XP to go", math.floor(xp * 100 / max), c.level + 1, Num(max - xp)))
    end
    local rested = GetXPExhaustion and tonumber(GetXPExhaustion()) or nil
    if rested and rested > 0 and max > 0 then
        p:AddRow("Rested", nil, string.format("%s XP, %d%% of a level\nDouble XP from kills", Num(rested), math.floor(rested * 100 / max)), Num(rested))
    else
        p:AddRow("Not rested", nil, "Log out in an inn or a city to earn rested XP.")
    end

    p:AddHeader("This session")
    local secs = SessionSeconds()
    p:AddRow("XP gained", nil, string.format("%d kills, %d quests", session.kills, session.quests), Num(session.xp))
    local per = PerHour(session.xp, secs)
    if per and per > 0 then
        p:AddRow("XP an hour", nil, FormatDuration(secs) .. " played", Num(per))
        if max > 0 then p:AddRow("Next level in", nil, "At this session's pace", FormatDuration((max - xp) / per * 3600)) end
    end

    local cur = LevelData()
    if cur then
        p:AddHeader("This level")
        local lp = PerHour(xp, cur.seconds)
        p:AddRow("Time so far", nil, cur.partial and "Since tracking began" or nil, FormatDuration(cur.seconds))
        if lp and lp > 0 and not cur.partial then p:AddRow("XP an hour", nil, nil, Num(lp)) end
        local kills, quests = tonumber(cur.kills) or 0, tonumber(cur.quests) or 0
        local killXP, questXP = tonumber(cur.killXP) or 0, tonumber(cur.questXP) or 0
        if kills > 0 and killXP > 0 and max > 0 then
            p:AddRow("Kills to level", nil, string.format("At %s XP a kill", Num(killXP / kills)), Num(math.ceil((max - xp) / (killXP / kills))))
        end
        if quests > 0 and questXP > 0 and max > 0 then
            p:AddRow("Quests to level", nil, string.format("At %s XP a quest", Num(questXP / quests)), Num(math.ceil((max - xp) / (questXP / quests))))
        end
    end

    -- The last few levels, and what they say about the road to the cap
    local cdb = CharDB()
    local hist = cdb and type(cdb.history) == "table" and cdb.history or {}
    local shown, sum, n = 0, 0, 0
    for lv = c.level - 1, math.max(1, c.level - 10), -1 do
        local h = hist[lv]
        if type(h) == "table" and not h.partial and (tonumber(h.seconds) or 0) > 0 then
            if shown == 0 then p:AddHeader("Recent levels") end
            if shown < 5 then
                local xph = h.xpMax and PerHour(h.xpMax, h.seconds)
                p:AddRow("Level " .. lv, nil, xph and (Num(xph) .. " XP an hour") or nil, FormatDuration(h.seconds))
                shown = shown + 1
            end
            sum, n = sum + h.seconds, n + 1
        end
    end
    if cap and c.level < cap and n > 0 then
        p:AddNote(string.format("At your recent pace, about %s more to reach Lv %d.", FormatDuration(sum / n * (cap - c.level)), cap))
    end
end

-- ---------- Discover ----------
-- Tips, changed with a click; now and then a line the game's characters made famous.
local TIPS = {
    "Rested XP builds while you're logged out in an inn or a city, and doubles the XP from kills until it runs out.",
    "Pick up every quest in a town before you leave it: most of them send you to the same few places.",
    "Turn quests in on the way back to town, not one trip at a time.",
    "A dungeon's quests are worth more than its loot at your level. Pick them up before you queue.",
    "Kill what's on the way. Mobs your color or green give good XP for the time.",
    "Train your skills as soon as the trainer has them: a new rank is often the biggest upgrade you'll get that level.",
    "Bandages heal between fights without mana. First Aid is worth keeping up with your level.",
    "Set your hearthstone where you'll turn most of your quests in.",
    "Flight paths are worth the detour: pick up every one you pass.",
    "Sell grey items to any merchant. They add up to your mount.",
    "Keep a stack of food and drink a few levels behind you: it costs little and saves time.",
    "Repair before a dungeon, not after a wipe.",
    "Quests a few levels above you are often fine with a group.",
    "If a quest is taking too long, skip it. There's always another one.",
    "Your professions are cheapest to level when they keep pace with you.",
    "Class quests often give a skill or a weapon you can't get anywhere else.",
    "The map pin on any quest in PathForever marks where it starts.",
    "\"Lok'tar ogar.\" Victory or death.",
    "\"For the Alliance.\"",
    "\"You are not prepared.\" - Illidan Stormrage",
    "\"Light be with you.\"",
    "\"Strength and honor.\"",
}
local tipIndex

local function NextTip()
    tipIndex = (tipIndex or 0) % #TIPS + 1
    Theme().PlayUISound("IG_QUEST_LIST_SELECT")
    Journey:Refresh()
end

local function OpenJourneyModule(id) Journey:OpenModule(id) end

-- ---------- Library books (Discover, levels 10 to 40) ----------
-- Data.lua's LibraryBooks: books handed in one at a time to the faction's librarian,
-- and three reward quests at 10, 20 and 25 books. Each reward quest opens in UI.lua's
-- side panel like a class quest (all three as its chain, its rewards as item rows, the
-- librarian with a map pin) plus "See book locations": the books for this faction,
-- each ticked once its hand-in quest is done, each pinned on the map with a click.
-- (In a do-block, with one name outside it: Journey.lua is near Lua's limit of 200
-- locals in its main chunk.)
local Library = {}
do
Library.FIRST, Library.LAST = 2, 40 -- books can be collected at any level

-- Options' "Library books" (on unless turned off): the Discover row and the world
-- map's Books button.
function Library.On()
    return not (PathForeverDB and PathForeverDB.options and PathForeverDB.options.libraryBooks == false)
end
Journey.LibraryOn = Library.On

-- The last reward (25 books) handed in: say once that book tracking can be turned
-- off. On its QUEST_TURNED_IN, or at the first login after it while tracking is on.
local function FinalQuestID()
    local q = Data.LibraryBooks and Data.LibraryBooks.quests
    return q and q[#q] and q[#q].id
end
function Library.Finished(questID)
    local final = FinalQuestID()
    if not (final and Library.On() and PathForeverDB and PathForeverDB.options) then return end
    if questID and questID ~= final then return end
    if not questID and not Done(final) then return end
    if PathForeverDB.options.libraryReminded then return end
    PathForeverDB.options.libraryReminded = true
    print("|cff3fc7ebPathForever:|r you've earned every library reward. You can turn off book tracking in PathForever's Options.")
end
Journey.LibraryFinished = Library.Finished
local libraryPanel = { name = "Library books" } -- the side panel's "dungeon" line
local libraryQuests, librarySteps, libraryBooks, libraryBookPool = {}, {}, {}, {}
local libraryBooksSubject = { title = "Library books", books = libraryBooks }

-- A book in the bags or the bank (the game's own count; the book is a unique item
-- kept until it's handed in).
local function Held(itemID)
    local itemCount = C_Item and C_Item.GetItemCount or GetItemCount
    if not (itemID and itemCount) then return false end
    local ok, n = pcall(itemCount, itemID, true)
    return ok and (tonumber(n) or 0) > 0
end

-- Books handed in (their hand-in quests done) and books picked up but not handed in
-- yet; a book found in two places counts once.
local function LibraryHandedIn()
    local L, seen, handed, held = Data.LibraryBooks, {}, 0, 0
    for _, b in ipairs(L and L.books or {}) do
        local key = b[2] or b[9]
        if key and not seen[key] then
            seen[key] = true
            if b[2] and Done(b[2]) then handed = handed + 1
            elseif Held(b[9]) then held = held + 1 end
        end
    end
    return handed, held
end

-- The three reward quests as side-panel quests, with their chain's status; returns the
-- next one to do (nil once all are done) and the books handed in.
function Library.State(c)
    local L = Data.LibraryBooks
    local lib = L and L.librarians[c.faction]
    if not lib then return nil end
    local handed, held = LibraryHandedIn()
    local nextQ
    for i, lq in ipairs(L.quests) do
        local q = libraryQuests[i]
        if not q then
            local items = {}
            for _, r in ipairs(lq.rewards) do items[#items + 1] = { id = r[1], name = r[2], slot = r[3] } end
            q = { name = string.format("%s (%d books)", lq.name, lq.books), id = lq.id, level = lq.level,
                  requires = lq.requires, xp = lq.xp, rewardItems = items, library = true, books = lq.books }
            libraryQuests[i] = q
            librarySteps[i] = { q = q, depth = 0 }
            q.chainSteps = librarySteps
        end
        local who = lib.npc .. ", " .. lib.place .. ", " .. lib.zone
        q.pickup, q.pickupZone, q.turnin, q.turninZone = who, lib.zone, who, lib.zone
        q.handedIn, q.held, q.librarian = handed, held, lib.npc
        if not q.mapID then
            q.mapID = PF.GetZoneMapID and PF:GetZoneMapID(lib.zone)
            if q.mapID then q.x, q.y = lib.x / 100, lib.y / 100 end
        end
        local st
        if Done(lq.id) then st = "completed"
        elseif PF:IsQuestInLog(lq.id) then st = "inprogress"
        elseif not nextQ then st = ((lq.requires or 1) <= c.level) and "available" or "unavailable"
        else st = "later" end
        librarySteps[i].status = st
        if not nextQ and st ~= "completed" then nextQ = q end
    end
    return nextQ, handed, held
end

-- The books for this character's faction, sorted by zone, each with its map pin and
-- whether it's been handed in (for UI.lua's book list).
function Journey:LibraryBooks()
    local c = ReadCharacter()
    local L = Data.LibraryBooks
    wipe(libraryBooks)
    if not L then return libraryBooksSubject end
    local here = GetRealZoneText and GetRealZoneText() or (GetZoneText and GetZoneText())
    for i, b in ipairs(L.books) do
        if not b[7] or b[7] == c.faction then
            local book = libraryBookPool[i]
            if not book then
                book = { name = b[1], id = b[2], container = b[3], zone = b[4], note = b[8],
                         pickup = b[1] .. " (" .. b[3] .. ")", pickupZone = b[4] }
                libraryBookPool[i] = book
            end
            if not book.mapID then
                book.mapID = PF.GetZoneMapID and PF:GetZoneMapID(b[4])
                if book.mapID then book.x, book.y = b[5] / 100, b[6] / 100 end
            end
            book.coords = string.format("%.1f, %.1f", b[5], b[6])
            book.done = b[2] and Done(b[2]) or false
            book.held = not book.done and Held(b[9])
            book.onQuest = not book.done and b[2] and PF:IsQuestInLog(b[2]) or false
            book.librarian = L.librarians[c.faction] and L.librarians[c.faction].npc
            -- first the books to hand in (carried, or their quest in the log), then the
            -- ones in the zone you're in, then the rest by zone
            if book.held or book.onQuest then
                book.section, book.rank = "To hand in", 1
            elseif here and b[4] == here then
                book.section, book.rank = "Where you are", 2
            else
                book.section, book.rank = b[4], 3
            end
            libraryBooks[#libraryBooks + 1] = book
        end
    end
    table.sort(libraryBooks, function(a, b)
        if a.rank ~= b.rank then return a.rank < b.rank end
        if a.zone ~= b.zone then return a.zone < b.zone end
        return a.name < b.name
    end)
    local handed, held = LibraryHandedIn()
    libraryBooksSubject.subtitle = held > 0 and string.format("%d books handed in, %d to hand in", handed, held)
        or string.format("%d books handed in", handed)
    return libraryBooksSubject
end

function Library.Open(q)
    if PF.UI and PF.UI.ShowQuestPanel then PF.UI.ShowQuestPanel(q, libraryPanel) end
end
end -- do (Library)
-- ---------- Cozy Sleeping Bag (Discover, from level 14) ----------
-- Data.lua's SleepingBag: a six-step quest line. Each step opens in UI.lua's side panel
-- like a class quest, with the whole line as its chain.
local SleepingBag = {}
do
local sbPanel = { name = "Cozy Sleeping Bag" }
local sbQuests, sbSteps = {}, {}

local function Pick(v, faction)
    if type(v) == "table" and (v.Alliance or v.Horde) then return v[faction] end
    return v
end
local function Where(w)
    return w and (w.place .. ", " .. w.zone) or nil
end

-- The steps as side-panel quests; returns the next step to do (nil once the bag is
-- earned) and how many are done.
function SleepingBag.State(c)
    local S = Data.SleepingBag
    if not (S and S.steps) then return nil end
    local nextQ, done = nil, 0
    for i, st in ipairs(S.steps) do
        local id = Pick(st.id, c.faction)
        local q = sbQuests[i]
        if not q then
            local items
            if st.rewards then
                items = {}
                for _, r in ipairs(st.rewards) do items[#items + 1] = { id = r[1], name = r[2], slot = r[3] } end
            end
            q = { name = st.name, level = st.level, requires = S.minLevel, xp = st.xp, rewardItems = items, sleepingBag = true }
            sbQuests[i] = q
            sbSteps[i] = { q = q, depth = 0 }
            q.chainSteps = sbSteps
        end
        q.id = id
        local from, to = Pick(st.from, c.faction), Pick(st.to, c.faction)
        q.pickup, q.pickupZone, q.turnin, q.turninZone = Where(from), from and from.zone, Where(to), to and to.zone
        q.mapID, q.x, q.y = nil, nil, nil
        q.endMapID, q.endX, q.endY = nil, nil, nil
        if from and from.x and PF.GetZoneMapID then
            q.mapID = PF:GetZoneMapID(from.zone)
            if q.mapID then q.x, q.y = from.x / 100, from.y / 100 end
        end
        if to and to.x and PF.GetZoneMapID then
            q.endMapID = PF:GetZoneMapID(to.zone)
            if q.endMapID then q.endX, q.endY = to.x / 100, to.y / 100 end
        end
        local status
        if Done(id) then status = "completed"; done = done + 1
        elseif PF:IsQuestInLog(id) then status = "inprogress"
        elseif not nextQ then status = (c.level >= S.minLevel) and "available" or "unavailable"
        else status = "later" end
        sbSteps[i].status = status
        if not nextQ and status ~= "completed" then nextQ = q end
    end
    return nextQ, done, #S.steps
end

function SleepingBag.Open(q)
    if PF.UI and PF.UI.ShowQuestPanel then PF.UI.ShowQuestPanel(q, sbPanel) end
end
end -- do (SleepingBag)
local function OpenDungeon(d)
    if PF.OpenTab then
        Theme().PlayUISound("IG_CHARACTER_INFO_TAB")
        PF:OpenTab("Dungeons", d)
    end
end

local Discover = { id = "discover", label = "Discover", priority = 0, mini = true }
function Discover:IsRelevant() return true end
function Discover:IsComplete() return false end
function Discover:Summary() return "Books and tips" end
-- Icons for the Discover rows (client icon files that exist in every build).
Discover.ICON = {
    skills = "Interface\\Icons\\INV_Misc_Book_09",
    quests = "Interface\\GossipFrame\\AvailableQuestIcon",
    dungeon = "Interface\\Icons\\INV_Misc_Key_03",
    bag = "Interface\\Icons\\INV_Misc_Bag_10",
    books = "Interface\\Icons\\INV_Misc_Book_11",
    flight = "Interface\\Icons\\Ability_Hunter_EagleEye",
    profession = "Interface\\Icons\\INV_Misc_Gear_01",
    rested = "Interface\\Icons\\Spell_Nature_Sleep",
}

function Discover:Render(p, c)
    local I = Discover.ICON
    local waiting = {} -- the "Right now" rows, collected so the header can count them
    local function AddNow(...) waiting[#waiting + 1] = { ... } end

    ComputeSkills(c)
    if skillSummary.available > 0 then
        AddNow(string.format("Train %d %s", skillSummary.available, skillSummary.available == 1 and "skill" or "skills"),
            nil, "At your class trainer", FormatMoney(skillSummary.cost), I.skills, OpenJourneyModule, "skills")
    end
    local classLines = ComputeQuests(c)
    if questSummary.available > 0 then
        AddNow(string.format("%d class %s to pick up", questSummary.available, questSummary.available == 1 and "quest" or "quests"),
            nil, "Your class trainer has them", nil, I.quests, OpenJourneyModule, "quests")
    end
    -- dungeons ready at this level, quests still to do in them
    local listed = 0
    for _, d in ipairs(Data.Dungeons or {}) do
        if listed < 3 and not d.comingSoon and d.levelMin and d.levelMin <= c.level and (d.levelMax or 60) >= c.level
            and (not d.faction or d.faction == "Both" or d.faction == c.faction) then
            local total, done = 0, 0
            if PF.GetDungeonQuestCounts then total, done = PF:GetDungeonQuestCounts(d) end
            if (total or 0) > (done or 0) then
                listed = listed + 1
                AddNow(d.name, nil, string.format("%d of %d quests done\n%s", done or 0, total, d.zone or ""),
                    "Lv " .. d.levelMin .. "-" .. d.levelMax, I.dungeon, OpenDungeon, d, nil, nil, (done or 0) / total)
            end
        end
    end
    local profs = PF.GetProfessionStatus and PF:GetProfessionStatus(c.level) or {}
    for _, pr in ipairs(profs) do
        if pr.behind then
            AddNow(string.format("Catch up %s", pr.name or "a profession"), nil,
                pr.skillLevel and pr.expected and string.format("Skill %d, %d expected at Lv %d", pr.skillLevel, pr.expected, c.level) or nil,
                nil, I.profession, nil, nil, nil, nil,
                (pr.skillLevel and pr.expected and pr.expected > 0) and pr.skillLevel / pr.expected or nil)
        end
    end
    local _, max = ReadXP()
    local rested = GetXPExhaustion and tonumber(GetXPExhaustion()) or 0
    if max > 0 and rested >= max / 2 then
        AddNow("You're well rested", nil, "Kills give double XP", nil, I.rested)
    end

    if #waiting > 0 then
        p:AddHeader("Right now")
        for _, r in ipairs(waiting) do p:AddRow(unpack(r, 1, 10)) end
    else
        p:AddNote("Nothing waiting. Quest on.")
    end

    -- Things to find: each has a bar for how far along you are
    local found = {}
    local function AddFind(...) found[#found + 1] = { ... } end
    do
        local nextQ, done, total = SleepingBag.State(c)
        if nextQ and c.level >= (Data.SleepingBag.minLevel or 14) then
            AddFind("Cozy Sleeping Bag", nil, string.format("Step %d of %d\n%s", done + 1, total, nextQ.name),
                string.format("%d/%d", done, total), I.bag, SleepingBag.Open, nextQ, nil, nil, total > 0 and done / total or nil)
        end
    end
    if Library.On() and c.level >= Library.FIRST and c.level <= Library.LAST then
        local nextQ, handed, held = Library.State(c)
        if nextQ then
            local count = held > 0 and string.format("%d handed in, %d to hand in", handed, held)
                or string.format("%d handed in", handed)
            AddFind("Collect books", nil, count .. "\nNext: " .. nextQ.name,
                string.format("%d/%d", math.min(handed, nextQ.books), nextQ.books), I.books, Library.Open, nextQ, nil, nil,
                nextQ.books > 0 and math.min(handed, nextQ.books) / nextQ.books or nil)
        end
    end
    -- a class quest line you are part of the way through
    local shown = 0
    local seenRoot = {}
    for _, line in ipairs(classLines or {}) do
        if shown < 2 and line.status and line.root and not seenRoot[line.root] then
            seenRoot[line.root] = true
            local steps = {}
            AddChainSteps(steps, line.root, c, 0)
            local done, nextStep = 0, nil
            for _, st in ipairs(steps) do
                if st.status == "completed" then done = done + 1 elseif not nextStep then nextStep = st end
            end
            if #steps >= 3 and done >= 1 and nextStep then
                shown = shown + 1
                AddFind(steps[1].q.name, nil, string.format("Step %d of %d\nNext: %s", done + 1, #steps, nextStep.q.name),
                    string.format("%d/%d", done, #steps), I.quests, OpenQuest, line, nil, nil, done / #steps)
            end
        end
    end
    -- a profession rank that comes from a book or a quest, once you are close to it
    for _, pr in ipairs(profs) do
        local src = Data.ProfessionRankSources and Data.ProfessionRankSources[pr.name]
        local rank
        for _, r in ipairs(Data.ProfessionRanks or {}) do
            if r.cap > (pr.maxSkillLevel or 0) then rank = r break end
        end
        local s = src and rank and src[rank.name]
        local where = s and (s[c.faction] or s.both)
        local needSkill = s and (s.skill or rank.skill)
        if where and (pr.maxSkillLevel or 0) > 0 and (pr.skillLevel or 0) >= needSkill - 25 then
            local needLevel = s.level or rank.level
            AddFind(s.book or ("Quest: " .. s.quest), nil,
                string.format("%s %s\n%s", s.book and "Sold by" or "Given by", where.npc, where.zone),
                needLevel > c.level and ("Lv " .. needLevel) or ("Skill " .. needSkill), I.profession,
                PF.UI and PF.UI.ShowProfession, pr, nil, nil, math.min(1, (pr.skillLevel or 0) / needSkill))
        end
    end
    -- flight points not found in the zone you are in
    if PF.FlightMap and PF.FlightMap.ZoneProgress then
        local ok, zp = pcall(PF.FlightMap.ZoneProgress, PF.FlightMap)
        if ok and zp and zp.found < zp.total then
            AddFind("Flight paths in " .. zp.zone, nil, "Not found: " .. table.concat(zp.missing, ", "),
                string.format("%d/%d", zp.found, zp.total), I.flight, nil, nil,
                "Talk to a flight master to find a new one. Turn on Flight paths on the world map to see where they are.",
                nil, zp.found / zp.total)
        end
    end
    if PF.FlightMap and PF.FlightMap.Counts then
        local ok, counts = pcall(PF.FlightMap.Counts, PF.FlightMap)
        for _, fc in ipairs(ok and counts or {}) do
            if fc.found < fc.total then
                AddFind("Flight paths: " .. fc.name, nil, string.format("%d not found yet", fc.total - fc.found),
                    string.format("%d/%d", fc.found, fc.total), I.flight, nil, nil,
                    "Talk to a flight master to find a new one. Turn on Flight paths on the world map to see which are missing.",
                    nil, fc.found / fc.total)
            end
        end
    end
    if #found > 0 then
        p:AddHeader("To find")
        for _, r in ipairs(found) do p:AddRow(unpack(r, 1, 10)) end
    end

    -- the wishlist: starred boss loot, what is still to drop first, what you got after
    do
        local wishes = PF.WishlistEntries and PF:WishlistEntries() or {}
        if #wishes > 0 then
            p:AddHeader("Wishlist")
            local todo, got = 0, 0
            for _, w in ipairs(wishes) do if w.got then got = got + 1 else todo = todo + 1 end end
            local shownTodo, shownGot = 0, 0
            for _, w in ipairs(wishes) do
                local name = w.name or (C_Item and C_Item.GetItemInfo and C_Item.GetItemInfo(w.id)) or ("Item " .. w.id)
                local icon = C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(w.id)
                local dungeon
                for _, d in ipairs(Data.Dungeons or {}) do if d.name == w.dungeon then dungeon = d break end end
                if w.got then
                    if shownGot < 3 then
                        shownGot = shownGot + 1
                        p:AddRow(name, Theme().GOOD, "Got it" .. (w.boss and ("\nFrom " .. w.boss) or ""), nil,
                            icon or "Interface\\RaidFrame\\ReadyCheck-Ready", dungeon and OpenDungeon or nil, dungeon)
                    end
                elseif shownTodo < 6 then
                    shownTodo = shownTodo + 1
                    p:AddRow(name, nil, (w.boss or "") .. ((w.boss and w.dungeon) and "\n" or "") .. (w.dungeon or ""), nil,
                        icon, dungeon and OpenDungeon or nil, dungeon)
                end
            end
            if todo > shownTodo then p:AddNote(string.format("%d more on your list", todo - shownTodo)) end
            if got > 0 then
                p:AddRow("Clear received items", Theme().MUTED, nil, nil, nil, function()
                    PF:ClearReceivedWishes()
                    Journey:Refresh()
                end, nil, "Takes the items you have off your wishlist.")
            end
        end
    end

    -- Coming up: dungeons opening in the next five levels
    local soon = 0
    for _, d in ipairs(Data.Dungeons or {}) do
        if d.levelMin and d.levelMin > c.level and d.levelMin <= c.level + 5
            and (not d.faction or d.faction == "Both" or d.faction == c.faction) then
            if soon == 0 then p:AddHeader("Coming up") end
            soon = soon + 1
            p:AddRow(d.name, nil, (d.comingSoon and "Not in the game yet\n" or "") .. (d.zone or ""),
                "Lv " .. d.levelMin, I.dungeon, not d.comingSoon and OpenDungeon or nil, d, nil, d.comingSoon)
        end
    end

    p:AddHeader("Tip")
    tipIndex = tipIndex or (math.floor(Now()) % #TIPS + 1)
    p:AddRow(TIPS[tipIndex], nil, nil, nil, nil, NextTip, nil, "Another tip")
end

Journey:RegisterModule(Gold)
Journey:RegisterModule(Experience)
Journey:RegisterModule(Discover)

local events = CreateFrame("Frame")
Journey.eventFrame = events
events:RegisterEvent("SPELLS_CHANGED")
events:RegisterEvent("PLAYER_MONEY")
events:RegisterEvent("TRAINER_SHOW")
events:RegisterEvent("TRAINER_UPDATE")
events:RegisterEvent("QUEST_TURNED_IN")
events:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
events:RegisterEvent("UNIT_MODEL_CHANGED")
-- level stats
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_LOGOUT")
events:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
events:RegisterEvent("TIME_PLAYED_MSG")
-- gold and XP: which window is open when money changes, the repair bill, XP gained
for e in pairs(WINDOW_EVENTS) do events:RegisterEvent(e) end
events:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
events:RegisterEvent("BAG_UPDATE_DELAYED") -- a library book picked up (the Discover window)
events:RegisterEvent("PLAYER_XP_UPDATE")
events:RegisterEvent("SKILL_LINES_CHANGED")
-- the alt pop-out's snapshot: where the character is and whether it's resting
events:RegisterEvent("ZONE_CHANGED_NEW_AREA")
events:RegisterEvent("PLAYER_UPDATE_RESTING")
-- the spellbook button: the classic book exists at login, the retail one loads later
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", function(_, event, arg1, arg2, arg3)
    if WINDOW_EVENTS[event] then
        Journey:OnWindowEvent(event)
        if event == "TRAINER_CLOSED" then Journey:OnGoldXPEvent(event) end -- skills learned
        if event ~= "TRAINER_SHOW" then return end -- the trainer's prices are read below
    elseif event == "UPDATE_INVENTORY_DURABILITY" then
        Journey:OnGoldXPEvent(event)
        return
    elseif event == "BAG_UPDATE_DELAYED" then
        if openMini and openMini.id == "discover" and PF.RequestRefresh then PF:RequestRefresh("journey") end
        return
    elseif event == "SKILL_LINES_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_UPDATE_RESTING" then
        Journey:OnGoldXPEvent(event)
        return
    elseif event == "PLAYER_XP_UPDATE" then
        Journey:OnXPUpdate()
        Journey:SnapshotXP()
        if (openMini or (openModule and openModule.mini)) and PF.RequestRefresh then PF:RequestRefresh("journey") end
        return
    end
    if event == "PLAYER_ENTERING_WORLD" or event == "QUEST_TURNED_IN" or event == "PLAYER_LOGOUT" then
        Journey:OnGoldXPEvent(event, arg1, arg2, arg3)
    end
    if event == "PLAYER_LOGIN" or event == "ADDON_LOADED" then
        Journey:HookSpellbooks()
        return
    end
    if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGOUT" or event == "PLAYER_MONEY"
        or event == "QUEST_TURNED_IN" or event == "CHAT_MSG_COMBAT_XP_GAIN" or event == "TIME_PLAYED_MSG" then
        Journey:OnStatsEvent(event, arg1, arg2)
        if event == "PLAYER_LOGOUT" or event == "CHAT_MSG_COMBAT_XP_GAIN" or event == "TIME_PLAYED_MSG"
            or event == "PLAYER_ENTERING_WORLD" then
            return -- nothing on the cards changes
        end
    end
    if event == "TRAINER_SHOW" or event == "TRAINER_UPDATE" then
        Journey:ReadTrainer()
    elseif event == "QUEST_TURNED_IN" then
        if Journey.LibraryFinished then Journey.LibraryFinished(arg1) end
        Journey:TakeSnapshot() -- class quests waiting
    elseif event == "PLAYER_EQUIPMENT_CHANGED" or (event == "UNIT_MODEL_CHANGED" and arg1 == "player") then
        modelDirty = true
    elseif event == "UNIT_MODEL_CHANGED" then
        return
    end
    if PF.RequestRefresh then PF:RequestRefresh("journey") end
end)
