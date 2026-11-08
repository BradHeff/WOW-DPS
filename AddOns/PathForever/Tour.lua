-- PathForever: the tour.
--
-- A short walk through the window for a new player: one small card at a time, beside the
-- sidebar entry it talks about, with a gold outline around that entry and an arrow pointing at
-- it. Each step also opens the page it is about. Offered by the welcome dialog ("Take Tour")
-- and run again with /pf tour.
--
-- Plain frames of our own, nothing protected, never in the way of the game: Escape closes it,
-- and nothing is captured. The outline and the arrow are flat textures (never an animated
-- gradient). A step whose sidebar entry is missing (a tool that is turned off) is left out.

local PF = PathForever
local Tour = {}
PF.Tour = Tour

local WIDTH = 270
local PAD = 14

-- { entry = sidebar page or action, title, text }. `entry` is also the page opened.
local STEPS = {
    { entry = "Journey", title = "Journey",
      text = "Your character at a glance, and what to do next: quests, skills, zones and dungeons for your level." },
    { entry = "Discover", title = "Discover",
      text = "Things most players miss: library books, flight paths and the like, with their places on the map." },
    { entry = "Dungeons", title = "Dungeons",
      text = "Every dungeon with its quests, bosses and loot. The ones in range of your level come first." },
    { entry = "Zones", title = "Zones",
      text = "Where to level next, zone by zone, with a guide to each one." },
    { entry = "Skills", title = "Skills",
      text = "The skills your class can train at your level, and what they cost." },
    { entry = "ClassQuests", title = "Class quests",
      text = "Your class quests in order, with who gives each one and where." },
    { entry = "Professions", title = "Professions",
      text = "Your professions and how they keep pace with your level." },
    { entry = "Reputations", title = "Reputations",
      text = "Each faction's vendors and rewards, and how to earn standing." },
    { entry = "History", title = "History",
      text = "A journal of your dungeon runs: time, XP, gold and loot, and which dungeon pays best per hour." },
    { entry = "Wishlist", title = "Wishlist",
      text = "Add the items you are after. It tells you when you are somewhere they drop." },
    { entry = "PvP", title = "PvP",
      text = "Honor, rank and the battlegrounds, with their rewards." },
    { entry = "fishing", title = "Fishing",
      text = "A fishing window with your catches, lures and a quick cast." },
    { entry = "camping", title = "Camping",
      text = "Opens at a campfire and shows which camp buffs you have." },
    { entry = "Options", title = "Options",
      text = "Make PathForever yours: what it shows, how it looks and what it tells you." },
    { title = "At the auction house and the mail",
      text = "Open the auction house and PathForever Auction appears beside it with deals and price checks. At a mailbox, PathForever Mail lists the people you wrote to last." },
}

local card, outline, arrow

local function FindEntry(key)
    local sb = PF.Sidebar and PF.Sidebar.frame
    if not (sb and sb.entries) then return nil end
    for _, e in ipairs(sb.entries) do
        if e.page == key or e.action == key then return e end
    end
end

-- The steps that can be shown now.
local function Playable()
    local list = {}
    for _, s in ipairs(STEPS) do
        if not s.entry or FindEntry(s.entry) then list[#list + 1] = s end
    end
    return list
end

local function Create()
    local T = PF.Theme
    local f = CreateFrame("Frame", "PathForeverTour", UIParent, "BackdropTemplate")
    f:SetWidth(WIDTH)
    f:SetFrameStrata("DIALOG")
    f:SetToplevel(true)
    f:EnableMouse(true)
    T.StyleWindow(f, 0.97, 0.7)

    f.count = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.count:SetPoint("TOPRIGHT", f, "TOPRIGHT", -PAD, -PAD)
    f.count:SetTextColor(T.MUTED[1], T.MUTED[2], T.MUTED[3])
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    f.title:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -PAD)
    f.title:SetWidth(WIDTH - 2 * PAD - 44)
    f.title:SetJustifyH("LEFT")
    f.text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    f.text:SetJustifyH("LEFT")
    f.text:SetJustifyV("TOP")
    f.text:SetSpacing(2)
    f.text:SetWidth(WIDTH - 2 * PAD)

    f.buttons = {}
    for i, label in ipairs({ "Back", "Next", "Skip tour" }) do
        local b = CreateFrame("Button", nil, f)
        b:SetSize(i == 3 and 80 or 64, 24)
        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        b.text:SetPoint("CENTER")
        b.text:SetText(label)
        T.StyleOutlineButton(b)
        b:SetScript("OnClick", function() Tour:Go(i == 1 and -1 or i == 2 and 1 or 0) end)
        f.buttons[i] = b
    end
    f:SetScript("OnUpdate", function(_, dt) Tour:Step(dt) end)
    f:SetScript("OnHide", function()
        if outline then outline:Hide() end
        if arrow then arrow:Hide() end
    end)
    tinsert(UISpecialFrames, "PathForeverTour")
    f:Hide()
    return f
end

-- A gold outline around the target and an arrow just left of the card, pointing at it.
local function CreateMarks()
    local ar, ag, ab = PF.Theme.GetAccentColor()
    outline = CreateFrame("Frame", "PathForeverTourOutline", UIParent)
    outline:SetFrameStrata("DIALOG")
    outline.edges = {}
    for _, side in ipairs({ { "TOPLEFT", "TOPRIGHT", nil, 2 }, { "BOTTOMLEFT", "BOTTOMRIGHT", nil, 2 },
                            { "TOPLEFT", "BOTTOMLEFT", 2, nil }, { "TOPRIGHT", "BOTTOMRIGHT", 2, nil } }) do
        local e = outline:CreateTexture(nil, "OVERLAY")
        e:SetPoint(side[1], outline, side[1], 0, 0)
        e:SetPoint(side[2], outline, side[2], 0, 0)
        if side[3] then e:SetWidth(side[3]) else e:SetHeight(side[4]) end
        e:SetColorTexture(ar, ag, ab, 1)
        outline.edges[#outline.edges + 1] = e
    end
    outline:Hide()
    arrow = CreateFrame("Frame", "PathForeverTourArrow", UIParent)
    arrow:SetFrameStrata("DIALOG")
    arrow:SetSize(28, 28)
    arrow.text = arrow:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    arrow.text:SetPoint("CENTER")
    arrow.text:SetText("<")
    arrow.text:SetTextColor(ar, ag, ab)
    arrow:Hide()
end

local playable, index

-- Each card grows out of the entry it points at, the way the window grows out of its icon
-- (Dock.lua): a smooth ease from a tiny, see-through card to full size (scale and alpha only;
-- flat textures, no animated gradient). The card is laid out at full size first, and a card with
-- a target keeps its left edge on the arrow while it grows. Step is public for the tests.
local DURATION, START_SCALE = 0.22, 0.08
local growT, anchorTarget
local function Smooth(t) return t * t * (3 - 2 * t) end
local function PlaceCard(scale)
    card:ClearAllPoints()
    if anchorTarget then
        card:SetPoint("LEFT", anchorTarget, "RIGHT", 44 / scale, 0)
    else
        card:SetPoint("CENTER", _G.PathForeverFrame or UIParent, "CENTER", 0, 0)
    end
end
function Tour:Step(dt)
    if not (growT and card) then return end
    growT = growT + dt
    if growT >= DURATION then
        growT = nil
        card:SetScale(1)
        card:SetAlpha(1)
        PlaceCard(1)
        return
    end
    local e = Smooth(growT / DURATION)
    local scale = START_SCALE + (1 - START_SCALE) * e
    card:SetScale(scale)
    card:SetAlpha(e)
    PlaceCard(scale)
end

local function Show(i)
    local step = playable[i]
    if not step then return end
    index = i
    if not card then card = Create() CreateMarks() end
    local target = step.entry and FindEntry(step.entry)

    -- open the page the step is about
    if step.entry and target and target.page and PathForeverDB then
        PathForeverDB.activeTab = target.page
        if PF.RefreshUI then PF:RefreshUI() end
    end

    card.title:SetText(step.title)
    card.count:SetText(i .. " / " .. #playable)
    card.text:ClearAllPoints()
    card.text:SetPoint("TOPLEFT", card.title, "BOTTOMLEFT", 0, -8)
    card.text:SetText(step.text)
    local h = PAD + (card.title:GetStringHeight() or 16) + 8 + (card.text:GetStringHeight() or 0) + 14 + 24 + PAD
    card:SetHeight(h)

    local last = i == #playable
    card.buttons[2].text:SetText(last and "Done" or "Next")
    card.buttons[1]:SetShown(i > 1)
    card.buttons[3]:SetShown(not last)
    local bottom = -(h - PAD - 24)
    card.buttons[1]:ClearAllPoints()
    card.buttons[1]:SetPoint("TOPLEFT", card, "TOPLEFT", PAD, bottom)
    card.buttons[2]:ClearAllPoints()
    card.buttons[2]:SetPoint("TOPLEFT", card, "TOPLEFT", PAD + 70, bottom)
    card.buttons[3]:ClearAllPoints()
    card.buttons[3]:SetPoint("TOPRIGHT", card, "TOPRIGHT", -PAD, bottom)

    anchorTarget = target
    card:SetScale(1)
    PlaceCard(1)
    if target then
        outline:ClearAllPoints()
        outline:SetPoint("TOPLEFT", target, "TOPLEFT", -1, 1)
        outline:SetPoint("BOTTOMRIGHT", target, "BOTTOMRIGHT", 1, -1)
        outline:Show()
        arrow:ClearAllPoints()
        arrow:SetPoint("RIGHT", card, "LEFT", -6, 0)
        arrow:Show()
    else
        outline:Hide()
        arrow:Hide()
    end
    card:Show()
    card:Raise()
    growT = 0
    Tour:Step(0)
end

-- Step by `dir` (-1 back, 1 forward); 0, or past the end, closes the tour.
function Tour:Go(dir)
    PF.Theme.PlayUISound("IG_CHARACTER_INFO_TAB")
    local nextIndex = (dir == 0) and 0 or (index or 0) + dir
    if nextIndex < 1 or nextIndex > #playable then
        Tour:Stop()
        return
    end
    Show(nextIndex)
end

function Tour:Stop()
    index = nil
    if card then card:Hide() end
end

function Tour:IsRunning() return card ~= nil and card:IsShown() end

function Tour:Start()
    if InCombatLockdown and InCombatLockdown() then
        print("|cff3fc7ebPathForever:|r Not in combat.")
        return
    end
    local main = _G.PathForeverFrame
    if not (main and main:IsShown()) then PF:ToggleUI() end
    playable = Playable()
    if #playable == 0 then return end
    Show(1)
end

-- for the tests
Tour.GetCard = function() return card end
Tour.Steps = function() return STEPS end
