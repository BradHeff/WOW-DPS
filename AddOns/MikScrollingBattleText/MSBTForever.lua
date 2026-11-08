-------------------------------------------------------------------------------
-- WoW Forever support. The Camelot TOC loads this before the rest of MSBT.
-- The TBC TOC does not, so Classic TBC keeps the original globals.
--
-- Replacements for removed APIs live in MikSBT_Compat. They are never written
-- to the old global names: other addons test those globals to choose a client
-- path, and they would pick up MSBT's versions. Each MSBT file reads its
-- functions from (MikSBT_Compat or _G).
-------------------------------------------------------------------------------

local tocVersion = select(4, GetBuildInfo()) or 0
local isForever = (WOW_PROJECT_CAMELOT ~= nil and WOW_PROJECT_ID == WOW_PROJECT_CAMELOT) or (tocVersion >= 16000 and tocVersion < 20000)
MikSBT_IsForever = isForever
if not isForever then return end

local issecretvalue = issecretvalue
local issecrettable = issecrettable

local function Secret(value)
	return issecretvalue ~= nil and issecretvalue(value)
end
MikSBT_IsSecret = Secret

local function SecretTable(value)
	return issecrettable ~= nil and issecrettable(value)
end

local Compat = {}
MikSBT_Compat = Compat


-------------------------------------------------------------------------------
-- Same arguments and returns as the removed globals.
-------------------------------------------------------------------------------

Compat.GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata
Compat.IsAddOnLoaded = C_AddOns and C_AddOns.IsAddOnLoaded
Compat.LoadAddOn = C_AddOns and C_AddOns.LoadAddOn
Compat.GetItemCount = C_Item and C_Item.GetItemCount
Compat.GetItemClassInfo = C_Item and C_Item.GetItemClassInfo
Compat.GetSpellTexture = C_Spell and C_Spell.GetSpellTexture
Compat.GetContainerItemID = C_Container and C_Container.GetContainerItemID
Compat.GetActiveSpecGroup = C_SpecializationInfo and C_SpecializationInfo.GetActiveSpecGroup


-------------------------------------------------------------------------------
-- Wrappers where the modern API returns something different.
-------------------------------------------------------------------------------

-- MSBT keeps item ids from links as strings ("item:(%d+)").
local function ItemArg(item)
	return tonumber(item) or item
end

local GetItemInfoModern = C_Item and C_Item.GetItemInfo
function Compat.GetItemInfo(item)
	if (item == nil or not GetItemInfoModern) then return end
	return GetItemInfoModern(ItemArg(item))
end

-- The old global returned name, rank, icon, castTime, minRange, maxRange, spellID.
local GetSpellInfoModern = C_Spell and C_Spell.GetSpellInfo
function Compat.GetSpellInfo(spell)
	if (spell == nil or not GetSpellInfoModern) then return end
	local info = GetSpellInfoModern(spell)
	if (not info) then return end
	return info.name, nil, info.iconID, info.castTime, info.minRange, info.maxRange, info.spellID
end

-- Spell cooldowns are secret while cooldowns are restricted (combat). Then this
-- returns nothing for the old values and true as a fifth value, so callers can
-- tell "secret right now" apart from "no cooldown".
local GetSpellCooldownModern = C_Spell and C_Spell.GetSpellCooldown
function Compat.GetSpellCooldown(spell)
	if (spell == nil or not GetSpellCooldownModern) then return end
	local info = GetSpellCooldownModern(spell)
	if (Secret(info) or SecretTable(info)) then return nil, nil, nil, nil, true end
	if (not info) then return end
	local startTime, duration, isEnabled = info.startTime, info.duration, info.isEnabled
	if (Secret(startTime) or Secret(duration) or Secret(isEnabled)) then return nil, nil, nil, nil, true end
	return startTime, duration, isEnabled and 1 or 0, info.modRate
end

-- C_Item.GetItemCooldown returns a boolean where the old global returned 1 or 0.
local GetItemCooldownModern = C_Item and C_Item.GetItemCooldown
function Compat.GetItemCooldown(item)
	if (item == nil or not GetItemCooldownModern) then return end
	local startTime, duration, enabled = GetItemCooldownModern(ItemArg(item))
	if (Secret(startTime) or Secret(duration) or Secret(enabled)) then return nil, nil, nil, nil, true end
	return startTime, duration, enabled and 1 or 0
end

-- Used only by the buffActive/buffInactive trigger exceptions: the buff's name
-- when the player has it. Auras are secret while restricted; report no buff then.
local GetAuraDataBySpellName = C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName
function Compat.UnitBuff(unit, spellName)
	if (not GetAuraDataBySpellName or spellName == nil) then return end
	local ok, aura = pcall(GetAuraDataBySpellName, unit, spellName, "HELPFUL")
	if (not ok or Secret(aura) or SecretTable(aura) or not aura) then return end
	local name = aura.name
	if (Secret(name)) then return end
	return name
end

-- FillLocalizedClassList(t) is gone; LocalizedClassList() returns a new table.
function Compat.FillLocalizedClassList(classList, isFemale)
	local list = LocalizedClassList and LocalizedClassList(isFemale and true or false)
	if (type(list) == "table") then
		for classFile, className in pairs(list) do classList[classFile] = className end
	end
	return classList
end


-------------------------------------------------------------------------------
-- Secret amounts. UNIT_COMBAT's amount is secret: it can be stored, passed,
-- concatenated and shown, but not compared or used in math. Blizzard's number
-- formatters accept it (SecretArguments = "AllowedWhenTainted").
-------------------------------------------------------------------------------

local AbbreviateNumbers = AbbreviateNumbers
local BreakUpLargeNumbers = BreakUpLargeNumbers
local TruncateWhenZero = C_StringUtil and C_StringUtil.TruncateWhenZero

-- Follows the profile's number style: shortened, grouped, or plain.
function Compat.FormatSecretNumber(amount, shorten, group)
	if (shorten and AbbreviateNumbers) then return AbbreviateNumbers(amount) end
	if (group and BreakUpLargeNumbers) then return BreakUpLargeNumbers(amount) end
	if (TruncateWhenZero) then return TruncateWhenZero(amount) end
	return amount
end

-- Text after a miss word such as "Resist": blank for a full avoid, the damage
-- that got through for a partial one. UNIT_COMBAT cannot tell the two apart.
function Compat.FormatSecretTrailer(amount)
	if (TruncateWhenZero) then return " " .. TruncateWhenZero(amount) end
	return ""
end
