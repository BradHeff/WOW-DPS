-- GLOBAL LibRover,LibRover_Node,LibRover_Region

LibRover_Region = {}

local Region=LibRover_Region


local Lib

local BZ = LibStub("LibBabble-SubZone-3.0")
local BZL = BZ:GetUnstrictLookupTable()
local BZR = setmetatable({_table=BZ:GetReverseLookupTable()},{__index=function(t,k) return t._table[k] or k end})

function Region:New(data)
	local region=data
	setmetatable(region,{__index=self})

	self = region

	if self[1]=="REGION" then tremove(self,1) end

	if self.center then
		local m1,f1,x1,y1,id1,dat1 = LibRover_Node:Parse(self.center)   self.center=nil
		self.centernode = self.centernode or ( x1 and LibRover_Node:New{c=ZGV.GetMapContinent(m1),m=m1,f=f1,x=x1,y=y1,id=id1,type="misc"} ) or Lib.nodes.id[self.centernodeid] or Lib.nodes.id[id1]
	end
	if self.poly then
		-- polygon defined as pairs of coords
		if #self.poly<3 then error("Region "..self.name.." poly: must have at least 3 coordinates") end
		for i,coord in ipairs(self.poly) do
			if #coord~=2 then error("Region "..self.name.." poly: coordinate at index "..i.." must have 2 values") end
		end
		if not self.mapzone then error("Region "..self.name.." poly: missing mapzone") end
		-- actual poly matching: in Contains
	end
	if self.greenborders then
		for ni,n in ipairs(self.greenborders) do
			local f
			if type(n) == "table" then
				f = n[2]
				n = n[1]
			end
			local id = Lib.data.MapIDsByName[n]
			if id then self.greenborders[id]=f or true end
		end
	end

	if self.zonematch then
		local zone,realzone,subzone,minizone=self.zonematch:match("^(.-)/(.-)/(.-)/(.-)$")
		local function verify(z)
			if z=="*" then return nil end
			return z
		end
		if zone then
			local err
			self.zone,err = verify(zone)  if err then return nil,err end
			self.realzone,err = verify(realzone)  if err then return nil,err end
			self.subzone,err = verify(subzone)  if err then return nil,err end
			self.minizone,err = verify(minizone)  if err then return nil,err end
		end
	end
	for _,boo in ipairs{"indoors","nofly","in_flight","submerged"} do if self[boo]~=nil then self[boo]=(self[boo]==1 or self[boo]==true) end end
	
	if type(self.mapzone)=="string" then self.mapzone = LibRover:GetMapByNameFloor(self.mapzone) end

	return region
end

-- x,y are 0-1 coordinates, will be scaled to 0-100
-- poly has 0-100 coords
local function pointInPoly(x, y, coords)
    local odd = false
    local p1
	local p2=coords[#coords]
	x,y=x*100,y*100

    for i = 1,#coords do
        p1 = coords[i]
        
        -- 1. Check if the ray's Y matches the edge's Y span
        if (p1[2] > y) ~= (p2[2] > y) then
            -- 2. Compute the exact X intersection point on the edge line
            local intersectX = (p2[1] - p1[1]) * (y - p1[2]) / (p2[2] - p1[2]) + p1[1]
            
            -- 3. If our test point is to the left of the intersection, the ray crosses the edge
            if x < intersectX then
                odd = not odd
            end
        end
        p2 = p1 -- Move the previous index forward
    end

    return odd
end

function Region:Contains(node,debug)
	--Lib:Debug(getdist(self.centernode,node))
	if not self.name then BADREGION=self error("Bad region definition! Stored in var BADREGION") end
	if self.name==node.region then
		return true,debug and "already in"  -- that's a no-brainer
	elseif node.region then
		return false,debug and "already in diff region: "..node.region  -- in different region
	else
		local flyspeed_in_zone = LibRover.maxspeedinzone[node.m][3]
		if flyspeed_in_zone>0 and not self.indoors and not self.in_flight then return false,debug and "player can fly" end
		if self.indoors~=nil and node.indoors~=self.indoors then return false,debug and "indoors mismatch" end
		if self.submerged~=nil and node.submerged~=self.submerged then return false,debug and "submerged mismatch" end
		if self.cond_fun then
			local ok,result = pcall(self.cond_fun)
			if not ok or not result then return false,debug and "cond_fun fail" end
		end
		if not self.centernode and not self.zonematch and not self.poly then return false,debug and "no center/zone/poly" end  -- no conditions? it must be a very special region... die. indoors doesn't matter at this point,
		if self.centernode then
			local centermatch = self.centernode.m==node.m and Lib.GetDist(self.centernode,node)<self.radius
			if not centermatch then return false,debug and "center mismatch" end
		end
		if self.zonematch then
			-- if any map name is specified, then it needs to match
			local zonematch = (not self.mapzone or node.m==self.mapzone)
				and (not self.zone or node.zone==self.zone)
				and (not self.realzone or node.realzone==self.realzone)
				and (not self.subzone or node.subzone==self.subzone)
				and (not self.minizone or node.minizone==self.minizone)
			if not zonematch then return false,debug and "zonematch mismatch" end
		end
		if self.poly then
			if self.mapzone~=node.m then return false,debug and "poly mapzone mismatch" end
			if not pointInPoly(node.x,node.y,self.poly) then return false,debug and "poly mismatch" end
		end
		return true  -- passed all
	end
end

function Region:HasGreenBorder(mapid)
	return self.greenborders and self.greenborders[mapid]
end

function Region:tostring()
	return self.name
end


function Region:InterfaceWithLib(lib)
	Lib=lib
end
