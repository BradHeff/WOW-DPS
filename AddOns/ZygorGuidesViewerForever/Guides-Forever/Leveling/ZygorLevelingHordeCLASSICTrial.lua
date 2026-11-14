local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("LevelingHCLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Startup Guide Wizard")
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Undead Starter (1-13)",{
image=ZGV.IMAGESDIR.."Tirisfal Glades",
condition_suggested=function() return raceclass('Scourge') and level <= 13 end,
condition_suggested_exclusive=true,
condition_visible=function() return Undead end,
linked = {"Leveling Guides\\Hidden Guides"},
linkedhidden = true,
hardcore = true,
next="Leveling Guides\\Silverpine Forest (13-15)",
},[[
defaultfor Scourge
step
_NOTE:_
Wrong Character Race
|tip Guide written for {o}Undead{} characters.
|tip Other races may encounter issues.
Click Here to Continue |confirm
|only if not Undead
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948
step
talk Undertaker Mordo##1568
|tip Outside the crypt.
accept Rude Awakening##363 |goto Tirisfal Glades/0 30.22,71.65
step
kill Duskbat##1512, Young Scavenger##1508
|tip Loot items worth at least {o}10 copper{} to sell.
|tip Allows training an ability early.
|tip Increases leveling speed.
Click Here to Continue |confirm |goto Tirisfal Glades/0 29.40,69.60 |q 364 |future
|mapmarker Tirisfal Glades/0 28.40,67.40
|mapmarker Tirisfal Glades/0 31.60,71.00
|mapmarker Tirisfal Glades/0 32.00,68.40
|only if Warrior or Warlock
step
talk Blacksmith Rand##2116
|tip Inside the building.
Sell Items |vendor Blacksmith Rand##2116 |goto Tirisfal Glades/0 32.38,66.22 |q 364 |future
|only if Warrior or Warlock
step
talk Shadow Priest Sarvis##1569
|tip Inside the building.
turnin Rude Awakening##363 |goto Tirisfal Glades/0 30.84,66.20
accept The Mindless Ones##364 |goto Tirisfal Glades/0 30.84,66.20
step
talk Venya Marthand##5667
|tip Inside the building.
accept Piercing the Veil##1470 |goto Tirisfal Glades 30.98,66.41
|only if Warlock
step
talk Maximillion##2126
|tip Inside the building.
Select _"I submit myself for further training my master."_ |gossip 98050
Train Abilities |trainer Maximillion##2126 |goto Tirisfal Glades/0 30.91,66.34 |q 1470
|only if Warlock
stickystart "Kill_Mindless_Zombies_And_Wretched_Zombies"
step
kill Rattlecage Skeleton##1890+
collect 3 Rattlecage Skull##6281 |q 1470/1 |goto Tirisfal Glades/0 32.80,61.19
|only if Warlock
stickystop "Kill_Mindless_Zombies_And_Wretched_Zombies"
step
talk Venya Marthand##5667
|tip Inside the building.
turnin Piercing the Veil##1470 |goto Tirisfal Glades 30.98,66.41
|only if Warlock
step
Summon Your Imp |complete warlockpet("Imp") |q 364
|tip Cast {o}Summon Imp{}.
|only if Warlock
step
talk Dannal Stern##2119
|tip Inside the building.
Train Abilities |trainer Dannal Stern##2119 |goto Tirisfal Glades/0 32.65,65.61 |q 364
|only if Warrior
step
label "Kill_Mindless_Zombies_And_Wretched_Zombies"
kill 8 Mindless Zombie##1501 |q 364/1 |goto Tirisfal Glades/0 32.60,63.07
kill 8 Wretched Zombie##1502 |q 364/2 |goto Tirisfal Glades/0 32.60,63.07
step
talk Shadow Priest Sarvis##1569
|tip Inside the building.
turnin The Mindless Ones##364		|goto Tirisfal Glades/0 30.84,66.20
accept Rattling the Rattlecages##3901	|goto Tirisfal Glades/0 30.84,66.20
accept Simple Scroll##3095		|goto Tirisfal Glades/0 30.84,66.20		|only if Warrior
accept Tainted Scroll##3099		|goto Tirisfal Glades/0 30.84,66.20		|only if Warlock
accept Encrypted Scroll##3096		|goto Tirisfal Glades/0 30.84,66.20		|only if Rogue
accept Hallowed Scroll##3097		|goto Tirisfal Glades/0 30.84,66.20		|only if Priest
accept Glyphic Scroll##3098		|goto Tirisfal Glades/0 30.84,66.20		|only if Mage
accept A Difficult Path##98601		|goto Tirisfal Glades/0 30.84,66.20		|only if Paladin
step
talk Novice Elreth##1661
|tip Inside the building.
accept The Damned##376 |goto Tirisfal Glades 30.86,66.05
step
talk Isabella##2124
|tip Inside the building.
turnin Glyphic Scroll##3098 |goto Tirisfal Glades 30.94,66.06
|only if Mage
step
talk Isabella##2124
|tip Inside the building.
Train Abilities |trainer Isabella##2124 |goto Tirisfal Glades 30.94,66.06 |q 3901
|only if Mage
step
talk Maximillion##2126
|tip Inside the building.
turnin Tainted Scroll##3099 |goto Tirisfal Glades 30.91,66.34
|only if Warlock
step
talk Dark Cleric Duesten##2123
|tip Inside the building.
turnin Hallowed Scroll##3097 |goto Tirisfal Glades 31.11,66.03
|only if Priest
step
talk Dark Cleric Duesten##2123
|tip Inside the building.
Train Abilities |trainer Dark Cleric Duesten##2123 |goto Tirisfal Glades 31.11,66.03 |q 3901
|only if Priest
step
talk Aramis Hammerhand##244808
turnin A Difficult Path##98601 |goto Tirisfal Glades/0 31.09,66.40
accept Rediscovering the Light##90902 |goto Tirisfal Glades/0 31.09,66.40
|only if Paladin
step
talk Aramis Hammerhand##244808
|tip Inside the building.
Train Abilities |trainer Aramis Hammerhand##244808 |goto Tirisfal Glades/0 31.09,66.40 |q 3901
|only if Paladin
step
Heal #5# Injured Deathguards |q 90902/1 |goto Tirisfal Glades/0 31.98,64.72
|tip Cast {o}Holy Light{}.
|tip On Injured Deathguards.
|tip Kneeling undead.
|only if Paladin
step
talk Aramis Hammerhand##244808
turnin Rediscovering the Light##90902 |goto Tirisfal Glades/0 31.09,66.40
|only if Paladin
stickystart "Collect_Scavenger_Paws"
stickystart "Collect_Duskbat_Wings"
step
kill 12 Rattlecage Skeleton##1890 |q 3901/1 |goto Tirisfal Glades/0 32.82,61.14
step
label "Collect_Scavenger_Paws"
kill Young Scavenger##1508+
|tip Wolves.
collect 6 Scavenger Paw##3265 |q 376/1 |goto Tirisfal Glades/0 32.62,58.62
step
label "Collect_Duskbat_Wings"
kill Duskbat##1512+
|tip Bats.
collect 6 Duskbat Wing##3264 |q 376/2 |goto Tirisfal Glades/0 32.62,58.62
step
Kill enemies
|tip Helps reach level 4 after quest turnins.
ding 3,980 |goto Tirisfal Glades/0 32.62,58.62
step
talk Novice Elreth##1661
|tip Inside the building.
turnin The Damned##376 |goto Tirisfal Glades 30.86,66.05
accept Marla's Last Wish##6395 |goto Tirisfal Glades 30.86,66.05
step
talk Shadow Priest Sarvis##1569
|tip Inside the building.
turnin Rattling the Rattlecages##3901 |goto Tirisfal Glades 30.83,66.20
step
talk Isabella##2124
|tip Inside the building.
Train Abilities |trainer Isabella##2124 |goto Tirisfal Glades 30.94,66.06 |q 6395
|only if Mage
step
talk Maximillion##2126
|tip Inside the building.
Select _"I submit myself for further training my master."_ |gossip 98050
Train Abilities |trainer Maximillion##2126 |goto Tirisfal Glades/0 30.91,66.34 |q 6395
|only if Warlock
step
talk Kayla Smithe##5749
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Kayla Smithe##5749 |goto Tirisfal Glades/0 30.81,66.42 |q 6395
|only if Warlock
step
talk Aramis Hammerhand##244808
|tip Inside the building.
accept Coming to Terms##91208		|goto Tirisfal Glades/0 31.09,66.40	|only if Paladin
accept Continue Your Training##91209	|goto Tirisfal Glades/0 31.09,66.40	|only if Paladin
accept A Light in the Darkness##98389	|goto Tirisfal Glades/0 31.09,66.40
step
talk Aramis Hammerhand##244808
|tip Inside the building.
Train Abilities |trainer Aramis Hammerhand##244808 |goto Tirisfal Glades/0 31.09,66.40 |q 6395
|only if Paladin
step
talk Dark Cleric Duesten##2123
|tip Inside the building.
Train Abilities |trainer Dark Cleric Duesten##2123 |goto Tirisfal Glades 31.11,66.03 |q 6395
|only if Priest
step
talk Executor Arren##1570
accept Night Web's Hollow##380 |goto Tirisfal Glades 32.15,66.01
step
talk Dannal Stern##2119
|tip Inside the building.
turnin Simple Scroll##3095 |goto Tirisfal Glades 32.69,65.56
|only if Warrior
step
talk Dannal Stern##2119
|tip Inside the building.
Train Abilities |trainer Dannal Stern##2119 |goto Tirisfal Glades 32.69,65.56 |q 380
|only if Warrior
step
talk David Trias##2122
|tip Inside the building.
turnin Encrypted Scroll##3096 |goto Tirisfal Glades 32.53,65.65
|only if Rogue
step
talk David Trias##2122
|tip Inside the building.
Train Abilities |trainer David Trias##2122 |goto Tirisfal Glades 32.53,65.65 |q 380
|only if Rogue
step
talk Deathguard Saltain##1740
|tip Walks around.
accept Scavenging Deathknell##3902 |goto Tirisfal Glades 31.61,65.60
step
click Equipment Boxes+
|tip Piles of brown boxes.
|tip Near and inside buildings.
collect 6 Scavenged Goods##11127 |q 3902/1 |goto Tirisfal Glades/0 32.73,63.50
step
talk Frightened Paladin##246143
Select _"Greetings, fellow paladin. I know this is a shock, but you have been risen and given another chance to serve the light. Come with me and I will help you acclimate to this new reality."_ |gossip 134245
Select _"Please don't do this..."_ |gossip 134244
kill Frightened Paladin##246143
Offer Aid to the Frightened Paladin |q 91208/1 |goto Tirisfal Glades/0 27.68,63.82
step
kill 10 Young Night Web Spider##1504 |q 380/1 |goto Tirisfal Glades/0 28.98,57.21
|tip Outside the mine.
stickystart "Kill_Night_Web_Spiders"
step
clicknpc Webbed Forsaken##271961+
|tip Squirming cocoons.
|tip Inside the mine.
Free #6# Webbed Forsaken |q 98389/1 |goto Tirisfal Glades 26.84,59.41
step
label "Kill_Night_Web_Spiders"
kill 8 Night Web Spider##1505 |q 380/2 |goto Tirisfal Glades 26.84,59.41
|tip Inside the mine.
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Inside and outside the mine.
Die on Purpose |complete isdead |goto Tirisfal Glades 26.84,59.41 |q 380
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Tirisfal Glades 31.24,64.89 |q 380 |zombiewalk
|only if not hardcore()
step
Leave the mine |goto Tirisfal Glades/0 26.82,59.42 < 15 |walk |only if subzone("Night Web's Hollow") and indoors()
talk Deathguard Saltain##1740
|tip Walks around.
turnin Scavenging Deathknell##3902 |goto Tirisfal Glades 31.61,65.60
step
talk Aramis Hammerhand##244808
|tip Inside the building.
turnin Coming to Terms##91208		|goto Tirisfal Glades/0 31.09,66.40 |only if Paladin
turnin A Light in the Darkness##98389	|goto Tirisfal Glades/0 31.09,66.40
step
talk Executor Arren##1570
turnin Night Web's Hollow##380 |goto Tirisfal Glades 32.15,66.01
accept The Scarlet Crusade##381 |goto Tirisfal Glades 32.15,66.01
step
kill Scarlet Convert##1506, Scarlet Initiate##1507
collect 12 Scarlet Armband##3266 |q 381/1 |goto Tirisfal Glades/0 37.51,67.62
step
kill Samuel Fipps##1919
|tip Zombie.
|tip Walks around.
collect Samuel's Remains##16333 |goto Tirisfal Glades 36.68,61.57 |q 6395
step
click Marla's Grave
Bury Samuel's Remains |q 6395/1 |goto Tirisfal Glades 31.17,65.08
step
talk Novice Elreth##1661
|tip Inside the building.
turnin Marla's Last Wish##6395 |goto Tirisfal Glades 30.86,66.05
step
use Pelt Collecting for Beginners##247846
Learn Skinning |skillmax Skinning,75
|only if itemcount(247846) > 0
step
use Wild Harvest##247841
Learn Herbalism |skillmax Herbalism,75
|only if itemcount(247841) > 0
step
use Mining for Dummies##247840
Learn Mining |skillmax Mining,75
|only if itemcount(247840) > 0
step
talk Dark Cleric Duesten##2123
|tip Inside the building.
accept In Favor of Darkness##5651 |goto Tirisfal Glades 31.11,66.03
|only if Priest
step
talk Executor Arren##1570
turnin The Scarlet Crusade##381 |goto Tirisfal Glades 32.15,66.01
accept The Red Messenger##382 |goto Tirisfal Glades 32.15,66.01
step
talk Joshua Kien##2115
|tip Inside the building.
buy Skinning Knife##7005 |goto Tirisfal Glades/0 32.28,65.44 |q 382
buy Apprentice's Skinning Satchel##277114 |goto Tirisfal Glades/0 32.28,65.44 |q 382
|only if skillmax("Skinning") > 1
step
talk Joshua Kien##2115
|tip Inside the building.
buy Apprentice's Herb Pouch##277113 |goto Tirisfal Glades/0 32.28,65.44 |q 382
|only if skillmax("Herbalism") > 1
step
talk Joshua Kien##2115
|tip Inside the building.
buy Mining Pick##2901 |goto Tirisfal Glades/0 32.28,65.44 |q 382
buy Apprentice's Mining Pack##277115 |goto Tirisfal Glades/0 32.28,65.44 |q 382
|only if skillmax("Mining") > 1
step
kill Meven Korgal##1667
collect Scarlet Crusade Documents##2885 |q 382/1 |goto Tirisfal Glades/0 36.51,68.80
step
talk Executor Arren##1570
turnin The Red Messenger##382 |goto Tirisfal Glades/0 32.15,66.01
accept Vital Intelligence##383 |goto Tirisfal Glades/0 32.15,66.01
accept The Adventurer##96656 |goto Tirisfal Glades/0 32.15,66.01
step
talk Calvin Montague##6784
accept A Rogue's Deal##8 |goto Tirisfal Glades 38.23,56.79
step
talk Deathguard Simmer##1519
accept Fields of Grief##365 |goto Tirisfal Glades/0 40.91,54.16
step
map Tirisfal Glades
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	40.78,54.49	41.11,54.83	41.44,55.04	42.36,55.03	42.68,54.93
path	43.40,54.44	43.79,54.47	44.36,55.23	45.04,56.24	45.36,56.47
path	45.99,56.70	46.59,56.97	47.23,57.32	48.59,57.85	49.15,57.94
path	50.04,57.90	50.50,57.66	51.21,56.46	51.58,55.83	51.77,55.45
path	51.95,55.09	53.64,53.22	53.92,52.93	54.19,52.78	54.59,52.64
path	55.02,52.32	55.30,52.29	55.73,52.47	56.18,52.48
talk Gordo##10666
|tip Abomination.
|tip Walks along the road.
|tip Sometimes leaves the road to collect plants.
accept Gordo's Task##5481
step
talk Eleanor Shackleton##265812
turnin The Adventurer##96656 |goto Tirisfal Glades/0 57.27,55.49
accept The Great Outdoors##96607 |goto Tirisfal Glades/0 57.27,55.49
step
Watch the dialogue
Use the {y}/sit{} Emote Near the Campfire |q 96607/1 |goto Tirisfal Glades/0 57.27,55.49 |macro /sit
Gain the Boosted Rest Buff |q 96607/2 |goto Tirisfal Glades/0 57.27,55.49
|tip Takes {o}1 minute{}.
step
talk Eleanor Shackleton##265812
turnin The Great Outdoors##96607		|goto Tirisfal Glades/0 57.27,55.49
accept Camping 101: Cooking##96658		|goto Tirisfal Glades/0 57.27,55.49
accept Camping 101: Skinning##97960		|goto Tirisfal Glades/0 57.27,55.49 |only if skillmax("Skinning") >= 1
accept Camping 101: Herbalism##97957	|goto Tirisfal Glades/0 57.27,55.49 |only if skillmax("Herbalism") >= 1
accept Camping 101: Mining##97959		|goto Tirisfal Glades/0 57.27,55.49 |only if skillmax("Mining") >= 1
step
talk Deathguard Dillinger##1496
accept A Putrid Task##404 |goto Tirisfal Glades/0 58.20,51.44
step
talk Deathguard Bartholomew##1742
accept Sticks and Bones##86784 |goto Tirisfal Glades/0 58.47,51.39
step
talk Apothecary Johaan##1518
|tip Inside the building.
accept A New Plague##367 |goto Tirisfal Glades/0 59.45,52.40
step
talk Shari Stilwell##246152
Report to Shari Stilwell in Brill |q 91209/1 |goto Tirisfal Glades/0 60.23,52.68
|only if Paladin
step
talk Shari Stilwell##246152
turnin Continue Your Training##91209 |goto Tirisfal Glades/0 60.23,52.68
|only if Paladin
step
talk Shari Stilwell##246152
Train Abilities |trainer Shari Stilwell##246152 |goto Tirisfal Glades/0 60.23,52.68 |q 383
|only if Paladin
step
talk Executor Zygand##1515
turnin Vital Intelligence##383 |goto Tirisfal Glades/0 60.59,51.76
accept At War With The Scarlet Crusade##427 |goto Tirisfal Glades/0 60.59,51.76
accept Patience##99141 |goto Tirisfal Glades/0 60.59,51.76
accept Discipline##99134 |goto Tirisfal Glades/0 60.59,51.76
step
use Executor's Motivator##286176
|tip On Deathguard Cyrus.
Motivate the Deathguard |q 99134/1 |goto Tirisfal Glades/0 60.70,51.93 |count 1
step
use Executor's Motivator##286176
|tip On Deathguard Burgess.
Motivate the Deathguard |q 99134/1 |goto Tirisfal Glades/0 60.93,52.00 |count 2
step
use Executor's Motivator##286176
|tip On Deathguard Terrence.
Motivate the Deathguard |q 99134/1 |goto Tirisfal Glades/0 61.50,53.49 |count 3
step
talk Austil de Mon##2131
|tip Inside the building.
Train Abilities |trainer Austil de Mon##2131 |goto Tirisfal Glades/0 61.86,52.54 |q 8
|only if Warrior
step
talk Innkeeper Renee##5688
|tip Inside the building.
turnin A Rogue's Deal##8 |goto Tirisfal Glades 61.71,52.05
step
talk Innkeeper Renee##5688
|tip Inside the building.
home Gallows' End Tavern |goto Tirisfal Glades 61.71,52.05
step
talk William Pickman##265944
|tip Inside the building.
Select _"Train me."_ |gossip 96866
Learn Cooking from William Pickman in Brill |q 96658/1 |goto Tirisfal Glades/0 61.75,51.43
step
talk William Pickman##265944
|tip Inside the building.
turnin Camping 101: Cooking##96658 |goto Tirisfal Glades/0 61.75,51.43
step
use Executor's Motivator##286176
|tip On Deathguard Royann.
|tip Downstairs inside the building.
Motivate the Deathguard |q 99134/1 |goto Tirisfal Glades/0 61.67,51.18 |count 4
step
use Executor's Motivator##286176
|tip On Deathguard Gavin.
|tip Downstairs inside the building.
Motivate the Deathguard |q 99134/1 |goto Tirisfal Glades/0 61.74,51.41 |count 5
step
talk Cain Firesong##2128
|tip Upstairs inside the building.
Train Abilities |trainer Cain Firesong##2128 |goto Tirisfal Glades/0 61.97,52.47 |q 367
|only if Mage
step
talk Rupert Boch##2127
|tip Upstairs inside the building.
Train Abilities |trainer Rupert Boch##2127 |goto Tirisfal Glades/0 61.59,52.40 |q 367
|only if Warlock
step
talk Gina Lang##5750
|tip Upstairs inside the building.
Train Demon Abilities |vendor Gina Lang##5750 |goto Tirisfal Glades/0 61.55,52.61 |q 367
|only if Warlock
step
talk Dark Cleric Beryl##2129
|tip Upstairs inside the building.
Train Abilities |trainer Dark Cleric Beryl##2129 |goto Tirisfal Glades/0 61.57,52.20 |q 367
|only if Priest
step
talk Dark Cleric Beryl##2129
|tip Upstairs inside the building.
turnin In Favor of Darkness##5651 |goto Tirisfal Glades 61.57,52.19
accept Garments of Darkness##5650 |goto Tirisfal Glades 61.57,52.19
|only if Priest
step
Heal and Fortify Deathguard Kel |q 5650/1 |goto Tirisfal Glades 59.18,46.50
|tip Cast {o}Lesser Heal (Rank 2){} on Deathguard Kel.
|tip Cast {o}Power Word: Fortitude{} on Deathguard Kel.
|only if Priest
step
talk Dark Cleric Beryl##2129
|tip Upstairs inside the building.
turnin Garments of Darkness##5650 |goto Tirisfal Glades 61.57,52.19
|only if Priest
step
talk Marion Call##2130
|tip Upstairs inside the building.
Train Abilities |trainer Marion Call##2130 |goto Tirisfal Glades/0 61.75,52.00 |q 367
|only if Rogue
step
talk Deathguard Kristof##251001
Select _"I need a report for Executor Zygand."_ |gossip 142730
collect Kristof's Report##286201 |q 99141/2 |goto Tirisfal Glades/0 65.25,60.21
step
talk Shelene Rhobart##3549
accept Hides for the Forsaken##97558 |goto Tirisfal Glades/0 65.42,60.08
stickystart "Collect_Duskbat_Wing_Membranes"
stickystart "Raise_Your_Skinning_Skill_To_20_Skinning"
step
kill Decrepit Darkhound##1547+
|tip Grey demon dogs.
collect 5 Darkhound Blood##2858 |q 367/1 |goto Tirisfal Glades/0 64.93,53.22
collect 6 Darkhound Hide##278243 |q 97558/2 |goto Tirisfal Glades/0 64.93,53.22
step
label "Collect_Duskbat_Wing_Membranes"
kill Greater Duskbat##1553+
collect 8 Duskbat Wing Membrane##278242 |q 97558/1 |goto Tirisfal Glades/0 64.93,53.22
step
label "Raise_Your_Skinning_Skill_To_20_Skinning"
Kill enemies
|tip Skin them.
Raise Your Skinning Skill to 20 |q 97960/1 |goto Tirisfal Glades/0 64.93,53.22
|only if haveq(97960) or completedq(97960)
step
talk Rand Rhobart##6289
turnin Camping 101: Skinning##97960 |goto Tirisfal Glades/0 65.59,60.03
|only if haveq(97960) or completedq(97960)
stickystart "Collect_Dry_Branches"
step
talk Executor Zygand##1515
turnin Discipline##99134 |goto Tirisfal Glades/0 60.58,51.76
step
talk Apothecary Johaan##1518
|tip Inside the building.
turnin A New Plague##367 |goto Tirisfal Glades/0 59.45,52.40
accept A New Plague##368 |goto Tirisfal Glades/0 59.45,52.40
stickystop "Collect_Dry_Branches"
step
talk Gretchen Dedmar##1521
|tip Upstairs inside the building.
accept The Chill of Death##375 |goto Tirisfal Glades/0 61.89,52.73
stickystart "Collect_Dry_Branches"
step
talk Deathguard Dillinger##1496
Select _"I need a report for Executor Zygand."_ |gossip 142723
collect Dillinger's Report##286200 |q 99141/1 |goto Tirisfal Glades/0 58.20,51.45
stickystart "Collect_Gloom_Weeds"
stickystart "Collect_Duskbat_Pelts"
step
label "Collect_Dry_Branches"
click Dry Branch+
|tip Brown sticks.
|tip Usually near trees.
collect 6 Dry Branch##279991 |q 86784/1 |goto Tirisfal Glades/0 57.94,54.08
step
talk Eleanor Shackleton##265812
turnin Sticks and Bones##86784 |goto Tirisfal Glades/0 57.27,55.48
stickystart "Collect_Gordos_Report"
step
kill Ravaged Corpse##1526, Rotting Dead##1525
|tip Zombies.
collect 7 Putrid Claw##2855 |q 404/1 |goto Tirisfal Glades/0 53.19,51.89
step
label "Collect_Gloom_Weeds"
click Gloom Weed##175566+
|tip Withered purple plants.
|tip Work your way {o}west{}. |notinsticky
collect 3 Gloom Weed##12737 |q 5481/1 |goto Tirisfal Glades/0 47.89,55.16
step
label "Collect_Gordos_Report"
map Tirisfal Glades
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	56.18,52.48	55.73,52.47	55.30,52.29	55.02,52.32	54.59,52.64
path	54.19,52.78	53.92,52.93	53.64,53.22	51.95,55.09	51.77,55.45
path	51.58,55.83	51.21,56.46	50.50,57.66	50.04,57.90	49.15,57.94
path	48.59,57.85	47.23,57.32	46.59,56.97	45.99,56.70	45.36,56.47
path	45.04,56.24	44.36,55.23	43.79,54.47	43.40,54.44	42.68,54.93
path	42.36,55.03	41.44,55.04	41.11,54.83	40.78,54.49
talk Gordo##10666
|tip Abomination.
|tip Walks along the road.
|tip Sometimes leaves the road to collect plants.
Select _"I need a report for Executor Zygand."_ |gossip 142737
collect Gordo's Report##286202 |q 99141/3 |goto Tirisfal Glades/0 52.39,54.33
step
label "Collect_Duskbat_Pelts"
kill Greater Duskbat##1553+
collect 5 Duskbat Pelt##2876 |q 375/1 |goto Tirisfal Glades/0 46.05,51.33
stickystart "Collect_Tirisfal_Pumpkins"
stickystart "Kill_Scarlet_Warriors"
step
talk Bareth Dawnstone##275954
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Top of the tower.
accept Seeking Refuge##99144 |goto Tirisfal Glades/0 32.00,46.41
step
Escort Bareth Dawnstone out of Crusader's Outpost |q 99144/1 |goto Tirisfal Glades/0 39.06,48.76
|tip Follow and protect Bareth Dawnstone.
step
label "Collect_Tirisfal_Pumpkins"
click Tirisfal Pumpkin##375+
collect 10 Tirisfal Pumpkin##2846 |q 365/1 |goto Tirisfal Glades/0 35.96,50.21
step
label "Kill_Scarlet_Warriors"
kill 10 Scarlet Warrior##1535 |q 427/1 |goto Tirisfal Glades/0 33.24,47.93
step
talk Coleman Farthing##1500
|tip Inside the building.
accept Deaths in the Family##354 |goto Tirisfal Glades/0 61.72,52.28
accept The Haunted Mills##362 |goto Tirisfal Glades/0 61.72,52.28
step
talk Abigail Shiel##2118
buy Coarse Thread##2320 |q 375/2 |goto Tirisfal Glades 61.03,52.37
step
talk Magistrate Sevren##1499
|tip Inside the building.
accept Graverobbers##358 |goto Tirisfal Glades/0 61.26,50.84
step
click Wanted!
|tip Wanted poster.
accept Wanted: Maggot Eye##398 |goto Tirisfal Glades 60.73,51.52
step
talk Executor Zygand##1515
turnin At War With The Scarlet Crusade##427 |goto Tirisfal Glades/0 60.59,51.76
accept At War With The Scarlet Crusade##370 |goto Tirisfal Glades/0 60.59,51.76
turnin Patience##99141 |goto Tirisfal Glades/0 60.59,51.76
step
talk Shari Stilwell##246152
turnin Seeking Refuge##99144 |goto Tirisfal Glades/0 60.23,52.67
step
talk Apothecary Johaan##1518
|tip Inside the building.
turnin Fields of Grief##365 |goto Tirisfal Glades/0 59.45,52.40
accept Fields of Grief##407 |goto Tirisfal Glades/0 59.45,52.40
step
talk Deathguard Dillinger##1496
turnin A Putrid Task##404 |goto Tirisfal Glades/0 58.20,51.45
accept The Mills Overrun##426 |goto Tirisfal Glades/0 58.20,51.45
step
map Tirisfal Glades
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	59.25,46.73	59.10,47.09	58.81,47.44	58.51,47.71	58.17,47.95
path	57.87,48.13	57.68,48.41	57.59,48.81	57.67,48.97	57.67,49.36
path	57.85,49.63	58.13,49.74	58.29,49.90	58.31,50.42	58.20,49.75
path	57.84,49.62	57.62,49.30	57.50,49.33	57.36,49.22	57.37,48.96
path	57.59,48.71
talk Junior Apothecary Holland##10665
|tip Walks a large path.
turnin Gordo's Task##5481
accept Doom Weed##5482
step
talk Deathguard Burgess##1652
accept Proof of Demise##374 |goto Tirisfal Glades/0 60.93,52.01
step
talk Austil de Mon##2131
|tip Inside the building.
Train Abilities |trainer Austil de Mon##2131 |goto Tirisfal Glades/0 61.86,52.54 |q 407
|only if Warrior
step
talk Captured Scarlet Zealot##1931
|tip Downstairs inside the building.
turnin Fields of Grief##407 |goto Tirisfal Glades/0 61.97,51.29
step
talk Cain Firesong##2128
|tip Upstairs inside the building.
Train Abilities |trainer Cain Firesong##2128 |goto Tirisfal Glades/0 61.97,52.47 |q 375
|only if Mage
step
talk Gretchen Dedmar##1521
|tip Upstairs inside the building.
turnin The Chill of Death##375 |goto Tirisfal Glades 61.89,52.73
step
talk Rupert Boch##2127
|tip Upstairs inside the building.
Train Abilities |trainer Rupert Boch##2127 |goto Tirisfal Glades/0 61.59,52.40 |q 426
|only if Warlock
step
talk Gina Lang##5750
|tip Upstairs inside the building.
Train Demon Abilities |vendor Gina Lang##5750 |goto Tirisfal Glades/0 61.55,52.61 |q 426
|only if Warlock
step
talk Dark Cleric Beryl##2129
|tip Upstairs inside the building.
Train Abilities |trainer Dark Cleric Beryl##2129 |goto Tirisfal Glades/0 61.57,52.20 |q 426
|only if Priest
step
talk Marion Call##2130
|tip Upstairs inside the building.
Train Abilities |trainer Marion Call##2130 |goto Tirisfal Glades/0 61.75,52.00 |q 426
|only if Rogue
step
talk Nurse Neela##5759
|tip Inside the building.
Train Apprentice First Aid |skillmax First Aid,75 |goto Tirisfal Glades/0 61.82,52.83
|only if Warrior or Rogue
step
_NOTE:_
Create Bandages in Downtime
|tip While waiting for things like boats.
|tip Increases skill in First Aid.
|tip Need higher skill to make better bandages.
|tip Keep bandages to heal yourself.
Click Here to Continue |confirm |q 426
|only if Warrior or Rogue
step
talk Shari Stilwell##246152
Train Abilities |trainer Shari Stilwell##246152 |goto Tirisfal Glades/0 60.23,52.68 |q 426
|only if Paladin
stickystart "Collect_Notched_Ribs"
stickystart "Collect_Blackened_Skulls"
step
kill Devlin Agamand##1657
|tip Armored skeleton mage.
|tip Walks around.
collect Devlin's Remains##2831 |q 362/1 |goto Tirisfal Glades/0 47.23,40.03
step
kill Nissa Agamand##1655
|tip Banshee.
|tip Walks around.
|tip {o}Both floors{} inside the building.
collect Nissa's Remains##2828 |q 354/2 |goto Tirisfal Glades 49.54,36.02
step
kill Gregor Agamand##1654
|tip Ghoul.
|tip Walks around.
collect Gregor's Remains##2829 |q 354/1 |goto Tirisfal Glades/0 45.69,29.42
step
kill Thurman Agamand##1656
|tip Zombie.
|tip Walks around.
collect Thurman's Remains##2830 |q 354/3 |goto Tirisfal Glades/0 42.84,32.38
step
label "Collect_Notched_Ribs"
kill Cracked Skull Soldier##1523, Rattlecage Soldier##1520
|tip Armored skeletons.
collect 5 Notched Rib##3162 |q 426/1 |goto Tirisfal Glades/0 47.33,35.71
step
label "Collect_Blackened_Skulls"
kill Darkeye Bonecaster##1522+
|tip Skeleton mages.
collect 3 Blackened Skull##3163 |q 426/2 |goto Tirisfal Glades/0 47.33,35.71
step
use A Letter to Yvette##2839
accept A Letter Undelivered##361
|only if itemcount(2839) > 0
stickystart "Kill_Rot_Hide_Mongrels"
stickystart "Collect_Embalming_Ichors"
step
Jump down carefully |goto Tirisfal Glades/0 54.28,31.67 < 30 |only if walking and subzone("Agamand Mills")
kill Maggot Eye##1753
|tip Inside the building.
collect Maggot Eye's Paw##3635 |q 398/1 |goto Tirisfal Glades 58.66,30.76
stickystop "Kill_Rot_Hide_Mongrels"
stickystop "Collect_Embalming_Ichors"
step
kill Vile Fin Puddlejumper##1543, Vile Fin Minor Oracle##1544, Vile Fin Muckdweller##1545
|tip Murlocs.
collect 3 Vile Fin Murloc Skin##278244 |q 97558/3 |goto Tirisfal Glades/0 65.49,28.40
collect 5 Vile Fin Scale##2859 |q 368/1 |goto Tirisfal Glades/0 65.49,28.40
stickystart "Collect_Embalming_Ichors"
step
label "Kill_Rot_Hide_Mongrels"
kill 5 Rot Hide Mongrel##1675 |q 358/2 |goto Tirisfal Glades/0 59.10,35.30
stickystart "Collect_Doom_Weed"
step
kill 8 Rot Hide Graverobber##1941 |q 358/1 |goto Tirisfal Glades/0 55.90,41.61
step
label "Collect_Doom_Weed"
click Doom Weed##176753+
|tip Withered purple plants.
collect 10 Doom Weed##13702 |q 5482/1 |goto Tirisfal Glades/0 56.76,38.69
step
label "Collect_Embalming_Ichors"
kill Rot Hide Graverobber##1941, Rot Hide Gnoll##1674, Rot Hide Mongrel##1675
|tip Gnolls.
collect 8 Embalming Ichor##2834 |q 358/3 |goto Tirisfal Glades/0 56.76,38.69
step
Kill enemies
|tip Helps reach level 10 after quest turnins.
ding 9,975	|goto Tirisfal Glades/0 59.10,35.30	|only if haveq(361)
ding 9,1455	|goto Tirisfal Glades/0 59.10,35.30	|only if not haveq(361)
step
map Tirisfal Glades/0
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	59.25,46.73	59.10,47.09	58.81,47.44	58.51,47.71	58.17,47.95
path	57.87,48.13	57.68,48.41	57.59,48.81	57.67,48.97	57.67,49.36
path	57.85,49.63	58.13,49.74	58.29,49.90	58.31,50.42	58.20,49.75
path	57.84,49.62	57.62,49.30	57.50,49.33	57.36,49.22	57.37,48.96
path	57.59,48.71
talk Junior Apothecary Holland##10665
|tip Walks a large path.
turnin Doom Weed##5482b
accept Tomb Weed##99142
step
talk Deathguard Dillinger##1496
turnin The Mills Overrun##426 |goto Tirisfal Glades/0 58.20,51.45
step
talk Apothecary Johaan##1518
|tip Inside the building.
turnin A New Plague##368 |goto Tirisfal Glades/0 59.45,52.40
accept A New Plague##369 |goto Tirisfal Glades/0 59.45,52.40
step
talk Executor Zygand##1515
turnin Wanted: Maggot Eye##398 |goto Tirisfal Glades/0 60.59,51.76
step
talk Magistrate Sevren##1499
|tip Inside the building.
turnin Graverobbers##358 |goto Tirisfal Glades/0 61.26,50.84
accept Forsaken Duties##359 |goto Tirisfal Glades/0 61.26,50.84
accept The Prodigal Lich##405 |goto Tirisfal Glades/0 61.26,50.84
step
talk Yvette Farthing##1560
|tip Inside the building.
turnin A Letter Undelivered##361 |goto Tirisfal Glades/0 61.58,52.60
|only if haveq(361) or completedq(361)
step
talk Coleman Farthing##1500
|tip Inside the building.
turnin Deaths in the Family##354 |goto Tirisfal Glades/0 61.72,52.29
turnin The Haunted Mills##362 |goto Tirisfal Glades/0 61.72,52.29
accept Speak with Sevren##355 |goto Tirisfal Glades/0 61.72,52.29
step
talk Austil de Mon##2131
|tip Inside the building.
Train Abilities |trainer Austil de Mon##2131 |goto Tirisfal Glades/0 61.86,52.54 |q 355
|only if Warrior
step
talk Austil de Mon##2131
|tip Inside the building.
accept Speak with Dillinger##1818 |goto Tirisfal Glades 61.85,52.54
|only if Warrior
step
talk Deathguard Dillinger##1496
turnin Speak with Dillinger##1818 |goto Tirisfal Glades 58.20,51.45
accept Ulag the Cleaver##1819 |goto Tirisfal Glades 58.20,51.45
|only if Warrior
step
click Mausoleum Trigger##104593
|tip Metal plate with skull icon.
Watch the dialogue
kill Ulag the Cleaver##6390 |q 1819/1 |goto Tirisfal Glades 59.16,48.51
|only if Warrior
step
talk Deathguard Dillinger##1496
turnin Ulag the Cleaver##1819 |goto Tirisfal Glades 58.20,51.45
accept Speak with Coleman##1820 |goto Tirisfal Glades 58.20,51.45
|only if Warrior
step
talk Coleman Farthing##1500
|tip Inside the building.
turnin Speak with Coleman##1820 |goto Tirisfal Glades 61.72,52.29
|only if Warrior
step
talk Cain Firesong##2128
|tip Upstairs inside the building.
Train Abilities |trainer Cain Firesong##2128 |goto Tirisfal Glades/0 61.97,52.47 |q 355
|only if Mage
step
talk Cain Firesong##2128
|tip Upstairs inside the building.
accept Speak with Anastasia##1881 |goto Tirisfal Glades/0 61.97,52.47
|only if Mage
step
talk Anastasia Hartwell##4568
|tip Upstairs inside the building.
turnin Speak with Anastasia##1881 |goto Undercity/0 85.14,10.03
accept The Balnir Farmstead##1882 |goto Undercity/0 85.14,10.03
|only if Mage
step
talk Rupert Boch##2127
|tip Upstairs inside the building.
Train Abilities |trainer Rupert Boch##2127 |goto Tirisfal Glades/0 61.59,52.40 |q 355
|only if Warlock
step
talk Gina Lang##5750
|tip Upstairs inside the building.
Train Demon Abilities |vendor Gina Lang##5750 |goto Tirisfal Glades/0 61.55,52.61 |q 355
|only if Warlock
step
talk Ageron Kargal##5724
|tip Upstairs inside the building.
accept Halgar's Summons##1478 |goto Tirisfal Glades/0 61.62,52.68
|only if Warlock
step
talk Carendin Halgar##5675
turnin Halgar's Summons##1478 |goto Undercity 85.04,26.01
accept Creature of the Void##1473 |goto Undercity 85.04,26.01
|only if Warlock
step
talk Dark Cleric Beryl##2129
|tip Upstairs inside the building.
Train Abilities |trainer Dark Cleric Beryl##2129 |goto Tirisfal Glades/0 61.57,52.20 |q 355
|only if Priest
step
talk Aelthalyste##4606
accept Touch of Weakness##5658 |goto Undercity/0 49.26,17.12
|only if Priest
step
talk Aelthalyste##4606
turnin Touch of Weakness##5658 |goto Undercity/0 49.26,17.12
|only if Priest
step
talk Marion Call##2130
|tip Upstairs inside the building.
Train Abilities |trainer Marion Call##2130 |goto Tirisfal Glades/0 61.75,52.00 |q 355
|only if Rogue
step
talk Marion Call##2130
|tip Upstairs inside the building.
accept Mennet Carkad##1885 |goto Tirisfal Glades 61.75,52.00
|only if Rogue
step
talk Mennet Carkad##6467
turnin Mennet Carkad##1885 |goto Undercity/0 83.51,69.11
accept The Deathstalkers##1886 |goto Undercity/0 83.51,69.11
|only if Rogue
step
talk Archibald##11870
Train Swords |complete weaponskill("SWORD") > 0 |goto Undercity 57.31,32.77
|only if Rogue
step
talk Deathguard Terrence##1738
accept The Argent Emissary##96895 |goto Tirisfal Glades/0 61.50,53.50
step
talk Shari Stilwell##246152
Train Abilities |trainer Shari Stilwell##246152 |goto Tirisfal Glades/0 60.23,52.68 |q 370
|only if Paladin
stickystart "Collect_Scarlet_Insignia_Rings"
stickystart "Kill_Scarlet_Zealots_And_Missionaries"
step
kill Captain Perrine##1662 |q 370/1 |goto Tirisfal Glades 51.13,67.80
|tip Inside the building. |notinsticky
step
click Perrine's Chest
|tip Inside the building.
collect Egalin's Grimoire##6285 |q 1473/1 |goto Tirisfal Glades 51.06,67.57
|only if Warlock
step
label "Collect_Scarlet_Insignia_Rings"
kill Scarlet Missionary##1536, Scarlet Zealot##1537
collect 10 Scarlet Insignia Ring##2875 |q 374/1 |goto Tirisfal Glades/0 51.51,67.01
step
label "Kill_Scarlet_Zealots_And_Missionaries"
kill 3 Scarlet Zealot##1537 |q 370/2 |goto Tirisfal Glades/0 50.54,66.95
kill 3 Scarlet Missionary##1536 |q 370/3 |goto Tirisfal Glades/0 50.54,66.95
step
talk Executor Zygand##1515
turnin At War With The Scarlet Crusade##370 |goto Tirisfal Glades/0 60.59,51.76
accept At War With The Scarlet Crusade##371 |goto Tirisfal Glades/0 60.59,51.76
step
talk Deathguard Burgess##1652
turnin Proof of Demise##374 |goto Tirisfal Glades/0 60.93,52.01
step
talk Carendin Halgar##5675
turnin Creature of the Void##1473 |goto Undercity 85.04,26.01
accept The Binding##1471 |goto Undercity 85.04,26.01
|only if Warlock
step
use Runes of Summoning##6284
|tip On the pink symbol.
kill Summoned Voidwalker##5676 |q 1471/1 |goto Undercity 86.62,27.10
|only if Warlock
step
talk Carendin Halgar##5675
turnin The Binding##1471 |goto Undercity 85.04,26.01
|only if Warlock
step
talk Bethor Iceshard##1498
|tip Up on the stairs.
turnin The Prodigal Lich##405 |goto Undercity/0 84.05,17.46
accept The Lich's Identity##357 |goto Undercity/0 84.05,17.46
step
_NOTE:_
Use Weapon Stones
|tip We will train Mining and Blacksmithing.
|tip Allows you to make and use {o}Sharpening Stones{}.
|tip Increases damage.
|tip Mine {o}Copper Ore{} as you see it.
|tip Use the {g}Rough Stones{} to make sharpening stones.
Click Here to Continue |confirm |q 97891 |future
|only if Warrior or Rogue
step
talk Brom Killian##4598
Train Apprentice Mining |skillmax Mining,75 |goto Undercity/0 56.04,37.47
|only if Warrior or Rogue
step
talk Sarah Killian##4599
buy Mining Pick##2901 |goto Undercity/0 56.72,36.93
|only if Warrior or Rogue
step
talk Basil Frye##4605
Train Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Undercity/0 60.19,29.09
|only if Warrior or Rogue
step
talk Brom Killian##4598
turnin Camping 101: Mining##97959 |goto Undercity/0 55.95,37.35
|tip Smelt any ore you've gathered if you still aren't 20 Mining
|only if haveq(97959) or completedq(97959)
step
talk Alessandro Luca##7683
accept Prompt Potion Runner##97891 |goto Undercity/0 58.62,54.66
step
Follow the path down |goto Undercity/0 52.83,77.69 < 10 |walk
talk Doctor Martin Felben##11044
Speak to Doctor Martin Felben |q 97891/1 |goto Undercity/0 46.60,74.08
step
talk Doctor Martin Felben##11044
turnin Prompt Potion Runner##97891 |goto Undercity/0 46.60,74.08
step
talk Shelene Rhobart##3549
turnin Hides for the Forsaken##97558 |goto Tirisfal Glades/0 65.42,60.12
step
_Destroy This Item:_
|tip Not needed.
trash Inert Potion##279023
step
talk Deathguard Linnea##1495
turnin Forsaken Duties##359 |goto Tirisfal Glades/0 65.49,60.26
accept Return to the Magistrate##360 |goto Tirisfal Glades/0 65.49,60.26
accept Rear Guard Patrol##356 |goto Tirisfal Glades/0 65.49,60.26
step
talk Hadric Harlson##267009
turnin The Argent Emissary##96895 |goto Tirisfal Glades/0 65.93,61.11
step
click Gunther's Books
collect The Lich's Spellbook##2833 |q 357/1 |goto Tirisfal Glades/0 67.96,42.09
step
kill Vicious Night Web Spider##1555+
collect 4 Vicious Night Web Spider Venom##2872 |q 369/1 |goto Tirisfal Glades/0 86.29,51.41
stickystart "Kill_Scarlet_Friars"
step
kill Captain Vachon##1664 |q 371/1 |goto Tirisfal Glades 78.82,56.13
|tip Inside the building.
step
label "Kill_Scarlet_Friars"
kill 5 Scarlet Friar##1538 |q 371/2 |goto Tirisfal Glades/0 79.56,55.16
stickystart "Kill_Bleeding_Horrors_And_Wandering_Spirits"
step
click Balnir Snapdragons
collect Balnir Snapdragons##7227 |q 1882/1 |goto Tirisfal Glades/0 76.94,62.38
|only if Mage
step
click Tomb Weed+
|tip Withered purple plants.
collect 5 Tomb Weed##286204 |q 99142/1 |goto Tirisfal Glades/0 76.08,60.94
step
label "Collect_Linen_Cloth_Paladin"
kill Bleeding Horror##1529, Wandering Spirit##1532
collect 10 Linen Cloth##2589 |goto Tirisfal Glades/0 76.19,60.38 |q 94434 |future
|tip Needed for class quest soon.
|tip Don't vendor them.
|only if Paladin
step
label "Kill_Bleeding_Horrors_And_Wandering_Spirits"
kill 8 Bleeding Horror##1529 |q 356/1 |goto Tirisfal Glades/0 76.19,60.38
kill 8 Wandering Spirit##1532 |q 356/2 |goto Tirisfal Glades/0 76.19,60.38
step
talk Deathguard Linnea##1495
turnin Rear Guard Patrol##356 |goto Tirisfal Glades 65.49,60.25
step
talk Hadric Harlson##267009
accept The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
accept Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
stickystart "Kill_Dark_Neophytes_And_Dark_Enforcers"
step
kill Dark Enforcer##275437, Dark Neophyte##267006
click Naxxramas Crystal Fragment+
|tip Black crystals.
collect 12 Necrotic Crystal Fragment##275851 |q 96898/1 |goto Tirisfal Glades/0 68.26,64.73
step
label "Kill_Dark_Neophytes_And_Dark_Enforcers"
kill 8 Dark Neophyte##267006 |q 96897/1 |goto Tirisfal Glades/0 68.26,64.73
kill 8 Dark Enforcer##275437 |q 96897/2 |goto Tirisfal Glades/0 68.26,64.73
step
talk Hadric Harlson##267009
turnin The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
turnin Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
accept Bandarion Keep##96899 |goto Tirisfal Glades/0 65.93,61.11
step
talk Bethor Iceshard##1498
|tip Up on the stairs.
turnin The Lich's Identity##357 |goto Undercity/0 84.05,17.46
accept Return the Book##366 |goto Undercity/0 84.05,17.46
step
talk Magistrate Sevren##1499
|tip Inside the building.
turnin Speak with Sevren##355 |goto Tirisfal Glades 61.26,50.84
turnin Return to the Magistrate##360 |goto Tirisfal Glades 61.26,50.84
step
talk Faruza##2114
turnin Camping 101: Herbalism##97957 |goto Tirisfal Glades/0 59.81,52.05
|only if haveq(97957) or completedq(97957)
step
talk Executor Zygand##1515
turnin At War With The Scarlet Crusade##371 |goto Tirisfal Glades 60.58,51.77
step
talk Apothecary Johaan##1518
|tip Inside the building.
turnin A New Plague##369 |goto Tirisfal Glades 59.45,52.40
accept A New Plague##492 |goto Tirisfal Glades 59.45,52.40
step
talk Carolai Anise##2132
|tip Inside the building.
accept That Shadowvale Green Elixir##95314 |goto Tirisfal Glades/0 59.43,52.19
step
map Tirisfal Glades/0
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	59.25,46.73	59.10,47.09	58.81,47.44	58.51,47.71	58.17,47.95
path	57.87,48.13	57.68,48.41	57.59,48.81	57.67,48.97	57.67,49.36
path	57.85,49.63	58.13,49.74	58.29,49.90	58.31,50.42	58.20,49.75
path	57.84,49.62	57.62,49.30	57.50,49.33	57.36,49.22	57.37,48.96
path	57.59,48.71
talk Junior Apothecary Holland##10665
|tip Walks a large path.
turnin Tomb Weed##99142
step
talk Captured Mountaineer##2211
|tip Downstairs inside the building.
turnin A New Plague##492 |goto Tirisfal Glades 61.94,51.40
step
talk Gunther Arcanus##1497
turnin Return the Book##366 |goto Tirisfal Glades/0 68.20,41.92
accept Proving Allegiance##409 |goto Tirisfal Glades/0 68.20,41.92
step
click Crate of Candles
|tip Complete the {o}Candles of Beckoning{} quest.
collect Candle of Beckoning##3080 |goto Tirisfal Glades/0 68.16,42.02 |q 409
step
click Lillith's Dinner Table
|tip Complete {o}The Dormant Shade{} quest.
kill Lillith Nefara##1946 |q 409/1 |goto Tirisfal Glades/0 66.64,44.88
step
talk Gunther Arcanus##1497
turnin Proving Allegiance##409 |goto Tirisfal Glades/0 68.20,41.92
accept The Prodigal Lich Returns##411 |goto Tirisfal Glades/0 68.20,41.92
step
talk Austil de Mon##2131
|tip Inside the building.
Train Abilities |trainer Austil de Mon##2131 |goto Tirisfal Glades/0 61.86,52.54 |q 96899
|only if Warrior
step
talk Cain Firesong##2128
|tip Upstairs inside the building.
Train Abilities |trainer Cain Firesong##2128 |goto Tirisfal Glades/0 61.97,52.47 |q 96899
|only if Mage
step
talk Rupert Boch##2127
|tip Upstairs inside the building.
Train Abilities |trainer Rupert Boch##2127 |goto Tirisfal Glades/0 61.59,52.40 |q 96899
|only if Warlock
step
talk Gina Lang##5750
|tip Upstairs inside the building.
Train Demon Abilities |vendor Gina Lang##5750 |goto Tirisfal Glades/0 61.55,52.61 |q 96899
|only if Warlock
step
talk Dark Cleric Beryl##2129
|tip Upstairs inside the building.
Train Abilities |trainer Dark Cleric Beryl##2129 |goto Tirisfal Glades/0 61.57,52.20 |q 96899
|only if Priest
step
talk Marion Call##2130
|tip Upstairs inside the building.
Train Abilities |trainer Marion Call##2130 |goto Tirisfal Glades/0 61.75,52.00 |q 96899
|only if Rogue
step
talk Shari Stilwell##246152
accept A Second Home##91282 |goto Tirisfal Glades/0 60.23,52.67
|only if Paladin
step
talk Shari Stilwell##246152
Train Abilities |trainer Shari Stilwell##246152 |goto Tirisfal Glades/0 60.23,52.68 |q 370
|only if Paladin
step
talk Thatog##268701
|tip {o}Top floor{} inside the building.
accept Meal Appeal##97246 |goto Orgrimmar/0 55.58,72.19
|only if not Paladin
step
talk Doras##3310
|tip Top of the tower.
fpath Orgrimmar |goto Orgrimmar 45.13,63.90
|only if not Paladin
step
Run up the stairs |goto Orgrimmar/0 56.40,56.75 < 15 |only if walking
talk Borstan##3368
|tip Inside the building.
turnin Meal Appeal##97246 |goto Orgrimmar/0 57.19,53.33
accept Favorite Food##97249 |goto Orgrimmar/0 57.19,53.33
|only if not Paladin
step
talk Kor'geld##3348
|tip Inside the building.
accept Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if not Paladin
stickystart "Collect_Speargrass_Cuttings"
step
click Cattail+
|tip Long brown plants.
collect 2 Handful of Cattails##277278 |q 97242/1 |goto Orgrimmar/0 67.79,30.26
|only if not Paladin
step
label "Collect_Speargrass_Cuttings"
click Speargrass+
|tip Green grass.
collect 4 Speargrass Cuttings##277279 |q 97242/2 |goto Orgrimmar/0 67.79,30.26
|only if not Paladin
step
talk Kor'geld##3348
|tip Inside the building.
turnin Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if not Paladin
step
talk Yelmak##3347
|tip Walks around.
|tip Inside the building.
accept Whuut's the Rush##97275 |goto Orgrimmar/0 56.84,33.03
|tip May need to wait.
|only if not Paladin
step
talk Whuut##11046
|tip Inside the building.
turnin Whuut's the Rush##97275 |goto Orgrimmar/0 55.80,32.90
|only if not Paladin
step
talk Migi##268682
|tip Outside the building.
turnin Favorite Food##97249 |goto Orgrimmar/0 36.55,29.10
|only if not Paladin
step
talk Thra##268684
|tip Outside the building.
accept Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
|only if not Paladin
step
click Smooth Boulder+
|tip Brown rocks.
collect 8 Smooth Boulder##277952 |q 97326/1 |goto Orgrimmar/0 43.83,34.70
|only if not Paladin
step
talk Thra##268684
|tip Outside the building.
turnin Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
|only if not Paladin
step
talk Rezlak##3293
accept Winds in the Desert##834 |goto Durotar 46.37,22.94
|only if not Paladin
step
click Stolen Supply Sack+
|tip Tan bags.
collect 5 Sack of Supplies##4918 |q 834/1 |goto Durotar/0 49.62,22.97
|mapmarker Durotar/0 48.41,32.44
|only if not Paladin
step
talk Rezlak##3293
turnin Winds in the Desert##834 |goto Durotar 46.37,22.94
|only if not Paladin
step
_NOTE:_
During the Next Steps
|tip You will take the zeppelin to Tirisfal Glades.
|tip Jump down into the water almost immediately.
|tip Allows you to travel to quests faster.
Click Here to Continue |confirm |q 96899
|only if not Paladin
step
Ride the Zeppelin to Tirisfal Glades |complete zone("Tirisfal Glades") |goto Durotar/0 50.83,13.79 |q 96899
|tip Top of the tower.
|only if not Paladin
step
talk Breton Samuels##246349
|tip Inside the building.
|tip Follow the road.
turnin A Second Home##91282 |goto Tirisfal Glades/0 21.85,45.21
accept Murlocs at the Gates##91285 |goto Tirisfal Glades/0 21.85,45.21
|only if Paladin
step
talk Leonid Barthalomew the Revered##267008
|tip Upstairs inside the building.
|tip Follow the road.			|only if not Paladin
turnin Bandarion Keep##96899 |goto Tirisfal Glades/0 22.03,44.73
accept A Righteous Cause##96896 |goto Tirisfal Glades/0 22.03,44.73
step
talk Leonid Barthalomew the Revered##267008
|tip Upstairs inside the building.
turnin A Righteous Cause##96896 |goto Tirisfal Glades/0 22.03,44.73
accept Leonid's Letter##98545 |goto Tirisfal Glades/0 22.03,44.73
step
talk Danitha Morr##246378
|tip Upstairs inside the building.
accept A Lesson in Divinity##94427 |goto Tirisfal Glades/0 22.09,44.66
|only if Paladin
step
talk Ephram Barbaro##259190
accept The One That Got Away##99153 |goto Tirisfal Glades/0 20.16,46.49
step
talk Hilda the Breaker##246389
|tip Walks around.
accept As Above, So Below##99152 |goto Tirisfal Glades/0 22.05,47.14
step
kill 8 Vile Fin Attacker##250283 |q 91285/1 |goto Tirisfal Glades/0 14.68,54.75
kill 8 Vile Fin Seer##250282 |q 91285/2 |goto Tirisfal Glades/0 14.68,54.75
|only if Paladin
stickystart "Collect_Faintly_Glowing_Bones"
stickystart "Collect_Bottles_Of_Whispering_Elixirs"
step
Enter the crypt |goto Tirisfal Glades/0 12.90,65.73 < 10 |walk |only if not (subzone("Shadowvale") and indoors())
click Glowing Crystal Fragment
|tip Inside the crypt.
collect Glowing Crystal Fragment##286269 |q 99153/1 |goto Tirisfal Glades/0 9.75,69.39
step
label "Collect_Faintly_Glowing_Bones"
kill Shadowvale Lurcher##260428, Shadowvale Mystic##260430
|tip Inside the crypt. |notinsticky
collect 6 Faintly Glowing Bone##286259 |q 99152/1 |goto Tirisfal Glades/0 10.09,66.23
step
label "Collect_Bottles_Of_Whispering_Elixirs"
click Bottle+
|tip Green glass bottles.
|tip Inside the crypt. |notinsticky
collect 8 Bottle of Whispering Elixir##268801 |q 95314/1 |goto Tirisfal Glades/0 10.09,66.23
step
Leave the crypt |goto Tirisfal Glades/0 12.90,65.73 < 10 |walk |only if subzone("Shadowvale") and indoors()
talk Hilda the Breaker##246389
|tip Walks around.
turnin As Above, So Below##99152 |goto Tirisfal Glades/0 21.95,47.24
step
talk Breton Samuels##246349
|tip Inside the building.
turnin Murlocs at the Gates##91285 |goto Tirisfal Glades/0 21.85,45.21
accept Touring the Grounds##91294 |goto Tirisfal Glades/0 21.85,45.21
|only if Paladin
step
click Jorin Croge##246393
|tip Inside the building.
Speak with Jorin Croge |q 91294/2 |goto Tirisfal Glades/0 22.70,44.68
|only if Paladin
step
talk Ephram Barbaro##259190
turnin The One That Got Away##99153 |goto Tirisfal Glades/0 20.16,46.49
step
talk Hilda the Breaker##246389
|tip Walks around.
Speak with Hilda the Breaker |q 91294/1 |goto Tirisfal Glades/0 21.95,47.24
|only if Paladin
step
click Ander Solliden##246394
Speak with Ander Solliden |q 91294/3 |goto Tirisfal Glades/0 25.41,50.41
|only if Paladin
step
talk Danitha Morr##246378
|tip Upstairs inside the building.
Speak with Danitha Morr |q 91294/4 |goto Tirisfal Glades/0 22.09,44.66
|only if Paladin
step
talk Danitha Morr##246378
|tip Upstairs inside the building.
turnin Touring the Grounds##91294 |goto Tirisfal Glades/0 22.09,44.66
accept The Tarnished##91317 |goto Tirisfal Glades/0 22.09,44.66
|only if Paladin
step
talk Jorin Croge##246393
|tip Inside the building.
accept Making Repairs##91316 |goto Tirisfal Glades/0 22.70,44.68
|only if Paladin
step
Enter the crypt |goto Tirisfal Glades/0 12.90,65.73 < 10 |walk |only if not (subzone("Shadowvale") and indoors())
click Lumber Pile+
|tip Wooden boards.
|tip Inside the crypt.
collect 12 Sturdy Lumber##246213 |q 91316/1 |goto Tirisfal Glades/0 10.42,65.69
|only if Paladin
stickystart "Kill_Tarnished_Enemies"
step
Leave the crypt |goto Tirisfal Glades/0 12.90,65.73 < 10 |walk |only if subzone("Shadowvale") and indoors()
kill Rudolph Gelhardt##259431
|tip Walks around.
|tip Upstairs inside the building.
collect Rudolph Gelhardt's Head##270435 |q 91317/1 |goto Tirisfal Glades/0 11.53,64.21
|only if Paladin
step
label "Kill_Tarnished_Enemies"
kill 6 Tarnished Zealot##259433 |q 91317/3 |goto Tirisfal Glades/0 12.87,63.45
kill 8 Tarnished Drudge##259434 |q 91317/2 |goto Tirisfal Glades/0 12.87,63.45
|only if Paladin
step
talk Jorin Croge##246393
|tip Inside the building.
turnin Making Repairs##91316 |goto Tirisfal Glades/0 22.70,44.68
|only if Paladin
step
talk Danitha Morr##246378
|tip Upstairs inside the building.
turnin The Tarnished##91317 |goto Tirisfal Glades/0 22.09,44.66
accept A Token of Good Faith##95803 |goto Tirisfal Glades/0 22.09,44.66
|only if Paladin
step
talk Carolai Anise##2132
|tip Inside the building.
turnin That Shadowvale Green Elixir##95314 |goto Tirisfal Glades/0 59.43,52.20
step
talk Apothecary Johaan##1518
|tip Inside the building.
accept Delivery to Silverpine Forest##445 |goto Tirisfal Glades 59.45,52.40
step
talk Glix Xizzix##272526
turnin Leonid's Letter##98545 |goto Undercity/0 70.04,47.30
step
talk Tanis Alderwood##257648
turnin A Lesson in Divinity##94427 |goto Undercity/0 65.45,37.47
accept A Lesson in Divinity##94434 |goto Undercity/0 65.45,37.47
|only if Paladin
step
talk Tanis Alderwood##257648
turnin A Lesson in Divinity##94434 |goto Undercity/0 65.45,37.47
|only if Paladin
step
talk Bethor Iceshard##1498
|tip Up on the stairs.
turnin The Prodigal Lich Returns##411 |goto Undercity/0 84.05,17.46
step
talk Anastasia Hartwell##4568
|tip Upstairs inside the building.
turnin The Balnir Farmstead##1882 |goto Undercity/0 85.14,10.03
|only if Mage
step
Follow the path down |goto Undercity/0 52.18,64.37 < 15 |walk
talk Lady Sylvanas Windrunner##10181
turnin A Token of Good Faith##95803 |goto Undercity/0 58.06,91.78
step
map Tirisfal Glades
path follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	61.56,53.14	61.60,53.36	61.64,53.56	61.57,53.84	61.82,54.60
path	62.06,55.15	62.24,55.46	62.42,55.59	62.71,55.62	63.02,55.65
path	63.20,55.82	63.39,56.32	63.63,57.16	63.72,57.75	63.73,58.47
path	63.69,58.86	63.50,59.59	63.34,59.98	63.08,60.39	62.40,61.00
path	61.63,61.79	61.26,62.15	60.75,62.60	59.92,63.22	59.23,63.78
path	58.78,64.10	58.37,64.30	57.47,64.66	56.86,65.04	56.39,65.51
path	56.04,66.14	55.90,66.56	55.56,68.13	55.35,69.34	55.30,69.84
path	55.13,70.67	54.93,72.43	54.64,74.02	54.35,75.15
map Silverpine Forest
path	67.83,4.94	67.37,5.83	66.52,7.07	65.77,7.97	64.60,8.89
path	63.41,9.66	62.98,9.99	61.82,10.67	60.88,11.21	59.11,11.78
path	58.05,12.22	57.29,12.76	56.66,13.46	55.50,15.32	54.85,16.58
path	53.91,18.70	53.06,20.64	52.04,22.17	51.32,23.71	50.64,25.30
path	50.22,26.19	49.98,26.95	49.74,28.76	49.74,30.13	49.67,32.29
path	49.73,33.04	49.97,33.84	50.33,34.49	50.69,35.08	50.99,35.71
path	51.12,36.33	51.04,36.69	50.57,37.18	49.83,37.76	49.08,38.27
path	48.38,38.77	48.01,39.14	47.50,39.80
talk Astor Hadren##6497
|tip Undead.
Select _"You're Astor Hadren, right?"_
Select _"You've got something I need, Astor. And I'll be taking it now."_
kill Astor Hadren##6497
|tip Walks the road between {o}Brill{} and {o}The Sepulcher{}.
collect Astor's Letter of Introduction##7231 |q 1886/1
Spawns near The Sepulcher at [Silverpine Forest/0 47.50,39.80] |noway
|only if Rogue
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Tauren Starter (1-13)",{
image=ZGV.IMAGESDIR.."Mulgore",
condition_suggested=function() return raceclass('Tauren') and level <= 13 end,
condition_suggested_exclusive=true,
condition_visible=function() return Tauren end,
linked = {"Leveling Guides\\Hidden Guides"},
linkedhidden = true,
hardcore = true,
next="Leveling Guides\\Silverpine Forest (13-15)",
},[[
defaultfor Tauren
step
_NOTE:_
Wrong Character Race
|tip Guide written for {o}Tauren{} characters.
|tip Other races may encounter issues.
Click Here to Continue |confirm
|only if not Tauren
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948 |q 1656 |future
|only if not hardcore()
step
_NOTE:_
Manage Your Ammo
|tip Make sure you always have ammo.
|tip You need it to attack enemies.
|tip {o}General Goods{} vendors sell it (also Bow & Gun vendors).
|tip Try to keep your ammo bag full.
Click Here to Continue |confirm |q 747 |future
|only if Hunter
step
kill Plainstrider##2955+
|tip Loot items worth at least {o}10 copper{} to sell.
|tip Allows training an ability early.
|tip Increases leveling speed.
Click Here to Continue |confirm |goto Mulgore 44.91,80.95 |q 747 |future
|mapmarker Mulgore/0 42.41,76.95
|mapmarker Mulgore/0 42.41,80.28
|mapmarker Mulgore/0 43.24,84.11
|mapmarker Mulgore/0 43.91,86.78
|mapmarker Mulgore/0 44.91,74.95
|mapmarker Mulgore/0 45.91,84.78
|mapmarker Mulgore/0 47.07,82.28
|mapmarker Mulgore/0 47.24,75.95
|mapmarker Mulgore/0 47.91,79.78
|mapmarker Mulgore/0 48.41,85.61
|mapmarker Mulgore/0 49.24,77.61
|mapmarker Mulgore/0 50.07,74.95
|mapmarker Mulgore/0 50.07,81.28
|mapmarker Mulgore/0 50.41,83.95
|mapmarker Mulgore/0 52.07,86.11
|only if Warrior or Shaman
step
talk Kawnie Softbreeze##3072
|tip Inside the building.
Sell Items |vendor Kawnie Softbreeze##3072 |goto Mulgore/0 44.82,77.05 |q 747 |future
|only if Warrior or Shaman
step
talk Grull Hawkwind##2980
accept The Hunt Begins##747 |goto Mulgore/0 44.47,77.51
step
talk Meela Dawnstrider##3062
|tip Inside the building.
Train Abilities |trainer Meela Dawnstrider##3062 |goto Mulgore/0 44.59,76.57 |q 747
|only if Shaman
step
talk Chief Hawkwind##2981
|tip Inside the building.
accept A Humble Task##752 |goto Mulgore/0 43.89,76.66
step
talk Harutt Thunderhorn##3059
|tip Inside the building.
Train Abilities |trainer Harutt Thunderhorn##3059 |goto Mulgore/0 43.75,76.72 |q 752
|only if Warrior
stickystart "Collect_Plainstrider_Meat_And_Feathers"
step
talk Greatmother Hawkwind##2991
turnin A Humble Task##752 |goto Mulgore/0 48.77,80.91
accept A Humble Task##753 |goto Mulgore/0 48.77,80.91
step
use Pelt Collecting for Beginners##247846
Learn Skinning |skillmax Skinning,75
|only if itemcount(247846) > 0
step
use Wild Harvest##247841
Learn Herbalism |skillmax Herbalism,75
|only if itemcount(247841) > 0
step
use Mining for Dummies##247840
Learn Mining |skillmax Mining,75
|only if itemcount(247840) > 0
step
click Water Pitcher
collect Water Pitcher##4755 |q 753/1 |goto Mulgore/0 48.92,81.08
step
label "Collect_Plainstrider_Meat_And_Feathers"
kill Plainstrider##2955+
collect 7 Plainstrider Meat##4739 |q 747/1 |goto Mulgore/0 46.75,79.84
collect 7 Plainstrider Feather##4740 |q 747/2 |goto Mulgore/0 46.75,79.84
step
talk Grull Hawkwind##2980
turnin The Hunt Begins##747		|goto Mulgore/0 44.47,77.51
accept The Hunt Continues##750		|goto Mulgore/0 44.47,77.51
accept Simple Note##3091		|goto Mulgore/0 44.47,77.51		|only Warrior
accept Rune-Inscribed Note##3093	|goto Mulgore/0 44.47,77.51		|only Shaman
accept Etched Note##3092		|goto Mulgore/0 44.47,77.51		|only Hunter
accept Verdant Note##3094		|goto Mulgore/0 44.47,77.51		|only Druid
step
talk Meela Dawnstrider##3062
|tip Inside the building.
turnin Rune-Inscribed Note##3093 |goto Mulgore 44.58,76.56
|only if Shaman
step
talk Gart Mistrunner##3060
|tip Inside the building.
turnin Verdant Note##3094 |goto Mulgore 44.65,76.56
|only if Druid
step
talk Gart Mistrunner##3060
|tip Inside the building.
Train Abilities |trainer Gart Mistrunner##3060 |goto Mulgore 44.65,76.56 |q 753
|only if Druid
step
talk Chief Hawkwind##2981
|tip Inside the building.
turnin A Humble Task##753 |goto Mulgore 43.89,76.66
accept Rites of the Earthmother##755 |goto Mulgore 43.89,76.66
step
talk Harutt Thunderhorn##3059
|tip Inside the building.
turnin Simple Note##3091 |goto Mulgore 43.75,76.72
|only if Warrior
step
talk Lanka Farshot##3061
|tip Inside the building.
turnin Etched Note##3092 |goto Mulgore 43.96,76.36
|only if Hunter
step
talk Lanka Farshot##3061
|tip Inside the building.
Train Abilities |trainer Lanka Farshot##3061 |goto Mulgore 43.96,76.36 |q 755
|only if Hunter
step
talk Kawnie Softbreeze##3072
buy Skinning Knife##7005 |goto Mulgore/0 44.82,77.04 |q 755
buy Apprentice's Skinning Satchel##277114 |goto Mulgore/0 44.82,77.04 |q 755
|only if skillmax("Skinning") > 1
step
talk Kawnie Softbreeze##3072
buy Apprentice's Herb Pouch##277113 |goto Mulgore/0 44.82,77.04 |q 755
|only if skillmax("Herbalism") > 1
step
talk Kawnie Softbreeze##3072
buy Mining Pick##2901 |goto Mulgore/0 44.82,77.04 |q 755
buy Apprentice's Mining Pack##277115 |goto Mulgore/0 44.82,77.04 |q 755
|only if skillmax("Mining") > 1
stickystart "Collect_Mountain_Cougar_Pelts"
step
talk Seer Graytongue##2982
turnin Rites of the Earthmother##755 |goto Mulgore/0 42.55,90.12
accept Rite of Strength##757 |goto Mulgore/0 42.55,90.12
accept Grace of An'she and Mu'sha##95805 |goto Mulgore/0 42.55,90.12
step
click Ritual Fire
turnin Grace of An'she and Mu'sha##95805 |goto Mulgore/0 56.62,88.69
step
label "Collect_Mountain_Cougar_Pelts"
kill Mountain Cougar##2961+
collect 10 Mountain Cougar Pelt##4742 |q 750/1 |goto Mulgore/0 48.00,88.55
step
Kill enemies
|tip Helps reach level 4 after quest turnins.
ding 3,1150 |goto Mulgore/0 48.00,88.55
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Mulgore/0 56.36,88.69 |q 750
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Mulgore/0 42.61,78.36 |q 750 |zombiewalk
|only if not hardcore()
step
talk Grull Hawkwind##2980
turnin The Hunt Continues##750 |goto Mulgore/0 44.47,77.51
accept The Battleboars##780 |goto Mulgore/0 44.47,77.51
step
talk Brave Windfeather##3209
|tip Walks around.
accept Break Sharptusk!##3376 |goto Mulgore/0 44.52,77.48
step
talk Seer Ravenfeather##5888
accept Call of Earth##1519 |goto Mulgore 44.35,76.76
|only if Shaman
step
talk Meela Dawnstrider##3062
|tip Inside the building.
Train Abilities |trainer Meela Dawnstrider##3062 |goto Mulgore/0 44.58,76.56 |q 3376
|only if Shaman
step
talk Harutt Thunderhorn##3059
|tip Inside the building.
Train Abilities |trainer Harutt Thunderhorn##3059 |goto Mulgore 43.75,76.72 |q 3376
|only if Warrior
step
talk Gart Mistrunner##3060
|tip Inside the building.
Train Abilities |trainer Gart Mistrunner##3060 |goto Mulgore 44.65,76.56 |q 3376
|only if Druid
step
talk Lanka Farshot##3061
|tip Inside the building.
Train Abilities |trainer Lanka Farshot##3061 |goto Mulgore 43.96,76.36 |q 3376
|only if Hunter
step
kill Battleboar##2966+
collect 8 Battleboar Snout##4848 |q 780/1 |goto Mulgore/0 53.00,80.59
collect 8 Battleboar Flank##4849 |q 780/2 |goto Mulgore/0 53.00,80.59
stickystart "Collect_Ritual_Salves_Shaman"
stickystart "Collect_Bristleback_Belts"
step
Run through the tunnel |goto Mulgore 55.53,84.13 < 15 |only if walking and not subzone("Brambleblade Ravine")
kill Chief Sharptusk Thornmantle##8554
|tip Inside the building.
collect Chief Sharptusk Thornmantle's Head##10459 |q 3376/1 |goto Mulgore 60.99,78.00
step
click Dirt-stained Map
|tip Inside the small cave.
collect Dirt-stained Map##4851 |n
use Dirt-stained Map##4851
accept Attack on Camp Narache##781 |goto Mulgore 59.77,82.20
step
label "Collect_Ritual_Salves_Shaman"
kill Bristleback Shaman##2953+
|tip Uncommon and spread out.
collect 2 Ritual Salve##6634 |q 1519/1 |goto Mulgore/0 59.77,78.86
|only if Shaman
step
label "Collect_Bristleback_Belts"
kill Bristleback Quilboar##2952, Bristleback Shaman##2953
|tip Quilboars.
collect 12 Bristleback Belt##4770 |q 757/1 |goto Mulgore/0 59.77,78.86
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Mulgore/0 59.77,78.86 |q 757
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Mulgore/0 42.61,78.36 |q 757 |zombiewalk
|only if not hardcore()
step
use Hearthstone##6948
Hearth to Camp Narache |complete subzone("Camp Narache") |q 757
|only if subzone("Brambleblade Ravine") and hardcore()
step
talk Grull Hawkwind##2980
turnin The Battleboars##780 |goto Mulgore/0 44.47,77.51
step
talk Brave Windfeather##3209
|tip Walks around.
turnin Break Sharptusk!##3376 |goto Mulgore/0 44.52,77.48
step
talk Chief Hawkwind##2981
|tip Inside the building.
turnin Attack on Camp Narache##781 |goto Mulgore 43.89,76.66
turnin Rite of Strength##757 |goto Mulgore 43.89,76.66
accept Rites of the Earthmother##763 |goto Mulgore 43.89,76.66
accept The Adventurer##96659 |goto Mulgore 43.89,76.66
step
talk Seer Ravenfeather##5888
turnin Call of Earth##1519 |goto Mulgore 44.35,76.77
accept Call of Earth##1520 |goto Mulgore 44.35,76.77
|only if Shaman
step
talk Meela Dawnstrider##3062
|tip Inside the building.
Train Abilities |trainer Meela Dawnstrider##3062 |goto Mulgore/0 44.58,76.56 |q 763
|only if Shaman
step
use Earth Sapta##6635
talk Minor Manifestation of Earth##5891
turnin Call of Earth##1520 |goto Mulgore/0 51.93,80.43
accept Call of Earth##1521 |goto Mulgore/0 51.93,80.43
|only if Shaman
step
talk Seer Ravenfeather##5888
turnin Call of Earth##1521 |goto Mulgore 44.35,76.77
|only if Shaman
step
kill Plainstrider##2955+
|tip Skin them.
skill Skinning,20 |goto Mulgore/0 46.75,79.84 |q 97936 |future
|tip Needed for quest soon.
|only if skillmax("Skinning") >= 1
step
talk Antur Fallow##6775
|tip Follow the road.
accept A Task Unfinished##1656 |goto Mulgore 39.17,81.25
step
talk Kaga Wildhoof##265810
turnin The Adventurer##96659 |goto Mulgore/0 46.18,67.22
accept The Great Outdoors##96605 |goto Mulgore/0 46.18,67.22
step
Watch the dialogue
Use the {y}/sit{} Emote Near the Campfire |q 96605/1 |goto Mulgore/0 46.18,67.22 |macro /sit
Gain the Boosted Rest Buff |q 96605/2 |goto Mulgore/0 46.18,67.22
|tip Takes {o}1 minute{}.
step
talk Kaga Wildhoof##265810
turnin The Great Outdoors##96605		|goto Mulgore/0 46.18,67.22
accept Camping 101: Cooking##96661		|goto Mulgore/0 46.18,67.22
accept Camping 101: Skinning##97936		|goto Mulgore/0 46.18,67.22 |only if skillmax("Skinning") >= 1
step
talk Ruul Eagletalon##2985
accept Dangers of the Windfury##743 |goto Mulgore/0 46.54,64.96
step
talk Baine Bloodhoof##2993
turnin Rites of the Earthmother##763 |goto Mulgore/0 46.67,63.42
accept Sharing the Land##745 |goto Mulgore/0 46.67,63.42
accept Rite of Vision##767 |goto Mulgore/0 46.67,63.42
accept Dwarven Digging##746 |goto Mulgore/0 46.67,63.42
step
talk Innkeeper Kauth##6747
|tip Inside the building.
turnin A Task Unfinished##1656 |goto Mulgore/0 45.92,64.19
step
talk Vira Younghoof##5939
|tip Inside the building.
Learn First Aid |skillmax First Aid,75 |goto Mulgore/0 46.08,63.96
|only if Warrior
step
_NOTE:_
Create Bandages in Downtime
|tip While waiting for things like boats.
|tip Increases skill in First Aid.
|tip Need higher skill to make better bandages.
|tip Keep bandages to heal yourself.
Click Here to Continue |confirm |q 96661
|only if Warrior
step
talk Pyall Silentstride##3067
|tip Inside the building.
Select _"Train me."_ |gossip 96866
Learn Cooking from Pyall Silentstride in Bloodhoof Village |q 96661/1 |goto Mulgore/0 44.92,61.67
step
talk Pyall Silentstride##3067
|tip Inside the building.
turnin Camping 101: Cooking##96661 |goto Mulgore/0 44.92,61.67
step
talk Yonn Deepcut##6290
|tip Inside the building.
turnin Camping 101: Skinning##97936 |goto Mulgore/0 44.97,61.40
step
talk Maur Raincaller##3055
accept Mazzranache##766 |goto Mulgore/0 46.23,60.81
step
talk Yaw Sharpmane##3065
accept Chakuyak##96130 |goto Mulgore/0 46.93,59.65
step
talk Yaw Sharpmane##3065
Train Abilities |trainer Yaw Sharpmane##3065 |goto Mulgore/0 46.93,59.65 |q 767
|only if Hunter
step
talk Zarlman Two-Moons##3054
turnin Rite of Vision##767 |goto Mulgore/0 46.88,61.19
accept Rite of Vision##771 |goto Mulgore/0 46.88,61.19
step
talk Narm Skychaser##3066
|tip Inside the building.
Train Abilities |trainer Narm Skychaser##3066 |goto Mulgore/0 47.40,62.55 |q 99108 |future
|only if Shaman
step
talk Harken Windtotem##2947
|tip Inside the building.
accept Swoop Hunting##761 |goto Mulgore/0 47.67,62.69
step
talk Gennia Runetotem##3064
|tip Inside the building.
Train Abilities |trainer Gennia Runetotem##3064 |goto Mulgore/0 47.48,62.95 |q 99108 |future
|only if Druid
step
talk Krang Stonehoof##3063
accept Sparring Match##99108 |goto Mulgore/0 48.34,63.74
step
talk Krang Stonehoof##3063
Train Abilities |trainer Krang Stonehoof##3063 |goto Mulgore/0 48.34,63.77 |q 99108
|only if Warrior
step
talk Novice Warrior##10721+
Select _"I challenge you."_ |gossip 142701
kill Novice Warrior##10721+
Defeat #3# Novice Warriors |q 99108/1 |goto Mulgore/0 48.67,63.72
step
talk Krang Stonehoof##3063
turnin Sparring Match##99108 |goto Mulgore/0 48.34,63.74
step
talk Mull Thunderhorn##2948
accept Poison Water##748 |goto Mulgore/0 47.52,63.58
stickystart "Collect_Ambercorns"
stickystart "Collect_Prairie_Wolf_Items"
stickystart "Collect_Plainstrider_Items"
stickystart "Collect_Swoop_Items"
step
kill Chakuyak##268558
|tip Black wolf.
|tip Walks around.
collect Chakuyak's Pelt##270302 |q 96130/1 |goto Mulgore/0 39.80,65.20
|mapmarker Mulgore/0 38.80,62.20
|mapmarker Mulgore/0 39.40,67.20
step
label "Collect_Ambercorns"
click Ambercorn+
|tip Small brown pinecones.
|tip Near trees.
collect 2 Ambercorn##4809 |q 771/2 |goto Mulgore/0 39.49,63.11
|mapmarker Mulgore/0 36.57,61.28
|mapmarker Mulgore/0 38.24,70.28
|mapmarker Mulgore/0 39.49,66.36
|mapmarker Mulgore/0 39.49,72.78
|mapmarker Mulgore/0 41.07,56.11
|mapmarker Mulgore/0 41.32,57.95
|mapmarker Mulgore/0 41.41,66.61
|mapmarker Mulgore/0 42.24,60.28
|mapmarker Mulgore/0 42.74,71.78
|mapmarker Mulgore/0 43.41,73.53
|mapmarker Mulgore/0 44.07,69.20
|mapmarker Mulgore/0 44.32,54.20
|mapmarker Mulgore/0 44.41,71.78
|mapmarker Mulgore/0 44.91,56.86
|mapmarker Mulgore/0 46.91,70.11
|mapmarker Mulgore/0 47.66,66.95
|mapmarker Mulgore/0 49.07,68.61
|mapmarker Mulgore/0 49.66,72.45
|mapmarker Mulgore/0 50.07,66.11
|mapmarker Mulgore/0 50.41,64.11
|mapmarker Mulgore/0 51.24,74.61
|mapmarker Mulgore/0 51.66,61.53
|mapmarker Mulgore/0 53.49,68.78
|mapmarker Mulgore/0 53.74,65.20
|mapmarker Mulgore/0 54.32,74.11
|mapmarker Mulgore/0 54.74,71.53
|mapmarker Mulgore/0 55.16,67.28
|mapmarker Mulgore/0 56.91,69.11
step
label "Collect_Prairie_Wolf_Items"
kill Prairie Wolf##2958+
collect Prairie Wolf Heart##4804 |q 766/1 |goto Mulgore 40.74,64.78
collect 6 Prairie Wolf Paw##4758 |q 748/1 |goto Mulgore 40.74,64.78
step
label "Collect_Plainstrider_Items"
kill Adult Plainstrider##2956+
|tip Large walking birds.
collect Plainstrider Scale##4806	|q 766/3 |goto Mulgore 40.74,64.78
collect 4 Plainstrider Talon##4759	|q 748/2 |goto Mulgore 40.74,64.78
step
label "Collect_Swoop_Items"
kill Wiry Swoop##2969+
|tip Black birds.
|tip Uncommon and spread out.
collect Swoop Gizzard##4807 |q 766/4 |goto Mulgore 40.74,65.11
collect 8 Trophy Swoop Quill##4769 |q 761/1 |goto Mulgore 40.74,65.11
|mapmarker Mulgore/0 35.57,78.28
|mapmarker Mulgore/0 35.74,67.95
|mapmarker Mulgore/0 36.07,70.61
|mapmarker Mulgore/0 36.57,61.28
|mapmarker Mulgore/0 37.24,57.78
|mapmarker Mulgore/0 37.41,73.11
|mapmarker Mulgore/0 38.24,64.78
|mapmarker Mulgore/0 38.24,68.11
|mapmarker Mulgore/0 38.91,60.11
|mapmarker Mulgore/0 39.91,70.95
|mapmarker Mulgore/0 40.07,56.78
|mapmarker Mulgore/0 40.74,62.45
|mapmarker Mulgore/0 40.74,68.11
|mapmarker Mulgore/0 41.74,59.95
|mapmarker Mulgore/0 44.07,72.45
|mapmarker Mulgore/0 47.91,67.45
|mapmarker Mulgore/0 48.24,70.11
|mapmarker Mulgore/0 50.57,64.45
|mapmarker Mulgore/0 50.57,68.61
|mapmarker Mulgore/0 50.57,71.28
|mapmarker Mulgore/0 52.41,73.61
|mapmarker Mulgore/0 52.74,60.11
|mapmarker Mulgore/0 52.91,69.95
|mapmarker Mulgore/0 53.24,65.28
|mapmarker Mulgore/0 54.24,67.78
stickystart "Accept_Longwalker_Malah"
step
talk Mull Thunderhorn##2948
turnin Poison Water##748 |goto Mulgore/0 47.52,63.58
accept Winterhoof Cleansing##754 |goto Mulgore/0 47.52,63.58
step
talk Harken Windtotem##2947
|tip Inside the building.
turnin Swoop Hunting##761 |goto Mulgore/0 47.67,62.69
step
talk Yaw Sharpmane##3065
turnin Chakuyak##96130 |goto Mulgore/0 46.93,59.65
step
label "Accept_Longwalker_Malah"
map Mulgore
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	46.62,59.61	46.60,60.03	46.56,60.42	46.54,61.00	46.61,61.64
path	46.59,61.75	46.42,62.15	46.38,62.31	46.40,62.67	46.61,62.86
path	46.68,62.94	46.73,63.27	46.71,63.56	46.66,63.93	46.60,64.38
path	46.66,63.93	46.78,63.65	47.04,64.05	47.29,64.50	47.37,64.67
path	47.14,64.22	46.84,63.74	46.76,63.59	46.66,63.94	46.60,64.39
path	46.67,63.81	46.68,62.91	46.41,62.66	46.39,62.27	46.53,61.92
path	46.61,61.73	46.55,61.11	46.55,60.77	46.57,60.40	46.61,60.04
path	46.63,59.64	46.66,60.22	47.03,60.70	47.35,61.10	47.61,61.47
path	47.70,61.64	47.73,61.85	47.61,62.28	47.45,62.75	47.13,62.92
path	46.81,63.04	46.41,62.96	46.20,62.91	46.06,62.95	45.81,63.21
path	45.66,63.30	45.44,63.46	45.76,63.24	46.00,62.99	46.15,62.91
path	46.46,62.97	46.84,63.04	47.19,62.88	47.41,62.79	47.47,62.73
path	47.64,62.18	47.72,61.83	47.69,61.62	47.53,61.38	47.23,60.96
path	46.85,60.49	46.66,60.22	46.63,59.82	46.62,59.61
talk Brave Wildrunner##3222
|tip Walks a large path.
accept Longwalker Malah##99079
step
click Well Stone+
|tip Flat grey rocks.
collect 2 Well Stone##4808 |q 771/1 |goto Mulgore 51.66,68.45
step
use Winterhoof Cleansing Totem##5411
Cleanse the Winterhoof Water Well |q 754/1 |goto Mulgore 51.77,68.41
stickystart "Kill_Palemane_Skinners_And_Tanners"
step
kill 5 Palemane Poacher##2951 |q 745/3 |goto Mulgore/0 52.04,73.87
step
label "Kill_Palemane_Skinners_And_Tanners"
kill 8 Palemane Skinner##2950 |q 745/2 |goto Mulgore/0 52.04,73.87
kill 10 Palemane Tanner##2949 |q 745/1 |goto Mulgore/0 52.04,73.87
step
Kill enemies
|tip Helps reach level 8 after quest turnins.
ding 7,2625 |goto Mulgore/0 52.04,73.87
step
talk Mull Thunderhorn##2948
turnin Winterhoof Cleansing##754 |goto Mulgore/0 47.52,63.58
accept Thunderhorn Totem##756 |goto Mulgore/0 47.52,63.58
step
talk Baine Bloodhoof##2993
turnin Sharing the Land##745 |goto Mulgore/0 46.67,63.41
step
talk Zarlman Two-Moons##3054
turnin Rite of Vision##771 |goto Mulgore/0 46.88,61.20
accept Rite of Vision##772 |goto Mulgore/0 46.88,61.20
|tip Don't follow the wolf.
step
talk Yaw Sharpmane##3065
Train Abilities |trainer Yaw Sharpmane##3065 |goto Mulgore/0 46.93,59.65 |q 749 |future
|only if Hunter
step
talk Krang Stonehoof##3063
Train Abilities |trainer Krang Stonehoof##3063 |goto Mulgore/0 48.35,63.74 |q 749 |future
|only if Warrior
step
talk Gennia Runetotem##3064
|tip Inside the building.
Train Abilities |trainer Gennia Runetotem##3064 |goto Mulgore/0 47.48,62.95 |q 749 |future
|only if Druid
step
talk Narm Skychaser##3066
|tip Inside the building.
Train Abilities |trainer Narm Skychaser##3066 |goto Mulgore/0 47.40,62.55 |q 749 |future
|only if Shaman
stickystart "Collect_Cougar_Items"
stickystart "Collect_Stalker_Claws"
step
map Mulgore
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	50.36,62.96	51.31,63.51	52.77,63.73	53.90,64.16	54.88,64.31
path	56.84,65.32
talk Morin Cloudstalker##2988
|tip Walks along the road.
accept The Ravaged Caravan##749
step
clicknpc Malah Longwind##275789
turnin Longwalker Malah##99079 |goto Mulgore/0 57.62,63.18
accept Grim Tidings##99081 |goto Mulgore/0 57.62,63.18
step
click Sealed Supply Crate
turnin The Ravaged Caravan##749 |goto Mulgore 51.86,53.43
accept The Ravaged Caravan##751 |goto Mulgore 51.86,53.43
step
label "Collect_Cougar_Items"
kill Flatland Cougar##3035+
collect Flatland Cougar Femur##4805	|q 766/2	|goto Mulgore 49.57,47.28
collect 6 Cougar Claws##4802		|q 756/2	|goto Mulgore 49.57,47.28
step
label "Collect_Stalker_Claws"
kill Prairie Stalker##2959+
|tip Wolves.
collect 6 Stalker Claws##4801 |q 756/1 |goto Mulgore 49.57,47.28
step
Kill enemies
|tip Helps reach level 9 after quest turnins.
|tip Higher level enemies soon.
ding 8,3915 |goto Mulgore 49.57,47.28
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Mulgore 49.57,47.28 |q 766
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Mulgore 45.75,59.59 |q 766 |zombiewalk
|only if not hardcore()
stickystart "Accept_Our_Ancient_Enemy"
step
talk Maur Raincaller##3055
turnin Mazzranache##766 |goto Mulgore 46.22,60.84
step
talk Mull Thunderhorn##2948
turnin Thunderhorn Totem##756 |goto Mulgore 47.52,63.61
accept Thunderhorn Cleansing##758 |goto Mulgore 47.52,63.61
step
label "Accept_Our_Ancient_Enemy"
map Mulgore
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	46.62,59.61	46.60,60.03	46.56,60.42	46.54,61.00	46.61,61.64
path	46.59,61.75	46.42,62.15	46.38,62.31	46.40,62.67	46.61,62.86
path	46.68,62.94	46.73,63.27	46.71,63.56	46.66,63.93	46.60,64.38
path	46.66,63.93	46.78,63.65	47.04,64.05	47.29,64.50	47.37,64.67
path	47.14,64.22	46.84,63.74	46.76,63.59	46.66,63.94	46.60,64.39
path	46.67,63.81	46.68,62.91	46.41,62.66	46.39,62.27	46.53,61.92
path	46.61,61.73	46.55,61.11	46.55,60.77	46.57,60.40	46.61,60.04
path	46.63,59.64	46.66,60.22	47.03,60.70	47.35,61.10	47.61,61.47
path	47.70,61.64	47.73,61.85	47.61,62.28	47.45,62.75	47.13,62.92
path	46.81,63.04	46.41,62.96	46.20,62.91	46.06,62.95	45.81,63.21
path	45.66,63.30	45.44,63.46	45.76,63.24	46.00,62.99	46.15,62.91
path	46.46,62.97	46.84,63.04	47.19,62.88	47.41,62.79	47.47,62.73
path	47.64,62.18	47.72,61.83	47.69,61.62	47.53,61.38	47.23,60.96
path	46.85,60.49	46.66,60.22	46.63,59.82	46.62,59.61
talk Brave Wildrunner##3222
|tip Walks a large path.
turnin Grim Tidings##99081
accept Our Ancient Enemy##99101
step
talk Baine Bloodhoof##2993
turnin Our Ancient Enemy##99101 |goto Mulgore/0 46.67,63.41
accept Drive Them Out##99080 |goto Mulgore/0 46.67,63.41
step
map Mulgore
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	50.36,62.96	51.31,63.51	52.77,63.73	53.90,64.16	54.88,64.31
path	56.84,65.32
talk Morin Cloudstalker##2988
|tip Walks along the road.
turnin The Ravaged Caravan##751
accept The Venture Co.##764
stickystart "Kill_Galak_Outrunners_And_Centaurs"
step
kill Herak the Pillager##275767
|tip Inside the building.
collect Herak's Head##286075 |q 99080/3 |goto Mulgore/0 60.54,59.67
step
label "Kill_Galak_Outrunners_And_Centaurs"
kill 4 Galak Outrunner##2968 |q 99080/2 |goto Mulgore/0 61.40,61.51
kill 6 Galak Centaur##2967 |q 99080/1 |goto Mulgore/0 61.40,61.51
step
kill 6 Venture Co. Supervisor##2979 |q 764/2 |goto Mulgore 58.37,52.36
kill 14 Venture Co. Worker##2978 |q 764/1 |goto Mulgore 58.37,52.36
|tip Inside and outside the mine.
|tip Safer to stay outside, if possible.
step
Leave the mine |goto 58.37,52.36 < 15 |walk |only if subzone("The Venture Co. Mine") and indoors()
use Thunderhorn Cleansing Totem##5415
Cleanse the Thunderhorn Water Well |q 758/1 |goto Mulgore 44.23,51.14
step
Kill enemies
|tip Helps reach level 10 after quest turnins.
ding 9,4400 |goto Mulgore 49.57,47.28
step
talk Baine Bloodhoof##2993
turnin Drive Them Out##99080 |goto Mulgore/0 46.67,63.39
accept The High Chieftain##99082 |goto Mulgore/0 46.67,63.39
step
talk Mull Thunderhorn##2948
turnin Thunderhorn Cleansing##758 |goto Mulgore/0 47.52,63.59
accept Wildmane Totem##759 |goto Mulgore/0 47.52,63.59
step
map Mulgore
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	50.36,62.96	51.31,63.51	52.77,63.73	53.90,64.16	54.88,64.31
path	56.84,65.32
talk Morin Cloudstalker##2988
|tip Walks along the road.
turnin The Venture Co.##764
step
talk Krang Stonehoof##3063
Train Abilities |trainer Krang Stonehoof##3063 |goto Mulgore/0 48.35,63.74 |q 772
|only if Warrior
step
talk Narm Skychaser##3066
|tip Inside the building.
accept Call of Fire##2984 |goto Mulgore/0 47.40,62.55
|only if Tauren Shaman
step
talk Narm Skychaser##3066
|tip Inside the building.
Train Abilities |trainer Narm Skychaser##3066 |goto Mulgore/0 47.40,62.55 |q 772
|only if Shaman
step
talk Gennia Runetotem##3064
|tip Inside the building.
accept Heeding the Call##5928 |goto Mulgore/0 47.48,62.95
|only if Druid
step
talk Gennia Runetotem##3064
|tip Inside the building.
Train Abilities |trainer Gennia Runetotem##3064 |goto Mulgore/0 47.48,62.95 |q 772
|only if Druid
step
talk Skorn Whitecloud##3052
accept The Hunter's Way##861 |goto Mulgore/0 46.04,63.44
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 10 ammo when restocking.
Click Here to Continue |confirm |q 772
|only if Hunter
step
talk Yaw Sharpmane##3065
accept Taming the Beast##6061 |goto Mulgore/0 46.93,59.65
|only if Hunter
step
talk Yaw Sharpmane##3065
Train Abilities |trainer Yaw Sharpmane##3065 |goto Mulgore/0 46.93,59.65 |q 6061
|only if Hunter
step
use Taming Rod##15914
|tip On an Adult Plainstrider.
|tip Large walking birds.
Tame an Adult Plainstrider |q 6061/1 |goto Mulgore 41.91,58.61
|mapmarker Mulgore/0 34.57,76.78
|mapmarker Mulgore/0 35.41,73.78
|mapmarker Mulgore/0 36.24,57.11
|mapmarker Mulgore/0 36.24,70.28
|mapmarker Mulgore/0 36.57,59.61
|mapmarker Mulgore/0 36.57,62.78
|mapmarker Mulgore/0 37.07,67.78
|mapmarker Mulgore/0 37.07,76.45
|mapmarker Mulgore/0 37.74,72.78
|mapmarker Mulgore/0 38.24,65.28
|mapmarker Mulgore/0 38.91,53.11
|mapmarker Mulgore/0 38.91,57.78
|mapmarker Mulgore/0 39.07,62.78
|mapmarker Mulgore/0 39.07,70.61
|mapmarker Mulgore/0 39.41,75.11
|mapmarker Mulgore/0 39.91,60.11
|mapmarker Mulgore/0 40.24,55.45
|mapmarker Mulgore/0 40.57,68.11
|mapmarker Mulgore/0 41.07,72.78
|mapmarker Mulgore/0 40.74,64.78
|mapmarker Mulgore/0 43.57,73.11
|mapmarker Mulgore/0 44.91,70.95
|mapmarker Mulgore/0 47.41,70.28
|mapmarker Mulgore/0 49.24,68.45
|mapmarker Mulgore/0 49.41,72.11
|mapmarker Mulgore/0 51.24,64.45
|mapmarker Mulgore/0 51.24,70.11
|mapmarker Mulgore/0 51.91,67.11
|mapmarker Mulgore/0 51.91,72.95
|mapmarker Mulgore/0 52.74,61.95
|mapmarker Mulgore/0 54.07,68.61
|mapmarker Mulgore/0 54.24,65.28
|mapmarker Mulgore/0 54.57,71.28
|only if Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast##6061 |goto Mulgore/0 46.93,59.65
accept Taming the Beast##6087 |goto Mulgore/0 46.93,59.65
|only if Hunter
step
use Taming Rod##15915
|tip On a Prairie Stalker.
|tip Wolves.
|tip Dismiss your pet first.
Tame a Prairie Stalker |q 6087/1 |goto Mulgore 46.91,55.45
|mapmarker Mulgore/0 35.57,49.61
|mapmarker Mulgore/0 35.57,54.78
|mapmarker Mulgore/0 36.57,52.45
|mapmarker Mulgore/0 37.41,57.11
|mapmarker Mulgore/0 38.07,49.95
|mapmarker Mulgore/0 38.07,54.45
|mapmarker Mulgore/0 40.41,56.28
|mapmarker Mulgore/0 40.57,51.11
|mapmarker Mulgore/0 41.07,48.28
|mapmarker Mulgore/0 41.57,53.78
|mapmarker Mulgore/0 42.41,58.11
|mapmarker Mulgore/0 43.07,51.61
|mapmarker Mulgore/0 43.91,46.45
|mapmarker Mulgore/0 43.91,55.78
|mapmarker Mulgore/0 44.74,49.11
|mapmarker Mulgore/0 45.07,53.45
|mapmarker Mulgore/0 46.24,44.78
|mapmarker Mulgore/0 46.91,47.45
|mapmarker Mulgore/0 46.91,51.28
|mapmarker Mulgore/0 49.57,47.28
|mapmarker Mulgore/0 47.91,42.78
|mapmarker Mulgore/0 48.74,53.11
|mapmarker Mulgore/0 50.41,42.61
|mapmarker Mulgore/0 50.57,50.28
|mapmarker Mulgore/0 51.91,45.11
|mapmarker Mulgore/0 52.24,60.78
|mapmarker Mulgore/0 52.41,63.95
|mapmarker Mulgore/0 52.57,48.61
|mapmarker Mulgore/0 53.07,54.95
|mapmarker Mulgore/0 53.24,57.61
|mapmarker Mulgore/0 53.24,71.78
|mapmarker Mulgore/0 53.57,66.95
|mapmarker Mulgore/0 54.41,45.45
|mapmarker Mulgore/0 54.57,74.61
|mapmarker Mulgore/0 54.74,60.45
|mapmarker Mulgore/0 54.91,51.11
|mapmarker Mulgore/0 55.57,55.78
|mapmarker Mulgore/0 55.57,63.78
|mapmarker Mulgore/0 55.57,69.45
|mapmarker Mulgore/0 55.74,48.61
|mapmarker Mulgore/0 55.91,71.95
|mapmarker Mulgore/0 56.41,66.45
|mapmarker Mulgore/0 56.91,58.45
|mapmarker Mulgore/0 57.07,61.61
|mapmarker Mulgore/0 57.41,52.28
|mapmarker Mulgore/0 58.07,70.28
|mapmarker Mulgore/0 58.41,64.28
|mapmarker Mulgore/0 58.41,72.95
|mapmarker Mulgore/0 59.07,55.78
|mapmarker Mulgore/0 59.41,66.95
|mapmarker Mulgore/0 59.57,59.28
|only if Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast##6087 |goto Mulgore/0 46.93,59.65
accept Taming the Beast##6088 |goto Mulgore/0 46.93,59.65
|only if Hunter
step
use Taming Rod##15916
|tip On a Swoop.
|tip Black birds.
|tip Dismiss your pet first.
Tame a Swoop |q 6088/1 |goto Mulgore 44.74,54.95
|mapmarker Mulgore/0 35.74,48.28
|mapmarker Mulgore/0 35.74,54.45
|mapmarker Mulgore/0 37.24,50.28
|mapmarker Mulgore/0 38.74,47.95
|mapmarker Mulgore/0 41.41,48.28
|mapmarker Mulgore/0 41.41,53.45
|mapmarker Mulgore/0 42.41,56.95
|mapmarker Mulgore/0 44.41,42.95
|mapmarker Mulgore/0 44.57,47.28
|mapmarker Mulgore/0 46.24,51.11
|mapmarker Mulgore/0 47.57,53.61
|mapmarker Mulgore/0 48.41,46.95
|mapmarker Mulgore/0 48.74,51.28
|mapmarker Mulgore/0 49.74,41.95
|mapmarker Mulgore/0 50.74,44.28
|mapmarker Mulgore/0 51.57,50.95
|mapmarker Mulgore/0 53.24,48.61
|mapmarker Mulgore/0 54.41,51.78
|mapmarker Mulgore/0 54.57,61.45
|mapmarker Mulgore/0 54.74,69.95
|mapmarker Mulgore/0 54.91,54.45
|mapmarker Mulgore/0 55.74,66.78
|mapmarker Mulgore/0 56.57,63.11
|mapmarker Mulgore/0 57.24,59.28
|only if Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast##6088 |goto Mulgore/0 46.93,59.65
accept Training the Beast##6089 |goto Mulgore/0 46.93,59.65
|only if Hunter
step
talk Innkeeper Kauth##6747
|tip Inside the building.
home Bloodhoof Village |goto Mulgore/0 45.92,64.19
step
_NOTE:_
Tame Any Beast
|tip Cast {o}Tame Beast{} on any {o}level 8{} beast.
|tip You'll replace it with a new permanent pet soon.
|tip Dismiss your pet first.
Click Here to Continue |confirm |goto Mulgore 46.91,55.45 |q 772
|only if Hunter
step
kill Bael'dun Digger##2989, Bael'dun Appraiser##2990
|tip Dwarves.
collect 5 Prospector's Pick##4702 |goto Mulgore/0 34.15,53.83 |q 746
step
kill Windfury Harpy##2962, Windfury Wind Witch##2963
|tip Harpies.
collect 8 Windfury Talon##4751 |q 743/1 |goto Mulgore/0 34.57,48.01
step
talk Seer Wiserunner##2984
|tip Inside the small cave.
|tip Run around the mountain.
turnin Rite of Vision##772 |goto Mulgore 34.34,43.36
accept Rite of Wisdom##773 |goto Mulgore 34.34,43.36
step
_Destroy This Item:_
|tip Not needed.
trash Water of the Seers##4823
step
Ride an elevator up into Thunder Bluff |goto Thunder Bluff/0 32.10,67.13 < 20 |only if walking
talk Eylah Sunhorn##269068
accept Traditions of the Bluff##97485 |goto Thunder Bluff/0 38.06,55.97
step
use Prospector's Pick##4702+
|tip Next to the forge.
collect 5 Broken Tools##4703 |q 746/1 |goto Thunder Bluff/0 39.25,56.18
step
talk Veren Tallstrider##3050
|tip Inside the building.
accept Gathering Leather##768 |goto Thunder Bluff/0 44.37,44.67
|only if skillmax("Skinning") >= 1
step
talk Veren Tallstrider##3050
|tip Inside the building.
turnin Gathering Leather##768 |goto Thunder Bluff/0 44.37,44.67
|only if readyq(768)
step
talk Mahu##3005
|tip Inside the building.
buy Sinew Thread##278081 |goto Thunder Bluff/0 43.81,45.09 |q 97485
step
talk Nata Dawnstrider##3012
buy Bundle of Dried Cedar Twigs##278080 |goto Thunder Bluff/0 45.01,38.78 |q 97485
step
talk Nida Winterhoof##3014
buy Bundle of Herbs##278079 |goto Thunder Bluff/0 49.55,39.57 |q 97485
step
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
accept The Barrens Oases##886 |goto Thunder Bluff 78.62,28.56
step
talk Turak Runetotem##3033
|tip Inside the building.
turnin Heeding the Call##5928 |goto Thunder Bluff 76.46,27.23
accept Moonglade##5922 |goto Thunder Bluff 76.46,27.23
|only if Druid
step
talk Cairne Bloodhoof##3057
|tip Inside the building.
turnin The High Chieftain##99082 |goto Thunder Bluff/0 60.27,51.68
step
talk Naal Mistrunner##3027
buy Ceremonial Flint and Tinder##278083 |goto Thunder Bluff/0 51.01,52.43 |q 97485
step
use Ceremonial Flint and Tinder##278083
Create the Incense |q 97485/1
step
talk Kaga Mistrunner##3025
buy Tough Jerky##117+ |n
|tip Buy {o}20{}, if possible.
|tip Used to feed your pet.
Visit the Vendor |vendor Kaga Mistrunner##3025 |goto Thunder Bluff/0 52.32,47.77 |q 6089
|only if Hunter
step
talk Holt Thunderhorn##3039
|tip Inside the building.
turnin Training the Beast##6089 |goto Thunder Bluff 57.31,89.76
|only if Hunter
step
use Prepared Incense##278078
Spread the Incense |q 97485/2 |goto Thunder Bluff/0 53.14,87.88
step
talk Hesuwa Thunderhorn##10086
|tip Inside the building.
Train Pet Abilities |trainer Hesuwa Thunderhorn##10086 |goto Thunder Bluff/0 54.09,83.97 |q 773
|only if Hunter
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948 |q 5922
|only if Druid
step
talk Innkeeper Pala##6746
|tip Inside the building.
home Thunder Bluff |goto Thunder Bluff 45.81,64.71
|only if Druid
step
talk Eylah Sunhorn##269068
turnin Traditions of the Bluff##97485 |goto Thunder Bluff/0 38.06,55.97
step
_Destroy These Items:_
|tip Not needed.
trash Prepared Incense##281040
stickystart "Collect_Flatland_Prowler_Claws"
stickystart "Collect_Prairie_Alpha_Teeth"
stickystart "Collect_Light_Leather_Skinning"
step
Ride an elevator down to leave Thunder Bluff |goto Thunder Bluff/0 51.20,31.51 < 20 |only if walking and zone("Thunder Bluff")
talk Lorekeeper Raintotem##3233
accept A Sacred Burial##833 |goto Mulgore/0 56.98,34.54
stickystop "Collect_Flatland_Prowler_Claws"
stickystop "Collect_Prairie_Alpha_Teeth"
stickystop "Collect_Light_Leather_Skinning"
stickystart "Kill_Bristleback_Interlopers"
step
talk Ancestral Spirit##2994
turnin Rite of Wisdom##773 |goto Mulgore/0 58.30,30.71
accept Journey into Thunder Bluff##775 |goto Mulgore/0 58.30,30.71
step
label "Kill_Bristleback_Interlopers"
kill 8 Bristleback Interloper##3232 |q 833/1 |goto Mulgore/0 58.24,30.55
step
talk Lorekeeper Raintotem##3233
turnin A Sacred Burial##833 |goto Mulgore/0 56.98,34.54
stickystart "Collect_Prairie_Alpha_Teeth"
stickystart "Collect_Light_Leather_Skinning"
step
label "Collect_Flatland_Prowler_Claws"
kill Flatland Prowler##3566+
|tip Cougars.
collect 4 Flatland Prowler Claw##5203 |q 861/1 |goto Mulgore/0 51.25,31.30
step
label "Collect_Prairie_Alpha_Teeth"
kill Prairie Wolf Alpha##2960+
collect 8 Prairie Alpha Tooth##4803 |q 759/1 |goto Mulgore/0 51.25,31.30
step
label "Collect_Light_Leather_Skinning"
kill Prairie Wolf Alpha##2960, Flatland Prowler##3566
|tip Skin them.
collect 12 Light Leather##2318 |goto Mulgore/0 51.25,31.30
|tip Don't vendor them.
|only if haveq(768) or completedq(768)
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Moonglade##5922 |goto Moonglade 56.21,30.64
accept Great Bear Spirit##5930 |goto Moonglade 56.21,30.64
|only if Druid
step
talk Great Bear Spirit##11956
Select _"What do you represent, spirit?"_
Seek Out the Great Bear Spirit and Learn what it Has to Share with You About the Nature of the Bear |q 5930/1 |goto Moonglade 39.11,27.51
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Great Bear Spirit##5930 |goto Moonglade 56.21,30.64
accept Back to Thunder Bluff##5932 |goto Moonglade 56.21,30.64
|only if Druid
step
talk Turak Runetotem##3033
|tip Inside the building.
turnin Back to Thunder Bluff##5932 |goto Thunder Bluff 76.46,27.23
accept Body and Heart##6002 |goto Thunder Bluff 76.46,27.23
|only if Druid
step
talk Baine Bloodhoof##2993
turnin Dwarven Digging##746 |goto Mulgore/0 46.67,63.39
step
talk Ruul Eagletalon##2985
turnin Dangers of the Windfury##743 |goto Mulgore/0 46.54,64.93
step
talk Mull Thunderhorn##2948
turnin Wildmane Totem##759 |goto Mulgore/0 47.52,63.58
step
use Cenarion Lunardust##15710
kill Lunaclaw##12138
|tip Spirit appears.
talk Lunaclaw Spirit##12144
Select _"You have fought well, spirit. I ask you to grant me the strength of your body and the strength of your heart."_
Face Lunaclaw and Earn the Strength of Body and Heart it Possesses |q 6002/1 |goto The Barrens 42.00,60.86
|only if Druid
step
talk Omusa Thunderhorn##10378
fpath Camp Taurajo |goto The Barrens 44.45,59.15
step
talk Omusa Thunderhorn##10378
|tip Open the flight map.
|tip Allows guide to learn your flight paths.
fpath Thunder Bluff |goto The Barrens 44.45,59.15
step
talk Kirge Sternhorn##3418
accept Journey to the Crossroads##854 |goto The Barrens 44.88,58.61
step
talk Tonga Runetotem##3448
|tip Carefully follow the road.
|tip Higher level enemies.
turnin The Barrens Oases##886 |goto The Barrens/0 52.26,31.93
step
talk Thork##3429
turnin Journey to the Crossroads##854 |goto The Barrens 51.50,30.87
step
talk Devrak##3615
fpath Crossroads |goto The Barrens 51.51,30.34
step
talk Jahan Hawkwing##3483
accept A Bundle of Hides##6361 |goto The Barrens 51.21,29.05
step
talk Devrak##3615
turnin A Bundle of Hides##6361 |goto The Barrens 51.50,30.34
accept Ride to Thunder Bluff##6362 |goto The Barrens 51.50,30.34
step
talk Veren Tallstrider##3050
|tip Inside the building.
turnin Gathering Leather##768 |goto Thunder Bluff/0 44.37,44.67
|only if haveq(768) or completedq(768)
step
talk Turak Runetotem##3033
|tip Inside the building.
turnin Body and Heart##6002 |goto Thunder Bluff 76.46,27.23
|only if Druid
step
talk Cairne Bloodhoof##3057
|tip Inside the building.
turnin Journey into Thunder Bluff##775 |goto Thunder Bluff 60.30,51.68
step
talk Melor Stonehoof##3441
turnin The Hunter's Way##861 |goto Thunder Bluff/0 61.52,80.89
accept Sergra Darkthorn##860 |goto Thunder Bluff/0 61.52,80.89
step
talk Ansekhwa##11869
Train Staves		|complete weaponskill("TH_STAFF") > 0		|goto Thunder Bluff 40.93,62.73		|only if Warrior or Hunter
Train Two-Handed Maces	|complete weaponskill("TH_MACE") > 0		|goto Thunder Bluff 40.93,62.73		|only if Druid
|only if Warrior or Hunter or Druid
step
_NOTE:_
Use Weapon Stones
|tip We will train Mining and Blacksmithing.
|tip Allows you to make and use {o}Sharpening Stones{}.
|tip Increases damage.
|tip Mine {o}Copper Ore{} as you see it.
|tip Use the {g}Rough Stones{} to make sharpening stones.
Click Here to Continue |confirm |q 6362
|only if Warrior
step
talk Karn Stonehoof##2998
Train Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Thunder Bluff/0 39.38,55.09
|only if Warrior
step
talk Brek Stonehoof##3001
|tip Inside the building.
Train Apprentice Mining |skillmax Mining,75 |goto Thunder Bluff/0 34.37,57.90
|only if Warrior
step
talk Kurm Stonehoof##3002
|tip Inside the building.
buy Mining Pick##2901 |goto Thunder Bluff/0 34.35,56.56
|only if Warrior
step
talk Ahanu##8359
|tip Inside the building.
turnin Ride to Thunder Bluff##6362 |goto Thunder Bluff 45.77,55.84
accept Tal the Wind Rider Master##6363 |goto Thunder Bluff 45.77,55.84
step
talk Tal##2995
|tip Top of the tower.
turnin Tal the Wind Rider Master##6363 |goto Thunder Bluff 47.00,49.83
accept Return to Jahan##6364 |goto Thunder Bluff 47.00,49.83
step
talk Sergra Darkthorn##3338
turnin Sergra Darkthorn##860 |goto The Barrens/0 52.23,31.01
step
talk Jahan Hawkwing##3483
turnin Return to Jahan##6364 |goto The Barrens 51.21,29.05
step
_NOTE:_
Tame a Venomtail Scorpid
|tip Cast {o}Tame Beast{} on a Venomtail Scorpid.
|tip Abandon your pet first.
|tip New permanent pet.
Click Here to Continue |confirm |goto Durotar/0 35.40,47.40 |q 834 |future
|mapmarker Durotar/0 35.40,53.80
|mapmarker Durotar/0 37.80,51.20
|only if Hunter
step
talk Kranal Fiss##5907
|tip Walks around.
turnin Call of Fire##2984 |goto The Barrens 56.03,19.89
accept Call of Fire##1524 |goto The Barrens 56.03,19.89
|only if Shaman
step
Follow the path up |goto Durotar 36.59,57.07 < 15 |only if walking
talk Telf Joolam##5900
|tip On top of the mountain.
turnin Call of Fire##1524 |goto Durotar 38.55,58.96
accept Call of Fire##1525 |goto Durotar 38.55,58.96
|only if Shaman
step
kill Razormane Geomancer##3269, Razormane Thornweaver##3268, Razormane Mystic##3271, Razormane Water Seeker##3267
|tip Thornweavers and Water Seekers.
collect Fire Tar##5026 |q 1525/1 |goto The Barrens/0 54.33,24.72
|only if Shaman
step
talk Takrin Pathseeker##3336
accept Conscript of the Horde##840 |goto Durotar/0 50.85,43.59
step
Follow the path up |goto 54.54,38.79 < 40 |only if walking and not (subzone("Dustwind Cave") and indoors())
kill Burning Blade Cultist##3199+
|tip Inside the cave.
|tip In the back.
collect Reagent Pouch##6652 |q 1525/2 |goto Durotar/0 52.80,28.60
|only if Shaman
step
Leave the cave |goto Durotar/0 52.80,28.60 < 15 |walk |only if subzone("Dustwind Cave") and indoors()
Follow the path up |goto Durotar 36.59,57.07 < 15 |only if walking
talk Telf Joolam##5900
|tip Top of the mountain.
turnin Call of Fire##1525 |goto Durotar 38.55,58.96
accept Call of Fire##1526 |goto Durotar 38.55,58.96
|only if Shaman
step
use Fire Sapta##6636
|tip Top of the mountain.
Gain Sapta Sight |havebuff Sapta Sight##8898 |goto Durotar 38.16,58.54 |q 1526
|only if Shaman
step
kill Minor Manifestation of Fire##5893
|tip Top of the mountain.
collect Glowing Ember##6655 |q 1526/1 |goto Durotar 38.72,58.29
|only if Shaman
step
click Brazier of the Dormant Flame
|tip Top of the mountain.
turnin Call of Fire##1526 |goto Durotar 38.95,58.22
accept Call of Fire##1527 |goto Durotar 38.95,58.22
|only if Shaman
step
talk Kranal Fiss##5907
|tip Walks around.
turnin Call of Fire##1527 |goto The Barrens 56.04,19.89
|only if Shaman
step
talk Innkeeper Grosk##6928
|tip Inside the building.
home Razor Hill |goto Durotar/0 51.52,41.65
step
talk Rezlak##3293
accept Winds in the Desert##834 |goto Durotar 46.37,22.94
step
click Stolen Supply Sack+
|tip Tan bags.
collect 5 Sack of Supplies##4918 |q 834/1 |goto Durotar/0 49.61,22.58
step
talk Rezlak##3293
turnin Winds in the Desert##834 |goto Durotar 46.37,22.94
accept Securing the Lines##835 |goto Durotar 46.37,22.94
stickystart "Kill_Dustwind_Storm_Witches_And_Savages"
step
Follow the path and run through the tunnel |goto Durotar 51.95,27.44 < 15 |only if walking and not subzone("Drygulch Ravine")
kill Dustwind Storm Witch##3118+
collect Dull Storm Orb##277661 |n
use Dull Storm Orb##277661
accept A Simmering Storm##97281 |goto Durotar/0 53.10,24.08
step
label "Kill_Dustwind_Storm_Witches_And_Savages"
kill 8 Dustwind Storm Witch##3118 |q 835/2 |goto Durotar/0 53.10,24.08
kill 12 Dustwind Savage##3117 |q 835/1 |goto Durotar/0 53.10,24.08
step
Run through the tunnel |goto Durotar/0 53.51,27.79 < 15 |only if walking and subzone("Drygulch Ravine")
talk Rezlak##3293
turnin Securing the Lines##835 |goto Durotar/0 46.37,22.94
turnin A Simmering Storm##97281 |goto Durotar/0 46.37,22.94
step
talk Thatog##268701
|tip {o}Top floor{} inside the building.
accept Meal Appeal##97246 |goto Orgrimmar/0 55.58,72.19
step
Run up the stairs |goto Orgrimmar/0 56.40,56.75 < 15 |only if walking
talk Borstan##3368
|tip Inside the building.
turnin Meal Appeal##97246 |goto Orgrimmar/0 57.19,53.33
accept Favorite Food##97249 |goto Orgrimmar/0 57.19,53.33
step
talk Kor'geld##3348
|tip Inside the building.
accept Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
stickystart "Collect_Speargrass_Cuttings"
step
click Cattail+
|tip Long brown plants.
collect 2 Handful of Cattails##277278 |q 97242/1 |goto Orgrimmar/0 67.79,30.26
step
label "Collect_Speargrass_Cuttings"
click Speargrass+
|tip Green grass.
collect 4 Speargrass Cuttings##277279 |q 97242/2 |goto Orgrimmar/0 67.79,30.26
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 97242
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 97242
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 97242
|only if Hunter
step
talk Kor'geld##3348
|tip Inside the building.
turnin Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
step
talk Yelmak##3347
|tip Walks around.
|tip Inside the building.
accept Whuut's the Rush##97275 |goto Orgrimmar/0 56.84,33.03
|tip May need to wait.
step
talk Whuut##11046
|tip Inside the building.
turnin Whuut's the Rush##97275 |goto Orgrimmar/0 55.80,32.90
step
talk Migi##268682
|tip Outside the building.
turnin Favorite Food##97249 |goto Orgrimmar/0 36.55,29.10
step
talk Thra##268684
|tip Outside the building.
accept Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
step
click Smooth Boulder+
|tip Brown rocks.
collect 8 Smooth Boulder##277952 |q 97326/1 |goto Orgrimmar/0 43.83,34.70
step
talk Thra##268684
|tip Outside the building.
turnin Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.81,36.39 |q 86784 |future
|only if Shaman
step
talk Doras##3310
|tip Top of the tower.
fpath Orgrimmar |goto Orgrimmar 45.13,63.90
step
talk Deathguard Bartholomew##1742
accept Sticks and Bones##86784 |goto Tirisfal Glades/0 58.47,51.39
step
click Dry Branch+
|tip Brown sticks.
|tip Usually near trees.
collect 6 Dry Branch##279991 |q 86784/1 |goto Tirisfal Glades/0 57.94,54.08
step
talk Eleanor Shackleton##265812
turnin Sticks and Bones##86784 |goto Tirisfal Glades/0 57.27,55.48
step
talk Apothecary Johaan##1518
|tip Inside the building.
accept Delivery to Silverpine Forest##445 |goto Tirisfal Glades 59.45,52.40
step
talk Deathguard Terrence##1738
accept The Argent Emissary##96895 |goto Tirisfal Glades/0 61.50,53.49
step
talk Hadric Harlson##267009
turnin The Argent Emissary##96895 |goto Tirisfal Glades/0 65.93,61.11
accept The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
accept Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
stickystart "Kill_Dark_Neophytes_And_Dark_Enforcers"
step
kill Dark Enforcer##275437, Dark Neophyte##267006
click Naxxramas Crystal Fragment+
|tip Black crystals.
collect 12 Necrotic Crystal Fragment##275851 |q 96898/1 |goto Tirisfal Glades/0 68.26,64.73
step
label "Kill_Dark_Neophytes_And_Dark_Enforcers"
kill 8 Dark Neophyte##267006 |q 96897/1 |goto Tirisfal Glades/0 68.26,64.73
kill 8 Dark Enforcer##275437 |q 96897/2 |goto Tirisfal Glades/0 68.26,64.73
step
talk Hadric Harlson##267009
turnin The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
turnin Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
step
talk Michael Garrett##4551
fpath Undercity |goto Undercity 63.28,48.58
step
talk Alessandro Luca##7683
accept Prompt Potion Runner##97891 |goto Undercity/0 58.62,54.66
step
Follow the path down |goto Undercity/0 52.83,77.69 < 10 |walk
talk Doctor Martin Felben##11044
turnin Prompt Potion Runner##97891 |goto Undercity/0 46.60,74.08
|delay 0.2
step
_Destroy This Item:_
|tip Not needed.
trash Inert Potion##279023
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Orc & Troll Starter (1-13)",{
image=ZGV.IMAGESDIR.."Durotar",
condition_suggested=function() return (raceclass('Orc') or raceclass('Troll')) and level <= 13 end,
condition_suggested_exclusive=true,
condition_visible=function() return (Orc or Troll) end,
linked = {"Leveling Guides\\Hidden Guides"},
linkedhidden = true,
hardcore = true,
next="Leveling Guides\\Silverpine Forest (13-15)",
},[[
defaultfor Orc,Troll
step
_NOTE:_
Wrong Character Race
|tip Guide written for {o}Orc & Troll{} characters.
|tip Other races may encounter issues.
Click Here to Continue |confirm
|only if not (Orc or Troll)
step
_NOTE:_
Manage Your Ammo
|tip Make sure you always have ammo.
|tip You need it to attack enemies.
|tip {o}General Goods{} vendors sell it (also Bow & Gun vendors).
|tip Try to keep your ammo bag full.
Click Here to Continue |confirm |q 4641 |future
|only if Hunter
step
talk Kaltunk##10176
accept Your Place In The World##4641 |goto Durotar/0 43.29,68.53
step
kill Mottled Boar##3098+
|tip Loot items worth at least {o}10 copper{} to sell.
|tip Allows training an ability early.
|tip Increases leveling speed.
Click to Continue |confirm |goto Durotar/0 43.80,70.40 |q 4641
|mapmarker Durotar/0 43.40,72.40
|mapmarker Durotar/0 41.40,71.60
|only if Warrior or Warlock or Shaman
step
talk Duokna##3158
Sell Items |vendor Duokna##3158  |goto Durotar/0 42.58,67.34 |q 4641
|only if Warrior or Warlock or Shaman
step
talk Frang##3153
Train Abilities |trainer Frang##3153 |goto Durotar 42.89,69.43 |q 4641
|only if Warrior
step
talk Shikrik##3157
Train Abilities |trainer Shikrik##3157 |goto Durotar 42.39,69.00 |q 4641
|only if Shaman
step
talk Ruzan##5765
accept Vile Familiars##1485 |goto Durotar 42.59,69.00
|only if Warlock
step
talk Gornek##3143
|tip Inside the cave.
turnin Your Place In The World##4641 |goto Durotar 42.06,68.33
accept Cutting Teeth##788 |goto Durotar 42.06,68.33
accept Wayward Weapons##97279 |goto Durotar/0 42.06,68.33
step
talk Nartok##3156
|tip Inside the cave.
Train Abilities |trainer Nartok##3156 |goto Durotar 40.65,68.51 |q 788
|only if Warlock
stickystart "Kill_Mottled_Boars"
step
click Abandoned Training Weapon+
|tip Axes.
collect 6 Abandoned Training Weapon##277653 |q 97279/1 |goto Durotar/0 44.36,64.91
step
label "Kill_Mottled_Boars"
kill 10 Mottled Boar##3098 |q 788/1 |goto Durotar/0 44.36,64.91
step
label "Collect_Vile_Familiar_Heads"
kill Vile Familiar##3101+
|tip Avoid going inside the cave, if possible.
|tip Next step outside the cave.
collect 6 Vile Familiar Head##6487 |q 1485/1 |goto Durotar 45.80,57.40
|mapmarker Durotar/0 43.80,58.40
|only if Warlock
step
talk Hana'zua##3287
accept Sarkoth##790 |goto Durotar 40.60,62.59
step
kill Sarkoth##3281
|tip Black scorpion.
|tip Walks around.
collect Sarkoth's Mangled Claw##4905 |q 790/1 |goto Durotar/0 40.60,67.60
step
talk Hana'zua##3287
turnin Sarkoth##790 |goto Durotar 40.60,62.59
accept Sarkoth##804 |goto Durotar 40.60,62.59
step
talk Ruzan##5765
turnin Vile Familiars##1485 |goto Durotar 42.59,69.00
accept Vile Familiars##1499 |goto Durotar 42.59,69.00
|only if Warlock
step
Summon Your Imp |complete warlockpet("Imp")
|tip Cast {o}Summon Imp{}.
|only if Warlock
step
talk Zureetha Fargaze##3145
turnin Vile Familiars##1499 |goto Durotar 42.85,69.15
|only if Warlock
step
talk Gornek##3143
|tip Inside the cave.
turnin Cutting Teeth##788		|goto Durotar 42.06,68.33
turnin Sarkoth##804			|goto Durotar 42.06,68.33
accept Sting of the Scorpid##789	|goto Durotar 42.06,68.33
accept Simple Parchment##2383		|goto Durotar 42.06,68.33	|only if Orc Warrior
accept Rune-Inscribed Parchment##3089	|goto Durotar 42.06,68.33	|only if Orc Shaman
accept Encrypted Parchment##3088	|goto Durotar 42.06,68.33	|only if Orc Rogue
accept Etched Parchment##3087		|goto Durotar 42.06,68.33	|only if Orc Hunter
accept Tainted Parchment##3090		|goto Durotar 42.06,68.33	|only if Orc Warlock
accept Glyphic Parchment##98576		|goto Durotar 42.06,68.33	|only if Orc Mage
accept Simple Tablet##3065		|goto Durotar 42.06,68.33	|only if Troll Warrior
accept Etched Tablet##3082		|goto Durotar 42.06,68.33	|only if Troll Hunter
accept Encrypted Tablet##3083		|goto Durotar 42.06,68.33	|only if Troll Rogue
accept Hallowed Tablet##3085		|goto Durotar 42.06,68.33	|only if Troll Priest
accept Rune-Inscribed Tablet##3084	|goto Durotar 42.06,68.33	|only if Troll Shaman
accept Glyphic Tablet##3086		|goto Durotar 42.06,68.33	|only if Troll Mage
accept Tainted Tablet##98575		|goto Durotar 42.06,68.33	|only if Troll Warlock
step
talk Rwag##3155
|tip Inside the cave.
turnin Encrypted Parchment##3088 |goto Durotar 41.28,68.00	|only if Orc
turnin Encrypted Tablet##3083 |goto Durotar 41.28,68.00		|only if Troll
|only if Rogue
step
talk Rwag##3155
|tip Inside the cave.
Train Abilities |trainer Rwag##3155 |goto Durotar 41.28,68.00 |q 97279
|only if Rogue
step
talk Kzan Thornslash##3159
|tip Inside the cave.
turnin Wayward Weapons##97279 |goto Durotar/0 40.47,68.01
step
talk Nartok##3156
|tip Inside the cave.
turnin Tainted Parchment##3090	|goto Durotar 40.65,68.51 |only if Orc
turnin Tainted Tablet##98575	|goto Durotar 40.65,68.51 |only if Troll
|only if Warlock
step
talk Nartok##3156
|tip Inside the cave.
Train Abilities |trainer Nartok##3156 |goto Durotar 40.65,68.51 |q 4402 |future
|only if Warlock
step
talk Hraug##12776
|tip Buy available Grimoires.
|tip Inside the cave.
Train Demon Abilities |vendor Hraug##12776 |goto Durotar 40.56,68.43 |q 4402 |future
|only if Warlock
step
Leave the cave |goto Durotar/0 42.27,68.42 < 10 |walk |only if subzone("The Den") and indoors()
talk Galgar##9796
accept Galgar's Cactus Apple Surprise##4402 |goto Durotar 42.73,67.24
step
talk Ken'jai##3707
turnin Hallowed Tablet##3085 |goto Durotar 42.36,68.82
|only if Priest
step
talk Ken'jai##3707
Train Abilities |trainer Ken'jai##3707 |goto Durotar 42.36,68.82 |q 4402
|only if Priest
step
talk Shikrik##3157
turnin Rune-Inscribed Parchment##3089 |goto Durotar 42.39,69.00		|only if Orc
turnin Rune-Inscribed Tablet##3084 |goto Durotar 42.39,69.00		|only if Troll
|only if Shaman
step
talk Shikrik##3157
Train Abilities |trainer Shikrik##3157 |goto Durotar 42.39,69.00 |q 4402
|only if Shaman
step
talk Mai'ah##5884
turnin Glyphic Tablet##3086	|goto Durotar 42.51,69.04 |only if Troll
turnin Glyphic Parchment##98576 |goto Durotar 42.51,69.04 |only if Orc
|only if Mage
step
talk Mai'ah##5884
Train Abilities |trainer Mai'ah##5884 |goto Durotar 42.51,69.04 |q 4402
|only if Mage
step
talk Zureetha Fargaze##3145
accept Vile Familiars##792 |goto Durotar 42.85,69.14
|only if not Warlock
step
talk Frang##3153
turnin Simple Parchment##2383 |goto Durotar 42.89,69.43		|only if Orc
turnin Simple Tablet##3065 |goto Durotar 42.89,69.43		|only if Troll
|only if Warrior
step
talk Frang##3153
Train Abilities |trainer Frang##3153 |goto Durotar 42.89,69.43 |q 4402
|only if Warrior
step
talk Jen'shan##3154
turnin Etched Parchment##3087	|goto Durotar 42.84,69.32 |only if Orc
turnin Etched Tablet##3082	|goto Durotar 42.84,69.32 |only if Troll
|only if Hunter
step
talk Jen'shan##3154
Train Abilities |trainer Jen'shan##3154 |goto Durotar 42.84,69.32 |q 4402
|only if Hunter
step
talk Foreman Thazz'ril##11378
accept Lazy Peons##5441 |goto Durotar 44.62,68.64
stickystart "Collect_Scorpid_Worker_Tails"
stickystart "Awaken_Lazy_Peons"
stickystart "Collect_Cactus_Apples"
step
kill 12 Vile Familiar##3101 |q 792/1 |goto Durotar/0 44.73,57.34
|tip Avoid going inside the cave, if possible.
|tip Next step outside the cave.
|only if not Warlock
step
label "Collect_Scorpid_Worker_Tails"
kill Scorpid Worker##3124+
|tip Scorpions.
collect 10 Scorpid Worker Tail##4862 |q 789/1 |goto Durotar/0 43.41,60.03
step
label "Awaken_Lazy_Peons"
use Foreman's Blackjack##16114
|tip On Lazy Peons.
|tip Sleeping orcs.
|tip Near trees.
|tip If not sleeping, wait or skip them.
Awaken #5# Lazy Peons |q 5441/1 |goto Durotar 45.40,65.80
|mapmarker Durotar/0 39.00,61.80
|mapmarker Durotar/0 40.80,60.60
|mapmarker Durotar/0 41.40,72.60
|mapmarker Durotar/0 43.80,57.40
|mapmarker Durotar/0 44.40,72.80
|mapmarker Durotar/0 44.80,69.00
|mapmarker Durotar/0 46.60,60.40
|mapmarker Durotar/0 47.00,58.00
|mapmarker Durotar/0 47.20,65.40
|mapmarker Durotar/0 47.40,69.20
step
label "Collect_Cactus_Apples"
click Cactus Apple+
|tip Cactuses with red fruit.
collect 10 Cactus Apple##11583 |q 4402/1 |goto Durotar/0 43.37,61.84
step
talk Galgar##9796
turnin Galgar's Cactus Apple Surprise##4402 |goto Durotar 42.73,67.24
step
use Pelt Collecting for Beginners##247846
Learn Skinning |skillmax Skinning,75
|only if itemcount(247846) > 0
step
use Wild Harvest##247841
Learn Herbalism |skillmax Herbalism,75
|only if itemcount(247841) > 0
step
use Mining for Dummies##247840
Learn Mining |skillmax Mining,75
|only if itemcount(247840) > 0
step
talk Gornek##3143
|tip Inside the cave.
turnin Sting of the Scorpid##789 |goto Durotar 42.05,68.32
step
talk Nartok##3156
|tip Inside the cave.
Train Abilities |trainer Nartok##3156 |goto Durotar 40.65,68.51 |q 5441
|only if Warlock
step
talk Hraug##12776
|tip Buy available Grimoires.
|tip Inside the cave.
Train Demon Abilities |vendor Hraug##12776 |goto Durotar 40.56,68.43 |q 5441
|only if Warlock
step
talk Rwag##3155
|tip Inside the cave.
Train Abilities |trainer Rwag##3155 |goto |goto Durotar 41.28,68.00 |q 5441
|only if Rogue
step
talk Ken'jai##3707
Train Abilities |trainer Ken'jai##3707 |goto Durotar 42.36,68.81 |q 5441
|only if Troll Priest
step
talk Canaga Earthcaller##5887
accept Call of Earth##1516 |goto Durotar 42.41,69.17
|only if Shaman
step
talk Shikrik##3157
Train Abilities |trainer Shikrik##3157 |goto Durotar 42.39,69.00 |q 5441
|only if Shaman
step
talk Mai'ah##5884
Train Abilities |trainer Mai'ah##5884 |goto Durotar 42.51,69.04 |q 5441
|only if Mage
step
Leave the cave |goto Durotar/0 42.27,68.42 < 10 |walk |only if subzone("The Den") and indoors()
talk Zureetha Fargaze##3145
turnin Vile Familiars##792 |goto Durotar 42.85,69.15 |only if not Warlock
accept Burning Blade Medallion##794 |goto Durotar 42.85,69.15
step
talk Frang##3153
Train Abilities |trainer Frang##3153 |goto Durotar 42.89,69.43 |q 5441
|only if Warrior
step
talk Jen'shan##3154
Train Abilities |trainer Jen'shan##3154 |goto Durotar 42.84,69.32 |q 5441
|only if Hunter
step
talk Duokna##3158
buy Skinning Knife##7005 |goto Durotar/0 42.59,67.34 |q 5441
buy Apprentice's Skinning Satchel##277114 |goto Durotar/0 42.59,67.34 |q 5441
|only if skillmax("Skinning") > 1
step
talk Duokna##3158
buy Apprentice's Herb Pouch##277113 |goto Durotar/0 42.59,67.34 |q 5441
|only if skillmax("Herbalism") > 1
step
talk Duokna##3158
buy Mining Pick##2901 |goto Durotar/0 42.59,67.34 |q 5441
buy Apprentice's Mining Pack##277115 |goto Durotar/0 42.59,67.34 |q 5441
|only if skillmax("Mining") > 1
step
talk Foreman Thazz'ril##11378
turnin Lazy Peons##5441 |goto Durotar 44.62,68.64
accept Thazz'ril's Pick##6394 |goto Durotar 44.62,68.64
stickystart "Collect_Felstalker_Hoofs_Shaman"
step
Enter the cave |goto Durotar 45.34,56.36 < 15 |walk |only if not (subzone("Burning Blade Coven") and indoors())
click Thazz'ril's Pick
|tip Inside the cave.
collect Thazz'ril's Pick##16332 |q 6394/1 |goto Durotar 43.73,53.79
step
Follow the path |goto Durotar 44.76,54.54 < 10 |walk
kill Yarrog Baneshadow##3183
|tip Inside the cave.
collect Burning Blade Medallion##4859 |q 794/1 |goto Durotar 42.71,52.95
step
label "Collect_Felstalker_Hoofs_Shaman"
kill Felstalker##3102+
|tip Demon dogs.
|tip Inside the cave. |notinsticky
collect 2 Felstalker Hoof##6640 |q 1516/1 |goto Durotar 45.34,56.36
|only if Shaman
step
use Hearthstone##6948
Hearth to Valley of Trials |complete subzone("Valley of Trials") |q 6394
|only if subzone("Burning Blade Coven") and indoors()
step
talk Zureetha Fargaze##3145
turnin Burning Blade Medallion##794 |goto Durotar 42.85,69.15
accept Report to Sen'jin Village##805 |goto Durotar 42.85,69.15
step
click Lost Journal
accept The Adventurer##96652 |goto Durotar/0 42.77,69.20
step
talk Ken'jai##3707
accept In Favor of Spirituality##5649 |goto Durotar 42.36,68.81
|only if Priest
step
talk Canaga Earthcaller##5887
turnin Call of Earth##1516 |goto Durotar 42.41,69.17
accept Call of Earth##1517 |goto Durotar 42.41,69.17
|only if Shaman
step
Follow the path up |goto Durotar 41.56,73.28 < 15 |only if walking
use Earth Sapta##6635
|tip Top of the mountain.
talk Minor Manifestation of Earth##5891
turnin Call of Earth##1517 |goto Durotar 44.03,76.20
accept Call of Earth##1518 |goto Durotar 44.03,76.20
|only if Shaman
step
talk Canaga Earthcaller##5887
turnin Call of Earth##1518 |goto Durotar 42.41,69.17
|only if Shaman
step
talk Foreman Thazz'ril##11378
turnin Thazz'ril's Pick##6394 |goto Durotar 44.62,68.64
step
talk Ukor##6786
accept A Peon's Burden##2161 |goto Durotar 52.06,68.31
step
talk Lar Prowltusk##3140
|tip Walks around.
|tip Multiple locations.
accept Thwarting Kolkar Aggression##786 |goto Durotar 54.19,73.29
|mapmarker Durotar/0 54.00,76.20
|mapmarker Durotar/0 54.40,74.20
step
talk Xar'Ti##7953
accept Bloodtalon Matriarch##97223 |goto Durotar/0 55.26,75.57
step
talk Vel'rin Fang##3194
|tip Inside the building.
accept Practical Prey##817 |goto Durotar 55.96,73.92
accept Legging It##96821 |goto Durotar/0 55.96,73.92
step
talk Master Gadrin##3188
turnin Report to Sen'jin Village##805 |goto Durotar 55.95,74.72
accept Minshina's Skull##808 |goto Durotar 55.95,74.72
accept Zalazane##826 |goto Durotar 55.95,74.72
accept Report to Orgnil##823 |goto Durotar 55.95,74.72
step
talk Master Vornal##3304
accept A Solvent Spirit##818 |goto Durotar/0 55.94,74.40
accept Forgotten Loa Idols##97225 |goto Durotar/0 55.94,74.40
stickystart "Collect_Crawler_Mucus"
step
kill Makrura Clacker##3103, Makrura Shellhide##3104
|tip Lobsters.
|tip Along the beach.
collect 4 Intact Makrura Eye##4887 |q 818/1 |goto Durotar 60.20,70.80
|mapmarker Durotar/0 52.20,83.00
|mapmarker Durotar/0 55.00,81.40
|mapmarker Durotar/0 56.40,78.40
|mapmarker Durotar/0 58.40,73.40
step
label "Collect_Crawler_Mucus"
kill Pygmy Surf Crawler##3106, Surf Crawler##3107
|tip Crabs.
|tip Along the beach. |notinsticky
collect 8 Crawler Mucus##4888 |q 818/2 |goto Durotar 60.20,70.80
|mapmarker Durotar/0 52.20,83.00
|mapmarker Durotar/0 55.00,81.40
|mapmarker Durotar/0 56.40,78.40
|mapmarker Durotar/0 58.40,73.40
step
Follow the path |goto Durotar 50.85,79.14 < 15 |only if walking and not subzone("Kolkar Crag")
click Attack Plan: Valley of Trials
|tip Inside the building.
Destroy the Attack Plan: Valley of Trials |q 786/1 |goto Durotar 49.82,81.28
step
click Attack Plan: Sen'jin Village
Destroy the Attack Plan: Sen'jin Village |q 786/2 |goto Durotar 47.66,77.34
step
click Attack Plan: Orgrimmar
|tip Follow the path around.
Destroy the Attack Plan: Orgrimmar |q 786/3 |goto Durotar 46.23,78.95
step
talk Pal'juh##275811
|tip Escort quest.
|tip Wait until she respawns, if missing.
accept Lost in the Shadows##99123 |goto Durotar/0 46.30,78.64
step
Escort Pal'juh out of Kolkar Crag |q 99123/1 |goto Durotar/0 51.41,79.29
|tip Follow and protect Pal'juh.
step
talk Master Vornal##3304
turnin A Solvent Spirit##818 |goto Durotar/0 55.94,74.40
turnin Lost in the Shadows##99123 |goto Durotar/0 55.94,74.40
step
talk Un'Thuwa##5880
|tip Inside the building.
Train Abilities |trainer Un'Thuwa##5880 |goto Durotar/0 56.31,75.11 |q 786
|only if Mage
step
talk Lar Prowltusk##3140
|tip Walks around.
|tip Multiple locations.
turnin Thwarting Kolkar Aggression##786 |goto Durotar 54.19,73.29
|mapmarker Durotar/0 54.00,76.20
|mapmarker Durotar/0 54.40,74.20
step
kill 6 Ridgeshade Creeper##266850 |q 96821/1 |goto Durotar/0 51.68,57.20
kill 6 Ridgeshade Lurker##266849 |q 96821/2 |goto Durotar/0 51.68,57.20
step
talk Brakk##265809
turnin The Adventurer##96652 |goto Durotar/0 52.02,47.31
accept The Great Outdoors##96604 |goto Durotar/0 52.02,47.31
step
Watch the dialogue
Use the {y}/sit{} Emote Near the Campfire |q 96604/1 |goto Durotar/0 52.02,47.31 |macro /sit
Gain the Boosted Rest Buff |q 96604/2 |goto Durotar/0 52.02,47.31
|tip Takes {o}1 minute{}.
step
talk Brakk##265809
turnin The Great Outdoors##96604		|goto Durotar/0 52.02,47.31
accept Camping 101: Cooking##96655		|goto Durotar/0 52.02,47.31
accept Camping 101: Skinning##97908		|goto Durotar/0 52.02,47.31 |only if skillmax("Skinning") >= 1
step
talk Orgnil Soulscar##3142
turnin Report to Orgnil##823 |goto Durotar 52.25,43.15
step
talk Gar'Thok##3139
|tip Upstairs inside the building.
turnin Legging It##96821 |goto Durotar/0 51.95,43.50
accept Vanquish the Betrayers##784 |goto Durotar 51.95,43.50
accept Encroachment##837 |goto Durotar 51.95,43.50
step
talk Thotar##3171
|tip Inside the building.
Train Abilities |trainer Thotar##3171 |goto Durotar/0 51.85,43.49 |q 2161
|only if Hunter
step
talk Kaplak##3170
|tip Upstairs inside the building.
Train Abilities |trainer Kaplak##3170 |goto Durotar/0 51.98,43.69 |q 2161
|only if Rogue
step
talk Turroc##266940
|tip Inside the building.
accept For Honor##96822 |goto Durotar/0 53.96,42.60
step
talk Tai'jin##3706
|tip Inside the building.
Train Abilities |trainer Tai'jin##3706 |goto Durotar/0 54.26,42.93 |q 5649
|only if Priest
step
talk Tai'jin##3706
|tip Inside the building.
turnin In Favor of Spirituality##5649 |goto Durotar 54.26,42.93
accept Garments of Spirituality##5648 |goto Durotar 54.26,42.93
|only if Priest
step
Heal and Fortify Grunt Kor'ja |q 5648/1 |goto Durotar 53.10,46.46
|tip Cast {o}Lesser Heal (Rank 2){} on Grunt Kor'ja.
|tip Cast {o}Power Word: Fortitude{} on Grunt Kor'ja.
|only if Priest
step
talk Tai'jin##3706
|tip Inside the building.
turnin Garments of Spirituality##5648 |goto Durotar 54.26,42.93
|only if Priest
step
talk Tarshaw Jaggedscar##3169
|tip Inside the building.
Train Abilities |trainer Tarshaw Jaggedscar##3169 |goto Durotar/0 54.19,42.47 |q 2161
|only if Warrior
step
talk Swart##3173
|tip Inside the building.
Train Abilities |trainer Swart##3173 |goto Durotar/0 54.42,42.59 |q 2161
|only if Shaman
step
_NOTE:_
Use Weapon Stones
|tip We will train Mining and Blacksmithing.
|tip Allows you to make and use {o}Sharpening Stones{}.
|tip Increases damage.
|tip Mine {o}Copper Ore{} as you see it.
|tip Use the {g}Rough Stones{} to make sharpening stones.
Click Here to Continue |confirm |q 2161
|only if Warrior or Rogue
step
talk Flakk##3168
buy Mining Pick##2901 |goto Durotar/0 52.98,41.97
|only if Warrior or Rogue
step
talk Krunn##3175
Train Apprentice Mining |skillmax Mining,75 |goto Durotar/0 51.82,40.89
|only if Warrior or Rogue
step
talk Dwukk##3174
Train Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Durotar/0 52.03,40.72
|only if Warrior or Rogue
step
talk Dhugru Gorelust##3172
|tip Outside behind the building.
Train Abilities |trainer Dhugru Gorelust##3172 |goto Durotar/0 54.38,41.19 |q 2161
|only if Warlock
step
talk Kitha##6027
|tip Buy available Grimoires.
|tip Outside behind the building.
Train Demon Abilities |vendor Kitha##6027 |goto Durotar/0 54.71,41.50 |q 2161
|only if Warlock
step
talk Innkeeper Grosk##6928
|tip Inside the building.
turnin A Peon's Burden##2161 |goto Durotar/0 51.52,41.65
step
talk Cook Torka##3191
Select _"Train me."_ |gossip 96866
Learn Cooking from Cook Torka in Razor Hill |q 96655/1 |goto Durotar/0 51.11,42.45
step
talk Cook Torka##3191
|tip Walks around.
turnin Camping 101: Cooking##96655 |goto Durotar 51.11,42.45
accept Break a Few Eggs##815 |goto Durotar 51.11,42.45
accept This Fruit Could Bite Back##96825 |goto Durotar 51.11,42.45
stickystart "Kill_Razormane_Quilboars_And_Scouts"
step
click Prickly Pear Fruit+
|tip Cactuses with red fruit.
collect 8 Prickly Pear Fruit##275718 |q 96825/1 |goto Durotar/0 46.17,49.03
step
label "Kill_Razormane_Quilboars_And_Scouts"
kill 4 Razormane Quilboar##3111 |q 837/1 |goto Durotar/0 46.17,49.03
kill 4 Razormane Scout##3112 |q 837/2 |goto Durotar/0 46.17,49.03
step
talk Furl Scornbrow##3147
|tip Top of the tower.
accept Carry Your Weight##791 |goto Durotar 49.89,40.38
step
talk Cook Torka##3191
|tip Walks around.
turnin This Fruit Could Bite Back##96825 |goto Durotar 51.11,42.45
step
talk Thotar##3171
|tip Inside the building.
Train Abilities |trainer Thotar##3171 |goto Durotar/0 51.85,43.49 |q 784
|only if Hunter
step
talk Kaplak##3170
|tip Upstairs inside the building.
Train Abilities |trainer Kaplak##3170 |goto Durotar/0 51.98,43.69 |q 784
|only if Rogue
step
talk Tai'jin##3706
|tip Inside the building.
Train Abilities |trainer Tai'jin##3706 |goto Durotar/0 54.26,42.93 |q 784
|only if Priest
step
talk Tarshaw Jaggedscar##3169
|tip Inside the building.
Train Abilities |trainer Tarshaw Jaggedscar##3169 |goto Durotar/0 54.19,42.47 |q 784
|only if Warrior
step
talk Swart##3173
|tip Inside the building.
Train Abilities |trainer Swart##3173 |goto Durotar/0 54.42,42.59 |q 784
|only if Shaman
step
talk Dhugru Gorelust##3172
|tip Outside behind the building.
Train Abilities |trainer Dhugru Gorelust##3172 |goto Durotar/0 54.38,41.19 |q 784
|only if Warlock
step
talk Kitha##6027
|tip Buy available Grimoires.
|tip Outside behind the building.
Train Demon Abilities |vendor Kitha##6027 |goto Durotar/0 54.71,41.50 |q 784
|only if Warlock
stickystart "Collect_Canvas_Scraps"
stickystart "Kill_Kul_Tiras_Enemies"
step
click Raider's Shield
|tip Inside the tower.
collect Raider's Shield##275717 |q 96822/3 |goto Durotar/0 56.53,53.00
step
click Raider's Battleaxe
collect Raider's Battleaxe##275716 |q 96822/2 |goto Durotar/0 57.35,56.45
step
click Raider's Bow
|tip On the platform.
collect Raider's Bow##275713 |q 96822/1 |goto Durotar/0 57.30,57.95
|mapmarker Durotar/0 59.40,56.40
step
kill Lieutenant Benedict##3192 |q 784/3 |goto Durotar 59.71,58.27
|tip Upstairs inside the building.
collect Benedict's Key##4882 |goto Durotar 59.71,58.27 |q 830 |future
step
Follow the path and run further up the stairs |goto Durotar 59.90,57.87 < 7 |walk
click Benedict's Chest
|tip Top of the building.
collect Aged Envelope##4881 |goto Durotar 59.26,57.66 |q 830 |future
step
use Aged Envelope##4881
accept The Admiral's Orders##830
step
label "Collect_Canvas_Scraps"
kill Kul Tiras Sailor##3128, Kul Tiras Marine##3129
collect 8 Canvas Scraps##4870 |q 791/1 |goto Durotar/0 58.08,55.78
step
label "Kill_Kul_Tiras_Enemies"
kill 8 Kul Tiras Marine##3129 |q 784/2 |goto Durotar/0 58.08,55.78
kill 10 Kul Tiras Sailor##3128 |q 784/1 |goto Durotar/0 58.08,55.78
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Durotar/0 58.08,55.78 |q 830
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Durotar 53.51,44.45 |q 830 |zombiewalk
|only if not hardcore()
step
talk Gar'Thok##3139
|tip Upstairs inside the building.
turnin Vanquish the Betrayers##784 |goto Durotar 51.95,43.50
accept From The Wreckage....##825 |goto Durotar 51.95,43.50
turnin The Admiral's Orders##830 |goto Durotar 51.95,43.50
step
Follow the path up |goto Durotar 50.09,43.01 < 10 |only if walking
talk Furl Scornbrow##3147
|tip Top of the tower.
turnin Carry Your Weight##791 |goto Durotar 49.89,40.38
step
talk Innkeeper Grosk##6928
|tip Inside the building.
home Razor Hill |goto Durotar/0 51.52,41.65
step
talk Turroc##266940
|tip Inside the building.
turnin For Honor##96822 |goto Durotar/0 53.96,42.60
step
talk Rawrk##5943
|tip Inside the building.
Train Apprentice First Aid |skillmax First Aid,75 |goto Durotar 54.17,41.93
|only if Warrior or Rogue
step
_NOTE:_
Create Bandages in Downtime
|tip While waiting for things like boats.
|tip Increases skill in First Aid.
|tip Need higher skill to make better bandages.
|tip Keep bandages to heal yourself.
Click Here to Continue |confirm |q 808
|only if Warrior or Rogue
step
click Gnomish Toolbox
|tip Grey metal chests.
|tip Inside and near sunken ships.
|tip Underwater.
collect 3 Gnomish Tools##4863 |q 825/1 |goto Durotar/0 62.03,56.06
stickystart "Collect_Taillasher_Eggs"
stickystart "Collect_Durotar_Tiger_Fur"
step
kill Bloodtalon Matriarch##268530
|tip Brown raptor.
|tip Walks around.
collect Bloodtalon Martriarch Eggs##277128 |q 97223/1 |goto Durotar/0 68.71,71.66
stickystart "Collect_Forgotten_Loa_Idols"
stickystart "Kill_Hexed_Trolls_And_Voodoo_Trolls"
step
kill Zalazane##3205
|tip Troll wearing a red robe.
|tip Walks around.
collect Zalazane's Head##4866 |q 826/3 |goto Durotar 67.40,86.40
step
click Imprisoned Darkspear
|tip Skulls.
collect Minshina's Skull##4864 |q 808/1 |goto Durotar 67.45,87.81
step
label "Collect_Forgotten_Loa_Idols"
click Forgotten Loa Idol+
|tip Small snake statues.
collect 8 Forgotten Loa Idol##277135 |q 97225/1 |goto Durotar/0 66.81,85.21
step
label "Kill_Hexed_Trolls_And_Voodoo_Trolls"
kill 8 Hexed Troll##3207 |q 826/1 |goto Durotar/0 67.36,85.03
kill 8 Voodoo Troll##3206 |q 826/2 |goto Durotar/0 67.36,85.03
step
label "Collect_Taillasher_Eggs"
click Taillasher Eggs+
|tip Clusters of purple eggs.
|tip Near trees.
collect 3 Taillasher Egg##4890 |q 815/1 |goto Durotar/0 63.90,85.50
step
label "Collect_Durotar_Tiger_Fur"
kill Durotar Tiger##3121+
collect 4 Durotar Tiger Fur##4892 |q 817/1 |goto Durotar/0 60.54,89.71
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Anywhere in Echo Isles.
Die on Purpose |complete isdead |goto Durotar/0 60.54,89.71
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Durotar 57.50,73.26 |q 817 |zombiewalk
|only if not hardcore()
step
talk Un'Thuwa##5880
|tip Inside the building.
Train Abilities |trainer Un'Thuwa##5880 |goto Durotar/0 56.31,75.11 |q 808
|only if Mage
step
_NOTE:_
When Turning in Quests
|tip Save the {g}Faintly Glowing Skull{} quest reward.
|tip Used later to make a quest easier.
Click Here to Continue |confirm |q 808
step
talk Master Gadrin##3188
turnin Minshina's Skull##808 |goto Durotar 55.95,74.72
turnin Zalazane##826 |goto Durotar 55.95,74.72
turnin Forgotten Loa Idols##97225 |goto Durotar 55.95,74.72
step
talk Vel'rin Fang##3194
|tip Inside the building.
turnin Practical Prey##817 |goto Durotar 55.95,73.93
step
talk Xar'Ti##7953
turnin Bloodtalon Matriarch##97223 |goto Durotar/0 55.25,75.57
step
talk Cook Torka##3191
|tip Walks around.
turnin Break a Few Eggs##815 |goto Durotar 51.11,42.45
step
talk Gar'Thok##3139
|tip Upstairs inside the building.
turnin From The Wreckage....##825 |goto Durotar 51.95,43.50
accept The Admiral's Orders##831 |goto Durotar 51.95,43.50
step
talk Orgnil Soulscar##3142
accept A Missing Hand##99048 |goto Durotar/0 52.24,43.15
step
talk Heglan Shadeeye##275657
|tip Inside the building.
turnin A Missing Hand##99048 |goto Durotar/0 58.60,45.61
accept Threat from Below##99049 |goto Durotar/0 58.60,45.61
step
click Weapon Piece
collect Broken Bone Trident##286010 |q 99049/3 |goto Durotar/0 60.10,44.80
step
click Strange Debris
collect Banner Scrap##286011 |q 99049/2 |goto Durotar/0 60.08,42.42
step
click Abandoned Dagger
collect Orcish Dagger##286012 |q 99049/1 |q 99049/1 |goto Durotar/0 58.85,44.36
step
talk Orgnil Soulscar##3142
turnin Threat from Below##99049 |goto Durotar/0 52.24,43.15
accept Threat from Below##99051 |goto Durotar/0 52.24,43.15
step
talk Tai'jin##3706
|tip Inside the building.
Train Abilities |trainer Tai'jin##3706 |goto Durotar/0 54.26,42.93 |q 837
|only if Priest
step
talk Tai'jin##3706
|tip Inside the building.
accept Hex of Weakness##5654 |goto Durotar/0 54.26,42.93
|only if Priest
step
talk Kaplak##3170
|tip Upstairs inside the building.
Train Abilities |trainer Kaplak##3170 |goto Durotar/0 51.98,43.69 |q 837
|only if Rogue
step
talk Kaplak##3170
|tip Upstairs inside the building.
accept Therzok##1859 |goto Durotar/0 51.98,43.69
|only if Rogue
step
talk Dhugru Gorelust##3172
|tip Outside behind the building.
Train Abilities |trainer Dhugru Gorelust##3172 |goto Durotar/0 54.38,41.19 |q 837
|only if Warlock
step
talk Kitha##6027
|tip Buy available Grimoires.
|tip Outside behind the building.
Train Demon Abilities |vendor Kitha##6027 |goto Durotar/0 54.71,41.50 |q 837
|only if Warlock
step
talk Tarshaw Jaggedscar##3169
|tip Inside the building.
Train Abilities |trainer Tarshaw Jaggedscar##3169 |goto Durotar/0 54.19,42.47 |q 837
|only if Warrior
step
talk Tarshaw Jaggedscar##3169
|tip Inside the building.
accept Veteran Uzzek##1505 |goto Durotar/0 54.19,42.47
|only if Warrior
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 10 ammo when restocking.
Click Here to Continue |confirm |q 6062 |future
|only if Hunter
step
talk Thotar##3171
|tip Inside the building.
Train Abilities |trainer Thotar##3171 |goto Durotar/0 51.85,43.49 |q 6062 |future
|only if Hunter
step
talk Thotar##3171
|tip Inside the building.
accept Taming the Beast##6062 |goto Durotar/0 51.85,43.49
|only if Hunter
step
use Taming Rod##15917
|tip On a Dire Mottled Boar.
Tame a Dire Mottled Boar |q 6062/1 |goto Durotar/0 51.40,48.00
|mapmarker Durotar/0 50.40,44.40
|mapmarker Durotar/0 50.40,52.00
|mapmarker Durotar/0 54.00,45.40
|mapmarker Durotar/0 54.20,50.60
|mapmarker Durotar/0 56.60,47.00
|mapmarker Durotar/0 57.20,50.20
|only if Hunter
step
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6062 |goto Durotar/0 51.85,43.49
accept Taming the Beast##6083 |goto Durotar/0 51.85,43.49
|only if Hunter
step
use Taming Rod##15919
|tip On a Surf Crawler.
|tip Crabs.
|tip Dismiss your pet first.
Tame a Surf Crawler |q 6083/1 |goto Durotar/0 57.80,28.00
|mapmarker Durotar/0 59.40,23.00
|mapmarker Durotar/0 59.80,31.00
|mapmarker Durotar/0 60.40,26.00
|only if Hunter
step
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6083 |goto Durotar/0 51.85,43.49
accept Taming the Beast##6082 |goto Durotar/0 51.85,43.49
|only if Hunter
step
use Taming Rod##15920
|tip On an Armored Scorpid.
|tip Dismiss your pet first.
Tame an Armored Scorpid |q 6082/1 |goto Durotar/0 55.00,38.20
|mapmarker Durotar/0 54.00,33.80
|mapmarker Durotar/0 54.20,30.40
|mapmarker Durotar/0 57.20,29.00
|only if Hunter
step
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6082 |goto Durotar/0 51.85,43.49
accept Training the Beast##6081 |goto Durotar/0 51.85,43.49
|only if Hunter
step
talk Grimtak##3881
buy Tough Jerky##117 |n
|tip Buy {o}20{}, or whatever you can afford.
|tip Used to feed your pet soon.
Visit the Vendor |vendor Grimtak##3881 |goto Durotar 51.13,42.63 |q 6081
|only if Hunter
step
talk Rhinag##3190
|tip Between the rocks.
|tip {o}Hurry{}, timed quest.
accept Need for a Cure##812 |goto Durotar/0 41.55,18.61
|only if Hunter
step
talk Thatog##268701
|tip {o}Top floor{} inside the building.
accept Meal Appeal##97246 |goto Orgrimmar/0 55.58,72.19
|only if Hunter
step
Run up the stairs |goto Orgrimmar/0 56.40,56.75 < 15 |only if walking
talk Borstan##3368
|tip Inside the building.
turnin Meal Appeal##97246 |goto Orgrimmar/0 57.19,53.33
accept Favorite Food##97249 |goto Orgrimmar/0 57.19,53.33
|only if Hunter
step
talk Thuwd##7088
|tip Inside the building.
turnin Camping 101: Skinning##97908 |goto Orgrimmar/0 63.36,45.42
|only if Hunter and (haveq(97908) or completedq(97908))
step
talk Kor'geld##3348
|tip Inside the building.
accept Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if Hunter
step
talk Ormak Grimshot##3352
|tip Top of the building.
turnin Training the Beast##6081 |goto Orgrimmar/0 66.05,18.54
|only if Hunter
step
_NOTE:_
Train Your Pet
|tip Learn pet abilities from Pet Trainers.
|tip Cast {o}Beast Training{} to teach your pet.
Click Here to Continue |confirm |q 837
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.34,14.83 |q 837
|only if Hunter
stickystart "Collect_Speargrass_Cuttings"
step
click Cattail+
|tip Long brown plants.
collect 2 Handful of Cattails##277278 |q 97242/1 |goto Orgrimmar/0 67.79,30.26
|only if Hunter
step
label "Collect_Speargrass_Cuttings"
click Speargrass+
|tip Green grass.
collect 4 Speargrass Cuttings##277279 |q 97242/2 |goto Orgrimmar/0 67.79,30.26
|only if Hunter
step
talk Kor'geld##3348
|tip Inside the building.
turnin Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if Hunter
step
talk Yelmak##3347
|tip Walks around.
|tip Inside the building.
accept Whuut's the Rush##97275 |goto Orgrimmar/0 56.84,33.03
|tip May need to wait.
|only if Hunter
step
talk Whuut##11046
|tip Inside the building.
turnin Whuut's the Rush##97275 |goto Orgrimmar/0 55.80,32.90
|only if Hunter
step
talk Migi##268682
|tip Outside the building.
turnin Favorite Food##97249 |goto Orgrimmar/0 36.55,29.10
|only if Hunter
step
talk Thra##268684
|tip Outside the building.
accept Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
|only if Hunter
step
click Smooth Boulder+
|tip Brown rocks.
collect 8 Smooth Boulder##277952 |q 97326/1 |goto Orgrimmar/0 43.83,34.70
|only if Hunter
step
talk Thra##268684
|tip Outside the building.
turnin Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
|only if Hunter
step
talk Nazgrel##3230
|tip Inside the building.
turnin The Admiral's Orders##831 |goto Orgrimmar/0 32.27,35.80
|only if Hunter
step
talk Thrall##4949
|tip Inside the building.
accept Hidden Enemies##5726 |goto Orgrimmar/0 31.75,37.82
|only if Hunter
step
talk Kor'ghan##3189
|tip Inside the Cleft of Shadow.
accept Finding the Antidote##813 |goto Orgrimmar 47.24,53.58
|only if haveq(812) and Hunter
step
Abandon the {y}Need for a Cure{} Quest |complete not haveq(812)
|tip Not needed.
|tip Removes the quest timer.
|only if Hunter
step
talk Doras##3310
|tip Top of the tower.
fpath Orgrimmar |goto Orgrimmar 45.13,63.90
|only if Hunter
step
_NOTE:_
Tame a Venomtail Scorpid
|tip Cast {o}Tame Beast{} on a {o}Venomtail Scorpid{}.
|tip Scorpions.
|tip New permanent pet.
|tip Dismiss your pet first.
Click Here to Continue |confirm |goto Durotar 49.80,17.40 |q 837
|mapmarker Durotar/0 38.00,19.20
|mapmarker Durotar/0 38.20,22.40
|mapmarker Durotar/0 39.20,16.40
|mapmarker Durotar/0 41.40,19.40
|mapmarker Durotar/0 44.40,21.00
|mapmarker Durotar/0 43.40,16.60
|mapmarker Durotar/0 52.80,12.80
|mapmarker Durotar/0 55.40,15.20
|mapmarker Durotar/0 55.80,12.20
|only if Hunter
step
talk Misha Tor'kren##3193
|tip Walks around.
|tip Inside the building.
accept Lost But Not Forgotten##816 |goto Durotar 43.11,30.24
|only if Hunter
step
talk Swart##3173
|tip Inside the building.
Train Abilities |trainer Swart##3173 |goto Durotar/0 54.42,42.59 |q 837
|only if Shaman
step
talk Swart##3173
|tip Inside the building.
accept Call of Fire##2983 |goto Durotar/0 54.42,42.59
|only if Shaman
step
kill 4 Razormane Dustrunner##3113 |q 837/3 |goto Durotar/0 43.43,39.15
kill 4 Razormane Battleguard##3114 |q 837/4 |goto Durotar/0 43.43,39.15
step
talk Misha Tor'kren##3193
|tip Walks around.
|tip Inside the building.
accept Lost But Not Forgotten##816 |goto Durotar 43.11,30.24
|only if not Hunter
step
talk Kranal Fiss##5907
|tip Walks around.
turnin Call of Fire##2983 |goto The Barrens 56.03,19.89
accept Call of Fire##1524 |goto The Barrens 56.03,19.89
|only if Shaman
step
Follow the path up |goto Durotar 36.59,57.07 < 20 |only if walking
talk Telf Joolam##5900
|tip Top of the mountain.
turnin Call of Fire##1524 |goto Durotar 38.55,58.96
accept Call of Fire##1525 |goto Durotar 38.55,58.96
|only if Shaman
step
kill Razormane Geomancer##3269, Razormane Thornweaver##3268, Razormane Mystic##3271, Razormane Water Seeker##3267
|tip Thornweavers and Water Seekers.
collect Fire Tar##5026 |q 1525/1 |goto The Barrens/0 54.33,24.72
|only if Shaman
step
talk Gar'Thok##3139
|tip Upstairs inside the building.
turnin Encroachment##837 |goto Durotar 51.95,43.50
step
talk Orgnil Soulscar##3142
accept Dark Storms##806 |goto Durotar/0 52.24,43.15
step
Follow the path up |goto 54.54,38.79 < 40 |only if walking and not (subzone("Dustwind Cave") and indoors())
kill Burning Blade Cultist##3199+
|tip Inside the cave.
|tip In the back.
collect Reagent Pouch##6652 |q 1525/2 |goto Durotar/0 52.80,28.60
|only if Shaman
step
Leave the cave |goto Durotar/0 52.80,28.60 < 15 |walk |only if subzone("Dustwind Cave") and indoors()
talk Rezlak##3293
accept Winds in the Desert##834 |goto Durotar 46.37,22.94
step
click Stolen Supply Sack+
|tip Tan bags.
collect 5 Sack of Supplies##4918 |q 834/1 |goto Durotar/0 49.61,22.58
step
talk Rezlak##3293
turnin Winds in the Desert##834 |goto Durotar 46.37,22.94
accept Securing the Lines##835 |goto Durotar 46.37,22.94
stickystart "Kill_Dustwind_Storm_Witches_And_Savages"
step
Follow the path and run through the tunnel |goto Durotar 51.95,27.44 < 15 |only if walking and not subzone("Drygulch Ravine")
kill Dustwind Storm Witch##3118+
collect Dull Storm Orb##277661 |n
use Dull Storm Orb##277661
accept A Simmering Storm##97281 |goto Durotar/0 53.10,24.08
step
label "Kill_Dustwind_Storm_Witches_And_Savages"
kill 8 Dustwind Storm Witch##3118 |q 835/2 |goto Durotar/0 53.10,24.08
kill 12 Dustwind Savage##3117 |q 835/1 |goto Durotar/0 53.10,24.08
step
Run through the tunnel |goto Durotar/0 53.51,27.79 < 15 |only if walking and subzone("Drygulch Ravine")
talk Rezlak##3293
turnin Securing the Lines##835 |goto Durotar/0 46.37,22.94
turnin A Simmering Storm##97281 |goto Durotar/0 46.37,22.94
accept Stormy Potential##97282 |goto Durotar/0 46.37,22.94
step
talk Rhinag##3190
|tip Between the rocks.
|tip {o}Hurry{}, timed quest.
accept Need for a Cure##812 |goto Durotar/0 41.55,18.61
|only if not Hunter
step
talk Thatog##268701
|tip {o}Top floor{} inside the building.
accept Meal Appeal##97246 |goto Orgrimmar/0 55.58,72.19
|only if not Hunter
step
Run up the stairs |goto Orgrimmar/0 56.40,56.75 < 15 |only if walking
talk Borstan##3368
|tip Inside the building.
turnin Meal Appeal##97246 |goto Orgrimmar/0 57.19,53.33
accept Favorite Food##97249 |goto Orgrimmar/0 57.19,53.33
|only if not Hunter
step
talk Thuwd##7088
|tip Inside the building.
turnin Camping 101: Skinning##97908 |goto Orgrimmar/0 63.36,45.42
|only if not Hunter and (haveq(97908) or completedq(97908))
step
talk Kor'geld##3348
|tip Inside the building.
accept Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if not Hunter
stickystart "Collect_Speargrass_Cuttings"
step
click Cattail+
|tip Long brown plants.
collect 2 Handful of Cattails##277278 |q 97242/1 |goto Orgrimmar/0 67.79,30.26
|only if not Hunter
step
label "Collect_Speargrass_Cuttings"
click Speargrass+
|tip Green grass.
collect 4 Speargrass Cuttings##277279 |q 97242/2 |goto Orgrimmar/0 67.79,30.26
|only if not Hunter
step
talk Kor'geld##3348
|tip Inside the building.
turnin Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if not Hunter
step
talk Yelmak##3347
|tip Walks around.
|tip Inside the building.
accept Whuut's the Rush##97275 |goto Orgrimmar/0 56.84,33.03
|tip May need to wait.
|only if not Hunter
step
talk Whuut##11046
|tip Inside the building.
turnin Whuut's the Rush##97275 |goto Orgrimmar/0 55.80,32.90
|only if not Hunter
step
talk Migi##268682
|tip Outside the building.
turnin Favorite Food##97249 |goto Orgrimmar/0 36.55,29.10
|only if not Hunter
step
talk Thra##268684
|tip Outside the building.
accept Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
|only if not Hunter
step
click Smooth Boulder+
|tip Brown rocks.
collect 8 Smooth Boulder##277952 |q 97326/1 |goto Orgrimmar/0 43.83,34.70
|only if not Hunter
step
talk Thra##268684
|tip Outside the building.
turnin Rocks to Rests##97326 |goto Orgrimmar/0 37.59,29.45
|only if not Hunter
step
talk Nazgrel##3230
|tip Inside the building.
turnin The Admiral's Orders##831 |goto Orgrimmar/0 32.27,35.80
|only if not Hunter
step
talk Thrall##4949
|tip Inside the building.
accept Hidden Enemies##5726 |goto Orgrimmar/0 31.75,37.82
|only if not Hunter
step
talk Kor'ghan##3189
|tip Inside the Cleft of Shadow.
accept Finding the Antidote##813 |goto Orgrimmar 47.24,53.58
|only if haveq(812) and not Hunter
step
Abandon the {y}Need for a Cure{} Quest |complete not haveq(812)
|tip Not needed.
|tip Removes the quest timer.
|only if not Hunter
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin Gan'rul's Summons##1506 |goto Orgrimmar 48.25,45.29
accept Creature of the Void##1501 |goto Orgrimmar 48.25,45.29
|only if Warlock
step
talk Therzok##6446
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin Therzok##1859 |goto Orgrimmar/0 42.74,53.54
accept The Shattered Hand##1963 |goto Orgrimmar/0 42.74,53.54
|only if Rogue
step
talk Ur'kyo##6018
|tip Inside the building.
turnin Hex of Weakness##5654 |goto Orgrimmar/0 35.59,87.80
|only if Priest
step
talk Doras##3310
|tip Top of the tower.
fpath Orgrimmar |goto Orgrimmar 45.13,63.90
|only if not Hunter
step
kill Venomtail Scorpid##3127+
|tip Scorpions.
collect 4 Venomtail Poison Sac##4886 |q 813/1 |goto Durotar/0 41.98,18.82
step
talk Kor'ghan##3189
|tip Inside the Cleft of Shadow.
turnin Finding the Antidote##813 |goto Orgrimmar 47.24,53.58
step
talk Rhinag##3190
|tip Between the rocks.
accept Need for a Cure##812 |goto Durotar/0 41.55,18.61
step
talk Rhinag##3190
|tip Between the rocks.
turnin Need for a Cure##812 |goto Durotar/0 41.55,18.61
step
kill Dreadmaw Crocolisk##3110+
collect Kron's Amulet##4891 |q 816/1 |goto Durotar/0 36.53,19.93
step
Follow the path up |goto Durotar 36.59,57.07 < 15 |only if walking
talk Telf Joolam##5900
|tip Top of the mountain.
turnin Call of Fire##1525 |goto Durotar 38.55,58.96
accept Call of Fire##1526 |goto Durotar 38.55,58.96
|only if Shaman
step
use Fire Sapta##6636
|tip Top of the mountain.
Gain Sapta Sight |havebuff Sapta Sight##8898 |goto Durotar 38.16,58.54 |q 1526
|only if Shaman
step
kill Minor Manifestation of Fire##5893
|tip Top of the mountain.
collect Glowing Ember##6655 |q 1526/1 |goto Durotar 38.72,58.29
|only if Shaman
step
click Brazier of the Dormant Flame
|tip Top of the mountain.
turnin Call of Fire##1526 |goto Durotar 38.95,58.22
accept Call of Fire##1527 |goto Durotar 38.95,58.22
|only if Shaman
step
talk Kranal Fiss##5907
|tip Walks around.
turnin Call of Fire##1527 |goto The Barrens 56.04,19.89
|only if Shaman
step
talk Uzzek##5810
turnin Veteran Uzzek##1505 |goto The Barrens 61.38,21.11
accept Path of Defense##1498 |goto The Barrens 61.38,21.11
|only if Warrior
stickystart "Collect_Charged_Thunder_Lizard_Organs"
stickystart "Collect_Singed_Scales_Warrior"
step
Jump down carefully |goto Durotar/0 38.90,24.11 < 15 |only if walking
use Faintly Glowing Skull##4945
|tip On Fizzle Darkstorm when he's {o}next to the bonfire{}.
|tip Damages him.
|tip Goblin with imp minion.
|tip Walks around.
|tip Clear most enemies first and pull him away.
kill Fizzle Darkstorm##3203
|tip Kill his imp first.
collect Fizzle's Claw##4869 |q 806/1 |goto Durotar 42.28,26.59
step
label "Collect_Charged_Thunder_Lizard_Organs"
kill Lightning Hide##3131, Thunder Lizard##3130
|tip Dinosaurs.
collect 5 Charged Thunder Lizard Organ##277665 |q 97282/1 |goto Durotar/0 40.41,24.13
step
label "Collect_Singed_Scales_Warrior"
kill Thunder Lizard##3130+
collect 5 Singed Scale##6486 |q 1498/1 |goto Durotar/0 40.41,24.13
|only if Warrior
step
Kill enemies
|tip Helps reach level 12 after quest turnins.
ding 11,5500 |goto Durotar/0 40.41,24.13 |only if Warrior
ding 11,6130 |goto Durotar/0 40.41,24.13 |only if not Warrior
step
Leave the canyon |goto Durotar 39.16,32.31 < 40 |only if walking and subzone("Thunder Ridge")
talk Uzzek##5810
turnin Path of Defense##1498 |goto The Barrens 61.38,21.11
|only if Warrior
step
Leave the canyon |goto Durotar 39.16,32.31 < 40 |only if walking and subzone("Thunder Ridge")
talk Misha Tor'kren##3193
|tip Walks around.
|tip Inside the building.
turnin Lost But Not Forgotten##816 |goto Durotar 43.10,30.24
step
talk Rezlak##3293
turnin Stormy Potential##97282 |goto Durotar/0 46.37,22.94
step
talk Orgnil Soulscar##3142
turnin Dark Storms##806 |goto Durotar/0 52.24,43.15
accept Margoz##828 |goto Durotar/0 52.24,43.15
step
talk Kaplak##3170
|tip Upstairs inside the building.
Train Abilities |trainer Kaplak##3170 |goto Durotar/0 51.98,43.69 |q 828
|only if Rogue
step
talk Thotar##3171
|tip Inside the building.
Train Abilities |trainer Thotar##3171 |goto Durotar/0 51.85,43.49 |q 828
|only if Hunter
step
talk Harruk##3620
|tip Inside the building.
Train Pet Abilities |trainer Harruk##3620 |goto Durotar/0 52.02,43.55 |q 828
|only if Hunter
step
talk Tai'jin##3706
|tip Inside the building.
Train Abilities |trainer Tai'jin##3706 |goto Durotar/0 54.26,42.93 |q 828
|only if Priest
step
talk Tarshaw Jaggedscar##3169
|tip Inside the building.
Train Abilities |trainer Tarshaw Jaggedscar##3169 |goto Durotar/0 54.19,42.47 |q 828
|only if Warrior
step
talk Swart##3173
|tip Inside the building.
Train Abilities |trainer Swart##3173 |goto Durotar/0 54.42,42.59 |q 828
|only if Shaman
step
talk Dhugru Gorelust##3172
|tip Outside behind the building.
Train Abilities |trainer Dhugru Gorelust##3172 |goto Durotar/0 54.38,41.19 |q 828
|only if Warlock
step
talk Kitha##6027
|tip Buy available Grimoires.
|tip Outside behind the building.
Train Demon Abilities |vendor Kitha##6027 |goto Durotar/0 54.71,41.50 |q 828
|only if Warlock
step
kill Spitelash Scout##275662, Spitelash Attendant##275663
|tip Nagas.
collect 9 Naga Spinefin##286008 |q 99051/1 |goto Durotar/0 59.25,25.29
step
talk Margoz##3208
turnin Margoz##828 |goto Durotar 56.41,20.04
accept Skull Rock##827 |goto Durotar 56.41,20.04
stickystart "Collect_Lieutenants_Insignia_And_Searing_Collars"
step
Enter the cave |goto Durotar 54.98,9.67 < 15 |walk |only if not (subzone("Skull Rock") and indoors())
click Burning Blade Stash##58595
|tip Inside the cave.
collect Tablet of Verga##6535 |q 1501/1 |goto Durotar 51.62,9.74
|only if Warlock
step
label "Collect_Lieutenants_Insignia_And_Searing_Collars"
kill Burning Blade Apprentice##3198, Burning Blade Fanatic##3197
|tip Inside the cave.
collect Lieutenant's Insignia##14544 |q 5726/1 |goto Durotar 54.98,9.67
collect 6 Searing Collar##4871 |q 827/1 |goto Durotar 54.98,9.67
step
Leave the cave |goto Durotar 52.82,28.90 < 15 |walk |only if subzone("Skull Rock") and indoors()
talk Margoz##3208
turnin Skull Rock##827 |goto Durotar 56.41,20.03
accept Neeru Fireblade##829 |goto Durotar 56.41,20.03
step
use Eye of Burning Shadow##4903
accept Burning Shadows##832
|only if itemcount(4903) > 0
step
talk Hanashi##2704
|tip Inside the building.
Train Staves |complete weaponskill("TH_STAFF") > 0 |goto Orgrimmar/0 81.53,19.63
|only if Warrior
step
talk Thrall##4949
|tip Inside the building.
turnin Hidden Enemies##5726 |goto Orgrimmar/0 31.76,37.82
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin Creature of the Void##1501 |goto Orgrimmar/0 48.24,45.28
accept The Binding##1504 |goto Orgrimmar/0 48.24,45.28
|only if Orc Warlock
step
talk Neeru Fireblade##3216
|tip Inside the tent.
turnin Neeru Fireblade##829 |goto Orgrimmar/0 49.48,50.60
accept Ak'Zeloth##809 |goto Orgrimmar/0 49.48,50.60
turnin Burning Shadows##832 |goto Orgrimmar/0 49.48,50.60 |only if (haveq(832) or completedq(832))
step
use Glyphs of Summoning##7464
|tip On the pink symbol.
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
kill Summoned Voidwalker##5676 |q 1504/1 |goto Orgrimmar/0 49.43,50.00
|only if Orc Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin The Binding##1504 |goto Orgrimmar/0 48.24,45.28
|only if Orc Warlock
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 1881 |future
|only if Mage
step
talk Deathguard Bartholomew##1742
accept Sticks and Bones##86784 |goto Tirisfal Glades/0 58.47,51.39
step
click Dry Branch+
|tip Brown sticks.
|tip Usually near trees.
collect 6 Dry Branch##279991 |q 86784/1 |goto Tirisfal Glades/0 57.94,54.08
step
talk Eleanor Shackleton##265812
turnin Sticks and Bones##86784 |goto Tirisfal Glades/0 57.27,55.48
step
talk Apothecary Johaan##1518
|tip Inside the building.
accept Delivery to Silverpine Forest##445 |goto Tirisfal Glades 59.45,52.40
step
talk Deathguard Terrence##1738
accept The Argent Emissary##96895 |goto Tirisfal Glades/0 61.50,53.49
step
talk Hadric Harlson##267009
turnin The Argent Emissary##96895 |goto Tirisfal Glades/0 65.93,61.11
accept The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
accept Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
stickystart "Kill_Dark_Neophytes_And_Dark_Enforcers"
step
kill Dark Enforcer##275437, Dark Neophyte##267006
click Naxxramas Crystal Fragment+
|tip Black crystals.
collect 12 Necrotic Crystal Fragment##275851 |q 96898/1 |goto Tirisfal Glades/0 68.26,64.73
step
label "Kill_Dark_Neophytes_And_Dark_Enforcers"
kill 8 Dark Neophyte##267006 |q 96897/1 |goto Tirisfal Glades/0 68.26,64.73
kill 8 Dark Enforcer##275437 |q 96897/2 |goto Tirisfal Glades/0 68.26,64.73
step
talk Hadric Harlson##267009
turnin The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
turnin Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
step
talk Michael Garrett##4551
fpath Undercity |goto Undercity 63.28,48.58
step
talk Archibald##11870
Train Swords |complete weaponskill("SWORD") > 0 |goto Undercity 57.31,32.77
|only if Rogue
step
talk Alessandro Luca##7683
accept Prompt Potion Runner##97891 |goto Undercity/0 58.62,54.66
step
Follow the path down |goto Undercity/0 52.83,77.69 < 10 |walk
talk Doctor Martin Felben##11044
turnin Prompt Potion Runner##97891 |goto Undercity/0 46.60,74.08
|delay 0.2
step
_Destroy This Item:_
|tip Not needed.
trash Inert Potion##279023
]])
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Silverpine Forest (13-15)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\The Barrens & Stonetalon Mountain (15-21)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ashenvale (21-22)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Hillsbrad Foothills (22-24)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\The Barrens (24-25)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stonetalon Mountains (25-26)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ashenvale (26-28)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Thousand Needles (28-30)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Hillsbrad Foothills (30-32)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Arathi Highlands (32-33)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Thousand Needles (33-34)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Desolace (34-36)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale (36-37)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Dustwallow Marsh (37-38)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Alterac Mountains & Arathi Highlands (38-39)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Badlands (39-40)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale & Swamp of Sorrows (40-41)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Desolace (41-41)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Tanaris (41-42)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Dustwallow Marsh (42-42)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Tanaris (42-43)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Feralas (43-44)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale (44-45)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Swamp of Sorrows (45-46)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Tanaris & Dustwallow Marsh (46-48)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\The Hinterlands (48-49)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Feralas & Un'Goro Crater (49-50)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale & Swamp of Sorrows (50-50)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Blasted Lands (50-51)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Searing Gorge (51-51)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Burning Steppes & Azshara (51-52)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Felwood & Winterspring (52-53)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Un'Goro Crater (53-54)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Azshara (54-54)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Felwood & Winterspring (54-56)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Western & Eastern Plaguelands (56-58)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Winterspring (58-59)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Silithus (59-60)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Ruins of Ahn'Qiraj Cloak Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Ruins of Ahn'Qiraj Ring Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Ruins of Ahn'Qiraj Weapon Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Shoulder Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Boots Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Helm Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Legs Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Chest Quest")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Scepter of the Shifting Sands")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Signet Ring of the Bronze Dragonflight")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ahn'Qiraj Gear\\Cenarion Battlegear")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Cenarion Field Duty Combat Assignments")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Cenarion Field Duty Tactical Assignments")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Cenarion Field Duty Logistics Assignments")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Druid Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Priest Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Warrior Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Hunter Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Mage Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Rogue Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Shaman Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Warlock Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Cozy Sleeping Bag")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\City of Dalaran Key")
