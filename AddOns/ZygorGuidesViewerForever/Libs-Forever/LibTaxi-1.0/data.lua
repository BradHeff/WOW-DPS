local name,addon = ...
local data={}
addon.LibTaxiData = data
data.taxipoints = {}



--------------------
---   KALIMDOR   ---
--------------------

data.taxipoints[1414]={
	
	["Ashenvale"] = {
		{name="Splintertree Post",faction="H",npc="Vhulgra",npcid=12616,x=73.18,y=61.59},
		{name="Zoram'gar Outpost",faction="H",npc="Andruk",npcid=11901,x=12.24,y=33.80},
		{name="Astranaar",faction="A",npc="Daelyshia",npcid=4267,x=34.41,y=47.99},
	},
	
	["Azshara"] = {
		{name="Talrendis Point",faction="A",npc="Jarrodenus",npcid=12577,x=11.90,y=77.59},
		{name="Valormok",faction="H",npc="Kroum",npcid=8610,x=21.96,y=49.62},
	},
	
	["Darkshore"] = {
		{name="Auberdine",faction="A",npc="Caylais Moonfeather",npcid=3841,x=36.34,y=45.58},
	},
	
	["Desolace"] = {
		{name="Shadowprey Village",faction="H",npc="Thalon",npcid=6726,x=21.60,y=74.13},
		{name="Nijel's Point",faction="A",npc="Baritanas Skyriver",npcid=6706,x=64.66,y=10.54},
	},
	
	["Dustwallow Marsh"] = {
		{name="Brackenwall Village",faction="H",npc="Shardi",npcid=11899,x=35.56,y=31.88},
		{name="Theramore",faction="A",npc="Baldruc",npcid=4321,x=67.48,y=51.30},
	},
	
	["Felwood"] = {
		{name="Bloodvenom Post",faction="H",npc="Brakkar",npcid=11900,x=34.44,y=53.96},
		{name="Talonbranch Glade",faction="A",npc="Mishellena",npcid=12578,x=62.49,y=24.24},
	},
	
	["Feralas"] = {
		{name="Camp Mojache",faction="H",npc="Shyn",npcid=8020,x=75.45,y=44.36},
		{name="Thalanaar",faction="A",npc="Thyssiana",npcid=4319,x=89.50,y=45.85},
		{name="Feathermoon",faction="A",npc="Fyldren Moonfeather",npcid=8019,x=30.24,y=43.25},
	},
	
	["Moonglade"] = {
		{name="Moonglade",faction="H",npc="Faustron",npcid=12740,x=32.09,y=66.61},
		{name="Moonglade",faction="A",npc="Sindrayl",npcid=10897,x=48.10,y=67.34},
	},
	
	["Orgrimmar"] = {
		{name="Orgrimmar",faction="H",npc="Doras",npcid=3310,x=45.12,y=63.89},
	},
	
	["Silithus"] = {
		{name="Cenarion Hold",faction="H",npc="Runk Windtamer",npcid=15178,x=48.68,y=36.67},
		{name="Cenarion Hold",faction="A",npc="Cloud Skydancer",npcid=15177,x=50.58,y=34.45},
	},
	
	["Stonetalon Mountains"] = {
		{name="Stonetalon Peak",faction="A",npc="Teloren",npcid=4407,x=36.44,y=7.18},
		{name="Sun Rock Retreat",faction="H",npc="Tharm",npcid=4312,x=45.12,y=59.84},
	},
	
	["Tanaris"] = {
		{name="Gadgetzan",faction="H",npc="Bulkrek Ragefist",npcid=7824,x=51.60,y=25.44},
		{name="Gadgetzan",faction="A",npc="Bera Stonehammer",npcid=7823,x=51.01,y=29.35},
	},
	
	["Teldrassil"] = {
		{name="Rut'theran Village",faction="A",npc="Vesprystus",npcid=3838,x=58.40,y=94.02,region="ruttheran"},
	},
	
	["The Barrens"] = {
		{name="Crossroads",faction="H",npc="Devrak",npcid=3615,x=51.51,y=30.36},
		{name="Camp Taurajo",faction="H",npc="Omusa Thunderhorn",npcid=10378,x=44.45,y=59.15},
		{name="Ratchet",faction="B",npc="Bragok",npcid=16227,x=63.08,y=37.16},
	},
	
	["Thousand Needles"] = {
		{name="Freewind Post",faction="H",npc="Nyse",npcid=4317,x=45.14,y=49.11},
	},
	
	["Thunder Bluff"] = {
		{name="Thunder Bluff",faction="H",npc="Tal",npcid=2995,x=46.99,y=49.83},
	},
	
	["Un'Goro Crater"] = {
		{name="Marshal's Refuge",faction="B",npc="Gryfe",npcid=10583,x=45.23,y=5.83},
	},
	
	["Winterspring"] = {
		{name="Everlook",faction="A",npc="Maethrya",npcid=11138,x=62.33,y=36.61},
		{name="Everlook",faction="H",npc="Yugrek",npcid=11139,x=60.47,y=36.30},
	},
	
	["Mount Hyjal"] = {
		{name="Summit of Eternity",npc="Fayran Elthas",npcid=41861,x=68.60,y=44.00},
		{name="Tainted Foothills",npc="Bluebell ",npcid=260626,x=55.00,y=82.80},
	
	},
}



----------------------------
---   EASTERN KINGDOMS   ---
----------------------------

data.taxipoints[1415]={
	
	["Arathi Highlands"] = {
		{name="Refuge Pointe",faction="A",npc="Cedrik Prose",npcid=2835,x=45.76,y=46.11},
		{name="Hammerfall",faction="H",npc="Urda",npcid=2851,x=73.06,y=32.68},
	},
	
	["Badlands"] = {
		{name="Kargath",faction="H",npc="Gorrik",npcid=2861,x=3.99,y=44.78},
	},
	
	["Blasted Lands"] = {
		{name="Nethergarde Keep",faction="A",npc="Alexandra Constantine",npcid=8609,x=65.54,y=24.34},
	},
	
	["Burning Steppes"] = {
		{name="Flame Crest",faction="H",npc="Vahgruk",npcid=13177,x=65.69,y=24.22},
		{name="Morgan's Vigil",faction="A",npc="Borgus Stoutarm",npcid=2299,x=84.33,y=68.33},
	},
	
	["Duskwood"] = {
		{name="Darkshire",faction="A",npc="Felicia Maline",npcid=2409,x=77.49,y=44.29},
	},
	
	["Eastern Plaguelands"] = {
		{name="Light's Hope Chapel",faction="A",npc="Khaelyn Steelwing",npcid=12617,x=81.64,y=59.28},
		{name="Light's Hope Chapel",faction="H",npc="Georgia",npcid=12636,x=80.22,y=57.01},
	},
	
	["Hillsbrad Foothills"] = {
		{name="Southshore",faction="A",npc="Darla Harris",npcid=2432,x=49.34,y=52.27},
		{name="Tarren Mill",faction="H",npc="Zarise",npcid=2389,x=60.14,y=18.62},
	},
	
	["Ironforge"] = {
		{name="Ironforge",faction="A",npc="Gryth Thurden",npcid=1573,x=55.50,y=47.74},
	},
	
	["Loch Modan"] = {
		{name="Thelsamar",faction="A",npc="Thorgrum Borrelson",npcid=1572,x=33.94,y=50.95},
	},
	
	["Redridge Mountains"] = {
		{name="Lakeshire",faction="A",npc="Ariena Stormfeather",npcid=931,x=25.51,y=59.41},
	},
	
	["Searing Gorge"] = {
		{name="Thorium Point",faction="H",npc="Grisha",npcid=3305,x=34.84,y=30.87},
		{name="Thorium Point",faction="A",npc="Lanie Reed",npcid=2941,x=37.94,y=30.86},
	},
	
	["Silverpine Forest"] = {
		{name="The Sepulcher",faction="H",npc="Karos Razok",npcid=2226,x=45.62,y=42.60},
	},
	
	["Stranglethorn Vale"] = {
		{name="Grom'gol",faction="H",npc="Thysta",npcid=1387,x=32.54,y=29.35},
		{name="Booty Bay",faction="H",npc="Gringer",npcid=2858,x=26.87,y=77.10},
		{name="Booty Bay",faction="A",npc="Gyll",npcid=2859,x=27.53,y=77.79},
	},
	
	["Swamp of Sorrows"] = {
		{name="Stonard",faction="H",npc="Breyk",npcid=6026,x=46.07,y=54.83},
	},
	
	["Stormwind City"] = {
		{name="Stormwind",faction="A",npc="Dungar Longdrink",npcid=352,x=71.29,y=72.22},
	},
	
	["The Hinterlands"] = {
		{name="Revantusk Village",faction="H",npc="Gorkas",npcid=4314,x=81.70,y=81.76},
		{name="Aerie Peak",faction="A",npc="Guthrum Thunderfist",npcid=8018,x=11.07,y=46.15},
	},
	
	["Undercity"] = {
		{name="Undercity",faction="H",npc="Michael Garrett",npcid=4551,x=63.25,y=48.56},
	},
	
	["Western Plaguelands"] = {
		{name="Chillwind Camp",faction="A",npc="Bibilfaz Featherwhistle",npcid=12596,x=42.92,y=85.06},
	},
	
	["Westfall"] = {
		{name="Sentinel Hill",faction="A",npc="Thor",npcid=523,x=56.55,y=52.64},
	},
	
	["Wetlands"] = {
		{name="Menethil Harbor",faction="A",npc="Shellei Brondir",npcid=1571,x=9.49,y=59.69},
	},
	
	["Riverglades"] = {
		{name="Farholde Keep",faction="A",npc="Gretchen Mayberry",npcid=257087,x=60.59,y=81.57},
		{name="Rog'mar",faction="H",npc="Grakna ",npcid=255993,x=59.60,y=45.00},
	},

}

-- NOTE: If two taxis have the same name but different factions then a factions field must be added in here. See Serpent's Spine.
-- If not then one of the taxis will be marked with the wrong faction so will not properly get neighbors that it should.
-- This data is regenerated when performing a Taxi Connections Dump. Any weird data edits may be lost. 
data.flightcost = {}
data.flightcost[1414]={
	{
		nodeID = 28,
		name = "Astranaar, Ashenvale",
		neighbors = {
			[26] = 148, -- Auberdine, Darkshore
			[33] = 154, -- Stonetalon Peak, Stonetalon Mountains
			[64] = 148, -- Talrendis Point, Azshara
		},
	},
	{
		nodeID = 26,
		name = "Auberdine, Darkshore",
		neighbors = {
			[27] = 84, -- Rut'theran Village, Teldrassil
			[28] = 177, -- Astranaar, Ashenvale
			[32] = 678, -- Theramore, Dustwallow Marsh
			[33] = 181, -- Stonetalon Peak, Stonetalon Mountains
			[37] = 292, -- Nijel's Point, Desolace
			[41] = 472, -- Feathermoon, Feralas
			[49] = 151, -- Moonglade
			[64] = 299, -- Talrendis Point, Azshara
			[65] = 190, -- Talonbranch Glade, Felwood
		},
	},
	{
		nodeID = 48,
		name = "Bloodvenom Post, Felwood",
		neighbors = {
			[23] = 259, -- Orgrimmar, Durotar
			[25] = 241, -- Crossroads, The Barrens
			[44] = 242, -- Valormok, Azshara
			[53] = 190, -- Everlook, Winterspring
			[69] = 166, -- Moonglade
		},
	},
	{
		nodeID = 55,
		name = "Brackenwall Village, Dustwallow Marsh",
		neighbors = {
			[22] = 226, -- Thunder Bluff, Mulgore
			[23] = 217, -- Orgrimmar, Durotar
			[25] = 162, -- Crossroads, The Barrens
			[40] = 223, -- Gadgetzan, Tanaris
		},
	},
	{
		nodeID = 42,
		name = "Camp Mojache, Feralas",
		neighbors = {
			[22] = 259, -- Thunder Bluff, Mulgore
			[25] = 266, -- Crossroads, The Barrens
			[30] = 107, -- Freewind Post, Thousand Needles
			[38] = 201, -- Shadowprey Village, Desolace
			[40] = 201, -- Gadgetzan, Tanaris
			[72] = 130, -- Cenarion Hold, Silithus
		},
	},
	{
		nodeID = 77,
		name = "Camp Taurajo, The Barrens",
		neighbors = {
			[22] = 115, -- Thunder Bluff, Mulgore
			[25] = 80, -- Crossroads, The Barrens
			[30] = 126, -- Freewind Post, Thousand Needles
		},
	},
	{
		nodeID = 73,
		name = "Cenarion Hold, Silithus",
		faction = "A",
		neighbors = {
			[39] = 190, -- Gadgetzan, Tanaris
			[41] = 176, -- Feathermoon, Feralas
			[79] = 92, -- Marshal's Refuge, Un'Goro Crater
		},
	},
	{
		nodeID = 72,
		name = "Cenarion Hold, Silithus",
		faction = "H",
		neighbors = {
			[40] = 242, -- Gadgetzan, Tanaris
			[42] = 130, -- Camp Mojache, Feralas
			[79] = 97, -- Marshal's Refuge, Un'Goro Crater
		},
	},
	{
		nodeID = 25,
		name = "Crossroads, The Barrens",
		neighbors = {
			[22] = 182, -- Thunder Bluff, Mulgore
			[23] = 142, -- Orgrimmar, Durotar
			[29] = 149, -- Sun Rock Retreat, Stonetalon Mountains
			[30] = 184, -- Freewind Post, Thousand Needles
			[40] = 305, -- Gadgetzan, Tanaris
			[42] = 253, -- Camp Mojache, Feralas
			[44] = 168, -- Valormok, Azshara
			[48] = 254, -- Bloodvenom Post, Felwood
			[55] = 163, -- Brackenwall Village, Dustwallow Marsh
			[58] = 230, -- Zoram'gar Outpost, Ashenvale
			[61] = 163, -- Splintertree Post, Ashenvale
			[77] = 92, -- Camp Taurajo, The Barrens
			[80] = 52, -- Ratchet, The Barrens
		},
	},
	{
		nodeID = 52,
		name = "Everlook, Winterspring",
		faction = "A",
		neighbors = {
			[49] = 122, -- Moonglade
			[64] = 176, -- Talrendis Point, Azshara
			[65] = 123, -- Talonbranch Glade, Felwood
			[3242] = 0, -- Tainted Foothills, Mount Hyjal
		},
	},
	{
		nodeID = 53,
		name = "Everlook, Winterspring",
		faction = "H",
		neighbors = {
			[23] = 306, -- Orgrimmar, Durotar
			[44] = 134, -- Valormok, Azshara
			[48] = 195, -- Bloodvenom Post, Felwood
			[69] = 134, -- Moonglade
			[3242] = 0, -- Tainted Foothills, Mount Hyjal
		},
	},
	{
		nodeID = 41,
		name = "Feathermoon, Feralas",
		neighbors = {
			[26] = 465, -- Auberdine, Darkshore
			[31] = 154, -- Thalanaar, Feralas
			[37] = 227, -- Nijel's Point, Desolace
			[73] = 160, -- Cenarion Hold, Silithus
		},
	},
	{
		nodeID = 30,
		name = "Freewind Post, Thousand Needles",
		neighbors = {
			[22] = 226, -- Thunder Bluff, Mulgore
			[25] = 194, -- Crossroads, The Barrens
			[40] = 93, -- Gadgetzan, Tanaris
			[42] = 123, -- Camp Mojache, Feralas
			[77] = 138, -- Camp Taurajo, The Barrens
		},
	},
	{
		nodeID = 39,
		name = "Gadgetzan, Tanaris",
		faction = "A",
		neighbors = {
			[31] = 177, -- Thalanaar, Feralas
			[32] = 153, -- Theramore, Dustwallow Marsh
			[73] = 198, -- Cenarion Hold, Silithus
			[79] = 103, -- Marshal's Refuge, Un'Goro Crater
		},
	},
	{
		nodeID = 40,
		name = "Gadgetzan, Tanaris",
		faction = "H",
		neighbors = {
			[22] = 304, -- Thunder Bluff, Mulgore
			[23] = 349, -- Orgrimmar, Durotar
			[25] = 302, -- Crossroads, The Barrens
			[30] = 87, -- Freewind Post, Thousand Needles
			[42] = 199, -- Camp Mojache, Feralas
			[55] = 222, -- Brackenwall Village, Dustwallow Marsh
			[72] = 233, -- Cenarion Hold, Silithus
			[79] = 107, -- Marshal's Refuge, Un'Goro Crater
		},
	},
	{
		nodeID = 79,
		name = "Marshal's Refuge, Un'Goro Crater",
		neighbors = {
			[39] = 103, -- Gadgetzan, Tanaris
			[40] = 113, -- Gadgetzan, Tanaris
			[72] = 101, -- Cenarion Hold, Silithus
			[73] = 95, -- Cenarion Hold, Silithus
		},
	},
	{
		nodeID = 49,
		name = "Moonglade",
		faction = "A",
		neighbors = {
			[26] = 142, -- Auberdine, Darkshore
			[52] = 130, -- Everlook, Winterspring
			[65] = 62, -- Talonbranch Glade, Felwood
		},
	},
	{
		nodeID = 69,
		name = "Moonglade",
		faction = "H",
		neighbors = {
			[48] = 158, -- Bloodvenom Post, Felwood
			[53] = 143, -- Everlook, Winterspring
		},
	},
	{
		nodeID = 37,
		name = "Nijel's Point, Desolace",
		neighbors = {
			[26] = 283, -- Auberdine, Darkshore
			[32] = 307, -- Theramore, Dustwallow Marsh
			[33] = 120, -- Stonetalon Peak, Stonetalon Mountains
			[41] = 233, -- Feathermoon, Feralas
		},
	},
	{
		nodeID = 23,
		name = "Orgrimmar, Durotar",
		neighbors = {
			[22] = 226, -- Thunder Bluff, Mulgore
			[25] = 110, -- Crossroads, The Barrens
			[40] = 416, -- Gadgetzan, Tanaris
			[44] = 99, -- Valormok, Azshara
			[48] = 253, -- Bloodvenom Post, Felwood
			[53] = 322, -- Everlook, Winterspring
			[55] = 229, -- Brackenwall Village, Dustwallow Marsh
			[61] = 90, -- Splintertree Post, Ashenvale
		},
	},
	{
		nodeID = 80,
		name = "Ratchet, The Barrens",
		neighbors = {
			[25] = 69, -- Crossroads, The Barrens
			[32] = 104, -- Theramore, Dustwallow Marsh
			[64] = 132, -- Talrendis Point, Azshara
		},
	},
	{
		nodeID = 27,
		name = "Rut'theran Village, Teldrassil",
		neighbors = {
			[26] = 85, -- Auberdine, Darkshore
		},
	},
	{
		nodeID = 38,
		name = "Shadowprey Village, Desolace",
		neighbors = {
			[22] = 179, -- Thunder Bluff, Mulgore
			[29] = 200, -- Sun Rock Retreat, Stonetalon Mountains
			[42] = 196, -- Camp Mojache, Feralas
		},
	},
	{
		nodeID = 61,
		name = "Splintertree Post, Ashenvale",
		neighbors = {
			[23] = 96, -- Orgrimmar, Durotar
			[25] = 160, -- Crossroads, The Barrens
			[44] = 96, -- Valormok, Azshara
			[58] = 167, -- Zoram'gar Outpost, Ashenvale
		},
	},
	{
		nodeID = 33,
		name = "Stonetalon Peak, Stonetalon Mountains",
		neighbors = {
			[26] = 176, -- Auberdine, Darkshore
			[28] = 155, -- Astranaar, Ashenvale
			[37] = 128, -- Nijel's Point, Desolace
		},
	},
	{
		nodeID = 559,
		name = "Summit of Eternity, Mount Hyjal",
		neighbors = {
			[3242] = 1, -- Tainted Foothills, Mount Hyjal
		},
	},
	{
		nodeID = 29,
		name = "Sun Rock Retreat, Stonetalon Mountains",
		neighbors = {
			[22] = 174, -- Thunder Bluff, Mulgore
			[25] = 149, -- Crossroads, The Barrens
			[38] = 144, -- Shadowprey Village, Desolace
		},
	},
	{
		nodeID = 3242,
		name = "Tainted Foothills, Mount Hyjal",
		neighbors = {
			[52] = 1, -- Everlook, Winterspring
			[53] = 1, -- Everlook, Winterspring
			[559] = 1, -- Summit of Eternity, Mount Hyjal
		},
	},
	{
		nodeID = 65,
		name = "Talonbranch Glade, Felwood",
		neighbors = {
			[26] = 189, -- Auberdine, Darkshore
			[49] = 68, -- Moonglade
			[52] = 121, -- Everlook, Winterspring
			[64] = 284, -- Talrendis Point, Azshara
		},
	},
	{
		nodeID = 64,
		name = "Talrendis Point, Azshara",
		neighbors = {
			[26] = 301, -- Auberdine, Darkshore
			[28] = 153, -- Astranaar, Ashenvale
			[32] = 242, -- Theramore, Dustwallow Marsh
			[52] = 179, -- Everlook, Winterspring
			[65] = 285, -- Talonbranch Glade, Felwood
			[80] = 135, -- Ratchet, The Barrens
		},
	},
	{
		nodeID = 31,
		name = "Thalanaar, Feralas",
		neighbors = {
			[32] = 159, -- Theramore, Dustwallow Marsh
			[39] = 171, -- Gadgetzan, Tanaris
			[41] = 178, -- Feathermoon, Feralas
		},
	},
	{
		nodeID = 32,
		name = "Theramore, Dustwallow Marsh",
		neighbors = {
			[26] = 619, -- Auberdine, Darkshore
			[31] = 164, -- Thalanaar, Feralas
			[37] = 333, -- Nijel's Point, Desolace
			[39] = 156, -- Gadgetzan, Tanaris
			[64] = 235, -- Talrendis Point, Azshara
			[80] = 115, -- Ratchet, The Barrens
		},
	},
	{
		nodeID = 22,
		name = "Thunder Bluff, Mulgore",
		neighbors = {
			[23] = 210, -- Orgrimmar, Durotar
			[25] = 159, -- Crossroads, The Barrens
			[29] = 182, -- Sun Rock Retreat, Stonetalon Mountains
			[30] = 204, -- Freewind Post, Thousand Needles
			[38] = 159, -- Shadowprey Village, Desolace
			[40] = 290, -- Gadgetzan, Tanaris
			[42] = 252, -- Camp Mojache, Feralas
			[44] = 269, -- Valormok, Azshara
			[55] = 240, -- Brackenwall Village, Dustwallow Marsh
			[77] = 87, -- Camp Taurajo, The Barrens
		},
	},
	{
		nodeID = 44,
		name = "Valormok, Azshara",
		neighbors = {
			[22] = 256, -- Thunder Bluff, Mulgore
			[23] = 121, -- Orgrimmar, Durotar
			[25] = 172, -- Crossroads, The Barrens
			[48] = 233, -- Bloodvenom Post, Felwood
			[53] = 130, -- Everlook, Winterspring
			[61] = 93, -- Splintertree Post, Ashenvale
		},
	},
	{
		nodeID = 58,
		name = "Zoram'gar Outpost, Ashenvale",
		neighbors = {
			[25] = 228, -- Crossroads, The Barrens
			[61] = 168, -- Splintertree Post, Ashenvale
		},
	},
}

data.flightcost[1415]={
	{
		nodeID = 43,
		name = "Aerie Peak, The Hinterlands",
		neighbors = {
			[6] = 256, -- Ironforge, Dun Morogh
			[14] = 68, -- Southshore, Hillsbrad
			[16] = 76, -- Refuge Pointe, Arathi
			[66] = 53, -- Chillwind Camp, Western Plaguelands
			[67] = 164, -- Light's Hope Chapel, Eastern Plaguelands
		},
	},
	{
		nodeID = 19,
		name = "Booty Bay, Stranglethorn",
		faction = "A",
		neighbors = {
			[2] = 219, -- Stormwind, Elwynn
			[4] = 182, -- Sentinel Hill, Westfall
			[12] = 176, -- Darkshire, Duskwood
		},
	},
	{
		nodeID = 18,
		name = "Booty Bay, Stranglethorn",
		faction = "H",
		neighbors = {
			[20] = 102, -- Grom'gol, Stranglethorn
			[21] = 411, -- Kargath, Badlands
			[56] = 266, -- Stonard, Swamp of Sorrows
		},
	},
	{
		nodeID = 66,
		name = "Chillwind Camp, Western Plaguelands",
		neighbors = {
			[6] = 261, -- Ironforge, Dun Morogh
			[14] = 86, -- Southshore, Hillsbrad
			[43] = 66, -- Aerie Peak, The Hinterlands
			[67] = 146, -- Light's Hope Chapel, Eastern Plaguelands
		},
	},
	{
		nodeID = 12,
		name = "Darkshire, Duskwood",
		neighbors = {
			[2] = 88, -- Stormwind, Elwynn
			[4] = 93, -- Sentinel Hill, Westfall
			[5] = 59, -- Lakeshire, Redridge
			[19] = 171, -- Booty Bay, Stranglethorn
			[45] = 97, -- Nethergarde Keep, Blasted Lands
		},
	},
	{
		nodeID = 3276,
		name = "Farholde Keep, Riverglades",
		neighbors = {
			[5] = 1, -- Lakeshire, Redridge
			[8] = 1, -- Thelsamar, Loch Modan
			[71] = 1, -- Morgan's Vigil, Burning Steppes
		},
	},
	{
		nodeID = 70,
		name = "Flame Crest, Burning Steppes",
		neighbors = {
			[21] = 101, -- Kargath, Badlands
			[56] = 213, -- Stonard, Swamp of Sorrows
			[75] = 73, -- Thorium Point, Searing Gorge
			[3203] = 0, -- Rog'mar, Riverglades
		},
	},
	{
		nodeID = 20,
		name = "Grom'gol, Stranglethorn",
		neighbors = {
			[18] = 81, -- Booty Bay, Stranglethorn
			[21] = 327, -- Kargath, Badlands
			[56] = 206, -- Stonard, Swamp of Sorrows
		},
	},
	{
		nodeID = 17,
		name = "Hammerfall, Arathi",
		neighbors = {
			[11] = 259, -- Undercity, Tirisfal
			[13] = 117, -- Tarren Mill, Hillsbrad
			[21] = 259, -- Kargath, Badlands
			[76] = 91, -- Revantusk Village, The Hinterlands
			[3203] = 0, -- Rog'mar, Riverglades
		},
	},
	{
		nodeID = 6,
		name = "Ironforge, Dun Morogh",
		neighbors = {
			[2] = 211, -- Stormwind, Elwynn
			[7] = 129, -- Menethil Harbor, Wetlands
			[8] = 102, -- Thelsamar, Loch Modan
			[14] = 265, -- Southshore, Hillsbrad
			[16] = 254, -- Refuge Pointe, Arathi
			[43] = 298, -- Aerie Peak, The Hinterlands
			[59] = 0, -- Dun Baldar, Alterac Valley
			[66] = 296, -- Chillwind Camp, Western Plaguelands
			[67] = 349, -- Light's Hope Chapel, Eastern Plaguelands
			[74] = 87, -- Thorium Point, Searing Gorge
		},
	},
	{
		nodeID = 21,
		name = "Kargath, Badlands",
		neighbors = {
			[11] = 498, -- Undercity, Tirisfal
			[17] = 263, -- Hammerfall, Arathi
			[18] = 417, -- Booty Bay, Stranglethorn
			[20] = 313, -- Grom'gol, Stranglethorn
			[56] = 282, -- Stonard, Swamp of Sorrows
			[70] = 87, -- Flame Crest, Burning Steppes
			[75] = 57, -- Thorium Point, Searing Gorge
			[3203] = 0, -- Rog'mar, Riverglades
		},
	},
	{
		nodeID = 5,
		name = "Lakeshire, Redridge",
		neighbors = {
			[2] = 113, -- Stormwind, Elwynn
			[4] = 133, -- Sentinel Hill, Westfall
			[12] = 60, -- Darkshire, Duskwood
			[71] = 61, -- Morgan's Vigil, Burning Steppes
			[3276] = 0, -- Farholde Keep, Riverglades
		},
	},
	{
		nodeID = 67,
		name = "Light's Hope Chapel, Eastern Plaguelands",
		faction = "A",
		neighbors = {
			[6] = 369, -- Ironforge, Dun Morogh
			[43] = 163, -- Aerie Peak, The Hinterlands
			[66] = 149, -- Chillwind Camp, Western Plaguelands
		},
	},
	{
		nodeID = 68,
		name = "Light's Hope Chapel, Eastern Plaguelands",
		faction = "H",
		neighbors = {
			[11] = 263, -- Undercity, Tirisfal
			[76] = 141, -- Revantusk Village, The Hinterlands
		},
	},
	{
		nodeID = 7,
		name = "Menethil Harbor, Wetlands",
		neighbors = {
			[6] = 89, -- Ironforge, Dun Morogh
			[8] = 163, -- Thelsamar, Loch Modan
			[14] = 107, -- Southshore, Hillsbrad
			[16] = 113, -- Refuge Pointe, Arathi
		},
	},
	{
		nodeID = 71,
		name = "Morgan's Vigil, Burning Steppes",
		neighbors = {
			[2] = 151, -- Stormwind, Elwynn
			[5] = 63, -- Lakeshire, Redridge
			[45] = 213, -- Nethergarde Keep, Blasted Lands
			[74] = 104, -- Thorium Point, Searing Gorge
			[3276] = 0, -- Farholde Keep, Riverglades
		},
	},
	{
		nodeID = 45,
		name = "Nethergarde Keep, Blasted Lands",
		neighbors = {
			[2] = 190, -- Stormwind, Elwynn
			[12] = 92, -- Darkshire, Duskwood
			[71] = 211, -- Morgan's Vigil, Burning Steppes
		},
	},
	{
		nodeID = 16,
		name = "Refuge Pointe, Arathi",
		neighbors = {
			[6] = 272, -- Ironforge, Dun Morogh
			[7] = 126, -- Menethil Harbor, Wetlands
			[8] = 170, -- Thelsamar, Loch Modan
			[14] = 87, -- Southshore, Hillsbrad
			[43] = 72, -- Aerie Peak, The Hinterlands
		},
	},
	{
		nodeID = 76,
		name = "Revantusk Village, The Hinterlands",
		neighbors = {
			[11] = 287, -- Undercity, Tirisfal
			[13] = 160, -- Tarren Mill, Hillsbrad
			[17] = 93, -- Hammerfall, Arathi
			[68] = 139, -- Light's Hope Chapel, Eastern Plaguelands
		},
	},
	{
		nodeID = 3203,
		name = "Rog'mar, Riverglades",
		neighbors = {
			[17] = 1, -- Hammerfall, Arathi
			[21] = 1, -- Kargath, Badlands
			[56] = 1, -- Stonard, Swamp of Sorrows
			[70] = 1, -- Flame Crest, Burning Steppes
		},
	},
	{
		nodeID = 4,
		name = "Sentinel Hill, Westfall",
		neighbors = {
			[2] = 86, -- Stormwind, Elwynn
			[5] = 129, -- Lakeshire, Redridge
			[12] = 96, -- Darkshire, Duskwood
			[19] = 185, -- Booty Bay, Stranglethorn
		},
	},
	{
		nodeID = 14,
		name = "Southshore, Hillsbrad",
		neighbors = {
			[6] = 207, -- Ironforge, Dun Morogh
			[7] = 110, -- Menethil Harbor, Wetlands
			[16] = 73, -- Refuge Pointe, Arathi
			[43] = 72, -- Aerie Peak, The Hinterlands
			[66] = 81, -- Chillwind Camp, Western Plaguelands
		},
	},
	{
		nodeID = 56,
		name = "Stonard, Swamp of Sorrows",
		neighbors = {
			[18] = 261, -- Booty Bay, Stranglethorn
			[20] = 189, -- Grom'gol, Stranglethorn
			[21] = 286, -- Kargath, Badlands
			[70] = 197, -- Flame Crest, Burning Steppes
			[3203] = 0, -- Rog'mar, Riverglades
		},
	},
	{
		nodeID = 2,
		name = "Stormwind, Elwynn",
		neighbors = {
			[4] = 78, -- Sentinel Hill, Westfall
			[5] = 112, -- Lakeshire, Redridge
			[6] = 259, -- Ironforge, Dun Morogh
			[12] = 116, -- Darkshire, Duskwood
			[19] = 244, -- Booty Bay, Stranglethorn
			[45] = 176, -- Nethergarde Keep, Blasted Lands
			[71] = 158, -- Morgan's Vigil, Burning Steppes
		},
	},
	{
		nodeID = 13,
		name = "Tarren Mill, Hillsbrad",
		neighbors = {
			[10] = 99, -- The Sepulcher, Silverpine Forest
			[11] = 140, -- Undercity, Tirisfal
			[17] = 118, -- Hammerfall, Arathi
			[76] = 197, -- Revantusk Village, The Hinterlands
		},
	},
	{
		nodeID = 10,
		name = "The Sepulcher, Silverpine Forest",
		neighbors = {
			[11] = 112, -- Undercity, Tirisfal
			[13] = 95, -- Tarren Mill, Hillsbrad
		},
	},
	{
		nodeID = 8,
		name = "Thelsamar, Loch Modan",
		neighbors = {
			[6] = 109, -- Ironforge, Dun Morogh
			[7] = 152, -- Menethil Harbor, Wetlands
			[16] = 163, -- Refuge Pointe, Arathi
			[3276] = 0, -- Farholde Keep, Riverglades
		},
	},
	{
		nodeID = 74,
		name = "Thorium Point, Searing Gorge",
		faction = "A",
		neighbors = {
			[6] = 94, -- Ironforge, Dun Morogh
			[71] = 96, -- Morgan's Vigil, Burning Steppes
		},
	},
	{
		nodeID = 75,
		name = "Thorium Point, Searing Gorge",
		faction = "H",
		neighbors = {
			[21] = 70, -- Kargath, Badlands
			[70] = 78, -- Flame Crest, Burning Steppes
		},
	},
	{
		nodeID = 11,
		name = "Undercity, Tirisfal",
		neighbors = {
			[10] = 106, -- The Sepulcher, Silverpine Forest
			[13] = 141, -- Tarren Mill, Hillsbrad
			[17] = 301, -- Hammerfall, Arathi
			[21] = 488, -- Kargath, Badlands
			[60] = 0, -- Frostwolf Keep, Alterac Valley
			[68] = 263, -- Light's Hope Chapel, Eastern Plaguelands
			[76] = 287, -- Revantusk Village, The Hinterlands
		},
	},
}