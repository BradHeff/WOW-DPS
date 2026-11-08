-- UI.lua
-- Flat, minimal styling in the spirit of modern UI suites like EllesmereUI.
--
-- Opening the addon while inside a dungeon jumps straight to that dungeon's
-- detail view. Dungeons tab shows every dungeon, colored by state, with a
-- large pinned header (stays visible while scrolling) and a live quest-
-- completion count. Click a dungeon to see its Quests (gold "!" markers,
-- click for a scrolling side panel with status, in-progress detection, a
-- copyable Wowhead link, a "show on map" pin when coordinates exist, and
-- that quest's reward items) and its Bosses (click one for the same panel
-- showing that boss's loot instead). Every item row shows a real tooltip
-- on hover, colors by rarity once the client knows it, and - with a
-- verified numeric ID on file - shift-click links it in chat (inserting
-- at the cursor, not replacing what's typed) and ctrl-click previews it on
-- your character. See the note at the top of Data.lua for how those IDs
-- get verified, and PF:ShowWelcome (near the bottom of this file) for the
-- one-time dialog explaining undiscovered items.
--
-- Professions tab tracks alt characters' primary professions (toggle in
-- Options), nudges you to train missing tradeskills or buy a gathering
-- tool you don't have, and opens a profession's window on click.
--
-- A note on symbols: WoW's default font (Friz Quadrata) is missing glyphs
-- for a lot of Unicode punctuation - arrows and bullet characters most
-- commonly render as an empty box. Everywhere this file needs an icon-like
-- visual, it uses a real texture instead of a Unicode character, and
-- decorative separators use plain ASCII (" - ") rather than a "•".

local PF = PathForever

local frame, header, divider, cardBg
local stickyHeader, stickyHeaderText, stickyHeaderSub
local STICKY_TOP = 47       -- the name bar's offset from the top of the window
local STICKY_PAD_TOP = 7    -- space above the name, inside the bar
local scrollFrame
local professionReminderBox
local tabButtons = {}
local scrollChild
local rowPool = {}
local activeRows = {}
local viewingDungeon = nil -- non-nil while showing a dungeon's detail view
local instanceFilter = nil -- set when auto-opened inside an ambiguous multi-wing complex

local sidePanel = nil
local currentPanelSubject = nil
local currentPanelMode = nil -- "quest" or "boss"
local currentPanelDungeon = nil
local panelItemIDs = {}      -- item IDs currently shown in the side panel
local requestedItemData = {} -- item IDs already requested from the client this session

-- The collapsible section headers' arrow. Friz Quadrata has no arrow glyphs,
-- so it's a texture: the chat frame's arrow, which points right, rotated down
-- while a section is open.
local ICON_SECTION_ARROW = "Interface\\ChatFrame\\ChatFrameExpandArrow"
local ICON_UNKNOWN_ITEM = "Interface\\Icons\\INV_Misc_QuestionMark"

-- ---------- Theme ----------
-- One fixed accent for the whole addon - a muted WoW gold - for borders, the
-- active tab's underline and section headers. (It used to follow the player's
-- class color, which read like a theme generator rather than a designed UI.)
local COLOR_ACCENT = { 0.78, 0.64, 0.32 }
local function GetAccentColor()
    return COLOR_ACCENT[1], COLOR_ACCENT[2], COLOR_ACCENT[3]
end

-- Plays one of the game's own interface sounds (a SOUNDKIT name), so the
-- window sounds like a Blizzard one. PlaySound isn't protected; a client
-- without that sound just stays quiet.
local function PlayUISound(name)
    local id = SOUNDKIT and SOUNDKIT[name]
    if id and PlaySound then pcall(PlaySound, id) end
end

-- The settings checkboxes click like the game's own (a different sound on and off).
local function PlayCheckboxSound(on)
    PlayUISound(on and "IG_MAINMENU_OPTION_CHECKBOX_ON" or "IG_MAINMENU_OPTION_CHECKBOX_OFF")
end

local COLOR_TEXT    = { 0.92, 0.92, 0.94 }
local COLOR_MUTED   = { 0.55, 0.55, 0.58 }
local COLOR_WARN    = { 1.00, 0.55, 0.15 }
local COLOR_GOOD    = { 0.45, 0.80, 0.45 }
local COLOR_READY   = { 0.40, 0.85, 0.45 } -- in level range
local COLOR_DONE    = { 0.85, 0.30, 0.30 } -- all tracked quests complete
local COLOR_LOCKED  = { 0.40, 0.40, 0.43 } -- out of level range
local COLOR_GOLD    = { 1.00, 0.82, 0.00 } -- classic "available quest" yellow
local COLOR_BAD     = { 0.90, 0.32, 0.30 } -- a profession far behind pace

-- The game's scroll bar (arrow buttons, a round knob) doesn't match PathForever's
-- windows. Every scroll frame keeps UIPanelScrollFrameTemplate for the scrolling and
-- the mouse wheel, and this restyles its bar: the arrows and the bar's own art made
-- invisible, a faint full-height track, and a thin accent-colored thumb that
-- brightens on hover. Anything the client doesn't have is skipped quietly.
-- (Its helpers sit in a do-block: UI.lua is close to Lua's 200-locals limit.)
local StyleScrollBar
do
local SCROLL_THUMB_ALPHA, SCROLL_THUMB_HOVER = 0.45, 0.85
local function ScrollThumbEnter(self) if self.pfThumb then self.pfThumb:SetAlpha(SCROLL_THUMB_HOVER) end end
local function ScrollThumbLeave(self) if self.pfThumb then self.pfThumb:SetAlpha(SCROLL_THUMB_ALPHA) end end
-- the bar only while there's something to scroll (the template would show it always)
local function SyncScrollBar(self)
    local bar = self.pfBar
    if not bar then return end
    local range = self.GetVerticalScrollRange and tonumber(self:GetVerticalScrollRange()) or 0
    bar:SetShown(range > 0.5)
end
function StyleScrollBar(scroll)
    local name = scroll.GetName and scroll:GetName()
    local bar = scroll.ScrollBar or (name and _G[name .. "ScrollBar"])
    if type(bar) ~= "table" or bar.pfStyled then return end
    bar.pfStyled = true
    local barName = bar.GetName and bar:GetName()
    for _, key in ipairs({ "ScrollUpButton", "ScrollDownButton" }) do
        local b = bar[key] or (barName and _G[barName .. key])
        if type(b) == "table" then
            b:SetAlpha(0)
            b:EnableMouse(false)
        end
    end
    local thumb = bar.GetThumbTexture and bar:GetThumbTexture()
    if bar.GetRegions then
        for _, r in ipairs({ bar:GetRegions() }) do
            if r ~= thumb and r.SetAlpha then r:SetAlpha(0) end
        end
    end
    -- full height, now that there are no arrows above and below it
    bar:ClearAllPoints()
    bar:SetPoint("TOPLEFT", scroll, "TOPRIGHT", 6, -2)
    bar:SetPoint("BOTTOMLEFT", scroll, "BOTTOMRIGHT", 6, 2)
    bar:SetWidth(10)
    local track = bar:CreateTexture(nil, "BACKGROUND")
    track:SetPoint("TOP", bar, "TOP", 0, 0)
    track:SetPoint("BOTTOM", bar, "BOTTOM", 0, 0)
    track:SetWidth(2)
    track:SetColorTexture(1, 1, 1, 0.07)
    bar.pfTrack = track
    if thumb then
        local ar, ag, ab = GetAccentColor()
        thumb:SetColorTexture(ar, ag, ab, 1)
        thumb:SetAlpha(SCROLL_THUMB_ALPHA)
        thumb:SetSize(4, 36)
        bar.pfThumb = thumb
        bar:HookScript("OnEnter", ScrollThumbEnter)
        bar:HookScript("OnLeave", ScrollThumbLeave)
    end
    scroll.pfBar = bar
    scroll:HookScript("OnScrollRangeChanged", SyncScrollBar)
    scroll:HookScript("OnShow", SyncScrollBar)
    SyncScrollBar(scroll)
end
end -- do (StyleScrollBar)

-- Shared with the modules (Fishing.lua, Journey.lua), so every PathForever window
-- looks the same. ColorHex and ClassColorHex are added below, where they're defined.
PF.Theme = {
    StyleScrollBar = StyleScrollBar,
    GetAccentColor = GetAccentColor,
    PlayUISound = PlayUISound,
    PlayCheckboxSound = PlayCheckboxSound,
    TEXT = COLOR_TEXT,
    MUTED = COLOR_MUTED,
    GOOD = COLOR_GOOD,
    WARN = COLOR_WARN,
    GOLD = COLOR_GOLD,
    BAD = COLOR_BAD,
}

-- A profession more than this many points behind the level's expected skill
-- shows red; any less far behind shows orange.
local PACE_FAR_BEHIND = 20

-- ---------- Row pooling ----------
-- Rows fill the scroll area exactly: the window is WINDOW_WIDTH wide and the
-- scroll frame is inset SCROLL_INSET_LEFT / SCROLL_INSET_RIGHT (the right one
-- leaves room for the scroll bar). A row narrower than that left a wide empty
-- strip on the right, which the dungeon art made obvious.
local WINDOW_WIDTH = 420
local WINDOW_HEIGHT = 580 -- tall enough for the whole sidebar
local SCROLL_INSET_LEFT, SCROLL_INSET_RIGHT = 14, 28
local ROW_WIDTH = WINDOW_WIDTH - SCROLL_INSET_LEFT - SCROLL_INSET_RIGHT
local PORTRAIT_SIZE = 32 -- boss faces on the dungeon detail view

-- Side panel geometry. Every text in the panel gets an explicit width from
-- these (see "How text is laid out" below).
local PANEL_WIDTH = 300
local PANEL_CHILD_WIDTH = 266
local PANEL_PAD = 16
local PANEL_CW = PANEL_CHILD_WIDTH - 2 * PANEL_PAD -- usable text width

-- ---------- Small formatting helpers ----------
local function ColorHex(c)
    return string.format("|cff%02x%02x%02x", math.floor(c[1] * 255 + 0.5), math.floor(c[2] * 255 + 0.5), math.floor(c[3] * 255 + 0.5))
end

-- "|cffRRGGBB" for a class token, or nil if the class isn't known.
local function ClassColorHex(token)
    local c = token and RAID_CLASS_COLORS and RAID_CLASS_COLORS[token]
    if not c then return nil end
    return string.format("|cff%02x%02x%02x", math.floor(c.r * 255 + 0.5), math.floor(c.g * 255 + 0.5), math.floor(c.b * 255 + 0.5))
end

PF.Theme.ColorHex = ColorHex
PF.Theme.ClassColorHex = ClassColorHex

-- 4590 -> "4,590"
local function FormatNumber(n)
    local s = tostring(math.floor(tonumber(n) or 0))
    local count
    repeat
        s, count = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
    until count == 0
    return s
end

-- ---------- Dungeon art ----------
-- A dungeon that's still relevant to you gets its loading-screen art drawn
-- faded behind its row (and behind the pinned name bar in its detail view).
-- The image is the game's own file, referenced by FileDataID (`art` in
-- Data.lua, read from the client's Map -> LoadingScreens tables) - nothing
-- ships with the addon. (Forever's Adventure Guide lists no dungeons, so it
-- can't supply art; an earlier fallback to it was removed.)
local LOADING_SCREEN_ASPECT = 4 / 3 -- classic loading screens are 4:3
local artPreviewAll = false         -- /pf art: draw art on every row, for checking crops

-- file and aspect (width / height), or nil when the dungeon has no art.
local function GetDungeonArt(d)
    if not d.art then return nil end
    return d.art, d.artAspect or LOADING_SCREEN_ASPECT
end

-- The same rule that floats a dungeon to the top of the list and drives
-- "New Quests Available!": inside its level range or its quest range.
-- The art is always drawn; a dungeon outside both ranges has it dimmed and no gold bar
-- (see RenderDungeons), so range is still readable at a glance.
local function IsArtShown(d, level)
    return true
end

-- How an art texture is tinted. "faded": left to right and dimmed, so text on
-- top stays readable - for the loading screens, which are fully opaque.
-- "plain": drawn as-is - for the profession backgrounds, which are already
-- semi-transparent (fading them too made them all but invisible). Rows are
-- pooled and switch between the two, so the current look is tracked.
local function SetArtLook(tex, look)
    if tex.look == look then return end
    tex.look = look
    local faded = (look == "faded")
    local ok = CreateColor and pcall(tex.SetGradient, tex, "HORIZONTAL",
        faded and CreateColor(0.8, 0.8, 0.8, 0.55) or CreateColor(1, 1, 1, 1),
        faded and CreateColor(0.8, 0.8, 0.8, 0.08) or CreateColor(1, 1, 1, 1))
    tex.baseAlpha = (faded and not ok) and 0.35 or 1
    tex:SetAlpha(tex.baseAlpha)
end

local function ApplyArtFade(tex) SetArtLook(tex, "faded") end

-- A soft glow in the accent color: a texture over the whole of `frame` that fades
-- from `alpha` at one edge ("LEFT" or "BOTTOM") to nothing at the other, the way
-- polished UI addons light up a selected or hovered item. Plain color, no art, so it
-- can't fail to load. Hidden until the caller shows it. A client without gradients
-- gets an even faint tint instead. `color` ({ r, g, b }) replaces the accent.
local function CreateGlow(frame, from, alpha, layer, sublevel, color)
    local g = frame:CreateTexture(nil, layer or "BACKGROUND", nil, sublevel or 1)
    g:SetAllPoints()
    g:SetTexture("Interface\\Buttons\\WHITE8X8")
    local ar, ag, ab = GetAccentColor()
    if color then ar, ag, ab = color[1], color[2], color[3] end
    -- HORIZONTAL runs left to right, VERTICAL bottom to top: from "LEFT" or "BOTTOM"
    -- the strong color comes first, from "RIGHT" or "TOP" last
    local strong, clear = CreateColor and CreateColor(ar, ag, ab, alpha), CreateColor and CreateColor(ar, ag, ab, 0)
    local horizontal = (from == "LEFT" or from == "RIGHT")
    local first = (from == "LEFT" or from == "BOTTOM")
    local ok = CreateColor and pcall(g.SetGradient, g, horizontal and "HORIZONTAL" or "VERTICAL",
        first and strong or clear, first and clear or strong)
    if not ok then g:SetColorTexture(ar, ag, ab, alpha * 0.4) end
    g.pfGlow = from
    g:Hide()
    return g
end
PF.Theme.CreateGlow = CreateGlow

-- A soft glow under a word (the tabs): brightest at the bottom middle, fading
-- upward and out to both sides. One texture's gradient runs along one axis only, so
-- it's a stack of thin bands, each fading from the middle out to left and right
-- (two halves), each fainter than the one below. Returns an object with Show, Hide,
-- SetShown and IsShown, like a texture.
local CreateSoftGlow
do
local SOFT_BANDS, SOFT_HEIGHT, SOFT_SPREAD = 7, 20, 12
function CreateSoftGlow(frame, alpha, color)
    local r, g, b = GetAccentColor()
    if color then r, g, b = color[1], color[2], color[3] end
    local glow = { parts = {}, shown = false }
    local band = SOFT_HEIGHT / SOFT_BANDS
    for i = 1, SOFT_BANDS do
        -- fainter toward the top, easing out
        local k = 1 - (i - 1) / SOFT_BANDS
        local a = alpha * k * k
        local y0, y1 = (i - 1) * band, i * band
        local left = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
        left:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -SOFT_SPREAD, y0)
        left:SetPoint("TOPRIGHT", frame, "BOTTOM", 0, y1)
        local right = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
        right:SetPoint("BOTTOMLEFT", frame, "BOTTOM", 0, y0)
        right:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", SOFT_SPREAD, y1)
        for side, tex in ipairs({ left, right }) do
            tex:SetTexture("Interface\\Buttons\\WHITE8X8")
            local edge, mid = CreateColor and CreateColor(r, g, b, 0), CreateColor and CreateColor(r, g, b, a)
            -- HORIZONTAL runs left to right: the left half rises to the middle, the right falls
            local ok = CreateColor and pcall(tex.SetGradient, tex, "HORIZONTAL", side == 1 and edge or mid, side == 1 and mid or edge)
            if not ok then tex:SetColorTexture(r, g, b, a * 0.5) end
            tex:Hide()
            glow.parts[#glow.parts + 1] = tex
        end
    end
    function glow:SetShown(v)
        self.shown = v and true or false
        for _, t in ipairs(self.parts) do t:SetShown(self.shown) end
    end
    function glow:Show() self:SetShown(true) end
    function glow:Hide() self:SetShown(false) end
    function glow:IsShown() return self.shown end
    return glow
end
end -- do (CreateSoftGlow)

-- A toggle switch, for every on/off setting: a track with a knob, the knob on the
-- right in white over an accent track when on (cbCheck), on the left in grey over a
-- dark track when off (cbKnobOff). The parts keep the old checkbox's field names, so
-- "cbCheck shown" still means on. Place `owner.cbBorder` (the track); the rest follows.
local SWITCH_W, SWITCH_H = 30, 16
local function CreateSwitch(owner, w, h)
    w, h = w or SWITCH_W, h or SWITCH_H
    owner.cbBorder = owner:CreateTexture(nil, "ARTWORK")
    owner.cbBorder:SetSize(w, h)
    owner.cbBorder:Hide()
    owner.cbFill = owner:CreateTexture(nil, "ARTWORK", nil, 1)
    owner.cbFill:SetSize(w - 2, h - 2)
    owner.cbFill:SetPoint("CENTER", owner.cbBorder, "CENTER", 0, 0)
    owner.cbFill:Hide()
    owner.cbCheck = owner:CreateTexture(nil, "OVERLAY")
    owner.cbCheck:SetSize(h - 6, h - 6)
    owner.cbCheck:SetPoint("RIGHT", owner.cbBorder, "RIGHT", -3, 0)
    owner.cbCheck:SetColorTexture(1, 1, 1, 0.95)
    owner.cbCheck:Hide()
    owner.cbKnobOff = owner:CreateTexture(nil, "OVERLAY")
    owner.cbKnobOff:SetSize(h - 6, h - 6)
    owner.cbKnobOff:SetPoint("LEFT", owner.cbBorder, "LEFT", 3, 0)
    owner.cbKnobOff:SetColorTexture(0.55, 0.55, 0.58, 1)
    owner.cbKnobOff:Hide()
end
local function SetSwitch(owner, on)
    if on then
        local ar, ag, ab = GetAccentColor()
        owner.cbBorder:SetColorTexture(ar, ag, ab, 0.9)
        owner.cbFill:SetColorTexture(ar, ag, ab, 0.55)
    else
        owner.cbBorder:SetColorTexture(1, 1, 1, 0.22)
        owner.cbFill:SetColorTexture(0.05, 0.05, 0.06, 1)
    end
    owner.cbBorder:Show()
    owner.cbFill:Show()
    owner.cbCheck:SetShown(on and true or false)
    owner.cbKnobOff:SetShown(not on)
end
local function HideSwitch(owner)
    owner.cbBorder:Hide()
    owner.cbFill:Hide()
    owner.cbCheck:Hide()
    owner.cbKnobOff:Hide()
end
PF.Theme.CreateSwitch, PF.Theme.SetSwitch = CreateSwitch, SetSwitch

-- ---------- Windows and buttons in the icon's colors ----------
-- The logo is gold on a deep navy that shades to teal-navy towards the bottom
-- right. Windows take that navy (darkened for readable text), gold stays the accent.
local NAVY_FILL = { 0.05, 0.12, 0.19 } -- buttons and grouped panels: a lighter navy
local BLUE = { 0.42, 0.66, 0.80 } -- the icon's blue, brightened: quiet accents

-- (A do-block keeps the helpers out of UI.lua's top-level locals, which are near
-- Lua's limit of 200.)
local StyleWindow, StyleOutlineButton
do
-- (18% darker than the first try, 2026-10-05: the user wanted it a touch darker)
local NAVY_TOP, NAVY_BOTTOM = { 0.029, 0.057, 0.103 }, { 0.021, 0.09, 0.115 }
local WHITE_TEX = "Interface\\Buttons\\WHITE8X8"
-- A texture fading from one color to another along `orient`; plain `a` without gradients.
local function Gradient(tex, orient, a, b)
    tex:SetTexture(WHITE_TEX)
    local ok = CreateColor and pcall(tex.SetGradient, tex, orient,
        CreateColor(a[1], a[2], a[3], a[4]), CreateColor(b[1], b[2], b[3], b[4]))
    if not ok then tex:SetColorTexture(a[1], a[2], a[3], a[4]) end
end

-- PathForever's window look: the navy gradient as the fill, darker toward the edges
-- (a vignette) and a gold hairline border, so the window has depth instead of
-- looking like a flat box. `f` must be a BackdropTemplate frame.
local VIGNETTE = 34

-- Texture under the gradient's vignette: the game's own tiling art, tinted blue and kept
-- faint, so the navy has some depth. the choices are in `WINDOW_TEXTURES`
-- (saved in options.windowTexture); the default is the first. A texture the client lacks
-- would draw as a green square, so only long-standing interface files are listed.
local WINDOW_TEXTURES = {
    { key = "marble", file = "Interface\\FrameGeneral\\UI-Background-Marble", alpha = 0.10, tint = { 0.55, 0.7, 1 } },
    { key = "rock", file = "Interface\\FrameGeneral\\UI-Background-Rock", alpha = 0.12, tint = { 0.55, 0.7, 1 } },
    { key = "dark", file = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", alpha = 0.16, tint = { 0.6, 0.75, 1 } },
    { key = "stone", file = "Interface\\FrameGeneral\\UI-Background-Marble", alpha = 0.22, tint = { 0.45, 0.6, 0.9 } },
}
local texturedWindows = {}
local function WindowTextureChoice()
    local want = PathForeverDB and PathForeverDB.options and PathForeverDB.options.windowTexture
    if want == "off" then return nil end
    for _, t in ipairs(WINDOW_TEXTURES) do if t.key == want then return t end end
    return WINDOW_TEXTURES[1]
end
local function ApplyWindowTexture(tex)
    local c = WindowTextureChoice()
    if not c then tex:Hide() return end
    if not pcall(tex.SetTexture, tex, c.file, "REPEAT", "REPEAT") then tex:SetTexture(c.file) end
    tex:SetVertexColor(c.tint[1], c.tint[2], c.tint[3], 1)
    tex:SetAlpha(c.alpha)
    tex:Show()
end
-- Thin L-shaped brackets just inside each corner of the border, in the accent.
local function AddCorners(f, ar, ag, ab)
    local list = {}
    for _, corner in ipairs({ { "TOPLEFT", 1, -1 }, { "TOPRIGHT", -1, -1 }, { "BOTTOMLEFT", 1, 1 }, { "BOTTOMRIGHT", -1, 1 } }) do
        for _, horizontal in ipairs({ true, false }) do
            local t = f:CreateTexture(nil, "BORDER", nil, 3)
            t:SetPoint(corner[1], f, corner[1], corner[2] * 3, corner[3] * 3)
            if horizontal then t:SetSize(12, 1) else t:SetSize(1, 12) end
            t:SetColorTexture(ar, ag, ab, 0.45)
            list[#list + 1] = t
        end
    end
    return list
end
-- Sets the choice and restyles every window already built.
function PF.Theme.SetWindowTexture(key)
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.windowTexture = key
    for _, tex in ipairs(texturedWindows) do ApplyWindowTexture(tex) end
end
function PF.Theme.WindowTextureKeys()
    local out = { "off" }
    for _, t in ipairs(WINDOW_TEXTURES) do out[#out + 1] = t.key end
    return out
end

function StyleWindow(f, alpha, borderAlpha)
    alpha = alpha or 0.96
    local ar, ag, ab = GetAccentColor()
    f:SetBackdrop({ bgFile = WHITE_TEX, edgeFile = WHITE_TEX, edgeSize = 1 })
    f:SetBackdropColor(0, 0, 0, 0) -- the gradient below is the fill
    f:SetBackdropBorderColor(ar, ag, ab, borderAlpha or 0.55)
    local bg = f:CreateTexture(nil, "BACKGROUND", nil, -8)
    bg:SetPoint("TOPLEFT", 1, -1)
    bg:SetPoint("BOTTOMRIGHT", -1, 1)
    -- VERTICAL runs bottom to top
    Gradient(bg, "VERTICAL", { NAVY_BOTTOM[1], NAVY_BOTTOM[2], NAVY_BOTTOM[3], alpha },
        { NAVY_TOP[1], NAVY_TOP[2], NAVY_TOP[3], alpha })
    f.pfBg = bg
    local tex = f:CreateTexture(nil, "BACKGROUND", nil, -7)
    tex:SetPoint("TOPLEFT", 1, -1)
    tex:SetPoint("BOTTOMRIGHT", -1, 1)
    ApplyWindowTexture(tex)
    texturedWindows[#texturedWindows + 1] = tex
    f.pfTexture = tex
    f.pfCorners = AddCorners(f, ar, ag, ab)
    local dark, clear = { 0, 0, 0, 0.32 }, { 0, 0, 0, 0 }
    local function Edge(p1, p2, orient, w, h, from, to)
        local t = f:CreateTexture(nil, "BACKGROUND", nil, -7)
        t:SetPoint(p1, f, p1, 0, 0)
        t:SetPoint(p2, f, p2, 0, 0)
        if w then t:SetWidth(w) else t:SetHeight(h) end
        Gradient(t, orient, from, to)
        return t
    end
    f.pfVignette = {
        Edge("TOPLEFT", "BOTTOMLEFT", "HORIZONTAL", VIGNETTE, nil, dark, clear),
        Edge("TOPRIGHT", "BOTTOMRIGHT", "HORIZONTAL", VIGNETTE, nil, clear, dark),
        Edge("BOTTOMLEFT", "BOTTOMRIGHT", "VERTICAL", nil, VIGNETTE, dark, clear),
        Edge("TOPLEFT", "TOPRIGHT", "VERTICAL", nil, VIGNETTE, clear, { 0, 0, 0, 0.18 }),
    }
    -- (No shadow outside the border: four straight strips left hard edges at the
    -- corners in game, 2026-10-05, so it was taken out.)
end

-- An outlined button: a navy fill, a gold hairline that brightens on hover, and a
-- gold glow rising from the bottom. Hooks the button's own enter and leave, so its
-- text color changes keep working. `btn.bg`, an older flat fill, is hidden.
local OUTLINE_ALPHA, OUTLINE_HOVER = 0.55, 0.95
local function OutlineEnter(self)
    self.pfGlow:Show()
    for _, e in ipairs(self.pfEdges) do e:SetAlpha(OUTLINE_HOVER) end
end
local function OutlineLeave(self)
    self.pfGlow:Hide()
    for _, e in ipairs(self.pfEdges) do e:SetAlpha(OUTLINE_ALPHA) end
end
function StyleOutlineButton(btn)
    local ar, ag, ab = GetAccentColor()
    if btn.bg then btn.bg:Hide() end
    btn.pfFill = btn:CreateTexture(nil, "BACKGROUND", nil, -1)
    btn.pfFill:SetAllPoints()
    btn.pfFill:SetColorTexture(NAVY_FILL[1], NAVY_FILL[2], NAVY_FILL[3], 0.9)
    btn.pfGlow = CreateGlow(btn, "BOTTOM", 0.32, "BACKGROUND", 1)
    btn.pfEdges = {}
    for _, side in ipairs({ { "TOPLEFT", "TOPRIGHT", nil, 1 }, { "BOTTOMLEFT", "BOTTOMRIGHT", nil, 1 },
                            { "TOPLEFT", "BOTTOMLEFT", 1, nil }, { "TOPRIGHT", "BOTTOMRIGHT", 1, nil } }) do
        local e = btn:CreateTexture(nil, "BORDER")
        e:SetPoint(side[1], btn, side[1], 0, 0)
        e:SetPoint(side[2], btn, side[2], 0, 0)
        if side[3] then e:SetWidth(1) else e:SetHeight(1) end
        e:SetColorTexture(ar, ag, ab, 1)
        e:SetAlpha(OUTLINE_ALPHA)
        btn.pfEdges[#btn.pfEdges + 1] = e
    end
    btn:HookScript("OnEnter", OutlineEnter)
    btn:HookScript("OnLeave", OutlineLeave)
end
end -- do (StyleWindow, StyleOutlineButton)

-- A gold hairline across `frame` at `y` below its top, brightest in the middle and
-- fading to nothing at both ends (inset by `inset`): the line under every window's
-- title bar, in place of a flat grey rule. Returns its two halves.
local function AddFadedLine(frame, y, inset, alpha, layer)
    inset = inset or 0
    local left = CreateGlow(frame, "RIGHT", alpha or 0.5, layer or "ARTWORK", 1)
    left:ClearAllPoints()
    left:SetPoint("TOPLEFT", frame, "TOPLEFT", inset, -y)
    left:SetPoint("BOTTOMRIGHT", frame, "TOP", 0, -(y + 1))
    left:Show()
    local right = CreateGlow(frame, "LEFT", alpha or 0.5, layer or "ARTWORK", 1)
    right:ClearAllPoints()
    right:SetPoint("TOPLEFT", frame, "TOP", 0, -y)
    right:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -inset, -(y + 1))
    right:Show()
    return left, right
end
PF.Theme.AddFadedLine = AddFadedLine

-- A grouped section's panel: the rows or text under one header sit on a slightly
-- lighter navy block, so a window reads as groups. `pool` is { used = n } on the
-- frame that holds them; textures are drawn on `parent`, under its child frames
-- (rows). Call ResetGroupPanels before laying out again.
local function AddGroupPanel(pool, parent, left, top, width, bottom)
    pool.used = (pool.used or 0) + 1
    local t = pool[pool.used]
    if not t then
        t = parent:CreateTexture(nil, "BACKGROUND", nil, 2)
        pool[pool.used] = t
    end
    t:SetColorTexture(NAVY_FILL[1], NAVY_FILL[2], NAVY_FILL[3], 0.55)
    t:ClearAllPoints()
    t:SetPoint("TOPLEFT", parent, "TOPLEFT", left, -top)
    t:SetSize(width, math.max(bottom - top, 1))
    t:Show()
    return t
end
local function ResetGroupPanels(pool)
    for i = 1, (pool.used or 0) do pool[i]:Hide() end
    pool.used = 0
end
local GROUP_GAP = 10 -- between one group and the next header

PF.Theme.StyleWindow, PF.Theme.StyleOutlineButton = StyleWindow, StyleOutlineButton
PF.Theme.AddGroupPanel, PF.Theme.ResetGroupPanels = AddGroupPanel, ResetGroupPanels
PF.Theme.NAVY_FILL, PF.Theme.BLUE = NAVY_FILL, BLUE

-- The look of the buttons beside the world map (Books, Entrances), like the game's
-- own side buttons: a dark tile, a rim in the accent (the button dims it when it is
-- off), a black outer edge and the icon inset. Sets b.border (the rim), b.fill, b.icon.
function PF.Theme.StyleMapTile(b)
    local ar, ag, ab = GetAccentColor()
    b.edge = b:CreateTexture(nil, "BACKGROUND", nil, -3)
    b.edge:SetPoint("TOPLEFT", -2, 2)
    b.edge:SetPoint("BOTTOMRIGHT", 2, -2)
    b.edge:SetColorTexture(0, 0, 0, 0.95)
    b.border = b:CreateTexture(nil, "BACKGROUND", nil, -2)
    b.border:SetPoint("TOPLEFT", -1, 1)
    b.border:SetPoint("BOTTOMRIGHT", 1, -1)
    b.border:SetColorTexture(ar, ag, ab, 0.9)
    b.fill = b:CreateTexture(nil, "BACKGROUND", nil, -1)
    b.fill:SetAllPoints()
    b.fill:SetColorTexture(0.03, 0.07, 0.11, 1)
    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:SetPoint("TOPLEFT", 4, -4)
    b.icon:SetPoint("BOTTOMRIGHT", -4, 4)
end

-- Draws the band of an image that fits a w x h area without stretching it:
-- the full width, and as much height as the area's shape allows, centered
-- on centerY (0 = top of the image, 1 = bottom). The image may be a region of
-- a larger texture sheet (an atlas): l, r, t, b are that region's texture
-- coordinates (default: the whole file), and the band is placed inside it.
-- The caller has already put the image on the texture (SetTexture or SetAtlas).
-- `flip` mirrors it left to right.
local function SetArtBand(tex, aspect, centerY, w, h, l, r, t, b, flip)
    l, r, t, b = l or 0, r or 1, t or 0, b or 1
    if flip then l, r = r, l end
    local band = math.min(1, (h / w) * aspect)
    local top = math.max(0, math.min(1 - band, (centerY or 0.5) - band / 2))
    tex:SetTexCoord(l, r, t + (b - t) * top, t + (b - t) * (top + band))
    tex:Show()
end

local function ShowDungeonArt(tex, d, w, h, dim)
    local file, aspect = GetDungeonArt(d)
    if not file or not w or w <= 0 or not h or h <= 0 then tex:Hide() return end
    if tex.file ~= file then tex:SetTexture(file); tex.file = file end
    SetArtLook(tex, "faded")
    tex:SetAlpha((tex.baseAlpha or 1) * (dim and 0.4 or 1))
    SetArtBand(tex, aspect, d.artY, w, h)
end

-- Profession art: the painted backgrounds from the modern profession window's
-- Specializations page, one atlas per profession. Keyed by skill line ID
-- (confirmed in the client's SkillLine table), so it works in every locale.
-- Retail dropped First Aid before these were painted, so it has none of its
-- own: it borrows Tailoring's (bandages are made from cloth), mirrored so the
-- two never look like a repeat when their rows sit next to each other.
local PROFESSION_ART_ATLAS = {
    [129] = "professions-specializations-background-tailoring", -- First Aid (borrowed)
    [164] = "professions-specializations-background-blacksmithing",
    [165] = "professions-specializations-background-leatherworking",
    [171] = "professions-specializations-background-alchemy",
    [182] = "professions-specializations-background-herbalism",
    [185] = "professions-specializations-background-cooking",
    [186] = "professions-specializations-background-mining",
    [197] = "professions-specializations-background-tailoring",
    [202] = "professions-specializations-background-engineering",
    [333] = "professions-specializations-background-enchanting",
    [356] = "professions-specializations-background-fishing",
    [393] = "professions-specializations-background-skinning",
    [755] = "professions-specializations-background-jewelcrafting",
    [773] = "professions-specializations-background-inscription",
}
local PROFESSION_ART_FLIPPED = { [129] = true } -- skill lines drawn mirrored
local PROFESSION_ART_Y = 0.45 -- a little above the middle, where these scenes' subjects sit
local atlasInfoCache = {} -- atlas name -> the client's info table, or false if it doesn't have it

-- The client's own description of an atlas, checked once each. A client that
-- lacks the atlas gets false, and that row simply stays plain.
local function GetAtlas(name)
    local info = atlasInfoCache[name]
    if info == nil then
        local ok, result = pcall(function() return C_Texture and C_Texture.GetAtlasInfo(name) end)
        info = (ok and type(result) == "table" and result.file and result.width and result.height) and result or false
        atlasInfoCache[name] = info
    end
    return info or nil
end

-- SetAtlas lets the client resolve the atlas's sheet itself. It also resets the
-- texture's coordinates and may reset its colors, so the look is re-applied
-- (plain: these images are already semi-transparent) and the band is cut from
-- the atlas region afterwards.
local function ShowProfessionArt(tex, skillLine, w, h)
    local name = skillLine and PROFESSION_ART_ATLAS[skillLine]
    local info = name and GetAtlas(name)
    if not info or not w or w <= 0 or not h or h <= 0 then tex:Hide() return end
    if tex.file ~= name then
        tex:SetAtlas(name)
        tex.look = nil -- whatever SetAtlas left, set the look explicitly below
        tex.file = name -- a dungeon's file ID is a number, so the two never collide
    end
    SetArtLook(tex, "plain")
    SetArtBand(tex, info.width / info.height, PROFESSION_ART_Y, w, h,
        info.leftTexCoord, info.rightTexCoord, info.topTexCoord, info.bottomTexCoord,
        PROFESSION_ART_FLIPPED[skillLine])
end

-- How text is laid out (read this before changing any row/panel code):
--   * Anchor every text at TOPLEFT only, and give it an explicit SetWidth.
--     Pinning text between two side anchors, or with a "RIGHT" anchor (which
--     pins its vertical CENTER), bounds its height implicitly and long text
--     gets cut off with "...".
--   * NEVER give a text an explicit height. A text with an explicit height is
--     bounded to it, and GetStringHeight then reports only what FITS. Rows and
--     panel sections are pooled and reused, so a text that once showed one
--     short line stays locked at one line and truncates everything after it.
--     (This was the 0.4.0 "everything is cut off" regression.) Leave the height
--     unset and it sizes itself to the wrapped text.
--   * Measure with GetStringHeight AFTER SetWidth and SetText, and size the
--     row/section from that measurement.

PF.KEY_SIZE = 28 -- the key left of a quest's status icon, twice its size
PF.KEY_SHIFT = 18 -- how far a key row moves its status icon and text right
PF.ICON_KEY = "Interface\\Store\\Category-icon-key"

local function AcquireRow()
    local row = table.remove(rowPool)
    if not row then
        row = CreateFrame("Frame", nil, scrollChild)
        row:SetWidth(ROW_WIDTH)

        row.bg = row:CreateTexture(nil, "BACKGROUND")
        row.bg:SetAllPoints()

        -- a hairline along the row's foot: rows are flat and divided by it, not striped
        row.divider = row:CreateTexture(nil, "BORDER")
        row.divider:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 12, 0)
        row.divider:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -12, 0)
        row.divider:SetHeight(1)

        -- Dungeon art sits under row.bg (sublevel -1), so the hover highlight
        -- still shows on top of it.
        row.art = row:CreateTexture(nil, "BACKGROUND", nil, -1)
        row.art:SetAllPoints()
        ApplyArtFade(row.art)
        row.art:Hide()

        -- A thin accent bar on the left edge: a dungeon in your level or quest range.
        row.rangeBar = row:CreateTexture(nil, "ARTWORK", nil, 2)
        row.rangeBar:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
        row.rangeBar:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 1)
        row.rangeBar:SetWidth(3)
        row.rangeBar:SetColorTexture(COLOR_GOLD[1], COLOR_GOLD[2], COLOR_GOLD[3], 0.9)
        row.rangeBar:Hide()

        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(14, 14)
        row.icon:SetPoint("TOPLEFT", 12, -8)
        row.icon:Hide()

        -- A boss's face, square, left of its name (see LayoutRow's `portrait`).
        row.portraitBg = row:CreateTexture(nil, "ARTWORK")
        row.portraitBg:SetSize(PORTRAIT_SIZE + 2, PORTRAIT_SIZE + 2)
        row.portraitBg:SetPoint("TOPLEFT", 9, -5)
        row.portraitBg:SetColorTexture(0, 0, 0, 0.6)
        row.portraitBg:Hide()
        row.portrait = row:CreateTexture(nil, "ARTWORK", nil, 1)
        row.portrait:SetSize(PORTRAIT_SIZE, PORTRAIT_SIZE)
        row.portrait:SetPoint("TOPLEFT", 10, -6)
        row.portrait:Hide()

        -- A toggle switch on the right, shown only on rows laid out with a checked
        -- state (the Options tab).
        CreateSwitch(row)
        -- every clickable row glows from the left on hover
        row.glow = CreateGlow(row, "LEFT", 0.16)

        -- Title and sub are positioned entirely by LayoutRow.
        row.title = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.title:SetJustifyH("LEFT")

        row.sub = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.sub:SetJustifyH("LEFT")

        -- Optional short text in a column right of the title (a quest's "Lv 10"):
        -- white, one point smaller than the title.
        row.right = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.right:SetJustifyH("RIGHT")
        row.right:SetTextColor(1, 1, 1)
        pcall(function()
            local font, size, flags = row.title:GetFont()
            if font and size then row.right:SetFont(font, size - 1, flags) end
        end)
        row.right:Hide()

        -- A small tag right after the title ("NEW" on a Forever dungeon): gold
        -- text on a faint gold chip, placed by SetRowBadge.
        row.badgeBg = row:CreateTexture(nil, "ARTWORK")
        row.badgeBg:SetColorTexture(COLOR_GOLD[1], COLOR_GOLD[2], COLOR_GOLD[3], 0.18)
        row.badgeBg:Hide()
        row.badge = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        row.badge:SetJustifyH("CENTER")
        row.badge:SetTextColor(COLOR_GOLD[1], COLOR_GOLD[2], COLOR_GOLD[3])
        row.badge:Hide()

        -- A small key right after a quest's name when it opens a dungeon or an
        -- attunement (see LayoutQuestRow); the quest's own status icon stays.
        -- The store's round key icon (transparent background).
        row.keyIcon = row:CreateTexture(nil, "ARTWORK")
        row.keyIcon:SetTexture(PF.ICON_KEY)
        row.keyIcon:SetSize(PF.KEY_SIZE, PF.KEY_SIZE)
        row.keyIcon:Hide()

        -- Scripts are installed ONCE per pooled row and dispatch through fields
        -- (row.onClick, row.baseAlpha) that LayoutRow sets. Creating new closures
        -- on every refresh was a large share of this addon's garbage.
        row:SetScript("OnMouseUp", function(self, ...)
            -- a row holding an item (the Wishlist tab): Shift links it, Ctrl tries it on
            if self.rowItem and PF.RowItemClick and PF.RowItemClick(self) then return end
            if self.onClick then self.onClick(self, ...) end
        end)
        row:SetScript("OnEnter", function(self)
            if self.onClick then self.glow:Show() end
            if self.rowItem and PF.RowItemEnter then PF.RowItemEnter(self) end
            -- A row explains anything beyond "click it" (shift-click and so on) in
            -- a tooltip, never in its own text.
            if self.tooltip then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function(self)
            if self.tooltip or self.rowItem then GameTooltip:Hide() end
            self.glow:Hide()
        end)
    end
    row:Show()
    table.insert(activeRows, row)
    return row
end

-- Rows go back into the pool last-first, so AcquireRow (which takes from the
-- end) hands them out again in the same order: a redraw of the same view gets
-- the same row for the same line, and whatever a row cached (its portrait,
-- its art file) is still right. Taking them in reverse swapped rows every redraw.
local listGroups = {} -- the main list's group panels (the Options tab)
local function ReleaseAllRows()
    if PF.followStrip then PF.followStrip:Hide() end
    ResetGroupPanels(listGroups)
    for n = #activeRows, 1, -1 do
        local row = activeRows[n]
        row:Hide()
        row:ClearAllPoints()
        row:EnableMouse(false)
        row.onClick = nil
        row.rowItem, row.wishGroup = nil, nil
        if row.upStar then row.upStar:Hide() end
        if row.wlStar then row.wlStar:Hide() end
        row.icon:Hide()
        HideSwitch(row)
        row.glow:Hide()
        row.right:Hide()
        row.art:Hide()
        row.portrait:Hide()
        row.portraitBg:Hide()
        row.badge:Hide()
        row.badgeBg:Hide()
        row.keyIcon:Hide()
        row.wantsKey = nil
        table.insert(rowPool, row)
    end
    wipe(activeRows)
    if professionReminderBox then professionReminderBox:Hide() end
    if PF.upSpecBar then PF.upSpecBar:Hide() end
    if PF.bankGrid then for _, c in ipairs(PF.bankGrid.cells) do c:Hide() end end
end

local RIGHT_TEXT_WIDTH = 44

-- Draws creature `displayID`'s portrait (the face the game renders for unit
-- frames) on `tex`, cropped a little so the face fills the square. Returns
-- false when this client can't, so the caller lays the row out without it.
-- Not a protected API, and safe in combat.
local function SetBossPortrait(tex, displayID)
    if not displayID or type(SetPortraitTextureFromCreatureDisplayID) ~= "function" then return false end
    if tex.displayID ~= displayID then
        if not pcall(SetPortraitTextureFromCreatureDisplayID, tex, displayID) then return false end
        tex.displayID = displayID
    end
    tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    return true
end

-- Lays out one row at the given y-offset and returns its height. onClick
-- makes the row clickable. iconPath adds a small icon; `checked` (true/false,
-- nil for none) draws a checkbox in that state instead. rightText adds a short
-- label in a column right of the title. `portrait` (a creature display ID)
-- draws that creature's face, square, left of the title; `picture` (a texture,
-- such as a profession's icon) goes in the same square instead. A caller that wants
-- a hover tooltip sets row.tooltip after this returns. See "How text is laid
-- out" above for why every text gets an explicit width and measured height.
local function LayoutRow(row, index, y, titleText, titleColor, subText, onClick, iconPath, checked, rightText, portrait, picture)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -y)
    row:SetWidth(ROW_WIDTH)
    row.art:Hide() -- only dungeon rows show it, via ShowDungeonArt after layout
    row.rangeBar:Hide() -- likewise, RenderDungeons shows it for a dungeon in range
    if row.lockIcon then row.lockIcon:Hide() end -- the Raids tab's saved-to-raid icon

    local hasPortrait = portrait and SetBossPortrait(row.portrait, portrait) or false
    if not hasPortrait and picture then
        row.portrait:SetTexture(picture)
        row.portrait:SetTexCoord(0.08, 0.92, 0.08, 0.92) -- trims the icon's built-in border
        row.portrait.displayID = nil -- so a boss drawn here later is rendered again
        hasPortrait = true
    end
    row.portrait:SetShown(hasPortrait)
    row.portraitBg:SetShown(hasPortrait)
    row.badge:Hide() -- only rows that call SetRowBadge afterwards show one
    row.badgeBg:Hide()
    row.keyIcon:Hide() -- likewise for the key

    local left = 12
    if hasPortrait then left = PORTRAIT_SIZE + 20
    elseif iconPath then left = 30 end
    -- a quest with a key: the key takes the corner and the status icon and text move right
    -- (the key's image has empty edges, so they overlap it a little)
    local keyShift = (row.wantsKey and iconPath and not hasPortrait) and PF.KEY_SHIFT or 0
    left = left + keyShift
    local textWidth = ROW_WIDTH - left - 8
    -- the switch sits at the right, so the text stops short of it
    if checked ~= nil then textWidth = textWidth - SWITCH_W - 12 end

    if rightText then
        row.right:ClearAllPoints()
        row.right:SetPoint("TOPLEFT", row, "TOPLEFT", ROW_WIDTH - 8 - RIGHT_TEXT_WIDTH, -8)
        row.right:SetWidth(RIGHT_TEXT_WIDTH)
        row.right:SetText(rightText)
        row.right:Show()
        -- the title and sub stop short of the column, so they can never run under it
        textWidth = textWidth - RIGHT_TEXT_WIDTH - 6
    else
        row.right:Hide()
        row.right:SetText("")
    end

    if iconPath then
        row.icon:SetTexture(iconPath)
        -- placed every time: a section header reuses this texture for its arrow
        row.icon:ClearAllPoints()
        row.icon:SetPoint("TOPLEFT", row, "TOPLEFT", 12 + keyShift, -8)
        row.icon:SetSize(14, 14)
        row.icon:SetRotation(0)
        row.icon:SetDesaturated(false)
        row.icon:SetAlpha(1)
        row.icon:Show()
    else
        row.icon:Hide()
    end
    if checked ~= nil then
        row.cbBorder:ClearAllPoints()
        row.cbBorder:SetPoint("TOPRIGHT", row, "TOPRIGHT", -12, -9)
        SetSwitch(row, checked)
    else
        HideSwitch(row)
    end

    row.title:ClearAllPoints()
    row.title:SetPoint("TOPLEFT", row, "TOPLEFT", left, -7)
    row.title:SetWidth(textWidth)
    row.titleLeft = left
    row.title:SetText(titleText)
    row.title:SetTextColor(unpack(titleColor))
    local titleH = row.title:GetStringHeight() or 0

    local subH = 0
    if subText and subText ~= "" then
        row.sub:Show()
        row.sub:ClearAllPoints()
        row.sub:SetPoint("TOPLEFT", row, "TOPLEFT", left, -(7 + titleH + 3))
        row.sub:SetWidth(textWidth)
        row.sub:SetText(subText)
        subH = row.sub:GetStringHeight() or 0
    else
        row.sub:Hide()
        row.sub:SetText("")
    end

    local height = 7 + titleH + ((subH > 0) and (3 + subH + 6) or 5)
    height = math.max(height, iconPath and 28 or 0, (checked ~= nil) and 34 or 0, hasPortrait and (PORTRAIT_SIZE + 12) or 0)
    row:SetHeight(height)

    local baseAlpha = 0
    row.bg:SetColorTexture(1, 1, 1, baseAlpha)
    row.divider:SetColorTexture(1, 1, 1, 0.055)
    row.divider:Show()

    row.onClick = onClick
    row.tooltip = nil
    row.baseAlpha = baseAlpha
    row.bgR, row.bgG, row.bgB = 1, 1, 1
    row:EnableMouse(onClick ~= nil)

    return height
end

-- Puts a small gold tag ("NEW") right after a laid-out row's title, on the
-- title's first line. Call it after LayoutRow.
local BADGE_WIDTH = 30
local function SetRowBadge(row, text)
    local titleWidth = math.min(row.title:GetStringWidth() or 0, row.title:GetWidth() or 0)
    local x = (row.titleLeft or 12) + titleWidth + 8
    row.badge:ClearAllPoints()
    row.badge:SetPoint("TOPLEFT", row, "TOPLEFT", x, -9)
    row.badge:SetWidth(BADGE_WIDTH)
    row.badge:SetText(text)
    row.badge:Show()
    row.badgeBg:ClearAllPoints()
    row.badgeBg:SetPoint("TOPLEFT", row, "TOPLEFT", x, -7)
    row.badgeBg:SetSize(BADGE_WIDTH, 14)
    row.badgeBg:Show()
end

-- A distinct section divider: capitalized in the accent color, with a tinted
-- background band so it reads as a break between sections. With onClick it
-- becomes a collapsible header: an arrow shows whether it's `expanded`, and a
-- click toggles it.
local function LayoutSectionHeader(row, y, label, onClick, expanded)
    local ar, ag, ab = GetAccentColor()
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -y)
    row:SetWidth(ROW_WIDTH)
    local left = 12
    if onClick then
        row.icon:SetTexture(ICON_SECTION_ARROW)
        row.icon:ClearAllPoints()
        row.icon:SetPoint("TOPLEFT", row, "TOPLEFT", 10, -5)
        row.icon:SetSize(12, 12)
        row.icon:SetRotation(expanded and -math.pi / 2 or 0)
        row.icon:SetDesaturated(false)
        row.icon:Show()
        left = 26
    else
        row.icon:Hide()
    end
    HideSwitch(row)
    row.glow:Hide()
    row.right:Hide()
    row.right:SetText("")
    row.art:Hide()
    row.portrait:Hide()
    row.portraitBg:Hide()
    row.badge:Hide()
    row.badgeBg:Hide()
    row.keyIcon:Hide()
    row.title:ClearAllPoints()
    row.title:SetPoint("TOPLEFT", row, "TOPLEFT", left, -5)
    row.title:SetWidth(ROW_WIDTH - left - 8)
    row.title:SetText(string.upper(label))
    row.title:SetTextColor(ar, ag, ab)
    row.sub:Hide()
    row.sub:SetText("")

    -- no tinted band: the name in the accent, a faint accent line under it
    local height = 24
    row:SetHeight(height)
    row.bg:SetColorTexture(ar, ag, ab, 0)
    row.divider:SetColorTexture(ar, ag, ab, 0.28)
    row.divider:Show()
    row.bgR, row.bgG, row.bgB, row.baseAlpha = ar, ag, ab, 0 -- what hovering returns to
    row.onClick = onClick
    row.tooltip = nil
    row:EnableMouse(onClick ~= nil)

    return height
end

-- ---------- Chat linking ----------
-- ChatEdit_InsertLink is what the default UI itself uses for shift-click:
-- it inserts at the cursor in whatever chat box is already open (or opens
-- one if none is), rather than replacing anything already typed there.
local function InsertItemLink(item)
    if item.id then
        local name, link = C_Item.GetItemInfo(item.id)
        if link then
            ChatEdit_InsertLink(link)
            return
        elseif C_Item and C_Item.RequestLoadItemDataByID then
            C_Item.RequestLoadItemDataByID(item.id)
        end
    end
    ChatEdit_InsertLink("[" .. item.name .. "]")
end

-- Rows that hold an item (row.rowItem = { id, name }): its tooltip, and the panel rows'
-- Shift-click to link and Ctrl-click to try on (not in combat).
function PF.RowItemEnter(row)
    local item = row.rowItem
    if not (item and item.id) then return end
    GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
    GameTooltip:SetItemByID(item.id)
    GameTooltip:Show()
end
function PF.RowItemClick(row)
    local item = row.rowItem
    if not (item and item.id) then return false end
    if IsShiftKeyDown() then
        InsertItemLink(item)
        return true
    elseif IsControlKeyDown() then
        if not InCombatLockdown() then
            local _, link = C_Item.GetItemInfo(item.id)
            if link and DressUpItemLink then DressUpItemLink(link) end
        end
        return true
    end
    return false
end

local function InsertQuestLink(q)
    if q.id then
        ChatEdit_InsertLink(string.format("|cffffff00|Hquest:%d:1|h[%s]|h|r", q.id, q.name))
    else
        ChatEdit_InsertLink("[" .. q.name .. "]")
    end
end

-- "Warlock", or "Warrior, Paladin": the game's own class names for a quest's
-- class tokens (see PF:IsQuestForPlayer), or nil for a quest open to all.
local function ClassName(token)
    local names = LOCALIZED_CLASS_NAMES_MALE
    return (names and names[token]) or (token:sub(1, 1) .. token:sub(2):lower())
end

local function QuestClassNames(class)
    if not class then return nil end
    if type(class) == "string" then return ClassName(class) end
    local out = {}
    for i = 1, #class do out[i] = ClassName(class[i]) end
    return table.concat(out, ", ")
end

-- ---------- Side panel lookups ----------
-- Finds the reward-loot group tied to a specific quest, if any, filtered
-- to what this character's faction can actually see.
local function FindQuestRewardItems(d, q)
    if not d or not d.lootGroups then return nil end
    local playerFaction = UnitFactionGroup("player")
    for _, group in ipairs(d.lootGroups) do
        if group.kind == "quest" and group.title == q.name then
            if not group.faction or group.faction == playerFaction then
                return group.items
            end
        end
    end
    return nil
end

-- ---------- Map pin ----------
-- Least-verified part of the addon: it can only really be checked in the
-- client. Two rules keep it from ever triggering Blizzard's "Interface
-- action failed because of an AddOn" warning:
--   0. PathForever never opens the world map or changes its zone (see
--      ShowQuestOnMap); the player opens it.
--   1. Nothing map-related is touched during combat lockdown. The pin is
--      parented/anchored to the world map's canvas, and moving frames tied
--      to Blizzard UI mid-combat is exactly what gets blocked.
--   2. Updates run on a throttled timer (not every frame) and only
--      re-anchor when the canvas size or target actually changed.
-- A plain colored diamond is used instead of a named texture so it can't
-- silently fail to load.
local mapPin = nil
local mapDriver = nil
local activePinSubject = nil
local mapSawShown = false

local function GetMapPin()
    if mapPin then return mapPin end
    local canvas = WorldMapFrame:GetCanvas()
    local pin = CreateFrame("Frame", "PathForeverMapPin", canvas)
    pin:SetSize(26, 26)
    pin:SetFrameStrata("FULLSCREEN_DIALOG")
    pin:SetFrameLevel(canvas:GetFrameLevel() + 50)

    -- Outline sits BEHIND and slightly larger than the fill so it reads as
    -- a border (higher sublevel draws on top within the same layer).
    local border = pin:CreateTexture(nil, "OVERLAY", nil, -1)
    border:SetPoint("TOPLEFT", -3, 3)
    border:SetPoint("BOTTOMRIGHT", 3, -3)
    border:SetColorTexture(0.05, 0.05, 0.06, 1)
    border:SetRotation(math.pi / 4)

    local tex = pin:CreateTexture(nil, "OVERLAY", nil, 0)
    tex:SetAllPoints()
    tex:SetColorTexture(1, 0.82, 0, 1)
    tex:SetRotation(math.pi / 4)

    -- Slow pulse so it stands out against a busy map background.
    local anim = pin:CreateAnimationGroup()
    anim:SetLooping("BOUNCE")
    local pulse = anim:CreateAnimation("Scale")
    pulse:SetScale(1.25, 1.25)
    pulse:SetDuration(0.6)
    pulse:SetSmoothing("IN_OUT")
    anim:Play()
    pin.anim = anim

    pin:EnableMouse(true)
    pin:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText or "Quest location")
        GameTooltip:Show()
    end)
    pin:SetScript("OnLeave", function() GameTooltip:Hide() end)

    pin:Hide()
    mapPin = pin
    return pin
end

local function ClearMapPin()
    activePinSubject = nil
    mapSawShown = false
    if mapPin then
        mapPin:Hide()
        mapPin.lastW, mapPin.lastH, mapPin.lastSubject = nil, nil, nil
    end
    if mapDriver then mapDriver:Hide() end
end

local function UpdateMapPin()
    local pin, subject = mapPin, activePinSubject
    if not pin or not subject then return end
    if InCombatLockdown() then return end -- see rule 1 above

    if not WorldMapFrame or not WorldMapFrame:IsShown() then
        -- The map was open and has since been closed: drop the pin so it
        -- doesn't ambush you the next time you open the map for something else.
        if mapSawShown then ClearMapPin() end
        return
    end
    mapSawShown = true

    -- Only meaningful on the map these coordinates belong to.
    if WorldMapFrame:GetMapID() ~= subject.mapID then
        if pin:IsShown() then pin:Hide() end
        return
    end

    local canvas = WorldMapFrame:GetCanvas()
    if not canvas then return end
    local w, h = canvas:GetSize()
    if not w or w <= 0 or not h or h <= 0 then return end

    if not pin:IsShown() then pin:Show() end
    if pin.lastW ~= w or pin.lastH ~= h or pin.lastSubject ~= subject then
        pin:ClearAllPoints()
        pin:SetPoint("CENTER", canvas, "TOPLEFT", subject.x * w, -subject.y * h)
        pin.lastW, pin.lastH, pin.lastSubject = w, h, subject
    end
end

local function EnsureMapDriver()
    if mapDriver then return end
    mapDriver = CreateFrame("Frame")
    local sinceLast = 0
    mapDriver:SetScript("OnUpdate", function(_, elapsed)
        sinceLast = sinceLast + elapsed
        if sinceLast < 0.05 then return end
        sinceLast = 0
        UpdateMapPin()
    end)
end

-- Marks the quest's spot. PathForever never opens or changes the world map
-- itself: OpenWorldMap / SetMapID from addon code makes the map's own pin
-- updates run as PathForever, and the next one in combat was blocked
-- ("Button:SetPassThroughButtons()" x12, seen in game 2026-10-02).
-- Instead it sets the game's own map pin (the one Ctrl-click or /way sets;
-- a plain C API request, so nothing of Blizzard's runs as PathForever, and
-- it's fine in combat), tracks it, prints the game's map pin link, and out
-- of combat opens the map on that zone with C_Map.OpenWorldMap.
-- Forever has map pins (checked in game 2026-10-02). Without them, the old
-- pin below is the fallback, seen when the player opens the map there.
local function MapName(mapID)
    if C_Map and C_Map.GetMapInfo then
        local ok, info = pcall(C_Map.GetMapInfo, mapID)
        if ok and info and info.name then return info.name end
    end
end

local function SetGamePin(subject)
    if not (C_Map and C_Map.SetUserWaypoint and C_Map.GetUserWaypointHyperlink and UiMapPoint) then return nil end
    if C_Map.CanSetUserWaypointOnMap then
        local ok, can = pcall(C_Map.CanSetUserWaypointOnMap, subject.mapID)
        if not ok or not can then return nil end
    end
    local ok = pcall(function()
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(subject.mapID, subject.x, subject.y))
    end)
    if not ok then return nil end
    if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
        pcall(C_SuperTrack.SetSuperTrackedUserWaypoint, true)
    end
    local okLink, link = pcall(C_Map.GetUserWaypointHyperlink)
    return okLink and link or ""
end

local function ShowQuestOnMap(subject)
    if not subject.mapID or not subject.x or not subject.y then return end
    local zone = MapName(subject.mapID) or subject.pickupZone
    local where = zone and (" of " .. zone) or ""

    local link = SetGamePin(subject)
    if link then
        print("|cff3fc7ebPathForever:|r Marked on your map" .. where .. ". " .. link)
        -- C_Map.OpenWorldMap is the client's own way to open the map, unlike the
        -- interface's OpenWorldMap that caused the blocked actions: tested in game
        -- 2026-10-02 (opened on other zones, then fights, map opened in combat)
        -- with no blocked actions. Still never in combat.
        if not InCombatLockdown() and C_Map.OpenWorldMap then
            pcall(C_Map.OpenWorldMap, subject.mapID)
        end
        return
    end

    if not WorldMapFrame then return end
    print("|cff3fc7ebPathForever:|r Marked on your map" .. where .. ".")
    GetMapPin().tooltipText = subject.pickup or subject.name
    activePinSubject = subject
    mapSawShown = false
    EnsureMapDriver()
    mapDriver:Show()
    UpdateMapPin()
end

-- ---------- Side panel (quests and bosses share this) ----------
local function AcquirePanelItemRow(panel)
    local row = table.remove(panel.itemRowPool)
    if not row then
        row = CreateFrame("Button", nil, panel.scrollChild)
        row:SetHeight(38)

        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(24, 24)
        row.icon:SetPoint("TOPLEFT", 0, 0)
        row.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        -- Name and slot are positioned by LayoutPanelItem.
        row.name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.name:SetJustifyH("LEFT")

        row.slot = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.slot:SetJustifyH("LEFT")

        -- Installed once; they act on whichever item LayoutPanelItem put in row.item.
        row:SetScript("OnMouseUp", function(self)
            local item = self.item
            if not item then return end
            if IsShiftKeyDown() then
                InsertItemLink(item)
            elseif IsControlKeyDown() and item.id and not InCombatLockdown() then
                -- (No dressing-room previews mid-combat: opening Blizzard UI
                -- panels from addon code during lockdown gets blocked.)
                local _, link = C_Item.GetItemInfo(item.id)
                if link and DressUpItemLink then
                    DressUpItemLink(link)
                end
            end
        end)
        -- The wishlist star (boss loot only): a star to add the item, gold once it is
        -- on the list, a green check once the character has it.
        local star = CreateFrame("Button", nil, row)
        star:SetSize(18, 18)
        star:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, 0)
        star.tex = star:CreateTexture(nil, "OVERLAY")
        star.tex:SetAllPoints()
        star.fallback = star:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        star.fallback:SetPoint("CENTER", 0, -3)
        star.fallback:SetText("*")
        star:SetScript("OnClick", function(self)
            local r = self:GetParent()
            local item = r.item
            if not (item and item.id and r.wishBoss) then return end
            local had = PF:GetWish(item.id)
            if had and had.got then return end -- received: nothing to take back
            PF:ToggleWish(item, r.wishDungeon, r.wishBoss)
            PF.UpdateWishStar(r)
            PlayUISound(PF:GetWish(item.id) and "IG_MAINMENU_OPTION_CHECKBOX_ON" or "IG_MAINMENU_OPTION_CHECKBOX_OFF")
            if self:IsMouseOver() then self:GetScript("OnEnter")(self) end
        end)
        star:SetScript("OnEnter", function(self)
            local r = self:GetParent()
            local e = r.item and r.item.id and PF:GetWish(r.item.id)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if e and e.got then
                GameTooltip:SetText("You have this item", 0.45, 0.8, 0.45)
                GameTooltip:AddLine("It was on your wishlist.", 0.6, 0.6, 0.6)
            elseif e then
                GameTooltip:SetText("On your wishlist", 1, 0.82, 0)
                GameTooltip:AddLine("Click to take it off.", 0.6, 0.6, 0.6)
            else
                GameTooltip:SetText("Add to your wishlist", 1, 1, 1)
                GameTooltip:AddLine("PathForever tells you when you get it.", 0.6, 0.6, 0.6)
            end
            GameTooltip:Show()
        end)
        star:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row.star = star
        row.glow = CreateGlow(row, "LEFT", 0.18)
        row:SetScript("OnEnter", function(self)
            local item = self.item
            if not item then return end
            self.glow:Show()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if item.id then
                GameTooltip:SetItemByID(item.id)
            else
                GameTooltip:SetText(item.name, 1, 1, 1)
                if item.slot and item.slot ~= "" then GameTooltip:AddLine(item.slot, 0.6, 0.6, 0.6) end
                GameTooltip:AddLine("Full details aren't available for this item yet.", 0.6, 0.6, 0.6, true)
            end
            GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function(self) self.glow:Hide(); GameTooltip:Hide() end)
    end
    row:Show()
    table.insert(panel.itemRows, row)
    return row
end

local function ReleasePanelItemRows(panel)
    for _, row in ipairs(panel.itemRows) do
        row:Hide()
        row:ClearAllPoints()
        row:EnableMouse(false)
        row.item, row.wishBoss, row.wishDungeon = nil, nil, nil
        if row.star then row.star:Hide() end
        table.insert(panel.itemRowPool, row)
    end
    wipe(panel.itemRows)
end

-- The star's look: off (faint star), on (gold), received (green check).
do
local STAR_ON, STAR_OFF = "auctionhouse-icon-favorite", "auctionhouse-icon-favorite-off"
local CHECK = "Interface\\RaidFrame\\ReadyCheck-Ready"
local function HasAtlas(name)
    return C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(name) ~= nil
end
function PF.UpdateWishStar(row)
    local star = row.star
    if not star then return end
    if not (row.wishBoss and row.item and row.item.id) then star:Hide() return end
    local e = PF:GetWish(row.item.id)
    star.fallback:Hide()
    star.tex:SetDesaturated(false)
    star.tex:SetVertexColor(1, 1, 1)
    if e and e.got then
        star.tex:SetTexture(CHECK)
        star.tex:SetTexCoord(0, 1, 0, 1)
    elseif HasAtlas(e and STAR_ON or STAR_OFF) then
        star.tex:SetAtlas(e and STAR_ON or STAR_OFF)
        star.tex:SetTexCoord(0, 1, 0, 1)
        if not e then star.tex:SetAlpha(0.6) end
    else
        star.tex:SetTexture(nil)
        star.fallback:SetText("*")
        if e then star.fallback:SetTextColor(1, 0.82, 0) else star.fallback:SetTextColor(0.5, 0.5, 0.5) end
        star.fallback:Show()
    end
    if e then star.tex:SetAlpha(1) end
    star:Show()
end
end

local function LayoutPanelItem(panel, row, y, item)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", panel.scrollChild, "TOPLEFT", PANEL_PAD, -y)
    row:SetWidth(PANEL_CW)

    -- A few items have no name on file (the Journey's class quest rewards); the
    -- game's own name fills in once the item loads, which redraws the panel.
    local itemName = item.name or (item.id and C_Item.GetItemInfo(item.id)) or RETRIEVING_ITEM_INFO or "Retrieving item information"
    local nameText = item.dropPct and string.format("%s  (%d%%)", itemName, item.dropPct) or itemName
    local quality
    if item.id then
        panelItemIDs[item.id] = true
        local _, _, itemQuality = C_Item.GetItemInfo(item.id)
        quality = itemQuality
        -- Not cached yet: ask the client for it ONCE per session, and recolor
        -- when GET_ITEM_INFO_RECEIVED reports it (see PF:RefreshSidePanel).
        -- Asking again on every refresh would loop forever for items the
        -- client never loads (undiscovered beta items).
        if not quality and C_Item.RequestLoadItemDataByID and not requestedItemData[item.id] then
            requestedItemData[item.id] = true
            C_Item.RequestLoadItemDataByID(item.id)
        end
    end

    -- Name and slot sit to the right of the 24px icon, with explicit widths so
    -- a long item name wraps instead of being cut off.
    local textWidth = PANEL_CW - 32 - ((row.wishBoss and item.id) and 22 or 0)
    row.name:ClearAllPoints()
    row.name:SetPoint("TOPLEFT", row, "TOPLEFT", 32, -1)
    row.name:SetWidth(textWidth)
    local color = quality and ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[quality]
    if color then
        row.name:SetText(string.format("|cff%02x%02x%02x%s|r",
            math.floor(color.r * 255 + 0.5), math.floor(color.g * 255 + 0.5), math.floor(color.b * 255 + 0.5), nameText))
    else
        row.name:SetText(nameText)
    end
    local nameH = row.name:GetStringHeight() or 0

    row.slot:ClearAllPoints()
    row.slot:SetPoint("TOPLEFT", row, "TOPLEFT", 32, -(1 + nameH + 2))
    row.slot:SetWidth(textWidth)
    row.slot:SetText(item.slot or "")
    local slotH = row.slot:GetStringHeight() or 0

    local height = math.max(38, 1 + nameH + 2 + slotH)
    row:SetHeight(height)
    row.icon:SetTexture((item.id and C_Item.GetItemIconByID(item.id)) or ICON_UNKNOWN_ITEM)
    row.item = item
    PF.UpdateWishStar(row)
    row:EnableMouse(true)

    return height + 4
end

local panelReturn -- the Journey window (Gold, XP, Discover) this panel replaced, for Back
local function CreateSidePanel()
    local ar, ag, ab = GetAccentColor()
    local p = CreateFrame("Frame", "PathForeverSidePanel", frame, "BackdropTemplate")
    PF.Popouts:Init(frame)
    PF.Popouts:Attach(1, p, PANEL_WIDTH) -- popout 1, beside the main window
    StyleWindow(p)
    p.titleLine = { AddFadedLine(p, 34, 0, 0.4) }


    local close = CreateFrame("Button", nil, p)
    close:SetSize(24, 24)
    close:SetPoint("TOPRIGHT", -8, -8)
    local closeText = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    closeText:SetPoint("CENTER")
    closeText:SetText("\195\151")
    closeText:SetTextColor(unpack(COLOR_MUTED))
    close:SetScript("OnClick", function()
        if PF.Popouts and PF.Popouts:ClosePanel(p) then return end
        p:Hide(); panelReturn = nil; currentPanelSubject = nil; currentPanelDungeon = nil
    end)
    close:SetScript("OnEnter", function() closeText:SetTextColor(unpack(COLOR_TEXT)) end)
    close:SetScript("OnLeave", function() closeText:SetTextColor(unpack(COLOR_MUTED)) end)
    p.closeButton = close

    -- Back: shown when this panel took the place of the Journey's Gold, XP or Discover
    -- window (they share the right side); a click brings that window back.
    local back = CreateFrame("Button", nil, p)
    back:SetSize(44, 24)
    back:SetPoint("TOPRIGHT", close, "TOPLEFT", -2, 0)
    back.text = back:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    back.text:SetPoint("CENTER")
    back.text:SetText("Back")
    back.text:SetTextColor(unpack(COLOR_MUTED))
    back:SetScript("OnClick", function()
        -- the book list goes back to the library quest it was opened from
        local s = currentPanelSubject
        if s and s.backTo and PF.UI then
            PlayUISound("IG_CHARACTER_INFO_TAB")
            PF.UI.ShowQuestPanel(s.backTo, s.backDungeon)
            return
        end
        local id = panelReturn
        if not id or not PF.Journey then return end
        PlayUISound("IG_CHARACTER_INFO_TAB")
        if PathForeverDB.activeTab ~= "Journey" and PF.OpenTab then PF:OpenTab("Journey") end
        PF.Journey:OpenModule(id) -- the Journey's small window opens on the right and closes this panel
    end)
    back:SetScript("OnEnter", function(self) self.text:SetTextColor(unpack(COLOR_TEXT)) end)
    back:SetScript("OnLeave", function(self) self.text:SetTextColor(unpack(COLOR_MUTED)) end)
    back:Hide()
    p.back = back

    -- Everything below the close button scrolls, since some quests/bosses
    -- have enough reward items to run past the panel's fixed height.
    local scroll = CreateFrame("ScrollFrame", "PathForeverSidePanelScroll", p, "UIPanelScrollFrameTemplate")
    StyleScrollBar(scroll)
    scroll:SetPoint("TOPLEFT", 4, -36)
    scroll:SetPoint("BOTTOMRIGHT", -26, 12)

    local sc = CreateFrame("Frame", nil, scroll)
    sc:SetSize(PANEL_CHILD_WIDTH, 1)
    scroll:SetScrollChild(sc)
    p.scrollChild = sc

    -- Every element below is positioned by PopulateSidePanel.
    p.title = sc:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    p.title:SetJustifyH("LEFT")
    p.title:SetTextColor(unpack(COLOR_TEXT))

    -- FontStrings can't take clicks, so a transparent button sits over the
    -- title to catch the shift-click-to-link gesture (quest mode only).
    local titleButton = CreateFrame("Button", nil, sc)
    titleButton:SetScript("OnMouseUp", function()
        if currentPanelMode == "quest" and IsShiftKeyDown() and currentPanelSubject then
            InsertQuestLink(currentPanelSubject)
        end
    end)
    titleButton:SetScript("OnEnter", function(self)
        p.title:SetTextColor(1, 1, 1)
        if currentPanelMode == "quest" then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Shift-click to link this quest in chat")
            GameTooltip:Show()
        end
    end)
    titleButton:SetScript("OnLeave", function()
        p.title:SetTextColor(unpack(COLOR_TEXT))
        GameTooltip:Hide()
    end)
    p.titleButton = titleButton

    p.subtitle = sc:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.subtitle:SetJustifyH("LEFT")
    p.subtitle:SetTextColor(unpack(COLOR_MUTED))

    -- Quest status "pill": colored text on a faint tint of the same color.
    p.badge = CreateFrame("Frame", nil, sc)
    p.badge.bg = p.badge:CreateTexture(nil, "BACKGROUND")
    p.badge.bg:SetAllPoints()
    p.badge.text = p.badge:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.badge.text:SetPoint("CENTER")

    -- Quest facts as two aligned columns (labels, values) rather than one blob.
    p.statLabels = sc:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.statLabels:SetJustifyH("LEFT")
    p.statLabels:SetJustifyV("TOP")
    p.statLabels:SetTextColor(unpack(COLOR_MUTED))
    p.statValues = sc:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    p.statValues:SetJustifyH("LEFT")
    p.statValues:SetJustifyV("TOP")
    p.statValues:SetTextColor(unpack(COLOR_TEXT))

    -- a boss's kill count (red, under its dungeon) and its one-line tip (dim, last)
    p.killText = sc:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.killText:SetJustifyH("LEFT")
    p.tipText = sc:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    p.tipText:SetJustifyH("LEFT")
    p.emptyNote = sc:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    p.emptyNote:SetJustifyH("LEFT")

    -- The Wowhead link is one line, "Copy Wowhead link". Addons can't write to
    -- the clipboard, so a click swaps that line for an edit box holding the
    -- link, already selected: Ctrl+C copies it and the line comes back saying
    -- so. Escape or clicking elsewhere puts the line back too.
    p.linkButton = CreateFrame("Button", nil, sc)
    p.linkButton:SetSize(200, 24)
    p.linkButton.text = p.linkButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.linkButton.text:SetPoint("TOPLEFT", 0, -6)
    p.linkButton.text:SetWidth(200)
    p.linkButton.text:SetJustifyH("CENTER")
    local function ResetLinkButton()
        p.linkButton.text:SetText("Copy Wowhead link")
        p.linkButton.text:SetTextColor(COLOR_GOLD[1], COLOR_GOLD[2], COLOR_GOLD[3])
    end
    ResetLinkButton()
    p.linkButton:SetScript("OnEnter", function() p.linkButton.text:SetTextColor(1, 1, 1) end)
    p.linkButton:SetScript("OnLeave", function() ResetLinkButton() end)
    StyleOutlineButton(p.linkButton) -- after its own scripts: SetScript would drop the hooks

    p.linkBox = CreateFrame("EditBox", nil, sc, "InputBoxTemplate")
    p.linkBox:SetSize(PANEL_CW - 10, 20)
    p.linkBox:SetAutoFocus(false)
    if GameFontHighlightSmall then p.linkBox:SetFontObject(GameFontHighlightSmall) end
    p.linkBox:Hide()
    p.linkBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    p.linkBox:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    p.linkBox:SetScript("OnEditFocusLost", function(self)
        self:HighlightText(0, 0)
        self:Hide()
        if p.linkButton.shouldShow then p.linkButton:Show() end
    end)
    p.linkBox:SetScript("OnKeyDown", function(self, key)
        if key == "C" and IsControlKeyDown() then
            -- let the copy happen first, then tidy up
            C_Timer.After(0, function()
                self:ClearFocus()
                p.linkButton.text:SetText("Link copied")
                p.linkButton.text:SetTextColor(COLOR_GOOD[1], COLOR_GOOD[2], COLOR_GOOD[3])
                C_Timer.After(2, ResetLinkButton)
            end)
        end
    end)
    p.linkBox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Press Ctrl+C to copy", 1, 1, 1)
        GameTooltip:Show()
    end)
    p.linkBox:SetScript("OnLeave", function() GameTooltip:Hide() end)
    p.linkButton:SetScript("OnClick", function(self)
        self:Hide()
        p.linkBox:SetText(p.linkURL or "")
        p.linkBox:SetCursorPosition(0)
        p.linkBox:Show()
        p.linkBox:SetFocus()
        p.linkBox:HighlightText()
    end)

    p.itemsHeader = sc:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.itemsHeader:SetJustifyH("LEFT")
    p.itemsHint = sc:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    p.itemsHint:SetJustifyH("LEFT")

    p.mapButton = CreateFrame("Button", nil, sc)
    p.mapButton:SetSize(200, 24)
    p.mapButton.bg = p.mapButton:CreateTexture(nil, "BACKGROUND")
    p.mapButton.bg:SetAllPoints()
    p.mapButton.bg:SetColorTexture(1, 1, 1, 0.06)
    p.mapButton.text = p.mapButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.mapButton.text:SetPoint("CENTER")
    p.mapButton.text:SetText("Mark on map")
    p.mapButton.text:SetTextColor(unpack(COLOR_TEXT))
    StyleOutlineButton(p.mapButton)
    p.mapButton:SetScript("OnClick", function()
        if currentPanelSubject then ShowQuestOnMap(currentPanelSubject) end
    end)

    -- Where a quest ends, when that is somewhere else with a spot on file (the
    -- Sleeping Bag steps): the same button under the "Ends" section.
    p.endMapButton = CreateFrame("Button", nil, sc)
    p.endMapButton:SetSize(200, 24)
    p.endMapButton.bg = p.endMapButton:CreateTexture(nil, "BACKGROUND")
    p.endMapButton.bg:SetAllPoints()
    p.endMapButton.bg:SetColorTexture(1, 1, 1, 0.06)
    p.endMapButton.text = p.endMapButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.endMapButton.text:SetPoint("CENTER")
    p.endMapButton.text:SetText("Mark on map")
    p.endMapButton.text:SetTextColor(unpack(COLOR_TEXT))
    StyleOutlineButton(p.endMapButton)
    p.endSubject = {}
    p.endMapButton:SetScript("OnClick", function()
        local s, e = currentPanelSubject, p.endSubject
        if not (s and s.endMapID and s.endX and s.endY) then return end
        e.name, e.pickup, e.pickupZone = s.name, s.turnin, s.turninZone
        e.mapID, e.x, e.y = s.endMapID, s.endX, s.endY
        ShowQuestOnMap(e)
    end)

    -- On a library quest: every book for the faction, in this panel (Back returns)
    p.booksButton = CreateFrame("Button", nil, sc)
    p.booksButton:SetSize(200, 24)
    p.booksButton.text = p.booksButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.booksButton.text:SetPoint("CENTER")
    p.booksButton.text:SetText("See book locations")
    p.booksButton.text:SetTextColor(unpack(COLOR_TEXT))
    StyleOutlineButton(p.booksButton)
    p.booksButton:SetScript("OnClick", function()
        local q, d = currentPanelSubject, currentPanelDungeon
        local books = PF.Journey and PF.Journey.LibraryBooks and PF.Journey:LibraryBooks()
        if not (books and PF.UI) then return end
        books.backTo, books.backDungeon = q, d
        PlayUISound("IG_QUEST_LIST_SELECT")
        PF.UI.ShowBooks(books)
    end)
    p.booksButton:Hide()

    -- The zone guide: the zone on the world map (the Zones card's old click)
    p.zoneButton = CreateFrame("Button", nil, sc)
    p.zoneButton:SetSize(200, 24)
    p.zoneButton.text = p.zoneButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.zoneButton.text:SetPoint("CENTER")
    p.zoneButton.text:SetText("Open on map")
    p.zoneButton.text:SetTextColor(unpack(COLOR_TEXT))
    StyleOutlineButton(p.zoneButton)
    p.zoneButton:SetScript("OnClick", function()
        local z = currentPanelSubject
        if z and z.zone and PF.Journey and PF.Journey.OpenZoneMap then PF.Journey.OpenZoneMap(z.zone) end
    end)
    p.zoneButton:Hide()

    p.sectionPool = {}
    p.sectionsUsed = 0
    p.itemRows = {}
    p.itemRowPool = {}
    p.stepRows = {}
    p.stepRowsUsed = 0

    p:Hide()
    return p
end

local function HideSidePanel()
    if sidePanel then sidePanel:Hide() end
    panelReturn = nil
    currentPanelSubject = nil
    currentPanelMode = nil
    currentPanelDungeon = nil
end

local function ReleasePanelSections(panel)
    for _, s in ipairs(panel.sectionPool) do
        s.header:Hide()
        s.body:Hide()
        for _, seg in ipairs(s.segs or {}) do seg.fs:Hide() seg.dot:Hide() end
    end
    panel.sectionsUsed = 0
end

-- Lines that start with " - " are bullets: a small square at the left and the text in its own
-- column, so a wrapped line stays under its own text. Returns the height used.
local BULLET_INDENT = 12
PF.BULLET_PIXELS = 5
function PF.PixelUnit(frame)
    local px = 1
    local es = frame and frame.GetEffectiveScale and frame:GetEffectiveScale()
    local ph = GetPhysicalScreenHeight and GetPhysicalScreenHeight()
    if es and es > 0 and ph and ph > 0 then px = 768 / ph / es end
    return px
end
local function PlaceBullets(panel, s, y, body)
    s.segs = s.segs or {}
    local used, top = 0, y
    local function Seg()
        used = used + 1
        local seg = s.segs[used]
        if not seg then
            seg = { fs = panel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight"),
                    dot = panel.scrollChild:CreateTexture(nil, "OVERLAY") }
            seg.fs:SetJustifyH("LEFT")
            s.segs[used] = seg
        end
        return seg
    end
    local plain = {}
    local function Flush()
        if #plain == 0 then return end
        local seg = Seg()
        seg.dot:Hide()
        seg.fs:SetTextColor(unpack(COLOR_TEXT))
        seg.fs:ClearAllPoints()
        seg.fs:SetPoint("TOPLEFT", panel.scrollChild, "TOPLEFT", PANEL_PAD, -y)
        seg.fs:SetWidth(PANEL_CW)
        seg.fs:SetText(table.concat(plain, "\n"))
        seg.fs:Show()
        y = y + (seg.fs:GetStringHeight() or 0) + 4
        wipe(plain)
    end
    for line in (body .. "\n"):gmatch("(.-)\n") do
        local item = line:match("^%s*%- (.*)$")
        if item then
            Flush()
            local seg = Seg()
            seg.fs:SetTextColor(unpack(COLOR_TEXT))
            seg.fs:ClearAllPoints()
            seg.fs:SetPoint("TOPLEFT", panel.scrollChild, "TOPLEFT", PANEL_PAD + BULLET_INDENT, -y)
            seg.fs:SetWidth(PANEL_CW - BULLET_INDENT)
            seg.fs:SetText(item)
            seg.fs:Show()
            local ar, ag, ab = GetAccentColor()
            seg.dot:SetColorTexture(ar, ag, ab, 1)
            -- a square of whole screen pixels, its edges on whole pixels, centred on the first line
            local _, fh = seg.fs:GetFont()
            local px = PF.PixelUnit(panel.scrollChild)
            local n = PF.BULLET_PIXELS
            seg.dot:SetSize(n * px, n * px)
            seg.dot:ClearAllPoints()
            seg.dot:SetPoint("TOPLEFT", panel.scrollChild, "TOPLEFT",
                math.floor((PANEL_PAD + 2) / px + 0.5) * px,
                -(math.floor((y + (tonumber(fh) or 12) / 2) / px + 0.5) - math.floor(n / 2)) * px)
            seg.dot:Show()
            y = y + (seg.fs:GetStringHeight() or 0) + 4
        else
            plain[#plain + 1] = line
        end
    end
    Flush()
    for i = used + 1, #s.segs do s.segs[i].fs:Hide() s.segs[i].dot:Hide() end
    return y - 4 - top
end

-- Puts `fs` at the panel's left edge at y, at the panel's text width, and
-- returns its measured height (0 for empty text).
local function PlacePanelText(panel, fs, y, text)
    fs:ClearAllPoints()
    fs:SetPoint("TOPLEFT", panel.scrollChild, "TOPLEFT", PANEL_PAD, -y)
    fs:SetWidth(PANEL_CW)
    fs:SetText(text)
    fs:Show()
    local h = fs:GetStringHeight() or 0
    return h
end

-- A small accent-colored label with body text under it (body may be nil for a
-- header-only section). Returns the y where whatever comes next should start.
local function AddPanelSection(panel, y, headerText, body, gapAfter)
    panel.sectionsUsed = panel.sectionsUsed + 1
    local s = panel.sectionPool[panel.sectionsUsed]
    if not s then
        s = {
            header = panel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"),
            body = panel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight"),
        }
        s.header:SetJustifyH("LEFT")
        s.body:SetJustifyH("LEFT")
        panel.sectionPool[panel.sectionsUsed] = s
    end
    local ar, ag, ab = GetAccentColor()
    s.header:SetTextColor(ar, ag, ab)
    y = y + PlacePanelText(panel, s.header, y, string.upper(headerText)) + 4
    if body and body ~= "" then
        if body:find("\n%s*%- ") or body:find("^%s*%- ") then
            s.body:Hide()
            y = y + PlaceBullets(panel, s, y, body)
        else
            for _, seg in ipairs(s.segs or {}) do seg.fs:Hide() seg.dot:Hide() end
            s.body:SetTextColor(unpack(COLOR_TEXT))
            y = y + PlacePanelText(panel, s.body, y, body)
        end
    else
        for _, seg in ipairs(s.segs or {}) do seg.fs:Hide() seg.dot:Hide() end
        s.body:Hide()
    end
    return y + (gapAfter or 14)
end

-- ---------- A chain's steps in the side panel ----------
-- One pooled row per step (subject.chainSteps, from the Journey's class quests): the
-- game's quest icon for its state, the name, its level; clicking one opens that step.
-- The step on show is highlighted. The script is installed once and reads row.step.
local STEP_ICONS = {
    completed = "Interface\\RaidFrame\\ReadyCheck-Ready",
    inprogress = "Interface\\GossipFrame\\IncompleteQuestIcon",
    available = "Interface\\GossipFrame\\AvailableQuestIcon",
    unavailable = "Interface\\GossipFrame\\AvailableQuestIcon",
    later = "Interface\\GossipFrame\\AvailableQuestIcon",
}
local STEP_INDENT, STEP_ICON, STEP_LEVEL_W = 12, 14, 40
local ShowSidePanel -- below

local function StepRowOnClick(self)
    local step = self.step
    if step and step.onClick then
        -- the zone guide's rows: a dungeon or a class quest, each opening its own way
        PlayUISound("IG_QUEST_LIST_SELECT")
        step.onClick()
    elseif step and step.q ~= currentPanelSubject then
        PlayUISound("IG_QUEST_LIST_SELECT")
        ShowSidePanel("quest", step.q, currentPanelDungeon)
    end
end
local function StepRowOnEnter(self) self.hl:Show() end
local function StepRowOnLeave(self) self.hl:Hide() end

local function AcquireStepRow(p)
    p.stepRowsUsed = p.stepRowsUsed + 1
    local row = p.stepRows[p.stepRowsUsed]
    if not row then
        row = CreateFrame("Button", nil, p.scrollChild)
        row.hl = CreateGlow(row, "LEFT", 0.20)
        row.current = CreateGlow(row, "LEFT", 0.34, "BACKGROUND", 0)
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(STEP_ICON, STEP_ICON)
        row.name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.name:SetJustifyH("LEFT")
        row.level = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.level:SetJustifyH("RIGHT")
        row:SetScript("OnClick", StepRowOnClick)
        row:SetScript("OnEnter", StepRowOnEnter)
        row:SetScript("OnLeave", StepRowOnLeave)
        p.stepRows[p.stepRowsUsed] = row
    end
    return row
end

-- ---------- The library's book list ----------
-- One pooled row per book: a book icon (the ready-check tick once it's handed in), its
-- name, what it's in with the coordinates and a tip; a click puts the game's map pin
-- on it (ShowQuestOnMap), and the picked one stays lit. Books come grouped by zone.
local BookRows = {}
do
local BOOK_ICON = "Interface\\Icons\\INV_Misc_Book_09"
local BOOK_HELD_ICON = "Interface\\GossipFrame\\ActiveQuestIcon" -- the game's "ready to turn in"
local function BookClick(self)
    local book = self.book
    if not (book and book.mapID) then return end
    PlayUISound("IG_QUEST_LIST_SELECT")
    ShowQuestOnMap(book)
    local p = self.panel
    for i = 1, (p.bookRowsUsed or 0) do p.bookRows[i].current:SetShown(p.bookRows[i] == self) end
end
local function BookEnter(self) self.hl:Show() end
local function BookLeave(self) self.hl:Hide() end
function BookRows.Release(p)
    for i = 1, (p.bookRowsUsed or 0) do
        p.bookRows[i]:Hide()
        p.bookRows[i].book = nil
    end
    p.bookRowsUsed = 0
end
local function Acquire(p)
    p.bookRows = p.bookRows or {}
    p.bookRowsUsed = (p.bookRowsUsed or 0) + 1
    local row = p.bookRows[p.bookRowsUsed]
    if not row then
        row = CreateFrame("Button", nil, p.scrollChild)
        row.hl = CreateGlow(row, "LEFT", 0.20)
        row.current = CreateGlow(row, "LEFT", 0.34, "BACKGROUND", 0)
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(16, 16)
        row.icon:SetPoint("TOPLEFT", row, "TOPLEFT", 2, -4)
        row.name = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.name:SetJustifyH("LEFT")
        row.sub = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        row.sub:SetJustifyH("LEFT")
        row:SetScript("OnClick", BookClick)
        row:SetScript("OnEnter", BookEnter)
        row:SetScript("OnLeave", BookLeave)
        row.panel = p -- (its parent is the scroll child; the rows are kept on the panel)
        p.bookRows[p.bookRowsUsed] = row
    end
    return row
end
local function Layout(p, row, y, book)
    row.book = book
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
    -- handed in: the tick; picked up: the game's "ready to turn in" mark; else a book
    row.icon:SetTexture(book.done and STEP_ICONS.completed or (book.held and BOOK_HELD_ICON) or BOOK_ICON)
    row.name:ClearAllPoints()
    row.name:SetPoint("TOPLEFT", row, "TOPLEFT", 24, -3)
    row.name:SetWidth(PANEL_CW - 24)
    row.name:SetText(book.name)
    local c = book.done and COLOR_MUTED or (book.held and COLOR_WARN) or COLOR_GOLD
    row.name:SetTextColor(c[1], c[2], c[3])
    local sub = book.container .. "  -  " .. (book.section ~= book.zone and (book.zone .. " ") or "") .. book.coords
    if book.note then sub = sub .. "\n" .. book.note end
    if book.done then sub = sub .. "\nHanded in"
    elseif book.held then sub = sub .. "\nPicked up - hand it in to " .. (book.librarian or "the librarian") end
    local nameH = row.name:GetStringHeight() or 12
    row.sub:ClearAllPoints()
    row.sub:SetPoint("TOPLEFT", row, "TOPLEFT", 24, -(3 + nameH + 2))
    row.sub:SetWidth(PANEL_CW - 24)
    row.sub:SetText(sub)
    local h = 3 + nameH + 2 + (row.sub:GetStringHeight() or 10) + 6
    row:SetSize(PANEL_CW, h)
    row.hl:Hide()
    row.current:Hide()
    row:EnableMouse(book.mapID ~= nil)
    row:Show()
    return h
end
-- the whole list from y, a header per zone; returns the y after it
function BookRows.LayoutAll(p, y, books)
    local section
    for _, book in ipairs(books) do
        if book.section ~= section then
            section = book.section
            y = AddPanelSection(p, y, section, nil, 2)
        end
        y = y + Layout(p, Acquire(p), y, book)
    end
    if #books == 0 then y = y + PlacePanelText(p, p.emptyNote, y, "No book locations known yet.") + 14 end
    return y + 10
end
-- a few books under a header of the caller's (the zone guide)
function BookRows.LayoutPlain(p, y, books)
    for _, book in ipairs(books) do y = y + Layout(p, Acquire(p), y, book) end
    return y
end
end -- do (BookRows)

-- the zone guide's lists of step rows: the subject's field, and its header
local ZONE_STEP_SECTIONS = { { "dungeons", "Dungeons" }, { "quests", "Class quests" } }

local function ReleaseStepRows(p)
    for i = 1, p.stepRowsUsed do
        p.stepRows[i]:Hide()
        p.stepRows[i].step = nil
    end
    p.stepRowsUsed = 0
end

-- Lays out one step at y and returns the height it took.
local function LayoutStepRow(p, row, y, step, isCurrent, partOf)
    local x = (step.depth or 0) * STEP_INDENT
    row.step = step
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
    row.icon:ClearAllPoints()
    row.icon:SetPoint("TOPLEFT", row, "TOPLEFT", x, -3)
    row.icon:SetTexture(STEP_ICONS[step.status] or STEP_ICONS.later)
    row.icon:SetDesaturated(step.status == "unavailable" or step.status == "later")
    local nameW = PANEL_CW - x - STEP_ICON - 6 - STEP_LEVEL_W
    row.name:ClearAllPoints()
    row.name:SetPoint("TOPLEFT", row, "TOPLEFT", x + STEP_ICON + 6, -2)
    row.name:SetWidth(nameW)
    row.name:SetText(partOf and (step.q.name .. ", part " .. partOf) or step.q.name)
    local muted = step.status == "completed" or step.status == "unavailable" or step.status == "later"
    local c = muted and COLOR_MUTED or (step.status == "inprogress" and COLOR_WARN or COLOR_GOLD)
    row.name:SetTextColor(c[1], c[2], c[3])
    row.level:ClearAllPoints()
    row.level:SetPoint("TOPLEFT", row, "TOPLEFT", PANEL_CW - STEP_LEVEL_W, -3)
    row.level:SetWidth(STEP_LEVEL_W)
    row.level:SetText(step.q.requires and ("Lv " .. step.q.requires) or "")
    row.level:SetTextColor(unpack(COLOR_MUTED))
    if isCurrent then
        local ar, ag, ab = GetAccentColor()
        row.current:Show()
    else
        row.current:Hide()
    end
    local h = math.max(row.name:GetStringHeight() or 0, STEP_ICON) + 6
    row:SetSize(PANEL_CW, h)
    row:Show()
    return h
end

-- A dungeon quest's chain (Data.lua's QuestChains, from Wowhead's series boxes) as
-- steps for the list above: the dungeon's own quest table for a step that's one of
-- its quests (full details), else a bare { name, id } (status and Wowhead link). A
-- row of several quests is one step done any of those ways.
local chainIndex        -- questID -> its chain
local bareQuests = {}   -- questID -> the bare table for a quest not in this dungeon
function PF:ChainOf(questID)
    local chains = PathForeverData.QuestChains
    if not (chains and questID) then return nil end
    if not chainIndex then
        chainIndex = {}
        for _, chain in ipairs(chains) do
            for _, row in ipairs(chain) do
                for _, q in ipairs(row) do chainIndex[q[1]] = chain end
            end
        end
    end
    return chainIndex[questID]
end

-- Whether quest q is a step of a chain the player hasn't reached yet in this
-- dungeon's list: an earlier step of the same chain that is also one of the
-- dungeon's quests is still not done. The list shows only the step the player is
-- on; the Chain section of the side panel still lists every step. Allocates nothing.
function PF:IsLaterChainStep(q, d)
    local chain = q.id and self:ChainOf(q.id)
    if not chain or #chain < 2 then return false end
    for _, row in ipairs(chain) do
        local isQ = false
        for _, entry in ipairs(row) do
            if entry[1] == q.id then isQ = true break end
        end
        if isQ then return false end
        for _, entry in ipairs(row) do
            if not C_QuestLog.IsQuestFlaggedCompleted(entry[1]) then
                for _, dq in ipairs(d.quests or {}) do
                    if dq.id == entry[1] then return true end
                end
            end
        end
    end
    return false
end

local function DungeonChainSteps(subject, d)
    local chain = PF:ChainOf(subject.id)
    if not chain or #chain < 2 then return nil end
    local level = UnitLevel("player") or 1
    local steps, nextFound = {}, false
    for _, row in ipairs(chain) do
        local pick
        for _, entry in ipairs(row) do
            if entry[1] == subject.id or C_QuestLog.IsQuestFlaggedCompleted(entry[1]) or PF:IsQuestInLog(entry[1]) then pick = entry break end
        end
        pick = pick or row[1]
        local q
        if pick[1] == subject.id then q = subject end
        for _, dq in ipairs(not q and d and d.quests or {}) do
            if dq.id == pick[1] then q = dq break end
        end
        if not q then
            q = bareQuests[pick[1]]
            if not q then q = { name = pick[2], id = pick[1], requires = pick[3] }; bareQuests[pick[1]] = q end
        end
        local st
        if C_QuestLog.IsQuestFlaggedCompleted(pick[1]) then st = "completed"
        elseif PF:IsQuestInLog(pick[1]) then st = "inprogress"
        elseif not nextFound then
            nextFound = true
            st = (q.requires and q.requires > level) and "unavailable" or "available"
        else st = "later" end
        steps[#steps + 1] = { q = q, status = st, depth = 0 }
    end
    return steps
end

local function PopulateSidePanel(mode, subject, d)
    local p = sidePanel
    ReleasePanelItemRows(p)
    ReleasePanelSections(p)
    ReleaseStepRows(p)
    BookRows.Release(p)
    p.booksButton:Hide()
    p.zoneButton:Hide()
    wipe(panelItemIDs)
    local ar, ag, ab = GetAccentColor()
    local y = 16

    -- Title. (Explicit width: a long quest name wraps instead of being cut off.)
    local title = (mode == "quest") and subject.name or subject.title
    local titleH = math.max(PlacePanelText(p, p.title, y, title), 20)
    p.titleButton:ClearAllPoints()
    p.titleButton:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
    p.titleButton:SetSize(PANEL_CW, titleH)
    y = y + titleH + 4

    -- Subtitle: the dungeon, plus which faction and class can do the quest.
    local subtitle = d and d.name or subject.subtitle or ""
    if mode == "quest" and (subject.faction or subject.class) then
        local who = subject.faction
        local classes = QuestClassNames(subject.class)
        if classes then who = who and (who .. " " .. classes) or classes end
        subtitle = subtitle .. "\n" .. who .. " only"
    end
    if mode == "quest" and subject.part then
        subtitle = subtitle .. "\nPart " .. subject.part
    end
    if subtitle ~= "" then
        y = y + PlacePanelText(p, p.subtitle, y, subtitle) + 12
    else
        p.subtitle:Hide()
    end

    -- A boss: how many times this character has killed it, in red under the dungeon.
    p.killText:Hide()
    p.tipText:Hide()
    local killText = mode == "boss" and PF.BossKillText and PF:BossKillText(d, subject)
    if killText then
        p.killText:SetTextColor(unpack(COLOR_BAD))
        y = y + PlacePanelText(p, p.killText, y, killText) + 10
    end

    -- Everything only some modes use starts hidden; the branch below shows what applies.
    p.badge:Hide()
    p.statLabels:Hide()
    p.statValues:Hide()
    p.emptyNote:Hide()
    p.mapButton:Hide()
    p.mapButton.text:SetText("Mark on map")
    for _, mb in ipairs(p.markButtons or {}) do mb:Hide() end
    p.endMapButton:Hide()
    p.linkButton.shouldShow = false
    p.linkButton:Hide()
    p.linkBox:ClearFocus()
    p.linkBox:Hide()

    if mode == "quest" then
        -- Status pill, worded and colored like the quest's row. A quest with
        -- no ID on file can't be checked, so it gets no pill at all.
        local statusText, statusColor
        local status = PF:GetQuestStatus(subject, d)
        if status == "completed" then
            statusText, statusColor = "Done", COLOR_GOOD
        elseif status == "inprogress" and PF:IsQuestReadyToTurnIn(subject.id) then
            statusText, statusColor = "Ready to turn in", COLOR_GOLD
        elseif status == "inprogress" then
            statusText, statusColor = "In progress", COLOR_WARN
        elseif status == "available" then
            statusText, statusColor = "Available", COLOR_READY
        elseif status == "unavailable" then
            statusText, statusColor = "Available at level " .. PF:GetQuestRequiredLevel(subject, d), COLOR_MUTED
        end
        if statusText then
            p.badge.text:SetText(statusText)
            p.badge.text:SetTextColor(statusColor[1], statusColor[2], statusColor[3])
            p.badge.bg:SetColorTexture(statusColor[1], statusColor[2], statusColor[3], 0.18)
            p.badge:SetSize((p.badge.text:GetStringWidth() or 60) + 20, 22)
            p.badge:ClearAllPoints()
            p.badge:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
            p.badge:Show()
            y = y + 22 + 14
        end

        -- Quick facts, as two aligned columns
        local labels, values = {}, {}
        if subject.requires then labels[#labels + 1] = "Obtainable at"; values[#values + 1] = tostring(subject.requires) end
        if subject.level then labels[#labels + 1] = "Quest level"; values[#values + 1] = tostring(subject.level) end
        if subject.xp then labels[#labels + 1] = "XP"; values[#values + 1] = FormatNumber(subject.xp) end
        if #labels > 0 then
            local labelWidth = 112
            p.statLabels:ClearAllPoints()
            p.statLabels:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
            p.statLabels:SetWidth(labelWidth)
            p.statLabels:SetText(table.concat(labels, "\n"))
            p.statLabels:Show()
            p.statValues:ClearAllPoints()
            p.statValues:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD + labelWidth + 4, -y)
            p.statValues:SetWidth(PANEL_CW - labelWidth - 4)
            p.statValues:SetText(table.concat(values, "\n"))
            p.statValues:Show()
            local h = p.statLabels:GetStringHeight() or 0
            y = y + h + 16
        end

        -- Where it starts and ends
        local hasMap = subject.mapID and subject.x and subject.y
        local function PlaceMapButton()
            p.mapButton:ClearAllPoints()
            p.mapButton:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
            p.mapButton:Show()
            y = y + 24 + 14
        end
        if subject.library then
            -- a library quest: who takes the books, Mark on map, and the books under it
            y = AddPanelSection(p, y, "Turn in", subject.turnin, 8)
            if hasMap then PlaceMapButton(); y = y - 14 + 6 end
            p.booksButton:ClearAllPoints()
            p.booksButton:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
            p.booksButton:Show()
            y = y + 24 + 14
        elseif subject.pickup then
            y = AddPanelSection(p, y, "Starts", subject.pickup, hasMap and 8 or 14)
            if hasMap then PlaceMapButton() end
        elseif hasMap then
            PlaceMapButton()
        end
        if subject.turnin and not subject.library then
            local endMap = subject.endMapID and subject.endX and subject.endY
            y = AddPanelSection(p, y, "Ends", subject.turnin, endMap and 8 or 14)
            if endMap then
                p.endMapButton:ClearAllPoints()
                p.endMapButton:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
                p.endMapButton:Show()
                y = y + 24 + 14
            end
        end
        local chainSteps = subject.chainSteps or DungeonChainSteps(subject, d)
        if chainSteps then
            -- every step of the chain, this one highlighted; each opens its own panel
            y = AddPanelSection(p, y, "Chain", nil, 4)
            for n, step in ipairs(chainSteps) do
                -- steps that share a name are told apart by "part N of M"
                local partOf = step.q.part
                if not partOf then
                    local before, total = 0, 0
                    for m, other in ipairs(chainSteps) do
                        if other.q.name == step.q.name and not other.q.part then
                            total = total + 1
                            if m <= n then before = before + 1 end
                        end
                    end
                    if total > 1 then partOf = before .. " of " .. total end
                end
                y = y + LayoutStepRow(p, AcquireStepRow(p), y, step, step.q == subject, partOf)
            end
            y = y + 14
            -- a library quest: how many books are in
            if subject.library then
                local books = string.format("%d handed in", subject.handedIn or 0)
                if (subject.held or 0) > 0 then
                    books = books .. string.format("\n%d picked up: hand %s in to %s", subject.held,
                        subject.held == 1 and "it" or "them", subject.librarian or "the librarian")
                end
                y = AddPanelSection(p, y, "Books", books)
            end
        elseif subject.chainStart then
            local body = ColorHex(COLOR_TEXT) .. subject.chainStart.name .. "|r"
            if subject.chainStart.pickup then
                body = body .. "\n" .. ColorHex(COLOR_MUTED) .. subject.chainStart.pickup .. "|r"
            end
            y = AddPanelSection(p, y, "Chain starts with", body)
        end
        -- other versions of the same quest (the Journey's class quests): name and pickup
        if subject.orInstead then
            y = AddPanelSection(p, y, "Or instead", subject.orInstead)
        end
        if #labels == 0 and not subject.pickup and not subject.turnin and not subject.chainStart and not chainSteps then
            y = y + PlacePanelText(p, p.emptyNote, y, "No details for this quest yet.") + 14
        end

        -- "Copy Wowhead link": one line; the edit box takes its place when clicked.
        if subject.id then
            p.linkURL = "wowhead.com/forever/quest=" .. subject.id
            p.linkButton:ClearAllPoints()
            p.linkButton:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
            p.linkButton.shouldShow = true
            p.linkButton:Show()
            p.linkBox:ClearAllPoints()
            p.linkBox:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD + 6, -(y + 2))
            y = y + 24 + 14
        end
    end

    -- the profession and alt pop-outs: their sections, built when opened, each on
    -- its own group panel
    p.groups = p.groups or {}
    ResetGroupPanels(p.groups)
    if mode == "books" then y = BookRows.LayoutAll(p, y, subject.books) end
    if mode == "zone" then
        -- the zone guide (Journey.lua's Zones.Guide): what's here for this character
        p.zoneButton:ClearAllPoints()
        p.zoneButton:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
        p.zoneButton:Show()
        y = y + 24 + 14
        local any = false
        for _, sec in ipairs(ZONE_STEP_SECTIONS) do
            local steps = subject[sec[1]]
            if steps and #steps > 0 then
                any = true
                y = AddPanelSection(p, y, sec[2], nil, 4)
                for _, step in ipairs(steps) do y = y + LayoutStepRow(p, AcquireStepRow(p), y, step, false) end
                y = y + 14
            end
        end
        if subject.books and #subject.books > 0 then
            any = true
            y = AddPanelSection(p, y, "Library books", nil, 4)
            y = BookRows.LayoutPlain(p, y, subject.books) + 14
        end
        if subject.gathering then any = true; y = AddPanelSection(p, y, "Gathering", subject.gathering) end
        if subject.fishing then any = true; y = AddPanelSection(p, y, "Fishing", subject.fishing) end
        if not any then
            y = y + PlacePanelText(p, p.emptyNote, y, "Nothing on file for you here yet.") + 14
        end
    end
    if mode == "info" then
        for _, sec in ipairs(subject.sections) do
            local mapHere = sec[1] == (subject.mapSection or "Next rank") and subject.mapID and subject.x and subject.y
            local marks = subject.marks and subject.marks[sec[1]] -- { { label, mapID, x, y, pickup, pickupZone }, ... }
            local top = y
            y = AddPanelSection(p, y, sec[1], sec[2], (mapHere or marks) and 8 or 14)
            AddGroupPanel(p.groups, p.scrollChild, PANEL_PAD - 6, top - 6, PANEL_CW + 12, y - ((mapHere or marks) and 8 or 14) + 6)
            if marks then
                p.markButtons = p.markButtons or {}
                for i, mk in ipairs(marks) do
                    local mb = p.markButtons[i]
                    if not mb then
                        mb = CreateFrame("Button", nil, p.scrollChild)
                        mb:SetSize(PANEL_CW, 24)
                        mb.bg = mb:CreateTexture(nil, "BACKGROUND")
                        mb.bg:SetAllPoints()
                        mb.bg:SetColorTexture(1, 1, 1, 0.06)
                        mb.text = mb:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                        mb.text:SetPoint("CENTER")
                        mb.text:SetTextColor(unpack(COLOR_TEXT))
                        StyleOutlineButton(mb)
                        mb:SetScript("OnClick", function(self) ShowQuestOnMap(self.mark) end)
                        p.markButtons[i] = mb
                    end
                    mb.mark = mk
                    mb.text:SetText(mk.label or "Mark on map")
                    mb:ClearAllPoints()
                    mb:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
                    mb:Show()
                    y = y + 24 + 6
                end
                y = y + 8
            end
            if mapHere then
                p.mapButton.text:SetText(subject.mapLabel or "Mark on map")
                p.mapButton:ClearAllPoints()
                p.mapButton:SetPoint("TOPLEFT", p.scrollChild, "TOPLEFT", PANEL_PAD, -y)
                p.mapButton:Show()
                y = y + 24 + 14
            end
        end
    end

    local items, itemsLabel
    if mode == "quest" then
        items = subject.rewardItems or FindQuestRewardItems(d, subject)
        itemsLabel = "Rewards"
    else
        items = subject.items
        itemsLabel = subject.itemsLabel or "Loot"
    end

    if items and #items > 0 then
        p.itemsHeader:SetTextColor(ar, ag, ab)
        y = y + PlacePanelText(p, p.itemsHeader, y, string.upper(itemsLabel)) + 2
        y = y + PlacePanelText(p, p.itemsHint, y, "Shift-click to link an item, Ctrl-click to try it on.") + 10
        for _, item in ipairs(items) do
            local row = AcquirePanelItemRow(p)
            if mode == "boss" and item.id and d then row.wishBoss, row.wishDungeon = subject.title, d.name end
            y = y + LayoutPanelItem(p, row, y, item)
        end
    else
        p.itemsHeader:Hide()
        p.itemsHint:Hide()
        if mode == "boss" then
            y = y + PlacePanelText(p, p.emptyNote, y, "No loot known for this boss yet.") + 14
        end
    end

    -- a boss's tip, last and quiet
    if mode == "boss" and subject.tip then
        y = y + 4
        y = y + PlacePanelText(p, p.tipText, y, "Classic tip: " .. subject.tip) + 8
    end

    p.scrollChild:SetHeight(math.max(y + 8, 1))
    p:Show()
end

function ShowSidePanel(mode, subject, d)
    if not sidePanel then
        sidePanel = CreateSidePanel()
        sidePanel.onPopoutClose = HideSidePanel
    end

    if currentPanelSubject == subject and sidePanel:IsShown() then
        -- the same row again closes it, sliding shut like the x does (the panel resets itself then)
        if not (PF.Popouts and PF.Popouts:ClosePanel(sidePanel)) then HideSidePanel() end
        return
    end

    -- it opens on the right, where the Journey's Gold, XP and Discover window is: that
    -- closes, and Back returns to it (kept while moving between steps in this panel)
    local replaced = PF.Journey and PF.Journey.CloseMiniPanel and PF.Journey:CloseMiniPanel()
    if replaced then
        panelReturn = replaced
    elseif not sidePanel:IsShown() then
        panelReturn = nil
    end
    currentPanelSubject = subject
    currentPanelMode = mode
    currentPanelDungeon = d
    PopulateSidePanel(mode, subject, d)
    sidePanel.back:SetShown(panelReturn ~= nil or subject.backTo ~= nil)
end

-- Re-populates the currently-open panel without toggling it closed - used
-- when an item's data finishes loading after the panel was already shown,
-- so quality coloring catches up. Only reacts to items the panel is actually
-- showing, and coalesces bursts of events into one refresh.
local refreshPending = false
local function FlushSidePanelRefresh()
    refreshPending = false
    if sidePanel and sidePanel:IsShown() and currentPanelSubject then
        PopulateSidePanel(currentPanelMode, currentPanelSubject, currentPanelDungeon)
    end
end

function PF:RefreshSidePanel(itemID)
    if not (sidePanel and sidePanel:IsShown() and currentPanelSubject) then return end
    if itemID and not panelItemIDs[itemID] then return end
    if refreshPending then return end
    refreshPending = true
    C_Timer.After(0.15, FlushSidePanelRefresh)
end

-- ---------- Frame construction ----------
-- A plain button with a faint background (the dialog's buttons).
local function CreateFlatButton(parent, width, height, label)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(width, height)

    btn.bg = btn:CreateTexture(nil, "BACKGROUND")
    btn.bg:SetAllPoints()
    btn.bg:SetColorTexture(1, 1, 1, 0.06)

    btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    btn.text:SetPoint("CENTER")
    btn.text:SetText(label)
    btn.text:SetTextColor(unpack(COLOR_TEXT))

    StyleOutlineButton(btn)

    return btn
end

-- A tab is just its word: no box, sized to the text. The active tab is white
-- with a short accent line under the word; the others are grey and brighten
-- on hover.
local TAB_HEIGHT = 26
local TAB_GAP = 20 -- space between one tab's word and the next
local COLOR_TAB_HOVER = { 0.78, 0.78, 0.80 }

local function CreateTextTab(parent, label)
    local btn = CreateFrame("Button", nil, parent)

    btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    btn.text:SetPoint("TOPLEFT", 0, -5)
    btn.text:SetText(label)
    btn.text:SetTextColor(unpack(COLOR_MUTED))
    local width = math.ceil(btn.text:GetStringWidth() or (#label * 7))
    btn.text:SetWidth(width + 2) -- a hair of slack, so the word never wraps or clips
    btn:SetSize(width + 2, TAB_HEIGHT)

    btn.underline = btn:CreateTexture(nil, "ARTWORK")
    btn.underline:SetHeight(2)
    btn.underline:SetPoint("BOTTOMLEFT", 0, 0)
    btn.underline:SetPoint("BOTTOMRIGHT", 0, 0)
    btn.underline:Hide()
    -- the active tab's gold glow rising from its underline and fading out to both
    -- sides, and a faint blue one on hovering another tab
    btn.glow = CreateSoftGlow(btn, 0.34)
    btn.hoverGlow = CreateSoftGlow(btn, 0.24, BLUE)

    btn:SetScript("OnEnter", function(self)
        if not self.active then
            self.text:SetTextColor(unpack(COLOR_TAB_HOVER))
            self.hoverGlow:Show()
        end
    end)
    btn:SetScript("OnLeave", function(self)
        self.hoverGlow:Hide()
        if not self.active then self.text:SetTextColor(unpack(COLOR_MUTED)) end
    end)

    return btn
end

local function SetActiveTab(name)
    local ar, ag, ab = GetAccentColor()
    for tabName, btn in pairs(tabButtons) do
        local isActive = (tabName == name)
        btn.active = isActive
        btn.marker:SetColorTexture(ar, ag, ab, 0.9)
        do local px = PF.PixelUnit(btn); btn.marker:SetSize(PF.BULLET_PIXELS * px, PF.BULLET_PIXELS * px) end
        btn.marker:SetShown(isActive)
        btn.glow:SetShown(isActive)
        if isActive then btn.hoverGlow:Hide() end
        btn.text:SetTextColor(unpack(isActive and COLOR_TEXT or COLOR_MUTED))
    end
end

local function CreateMainFrame()
    local ar, ag, ab = GetAccentColor()

    local f = CreateFrame("Frame", "PathForeverFrame", UIParent, "BackdropTemplate")
    f:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
    f:SetPoint(unpack(PathForeverDB.point))
    f:SetMovable(true)
    -- PathForever's windows (this one and PathForever Fishing) share a layer, and
    -- whichever was clicked, dragged or opened last is in front: a top-level frame
    -- comes forward when clicked, and Raise() does the same on drag and open.
    -- Without this, parts of one window drew over parts of the other.
    f:SetFrameStrata("MEDIUM")
    f:SetToplevel(true)
    StyleWindow(f)


    header = CreateFrame("Frame", nil, f)
    header:SetPoint("TOPLEFT", 0, 0)
    header:SetPoint("TOPRIGHT", 0, 0)
    header:SetHeight(46)
    header:EnableMouse(true)
    header:RegisterForDrag("LeftButton")
    header:SetScript("OnDragStart", function()
        f:Raise()
        f:StartMoving()
    end)
    header:SetScript("OnDragStop", function()
        f:StopMovingOrSizing()
        local point, _, _, x, y = f:GetPoint()
        PathForeverDB.point = { point, "UIParent", point, x, y }
        if PF.Dock then PF.Dock:SyncToWindow(f) end -- the icon goes where the window is
    end)

    -- (No gold sheen behind the logo: tried and taken out at the user's request, 2026-10-05.)

    -- the page's name (the logo and PathForever's name are the sidebar's), a little larger
    -- than the game's large font
    local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", header, "TOPLEFT", 16, -13)
    title:SetWidth(300)
    title:SetJustifyH("LEFT")
    pcall(function()
        local font, size, flags = title:GetFont()
        if font and size then title:SetFont(font, size + 3, flags) end
    end)
    title:SetText("PathForever")
    title:SetTextColor(unpack(COLOR_TEXT))
    header.title = title


    local close = CreateFrame("Button", nil, header)
    close:SetSize(24, 24)
    close:SetPoint("TOPRIGHT", -10, -10)
    local closeText = close:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    closeText:SetPoint("CENTER")
    closeText:SetText("\195\151")
    closeText:SetTextColor(unpack(COLOR_MUTED))
    close:SetScript("OnClick", function() PF:CloseUI() end)
    close:SetScript("OnEnter", function() closeText:SetTextColor(unpack(COLOR_TEXT)) end)
    close:SetScript("OnLeave", function() closeText:SetTextColor(unpack(COLOR_MUTED)) end)

    -- Back from a dungeon's detail view to the list of dungeons
    local back = CreateFrame("Button", nil, header)
    back:SetSize(54, 24)
    back:SetPoint("RIGHT", close, "LEFT", -4, 0)
    back.text = back:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    back.text:SetPoint("CENTER")
    back.text:SetText("< Back")
    back.text:SetTextColor(unpack(COLOR_MUTED))
    back:SetScript("OnClick", function()
        PlayUISound("IG_CHARACTER_INFO_TAB")
        viewingDungeon, instanceFilter = nil, nil
        HideSidePanel()
        PF:RefreshUI()
    end)
    back:SetScript("OnEnter", function(self) self.text:SetTextColor(unpack(COLOR_TEXT)) end)
    back:SetScript("OnLeave", function(self) self.text:SetTextColor(unpack(COLOR_MUTED)) end)
    back:Hide()
    header.back = back

    -- Opening and closing sound like the game's own windows; closing (by the
    -- x, /pf, the minimap button or Escape) also closes the side panel.
    f:SetScript("OnShow", function() PlayUISound("IG_CHARACTER_INFO_OPEN") end)
    f:SetScript("OnHide", function()
        PlayUISound("IG_CHARACTER_INFO_CLOSE")
        HideSidePanel()
    end)
    -- Escape closes it, like every Blizzard window, but one window at a time: the outermost
    -- popout first, the main window last. UISpecialFrames hides everything listed at once,
    -- so a one pixel proxy is listed in the window's place; it is shown while the window is,
    -- and when Escape hides it, it closes one popout (and comes back) or else the window.
    do
        local esc = CreateFrame("Frame", "PathForeverEscape", UIParent)
        esc:SetSize(1, 1)
        esc:SetPoint("CENTER")
        esc:Hide()
        esc:SetScript("OnHide", function(self)
            if not f:IsShown() then return end
            self:Show() -- Escape hid it; it stays while the window does
            local level = PF.Popouts:Outermost()
            if level then
                PF.Popouts:Close(level)
            else
                PF:CloseUI()
            end
        end)
        if PF.Dock then PF.Dock:Hook(f) end
        f:HookScript("OnShow", function() esc:Show() end)
        f:HookScript("OnHide", function() esc:Hide() end)
        if type(UISpecialFrames) == "table" then table.insert(UISpecialFrames, "PathForeverEscape") end
    end

    -- The pages are the sidebar's entries (Sidebar.lua), which fill tabButtons. Journey
    -- took the old Zones tab's place (Journey.lua); Zones' data stays in Data.lua.
    PF.Sidebar:Create(f, tabButtons, function(name)
        PlayUISound("IG_CHARACTER_INFO_TAB")
        PathForeverDB.activeTab = name
        viewingDungeon = nil
        instanceFilter = nil
        HideSidePanel()
        PF:RefreshUI()
    end)

    -- under the page's name: a gold hairline fading out at both ends
    divider = { AddFadedLine(f, 46, 0, 0.45) }

    stickyHeader = CreateFrame("Frame", nil, f)
    -- inset by the border's 1 px, so the dungeon's art doesn't cover the gold border
    stickyHeader:SetPoint("TOPLEFT", 1, -STICKY_TOP)
    stickyHeader:SetPoint("TOPRIGHT", -1, -STICKY_TOP)
    stickyHeader:SetHeight(30)
    local stickyBg = stickyHeader:CreateTexture(nil, "BACKGROUND")
    stickyBg:SetAllPoints()
    stickyBg:SetColorTexture(0, 0, 0, 0.25)
    stickyHeader.art = stickyHeader:CreateTexture(nil, "BACKGROUND", nil, 1) -- above the dark band
    stickyHeader.art:SetAllPoints()
    ApplyArtFade(stickyHeader.art)
    stickyHeader.art:Hide()
    f.stickyHeaderArt = stickyHeader.art
    stickyHeaderText = stickyHeader:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    stickyHeaderText:SetPoint("TOPLEFT", 16, -STICKY_PAD_TOP)
    stickyHeaderText:SetWidth(388) -- the frame is 420 wide; see "How text is laid out"
    stickyHeaderText:SetJustifyH("LEFT")
    stickyHeaderText:SetTextColor(1, 1, 1)
    f.stickyHeaderText = stickyHeaderText -- (also lets the tests inspect it)
    -- A smaller second line under the name: level range, zone, and state.
    stickyHeaderSub = stickyHeader:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    stickyHeaderSub:SetWidth(388)
    stickyHeaderSub:SetJustifyH("LEFT")
    stickyHeaderSub:SetTextColor(COLOR_MUTED[1], COLOR_MUTED[2], COLOR_MUTED[3])
    stickyHeaderSub:Hide()
    f.stickyHeaderSub = stickyHeaderSub
    stickyHeader:Hide()

    cardBg = f:CreateTexture(nil, "BACKGROUND", nil, 1)
    cardBg:SetPoint("TOPLEFT", 8, -54)
    cardBg:SetPoint("BOTTOMRIGHT", -8, 8)
    cardBg:SetColorTexture(NAVY_FILL[1], NAVY_FILL[2], NAVY_FILL[3], 0.22)

    scrollFrame = CreateFrame("ScrollFrame", "PathForeverScroll", f, "UIPanelScrollFrameTemplate")
    StyleScrollBar(scrollFrame)
    scrollFrame:SetPoint("TOPLEFT", SCROLL_INSET_LEFT, -60)
    scrollFrame:SetPoint("BOTTOMRIGHT", -SCROLL_INSET_RIGHT, 14)

    scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(ROW_WIDTH, 1)
    scrollFrame:SetScrollChild(scrollChild)

    f:Hide()
    return f
end

-- Shows/hides the persistent (non-scrolling) dungeon name bar and shifts
-- the scroll area to make room for it, so the name stays visible while
-- scrolling through a long quest/boss list. `subText` (optional) is a smaller
-- second line under the name. The bar is sized from the measured text, and the
-- scroll area starts below it. With a dungeon `d`, its art is drawn behind the
-- name under the same rule as its list row.
local function SetStickyHeader(text, d, level, subText)
    if text then
        stickyHeaderText:SetText(text)
        local h = STICKY_PAD_TOP + (stickyHeaderText:GetStringHeight() or 16)
        if subText then
            stickyHeaderSub:ClearAllPoints()
            stickyHeaderSub:SetPoint("TOPLEFT", stickyHeader, "TOPLEFT", 16, -(h + 2))
            stickyHeaderSub:SetText(subText)
            stickyHeaderSub:Show()
            h = h + 2 + (stickyHeaderSub:GetStringHeight() or 10)
        else
            stickyHeaderSub:Hide()
            stickyHeaderSub:SetText("")
        end
        h = math.max(30, h + 7)
        stickyHeader:SetHeight(h)
        if d and IsArtShown(d, level) then
            ShowDungeonArt(stickyHeader.art, d, stickyHeader:GetWidth() or 420, h)
        else
            stickyHeader.art:Hide()
        end
        stickyHeader:Show()
        scrollFrame:ClearAllPoints()
        scrollFrame:SetPoint("TOPLEFT", SCROLL_INSET_LEFT, -(STICKY_TOP + h + 13))
        scrollFrame:SetPoint("BOTTOMRIGHT", -SCROLL_INSET_RIGHT, 14)
        cardBg:ClearAllPoints()
        cardBg:SetPoint("TOPLEFT", 8, -(STICKY_TOP + h + 7))
        cardBg:SetPoint("BOTTOMRIGHT", -8, 8)
    else
        stickyHeader:Hide()
        scrollFrame:ClearAllPoints()
        scrollFrame:SetPoint("TOPLEFT", SCROLL_INSET_LEFT, -60)
        scrollFrame:SetPoint("BOTTOMRIGHT", -SCROLL_INSET_RIGHT, 14)
        cardBg:ClearAllPoints()
        cardBg:SetPoint("TOPLEFT", 8, -54)
        cardBg:SetPoint("BOTTOMRIGHT", -8, 8)
    end
end

-- ---------- Tab content builders ----------
-- Scratch lists and comparators reused by every Dungeons redraw (wiped, never
-- reallocated). Building four lists and two sort functions per redraw is garbage.
local dungeonVisible, dungeonInRange, dungeonOther, dungeonSorted = {}, {}, {}, {}
local function SortInRange(a, b) return a.levelMin < b.levelMin end
local function SortOther(a, b)
    if a.comingSoon ~= b.comingSoon then return not a.comingSoon end
    return a.levelMin < b.levelMin
end

-- What a dungeon's list row says only changes when its numbers do (state,
-- quests done, quests available), so its text and click handler are built once
-- and reused until they change.
local dungeonRowCache = {}
-- In-line color so this one line is quest yellow inside an otherwise grey row.
local NEW_QUESTS_LINE = ColorHex(COLOR_GOLD) .. "New quests available|r"

local function GetDungeonRow(d, level)
    local entry = dungeonRowCache[d]
    if not entry then
        entry = {}
        dungeonRowCache[d] = entry
        entry.range = string.format("%d-%d", d.levelMin, d.levelMax) -- shown in the right-hand column
        entry.onClick = function()
            viewingDungeon = d
            instanceFilter = nil
            HideSidePanel()
            PF:RefreshUI()
        end
    end
    if d.comingSoon then return entry end

    local total, completed, allDone = PF:GetDungeonQuestCounts(d)
    local hasNew = PF:GetDungeonNewQuestCount(d, level) > 0
    -- The title is white while the dungeon is worth doing (in your level or
    -- quest range, quests left), grey otherwise.
    local relevant = not allDone and PF:IsInDungeonOrQuestRange(d, level)
    local key = ((completed * 1000 + total) * 2 + (hasNew and 1 or 0)) * 2 + (relevant and 1 or 0)
    if entry.key ~= key then
        entry.key = key
        local lines = {}
        if hasNew then lines[#lines + 1] = NEW_QUESTS_LINE end
        -- No faction here: either faction can enter any dungeon (they may just
        -- have no quests there), and quests carry their own faction tags.
        lines[#lines + 1] = d.zone
        if allDone then
            lines[#lines + 1] = ColorHex(COLOR_GOOD) .. string.format("All %d quests done", total) .. "|r"
        elseif total > 0 then
            lines[#lines + 1] = string.format("%d of %d quests done", completed, total)
        end
        entry.subText = table.concat(lines, "\n")
        entry.titleColor = relevant and COLOR_TEXT or COLOR_MUTED
    end
    return entry
end

local function RenderDungeons()
    SetStickyHeader(nil)
    local level = UnitLevel("player")
    local source = instanceFilter or PathForeverData.Dungeons

    -- Hide dungeons above the beta level cap (unless turned off in Options).
    -- The "wings of your current instance" list is exempt: you're standing there.
    local hiddenDungeons = 0
    if not instanceFilter then
        wipe(dungeonVisible)
        for _, d in ipairs(source) do
            if PF:IsDungeonBeyondCap(d) then
                hiddenDungeons = hiddenDungeons + 1
            else
                dungeonVisible[#dungeonVisible + 1] = d
            end
        end
        source = dungeonVisible
    end

    -- Dungeons inside your level range or their quest range (including ones
    -- you've already finished) float to the top so old low-level or
    -- far-future dungeons don't clutter the head of the list. "Coming Soon"
    -- entries always sort to the bottom, level match or not, since there's
    -- nothing actionable about them yet.
    wipe(dungeonInRange)
    wipe(dungeonOther)
    wipe(dungeonSorted)
    for _, d in ipairs(source) do
        if d.comingSoon then
            dungeonOther[#dungeonOther + 1] = d
        elseif PF:IsInDungeonOrQuestRange(d, level) then
            dungeonInRange[#dungeonInRange + 1] = d
        else
            dungeonOther[#dungeonOther + 1] = d
        end
    end
    table.sort(dungeonInRange, SortInRange)
    table.sort(dungeonOther, SortOther)
    for _, d in ipairs(dungeonInRange) do dungeonSorted[#dungeonSorted + 1] = d end
    for _, d in ipairs(dungeonOther) do dungeonSorted[#dungeonSorted + 1] = d end

    local y, i = 0, 0

    -- The art preview overrides the normal rule for every row, so it must never
    -- be left on without the window saying so.
    if artPreviewAll then
        i = i + 1
        local row = AcquireRow()
        y = y + LayoutRow(row, i, y, "Art preview is on", COLOR_GOLD,
            "Every dungeon is showing its art", function()
                artPreviewAll = false
                PF:RefreshUI()
            end)
        row.tooltip = "Click to turn the preview off"
    end

    if instanceFilter then
        i = i + 1
        local row = AcquireRow()
        y = y + LayoutRow(row, i, y, "Show all dungeons", COLOR_TEXT,
            "Only the wings of the instance you're in are listed", function()
                instanceFilter = nil
                PF:RefreshUI()
            end)
    end

    for _, d in ipairs(dungeonSorted) do
        i = i + 1
        local row = AcquireRow()
        local entry = GetDungeonRow(d, level)
        local h
        if d.comingSoon then
            h = LayoutRow(row, i, y, d.name, COLOR_MUTED, "Coming soon", nil, nil, nil, entry.range)
        else
            h = LayoutRow(row, i, y, d.name, entry.titleColor, entry.subText, entry.onClick, nil, nil, entry.range)
        end
        local inRange = not d.comingSoon and PF:IsInDungeonOrQuestRange(d, level)
        if IsArtShown(d, level) then ShowDungeonArt(row.art, d, ROW_WIDTH, h, not inRange) end
        row.rangeBar:SetShown(inRange and true or false)
        y = y + h
    end

    if hiddenDungeons > 0 then
        i = i + 1
        local row = AcquireRow()
        y = y + LayoutRow(row, i, y,
            string.format("%d more above level %d", hiddenDungeons, PathForeverData.LevelCap),
            COLOR_MUTED, "Hidden while the beta is capped at level " .. PathForeverData.LevelCap,
            function()
                PathForeverDB.options.showAboveCap = true
                PF:RefreshUI()
            end)
        row.tooltip = "Click to show them. You can hide them again in Options."
    end
    scrollChild:SetHeight(math.max(y, 1))
end

-- Dungeons whose completed quests are expanded in the detail view. Session only.
local showCompletedQuests = {}

-- The dungeon view's Quests and Bosses sections start open; a click on the
-- header collapses one. Remembered for the session, across dungeons.
local collapsedSections = {}
local function ToggleQuestsSection()
    collapsedSections.Quests = not collapsedSections.Quests or nil
    PF:RefreshUI()
end
local function ToggleBossesSection()
    collapsedSections.Bosses = not collapsedSections.Bosses or nil
    PF:RefreshUI()
end

-- What a quest row shows for each status: the game's own quest icon, and a
-- short status line. The statuses you act on are colored in-line (the rest of
-- the row stays grey): green to pick up, orange in progress, gold to turn in.
-- "turnin" is an in-progress quest whose objectives are all done.
local ICON_QUEST_AVAILABLE = "Interface\\GossipFrame\\AvailableQuestIcon"   -- yellow !
local ICON_QUEST_INCOMPLETE = "Interface\\GossipFrame\\IncompleteQuestIcon" -- grey ?
local ICON_QUEST_TURNIN = "Interface\\GossipFrame\\ActiveQuestIcon"         -- yellow ?
local ICON_QUEST_DONE = "Interface\\RaidFrame\\ReadyCheck-Ready"            -- green check
local QUEST_ROW = {
    available = { icon = ICON_QUEST_AVAILABLE, text = ColorHex(COLOR_READY) .. "Available|r" },
    inprogress = { icon = ICON_QUEST_INCOMPLETE, text = ColorHex(COLOR_WARN) .. "In progress|r" },
    turnin = { icon = ICON_QUEST_TURNIN, text = ColorHex(COLOR_GOLD) .. "Ready to turn in|r" },
    completed = { icon = ICON_QUEST_DONE, text = "Done" },
    unavailable = { icon = ICON_QUEST_AVAILABLE, grey = true },  -- text: "Available at level N"
    untracked = { icon = ICON_QUEST_AVAILABLE, grey = true },    -- no ID on file: nothing to say
}

-- "Pick up in <zone>", or "Chain starts in <zone>" when the quest is a later
-- link in a chain (the chain's start is where you actually have to go), unless
-- atStep says the steps before it are done (the Journey's class quests). Nothing
-- when the zone isn't on file yet.
local function QuestLocationText(q, status, atStep)
    -- Once it's in your log, where you go next is where it's turned in.
    if status == "inprogress" then
        return q.turninZone and ("Complete in " .. q.turninZone) or nil
    end
    if q.chainStart and not atStep then
        return q.chainStart.zone and ("Chain starts in " .. q.chainStart.zone) or nil
    end
    return q.pickupZone and ("Pick up in " .. q.pickupZone) or nil
end

-- How a quest row reads for a status: its icon, its lines under the name, the
-- name's color, and whether the icon is greyed. Shared with the Journey tab's
-- class quests (PF.UI.DescribeQuest), so both lists read the same; atStep is
-- QuestLocationText's.
local function DescribeQuest(q, d, level, status, atStep)
    status = status or PF:GetQuestStatus(q, d, level)
    local show = (status == "inprogress" and PF:IsQuestReadyToTurnIn(q.id)) and QUEST_ROW.turnin or QUEST_ROW[status]
    local text = show.text
    if status == "unavailable" then
        text = string.format("Available at level %d", PF:GetQuestRequiredLevel(q, d))
    end
    local where = status ~= "completed" and QuestLocationText(q, status, atStep) or nil
    if where then text = text and (text .. "\n" .. where) or where end
    if q.part then text = text and ("Part " .. q.part .. "\n" .. text) or ("Part " .. q.part) end
    local color = (status == "unavailable" or status == "completed" or status == "untracked") and COLOR_MUTED or COLOR_GOLD
    return show.icon, text, color, show.grey and true or false
end

local function LayoutQuestRow(row, i, y, q, d, level)
    local status = PF:GetQuestStatus(q, d, level)
    local show = (status == "inprogress" and PF:IsQuestReadyToTurnIn(q.id)) and QUEST_ROW.turnin or QUEST_ROW[status]
    local text = show.text
    if status == "unavailable" then
        text = string.format("Available at level %d", PF:GetQuestRequiredLevel(q, d))
    end
    -- The location gets a line of its own: joined onto the status it wrapped mid-phrase.
    local where = status ~= "completed" and QuestLocationText(q, status) or nil
    if where then text = text and (text .. "\n" .. where) or where end
    -- Two steps of a chain with the same name read "Part 1 of 2" / "Part 2 of 2".
    if q.part then text = text and ("Part " .. q.part .. "\n" .. text) or ("Part " .. q.part) end
    local color = (status == "unavailable" or status == "completed" or status == "untracked") and COLOR_MUTED or COLOR_GOLD
    -- The level it can be picked up at - only when it's on file, never the
    -- dungeon-minimum stand-in, so the label is always a real number.
    local levelLabel = q.requires and ("Lv " .. q.requires) or nil
    row.wantsKey = q.key and true or nil
    local h = LayoutRow(row, i, y, q.name, color, text, function()
        ShowSidePanel("quest", q, d)
    end, show.icon, nil, levelLabel)
    row.icon:SetDesaturated(show.grey and true or false)
    if q.key then
        if h < PF.KEY_SIZE + 8 then h = PF.KEY_SIZE + 8; row:SetHeight(h) end
        row.keyIcon:ClearAllPoints()
        row.keyIcon:SetPoint("TOPLEFT", row, "TOPLEFT", 1, -1)
        row.keyIcon:Show()
        row.tooltip = q.key
    end
    return h
end

local function RenderDungeonDetail(d)
    local level = UnitLevel("player")
    local y, i = 0, 0

    -- Level range, zone and state sit under the dungeon's name in the pinned
    -- bar; the state word keeps its color (it was the old row's accent bar).
    local state = PF:GetDungeonState(d, level)
    local stateColor = (state == "done" and COLOR_DONE) or (state == "ready" and COLOR_READY) or COLOR_LOCKED
    local stateLabel = (state == "done" and "Completed") or (state == "ready" and "In range") or "Out of range"
    local details = string.format("%s\nLv %d-%d, %s%s|r", d.zone, d.levelMin, d.levelMax, ColorHex(stateColor), string.lower(stateLabel))
    SetStickyHeader(d.name, d, level, details)

    -- No "back" row: the Dungeons tab button returns to the list.

    -- The panel with the way there, what it takes to get in and the quest XP.
    if PF.BuildTripSubject and not d.comingSoon then
        i = i + 1
        y = y + LayoutRow(AcquireRow(), i, y, "Before you go", COLOR_TEXT, "Getting there, getting in, quest XP", function()
            ShowSidePanel("info", PF.BuildTripSubject(d))
        end)
    end

    -- Quests (a collapsible section)
    i = i + 1
    y = y + LayoutSectionHeader(AcquireRow(), y, "Quests", ToggleQuestsSection, not collapsedSections.Quests)
    if not collapsedSections.Quests then
        -- Completed quests are tucked away under a "Show Completed Quests" toggle at
        -- the bottom of the list, so what's left to do is what you see first.
        local effectiveQuests = PF:GetEffectiveQuests(d)
        if #effectiveQuests > 0 then
            local completedCount = 0
            for _, q in ipairs(effectiveQuests) do
                if PF:GetQuestStatus(q, d, level) == "completed" then
                    completedCount = completedCount + 1
                elseif not PF:IsLaterChainStep(q, d) then
                    i = i + 1
                    y = y + LayoutQuestRow(AcquireRow(), i, y, q, d, level)
                end
            end
            if completedCount > 0 then
                local expanded = showCompletedQuests[d]
                i = i + 1
                local toggleRow = AcquireRow()
                local label = string.format("%s completed quests (%d)", expanded and "Hide" or "Show", completedCount)
                y = y + LayoutRow(toggleRow, i, y, label, COLOR_TEXT, "", function()
                    showCompletedQuests[d] = not showCompletedQuests[d] or nil
                    PF:RefreshUI()
                end)
                if expanded then
                    for _, q in ipairs(effectiveQuests) do
                        if PF:GetQuestStatus(q, d, level) == "completed" then
                            i = i + 1
                            y = y + LayoutQuestRow(AcquireRow(), i, y, q, d, level)
                        end
                    end
                end
            end
        else
            i = i + 1
            local row = AcquireRow()
            y = y + LayoutRow(row, i, y, "No quests known yet", COLOR_MUTED, "")
        end

        local hiddenQuests = PF:GetHiddenQuestCount(d)
        if hiddenQuests > 0 then
            i = i + 1
            local row = AcquireRow()
            y = y + LayoutRow(row, i, y,
                string.format("%d more quest%s above Lv %d", hiddenQuests, hiddenQuests == 1 and "" or "s", PathForeverData.LevelCap),
                COLOR_MUTED, "Hidden above the level cap", function()
                    PathForeverDB.options.showAboveCap = true
                    PF:RefreshUI()
                end)
            row.tooltip = "Click to show them. You can hide them again in Options."
        end
    end

    -- Bosses (a collapsible section)
    i = i + 1
    y = y + LayoutSectionHeader(AcquireRow(), y, "Bosses", ToggleBossesSection, not collapsedSections.Bosses)
    if not collapsedSections.Bosses then
        local playerFaction = UnitFactionGroup("player")
        local bossGroups = {}
        if d.lootGroups then
            for _, group in ipairs(d.lootGroups) do
                if group.kind == "boss" and (not group.faction or group.faction == playerFaction) then
                    table.insert(bossGroups, group)
                end
            end
        end

        if #bossGroups > 0 then
            for _, group in ipairs(bossGroups) do
                i = i + 1
                local row = AcquireRow()
                if #group.items == 0 then
                    -- a new dungeon's boss whose loot hasn't been recorded yet: nothing to open
                    y = y + LayoutRow(row, i, y, group.title, COLOR_TEXT, "Loot not known yet", nil,
                        nil, nil, nil, group.displayID)
                else
                    local itemLabel = (#group.items == 1) and "1 item" or (#group.items .. " items")
                    y = y + LayoutRow(row, i, y, group.title, COLOR_TEXT, itemLabel, function()
                        ShowSidePanel("boss", group, d)
                    end, nil, nil, nil, group.displayID)
                end
            end
            -- the dungeon's trash drops: one more row after the bosses
            for _, group in ipairs(d.lootGroups) do
                if group.kind == "trash" and #group.items > 0 then
                    i = i + 1
                    local itemLabel = (#group.items == 1) and "1 item" or (#group.items .. " items")
                    y = y + LayoutRow(AcquireRow(), i, y, group.title, COLOR_TEXT, itemLabel, function()
                        ShowSidePanel("boss", group, d)
                    end)
                end
            end
        else
            i = i + 1
            local row = AcquireRow()
            local text = (d.notableLoot and #d.notableLoot > 0) and table.concat(d.notableLoot, "\n") or ""
            y = y + LayoutRow(row, i, y, "No boss loot known yet", COLOR_MUTED, text)
        end
    end

    scrollChild:SetHeight(math.max(y, 1))
end

-- ---------- The profession and alt pop-outs ----------
-- Both use the side panel's "info" mode: a title, a subtitle and a list of
-- { header, body } sections, rebuilt each time the panel opens. One subject table per
-- profession name and alt GUID, so clicking the same row again closes the panel.
local infoSubjects = {}
local function InfoSubject(key)
    local s = infoSubjects[key]
    if not s then s = { sections = {} }; infoSubjects[key] = s end
    wipe(s.sections)
    return s
end
local function AddInfo(s, header, body)
    if body and body ~= "" then s.sections[#s.sections + 1] = { header, body } end
end
local function Colored(c, text) return ColorHex(c) .. text .. "|r" end

-- "Before you go" for a dungeon (its own do-block: this file is at Lua's 200-locals limit).
do
local function EntranceOf(d)
    for _, e in ipairs(PathForeverData.Entrances or {}) do
        for _, name in ipairs(e.dungeons or {}) do
            if name == d.name then return e end
        end
    end
end

function PF.BuildTripSubject(d)
    local s = InfoSubject("trip:" .. d.name)
    s.title, s.subtitle = "Before you go", d.name
    s.mapID, s.x, s.y, s.pickup, s.pickupZone, s.mapSection, s.mapLabel = nil, nil, nil, nil, nil, nil, nil
    local level = UnitLevel("player") or 1

    -- the entrance, and the flight point nearest it
    local e = EntranceOf(d)
    if e then
        local zone = MapName(e.map) or d.zone or ""
        local body = Colored(COLOR_TEXT, e.name) .. "\n" .. string.format("%s (%d, %d)", zone,
            math.floor(e.x * 100 + 0.5), math.floor(e.y * 100 + 0.5))
        if e.note then body = body .. "\n" .. Colored(COLOR_MUTED, e.note) end
        AddInfo(s, "Entrance", body)
        s.mapID, s.x, s.y, s.pickup, s.pickupZone, s.mapSection, s.mapLabel = e.map, e.x, e.y, e.name, zone, "Entrance", "Mark entrance on map"
    else
        AddInfo(s, "Entrance", Colored(COLOR_MUTED, "Not known yet"))
    end

    -- getting in: the level, and the quests that open the way
    local quests = PF:GetEffectiveQuests(d)
    local lines = {}
    local lvlColor = (level >= d.levelMin and level <= d.levelMax) and COLOR_GOOD or COLOR_WARN
    lines[1] = Colored(lvlColor, string.format("Lv %d-%d", d.levelMin, d.levelMax))
    lines[2] = string.format("You are Lv %d", level)
    local keyDone, keyTotal = 0, 0
    for _, q in ipairs(quests) do
        if q.key then
            keyTotal = keyTotal + 1
            local st = PF:GetQuestStatus(q, d, level)
            local word, color = "not started", COLOR_MUTED
            if st == "completed" then word, color = "done", COLOR_GOOD; keyDone = keyDone + 1
            elseif st == "inprogress" then word, color = "in your log", COLOR_WARN end
            lines[#lines + 1] = q.name .. "\n" .. Colored(color, word)
        end
    end
    if keyTotal > 0 then
        table.insert(lines, 3, string.format("%d of %d key quests done", keyDone, keyTotal))
    else
        lines[#lines + 1] = Colored(COLOR_MUTED, "No key quests known")
    end
    AddInfo(s, "Getting in", table.concat(lines, "\n"))

    -- the quests left, and the XP they give where it is known
    local left, xp, unknown = 0, 0, 0
    for _, q in ipairs(quests) do
        if PF:GetQuestStatus(q, d, level) ~= "completed" then
            left = left + 1
            if q.xp then xp = xp + q.xp else unknown = unknown + 1 end
        end
    end
    local body
    if #quests == 0 then
        body = Colored(COLOR_MUTED, "No quests known yet")
    elseif left == 0 then
        body = Colored(COLOR_GOOD, "All done")
    else
        body = string.format("%d %s left", left, left == 1 and "quest" or "quests")
        if xp > 0 then body = body .. ", " .. Colored(COLOR_TEXT, FormatNumber(xp) .. " XP") end
        if unknown > 0 then
            body = body .. "\n" .. Colored(COLOR_MUTED, string.format("%d %s with unknown XP", unknown, unknown == 1 and "quest" or "quests"))
        end
    end
    AddInfo(s, "Quest XP", body)
    return s
end
end -- do (Before you go)

-- "less than an hour ago", "5 hours ago", "3 days ago"
local function TimeAgo(seen)
    local now = time and time()
    seen = tonumber(seen)
    if not (now and seen) then return nil end
    local hours = math.floor((now - seen) / 3600)
    if hours < 1 then return "less than an hour ago" end
    if hours < 48 then return hours .. (hours == 1 and " hour ago" or " hours ago") end
    return math.floor(hours / 24) .. " days ago"
end

-- "4 days 3h", "7h 12m"
local function LongDuration(seconds)
    seconds = math.floor(tonumber(seconds) or 0)
    local days = math.floor(seconds / 86400)
    if days > 0 then
        return string.format("%d day%s %dh", days, days == 1 and "" or "s", math.floor(seconds / 3600) % 24)
    end
    return string.format("%dh %dm", math.floor(seconds / 3600), math.floor(seconds / 60) % 60)
end

-- One line on the skill against the pace for the character's level.
local function PaceLine(skill, level)
    local expected = PF:GetExpectedSkill(level)
    local gap = expected - skill
    if expected == 0 then
        return Colored(COLOR_MUTED, "No pace to keep before Lv " .. PathForeverData.ProfessionGraceLevel)
    end
    if gap <= 0 then
        return Colored(COLOR_GOOD, gap == 0 and "On pace" or string.format("%d ahead of pace", -gap))
    end
    return Colored(gap > PACE_FAR_BEHIND and COLOR_BAD or COLOR_WARN, string.format("%d behind pace", gap))
end

local function NextRank(maxSkill)
    for _, r in ipairs(PathForeverData.ProfessionRanks or {}) do
        if r.cap > (maxSkill or 0) then return r end
    end
end

-- The first `count` zones of a gathering node's list.
local function ZoneList(zones, count)
    local out = {}
    for i = 1, math.min(count, #zones) do out[i] = zones[i] end
    return table.concat(out, ", ")
end

local function GatheringSections(s, name, skill)
    local nodes = PathForeverData.Gathering and PathForeverData.Gathering[name]
    if not nodes then return end
    -- the best nodes are the highest you can gather: they keep giving skill longest
    local best, nextNode = {}, nil
    for _, n in ipairs(nodes) do
        if n.skill <= skill then
            best[#best + 1] = n
        elseif not nextNode then
            nextNode = n
        end
    end
    local lines = {}
    for i = #best, math.max(1, #best - 2), -1 do
        local n = best[i]
        lines[#lines + 1] = Colored(COLOR_TEXT, n.name) .. "\n" .. Colored(COLOR_MUTED, ZoneList(n.zones, 3))
    end
    AddInfo(s, "Best to gather now", table.concat(lines, "\n"))
    if nextNode then
        AddInfo(s, "Next to unlock", string.format("%s at %d skill (%d to go)\n%s",
            Colored(COLOR_TEXT, nextNode.name), nextNode.skill, nextNode.skill - skill,
            Colored(COLOR_MUTED, ZoneList(nextNode.zones, 3))))
    end
end

-- Skinning in classic: beasts up to skill / 10 + 10 under 100 skill, skill / 5 from there.
local function SkinningSections(s, skill)
    local maxLevel = skill < 100 and (math.floor(skill / 10) + 10) or math.floor(skill / 5)
    local faction = UnitFactionGroup("player")
    local zones = {}
    for _, z in ipairs(PF:GetRelevantZones(maxLevel - 3, 0)) do
        if z.levelMax and z.levelMax <= maxLevel + 2 and (z.faction == "Both" or z.faction == faction) then
            zones[#zones + 1] = z.name
        end
    end
    local body = "Beasts up to Lv " .. maxLevel
    if #zones > 0 then body = body .. "\n" .. Colored(COLOR_MUTED, table.concat(zones, ", ")) end
    AddInfo(s, "You can skin", body)
end

-- Where this account has caught the most (PathForever Fishing's saved catches).
local function FishingSections(s)
    local fishing = PathForeverDB and PathForeverDB.fishing
    local zones = type(fishing) == "table" and type(fishing.zones) == "table" and fishing.zones or {}
    local list = {}
    for _, z in pairs(zones) do
        if type(z) == "table" and type(z.fish) == "table" then
            local total, topName, topCount = 0, nil, 0
            for _, f in pairs(z.fish) do
                local c = type(f) == "table" and tonumber(f.count) or 0
                total = total + c
                if c > topCount and f.name then topName, topCount = f.name, c end
            end
            if total > 0 then list[#list + 1] = { name = z.name or "Unknown zone", total = total, top = topName } end
        end
    end
    table.sort(list, function(a, b) return a.total > b.total end)
    local lines = {}
    for i = 1, math.min(4, #list) do
        local z = list[i]
        lines[#lines + 1] = Colored(COLOR_TEXT, z.name) .. "\n" .. Colored(COLOR_MUTED,
            string.format("%d caught%s", z.total, z.top and (", mostly " .. z.top) or ""))
    end
    AddInfo(s, "Where you've fished most", #lines > 0 and table.concat(lines, "\n")
        or Colored(COLOR_MUTED, "Your catches show here once PathForever Fishing has seen a few."))
end

local function ProfessionSubject(p)
    local s = InfoSubject("prof:" .. p.name)
    local level = UnitLevel("player") or 1
    local skill, max = p.skillLevel or 0, p.maxSkillLevel or 0
    s.title = p.name
    s.subtitle = p.isPrimary and "Main profession" or "Secondary profession"

    AddInfo(s, "Where you stand", string.format("%s\n%s\n%s",
        Colored(COLOR_TEXT, string.format("%d / %d", skill, max)),
        PaceLine(skill, level),
        Colored(COLOR_MUTED, string.format("%d expected at Lv %d", PF:GetExpectedSkill(level), level))))

    local atLevel, atSession
    if PF.Journey and PF.Journey.ProfessionGains then
        atLevel, atSession = PF.Journey:ProfessionGains(p.name, skill)
    end
    if atLevel or atSession then
        local parts = {}
        if atLevel then parts[#parts + 1] = string.format("%d this level", atLevel) end
        if atSession then parts[#parts + 1] = string.format("%d this session", atSession) end
        AddInfo(s, "Skill gained", table.concat(parts, "\n"))
    end

    local rank = NextRank(max)
    s.mapID, s.x, s.y, s.pickup, s.pickupZone = nil, nil, nil, nil, nil
    if rank then
        -- a book or a quest instead of the trainer, for the player's faction
        local src = PathForeverData.ProfessionRankSources and PathForeverData.ProfessionRankSources[p.name]
        src = src and src[rank.name]
        local where = src and (src[UnitFactionGroup("player") or ""] or src.both)
        local needSkill, needLevel = src and src.skill or rank.skill, src and src.level or rank.level
        local skillOk, levelOk = skill >= needSkill, level >= needLevel
        local needs = Colored(skillOk and COLOR_GOOD or COLOR_WARN, "skill " .. needSkill)
        if needLevel > 0 then needs = needs .. " and " .. Colored(levelOk and COLOR_GOOD or COLOR_WARN, "Lv " .. needLevel) end
        local body = string.format("%s, up to %d skill\nNeeds %s", Colored(COLOR_TEXT, rank.name), rank.cap, needs)
        if src and where then
            local at = where.npc .. (where.place and (", " .. where.place) or "") .. ", " .. where.zone
                .. string.format(" (%d, %d)", math.floor(where.x * 100 + 0.5), math.floor(where.y * 100 + 0.5))
            if src.book then
                body = body .. "\n" .. string.format("From the book %s%s\nSold by %s",
                    Colored(COLOR_TEXT, src.book), src.cost and (", " .. PF.Journey.FormatMoney(src.cost)) or "", at)
            else
                body = body .. "\n" .. string.format("From the quest %s\nGiven by %s", Colored(COLOR_TEXT, src.quest), at)
            end
            -- the panel's "Mark on map" button (taint rule 2) pins this NPC
            s.mapID, s.x, s.y, s.pickup, s.pickupZone = where.mapID, where.x, where.y, where.npc, where.zone
        else
            local price = PF.Journey and PF.Journey.RankCost and PF.Journey:RankCost(rank.name)
            body = body .. "\nFrom your trainer" .. (price and (", " .. PF.Journey.FormatMoney(price)) or "")
        end
        if max > 0 and skill >= max then
            body = body .. "\n" .. Colored(COLOR_WARN, levelOk and "You're at the cap: get it to keep gaining skill"
                or ("You're at the cap until Lv " .. needLevel))
        elseif skillOk and levelOk then
            body = body .. "\n" .. Colored(COLOR_GOOD, src and "Ready for it" or "Ready to train")
        end
        AddInfo(s, "Next rank", body)
    elseif max > 0 then
        AddInfo(s, "Rank", Colored(COLOR_TEXT, "Artisan") .. ", the highest rank")
    end

    -- the ranks after the next one: what each needs and costs, with the price a trainer showed
    -- (a rank not seen at a trainer yet has none)
    if rank then
        local later = {}
        local rsrc = PathForeverData.ProfessionRankSources and PathForeverData.ProfessionRankSources[p.name]
        for _, r in ipairs(PathForeverData.ProfessionRanks or {}) do
            if r.cap > rank.cap then
                local rs = rsrc and rsrc[r.name]
                local needSkill, needLevel = rs and rs.skill or r.skill, rs and rs.level or r.level
                local price = rs and rs.cost
                    or (PF.Journey and PF.Journey.RankCost and PF.Journey:RankCost(r.name))
                local from = rs and (rs.book and "book" or "quest") or "trainer"
                local needs = "skill " .. needSkill .. (needLevel > 0 and (" and Lv " .. needLevel) or "")
                later[#later + 1] = Colored(COLOR_TEXT, r.name) .. ", up to " .. r.cap .. " skill\n"
                    .. Colored(COLOR_MUTED, string.format("Needs %s, from the %s%s", needs, from,
                        price and (", " .. PF.Journey.FormatMoney(price)) or ""))
            end
        end
        if #later > 0 then AddInfo(s, "Later ranks", table.concat(later, "\n")) end
    end

    if p.name == "Mining" or p.name == "Herbalism" then
        GatheringSections(s, p.name, skill)
    elseif p.name == "Skinning" then
        SkinningSections(s, skill)
    elseif p.name == "Fishing" then
        FishingSections(s)
    end
    return s
end

local function AltSubject(char)
    local s = InfoSubject("alt:" .. tostring(char.key))
    local J = PF.Journey
    local rec = J and J.GetCharRecord and J:GetCharRecord(char.key)
    local snap = rec and type(rec.snap) == "table" and rec.snap or nil
    local level = math.floor(char.level or 0)
    local hex = ClassColorHex(char.class)
    s.title = hex and (hex .. char.name .. "|r") or char.name
    local who = { "Lv " .. level }
    if snap and type(snap.raceName) == "string" then who[#who + 1] = snap.raceName end
    if char.className and char.className ~= "" then who[#who + 1] = char.className end
    s.subtitle = table.concat(who, " ")

    if snap then
        local ago = TimeAgo(snap.seen)
        local where = (type(snap.zone) == "string" and snap.zone ~= "") and ("In " .. snap.zone) or "Logged out"
        AddInfo(s, "Last seen", where .. (ago and (", " .. ago) or ""))
    end
    if rec and tonumber(rec.money) then
        AddInfo(s, "Gold", J.FormatMoney(rec.money))
    end
    local cap = PathForeverData.LevelCap or 60
    if snap and (tonumber(snap.xpMax) or 0) > 0 and level < cap then
        local rested, max = J:EstimateRested(snap)
        local pct = math.floor((tonumber(snap.xp) or 0) / max * 100)
        local body = string.format("%d%% through Lv %d", pct, level)
        if rested and rested > 0 then
            body = body .. "\n" .. string.format("About %s rested XP (%d%% of a level)",
                FormatNumber(rested), math.floor(rested / max * 100))
            if rested >= max * 1.5 then
                body = body .. "\n" .. Colored(COLOR_GOOD, "Fully rested")
            elseif not snap.resting then
                body = body .. "\n" .. Colored(COLOR_MUTED, "Logged out away from an inn or city, so it rests slowly")
            end
        end
        AddInfo(s, "Experience", body)
    end

    local profs = {}
    for _, prof in ipairs(char.professions or {}) do
        profs[#profs + 1] = string.format("%s  %d / %d\n%s", Colored(COLOR_TEXT, prof.name),
            prof.skillLevel, prof.maxSkillLevel, PaceLine(prof.skillLevel, level))
    end
    AddInfo(s, "Professions", #profs > 0 and table.concat(profs, "\n") or Colored(COLOR_MUTED, "No main professions yet"))

    if snap then
        local waiting = {}
        local skills, quests = tonumber(snap.skillsReady) or 0, tonumber(snap.questsReady) or 0
        if skills > 0 then
            local cost = tonumber(snap.skillsCost) or 0
            waiting[#waiting + 1] = string.format("%d skill%s at the trainer%s", skills, skills == 1 and "" or "s",
                cost > 0 and (" (" .. J.FormatMoney(cost) .. ")") or "")
        end
        if quests > 0 then
            waiting[#waiting + 1] = string.format("%d class quest%s to pick up", quests, quests == 1 and "" or "s")
        end
        if #waiting > 0 then
            AddInfo(s, "Waiting", table.concat(waiting, "\n") .. "\n" .. Colored(COLOR_MUTED, "As of the last login"))
        end
    end

    if rec and tonumber(rec.played) then AddInfo(s, "Time played", LongDuration(rec.played)) end

    -- every character's gold together, the one logged in counted live
    local total, count = GetMoney and GetMoney() or 0, 1
    local chars = PathForeverDB and type(PathForeverDB.journey) == "table" and PathForeverDB.journey.chars
    local me = UnitGUID("player")
    for guid, c in pairs(type(chars) == "table" and chars or {}) do
        if guid ~= me and type(c) == "table" and tonumber(c.money) then
            total, count = total + c.money, count + 1
        end
    end
    if count > 1 then
        AddInfo(s, "All characters", string.format("%s across %d characters", J.FormatMoney(total), count))
    end
    if not snap then
        AddInfo(s, "More", Colored(COLOR_MUTED, "Log in on this character to see where it is, its rested XP and what's waiting for it."))
    end
    return s
end

-- The Wishlist tab: the starred items by dungeon, the dungeon with the most on top.
-- A dungeon's header collapses it (until the game is reloaded).
local collapsedWish = {}
local function ToggleWishGroup(row)
    local name = row.wishGroup
    if not name then return end
    collapsedWish[name] = not collapsedWish[name] or nil
    PF:RefreshUI()
end
local function ConfirmClearWishlist()
    PF:ShowDialog({
        title = "Clear your wishlist?",
        text = "This removes every item from this character's wishlist, including the ones you have received. It can't be undone.",
        buttons = {
            { text = "Clear wishlist", onClick = function()
                PF:ClearWishlist()
                PF:RefreshUI()
            end },
            { text = "Cancel" },
        },
    })
end
-- A gold star at the right of a wishlist row: clicking it takes the item off the list.
do
local STAR_ON = "auctionhouse-icon-favorite"
function PF.WishlistStar(row, w)
    local star = row.wlStar
    if not star then
        star = CreateFrame("Button", nil, row)
        star:SetSize(18, 18)
        star:SetPoint("TOPRIGHT", row, "TOPRIGHT", -12, -8)
        star.tex = star:CreateTexture(nil, "OVERLAY")
        star.tex:SetAllPoints()
        star.fallback = star:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        star.fallback:SetPoint("CENTER", 0, -3)
        star.fallback:SetText("*")
        star.fallback:SetTextColor(1, 0.82, 0)
        star:SetScript("OnClick", function(self)
            local it = self.wish
            if not (it and it.id) then return end
            PF:ToggleWish({ id = it.id, name = it.name }) -- it is on the list, so this takes it off
            PlayUISound("IG_MAINMENU_OPTION_CHECKBOX_OFF")
            GameTooltip:Hide()
            PF:RefreshUI()
        end)
        star:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("On your wishlist", 1, 0.82, 0)
            GameTooltip:AddLine("Click to take it off.", 0.6, 0.6, 0.6)
            GameTooltip:Show()
        end)
        star:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row.wlStar = star
    end
    star.wish = w
    if C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(STAR_ON) then
        star.tex:SetAtlas(STAR_ON)
        star.tex:Show()
        star.fallback:Hide()
    else
        star.tex:Hide()
        star.fallback:Show()
    end
    star:Show()
end
end

local function RenderWishlist()
    SetStickyHeader(nil) -- also puts the list back right under the tabs
    local entries = PF:WishlistEntries()
    local i, y = 0, 0
    if #entries == 0 then
        i = i + 1
        y = y + LayoutRow(AcquireRow(), i, y, "Nothing on your wishlist yet", COLOR_MUTED,
            "Star items in a boss' loot to add them.")
        scrollChild:SetHeight(math.max(y, 1))
        return
    end
    local groups, order, anyGot = {}, {}, false
    for _, w in ipairs(entries) do
        local key = w.dungeon or "Other"
        local g = groups[key]
        if not g then g = { name = key, items = {}, todo = 0 }; groups[key] = g; order[#order + 1] = g end
        g.items[#g.items + 1] = w
        if w.got then anyGot = true else g.todo = g.todo + 1 end
    end
    table.sort(order, function(a, b)
        if #a.items ~= #b.items then return #a.items > #b.items end
        if a.todo ~= b.todo then return a.todo > b.todo end
        return a.name < b.name
    end)
    for _, g in ipairs(order) do
        local dungeon
        for _, d in ipairs(PathForeverData.Dungeons) do if d.name == g.name then dungeon = d break end end
        i = i + 1
        local header = AcquireRow()
        y = y + LayoutSectionHeader(header, y, string.format("%s  (%d)", g.name, #g.items), ToggleWishGroup, not collapsedWish[g.name])
        header.wishGroup = g.name
        for _, w in ipairs(collapsedWish[g.name] and {} or g.items) do
            i = i + 1
            local name = w.name or (w.id and C_Item.GetItemInfo(w.id)) or ("Item " .. tostring(w.id))
            local parts = {}
            if w.slot and w.slot ~= "" then parts[#parts + 1] = w.slot end
            if w.boss then parts[#parts + 1] = w.boss end
            if w.got then parts[#parts + 1] = "Got it" end
            local icon = w.id and C_Item.GetItemIconByID(w.id)
            -- the name in the item's rarity color; plain until the client has the item
            local nameColor = COLOR_TEXT
            if w.id then
                local _, _, quality = C_Item.GetItemInfo(w.id)
                local qc = quality and ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[quality]
                if qc then
                    nameColor = { qc.r, qc.g, qc.b }
                elseif C_Item.RequestLoadItemDataByID and not requestedItemData[w.id] then
                    requestedItemData[w.id] = true
                    C_Item.RequestLoadItemDataByID(w.id)
                end
            end
            local row = AcquireRow()
            y = y + LayoutRow(row, i, y, name, nameColor, table.concat(parts, "\n"), function()
                PF:OpenTab("Dungeons", dungeon)
            end, nil, nil, " ", nil, icon) -- the blank right text keeps the words clear of the star
            row.rowItem = w
            row:EnableMouse(true)
            if w.id then PF.WishlistStar(row, w) end
        end
    end
    if anyGot then
        i = i + 1
        y = y + LayoutRow(AcquireRow(), i, y, "Clear received items", COLOR_MUTED, "", function()
            PF:ClearReceivedWishes()
            PF:RefreshUI()
        end)
    end
    i = i + 1
    y = y + LayoutRow(AcquireRow(), i, y, "Clear wishlist", COLOR_BAD, "Removes every item from the list", ConfirmClearWishlist)
    scrollChild:SetHeight(math.max(y, 1))
end

-- ---------- Upgrades page (the logic is in Upgrades.lua) ----------
do
local STAR_ON, STAR_OFF = "auctionhouse-icon-favorite", "auctionhouse-icon-favorite-off"

local function StyleStar(star)
    local on = star.item and PF:GetWish(star.item.id)
    local atlas = on and STAR_ON or STAR_OFF
    if C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(atlas) then
        star.fallback:Hide()
        star.tex:SetAtlas(atlas)
        star.tex:SetAlpha(on and 1 or 0.6)
        star.tex:Show()
    else
        star.tex:Hide()
        star.fallback:SetText("*")
        if on then star.fallback:SetTextColor(1, 0.82, 0) else star.fallback:SetTextColor(0.5, 0.5, 0.5) end
        star.fallback:Show()
    end
end

local function UpgradeStar(row)
    local star = row.upStar
    if not star then
        star = CreateFrame("Button", nil, row)
        star:SetSize(18, 18)
        star:SetPoint("TOPRIGHT", row, "TOPRIGHT", -8 - RIGHT_TEXT_WIDTH - 4, -6)
        star.tex = star:CreateTexture(nil, "OVERLAY")
        star.tex:SetAllPoints()
        star.fallback = star:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        star.fallback:SetPoint("CENTER", 0, -3)
        star:SetScript("OnClick", function(self)
            local it = self.item
            if not it then return end
            PF:ToggleWish({ id = it.id, name = it.name, slot = it.slot }, it.dungeonName, it.bossName)
            StyleStar(self)
            PlayUISound(PF:GetWish(it.id) and "IG_MAINMENU_OPTION_CHECKBOX_ON" or "IG_MAINMENU_OPTION_CHECKBOX_OFF")
        end)
        star:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(self.item and PF:GetWish(self.item.id) and "On your wishlist" or "Add to your wishlist", 1, 1, 1)
            GameTooltip:Show()
        end)
        star:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row.upStar = star
    end
    return star
end

-- The Raids tab: the raids with their loading-screen art, like the Dungeons list. A raid still
-- marked comingSoon (all of them until Forever opens its raids) says so in red and does not click.
local RAID_SOON_DATE = "Coming December 9th"

-- The raids this character is saved to, by name -> seconds until the lockout resets (0 if unknown).
-- The game's own saved-instance list, read in pcall; unverified on Forever (docs/launch-checklist.md).
-- (In a table: UI.lua is at Lua's locals limit.)
PF.RaidLock = { saved = {}, askedAt = -100 }
do
    local R = PF.RaidLock
    function R.Read()
        wipe(R.saved)
        if not GetNumSavedInstances then return end
        local okN, n = pcall(GetNumSavedInstances)
        if not okN or type(n) ~= "number" then return end
        for i = 1, n do
            local ok, name, _, reset, _, locked, extended, _, isRaid = pcall(GetSavedInstanceInfo, i)
            if ok and type(name) == "string" and isRaid and (locked or extended) then
                R.saved[name] = tonumber(reset) or 0
            end
        end
    end
    -- kind "raid" (the green entrance swirl, else a skull) or "dungeon" (the blue one, else a key)
    function R.SetIcon(tex, kind)
        local atlas = kind == "dungeon" and "Dungeon" or "Raid"
        local info = C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(atlas)
        if info then tex:SetAtlas(atlas)
        else tex:SetTexture(kind == "dungeon" and "Interface\\Icons\\INV_Misc_Key_03" or "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01") end
    end
    local f = CreateFrame("Frame")
    pcall(f.RegisterEvent, f, "UPDATE_INSTANCE_INFO")
    f:SetScript("OnEvent", function()
        R.Read()
        if PathForeverDB and PathForeverDB.activeTab == "Raids" and PF.RefreshUI then PF:RefreshUI() end
    end)
end

function PF:RenderRaidsTab()
    SetStickyHeader(nil)
    local R = PF.RaidLock
    if RequestRaidInfo and GetTime() - R.askedAt > 15 then
        R.askedAt = GetTime()
        pcall(RequestRaidInfo)
    end
    R.Read()
    local y, section, n = 0, nil, 0
    for _, d in ipairs(PathForeverData.Raids or {}) do
        local which = (d.tier == 1) and "first" or "later"
        if which ~= section then
            section = which
            y = y + LayoutSectionHeader(AcquireRow(), y, which == "first" and RAID_SOON_DATE or "Coming Soon...")
        end
        n = n + 1
        local row = AcquireRow()
        local sub
        if d.zone then sub = d.zone .. (d.players and ("\n" .. d.players .. " players") or "") end
        local h = LayoutRow(row, n, y, d.name, d.comingSoon and COLOR_MUTED or COLOR_TEXT, sub, nil, nil, nil, "")
        -- the raid icon, where the level used to be: lit, or grey and faded while this character is saved to the raid
        local lock = row.lockIcon
        if not lock then
            lock = row:CreateTexture(nil, "ARTWORK", nil, 2)
            lock:SetSize(16, 16)
            lock:SetPoint("TOPRIGHT", row, "TOPRIGHT", -12, -8)
            row.lockIcon = lock
        end
        R.SetIcon(lock, "raid")
        local saved = R.saved[d.name]
        lock:SetDesaturated(saved ~= nil)
        lock:SetAlpha(saved ~= nil and 0.45 or 1)
        lock:Show()
        row.tooltip = saved ~= nil and "Saved" or "Not saved"
        if d.art then ShowDungeonArt(row.art, d, ROW_WIDTH, h) end
        y = y + h
    end
    scrollChild:SetHeight(math.max(y, 1))
end

function PF:RenderUpgradesTab()
    SetStickyHeader(nil)
    local U = PF.Upgrades
    local result = U:Compute()
    local spec = result.spec
    local i, y = 1, 0

    -- the spec: one icon per talent tree, the one in use lit; clicking one picks it by hand
    -- (saved per character), clicking the picked one again goes back to automatic
    local bar = PF.upSpecBar
    if not bar then
        bar = CreateFrame("Frame", nil, scrollChild)
        bar:SetHeight(46)
        bar.icons = {}
        for n = 1, 3 do
            local b = CreateFrame("Button", nil, bar, "BackdropTemplate")
            b:SetSize(34, 34)
            b:SetPoint("TOPLEFT", bar, "TOPLEFT", 12 + (n - 1) * 42, -6)
            b:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
            b:SetBackdropColor(0, 0, 0, 0.5)
            b.tex = b:CreateTexture(nil, "ARTWORK")
            b.tex:SetPoint("TOPLEFT", 2, -2)
            b.tex:SetPoint("BOTTOMRIGHT", -2, 2)
            b.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            b.index = n
            b:SetScript("OnClick", function(self)
                local U2 = PF.Upgrades
                PlayUISound("IG_CHARACTER_INFO_TAB")
                if U2:GetChoice() == self.index then U2:SetChoice(nil) else U2:SetChoice(self.index) end
                PF:RefreshUI()
            end)
            b:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.specName or "", 1, 1, 1)
                GameTooltip:AddLine(self.note or "", 0.6, 0.6, 0.6, true)
                GameTooltip:Show()
            end)
            b:SetScript("OnLeave", function() GameTooltip:Hide() end)
            bar.icons[n] = b
        end
        PF.upSpecBar = bar
    end
    bar:ClearAllPoints()
    bar:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, 0)
    bar:SetWidth(ROW_WIDTH)
    local ar, ag, ab = GetAccentColor()
    for n = 1, 3 do
        local b = bar.icons[n]
        local name, icon = U:SpecIcon(n)
        local lit = spec.index == n
        b.specName, b.note = name, lit and (spec.hand and "Picked by you. Click to go back to automatic." or "From your talents. Click another to pick by hand.") or "Click to look for this spec's gear."
        b.tex:SetTexture(icon)
        b.tex:SetDesaturated(not lit)
        b.tex:SetAlpha(lit and 1 or 0.55)
        b:SetBackdropBorderColor(ar, ag, ab, lit and 0.95 or 0.2)
        b:Show()
    end
    bar:Show()
    y = y + 46

    local total = 0
    for _, g in ipairs(result.groups) do total = total + g.total end
    if total == 0 and result.pending == 0 then
        i = i + 1
        y = y + LayoutRow(AcquireRow(), i, y, "No upgrades found", COLOR_MUTED,
            "Nothing in the dungeons or class quests beats what you wear right now.")
        scrollChild:SetHeight(math.max(y, 1))
        return
    end

    for _, g in ipairs(result.groups) do
        i = i + 1
        y = y + LayoutSectionHeader(AcquireRow(), y, string.format("%s  (%d)", g.name, g.total))
        for _, v in ipairs(g.items) do
            i = i + 1
            local qc = v.quality and ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[v.quality]
            local c = v.c
            local dungeon = c.dungeon
            local sub = U:SourceText(v) .. "\nLv " .. v.minLevel .. ", ilvl " .. v.ilvl
            local row = AcquireRow()
            -- no click-through to the boss or quest until it is checked in Forever (docs/launch-checklist.md)
            y = y + LayoutRow(row, i, y, v.name, qc and { qc.r, qc.g, qc.b } or COLOR_TEXT, sub, nil, nil, nil, v.text, nil, v.icon)
            row.rowItem = v
            row:EnableMouse(true)
            local star = UpgradeStar(row)
            star.item = { id = v.id, name = v.name, slot = c.slot, dungeonName = dungeon and dungeon.name, bossName = c.group and c.group.title or (c.classQuest and c.classQuest[2]) }
            StyleStar(star)
            star:Show()
        end
    end
    scrollChild:SetHeight(math.max(y, 1))
end
end

-- ---------- History page (the logic is in History.lua) ----------
function PF.EndRunClick()
    PlayUISound("IG_CHARACTER_INFO_TAB")
    PF.History:EndRun()
    PF:RefreshUI()
end

function PF.OpenRunSummary(row)
    PlayUISound("IG_QUEST_LIST_SELECT")
    if row.run then PF.History:ShowRun(row.run) end
end

-- The running clock on the page ticks every second (History.lua asks), without a redraw.
function PF.UpdateHistoryClock()
    local row, H = PF.historyClockRow, PF.History
    if not (row and row.isClock and row:IsVisible() and PathForeverDB.activeTab == "History") then return end
    local cur = H:Current()
    if not cur or cur.away then return end
    row.right:SetText(H.Duration(H:Elapsed() or 0))
end

function PF:RenderHistoryTab()
    SetStickyHeader(nil)
    local H = PF.History
    local i, y = 0, 0
    if PF.historyClockRow then PF.historyClockRow.isClock = false end
    PF.historyClockRow = nil
    local endButton = PF.historyEndButton
    if not endButton then
        endButton = CreateFrame("Button", nil, scrollChild)
        endButton:SetSize(64, 22)
        endButton.text = endButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        endButton.text:SetPoint("CENTER")
        endButton.text:SetText("End run")
        endButton.text:SetTextColor(unpack(COLOR_TEXT))
        endButton:SetScript("OnClick", PF.EndRunClick)
        StyleOutlineButton(endButton)
        PF.historyEndButton = endButton
    end
    endButton:Hide()
    local cur = H:Current()
    i = i + 1
    if cur and cur.away then
        local row = AcquireRow()
        local h = LayoutRow(row, i, y, cur.name, COLOR_TEXT, "|cffff4040Paused|r", nil, nil, nil, H.Duration(H:Elapsed() or 0))
        -- the End run button sits to the left of the timer
        endButton:ClearAllPoints()
        endButton:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", ROW_WIDTH - 8 - RIGHT_TEXT_WIDTH - 6 - 64, -(y + 7))
        endButton:SetFrameLevel(row:GetFrameLevel() + 5)
        endButton:Show()
        y = y + h
    elseif cur then
        local row = AcquireRow()
        y = y + LayoutRow(row, i, y, "In " .. cur.name, COLOR_TEXT, "Run in progress", nil, nil, nil, H.Duration(H:Elapsed() or 0))
        row.isClock = true
        PF.historyClockRow = row
    else
        y = y + LayoutRow(AcquireRow(), i, y, "Not in a dungeon", COLOR_MUTED, "A run starts when you walk in and is saved when you leave.")
    end
    local wide = H:AccountWide()
    i = i + 1
    y = y + LayoutRow(AcquireRow(), i, y, "Show the whole account", COLOR_TEXT,
        "Runs of every character, with their names", function()
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.historyAccount = not H:AccountWide()
            PlayCheckboxSound(PathForeverDB.options.historyAccount)
            PF:RefreshUI()
        end, nil, wide)
    local runs = H:Recent()
    if #runs == 0 then
        i = i + 1
        y = y + LayoutRow(AcquireRow(), i, y, "No runs yet", COLOR_MUTED, wide and "Stay in a dungeon for a couple of minutes and it is listed here." or "None for this character. Stay in a dungeon for a couple of minutes and it is listed here.")
        scrollChild:SetHeight(math.max(y, 1))
        return
    end
    i = i + 1
    y = y + LayoutSectionHeader(AcquireRow(), y, string.format("Latest runs  (%d)", H:Count()))
    for _, r in ipairs(runs) do
        i = i + 1
        local row = AcquireRow()
        local when = date and date("%d %b", r.finish) or nil
        local who = wide and H:CharName(r) or nil
        y = y + LayoutRow(row, i, y, r.name, COLOR_TEXT, (who and (who .. " - ") or "") .. (when and (when .. " - ") or "") .. H:Describe(r), PF.OpenRunSummary)
        row.run = r
    end
    i = i + 1
    y = y + LayoutRow(AcquireRow(), i, y, "Clear history", COLOR_MUTED, "Removes every saved run, of every character.", function()
        PF:ShowDialog({
            title = "Clear the history?",
            text = "This removes every saved run. The run in progress is kept.",
            buttons = {
                { text = "Clear", onClick = function() H:Clear(); PF:RefreshUI() end },
                { text = "Cancel" },
            },
        })
    end)
    scrollChild:SetHeight(math.max(y, 1))
end

-- ---------- Bank page (the logic is in Bank.lua) ----------
-- A small menu that floats over the window beside the button that opened it (like a tooltip)
-- and goes when a choice is made or anything else is clicked. options = { { key, text, color } }.
function PF:ShowChoiceMenu(anchor, options, current, onPick)
    local m = PF.choiceMenu
    if not m then
        m = CreateFrame("Frame", "PathForeverChoiceMenu", UIParent, "BackdropTemplate")
        m:SetFrameStrata("FULLSCREEN_DIALOG")
        m:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
        m:SetBackdropColor(0.04, 0.09, 0.15, 0.97)
        m:EnableMouse(true)
        m.items = {}
        m.catcher = CreateFrame("Button", nil, UIParent)
        m.catcher:SetFrameStrata("FULLSCREEN_DIALOG")
        m.catcher:SetAllPoints(UIParent)
        m.catcher:SetScript("OnClick", function() m:Hide() end)
        m:SetScript("OnShow", function() m.catcher:Show() end)
        m:SetScript("OnHide", function() m.catcher:Hide() end)
        m:SetFrameLevel(m.catcher:GetFrameLevel() + 5)
        if frame then frame:HookScript("OnHide", function() m:Hide() end) end
        m:Hide()
        PF.choiceMenu = m
    end
    local ar, ag, ab = GetAccentColor()
    m:SetBackdropBorderColor(ar, ag, ab, 0.6)
    local ROW, W = 22, math.max(anchor:GetWidth() or 0, 150)
    for n, o in ipairs(options) do
        local b = m.items[n]
        if not b then
            b = CreateFrame("Button", nil, m)
            b:SetHeight(ROW)
            b.text = b:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            b.text:SetPoint("LEFT", 10, 0)
            b.hl = b:CreateTexture(nil, "HIGHLIGHT")
            b.hl:SetAllPoints()
            b.hl:SetColorTexture(1, 1, 1, 0.08)
            b:SetScript("OnClick", function(self)
                PlayUISound("IG_CHARACTER_INFO_TAB")
                m:Hide()
                if m.onPick then m.onPick(self.key) end
            end)
            m.items[n] = b
        end
        b:ClearAllPoints()
        b:SetPoint("TOPLEFT", m, "TOPLEFT", 1, -1 - (n - 1) * ROW)
        b:SetPoint("TOPRIGHT", m, "TOPRIGHT", -1, -1 - (n - 1) * ROW)
        b.key = o.key
        b.text:SetText(o.text)
        local c = o.color
        if o.key == current then b.text:SetTextColor(ar, ag, ab)
        elseif c then b.text:SetTextColor(c[1], c[2], c[3])
        else b.text:SetTextColor(unpack(COLOR_TEXT)) end
        b:Show()
    end
    for n = #options + 1, #m.items do m.items[n]:Hide() end
    m.onPick = onPick
    m:SetSize(W, #options * ROW + 2)
    m:ClearAllPoints()
    m:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -2)
    m:Show()
    m:Raise()
end

do
local requestedBankItems = {}
local bankSearch = ""
local SORTS = { { key = "type", text = "Type" }, { key = "rarity", text = "Rarity" }, { key = "ilvl", text = "Item level" },
                { key = "name", text = "Name" }, { key = "count", text = "Stack size" } }
local KINDS = { { "Armor", 4 }, { "Weapons", 2 }, { "Consumables", 0 }, { "Trade goods", 7 }, { "Recipes", 9 },
                { "Quest", 12 }, { "Containers", 1 }, { "Gems", 3 }, { "Miscellaneous" }, { "Junk" } }
local RARITY = { [5] = "Legendary", [4] = "Epic", [3] = "Rare", [2] = "Uncommon", [1] = "Common", [0] = "Poor" }

-- the saved items of one bank with what the client knows about each
local function BuildEntries(items, filter)
    local out = {}
    for _, e in ipairs(items) do
        if type(e) == "table" and type(e.id) == "number" then
            local name, _, quality, ilvl, _, _, _, _, _, _, _, classID = C_Item.GetItemInfo(e.id)
            if not classID and C_Item.GetItemInfoInstant then
                local ok, _, _, _, _, _, cid = pcall(C_Item.GetItemInfoInstant, e.id)
                if ok then classID = cid end
            end
            if not name and C_Item.RequestLoadItemDataByID and not requestedBankItems[e.id] then
                requestedBankItems[e.id] = true
                C_Item.RequestLoadItemDataByID(e.id)
            end
            if not filter or (name and name:lower():find(filter, 1, true)) then
                out[#out + 1] = { id = e.id, count = tonumber(e.count) or 1, name = name, quality = quality or 0,
                                  classID = classID, ilvl = tonumber(ilvl) or 0 }
            end
        end
    end
    return out
end

local function KindOf(e)
    if e.quality == 0 then return "Junk" end
    for _, k in ipairs(KINDS) do if k[2] and k[2] == e.classID then return k[1] end end
    return "Miscellaneous"
end

local function Sorter(key)
    local function ByName(a, b) return (a.name or "~") < (b.name or "~") end
    if key == "ilvl" then
        return function(a, b) if a.ilvl ~= b.ilvl then return a.ilvl > b.ilvl end return ByName(a, b) end
    elseif key == "count" then
        return function(a, b) if a.count ~= b.count then return a.count > b.count end return ByName(a, b) end
    elseif key == "name" then
        return ByName
    end
    return function(a, b) if a.quality ~= b.quality then return a.quality > b.quality end return ByName(a, b) end
end

-- The bar at the top of the page: the character and sort buttons, and the search box.
local BAR_H = 70
local function Bar()
    local bar = PF.bankBar
    if bar then return bar end
    bar = CreateFrame("Frame", nil, scrollChild)
    bar:SetHeight(BAR_H)
    local function Button(width, anchorPoint, x)
        local b = CreateFrame("Button", nil, bar, "BackdropTemplate")
        b:SetSize(width, 24)
        b:SetPoint(anchorPoint, bar, anchorPoint, x, -8)
        b:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
        b:SetBackdropColor(1, 1, 1, 0.04)
        b:SetBackdropBorderColor(1, 1, 1, 0.18)
        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        b.text:SetPoint("LEFT", 8, 0)
        b.text:SetPoint("RIGHT", -18, 0)
        b.text:SetJustifyH("LEFT")
        b.arrow = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        b.arrow:SetPoint("RIGHT", -6, 0)
        b.arrow:SetText("v")
        b.arrow:SetTextColor(unpack(COLOR_MUTED))
        b:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(GetAccentColor()) end)
        b:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(1, 1, 1, 0.18) end)
        return b
    end
    bar.charBtn = Button(214, "TOPLEFT", 12)
    bar.sortBtn = Button(140, "TOPRIGHT", -12)
    bar.charBtn:SetScript("OnClick", function(self)
        local list = PF.Bank:Characters()
        if #list < 2 then return end
        local opts = {}
        for _, c in ipairs(list) do
            local rc = c.class and RAID_CLASS_COLORS and RAID_CLASS_COLORS[c.class]
            opts[#opts + 1] = { key = c.guid, text = c.name, color = rc and { rc.r, rc.g, rc.b } }
        end
        local cur = PF.Bank:GetSelected()
        PF:ShowChoiceMenu(self, opts, cur and cur.guid, function(guid)
            PF.Bank:Select(guid)
            PF:RefreshUI()
        end)
    end)
    bar.sortBtn:SetScript("OnClick", function(self)
        local cur = PathForeverDB.options and PathForeverDB.options.bankSort or "type"
        PF:ShowChoiceMenu(self, SORTS, cur, function(key)
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.bankSort = key
            PF:RefreshUI()
        end)
    end)
    local box = CreateFrame("EditBox", nil, bar, "BackdropTemplate")
    box:SetPoint("TOPLEFT", bar, "TOPLEFT", 12, -40)
    box:SetPoint("TOPRIGHT", bar, "TOPRIGHT", -12, -40)
    box:SetHeight(24)
    box:SetAutoFocus(false)
    box:SetTextInsets(8, 8, 0, 0)
    box:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
    box:SetBackdropColor(0, 0, 0, 0.35)
    box:SetBackdropBorderColor(1, 1, 1, 0.18)
    if GameFontHighlightSmall then box:SetFontObject(GameFontHighlightSmall) end
    box.hint = box:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    box.hint:SetPoint("LEFT", 8, 0)
    box.hint:SetText("Search every character's bank")
    box.hint:SetTextColor(unpack(COLOR_MUTED))
    box:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    box:SetScript("OnEditFocusGained", function(self) self:SetBackdropBorderColor(GetAccentColor()) end)
    box:SetScript("OnEditFocusLost", function(self) self:SetBackdropBorderColor(1, 1, 1, 0.18) end)
    box:SetScript("OnTextChanged", function(self)
        local t = (self:GetText() or ""):lower()
        self.hint:SetShown(t == "")
        if t ~= bankSearch then
            bankSearch = t
            local had = self:HasFocus()
            PF:RefreshUI()
            if had and not self:HasFocus() then self:SetFocus() end
        end
    end)
    bar.search = box
    PF.bankBar = bar
    return bar
end

function PF:RenderBankTab()
    SetStickyHeader(nil)
    local B = PF.Bank
    local current, list = B:GetSelected()
    local i, y = 0, 0
    if not current then
        i = i + 1
        y = y + LayoutRow(AcquireRow(), i, y, "No bank seen yet", COLOR_MUTED,
            "Open your bank once to see it here.")
        scrollChild:SetHeight(math.max(y, 1))
        return
    end
    local sortKey = PathForeverDB.options and PathForeverDB.options.bankSort or "type"
    local sortName = "Type"
    for _, o in ipairs(SORTS) do if o.key == sortKey then sortName = o.text end end

    local bar = Bar()
    bar:ClearAllPoints()
    bar:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, 0)
    bar:SetWidth(ROW_WIDTH)
    bar.charBtn.text:SetText(current.name)
    local cc = current.class and RAID_CLASS_COLORS and RAID_CLASS_COLORS[current.class]
    if cc then bar.charBtn.text:SetTextColor(cc.r, cc.g, cc.b) else bar.charBtn.text:SetTextColor(unpack(COLOR_TEXT)) end
    bar.charBtn.arrow:SetShown(#list > 1)
    bar.sortBtn.text:SetText("Sort: " .. sortName)
    bar.sortBtn.text:SetTextColor(unpack(COLOR_TEXT))
    if bar.search:GetText() ~= bankSearch then bar.search:SetText(bankSearch) end
    bar.search.hint:SetShown(bankSearch == "")
    bar:Show()
    y = y + BAR_H

    -- what to show: one bank grouped by the sort, or every bank's matches when searching
    local sorter = Sorter(sortKey)
    local groups, order = {}, {}
    local function Add(key, e)
        if not groups[key] then groups[key] = {}; order[#order + 1] = key end
        table.insert(groups[key], e)
    end
    if bankSearch ~= "" then
        for _, c in ipairs(list) do
            local found = BuildEntries(c.items, bankSearch)
            table.sort(found, sorter)
            for _, e in ipairs(found) do Add(c.name, e) end
        end
        if #order == 0 then
            i = i + 1
            y = y + LayoutRow(AcquireRow(), i, y, "No matches", COLOR_MUTED)
        end
    else
        local entries = BuildEntries(current.items)
        table.sort(entries, sorter)
        if #entries == 0 then
            i = i + 1
            y = y + LayoutRow(AcquireRow(), i, y, "The bank was empty", COLOR_MUTED)
        end
        if sortKey == "rarity" then
            for q = 5, 0, -1 do
                for _, e in ipairs(entries) do if math.min(e.quality, 5) == q then Add(RARITY[q], e) end end
            end
        elseif sortKey == "type" then
            for _, k in ipairs(KINDS) do
                for _, e in ipairs(entries) do if KindOf(e) == k[1] then Add(k[1], e) end end
            end
        else
            for _, e in ipairs(entries) do Add("All items", e) end
        end
    end

    -- the grids: empty slots fill out each row, hovering an icon shows the item, Shift-click links it
    local grid = PF.bankGrid
    if not grid then
        grid = { cells = {} }
        PF.bankGrid = grid
    end
    local CELL, GAP, EDGE = 38, 5, 2
    local cols = math.max(1, math.floor((ROW_WIDTH - 24 + GAP) / (CELL + GAP)))
    local n = 0
    local function Cell(e, col, top)
        n = n + 1
        local cell = grid.cells[n]
        if not cell then
            cell = CreateFrame("Button", nil, scrollChild)
            cell:SetSize(CELL, CELL)
            cell.bg = cell:CreateTexture(nil, "BACKGROUND")
            cell.bg:SetAllPoints()
            cell.bg:SetColorTexture(0.03, 0.05, 0.08, 0.85)
            cell.tex = cell:CreateTexture(nil, "ARTWORK")
            cell.tex:SetPoint("TOPLEFT", EDGE, -EDGE)
            cell.tex:SetPoint("BOTTOMRIGHT", -EDGE, EDGE)
            cell.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            -- the rarity border: four plain lines over the icon's edge
            cell.edges = {}
            for k = 1, 4 do cell.edges[k] = cell:CreateTexture(nil, "OVERLAY", nil, 2) end
            cell.edges[1]:SetPoint("TOPLEFT"); cell.edges[1]:SetPoint("TOPRIGHT"); cell.edges[1]:SetHeight(EDGE)
            cell.edges[2]:SetPoint("BOTTOMLEFT"); cell.edges[2]:SetPoint("BOTTOMRIGHT"); cell.edges[2]:SetHeight(EDGE)
            cell.edges[3]:SetPoint("TOPLEFT"); cell.edges[3]:SetPoint("BOTTOMLEFT"); cell.edges[3]:SetWidth(EDGE)
            cell.edges[4]:SetPoint("TOPRIGHT"); cell.edges[4]:SetPoint("BOTTOMRIGHT"); cell.edges[4]:SetWidth(EDGE)
            cell.count = cell:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
            cell.count:SetPoint("BOTTOMRIGHT", -3, 3)
            cell.hl = cell:CreateTexture(nil, "HIGHLIGHT")
            cell.hl:SetAllPoints()
            cell.hl:SetColorTexture(1, 1, 1, 0.15)
            cell:SetScript("OnEnter", function(self) if self.rowItem then PF.RowItemEnter(self) end end)
            cell:SetScript("OnLeave", function() GameTooltip:Hide() end)
            cell:SetScript("OnClick", function(self) if self.rowItem then PF.RowItemClick(self) end end)
            grid.cells[n] = cell
        end
        cell:ClearAllPoints()
        cell:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 12 + col * (CELL + GAP), -top)
        cell:EnableMouse(e ~= nil)
        cell.rowItem = e
        local r, g, b, a
        if e then
            cell.tex:SetTexture(C_Item.GetItemIconByID(e.id))
            cell.tex:Show()
            local qc = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[e.quality]
            if qc then r, g, b, a = qc.r, qc.g, qc.b, 1 else r, g, b, a = 0.7, 0.7, 0.7, 1 end
            cell.count:SetText(e.count > 1 and e.count or "")
        else
            cell.tex:Hide()
            cell.count:SetText("")
            r, g, b, a = 1, 1, 1, 0.08
        end
        for _, line in ipairs(cell.edges) do line:SetColorTexture(r, g, b, a) end
        cell:Show()
    end
    for _, key in ipairs(order) do
        local items = groups[key]
        i = i + 1
        y = y + LayoutSectionHeader(AcquireRow(), y, string.format("%s  (%d)", key, #items))
        y = y + 6
        local slots = math.ceil(#items / cols) * cols
        for slot = 0, slots - 1 do
            Cell(items[slot + 1], slot % cols, y + math.floor(slot / cols) * (CELL + GAP))
        end
        y = y + (slots / cols) * (CELL + GAP) + 6
    end
    for m = n + 1, #grid.cells do grid.cells[m]:Hide() end
    scrollChild:SetHeight(math.max(y, 1))
end
end

local function RenderProfessions()
    SetStickyHeader(nil)
    local statuses = PF:GetProfessionStatus()
    local y, i = 0, 0

    local primaryCount, hasCooking, hasFishing, hasFirstAid = PF:GetProfessionSlotSummary()

    -- Reminders - each shown until it no longer applies.
    local reminders = {}
    if primaryCount == 0 then
        table.insert(reminders, "You haven't learned a main profession yet")
    elseif primaryCount == 1 then
        table.insert(reminders, "You have room for another main profession")
    end
    local missing = {}
    if not hasFirstAid then missing[#missing + 1] = "First Aid" end
    if not hasCooking then missing[#missing + 1] = "Cooking" end
    if not hasFishing then missing[#missing + 1] = "Fishing" end
    if #missing > 0 then table.insert(reminders, "Not learned yet: " .. table.concat(missing, ", ")) end

    -- Tool nudges - only once the relevant gathering profession is trained.
    -- Mining Pick (2901) is a solid classic-era ID; the Skinning Knife
    -- (7005) check is included per your ask, but worth knowing: in
    -- original vanilla, Skinning never actually required a dedicated
    -- knife - any weapon worked - so this one may not apply to Forever's
    -- ruleset at all. Flagging that rather than guessing.
    for _, p in ipairs(statuses) do
        if p.isPrimary and p.name == "Mining" and not PF:HasAnyItemInBags({ 2901 }) then
            table.insert(reminders, "You'll need a Mining Pick in your bags")
        end
        if p.isPrimary and p.name == "Skinning" and not PF:HasAnyItemInBags({ 7005 }) then
            table.insert(reminders, "You'll need a Skinning Knife in your bags")
        end
    end

    if #reminders > 0 then
        if not professionReminderBox then
            local box = CreateFrame("Frame", nil, scrollChild, "BackdropTemplate")
            box:SetBackdrop({
                bgFile = "Interface\\Buttons\\WHITE8X8",
                edgeFile = "Interface\\Buttons\\WHITE8X8",
                edgeSize = 1,
            })
            -- A quiet note, not an alarm: faint panel, thin border, normal text.
            box:SetBackdropColor(1, 1, 1, 0.04)
            box:SetBackdropBorderColor(1, 1, 1, 0.15)
            box.text = box:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            box.text:SetPoint("TOPLEFT", 10, -8)
            box.text:SetWidth(ROW_WIDTH - 20)
            box.text:SetJustifyH("LEFT")
            box.text:SetSpacing(3)
            box.text:SetTextColor(COLOR_TEXT[1], COLOR_TEXT[2], COLOR_TEXT[3])
            professionReminderBox = box
        end
        professionReminderBox.text:SetText(table.concat(reminders, "\n"))
        professionReminderBox:ClearAllPoints()
        professionReminderBox:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -y)
        professionReminderBox:SetWidth(ROW_WIDTH)
        professionReminderBox:SetHeight(professionReminderBox.text:GetStringHeight() + 16)
        professionReminderBox:Show()
        y = y + professionReminderBox:GetHeight() + 12
    elseif professionReminderBox then
        professionReminderBox:Hide()
    end

    if #statuses == 0 then
        i = i + 1
        local row = AcquireRow()
        y = y + LayoutRow(row, i, y, "No professions learned yet", COLOR_MUTED, "")
    end

    for _, p in ipairs(statuses) do
        i = i + 1
        local row = AcquireRow()
        -- The name shows the pace at a glance: green on pace or ahead, orange a
        -- little behind, red more than PACE_FAR_BEHIND points behind.
        local gap = (p.expected or 0) - (p.skillLevel or 0)
        local color = (gap > PACE_FAR_BEHIND and COLOR_BAD) or (gap > 0 and COLOR_WARN) or COLOR_GOOD
        local pace = gap > 0 and string.format("%d point%s behind", gap, gap == 1 and "" or "s") or "on pace"
        local subText = string.format("%d / %d\n%s", p.skillLevel, p.maxSkillLevel, pace)
        -- A click opens the profession's pop-out, never the profession itself: on
        -- Forever, C_TradeSkillUI.OpenTradeSkill reopens the first profession opened
        -- whatever it's asked for, and a secure spell button over the row didn't open
        -- anything either (2026-09-29).
        local h = LayoutRow(row, i, y, p.name, color, subText, function()
            ShowSidePanel("info", ProfessionSubject(p))
        end, nil, nil, nil, nil, p.icon)
        ShowProfessionArt(row.art, p.skillLine, ROW_WIDTH, h)
        y = y + h
    end

    local altTrackingOn = not PathForeverDB.options or PathForeverDB.options.altTracking ~= false
    local others = altTrackingOn and PF:GetOtherCharacters() or {}
    -- Shown even with no alts saved yet, so the note below explains why the list is empty.
    if altTrackingOn then
        i = i + 1
        local altHeader = AcquireRow()
        y = y + LayoutSectionHeader(altHeader, y, "Other characters")

        -- Name and class in the class's color, then the level. A character
        -- that can't be drawn is skipped and counted, never allowed to stop
        -- the rest of the list.
        -- Hidden characters are only counted; the "Restore hidden characters"
        -- row below brings them back.
        local skipped, hiddenCount = 0, 0
        local function LayoutCharacter(char)
            local hex = ClassColorHex(char.class)
            local titleText = hex and (hex .. char.name .. "|r") or char.name
            if char.className and char.className ~= "" then
                titleText = titleText .. "  " .. (hex and (hex .. char.className .. "|r") or char.className)
            end

            local profLines = {}
            for _, prof in ipairs(char.professions) do
                table.insert(profLines, string.format("%s %d/%d", prof.name, prof.skillLevel, prof.maxSkillLevel))
            end
            local subText = (#profLines > 0) and table.concat(profLines, "\n") or "No main professions yet"

            i = i + 1
            local row = AcquireRow()
            local charKey, charName = char.key, char.name
            y = y + LayoutRow(row, i, y, titleText, COLOR_MUTED, subText, function()
                if IsShiftKeyDown() then
                    PF:ConfirmRemoveCharacter(charName, charKey)
                elseif IsControlKeyDown() then
                    PF:HideCharacter(charKey)
                    PF:RefreshUI()
                else
                    ShowSidePanel("info", AltSubject(char))
                end
            end, nil, nil, string.format("Lv %d", math.floor(char.level or 0)))
            row.tooltip = "Ctrl-click to hide. Shift-click to remove for good."
        end
        for _, char in ipairs(others) do
            if PF:IsCharacterHidden(char.key) then
                hiddenCount = hiddenCount + 1
            elseif not pcall(LayoutCharacter, char) then
                skipped = skipped + 1
            end
        end
        if hiddenCount > 0 then
            i = i + 1
            local row = AcquireRow()
            y = y + LayoutRow(row, i, y,
                string.format("Show %d hidden character%s", hiddenCount, hiddenCount == 1 and "" or "s"),
                COLOR_TEXT, "", function()
                    PF:RestoreHiddenCharacters()
                    PF:RefreshUI()
                end)
        end
        if skipped > 0 then
            i = i + 1
            local row = AcquireRow()
            y = y + LayoutRow(row, i, y,
                string.format("%d saved character%s couldn't be shown", skipped, skipped == 1 and "" or "s"),
                COLOR_MUTED, "Type /pf chars for details")
        end

        -- Profession data is only readable for the character that's logged in,
        -- so an alt appears here after it has been played once.
        i = i + 1
        local noteRow = AcquireRow()
        y = y + LayoutRow(noteRow, i, y, "Log in on a character once to add it here", COLOR_MUTED, "")
    end

    scrollChild:SetHeight(math.max(y, 1))
end

local function ToggleMinimapOption()
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.showMinimap = PathForeverDB.options.showMinimap == false
    PlayCheckboxSound(PathForeverDB.options.showMinimap)
    if PF.UpdateMinimapButton then PF:UpdateMinimapButton() end
    PF:RefreshUI()
end

local function ToggleFishingOption()
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.fishingWindow = PathForeverDB.options.fishingWindow == false
    PlayCheckboxSound(PathForeverDB.options.fishingWindow)
    if PF.Fishing then PF.Fishing:OptionChanged() end
    PF:RefreshUI()
end

local function ToggleLevelUpOption()
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.levelUpMessages = PathForeverDB.options.levelUpMessages == false
    PlayCheckboxSound(PathForeverDB.options.levelUpMessages)
    PF:RefreshUI()
end

local function ToggleTrainerRemindersOption()
    PathForeverDB.options = PathForeverDB.options or {}
    PathForeverDB.options.trainerReminders = PathForeverDB.options.trainerReminders == false
    PlayCheckboxSound(PathForeverDB.options.trainerReminders)
    PF:RefreshUI()
end

local function RenderOptions()
    SetStickyHeader(nil)
    local y, i = 0, 0

    i = i + 1
    local sectionHeader = AcquireRow()
    y = y + LayoutSectionHeader(sectionHeader, y, "Settings")
    local groupTop = y

    i = i + 1
    local altRow = AcquireRow()
    local altOn = not PathForeverDB.options or PathForeverDB.options.altTracking ~= false
    y = y + LayoutRow(altRow, i, y, "Track my other characters", COLOR_TEXT,
        "List their professions on the Professions tab", function()
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.altTracking = not (PathForeverDB.options.altTracking ~= false)
            PlayCheckboxSound(PathForeverDB.options.altTracking)
            PF:RefreshUI()
        end, nil, altOn)

    i = i + 1
    local minimapRow = AcquireRow()
    y = y + LayoutRow(minimapRow, i, y, "Show minimap button", COLOR_TEXT,
        "Without it, type /pf to open this window", ToggleMinimapOption, nil,
        not (PathForeverDB.options and PathForeverDB.options.showMinimap == false))

    i = i + 1
    local levelUpRow = AcquireRow()
    y = y + LayoutRow(levelUpRow, i, y, "Level-up messages", COLOR_TEXT,
        "A chat line when a dungeon opens up or a profession falls behind", ToggleLevelUpOption, nil,
        not (PathForeverDB.options and PathForeverDB.options.levelUpMessages == false))

    i = i + 1
    local trainerRow = AcquireRow()
    y = y + LayoutRow(trainerRow, i, y, "Trainer reminders", COLOR_TEXT,
        "A chat line in cities and inns when skills are waiting at your trainer", ToggleTrainerRemindersOption, nil,
        not (PathForeverDB.options and PathForeverDB.options.trainerReminders == false))

    i = i + 1
    local slideRow = AcquireRow()
    y = y + LayoutRow(slideRow, i, y, "Slide popouts", COLOR_TEXT,
        "Side windows slide open and shut instead of appearing at once", function()
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.slidePopouts = PathForeverDB.options.slidePopouts == false
            PlayCheckboxSound(PathForeverDB.options.slidePopouts)
            PF:RefreshUI()
        end, nil, not (PathForeverDB.options and PathForeverDB.options.slidePopouts == false))

    i = i + 1
    local dockRow = AcquireRow()
    y = y + LayoutRow(dockRow, i, y, "Minimize to an icon", COLOR_TEXT,
        "Closing shrinks the window into a small icon you can move, which opens it again", function()
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.dockIcon = PathForeverDB.options.dockIcon == false
            PlayCheckboxSound(PathForeverDB.options.dockIcon)
            if PF.Dock then PF.Dock:Update() end
            PF:RefreshUI()
        end, nil, not (PathForeverDB.options and PathForeverDB.options.dockIcon == false))

    if PF.Fishing then
        i = i + 1
        local fishingRow = AcquireRow()
        y = y + LayoutRow(fishingRow, i, y, "PathForever Fishing", COLOR_TEXT,
            "Opens when you equip a fishing pole (or type /pf fishing)", ToggleFishingOption, nil,
            not (PathForeverDB.options and PathForeverDB.options.fishingWindow == false))
    end

    if PF.Camping then
        i = i + 1
        local campRow = AcquireRow()
        y = y + LayoutRow(campRow, i, y, "PathForever Camping", COLOR_TEXT,
            "Opens at a campfire and lists its buffs (or type /pf campfire)", function()
                PathForeverDB.options = PathForeverDB.options or {}
                PathForeverDB.options.campWindow = PathForeverDB.options.campWindow == false
                PlayCheckboxSound(PathForeverDB.options.campWindow)
                if PF.Camping then PF.Camping:OptionChanged() end
                PF:RefreshUI()
            end, nil, not (PathForeverDB.options and PathForeverDB.options.campWindow == false))
    end

    if PF.Tracker then
        i = i + 1
        local trackerRow = AcquireRow()
        y = y + LayoutRow(trackerRow, i, y, "Leveling tracker", COLOR_TEXT,
            "A small window with XP per hour, time to the next level, kills and gold per hour", function()
                local on = not (PathForeverDB.options and PathForeverDB.options.levelTracker == true)
                PlayCheckboxSound(on)
                PF.Tracker:SetEnabled(on)
            end, nil, PathForeverDB.options and PathForeverDB.options.levelTracker == true)
    end

    if PF.Spotter then
        i = i + 1
        local spotterRow = AcquireRow()
        y = y + LayoutRow(spotterRow, i, y, "Enemy spotter", COLOR_TEXT,
            "A thin strip on the screen edge that shows the most dangerous enemy player nearby", function()
                local on = not (PathForeverDB.options and PathForeverDB.options.enemySpotter == true)
                PlayCheckboxSound(on)
                PF.Spotter:SetEnabled(on)
            end, nil, PathForeverDB.options and PathForeverDB.options.enemySpotter == true)
    end

    i = i + 1
    local libraryRow = AcquireRow()
    y = y + LayoutRow(libraryRow, i, y, "Library books", COLOR_TEXT,
        "Collect books in Discover, and the Books button on the world map", function()
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.libraryBooks = PathForeverDB.options.libraryBooks == false
            PlayCheckboxSound(PathForeverDB.options.libraryBooks)
            if PF.LibraryMap and PF.LibraryMap.Refresh then PF.LibraryMap:Refresh() end
            PF:RefreshUI()
        end, nil, not (PathForeverDB.options and PathForeverDB.options.libraryBooks == false))

    i = i + 1
    local entranceRow = AcquireRow()
    y = y + LayoutRow(entranceRow, i, y, "Dungeon entrances", COLOR_TEXT,
        "The Entrances button on the world map, marking every dungeon and raid", function()
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.entranceMap = PathForeverDB.options.entranceMap == false
            PlayCheckboxSound(PathForeverDB.options.entranceMap)
            if PF.EntranceMap and PF.EntranceMap.Refresh then PF.EntranceMap:Refresh() end
            PF:RefreshUI()
        end, nil, not (PathForeverDB.options and PathForeverDB.options.entranceMap == false))

    i = i + 1
    local flightRow = AcquireRow()
    y = y + LayoutRow(flightRow, i, y, "Flight paths", COLOR_TEXT,
        "The Flight paths button on the world map, showing which flight points you have found", function()
            PathForeverDB.options = PathForeverDB.options or {}
            PathForeverDB.options.flightMap = PathForeverDB.options.flightMap == false
            PlayCheckboxSound(PathForeverDB.options.flightMap)
            if PF.FlightMap and PF.FlightMap.Refresh then PF.FlightMap:Refresh() end
            PF:RefreshUI()
        end, nil, not (PathForeverDB.options and PathForeverDB.options.flightMap == false))

    AddGroupPanel(listGroups, scrollChild, 0, groupTop, ROW_WIDTH, y)
    y = y + GROUP_GAP

    i = i + 1
    local aboutHeader = AcquireRow()
    y = y + LayoutSectionHeader(aboutHeader, y, "About")
    groupTop = y

    i = i + 1
    local versionRow = AcquireRow()
    y = y + LayoutRow(versionRow, i, y, "Version", COLOR_TEXT, "PathForever " .. tostring(PF.version))
    versionRow.tooltip = "Include this in bug reports (or type /pf version)"

    i = i + 1
    local followRow = AcquireRow()
    local followTop = y
    local followH = LayoutRow(followRow, i, y, "Follow oheyspun", COLOR_TEXT, "Twitch, YouTube and X")
    y = y + followH
    PF.PlaceFollowStrip(scrollChild, followTop, followH, ROW_WIDTH)

    AddGroupPanel(listGroups, scrollChild, 0, groupTop, ROW_WIDTH, y)
    scrollChild:SetHeight(math.max(y, 1))
end

-- ---------- The copy box and the Follow logos (Options > About) ----------
-- Addons can't open a web page or write to the clipboard, so a click on a logo opens a
-- small box at the cursor with the link already selected: Ctrl+C copies it and the box
-- closes (Escape or clicking elsewhere closes it too).
do
local box

local function CreateCopyBox()
    local f = CreateFrame("Frame", "PathForeverCopyBox", UIParent, "BackdropTemplate")
    f:SetSize(300, 62)
    f:SetFrameStrata("DIALOG")
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    StyleWindow(f, 0.97, 0.7)
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.title:SetPoint("TOPLEFT", 14, -10)
    f.title:SetTextColor(GetAccentColor())
    f.hint = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    f.hint:SetPoint("TOPRIGHT", -14, -10)
    f.hint:SetText("Ctrl+C to copy")
    f.edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    f.edit:SetSize(268, 20)
    f.edit:SetPoint("TOPLEFT", 20, -28)
    f.edit:SetAutoFocus(false)
    if GameFontHighlightSmall then f.edit:SetFontObject(GameFontHighlightSmall) end
    f.edit:SetScript("OnEscapePressed", function() f:Hide() end)
    f.edit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    f.edit:SetScript("OnEditFocusLost", function() f:Hide() end)
    -- typing can't change the link
    f.edit:SetScript("OnTextChanged", function(self, byUser)
        if byUser and f.url then self:SetText(f.url); self:HighlightText() end
    end)
    f.edit:SetScript("OnKeyDown", function(self, key)
        if key == "C" and IsControlKeyDown() then
            -- let the copy happen first, then close
            C_Timer.After(0, function()
                f:Hide()
                print("|cff3fc7ebPathForever:|r Link copied. Thank you.")
            end)
        end
    end)
    f:Hide()
    return f
end

-- Opens the box at the cursor, with `url` selected.
function PF.ShowCopyBox(title, url)
    box = box or CreateCopyBox()
    box.url = url
    box.title:SetText(title)
    box.edit:SetText(url)
    box.edit:SetCursorPosition(0)
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    if not scale or scale <= 0 then scale = 1 end
    box:ClearAllPoints()
    box:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", x / scale, y / scale + 14)
    box:Show()
    box:Raise()
    box.edit:SetFocus()
    box.edit:HighlightText()
end

local function LogoOnEnter(self)
    self.tex:SetVertexColor(GetAccentColor())
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(self.link.name, 1, 1, 1)
    GameTooltip:AddLine("Click to copy the link", 0.6, 0.6, 0.6)
    GameTooltip:Show()
end
local function LogoOnLeave(self)
    self.tex:SetVertexColor(0.75, 0.75, 0.78)
    GameTooltip:Hide()
end
local function LogoOnClick(self)
    PlayUISound("IG_MAINMENU_OPTION_CHECKBOX_ON")
    PF.ShowCopyBox(self.link.name, self.link.url)
end

-- The row of logos, right-aligned in the list row that starts at `rowTop` and is `rowH` high.
function PF.PlaceFollowStrip(parent, rowTop, rowH, rowWidth)
    local size, gap = 28, 10
    local strip = PF.followStrip
    if not strip then
        strip = CreateFrame("Frame", nil, parent)
        strip.buttons = {}
        for n, link in ipairs(PF.FOLLOW) do
            local b = CreateFrame("Button", nil, strip)
            b:SetSize(size, size)
            b.link = link
            b.tex = b:CreateTexture(nil, "ARTWORK")
            b.tex:SetAllPoints()
            b.tex:SetTexture(link.icon)
            b.tex:SetVertexColor(0.75, 0.75, 0.78)
            b:SetScript("OnEnter", LogoOnEnter)
            b:SetScript("OnLeave", LogoOnLeave)
            b:SetScript("OnClick", LogoOnClick)
            b:SetPoint("TOPLEFT", strip, "TOPLEFT", (n - 1) * (size + gap), 0)
            strip.buttons[n] = b
        end
        strip:SetSize(#PF.FOLLOW * size + (#PF.FOLLOW - 1) * gap, size)
        PF.followStrip = strip
    end
    strip:SetParent(parent)
    strip:ClearAllPoints()
    strip:SetPoint("TOPRIGHT", parent, "TOPLEFT", rowWidth - 14, -(rowTop + math.floor((rowH - size) / 2)))
    strip:SetFrameLevel((parent:GetFrameLevel() or 1) + 5)
    strip:Show()
end
end

-- ---------- Dialogs ----------
-- PathForever draws its own small dialog instead of using Blizzard's
-- StaticPopup system. Registering entries in StaticPopupDialogs from addon
-- code is a well-known source of taint: it can poison later Blizzard popups
-- (group invites, summons, and similar), which the client reports as
-- "Interface action failed because of an AddOn." A plain frame of our own
-- can't touch any of that.
local dialog

local function CreateDialog()
    local ar, ag, ab = GetAccentColor()
    local d = CreateFrame("Frame", "PathForeverDialog", UIParent, "BackdropTemplate")
    d:SetSize(440, 200)
    d:SetPoint("CENTER", UIParent, "CENTER", 0, 80)
    d:SetFrameStrata("DIALOG")
    d:SetToplevel(true)
    StyleWindow(d, 0.97, 0.7)


    d.title = d:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    d.title:SetPoint("TOPLEFT", 20, -20)
    d.title:SetWidth(400)
    d.title:SetJustifyH("LEFT")
    d.title:SetTextColor(1, 0.82, 0)

    d.text = d:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    d.text:SetJustifyH("LEFT")
    d.text:SetJustifyV("TOP")
    d.text:SetSpacing(2)

    d.buttons = {}

    -- ESC closes it. Keyboard input is only captured while the dialog is
    -- up, and every key except ESC is passed straight through so movement
    -- and keybinds keep working underneath it.
    d:SetScript("OnShow", function(self) self:EnableKeyboard(true) end)
    d:SetScript("OnHide", function(self) self:EnableKeyboard(false) end)
    d:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            self:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    d:Hide()
    return d
end

-- opts = { title = "...", text = "...", buttons = { { text = "OK", onClick = fn }, ... } }
function PF:ShowDialog(opts)
    if not dialog then dialog = CreateDialog() end
    local d = dialog

    d.title:SetText(opts.title or "PathForever")
    local titleH = d.title:GetStringHeight() or 0
    d.text:ClearAllPoints()
    d.text:SetPoint("TOPLEFT", d.title, "BOTTOMLEFT", 0, -14)
    d.text:SetWidth(400)
    d.text:SetText(opts.text or "")

    for _, b in ipairs(d.buttons) do b:Hide() end
    local buttons = opts.buttons or { { text = "OK" } }
    local btnW, gap = 110, 10
    local totalW = #buttons * btnW + (#buttons - 1) * gap
    local startX = (440 - totalW) / 2
    local textH = d.text:GetStringHeight() or 0
    local btnY = 20 + titleH + 14 + textH + 22

    for i, spec in ipairs(buttons) do
        local btn = d.buttons[i]
        if not btn then
            btn = CreateFlatButton(d, btnW, 28, "")
            d.buttons[i] = btn
        end
        btn.text:SetText(spec.text)
        btn.text:SetTextColor(unpack(COLOR_TEXT))
        btn:ClearAllPoints()
        btn:SetPoint("TOPLEFT", d, "TOPLEFT", startX + (i - 1) * (btnW + gap), -btnY)
        btn:SetScript("OnClick", function()
            d:Hide()
            if spec.onClick then spec.onClick() end
        end)
        btn:Show()
    end

    d:SetHeight(btnY + 28 + 20)
    d:Show()
    d:Raise()
end

local WELCOME_TEXT =
    "PathForever is designed to ease the pain points of WoW Forever and give you, the player, an edge. "
    .. "We update the addon constantly, but you should know that Forever does not reveal items or quests until players discover them. "
    .. "You may see \"Retrieving item information\" from time to time, and that will change as more is discovered."

function PF:ShowWelcome()
    PF:ShowDialog({
        title = "Welcome to PathForever",
        text = WELCOME_TEXT,
        buttons = { { text = "Accept" }, { text = "Take Tour", onClick = function() if PF.Tour then PF.Tour:Start() end end } },
    })
end

function PF:ConfirmRemoveCharacter(charName, key)
    PF:ShowDialog({
        title = "Remove character?",
        text = "Remove " .. tostring(charName) .. "'s tracked profession data? This can't be undone.",
        buttons = {
            { text = "Remove", onClick = function()
                PF:RemoveCharacter(key)
                PF:RefreshUI()
            end },
            { text = "Cancel" },
        },
    })
end

-- /pf art: switches "art on every dungeon" on or off (so each image and its
-- crop can be checked on the Dungeons tab), and lists each dungeon's image.
function PF:PrintArtReport()
    local tag = "|cff3fc7ebPathForever|r "
    artPreviewAll = not artPreviewAll
    print(string.format("%sart preview %s", tag,
        artPreviewAll and "ON (every dungeon shows its art)" or "OFF (normal rules)"))
    for _, d in ipairs(PathForeverData.Dungeons) do
        local file, aspect = GetDungeonArt(d)
        print(string.format("  %s: %s", d.name,
            file and string.format("%s (aspect %.2f)", tostring(file), aspect) or "NONE"))
    end
    -- Profession art comes from the client's atlases, which this build may or may not have.
    print(tag .. "profession art (Professions tab):")
    local names, seen = {}, {}
    for _, name in pairs(PROFESSION_ART_ATLAS) do
        if not seen[name] then seen[name] = true; names[#names + 1] = name end
    end
    table.sort(names)
    for _, name in ipairs(names) do
        local info = GetAtlas(name)
        print(string.format("  %s: %s", (name:gsub("^professions%-specializations%-background%-", "")),
            info and string.format("found (%dx%d)", info.width, info.height) or "MISSING in this client"))
    end
    -- The world map's entrance pins use these (EntranceMap.lua), else a key and a skull.
    print(tag .. "entrance icons (world map):")
    for kind, name in pairs(PF.EntranceMap and PF.EntranceMap.ATLAS or {}) do
        local info = GetAtlas(name)
        print(string.format("  %s (%s): %s", kind, name,
            info and string.format("found (%dx%d)", info.width, info.height) or "MISSING in this client (key and skull used)"))
    end
    -- The link from your professions to that art is the skill line ID the client reports.
    print(tag .. "your professions (skill line ID -> art):")
    for _, p in ipairs(PF:GetProfessionStatus()) do
        local name = p.skillLine and PROFESSION_ART_ATLAS[p.skillLine]
        local state = name and (GetAtlas(name) and "art" or "atlas missing") or "NO ART MAPPED for this ID"
        if name and PROFESSION_ART_FLIPPED[p.skillLine] then
            state = state .. string.format(" (borrowed: %s, mirrored)", (name:gsub("^professions%-specializations%-background%-", "")))
        end
        print(string.format("  %s: skill line %s -> %s", tostring(p.name), tostring(p.skillLine), state))
    end
    PF:RefreshUI()
end

-- /pf atlas <words>: the client's atlas names that contain every word, with their
-- size, for finding an icon (the client lists them: C_Texture.GetAtlasElements).
function PF:PrintAtlasSearch(words)
    local tag = "|cff3fc7ebPathForever|r "
    local fn = C_Texture and C_Texture.GetAtlasElements
    if not fn then print(tag .. "this client doesn't list its atlases (C_Texture.GetAtlasElements)") return end
    local ok, all = pcall(fn)
    if not ok or type(all) ~= "table" then print(tag .. "the client gave no atlas list") return end
    local needles = {}
    for w in string.gmatch(string.lower(words or ""), "%S+") do needles[#needles + 1] = w end
    if #needles == 0 then print(tag .. "usage: /pf atlas <word> [more words]   (" .. #all .. " atlases)") return end
    local found = {}
    for _, name in ipairs(all) do
        local lower, hit = string.lower(name), true
        for _, w in ipairs(needles) do
            if not string.find(lower, w, 1, true) then hit = false break end
        end
        if hit then found[#found + 1] = name end
    end
    table.sort(found)
    print(string.format("%satlases with \"%s\": %d", tag, table.concat(needles, " "), #found))
    for i = 1, math.min(#found, 50) do
        local info = GetAtlas(found[i])
        print(string.format("  %s%s", found[i], info and string.format(" (%dx%d)", info.width, info.height) or ""))
    end
    if #found > 50 then print(string.format("  ... and %d more: add another word to narrow it", #found - 50)) end
end

-- ---------- For the modules (Journey.lua) ----------
-- The Journey tab's class quests open in this same side panel. `d` is the
-- "dungeon" they belong to: a name for the subtitle and their reward groups.
PF.UI = {
    ShowQuestPanel = function(q, d) ShowSidePanel("quest", q, d) end,
    ShowBooks = function(books) ShowSidePanel("books", books, nil) end,
    ShowProfession = function(p) ShowSidePanel("info", ProfessionSubject(p)) end,
    ShowZone = function(guide) ShowSidePanel("zone", guide, nil) end,
    ShowInfo = function(subject) ShowSidePanel("info", subject, nil) end,
    MarkOnMap = function(subject) ShowQuestOnMap(subject) end,
    HideSidePanel = function() HideSidePanel() end,
    DescribeQuest = DescribeQuest,
}

-- ---------- Public API (called from Core.lua) ----------
function PF:RefreshUI()
    if not frame or not frame:IsShown() then return end
    PF.stats.refreshes = PF.stats.refreshes + 1
    local tab = PathForeverDB.activeTab or "Journey"
    if not tabButtons[tab] then tab = "Dungeons" end
    PathForeverDB.activeTab = tab
    SetActiveTab(tab)
    if header and header.title then
        header.title:SetText(tab == "Wishlist" and "Wishlist" or tab == "ClassQuests" and "Class quests" or tab == "History" and "Dungeon history" or tab)
    end
    ReleaseAllRows()
    header.back:SetShown(tab == "Dungeons" and viewingDungeon ~= nil)

    -- the Bank page's bar (with the search box) stays shown through its own redraws: hiding an
    -- edit box takes its keyboard focus, and typing would fall through to the keybinds
    if tab ~= "Bank" and PF.bankBar then PF.bankBar:Hide() end
    if tab ~= "History" and PF.historyEndButton then PF.historyEndButton:Hide() end

    -- The Journey tab draws its own content (Journey.lua) instead of the scroll list.
    local journey = (tab == "Journey") and PF.Journey
    -- the Skills, Class quests and Zones pages are Journey modules drawn as the whole window
    local pageModule = PF.Journey and PF.Journey.PAGES and PF.Journey.PAGES[tab]
    scrollFrame:SetShown(not journey and not pageModule)
    cardBg:SetShown(not journey and not pageModule)
    if journey then
        stickyHeader:Hide()
        PF.Journey:Render(frame)
        return
    elseif pageModule then
        stickyHeader:Hide()
        PF.Journey:RenderPage(frame, pageModule)
        return
    elseif PF.Journey then
        PF.Journey:Hide()
    end

    if tab == "Dungeons" then
        if viewingDungeon then
            RenderDungeonDetail(viewingDungeon)
        else
            RenderDungeons()
        end
    elseif tab == "Wishlist" then
        RenderWishlist()
    elseif tab == "Bank" then
        PF:RenderBankTab()
    elseif tab == "Upgrades" then
        PF:RenderUpgradesTab()
    elseif tab == "History" then
        PF:RenderHistoryTab()
    elseif tab == "Raids" then
        PF:RenderRaidsTab()
    elseif tab == "Professions" then
        RenderProfessions()
    elseif tab == "Options" then
        RenderOptions()
    end
end

-- Game events call this instead of RefreshUI. Each kind of change can only
-- affect certain tabs, so a change that cannot alter what's showing costs
-- nothing, and a burst of them collapses into a single redraw a moment later.
-- (Clicks in the window still call RefreshUI directly, so they stay instant.)
local REFRESH_TABS = {
    professions = { Professions = true },
    wishlist = { Wishlist = true, Journey = true },
    upgrades = { Upgrades = true },
    history = { History = true },
    bank = { Bank = true },
    kills = { Dungeons = true },
    quests = { Dungeons = true, Journey = true, ClassQuests = true, Zones = true },
    journey = { Journey = true, Skills = true, ClassQuests = true, Zones = true, Gold = true, XP = true, Discover = true },
    reputation = { Reputations = true, Journey = true, PvP = true },
}
local refreshScheduled = false
local function FlushRefresh()
    refreshScheduled = false
    PF:RefreshUI()
end
function PF:RequestRefresh(scope)
    local tabs = REFRESH_TABS[scope]
    local tab = PathForeverDB and PathForeverDB.activeTab or "Journey"
    if not (frame and frame:IsShown()) or (tabs and not tabs[tab]) then
        PF.stats.skipped = PF.stats.skipped + 1
        return
    end
    if refreshScheduled then return end
    refreshScheduled = true
    C_Timer.After(0.15, FlushRefresh)
end

-- Opens the window on a tab (the Journey's spellbook button uses it), and on the
-- Dungeons tab optionally straight into one dungeon (the Journey's Discover panel).
function PF:OpenTab(tab, dungeon, filter)
    if not frame then frame = CreateMainFrame() end
    PathForeverDB.activeTab = tab
    viewingDungeon, instanceFilter = dungeon, filter
    if not frame:IsShown() and not (PF.Dock and PF.Dock:Open(frame)) then frame:Show() end
    frame:Raise()
    PF:RefreshUI()
end

-- Closes the window: it shrinks into the dock icon when that is on, else it just hides.
function PF:CloseUI()
    if not (frame and frame:IsShown()) then return end
    if PF.Dock and PF.Dock:Minimize(frame) then return end
    frame:Hide()
end

function PF:ToggleUI()
    if not frame then
        frame = CreateMainFrame()
    end

    if frame:IsShown() then
        PF:CloseUI() -- its OnHide closes the side panel
        return
    end

    -- Jump straight to your current dungeon, if you're in one on file.
    -- An ambiguous multi-wing complex (Scarlet Monastery, Dire Maul) shows
    -- a filtered list instead of guessing which wing you're actually in.
    local matches = PF:GetCurrentDungeonMatches()
    if matches then
        PathForeverDB.activeTab = "Dungeons"
        if #matches == 1 then
            viewingDungeon = matches[1]
            instanceFilter = nil
        else
            viewingDungeon = nil
            instanceFilter = matches
        end
    end

    if not (PF.Dock and PF.Dock:Open(frame)) then frame:Show() end
    frame:Raise()
    PF:RefreshUI()
end

-- ---------- Diagnostics ----------
function PF:GetUICounts()
    local itemRows = sidePanel and (#sidePanel.itemRows + #sidePanel.itemRowPool) or 0
    return #rowPool + #activeRows, itemRows
end

-- /pf layout: what the client itself reports for the window's text, so a
-- "text is cut off" report comes with real numbers instead of guesses.
function PF:PrintLayoutReport(showAll)
    local tag = "|cff3fc7ebPathForever|r "
    if not (frame and frame:IsShown()) then
        print(tag .. "open the window (/pf), go to the tab with the cut-off text, then run /pf layout.")
        return
    end

    local texts = {}
    local function add(label, fs)
        if fs and fs:IsVisible() and (fs:GetText() or "") ~= "" then
            texts[#texts + 1] = { label = label, fs = fs }
        end
    end
    if stickyHeader and stickyHeader:IsShown() then
        add("pinned name", stickyHeaderText)
        add("pinned details", stickyHeaderSub)
    end
    for n, row in ipairs(activeRows) do
        add("row " .. n .. " title", row.title)
        add("row " .. n .. " sub", row.sub)
        add("row " .. n .. " right", row.right)
    end
    if sidePanel and sidePanel:IsShown() then
        for _, key in ipairs({ "title", "subtitle", "statLabels", "statValues", "emptyNote", "itemsHeader", "itemsHint" }) do
            add("panel " .. key, sidePanel[key])
        end
        for n = 1, sidePanel.sectionsUsed do
            add("panel section " .. n .. " header", sidePanel.sectionPool[n].header)
            add("panel section " .. n .. " body", sidePanel.sectionPool[n].body)
        end
        for n, row in ipairs(sidePanel.itemRows) do
            add("panel item " .. n .. " name", row.name)
            add("panel item " .. n .. " slot", row.slot)
        end
    end

    -- Some of these methods may not exist on every client; a missing or failing
    -- one just shows as "?" rather than raising an error.
    local function measure(fs, method)
        local fn = fs[method]
        if not fn then return nil end
        local ok, value = pcall(fn, fs)
        if ok and type(value) == "number" then return value end
        return nil
    end
    local function show(v) return v and string.format("%.0f", v) or "?" end

    local flagged, plain = {}, {}
    for _, t in ipairs(texts) do
        local fs = t.fs
        local w, h = measure(fs, "GetWidth"), measure(fs, "GetHeight")
        local textH = measure(fs, "GetStringHeight")
        local unwrapped, lines = measure(fs, "GetUnboundedStringWidth"), measure(fs, "GetNumLines")
        -- Suspicious when the box is shorter than its text, or when the text is
        -- wider than the box yet shows fewer lines than it would need to wrap.
        local cut = false
        if h and textH and h + 1 < textH then cut = true end
        if w and w > 0 and unwrapped and lines and lines < math.ceil(unwrapped / w) then cut = true end
        local snippet = ((fs:GetText() or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\n", " "))
        local line = string.format("%s%s: box %sx%s, text-height %s, lines %s, unwrapped-width %s  \"%s\"",
            cut and "CUT? " or "", t.label, show(w), show(h), show(textH), show(lines), show(unwrapped), snippet:sub(1, 34))
        if cut then flagged[#flagged + 1] = line else plain[#plain + 1] = line end
    end

    print(string.format("%slayout check: %d texts on screen, %d look cut off", tag, #texts, #flagged))
    local limit = showAll and math.huge or 14
    local printed = 0
    for _, list in ipairs({ flagged, plain }) do
        for _, line in ipairs(list) do
            if printed >= limit then break end
            print("  " .. line)
            printed = printed + 1
        end
    end
    if printed < #texts then
        print(string.format("%s(showing %d of %d - run /pf layout all for everything)", tag, printed, #texts))
    end
end
