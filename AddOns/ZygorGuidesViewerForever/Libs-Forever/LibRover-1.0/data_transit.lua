local name,addon = ...

addon.LibRoverData = addon.LibRoverData or {}
local data=addon.LibRoverData

data.basenodes.transit = {






---------------------
----   PORTALS   ----
---------------------

	--## ALLIANCE ##--

		-- Rut'theran Village / Darnassus Pink Portal
			"Teldrassil 55.91,89.64 <region:ruttheran> -x- Darnassus 30.06,41.44 {fac:A} {mode:PORTAL} {title_atob:Enter the pink portal to Darnassus} {title_btoa:Enter the pink portal to Rut'theran Village}",



		-- Moonglade to Rut'theran Village Druid fake taxi
			"Moonglade 44.19,45.33 -to- Teldrassil 58.33,93.86 <region:ruttheran> {mode:PORTAL} {fac:A} {title:Take hippogryph to Rut'theran Village } {cost:145} {cond:ZGV:RaceClassMatch('DRUID')}",
				
				
				
		-- Dalaran -to- Stormwind City (Skyborne)
			"Alterac Mountains/0 12.04,56.21 -to- Stormwind City/0 49.87,86.67 {fac:A} {mode:PORTAL} "..
				"{title:Click the Skyborne Portal to Stormwind\nInside the Building} {cond:ZGV:RaceClassMatch('SKYBORNE')}",
				
				
				
		-- Stormwind City -to- Dalaran (Skyborne)
			"Stormwind City/0 50.04,86.97 -to- Alterac Mountains/0 12.12,56.55 {fac:A} {mode:PORTAL} "..
				"{title:Click the Skyborne Portal to Dalaran\nInside the Building} {cond:ZGV:RaceClassMatch('SKYBORNE')}",
				
				
				
				
				
			
	--## HORDE ##--

		-- Moonglade to Thunderbluff Druid fake taxi
			"Moonglade 44.27,45.77 -to- Thunder Bluff 46.70,49.92 {mode:PORTAL} {fac:H} {title:Take windrider to Thunder Bluff} {cost:515} {cond:ZGV:RaceClassMatch('DRUID')}",



-------------------------
-- BOATS AND ZEPPELINS --
-------------------------

	--## ALLIANCE ##--
		
		-- Stormwind City / Auberdine (Darkshore) Boat
			"Stormwind City/0 22.60,56.13 -x- Darkshore/0 30.76,41.00 {fac:A} {mode:SHIP} {title_atob:Ride the Boat to Auberdine} {title_btoa:Ride the Boat to Stormwind City}",
		
		
		
		-- Rut'theran Village (Teldrassil) / Auberdine (Darkshore) Boat
			"Teldrassil 54.86,96.79 <region:ruttheran> -x- Darkshore 33.19,40.13 {fac:A} {mode:SHIP} {title_atob:Ride the Boat to Auberdine} {title_btoa:Ride the Boat to Rut'theran Village}",

			
			
		-- Menethil Harbor (Wetlands) / Theramore Isle (Dustwallow Marsh) Boat
			"Wetlands 5.08,63.40 -x- Dustwallow Marsh 71.54,56.34 {fac:A} {mode:SHIP} {title_atob:Ride the Boat to Theramore Isle} {title_btoa:Ride the Boat to Menethil Harbor}",

		
		
		-- Auberdine (Darkshore) -to- Menethil Harbor (Wetlands) One-Way Boat
			"Darkshore/0 32.39,43.80 <radius:30> -to- Wetlands/0 4.65,57.16 <radius:30> {fac:A} {mode:SHIP} {title_atob:Ride the Boat to Menethil Harbor}",
			"Wetlands/0 1.58,40.32 <region:wetlands_boat_spawn> -to- Wetlands/0 4.65,57.16 <radius:100> {fac:A} {mode:SHIP} {title_atob:Ride the Boat to Menethil Harbor}" , -- segment after load screen
		
		
		-- Menethil Harbor (Wetlands) -to- Southshore (Hillsbrad Foothills) One-Way Boat
			"Wetlands/0 4.65,57.19 <radius:30> -to- Hillsbrad Foothills/0 50.60,69.71 <radius:30> {fac:A} {mode:SHIP} {title_atob:Ride the Boat to Southshore}",
			
			
			
		-- Southshore (Hillsbrad Foothills) -to- Auberdine (Darkshore) One-Way Boat
			"Hillsbrad Foothills/0 50.60,69.71 <radius:30> -to- Darkshore/0 32.39,43.80 <radius:30> {fac:A} {mode:SHIP} {title_atob:Ride the Boat to Auberdine}",



		-- DEEPRUN TRAM (Ironforge / Stormwind City)
			-- Stormwind - Elwyyn Forest, Eastern Kingdoms --
			--"Stormwind City/0 69.62,31.11 -x- Deeprun Tram/1 42.53,11.53 @deeprun_sw {mode:PORTAL} {title_atob:Enter the Deeprun Tram Portal\nand Ride the Tram to Ironforge} "..
			--	"{title_btoa:Enter Ironforge through the Portal}",

			-- Ironforge - Dun Morogh, Eastern Kingdoms --
			--"Ironforge/0 76.93,51.25 -x- Deeprun Tram/1 45.77,12.47 @deeprun_if {mode:PORTAL} {title_atob:Enter the Deeprun Tram Portal\nand Ride the Tram to Stormwind City} "..
			--	"{title_btoa:Ride the Tram to Ironforge\nand Enter Ironforge through the Portal}",
			"Stormwind City/0 60.36,12.47 -x- Ironforge 72.90,50.27 {fac:A} {mode:PORTAL} {cost:500} {title_atob:Ride the Deeprun Tram to Ironforge} {title_btoa:Ride the Deeprun Tram to Stormwind}",
			

			
		-- Valanaar (Zephras Isle) / Dalaran Airship
			"Zephras Isle/0 65.82,83.42 -x- Alterac Mountains/0 12.52,51.96 {fac:A} {mode:ZEPPELIN} "..
				"{title_atob:Ride the Airship to Dalaran} {title_btoa:Ride the Airship to Zephras Isle}",



	--## HORDE ##--

		-- Undercity (Tirisfal Glades) / Orgrimmar (Durotar) Zeppelin
			"Tirisfal Glades 60.70,58.76 -x- Durotar 50.82,13.81 {fac:H} {mode:ZEPPELIN} {title_atob:Ride the Zeppelin to Orgrimmar} {title_btoa:Ride the Zeppelin to Undercity}",

		-- Undercity (Tirisfal Glades) / Grom'gol Base Camp (Stranglethorn Vale) Zeppelin
			"Tirisfal Glades 61.88,59.10 -x- Stranglethorn Vale 31.53,29.15 {fac:H} {mode:ZEPPELIN} {title_atob:Ride the Zeppelin to Grom'gol Base Camp} {title_btoa:Ride the Zeppelin to Undercity}",

		-- Orgrimmar (Durotar) / Grom'gol Base Camp (Stranglethorn Vale) Zeppelin
			"Durotar 50.57,12.66 -x- Stranglethorn Vale 31.35,30.12 {fac:H} {mode:ZEPPELIN} {title_atob:Ride the Zeppelin to Grom'gol Base Camp} {title_btoa:Ride the Zeppelin to Orgrimmar}",
			
		-- Valanaar (Zephras Isle) / Skywatcher Plateau (Mulgore) Airship
			"Zephras Isle/0 57.94,80.72 -x- Mulgore/0 34.29,25.73 {fac:H} {mode:ZEPPELIN} "..
				"{title_atob:Ride the Airship to Mulgore} {title_btoa:Ride the Airship to Zephras Isle}",
	


	--## NEUTRAL ##--

		-- Booty Bay (Stranglethorn Vale) -x- Rachet (The Barrens) Boat
			"Stranglethorn Vale 25.92,73.15 -x- The Barrens 63.66,38.65 {fac:B} {mode:SHIP} {title_atob:Ride the Boat to Ratchet} {title_btoa:Ride the Boat to Booty Bay}",
			
		-- Powderfuse Port (Riverglades) -x- Steamwheedle Port (Tanaris) Boat
			"Riverglades/0 80.30,54.40 -x- Tanaris/0 68.34,22.98 {fac:B} {mode:SHIP} {title_atob:Ride the Boat to Steamwheedle Port} {title_btoa:Ride the Boat to Powderfuse Port}",



-------------
-- DALARAN -- 
-------------

			"Alterac Mountains/0 15.21,56.00 <region:dalaran_parlor> -x- Alterac Mountains/0 14.63,57.82 {mode:PORTAL}",
			"Alterac Mountains/0 18.08,71.87 -x- Alterac Mountains/0 18.06,72.03 <region:dalaran_underbelly>",




------------------
-- CLASS SPELLS --
------------------

	----------------
	---   MAGE   ---		-- NOTE: ACCOUNT FOR "Rune of Teleportation" REQUIRED TO CAST TELEPORT SPELLS
	----------------
	
	--## ALLIANCE ##--
		-- Teleport: Darnassus
			"Darnassus 40.13,81.83		<spell:3565>	<faction:A>",
		
		-- Teleport: Ironforge
			"Ironforge 25.52,8.41		<spell:3562>	<faction:A>",
		
		-- Teleport: Stormwind
			"Stormwind City 38.01,80.84	<spell:3561>	<faction:A>",



	--## HORDE ##--
		-- Teleport: Undercity
			"Undercity 84.65,16.32		<spell:3563>	<faction:H>",

		-- Teleport: Orgrimmar
			"Orgrimmar 38.57,85.95		<spell:3567>	<faction:H>",
		
		-- Teleport: Thunder Bluff
			"Thunder Bluff 22.35,16.52	<spell:3566>	<faction:H>",
		
	

	-----------------
	---   DRUID   ---
	-----------------
		-- Teleport: Moonglade
			"Moonglade 56.26,32.46		<spell:18960>",
	


	------------------
	---   SHAMAN   ---
	------------------

		-- NOTE: ADD "Astral Recall" SPELL, IF POSSIBLE.
}
