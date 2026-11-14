local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end

ZygorGuidesViewer.Skills.SkillTraining = {
	HUNTER = {
		[1] = {
			{1494,10, optional=true}, -- Track Beasts
		},
		[4] = {
			{1978,100, rank=1}, -- Serpent Sting Rank 1
			{13163,100, optional=true}, -- Aspect of the Monkey
		},
		[6] = {
			{1130,100, rank=1, optional=true}, -- Hunter's Mark Rank 1
			{3044,100, rank=1}, -- Arcane Shot Rank 1
		},
		[8] = {
			{3127,200, optional=true}, -- Parry (Passive)
			{5116,200, optional=true}, -- Concussive Shot
			{14260,200, req=2973, rank=2, optional=true}, -- Raptor Strike Rank 2
		},
		[10] = {
			{4187,10, pet=true, rank=1}, -- Great Stamina Rank 1
			{13165,400, rank=1}, -- Aspect of the Hawk Rank 1
			{13549,400, req=1978, rank=2}, -- Serpent Sting Rank 2
			{19883,400, optional=true}, -- Track Humanoids
			{24545,10, pet=true, rank=1}, -- Natural Armor Rank 1
			{14916,100, req=2649, pet=true, rank=2}, -- Growl rank 2
		},
		[12] = {
			{136,600, req=1515, rank=1}, -- Mend Pet Rank 1
			{2974,600, rank=1}, -- Wing Clip Rank 1
			{4188,120, req=4187, pet=true, rank=2}, -- Great Stamina Rank 2
			{14281,600, req=3044, rank=2}, -- Arcane Shot Rank 2
			{20736,600, rank=1, optional=true}, -- Distracting Shot Rank 1
			{24549,120, req=24545, pet=true, rank=2}, -- Natural Armor Rank 2
		},
		[14] = {
			{1002,1200, optional=true}, -- Eyes of the Beast
			{1513,1200, rank=1, optional=true}, -- Scare Beast Rank 1
			{6197,1200, optional=true}, -- Eagle Eye
		},
		[16] = {
			{1495,1500, rank=1, optional=true}, -- Mongoose Bite Rank 1
			{13795,1500, rank=1}, -- Immolation Trap Rank 1
			{14261,1500, req=14260, rank=3, optional=true}, -- Raptor Strike Rank 3
		},
		[18] = {
			{2643,1600}, -- Multi-Shot
			{4189,400, req=4188, pet=true, rank=3}, -- Great Stamina Rank 3
			{13550,1600, req=13549, rank=3}, -- Serpent Sting Rank 3
			{14318,1600, req=13165, rank=2}, -- Aspect of the Hawk Rank 2
			{19884,1600, optional=true}, -- Track Undead
			{24550,400, req=24549, pet=true, rank=3}, -- Natural Armor Rank 3
		},
		[20] = {
			{674,2100}, -- Dual Wield (Passive)
			{781,2100, rank=1, optional=true}, -- Disengage Rank 1
			{1499,2100, rank=1}, -- Freezing Trap Rank 1
			{3111,2100, req=136, rank=2}, -- Mend Pet Rank 2
			{5118,2100}, -- Aspect of the Cheetah
			{14274,2100, req=20736, rank=2, optional=true}, -- Distracting Shot Rank 2
			{14282,2100, req=14281, rank=3}, -- Arcane Shot Rank 3
			{14917,440, req=14916, pet=true, rank=3}, -- Growl Rank 3
			{23992,440, pet=true, rank=1}, -- Fire Resistance Rank 1
			{24446,440, pet=true, rank=1}, -- Frost Resistance Rank 1
			{24493,440, pet=true, rank=1, optional=true}, -- Arcane Resistance Rank 1
			{24488,40, pet=true, rank=1, optional=true}, -- Shadow Resistance Rank 1
			{24492,440, pet=true, rank=1, optional=true}, -- Nature Resistance Rank 1
		},
		[22] = {
			{3043,7000, optional=true}, -- Scorpid Sting
			{14323,7000, req=1130, rank=2, optional=true}, -- Hunter's Mark Rank 2
		},
		[24] = {
			{1462,7200, optional=true}, -- Beast Lore
			{4190,1260, req=4189, pet=true, rank=4}, -- Great Stamina Rank 4
			{14262,7200, req=14261, rank=4, optional=true}, -- Raptor Strike Rank 4
			{19885,7200, optional=true}, -- Track Hidden
			{24551,1260, req=24550, pet=true, rank=4}, -- Natural Armor Rank 4
		},
		[26] = {
			{3045,7400}, -- Rapid Fire
			{13551,7400, req=13550, rank=4}, -- Serpent Sting Rank 4
			{14302,7400, req=13795, rank=2}, -- Immolation Trap Rank 2
			{19880,7400, optional=true}, -- Track Elementals
		},
		[28] = {
			{3661,7500, req=3111, rank=3}, -- Mend Pet Rank 3
			{13809,7500, optional=true}, -- Frost Trap
			{14283,7500, req=14282, rank=4}, -- Arcane Shot Rank 4
			{14319,7500, req=14318, rank=3}, -- Aspect of the Hawk Rank 3
			{20900,7500, talent=19434, rank=2}, -- Aimed Shot Rank 2
		},
		[30] = {
			{4191,1440, req=4190, pet=true, rank=5}, -- Great Stamina Rank 5
			{5384,7600}, -- Feign Death
			{13161,7600, rank=1, optional=true}, -- Aspect of the Beast Rank 1
			{14269,7600, req=1495, rank=2, optional=true}, -- Mongoose Bite Rank 2
			{14326,7600, req=1513, rank=2, optional=true}, -- Scare Beast Rank 2
			{14918,1440, req=14917, pet=true, rank=4}, -- Growl Rank 4
			{15629,7600, req=14274, rank=3, optional=true}, -- Distracting Shot Rank 3
			{1242634,7600, talent=19306, rank=2}, -- Counterattack Rank 2
			{24439,1440, req=23992, pet=true, rank=2}, -- Fire Resistance Rank 2
			{24447,1440, req=24446, pet=true, rank=2}, -- Frost Resistance Rank 2
			{24497,1440, req=24493, pet=true, rank=2, optional=true}, -- Arcane Resistance Rank 2
			{24505,1440, req=24488, pet=true, rank=2, optional=true}, -- Shadow Resistance Rank 2
			{24502,1440, req=24492, pet=true, rank=2, optional=true}, -- Nature Resistance Rank 2
			{24552,1440, req=24551, pet=true, rank=5}, -- Natural Armor Rank 5
		},
		[32] = {
			{1543,10000, optional=true}, -- Flare
			{14263,10000, req=14262, rank=5, optional=true}, -- Raptor Strike Rank 5
			{19878,10000, optional=true}, -- Track Demons
			{1299348,10000, req=1299346, rank=2}, -- Trueshot Aura Rank 2
		},
		[34] = {
			{13552,11000, req=13551, rank=5}, -- Serpent Sting Rank 5
			{13813,11000, rank=1, optional=true}, -- Explosive Trap Rank 1
			{14272,11000, req=781, rank=2, optional=true}, -- Disengage Rank 2
		},
		[36] = {
			{3034,13000, rank=1, optional=true}, -- Viper Sting Rank 1
			{3662,13000, req=3661, rank=4}, -- Mend Pet Rank 4
			{14284,13000, req=14283, rank=5}, -- Arcane Shot Rank 5
			{14303,13000, req=14302, rank=3}, -- Immolation Trap Rank 3
			{20901,13000, req=20900, talent=19434, rank=3}, -- Aimed Shot Rank 3
			{1293525,13000, req=1293241, rank=2}, -- Summon Hawk Rank 2
		},
		[38] = {
			{14267,15000, req=2974, rank=2, optional=true}, -- Wing Clip Rank 2
			{14320,15000, req=14319, rank=4}, -- Aspect of the Hawk Rank 4
		},
		[40] = {
			{1510,16000, rank=1, optional=true}, -- Volley Rank 1
			{8737,16000}, -- Mail
			{13159,16000, optional=true}, -- Aspect of the Pack
			{14264,16000, req=14263, rank=6, optional=true}, -- Raptor Strike Rank 6
			{14310,16000, req=1499, rank=2}, -- Freezing Trap Rank 2
			{14324,16000, req=14323, rank=3, optional=true}, -- Hunter's Mark Rank 3
			{15630,16000, req=15629, rank=4, optional=true}, -- Distracting Shot Rank 4
			{19506,16000, req=1299348, talent=19506, rank=3}, -- Trueshot Aura Rank 3
			{19882,16000, optional=true}, -- Track Giants
			{1299445,16000, req=13161, rank=2}, -- Aspect of the Beast Rank 2
		},
		[42] = {
			{13553,22000, req=13552, rank=6}, -- Serpent Sting Rank 6
			{20909,22000, req=1242634, talent=19306, rank=3}, -- Counterattack Rank 3
		},
		[44] = {
			{13542,23000, req=3662, rank=5}, -- Mend Pet Rank 5
			{14270,23000, req=14269, rank=3, optional=true}, -- Mongoose Bite Rank 3
			{14285,23000, req=14284, rank=6}, -- Arcane Shot Rank 6
			{14316,23000, req=13813, rank=2, optional=true}, -- Explosive Trap Rank 2
			{20902,23000, req=20901, talent=19434, rank=4}, -- Aimed Shot Rank 4
		},
		[46] = {
			{14279,28000, req=3034, rank=2, optional=true}, -- Viper Sting Rank 2
			{14304,28000, req=14303, rank=4}, -- Immolation Trap Rank 4
			{14327,28000, req=14326, rank=3, optional=true}, -- Scare Beast Rank 3
			{20043,28000, rank=1, optional=true}, -- Aspect of the Wild Rank 1
		},
		[48] = {
			{14265,29000, req=14264, rank=7, optional=true}, -- Raptor Strike Rank 7
			{14273,29000, req=14272, rank=3, optional=true}, -- Disengage Rank 3
			{14321,29000, req=14320, rank=5}, -- Aspect of the Hawk Rank 5
			{1293526,29000, req=1293525, rank=3}, -- Summon Hawk Rank 3
			{1310785,29000, req=1310687, rank=2}, -- Sniper Shot Rank 2
		},
		[50] = {
			{13554,30000, req=13553, rank=7}, -- Serpent Sting Rank 7
			{14294,30000, req=1510, rank=2, optional=true}, -- Volley Rank 2
			{15631,30000, req=15630, rank=5, optional=true}, -- Distracting Shot Rank 5
			{19879,30000, optional=true}, -- Track Dragonkin
			{20905,30000, talent=19506, rank=4}, -- Trueshot Aura Rank 4
			{1299446,30000, req=1299445, rank=3}, -- Aspect of the Beast Rank 3
		},
		[52] = {
			{13543,36000, req=13542, rank=6}, -- Mend Pet Rank 6
			{14286,36000, req=14285, rank=7}, -- Arcane Shot Rank 7
			{20903,36000, req=20902, talent=19434, rank=5}, -- Aimed Shot Rank 5
		},
		[54] = {
			{14317,37000, req=14316, rank=3, optional=true}, -- Explosive Trap Rank 3
			{20910,37000, req=20909, talent=19306, rank=4}, -- Counterattack Rank 4
		},
		[56] = {
			{14266,38000, req=14265, rank=8, optional=true}, -- Raptor Strike Rank 8
			{14280,38000, req=14279, rank=3, optional=true}, -- Viper Sting Rank 3
			{14305,38000, req=14304, rank=5}, -- Immolation Trap Rank 5
			{20190,38000, req=20043, rank=2, optional=true}, -- Aspect of the Wild Rank 2
		},
		[58] = {
			{13555,39000, req=13554, rank=8}, -- Serpent Sting Rank 8
			{14271,39000, req=14270, rank=4, optional=true}, -- Mongoose Bite Rank 4
			{14295,39000, req=14294, rank=3, optional=true}, -- Volley Rank 3
			{14322,39000, req=14321, rank=6}, -- Aspect of the Hawk Rank 6
			{14325,39000, req=14324, rank=4, optional=true}, -- Hunter's Mark Rank 4
			{1310786,39000, req=1310785, rank=3}, -- Sniper Shot Rank 3
		},
		[60] = {
			{13544,42000, req=13543, rank=7}, -- Mend Pet Rank 7
			{14268,42000, req=14267, rank=3, optional=true}, -- Wing Clip Rank 3
			{14287,42000, req=14286, rank=8}, -- Arcane Shot Rank 8
			{14311,42000, req=14310, rank=3}, -- Freezing Trap Rank 3
			{15632,42000, req=15631, rank=6, optional=true}, -- Distracting Shot Rank 6
			{20904,42000, req=20903, talent=19434, rank=6}, -- Aimed Shot Rank 6
			{20906,42000, req=20905, talent=19506, rank=5}, -- Trueshot Aura Rank 5
			{1293527,42000, req=1293526, rank=4}, -- Summon Hawk Rank 4
			{1299447,39000, req=1299446, rank=4}, -- Aspect of the Beast Rank 4
		},
	},
	WARRIOR = {
		[1] = {
			{6673,10, rank=1}, -- Battle Shout Rank 1
		},
		[4] = {
			{100,100, rank=1}, -- Charge Rank 1
			{772,100}, -- Rend
		},
		[6] = {
			{3127,100}, -- Parry (Passive)
			{6343,100, rank=1}, -- Thunder Clap Rank 1
		},
		[8] = {
			{284,200, req=78, rank=2}, -- Heroic Strike Rank 2
			{1715,200, rank=1}, -- Hamstring Rank 1
		},
		[10] = {
			{2687,600}, -- Bloodrage
			{6546,600, req=772, rank=2}, -- Rend Rank 2
		},
		[12] = {
			{72,1000, rank=1}, -- Shield Bash Rank 1
			{5242,1000, req=6673, rank=2}, -- Battle Shout Rank 2
			{7384,1000, rank=1}, -- Overpower Rank 1
		},
		[14] = {
			{1160,1500, rank=1}, -- Demoralizing Shout Rank 1
			{6572,1500, req=71, rank=1}, -- Revenge Rank 1
			{1310185,1500}, -- Tactical Mastery
		},
		[16] = {
			{285,2000, req=284, rank=3}, -- Heroic Strike Rank 3
			{694,2000, rank=1}, -- Mocking Blow Rank 1
			{2565,2000, req=71, optional="not talentknown(12298)"}, -- Shield Block
		},
		[18] = {
			{676,3000, req=71, optional="not talentknown(12298)"}, -- Disarm
			{8198,3000, req=6343, rank=2, optional=true}, -- Thunder Clap Rank 2
		},
		[20] = {
			{674,4000}, -- Dual Wield (Passive)
			{845,4000, rank=1}, -- Cleave Rank 1
			{6547,4000, req=6546, rank=3}, -- Rend Rank 3
			{20230,4000}, -- Retaliation
			{402927,4000}, -- Victory Rush
			{1240193,4000, rank=1}, -- Slam Rank 1
		},
		[22] = {
			{5246,6000}, -- Intimidating Shout
			{6192,6000, req=5242, rank=3}, -- Battle Shout Rank 3
			{7405,6000, req=7386, rank=2, optional="not talentknown(12298)"}, -- Sunder Armor Rank 2
		},
		[24] = {
			{1608,8000, req=285, rank=4}, -- Heroic Strike Rank 4
			{5308,8000, rank=1}, -- Execute Rank 1
			{6190,8000, req=1160, rank=2, optional="not talentknown(12298)"}, -- Demoralizing Shout Rank 2
			{6574,8000, req=6572, rank=2, optional="not talentknown(12298)"}, -- Revenge Rank 2
		},
		[26] = {
			{1161,10000, optional="not talentknown(12298)"}, -- Challenging Shout
			{6178,10000, req=100, rank=2, optional=true}, -- Charge Rank 2
			{7400,10000, req=694, rank=2, optional=true}, -- Mocking Blow Rank 2
		},
		[28] = {
			{871,11000, req=71, optional="not talentknown(12298)"}, -- Shield Wall
			{7887,11000, req=7384, rank=2, optional=true}, -- Overpower Rank 2
			{8204,11000, req=8198, rank=3, optional=true}, -- Thunder Clap Rank 3
		},
		[30] = {
			{1464,12000, req=1240193, rank=2, optional=true}, -- Slam Rank 2
			{6548,12000, req=6547, rank=4}, -- Rend Rank 4
			{7369,12000, req=845, rank=2, optional=true}, -- Cleave Rank 2
			{18499,12000, req=2458}, -- Berserker Rage
		},
		[32] = {
			{1671,14000, req=72, rank=2, optional=true}, -- Shield Bash Rank 2
			{7372,14000, req=1715, rank=2, optional=true}, -- Hamstring Rank 2
			{11549,14000, req=6192, rank=4}, -- Battle Shout Rank 4
			{11564,14000, req=1608, rank=5, optional=true}, -- Heroic Strike Rank 5
			{20658,14000, req=5308, rank=2}, -- Execute Rank 2
		},
		[34] = {
			{7379,16000, req=6574, rank=3, optional="not talentknown(12298)"}, -- Revenge Rank 3
			{8380,16000, req=7405, rank=3, optional="not talentknown(12298)"}, -- Sunder Armor Rank 3
			{11554,16000, req=6190, rank=3, optional="not talentknown(12298)"}, -- Demoralizing Shout Rank 3
		},
		[36] = {
			{1680,18000, req=2458}, -- Whirlwind
			{7402,18000, req=7400, rank=3, optional=true}, -- Mocking Blow Rank 3
		},
		[38] = {
			{6552,20000, req=2458, rank=1}, -- Pummel Rank 1
			{8205,20000, req=8204, rank=4, optional=true}, -- Thunder Clap Rank 4
			{8820,20000, req=1464, rank=3, optional=true}, -- Slam Rank 3
		},
		[40] = {
			{750,22000}, -- Plate Mail
			{11565,22000, req=11564, rank=6, optional=true}, -- Heroic Strike Rank 6
			{11572,22000, req=6548, rank=5, optional=true}, -- Rend Rank 5
			{11608,22000, req=7369, rank=3, optional=true}, -- Cleave Rank 3
			{20660,22000, req=20658, rank=3}, -- Execute Rank 3
		},
		[42] = {
			{11550,32000, req=11549, rank=5}, -- Battle Shout Rank 5
			{20616,32000, req=20252, rank=2, optional=true}, -- Intercept Rank 2
		},
		[44] = {
			{11555,34000, req=11554, rank=4, optional="not talentknown(23922)"}, -- Demoralizing Shout Rank 4
			{11584,34000, req=7887, rank=3, optional=true}, -- Overpower Rank 3
			{11600,34000, req=7379, rank=4, optional="not talentknown(23922)"}, -- Revenge Rank 4
		},
		[46] = {
			{11578,36000, req=6178, rank=3, optional=true}, -- Charge Rank 3
			{11596,36000, req=8380, rank=4, optional="not talentknown(23922)"}, -- Sunder Armor Rank 4
			{11604,36000, req=8820, rank=4, optional=true}, -- Slam Rank 4
			{20559,36000, req=7402, rank=4, optional=true}, -- Mocking Blow Rank 4
		},
		[48] = {
			{11566,40000, req=11565, rank=7, optional=true}, -- Heroic Strike Rank 7
			{11580,40000, req=8205, rank=5, optional=true}, -- Thunder Clap Rank 5
			{20661,40000, req=20660, rank=4}, -- Execute Rank 4
			{21551,2000, talent=12294, rank=2}, -- Mortal Strike Rank 2
			{23892,2000, talent=23881, rank=2}, -- Bloodthirst Rank 2
			{23923,2000, talent=23922, rank=2}, -- Shield Slam Rank 2
		},
		[50] = {
			{1719,42000, req=2458}, -- Recklessness
			{11573,42000, req=11572, rank=6, optional=true}, -- Rend Rank 6
			{11609,42000, req=11608, rank=4, optional=true}, -- Cleave Rank 4
		},
		[52] = {
			{1672,54000, req=1671, rank=3, optional=true}, -- Shield Bash Rank 3
			{11551,54000, req=11550, rank=6}, -- Battle Shout Rank 6
			{20617,54000, req=20616, rank=3, optional=true}, -- Intercept Rank 3
		},
		[54] = {
			{7373,56000, req=7372, rank=3, optional=true}, -- Hamstring Rank 3
			{11556,56000, req=11555, rank=5, optional="not talentknown(23922)"}, -- Demoralizing Shout Rank 5
			{11601,56000, req=11600, rank=5, optional="not talentknown(23922)"}, -- Revenge Rank 5
			{11605,56000, req=11604, rank=5, optional=true}, -- Slam Rank 5
			{21552,2800, req=21551, talent=12294, rank=3}, -- Mortal Strike Rank 3
			{23893,2800, req=23892, talent=23881, rank=3}, -- Bloodthirst Rank 3
			{23924,2800, req=23923, talent=23922, rank=3}, -- Shield Slam Rank 3
		},
		[56] = {
			{11567,58000, req=11566, rank=8, optional=true}, -- Heroic Strike Rank 8
			{20560,58000, req=20559, rank=5, optional=true}, -- Mocking Blow Rank 5
			{20662,58000, req=20661, rank=5}, -- Execute Rank 5
		},
		[58] = {
			{6554,60000, req=6552, rank=2, optional=true}, -- Pummel Rank 2
			{11581,60000, req=11580, rank=6, optional=true}, -- Thunder Clap Rank 6
			{11597,60000, req=11596, rank=5, optional="not talentknown(23922)"}, -- Sunder Armor Rank 5
		},
		[60] = {
			{11574,62000, req=11573, rank=7, optional=true}, -- Rend Rank 7
			{11585,62000, req=11584, rank=4, optional=true}, -- Overpower Rank 4
			{20569,62000, req=11609, rank=5, optional=true}, -- Cleave Rank 5
			{21553,3100, req=21552, talent=12294, rank=4}, -- Mortal Strike Rank 4
			{23894,3100, req=23893, talent=23881, rank=4}, -- Bloodthirst Rank 4
			{23925,3100, req=23924, talent=23922, rank=4}, -- Shield Slam Rank 4
		},
	},
	PALADIN = {
		[1] = {
			{465,10, rank=1}, -- Devotion Aura Rank 1
		},
		[4] = {
			{19740,100, rank=1}, -- Blessing of Might Rank 1
			{20271,100}, -- Judgement
		},
		[6] = {
			{498,100, rank=1}, -- Divine Protection Rank 1
			{639,100, req=635, rank=2}, -- Holy Light Rank 2
			{679,100, rank=1}, -- Holy Strike Rank 1
			{21082,100, rank=1, optional=true}, -- Seal of the Crusader Rank 1
		},
		[8] = {
			{853,100, rank=1}, -- Hammer of Justice Rank 1
			{1152,100}, -- Purify
			{3127,100}, -- Parry (Passive)
		},
		[10] = {
			{633,300, rank=1}, -- Lay on Hands Rank 1
			{1022,300, rank=1}, -- Blessing of Protection Rank 1
			{10290,300, req=465, rank=2}, -- Devotion Aura Rank 2
			{20287,300, req=20154, rank=2}, -- Seal of Righteousness Rank 2
			{1311649,300, rank=1}, -- Seal of Fury Rank 1
		},
		[12] = {
			{678,1000, req=679, rank=2}, -- Holy Strike Rank 2
			{19834,1000, req=19740, rank=2}, -- Blessing of Might Rank 2
			{20162,1000, req=21082, rank=2, optional=true}, -- Seal of the Crusader Rank 2
		},
		[14] = {
			{647,2000, req=639, rank=3}, -- Holy Light Rank 3
			{19742,2000, rank=1}, -- Blessing of Wisdom Rank 1
		},
		[16] = {
			{7294,3000, rank=1, optional=true}, -- Retribution Aura Rank 1
			{25780,3000}, -- Righteous Fury
		},
		[18] = {
			{1044,3500}, -- Blessing of Freedom
			{5573,3500, req=498, rank=2}, -- Divine Protection Rank 2
			{20288,3500, req=20287, rank=3}, -- Seal of Righteousness Rank 3
			{1311656,3500, req=1311649, rank=2}, -- Seal of Fury Rank 2
		},
		[20] = {
			{643,4000, req=10290, rank=3}, -- Devotion Aura Rank 3
			{879,4000, rank=1, optional=true}, -- Exorcism Rank 1
			{1866,4000, req=678, rank=3}, -- Holy Strike Rank 3
			{19750,4000, rank=1}, -- Flash of Light Rank 1
			{20217,4000, talent=20217}, -- Blessing of Kings
			{26573,4000, talent=26573, rank=1}, -- Consecration Rank 1
		},
		[22] = {
			{1026,4000, req=647, rank=4}, -- Holy Light Rank 4
			{19746,4000}, -- Concentration Aura
			{19835,4000, req=19834, rank=3}, -- Blessing of Might Rank 3
			{20164,4000, optional=true}, -- Seal of Justice
			{20305,4000, req=20162, rank=3, optional=true}, -- Seal of the Crusader Rank 3
		},
		[24] = {
			{2878,5000, rank=1, optional=true}, -- Turn Undead Rank 1
			{5588,5000, req=853, rank=2}, -- Hammer of Justice Rank 2
			{5599,5000, req=1022, rank=2}, -- Blessing of Protection Rank 2
			{10322,5000, req=7328, rank=2, optional=true}, -- Redemption Rank 2
			{19850,5000, req=19742, rank=2}, -- Blessing of Wisdom Rank 2
		},
		[25] = {
			{20163,6000, req=1311656, rank=3}, -- Seal of Fury Rank 3
		},
		[26] = {
			{1038,6000, optional="not talentknown(20127)"}, -- Blessing of Salvation
			{10298,6000, req=7294, rank=2, optional=true}, -- Retribution Aura Rank 2
			{19939,6000, req=19750, rank=2}, -- Flash of Light Rank 2
			{20289,6000, req=20288, rank=4}, -- Seal of Righteousness Rank 4
		},
		[28] = {
			{680,9000, req=1866, rank=4}, -- Holy Strike Rank 4
			{5614,9000, req=879, rank=2, optional=true}, -- Exorcism Rank 2
			{19876,9000, rank=1, optional=true}, -- Shadow Resistance Aura Rank 1
		},
		[30] = {
			{1042,11000, req=1026, rank=5}, -- Holy Light Rank 5
			{2800,11000, req=633, rank=2, optional=true}, -- Lay on Hands Rank 2
			{10291,11000, req=643, rank=4}, -- Devotion Aura Rank 4
			{19752,11000, optional=true}, -- Divine Intervention
			{20116,11000, talent=26573, rank=2}, -- Consecration Rank 2
			{20165,11000, rank=1}, -- Seal of Light Rank 1
			{20915,550, talent=20375, rank=2}, -- Seal of Command Rank 2
		},
		[32] = {
			{19836,12000, req=19835, rank=4}, -- Blessing of Might Rank 4
			{19888,12000, rank=1, optional=true}, -- Frost Resistance Aura Rank 1
			{20306,12000, req=20305, rank=4, optional=true}, -- Seal of the Crusader Rank 4
		},
		[34] = {
			{642,13000, rank=1}, -- Divine Shield Rank 1
			{19852,13000, req=19850, rank=3}, -- Blessing of Wisdom Rank 3
			{19940,13000, req=19939, rank=3}, -- Flash of Light Rank 3
			{20290,13000, req=20289, rank=5}, -- Seal of Righteousness Rank 5
			{20419,13000, req=20163, rank=4}, -- Seal of Fury Rank 4
		},
		[36] = {
			{2495,14000, req=680, rank=5}, -- Holy Strike Rank 5
			{5615,14000, req=5614, rank=3, optional=true}, -- Exorcism Rank 3
			{10299,14000, req=10298, rank=3, optional=true}, -- Retribution Aura Rank 3
			{10324,14000, req=10322, rank=3, optional=true}, -- Redemption Rank 3
			{19891,14000, rank=1, optional=true}, -- Fire Resistance Aura Rank 1
		},
		[38] = {
			{3472,16000, req=1042, rank=6}, -- Holy Light Rank 6
			{5627,16000, req=2878, rank=2, optional=true}, -- Turn Undead Rank 2
			{10278,16000, req=5599, rank=3}, -- Blessing of Protection Rank 3
			{20166,16000, rank=1}, -- Seal of Wisdom Rank 1
		},
		[40] = {
			{750,20000}, -- Plate Mail
			{1032,20000, req=10291, rank=5}, -- Devotion Aura Rank 5
			{5589,20000, req=5588, rank=3}, -- Hammer of Justice Rank 3
			{19895,20000, req=19876, rank=2, optional=true}, -- Shadow Resistance Aura Rank 2
			{19977,20000, rank=1, optional=true}, -- Blessing of Light Rank 1
			{20347,20000, req=20165, rank=2}, -- Seal of Light Rank 2
			{20473,1000, req=1311606, rank=2}, -- Holy Shock Rank 2
			{20918,1000, req=20915, talent=20375, rank=3}, -- Seal of Command Rank 3
			{20922,20000, req=20116, talent=26573, rank=3}, -- Consecration Rank 3
		},
		[42] = {
			{4987,21000}, -- Cleanse
			{19837,21000, req=19836, rank=5}, -- Blessing of Might Rank 5
			{19941,21000, req=19940, rank=4}, -- Flash of Light Rank 4
			{20291,21000, req=20290, rank=6}, -- Seal of Righteousness Rank 6
			{20307,21000, req=20306, rank=5, optional=true}, -- Seal of the Crusader Rank 5
			{20421,21000, req=20419, rank=5}, -- Seal of Fury Rank 5
		},
		[44] = {
			{5569,22000, req=2495, rank=6}, -- Holy Strike Rank 6
			{10312,22000, req=5615, rank=4, optional=true}, -- Exorcism Rank 4
			{19853,22000, req=19852, rank=4}, -- Blessing of Wisdom Rank 4
			{19897,22000, req=19888, rank=2, optional=true}, -- Frost Resistance Aura Rank 2
			{24275,22000, rank=1}, -- Hammer of Wrath Rank 1
		},
		[46] = {
			{6940,24000, rank=1, optional=true}, -- Blessing of Sacrifice Rank 1
			{10300,24000, req=10299, rank=4, optional=true}, -- Retribution Aura Rank 4
			{10328,24000, req=3472, rank=7}, -- Holy Light Rank 7
		},
		[48] = {
			{19899,26000, req=19891, rank=2, optional=true}, -- Fire Resistance Aura Rank 2
			{20356,26000, req=20166, rank=2}, -- Seal of Wisdom Rank 2
			{20772,26000, req=10324, rank=4, optional=true}, -- Redemption Rank 4
			{20929,1300, talent=20473, rank=3}, -- Holy Shock Rank 3
		},
		[50] = {
			{1020,28000, req=642, rank=2}, -- Divine Shield Rank 2
			{2812,28000, rank=1, optional=true}, -- Holy Wrath Rank 1
			{10292,28000, req=1032, rank=6}, -- Devotion Aura Rank 6
			{10310,28000, req=2800, rank=3, optional=true}, -- Lay on Hands Rank 3
			{19942,28000, req=19941, rank=5}, -- Flash of Light Rank 5
			{19978,28000, req=19977, rank=2, optional=true}, -- Blessing of Light Rank 2
			{20292,28000, req=20291, rank=7}, -- Seal of Righteousness Rank 7
			{20348,28000, req=20347, rank=3}, -- Seal of Light Rank 3
			{20422,28000, req=20421, rank=6}, -- Seal of Fury Rank 6
			{20919,1400, req=20918, talent=20375, rank=4}, -- Seal of Command Rank 4
			{20923,28000, req=20922, talent=26573, rank=4}, -- Consecration Rank 4
			{20927,1400, talent=20925, rank=2}, -- Holy Shield Rank 2
			{1311590,1400, req=1310911, rank=2}, -- Light's Vigil Rank 2
		},
		[52] = {
			{10313,34000, req=10312, rank=5, optional=true}, -- Exorcism Rank 5
			{10326,34000, req=5627, rank=3, optional=true}, -- Turn Undead Rank 3
			{10332,34000, req=5569, rank=7}, -- Holy Strike Rank 7
			{19838,34000, req=19837, rank=6}, -- Blessing of Might Rank 6
			{19896,34000, req=19895, rank=3, optional=true}, -- Shadow Resistance Aura Rank 3
			{20308,34000, req=20307, rank=6, optional=true}, -- Seal of the Crusader Rank 6
			{24274,34000, req=24275, rank=2}, -- Hammer of Wrath Rank 2
			{25782,46000, req=19838, rank=1}, -- Greater Blessing of Might Rank 1
		},
		[54] = {
			{10308,40000, req=5589, rank=4}, -- Hammer of Justice Rank 4
			{10329,40000, req=10328, rank=8}, -- Holy Light Rank 8
			{19854,40000, req=19853, rank=5}, -- Blessing of Wisdom Rank 5
			{20729,40000, req=6940, rank=2, optional=true}, -- Blessing of Sacrifice Rank 2
			{25894,46000, req=19854, rank=1}, -- Greater Blessing of Wisdom Rank 1
		},
		[56] = {
			{10301,42000, req=10300, rank=5, optional=true}, -- Retribution Aura Rank 5
			{19898,42000, req=19897, rank=3, optional=true}, -- Frost Resistance Aura Rank 3
			{20930,2100, req=20929, talent=20473, rank=4}, -- Holy Shock Rank 4
		},
		[58] = {
			{19943,44000, req=19942, rank=6}, -- Flash of Light Rank 6
			{20293,44000, req=20292, rank=8}, -- Seal of Righteousness Rank 8
			{20357,44000, req=20356, rank=3}, -- Seal of Wisdom Rank 3
			{20423,44000, req=20422, rank=7}, -- Seal of Fury Rank 7
		},
		[60] = {
			{10293,46000, req=10292, rank=7}, -- Devotion Aura Rank 7
			{10314,46000, req=10313, rank=6, optional=true}, -- Exorcism Rank 6
			{10318,46000, req=2812, rank=2, optional=true}, -- Holy Wrath Rank 2
			{10333,46000, req=10332, rank=8}, -- Holy Strike Rank 8
			{19900,46000, req=19899, rank=3, optional=true}, -- Fire Resistance Aura Rank 3
			{19979,46000, req=19978, rank=3, optional=true}, -- Blessing of Light Rank 3
			{20349,46000, req=20348, rank=4}, -- Seal of Light Rank 4
			{20773,46000, req=20772, rank=5, optional=true}, -- Redemption Rank 5
			{20920,2300, req=20919, talent=20375, rank=5}, -- Seal of Command Rank 5
			{20924,46000, req=20923, talent=26573, rank=5}, -- Consecration Rank 5
			{20928,2300, req=20927, talent=20925, rank=3}, -- Holy Shield Rank 3
			{24239,46000, req=24274, rank=3}, -- Hammer of Wrath Rank 3
			{25890,46000, req=19979, optional=true}, -- Greater Blessing of Light
			{25895,46000, req=1038, optional="not talentknown(20127)"}, -- Greater Blessing of Salvation
			{25898,46000, req=20217}, -- Greater Blessing of Kings
			{25916,46000, req=25782, rank=2}, -- Greater Blessing of Might Rank 2
			{25918,46000, req=25894, rank=2}, -- Greater Blessing of Wisdom Rank 2
			{1311595,2300, req=1311590, rank=3}, -- Light's Vigil Rank 3
		},
	},
	MAGE = {
		[1] = {
			{1459,10, rank=1}, -- Arcane Intellect Rank 1
		},
		[4] = {
			{116,100, rank=1}, -- Frostbolt Rank 1
			{5504,100, rank=1}, -- Conjure Water Rank 1
		},
		[6] = {
			{143,100, req=133, rank=2}, -- Fireball Rank 2
			{587,100, rank=1}, -- Conjure Food Rank 1
			{2136,100, rank=1}, -- Fire Blast Rank 1
			{1296017,100}, -- Comprehend Scroll
		},
		[8] = {
			{118,200, rank=1}, -- Polymorph Rank 1
			{205,200, req=116, rank=2}, -- Frostbolt Rank 2
			{5143,200, rank=1}, -- Arcane Missiles Rank 1
		},
		[10] = {
			{122,400, rank=1}, -- Frost Nova Rank 1
			{5505,400, req=5504, rank=2}, -- Conjure Water Rank 2
			{7300,400, req=168, rank=2}, -- Frost Armor Rank 2
		},
		[12] = {
			{130,600}, -- Slow Fall
			{145,600, req=143, rank=3}, -- Fireball Rank 3
			{597,600, req=587, rank=2}, -- Conjure Food Rank 2
			{604,600, rank=1, optional=true}, -- Dampen Magic Rank 1
		},
		[14] = {
			{837,900, req=205, rank=3, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 3
			{1449,900, rank=1}, -- Arcane Explosion Rank 1
			{1460,900, req=1459, rank=2}, -- Arcane Intellect Rank 2
			{2137,900, req=2136, rank=2}, -- Fire Blast Rank 2
		},
		[16] = {
			{2120,1500, rank=1, optional=true}, -- Flamestrike Rank 1
			{5144,1500, req=5143, rank=2, optional="not talentknown(11237)"}, -- Arcane Missiles Rank 2
		},
		[18] = {
			{475,1800}, -- Remove Lesser Curse
			{1008,1800, rank=1, optional=true}, -- Amplify Magic Rank 1
			{3140,1800, req=145, rank=4, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 4
		},
		[20] = {
			{10,2000, rank=1, optional="not talentknown(11185)"}, -- Blizzard Rank 1
			{543,2000, rank=1, optional=true}, -- Fire Ward Rank 1
			{1463,2000, rank=1}, -- Mana Shield Rank 1
			{1953,2000}, -- Blink
			{5506,2000, req=5505, rank=3}, -- Conjure Water Rank 3
			{7301,2000, req=7300, rank=3}, -- Frost Armor Rank 3
			{7322,2000, req=837, rank=4, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 4
			{12051,2000}, -- Evocation
			{12824,2000, req=118, rank=2}, -- Polymorph Rank 2
		},
		[22] = {
			{990,3000, req=597, rank=3}, -- Conjure Food Rank 3
			{2138,3000, req=2137, rank=3}, -- Fire Blast Rank 3
			{2948,3000, rank=1, optional="not talentknown(11069)"}, -- Scorch Rank 1
			{6143,3000, rank=1, optional=true}, -- Frost Ward Rank 1
			{8437,3000, req=1449, rank=2, optional="not talentknown(11237)"}, -- Arcane Explosion Rank 2
		},
		[24] = {
			{2121,4000, req=2120, rank=2, optional=true}, -- Flamestrike Rank 2
			{2139,4000}, -- Counterspell
			{5145,4000, req=5144, rank=3, optional="not talentknown(11237)"}, -- Arcane Missiles Rank 3
			{8400,4000, req=3140, rank=5, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 5
			{8450,4000, req=604, rank=2, optional=true}, -- Dampen Magic Rank 2
			{12505,200, talent=11366, rank=2}, -- Pyroblast Rank 2
		},
		[26] = {
			{120,5000, rank=1, optional="not talentknown(11070)"}, -- Cone of Cold Rank 1
			{865,5000, req=122, rank=2, optional=true}, -- Frost Nova Rank 2
			{8406,5000, req=7322, rank=5, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 5
		},
		[28] = {
			{759,7000}, -- Conjure Mana Agate
			{1461,7000, req=1460, rank=3}, -- Arcane Intellect Rank 3
			{6141,7000, req=10, rank=2, optional="not talentknown(11185)"}, -- Blizzard Rank 2
			{8444,7000, req=2948, rank=2, optional="not talentknown(11069)"}, -- Scorch Rank 2
			{8494,7000, req=1463, rank=2}, -- Mana Shield Rank 2
			{400640,3000, req=1312002, rank=2}, -- Ice Lance Rank 2
		},
		[30] = {
			{6127,8000, req=5506, rank=4}, -- Conjure Water Rank 4
			{7302,8000, rank=1}, -- Ice Armor Rank 1
			{8401,8000, req=8400, rank=6, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 6
			{8412,8000, req=2138, rank=4}, -- Fire Blast Rank 4
			{8438,8000, req=8437, rank=3, optional="not talentknown(11237)"}, -- Arcane Explosion Rank 3
			{8455,8000, req=1008, rank=2, optional=true}, -- Amplify Magic Rank 2
			{8457,8000, req=543, rank=2, optional=true}, -- Fire Ward Rank 2
			{12522,400, req=12505, talent=11366, rank=3}, -- Pyroblast Rank 3
			{1239696,8000, req=400574, rank=2}, -- Arcane Blast Rank 2
		},
		[32] = {
			{6129,10000, req=990, rank=4}, -- Conjure Food Rank 4
			{8407,10000, req=8406, rank=6, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 6
			{8416,10000, req=5145, rank=4, optional="not talentknown(11237)"}, -- Arcane Missiles Rank 4
			{8422,10000, req=2121, rank=3, optional=true}, -- Flamestrike Rank 3
			{8461,10000, req=6143, rank=2, optional=true}, -- Frost Ward Rank 2
		},
		[34] = {
			{6117,12000, rank=1}, -- Mage Armor Rank 1
			{8445,12000, req=8444, rank=3, optional="not talentknown(11069)"}, -- Scorch Rank 3
			{8492,12000, req=120, rank=2, optional="not talentknown(11070)"}, -- Cone of Cold Rank 2
			{1240044,14500, req=400640, rank=3}, -- Ice Lance Rank 3
		},
		[36] = {
			{8402,13000, req=8401, rank=7, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 7
			{8427,13000, req=6141, rank=3, optional="not talentknown(11185)"}, -- Blizzard Rank 3
			{8451,13000, req=8450, rank=3, optional=true}, -- Dampen Magic Rank 3
			{8495,13000, req=8494, rank=3}, -- Mana Shield Rank 3
			{12523,650, req=12522, talent=11366, rank=4}, -- Pyroblast Rank 4
			{13018,650, talent=11113, rank=2}, -- Blast Wave Rank 2
		},
		[38] = {
			{3552,14000, req=759}, -- Conjure Mana Jade
			{8408,14000, req=8407, rank=7, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 7
			{8413,14000, req=8412, rank=5}, -- Fire Blast Rank 5
			{8439,14000, req=8438, rank=4, optional="not talentknown(11237)"}, -- Arcane Explosion Rank 4
		},
		[40] = {
			{6131,15000, req=865, rank=3, optional=true}, -- Frost Nova Rank 3
			{7320,15000, req=7302, rank=2}, -- Ice Armor Rank 2
			{8417,15000, req=8416, rank=5, optional="not talentknown(11237)"}, -- Arcane Missiles Rank 5
			{8423,15000, req=8422, rank=4, optional=true}, -- Flamestrike Rank 4
			{8446,15000, req=8445, rank=4, optional="not talentknown(11069)"}, -- Scorch Rank 4
			{8458,15000, req=8457, rank=3, optional=true}, -- Fire Ward Rank 3
			{10138,15000, req=6127, rank=5}, -- Conjure Water Rank 5
			{12825,15000, req=12824, rank=3}, -- Polymorph Rank 3
			{401502,15000, rank=1}, -- Frostfire Bolt Rank 1
			{1239697,15000, req=1239696, rank=3}, -- Arcane Blast Rank 3
		},
		[42] = {
			{8462,18000, req=8461, rank=3, optional=true}, -- Frost Ward Rank 3
			{10144,18000, req=6129, rank=5}, -- Conjure Food Rank 5
			{10148,18000, req=8402, rank=8, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 8
			{10156,18000, req=1461, rank=4}, -- Arcane Intellect Rank 4
			{10159,18000, req=8492, rank=3, optional="not talentknown(11070)"}, -- Cone of Cold Rank 3
			{10169,18000, req=8455, rank=3, optional=true}, -- Amplify Magic Rank 3
			{12524,900, req=12523, talent=11366, rank=5}, -- Pyroblast Rank 5
			{1240045,18000, req=1240044, rank=4}, -- Ice Lance Rank 4
		},
		[44] = {
			{10179,23000, req=8408, rank=8, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 8
			{10185,23000, req=8427, rank=4, optional="not talentknown(11185)"}, -- Blizzard Rank 4
			{10191,23000, req=8495, rank=4, optional="not talentknown(11426)"}, -- Mana Shield Rank 4
			{13019,1150, req=13018, talent=11113, rank=3}, -- Blast Wave Rank 3
		},
		[46] = {
			{10197,26000, req=8413, rank=6}, -- Fire Blast Rank 6
			{10201,26000, req=8439, rank=5, optional="not talentknown(11237)"}, -- Arcane Explosion Rank 5
			{10205,26000, req=8446, rank=5, optional="not talentknown(11069)"}, -- Scorch Rank 5
			{13031,1300, talent=11426, rank=2}, -- Ice Barrier Rank 2
			{22782,28000, req=6117, rank=2}, -- Mage Armor Rank 2
		},
		[48] = {
			{10053,28000, req=3552}, -- Conjure Mana Citrine
			{10149,28000, req=10148, rank=9, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 9
			{10173,28000, req=8451, rank=4, optional=true}, -- Dampen Magic Rank 4
			{10211,28000, req=8417, rank=6, optional="not talentknown(11237)"}, -- Arcane Missiles Rank 6
			{10215,28000, req=8423, rank=5, optional=true}, -- Flamestrike Rank 5
			{12525,1400, req=12524, talent=11366, rank=6}, -- Pyroblast Rank 6
			{1240046,32000, req=1240045, rank=5}, -- Ice Lance Rank 5
		},
		[50] = {
			{10139,32000, req=10138, rank=6}, -- Conjure Water Rank 6
			{10160,32000, req=10159, rank=4, optional="not talentknown(11070)"}, -- Cone of Cold Rank 4
			{10180,32000, req=10179, rank=9, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 9
			{10219,32000, req=7320, rank=3}, -- Ice Armor Rank 3
			{10223,32000, req=8458, rank=4, optional=true}, -- Fire Ward Rank 4
			{1237312,32000, req=401502, rank=2}, -- Frostfire Bolt Rank 2
			{1239699,32000, req=1239697, rank=4}, -- Arcane Blast Rank 4
		},
		[52] = {
			{10145,35000, req=10144, rank=6}, -- Conjure Food Rank 6
			{10177,35000, req=8462, rank=4, optional=true}, -- Frost Ward Rank 4
			{10186,35000, req=10185, rank=5, optional="not talentknown(11185)"}, -- Blizzard Rank 5
			{10192,35000, req=10191, rank=5, optional="not talentknown(11426)"}, -- Mana Shield Rank 5
			{10206,35000, req=10205, rank=6, optional="not talentknown(11069)"}, -- Scorch Rank 6
			{13020,1750, req=13019, talent=11113, rank=4}, -- Blast Wave Rank 4
			{13032,1750, req=13031, talent=11426, rank=3}, -- Ice Barrier Rank 3
		},
		[54] = {
			{10150,36000, req=10149, rank=10, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 10
			{10170,36000, req=10169, rank=4, optional=true}, -- Amplify Magic Rank 4
			{10199,36000, req=10197, rank=7}, -- Fire Blast Rank 7
			{10202,36000, req=10201, rank=6, optional="not talentknown(11237)"}, -- Arcane Explosion Rank 6
			{10230,36000, req=6131, rank=4, optional=true}, -- Frost Nova Rank 4
			{12526,1800, req=12525, talent=11366, rank=7}, -- Pyroblast Rank 7
		},
		[56] = {
			{10157,38000, req=10156, rank=5}, -- Arcane Intellect Rank 5
			{10181,38000, req=10180, rank=10, optional="not talentanyknown(11070,11237)"}, -- Frostbolt Rank 10
			{10212,38000, req=10211, rank=7, optional="not talentknown(11237)"}, -- Arcane Missiles Rank 7
			{10216,38000, req=10215, rank=6, optional=true}, -- Flamestrike Rank 6
			{1240047,40000, req=1240046, rank=6}, -- Ice Lance Rank 6
		},
		[58] = {
			{10054,40000, req=10053}, -- Conjure Mana Ruby
			{10161,40000, req=10160, rank=5, optional="not talentknown(11070)"}, -- Cone of Cold Rank 5
			{10207,40000, req=10206, rank=7, optional="not talentknown(11069)"}, -- Scorch Rank 7
			{13033,2000, req=13032, talent=11426, rank=4}, -- Ice Barrier Rank 4
			{22783,40000, req=22782, rank=3}, -- Mage Armor Rank 3
		},
		[60] = {
			{10151,42000, req=10150, rank=11, optional="not talentanyknown(11069,11237)"}, -- Fireball Rank 11
			{10174,42000, req=10173, rank=5, optional=true}, -- Dampen Magic Rank 5
			{10187,42000, req=10186, rank=6, optional="not talentknown(11185)"}, -- Blizzard Rank 6
			{10193,42000, req=10192, rank=6, optional="not talentknown(11426)"}, -- Mana Shield Rank 6
			{10220,42000, req=10219, rank=4}, -- Ice Armor Rank 4
			{10225,42000, req=10223, rank=5, optional=true}, -- Fire Ward Rank 5
			{12826,42000, req=12825, rank=4}, -- Polymorph Rank 4
			{13021,2100, req=13020, talent=11113, rank=5}, -- Blast Wave Rank 5
			{18809,2100, req=12526, talent=11366, rank=8}, -- Pyroblast Rank 8
			{1237313,42000, req=1237312, rank=3}, -- Frostfire Bolt Rank 3
			{1239700,42000, req=1239699, rank=5}, -- Arcane Blast Rank 5
		},
	},
	PRIEST = {
		[1] = {
			{1243,10, rank=1}, -- Power Word: Fortitude Rank 1
		},
		[4] = {
			{589,100, rank=1}, -- Shadow Word: Pain Rank 1
			{2052,100, req=2050, rank=2}, -- Lesser Heal Rank 2
		},
		[6] = {
			{17,100, rank=1}, -- Power Word: Shield Rank 1
			{591,100, req=585, rank=2, optional=true}, -- Smite Rank 2
		},
		[8] = {
			{139,200, rank=1}, -- Renew Rank 1
			{586,200, rank=1, optional=true}, -- Fade Rank 1
		},
		[10] = {
			{594,300, req=589, rank=2}, -- Shadow Word: Pain Rank 2
			{2006,300, rank=1}, -- Resurrection Rank 1
			{2053,300, req=2052, rank=3}, -- Lesser Heal Rank 3
			{8092,300, rank=1}, -- Mind Blast Rank 1
		},
		[12] = {
			{588,800, rank=1}, -- Inner Fire Rank 1
			{592,800, req=17, rank=2}, -- Power Word: Shield Rank 2
			{1244,800, req=1243, rank=2}, -- Power Word: Fortitude Rank 2
		},
		[14] = {
			{528,1200}, -- Cure Disease
			{598,1200, req=591, rank=3, optional=true}, -- Smite Rank 3
			{6074,1200, req=139, rank=2}, -- Renew Rank 2
			{8122,1200, rank=1}, -- Psychic Scream Rank 1
		},
		[16] = {
			{2054,1600, rank=1}, -- Heal Rank 1
			{8102,1600, req=8092, rank=2}, -- Mind Blast Rank 2
		},
		[18] = {
			{527,2000, rank=1, optional=true}, -- Dispel Magic Rank 1
			{600,2000, req=592, rank=3}, -- Power Word: Shield Rank 3
			{970,2000, req=594, rank=3}, -- Shadow Word: Pain Rank 3
			{1277371,100, req=1277370, rank=2}, -- Divine Grace Rank 2
		},
		[20] = {
			{453,3000, rank=1, optional=true}, -- Mind Soothe Rank 1
			{2061,3000, rank=1, optional=true}, -- Flash Heal Rank 1
			{2944,300, rank=1}, -- Devouring Plague Rank 1
			{6075,3000, req=6074, rank=3}, -- Renew Rank 3
			{6346,300}, -- Fear Ward
			{7128,3000, req=588, rank=2}, -- Inner Fire Rank 2
			{9484,3000, rank=1, optional=true}, -- Shackle Undead Rank 1
			{9578,3000, req=586, rank=2, optional=true}, -- Fade Rank 2
			{14914,3000, rank=1, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 1
		},
		[22] = {
			{984,4000, req=598, rank=4, optional=true}, -- Smite Rank 4
			{2010,4000, req=2006, rank=2, optional=true}, -- Resurrection Rank 2
			{2055,4000, req=2054, rank=2}, -- Heal Rank 2
			{2096,4000, rank=1, optional=true}, -- Mind Vision Rank 1
			{8103,4000, req=8102, rank=3}, -- Mind Blast Rank 3
		},
		[24] = {
			{1245,5000, req=1244, rank=3}, -- Power Word: Fortitude Rank 3
			{3747,5000, req=600, rank=4}, -- Power Word: Shield Rank 4
			{8129,5000, rank=1, optional=true}, -- Mana Burn Rank 1
			{15262,5000, req=14914, rank=2, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 2
		},
		[26] = {
			{992,6000, req=970, rank=4}, -- Shadow Word: Pain Rank 4
			{6076,6000, req=6075, rank=4}, -- Renew Rank 4
			{9472,6000, req=2061, rank=2, optional=true}, -- Flash Heal Rank 2
			{1277372,300, req=1277371, rank=3}, -- Divine Grace Rank 3
		},
		[28] = {
			{6063,8000, req=2055, rank=3}, -- Heal Rank 3
			{8104,8000, req=8103, rank=4}, -- Mind Blast Rank 4
			{8124,8000, req=8122, rank=2, optional=true}, -- Psychic Scream Rank 2
			{15430,400, talent=15237, rank=2}, -- Holy Nova Rank 2
			{17311,400, talent=15407, rank=2}, -- Mind Flay Rank 2
			{19276,400, req=2944, rank=2}, -- Devouring Plague Rank 2
		},
		[30] = {
			{596,10000, rank=1, optional=true}, -- Prayer of Healing Rank 1
			{602,10000, req=7128, rank=3}, -- Inner Fire Rank 3
			{605,10000, rank=1, optional=true}, -- Mind Control Rank 1
			{976,10000, rank=1, optional=true}, -- Shadow Protection Rank 1
			{1004,10000, req=984, rank=5, optional=true}, -- Smite Rank 5
			{6065,10000, req=3747, rank=5}, -- Power Word: Shield Rank 5
			{9579,10000, req=9578, rank=3, optional=true}, -- Fade Rank 3
			{14752,10000, talent=14752, rank=1}, -- Divine Spirit Rank 1
			{15263,10000, req=15262, rank=3, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 3
			{19271,500, req=13896, rank=2}, -- Feedback Rank 2
		},
		[32] = {
			{552,11000, optional=true}, -- Abolish Disease
			{6077,11000, req=6076, rank=5}, -- Renew Rank 5
			{8131,11000, req=8129, rank=2, optional=true}, -- Mana Burn Rank 2
			{9473,11000, req=9472, rank=3, optional=true}, -- Flash Heal Rank 3
			{1240770,11000, req=401937, rank=2}, -- Binding Heal Rank 2
			{1309595,11000, rank=1}, -- Shadow Word: Death Rank 1
		},
		[34] = {
			{1706,12000, optional=true}, -- Levitate
			{2767,12000, req=992, rank=5}, -- Shadow Word: Pain Rank 5
			{6064,12000, req=6063, rank=4}, -- Heal Rank 4
			{8105,12000, req=8104, rank=5}, -- Mind Blast Rank 5
			{10880,12000, req=2010, rank=3, optional=true}, -- Resurrection Rank 3
			{1277374,600, req=1277372, rank=4}, -- Divine Grace Rank 4
		},
		[36] = {
			{988,14000, req=527, rank=2, optional=true}, -- Dispel Magic Rank 2
			{2791,14000, req=1245, rank=4}, -- Power Word: Fortitude Rank 4
			{6066,14000, req=6065, rank=6}, -- Power Word: Shield Rank 6
			{8192,14000, req=453, rank=2, optional=true}, -- Mind Soothe Rank 2
			{15264,14000, req=15263, rank=4, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 4
			{15431,700, req=15430, talent=15237, rank=3}, -- Holy Nova Rank 3
			{17312,700, req=17311, talent=15407, rank=3}, -- Mind Flay Rank 3
			{19277,700, req=19276, rank=3}, -- Devouring Plague Rank 3
		},
		[38] = {
			{6060,16000, req=1004, rank=6, optional=true}, -- Smite Rank 6
			{6078,16000, req=6077, rank=6}, -- Renew Rank 6
			{9474,16000, req=9473, rank=4, optional=true}, -- Flash Heal Rank 4
			{1240771,16000, req=1240770, rank=3}, -- Binding Heal Rank 3
		},
		[40] = {
			{996,18000, req=596, rank=2, optional=true}, -- Prayer of Healing Rank 2
			{1006,18000, req=602, rank=4}, -- Inner Fire Rank 4
			{2060,18000, rank=1, optional=true}, -- Greater Heal Rank 1
			{8106,18000, req=8105, rank=6}, -- Mind Blast Rank 6
			{9485,18000, req=9484, rank=2, optional=true}, -- Shackle Undead Rank 2
			{9592,18000, req=9579, rank=4, optional=true}, -- Fade Rank 4
			{10874,18000, req=8131, rank=3, optional=true}, -- Mana Burn Rank 3
			{14818,900, talent=14752, rank=2}, -- Divine Spirit Rank 2
			{19273,900, req=19271, rank=3}, -- Feedback Rank 3
			{1240720,16000, talent=402174, rank=2}, -- Penance Rank 2
			{1309633,18000, req=1309595, rank=2}, -- Shadow Word: Death Rank 2
		},
		[42] = {
			{10888,22000, req=8124, rank=3, optional=true}, -- Psychic Scream Rank 3
			{10892,22000, req=2767, rank=6}, -- Shadow Word: Pain Rank 6
			{10898,22000, req=6066, rank=7}, -- Power Word: Shield Rank 7
			{10957,22000, req=976, rank=2, optional=true}, -- Shadow Protection Rank 2
			{15265,22000, req=15264, rank=5, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 5
			{1277376,1100, req=1277374, rank=5}, -- Divine Grace Rank 5
		},
		[44] = {
			{10909,24000, req=2096, rank=2, optional=true}, -- Mind Vision Rank 2
			{10911,24000, req=605, rank=2, optional=true}, -- Mind Control Rank 2
			{10915,24000, req=9474, rank=5, optional=true}, -- Flash Heal Rank 5
			{10927,24000, req=6078, rank=7}, -- Renew Rank 7
			{17313,1200, req=17312, talent=15407, rank=4}, -- Mind Flay Rank 4
			{19278,1200, req=19277, rank=4}, -- Devouring Plague Rank 4
			{27799,1200, req=15431, talent=15237, rank=4}, -- Holy Nova Rank 4
			{1240772,24000, req=1240771, rank=4}, -- Binding Heal Rank 4
		},
		[46] = {
			{10881,26000, req=10880, rank=4, optional=true}, -- Resurrection Rank 4
			{10933,26000, req=6060, rank=7, optional=true}, -- Smite Rank 7
			{10945,26000, req=8106, rank=7}, -- Mind Blast Rank 7
			{10963,26000, req=2060, rank=2, optional=true}, -- Greater Heal Rank 2
		},
		[48] = {
			{10875,28000, req=10874, rank=4, optional=true}, -- Mana Burn Rank 4
			{10899,28000, req=10898, rank=8}, -- Power Word: Shield Rank 8
			{10937,28000, req=2791, rank=5}, -- Power Word: Fortitude Rank 5
			{15266,28000, req=15265, rank=6, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 6
			{1309635,28000, req=1309633, rank=3}, -- Shadow Word: Death Rank 3
		},
		[50] = {
			{10893,30000, req=10892, rank=7}, -- Shadow Word: Pain Rank 7
			{10916,30000, req=10915, rank=6, optional=true}, -- Flash Heal Rank 6
			{10928,30000, req=10927, rank=8}, -- Renew Rank 8
			{10941,30000, req=9592, rank=5, optional=true}, -- Fade Rank 5
			{10951,30000, req=1006, rank=5}, -- Inner Fire Rank 5
			{10960,30000, req=996, rank=3, optional=true}, -- Prayer of Healing Rank 3
			{14819,1500, req=14818, talent=14752, rank=3}, -- Divine Spirit Rank 3
			{19274,1500, req=19273, rank=4}, -- Feedback Rank 4
			{1240721,30000, req=1240720, rank=3}, -- Penance Rank 3
			{1240773,30000, req=1240772, rank=5}, -- Binding Heal Rank 5
			{1240826,30000, req=401859, rank=2}, -- Prayer of Mending Rank 2
			{1277377,1500, req=1277376, rank=6}, -- Divine Grace Rank 6
		},
		[52] = {
			{10946,38000, req=10945, rank=8}, -- Mind Blast Rank 8
			{10953,38000, req=8192, rank=3, optional=true}, -- Mind Soothe Rank 3
			{10964,38000, req=10963, rank=3, optional=true}, -- Greater Heal Rank 3
			{17314,1900, req=17313, talent=15407, rank=5}, -- Mind Flay Rank 5
			{19279,1900, req=19278, rank=5}, -- Devouring Plague Rank 5
			{27800,1900, req=27799, talent=15237, rank=5}, -- Holy Nova Rank 5
		},
		[54] = {
			{10900,40000, req=10899, rank=9}, -- Power Word: Shield Rank 9
			{10934,40000, req=10933, rank=8, optional=true}, -- Smite Rank 8
			{15267,40000, req=15266, rank=7, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 7
		},
		[56] = {
			{10876,42000, req=10875, rank=5, optional=true}, -- Mana Burn Rank 5
			{10890,42000, req=10888, rank=4, optional=true}, -- Psychic Scream Rank 4
			{10917,42000, req=10916, rank=7, optional=true}, -- Flash Heal Rank 7
			{10929,42000, req=10928, rank=9}, -- Renew Rank 9
			{10958,42000, req=10957, rank=3, optional=true}, -- Shadow Protection Rank 3
			{1240774,42000, req=1240773, rank=6}, -- Binding Heal Rank 6
			{1309636,42000, req=1309635, rank=4}, -- Shadow Word: Death Rank 4
		},
		[58] = {
			{10894,44000, req=10893, rank=8}, -- Shadow Word: Pain Rank 8
			{10912,44000, req=10911, rank=3, optional=true}, -- Mind Control Rank 3
			{10947,44000, req=10946, rank=9}, -- Mind Blast Rank 9
			{10965,44000, req=10964, rank=4, optional=true}, -- Greater Heal Rank 4
			{20770,44000, req=10881, rank=5, optional=true}, -- Resurrection Rank 5
			{1277378,2200, req=1277377, rank=7}, -- Divine Grace Rank 7
		},
		[60] = {
			{10901,46000, req=10900, rank=10}, -- Power Word: Shield Rank 10
			{10938,46000, req=10937, rank=6}, -- Power Word: Fortitude Rank 6
			{10942,46000, req=10941, rank=6, optional=true}, -- Fade Rank 6
			{10952,46000, req=10951, rank=6}, -- Inner Fire Rank 6
			{10955,46000, req=9485, rank=3, optional=true}, -- Shackle Undead Rank 3
			{10961,46000, req=10960, rank=4, optional=true}, -- Prayer of Healing Rank 4
			{15261,46000, req=15267, rank=8, optional="talentanyknown(15268,15260)"}, -- Holy Fire Rank 8
			{18807,2300, req=17314, talent=15407, rank=6}, -- Mind Flay Rank 6
			{19275,2300, req=19274, rank=5}, -- Feedback Rank 5
			{19280,2300, req=19279, rank=6}, -- Devouring Plague Rank 6
			{27681,2300, req=27841, talent=14752, rank=1}, -- Prayer of Spirit Rank 1
			{27801,2300, req=27800, talent=15237, rank=6}, -- Holy Nova Rank 6
			{27841,2300, req=14819, talent=14752, rank=4}, -- Divine Spirit Rank 4
			{1240827,46000, req=1240826, rank=3}, -- Prayer of Mending Rank 3
			{1316995,46000, req=1240721, rank=4}, -- Penance Rank 4
		},
	},
	WARLOCK = {
		[1] = {
			{348,10, rank=1}, -- Immolate Rank 1
		},
		[4] = {
			{172,100, rank=1}, -- Corruption Rank 1
			{702,100, rank=1, optional=true}, -- Curse of Weakness Rank 1
		},
		[6] = {
			{695,100, req=686, rank=2}, -- Shadow Bolt Rank 2
			{1454,100, rank=1}, -- Life Tap Rank 1
		},
		[8] = {
			{980,200, rank=1}, -- Bane of Agony Rank 1
			{5782,200, rank=1}, -- Fear Rank 1
		},
		[10] = {
			{696,300, req=687, rank=2}, -- Demon Skin Rank 2
			{707,300, req=348, rank=2}, -- Immolate Rank 2
			{1120,300, rank=1}, -- Drain Soul Rank 1
			{6201,300, req=1120, rank=1}, -- Create Healthstone Rank 1
		},
		[12] = {
			{705,600, req=695, rank=3}, -- Shadow Bolt Rank 3
			{755,600, rank=1}, -- Health Funnel Rank 1
			{1108,600, req=702, rank=2, optional=true}, -- Curse of Weakness Rank 2
		},
		[14] = {
			{689,900, rank=1}, -- Drain Life Rank 1
			{704,900, rank=1, optional=true}, -- Curse of Recklessness Rank 1
			{6222,900, req=172, rank=2}, -- Corruption Rank 2
		},
		[16] = {
			{1455,1200, req=1454, rank=2}, -- Life Tap Rank 2
			{5697,1200}, -- Unending Breath
		},
		[18] = {
			{693,1500, req=1120, rank=1}, -- Create Soulstone Rank 1
			{1014,1500, req=980, rank=2}, -- Bane of Agony Rank 2
			{5676,1500, rank=1, optional=true}, -- Searing Pain Rank 1
		},
		[20] = {
			{698,2000, optional=true}, -- Ritual of Summoning
			{706,2000, rank=1}, -- Demon Armor Rank 1
			{1088,2000, req=705, rank=4}, -- Shadow Bolt Rank 4
			{1094,2000, req=707, rank=3}, -- Immolate Rank 3
			{3698,2000, req=755, rank=2}, -- Health Funnel Rank 2
			{5740,2000, rank=1, optional=true}, -- Rain of Fire Rank 1
			{440892,2000, rank=1}, -- Curse of the Elements Rank 1
		},
		[22] = {
			{126,2500, optional=true}, -- Eye of Kilrogg (Summon)
			{699,2500, req=689, rank=2}, -- Drain Life Rank 2
			{6202,2500, req=6201, rank=2}, -- Create Healthstone Rank 2
			{6205,2500, req=1108, rank=3, optional=true}, -- Curse of Weakness Rank 3
		},
		[24] = {
			{5138,3000, rank=1, optional=true}, -- Drain Mana Rank 1
			{5500,3000, optional=true}, -- Sense Demons
			{6223,3000, req=6222, rank=3}, -- Corruption Rank 3
			{8288,3000, req=1120, rank=2, optional=true}, -- Drain Soul Rank 2
			{18867,150, talent=17877, rank=2}, -- Shadowburn Rank 2
		},
		[26] = {
			{132,4000, rank=1, optional=true}, -- Detect Invisibility Rank 1
			{1456,4000, req=1455, rank=3}, -- Life Tap Rank 3
			{1714,4000, rank=1, optional=true}, -- Curse of Tongues Rank 1
			{17919,4000, req=5676, rank=2, optional=true}, -- Searing Pain Rank 2
		},
		[28] = {
			{710,5000, rank=1, optional=true}, -- Banish Rank 1
			{1106,5000, req=1088, rank=5}, -- Shadow Bolt Rank 5
			{3699,5000, req=3698, rank=3}, -- Health Funnel Rank 3
			{6217,5000, req=1014, rank=3}, -- Bane of Agony Rank 3
			{6366,5000, rank=1, optional=true}, -- Create Firestone Rank 1
			{7658,5000, req=704, rank=2, optional=true}, -- Curse of Recklessness Rank 2
		},
		[30] = {
			{709,6000, req=699, rank=3}, -- Drain Life Rank 3
			{1086,6000, req=706, rank=2}, -- Demon Armor Rank 2
			{1098,6000, rank=1, optional=true}, -- Subjugate Demon Rank 1
			{1949,6000, rank=1, optional=true}, -- Hellfire Rank 1
			{2941,6000, req=1094, rank=4}, -- Immolate Rank 4
			{20752,6000, req=693, rank=2, optional=true}, -- Create Soulstone Rank 2
			{1311676,6000, req=440892, rank=2}, -- Curse of the Elements Rank 2
		},
		[32] = {
			{6213,7000, req=5782, rank=2}, -- Fear Rank 2
			{6229,7000, rank=1, optional=true}, -- Shadow Ward Rank 1
			{7646,7000, req=6205, rank=4, optional=true}, -- Curse of Weakness Rank 4
			{18868,350, req=18867, talent=17877, rank=3}, -- Shadowburn Rank 3
			{1293818,300, talent=1293817, rank=2}, -- Conflagrate Rank 2
		},
		[34] = {
			{5699,8000, req=6202, rank=3}, -- Create Healthstone Rank 3
			{6219,8000, req=5740, rank=2, optional=true}, -- Rain of Fire Rank 2
			{6226,8000, req=5138, rank=2, optional=true}, -- Drain Mana Rank 2
			{7648,8000, req=6223, rank=4}, -- Corruption Rank 4
			{17920,8000, req=17919, rank=3, optional=true}, -- Searing Pain Rank 3
		},
		[36] = {
			{2362,9000, req=1120, rank=1, optional=true}, -- Create Spellstone Rank 1
			{3700,9000, req=3699, rank=4}, -- Health Funnel Rank 4
			{7641,9000, req=1106, rank=6}, -- Shadow Bolt Rank 6
			{11687,9000, req=1456, rank=4}, -- Life Tap Rank 4
			{17951,9000, req=6366, rank=2, optional=true}, -- Create Firestone Rank 2
		},
		[38] = {
			{2970,10000, req=132, rank=2, optional=true}, -- Detect Invisibility Rank 2
			{7651,10000, req=709, rank=4}, -- Drain Life Rank 4
			{8289,10000, req=8288, rank=3, optional=true}, -- Drain Soul Rank 3
			{11711,10000, req=6217, rank=4}, -- Bane of Agony Rank 4
			{18879,1000, talent=18265, rank=2}, -- Siphon Life Rank 2
		},
		[40] = {
			{5484,11000, rank=1, optional=true}, -- Howl of Terror Rank 1
			{11665,11000, req=2941, rank=5}, -- Immolate Rank 5
			{11733,11000, req=1086, rank=3}, -- Demon Armor Rank 3
			{17962,500, req=1293818, talent=17962, rank=3}, -- Conflagrate Rank 3
			{18869,550, req=18868, talent=17877, rank=4}, -- Shadowburn Rank 4
			{20755,11000, req=20752, rank=3, optional=true}, -- Create Soulstone Rank 3
			{1311677,11000, req=1311676, rank=3}, -- Curse of the Elements Rank 3
		},
		[42] = {
			{6789,11000, rank=1}, -- Death Coil Rank 1
			{7659,11000, req=7658, rank=3, optional=true}, -- Curse of Recklessness Rank 3
			{11683,11000, req=1949, rank=2, optional=true}, -- Hellfire Rank 2
			{11707,11000, req=7646, rank=5, optional=true}, -- Curse of Weakness Rank 5
			{11739,11000, req=6229, rank=2, optional=true}, -- Shadow Ward Rank 2
			{17921,11000, req=17920, rank=4, optional=true}, -- Searing Pain Rank 4
		},
		[44] = {
			{11659,12000, req=7641, rank=7}, -- Shadow Bolt Rank 7
			{11671,12000, req=7648, rank=5}, -- Corruption Rank 5
			{11693,12000, req=3700, rank=5}, -- Health Funnel Rank 5
			{11703,12000, req=6226, rank=3, optional=true}, -- Drain Mana Rank 3
			{11725,12000, req=1098, rank=2, optional=true}, -- Subjugate Demon Rank 2
		},
		[46] = {
			{11677,13000, req=6219, rank=3, optional=true}, -- Rain of Fire Rank 3
			{11688,13000, req=11687, rank=5}, -- Life Tap Rank 5
			{11699,13000, req=7651, rank=5}, -- Drain Life Rank 5
			{11729,13000, req=5699, rank=4}, -- Create Healthstone Rank 4
			{17952,13000, req=17951, rank=3, optional=true}, -- Create Firestone Rank 3
		},
		[48] = {
			{6353,14000, rank=1, optional=true}, -- Soul Fire Rank 1
			{11712,14000, req=11711, rank=5}, -- Bane of Agony Rank 5
			{17727,14000, req=2362, rank=2, optional=true}, -- Create Spellstone Rank 2
			{18647,14000, req=710, rank=2, optional=true}, -- Banish Rank 2
			{18870,700, req=18869, talent=17877, rank=5}, -- Shadowburn Rank 5
			{18880,1400, req=18879, talent=18265, rank=3}, -- Siphon Life Rank 3
			{18930,700, talent=17962, rank=4}, -- Conflagrate Rank 4
		},
		[50] = {
			{11667,15000, req=11665, rank=6}, -- Immolate Rank 6
			{11719,15000, req=1714, rank=2, optional=true}, -- Curse of Tongues Rank 2
			{11734,15000, req=11733, rank=4}, -- Demon Armor Rank 4
			{11743,15000, req=2970, rank=3, optional=true}, -- Detect Invisibility Rank 3
			{17922,15000, req=17921, rank=5, optional=true}, -- Searing Pain Rank 5
			{17925,15000, req=6789, rank=2}, -- Death Coil Rank 2
			{20756,15000, req=20755, rank=4, optional=true}, -- Create Soulstone Rank 4
			{1293812,900, req=412758, rank=2}, -- Incinerate Rank 2
			{1311680,15000, req=1311677, rank=4}, -- Curse of the Elements Rank 4
		},
		[52] = {
			{11660,18000, req=11659, rank=8}, -- Shadow Bolt Rank 8
			{11675,18000, req=8289, rank=4, optional=true}, -- Drain Soul Rank 4
			{11694,18000, req=11693, rank=6}, -- Health Funnel Rank 6
			{11708,18000, req=11707, rank=6, optional=true}, -- Curse of Weakness Rank 6
			{11740,18000, req=11739, rank=3, optional=true}, -- Shadow Ward Rank 3
		},
		[54] = {
			{11672,20000, req=11671, rank=6}, -- Corruption Rank 6
			{11684,20000, req=11683, rank=3, optional=true}, -- Hellfire Rank 3
			{11700,20000, req=11699, rank=6}, -- Drain Life Rank 6
			{11704,20000, req=11703, rank=4, optional=true}, -- Drain Mana Rank 4
			{17928,20000, req=5484, rank=2, optional=true}, -- Howl of Terror Rank 2
			{18931,1000, req=18930, talent=17962, rank=5}, -- Conflagrate Rank 5
		},
		[56] = {
			{6215,22000, req=6213, rank=3}, -- Fear Rank 3
			{11689,22000, req=11688, rank=6}, -- Life Tap Rank 6
			{11717,22000, req=7659, rank=4, optional=true}, -- Curse of Recklessness Rank 4
			{17924,22000, req=6353, rank=2, optional=true}, -- Soul Fire Rank 2
			{17953,22000, req=17952, rank=4, optional=true}, -- Create Firestone Rank 4
			{18871,1100, req=18870, talent=17877, rank=6}, -- Shadowburn Rank 6
		},
		[58] = {
			{11678,24000, req=11677, rank=4, optional=true}, -- Rain of Fire Rank 4
			{11713,24000, req=11712, rank=6}, -- Bane of Agony Rank 6
			{11726,24000, req=11725, rank=3, optional=true}, -- Subjugate Demon Rank 3
			{11730,24000, req=11729, rank=5}, -- Create Healthstone Rank 5
			{17923,24000, req=17922, rank=6, optional=true}, -- Searing Pain Rank 6
			{17926,24000, req=17925, rank=3}, -- Death Coil Rank 3
			{18881,2400, req=18880, talent=18265, rank=4}, -- Siphon Life Rank 4
		},
		[60] = {
			{603,26000, optional=true}, -- Bane of Doom
			{11661,26000, req=11660, rank=9}, -- Shadow Bolt Rank 9
			{11668,26000, req=11667, rank=7}, -- Immolate Rank 7
			{11695,26000, req=11694, rank=7}, -- Health Funnel Rank 7
			{11735,26000, req=11734, rank=5}, -- Demon Armor Rank 5
			{17728,26000, req=17727, rank=3, optional=true}, -- Create Spellstone Rank 3
			{18932,1300, req=18931, talent=17962, rank=6}, -- Conflagrate Rank 6
			{20757,26000, req=20756, rank=5, optional=true}, -- Create Soulstone Rank 5
			{1293813,1100, req=1293812, rank=3}, -- Incinerate Rank 3
		},
	},
	DRUID = {
		[1] = {
			{1126,10, rank=1}, -- Mark of the Wild Rank 1
		},
		[4] = {
			{774,100, rank=1}, -- Rejuvenation Rank 1
			{8921,100, rank=1}, -- Moonfire Rank 1
		},
		[6] = {
			{467,100, rank=1, optional=true}, -- Thorns Rank 1
			{5177,100, req=5176, rank=2}, -- Wrath Rank 2
		},
		[8] = {
			{339,200, rank=1}, -- Entangling Roots Rank 1
			{5186,200, req=5185, rank=2}, -- Healing Touch Rank 2
		},
		[10] = {
			{99,300, req=5487, rank=1}, -- Demoralizing Roar Rank 1
			{1058,300, req=774, rank=2}, -- Rejuvenation Rank 2
			{5232,300, req=1126, rank=2}, -- Mark of the Wild Rank 2
			{8924,300, req=8921, rank=2}, -- Moonfire Rank 2
			{16689,300, req=339, talent=16689, rank=1}, -- Nature's Grasp Rank 1
		},
		[12] = {
			{5229,800, req=5487, optional="not talentanyknown(16934,16858)"}, -- Enrage
			{8936,800, rank=1}, -- Regrowth Rank 1
			{437138,800, rank=1}, -- Revive Rank 1
		},
		[14] = {
			{782,900, req=467, rank=2, optional=true}, -- Thorns Rank 2
			{5178,900, req=5177, rank=3, optional="talentanyknown(16934,16858)"}, -- Wrath Rank 3
			{5187,900, req=5186, rank=3, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 3
			{5211,900, req=5487, rank=1, optional="not talentanyknown(16934,16858)"}, -- Bash Rank 1
		},
		[16] = {
			{779,1400, req=5487, rank=1, optional="not talentanyknown(16934,16858)"}, -- Swipe Rank 1
			{1430,1400, req=1058, rank=3}, -- Rejuvenation Rank 3
			{8925,1400, req=8924, rank=3, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 3
		},
		[18] = {
			{770,1500, rank=1, optional="talentanyknown(16934,16858)"}, -- Faerie Fire Rank 1
			{1062,1500, req=339, rank=2, optional="talentanyknown(16934,16858)"}, -- Entangling Roots Rank 2
			{2637,1500, rank=1, optional=true}, -- Hibernate Rank 1
			{6808,1500, req=6807, rank=2, optional="not talentanyknown(16934,16858)"}, -- Maul Rank 2
			{8938,1500, req=8936, rank=2}, -- Regrowth Rank 2
			{16810,1500, req=16689, talent=1062, rank=2}, -- Nature's Grasp Rank 2
		},
		[20] = {
			{1735,2400, req=99, rank=2, optional="not talentanyknown(16934,16858)"}, -- Demoralizing Roar Rank 2
			{2912,2400, rank=1, optional="talentanyknown(16934,16858)"}, -- Starfire Rank 1
			{5188,2400, req=5187, rank=4, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 4
			{6756,2400, req=5232, rank=3}, -- Mark of the Wild Rank 3
			{16864,2400, talent=16864}, -- Omen of Clarity
			{20484,2400, rank=1}, -- Rebirth Rank 1
		},
		[22] = {
			{2090,3300, req=1430, rank=4}, -- Rejuvenation Rank 4
			{2908,3300, rank=1, optional=true}, -- Soothe Animal Rank 1
			{5179,3300, req=5178, rank=4, optional="talentanyknown(16934,16858)"}, -- Wrath Rank 4
			{5221,3300, req=768, rank=1, optional="not talentanyknown(16934,16858)"}, -- Shred Rank 1
			{8926,3300, req=8925, rank=4, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 4
		},
		[24] = {
			{780,4300, req=779, rank=2, optional="not talentanyknown(16934,16858)"}, -- Swipe Rank 2
			{1075,4300, req=782, rank=3, optional=true}, -- Thorns Rank 3
			{1822,4300, req=768, rank=1, optional="not talentanyknown(16934,16858)"}, -- Rake Rank 1
			{2782,4300}, -- Remove Curse
			{8939,4300, req=8938, rank=3}, -- Regrowth Rank 3
			{1237948,4300, req=437138, rank=2}, -- Revive Rank 2
		},
		[26] = {
			{1850,4400, req=768, rank=1}, -- Dash Rank 1
			{2893,4400}, -- Abolish Poison
			{5189,4400, req=5188, rank=5, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 5
			{6809,4400, req=6808, rank=3, optional="not talentanyknown(16934,16858)"}, -- Maul Rank 3
			{8949,4400, req=2912, rank=2, optional="talentanyknown(16934,16858)"}, -- Starfire Rank 2
		},
		[28] = {
			{2091,4500, req=2090, rank=5}, -- Rejuvenation Rank 5
			{3029,4500, req=1082, rank=2, optional="not talentanyknown(16934,16858)"}, -- Claw Rank 2
			{5195,4500, req=1062, rank=3, optional="talentanyknown(16934,16858)"}, -- Entangling Roots Rank 3
			{5209,4500, req=5487, optional="not talentanyknown(16934,16858)"}, -- Challenging Roar
			{8927,4500, req=8926, rank=5, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 5
			{8998,4500, req=768, rank=1, optional=true}, -- Cower Rank 1
			{9492,4500, req=1079, rank=2, optional="not talentanyknown(16934,16858)"}, -- Rip Rank 2
			{16811,4500, req=16810, talent=5195, rank=3}, -- Nature's Grasp Rank 3
		},
		[30] = {
			{740,4600, rank=1, optional=true}, -- Tranquility Rank 1
			{778,4600, req=770, rank=2, optional="talentanyknown(16934,16858)"}, -- Faerie Fire Rank 2
			{783,4600}, -- Travel Form (Shapeshift)
			{5180,4600, req=5179, rank=5, optional="talentanyknown(16934,16858)"}, -- Wrath Rank 5
			{5234,4600, req=6756, rank=4}, -- Mark of the Wild Rank 4
			{6798,4600, req=5211, rank=2, optional="not talentanyknown(16934,16858)"}, -- Bash Rank 2
			{6800,4600, req=5221, rank=2, optional="not talentanyknown(16934,16858)"}, -- Shred Rank 2
			{8940,4600, req=8939, rank=4}, -- Regrowth Rank 4
			{20739,4600, req=20484, rank=2, optional=true}, -- Rebirth Rank 2
			{24974,4600, talent=5570, rank=2}, -- Insect Swarm Rank 2
		},
		[32] = {
			{5225,6000, req=768, optional=true}, -- Track Humanoids
			{6778,6000, req=5189, rank=6, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 6
			{6785,6000, req=768, rank=1, optional="not talentanyknown(16934,16858)"}, -- Ravage Rank 1
			{9490,6000, req=1735, rank=3, optional="not talentanyknown(16934,16858)"}, -- Demoralizing Roar Rank 3
			{22568,6000, req=768, rank=1, optional="not talentanyknown(16934,16858)"}, -- Ferocious Bite Rank 1
		},
		[34] = {
			{769,7000, req=780, rank=3, optional="not talentanyknown(16934,16858)"}, -- Swipe Rank 3
			{1823,7000, req=1822, rank=2, optional="not talentanyknown(16934,16858)"}, -- Rake Rank 2
			{3627,7000, req=2091, rank=6}, -- Rejuvenation Rank 6
			{8914,7000, req=1075, rank=4, optional=true}, -- Thorns Rank 4
			{8928,7000, req=8927, rank=6, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 6
			{8950,7000, req=8949, rank=3, optional="talentanyknown(16934,16858)"}, -- Starfire Rank 3
			{8972,7000, req=6809, rank=4, optional="not talentanyknown(16934,16858)"}, -- Maul Rank 4
		},
		[36] = {
			{8941,8000, req=8940, rank=5}, -- Regrowth Rank 5
			{9005,8000, req=768, rank=1, optional=true}, -- Pounce Rank 1
			{9493,8000, req=9492, rank=3, optional="not talentanyknown(16934,16858)"}, -- Rip Rank 3
			{22842,8000, req=5487, optional="not talentanyknown(16934,16858)"}, -- Frenzied Regeneration
			{1237949,8000, req=1237948, rank=3}, -- Revive Rank 3
			{1238069,8000, req=407995, rank=2}, -- Primal Bite Rank 2
		},
		[38] = {
			{5196,9000, req=5195, rank=4, optional="talentanyknown(16934,16858)"}, -- Entangling Roots Rank 4
			{5201,9000, req=3029, rank=3, optional="not talentanyknown(16934,16858)"}, -- Claw Rank 3
			{6780,9000, req=5180, rank=6, optional="talentanyknown(16934,16858)"}, -- Wrath Rank 6
			{8903,9000, req=6778, rank=7, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 7
			{8955,9000, req=2908, rank=2, optional=true}, -- Soothe Animal Rank 2
			{8992,9000, req=6800, rank=3, optional="not talentanyknown(16934,16858)"}, -- Shred Rank 3
			{16812,9000, req=16811, talent=5196, rank=4}, -- Nature's Grasp Rank 4
			{18657,9000, req=2637, rank=2, optional=true}, -- Hibernate Rank 2
		},
		[40] = {
			{6783,10000, req=5215, rank=2}, -- Prowl Rank 2
			{8907,10000, req=5234, rank=5}, -- Mark of the Wild Rank 5
			{8910,10000, req=3627, rank=7}, -- Rejuvenation Rank 7
			{8918,10000, req=740, rank=2, optional=true}, -- Tranquility Rank 2
			{8929,10000, req=8928, rank=7, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 7
			{9000,10000, req=8998, rank=2, optional=true}, -- Cower Rank 2
			{9634,10000, req=5487}, -- Dire Bear Form (Shapeshift)
			{16914,10000, rank=1, optional=true}, -- Hurricane Rank 1
			{20719,10000, req=768}, -- Feline Grace (Passive)
			{20742,10000, req=20739, rank=3, optional=true}, -- Rebirth Rank 3
			{22827,10000, req=22568, rank=2, optional="not talentanyknown(16934,16858)"}, -- Ferocious Bite Rank 2
			{24975,10000, req=24974, talent=5570, rank=3}, -- Insect Swarm Rank 3
			{29166,10000}, -- Innervate
		},
		[42] = {
			{6787,13000, req=6785, rank=2, optional="not talentanyknown(16934,16858)"}, -- Ravage Rank 2
			{8951,13000, req=8950, rank=4, optional="talentanyknown(16934,16858)"}, -- Starfire Rank 4
			{9745,13000, req=8972, rank=5, optional="not talentanyknown(16934,16858)"}, -- Maul Rank 5
			{9747,13000, req=9490, rank=4, optional="not talentanyknown(16934,16858)"}, -- Demoralizing Roar Rank 4
			{9749,13000, req=778, rank=3, optional="talentanyknown(16934,16858)"}, -- Faerie Fire Rank 3
			{9750,13000, req=8941, rank=6}, -- Regrowth Rank 6
			{414644,13000, req=9634, rank=1}, -- Lacerate Rank 1
		},
		[44] = {
			{1824,14000, req=1823, rank=3, optional="not talentanyknown(16934,16858)"}, -- Rake Rank 3
			{9752,14000, req=9493, rank=4, optional="not talentanyknown(16934,16858)"}, -- Rip Rank 4
			{9754,14000, req=769, rank=4, optional="not talentanyknown(16934,16858)"}, -- Swipe Rank 4
			{9756,14000, req=8914, rank=5, optional=true}, -- Thorns Rank 5
			{9758,14000, req=8903, rank=8, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 8
			{22812,14000}, -- Barkskin
		},
		[46] = {
			{8905,16000, req=6780, rank=7, optional="talentanyknown(16934,16858)"}, -- Wrath Rank 7
			{8983,16000, req=6798, rank=3, optional="not talentanyknown(16934,16858)"}, -- Bash Rank 3
			{9821,16000, req=1850, rank=2}, -- Dash Rank 2
			{9823,16000, req=9005, rank=2, optional=true}, -- Pounce Rank 2
			{9829,16000, req=8992, rank=4, optional="not talentanyknown(16934,16858)"}, -- Shred Rank 4
			{9833,16000, req=8929, rank=8, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 8
			{9839,16000, req=8910, rank=8}, -- Rejuvenation Rank 8
		},
		[48] = {
			{9849,17000, req=5201, rank=4, optional="not talentanyknown(16934,16858)"}, -- Claw Rank 4
			{9852,17000, req=5196, rank=5, optional="talentanyknown(16934,16858)"}, -- Entangling Roots Rank 5
			{9856,17000, req=9750, rank=7}, -- Regrowth Rank 7
			{16813,17000, req=16812, talent=9852, rank=5}, -- Nature's Grasp Rank 5
			{22828,17000, req=22827, rank=3, optional="not talentanyknown(16934,16858)"}, -- Ferocious Bite Rank 3
			{1237950,17000, req=1237949, rank=4}, -- Revive Rank 4
			{1238070,17000, req=1238069, rank=3}, -- Primal Bite Rank 3
		},
		[50] = {
			{9862,18000, req=8918, rank=3, optional=true}, -- Tranquility Rank 3
			{9866,18000, req=6787, rank=3, optional="not talentanyknown(16934,16858)"}, -- Ravage Rank 3
			{9875,18000, req=8951, rank=5, optional="talentanyknown(16934,16858)"}, -- Starfire Rank 5
			{9880,18000, req=9745, rank=6, optional="not talentanyknown(16934,16858)"}, -- Maul Rank 6
			{9884,18000, req=8907, rank=6}, -- Mark of the Wild Rank 6
			{9888,18000, req=9758, rank=9, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 9
			{17401,18000, req=16914, rank=2, optional=true}, -- Hurricane Rank 2
			{20747,18000, req=20742, rank=4, optional=true}, -- Rebirth Rank 4
			{24976,18000, req=24975, talent=5570, rank=4}, -- Insect Swarm Rank 4
			{1235826,18000, req=414644, rank=2}, -- Lacerate Rank 2
			{1238214,18000, req=408120, rank=2}, -- Wild Growth Rank 2
		},
		[52] = {
			{9834,23000, req=9833, rank=9, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 9
			{9840,23000, req=9839, rank=9}, -- Rejuvenation Rank 9
			{9892,23000, req=9000, rank=3, optional=true}, -- Cower Rank 3
			{9894,23000, req=9752, rank=5, optional="not talentanyknown(16934,16858)"}, -- Rip Rank 5
			{9898,23000, req=9747, rank=5, optional="not talentanyknown(16934,16858)"}, -- Demoralizing Roar Rank 5
		},
		[54] = {
			{9830,24000, req=9829, rank=5, optional="not talentanyknown(16934,16858)"}, -- Shred Rank 5
			{9857,24000, req=9856, rank=8}, -- Regrowth Rank 8
			{9901,24000, req=8955, rank=3, optional=true}, -- Soothe Animal Rank 3
			{9904,24000, req=1824, rank=4, optional="not talentanyknown(16934,16858)"}, -- Rake Rank 4
			{9907,24000, req=9749, rank=4, optional="talentanyknown(16934,16858)"}, -- Faerie Fire Rank 4
			{9908,24000, req=9754, rank=5, optional="not talentanyknown(16934,16858)"}, -- Swipe Rank 5
			{9910,24000, req=9756, rank=6, optional=true}, -- Thorns Rank 6
			{9912,24000, req=8905, rank=8, optional="talentanyknown(16934,16858)"}, -- Wrath Rank 8
		},
		[56] = {
			{9827,25000, req=9823, rank=3, optional=true}, -- Pounce Rank 3
			{9889,25000, req=9888, rank=10, optional="talentanyknown(16934,16858)"}, -- Healing Touch Rank 10
			{22829,25000, req=22828, rank=4, optional="not talentanyknown(16934,16858)"}, -- Ferocious Bite Rank 4
		},
		[58] = {
			{9835,26000, req=9834, rank=10, optional="talentanyknown(16934,16858)"}, -- Moonfire Rank 10
			{9841,26000, req=9840, rank=10}, -- Rejuvenation Rank 10
			{9850,26000, req=9849, rank=5, optional="not talentanyknown(16934,16858)"}, -- Claw Rank 5
			{9853,26000, req=9852, rank=6, optional="talentanyknown(16934,16858)"}, -- Entangling Roots Rank 6
			{9867,26000, req=9866, rank=4, optional="not talentanyknown(16934,16858)"}, -- Ravage Rank 4
			{9876,26000, req=9875, rank=6, optional="talentanyknown(16934,16858)"}, -- Starfire Rank 6
			{9881,26000, req=9880, rank=7, optional="not talentanyknown(16934,16858)"}, -- Maul Rank 7
			{17329,26000, req=16813, talent=9853, rank=6}, -- Nature's Grasp Rank 6
			{18658,26000, req=18657, rank=3, optional=true}, -- Hibernate Rank 3
			{1235827,26000, req=1235826, rank=3}, -- Lacerate Rank 3
		},
		[60] = {
			{9858,28000, req=9857, rank=9}, -- Regrowth Rank 9
			{9863,28000, req=9862, rank=4, optional=true}, -- Tranquility Rank 4
			{9885,28000, req=9884, rank=7}, -- Mark of the Wild Rank 7
			{9896,28000, req=9894, rank=6, optional="not talentanyknown(16934,16858)"}, -- Rip Rank 6
			{9913,28000, req=6783, rank=3}, -- Prowl Rank 3
			{17402,28000, req=17401, rank=3, optional=true}, -- Hurricane Rank 3
			{20748,28000, req=20747, rank=5, optional=true}, -- Rebirth Rank 5
			{24977,28000, req=24976, talent=5570, rank=5}, -- Insect Swarm Rank 5
			{1237951,28000, req=1237950, rank=5}, -- Revive Rank 5
			{1238073,28000, req=1238070, rank=4}, -- Primal Bite Rank 4
			{1238215,28000, req=1238214, rank=3}, -- Wild Growth Rank 3
		},
	},
	SHAMAN = {
		[1] = {
			{8017,10, rank=1}, -- Rockbiter Weapon Rank 1
		},
		[4] = {
			{8042,100, rank=1}, -- Earth Shock Rank 1
		},
		[6] = {
			{332,100, req=331, rank=2}, -- Healing Wave Rank 2
			{2484,100, optional=true}, -- Earthbind Totem
		},
		[8] = {
			{324,100, rank=1}, -- Lightning Shield Rank 1
			{529,100, req=403, rank=2}, -- Lightning Bolt Rank 2
			{5730,100, rank=1, optional=true}, -- Stoneclaw Totem Rank 1
			{8018,100, req=8017, rank=2}, -- Rockbiter Weapon Rank 2
			{8044,100, req=8042, rank=2}, -- Earth Shock Rank 2
		},
		[10] = {
			{8024,400, rank=1, optional=true}, -- Flametongue Weapon Rank 1
			{8050,400, rank=1}, -- Flame Shock Rank 1
			{8075,400, rank=1}, -- Strength of Earth Totem Rank 1
		},
		[12] = {
			{370,800, rank=1}, -- Purge Rank 1
			{547,800, req=332, rank=3}, -- Healing Wave Rank 3
			{2008,800, rank=1}, -- Ancestral Spirit Rank 1
			{408341,800, rank=1}, -- Fire Nova Rank 1
		},
		[14] = {
			{548,900, req=529, rank=3, optional="talentknown(16253)"}, -- Lightning Bolt Rank 3
			{8045,900, req=8044, rank=3, optional="talentknown(16182)"}, -- Earth Shock Rank 3
			{8154,900, req=8071, rank=2, optional=true}, -- Stoneskin Totem Rank 2
		},
		[16] = {
			{325,1800, req=324, rank=2}, -- Lightning Shield Rank 2
			{526,1800}, -- Cure Poison
			{8019,1800, req=8018, rank=3}, -- Rockbiter Weapon Rank 3
		},
		[18] = {
			{913,2000, req=547, rank=4}, -- Healing Wave Rank 4
			{6390,2000, req=5730, rank=2, optional=true}, -- Stoneclaw Totem Rank 2
			{8027,2000, req=8024, rank=2, optional=true}, -- Flametongue Weapon Rank 2
			{8052,2000, req=8050, rank=2, optional="not talentknown(16176)"}, -- Flame Shock Rank 2
			{8143,2000, optional=true}, -- Tremor Totem
		},
		[20] = {
			{915,2200, req=548, rank=4, optional="talentknown(16253)"}, -- Lightning Bolt Rank 4
			{2645,2200}, -- Ghost Wolf
			{6363,2200, req=3599, rank=2, optional=true}, -- Searing Totem Rank 2
			{8004,2200, rank=1}, -- Lesser Healing Wave Rank 1
			{8033,2200, rank=1, optional=true}, -- Frostbrand Weapon Rank 1
			{8056,2200, rank=1}, -- Frost Shock Rank 1
			{36936,7000}, -- Totemic Recall
			{66842,7000}, -- Call of the Elements
		},
		[22] = {
			{131,3000}, -- Water Breathing
			{2870,3000}, -- Cure Disease
			{8166,3000, optional=true}, -- Poison Cleansing Totem
			{408342,3000, req=408341, rank=2}, -- Fire Nova Rank 2
			{437009,3000}, -- Totemic Projection
		},
		[24] = {
			{905,3500, req=325, rank=3}, -- Lightning Shield Rank 3
			{939,3500, req=913, rank=5}, -- Healing Wave Rank 5
			{8046,3500, req=8045, rank=4, optional="talentknown(16176)"}, -- Earth Shock Rank 4
			{8155,3500, req=8154, rank=3, optional=true}, -- Stoneskin Totem Rank 3
			{8160,3500, req=8075, rank=2}, -- Strength of Earth Totem Rank 2
			{8181,3500, rank=1, optional=true}, -- Frost Resistance Totem Rank 1
			{10399,3500, req=8019, rank=4}, -- Rockbiter Weapon Rank 4
			{20609,3500, req=2008, rank=2, optional=true}, -- Ancestral Spirit Rank 2
		},
		[26] = {
			{943,4000, req=915, rank=5, optional="talentknown(16253)"}, -- Lightning Bolt Rank 5
			{5675,4000, rank=1, optional="not talentknown(16176)"}, -- Mana Spring Totem Rank 1
			{6196,4000, optional=true}, -- Far Sight
			{8030,4000, req=8027, rank=3, optional=true}, -- Flametongue Weapon Rank 3
			{8190,4000, rank=1, optional=true}, -- Magma Totem Rank 1
		},
		[28] = {
			{546,6000}, -- Water Walking
			{6391,6000, req=6390, rank=3, optional=true}, -- Stoneclaw Totem Rank 3
			{8008,6000, req=8004, rank=2}, -- Lesser Healing Wave Rank 2
			{8038,6000, req=8033, rank=2, optional=true}, -- Frostbrand Weapon Rank 2
			{8053,6000, req=8052, rank=3, optional="not talentknown(16176)"}, -- Flame Shock Rank 3
			{8184,6000, rank=1, optional=true}, -- Fire Resistance Totem Rank 1
			{8227,6000, rank=1, optional=true}, -- Flametongue Totem Rank 1
		},
		[30] = {
			{556,7000}, -- Astral Recall
			{6364,7000, req=6363, rank=3}, -- Searing Totem Rank 3
			{6375,7000, req=5394, rank=2, optional="talentknown(16176)"}, -- Healing Stream Totem Rank 2
			{8177,7000}, -- Grounding Totem
			{8232,7000, rank=1, optional=true}, -- Windfury Weapon Rank 1
			{10595,7000, rank=1, optional=true}, -- Nature Resistance Totem Rank 1
			{20608,7000}, -- Reincarnation (Passive)
			{66843,7000, req=66842}, -- Call of the Ancestors
		},
		[32] = {
			{421,8000, rank=1, optional="talentknown(16253)"}, -- Chain Lightning Rank 1
			{945,8000, req=905, rank=4}, -- Lightning Shield Rank 4
			{959,8000, req=939, rank=6}, -- Healing Wave Rank 6
			{6041,8000, req=943, rank=6, optional="talentknown(16253)"}, -- Lightning Bolt Rank 6
			{8012,8000, req=370, rank=2}, -- Purge Rank 2
			{8512,8000, rank=1}, -- Windfury Totem Rank 1
			{408343,8000, req=408342, rank=3}, -- Fire Nova Rank 3
		},
		[34] = {
			{6495,9000, optional=true}, -- Sentry Totem
			{8058,9000, req=8056, rank=2, optional=true}, -- Frost Shock Rank 2
			{10406,9000, req=8155, rank=4, optional=true}, -- Stoneskin Totem Rank 4
			{16314,9000, req=10399, rank=5}, -- Rockbiter Weapon Rank 5
		},
		[36] = {
			{8010,10000, req=8008, rank=3}, -- Lesser Healing Wave Rank 3
			{10412,10000, req=8046, rank=5, optional="talentknown(16176)"}, -- Earth Shock Rank 5
			{10495,10000, req=5675, rank=2, optional="not talentknown(16176)"}, -- Mana Spring Totem Rank 2
			{10585,10000, req=8190, rank=2, optional=true}, -- Magma Totem Rank 2
			{15107,10000, rank=1, optional=true}, -- Windwall Totem Rank 1
			{16339,10000, req=8030, rank=4, optional=true}, -- Flametongue Weapon Rank 4
			{20610,10000, req=20609, rank=3, optional=true}, -- Ancestral Spirit Rank 3
		},
		[38] = {
			{6392,11000, req=6391, rank=4, optional=true}, -- Stoneclaw Totem Rank 4
			{8161,11000, req=8160, rank=3}, -- Strength of Earth Totem Rank 3
			{8170,11000, optional=true}, -- Disease Cleansing Totem
			{8249,11000, req=8227, rank=2, optional=true}, -- Flametongue Totem Rank 2
			{10391,11000, req=6041, rank=7, optional="talentknown(16253)"}, -- Lightning Bolt Rank 7
			{10456,11000, req=8038, rank=3, optional=true}, -- Frostbrand Weapon Rank 3
			{10478,11000, req=8181, rank=2, optional=true}, -- Frost Resistance Totem Rank 2
		},
		[40] = {
			{930,12000, req=421, rank=2, optional="talentknown(16253)"}, -- Chain Lightning Rank 2
			{1064,12000, rank=1, optional="talentknown(16253)"}, -- Chain Heal Rank 1
			{6365,12000, req=6364, rank=4}, -- Searing Totem Rank 4
			{6377,12000, req=6375, rank=3, optional="talentknown(16190)"}, -- Healing Stream Totem Rank 3
			{8005,12000, req=959, rank=7}, -- Healing Wave Rank 7
			{8134,12000, req=945, rank=5}, -- Lightning Shield Rank 5
			{8235,12000, req=8232, rank=2, optional=true}, -- Windfury Weapon Rank 2
			{8737,12000}, -- Mail
			{10447,12000, req=8053, rank=4, optional="not talentknown(16176)"}, -- Flame Shock Rank 4
			{66844,7000, req=66843}, -- Call of the Spirits
		},
		[42] = {
			{8835,16000, rank=1, optional=true}, -- Grace of Air Totem Rank 1
			{10537,16000, req=8184, rank=2, optional=true}, -- Fire Resistance Totem Rank 2
			{10613,16000, req=8512, rank=2}, -- Windfury Totem Rank 2
			{408344,16000, req=408343, rank=4}, -- Fire Nova Rank 4
		},
		[44] = {
			{10392,18000, req=10391, rank=8, optional="talentknown(17364)"}, -- Lightning Bolt Rank 8
			{10407,18000, req=10406, rank=5, optional=true}, -- Stoneskin Totem Rank 5
			{10466,18000, req=8010, rank=4}, -- Lesser Healing Wave Rank 4
			{10600,18000, req=10595, rank=2, optional=true}, -- Nature Resistance Totem Rank 2
			{16315,18000, req=16314, rank=6}, -- Rockbiter Weapon Rank 6
		},
		[46] = {
			{10472,20000, req=8058, rank=3, optional=true}, -- Frost Shock Rank 3
			{10496,20000, req=10495, rank=3, optional="not talentknown(16190)"}, -- Mana Spring Totem Rank 3
			{10586,20000, req=10585, rank=3, optional=true}, -- Magma Totem Rank 3
			{10622,20000, req=1064, rank=2, optional="talentknown(17364)"}, -- Chain Heal Rank 2
			{15111,20000, req=15107, rank=2, optional=true}, -- Windwall Totem Rank 2
			{16341,20000, req=16339, rank=5, optional=true}, -- Flametongue Weapon Rank 5
		},
		[48] = {
			{2860,22000, req=930, rank=3, optional="talentknown(17364)"}, -- Chain Lightning Rank 3
			{10395,22000, req=8005, rank=8}, -- Healing Wave Rank 8
			{10413,22000, req=10412, rank=6, optional="talentknown(16190)"}, -- Earth Shock Rank 6
			{10427,22000, req=6392, rank=5, optional=true}, -- Stoneclaw Totem Rank 5
			{10431,22000, req=8134, rank=6}, -- Lightning Shield Rank 6
			{10526,22000, req=8249, rank=3, optional=true}, -- Flametongue Totem Rank 3
			{16355,22000, req=10456, rank=4, optional=true}, -- Frostbrand Weapon Rank 4
			{17354,800, talent=16190, rank=2}, -- Mana Tide Totem Rank 2
			{20776,22000, req=20610, rank=4, optional=true}, -- Ancestral Spirit Rank 4
		},
		[50] = {
			{10437,24000, req=6365, rank=5}, -- Searing Totem Rank 5
			{10462,24000, req=6377, rank=4, optional="talentknown(16190)"}, -- Healing Stream Totem Rank 4
			{10486,24000, req=8235, rank=3, optional=true}, -- Windfury Weapon Rank 3
			{15207,24000, req=10392, rank=9, optional="talentknown(17364)"}, -- Lightning Bolt Rank 9
			{1238299,24000, req=408490, rank=2}, -- Lava Burst Rank 2
			{1239242,800, req=408521, rank=2}, -- Riptide Rank 2
		},
		[52] = {
			{10442,27000, req=8161, rank=4}, -- Strength of Earth Totem Rank 4
			{10448,27000, req=10447, rank=5, optional="not talentknown(16190)"}, -- Flame Shock Rank 5
			{10467,27000, req=10466, rank=5}, -- Lesser Healing Wave Rank 5
			{10614,27000, req=10613, rank=3}, -- Windfury Totem Rank 3
			{408345,27000, req=408344, rank=5}, -- Fire Nova Rank 5
		},
		[54] = {
			{10408,29000, req=10407, rank=6, optional=true}, -- Stoneskin Totem Rank 6
			{10479,29000, req=10478, rank=3, optional=true}, -- Frost Resistance Totem Rank 3
			{10623,29000, req=10622, rank=3, optional="talentknown(17364)"}, -- Chain Heal Rank 3
			{16316,29000, req=16315, rank=7}, -- Rockbiter Weapon Rank 7
		},
		[56] = {
			{10396,30000, req=10395, rank=9}, -- Healing Wave Rank 9
			{10432,30000, req=10431, rank=7}, -- Lightning Shield Rank 7
			{10497,30000, req=10496, rank=4, optional="not talentknown(16190)"}, -- Mana Spring Totem Rank 4
			{10587,30000, req=10586, rank=4, optional=true}, -- Magma Totem Rank 4
			{10605,30000, req=2860, rank=4, optional="talentknown(17364)"}, -- Chain Lightning Rank 4
			{10627,30000, req=8835, rank=2, optional=true}, -- Grace of Air Totem Rank 2
			{15112,30000, req=15111, rank=3, optional=true}, -- Windwall Totem Rank 3
			{15208,30000, req=15207, rank=10, optional="talentknown(17364)"}, -- Lightning Bolt Rank 10
			{16342,30000, req=16341, rank=6, optional=true}, -- Flametongue Weapon Rank 6
		},
		[58] = {
			{10428,32000, req=10427, rank=6, optional=true}, -- Stoneclaw Totem Rank 6
			{10473,32000, req=10472, rank=4, optional=true}, -- Frost Shock Rank 4
			{10538,32000, req=10537, rank=3, optional=true}, -- Fire Resistance Totem Rank 3
			{16356,32000, req=16355, rank=5, optional=true}, -- Frostbrand Weapon Rank 5
			{16387,32000, req=10526, rank=4, optional=true}, -- Flametongue Totem Rank 4
			{17359,1600, req=17354, talent=16190, rank=3}, -- Mana Tide Totem Rank 3
		},
		[60] = {
			{10414,34000, req=10413, rank=7, optional="talentknown(16190)"}, -- Earth Shock Rank 7
			{10438,34000, req=10437, rank=6}, -- Searing Totem Rank 6
			{10463,34000, req=10462, rank=5, optional="talentknown(16190)"}, -- Healing Stream Totem Rank 5
			{10468,34000, req=10467, rank=6}, -- Lesser Healing Wave Rank 6
			{10601,34000, req=10600, rank=3, optional=true}, -- Nature Resistance Totem Rank 3
			{16362,34000, req=10486, rank=4, optional=true}, -- Windfury Weapon Rank 4
			{20777,34000, req=20776, rank=5, optional=true}, -- Ancestral Spirit Rank 5
			{1238300,34000, req=1238299, rank=3}, -- Lava Burst Rank 3
			{1239243,1600, req=1239242, rank=3}, -- Riptide Rank 3
		},
	},
	ROGUE = {
		[1] = {
			{1784,10, rank=1}, -- Stealth Rank 1
		},
		[4] = {
			{53,100, rank=1}, -- Backstab Rank 1
			{921,100, optional=true}, -- Pick Pocket
		},
		[6] = {
			{1757,100, req=1752, rank=2}, -- Sinister Strike Rank 2
			{1776,100, rank=1}, -- Gouge Rank 1
		},
		[8] = {
			{5277,200}, -- Evasion
			{6760,200, req=2098, rank=2}, -- Eviscerate Rank 2
		},
		[10] = {
			{674,300}, -- Dual Wield (Passive)
			{2983,300, rank=1}, -- Sprint Rank 1
			{5171,300, rank=1}, -- Slice and Dice Rank 1
			{6770,300, rank=1}, -- Sap Rank 1
		},
		[12] = {
			{1766,800, rank=1}, -- Kick Rank 1
			{2589,800, req=53, rank=2}, -- Backstab Rank 2
			{3127,800}, -- Parry (Passive)
		},
		[14] = {
			{703,1200, rank=1, optional=true}, -- Garrote Rank 1
			{1758,1200, req=1757, rank=3}, -- Sinister Strike Rank 3
			{8647,1200, rank=1, optional=true}, -- Expose Armor Rank 1
		},
		[16] = {
			{1804,1800, optional=true}, -- Pick Lock
			{1966,1800, rank=1, optional=true}, -- Feint Rank 1
			{6761,1800, req=6760, rank=3}, -- Eviscerate Rank 3
		},
		[18] = {
			{1777,2900, req=1776, rank=2}, -- Gouge Rank 2
			{8676,2900, rank=1}, -- Ambush Rank 1
		},
		[20] = {
			{1785,3000, req=1784, rank=2}, -- Stealth Rank 2
			{1943,3000, rank=1, optional=true}, -- Rupture Rank 1
			{2590,3000, req=2589, rank=3}, -- Backstab Rank 3
			{3420,3000, rank=1}, -- Crippling Poison Rank 1
		},
		[22] = {
			{1725,4000, optional=true}, -- Distract
			{1759,4000, req=1758, rank=4}, -- Sinister Strike Rank 4
			{1856,4000, req=1784, rank=1}, -- Vanish Rank 1
			{8631,4000, req=703, rank=2, optional=true}, -- Garrote Rank 2
		},
		[24] = {
			{2836,5000, optional=true}, -- Detect Traps (Passive)
			{5763,5000, rank=1, optional=true}, -- Mind-numbing Poison Rank 1
			{6762,5000, req=6761, rank=4}, -- Eviscerate Rank 4
		},
		[26] = {
			{1767,6000, req=1766, rank=2, optional=true}, -- Kick Rank 2
			{1833,6000}, -- Cheap Shot
			{8649,6000, req=8647, rank=2, optional=true}, -- Expose Armor Rank 2
			{8724,6000, req=8676, rank=2}, -- Ambush Rank 2
		},
		[28] = {
			{2070,8000, req=6770, rank=2}, -- Sap Rank 2
			{2591,8000, req=2590, rank=4}, -- Backstab Rank 4
			{6768,8000, req=1966, rank=2, optional=true}, -- Feint Rank 2
			{8639,8000, req=1943, rank=2, optional=true}, -- Rupture Rank 2
			{8687,8000, rank=2}, -- Instant Poison II Rank 2
		},
		[30] = {
			{408,10000, rank=1}, -- Kidney Shot Rank 1
			{1760,10000, req=1759, rank=5}, -- Sinister Strike Rank 5
			{1842,10000, req=2836, optional=true}, -- Disarm Trap
			{2835,10000, rank=1, optional=true}, -- Deadly Poison Rank 1
			{8632,10000, req=8631, rank=3, optional=true}, -- Garrote Rank 3
		},
		[32] = {
			{8623,12000, req=6762, rank=5}, -- Eviscerate Rank 5
			{8629,12000, req=1777, rank=3}, -- Gouge Rank 3
			{13220,12000, rank=1, optional=true}, -- Wound Poison Rank 1
		},
		[34] = {
			{2094,14000}, -- Blind
			{6510,14000}, -- Blinding Powder
			{8696,14000, req=2983, rank=2}, -- Sprint Rank 2
			{8725,14000, req=8724, rank=3}, -- Ambush Rank 3
		},
		[36] = {
			{8640,16000, req=8639, rank=3, optional=true}, -- Rupture Rank 3
			{8650,16000, req=8649, rank=3, optional=true}, -- Expose Armor Rank 3
			{8691,16000, rank=3}, -- Instant Poison III Rank 3
			{8721,16000, req=2591, rank=5}, -- Backstab Rank 5
		},
		[38] = {
			{2837,18000, rank=2, optional=true}, -- Deadly Poison II Rank 2
			{8621,18000, req=1760, rank=6}, -- Sinister Strike Rank 6
			{8633,18000, req=8632, rank=4, optional=true}, -- Garrote Rank 4
			{8694,18000, rank=2, optional=true}, -- Mind-numbing Poison II Rank 2
		},
		[40] = {
			{1786,20000, req=1785, rank=3}, -- Stealth Rank 3
			{1860,20000}, -- Safe Fall (Passive)
			{8624,20000, req=8623, rank=6}, -- Eviscerate Rank 6
			{8637,20000, req=6768, rank=3, optional=true}, -- Feint Rank 3
			{13228,20000, rank=2, optional=true}, -- Wound Poison II Rank 2
			{399956,10000, req=1310707, rank=2}, -- Mutilate Rank 2
		},
		[42] = {
			{1768,27000, req=1767, rank=3, optional=true}, -- Kick Rank 3
			{1857,27000, req=1856, rank=2}, -- Vanish Rank 2
			{6774,27000, req=5171, rank=2}, -- Slice and Dice Rank 2
			{11267,27000, req=8725, rank=4}, -- Ambush Rank 4
		},
		[44] = {
			{11273,29000, req=8640, rank=4, optional=true}, -- Rupture Rank 4
			{11279,29000, req=8721, rank=6}, -- Backstab Rank 6
			{11341,29000, rank=4}, -- Instant Poison IV Rank 4
		},
		[46] = {
			{11197,31000, req=8650, rank=4, optional=true}, -- Expose Armor Rank 4
			{11285,31000, req=8629, rank=4}, -- Gouge Rank 4
			{11289,31000, req=8633, rank=5, optional=true}, -- Garrote Rank 5
			{11293,31000, req=8621, rank=7}, -- Sinister Strike Rank 7
			{11357,31000, rank=3, optional=true}, -- Deadly Poison III Rank 3
		},
		[48] = {
			{11297,33000, req=2070, rank=3}, -- Sap Rank 3
			{11299,33000, req=8624, rank=7}, -- Eviscerate Rank 7
			{13229,33000, rank=3, optional=true}, -- Wound Poison III Rank 3
		},
		[50] = {
			{3421,35000, rank=2}, -- Crippling Poison II Rank 2
			{8643,35000, req=408, rank=2}, -- Kidney Shot Rank 2
			{11268,35000, req=11267, rank=5}, -- Ambush Rank 5
			{1241582,35000, req=399956, rank=3}, -- Mutilate Rank 3
		},
		[52] = {
			{11274,46000, req=11273, rank=5, optional=true}, -- Rupture Rank 5
			{11280,46000, req=11279, rank=7}, -- Backstab Rank 7
			{11303,46000, req=8637, rank=4, optional=true}, -- Feint Rank 4
			{11342,46000, rank=5}, -- Instant Poison V Rank 5
			{11400,46000, rank=3, optional=true}, -- Mind-numbing Poison III Rank 3
		},
		[54] = {
			{11290,48000, req=11289, rank=6, optional=true}, -- Garrote Rank 6
			{11294,48000, req=11293, rank=8}, -- Sinister Strike Rank 8
			{11358,48000, rank=4, optional=true}, -- Deadly Poison IV Rank 4
		},
		[56] = {
			{11198,50000, req=11197, rank=5, optional=true}, -- Expose Armor Rank 5
			{11300,50000, req=11299, rank=8}, -- Eviscerate Rank 8
			{13230,50000, rank=4, optional=true}, -- Wound Poison IV Rank 4
		},
		[58] = {
			{1769,52000, req=1768, rank=4, optional=true}, -- Kick Rank 4
			{11269,52000, req=11268, rank=6}, -- Ambush Rank 6
			{11305,52000, req=8696, rank=3}, -- Sprint Rank 3
		},
		[60] = {
			{1787,54000, req=1786, rank=4}, -- Stealth Rank 4
			{11275,54000, req=11274, rank=6, optional=true}, -- Rupture Rank 6
			{11281,54000, req=11280, rank=8}, -- Backstab Rank 8
			{11286,54000, req=11285, rank=5}, -- Gouge Rank 5
			{11343,54000, rank=6}, -- Instant Poison VI Rank 6
			{1241584,54000, req=1241582, rank=4}, -- Mutilate Rank 4
		},
	},
}