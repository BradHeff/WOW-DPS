--[[
	widget_locations_name
	widget_locations_empty
	widget_locations_recordtooltip
	widget_locations_header
--]]

local ZGV = ZGV
local L = ZGV.L
local CHAIN = ZGV.ChainCall
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local SkinData = ZGV.UI.SkinData
local ZGV_Widget_Object_Mixin = ZGV_Widget_Object_Mixin

local widget={
	ident = "locations",
	group = "general",
	sizes = {
		{width = 2,height = 2}
	},
	sizelimits = {
		minwidth = 2,
		minheight = 2,
		maxwidth = 4,
		maxheight = 4,
	},
}

local ROWS_PER_HEIGHT = 4
local ROW_COUNT_NORMAL = ROWS_PER_HEIGHT*widget.sizelimits.maxheight - 2 -- two rows saved for header/footer

local SCROLLTABLE_DATA = {
	ROW_COUNT = 25,
	LIST_WIDTH = 600,
	LIST_HEIGHT = 550,
	POSX = 3,
	POSY = -34,
	BORDER = {0,0,0,0},
	BACKGROUND = {0,0,0,0},
	ROWBACKGROUND = false,
	ROW_HEADER = 0,
	HIDESCROLLBAR = true,
	STRATA = "DIALOG",
}

local SCROLLTABLE_COLUMNS = {
	{ title="", width=14, headerwidth=18, titlej="LEFT", textj="LEFT", name="icon", type="icon", padding=5 },
	{ title="", width=280, titlej="LEFT", textj="LEFT", name="name", padding=5},
	{ title="", width=240, titlej="LEFT", textj="LEFT", name="location", padding=5},
	{ title="", width=14, headerwidth=20, titlej="LEFT", textj="LEFT", name="rename", type="button", padding=5, iconset="TitleButtons", iconkey="LIST",  },
	{ title="", width=14, headerwidth=20, titlej="LEFT", textj="LEFT", name="remove", type="button", padding=5, iconset="TitleButtons", iconkey="SMALLX" },
}

local NAME_NOT_SET_WIDTH = SCROLLTABLE_COLUMNS[2].width + SCROLLTABLE_COLUMNS[3].width -2 -- if custom name is not set, we are showing coords as name, and hiding location
local NAME_SET_WIDTH = SCROLLTABLE_COLUMNS[2].width
local LOCATION_WIDTH = SCROLLTABLE_COLUMNS[3].width

function widget.FinishRename(widget,row,save)
	-- row entry is the array in saved vars, so editing it will edit saved vars
	local entry = row.entry
	if not entry then return end
	if save then
		widget:RenameLocation(entry,row.editbox:GetText())
	end
	row.editbox:ClearFocus()
	row.editbox:Hide()
end

function widget:Initialise()
	self.frame = ZGV.UI:Create("Button",ZGV.Widgets.Parent,nil,nil,"ZGV_Widget_Template")
	self.frame.text = CHAIN(self.frame:CreateFontString())
		:SetPoint("TOPLEFT",10,-10)
		:SetFont(FONTBOLD,14)
		:SetTextColor(1,1,1,1)
		:SetText(L["widget_locations_name"])
		:SetIgnoreParentAlpha(true)
	.__END

	self.frame.empty = CHAIN(self.frame:CreateFontString())
		:SetPoint("CENTER")
		:SetPoint("LEFT",10,0)
		:SetPoint("RIGHT",-10,0)
		:SetFont(FONT,13)
		:SetTextColor(1,1,1,1)
		:SetText(L["widget_locations_empty"])
		:SetWordWrap(true)
		:SetJustifyH("CENTER")
		:SetIgnoreParentAlpha(true)
	.__END

	-- "Record current location" button, top right corner of the widget.
	self.frame.recordbutton = CHAIN(CreateFrame("Button",nil,self.frame,"ZGV_DefaultSkin_TitleButton_Template"))
		:SetSize(20,20)
		:SetPoint("TOPRIGHT",self.frame,"TOPRIGHT",-10,-10)
		:SetFrameLevel(self.frame:GetFrameLevel()+5)
		:SetScript("OnClick",ZGV.WhoWhere.RecordLocation)
		:SetScript("OnEnter",function(btn)
			GameTooltip:SetOwner(btn,"ANCHOR_BOTTOMLEFT")
			GameTooltip:SetText(L["widget_locations_recordtooltip"])
			GameTooltip:Show()
		end)
		:SetScript("OnLeave",function() GameTooltip:Hide() end)
		:Show()
	.__END
	self.frame.recordbutton.buttonkey = "PLUS"
	self.frame.recordbutton:ApplySkin()

	self.buttons = {}

	local prev
	for i=1,ROW_COUNT_NORMAL do
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

		row.icon = CHAIN(row:CreateTexture())
			:SetPoint("LEFT")
			:SetSize(10,10)
			--:SetColorTexture(1,1,1,1)
			:Show()
		.__END

		row.name = CHAIN(row:CreateFontString())
			:SetFont(FONT,13)
			:SetPoint("LEFT",row.icon,"RIGHT",7,0)
			:SetPoint("RIGHT",-4,0)
			:SetWordWrap(false)
			:SetJustifyH("LEFT")
		.__END

		row:SetScript("OnClick",function()
			ZGV.WhoWhere.SetLocationWaypoint(row.entry)
		end)

		row:SetNormalBackdropColor(1,1,1,0)
		row:SetHighlightBackdropColor(1,1,1,0.15)

		table.insert(self.buttons,row)
	end

	do 
		-- add editbox to first main screen line, so we can add name automatically
		local row = self.buttons[1]
		row.editbox = CHAIN(ZGV.UI:Create("EditBox",row))
			:SetPoint("TOPLEFT",row.name,"TOPLEFT",-4,0)
			:SetPoint("BOTTOMRIGHT",row.name,"BOTTOMRIGHT",0,0)
			:SetFont(FONT,13,"")
			:SetFrameLevel(row:GetFrameLevel()+4)
			:Hide()
			:SetScript("OnEnterPressed",function() widget.FinishRename(self,row,true) end)
			:SetScript("OnEscapePressed",function()
				if row.entry then row.editbox:SetText(row.entry.name) end
				widget.FinishRename(self,row,false)
			end)
			:SetScript("OnEditFocusLost",function() widget.FinishRename(self,row,true) end)
		.__END
	end

	self.popup = CHAIN(ZGV.CreateFrameWithBG("Button",nil,ZGV.Widgets.Fader))
		:SetSize(ZGV.Widgets.Fader:GetWidth(),ZGV.Widgets.Fader:GetHeight())
		:SetScript("OnShow",function() self:OnPopup() end)
	.__END

	Mixin(self,ZGV_Widget_Object_Mixin)

	self:Update()
	self:ApplySkin()
end

function widget:ApplySkin()
	self.buttons[1].editbox:SetTextColor(1,1,1,1)

	CHAIN(self.buttons[1].editbox.back)
		:SetBackdrop(SkinData("SearchBackdrop"))
		:SetBackdropColor(unpack(SkinData("SearchEditBackdropColor")))
		:SetBackdropBorderColor(unpack(SkinData("SearchEditBorderColor")))

	for _,row in ipairs(self.buttons) do
		ZGV.ButtonSets.TitleButtons.MAPMARKER:AssignToTexture(row.icon)
	end

	if not self.popupready then return end
	for _,row in ipairs(self.popup.scrolltable.rows) do
		row.editbox:SetTextColor(1,1,1,1)
		row.location:SetTextColor(0.6,0.6,0.6,1)

		ZGV.ButtonSets.TitleButtons.MAPMARKER:AssignToTexture(row.icon)

		CHAIN(row.editbox.back)
			:SetBackdrop(SkinData("SearchBackdrop"))
			:SetBackdropColor(unpack(SkinData("SearchEditBackdropColor")))
			:SetBackdropBorderColor(unpack(SkinData("SearchEditBorderColor")))
	end
end

-- Removes a saved location entry
function widget:RemoveLocation(entry)
	local list = ZGV.db.char.savedLocations
	if not list then return end

	for i,v in ipairs(list) do
		if v==entry then
			table.remove(list,i)
			break
		end
	end

	self:Update()
	if self.popup:IsVisible() then self:OnPopup() end
end

-- Renames a saved location entry.
function widget:RenameLocation(entry,newname)
	if not entry then return end
	newname = newname and newname:trim()
	if not newname or newname=="" then return end

	entry.name = newname

	self:Update()
	if self.popup:IsVisible() then self:OnPopup() end
end

function widget:Update()
	local list = ZGV.db.char.savedLocations or {}

	for _,button in ipairs(self.buttons) do
		button:Hide()
	end

	local visible_count = self.height * ROWS_PER_HEIGHT - 2
		
	for i=1,math.min(visible_count,#list) do
		local entry = list[i]
		local button = self.buttons[i]
		button.entry = entry
		button.name:SetText(entry.name)
		button:Show()
	end

	if #list==0 then
		self.frame.empty:Show()
	else
		self.frame.empty:Hide()
	end
end

function widget:InitialisePopup()
	if self.popupready then return end

	self.popup.header = CHAIN(self.popup:CreateFontString())
		:SetPoint("TOPLEFT",30,-10)
		:SetFont(FONT,18,"")
		:SetTextColor(1,1,1,1)
		:SetText(L["widget_locations_header"])
	.__END

	self.popup.recordbutton = CHAIN(CreateFrame("Button",nil,self.popup,"ZGV_DefaultSkin_TitleButton_Template"))
		:SetSize(20,20)
		:SetPoint("TOPRIGHT",self.popup,"TOPRIGHT",-5,-5)
		:SetScript("OnClick",ZGV.WhoWhere.RecordLocation)
		:SetScript("OnEnter",function(btn)
			GameTooltip:SetOwner(btn,"ANCHOR_BOTTOMLEFT")
			GameTooltip:SetText(L["widget_locations_recordtooltip"])
			GameTooltip:Show()
		end)
		:Show()
	.__END
	self.popup.recordbutton.buttonkey = "PLUS"
	self.popup.recordbutton:ApplySkin()

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
		-- Clicking anywhere on the row (other than Rename/Remove) sets the waypoint.
		row:SetScript("OnClick",function()
			ZGV.WhoWhere.SetLocationWaypoint(row.entry)
		end)

		-- Inline rename edit box, overlaid on top of the name column		
		row.editbox = CHAIN(ZGV.UI:Create("EditBox",row))
			:SetPoint("TOPLEFT",row.name,"TOPLEFT",-4,0)
			:SetPoint("BOTTOMRIGHT",row.name,"BOTTOMRIGHT",0,0)
			:SetFont(FONT,12,"")
			:SetFrameLevel(row:GetFrameLevel()+4)
			:Hide()
			:SetScript("OnEnterPressed",function() widget.FinishRename(self,row,true) end)
			:SetScript("OnEscapePressed",function()
				if row.entry then row.editbox:SetText(row.entry.name) end
				widget.FinishRename(self,row,false)
			end)
			:SetScript("OnEditFocusLost",function() widget.FinishRename(self,row,true) end)
		.__END

		row.rename:SetScript("OnClick",function()
			row.editbox:Show()
			row.editbox:SetFocus()
			row.editbox:HighlightText()
		end)
		row.remove:SetScript("OnClick",function() self:RemoveLocation(row.entry) end)
	end

	self.popupready = true
	self:ApplySkin()
end

function widget:OnPopup()
	if not self.popupready then self:InitialisePopup() end

	local list = ZGV.db.char.savedLocations or {}

	local rownum=0
	local ROW_COUNT = self.popup.scrolltable:CountRows()
	local results=#list

	self.popup.scrolltableoffset = max(0,min(self.popup.scrolltableoffset,results-ROW_COUNT))
	local rowoff=self.popup.scrolltableoffset

	local itemindex = 1
	for ii,entry in ipairs(list) do
		rownum = itemindex-rowoff
		if rownum>0 and rownum<ROW_COUNT+1 then
			local row = self.popup.scrolltable.rows[rownum]

			row.entry = entry

			row.name:SetText(entry.name)
			
			local location = ("%s %.2f, %.2f"):format(entry.mapName,entry.x*100,entry.y*100)
			if entry.name~=location then
				row.name:SetWidth(NAME_SET_WIDTH)
				row.location:SetWidth(LOCATION_WIDTH)
				row.location:SetText(location)
			else
				row.name:SetWidth(NAME_NOT_SET_WIDTH)
				row.location:SetWidth(0)
				row.location:SetText("")
			end

			
			row.editbox:SetText(entry.name)

			-- Abort any lingering rename edit box when the row gets reused/refreshed.
			if row.editbox:IsShown() then widget.FinishRename(self,row,false) end

			row:Show()
		end
		itemindex=itemindex+1
	end

	self.popup.scrolltable:TotalValue(results)
	self.popup.scrolltable:SetValue(rowoff)
	for r=rownum+1,ROW_COUNT do
		local row = self.popup.scrolltable.rows[r]
		row:Hide()
		if row.editbox:IsShown() then widget.FinishRename(self,row,false) end
		row.entry = nil
	end
end

function widget:OnResize()
	self:Update()
end

function widget:OnEvent()
	if self.frame and self.frame:IsVisible() then
		self:Update()
	end
end

ZGV.Widgets:RegisterWidget(widget)