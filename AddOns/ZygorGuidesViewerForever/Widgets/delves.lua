local ZGV = ZGV
local L = ZGV.L
local CHAIN = ZGV.ChainCall
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local SkinData = ZGV.UI.SkinData
local ZGV_Widget_Object_Mixin = ZGV_Widget_Object_Mixin

-- Name, normalID, bountifulID, mapId, x, y
local delves = {
	-- Midnight
	{name="Atal'Aman",		normal=8443,bountiful=8444,m=2437, x=24.8, y=53.0, achieve=61729, exp="MID"},
	{name="Collegiate Calamity",	normal=8425,bountiful=8426,m=2393, x=40.7, y=54.1, achieve=61726, exp="MID"},
	{name="Parhelion Plaza",	normal=8427,bountiful=8428,m=2424, x=47.8, y=41.6, achieve=61725, exp="MID"},
	{name="Shadowguard Point",	normal=8431,bountiful=8432,m=2405, x=37.4, y=47.7, achieve=61733, exp="MID"},
	{name="Sunkiller Sanctum",	normal=8429,bountiful=8430,m=2405, x=54.8, y=47.0, achieve=61732, exp="MID"},
	{name="The Darkway",		normal=8439,bountiful=8440,m=2393, x=39.3, y=32.1, achieve=61728, exp="MID"},
	{name="The Grudge Pit",		normal=8433,bountiful=8434,m=2413, x=70.5, y=64.9, achieve=61724, exp="MID"},
	{name="The Gulf of Memory",	normal=8435,bountiful=8436,m=2413, x=36.3, y=49.2, achieve=61731, exp="MID"},
	{name="The Shadow Enclave",	normal=8437,bountiful=8438,m=2395, x=45.4, y=86.0, achieve=61727, exp="MID"},
	{name="Twilight Crypts",	normal=8441,bountiful=8442,m=2437, x=25.4, y=84.3, achieve=61730, exp="MID"},
	{name="The Ring of Glory",	normal=8764,bountiful=8763,m=2512, x=71.1, y=56.4, achieve=63436, exp="MID"},
	{name="Gnarldor Isle",		normal=8761,bountiful=8760,m=2512, x=64.3, y=77.7, achieve=63437, exp="MID"},

	-- TWW
	{name="Archival Assault",	normal=8274,bountiful=nil, m=2371, x=55.0, y=48.0, achieve=42771, exp="TWW"},
	{name="Earthcrawl Mines",	normal=7863,bountiful=nil, m=2248, x=38.7, y=73.6, achieve=40527, exp="TWW"},
	{name="Excavation Site 9",	normal=8143,bountiful=nil, m=2214, x=79.0, y=96.7, achieve=41098, exp="TWW"},
	{name="Fungal Folly",		normal=7864,bountiful=nil, m=2248, x=52.3, y=66.0, achieve=40525, exp="TWW"},
	{name="Kriegval's Rest",	normal=7865,bountiful=nil, m=2248, x=62.0, y=42.0, achieve=40526, exp="TWW"},
	{name="Mycomancer Cavern",	normal=7869,bountiful=nil, m=2215, x=71.2, y=31.1, achieve=40531, exp="TWW"},
	{name="Nightfall Sanctum",	normal=7868,bountiful=nil, m=2215, x=35.1, y=46.2, achieve=40530, exp="TWW"},
	{name="Sidestreet Sluice",	normal=8140,bountiful=nil, m=2346, x=35.2, y=52.6, achieve=41099, exp="TWW"},
	{name="Skittering Breach",	normal=7871,bountiful=nil, m=2215, x=66.6, y=61.7, achieve=40533, exp="TWW"},
	{name="Tak-Rethan Abyss",	normal=7873,bountiful=nil, m=2255, x=54.8, y=72.6, achieve=40535, exp="TWW"},
	{name="The Dread Pit",		normal=7867,bountiful=nil, m=2214, x=73.6, y=38.4, achieve=40529, exp="TWW"},
	{name="The Sinkhole",		normal=7870,bountiful=nil, m=2215, x=50.6, y=50.7, achieve=40532, exp="TWW"},
	{name="The Spiral Weave",	normal=7874,bountiful=nil, m=2255, x=45.5, y=21.6, achieve=40536, exp="TWW"},
	{name="The Underkeep",		normal=7872,bountiful=nil, m=2216, x=57.3, y=64.9, achieve=40534, exp="TWW"},
	{name="The Waterworks",		normal=7866,bountiful=nil, m=2214, x=46.2, y=48.0, achieve=40528, exp="TWW"},
}

local KEYS_CURRENCY_ID = 3028
local SHARDS_CURRENCY_ID = 3310

local widget={
	ident = "bountifuldelves",
	group = "dungeons",
	sizes = {
		{width = 3,height = 2}
	},
	sizelimits = {
		minwidth = 3,
		minheight = 2,
		maxwidth = 4,
		maxheight = 2,
	},
}

local SCROLLTABLE_DATA = {
	ROW_COUNT = 25,
	LIST_WIDTH = 600,
	LIST_HEIGHT = 550,
	POSX = 10,
	POSY = -34,
	BORDER = {0,0,0,0},
	BACKGROUND = {0,0,0,0},
	ROWBACKGROUND = false,
	ROW_HEADER = 25,
	HIDESCROLLBAR = true,
	STRATA = "DIALOG",
}
local SCROLLTABLE_COLUMNS = {
	{ title="", width=20, headerwidth=20, titlej="LEFT", textj="LEFT", name="expansion", type="icon"},
	{ title="", width=20, headerwidth=20, titlej="LEFT", textj="LEFT", name="icon", type="icon"},
	{ title="Delve", width=245, titlej="LEFT", textj="LEFT", name="name", padding=5 },
	{ title="Stories", width=50, titlej="RIGHT", textj="RIGHT", name="stories", padding=5 },
	{ title="", width=20, headerwidth=20, titlej="LEFT", textj="LEFT", name="iconstory", type="icon", iconset="StepLineIcons", iconkey="CHECK"},
	{ title="Active", width=245, titlej="LEFT", textj="LEFT", name="story", padding=5 },
}

function widget:Initialise()
	self.frame = ZGV.UI:Create("Button",ZGV.Widgets.Parent,nil,nil,"ZGV_Widget_Template")
	self.frame.text = CHAIN(self.frame:CreateFontString())
		:SetPoint("TOPLEFT",10,-10)
		:SetFont(FONTBOLD,14)
		:SetTextColor(1,1,1,1)
		:SetText(L["widget_bountifuldelves_name"])
		:SetIgnoreParentAlpha(true)
	.__END
	self.frame.empty = CHAIN(self.frame:CreateFontString())
		:SetPoint("CENTER")
		:SetFont(FONT,14)
		:SetTextColor(1,1,1,1)
		:SetText(L["widget_bountifuldelves_empty"])
		:SetIgnoreParentAlpha(true)
	.__END

	self.frame.currency = CHAIN(self.frame:CreateFontString())
		:SetPoint("TOPRIGHT",self.frame,"TOPRIGHT",-10,-10)
		:SetFont(FONT,13)
		:SetTextColor(1,1,1,1)
		:SetJustifyH("RIGHT")
		:SetIgnoreParentAlpha(true)
		:SetText("")
		:Show()
	.__END

	self.buttons = {}

	local prev
	for i=1,5 do
		local row = CHAIN(ZGV.UI:Create("Button",self.frame))
			:SetPoint("RIGHT")
			:SetHeight(20)
			:Hide()
			:SetIgnoreParentAlpha(true)
			:SetBackdropBorderColor(0,0,0,0)
		.__END

		if prev then
			row:SetPoint("TOPLEFT",prev,"BOTTOMLEFT",0,-2)
		else
			row:SetPoint("TOPLEFT",self.frame.text,"BOTTOMLEFT",0,-8)
		end

		prev = row

		row.tex = CHAIN(row:CreateTexture())
			:SetPoint("LEFT")
			:SetSize(18,18)
			:Show()
		.__END
		
		row.tex:SetAtlas("delves-bountiful")

		row.text = CHAIN(row:CreateFontString())
			:SetFont(FONT,13)
			:SetPoint("LEFT",row.tex,"RIGHT",5,0)
			:SetPoint("RIGHT",-20,0)
			:SetWordWrap(false)
			:SetJustifyH("LEFT")
		.__END

		row:SetScript("OnClick",function() 
			ZGV.Pointer:SetWaypoint(row.entry.m,row.entry.x,row.entry.y,{
				title=row.entry.name,
				type="manual",
				cleartype=not IsControlKeyDown(),
				icon=ZGV.Pointer.Icons.greendotbig,
				onminimap="always",
				overworld=true,
				showonedge=true,
				findpath=true,
			})		
		end)

		row:SetNormalBackdropColor(1,1,1,0)
		row:SetHighlightBackdropColor(1,1,1,0.15)

		table.insert(self.buttons,row)
	end

	self.popup = CHAIN(ZGV.CreateFrameWithBG("Button",nil,ZGV.Widgets.Fader))
		:SetSize(ZGV.Widgets.Fader:GetWidth(),ZGV.Widgets.Fader:GetHeight())
		:SetScript("OnShow",function() self:UpdateDetails() end)
	.__END
		
	Mixin(self,ZGV_Widget_Object_Mixin)
end

function widget:ApplySkin()
end

function widget:Update()
	local keyInfo = C_CurrencyInfo.GetCurrencyInfo(KEYS_CURRENCY_ID)
	local shardInfo = C_CurrencyInfo.GetCurrencyInfo(SHARDS_CURRENCY_ID)

	if keyInfo and shardInfo then
		self.frame.currency:SetText(string.format("|T%d:16:16:0:0:64:64:4:60:4:60|t %d    |T%d:16:16:0:0:64:64:4:60:4:60|t %d (%d/%d)",
			keyInfo.iconFileID, keyInfo.quantity,
			shardInfo.iconFileID, shardInfo.quantity,
			shardInfo.quantityEarnedThisWeek, shardInfo.maxWeeklyQuantity))
		self.frame.currency:Show()
	end

	local active = {}

	for _,entry in ipairs(delves) do
		if entry.bountiful and C_AreaPoiInfo.GetAreaPOIInfo(entry.m,entry.bountiful) then
			table.insert(active,entry)
			entry.isbountiful = true
		else
			entry.isbountiful = false
		end
	end

	table.sort(active,function(a,b) return a.name < b.name end)

	for _,button in ipairs(self.buttons) do
		button:Hide()
	end

	local count = 0
	
	for _,entry in ipairs(active) do
		count = count + 1
		local button = self.buttons[count]
		if button then
			button.entry=entry
			button.text:SetText(entry.name)
			button:Show()
		else
			break
		end
	end

	if count==0 then
		self.frame.empty:Show()
		local expansion = GetExpansionLevel()
		local maxlevel = GetMaxLevelForExpansionLevel(expansion)
		if (UnitLevel("player")==maxlevel) then
			self.frame.empty:SetText(L["widget_bountifuldelves_empty"])
		else
			self.frame.empty:SetText(L["widget_bountifuldelves_locked"])
		end
	
	else
		self.frame.empty:Hide()
	end
end

function widget:UpdateDetails()
	for _,delve in ipairs(delves) do
		local areapoi = delve.bountiful and C_AreaPoiInfo.GetAreaPOIInfo(delve.m,delve.bountiful) or C_AreaPoiInfo.GetAreaPOIInfo(delve.m,delve.normal)
		local widgetsID = areapoi.widgetSetID or areapoi.tooltipWidgetSet
		local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(widgetsID)
		for windex,w in ipairs(widgets) do
			if w.widgetType == Enum.UIWidgetVisualizationType.TextWithState then
				local visualisationinfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(w.widgetID)
				if visualisationinfo.orderIndex==0 then
					delve.story = visualisationinfo.text:match("WHITE_FONT_COLOR:(.*)")
				end
			end
		end

		if delve.achieve then
			local _, _, _, completed = GetAchievementInfo(delve.achieve)
			local num = GetAchievementNumCriteria(delve.achieve)
			if completed then
				delve.story_completed = true
				delve.stories_total = num
				delve.stories_done = num
			else
				delve.stories_total = num
				delve.stories_done = 0
				for i=1,num do
					local desc,ctype,completed,quantity,required = ZGV.Zygor_GetAchievementCriteriaInfo(delve.achieve,i)
					if desc==delve.story then
						delve.story_completed = completed
						delve.story_found = true
					end
					if completed then
						delve.stories_done = delve.stories_done + 1
					end
				end
			end
		end
	end
end

function widget:OnEvent()
	if self.frame and self.frame:IsVisible() then
		self:Update()
	end

        local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(setId)

end

local function ShowTooltip(row)
	if not row.object then return end
	local link = GetAchievementLink(row.object.achieve)
	if not link then return end

	GameTooltip:SetOwner(row, "ANCHOR_CURSOR")
	GameTooltip:SetHyperlink(link)
	GameTooltip:Show()
end

local function HideTooltip(row)
	GameTooltip:FadeOut()
end

function widget:InitialisePopup()
	if self.popupready then return end

	self.popup.header = CHAIN(self.popup:CreateFontString())
		:SetPoint("TOPLEFT",30,-10)
		:SetFont(FONT,18,"") 
		:SetTextColor(1,1,1,1)
		:SetText(L["widget_bountifuldelves_stories_header"])
	.__END

	self.popup.scrolltableoffset = 0

	self.popup.scrolltable = ZGV.UI:Create("ScrollTable",self.popup,nil,SCROLLTABLE_COLUMNS,SCROLLTABLE_DATA)
	self.popup.scrolltable:SetScript("OnMouseWheel", function(popup,delta)
		self.popup.scrolltableoffset = self.popup.scrolltableoffset-delta
		self:OnPopup()
	end)
	self.popup.scrolltable.scrollbar:SetScript("OnVerticalScroll",function(popup,offset)
		self.popup.scrolltableoffset=math.round(offset)
		self:OnPopup()
	end)

	for _,row in ipairs(self.popup.scrolltable.rows) do
		row:SetScript("OnEnter", function() ShowTooltip(row) end)
		row:SetScript("OnLeave", function() HideTooltip(row) end)
		row.expansion:SetAlpha(0.7)

		row:SetScript("OnClick",function() 
			ZGV.Pointer:SetWaypoint(row.object.m,row.object.x,row.object.y,{
				title=row.object.name,
				type="manual",
				cleartype=not IsControlKeyDown(),
				icon=ZGV.Pointer.Icons.greendotbig,
				onminimap="always",
				overworld=true,
				showonedge=true,
				findpath=true,
			})		
		end)
	
	end

	self.popupready = true
end

function widget:OnPopup()
	local rownum=0
	local ROW_COUNT = self.popup.scrolltable:CountRows()
	local results=#delves

	self.popup.scrolltableoffset = max(0,min(self.popup.scrolltableoffset,results-ROW_COUNT))
	local rowoff=self.popup.scrolltableoffset

	local itemindex = 1
	for ii,object in ipairs(delves) do
		rownum = itemindex-rowoff
		if rownum>0 and rownum<ROW_COUNT+1 then 
			local row = self.popup.scrolltable.rows[rownum]
			
			row.object = object

			if object.isbountiful then
				row.icon:SetAtlas("delves-bountiful")
			else
				row.icon:SetAtlas("delves-regular")
			end
			
			ZGV.IconSets.ExpansionIcons[object.exp]:AssignToTexture(row.expansion)
			
			row.name:SetText(object.name)
			row.story:SetText(object.story)
			row.stories:SetText(("%d/%d"):format(object.stories_done,object.stories_total))
			
			if object.story_completed then
				row.iconstory:SetVertexColor(0,1,0,1)
				row.story:SetTextColor(1,1,1,1)
			elseif not object.story_found then
				row.story:SetTextColor(0.5,0.5,0.5,1)
				row.iconstory:SetVertexColor(0.3,0.3,0.3,1)
			else
				row.story:SetTextColor(1,1,1,1)
				row.iconstory:SetVertexColor(0.3,0.3,0.3,1)
			end
				
			row:Show()
		end
		itemindex=itemindex+1 
	end
	
	self.popup.scrolltable:TotalValue(results)
	self.popup.scrolltable:SetValue(rowoff)
	for r=rownum+1,ROW_COUNT do 
		self.popup.scrolltable.rows[r]:Hide() 
		self.popup.scrolltable.rows[r].item = nil
	end
end

ZGV.Widgets:RegisterWidget(widget)