local name,ZGV = ...
local GearFinder = ZGV.ItemScore.GearFinder

GearFinder.PAST_DUNGEONS_LIMIT = 30 -- how many levels can user be above previous expansion cap before we start ignoring its dungeon
GearFinder.FUTURE_DUNGEONS_LIMIT = 5 -- how many levels to look ahead for future upgrades

function GearFinder:Initialise()
	GearFinder:CreateMainFrame()
end

local L = ZGV.L
local G = _G
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local CHAIN = ZGV.ChainCall
local ui = ZGV.UI
local SkinData = ui.SkinData

local tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop=tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local ItemScore = ZGV.ItemScore

-- support function for character frame system tab creation
local function RestoreBlizzard()
	GearFinder.PaperDollButton:GetNormalTexture():SetTexCoord(0,1,0,0.25)
	if CharacterFrameRightPaneHost:IsVisible() then
		CharacterFrame:SetWidth(631)
	else
		CharacterFrame:SetWidth(398)
	end
	if GearFinder.LastChecked then
		GearFinder.LastChecked:SetChecked(true)
	end
end

function GearFinder:AttachFrame()
	GearFinder.PaperDollButton = ZGV.ChainCall(CreateFrame("Button", nil, CharacterFrame))
		:SetPoint("TOPLEFT", CharacterFrameModeTab6, "BOTTOMLEFT", 0, 2)
		:SetSize(64,64)
		:SetScript("OnClick", function() 
			GearFinder:ShowFinder()	
		end)
		:SetScript("OnEnter",function(self) 
			CHAIN(GameTooltip):SetOwner(self, "ANCHOR_TOP") 
			:SetText("Toggle Zygor Gear Finder") 
			:Show() 
			end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
	.__END
	ZGV.F.AssignButtonTexture(GearFinder.PaperDollButton,ZGV.DIR.."\\Skins\\popout-forever",1,1,false)

	if ZGV.ItemScore.GearFinder:IsEnabled() then
		GearFinder.PaperDollButton:Show()
	else
		GearFinder.PaperDollButton:Hide()
	end
end

function GearFinder:UpdateSystemTab()
	if ZGV.ItemScore.GearFinder:IsEnabled() then
		GearFinder.PaperDollButton:Show()
	else
		GearFinder.PaperDollButton:Hide()
		GearFinder.MainFrame:Hide()
	end
end

function GearFinder:ShowFinder()
	if ZygorGearFinder:IsVisible() then 
		GearFinder.MainFrame:Hide() 
		return 
	end
	if not GearFinder.HookedChar then
		hooksecurefunc("ToggleCharacter",function() 
			GearFinder.LastChecked = nil
			GearFinder.MainFrame:Hide() 
		end)
		GearFinder.MainFrame:HookScript("OnHide",RestoreBlizzard)
		
		GearFinder.HookedChar = true
	end
	
	for _, modeTab in ipairs(CharacterFrame.ModeTabs.Tabs) do
		if modeTab.SelectedTexture:IsShown() then
			GearFinder.LastChecked = modeTab
		end
		modeTab:SetChecked(false);
	end

	CharacterFrame:SetWidth(703)
	GearFinder.PaperDollButton:GetNormalTexture():SetTexCoord(0,1,0.25,0.5)

	ZygorGearFinder:Show()
	GearFinder:ScoreDungeonItems()
end

function GearFinder:IsEnabled()
	if not ZGV.db.profile.autogear_finder then return false else return true end
end