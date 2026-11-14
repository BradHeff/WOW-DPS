local name,ZGV = ...

local L = ZGV.L
local CHAIN = ZGV.ChainCall
local ZGVG=ZGV.Gold
local FONT=ZGV.Font

local Goldguide = ZGV.Goldguide

Goldguide.Farming = {}
local Farming=Goldguide.Farming

setmetatable(Goldguide.Farming,{__index=Goldguide.Common})

function Farming:New(data)
	data.time=data.time or 60
	setmetatable(data,{__index=Farming,__lt=Farming.sorting})
	table.insert(Goldguide.Chores.Farming,data)
end

local heatcodes = {
	{9000,"|cffFFEE00"},
	{8000,"|cffFDF140"},
	{7000,"|cffFCF380"},
	{6000,"|cffFAF6BF"},
	{5000,"|cffF8F8FF"},
	{4000,"|cffFAE5E6"},
	{3000,"|cffFCD1CC"},
	{2000,"|cffFDBEB3"},
	{1000,"|cffFFAA99"},
	{0,"|cffFFAA99"},
}

function Farming:GetDisplayInfo(refresh)
	if self.cached_display and not refresh then return unpack(self.cached_display) end

	self.needsRefresh=false

	-- icon
	local iconitem
	if #self.good_items>0 then 
		iconitem=self.good_items[1].itemdata[1]
	elseif #self.bad_items>0 then 
		iconitem=self.bad_items[1].itemdata[1]
	end
	local icon = iconitem and select(10,ZGV:GetItemInfo(iconitem))
	if not icon then self.needsRefresh=true end

	self.dispgold = self.score_raw
	
	local dispscore = ""
	for i,data in ipairs(heatcodes) do
		if self.score>=data[1] then
			dispscore = data[2]..self.score
			break
		end
	end

	self.cached_display={
		icon,
		self.name,
		self.maps,
		dispscore
		}

	return unpack(self.cached_display)
end

local detailed_filters = {
	mining=true,
	herbalism=true,
	skinning=true,
	fishing=true,
	enchanting=true,
}
function Farming:IsValidChore()
	if ZGV.db.profile.gmgoldallvalid then self.valid=true return true,"debug override" end

	self.valid=false
	--if self.profitperhour<=0 then return false,"no profit" end
	if ZGV.db.profile.gold_farming_type~="all" then
		if detailed_filters[ZGV.db.profile.gold_farming_type] then
			if self.parentskill~=ZGV.db.profile.gold_farming_type then return false,"skill filter" end
		else
			if ZGV.db.profile.gold_farming_type~=self.meta.itemtype then return false,"type filter" end
		end
	end

	if ZGV.db.profile.gold_farming_valid then
		local reqs_met,err = self:AreRequirementsMet()
		if not reqs_met then return false,"requirements not met",err end
	end

	--if (not ZGV.db.profile.gold_farming_mode and (#self.good_items<=0 or (self.scale and self.scale<Goldguide.TIER_DEMAND_MEDIUM))) then return false,"mode filter" end
	
	local query = string.lower(Goldguide.MainFrame.MenuFrame.SearchEdit:GetText())
	if query and query~="" then 
		if not string.match(string.lower(self.name), query) then return false,"name query" end
	end

	self.valid=true
	return true
end

function Farming.dynamic_sort(a,b)
	return Goldguide.dynamic_sort("farming",a,b, ZGV.db.profile.goldsort['farming'][1],ZGV.db.profile.goldsort['farming'][2], "name","asc")
end


function Farming:GetTooltipData(refresh)
	if self.cached_tooltip and not refresh then return self.cached_tooltip end

	local price_desc = " /ea"
	local drops_desc = " /hr"

	local h = floor(self.scale)
	local m = (self.scale-h)*60
	m=m-m%5 --trunc to 10
	if h>2 then m=nil end
	local hm = (h>0 and h.."h" or "") .. (h>0 and m and " " or "") .. (m and (m .. "m") or "")

	self.cached_tooltip = {items={},separator=false}

	for ii,item in ipairs(self.good_items) do
		local itemname,itemlink = ZGV:GetItemInfo(item.itemdata[1])

		local demand
		-- DEMAND TIERS
		if item.itemdata.scale>=Goldguide.TIER_DEMAND_HIGH then
			demand=Goldguide.COLOR_DEMANDGREAT ..math.floor(item.itemdata.demand).."|r"
		elseif item.itemdata.scale>=Goldguide.TIER_DEMAND_MEDIUM then
			demand=Goldguide.COLOR_DEMANDGOOD ..math.floor(item.itemdata.demand).."|r"
		else
			demand=Goldguide.COLOR_DEMANDLOW ..math.floor(item.itemdata.demand).."|r"
		end
		
		local comment
		if item.itemdata.gouged then
			comment="Gouged; price raised."
		elseif item.itemdata.empty then
			comment="Market empty; price raised."
		else
			comment=""
		end

		local scaled_profit = item.profit * self.scale

		if not item.itemdata[3] then
			table.insert(self.cached_tooltip.items,{
				item=itemlink,
				price=ZGV.GetMoneyString(item.price)..price_desc, 
				demand=demand,
				status=comment
			})
		end
	end
	if self.good_items and #self.good_items>0 and #self.bad_items>0 then 
		self.cached_tooltip.separator = #self.good_items
	end

	if self.bad_items then
		for ii,item in ipairs(self.bad_items) do
			local itemname,itemlink = ZGV:GetItemInfo(item.itemdata[1])
			local comment=""
			if item.itemdata[3] then --crap
				comment="Vendor."
			elseif item.no_trend then
				if ZGV.IsClassic or ZGV.IsClassicTBC or ZGV.IsClassicWOTLK or ZGV.IsClassicCATA then
					comment="No trend data."
				else
					comment="Not useful."
				end
			elseif not item.is_lively then
				comment="Market stagnant, vendor."
			else
				comment=""
			end
			if not item.itemdata[3] then
				local scaled_profit = (item.profit or 0) * self.scale
				table.insert(self.cached_tooltip.items,{
					item=itemlink,
					price=ZGV.GetMoneyString(item.price)..price_desc, 
					demand=item.itemdata.demand or 0,
					status=comment
				})
			end
		end
	end


	local requirements = {}
	if self.leveldesc then table.insert(requirements,self.leveldesc) end
	if self.parentskilldesc then table.insert(requirements,self.parentskilldesc) end
	
	local headerlines = {}
	if #requirements>0 then table.insert(headerlines,"Requirements: "..table.concat(requirements,", ")) end
	if self.crap_rate then table.insert(headerlines,"|cff9100ffLow gathering skill level will result in lower amount of items.|r") end

	if #headerlines>0 then
		self.cached_tooltip.header = table.concat(headerlines,"\n")
	end

	-- crop display to 30 entries
	while #self.cached_tooltip.items>30 do table.remove(self.cached_tooltip.items) end

	return self.cached_tooltip
end