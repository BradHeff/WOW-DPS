local _n,ZGV = ...

---@class Telemetry

--- @alias TelemetryEventType
 ---| 'GUIDES_LOADED' # tabs: array of guides currently loaded, current: current guide
 ---| 'SHARE_STATE' # state: master, slave, party, solo
 ---| 'OPTIONS' # uiscale
 ---| 'WINDOW_STATE' # visible
 ---| 'STARTUP' # 
 ---| 'SHUTDOWN' # 
 ---| 'CLICKED_GOAL' # button: button, goalnum: number of goal
 ---| 'CLICKED_PROGRESSBAR' # 
 ---| 'STEPS_COMPLETED' # interval: time; num: step count
 ---| 'MAINMENU_ITEM' # item: name
 ---| 'ADDITIONALMENU_ITEM' # item: name
 ---| 'BUTTON_CLICKED' # item: name
--

--- @alias TelemetryHookTriggerType
---| "message"
---| "event"

---@alias TelemetryEvent { time:number,event:TelemetryEventType }

---@alias TelemetryHookTrigger { [1]:TelemetryHookTriggerType, [2]:string }
---@class TelemetryHook
 ---@field triggers TelemetryHookTrigger[]
 ---@field func fun(t:Telemetry,event?:string,...):nil
 ---@field autostart boolean
 ---@field init fun(t:Telemetry):nil
 ---@field final fun(t:Telemetry):nil


---@class Telemetry
local Telemetry = {}
ZGV.Telemetry = Telemetry

local T  ---@type TelemetryEvent[]
function Telemetry:Setup()
	ZGV.db.char.telemetry = ZGV.db.char.telemetry or {}  --[[@as TelemetryEvent[] ]]
	T = ZGV.db.char.telemetry 
	setmetatable(T,{__itemname=function(t) return ("%d min ago: %s %s"):format((time()-t.time)/60,t.event,(t.state~=nil and tostring(t.state) or t.num)) end})
	self:Prune()
	self:SetupEvents()
end

local MAX_EVENT_AGE=7*86400
function Telemetry:Prune()
	local now = time()
	while T[1] and now-T[1].time>MAX_EVENT_AGE do tremove(T,1) end
end

--- @param eventType TelemetryEventType
--- @param args table?
--- Records an event.
function Telemetry:AddEvent(eventType,args)
	local event = {time=time(),event=eventType}		---@type TelemetryEvent
	if args then for k,v in pairs(args) do event[k]=v end end
	tinsert(T,event)
end


function Telemetry:SetupEvents()
	for k,hook in ipairs(self.Hooks) do
		if hook.triggers then
			for _,trigger in ipairs(hook.triggers) do
				local typ,name = trigger[1],trigger[2]
				if typ=="message" then ZGV:AddMessageHandler(name,{self,hook.func})
				elseif typ=="event" then ZGV:AddEventHandler(name,{self,hook.func})
				else error("bad trigger type: "..tostring(typ)) end
			end
		end
		if hook.autostart then hook.func(self) end
		if hook.init then hook.init(self) end
	end
end

---@type TelemetryHook[]
Telemetry.Hooks = {
	{ -- STARTUP
		func=function (self)
			self:AddEvent('STARTUP')
		end,
		autostart=true,
	},
	{ -- VERSION
		func=function (self)
			self:AddEvent('VERSION',ZGV:GetFlavourVersion())
		end,
		autostart=true,
	},	
	{ -- SHUTDOWN
		triggers={{"event","PLAYER_LOGOUT"}},
		func=function (self)
			self:AddEvent('SHUTDOWN')
		end
	},
	{ -- GUIDES_LOADED
		triggers={{"message","GUIDE_CHANGED"}},
		func=function (self)
			self:AddEvent('GUIDES_LOADED',{
				tabs=ZGV.db.char.tabguides,
				current={title=ZGV.CurrentGuide and ZGV.CurrentGuide.title or "none",step=ZGV.CurrentStepNum or "none"}
			})
		end
	},
	{ -- SHARE_STATE
		triggers={{"message","ZGV_SHAREMODE"},{"event","GROUP_ROSTER_UPDATE"}},
		autostart=true,
		func=function (self)
			local shareState =
				(ZGV.Sync:IsMaster() and "master")
				or (ZGV.Sync:IsSlave() and "slave")
				or (GetNumGroupMembers()>0 and "party")
				or "solo"
			if shareState==self.lastShareState then return end  -- prevent spam when in a raid
			self:AddEvent('SHARE_STATE',{state=shareState})
			self.lastShareState=shareState
		end
	},
	{ -- WINDOW_STATE
		triggers={{"message","WINDOW_SHOWN"}},
		func=function (self)
			local windowState = ZGV.Frame:IsShown()
			if windowState==self.lastWindowState then return end
			self:AddEvent('WINDOW_STATE',{
				state=windowState
			})
			self.lastWindowState=windowState
		end
	},
	{ -- CLICKED_GOAL
		triggers={{"message","CLICKED_GOAL"}},
		func=function (self,ev,button,goalnum)
			self:AddEvent('CLICKED_GOAL',{
				button=button,
				goalnum=goalnum
			})
		end
	},
	{ -- CLICKED_PROGRESSBAR
		triggers={{"message","CLICKED_PROGRESSBAR"}},
		func=function (self,ev,state)
			self:AddEvent('CLICKED_PROGRESSBAR',{
				state=state
			})
		end
	},
	{ -- STEPS_COMPLETED
		triggers={{"message","STEP_COMPLETED"}},
		func=function (self)
			self.stepsCompleted = (self.stepsCompleted or 0)+1

		end,
		init=function (self)
			self.stepsCompleted=0
			local WrapUp = function ()
				self=Telemetry
				if self.stepsCompleted>0 then
					self:AddEvent("STEPS_COMPLETED",{
						num=self.stepsCompleted
					})
					self.stepsCompleted=0
				end
			end
			C_Timer.NewTicker(60,WrapUp)
			ZGV:AddEventHandler("PLAYER_LOGOUT",WrapUp)
		end,
	},
	{ -- OPTIONS
		autostart=true,
		func=function (self)
			self:AddEvent('OPTIONS',{
				uiscale=(GetCVar("useUiScale") or 0)=="1" and ("%2d%%"):format((GetCVar("uiscale") or 0)*100) or "off",
			})
		end
	},
	{ -- MAINMENU_ITEM, ADDITIONALMENU_ITEM
		triggers={{"message","MAINMENU_ITEM"},{"message","ADDITIONALMENU_ITEM"}},
		func=function (self,ev,itemname,state)
			self:AddEvent(ev,{
				item=itemname,
				state=state
			})
		end
	},
	{ -- BUTTON_CLICKED
		triggers={{"message","BUTTON_CLICKED"}},
		func=function (self,ev,itemname,button)
			self:AddEvent('BUTTON_CLICKED',{
				button=button,
				name=itemname,
			})
		end
	}
}


tinsert(ZGV.startups,{"Telemetry",function(self)
	Telemetry:Setup()
end})


Telemetry.Miner = {}
local Miner = Telemetry.Miner

Miner.RecentOptions = {}
Miner.CurrentStepData = {}
local gossipFormat = "Select _\"%s\"_ ||gossip %d"
local race = UnitRace("player")
local minerraceclass = (race or "??").." "..(UnitClass("player") or "??")
local ver = ZGV.version
local build = GetBuildInfo()


function Miner:Startup()
	-- Hook selection functions
	if C_GossipInfo then
		if C_GossipInfo.SelectOption then hooksecurefunc(C_GossipInfo, "SelectOption",function(id) Miner:GetSelectedOption("id",id) end) end
		if C_GossipInfo.SelectOptionByIndex then hooksecurefunc(C_GossipInfo, "SelectOptionByIndex",function(index) Miner:GetSelectedOption("index",index) end) end
	end

	-- record visible gossips. we can't wait for next frame, since autogossip will be too fast for us
	ZGV:AddEventHandler("GOSSIP_SHOW",Miner.GetGossips) 
	ZGV:AddEventHandler("PLAYER_INTERACTION_MANAGER_FRAME_SHOW",Miner.GetInteraction) 

	-- When we change step, verify that we have a reason to check its gossips
	ZGV:AddMessageHandler("ZGV_STEP_CHANGED", Miner.CheckCurrentStep)
end

function Miner:CheckCurrentStep()
	local gossip_target
	local step_has_quests

	for g,goal in ipairs(ZGV.CurrentStep.goals) do
		if goal.action=="talk" then
			gossip_target = goal.npcid
		end
		if goal.action=="accept" or goal.action=="turnin" then
			step_has_quests = true
		end				
	end
	if gossip_target and not step_has_quests then
		local goalstable = ZGV.Sync:GetStepSource(ZGV.CurrentStepNum,"nomap")

		Miner.CurrentStepData = {
			num = ZGV.CurrentStep.num, 
			goals = table.concat(goalstable,"\n"),
			npc = gossip_target,
		}
	else
		table.wipe(Miner.CurrentStepData)
	end
end

function Miner:GetGossips()
	if not Miner.CurrentStepData.npc then return end

	Miner.RecentOptions = C_GossipInfo.GetOptions()

	local unitguid = UnitGUID("npc")
	if ZGV.IsSecret(unitguid) then return end
	if not unitguid then return end

	local npctype,npcid = unitguid:match("(%w+)%-%d+%-%d+%-%d+%-%d+%-(%d+)")
	local npctype = npctype or "Unknown"
	Miner.RecentOptions.source = (UnitName("npc") or "???").."##"..(tonumber(npcid) or npctype)
	Miner.RecentOptions.sourceID = tonumber(npcid)
end

function Miner:GetSelectedOption(mode,param)
	if not Miner.CurrentStepData.npc then return end
	if Miner.RecentOptions.sourceID ~= Miner.CurrentStepData.npc then return end

	local selectedOption = false

	if mode=="id" then
		for i,v in pairs(Miner.RecentOptions) do
			if type(v)=="table" and v.gossipOptionID == param then
				selectedOption = v
				break
			end
		end

	elseif mode=="index" then
		for i,v in pairs(Miner.RecentOptions) do
			if type(v)=="table" and v.orderIndex == param then
				selectedOption = v
				break
			end
		end
	end

	if not selectedOption then
		return
	end

	local text = selectedOption.name:gsub("(Quest) ",""):gsub("(Delve) ","")
	local gossipGoal = gossipFormat:format(text,selectedOption.gossipOptionID)

	local playername = UnitName("player")
	local text = " " .. text .. " "
	local text = text:gsub("([^%w])" .. playername .. "([^%w])", "%1$NAME%2"):sub(2, -2)
	
	ZGV.Telemetry:AddEvent('GOSSIP_MINED',{
		guide = ZGV.CurrentGuide.title,
		file = ZGV.CurrentGuide.filepath,
		raceclass = minerraceclass,
		ver = ver,
		step = Miner.CurrentStepData.num,
		stepgoals = Miner.CurrentStepData.goals,
		gossip = gossipFormat:format(text,selectedOption.gossipOptionID),
		gossipIcon = selectedOption.icon,
		locale = GetLocale(),
	})
end

local valid_interactions = {
	[5] = "Merchant",
	[6] = "TaxiNode",
	[7] = "Trainer",
	[8] = "Banker",
	[12] = "Vendor",
	[15] = "TalentMaster",
	[16] = "SpecializationMaster",
	[17] = "MailInfo",
	[21] = "Auctioneer",
	[22] = "StableMaster",
	[23] = "BattleMaster",
	[24] = "Transmogrifier",
	[26] = "VoidStorageBanker",
	[27] = "BlackMarketAuctioneer",
	[59] = "Professions",
}
function Miner:GetInteraction(_,PlayerInteractionType)
	if not ZGV.DEV then return end
	if not valid_interactions[PlayerInteractionType] then return end
	local unitguid = UnitGUID("npc")
	local unitname = UnitName("npc")
	if ZGV.IsSecret(unitguid) then return end
	
	local mapid = C_Map.GetBestMapForUnit("player") or -1
	local coords = C_Map.GetPlayerMapPosition(mapid,"player")
	local x,y = coords and coords.x or 0,coords and coords.y or 0
	
	if x==0 and y==0 then return end

	ZGV.Telemetry:AddEvent('NPC_INTERACTION',{
		mapid = mapid,
		x = x,
		y = y,
		race = race,
		build = build,
		
		type = valid_interactions[PlayerInteractionType],
		unitname = unitname,
		unitid = tonumber(unitguid:match("[Creature|Pet]%-%d+%-%d+%-%d+%-%d+%-(%d+)")) or -1,
	})	
end


tinsert(ZGV.startups,{"Dataminer",function(self)
	Miner:Startup()
end})
