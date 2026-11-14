local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("LevelingHCLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Startup Guide Wizard",{
condition_visible=function() return false end,
noscoring = true,
orientation = true,
hardcore = true,
},[[
step
Welcome to the Zygor Startup Wizard!
In order for Zygor Guides to perform at its best we need to collect some character data.
This wizard will walk you through a few simple steps to do this.
confirm begin
step
Open the Talent Advisor tab in Zygor Settings, and select your preferred build. |complete ZGV.TalentAdvisor:IsBuildSelected()
step
findcity Main City
|tip You need to be in a capital city for the upcoming steps.
step
talknpcs Auctioneer |autoscript ZGV.ATWereEnabled=ZGV.db.profile.auction_enable ZGV.db.profile.auction_enable=true
Click the Scan button in the bottom right corner.
Record auction pricing data for the Gold Guide |complete ZGV.Gold:LastScan(15)
step
talknpcs Banker
|only if not ZGV.Inventory:CharacterBankKnown()
Record the items you have placed in your bank inventory. |complete ZGV.Inventory:CharacterBankKnown()
step
talknpcs Flightmaster
Record what flight points you have for the Travel System. | complete LibTaxi:IsContinentKnown()
step
openskill Alchemy
|only if hasprofunscanned("Alchemy")
Record your profession data for the Gold Guide. |complete hasprof("Alchemy",1)
step
openskill Blacksmithing
|only if hasprofunscanned("Blacksmithing")
Record your profession data for the Gold Guide. |complete hasprof("Blacksmithing",1)
step
openskill Cooking
|only if hasprofunscanned("Cooking")
Record your profession data for the Gold Guide. |complete hasprof("Cooking",1)
step
openskill Enchanting
|only if hasprofunscanned("Enchanting")
Record your profession data for the Gold Guide. |complete hasprof("Enchanting",1)
step
openskill Engineering
|only if hasprofunscanned("Engineering")
Record your profession data for the Gold Guide. |complete hasprof("Engineering",1)
step
openskill First Aid
|only if hasprofunscanned("First Aid")
Record your profession data for the Gold Guide. |complete hasprof("First Aid",1)
step
openskill Leatherworking
|only if hasprofunscanned("Leatherworking")
Record your profession data for the Gold Guide. |complete hasprof("Leatherworking",1)
step
openskill Mining
|only if hasprofunscanned("Mining")
Record your profession data for the Gold Guide. |complete hasprof("Mining",1)
step
openskill Tailoring
|only if hasprofunscanned("Tailoring")
Record your profession data for the Gold Guide. |complete hasprof("Tailoring",1)
step
You''re all set!
]])
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
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Silverpine Forest (13-15)",{
image=ZGV.IMAGESDIR.."Silverpine Forest",
hardcore = true,
next="Leveling Guides\\The Barrens & Stonetalon Mountain (15-21)",
},[[
step
talk Deathstalker Erland##1978
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Inside the building.
accept Escorting Erland##435 |goto Silverpine Forest 56.19,9.18 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Deathstalker Erland.
Erland Must Reach Rane Yorick |q 435/1 |goto Silverpine Forest 54.30,13.43
step
talk Rane Yorick##1950
turnin Escorting Erland##435 |goto Silverpine Forest 53.46,13.43
accept The Deathstalkers' Report##449 |goto Silverpine Forest 53.46,13.43
accept Wild Hearts##429 |goto Silverpine Forest 53.46,13.42
step
kill Mottled Worg##1766, Worg##1765
|tip Black wolves.
collect 3 Discolored Worg Heart##3164 |q 429/1 |goto Silverpine Forest/0 57.40,12.80
step
_NOTE:_
Tame a Ferocious Grizzled Bear
|tip Cast {o}Tame Beast{} on a {o}Ferocious Grizzled Bear{}.
|tip Abandon your pet first.
|tip New permanent pet.
Click Here to Continue |confirm |goto Silverpine Forest/0 51.20,21.60 |q 449
|mapmarker Silverpine Forest/0 47.00,18.40
|mapmarker Silverpine Forest/0 47.40,23.40
|mapmarker Silverpine Forest/0 48.80,15.60
|mapmarker Silverpine Forest/0 48.80,26.20
|mapmarker Silverpine Forest/0 49.00,33.00
|mapmarker Silverpine Forest/0 49.40,36.40
|mapmarker Silverpine Forest/0 50.00,42.80
|mapmarker Silverpine Forest/0 50.20,18.60
|mapmarker Silverpine Forest/0 50.40,39.40
|mapmarker Silverpine Forest/0 51.40,48.00
|mapmarker Silverpine Forest/0 53.40,38.40
|mapmarker Silverpine Forest/0 53.80,45.20
|mapmarker Silverpine Forest/0 56.00,43.00
|only if Hunter
step
talk Karos Razok##2226
fpath The Sepulcher |goto Silverpine Forest 45.62,42.60
step
talk Karos Razok##2226
|tip Open the flight map.
|tip Allows guide to learn your flight paths.
fpath Undercity |goto Silverpine Forest 45.62,42.60
|only if Scourge
step
talk Dalar Dawnweaver##1938
|tip Walks around.
accept Prove Your Worth##421 |goto Silverpine Forest/0 44.20,39.73
step
talk Shadow Priest Allister##2121
accept Border Crossings##477 |goto Silverpine Forest 43.98,40.93
step
talk Deathguard Podrig##6389
accept Supplying the Sepulcher##6321 |goto Silverpine Forest 43.43,41.68
|only if Scourge
step
Enter the crypt |goto Silverpine Forest 43.09,41.39 < 10 |walk |only if not (subzone("The Sepulcher") and indoors())
talk High Executor Hadrec##1952
|tip Downstairs inside the crypt.
turnin The Deathstalkers' Report##449 |goto Silverpine Forest 43.43,40.87
accept Speak with Renferrel##3221 |goto Silverpine Forest 43.43,40.87
accept The Dead Fields##437 |goto Silverpine Forest 43.43,40.87
step
talk Apothecary Renferrel##1937
|tip Outside the crypt.
turnin Delivery to Silverpine Forest##445 |goto Silverpine Forest 42.80,40.86
turnin Speak with Renferrel##3221 |goto Silverpine Forest 42.80,40.86
accept Zinge's Delivery##1359 |goto Silverpine Forest 42.80,40.86
turnin Wild Hearts##429 |goto Silverpine Forest 42.80,40.86
accept Return to Quinn##430 |goto Silverpine Forest 42.80,40.86
accept A Recipe For Death##447 |goto Silverpine Forest 42.80,40.86
step
_Destroy These Items:_
|tip Not needed.
trash Discolored Worg Heart##3164
step
talk Karos Razok##2226
turnin Supplying the Sepulcher##6321 |goto Silverpine Forest 45.62,42.60
accept Ride to the Undercity##6323 |goto Silverpine Forest 45.62,42.60
|only if Scourge
stickystart "Collect_Grizzled_Bear_Hearts"
step
kill 5 Moonrage Whitescalp##1769 |q 421/1 |goto Silverpine Forest/0 51.62,39.98
|tip Worgen.
step
talk Dalar Dawnweaver##1938
|tip Walks around.
turnin Prove Your Worth##421 |goto Silverpine Forest 44.20,39.78
accept Arugal's Folly##422 |goto Silverpine Forest 44.20,39.78
step
Cross the bridge |goto Silverpine Forest/0 49.75,30.07 < 20 |only if walking and not subzone("Valgan's Field")
click Dusty Spellbooks
|tip You will be attacked.
|tip Upstairs inside the building.
collect Remedy of Arugal##3155 |q 422/1 |goto Silverpine Forest 52.82,28.58
step
talk Quinn Yorick##1951
|tip Upstairs inside the building.
turnin Return to Quinn##430 |goto Silverpine Forest 53.43,12.59
accept Wild Eyes##91920 |goto Silverpine Forest/0 53.43,12.60
stickystop "Collect_Grizzled_Bear_Hearts"
step
kill Vile Fin Shredder##1767, Vile Fin Tidehunter##1768
|tip Murlocs.
collect 3 Murloc Eye##730 |q 91920/1 |goto Silverpine Forest/0 58.84,17.11
stickystart "Collect_Grizzled_Bear_Hearts"
step
talk Dalar Dawnweaver##1938
|tip Walks around.
turnin Arugal's Folly##422 |goto Silverpine Forest/0 44.20,39.78
accept Arugal's Folly##423 |goto Silverpine Forest/0 44.20,39.78
stickystop "Collect_Grizzled_Bear_Hearts"
step
talk Apothecary Renferrel##1937
|tip Outside the crypt.
turnin Wild Eyes##91920 |goto Silverpine Forest 42.80,40.86
accept Return to Quinn (Again)##91921 |goto Silverpine Forest 42.80,40.86
stickystart "Collect_Grizzled_Bear_Hearts"
step
click Dalaran Crate##1627
turnin Border Crossings##477 |goto Silverpine Forest/0 49.91,60.32
accept Maps and Runes##478 |goto Silverpine Forest/0 49.91,60.32
step
talk Quinn Yorick##1951
|tip Upstairs inside the building.
turnin Return to Quinn (Again)##91921 |goto Silverpine Forest 53.43,12.59
stickystop "Collect_Grizzled_Bear_Hearts"
step
talk Rane Yorick##1950
|tip Outside the building.
accept Ivar the Foul##425 |goto Silverpine Forest 53.46,13.43
step
kill Ivar the Foul##1971
|tip {o}Three ghouls{} with him.
|tip Wait for one to walk outside, then kill it.
|tip Inside the building.
collect Ivar's Head##3621 |q 425/1 |goto Silverpine Forest 51.53,13.91
step
talk Rane Yorick##1950
turnin Ivar the Foul##425 |goto Silverpine Forest 53.46,13.43
step
_NOTE:_
During the Next Steps
|tip Avoid {o}Son of Arugal{}.
|tip Higher level {o}elite black worgen{}.
|tip Walks around a large area.
Click Here to Continue |confirm |q 437
stickystart "Collect_Grizzled_Bear_Hearts"
stickystart "Collect_Darksoul_Shackles"
stickystart "Collect_Glutton_Shackles"
step
Enter the Dead Fields |q 437/2 |goto Silverpine Forest 45.44,21.01
step
label "Collect_Essence_Of_Nightlash"
kill Rot Hide Gladerunner##1772, Rot Hide Mystic##1773
|tip Gnolls.
kill Nightlash##1983
|tip Eventually spawns here.
collect Essence of Nightlash##3622 |q 437/1 |goto Silverpine Forest 45.44,21.01
stickystart "Collect_Skittering_Blood"
step
label "Collect_Grizzled_Bear_Hearts"
kill Ferocious Grizzled Bear##1778, Giant Grizzled Bear##1797
collect 6 Grizzled Bear Heart##3253 |q 447/1 |goto Silverpine Forest/0 40.75,17.83
step
label "Collect_Skittering_Blood"
kill Moss Stalker##1780+
|tip Spiders.
|tip Inside and outside the mine. |notinsticky
collect 6 Skittering Blood##3254 |q 447/2 |goto Silverpine Forest 35.65,13.58
step
label "Collect_Darksoul_Shackles"
Leave the mine |goto Silverpine Forest 35.65,13.58 < 15 |walk |only if subzone("The Skittering Dark") and indoors()
kill Moonrage Darksoul##1782+
|tip Worgen.
|tip Avoid {o}Son of Arugal{}. |notinsticky
|tip Higher level {o}elite black worgen{}. |notinsticky
collect 3 Darksoul Shackle##3157 |q 423/2 |goto Silverpine Forest/0 39.83,24.99
step
label "Collect_Glutton_Shackles"
Leave the mine |goto Silverpine Forest 35.65,13.58 < 15 |walk |only if subzone("The Skittering Dark") and indoors()
kill Moonrage Glutton##1779+
|tip Worgen.
|tip Avoid {o}Son of Arugal{}. |notinsticky
|tip Higher level {o}elite black worgen{}. |notinsticky
collect 6 Glutton Shackle##3156 |q 423/1 |goto Silverpine Forest/0 39.83,24.99
step
Allow Enemies to Kill You
|tip Fast travel.
|tip Don't worry about resurrection sickness.
|tip Traveling around soon.
Die on Purpose |complete isdead |goto Silverpine Forest/0 39.83,24.99 |q 423
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Silverpine Forest/0 44.31,41.51 |q 423 |zombiewalk
|only if not hardcore()
step
talk Shadow Priest Allister##2121
|tip Follow the road.			|only if hardcore()
turnin Maps and Runes##478 |goto Silverpine Forest/0 43.98,40.93
accept Dalar's Analysis##481 |goto Silverpine Forest/0 43.98,40.93
step
talk Dalar Dawnweaver##1938
|tip Walks around.
turnin Arugal's Folly##423 |goto Silverpine Forest/0 44.19,39.78
turnin Dalar's Analysis##481 |goto Silverpine Forest/0 44.19,39.78
accept Dalaran's Intentions##482 |goto Silverpine Forest/0 44.19,39.78
step
talk Shadow Priest Allister##2121
turnin Dalaran's Intentions##482 |goto Silverpine Forest/0 43.98,40.93
step
Enter the crypt |goto Silverpine Forest 43.09,41.39 < 10 |walk |only if not (subzone("The Sepulcher") and indoors())
talk High Executor Hadrec##1952
|tip Downstairs inside the crypt.
turnin The Dead Fields##437 |goto Silverpine Forest/0 43.43,40.87
accept The Decrepit Ferry##438 |goto Silverpine Forest/0 43.43,40.87
step
click Corpse Laden Boat##1593
turnin The Decrepit Ferry##438 |goto Silverpine Forest/0 58.39,34.84
accept Rot Hide Clues##439 |goto Silverpine Forest/0 58.39,34.84
step
Enter the crypt |goto Silverpine Forest 43.09,41.39 < 10 |walk |only if not (subzone("The Sepulcher") and indoors())
talk High Executor Hadrec##1952
|tip Downstairs inside the crypt.
turnin Rot Hide Clues##439 |goto Silverpine Forest/0 43.43,40.87
step
talk Gordon Wendham##4556
|tip Upstairs inside Undercity.
turnin Ride to the Undercity##6323 |goto Undercity 61.49,41.80
accept Michael Garrett##6322 |goto Undercity 61.49,41.80
|only if Scourge
step
talk Michael Garrett##4551
|tip Upstairs inside Undercity.
turnin Michael Garrett##6322 |goto Undercity 63.26,48.56
accept Return to Podrig##6324 |goto Undercity 63.26,48.56
|only if Scourge
step
talk Deathguard Podrig##6389
turnin Return to Podrig##6324 |goto Silverpine Forest 43.43,41.68
|only if Scourge
step
Follow the path down |goto Undercity 52.84,77.62 < 10 |walk
talk Master Apothecary Faranell##2055
turnin A Recipe For Death##447 |goto Undercity 48.82,69.29
step
talk Apothecary Zinge##5204
turnin Zinge's Delivery##1359 |goto Undercity 50.13,67.99
accept Sample for Helbrim##1358 |goto Undercity 50.13,67.99
step
talk Father Lazarus##4608
Train Abilities |trainer Father Lazarus##4608 |goto Undercity/0 47.57,18.90 |q 1358
|only if Priest
step
talk Carolyn Ward##4582
Train Abilities |trainer Carolyn Ward##4582 |goto Undercity/0 83.86,72.07 |q 1358
|only if Rogue
step
talk Anastasia Hartwell##4568
|tip Upstairs inside the building.
Train Abilities |trainer Anastasia Hartwell##4568 |goto Undercity/0 85.14,10.03 |q 1358
|only if Mage
step
talk Kaal Soulreaper##4563
|tip Inside the building.
Train Abilities |trainer Kaal Soulreaper##4563 |goto Undercity/0 86.21,15.93 |q 1358
|only if Warlock
step
talk Martha Strain##5753
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Martha Strain##5753 |goto Undercity/0 85.70,16.08 |q 1358
|only if Warlock
step
talk Baltus Fowler##4595
|tip Inside the building.
Train Abilities |trainer Baltus Fowler##4595 |goto Undercity/0 47.40,17.29 |q 1358
|only if Warrior
step
talk Mennet Carkad##6467
turnin The Deathstalkers##1886 |goto Undercity 83.51,69.11
accept The Deathstalkers##1898 |goto Undercity 83.51,69.11
|only if Scourge Rogue
step
talk Andron Gant##6522
turnin The Deathstalkers##1898 |goto Undercity 54.82,76.30
accept The Deathstalkers##1899 |goto Undercity 54.82,76.30
|only if Scourge Rogue
step
click Andron's Bookshelf##103600
collect Andron's Ledger##7294 |q 1899/1 |goto Undercity 55.42,77.05
|only if Scourge Rogue
step
talk Mennet Carkad##6467
turnin The Deathstalkers##1899 |goto Undercity 83.51,69.11
accept The Deathstalkers##1978 |goto Undercity 65.53,79.73
|only if Scourge Rogue
step
talk Varimathras##2425
turnin The Deathstalkers##1978 |goto Undercity 59.75,84.64
|only if Scourge Rogue
step
talk Garen Largo##260093
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Baltus Fowler##4595 |goto Undercity/0 47.39,14.89 |q 1358
|only if Paladin
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Moonglade##94913 |goto Moonglade 56.21,30.64
|only if Skyborne Druid
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1358
|only if Druid
step
talk Orgnil Soulscar##3142
turnin Threat from Below##99051 |goto Durotar/0 52.24,43.14
|only if Orc or Troll
step
talk Swart##3173
|tip Inside the building.
Train Abilities |trainer Swart##3173 |goto Durotar/0 54.42,42.59 |q 1358
|only if Shaman
step
talk Thotar##3171
|tip Inside the building.
Train Abilities |trainer Thotar##3171 |goto Durotar/0 51.85,43.49 |q 1358
|only if Hunter
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\The Barrens & Stonetalon Mountain (15-21)",{
image=ZGV.IMAGESDIR.."The Barrens",
hardcore = true,
next="Leveling Guides\\Ashenvale (21-22)",
},[[
step
talk Takrin Pathseeker##3336
accept Conscript of the Horde##840 |goto Durotar/0 50.85,43.59
step
talk Kargal Battlescar##3337
turnin Conscript of the Horde##840 |goto The Barrens 62.26,19.38
accept Crossroads Conscription##842 |goto The Barrens 62.26,19.38
step
talk Ak'Zeloth##3521
turnin Ak'Zeloth##809 |goto The Barrens/0 62.34,20.07
|only if Orc or Troll
step
talk Zargh##3489
accept Meats to Orgrimmar##6365 |goto The Barrens 52.62,29.84
|only if Orc or Troll
step
talk Gazrog##3464
accept Raptor Thieves##869 |goto The Barrens 51.93,30.32
step
talk Sergra Darkthorn##3338
turnin Crossroads Conscription##842 |goto The Barrens 52.24,31.01
accept Plainstrider Menace##844 |goto The Barrens 52.24,31.01
step
talk Tonga Runetotem##3448
accept The Forgotten Pools##870 |goto The Barrens 52.26,31.93
step
talk Thork##3429
accept Disrupt the Attacks##871 |goto The Barrens 51.50,30.87
step
talk Devrak##3615
fpath Crossroads |goto The Barrens 51.50,30.34
step
talk Devrak##3615
turnin Meats to Orgrimmar##6365 |goto The Barrens 51.50,30.34
accept Ride to Orgrimmar##6384 |goto The Barrens 51.50,30.34
|only if Orc or Troll
step
talk Innkeeper Gryshka##6929
|tip Inside the building.
turnin Ride to Orgrimmar##6384 |goto Orgrimmar 54.09,68.41
accept Doras the Wind Rider Master##6385 |goto Orgrimmar 54.09,68.41
|only if Orc or Troll
step
talk Doras##3310
|tip Top of the tower.
turnin Doras the Wind Rider Master##6385 |goto Orgrimmar 45.12,63.89
accept Return to the Crossroads##6386 |goto Orgrimmar 45.12,63.89
|only if Orc or Troll
step
talk Therzok##6446
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
accept The Shattered Hand##1963 |goto Orgrimmar/0 42.74,53.54
|only if Rogue
step
talk Apothecary Helbrim##3390
turnin Sample for Helbrim##1358 |goto The Barrens 51.44,30.15
accept Wharfmaster Dizzywig##1492 |goto The Barrens 51.44,30.15
step
talk Zargh##3489
turnin Return to the Crossroads##6386 |goto The Barrens/0 52.62,29.84
|only if Orc or Troll
stickystart "Collect_Raptor_Heads"
stickystart "Kill_Razormane_Enemies"
stickystart "Collect_Plainstrider_Beaks"
step
click Chen's Empty Keg
|tip Skip if not here.
|tip Can try again later.
collect Chen's Empty Keg##4926 |goto The Barrens 55.70,27.29 |q 819 |future
stickystop "Collect_Raptor_Heads"
stickystop "Collect_Plainstrider_Beaks"
step
use Chen's Empty Keg##4926
accept Chen's Empty Keg##819
|only if itemcount(4926) > 0
step
label "Kill_Razormane_Enemies"
kill 3 Razormane Hunter##3265 |q 871/3 |goto The Barrens/0 54.67,25.75
kill 8 Razormane Water Seeker##3267 |q 871/1 |goto The Barrens/0 54.67,25.75
kill 8 Razormane Thornweaver##3268 |q 871/2 |goto The Barrens/0 54.67,25.75
stickystart "Collect_Raptor_Heads"
stickystart "Collect_Plainstrider_Beaks"
step
click Chen's Empty Keg
|tip Wait until it appears, if missing.
collect Chen's Empty Keg##4926 |goto The Barrens 55.78,20.01 |q 819 |future
step
use Chen's Empty Keg##4926
accept Chen's Empty Keg##819
step
label "Collect_Plainstrider_Beaks"
kill Greater Plainstrider##3244, Fleeting Plainstrider##3246
collect 7 Plainstrider Beak##5087 |q 844/1 |goto The Barrens/0 52.94,27.08
step
talk Thork##3429
turnin Disrupt the Attacks##871 |goto The Barrens 51.50,30.87
accept The Disruption Ends##872 |goto The Barrens 51.50,30.87
accept Supplies for the Crossroads##5041 |goto The Barrens 51.50,30.87
stickystop "Collect_Raptor_Heads"
step
talk Darsok Swiftdagger##3449
|tip Top of the tower.
accept Harpy Raiders##867 |goto The Barrens 51.62,30.89
step
talk Sergra Darkthorn##3338
turnin Plainstrider Menace##844 |goto The Barrens 52.24,31.01
accept The Zhevra##845 |goto The Barrens 52.24,31.01
stickystart "Collect_Crossroads_Cupply_Crates"
stickystart "Kill_Razormane_Geomancers_And_Defenders"
stickystart "Collect_Zhevra_Hooves"
stickystart "Collect_Raptor_Heads"
step
kill Kreenig Snarlsnout##3438
|tip Run around the {o}north side{} of the mountain.
|tip Walks around.
collect Kreenig Snarlsnout's Tusk##5063 |q 872/3 |goto The Barrens 58.53,27.04
stickystop "Collect_Zhevra_Hooves"
stickystop "Collect_Raptor_Heads"
step
label "Collect_Crossroads_Cupply_Crates"
click Crossroads' Supply Crates
|tip Piles of brown boxes.
|tip Multiple locations.
collect Crossroads' Supply Crates##12708 |q 5041/1 |goto The Barrens 58.40,27.00
|mapmarker The Barrens/0 58.50,25.80
|mapmarker The Barrens/0 59.10,24.40
step
label "Kill_Razormane_Geomancers_And_Defenders"
kill 8 Razormane Geomancer##3269 |q 872/1 |goto The Barrens/0 58.32,24.45
kill 8 Razormane Defender##3266 |q 872/2 |goto The Barrens/0 58.32,24.45
stickystart "Collect_Zhevra_Hooves"
stickystart "Collect_Raptor_Heads"
step
talk Wrenix the Wretched##7161
accept Parts and Pieces##97253 |goto The Barrens/0 63.07,36.32
step
talk Gazlowe##3391
|tip Upstairs inside the building.
accept Southsea Freebooters##887 |goto The Barrens 62.68,36.23
stickystop "Collect_Zhevra_Hooves"
stickystop "Collect_Raptor_Heads"
step
talk Bragok##16227
fpath Ratchet |goto The Barrens 63.09,37.16
step
talk Sputtervalve##3442
accept Samophlange##894 |goto The Barrens 62.98,37.22
step
_Destroy This Item:_
|tip Not needed.
trash Control Console Operating Manual##5088
step
talk Fuzruckle##3496
|tip Deposit into the bank.
bank Kreenig Snarlsnout's Tusk##5063 |goto The Barrens 62.64,37.42 |q 872
bank Crossroads' Supply Crates##12708 |goto The Barrens 62.64,37.42 |q 5041
step
click WANTED
accept WANTED: Baron Longshore##895 |goto The Barrens 62.59,37.47
step
talk Brewmaster Drohn##3292
turnin Chen's Empty Keg##819 |goto The Barrens 62.26,38.39
accept Chen's Empty Keg##821 |goto The Barrens 62.26,38.39
stickystart "Collect_Tazans_Satchel_Rogue"
stickystart "Kill_Southsea_Cannoneers_And_Brigands"
step
Follow the path up |goto The Barrens/0 63.35,44.22 < 30 |only if walking
click Pile of Complicated Parts+
|tip Small clusters of nuts and bolts.
|tip Usually near tents.
collect 5 Handful of Complicated Parts##277331 |q 97253/1 |goto The Barrens/0 61.77,46.19
step
label "Collect_Tazans_Satchel_Rogue"
kill Tazan##6494
|tip Troll.
|tip Walks around.
collect Tazan's Satchel##7209 |q 1963/1 |goto The Barrens/0 62.92,44.07
|only if Rogue
step
kill Baron Longshore##3467
|tip Human wearing a red trenchcoat.
|tip Walks around.
|tip Multiple locations.
collect Baron Longshore's Head##5084 |q 895/1 |goto The Barrens 64.20,47.20
|mapmarker The Barrens/0 62.40,49.40
|mapmarker The Barrens/0 63.40,49.20
step
label "Kill_Southsea_Cannoneers_And_Brigands"
kill 6 Southsea Cannoneer##3382 |q 887/2 |goto The Barrens/0 63.76,46.71
kill 12 Southsea Brigand##3381 |q 887/1 |goto The Barrens/0 63.76,46.71
step
talk Innkeeper Wiley##6791
|tip Inside the building.
home Ratchet |goto The Barrens/0 62.05,39.41
step
talk Fuzruckle##3496
|tip Collect from the bank.
collect Kreenig Snarlsnout's Tusk##5063 |goto The Barrens 62.64,37.42 |q 872
collect Crossroads' Supply Crates##12708 |goto The Barrens 62.64,37.42 |q 5041
step
talk Wrenix the Wretched##7161
turnin Parts and Pieces##97253 |goto The Barrens/0 63.07,36.32
step
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Southsea Freebooters##887 |goto The Barrens 62.68,36.23
accept The Missing Shipment##890 |goto The Barrens 62.68,36.23
turnin WANTED: Baron Longshore##895 |goto The Barrens 62.68,36.23
step
talk Wharfmaster Dizzywig##3453
turnin Wharfmaster Dizzywig##1492 |goto The Barrens 63.35,38.45
turnin The Missing Shipment##890 |goto The Barrens 63.35,38.45
accept The Missing Shipment##892 |goto The Barrens 63.35,38.45
accept Miner's Fortune##896 |goto The Barrens 63.35,38.45
step
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin The Missing Shipment##892 |goto The Barrens 62.68,36.23
accept Stolen Booty##888 |goto The Barrens 62.68,36.23
step
talk Thork##3429
turnin The Disruption Ends##872 |goto The Barrens 51.50,30.87
turnin Supplies for the Crossroads##5041 |goto The Barrens 51.50,30.87
stickystart "Collect_Plainstrider_Kidneys"
stickystart "Collect_Raptor_Heads"
step
label "Collect_Zhevra_Hooves"
kill Zhevra Runner##3242+
|tip Zebras.
collect 4 Zhevra Hooves##5086 |q 845/1 |goto The Barrens/0 53.46,36.19
|only if not subzone("Thorn Hill")
step
talk Sergra Darkthorn##3338
turnin The Zhevra##845 |goto The Barrens 52.23,31.01
accept Prowlers of the Barrens##903 |goto The Barrens 52.23,31.01
step
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
accept Centaur Bracers##855 |goto The Barrens 45.34,28.41
accept Kolkar Leaders##850 |goto The Barrens 45.34,28.41
stickystart "Collect_Centaur_Bracers"
step
Explore the Waters of the Forgotten Pools |q 870/1 |goto The Barrens 45.07,22.53
|tip Swim next to the bubbling rock.
|tip Underwater.
step
kill Barak Kodobane##3394
|tip Walks around.
collect Barak's Head##5022 |q 850/1 |goto The Barrens 42.72,23.61
step
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
turnin Centaur Bracers##855 |goto The Barrens 45.34,28.41			|only if readyq(855)
turnin Kolkar Leaders##850 |goto The Barrens 45.34,28.41
accept Verog the Dervish##851 |goto The Barrens 45.34,28.41
stickystop "Collect_Centaur_Bracers"
step
kill Savannah Prowler##3425+
|tip Lions.
collect 7 Prowler Claws##5096 |q 903/1 |goto The Barrens 41.20,28.40
collect 5 Savannah Lion Tusk##4893 |q 821/1 |goto The Barrens/0 45.50,15.08 |usebank |only if not (readyq(903) or completedq(903))
|mapmarker The Barrens/0 40.40,20.60
|mapmarker The Barrens/0 40.80,26.20
|mapmarker The Barrens/0 42.00,23.40
|mapmarker The Barrens/0 43.20,33.20
|mapmarker The Barrens/0 43.40,39.40
|mapmarker The Barrens/0 44.60,31.40
stickystop "Collect_Raptor_Heads"
stickystop "Collect_Plainstrider_Kidneys"
step
kill Witchwing Harpy##3276, Witchwing Roguefeather##3277
|tip Harpies.
collect 8 Witchwing Talon##5064 |q 867/1 |goto The Barrens/0 40.48,17.77
step
talk Vrang Wildgore##3682
accept Bruised Pride and Lion Hides##95494 |goto The Barrens/0 43.77,12.17
accept Vrang's Game##95507 |goto The Barrens/0 43.77,12.17
stickystart "Collect_Trapped_Game"
stickystart "Collect_Raptor_Heads"
stickystart "Collect_Plainstrider_Kidneys"
step
kill Savannah Patriarch##3241+
|tip Lions.
collect 5 Savannah Lion Tusk##4893 |q 821/1 |goto The Barrens/0 45.50,15.08 |usebank
collect 6 Savannah Lion Hide |q 95494/1 |goto The Barrens/0 45.50,15.08
step
label "Collect_Trapped_Game"
click Sprung Trap+
|tip Silver metal traps.
collect 8 Trapped Game##269719 |q 95507/1 |goto The Barrens/0 45.34,14.61
step
talk Vrang Wildgore##3682
turnin Bruised Pride and Lion Hides##95494 |goto The Barrens/0 43.77,12.17
turnin Vrang's Game##95507 |goto The Barrens/0 43.77,12.17
step
click Control Console
turnin Samophlange##894 |goto The Barrens 52.41,11.64
accept Samophlange##900 |goto The Barrens 52.41,11.64
step
click the Fuel Control Valve
|tip Two enemies may attack.
Shut Off the Fuel Control Valve |q 900/2 |goto The Barrens 52.40,11.41
step
click the Regulator Valve
|tip Two enemies may attack.
Shut Off the Regulator Valve |q 900/3 |goto The Barrens 52.29,11.40
step
click Main Control Valve
|tip Two enemies may attack.
Shut Off the Main Control Valve |q 900/1 |goto The Barrens 52.33,11.57
step
click Control Console
turnin Samophlange##900 |goto The Barrens 52.41,11.64
accept Samophlange##901 |goto The Barrens 52.41,11.64
step
kill Tinkerer Sniggles##3471
|tip Inside the building.
collect Console Key##5089 |q 901/1 |goto The Barrens 52.84,10.39
step
click Control Console
turnin Samophlange##901 |goto The Barrens 52.41,11.64
accept Samophlange##902 |goto The Barrens 52.41,11.64
step
label "Collect_Raptor_Heads"
kill Sunscale Lashtail##3254, Sunscale Screecher##3255
|tip Purple raptors.
|tip All around the Barrens.
|tip Kill them as you see them.
collect 12 Raptor Head##5062 |q 869/1 |goto The Barrens 53.00,12.60
|mapmarker The Barrens/0 50.40,13.00
|mapmarker The Barrens/0 52.00,14.60
|mapmarker The Barrens/0 52.40,16.60
|mapmarker The Barrens/0 52.80,19.40
|mapmarker The Barrens/0 54.00,10.40
|mapmarker The Barrens/0 54.80,15.40
|mapmarker The Barrens/0 55.40,21.00
|mapmarker The Barrens/0 56.20,11.20
|mapmarker The Barrens/0 56.40,17.40
|mapmarker The Barrens/0 58.00,20.40
|mapmarker The Barrens/0 58.40,15.20
|mapmarker The Barrens/0 59.40,17.40
stickystop "Collect_Plainstrider_Kidneys"
step
Follow the path up |goto The Barrens 61.54,6.68 < 40 |only if walking and not subzone("Boulder Lode Mine")
kill Venture Co. Enforcer##3283, Venture Co. Overseer##3286
collect Cats Eye Emerald##5097 |q 896/1 |goto The Barrens/0 61.33,4.21
step
Kill enemies
|tip Helps reach level 18 after quest turnins.
ding 17,11175 |goto The Barrens/0 61.33,4.21
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 896
|only if Druid
step
talk Wharfmaster Dizzywig##3453
turnin Miner's Fortune##896 |goto The Barrens 63.35,38.45
step
talk Fuzruckle##3496
|tip Deposit into the bank.
bank Savannah Lion Tusk##4893 |goto The Barrens 62.64,37.42 |q 821
step
talk Sputtervalve##3442
turnin Samophlange##902 |goto The Barrens 62.98,37.22
accept Wenikee Boltbucket##3921 |goto The Barrens 62.98,37.22
step
talk Darsok Swiftdagger##3449
|tip Top of the tower.
turnin Harpy Raiders##867 |goto The Barrens 51.62,30.90
accept Harpy Lieutenants##875 |goto The Barrens 51.62,30.90
step
talk Tonga Runetotem##3448
turnin The Forgotten Pools##870 |goto The Barrens 52.26,31.93
accept The Stagnant Oasis##877 |goto The Barrens 52.26,31.93
step
talk Sergra Darkthorn##3338
turnin Prowlers of the Barrens##903 |goto The Barrens 52.24,31.01
accept Echeyakee##881 |goto The Barrens 52.24,31.01
step
talk Gazrog##3464
turnin Raptor Thieves##869 |goto The Barrens 51.93,30.32
accept Stolen Silver##3281 |goto The Barrens 51.93,30.32
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 3921
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 3921
|only if Priest
step
talk Zor Lonetree##4047
|tip Inside the building.
accept The Spirits of Stonetalon##1061 |goto Orgrimmar/0 38.93,38.38
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 3921
|only if Shaman
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3921
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3921
|only if Warlock
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 3921
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 3921
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 3921
|only if Hunter
step
talk Hanashi##2704
|tip Inside the building.
Train Staves |complete weaponskill("TH_STAFF") > 0 |goto Orgrimmar/0 81.53,19.63
|only if Hunter
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3921
|only if Rogue
step
talk Shenthul##3401
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
accept Zando'zan##2379 |goto Orgrimmar/0 43.05,53.72
|only if Rogue
step
talk Therzok##6446
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin The Shattered Hand##1963 |goto Orgrimmar/0 42.74,53.54
accept The Shattered Hand##1858 |goto Orgrimmar/0 42.74,53.54
|only if Rogue
step
talk Zando'zan##3402
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin Zando'zan##2379 |goto 42.73,52.95
accept Wrenix of Ratchet##2382 |goto 42.73,52.95
|only if Rogue
step
collect Tazan's Key##7208 |goto Orgrimmar 54.00,68.03 |q 1858
|tip Cast {o}Pick Pocket{} on Gamon.
|tip Inside the building.
|only if Rogue
step
use Tazan's Key##7208
|tip On {o}Tazan's Satchel{}.
|tip In your bags.
collect Tazan's Logbook##7295 |q 1858/1
|only if Rogue
step
talk Therzok##6446
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin The Shattered Hand##1858 |goto Orgrimmar/0 42.74,53.54
|only if Rogue
step
talk Innkeeper Boorand Plainswind##3934
|tip Inside the building.
home The Crossroads |goto The Barrens 51.99,29.89
stickystart "Collect_Plainstrider_Kidneys"
step
talk Wenikee Boltbucket##9316
turnin Wenikee Boltbucket##3921 |goto The Barrens 49.05,11.16
accept Nugget Slugs##3922 |goto The Barrens 49.05,11.16
stickystart "Collect_Nugget_Slugs"
step
talk Wizzlecrank's Shredder##3439
|tip Escort quest.
|tip Wait until it respawns, if missing.
accept Ignition##858 |goto The Barrens 56.51,7.45
stickystop "Collect_Plainstrider_Kidneys"
step
kill Supervisor Lugwizzle##3445
|tip Walks around.
|tip Both levels of the platform.
collect Ignition Key##5050 |q 858/1 |goto The Barrens 56.20,8.25
step
talk Wizzlecrank's Shredder##3439
|tip Escort quest.
|tip Wait until it respawns, if missing.
turnin Ignition##858 |goto The Barrens 56.51,7.45
accept The Escape##863 |goto The Barrens 56.51,7.45 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Wizzlecrank's Shredder.
Escort Wizzlecrank Out of the Venture Co. Drill Site |q 863/1 |goto The Barrens 55.35,7.70
step
label "Collect_Nugget_Slugs"
click Tool Bucket##161752+
|tip Grey metal buckets.
collect 15 Nugget Slug##11143 |q 3922/1 |goto The Barrens/0 56.44,8.19
stickystart "Collect_Plainstrider_Kidneys"
step
use Horn of Echeyakee##10327
|tip Run around the mountain.
kill Echeyakee##3475
|tip White lion.
|tip Spawns nearby.
collect Echeyakee's Hide##5100 |q 881/1 |goto The Barrens 55.85,17.08
step
talk Wenikee Boltbucket##9316
turnin Nugget Slugs##3922 |goto The Barrens 49.05,11.16
step
_Destroy These Items:_
|tip Not needed.
trash Nugget Slug##11143
step
label "Collect_Plainstrider_Kidneys"
kill Fleeting Plainstrider##3246, Greater Plainstrider##3244, Ornery Plainstrider##3245
|tip Large walking birds.
collect 5 Plainstrider Kidney##4894 |q 821/2 |goto The Barrens/0 44.95,14.61
step
talk Vrang Wildgore##3682
accept The Hermit Tanner##95495 |goto The Barrens/0 43.77,12.17
step
Run up the mountain |goto The Barrens/0 43.39,13.66 < 20 |only if walking
talk Walton##261366
|tip Top of the mountain.
turnin The Hermit Tanner##95495 |goto The Barrens/0 42.02,11.45
step
kill Witchwing Slayer##3278+
|tip Avoid Sister Rathtalon.
|tip {o}Elite{} green harpy.
|tip Flies around.
|tip Careful, stealthed enemies.
collect 6 Harpy Lieutenant Ring##5065 |q 875/1 |goto The Barrens/0 38.91,14.44
step
talk Sergra Darkthorn##3338
turnin Echeyakee##881 |goto The Barrens 52.23,31.00
accept The Angry Scytheclaws##905 |goto The Barrens 52.23,31.00
step
_Destroy This Item:_
|tip Not needed.
trash Horn of Echeyakee##10327
step
talk Mankrik##3432
accept Lost in Battle##4921 |goto The Barrens 51.95,31.58
step
talk Darsok Swiftdagger##3449
|tip Top of the tower.
turnin Harpy Lieutenants##875 |goto The Barrens 51.62,30.90
accept Serena Bloodfeather##876 |goto The Barrens 51.62,30.90
step
talk Wrenix the Wretched##7161
turnin Wrenix of Ratchet##2382 |goto The Barrens/0 63.07,36.32
accept Plundering the Plunderers##2381 |goto The Barrens/0 63.07,36.32
|only if Rogue
step
talk Wrenix's Gizmotronic Apparatus##7166
Select _"Press the yellow button labeled 'Thieves' Tools.'"_
collect Thieves' Tools##5060 |goto The Barrens 63.12,36.32 |q 2381
|only if Rogue
step
talk Wrenix's Gizmotronic Apparatus##7166
Select _"Press the red button labeled 'E.C.A.C.'"_
collect E.C.A.C.##7970 |goto The Barrens 63.12,36.32 |q 2381
|only if Rogue
step
talk Sputtervalve##3442
turnin The Escape##863 |goto The Barrens 62.98,37.22
accept Ziz Fizziks##1483 |goto The Barrens 62.98,37.22
step
talk Fuzruckle##3496
|tip Deposit into the bank.
bank Plainstrider Kidney##4894 |goto The Barrens 62.64,37.42 |q 821
step
talk Mebok Mizzyrix##3446
accept Raptor Horns##865 |goto The Barrens 62.37,37.62
step
click Buccaneer's Strongbox+
|tip Grey metal chests.
|tip {o}Middle floor{} inside the ship.
skill Lockpicking,85 |goto The Barrens 65.07,45.44
|tip Needed for quest soon.
|only if Rogue
step
_NOTE:_
During the Next Step
|tip A {o}level 50{} bird appears after looting a chest.
|tip Use the {o}E.C.A.C.{} on it.
|tip Weakens it to {o}level 18{}.
Click Here to Continue |confirm |q 2381
|only if Rogue
step
click The Jewel of the Southsea##123462
|tip Small wooden chest.
|tip {o}Middle floor{} inside the ship.
use E.C.A.C.##7970
|tip On Polly.
|tip {o}Level 50{} bird that appears.
|tip Weakens it to {o}level 18{}.
collect Southsea Treasure##7968 |q 2381/1 |goto The Barrens 64.95,45.44
|only if Rogue
step
click Fragile - Do NOT Drop
collect Telescopic Lens##5077 |q 888/2 |goto The Barrens 63.58,49.24
step
click Drizzlik's Emporium
collect Shipment of Boots##5076 |q 888/1 |goto The Barrens 62.63,49.64
stickystart "Collect_Sunscale_Feathers_And_Intact_Raptor_Horns"
step
Run around the mountain and follow the path |goto The Barrens 57.35,52.24 < 30 |only if walking and not subzone("Raptor Grounds")
click Stolen Silver
collect Stolen Silver##5061 |q 3281/1 |goto The Barrens 58.03,53.87
step
label "Collect_Sunscale_Feathers_And_Intact_Raptor_Horns"
kill Sunscale Scytheclaw##3256+
|tip Purple raptors.
collect 3 Sunscale Feather##5165 |goto The Barrens/0 57.47,53.71 |q 905
collect 5 Intact Raptor Horn##5055 |q 865/1 |goto The Barrens/0 57.47,53.71
stickystart "Collect_Centaur_Bracers"
step
click Bubbling Fissure
|tip Underwater.
Test the Dried Seeds |q 877/1 |goto The Barrens 55.61,42.74
step
kill Verog the Dervish##3395
|tip Kill {o}Kolkar enemies{} in {o}Stagnant Oasis{}.
|tip You'll eventually see a message yelled in chat.
|tip Says {o}I am summoned! Intruders, come to my tent and face your death!{}
|tip Means he spawned at this location.
collect Verog's Head##5023 |q 851/1 |goto The Barrens 52.91,41.77
step
label "Collect_Centaur_Bracers"
kill Kolkar Bloodcharger##3397, Kolkar Pack Runner##3274, Kolkar Stormer##3273, Kolkar Wrangler##3272, Kolkar Marauder##3275
collect 15 Centaur Bracers##5030 |q 855/1 |goto The Barrens/0 55.17,41.98
step
click Blue Raptor Nest
Visit the Blue Raptor Nest |q 905/1 |goto The Barrens 52.60,46.11
step
click Red Raptor Nest
Visit the Red Raptor Nest |q 905/3 |goto The Barrens 52.46,46.57
step
click Yellow Raptor Nest
Visit the Yellow Raptor Nest |q 905/2 |goto The Barrens 52.02,46.47
step
_Destroy These Items:_
|tip Not needed.
trash Sunscale Feather##5165
step
clicknpc Beaten Corpse##10668
Select _"I inspect the body further."_ |gossip 96232
Find Mankrik's Wife |q 4921/1 |goto The Barrens/0 49.33,50.32
step
talk Innkeeper Byula##7714
|tip Inside the building.
home Camp Taurajo |goto The Barrens 45.58,59.04
step
talk Omusa Thunderhorn##10378
fpath Camp Taurajo |goto The Barrens 44.45,59.15
step
talk Mankrik##3432
turnin Lost in Battle##4921 |goto The Barrens/0 51.95,31.58
accept Her Name Is Olgra##95774 |goto The Barrens/0 51.95,31.58
accept Consumed by Hatred##899 |goto The Barrens 51.95,31.58
step
talk Tonga Runetotem##3448
turnin The Stagnant Oasis##877 |goto The Barrens/0 52.26,31.93
accept Altered Beings##880 |goto The Barrens/0 52.26,31.93
step
_Destroy This Item:_
|tip Not needed.
trash Dried Seeds##5068
step
talk Sergra Darkthorn##3338
turnin The Angry Scytheclaws##905 |goto The Barrens/0 52.23,31.01
accept Jorn Skyseer##3261 |goto The Barrens/0 52.23,31.01
step
talk Gazrog##3464
turnin Stolen Silver##3281 |goto The Barrens/0 51.93,30.32
step
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
turnin Centaur Bracers##855 |goto The Barrens/0 45.34,28.41
turnin Verog the Dervish##851 |goto The Barrens/0 45.34,28.41
accept Hezrul Bloodmark##852 |goto The Barrens/0 45.34,28.41
step
kill Serena Bloodfeather##3452
|tip Careful, stealthed enemies.
collect Serena's Head##5067 |q 876/1 |goto The Barrens 39.16,12.17
step
talk Seereth Stonebreak##4049
|tip Run around the mountain.
turnin The Spirits of Stonetalon##1061 |goto The Barrens 35.26,27.88
accept Goblin Invaders##1062 |goto The Barrens 35.26,27.88
step
talk Makaba Flathoof##11857
accept Avenge My Village##6548 |goto The Barrens 35.19,27.79
step
kill 6 Grimtotem Mercenary##11911 |q 6548/2 |goto Stonetalon Mountains/0 81.47,88.36
kill 8 Grimtotem Ruffian##11910 |q 6548/1 |goto Stonetalon Mountains/0 81.47,88.36
step
talk Makaba Flathoof##11857
|tip Follow the road.
turnin Avenge My Village##6548 |goto The Barrens 35.19,27.79
accept Kill Grundig Darkcloud##6629 |goto The Barrens 35.19,27.79
stickystart "Kill_Grimtotem_Brutes"
step
Follow the path |goto Stonetalon Mountains 71.50,88.59 < 30 |only if walking and not subzone("Grimtotem Post")
kill Grundig Darkcloud##11858 |q 6629/1 |goto Stonetalon Mountains 73.65,86.13
step
label "Kill_Grimtotem_Brutes"
kill 6 Grimtotem Brute##11912 |q 6629/2 |goto Stonetalon Mountains/0 75.68,86.41
step
talk Kaya Flathoof##11856
|tip Escort quest.
|tip Wait until she respawns, if missing.
|tip Inside the building.
accept Protect Kaya##6523 |goto Stonetalon Mountains 73.48,85.59 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect {o}Kaya Flathoof{}.
|tip Group of {o}3 enemies attack{} near end of escort.
|tip Kill the {o}Grimtotem Sorcerer{} first.
Escort Kaya to Camp Aparaje |q 6523/1 |goto Stonetalon Mountains 77.10,90.84
step
talk Xen'Zilla##12816
|tip Inside the building.
accept Blood Feeders##6461 |goto Stonetalon Mountains 71.24,95.02
step
kill 10 Deepmoss Creeper##4005 |q 6461/1 |goto Stonetalon Mountains/0 59.40,74.95
|tip Green spiders.
stickystart "Kill_Deepmoss_Venomspitters"
step
talk Tharm##4312
fpath Sun Rock Retreat |goto Stonetalon Mountains/0 45.13,59.84
step
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Ziz Fizziks##1483 |goto Stonetalon Mountains 58.99,62.60
accept Super Reaper 6000##1093 |goto Stonetalon Mountains 58.99,62.60
step
label "Kill_Deepmoss_Venomspitters"
kill 7 Deepmoss Venomspitter##4007 |q 6461/2 |goto Stonetalon Mountains/0 62.02,61.22
|tip Green spiders.
stickystart "Kill_Venture_Co_Loggers"
step
kill Venture Co. Operator##3988+
collect Super Reaper 6000 Blueprints##5734 |q 1093/1 |goto Stonetalon Mountains 62.20,52.00
|mapmarker Stonetalon Mountains/0 66.20,45.60
|mapmarker Stonetalon Mountains/0 66.20,51.80
|mapmarker Stonetalon Mountains/0 70.00,55.60
|mapmarker Stonetalon Mountains/0 71.40,49.80
|mapmarker Stonetalon Mountains/0 73.00,56.60
|mapmarker Stonetalon Mountains/0 74.00,54.00
step
label "Kill_Venture_Co_Loggers"
kill 15 Venture Co. Logger##3989 |q 1062/1 |goto Stonetalon Mountains/0 66.43,55.88
step
Kill enemies
|tip Helps reach level 20 after quest turnins.
ding 19,19650 |goto Stonetalon Mountains/0 66.43,55.88
step
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Super Reaper 6000##1093 |goto Stonetalon Mountains 58.99,62.60
accept Further Instructions##1094 |goto Stonetalon Mountains 58.99,62.60
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 3261
|only if Druid
step
talk Jorn Skyseer##3387
turnin Jorn Skyseer##3261 |goto The Barrens 44.86,59.14
accept Ishamuhale##882 |goto The Barrens 44.86,59.14
step
talk Mangletooth##3430
accept Tribes at War##878 |goto The Barrens/0 44.55,59.24
stickystart "Collect_Olgras_Adornments"
stickystart "Collect_Thunder_Lizard_Horn"
stickystart "Collect_Blood_Shard_And_Bristleback_Quilboar_Tusks"
step
kill Lakota'mani##3474
|tip Grey kodo.
|tip Walks around.
|tip Multiple locations.
collect Hoof of Lakota'mani##5099 |n
use Hoof of Lakota'mani##5099
accept Lakota'mani##883 |goto The Barrens 49.40,53.00
|mapmarker The Barrens/0 45.20,52.40
|mapmarker The Barrens/0 46.00,49.40
|mapmarker The Barrens/0 47.20,51.60
step
label "Collect_Olgras_Adornments"
kill Razormane Raider##268624+
|tip Quilboars.
collect 4 Olgra's Adornments##277277 |q 95774/1 |goto The Barrens/0 49.66,50.66
step
label "Collect_Thunder_Lizard_Horn"
kill Stormsnout##3240+
|tip Pink dinosaurs.
collect Thunder Lizard Horn##4895 |q 821/3 |goto The Barrens 48.40,57.20
stickystart "Kill_Bristleback_Enemies"
step
label "Collect_Blood_Shard_And_Bristleback_Quilboar_Tusks"
kill Bristleback Water Seeker##3260, Bristleback Hunter##3258, Bristleback Thornweaver##3261, Bristleback Geomancer##3263
collect Blood Shard##5075 |goto The Barrens/0 52.11,54.81 |q 5052 |future
|tip Don't vendor them.
collect 60 Bristleback Quilboar Tusk##5085 |q 899/1 |goto The Barrens/0 52.11,54.81
step
label "Kill_Bristleback_Enemies"
kill 6 Bristleback Water Seeker##3260 |q 878/1 |goto The Barrens/0 52.11,54.81
kill 12 Bristleback Thornweaver##3261 |q 878/2 |goto The Barrens/0 52.11,54.81
kill 12 Bristleback Geomancer##3263 |q 878/3 |goto The Barrens/0 52.11,54.81
step
kill Oasis Snapjaw##3461+
|tip Turtles.
|tip Underwater and around the water edge.
collect 8 Altered Snapjaw Shell##5098 |q 880/1 |goto The Barrens 55.53,42.70
step
kill Zhevra Charger##3426+
collect Fresh Zhevra Carcass##10338 |goto The Barrens 60.60,35.60 |q 882
|mapmarker The Barrens/0 61.00,31.80
|mapmarker The Barrens/0 62.60,33.40
step
use Fresh Zhevra Carcass##10338
kill Ishamuhale##3257
|tip Raptor.
|tip Appears nearby.
collect Ishamuhale's Fang##5101 |q 882/1 |goto The Barrens 59.89,30.29
step
talk Wrenix the Wretched##7161
turnin Plundering the Plunderers##2381 |goto The Barrens 63.07,36.32
|only if Rogue
step
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Stolen Booty##888 |goto The Barrens 62.68,36.23
step
talk Sputtervalve##3442
turnin Further Instructions##1094 |goto The Barrens 62.98,37.22
accept Further Instructions##1095 |goto The Barrens 62.98,37.22
step
talk Fuzruckle##3496
|tip Collect from the bank.
collect 5 Plainstrider Kidney##4894 |goto The Barrens 62.64,37.42 |q 821
collect 5 Savannah Lion Tusk##4893 |goto The Barrens 62.64,37.42 |q 821
step
talk Mebok Mizzyrix##3446
turnin Raptor Horns##865 |goto The Barrens 62.37,37.62
step
talk Brewmaster Drohn##3292
turnin Chen's Empty Keg##821 |goto The Barrens 62.26,38.39
step
talk Darsok Swiftdagger##3449
|tip Top of the tower.
turnin Serena Bloodfeather##876 |goto The Barrens 51.62,30.90
accept Letter to Jin'Zil##1060 |goto The Barrens 51.62,30.90
step
talk Mankrik##3432
turnin Consumed by Hatred##899 |goto The Barrens 51.95,31.58
turnin Her Name Is Olgra##95774 |goto The Barrens/0 51.95,31.58
step
_Destroy These Items:_
|tip Not needed.
trash Bristleback Quilboar Tusk##5085
step
talk Tonga Runetotem##3448
turnin Altered Beings##880 |goto The Barrens 52.26,31.93
accept Hamuul Runetotem##1489 |goto The Barrens 52.26,31.93
accept Mura Runetotem##3301 |goto The Barrens 52.26,31.93
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 878
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 878
|only if Priest
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 878
|only if Rogue
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 878
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 878
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 878
|only if Hunter
step
talk Searn Firewarder##5892
|tip Inside the building.
accept Call of Water##1528 |goto Orgrimmar 37.96,37.73
|only if Shaman
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 878
|only if Shaman
step
talk Islen Waterseer##5901
turnin Call of Water##1528 |goto The Barrens 65.83,43.78
accept Call of Water##1530 |goto The Barrens 65.83,43.78
|only if Shaman
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 878
|only if Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
accept Devourer of Souls##1507 |goto Orgrimmar 48.25,45.29
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 878
|only if Warlock
step
talk Cazul##5909
|tip Inside the Cleft of Shadow.
turnin Devourer of Souls##1507 |goto Orgrimmar 47.06,46.48
accept Blind Cazul##1508 |goto Orgrimmar 47.06,46.48
|only if Warlock
step
talk Zankaja##5910
|tip Inside the building.
turnin Blind Cazul##1508 |goto Orgrimmar 37.03,59.45
accept News of Dogran##1509 |goto Orgrimmar 37.03,59.45
|only if Warlock
step
talk Gazrog##3464
turnin News of Dogran##1509 |goto The Barrens 51.93,30.32
accept News of Dogran##1510 |goto The Barrens 51.93,30.32
|only if Warlock
step
talk Mangletooth##3430
turnin Tribes at War##878 |goto The Barrens 44.55,59.24
accept Blood Shards of Agamaggan##5052 |goto The Barrens 44.55,59.24
step
talk Mangletooth##3430
turnin Blood Shards of Agamaggan##5052 |goto The Barrens 44.55,59.24
step
_NOTE:_
talk Mangletooth##3430
|tip Exchange Blood Shards for buffs.
|tip When questing in the Barrens, spend extra Blood Shards here.
|tip
|tip {o}SPIRIT OF THE WIND{}
|tip +30% Movement Speed (5 Minutes)
|tip Note: Does {o}NOT{} stack with other run speed abilities.
|tip
|tip {o}AGAMAGGAN'S STRENGTH{}
|tip +10 Strength (30 Minutes)
|tip
|tip {o}AGAMAGGAN'S AGILITY{}
|tip +10 Agility (30 Minutes)
|tip
|tip {o}WISDOM OF AGAMAGGAN{}
|tip +10 Intellect (30 Minutes)
|tip
|tip {o}RISING SPIRIT{}
|tip +25 Spirit (30 Minutes)
|tip
|tip {o}RAZORHIDE{}
|tip +95 Armor and Returns Damage to Enemies (10 Minutes)
|tip
Click Here to Continue |confirm |goto The Barrens 44.55,59.24 |q 882
step
talk Jorn Skyseer##3387
turnin Ishamuhale##882 |goto The Barrens 44.86,59.14
accept Enraged Thunder Lizards##907 |goto The Barrens 44.86,59.14
turnin Lakota'mani##883 |goto The Barrens 44.86,59.14
step
kill Stormsnout##3240, Thunderhead##3239
|tip Pink dinosaurs.
collect 3 Thunder Lizard Blood##5143 |q 907/1 |goto The Barrens/0 44.73,62.09
step
talk Jorn Skyseer##3387
turnin Enraged Thunder Lizards##907 |goto The Barrens 44.86,59.14
accept Cry of the Thunderhawk##913 |goto The Barrens 44.86,59.14
stickystart "Collect_Thunderhawk_Wings"
step
talk Brine##5899
|tip Top of the hill.
turnin Call of Water##1530 |goto The Barrens 43.42,77.41
accept Call of Water##1535 |goto The Barrens 43.42,77.41
|only if Shaman
step
use Empty Brown Waterskin##7766
collect Filled Brown Waterskin##7769 |q 1535/1 |goto The Barrens 44.35,76.97
|only if Shaman
step
talk Brine##5899
|tip Top of the hill.
turnin Call of Water##1535 |goto The Barrens 43.42,77.41
accept Call of Water##1536 |goto The Barrens 43.42,77.41
|only if Shaman
step
label "Collect_Thunderhawk_Wings"
kill Thunderhawk Hatchling##3247, Thunderhawk Cloudscraper##3424
|tip Flying snakes.
collect Thunderhawk Wings##5164 |q 913/1 |goto The Barrens 45.60,56.20
step
talk Jorn Skyseer##3387
turnin Cry of the Thunderhawk##913 |goto The Barrens 44.86,59.14
accept Mahren Skyseer##874 |goto The Barrens 44.86,59.14
step
talk Mangletooth##3430
|tip Complete the {o}Spirit of the Wind{} quest.
Get the {y}Spirit of the Wind{} Buff |havebuff Spirit of the Wind##16618 |goto The Barrens 44.55,59.24 |q 853
|tip Long run to Thunder Bluff now.
|tip Increases run speed.
|only if itemcount(5075) >= 10 and not Tauren
step
Ride an elevator up to enter Thunder Bluff |goto Thunder Bluff 31.78,66.01 < 30 |only if walking and not Tauren
talk Ansekhwa##11869
Train Two-Handed Maces	|complete weaponskill("TH_MACE") > 0		|goto Thunder Bluff 40.93,62.73		|only if Warrior
Train One-Handed Maces	|complete weaponskill("MACE") > 0		|goto Thunder Bluff 40.93,62.73		|only if Rogue
Train Staves		|complete weaponskill("TH_STAFF") > 0		|goto Thunder Bluff 40.93,62.73		|only if Warlock or Priest or Warrior
Train Guns		|complete weaponskill("GUN") > 0		|goto Thunder Bluff 40.93,62.73		|only if Hunter
step
talk Innkeeper Pala##6746
|tip Inside the building.
home Thunder Bluff |goto Thunder Bluff 45.81,64.71
step
Enter the cave |goto Thunder Bluff 29.84,29.88 < 15 |walk |only if not subzone("The Pools of Vision")
talk Clarice Foster##5543
|tip Walks around.
|tip Inside the cave.
accept Until Death Do Us Part##264 |goto Thunder Bluff 24.72,22.30
step
talk Miles Welsh##3044
|tip Inside the cave.
accept Shadowguard##5642	|goto Thunder Bluff/0 25.32,15.29 |only if Troll
accept Devouring Plague##5644	|goto Thunder Bluff/0 25.32,15.29 |only if Scourge
|only if Priest
step
talk Alodan the Hopeful##246344
|tip Inside the cave.
Train Abilities |trainer Alodan the Hopeful##246344 |goto Thunder Bluff/0 25.20,14.41 |q 1489
|only if Paladin
step
Leave the cave |goto Thunder Bluff 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
turnin Hamuul Runetotem##1489 |goto Thunder Bluff 78.62,28.56
accept Nara Wildmane##1490 |goto Thunder Bluff 78.62,28.56
step
talk Nara Wildmane##5770
|tip Inside the building.
turnin Nara Wildmane##1490 |goto Thunder Bluff 75.65,31.61
step
talk Turak Runetotem##3033
|tip Inside the building.
accept A Lesson to Learn##27 |goto Thunder Bluff 76.48,27.22
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin A Lesson to Learn##27 |goto Moonglade 56.21,30.64
accept Trial of the Lake##28 |goto Moonglade 56.21,30.64
|only if Druid
step
click Bauble Container
|tip Wicker vase.
|tip Underwater.
|tip Random locoations.
collect Shrine Bauble##15877 |q 28/1 |goto Moonglade 54.33,55.65
|only if Druid
step
use Shrine Bauble##15877
Complete the Trial of the Lake |q 28/2 |goto Moonglade 35.92,41.38
|only if Druid
step
talk Tajarri##11799
turnin Trial of the Lake##28 |goto Moonglade 36.52,40.10
accept Trial of the Sea Lion##30 |goto Moonglade 36.52,40.10
|only if Druid
step
talk Tal##2995
|tip Top of the tower.
fpath Thunder Bluff |goto Thunder Bluff 46.98,49.84
step
talk Korran##3428
accept Egg Hunt##868 |goto The Barrens 51.07,29.63
step
kill Hezrul Bloodmark##3396
|tip Centaur with {o}two guards{}.
|tip Walks around.
collect Hezrul's Head##5025 |q 852/1 |goto The Barrens/0 48.80,39.80
|mapmarker The Barrens/0 45.00,39.40
|mapmarker The Barrens/0 46.00,36.40
|mapmarker The Barrens/0 46.20,41.40
|mapmarker The Barrens/0 46.40,38.00
|mapmarker The Barrens/0 47.40,39.20
|mapmarker The Barrens/0 47.60,41.20
step
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
turnin Hezrul Bloodmark##852 |goto The Barrens/0 45.34,28.41
step
talk Seereth Stonebreak##4049
turnin Goblin Invaders##1062 |goto The Barrens 35.26,27.88
step
Watch the dialogue
talk Seereth Stonebreak##4049
accept The Elder Crone##1063 |goto The Barrens 35.26,27.88
accept Shredding Machines##1068 |goto The Barrens/0 35.26,27.88
step
talk Makaba Flathoof##11857
turnin Protect Kaya##6523 |goto The Barrens 35.19,27.79
accept Kaya's Alive##6401 |goto The Barrens 35.19,27.79
turnin Kill Grundig Darkcloud##6629 |goto The Barrens 35.19,27.79
step
Follow the path up and through the mountains |goto Stonetalon Mountains 82.07,98.57 < 30 |only if walking and subzone("The Barrens")
talk Witch Doctor Jin'Zil##3995
|tip Inside the small cave.
turnin Letter to Jin'Zil##1060 |goto Stonetalon Mountains 74.54,97.94
accept Jin'Zil's Forest Magic##1058 |goto Stonetalon Mountains/0 74.54,97.94
step
talk Ken'zigla##4197
turnin News of Dogran##1510 |goto Stonetalon Mountains 73.25,95.13
accept Ken'zigla's Draught##1511 |goto Stonetalon Mountains 73.25,95.13
|only if Warlock
step
talk Xen'Zilla##12816
|tip Inside the building.
turnin Blood Feeders##6461 |goto Stonetalon Mountains 71.24,95.02
step
talk Tammra Windfield##11864
turnin Kaya's Alive##6401 |goto Stonetalon Mountains/0 47.46,58.38
step
Follow the path up |goto Stonetalon Mountains/0 49.20,61.91 < 20 |only if walking
talk Tsunaman##11862
|tip Walks around.
accept Trouble in the Deeps##6562 |goto Stonetalon Mountains/0 47.37,64.29
step
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Further Instructions##1095 |goto Stonetalon Mountains/0 58.99,62.60
step
kill XT:9##4074 |q 1068/2 |goto Stonetalon Mountains/0 70.66,56.12
|tip Humanoid robot.
|tip Walks around.
|tip Kill enemies while searching.
|tip Spawns at this location.
|mapmarker Stonetalon Mountains/0 59.80,51.20
|mapmarker Stonetalon Mountains/0 60.00,54.60
|mapmarker Stonetalon Mountains/0 62.20,56.00
|mapmarker Stonetalon Mountains/0 66.40,54.80
|mapmarker Stonetalon Mountains/0 66.60,56.80
|mapmarker Stonetalon Mountains/0 69.00,57.60
|mapmarker Stonetalon Mountains/0 64.60,56.40
step
kill XT:4##4073 |q 1068/1 |goto Stonetalon Mountains/0 67.32,46.58
|tip Humanoid robot.
|tip Walks around.
|tip Kill enemies while searching.
|tip Spawns at this location.
|mapmarker Stonetalon Mountains/0 63.40,44.80
|mapmarker Stonetalon Mountains/0 63.40,46.80
|mapmarker Stonetalon Mountains/0 65.20,48.60
|mapmarker Stonetalon Mountains/0 65.80,45.20
|mapmarker Stonetalon Mountains/0 67.20,49.20
|mapmarker Stonetalon Mountains/0 70.60,48.80
|mapmarker Stonetalon Mountains/0 71.20,43.80
|mapmarker Stonetalon Mountains/0 71.40,46.00
|mapmarker Stonetalon Mountains/0 68.80,47.60
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ashenvale (21-22)",{
image=ZGV.IMAGESDIR.."Ashenvale",
hardcore = true,
next="Leveling Guides\\Hillsbrad Foothills (22-24)",
},[[
step
Enter the tunnel and follow the path of lanterns to Ashenvale |goto Stonetalon Mountains 78.28,42.51 < 15 |only if walking and not zone("Ashenvale")
Leave the tunnel and enter Ashenvale |goto Stonetalon Mountains 81.54,30.03 < 15 |only if walking and not zone("Ashenvale")
talk Andruk##11901
|tip Avoid Astranaar.
fpath Zoram'gar Outpost |goto Ashenvale 12.23,33.80
step
talk Je'neu Sancrea##12736
|tip Inside the building.
turnin Trouble in the Deeps##6562 |goto Ashenvale/0 11.56,34.28
step
talk Karang Amakkar##12757
accept Between a Rock and a Thistlefur##216 |goto Ashenvale/0 11.90,34.53
step
talk Marukai##12719
|tip Inside the building.
accept Naga at the Zoram Strand##6442 |goto Ashenvale/0 11.69,34.90
step
talk Mitsuwa##12721
|tip Inside the building.
accept Troll Charm##6462 |goto Ashenvale/0 11.65,34.85
step
kill Wrathtail Wave Rider##3713, Wrathtail Sorceress##3717, Wrathtail Razortail##3712, Wrathtail Sea Witch##3715, Wrathtail Priestess##3944, Wrathtail Myrmidon##3711
|tip Nagas.
collect 20 Wrathtail Head##5490 |q 6442/1 |goto Ashenvale/0 14.53,23.81
step
Kill enemies
ding 21,23750 |goto Ashenvale/0 14.53,23.81
step
talk Marukai##12719
|tip Inside the building.
turnin Naga at the Zoram Strand##6442 |goto Ashenvale/0 11.69,34.90
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1063
|only if Druid
step
talk Chesmu##8356
|tip Deposit into the bank.
|tip Inside the building.
bank Digging Claw##5059 |goto Thunder Bluff 47.13,57.89 |q 868
step
talk Urek Thunderhorn##3040
|tip Inside the building.
Train Abilities |trainer Urek Thunderhorn##3040 |goto Thunder Bluff/0 59.11,86.86 |q 1063
|only if Hunter
step
talk Ker Ragetotem##3043
|tip Inside the building.
Train Abilities |trainer Ker Ragetotem##3043 |goto Thunder Bluff/0 57.58,85.52 |q 1063
|only if Warrior
step
talk Hanashi##2704
|tip Inside the building.
Train Two-Handed Axes |complete weaponskill("TH_AXE") > 0 |goto Orgrimmar/0 81.53,19.61
|only if Warrior
step
talk Magatha Grimtotem##4046
|tip Inside the tent.
turnin The Elder Crone##1063 |goto Thunder Bluff 69.85,30.91
step
Watch the dialogue
talk Magatha Grimtotem##4046
|tip Inside the tent.
accept Forsaken Aid##1064 |goto Thunder Bluff 69.85,30.91
step
Enter the cave |goto Thunder Bluff 29.81,29.82 < 15 |walk |only if not subzone("The Pools of Vision")
talk Apothecary Zamah##3419
|tip Inside the cave.
turnin Forsaken Aid##1064 |goto Thunder Bluff 22.81,20.90
accept Journey to Tarren Mill##1065 |goto Thunder Bluff 22.81,20.90
step
talk Malakai Cross##3045
|tip Inside the cave.
Train Abilities |trainer Malakai Cross##3045 |goto Thunder Bluff/0 24.55,22.58 |q 3301
|only if Priest
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Ur'kyo##6018
|tip Inside the building.
turnin Shadowguard##5642 |goto Orgrimmar/0 35.59,87.82
|only if Troll Priest
step
talk Archmage Shymm##3047
|tip Inside the cave.
Train Abilities |trainer Archmage Shymm##3047 |goto Thunder Bluff/0 22.76,14.52 |q 3301
|only if Mage
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Thuul##5958
|tip Top of the building.
learnspell Teleport: Orgrimmar##3567 |goto Orgrimmar 38.68,85.41
|only if Mage
step
talk Alodan the Hopeful##246344
|tip Inside the cave.
Train Abilities |trainer Alodan the Hopeful##246344 |goto Thunder Bluff/0 25.20,14.41 |q 3301
|only if Paladin
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Siln Skychaser##3030
|tip Inside the building.
Train Abilities |trainer Siln Skychaser##3030 |goto Thunder Bluff/0 22.83,21.10 |q 3301
|only if Shaman
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Grunt Logmar##5911
turnin Ken'zigla's Draught##1511 |goto The Barrens 44.62,59.27
accept Dogran's Captivity##1515 |goto The Barrens 44.62,59.27
|only if Warlock
step
talk Grunt Dogran##5908
|tip Inside the hut.
turnin Dogran's Captivity##1515 |goto The Barrens 43.31,47.89
accept Love's Gift##1512 |goto The Barrens 43.31,47.89
|only if Warlock
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3301
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3301
|only if Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin Love's Gift##1512 |goto Orgrimmar 48.25,45.29
accept The Binding##1513 |goto Orgrimmar 48.25,45.29
|only if Warlock
step
use Dogran's Pendant##6626
|tip Stand on the pink symbol.
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
kill Summoned Succubus##5677 |q 1513/1 |goto Orgrimmar 49.45,50.03
|only if Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin The Binding##1513 |goto Orgrimmar 48.24,45.29
|only if Warlock
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3301
|only if Rogue
step
talk Shenthul##3401
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
accept The Shattered Salute##2460 |goto Orgrimmar/0 43.05,53.74
|only if Rogue
step
Watch the dialogue
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
|tip Wait for Shenthul to salute you.
Perform the Shattered Salute |q 2460/1 |goto Orgrimmar/0 43.05,53.74
|tip Perform the {o}/salute{} emote on Shenthul. |macro /salute
|only if Rogue
step
talk Shenthul##3401
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin The Shattered Salute##2460 |goto Orgrimmar/0 43.05,53.74
accept Deep Cover##2458 |goto Orgrimmar/0 43.05,53.74
|only if Rogue
step
use Flare Gun##8051
|tip On Taskmaster Fizzule {o}two times{}.
|tip Nearby to the north.
Signal Taskmaster Fizzule |q 2458/1 |goto The Barrens 55.47,6.08
|tip Perform the {o}/salute{} emote on Taskmaster Fizzule. |macro /salute
|tip Wait for him to salute you back.
|only if Rogue
step
talk Taskmaster Fizzule##7233
turnin Deep Cover##2458 |goto The Barrens 55.44,5.56
accept Mission: Possible But Not Probable##2478 |goto The Barrens 55.44,5.56
|only if Rogue
step
collect Silixiz's Tower Key##8072 |q 2478/5 |goto The Barrens 54.80,5.97
|tip {o}Pickpocket{} Foreman Silixiz.
|only if Rogue
step
kill 2 Mutated Venture Co. Drone##7310 |q 2478/1 |goto The Barrens 54.71,5.73
|tip Use {o}Ambush{} to deal extra damage.
|tip {o}Ground floor{} inside the building.
|only if Rogue
step
kill 2 Venture Co. Patroller##7308 |q 2478/3 |goto The Barrens 54.81,5.59
|tip Use {o}Rupture{} to deal extra damage.
|tip {o}Middle floor{} inside the building.
|only if Rogue
step
kill 2 Venture Co. Lookout##7307 |q 2478/2 |goto The Barrens 54.63,5.64
|tip Use {o}Eviscerate{} to deal extra damage.
|tip Up on the balcony.
|tip {o}Middle floor{} inside the building.
|only if Rogue
step
kill Grand Foreman Puzik Gallywix##7288
|tip Use {o}Ambush{} to deal extra damage.
|tip {o}Top floor{} inside the building.
collect Gallywix's Head##8074 |q 2478/4 |goto The Barrens 54.75,5.59
|only if Rogue
step
click Gallywix's Lockbox##129127
|tip Lockpick it.
|tip {o}Top floor{} inside the building.
collect Cache of Zanzil's Altered Mixture##8073 |q 2478/6 |goto The Barrens 54.75,5.55
|only if Rogue
step
talk Shenthul##3401
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin Mission: Possible But Not Probable##2478 |goto Orgrimmar 43.05,53.74
accept Hinott's Assistance##2479 |goto Orgrimmar 43.05,53.74
|only if Rogue
step
_Destroy These Items:_
|tip Not needed.
trash Flare Gun##8051
trash Fizzule's Whistle##8066
|only if Rogue
step
talk Rekkul##3334
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
|tip Buy {o}20+{} Dust of Decay and Empty Vials.
|tip Used to create poisons.
Visit the Vendor |vendor Rekkul##3334 |goto Orgrimmar 42.09,49.48 |q 2479
|only if Rogue
step
Remove the Touch of Zanzil |nobuff Touch of Zanzil##9991
|tip Multiple options.
|tip Create {o}Anti-Venom{} with First Aid.
|tip Buy {o}Jungle Remedy{} from Auction House.
|tip Ask a {o}Druid{} to cast {o}Cure Poison{} on you.
|only if Rogue
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
click Strange Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Agility##15883 |goto The Barrens 56.67,8.32 |q 30
|only if Druid
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Hillsbrad Foothills (22-24)",{
image=ZGV.IMAGESDIR.."Hillsbrad Foothills",
hardcore = true,
next="Leveling Guides\\The Barrens (24-25)",
},[[
step
talk Lexington Mortaim##2492
|tip Up on the platform.
learnspell Teleport: Undercity##3563 |goto Undercity/0 84.19,15.58
|only if Mage
step
talk Aelthalyste##4606
turnin Devouring Plague##5644 |goto Undercity/0 49.26,17.12
|only if Scourge Priest
step
click Strong Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Endurance##15882 |goto Silverpine Forest 29.54,29.50 |q 30
|only if Druid
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
click Yuriv's Tombstone
turnin Until Death Do Us Part##264 |goto Silverpine Forest/0 44.18,42.67
step
talk Mura Runetotem##8385
turnin Mura Runetotem##3301 |goto Silverpine Forest 42.91,41.99
step
talk Apothecary Renferrel##1937
accept Journey to Hillsbrad Foothills##493 |goto Silverpine Forest 42.80,40.87
step
talk Shadow Priest Allister##2121
accept Watching the Roads##95981 |goto Silverpine Forest/0 43.98,40.93
accept Beren's Peril##516 |goto Silverpine Forest/0 43.98,40.93
stickystart "kill_ravenclaw_enemies"
step
Follow the path up |goto Silverpine Forest/0 60.34,74.12 < 10 |walk
kill Ravenclaw Guardian##1973+, Ravenclaw Drudger##1974+
|tip Inside the cave.
collect Note Scrap##271343 |n
use the Note Scrap##271343
accept The Offering Stone##95884 |goto Silverpine Forest/0 59.90,71.25
step
click Offering Stone##645153
turnin The Offering Stone##95884 |goto Silverpine Forest/0 58.12,69.81
accept The Tortured Soul##95883 |goto Silverpine Forest/0 58.12,69.81
step
kill Ravenclaw Drudger##1974+, Ravenclaw Guardian##1973+
collect Tortured Soul##271350 |q 95883/1 |goto Silverpine Forest/0 59.67,70.78
step
click Offering Stone##645153
turnin The Tortured Soul##95883 |goto Silverpine Forest/0 58.15,69.81
step
label "kill_ravenclaw_enemies"
kill 8 Ravenclaw Drudger##1974+ |q 516/1 |goto Silverpine Forest/0 59.67,70.78
kill 8 Ravenclaw Guardian##1973+ |q 516/2 |goto Silverpine Forest/0 59.67,70.78
|tip Inside the cave.
step
label "Kill_Dalaran_Watchers_And_Wizards"
kill 8 Dalaran Watcher##1888 |q 95981/1 |goto Silverpine Forest/0 64.00,77.09
kill 8 Dalaran Wizard##1889 |q 95981/2 |goto Silverpine Forest/0 64.00,77.09
step
talk Deathstalker Lesh##2214
accept Time To Strike##494 |goto Hillsbrad Foothills 20.78,47.40
step
talk Zarise##2389
fpath Tarren Mill |goto Hillsbrad Foothills 60.14,18.62
step
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Journey to Hillsbrad Foothills##493 |goto Hillsbrad Foothills 61.44,19.06
turnin Journey to Tarren Mill##1065 |goto Hillsbrad Foothills 61.44,19.06
accept Blood of Innocents##1066 |goto Hillsbrad Foothills 61.44,19.06
accept Elixir of Suffering##496 |goto Hillsbrad Foothills 61.44,19.06
accept Elixir of Pain##501 |goto Hillsbrad Foothills 61.44,19.06
step
talk Serge Hinott##2391
|tip Inside the building.
turnin Hinott's Assistance##2479 |goto Hillsbrad Foothills 61.63,19.19
accept Hinott's Assistance##2480 |goto Hillsbrad Foothills 61.63,19.19
|only if Rogue
step
Watch the dialogue
|tip Inside the building.
Complete the Cure |q 2480/1 |goto Hillsbrad Foothills 61.58,18.97
|only if Rogue
step
talk Serge Hinott##2391
|tip Inside the building.
turnin Hinott's Assistance##2480 |goto Hillsbrad Foothills 61.58,18.97
|only if Rogue
step
use Hinott's Oil##8095
Remove the Touch of Zanzil |nobuff 136230
|only if Rogue
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin Time To Strike##494 |goto Hillsbrad Foothills 62.33,20.46
accept Battle of Hillsbrad##527 |goto Hillsbrad Foothills 62.33,20.46
step
talk Theodore Mont Claire##10057
Stable Your Pet |stablemaster Theodore Mont Claire##10057 |goto Hillsbrad Foothills/0 62.31,19.70 |q 496
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 3){}.
|only if Hunter
step
click Dangerous!
|tip Wanted poster.
accept Dangerous!##567 |goto Hillsbrad Foothills 62.55,19.69
step
click WANTED
|tip Wanted poster.
accept WANTED: Syndicate Personnel##549 |goto Hillsbrad Foothills 62.62,20.74
step
talk Krusk##2229
|tip Inside the building.
accept The Rescue##498 |goto Hillsbrad Foothills 63.23,20.66
step
use Empty Red Waterskin##7768
collect Filled Red Waterskin##7771 |q 1536/1 |goto Hillsbrad Foothills 62.15,20.75
|only if Shaman
step
Learn the {y}Claw (Rank 3){} Pet Ability |learnspell Claw##2982 |goto Hillsbrad Foothills/0 66.40,19.00 |q 496
|tip Cast {o}Tame Beast{} on a {o}Gray Bear{}.
|tip Kill enemies nearby.
|mapmarker Hillsbrad Foothills/0 54.40,19.80
|mapmarker Hillsbrad Foothills/0 55.00,13.40
|mapmarker Hillsbrad Foothills/0 55.40,28.00
|mapmarker Hillsbrad Foothills/0 56.40,22.40
|mapmarker Hillsbrad Foothills/0 56.40,35.40
|mapmarker Hillsbrad Foothills/0 57.00,25.40
|mapmarker Hillsbrad Foothills/0 58.40,30.60
|mapmarker Hillsbrad Foothills/0 59.40,38.00
|mapmarker Hillsbrad Foothills/0 61.20,35.20
|mapmarker Hillsbrad Foothills/0 62.00,14.60
|mapmarker Hillsbrad Foothills/0 62.20,31.40
|mapmarker Hillsbrad Foothills/0 62.40,27.20
|mapmarker Hillsbrad Foothills/0 64.40,33.60
|mapmarker Hillsbrad Foothills/0 64.40,37.20
|mapmarker Hillsbrad Foothills/0 65.00,16.20
|mapmarker Hillsbrad Foothills/0 66.40,22.40
|mapmarker Hillsbrad Foothills/0 66.40,26.20
|mapmarker Hillsbrad Foothills/0 67.40,29.60
|mapmarker Hillsbrad Foothills/0 67.80,14.40
|only if Hunter
step
talk Theodore Mont Claire##10057
Retrieve Your Pet |stablemaster Theodore Mont Claire##10057 |goto Hillsbrad Foothills/0 62.31,19.70 |q 496
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 3){} to Your Pet |learnpetspell Claw##16829 |q 496
|tip Use {o}Beast Training{} ability.
|only if Hunter
stickystart "Collect_Creeper_Ichor"
stickystart "Collect_Gray_Bear_Tongues"
stickystart "Collect_Vials_of_Innocent_Blood"
stickystart "Kill_Syndicate_Rogues_And_Watchmen"
step
Enter Durnholde Keep and cross the bridge |goto Hillsbrad Foothills 76.57,46.48 < 30 |only if walking
kill Jailor Marlgen##2428
|tip Walks around.
|tip Multiple locations.
collect Burnished Gold Key##3499 |goto Hillsbrad Foothills 78.80,42.00 |q 498
|mapmarker Hillsbrad Foothills/0 77.60,39.20
|mapmarker Hillsbrad Foothills/0 77.80,40.40
|mapmarker Hillsbrad Foothills/0 79.20,40.60
stickystop "Collect_Creeper_Ichor"
stickystop "Collect_Gray_Bear_Tongues"
step
click Locked ball and chain##1721
|tip Tied to the orc's leg.
Rescue Tog'thar |q 498/2 |goto Hillsbrad Foothills 79.79,39.66
step
kill Jailor Eston##2427
|tip Walks around.
|tip Multiple locations.
collect Dull Iron Key##3467 |goto Hillsbrad Foothills 79.60,41.83 |q 498
|mapmarker Hillsbrad Foothills/0 75.40,42.00
step
click Locked ball and chain##1721
|tip Tied to the orc's leg.
|tip Inside the building.
Rescue Drull |q 498/1 |goto Hillsbrad Foothills 75.33,41.50
step
label "Collect_Vials_of_Innocent_Blood"
kill Syndicate Shadow Mage##2244+
collect 5 Vial of Innocent Blood##5620 |q 1066/1 |goto Hillsbrad Foothills/0 79.70,42.49
step
label "Kill_Syndicate_Rogues_And_Watchmen"
kill 10 Syndicate Rogue##2260 |q 549/1 |goto Hillsbrad Foothills/0 78.99,43.13
kill 10 Syndicate Watchman##2261 |q 549/2 |goto Hillsbrad Foothills/0 78.99,43.13
step
Cross the bridge and leave Durnholde Keep |goto Hillsbrad Foothills 76.57,46.48 < 20 |c |q 498
|only if walking and subzone("Durnholde Keep")
stickystart "Collect_Gray_Bear_Tongues"
step
label "Collect_Creeper_Ichor"
kill Forest Moss Creeper##2350+
|tip Green spiders.
collect Creeper Ichor##3477 |q 496/2 |goto Hillsbrad Foothills 62.80,34.20
|stickyif not subzone("Durnholde Keep")
step
label "Collect_Gray_Bear_Tongues"
kill Gray Bear##2351, Vicious Gray Bear##2354
collect 10 Gray Bear Tongue##3476 |q 496/1 |goto Hillsbrad Foothills/0 62.80,34.20
|stickyif not subzone("Durnholde Keep")
step
Kill enemies
|tip Helps reach level 23 after quest turnins.
ding 22,19570 |goto Hillsbrad Foothills/0 62.80,34.20
step
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Blood of Innocents##1066 |goto Hillsbrad Foothills/0 61.44,19.06
turnin Elixir of Suffering##496 |goto Hillsbrad Foothills/0 61.44,19.06
accept Elixir of Suffering##499 |goto Hillsbrad Foothills/0 61.44,19.06
accept Return to Thunder Bluff##1067 |goto Hillsbrad Foothills/0 61.44,19.06
step
talk Umpi##2230
|tip Inside the building.
turnin Elixir of Suffering##499 |goto Hillsbrad Foothills/0 61.52,19.20
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin WANTED: Syndicate Personnel##549 |goto Hillsbrad Foothills/0 62.33,20.46
step
talk Krusk##2229
|tip Inside the building.
turnin The Rescue##498 |goto Hillsbrad Foothills/0 63.23,20.6
stickystart "Kill_Hillsbrad_Farmers_Farmhands"
stickystart "Collect_Mountain_Lion_Blood"
step
kill Farmer Getz##2403 |q 527/4 |goto Hillsbrad Foothills/0 36.74,39.44
|tip Multiple locations.
|tip Inside buildings or in the field.
|mapmarker Hillsbrad Foothills/0 35.20,38.60
|mapmarker Hillsbrad Foothills/0 35.20,40.40
step
kill Farmer Ray##232 |q 527/3 |goto Hillsbrad Foothills/0 33.68,35.42
|tip {o}Both floors{} inside the building.
|tip Can also be outside.
|mapmarker Hillsbrad Foothills/0 33.22,34.76
step
label "Kill_Hillsbrad_Farmers_Farmhands"
kill 6 Hillsbrad Farmer##2266 |q 527/1 |goto Hillsbrad Foothills/0 33.40,40.80
kill 6 Hillsbrad Farmhand##2360 |q 527/2 |goto Hillsbrad Foothills/0 33.40,40.80
step
label "Collect_Mountain_Lion_Blood"
kill Starving Mountain Lion##2384+
collect 10 Mountain Lion Blood##3496 |q 501/1 |goto Hillsbrad Foothills/0 43.98,37.68
|stickyif not subzone("Hillsbrad Fields")
step
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Elixir of Pain##501 |goto Hillsbrad Foothills/0 61.44,19.06
accept Elixir of Pain##502 |goto Hillsbrad Foothills/0 61.44,19.06
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin Battle of Hillsbrad##527 |goto Hillsbrad Foothills/0 62.33,20.45
accept Battle of Hillsbrad##528 |goto Hillsbrad Foothills/0 62.33,20.45
step
talk Deathguard Samsa##2418
accept Souvenirs of Death##546 |goto Hillsbrad Foothills/0 62.10,19.73
step
_NOTE:_
During the Next Steps
|tip Kill enemies as you walk.
|tip Reduces grinding later.
Click Here to Continue |confirm |q 502
stickystart "Kill_Citizen_Wilkes"
stickystart "Kill_Hillsbrad_Peasants"
stickystart "Collect_Hillsbrad_Human_Skulls"
step
talk Stanley##2274
|tip Small wolf.
|tip Walks around.
|tip Enrages and attacks after quest turnin.
|tip Kill him for {o}1000+ xp{}.
turnin Elixir of Pain##502 |goto Hillsbrad Foothills/0 32.66,35.32
step
kill Farmer Kalaba##2451 |q 567/4 |goto Hillsbrad Foothills/0 34.40,45.80
|tip Female carrying a pitchfork.
|tip Walks around.
|mapmarker Hillsbrad Foothills/0 36.40,45.20
|mapmarker Hillsbrad Foothills/0 36.40,47.60
step
label "Kill_Citizen_Wilkes"
map Hillsbrad Foothills
path follow strict;	loop on;	ants curved;	dist 20;	arrow hide
path	32.97,39.58	34.15,38.65	35.48,38.74	36.50,39.45	35.78,38.83
path	33.97,38.73	32.53,40.00	32.59,38.14	32.67,36.96	32.62,36.03
path	32.92,35.26	32.58,35.83	32.69,36.96	32.56,38.30	32.54,39.49
path	32.63,41.07	32.46,42.55	31.40,42.23	31.06,41.73	30.55,40.61
path	30.83,41.62	31.21,42.19	31.72,42.24	32.43,42.86	32.51,44.69
path	32.30,45.13	32.55,44.19	32.56,42.23	32.61,41.17
kill Citizen Wilkes##2449 |q 567/2
|tip Walks the path between buildings.
Spawns at [Hillsbrad Foothills/0 30.54,40.59] |noway
step
label "Kill_Hillsbrad_Peasants"
kill 15 Hillsbrad Peasant##2267 |q 528/1 |goto Hillsbrad Foothills/0 35.32,45.42
stickystop "Collect_Hillsbrad_Human_Skulls"
step
Kill enemies
|tip Helps reach level 24 after quest turnins.
|tip Higher level enemies soon.
ding 23,24600 |goto Hillsbrad Foothills 41.80,37.60
|mapmarker Hillsbrad Foothills/0 37.20,44.20
|mapmarker Hillsbrad Foothills/0 38.00,36.00
|mapmarker Hillsbrad Foothills/0 38.40,39.20
|mapmarker Hillsbrad Foothills/0 39.20,47.00
|mapmarker Hillsbrad Foothills/0 39.80,42.60
|mapmarker Hillsbrad Foothills/0 40.60,34.40
|mapmarker Hillsbrad Foothills/0 42.40,40.80
|mapmarker Hillsbrad Foothills/0 44.60,35.40
|mapmarker Hillsbrad Foothills/0 45.20,39.40
|mapmarker Hillsbrad Foothills/0 46.40,42.60
|mapmarker Hillsbrad Foothills/0 48.40,31.20
|mapmarker Hillsbrad Foothills/0 48.40,34.20
|mapmarker Hillsbrad Foothills/0 48.40,45.60
|mapmarker Hillsbrad Foothills/0 48.60,40.20
|mapmarker Hillsbrad Foothills/0 51.00,42.60
|mapmarker Hillsbrad Foothills/0 51.40,35.60
|mapmarker Hillsbrad Foothills/0 52.00,39.00
|mapmarker Hillsbrad Foothills/0 52.20,46.40
|mapmarker Hillsbrad Foothills/0 54.40,42.20
|mapmarker Hillsbrad Foothills/0 55.40,37.00
|mapmarker Hillsbrad Foothills/0 57.40,41.40
|mapmarker Hillsbrad Foothills/0 54.80,29.60
|mapmarker Hillsbrad Foothills/0 53.20,32.60
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin Battle of Hillsbrad##528 |goto Hillsbrad Foothills 62.33,20.45
accept Battle of Hillsbrad##529 |goto Hillsbrad Foothills 62.33,20.45
step
talk Shadow Priest Allister##2121
turnin Beren's Peril##516 |goto Silverpine Forest/0 43.98,40.93
turnin Watching the Roads##95981 |goto Silverpine Forest/0 43.98,40.93
stickystart "Kill_Blacksmith_Verrington"
stickystart "Kill_Hillsbrad_Apprentice_Blacksmiths"
stickystart "Collect_Hillsbrad_Human_Skulls"
step
click Shipment of Iron
|tip Inside the building.
collect Shipment of Iron##3564 |q 529/3 |goto Hillsbrad Foothills 32.01,45.45
step
label "Kill_Blacksmith_Verrington"
kill Blacksmith Verringtan##2404 |q 529/1 |goto Hillsbrad Foothills 32.41,44.81
|tip Walks around.
|tip Multiple locations.
|tip Can be inside the blacksmith building.
|mapmarker Hillsbrad Foothills/0 31.00,44.80
|mapmarker Hillsbrad Foothills/0 31.20,47.40
step
label "Kill_Hillsbrad_Apprentice_Blacksmiths"
kill 4 Hillsbrad Apprentice Blacksmith##2265 |q 529/2 |goto Hillsbrad Foothills 32.41,44.81
|mapmarker Hillsbrad Foothills/0 31.00,46.20
|mapmarker Hillsbrad Foothills/0 31.20,44.00
stickystop "Collect_Hillsbrad_Human_Skulls"
step
use Half Pendant of Aquatic Agility##15883
collect Pendant of the Sea Lion##15885 |q 30/1 |goto Moonglade 35.92,41.42
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Trial of the Sea Lion##30 |goto Moonglade 56.21,30.64
accept Aquatic Form##31 |goto Moonglade 56.21,30.64
|only if Druid
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1067
|only if Druid
step
label "Collect_Hillsbrad_Human_Skulls"
kill Hillsbrad Farmhand##2360, Hillsbrad Farmer##2266, Hillsbrad Peasant##2267, Hillsbrad Tailor##2264, Hillsbrad Apprentice Blacksmith##2265, Hillsbrad Footman##2268, Hillsbrad Councilman##2387
collect 30 Hillsbrad Human Skull##3692 |q 546/1
|sticky only
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\The Barrens (24-25)",{
image=ZGV.IMAGESDIR.."The Barrens",
hardcore = true,
next="Leveling Guides\\Stonetalon Mountains (25-26)",
},[[
step
talk Chesmu##8356
|tip Collect from the bank.
|tip Inside the building.
collect Digging Claw##5059 |goto Thunder Bluff 47.13,57.89 |q 868
step
talk Chesmu##8356
|tip Deposit into the bank.
|tip Inside the building.
bank Hillsbrad Human Skull##3692+ |goto Thunder Bluff/0 47.13,57.89 |q 546
bank Shipment of Iron##3564 |goto Thunder Bluff/0 47.13,57.89 |q 529
step
Enter the cave |goto Thunder Bluff 29.81,29.82 < 15 |walk |only if not subzone("The Pools of Vision")
talk Apothecary Zamah##3419
|tip Inside the cave.
turnin Return to Thunder Bluff##1067 |goto Thunder Bluff 22.81,20.90
step
Watch the dialogue
|tip Inside the cave.
talk Apothecary Zamah##3419
accept The Flying Machine Airport##1086 |goto Thunder Bluff 22.81,20.90
step
talk Malakai Cross##3045
|tip Inside the cave.
Train Abilities |trainer Malakai Cross##3045 |goto Thunder Bluff/0 24.55,22.58 |q 843 |future
|only if Priest
step
talk Archmage Shymm##3047
|tip Inside the cave.
Train Abilities |trainer Archmage Shymm##3047 |goto Thunder Bluff/0 22.76,14.52 |q 843 |future
|only if Mage
step
talk Alodan the Hopeful##246344
|tip Inside the cave.
Train Abilities |trainer Alodan the Hopeful##246344 |goto Thunder Bluff/0 25.20,14.41 |q 843 |future
|only if Paladin
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Siln Skychaser##3030
|tip Inside the building.
Train Abilities |trainer Siln Skychaser##3030 |goto Thunder Bluff/0 22.83,21.10 |q 843 |future
|only if Shaman
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Tah Winterhoof##3024
accept Pigments for Paints##97538 |goto Thunder Bluff/0 54.14,47.00
step
talk Zangen Stonehoof##4721
accept The Sacred Flame##1195 |goto Thunder Bluff/0 54.96,51.38
step
talk Urek Thunderhorn##3040
|tip Inside the building.
Train Abilities |trainer Urek Thunderhorn##3040 |goto Thunder Bluff/0 59.11,86.86 |q 843 |future
|only if Hunter
step
talk Hesuwa Thunderhorn##10086
|tip Inside the building.
Train Pet Abilities |trainer Hesuwa Thunderhorn##10086 |goto Thunder Bluff/0 54.09,83.97 |q 843 |future
|only if Hunter
step
talk Ker Ragetotem##3043
|tip Inside the building.
Train Abilities |trainer Ker Ragetotem##3043 |goto Thunder Bluff/0 57.58,85.52 |q 843 |future
|only if Warrior
step
talk Turak Runetotem##3033
|tip Inside the building.
turnin Aquatic Form##31 |goto Thunder Bluff 76.48,27.22
|only if Druid
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 843 |future
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 843 |future
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 843 |future
|only if Warlock
step
talk Mangletooth##3430
accept Betrayal from Within##879 |goto The Barrens 44.55,59.24
step
_NOTE:_
talk Mangletooth##3430
|tip Exchange Blood Shards for buffs.
|tip When questing in the Barrens, spend extra Blood Shards here.
|tip
|tip {o}SPIRIT OF THE WIND{}
|tip +30% Movement Speed (5 Minutes)
|tip Note: Does {o}NOT{} stack with other run speed abilities.
|tip
|tip {o}AGAMAGGAN'S STRENGTH{}
|tip +10 Strength (30 Minutes)
|tip
|tip {o}AGAMAGGAN'S AGILITY{}
|tip +10 Agility (30 Minutes)
|tip
|tip {o}WISDOM OF AGAMAGGAN{}
|tip +10 Intellect (30 Minutes)
|tip
|tip {o}RISING SPIRIT{}
|tip +25 Spirit (30 Minutes)
|tip
|tip {o}RAZORHIDE{}
|tip +95 Armor and Returns Damage to Enemies (10 Minutes)
|tip
Click Here to Continue |confirm |goto The Barrens 44.55,59.24 |q 879
|only if itemcount(5075) >= 4
step
talk Tatternack Steelforge##3433
accept Weapons of Choice##893 |goto The Barrens 45.10,57.68
step
talk Innkeeper Byula##7714
|tip Inside the building.
home Camp Taurajo |goto The Barrens 45.58,59.04 |q 1195 |future
step
kill Owatanka##3473
|tip Blue dinosuar.
|tip Multiple locations.
collect Owatanka's Tailspike##5102 |n
use Owatanka's Tailspike##5102
accept Owatanka##884 |goto The Barrens 44.40,61.40
|mapmarker The Barrens/0 45.40,62.80
|mapmarker The Barrens/0 49.20,61.40
|mapmarker The Barrens/0 49.40,59.20
step
click Silithid Mound##3685+
|tip Large rocks leaking green liquid.
|tip May be attacked.
collect 12 Silithid Egg##5058 |q 868/1 |goto The Barrens/0 45.14,71.02
step
use Harvester's Head##5138
accept The Harvester##897
|only if itemcount(5138) > 0
step
talk Brine##5899
|tip Top of the hill.
turnin Call of Water##1536 |goto The Barrens 43.42,77.41
accept Call of Water##1534 |goto The Barrens 43.42,77.41
|only if Shaman
step
talk Sulhasa##14242
|tip Up in the tree.
accept Field to Clear##98093 |goto The Barrens/0 47.93,77.62
stickystart "Kill_Hecklefang_Stalkers_And_Stormhides"
step
map The Barrens
path	follow strictbounce;	loop off;	ants curved;	dist 20;	markers none;	arrow hide
path	46.15,75.39	46.10,75.61	46.09,75.86	46.08,76.27	46.03,76.60
path	45.95,76.84	45.85,77.13	45.80,77.44	45.78,77.93	45.79,78.44
path	45.83,78.70	45.99,79.01	46.10,79.27	46.15,79.49	46.13,79.89
path	46.10,80.40	46.10,80.70	46.12,81.00	46.11,81.32
talk Gann Stonespire##3341
|tip Walks along the road.
accept Gann's Reclamation##843
stickystart "Collect_Razormane_Backstabber"
stickystart "Collect_Razormane_Wand"
stickystart "Collect_Razormane_War_Shield"
stickystart "Collect_Washte_Pawnes_Feather"
step
kill Kuz##3436
|tip Quilboar in a red robe.
|tip Walks around.
|tip Spawns here.
collect Kuz's Skull##5074 |q 879/1 |goto The Barrens 43.96,79.57
|mapmarker The Barrens/0 42.80,79.60
|mapmarker The Barrens/0 44.00,81.60
|mapmarker The Barrens/0 45.60,80.20
stickystop "Kill_Hecklefang_Stalkers_And_Stormhides"
step
kill Nak##3434
|tip Walks around.
|tip Careful, stealthed enemies.
collect Nak's Skull##5073 |q 879/2 |goto The Barrens 43.82,83.10
step
kill Lok Orcbane##3435
|tip Careful, stealthed enemies.
|tip Inside the building.
collect Lok's Skull##5072 |q 879/3 |goto The Barrens 40.15,80.54
step
label "Collect_Razormane_Backstabber"
kill Razormane Stalker##3457, Razormane Pathfinder##3456
|tip Pathfinders and Stalkers.
|tip Careful, stealthed enemies. |notinsticky
collect Razormane Backstabber##5093 |q 893/1 |goto The Barrens 44.20,81.40
|tip Don't vendor it.
|mapmarker The Barrens/0 41.20,80.40
|mapmarker The Barrens/0 42.40,82.60
|mapmarker The Barrens/0 44.80,83.80
step
label "Collect_Razormane_Wand"
kill Razormane Seer##3458+
|tip Careful, stealthed enemies. |notinsticky
collect Charred Razormane Wand##5092 |q 893/2 |goto The Barrens 42.40,82.20
|tip Don't vendor it.
|mapmarker The Barrens/0 40.40,80.80
|mapmarker The Barrens/0 41.60,78.80
|mapmarker The Barrens/0 44.40,83.60
step
label "Collect_Razormane_War_Shield"
kill Razormane Warfrenzy##3459+
|tip Careful, stealthed enemies. |notinsticky
collect Razormane War Shield##5094 |q 893/3 |goto The Barrens 42.20,82.60
|tip Don't vendor it.
|mapmarker The Barrens/0 40.40,80.80
|mapmarker The Barrens/0 41.40,78.40
stickystart "Kill_Hecklefang_Stalkers_And_Stormhides"
step
label "Collect_Washte_Pawnes_Feather"
kill Washte Pawne##3472
|tip Red flying snake.
|tip Moves around.
collect Washte Pawne's Feather##5103 |n
use Washte Pawne's Feather##5103
accept Washte Pawne##885 |goto The Barrens 43.20,80.80
|mapmarker The Barrens/0 44.40,74.80
|mapmarker The Barrens/0 44.40,78.80
|mapmarker The Barrens/0 47.20,79.40
stickystart "Kill_Baeldun_Foremen_And_Excavators"
step
kill Prospector Khazgorm##3392
|tip Walks around.
|tip Multiple locations.
collect Khazgorm's Journal##5006 |q 843/3 |goto The Barrens 47.55,85.26
|mapmarker The Barrens/0 48.33,86.22
stickystop "Kill_Hecklefang_Stalkers_And_Stormhides"
step
label "Kill_Baeldun_Foremen_And_Excavators"
kill 5 Bael'dun Foreman##3375 |q 843/2 |goto The Barrens/0 47.46,85.17
kill 15 Bael'dun Excavator##3374 |q 843/1 |goto The Barrens/0 47.46,85.17
step
Leave Bael Modan |goto The Barrens/0 46.74,85.06 < 30 |c |q 843
|only if subzone("Bael Modan")
stickystart "Kill_Hecklefang_Stalkers_And_Stormhides"
step
map The Barrens
path	follow strictbounce;	loop off;	ants curved;	dist 20;	markers none;	arrow hide
path	46.15,75.39	46.10,75.61	46.09,75.86	46.08,76.27	46.03,76.60
path	45.95,76.84	45.85,77.13	45.80,77.44	45.78,77.93	45.79,78.44
path	45.83,78.70	45.99,79.01	46.10,79.27	46.15,79.49	46.13,79.89
path	46.10,80.40	46.10,80.70	46.12,81.00	46.11,81.32
talk Gann Stonespire##3341
|tip Walks along the road.
turnin Gann's Reclamation##843
accept Revenge of Gann##846
step
kill Bael'dun Rifleman##3377, Bael'dun Soldier##3376, Bael'dun Officer##3378
|tip Inside and outside the building.
|tip Safer to stay outside. |only if hardcore()
collect 6 Nitroglycerin##5017 |q 846/1 |goto The Barrens 48.75,84.49
collect 6 Wood Pulp##5018 |q 846/2 |goto The Barrens 48.75,84.49
collect 6 Sodium Nitrate##5019 |q 846/3 |goto The Barrens 48.75,84.49
step
map The Barrens
path	follow strictbounce;	loop off;	ants curved;	dist 20;	markers none;	arrow hide
path	46.15,75.39	46.10,75.61	46.09,75.86	46.08,76.27	46.03,76.60
path	45.95,76.84	45.85,77.13	45.80,77.44	45.78,77.93	45.79,78.44
path	45.83,78.70	45.99,79.01	46.10,79.27	46.15,79.49	46.13,79.89
path	46.10,80.40	46.10,80.70	46.12,81.00	46.11,81.32
talk Gann Stonespire##3341
|tip Walks along the road.
turnin Revenge of Gann##846
accept Revenge of Gann##849
step
click Bael Modan Flying Machine
|tip Top of the platform.
|tip Click it from a distance.
Destroy the Bael Modan Flying Machine |q 849/1 |goto The Barrens 47.00,85.60
step
map The Barrens
path	follow strictbounce;	loop off;	ants curved;	dist 20;	markers none;	arrow hide
path	46.15,75.39	46.10,75.61	46.09,75.86	46.08,76.27	46.03,76.60
path	45.95,76.84	45.85,77.13	45.80,77.44	45.78,77.93	45.79,78.44
path	45.83,78.70	45.99,79.01	46.10,79.27	46.15,79.49	46.13,79.89
path	46.10,80.40	46.10,80.70	46.12,81.00	46.11,81.32
talk Gann Stonespire##3341
|tip Walks along the road.
turnin Revenge of Gann##849
step
label "Kill_Hecklefang_Stalkers_And_Stormhides"
kill 7 Hecklefang Stalker##4128 |q 98093/1 |goto The Barrens/0 47.78,79.27
|tip Hyenas.
kill 7 Stormhide##3238 |q 98093/2 |goto The Barrens/0 47.78,79.27
|tip Pink dinosaurs.
step
talk Sulhasa##14242
|tip Up in the tree.
turnin Field to Clear##98093 |goto The Barrens/0 47.93,77.62
step
Kill enemies
|tip Helps reach level 25 after quest turnins.
ding 24,25300 |goto The Barrens/0 47.78,79.27
step
talk Shardi##11899
|tip Careful, higher level enemies.
fpath Brackenwall Village |goto Dustwallow Marsh 35.56,31.88
step
talk Tatternack Steelforge##3433
turnin Weapons of Choice##893 |goto The Barrens 45.10,57.68
step
talk Jorn Skyseer##3387
turnin The Harvester##897	|goto The Barrens 44.86,59.14 |only if haveq(897) or completedq(897)
turnin Owatanka##884		|goto The Barrens 44.86,59.14
turnin Washte Pawne##885	|goto The Barrens 44.86,59.14
accept The Ashenvale Hunt##6382 |goto The Barrens 44.86,59.14
step
talk Mangletooth##3430
turnin Betrayal from Within##879 |goto The Barrens 44.55,59.24
accept Betrayal from Within##906 |goto The Barrens 44.55,59.24
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 25 ammo when restocking.
Click Here to Continue |confirm |q 906
|only if Hunter
step
talk Thork##3429
turnin Betrayal from Within##906 |goto The Barrens 51.50,30.87
step
talk Korran##3428
turnin Egg Hunt##868 |goto The Barrens 51.07,29.63
step
_Destroy These Items:_
|tip Not needed.
trash Silithid Egg##5058
step
talk Mahren Skyseer##3388
turnin Mahren Skyseer##874 |goto The Barrens 65.84,43.86
accept Isha Awak##873 |goto The Barrens 65.84,43.86
step
kill Isha Awak##3476
|tip Water dinosaur.
|tip Swims around.
|tip Multiple locations.
collect Heart of Isha Awak##5104 |q 873/1 |goto The Barrens/0 65.40,47.20
|mapmarker The Barrens/0 63.40,53.40
|mapmarker The Barrens/0 64.20,50.40
step
talk Mahren Skyseer##3388
turnin Isha Awak##873 |goto The Barrens 65.84,43.86
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stonetalon Mountains (25-26)",{
image=ZGV.IMAGESDIR.."Stonetalon Mountains",
hardcore = true,
next="Leveling Guides\\Ashenvale (26-28)",
},[[
step
talk Braelyn Firehand##4198
accept Cenarius' Legacy##1087 |goto Stonetalon Mountains 45.94,60.42
step
talk Tammra Windfield##11864
accept Cycle of Rebirth##6301 |goto Stonetalon Mountains 47.46,58.38
step
talk Maggran Earthbinder##11860
accept Calling in the Reserves##5881 |goto Stonetalon Mountains 47.20,61.15
accept Harpies Threaten##6282 |goto Stonetalon Mountains 47.20,61.15
accept Bloodfury Trinkets##86576 |goto Stonetalon Mountains 47.20,61.15
step
Follow the path up |goto Stonetalon Mountains/0 49.20,61.91 < 20 |only if walking
talk Tsunaman##11862
|tip Walks around.
accept Elemental War##6393 |goto Stonetalon Mountains/0 47.37,64.29
step
talk Ziz Fizziks##4201
|tip Inside the building.
accept Gerenzo Wrenchwhistle##1096 |goto Stonetalon Mountains/0 58.99,62.60
step
use Toxic Fogger##5638
|tip Under the platform.
Place the Toxic Fogger |q 1086/1 |goto Stonetalon Mountains 66.52,45.48
step
Follow the path up |goto Stonetalon Mountains 68.94,39.65 < 30 |only if walking
kill Gerenzo Wrenchwhistle##4202
|tip Up on the wooden platform.
|tip Multiple locations.
collect Gerenzo's Mechanical Arm##5736 |q 1096/1 |goto Stonetalon Mountains 64.60,39.80
|mapmarker Stonetalon Mountains/0 62.80,40.40
|mapmarker Stonetalon Mountains/0 63.60,39.60
step
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Gerenzo Wrenchwhistle##1096 |goto Stonetalon Mountains 58.99,62.60
stickystart "Collect_Mirkweed_Pods"
stickystart "Collect_Gaea_Seeds"
step
Leave Windshear Crag |goto Stonetalon Mountains/0 60.47,70.13 < 40 |only if walking and subzone("Windshear Crag")
kill Burning Ravager##4037, Rogue Flame Spirit##4036, Burning Destroyer##4038
|tip Fire elementals.
|tip Skip once no more to kill.
|tip Can finish later.
collect 10 Incendrites##16312 |q 6393/1 |goto Stonetalon Mountains/0 44.80,43.40
|mapmarker Stonetalon Mountains/0 44.00,39.40
stickystart "Collect_Fey_Dragon_Scale"
stickystart "Collect_Stonetalon_Sap"
step
kill Antlered Courser##4018, Great Courser##4019
|tip Deer.
collect 30 Courser Eye##5585 |q 1058/3 |goto Stonetalon Mountains/0 46.40,38.20
|mapmarker Stonetalon Mountains/0 34.00,11.20
|mapmarker Stonetalon Mountains/0 36.40,16.40
|mapmarker Stonetalon Mountains/0 37.40,10.20
|mapmarker Stonetalon Mountains/0 39.20,5.60
|mapmarker Stonetalon Mountains/0 39.20,17.60
|mapmarker Stonetalon Mountains/0 39.80,13.80
|mapmarker Stonetalon Mountains/0 45.00,20.40
|mapmarker Stonetalon Mountains/0 45.00,24.60
|mapmarker Stonetalon Mountains/0 46.40,30.80
|mapmarker Stonetalon Mountains/0 46.60,27.40
|mapmarker Stonetalon Mountains/0 48.40,36.00
|mapmarker Stonetalon Mountains/0 51.00,38.60
|mapmarker Stonetalon Mountains/0 52.00,34.40
stickystop "Collect_Mirkweed_Pods"
stickystop "Collect_Gaea_Seeds"
stickystart "Collect_Twilight_Whiskers"
step
label "Collect_Fey_Dragon_Scale"
kill Fey Dragon##4016+
|tip Small blue dragons.
|tip Uncommon and spread out.
collect Fey Dragon Scale##5583 |q 1058/4 |goto Stonetalon Mountains/0 41.00,12.20
|mapmarker Stonetalon Mountains/0 30.20,14.80
|mapmarker Stonetalon Mountains/0 31.20,9.40
|mapmarker Stonetalon Mountains/0 32.60,17.20
|mapmarker Stonetalon Mountains/0 33.20,12.40
|mapmarker Stonetalon Mountains/0 35.40,15.40
|mapmarker Stonetalon Mountains/0 35.40,18.60
|mapmarker Stonetalon Mountains/0 36.80,21.60
|mapmarker Stonetalon Mountains/0 38.20,14.00
|mapmarker Stonetalon Mountains/0 38.40,10.60
|mapmarker Stonetalon Mountains/0 38.60,17.80
|mapmarker Stonetalon Mountains/0 39.60,7.40
step
label "Collect_Stonetalon_Sap"
kill Sap Beast##4020+
|tip Green oozes.
|tip Shared spawns with Corrosive Sap Beasts.
collect 5 Stonetalon Sap##5582 |q 1058/1 |goto Stonetalon Mountains/0 35.40,17.80
|mapmarker Stonetalon Mountains/0 32.20,16.40
|mapmarker Stonetalon Mountains/0 33.40,20.20
|mapmarker Stonetalon Mountains/0 38.40,15.40
|mapmarker Stonetalon Mountains/0 39.00,12.40
|mapmarker Stonetalon Mountains/0 39.00,18.60
stickystart "Kill_Cenarion_Enemies"
step
label "Collect_Twilight_Whiskers"
kill Twilight Runner##4067+
|tip Blue leopards.
collect 5 Twilight Whisker##5584 |q 1058/2 |goto Stonetalon Mountains/0 31.40,13.00
|mapmarker Stonetalon Mountains/0 31.00,9.60
|mapmarker Stonetalon Mountains/0 34.00,11.20
|mapmarker Stonetalon Mountains/0 34.40,16.20
|mapmarker Stonetalon Mountains/0 37.40,16.60
|mapmarker Stonetalon Mountains/0 38.40,10.00
|mapmarker Stonetalon Mountains/0 40.20,14.80
step
label "Kill_Cenarion_Enemies"
kill 4 Son of Cenarius##4057 |q 1087/1 |goto Stonetalon Mountains/0 36.28,12.39
kill 4 Daughter of Cenarius##4053 |q 1087/2 |goto Stonetalon Mountains/0 36.28,12.39
kill 4 Cenarion Botanist##4051 |q 1087/3 |goto Stonetalon Mountains/0 36.28,12.39
|tip Avoid {o}Sentinel Amarassan{}.
|tip {o}Level 27 elite{} night elf.
stickystart "Collect_Gaea_Seeds"
step
label "Collect_Mirkweed_Pods"
Leave Stonetalon Peak |goto Stonetalon Mountains/0 41.62,16.01 < 30 |only if walking and subzone("Stonetalon Peak")
click Mirkweed##667362+
|tip Tall bushy plants.
|tip Underwater.
click Dried Mirkweed Pile##667364+
|tip Flat red and green plant patches.
|tip Around the water edge.
collect 30 Mirkweed Pods##278201 |q 97538/1 |goto Stonetalon Mountains/0 48.52,40.24
|stickyif subzone("Mirkfallon Lake")
step
label "Collect_Gaea_Seeds"
Leave Stonetalon Peak |goto Stonetalon Mountains/0 41.62,16.01 < 30 |only if walking and subzone("Stonetalon Peak")
click Gaea Seed+
|tip Brown pine cones.
|tip Avoid the elite windstrider. |notinsticky
collect 10 Gaea Seed##16205 |q 6301/1 |goto Stonetalon Mountains/0 48.61,40.15
|stickyif subzone("Mirkfallon Lake")
stickystart "Kill_Bloodfury_Harpies"
stickystart "Kill_Bloodfury_Ambushers"
stickystart "Kill_Bloodfury_Slayers"
stickystart "Kill_Bloodfury_Roguefeathers"
stickystart "Collect_Glittering_Sunstones"
step
Leave Stonetalon Peak |goto Stonetalon Mountains/0 41.62,16.01 < 30 |only if walking and subzone("Stonetalon Peak")
kill Burning Ravager##4037, Rogue Flame Spirit##4036, Burning Destroyer##4038
|tip Fire elementals.
|tip Shared spawns with {o}basilisks{} and {o}walking trees{}.
collect 10 Incendrites##16312 |q 6393/1 |goto Stonetalon Mountains/0 44.68,41.82
|mapmarker Stonetalon Mountains/0 36.62,50.12
|mapmarker Stonetalon Mountains/0 28.40,63.20
|mapmarker Stonetalon Mountains/0 29.40,72.40
|mapmarker Stonetalon Mountains/0 32.40,73.60
|mapmarker Stonetalon Mountains/0 34.40,60.00
|mapmarker Stonetalon Mountains/0 35.40,73.40
|mapmarker Stonetalon Mountains/0 35.60,65.60
|mapmarker Stonetalon Mountains/0 36.20,70.40
|mapmarker Stonetalon Mountains/0 32.60,67.40
step
label "Kill_Bloodfury_Harpies"
kill 7 Bloodfury Harpy##4022 |q 6282/1 |goto Stonetalon Mountains/0 32.60,61.60
|mapmarker Stonetalon Mountains/0 29.20,63.20
|mapmarker Stonetalon Mountains/0 30.40,59.40
|mapmarker Stonetalon Mountains/0 31.40,66.00
|mapmarker Stonetalon Mountains/0 35.20,63.40
step
label "Kill_Bloodfury_Ambushers"
kill 7 Bloodfury Ambusher##4025 |q 6282/2 |goto Stonetalon Mountains/0 32.20,63.80
|mapmarker Stonetalon Mountains/0 29.20,63.60
|mapmarker Stonetalon Mountains/0 30.80,59.60
|mapmarker Stonetalon Mountains/0 31.40,66.80
|mapmarker Stonetalon Mountains/0 34.40,61.20
|mapmarker Stonetalon Mountains/0 35.20,64.60
step
label "Kill_Bloodfury_Slayers"
kill 7 Bloodfury Slayer##4024 |q 6282/3 |goto Stonetalon Mountains/0 34.40,67.40
|mapmarker Stonetalon Mountains/0 26.40,68.00
|mapmarker Stonetalon Mountains/0 27.00,71.00
|mapmarker Stonetalon Mountains/0 29.40,68.40
|mapmarker Stonetalon Mountains/0 30.00,71.60
|mapmarker Stonetalon Mountains/0 34.00,70.80
|mapmarker Stonetalon Mountains/0 37.00,70.80
|mapmarker Stonetalon Mountains/0 37.20,65.40
step
label "Kill_Bloodfury_Roguefeathers"
kill 7 Bloodfury Roguefeather##4023 |q 6282/4 |goto Stonetalon Mountains/0 34.40,67.40
|mapmarker Stonetalon Mountains/0 26.40,68.00
|mapmarker Stonetalon Mountains/0 27.00,71.00
|mapmarker Stonetalon Mountains/0 29.40,68.40
|mapmarker Stonetalon Mountains/0 30.00,71.60
|mapmarker Stonetalon Mountains/0 34.00,70.80
|mapmarker Stonetalon Mountains/0 37.00,70.80
|mapmarker Stonetalon Mountains/0 37.20,65.40
step
label "Collect_Glittering_Sunstones"
kill Bloodfury Harpy##4022, Bloodfury Ambusher##4025, Bloodfury Slayer##4024, Bloodfury Roguefeather##4023, Bloodfury Windcaller##4026, Bloodfury Storm Witch##4027
|tip Harpies.
collect 15 Glittering Sunstone##277936 |q 86576/1 |goto Stonetalon Mountains/0 31.53,64.94
step
Kill enemies
|tip All around the Charred Vale.
ding 26 |goto Stonetalon Mountains/0 32.60,67.40
|mapmarker Stonetalon Mountains/0 28.00,66.20
|mapmarker Stonetalon Mountains/0 28.40,63.20
|mapmarker Stonetalon Mountains/0 29.40,72.40
|mapmarker Stonetalon Mountains/0 32.40,73.60
|mapmarker Stonetalon Mountains/0 34.40,60.00
|mapmarker Stonetalon Mountains/0 35.40,73.40
|mapmarker Stonetalon Mountains/0 35.60,65.60
|mapmarker Stonetalon Mountains/0 36.20,70.40
step
Follow the path to Sun Rock Retreat |goto Stonetalon Mountains/0 37.93,67.96 < 20 |only if walking and subzone("The Charred Vale")
talk Mor'rogal##11861
turnin Bloodfury Trinkets##86576 |goto Stonetalon Mountains/0 47.21,64.05
step
talk Tsunaman##11862
|tip Walks around.
turnin Elemental War##6393 |goto Stonetalon Mountains/0 47.37,64.29
step
talk Maggran Earthbinder##11860
turnin Harpies Threaten##6282 |goto Stonetalon Mountains/0 47.19,61.14
step
talk Tammra Windfield##11864
turnin Cycle of Rebirth##6301 |goto Stonetalon Mountains/0 47.46,58.38
accept New Life##6381 |goto Stonetalon Mountains/0 47.46,58.38
step
talk Braelyn Firehand##4198
turnin Cenarius' Legacy##1087 |goto Stonetalon Mountains/0 45.94,60.42
step
Follow the path to the Charred Vale |goto Stonetalon Mountains/0 44.63,61.81 < 20 |only if walking and not subzone("The Charred Vale")
click Gaea Dirt Mound+
|tip Piles of dirt.
|tip All around the Charred Vale.
Plant #10# Gaea Seeds |q 6381/1 |goto Stonetalon Mountains/0 32.25,68.16
step
Follow the path to Sun Rock Retreat |goto Stonetalon Mountains/0 37.93,67.96 < 20 |only if walking and subzone("The Charred Vale")
talk Tammra Windfield##11864
turnin New Life##6381 |goto Stonetalon Mountains/0 47.46,58.38
step
talk Witch Doctor Jin'Zil##3995
|tip Inside the small cave.
turnin Jin'Zil's Forest Magic##1058 |goto Stonetalon Mountains/0 74.54,97.94
step
Follow the path up through the mountains |goto Stonetalon Mountains/0 72.92,93.72 < 20 |only if walking and subzone("Malaka'jin")
talk Seereth Stonebreak##4049
turnin Shredding Machines##1068 |goto The Barrens/0 35.26,27.88
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 6541 |future
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 6541 |future
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 6541 |future
|only if Priest
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 6541 |future
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 6541 |future
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 6541 |future
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 6541 |future
|only if Warlock
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 6541 |future
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 6541 |future
|only if Hunter
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ashenvale (26-28)",{
image=ZGV.IMAGESDIR.."Ashenvale",
hardcore = true,
next="Leveling Guides\\Thousand Needles (28-30)",
},[[
step
talk Auctioneer Thathung##8673
|tip Buy from the Auction House, if possible.
|tip Inside the building.
collect Shredder Operating Manual - Page 1##16645 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 2##16646 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 3##16647 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 4##16648 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 5##16649 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 6##16650 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 7##16651 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 8##16652 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 9##16653 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 10##16654 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 11##16655 |goto Orgrimmar 55.90,62.71 |q 6504 |future
collect Shredder Operating Manual - Page 12##16656 |goto Orgrimmar 55.90,62.71 |q 6504 |future
step
talk Trak'gen##3313
|tip Inside the building.
Buy Extra Ammo |vendor Trak'gen##3313 |goto Orgrimmar/0 48.13,80.54 |q 6541 |future
|tip Long questing session soon.
|only if Hunter
step
talk Thork##3429
accept Report to Kadrak##6541 |goto The Barrens 51.50,30.87
step
talk Kadrak##8582
|tip {o}Middle level{} of the tower.
turnin Report to Kadrak##6541 |goto The Barrens 48.12,5.42
step
talk Gurda Ragescar##12718
accept The Lost Pages##6504 |goto Ashenvale/0 70.00,71.15
|only if itemcount(16645) > 0 and itemcount(16646) > 0 and itemcount(16647) > 0 and itemcount(16648) > 0 and itemcount(16649) > 0 and itemcount(16650) > 0 and itemcount(16651) > 0 and itemcount(16652) > 0 and itemcount(16653) > 0 and itemcount(16654) > 0 and itemcount(16655) > 0 and itemcount(16656) > 0
step
use Shredder Operating Manual - Page 1##16645
collect Shredder Operating Manual - Chapter 1##16642 |q 6504/1
|only if haveq(6504) or completedq(6504)
step
use Shredder Operating Manual - Page 5##16649
collect Shredder Operating Manual - Chapter 2##16643 |q 6504/2
|only if haveq(6504) or completedq(6504)
step
use Shredder Operating Manual - Page 9##16653
collect Shredder Operating Manual - Chapter 3##16644 |q 6504/3
|only if haveq(6504) or completedq(6504)
step
talk Gurda Ragescar##12718
turnin The Lost Pages##6504 |goto Ashenvale/0 70.00,71.15
|only if haveq(6504) or completedq(6504)
step
talk Kuray'bin##12867
accept Ashenvale Outrunners##6503 |goto Ashenvale 71.10,68.12
step
talk Senani Thunderheart##12696
turninany The Ashenvale Hunt##6382,235,742
accept The Ashenvale Hunt##6383 |goto Ashenvale/0 73.78,61.46 |instant
step
talk Mastok Wrilehiss##12737
accept Stonetalon Standstill##25 |goto Ashenvale/0 73.67,60.01
step
talk Qeeju##15131
Stable Your Pet |stablemaster Qeeju##15131 |goto Ashenvale/0 73.38,61.03 |q 6503
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 4){}.
|only if Hunter
step
talk Pixel##12724
accept Satyr Horns##6441 |goto Ashenvale/0 73.06,61.48
step
talk Vhulgra##12616
fpath Splintertree Post |goto Ashenvale/0 73.18,61.59
step
Learn the {y}Claw (Rank 4){} Pet Ability |learnspell Claw##3667 |goto Ashenvale/0 62.20,68.00 |q 6503
|tip Cast {o}Tame Beast{} on an {o}Elder Ashenvale Bear{}.
|tip Kill enemies nearby.
|mapmarker Ashenvale/0 59.00,61.60
|mapmarker Ashenvale/0 60.40,64.60
|mapmarker Ashenvale/0 62.20,61.40
|mapmarker Ashenvale/0 69.00,59.60
|mapmarker Ashenvale/0 64.20,57.00
|mapmarker Ashenvale/0 64.40,64.00
|mapmarker Ashenvale/0 65.40,60.00
|mapmarker Ashenvale/0 67.40,62.40
|only if Hunter
step
talk Qeeju##15131
Retrieve Your Pet |stablemaster Qeeju##15131 |goto Ashenvale/0 73.38,61.03 |q 6503
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 4){} to Your Pet |learnpetspell Claw##16830 |q 6503
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
kill 9 Ashenvale Outrunner##12856 |q 6503/1 |goto Ashenvale 72.80,70.20
|tip Stealthed night elves.
|tip Usually near trees.
|tip Cast {o}Track Hidden{} to find them easier. |only if Hunter
|tip Avoid {o}Sharptalon{}.
|tip {o}Level 31{} large blue bird.
|mapmarker Ashenvale/0 68.20,70.20
|mapmarker Ashenvale/0 68.20,73.20
|mapmarker Ashenvale/0 69.80,74.40
|mapmarker Ashenvale/0 69.80,76.00
|mapmarker Ashenvale/0 72.40,72.40
|mapmarker Ashenvale/0 73.40,74.40
|mapmarker Ashenvale/0 74.40,69.40
|mapmarker Ashenvale/0 74.40,72.40
|mapmarker Ashenvale/0 76.00,69.00
|mapmarker Ashenvale/0 76.00,73.00
|mapmarker Ashenvale/0 76.20,67.40
|mapmarker Ashenvale/0 72.22,76.28
|mapmarker Ashenvale/0 70.92,72.60
step
_NOTE:_
During the Next Steps
|tip Make sure {o}3 Splintertree Raiders{} are next to {o}Torek{}.
|tip Don't accept the quest unless there are.
|tip They help you fight during the escort.
Move to the Balcony
|tip You enter a building during the escort.
|tip {o}Move onto the balcony{} before more enemies appear.
|tip Let your allies get attacked by the enemies.
|tip Protect {o}Torek{}, he {o}must survive{}.
Click Here to Continue |confirm |q 6544 |future
step
talk Torek##12858
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept Torek's Assault##6544 |goto Ashenvale 68.34,75.30 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Torek.
|tip He must survive.
|tip {o}Move to the balcony{} inside the building.
|tip Let your allies get attacked by the enemies.
Take Silverwing Outpost |q 6544/1 |goto Ashenvale 64.66,75.34
step
_NOTE:_
During the Next Steps
|tip Kill enemies as you walk.
|tip Reduces grinding later.
Click Here to Continue |confirm |q 6441
step
Follow the path along the river and follow this path up |goto Ashenvale 72.33,49.92 < 30 |only if walking and not subzone("Night Run")
kill Felmusk Felsworn##3762, Felmusk Rogue##3759, Felmusk Satyr##3758, Felmusk Shadowstalker##3763
|tip Satyrs.
|tip Careful, stealthed enemies.
collect 16 Satyr Horns##5481 |q 6441/1 |goto Ashenvale/0 66.98,54.97
step
Kill enemies
|tip Careful, stealthed enemies.
ding 27 |goto Ashenvale/0 66.98,54.97
stickystart "Collect_Etched_Phial"
step
map Ashenvale
path follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	62.52,49.81	62.10,49.78	61.35,49.99	61.02,50.36	61.03,50.93
path	60.97,51.46	60.51,52.38	59.83,53.40	59.58,53.68	59.32,54.12
path	59.09,54.78	58.88,55.19	57.81,55.97	57.46,56.05	56.93,56.04
path	56.39,55.92	56.20,55.46	55.70,55.42	54.13,54.92	52.15,54.34
kill Shadumbra##12677
|tip Black panther.
|tip Walks a large pattern.
collect Shadumbra's Head##16304 |n
use Shadumbra's Head##16304
accept Shadumbra's Head##24
Spawns near [Ashenvale/0 62.35,50.04] |noway
|only if completedq(6383)
step
label "Collect_Etched_Phial"
kill Laughing Sister##4054+
collect Etched Phial##5867 |goto Ashenvale 59.20,54.40 |q 1195
|mapmarker Ashenvale/0 57.40,56.00
|mapmarker Ashenvale/0 58.40,58.20
|mapmarker Ashenvale/0 59.60,56.60
|mapmarker Ashenvale/0 60.40,52.40
|mapmarker Ashenvale/0 60.80,49.00
|mapmarker Ashenvale/0 62.60,50.20
stickystart "Kill_Thistlefur_Avengers_And_Shamans"
step
Follow the path north to Thistlefur Hold |goto Ashenvale 44.27,56.27 < 70 |only if walking and not (subzone("Thistlfur Village") or subzone("Thistlefur Hold"))
Follow the path up |goto Ashenvale 37.48,32.25 < 40 |only if walking and not subzone("Thistlefur Hold")
click Troll Chest+
|tip Brown wooden boxes.
|tip Mainly {o}top floor{} inside the cave.
collect 8 Troll Charm##16602 |q 6462/1 |goto Ashenvale 38.41,30.57
step
talk Ruul Snowhoof##12818
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip {o}Bottom floor{} inside the cave.
accept Freedom to Ruul##6482 |goto Ashenvale 41.49,34.50 |noautoaccept inparty
|tip {o}BEFORE{} accepting, kill enemies to {o}clear a path{} to the cave exit.
|tip Careful, groups of 3 enemies appear during the escort.
step
Escort Ruul from the Thistlefurs |q 6482/1 |goto Ashenvale 38.56,37.47
|tip Follow and protect Ruul Snowhoof.
step
label "Kill_Thistlefur_Avengers_And_Shamans"
kill 12 Thistlefur Avenger##3925 |q 216/1 |goto Ashenvale 39.60,36.40
kill 12 Thistlefur Shaman##3924 |q 216/2 |goto Ashenvale 39.60,36.40
|stickyif subzone("Thistlefur Village")
step
use Empty Blue Waterskin##7767
|tip Avoid Astranaar.
collect Filled Blue Waterskin##7770 |q 1534/1 |goto Ashenvale 33.55,67.44
|only if Shaman
step
map Ashenvale
path follow strict;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	42.69,63.22	43.09,63.07	43.24,63.76	43.71,63.87	43.25,63.81
path	43.13,63.09	42.70,63.17	42.55,63.96	42.25,64.80	41.87,65.35
path	40.85,66.35	40.23,66.26	39.77,65.43	39.66,63.82	39.80,62.90
path	39.65,63.77	39.77,65.41	41.40,66.60	41.47,67.53	41.77,68.25
path	42.05,68.75	42.43,68.43	42.93,68.43	43.32,68.07	43.78,68.87
path	43.36,68.13	42.46,68.38	42.05,68.75	41.73,68.15	41.47,67.49
path	41.40,66.52	40.22,66.23	39.77,65.45	39.68,64.37	39.64,63.81
path	39.83,62.80	39.66,63.78	39.78,65.45	40.20,66.23	40.54,65.96
path	41.57,65.66	42.19,64.90	42.53,64.04
kill Ursangous##12678
|tip Grey druid bear.
|tip Walks a large pattern.
|tip Avoid Astranaar.
collect Ursangous's Paw##16303 |n
use Ursangous's Paw##16303
accept Ursangous's Paw##23
Spawns at [Ashenvale/0 43.77,68.87] |noway
|only if completedq(6383)
stickystart "Collect_Befouled_Water_Globe"
stickystart "Kill_Befouled_Water_Elementals"
step
Scout the Gazebo on Mystral Lake that Overlooks the Nearby Alliance Outpost |q 25/2 |goto Ashenvale 48.92,69.57
step
label "Collect_Befouled_Water_Globe"
kill Tideress##12759
|tip Darker green water elemental.
|tip Moves around.
collect Befouled Water Globe##16408 |n
use Befouled Water Globe##16408
accept The Befouled Element##1918 |goto Ashenvale 48.40,69.40
|mapmarker Ashenvale/0 46.40,70.40
|mapmarker Ashenvale/0 50.40,71.60
|mapmarker Ashenvale/0 52.60,71.20
step
label "Kill_Befouled_Water_Elementals"
kill 12 Befouled Water Elemental##3917 |q 25/1 |goto Ashenvale/0 49.77,70.37
step
Kill enemies
|tip Helps reach level 28 after quest turnins.
|tip Avoid Silverwind Refuge.
ding 27,14950 |goto Ashenvale/0 52.40,62.80
|mapmarker Ashenvale/0 50.40,61.20
|mapmarker Ashenvale/0 53.40,60.80
|mapmarker Ashenvale/0 55.00,62.20
|mapmarker Ashenvale/0 57.60,64.00
step
use Etched Phial##5867
collect Filled Etched Phial##5868 |q 1195/1 |goto Ashenvale 60.20,72.90
step
Follow the path up and follow the road back to Splintertree Post |goto Ashenvale 59.51,68.25 < 30 |only if walking and (subzone("Moonwell") or subzone("Nightsong Woods"))
talk Kuray'bin##12867
turnin Ashenvale Outrunners##6503 |goto Ashenvale 71.11,68.12
step
talk Ertog Ragetusk##12877
turnin Torek's Assault##6544 |goto Ashenvale 73.03,62.47
step
talk Senani Thunderheart##12696
turnin Shadumbra's Head##24 |goto Ashenvale 73.78,61.46
turnin Ursangous's Paw##23 |goto Ashenvale 73.78,61.46
step
talk Yama Snowhoof##12837
|tip Inside the building.
turnin Freedom to Ruul##6482 |goto Ashenvale 74.11,60.92
step
talk Mastok Wrilehiss##12737
turnin Stonetalon Standstill##25 |goto Ashenvale 73.67,60.00
turnin The Befouled Element##1918 |goto Ashenvale 73.67,60.00
accept Je'neu of the Earthen Ring##824 |goto Ashenvale 73.67,60.00
step
talk Pixel##12724
turnin Satyr Horns##6441 |goto Ashenvale 73.06,61.48
step
talk Je'neu Sancrea##12736
|tip Inside the building.
turnin Je'neu of the Earthen Ring##824 |goto Ashenvale 11.56,34.29
step
talk Mitsuwa##12721
|tip Inside the building.
turnin Troll Charm##6462 |goto Ashenvale 11.65,34.85
step
talk Karang Amakkar##12757
turnin Between a Rock and a Thistlefur##216 |goto Ashenvale 11.90,34.54
step
talk Muglash##12717
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept Vorsha the Lasher##6641 |goto Ashenvale/0 12.06,34.63
step
Watch the dialogue
|tip Follow and protect Muglash.
click Naga Brazier
|tip Wait if unable to click.
|tip It relights.
Kill the enemies that attack in waves
kill Vorsha the Lasher##12940
Defeat Vorsha the Lasher |q 6641/1 |goto Ashenvale/0 9.63,27.66
step
talk Warsong Runner##12863
turnin Vorsha the Lasher##6641 |goto Ashenvale/0 12.22,34.21
step
Return to Splintertree Post |goto Ashenvale/0 73.24,61.54 < 30 |c |q 2 |future
step
map Ashenvale
path follow strict;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	71.49,70.11	72.04,70.46	72.56,70.62	73.41,70.57	74.38,70.07
path	75.07,70.01	75.94,69.80	76.09,69.00	76.85,68.13	77.57,66.41
path	77.89,65.98	78.32,65.65
path	77.89,65.98	77.57,66.41	76.85,68.13	76.09,69.00	75.94,69.80
path	75.07,70.01	74.38,70.07	73.41,70.57	72.56,70.62	72.04,70.46
kill Sharptalon##12676
|tip {o}Level 31{} large blue bird.
|tip Flies a large pattern.
collect Sharptalon's Claw##16305 |n
use Sharptalon's Claw##16305
accept Sharptalon's Claw##2
Spawns around [Ashenvale/0 78.00,66.0] |noway
|only if completedq(6383)
step
talk Senani Thunderheart##12696
turnin Sharptalon's Claw##2 |goto Ashenvale/0 73.78,61.46
accept The Hunt Completed##247 |goto Ashenvale/0 73.78,61.46 |instant
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1086
|only if Druid
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 1086
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 1086
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 1086
|only if Warlock
step
Enter the cave |goto Thunder Bluff 29.87,29.84 < 15 |walk |only if not subzone("The Pools of Vision")
talk Apothecary Zamah##3419
|tip Inside the cave.
turnin The Flying Machine Airport##1086 |goto Thunder Bluff 22.81,20.89
step
talk Malakai Cross##3045
|tip Inside the cave.
Train Abilities |trainer Malakai Cross##3045 |goto Thunder Bluff/0 24.55,22.58 |q 97538
|only if Priest
step
talk Archmage Shymm##3047
|tip Inside the cave.
Train Abilities |trainer Archmage Shymm##3047 |goto Thunder Bluff/0 22.76,14.52 |q 97538
|only if Mage
step
talk Alodan the Hopeful##246344
|tip Inside the cave.
Train Abilities |trainer Alodan the Hopeful##246344 |goto Thunder Bluff/0 25.20,14.41 |q 97538
|only if Paladin
step
Leave the cave |goto Thunder Bluff/0 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Siln Skychaser##3030
|tip Inside the building.
Train Abilities |trainer Siln Skychaser##3030 |goto Thunder Bluff/0 22.83,21.10 |q 97538
|only if Shaman
step
Leave the cave |goto Thunder Bluff/0 29.87,29.84 < 15 |walk |only if subzone("The Pools of Vision")
talk Tah Winterhoof##3024
turnin Pigments for Paints##97538 |goto Thunder Bluff/0 54.14,47.00
step
talk Zangen Stonehoof##4721
turnin The Sacred Flame##1195 |goto Thunder Bluff/0 54.97,51.41
accept The Sacred Flame##1196 |goto Thunder Bluff/0 54.97,51.41
step
talk Melor Stonehoof##3441
accept Steelsnap##1131 |goto Thunder Bluff/0 61.54,80.92
step
talk Urek Thunderhorn##3040
|tip Inside the building.
Train Abilities |trainer Urek Thunderhorn##3040 |goto Thunder Bluff/0 59.11,86.86 |q 5881
|only if Hunter
step
talk Ker Ragetotem##3043
|tip Inside the building.
Train Abilities |trainer Ker Ragetotem##3043 |goto Thunder Bluff/0 57.58,85.52 |q 5881
|only if Warrior
step
talk Innkeeper Pala##6746
|tip Inside the building.
home Thunder Bluff |goto Thunder Bluff 45.81,64.71
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Thousand Needles (28-30)",{
image=ZGV.IMAGESDIR.."Thousand Needles",
hardcore = true,
next="Leveling Guides\\Hillsbrad Foothills (30-32)",
},[[
step
talk Grunt Logmar##5911
accept Wrongly Blamed, Justly Corrected##97250 |goto The Barrens/0 44.62,59.27
step
talk Tatternack Steelforge##3433
accept A New Ore Sample##1153 |goto The Barrens 45.10,57.68
step
talk Brine##5899
|tip Top of the hill.
turnin Call of Water##1534 |goto The Barrens 43.42,77.41
accept Call of Water##220 |goto The Barrens 43.42,77.41
|only if Shaman
stickystart "Kill_Encroaching_Soldiers"
step
kill Outraged Pillager##268623 |q 97250/2 |goto The Barrens/0 49.11,76.98
|tip {o}Level 23 elite{} enemy.
|tip Skip if too difficult.
step
label "Kill_Encroaching_Soldiers"
kill 2 Encroaching Soldier##268622 |q 97250/1 |goto The Barrens/0 49.11,76.98
step
talk Grish Longrunner##12576
|tip Wait until he respawns, if missing.
turnin Calling in the Reserves##5881 |goto Thousand Needles 31.86,21.66
step
talk Brave Moonhorn##10079
|tip Wait until he respawns, if missing.
accept Message to Freewind Post##4542 |goto Thousand Needles 32.24,22.17
step
Ride an elevator down into Thousand Needles, follow the road to Freewind Post, and ride an elevator up |goto Thousand Needles 47.02,48.32 < 50 |only if walking
talk Nyse##4317
fpath Freewind Post |goto Thousand Needles 45.14,49.11
step
talk Elu##10377
|tip Walks around.
accept Wind Rider##4767 |goto Thousand Needles 44.93,48.93
step
talk Hagar Lightninghoof##10539
accept Alien Egg##4821 |goto Thousand Needles 44.64,50.29
step
talk Cliffwatcher Longhorn##10537
|tip Walks around.
turnin Message to Freewind Post##4542 |goto Thousand Needles 45.65,50.80
accept Pacify the Centaur##4841 |goto Thousand Needles 45.65,50.80
step
talk Rau Cliffrunner##4722
|tip Inside the building.
turnin The Sacred Flame##1196 |goto Thousand Needles 46.14,51.72
accept The Sacred Flame##1197 |goto Thousand Needles 46.14,51.72
stickystart "Kill_Galak_Enemies"
step
Enter the cave |goto Thousand Needles 44.05,37.34 < 20 |walk |only if not subzone("Splithoof Hold")
Follow the path |goto Thousand Needles 42.06,34.68 < 10 |walk
click Ancient Brazier
|tip Two {o}level 30{} enemies guarding it.
|tip Inside the cave.
collect Cloven Hoof##5869 |q 1197/1 |goto Thousand Needles 42.01,31.51
step
label "Kill_Galak_Enemies"
Leave the cave |goto Thousand Needles 44.05,37.34 < 20 |only if walking and subzone("Splithoof Hold")
kill 6 Galak Windchaser##4096 |q 4841/3 |goto Thousand Needles/0 43.13,38.52
kill 10 Galak Wrangler##4093 |q 4841/2 |goto Thousand Needles/0 43.13,38.52
kill 12 Galak Scout##4094 |q 4841/1 |goto Thousand Needles/0 43.13,38.52
stickystart "Collect_Unrefined_Ore_Sample"
step
Leave the cave |goto Thousand Needles 44.05,37.34 < 20 |only if walking and subzone("Splithoof Hold")
Follow the path up |goto Thousand Needles 54.68,44.78 < 20 |only if walking
talk Dorn Plainstalker##2986
|tip Inside the small cave.
accept Test of Faith##1149 |goto Thousand Needles 53.94,41.48
stickystop "Collect_Unrefined_Ore_Sample"
step
Watch the dialogue
Teleport to the Plateau |goto Thousand Needles 26.43,31.29 < 30 |noway |c |q 1149
step
Return to Dorn Plainstalker |complete subzone("The Weathered Nook") |goto Thousand Needles 26.43,32.41 |q 1149
|tip Jump off the cliff.
|tip You won't die.
step
talk Dorn Plainstalker##2986
|tip Inside the small cave.
turnin Test of Faith##1149 |goto Thousand Needles 53.94,41.48
stickystart "Collect_Unrefined_Ore_Sample"
step
click Alien Egg
|tip Large white egg.
|tip Multiple locations.
collect Alien Egg##12467 |q 4821/1 |goto Thousand Needles/0 56.35,50.36
|mapmarker Thousand Needles/0 52.33,55.21
step
label "Collect_Unrefined_Ore_Sample"
kill Gravelsnout Surveyor##4116, Gravelsnout Digger##4113
|tip {o}Diggers{} and {o}Surveyors{}.
|tip Kobolds.
|tip Uncommon and spread out.
|tip Kill other enemies while searching.
|tip Reduces grinding later.
collect Unrefined Ore Sample##5842 |q 1153/1 |goto Thousand Needles/0 65.03,54.47
|tip Quest can be slow and annoying.
|tip Skip if you'd rather just grind.
step
Kill enemies
|tip Helps reach level 29 after quest turnins.
|tip Higher level enemies soon.
ding 28,34950 |goto Thousand Needles 44.40,40.20
|mapmarker Thousand Needles/0 39.00,32.20
|mapmarker Thousand Needles/0 39.00,37.60
|mapmarker Thousand Needles/0 41.00,41.20
|mapmarker Thousand Needles/0 42.00,38.00
|mapmarker Thousand Needles/0 43.40,35.20
|mapmarker Thousand Needles/0 45.40,44.00
|mapmarker Thousand Needles/0 47.60,41.00
step
Abandon the {y}A New Ore Sample{} Quest |complete not haveq(1153)
|tip Not needed.
|only if haveq(1153) and not readyq(1153)
step
Ride an elevator up |goto Thousand Needles 47.02,48.32 < 50 |only if walking
talk Hagar Lightninghoof##10539
turnin Alien Egg##4821 |goto Thousand Needles 44.64,50.29
accept Serpent Wild##4865 |goto Thousand Needles 44.64,50.29
step
talk Cliffwatcher Longhorn##10537
|tip Walks around.
turnin Pacify the Centaur##4841 |goto Thousand Needles 45.65,50.80
step
talk Rau Cliffrunner##4722
|tip Inside the building.
turnin The Sacred Flame##1197 |goto Thousand Needles 46.14,51.71
step
talk Jandia##4877
|tip Inside the building.
accept Stolen Freewind Supplies##98069 |goto Thousand Needles/0 46.21,51.50
accept Stop the Screeching##98070 |goto Thousand Needles/0 46.21,51.50
stickystart "Collect_Stolen_Freewind_Supplies"
stickystart "Kill_Screeching_Harpies_And_Roguefeathers"
step
kill 5 Screeching Windcaller##4104 |q 98070/3 |goto Thousand Needles/0 27.24,51.43
|tip Inside the cave.
step
label "Collect_Stolen_Freewind_Supplies"
click Stolen Freewind Supplies+
|tip Tan sacks.
|tip Inside and outside the cave. |notinsticky
collect 8 Stolen Freewind Supplies##279383 |q 98069/1 |goto Thousand Needles/0 27.24,51.43
step
label "Kill_Screeching_Harpies_And_Roguefeathers"
kill 5 Screeching Harpy##4100 |q 98070/1 |goto Thousand Needles/0 27.24,51.43
kill 5 Screeching Roguefeather##4101 |q 98070/2 |goto Thousand Needles/0 27.24,51.43
|tip Inside and outside the cave. |notinsticky
step
Leave the cave |goto Thousand Needles/0 27.24,51.43 < 15 |walk |only if subzone("Roguefeather Den") and indoors()
Follow the path up |goto Thousand Needles 14.75,32.83 < 20 |only if walking and not subzone("Highperch")
click Highperch Wyvern Egg+
|tip Large eggs.
collect 10 Highperch Wyvern Egg##12356 |q 4767/1 |goto Thousand Needles/0 11.10,35.60
step
Follow the path up |goto Thousand Needles 13.17,39.51 < 20 |only if walking
talk Pao'ka Swiftmountain##10427
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Avoid {o}Heartrazor{}.
|tip {o}Level 32 elite{} wyvern.
|tip Skip if he's nearby.
accept Homeward Bound##4770 |goto Thousand Needles 17.89,40.57 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect {o}Pao'ka Swiftmountain{}.
|tip Clear the path of enemies, as much as possible.
|tip Group of {o}3 wyverns{} ambush you in the wide open area.
|tip Attack the one {o}nearest the Highperch exit{}.
|tip Ignore the others, they should disappear.
Escort Pao'ka Swiftmountain to Safety |q 4770/1 |goto Thousand Needles 15.16,32.67
stickystart "Accept_Assassination_Plot"
step
map Thousand Needles
path	follow strict;		loop on;	ants curved;	dist 30;	markers none;		arrow hide
path	18.21,26.63		17.18,29.62		14.66,30.75		11.08,22.60
path	13.29,19.81		14.83,19.58		17.19,18.92		18.71,24.78
kill Steelsnap##4548
|tip Brown hyena with 2 hyena guards.
|tip Walks a large path.
collect Steelsnap's Rib##5837 |q 1131/1
Spawns at [Thousand Needles/0 17.32,22.20] |noway
step
talk Motega Firemane##10428
|tip Walks around.
turnin Homeward Bound##4770 |goto Thousand Needles 21.55,32.35 |only if haveq(4770) or completedq(4770)
turnin Serpent Wild##4865 |goto Thousand Needles 21.55,32.35
accept Sacred Fire##5062 |goto Thousand Needles 21.55,32.35
step
label "Accept_Assassination_Plot"
map Thousand Needles
path follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	18.31,22.24	18.58,25.92	20.01,27.62	21.87,30.19	23.27,31.50
path	25.29,34.22	26.34,34.21	29.31,34.01	31.42,30.78	32.92,30.73
path	35.08,28.16	36.95,29.43	38.71,31.64	39.36,33.09
kill Galak Messenger##10617
|tip Black centaur.
|tip Runs a large path.
|tip Skip if don't want to search. |notinsticky
|tip Can wait for him to come to you. |notinsticky
collect Assassination Note##12564 |n
use Assassination Note##12564
accept Assassination Plot##4881
Spawns at [Thousand Needles/0 39.60,32.80] |noway
step
kill Galak Messenger##10617
|tip Black centaur.
|tip Runs a large path.
|tip Passes here twice in his route.
|tip Wait for him.
collect Assassination Note##12564 |n
use Assassination Note##12564
accept Assassination Plot##4881 |goto Thousand Needles 31.50,29.96
Spawns at [Thousand Needles/0 39.60,32.80] |noway
step
talk Kanati Greycloud##10638
turnin Assassination Plot##4881 |goto Thousand Needles/0 21.21,32.10
accept Protect Kanati Greycloud##4966 |goto Thousand Needles/0 21.21,32.10
|tip Three enemies attack.
step
Kill the enemies that attack
Protect Kanati Greycloud |q 4966/1 |goto Thousand Needles/0 21.21,32.10
step
talk Kanati Greycloud##10638
turnin Protect Kanati Greycloud##4966 |goto Thousand Needles/0 21.21,32.10
step
click Incendia Agave+
|tip Spikey plants.
|tip Underwater and around the water edge.
collect 10 Incendia Agave##12732 |q 5062/1 |goto Thousand Needles/0 33.60,34.10
|mapmarker Thousand Needles/0 35.00,33.30
|mapmarker Thousand Needles/0 35.70,36.20
|mapmarker Thousand Needles/0 37.80,38.10
step
talk Melor Stonehoof##3441
turnin Steelsnap##1131 |goto Thunder Bluff 61.53,80.90
accept Frostmaw##1136 |goto Thunder Bluff 61.53,80.90
step
talk Magatha Grimtotem##4046
|tip Inside the tent.
turnin Sacred Fire##5062 |goto Thunder Bluff 69.86,30.92
accept Arikara##5088 |goto Thunder Bluff 69.86,30.92
step
talk Chesmu##8356
|tip Deposit into the bank.
|tip Inside the building.
bank Kodo Skin Scroll##5838 |goto Thunder Bluff 47.13,57.89 |q 1136
step
talk Tatternack Steelforge##3433
turnin A New Ore Sample##1153 |goto The Barrens 45.10,57.68
|only if haveq(1153)
step
talk Elu##10377
|tip Walks around.
turnin Wind Rider##4767 |goto Thousand Needles 44.93,48.93
step
talk Cliffwatcher Longhorn##10537
|tip Walks around.
accept Grimtotem Spying##5064 |goto Thousand Needles 45.65,50.80
step
click Wanted Poster - Arnak Grimtotem
accept Wanted - Arnak Grimtotem##5147 |goto Thousand Needles 46.00,50.84
step
talk Jandia##4877
|tip Inside the building.
turnin Stolen Freewind Supplies##98069 |goto Thousand Needles/0 46.21,51.50
turnin Stop the Screeching##98070 |goto Thousand Needles/0 46.21,51.50
step
Kill enemies
|tip Difficult quests soon.
|tip Reduces grinding all at once later.
ding 30 |goto Thousand Needles 44.40,40.20
|mapmarker Thousand Needles/0 39.00,32.20
|mapmarker Thousand Needles/0 39.00,37.60
|mapmarker Thousand Needles/0 41.00,41.20
|mapmarker Thousand Needles/0 42.00,38.00
|mapmarker Thousand Needles/0 43.40,35.20
|mapmarker Thousand Needles/0 45.40,44.00
|mapmarker Thousand Needles/0 47.60,41.00
step
Follow the path up and across the hanging bridges |goto Thousand Needles 31.24,36.88 < 20 |only if walking
Cross the hanging bridge |goto Thousand Needles 34.99,31.50 < 15 |only if walking
click Document Chest
|tip Up on the plateau.
|tip Inside the building.
collect Secret Note #3##12768 |q 5064/3 |goto Thousand Needles 39.32,41.52
step
click Document Chest
|tip Up on the plateau.
|tip Inside the building.
collect Secret Note #2##12766 |q 5064/2 |goto Thousand Needles 33.78,39.97
step
click Document Chest
|tip Up on the plateau.
collect Secret Note #1##12765 |q 5064/1 |goto Thousand Needles 31.80,32.59
step
Cross the hanging bridge |goto Thousand Needles/0 35.68,31.00 < 15 |only if walking
click Sacred Fire of Life
|tip Up on the plateau.
|tip You will be attacked.
|tip {o}Level 28 elite{} enemy.
|tip Pretty easy to kill solo.
|tip May need help.
Light the Sacred Fire of Life |q 5088/2 |goto Thousand Needles/0 38.02,35.32
step
kill Arikara##10882
|tip {o}Level 28 elite{} enemy.
|tip Pretty easy to kill solo.
|tip May need help.
|tip Skip if too difficult.
|tip Up on the plateau.
collect Arikara Serpent Skin##12925 |q 5088/1 |goto Thousand Needles/0 38.29,35.54
step
kill Arnak Grimtotem##10896
|tip Up on the plateau.
|tip Walks around.
collect Arnak's Hoof##12884 |q 5147/1 |goto Thousand Needles/0 38.08,26.85
step
talk Lakota Windsong##10646
|tip Escort quest.
|tip Wait until she respawns, if missing.
accept Free at Last##4904 |goto Thousand Needles/0 37.99,26.59 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Lakota Windsong.
|tip Kill enemies to clear a path for her.
|tip {o}Two enemies{} appear on each plateau.
|tip Skip if too difficult.
Escort Lakota Windsong from the Darkcloud Pinnacle |q 4904/1 |goto Thousand Needles/0 30.97,37.09
step
talk Motega Firemane##10428
|tip Walks around.
turnin Arikara##5088 |goto Thousand Needles/0 21.55,32.35
step
talk Wizlo Bearingshiner##10941
accept Hypercapacitor Gizmo##5151 |goto Thousand Needles/0 21.43,32.55
step
click Panther Cage
kill Enraged Panther##10992
|tip {o}Level 30 elite{} enemy.
|tip May need help.
|tip Skip if too difficult.
collect Hypercapacitor Gizmo##12946 |q 5151/1 |goto Thousand Needles/0 22.79,24.54
step
talk Wizlo Bearingshiner##10941
turnin Hypercapacitor Gizmo##5151 |goto Thousand Needles/0 21.43,32.55
|only if haveq(5151) or completedq(5151)
step
Abandon the {y}Hypercapacitor Gizmo{} Quest |complete not haveq(5151)
|tip Not needed.
|only if haveq(5151) and not completedq(5151)
step
Follow the road up into Feralas |goto Thousand Needles/0 7.68,10.62 < 40 |only if walking and zone("Thousand Needles")
talk Shyn##8020
|tip Careful, higher level enemies.
|tip If you die, resurrect at Camp Mojache.
fpath Camp Mojache |goto Feralas 75.45,44.36
|only if not hardcore()
step
talk Cliffwatcher Longhorn##10537
|tip Walks around.
turnin Grimtotem Spying##5064 |goto Thousand Needles 45.65,50.80
turnin Wanted - Arnak Grimtotem##5147 |goto Thousand Needles 45.65,50.80
step
talk Innkeeper Abeqwa##11116
|tip Inside the building.
home Freewind Post |goto Thousand Needles 46.07,51.51 |q 5361 |future
step
talk Thalia Amberhide##10645
|tip Inside the building.
turnin Free at Last##4904 |goto Thousand Needles 45.97,51.61
step
talk Kravel Koalbeard##4452
accept Wharfmaster Dizzywig##1111 |goto Thousand Needles 77.79,77.27
step
talk Bulkrek Ragefist##7824
|tip Careful, higher level enemies.
fpath Gadgetzan |goto Tanaris 51.60,25.44
step
talk Ker Ragetotem##3043
|tip Inside the building.
Train Abilities |trainer Ker Ragetotem##3043 |goto Thunder Bluff/0 57.58,85.52 |q 1111
|only if Warrior
step
talk Torm Ragetotem##3041
|tip Inside the building.
accept The Islander##1718 |goto Thunder Bluff/0 57.24,87.37
|only if Warrior
step
Enter the cave |goto Thunder Bluff 29.81,29.82 < 15 |walk |only if not subzone("The Pools of Vision")
talk Thurston Xane##3049
|tip Inside the cave.
Train Abilities |trainer Thurston Xane##3049 |goto Thunder Bluff/0 25.18,20.96
|only if Mage
step
talk Birgitte Cranston##5957
|tip Inside the cave.
learnspell Teleport: Thunder Bluff##3566 |goto Thunder Bluff 22.50,16.91
|only if Mage
step
Leave the cave |goto Thunder Bluff 29.81,29.82 < 15 |walk |only if subzone("The Pools of Vision")
talk Korran##3428
accept The Swarm Grows##1145 |goto The Barrens 51.07,29.63
step
talk Wharfmaster Dizzywig##3453
turnin Wharfmaster Dizzywig##1111 |goto The Barrens 63.35,38.45
accept Parts for Kravel##1112 |goto The Barrens 63.35,38.45
step
talk Islen Waterseer##5901
turnin Call of Water##220 |goto The Barrens 65.83,43.78
accept Call of Water##63 |goto The Barrens 65.83,43.78
|only if Shaman
step
talk Islen Waterseer##5901
|tip Complete the {o}Water Sapta{} quest.
collect Water Sapta##6637 |goto The Barrens 65.83,43.78 |q 63
|only if Shaman
step
talk Klannoc Macleod##6236
turnin The Islander##1718 |goto The Barrens 68.62,49.17
accept The Affray##1719 |goto The Barrens 68.62,49.17
|only if Warrior
step
kill Affray Challenger##6240+
|tip Step on the grate to start the fight.
kill Big Will##6238 |q 1719/1 |goto The Barrens 68.61,48.72
|tip Appears after killing {o}six challengers{}.
|only if Warrior
step
talk Klannoc Macleod##6236
turnin The Affray##1719 |goto The Barrens 68.62,49.17
accept The Windwatcher##1791 |goto The Barrens 68.62,49.17
|only if Warrior
step
talk Zikkel##8119
|tip Deposit into the bank.
bank Kravel's Parts##5800 |goto The Barrens/0 62.68,37.42 |q 1112
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 1145
|only if Rogue
step
talk Craven Drok##5639
|tip Walks around.
|tip Inside the Cleft of Shadow.
accept Alliance Relations##1431 |goto Orgrimmar 46.76,50.43
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 1145
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 1145
|only if Warlock
step
talk Searn Firewarder##5892
|tip Inside the building.
accept Call of Air##1531 |goto Orgrimmar 37.96,37.73
|only if Shaman
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 1145
|only if Shaman
step
talk Belgrom Rockmaul##4485
turnin The Swarm Grows##1145 |goto Orgrimmar 75.23,34.23
accept The Swarm Grows##1146 |goto Orgrimmar 75.23,34.23
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 1431
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 1431
|only if Hunter
step
talk Hanashi##2704
|tip Inside the building.
Train Two-Handed Axes |complete weaponskill("TH_AXE") > 0 |goto Orgrimmar/0 81.53,19.61
|only if Hunter
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 1431
|only if Priest
step
talk Keldran##5640
|tip Walks around.
|tip Inside the building.
turnin Alliance Relations##1431 |goto Orgrimmar 22.56,52.63
accept Alliance Relations##1432 |goto Orgrimmar 22.56,52.63
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Hillsbrad Foothills (30-32)",{
image=ZGV.IMAGESDIR.."Hillsbrad Foothills",
hardcore = true,
next="Leveling Guides\\Arathi Highlands (32-33)",
},[[
step
talk William Montague##4549
|tip Deposit into the bank.
bank Belgrom's Sealed Note##5850 |goto Undercity 65.97,44.75 |q 1146
step
talk William Montague##4549
|tip Collect from the bank.
collect Shipment of Iron##3564 |goto Undercity 65.97,44.75 |q 529
collect Hillsbrad Human Skull##3692+ |goto Undercity 65.97,44.75 |q 546
step
talk Eunice Burch##4552
Learn Cooking |skillmax Cooking,75 |goto Undercity 62.14,44.91 |q 7321 |future
|tip Needed to accept a quest soon.
step
talk Archibald##11870
Train Crossbows |complete weaponskill("CROSSBOW") > 0 |goto Undercity 57.31,32.77
Train Two-Handed Swords |complete weaponskill("TH_SWORD") > 0 |goto Undercity 57.31,32.77
|only if Hunter
step
talk Genavie Callow##4486
accept To Steal From Thieves##1164 |goto Undercity 63.83,49.45
step
Jump up and follow the path behind the tree |goto Silverpine Forest 42.03,40.66 < 7 |only if walking
use Water Sapta##6637
kill Corrupt Water Spirit##5897+
collect Corrupt Manifestation's Bracers##7812 |q 63/1 |goto Silverpine Forest 38.28,44.56
|only if Shaman
step
click Brazier of Everfount
turnin Call of Water##63 |goto Silverpine Forest 38.28,44.56
accept Call of Water##100 |goto Silverpine Forest 38.28,44.56
|only if Shaman
step
Watch the dialogue
talk Minor Manifestation of Water##5895
turnin Call of Water##100 |goto Silverpine Forest 38.75,44.62
accept Call of Water##96 |goto Silverpine Forest 38.75,44.62
|only if Shaman
step
talk Apothecary Lydon##2216
|tip Inside the building.
accept Elixir of Agony##509 |goto Hillsbrad Foothills 61.44,19.06
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin Battle of Hillsbrad##529 |goto Hillsbrad Foothills 62.33,20.45
accept Battle of Hillsbrad##532 |goto Hillsbrad Foothills 62.33,20.45
step
talk Christoph Jeffcoat##2393
|tip Inside the building.
accept Soothing Turtle Bisque##7321 |goto Hillsbrad Foothills 62.29,19.04
|only if skill("Cooking") > 0
step
talk Krusk##2229
|tip Inside the building.
accept Infiltration##533 |goto Hillsbrad Foothills 63.24,20.65
step
talk Novice Thaivand##2429
accept Helcular's Revenge##552 |goto Hillsbrad Foothills 63.88,19.66
stickystart "Collect_Turtle_Meat"
step
talk Bath'rah the Windwatcher##6176
|tip Inside the building.
|tip Follow the river north to travel to this location.
turnin The Windwatcher##1791 |goto Alterac Mountains 80.50,66.92
accept Cyclonian##1712 |goto Alterac Mountains 80.50,66.92
|only if Warrior
step
label "Collect_Turtle_Meat"
kill Snapjaw##2408+
|tip Turtles.
|tip Avoid Southshore.
collect 10 Turtle Meat##3712 |q 7321/1 |goto Hillsbrad Foothills 67.80,21.20
|tip Don't vendor them.
|mapmarker Hillsbrad Foothills/0 55.20,54.00
|mapmarker Hillsbrad Foothills/0 55.20,57.00
|mapmarker Hillsbrad Foothills/0 57.40,48.00
|mapmarker Hillsbrad Foothills/0 59.60,45.20
|mapmarker Hillsbrad Foothills/0 63.80,40.60
|mapmarker Hillsbrad Foothills/0 67.20,31.40
|mapmarker Hillsbrad Foothills/0 67.60,35.40
|mapmarker Hillsbrad Foothills/0 67.80,17.80
|mapmarker Hillsbrad Foothills/0 68.40,14.80
|mapmarker Hillsbrad Foothills/0 68.60,28.20
|mapmarker Hillsbrad Foothills/0 70.00,12.00
|mapmarker Hillsbrad Foothills/0 71.40,8.60
|mapmarker Alterac Mountains/0 74.40,65.00
|mapmarker Alterac Mountains/0 77.00,62.40
|mapmarker Alterac Mountains/0 79.20,58.60
|mapmarker Alterac Mountains/0 81.00,54.80
|mapmarker Alterac Mountains/0 84.40,50.80
|mapmarker Alterac Mountains/0 88.00,47.40
step
talk Christoph Jeffcoat##2393
|tip Inside the building.
buy Soothing Spices##3713 |q 7321/2 |goto Hillsbrad Foothills/0 62.29,19.02
step
talk Christoph Jeffcoat##2393
|tip Inside the building.
turnin Soothing Turtle Bisque##7321 |goto Hillsbrad Foothills/0 62.29,19.04
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
accept Prison Break In##544 |goto Hillsbrad Foothills/0 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
accept Stone Tokens##556 |goto Hillsbrad Foothills/0 61.50,20.93
step
kill Cave Yeti##2248, Ferocious Yeti##2249
|tip Inside and outside the cave.
collect Helcular's Rod##3708 |q 552/1 |goto Hillsbrad Foothills 46.18,31.83
|mapmarker Hillsbrad Foothills/0 41.80,32.00
|mapmarker Hillsbrad Foothills/0 42.80,33.60
|mapmarker Hillsbrad Foothills/0 43.40,25.40
|mapmarker Hillsbrad Foothills/0 43.40,27.40
|mapmarker Hillsbrad Foothills/0 43.40,29.40
|mapmarker Hillsbrad Foothills/0 44.20,31.20
|mapmarker Hillsbrad Foothills/0 45.00,26.40
|mapmarker Hillsbrad Foothills/0 45.00,28.60
|mapmarker Hillsbrad Foothills/0 45.40,33.40
|mapmarker Hillsbrad Foothills/0 46.20,31.80
|mapmarker Hillsbrad Foothills/0 47.60,30.40
step
Kill enemies
|tip Difficult quest soon.
|tip Higher level enemies.
|tip Inside and outside the cave.
ding 31 |goto Hillsbrad Foothills 46.18,31.83
|mapmarker Hillsbrad Foothills/0 41.80,32.00
|mapmarker Hillsbrad Foothills/0 42.80,33.60
|mapmarker Hillsbrad Foothills/0 43.40,25.40
|mapmarker Hillsbrad Foothills/0 43.40,27.40
|mapmarker Hillsbrad Foothills/0 43.40,29.40
|mapmarker Hillsbrad Foothills/0 44.20,31.20
|mapmarker Hillsbrad Foothills/0 45.00,26.40
|mapmarker Hillsbrad Foothills/0 45.00,28.60
|mapmarker Hillsbrad Foothills/0 45.40,33.40
|mapmarker Hillsbrad Foothills/0 46.20,31.80
|mapmarker Hillsbrad Foothills/0 47.60,30.40
stickystart "Kill_Hillsbrad_Councilmen"
stickystart "Collect_Hillsbrad_Human_Skulls"
step
Leave the cave |goto Hillsbrad Foothills 46.18,31.83 < 20 |walk |only if subzone("Darrow Hill") and indoors()
kill Clerk Horrace Whitesteed##2448 |q 567/1 |goto Hillsbrad Foothills/0 29.81,42.42
|tip Try to pull enemies individually.
|tip Avoid having to fight them all at once.
|tip Inside the building.
step
kill Magistrate Burnside##2335 |q 532/1 |goto Hillsbrad Foothills/0 29.67,41.64
|tip Inside the building.
step
click Hillsbrad Proclamation
|tip Inside the building.
Destroy the Hillsbrad Proclamation |q 532/3 |goto Hillsbrad Foothills/0 29.73,41.75
step
click Hillsbrad Town Registry
|tip Inside the building.
collect Hillsbrad Town Registry##3657 |q 532/4 |goto Hillsbrad Foothills/0 29.52,41.53
step
label "Kill_Hillsbrad_Councilmen"
kill 4 Hillsbrad Councilman##2387 |q 532/2 |goto Hillsbrad Foothills/0 30.20,42.20
|tip Inside and outside the building. |notinsticky
|mapmarker Hillsbrad Foothills/0 29.40,40.20
|mapmarker Hillsbrad Foothills/0 32.80,45.60
stickystop "Collect_Hillsbrad_Human_Skulls"
step
talk High Executor Darthalia##2215
turnin Battle of Hillsbrad##532 |goto Hillsbrad Foothills/0 62.33,20.45
accept Battle of Hillsbrad##539 |goto Hillsbrad Foothills/0 62.33,20.45
step
talk Novice Thaivand##2429
turnin Helcular's Revenge##552 |goto Hillsbrad Foothills/0 63.88,19.66
accept Helcular's Revenge##553 |goto Hillsbrad Foothills/0 63.88,19.66 |only if not hardcore()
step
Enter the cave |goto Hillsbrad Foothills/0 46.21,31.86 < 20 |walk |only if not (subzone("Darrow Hill") and indoors())
Run down the ramp and follow the path |goto Hillsbrad Foothills/0 45.00,28.07 < 10 |walk
click Flame of Veraz
|tip Downstairs inside the cave.
Charge the Flame of Veraz |q 553/2 |goto Hillsbrad Foothills/0 44.04,26.56
|only if not hardcore()
step
Follow the path up to the top floor of the cave |goto Hillsbrad Foothills/0 44.11,28.54 < 15 |walk
click Flame of Azel
|tip Upstairs inside the cave.
Charge the Flame of Azel |q 553/1 |goto Hillsbrad Foothills/0 43.90,28.05
|only if not hardcore()
stickystart "Kill_Hillsbrad_Miners"
stickystart "Collect_Hillsbrad_Human_Skulls"
step
Leave the cave |goto Hillsbrad Foothills/0 46.27,31.94 < 20 |walk |only if subzone("Darrow Hill") and indoors()
Enter the mine |goto Hillsbrad Foothills/0 26.51,58.61 < 15 |walk |only if not (subzone("Azurelode Mine") and indoors())
kill Foreman Bonds##2305 |q 539/1 |goto Hillsbrad Foothills/0 31.21,56.01
|tip Summons {o}two guards{} at low health.
|tip Inside the mine.
step
kill Miner Hackett##2450 |q 567/3 |goto Hillsbrad Foothills/0 31.12,58.62
|tip Multiple locations.
|tip Inside the mine.
|mapmarker Hillsbrad Foothills/0 29.40,53.60
|mapmarker Hillsbrad Foothills/0 29.40,56.20
|mapmarker Hillsbrad Foothills/0 30.80,55.40
|mapmarker Hillsbrad Foothills/0 31.60,52.80
step
label "Kill_Hillsbrad_Miners"
kill 10 Hillsbrad Miner##2269 |q 539/2 |goto Hillsbrad Foothills/0 29.80,54.60
|tip Inside the mine. |notinsticky
|mapmarker Hillsbrad Foothills/0 26.40,58.60
|mapmarker Hillsbrad Foothills/0 28.00,53.20
|mapmarker Hillsbrad Foothills/0 28.00,56.20
|mapmarker Hillsbrad Foothills/0 30.20,56.80
|mapmarker Hillsbrad Foothills/0 31.60,52.80
|mapmarker Hillsbrad Foothills/0 32.00,55.20
step
label "Collect_Hillsbrad_Human_Skulls"
kill Hillsbrad Peasant##2267, Hillsbrad Tailor##2264, Hillsbrad Footman##2268, Hillsbrad Apprentice Blacksmith##2265, Blacksmith Verringtan##2404, Hillsbrad Councilman##2387, Magistrate Burnside##2335, Citizen Wilkes##2449, Clerk Horrace Whitesteed##2448, Farmer Kalaba##2451, Hillsbrad Farmhand##2360, Hillsbrad Farmer##2266, Hillsbrad Sentry##2270, Hillsbrad Foreman##2503, Miner Hackett##2450, Syndicate Watchman##2261, Hillsbrad Miner##2269, Foreman Bonds##2305, Farmer Getz##2403, Farmer Ray##232
|tip Humans.
|tip Inside the mine. |notinsticky
collect 30 Hillsbrad Human Skull##3692 |q 546/1 |goto Hillsbrad Foothills/0 29.80,54.60
|mapmarker Hillsbrad Foothills/0 26.40,58.60
|mapmarker Hillsbrad Foothills/0 28.00,53.20
|mapmarker Hillsbrad Foothills/0 28.00,56.20
|mapmarker Hillsbrad Foothills/0 30.20,56.80
|mapmarker Hillsbrad Foothills/0 31.60,52.80
|mapmarker Hillsbrad Foothills/0 32.00,55.20
step
Leave Azurelode Mine |condition not (subzone("Azurelode Mine") and indoors()) |q 567
|tip Multiple exits.
|tip Use whichever you find first.
stickystart "Collect_Worn_Stone_Tokens"
step
kill Ricter##2411
|tip Walks around.
collect Bloodstone Marble##3689 |q 544/2 |goto Alterac Mountains 20.20,84.08
step
kill Alina##2412
|tip Walks around.
|tip Inside the building.
collect Bloodstone Shard##3690 |q 544/3 |goto Alterac Mountains 20.35,86.35
step
kill Dermot##2413
|tip Walks around.
|tip Inside the building.
collect Bloodstone Wedge##3691 |q 544/1 |goto Alterac Mountains 20.01,86.13
step
kill Kegan Darkmar##2414
|tip Guarded by {o}Warden Belamoore{}.
|tip {o}Level 36{} mage.
|tip Kill Kegan while using {o}doorways and stairs{} to line-of-sight her.
|tip Prevents her from casting spells and hurting you.
|tip Upstairs inside the building.
collect Bloodstone Oval##3688 |q 544/4 |goto Alterac Mountains 17.78,83.20
step
label "Collect_Worn_Stone_Tokens"
kill Dalaran Shield Guard##2271, Dalaran Theurgist##2272, Dalaran Worker##2628, Dalaran Summoner##2358
|tip Don't hit {o}Shield Guards{} with melee when they're {o}glowing{}.
|tip Deals high damage.
|tip Humans.
collect 10 Worn Stone Token##3714 |q 556/1 |goto Alterac Mountains 20.20,82.40
|mapmarker Alterac Mountains/0 17.40,81.00
|mapmarker Alterac Mountains/0 17.60,84.00
|mapmarker Alterac Mountains/0 19.40,86.80
|mapmarker Alterac Mountains/0 22.00,85.20
step
_Destroy This Item:_
|tip Not needed.
trash Belamoore's Research Journal##3711
step
click Flame of Uzel
|tip Inside the small cave.
Charge the Flame of Uzel |q 553/3 |goto Alterac Mountains 37.54,66.26
|only if not hardcore()
step
kill Syndicate Footpad##2240, Syndicate Thief##2241
collect Syndicate Missive##3601 |q 533/1 |goto Alterac Mountains/0 47.60,82.80
|mapmarker Alterac Mountains/0 46.00,80.40
|mapmarker Alterac Mountains/0 57.80,66.40
|mapmarker Alterac Mountains/0 48.20,80.20
|mapmarker Alterac Mountains/0 49.60,82.00
|mapmarker Alterac Mountains/0 55.80,66.60
|mapmarker Alterac Mountains/0 56.40,69.00
|mapmarker Alterac Mountains/0 58.00,64.40
|mapmarker Alterac Mountains/0 58.40,69.80
|mapmarker Alterac Mountains/0 60.00,67.00
step
Kill enemies
|tip Helps reach level 32 after quest turnins.
|tip Inside and outside the cave.
ding 31,35550 |goto Hillsbrad Foothills 46.18,31.83
|mapmarker Hillsbrad Foothills/0 41.80,32.00
|mapmarker Hillsbrad Foothills/0 42.80,33.60
|mapmarker Hillsbrad Foothills/0 43.40,25.40
|mapmarker Hillsbrad Foothills/0 43.40,27.40
|mapmarker Hillsbrad Foothills/0 43.40,29.40
|mapmarker Hillsbrad Foothills/0 44.20,31.20
|mapmarker Hillsbrad Foothills/0 45.00,26.40
|mapmarker Hillsbrad Foothills/0 45.00,28.60
|mapmarker Hillsbrad Foothills/0 45.40,33.40
|mapmarker Hillsbrad Foothills/0 46.20,31.80
|mapmarker Hillsbrad Foothills/0 47.60,30.40
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
turnin Prison Break In##544 |goto Hillsbrad Foothills 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
turnin Stone Tokens##556 |goto Hillsbrad Foothills 61.50,20.94
step
talk Tallow##2770
accept The Hammer May Fall##676 |goto Hillsbrad Foothills 61.87,19.58
step
talk Deathguard Samsa##2418
turnin Souvenirs of Death##546 |goto Hillsbrad Foothills 62.11,19.70
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin Battle of Hillsbrad##539 |goto Hillsbrad Foothills 62.33,20.46
turnin Dangerous!##567 |goto Hillsbrad Foothills 62.33,20.46
step
talk Krusk##2229
|tip Inside the building.
turnin Infiltration##533 |goto Hillsbrad Foothills 63.24,20.65
step
Avoid Southshore |goto Hillsbrad Foothills 54.96,49.07 < 40 |only if walking
Follow the path and be careful to avoid the guards |goto Hillsbrad Foothills 53.54,52.18 < 40 |only if walking
click Helcular's Grave
|tip Avoid Southshore guards.
|tip Be {o}extremely careful{}. |only if hardcore()
turnin Helcular's Revenge##553 |goto Hillsbrad Foothills 52.78,53.38
|only if not hardcore()
step
click Mudsnout Blossom+
|tip Large mushrooms.
collect 6 Mudsnout Blossoms##3502 |q 509/1 |goto Hillsbrad Foothills 64.00,59.90
|mapmarker Hillsbrad Foothills/0 62.90,62.00
|mapmarker Hillsbrad Foothills/0 64.90,62.80
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Arathi Highlands (32-33)",{
image=ZGV.IMAGESDIR.."Arathi Highlands",
hardcore = true,
next="Leveling Guides\\Thousand Needles (33-34)",
},[[
stickystart "Kill_Boulderfist_Ogres"
step
kill 10 Boulderfist Enforcer##2564 |q 676/2 |goto Arathi Highlands 34.81,44.14
|tip Inside the cave.
|mapmarker Arathi Highlands/0 31.00,43.20
|mapmarker Arathi Highlands/0 31.40,45.80
|mapmarker Arathi Highlands/0 33.40,44.00
step
label "Kill_Boulderfist_Ogres"
Leave the cave |goto Arathi Highlands 34.82,44.15 < 15 |walk |only if subzone("Boulderfist Outpost")
kill 8 Boulderfist Ogre##2562 |q 676/1 |goto Arathi Highlands 37.60,43.40
|tip Outside the cave. |notinsticky
|mapmarker Arathi Highlands/0 30.80,45.00
|mapmarker Arathi Highlands/0 32.40,40.20
|mapmarker Arathi Highlands/0 32.80,49.80
|mapmarker Arathi Highlands/0 35.60,41.00
|mapmarker Arathi Highlands/0 35.20,45.60
|stickyif not subzone("Boulderfist Outpost")
step
Leave the cave |goto Arathi Highlands 34.82,44.15 < 15 |walk |only if subzone("Boulderfist Outpost")
kill Marcel Dabyrie##4481
|tip Inside the building.
collect Marcel's Head##5832 |q 1164/2 |goto Arathi Highlands 54.14,38.16
step
kill Fardel Dabyrie##4479
|tip Multiple locations.
collect Fardel's Head##58312 |q 1164/3 |goto Arathi Highlands 56.54,38.70
|mapmarker Arathi Highlands/0 53.60,40.00
|mapmarker Arathi Highlands/0 54.00,37.20
|mapmarker Arathi Highlands/0 56.40,40.60
step
kill Kenata Dabyrie##4480
|tip Inside the building.
collect Kenata's Head##5830 |q 1164/1 |goto Arathi Highlands 56.37,36.08
step
click Shards of Myzrael
accept The Princess Trapped##642 |goto Arathi Highlands 62.48,33.80
step
talk Urda##2851
fpath Hammerfall |goto Arathi Highlands 73.06,32.68
step
talk Drum Fel##2771
turnin The Hammer May Fall##676 |goto Arathi Highlands/0 74.24,33.91
accept Call to Arms##677 |goto Arathi Highlands/0 74.24,33.91
step
talk Gor'mul##2792
|tip Walks around.
accept Hammerfall##655 |goto Arathi Highlands/0 72.67,34.12
step
talk Tor'gan##2706
turnin Hammerfall##655 |goto Arathi Highlands/0 74.71,36.29
accept Raising Spirits##672 |goto Arathi Highlands/0 74.71,36.29
accept Foul Magics##671 |goto Arathi Highlands/0 74.71,36.29
stickystart "Collect_Highland_Raptor_Eyes"
step
kill Syndicate Pathstalker##2587, Syndicate Mercenary##2589, Syndicate Highwayman##2586
|tip Avoid {o}Refuge Point{}.
|tip Careful, stealthed enemies.
|tip More stealthed {o}along the ridges{}.
|tip Also inside buildings.
collect 10 Bloodstone Amulet##4495 |q 671/1 |goto Arathi Highlands 33.40,30.00
|mapmarker Arathi Highlands/0 29.20,27.00
|mapmarker Arathi Highlands/0 30.00,24.60
|mapmarker Arathi Highlands/0 30.00,30.00
|mapmarker Arathi Highlands/0 31.40,32.40
|mapmarker Arathi Highlands/0 32.20,25.00
|mapmarker Arathi Highlands/0 33.40,27.00
|mapmarker Arathi Highlands/0 33.80,32.80
step
label "Collect_Highland_Raptor_Eyes"
kill Highland Strider##2559, Highland Thrasher##2560
|tip Raptors.
|tip Avoid Refuge Pointe. |notinsticky
collect 10 Highland Raptor Eye##4512 |q 672/1 |goto Arathi Highlands/0 42.40,40.40
|mapmarker Arathi Highlands/0 36.40,51.20
|mapmarker Arathi Highlands/0 38.00,48.20
|mapmarker Arathi Highlands/0 39.40,54.80
|mapmarker Arathi Highlands/0 40.00,43.40
|mapmarker Arathi Highlands/0 40.00,51.00
|mapmarker Arathi Highlands/0 40.40,46.40
|mapmarker Arathi Highlands/0 42.60,49.40
|mapmarker Arathi Highlands/0 42.80,52.60
|mapmarker Arathi Highlands/0 45.80,55.00
|mapmarker Arathi Highlands/0 46.40,39.40
|mapmarker Arathi Highlands/0 46.40,50.20
|mapmarker Arathi Highlands/0 49.40,40.80
|mapmarker Arathi Highlands/0 49.40,49.20
|mapmarker Arathi Highlands/0 49.40,52.40
|mapmarker Arathi Highlands/0 51.20,44.20
|mapmarker Arathi Highlands/0 53.40,46.60
|mapmarker Arathi Highlands/0 56.20,48.20
|mapmarker Arathi Highlands/0 58.20,36.60
|mapmarker Arathi Highlands/0 58.40,41.20
|mapmarker Arathi Highlands/0 59.40,45.20
|mapmarker Arathi Highlands/0 60.60,39.00
|mapmarker Arathi Highlands/0 61.60,42.40
|mapmarker Arathi Highlands/0 62.20,47.60
|mapmarker Arathi Highlands/0 64.40,40.40
|mapmarker Arathi Highlands/0 64.40,51.00
|mapmarker Arathi Highlands/0 65.00,30.60
|mapmarker Arathi Highlands/0 65.00,44.40
|mapmarker Arathi Highlands/0 65.40,36.40
|mapmarker Arathi Highlands/0 66.80,33.40
|mapmarker Arathi Highlands/0 67.20,55.60
|mapmarker Arathi Highlands/0 67.60,39.00
|mapmarker Arathi Highlands/0 67.60,42.00
|mapmarker Arathi Highlands/0 68.40,27.80
|mapmarker Arathi Highlands/0 68.40,36.00
|mapmarker Arathi Highlands/0 68.80,51.20
|mapmarker Arathi Highlands/0 69.40,31.40
|mapmarker Arathi Highlands/0 71.80,50.80
|mapmarker Arathi Highlands/0 73.20,48.00
|stickyif not subzone("Northfold Manor")
step
kill 8 Witherbark Witch Doctor##2555 |q 677/3 |goto Arathi Highlands/0 65.80,68.00
kill 10 Witherbark Headhunter##2556 |q 677/2 |goto Arathi Highlands/0 65.80,68.00
kill 10 Witherbark Axe Thrower##2554 |q 677/1 |goto Arathi Highlands 65.80,68.00
|mapmarker Arathi Highlands/0 60.80,72.20
|mapmarker Arathi Highlands/0 62.80,67.60
|mapmarker Arathi Highlands/0 65.00,73.60
|mapmarker Arathi Highlands/0 65.40,71.40
|mapmarker Arathi Highlands/0 66.40,63.40
|mapmarker Arathi Highlands/0 67.00,73.60
|mapmarker Arathi Highlands/0 68.60,71.80
|mapmarker Arathi Highlands/0 69.00,61.40
|mapmarker Arathi Highlands/0 69.20,68.40
|mapmarker Arathi Highlands/0 69.80,66.40
|mapmarker Arathi Highlands/0 70.40,70.40
|mapmarker Arathi Highlands/0 71.40,63.00
|mapmarker Arathi Highlands/0 72.40,65.80
step
Kill enemies
|tip Helps reach level 33 after quest turnins.
ding 32,43760 |goto Arathi Highlands 65.80,68.00
|mapmarker Arathi Highlands/0 60.80,72.20
|mapmarker Arathi Highlands/0 62.80,67.60
|mapmarker Arathi Highlands/0 65.00,73.60
|mapmarker Arathi Highlands/0 65.40,71.40
|mapmarker Arathi Highlands/0 66.40,63.40
|mapmarker Arathi Highlands/0 67.00,73.60
|mapmarker Arathi Highlands/0 68.60,71.80
|mapmarker Arathi Highlands/0 69.00,61.40
|mapmarker Arathi Highlands/0 69.20,68.40
|mapmarker Arathi Highlands/0 69.80,66.40
|mapmarker Arathi Highlands/0 70.40,70.40
|mapmarker Arathi Highlands/0 71.40,63.00
|mapmarker Arathi Highlands/0 72.40,65.80
step
talk Tor'gan##2706
turnin Foul Magics##671 |goto Arathi Highlands/0 74.71,36.29
turnin Raising Spirits##672 |goto Arathi Highlands/0 74.71,36.29
accept Raising Spirits##674 |goto Arathi Highlands/0 74.71,36.29
step
talk Gor'mul##2792
|tip Walks around.
turnin Raising Spirits##674 |goto Arathi Highlands/0 72.67,34.12
accept Raising Spirits##675 |goto Arathi Highlands/0 72.67,34.12
step
talk Tor'gan##2706
turnin Raising Spirits##675 |goto Arathi Highlands/0 74.71,36.29
step
talk Drum Fel##2771
turnin Call to Arms##677 |goto Arathi Highlands/0 74.24,33.91
step
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Elixir of Agony##509 |goto Hillsbrad Foothills 61.44,19.06
accept Elixir of Agony##513 |goto Hillsbrad Foothills 61.44,19.06
step
talk Anastasia Hartwell##4568
|tip Upstairs inside the building.
Train Abilities |trainer Anastasia Hartwell##4568 |goto Undercity/0 85.14,10.03 |q 1164
|only if Mage
step
talk Genavie Callow##4486
turnin To Steal From Thieves##1164 |goto Undercity 63.84,49.45
step
talk William Montague##4549
|tip Collect from the bank.
collect Kravel's Parts##5800 |goto Undercity 65.97,44.75 |q 1112
collect Belgrom's Sealed Note##5850 |goto Undercity 65.97,44.75 |q 1146
step
Follow the path down |goto Undercity 52.84,77.63 < 10 |walk
talk Master Apothecary Faranell##2055
turnin Elixir of Agony##513 |goto Undercity 48.82,69.28
step
Leave the Apothecarium |goto Undercity/0 47.84,76.46 < 10 |only if walking and subzone("The Apothecarium")
Follow the path down |goto Undercity/0 52.18,64.42 < 15 |only if walking
talk Varimathras##2425
turnin Battle of Hillsbrad##550 |goto Undercity/0 56.24,92.22
step
talk Father Lazarus##4608
Train Abilities |trainer Father Lazarus##4608 |goto Undercity/0 47.57,18.90 |q 5361 |future
|only if Priest
step
talk Carolyn Ward##4582
Train Abilities |trainer Carolyn Ward##4582 |goto Undercity/0 83.86,72.07 |q 5361 |future
|only if Rogue
step
talk Kaal Soulreaper##4563
|tip Inside the building.
Train Abilities |trainer Kaal Soulreaper##4563 |goto Undercity/0 86.21,15.93 |q 5361 |future
|only if Warlock
step
talk Martha Strain##5753
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Martha Strain##5753 |goto Undercity/0 85.70,16.08 |q 5361 |future
|only if Warlock
step
talk Baltus Fowler##4595
|tip Inside the building.
Train Abilities |trainer Baltus Fowler##4595 |goto Undercity/0 47.40,17.29 |q 5361 |future
|only if Warrior
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 5361 |future
|only if Druid
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Thousand Needles (33-34)",{
image=ZGV.IMAGESDIR.."Thousand Needles",
hardcore = true,
next="Leveling Guides\\Desolace (34-36)",
},[[
step
_NOTE:_
Optional Dungeon Later
|tip Can run {o}Gnomeregan{} dungeon later.
|tip Slower leveling, but potential gear upgrades.
|tip We'll pick up dungeon quests.
|tip Guide will say when it's time to run the dungeon.
Click Here to Run {y}Gnomeregan{} Dungeon Later |confirm Gnomerflag |multiq 2841,2842,2843 |future
|tip Skip if you'd rather grind.
step
Follow the path up |goto Thousand Needles 54.67,44.77 < 20 |only if walking
talk Prate Cloudseer##5905
turnin Call of Air##1531 |goto Thousand Needles 53.54,42.65
|only if Shaman
step
talk Moktar Krin##4483
turnin The Swarm Grows##1146 |goto Thousand Needles 67.58,63.94
accept The Swarm Grows##1147 |goto Thousand Needles 67.58,63.94
step
talk Kravel Koalbeard##4452
turnin Parts for Kravel##1112 |goto Thousand Needles 77.79,77.27
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Rocket Car Parts##1110 |goto Thousand Needles 77.79,77.27
accept Delivery to the Gnomes##1114 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin Delivery to the Gnomes##1114 |goto Thousand Needles 78.06,77.13
accept Salt Flat Venom##1104 |goto Thousand Needles 78.06,77.13
step
talk Kravel Koalbeard##4452
accept The Rumormonger##1115 |goto Thousand Needles 77.79,77.27
step
talk Wizzle Brassbolts##4453
accept Hardened Shells##1105 |goto Thousand Needles 78.14,77.12
step
talk Pozzik##4630
accept Load Lightening##1176 |goto Thousand Needles 80.18,75.89
step
talk Trackmaster Zherin##4629
accept A Bump in the Road##1175 |goto Thousand Needles 81.64,77.95
step
_NOTE:_
During the Next Steps
|tip Careful, insect enemies call for help.
|tip Try to pull them away from other enemies.
Click Here to Continue |confirm |q 1148 |future
stickystart "Kill_Silithid_Searchers"
stickystart "Accept_Parts_Of_The_Swarm"
stickystart "Kill_Silithid_Hive_Drones"
stickystart "Collect_Silithid_Items"
step
kill 5 Silithid Invader##4131 |q 1147/3 |goto Thousand Needles 66.32,86.18
|tip Shared spawns with Hive Drones.
|tip Inside the cave.
|mapmarker Thousand Needles/0 63.40,85.80
step
label "Kill_Silithid_Searchers"
Leave the cave |goto Thousand Needles 66.32,86.18 < 15 |walk |only if subzone("The Rustmaul Dig Site") and indoors()
kill 5 Silithid Searcher##4130 |q 1147/1 |goto Thousand Needles 70.20,82.60
|tip Outside the cave. |notinsticky
|mapmarker Thousand Needles/0 67.40,81.40
|mapmarker Thousand Needles/0 67.40,84.60
|mapmarker Thousand Needles/0 68.40,87.60
|mapmarker Thousand Needles/0 71.40,85.80
step
label "Accept_Parts_Of_The_Swarm"
kill Silithid Searcher##4130, Silithid Hive Drone##4133, Silithid Ravager##4132, Silithid Invader##4131
|tip Inside and outside the cave. |notinsticky
collect Cracked Silithid Carapace##5877 |n
use Cracked Silithid Carapace##5877
accept Parts of the Swarm##1148 |goto Thousand Needles 70.20,82.60
|mapmarker Thousand Needles/0 67.40,81.40
|mapmarker Thousand Needles/0 67.40,84.60
|mapmarker Thousand Needles/0 68.40,87.60
|mapmarker Thousand Needles/0 71.40,85.80
|only if (haveq(1147) or completedq(1147)) or (haveq(1148) or completedq(1148))
step
label "Kill_Silithid_Hive_Drones"
kill 5 Silithid Hive Drone##4133 |q 1147/2 |goto Thousand Needles 70.00,84.60
|tip Inside and outside the cave. |notinsticky
|mapmarker Thousand Needles/0 67.00,83.80
|mapmarker Thousand Needles/0 67.80,88.00
|mapmarker Thousand Needles/0 69.20,81.60
|mapmarker Thousand Needles/0 66.32,86.18
step
label "Collect_Silithid_Items"
Leave the cave |goto Thousand Needles 66.32,86.18 < 15 |walk |only if subzone("The Rustmaul Dig Site") and indoors()
kill Silithid Searcher##4130, Silithid Hive Drone##4133, Silithid Ravager##4132, Silithid Invader##4131
|tip Inside and outside the cave. |notinsticky
collect Silithid Heart##5855 |q 1148/1 |goto Thousand Needles 70.20,82.60
collect 3 Intact Silithid Carapace##5853 |q 1148/3 |goto Thousand Needles 70.20,82.60
collect 5 Silithid Talon##5854 |q 1148/2 |goto Thousand Needles 70.20,82.60
|mapmarker Thousand Needles/0 67.40,81.40
|mapmarker Thousand Needles/0 67.40,84.60
|mapmarker Thousand Needles/0 68.40,87.60
|mapmarker Thousand Needles/0 71.40,85.80
|mapmarker Thousand Needles/0 66.32,86.18
|only if haveq(1148) or completedq(1148)
stickystart "Collect_Hardened_Tortoise_Shells"
stickystart "Collect_Salty_Scorpid_Venom"
stickystart "Kill_Saltstone_Basilisks"
stickystart "Collect_Rocket_Car_Parts"
stickystart "Kill_Saltstone_Crystalhides"
step
Leave the cave |goto Thousand Needles 66.32,86.18 < 15 |walk |only if subzone("The Rustmaul Dig Site") and indoors()
kill 6 Saltstone Gazer##4150 |q 1175/3 |goto Thousand Needles 77.40,88.00
|mapmarker Thousand Needles/0 75.40,82.80
|mapmarker Thousand Needles/0 75.40,85.40
|mapmarker Thousand Needles/0 75.40,87.80
|mapmarker Thousand Needles/0 75.40,89.80
|mapmarker Thousand Needles/0 76.40,91.60
|mapmarker Thousand Needles/0 77.40,82.40
|mapmarker Thousand Needles/0 78.40,84.40
|mapmarker Thousand Needles/0 78.40,90.20
|mapmarker Thousand Needles/0 79.60,87.00
|mapmarker Thousand Needles/0 80.60,89.20
|mapmarker Thousand Needles/0 81.80,87.20
step
kill Salt Flats Scavenger##4154, Salt Flats Vulture##4158
|tip Vultures.
|tip Mostly here, otherwise uncommon.
collect 10 Hollow Vulture Bone##5848 |q 1176/1 |goto Thousand Needles 88.00,66.00
|tip Revisit this location while working on other quests.
|mapmarker Thousand Needles/0 69.40,63.60
|mapmarker Thousand Needles/0 70.20,66.40
|mapmarker Thousand Needles/0 71.80,71.20
|mapmarker Thousand Needles/0 73.20,58.20
|mapmarker Thousand Needles/0 73.40,60.20
|mapmarker Thousand Needles/0 79.80,55.20
|mapmarker Thousand Needles/0 81.40,53.80
|mapmarker Thousand Needles/0 82.40,63.80
|mapmarker Thousand Needles/0 83.40,56.20
|mapmarker Thousand Needles/0 83.80,60.40
step
label "Collect_Hardened_Tortoise_Shells"
kill Sparkleshell Borer##4144, Sparkleshell Tortoise##4142, Sparkleshell Snapper##4143
|tip Turtles.
collect 9 Hardened Tortoise Shell##5795 |q 1105/1 |goto Thousand Needles 82.80,55.20
|mapmarker Thousand Needles/0 69.20,59.80
|mapmarker Thousand Needles/0 69.40,64.40
|mapmarker Thousand Needles/0 69.80,67.40
|mapmarker Thousand Needles/0 71.20,54.40
|mapmarker Thousand Needles/0 72.20,57.40
|mapmarker Thousand Needles/0 72.40,61.40
|mapmarker Thousand Needles/0 74.20,53.40
|mapmarker Thousand Needles/0 74.80,64.80
|mapmarker Thousand Needles/0 75.20,57.60
|mapmarker Thousand Needles/0 77.20,54.40
|mapmarker Thousand Needles/0 72.00,69.40
|mapmarker Thousand Needles/0 76.00,67.80
|mapmarker Thousand Needles/0 76.20,71.80
|mapmarker Thousand Needles/0 78.20,52.20
|mapmarker Thousand Needles/0 79.00,56.60
|mapmarker Thousand Needles/0 79.40,70.20
|mapmarker Thousand Needles/0 81.20,52.40
|mapmarker Thousand Needles/0 82.40,61.00
|mapmarker Thousand Needles/0 82.40,70.20
|mapmarker Thousand Needles/0 82.80,66.40
|mapmarker Thousand Needles/0 83.60,58.20
|mapmarker Thousand Needles/0 85.40,62.40
|mapmarker Thousand Needles/0 86.60,57.40
|mapmarker Thousand Needles/0 86.80,70.00
step
label "Collect_Salty_Scorpid_Venom"
kill Scorpid Reaver##4140, Scorpid Terror##4139
|tip Scorpions.
collect 6 Salty Scorpid Venom##5794 |q 1104/1 |goto Thousand Needles 82.40,60.00
|mapmarker Thousand Needles/0 69.20,60.20
|mapmarker Thousand Needles/0 69.40,63.40
|mapmarker Thousand Needles/0 69.40,67.00
|mapmarker Thousand Needles/0 70.40,57.40
|mapmarker Thousand Needles/0 70.40,72.40
|mapmarker Thousand Needles/0 71.20,54.40
|mapmarker Thousand Needles/0 72.00,69.60
|mapmarker Thousand Needles/0 72.40,61.40
|mapmarker Thousand Needles/0 72.60,65.80
|mapmarker Thousand Needles/0 72.60,74.80
|mapmarker Thousand Needles/0 73.40,56.80
|mapmarker Thousand Needles/0 74.20,53.20
|mapmarker Thousand Needles/0 75.40,68.40
|mapmarker Thousand Needles/0 75.60,62.20
|mapmarker Thousand Needles/0 75.60,65.40
|mapmarker Thousand Needles/0 76.40,58.80
|mapmarker Thousand Needles/0 76.40,71.80
|mapmarker Thousand Needles/0 77.20,53.00
|mapmarker Thousand Needles/0 78.40,66.80
|mapmarker Thousand Needles/0 79.00,56.60
|mapmarker Thousand Needles/0 79.40,50.60
|mapmarker Thousand Needles/0 79.40,69.80
|mapmarker Thousand Needles/0 82.40,64.00
|mapmarker Thousand Needles/0 82.40,69.20
|mapmarker Thousand Needles/0 83.60,57.20
|mapmarker Thousand Needles/0 84.20,66.80
|mapmarker Thousand Needles/0 85.40,59.80
|mapmarker Thousand Needles/0 86.40,63.80
step
label "Kill_Saltstone_Basilisks"
kill 10 Saltstone Basilisk##4147 |q 1175/1 |goto Thousand Needles 78.40,59.00
|mapmarker Thousand Needles/0 68.40,61.00
|mapmarker Thousand Needles/0 69.20,64.00
|mapmarker Thousand Needles/0 69.40,68.40
|mapmarker Thousand Needles/0 70.40,57.40
|mapmarker Thousand Needles/0 71.20,54.40
|mapmarker Thousand Needles/0 72.00,66.20
|mapmarker Thousand Needles/0 72.20,70.60
|mapmarker Thousand Needles/0 72.40,61.40
|mapmarker Thousand Needles/0 73.40,56.80
|mapmarker Thousand Needles/0 74.40,53.40
|mapmarker Thousand Needles/0 75.00,64.60
|mapmarker Thousand Needles/0 75.60,61.40
|mapmarker Thousand Needles/0 76.60,56.40
|mapmarker Thousand Needles/0 77.40,51.40
|mapmarker Thousand Needles/0 78.40,63.80
|mapmarker Thousand Needles/0 79.60,66.80
step
label "Kill_Saltstone_Crystalhides"
kill 10 Saltstone Crystalhide##4151 |q 1175/2 |goto Thousand Needles 78.80,86.80
|mapmarker Thousand Needles/0 70.40,76.20
|mapmarker Thousand Needles/0 72.00,69.20
|mapmarker Thousand Needles/0 72.40,80.80
|mapmarker Thousand Needles/0 73.60,76.40
|mapmarker Thousand Needles/0 74.80,65.60
|mapmarker Thousand Needles/0 75.40,68.60
|mapmarker Thousand Needles/0 75.40,86.00
|mapmarker Thousand Needles/0 75.40,89.80
|mapmarker Thousand Needles/0 76.20,60.40
|mapmarker Thousand Needles/0 76.20,72.60
|mapmarker Thousand Needles/0 77.80,65.60
|mapmarker Thousand Needles/0 78.20,83.40
|mapmarker Thousand Needles/0 78.40,52.40
|mapmarker Thousand Needles/0 78.40,90.00
|mapmarker Thousand Needles/0 79.00,56.60
|mapmarker Thousand Needles/0 79.20,61.60
|mapmarker Thousand Needles/0 79.20,69.40
|mapmarker Thousand Needles/0 82.40,61.20
|mapmarker Thousand Needles/0 82.40,65.80
|mapmarker Thousand Needles/0 82.40,69.40
|mapmarker Thousand Needles/0 83.20,73.40
|mapmarker Thousand Needles/0 83.40,57.40
|mapmarker Thousand Needles/0 83.40,76.80
|mapmarker Thousand Needles/0 85.40,60.20
|mapmarker Thousand Needles/0 86.40,63.60
|mapmarker Thousand Needles/0 86.40,69.20
|mapmarker Thousand Needles/0 86.40,74.40
|mapmarker Thousand Needles/0 86.60,57.40
|mapmarker Thousand Needles/0 87.40,77.80
step
label "Collect_Rocket_Car_Parts"
click Rocket Car Rubble##19868+
|tip Various machine parts.
|tip Throughout the Shimmering Flats.
collect 30 Rocket Car Parts##5798 |q 1110/1 |goto Thousand Needles 83.00,64.60
|mapmarker Thousand Needles/0 69.60,61.20
|mapmarker Thousand Needles/0 69.90,78.50
|mapmarker Thousand Needles/0 70.20,57.20
|mapmarker Thousand Needles/0 71.40,64.40
|mapmarker Thousand Needles/0 71.70,68.50
|mapmarker Thousand Needles/0 72.40,72.30
|mapmarker Thousand Needles/0 72.50,80.70
|mapmarker Thousand Needles/0 73.10,59.70
|mapmarker Thousand Needles/0 75.40,56.30
|mapmarker Thousand Needles/0 76.20,86.90
|mapmarker Thousand Needles/0 77.00,53.20
|mapmarker Thousand Needles/0 78.40,90.10
|mapmarker Thousand Needles/0 79.40,85.50
|mapmarker Thousand Needles/0 79.50,59.10
|mapmarker Thousand Needles/0 80.70,54.20
|mapmarker Thousand Needles/0 81.90,87.30
|mapmarker Thousand Needles/0 85.30,58.40
|mapmarker Thousand Needles/0 85.60,61.40
|mapmarker Thousand Needles/0 86.20,74.40
|mapmarker Thousand Needles/0 86.60,64.70
|mapmarker Thousand Needles/0 86.90,67.90
|mapmarker Thousand Needles/0 87.50,71.20
|mapmarker Thousand Needles/0 88.00,79.80
step
talk Moktar Krin##4483
turnin The Swarm Grows##1147 |goto Thousand Needles 67.58,63.94
step
talk Kravel Koalbeard##4452
turnin Rocket Car Parts##1110 |goto Thousand Needles 77.79,77.27
accept Hemet Nesingwary Jr.##5762 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin Salt Flat Venom##1104 |goto Thousand Needles 78.06,77.13
step
talk Wizzle Brassbolts##4453
turnin Hardened Shells##1105 |goto Thousand Needles 78.14,77.12
step
talk Fizzle Brassbolts##4454
accept Martek the Exiled##1106 |goto Thousand Needles 78.06,77.12
step
talk Pozzik##4630
turnin Load Lightening##1176 |goto Thousand Needles 80.18,75.88
accept Goblin Sponsorship##1178 |goto Thousand Needles 80.18,75.88
step
talk Trackmaster Zherin##4629
turnin A Bump in the Road##1175 |goto Thousand Needles 81.63,77.95
step
Kill enemies
ding 34 |goto Thousand Needles 82.80,55.20
|mapmarker Thousand Needles/0 69.20,59.80
|mapmarker Thousand Needles/0 69.40,64.40
|mapmarker Thousand Needles/0 69.80,67.40
|mapmarker Thousand Needles/0 71.20,54.40
|mapmarker Thousand Needles/0 72.20,57.40
|mapmarker Thousand Needles/0 72.40,61.40
|mapmarker Thousand Needles/0 74.20,53.40
|mapmarker Thousand Needles/0 74.80,64.80
|mapmarker Thousand Needles/0 75.20,57.60
|mapmarker Thousand Needles/0 77.20,54.40
|mapmarker Thousand Needles/0 72.00,69.40
|mapmarker Thousand Needles/0 76.00,67.80
|mapmarker Thousand Needles/0 76.20,71.80
|mapmarker Thousand Needles/0 78.20,52.20
|mapmarker Thousand Needles/0 79.00,56.60
|mapmarker Thousand Needles/0 79.40,70.20
|mapmarker Thousand Needles/0 81.20,52.40
|mapmarker Thousand Needles/0 82.40,61.00
|mapmarker Thousand Needles/0 82.40,70.20
|mapmarker Thousand Needles/0 82.80,66.40
|mapmarker Thousand Needles/0 83.60,58.20
|mapmarker Thousand Needles/0 85.40,62.40
|mapmarker Thousand Needles/0 86.60,57.40
|mapmarker Thousand Needles/0 86.80,70.00
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1148
|only if Druid
step
talk Cliffwatcher Longhorn##10537
|tip Walks around.
accept Family Tree##5361 |goto Thousand Needles 45.65,50.80
step
talk Korran##3428
turnin Parts of the Swarm##1148 |goto The Barrens 51.07,29.63
accept Parts of the Swarm##1184 |goto The Barrens 51.07,29.63
step
_Destroy This Item:_
|tip Not needed.
trash Cracked Silithid Carapace##5877
step
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Goblin Sponsorship##1178 |goto The Barrens 62.68,36.23
accept Goblin Sponsorship##1180 |goto The Barrens 62.68,36.23
step
talk Islen Waterseer##5901
turnin Call of Water##96 |goto The Barrens 65.83,43.78
|only if Shaman
step
talk Wharfmaster Lozgil##4631
turnin Goblin Sponsorship##1180 |goto Stranglethorn Vale 26.34,73.56
accept Goblin Sponsorship##1181 |goto Stranglethorn Vale 26.34,73.56
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
accept Supply and Demand##575 |goto Stranglethorn Vale 28.29,77.59
step
talk Crank Fizzlebub##2498
|tip {o}Bottom floor{} inside the building.
accept Singing Blue Shards##605 |goto Stranglethorn Vale 27.12,77.21
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
turnin The Rumormonger##1115 |goto Stranglethorn Vale 26.94,77.21
accept Investigate the Camp##201 |goto Stranglethorn Vale 26.95,77.21
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
accept Bloodscalp Ears##189 |goto Stranglethorn Vale 27.00,77.12
accept Hostile Takeover##213 |goto Stranglethorn Vale 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
turnin Goblin Sponsorship##1181 |goto Stranglethorn Vale 27.23,76.87
accept Goblin Sponsorship##1182 |goto Stranglethorn Vale 27.23,76.87
step
talk Gringer##2858
|tip Up on the balcony of the building.
fpath Booty Bay |goto Stranglethorn Vale 26.87,77.10
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 1184
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 1184
|only if Priest
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 1178
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 1178
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 1178
|only if Warlock
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 1184
|only if Shaman
step
talk Belgrom Rockmaul##4485
turnin Parts of the Swarm##1184 |goto Orgrimmar 75.23,34.24
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 5361
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 5361
|only if Hunter
step
talk Auctioneer Thathung##8673
|tip Buy from the Auction House, if possible.
|tip Makes quests easier later.
|tip Inside the building.
collect 2 Elixir of Water Breathing##5996	|goto Orgrimmar/0 55.69,62.86 |q 6161 |future	|only if not (Undead or Druid or Warlock or Shaman)
collect 2 Shiny Fish Scales##17057		|goto Orgrimmar/0 55.69,62.86 |q 6161 |future	|only if Shaman
|only if not (Undead or Druid or Warlock)
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Fizzle Brassbolts' Letter##5827 |goto Orgrimmar/0 49.59,69.12 |q 1106
bank Kravel's Crate##14542 |goto Orgrimmar/0 49.59,69.12 |q 5762
step
talk Innkeeper Gryshka##6929
|tip Inside the building.
home Orgrimmar |goto Orgrimmar 54.09,68.42 |q 600 |future
step
_NOTE:_
Begin Finding a Dungeon Group
|tip Good time to run {o}Gnomeregan{} dungeon soon.
|tip Start looking for a group.
Click Here to Continue |confirm |multiq 2841,2842,2843 |future
|only if guideflag("Gnomerflag")
step
talk Nogg##3412
|tip Inside the building.
accept Rig Wars##2841 |goto Orgrimmar 75.99,25.41
|only if guideflag("Gnomerflag")
step
talk Sovik##3413
|tip Inside the building.
Select _"What else do you have to say?"_ |gossip 95758
accept Chief Engineer Scooty##2842 |goto Orgrimmar 75.49,25.36
|only if guideflag("Gnomerflag")
step
talk Scooty##7853
turnin Chief Engineer Scooty##2842 |goto Stranglethorn Vale 27.60,77.48
accept Gnomer-gooooone!##2843 |goto Stranglethorn Vale 27.60,77.48
|only if guideflag("Gnomerflag")
step
Watch the dialogue
Wait for Scooty to Calibrate the Goblin Transponder |q 2843/1 |goto Stranglethorn Vale 27.60,77.48
|only if guideflag("Gnomerflag")
step
talk Scooty##7853
turnin Gnomer-gooooone!##2843 |goto Stranglethorn Vale 27.60,77.48
|only if guideflag("Gnomerflag")
step
_NOTE:_
Starting Dungeon Run
|tip Running {o}Gnomeregan{} dungeon now.
|tip Meet with your dungeon group.
Click Here to Continue |confirm |multiq 2841,2842,2843 |future
|only if guideflag("Gnomerflag")
step
_Inside the Gnomeregan Dungeon:_
talk Kernobee##7850
|tip Inside the Dormitory area.
accept A Fine Mess##2904
|only if guideflag("Gnomerflag")
step
_Inside the Gnomeregan Dungeon:_
Rescue Kernobee |q 2904/1
|tip Bring Kernobee to the dungeon entrance portal.
|only if guideflag("Gnomerflag")
step
_Inside the Gnomeregan Dungeon:_
kill Mekgineer Thermaplugg##7800
|tip Final boss.
colect Thermaplugg's Safe Combination##9299 |q 2841/2
|only if guideflag("Gnomerflag")
step
_Inside the Gnomeregan Dungeon:_
click Thermaplugg's Safe##142477
|tip Grey metal chest.
|tip Near the northern wall.
|tip Same room as Mekgineer Thermaplugg.
collect Rig Blueprints##9153 |q 2841/1
|only if guideflag("Gnomerflag")
step
use Grime-Encrusted Ring##9326
accept Grime-Encrusted Ring##2945
|only if itemcount(9326) > 0 and guideflag("Gnomerflag")
step
click The Sparklematic 5200##142487
|tip In the {o}Dormitory{}.
|tip May need to click multiple.
turnin Grime-Encrusted Ring##2945
accept Return of the Ring##2949
accept The Sparklematic 5200!##2952 |instant
|only if (haveq(2945) or completedq(2945)) and guideflag("Gnomerflag")
step
Leave the Gnomeregan Dungeon |complete not zone("Gnomeregan") |multiq 2841,2904 |future
|only if guideflag("Gnomerflag")
step
talk Scooty##7853
turnin A Fine Mess##2904 |goto Stranglethorn Vale 27.60,77.48
|only if guideflag("Gnomerflag")
step
talk Nogg##3412
|tip Inside the building.
turnin Rig Wars##2841 |goto Orgrimmar 75.99,25.41
turnin Return of the Ring##2949 |goto Orgrimmar 75.99,25.41 |only if haveq(2949) or completedq(2949)
|only if guideflag("Gnomerflag")
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Desolace (34-36)",{
image=ZGV.IMAGESDIR.."Desolace",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale (36-37)",
},[[
step
talk Trak'gen##3313
|tip Inside the building.
Buy Extra Ammo |vendor Trak'gen##3313 |goto Orgrimmar/0 48.13,80.54 |q 1480 |future
|tip Long grind soon.
|only if Hunter
step
kill Burning Blade Augur##4663, Burning Blade Reaver##4664, Burning Blade Felsworn##4666, Burning Blade Adept##4665, Burning Blade Shadowmage##4667, Burning Blade Seer##13019
collect Flayed Demon Skin##20310 |n
use Flayed Demon Skin##20310
accept The Corrupter##1480 |goto Desolace/0 57.80,25.40
|mapmarker Desolace/0 53.20,27.40
|mapmarker Desolace/0 53.40,30.00
|mapmarker Desolace/0 55.20,27.40
|mapmarker Desolace/0 55.60,24.80
|mapmarker Desolace/0 55.80,31.60
|mapmarker Desolace/0 56.00,29.40
|mapmarker Desolace/0 57.20,27.80
step
Kill enemies
|tip Long grind.
|tip Run dungeons, if you prefer.
ding 35 |goto Desolace/0 57.80,25.40
|mapmarker Desolace/0 53.20,27.40
|mapmarker Desolace/0 53.40,30.00
|mapmarker Desolace/0 55.20,27.40
|mapmarker Desolace/0 55.60,24.80
|mapmarker Desolace/0 55.80,31.60
|mapmarker Desolace/0 56.00,29.40
|mapmarker Desolace/0 57.20,27.80
step
talk Azore Aldamort##11863
|tip Up on the cliff.
accept Sceptre of Light##5741 |goto Desolace 38.88,27.17
step
Follow the path up |goto Desolace 56.10,53.66 < 15 |only if walking
talk Nataka Longhorn##11259
turnin Family Tree##5361 |goto Desolace 55.41,55.81
step
talk Takata Steelblade##5641
turnin Alliance Relations##1432 |goto Desolace 52.57,54.39
accept Alliance Relations##1433 |goto Desolace 52.57,54.39
accept Befouled by Satyr##1434 |goto Desolace 52.57,54.39
step
talk Maurin Bonesplitter##4498
turnin Alliance Relations##1433 |goto Desolace 52.24,53.44
accept The Burning of Spirits##1435 |goto Desolace 52.24,53.44
turnin The Corrupter##1480 |goto Desolace 52.24,53.44
accept The Corrupter##1481 |goto Desolace 52.24,53.44
step
talk Felgur Twocuts##5395
accept Khan Dez'hepah##1365 |goto Desolace 56.20,59.57
step
talk Gurda Wildmane##5412
accept Gelkis Alliance##1368 |goto Desolace 56.29,59.68
step
kill Khan Dez'hepah##5600
|tip Multiple locations.
|tip Inside the building.
collect Khan Dez'hepah's Head##6066 |q 1365/1 |goto Desolace 74.68,48.84
|mapmarker Desolace/0 72.90,46.66
|mapmarker Desolace/0 73.38,41.62
stickystart "Kill_Hatefury_Enemies"
step
kill Hatefury Shadowstalker##4674+
|tip Shared spawns with other satyrs.
|tip Careful, stealthed enemies. |notinsticky
collect Shadowstalker Scalp##6441 |q 1481/1 |goto Desolace/0 72.40,24.20
|mapmarker Desolace/0 71.20,19.40
|mapmarker Desolace/0 72.40,13.40
|mapmarker Desolace/0 69.40,15.80
|mapmarker Desolace/0 73.40,9.20
|mapmarker Desolace/0 73.40,16.40
|mapmarker Desolace/0 74.40,26.60
|mapmarker Desolace/0 74.60,19.80
|mapmarker Desolace/0 76.00,22.60
|mapmarker Desolace/0 76.40,15.00
|mapmarker Desolace/0 76.40,29.80
|mapmarker Desolace/0 77.40,18.20
|mapmarker Desolace/0 77.40,26.60
|mapmarker Desolace/0 80.40,16.40
step
label "Kill_Hatefury_Enemies"
kill 7 Hatefury Rogue##4670 |q 1434/1 |goto Desolace/0 72.40,24.20
kill 7 Hatefury Felsworn##4672 |q 1434/2 |goto Desolace/0 72.40,24.20
kill 7 Hatefury Betrayer##4673 |q 1434/3 |goto Desolace/0 72.40,24.20
kill 7 Hatefury Hellcaller##4675 |q 1434/4 |goto Desolace/0 72.40,24.20
|tip Careful, stealthed enemies. |notinsticky
|mapmarker Desolace/0 71.20,19.40
|mapmarker Desolace/0 72.40,13.40
|mapmarker Desolace/0 69.40,15.80
|mapmarker Desolace/0 73.40,9.20
|mapmarker Desolace/0 73.40,16.40
|mapmarker Desolace/0 74.40,26.60
|mapmarker Desolace/0 74.60,19.80
|mapmarker Desolace/0 76.00,22.60
|mapmarker Desolace/0 76.40,15.00
|mapmarker Desolace/0 76.40,29.80
|mapmarker Desolace/0 77.40,18.20
|mapmarker Desolace/0 77.40,26.60
|mapmarker Desolace/0 80.40,16.40
step
talk Bibbly F'utzbuckle##11438
|tip Walks around.
accept Bone Collector##5501 |goto Desolace 62.33,38.98
step
Follow the path up |goto Desolace 55.89,53.49 < 15 |only if walking
talk Takata Steelblade##5641
turnin Befouled by Satyr##1434 |goto Desolace 52.57,54.38
step
talk Maurin Bonesplitter##4498
turnin The Corrupter##1481 |goto Desolace 52.25,53.45
accept The Corrupter##1482 |goto Desolace 52.25,53.45
step
talk Felgur Twocuts##5395
turnin Khan Dez'hepah##1365 |goto Desolace 56.20,59.56
accept Centaur Bounty##1366 |goto Desolace 56.20,59.56
step
kill Magram Outrunner##4639, Magram Scout##4638, Magram Wrangler##4640
|tip Centaurs.
|tip Avoid Magram Pack Runners walking with {o}2 hyena guards{}.
collect 15 Centaur Ear##6067 |q 1366/1 |goto Desolace/0 69.00,69.20
Reach {y}Friendly Reputation{} with Gelkis Clan Centaur |q 1368/1 |goto Desolace/0 69.00,69.20
|mapmarker Desolace/0 65.20,75.40
|mapmarker Desolace/0 65.40,70.00
|mapmarker Desolace/0 67.20,72.60
|mapmarker Desolace/0 71.40,67.00
|mapmarker Desolace/0 72.60,70.20
step
talk Smeed Scrabblescrew##11596
accept Kodo Roundup##5561 |goto Desolace 60.86,61.86
stickystart "Collect_Kodo_Bones"
step
use Kodo Kombobulator##13892
|tip On Kodo enemies.
|tip They will follow you.
|tip {o}Talk to them{} near Smeed Scrabblescrew.
Tame #5# Kodos |q 5561/1 |goto Desolace/0 54.40,60.30
Bring Kodos to [Desolace/0 60.73,61.96]
|mapmarker Desolace/0 46.20,61.30
|mapmarker Desolace/0 47.30,57.70
|mapmarker Desolace/0 50.80,58.80
step
talk Smeed Scrabblescrew##11596
turnin Kodo Roundup##5561 |goto Desolace 60.86,61.86
step
label "Collect_Kodo_Bones"
click Kodo Bones##176751+
|tip White horned animal skulls.
|tip May be attacked.
|tip Run away, if needed.
collect 10 Kodo Bone##13703 |q 5501/1 |goto Desolace/0 54.40,60.30
|mapmarker Desolace/0 46.20,61.30
|mapmarker Desolace/0 47.30,57.70
|mapmarker Desolace/0 50.80,58.80
step
talk Felgur Twocuts##5395
|tip Up on the cliff.
turnin Centaur Bounty##1366 |goto Desolace 56.19,59.56
step
talk Uthek the Wise##5397
turnin Gelkis Alliance##1368 |goto Desolace 36.23,79.25
accept Stealing Supplies##1370 |goto Desolace 36.23,79.25
step
Follow the path into Shadowprey Village |goto Desolace 26.27,74.83 < 40 |only if walking and not subzone("Shadowprey Village")
talk Taiga Wisemane##11624
accept Hand of Iruxos##5381 |goto Desolace 25.81,68.22
step
talk Aboda##11105
Stable Your Pet |stablemaster Aboda##11105 |goto Desolace/0 24.90,68.67 |q 5501
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 5){}.
|only if Hunter
step
talk Drulzegar Skraghook##12340
accept Other Fish to Fry##6143 |goto Desolace 23.32,72.87
step
talk Mai'Lahii##12031
|tip Inside the building.
accept Clam Bait##6142 |goto Desolace 22.65,71.97
step
talk Thalon##6726
fpath Shadowprey Village |goto Desolace 21.60,74.13
step
Learn the {y}Claw (Rank 5){} Pet Ability |learnspell Claw##2975 |goto Desolace/0 33.40,77.20 |q 5501
|tip Cast {o}Tame Beast{} on an {o}Scorpashi Lasher{}.
|tip Kill enemies nearby.
|mapmarker Desolace/0 33.20,81.60
|mapmarker Desolace/0 35.20,73.80
|mapmarker Desolace/0 36.20,79.20
|mapmarker Desolace/0 36.40,71.00
|mapmarker Desolace/0 38.20,74.60
|mapmarker Desolace/0 39.80,70.20
|mapmarker Desolace/0 40.40,78.20
|mapmarker Desolace/0 42.20,73.80
|mapmarker Desolace/0 42.80,70.00
|mapmarker Desolace/0 43.40,77.60
|mapmarker Desolace/0 45.20,73.00
|only if Hunter
step
Follow the path into Shadowprey Village |goto Desolace 26.27,74.83 < 40 |only if walking and not subzone("Shadowprey Village")
talk Aboda##11105
Retrieve Your Pet |stablemaster Aboda##11105 |goto Desolace/0 24.90,68.67 |q 5501
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 5){} to Your Pet |learnpetspell Claw##16831 |q 5501
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
talk Bibbly F'utzbuckle##11438
|tip Walks around.
turnin Bone Collector##5501 |goto Desolace 62.33,38.98
stickystart "Collect_Infused_Burning_Gems"
step
kill Burning Blade Seer##13019
|tip Top of the tower.
collect Sceptre of Light##15750 |q 5741/1 |goto Desolace 55.17,30.15
step
click Hand of Iruxos Crystal##176581
|tip Kill all enemies in the room first.
|tip Inside the building.
kill Demon Spirit##11876
collect Demon Box##13542 |q 5381/1 |goto Desolace 54.97,26.65
step
label "Collect_Infused_Burning_Gems"
use Burning Gem##6436
|tip On Burning Blade enemies.
|tip When {o}low health{}.
collect 15 Infused Burning Gem##6435 |q 1435/1 |goto Desolace/0 56.00,29.40
|mapmarker Desolace/0 53.20,27.40
|mapmarker Desolace/0 53.40,30.00
|mapmarker Desolace/0 55.20,27.40
|mapmarker Desolace/0 55.60,24.80
|mapmarker Desolace/0 55.80,31.60
|mapmarker Desolace/0 57.80,25.40
|mapmarker Desolace/0 57.20,27.80
step
talk Azore Aldamort##11863
|tip Up on the cliff.
turnin Sceptre of Light##5741 |goto Desolace 38.88,27.17
accept Book of the Ancients##6027 |goto Desolace 38.88,27.17
step
click Rackmore's Log##177787
|tip Small book.
accept Claim Rackmore's Treasure!##6161 |goto Desolace 36.07,30.41
stickystart "Collect_Softshelled_Clam_Meats"
step
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock)
kill Drysnap Pincer##11563, Drysnap Crawler##11562
|tip Lobsters.
|tip Underwater.
collect Rackmore's Silver Key##15878 |q 6161/1 |goto Desolace/0 33.80,30.20
|mapmarker Desolace/0 28.80,35.60
|mapmarker Desolace/0 31.00,27.40
|mapmarker Desolace/0 31.00,32.20
|mapmarker Desolace/0 32.80,35.20
stickystart "Collect_Rackmores_Golden_Key"
stickystart "Kill_Slitherblade_Sorceresses"
stickystart "Kill_Slitherblade_Nagas"
step
label "Collect_Softshelled_Clam_Meats"
click Giant Softshell Clam##177784+
|tip Large white clams.
|tip Underwater.
kill Enraged Reef Crawler##12347+
|tip Crabs.
collect Soft-shelled Clam##15874+ |n
use Soft-shelled Clam##15874+
collect 10 Soft-shelled Clam Meat##15924 |q 6142/1 |goto Desolace 33.00,28.40
|mapmarker Desolace/0 28.20,34.10
|mapmarker Desolace/0 30.40,34.20
|mapmarker Desolace/0 30.50,32.00
|mapmarker Desolace/0 30.70,27.50
|mapmarker Desolace/0 30.80,24.40
|mapmarker Desolace/0 31.90,30.40
|mapmarker Desolace/0 32.70,25.40
|mapmarker Desolace/0 32.80,35.20
|mapmarker Desolace/0 33.90,33.20
|mapmarker Desolace/0 34.10,30.80
|mapmarker Desolace/0 34.30,23.20
|mapmarker Desolace/0 35.40,25.00
stickystart "Collect_Oracle_Crystal"
stickystart "Kill_Slitherblade_Myrmidons"
step
label "Collect_Rackmores_Golden_Key"
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock)
kill Slitherblade Naga##4711, Slitherblade Sorceress##4712, Slitherblade Warrior##4713, Slitherblade Tide Priestess##218249, Slitherblade Myrmidon##4714, Slitherblade Oracle##4718, Slitherblade Razortail##4715, Slitherblade Sea Witch##4719, Slitherblade Tidehunter##4716
|tip Nagas. |notinsticky
|tip On islands and underwater. |notinsticky
collect Rackmore's Golden Key##15881 |q 6161/2 |goto Desolace/0 29.20,13.60
|mapmarker Desolace/0 27.40,9.20
|mapmarker Desolace/0 30.80,19.20
|mapmarker Desolace/0 32.20,6.60
|mapmarker Desolace/0 32.40,23.40
|mapmarker Desolace/0 33.20,10.40
|mapmarker Desolace/0 34.40,26.40
|mapmarker Desolace/0 34.40,30.00
|mapmarker Desolace/0 35.40,21.40
|mapmarker Desolace/0 35.60,14.00
|mapmarker Desolace/0 36.00,18.00
|mapmarker Desolace/0 37.20,8.20
|mapmarker Desolace/0 38.40,20.20
|mapmarker Desolace/0 38.40,23.80
|mapmarker Desolace/0 40.60,15.80
step
click Rackmore's Chest##177786
turnin Claim Rackmore's Treasure!##6161 |goto Desolace 30.00,8.70
stickystop "Kill_Slitherblade_Nagas"
step
Kill enemies
ding 36 |goto Desolace/0 28.40,12.20
|mapmarker Desolace/0 27.40,9.00
|mapmarker Desolace/0 29.20,15.40
|mapmarker Desolace/0 30.00,6.40
|mapmarker Desolace/0 30.40,9.60
|mapmarker Desolace/0 33.63,10.45
step
click Serpent Statue
kill Lord Kragaru##12369
collect Book of the Ancients##15803 |q 6027/1 |goto Desolace 28.19,6.62
step
label "Collect_Oracle_Crystal"
kill Slitherblade Oracle##4718+
|tip Shared spawns with other nagas. |notinsticky
|tip On islands and underwater. |notinsticky
collect Oracle Crystal##6442 |q 1482/1 |goto Desolace 27.40,8.00
|mapmarker Desolace/0 28.40,13.60
|mapmarker Desolace/0 30.00,6.40
|mapmarker Desolace/0 30.40,11.00
|mapmarker Desolace/0 30.60,18.40
|mapmarker Desolace/0 31.40,15.40
|mapmarker Desolace/0 32.20,23.40
|mapmarker Desolace/0 33.40,9.60
|mapmarker Desolace/0 33.80,13.40
|mapmarker Desolace/0 34.40,6.00
|mapmarker Desolace/0 34.40,17.40
|mapmarker Desolace/0 37.00,8.80
|mapmarker Desolace/0 38.80,13.40
|mapmarker Desolace/0 39.00,18.60
step
label "Kill_Slitherblade_Myrmidons"
kill 7 Slitherblade Myrmidon##4714 |q 6143/1 |goto Desolace 29.20,13.60
|tip Shared spawns with other nagas. |notinsticky
|mapmarker Desolace/0 27.20,10.20
|mapmarker Desolace/0 28.40,7.40
|mapmarker Desolace/0 31.40,18.00
|mapmarker Desolace/0 32.80,6.00
|mapmarker Desolace/0 32.80,14.80
|mapmarker Desolace/0 33.00,9.40
|mapmarker Desolace/0 33.00,22.20
|mapmarker Desolace/0 37.20,8.20
|mapmarker Desolace/0 38.00,19.20
|mapmarker Desolace/0 39.60,15.60
stickystart "Kill_Slitherblade_Nagas"
step
label "Kill_Slitherblade_Sorceresses"
kill 5 Slitherblade Sorceress##4712 |q 6143/3 |goto Desolace 34.40,22.40
|tip Shared spawns with other nagas. |notinsticky
|mapmarker Desolace/0 31.40,17.00
|mapmarker Desolace/0 31.40,22.00
|mapmarker Desolace/0 35.40,28.60
|mapmarker Desolace/0 36.20,25.20
|mapmarker Desolace/0 38.20,19.00
|mapmarker Desolace/0 39.00,15.60
|mapmarker Desolace/0 39.20,22.80
step
label "Kill_Slitherblade_Nagas"
kill 7 Slitherblade Naga##4711 |q 6143/2 |goto Desolace 35.40,21.40
|tip Shared spawns with other nagas. |notinsticky
|mapmarker Desolace/0 32.40,23.40
|mapmarker Desolace/0 34.40,27.80
|mapmarker Desolace/0 35.80,24.80
|mapmarker Desolace/0 38.40,21.80
|mapmarker Desolace/0 39.00,18.20
step
Follow the path up |goto Desolace/0 40.74,28.95 < 30 |only if walking
talk Azore Aldamort##11863
|tip Up on the cliff.
turnin Book of the Ancients##6027 |goto Desolace 38.89,27.17
step
Follow the path up |goto Desolace 55.89,53.49 < 15 |only if walking
talk Maurin Bonesplitter##4498
turnin The Burning of Spirits##1435 |goto Desolace 52.24,53.44
turnin The Corrupter##1482 |goto Desolace 52.24,53.44
step
Watch the dialogue
talk Maurin Bonesplitter##4498
accept The Corrupter##1484 |goto Desolace 52.25,53.44
step
talk Takata Steelblade##5641
turnin The Corrupter##1484 |goto Desolace 52.57,54.38
accept Alliance Relations##1436 |goto Desolace 52.57,54.38
step
click Sack of Meat##22245+
|tip Tan bags near buildings.
|tip Not all will be clickable.
|tip Avoid Magram Pack Runners walking with {o}2 hyena guards{}.
collect 6 Crudely Dried Meat##6069 |q 1370/1 |goto Desolace 70.90,75.30
|mapmarker Desolace/0 65.90,80.50
|mapmarker Desolace/0 69.20,77.20
|mapmarker Desolace/0 70.00,78.70
|mapmarker Desolace/0 72.40,78.40
|mapmarker Desolace/0 73.60,74.40
step
talk Uthek the Wise##5397
turnin Stealing Supplies##1370 |goto Desolace 36.23,79.25
accept Ongeku##1373 |goto Desolace 36.23,79.25
step
Follow the path into Shadowprey Village |goto Desolace 26.27,74.83 < 40 |only if walking and not subzone("Shadowprey Village")
talk Roon Wildmane##11877
accept Hunting in Stranglethorn##5763 |goto Desolace 25.05,72.28
step
talk Taiga Wisemane##11624
turnin Hand of Iruxos##5381 |goto Desolace 25.81,68.22
step
talk Drulzegar Skraghook##12340
turnin Other Fish to Fry##6143 |goto Desolace 23.32,72.87
step
talk Mai'Lahii##12031
|tip Inside the building.
turnin Clam Bait##6142 |goto Desolace 22.64,71.97
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1436
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 1436
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 1436
|only if Priest
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 1436
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 1436
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 1436
|only if Warlock
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 1436
|only if Shaman
step
talk Keldran##5640
|tip Walks around.
|tip Inside the building.
turnin Alliance Relations##1436 |goto Orgrimmar 22.56,52.63
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 5762
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 5762
|only if Hunter
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 5762
|only if Warrior
step
talk Karus##3309
|tip Collect from the bank.
|tip Inside the building.
collect Kravel's Crate##14542 |goto Orgrimmar 49.58,69.12 |q 5762
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale (36-37)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Dustwallow Marsh (37-38)",
},[[
step
talk Commander Aggro'gosh##2464
|tip Walks around.
accept The Defense of Grom'gol##568 |goto Stranglethorn Vale 32.17,28.90
step
talk Thysta##1387
fpath Grom'gol |goto Stranglethorn Vale 32.54,29.35
step
talk Nimboya##2497
accept Hunt for Yenniku##581 |goto Stranglethorn Vale 32.16,27.73
step
talk Kin'weelay##2519
accept Bloody Bone Necklaces##596 |goto Stranglethorn Vale 32.27,27.71
step
talk Uthok##1149
|tip Long questing session soon.
Buy Extra Ammo |vendor Uthok##1149 |goto Stranglethorn Vale/0 31.56,27.96 |q 5762
|only if Hunter
step
_NOTE:_
Save Green Hills of Stranglethorn Pages
|tip Save any you find.
|tip Store them in your bank for later.
|tip Sell duplicates on the Auction House.
|tip We'll buy missing ones later to complete quests.
Click Here to Continue |confirm |q 338 |future
step
Locate the Hunters' Camp |q 201/1 |goto Stranglethorn Vale 35.55,10.55
step
talk Hemet Nesingwary Jr.##715
turnin Hemet Nesingwary Jr.##5762 |goto Stranglethorn Vale 35.66,10.81
turnin Hunting in Stranglethorn##5763 |goto Stranglethorn Vale 35.66,10.81
step
talk Barnil Stonepot##716
accept Welcome to the Jungle##583 |goto Stranglethorn Vale 35.66,10.53
step
talk Hemet Nesingwary Jr.##715
turnin Welcome to the Jungle##583 |goto Stranglethorn Vale 35.66,10.81
accept Raptor Mastery##194 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
accept Tiger Mastery##185 |goto Stranglethorn Vale 35.61,10.62
step
talk Sir S. J. Erlgadin##718
accept Panther Mastery##190 |goto Stranglethorn Vale 35.55,10.55
step
_NOTE:_
Save Silk Cloth
|tip Start saving any you find.
|tip Need {o}15 Silk Cloth{} for future quest in Searing Gorge.
|tip Save them now to prevent grinding later.
Click Here to Continue |confirm |q 4449 |future
stickystart "Kill_Young_Panthers"
stickystart "Collect_Large_River_Crocolisk_Skins"
step
kill 10 Young Stranglethorn Tiger##681 |q 185/1 |goto Stranglethorn Vale 33.80,13.00
|mapmarker Stranglethorn Vale/0 30.40,7.40
|mapmarker Stranglethorn Vale/0 31.40,10.00
|mapmarker Stranglethorn Vale/0 33.40,10.80
|mapmarker Stranglethorn Vale/0 34.60,17.60
|mapmarker Stranglethorn Vale/0 35.20,15.00
|mapmarker Stranglethorn Vale/0 37.20,11.40
|mapmarker Stranglethorn Vale/0 37.20,14.20
step
talk Ajeck Rouack##717
turnin Tiger Mastery##185 |goto Stranglethorn Vale 35.61,10.62
accept Tiger Mastery##186 |goto Stranglethorn Vale 35.61,10.62
step
label "Kill_Young_Panthers"
kill 10 Young Panther##683 |q 190/1 |goto Stranglethorn Vale 40.00,10.00
|mapmarker Stranglethorn Vale/0 41.40,13.00
|mapmarker Stranglethorn Vale/0 41.20,8.20
|mapmarker Stranglethorn Vale/0 42.00,10.80
stickystop "Collect_Large_River_Crocolisk_Skins"
step
label "Collect_Liferoot_Warrior"
kill Kurzen Medicine Man##940+
|tip Share spawns with other Kurzen enemies.
collect 8 Liferoot##3357 |q 1712/1 |goto Stranglethorn Vale 44.00,11.80
|tip Needed for important class quest soon.
|tip Don't vendor them.
|mapmarker Stranglethorn Vale/0 43.40,9.00
|mapmarker Stranglethorn Vale/0 46.00,11.40
|mapmarker Stranglethorn Vale/0 46.40,9.40
|only if Warrior
step
kill Crystal Spine Basilisk##689+
|tip Skip once no more to kill.
|tip Can finish later.
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto Stranglethorn Vale/0 47.60,9.00
|mapmarker Stranglethorn Vale/0 46.60,5.80
|mapmarker Stranglethorn Vale/0 48.80,10.20
step
kill 10 Stranglethorn Tiger##682 |q 186/1 |goto Stranglethorn Vale/0 46.40,12.80
|mapmarker Stranglethorn Vale/0 42.80,15.00
|mapmarker Stranglethorn Vale/0 44.00,13.40
|mapmarker Stranglethorn Vale/0 46.00,15.20
|mapmarker Stranglethorn Vale/0 46.40,17.60
step
label "Collect_Large_River_Crocolisk_Skins"
kill River Crocolisk##1150+
|tip Along the river.
collect 2 Large River Crocolisk Skin##4053 |q 575/1 |goto Stranglethorn Vale/0 36.80,10.40
|mapmarker Stranglethorn Vale/0 32.40,8.80
|mapmarker Stranglethorn Vale/0 34.60,8.00
|mapmarker Stranglethorn Vale/0 34.60,10.40
|mapmarker Stranglethorn Vale/0 39.40,14.40
|mapmarker Stranglethorn Vale/0 40.60,12.20
step
talk Ajeck Rouack##717
turnin Tiger Mastery##186 |goto Stranglethorn Vale 35.61,10.62
accept Tiger Mastery##187 |goto Stranglethorn Vale 35.61,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##190 |goto Stranglethorn Vale 35.55,10.55
accept Panther Mastery##191 |goto Stranglethorn Vale 35.55,10.55
stickystart "Collect_Bloodscalp_Items"
step
kill 10 Elder Stranglethorn Tiger##1085 |q 187/1 |goto Stranglethorn Vale 31.40,14.20
|mapmarker Stranglethorn Vale/0 30.40,17.40
|mapmarker Stranglethorn Vale/0 31.40,19.80
|mapmarker Stranglethorn Vale/0 33.00,17.40
|mapmarker Stranglethorn Vale/0 35.00,19.00
stickystop "Collect_Bloodscalp_Items"
stickystart "Kill_Stranglethorn_Raptors"
step
kill 10 Panther##736 |q 191/1 |goto Stranglethorn Vale 28.20,16.40
|mapmarker Stranglethorn Vale/0 27.80,9.60
|mapmarker Stranglethorn Vale/0 28.20,12.00
|mapmarker Stranglethorn Vale/0 30.40,15.20
|mapmarker Stranglethorn Vale/0 29.40,8.20
|mapmarker Stranglethorn Vale/0 30.40,12.80
|mapmarker Stranglethorn Vale/0 30.40,10.60
step
label "Kill_Stranglethorn_Raptors"
kill 10 Stranglethorn Raptor##685 |q 194/1 |goto Stranglethorn Vale 27.40,14.40
|mapmarker Stranglethorn Vale/0 23.40,15.40
|mapmarker Stranglethorn Vale/0 25.60,16.00
|mapmarker Stranglethorn Vale/0 26.80,17.60
step
kill Crystal Spine Basilisk##689+
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto Stranglethorn Vale/0 24.00,17.60
|mapmarker Stranglethorn Vale/0 27.60,18.40
stickystart "Collect_Bloodscalp_Tusks_Warrior"
step
label "Collect_Bloodscalp_Items"
kill Bloodscalp Axe Thrower##694, Bloodscalp Beastmaster##699, Bloodscalp Berserker##597, Bloodscalp Headhunter##671, Bloodscalp Hunter##595, Bloodscalp Mystic##701, Bloodscalp Scavenger##702, Bloodscalp Scout##588, Bloodscalp Shaman##697, Bloodscalp Warrior##587, Bloodscalp Witch Doctor##660
|tip Trolls.
collect 9 Bloodscalp Tusk##3901 |q 581/1 |goto Stranglethorn Vale 28.80,19.20
collect 15 Bloodscalp Ear##1519 |q 189/1 |goto Stranglethorn Vale 28.80,19.20
collect 25 Bloody Bone Necklace##3915 |q 596/1 |goto Stranglethorn Vale 28.80,19.20
collect 15 Silk Cloth##4306 |goto Stranglethorn Vale 28.80,19.20 |q 4449 |future
|tip Needed for future quest.
|tip Don't vendor them.
|mapmarker Stranglethorn Vale/0 30.20,16.40
|mapmarker Stranglethorn Vale/0 30.80,19.00
|mapmarker Stranglethorn Vale/0 33.20,15.80
|mapmarker Stranglethorn Vale/0 33.40,13.80
|mapmarker Stranglethorn Vale/0 31.57,12.41
stickystop "Collect_Bloodscalp_Tusks_Warrior"
step
talk Hemet Nesingwary Jr.##715
turnin Raptor Mastery##194 |goto Stranglethorn Vale 35.66,10.81
accept Raptor Mastery##195 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
turnin Tiger Mastery##187 |goto Stranglethorn Vale 35.62,10.62
accept Tiger Mastery##188 |goto Stranglethorn Vale 35.62,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##191 |goto Stranglethorn Vale 35.55,10.55
accept Panther Mastery##192 |goto Stranglethorn Vale 35.55,10.55
step
kill Sin'Dall##729
|tip Orange tiger.
|tip Usually on top of the hill.
|tip Walks around.
collect Paw of Sin'Dall##3879 |q 188/1 |goto Stranglethorn Vale 32.21,17.39
|mapmarker Stranglethorn Vale/0 32.00,17.40
|mapmarker Stranglethorn Vale/0 32.60,17.20
|mapmarker Stranglethorn Vale/0 32.60,18.80
|mapmarker Stranglethorn Vale/0 32.80,18.00
step
kill 10 Lashtail Raptor##686 |q 195/1 |goto Stranglethorn Vale 32.20,20.40
kill 15 Lashtail Raptor##686 |q 568/1 |goto Stranglethorn Vale 32.20,20.40
|mapmarker Stranglethorn Vale/0 30.20,24.60
|mapmarker Stranglethorn Vale/0 30.40,21.40
|mapmarker Stranglethorn Vale/0 37.20,23.60
|mapmarker Stranglethorn Vale/0 32.40,23.00
|mapmarker Stranglethorn Vale/0 33.80,25.40
|mapmarker Stranglethorn Vale/0 35.00,27.60
|mapmarker Stranglethorn Vale/0 36.00,25.40
|mapmarker Stranglethorn Vale/0 37.40,19.80
|mapmarker Stranglethorn Vale/0 37.40,27.40
|mapmarker Stranglethorn Vale/0 38.80,21.40
|mapmarker Stranglethorn Vale/0 39.60,19.00
step
talk Nimboya##2497
turnin Hunt for Yenniku##581 |goto Stranglethorn Vale 32.16,27.72
accept Headhunting##582 |goto Stranglethorn Vale 32.16,27.72
step
talk Kin'weelay##2519
turnin Bloody Bone Necklaces##596 |goto Stranglethorn Vale/0 32.27,27.71
accept The Vile Reef##629 |goto Stranglethorn Vale 32.27,27.71
step
talk Commander Aggro'gosh##2464
|tip Walks around.
turnin The Defense of Grom'gol##568 |goto Stranglethorn Vale 32.17,28.91
accept The Defense of Grom'gol##569 |goto Stranglethorn Vale 32.17,28.91
step
click Gri'lek the Wanderer
|tip Avoid the {o}elite murlocs{}.
|tip Underwater.
collect Tablet Shard##4094 |q 629/1 |goto Stranglethorn Vale 24.75,22.84
stickystart "Collect_Bloodscalp_Tusks_Warrior"
step
kill Bloodscalp Headhunter##671+
collect 20 Shrunken Head##1532 |q 582/1 |goto Stranglethorn Vale 20.80,15.20
|mapmarker Stranglethorn Vale/0 19.20,12.20
|mapmarker Stranglethorn Vale/0 21.40,10.20
|mapmarker Stranglethorn Vale/0 22.60,8.40
|mapmarker Stranglethorn Vale/0 23.40,10.80
|mapmarker Stranglethorn Vale/0 24.60,9.00
step
label "Collect_Bloodscalp_Tusks_Warrior"
kill Bloodscalp Mystic##701, Bloodscalp Hunter##595, Bloodscalp Scout##588, Bloodscalp Beastmaster##699, Bloodscalp Berserker##597, Bloodscalp Witch Doctor##660, Bloodscalp Headhunter##671
collect 30 Bloodscalp Tusk##3901 |q 1712/2 |goto Stranglethorn Vale 23.40,10.80
|mapmarker Stranglethorn Vale/0 19.20,12.20
|mapmarker Stranglethorn Vale/0 21.40,10.20
|mapmarker Stranglethorn Vale/0 22.60,8.40
|mapmarker Stranglethorn Vale/0 22.40,13.20
|mapmarker Stranglethorn Vale/0 25.40,9.20
|mapmarker Stranglethorn Vale/0 25.40,13.60
|mapmarker Stranglethorn Vale/0 27.20,11.20
|mapmarker Stranglethorn Vale/0 29.40,12.20
|only if Warrior
step
talk Nimboya##2497
turnin Headhunting##582 |goto Stranglethorn Vale 32.16,27.73
step
_Destroy These Items:_
|tip Not needed.
trash Shrunken Head##1532
step
talk Kin'weelay##2519
turnin The Vile Reef##629 |goto Stranglethorn Vale 32.27,27.70
step
talk Far Seer Mok'thardin##2465
accept Mok'thardin's Enchantment##570 |goto Stranglethorn Vale 32.12,29.24
step
kill 5 Mosh'Ogg Witch Doctor##1144 |q 569/2 |goto Stranglethorn Vale 35.40,30.80
kill 10 Mosh'Ogg Brute##1142 |q 569/1 |goto Stranglethorn Vale 35.40,30.80
|mapmarker Stranglethorn Vale/0 37.00,28.40
|mapmarker Stranglethorn Vale/0 37.40,31.40
stickystart "Collect_Shadowmaw_Claws"
stickystart "Kill_Shadowmaw_Panthers"
step
kill Stranglethorn Tigress##772+
|tip Shared spawns with panthers.
|tip Shadowmaw Panthers are {o}stealthed{}.
collect Pristine Tigress Fang##3839|q 570/2 |goto Stranglethorn Vale 37.40,32.80
|mapmarker Stranglethorn Vale/0 35.00,36.80
|mapmarker Stranglethorn Vale/0 36.60,39.60
|mapmarker Stranglethorn Vale/0 37.20,45.40
|mapmarker Stranglethorn Vale/0 38.20,37.00
|mapmarker Stranglethorn Vale/0 39.40,42.40
|mapmarker Stranglethorn Vale/0 40.40,31.40
|mapmarker Stranglethorn Vale/0 41.20,34.80
|mapmarker Stranglethorn Vale/0 41.20,38.20
|mapmarker Stranglethorn Vale/0 45.60,25.00
|mapmarker Stranglethorn Vale/0 46.40,22.00
|mapmarker Stranglethorn Vale/0 47.00,27.80
|mapmarker Stranglethorn Vale/0 49.20,20.00
|mapmarker Stranglethorn Vale/0 49.20,23.20
step
label "Collect_Shadowmaw_Claws"
kill Shadowmaw Panther##684+
|tip Stealthed. |notinsticky
|tip Shared spawns with tigers. |notinsticky
collect 8 Shadowmaw Claw##3838 |q 570/1 |goto Stranglethorn Vale 37.40,32.80
|mapmarker Stranglethorn Vale/0 35.00,36.80
|mapmarker Stranglethorn Vale/0 36.60,39.60
|mapmarker Stranglethorn Vale/0 37.20,45.40
|mapmarker Stranglethorn Vale/0 38.20,37.00
|mapmarker Stranglethorn Vale/0 39.40,42.40
|mapmarker Stranglethorn Vale/0 40.40,31.40
|mapmarker Stranglethorn Vale/0 41.20,34.80
|mapmarker Stranglethorn Vale/0 41.20,38.20
|mapmarker Stranglethorn Vale/0 45.60,25.00
|mapmarker Stranglethorn Vale/0 46.40,22.00
|mapmarker Stranglethorn Vale/0 47.00,27.80
|mapmarker Stranglethorn Vale/0 49.20,20.00
|mapmarker Stranglethorn Vale/0 49.20,23.20
step
label "Kill_Shadowmaw_Panthers"
kill 10 Shadowmaw Panther##684 |q 192/1 |goto Stranglethorn Vale 37.40,32.80
|tip Stealthed. |notinsticky
|mapmarker Stranglethorn Vale/0 35.00,36.80
|mapmarker Stranglethorn Vale/0 36.60,39.60
|mapmarker Stranglethorn Vale/0 37.20,45.40
|mapmarker Stranglethorn Vale/0 38.20,37.00
|mapmarker Stranglethorn Vale/0 39.40,42.40
|mapmarker Stranglethorn Vale/0 40.40,31.40
|mapmarker Stranglethorn Vale/0 41.20,34.80
|mapmarker Stranglethorn Vale/0 41.20,38.20
|mapmarker Stranglethorn Vale/0 45.60,25.00
|mapmarker Stranglethorn Vale/0 46.40,22.00
|mapmarker Stranglethorn Vale/0 47.00,27.80
|mapmarker Stranglethorn Vale/0 49.20,20.00
|mapmarker Stranglethorn Vale/0 49.20,23.20
stickystart "Collect_Tumbled_Crystals"
step
kill Foreman Cozzle##4723
|tip Top of the platform.
|tip Inside the building.
collect Cozzle's Key##5851 |goto Stranglethorn Vale 42.65,18.35 |q 1182
step
click Cozzle's Footlocker
|tip Inside the building.
collect Fuel Regulator Blueprints##5852 |q 1182/1 |goto Stranglethorn Vale 43.34,20.34
step
label "Collect_Tumbled_Crystals"
kill Venture Co. Geologist##1096+
collect 8 Tumbled Crystal##4106 |q 213/1 |goto Stranglethorn Vale/0 44.20,20.20
|mapmarker Stranglethorn Vale/0 42.40,18.40
|mapmarker Stranglethorn Vale/0 42.40,22.00
|mapmarker Stranglethorn Vale/0 43.40,16.20
|mapmarker Stranglethorn Vale/0 44.40,23.60
|mapmarker Stranglethorn Vale/0 45.20,18.00
|mapmarker Stranglethorn Vale/0 46.00,21.80
|mapmarker Stranglethorn Vale/0 47.60,19.00
step
talk Hemet Nesingwary Jr.##715
turnin Raptor Mastery##195 |goto Stranglethorn Vale 35.66,10.81
accept Raptor Mastery##196 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
turnin Tiger Mastery##188 |goto Stranglethorn Vale 35.62,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##192 |goto Stranglethorn Vale 35.56,10.55
accept Panther Mastery##193 |goto Stranglethorn Vale 35.56,10.55
step
talk Nimboya##2497
accept Trollbane##638 |goto Stranglethorn Vale 32.16,27.73
step
talk Commander Aggro'gosh##2464
|tip Walks around.
turnin The Defense of Grom'gol##569 |goto Stranglethorn Vale 32.17,28.90
step
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##570 |goto Stranglethorn Vale 32.12,29.24
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
turnin Goblin Sponsorship##1182 |goto Stranglethorn Vale 27.23,76.87
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
turnin Bloodscalp Ears##189 |goto Stranglethorn Vale 27.00,77.13
turnin Hostile Takeover##213 |goto Stranglethorn Vale 27.00,77.13
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
turnin Investigate the Camp##201 |goto Stranglethorn Vale 26.94,77.21
step
talk Crank Fizzlebub##2498
|tip {o}Bottom floor{} inside the building
turnin Singing Blue Shards##605 |goto Stranglethorn Vale 27.12,77.21
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
turnin Supply and Demand##575 |goto Stranglethorn Vale 28.29,77.59
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Dustwallow Marsh (37-38)",{
image=ZGV.IMAGESDIR.."Dustwallow Marsh",
hardcore = true,
next="Leveling Guides\\Alterac Mountains & Arathi Highlands (38-39)",
},[[
step
talk Auctioneer Thathung##8673
|tip Buy from the Auction House, if possible.
collect Moonsteel Broadsword##3853 |goto Orgrimmar 55.69,62.86 |q 1203 |future
|tip Needed for quest soon.
|only if level <= 40
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Silk Cloth##4306 |complete (C_Item.GetItemCount(4306,true) - C_Item.GetItemCount(4306))>=15 |goto Orgrimmar/0 49.59,69.12 |q 4449 |future
bank Green Hills of Stranglethorn - Page 1##2725 |goto Orgrimmar/0 49.59,69.12 |q 339 |future |only if itemcount(2725) > 0
bank Green Hills of Stranglethorn - Page 4##2728 |goto Orgrimmar/0 49.59,69.12 |q 339 |future |only if itemcount(2728) > 0
bank Green Hills of Stranglethorn - Page 6##2730 |goto Orgrimmar/0 49.59,69.12 |q 339 |future |only if itemcount(2730) > 0
bank Green Hills of Stranglethorn - Page 8##2732 |goto Orgrimmar/0 49.59,69.12 |q 339 |future |only if itemcount(2732) > 0
bank Green Hills of Stranglethorn - Page 10##2734 |goto Orgrimmar/0 49.59,69.12 |q 340 |future |only if itemcount(2734) > 0
bank Green Hills of Stranglethorn - Page 11##2735 |goto Orgrimmar/0 49.59,69.12 |q 340 |future |only if itemcount(2735) > 0
bank Green Hills of Stranglethorn - Page 14##2738 |goto Orgrimmar/0 49.59,69.12 |q 340 |future |only if itemcount(2738) > 0
bank Green Hills of Stranglethorn - Page 16##2740 |goto Orgrimmar/0 49.59,69.12 |q 340 |future |only if itemcount(2740) > 0
bank Green Hills of Stranglethorn - Page 18##2742 |goto Orgrimmar/0 49.59,69.12 |q 341 |future |only if itemcount(2742) > 0
bank Green Hills of Stranglethorn - Page 20##2744 |goto Orgrimmar/0 49.59,69.12 |q 341 |future |only if itemcount(2744) > 0
bank Green Hills of Stranglethorn - Page 21##2745 |goto Orgrimmar/0 49.59,69.12 |q 341 |future |only if itemcount(2745) > 0
bank Green Hills of Stranglethorn - Page 24##2748 |goto Orgrimmar/0 49.59,69.12 |q 341 |future |only if itemcount(2748) > 0
bank Green Hills of Stranglethorn - Page 25##2749 |goto Orgrimmar/0 49.59,69.12 |q 342 |future |only if itemcount(2749) > 0
bank Green Hills of Stranglethorn - Page 26##2750 |goto Orgrimmar/0 49.59,69.12 |q 342 |future |only if itemcount(2750) > 0
bank Green Hills of Stranglethorn - Page 27##2751 |goto Orgrimmar/0 49.59,69.12 |q 342 |future |only if itemcount(2751) > 0
step
Run up the stairs |goto Orgrimmar/0 56.35,56.89 < 15 |only if walking
talk Xen'to##3400
|tip Inside the building.
buy 3 Soothing Spices##3713 |goto Orgrimmar/0 57.57,52.89 |q 1218 |future
|tip Don't vendor them.
step
talk Trak'gen##3313
|tip Long questing session soon.
|tip No ammo vendor available.
|tip Inside the building.
Buy Extra Ammo |vendor Trak'gen##3313 |goto Orgrimmar/0 48.13,80.52 |q 1201 |future
|only if Hunter
step
_NOTE:_
Optional Dungeon Later
|tip Can run {o}Scarlet Monastery{} dungeon later.
|tip Slower leveling, but potential gear upgrades.
|tip We'll pick up dungeon quests.
|tip Guide will say when it's time to run the dungeon.
Click Here to Run {y}Scarlet Monastery{} Dungeon Later |confirm SMflag |multiq 1048,1051	|future		|only if Scourge
Click Here to Run {y}Scarlet Monastery{} Dungeon Later |confirm SMflag |multiq 1049,1048,1051	|future		|only if not Scourge
|tip Skip if you'd rather grind.
step
talk Nazeer Bloodpike##4791
accept Theramore Spies##1201 |goto Dustwallow Marsh 35.21,30.66
step
click Hoofprints##21015
accept Suspicious Hoofprints##1268 |goto Dustwallow Marsh 29.70,47.63
step
click Theramore Guard Badge
|tip Tiny metal object.
accept Lieutenant Paval Reethe##1269 |goto Dustwallow Marsh 29.83,48.24
step
click Black Shield
accept The Black Shield##1251 |goto Dustwallow Marsh 29.63,48.59
step
talk Mudcrush Durtfeet##4503
accept Hungry!##1177 |goto Dustwallow Marsh 35.15,38.25
step
talk Krog##4926
turnin Suspicious Hoofprints##1268 |goto Dustwallow Marsh 36.42,31.88
turnin Lieutenant Paval Reethe##1269 |goto Dustwallow Marsh 36.42,31.88
turnin The Black Shield##1251 |goto Dustwallow Marsh 36.42,31.88
accept The Black Shield##1321 |goto Dustwallow Marsh 36.42,31.88
step
talk Do'gol##5087
turnin The Black Shield##1321 |goto Dustwallow Marsh 36.53,30.80
accept The Black Shield##1322 |goto Dustwallow Marsh 36.53,30.80
stickystart "Collect_Acidic_Venom_Sacs"
step
kill 9 Theramore Infiltrator##4834 |q 1201/1 |goto Dustwallow Marsh/0 38.00,33.40
|tip Stealthed.
|mapmarker Dustwallow Marsh/0 36.40,35.40
|mapmarker Dustwallow Marsh/0 37.00,38.40
|mapmarker Dustwallow Marsh/0 37.40,27.00
|mapmarker Dustwallow Marsh/0 38.00,23.60
|mapmarker Dustwallow Marsh/0 38.00,33.40
|mapmarker Dustwallow Marsh/0 38.80,22.60
|mapmarker Dustwallow Marsh/0 40.40,33.40
|mapmarker Dustwallow Marsh/0 40.40,35.20
|mapmarker Dustwallow Marsh/0 41.60,25.40
|mapmarker Dustwallow Marsh/0 42.80,31.20
|mapmarker Dustwallow Marsh/0 44.00,27.20
|mapmarker Dustwallow Marsh/0 37.95,37.53
step
talk "Stinky" Ignatz##4880
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Kill nearby raptors first.
accept Stinky's Escape##1270 |goto Dustwallow Marsh 46.88,17.52 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect "Stinky" Ignatz.
Help Stinky Find Bogbean Leaves |q 1270/1 |goto Dustwallow Marsh 48.86,24.65
step
talk "Swamp Eye" Jarl##4792
accept Soothing Spices##1218 |goto Dustwallow Marsh/0 55.44,26.27
step
talk "Swamp Eye" Jarl##4792
turnin Soothing Spices##1218 |goto Dustwallow Marsh/0 55.44,26.27
step
click Loose Dirt
accept The Lost Report##1238 |goto Dustwallow Marsh/0 55.44,25.93
step
kill Mirefin Coastrunner##4362, Mirefin Murloc##4359, Mirefin Muckdweller##4361, Mirefin Puddlejumper##4358, Mirefin Warrior##4360, Mirefin Oracle##4363
|tip Murlocs.
collect 12 Mirefin Head##5847 |q 1177/1 |goto Dustwallow Marsh 57.83,21.37
|mapmarker Dustwallow Marsh/0 53.40,15.80
|mapmarker Dustwallow Marsh/0 54.00,12.20
|mapmarker Dustwallow Marsh/0 55.80,20.40
|mapmarker Dustwallow Marsh/0 58.60,17.60
|mapmarker Dustwallow Marsh/0 59.00,15.40
|mapmarker Dustwallow Marsh/0 59.40,9.80
|mapmarker Dustwallow Marsh/0 62.80,8.00
|mapmarker Dustwallow Marsh/0 63.40,17.60
|mapmarker Dustwallow Marsh/0 63.80,28.00
step
talk "Swamp Eye" Jarl##4792
accept Jarl Needs Eyes##1206 |goto Dustwallow Marsh 55.44,26.27
step
_NOTE:_
Begin Finding a Dungeon Group
|tip Good time to run {o}Scarlet Monastery{} dungeon soon.
|tip Start looking for a group.
Click Here to Continue |confirm |multiq 1048		|future		|only if Scourge
Click Here to Continue |confirm |multiq 1049,1048	|future		|only if not Scourge
|only if guideflag("SMflag")
step
label "Collect_Acidic_Venom_Sacs"
kill Darkfang Spider##4413, Darkfang Lurker##4411
|tip Orange spiders.
|tip Careful, {o}Darkfang Lurkers{} are stealthed.
collect 6 Acidic Venom Sac##5959 |q 1322/1 |goto Dustwallow Marsh/0 51.60,25.20
|mapmarker Dustwallow Marsh/0 35.80,15.00
|mapmarker Dustwallow Marsh/0 37.00,12.20
|mapmarker Dustwallow Marsh/0 37.40,25.80
|mapmarker Dustwallow Marsh/0 38.00,18.60
|mapmarker Dustwallow Marsh/0 39.20,14.40
|mapmarker Dustwallow Marsh/0 39.40,22.40
|mapmarker Dustwallow Marsh/0 41.00,25.60
|mapmarker Dustwallow Marsh/0 41.20,17.40
|mapmarker Dustwallow Marsh/0 41.60,11.40
|mapmarker Dustwallow Marsh/0 43.20,23.40
|mapmarker Dustwallow Marsh/0 44.20,15.40
|mapmarker Dustwallow Marsh/0 44.80,28.60
|mapmarker Dustwallow Marsh/0 47.80,25.40
|mapmarker Dustwallow Marsh/0 49.40,28.40
|mapmarker Dustwallow Marsh/0 51.00,21.40
|mapmarker Dustwallow Marsh/0 51.20,15.40
|mapmarker Dustwallow Marsh/0 51.80,32.20
|mapmarker Dustwallow Marsh/0 54.60,21.60
|mapmarker Dustwallow Marsh/0 56.00,30.60
|mapmarker Dustwallow Marsh/0 57.40,27.60
|mapmarker Dustwallow Marsh/0 57.40,34.20
|mapmarker Dustwallow Marsh/0 57.40,37.60
|mapmarker Dustwallow Marsh/0 59.60,23.60
|mapmarker Dustwallow Marsh/0 60.20,29.40
|mapmarker Dustwallow Marsh/0 61.40,36.60
|mapmarker Dustwallow Marsh/0 63.20,40.20
step
kill Darkmist Silkspinner##4379, Darkmist Spider##4376, Darkmist Widow##4380, Darkmist Recluse##4378
|tip Spiders.
|tip Inside and outside the mine.
collect 40 Unpopped Darkmist Eye##5884 |q 1206/1 |goto Dustwallow Marsh 33.22,22.76
|mapmarker Dustwallow Marsh/0 30.40,21.80
|mapmarker Dustwallow Marsh/0 33.40,20.40
|mapmarker Dustwallow Marsh/0 34.40,25.60
|mapmarker Dustwallow Marsh/0 35.60,20.80
step
Leave the mine |goto Dustwallow Marsh 33.22,22.76 < 15 |walk |only if subzone("Darkmist Cavern") and indoors()
talk Nazeer Bloodpike##4791
turnin Theramore Spies##1201 |goto Dustwallow Marsh 35.21,30.66
accept The Theramore Docks##1202 |goto Dustwallow Marsh/0 35.21,30.66 |only if not hardcore()
turnin The Lost Report##1238 |goto Dustwallow Marsh 35.21,30.66
step
talk Do'gol##5087
turnin The Black Shield##1322 |goto Dustwallow Marsh 36.53,30.80
accept The Black Shield##1323 |goto Dustwallow Marsh 36.53,30.80
step
talk Krog##4926
turnin The Black Shield##1323 |goto Dustwallow Marsh 36.42,31.88
step
talk Ogron##4983
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept Questioning Reethe##1273 |goto Dustwallow Marsh 40.96,36.69 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Ogron.
Kill the enemies that attack
|tip Group of 4 enemies.
|tip Let Ogron tank some of them.
|tip Ogron {o}must survive{}.
|tip May need help.
Question Reethe with Ogron |q 1273/1 |goto Dustwallow Marsh 42.65,38.07
step
talk Mudcrush Durtfeet##4503
turnin Hungry!##1177 |goto Dustwallow Marsh 35.15,38.25
step
talk Krog##4926
turnin Questioning Reethe##1273 |goto Dustwallow Marsh 36.42,31.88
accept The Black Shield##1276 |goto Dustwallow Marsh 36.42,31.88
step
talk "Swamp Eye" Jarl##4792
turnin Jarl Needs Eyes##1206 |goto Dustwallow Marsh 55.43,26.27
accept Jarl Needs a Blade##1203 |goto Dustwallow Marsh 55.44,26.27 |only if itemcount(3853) > 0
step
talk "Swamp Eye" Jarl##4792
turnin Jarl Needs a Blade##1203 |goto Dustwallow Marsh 55.44,26.27
|only if itemcount(3853) > 0
step
_Destroy These Items:_
|tip Not needed.
trash Unpopped Darkmist Eye##5884
step
click Loose Dirt
accept The Severed Head##1239 |goto Dustwallow Marsh 55.44,25.93
step
click Captain's Footlocker##20925
|tip Avoid {o}Theramore Isle{}.
|tip Underwater.
collect Captain's Documents##5882 |q 1202/1 |goto Dustwallow Marsh 71.53,51.18
|only if not hardcore()
step
Drown Yourself
|tip Fast travel.
Die on Purpose |complete isdead |goto Dustwallow Marsh 71.53,51.18 |q 1202
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Dustwallow Marsh/0 39.70,30.77 |q 1202 |zombiewalk
|only if not hardcore()
step
talk Nazeer Bloodpike##4791
turnin The Theramore Docks##1202 |goto Dustwallow Marsh/0 35.21,30.66 |only if not hardcore()
turnin The Severed Head##1239 |goto Dustwallow Marsh/0 35.21,30.66
accept The Troll Witchdoctor##1240 |goto Dustwallow Marsh/0 35.21,30.66
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 232 |future
|only if Druid
step
talk Sage Truthseeker##3978
|tip Inside the building.
accept Compendium of the Fallen##1049 |goto Thunder Bluff 34.40,46.87
|only if guideflag("SMflag") and not Scourge
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 232 |future
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 232 |future
|only if Priest
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 232 |future
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 232 |future
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 232 |future
|only if Warlock
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 232 |future
|only if Shaman
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 232 |future
|only if Hunter
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 232 |future
|only if Warrior
step
Follow the path down |goto Undercity 52.20,64.31 < 15 |only if walking
talk Varimathras##2425
accept Into The Scarlet Monastery##1048 |goto Undercity 56.25,92.20
|only if guideflag("SMflag")
step
_NOTE:_
Starting Dungeon Run
|tip Running {o}Scarlet Monastery{} dungeon now.
|tip We will do {o}Library{}, {o}Armory{}, and {o}Cathedral{} sections.
|tip Meet with your dungeon group.
Click Here to Continue |confirm |multiq 1048		|future		|only if Scourge
Click Here to Continue |confirm |multiq 1049,1048	|future		|only if not Scourge
|only if guideflag("SMflag")
step
Enter the Scarlet Monastery {y}Library{} Dungeon |complete zone("Scarlet Monastery") |multiq 1048	|future		|only if Scourge
Enter the Scarlet Monastery {y}Library{} Dungeon |complete zone("Scarlet Monastery") |multiq 1049,1048	|future		|only if not Scourge
|tip Follow your group.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Library{} section.
kill Houndmaster Loksey##3974 |q 1048/4
|tip First boss.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Library{} section.
click Compendium of the Fallen##19283
|tip Black book on {o}bottom shelf{} of a bookshelf.
|tip Same room as Arcanist Doan.
collect Compendium of the Fallen##5535 |q 1049/1
|only if guideflag("SMflag") and not Scourge
step
Leave the Scarlet Monastery {y}Library{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1048		|future		|only if Scourge
Leave the Scarlet Monastery {y}Library{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1049,1048	|future		|only if not Scourge
|tip Follow your group.
|only if guideflag("SMflag")
step
Enter the Scarlet Monastery {y}Armory{} Dungeon |complete zone("Scarlet Monastery") |multiq 1048	|future		|only if Scourge
Enter the Scarlet Monastery {y}Armory{} Dungeon |complete zone("Scarlet Monastery") |multiq 1049,1048	|future		|only if not Scourge
|tip Follow your group.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Armory{} section.
kill Herod##3975 |q 1048/3
|tip Final boss.
|only if guideflag("SMflag")
step
Leave the Scarlet Monastery {y}Armory{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1048		|future		|only if Scourge
Leave the Scarlet Monastery {y}Armory{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1049,1048	|future		|only if not Scourge
|tip Follow your group.
|only if guideflag("SMflag")
step
Enter the Scarlet Monastery {y}Cathedral{} Dungeon |complete zone("Scarlet Monastery") |multiq 1048		|future		|only if Scourge
Enter the Scarlet Monastery {y}Cathedral{} Dungeon |complete zone("Scarlet Monastery") |multiq 1049,1048	|future		|only if not Scourge
|tip Follow your group.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Cathedral{} section.
kill Scarlet Commander Mograine##3976 |q 1048/2
kill High Inquisitor Whitemane##3977 |q 1048/1
|tip Final boss.
|only if guideflag("SMflag")
step
Leave the Scarlet Monastery {y}Cathedral{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1048		|future		|only if Scourge
Leave the Scarlet Monastery {y}Cathedral{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1049,1048	|future		|only if not Scourge
|tip Follow your group.
|only if guideflag("SMflag")
step
Follow the path down |goto Undercity 52.20,64.31 < 15 |only if walking
talk Varimathras##2425
turnin Into The Scarlet Monastery##1048 |goto Undercity 56.25,92.20
|only if guideflag("SMflag")
step
Follow the path down |goto Undercity 52.86,77.57 < 10 |walk
talk Apothecary Zinge##5204
accept Errand for Apothecary Zinge##232 |goto Undercity 50.13,67.99
step
Follow the path up |goto Undercity 47.90,76.49 < 10 |walk
talk Alessandro Luca##7683
turnin Errand for Apothecary Zinge##232 |goto Undercity 58.62,54.67
accept Errand for Apothecary Zinge##238 |goto Undercity 58.62,54.67
step
Follow the path down |goto Undercity 52.86,77.57 < 10 |walk
talk Apothecary Zinge##5204
turnin Errand for Apothecary Zinge##238 |goto Undercity 50.13,67.99
accept Into the Field##243 |goto Undercity 50.13,67.99
step
talk Auctioneer Naxxremis##15683
|tip Buy from the Auction House, if possible.
|tip Needed for your Whirlwind weapon class quest.
collect 8 Thundering Charm##4480 |goto Undercity 64.39,35.82 |q 1714 |future
collect 8 Burning Charm##4479 |goto Undercity 64.39,35.82 |q 1714 |future
collect 8 Cresting Charm##4481 |goto Undercity 64.39,35.82 |q 1714 |future
collect 2 Nature Protection Potion##6052 |goto Undercity 64.39,35.82 |q 1713 |future
|only if Warrior
step
talk Auctioneer Redmuse##8720
|tip Buy from the Auction House, if possible.
|tip Needed for easy quest turnins in Badlands soon.
|tip Inside the building.
collect 9 Blue Pearl##4611			|goto Undercity 64.39,35.82 |q 705 |future
collect Frost Oil##3829				|goto Undercity 64.39,35.82 |q 713 |future
collect Gyrochronatom##4389			|goto Undercity 64.39,35.82 |q 714 |future
collect Healing Potion##929			|goto Undercity 64.39,35.82 |q 715 |future
collect Lesser Invisibility Potion##3823	|goto Undercity 64.39,35.82 |q 715 |future
|only if level <= 45
step
talk Randolph Montague##2458
|tip Collect from the bank.
collect Fizzle Brassbolts' Letter##5827 |goto Undercity/0 65.93,43.46 |q 1106
step
talk Randolph Montague##2458
|tip Deposit into the bank.
bank Blackened Iron Shield##5919 |goto Undercity/0 65.93,43.46 |q 1276
bank Field Testing Kit##8523 |goto Undercity/0 65.93,43.46 |q 243
step
kill Cresting Exile##2761+
collect 8 Cresting Charm##4481 |goto Arathi Highlands 66.20,31.60 |q 1714 |future
|mapmarker Arathi Highlands/0 65.00,27.40
|mapmarker Arathi Highlands/0 65.20,29.80
|mapmarker Arathi Highlands/0 67.20,28.40
|mapmarker Arathi Highlands/0 68.60,30.60
|only if Warrior
step
kill Thundering Exile##2762+
collect 8 Thundering Charm##4480 |goto Arathi Highlands 52.20,52.60 |q 1714 |future
|mapmarker Arathi Highlands/0 50.40,50.40
|mapmarker Arathi Highlands/0 52.40,47.40
|mapmarker Arathi Highlands/0 53.60,49.20
|only if Warrior
step
kill Burning Exile##2760+
|tip Avoid Refuge Point.
collect 8 Burning Charm##4479 |goto Arathi Highlands 24.40,30.40 |q 1714 |future
|mapmarker Arathi Highlands/0 24.40,28.40
|mapmarker Arathi Highlands/0 24.40,32.40
|mapmarker Arathi Highlands/0 26.40,28.60
|mapmarker Arathi Highlands/0 26.40,30.80
|only if Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Alterac Mountains & Arathi Highlands (38-39)",{
image=ZGV.IMAGESDIR.."Arathi Highlands",
hardcore = true,
next="Leveling Guides\\Badlands (39-40)",
},[[
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
accept Dalaran Patrols##545 |goto Hillsbrad Foothills 61.60,20.84
step
use Nature Protection Potion##6052
|tip Killing a level 40 elite enemy soon.
|tip Use another Nature Protection Potion during the fight.
|tip Using one potion now so the cooldown is finished by then.
Click Here to Continue |confirm |q 1713 |future
|only if Warrior and itemcount(6052) > 0
step
talk Keeper Bel'varil##2437
|tip Inside the building.
accept Bracers of Binding##557 |goto Hillsbrad Foothills 61.50,20.94
step
click WANTED
|tip Wanted poster.
accept WANTED: Baron Vardus##566 |goto Hillsbrad Foothills 62.62,20.74
step
talk Krusk##2229
|tip Inside the building.
accept Gol'dir##503 |goto Hillsbrad Foothills 63.24,20.66
step
click Bah'rah's Cauldron
|tip Follow the river north.
|tip Complete the {o}Essence of the Exile{} quest.
collect Essence of the Exile##6851 |q 1712/3 |goto Alterac Mountains 79.32,66.81
|only if Warrior
step
talk Bath'rah the Windwatcher##6176
|tip Inside the building.
turnin Cyclonian##1712 |goto Alterac Mountains 80.50,66.92
accept The Summoning##1713 |goto Alterac Mountains 80.50,66.92 |noautoaccept
|tip Make sure your {o}Nature Protection Potion{} cooldown is finished.
|only if Warrior
step
Watch the dialogue
|tip Follow Bath'rah the Windwatcher.
|tip Summons Cyclonian.
kill Cyclonian##6239
|tip Level 40 elite.
|tip Use the other {o}Nature Protection Potion{} when the first wears off. |only if itemcount(6052) > 0
|tip May need help.
collect Whirlwind Heart##6894 |q 1713/1 |goto Alterac Mountains 80.60,62.52
|only if Warrior
step
talk Bath'rah the Windwatcher##6176
|tip Inside the building.
turnin The Summoning##1713 |goto Alterac Mountains 80.50,66.92
accept Whirlwind Weapon##1792 |goto Alterac Mountains 80.50,66.92 |instant
|only if Warrior
step
_Destroy This Item:_
|tip Not needed.
trash Bath'rah's Parchment##6929
|only if Warrior
step
kill Hulking Mountain Lion##2407, Starving Mountain Lion##2384, Mountain Lion##2406, Feral Mountain Lion##2385
collect Fresh Carcass##5810 |goto Alterac Mountains 48.40,75.00 |q 1136
|mapmarker Alterac Mountains/0 42.20,76.80
|mapmarker Alterac Mountains/0 42.40,80.40
|mapmarker Alterac Mountains/0 44.40,76.40
|mapmarker Alterac Mountains/0 44.60,79.00
|mapmarker Alterac Mountains/0 46.60,76.60
step
use Fresh Carcass##5810
|tip Inside the small cave.
kill Frostmaw##4504
|tip Walks to cave entrance.
collect Frostmaw's Mane##5811 |q 1136/1 |goto Alterac Mountains 37.54,66.26
step
kill Jailor Borhuin##2431
|tip Multiple locations.
|tip Inside the building.
|tip Also check upstairs.
collect Rusted Iron Key##3704 |q 503/1 |goto Alterac Mountains 63.13,43.47
|mapmarker Alterac Mountains/0 62.70,40.12
|mapmarker Alterac Mountains/0 60.62,43.87
step
Find Where Gol'dir is Being Held |q 503/2 |goto Alterac Mountains 60.19,43.91
|tip Upstairs inside the building.
step
talk Gol'dir##2316
|tip Upstairs inside the building.
turnin Gol'dir##503 |goto Alterac Mountains 59.96,43.74
accept Blackmoore's Legacy##506 |goto Alterac Mountains 59.96,43.74
step
kill Baron Vardus##2306
|tip Downstairs inside the building.
|tip Skip if missing.
|tip Can finish later.
collect Head of Baron Vardus##3626 |q 566/1 |goto Alterac Mountains 60.30,43.21
step
talk Krusk##2229
|tip Inside the building.
turnin Blackmoore's Legacy##506 |goto Hillsbrad Foothills 63.24,20.66
accept Lord Aliden Perenolde##507 |goto Hillsbrad Foothills 63.24,20.66
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin WANTED: Baron Vardus##566 |goto Hillsbrad Foothills 62.33,20.45
|only if readyq(566)
stickystart "Kill_Dalaran_Summoners_And_Elemental_Slavers"
step
Run up the ramp and jump over the wall |goto Alterac Mountains 38.89,39.43 < 10 |only if walking and subzone("Ruins of Alterac")
kill Elemental Slave##2359+
collect 4 Bracers of Earth Binding##3715 |q 557/1 |goto Alterac Mountains 20.60,76.40
|mapmarker Alterac Mountains/0 9.80,78.20
|mapmarker Alterac Mountains/0 11.20,75.00
|mapmarker Alterac Mountains/0 11.80,80.60
|mapmarker Alterac Mountains/0 13.00,77.60
|mapmarker Alterac Mountains/0 15.20,80.60
|mapmarker Alterac Mountains/0 16.00,75.40
|mapmarker Alterac Mountains/0 17.80,78.60
|mapmarker Alterac Mountains/0 18.20,58.00
|mapmarker Alterac Mountains/0 18.40,54.40
|mapmarker Alterac Mountains/0 18.40,73.40
|mapmarker Alterac Mountains/0 20.40,61.20
|mapmarker Alterac Mountains/0 20.60,70.80
|mapmarker Alterac Mountains/0 23.20,59.20
|mapmarker Alterac Mountains/0 21.20,56.40
|mapmarker Alterac Mountains/0 21.40,65.00
|mapmarker Alterac Mountains/0 21.80,53.20
|mapmarker Alterac Mountains/0 23.60,62.20
step
label "Kill_Dalaran_Summoners_And_Elemental_Slavers"
kill 6 Dalaran Summoner##2358 |q 545/1 |goto Alterac Mountains 20.60,76.40
kill 12 Elemental Slave##2359 |q 545/2 |goto Alterac Mountains 20.60,76.40
|mapmarker Alterac Mountains/0 9.80,78.20
|mapmarker Alterac Mountains/0 11.20,75.00
|mapmarker Alterac Mountains/0 11.80,80.60
|mapmarker Alterac Mountains/0 13.00,77.60
|mapmarker Alterac Mountains/0 15.20,80.60
|mapmarker Alterac Mountains/0 16.00,75.40
|mapmarker Alterac Mountains/0 17.80,78.60
|mapmarker Alterac Mountains/0 18.20,58.00
|mapmarker Alterac Mountains/0 18.40,54.40
|mapmarker Alterac Mountains/0 18.40,73.40
|mapmarker Alterac Mountains/0 20.40,61.20
|mapmarker Alterac Mountains/0 20.60,70.80
|mapmarker Alterac Mountains/0 23.20,59.20
|mapmarker Alterac Mountains/0 21.20,56.40
|mapmarker Alterac Mountains/0 21.40,65.00
|mapmarker Alterac Mountains/0 21.80,53.20
|mapmarker Alterac Mountains/0 23.60,62.20
step
kill Lord Aliden Perenolde##2423 |q 507/1 |goto Alterac Mountains 39.32,14.58
|tip Upstairs inside the building.
|tip Careful, stealthed enemies.
step
talk Elysa##2317
|tip Upstairs inside the building.
turnin Lord Aliden Perenolde##507 |goto Alterac Mountains 39.30,14.31
accept Taretha's Gift##508 |goto Alterac Mountains 39.30,14.31
step
kill Baron Vardus##2306
|tip Multiple locations.
|tip Downstairs inside the building in {o}Strahnbrad{} location.
collect Head of Baron Vardus##3626 |q 566/1 |goto Alterac Mountains 47.40,17.00
|mapmarker Alterac Mountains/0 53.40,20.40
|mapmarker Alterac Mountains/0 56.00,26.20
|mapmarker Alterac Mountains/0 58.20,29.40
|mapmarker Alterac Mountains/0 60.20,43.40
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
turnin Dalaran Patrols##545 |goto Hillsbrad Foothills 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
turnin Bracers of Binding##557 |goto Hillsbrad Foothills 61.50,20.94
step
talk High Executor Darthalia##2215
|tip Walks around.
turnin WANTED: Baron Vardus##566 |goto Hillsbrad Foothills 62.33,20.45
step
talk Krusk##2229
|tip Inside the building.
turnin Taretha's Gift##508 |goto Hillsbrad Foothills 63.24,20.66
step
talk Zengu##2703
turnin Trollbane##638 |goto Arathi Highlands 73.80,33.95
step
talk Drum Fel##2771
accept Call to Arms##678 |goto Arathi Highlands 74.24,33.91
step
talk Tor'gan##2706
accept Guile of the Raptor##701 |goto Arathi Highlands/0 74.72,36.29
step
kill Drywhisker Kobold##2572, Drywhisker Digger##2574, Drywhisker Surveyor##2573
|tip Kobolds.
|tip More inside the cave up the path.
|tip Next step is inside the cave.
collect 12 Mote of Myzrael##4435 |q 642/1 |goto Arathi Highlands 76.00,44.20
|mapmarker Arathi Highlands/0 77.20,42.40
|mapmarker Arathi Highlands/0 77.40,35.40
|mapmarker Arathi Highlands/0 78.00,39.60
|mapmarker Arathi Highlands/0 78.60,37.40
|mapmarker Arathi Highlands/0 79.20,41.20
|mapmarker Arathi Highlands/0 79.40,33.20
|mapmarker Arathi Highlands/0 81.80,39.60
|mapmarker Arathi Highlands/0 82.20,36.80
|mapmarker Arathi Highlands/0 83.20,33.20
|mapmarker Arathi Highlands/0 83.60,35.20
|mapmarker Arathi Highlands/0 84.20,28.40
|mapmarker Arathi Highlands/0 84.40,31.40
|mapmarker Arathi Highlands/0 85.40,33.40
|mapmarker Arathi Highlands/0 86.20,30.20
step
Follow the path up to the cave |goto Arathi Highlands 80.90,39.96 < 15 |only if walking and not (subzone("Drywhisker Gorge") and indoors())
Enter the cave |goto Arathi Highlands 82.66,36.16 < 20 |walk |walk |only if not (subzone("Drywhisker Gorge") and indoors())
click Iridescent Shards
|tip Upstairs inside the cave.
turnin The Princess Trapped##642 |goto Arathi Highlands 84.31,30.92
accept Stones of Binding##651 |goto Arathi Highlands 84.31,30.92
step
Leave the cave |goto Arathi Highlands 82.69,36.21 < 20 |walk |only if subzone("Drywhisker Gorge") and indoors()
click Stone of East Binding
collect Cresting Key##4484 |q 651/2 |goto Arathi Highlands 66.75,29.75
step
click Stone of Outer Binding
collect Thundering Key##4485 |q 651/3 |goto Arathi Highlands 52.06,50.69
stickystart "Collect_Raptor_Hearts"
step
kill 4 Boulderfist Magus##2567 |q 678/2 |goto Arathi Highlands 51.40,72.40
kill 10 Boulderfist Brute##2566 |q 678/1 |goto Arathi Highlands 51.40,72.40
|mapmarker Arathi Highlands/0 49.40,75.40
|mapmarker Arathi Highlands/0 51.60,77.80
|mapmarker Arathi Highlands/0 53.80,74.60
|mapmarker Arathi Highlands/0 54.40,80.40
|mapmarker Arathi Highlands/0 53.78,77.42
step
label "Collect_Raptor_Hearts"
kill Highland Fleshstalker##2561+
|tip Raptors.
collect 12 Raptor Heart##4513 |q 701/1 |goto Arathi Highlands 47.40,79.40
|mapmarker Arathi Highlands/0 45.40,76.40
|mapmarker Arathi Highlands/0 47.40,73.40
|mapmarker Arathi Highlands/0 48.00,82.60
|mapmarker Arathi Highlands/0 49.40,68.20
|mapmarker Arathi Highlands/0 50.20,71.60
|mapmarker Arathi Highlands/0 51.00,63.80
|mapmarker Arathi Highlands/0 52.40,67.40
|mapmarker Arathi Highlands/0 54.40,64.00
step
talk Tor'gan##2706
turnin Guile of the Raptor##701 |goto Arathi Highlands 74.71,36.29
accept Guile of the Raptor##702 |goto Arathi Highlands 74.71,36.29
step
talk Gor'mul##2792
|tip Walks around.
turnin Guile of the Raptor##702 |goto Arathi Highlands 72.55,34.01
step
Watch the dialogue
talk Gor'mul##2792
|tip Walks around.
accept Guile of the Raptor##847 |goto Arathi Highlands 72.55,34.01
step
talk Drum Fel##2771
turnin Call to Arms##678 |goto Arathi Highlands 74.24,33.91
step
talk Tor'gan##2706
turnin Guile of the Raptor##847 |goto Arathi Highlands 74.71,36.29
step
click Stone of West Binding
collect Burning Key##4483 |q 651/1 |goto Arathi Highlands 25.52,30.12
step
click Stone of Inner Binding
turnin Stones of Binding##651 |goto Arathi Highlands 36.19,57.37
step
Follow the path through the mountains |goto Arathi Highlands 31.22,65.35 < 40 |only if walking and not subzone("Faldir's Cove")
Run through the tunnel to Faldir's Cove |goto Arathi Highlands 21.58,75.61 < 20 |only if walking and not subzone("Faldir's Cove")
talk Lolo the Lookout##2766
|tip Walks around.
accept Land Ho!##663 |goto Arathi Highlands 31.78,82.70
step
talk Shakes O'Breen##2610
turnin Land Ho!##663 |goto Arathi Highlands 32.28,81.38
step
talk First Mate Nilzlix##2767
|tip Walks around.
accept Deep Sea Salvage##662 |goto Arathi Highlands 32.77,81.47
step
talk Captain Steelgut##2769
accept Drowned Sorrows##664 |goto Arathi Highlands 34.00,80.79
step
talk Professor Phizzlethorpe##2768
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept Sunken Treasure##665 |goto Arathi Highlands 33.87,80.55 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Professor Phizzlethorpe.
Defend Professor Phizzlethorpe |q 665/1 |goto Arathi Highlands 33.87,80.55
step
talk Doctor Draxlegauge##2774
turnin Sunken Treasure##665 |goto Arathi Highlands 33.86,80.45
accept Sunken Treasure##666 |goto Arathi Highlands 33.86,80.45
stickystart "Collect_Elven_Gems"
stickystart "Kill_Daggerspine_Sorceresses_And_Raiders"
step
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Maiden's Folly Log
|tip Brown book in a metal cauldron.
|tip {o}Middle floor{} inside the sunken ship.
collect Maiden's Folly Log##4489 |q 662/2 |goto Arathi Highlands 23.41,85.10
step
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Maiden's Folly Charts
|tip Tan flat scroll.
|tip {o}Middle floor{} inside the sunken ship.
collect Maiden's Folly Charts##4487 |q 662/1 |goto Arathi Highlands 23.04,84.51
step
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Spirit of Silverpine Charts
|tip Tan flat scroll.
|tip {o}Middle floor{} inside the sunken ship.
collect Spirit of Silverpine Charts##4488 |q 662/3 |goto Arathi Highlands 20.45,85.60
step
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Spirit of Silverpine Log
|tip Open book.
|tip Very bottom inside the ship.
collect Spirit of Silverpine Log##4490 |q 662/4 |goto Arathi Highlands 20.65,85.10
step
label "Collect_Elven_Gems"
equip Goggles of Gem Hunting##4491 |n |only if not equipped(4491)
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman) |notinsticky
click Calcified Elven Gem+
|tip Large grey stones.
|tip On your minimap.
collect 10 Elven Gem##4492 |q 666/1 |goto Arathi Highlands 23.60,87.40
|mapmarker Arathi Highlands/0 17.70,88.80
|mapmarker Arathi Highlands/0 19.40,90.20
|mapmarker Arathi Highlands/0 19.60,84.70
|mapmarker Arathi Highlands/0 20.40,87.10
|mapmarker Arathi Highlands/0 21.00,92.10
|mapmarker Arathi Highlands/0 21.10,90.20
|mapmarker Arathi Highlands/0 22.40,83.70
|mapmarker Arathi Highlands/0 23.00,92.20
|mapmarker Arathi Highlands/0 24.30,84.80
|mapmarker Arathi Highlands/0 24.40,86.40
|mapmarker Arathi Highlands/0 25.20,90.60
step
Equip Your Regular Head Armor |unequip Goggles of Gem Hunting##4491 |q 666
step
label "Kill_Daggerspine_Sorceresses_And_Raiders"
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman) |notinsticky
kill 3 Daggerspine Sorceress##2596 |q 664/2 |goto Arathi Highlands 19.20,84.00
kill 10 Daggerspine Raider##2595 |q 664/1 |goto Arathi Highlands 19.20,84.00
|tip Underwater. |notinsticky
|mapmarker Arathi Highlands/0 17.20,87.20
|mapmarker Arathi Highlands/0 18.40,90.00
|mapmarker Arathi Highlands/0 20.40,87.00
|mapmarker Arathi Highlands/0 21.00,92.20
|mapmarker Arathi Highlands/0 23.20,84.40
|mapmarker Arathi Highlands/0 23.20,88.20
|mapmarker Arathi Highlands/0 25.20,90.60
step
talk First Mate Nilzlix##2767
|tip Walks around.
turnin Deep Sea Salvage##662 |goto Arathi Highlands 32.80,81.48
step
talk Captain Steelgut##2769
turnin Drowned Sorrows##664 |goto Arathi Highlands 34.00,80.79
step
talk Doctor Draxlegauge##2774
turnin Sunken Treasure##666 |goto Arathi Highlands 33.85,80.45
accept Sunken Treasure##668 |goto Arathi Highlands 33.85,80.45
step
talk Shakes O'Breen##2610
turnin Sunken Treasure##668 |goto Arathi Highlands 32.29,81.38
accept Sunken Treasure##669 |goto Arathi Highlands 32.29,81.38
step
Swim along the coast into the Wetlands |goto Wetlands 32.99,10.11 < 40 |c |notravel
|only if (subzone("Faldir's Cove") or subzone("The Drowned Reef") or subzone("Baradin Bay"))
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Badlands (39-40)",{
image=ZGV.IMAGESDIR.."Badlands",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale & Swamp of Sorrows (40-41)",
},[[
step
talk Rigglefuzz##2817
accept Pearl Diving##705 |goto Badlands/0 42.39,52.93 |only if itemcount(4611) >= 9
accept Barbecued Buzzard Wings##703 |goto Badlands 42.39,52.93
step
talk Rigglefuzz##2817
turnin Pearl Diving##705 |goto Badlands/0 42.39,52.93
|only if haveq(705) or completedq(705)
step
talk Martek the Exiled##4618
turnin Martek the Exiled##1106 |goto Badlands 42.22,52.69
accept Indurium##1108 |goto Badlands 42.22,52.69
step
talk Lotwil Veriatus##2921
|tip Walks around.
accept Study of the Elements: Rock##710 |goto Badlands 25.95,44.87
accept Coolant Heads Prevail##713 |goto Badlands/0 25.95,44.87 |only if itemcount(3829) > 0
step
talk Lotwil Veriatus##2921
|tip Walks around.
turnin Coolant Heads Prevail##713 |goto Badlands/0 25.95,44.87
accept Gyro... What?##714 |goto Badlands/0 25.95,44.87 |only if itemcount(4389) > 0
|only if haveq(713) or completedq(713)
step
talk Lotwil Veriatus##2921
|tip Walks around.
turnin Gyro... What?##714 |goto Badlands/0 25.95,44.87
|only if haveq(714) or completedq(714)
step
talk Lucien Tosselwrench##2920
accept Liquid Stone##715 |goto Badlands/0 25.82,44.23
|only if itemcount(929) > 0 and itemcount(3823) > 0
step
talk Lucien Tosselwrench##2920
turnin Liquid Stone##715 |goto Badlands/0 25.82,44.23
|only if haveq(715) or completedq(715)
stickystart "Collect_Small_Stone_Shards"
step
talk Neeka Bloodscar##5394
|tip Top of the tower.
accept Coyote Thieves##1419 |goto Badlands 6.48,47.18
stickystop "Collect_Small_Stone_Shards"
step
talk Gorrik##2861
fpath Kargath |goto Badlands 3.99,44.78
step
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
accept Badlands Reagent Run##2258 |goto Badlands 2.42,46.06
stickystart "Collect_Buzzard_Gizzards"
stickystart "Collect_Coyote_Items"
step
label "Collect_Buzzard_Wings"
kill Giant Buzzard##2831, Buzzard##2830
|tip Group of them at this location. |notinsticky
|tip Spread out elsewhere. |notinsticky
collect 4 Buzzard Wing##3404 |q 703/1 |goto Badlands 17.20,61.00
|tip Don't vendor them.
|mapmarker Badlands/0 9.20,70.00
|mapmarker Badlands/0 10.20,66.20
|mapmarker Badlands/0 14.00,71.40
|mapmarker Badlands/0 14.20,59.20
|mapmarker Badlands/0 14.40,62.20
|mapmarker Badlands/0 14.80,80.80
|mapmarker Badlands/0 15.00,67.00
|mapmarker Badlands/0 16.20,49.20
|mapmarker Badlands/0 16.80,57.00
|mapmarker Badlands/0 18.20,64.60
|mapmarker Badlands/0 18.40,74.60
|mapmarker Badlands/0 19.20,48.40
|mapmarker Badlands/0 19.40,79.60
|mapmarker Badlands/0 22.80,51.00
|mapmarker Badlands/0 23.00,72.60
|mapmarker Badlands/0 23.40,77.60
|mapmarker Badlands/0 26.00,73.20
|mapmarker Badlands/0 27.60,61.00
|mapmarker Badlands/0 28.60,46.20
|mapmarker Badlands/0 28.60,66.60
|mapmarker Badlands/0 29.40,51.80
|mapmarker Badlands/0 31.40,64.80
|mapmarker Badlands/0 31.80,73.00
|mapmarker Badlands/0 32.20,70.00
|mapmarker Badlands/0 32.80,62.00
|mapmarker Badlands/0 36.20,69.40
stickystop "Collect_Buzzard_Gizzards"
stickystop "Collect_Coyote_Items"
stickystart "Collect_Rock_Elemental_Shards"
step
label "Collect_Small_Stone_Shards"
kill Lesser Rock Elemental##2735+
collect 10 Small Stone Shard##4626 |q 710/1 |goto Badlands 21.40,43.40
|mapmarker Badlands/0 12.40,40.60
|mapmarker Badlands/0 13.40,36.40
|mapmarker Badlands/0 15.40,41.80
|mapmarker Badlands/0 16.40,37.40
|mapmarker Badlands/0 18.20,43.60
|mapmarker Badlands/0 19.40,46.60
|mapmarker Badlands/0 23.00,47.40
step
talk Lotwil Veriatus##2921
|tip Walks around.
turnin Study of the Elements: Rock##710 |goto Badlands 25.95,44.87
accept Study of the Elements: Rock##711 |goto Badlands 25.95,44.87
step
kill Rock Elemental##92+
collect 3 Large Stone Slab##4627 |q 711/1 |goto Badlands 13.40,37.80
|mapmarker Badlands/0 12.20,34.20
|mapmarker Badlands/0 15.20,32.40
|mapmarker Badlands/0 16.20,35.40
step
label "Collect_Rock_Elemental_Shards"
kill Lesser Rock Elemental##2735, Rock Elemental##92
collect 5 Rock Elemental Shard##7848 |q 2258/3 |goto Badlands 21.40,43.40
|mapmarker Badlands/0 12.40,40.60
|mapmarker Badlands/0 15.40,41.80
|mapmarker Badlands/0 18.20,43.60
|mapmarker Badlands/0 19.40,46.60
|mapmarker Badlands/0 23.00,47.40
|mapmarker Badlands/0 13.40,37.80
|mapmarker Badlands/0 12.20,34.20
|mapmarker Badlands/0 15.20,32.40
|mapmarker Badlands/0 16.20,35.40
step
talk Lotwil Veriatus##2921
|tip Walks around.
turnin Study of the Elements: Rock##711 |goto Badlands 25.95,44.87
stickystart "Collect_Coyote_Items"
step
label "Collect_Buzzard_Gizzards"
kill Giant Buzzard##2831, Buzzard##2830
|tip Group of them at this location. |notinsticky
|tip Spread out elsewhere. |notinsticky
collect 5 Buzzard Gizzard##7847 |q 2258/1 |goto Badlands 17.20,61.00
|mapmarker Badlands/0 9.20,70.00
|mapmarker Badlands/0 10.20,66.20
|mapmarker Badlands/0 14.00,71.40
|mapmarker Badlands/0 14.20,59.20
|mapmarker Badlands/0 14.40,62.20
|mapmarker Badlands/0 14.80,80.80
|mapmarker Badlands/0 15.00,67.00
|mapmarker Badlands/0 16.20,49.20
|mapmarker Badlands/0 16.80,57.00
|mapmarker Badlands/0 18.20,64.60
|mapmarker Badlands/0 18.40,74.60
|mapmarker Badlands/0 19.20,48.40
|mapmarker Badlands/0 19.40,79.60
|mapmarker Badlands/0 22.80,51.00
|mapmarker Badlands/0 23.00,72.60
|mapmarker Badlands/0 23.40,77.60
|mapmarker Badlands/0 26.00,73.20
|mapmarker Badlands/0 27.60,61.00
|mapmarker Badlands/0 28.60,46.20
|mapmarker Badlands/0 28.60,66.60
|mapmarker Badlands/0 29.40,51.80
|mapmarker Badlands/0 31.40,64.80
|mapmarker Badlands/0 31.80,73.00
|mapmarker Badlands/0 32.20,70.00
|mapmarker Badlands/0 32.80,62.00
|mapmarker Badlands/0 36.20,69.40
step
label "Collect_Coyote_Items"
kill Crag Coyote##2727, Feral Crag Coyote##2728, Elder Crag Coyote##2729
collect 10 Crag Coyote Fang##7846 |q 2258/2 |goto Badlands 20.80,56.80
collect 30 Coyote Jawbone##6166 |q 1419/1 |goto Badlands 20.80,56.80
|mapmarker Badlands/0 4.60,57.20
|mapmarker Badlands/0 6.40,64.40
|mapmarker Badlands/0 7.40,71.00
|mapmarker Badlands/0 10.20,78.40
|mapmarker Badlands/0 10.40,59.40
|mapmarker Badlands/0 12.20,66.20
|mapmarker Badlands/0 13.20,83.80
|mapmarker Badlands/0 13.60,73.40
|mapmarker Badlands/0 15.00,54.20
|mapmarker Badlands/0 16.20,61.60
|mapmarker Badlands/0 16.80,45.80
|mapmarker Badlands/0 16.80,78.80
|mapmarker Badlands/0 17.80,68.60
|mapmarker Badlands/0 20.40,50.80
|mapmarker Badlands/0 21.20,73.80
|mapmarker Badlands/0 22.40,82.00
|mapmarker Badlands/0 24.80,62.20
|mapmarker Badlands/0 25.20,42.40
|mapmarker Badlands/0 26.40,49.40
|mapmarker Badlands/0 26.40,68.40
|mapmarker Badlands/0 27.40,56.40
|mapmarker Badlands/0 27.40,74.60
|mapmarker Badlands/0 30.80,45.20
|mapmarker Badlands/0 30.80,61.40
|mapmarker Badlands/0 32.40,52.00
|mapmarker Badlands/0 32.60,69.80
|mapmarker Badlands/0 35.20,75.80
|mapmarker Badlands/0 35.60,57.40
|mapmarker Badlands/0 36.00,64.80
|mapmarker Badlands/0 39.20,70.20
|mapmarker Badlands/0 41.00,53.20
|mapmarker Badlands/0 41.80,62.60
|mapmarker Badlands/0 44.80,73.40
step
Kill enemies
ding 40 |goto Badlands 20.80,56.80
|mapmarker Badlands/0 4.60,57.20
|mapmarker Badlands/0 6.40,64.40
|mapmarker Badlands/0 7.40,71.00
|mapmarker Badlands/0 10.20,78.40
|mapmarker Badlands/0 10.40,59.40
|mapmarker Badlands/0 12.20,66.20
|mapmarker Badlands/0 13.20,83.80
|mapmarker Badlands/0 13.60,73.40
|mapmarker Badlands/0 15.00,54.20
|mapmarker Badlands/0 16.20,61.60
|mapmarker Badlands/0 16.80,45.80
|mapmarker Badlands/0 16.80,78.80
|mapmarker Badlands/0 17.80,68.60
|mapmarker Badlands/0 20.40,50.80
|mapmarker Badlands/0 21.20,73.80
|mapmarker Badlands/0 22.40,82.00
|mapmarker Badlands/0 24.80,62.20
|mapmarker Badlands/0 25.20,42.40
|mapmarker Badlands/0 26.40,49.40
|mapmarker Badlands/0 26.40,68.40
|mapmarker Badlands/0 27.40,56.40
|mapmarker Badlands/0 27.40,74.60
|mapmarker Badlands/0 30.80,45.20
|mapmarker Badlands/0 30.80,61.40
|mapmarker Badlands/0 32.40,52.00
|mapmarker Badlands/0 32.60,69.80
|mapmarker Badlands/0 35.20,75.80
|mapmarker Badlands/0 35.60,57.40
|mapmarker Badlands/0 36.00,64.80
|mapmarker Badlands/0 39.20,70.20
|mapmarker Badlands/0 41.00,53.20
|mapmarker Badlands/0 41.80,62.60
|mapmarker Badlands/0 44.80,73.40
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 40 ammo when restocking.
Click Here to Continue |confirm |q 703
|only if Hunter
step
talk Rigglefuzz##2817
turnin Barbecued Buzzard Wings##703 |goto Badlands 42.39,52.93
step
_Destroy These Items:_
|tip Not needed.
trash Buzzard Wing##3404
step
kill Stonevault Shaman##2894, Stonevault Bonesnapper##2893
|tip Troggs.
collect 10 Indurium Flake##5797 |q 1108/1 |goto Badlands 50.40,68.60
|mapmarker Badlands/0 47.20,70.00
|mapmarker Badlands/0 48.40,71.80
|mapmarker Badlands/0 49.40,64.20
|mapmarker Badlands/0 49.60,66.40
|mapmarker Badlands/0 50.60,72.80
|mapmarker Badlands/0 50.80,62.20
|mapmarker Badlands/0 51.60,64.20
|mapmarker Badlands/0 51.80,70.60
|mapmarker Badlands/0 52.40,66.20
|mapmarker Badlands/0 52.80,73.80
step
talk Martek the Exiled##4618
turnin Indurium##1108 |goto Badlands 42.21,52.70
step
Watch the dialogue
talk Martek the Exiled##4618
accept News for Fizzle##1137 |goto Badlands 42.21,52.70
step
talk Neeka Bloodscar##5394
|tip Top of the tower.
turnin Coyote Thieves##1419 |goto Badlands 6.48,47.18
accept Report to Helgrum##1420 |goto Badlands/0 6.48,47.18
step
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
turnin Badlands Reagent Run##2258 |goto Badlands 2.42,46.06
step
_Destroy These Items:_
|tip Not needed.
trash Crag Coyote Fang##7846
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1276
|only if Druid
step
talk Thuul##5958
|tip Upstairs inside the building.
learnspell Portal: Orgrimmar##11417 |goto Orgrimmar/0 38.68,85.41
|only if Mage
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 1276
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 1276
|only if Priest
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 1276
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 1276
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 1276
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 1276
|only if Warlock
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 1276
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 1276
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 1276
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Auctioneer Thathung##8673
|tip Buy from the Auction House, if possible.
|tip Makes quests easier later.
|tip Inside the building.
collect 2 Elixir of Water Breathing##5996	|goto Orgrimmar/0 55.69,62.86 |q 1424 |future	|only if not (Undead or Druid or Warlock or Shaman)
collect 2 Shiny Fish Scales##17057		|goto Orgrimmar/0 55.69,62.86 |q 1424 |future	|only if Shaman
|only if not (Undead or Druid or Warlock)
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Sage Truthseeker##3978
|tip Inside the building.
turnin Compendium of the Fallen##1049 |goto Thunder Bluff 34.40,46.87
|only if guideflag("SMflag") and not Scourge
step
talk Chesmu##8356
|tip Collect from the bank.
|tip Inside the building.
collect Blackened Iron Shield##5919 |goto Thunder Bluff/0 47.13,57.89 |q 1276
collect Kodo Skin Scroll##5838 |goto Thunder Bluff/0 47.13,57.89 |q 1136
step
talk Mosarn##4943
|tip Inside the tent.
turnin The Black Shield##1276 |goto Thunder Bluff 54.01,80.77
step
talk Melor Stonehoof##3441
turnin Frostmaw##1136 |goto Thunder Bluff 61.53,80.90
accept Deadmire##1205 |goto Thunder Bluff 61.53,80.90
step
_Destroy This Item:_
|tip Not needed.
trash Kodo Skin Scroll##5838
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale & Swamp of Sorrows (40-41)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Desolace (41-41)",
},[[
step
talk Mebok Mizzyrix##3446
turnin Stinky's Escape##1270 |goto The Barrens 62.37,37.62
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
accept Some Assembly Required##577 |goto Stranglethorn Vale 28.29,77.59
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
accept Venture Company Mining##600 |goto Stranglethorn Vale 27.12,77.21
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
accept Skullsplitter Tusks##209 |goto Stranglethorn Vale 27.00,77.13
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
turnin Sunken Treasure##669 |goto Stranglethorn Vale 27.17,77.01
step
talk Far Seer Mok'thardin##2465
accept Mok'thardin's Enchantment##572 |goto Stranglethorn Vale 32.12,29.24
step
talk Nimboya##2497
accept Bloodscalp Clan Heads##584 |goto Stranglethorn Vale 32.16,27.72
step
talk Kin'weelay##2519
accept Split Bone Necklace##598 |goto Stranglethorn Vale 32.27,27.71
turnin The Troll Witchdoctor##1240 |goto Stranglethorn Vale 32.27,27.71
step
Run down the coast and follow the path up |goto Stranglethorn Vale 21.43,10.13 < 15 |only if walking
kill Nezzliok the Dire##1062
|tip Walks around.
collect Nezzliok's Head##3905 |q 584/2 |goto Stranglethorn Vale 23.52,9.53
step
kill Gan'zulah##1061
collect Gan'zulah's Head##3904 |q 584/1 |goto Stranglethorn Vale 23.44,8.12
step
click Bubbling Cauldron
turnin Bloodscalp Clan Heads##584 |goto Stranglethorn Vale 32.22,27.60
accept Speaking with Nezzliok##585 |goto Stranglethorn Vale 32.22,27.60
stickystart "Kill_Jungle_Stalkers"
step
kill Jungle Stalker##687+
collect 10 Jungle Stalker Feather##3863 |q 572/1 |goto Stranglethorn Vale 33.40,40.40
|mapmarker Stranglethorn Vale/0 23.00,49.80
|mapmarker Stranglethorn Vale/0 26.00,51.20
|mapmarker Stranglethorn Vale/0 27.40,43.20
|mapmarker Stranglethorn Vale/0 30.40,41.80
|mapmarker Stranglethorn Vale/0 31.80,37.80
|mapmarker Stranglethorn Vale/0 27.20,48.20
step
label "Kill_Jungle_Stalkers"
kill 10 Jungle Stalker##687 |q 196/1 |goto Stranglethorn Vale 33.40,40.40
|mapmarker Stranglethorn Vale/0 23.00,49.80
|mapmarker Stranglethorn Vale/0 26.00,51.20
|mapmarker Stranglethorn Vale/0 27.40,43.20
|mapmarker Stranglethorn Vale/0 30.40,41.80
|mapmarker Stranglethorn Vale/0 31.80,37.80
|mapmarker Stranglethorn Vale/0 27.20,48.20
step
kill Venture Co. Strip Miner##674, Venture Co. Tinkerer##677, Venture Co. Surveyor##676, Venture Co. Foreman##675
|tip Goblins.
collect 10 Singing Blue Crystal##3917 |q 600/1 |goto Stranglethorn Vale 41.40,44.60
|mapmarker Stranglethorn Vale/0 40.20,42.40
|mapmarker Stranglethorn Vale/0 40.40,43.80
|mapmarker Stranglethorn Vale/0 41.40,41.40
|mapmarker Stranglethorn Vale/0 42.00,46.00
stickystart "Collect_Skullsplitter_Tusks_And_Split_Bones_Necklaces"
step
click Ziata'jai Trophy Skulls
collect Ziata'jai Trophy##3907 |q 585/2 |goto Stranglethorn Vale 42.21,36.12
step
click Balia'mah Trophy Skulls
collect Balia'mah Trophy##3906 |q 585/1 |goto Stranglethorn Vale 46.14,32.33
step
click Zul'Mamwe Trophy Skulls
collect Zul'Mamwe Trophy##3908 |q 585/3 |goto Stranglethorn Vale 47.65,39.54
step
label "Collect_Skullsplitter_Tusks_And_Split_Bones_Necklaces"
kill Skullsplitter Warrior##667, Skullsplitter Axe Thrower##696, Skullsplitter Mystic##780, Skullsplitter Scout##782, Skullsplitter Beastmaster##784, Skullsplitter Witch Doctor##670, Skullsplitter Hunter##669, Skullsplitter Berserker##783, Skullsplitter Spiritchaser##672, Skullsplitter Headhunter##781
|tip Trolls.
collect 18 Skullsplitter Tusk##1524 |q 209/1 |goto Stranglethorn Vale 42.20,36.20
collect 25 Split Bone Necklace##3916 |q 598/1 |goto Stranglethorn Vale 42.20,36.20
|mapmarker Stranglethorn Vale/0 42.40,33.40
|mapmarker Stranglethorn Vale/0 43.40,39.40
|mapmarker Stranglethorn Vale/0 45.00,32.60
|mapmarker Stranglethorn Vale/0 46.00,38.00
|mapmarker Stranglethorn Vale/0 46.40,30.20
|mapmarker Stranglethorn Vale/0 46.40,40.60
|mapmarker Stranglethorn Vale/0 47.00,34.60
step
Kill enemies
ding 41 |goto Stranglethorn Vale 42.20,36.20
|mapmarker Stranglethorn Vale/0 42.40,33.40
|mapmarker Stranglethorn Vale/0 43.40,39.40
|mapmarker Stranglethorn Vale/0 45.00,32.60
|mapmarker Stranglethorn Vale/0 46.00,38.00
|mapmarker Stranglethorn Vale/0 46.40,30.20
|mapmarker Stranglethorn Vale/0 46.40,40.60
|mapmarker Stranglethorn Vale/0 47.00,34.60
step
kill Snapjaw Crocolisk##1152+
|tip In and around the water.
collect 5 Snapjaw Crocolisk Skin##4104 |q 577/1 |goto Stranglethorn Vale 38.40,30.60
|mapmarker Stranglethorn Vale/0 40.40,25.00
|mapmarker Stranglethorn Vale/0 39.40,17.80
|mapmarker Stranglethorn Vale/0 39.40,21.40
|mapmarker Stranglethorn Vale/0 40.00,27.20
|mapmarker Stranglethorn Vale/0 41.80,15.80
|mapmarker Stranglethorn Vale/0 42.60,21.00
step
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##572 |goto Stranglethorn Vale 32.12,29.24
step
talk Viznik Goldgrubber##2625
|tip Deposit into the bank.
bank Green Hills of Stranglethorn - Page 1##2725 |goto Stranglethorn Vale 26.54,76.57 |q 339 |future |only if itemcount(2725) > 0
bank Green Hills of Stranglethorn - Page 4##2728 |goto Stranglethorn Vale 26.54,76.57 |q 339 |future |only if itemcount(2728) > 0
bank Green Hills of Stranglethorn - Page 6##2730 |goto Stranglethorn Vale 26.54,76.57 |q 339 |future |only if itemcount(2730) > 0
bank Green Hills of Stranglethorn - Page 8##2732 |goto Stranglethorn Vale 26.54,76.57 |q 339 |future |only if itemcount(2732) > 0
bank Green Hills of Stranglethorn - Page 10##2734 |goto Stranglethorn Vale 26.54,76.57 |q 340 |future |only if itemcount(2734) > 0
bank Green Hills of Stranglethorn - Page 11##2735 |goto Stranglethorn Vale 26.54,76.57 |q 340 |future |only if itemcount(2735) > 0
bank Green Hills of Stranglethorn - Page 14##2738 |goto Stranglethorn Vale 26.54,76.57 |q 340 |future |only if itemcount(2738) > 0
bank Green Hills of Stranglethorn - Page 16##2740 |goto Stranglethorn Vale 26.54,76.57 |q 340 |future |only if itemcount(2740) > 0
bank Green Hills of Stranglethorn - Page 18##2742 |goto Stranglethorn Vale 26.54,76.57 |q 341 |future |only if itemcount(2742) > 0
bank Green Hills of Stranglethorn - Page 20##2744 |goto Stranglethorn Vale 26.54,76.57 |q 341 |future |only if itemcount(2744) > 0
bank Green Hills of Stranglethorn - Page 21##2745 |goto Stranglethorn Vale 26.54,76.57 |q 341 |future |only if itemcount(2745) > 0
bank Green Hills of Stranglethorn - Page 24##2748 |goto Stranglethorn Vale 26.54,76.57 |q 341 |future |only if itemcount(2748) > 0
bank Green Hills of Stranglethorn - Page 25##2749 |goto Stranglethorn Vale 26.54,76.57 |q 342 |future |only if itemcount(2749) > 0
bank Green Hills of Stranglethorn - Page 26##2750 |goto Stranglethorn Vale 26.54,76.57 |q 342 |future |only if itemcount(2750) > 0
bank Green Hills of Stranglethorn - Page 27##2751 |goto Stranglethorn Vale 26.54,76.57 |q 342 |future |only if itemcount(2751) > 0
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
turnin Some Assembly Required##577 |goto Stranglethorn Vale 28.29,77.59
accept Excelsior##628 |goto Stranglethorn Vale 28.29,77.59
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
turnin Venture Company Mining##600 |goto Stranglethorn Vale 27.12,77.21
step
talk Innkeeper Skindle##6807
|tip {o}Ground floor{} inside the building.
home Booty Bay |goto Stranglethorn Vale/0 27.04,77.31 |q 1116 |future
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
accept Dream Dust in the Swamp##1116 |goto Stranglethorn Vale/0 26.94,77.21
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
turnin Skullsplitter Tusks##209 |goto Stranglethorn Vale 27.00,77.13
step
talk Kin'weelay##2519
turnin Split Bone Necklace##598 |goto Stranglethorn Vale/0 32.27,27.71
step
click Bubbling Cauldron
turnin Speaking with Nezzliok##585 |goto Stranglethorn Vale 32.22,27.60
accept Marg Speaks##1261 |goto Stranglethorn Vale 32.22,27.60
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##196 |goto Stranglethorn Vale 35.66,10.81
accept Raptor Mastery##197 |goto Stranglethorn Vale 35.66,10.81
step
talk Deathstalker Zraedus##5418
|tip Avoid Darkshire.
accept Nothing But The Truth##1372 |goto Duskwood 87.81,35.63
step
talk Apothecary Faustin##5414
turnin Nothing But The Truth##1372 |goto Duskwood 87.46,35.25
step
kill Adolescent Whelp##740, Dreaming Whelp##741
|tip Tiny flying dragons.
|tip Skip once no more to kill.
|tip Can finish later.
collect 10 Speck of Dream Dust##5803 |q 1116/1 |goto Swamp of Sorrows/0 12.40,57.40
|mapmarker Swamp of Sorrows/0 11.40,62.00
|mapmarker Swamp of Sorrows/0 11.40,65.40
|mapmarker Swamp of Sorrows/0 15.00,61.60
|mapmarker Swamp of Sorrows/0 15.00,66.60
|mapmarker Swamp of Sorrows/0 16.80,58.40
step
talk Dar##5591
|tip Inside the building.
accept Lack of Surplus##698 |goto Swamp of Sorrows 44.70,57.20
step
talk Breyk##6026
fpath Stonard |goto Swamp of Sorrows 46.07,54.82
step
talk Helgrum the Swift##1442
|tip Upstairs inside the building.
turnin Report to Helgrum##1420 |goto Swamp of Sorrows 47.74,55.20
step
talk Fel'zerul##1443
|tip Upstairs inside the building.
accept Pool of Tears##1424 |goto Swamp of Sorrows 47.93,54.80
stickystart "Collect_Unprepared_Sawtooth_Flanks"
step
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	32.20,36.29	33.36,40.42	33.49,43.89	36.69,46.29	37.91,43.12
path	38.87,35.52	40.22,34.56	40.86,32.25	42.27,32.35	45.61,36.48
path	46.38,38.60	47.66,38.21	53.11,39.08	55.48,37.44	55.87,35.71
path	55.54,33.98
kill Noboru the Cudgel##5477
|tip Humanoid creature with 2 guards.
|tip Walks a large path.
collect Noboru's Cudgel##6196 |n
use Noboru's Cudgel##6196 |forceuse
accept Noboru the Cudgel##1392
stickystop "Collect_Unprepared_Sawtooth_Flanks"
step
talk Magtoor##1776
turnin Noboru the Cudgel##1392 |goto Swamp of Sorrows 25.99,31.40
accept Draenethyst Crystals##1389 |goto Swamp of Sorrows 25.99,31.40
stickystart "Collect_Draenethyst_Crystals"
stickystart "Collect_Unprepared_Sawtooth_Flanks"
step
kill Ongeku##5622
|tip Walks around.
|tip Multiple locations.
collect Draenethyst Shard##6190 |q 1373/1 |goto Swamp of Sorrows 61.31,23.25
|mapmarker Swamp of Sorrows/0 59.80,23.60
|mapmarker Swamp of Sorrows/0 60.20,20.00
|mapmarker Swamp of Sorrows/0 63.00,24.60
|mapmarker Swamp of Sorrows/0 64.20,20.80
step
talk Galen Goodward##5391
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Kill nearby enemies to the {o}south{} first.
accept Galen's Escape##1393 |goto Swamp of Sorrows 65.41,18.23 |noautoaccept inparty
|only if not hardcore()
step
Watch the dialogue
|tip Follow and protect Galen Goodward.
Escort Galen Out of the Fallow Sanctuary |q 1393/1 |goto Swamp of Sorrows 53.05,29.64
|only if not hardcore()
step
label "Collect_Draenethyst_Crystals"
click Draenethyst Crystal##22550+
|tip Large blue crystals.
collect 6 Draenethyst Crystal##6071 |q 1389/1 |goto Swamp of Sorrows 55.00,30.20
|mapmarker Swamp of Sorrows/0 57.30,25.10
|mapmarker Swamp of Sorrows/0 60.10,22.40
|mapmarker Swamp of Sorrows/0 62.10,23.50
|mapmarker Swamp of Sorrows/0 64.80,22.40
|mapmarker Swamp of Sorrows/0 65.40,20.10
step
click Galen's Strongbox
turnin Galen's Escape##1393 |goto Swamp of Sorrows 47.81,39.76
|only if not hardcore()
step
label "Collect_Unprepared_Sawtooth_Flanks"
kill Sawtooth Crocolisk##1082+
collect 8 Unprepared Sawtooth Flank##6169 |q 698/1 |goto Swamp of Sorrows 46.40,41.20
|mapmarker Swamp of Sorrows/0 47.40,45.00
|mapmarker Swamp of Sorrows/0 48.20,38.40
|mapmarker Swamp of Sorrows/0 50.20,40.80
|mapmarker Swamp of Sorrows/0 52.20,37.40
|mapmarker Swamp of Sorrows/0 53.40,47.20
|mapmarker Swamp of Sorrows/0 53.60,43.00
|mapmarker Swamp of Sorrows/0 55.40,38.60
|mapmarker Swamp of Sorrows/0 55.80,52.20
|mapmarker Swamp of Sorrows/0 56.00,56.60
|mapmarker Swamp of Sorrows/0 56.40,34.40
|mapmarker Swamp of Sorrows/0 56.40,47.60
|mapmarker Swamp of Sorrows/0 59.40,34.40
|mapmarker Swamp of Sorrows/0 62.80,26.00
|mapmarker Swamp of Sorrows/0 63.60,32.20
|mapmarker Swamp of Sorrows/0 65.00,28.20
|mapmarker Swamp of Sorrows/0 69.40,15.40
|mapmarker Swamp of Sorrows/0 69.40,19.20
step
use Elixir of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Atal'ai Artifact##30854+
|tip Various small brown objects.
|tip Underwater.
|tip Reduce the {o}Ground Clutter{} setting to {o}1{}.
|tip In {o}System > Graphics{} game settings.
|tip Makes them easier to see.
collect 10 Atal'ai Artifact##6175 |q 1424/1 |goto Swamp of Sorrows 65.90,47.20
|mapmarker Swamp of Sorrows/0 61.40,57.80
|mapmarker Swamp of Sorrows/0 62.40,53.00
|mapmarker Swamp of Sorrows/0 65.40,43.50
|mapmarker Swamp of Sorrows/0 65.40,51.80
|mapmarker Swamp of Sorrows/0 65.40,55.40
|mapmarker Swamp of Sorrows/0 66.40,59.10
|mapmarker Swamp of Sorrows/0 67.30,45.90
|mapmarker Swamp of Sorrows/0 67.40,62.80
|mapmarker Swamp of Sorrows/0 68.00,61.20
|mapmarker Swamp of Sorrows/0 68.30,43.20
|mapmarker Swamp of Sorrows/0 70.30,65.00
|mapmarker Swamp of Sorrows/0 71.90,60.40
|mapmarker Swamp of Sorrows/0 73.70,64.70
|mapmarker Swamp of Sorrows/0 73.80,42.30
|mapmarker Swamp of Sorrows/0 74.20,47.90
|mapmarker Swamp of Sorrows/0 74.20,61.70
|mapmarker Swamp of Sorrows/0 74.80,55.90
|mapmarker Swamp of Sorrows/0 75.40,60.30
|mapmarker Swamp of Sorrows/0 76.20,63.40
|mapmarker Swamp of Sorrows/0 76.30,53.40
|mapmarker Swamp of Sorrows/0 78.20,48.60
step
talk Tok'Kar##5592
turnin Lack of Surplus##698 |goto Swamp of Sorrows 81.32,80.97
step
talk Fel'zerul##1443
|tip Upstairs inside the building.
turnin Pool of Tears##1424 |goto Swamp of Sorrows 47.93,54.79
step
talk Magtoor##1776
turnin Draenethyst Crystals##1389 |goto Swamp of Sorrows 25.99,31.40
step
kill Adolescent Whelp##740, Dreaming Whelp##741
|tip Tiny flying dragons.
collect 10 Speck of Dream Dust##5803 |q 1116/1 |goto Swamp of Sorrows/0 12.40,57.40
|mapmarker Swamp of Sorrows/0 11.40,62.00
|mapmarker Swamp of Sorrows/0 11.40,65.40
|mapmarker Swamp of Sorrows/0 15.00,61.60
|mapmarker Swamp of Sorrows/0 15.00,66.60
|mapmarker Swamp of Sorrows/0 16.80,58.40
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
turnin Dream Dust in the Swamp##1116 |goto Stranglethorn Vale 26.94,77.21
step
Watch the dialogue
|tip {o}Top floor{} inside the building.
talk Krazek##773
accept Rumors for Kravel##1117 |goto Stranglethorn Vale 26.94,77.21
accept Tran'rek##2864 |goto Stranglethorn Vale 26.94,77.21
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
accept Goblin Sponsorship##1183 |goto Stranglethorn Vale 27.23,76.87
step
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
accept Stoley's Debt##2872 |goto Stranglethorn Vale 27.78,77.07
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Innkeeper Byula##7714
|tip Inside the building.
home Camp Taurajo |goto The Barrens/0 45.58,59.04 |q 1707 |future
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Desolace (41-41)",{
image=ZGV.IMAGESDIR.."Desolace",
hardcore = true,
next="Leveling Guides\\Tanaris (41-42)",
},[[
step
talk Taiga Wisemane##11624
accept Portals of the Legion##5581 |goto Desolace 25.81,68.22
step
talk Uthek the Wise##5397
turnin Ongeku##1373 |goto Desolace 36.22,79.25
accept Khan Jehn##1374 |goto Desolace 36.22,79.25
step
talk Hornizz Brimbuzzle##6019
accept Ghost-o-plasm Round Up##6134 |goto Desolace 47.83,61.82
step
Follow the path up |goto Desolace/0 55.46,58.07 < 20 |only if walking
talk Takata Steelblade##5641
accept The Corrupter##1488 |goto Desolace 52.57,54.38
step
click Demon Portal+
|tip Purple stone circles.
|tip Guardian appears.
kill Demon Portal Guardian##11937+
Banish #6# Demon Portals |q 5581/1 |goto Desolace 53.90,79.14
|mapmarker Desolace 52.70,81.92
|mapmarker Desolace 50.96,81.26
|mapmarker Desolace 53.11,79.95
|mapmarker Desolace 53.17,84.03
|mapmarker Desolace 55.07,79.40
step
kill Jugkar Grim'rod##5771 |q 1488/2 |goto Desolace 55.91,77.76
|tip Avoid Lord Azrethoc.
|tip {o}Level 40 elite{} brown demon with wings.
|tip Walks around nearby.
step
kill Lord Azrethoc##5760 |q 1488/1 |goto Desolace/0 56.02,77.76
|tip {o}Level 40 elite{} brown demon with wings.
|tip Pretty easy to solo.
|tip Walks around.
|tip May need help.
|mapmarker Desolace/0 57.55,79.16
|mapmarker Desolace/0 59.15,78.04
|mapmarker Desolace/0 58.02,75.54
|mapmarker Desolace/0 57.45,73.42
|mapmarker Desolace/0 55.91,73.14
step
use Crate of Ghost Magnets##15848
|tip Next to huge bones.
|tip Kill nearby enemies to clear the area first.
kill Magrami Spectre##11560+
|tip Ghost centaurs.
|tip Walking towards the {o}spinning object{}.
|tip Become {r}hostile{} when they reach it.
|tip Pull them away to fight them.
|tip Won't pull together if {y}neutral{}.
|tip Will pull together if {r}hostile{}.
|tip Can wait for them to despawn and use item again.
|tip Slower, but much safer.
collect 8 Ghost-o-plasm##15849 |q 6134/1 |goto Desolace 63.81,91.27
step
kill Khan Jehn##5601
|tip Walks around.
|tip In and out of the tent.
collect Khan Jehn's Head##6072 |q 1374/1 |goto Desolace 66.39,80.08
step
Follow the path up |goto Desolace/0 57.42,56.45 < 20 |only if walking
talk Takata Steelblade##5641
turnin The Corrupter##1488 |goto Desolace 52.57,54.38
step
talk Hornizz Brimbuzzle##6019
turnin Ghost-o-plasm Round Up##6134 |goto Desolace 47.83,61.82
step
talk Uthek the Wise##5397
turnin Khan Jehn##1374 |goto Desolace 36.22,79.25
step
Follow the path into Shadowprey Village |goto Desolace 26.27,74.83 < 40 |only if walking and not subzone("Shadowprey Village")
talk Taiga Wisemane##11624
turnin Portals of the Legion##5581 |goto Desolace 25.81,68.22
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Tanaris (41-42)",{
image=ZGV.IMAGESDIR.."Tanaris",
hardcore = true,
next="Leveling Guides\\Dustwallow Marsh (42-42)",
},[[
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Tran'rek##7876
turnin Tran'rek##2864 |goto Tanaris 51.57,26.76
step
talk Spigot Operator Luglunket##7408
accept Water Pouch Bounty##1707 |goto Tanaris 52.48,28.44
step
talk Chief Engineer Bilgewhizzle##7407
turnin Into the Field##243 |goto Tanaris 52.46,28.51
accept Slake That Thirst##379 |goto Tanaris 52.46,28.51
accept Wastewander Justice##1690 |goto Tanaris 52.46,28.51
step
talk Laziphus##9985
Stable Your Pet |stablemaster Laziphus##9985 |goto Tanaris/0 52.25,28.00 |q 1690
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 6){}.
|only if Hunter
step
Learn the {y}Claw (Rank 6){} Pet Ability |learnspell Claw##2976 |goto Tanaris/0 50.00,31.00 |q 1690
|tip Cast {o}Tame Beast{} on a {o}Scorpid Hunter{}.
|tip Scorpions.
|tip Kill enemies nearby.
|mapmarker Tanaris/0 47.00,25.40
|mapmarker Tanaris/0 47.00,31.80
|mapmarker Tanaris/0 47.20,28.60
|mapmarker Tanaris/0 51.20,34.40
|mapmarker Tanaris/0 52.40,24.40
|mapmarker Tanaris/0 53.20,31.20
|mapmarker Tanaris/0 53.80,36.80
|mapmarker Tanaris/0 55.20,25.60
|mapmarker Tanaris/0 55.20,33.80
|mapmarker Tanaris/0 56.80,23.00
|mapmarker Tanaris/0 57.20,31.00
|mapmarker Tanaris/0 59.00,26.40
|only if Hunter
step
talk Laziphus##9985
Retrieve Your Pet |stablemaster Laziphus##9985 |goto Tanaris/0 52.25,28.00 |q 1690
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 6){} to Your Pet |learnpetspell Claw##16832 |q 1690
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.99,22.36
step
talk Stoley##7881
|tip Inside the building.
turnin Stoley's Debt##2872 |goto Tanaris 67.11,23.98
stickystart "Kill_Wastewander_Bandits_And_Thieves"
step
label "Collect_Wastewander_Water_Pouches"
kill Wastewander Shadow Mage##5617, Wastewander Thief##5616, Wastewander Bandit##5618, Wastewander Rogue##5615, Wastewander Assassin##5623
|tip Humans.
collect 10 Wastewander Water Pouch##8483 |goto Tanaris 62.80,30.40 |multiq 379,1707
|tip Don't vendor them.
|mapmarker Tanaris/0 59.80,24.00
|mapmarker Tanaris/0 63.20,32.40
|mapmarker Tanaris/0 63.20,34.60
|mapmarker Tanaris/0 64.00,28.40
|mapmarker Tanaris/0 65.20,32.80
step
label "Kill_Wastewander_Bandits_And_Thieves"
kill 10 Wastewander Bandit##5618 |q 1690/1 |goto Tanaris 62.80,30.40
kill 10 Wastewander Thief##5616 |q 1690/2 |goto Tanaris 62.80,30.40
|mapmarker Tanaris/0 59.80,24.00
|mapmarker Tanaris/0 63.20,32.40
|mapmarker Tanaris/0 63.20,34.60
|mapmarker Tanaris/0 64.00,28.40
|mapmarker Tanaris/0 65.20,32.80
step
Kill enemies
|tip Higher level enemy soon.
ding 42 |goto Tanaris 62.80,30.40
|mapmarker Tanaris/0 59.80,24.00
|mapmarker Tanaris/0 63.20,32.40
|mapmarker Tanaris/0 63.20,34.60
|mapmarker Tanaris/0 64.00,28.40
|mapmarker Tanaris/0 65.20,32.80
step
talk Chief Engineer Bilgewhizzle##7407
turnin Slake That Thirst##379 |goto Tanaris 52.46,28.51
turnin Wastewander Justice##1690 |goto Tanaris 52.46,28.51
step
talk Spigot Operator Luglunket##7408
turnin Water Pouch Bounty##1707 |goto Tanaris 52.48,28.44
step
_Destroy This Item:_
|tip Not needed.
|tip Loot it.
trash Gadgetzan Water Co. Care Package##8484
step
talk Innkeeper Fizzgrimble##7733
|tip Inside the building.
home Gadgetzan |goto Tanaris 52.51,27.92 |q 2974 |future
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Model 4711-FTZ Power Source##8524	|goto Tanaris 52.30,28.91 |q 654 |future
bank Yeh'kinya's Bramble##10699		|goto Tanaris 52.30,28.91 |q 3520
step
talk Kravel Koalbeard##4452
turnin Rumors for Kravel##1117 |goto Thousand Needles 77.79,77.27
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Back to Booty Bay##1118 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin News for Fizzle##1137 |goto Thousand Needles 78.06,77.13
step
talk Pozzik##4630
turnin Goblin Sponsorship##1183 |goto Thousand Needles 80.18,75.88
accept The Eighteenth Pilot##1186 |goto Thousand Needles 80.18,75.88
accept Keeping Pace##1190 |goto Thousand Needles 80.18,75.88
step
talk Razzeric##4706
turnin The Eighteenth Pilot##1186 |goto Thousand Needles 80.33,76.09
accept Razzeric's Tweaking##1187 |goto Thousand Needles 80.33,76.09
step
talk Zamek##4709
accept Zamek's Distraction##1191 |goto Thousand Needles 79.81,77.02
|only if haveq(1190)
step
click Rizzle's Unguarded Plans
|tip Wait for Rizzle to run away.
|tip Inside the building.
turnin Keeping Pace##1190 |goto Thousand Needles/0 77.21,77.38
accept Rizzle's Schematics##1194 |goto Thousand Needles/0 77.21,77.38
step
talk Pozzik##4630
turnin Rizzle's Schematics##1194 |goto Thousand Needles 80.18,75.88
step
_Destroy This Item:_
|tip Not needed.
trash Sample of Indurium Ore##5866
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Kravel's Scheme##5826 |goto Tanaris 52.30,28.91 |q 1118 |future
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Dustwallow Marsh (42-42)",{
image=ZGV.IMAGESDIR.."Dustwallow Marsh",
hardcore = true,
next="Leveling Guides\\Tanaris (42-43)",
},[[
step
talk Overlord Mok'Morokk##4500
accept Overlord Mok'Morokk's Concern##1166 |goto Dustwallow Marsh 36.30,31.42
step
talk Draz'Zilb##4501
|tip Inside the small cave.
accept Identifying the Brood##1169 |goto Dustwallow Marsh 37.15,33.08
step
talk Tharg##4502
accept Army of the Black Dragon##1168 |goto Dustwallow Marsh 37.37,31.39
step
map Dustwallow Marsh
path	follow strictbounce;	loop off;	ants curved;	dist 30;	markers none;		arrow hide
path	47.10,51.36	47.61,52.53	47.61,53.26	47.05,54.32	46.40,54.20
path	45.65,52.97	46.41,54.19	47.57,54.87	47.75,55.92	45.92,61.67
path	44.65,62.27	45.91,61.67	47.62,56.05	48.13,55.79	48.92,57.12
path	49.56,56.90	50.94,54.14	50.94,53.28	49.93,52.67
kill Deadmire##4841
|tip White crocodile.
|tip Walks a large pattern in the water.
collect Deadmire's Tooth##5945 |q 1205/1
step
click Gizmorium Shipping Crate
collect Seaforium Booster##5862 |q 1187/1 |goto Dustwallow Marsh 54.07,56.49
step
kill Muckshell Razorclaw##4405, Muckshell Scrabbler##4404, Muckshell Clacker##4401, Muckshell Pincer##4403
collect Jeweled Pendant##5942 |q 1261/1 |goto Dustwallow Marsh/0 56.40,60.40
|tip Low drop rate.
|mapmarker Dustwallow Marsh/0 52.80,63.00
|mapmarker Dustwallow Marsh/0 54.80,62.20
|mapmarker Dustwallow Marsh/0 54.80,64.20
|mapmarker Dustwallow Marsh/0 57.60,62.20
stickystart "Kill_Firemane_Scouts_And_Ash_Tails"
stickystart "Collect_Searing_Tongues_And_Searing_Hearts"
step
Follow the path up |goto Dustwallow Marsh/0 55.55,65.32 < 20 |only if walking and subzone("Tidefury Cove")
click Mok'Morokk's Snuff
collect Mok'Morokk's Snuff##5834 |q 1166/1 |goto Dustwallow Marsh/0 44.53,66.04
step
click Mok'Morokk's Grog
collect Mok'Morokk's Grog##5835 |q 1166/2 |goto Dustwallow Marsh/0 38.67,65.58
stickystop "Collect_Searing_Tongues_And_Searing_Hearts"
stickystart "Kill_Firemane_Scalebanes"
step
Enter the cave |goto Dustwallow Marsh/0 38.41,66.04 < 15 |walk |only if not (subzone("The Den of Flame") and indoors())
click Mok'Morokk's Strongbox
|tip Inside the cave.
collect Mok'Morokk's Strongbox##5836 |q 1166/3 |goto Dustwallow Marsh/0 36.64,69.57
step
label "Kill_Firemane_Scalebanes"
kill 5 Firemane Scalebane##4328 |q 1168/3 |goto Dustwallow Marsh/0 38.46,65.96
|tip Inside the cave. |notinsticky
|mapmarker Dustwallow Marsh/0 36.40,69.40
|mapmarker Dustwallow Marsh/0 38.00,68.20
stickystart "Collect_Searing_Tongues_And_Searing_Hearts"
step
label "Kill_Firemane_Scouts_And_Ash_Tails"
Leave the cave |goto Dustwallow Marsh/0 38.46,65.96 < 15 |walk |only if subzone("The Den of Flame") and indoors()
kill 10 Firemane Ash Tail##4331 |q 1168/2 |goto Dustwallow Marsh/0 42.00,67.20
kill 15 Firemane Scout##4329 |q 1168/1 |goto Dustwallow Marsh/0 42.00,67.20
|mapmarker Dustwallow Marsh/0 36.80,69.00
|mapmarker Dustwallow Marsh/0 38.46,65.96
|mapmarker Dustwallow Marsh/0 43.60,69.20
|mapmarker Dustwallow Marsh/0 43.80,65.40
|mapmarker Dustwallow Marsh/0 46.00,67.20
step
label "Collect_Searing_Tongues_And_Searing_Hearts"
kill Searing Whelp##4324, Searing Hatchling##4323
|tip Small flying dragons.
collect 15 Searing Tongue##5840 |q 1169/1 |goto Dustwallow Marsh/0 41.00,74.60
collect 15 Searing Heart##5841 |q 1169/2 |goto Dustwallow Marsh/0 41.00,74.60
|mapmarker Dustwallow Marsh/0 37.40,74.20
|mapmarker Dustwallow Marsh/0 40.60,70.80
|mapmarker Dustwallow Marsh/0 46.40,77.00
|mapmarker Dustwallow Marsh/0 41.20,77.60
|mapmarker Dustwallow Marsh/0 41.80,80.80
|mapmarker Dustwallow Marsh/0 42.60,68.40
|mapmarker Dustwallow Marsh/0 43.40,65.00
|mapmarker Dustwallow Marsh/0 45.40,73.20
|mapmarker Dustwallow Marsh/0 45.80,84.40
|mapmarker Dustwallow Marsh/0 47.20,67.00
|mapmarker Dustwallow Marsh/0 47.60,70.20
|mapmarker Dustwallow Marsh/0 48.20,80.40
|mapmarker Dustwallow Marsh/0 50.20,72.20
|mapmarker Dustwallow Marsh/0 51.80,67.40
|mapmarker Dustwallow Marsh/0 54.20,70.60
step
talk Draz'Zilb##4501
|tip Inside the small cave.
turnin Identifying the Brood##1169 |goto Dustwallow Marsh/0 37.15,33.08
step
Watch the dialogue
|tip Inside the small cave.
talk Draz'Zilb##4501
accept The Brood of Onyxia##1170 |goto Dustwallow Marsh/0 37.15,33.08
step
talk Tharg##4502
turnin Army of the Black Dragon##1168 |goto Dustwallow Marsh/0 37.37,31.39
step
talk Overlord Mok'Morokk##4500
turnin Overlord Mok'Morokk's Concern##1166 |goto Dustwallow Marsh/0 36.30,31.42
turnin The Brood of Onyxia##1170 |goto Dustwallow Marsh/0 36.30,31.42
accept The Brood of Onyxia##1171 |goto Dustwallow Marsh/0 36.30,31.42
step
talk Draz'Zilb##4501
|tip Inside the small cave.
turnin The Brood of Onyxia##1171 |goto Dustwallow Marsh/0 37.15,33.08
step
talk Nazeer Bloodpike##4791
turnin Marg Speaks##1261 |goto Dustwallow Marsh/0 35.21,30.66
accept Report to Zor##1262 |goto Dustwallow Marsh/0 35.21,30.66
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 654 |future
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 654 |future
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 654 |future
|only if Priest
step
talk Zor Lonetree##4047
|tip Inside the building.
turnin Report to Zor##1262 |goto Orgrimmar 38.93,38.38
accept Service to the Horde##7541 |goto Orgrimmar 38.93,38.38 |instant
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 654 |future
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 654 |future
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 654 |future
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 654 |future
|only if Warlock
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 654 |future
|only if Warrior
step
talk Belgrom Rockmaul##4485
accept A Threat in Feralas##2981 |goto Orgrimmar/0 75.22,34.22
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 654 |future
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 654 |future
|only if Hunter
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Tanaris (42-43)",{
image=ZGV.IMAGESDIR.."Tanaris",
hardcore = true,
next="Leveling Guides\\Feralas (43-44)",
},[[
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Field Testing Kit##8523			|goto Tanaris 52.30,28.91 |q 654 |future
collect Model 4711-FTZ Power Source##8524	|goto Tanaris 52.30,28.91 |q 654 |future
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Deadmire's Tooth##5945 |goto Tanaris 52.30,28.91 |q 1205
bank Seaforium Booster##5862 |goto Tanaris 52.30,28.91 |q 1187
step
talk Senior Surveyor Fizzledowser##7724
accept Gadgetzan Water Survey##992 |goto Tanaris 50.21,27.48
|only if not hardcore()
step
_NOTE:_
Long Timed Quest
|tip Next quest has a {o}2 hour{} timer.
|tip Counts down even when logged off.
|tip Time consuming to get quest again if failed.
|tip Only accept quest if you have the time.
Keep All Untested Samples
|tip During the quest, you get various {o}Untested Samples{}.
|tip Don't destroy any, even if quest complete.
|tip May abandon the quest.
Click Here to Continue |confirm |q 654 |future
step
use Model 4711-FTZ Power Source##8524
|tip Starts {o}2 hour{} timed quest.
|tip Counts down even when logged off.
|tip Only accept quest if you have the time.
accept Tanaris Field Sampling##654
stickystart "Collect_Acceptable_Scorpid_Samples"
stickystart "Collect_Acceptable_Hyena_Samples"
stickystart "Collect_Acceptable_Basilisk_Samples"
step
use Untapped Dowsing Widget##8584
|tip Avoid {o}elite enemies{}.
|tip You will be attacked.
|tip Careful, {o}two higher level enemies{}.
|tip Run away quickly.
collect Tapped Dowsing Widget##8585 |q 992/1 |goto Tanaris 39.09,29.17
|only if not hardcore()
step
label "Collect_Acceptable_Scorpid_Samples"
kill Scorpid Hunter##5422+
|tip Scorpions.
collect Untested Scorpid Sample##9442+ |n
use Untested Scorpid Sample##9442+
collect 8 Acceptable Scorpid Sample##9438 |q 654/3 |goto Tanaris 53.20,31.20
|mapmarker Tanaris/0 47.00,25.40
|mapmarker Tanaris/0 47.00,31.80
|mapmarker Tanaris/0 47.20,28.60
|mapmarker Tanaris/0 50.20,31.20
|mapmarker Tanaris/0 51.20,34.40
|mapmarker Tanaris/0 52.40,24.40
|mapmarker Tanaris/0 53.80,36.80
|mapmarker Tanaris/0 55.20,33.80
|mapmarker Tanaris/0 55.80,24.40
|mapmarker Tanaris/0 57.20,31.00
|mapmarker Tanaris/0 57.80,27.00
|mapmarker Tanaris/0 58.00,22.20
|mapmarker Tanaris/0 61.00,29.40
|mapmarker Tanaris/0 62.60,24.20
|mapmarker Tanaris/0 63.60,19.80
|mapmarker Tanaris/0 65.40,26.40
step
label "Collect_Acceptable_Hyena_Samples"
kill Starving Blisterpaw##5425+
|tip Hyenas.
collect Untested Hyena Sample##9439+ |n
use Untested Hyena Sample##9439+
collect 8 Acceptable Hyena Sample##9441 |q 654/2 |goto Tanaris 50.20,31.60
|mapmarker Tanaris/0 39.40,21.40
|mapmarker Tanaris/0 39.60,24.40
|mapmarker Tanaris/0 42.20,26.60
|mapmarker Tanaris/0 43.60,23.40
|mapmarker Tanaris/0 44.40,29.60
|mapmarker Tanaris/0 46.40,25.40
|mapmarker Tanaris/0 47.00,31.60
|mapmarker Tanaris/0 48.40,28.60
|mapmarker Tanaris/0 49.20,37.00
|mapmarker Tanaris/0 51.40,34.60
|mapmarker Tanaris/0 52.40,24.40
|mapmarker Tanaris/0 53.20,31.20
|mapmarker Tanaris/0 53.80,36.80
|mapmarker Tanaris/0 55.40,33.80
|mapmarker Tanaris/0 55.60,24.40
|mapmarker Tanaris/0 57.20,31.00
|mapmarker Tanaris/0 58.00,27.00
|mapmarker Tanaris/0 58.20,22.40
|mapmarker Tanaris/0 60.80,29.60
|mapmarker Tanaris/0 62.00,20.80
|mapmarker Tanaris/0 62.40,24.20
|mapmarker Tanaris/0 64.80,27.20
|mapmarker Tanaris/0 65.60,20.00
step
label "Collect_Acceptable_Basilisk_Samples"
kill Glasshide Basilisk##5419+
collect Untested Basilisk Sample##9437+ |n
use Untested Basilisk Sample##9437+
collect 8 Acceptable Basilisk Sample##9440 |q 654/1 |goto Tanaris 49.40,31.00
|mapmarker Tanaris/0 40.20,39.80
|mapmarker Tanaris/0 41.20,36.80
|mapmarker Tanaris/0 42.40,27.00
|mapmarker Tanaris/0 42.40,30.00
|mapmarker Tanaris/0 42.60,33.00
|mapmarker Tanaris/0 43.80,39.00
|mapmarker Tanaris/0 44.20,23.40
|mapmarker Tanaris/0 45.20,28.60
|mapmarker Tanaris/0 45.40,35.40
|mapmarker Tanaris/0 46.40,25.60
|mapmarker Tanaris/0 46.40,31.40
|mapmarker Tanaris/0 47.20,40.60
|mapmarker Tanaris/0 48.40,28.00
|mapmarker Tanaris/0 48.40,35.80
|mapmarker Tanaris/0 50.20,40.00
|mapmarker Tanaris/0 51.20,34.20
|mapmarker Tanaris/0 52.40,31.00
|mapmarker Tanaris/0 53.20,36.80
|mapmarker Tanaris/0 55.00,32.60
|mapmarker Tanaris/0 55.00,40.20
|mapmarker Tanaris/0 56.20,36.20
|mapmarker Tanaris/0 57.80,31.40
step
talk Chief Engineer Bilgewhizzle##7407
turnin Tanaris Field Sampling##654 |goto Tanaris 52.46,28.51
step
_Destroy These Items:_
|tip Not needed.
trash Model 4711-FTZ Power Source##8524 |goto Tanaris 52.21,28.57
trash Untested Basilisk Sample##9437 |goto Tanaris 52.21,28.57
trash Untested Hyena Sample##9439 |goto Tanaris 52.21,28.57
trash Untested Scorpid Sample##9442 |goto Tanaris 52.21,28.57
step
talk Senior Surveyor Fizzledowser##7724
turnin Gadgetzan Water Survey##992 |goto Tanaris 50.21,27.48
|only if not hardcore()
step
kill Wastewander Shadow Mage##5617, Wastewander Thief##5616, Wastewander Bandit##5618, Wastewander Rogue##5615, Wastewander Assassin##5623
|tip Humans.
collect Wastewander Water Pouch##8483+ |n
|tip Turn in {o}stacks of 5{} in Gadgetzan for {o}380 xp{}.
expcollect Wastewander Water Pouch##8483,5,380,43
|tip Count will reduce as you grind.
ding 43 |goto Tanaris 62.80,30.40
Turn in Water Pouches at [52.49,28.45]
Ammo available at [67.01,21.99] |only if Hunter
|mapmarker Tanaris/0 59.80,24.00
|mapmarker Tanaris/0 63.20,32.40
|mapmarker Tanaris/0 63.20,34.60
|mapmarker Tanaris/0 64.00,28.40
|mapmarker Tanaris/0 65.20,32.80
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Yeh'kinya's Bramble##10699 |goto Tanaris 52.30,28.91 |q 3520
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Feralas (43-44)",{
image=ZGV.IMAGESDIR.."Feralas",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale (44-45)",
},[[
step
Follow the road up into Feralas |goto Thousand Needles/0 7.68,10.62 < 40 |only if walking and zone("Thousand Needles")
talk Shyn##8020
fpath Camp Mojache |goto Feralas 75.45,44.36
|only if hardcore()
step
talk Orwin Gizzmick##8021
accept Gordunni Cobalt##2987 |goto Feralas 75.70,44.30
stickystart "Accept_Ogres_Of_Feralas"
step
talk Krueg Skullsplitter##4544
accept A New Cloak's Sheen##2973 |goto Feralas 75.94,42.74
step
talk Hadoken Swiftstrider##7875
accept War on the Woodpaw##2862 |goto Feralas 74.91,42.47
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
accept The Mark of Quality##2822 |goto Feralas 74.43,42.91
step
label "Accept_Ogres_Of_Feralas"
talk Rok Orhan##7777
|tip Wearing red armor.
|tip Walks around.
turnin A Threat in Feralas##2981 |goto Feralas 75.60,43.60
accept The Ogres of Feralas##2975 |goto Feralas 75.60,43.60
|mapmarker Feralas/0 73.40,45.40
|mapmarker Feralas/0 74.40,44.00
step
kill Woodpaw Mongrel##5249, Woodpaw Trapper##5251, Woodpaw Brute##5253
|tip Gnolls.
collect 10 Woodpaw Gnoll Mane##9237 |q 2862/1 |goto Feralas 73.00,39.80
|mapmarker Feralas/0 72.20,36.40
stickystart "Collect_Gordunni_Cobalt"
stickystart "Kill_Gordunni_Brutes_Ogres_Ogre_Mages"
step
Follow the path up into Gordunni Outpost |goto Feralas 75.00,35.15 < 20 |only if walking and not subzone("Gordunni Outpost")
Follow the path |goto Feralas 76.29,32.90 < 20 |only if walking
click Gordunni Scroll
|tip White unrolled scroll.
|tip Multiple locations.
collect Gordunni Scroll##9370 |n
use Gordunni Scroll##9370
accept The Gordunni Scroll##2978 |goto Feralas 75.13,29.73 |q 2978 |future
|mapmarker Feralas 75.21,28.71
|mapmarker Feralas 74.51,27.92
|mapmarker Feralas 79.40,34.80
|mapmarker Feralas 80.50,34.30
|mapmarker Feralas 80.80,35.00
step
label "Collect_Gordunni_Cobalt"
use Orwin's Shovel##9466
|tip Next to glowing blue circles.
click Gordunni Dirt Mound+
|tip Piles of dirt that appear.
|tip They {o}glow blue{} if containing quest item.
collect 12 Gordunni Cobalt##9463 |q 2987/1 |goto Feralas 76.70,33.80
|mapmarker Feralas/0 74.60,30.20
|mapmarker Feralas/0 74.80,26.60
|mapmarker Feralas/0 75.10,32.40
|mapmarker Feralas/0 76.70,33.80
|mapmarker Feralas/0 81.60,35.10
|mapmarker Feralas/0 79.50,34.90
step
label "Kill_Gordunni_Brutes_Ogres_Ogre_Mages"
kill 5 Gordunni Brute##5232 |q 2975/3 |goto Feralas 76.70,33.80
kill 10 Gordunni Ogre##5229 |q 2975/1 |goto Feralas 76.70,33.80
kill 10 Gordunni Ogre Mage##5237 |q 2975/2 |goto Feralas 76.70,33.80
|mapmarker Feralas/0 74.60,30.20
|mapmarker Feralas/0 74.80,26.60
|mapmarker Feralas/0 75.10,32.40
|mapmarker Feralas/0 81.60,35.10
|mapmarker Feralas/0 79.50,34.90
step
talk Hadoken Swiftstrider##7875
turnin War on the Woodpaw##2862 |goto Feralas 74.91,42.47
accept Alpha Strike##2863 |goto Feralas 74.91,42.47
stickystart "Accept_Dark_Ceremony"
step
talk Orwin Gizzmick##8021
turnin Gordunni Cobalt##2987 |goto Feralas 75.70,44.31
step
label "Accept_Dark_Ceremony"
talk Rok Orhan##7777
|tip Wearing red armor.
|tip Walks around.
turnin The Ogres of Feralas##2975 |goto Feralas 75.60,43.60
accept The Ogres of Feralas##2980 |goto Feralas 75.60,43.60
turnin The Gordunni Scroll##2978 |goto Feralas 75.60,43.60
accept Dark Ceremony##2979 |goto Feralas 75.60,43.60
|mapmarker Feralas/0 73.40,45.40
|mapmarker Feralas/0 74.40,44.00
step
_NOTE:_
During the Next Steps
|tip {o}Hurry{}, you have a timed quest.
Click Here to Continue |confirm |q 2863
step
kill Sprite Darter##5278+
collect 10 Iridescent Sprite Darter Wing##9369 |q 2973/1 |goto Feralas 69.40,46.80
|mapmarker Feralas/0 64.40,48.40
|mapmarker Feralas/0 66.40,47.80
|mapmarker Feralas/0 68.40,44.80
|mapmarker Feralas/0 68.40,49.20
step
kill 5 Woodpaw Alpha##5258 |q 2863/1 |goto Feralas 68.60,54.20
|mapmarker Feralas 75.48,56.48
|mapmarker Feralas 73.27,56.17
|mapmarker Feralas 72.40,56.55
|mapmarker Feralas 71.42,55.92
|mapmarker Feralas 77.20,56.80
|mapmarker Feralas 69.00,55.80
|mapmarker Feralas 74.34,54.96
step
talk Hadoken Swiftstrider##7875
turnin Alpha Strike##2863 |goto Feralas 74.91,42.46
accept Woodpaw Investigation##2902 |goto Feralas 74.91,42.46
step
talk Krueg Skullsplitter##4544
turnin A New Cloak's Sheen##2973 |goto Feralas 75.94,42.74
accept A Grim Discovery##2974 |goto Feralas 75.94,42.74
step
_Destroy These Items:_
|tip Not needed.
trash Iridescent Sprite Darter Wing##9369
step
click Woodpaw Battle Map
turnin Woodpaw Investigation##2902 |goto Feralas 71.63,55.92
accept The Battle Plans##2903 |goto Feralas 71.63,55.92
step
kill Grimtotem Shaman##7727, Grimtotem Raider##7725, Grimtotem Naturalist##7726
|tip Tauren.
collect 20 Grimtotem Horn##9460 |q 2974/1 |goto Feralas 67.40,46.40
|mapmarker Feralas/0 65.40,47.40
|mapmarker Feralas/0 66.60,38.40
|mapmarker Feralas/0 68.80,39.40
step
talk Hadoken Swiftstrider##7875
turnin The Battle Plans##2903 |goto Feralas 74.91,42.47
accept Zukk'ash Infestation##7730 |goto Feralas 74.91,42.47
accept Stinglasher##7731 |goto Feralas 74.91,42.47
step
talk Krueg Skullsplitter##4544
turnin A Grim Discovery##2974 |goto Feralas 75.94,42.74
accept A Grim Discovery##2976 |goto Feralas 75.94,42.74
step
_Destroy These Items:_
|tip Not needed.
trash Grimtotem Horn##9460
step
talk Innkeeper Greul##7737
home Camp Mojache |goto Feralas 74.80,45.18 |q 621 |future
step
talk Cawind Trueaim##9548
|tip Long grind soon.
|tip Up on the balcony of the building.
Buy Extra Ammo |vendor Cawind Trueaim##9548 |goto Feralas 74.94,45.71 |q 2976 |optional
|only if Hunter
step
_NOTE:_
During the Next Steps
|tip Kill enemies as you walk.
|tip Reduces grinding later.
Click Here to Continue |confirm |q 7731
stickystart "Collect_Zukkash_Carapaces"
step
kill Stinglasher##14661
|tip {o}Level 47{} green flying insect.
|tip Should be able to kill at this level.
|tip Flies around.
|tip Also inside the insect caves, but mostly outside.
collect Stinglasher's Glands##18962 |q 7731/1 |goto Feralas 75.60,61.60
|mapmarker Feralas/0 73.20,63.40
|mapmarker Feralas/0 73.60,64.60
|mapmarker Feralas/0 74.40,62.40
|mapmarker Feralas/0 75.20,60.40
|mapmarker Feralas/0 76.98,61.55
|mapmarker Feralas/0 78.00,62.60
step
label "Collect_Zukkash_Carapaces"
kill Zukk'ash Worker##5246, Zukk'ash Wasp##5245, Zukk'ash Stinger##5244, Zukk'ash Tunneler##5247
|tip Insects.
|tip More inside the insect caves. |notinsticky
collect 20 Zukk'ash Carapace##18961 |q 7730/1 |goto Feralas 75.40,61.20
|mapmarker Feralas/0 72.40,61.20
|mapmarker Feralas/0 72.40,63.40
|mapmarker Feralas/0 74.40,59.40
|mapmarker Feralas/0 74.40,63.60
|mapmarker Feralas/0 76.60,59.40
|mapmarker Feralas/0 76.60,63.00
step
Follow the road |goto Feralas 67.56,49.82 < 40 |only if walking and not subzone("High Wilderness")
kill Vale Screecher##5307+
|tip Red flying snakes.
use Yeh'kinya's Bramble##10699
|tip On their corpses.
talk Screecher Spirit##8612+
|tip Ghosts that appear.
Collect #3# Screecher Spirits |q 3520/1 |goto Feralas 57.40,54.00
|mapmarker Feralas/0 55.40,53.40
|mapmarker Feralas/0 56.40,55.80
|mapmarker Feralas/0 57.00,60.80
|mapmarker Feralas/0 58.60,55.80
|mapmarker Feralas/0 57.40,58.40
|mapmarker Feralas/0 59.00,60.60
|mapmarker Feralas/0 59.20,62.60
stickystart "Kill_Gordunni_Warlocks"
step
kill 5 Gordunni Mauler##5234 |q 2980/3 |goto Feralas 61.80,54.40
|mapmarker Feralas/0 58.60,67.80
|mapmarker Feralas/0 59.00,65.00
|mapmarker Feralas/0 59.40,62.40
|mapmarker Feralas/0 60.40,57.00
stickystop "Kill_Gordunni_Warlocks"
step
kill Frayfeather Hippogryph##5300+
|tip Stagwings and Skystormers won't drop.
collect 10 Long Elegant Feather##4589 |goto Feralas 56.99,64.45 |q 7842 |future
|tip Don't vendor them.
|tip Needed for future quest.
|mapmarker Feralas/0 54.80,60.20
|mapmarker Feralas/0 55.40,63.40
|mapmarker Feralas/0 55.80,66.00
|mapmarker Feralas/0 56.60,61.40
|mapmarker Feralas/0 53.80,66.20
step
Kill enemies
|tip Higher level enemies soon.
|tip Helps reduce grinding later.
|tip Run dungeons, if you prefer.
ding 44,35000 |goto Feralas 56.99,64.45
|mapmarker Feralas/0 54.80,60.20
|mapmarker Feralas/0 55.40,63.40
|mapmarker Feralas/0 55.80,66.00
|mapmarker Feralas/0 56.60,61.40
|mapmarker Feralas/0 53.80,66.20
step
Follow the path up |goto Feralas 54.10,68.24 < 40 |only if walking and not subzone("Frayfeather Highlands")
click Hippogryph Egg
|tip Large white egg.
|tip Multiple locations.
collect Hippogryph Egg##8564 |goto Feralas 56.60,75.90 |q 2741 |future
|tip Don't vendor it.
|tip Needed for future quest.
|mapmarker Feralas/0 55.90,76.00
|mapmarker Feralas/0 56.40,77.40
|mapmarker Feralas/0 56.70,76.70
|mapmarker Feralas/0 57.00,78.20
|mapmarker Feralas/0 58.00,76.30
|mapmarker Feralas/0 58.30,76.80
|mapmarker Feralas/0 58.60,75.60
stickystart "Kill_Gordunni_Warlocks"
stickystart "Kill_Gordunni_Shamans"
step
kill Gordunni Mage-Lord##5239+
collect Gordunni Orb##9371 |q 2979/1 |goto Feralas 58.40,67.60
|mapmarker Feralas/0 57.80,70.20
|mapmarker Feralas/0 58.40,73.40
|mapmarker Feralas/0 60.20,70.40
|mapmarker Feralas/0 60.40,68.00
|mapmarker Feralas/0 61.20,72.20
|mapmarker Feralas/0 62.40,68.00
step
label "Kill_Gordunni_Shamans"
kill 10 Gordunni Shaman##5236 |q 2980/1 |goto Feralas 60.40,68.00
|mapmarker Feralas/0 57.80,70.20
|mapmarker Feralas/0 58.40,67.40
|mapmarker Feralas/0 59.40,65.40
|mapmarker Feralas/0 59.80,63.20
|mapmarker Feralas/0 60.20,70.40
|mapmarker Feralas/0 62.80,68.40
step
label "Kill_Gordunni_Warlocks"
kill 10 Gordunni Warlock##5240 |q 2980/2 |goto Feralas 58.20,66.40
|mapmarker Feralas/0 59.40,64.60
|mapmarker Feralas/0 60.40,57.00
|mapmarker Feralas/0 60.40,71.00
|mapmarker Feralas/0 61.80,54.40
step
kill Feral Scar Yeti##5292, Enraged Feral Scar##5295, Hulking Feral Scar##5293
|tip Yetis.
|tip More through the tunnel.
collect 10 Thick Yeti Hide##8973 |q 2822/1 |goto Feralas 55.40,57.40
|mapmarker Feralas/0 52.40,57.40
|mapmarker Feralas/0 53.40,55.40
|mapmarker Feralas/0 55.20,54.40
|mapmarker Feralas/0 50.40,58.40
|mapmarker Feralas/0 51.80,60.60
step
use OOX-22/FE Distress Beacon##8705
accept Find OOX-22/FE!##2766
|only if itemcount(8705) > 0
step
Run through the tunnel |goto Feralas 55.22,56.39 < 20 |only if walking and (subzone("Feral Scar Vale") and not indoors())
talk Homing Robot OOX-22/FE##7807
|tip In the clearing between the tunnel and cave.
turnin Find OOX-22/FE!##2766 |goto Feralas 53.35,55.70
|only if haveq(2766) or completedq(2766)
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 2822
|only if Druid
stickystart "Accept_The_Gordunni_Orb"
step
talk Witch Doctor Uzer'i##8115
accept A Strange Request##3121 |goto Feralas 74.42,43.36
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin The Mark of Quality##2822 |goto Feralas 74.43,42.91
step
talk Hadoken Swiftstrider##7875
turnin Zukk'ash Infestation##7730 |goto Feralas 74.91,42.47
turnin Stinglasher##7731 |goto Feralas 74.91,42.47
accept Zukk'ash Report##7732 |goto Feralas 74.91,42.47
step
label "Accept_The_Gordunni_Orb"
talk Rok Orhan##7777
|tip Wearing red armor.
|tip Walks around.
turnin The Ogres of Feralas##2980 |goto Feralas 75.60,43.60
turnin Dark Ceremony##2979 |goto Feralas 75.60,43.60
accept The Gordunni Orb##3002 |goto Feralas 75.60,43.60
|mapmarker Feralas/0 73.40,45.40
|mapmarker Feralas/0 74.40,44.00
step
talk Chesmu##8356
|tip Collect from the bank.
|tip Inside the building.
collect Deadmire's Tooth##5945 |goto Thunder Bluff/0 47.13,57.89 |q 1205
step
talk Chesmu##8356
|tip Deposit into the bank.
|tip Inside the building.
bank Long Elegant Feather##4589 |goto Thunder Bluff/0 47.13,57.89 |q 7842 |future
bank Yeh'kinya's Bramble##10699 |goto Thunder Bluff/0 47.13,57.89 |q 3520
bank Hippogryph Egg##8564	|goto Thunder Bluff/0 47.13,57.89 |q 2741 |future
step
talk Melor Stonehoof##3441
turnin Deadmire##1205 |goto Thunder Bluff 61.54,80.91
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 3002
|only if Mage
step
talk Uthel'nay##7311
|tip Inside the building.
turnin The Gordunni Orb##3002 |goto Orgrimmar 39.16,86.24
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 3121
|only if Priest
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 3121
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3121
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3121
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3121
|only if Warlock
step
talk Neeru Fireblade##3216
|tip Inside the tent.
|tip Inside the Cleft of Shadow.
turnin A Strange Request##3121 |goto Orgrimmar 49.49,50.59
accept Return to Witch Doctor Uzer'i##3122 |goto Orgrimmar 49.49,50.59
step
talk Belgrom Rockmaul##4485
turnin A Grim Discovery##2976 |goto Orgrimmar 75.23,34.24
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 7732
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 7732
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
Run up the stairs |goto Orgrimmar 56.33,56.94 < 15 |only if walking
talk Zilzibin Drumlore##7010
|tip Upstairs inside the building.
turnin Zukk'ash Report##7732 |goto Orgrimmar 56.28,46.67
step
talk Karus##3309
|tip Collect from the bank.
|tip Skip any missing pages.
|tip We'll buy them from the Auction House.
|tip Inside the building.
collect Green Hills of Stranglethorn - Page 1##2725 |goto Orgrimmar 49.58,69.12 |q 339 |future
collect Green Hills of Stranglethorn - Page 4##2728 |goto Orgrimmar 49.58,69.12 |q 339 |future
collect Green Hills of Stranglethorn - Page 6##2730 |goto Orgrimmar 49.58,69.12 |q 339 |future
collect Green Hills of Stranglethorn - Page 8##2732 |goto Orgrimmar 49.58,69.12 |q 339 |future
collect Green Hills of Stranglethorn - Page 10##2734 |goto Orgrimmar 49.58,69.12 |q 340 |future
collect Green Hills of Stranglethorn - Page 11##2735 |goto Orgrimmar 49.58,69.12 |q 340 |future
collect Green Hills of Stranglethorn - Page 14##2738 |goto Orgrimmar 49.58,69.12 |q 340 |future
collect Green Hills of Stranglethorn - Page 16##2740 |goto Orgrimmar 49.58,69.12 |q 340 |future
collect Green Hills of Stranglethorn - Page 18##2742 |goto Orgrimmar 49.58,69.12 |q 341 |future
collect Green Hills of Stranglethorn - Page 20##2744 |goto Orgrimmar 49.58,69.12 |q 341 |future
collect Green Hills of Stranglethorn - Page 21##2745 |goto Orgrimmar 49.58,69.12 |q 341 |future
collect Green Hills of Stranglethorn - Page 24##2748 |goto Orgrimmar 49.58,69.12 |q 341 |future
collect Green Hills of Stranglethorn - Page 25##2749 |goto Orgrimmar 49.58,69.12 |q 342 |future
collect Green Hills of Stranglethorn - Page 26##2750 |goto Orgrimmar 49.58,69.12 |q 342 |future
collect Green Hills of Stranglethorn - Page 27##2751 |goto Orgrimmar 49.58,69.12 |q 342 |future
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Neeru's Herb Pouch##9628 |goto Orgrimmar 49.58,69.12 |q 3122
step
talk Auctioneer Thathung##8673
|tip Buy from the Auction House, if possible.
|tip Inside the building.
_Chapter I_
collect Green Hills of Stranglethorn - Page 1##2725 |goto Orgrimmar/0 55.68,62.83 |q 339 |future
collect Green Hills of Stranglethorn - Page 4##2728 |goto Orgrimmar/0 55.68,62.83 |q 339 |future
collect Green Hills of Stranglethorn - Page 6##2730 |goto Orgrimmar/0 55.68,62.83 |q 339 |future
collect Green Hills of Stranglethorn - Page 8##2732 |goto Orgrimmar/0 55.68,62.83 |q 339 |future
_Chapter II_
collect Green Hills of Stranglethorn - Page 10##2734 |goto Orgrimmar/0 55.68,62.83 |q 340 |future
collect Green Hills of Stranglethorn - Page 11##2735 |goto Orgrimmar/0 55.68,62.83 |q 340 |future
collect Green Hills of Stranglethorn - Page 14##2738 |goto Orgrimmar/0 55.68,62.83 |q 340 |future
collect Green Hills of Stranglethorn - Page 16##2740 |goto Orgrimmar/0 55.68,62.83 |q 340 |future
_Chapter III_
collect Green Hills of Stranglethorn - Page 18##2742 |goto Orgrimmar/0 55.68,62.83 |q 341 |future
collect Green Hills of Stranglethorn - Page 20##2744 |goto Orgrimmar/0 55.68,62.83 |q 341 |future
collect Green Hills of Stranglethorn - Page 21##2745 |goto Orgrimmar/0 55.68,62.83 |q 341 |future
collect Green Hills of Stranglethorn - Page 24##2748 |goto Orgrimmar/0 55.68,62.83 |q 341 |future
_Chapter IV_
collect Green Hills of Stranglethorn - Page 25##2749 |goto Orgrimmar/0 55.68,62.83 |q 342 |future
collect Green Hills of Stranglethorn - Page 26##2750 |goto Orgrimmar/0 55.68,62.83 |q 342 |future
collect Green Hills of Stranglethorn - Page 27##2751 |goto Orgrimmar/0 55.68,62.83 |q 342 |future
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale (44-45)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Swamp of Sorrows (45-46)",
},[[
step
click Bubbling Cauldron
accept Speaking with Gan'zulah##586 |goto Stranglethorn Vale 32.22,27.60
step
kill Elder Saltwater Crocolisk##2635
|tip {o}Level 38 elite{} enemies.
|tip Shared spawns with Saltwater Crocolisks.
collect Elder Crocolisk Skin##4105 |q 628/1 |goto Stranglethorn Vale 29.20,22.40
|mapmarker Stranglethorn Vale/0 21.40,15.80
|mapmarker Stranglethorn Vale/0 22.40,19.00
|mapmarker Stranglethorn Vale/0 25.20,19.20
|mapmarker Stranglethorn Vale/0 29.40,25.20
|mapmarker Stranglethorn Vale/0 33.60,32.60
stickystart "Kill_Skullsplitter_Headhunters"
stickystart "Kill_Skullsplitter_Berserkers_And_Hunters"
step
kill Ana'thek the Cruel##1059
|tip Larger troll with wooden mallet.
|tip Walks around with 2 guards.
|tip Sometimes stands inside this small cave.
|tip Careful, {o}dangerous area{}.	|only if hardcore()
collect Broken Armor of Ana'thek##3909 |q 586/4 |goto Stranglethorn Vale/0 44.40,44.40
|mapmarker Stranglethorn Vale/0 44.00,43.00
|mapmarker Stranglethorn Vale/0 45.20,42.20
|mapmarker Stranglethorn Vale/0 46.00,41.00
step
label "Kill_Skullsplitter_Headhunters"
kill 6 Skullsplitter Headhunter##781 |q 586/2 |goto Stranglethorn Vale/0 47.20,43.80
|tip Uncommon.
|mapmarker Stranglethorn Vale/0 46.20,44.60
|mapmarker Stranglethorn Vale/0 47.40,42.00
step
label "Kill_Skullsplitter_Berserkers_And_Hunters"
kill 4 Skullsplitter Berserker##783 |q 586/3 |goto Stranglethorn Vale/0 47.20,39.60
kill 8 Skullsplitter Hunter##669 |q 586/1 |goto Stranglethorn Vale/0 47.20,39.60
|mapmarker Stranglethorn Vale/0 44.40,40.40
|mapmarker Stranglethorn Vale/0 44.40,42.60
|mapmarker Stranglethorn Vale/0 45.40,38.40
|mapmarker Stranglethorn Vale/0 46.60,42.20
step
kill Bhag'thera##728
|tip Unstealthed {o}level 40 elite{} black panther.
|tip Walks around.
|tip Multiple locations.
collect Fang of Bhag'thera##3876 |q 193/1 |goto Stranglethorn Vale 46.37,29.05
|mapmarker Stranglethorn Vale 49.60,24.03
|mapmarker Stranglethorn Vale 48.99,20.20
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##193 |goto Stranglethorn Vale 35.55,10.55
step
talk Barnil Stonepot##716
accept The Green Hills of Stranglethorn##338 |goto Stranglethorn Vale/0 35.66,10.53
step
talk Barnil Stonepot##716
accept Chapter I##339 |goto Stranglethorn Vale/0 35.66,10.53
|only if itemcount(2725) > 0 and itemcount(2728) > 0 and itemcount(2730) > 0 and itemcount(2732) > 0
step
talk Barnil Stonepot##716
turnin Chapter I##339 |goto Stranglethorn Vale/0 35.66,10.53
|only if haveq(339) or completedq(339)
step
talk Barnil Stonepot##716
accept Chapter II##340 |goto Stranglethorn Vale/0 35.66,10.53
|only if itemcount(2734) > 0 and itemcount(2735) > 0 and itemcount(2738) > 0 and itemcount(2740) > 0
step
talk Barnil Stonepot##716
turnin Chapter II##340 |goto Stranglethorn Vale/0 35.66,10.53
|only if haveq(339) or completedq(339)
step
talk Barnil Stonepot##716
accept Chapter III##341 |goto Stranglethorn Vale/0 35.66,10.53
|only if itemcount(2742) > 0 and itemcount(2744) > 0 and itemcount(2745) > 0 and itemcount(2748) > 0
step
talk Barnil Stonepot##716
turnin Chapter III##341 |goto Stranglethorn Vale/0 35.66,10.53
|only if haveq(339) or completedq(339)
step
talk Barnil Stonepot##716
accept Chapter IV##342 |goto Stranglethorn Vale/0 35.66,10.53
|only if itemcount(2749) > 0 and itemcount(2750) > 0 and itemcount(2751) > 0
step
talk Barnil Stonepot##716
turnin Chapter IV##342 |goto Stranglethorn Vale/0 35.66,10.53
|only if haveq(339) or completedq(339)
|delay 0.2
step
talk Barnil Stonepot##716
turnin The Green Hills of Stranglethorn##338 |goto Stranglethorn Vale/0 35.66,10.53
|only if readyq(338) or completedq(338)
step
Abandon the {y}The Green Hills of Stranglethorn{} Quest |complete not haveq(338)
|tip Not needed.
step
click Bubbling Cauldron
turnin Speaking with Gan'zulah##586 |goto Stranglethorn Vale/0 32.22,27.60
accept The Fate of Yenniku##588 |goto Stranglethorn Vale/0 32.22,27.60
step
talk Kin'weelay##2519
turnin The Fate of Yenniku##588 |goto Stranglethorn Vale/0 32.27,27.71
accept The Singing Crystals##589 |goto Stranglethorn Vale/0 32.27,27.71
step
talk Far Seer Mok'thardin##2465
accept Mok'thardin's Enchantment##571 |goto Stranglethorn Vale 32.12,29.24
step
talk Viznik Goldgrubber##2625
|tip Collect from the bank.
collect Kravel's Scheme##5826 |goto Stranglethorn Vale 26.54,76.57 |q 1118
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
turnin Back to Booty Bay##1118 |goto Stranglethorn Vale/0 27.12,77.21
step
Watch the dialogue
|tip {o}Ground floor{} inside the building.
talk Crank Fizzlebub##2498
accept Zanzil's Secret##621 |goto Stranglethorn Vale 27.12,77.21
step
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
accept Scaring Shaky##606 |goto Stranglethorn Vale 27.78,77.07
step
talk First Mate Crazz##2490
accept The Bloodsail Buccaneers##595 |goto Stranglethorn Vale 28.10,76.22
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
turnin Excelsior##628 |goto Stranglethorn Vale 28.29,77.59
step
Run through the tunnel to leave Booty Bay |goto Stranglethorn Vale 28.00,73.46 < 15 |only if walking and (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
kill Elder Mistvale Gorilla##1557+
collect Aged Gorilla Sinew##3862 |q 571/1 |goto Stranglethorn Vale 31.20,68.20
collect 5 Mistvale Giblets##3919 |q 606/1 |goto Stranglethorn Vale 31.20,68.20
|mapmarker Stranglethorn Vale/0 31.00,60.00
|mapmarker Stranglethorn Vale/0 31.20,65.20
|mapmarker Stranglethorn Vale/0 32.80,61.40
|mapmarker Stranglethorn Vale/0 33.20,64.60
|mapmarker Stranglethorn Vale/0 33.60,67.00
|mapmarker Stranglethorn Vale/0 34.60,62.60
step
click Bloodsail Correspondence
turnin The Bloodsail Buccaneers##595 |goto Stranglethorn Vale 27.28,69.52
accept The Bloodsail Buccaneers##597 |goto Stranglethorn Vale 27.28,69.52
step
Run through the tunnel to enter Booty Bay |goto Stranglethorn Vale 29.56,72.51 < 15 |only if walking and not (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
talk "Shaky" Phillipe##2502
turnin Scaring Shaky##606 |goto Stranglethorn Vale 26.90,73.59
accept Return to MacKinley##607 |goto Stranglethorn Vale 26.90,73.59
step
talk First Mate Crazz##2490
turnin The Bloodsail Buccaneers##597 |goto Stranglethorn Vale 28.10,76.21
accept The Bloodsail Buccaneers##599 |goto Stranglethorn Vale 28.10,76.21
step
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Return to MacKinley##607 |goto Stranglethorn Vale 27.78,77.07
accept Voodoo Dues##609 |goto Stranglethorn Vale 27.78,77.07
step
talk Deeg##2488
|tip {o}Top floor{} inside the building.
accept Up to Snuff##587 |goto Stranglethorn Vale 26.92,77.35
step
talk Fleet Master Seahorn##2487
|tip Upstairs on the balcony of the building.
turnin The Bloodsail Buccaneers##599 |goto Stranglethorn Vale 27.17,77.01
accept The Bloodsail Buccaneers##604 |goto Stranglethorn Vale 27.17,77.01
step
talk Dizzy One-Eye##2493
|tip Upper level of the docks.
accept Keep An Eye Out##576 |goto Stranglethorn Vale 28.59,75.90
stickystart "Collect_Bloodsail_Orders"
stickystart "Collect_Dizzys_Eye_And_Snuff"
stickystart "Kill_Bloodsail_Swashbucklers"
step
Run through the tunnel to leave Booty Bay |goto Stranglethorn Vale 28.00,73.46 < 15 |only if walking and (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
Run along the beach |goto Stranglethorn Vale 32.89,73.75 < 50 |only if walking and not subzone("Wild Shore")
click Bloodsail Charts
|tip Brown paper.
|tip Multiple locations.
collect Bloodsail Charts##3920 |q 604/2 |goto Stranglethorn Vale 29.59,80.83
|mapmarker Stranglethorn Vale 27.15,82.69
|mapmarker Stranglethorn Vale 27.74,83.13
step
label "Collect_Bloodsail_Orders"
click Bloodsail Orders
|tip White unrolled scroll.
|tip Multiple locations. |notinsticky
collect Bloodsail Orders##3921 |q 604/3 |goto Stranglethorn Vale 29.59,80.80
|mapmarker Stranglethorn Vale 27.18,82.66
|mapmarker Stranglethorn Vale 27.74,83.13
step
label "Collect_Dizzys_Eye_And_Snuff"
kill Bloodsail Warlock##1564, Bloodsail Swashbuckler##1563, Bloodsail Mage##1562, Bloodsail Raider##1561
collect Dizzy's Eye##3897 |q 576/1 |goto Stranglethorn Vale 27.00,82.80
collect 15 Snuff##3910 |q 587/1 |goto Stranglethorn Vale 27.00,82.80
|mapmarker Stranglethorn Vale/0 29.40,80.40
|mapmarker Stranglethorn Vale/0 32.00,79.60
|mapmarker Stranglethorn Vale/0 33.00,77.00
|mapmarker Stranglethorn Vale/0 29.60,87.40
|mapmarker Stranglethorn Vale/0 33.60,86.60
step
label "Kill_Bloodsail_Swashbucklers"
kill 10 Bloodsail Swashbuckler##1563 |q 604/1 |goto Stranglethorn Vale 27.00,82.80
|mapmarker Stranglethorn Vale/0 29.40,80.40
|mapmarker Stranglethorn Vale/0 32.00,79.60
|mapmarker Stranglethorn Vale/0 33.00,77.00
|mapmarker Stranglethorn Vale/0 29.60,87.40
|mapmarker Stranglethorn Vale/0 33.60,86.60
step
Run through the tunnel to enter Booty Bay |goto Stranglethorn Vale 29.56,72.51 < 15 |only if walking and not (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
talk Dizzy One-Eye##2493
|tip Upper level of the docks.
turnin Keep An Eye Out##576 |goto Stranglethorn Vale 28.59,75.90
step
talk Privateer Bloads##2494
|tip Walks around.
accept Akiris by the Bundle##617 |goto Stranglethorn Vale 27.43,76.78
|mapmarker Stranglethorn Vale 26.76,76.38
step
talk Deeg##2488
|tip {o}Top floor{} inside the building.
turnin Up to Snuff##587 |goto Stranglethorn Vale 26.92,77.35
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
turnin The Bloodsail Buccaneers##604 |goto Stranglethorn Vale 27.17,77.01
step
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##571 |goto Stranglethorn Vale 32.12,29.24
accept Mok'thardin's Enchantment##573 |goto Stranglethorn Vale 32.12,29.24
step
Follow the road to the path |goto Stranglethorn Vale/0 39.02,47.10 < 30 |only if walking and not subzone("Crystalvein Mine")
kill Ironjaw Basilisk##1551+
|tip Inside the cave.
collect 3 Pulsing Blue Shard##3911 |q 589/1 |goto Stranglethorn Vale/0 41.99,50.03
|mapmarker Stranglethorn Vale/0 41.80,47.60
|mapmarker Stranglethorn Vale/0 42.80,45.80
|mapmarker Stranglethorn Vale/0 43.20,49.20
stickystart "Collect_Zanzils_Mixture"
step
Leave the cave |goto Stranglethorn Vale/0 41.99,50.03 < 15 |walk |only if subzone("Crystalvein Mine") and indoors()
kill Maury "Club Foot" Wilkins##2535
collect Maury's Clubbed Foot##3924 |q 609/1 |goto Stranglethorn Vale 35.25,51.26
step
kill Jon-Jon the Crow##2536
collect Jon-Jon's Golden Spyglass##3925 |q 609/2 |goto Stranglethorn Vale 34.93,51.85
step
Follow the path |goto Stranglethorn Vale/0 34.10,54.06 < 20 |only if walking and not (subzone("Ruins of Aboraz") or subzone("The Crystal Shore"))
kill Chucky "Ten Thumbs"##2537
collect Chucky's Huge Ring##3926 |q 609/3 |goto Stranglethorn Vale 40.00,58.24
step
label "Collect_Zanzils_Mixture"
kill Zanzil Zombie##1488, Zanzil Hunter##1489, Zanzil Witch Doctor##1490, Zanzil Naga##1491
|tip Avoid Zanzil the Outcast. 			|only if (subzone("Ruins of Aboraz") or subzone("The Crystal Shore"))
|tip Summons many enemies. 			|only if (subzone("Ruins of Aboraz") or subzone("The Crystal Shore"))
collect 12 Zanzil's Mixture##4016 |q 621/1 |goto Stranglethorn Vale 39.80,57.20
|mapmarker Stranglethorn Vale/0 38.40,56.60
|mapmarker Stranglethorn Vale/0 38.60,58.60
|mapmarker Stranglethorn Vale/0 41.60,56.40
|mapmarker Stranglethorn Vale/0 40.46,59.45
stickystart "Collect_Akiris_Reeds"
stickystart "Kill_Naga_Explorers"
step
Follow the path around the mountain and follow the path up |goto Stranglethorn Vale 27.03,59.49 < 30 |only if walking
Follow the path |goto Stranglethorn Vale 27.35,62.99 < 15 |only if walking
click The Holy Spring
collect Holy Spring Water##737 |q 573/2 |goto Stranglethorn Vale 28.92,61.96
step
label "Collect_Akiris_Reeds"
kill Naga Explorer##1907+
collect 10 Akiris Reed##4029 |q 617/1 |goto Stranglethorn Vale 24.40,64.60
|mapmarker Stranglethorn Vale/0 24.00,62.40
|mapmarker Stranglethorn Vale/0 24.40,59.80
|mapmarker Stranglethorn Vale/0 26.00,62.40
|mapmarker Stranglethorn Vale/0 26.80,59.20
|mapmarker Stranglethorn Vale/0 27.80,61.40
|mapmarker Stranglethorn Vale/0 28.00,64.60
step
label "Kill_Naga_Explorers"
kill 10 Naga Explorer##1907 |q 573/1 |goto Stranglethorn Vale 24.40,64.60
|mapmarker Stranglethorn Vale/0 24.00,62.40
|mapmarker Stranglethorn Vale/0 24.40,59.80
|mapmarker Stranglethorn Vale/0 26.00,62.40
|mapmarker Stranglethorn Vale/0 26.80,59.20
|mapmarker Stranglethorn Vale/0 27.80,61.40
|mapmarker Stranglethorn Vale/0 28.00,64.60
step
Run through the tunnel to enter Booty Bay |goto Stranglethorn Vale 29.56,72.51 < 15 |only if walking and not (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Voodoo Dues##609 |goto Stranglethorn Vale 27.78,77.07
step
talk Privateer Bloads##2494
|tip Walks around.
turnin Akiris by the Bundle##617 |goto Stranglethorn Vale 27.43,76.78
|mapmarker Stranglethorn Vale 26.76,76.38
step
talk Whiskey Slim##2491
|tip {o}Ground floor{} inside the building.
accept Whiskey Slim's Lost Grog##580 |goto Stranglethorn Vale 27.13,77.45
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
turnin Zanzil's Secret##621 |goto Stranglethorn Vale 27.12,77.21
step
talk Innkeeper Skindle##6807
|tip {o}Ground floor{} inside the building.
home Booty Bay |goto Stranglethorn Vale/0 27.04,77.31 |q 2605 |future
step
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##573 |goto Stranglethorn Vale 32.12,29.24
step
talk Kin'weelay##2519
turnin The Singing Crystals##589 |goto Stranglethorn Vale/0 32.27,27.71
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Swamp of Sorrows (45-46)",{
image=ZGV.IMAGESDIR.."Swamp of Sorrows",
hardcore = true,
next="Leveling Guides\\Tanaris & Dustwallow Marsh (46-48)",
},[[
step
talk Fallen Hero of the Horde##7572
accept Fall From Grace##2784 |goto Swamp of Sorrows 34.29,66.13
step
talk Fallen Hero of the Horde##7572
Select _"Why are you here?"_ |gossip 95944
Select _"Continue with your story."_ |gossip 95945
Select _"Tragic..."_ |gossip 98462
Listen to the Tale of Sorrow |q 2784/1 |goto Swamp of Sorrows 34.29,66.13
step
talk Fallen Hero of the Horde##7572
turnin Fall From Grace##2784	 |goto Swamp of Sorrows 34.29,66.13
accept The Disgraced One##2621	 |goto Swamp of Sorrows 34.29,66.13
step
talk Dispatch Commander Ruag##7623
|tip Upstairs inside the building.
turnin The Disgraced One##2621 |goto Swamp of Sorrows 47.79,54.95
accept The Missing Orders##2622 |goto Swamp of Sorrows 47.79,54.95
step
talk Fel'zerul##1443
|tip Upstairs inside the building.
accept The Atal'ai Exile##1429 |goto Swamp of Sorrows 47.93,54.79
step
talk Bengor##7643
|tip Inside the building.
turnin The Missing Orders##2622 |goto Swamp of Sorrows 44.98,57.34
step
talk Tok'Kar##5592
accept Lack of Surplus##699 |goto Swamp of Sorrows 81.32,80.97
step
kill Sawtooth Snapper##1087+
|tip Crocodiles.
|tip Careful, stealthed enemies.
collect 6 Sawtooth Snapper Claw##6168 |q 699/1 |goto Swamp of Sorrows 82.00,73.00
|mapmarker Swamp of Sorrows/0 74.00,15.60
|mapmarker Swamp of Sorrows/0 75.60,18.40
|mapmarker Swamp of Sorrows/0 76.40,12.40
|mapmarker Swamp of Sorrows/0 77.40,21.80
|mapmarker Swamp of Sorrows/0 78.20,25.40
|mapmarker Swamp of Sorrows/0 78.20,31.00
|mapmarker Swamp of Sorrows/0 78.40,16.00
|mapmarker Swamp of Sorrows/0 79.40,28.20
|mapmarker Swamp of Sorrows/0 80.00,18.60
|mapmarker Swamp of Sorrows/0 80.40,22.60
|mapmarker Swamp of Sorrows/0 80.40,65.40
|mapmarker Swamp of Sorrows/0 81.00,33.60
|mapmarker Swamp of Sorrows/0 81.40,25.80
|mapmarker Swamp of Sorrows/0 81.40,69.80
|mapmarker Swamp of Sorrows/0 82.40,30.40
|mapmarker Swamp of Sorrows/0 83.20,59.20
|mapmarker Swamp of Sorrows/0 83.40,22.60
|mapmarker Swamp of Sorrows/0 83.40,36.40
|mapmarker Swamp of Sorrows/0 83.40,39.40
|mapmarker Swamp of Sorrows/0 83.40,64.40
|mapmarker Swamp of Sorrows/0 84.60,26.80
|mapmarker Swamp of Sorrows/0 84.60,71.00
|mapmarker Swamp of Sorrows/0 85.00,32.60
|mapmarker Swamp of Sorrows/0 85.00,67.00
|mapmarker Swamp of Sorrows/0 85.20,54.40
|mapmarker Swamp of Sorrows/0 85.40,61.40
|mapmarker Swamp of Sorrows/0 86.20,40.60
|mapmarker Swamp of Sorrows/0 86.40,35.60
|mapmarker Swamp of Sorrows/0 86.40,58.20
|mapmarker Swamp of Sorrows/0 86.80,51.00
|mapmarker Swamp of Sorrows/0 88.60,55.80
|mapmarker Swamp of Sorrows/0 88.60,60.80
|mapmarker Swamp of Sorrows/0 89.40,44.60
|mapmarker Swamp of Sorrows/0 89.80,52.60
step
talk Tok'Kar##5592
turnin Lack of Surplus##699 |goto Swamp of Sorrows 81.32,80.97
accept Threat From the Sea##1422 |goto Swamp of Sorrows 81.32,80.97
step
talk Katar##5593
turnin Threat From the Sea##1422 |goto Swamp of Sorrows 83.75,80.42
accept Threat From the Sea##1426 |goto Swamp of Sorrows 83.75,80.42
stickystart "Kill_Marsh_Flesheaters"
stickystart "Kill_Marsh_Inkspewers"
step
kill 10 Marsh Murloc##747 |q 1426/1 |goto Swamp of Sorrows 85.20,82.20
|mapmarker Swamp of Sorrows/0 79.40,93.40
|mapmarker Swamp of Sorrows/0 81.40,90.40
|mapmarker Swamp of Sorrows/0 83.00,94.60
|mapmarker Swamp of Sorrows/0 83.20,87.20
|mapmarker Swamp of Sorrows/0 84.60,90.80
|mapmarker Swamp of Sorrows/0 86.20,88.00
|mapmarker Swamp of Sorrows/0 86.40,79.40
|mapmarker Swamp of Sorrows/0 87.80,84.80
|mapmarker Swamp of Sorrows/0 89.20,81.20
step
label "Kill_Marsh_Flesheaters"
kill 10 Marsh Flesheater##751 |q 1426/3 |goto Swamp of Sorrows 86.00,80.20
|mapmarker Swamp of Sorrows/0 87.20,75.60
|mapmarker Swamp of Sorrows/0 88.60,78.40
|mapmarker Swamp of Sorrows/0 89.80,74.00
|mapmarker Swamp of Sorrows/0 90.00,71.00
|mapmarker Swamp of Sorrows/0 91.00,66.40
|mapmarker Swamp of Sorrows/0 92.40,62.20
|mapmarker Swamp of Sorrows/0 92.60,69.40
|mapmarker Swamp of Sorrows/0 93.20,58.80
|mapmarker Swamp of Sorrows/0 93.40,48.40
|mapmarker Swamp of Sorrows/0 93.40,51.80
|mapmarker Swamp of Sorrows/0 93.40,55.20
step
label "Kill_Marsh_Inkspewers"
kill 10 Marsh Inkspewer##750 |q 1426/2 |goto Swamp of Sorrows 86.40,83.00
|mapmarker Swamp of Sorrows/0 80.00,93.80
|mapmarker Swamp of Sorrows/0 81.20,89.20
|mapmarker Swamp of Sorrows/0 83.40,84.40
|mapmarker Swamp of Sorrows/0 83.40,93.60
|mapmarker Swamp of Sorrows/0 84.40,87.60
|mapmarker Swamp of Sorrows/0 84.60,90.80
|mapmarker Swamp of Sorrows/0 85.40,79.40
|mapmarker Swamp of Sorrows/0 88.20,75.40
|mapmarker Swamp of Sorrows/0 88.60,78.40
|mapmarker Swamp of Sorrows/0 90.40,68.60
|mapmarker Swamp of Sorrows/0 90.40,72.40
|mapmarker Swamp of Sorrows/0 92.20,65.20
|mapmarker Swamp of Sorrows/0 93.00,53.80
|mapmarker Swamp of Sorrows/0 93.20,59.60
|mapmarker Swamp of Sorrows/0 93.40,49.60
|mapmarker Swamp of Sorrows/0 93.60,68.80
|mapmarker Swamp of Sorrows/0 95.20,56.00
|mapmarker Swamp of Sorrows/0 95.80,52.20
|mapmarker Swamp of Sorrows/0 95.80,62.80
step
talk Katar##5593
turnin Threat From the Sea##1426 |goto Swamp of Sorrows 83.76,80.43
accept Threat From the Sea##1427 |goto Swamp of Sorrows 83.76,80.43
step
talk Tok'Kar##5592
turnin Threat From the Sea##1427 |goto Swamp of Sorrows 81.31,80.97
step
Kill enemies
ding 46 |goto Swamp of Sorrows 85.20,82.20
|mapmarker Swamp of Sorrows/0 79.40,93.40
|mapmarker Swamp of Sorrows/0 81.40,90.40
|mapmarker Swamp of Sorrows/0 83.00,94.60
|mapmarker Swamp of Sorrows/0 83.20,87.20
|mapmarker Swamp of Sorrows/0 84.60,90.80
|mapmarker Swamp of Sorrows/0 86.20,88.00
|mapmarker Swamp of Sorrows/0 86.40,79.40
|mapmarker Swamp of Sorrows/0 87.80,84.80
|mapmarker Swamp of Sorrows/0 89.20,81.20
step
talk Katar##5593
accept Continued Threat##1428 |goto Swamp of Sorrows 83.76,80.41
step
kill 10 Marsh Inkspewer##750 |q 1428/1 |goto Swamp of Sorrows 66.37,76.54
kill 10 Marsh Flesheater##751 |q 1428/2 |goto Swamp of Sorrows 66.37,76.54
kill 10 Marsh Oracle##752 |q 1428/3 |goto Swamp of Sorrows 66.37,76.54
|tip Inside the cave.
|tip Avoid {o}Swamp Talker{}.
|tip {o}Level 50{} grey murloc.
|mapmarker Swamp of Sorrows/0 60.40,85.40
|mapmarker Swamp of Sorrows/0 61.60,80.40
|mapmarker Swamp of Sorrows/0 62.40,89.00
|mapmarker Swamp of Sorrows/0 63.40,84.40
|mapmarker Swamp of Sorrows/0 64.60,81.60
|mapmarker Swamp of Sorrows/0 65.60,86.60
step
Leave the cave |goto Swamp of Sorrows 66.37,76.54 < 20 |walk |only if subzone("Stagalbog Cave")
talk Katar##5593
turnin Continued Threat##1428 |goto Swamp of Sorrows 83.75,80.42
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 3122
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 3122
|only if Mage
step
_NOTE:_
Timed Quest
|tip Next quest has a {o}2 hour{} timer.
|tip Counts down even when logged off.
|tip You'll complete it within about {o}30 minutes{}.
|tip Don't accept the quest unless you have the time.
Click Here to Continue |confirm |q 1119 |future
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
accept Zanzil's Mixture and a Fool's Stout##1119 |goto Stranglethorn Vale 27.12,77.21
step
talk Viznik Goldgrubber##2625
|tip Collect from the bank.
collect Neeru's Herb Pouch##9628	|goto Stranglethorn Vale/0 26.54,76.57 |q 3122
collect Seaforium Booster##5862		|goto Stranglethorn Vale/0 26.54,76.57 |q 1187
collect Yeh'kinya's Bramble##10699	|goto Stranglethorn Vale/0 26.54,76.57 |q 3520
collect Hippogryph Egg##8564		|goto Stranglethorn Vale/0 26.54,76.57 |q 2741 |future
step
talk Viznik Goldgrubber##2625
|tip Deposit into the bank.
bank Bundle of Atal'ai Artifacts##6193 |goto Stranglethorn Vale 26.54,76.57 |q 1429
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 3122
|only if Priest
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 3122
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3122
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3122
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3122
|only if Warlock
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 3122
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 3122
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Witch Doctor Uzer'i##8115
turnin Return to Witch Doctor Uzer'i##3122 |goto Feralas 74.42,43.36
step
Watch the dialogue
talk Witch Doctor Uzer'i##8115
accept Testing the Vessel##3123 |goto Feralas 74.42,43.36
accept The Sunken Temple##3380 |goto Feralas 74.42,43.36
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Tanaris & Dustwallow Marsh (46-48)",{
image=ZGV.IMAGESDIR.."Tanaris",
hardcore = true,
next="Leveling Guides\\The Hinterlands (48-49)",
},[[
step
talk Kravel Koalbeard##4452
turnin Zanzil's Mixture and a Fool's Stout##1119 |goto Thousand Needles 77.79,77.27
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Get the Gnomes Drunk##1120 |goto Thousand Needles 77.79,77.27
step
talk Gnome Pit Boss##4495
turnin Get the Gnomes Drunk##1120 |goto Thousand Needles 77.56,76.94
step
talk Kravel Koalbeard##4452
accept Report Back to Fizzlebub##1122 |goto Thousand Needles 77.79,77.27
step
talk Razzeric##4706
turnin Razzeric's Tweaking##1187 |goto Thousand Needles 80.33,76.10
accept Safety First##1188 |goto Thousand Needles 80.33,76.10
step
talk Tran'rek##7876
accept Thistleshrub Valley##3362 |goto Tanaris 51.57,26.76
step
talk Shreev##4708
turnin Safety First##1188 |goto Tanaris 50.96,27.24
step
talk Senior Surveyor Fizzledowser##7724
accept Gadgetzan Water Survey##992 |goto Tanaris 50.21,27.48
step
use Untapped Dowsing Widget##8584
|tip Avoid {o}elite enemies{}.
|tip You will be attacked.
|tip Careful, {o}two higher level enemies{}.
|tip Run away quickly.
collect Tapped Dowsing Widget##8585 |q 992/1 |goto Tanaris 39.09,29.17
step
talk Senior Surveyor Fizzledowser##7724
turnin Gadgetzan Water Survey##992 |goto Tanaris 50.21,27.48
step
talk Senior Surveyor Fizzledowser##7724
accept Noxious Lair Investigation##82 |goto Tanaris 50.21,27.48
step
click Wanted Poster
accept WANTED: Caliph Scorpidsting##2781 |goto Tanaris 51.84,27.02
accept WANTED: Andre Firebeard##2875 |goto Tanaris 51.84,27.02
step
click Egg-O-Matic
accept The Super Egg-O-Matic##2741 |goto Tanaris 52.37,26.97 |instant
|delay 0.2
step
use Egg Crate##8647
collect A Bad Egg##8646			|or
collect An Ordinary Egg##8645		|or
collect A Fine Egg##8644		|or
collect An Extraordinary Egg##8643	|or
|only if itemcount(8647) > 0
|delay 0.2
step
talk Curgle Cranklehop##7763
accept A Bad Egg##2750			|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8646) > 0
accept An Ordinary Egg##2749		|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8645) > 0
accept A Fine Egg##2748			|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8644) > 0
accept An Extraordinary Egg##2747	|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8643) > 0
step
talk Andi Lynn##11758
accept The Dunemaul Compound##5863 |goto Tanaris 52.82,27.40
step
talk Chief Engineer Bilgewhizzle##7407
accept More Wastewander Justice##1691 |goto Tanaris 52.46,28.51
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Wildkin Muisek Vessel##9618	|goto Tanaris 52.30,28.91 |q 3123 |future
bank Fool's Stout Report##5807		|goto Tanaris 52.30,28.91 |q 1122 |future
step
talk Marin Noggenfogger##7564
accept The Thirsty Goblin##2605 |goto Tanaris 51.81,28.66
step
talk Haughty Modiste##15165
accept Pirate Hats Ahoy!##8365 |goto Tanaris 66.56,22.27
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.99,22.36
step
talk Jabbey##8139
|tip Long grind soon.
|tip Inside the building.
Buy Extra Ammo |vendor Jabbey##8139 |goto Tanaris/0 67.01,21.99 |q 8365
|only if Hunter
step
talk Security Chief Bilgewhizzle##7882
|tip Inside the building.
accept Southsea Shakedown##8366 |goto Tanaris 67.06,23.89
step
talk Stoley##7881
|tip Inside the building.
accept Stoley's Shipment##2873 |goto Tanaris 67.11,23.98
stickystart "Kill_Wastewander_Assassins_Rogues_Shadow_Mages"
step
map Tanaris/0
path	follow strictbounce;	loop;	ants curved;	dist 40;	markers none;		arrow hide
path	63.84,31.89		63.30,37.23		62.29,37.83		59.52,41.19
path	58.71,38.17		61.87,33.42
kill Caliph Scorpidsting##7847
|tip Walks a large counter-clockwise pattern.
|tip Careful, two stealthed guards.
collect Caliph Scorpidsting's Head##8723 |q 2781/1
Spawns at [Tanaris 58.90,39.30] |noway
step
label "Kill_Wastewander_Assassins_Rogues_Shadow_Mages"
kill 6 Wastewander Assassin##5623 |q 1691/2 |goto Tanaris 60.80,36.60
kill 8 Wastewander Rogue##5615 |q 1691/1 |goto Tanaris 60.80,36.60
|tip Stealthed.
kill 10 Wastewander Shadow Mage##5617 |q 1691/3 |goto Tanaris 60.80,36.60
|mapmarker Tanaris/0 58.40,36.40
|mapmarker Tanaris/0 58.40,38.40
|mapmarker Tanaris/0 60.40,32.40
|mapmarker Tanaris/0 60.40,39.20
|mapmarker Tanaris/0 61.80,34.20
|mapmarker Tanaris/0 63.40,37.40
|mapmarker Tanaris/0 63.40,39.80
|mapmarker Tanaris/0 65.08,39.21
stickystart "Collect_Ship_Schedule"
stickystart "Accept_Find_OOX_17TN"
stickystart "Collect_Southsea_Pirate_Hats"
stickystart "Kill_Southsea_Pirates_And_Freebooters"
stickystart "Kill_Southsea_Dock_Workers"
stickystart "Kill_Southsea_Swashbucklers"
step
Run through the tunnel to enter Lost Rigger Cove |goto Tanaris 68.62,41.46 < 20 |only if walking and not subzone("Lost Rigger Cove")
click Stolen Cargo
|tip Upstairs inside the building.
collect Stoley's Shipment##9244 |q 2873/1 |goto Tanaris 72.19,46.77
step
kill Andre Firebeard##7883
collect Firebeard's Head##9246 |q 2875/1 |goto Tanaris 73.37,47.14
step
label "Collect_Ship_Schedule"
kill Southsea Pirate##7855, Southsea Freebooter##7856, Southsea Dock Worker##7857, Southsea Swashbuckler##7858
collect Pirate's Footlocker##9276+ |n
use Pirate's Footlocker##9276+
collect Ship Schedule##9250 |n
use Ship Schedule##9250
accept Ship Schedules##2876 |goto Tanaris 73.80,46.60 |q 2876 |future
|tip Rare.
|mapmarker Tanaris/0 70.40,42.40
|mapmarker Tanaris/0 71.00,47.20
|mapmarker Tanaris/0 72.40,45.00
|mapmarker Tanaris/0 73.20,48.60
|only if level < 47
step
label "Accept_Find_OOX_17TN"
kill Southsea Pirate##7855, Southsea Freebooter##7856, Southsea Dock Worker##7857, Southsea Swashbuckler##7858
collect OOX-17/TN Distress Beacon##8623 |n
|tip Rare.
use OOX-17/TN Distress Beacon##8623
accept Find OOX-17/TN!##351 |goto Tanaris 73.80,46.60
|mapmarker Tanaris/0 70.40,42.40
|mapmarker Tanaris/0 71.00,47.20
|mapmarker Tanaris/0 72.40,45.00
|mapmarker Tanaris/0 73.20,48.60
|only if level < 47
step
label "Collect_Southsea_Pirate_Hats"
kill Southsea Pirate##7855, Southsea Freebooter##7856, Southsea Dock Worker##7857, Southsea Swashbuckler##7858
collect 20 Southsea Pirate Hat##20519 |q 8365/1 |goto Tanaris 73.80,46.60
|mapmarker Tanaris/0 70.40,42.40
|mapmarker Tanaris/0 71.00,47.20
|mapmarker Tanaris/0 72.40,45.00
|mapmarker Tanaris/0 73.20,48.60
|mapmarker Tanaris/0 76.20,45.60
step
label "Kill_Southsea_Pirates_And_Freebooters"
kill 10 Southsea Pirate##7855 |q 8366/1 |goto Tanaris 73.80,46.60
kill 10 Southsea Freebooter##7856 |q 8366/2 |goto Tanaris 73.80,46.60
|mapmarker Tanaris/0 70.40,42.40
|mapmarker Tanaris/0 71.00,47.20
|mapmarker Tanaris/0 72.40,45.00
|mapmarker Tanaris/0 73.20,48.60
step
label "Kill_Southsea_Dock_Workers"
kill 10 Southsea Dock Worker##7857 |q 8366/3 |goto Tanaris 73.00,47.80
|tip More up on the wooden platforms nearby. |notinsticky
|mapmarker Tanaris/0 74.60,46.40
step
label "Kill_Southsea_Swashbucklers"
kill 10 Southsea Swashbuckler##7858 |q 8366/4 |goto Tanaris 74.40,45.20
|tip More inside buildings. |notinsticky
|mapmarker Tanaris/0 72.20,46.40
|mapmarker Tanaris/0 76.20,45.60
step
Kill enemies
|tip Higher level enemies soon.
|tip Run dungeons, if you prefer.
ding 47 |goto Tanaris 73.80,46.60
Ammo available at [Tanaris/0 67.01,21.99] |only if Hunter
|mapmarker Tanaris/0 70.40,42.40
|mapmarker Tanaris/0 71.00,47.20
|mapmarker Tanaris/0 72.40,45.00
|mapmarker Tanaris/0 73.20,48.60
|mapmarker Tanaris/0 76.20,45.60
step
_NOTE:_
Optional Dungeon Later
|tip Can run {o}Zul'Farrak{} dungeon later.
|tip Slower leveling, but potential gear upgrades.
|tip We'll pick up dungeon quests.
|tip Guide will say when it's time to run the dungeon.
Click Here to Run {y}Zul'Farrak{} Dungeon Later |confirm ZFflag |multiq 3527,2768,2865,3042,2846 |future
|tip Skip if you'd rather grind.
step
Run through the tunnel to leave Lost Rigger Cove |goto Tanaris/0 69.63,42.37 < 20 |only if walking and subzone("Lost Rigger Cove")
talk Security Chief Bilgewhizzle##7882
|tip Inside the building.
turnin WANTED: Andre Firebeard##2875 |goto Tanaris 67.06,23.89
turnin Southsea Shakedown##8366 |goto Tanaris 67.06,23.89
turnin Ship Schedules##2876 |goto Tanaris 67.06,23.89 |only if haveq(2876) or completedq(2876)
step
talk Stoley##7881
|tip Inside the building.
turnin Stoley's Shipment##2873 |goto Tanaris 67.11,23.97
accept Deliver to MacKinley##2874 |goto Tanaris 67.11,23.97
step
talk Haughty Modiste##15165
turnin Pirate Hats Ahoy!##8365 |goto Tanaris 66.56,22.27
step
talk Chief Engineer Bilgewhizzle##7407
turnin WANTED: Caliph Scorpidsting##2781 |goto Tanaris 52.46,28.51
turnin More Wastewander Justice##1691 |goto Tanaris 52.46,28.51
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Stoley's Bottle##9245 |goto Tanaris/0 52.30,28.92 |q 2874
step
talk Marvon Rivetseeker##7771
turnin The Sunken Temple##3380 |goto Tanaris 52.71,45.93
accept The Stone Circle##3444 |goto Tanaris 52.71,45.93
accept Gahz'ridian##3161 |goto Tanaris 52.71,45.93
step
kill Centipaar Wasp##5455, Centipaar Stinger##5456, Centipaar Swarmer##5457, Centipaar Worker##5458, Centipaar Sandreaver##5460, Centipaar Tunneler##5459
|tip Insects.
collect 5 Centipaar Insect Parts##8587 |q 82/1 |goto Tanaris 36.00,40.00
|mapmarker Tanaris/0 30.40,47.40
|mapmarker Tanaris/0 31.20,44.00
|mapmarker Tanaris/0 31.20,52.60
|mapmarker Tanaris/0 33.00,40.40
|mapmarker Tanaris/0 33.40,47.20
|mapmarker Tanaris/0 34.20,37.40
|mapmarker Tanaris/0 34.20,43.20
|mapmarker Tanaris/0 34.20,50.20
|mapmarker Tanaris/0 36.40,45.60
stickystart "Kill_Dunemaul_Brutes_And_Enforcers"
stickystart "Collect_Gahzridian_Ornaments"
step
kill Gor'marok the Ravager##12046 |q 5863/3 |goto Tanaris 41.50,57.81
|tip Inside the small cave.
step
label "Kill_Dunemaul_Brutes_And_Enforcers"
kill 10 Dunemaul Brute##5474 |q 5863/1 |goto Tanaris 40.40,56.00
kill 10 Dunemaul Enforcer##5472 |q 5863/2 |goto Tanaris 40.40,56.00
|mapmarker Tanaris/0 37.40,56.40
|mapmarker Tanaris/0 38.00,59.20
|mapmarker Tanaris/0 38.20,52.20
|mapmarker Tanaris/0 38.40,54.40
|mapmarker Tanaris/0 39.40,50.40
|mapmarker Tanaris/0 40.00,58.00
|mapmarker Tanaris/0 40.40,53.40
|mapmarker Tanaris/0 41.60,51.40
|mapmarker Tanaris/0 42.40,55.20
|mapmarker Tanaris/0 42.60,53.20
step
label "Collect_Gahzridian_Ornaments"
click Gahz'ridian+
|tip Piles of sand.
collect 30 Gahz'ridian Ornament##8443 |q 3161/1 |goto Tanaris/0 48.20,64.70
|mapmarker Tanaris/0 38.90,73.00
|mapmarker Tanaris/0 39.10,70.70
|mapmarker Tanaris/0 40.30,68.90
|mapmarker Tanaris/0 41.10,71.10
|mapmarker Tanaris/0 41.50,73.70
|mapmarker Tanaris/0 45.60,64.60
|mapmarker Tanaris/0 48.10,67.50
stickystart "Kill_Gnarled_Thistleshrubs_And_Rootshapers"
step
kill Thistleshrub Dew Collector##5481+
|tip Shares spawns.
collect Laden Dew Gland##8428 |q 2605/1 |goto Tanaris 29.80,66.80
|mapmarker Tanaris/0 27.40,63.40
|mapmarker Tanaris/0 27.40,67.20
|mapmarker Tanaris/0 29.40,62.40
|mapmarker Tanaris/0 30.40,64.20
step
label "Kill_Gnarled_Thistleshrubs_And_Rootshapers"
kill 8 Gnarled Thistleshrub##5490 |q 3362/1 |goto Tanaris 29.80,66.80
kill 8 Thistleshrub Rootshaper##5485 |q 3362/2 |goto Tanaris 29.80,66.80
|mapmarker Tanaris/0 27.40,63.40
|mapmarker Tanaris/0 27.40,67.20
|mapmarker Tanaris/0 29.40,62.40
|mapmarker Tanaris/0 30.40,64.20
step
talk Marvon Rivetseeker##7771
turnin Gahz'ridian##3161 |goto Tanaris 52.71,45.93
step
talk Marin Noggenfogger##7564
turnin The Thirsty Goblin##2605 |goto Tanaris 51.81,28.66
accept In Good Taste##2606 |goto Tanaris 51.81,28.66
step
talk Innkeeper Fizzgrimble##7733
|tip Inside the building.
home Gadgetzan |goto Tanaris 52.51,27.92 |q 4300 |future
step
talk Andi Lynn##11758
turnin The Dunemaul Compound##5863 |goto Tanaris 52.82,27.40
step
talk Tran'rek##7876
turnin Thistleshrub Valley##3362 |goto Tanaris 51.57,26.76
step
talk Sprinkle##7583
turnin In Good Taste##2606 |goto Tanaris 51.06,26.87
accept Sprinkle's Secret Ingredient##2641 |goto Tanaris 51.06,26.87
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Noxious Lair Investigation##82 |goto Tanaris 50.89,26.96
step
talk Senior Surveyor Fizzledowser##7724
accept The Scrimshank Redemption##10 |goto Tanaris 50.21,27.48
step
talk Homing Robot OOX-17/TN##7784
|tip Escort quest.
|tip Wait until it respawns, if missing.
turnin Find OOX-17/TN!##351 |goto Tanaris 60.23,64.72
step
Enter the cave |goto Tanaris 55.78,68.91 < 15 |walk |only if not (subzone("The Gaping Chasm") and indoors())
Follow the path down |goto Tanaris 57.61,70.67 < 10 |walk
click Scrimshank's Surveying Gear
|tip Inside the cave.
collect Scrimshank's Surveying Gear##8593 |q 10/1 |goto Tanaris 55.97,71.18
step
talk Chief Engineer Bilgewhizzle##7407
accept Return to Apothecary Zinge##864 |goto Tanaris 52.46,28.51
|delay 0.2
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Sealed Field Testing Kit##8527 |goto Tanaris 52.30,28.91 |q 864
step
talk Senior Surveyor Fizzledowser##7724
turnin The Scrimshank Redemption##10 |goto Tanaris 50.21,27.48
accept Insect Part Analysis##110 |goto Tanaris 50.21,27.48
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Insect Part Analysis##110 |goto Tanaris 50.89,26.96
accept Insect Part Analysis##113 |goto Tanaris 50.89,26.96
step
talk Senior Surveyor Fizzledowser##7724
turnin Insect Part Analysis##113 |goto Tanaris 50.21,27.48
accept Rise of the Silithid##32 |goto Tanaris 50.21,27.48
step
kill Wastewander Shadow Mage##5617, Wastewander Thief##5616, Wastewander Bandit##5618, Wastewander Rogue##5615, Wastewander Assassin##5623
|tip Humans.
|tip Careful, stealted enemies.
|tip Higher level zones soon.
|tip Not enough quests to get high enough level.
collect Wastewander Water Pouch##8483+ |n
|tip Turn in {o}stacks of 5{} in Gadgetzan for {o}380 xp{}.
expcollect Wastewander Water Pouch##8483,5,380,48
|tip Count will reduce as you grind.
ding 48 |goto Tanaris 60.80,36.60
Turn in Water Pouches at [52.49,28.45]
Ammo available at [67.01,21.99] |only if Hunter
|mapmarker Tanaris/0 58.40,36.40
|mapmarker Tanaris/0 58.40,38.40
|mapmarker Tanaris/0 60.40,32.40
|mapmarker Tanaris/0 60.40,39.20
|mapmarker Tanaris/0 61.80,34.20
|mapmarker Tanaris/0 63.40,37.40
|mapmarker Tanaris/0 63.40,39.80
|mapmarker Tanaris/0 65.08,39.21
step
_NOTE:_
Begin Finding a Dungeon Group
|tip Good time to run {o}Zul'Farrak{} dungeon soon.
|tip Start looking for a group.
Click Here to Continue |confirm |multiq 3527,2768,2865,3042,2846 |future
|only if guideflag("ZFflag")
step
talk Draz'Zilb##4501
|tip Inside the small cave.
accept The Brood of Onyxia##1172 |goto Dustwallow Marsh/0 37.15,33.08
step
talk Tabetha##6546
|tip Inside the building.
accept Tiara of the Deep##2846 |goto Dustwallow Marsh/0 46.06,57.09
|only if guideflag("ZFflag")
step
click Egg of Onyxia+
|tip Brown spikey eggs.
Destroy #5# Eggs of Onyxia |q 1172/1 |goto Dustwallow Marsh/0 48.39,75.98
|mapmarker Dustwallow Marsh/0 48.47,73.63
|mapmarker Dustwallow Marsh/0 52.28,83.94
|mapmarker Dustwallow Marsh/0 56.02,81.90
|mapmarker Dustwallow Marsh/0 56.66,75.39
|mapmarker Dustwallow Marsh/0 53.57,72.53
step
talk Draz'Zilb##4501
|tip Inside the small cave.
turnin The Brood of Onyxia##1172 |goto Dustwallow Marsh/0 37.15,33.08
step
talk Yeh'kinya##8579
accept The Prophecy of Mosh'aru##3527 |goto Tanaris 66.99,22.36
|only if guideflag("ZFflag")
step
talk Chief Engineer Bilgewhizzle##7407
accept Divino-matic Rod##2768 |goto Tanaris 52.46,28.51
|only if guideflag("ZFflag")
step
talk Tran'rek##7876
accept Scarab Shells##2865 |goto Tanaris 51.57,26.76
|only if guideflag("ZFflag")
step
talk Trenton Lighthammer##7804
accept Troll Temper##3042 |goto Tanaris 51.41,28.75
|only if guideflag("ZFflag")
step
_NOTE:_
Starting Dungeon Run
|tip Running {o}Zul'Farrak{} dungeon now.
|tip Meet with your dungeon group.
Click Here to Continue |confirm |multiq 3527,2768,2865,3042,2846 |future
|only if guideflag("ZFflag")
step
Enter the Zul'Farrak Dungeon |complete zone("Zul'Farrak") |multiq 3527,2768,2865,3042,2846 |future
|tip Follow your group.
|only if guideflag("ZFflag")
stickystart "Collect_Uncracked_Scarab_Shell"
stickystart "Collect_Troll_Temper"
step
_Inside the Zul'Farrak Dungeon:_
kill Theka the Martyr##7272
|tip Second boss.
collect First Mosh'aru Tablet##10660 |q 3527/1
|only if guideflag("ZFflag")
step
_Inside the Zul'Farrak Dungeon:_
kill Sergeant Bly##7604
|tip Killable after releasing them.
|tip Clear the temple event.
collect Divino-matic Rod##8548 |q 2768/1
|only if guideflag("ZFflag")
step
_Inside the Zul'Farrak Dungeon:_
kill Hydromancer Velratha##7795
|tip Follow the path {o}southeast{}.
|tip In large room with pool in the center.
|tip Walks around.
collect Second Mosh'aru Tablet##10661 |q 3527/2
collect Tiara of the Deep##9234 |q 2846/2
|only if guideflag("ZFflag")
step
label "Collect_Uncracked_Scarab_Shell"
_Inside the Zul'Farrak Dungeon:_ |notinsticky
kill Scarab##7269+
|tip Throughout the dungeon.
|tip Mostly in the scarab room with {o}Theka the Martyr{}.
collect 5 Uncracked Scarab Shell##9238 |q 2865/1
|only if guideflag("ZFflag")
step
label "Collect_Troll_Temper"
_Inside the Zul'Farrak Dungeon:_ |notinsticky
kill Sandfury Shadowhunter##7246, Sandfury Soul Eater##7247, Sandfury Blood Drinker##5649, Sandfury Witch Doctor##5650, Sandfury Shadowcaster##5648
|tip Trolls.
|tip Throughout the dungeon.
|tip May require multiple dungeon runs.
collect 20 Troll Temper##9523 |q 3042/1
|only if guideflag("ZFflag")
step
Leave the Zul'Farrak Dungeon |complete not zone("Zul'Farrak") |multiq 3527,2768,2865,3042,2846 |future
|only if guideflag("ZFflag")
step
talk Yeh'kinya##8579
turnin The Prophecy of Mosh'aru##3527 |goto Tanaris 66.99,22.36
|only if guideflag("ZFflag")
step
talk Chief Engineer Bilgewhizzle##7407
turnin Divino-matic Rod##2768 |goto Tanaris 52.46,28.51
|only if guideflag("ZFflag")
step
talk Tran'rek##7876
turnin Scarab Shells##2865 |goto Tanaris 51.57,26.76
|only if guideflag("ZFflag")
step
talk Trenton Lighthammer##7804
turnin Troll Temper##3042 |goto Tanaris 51.41,28.75
|only if guideflag("ZFflag")
step
talk Tabetha##6546
|tip Inside the building.
turnin Tiara of the Deep##2846 |goto Dustwallow Marsh/0 46.06,57.09
|only if guideflag("ZFflag")
step
click Marvon's Chest
collect Stone Circle##10556 |q 3444/1 |goto The Barrens 62.50,38.54
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 32
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 32
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 32
|only if Priest
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 32
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 32
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 32
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 32
|only if Warlock
step
Run up the stairs |goto Orgrimmar/0 56.42,56.92 < 15 |only if walking
talk Zilzibin Drumlore##7010
|tip Inside the building.
turnin Rise of the Silithid##32 |goto Orgrimmar/0 56.27,46.67
step
talk Dran Droffers##6986
|tip Inside the building.
accept Ripple Recovery##649 |goto Orgrimmar/0 59.48,36.59
step
talk Malton Droffers##6987
|tip Inside the building.
turnin Ripple Recovery##649 |goto Orgrimmar/0 59.64,36.92
accept Ripple Recovery##650 |goto Orgrimmar/0 59.64,36.92
step
talk Jes'rimon##8659
|tip Up on the balcony of the building.
accept Bone-Bladed Weapons##4300 |goto Orgrimmar 55.51,34.09
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 864
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 864
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 864
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\The Hinterlands (48-49)",{
image=ZGV.IMAGESDIR.."The Hinterlands",
hardcore = true,
next="Leveling Guides\\Feralas & Un'Goro Crater (49-50)",
},[[
step
talk Auctioneer Thathung##8673
|tip Buy from the Auction House, if possible.
|tip Saves time in Un'Goro Crater.
|tip Inside the building.
collect 7 Red Power Crystal##11186	|goto Orgrimmar 55.69,62.86 |q 4284 |future
collect 7 Yellow Power Crystal##11188	|goto Orgrimmar 55.69,62.86 |q 4284 |future
collect 7 Green Power Crystal##11185	|goto Orgrimmar 55.69,62.86 |q 4284 |future
collect 7 Blue Power Crystal##11184	|goto Orgrimmar 55.69,62.86 |q 4284 |future
step
talk Karus##3309
|tip Collect from the bank.
|tip Inside the building.
collect 10 Long Elegant Feather##4589		|goto Orgrimmar 49.58,69.12 |q 7842 |future
collect Sealed Field Testing Kit##8527		|goto Orgrimmar 49.58,69.12 |q 864
collect Bundle of Atal'ai Artifacts##6193	|goto Orgrimmar 49.58,69.12 |q 1429
collect Wildkin Muisek Vessel##9618		|goto Orgrimmar 49.58,69.12 |q 3123
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Stone Circle##10556		|goto Orgrimmar 49.58,69.12 |q 3444
bank Red Power Crystal##11186		|goto Orgrimmar 49.58,69.12 |q 4284 |future
bank Yellow Power Crystal##11188	|goto Orgrimmar 49.58,69.12 |q 4284 |future
bank Green Power Crystal##11185		|goto Orgrimmar 49.58,69.12 |q 4284 |future
bank Blue Power Crystal##11184		|goto Orgrimmar 49.58,69.12 |q 4284 |future
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Oran Snakewrithe##7825
accept Lines of Communication##2995 |goto Undercity 73.06,32.85
step
Follow the path down |goto Undercity 52.86,77.57 < 10 |walk
talk Apothecary Zinge##5204
turnin Return to Apothecary Zinge##864 |goto Undercity 50.14,67.97
step
talk Kayren Soothallow##2401
|tip Stock up on ammo.
|tip No level 40 ammo in the Hinterlands.
Visit the Vendor |vendor Kayren Soothallow##2401 |goto Hillsbrad Foothills 62.56,19.91 |q 650
|only if Hunter
step
click Venom Bottle
accept Venom Bottles##2933 |goto The Hinterlands/0 22.99,57.72
step
Follow the path up |goto The Hinterlands 20.80,47.91 < 30 |only if walking and not subzone("Shindigger's Camp")
talk Gilveradin Sunchaser##7801
turnin Ripple Recovery##650 |goto The Hinterlands 26.71,48.59
accept A Sticky Situation##77 |goto The Hinterlands 26.71,48.59
step
click Violet Tragan+
|tip Brown mushrooms.
|tip Underwater.
collect Violet Tragan##8526 |q 2641/1 |goto The Hinterlands 41.04,59.79
step
Follow the road around the mountain and run down the path |goto The Hinterlands 72.48,66.10 < 30 |only if walking and not (subzone("Revantusk Village") or subzone("The Overlook Cliffs"))
talk Smith Slagtree##14737
|tip Walks around.
accept Vilebranch Hooligans##7839 |goto The Hinterlands 77.23,80.12
step
talk Lard##14731
|tip Inside the building.
accept Lard Lost His Lunch##7840 |goto The Hinterlands 78.14,81.38
step
talk Katoom the Angler##14740
accept Snapjaws, Mon!##7815 |goto The Hinterlands 80.33,81.53
step
talk Gorkas##4314
fpath Revantusk Village |goto The Hinterlands 81.70,81.76
stickystart "Collect_Pupellyverbos_Port"
stickystart "Kill_Saltwater_Snapjaws"
step
click Lard's Picnic Basket
kill Vilebranch Kidnapper##14748+
|tip Three attack.
collect Lard's Lunch##19034 |q 7840/1 |goto The Hinterlands/0 84.47,41.22
step
label "Collect_Pupellyverbos_Port"
click Pupellyverbos Port
|tip Small blue bottles.
|tip Reduce the {o}Ground Clutter{} setting to {o}1{}.
|tip In {o}System > Graphics{} game settings.
|tip Makes them easier to see.
collect 12 Pupellyverbos Port##3900 |q 580/1 |goto The Hinterlands/0 77.40,70.30 |usebank
|mapmarker The Hinterlands/0 75.40,70.20
|mapmarker The Hinterlands/0 75.70,64.40
|mapmarker The Hinterlands/0 76.00,83.30
|mapmarker The Hinterlands/0 76.10,77.40
|mapmarker The Hinterlands/0 76.20,73.10
|mapmarker The Hinterlands/0 77.70,62.40
|mapmarker The Hinterlands/0 77.80,65.40
|mapmarker The Hinterlands/0 78.00,58.30
|mapmarker The Hinterlands/0 78.20,75.60
|mapmarker The Hinterlands/0 78.40,82.40
|mapmarker The Hinterlands/0 79.30,60.50
|mapmarker The Hinterlands/0 80.00,57.30
|mapmarker The Hinterlands/0 81.00,55.30
|mapmarker The Hinterlands/0 81.40,50.40
step
label "Kill_Saltwater_Snapjaws"
kill 15 Saltwater Snapjaw##2505 |q 7815/1 |goto The Hinterlands/0 78.20,68.20
|mapmarker The Hinterlands/0 74.40,70.80
|mapmarker The Hinterlands/0 75.40,66.40
|mapmarker The Hinterlands/0 76.40,73.40
|mapmarker The Hinterlands/0 77.20,61.40
|mapmarker The Hinterlands/0 78.60,64.20
|mapmarker The Hinterlands/0 79.40,58.00
|mapmarker The Hinterlands/0 80.00,70.80
|mapmarker The Hinterlands/0 80.40,61.60
|mapmarker The Hinterlands/0 81.40,47.40
|mapmarker The Hinterlands/0 81.40,50.40
|mapmarker The Hinterlands/0 81.40,53.60
step
talk Lard##14731
|tip Inside the building.
turnin Lard Lost His Lunch##7840 |goto The Hinterlands 78.14,81.38
step
talk Katoom the Angler##14740
turnin Snapjaws, Mon!##7815 |goto The Hinterlands 80.33,81.53
step
talk Huntsman Markhor##14741
accept Stalking the Stalkers##7828 |goto The Hinterlands 79.16,79.52
accept Hunt the Savages##7829 |goto The Hinterlands 79.16,79.52
accept Avenging the Fallen##7830 |goto The Hinterlands 79.16,79.52
step
talk Otho Moji'ko##14738
|tip Inside the building.
accept Message to the Wildhammer##7841 |goto The Hinterlands/0 79.40,79.09
step
talk Mystic Yayo'jin##14739
|tip Walks around.
|tip Inside the building.
accept Cannibalistic Cousins##7844 |goto The Hinterlands/0 78.80,78.24
stickystart "Kill_Vilebranch__Soothsayers"
stickystart "Kill_Vilebranch_Scalpers"
stickystart "Collect_Skylord_Plume"
stickystart "Kill_Silvermane_Stalkers"
stickystart "Collect_Wildkin_Muiseks"
stickystart "Kill_Savage_Owlbeasts"
step
Follow the path up |goto The Hinterlands/0 76.06,61.17 < 30 |only if walking and (subzone("Revantusk Village") or subzone("The Overlook Cliffs"))
click Slagtree's Lost Tools
|tip Small silver bucket of tools.
|tip Multiple locations.
collect Slagtree's Lost Tools##19033 |q 7839/1 |goto The Hinterlands/0 72.60,53.00
|mapmarker The Hinterlands/0 53.30,38.80
|mapmarker The Hinterlands/0 57.40,42.40
|mapmarker The Hinterlands/0 66.40,44.80
|mapmarker The Hinterlands/0 71.00,48.60
stickystop "Kill_Vilebranch__Soothsayers"
stickystop "Kill_Vilebranch_Scalpers"
step
label "Collect_Skylord_Plume"
kill Razorbeak Skylord##2659+
|tip Large eagle beasts.
|tip Shared spawns with wolves and owlbeasts.
collect Skylord Plume##19025 |q 7830/1 |goto The Hinterlands/0 60.20,50.60
|mapmarker The Hinterlands/0 49.80,50.20
|mapmarker The Hinterlands/0 50.20,45.20
|mapmarker The Hinterlands/0 50.60,55.40
|mapmarker The Hinterlands/0 50.60,59.80
|mapmarker The Hinterlands/0 52.20,48.00
|mapmarker The Hinterlands/0 52.60,51.60
|mapmarker The Hinterlands/0 53.40,58.20
|mapmarker The Hinterlands/0 53.60,43.60
|mapmarker The Hinterlands/0 55.00,53.60
|mapmarker The Hinterlands/0 55.80,48.40
|mapmarker The Hinterlands/0 57.40,51.80
|mapmarker The Hinterlands/0 58.80,55.80
|mapmarker The Hinterlands/0 60.40,47.00
|mapmarker The Hinterlands/0 61.00,41.20
|mapmarker The Hinterlands/0 61.20,57.80
|mapmarker The Hinterlands/0 62.00,54.40
|mapmarker The Hinterlands/0 62.20,44.20
|mapmarker The Hinterlands/0 63.00,49.40
|mapmarker The Hinterlands/0 64.20,56.60
|mapmarker The Hinterlands/0 64.60,46.40
|mapmarker The Hinterlands/0 65.20,53.00
|mapmarker The Hinterlands/0 65.60,60.20
|mapmarker The Hinterlands/0 65.80,42.00
|mapmarker The Hinterlands/0 66.60,49.80
stickystop "Kill_Silvermane_Stalkers"
stickystop "Collect_Wildkin_Muiseks"
stickystop "Kill_Savage_Owlbeasts"
step
click Horde Supply Crate+
|tip Wooden boxes.
|tip Inside the cave.
collect 10 Hinterlands Honey Ripple##8684 |q 77/1 |goto The Hinterlands/0 57.46,38.88
|mapmarker The Hinterlands/0 56.50,43.90
|mapmarker The Hinterlands/0 57.30,41.20
|mapmarker The Hinterlands/0 59.90,42.40
stickystart "Kill_Vilebranch__Soothsayers"
stickystart "Kill_Vilebranch_Scalpers"
stickystart "Collect_Wildkin_Muiseks"
step
Leave the cave |goto The Hinterlands/0 57.46,38.88 < 20 |walk |only if subzone("Skulk Rock") and indoors()
kill 15 Silvermane Howler##2925 |q 7828/2 |goto The Hinterlands/0 46.60,53.60
|tip Wolves.
|mapmarker The Hinterlands/0 35.40,58.20
|mapmarker The Hinterlands/0 35.80,61.60
|mapmarker The Hinterlands/0 37.00,45.60
|mapmarker The Hinterlands/0 37.40,49.40
|mapmarker The Hinterlands/0 38.20,53.40
|mapmarker The Hinterlands/0 38.40,63.20
|mapmarker The Hinterlands/0 38.60,57.60
|mapmarker The Hinterlands/0 39.00,43.20
|mapmarker The Hinterlands/0 40.40,46.60
|mapmarker The Hinterlands/0 40.40,50.20
|mapmarker The Hinterlands/0 41.00,55.60
|mapmarker The Hinterlands/0 41.20,61.80
|mapmarker The Hinterlands/0 42.20,44.00
|mapmarker The Hinterlands/0 42.20,58.40
|mapmarker The Hinterlands/0 42.60,65.00
|mapmarker The Hinterlands/0 43.40,53.80
|mapmarker The Hinterlands/0 43.60,47.00
|mapmarker The Hinterlands/0 44.60,61.60
|mapmarker The Hinterlands/0 45.40,50.40
|mapmarker The Hinterlands/0 45.40,56.40
|mapmarker The Hinterlands/0 47.00,59.00
|mapmarker The Hinterlands/0 47.20,46.40
|mapmarker The Hinterlands/0 49.80,57.40
|mapmarker The Hinterlands/0 49.80,60.60
step
label "Kill_Vilebranch__Soothsayers"
kill 15 Vilebranch Soothsayer##4467 |q 7844/2 |goto The Hinterlands/0 46.80,63.20
|mapmarker The Hinterlands/0 44.40,65.40
|mapmarker The Hinterlands/0 46.00,68.20
|mapmarker The Hinterlands/0 48.00,67.20
|mapmarker The Hinterlands/0 49.60,63.00
stickystart "Kill_Silvermane_Stalkers"
stickystart "Kill_Savage_Owlbeasts"
step
label "Kill_Vilebranch_Scalpers"
kill 30 Vilebranch Scalper##4466 |q 7844/1 |goto The Hinterlands/0 45.60,63.40
|tip Multiple locations. |notinsticky
|mapmarker The Hinterlands/0 43.80,61.80
|mapmarker The Hinterlands/0 44.60,66.80
|mapmarker The Hinterlands/0 47.40,70.60
|mapmarker The Hinterlands/0 50.20,65.80
|mapmarker The Hinterlands/0 50.60,62.40
|mapmarker The Hinterlands/0 52.20,39.40
|mapmarker The Hinterlands/0 53.20,37.40
|mapmarker The Hinterlands/0 54.60,39.40
|mapmarker The Hinterlands/0 65.20,44.40
|mapmarker The Hinterlands/0 65.60,42.40
|mapmarker The Hinterlands/0 67.60,43.80
|mapmarker The Hinterlands/0 69.40,47.40
|mapmarker The Hinterlands/0 70.60,49.20
|mapmarker The Hinterlands/0 72.60,47.20
step
label "Kill_Silvermane_Stalkers"
kill 15 Silvermane Stalker##2926 |q 7828/1 |goto The Hinterlands/0 51.80,49.40
|tip Stealthed wolves.
|mapmarker The Hinterlands/0 51.40,54.40
|mapmarker The Hinterlands/0 51.60,62.60
|mapmarker The Hinterlands/0 51.80,59.60
|mapmarker The Hinterlands/0 54.20,45.40
|mapmarker The Hinterlands/0 54.40,52.40
|mapmarker The Hinterlands/0 57.40,54.00
|mapmarker The Hinterlands/0 58.40,49.40
|mapmarker The Hinterlands/0 60.40,54.40
|mapmarker The Hinterlands/0 61.20,46.80
|mapmarker The Hinterlands/0 62.00,43.40
|mapmarker The Hinterlands/0 62.20,49.80
|mapmarker The Hinterlands/0 63.00,52.80
|mapmarker The Hinterlands/0 65.40,56.40
|mapmarker The Hinterlands/0 66.40,59.40
|mapmarker The Hinterlands/0 66.60,48.00
|mapmarker The Hinterlands/0 67.60,51.40
|mapmarker The Hinterlands/0 68.20,62.40
|mapmarker The Hinterlands/0 68.80,45.40
|mapmarker The Hinterlands/0 69.00,54.40
|mapmarker The Hinterlands/0 70.40,57.40
|mapmarker The Hinterlands/0 70.80,64.40
|mapmarker The Hinterlands/0 71.40,52.00
|mapmarker The Hinterlands/0 71.40,60.40
|mapmarker The Hinterlands/0 73.40,55.40
|mapmarker The Hinterlands/0 74.00,50.40
|mapmarker The Hinterlands/0 76.00,53.40
|mapmarker The Hinterlands/0 78.00,48.40
step
label "Collect_Wildkin_Muiseks"
kill Savage Owlbeast##2929, Primitive Owlbeast##2928
use Wildkin Muisek Vessel##9618
|tip On their corpses.
collect 10 Wildkin Muisek##9594 |q 3123/1 |goto The Hinterlands/0 57.40,50.40
|mapmarker The Hinterlands/0 51.40,45.60
|mapmarker The Hinterlands/0 51.40,49.40
|mapmarker The Hinterlands/0 51.40,54.20
|mapmarker The Hinterlands/0 51.40,58.40
|mapmarker The Hinterlands/0 51.40,61.40
|mapmarker The Hinterlands/0 54.00,41.20
|mapmarker The Hinterlands/0 54.40,44.20
|mapmarker The Hinterlands/0 54.40,50.40
|mapmarker The Hinterlands/0 55.40,53.60
|mapmarker The Hinterlands/0 56.20,46.80
|mapmarker The Hinterlands/0 58.40,54.60
|mapmarker The Hinterlands/0 60.40,47.40
|mapmarker The Hinterlands/0 60.60,57.80
|mapmarker The Hinterlands/0 61.20,41.40
|mapmarker The Hinterlands/0 62.00,54.20
|mapmarker The Hinterlands/0 62.20,50.60
|mapmarker The Hinterlands/0 63.60,44.40
|mapmarker The Hinterlands/0 63.60,57.00
|mapmarker The Hinterlands/0 65.20,52.20
step
label "Kill_Savage_Owlbeasts"
kill 20 Savage Owlbeast##2929 |q 7829/1 |goto The Hinterlands/0 57.40,50.40
|mapmarker The Hinterlands/0 51.40,45.60
|mapmarker The Hinterlands/0 51.40,49.40
|mapmarker The Hinterlands/0 51.40,54.20
|mapmarker The Hinterlands/0 51.40,58.40
|mapmarker The Hinterlands/0 51.40,61.40
|mapmarker The Hinterlands/0 54.00,41.20
|mapmarker The Hinterlands/0 54.40,44.20
|mapmarker The Hinterlands/0 54.40,50.40
|mapmarker The Hinterlands/0 55.40,53.60
|mapmarker The Hinterlands/0 56.20,46.80
|mapmarker The Hinterlands/0 58.40,54.60
|mapmarker The Hinterlands/0 60.40,47.40
|mapmarker The Hinterlands/0 60.60,57.80
|mapmarker The Hinterlands/0 61.20,41.40
|mapmarker The Hinterlands/0 62.00,54.20
|mapmarker The Hinterlands/0 62.20,50.60
|mapmarker The Hinterlands/0 63.60,44.40
|mapmarker The Hinterlands/0 63.60,57.00
|mapmarker The Hinterlands/0 65.20,52.20
stickystart "Kill_Highvale_Marksmen"
stickystart "Kill_Highvale_Outrunners"
stickystart "Kill_Highvale_Rangers"
stickystart "Kill_Highvale_Scouts"
step
click Highvale Records
|tip Inside the building.
Burn the Highvale Records |q 2995/1 |goto The Hinterlands/0 31.98,46.83
step
talk Rin'ji##7780
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Inside the building.
accept Rin'ji is Trapped!##2742 |goto The Hinterlands/0 30.73,46.97 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Rin'ji.
|tip Two groups of three enemies attack.
Escort Rin'ji to Safety |q 2742/1 |goto The Hinterlands/0 34.64,56.38
step
click Highvale Notes
Burn the Highvale Notes |q 2995/2 |goto The Hinterlands/0 29.63,48.66
step
click Highvale Report
Burn the Highvale Report |q 2995/3 |goto The Hinterlands/0 28.56,46.05
step
label "Kill_Highvale_Marksmen"
kill 15 Highvale Marksman##2693 |q 7841/4 |goto The Hinterlands/0 31.74,49.40
|mapmarker The Hinterlands/0 28.40,46.40
|mapmarker The Hinterlands/0 29.20,49.20
|mapmarker The Hinterlands/0 32.00,46.00
|mapmarker The Hinterlands/0 32.40,43.60
step
label "Kill_Highvale_Outrunners"
kill 15 Highvale Outrunner##2691 |q 7841/2 |goto The Hinterlands/0 32.20,51.00
|mapmarker The Hinterlands/0 29.00,51.20
|mapmarker The Hinterlands/0 33.20,42.60
|mapmarker The Hinterlands/0 33.60,53.40
|mapmarker The Hinterlands/0 33.80,48.40
step
label "Kill_Highvale_Rangers"
kill 15 Highvale Ranger##2694 |q 7841/3 |goto The Hinterlands/0 32.40,50.40
|mapmarker The Hinterlands/0 28.40,45.20
|mapmarker The Hinterlands/0 30.40,48.40
|mapmarker The Hinterlands/0 30.80,43.40
|mapmarker The Hinterlands/0 33.40,53.20
step
label "Kill_Highvale_Scouts"
kill 15 Highvale Scout##2692 |q 7841/1 |goto The Hinterlands/0 32.20,50.60
|mapmarker The Hinterlands/0 29.20,48.40
|mapmarker The Hinterlands/0 29.40,50.80
|mapmarker The Hinterlands/0 31.20,48.20
|mapmarker The Hinterlands/0 32.40,43.40
|mapmarker The Hinterlands/0 32.40,45.40
|mapmarker The Hinterlands/0 33.20,48.20
step
use OOX-09/HL Distress Beacon##8704
accept Find OOX-09/HL!##485
|only if itemcount(8704) > 0
step
talk Homing Robot OOX-09/HL##7806
turnin Find OOX-09/HL!##485 |goto The Hinterlands/0 49.35,37.66
|only if haveq(485) or completedq(485)
step
click Rin'ji's Secret
|tip Follow the road down to the coast.
|tip Can also follow the river and jump off the waterfall.
turnin Rin'ji is Trapped!##2742 |goto The Hinterlands/0 86.30,59.01
accept Rin'ji's Secret##2782 |goto The Hinterlands/0 86.30,59.01
step
talk Smith Slagtree##14737
|tip Walks around.
turnin Vilebranch Hooligans##7839 |goto The Hinterlands/0 77.24,80.12
step
talk Mystic Yayo'jin##14739
|tip Walks around.
|tip Inside the building.
turnin Cannibalistic Cousins##7844 |goto The Hinterlands/0 78.80,78.25
step
talk Otho Moji'ko##14738
|tip Inside the building.
turnin Message to the Wildhammer##7841 |goto The Hinterlands/0 79.40,79.08
accept Another Message to the Wildhammer##7842 |goto The Hinterlands/0 79.40,79.08
step
talk Otho Moji'ko##14738
|tip Inside the building.
turnin Another Message to the Wildhammer##7842 |goto The Hinterlands/0 79.40,79.08
accept The Final Message to the Wildhammer##7843 |goto The Hinterlands/0 79.40,79.08 |only if not hardcore()
step
_Destroy These Items:_
|tip Not needed.
trash Long Elegant Feather##4589
step
talk Huntsman Markhor##14741
turnin Stalking the Stalkers##7828 |goto The Hinterlands/0 79.16,79.53
turnin Hunt the Savages##7829 |goto The Hinterlands/0 79.16,79.53
turnin Avenging the Fallen##7830 |goto The Hinterlands/0 79.16,79.53
step
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Venom Bottles##2933 |goto Hillsbrad Foothills 61.44,19.06
accept Undamaged Venom Sac##2934 |goto Hillsbrad Foothills 61.44,19.06
step
use Final Message to the Wildhammer##19036
|tip Avoid Alliance NPC enemies.
|tip Careful, you'll be {o}flagged for PvP{}.
Deliver the Message to the Wildhammer |q 7843/1 |goto The Hinterlands 14.39,48.03
|only if not hardcore()
step
Follow the path up |goto The Hinterlands 20.44,48.08 < 30 |only if walking and not subzone("Shindigger's Camp")
talk Gilveradin Sunchaser##7801
turnin A Sticky Situation##77 |goto The Hinterlands 26.71,48.59
accept Ripple Delivery##81 |goto The Hinterlands 26.71,48.59
step
_Destroy These Items:_
|tip Not needed.
trash Hinterlands Honey Ripple##8684
stickystart "Collect_Undamaged_Venom_Sac"
step
Enter Shadra'Alor |goto The Hinterlands 35.81,63.99 < 30 |only if walking and not subzone("Shadra'Alor")
talk Atal'ai Exile##5598
|tip Up on the ledge.
turnin The Atal'ai Exile##1429 |goto The Hinterlands 33.75,75.21
accept Return to Fel'Zerul##1444 |goto The Hinterlands 33.75,75.21
step
label "Collect_Undamaged_Venom_Sac"
kill Witherbark Broodguard##2686+
|tip Spiders.
collect Undamaged Venom Sac##9322 |q 2934/1 |goto The Hinterlands 34.20,67.00
|mapmarker The Hinterlands/0 29.60,70.60
|mapmarker The Hinterlands/0 31.20,74.00
|mapmarker The Hinterlands/0 32.80,70.80
|mapmarker The Hinterlands/0 35.20,74.40
|mapmarker The Hinterlands/0 37.60,67.60
step
_NOTE:_
During the Next Steps
|tip {o}Hurry{}, timed quest.
Click Here to Continue |confirm |q 2934
step
use OOX-09/HL Distress Beacon##8704
accept Find OOX-09/HL!##485
|only if itemcount(8704) > 0
step
Leave Shadra'Alor |goto The Hinterlands 35.80,64.19 < 30 |only if walking and subzone("Shadra'Alor")
talk Homing Robot OOX-09/HL##7806
turnin Find OOX-09/HL!##485 |goto The Hinterlands/0 49.35,37.66
|only if haveq(485) or completedq(485)
step
Leave Shadra'Alor |goto The Hinterlands/0 35.80,64.19 < 30 |only if walking and subzone("Shadra'Alor")
Follow the road around the mountain and run down the path |goto The Hinterlands/0 72.48,66.10 < 30 |only if walking and not (subzone("Revantusk Village") or subzone("The Overlook Cliffs"))
talk Otho Moji'ko##14738
|tip Inside the building.
turnin The Final Message to the Wildhammer##7843 |goto The Hinterlands/0 79.38,79.08
|only if not hardcore()
step
Leave Shadra'Alor |goto The Hinterlands/0 35.80,64.19 < 30 |only if walking and subzone("Shadra'Alor")
Follow the road around the mountain and run down the path |goto The Hinterlands/0 72.48,66.10 < 30 |only if walking and not (subzone("Revantusk Village") or subzone("The Overlook Cliffs"))
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Undamaged Venom Sac##2934 |goto Hillsbrad Foothills 61.44,19.07
step
talk Oran Snakewrithe##7825
turnin Lines of Communication##2995 |goto Undercity 73.07,32.85
turnin Rin'ji's Secret##2782 |goto Undercity 73.07,32.85
accept Ora's Gratitude##8273 |goto Undercity 73.07,32.85 |instant
step
Follow the path down |goto Undercity 52.86,77.57 < 10 |walk
talk Chemist Cuely##8390
accept Seeping Corruption##3568 |goto Undercity 48.71,71.42
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Sprinkle##7583
turnin Sprinkle's Secret Ingredient##2641 |goto Tanaris 51.06,26.87
step
Watch the dialogue
talk Sprinkle##7583
accept Delivery for Marin##2661 |goto Tanaris 51.06,26.87
step
talk Marin Noggenfogger##7564
turnin Delivery for Marin##2661 |goto Tanaris 51.81,28.66
accept Noggenfogger Elixir##2662 |goto Tanaris 51.81,28.66
step
Watch the dialogue
talk Marin Noggenfogger##7564
turnin Noggenfogger Elixir##2662 |goto Tanaris 51.81,28.66
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Dran's Ripple Delivery##8685	|goto Tanaris 52.30,28.91 |q 81
bank Pupellyverbos Port##3900		|goto Tanaris 52.30,28.91 |q 580
bank Box of Empty Vials##10695		|goto Tanaris 52.30,28.91 |q 3568
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Feralas & Un'Goro Crater (49-50)",{
image=ZGV.IMAGESDIR.."Feralas",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale & Swamp of Sorrows (50-50)",
},[[
step
_NOTE:_
Optional Dungeon Later
|tip Can run {o}Maraudon{} dungeon later.
|tip Slower leveling, but potential gear upgrades.
|tip We'll pick up dungeon quests.
|tip Guide will say when it's time to run the dungeon.
Click Here to Run {y}Maraudon{} Dungeon Later |confirm Maraflag |multiq	7067,7028,7044,7066,7029,7064,7046 |future
|tip Skip if you'd rather grind.
step
_NOTE:_
Begin Finding a Dungeon Group
|tip Good time to run {o}Maraudon{} dungeon soon.
|tip Start looking for a group.
Click Here to Continue |confirm |multiq 7067,7028,7044,7066,7029,7064,7046 |future
|only if guideflag("Maraflag")
step
talk Talo Thornhoof##7776
|tip Inside the building.
accept Dark Heart##3062 |goto Feralas 76.18,43.83			|only if not hardcore()
accept Vengeance on the Northspring##3063 |goto Feralas 76.18,43.83
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
accept Improved Quality##7734 |goto Feralas 74.43,42.91
step
talk Witch Doctor Uzer'i##8115
turnin Testing the Vessel##3123 |goto Feralas 74.42,43.36
accept Hippogryph Muisek##3124 |goto Feralas 74.42,43.36
accept Natural Materials##3128 |goto Feralas 74.42,43.36
step
kill Frayfeather Patriarch##5306, Frayfeather Skystormer##5305, Frayfeather Stagwing##5304, Frayfeather Hippogryph##5300
|tip Hippogryphs.
use Hippogryph Muisek Vessel##9619
|tip On their corpses.
collect 10 Hippogryph Muisek##9595 |q 3124/1 |goto Feralas 57.40,62.40
collect 20 Resilient Sinew##9591 |q 3128/3 |goto Feralas 57.40,62.40
collect 40 Metallic Fragments##9592 |q 3128/4 |goto Feralas 57.40,62.40
|mapmarker Feralas/0 53.40,70.40
|mapmarker Feralas/0 54.60,75.40
|mapmarker Feralas/0 54.80,60.20
|mapmarker Feralas/0 55.80,72.40
|mapmarker Feralas/0 56.20,66.00
|mapmarker Feralas/0 59.80,73.40
|mapmarker Feralas/0 53.40,64.60
step
talk Witch Doctor Uzer'i##8115
turnin Hippogryph Muisek##3124 |goto Feralas 74.42,43.36
accept Faerie Dragon Muisek##3125 |goto Feralas 74.42,43.36
step
kill Sprite Darter##5278+
use Faerie Dragon Muisek Vessel##9620
|tip On their corpses.
collect 8 Faerie Dragon Muisek##9596 |q 3125/1 |goto Feralas 69.40,46.80
collect 6 Encrusted Minerals##9589 |q 3128/2 |goto Feralas 69.40,46.80
|mapmarker Feralas/0 64.40,48.40
|mapmarker Feralas/0 66.40,47.80
|mapmarker Feralas/0 68.40,44.80
|mapmarker Feralas/0 68.40,49.20
step
talk Witch Doctor Uzer'i##8115
turnin Faerie Dragon Muisek##3125 |goto Feralas 74.42,43.36
accept Treant Muisek##3126 |goto Feralas 74.42,43.36
step
map Feralas/0
path follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	68.40,46.40	69.20,45.40	69.40,43.00	70.60,41.80	71.80,42.00
path	72.40,41.20	73.00,40.20	73.80,38.80	74.80,38.40	76.00,39.80
path	77.40,40.60	78.20,41.40	78.40,42.60	78.80,44.20	81.00,45.00
path	81.80,45.20	82.60,45.60	83.22,46.16
kill Wandering Forest Walker##7584+
|tip Walking trees.
|tip Walks a large path.
use Treant Muisek Vessel##9606
|tip On their corpses.
collect 3 Treant Muisek##9593 |q 3126/1
collect 2 Splintered Log##9590 |q 3128/1
Spawns at [Feralas/0 83.22,46.16] |noway
|tip Roughly {o}6 minute{} respawn.
step
talk Witch Doctor Uzer'i##8115
turnin Treant Muisek##3126 |goto Feralas 74.42,43.36
accept Mountain Giant Muisek##3127 |goto Feralas 74.42,43.36
turnin Natural Materials##3128 |goto Feralas 74.42,43.36
step
talk Zorbin Fandazzle##14637
accept Zapped Giants##7003 |goto Feralas 44.81,43.42
accept Fuel for the Zapping##7721 |goto Feralas 44.81,43.42
stickystart "Collect_Water_Elemental_Cores"
step
use Zorbin's Ultra-Shrinker##18904
|tip On {o}Strider enemies{}.
|tip Tall green giants.
|tip Makes them {o}non-elite{}.
|tip Item lasts {o}2 hours{}.
|tip Abandon quest and accept again if you need another.
kill Zapped Wave Strider##14638+
collect 15 Miniaturization Residue##18956 |q 7003/1 |goto Feralas/0 44.40,49.80
|mapmarker Feralas/0 36.20,34.00
|mapmarker Feralas/0 39.00,35.80
|mapmarker Feralas/0 40.40,38.00
|mapmarker Feralas/0 43.20,53.80
|mapmarker Feralas/0 43.40,67.80
|mapmarker Feralas/0 44.40,46.20
|mapmarker Feralas/0 44.40,61.00
|mapmarker Feralas/0 45.00,66.40
|mapmarker Feralas/0 46.00,52.80
|mapmarker Feralas/0 46.00,62.20
|mapmarker Feralas/0 46.40,59.20
|mapmarker Feralas/0 46.60,57.20
step
label "Collect_Water_Elemental_Cores"
kill Sea Spray##5462, Sea Elemental##5461
|tip Water elementals.
collect 10 Water Elemental Core##18958 |q 7721/1 |goto Feralas/0 44.20,50.60
|mapmarker Feralas/0 35.40,34.80
|mapmarker Feralas/0 38.20,33.40
|mapmarker Feralas/0 39.80,36.80
|mapmarker Feralas/0 44.00,39.20
|mapmarker Feralas/0 44.40,67.20
|mapmarker Feralas/0 44.60,46.80
|mapmarker Feralas/0 45.80,63.80
|mapmarker Feralas/0 46.20,56.80
|mapmarker Feralas/0 46.20,60.40
|mapmarker Feralas/0 46.40,52.80
|mapmarker Feralas/0 48.00,49.40
|mapmarker Feralas/0 49.40,53.20
step
talk Zorbin Fandazzle##14637
turnin Zapped Giants##7003 |goto Feralas 44.81,43.42
turnin Fuel for the Zapping##7721 |goto Feralas 44.81,43.42
step
_Destroy This Item:_
|tip Not needed.
trash Zorbin's Ultra-Shrinker##18904
step
talk Zorbin Fandazzle##14637
accept Again With the Zapped Giants##7725 |goto Feralas 44.81,43.42
|only if not (readyq(3127) or completedq(3127))
stickystart "Collect_Rage_Scar_Yeti_Hides"
step
kill Ferocious Rage Scar##5299, Rage Scar Yeti##5296, Elder Rage Scar##5297
|tip Yetis.
|tip Skin them. |only if skill('Skinning') > 0
|tip Inside and outside the cave.
collect Perfect Yeti Hide##18972 |n
use Perfect Yeti Hide##18972
accept Perfect Yeti Hide##7738 |goto Feralas/0 51.40,32.40
|mapmarker Feralas/0 52.20,29.60
|mapmarker Feralas/0 53.60,32.00
|mapmarker Feralas/0 54.60,33.80
|only if itemcount(18972) == 0 and not (readyq(7734) or completedq(7734))
step
label "Collect_Rage_Scar_Yeti_Hides"
kill Ferocious Rage Scar##5299, Rage Scar Yeti##5296, Elder Rage Scar##5297 |notinsticky
|tip Yetis. |notinsticky
|tip Inside and outside the cave. |notinsticky
collect 10 Rage Scar Yeti Hide##18947 |q 7734/1 |goto Feralas/0 51.40,32.40
|mapmarker Feralas/0 52.20,29.60
|mapmarker Feralas/0 53.60,32.00
|mapmarker Feralas/0 54.60,33.80
step
Leave the cave |goto Feralas/0 53.32,31.85 < 15 |walk |only if subzone("Rage Scar Hold") and indoors()
use Zorbin's Ultra-Shrinker##18904
|tip On rock giant enemies.
|tip Makes them {o}non-elite{}.
|tip Item lasts {o}2 hours{}.
|tip Abandon {o}Again With the Zapped Giants{} quest and accept again if you need another.
kill Cliff Giant##5358, Enraged Mountain Giant##221373
|tip Rock giants.
use Mountain Giant Muisek Vessel##9621
|tip On their corpses.
collect 7 Mountain Giant Muisek##9597 |q 3127/1 |goto Feralas 40.20,25.80
|mapmarker Feralas/0 37.00,22.60
|mapmarker Feralas/0 38.00,17.40
|mapmarker Feralas/0 38.20,20.60
|mapmarker Feralas/0 38.20,24.20
|mapmarker Feralas/0 39.60,22.60
step
Abandon the {y}Again With the Zapped Giants{} Quest |complete not haveq(7725)
|tip Not needed.
stickystart "Kill_Northspring_Enemies"
step
kill Northspring Harpy##5362, Northspring Roguefeather##5363, Northspring Slayer##5364, Northspring Windcaller##5366
|tip Harpies.
collect Horn of Hatetalon##9530 |goto Feralas 40.00,15.20 |q 3062
|mapmarker Feralas/0 37.40,12.40
|mapmarker Feralas/0 37.40,15.40
|mapmarker Feralas/0 38.20,10.20
|mapmarker Feralas/0 40.00,12.40
|mapmarker Feralas/0 41.20,10.40
|mapmarker Feralas/0 41.80,13.60
|only if not hardcore()
step
use Horn of Hatetalon##9530
kill Edana Hatetalon##8075
|tip {o}Level 50 elite{} enemy.
|tip Should be able to solo.
|tip May need help.
collect Edana's Dark Heart##9528 |q 3062/1 |goto Feralas 40.55,8.59
|only if not hardcore()
step
label "Kill_Northspring_Enemies"
kill 4 Northspring Harpy##5362 |q 3063/1 |goto Feralas 40.00,15.20
kill 4 Northspring Roguefeather##5363 |q 3063/2 |goto Feralas 40.00,15.20
kill 4 Northspring Slayer##5364 |q 3063/3 |goto Feralas 40.00,15.20
kill 4 Northspring Windcaller##5366 |q 3063/4 |goto Feralas 40.00,15.20
|mapmarker Feralas/0 37.40,12.40
|mapmarker Feralas/0 37.40,15.40
|mapmarker Feralas/0 38.20,10.20
|mapmarker Feralas/0 40.00,12.40
|mapmarker Feralas/0 41.20,10.40
|mapmarker Feralas/0 41.80,13.60
step
talk Selendra##13699
accept Corruption of Earth and Seed##7064 |goto Desolace 26.87,77.67
|only if guideflag("Maraflag")
step
talk Vark Battlescar##11823
|tip Top of the building.
accept Vyletongue Corruption##7029 |goto Desolace 23.22,70.33
|only if guideflag("Maraflag")
step
talk Willow##13656
|tip Inside the building.
accept Twisted Evils##7028 |goto Desolace 62.19,39.63
|only if guideflag("Maraflag")
step
talk Centuar Pariah##13717
|tip Walks around.
accept The Pariah's Instructions##7067 |goto Desolace 50.42,86.65
|mapmarker Desolace/0 43.40,84.80
|mapmarker Desolace/0 44.40,85.60
|mapmarker Desolace/0 45.60,86.40
|mapmarker Desolace/0 47.40,87.00
|only if guideflag("Maraflag")
step
_NOTE:_
Starting Dungeon Run
|tip Running {o}Maraudon{} dungeon now.
|tip Meet with your dungeon group.
Click Here to Continue |confirm |multiq 7067,7028,7044,7066,7029,7064,7046 |future
|only if guideflag("Maraflag")
step
Enter the Stone Door of the Maraudon Tunnels |complete subzone("Maraudon") |multiq 7067,7028,7044,7066,7029,7064,7046 |future
|tip Follow your group.
|only if guideflag("Maraflag")
step
_Inside the Maraudon Tunnels:_
kill The Nameless Prophet##13718
|tip Centaur with purple armor.
|tip Multiple locations.
collect Amulet of Spirits##17757 |q 7067
|only if guideflag("Maraflag")
step
_Inside the Maraudon Tunnels:_
|tip {o}Purple{} section.
use Amulet of Spirits##17757
|tip On Spirit of Gelk.
|tip Ghost centaur with a trident.
|tip Walks around.
kill Gelk##13741
collect Gem of the Second Khan##17762 |q 7067
|only if guideflag("Maraflag")
step
_Inside the Maraudon Tunnels:_
|tip {o}Room between{} the orange and purple sections.
use Amulet of Spirits##17757
|tip On Spirit of Kolk.
|tip Ghost centaur with a trident.
kill Kolk##13742
collect Gem of the First Khan##17761 |q 7067
|only if guideflag("Maraflag")
step
_Inside the Maraudon Tunnels:_
|tip {o}Orange{} section.
talk Cavindra##Cavindra
accept Legends of Maraudon##7044
|only if guideflag("Maraflag")
step
_Inside the Maraudon Tunnels:_
|tip {o}Orange{} section.
use Coated Cerulean Vial##17693
|tip Next to the {o}large pool{} with {o}orange crystals{} in it.
collect Filled Cerulean Vial##17696 |q 7029/2
|only if guideflag("Maraflag")
step
_Inside the Maraudon Tunnels:_
|tip {o}Orange{} section.
use Amulet of Spirits##17757
|tip On Spirit of Magra.
|tip Walks around.
kill Magra##13740
collect Gem of the Third Khan##17763 |q 7067
|only if guideflag("Maraflag")
step
Enter the Maraudon Dungeon |complete zone("Maraudon") |multiq 7067,7028,7044,7066,7029,7064,7046 |future
|tip Follow your group.
|only if guideflag("Maraflag")
stickystart "Collect_Gem_Of_The_Fifth_Khan"
step
_Inside the Maraudon Dungeon:_
|tip {o}Orange{} section.
kill Noxxion##13282
|tip First boss.
collect Celebrian Rod##17702 |q 7044/2
|only if guideflag("Maraflag")
step
label "Collect_Gem_Of_The_Fifth_Khan"
_Inside the Maraudon Dungeon:_ |notinsticky
use Amulet of Spirits##17757
|tip On Spirit of Veng.
|tip Walks around.
|tip {o}Orange{} section.
kill Veng##13738
collect Gem of the Fifth Khan##17765 |q 7067
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
|tip {o}Purple{} section.
use Amulet of Spirits##17757
|tip On Spirit of Maraudos.
|tip Ghost centaur with a spear.
|tip Walks around.
|tip In {o}The Wicked Grotto{} area.
kill Maraudos##13739
collect Gem of the Fourth Khan##17764 |q 7067
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
use Gem of the Fifth Khan##17765
collect Amulet of Union##17758 |q 7067/1
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
|tip {o}Purple{} section.
kill Lord Vyletongue##12236
|tip {o}Vyletongue Seat{} area.
|tip Small room on the {o}northern side{}.
collect Celebrian Diamond##17703 |q 7044/1
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
|tip {o}Purple{} section.
kill Celebras the Cursed##12225
|tip {o}Poison Falls{} area.
|tip On a small island.
talk Celebras the Redeemed##13716
turnin Legend of Maraudon##7044
accept The Scepter of Celebras##7046
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
|tip {o}Purple{} section.
Watch the dialogue
|tip Follow Celebras the Redeemed.
click Incantations of Celebras
|tip Stone he leads you to.
Create the Scepter of Celebras |q 7046/1
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
|tip {o}Purple{} section.
talk Celebras the Redeemed##13716
turnin The Scepter of Celebras##7046
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
|tip {o}Purple{} section.
kill Princess Theradras##12201 |q 7064/1
|tip Final boss.
|only if guideflag("Maraflag")
step
_Inside the Maraudon Dungeon:_
|tip {o}Purple{} section.
talk Zaetar's Spirit##12238
|tip Appears {o}center of the room{}.
|tip After Princess Theradras is killed.
accept Seed of Life##7066
|only if guideflag("Maraflag")
step
Leave the Maraudon Dungeon |complete not zone("Maraudon") |multiq 7067,7028,7044,7066,7029,7064,7046 |future
|tip Don't hearth yet.
|only if guideflag("Maraflag")
step
talk Centuar Pariah##13717
|tip Walks around.
turnin The Pariah's Instructions##7067 |goto Desolace 43.40,84.80
|mapmarker Desolace/0 50.42,86.65
|mapmarker Desolace/0 44.40,85.60
|mapmarker Desolace/0 45.60,86.40
|mapmarker Desolace/0 47.40,87.00
|only if guideflag("Maraflag")
step
talk Willow##13656
|tip Inside the building.
turnin Twisted Evils##7028 |goto Desolace 62.20,39.63
|only if guideflag("Maraflag")
step
talk Selendra##13699
turnin Corruption of Earth and Seed##7064 |goto Desolace 26.87,77.67
|only if guideflag("Maraflag")
step
talk Vark Battlescar##11823
|tip Top of the building.
turnin Vyletongue Corruption##7029 |goto Desolace 23.22,70.33
|only if guideflag("Maraflag")
step
talk Keeper Remulos##11832
turnin Seed of Life##7066 |goto Moonglade 36.18,41.79
|only if guideflag("Maraflag")
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Stone Circle##10556		|goto Tanaris 52.30,28.91 |q 3444
collect 7 Red Power Crystal##11186	|goto Tanaris 52.30,28.91 |q 4284 |future
collect 7 Yellow Power Crystal##11188	|goto Tanaris 52.30,28.91 |q 4284 |future
collect 7 Green Power Crystal##11185	|goto Tanaris 52.30,28.91 |q 4284 |future
collect 7 Blue Power Crystal##11184	|goto Tanaris 52.30,28.91 |q 4284 |future
step
talk Marvon Rivetseeker##7771
turnin The Stone Circle##3444 |goto Tanaris 52.71,45.93
step
talk Torwa Pathfinder##9619
accept The Apes of Un'Goro##4289 |goto Un'Goro Crater 71.64,75.96
accept The Fare of Lar'korwi##4290 |goto Un'Goro Crater 71.64,75.96
stickystart "Collect_White_Ravasaur_Claws"
stickystart "Collect_A_Mangled_Journal"
stickystart "Collect_Power_Crystals"
stickystart "Collect_UnGoro_Soil"
step
click A Wrecked Raft
accept It's a Secret to Everybody##3844 |goto Un'Goro Crater 63.02,68.50
step
click A Small Pack
|tip Underwater.
turnin It's a Secret to Everybody##3844 |goto Un'Goro Crater 63.12,69.02
accept It's a Secret to Everybody##3845 |goto Un'Goro Crater 63.12,69.02
step
click Fresh Threshadon Carcass
|tip Avoid the elite t-rex.
collect Piece of Threshadon Carcass##11504 |q 4290/1 |goto Un'Goro Crater 68.75,56.66
step
talk Torwa Pathfinder##9619
turnin The Fare of Lar'korwi##4290 |goto Un'Goro Crater 71.64,75.97
accept The Scent of Lar'korwi##4291 |goto Un'Goro Crater 71.64,75.97
step
kill Lar'korwi Mate##9683+
|tip Stand on piles of purple eggs.
collect 2 Ravasaur Pheromone Gland##11509 |q 4291/1 |goto Un'Goro Crater 67.20,73.00
|mapmarker Un'Goro Crater/0 58.20,78.20
|mapmarker Un'Goro Crater/0 60.80,72.20
|mapmarker Un'Goro Crater/0 62.20,65.40
|mapmarker Un'Goro Crater/0 62.80,80.40
|mapmarker Un'Goro Crater/0 63.20,77.20
|mapmarker Un'Goro Crater/0 63.80,62.80
|mapmarker Un'Goro Crater/0 66.40,66.80
|mapmarker Un'Goro Crater/0 67.00,62.40
|mapmarker Un'Goro Crater/0 67.20,60.40
|mapmarker Un'Goro Crater/0 68.40,54.40
|mapmarker Un'Goro Crater/0 71.40,60.00
step
label "Collect_White_Ravasaur_Claws"
kill Ravasaur Hunter##6507, Venomhide Ravasaur##6508, Ravasaur##6505, Ravasaur Runner##6506
|tip Raptors.
collect 8 White Ravasaur Claw##11477 |q 4300/1 |goto Un'Goro Crater 65.00,70.40
|mapmarker Un'Goro Crater/0 57.20,77.40
|mapmarker Un'Goro Crater/0 59.40,72.60
|mapmarker Un'Goro Crater/0 59.40,81.00
|mapmarker Un'Goro Crater/0 60.20,75.60
|mapmarker Un'Goro Crater/0 60.40,66.40
|mapmarker Un'Goro Crater/0 60.40,69.40
|mapmarker Un'Goro Crater/0 61.80,79.00
|mapmarker Un'Goro Crater/0 62.00,82.60
|mapmarker Un'Goro Crater/0 62.40,72.00
|mapmarker Un'Goro Crater/0 63.20,75.20
|mapmarker Un'Goro Crater/0 63.40,62.80
|mapmarker Un'Goro Crater/0 63.80,66.20
|mapmarker Un'Goro Crater/0 64.80,78.20
|mapmarker Un'Goro Crater/0 67.00,73.40
|mapmarker Un'Goro Crater/0 67.60,68.40
|mapmarker Un'Goro Crater/0 68.00,61.60
|mapmarker Un'Goro Crater/0 68.20,78.00
|mapmarker Un'Goro Crater/0 60.60,49.40
|mapmarker Un'Goro Crater/0 60.80,52.40
|mapmarker Un'Goro Crater/0 61.00,56.60
|mapmarker Un'Goro Crater/0 62.20,59.40
|mapmarker Un'Goro Crater/0 63.20,47.80
|mapmarker Un'Goro Crater/0 63.40,44.20
|mapmarker Un'Goro Crater/0 63.60,54.40
|mapmarker Un'Goro Crater/0 65.20,50.60
|mapmarker Un'Goro Crater/0 65.40,59.00
|mapmarker Un'Goro Crater/0 66.20,42.00
|mapmarker Un'Goro Crater/0 66.60,46.20
|mapmarker Un'Goro Crater/0 67.20,54.00
|mapmarker Un'Goro Crater/0 67.40,64.60
|mapmarker Un'Goro Crater/0 68.40,49.80
|mapmarker Un'Goro Crater/0 68.80,56.60
|mapmarker Un'Goro Crater/0 69.00,43.60
|mapmarker Un'Goro Crater/0 70.00,52.40
|mapmarker Un'Goro Crater/0 70.20,46.80
|mapmarker Un'Goro Crater/0 70.40,63.20
|mapmarker Un'Goro Crater/0 70.60,59.40
|mapmarker Un'Goro Crater/0 71.60,55.00
|mapmarker Un'Goro Crater/0 72.00,42.60
|mapmarker Un'Goro Crater/0 72.40,49.80
|mapmarker Un'Goro Crater/0 73.40,62.80
|mapmarker Un'Goro Crater/0 74.00,57.20
|mapmarker Un'Goro Crater/0 75.40,51.40
step
label "Collect_A_Mangled_Journal"
Kill enemies
|tip Any in Un'Goro Crater.
collect A Mangled Journal##11116 |n
use A Mangled Journal##11116
accept Williden's Journal##3884 |goto Un'Goro Crater 65.00,70.40
|mapmarker Un'Goro Crater/0 57.20,77.40
|mapmarker Un'Goro Crater/0 59.40,72.60
|mapmarker Un'Goro Crater/0 59.40,81.00
|mapmarker Un'Goro Crater/0 60.20,75.60
|mapmarker Un'Goro Crater/0 60.40,66.40
|mapmarker Un'Goro Crater/0 60.40,69.40
|mapmarker Un'Goro Crater/0 61.80,79.00
|mapmarker Un'Goro Crater/0 62.00,82.60
|mapmarker Un'Goro Crater/0 62.40,72.00
|mapmarker Un'Goro Crater/0 63.20,75.20
|mapmarker Un'Goro Crater/0 63.40,62.80
|mapmarker Un'Goro Crater/0 63.80,66.20
|mapmarker Un'Goro Crater/0 64.80,78.20
|mapmarker Un'Goro Crater/0 67.00,73.40
|mapmarker Un'Goro Crater/0 67.60,68.40
|mapmarker Un'Goro Crater/0 68.00,61.60
|mapmarker Un'Goro Crater/0 68.20,78.00
|mapmarker Un'Goro Crater/0 60.60,49.40
|mapmarker Un'Goro Crater/0 60.80,52.40
|mapmarker Un'Goro Crater/0 61.00,56.60
|mapmarker Un'Goro Crater/0 62.20,59.40
|mapmarker Un'Goro Crater/0 63.20,47.80
|mapmarker Un'Goro Crater/0 63.40,44.20
|mapmarker Un'Goro Crater/0 63.60,54.40
|mapmarker Un'Goro Crater/0 65.20,50.60
|mapmarker Un'Goro Crater/0 65.40,59.00
|mapmarker Un'Goro Crater/0 66.20,42.00
|mapmarker Un'Goro Crater/0 66.60,46.20
|mapmarker Un'Goro Crater/0 67.20,54.00
|mapmarker Un'Goro Crater/0 67.40,64.60
|mapmarker Un'Goro Crater/0 68.40,49.80
|mapmarker Un'Goro Crater/0 68.80,56.60
|mapmarker Un'Goro Crater/0 69.00,43.60
|mapmarker Un'Goro Crater/0 70.00,52.40
|mapmarker Un'Goro Crater/0 70.20,46.80
|mapmarker Un'Goro Crater/0 70.40,63.20
|mapmarker Un'Goro Crater/0 70.60,59.40
|mapmarker Un'Goro Crater/0 71.60,55.00
|mapmarker Un'Goro Crater/0 72.00,42.60
|mapmarker Un'Goro Crater/0 72.40,49.80
|mapmarker Un'Goro Crater/0 73.40,62.80
|mapmarker Un'Goro Crater/0 74.00,57.20
|mapmarker Un'Goro Crater/0 75.40,51.40
step
Kill enemies
ding 50 |goto Un'Goro Crater 65.00,70.40
|mapmarker Un'Goro Crater/0 57.20,77.40
|mapmarker Un'Goro Crater/0 59.40,72.60
|mapmarker Un'Goro Crater/0 59.40,81.00
|mapmarker Un'Goro Crater/0 60.20,75.60
|mapmarker Un'Goro Crater/0 60.40,66.40
|mapmarker Un'Goro Crater/0 60.40,69.40
|mapmarker Un'Goro Crater/0 61.80,79.00
|mapmarker Un'Goro Crater/0 62.00,82.60
|mapmarker Un'Goro Crater/0 62.40,72.00
|mapmarker Un'Goro Crater/0 63.20,75.20
|mapmarker Un'Goro Crater/0 63.40,62.80
|mapmarker Un'Goro Crater/0 63.80,66.20
|mapmarker Un'Goro Crater/0 64.80,78.20
|mapmarker Un'Goro Crater/0 67.00,73.40
|mapmarker Un'Goro Crater/0 67.60,68.40
|mapmarker Un'Goro Crater/0 68.00,61.60
|mapmarker Un'Goro Crater/0 68.20,78.00
|mapmarker Un'Goro Crater/0 60.60,49.40
|mapmarker Un'Goro Crater/0 60.80,52.40
|mapmarker Un'Goro Crater/0 61.00,56.60
|mapmarker Un'Goro Crater/0 62.20,59.40
|mapmarker Un'Goro Crater/0 63.20,47.80
|mapmarker Un'Goro Crater/0 63.40,44.20
|mapmarker Un'Goro Crater/0 63.60,54.40
|mapmarker Un'Goro Crater/0 65.20,50.60
|mapmarker Un'Goro Crater/0 65.40,59.00
|mapmarker Un'Goro Crater/0 66.20,42.00
|mapmarker Un'Goro Crater/0 66.60,46.20
|mapmarker Un'Goro Crater/0 67.20,54.00
|mapmarker Un'Goro Crater/0 67.40,64.60
|mapmarker Un'Goro Crater/0 68.40,49.80
|mapmarker Un'Goro Crater/0 68.80,56.60
|mapmarker Un'Goro Crater/0 69.00,43.60
|mapmarker Un'Goro Crater/0 70.00,52.40
|mapmarker Un'Goro Crater/0 70.20,46.80
|mapmarker Un'Goro Crater/0 70.40,63.20
|mapmarker Un'Goro Crater/0 70.60,59.40
|mapmarker Un'Goro Crater/0 71.60,55.00
|mapmarker Un'Goro Crater/0 72.00,42.60
|mapmarker Un'Goro Crater/0 72.40,49.80
|mapmarker Un'Goro Crater/0 73.40,62.80
|mapmarker Un'Goro Crater/0 74.00,57.20
|mapmarker Un'Goro Crater/0 75.40,51.40
step
talk Torwa Pathfinder##9619
turnin The Scent of Lar'korwi##4291 |goto Un'Goro Crater 71.63,75.97
accept The Bait for Lar'korwi##4292 |goto Un'Goro Crater 71.63,75.97
step
label "Collect_Power_Crystals"
click Power Crystal+
|tip Clusters of colored crystals.
|tip Shared spawns, loot all you see.
|tip Makes other colors spawn.
collect 7 Red Power Crystal##11186	|q 4284		|future		|only if itemcount(11186) < 7
collect 7 Yellow Power Crystal##11188	|q 4284		|future		|only if itemcount(11188) < 7
collect 7 Green Power Crystal##11185	|q 4284		|future		|only if itemcount(11185) < 7
collect 7 Blue Power Crystal##11184	|q 4284		|future		|only if itemcount(11184) < 7
|mapmarker Un'Goro Crater/0 54.10,18.10
|mapmarker Un'Goro Crater/0 55.80,7.90
|mapmarker Un'Goro Crater/0 56.00,18.50
|mapmarker Un'Goro Crater/0 56.40,12.30
|mapmarker Un'Goro Crater/0 57.30,10.20
|mapmarker Un'Goro Crater/0 58.10,8.80
|mapmarker Un'Goro Crater/0 59.20,20.40
|mapmarker Un'Goro Crater/0 61.00,15.10
|mapmarker Un'Goro Crater/0 62.30,68.50
|mapmarker Un'Goro Crater/0 62.40,70.30
|mapmarker Un'Goro Crater/0 62.60,16.70
|mapmarker Un'Goro Crater/0 62.60,26.90
|mapmarker Un'Goro Crater/0 63.20,75.20
|mapmarker Un'Goro Crater/0 63.30,23.10
|mapmarker Un'Goro Crater/0 64.20,54.00
|mapmarker Un'Goro Crater/0 65.20,79.70
|mapmarker Un'Goro Crater/0 66.10,21.10
|mapmarker Un'Goro Crater/0 66.60,47.00
|mapmarker Un'Goro Crater/0 66.80,73.30
|mapmarker Un'Goro Crater/0 67.70,40.40
|mapmarker Un'Goro Crater/0 68.10,51.40
|mapmarker Un'Goro Crater/0 68.30,25.30
|mapmarker Un'Goro Crater/0 68.40,59.70
|mapmarker Un'Goro Crater/0 69.10,28.90
|mapmarker Un'Goro Crater/0 69.40,79.90
|mapmarker Un'Goro Crater/0 69.60,35.10
|mapmarker Un'Goro Crater/0 69.60,69.40
|mapmarker Un'Goro Crater/0 69.90,18.90
|mapmarker Un'Goro Crater/0 70.10,77.10
|mapmarker Un'Goro Crater/0 71.10,42.90
|mapmarker Un'Goro Crater/0 71.60,73.60
|mapmarker Un'Goro Crater/0 71.70,63.50
|mapmarker Un'Goro Crater/0 71.90,23.00
|mapmarker Un'Goro Crater/0 72.10,33.10
|mapmarker Un'Goro Crater/0 72.30,21.10
|mapmarker Un'Goro Crater/0 72.40,35.40
|mapmarker Un'Goro Crater/0 72.80,52.10
|mapmarker Un'Goro Crater/0 72.90,46.90
|mapmarker Un'Goro Crater/0 73.00,65.40
|mapmarker Un'Goro Crater/0 73.80,53.40
|mapmarker Un'Goro Crater/0 74.40,57.00
|mapmarker Un'Goro Crater/0 74.40,63.80
|mapmarker Un'Goro Crater/0 74.80,29.60
|mapmarker Un'Goro Crater/0 74.80,58.90
|mapmarker Un'Goro Crater/0 74.90,70.50
|mapmarker Un'Goro Crater/0 75.10,37.40
|mapmarker Un'Goro Crater/0 75.20,61.60
|mapmarker Un'Goro Crater/0 75.90,40.10
|mapmarker Un'Goro Crater/0 76.60,43.80
|mapmarker Un'Goro Crater/0 76.80,57.70
|mapmarker Un'Goro Crater/0 78.20,40.10
|mapmarker Un'Goro Crater/0 79.30,57.90
|mapmarker Un'Goro Crater/0 79.90,61.90
|mapmarker Un'Goro Crater/0 80.40,49.70
|mapmarker Un'Goro Crater/0 80.60,43.00
|mapmarker Un'Goro Crater/0 81.40,39.10
|mapmarker Un'Goro Crater/0 81.60,60.60
|only if itemcount(11186) < 7 or itemcount(11188) < 7 or itemcount(11185) < 7 or itemcount(11184) < 7
step
use A Small Pack##11107
collect Large Compass##11104 |q 3845/1
collect Curled Map Parchment##11105 |q 3845/2
collect Lion-headed Key##11106 |q 3845/3
step
_Destroy This Item:_
|tip Not needed.
trash Faded Photograph##11108
trash Heavy Throwing Dagger##3108
step
talk Linken##8737
turnin It's a Secret to Everybody##3845 |goto Un'Goro Crater 44.66,8.11
accept It's a Secret to Everybody##3908 |goto Un'Goro Crater 44.66,8.11
stickystop "Collect_UnGoro_Soil"
step
talk Williden Marshal##9270
turnin Williden's Journal##3884 |goto Un'Goro Crater 43.95,7.14
step
Enter the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
accept Crystals of Power##4284 |goto Un'Goro Crater 41.92,2.70
step
talk J.D. Collie##9117
|tip Inside the cave.
turnin Crystals of Power##4284 |goto Un'Goro Crater 41.92,2.70
step
_Destroy These Items:_
|tip Not needed.
trash Red Power Crystal##11186
trash Yellow Power Crystal##11188
trash Green Power Crystal##11185
trash Blue Power Crystal##11184
step
Leave the cave |goto Un'Goro Crater 43.47,6.81 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
talk Gryfe##10583
fpath Marshal's Refuge |goto Un'Goro Crater/0 45.23,5.84
step
label "Collect_UnGoro_Soil"
click Un'Goro Dirt Pile+
Kill enemies
collect 20 Un'Goro Soil##11018 |multiq 3761,4496 |future
|tip Don't vendor them.
|sticky only
step
talk Talo Thornhoof##7776
|tip Inside the building.
turnin Vengeance on the Northspring##3063 |goto Feralas 76.18,43.83
accept The Strength of Corruption##4120 |goto Feralas 76.18,43.83
turnin Dark Heart##3062 |goto Feralas 76.18,43.83			|only if not hardcore()
step
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Improved Quality##7734 |goto Feralas 74.43,42.91
turnin Perfect Yeti Hide##7738 |goto Feralas 74.43,42.91 |only if haveq(7738) or completedq(7738)
step
talk Witch Doctor Uzer'i##8115
turnin Mountain Giant Muisek##3127 |goto Feralas 74.42,43.37
accept Weapons of Spirit##3129 |goto Feralas 74.42,43.37
step
Watch the dialogue
talk Witch Doctor Uzer'i##8115
turnin Weapons of Spirit##3129 |goto Feralas 74.42,43.37
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 4300
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 4300
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 4300
|only if Priest
step
talk Karus##3309
|tip Collect from the bank.
|tip Inside the building.
collect Dran's Ripple Delivery##8685	|goto Orgrimmar 49.58,69.12 |q 81
collect Stoley's Bottle##9245		|goto Orgrimmar 49.58,69.12 |q 2874
collect Fool's Stout Report##5807	|goto Orgrimmar 49.58,69.12 |q 1122
collect 12 Pupellyverbos Port##3900	|goto Orgrimmar 49.58,69.12 |q 580
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Un'Goro Soil##11018		|goto Orgrimmar 49.58,69.12 |multiq 3761,4496 |future
bank Torwa's Pouch##11568		|goto Orgrimmar 49.58,69.12 |q 4292
bank Linken's Training Sword##11133	|goto Orgrimmar 49.58,69.12 |q 3908
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 4300
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 4300
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 4300
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 4300
|only if Warlock
step
talk Dran Droffers##6986
|tip Inside the building.
turnin Ripple Delivery##81 |goto Orgrimmar/0 59.48,36.59
step
talk Jes'rimon##8659
|tip Up on the balcony of the building.
turnin Bone-Bladed Weapons##4300 |goto Orgrimmar 55.51,34.09
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 197
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 197
|only if Hunter
step
talk Xao'tsu##10088
|tip Top of the building.
Train Pet Abilities |trainer Xao'tsu##10088 |goto Orgrimmar/0 66.33,14.82 |q 197
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Innkeeper Gryshka##6929
|tip Inside the building.
home Orgrimmar |goto Orgrimmar 54.09,68.42 |q 3541 |future
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Liv Rizzlefix##8496
|tip Inside the building.
accept Volcanic Activity##4502 |goto The Barrens 62.45,38.74
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale & Swamp of Sorrows (50-50)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Blasted Lands (50-51)",
},[[
step
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Deliver to MacKinley##2874 |goto Stranglethorn Vale 27.78,77.07
step
talk Whiskey Slim##2491
|tip {o}Ground floor{} inside the building.
turnin Whiskey Slim's Lost Grog##580 |goto Stranglethorn Vale 27.13,77.45
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
turnin Report Back to Fizzlebub##1122 |goto Stranglethorn Vale/0 27.12,77.21
step
kill Tethis##730
|tip {o}Level 43 elite{} blue raptor.
|tip Walks around.
|tip Multiple locations.
collect Talon of Tethis##3877 |q 197/1 |goto Stranglethorn Vale 30.40,40.60
|mapmarker Stranglethorn Vale/0 27.00,44.00
|mapmarker Stranglethorn Vale/0 28.20,42.40
|mapmarker Stranglethorn Vale/0 28.80,45.80
|mapmarker Stranglethorn Vale/0 31.40,43.40
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##197 |goto Stranglethorn Vale 35.66,10.81
accept Big Game Hunter##208 |goto Stranglethorn Vale 35.66,10.81
step
kill King Bangalash##731
|tip {o}Level 43 elite{} white tiger.
|tip Summons 2 non-elite {o}lower level{} helpers.
|tip Around {o}50% health{}.
|tip Walks around.
|tip Top of the hill.
|tip May need help.
collect Head of Bangalash##3880 |q 208/1 |goto Stranglethorn Vale/0 38.35,35.55
|mapmarker Stranglethorn Vale/0 38.20,34.40
|mapmarker Stranglethorn Vale/0 38.20,36.60
step
talk Hemet Nesingwary##715
turnin Big Game Hunter##208 |goto Stranglethorn Vale 35.66,10.81
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
accept The Bloodsail Buccaneers##608 |goto Stranglethorn Vale 27.17,77.01
step
Run through the tunnel to leave Booty Bay |goto Stranglethorn Vale 28.00,73.46 < 15 |only if walking and (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
click Half-Buried Bottle+
|tip Tiny green bottles.
|tip Next to the water along the beach.
collect Carefully Folded Note##4098 |n
use Carefully Folded Note##4098
accept Message in a Bottle##594 |goto Stranglethorn Vale 35.07,72.90
|mapmarker Stranglethorn Vale 37.00,65.47
|mapmarker Stranglethorn Vale 29.71,83.17
step
_NOTE:_
During the Next Steps
|tip The ships in the next steps can be {o}very dangerous{}.
|tip Be {o}extremely careful{} in them.
|tip Skip the quests if you don't feel safe.
Click Here to Continue |confirm |multiq 608,624 |future
|only if hardcore()
stickystart "Collect_Cortellos_Riddle_1"
step
kill Captain Keelhaul##2548 |q 608/2 |goto Stranglethorn Vale 29.20,88.34
|tip {o}Middle floor{} inside the ship.
step
label "Collect_Cortellos_Riddle_1"
click Cortello's Riddle
|tip White rolled up scroll.
|tip {o}Middle floor{} or {o}bottom floor{} inside the ship.
|tip Multiple locations.
|tip Can be on another ship.
collect Cortello's Riddle##4056 |goto Stranglethorn Vale 29.20,88.60 |q 624 |future
|tip Skip if not on this ship. |notinsticky
|only if not (haveq(624) or completedq(624))
step
use Cortello's Riddle##4056
accept Cortello's Riddle##624
|only if itemcount(4056) > 0
stickystart "Collect_Cortellos_Riddle_2"
step
kill Fleet Master Firallon##2546 |q 608/3 |goto Stranglethorn Vale 30.58,90.64
|tip {o}Middle floor{} inside the ship.
step
label "Collect_Cortellos_Riddle_2"
click Cortello's Riddle
|tip White rolled up scroll.
|tip {o}Middle floor{} or {o}bottom floor{} inside the ship.
|tip Multiple locations.
|tip Can be on another ship.
collect Cortello's Riddle##4056 |goto Stranglethorn Vale 30.64,90.17 |q 624 |future |or
|tip Skip if not on this ship. |notinsticky
|only if not (haveq(624) or completedq(624))
step
use Cortello's Riddle##4056
accept Cortello's Riddle##624
|only if itemcount(4056) > 0
stickystart "Collect_Cortellos_Riddle_3"
step
kill Captain Stillwater##2550 |q 608/1 |goto Stranglethorn Vale 32.87,88.20
|tip {o}Middle floor{} inside the ship.
step
label "Collect_Cortellos_Riddle_3"
click Cortello's Riddle
|tip White rolled up scroll.
|tip {o}Middle floor{} or {o}bottom floor{} inside the ship.
|tip Multiple locations.
|tip Can be on another ship.
collect Cortello's Riddle##4056 |goto Stranglethorn Vale 33.39,88.17 |q 624 |future |or
|tip Skip if not on this ship. |notinsticky
|only if not (haveq(624) or completedq(624))
step
use Cortello's Riddle##4056
accept Cortello's Riddle##624
|only if itemcount(4056) > 0
step
talk Princess Poobah##2634
|tip Wait if she's missing.
|tip Careful, stealthed enemies.
turnin Message in a Bottle##594 |goto Stranglethorn Vale 38.53,80.58
step
Run through the tunnel to enter Booty Bay |goto Stranglethorn Vale 29.56,72.51 < 15 |only if walking and not (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
turnin The Bloodsail Buccaneers##608 |goto Stranglethorn Vale 27.17,77.01
step
talk Bengor##7643
|tip Inside the building.
accept The Swamp Talker##2623 |goto Swamp of Sorrows 44.98,57.34
step
talk Fel'zerul##1443
|tip Upstairs inside the building.
turnin Return to Fel'Zerul##1444 |goto Swamp of Sorrows 47.93,54.79
step
Enter the cave |goto Swamp of Sorrows 66.37,76.54 < 20 |walk |only if not subzone("Stagalbog Cave")
Follow the path up |goto Swamp of Sorrows/0 64.07,87.93 <  15 |walk
kill Swamp Talker##950
|tip Grey murloc.
|tip Walks around.
|tip Upstairs inside the cave.
|tip May spawn in other locations.
collect Warchief's Orders##8463 |q 2623/1 |goto Swamp of Sorrows 62.60,88.08
step
Leave the cave |goto Swamp of Sorrows 66.37,76.54 < 20 |walk |only if subzone("Stagalbog Cave")
click A Soggy Scroll
|tip Under the bridge.
|tip Underwater.
turnin Cortello's Riddle##624 |goto Swamp of Sorrows 22.86,48.19
accept Cortello's Riddle##625 |goto Swamp of Sorrows 22.86,48.19
step
talk Overlord Mok'Morokk##4500
|tip He attacks you.
|tip May need help.
accept Challenge Overlord Mok'Morokk##1173 |goto Dustwallow Marsh 36.30,31.42
|only if not hardcore()
step
Watch the dialogue
kill Overlord Mok'Morokk##4500
|tip Surrenders around {o}30% health{}.
Drive Overlord Mok'Morokk from Brackenwall Village |q 1173/1 |goto Dustwallow Marsh 36.30,31.42
|only if not hardcore()
step
talk Draz'Zilb##4501
|tip Inside the small cave.
turnin Challenge Overlord Mok'Morokk##1173 |goto Dustwallow Marsh 37.15,33.08
|only if not hardcore()
step
click Musty Scroll
|tip Inside the small cave.
turnin Cortello's Riddle##625 |goto Dustwallow Marsh 31.10,66.15
accept Cortello's Riddle##626 |goto Dustwallow Marsh 31.10,66.15
step
talk Fuzruckle##3496
|tip Collect from the bank.
collect 15 Silk Cloth##4306 |goto The Barrens 62.64,37.42 |q 4449 |future
step
talk Fallen Hero of the Horde##7572
turnin The Swamp Talker##2623 |goto Swamp of Sorrows 34.29,66.13
accept A Tale of Sorrow##2801 |goto Swamp of Sorrows 34.29,66.13
step
talk Fallen Hero of the Horde##7572
Select _"Please continue, Hero..."_ |gossip 95943
Select _"What could be worse than death?"_ |gossip 95715
Select _"Subordinates?"_ |gossip 95838
Select _"What are the stones of binding?"_ |gossip 95837
Select _"You can count on me, Hero."_ |gossip 95641
Select _"I shall."_ |gossip 95640
Listen to a Tale of Sorrow |q 2801/1 |goto Swamp of Sorrows 34.29,66.13
step
talk Fallen Hero of the Horde##7572
turnin A Tale of Sorrow##2801 |goto Swamp of Sorrows 34.29,66.13
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Blasted Lands (50-51)",{
image=ZGV.IMAGESDIR.."Blasted Lands",
hardcore = true,
next="Leveling Guides\\Searing Gorge (51-51)",
},[[
step
_NOTE:_
While Questing in Blasted Lands
|tip Avoid {o}Teremus the Devourer{}.
|tip {o}Elite level 60{} dragon.
|tip Patrols the zone.
Click Here To Continue |confirm |multiq 2581,2583,2585,2601,2603 |future
|only if hardcore()
step
talk Bloodmage Drazial##7505
accept Snickerfang Jowls##2581 |goto Blasted Lands 50.55,14.21
accept A Boar's Vitality##2583 |goto Blasted Lands 50.55,14.21
accept The Decisive Striker##2585 |goto Blasted Lands 50.55,14.21
step
talk Bloodmage Lynnore##7506
accept The Basilisk's Bite##2601 |goto Blasted Lands 50.64,14.30
accept Vulture's Vigor##2603 |goto Blasted Lands 50.64,14.30
stickystart "Collect_Basilisk_Brains"
stickystart "Collect_Blasted_Boar_Lungs"
stickystart "Collect_Snickerfang_Jowls"
stickystart "Collect_Scorpok_Pincers"
step
kill Black Slayer##5982, Bonepicker##5983
|tip Vultures.
|tip Focus on these.
collect 14 Vulture Gizzard##8396 |goto Blasted Lands/0 56.60,35.40 |multiq 2585,2601,2603
|mapmarker Blasted Lands/0 46.20,18.80
|mapmarker Blasted Lands/0 46.20,22.60
|mapmarker Blasted Lands/0 50.00,17.60
|mapmarker Blasted Lands/0 54.40,36.20
|mapmarker Blasted Lands/0 54.80,44.40
|mapmarker Blasted Lands/0 56.20,29.60
|mapmarker Blasted Lands/0 48.80,19.60
|mapmarker Blasted Lands/0 57.80,44.60
|mapmarker Blasted Lands/0 59.80,39.60
|mapmarker Blasted Lands/0 61.40,26.80
step
label "Collect_Basilisk_Brains"
kill Redstone Basilisk##5990, Redstone Crystalhide##5991
|tip Basilisks.
|tip Shared spawns with boars. |notinsticky
collect 11 Basilisk Brain##8394 |goto Blasted Lands/0 54.40,29.80 |multiq 2583,2601
|mapmarker Blasted Lands/0 44.40,31.20
|mapmarker Blasted Lands/0 45.40,42.60
|mapmarker Blasted Lands/0 45.40,46.40
|mapmarker Blasted Lands/0 45.40,52.40
|mapmarker Blasted Lands/0 46.60,36.00
|mapmarker Blasted Lands/0 47.40,49.40
|mapmarker Blasted Lands/0 49.40,53.40
|mapmarker Blasted Lands/0 51.40,36.60
|mapmarker Blasted Lands/0 51.40,40.80
|mapmarker Blasted Lands/0 52.40,57.60
|mapmarker Blasted Lands/0 54.40,43.40
|mapmarker Blasted Lands/0 57.40,35.80
|mapmarker Blasted Lands/0 57.60,31.00
|mapmarker Blasted Lands/0 58.40,27.40
|mapmarker Blasted Lands/0 62.40,28.20
step
label "Collect_Blasted_Boar_Lungs"
kill Ashmane Boar##5992, Helboar##5993
|tip Boars.
|tip Shared spawns with basilisks. |notinsticky
collect 6 Blasted Boar Lung##8392 |goto Blasted Lands/0 57.20,27.20 |multiq 2583,2581,2585
|mapmarker Blasted Lands/0 44.40,31.40
|mapmarker Blasted Lands/0 44.40,36.40
|mapmarker Blasted Lands/0 45.20,41.60
|mapmarker Blasted Lands/0 45.40,45.20
|mapmarker Blasted Lands/0 45.40,52.60
|mapmarker Blasted Lands/0 47.40,37.20
|mapmarker Blasted Lands/0 47.60,49.20
|mapmarker Blasted Lands/0 51.20,37.40
|mapmarker Blasted Lands/0 51.20,57.60
|mapmarker Blasted Lands/0 52.80,52.40
|mapmarker Blasted Lands/0 53.80,34.40
|mapmarker Blasted Lands/0 54.40,30.80
|mapmarker Blasted Lands/0 54.40,43.60
|mapmarker Blasted Lands/0 57.20,35.60
|mapmarker Blasted Lands/0 61.80,30.80
|mapmarker Blasted Lands/0 62.60,26.20
step
label "Collect_Snickerfang_Jowls"
kill Starving Snickerfang##5984, Snickerfang Hyena##5985
|tip Hyenas.
|tip Shared spawns with scorpions. |notinsticky
collect 5 Snickerfang Jowl##8391 |goto Blasted Lands/0 58.20,31.80 |multiq 2581,2603
|mapmarker Blasted Lands/0 43.40,26.40
|mapmarker Blasted Lands/0 44.20,29.60
|mapmarker Blasted Lands/0 44.40,19.40
|mapmarker Blasted Lands/0 46.20,15.40
|mapmarker Blasted Lands/0 48.40,23.60
|mapmarker Blasted Lands/0 50.60,17.40
|mapmarker Blasted Lands/0 55.00,38.00
|mapmarker Blasted Lands/0 55.20,41.20
|mapmarker Blasted Lands/0 56.40,45.80
|mapmarker Blasted Lands/0 58.40,36.60
|mapmarker Blasted Lands/0 59.20,40.40
|mapmarker Blasted Lands/0 60.00,43.40
|mapmarker Blasted Lands/0 61.40,48.40
|mapmarker Blasted Lands/0 61.60,34.40
|mapmarker Blasted Lands/0 62.20,39.00
|mapmarker Blasted Lands/0 63.00,44.60
step
label "Collect_Scorpok_Pincers"
kill Scorpok Stinger##5988+
|tip Scorpions.
|tip Shared spawns with hyenas. |notinsticky
collect 6 Scorpok Pincer##8393 |goto Blasted Lands/0 47.60,18.80 |multiq 2583,2581,2585
|mapmarker Blasted Lands/0 43.40,26.40
|mapmarker Blasted Lands/0 44.40,19.40
|mapmarker Blasted Lands/0 44.40,22.40
|mapmarker Blasted Lands/0 44.40,29.80
|mapmarker Blasted Lands/0 46.40,15.40
|mapmarker Blasted Lands/0 47.40,22.60
|mapmarker Blasted Lands/0 49.40,16.40
|mapmarker Blasted Lands/0 49.60,24.80
|mapmarker Blasted Lands/0 50.40,29.00
|mapmarker Blasted Lands/0 58.40,42.00
|mapmarker Blasted Lands/0 60.20,35.80
|mapmarker Blasted Lands/0 61.60,45.80
step
talk Kum'isha the Collector##7363
|tip Walks around.
accept Everything Counts In Large Amounts##3501 |goto Blasted Lands 51.80,35.64		|only if itemcount(10593) > 0
accept To Serve Kum'isha##2521 |goto Blasted Lands 51.80,35.64				|only if itemcount(8244) > 0
|mapmarker Blasted Lands/0 53.00,33.80
step
talk Kum'isha the Collector##7363
|tip Walks around.
turnin Everything Counts In Large Amounts##3501 |goto Blasted Lands 51.80,35.64		|only if haveq(3501) or completedq(3501)
turnin To Serve Kum'isha##2521 |goto Blasted Lands 51.80,35.64				|only if haveq(2521) or completedq(2521)
|mapmarker Blasted Lands/0 53.00,33.80
step
talk Bloodmage Lynnore##7506
turnin The Basilisk's Bite##2601 |goto Blasted Lands 50.64,14.30
turnin Vulture's Vigor##2603 |goto Blasted Lands 50.64,14.30
step
talk Bloodmage Drazial##7505
turnin Snickerfang Jowls##2581 |goto Blasted Lands 50.55,14.21
turnin A Boar's Vitality##2583 |goto Blasted Lands 50.55,14.21
turnin The Decisive Striker##2585 |goto Blasted Lands 50.55,14.21
step
_Destroy These Items:_
|tip Not needed.
trash Vulture Gizzard##8396
trash Basilisk Brain##8394
trash Blasted Boar Lung##8392
trash Snickerfang Jowl##8391
trash Scorpok Pincer##8393
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Searing Gorge (51-51)",{
image=ZGV.IMAGESDIR.."Searing Gorge",
hardcore = true,
next="Leveling Guides\\Burning Steppes & Azshara (51-52)",
},[[
step
talk Thal'trak Proudtusk##9082
|tip Walks along the path near Kargath.
|tip Only offers quest when standing here.
|tip Wait until he returns, if missing.
accept Dreadmaul Rock##3821 |goto Badlands 3.36,48.07
step
click Wooden Outhouse
accept Caught!##4449 |goto Searing Gorge 65.54,62.24
stickystart "Collect_Silk_Cloth"
step
kill 8 Dark Iron Geologist##5839 |q 4449/1 |goto Searing Gorge 63.40,61.40
|tip Multiple locations.
|mapmarker Searing Gorge/0 62.40,58.20
|mapmarker Searing Gorge/0 69.20,34.40
step
label "Collect_Silk_Cloth"
kill Dark Iron Geologist##5839, Dark Iron Watchman##8637
|tip Multiple locations. |notinsticky
collect 15 Silk Cloth##4306 |q 4449/2 |goto Searing Gorge 63.40,61.40
|mapmarker Searing Gorge/0 62.40,58.20
|mapmarker Searing Gorge/0 69.20,34.40
step
click Wooden Outhouse
turnin Caught!##4449 |goto Searing Gorge 65.54,62.24
step
Follow the path |goto Searing Gorge 66.79,34.56 < 80 |only if walking
talk Velarok Windblade##8479
accept Divine Retribution##3441 |goto Searing Gorge 39.05,38.99
step
talk Velarok Windblade##8479
Select _"Tell me what drives this vengeance?"_ |gossip 95692
Select _"Continue please."_ |gossip 95530
Select _"Let me confer with my colleagues."_ |gossip 95529
Listen to Kalaran's Story |q 3441/1 |goto Searing Gorge 39.05,38.99
step
talk Velarok Windblade##8479
turnin Divine Retribution##3441 |goto Searing Gorge 39.05,38.99
accept The Flawless Flame##3442 |goto Searing Gorge 39.05,38.99
step
Follow the path up to enter Thorium Point |goto Searing Gorge 31.52,33.54 < 20 |only if walking and not subzone("Thorium Point")
talk Grisha##3305
|tip Up on the cliff.
fpath Thorium Point |goto Searing Gorge 34.85,30.87
step
click Wanted/Missing/Lost & Found
accept STOLEN: Smithing Tuyere and Lookout's Spyglass##7728 |goto Searing Gorge 37.63,26.53
accept JOB OPPORTUNITY: Culling the Competition##7729 |goto Searing Gorge 37.63,26.53
step
talk Hansel Heavyhands##14627
accept Curse These Fat Fingers##7723 |goto Searing Gorge 38.57,27.80
accept Fiery Menace!##7724 |goto Searing Gorge 38.57,27.80
accept Incendosaurs? Whateverosaur is More Like It##7727 |goto Searing Gorge 38.57,27.80
stickystart "Collect_Hearts_Of_Flame"
stickystart "Collect_Golem_Oil"
stickystart "Kill_Greater_Lava_Spiders"
stickystart "Kill_Heavy_War_Golems"
stickystart "Collect_Grimesilt_Outhouse_Key"
stickystart "Collect_Lookouts_Spyglass"
stickystart "Kill_Dark_Iron_Taskmasters_And_Slavers"
step
kill Dark Iron Steamsmith##5840+
collect Smithing Tuyere##18959 |q 7728/1 |goto Searing Gorge 39.20,49.40
|mapmarker Searing Gorge/0 36.40,49.40
|mapmarker Searing Gorge/0 38.00,51.20
|mapmarker Searing Gorge/0 41.40,50.60
|mapmarker Searing Gorge/0 43.60,52.20
step
label "Collect_Hearts_Of_Flame"
kill Inferno Elemental##5852, Magma Elemental##5855, Blazing Elemental##5850
|tip Fire and rock elementals.
collect 4 Heart of Flame##10509 |q 3442/1 |goto Searing Gorge 42.58,38.58
|mapmarker Searing Gorge/0 24.60,54.00
|mapmarker Searing Gorge/0 28.20,64.80
|mapmarker Searing Gorge/0 29.40,75.60
|mapmarker Searing Gorge/0 31.20,43.40
|mapmarker Searing Gorge/0 32.40,70.00
|mapmarker Searing Gorge/0 35.40,77.60
|mapmarker Searing Gorge/0 38.40,41.80
|mapmarker Searing Gorge/0 40.40,34.20
|mapmarker Searing Gorge/0 42.40,35.00
|mapmarker Searing Gorge/0 42.40,38.60
step
label "Collect_Golem_Oil"
kill Heavy War Golem##5854, Magma Elemental##5855, Tempered War Golem##5853
|tip Golems and Elementals.
collect 4 Golem Oil##10511 |q 3442/2 |goto Searing Gorge 39.20,43.40
|mapmarker Searing Gorge/0 31.20,46.60
|mapmarker Searing Gorge/0 32.40,52.20
|mapmarker Searing Gorge/0 34.40,40.40
|mapmarker Searing Gorge/0 34.80,49.00
|mapmarker Searing Gorge/0 35.00,59.80
|mapmarker Searing Gorge/0 35.20,44.40
|mapmarker Searing Gorge/0 36.80,63.80
|mapmarker Searing Gorge/0 38.60,47.40
|mapmarker Searing Gorge/0 41.00,39.40
|mapmarker Searing Gorge/0 43.20,45.60
|mapmarker Searing Gorge/0 44.20,36.80
|mapmarker Searing Gorge/0 45.40,42.00
|mapmarker Searing Gorge/0 48.80,39.80
step
talk Velarok Windblade##8479
turnin The Flawless Flame##3442 |goto Searing Gorge 39.05,38.99
accept Forging the Shaft##3443 |goto Searing Gorge 39.05,38.99
stickystart "Collect_Thorium_Plated_Daggers"
step
Jump down onto the metal walkway here |goto Searing Gorge 49.32,43.74 < 15 |only if walking
Enter the cave |goto Searing Gorge 49.58,45.49 < 15 |c |q 7727
|only if not (subzone("The Slag Pit") and indoors())
stickystop "Kill_Greater_Lava_Spiders"
stickystop "Kill_Heavy_War_Golems"
stickystop "Collect_Grimesilt_Outhouse_Key"
stickystop "Collect_Lookouts_Spyglass"
stickystop "Collect_Thorium_Plated_Daggers"
stickystop "Kill_Dark_Iron_Taskmasters_And_Slavers"
step
Jump down from the bridge inside the cave here |goto Searing Gorge 47.73,41.92 < 15 |walk
kill 20 Incendosaur##9318 |q 7727/1 |goto Searing Gorge 51.40,36.00
|tip Inside the cave.
|mapmarker Searing Gorge/0 43.20,28.60
|mapmarker Searing Gorge/0 44.40,24.40
|mapmarker Searing Gorge/0 45.20,21.40
|mapmarker Searing Gorge/0 47.00,26.60
|mapmarker Searing Gorge/0 48.20,29.60
|mapmarker Searing Gorge/0 48.40,22.60
|mapmarker Searing Gorge/0 50.20,25.40
|mapmarker Searing Gorge/0 50.20,32.80
|mapmarker Searing Gorge/0 51.00,28.40
stickystart "Collect_Grimesilt_Outhouse_Key"
stickystart "Collect_Thorium_Plated_Daggers"
stickystart "Kill_Dark_Iron_Taskmasters_And_Slavers"
step
Leave the cave |goto Searing Gorge 47.52,46.46 < 15 |walk
Enter the Other Cave Entrance |goto Searing Gorge 49.60,45.50 < 15 |c |multiq 4451,3443,7729 |future
step
label "Collect_Grimesilt_Outhouse_Key"
kill Dark Iron Lookout##8566, Dark Iron Steamsmith##5840, Dark Iron Slaver##5844, Dark Iron Taskmaster##5846
|tip Throughout the cave. |notinsticky
collect Grimesilt Outhouse Key##11818 |goto Searing Gorge 44.60,37.40 |q 4451 |future
|mapmarker Searing Gorge/0 34.40,47.60
|mapmarker Searing Gorge/0 35.40,42.40
|mapmarker Searing Gorge/0 38.20,32.40
|mapmarker Searing Gorge/0 38.20,38.40
|mapmarker Searing Gorge/0 38.40,45.40
|mapmarker Searing Gorge/0 38.40,50.00
|mapmarker Searing Gorge/0 40.00,54.20
|mapmarker Searing Gorge/0 41.00,29.40
|mapmarker Searing Gorge/0 41.20,25.40
|mapmarker Searing Gorge/0 41.80,41.60
|mapmarker Searing Gorge/0 42.40,33.40
|mapmarker Searing Gorge/0 43.60,51.00
|mapmarker Searing Gorge/0 45.40,26.00
|mapmarker Searing Gorge/0 45.40,30.40
step
use Grimesilt Outhouse Key##11818
accept The Key to Freedom##4451
step
label "Collect_Thorium_Plated_Daggers"
kill Dark Iron Steamsmith##5840, Dark Iron Slaver##5844, Dark Iron Taskmaster##5846, Dark Iron Lookout##8566
|tip Slaves Workers also drop them. |notinsticky
|tip Throughout the cave. |notinsticky
collect 8 Thorium Plated Dagger##10551 |q 3443/1 |goto Searing Gorge 44.60,37.40
|mapmarker Searing Gorge/0 34.40,47.60
|mapmarker Searing Gorge/0 35.40,42.40
|mapmarker Searing Gorge/0 38.20,32.40
|mapmarker Searing Gorge/0 38.20,38.40
|mapmarker Searing Gorge/0 38.40,45.40
|mapmarker Searing Gorge/0 38.40,50.00
|mapmarker Searing Gorge/0 40.00,54.20
|mapmarker Searing Gorge/0 41.00,29.40
|mapmarker Searing Gorge/0 41.20,25.40
|mapmarker Searing Gorge/0 41.80,41.60
|mapmarker Searing Gorge/0 42.40,33.40
|mapmarker Searing Gorge/0 43.60,51.00
|mapmarker Searing Gorge/0 45.40,26.00
|mapmarker Searing Gorge/0 45.40,30.40
step
label "Kill_Dark_Iron_Taskmasters_And_Slavers"
kill 15 Dark Iron Taskmaster##5846 |q 7729/1 |goto Searing Gorge 44.60,37.40
kill 15 Dark Iron Slaver##5844 |q 7729/2 |goto Searing Gorge 44.60,37.40
|tip Throughout the cave. |notinsticky
|mapmarker Searing Gorge/0 34.40,47.60
|mapmarker Searing Gorge/0 35.40,42.40
|mapmarker Searing Gorge/0 38.20,32.40
|mapmarker Searing Gorge/0 38.20,38.40
|mapmarker Searing Gorge/0 38.40,45.40
|mapmarker Searing Gorge/0 38.40,50.00
|mapmarker Searing Gorge/0 40.00,54.20
|mapmarker Searing Gorge/0 41.00,29.40
|mapmarker Searing Gorge/0 41.20,25.40
|mapmarker Searing Gorge/0 41.80,41.60
|mapmarker Searing Gorge/0 42.40,33.40
|mapmarker Searing Gorge/0 43.60,51.00
|mapmarker Searing Gorge/0 45.40,26.00
|mapmarker Searing Gorge/0 45.40,30.40
stickystart "Kill_Greater_Lava_Spiders"
stickystart "Kill_Heavy_War_Golems"
step
Leave the cave |goto Searing Gorge 49.60,45.50 < 15 |walk |only if subzone("The Slag Pit") and indoors()
Follow the path up to leave the Cauldron |goto Searing Gorge/0 58.21,40.61 < 15 |only if walking and (subzone("The Slag Pit") or subzone("The Cauldron"))
talk Velarok Windblade##8479
turnin Forging the Shaft##3443 |goto Searing Gorge/0 39.06,38.99
accept The Flame's Casing##3452 |goto Searing Gorge/0 39.06,38.99
step
kill Twilight Dark Shaman##5860, Twilight Fire Guard##5861, Twilight Geomancer##5862, Twilight Idolater##8419
|tip {o}Elite enemies{}.
|tip May need help.
|tip Important to get done.
|tip Unlocks more quests that give good xp.
collect Symbol of Ragnaros##10552 |q 3452/1 |goto Searing Gorge/0 25.00,36.40
|mapmarker Searing Gorge/0 15.00,34.20
|mapmarker Searing Gorge/0 18.00,37.40
|mapmarker Searing Gorge/0 21.00,36.00
|mapmarker Searing Gorge/0 22.20,25.60
|mapmarker Searing Gorge/0 22.40,39.20
|mapmarker Searing Gorge/0 24.20,33.40
|mapmarker Searing Gorge/0 25.00,28.60
|mapmarker Searing Gorge/0 25.40,25.20
|mapmarker Searing Gorge/0 28.00,23.40
|mapmarker Searing Gorge/0 28.60,26.40
step
Leave the cave |goto Searing Gorge/0 21.16,35.91 < 20 |walk |only if subzone("Firewatch Ridge") and indoors()
talk Velarok Windblade##8479
turnin The Flame's Casing##3452 |goto Searing Gorge/0 39.05,38.99
accept The Torch of Retribution##3453 |goto Searing Gorge/0 39.05,38.99
step
Watch the dialogue
Witness the Creation of the Torch |q 3453/1 |goto Searing Gorge/0 39.05,38.99
step
talk Velarok Windblade##8479
turnin The Torch of Retribution##3453 |goto Searing Gorge/0 39.05,38.99
accept The Torch of Retribution##3454 |goto Searing Gorge/0 39.05,38.99
step
click Torch of Retribution
turnin The Torch of Retribution##3454 |goto Searing Gorge/0 39.06,39.06
step
talk Velarok Windblade##8479
accept Squire Maltrake##3462 |goto Searing Gorge/0 39.05,39.00
step
talk Squire Maltrake##8509
turnin Squire Maltrake##3462 |goto Searing Gorge/0 39.16,38.99
accept Set Them Ablaze!##3463 |goto Searing Gorge/0 39.16,38.99
stickystart "Collect_Lookouts_Spyglass"
step
equip Torch of Retribution##10515 |n |only if not equipped(10515)
click Sentry Brazier
|tip Up in the tower.
|tip Careful, {o}elite enemy{}.
Set the Northern Tower Ablaze |q 3463/4 |goto Searing Gorge/0 33.31,54.49
step
Equip Your Normal Weapon |unequipped Torch of Retribution##10515 |q 3463
step
equip Torch of Retribution##10515 |n |only if not equipped(10515)
click Sentry Brazier
|tip Up in the tower.
|tip Careful, {o}elite enemy{}.
Set the Western Tower Ablaze |q 3463/1 |goto Searing Gorge/0 35.67,60.68
step
Equip Your Normal Weapon |unequipped Torch of Retribution##10515 |q 3463
stickystop "Kill_Greater_Lava_Spiders"
step
equip Torch of Retribution##10515 |n |only if not equipped(10515)
click Sentry Brazier
|tip Up in the tower.
|tip Careful, {o}elite enemy{}.
Set the Southern Tower Ablaze |q 3463/2 |goto Searing Gorge/0 44.03,60.91
step
Equip Your Normal Weapon |unequipped Torch of Retribution##10515 |q 3463
step
Cross the hanging bridge |goto Searing Gorge/0 52.48,57.95 < 20 |only if walking
equip Torch of Retribution##10515 |n |only if not equipped(10515)
click Sentry Brazier
|tip Up in the tower.
|tip Careful, {o}elite enemy{}.
Set the Eastern Tower Ablaze |q 3463/3 |goto Searing Gorge/0 50.06,54.74
step
Equip Your Normal Weapon |unequipped Torch of Retribution##10515 |q 3463
stickystop "Collect_Lookouts_Spyglass"
step
click Wooden Outhouse
turnin The Key to Freedom##4451 |goto Searing Gorge/0 65.53,62.23
stickystart "Kill_Greater_Lava_Spiders"
step
Follow the path |goto Searing Gorge 66.79,34.56 < 80 |only if walking
talk Squire Maltrake##8509
turnin Set Them Ablaze!##3463 |goto Searing Gorge/0 39.17,39.00
step
_Destroy This Item:_
|tip Not needed.
trash Torch of Retribution##10515
step
click Hoard of the Black Dragonflight
accept Trinkets...##3481 |goto Searing Gorge/0 38.86,38.99
step
click Hoard of the Black Dragonflight
turnin Trinkets...##3481 |goto Searing Gorge/0 38.86,38.99
step
use Hoard of the Black Dragonflight##10569
collect Black Dragonflight Molt##10575 |q 4022 |future
|tip Needed for a future quest.
step
label "Collect_Lookouts_Spyglass"
kill Dark Iron Lookout##8566+
|tip Near watch towers surrounding the Cauldron.
collect Lookout's Spyglass##18960 |q 7728/2 |goto Searing Gorge 33.20,53.60
|mapmarker Searing Gorge/0 33.80,51.20
|mapmarker Searing Gorge/0 36.00,61.00
|mapmarker Searing Gorge/0 44.40,60.40
|mapmarker Searing Gorge/0 44.40,62.40
|mapmarker Searing Gorge/0 49.20,55.80
|mapmarker Searing Gorge/0 51.40,55.80
|mapmarker Searing Gorge/0 53.60,58.20
step
label "Kill_Greater_Lava_Spiders"
kill 20 Greater Lava Spider##5858 |q 7724/1 |goto Searing Gorge 32.60,42.60
|mapmarker Searing Gorge/0 26.20,51.20
|mapmarker Searing Gorge/0 27.20,37.80
|mapmarker Searing Gorge/0 27.40,42.40
|mapmarker Searing Gorge/0 27.40,47.00
|mapmarker Searing Gorge/0 27.40,55.80
|mapmarker Searing Gorge/0 28.20,65.00
|mapmarker Searing Gorge/0 29.00,75.20
|mapmarker Searing Gorge/0 29.40,79.20
|mapmarker Searing Gorge/0 30.00,61.00
|mapmarker Searing Gorge/0 30.00,70.80
|mapmarker Searing Gorge/0 31.20,38.80
|mapmarker Searing Gorge/0 31.60,55.40
|mapmarker Searing Gorge/0 37.00,34.20
|mapmarker Searing Gorge/0 26.60,69.60
|mapmarker Searing Gorge/0 22.60,74.00
|mapmarker Searing Gorge/0 23.60,78.60
step
label "Kill_Heavy_War_Golems"
kill 20 Heavy War Golem##5854 |q 7723/1	|goto Searing Gorge 39.20,43.40
|mapmarker Searing Gorge/0 31.20,46.60
|mapmarker Searing Gorge/0 32.40,52.20
|mapmarker Searing Gorge/0 34.40,40.40
|mapmarker Searing Gorge/0 34.80,49.00
|mapmarker Searing Gorge/0 35.00,59.80
|mapmarker Searing Gorge/0 35.20,44.40
|mapmarker Searing Gorge/0 36.80,63.80
|mapmarker Searing Gorge/0 38.60,47.40
|mapmarker Searing Gorge/0 41.00,39.40
|mapmarker Searing Gorge/0 43.20,45.60
|mapmarker Searing Gorge/0 44.20,36.80
|mapmarker Searing Gorge/0 45.40,42.00
|mapmarker Searing Gorge/0 48.80,39.80
step
Follow the path up to enter Thorium Point |goto Searing Gorge/0 31.52,33.54 < 20 |only if walking and not subzone("Thorium Point")
talk Hansel Heavyhands##14627
turnin Curse These Fat Fingers##7723 |goto Searing Gorge/0 38.59,27.81
turnin Fiery Menace!##7724 |goto Searing Gorge/0 38.59,27.81
turnin Incendosaurs? Whateverosaur is More Like It##7727 |goto Searing Gorge/0 38.59,27.81
step
talk Taskmaster Scrange##14626
turnin STOLEN: Smithing Tuyere and Lookout's Spyglass##7728 |goto Searing Gorge/0 38.98,27.51
turnin JOB OPPORTUNITY: Culling the Competition##7729 |goto Searing Gorge/0 38.98,27.51
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Burning Steppes & Azshara (51-52)",{
image=ZGV.IMAGESDIR.."Burning Steppes",
hardcore = true,
next="Leveling Guides\\Felwood & Winterspring (52-53)",
},[[
step
Enter Blackrock Mountain and run through to Burning Steppes |complete subzone("Blackrock Mountain") and indoors() |goto Searing Gorge 34.80,83.96
|only if not (haveq(4726) or completedq(4726))
step
Travel to the Burning Steppes |complete zone("Burning Steppes")
|tip Follow the path to the other doorway.
|tip Run down the ramp outside.
|only if not (haveq(4726) or completedq(4726))
step
talk Vahgruk##13177
fpath Flame Crest |goto Burning Steppes 65.68,24.21
step
talk Tinkee Steamboil##10267
accept Broodling Essence##4726 |goto Burning Steppes 65.24,24.00
step
talk Maxwort Uberglint##9536
accept Tablet of the Seven##4296 |goto Burning Steppes 65.16,23.92
step
_NOTE:_
During the Next Steps
|tip Kill enemies as you walk.
|tip Need to be level 52 soon.
Click Here to Continue |confirm |q 4022 |future
step
click Tablet of the Seven
Select _"Transcribe the tablet."_ |gossip 96146
collect Tablet Transcript##11470 |q 4296/1 |goto Burning Steppes 54.09,40.73
step
Follow the path up |goto Burning Steppes 75.39,38.29 < 20 |only if walking
click Sha'ni Proudtusk's Remains
|tip On a stone table.
|tip Top of the mountain.
talk Sha'ni Proudtusk##9136
|tip Appears nearby.
turnin Dreadmaul Rock##3821 |goto Burning Steppes 79.79,45.52
step
Kill enemies
|tip Next quest requires level 52.
ding 52 |goto Burning Steppes 75.60,50.00
|mapmarker Burning Steppes/0 74.40,43.20
|mapmarker Burning Steppes/0 74.40,47.00
|mapmarker Burning Steppes/0 74.60,38.00
|mapmarker Burning Steppes/0 76.40,34.80
|mapmarker Burning Steppes/0 77.20,45.40
|mapmarker Burning Steppes/0 77.80,38.20
|mapmarker Burning Steppes/0 78.00,41.80
|mapmarker Burning Steppes/0 79.80,47.20
|mapmarker Burning Steppes/0 81.40,44.00
|mapmarker Burning Steppes/0 82.40,32.80
|mapmarker Burning Steppes/0 82.40,36.40
|mapmarker Burning Steppes/0 82.60,53.40
|mapmarker Burning Steppes/0 83.20,47.20
|mapmarker Burning Steppes/0 83.60,40.00
|mapmarker Burning Steppes/0 84.00,50.40
|mapmarker Burning Steppes/0 84.80,44.20
|mapmarker Burning Steppes/0 85.60,36.40
|mapmarker Burning Steppes/0 86.40,47.00
|mapmarker Burning Steppes/0 79.60,56.20
|mapmarker Burning Steppes/0 76.60,56.00
stickystart "Collect_Broodling_Essences"
step
talk Cyrus Therepentous##9459
|tip Inside the small cave.
accept A Taste of Flame##4022 |goto Burning Steppes 95.06,31.57
|only if itemcount(10575) > 0 or (haveq(4022) or completedq(4022))
stickystop "Collect_Broodling_Essences"
step
talk Cyrus Therepentous##9459
|tip Inside the small cave.
Select _"I present you with proof of my deeds, Cyrus."_ |gossip 95294
Present the Proof |q 4022/2 |goto Burning Steppes 95.06,31.57
|only if haveq(4022) or completedq(4022)
step
talk Cyrus Therepentous##9459
|tip Inside the small cave.
turnin A Taste of Flame##4022 |goto Burning Steppes 95.06,31.57
|only if haveq(4022) or completedq(4022)
step
label "Collect_Broodling_Essences"
use Draco-Incarcinatrix 900##12284
|tip On Black Broodlings.
|tip Small flying dragons.
kill Black Broodling##7047
click Broodling Essence+
|tip Red crystals above their corpses.
collect 8 Broodling Essence##12283 |q 4726/1 |goto Burning Steppes 91.40,31.40
|mapmarker Burning Steppes/0 79.40,30.80
|mapmarker Burning Steppes/0 81.40,27.00
|mapmarker Burning Steppes/0 81.40,59.40
|mapmarker Burning Steppes/0 82.40,62.60
|mapmarker Burning Steppes/0 88.60,29.40
|mapmarker Burning Steppes/0 84.40,58.40
|mapmarker Burning Steppes/0 85.20,61.40
|mapmarker Burning Steppes/0 85.40,30.40
|mapmarker Burning Steppes/0 87.80,32.40
|mapmarker Burning Steppes/0 88.20,57.00
|mapmarker Burning Steppes/0 88.40,44.20
|mapmarker Burning Steppes/0 90.00,47.40
|mapmarker Burning Steppes/0 90.40,40.80
|mapmarker Burning Steppes/0 91.20,58.40
|mapmarker Burning Steppes/0 84.20,55.00
|mapmarker Burning Steppes/0 92.00,35.40
|mapmarker Burning Steppes/0 92.00,44.80
step
talk Tinkee Steamboil##10267
turnin Broodling Essence##4726 |goto Burning Steppes 65.23,23.99
accept Felnok Steelspring##4808 |goto Burning Steppes 65.23,23.99
step
talk Maxwort Uberglint##9536
turnin Tablet of the Seven##4296 |goto Burning Steppes 65.15,23.91
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 3504 |future
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 3504 |future
|only if Mage
step
talk Karus##3309
|tip Collect from the bank.
|tip Inside the building.
collect Box of Empty Vials##10695	|goto Orgrimmar 49.58,69.12 |q 3568
collect Linken's Training Sword##11133	|goto Orgrimmar 49.58,69.12 |q 3908
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Tinkee's Letter##12438 |goto Orgrimmar 49.58,69.12 |q 4808
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 3504 |future
|only if Priest
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 3504 |future
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3504 |future
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3504 |future
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3504 |future
|only if Warlock
step
talk Belgrom Rockmaul##4485
accept Betrayed##3504 |goto Orgrimmar 75.23,34.23
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 3504 |future
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 3504 |future
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
Run up the stairs |goto Orgrimmar/0 56.42,56.92 < 15 |only if walking
talk Zilzibin Drumlore##7010
|tip Inside the building.
accept March of the Silithid##4494 |goto Orgrimmar/0 56.27,46.67
step
talk Trak'gen##3313
|tip Inside the building.
Buy Extra Ammo |vendor Trak'gen##3313 |goto Orgrimmar/0 48.13,80.54 |q 5535 |future
|tip Long questing session soon.
|tip No ammo available.
|only if Hunter
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Loh'atu##11548
accept Spiritual Unrest##5535 |goto Azshara 11.37,78.16
accept A Land Filled with Hatred##5536 |goto Azshara 11.37,78.16
step
kill 6 Highborne Apparition##6116 |q 5535/1 |goto Azshara/0 13.40,73.40
kill 6 Highborne Lichling##6117 |q 5535/2 |goto Azshara/0 13.40,73.40
|mapmarker Azshara/0 15.80,73.60
|mapmarker Azshara/0 16.40,67.80
|mapmarker Azshara/0 16.40,70.40
step
kill 2 Haldarr Trickster##6126 |q 5536/2 |goto Azshara/0 19.80,64.60
kill 2 Haldarr Felsworn##6127 |q 5536/3 |goto Azshara/0 19.80,64.60
kill 6 Haldarr Satyr##6125 |q 5536/1 |goto Azshara/0 19.80,64.60
|mapmarker Azshara/0 19.20,62.60
|mapmarker Azshara/0 20.20,60.40
step
talk Loh'atu##11548
turnin Spiritual Unrest##5535 |goto Azshara 11.37,78.17
turnin A Land Filled with Hatred##5536 |goto Azshara 11.37,78.17
step
talk Kroum##8610
fpath Valormok |goto Azshara 21.96,49.62
step
talk Ag'tor Bloodfist##8576
turnin Betrayed##3504 |goto Azshara 22.26,51.48
step
talk Jediga##8587
accept Stealing Knowledge##3517 |goto Azshara 22.56,51.42
stickystart "Collect_Tablet_Of_BethAmara"
stickystart "Collect_Tablet_Of_Jinyael"
stickystart "Collect_Tablet_Of_Saelhai"
step
click Tablet of Markri##148514
|tip Stone rectangle with green runes.
|tip Multiple locations.
collect Tablet of Markri##10540 |q 3517/3 |goto Azshara 35.00,54.60
|mapmarker Azshara/0 34.20,57.90
|mapmarker Azshara/0 34.80,51.40
|mapmarker Azshara/0 35.90,59.10
|mapmarker Azshara/0 36.20,52.40
|mapmarker Azshara/0 36.80,49.40
|mapmarker Azshara/0 37.90,47.80
|mapmarker Azshara/0 37.90,50.10
|mapmarker Azshara/0 38.30,60.60
|mapmarker Azshara/0 38.90,46.90
|mapmarker Azshara/0 38.90,56.80
|mapmarker Azshara/0 39.20,58.90
|mapmarker Azshara/0 39.80,48.70
|mapmarker Azshara/0 39.90,45.90
|mapmarker Azshara/0 39.90,60.30
|mapmarker Azshara/0 40.70,63.00
step
label "Collect_Tablet_Of_BethAmara"
click Tablet of Beth'Amara##148516
|tip Stone rectangle with pink runes.
|tip Multiple locations. |notinsticky
collect Tablet of Beth'Amara##10538 |q 3517/1 |goto Azshara 35.20,55.80
|mapmarker Azshara/0 34.10,50.40
|mapmarker Azshara/0 34.40,55.20
|mapmarker Azshara/0 34.80,52.60
|mapmarker Azshara/0 35.20,57.90
|mapmarker Azshara/0 36.80,58.50
|mapmarker Azshara/0 36.80,60.40
|mapmarker Azshara/0 37.10,51.80
|mapmarker Azshara/0 38.30,47.50
|mapmarker Azshara/0 38.40,43.60
|mapmarker Azshara/0 38.40,60.30
|mapmarker Azshara/0 38.80,62.40
|mapmarker Azshara/0 39.40,52.40
|mapmarker Azshara/0 39.50,64.30
|mapmarker Azshara/0 40.00,45.70
|mapmarker Azshara/0 40.80,62.60
|mapmarker Azshara/0 41.50,46.40
step
label "Collect_Tablet_Of_Jinyael"
click Tablet of Jin'yael##148513
|tip Stone rectangle with blue runes.
|tip Multiple locations. |notinsticky
collect Tablet of Jin'yael##10539 |q 3517/2 |goto Azshara 34.80,53.30
|mapmarker Azshara/0 34.00,59.90
|mapmarker Azshara/0 35.40,58.50
|mapmarker Azshara/0 35.60,49.60
|mapmarker Azshara/0 36.00,56.90
|mapmarker Azshara/0 36.30,62.20
|mapmarker Azshara/0 36.40,54.00
|mapmarker Azshara/0 36.40,60.60
|mapmarker Azshara/0 37.70,52.40
|mapmarker Azshara/0 38.00,51.30
|mapmarker Azshara/0 38.70,63.30
|mapmarker Azshara/0 39.20,61.40
|mapmarker Azshara/0 39.40,56.50
|mapmarker Azshara/0 40.20,62.50
|mapmarker Azshara/0 41.00,55.00
|mapmarker Azshara/0 41.20,62.00
|mapmarker Azshara/0 43.40,64.00
step
label "Collect_Tablet_Of_Saelhai"
click Tablet of Sael'hai##148515
|tip Stone rectangle with yellow runes.
|tip Multiple locations. |notinsticky
collect Tablet of Sael'hai##10541 |q 3517/4 |goto Azshara 34.80,54.10
|mapmarker Azshara/0 35.60,55.80
|mapmarker Azshara/0 35.90,53.40
|mapmarker Azshara/0 36.10,59.90
|mapmarker Azshara/0 36.20,54.50
|mapmarker Azshara/0 36.60,56.80
|mapmarker Azshara/0 36.90,49.60
|mapmarker Azshara/0 37.20,58.00
|mapmarker Azshara/0 37.30,48.10
|mapmarker Azshara/0 38.10,53.90
|mapmarker Azshara/0 38.60,47.60
|mapmarker Azshara/0 38.60,49.30
|mapmarker Azshara/0 38.70,52.60
|mapmarker Azshara/0 39.10,64.50
|mapmarker Azshara/0 39.30,50.50
|mapmarker Azshara/0 39.40,59.80
|mapmarker Azshara/0 40.40,63.30
|mapmarker Azshara/0 41.10,64.20
|mapmarker Azshara/0 43.50,63.50
step
use Box of Empty Vials##10695
collect Empty Vial Labeled #1##10687 |q 3568
collect Empty Vial Labeled #2##10688 |q 3568
collect Empty Vial Labeled #3##10689 |q 3568
collect Empty Vial Labeled #4##10690 |q 3568
step
use Empty Vial Labeled #1##10687
|tip In the water.
collect Filled Vial Labeled #1##10691 |q 3568/1 |goto Azshara 47.70,61.05
step
use Empty Vial Labeled #2##10688
|tip In the water.
collect Filled Vial Labeled #2##10692 |q 3568/2 |goto Azshara 47.86,51.55
step
use Empty Vial Labeled #3##10689
|tip In the water.
collect Filled Vial Labeled #3##10693 |q 3568/3 |goto Azshara 48.60,48.56
step
use Empty Vial Labeled #4##10690
|tip In the water.
collect Filled Vial Labeled #4##10694 |q 3568/4 |goto Azshara 47.41,46.28
step
Follow the path up |goto Azshara 46.00,38.71 < 30 |only if walking and subzone("The Shattered Strand")
talk Jediga##8587
turnin Stealing Knowledge##3517 |goto Azshara 22.56,51.42
accept Delivery to Magatha##3518 |goto Azshara 22.56,51.42
accept Delivery to Jes'rimon##3541 |goto Azshara 22.56,51.42
accept Delivery to Archmage Xylem##3561 |goto Azshara 22.56,51.42
step
talk Sanath Lim-yo##8395
accept Meeting with the Master##3503 |goto Azshara 28.11,50.09
|tip Teleports you up the cliff.
|only if haveq(3561)
step
talk Archmage Xylem##8379
|tip Walks around.
|tip {o}Multiple floors{} inside the tower.
turnin Delivery to Archmage Xylem##3561 |goto Azshara 29.71,40.52
accept Xylem's Payment to Jediga##3565 |goto Azshara 29.71,40.52
step
talk Nyrill##8399
accept Return Trip##3421 |goto Azshara 26.47,46.28
|tip Teleports you to the ground.
|only if haveq(3565)
step
talk Jediga##8587
turnin Xylem's Payment to Jediga##3565 |goto Azshara 22.56,51.42
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Felwood & Winterspring (52-53)",{
image=ZGV.IMAGESDIR.."Felwood",
hardcore = true,
next="Leveling Guides\\Un'Goro Crater (53-54)",
},[[
step
talk Greta Mosshoof##10922
|tip Walks around.
accept Forces of Jaedenar##5155 |goto Felwood 51.21,82.11
step
talk Taronn Redfeather##10921
|tip Inside the building.
accept Verifying the Corruption##5156 |goto Felwood 50.89,81.62
step
talk Grazle##11554
accept Timbermaw Ally##8460 |goto Felwood 50.93,85.01
step
_NOTE:_
While in Felwood
|tip Kill enemies as you walk.
|tip Reduces grinding later.
Click Here to Continue |confirm |q 8460
step
kill 6 Deadwood Warrior##7153 |q 8460/1 |goto Felwood 48.40,89.20
kill 6 Deadwood Pathfinder##7155 |q 8460/2 |goto Felwood 48.40,89.20
kill 6 Deadwood Gardener##7154 |q 8460/3 |goto Felwood 48.40,89.20
|mapmarker Felwood/0 46.20,89.20
|mapmarker Felwood/0 46.80,91.80
|mapmarker Felwood/0 48.00,93.40
|mapmarker Felwood/0 49.40,91.60
step
talk Grazle##11554
turnin Timbermaw Ally##8460 |goto Felwood 50.93,85.02
accept Speak to Nafien##8462 |goto Felwood 50.93,85.02
step
kill Deadwood Warrior##7153, Deadwood Pathfinder##7155, Deadwood Gardener##7154
collect Deadwood Headdress Feather##21377+ |n
|tip Don't vendor them.
|tip Can be turned in later for {o}xp and reputation{}.
Reach {y}Unfriendly{} Reputation with the Timbermaw Hold Faction |complete rep('Timbermaw Hold') >= Unfriendly |goto Felwood 48.40,89.20
|mapmarker Felwood/0 46.20,89.20
|mapmarker Felwood/0 46.80,91.80
|mapmarker Felwood/0 48.00,93.40
|mapmarker Felwood/0 49.40,91.60
step
talk Maybess Riverbreeze##9529
|tip Walks around.
accept Cleansing Felwood##4102 |goto Felwood 46.68,82.98
step
kill 4 Jaedenar Hound##7125 |q 5155/1 |goto Felwood 40.40,57.60
kill 4 Jaedenar Guardian##7113 |q 5155/2 |goto Felwood 40.40,57.60
kill 6 Jaedenar Adept##7115 |q 5155/3 |goto Felwood 40.40,57.60
kill 6 Jaedenar Cultist##7112 |q 5155/4 |goto Felwood 40.40,57.60
|tip More inside the caves.
|mapmarker Felwood/0 35.39,58.57
|mapmarker Felwood/0 36.40,61.20
|mapmarker Felwood/0 38.20,60.20
|mapmarker Felwood/0 38.60,57.60
|mapmarker Felwood/0 39.11,59.52
|mapmarker Felwood/0 38.60,57.60
step
Follow the path |goto Felwood 38.65,57.32 < 40 |only if walking and subzone("Jaedenar")
Follow the river west |goto Felwood 37.54,49.25 < 40 |only if walking and not subzone("Bloodvenom Post ")
talk Winna Hazzard##9996
accept Well of Corruption##4505 |goto Felwood 34.21,52.34
step
talk Dreka'Sur##9620
accept A Husband's Last Battle##6162 |goto Felwood 34.80,52.73
step
talk Bale##2806
|tip Inside the building.
Buy Extra Ammo |vendor Trak'gen##3313 |goto Felwood/0 34.75,53.23 |q 4505
|tip Long grind soon.
|only if Hunter
step
talk Brakkar##11900
fpath Bloodvenom Post |goto Felwood 34.44,53.96
step
Run around the mountain and follow the path |goto Felwood 36.64,66.86 < 40 |only if walking
use Hardened Flasket##12566
|tip Careful, stealthed enemies.
collect Filled Flasket##12567 |q 4505/1 |goto Felwood 32.41,66.58
step
kill Overlord Ror##9464
collect Overlord Ror's Claw##15879 |q 6162/1 |goto Felwood 48.23,94.27
step
Kill enemies
|tip Helps reach level 53 after quest turnins.
|tip Higher level enemies soon.
|tip Run dungeons, if you prefer.
collect Deadwood Headdress Feather##21377+ |n
|tip Don't vendor them.
|tip Can be turned in later for {o}xp and reputation{}.
ding 52,155500 |goto Felwood 48.40,89.20
|mapmarker Felwood/0 46.20,89.20
|mapmarker Felwood/0 46.80,91.80
|mapmarker Felwood/0 48.00,93.40
|mapmarker Felwood/0 49.40,91.60
step
talk Greta Mosshoof##10922
|tip Walks around.
turnin Forces of Jaedenar##5155 |goto Felwood 51.21,82.11
accept Collection of the Corrupt Water##5157 |goto Felwood 51.21,82.11
step
Follow the path into Jaedenar |goto Felwood 38.43,59.68 < 30 |only if walking
use Empty Canteen##12922
collect Corrupt Moonwell Water##12907 |q 5157/1 |goto Felwood 35.19,59.95
stickystart "Kill_Entropic_Beasts_And_Horrors"
step
Explore the Craters in Shatter Scar Vale |q 5156/3 |goto Felwood 41.54,42.98
step
label "Kill_Entropic_Beasts_And_Horrors"
kill 2 Entropic Beast##9878 |q 5156/1 |goto Felwood 42.60,41.40
kill 2 Entropic Horror##9879 |q 5156/2 |goto Felwood 42.60,41.40
|mapmarker Felwood/0 40.00,38.40
|mapmarker Felwood/0 40.00,43.40
|mapmarker Felwood/0 40.40,41.00
|mapmarker Felwood/0 41.40,36.40
|mapmarker Felwood/0 42.20,43.60
|mapmarker Felwood/0 42.60,38.00
|mapmarker Felwood/0 44.20,42.80
|mapmarker Felwood/0 44.40,40.40
|mapmarker Felwood/0 45.20,38.00
|mapmarker Felwood/0 46.60,39.60
step
kill Warpwood Moss Flayer##7100, Warpwood Shredder##7101
|tip Swamp elementals.
|tip Inside and outside the cave.
collect 15 Blood Amber##11503 |q 4102/1 |goto Felwood 55.78,16.85
|mapmarker Felwood/0 54.40,16.20
|mapmarker Felwood/0 58.00,17.60
|mapmarker Felwood/0 57.00,21.00
|mapmarker Felwood/0 59.20,20.40
|mapmarker Felwood/0 54.91,19.04
step
Leave the cave |goto Felwood 55.88,17.15 < 40 |walk |only if subzone("Irontree Cavern")
kill 12 Angerclaw Grizzly##8957 |q 4120/1 |goto Felwood/0 52.00,16.00
|tip Bears.
kill 12 Felpaw Ravager##8961 |q 4120/2 |goto Felwood/0 52.00,16.00
|tip Wolves.
|mapmarker Felwood/0 50.00,13.20
|mapmarker Felwood/0 52.40,27.20
|mapmarker Felwood/0 53.80,13.40
|mapmarker Felwood/0 54.60,25.00
|mapmarker Felwood/0 55.40,10.40
|mapmarker Felwood/0 55.40,21.20
|mapmarker Felwood/0 56.40,6.40
|mapmarker Felwood/0 57.40,18.40
|mapmarker Felwood/0 58.20,15.20
|mapmarker Felwood/0 60.80,17.00
|mapmarker Felwood/0 63.40,13.40
|mapmarker Felwood/0 64.40,19.80
step
talk Nafien##15395
|tip Follow the road.
turnin Speak to Nafien##8462 |goto Felwood 64.77,8.13
step
talk Donova Snowden##9298
accept Threat of the Winterfall##5082 |goto Winterspring 31.27,45.16
turnin It's a Secret to Everybody##3908 |goto Winterspring 31.27,45.16
stickystart "Kill_Winterfall_Enemies"
step
kill Winterfall Totemic##7441, Winterfall Pathfinder##7442, Winterfall Den Watcher##7440
|tip Furbolgs.
collect Empty Firewater Flask##12771 |n
use Empty Firewater Flask##12771
accept Winterfall Firewater##5083 |goto Winterspring 30.00,35.40
|mapmarker Winterspring/0 33.60,37.00
|mapmarker Winterspring/0 40.40,42.40
|mapmarker Winterspring/0 42.60,43.20
step
label "Kill_Winterfall_Enemies"
kill 8 Winterfall Totemic##7441 |q 5082/3 |goto Winterspring 30.00,35.40
kill 8 Winterfall Pathfinder##7442 |q 5082/1 |goto Winterspring 30.00,35.40
kill 8 Winterfall Den Watcher##7440 |q 5082/2 |goto Winterspring 30.00,35.40
|tip Shared spawns.
|mapmarker Winterspring/0 33.60,37.00
|mapmarker Winterspring/0 40.40,42.40
|mapmarker Winterspring/0 42.60,43.20
step
talk Donova Snowden##9298
turnin Threat of the Winterfall##5082 |goto Winterspring 31.27,45.16
turnin Winterfall Firewater##5083 |goto Winterspring 31.27,45.16
accept Falling to Corruption##5084 |goto Winterspring 31.27,45.16
accept The Videre Elixir##3909 |goto Winterspring 31.27,45.16
step
talk Azzleby##11119
Stable Your Pet |stablemaster Azzleby##11119 |goto Winterspring/0 60.39,37.92 |q 4808
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 7){}.
|only if Hunter
step
talk Izzy Coppergrab##13917
|tip Collect from the bank.
|tip Inside the building.
collect Tinkee's Letter##12438 |goto Winterspring/0 61.46,36.97 |q 4808
step
talk Izzy Coppergrab##13917
|tip Deposit into the bank.
|tip Inside the building.
bank Tablet of Beth'Amara##10538	|goto Winterspring/0 61.46,36.97 |q 3518
bank Filled Vial Labeled #1##10691	|goto Winterspring/0 61.46,36.97 |q 3568
bank Filled Vial Labeled #2##10692	|goto Winterspring/0 61.46,36.97 |q 3568
bank Filled Vial Labeled #3##10693	|goto Winterspring/0 61.46,36.97 |q 3568
bank Filled Vial Labeled #4##10694	|goto Winterspring/0 61.46,36.97 |q 3568
step
talk Felnok Steelspring##10468
turnin Felnok Steelspring##4808 |goto Winterspring 61.63,38.61
step
talk Yugrek##11139
fpath Everlook |goto Winterspring 60.47,36.30
step
talk Dreka'Sur##9620
turnin A Husband's Last Battle##6162 |goto Felwood 34.80,52.73
step
talk Winna Hazzard##9996
turnin Well of Corruption##4505 |goto Felwood 34.21,52.34
step
Learn the {y}Claw (Rank 7){} Pet Ability |learnspell Claw##2977 |goto Felwood 39.00,50.40 |q 4102
|tip Cast {o}Tame Beast{} on an {o}Angerclaw Mauler{}.
|tip Diseased brown bears.
|tip Kill enemies nearby.
|mapmarker Felwood/0 38.20,56.20
|mapmarker Felwood/0 38.40,41.40
|mapmarker Felwood/0 38.80,45.40
|mapmarker Felwood/0 42.40,57.80
|mapmarker Felwood/0 42.60,63.00
|mapmarker Felwood/0 43.80,67.40
|only if Hunter
step
talk Maybess Riverbreeze##9529
|tip Walks around.
turnin Cleansing Felwood##4102 |goto Felwood 46.72,83.07
step
talk Maybess Riverbreeze##9529
|tip Walks around.
Select _"I need a Cenarion beacon."_ |gossip 96156
collect Cenarion Beacon##11511 |goto Felwood 46.72,83.07 |q 5887 |future
step
talk Greta Mosshoof##10922
|tip Walks around.
turnin Collection of the Corrupt Water##5157 |goto Felwood 51.21,82.11
accept Seeking Spiritual Aid##5158 |goto Felwood 51.21,82.11
step
talk Taronn Redfeather##10921
|tip Inside the building.
turnin Verifying the Corruption##5156 |goto Felwood 50.89,81.62
step
talk Jes'rimon##8659
|tip Up on the balcony of the building.
turnin Delivery to Jes'rimon##3541 |goto Orgrimmar 55.51,34.09
accept Jes'rimon's Payment to Jediga##3563 |goto Orgrimmar 55.51,34.09
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Auctioneer Thathung##8673
|tip Buy from the Auction House, if possible.
|tip Inside the building.
collect Mithril Casing##10561 |goto Orgrimmar 55.69,62.86 |q 4244 |future
|tip Needed for future quest in Un'Goro Crater.
step
talk Karus##3309
|tip Collect from the bank.
|tip Inside the building.
collect Torwa's Pouch##11568						|goto Orgrimmar 49.58,69.12 |q 4292
collect 25 Un'Goro Soil##11018 |complete itembanked(11018) == 0		|goto Orgrimmar 49.58,69.12 |multiq 3761,4496 |future
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Jes'rimon's Note##10680 |goto Orgrimmar 49.58,69.12 |q 3563
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Kelsuwa##9983
Retrieve Your Pet |stablemaster Kelsuwa##9983 |goto The Barrens/0 45.30,58.66 |q 4494
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 7){} to Your Pet |learnpetspell Claw##3010 |q 4494
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
talk Innkeeper Byula##7714
|tip Inside the building.
home Camp Taurajo |goto The Barrens/0 45.58,59.04 |q 3783 |future
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Un'Goro Crater (53-54)",{
image=ZGV.IMAGESDIR.."Un'Goro Crater",
hardcore = true,
next="Leveling Guides\\Azshara (54-54)",
},[[
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin March of the Silithid##4494 |goto Tanaris 50.89,26.96
accept Bungle in the Jungle##4496 |goto Tanaris 50.89,26.96
step
talk Larion##9118
accept Larion and Muigin##4145 |goto Un'Goro Crater/0 45.54,8.72
step
talk Williden Marshal##9270
accept Expedition Salvation##3881 |goto Un'Goro Crater/0 43.95,7.14
step
talk Hol'anyee Marshal##9271
accept Alien Ecology##3883 |goto Un'Goro Crater/0 43.89,7.24
step
talk Spark Nilminer##9272
accept Roll the Bones##3882 |goto Un'Goro Crater/0 43.50,7.42
step
Enter the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
accept The Western Pylon##4288 |goto Un'Goro Crater/0 41.92,2.70
step
Leave the cave |goto Un'Goro Crater/0 43.47,6.81 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
click Beware of Pterrordax
accept Beware of Pterrordax##4501 |goto Un'Goro Crater/0 43.55,8.42
step
talk Spraggle Frock##9997
accept Lost!##4492 |goto Un'Goro Crater/0 43.62,8.50
step
talk Shizzle##9998
accept Shizzle's Flyer##4503 |goto Un'Goro Crater/0 44.24,11.59
tickystart "Kill_Bloodpetal_Flayers"
stickystart "Collect_Webbed_Pterrordax_Scales"
stickystart "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
stickystart "Collect_UnGoro_Soil"
step
kill 10 Pterrordax##9166 |q 4501/1 |goto Un'Goro Crater/0 56.00,9.80
|tip Skip once no more to kill.
|tip Can finish later.
|mapmarker Un'Goro Crater/0 57.40,8.20
|mapmarker Un'Goro Crater/0 57.60,12.80
step
label "Kill_Bloodpetal_Flayers"
kill 5 Bloodpetal Flayer##6510 |q 4145/3 |goto Un'Goro Crater/0 55.80,16.00
|tip Walking plants.
|mapmarker Un'Goro Crater/0 43.60,26.60
|mapmarker Un'Goro Crater/0 44.20,29.60
|mapmarker Un'Goro Crater/0 45.00,37.60
|mapmarker Un'Goro Crater/0 46.20,22.00
|mapmarker Un'Goro Crater/0 48.40,28.20
|mapmarker Un'Goro Crater/0 50.40,35.00
|mapmarker Un'Goro Crater/0 51.40,20.40
|mapmarker Un'Goro Crater/0 52.20,13.40
|mapmarker Un'Goro Crater/0 52.40,16.80
|mapmarker Un'Goro Crater/0 53.20,31.00
|mapmarker Un'Goro Crater/0 55.20,22.40
|mapmarker Un'Goro Crater/0 55.80,29.40
|mapmarker Un'Goro Crater/0 56.40,25.40
|mapmarker Un'Goro Crater/0 57.20,19.40
|mapmarker Un'Goro Crater/0 60.20,20.20
stickystop "Collect_Webbed_Pterrordax_Scales"
stickystop "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
stickystart "Collect_UnGoro_Thunderer_Pelts"
stickystart "Collect_UnGoro_Stomper_Pelts"
step
kill Un'Goro Gorilla##6514+
|tip Inside and outside the cave.
collect 2 Un'Goro Gorilla Pelt##11478 |q 4289/1 |goto Un'Goro Crater/0 64.23,16.36
|mapmarker Un'Goro Crater/0 60.40,17.00
|mapmarker Un'Goro Crater/0 62.40,16.40
|mapmarker Un'Goro Crater/0 62.40,19.40
|mapmarker Un'Goro Crater/0 65.00,16.60
|mapmarker Un'Goro Crater/0 65.20,14.40
|mapmarker Un'Goro Crater/0 66.80,17.60
|mapmarker Un'Goro Crater/0 67.20,14.80
|mapmarker Un'Goro Crater/0 68.40,13.20
|mapmarker Un'Goro Crater/0 68.80,17.40
step
label "Collect_UnGoro_Stomper_Pelts"
kill Un'Goro Stomper##6513+
|tip Inside and outside the cave. |notinsticky
collect 2 Un'Goro Stomper Pelt##11479 |q 4289/2 |goto Un'Goro Crater/0 64.23,16.36
|mapmarker Un'Goro Crater/0 60.40,17.00
|mapmarker Un'Goro Crater/0 62.40,16.40
|mapmarker Un'Goro Crater/0 62.40,19.40
|mapmarker Un'Goro Crater/0 65.00,16.60
|mapmarker Un'Goro Crater/0 65.20,14.40
|mapmarker Un'Goro Crater/0 66.80,17.60
|mapmarker Un'Goro Crater/0 67.20,14.80
|mapmarker Un'Goro Crater/0 68.40,13.20
|mapmarker Un'Goro Crater/0 68.80,17.40
step
label "Collect_UnGoro_Thunderer_Pelts"
kill Un'Goro Thunderer##6516+
|tip Inside and outside the cave. |notinsticky
collect 2 Un'Goro Thunderer Pelt##11480 |q 4289/3 |goto Un'Goro Crater/0 64.23,16.36
|mapmarker Un'Goro Crater/0 60.40,17.00
|mapmarker Un'Goro Crater/0 62.40,16.40
|mapmarker Un'Goro Crater/0 62.40,19.40
|mapmarker Un'Goro Crater/0 65.00,16.60
|mapmarker Un'Goro Crater/0 65.20,14.40
|mapmarker Un'Goro Crater/0 66.80,17.60
|mapmarker Un'Goro Crater/0 67.20,14.80
|mapmarker Un'Goro Crater/0 68.40,13.20
|mapmarker Un'Goro Crater/0 68.80,17.40
stickystart "Kill_Bloodpetal_Threshers_And_Lashers"
stickystart "Collect_Webbed_Pterrordax_Scales"
stickystart "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
step
Leave the cave |goto Un'Goro Crater/0 64.23,16.36 < 15 |walk |only if subzone("Fungal Rock") and indoors()
click Crate of Foodstuffs
collect Crate of Foodstuffs##11113 |q 3881/1 |goto Un'Goro Crater/0 68.51,36.54
step
label "Kill_Bloodpetal_Threshers_And_Lashers"
kill 5 Bloodpetal Thresher##6511 |q 4145/4 |goto Un'Goro Crater/0 67.60,34.60
kill 5 Bloodpetal Lasher##6509 |q 4145/1 |goto Un'Goro Crater/0 67.60,34.60
|tip Walking plants. |notinsticky
|mapmarker Un'Goro Crater/0 57.00,33.40
|mapmarker Un'Goro Crater/0 57.20,38.60
|mapmarker Un'Goro Crater/0 60.00,35.20
|mapmarker Un'Goro Crater/0 60.20,40.80
|mapmarker Un'Goro Crater/0 61.00,27.40
|mapmarker Un'Goro Crater/0 62.40,31.20
|mapmarker Un'Goro Crater/0 62.40,38.40
|mapmarker Un'Goro Crater/0 63.20,42.00
|mapmarker Un'Goro Crater/0 64.40,27.40
|mapmarker Un'Goro Crater/0 64.40,33.60
|mapmarker Un'Goro Crater/0 65.40,39.40
|mapmarker Un'Goro Crater/0 65.60,30.60
|mapmarker Un'Goro Crater/0 67.20,25.60
|mapmarker Un'Goro Crater/0 68.20,22.60
|mapmarker Un'Goro Crater/0 68.60,29.40
|mapmarker Un'Goro Crater/0 69.40,38.20
|mapmarker Un'Goro Crater/0 70.60,41.00
|mapmarker Un'Goro Crater/0 71.00,24.80
|mapmarker Un'Goro Crater/0 71.60,28.40
|mapmarker Un'Goro Crater/0 72.40,37.20
|mapmarker Un'Goro Crater/0 73.20,33.00
|mapmarker Un'Goro Crater/0 73.40,46.40
|mapmarker Un'Goro Crater/0 74.20,40.00
|mapmarker Un'Goro Crater/0 74.20,50.40
|mapmarker Un'Goro Crater/0 74.80,43.40
|mapmarker Un'Goro Crater/0 76.40,47.40
step
use Torwa's Pouch##11568
collect Preserved Threshadon Meat##11569 |q 4292
collect Preserved Pheromone Mixture##11570 |q 4292
step
use Preserved Threshadon Meat##11569
use Preserved Pheromone Mixture##11570
kill Lar'korwi##9684
collect Lar'korwi's Head##11510 |q 4292/1 |goto Un'Goro Crater/0 79.92,49.90
step
talk Torwa Pathfinder##9619
turnin The Apes of Un'Goro##4289 |goto Un'Goro Crater/0 71.64,75.97
turnin The Bait for Lar'korwi##4292 |goto Un'Goro Crater/0 71.63,75.96
accept The Mighty U'cha##4301 |goto Un'Goro Crater/0 71.64,75.97
stickystop "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
step
kill 10 Pterrordax##9166 |q 4501/1 |goto Un'Goro Crater/0 58.00,86.40
|mapmarker Un'Goro Crater/0 42.80,86.00
|mapmarker Un'Goro Crater/0 43.40,92.40
|mapmarker Un'Goro Crater/0 44.20,88.40
|mapmarker Un'Goro Crater/0 50.40,87.20
|mapmarker Un'Goro Crater/0 50.40,89.60
|mapmarker Un'Goro Crater/0 56.60,91.60
|mapmarker Un'Goro Crater/0 56.20,88.20
stickystop "Collect_Webbed_Pterrordax_Scales"
stickystart "Collect_Gorishi_Scent_Gland"
step
Enter the cave |goto Un'Goro Crater/0 49.95,81.70 < 15 |walk |only if not (subzone("The Slithering Scar") and indoors())
use Unused Scraping Vial##11132
|tip Inside the cave.
collect Hive Wall Sample##11131 |q 3883/1 |goto Un'Goro Crater/0 48.74,85.21
step
label "Collect_Gorishi_Scent_Gland"
kill Gorishi Worker##6552, Gorishi Wasp##6551, Gorishi Reaver##6553, Gorishi Tunneler##6555, Gorishi Stinger##6554, Gorishi Hive Guard##10040
|tip Insects.
|tip Inside and outside the cave. |notinsticky
collect Gorishi Scent Gland##11837 |q 4496/1 |goto Un'Goro Crater/0 49.95,81.70
|mapmarker Un'Goro Crater/0 42.00,79.40
|mapmarker Un'Goro Crater/0 42.40,82.40
|mapmarker Un'Goro Crater/0 43.20,75.20
|mapmarker Un'Goro Crater/0 44.20,85.20
|mapmarker Un'Goro Crater/0 45.00,78.40
|mapmarker Un'Goro Crater/0 45.40,82.00
|mapmarker Un'Goro Crater/0 46.20,73.40
|mapmarker Un'Goro Crater/0 47.40,84.80
|mapmarker Un'Goro Crater/0 47.60,76.40
|mapmarker Un'Goro Crater/0 48.00,80.20
|mapmarker Un'Goro Crater/0 50.20,74.20
|mapmarker Un'Goro Crater/0 50.60,78.40
|mapmarker Un'Goro Crater/0 51.20,84.40
|mapmarker Un'Goro Crater/0 51.40,71.40
|mapmarker Un'Goro Crater/0 52.80,75.80
|mapmarker Un'Goro Crater/0 53.80,79.80
|mapmarker Un'Goro Crater/0 53.80,86.60
|mapmarker Un'Goro Crater/0 55.40,83.00
stickystart "Kill_Bloodpetal_Trappers"
stickystart "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
stickystart "Kill_Frenzied_Pterrordax"
stickystart "Collect_Webbed_Pterrordax_Scales"
step
Leave the cave |goto Un'Goro Crater/0 49.94,81.65 < 10 |only if subzone("The Slithering Scar") and indoors()
click Research Equipment
collect Research Equipment##11112 |q 3881/2 |goto Un'Goro Crater/0 38.47,66.11
step
click Western Crystal Pylon
|tip Up on the cliff.
Select _"I want to examine this pylon."_ |gossip 96123
Discover and Examine the Western Crystal Pylon |q 4288/1 |goto Un'Goro Crater/0 23.79,59.19
step
talk Krakle##10302
accept Finding the Source##974 |goto Un'Goro Crater/0 30.93,50.43
stickystart "Collect_UnGoro_Ash"
step
Follow the path up |goto Un'Goro Crater/0 46.30,45.65 < 20 |only if walking
use Krakle's Thermometer##12472
|tip Top of the mountain.
Find the Hottest Area of Fire Plume Ridge |q 974/1 |goto Un'Goro Crater/0 49.70,45.74
step
talk Krakle##10302
turnin Finding the Source##974 |goto Un'Goro Crater/0 30.93,50.43
accept The New Springs##980 |goto Un'Goro Crater/0 30.93,50.44
stickystop "Collect_UnGoro_Ash"
step
label "Kill_Bloodpetal_Trappers"
kill 5 Bloodpetal Trapper##6512 |q 4145/2 |goto Un'Goro Crater/0 34.80,40.00
|tip Walking plants. |notinsticky
|mapmarker Un'Goro Crater/0 24.60,43.80
|mapmarker Un'Goro Crater/0 25.40,39.80
|mapmarker Un'Goro Crater/0 26.20,35.20
|mapmarker Un'Goro Crater/0 27.40,31.40
|mapmarker Un'Goro Crater/0 28.40,38.20
|mapmarker Un'Goro Crater/0 28.40,42.40
|mapmarker Un'Goro Crater/0 29.40,45.60
|mapmarker Un'Goro Crater/0 30.20,28.20
|mapmarker Un'Goro Crater/0 31.00,34.20
|mapmarker Un'Goro Crater/0 31.40,41.80
|mapmarker Un'Goro Crater/0 31.60,37.20
|mapmarker Un'Goro Crater/0 32.00,47.60
|mapmarker Un'Goro Crater/0 33.20,44.40
|mapmarker Un'Goro Crater/0 33.40,28.80
|mapmarker Un'Goro Crater/0 33.80,32.60
|mapmarker Un'Goro Crater/0 34.60,35.80
|mapmarker Un'Goro Crater/0 35.40,46.60
|mapmarker Un'Goro Crater/0 36.80,28.80
|mapmarker Un'Goro Crater/0 37.20,32.00
|mapmarker Un'Goro Crater/0 37.40,42.40
|mapmarker Un'Goro Crater/0 37.40,49.40
|mapmarker Un'Goro Crater/0 37.60,36.20
|mapmarker Un'Goro Crater/0 38.80,39.60
|mapmarker Un'Goro Crater/0 39.20,46.60
|mapmarker Un'Goro Crater/0 40.00,33.80
|mapmarker Un'Goro Crater/0 40.00,51.80
|mapmarker Un'Goro Crater/0 40.60,36.80
|mapmarker Un'Goro Crater/0 40.60,43.60
|mapmarker Un'Goro Crater/0 41.00,30.00
|mapmarker Un'Goro Crater/0 42.20,49.60
|mapmarker Un'Goro Crater/0 42.80,46.40
step
label "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
kill Young Diemetradon##9162, Diemetradon##9163, Elder Diemetradon##9164
collect 8 Dinosaur Bone##11114 |q 3882/1 |goto Un'Goro Crater/0 34.80,40.00
collect 8 Webbed Diemetradon Scale##11830 |q 4503/1 |goto Un'Goro Crater/0 34.80,40.00
|mapmarker Un'Goro Crater/0 24.60,43.80
|mapmarker Un'Goro Crater/0 25.40,39.80
|mapmarker Un'Goro Crater/0 26.20,35.20
|mapmarker Un'Goro Crater/0 27.40,31.40
|mapmarker Un'Goro Crater/0 28.40,38.20
|mapmarker Un'Goro Crater/0 28.40,42.40
|mapmarker Un'Goro Crater/0 29.40,45.60
|mapmarker Un'Goro Crater/0 30.20,28.20
|mapmarker Un'Goro Crater/0 31.00,34.20
|mapmarker Un'Goro Crater/0 31.40,41.80
|mapmarker Un'Goro Crater/0 31.60,37.20
|mapmarker Un'Goro Crater/0 32.00,47.60
|mapmarker Un'Goro Crater/0 33.20,44.40
|mapmarker Un'Goro Crater/0 33.40,28.80
|mapmarker Un'Goro Crater/0 33.80,32.60
|mapmarker Un'Goro Crater/0 34.60,35.80
|mapmarker Un'Goro Crater/0 35.40,46.60
|mapmarker Un'Goro Crater/0 36.80,28.80
|mapmarker Un'Goro Crater/0 37.20,32.00
|mapmarker Un'Goro Crater/0 37.40,42.40
|mapmarker Un'Goro Crater/0 37.40,49.40
|mapmarker Un'Goro Crater/0 37.60,36.20
|mapmarker Un'Goro Crater/0 38.80,39.60
|mapmarker Un'Goro Crater/0 39.20,46.60
|mapmarker Un'Goro Crater/0 40.00,33.80
|mapmarker Un'Goro Crater/0 40.00,51.80
|mapmarker Un'Goro Crater/0 40.60,36.80
|mapmarker Un'Goro Crater/0 40.60,43.60
|mapmarker Un'Goro Crater/0 41.00,30.00
|mapmarker Un'Goro Crater/0 42.20,49.60
|mapmarker Un'Goro Crater/0 42.80,46.40
step
label "Collect_Webbed_Pterrordax_Scales"
kill Fledgling Pterrordax##9165, Pterrordax##9166, Frenzied Pterrordax##9167
|tip Pterodactyls.
collect 8 Webbed Pterrordax Scale##11831 |q 4503/2 |goto Un'Goro Crater/0 34.80,39.60
|mapmarker Un'Goro Crater/0 20.20,38.80
|mapmarker Un'Goro Crater/0 20.40,60.40
|mapmarker Un'Goro Crater/0 20.80,42.40
|mapmarker Un'Goro Crater/0 22.80,50.00
|mapmarker Un'Goro Crater/0 23.40,40.20
|mapmarker Un'Goro Crater/0 22.80,58.40
|mapmarker Un'Goro Crater/0 24.40,61.40
|mapmarker Un'Goro Crater/0 26.20,64.20
|mapmarker Un'Goro Crater/0 26.40,37.20
|mapmarker Un'Goro Crater/0 27.20,45.60
|mapmarker Un'Goro Crater/0 27.60,56.80
|mapmarker Un'Goro Crater/0 28.00,53.20
|mapmarker Un'Goro Crater/0 29.20,42.40
|mapmarker Un'Goro Crater/0 29.40,31.80
|mapmarker Un'Goro Crater/0 29.60,37.40
|mapmarker Un'Goro Crater/0 30.60,45.60
|mapmarker Un'Goro Crater/0 32.00,26.60
|mapmarker Un'Goro Crater/0 32.40,42.00
|mapmarker Un'Goro Crater/0 32.80,37.00
|mapmarker Un'Goro Crater/0 34.20,45.80
|mapmarker Un'Goro Crater/0 34.40,29.60
|mapmarker Un'Goro Crater/0 24.40,43.60
|mapmarker Un'Goro Crater/0 35.80,35.40
|mapmarker Un'Goro Crater/0 36.20,32.00
|mapmarker Un'Goro Crater/0 36.40,42.60
|mapmarker Un'Goro Crater/0 37.80,39.20
|mapmarker Un'Goro Crater/0 38.40,28.40
|mapmarker Un'Goro Crater/0 38.80,45.20
|mapmarker Un'Goro Crater/0 38.80,49.80
|mapmarker Un'Goro Crater/0 39.40,42.00
|mapmarker Un'Goro Crater/0 40.20,31.40
|mapmarker Un'Goro Crater/0 41.20,52.40
|mapmarker Un'Goro Crater/0 41.40,39.20
|mapmarker Un'Goro Crater/0 42.60,36.40
step
label "Kill_Frenzied_Pterrordax"
kill 15 Frenzied Pterrordax##9167 |q 4501/2 |goto Un'Goro Crater/0 34.80,39.60
|mapmarker Un'Goro Crater/0 20.20,38.80
|mapmarker Un'Goro Crater/0 20.40,60.40
|mapmarker Un'Goro Crater/0 20.80,42.40
|mapmarker Un'Goro Crater/0 22.80,50.00
|mapmarker Un'Goro Crater/0 23.40,40.20
|mapmarker Un'Goro Crater/0 22.80,58.40
|mapmarker Un'Goro Crater/0 24.40,61.40
|mapmarker Un'Goro Crater/0 26.20,64.20
|mapmarker Un'Goro Crater/0 26.40,37.20
|mapmarker Un'Goro Crater/0 27.20,45.60
|mapmarker Un'Goro Crater/0 27.60,56.80
|mapmarker Un'Goro Crater/0 28.00,53.20
|mapmarker Un'Goro Crater/0 29.20,42.40
|mapmarker Un'Goro Crater/0 29.40,31.80
|mapmarker Un'Goro Crater/0 29.60,37.40
|mapmarker Un'Goro Crater/0 30.60,45.60
|mapmarker Un'Goro Crater/0 32.00,26.60
|mapmarker Un'Goro Crater/0 32.40,42.00
|mapmarker Un'Goro Crater/0 32.80,37.00
|mapmarker Un'Goro Crater/0 34.20,45.80
|mapmarker Un'Goro Crater/0 34.40,29.60
|mapmarker Un'Goro Crater/0 24.40,43.60
|mapmarker Un'Goro Crater/0 35.80,35.40
|mapmarker Un'Goro Crater/0 36.20,32.00
|mapmarker Un'Goro Crater/0 36.40,42.60
|mapmarker Un'Goro Crater/0 37.80,39.20
|mapmarker Un'Goro Crater/0 38.40,28.40
|mapmarker Un'Goro Crater/0 38.80,45.20
|mapmarker Un'Goro Crater/0 38.80,49.80
|mapmarker Un'Goro Crater/0 39.40,42.00
|mapmarker Un'Goro Crater/0 40.20,31.40
|mapmarker Un'Goro Crater/0 41.20,52.40
|mapmarker Un'Goro Crater/0 41.40,39.20
|mapmarker Un'Goro Crater/0 42.60,36.40
step
label "Collect_UnGoro_Soil"
click Un'Goro Dirt Pile+
Kill enemies
collect 25 Un'Goro Soil##11018 |goto Un'Goro Crater/0 34.80,40.00 |multiq 3761,4496 |future
|tip Don't vendor them.
|mapmarker Un'Goro Crater/0 24.60,43.80
|mapmarker Un'Goro Crater/0 25.40,39.80
|mapmarker Un'Goro Crater/0 26.20,35.20
|mapmarker Un'Goro Crater/0 27.40,31.40
|mapmarker Un'Goro Crater/0 28.40,38.20
|mapmarker Un'Goro Crater/0 28.40,42.40
|mapmarker Un'Goro Crater/0 29.40,45.60
|mapmarker Un'Goro Crater/0 30.20,28.20
|mapmarker Un'Goro Crater/0 31.00,34.20
|mapmarker Un'Goro Crater/0 31.40,41.80
|mapmarker Un'Goro Crater/0 31.60,37.20
|mapmarker Un'Goro Crater/0 32.00,47.60
|mapmarker Un'Goro Crater/0 33.20,44.40
|mapmarker Un'Goro Crater/0 33.40,28.80
|mapmarker Un'Goro Crater/0 33.80,32.60
|mapmarker Un'Goro Crater/0 34.60,35.80
|mapmarker Un'Goro Crater/0 35.40,46.60
|mapmarker Un'Goro Crater/0 36.80,28.80
|mapmarker Un'Goro Crater/0 37.20,32.00
|mapmarker Un'Goro Crater/0 37.40,42.40
|mapmarker Un'Goro Crater/0 37.40,49.40
|mapmarker Un'Goro Crater/0 37.60,36.20
|mapmarker Un'Goro Crater/0 38.80,39.60
|mapmarker Un'Goro Crater/0 39.20,46.60
|mapmarker Un'Goro Crater/0 40.00,33.80
|mapmarker Un'Goro Crater/0 40.00,51.80
|mapmarker Un'Goro Crater/0 40.60,36.80
|mapmarker Un'Goro Crater/0 40.60,43.60
|mapmarker Un'Goro Crater/0 41.00,30.00
|mapmarker Un'Goro Crater/0 42.20,49.60
|mapmarker Un'Goro Crater/0 42.80,46.40
step
label "Collect_UnGoro_Ash"
Follow the path up |goto Un'Goro Crater/0 46.30,45.65 < 20 |only if walking
kill Scorching Elemental##6520, Living Blaze##6521, Blazing Invader##14460
|tip Fire elementals.
|tip Avoid the {o}elite enemy{} at the top of the mountain.
collect 9 Un'Goro Ash##11829 |q 4502/1 |goto Un'Goro Crater/0 50.98,47.18
|mapmarker Un'Goro Crater/0 46.60,53.60
|mapmarker Un'Goro Crater/0 47.40,50.60
|mapmarker Un'Goro Crater/0 49.40,46.20
|mapmarker Un'Goro Crater/0 49.80,53.20
|mapmarker Un'Goro Crater/0 50.80,49.20
|mapmarker Un'Goro Crater/0 52.40,42.40
|mapmarker Un'Goro Crater/0 52.40,45.60
|mapmarker Un'Goro Crater/0 53.40,50.80
|mapmarker Un'Goro Crater/0 53.80,54.40
|mapmarker Un'Goro Crater/0 55.40,57.40
step
talk Ringo##9999
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Inside the small cave.
|tip Midway up the mountain.
turnin Lost!##4492 |goto Un'Goro Crater/0 51.90,49.85
accept A Little Help From My Friends##4491 |goto Un'Goro Crater/0 51.90,49.85 |noautoaccept inparty
step
Watch the dialogue
|tip Protect Ringo as he follows you.
|tip Stay close, he faints.
|tip Message in chat when he faints.
use Spraggle's Canteen##11804
|tip Near Ringo when he faints.
Escort Ringo to Spraggle Frock at Marshal's Refuge |q 4491/1 |goto Un'Goro Crater/0 43.62,8.51 |notravel	|only if zone("Un'Goro Crater")
Escort Ringo to Spraggle Frock at Marshal's Refuge |q 4491/1 |goto Un'Goro Crater/0 43.62,8.51			|only if not zone("Un'Goro Crater")
|tip {o}HURRY{}, timed quest.
step
Watch the dialogue
talk Spraggle Frock##9997
turnin A Little Help From My Friends##4491 |goto Un'Goro Crater/0 43.62,8.51
turnin Beware of Pterrordax##4501 |goto Un'Goro Crater/0 43.62,8.50
step
_Destroy This Item:_
|tip Not needed.
trash Spraggle's Canteen##11804
step
talk Spark Nilminer##9272
turnin Roll the Bones##3882 |goto Un'Goro Crater/0 43.50,7.43
step
Enter the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
turnin The Western Pylon##4288 |goto Un'Goro Crater/0 41.92,2.70
accept The Northern Pylon##4285 |goto Un'Goro Crater/0 41.92,2.70
accept The Eastern Pylon##4287 |goto Un'Goro Crater/0 41.92,2.70
step
Leave the cave |goto Un'Goro Crater/0 43.47,6.79 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
talk Hol'anyee Marshal##9271
turnin Alien Ecology##3883 |goto Un'Goro Crater/0 43.89,7.24
step
talk Williden Marshal##9270
turnin Expedition Salvation##3881 |goto Un'Goro Crater/0 43.95,7.14
step
talk Larion##9118
turnin Larion and Muigin##4145 |goto Un'Goro Crater/0 45.54,8.72
accept Marvon's Workshop##4147 |goto Un'Goro Crater/0 45.54,8.72
step
talk Shizzle##9998
turnin Shizzle's Flyer##4503 |goto Un'Goro Crater/0 44.23,11.59
step
talk Karna Remtravel##9618
accept Chasing A-Me 01##4243 |goto Un'Goro Crater/0 46.38,13.45
step
click Northern Crystal Pylon
|tip Up on the cliff.
Select _"I want to examine this pylon."_ |gossip 98545
Discover and Examine the Northern Crystal Pylon |q 4285/1 |goto Un'Goro Crater/0 56.48,12.45
step
Enter the cave |goto Un'Goro Crater/0 63.88,16.44 < 15 |walk |only if not (subzone("Fungal Rock") and indoors())
Follow the path up |goto Un'Goro Crater/0 69.07,17.62 < 10 |walk
kill U'cha##9622
|tip Walks around.
|tip Upstairs inside the cave.
collect U'cha's Pelt##11476 |q 4301/1 |goto Un'Goro Crater/0 68.15,12.58
step
Follow the path inside the cave |goto Un'Goro Crater/0 65.87,16.75 < 10 |walk
talk A-Me 01##9623
|tip Escort quest.
|tip Wait until she respawns, if missing.
|tip Inside the cave.
turnin Chasing A-Me 01##4243 |goto Un'Goro Crater/0 67.65,16.76
accept Chasing A-Me 01##4244 |goto Un'Goro Crater/0 67.65,16.76 |only if (itemcount(10561) > 0) or (haveq(4244) or completedq(4244))
step
talk A-Me 01##9623
|tip Escort quest.
|tip Wait until she respawns, if missing.
|tip Inside the cave.
turnin Chasing A-Me 01##4244 |goto Un'Goro Crater/0 67.65,16.76
accept Chasing A-Me 01##4245 |goto Un'Goro Crater/0 67.65,16.76 |noautoaccept inparty
|only if haveq(4244) or completedq(4244)
step
Watch the dialogue
|tip Follow and protect A-Me 01.
Protect A-Me 01 Until You Reach Karna Remtravel |q 4245/1 |goto Un'Goro Crater/0 46.32,13.68
|only if haveq(4245) or completedq(4245)
step
talk Karna Remtravel##9618
turnin Chasing A-Me 01##4245 |goto Un'Goro Crater/0 46.38,13.45
|only if haveq(4245) or completedq(4245)
step
Leave the cave |goto Un'Goro Crater/0 64.23,16.36 < 15 |walk |only if subzone("Fungal Rock") and indoors()
click Eastern Crystal Pylon
|tip Up on the cliff.
Select _"I want to examine this pylon."_ |gossip 96122
Discover and Examine the Eastern Crystal Pylon |q 4287/1 |goto Un'Goro Crater/0 77.24,49.97
step
talk Torwa Pathfinder##9619
turnin The Mighty U'cha##4301 |goto Un'Goro Crater 71.63,75.96
step
Enter the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
turnin The Northern Pylon##4285 |goto Un'Goro Crater/0 41.92,2.70
turnin The Eastern Pylon##4287 |goto Un'Goro Crater/0 41.92,2.70
accept Making Sense of It##4321 |goto Un'Goro Crater/0 41.92,2.70
step
talk J.D. Collie##9117
|tip Inside the cave.
turnin Making Sense of It##4321 |goto Un'Goro Crater/0 41.92,2.70
|delay 0.2
step
_Destroy This Item:_
|tip Not needed.
trash Crystal Pylon User's Manual##11482
step
Leave the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Bungle in the Jungle##4496 |goto Tanaris/0 50.89,26.96
step
talk Talo Thornhoof##7776
|tip Inside the building.
turnin The Strength of Corruption##4120 |goto Feralas 76.18,43.83
step
Discover Dire Maul |goto Feralas 59.12,44.62 < 20 |c |q 5527 |future
|tip Run onto the huge ramp.
|tip Careful, {o}elite enemies{}.
|tip Run away after.
|tip Needed for quest later.
step
Jump onto this break in the wall from the nearby ledge |goto Feralas 44.62,9.81 < 3 |only if walking
click Evoroot##164798
|tip Inside the building.
collect Evoroot##11242 |goto Feralas 44.55,10.13 |q 3909
step
talk Gregan Brewspewer##7775
|tip Complete {o}The Videre Elixir{} quest.
collect Videre Elixir##11243 |q 3909/1 |goto Feralas 45.12,25.57
|tip {o}DO NOT DRINK IT{}.
|tip Kills you.
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 3762 |future
|only if Druid
step
talk Archmage Shymm##3047
|tip Inside the cave.
Train Abilities |trainer Archmage Shymm##3047 |goto Thunder Bluff/0 22.76,14.52 |q 3762 |future
|only if Mage
step
talk Chesmu##8356
|tip Collect from the bank.
|tip Inside the building.
collect Jes'rimon's Note##10680		|goto Thunder Bluff 47.13,57.89 |q 3563
collect Tablet of Beth'Amara##10538	|goto Thunder Bluff 47.13,57.89 |q 3518
step
talk Innkeeper Pala##6746
|tip Inside the building.
accept Assisting Arch Druid Runetotem##3762 |goto Thunder Bluff/0 45.82,64.72
stickystart "Accept_A_Call_To_Arms_Plaguelands_And_The_New_Frontier"
step
Enter the cave |goto Thunder Bluff 29.81,29.82 < 15 |walk |only if not subzone("The Pools of Vision")
talk Malakai Cross##3045
|tip Inside the cave.
Train Abilities |trainer Malakai Cross##3045 |goto Thunder Bluff/0 24.55,22.58 |q 3762 |future
|only if Priest
step
talk Siln Skychaser##3030
|tip Inside the building.
Train Abilities |trainer Siln Skychaser##3030 |goto Thunder Bluff/0 22.83,21.10 |q 3762 |future
|only if Shaman
step
talk Hesuwa Thunderhorn##10086
|tip Inside the building.
Train Pet Abilities |trainer Hesuwa Thunderhorn##10086 |goto Thunder Bluff/0 54.09,83.97 |q 3762 |future
|only if Hunter
step
talk Urek Thunderhorn##3040
|tip Inside the building.
Train Abilities |trainer Urek Thunderhorn##3040 |goto Thunder Bluff/0 59.11,86.86 |q 3762 |future
|only if Hunter
step
talk Ker Ragetotem##3043
|tip Inside the building.
Train Abilities |trainer Ker Ragetotem##3043 |goto Thunder Bluff/0 57.58,85.52 |q 3762 |future
|only if Warrior
step
label "Accept_A_Call_To_Arms_Plaguelands_And_The_New_Frontier"
map Thunder Bluff
path follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	42.59,59.42	39.25,63.11	37.23,59.78	36.31,54.06	37.87,51.02
path	42.85,56.51	44.30,68.39	46.19,69.23	49.04,66.75	49.85,61.95
path	56.77,61.65	56.26,54.51	58.95,52.31	57.74,48.48	54.32,48.53
path	52.58,51.30	55.21,54.51
talk Bluff Runner Windstrider##10881
|tip Walks a large path.
accept The New Frontier##1000
step
talk Magatha Grimtotem##4046
|tip Inside the building.
turnin Delivery to Magatha##3518 |goto Thunder Bluff/0 69.84,30.90
accept Magatha's Payment to Jediga##3562 |goto Thunder Bluff/0 69.84,30.90
step
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
turnin Assisting Arch Druid Runetotem##3762 |goto Thunder Bluff/0 78.59,28.57
accept Un'Goro Soil##3761 |goto Thunder Bluff/0 78.59,28.57
turnin The New Frontier##1000 |goto Thunder Bluff/0 78.59,28.57
accept Rabine Saturna##1123 |goto Thunder Bluff/0 78.59,28.57
step
talk Ghede##9076
turnin Un'Goro Soil##3761 |goto Thunder Bluff/0 77.45,21.98
step
_Destroy or Sell These Items:_
|tip Not needed.
trash Un'Goro Soil##11018
step
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
accept Morrowgrain Research##3782 |goto Thunder Bluff/0 78.59,28.57
step
talk Bashana Runetotem##9087
|tip Inside the building.
turnin Morrowgrain Research##3782 |goto Thunder Bluff/0 71.06,34.18
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Liv Rizzlefix##8496
|tip Inside the building.
turnin Marvon's Workshop##4147 |goto The Barrens 62.45,38.73
turnin Volcanic Activity##4502 |goto The Barrens 62.45,38.73
step
talk Islen Waterseer##5901
turnin Seeking Spiritual Aid##5158 |goto The Barrens 65.83,43.78
step
Watch the dialogue
talk Islen Waterseer##5901
accept Cleansed Water Returns to Felwood##5159 |goto The Barrens 65.83,43.78
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3563
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3563
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3563
|only if Warlock
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Azshara (54-54)",{
image=ZGV.IMAGESDIR.."Azshara",
hardcore = true,
next="Leveling Guides\\Felwood & Winterspring (54-56)",
},[[
step
talk Ag'tor Bloodfist##8576
accept Betrayed##3505 |goto Azshara 22.26,51.48
step
talk Jediga##8587
turnin Magatha's Payment to Jediga##3562 |goto Azshara 22.56,51.42
turnin Jes'rimon's Payment to Jediga##3563 |goto Azshara 22.56,51.42
accept Delivery to Andron Gant##3542 |goto Azshara 22.56,51.42
step
talk Kim'jael##8420
|tip Top of the hill.
accept Kim'jael Indeed!##3601 |goto Azshara 53.45,21.82
stickystart "Collect_Kimjaels_Items"
step
kill 10 Blood Elf Reclaimer##6199 |q 3505/1 |goto Azshara/0 55.20,27.40
kill 10 Blood Elf Surveyor##6198 |q 3505/2 |goto Azshara/0 55.20,27.40
|mapmarker Azshara/0 55.40,25.40
|mapmarker Azshara/0 55.40,29.60
|mapmarker Azshara/0 57.40,26.20
|mapmarker Azshara/0 57.80,30.20
|mapmarker Azshara/0 58.00,28.20
step
Find Magus Rimtori's Camp |q 3505/3 |goto Azshara 59.51,31.30
step
click Kaldorei Tome of Summoning##151286
turnin Betrayed##3505 |goto Azshara 59.51,31.30
accept Betrayed##3506 |goto Azshara 59.51,31.30
step
click Arcane Focusing Crystal+
|tip You will be attacked.
|tip May have to click multiple crystals.
kill Blood Elf Defender##8581
|tip Calls for Magus Rimtori when low health.
kill Magus Rimtori##8578
collect Head of Magus Rimtori##10597 |q 3506/1 |goto Azshara 59.55,31.52
step
label "Collect_Kimjaels_Items"
click Kim'jael's Equipment##153123+
|tip Wooden boxes.
|tip Some may be empty.
|tip Respawn quickly.
|tip Careful, enemies can be {o}VERY dangerous{}. |only if hardcore()
collect Kim'Jael's Compass##10717 |q 3601/1 |goto Azshara 56.10,30.10
collect Kim'Jael's Scope##10715 |q 3601/2 |goto Azshara 56.10,30.10
collect Kim'Jael's Stuffed Chicken##10722 |q 3601/3 |goto Azshara 56.10,30.10
collect Kim'Jael's Wizzlegoober##10718 |q 3601/4 |goto Azshara 56.10,30.10
|mapmarker Azshara/0 57.90,29.10
|mapmarker Azshara/0 56.30,28.80
|mapmarker Azshara/0 58.40,25.00
|mapmarker Azshara/0 58.90,28.40
|mapmarker Azshara/0 59.20,32.00
step
talk Kim'jael##8420
|tip Top of the hill.
turnin Kim'jael Indeed!##3601 |goto Azshara 53.45,21.82
accept Kim'jael's "Missing" Equipment##5534 |goto Azshara 53.45,21.82
step
kill Spitelash Siren##6195, Spitelash Myrmidon##6196
|tip Sirens and Myrmidons.
|tip Nagas.
collect Some Rune##13815 |q 5534/1 |goto Azshara/0 48.00,42.20
|mapmarker Azshara/0 43.00,45.40
|mapmarker Azshara/0 43.40,50.80
|mapmarker Azshara/0 43.60,56.80
|mapmarker Azshara/0 44.20,59.80
|mapmarker Azshara/0 45.40,54.00
|mapmarker Azshara/0 45.40,48.00
|mapmarker Azshara/0 46.00,63.00
|mapmarker Azshara/0 46.20,45.00
|mapmarker Azshara/0 47.20,50.80
|mapmarker Azshara/0 47.40,57.00
|mapmarker Azshara/0 45.00,41.40
|mapmarker Azshara/0 48.20,65.60
|mapmarker Azshara/0 49.20,60.00
|mapmarker Azshara/0 49.40,53.80
step
Follow the path up |goto Azshara 45.95,38.62 < 30 |only if walking and subzone("The Shattered Strand")
talk Kim'jael##8420
|tip Top of the hill.
turnin Kim'jael's "Missing" Equipment##5534 |goto Azshara 53.45,21.82
step
talk Ag'tor Bloodfist##8576
turnin Betrayed##3506 |goto Azshara 22.26,51.48
accept Betrayed##3507 |goto Azshara 22.26,51.48
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Felwood & Winterspring (54-56)",{
image=ZGV.IMAGESDIR.."Felwood",
hardcore = true,
next="Leveling Guides\\Western & Eastern Plaguelands (56-58)",
},[[
step
talk Winna Hazzard##9996
accept Corrupted Sabers##4506 |goto Felwood 34.21,52.34
step
talk Greta Mosshoof##10922
|tip Walks around.
turnin Cleansed Water Returns to Felwood##5159 |goto Felwood 51.21,82.11
accept Dousing the Flames of Protection##5165 |goto Felwood 51.21,82.11
step
kill Deadwood Warrior##7153, Deadwood Pathfinder##7155, Deadwood Gardener##7154
collect Deadwood Headdress Feather##21377+ |n
|tip Don't vendor them.
|tip Can be turned in later for {o}xp and reputation{}.
collect 6 Corrupted Soul Shard##11515 |goto Felwood 48.40,89.20 |q 5887 |future
|mapmarker Felwood/0 46.20,89.20
|mapmarker Felwood/0 46.80,91.80
|mapmarker Felwood/0 48.00,93.40
|mapmarker Felwood/0 49.40,91.60
step
talk Maybess Riverbreeze##9529
|tip Walks around.
accept Salve via Hunting##5887 |goto Felwood 46.72,83.07 |instant
step
_Destroy These Items:_
|tip Not needed.
trash Cenarion Plant Salve##11516
trash Cenarion Beacon##11511
trash Corrupted Soul Shard##11515
stickystart "Accept_A_Strange_Red_Key"
step
Enter Jaedenar |goto Felwood 38.40,59.74 < 40 |only if walking and not subzone("Shadow Hold")
Enter the cave |goto Felwood 35.41,58.69 < 10 |walk |only if not subzone("Shadow Hold")
click Brazier of Pain
|tip {o}Top level{} inside the cave.
Extinguish the Brazier of Pain |q 5165/1 |goto Felwood 36.27,56.29
step
click Brazier of Hatred
|tip {o}Top level{} inside the cave.
Extinguish the Brazier of Hatred |q 5165/4 |goto Felwood 36.48,55.18
step
Run around the hole in the floor and follow the path down |goto Felwood 38.25,54.06 < 10 |c |q 5165
step
click Brazier of Suffering
|tip {o}Bottom level{} inside the cave.
Extinguish the Brazier of Suffering |q 5165/3 |goto Felwood 36.73,53.26
step
click Brazier of Malice
|tip {o}Bottom level{} inside the cave.
Extinguish the Brazier of Malice |q 5165/2 |goto Felwood 37.68,52.69
step
label "Accept_A_Strange_Red_Key"
kill Jaedenar Darkweaver##7118, Jaedenar Warlock##7120, Jaedenar Enforcer##7114, Jaedenar Legionnaire##9862
|tip {o}Both levels{} inside the cave.
collect Blood Red Key##13140 |n
use Blood Red Key##13140
accept A Strange Red Key##5202 |goto Felwood 36.21,55.50
|mapmarker Felwood/0 35.40,57.40
|mapmarker Felwood/0 37.40,52.80
|mapmarker Felwood/0 37.80,45.40
|mapmarker Felwood/0 38.60,50.40
|mapmarker Felwood/0 40.00,48.00
step
talk Captured Arko'narin##11016
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Inside a yellow wooden cage.
|tip {o}Top level{} inside the cave.
turnin A Strange Red Key##5202 |goto Felwood 36.21,55.50
step
Follow the path up and leave the cave |complete not subzone("Shadow Hold") |goto Felwood 35.42,58.81 |q 5165
step
Run around the mountain and follow the path |goto Felwood 36.64,66.86 < 40 |only if walking
use Winna's Kitten Carrier##12565
|tip Summons a green Corrupted Saber cat.
|tip Wait until it starts following you.
|tip Careful, stealthed enemies.
Click Here to Continue |confirm |goto Felwood 32.41,66.58 |q 4506
step
Follow the river west |goto Felwood 37.54,49.25 < 40 |only if walking and not subzone("Bloodvenom Post ")
talk Common Kitten##9937
|tip Green cat next to you.
|tip Next to Winna Hazzard.
Select _"I want to release the corrupted saber to Winna."_ |gossip 96209
Return the Corrupted Cat to Winna Hazzard |q 4506/1 |goto Felwood 34.21,52.34
step
talk Winna Hazzard##9996
turnin Corrupted Sabers##4506 |goto Felwood 34.21,52.34
step
talk Trull Failbane##10306
accept Wild Guardians##4521 |goto Felwood/0 34.73,52.79
step
_NOTE:_
During the Next Steps
|tip Kill enemies as you walk.
|tip Reduces grinding later.
Click Here to Continue |confirm |q 8461 |future
step
talk Nafien##15395
|tip Follow the road.
accept Deadwood of the North##8461 |goto Felwood 64.77,8.13
step
kill 6 Deadwood Den Watcher##7156 |q 8461/1 |goto Felwood 63.60,9.60
kill 6 Deadwood Avenger##7157 |q 8461/2 |goto Felwood 63.60,9.60
kill 6 Deadwood Shaman##7158 |q 8461/3 |goto Felwood 63.60,9.60
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
step
Kill enemies
ding 55 |goto Felwood 63.60,9.60
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
step
click Deadwood Cauldron##176091
|tip Run away, if needed.
turnin Falling to Corruption##5084 |goto Felwood 60.20,5.87
accept Mystery Goo##5085 |goto Felwood 60.20,5.87
step
talk Nafien##15395
|tip Follow the road.
turnin Deadwood of the North##8461 |goto Felwood 64.77,8.13
accept Speak to Salfa##8465 |goto Felwood 64.77,8.13
step
label "ClearQuest_Feathers_For_Nafien"
|execute clearquest(8467)
|only if itemcount(21377) >= 5
step
talk Nafien##15395
accept Feathers for Nafien##8467 |goto Felwood 64.77,8.13 |instant
|only if itemcount(21377) >= 5
step
|next "ClearQuest_Feathers_For_Nafien"
|only if itemcount(21377) >= 5
step
talk Salfa##11556
turnin Speak to Salfa##8465 |goto Winterspring 27.74,34.50
step
talk Donova Snowden##9298
turnin The New Springs##980 |goto Winterspring/0 31.27,45.16
accept Strange Sources##4842 |goto Winterspring/0 31.27,45.16
turnin The Videre Elixir##3909 |goto Winterspring/0 31.27,45.16
accept Meet at the Grave##3912 |goto Winterspring/0 31.27,45.16
turnin Mystery Goo##5085 |goto Winterspring 31.27,45.16
accept Toxic Horrors##5086 |goto Winterspring 31.27,45.16
step
kill 15 Ragged Owlbeast##7450 |q 4521/2 |goto Winterspring/0 29.00,44.40
|mapmarker Winterspring/0 28.40,48.40
|mapmarker Winterspring/0 54.40,37.40
|mapmarker Winterspring/0 31.60,39.40
|mapmarker Winterspring/0 34.40,43.40
|mapmarker Winterspring/0 38.40,37.80
|mapmarker Winterspring/0 40.60,35.60
|mapmarker Winterspring/0 41.80,38.40
|mapmarker Winterspring/0 43.80,34.40
|mapmarker Winterspring/0 44.80,37.80
|mapmarker Winterspring/0 45.40,42.40
|mapmarker Winterspring/0 47.80,46.00
|mapmarker Winterspring/0 49.40,35.40
|mapmarker Winterspring/0 51.40,39.00
step
talk Umi Rumplesnicker##10305
accept Are We There, Yeti?##3783 |goto Winterspring 60.88,37.62
step
talk Izzy Coppergrab##13917
|tip Deposit into the bank.
|tip Inside the building.
bank Tablet of Markri##10540		|goto Winterspring/0 61.45,36.98 |q 3542
bank Videre Elixir##11243		|goto Winterspring/0 61.45,36.98 |q 3912
bank Linken's Tempered Sword##11136	|goto Winterspring/0 61.45,36.98 |q 3912
bank Head of Magus Rimtori##10597	|goto Winterspring/0 61.45,36.98 |q 3507
stickystart "Collect_Thick_Yeti_Fur"
step
kill 15 Raging Owlbeast##7451 |q 4521/1 |goto Winterspring/0 59.40,31.40
|mapmarker Winterspring/0 51.40,33.40
|mapmarker Winterspring/0 55.40,28.20
|mapmarker Winterspring/0 57.80,34.40
|mapmarker Winterspring/0 58.80,27.40
|mapmarker Winterspring/0 62.60,31.80
step
label "Collect_Thick_Yeti_Fur"
kill Ice Thistle Yeti##7458, Ice Thistle Matriarch##7459, Ice Thistle Patriarch##7460
|tip Yetis.
|tip Inside and outside the cave. |notinsticky
collect 10 Thick Yeti Fur##12366 |q 3783/1 |goto Winterspring 67.65,41.75
|mapmarker Winterspring/0 64.20,39.80
|mapmarker Winterspring/0 64.40,41.80
|mapmarker Winterspring/0 65.80,44.80
|mapmarker Winterspring/0 69.20,40.00
|mapmarker Winterspring/0 71.40,40.40
step
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##3783 |goto Winterspring 60.88,37.62
step
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto Winterspring/0 61.63,38.61
|only if readyq(4809)
step
talk Innkeeper Vizzie##11118
|tip Inside the building.
home Everlook |goto Winterspring 61.36,38.83 |q 3507 |future
step
talk Trull Failbane##10306
turnin Wild Guardians##4521 |goto Felwood/0 34.73,52.79
accept Wild Guardians##4741 |goto Felwood/0 34.73,52.79
step
_NOTE:_
During the Next Steps
|tip Drink the elixir in the Gadgetzan graveyard.
|tip It will kill you, that's normal.
|tip After dying, {o}release spirit{} but {o}don't resurrect{}.
|tip Need to stay dead to complete quest.
Click Here to Continue |confirm |q 3912
|only if not hardcore()
step
use Videre Elixir##11243
|tip In this {o}exact location{}.
|tip You will die.				|only if not hardcore()
|tip Careful, clear nearby enemies first.	|only if hardcore()
|tip Reduces your health to {o}very low{}.	|only if hardcore()
Drink the Videre Elixir |complete isdead |goto Tanaris 54.03,28.73 |q 3912
step
talk Gaeriyan##9299
|tip Human ghost.
|tip Walks around.
turnin Meet at the Grave##3912 |goto Tanaris/0 53.98,23.39 |zombiewalk	|only if not hardcore()
accept A Grave Situation##3913 |goto Tanaris/0 53.98,23.39 |zombiewalk	|only if not hardcore()
turnin Meet at the Grave##3912 |goto Tanaris/0 53.98,23.39		|only if hardcore()
accept A Grave Situation##3913 |goto Tanaris/0 53.98,23.39		|only if hardcore()
step
Resurrect At the Graveyard |complete not isdead |goto Tanaris 54.03,28.73 |q 3913
|tip Return to your corpse.
|only if not hardcore()
step
click A Conspicuous Gravestone
turnin A Grave Situation##3913 |goto Tanaris 53.82,29.06
accept Linken's Sword##3914 |goto Tanaris 53.82,29.06
step
_Destroy This Item:_
|tip Not needed.
trash Videre Elixir##11243
step
talk Tran'rek##7876
accept Super Sticky##4504 |goto Tanaris 51.57,26.76
step
talk Linken##8737
turnin Linken's Sword##3914 |goto Un'Goro Crater 44.66,8.10
accept A Gnome's Assistance##3941 |goto Un'Goro Crater 44.66,8.10
step
Enter the cave |goto Un'Goro Crater/0 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
turnin A Gnome's Assistance##3941 |goto Un'Goro Crater 41.92,2.70
step
Watch the dialogue
|tip Inside the cave.
talk J.D. Collie##9117
accept Linken's Memory##3942 |goto Un'Goro Crater 41.92,2.70
step
Leave the cave |goto Un'Goro Crater/0 43.47,6.79 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
kill Tar Beast##6517, Tar Creeper##6527, Tar Lord##6519, Tar Lurker##6518
|tip Swamp elementals.
collect 12 Super Sticky Tar##11834 |q 4504/1 |goto Un'Goro Crater 45.40,15.40
|mapmarker Un'Goro Crater/0 46.40,32.40
|mapmarker Un'Goro Crater/0 46.40,35.40
|mapmarker Un'Goro Crater/0 49.20,34.20
|mapmarker Un'Goro Crater/0 58.20,30.20
|mapmarker Un'Goro Crater/0 60.00,33.20
|mapmarker Un'Goro Crater/0 61.40,30.40
|mapmarker Un'Goro Crater/0 65.00,24.00
|mapmarker Un'Goro Crater/0 41.80,20.60
|mapmarker Un'Goro Crater/0 42.40,16.20
|mapmarker Un'Goro Crater/0 44.60,19.40
|mapmarker Un'Goro Crater/0 60.00,22.40
|mapmarker Un'Goro Crater/0 47.40,22.20
|mapmarker Un'Goro Crater/0 48.40,18.20
|mapmarker Un'Goro Crater/0 49.40,25.20
|mapmarker Un'Goro Crater/0 49.40,28.80
|mapmarker Un'Goro Crater/0 50.60,22.40
|mapmarker Un'Goro Crater/0 52.40,26.20
|mapmarker Un'Goro Crater/0 54.20,23.40
step
talk Tran'rek##7876
turnin Super Sticky##4504 |goto Tanaris 51.57,26.76
step
talk Gregor Greystone##10431
|tip Inside the building.
accept The Everlook Report##6029 |goto Winterspring 61.35,38.97
accept Duke Nicholas Zverenhoff##6030 |goto Winterspring 61.35,38.97
step
talk Jessica Redpath##11629
|tip Inside the building.
accept Sister Pamela##5601 |goto Winterspring 61.28,38.98
step
talk Izzy Coppergrab##13917
|tip Deposit into the bank.
|tip Inside the building.
bank Everlook Report##15788		|goto Winterspring 61.45,36.98 |q 6029
bank Studies in Spirit Speaking##15790	|goto Winterspring 61.45,36.98 |q 6030
step
Discover Darkwhisper Gorge |q 4842/1 |goto Winterspring 59.84,74.12
|tip Follow the road.
step
talk Greta Mosshoof##10922
|tip Walks around.
turnin Dousing the Flames of Protection##5165 |goto Felwood 51.21,82.11
step
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Linken's Memory##3942 |goto Felwood 51.35,81.51
accept Silver Heart##4084 |goto Felwood 51.35,81.51
stickystart "Collect_Toxic_Horror_Droplets"
stickystart "Collect_Silvery_Claws"
step
kill Irontree Stomper##7139, Irontree Wanderer##7138
|tip Walking trees with no leaves.
collect Irontree Heart##11173 |q 4084/2 |goto Felwood/0 45.20,23.40
|mapmarker Felwood/0 47.40,25.80
|mapmarker Felwood/0 48.20,28.80
|mapmarker Felwood/0 48.40,19.40
|mapmarker Felwood/0 50.40,24.00
|mapmarker Felwood/0 52.60,20.40
step
label "Collect_Toxic_Horror_Droplets"
kill Toxic Horror##7132+
|tip Green water elementals.
collect 3 Toxic Horror Droplet##12822 |q 5086/1 |goto Felwood/0 47.40,23.40
|mapmarker Felwood/0 49.40,26.40
|mapmarker Felwood/0 50.40,22.00
step
label "Collect_Silvery_Claws"
kill Angerclaw Grizzly##8957, Felpaw Ravager##8961
|tip Bears and wolves.
collect 11 Silvery Claws##11172 |q 4084/1 |goto Felwood/0 52.40,27.20
|mapmarker Felwood/0 52.00,16.00
|mapmarker Felwood/0 50.00,13.20
|mapmarker Felwood/0 53.80,13.40
|mapmarker Felwood/0 54.60,25.00
|mapmarker Felwood/0 55.40,10.40
|mapmarker Felwood/0 55.40,21.20
|mapmarker Felwood/0 56.40,6.40
|mapmarker Felwood/0 57.40,18.40
|mapmarker Felwood/0 58.20,15.20
|mapmarker Felwood/0 60.80,17.00
|mapmarker Felwood/0 63.40,13.40
|mapmarker Felwood/0 64.40,19.80
stickystart "Accept_Deadwood_Ritual_Totem"
step
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
collect Deadwood Headdress Feather##21377+ |n
|tip Turn in {o}stacks of 5{} to Nafien.
|tip Each stack gives {o}50 reputation{}.
Reach {y}Neutral{} Reputation with the Timbermaw Hold Faction |complete rep('Timbermaw Hold') >= Neutral |goto Felwood 63.60,9.60
Turn in Feathers at [64.77,8.13]
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
|only if level < 56.10
step
label "Accept_Deadwood_Ritual_Totem"
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
collect Deadwood Ritual Totem##20741 |n
use Deadwood Ritual Totem##20741
accept Deadwood Ritual Totem##8470 |goto Felwood 63.60,9.60
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
|only if level < 56.10
step
label "ClearQuest_Feathers_For_Nafien_Second_Time"
|execute clearquest(8467)
|only if itemcount(21377) >= 5
step
talk Nafien##15395
accept Feathers for Nafien##8467 |goto Felwood 64.77,8.13 |instant
|only if itemcount(21377) >= 5
step
|next "ClearQuest_Feathers_For_Nafien_Second_Time"
|only if itemcount(21377) >= 5
step
talk Kernda##11558
|tip Walks around.
|tip Inside the tunnel.
turnin Deadwood Ritual Totem##8470	|goto Felwood/0 65.49,3.48 |region timbermawhold
|mapmarker Felwood/0 65.37,2.49 |region timbermawhold
|mapmarker Felwood/0 65.38,1.17 |region timbermawhold
|only if level < 56.10
step
talk Donova Snowden##9298
turnin Strange Sources##4842 |goto Winterspring/0 31.27,45.16
turnin Toxic Horrors##5086 |goto Winterspring/0 31.27,45.16
accept Winterfall Runners##5087 |goto Winterspring/0 31.27,45.16
step
map Winterspring/0
path follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	28.07,35.03	28.02,36.46	28.40,37.43	28.53,39.32	29.30,40.76
path	29.81,42.02	30.34,42.56	31.73,42.41	33.48,42.00	34.25,41.86
path	35.48,42.05	36.06,42.17	38.15,42.00	40.01,40.85	42.10,40.05
path	44.35,39.90	45.75,39.81	47.26,39.40	49.00,38.42	50.45,36.73
path	51.56,36.28	52.56,35.54	53.35,34.46
kill Winterfall Runner##10916+
|tip Group of 3 white furbolgs.
|tip Walking a large path along the road.
collect Winterfall Crate##12829 |q 5087/1
Spawn around [Winterspring/0 28.07,35.03] |noway
step
talk Donova Snowden##9298
turnin Winterfall Runners##5087 |goto Winterspring 31.27,45.16
step
talk Salfa##11556
accept Winterfall Activity##8464 |goto Winterspring 27.74,34.50
step
label "Accept_Deadwood_Ritual_Totem"
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
expcollect Deadwood Headdress Feather##21377,5,550,56
|tip Count will reduce as you grind.
ding 56 |goto Felwood 63.60,9.60
Turn in Feathers at [64.77,8.13]
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
step
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Silver Heart##4084 |goto Felwood 51.35,81.51
accept Aquementas##4005 |goto Felwood 51.35,81.51
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 3507
|only if Druid
step
talk Izzy Coppergrab##13917
|tip Collect from the bank.
|tip Inside the building.
collect Head of Magus Rimtori##10597 |goto Winterspring/0 61.46,36.97 |q 3507
step
talk Izzy Coppergrab##13917
|tip Deposit into the bank.
|tip Inside the building.
bank Eridan's Supplies##11617 |goto Winterspring/0 61.46,36.97 |q 4005
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 3507
|only if Mage
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 3507
|only if Priest
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 3507
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3507
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3507
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3507
|only if Warlock
step
talk Belgrom Rockmaul##4485
turnin Betrayed##3507 |goto Orgrimmar 75.23,34.23
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 3542
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 3542
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Innkeeper Gryshka##6929
|tip Inside the building.
home Orgrimmar |goto Orgrimmar 54.09,68.42 |q 4809 |future
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk William Montague##4549
|tip Collect from the bank.
collect Filled Vial Labeled #1##10691		|goto Undercity 65.97,44.75 |q 3568
collect Filled Vial Labeled #2##10692		|goto Undercity 65.97,44.75 |q 3568
collect Filled Vial Labeled #3##10693		|goto Undercity 65.97,44.75 |q 3568
collect Filled Vial Labeled #4##10694		|goto Undercity 65.97,44.75 |q 3568
collect Tablet of Markri##10540			|goto Undercity 65.97,44.75 |q 3542
collect Everlook Report##15788			|goto Undercity 65.97,44.75 |q 6029
collect Studies in Spirit Speaking##15790	|goto Undercity 65.97,44.75 |q 6030
step
talk Andron Gant##6522
turnin Delivery to Andron Gant##3542 |goto Undercity/0 54.82,76.33
accept Andron's Payment to Jediga##3564 |goto Undercity/0 54.82,76.33
step
Follow the path down |goto Undercity 52.86,77.57 < 10 |walk
talk Chemist Cuely##8390
turnin Seeping Corruption##3568 |goto Undercity 48.71,71.42
step
Watch the dialogue
talk Chemist Cuely##8390
accept Seeping Corruption##3569 |goto Undercity/0 48.69,71.41
step
talk Thersa Windsong##8393
turnin Seeping Corruption##3569 |goto Undercity/0 49.03,70.83
step
talk Chemist Cuely##8390
accept Seeping Corruption##3570 |goto Undercity/0 48.71,71.40 |instant
step
talk William Montague##4549
|tip Collect from the bank.
bank Andron's Note##10679 |goto Undercity 65.97,44.75 |q 3564
step
talk Katoom the Angler##14740
accept Gammerita, Mon!##7816 |goto The Hinterlands 80.33,81.53
stickystart "Collect_Katooms_Best_Lure"
step
click Cortello's Treasure
|tip Bottom of the waterfall.
|tip Underwater.
turnin Cortello's Riddle##626 |goto The Hinterlands 80.81,46.81
step
label "Collect_Katooms_Best_Lure"
kill Gammerita##7977
|tip {o}Level 48 elite{} blue turtle.
|tip Walks around.
collect Katoom's Best Lure##19023 |q 7816/1 |goto The Hinterlands/0 81.40,47.20
|mapmarker The Hinterlands/0 74.20,67.40
|mapmarker The Hinterlands/0 75.20,71.00
|mapmarker The Hinterlands/0 75.40,62.20
|mapmarker The Hinterlands/0 75.40,74.20
|mapmarker The Hinterlands/0 76.80,65.00
|mapmarker The Hinterlands/0 77.20,59.40
|mapmarker The Hinterlands/0 77.40,68.40
|mapmarker The Hinterlands/0 78.60,62.40
|mapmarker The Hinterlands/0 79.40,56.20
|mapmarker The Hinterlands/0 80.20,59.80
|mapmarker The Hinterlands/0 81.40,51.20
|mapmarker The Hinterlands/0 81.60,55.80
step
talk Katoom the Angler##14740
turnin Gammerita, Mon!##7816 |goto The Hinterlands 80.33,81.53
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Western & Eastern Plaguelands (56-58)",{
image=ZGV.IMAGESDIR.."Western Plaguelands",
hardcore=true,
next="Leveling Guides\\Winterspring (58-59)",
},[[
step
talk Harbinger Balthazad##10879
|tip White shirt with lantern.
|tip Walks a large path.
accept A Call to Arms: The Plaguelands!##5094 |goto Undercity 63.40,44.00
|mapmarker Undercity/0 58.20,43.40
|mapmarker Undercity/0 59.40,39.40
|mapmarker Undercity/0 59.40,47.20
|mapmarker Undercity/0 60.40,51.00
|mapmarker Undercity/0 61.20,36.20
|mapmarker Undercity/0 62.80,54.60
|mapmarker Undercity/0 63.00,33.40
|mapmarker Undercity/0 65.40,40.20
|mapmarker Undercity/0 65.40,46.60
|mapmarker Undercity/0 65.80,54.20
|mapmarker Undercity/0 66.00,33.40
|mapmarker Undercity/0 67.40,42.60
|mapmarker Undercity/0 68.60,48.20
|mapmarker Undercity/0 69.00,34.80
|mapmarker Undercity/0 69.00,54.00
|mapmarker Undercity/0 70.40,37.60
|mapmarker Undercity/0 70.40,51.20
|mapmarker Undercity/0 72.20,46.40
|mapmarker Undercity/0 72.40,40.60
step
talk Eleanor Rusk##4555
|tip Long questing session soon.
|tip No ammo vendor available.
Buy Extra Ammo |vendor Eleanor Rusk##4555 |goto Undercity/0 69.16,48.90 |q 5094
|only if Hunter
step
talk High Executor Derrington##10837
turninany A Call to Arms: The Plaguelands!##5093,5094,5095 |goto Tirisfal Glades 83.13,68.93
accept Scarlet Diversions##5096 |goto Tirisfal Glades 83.13,68.93
step
click Box of Incendiaries
collect Flame in a Bottle##12814 |goto Tirisfal Glades 83.17,69.09 |q 5096
step
talk Argent Officer Garush##10839
turnin The Everlook Report##6029 |goto Tirisfal Glades 83.19,68.45
accept Argent Dawn Commission##5405 |goto Tirisfal Glades 83.19,68.45 |instant
step
equip Argent Dawn Commission##12846 |n
|tip Allows {o}Minion's Scourgestones{} to drop.
|tip From undead enemies in Western and Eastern Plaguelands.
Gain the Argent Dawn Commission Buff |havebuff Argent Dawn Commission##17670 |q 5402 |future
step
click Command Tent
use Scourge Banner##12807
Destroy the Command Tent and Plant the Scourge Banner in the Camp |q 5096/1 |goto Western Plaguelands 40.68,51.98
step
talk High Executor Derrington##10837
turnin Scarlet Diversions##5096 |goto Tirisfal Glades 83.13,68.93
accept All Along the Watchtowers##5098 |goto Tirisfal Glades 83.13,68.94
accept The Scourge Cauldrons##5228 |goto Tirisfal Glades 83.13,68.93
step
_Destroy This Item:_
|tip Not needed.
trash Flame in a Bottle##12814
step
talk Shadow Priestess Vandis##11055
turnin The Scourge Cauldrons##5228 |goto Tirisfal Glades 83.03,71.91
accept Target: Felstone Field##5229 |goto Tirisfal Glades 83.03,71.91
step
kill Cauldron Lord Bilemaw##11075
collect Felstone Field Cauldron Key##13194 |q 5229/1 |goto Western Plaguelands 37.03,57.11
step
click Scourge Cauldron
turnin Target: Felstone Field##5229 |goto Western Plaguelands 37.19,56.87
accept Return to the Bulwark##5230 |goto Western Plaguelands 37.19,56.87
step
talk Janice Felstone##10778
|tip Upstairs inside the building.
accept Better Late Than Never##5021 |goto Western Plaguelands 38.40,54.05
step
click Janice's Parcel
|tip Inside the building.
turnin Better Late Than Never##5021 |goto Western Plaguelands 38.73,55.24
accept Better Late Than Never##5023 |goto Western Plaguelands 38.73,55.24
step
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5230 |goto Tirisfal Glades 83.04,71.91
accept Target: Dalson's Tears##5231 |goto Tirisfal Glades 83.04,71.91
step
kill Cauldron Lord Malvinious##11077
collect Dalson's Tears Cauldron Key##13195 |q 5231/1 |goto Western Plaguelands 46.18,52.38
step
click Scourge Cauldron
turnin Target: Dalson's Tears##5231 |goto Western Plaguelands 46.18,52.02
accept Return to the Bulwark##5232 |goto Western Plaguelands 46.18,52.02
step
click Mrs. Dalson's Diary
|tip Inside the building.
accept Mrs. Dalson's Diary##5058 |goto Western Plaguelands 47.79,50.67 |instant
step
kill Wandering Skeleton##10816
|tip White skeleton.
|tip Walks around.
|tip Multiple spawn locations.
collect Dalson Outhouse Key##12738 |goto Western Plaguelands/0 48.34,49.27 |q 5060 |future
|mapmarker Western Plaguelands/0 46.40,50.20
|mapmarker Western Plaguelands/0 46.80,48.40
|mapmarker Western Plaguelands/0 47.20,51.40
|mapmarker Western Plaguelands/0 47.80,52.60
step
click Outhouse
|tip Complete the {o}Locked Away{} quest.
kill Farmer Dalson##10836
collect Dalson Cabinet Key##12739 |goto Western Plaguelands 48.11,49.71 |q 5060 |future
step
click Locked Cabinet
|tip Upstairs inside the building.
accept Locked Away##5060 |goto Western Plaguelands 47.37,49.65 |instant
step
talk Chromie##10667
|tip Upstairs inside the building.
accept A Matter of Time##4971 |goto Western Plaguelands 39.45,66.76
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower One |q 5098/1 |goto Western Plaguelands 40.13,71.52
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower Four |q 5098/4 |goto Western Plaguelands 46.70,71.10
step
use Temporal Displacer##12627
|tip Near large structures with blue lights.
kill 15 Temporal Parasite##10717 |q 4971/1 |goto Western Plaguelands 45.00,63.00
|tip Another can spawn when they die.
|mapmarker Western Plaguelands/0 47.40,66.40
|mapmarker Western Plaguelands/0 48.00,62.80
|mapmarker Western Plaguelands/0 49.20,68.40
|mapmarker Western Plaguelands/0 49.80,66.40
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower Three |q 5098/3 |goto Western Plaguelands/0 44.22,63.37
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower Two |q 5098/2 |goto Western Plaguelands/0 42.44,66.27
step
talk Chromie##10667
|tip Upstairs inside the building.
turnin A Matter of Time##4971 |goto Western Plaguelands 39.45,66.76
accept Counting Out Time##4972 |goto Western Plaguelands 39.45,66.76
step
label "Collect_Andorhal_Watches"
click Small Lockbox+
|tip Small grey metal chests.
|tip Inside crumbled buildings.
collect 5 Andorhal Watch##12638 |q 4972/1 |goto Western Plaguelands/0 42.30,68.80
|mapmarker Western Plaguelands/0 38.30,69.60
|mapmarker Western Plaguelands/0 40.40,66.40
|mapmarker Western Plaguelands/0 42.80,73.90
|mapmarker Western Plaguelands/0 44.80,70.50
|mapmarker Western Plaguelands/0 46.50,73.00
|mapmarker Western Plaguelands/0 46.70,66.40
|mapmarker Western Plaguelands/0 48.70,69.70
step
talk High Executor Derrington##10837
turnin All Along the Watchtowers##5098 |goto Tirisfal Glades 83.13,68.93
accept Scholomance##838 |goto Tirisfal Glades 83.13,68.93
step
_Destroy This Item:_
|tip Not needed.
trash Beacon Torch##12815
step
talk Apothecary Dithers##11057
turnin Scholomance##838 |goto Tirisfal Glades 83.28,69.23
accept Skeletal Fragments##964 |goto Tirisfal Glades 83.28,69.23
step
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5232 |goto Tirisfal Glades 83.04,71.91
accept Target: Writhing Haunt##5233 |goto Tirisfal Glades 83.04,71.91
step
talk Mickey Levine##11615
accept A Plague Upon Thee##5901 |goto Tirisfal Glades 83.29,72.33
step
kill Skeletal Sorcerer##1784, Skeletal Flayer##1783
collect 15 Skeletal Fragments##14619 |q 964/1 |goto Western Plaguelands 36.20,58.60
|mapmarker Western Plaguelands/0 35.40,56.20
|mapmarker Western Plaguelands/0 36.40,54.20
|mapmarker Western Plaguelands/0 38.40,57.40
|mapmarker Western Plaguelands/0 38.60,53.40
step
kill Cauldron Lord Razarch##11076
collect Writhing Haunt Cauldron Key##13197 |q 5233/1 |goto Western Plaguelands 53.02,66.06
step
click Scourge Cauldron
turnin Target: Writhing Haunt##5233 |goto Western Plaguelands 53.02,65.72
accept Return to the Bulwark##5234 |goto Western Plaguelands 53.02,65.72
step
talk Mulgris Deepriver##10739
|tip Inside the building.
accept The Wildlife Suffers Too##4984 |goto Western Plaguelands 53.72,64.67
stickystart "Kill_Diseased_Wolves"
step
talk Kirsta Deepshadow##11610
accept Unfinished Business##6004 |goto Western Plaguelands 51.92,28.06
step
kill 2 Scarlet Mage##1826 |q 6004/3 |goto Western Plaguelands 50.47,41.12
kill 2 Scarlet Knight##1833 |q 6004/4 |goto Western Plaguelands 50.47,41.12
|mapmarker Western Plaguelands/0 50.40,41.20
|mapmarker Western Plaguelands/0 53.40,37.40
|mapmarker Western Plaguelands/0 57.40,35.60
step
kill 2 Scarlet Medic##10605 |q 6004/1 |goto Western Plaguelands 51.60,44.60
kill 2 Scarlet Hunter##1831 |q 6004/2 |goto Western Plaguelands 51.60,44.60
|mapmarker Western Plaguelands/0 40.80,52.00
|mapmarker Western Plaguelands/0 40.80,54.60
step
talk Kirsta Deepshadow##11610
turnin Unfinished Business##6004 |goto Western Plaguelands 51.92,28.06
accept Unfinished Business##6023 |goto Western Plaguelands 51.92,28.06
step
kill Huntsman Radley##11613 |q 6023/1 |goto Western Plaguelands 57.83,36.09
|tip Run around the mountain.
step
kill Cavalier Durgen##11611 |q 6023/2 |goto Western Plaguelands/0 54.71,23.65
|tip Walks around.
|tip Inside and outside the tower.
|tip Wait outside if elite enemy at top of tower. |notinsticky
step
talk Kirsta Deepshadow##11610
turnin Unfinished Business##6023 |goto Western Plaguelands 51.92,28.06
step
label "Kill_Diseased_Wolves"
kill 8 Diseased Wolf##1817 |q 4984/1 |goto Western Plaguelands 46.80,39.40
|tip Shared spawns with spiders. |notinsticky
|mapmarker Western Plaguelands/0 39.40,48.60
|mapmarker Western Plaguelands/0 42.40,47.00
|mapmarker Western Plaguelands/0 42.40,56.40
|mapmarker Western Plaguelands/0 43.40,39.80
|mapmarker Western Plaguelands/0 43.80,50.80
|mapmarker Western Plaguelands/0 44.20,59.60
|mapmarker Western Plaguelands/0 45.20,42.20
|mapmarker Western Plaguelands/0 45.40,47.80
|mapmarker Western Plaguelands/0 50.20,64.20
|mapmarker Western Plaguelands/0 47.60,45.40
|mapmarker Western Plaguelands/0 48.20,61.60
|mapmarker Western Plaguelands/0 49.80,38.80
|mapmarker Western Plaguelands/0 50.40,48.00
|mapmarker Western Plaguelands/0 50.40,52.20
|mapmarker Western Plaguelands/0 51.20,58.00
|mapmarker Western Plaguelands/0 51.60,69.40
step
talk Mulgris Deepriver##10739
|tip Inside the building.
turnin The Wildlife Suffers Too##4984 |goto Western Plaguelands 53.72,64.67
accept The Wildlife Suffers Too##4985 |goto Western Plaguelands 53.72,64.67
stickystart "Kill_Diseased_Grizzlies"
step
talk Tirion Fordring##1855
|tip Walks around.
accept Demon Dogs##5542 |goto Eastern Plaguelands 5.16,35.57
accept Blood Tinged Skies##5543 |goto Eastern Plaguelands 5.16,35.57
accept Carrion Grubbage##5544 |goto Eastern Plaguelands 5.16,35.57
stickystop "Kill_Diseased_Grizzlies"
stickystart "Collect_Slabs_Of_Carrion_Worm_Meat"
stickystart "Kill_Plaguehound_Runts_And_Plaguebats"
step
talk Nathanos Blightcaller##11878
accept To Kill With Purpose##6022 |goto Eastern Plaguelands 22.23,63.52
accept Un-Life's Little Annoyances##6042 |goto Eastern Plaguelands 22.23,63.52
step
talk Pamela Redpath##10926
|tip Walks around.
|tip Inside the crumbled house.
turnin Sister Pamela##5601 |goto Eastern Plaguelands 31.15,77.98
accept Pamela's Doll##5149 |goto Eastern Plaguelands 31.15,77.98
stickystop "Collect_Slabs_Of_Carrion_Worm_Meat"
stickystop "Kill_Plaguehound_Runts_And_Plaguebats"
stickystart "Collect_Pamelas_Dolls_Left_Side"
stickystart "Collect_Pamelas_Dolls_Right_Side"
step
click Pamela's Doll's Head##176116
|tip Inside the buildings.
|tip You will be attacked.
collect Pamela's Doll's Head##12886 |goto Eastern Plaguelands/0 32.63,79.33 |q 5149
|mapmarker Eastern Plaguelands/0 33.98,77.35
|mapmarker Eastern Plaguelands/0 33.98,79.51
step
label "Collect_Pamelas_Dolls_Left_Side"
click Pamela's Doll's Left Side##176142
|tip Inside the buildings. |notinsticky
|tip You will be attacked. |notinsticky
collect Pamela's Doll's Left Side##12887 |goto Eastern Plaguelands/0 32.63,79.33 |q 5149
|mapmarker Eastern Plaguelands/0 33.98,77.35
|mapmarker Eastern Plaguelands/0 33.98,79.51
step
label "Collect_Pamelas_Dolls_Right_Side"
click Pamela's Doll's Right Side##176143
|tip Inside the buildings. |notinsticky
|tip You will be attacked. |notinsticky
collect Pamela's Doll's Right Side##12888 |goto Eastern Plaguelands/0 32.63,79.33 |q 5149
|mapmarker Eastern Plaguelands/0 33.98,77.35
|mapmarker Eastern Plaguelands/0 33.98,79.51
step
use Pamela's Doll's Head##12886
collect Pamela's Doll##12885 |q 5149/1
step
talk Pamela Redpath##10926
|tip Walks around.
|tip Inside the crumbled house.
turnin Pamela's Doll##5149 |goto Eastern Plaguelands 31.15,77.98
accept Auntie Marlene##5152 |goto Eastern Plaguelands 31.15,77.98
accept Uncle Carlin##5241 |goto Eastern Plaguelands 31.15,77.98
stickystart "Kill_Plaguehound_Runts_And_Plaguebats"
step
label "Collect_Slabs_Of_Carrion_Worm_Meat"
kill Carrion Grub##8603+
|tip Large yellow worms.
collect 15 Slab of Carrion Worm Meat##13853 |q 5544/1 |goto Eastern Plaguelands/0 34.52,71.50
|mapmarker Eastern Plaguelands/0 13.11,54.21
|mapmarker Eastern Plaguelands/0 13.47,63.75
|mapmarker Eastern Plaguelands/0 14.01,67.18
|mapmarker Eastern Plaguelands/0 14.55,57.81
|mapmarker Eastern Plaguelands/0 16.71,55.11
|mapmarker Eastern Plaguelands/0 16.71,59.79
|mapmarker Eastern Plaguelands/0 17.61,62.49
|mapmarker Eastern Plaguelands/0 17.97,68.26
|mapmarker Eastern Plaguelands/0 19.41,54.39
|mapmarker Eastern Plaguelands/0 21.39,59.25
|mapmarker Eastern Plaguelands/0 21.75,52.95
|mapmarker Eastern Plaguelands/0 23.01,56.73
|mapmarker Eastern Plaguelands/0 24.27,54.21
|mapmarker Eastern Plaguelands/0 24.81,59.07
|mapmarker Eastern Plaguelands/0 26.43,66.27
|mapmarker Eastern Plaguelands/0 26.43,72.76
|mapmarker Eastern Plaguelands/0 26.97,54.21
|mapmarker Eastern Plaguelands/0 27.51,58.89
|mapmarker Eastern Plaguelands/0 28.77,63.21
|mapmarker Eastern Plaguelands/0 29.67,71.50
|mapmarker Eastern Plaguelands/0 31.28,58.17
|mapmarker Eastern Plaguelands/0 31.82,69.52
|mapmarker Eastern Plaguelands/0 35.06,55.47
|mapmarker Eastern Plaguelands/0 35.06,58.35
|mapmarker Eastern Plaguelands/0 35.78,67.36
|mapmarker Eastern Plaguelands/0 36.50,63.57
|mapmarker Eastern Plaguelands/0 38.48,61.23
|mapmarker Eastern Plaguelands/0 38.84,55.65
|mapmarker Eastern Plaguelands/0 39.74,68.26
|mapmarker Eastern Plaguelands/0 41.00,62.31
|mapmarker Eastern Plaguelands/0 42.80,66.09
step
label "Kill_Plaguehound_Runts_And_Plaguebats"
kill 20 Plaguehound Runt##8596 |q 5542/1 |goto Eastern Plaguelands/0 34.52,71.50
kill 30 Plaguebat##8600 |q 5543/1 |goto Eastern Plaguelands/0 34.52,71.50
|mapmarker Eastern Plaguelands/0 13.11,54.21
|mapmarker Eastern Plaguelands/0 13.47,63.75
|mapmarker Eastern Plaguelands/0 14.01,67.18
|mapmarker Eastern Plaguelands/0 14.55,57.81
|mapmarker Eastern Plaguelands/0 16.71,55.11
|mapmarker Eastern Plaguelands/0 16.71,59.79
|mapmarker Eastern Plaguelands/0 17.61,62.49
|mapmarker Eastern Plaguelands/0 17.97,68.26
|mapmarker Eastern Plaguelands/0 19.41,54.39
|mapmarker Eastern Plaguelands/0 21.39,59.25
|mapmarker Eastern Plaguelands/0 21.75,52.95
|mapmarker Eastern Plaguelands/0 23.01,56.73
|mapmarker Eastern Plaguelands/0 24.27,54.21
|mapmarker Eastern Plaguelands/0 24.81,59.07
|mapmarker Eastern Plaguelands/0 26.43,66.27
|mapmarker Eastern Plaguelands/0 26.43,72.76
|mapmarker Eastern Plaguelands/0 26.97,54.21
|mapmarker Eastern Plaguelands/0 27.51,58.89
|mapmarker Eastern Plaguelands/0 28.77,63.21
|mapmarker Eastern Plaguelands/0 29.67,71.50
|mapmarker Eastern Plaguelands/0 31.28,58.17
|mapmarker Eastern Plaguelands/0 31.82,69.52
|mapmarker Eastern Plaguelands/0 35.06,55.47
|mapmarker Eastern Plaguelands/0 35.06,58.35
|mapmarker Eastern Plaguelands/0 35.78,67.36
|mapmarker Eastern Plaguelands/0 36.50,63.57
|mapmarker Eastern Plaguelands/0 38.48,61.23
|mapmarker Eastern Plaguelands/0 38.84,55.65
|mapmarker Eastern Plaguelands/0 39.74,68.26
|mapmarker Eastern Plaguelands/0 41.00,62.31
|mapmarker Eastern Plaguelands/0 42.80,66.09
step
Kill enemies
ding 57 |goto Eastern Plaguelands/0 34.52,71.50
|mapmarker Eastern Plaguelands/0 13.11,54.21
|mapmarker Eastern Plaguelands/0 13.47,63.75
|mapmarker Eastern Plaguelands/0 14.01,67.18
|mapmarker Eastern Plaguelands/0 14.55,57.81
|mapmarker Eastern Plaguelands/0 16.71,55.11
|mapmarker Eastern Plaguelands/0 16.71,59.79
|mapmarker Eastern Plaguelands/0 17.61,62.49
|mapmarker Eastern Plaguelands/0 17.97,68.26
|mapmarker Eastern Plaguelands/0 19.41,54.39
|mapmarker Eastern Plaguelands/0 21.39,59.25
|mapmarker Eastern Plaguelands/0 21.75,52.95
|mapmarker Eastern Plaguelands/0 23.01,56.73
|mapmarker Eastern Plaguelands/0 24.27,54.21
|mapmarker Eastern Plaguelands/0 24.81,59.07
|mapmarker Eastern Plaguelands/0 26.43,66.27
|mapmarker Eastern Plaguelands/0 26.43,72.76
|mapmarker Eastern Plaguelands/0 26.97,54.21
|mapmarker Eastern Plaguelands/0 27.51,58.89
|mapmarker Eastern Plaguelands/0 28.77,63.21
|mapmarker Eastern Plaguelands/0 29.67,71.50
|mapmarker Eastern Plaguelands/0 31.28,58.17
|mapmarker Eastern Plaguelands/0 31.82,69.52
|mapmarker Eastern Plaguelands/0 35.06,55.47
|mapmarker Eastern Plaguelands/0 35.06,58.35
|mapmarker Eastern Plaguelands/0 35.78,67.36
|mapmarker Eastern Plaguelands/0 36.50,63.57
|mapmarker Eastern Plaguelands/0 38.48,61.23
|mapmarker Eastern Plaguelands/0 38.84,55.65
|mapmarker Eastern Plaguelands/0 39.74,68.26
|mapmarker Eastern Plaguelands/0 41.00,62.31
|mapmarker Eastern Plaguelands/0 42.80,66.09
step
kill Hate Shrieker##8541, Scourge Warder##8525, Stitched Horror##8543, Gibbering Ghoul##8531, Unseen Servant##8538, Dark Caster##8526
|tip Undead.
|tip Careful, stealthed enemies.
|tip Avoid the {o}elite human enemies{} that patrol.
collect 7 Living Rot##15447 |n
|tip {o}Hurry{}, they disappear after {o}10 minutes{}.
|tip They don't stack, clear bag space.
use Mortar and Pestle##15454
collect Coagulated Rot##15448 |q 6022/1 |goto Eastern Plaguelands 50.18,59.97
|mapmarker Eastern Plaguelands/0 49.64,57.63
|mapmarker Eastern Plaguelands/0 50.72,55.11
|mapmarker Eastern Plaguelands/0 50.72,62.49
|mapmarker Eastern Plaguelands/0 52.34,57.63
|mapmarker Eastern Plaguelands/0 53.42,53.31
|mapmarker Eastern Plaguelands/0 53.42,60.51
|mapmarker Eastern Plaguelands/0 54.68,56.01
step
kill 5 Plaguehound##8597 |q 5542/2 |goto Eastern Plaguelands/0 59.54,64.29
kill 20 Noxious Plaguebat##8601 |q 6042/1 |goto Eastern Plaguelands 59.54,64.29
|mapmarker Eastern Plaguelands/0 56.12,47.19
|mapmarker Eastern Plaguelands/0 56.12,54.39
|mapmarker Eastern Plaguelands/0 56.30,50.61
|mapmarker Eastern Plaguelands/0 56.30,58.71
|mapmarker Eastern Plaguelands/0 58.46,56.73
|mapmarker Eastern Plaguelands/0 58.46,61.23
|mapmarker Eastern Plaguelands/0 59.00,53.13
|mapmarker Eastern Plaguelands/0 60.80,49.17
|mapmarker Eastern Plaguelands/0 60.80,58.71
|mapmarker Eastern Plaguelands/0 60.98,55.11
|mapmarker Eastern Plaguelands/0 61.70,61.41
|mapmarker Eastern Plaguelands/0 62.06,46.29
|mapmarker Eastern Plaguelands/0 62.42,52.05
|mapmarker Eastern Plaguelands/0 63.86,48.45
|mapmarker Eastern Plaguelands/0 64.22,60.33
|mapmarker Eastern Plaguelands/0 64.22,64.83
|mapmarker Eastern Plaguelands/0 64.58,45.02
|mapmarker Eastern Plaguelands/0 66.20,57.81
|mapmarker Eastern Plaguelands/0 66.74,62.49
|mapmarker Eastern Plaguelands/0 68.17,53.13
|mapmarker Eastern Plaguelands/0 68.89,55.83
|mapmarker Eastern Plaguelands/0 69.43,59.61
|mapmarker Eastern Plaguelands/0 72.13,59.61
step
talk Duke Nicholas Zverenhoff##11039
turnin Duke Nicholas Zverenhoff##6030 |goto Eastern Plaguelands 71.62,50.09
step
talk Carlin Redpath##11063
turnin Uncle Carlin##5241 |goto Eastern Plaguelands 71.70,50.04
accept Defenders of Darrowshire##5211 |goto Eastern Plaguelands 71.70,50.04
step
talk Caretaker Alen##11038
|tip Walks around.
accept Zaeldarr the Outcast##6021 |goto Eastern Plaguelands 69.92,53.64
accept The Restless Souls##5281 |goto Eastern Plaguelands 69.92,53.64
step
talk Caretaker Alen##11038
|tip Long questing session soon.
|tip Walks around.
Buy Extra Ammo |vendor Caretaker Alen##11038 |goto Eastern Plaguelands 69.92,53.64 |q 5281
|only if Hunter
step
talk Georgia##12636
fpath Light's Hope Chapel |goto Eastern Plaguelands 70.53,47.55
stickystart "Kill_Frenzied_Plaguehounds_And_Monstrous_Plaguebats"
stickystart "Free_Darrowshire_Spirits"
step
click Large Termite Mound##177464+
|tip Large stones leaking green ooze.
|tip Work your way west.
collect 100 Plagueland Termites##15043 |q 5901/1 |goto Eastern Plaguelands/0 39.65,26.93
|mapmarker Eastern Plaguelands/0 36.31,30.62
|mapmarker Eastern Plaguelands/0 36.90,27.09
|mapmarker Eastern Plaguelands/0 34.89,24.48
|mapmarker Eastern Plaguelands/0 30.77,24.86
|mapmarker Eastern Plaguelands/0 27.22,28.38
|mapmarker Eastern Plaguelands/0 22.17,30.05
|mapmarker Eastern Plaguelands/0 23.96,25.48
|mapmarker Eastern Plaguelands/0 21.89,23.04
|mapmarker Eastern Plaguelands/0 19.83,18.95
|mapmarker Eastern Plaguelands/0 18.55,15.60
|mapmarker Eastern Plaguelands/0 16.71,20.53
|mapmarker Eastern Plaguelands/0 33.95,16.99
|mapmarker Eastern Plaguelands/0 24.45,17.83
|mapmarker Eastern Plaguelands/0 28.95,21.43
step
talk Egan##11140
|tip Inside the building.
turnin The Restless Souls##5281 |goto Eastern Plaguelands 11.36,26.60
stickystop "Kill_Frenzied_Plaguehounds_And_Monstrous_Plaguebats"
step
talk Augustus the Touched##12384
|tip Inside the building.
accept Augustus' Receipt Book##6164 |goto Eastern Plaguelands 11.36,26.37
step
click Augustus' Receipt Book
|tip Upstairs inside the building.
collect Augustus' Receipt Book##15884 |q 6164/1 |goto Eastern Plaguelands 14.04,24.22
step
talk Augustus the Touched##12384
|tip Inside the building.
turnin Augustus' Receipt Book##6164 |goto Eastern Plaguelands 11.36,26.37
step
label "Kill_Frenzied_Plaguehounds_And_Monstrous_Plaguebats"
kill 5 Frenzied Plaguehound##8598 |q 5542/3 |goto Eastern Plaguelands 38.84,30.98
kill 10 Monstrous Plaguebat##8602 |q 6042/2 |goto Eastern Plaguelands 38.84,30.98
|mapmarker Eastern Plaguelands/0 48.20,22.69
|mapmarker Eastern Plaguelands/0 41.00,18.19
|mapmarker Eastern Plaguelands/0 42.80,31.34
|mapmarker Eastern Plaguelands/0 43.52,24.31
|mapmarker Eastern Plaguelands/0 44.06,20.53
|mapmarker Eastern Plaguelands/0 45.14,34.40
|mapmarker Eastern Plaguelands/0 47.12,16.57
|mapmarker Eastern Plaguelands/0 47.30,26.30
|mapmarker Eastern Plaguelands/0 49.10,37.64
|mapmarker Eastern Plaguelands/0 52.34,22.69
|mapmarker Eastern Plaguelands/0 53.60,39.44
|mapmarker Eastern Plaguelands/0 53.78,17.83
|mapmarker Eastern Plaguelands/0 54.50,32.60
|mapmarker Eastern Plaguelands/0 55.22,21.25
|mapmarker Eastern Plaguelands/0 55.40,28.82
|mapmarker Eastern Plaguelands/0 55.58,24.85
|mapmarker Eastern Plaguelands/0 55.94,35.66
step
label "Free_Darrowshire_Spirits"
kill Cannibal Ghoul##8530, Diseased Flayer##8532, Gibbering Ghoul##8531
|tip Ghouls.
|tip Shared spawns with other undead.
talk Darrowshire Spirit##11064+
|tip Appear at their corpses.
Free #15# Darrowshire Spirits |q 5211/1 |goto Eastern Plaguelands 58.64,32.96
|mapmarker Eastern Plaguelands/0 56.12,31.52
|mapmarker Eastern Plaguelands/0 56.66,29.54
|mapmarker Eastern Plaguelands/0 57.02,34.04
|mapmarker Eastern Plaguelands/0 58.28,30.98
|mapmarker Eastern Plaguelands/0 58.64,28.10
|mapmarker Eastern Plaguelands/0 60.08,30.98
|mapmarker Eastern Plaguelands/0 60.44,33.14
step
Enter the crypt |goto Eastern Plaguelands 23.42,73.19 < 10 |walk |only if not (subzone("The Undercroft")  and indoors())
kill Zaeldarr the Outcast##12250
|tip Downstairs inside the crypt.
collect Zaeldarr's Head##15785 |q 6021/1 |goto Eastern Plaguelands 23.06,72.65
step
talk Nathanos Blightcaller##11878
turnin To Kill With Purpose##6022 |goto Eastern Plaguelands 22.23,63.52
turnin Un-Life's Little Annoyances##6042 |goto Eastern Plaguelands 22.23,63.52
step
talk Tirion Fordring##1855
|tip Walks around.
turnin Demon Dogs##5542 |goto Eastern Plaguelands 5.16,35.57
turnin Blood Tinged Skies##5543 |goto Eastern Plaguelands 5.16,35.57
turnin Carrion Grubbage##5544 |goto Eastern Plaguelands 5.16,35.57
accept Redemption##5742 |goto Eastern Plaguelands 5.16,35.57
step
talk Tirion Fordring##1855
|tip Walks around.
Select _"I am ready to hear your tale, Tirion."_ |gossip 95701
Select _"Thank you, Tirion. What of your identity?"_ |gossip 96441
Select _"That is terrible."_ |gossip 96440
Select _"I will, Tirion."_ |gossip 96439
|tip Must be sitting.
|tip Type {o}/sit{} in chat. |macro /sit
Listen to Tirion's Tale |q 5742/1 |goto Eastern Plaguelands 5.16,35.57
step
talk Tirion Fordring##1855
|tip Walks around.
turnin Redemption##5742 |goto Eastern Plaguelands 5.16,35.57
step
label "Kill_Diseased_Grizzlies"
kill 8 Diseased Grizzly##1816 |q 4985/1 |goto Western Plaguelands 66.40,51.00
|tip Shared spawns with spiders. |notinsticky
|mapmarker Western Plaguelands/0 52.20,51.20
|mapmarker Western Plaguelands/0 52.40,54.40
|mapmarker Western Plaguelands/0 52.40,58.40
|mapmarker Western Plaguelands/0 53.20,62.60
|mapmarker Western Plaguelands/0 53.40,48.20
|mapmarker Western Plaguelands/0 54.40,45.20
|mapmarker Western Plaguelands/0 55.20,52.60
|mapmarker Western Plaguelands/0 56.00,58.60
|mapmarker Western Plaguelands/0 56.80,61.60
|mapmarker Western Plaguelands/0 57.00,55.60
|mapmarker Western Plaguelands/0 58.00,50.20
|mapmarker Western Plaguelands/0 55.80,64.60
|mapmarker Western Plaguelands/0 60.20,54.40
|mapmarker Western Plaguelands/0 61.40,48.40
|mapmarker Western Plaguelands/0 61.60,51.40
|mapmarker Western Plaguelands/0 63.20,44.40
|mapmarker Western Plaguelands/0 64.40,53.80
|mapmarker Western Plaguelands/0 64.60,47.60
|mapmarker Western Plaguelands/0 65.80,42.20
|mapmarker Western Plaguelands/0 66.20,57.40
|mapmarker Western Plaguelands/0 59.80,60.20
|mapmarker Western Plaguelands/0 66.60,45.20
|mapmarker Western Plaguelands/0 67.80,48.00
step
talk Mulgris Deepriver##10739
|tip Inside the building.
turnin The Wildlife Suffers Too##4985 |goto Western Plaguelands 53.72,64.67
accept Glyphed Oaken Branch##4987 |goto Western Plaguelands 53.72,64.67
step
talk Marlene Redpath##10927
|tip Walks around.
|tip {o}Both floors{} inside the building.
turnin Auntie Marlene##5152 |goto Western Plaguelands 49.17,78.58
accept A Strange Historian##5153 |goto Western Plaguelands 49.17,78.58
step
click Joseph Redpath's Monument
collect Joseph's Wedding Ring##12894 |q 5153/1 |goto Western Plaguelands 49.68,76.77
step
talk Chromie##10667
|tip Upstairs inside the building.
turnin Counting Out Time##4972 |goto Western Plaguelands 39.45,66.76
turnin A Strange Historian##5153 |goto Western Plaguelands 39.45,66.76
accept The Annals of Darrowshire##5154 |goto Western Plaguelands 39.45,66.76
step
_NOTE:_
During the Next Step
|tip Enemies near the building entrance.
|tip Run on the ledge of the building.
|tip Hug the building outside wall to reach the entrance.
Click Here to Continue |confirm |q 5154
step
click Musty Tome+
|tip Find the real book by zooming in and looking.
|tip Fake books spawn enemies.
|tip Real book has {o}two appearances{}:
|tip {o}Sharper pages{} and {o}even shading on both halves{}.
|tip Or
|tip {o}Uneven shading{} with {o}large brown spot{} on the pages{}.
|tip If no real book, click fakes to get it to spawn.
|tip Inside the building.
collect Annals of Darrowshire##12900 |q 5154/1 |goto Western Plaguelands 43.52,69.55
step
talk Chromie##10667
|tip Upstairs inside the building.
turnin The Annals of Darrowshire##5154 |goto Western Plaguelands 39.45,66.76
accept Brother Carlin##5210 |goto Western Plaguelands 39.45,66.76
step
_Destroy These Items:_
|tip Not needed.
trash Ruined Tome##15696
step
talk Apothecary Dithers##11057
turnin Skeletal Fragments##964 |goto Tirisfal Glades 83.28,69.23
step
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5234 |goto Tirisfal Glades 83.04,71.91
accept Target: Gahrron's Withering##5235 |goto Tirisfal Glades 83.04,71.91
step
talk Mickey Levine##11615
turnin A Plague Upon Thee##5901 |goto Tirisfal Glades 83.29,72.33
accept A Plague Upon Thee##5902 |goto Tirisfal Glades 83.29,72.33
step
_Destroy These Items:_
|tip Not needed.
trash Plagueland Termites##15043
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Royal Overseer Bauhaus##10781
turnin Better Late Than Never##5023 |goto Undercity 69.78,43.15
accept The Jeremiah Blues##5049 |goto Undercity 69.78,43.15
step
talk Jeremiah Payson##8403
|tip Under the stairs.
turnin The Jeremiah Blues##5049 |goto Undercity 67.60,44.16
accept Good Luck Charm##5050 |goto Undercity 67.60,44.16
step
talk Auctioneer Cain##15682
|tip Buy from the auction house, if possible.
|tip Or collect from bank.
collect 60 Wool Cloth##2592		|goto Undercity/0 67.64,35.90 |q 7813 |future
collect 60 Silk Cloth##4306		|goto Undercity/0 67.64,35.90 |q 7814 |future
collect 60 Mageweave Cloth##4338	|goto Undercity/0 67.64,35.90 |q 7817 |future
collect 60 Runecloth##14047		|goto Undercity/0 67.64,35.90 |q 7818 |future
step
talk Ralston Farnsley##14729
accept A Donation of Wool##7813 |goto Undercity 71.66,29.23 |instant
|only if itemcount(2592) >= 60
step
talk Ralston Farnsley##14729
accept A Donation of Silk##7814 |goto Undercity 71.66,29.23 |instant
|only if itemcount(4306) >= 60
step
talk Ralston Farnsley##14729
accept A Donation of Mageweave##7817 |goto Undercity 71.66,29.23 |instant
|only if itemcount(4338) >= 60
step
talk Ralston Farnsley##14729
accept A Donation of Runecloth##7818 |goto Undercity 71.66,29.23 |instant
|only if itemcount(14047) >= 60
step
talk Caretaker Alen##11038
|tip Walks around.
turnin Zaeldarr the Outcast##6021 |goto Eastern Plaguelands 69.92,53.64
step
talk Carlin Redpath##11063
turnin Brother Carlin##5210 |goto Eastern Plaguelands/0 71.70,50.03
accept Villains of Darrowshire##5181 |goto Eastern Plaguelands/0 71.70,50.03
turnin Defenders of Darrowshire##5211 |goto Eastern Plaguelands/0 71.70,50.03
step
click Horgus' Skull##176208
|tip Underwater.
collect Skull of Horgus##12956 |q 5181/1 |goto Eastern Plaguelands/0 44.34,41.18
step
click Shattered Sword of Marduk##176209
collect Shattered Sword of Marduk##12957 |q 5181/2 |goto Eastern Plaguelands/0 46.86,55.43
step
kill Cauldron Lord Soulwrath##11078
|tip Walks around.
collect Gahrron's Withering Cauldron Key##13196 |q 5225/1 |goto Western Plaguelands 62.78,58.75
step
click Scourge Cauldron
turnin Target: Gahrron's Withering##5235 |goto Western Plaguelands 62.56,58.57
accept Return to the Bulwark##5236 |goto Western Plaguelands 62.56,58.57
step
click Northridge Lumber Mill Crate
|tip Inside the building.
Select _"Place Termite Barrel on the crate."_ |gossip 97332
click Termite Barrel
|tip Appears on the crate.
turnin A Plague Upon Thee##5902 |goto Western Plaguelands 48.35,32.00
accept A Plague Upon Thee##6390 |goto Western Plaguelands 48.35,32.00
step
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Good Luck Charm##5050 |goto Western Plaguelands/0 38.40,54.05
accept Two Halves Become One##5051 |goto Western Plaguelands/0 38.40,54.05
step
kill Jabbering Ghoul##10801
|tip Ghoul with pitchfork.
|tip Walks around.
|tip May spawn here.
collect Good Luck Other-Half-Charm##12722 |goto Western Plaguelands/0 38.00,56.35 |q 5051
|mapmarker Western Plaguelands/0 36.20,57.40
|mapmarker Western Plaguelands/0 36.20,59.40
|mapmarker Western Plaguelands/0 37.20,55.40
step
use Good Luck Other-Half-Charm##12722
collect Good Luck Charm##12723 |q 5051/1
step
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Two Halves Become One##5051 |goto Western Plaguelands/0 38.40,54.05
step
Kill enemies
ding 58 |goto Western Plaguelands/0 41.80,62.00
|mapmarker Western Plaguelands/0 37.80,70.40
|mapmarker Western Plaguelands/0 39.40,66.80
|mapmarker Western Plaguelands/0 40.20,73.80
|mapmarker Western Plaguelands/0 41.00,70.40
|mapmarker Western Plaguelands/0 42.60,67.00
|mapmarker Western Plaguelands/0 44.20,74.80
|mapmarker Western Plaguelands/0 44.40,69.80
|mapmarker Western Plaguelands/0 44.80,62.20
|mapmarker Western Plaguelands/0 45.60,65.40
|mapmarker Western Plaguelands/0 47.00,71.60
|mapmarker Western Plaguelands/0 48.00,63.00
|mapmarker Western Plaguelands/0 48.00,68.20
step
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5236 |goto Tirisfal Glades 83.03,71.91
step
talk Mickey Levine##11615
turnin A Plague Upon Thee##6390 |goto Tirisfal Glades 83.29,72.33
step
talk High Executor Derrington##10837
accept Mission Accomplished!##5238 |goto Tirisfal Glades 83.13,68.94 |instant
step
talk Velma Warnam##4773
Train Undead Horsemanship |learnspell Undead Horsemanship##10906 |goto Tirisfal Glades/0 60.08,52.57
Buy a mount from Zachariah Post nearby at [Tirisfal Glades/0 59.87,52.68]
|only if Undead and discountgold('Undercity',1000000)
step
talk Carlin Redpath##11063
turnin Villains of Darrowshire##5181 |goto Eastern Plaguelands/0 71.70,50.03
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 3564
|only if Druid
step
talk Enyo##5883
|tip Inside the building.
Train Abilities |trainer Enyo##5883 |goto Orgrimmar/0 38.79,85.65 |q 3564
|only if Mage
step
talk Auctioneer Thathung##8673
|tip Buy from the auction house, if possible.
|tip Or collect from bank.
|tip Inside the building.
collect 60 Wool Cloth##2592		|goto Orgrimmar/0 55.68,62.83		|q 7826 |future
collect 60 Silk Cloth##4306		|goto Orgrimmar/0 55.68,62.83		|q 7827 |future
collect 60 Mageweave Cloth##4338	|goto Orgrimmar/0 55.68,62.83		|q 7831 |future
collect 60 Runecloth##14047		|goto Orgrimmar/0 55.68,62.83		|q 7824 |future
step
talk Karus##3309
|tip Collect from the bank.
|tip Inside the building.
collect Andron's Note##10679 |goto Orgrimmar 49.58,69.12 |q 3564
step
talk Karus##3309
|tip Deposit into the bank.
|tip Inside the building.
bank Glyphed Oaken Branch##12663 |goto Orgrimmar 49.58,69.12 |q 4987
step
talk Rashona Straglash##14726
|tip Inside the building.
accept A Donation of Wool##7826 |goto Orgrimmar/0 63.60,51.22 |instant
|only if itemcount(2592) >= 60
step
talk Rashona Straglash##14726
|tip Inside the building.
accept A Donation of Silk##7827 |goto Orgrimmar/0 63.60,51.22 |instant
|only if itemcount(4306) >= 60
step
talk Rashona Straglash##14726
|tip Inside the building.
accept A Donation of Mageweave##7831 |goto Orgrimmar/0 63.60,51.22 |instant
|only if itemcount(4338) >= 60
step
talk Rashona Straglash##14726
|tip Inside the building.
accept A Donation of Runecloth##7824 |goto Orgrimmar/0 63.60,51.22 |instant
|only if itemcount(14047) >= 60
step
talk Grezz Ragefist##3353
|tip Inside the building.
Train Abilities |trainer Grezz Ragefist##3353 |goto Orgrimmar/0 79.78,31.42 |q 3564
|only if Warrior
step
talk Ormak Grimshot##3352
|tip Top of the building.
Train Abilities |trainer Ormak Grimshot##3352 |goto Orgrimmar/0 66.06,18.54 |q 3564
|only if Hunter
step
talk Kildar##4752
Train Wolf Riding |learnspell Wolf Riding##825 |goto Orgrimmar/0 69.40,13.10
Buy a mount from Ogunaro Wolfrunner nearby at [Orgrimmar/0 69.38,12.26]
|only if Orc and discountgold('Orgrimmar',1000000)
step
talk Kardris Dreamseeker##3344
|tip Inside the building.
Train Abilities |trainer Kardris Dreamseeker##3344 |goto Orgrimmar/0 38.80,36.38 |q 3564
|only if Shaman
step
talk Ormok##3328
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Ormok##3328 |goto Orgrimmar/0 43.91,54.63 |q 3564
|only if Rogue
step
talk Mirket##3325
|tip Inside the Cleft of Shadow.
Train Abilities |trainer Mirket##3325 |goto Orgrimmar/0 48.62,46.95 |q 3564
|only if Warlock
step
talk Kurgul##5815
|tip Buy available Grimoires.
|tip Inside the Cleft of Shadow.
Train Demon Abilities |vendor Kurgul##5815 |goto Orgrimmar 47.52,46.72 |q 3564
|only if Warlock
step
talk Auctioneer Thathung##8673
|tip Buy from the auction house, if possible.
|tip Or collect from bank.
|tip Inside the building.
collect 60 Wool Cloth##2592		|goto Orgrimmar/0 55.68,62.83		|q 7833 |future
collect 60 Silk Cloth##4306		|goto Orgrimmar/0 55.68,62.83		|q 7834 |future
collect 60 Mageweave Cloth##4338	|goto Orgrimmar/0 55.68,62.83		|q 7835 |future
collect 60 Runecloth##14047		|goto Orgrimmar/0 55.68,62.83		|q 7836 |future
step
talk Cenarion Emissary Blackhoof##15188
accept Taking Back Silithus##8276 |goto Orgrimmar 47.64,65.77
step
talk Vehena##14727
|tip Inside the building.
accept A Donation of Wool##7833 |goto Orgrimmar/0 37.69,87.90 |instant
|only if itemcount(2592) >= 60
step
talk Vehena##14727
|tip Inside the building.
accept A Donation of Silk##7834 |goto Orgrimmar/0 37.69,87.90 |instant
|only if itemcount(4306) >= 60
step
talk Vehena##14727
|tip Inside the building.
accept A Donation of Mageweave##7835 |goto Orgrimmar/0 37.69,87.90 |instant
|only if itemcount(4338) >= 60
step
talk Vehena##14727
|tip Inside the building.
accept A Donation of Runecloth##7836 |goto Orgrimmar/0 37.69,87.90 |instant
|only if itemcount(14047) >= 60
step
talk Ur'kyo##6018
|tip Inside the building.
Train Abilities |trainer Ur'kyo##6018 |goto Orgrimmar/0 35.59,87.80 |q 3564
|only if Priest
step
talk Xar'Ti##7953
Train Raptor Riding |learnspell Raptor Riding##10861 |goto Durotar/0 55.28,75.49
Buy a mount from Zjolnir nearby at [Durotar/0 55.23,75.65]
|only if Troll and discountgold('Darkspear Trolls',1000000)
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Jediga##8587
turnin Andron's Payment to Jediga##3564 |goto Azshara 22.56,51.42
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Winterspring (58-59)",{
image=ZGV.IMAGESDIR.."Winterspring",
hardcore = true,
next="Leveling Guides\\Silithus (59-60)",
},[[
step
talk Azzleby##11119
Stable Your Pet |stablemaster Azzleby##11119 |goto Winterspring/0 60.39,37.92 |q 977 |future
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 8){}.
|only if Hunter
step
Learn the {y}Claw (Rank 8){} Pet Ability |learnspell Claw##3666 |goto Winterspring/0 57.80,26.40 |q 977 |future
|tip Cast {o}Tame Beast{} on a {o}Winterspring Screecher{}.
|tip White owls.
|tip Kill enemies nearby.
|mapmarker Winterspring/0 53.40,20.80
|mapmarker Winterspring/0 55.20,23.20
|mapmarker Winterspring/0 56.40,12.60
|mapmarker Winterspring/0 57.40,16.80
|mapmarker Winterspring/0 57.40,20.40
|mapmarker Winterspring/0 59.20,11.40
|mapmarker Winterspring/0 60.00,14.60
|mapmarker Winterspring/0 60.00,22.80
|mapmarker Winterspring/0 62.40,27.80
|only if Hunter
step
talk Azzleby##11119
Retrieve Your Pet |stablemaster Azzleby##11119 |goto Winterspring/0 60.39,37.92 |q 977 |future
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 8){} to Your Pet |learnpetspell Claw##3009 |q 977 |future
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
talk Umi Rumplesnicker##10305
accept Are We There, Yeti?##977 |goto Winterspring 60.88,37.62
step
talk Felnok Steelspring##10468
accept Chillwind Horns##4809 |goto Winterspring 61.63,38.61
step
_NOTE:_
While in Winterspring
|tip Kill enemies as you walk.
|tip Reduces grinding later.
Click Here to Continue |confirm |q 977
stickystart "Collect_Uncracked_Chillwind_Horns"
step
kill Ice Thistle Matriarch##7459, Ice Thistle Patriarch##7460
|tip Matriarchs and Patriarchs.
|tip Yetis.
|tip Inside and outside the cave.
collect 2 Pristine Yeti Horn##12367 |q 977/1 |goto Winterspring 67.65,41.75
|mapmarker Winterspring/0 64.20,39.80
|mapmarker Winterspring/0 64.40,41.80
|mapmarker Winterspring/0 65.80,44.80
|mapmarker Winterspring/0 69.20,40.00
|mapmarker Winterspring/0 71.40,40.40
stickystop "Collect_Uncracked_Chillwind_Horns"
stickystart "Kill_Winterfall_Enemies"
step
Leave the cave |goto Winterspring 67.65,41.75 < 30 |walk |only if subzone("Ice Thistle Hills") and indoors()
Run up and over the mountain |goto Winterspring/0 65.83,38.46 < 30 |only if walking and not subzone("Winterfall Village")
kill Winterfall Shaman##7439, Winterfall Den Watcher##7440, Winterfall Ursa##7438
collect Winterfall Ritual Totem##20742 |n
use Winterfall Ritual Totem##20742
accept Winterfall Ritual Totem##8471 |goto Winterspring/0 67.80,37.80
|mapmarker Winterspring/0 65.40,37.40
|mapmarker Winterspring/0 66.20,35.00
|mapmarker Winterspring/0 66.40,38.60
|mapmarker Winterspring/0 67.60,35.60
step
label "Kill_Winterfall_Enemies"
kill 8 Winterfall Shaman##7439		|q 8464/1 |goto Winterspring/0 67.80,37.80
kill 8 Winterfall Den Watcher##7440	|q 8464/2 |goto Winterspring/0 67.80,37.80
kill 8 Winterfall Ursa##7438		|q 8464/3 |goto Winterspring/0 67.80,37.80
|mapmarker Winterspring/0 65.40,37.40
|mapmarker Winterspring/0 66.20,35.00
|mapmarker Winterspring/0 66.40,38.60
|mapmarker Winterspring/0 67.60,35.60
stickystart "Collect_Uncracked_Chillwind_Horns"
step
kill 13 Moontouched Owlbeast##7453 |q 4741/1 |goto Winterspring/0 63.40,23.40
|mapmarker Winterspring/0 63.20,20.00
|mapmarker Winterspring/0 63.60,16.20
|mapmarker Winterspring/0 65.00,18.72
|mapmarker Winterspring/0 66.60,21.40
|mapmarker Winterspring/0 66.80,24.40
step
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##977 |goto Winterspring 60.88,37.62
stickystop "Collect_Uncracked_Chillwind_Horns"
step
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto Winterspring 61.63,38.61
|only if readyq(4809)
step
talk Trull Failbane##10306
turnin Wild Guardians##4741 |goto Felwood/0 34.73,52.79
accept Wild Guardians##4721 |goto Felwood/0 34.73,52.79
stickystart "Kill_Berserk_Owlbeasts"
stickystart "Collect_Uncracked_Chillwind_Horns"
step
kill Berserk Owlbeast##7454, Moontouched Owlbeast##7453, Crazed Owlbeast##7452
collect Blue-feathered Necklace##12558 |n
use Blue-feathered Necklace##12558
accept Guarding Secrets##4882 |goto Winterspring/0 63.40,23.40
|mapmarker Winterspring/0 63.20,20.00
|mapmarker Winterspring/0 63.60,16.20
|mapmarker Winterspring/0 65.00,18.72
|mapmarker Winterspring/0 66.60,21.40
|mapmarker Winterspring/0 66.80,24.40
step
label "Kill_Berserk_Owlbeasts"
kill 10 Berserk Owlbeast##7454 |q 4721/1 |goto Winterspring/0 63.40,23.40
|mapmarker Winterspring/0 63.20,20.00
|mapmarker Winterspring/0 63.60,16.20
|mapmarker Winterspring/0 65.00,18.72
|mapmarker Winterspring/0 66.60,21.40
|mapmarker Winterspring/0 66.80,24.40
step
label "Collect_Uncracked_Chillwind_Horns"
kill Chillwind Chimaera##7448, Chillwind Ravager##7449, Fledgling Chillwind##7447
|tip Chimaeras.
collect 8 Uncracked Chillwind Horn##12444 |q 4809/1 |goto Winterspring/0 64.00,30.20
|mapmarker Winterspring/0 55.00,46.60
|mapmarker Winterspring/0 55.40,37.40
|mapmarker Winterspring/0 57.20,40.60
|mapmarker Winterspring/0 59.20,44.60
|mapmarker Winterspring/0 61.20,41.40
|mapmarker Winterspring/0 61.60,48.00
|mapmarker Winterspring/0 62.40,34.80
|mapmarker Winterspring/0 63.40,45.40
|mapmarker Winterspring/0 64.60,26.20
|mapmarker Winterspring/0 65.60,53.20
|mapmarker Winterspring/0 66.40,47.60
|mapmarker Winterspring/0 66.60,28.60
|mapmarker Winterspring/0 66.80,31.60
|mapmarker Winterspring/0 68.00,50.20
step
talk Umi Rumplesnicker##10305
accept Are We There, Yeti?##5163 |goto Winterspring 60.88,37.62
step
use Umi's Mechanical Yeti##12928
|tip On Legacki.
Scare Legacki |q 5163/1 |goto Winterspring 61.54,38.62
step
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto Winterspring/0 61.63,38.61
step
talk Innkeeper Vizzie##11118
|tip Inside the building.
home Everlook |goto Winterspring 61.36,38.83 |q 5527 |future
step
talk Salfa##11556
turnin Winterfall Activity##8464 |goto Winterspring 27.74,34.50
step
talk Kernda##11558
|tip Walks around.
|tip Inside the tunnel.
turnin Winterfall Ritual Totem##8471	|goto Felwood/0 65.49,3.48 |region timbermawhold
step
talk Faustron##12740
fpath Moonglade |goto Moonglade/0 32.10,66.60
step
talk Rabine Saturna##11801
|tip Inside the building.
turnin Rabine Saturna##1123 |goto Moonglade 51.68,45.09
accept Wasteland##1124 |goto Moonglade 51.68,45.09
step
talk Rabine Saturna##11801
|tip Inside the building.
Select _"Have you ever heard of a place called Dire Maul?"_ |gossip 96817
Select _"Why do you say that this is a coincidence, Rabine?"_ |gossip 97191
Select _"The Fruit of Fertility?"_ |gossip 97192
Select _"But something went wrong, didn't it?"_ |gossip 96827
Select _"What would happen if the Fruit of Fertility - or the Felvine - was allowed to be fully corrupted?"_ |gossip 96012
Select _"What would you have me do, Rabine?"_ |gossip 97194
Watch the dialogue
Click Here to Continue |confirm |goto Moonglade 51.68,45.09 |q 5527 |future
|tip Must have discovered {o}Dire Maul{} dungeon earlier in the guide.
step
talk Rabine Saturna##11801
|tip Inside the building.
accept A Reliquary of Purity##5527 |goto Moonglade 51.68,45.09
|tip Must have discovered {o}Dire Maul{} dungeon earlier in the guide.
step
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
|tip Final long grind.
|tip Run dungeons, if you prefer.
expcollect Deadwood Headdress Feather##21377,5,550,59
|tip Count will reduce as you grind.
ding 59 |goto Felwood 63.60,9.60
Turn in Feathers at [64.77,8.13]
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
step
label "ClearQuest_Feathers_For_Nafien"
|execute clearquest(8467)
|only if itemcount(21377) >= 5
step
talk Nafien##15395
accept Feathers for Nafien##8467 |goto Felwood 64.77,8.13 |instant
|only if itemcount(21377) >= 5
step
|next "ClearQuest_Feathers_For_Nafien"
|only if itemcount(21377) >= 5
step
talk Kernda##11558
|tip Walks around.
|tip Inside the tunnel.
turnin Deadwood Ritual Totem##8470	|goto Felwood/0 65.49,3.48 |region timbermawhold
|mapmarker Felwood/0 65.37,2.49 |region timbermawhold
|mapmarker Felwood/0 65.38,1.17 |region timbermawhold
|only if level < 56.10
step
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
collect 30 Runecloth##14047 |goto Felwood 63.60,9.60 |q 6031 |future
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
|only if rep('Timbermaw Hold') >= Friendly and level < 60
step
talk Meilosh##11557
|tip Inside the tunnel.
accept Runecloth##6031 |goto Felwood/0 65.69,2.81 |region timbermawhold
|only if rep('Timbermaw Hold') >= Friendly and level < 60 and itemcount(14047) >= 30
step
talk Meilosh##11557
|tip Inside the tunnel.
turnin Runecloth##6031 |goto Felwood/0 65.69,2.81 |region timbermawhold
|only if rep('Timbermaw Hold') >= Friendly and level < 60 and itemcount(14047) >= 30
step
talk Trull Failbane##10306
turnin Wild Guardians##4721 |goto Felwood/0 34.73,52.79
turnin Guarding Secrets##4882 |goto Felwood/0 34.73,52.79
accept Guarding Secrets##4883 |goto Felwood/0 34.73,52.79
step
talk Auctioneer Stampi##8674
|tip Buy from the auction house, if possible.
|tip Or collect from bank.
collect 60 Wool Cloth##2592		|goto Thunder Bluff 40.41,51.77		|q 7820 |future
collect 60 Silk Cloth##4306		|goto Thunder Bluff 40.41,51.77		|q 7821 |future
collect 60 Mageweave Cloth##4338	|goto Thunder Bluff 40.41,51.77		|q 7822 |future
collect 60 Runecloth##14047		|goto Thunder Bluff 40.41,51.77		|q 7823 |future
step
talk Chesmu##8356
|tip Collect from the bank.
|tip Inside the building.
collect Eridan's Supplies##11617	|goto Thunder Bluff 47.13,57.89 |q 4005
collect Glyphed Oaken Branch##12663	|goto Thunder Bluff 47.13,57.89 |q 4987
step
talk Rumstag Proudstrider##14728
|tip Inside the building.
accept A Donation of Wool##7820 |goto Thunder Bluff 43.05,42.72 |instant
|only if itemcount(2592) >= 60
step
talk Rumstag Proudstrider##14728
|tip Inside the building.
accept A Donation of Silk##7821 |goto Thunder Bluff 43.05,42.72 |instant
|only if itemcount(4306) >= 60
step
talk Rumstag Proudstrider##14728
|tip Inside the building.
accept A Donation of Mageweave##7822 |goto Thunder Bluff 43.05,42.72 |instant
|only if itemcount(4338) >= 60
step
talk Rumstag Proudstrider##14728
|tip Inside the building.
accept A Donation of Runecloth##7823 |goto Thunder Bluff 43.05,42.72 |instant
|only if itemcount(14047) >= 60
step
talk Nara Wildmane##5770
|tip Inside the building.
turnin Guarding Secrets##4883 |goto Thunder Bluff 75.65,31.61
turnin Glyphed Oaken Branch##4987 |goto Thunder Bluff 75.65,31.61
step
map Thunder Bluff
path follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	42.59,59.42	39.25,63.11	37.23,59.78	36.31,54.06	37.87,51.02
path	42.85,56.51	44.30,68.39	46.19,69.23	49.04,66.75	49.85,61.95
path	56.77,61.65	56.26,54.51	58.95,52.31	57.74,48.48	54.32,48.53
path	52.58,51.30	55.21,54.51
talk Bluff Runner Windstrider##10881
|tip Walks a large path.
accept Camp Mojache##7492
step
talk Kar Stormsinger##3690
Train Kodo Riding |learnspell Kodo Riding##18995 |goto Mulgore/0 46.78,62.01
Buy a mount from Harb Clawhoof nearby at [Mulgore/0 46.65,62.11]
|only if Tauren and discountgold('Thunder Bluff',1000000)
step
talk Talo Thornhoof##7776
|tip Inside the building.
turnin Camp Mojache##7492 |goto Feralas 76.18,43.83
step
use Umi's Mechanical Yeti##12928
|tip On Sprinkle.
Scare Sprinkle |q 5163/2 |goto Tanaris 51.06,26.87
step
use Eridan's Supplies##11617
collect Irontree Heart##11173 |q 4005
collect 11 Silvery Claws##11172 |q 4005
collect Book of Aquor##11169 |q 4005
step
Run through the tunnel to enter Lost Rigger Cove |goto Tanaris 68.62,41.46 < 20 |only if walking and not subzone("Lost Rigger Cove")
use Book of Aquor##11169
Watch the dialogue
kill Aquementas##9453
collect Silver Totem of Aquementas##11522 |q 4005/1 |goto Tanaris 70.42,49.90
step
Run through the tunnel to leave Lost Rigger Cove |goto Tanaris/0 69.63,42.37 < 20 |only if walking and subzone("Lost Rigger Cove")
Enter the cave |goto Un'Goro Crater/0 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
turnin Aquementas##4005 |goto Un'Goro Crater/0 41.92,2.70
accept Linken's Adventure##3961 |goto Un'Goro Crater/0 41.92,2.70
step
_Destroy These Items:_
|tip Not needed.
trash Irontree Heart##11173 |goto Un'Goro Crater 43.44,6.77
trash Silvery Claws##11172 |goto Un'Goro Crater 43.44,6.77
trash Book of Aquor##11169 |goto Un'Goro Crater 43.44,6.77
step
Leave the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
talk Linken##8737
turnin Linken's Adventure##3961 |goto Un'Goro Crater 44.66,8.10
step
use Umi's Mechanical Yeti##12928
|tip On Quixxil.
Scare Quixxil |q 5163/3 |goto Un'Goro Crater 43.67,9.38
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Silithus (59-60)",{
image=ZGV.IMAGESDIR.."Silithus",
hardcore = true,
},[[
step
talk Layo Starstrike##13220
|tip Inside the building.
turnin Wasteland##1124 |goto Silithus 81.87,18.93
accept The Spirits of Southwind##1125 |goto Silithus 81.87,18.93
step
talk Beetix Ficklespragg##15189
|tip Walks around.
|tip Upstairs inside the building.
accept Deadly Desert Venom##8277 |goto Silithus 51.71,38.58
step
talk Windcaller Proudhorn##15191
turnin Taking Back Silithus##8276 |goto Silithus 51.15,38.29
accept Securing the Supply Lines##8280 |goto Silithus 51.15,38.29
step
talk Geologist Larksbane##15183
accept The Twilight Mystery##8284 |goto Silithus 49.67,37.46
step
talk Bor Wildmane##15306
accept Secret Communication##8318 |goto Silithus 48.57,37.78
step
talk Runk Windtamer##15178
fpath Cenarion Hold |goto Silithus 48.68,36.68
step
talk Commander Mar'alith##15181
|tip On the balcony of the building.
accept Dearest Natalia##8304 |goto Silithus 49.19,34.18
stickystart "Kill_Tortured_Enemies"
step
click Dusty Reliquary
|tip Inside the building.
collect Reliquary of Purity##22201 |q 5527/1 |goto Silithus 63.23,55.35
step
label "Kill_Tortured_Enemies"
kill 8 Tortured Druid##12178 |q 1125/1 |goto Silithus 60.80,49.40
kill 8 Tortured Sentinel##12179 |q 1125/2 |goto Silithus 60.80,49.40
|tip Careful, may {o}spawn enemies{} when they die.
|mapmarker Silithus/0 58.80,55.80
|mapmarker Silithus/0 60.20,52.40
|mapmarker Silithus/0 61.80,55.20
|mapmarker Silithus/0 63.40,47.40
|mapmarker Silithus/0 63.60,51.40
|mapmarker Silithus/0 66.00,49.40
step
use Brann Bronzebeard's Lost Letter##20461
accept Brann Bronzebeard's Lost Letter##8308
|only if itemcount(20461) > 0
stickystart "Collect_Stonelash_Scorpid_Stingers"
stickystart "Collect_Sand_Skitterer_Fangs"
stickystart "Kill_Dredge_Strikers"
step
talk Layo Starstrike##13220
|tip Inside the building.
turnin The Spirits of Southwind##1125 |goto Silithus 81.87,18.93
step
label "Collect_Stonelash_Scorpid_Stingers"
kill Stonelash Scorpid##11735+
|tip Scorpions.
collect 8 Stonelash Scorpid Stinger##20373 |q 8277/1 |goto Silithus/0 55.00,34.60
|mapmarker Silithus/0 49.80,15.20
|mapmarker Silithus/0 50.80,18.20
|mapmarker Silithus/0 51.20,29.40
|mapmarker Silithus/0 52.40,24.40
|mapmarker Silithus/0 52.40,32.60
|mapmarker Silithus/0 53.20,20.00
|mapmarker Silithus/0 54.00,16.40
|mapmarker Silithus/0 55.00,11.60
|mapmarker Silithus/0 55.20,22.60
|mapmarker Silithus/0 55.40,29.20
|mapmarker Silithus/0 56.40,19.20
|mapmarker Silithus/0 57.40,26.00
|mapmarker Silithus/0 58.00,15.40
|mapmarker Silithus/0 58.20,12.00
|mapmarker Silithus/0 58.20,22.40
|mapmarker Silithus/0 59.20,29.20
|mapmarker Silithus/0 59.20,41.40
|mapmarker Silithus/0 59.40,33.40
|mapmarker Silithus/0 60.20,18.00
|mapmarker Silithus/0 60.20,38.40
|mapmarker Silithus/0 60.40,26.20
|mapmarker Silithus/0 61.20,21.00
|mapmarker Silithus/0 61.40,15.00
|mapmarker Silithus/0 61.40,44.00
|mapmarker Silithus/0 62.20,30.80
|mapmarker Silithus/0 62.40,40.60
|mapmarker Silithus/0 63.20,24.40
|mapmarker Silithus/0 63.40,17.60
|mapmarker Silithus/0 63.40,28.00
|mapmarker Silithus/0 64.20,45.20
|mapmarker Silithus/0 64.40,33.40
|mapmarker Silithus/0 65.40,37.60
|mapmarker Silithus/0 65.60,22.20
|mapmarker Silithus/0 65.80,30.20
|mapmarker Silithus/0 66.00,41.00
|mapmarker Silithus/0 67.40,44.00
|mapmarker Silithus/0 68.00,47.80
|mapmarker Silithus/0 69.20,39.00
|mapmarker Silithus/0 71.80,35.80
|mapmarker Silithus/0 72.80,39.40
|mapmarker Silithus/0 75.80,31.00
step
label "Collect_Sand_Skitterer_Fangs"
kill Sand Skitterer##11738+
|tip Spiders.
collect 8 Sand Skitterer Fang##20376 |q 8277/2 |goto Silithus/0 55.00,34.60
|mapmarker Silithus/0 49.80,15.20
|mapmarker Silithus/0 50.80,18.20
|mapmarker Silithus/0 51.20,29.40
|mapmarker Silithus/0 52.40,24.40
|mapmarker Silithus/0 52.40,32.60
|mapmarker Silithus/0 53.20,20.00
|mapmarker Silithus/0 54.00,16.40
|mapmarker Silithus/0 55.00,11.60
|mapmarker Silithus/0 55.20,22.60
|mapmarker Silithus/0 55.40,29.20
|mapmarker Silithus/0 56.40,19.20
|mapmarker Silithus/0 57.40,26.00
|mapmarker Silithus/0 58.00,15.40
|mapmarker Silithus/0 58.20,12.00
|mapmarker Silithus/0 58.20,22.40
|mapmarker Silithus/0 59.20,29.20
|mapmarker Silithus/0 59.20,41.40
|mapmarker Silithus/0 59.40,33.40
|mapmarker Silithus/0 60.20,18.00
|mapmarker Silithus/0 60.20,38.40
|mapmarker Silithus/0 60.40,26.20
|mapmarker Silithus/0 61.20,21.00
|mapmarker Silithus/0 61.40,15.00
|mapmarker Silithus/0 61.40,44.00
|mapmarker Silithus/0 62.20,30.80
|mapmarker Silithus/0 62.40,40.60
|mapmarker Silithus/0 63.20,24.40
|mapmarker Silithus/0 63.40,17.60
|mapmarker Silithus/0 63.40,28.00
|mapmarker Silithus/0 64.20,45.20
|mapmarker Silithus/0 64.40,33.40
|mapmarker Silithus/0 65.40,37.60
|mapmarker Silithus/0 65.60,22.20
|mapmarker Silithus/0 65.80,30.20
|mapmarker Silithus/0 66.00,41.00
|mapmarker Silithus/0 67.40,44.00
|mapmarker Silithus/0 68.00,47.80
|mapmarker Silithus/0 69.20,39.00
|mapmarker Silithus/0 71.80,35.80
|mapmarker Silithus/0 72.80,39.40
|mapmarker Silithus/0 75.80,31.00
step
label "Kill_Dredge_Strikers"
kill 15 Dredge Striker##11740 |q 8280/1 |goto Silithus/0 55.00,34.60
|mapmarker Silithus/0 49.80,15.20
|mapmarker Silithus/0 50.80,18.20
|mapmarker Silithus/0 51.20,29.40
|mapmarker Silithus/0 52.40,24.40
|mapmarker Silithus/0 52.40,32.60
|mapmarker Silithus/0 53.20,20.00
|mapmarker Silithus/0 54.00,16.40
|mapmarker Silithus/0 55.00,11.60
|mapmarker Silithus/0 55.20,22.60
|mapmarker Silithus/0 55.40,29.20
|mapmarker Silithus/0 56.40,19.20
|mapmarker Silithus/0 57.40,26.00
|mapmarker Silithus/0 58.00,15.40
|mapmarker Silithus/0 58.20,12.00
|mapmarker Silithus/0 58.20,22.40
|mapmarker Silithus/0 59.20,29.20
|mapmarker Silithus/0 59.20,41.40
|mapmarker Silithus/0 59.40,33.40
|mapmarker Silithus/0 60.20,18.00
|mapmarker Silithus/0 60.20,38.40
|mapmarker Silithus/0 60.40,26.20
|mapmarker Silithus/0 61.20,21.00
|mapmarker Silithus/0 61.40,15.00
|mapmarker Silithus/0 61.40,44.00
|mapmarker Silithus/0 62.20,30.80
|mapmarker Silithus/0 62.40,40.60
|mapmarker Silithus/0 63.20,24.40
|mapmarker Silithus/0 63.40,17.60
|mapmarker Silithus/0 63.40,28.00
|mapmarker Silithus/0 64.20,45.20
|mapmarker Silithus/0 64.40,33.40
|mapmarker Silithus/0 65.40,37.60
|mapmarker Silithus/0 65.60,22.20
|mapmarker Silithus/0 65.80,30.20
|mapmarker Silithus/0 66.00,41.00
|mapmarker Silithus/0 67.40,44.00
|mapmarker Silithus/0 68.00,47.80
|mapmarker Silithus/0 69.20,39.00
|mapmarker Silithus/0 71.80,35.80
|mapmarker Silithus/0 72.80,39.40
|mapmarker Silithus/0 75.80,31.00
step
talk Beetix Ficklespragg##15189
|tip Walks around.
|tip Upstairs inside the building.
turnin Deadly Desert Venom##8277 |goto Silithus 51.71,38.58
accept Noggle's Last Hope##8278 |goto Silithus 51.71,38.58
step
talk Windcaller Proudhorn##15191
turnin Securing the Supply Lines##8280 |goto Silithus 51.15,38.29
accept Stepping Up Security##8281 |goto Silithus 51.15,38.29
step
click Twilight Tablet Fragment+
|tip Blue-glowing stone pieces.
collect 8 Twilight Tablet Fragment##20378 |q 8284/1 |goto Silithus 26.40,15.80
|mapmarker Silithus/0 17.60,23.10
|mapmarker Silithus/0 19.50,21.10
|mapmarker Silithus/0 20.10,15.40
|mapmarker Silithus/0 20.40,11.40
|mapmarker Silithus/0 20.60,8.00
|mapmarker Silithus/0 20.90,18.10
|mapmarker Silithus/0 21.50,22.00
|mapmarker Silithus/0 22.00,14.60
|mapmarker Silithus/0 22.60,8.30
|mapmarker Silithus/0 24.00,15.40
|mapmarker Silithus/0 24.10,9.80
|mapmarker Silithus/0 24.40,11.90
|mapmarker Silithus/0 26.60,13.30
|mapmarker Silithus/0 27.40,10.50
step
talk Geologist Larksbane##15183
turnin The Twilight Mystery##8284 |goto Silithus/0 49.68,37.46
accept The Deserter##8285 |goto Silithus/0 49.68,37.46
stickystart "Collect_Stonelash_Flayer_Stingers"
stickystart "Collect_Rock_Stalker_Fangs"
stickystart "Collect_Stonelash_Pincer_Stingers"
stickystart "Kill_Dredge_Crushers"
step
talk Hermit Ortell##15194
|tip Inside the small cave.
turnin The Deserter##8285 |goto Silithus/0 67.19,69.76
accept The Twilight Lexicon##8279 |goto Silithus/0 67.19,69.76
step
talk Rutgar Glyphshaper##15170
|tip Run around the insect area.
Select _"Hello, Rutgar. The Commander has sent me here to gather some information about his missing wife."_ |gossip 97861
Select _"That sounds dangerous."_ |gossip 97051
Select _"What happened to her after that?"_ |gossip 97050
Select _"Natalia?"_ |gossip 97049
Select _"What demands?"_ |gossip 95880
Select _"Lost it? What do you mean?"_ |gossip 98267
Select _"Possessed by what?"_ |gossip 97048
Select _"I'll be back once I straighten this mess out."_ |gossip 97047
Question Rutgar |q 8304/2 |goto Silithus/0 41.28,88.45
step
talk Frankal Stonebridge##15171
Select _"Hello, Frankal. I've heard that you might have some information as to the whereabouts of Mistress Natalia Mar'alith."_ |gossip 97860
Select _"That's what I like to hear."_ |gossip 98096
Select _"That's odd."_ |gossip 98095
Select _"You couldn't handle a lone night elf priestess?"_ |gossip 98094
Select _"I've been meaning to ask you about that monkey."_ |gossip 98093
Select _"Then what?"_ |gossip 95881
Select _"What a story! So she went into Hive'Regal and that was the last you saw of her?"_ |gossip 96129
Select _"Thanks for the information, Frankal."_ |gossip 98293
Question Frankal |q 8304/1 |goto Silithus/0 40.82,88.85
stickystart "Collect_Encrypted_Twilight_Texts"
step
kill Twilight Keeper Exeter##11803
|tip Walks around.
collect Twilight Lexicon - Chapter 2##20395 |q 8279/2 |goto Silithus/0 15.40,86.20
|mapmarker Silithus/0 16.40,84.40
|mapmarker Silithus/0 16.60,88.00
|mapmarker Silithus/0 18.00,86.00
stickystop "Collect_Encrypted_Twilight_Texts"
step
label "Collect_Stonelash_Flayer_Stingers"
kill Stonelash Flayer##11737+
|tip Grey scorpions.
collect 3 Stonelash Flayer Stinger##20375 |q 8278/1 |goto Silithus/0 36.20,81.60
|mapmarker Silithus/0 19.40,76.00
|mapmarker Silithus/0 22.00,79.80
|mapmarker Silithus/0 23.20,85.80
|mapmarker Silithus/0 24.40,76.00
|mapmarker Silithus/0 26.00,81.20
|mapmarker Silithus/0 26.80,72.00
|mapmarker Silithus/0 27.20,86.00
|mapmarker Silithus/0 28.80,76.00
|mapmarker Silithus/0 30.20,82.60
|mapmarker Silithus/0 31.00,72.40
|mapmarker Silithus/0 31.20,67.80
|mapmarker Silithus/0 33.00,88.00
|mapmarker Silithus/0 33.40,76.40
|mapmarker Silithus/0 35.20,69.40
|mapmarker Silithus/0 36.20,85.60
|mapmarker Silithus/0 37.00,90.20
|mapmarker Silithus/0 37.40,76.00
|mapmarker Silithus/0 38.60,71.60
|mapmarker Silithus/0 39.20,67.40
|mapmarker Silithus/0 40.20,80.80
|mapmarker Silithus/0 40.20,85.60
|mapmarker Silithus/0 41.40,90.20
|mapmarker Silithus/0 41.60,76.20
|mapmarker Silithus/0 43.40,66.40
|mapmarker Silithus/0 43.60,72.40
|mapmarker Silithus/0 44.00,84.00
|mapmarker Silithus/0 44.40,93.20
|mapmarker Silithus/0 45.40,77.80
|mapmarker Silithus/0 45.40,88.80
|mapmarker Silithus/0 47.60,72.00
|mapmarker Silithus/0 47.80,82.60
|mapmarker Silithus/0 49.00,67.40
step
label "Collect_Rock_Stalker_Fangs"
kill Rock Stalker##11739+
|tip Spiders.
collect 3 Rock Stalker Fang##20377 |q 8278/3 |goto Silithus/0 36.20,81.60
|mapmarker Silithus/0 19.40,76.00
|mapmarker Silithus/0 22.00,79.80
|mapmarker Silithus/0 23.20,85.80
|mapmarker Silithus/0 24.40,76.00
|mapmarker Silithus/0 26.00,81.20
|mapmarker Silithus/0 26.80,72.00
|mapmarker Silithus/0 27.20,86.00
|mapmarker Silithus/0 28.80,76.00
|mapmarker Silithus/0 30.20,82.60
|mapmarker Silithus/0 31.00,72.40
|mapmarker Silithus/0 31.20,67.80
|mapmarker Silithus/0 33.00,88.00
|mapmarker Silithus/0 33.40,76.40
|mapmarker Silithus/0 35.20,69.40
|mapmarker Silithus/0 36.20,85.60
|mapmarker Silithus/0 37.00,90.20
|mapmarker Silithus/0 37.40,76.00
|mapmarker Silithus/0 38.60,71.60
|mapmarker Silithus/0 39.20,67.40
|mapmarker Silithus/0 40.20,80.80
|mapmarker Silithus/0 40.20,85.60
|mapmarker Silithus/0 41.40,90.20
|mapmarker Silithus/0 41.60,76.20
|mapmarker Silithus/0 43.40,66.40
|mapmarker Silithus/0 43.60,72.40
|mapmarker Silithus/0 44.00,84.00
|mapmarker Silithus/0 44.40,93.20
|mapmarker Silithus/0 45.40,77.80
|mapmarker Silithus/0 45.40,88.80
|mapmarker Silithus/0 47.60,72.00
|mapmarker Silithus/0 47.80,82.60
|mapmarker Silithus/0 49.00,67.40
stickystart "Collect_Encrypted_Twilight_Texts"
step
kill Twilight Keeper Havunth##11804
|tip Orc in a purple robe.
|tip Walks around.
|tip Spawns near here.
collect Twilight Lexicon - Chapter 3##20396 |q 8279/3 |goto Silithus/0 40.43,41.99
step
kill Twilight Keeper Mayna##15200
|tip Walks around.
collect Twilight Lexicon - Chapter 1##20394 |q 8279/1 |goto Silithus/0 26.62,36.33
step
label "Collect_Encrypted_Twilight_Texts"
kill Twilight Geolord##11881, Twilight Avenger##11880, Twilight Stonecaller##11882
collect 10 Encrypted Twilight Text##20404 |q 8318/1 |goto Silithus/0 26.20,35.60
|mapmarker Silithus/0 23.40,33.40
|mapmarker Silithus/0 24.20,35.40
|mapmarker Silithus/0 24.40,38.00
|mapmarker Silithus/0 25.40,31.20
|mapmarker Silithus/0 25.40,33.40
|mapmarker Silithus/0 27.40,32.40
|mapmarker Silithus/0 27.60,30.40
|mapmarker Silithus/0 28.60,34.00
|mapmarker Silithus/0 37.00,42.40
|mapmarker Silithus/0 37.20,45.40
|mapmarker Silithus/0 38.40,47.60
|mapmarker Silithus/0 39.00,40.40
|mapmarker Silithus/0 39.20,43.60
|mapmarker Silithus/0 40.00,46.20
|mapmarker Silithus/0 41.60,45.00
step
talk Hermit Ortell##15194
|tip Inside the small cave.
turnin The Twilight Lexicon##8279 |goto Silithus/0 67.19,69.76
accept A Terrible Purpose##8287 |goto Silithus/0 67.19,69.76
step
_Destroy These Items:_
|tip Not needed.
trash Twilight Lexicon - Chapter 1##20394
trash Twilight Lexicon - Chapter 2##20395
trash Twilight Lexicon - Chapter 3##20396
step
label "Collect_Stonelash_Pincer_Stingers"
kill Stonelash Pincer##11736+
|tip Yellow scorpions.
collect 3 Stonelash Pincer Stinger##20374 |q 8278/2 |goto Silithus/0 56.40,60.20
|mapmarker Silithus/0 19.20,45.00
|mapmarker Silithus/0 19.80,39.20
|mapmarker Silithus/0 21.80,35.20
|mapmarker Silithus/0 22.80,42.40
|mapmarker Silithus/0 22.80,47.80
|mapmarker Silithus/0 26.40,28.00
|mapmarker Silithus/0 27.00,39.40
|mapmarker Silithus/0 27.40,44.00
|mapmarker Silithus/0 30.00,36.40
|mapmarker Silithus/0 30.40,48.20
|mapmarker Silithus/0 31.40,40.60
|mapmarker Silithus/0 32.40,31.40
|mapmarker Silithus/0 32.40,44.60
|mapmarker Silithus/0 34.20,36.40
|mapmarker Silithus/0 34.60,60.80
|mapmarker Silithus/0 35.80,55.60
|mapmarker Silithus/0 36.20,41.20
|mapmarker Silithus/0 36.20,67.40
|mapmarker Silithus/0 36.40,50.40
|mapmarker Silithus/0 37.60,63.60
|mapmarker Silithus/0 38.60,59.20
|mapmarker Silithus/0 39.40,53.80
|mapmarker Silithus/0 40.20,48.40
|mapmarker Silithus/0 41.80,64.60
|mapmarker Silithus/0 42.60,56.40
|mapmarker Silithus/0 43.40,45.40
|mapmarker Silithus/0 43.40,51.20
|mapmarker Silithus/0 43.40,60.40
|mapmarker Silithus/0 46.20,66.20
|mapmarker Silithus/0 46.40,54.20
|mapmarker Silithus/0 47.40,58.60
|mapmarker Silithus/0 47.80,50.40
|mapmarker Silithus/0 50.00,63.40
|mapmarker Silithus/0 50.40,55.40
|mapmarker Silithus/0 51.80,59.40
|mapmarker Silithus/0 54.20,64.20
|mapmarker Silithus/0 54.40,56.20
|mapmarker Silithus/0 56.80,52.60
|mapmarker Silithus/0 58.40,63.80
|mapmarker Silithus/0 61.40,53.80
|mapmarker Silithus/0 61.40,60.40
|mapmarker Silithus/0 62.20,66.60
|mapmarker Silithus/0 65.20,61.80
step
label "Kill_Dredge_Crushers"
kill 20 Dredge Crusher##11741 |q 8281/1 |goto Silithus/0 56.40,60.20
|tip Worms.
|mapmarker Silithus/0 19.20,45.00
|mapmarker Silithus/0 19.80,39.20
|mapmarker Silithus/0 21.80,35.20
|mapmarker Silithus/0 22.80,42.40
|mapmarker Silithus/0 22.80,47.80
|mapmarker Silithus/0 26.40,28.00
|mapmarker Silithus/0 27.00,39.40
|mapmarker Silithus/0 27.40,44.00
|mapmarker Silithus/0 30.00,36.40
|mapmarker Silithus/0 30.40,48.20
|mapmarker Silithus/0 31.40,40.60
|mapmarker Silithus/0 32.40,31.40
|mapmarker Silithus/0 32.40,44.60
|mapmarker Silithus/0 34.20,36.40
|mapmarker Silithus/0 34.60,60.80
|mapmarker Silithus/0 35.80,55.60
|mapmarker Silithus/0 36.20,41.20
|mapmarker Silithus/0 36.20,67.40
|mapmarker Silithus/0 36.40,50.40
|mapmarker Silithus/0 37.60,63.60
|mapmarker Silithus/0 38.60,59.20
|mapmarker Silithus/0 39.40,53.80
|mapmarker Silithus/0 40.20,48.40
|mapmarker Silithus/0 41.80,64.60
|mapmarker Silithus/0 42.60,56.40
|mapmarker Silithus/0 43.40,45.40
|mapmarker Silithus/0 43.40,51.20
|mapmarker Silithus/0 43.40,60.40
|mapmarker Silithus/0 46.20,66.20
|mapmarker Silithus/0 46.40,54.20
|mapmarker Silithus/0 47.40,58.60
|mapmarker Silithus/0 47.80,50.40
|mapmarker Silithus/0 50.00,63.40
|mapmarker Silithus/0 50.40,55.40
|mapmarker Silithus/0 51.80,59.40
|mapmarker Silithus/0 54.20,64.20
|mapmarker Silithus/0 54.40,56.20
|mapmarker Silithus/0 56.80,52.60
|mapmarker Silithus/0 58.40,63.80
|mapmarker Silithus/0 61.40,53.80
|mapmarker Silithus/0 61.40,60.40
|mapmarker Silithus/0 62.20,66.60
|mapmarker Silithus/0 65.20,61.80
step
talk Windcaller Proudhorn##15191
turnin Stepping Up Security##8281 |goto Silithus/0 51.15,38.29
step
talk Beetix Ficklespragg##15189
|tip Walks around.
|tip Upstairs inside the building.
turnin Noggle's Last Hope##8278 |goto Silithus/0 51.71,38.58
step
talk Commander Mar'alith##15181
|tip On the balcony of the building.
turnin A Terrible Purpose##8287 |goto Silithus/0 49.19,34.18
turnin Dearest Natalia##8304 |goto Silithus/0 49.19,34.18
step
talk Bor Wildmane##15306
turnin Secret Communication##8318 |goto Silithus 48.58,37.78
step
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##5163 |goto Winterspring 60.88,37.62
step
talk Rabine Saturna##11801
|tip Inside the building.
turnin A Reliquary of Purity##5527 |goto Moonglade 51.68,45.08
step
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
|tip Run dungeons, if you prefer.
expcollect Deadwood Headdress Feather##21377,5,550,60
|tip Count will reduce as you grind.
ding 60 |goto Felwood 63.60,9.60
Turn in Feathers at [64.77,8.13]
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 62.40,12.60
|mapmarker Felwood/0 63.60,6.00
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Ruins of Ahn'Qiraj Cloak Quest",{
description="This guide will walk you through obtaining the Ruins of Ahn'Qiraj class-specific cloak.",
condition_end=function() return completedq(8692,8696,8691,8695,8689,8693,8690,8694,8557) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Keyl Swiftclaw##15500
accept Cloak of Unending Life##8692 |goto Silithus 51.76,39.53 |only Druid
accept Cloak of the Unseen Path##8696 |goto Silithus 51.76,39.53 |only Hunter
accept Drape of Vaulted Secrets##8691 |goto Silithus 51.76,39.53 |only Mage
accept Cape of Eternal Justice##8695 |goto Silithus 51.76,39.53 |only Paladin
accept Shroud of Infinite Wisdom##8689 |goto Silithus 51.76,39.53 |only Priest
accept Cloak of Veiled Shadows##8693 |goto Silithus 51.76,39.53 |only Rogue
accept Cloak of the Gathering Storm##8690 |goto Silithus 51.76,39.53 |only Shaman
accept Shroud of Unspoken Names##8694 |goto Silithus 51.76,39.53 |only Warlock
accept Drape of Unyielding Strength##8557 |goto Silithus 51.76,39.53 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Revered_Reputation"
step
collect 1 Qiraji Regal Drape##20889 |q 8692/1 |only Druid
collect 1 Qiraji Regal Drape##20889 |q 8696/1 |only Hunter
collect 1 Qiraji Martial Drape##20885 |q 8691/1 |only Mage
collect 1 Qiraji Regal Drape##20889 |q 8695/1 |only Paladin
collect 1 Qiraji Martial Drape##20885 |q 8689/1 |only Priest
collect 1 Qiraji Martial Drape##20885 |q 8693/1 |only Rogue
collect 1 Qiraji Regal Drape##20889 |q 8690/1 |only Shaman
collect 1 Qiraji Regal Drape##20889 |q 8694/1 |only Warlock
collect 1 Qiraji Martial Drape##20885 |q 8557/1 |only Warrior
|tip This has a chance to drop from General Rajaxx, Kurinnaxx, Ayamiss the Hunter, and Buru the Gorger in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Vermillion Idol##20872 |q 8692/2 |only Druid
collect 2 Lambent Idol##20868 |q 8696/2 |only Hunter
collect 2 Alabaster Idol##20873 |q 8691/2 |only Mage
collect 2 Obsidian Idol##20871 |q 8695/2 |only Paladin
collect 2 Jasper Idol##20870 |q 8689/2 |only Priest
collect 2 Azure Idol##20866 |q 8693/2 |only Rogue
collect 2 Obsidian Idol##20871 |q 8690/2 |only Shaman
collect 2 Amber Idol##20869 |q 8694/2 |only Warlock
collect 2 Onyx Idol##20867 |q 8557/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Bone Scarab##20864 |q 8692/3 |only Druid
collect 5 Stone Scarab##20858 |q 8696/3 |only Hunter
collect 5 Stone Scarab##20858 |q 8691/3 |only Mage
collect 5 Gold Scarab##20859 |q 8695/3 |only Paladin
collect 5 Gold Scarab##20859 |q 8689/3 |only Priest
collect 5 Bronze Scarab##20861 |q 8693/3 |only Rogue
collect 5 Clay Scarab##20863 |q 8690/3 |only Shaman
collect 5 Bronze Scarab##20861 |q 8694/3 |only Warlock
collect 5 Bone Scarab##20864 |q 8557/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Silver Scarab##20860 |q 8692/4 |only Druid
collect 5 Crystal Scarab##20862 |q 8696/4 |only Hunter
collect 5 Crystal Scarab##20862 |q 8691/4 |only Mage
collect 5 Clay Scarab##20863 |q 8695/4 |only Paladin
collect 5 Clay Scarab##20863 |q 8689/4 |only Priest
collect 5 Ivory Scarab##20865 |q 8693/4 |only Rogue
collect 5 Gold Scarab##20859 |q 8690/4 |only Shaman
collect 5 Ivory Scarab##20865 |q 8694/4 |only Warlock
collect 5 Silver Scarab##20860 |q 8557/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Revered_Reputation"
Reach Revered Reputation with the Cenarion Circle |complete rep("Cenarion Circle") >= Revered |or
'|complete completedq(8692,8696,8691,8695,8689,8693,8690,8694,8557) |or
step
talk Keyl Swiftclaw##15500
turnin Cloak of Unending Life##8692 |goto Silithus 51.76,39.53 |only Druid
turnin Cloak of the Unseen Path##8696 |goto Silithus 51.76,39.53 |only Hunter
turnin Drape of Vaulted Secrets##8691 |goto Silithus 51.76,39.53 |only Mage
turnin Cape of Eternal Justice##8695 |goto Silithus 51.76,39.53 |only Paladin
turnin Shroud of Infinite Wisdom##8689 |goto Silithus 51.76,39.53 |only Priest
turnin Cloak of Veiled Shadows##8693 |goto Silithus 51.76,39.53 |only Rogue
turnin Cloak of the Gathering Storm##8690 |goto Silithus 51.76,39.53 |only Shaman
turnin Shroud of Unspoken Names##8694 |goto Silithus 51.76,39.53 |only Warlock
turnin Drape of Unyielding Strength##8557 |goto Silithus 51.76,39.53 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Ruins of Ahn'Qiraj Ring Quest",{
description="This guide will walk you through obtaining the Ruins of Ahn'Qiraj class-specific ring.",
condition_end=function() return completedq(8700,8704,8699,8703,8697,8701,8698,8702,8556) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Windcaller Yessendra##15498
accept Band of Unending Life##8700 |goto Silithus 52.04,38.15 |only Druid
accept Signet of the Unseen Path##8704 |goto Silithus 52.04,38.15 |only Hunter
accept Band of Vaulted Secrets##8699 |goto Silithus 52.04,38.15 |only Mage
accept Ring of Eternal Justice##8703 |goto Silithus 52.04,38.15 |only Paladin
accept Ring of Infinite Wisdom##8697 |goto Silithus 52.04,38.15 |only Priest
accept Band of Veiled Shadows##8701 |goto Silithus 52.04,38.15 |only Rogue
accept Ring of the Gathering Storm##8698 |goto Silithus 52.04,38.15 |only Shaman
accept Ring of Unspoken Names##8702 |goto Silithus 52.04,38.15 |only Warlock
accept Signet of Unyielding Strength##8556 |goto Silithus 52.04,38.15 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Honored_Reputation"
step
collect 1 Qiraji Magisterial Ring##20884 |q 8700/1 |only Druid
collect 1 Qiraji Ceremonial Ring##20888 |q 8704/1 |only Hunter
collect 1 Qiraji Magisterial Ring##20884 |q 8699/1 |only Mage
collect 1 Qiraji Magisterial Ring##20884 |q 8703/1 |only Paladin
collect 1 Qiraji Ceremonial Ring##20888 |q 8697/1 |only Priest
collect 1 Qiraji Ceremonial Ring##20888 |q 8701/1 |only Rogue
collect 1 Qiraji Magisterial Ring##20884 |q 8698/1 |only Shaman
collect 1 Qiraji Ceremonial Ring##20888 |q 8702/1 |only Warlock
collect 1 Qiraji Magisterial Ring##20884 |q 8556/1 |only Warrior
|tip This has a chance to drop from Ayamiss the Hunter, Buru the Gorger, Moam, General Rajax, Kurinnaxx, and Ossirian the Unscarred in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Alabaster Idol##20873 |q 8700/2 |only Druid
collect 2 Amber Idol##20869 |q 8704/2 |only Hunter
collect 2 Azure Idol##20866 |q 8699/2 |only Mage
collect 2 Vermillion Idol##20872 |q 8703/2 |only Paladin
collect 2 Obsidian Idol##20871 |q 8697/2 |only Priest
collect 2 Onyx Idol##20867 |q 8701/2 |only Rogue
collect 2 Vermillion Idol##20872 |q 8698/2 |only Shaman
collect 2 Jasper Idol##20870 |q 8702/2 |only Warlock
collect 2 Lambent Idol##20868 |q 8556/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Bronze Scarab##20861 |q 8700/3 |only Druid
collect 5 Gold Scarab##20859 |q 8704/3 |only Hunter
collect 5 Gold Scarab##20859 |q 8699/3 |only Mage
collect 5 Silver Scarab##20860 |q 8703/3 |only Paladin
collect 5 Silver Scarab##20860 |q 8697/3 |only Priest
collect 5 Stone Scarab##20858 |q 8701/3 |only Rogue
collect 5 Silver Scarab##20860 |q 8698/3 |only Shaman
collect 5 Stone Scarab##20858 |q 8702/3 |only Warlock
collect 5 Bronze Scarab##20861 |q 8556/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Ivory Scarab##20865 |q 8700/4 |only Druid
collect 5 Clay Scarab##20863 |q 8704/4 |only Hunter
collect 5 Clay Scarab##20863 |q 8699/4 |only Mage
collect 5 Bone Scarab##20864 |q 8703/4 |only Paladin
collect 5 Bone Scarab##20864 |q 8697/4 |only Priest
collect 5 Crystal Scarab##20862 |q 8701/4 |only Rogue
collect 5 Bronze Scarab##20861 |q 8698/4 |only Shaman
collect 5 Crystal Scarab##20862 |q 8702/4 |only Warlock
collect 5 Ivory Scarab##20865 |q 8556/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Honored_Reputation"
Reach Honored Reputation with the Cenarion Circle |complete rep("Cenarion Circle") >= Honored |or
'|complete completedq(8700,8704,8699,8703,8697,8701,8698,8702,8556) |or
step
talk Windcaller Yessendra##15498
turnin Band of Unending Life##8700 |goto Silithus 52.04,38.15 |only Druid
turnin Signet of the Unseen Path##8704 |goto Silithus 52.04,38.15 |only Hunter
turnin Band of Vaulted Secrets##8699 |goto Silithus 52.04,38.15 |only Mage
turnin Ring of Eternal Justice##8703 |goto Silithus 52.04,38.15 |only Paladin
turnin Ring of Infinite Wisdom##8697 |goto Silithus 52.04,38.15 |only Priest
turnin Band of Veiled Shadows##8701 |goto Silithus 52.04,38.15 |only Rogue
turnin Ring of the Gathering Storm##8698 |goto Silithus 52.04,38.15 |only Shaman
turnin Ring of Unspoken Names##8702 |goto Silithus 52.04,38.15 |only Warlock
turnin Signet of Unyielding Strength##8556 |goto Silithus 52.04,38.15 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Ruins of Ahn'Qiraj Weapon Quest",{
description="This guide will walk you through obtaining the Ruins of Ahn'Qiraj class-specific cloak.",
condition_end=function() return completedq(8708,8712,8707,8711,8705,8709,8706,8710,8558) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Warden Haro##15499
accept Mace of Unending Life##8708 |goto Silithus 51.14,38.95 |only Druid
accept Scythe of the Unseen Path##8712 |goto Silithus 51.14,38.95 |only Hunter
accept Blade of Vaulted Secrets##8707 |goto Silithus 51.14,38.95 |only Mage
accept Blade of Eternal Justice##8711 |goto Silithus 51.14,38.95 |only Paladin
accept Gavel of Infinite Wisdom##8705 |goto Silithus 51.14,38.95 |only Priest
accept Dagger of Veiled Shadows##8709 |goto Silithus 51.14,38.95 |only Rogue
accept Hammer of the Gathering Storm##8706 |goto Silithus 51.14,38.95 |only Shaman
accept Kris of Unspoken Names##8710 |goto Silithus 51.14,38.95 |only Warlock
accept Sickle of Unyielding Strength##8558 |goto Silithus 51.14,38.95 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Exalted_Reputation"
step
collect 1 Qiraji Ornate Hilt##20890 |q 8708/1 |only Druid
collect 1 Qiraji Spiked Hilt##20886 |q 8712/1 |only Hunter
collect 1 Qiraji Ornate Hilt##20890 |q 8707/1 |only Mage
collect 1 Qiraji Spiked Hilt##20886 |q 8711/1 |only Paladin
collect 1 Qiraji Ornate Hilt##20890 |q 8705/1 |only Priest
collect 1 Qiraji Spiked Hilt##20886 |q 8709/1 |only Rogue
collect 1 Qiraji Spiked Hilt##20886 |q 8706/1 |only Shaman
collect 1 Qiraji Ornate Hilt##20890 |q 8710/1 |only Warlock
collect 1 Qiraji Spiked Hilt##20886 |q 8558/1 |only Warrior
|tip This has a chance to drop from Ayamiss the Hunter, Buru the Gorger, Moam, General Rajax, Kurinnaxx, and Ossirian the Unscarred in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Jasper Idol##20870 |q 8708/2 |only Druid
collect 2 Azure Idol##20866 |q 8712/2 |only Hunter
collect 2 Obsidian Idol##20871 |q 8707/2 |only Mage
collect 2 Amber Idol##20869 |q 8711/2 |only Paladin
collect 2 Lambent Idol##20868 |q 8705/2 |only Priest
collect 2 Vermillion Idol##20872 |q 8709/2 |only Rogue
collect 2 Amber Idol##20869 |q 8706/2 |only Shaman
collect 2 Onyx Idol##20867 |q 8710/2 |only Warlock
collect 2 Alabaster Idol##20873 |q 8558/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Crystal Scarab##20862 |q 8708/3 |only Druid
collect 5 Silver Scarab##20860 |q 8712/3 |only Hunter
collect 5 Silver Scarab##20860 |q 8707/3 |only Mage
collect 5 Bronze Scarab##20861 |q 8711/3 |only Paladin
collect 5 Bronze Scarab##20861 |q 8705/3 |only Priest
collect 5 Gold Scarab##20859 |q 8709/3 |only Rogue
collect 5 Bronze Scarab##20861 |q 8706/3 |only Shaman
collect 5 Gold Scarab##20859 |q 8710/3 |only Warlock
collect 5 Crystal Scarab##20862 |q 8558/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Stone Scarab##20858 |q 8708/4 |only Druid
collect 5 Bone Scarab##20864 |q 8712/4 |only Hunter
collect 5 Bone Scarab##20864 |q 8707/4 |only Mage
collect 5 Ivory Scarab##20865 |q 8711/4 |only Paladin
collect 5 Ivory Scarab##20865 |q 8705/4 |only Priest
collect 5 Clay Scarab##20863 |q 8709/4 |only Rogue
collect 5 Ivory Scarab##20865 |q 8706/4 |only Shaman
collect 5 Clay Scarab##20863 |q 8710/4 |only Warlock
collect 5 Stone Scarab##20858 |q 8558/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Exalted_Reputation"
Reach Exalted Reputation with the Cenarion Circle |complete rep("Cenarion Circle") >= Exalted |or
'|complete completedq(8708,8712,8707,8711,8705,8709,8706,8710,8558) |or
step
talk Warden Haro##15499
turnin Mace of Unending Life##8708 |goto Silithus 51.14,38.95 |only Druid
turnin Scythe of the Unseen Path##8712 |goto Silithus 51.14,38.95 |only Hunter
turnin Blade of Vaulted Secrets##8707 |goto Silithus 51.14,38.95 |only Mage
turnin Blade of Eternal Justice##8711 |goto Silithus 51.14,38.95 |only Paladin
turnin Gavel of Infinite Wisdom##8705 |goto Silithus 51.14,38.95 |only Priest
turnin Dagger of Veiled Shadows##8709 |goto Silithus 51.14,38.95 |only Rogue
turnin Hammer of the Gathering Storm##8706 |goto Silithus 51.14,38.95 |only Shaman
turnin Kris of Unspoken Names##8710 |goto Silithus 51.14,38.95 |only Warlock
turnin Sickle of Unyielding Strength##8558 |goto Silithus 51.14,38.95 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Shoulder Quest",{
description="This guide will walk you through obtaining the Temple of Ahn'Qiraj class-specific shoulders.",
condition_end=function() return completedq(8669,8659,8625,8630,8594,8641,8602,8664,8544) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Andorgos##15502
|tip She is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
accept Genesis Shoulderpads##8669 |only Druid
accept Striker's Pauldrons##8659 |only Hunter
accept Enigma Shoulderpads##8625 |only Mage
accept Avenger's Pauldrons##8630 |only Paladin
accept Mantle of the Oracle##8594 |only Priest
accept Deathdealer's Spaulders##8641 |only Rogue
accept Stormcaller's Pauldrons##8602 |only Shaman
accept Doomcaller's Mantle##8664 |only Warlock
accept Conqueror's Spaulders##8544 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Neutral_Reputation"
step
collect 1 Qiraji Bindings of Dominance##20932 |q 8669/1 |only Druid
collect 1 Qiraji Bindings of Command##20928 |q 8659/1 |only Hunter
collect 1 Qiraji Bindings of Dominance##20932 |q 8625/1 |only Mage
collect 1 Qiraji Bindings of Dominance##20932 |q 8630/1 |only Paladin
collect 1 Qiraji Bindings of Command##20928 |q 8594/1 |only Priest
collect 1 Qiraji Bindings of Command##20928 |q 8641/1 |only Rogue
collect 1 Qiraji Bindings of Dominance##20932 |q 8602/1 |only Shaman
collect 1 Qiraji Bindings of Dominance##20932 |q 8664/1 |only Warlock
collect 1 Qiraji Bindings of Command##20928 |q 8544/1 |only Warrior
|tip This has a chance to drop from Princess Huhuran and Viscidus in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Idol of Strife##20881 |q 8669/2 |only Druid
collect 2 Idol of War##20882 |q 8659/2 |only Hunter
collect 2 Idol of Death##20876 |q 8625/2 |only Mage
collect 2 Idol of Life##20879 |q 8630/2 |only Paladin
collect 2 Idol of Rebirth##20878 |q 8594/2 |only Priest
collect 2 Idol of the Sun##20874 |q 8641/2 |only Rogue
collect 2 Idol of Life##20879 |q 8602/2 |only Shaman
collect 2 Idol of the Sage##20877 |q 8664/2 |only Warlock
collect 2 Idol of Night##20875 |q 8544/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Gold Scarab##20859 |q 8669/3 |only Druid
collect 5 Crystal Scarab##20862 |q 8659/3 |only Hunter
collect 5 Stone Scarab##20858 |q 8625/3 |only Mage
collect 5 Gold Scarab##20859 |q 8630/3 |only Paladin
collect 5 Silver Scarab##20860 |q 8594/3 |only Priest
collect 5 Silver Scarab##20860 |q 8641/3 |only Rogue
collect 5 Gold Scarab##20859 |q 8602/3 |only Shaman
collect 5 Bronze Scarab##20861 |q 8664/3 |only Warlock
collect 5 Clay Scarab##20863 |q 8544/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Bone Scarab##20864 |q 8669/4 |only Druid
collect 5 Ivory Scarab##20865 |q 8659/4 |only Hunter
collect 5 Bronze Scarab##20861 |q 8625/4 |only Mage
collect 5 Crystal Scarab##20862 |q 8630/4 |only Paladin
collect 5 Ivory Scarab##20865 |q 8594/4 |only Priest
collect 5 Clay Scarab##20863 |q 8641/4 |only Rogue
collect 5 Crystal Scarab##20862 |q 8602/4 |only Shaman
collect 5 Bone Scarab##20864 |q 8664/4 |only Warlock
collect 5 Stone Scarab##20858 |q 8544/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Neutral_Reputation"
Reach Neutral Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Neutral |or
'|complete completedq(8669,8659,8625,8630,8594,8641,8602,8664,8544) |or
step
talk Andorgos##15502
|tip She is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
turnin Genesis Shoulderpads##8669 |only Druid
turnin Striker's Pauldrons##8659 |only Hunter
turnin Enigma Shoulderpads##8625 |only Mage
turnin Avenger's Pauldrons##8630 |only Paladin
turnin Mantle of the Oracle##8594 |only Priest
turnin Deathdealer's Spaulders##8641 |only Rogue
turnin Stormcaller's Pauldrons##8602 |only Shaman
turnin Doomcaller's Mantle##8664 |only Warlock
turnin Conqueror's Spaulders##8544 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Boots Quest",{
description="This guide will walk you through obtaining the Temple of Ahn'Qiraj class-specific boots.",
condition_end=function() return completedq(8665,8626,8634,8655,8596,8637,8621,8660,8559) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Kandrostrasz##15503
|tip He is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
accept Genesis Boots##8665 |only Druid
accept Striker's Footguards##8626 |only Hunter
accept Enigma Boots##8634 |only Mage
accept Avenger's Greaves##8655 |only Paladin
accept Footwraps of the Oracle##8596 |only Priest
accept Deathdealer's Boots##8637 |only Rogue
accept Stormcaller's Footguards##8621 |only Shaman
accept Doomcaller's Footwraps##8660 |only Warlock
accept Conqueror's Greaves##8559 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Neutral_Reputation"
step
collect 1 Qiraji Bindings of Dominance##20932 |q 8665/1 |only Druid
collect 1 Qiraji Bindings of Command##20928 |q 8626/1 |only Hunter
collect 1 Qiraji Bindings of Dominance##20932 |q 8634/1 |only Mage
collect 1 Qiraji Bindings of Dominance##20932 |q 8655/1 |only Paladin
collect 1 Qiraji Bindings of Command##20928 |q 8596/1 |only Priest
collect 1 Qiraji Bindings of Command##20928 |q 8637/1 |only Rogue
collect 1 Qiraji Bindings of Dominance##20932 |q 8621/1 |only Shaman
collect 1 Qiraji Bindings of Dominance##20932 |q 8660/1 |only Warlock
collect 1 Qiraji Bindings of Command##20928 |q 8559/1 |only Warrior
|tip This has a chance to drop from Princess Huhuran and Viscidus in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Idol of Rebirth##20878 |q 8665/2 |only Druid
collect 2 Idol of Life##20879 |q 8626/2 |only Hunter
collect 2 Idol of the Sun##20874 |q 8634/2 |only Mage
collect 2 Idol of the Sage##20877 |q 8655/2 |only Paladin
collect 2 Idol of Death##20876 |q 8596/2 |only Priest
collect 2 Idol of Strife##20881 |q 8637/2 |only Rogue
collect 2 Idol of the Sage##20877 |q 8621/2 |only Shaman
collect 2 Idol of Night##20875 |q 8660/2 |only Warlock
collect 2 Idol of War##20882 |q 8559/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Stone Scarab##20858 |q 8665/3 |only Druid
collect 5 Stone Scarab##20858 |q 8626/3 |only Hunter
collect 5 Silver Scarab##20860 |q 8634/3 |only Mage
collect 5 Bronze Scarab##20861 |q 8655/3 |only Paladin
collect 5 Bronze Scarab##20861 |q 8596/3 |only Priest
collect 5 Crystal Scarab##20862 |q 8637/3 |only Rogue
collect 5 Bronze Scarab##20861 |q 8621/3 |only Shaman
collect 5 Clay Scarab##20863 |q 8660/3 |only Warlock
collect 5 Ivory Scarab##20865 |q 8559/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Silver Scarab##20860 |q 8665/4 |only Druid
collect 5 Bone Scarab##20864 |q 8626/4 |only Hunter
collect 5 Crystal Scarab##20862 |q 8634/4 |only Mage
collect 5 Clay Scarab##20863 |q 8655/4 |only Paladin
collect 5 Gold Scarab##20859 |q 8596/4 |only Priest
collect 5 Bone Scarab##20864 |q 8637/4 |only Rogue
collect 5 Clay Scarab##20863 |q 8621/4 |only Shaman
collect 5 Ivory Scarab##20865 |q 8660/4 |only Warlock
collect 5 Gold Scarab##20859 |q 8559/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Neutral_Reputation"
Reach Neutral Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Neutral |or
'|complete completedq(8665,8626,8634,8655,8596,8637,8621,8660,8559) |or
step
talk Kandrostrasz##15503
|tip He is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
turnin Genesis Boots##8665 |only Druid
turnin Striker's Footguards##8626 |only Hunter
turnin Enigma Boots##8634 |only Mage
turnin Avenger's Greaves##8655 |only Paladin
turnin Footwraps of the Oracle##8596 |only Priest
turnin Deathdealer's Boots##8637 |only Rogue
turnin Stormcaller's Footguards##8621 |only Shaman
turnin Doomcaller's Footwraps##8660 |only Warlock
turnin Conqueror's Greaves##8559 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Helm Quest",{
description="This guide will walk you through obtaining the Temple of Ahn'Qiraj class-specific helm.",
condition_end=function() return completedq(8667,8657,8632,8628,8592,8639,8623,8662,8561) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Andorgos##15502
|tip She is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
accept Genesis Helm##8667 |only Druid
accept Striker's Diadem##8657 |only Hunter
accept Enigma Circlet##8632 |only Mage
accept Avenger's Crown##8628 |only Paladin
accept Tiara of the Oracle##8592 |only Priest
accept Deathdealer's Helm##8639 |only Rogue
accept Stormcaller's Diadem##8623 |only Shaman
accept Doomcaller's Circlet##8662 |only Warlock
accept Conqueror's Crown##8561 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Friendly_Reputation"
step
collect 1 Vek'lor's Diadem##20930 |q 8667/1 |only Druid
collect 1 Vek'lor's Diadem##20930 |q 8657/1 |only Hunter
collect 1 Vek'nilash's Circlet##20926 |q 8632/1 |only Mage
collect 1 Vek'lor's Diadem##20930 |q 8628/1 |only Paladin
collect 1 Vek'nilash's Circlet##20926 |q 8592/1 |only Priest
collect 1 Vek'lor's Diadem##20930 |q 8639/1 |only Rogue
collect 1 Vek'lor's Diadem##20930 |q 8623/1 |only Shaman
collect 1 Vek'nilash's Circlet##20926 |q 8662/1 |only Warlock
collect 1 Vek'nilash's Circlet##20926 |q 8561/1 |only Warrior
|tip This has a chance to drop from Emperor Vek'lor and Emperor Vek'nilash in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Idol of Life##20879 |q 8667/2 |only Druid
collect 2 Idol of Strife##20881 |q 8657/2 |only Hunter
collect 2 Idol of Night##20875 |q 8632/2 |only Mage
collect 2 Idol of Rebirth##20878 |q 8628/2 |only Paladin
collect 2 Idol of the Sage##20877 |q 8592/2 |only Priest
collect 2 Idol of War##20882 |q 8639/2 |only Rogue
collect 2 Idol of Rebirth##20878 |q 8623/2 |only Shaman
collect 2 Idol of Death##20876 |q 8662/2 |only Warlock
collect 2 Idol of the Sun##20874 |q 8561/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Gold Scarab##20859 |q 8667/3 |only Druid
collect 5 Bronze Scarab##20861 |q 8657/3 |only Hunter
collect 5 Bronze Scarab##20861 |q 8632/3 |only Mage
collect 5 Stone Scarab##20858 |q 8628/3 |only Paladin
collect 5 Silver Scarab##20860 |q 8592/3 |only Priest
collect 5 Clay Scarab##20863 |q 8639/3 |only Rogue
collect 5 Stone Scarab##20858 |q 8623/3 |only Shaman
collect 5 Silver Scarab##20860 |q 8662/3 |only Warlock
collect 5 Crystal Scarab##20862 |q 8561/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Clay Scarab##20863 |q 8667/4 |only Druid
collect 5 Ivory Scarab##20865 |q 8657/4 |only Hunter
collect 5 Ivory Scarab##20865 |q 8632/4 |only Mage
collect 5 Crystal Scarab##20862 |q 8628/4 |only Paladin
collect 5 Bone Scarab##20864 |q 8592/4 |only Priest
collect 5 Gold Scarab##20859 |q 8639/4 |only Rogue
collect 5 Crystal Scarab##20862 |q 8623/4 |only Shaman
collect 5 Bone Scarab##20864 |q 8662/4 |only Warlock
collect 5 Stone Scarab##20858 |q 8561/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Friendly_Reputation"
Reach Friendly Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Friendly |or
'|complete completedq(8667,8657,8632,8628,8592,8639,8623,8662,8561) |or
step
talk Andorgos##15502
|tip She is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
turnin Genesis Helm##8667 |only Druid
turnin Striker's Diadem##8657 |only Hunter
turnin Enigma Circlet##8632 |only Mage
turnin Avenger's Crown##8628 |only Paladin
turnin Tiara of the Oracle##8592 |only Priest
turnin Deathdealer's Helm##8639 |only Rogue
turnin Stormcaller's Diadem##8623 |only Shaman
turnin Doomcaller's Circlet##8662 |only Warlock
turnin Conqueror's Crown##8561 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Legs Quest",{
description="This guide will walk you through obtaining the Temple of Ahn'Qiraj class-specific legs.",
condition_end=function() return completedq(8668,8658,8631,8629,8593,8640,8624,8663,8560) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Kandrostrasz##15503
|tip He is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
accept Genesis Trousers##8668 |only Druid
accept Striker's Leggings##8658 |only Hunter
accept Enigma Leggings##8631 |only Mage
accept Avenger's Legguards##8629 |only Paladin
accept Trousers of the Oracle##8593 |only Priest
accept Deathdealer's Leggings##8640 |only Rogue
accept Stormcaller's Leggings##8624 |only Shaman
accept Doomcaller's Trousers##8663 |only Warlock
accept Conqueror's Legguards##8560 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Friendly_Reputation"
step
collect 1 Skin of the Great Sandworm##20931 |q 8668/1 |only Druid
collect 1 Skin of the Great Sandworm##20931 |q 8658/1 |only Hunter
collect 1 Ouro's Intact Hide##20927 |q 8631/1 |only Mage
collect 1 Skin of the Great Sandworm##20931 |q 8629/1 |only Paladin
collect 1 Ouro's Intact Hide##20927 |q 8593/1 |only Priest
collect 1 Ouro's Intact Hide##20927 |q 8640/1 |only Rogue
collect 1 Skin of the Great Sandworm##20931 |q 8624/1 |only Shaman
collect 1 Skin of the Great Sandworm##20931 |q 8663/1 |only Warlock
collect 1 Ouro's Intact Hide##20927 |q 8560/1 |only Warrior
|tip This has a chance to drop from Ouro in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Idol of War##20882 |q 8668/2 |only Druid
collect 2 Idol of the Sun##20874 |q 8658/2 |only Hunter
collect 2 Idol of the Sage##20877 |q 8631/2 |only Mage
collect 2 Idol of Strife##20881 |q 8629/2 |only Paladin
collect 2 Idol of Life##20879 |q 8593/2 |only Priest
collect 2 Idol of Night##20875 |q 8640/2 |only Rogue
collect 2 Idol of Strife##20881 |q 8624/2 |only Shaman
collect 2 Idol of Rebirth##20878 |q 8663/2 |only Warlock
collect 2 Idol of Death##20876 |q 8560/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Stone Scarab##20858 |q 8668/3 |only Druid
collect 5 Silver Scarab##20860 |q 8658/3 |only Hunter
collect 5 Silver Scarab##20860 |q 8631/3 |only Mage
collect 5 Ivory Scarab##20865 |q 8629/3 |only Paladin
collect 5 Gold Scarab##20859 |q 8593/3 |only Priest
collect 5 Stone Scarab##20858 |q 8640/3 |only Rogue
collect 5 Ivory Scarab##20865 |q 8624/3 |only Shaman
collect 5 Gold Scarab##20859 |q 8663/3 |only Warlock
collect 5 Bronze Scarab##20861 |q 8560/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Crystal Scarab##20862 |q 8668/4 |only Druid
collect 5 Bone Scarab##20864 |q 8658/4 |only Hunter
collect 5 Bone Scarab##20864 |q 8631/4 |only Mage
collect 5 Bronze Scarab##20861 |q 8629/4 |only Paladin
collect 5 Clay Scarab##20863 |q 8593/4 |only Priest
collect 5 Crystal Scarab##20862 |q 8640/4 |only Rogue
collect 5 Bronze Scarab##20861 |q 8624/4 |only Shaman
collect 5 Clay Scarab##20863 |q 8663/4 |only Warlock
collect 5 Ivory Scarab##20865 |q 8560/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Friendly_Reputation"
Reach Friendly Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Friendly |or
'|complete completedq(8668,8658,8631,8629,8593,8640,8624,8663,8560) |or
step
talk Kandrostrasz##15503
|tip He is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
turnin Genesis Trousers##8668 |only Druid
turnin Striker's Leggings##8658 |only Hunter
turnin Enigma Leggings##8631 |only Mage
turnin Avenger's Legguards##8629 |only Paladin
turnin Trousers of the Oracle##8593 |only Priest
turnin Deathdealer's Leggings##8640 |only Rogue
turnin Stormcaller's Leggings##8624 |only Shaman
turnin Doomcaller's Trousers##8663 |only Warlock
turnin Conqueror's Legguards##8560 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Temple of Ahn'Qiraj Chest Quest",{
description="This guide will walk you through obtaining the Temple of Ahn'Qiraj class-specific chest.",
condition_end=function() return completedq(8666,8656,8633,8627,8603,8638,8622,8661,8562) end,
},[[
step
Reach Level 60 |ding 60
|tip Use the leveling guides to accomplish this.
step
talk Vethsera##15504
|tip She is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
accept Genesis Vest##8666 |only Druid
accept Striker's Hauberk##8656 |only Hunter
accept Enigma Robes##8633 |only Mage
accept Avenger's Breastplate##8627 |only Paladin
accept Vestments of the Oracle##8603 |only Priest
accept Deathdealer's Vest##8638 |only Rogue
accept Stormcaller's Hauberk##8622 |only Shaman
accept Doomcaller's Robes##8661 |only Warlock
accept Conqueror's Breastplate##8562 |only Warrior
stickystart "Collect_Idols"
stickystart "Collect_First_Scarab_Set"
stickystart "Collect_Second_Scarab_Set"
stickystart "Reach_Honored_Reputation"
step
collect 1 Husk of the Old God##20933 |q 8666/1 |only Druid
collect 1 Carapace of the Old God##20929 |q 8656/1 |only Hunter
collect 1 Husk of the Old God##20933 |q 8633/1 |only Mage
collect 1 Carapace of the Old God##20929 |q 8627/1 |only Paladin
collect 1 Husk of the Old God##20933 |q 8603/1 |only Priest
collect 1 Carapace of the Old God##20929 |q 8638/1 |only Rogue
collect 1 Carapace of the Old God##20929 |q 8622/1 |only Shaman
collect 1 Husk of the Old God##20933 |q 8661/1 |only Warlock
collect 1 Carapace of the Old God##20929 |q 8562/1 |only Warrior
|tip This has a chance to drop from C'Thun in the Ruins of Ahn'Qiraj raid.
step
label "Collect_Idols"
collect 2 Idol of Rebirth##20878 |q 8666/2 |only Druid
collect 2 Idol of Life##20879 |q 8656/2 |only Hunter
collect 2 Idol of the Sun##20874 |q 8633/2 |only Mage
collect 2 Idol of the Sage##20877 |q 8627/2 |only Paladin
collect 2 Idol of Death##20876 |q 8603/2 |only Priest
collect 2 Idol of Strife##20881 |q 8638/2 |only Rogue
collect 2 Idol of the Sage##20877 |q 8622/2 |only Shaman
collect 2 Idol of Night##20875 |q 8661/2 |only Warlock
collect 2 Idol of War##20882 |q 8562/2 |only Warrior
|tip These have a chance to drop from trash mobs and Scarab Coffers in the Ruins of Ahn'Qiraj raid.
step
label "Collect_First_Scarab_Set"
collect 5 Bronze Scarab##20861 |q 8666/3 |only Druid
collect 5 Gold Scarab##20859 |q 8656/3 |only Hunter
collect 5 Gold Scarab##20859 |q 8633/3 |only Mage
collect 5 Silver Scarab##20860 |q 8627/3 |only Paladin
collect 5 Stone Scarab##20858 |q 8603/3 |only Priest
collect 5 Bronze Scarab##20861 |q 8638/3 |only Rogue
collect 5 Silver Scarab##20860 |q 8622/3 |only Shaman
collect 5 Crystal Scarab##20862 |q 8661/3 |only Warlock
collect 5 Silver Scarab##20860 |q 8562/3 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Collect_Second_Scarab_Set"
collect 5 Ivory Scarab##20865 |q 8666/4 |only Druid
collect 5 Clay Scarab##20863 |q 8656/4 |only Hunter
collect 5 Clay Scarab##20863 |q 8633/4 |only Mage
collect 5 Bone Scarab##20864 |q 8627/4 |only Paladin
collect 5 Crystal Scarab##20862 |q 8603/4 |only Priest
collect 5 Ivory Scarab##20865 |q 8638/4 |only Rogue
collect 5 Bone Scarab##20864 |q 8622/4 |only Shaman
collect 5 Stone Scarab##20858 |q 8661/4 |only Warlock
collect 5 Bone Scarab##20864 |q 8562/4 |only Warrior
|tip These have a chance to drop from trash mobs in the Ruins of Ahn'Qiraj and Temple of Ahn'Qiraj raids.
step
label "Reach_Honored_Reputation"
Reach Honored Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Honored |or
'|complete completedq(8666,8656,8633,8627,8603,8638,8622,8661,8562) |or
step
talk Vethsera##15504
|tip She is located inside the Temple of Ahn'Qiraj raid.
|tip After killing The Prophet Skeram, run up the stairs and into the left-side alcove inside the temple entrance.
accept Genesis Vest##8666 |only Druid
accept Striker's Hauberk##8656 |only Hunter
accept Enigma Robes##8633 |only Mage
accept Avenger's Breastplate##8627 |only Paladin
accept Vestments of the Oracle##8603 |only Priest
accept Deathdealer's Vest##8638 |only Rogue
accept Stormcaller's Hauberk##8622 |only Shaman
accept Doomcaller's Robes##8661 |only Warlock
accept Conqueror's Breastplate##8562 |only Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Scepter of the Shifting Sands",{
description="This guide will walk you through completing the Scepter of the Shifting Sands questline.",
condition_end=function() return completedq(8745) end,
},[[
step
talk Baristolth of the Shifting Sands##15180
accept What Tomorrow Brings##8286 |goto Silithus 49.45,36.45
step
Follow the path |goto Tanaris 61.19,50.58 < 75 |only if walking
Discover the Brood of Nozdormu |q 8286/1 |goto Tanaris 64.24,50.26
step
talk Baristolth of the Shifting Sands##15180
turnin What Tomorrow Brings##8286 |goto Silithus 49.45,36.45
accept Only One May Rise##8288 |goto Silithus 49.45,36.45
step
kill Broodlord Lashlayer##12017
|tip It's the third boss in the Blackwing Lair raid.
|tip You will need a raid group for this.
collect 1 Head of the Broodlord Lashlayer##20383 |q 8288/1
step
talk Baristolth of the Shifting Sands##15180
turnin Only One May Rise##8288 |goto Silithus 49.45,36.45
accept The Path of the Righteous##8301 |goto Silithus 49.45,36.45
stickystart "Reach_Neutral_With_Brood_Of_Nozdormu"
step
Kill Silithid enemies around this area
|tip They look like large bugs.
|tip These enemies are elite and may require a group to kill.
collect 200 Silithid Carapace Fragment##20384 |q 8301/1 |goto Silithus 45.22,26.25
You can find more around:
[25.15,59.22]
[57.64,81.91]
step
talk Baristolth of the Shifting Sands##15180
turnin The Path of the Righteous##8301 |goto Silithus 49.45,36.45
step
label "Accept_The_Hand_of_the_Righteous"
talk Baristolth of the Shifting Sands##15180
accept The Hand of the Righteous##8302 |goto Silithus 49.45,36.45 |or
'|complete rep("Brood of Nozdormu") >= Neutral |or
step
Kill Silithid enemies around this area
|tip They look like large bugs.
|tip These enemies are elite and may require a group to kill.
|tip You will repeat this quest until neutral with the Brood of Nozdormu faction.
|tip This requires around 41,400 carapace fragments, so it's best to find a group.
collect 200 Silithid Carapace Fragment##20384 |q 8302/1 |goto Silithus 45.22,26.25 |or
You can find more around:
[25.15,59.22]
[57.64,81.91]
'|complete rep("Brood of Nozdormu") >= Neutral |or
step
talk Baristolth of the Shifting Sands##15180
turnin The Hand of the Righteous##8302 |goto Silithus 49.45,36.45 |next "Accept_The_Hand_of_the_Righteous" |or
|tip Each time you turn in this quest you will receive a "Proxy of Nozdormu" item.
|tip Target a friend and use the item to deputize them so they can collect carapace fragments as well.
|tip You must use or destroy your previous "Proxy of Nozdormu" before you can complete this quest.
'|complete rep("Brood of Nozdormu") >= Neutral |or
step
label "Reach_Neutral_With_Brood_Of_Nozdormu"
Reach Neutral Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Neutral
step
talk Baristolth of the Shifting Sands##15180
accept Anachronos##8303 |goto Silithus 49.45,36.45
step
talk Anachronos##15192
turnin Anachronos##8303 |goto Tanaris 65.27,50.03
accept Long Forgotten Memories##8305 |goto Tanaris 65.27,50.03
step
click Crystalline Tear
|tip It's a small red crystal on the ground.
turnin Long Forgotten Memories##8305 |goto Silithus 28.67,89.14
accept A Pawn on the Eternal Board##8519 |goto Silithus 28.67,89.14
step
talk Anachronos##15192
turnin A Pawn on the Eternal Board##8519 |goto Tanaris 65.27,50.03
accept The Charge of the Dragonflights##8555 |goto Tanaris 65.27,50.03
step
talk Anachronos##15192
turnin The Charge of the Dragonflights##8555 |goto Tanaris 65.27,50.03
stickystart "Collect_Deeprock_Salt"
stickystart "Collect_Arcanite_Bar"
stickystart "Collect_Elementium_Ore"
stickystart "Collect_Azerothian_Diamond"
stickystart "Collect_Blue_Sapphire"
step
_Collect the Following Items:_
collect 20 Goblin Rocket Fuel##9061 |q 8586 |future
|tip These are required to complete the quest "Dirge's Kickin' Chimaerok Chops." |notinsticky
|tip You can create them with Alchemy or purchase them from the Auction House. |only if not selfmade()
|tip You can create them with Alchemy. |only if selfmade()
|tip Each one requires one Firebloom, one Volatile Rum, and one Leaded Vial to craft.
step
label "Collect_Deeprock_Salt"
_Collect the Following Items:_ |notinsticky
Kill Rock Elemental enemies around this area
collect 20 Deeprock Salt##8150 |goto Badlands 14.16,39.38 |q 8586 |future
|tip You can also purchase these from the Auction House. |only if not selfmade()
|tip These are required to complete the quest "Dirge's Kickin' Chimaerok Chops." |notinsticky
step
label "Collect_Arcanite_Bar"
_Collect the Following Items:_ |notinsticky
collect 20 Arcanite Bar##12360 |q 8728 |future
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip You can create them with Alchemy or purchase them from the Auction House. |only if not selfmade()
|tip You can create them with Alchemy. |only if selfmade()
|tip Each one requires one Arcane Crystal and one Thorium Bar to craft.
step
label "Collect_Elementium_Ore"
_Collect the Following Items:_ |notinsticky
kill Blackwing Technician##13996+
|tip These spawn and flee from Vaelastrasz the Corrupt's room in Blackwing Lair.
|tip You must kill them quickly before they flee to safety.
collect 10 Elementium Ore##18562 |q 8728 |future
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip You can also purchase these from the Auction House. |only if not selfmade()
step
label "Collect_Azerothian_Diamond"
_Collect the Following Items:_ |notinsticky
collect 10 Azerothian Diamond##12800 |q 8728 |future
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip These can be mined from any type of Thorium Vein.
|tip They can also be contained inside Gray Sacks of Gems dropped by Onyxia, Nefarian, and the various World Bosses.
step
label "Collect_Blue_Sapphire"
_Collect the Following Items:_ |notinsticky
collect 10 Blue Sapphire##12361 |q 8728 |future
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip These can be mined from any type of Thorium Vein.
|tip They can also be contained inside Gray Sacks of Gems dropped by Onyxia, Nefarian, and the various World Bosses.
step
talk Spirit of Azuregos##15481
|tip He walks all over the area.
|tip You will need to search around.
|tip Make sure you talk to the spirit version.
Select _"How did you know? I mean, yes... Yes I am looking for that shard. Do you have it?"_
collect 1 Magical Ledger##20949 |goto Azshara 55.58,79.77
step
use the Magical Ledger##20949
accept Azuregos's Magical Ledger##8575
step
talk Narain Soothfancy##11811
|tip Inside the building.
turnin Azuregos's Magical Ledger##8575 |goto Tanaris 65.24,18.58
step
talk Narain Soothfancy##11811
|tip Inside the building.
accept Translating the Ledger##8576 |goto Tanaris 65.24,18.58
step
talk Narain Soothfancy##11811
|tip Inside the building.
turnin Translating the Ledger##8576 |goto Tanaris 65.24,18.58
step
talk Narain Soothfancy##11811
|tip Inside the building.
accept Stewvul, Ex-B.F.F.##8577 |goto Tanaris 65.24,18.58
accept Never Ask Me About My Business##8584 |goto Tanaris 65.24,18.58
accept Draconic for Dummies##8597 |goto Tanaris 65.24,18.58
step
talk Meridith the Mermaiden##15526
|tip Underwater.
accept Love Song for Narain##8599 |goto Tanaris 59.43,96.04
step
talk Narain Soothfancy##11811
|tip Inside the building.
turnin Love Song for Narain##8599 |goto Tanaris 65.24,18.58
step
talk Meridith the Mermaiden##15526
|tip Underwater.
Select _"That would be wonderful! Thank you, Merideth."_
Gain the "Siren's Song" Buff |havebuff Siren's Song##25678 |goto Tanaris 59.43,96.04 |q 8597
step
click Freshly Dug Dirt
|tip Quickly swim southeast to the pair of secret islands.
|tip The buff will expire in three minutes.
|tip On the island south of the metal rig.
turnin Draconic for Dummies##8597
accept rAnS0m##8598
step
talk Narain Soothfancy##11811
|tip Inside the building.
turnin rAnS0m##8598 |goto Tanaris 65.24,18.58
accept Decoy!##8606 |goto Tanaris 65.24,18.58
step
talk Dirge Quikcleave##8125
|tip Inside the building.
turnin Never Ask Me About My Business##8584 |goto Tanaris 52.63,28.12
accept The Isle of Dread!##8585 |goto Tanaris 52.63,28.12
stickystart "Kill_Number_Two"
step
Cross the bridge |goto Winterspring 61.24,74.20 < 50 |only if walking
Follow the path |goto Winterspring 63.43,72.69 < 40 |only if walking
Follow the path up |goto Winterspring 66.02,72.69 < 40 |only if walking
use Narain's Special Kit##21042
Open Narain's Special Kit |complete itemcount(21042) == 0 |goto Winterspring 67.55,72.84 |q 8606
step
use Narain's Turban##21039
Transform into Narain Soothfancy |havebuff Narain!##25688 |goto Winterspring 67.55,72.84 |q 8606
step
use the Bag of Gold##21041
Place the Bag of Loot |complete itemcount(21041) == 0 |goto Winterspring 67.55,72.84 |q 8606
|tip Placing the Bag of Loot will summon Number Two.
step
label "Kill_Number_Two"
Watch the dialogue |notinsticky
kill Number Two##15554 |q 8606/1 |goto Winterspring 67.23,72.60
|tip You will need a group of at least three people to kill it.
stickystart "Collect_Chimaerok_Tenderloin"
step
Follow the path up |goto Feralas 34.14,77.78 < 50 |only if walking
kill Lord Lakmaeran##12803
|tip You will need a group for this, preferrably at least ten people.
collect 1 Lakmaeran's Carcass##21027 |q 8585/1 |goto Feralas 29.34,72.63
step
label "Collect_Chimaerok_Tenderloin"
Kill Chimaerok enemies around this area
|tip You will need a group for this, preferrably at least ten people. |notinsticky
collect 20 Chimaerok Tenderloin##21024 |q 8585/2 |goto Feralas 28.51,74.88
step
talk Dirge Quikcleave##8125
|tip Inside the building.
turnin The Isle of Dread!##8585 |goto Tanaris 52.63,28.12
accept Dirge's Kickin' Chimaerok Chops##8586 |goto Tanaris 52.63,28.12
step
talk Narain Soothfancy##11811
|tip Inside the building.
turnin Decoy!##8606 |goto Tanaris 65.24,18.58
accept The Only Prescription##8620 |goto Tanaris 65.24,18.58
step
Enter the building |goto Dustwallow Marsh 77.25,17.41
kill Doctor Weavil##15552
|tip Upstairs inside the building.
|tip You will need a sizeable group to kill him.
collect 1 Draconic for Dummies##21103 |goto Dustwallow Marsh 77.85,17.12 |q 8620
step
kill Onyxia##10184
|tip Inside Onxyia's Lair.
collect 2 Draconic for Dummies##21103 |goto Kalimdor 56.58,71.55 |q 8620
step
Cross the bridge |goto Winterspring 62.43,67.46 < 50 |only if walking
Kill enemies around this area
collect 3 Draconic for Dummies##21103 |goto Winterspring 60.59,78.67 |q 8620
|tip Any elite demon in Darkwhisper Gorge can drop this.
step
click Draconic for Dummies
|tip You will need a group or stealth to survive the opposing faction's city. |only Alliance
collect 8 Draconic for Dummies##21103 |goto Undercity 77.05,38.93 |q 8620
step
click Inconspicuous Crate
turnin Stewvul, Ex-B.F.F.##8577 |goto Silverpine Forest 46.19,86.67
accept Scrying Goggles? No Problem!##8578 |goto Silverpine Forest 46.19,86.67
step
Kill Rock Elemental enemies around this area
collect 20 Deeprock Salt##8150 |q 8586/2 |goto Badlands 14.16,39.38
|tip You can also purchase these from the Auction House. |only if not selfmade()
step
kill Ebonroc##14601
|tip It is the fifth boss of the Blackwing Lair raid.
collect 6 Draconic for Dummies##21103 |q 8620
stickystart "Collect_Draconic_Scrying_Goggles"
step
kill Ragnaros##11502
|tip He is the final boss of the Molten Core raid.
collect 5 Draconic for Dummies##21103 |q 8620
step
label "Collect_Draconic_Scrying_Goggles"
Kill enemies inside Molten Core
collect 1 Narain's Scrying Goggles##20951 |q 8578/1
|tip These goggles have a chance to drop from trash mobs inside the Molten Core raid.
step
Enter Stormwind Keep |goto Stormwind City 73.35,46.40 < 20 |only if walking
click Draconic for Dummies
|tip You will need a group or stealth to survive the opposing faction's city. |only Horde
|tip It's the open book on the corner of the statue.
Choose _<Take this book for the good of Azeroth!>_
collect 7 Draconic for Dummies##21103 |goto Stormwind City 75.36,29.76 |q 8620
step
Watch the dialogue
talk Malfurion Stormrage##15362
|tip Inside the Sunken Temple dungeon.
|tip He will appear in front of Shade of Eranikus when you walk near.
accept Eranikus, Tyrant of the Dream##8733
step
Kill enemies around this area
collect 4 Draconic for Dummies##21103 |goto Blasted Lands 44.40,56.63 |q 8620
|tip Any elite demon in The Tainted Scar can drop this.
step
talk Forest Wisp##15624
turnin Eranikus, Tyrant of the Dream##8733 |goto Teldrassil 37.56,47.93
accept Tyrande and Remulos##8734 |goto Teldrassil 37.56,47.93
step
talk Keeper Remulos##11832
turnin Tyrande and Remulos##8734 |goto Moonglade 36.19,41.81
accept The Nightmare's Corruption##8735 |goto Moonglade 36.19,41.81
step
Follow the path |goto Ashenvale 89.00,41.02 < 50 |only if walking
Kill Emeraldon enemies around this area
|tip You will need a group for this.
collect 1 Fragment of the Nightmare's Corruption##21147 |goto Ashenvale 93.61,39.65 |q 8735/1
step
Kill Jademir enemies around this area
|tip You will need a group for this.
collect 1 Fragment of the Nightmare's Corruption##21148 |goto Feralas 50.70,12.50 |q 8735/3
step
Follow the path up |goto Duskwood 47.36,61.77 < 40 |only if walking
Enter the Twilight Grove |goto Duskwood 46.49,55.22 < 30 |only if walking
kill Twilight Corrupter##15625
|tip You will need a group for this.
collect 1 Fragment of the Nightmare's Corruption##21149 |goto Duskwood 48.98,34.39 |q 8735/2
step
Cross the bridge |goto The Hinterlands 60.64,38.41 < 20 |only if walking
Kill Verdantine enemies around this area
|tip You will need a group for this.
collect 1 Fragment of the Nightmare's Corruption##21146 |goto The Hinterlands 62.91,30.32 |q 8735/4
step
talk Keeper Remulos##11832
turnin The Nightmare's Corruption##8735 |goto Moonglade 36.19,41.81
accept The Nightmare Manifests##8736 |goto Moonglade 36.19,41.81
step
Defend Nighthaven from Eranikus |q 8736/1 |goto Moonglade 48.04,34.31
|tip You will need a raid to accomplish this.
|tip You cannot let Keeper Remulos die or kill Eranikus.
step
talk Keeper Remulos##11832
turnin The Nightmare Manifests##8736 |goto Moonglade 36.19,41.81
accept The Champion Returns##8741 |goto Moonglade 36.19,41.81
step
collect 20 Goblin Rocket Fuel##9061 |q 8586/1
|tip You can create them with Alchemy or purchase them from the Auction House. |only if not selfmade()
|tip You can create them with Alchemy. |only if selfmade()
|tip Each one requires one Firebloom, one Volatile Rum, and one Leaded Vial to craft.
step
talk Dirge Quikcleave##8125
|tip Inside the building.
turnin Dirge's Kickin' Chimaerok Chops##8586 |goto Tanaris 52.63,28.12
accept Return to Narain##8587 |goto Tanaris 52.63,28.12
step
use the Magical Book Binding##21112
collect 1 Draconic For Dummies: Volume II##21111 |q 8620/1
step
talk Narain Soothfancy##11811
|tip Inside the building.
turnin Scrying Goggles? No Problem!##8578 |goto Tanaris 65.24,18.58
turnin Return to Narain##8587 |goto Tanaris 65.24,18.58
turnin The Only Prescription##8620 |goto Tanaris 65.24,18.58
step
talk Anachronos##15192
turnin The Champion Returns##8741 |goto Tanaris 65.27,50.03
step
talk Vaelastrasz the Corrupt##13020
|tip The second boss inside the Blackwing Lair raid.
accept Nefarius's Corruption##8730
|tip You will only have five hours to kill Nefarian, collect the Red Scepter Shard, and turn in this quest.
step
kill Nefarian##11583
|tip He is the final boss inside the Blackwing Lair raid.
|tip You must kill him and turn in this quest within the five hour time limit.
collect 1 Red Scepter Shard##21138
|tip Only one person in the raid can loot this item per reset.
step
talk Anachronos##15192
turnin Nefarius's Corruption##8730 |goto Tanaris 65.27,50.03
|tip You must turn in this quest within the five hour time limit.
step
talk Narain Soothfancy##11811
|tip Inside the building.
accept The Good News and The Bad News##8728 |goto Tanaris 65.24,18.58
stickystart "Collect_Elementium_Ores"
stickystart "Collect_Azerothian_Diamonds"
stickystart "Collect_Blue_Sapphires"
step
_Collect the Following Items:_ |notinsticky
collect 20 Arcanite Bar##12360 |q 8728/1
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip You can create them with Alchemy or purchase them from the Auction House. |only if not selfmade()
|tip You can create them with Alchemy. |only if selfmade()
|tip Each one requires one Arcane Crystal and one Thorium Bar to craft.
step
label "Collect_Elementium_Ores"
_Collect the Following Items:_ |notinsticky
kill Blackwing Technician##13996+
|tip These spawn and flee from Vaelastrasz the Corrupt's room in Blackwing Lair.
|tip You must kill them quickly before they flee to safety.
collect 10 Elementium Ore##18562 |q 8728/2
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip You can also purchase these from the Auction House. |only if not selfmade()
step
label "Collect_Azerothian_Diamonds"
_Collect the Following Items:_ |notinsticky
collect 10 Azerothian Diamond##12800 |q 8728/3
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip These can be mined from any type of Thorium Vein.
|tip They can also be contained inside Gray Sacks of Gems dropped by Onyxia, Nefarian, and the various World Bosses.
step
label "Collect_Blue_Sapphires"
_Collect the Following Items:_ |notinsticky
collect 10 Blue Sapphire##12361 |q 8728/4
|tip These are required to complete the quest "The Good News and The Bad News." |notinsticky
|tip These can be mined from any type of Thorium Vein.
|tip They can also be contained inside Gray Sacks of Gems dropped by Onyxia, Nefarian, and the various World Bosses.
step
talk Narain Soothfancy##11811
|tip Inside the building.
turnin The Good News and The Bad News##8728 |goto Tanaris 65.24,18.58
accept The Wrath of Neptulon##8729 |goto Tanaris 65.24,18.58
step
use the Arcanite Buoy##21136
kill Maws##15571
|tip Using the buoy will summon it.
|tip You will need a raid to defeat it.
collect 1 Blue Scepter Shard##21137 |goto Azshara 65.88,54.05
step
talk Anachronos##15192
turnin The Wrath of Neptulon##8729 |goto Tanaris 65.27,50.03
step
talk Anachronos##15192
accept The Might of Kalimdor##8742 |goto Tanaris 65.27,50.03
step
click The Scarab Gong##180717
accept Bang a Gong!##8743 |goto Silithus 25.71,90.86
step
click The Scarab Gong##180717
turnin Bang a Gong!##8743 |goto Silithus 25.71,90.86
step
talk Jonathan the Revelator##15693
accept Treasure of the Timeless One##8745 |goto Silithus 25.94,90.96
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Signet Ring of the Bronze Dragonflight",{
description="This guide will walk you through acquiring and upgrading a Signet Ring of the Bronze Dragonflight.",
condition_end=function() return completedq(8761,8751,8756,8765,8764,8766) end,
},[[
step
Reach Neutral Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Neutral |or
|tip Killing trash and bosses inside the "Temple of Ahn'Qiraj" and "Ruins of Ahn'Qiraj" raids grants reputation.
|tip Completing the repeatable quest "The Hand of the Righteous" in Cenarion Hold also grants reputation.
|tip You can gain reputation by completing Ahn'Qiraj raid quests and the Scepter of the Shifting Sands questline too.
'|complete completedq(8757,8747,8752) |or
step
_Choose a path:_
|tip Accepting one of these quests will lock you into that questline until you complete it.
|tip You can switch to a different ring after you complete your first questline.
talk Anachronos##15192
accept The Path of the Invoker##8757 |goto Tanaris 65.27,50.03 |noautoaccept |or
|tip This quest grants an intellect-based caster ring.
accept The Path of the Protector##8747 |goto Tanaris 65.27,50.03 |noautoaccept |or
|tip This quest grants a strength-based defensive ring.
accept The Path of the Conqueror##8752 |goto Tanaris 65.27,50.03 |noautoaccept |or
|tip This quest grants an agility-based offensive ring.
step
Reach Friendly Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Friendly |or
|tip Killing trash and bosses inside the "Temple of Ahn'Qiraj" and "Ruins of Ahn'Qiraj" raids grants reputation.
|tip Completing the repeatable quest "The Hand of the Righteous" in Cenarion Hold also grants reputation.
|tip You can gain reputation by completing Ahn'Qiraj raid quests and the Scepter of the Shifting Sands questline too.
'|complete completedq(8758,8748,8753) |or
step
talk Anachronos##15192
accept The Path of the Invoker##8758 |goto Tanaris 65.27,50.03 |only if completedq(8757)
accept The Path of the Protector##8748 |goto Tanaris 65.27,50.03 |only if completedq(8747)
accept The Path of the Conqueror##8753 |goto Tanaris 65.27,50.03 |only if completedq(8752)
step
Reach Honored Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Honored |or
|tip Killing trash and bosses inside the "Temple of Ahn'Qiraj" and "Ruins of Ahn'Qiraj" raids grants reputation.
|tip Completing the repeatable quest "The Hand of the Righteous" in Cenarion Hold also grants reputation.
|tip You can gain reputation by completing Ahn'Qiraj raid quests and the Scepter of the Shifting Sands questline too.
'|complete completedq(8759,8749,8754) |or
step
talk Anachronos##15192
accept The Path of the Invoker##8759 |goto Tanaris 65.27,50.03 |only if completedq(8757)
accept The Path of the Protector##8749 |goto Tanaris 65.27,50.03 |only if completedq(8747)
accept The Path of the Conqueror##8754 |goto Tanaris 65.27,50.03 |only if completedq(8752)
step
Reach Revered Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Revered |or
|tip Killing trash and bosses inside the "Temple of Ahn'Qiraj" and "Ruins of Ahn'Qiraj" raids grants reputation.
|tip Completing the repeatable quest "The Hand of the Righteous" in Cenarion Hold also grants reputation.
|tip You can gain reputation by completing Ahn'Qiraj raid quests and the Scepter of the Shifting Sands questline too.
'|complete completedq(8760,8750,8755) |or
step
talk Anachronos##15192
accept The Path of the Invoker##8760 |goto Tanaris 65.27,50.03 |only if completedq(8757)
accept The Path of the Protector##8750 |goto Tanaris 65.27,50.03 |only if completedq(8747)
accept The Path of the Conqueror##8755 |goto Tanaris 65.27,50.03 |only if completedq(8752)
step
Reach Exalted Reputation with the Brood of Nozdormu |complete rep("Brood of Nozdormu") >= Exalted |or
|tip Killing trash and bosses inside the "Temple of Ahn'Qiraj" and "Ruins of Ahn'Qiraj" raids grants reputation.
|tip Completing the repeatable quest "The Hand of the Righteous" in Cenarion Hold also grants reputation.
|tip You can gain reputation by completing Ahn'Qiraj raid quests and the Scepter of the Shifting Sands questline too.
'|complete completedq(8761,8751,8756) |or
step
talk Anachronos##15192
accept The Grand Invoker##8761 |goto Tanaris 65.27,50.03 |only if completedq(8757)
accept The Protector of Kalimdor##8751 |goto Tanaris 65.27,50.03 |only if completedq(8747)
accept The Qiraji Conqueror##8756 |goto Tanaris 65.27,50.03 |only if completedq(8752)
step
Click Here to Change Paths |confirm
|tip You will need to provide 15 Bronze Scarabs, 15 Crystal Scarabs, and 15 Clay Scarabs in addition to your ring. |only if completedq(8761)
|tip You will need to provide 15 Stone Scarabs, 15 Gold Scarabs, and 15 Silver Scarabs in addition to your ring. |only if completedq(8751)
|tip You will need to provide 15 Bone Scarabs, 15 Ivory Scarabs, and 15 Stone Scarabs in addition to your ring. |only if completedq(8756)
stickystart "Collect_Crystal_Scarabs"
stickystart "Collect_Clay_Scarabs"
stickystart "Collect_Stone_Scarabs_8764"
stickystart "Collect_Gold_Scarabs"
stickystart "Collect_Silver_Scarabs"
stickystart "Collect_Bone_Scarabs"
stickystart "Collect_Ivory_Scarabs"
stickystart "Collect_Stone_Scarabs_8766"
step
collect 15 Bronze Scarab##20861 |q 8765 |future
step
label "Collect_Crystal_Scarabs"
collect 15 Crystal Scarab##20862 |q 8765 |future
step
label "Collect_Clay_Scarabs"
collect 15 Clay Scarab##20863 |q 8765 |future
step
label "Collect_Stone_Scarabs_8764"
collect 15 Stone Scarab##20858 |q 8764 |future
step
label "Collect_Gold_Scarabs"
collect 15 Gold Scarab##20859 |q 8764 |future
step
label "Collect_Silver_Scarabs"
collect 15 Silver Scarab##20860 |q 8764 |future
step
label "Collect_Bone_Scarabs"
collect 15 Bone Scarab##20864 |q 8766 |future
step
label "Collect_Ivory_Scarabs"
collect 15 Ivory Scarab##20865 |q 8766 |future
step
label "Collect_Stone_Scarabs_8766"
collect 15 Stone Scarab##20858 |q 8766 |future
step
talk Anachronos##15192
accept The Changing of Paths - Invoker No More##8765 |only if completedq(8761)
accept The Changing of Paths - Protector No More##8764 |only if completedq(8751)
accept The Changing of Paths - Conqueror No More##8766 |only if completedq(8756)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ahn'Qiraj Gear\\Cenarion Battlegear",{
description="This guide will walk you through acquiring and the four pieces of Cenarion Battlegear.",
condition_end=function() return completedq(8548,8572,8573,8574) end,
},[[
step
talk Windcaller Kaldon##15540
accept Cenarion Battlegear##8800 |goto Silithus 49.98,36.36
step
talk Vargus##15176
turnin Cenarion Battlegear##8800 |goto Silithus 51.22,38.85
step
talk Vargus##15176
accept Volunteer's Battlegear##8548 |goto Silithus 51.22,38.85
stickystart "Collect_Cenarion_Logistics_Badge_8548"
stickystart "Collect_Cenarion_Tactical_Badge_8548"
stickystart "Reach_Friendly_Reputation"
step
collect 5 Cenarion Combat Badge##20802 |q 8548/1
|tip Use the "Cenarion Field Duty Combat Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Logistics_Badge_8548"
collect 3 Cenarion Logistics Badge##20800 |q 8548/2
|tip Use the "Cenarion Field Duty Logistics Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Tactical_Badge_8548"
collect 7 Cenarion Tactical Badge##20801 |q 8548/3
|tip Use the "Cenarion Field Duty Tactical Assignments" leveling guide to collect these.
step
label "Reach_Friendly_Reputation"
Reach Friendly Reputation with the Cenarion Circle |complete rep("Cenarion Circle") >= Friendly
|tip Killing Twilight enemies in Silithus grants 1 reputation each until Honored.
|tip Killing Twilight Flamereavers in Silithus grants 1 reputation each until Revered.
|tip Killing mobs and bosses in the "Ruins of Ahn'Qiraj" and "Temple of Ahn'Qiraj" raids grants various levels of reputation until Exalted.
|tip Completing the repeatable quests "Field Duty" and "Encrypted Twilight Texts" in Cenarion Hold also grants reputation.
step
talk Vargus##15176
turnin Volunteer's Battlegear##8548 |goto Silithus 51.22,38.85
step
talk Vargus##15176
accept Veteran's Battlegear##8572 |goto Silithus 51.22,38.85
stickystart "Collect_Cenarion_Logistics_Badge_8572"
stickystart "Collect_Cenarion_Tactical_Badge_8572"
stickystart "Reach_Honored_Reputation"
step
collect 7 Cenarion Combat Badge##20802 |q 8572/1
|tip Use the "Cenarion Field Duty Combat Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Logistics_Badge_8572"
collect 4 Cenarion Logistics Badge##20800 |q 8572/2
|tip Use the "Cenarion Field Duty Logistics Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Tactical_Badge_8572"
collect 4 Cenarion Tactical Badge##20801 |q 8572/3
|tip Use the "Cenarion Field Duty Tactical Assignments" leveling guide to collect these.
step
label "Reach_Honored_Reputation"
Reach Honored Reputation with the Cenarion Circle |complete rep("Cenarion Circle") >= Honored
|tip Killing Twilight enemies in Silithus grants 1 reputation each until Honored.
|tip Killing Twilight Flamereavers in Silithus grants 1 reputation each until Revered.
|tip Killing mobs and bosses in the "Ruins of Ahn'Qiraj" and "Temple of Ahn'Qiraj" raids grants various levels of reputation until Exalted.
|tip Completing the repeatable quests "Field Duty" and "Encrypted Twilight Texts" in Cenarion Hold also grants reputation.
step
talk Vargus##15176
turnin Veteran's Battlegear##8572 |goto Silithus 51.22,38.85
step
talk Vargus##15176
accept Champion's Battlegear##8573 |goto Silithus 51.22,38.85
stickystart "Collect_Cenarion_Logistics_Badge_8573"
stickystart "Collect_Cenarion_Tactical_Badge_8573"
stickystart "Collect_Mark_of_Cenarius_8573"
stickystart "Reach_Honored_Reputation"
step
collect 15 Cenarion Combat Badge##20802 |q 8573/1
|tip Use the "Cenarion Field Duty Combat Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Logistics_Badge_8573"
collect 20 Cenarion Logistics Badge##20800 |q 8573/2
|tip Use the "Cenarion Field Duty Logistics Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Tactical_Badge_8573"
collect 20 Cenarion Tactical Badge##20801 |q 8573/3
|tip Use the "Cenarion Field Duty Tactical Assignments" leveling guide to collect these.
step
label "Collect_Mark_of_Cenarius_8573"
collect 1 Mark of Cenarius##21508 |q 8573/4
|tip Use the "Cenarion Field Duty Tactical Assignments" leveling guide to collect these.
|tip This item is a reward exclusive to the followup tactical assignment quest "The Four Dukes."
step
label "Reach_Revered_Reputation"
Reach Revered Reputation with the Cenarion Circle |complete rep("Cenarion Circle") >= Revered
|tip Killing Twilight enemies in Silithus grants 1 reputation each until Honored.
|tip Killing Twilight Flamereavers in Silithus grants 1 reputation each until Revered.
|tip Killing mobs and bosses in the "Ruins of Ahn'Qiraj" and "Temple of Ahn'Qiraj" raids grants various levels of reputation until Exalted.
|tip Completing the repeatable quests "Field Duty" and "Encrypted Twilight Texts" in Cenarion Hold also grants reputation.
step
talk Vargus##15176
turnin Champion's Battlegear##8573 |goto Silithus 51.22,38.85
step
talk Vargus##15176
accept Stalwart's Battlegear##8574 |goto Silithus 51.22,38.85
stickystart "Collect_Cenarion_Logistics_Badge_8574"
stickystart "Collect_Cenarion_Tactical_Badge_8574"
stickystart "Collect_Mark_of_Remulos_8574"
stickystart "Reach_Honored_Reputation"
step
collect 15 Cenarion Combat Badge##20802 |q 8574/1
|tip Use the "Cenarion Field Duty Combat Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Logistics_Badge_8574"
collect 20 Cenarion Logistics Badge##20800 |q 8574/2
|tip Use the "Cenarion Field Duty Logistics Assignments" leveling guide to collect these.
step
label "Collect_Cenarion_Tactical_Badge_8574"
collect 17 Cenarion Tactical Badge##20801 |q 8574/3
|tip Use the "Cenarion Field Duty Tactical Assignments" leveling guide to collect these.
step
label "Collect_Mark_of_Remulos_8574"
collect 1 Mark of Remulos##21515 |q 8574/4
|tip Use the "Cenarion Field Duty Logistics Assignments" leveling guide to collect these.
|tip This item is a reward exclusive to the followup logistics assignment quest "The Ultimate Deception."
step
label "Reach_Exalted_Reputation"
Reach Exalted Reputation with the Cenarion Circle |complete rep("Cenarion Circle") >= Exalted
|tip Killing Twilight enemies in Silithus grants 1 reputation each until Honored.
|tip Killing Twilight Flamereavers in Silithus grants 1 reputation each until Revered.
|tip Killing mobs and bosses in the "Ruins of Ahn'Qiraj" and "Temple of Ahn'Qiraj" raids grants various levels of reputation until Exalted.
|tip Completing the repeatable quests "Field Duty" and "Encrypted Twilight Texts" in Cenarion Hold also grants reputation.
step
talk Vargus##15176
turnin Stalwart's Battlegear##8574 |goto Silithus 51.22,38.85
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Cenarion Field Duty Combat Assignments",{
description="This guide will walk you through completing various combat assignments for the Cenarion Circle.",
},[[
step
label "Accept_Field_Duty"
talk Windcaller Kaldon##15540
accept Field Duty##8731 |goto Silithus 49.98,36.34
step
use the Unsigned Field Duty Papers##21143
collect 1 Prepared Field Duty Papers##23024 |q 8507
step
talk Krug Skullsplit##15612
accept Field Duty Papers##8732 |goto Silithus 52.21,68.43
step
collect 1 Signed Field Duty Papers##20810 |q 8507/1
step
talk Windcaller Kaldon##15540
|tip Choose a combat assignment.
|tip Combat Assignments require you to kill various elite silithid in Silithus hives.
turnin Field Duty##8507 |goto Silithus 49.98,36.34
step
label "Begin_Combat_Assignment"
use the Combat Assignment##20808
Open the Combat Assignment |complete itemcount(20808) == 0
step
use the Hive'Zora Dossier##22650 |only if itemcount(22650) >= 0
use the Hive'Ashi Dossier##22648 |only if itemcount(22648) >= 0
use the Hive'Regal Dossier##22649 |only if itemcount(22649) >= 0
Open the Dossier |complete itemcount(22650) == 0 and itemcount(22648) == 0 and itemcount(22649) == 0
step
use the Combat Task Briefing I##21749
accept Target: Hive'Ashi Defenders##8770
|only if itemcount(21749) >= 1 or haveq(8770)
step
use the Combat Task Briefing II##21750
accept Target: Hive'Ashi Sandstalkers##8771
|only if itemcount(21750) >= 1 or haveq(8771)
step
use the Combat Task Briefing III##20942
accept Target: Hive'Ashi Workers##8502
|only if itemcount(20942) >= 1 or haveq(8502)
step
use the Combat Task Briefing IV##21248
accept Target: Hive'Zora Reavers##8773
|only if itemcount(21248) >= 1 or haveq(8773)
step
use the Combat Task Briefing V##21249
accept Target: Hive'Zora Hive Sisters##8539
|only if itemcount(21249) >= 1 or haveq(8539)
step
use the Combat Task Briefing VI##21250
accept Target: Hive'Zora Waywatchers##8772
|only if itemcount(21250) >= 1 or haveq(8772)
step
use the Combat Task Briefing VII##21251
accept Target: Hive'Zora Tunnelers##8687
|only if itemcount(21251) >= 1 or haveq(8687)
step
use the Combat Task Briefing VIII##21252
accept Target: Hive'Regal Ambushers##8774
|only if itemcount(21252) >= 1 or haveq(8774)
step
use the Combat Task Briefing IX##21253
accept Target: Hive'Regal Spitfires##8775
|only if itemcount(21253) >= 1 or haveq(8775)
step
use the Combat Task Briefing X##21255
accept Target: Hive'Regal Slavemakers##8776
|only if itemcount(21255) >= 1 or haveq(8776)
step
use the Combat Task Briefing XI##21256
accept Target: Hive'Regal Burrowers##8777
|only if itemcount(21256) >= 1 or haveq(8777)
step
use the Combat Task Briefing XII##20941
accept Target: Hive'Ashi Stingers##8501
|only if itemcount(20941) >= 1 or haveq(8501)
stickystart "Kill_30_Hive'Ashi_Sandstalkers"
stickystart "Kill_30_Hive'Ashi_Workers"
stickystart "Kill_30_Hive'Zora_Reavers"
stickystart "Kill_30_Hive'Zora_Hive_Sisters"
stickystart "Kill_30_Hive'Zora_Waywatchers"
stickystart "Kill_30_Hive'Zora_Tunnelers"
stickystart "Kill_30_Hive'Regal_Ambushers"
stickystart "Kill_30_Hive'Regal_Spitfires"
stickystart "Kill_30_Hive'Regal_Slavemakers"
stickystart "Kill_30_Hive'Regal_Burrowers"
stickystart "Kill_30_Hive'Ashi_Stingers"
step
kill 30 Hive'Ashi Defender##11722 |q 8770/1 |goto Silithus 45.06,25.78
|tip These enemies are elite and may require a group to kill.
|only if haveq(8770)
step
label "Kill_30_Hive'Ashi_Sandstalkers"
kill 30 Hive'Ashi Sandstalker##11723 |q 8771/1  |goto Silithus 45.06,25.78
|tip These enemies are elite and may require a group to kill. |notinsticky
|tip They are stealthed all over the hive.
|only if haveq(8771)
step
label "Kill_30_Hive'Ashi_Workers"
kill 30 Hive'Ashi Worker##11721 |q 8502/1 |goto Silithus 45.06,25.78
|tip These enemies are elite and may require a group to kill. |notinsticky
|only if haveq(8502)
step
label "Kill_30_Hive'Zora_Reavers"
kill 30 Hive'Zora Reaver##11728 |q 8773/1 |goto Silithus 25.15,59.72
|tip These enemies are elite and may require a group to kill. |notinsticky
|only if haveq(8773)
step
label "Kill_30_Hive'Zora_Hive_Sisters"
kill 30 Hive'Zora Hive Sister##11729 |q 8539/1 |goto Silithus 25.15,59.72
|tip These enemies are elite and may require a group to kill. |notinsticky
|only if haveq(8539)
step
label "Kill_30_Hive'Zora_Waywatchers"
kill 30 Hive'Zora Waywatcher##11725 |q 8772/1 |goto Silithus 25.15,59.72
|tip These enemies are elite and may require a group to kill. |notinsticky
|only if haveq(8772)
step
label "Kill_30_Hive'Zora_Tunnelers"
kill 30 Hive'Zora Tunneler##11726 |q 8687/1 |goto Silithus 25.20,55.37
|tip These enemies are elite and may require a group to kill. |notinsticky
|tip They only spawn inside the hive.
|only if haveq(8687)
step
label "Kill_30_Hive'Regal_Ambushers"
kill 30 Hive'Regal Ambusher##11730 |q 8774/1 |goto Silithus 57.57,80.69
|tip These enemies are elite and may require a group to kill. |notinsticky
|tip They are stealthed all over the hive.
|only if haveq(8774)
step
label "Kill_30_Hive'Regal_Spitfires"
kill 30 Hive'Regal Spitfire##11732 |q 8775/1 |goto Silithus 57.57,80.69
|tip These enemies are elite and may require a group to kill. |notinsticky
|only if haveq(8775)
step
label "Kill_30_Hive'Regal_Slavemakers"
kill 30 Hive'Regal Slavemaker##11733 |q 8776/1 |goto Silithus 57.57,80.69
|tip These enemies are elite and may require a group to kill. |notinsticky
|only if haveq(8776)
step
label "Kill_30_Hive'Regal_Burrowers"
kill 30 Hive'Regal Burrower##11731 |q 8777/1 |goto Silithus 62.05,80.40
|tip These enemies are elite and may require a group to kill. |notinsticky
|tip They only spawn inside the hive.
|only if haveq(8777)
step
label "Kill_30_Hive'Ashi_Stingers"
kill 30 Hive'Ashi Stinger##11698 |q 8501/1 |goto Silithus 47.91,26.31
|tip These enemies are elite and may require a group to kill. |notinsticky
|tip They only spawn inside the hive.
|only if haveq(8501)
step
talk Commander Mar'alith##15181
turnin Target: Hive'Ashi Defenders##8770 |goto Silithus 49.20,34.19 |only if haveq(8770)
turnin Target: Hive'Ashi Sandstalkers##8771 |goto Silithus 49.20,34.19 |only if haveq(8771)
turnin Target: Hive'Ashi Workers##8502 |goto Silithus 49.20,34.19 |only if haveq(8502)
turnin Target: Hive'Zora Reavers##8773 |goto Silithus 49.20,34.19 |only if haveq(8773)
turnin Target: Hive'Zora Hive Sisters##8539 |goto Silithus 49.20,34.19 |only if haveq(8539)
turnin Target: Hive'Zora Waywatchers##8772 |goto Silithus 49.20,34.19 |only if haveq(8772)
turnin Target: Hive'Zora Tunnelers##8687 |goto Silithus 49.20,34.19 |only if haveq(8687)
turnin Target: Hive'Regal Ambushers##8774 |goto Silithus 49.20,34.19 |only if haveq(8774)
turnin Target: Hive'Regal Spitfires##8775 |goto Silithus 49.20,34.19 |only if haveq(8775)
turnin Target: Hive'Regal Slavemakers##8776 |goto Silithus 49.20,34.19 |only if haveq(8776)
turnin Target: Hive'Regal Burrowers##8777 |goto Silithus 49.20,34.19 |only if haveq(8777)
turnin Target: Hive'Ashi Stingers##8501 |goto Silithus 49.20,34.19 |only if haveq(8501)
'|complete not haveq(8770,8771,8502,8773,8539,8772,8687,8774,8775,8776,8777,8501) |next "Accept_Field_Duty"
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Cenarion Field Duty Tactical Assignments",{
description="This guide will walk you through completing various tactical assignments for the Cenarion Circle.",
},[[
step
label "Accept_Field_Duty"
talk Windcaller Kaldon##15540
accept Field Duty##8731 |goto Silithus 49.98,36.34
step
use the Unsigned Field Duty Papers##21143
collect 1 Prepared Field Duty Papers##23024 |q 8507
step
talk Krug Skullsplit##15612
accept Field Duty Papers##8732 |goto Silithus 52.21,68.43
step
collect 1 Signed Field Duty Papers##20810 |q 8507/1
step
talk Windcaller Kaldon##15540
|tip Choose a tactical assignment.
|tip Tactical Assignments require you to fight Twilight Hammer elementals or collect reports from Silithus hives.
turnin Field Duty##8507 |goto Silithus 49.98,36.34
step
label "Begin_Tactical_Assignment"
use the Tactical Assignment##20809
Open the Tactical Assignment |complete itemcount(20809) == 0
step
use the Tactical Task Briefing I##21245
accept Azure Templar##8737
|only if itemcount(21245) >= 1 or haveq(8737)
step
use the Tactical Task Briefing III##21751
accept Earthen Templar##8536
|only if itemcount(21751) >= 1 or haveq(8536)
step
use the Tactical Task Briefing VI##21165
accept Hive'Zora Scout Report##8534
|only if itemcount(21165) >= 1 or haveq(8534)
step
use the Tactical Task Briefing VII##21166
accept Hive'Regal Scout Report##8738
|only if itemcount(21166) >= 1 or haveq(8738)
step
use the Tactical Task Briefing IX##20944
accept Twilight Marauders##8740
|only if itemcount(20944) >= 1 or haveq(8740)
step
kill Azure Templar##15211 |q 8737/1 |goto Silithus 38.29,46.46
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle.
|tip Equip all three pieces and interact with the Lesser Wind Stone to summon a Templar.
|tip The Templar is random, so you may need to do this more than one time.
|only if haveq(8737)
step
kill Earthen Templar##15307 |q 8536/1 |goto Silithus 38.29,46.46
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle.
|tip Equip all three pieces and interact with the Lesser Wind Stone to summon a Templar.
|tip The Templar is random, so you may need to do this more than one time.
|only if haveq(8536)
step
Enter the cave |goto Silithus 25.37,55.22 < 20 |walk
Follow the path |goto Silithus 26.51,56.73 < 10 |walk
Follow the path down |goto Silithus 25.56,61.87 < 10 |walk
talk Cenarion Scout Azenel##15610
Select _"I'm here to retrieve your report."_
collect Hive'Zora Scout Report##21158 |q 8534/1 |goto Silithus 23.63,62.43
|only if haveq(8534)
step
Enter the cave |goto Silithus 54.88,88.05 < 20 |walk
Follow the path down |goto Silithus 53.57,88.96 < 10 |walk
Follow the path down |goto Silithus 53.12,93.24 < 10 |walk
talk Cenarion Scout Landion##15609
Select _"I'm here to retrieve your report."_
collect Hive'Regal Scout Report##21160 |q 8738/1 |goto Silithus 53.71,97.48
|only if haveq(8738)
stickystart "Kill_Twilight_Marauders"
step
kill Twilight Marauder Morna##15541 |q 8740/1
She can also spawn at:
[38.81,78.19]
[23.63,45.32]
|only if haveq(8740)
step
label "Kill_Twilight_Marauders"
kill 5 Twilight Marauder##15542 |q 8740/2 |goto Silithus 68.76,35.99
|tip They spawn with Twilight Marauder Morna.
They can also spawn at: |notinsticky
[38.81,78.19] |notinsticky
[23.63,45.32] |notinsticky
|only if haveq(8740)
step
talk Bor Wildmane##15306
turnin Azure Templar##8737 |goto Silithus 48.57,37.78 |only if haveq(8737) |next "Open_Followup_Tactical_Assignment"
turnin Earthen Templar##8536 |goto Silithus 48.57,37.78 |only if haveq(8536) |next "Open_Followup_Tactical_Assignment"
|only if haveq(8737,8536)
step
talk Windcaller Proudhorn##15191
turnin Hive'Zora Scout Report##8534 |goto Silithus 51.15,38.29 |only if haveq(8534) |next "Open_Followup_Tactical_Assignment"
turnin Hive'Regal Scout Report##8738 |goto Silithus 51.15,38.29 |only if haveq(8738) |next "Open_Followup_Tactical_Assignment"
turnin Twilight Marauders##8740 |goto Silithus 51.15,38.29 |only if haveq(8740) |next "Open_Followup_Tactical_Assignment"
|only if haveq(8534,8738,8740)
step
label "Open_Followup_Tactical_Assignment"
use the Followup Tactical Assignment##21133
Open the Followup Tactical Assignment |complete itemcount(21133) == 0
step
use the Tactical Task Briefing II##20945
accept Crimson Templar##8537
|only if itemcount(20945) >= 1 or haveq(8537)
step
use the Tactical Task Briefing IV##20947
accept Hoary Templar##8535
|only if itemcount(20947) >= 1 or haveq(8535)
step
use the Tactical Task Briefing V##20948
accept The Four Dukes##8538
|only if itemcount(20948) >= 1 or haveq(8538)
step
use the Tactical Task Briefing VIII##21167
accept Hive'Ashi Scout Report##8739
|only if itemcount(21167) >= 1 or haveq(8739)
step
use the Tactical Task Briefing X##20943
accept Twilight Battle Orders##8498
|only if itemcount(20943) >= 1 or haveq(8498)
step
kill Crimson Templar##15209 |q 8537/1 |goto Silithus 38.29,46.46
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle.
|tip Equip all three pieces and interact with the Lesser Wind Stone to summon a Templar.
|tip The Templar is random, so you may need to do this more than one time.
|only if haveq(8537)
step
kill Hoary Templar##15212 |q 8535/1 |goto Silithus 38.29,46.46
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle.
|tip Equip all three pieces and interact with the Lesser Wind Stone to summon a Templar.
|tip The Templar is random, so you may need to do this more than one time.
|only if haveq(8535)
stickystart "Kill_The_Duke_of_Fathoms"
stickystart "Kill_The_Duke_of_Zephyrs"
stickystart "Kill_The_Duke_of_Shards"
step
kill The Duke of Cynders##15206 |q 8538/1 |goto Silithus 37.63,44.80
|tip Dukes are level 62 elites and will require a group.
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle.
|tip Equip all three pieces along with a Medallion of Station and interact with the Wind Stone to summon a Duke.
|tip You can acquire a Medalion of Station by bringing 3 Abyssal Crests and 1 Large Brilliant Shard to Aurel Goldleaf next to the mailbox in Cenarion Hold.
|tip Abyssal Crests are dropped by templars summoned with a Twilight Cultist set at a Lesser Windstone.
|tip The duke is random, so you may need to do this more than one time.
|only if haveq(8538)
step
label "Kill_The_Duke_of_Fathoms"
kill The Duke of Fathoms##15207 |q 8538/2 |goto Silithus 37.63,44.80
|tip Dukes are level 62 elites and will require a group. |notinsticky
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle. |notinsticky
|tip Equip all three pieces along with a Medallion of Station and interact with the Wind Stone to summon a Duke. |notinsticky
|tip You can acquire a Medalion of Station by bringing 3 Abyssal Crests and 1 Large Brilliant Shard to Aurel Goldleaf next to the mailbox in Cenarion Hold. |notinsticky
|tip Abyssal Crests are dropped by templars summoned with a Twilight Cultist set at a Lesser Windstone. |notinsticky
|tip The duke is random, so you may need to do this more than one time. |notinsticky
|only if haveq(8538)
step
label "Kill_The_Duke_of_Zephyrs"
kill The Duke of Zephyrs##15220 |q 8538/3 |goto Silithus 37.63,44.80
|tip Dukes are level 62 elites and will require a group. |notinsticky
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle. |notinsticky
|tip Equip all three pieces along with a Medallion of Station and interact with the Wind Stone to summon a Duke. |notinsticky
|tip You can acquire a Medalion of Station by bringing 3 Abyssal Crests and 1 Large Brilliant Shard to Aurel Goldleaf next to the mailbox in Cenarion Hold. |notinsticky
|tip Abyssal Crests are dropped by templars summoned with a Twilight Cultist set at a Lesser Windstone. |notinsticky
|tip The duke is random, so you may need to do this more than one time. |notinsticky
|only if haveq(8538)
step
label "Kill_The_Duke_of_Shards"
kill The Duke of Shards##15208 |q 8538/4 |goto Silithus 37.63,44.80
|tip Dukes are level 62 elites and will require a group. |notinsticky
|tip Kill Twilight enemies around the area until you collect a Twilight Cultist robe, cowl, and mantle. |notinsticky
|tip Equip all three pieces along with a Medallion of Station and interact with the Wind Stone to summon a Duke. |notinsticky
|tip You can acquire a Medalion of Station by bringing 3 Abyssal Crests and 1 Large Brilliant Shard to Aurel Goldleaf next to the mailbox in Cenarion Hold. |notinsticky
|tip Abyssal Crests are dropped by templars summoned with a Twilight Cultist set at a Lesser Windstone. |notinsticky
|tip The duke is random, so you may need to do this more than one time. |notinsticky
|only if haveq(8538)
step
Enter the cave |goto Silithus 43.95,16.03 < 20 |walk
talk Cenarion Scout Jalia##15611
|tip She is stealthed.
Select _"I'm here to retrieve your report."_
collect Hive'Ashi Scout Report##21161 |q 8739/1 |goto Silithus 43.94,13.81
|only if haveq(8739)
step
kill Twilight Prophet##15308
|tip She patrols in and between the points indicated with a group of bodyguards.
|tip You may need to search around for her, especially during peak hours.
|tip She is elite, so you may need a group.
collect Twilight Battle Orders##20803 |q 8498/1 |goto Silithus 39.29,42.97
You can also find her here:
[25.95,34.98]
[19.15,83.78]
|only if haveq(8498)
step
talk Bor Wildmane##15306
turnin Crimson Templar##8537 |goto Silithus 48.57,37.78 |only if haveq(8537)
turnin Hoary Templar##8535 |goto Silithus 48.57,37.78 |only if haveq(8535)
|only if haveq(8537,8535)
step
talk Commander Mar'alith##15181
turnin The Four Dukes##8538 |goto Silithus 49.20,34.19 |only if haveq(8538)
turnin Twilight Battle Orders##8498 |goto Silithus 49.20,34.19 |only if haveq(8498)
|only if haveq(8538,8498)
step
talk Windcaller Proudhorn##15191
turnin Hive'Ashi Scout Report##8739 |goto Silithus 51.15,38.29
|only if haveq(8739)
step
collect 1 Tactical Assignment##20809 |next "Begin_Tactical_Assignment"
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Cenarion Field Duty Logistics Assignments",{
description="This guide will walk you through completing various logistics assignments for the Cenarion Circle.",
},[[
step
label "Accept_Field_Duty"
talk Windcaller Kaldon##15540
accept Field Duty##8731 |goto Silithus 49.98,36.34
step
use the Unsigned Field Duty Papers##21143
collect 1 Prepared Field Duty Papers##23024 |q 8507
step
talk Krug Skullsplit##15612
accept Field Duty Papers##8732 |goto Silithus 52.21,68.43
step
collect 1 Signed Field Duty Papers##20810 |q 8507/1
step
talk Windcaller Kaldon##15540
|tip Choose a logistics assignment.
|tip Logistics Assignments require you to donate various materials to the Cenarion effort.
turnin Field Duty##8507 |goto Silithus 49.98,36.34
step
label "Begin_Logistics_Assignment"
use the Logistics Assignment##21266
Open the Logistics Assignment |complete itemcount(21266) == 0
step
use the Logistics Task Briefing IV##21258
accept The Orgrimmar Legion Needs Mojo!##8785
|only if itemcount(21258) >= 1 or haveq(8785)
step
use the Logistics Task Briefing V##21382
accept Scrying Materials##8807
|only if itemcount(21382) >= 1 or haveq(8807)
step
use the Logistics Task Briefing VI##21261
accept Arms for the Field##8786
|only if itemcount(21261) >= 1 or haveq(8786)
step
use the Logistics Task Briefing VII##21264
accept Armor Kits for the Field##8787
|only if itemcount(21264) >= 1 or haveq(8787)
step
use the Logistics Task Briefing X##21385
accept Bandages for the Field##8810
|only if itemcount(21385) >= 1 or haveq(8810)
stickystart "Collect_6_Flask_of_Big_Mojo"
stickystart "Collect_6_Powerful_Mojo"
step
collect 8 Oil of Immolation##8956 |q 8785/1
|tip Craft them with Alchemy or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Alchemy. |only if selfmade()
|tip Each one requires 1 Firebloom, 1 Goldthorn, and 1 Crystal Vial to create.
|only if haveq(8785)
step
label "Collect_6_Flask_of_Big_Mojo"
Kill Vilebranch enemies around this area
collect 6 Flask of Big Mojo##8152 |q 8785/2 |goto The Hinterlands 66.48,68.75
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if haveq(8785)
step
label "Collect_6_Powerful_Mojo"
Follow the path up |goto Eastern Plaguelands 56.03,17.85 < 40 |only if walking
Kill Mossflayer enemies around this area
collect 6 Powerful Mojo##15992 |q 8785/3 |goto Eastern Plaguelands 61.08,12.25
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if haveq(8785)
stickystart "Collect_1_Large_Radiant_Shard"
stickystart "Collect_1_Huge_Emerald"
step
collect 1 Large Brilliant Shard##14344 |q 8807/1
|tip Disenchant item level 56-65 rare items or purchase it from the Auction House. |only if not selfmade()
|tip Disenchant item level 56-65 rare items. |only if selfmade()
|tip Blackrock Depths and Dire Maul are good sources for these items.
|only if haveq(8807)
step
label "Collect_1_Large_Radiant_Shard"
collect 1 Large Radiant Shard##11178 |q 8807/2
|tip Disenchant item level 46-50 rare items or purchase it from the Auction House. |only if not selfmade()
|tip Disenchant item level 46-50 rare items. |only if selfmade()
|tip Zul'Farrak, Dire Maul, and Stratholme are good sources for these items.
|only if haveq(8807)
step
label "Collect_1_Huge_Emerald"
collect 1 Huge Emerald##12364 |q 8807/3
|tip Gather it with Mining or purchase it from the Auction House. |only if not selfmade()
|tip Gather it with Mining . |only if selfmade()
|tip It can be mined from any type of Thorium vein.
|only if haveq(8807)
step
collect 2 Massive Iron Axe##3855 |q 8786/1
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 14 Iron Bars, 2 Strong Flux, 2 Heavy Grinding Stones, 4 Gold Bars, and 2 Heavy Leather to create.
|only if haveq(8786)
stickystart "Collect_8_Heavy_Armor_Kits"
step
collect 8 Rugged Armor Kit##15564 |q 8787/1
|tip Craft them with Leatherworking or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Leatherworking. |only if selfmade()
|tip Each one requires 5 Rugged Leather to create.
|only if haveq(8787)
step
label "Collect_8_Heavy_Armor_Kits"
collect 8 Heavy Armor Kit##4265 |q 8787/2
|tip Craft them with Leatherworking or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Leatherworking. |only if selfmade()
|tip Each one requires 5 Heavy Leather and 1 Fine Thread to create.
|only if haveq(8787)
stickystart "Collect_30_Heavy_Mageweave_Bandage"
stickystart "Collect_30_Heavy_Silk_Bandage"
step
collect 30 Heavy Runecloth Bandage##14530 |q 8810/1
|tip Craft them with First Aid or purchase them from the Auction House.
|tip Each one requires 2 Runecloth to create.
|only if haveq(8810)
step
label "Collect_30_Heavy_Mageweave_Bandage"
collect 30 Heavy Mageweave Bandage##8545 |q 8810/2
|tip Craft them with First Aid or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with First Aid. |only if selfmade()
|tip Each one requires 2 Mageweave Cloth to create.
|only if haveq(8810)
step
label "Collect_30_Heavy_Silk_Bandage"
collect 30 Heavy Silk Bandage##6451 |q 8810/3
|tip Craft them with First Aid or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with First Aid. |only if selfmade()
|tip Each one requires 2 Silk Cloth to create.
|only if haveq(8810)
step
talk Geologist Larksbane##15183
turnin Scrying Materials##8807 |goto Silithus 49.67,37.35 |next "Open_Followup_Logistics_Assignment"
|only if haveq(8807)
step
talk Windcaller Proudhorn##15191
turnin Bandages for the Field##8810 |goto Silithus 51.15,38.29 |next "Open_Followup_Logistics_Assignment"
|only if haveq(8810)
step
talk Shadow Priestess Shai##15615
turnin The Orgrimmar Legion Needs Mojo!##8785 |goto Silithus 51.34,68.81 |next "Open_Followup_Logistics_Assignment"
|only if haveq(8785)
step
talk Merok Longstride##15613
turnin Arms for the Field##8786 |goto Silithus 51.85,67.96 |next "Open_Followup_Logistics_Assignment" |only if haveq(8786)
turnin Armor Kits for the Field##8787 |goto Silithus 51.85,67.96 |next "Open_Followup_Logistics_Assignment" |only if haveq(8787)
|only if haveq(8786,8787)
step
label "Open_Followup_Logistics_Assignment"
use the Followup Logistics Assignment##21386
Open the Followup Logistics Assignment |complete itemcount(21386) == 0
step
use the Logistics Task Briefing I##21378
accept Desert Survival Kits##8804
|only if itemcount(21378) >= 1 or haveq(8804)
step
use the Logistics Task Briefing II##21379
accept Boots for the Guard##8805
|only if itemcount(21379) >= 1 or haveq(8805)
step
use the Logistics Task Briefing III##21380
accept Grinding Stones for the Guard##8806
|only if itemcount(21380) >= 1 or haveq(8806)
step
use the Logistics Task Briefing VIII##21384
accept Uniform Supplies##8808
|only if itemcount(21384) >= 1 or haveq(8808)
step
use the Logistics Task Briefing IX##21381
accept Extraordinary Materials##8809
|only if itemcount(21381) >= 1 or haveq(8809)
step
use the Logistics Task Briefing XI##21514
accept The Ultimate Deception##8829
|only if itemcount(21514) >= 1 or haveq(8829)
step
collect 3 Ornate Mithril Boots##7936 |q 8805/1
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 14 Mithril Bars, 2 Truesilver Bars, 4 Thick Leather, 1 Solid Grinding Stone, and 1 Aquamarine to create.
|only if haveq(8805)
stickystart "Collect_Powerful_Anti-Venom"
stickystart "Collect_Smoked_Desert_Dumplings"
step
kill Toxic Horror##7132+
collect 4 Globe of Water##7079 |q 8804/1 |goto Felwood 48.75,24.16
|tip You can also purchase these from the Auction House. |only if not selfmade()
|only if haveq(8804)
step
label "Collect_Powerful_Anti-Venom"
collect 4 Powerful Anti-Venom##19440 |q 8804/2
|tip Craft them with First Aid or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with First Aid. |only if selfmade()
|tip Each one requires 1 Huge Venom Sac to create.
|only if haveq(8804)
step
label "Collect_Smoked_Desert_Dumplings"
collect 4 Smoked Desert Dumplings##20452 |q 8804/3
|tip Craft them with Cooking or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Cooking. |only if selfmade()
|tip Each one requires 1 Sandworm Meat and 1 Soothing Spices to create.
|only if haveq(8804)
stickystart "Collect_Solid_Grinding_Stone"
stickystart "Collect_Heavy_Grinding_Stone"
step
collect 10 Dense Grinding Stone##12644 |q 8806/1
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 4 Dense Stone to create.
|only if haveq(8806)
step
label "Collect_Solid_Grinding_Stone"
collect 10 Solid Grinding Stone##7966 |q 8806/2
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 4 Solid Stone to create.
|only if haveq(8806)
step
label "Collect_Heavy_Grinding_Stone"
collect 10 Heavy Grinding Stone##3486 |q 8806/3
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 3 Heavy Stone to create.
|only if haveq(8806)
stickystart "Collect_Bolt_of_Runecloth"
stickystart "Collect_Ironweb_Spider_Silk"
step
collect 1 Mooncloth##14342 |q 8808/1
|tip Craft it with Tailoring or purchase it from the Auction House. |only if not selfmade()
|tip Craft it with Tailoring. |only if selfmade()
|tip It requires 2 Felcloth and a daily Tailoring cooldown to create.
|only if haveq(8808)
step
label "Collect_Bolt_of_Runecloth"
collect 2 Bolt of Runecloth##14048 |q 8808/2
|tip Craft them with Tailoring or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Tailoring. |only if selfmade()
|tip Each one requires 5 Runecloth to create.
|only if haveq(8808)
step
label "Collect_Ironweb_Spider_Silk"
kill Plague Lurker##1824+
collect 1 Ironweb Spider Silk##14227 |q 8808/3 |goto Western Plaguelands 62.20,49.48
|tip You can also purchase it from the Auction House. |only if not selfmade()
|only if haveq(8808)
stickystart "Collect_Enchanted_Leather"
step
collect 10 Enchanted Thorium Bar##12655 |q 8809/1
|tip Craft them with Enchanting or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Enchanting. |only if selfmade()
|tip Each one requires 1 Thorium Bar and 3 Dream Dust to create.
|only if haveq(8809)
step
label "Collect_Enchanted_Leather"
collect 10 Solid Grinding Stone##12810 |q 8809/2
|tip Craft them with Enchanting or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Enchanting. |only if selfmade()
|tip Each one requires 1 Rugged Leather and 1 Lesser Eternal Essence to create.
|only if haveq(8809)
stickystart "Collect_Frayed_Abomination_Stitching"
stickystart "Collect_Twilight_Cultist_Robe"
step
collect 1 Skin of Shadow##12753 |q 8829/1
|tip This has a chance to drop from Risen Bonewarders and Risen Constructs in the Scholomance dungeon.
|only if haveq(8829)
step
label "Collect_Frayed_Abomination_Stitching"
collect 3 Frayed Abomination Stitching##12735 |q 8829/2
|tip These drop from Abomination enemies as well as Ramstein the Gorger in the Undead Stratholme dungeon.
|only if haveq(8829)
step
label "Collect_Twilight_Cultist_Robe"
Kill Twilight enemies around this area
collect 1 Twilight Cultist Robe##20407 |q 8829/3 |goto Silithus 38.64,44.97
|tip You can also purchase it from the Auction House. |only if not selfmade()
|only if haveq(8829)
step
talk Calandrath##15174
|tip Inside the building.
turnin Desert Survival Kits##8804 |goto Silithus 51.87,39.14
|only if haveq(8804)
step
talk Vish Kozus##15182
|tip At the top of the tower.
turnin Grinding Stones for the Guard##8806 |goto Silithus 50.75,33.65 |only if haveq(8806)
turnin Boots for the Guard##8805 |goto Silithus 50.75,33.65 |only if haveq(8805)
|only if haveq(8806,8805)
step
talk Windcaller Proudhorn##15191
turnin Uniform Supplies##8808 |goto Silithus 51.15,38.29
|only if haveq(8808)
step
talk Vargus##15176
turnin Extraordinary Materials##8809 |goto Silithus 51.23,38.86
|only if haveq(8809)
step
talk Aurel Goldleaf##15282
turnin The Ultimate Deception##8829 |goto Silithus 51.96,38.15
|only if haveq(8829)
step
collect 1 Logistics Assignment##21266 |next "Begin_Logistics_Assignment"
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Druid Class Quests",{
description="This guide will walk you through completing various Druid Class Quests.",
},[[
step
ding 10
step
Enter the building |goto Mulgore 47.21,62.89 < 15 |walk
talk Gennia Runetotem##3064
|tip Inside the building.
accept Heeding the Call##5928 |goto Mulgore 47.47,62.98
|only if Tauren Druid
step
Ride the elevator up |goto Thunder Bluff 31.80,65.96 < 10 |only if walking
Enter the building |goto Thunder Bluff 58.66,46.92 < 15 |walk
Cross the bridge |goto Thunder Bluff 61.44,40.20 < 10 |walk
Enter the building |goto Thunder Bluff 74.09,29.91 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Heeding the Call##5928 |goto Thunder Bluff 76.46,27.23
accept Moonglade##5922 |goto Thunder Bluff 76.46,27.23
|only if Tauren Druid
step
Enter the building |goto Moonglade 56.13,30.98 < 15 |walk
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Moonglade##5922 |goto Moonglade 56.21,30.64
accept Great Bear Spirit##5930 |goto Moonglade 56.21,30.64
|only if Tauren Druid
step
Follow the path |goto Moonglade 42.47,34.44 < 20 |only if walking
talk Great Bear Spirit##11956
Select _"What do you represent, spirit?"_ |gossip 97167
Select _"I seek to understand the importance of strength of the body."_ |gossip 97129
Select _"I seek to understand the importance of strength of the heart."_ |gossip 97168
Select _"I have heard your words, Great Bear Spirit, and I understand. I now seek your blessings to fully learn the way of the Claw."_ |gossip 95967
Seek Out the Great Bear Spirit and Learn what it Has to Share with You About the Nature of the Bear |q 5930/1 |goto Moonglade 39.11,27.51
|only if Tauren Druid
step
talk Faustron##12740
fpath Moonglade |goto Moonglade 32.11,66.60
|only if Tauren Druid
step
Follow the road |goto Moonglade 40.77,35.81 < 20 |only if walking
Enter the building |goto Moonglade 56.13,30.98 < 15 |walk
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Great Bear Spirit##5930 |goto Moonglade 56.21,30.64
accept Back to Thunder Bluff##5932 |goto Moonglade 56.21,30.64
|only if Tauren Druid
step
Locate Bunthen Plainswind |goto Moonglade 44.28,45.86 < 10 |c |q 5932
|only if Tauren Druid
step
Enter the building |goto Thunder Bluff 58.66,46.92 < 15 |walk
Cross the bridge |goto Thunder Bluff 61.44,40.20 < 10 |walk
Enter the building |goto Thunder Bluff 74.09,29.91 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Back to Thunder Bluff##5932 |goto Thunder Bluff 76.46,27.23
accept Body and Heart##6002 |goto Thunder Bluff 76.46,27.23
|only if Tauren Druid
step
use the Cenarion Lunardust##15710
kill Lunaclaw##12138
|tip A spirit will appear after you kill her.
talk Lunaclaw Spirit##12144
Select _"You have fought well, spirit. I ask you to grant me the strength of your body and the strength of your heart."_ |gossip 97126
Face Lunaclaw and Earn the Strength of Body and Heart it Possesses |q 6002/1 |goto The Barrens 42.00,60.86
|only if Tauren Druid
step
Enter Mulgore |goto The Barrens 41.54,58.56 < 30 |only if walking
Cross the bridge |goto Mulgore 47.18,57.81 < 20 |only if walking
Ride the elevator up |goto Thunder Bluff 31.80,65.96 < 10 |only if walking
Enter the building |goto Thunder Bluff 58.66,46.92 < 15 |walk
Cross the bridge |goto Thunder Bluff 61.44,40.20 < 10 |walk
Enter the building |goto Thunder Bluff 74.09,29.91 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Body and Heart##6002 |goto Thunder Bluff 76.46,27.23
|only if Tauren Druid
step
ding 14
step
talk Auctioneer Stampi##8674
collect 5 Earthroot##2449 |goto Thunder Bluff 40.40,51.77 |q 6128 |future
|tip Buy them from the Auction House.
|only if Druid and not selfmade()
step
Enter the building |goto Thunder Bluff 74.17,29.89 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
accept Lessons Anew##6126 |goto Thunder Bluff 76.47,27.23
|only if Druid
step
Enter the building |goto Moonglade 56.13,30.98 < 15 |walk
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Lessons Anew##6126 |goto Moonglade 56.21,30.64
accept The Principal Source##6127 |goto Moonglade 56.21,30.64
|only if Druid
step
Follow the path up |goto The Barrens 51.08,22.66 < 15 |only if walking
Follow the path |goto The Barrens 49.16,20.33 < 15 |only if walking
Follow the path up |goto The Barrens 48.00,19.56 < 10 |only if walking
use the Empty Dreadmist Peak Sampler##15842
|tip Use it while standing in the bubbling water at the top of the mountain.
|tip {o}Be ready to flee!{} 3 acolytes will spawn and attack you right after.
|tip They stack warlock spells and curses on you, so taking them solo may be really hard, even if you clear all the other enemies at the peak of the mountain first.
collect Filled Dreadmist Peak Sampler##15843 |q 6127/1 |goto The Barrens 48.41,18.89
|only if Druid
step
Follow the path down |goto The Barrens 49.22,20.39 < 20 |only if walking
Follow the path |goto The Barrens 52.34,29.37 < 20 |only if walking
talk Tonga Runetotem##3448
turnin The Principal Source##6127 |goto The Barrens 52.26,31.93
accept Gathering the Cure##6128 |goto The Barrens 52.26,31.93
|only if Druid
step
Follow the path |goto The Barrens 50.09,40.90 < 30 |only if walking
kill Lost Barrens Kodo##3234+
collect 5 Kodo Horn##15852 |q 6128/2 |goto The Barrens 51.93,43.65
You can find more around: |notinsticky
[52.71,45.41]
[55.16,45.59]
[47.25,43.31]
[45.77,43.28]
[44.82,40.80]
|only if Druid
step
talk Tonga Runetotem##3448
turnin Gathering the Cure##6128 |goto The Barrens 52.26,31.93
accept Curing the Sick##6129 |goto The Barrens 52.26,31.93
|only if Druid
step
use the Curative Animal Salve##15826
'|talk Sickly Gazelle##12296+
|tip Use it on Sickly Gazelles around this area.
|tip They look like green gazelles all around the northern area of the Barrens.
Cure #10# Sickly Gazelles |q 6129/1 |goto The Barrens 50.17,31.12
You can find more around: |notinsticky
[48.77,29.54]
[48.33,26.15]
[48.84,23.88]
[49.99,23.09]
[51.79,20.51]
[53.44,20.86]
[54.29,21.65]
[54.98,21.95]
[53.52,26.92]
|only if Druid
step
Enter the building |goto Moonglade 56.13,30.98 < 15 |walk
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Curing the Sick##6129 |goto Moonglade 56.21,30.64
accept Power over Poison##6130 |goto Moonglade 56.21,30.64
|only if Druid
step
Enter the building |goto Thunder Bluff 74.17,29.89 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Power over Poison##6130 |goto Thunder Bluff 76.47,27.23
|only if Druid
step
ding 16
step
Follow the road |goto The Barrens 38.42,28.96 < 30 |only if walking
Continue following the road |goto The Barrens 43.46,30.63 < 30 |only if walking
Continue following the road |goto The Barrens 47.95,28.00 < 30 |only if walking
Follow the path |goto The Barrens 50.82,29.06 < 15 |only if walking
Enter the building |goto Thunder Bluff 74.15,29.89 < 7 |walk
talk Turak Runetotem##3033
|tip Inside the building.
accept A Lesson to Learn##27 |goto Thunder Bluff 76.47,27.22
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin A Lesson to Learn##27 |goto Moonglade 56.21,30.65
accept Trial of the Lake##28 |goto Moonglade 56.21,30.65
|only if Druid
step
click Bauble Container##177785
|tip It looks like a wicker vase on the ground underwater.
|tip They spawn randomly, so you may have to search around this area.
|tip Swim at the top of the water until you can see one. |only if hardcore
|tip Hover above the container before swimming directly down to it. |only if hardcore
|tip Don't linger underwater longer than is required and watch your breath meter. |only if hardcore
collect Shrine Bauble##15877 |goto Moonglade 54.33,55.65 |q 28 |future
|only if Druid
step
use the Shrine Bauble##15877
Complete the Trial of the Lake |q 28/1 |goto Moonglade 35.92,41.38
|only if Druid
step
talk Tajarri##11799
turnin Trial of the Lake##28 |goto Moonglade 36.51,40.11
accept Trial of the Sea Lion##30 |goto Moonglade 36.51,40.11
|only if Druid
step
Leave the building |goto The Barrens 52.03,30.18 < 7 |walk
Follow the path |goto Orgrimmar 52.54,85.14 < 15 |only if walking
Enter Undercity |goto Tirisfal Glades 61.86,65.03 < 15 |only if walking
talk Michael Garrett##4551
fpath Undercity |goto Undercity 63.28,48.58
|only if Druid
step
Leave Undercity |goto Undercity 66.19,0.63 < 10 |walk
Follow the road |goto Tirisfal Glades 56.17,65.88 < 30|only if walking
Continue following the road |goto Silverpine Forest 58.14,12.21 < 30 |only if walking
Follow the path |goto Silverpine Forest 51.56,22.48 < 30 |only if walking
Continue following the path |goto Silverpine Forest 44.15,28.90 < 30 |only if walking
click Strange Lockbox##177844
|tip Underwater.
|tip Hover above the container before swimming directly down to it. |only if hardcore
|tip Don't linger underwater longer than is required and watch your breath meter. |only if hardcore
collect Half Pendant of Aquatic Endurance##15882 |goto Silverpine Forest 29.54,29.53 |q 30
|only if Druid
step
Follow the path |goto The Barrens 52.92,12.63 < 40 |only if walking
click Strange Lockbox##177794
|tip Underwater.
|tip Hover above the container before swimming directly down to it. |only if hardcore
|tip Don't linger underwater longer than is required and watch your breath meter. |only if hardcore
collect Half Pendant of Aquatic Agility##15883 |goto The Barrens 56.68,8.32 |q 30
|only if Druid
step
use the Half Pendant of Aquatic Agility##15883
collect Pendant of the Sea Lion##15885 |q 30/1 |goto Moonglade 35.92,41.42
|only if Druid
step
Follow the road |goto Moonglade 41.76,35.10 < 20 |only if walking
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Trial of the Sea Lion##30 |goto Moonglade 56.21,30.64
accept Aquatic Form##31 |goto Moonglade 56.21,30.64
|only if Druid
step
Enter the building |goto Thunder Bluff 74.15,29.89 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Aquatic Form##31 |goto Thunder Bluff 76.47,27.22
|only if Druid
step
ding 52
step
talk Turak Runetotem##3033
|tip Insidie the building.
accept Torwa Pathfinder##9063 |goto Thunder Bluff 76.60,27.60
|only if Druid
step
talk Torwa Pathfinder##9619
turnin Torwa Pathfinder##9063 |goto Un'Goro Crater 71.63,75.96
accept Bloodpetal Poison##9052 |goto Un'Goro Crater 71.63,75.96
|only if Druid
step
Kill Gorishi enemies around this area
|tip Gorishi Workers may call for help when at low health.	|only if hardcore
|tip Watch for patrols and respawns while in the cave.		|only if hardcore
collect 8 Gorishi Sting##22435 |q 9052/1 |goto Un'Goro Crater 50.40,78.60
|only if Druid
step
click Bloodpetal Sprout##164958
|tip They look like vines entwined in a ball.
|tip They are all over Un'Goro Crater.
collect 8 Bloodcap##22434 |q 9052/2 |goto Un'Goro Crater 71.90,57.40
You Can Find More Around [53.50,14.90]
[34.60,30.60]
|only if Druid
step
talk Torwa Pathfinder##9619
turnin Bloodpetal Poison##9052 |goto Un'Goro Crater 71.63,75.96
accept Toxic Test##9051 |goto Un'Goro Crater 71.63,75.96
|only if Druid
step
use the Devilsaur Barb##22432
|tip Use it on roaming Devilsaur around Un'Goro Crater.
Stab a Devilsaur with the Barb |q 9051/1 |goto Un'Goro Crater 67.31,33.89
|only if Druid
step
talk Torwa Pathfinder##9619
turnin Toxic Test##9051 |goto Un'Goro Crater 71.63,75.96
accept A Better Ingredient##9053 |goto Un'Goro Crater 71.63,75.96
|only if Druid
step
Run up the stairs |goto Swamp of Sorrows 56.28,76.52 < 10 |only if walking
Enter the building |q 9053 |future |goto Swamp of Sorrows 56.33,76.26 < 10 |c
|only if Druid
step
Run up the stairs |goto Swamp of Sorrows/0 69.36,56.89 < 7 |walk
Enter the building and swim under the water |goto Swamp of Sorrows/0 70.54,49.78 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 72.69,42.22 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 75.69,45.78 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 78.62,47.47 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 80.22,49.62 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 81.33,42.38 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 78.86,40.74 < 7 |walk
Run down the ramp |goto Swamp of Sorrows/0 76.85,38.82 < 7 |walk
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 9053 |future
|only if Druid
step
Inside the Temple of Atal'Hakkar Dungeon:
kill Atal'alarion##8580
|tip Refer to the Temple of Atal'Hakkar Dungeon Guide to accomplish that.
collect Putrid Vine##22444 |q 9053/1
|only if Druid
step
talk Torwa Pathfinder##9619
turnin A Better Ingredient##9053 |goto Un'Goro Crater 71.63,75.96
|only if Druid
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Priest Class Quests",{
description="This guide will walk you through completing various Priest Class Quests.",
},[[
step
ding 10
step
Enter the building |goto Durotar 53.24,42.59 < 10 |walk
talk Tai'jin##3706
|tip Inside the building.
accept Hex of Weakness##5652 |goto Durotar 54.26,42.93
|only if Troll Priest
step
talk Ur'kyo##6018
|tip Inside the building.
turnin Hex of Weakness##5652 |goto Orgrimmar 35.59,87.83
|only if Troll Priest
step
talk Father Lankester##4607
accept Touch of Weakness##5658 |goto Undercity 49.14,14.61
|only if Scourge Priest
step
talk Aelthalyste##4606
turnin Touch of Weakness##5658 |goto Undercity 49.27,17.11
|only if Scourge Priest
step
ding 20
step
Enter the cave |goto Thunder Bluff 29.73,29.76
talk Miles Welsh##3044
|tip Inside the cave.
accept Shadowguard##5643 |goto Thunder Bluff 25.32,15.24
|only if Troll Priest
step
talk Ur'kyo##6018
|tip Inside the building.
turnin Shadowguard##5643 |goto Orgrimmar 35.59,87.83
|only if Troll Priest
step
talk Ur'kyo##6018
|tip Upstairs inside the building.
accept Devouring Plague##5644 |goto Orgrimmar 35.59,87.83
|only if Scourge Priest
step
talk Aelthalyste##4606
turnin Devouring Plague##5644 |goto Undercity 49.27,17.11
|only if Scourge Priest
step
ding 52
step
talk Ur'kyo##6018
|tip Inside the building.
accept Cenarion Aid##8254 |goto Orgrimmar 35.60,87.60
|only if Priest
step
talk Ogtinc##8405
turnin Cenarion Aid##8254 |goto Azshara 42.40,42.60
accept Of Coursers We know##8255 |goto Azshara 42.40,42.60
|only if Priest
step
kill Mosshoof Courser##8761
|tip they are scattered all over the area.
collect 4 Healthy Courser Gland##20027 |q 8255/1 |goto Azshara 49.47,17.62
|only if Priest
step
talk Ogtinc##8405
turnin Of Coursers We know##8255 |goto Azshara 42.40,42.60
accept The Ichor of Undeath##8256 |goto Azshara 42.40,42.60
|only if Priest
step
Kill Highborne enemies around this area
collect Ichor of Undeath##7972 |q 8256/1 |goto Winterspring 52.59,40.68
|tip These have a low drop rate.
You can find more around: |notinsticky
[53.62,42.09]
[56.02,44.24]
|only if Priest
step
talk Ogtinc##8405
turnin The Ichor of Undeath##8256 |goto Azshara 42.40,42.60
accept Blood of Morphaz##8257 |goto Azshara 42.40,42.60
|only if Priest
step
Run up the stairs |goto Swamp of Sorrows/0 69.36,56.89 < 7 |walk
Enter the building and swim under the water |goto Swamp of Sorrows/0 70.54,49.78 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 72.69,42.22 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 75.69,45.78 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 78.62,47.47 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 80.22,49.62 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 81.33,42.38 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 78.86,40.74 < 7 |walk
Run down the ramp |goto Swamp of Sorrows/0 76.85,38.82 < 7 |walk
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 9053 |future
|only if Priest
step
Inside the Temple of Atal'Hakkar Dungeon:
kill Morphaz##5719
collect Blood of Morphaz##20025 |q 8257/1
|only if Priest
step
talk Greta Mosshoof##10922
turnin Blood of Morphaz##8257 |goto Felwood 51.20,82.20
|only if Priest
step
ding 58
step
talk Movkar##16012
|tip Inside the building.
accept An Earnest Proposition##8916 |goto Orgrimmar 34.80,38.00
|only if Priest
step
Kill Frostsaber enemies around this area
collect 15 Winterspring Blood Sample##21928 |q 8916/1 |goto Winterspring/0 51.80,9.20
|only if Priest
step
collect Devout Bracers##16697 |q 8916/2
|tip These drop from enemies in Stratholme.
|tip Refer to either Stratholme dungeon guides to accomplish this.
|tip You can also buy them from the Auction House.|only if not selfmade()
|only if Priest
step
Collect 20 Gold |complete _G.GetMoney() >= 2000 |q 8916/3
|only if Priest
step
talk Movkar##16012
|tip Inside the building.
turnin An Earnest Proposition##8916 |goto Orgrimmar 34.80,38.00
|only if Priest
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Warrior Class Quests",{
description="This guide will walk you through completing various Warrior Class Quests.",
},[[
step
ding 10
step
talk Krang Stonehoof##3063
accept Veteran Uzzek##1505 |goto Mulgore 48.34,63.76
|only if Tauren Warrior
step
Enter the building |goto Durotar 53.25,42.59 < 7 |walk
talk Tarshaw Jaggedscar##3169
|tip Inside the building.
accept Veteran Uzzek##1505 |goto Durotar 54.19,42.46
|only if (Orc Warrior) or (Troll Warrior)
step
Leave the building |goto Durotar 53.27,42.59 < 7 |walk |only if (Orc Warrior) or (Troll Warrior)
Follow the road |goto Durotar 50.64,43.97 < 15 |only if walking and ((Orc Warrior) or (Troll Warrior))
Cross the bridge |goto Durotar 34.60,42.31 < 15 |only if walking and ((Orc Warrior) or (Troll Warrior))
talk Uzzek##5810
turnin Veteran Uzzek##1505 |goto The Barrens 61.38,21.11
accept Path of Defense##1498 |goto The Barrens 61.38,21.11
|only if (Orc Warrior) or (Troll Warrior) or (Tauren Warrior)
step
Cross the bridge |goto The Barrens 62.68,19.22 < 15 |only if walking
Follow the path |goto Durotar 39.18,32.15 < 15 |only if walking
kill Thunder Lizard##3130+
|tip Watch for respawns while in the area. |only if hardcore
collect 5 Singed Scale##6486 |q 1498/1 |goto Durotar 39.27,28.29
|only if (Orc Warrior) or (Troll Warrior) or (Tauren Warrior)
step
Follow the path |goto Durotar 39.16,32.31 < 15 |only if walking
Cross the bridge |goto Durotar 34.60,42.28 < 15 |only if walking
talk Uzzek##5810
turnin Path of Defense##1498 |goto The Barrens 61.38,21.11
accept Thun'grim Firegaze##1502 |goto The Barrens 61.38,21.11
|only if (Orc Warrior) or (Troll Warrior) or (Tauren Warrior)
step
Follow the path up |goto The Barrens 55.51,32.40
talk Thun'grim Firegaze##5878
turnin Thun'grim Firegaze##1502 |goto The Barrens 57.23,30.34
accept Forged Steel##1503 |goto The Barrens 57.23,30.34
|only if (Orc Warrior) or (Troll Warrior) or (Tauren Warrior)
step
Follow the path down |goto The Barrens 55.51,32.40
click Stolen Iron Chest##58369
collect Forged Steel Bars##6534 |q 1503/1 |goto The Barrens 55.05,26.66
|only if (Orc Warrior) or (Troll Warrior) or (Tauren Warrior)
step
Follow the path up |goto The Barrens 55.51,32.40
talk Thun'grim Firegaze##5878
turnin Forged Steel##1503 |goto The Barrens 57.23,30.34
|only if (Orc Warrior) or (Troll Warrior) or (Tauren Warrior)
step
talk Austil de Mon##2131
|tip Inside the building.
accept Speak with Dillinger##1818 |goto Tirisfal Glades 61.85,52.54
|only if Scourge Warrior
step
Leave the building |goto Tirisfal Glades 61.56,53.05 < 7 |walk
talk Deathguard Dillinger##1496
turnin Speak with Dillinger##1818 |goto Tirisfal Glades 58.20,51.45
accept Ulag the Cleaver##1819 |goto Tirisfal Glades 58.20,51.45
|only if Scourge Warrior
step
click Doors
kill Ulag the Cleaver##6390 |q 1819/1 |goto Tirisfal Glades 59.64,48.09
|only if Scourge Warrior
step
talk Deathguard Dillinger##1496
turnin Ulag the Cleaver##1819 |goto Tirisfal Glades 58.20,51.45
accept Speak with Coleman##1820 |goto Tirisfal Glades 58.20,51.45
|only if Scourge Warrior
step
Enter the building |goto Tirisfal Glades 61.56,53.04 < 7 |walk
talk Coleman Farthing##1500
|tip Inside the building.
turnin Speak with Coleman##1820 |goto Tirisfal Glades 61.72,52.29
accept Agamand Heirlooms##1821 |goto Tirisfal Glades 61.72,52.29
|only if Scourge Warrior
step
Follow the path up |goto Tirisfal Glades 47.86,47.45 < 20 |only if walking
Enter the crypt |q 1821 |goto Tirisfal Glades 52.25,26.86 < 10 |c |walk
|only if Scourge Warrior
step
click Agamand Weapon Rack##105172
|tip Inside the crypt.
|tip Watch for patrols and respawns while in the area. |only if hardcore
collect Agamand Family Mace##7569 |q 1821/3 |goto Tirisfal Glades 52.66,27.04
|only if Scourge Warrior
step
click Agamand Weapon Rack##105171
|tip Inside the crypt.
|tip Watch for patrols and respawns while in the area. |only if hardcore
collect Agamand Family Dagger##7568 |q 1821/2 |goto Tirisfal Glades 51.89,27.12
|only if Scourge Warrior
step
click Agamand Weapon Rack##105169
|tip Inside the crypt.
|tip Watch for patrols and respawns while in the area. |only if hardcore
collect Agamand Family Axe##7567 |q 1821/1 |goto Tirisfal Glades 51.70,25.69
|only if Scourge Warrior
step
click Agamand Weapon Rack##105170
|tip Inside the crypt.
|tip Watch for patrols and respawns while in the area. |only if hardcore
collect Agamand Family Sword##7566 |q 1821/1 |goto Tirisfal Glades 52.65,25.86
|only if Scourge Warrior
step
Leave the crypt |q 1821 |goto Tirisfal Glades 52.25,26.86 < 10 |walk
Enter the building |goto Tirisfal Glades 61.56,53.04 < 7 |walk
talk Coleman Farthing##1500
|tip Inside the building.
turnin Agamand Heirlooms##1821 |goto Tirisfal Glades 61.72,52.29
|only if Scourge Warrior
step
ding 30
step
Incoming Difficult Quest
|tip You're going to be tasked with surviving the Affray, which is a combat trial.
|tip You'll be tasked with killing waves of enemies with very little downtime afforded in between.
|tip If possible, you may want to get help for this.
Click Here to Continue |confirm |q 1718 |future
|only if Warrior and hardcore
step
Enter the building |goto Orgrimmar 76.52,32.92 < 7 |walk
talk Sorek##3354
|tip Inside the building.
accept The Islander##1718 |goto Orgrimmar 80.38,32.38
|only if Warrior
step
talk Klannoc Macleod##6236
turnin The Islander##1718 |goto The Barrens 68.62,49.17
accept The Affray##1719 |goto The Barrens 68.62,49.17
|only if Warrior
step
Step on the Grate to Begin the Affray |q 1719/1 |goto The Barrens 68.61,48.72
|only if Warrior
step
kill Affray Challenger##6240+
|tip You will have to kill six of them before Big Will will appear.
|tip They will fight them one at a time.
|tip Avoid using AoE abilities as they may aggro the other affray contestants. |only if hardcore
|tip When you defeat an enemy, don't stand near the grate or it will force the next opponent. |only if hardcore
|tip Eat or Bandage after each opponent. |only if hardcore
|tip Step back after each opponent spawns. |only if hardcore
kill Big Will##6238 |q 1719/2 |goto The Barrens 68.61,48.72
|tip It may take a while before he appears.
|only if Warrior
step
talk Klannoc Macleod##6236
turnin The Affray##1719 |goto The Barrens 68.62,49.17
|only if Warrior
step
ding 38
step
collect 8 Liferoot##3357 |q 1712 |future
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Warrior
step
talk Klannoc Macleod##6236
accept The Windwatcher##1791 |goto The Barrens 68.62,49.17
|only if Warrior
step
Follow the path |goto Hillsbrad Foothills 70.63,10.06
talk Bath'rah the Windwatcher##6176
turnin The Windwatcher##1791 |goto Alterac Mountains 80.50,66.92
accept Cyclonian##1712 |goto Alterac Mountains 80.50,66.92
|only if Warrior
step
kill Burning Exile##2760
collect 8 Burning Charm##4479 |q 1712 |future |goto Arathi Highlands 26.60,31.80
|only if Warrior
step
kill Thundering Exile##2762
collect 8 Thundering Charm##4480 |q 1712 |future |goto Arathi Highlands 52.60,52.20
|only if Warrior
step
kill Cresting Exile##2761
collect 8 Cresting Charm##4481 |q 1712 |future |goto Arathi Highlands 68.00,30.00
|only if Warrior
step
Kill Bloodscalp enemies around this area
collect 30 Bloodscalp Tusk##3901 |q 1712/2 |goto Stranglethorn Vale 25.85,11.25
|only if Warrior
step
click Bath'rah's Cauldron##89931
accept Essence of the Exile##1714 |goto Alterac Mountains 79.31,66.81
collect Essence of the Exile##6851 |q 1712/3 |goto Alterac Mountains 79.31,66.81
|only if Warrior
step
Incoming Difficult Quest
|tip "The Summoning" quest coming up after Cyclonian has you facing a level 40 elite enemy.
|tip You will likely need help with this.
Click Here to Continue |confirm |q 1713 |future
|only if Warrior and hardcore
step
talk Bath'rah the Windwatcher##6176
turnin Cyclonian##1712 |goto Alterac Mountains 80.50,66.92
accept The Summoning##1713 |goto Alterac Mountains 80.50,66.92
|only if Warrior
step
Follow Bath'rah the Windwatcher
Watch the Dialogue
kill Cyclonian##6239
|tip You may need help with this.
|tip This is a level 40 Elite enemy. |only if hardcore
collect Whirlwind Heart##6894 |q 1713/1 |goto Alterac Mountains 80.57,62.56
|only if Warrior
step
talk Bath'rah the Windwatcher##6176
turnin The Summoning##1713 |goto Alterac Mountains 80.50,66.92
accept Whirlwind Weapon##1792 |goto Alterac Mountains 80.50,66.92
|only if Warrior
step
ding 52
step
Enter the building |goto Orgrimmar 76.52,32.92 < 7 |walk
talk Sorek##3354
|tip Inside the building.
accept A Troubled Spirit##8417 |goto Orgrimmar 80.38,32.38
|only if Warrior
step
talk Fallen Hero of the Horde##7572
turnin A Troubled Spirit##8417 |goto Swamp of Sorrows 34.29,66.15
accept Warrior Kinship##8423 |goto Swamp of Sorrows 34.29,66.15
|only if Warrior
step
kill 7 Helboar##5993 |q 8423/1 |goto Blasted Lands 51.34,53.45
|only if Warrior
step
talk Fallen Hero of the Horde##7572
turnin Warrior Kinship##8423 |goto Swamp of Sorrows 34.29,66.15
accept War on the Shadowsworn##8424 |goto Swamp of Sorrows 34.29,66.15
|only if Warrior
stickystart "Kill_Shadowsworn_Cultitst"
stickystart "Kill_Shadowsworn_Thug"
step
kill 20	Shadowsworn Adept##6006 |q 8424/1 |goto Blasted Lands 65.17,32.83
|tip Watch for patrols and respawns around this area. |only if hardcore
|only if Warrior
step
label "Kill_Shadowsworn_Cultitst"
kill 10 Shadowsworn Cultist##6004 |q 8424/2 |goto Blasted Lands 65.17,32.83
|tip Watch for patrols and respawns around this area. |only if hardcore |notinsticky
|only if Warrior
step
label "Kill_Shadowsworn_Thug"
kill 20 Shadowsworn Thug##6005 |q 8424/3 |goto Blasted Lands 65.17,32.83
|tip Watch for patrols and respawns around this area. |only if hardcore |notinsticky
|only if Warrior
step
talk Fallen Hero of the Horde##7572
turnin War on the Shadowsworn##8424 |goto Swamp of Sorrows 34.29,66.15
accept Voodoo Feathers##8425 |goto Swamp of Sorrows 34.29,66.15
|only if Warrior
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8425
|only if Warrior and hardcore
step
Run up the stairs |goto Swamp of Sorrows/0 69.36,56.89 < 7 |walk
Enter the building and swim under the water |goto Swamp of Sorrows/0 70.54,49.78 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 72.69,42.22 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 75.69,45.78 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 78.62,47.47 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 80.22,49.62 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 81.33,42.38 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 78.86,40.74 < 7 |walk
Run down the ramp |goto Swamp of Sorrows/0 76.85,38.82 < 7 |walk
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 8425 |future
|only if Warrior
step
Inside the Temple of Atal'Hakkar:
collect 2 Amber Voodoo Feather##20606 |q 8425/1
|tip These come from Gasher and Zul'Lor.
|only if Warrior
step
Inside the Temple of Atal'Hakkar:
collect 2 Blue Voodoo Feather##20607 |q 8425/2
|tip These come from Mijan and Hukku.
|only if Warrior
step
Inside the Temple of Atal'Hakkar:
collect 2 Green Voodoo Feather##20608 |q 8425/3
|tip These come from Zolo and Loro.
|only if Warrior
step
talk Fallen Hero of the Horde##7572
turnin Voodoo Feathers##8425 |goto Swamp of Sorrows 34.29,66.15
|only if Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Hunter Class Quests",{
description="This guide will walk you through completing various Hunter Class Quests.",
},[[
step
ding 10
step
talk Thotar##3171
|tip Inside the building.
accept Taming the Beast##6062 |goto Durotar 51.85,43.49
|only if (Orc Hunter) or (Troll Hunter)
step
use the Taming Rod##15917
|tip Use it on a Dire Mottled Boar around this area.
Tame a Dire Mottled Boar |q 6062/1 |goto Durotar 51.84,47.23
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
|only if (Orc Hunter) or (Troll Hunter)
step
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6062 |goto Durotar 51.85,43.49
accept Taming the Beast##6083 |goto Durotar 51.85,43.49
|only if (Orc Hunter) or (Troll Hunter)
step
Follow the path |goto Durotar 54.36,39.59 < 20 |only if walking
use the Taming Rod##15919
|tip Use it on a Surf Crawler around this area.
Tame a Surf Crawler |q 6083/1 |goto Durotar 59.01,27.64
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
|only if (Orc Hunter) or (Troll Hunter)
step
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6083 |goto Durotar 51.85,43.49
accept Taming the Beast##6082 |goto Durotar 51.85,43.49
|only if (Orc Hunter) or (Troll Hunter)
step
use the Taming Rod##15920
|tip Use it on an Armored Scorpid around this area.
Tame an Armored Scorpid |q 6082/1 |goto Durotar 45.21,45.77
|only if (Orc Hunter) or (Troll Hunter)
step
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6082 |goto Durotar 51.85,43.49
accept Training the Beast##6081 |goto Durotar 51.85,43.49
|only if (Orc Hunter) or (Troll Hunter)
step
Enter Orgrimmar |goto Durotar 45.54,12.06 < 20 |only if walking
Follow the path up |goto Orgrimmar 71.64,25.95 < 15 |only if walking
Follow the path up |goto Orgrimmar 67.68,14.51 < 7 |only if walking
talk Ormak Grimshot##3352
turnin Training the Beast##6081 |goto Orgrimmar 66.05,18.54
|only if (Orc Hunter) or (Troll Hunter)
step
talk Yaw Sharpmane##3065
accept Taming the Beast##6061 |goto Mulgore 46.92,59.69
|only if Tauren Hunter
step
use the Taming Rod##15914
|tip Use it on an Adult Plainstrider around this area.
Tame an Adult Plainstrider |q 6061/1 |goto Mulgore 43.58,56.46
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
You can find more around [40.11,57.35]
|only if Tauren Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast##6061 |goto Mulgore 46.92,59.69
accept Taming the Beast##6087 |goto Mulgore 46.92,59.69
|only if Tauren Hunter
step
use the Taming Rod##15915
|tip Use it on a Prairie Stalker around this area.
Tame a Prairie Stalker |q 6087/1 |goto Mulgore 45.81,54.16
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
|only if Tauren Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast##6087 |goto Mulgore 46.92,59.69
accept Taming the Beast##6088 |goto Mulgore 46.92,59.69
|only if Tauren Hunter
step
use the Taming Rod##15916
|tip Use it on a Swoop around this area.
Tame a Swoop |q 6088/1 |goto Mulgore 45.81,54.16
|only if Tauren Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast#6088 |goto Mulgore 46.92,59.69
accept Training the Beast##6089 |goto Mulgore 46.92,59.69
|only if Tauren Hunter
step
Ride the elevator up |goto Thunder Bluff 31.80,65.96 < 10 |only if walking
Enter the building |goto Thunder Bluff 44.91,61.98 < 15 |only if walking
Cross the bridge |goto Thunder Bluff 47.69,68.75 < 10 |only if walking
Enter the building |goto Thunder Bluff 59.80,82.89 < 15 |walk
talk Holt Thunderhorn##3039
|tip Inside the building.
turnin Training the Beast##6089 |goto Thunder Bluff 57.31,89.76
|only if Tauren Hunter
step
ding 50
|only if not hardcore
step
ding 52
|only if hardcore
step
Follow the path up |goto Orgrimmar 66.46,22.63 < 10 |only if walking
talk Ormak Grimshot##3352
accept The Hunter's Charm##8151 |goto Orgrimmar 66.06,18.54
|only if Hunter
step
Follow the path up |goto Azshara 42.09,42.45
talk Ogtinc##8405
turnin The Hunter's Charm##8151 |goto Azshara 42.40,42.62
accept Courser Antlers##8153 |goto Azshara 42.40,42.62
|only if Hunter
step
kill Mosshoof Courser##8761
|tip they are scattered all over the area.
collect 2 Perfect Courser Antler##20017 |q 8153/1 |goto Azshara 49.47,17.62
|only if Hunter
step
Follow the path up |goto Azshara 42.09,42.45
talk Ogtinc##8405
turnin Courser Antlers##8153 |goto Azshara 42.40,42.62
accept Wavethrashing##8231 |goto Azshara 42.40,42.62
|only if Hunter
step
Jump down here carefully |goto Azshara 33.68,48.68 < 10 |only if walking
Follow the path down |goto Azshara 40.54,47.84 < 15 |only if walking
Kill Wavethrasher enemies around this area
|tip They are underwater around this area.
collect 6 Wavethrasher Scale##20087 |q 8231/1 |goto Azshara 52.61,41.87
You can find more around here [59.77,37.36]
|only if Hunter
step
Follow the path up |goto Azshara 42.09,42.45
talk Ogtinc##8405
turnin Wavethrashing##8231 |goto Azshara 42.40,42.62
accept The Green Drake##8232 |goto Azshara 42.40,42.62
|only if Hunter
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8425
|only if Hunter and hardcore
step
Run up the stairs |goto Swamp of Sorrows/0 69.36,56.89 < 7 |walk
Enter the building and swim under the water |goto Swamp of Sorrows/0 70.54,49.78 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 72.69,42.22 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 75.69,45.78 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 78.62,47.47 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 80.22,49.62 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 81.33,42.38 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 78.86,40.74 < 7 |walk
Run down the ramp |goto Swamp of Sorrows/0 76.85,38.82 < 7 |walk
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 8232 |future
|only if Hunter
step
Inside the Temple of Atal'Hakkar:
kill Morphaz##5719
collect Tooth of Morphaz##20019 |q 8232/1
|only if Hunter
step
Follow the path up |goto Azshara 42.09,42.45
talk Ogtinc##8405
turnin The Green Drake##8232 |goto Azshara 42.40,42.62
|only if Hunter
step
ding 60
step
Incoming Raid Steps
|tip The upcoming quest steps will send you into the Molten Core and Onyxia's Lair raids.
|tip You will need a group to complete them.
Click Here to Continue |confirm |q 7635 |future
|only if Hunter
step
Inside the Molten Core Raid:
kill Majordomo Executus##12018
collect Ancient Petrified Leaf##18703 |n
use the Ancient Petrified Leaf##18703
accept The Ancient Leaf##7632
|only if Hunter
step
talk Vartus the Ancient##14524
|tip Kill enemies around the area for him to appear.
turnin The Ancient Leaf##7632 |goto Felwood 48.99,24.44
accept An Introduction##7633 |goto Felwood 48.99,24.44
accept Stave of the Ancients##7636 |goto Felwood 48.99,24.44
|only if Hunter
step
talk Stoma the Ancient##14525
|tip Kill enemies around the area for him to appear.
accept A Proper String##7635 |goto Felwood 48.31,24.43
|only if Hunter
step
label "Simone_the_Inconspicuous_1"
map Un'Goro Crater
path loop off; dist 20
path	40.60,79.81	39.66,80.76	40.56,83.56	44.20,84.60	44.70,84.97
path	47.33,83.43	48.29,83.07	49.48,82.62	52.88,82.85	54.39,80.58
path	53.25,76.57	52.94,71.85	52.49,70.68	50.94,68.32	48.26,68.82
path	46.33,66.62	45.54,65.95	44.59,63.45	41.43,62.58	41.03,62.86
path	39.76,60.14	40.27,55.85	39.31,48.70	38.48,45.86	38.04,41.96
path	36.18,39.79	35.09,38.14	33.26,37.56	31.74,42.57	31.26,43.64
path	31.58,44.98
Follow the path
talk Simone the Inconspicuous##14527
|tip Use the "Track Demons" ability from the Survival Branch to accomplish this.
|tip She patrols all around Un'Goro Crater.
Select _"Show me your real face, demon."_
kill Simone the Inconspicuous##14527
|tip This must be done alone or it will despawn.
collect Simone's Head##18952 |q 7636/1 |next "Klinfran_the_Crazed_1" |or
'|goto Un'Goro Crater 31.58,44.98 < 20 |noway |or |c |next "Simone_the_Inconspicuous_2"
|only if Hunter
step
label "Simone_the_Inconspicuous_2"
map Un'Goro Crater
path loop off; dist 20
path	34.12,41.24	35.41,41.78	36.58,44.59	37.39,46.16	37.11,50.89
path	38.49,51.80	39.14,53.13	38.36,56.24	38.06,60.14	38.74,65.34
path	39.38,67.27	39.65,69.63	40.89,73.47	41.67,73.78	42.23,75.22
path	42.32,77.27	41.33,78.48	40.66,79.79
Follow the path
talk Simone the Inconspicuous##14527
|tip Use the "Track Demons" ability from the Survival Branch to accomplish this.
|tip She patrols all around Un'Goro Crater.
Select _"Show me your real face, demon."_
kill Simone the Inconspicuous##14527
|tip This must be done alone or it will despawn.
collect Simone's Head##18952 |q 7636/1 |next "Klinfran_the_Crazed_1" |or
'|goto Un'Goro Crater 40.66,79.79 < 20 |noway |or |c |next "Simone_the_Inconspicuous_1"
|only if Hunter
step
label "Klinfran_the_Crazed_1"
map Burning Steppes
path dist 25
path	30.95,53.11	28.61,51.69	26.37,50.79	24.46,49.56	22.35,49.13
path	19.24,49.41	17.32,53.62	17.55,57.76	19.13,59.29	21.32,59.59
path	24.15,62.26	25.60,62.31	25.54,64.65	27.14,62.05	28.46,59.49
path	28.81,56.98	30.04,55.63	29.20,51.92
Follow the path
talk Franklin the Friendly##14529
|tip Use the "Track Demons" ability from the Survival Branch to accomplish this.
|tip He patrols around Burning Steppes.
Select _"Show me your real face, demon."_
kill Klinfran the Crazed##14534
|tip This must be done alone or it will despawn.
collect Klinfran's Head##18953 |q 7636/2
|only if Hunter
step
map Silithus
path dist 20
path	27.18,84.28	25.70,86.85	25.51,88.41	22.00,86.39	21.41,83.81
path	21.45,81.74	23.00,79.45	24.79,76.13	26.93,75.99	28.43,76.18
path	28.98,80.30	29.15,81.69	26.81,84.80
Follow the path
talk Nelson the Nice##14536
|tip Use the "Track Demons" ability from the Survival Branch to accomplish this.
|tip He walks around the area.
Select _"Show me your real face, demon."_
kill Solenor the Slayer##14530
|tip This must be done alone or it will despawn.
collect Solenor's Head##18954 |q 7636/3 |goto Silithus 26.00,81.20
|only if Hunter
step
map Winterspring
path dist 17
path	57.82,21.11	58.43,21.89	58.74,22.81	59.05,23.60	59.71,24.17
path	60.19,23.60	60.38,22.81	60.15,21.85	60.63,21.54	60.84,21.21
path	60.33,20.38	59.94,19.05	59.71,17.37	60.14,16.22	60.62,15.32
path	60.87,14.53	60.51,13.36	59.83,12.09	59.33,12.32	58.73,12.74
path	58.15,13.34	57.93,14.47	58.11,15.96	58.50,17.78	58.22,19.31
path	57.98,20.53
Follow the path
talk Artorius the Amiable##14531
|tip Use the "Track Demons" ability from the Survival Branch to accomplish this.
|tip He walks around the area.
Select _"Show me your real face, demon."_
kill Artorius the Doombringer##14535
|tip This must be done alone or it will despawn and be on a 3 hour timer.
collect Artorius's Head##18955 |q 7636/4 |goto Winterspring 58.20,15.60
|only if Hunter
step
Inside the Onyxia's Lair Raid:
kill Onyxia##10184
collect Mature Black Dragon Sinew##18705 |q 7635/1
|tip This isn't a 100% drop rate.
|only if Hunter
step
talk Vartus the Ancient##14524
|tip Kill enemies around the area for him to appear.
turnin Stave of the Ancients##7636  |goto Felwood 48.99,24.44
|only if Hunter
step
talk Stoma the Ancient##14525
|tip Kill enemies around the area for him to appear.
turnin A Proper String##7635 |goto Felwood 48.31,24.43
|only if Hunter
step
use the Ancient Rune Etched Stave##18707
collect Rhok'delar Longbow of the Ancient Keepers##18713 |n
collect Lok'delar Stave of the Ancient Keepers##18715 |n
|only if Hunter
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Mage Class Quests",{
description="This guide will walk you through completing various Mage Class Quests.",
},[[
step
ding 15
step
talk Uthel'nay##7311
|tip Inside the building.
accept Speak with Un'thuwa##1883 |goto Orgrimmar 39.16,86.27
|only if Mage
step
talk Un'Thuwa##5880
|tip Inside the building.
turnin Speak with Un'thuwa##1883 |goto Durotar 56.31,75.11
accept Ju-Ju Heaps##1884 |goto Durotar 56.31,75.11
|only if Mage
step
click Ju-ju Heap##102986
|tip They look like a pile of skulls.
|tip They are in buildings all around this area.
|tip Watch for patrols and respawns while in the area. |only if hardcore
Destroy 4 Ju-ju Heaps |q 1884/1 |goto Durotar 67.76,83.50
|only if Mage
step
talk Un'Thuwa##5880
|tip Inside the building.
turnin Ju-Ju Heaps##1884 |goto Durotar 56.31,75.11
|only if Mage
step
ding 15
step
talk Uthel'nay##7311
|tip Inside the building.
accept Report to Anastasia##1959 |goto Orgrimmar 39.16,86.27
|only if Mage
step
talk Anastasia Hartwell##4568
turnin Report to Anastasia##1959 |goto Undercity 85.14,10.06
accept Investigate the Alchemist Shop##1960 |goto Undercity 85.14,10.06
|only if Mage
step
click Cantation of Manifestation##105175
|tip It looks like a scroll on the ledge of the wall.
collect Cantation of Manifestation##7308 |q 1960/3 |goto Undercity 85.65,10.00
|only if Mage
step
click Chest of Containment Coffers##105174
|tip It looks like a brown treasure box on the edge of the wall.
collect Chest of Containment Coffers##7247 |q 1960/2 |goto Undercity 85.65,10.00
|only if Mage
step
use the Cantation of Manifestation##7308
|tip Use the "Arcane Explosion" ability after using the Cantation to reveal the enemy.
kill Rift Spawn##6492
use the Chest of Containment Coffers##7247
|tip Use it on the Rift Spawn corpse.
click Filled Containment Coffer
collect 3 Filled Containment Coffer##7292 |q 1960/1 |goto Undercity 52.99,74.92
|only if Mage
step
talk Anastasia Hartwell##4568
turnin Investigate the Alchemist Shop##1960 |goto Undercity 85.14,10.06
accept Gathering Materials##1961 |goto Undercity 85.14,10.06
|only if Mage
stickystart "10_linen"
step
Kill enemies around this area
collect 6 Dalaran Mana Gem##7293 |q 1961/2 |goto Silverpine Forest 62.26,64.24
|tip Keep an eye out for patrols and casters while in the cave. |only if hardcore
|only if Mage
step
label "10_linen"
Kill enemies around this area
|tip Keep an eye out for patrols and casters while in the cave. |only if hardcore |notinsticky
collect 10 Linen Cloth##2589 |q 1961/1 |goto Silverpine Forest 62.26,64.24
|only if Mage
step
talk Josef Gregorian##4576
turnin Gathering Materials##1961 |goto Undercity 70.75,30.69
Watch the Dialogue
accept Spellfire Robes##1962 |goto Undercity 70.75,30.69
|only if Mage
step
ding 26
step
talk Anastasia Hartwell##4568
accept Speak with Deino##1943 |goto Undercity 85.13,9.98
|only if Mage
step
talk Deino##5885
turnin Speak with Deino##1943 |goto Orgrimmar 38.45,86.14
accept Waters of Xavian##1944 |goto Orgrimmar 38.45,86.14
|only if Mage
step
Follow the path up |goto Ashenvale 73.67,50.38 < 15
use Deino's Flask##7269
collect Xavian Water Sample##7268 |q 1944/1 |goto Ashenvale 76.33,41.43
|only if Mage
step
talk Deino##5885
turnin Waters of Xavian##1944 |goto Orgrimmar 38.45,86.14
accept Laughing Sisters##1945 |goto Orgrimmar 38.45,86.14
|only if Mage
step
kill Laughing Sister##4054
|tip Watch for patrols and respawns in the area. |only if hardcore
collect 12 Laughing Sister's Hair##7270 |q 1945/1 |goto Ashenvale 58.61,59.49
You can find more around here [58.25,55.98]
|only if Mage
step
talk Kil'hala##3484
turnin Laughing Sisters##1945 |goto The Barrens 52.20,31.70
accept Nether-lace Garment##1946 |goto The Barrens 52.20,31.70
|only if Mage
step
ding 30
step
talk Deino##5885
|tip Inside the building.
accept Journey to the Marsh##1947 |goto Orgrimmar 38.45,86.14
|only if Mage
step
collect 1 Jade##1529 |q 1948 |future
|tip These are gathered with the Mining profession.
|tip You can also buy them from the Auction House. |only if not selfmade()
|tip Make sure not to accidentally vendor it.
step
talk Tabetha##6546
|tip Inside the building.
turnin Journey to the Marsh##1947 |goto Dustwallow Marsh 46.06,57.09
Watch the Dialogue
accept Hidden Secrets##1949 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
talk Magus Tirth##6548
turnin Hidden Secrets##1949 |goto Thousand Needles 78.29,75.70
accept Get the Scoop##1950 |goto Thousand Needles 78.29,75.70
|only if Mage
step
talk "Plucky" Johnson##6626
|tip Use the "/beckon" Emote to turn him back to a human.
Tell him to _"Please tell me the Phrase..."_
Learn the Secret Phrase |q 1950/1 |goto Thousand Needles 79.60,75.60
|only if Mage
step
talk Magus Tirth##6548
turnin Get the Scoop##1950 |goto Thousand Needles 78.29,75.70
accept Rituals of Power##1951 |goto Thousand Needles 78.29,75.70
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
accept Items of Power##1948 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
Kill Witherbark enemies around this area
|tip They look like trolls.
collect 10 Witherbark Totem Stick##7273 |q 1948 |goto Arathi Highlands 66.66,64.37
|only if Mage
step
use the Witherbark Totem Stick##7273
|tip Clear the enemies around the stones before doing so.
click Bolt Charged Bramble##103662
|tip On top of the rock at the center of the Outer Binding Circle.
collect Bolt Charged Bramble##7272 |q 1948/2 |goto Arathi Highlands 52.06,50.69
|only if Mage
step
collect 1 Jade##1529 |q 1948
|tip You should have collected this earlier.
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Items of Power##1948 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
Incoming Scarlet Monastery (Library) Dungeon:
|tip The upcoming quest steps will send you into the Scarlet Monastery dungeons.
|tip You will need a group to complete them.
Click Here to Continue |confirm |q 1951
|only if Mage and hardcore
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
Enter the Portal |goto Tirisfal Glades/0 85.33,32.27 < 7 |walk
Enter the Scarlet Monastery - Library Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway |q 1951
|only if Mage
step
Inside the Scarlet Monastery Library Dungeon:
click Rituals of Power
|tip In the Athenaeum, to the left of the doorway.
collect Rituals of Power##7274 |q 1951/1
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Rituals of Power##1951  |goto Dustwallow Marsh 46.06,57.09
accept Mage's Wand##1952 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Mage's Wand##1952 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
ding 40
step
talk Anastasia Hartwell##4568
accept Return to the Marsh##1953 |goto Undercity 85.13,9.98
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Return to the Marsh##1953 |goto Dustwallow Marsh 46.06,57.09
accept The Infernal Orb##1954 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
kill Burning Blade Summoner##4668
|tip You may have to look around for them. |only if hardcore
|tip Watch out for patrols and respawns while in the area. |only if hardcore
collect Infernal Orb##7291 |q 1954/1 |goto Desolace 53.34,79.05
|only if Mage
step
Incoming Elite Quest
|tip During the quest "The Exorcism", you will be tasked with killing The Demon of the Orb, which is a level 40 elite enemy.
|tip It will deal a lot of a damage.
|tip If you are unable to get help, you should have your best healing potions ready.
Click Here to Continue |confirm |q 1955 |future
|only if Mage and hardcore
step
talk Tabetha##6546
|tip Inside the building.
turnin The Infernal Orb##1954 |goto Dustwallow Marsh 46.06,57.09
accept The Exorcism##1955 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
kill Demon of the Orb##6549 |q 1955/1 |goto Dustwallow Marsh 46.04,57.10
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin The Exorcism##1955 |goto Dustwallow Marsh 46.06,57.09
accept Power in Uldaman##1956 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Uldaman dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 1956
|only if Mage and hardcore
step
Enter the Uldaman Dungeon with Your Group |goto Uldaman/0 0.00,0.00 < 500 |c |q 1956
|only if Mage
step
Inside the Uldaman Dungeon:
kill Obsidian Sentinel##7023
|tip Use the Uldaman Dungeon guide to accomplish this.
collect Obsidian Power Source##8053 |q 1956/1
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Power in Uldaman##1956 |goto Dustwallow Marsh 46.06,57.09
accept Mana Surges##1957 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
kill Mana Surge##6550
|tip They will spawn continuously as you kill them.
Slay #12# Manage Surges |q 1957/1 |goto Dustwallow Marsh 45.85,56.76
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Mana Surges##1957 |goto Dustwallow Marsh 46.06,57.09
Watch the Dialogue
accept Celestial Power##1958 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
ding 46
step
talk Anastasia Hartwell##4568
accept Tabetha's Task##2861 |goto Undercity 85.13,9.98
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Tabetha's Task##2861 |goto Dustwallow Marsh 46.06,57.09
accept Tiara of the Deep##2846 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Zul'Farrak dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 2846
|only if Mage and hardcore
step
Enter the Zul'Farrak Dungeon with Your Group |goto Zul'Farrak/0 0.00,0.00 < 500 |c |q 2846
step
Inside the Zul'Farrak Dungeon:
kill Hydromancer Velratha##7795
collect Tiara of the Deep##9234 |q 2846/1
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Tiara of the Deep##2846 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
ding 60
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Dire Maul (North) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7463 |future
|only if Mage and hardcore
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 62.49,24.89 < 5 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - North Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 7463 |future
step
Inside the Dire Maul North Dungeon:
talk Lorekeeper Lydros##14368
|tip Through the Conservatory Door in the courtyard.
accept Arcane Refreshment##7463
|only if Mage
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Dire Maul (East) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7463 |future
|only if Mage and hardcore
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
Continue following the path |goto Feralas/0 64.85,30.18 < 7 |only if walking
Enter the Dire Maul - East Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 18299 |future
step
Inside the Dire Maul East Dungeon:
kill Hydrospawn##13280
|tip Refer to the Dire Maul East Dungeon guide to accomplish this.
collect Hydrospawn Essence##18299
|only if Mage
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Dire Maul (North) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7463 |future
|only if Mage and hardcore
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 62.49,24.89 < 5 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - North Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 7463
step
Inside the Dire Maul North Dungeon:
talk Lorekeeper Lydros##14368
|tip Through the Conservatory Door in the courtyard.
turnin Arcane Refreshment##7463
|only if Mage
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Rogue Class Quests",{
description="This guide will walk you through completing various Rogue Class Quests.",
},[[
step
ding 20
|only if not hardcore
step
ding 24
|tip We are waiting until 24 because you will have to deal with an level 23 elite.
|tip You are able to proceed at level 21, but you will likely need help.
Click Here to Continue |confirm |q 2478 |future
|only if hardcore
step
talk Gest##3327
Train the "Pick Lock" Ability |complete knowspell(1804) |goto Orgrimmar 42.71,51.48
|only if Rogue
step
Follow the path |goto The Barrens 62.37,39.44 < 15 |only if walking
Follow the path onto the ship |goto The Barrens 64.18,45.49 < 7 |only if walking
click Buccaneer's Strongbox##123330+
|tip They look like grey metal chests.
|tip Inside the ship, on the middle level.
|tip Keep clicking them until you reach Lockpicking skill level 75.
|tip Watch for patrols and respawns around the area. |only if hardcore
Reach Level 75 in Lockpicking |skill Lockpicking,75 |goto The Barrens 65.07,45.44 |q 2480 |future
|only if Rogue
step
talk Shenthul##3401
|tip Inside the tent, inside the Cleft of Shadow.
accept The Shattered Salute##2460 |goto Orgrimmar 43.05,53.74
|only if Rogue
step
Watch the dialogue
|tip Inside the tent, inside the Cleft of Shadow.
|tip Wait for Shenthul to salute you (you will see him perform a hand movement).
Perform the Shattered Salute |q 2460/1 |goto Orgrimmar 43.05,53.74
|tip Target Shenthul and type "/salute" into your chat to perform the Salute emote.
|only if Rogue
step
talk Shenthul##3401
|tip Inside the tent, inside the Cleft of Shadow.
turnin The Shattered Salute##2460 |goto Orgrimmar 43.05,53.74
accept Deep Cover##2458 |goto Orgrimmar 43.05,53.74
|only if Rogue
step
Follow the road |goto The Barrens 52.37,27.62 < 30 |only if walking
Follow the path |goto The Barrens 54.47,10.25 < 50 |only if walking
use the Flare Gun##8051
|tip Use it while targeting Taskmaster Fizzule nearby to the north.
|tip You must use it TWICE in a row.
|tip After shooting 2 flares, perform the "/salute" emote while still targeting Taskmaster Fizzule.
Signal Taskmaster Fizzule |q 2458/1 |goto The Barrens 55.47,6.08
|only if Rogue
step
talk Taskmaster Fizzule##7233
turnin Deep Cover##2458 |goto The Barrens 55.44,5.56
accept Mission: Possible But Not Probable##2478 |goto The Barrens 55.44,5.56
|only if Rogue
step
collect Silixiz's Tower Key##8072 |q 2478/5 |goto The Barrens 54.80,5.97
|tip Use your "Pickpocket" ability on Foreman Silixiz.
|tip Watch for patrols and respawns while in the area. |only if hardcore
|only if Rogue
step
Enter the building |goto The Barrens 54.87,5.86 < 7 |walk
kill 2 Mutated Venture Co. Drone##7310 |q 2478/1 |goto The Barrens 54.71,5.73
|tip Inside the building, on the bottom floor.
|tip Watch for patrols and respawns while in the area. |only if hardcore
|only if Rogue
step
kill 2 Venture Co. Patroller##7308 |q 2478/3 |goto The Barrens 54.81,5.59
|tip Upstairs inside the building, on the lower middle floor.
|tip Watch for patrols and respawns while in the area. |only if hardcore
|only if Rogue
step
kill 2 Venture Co. Lookout##7307 |q 2478/2 |goto The Barrens 54.63,5.64
|tip Upstairs on the balcony of the building, on the upper middle floor.
|tip Watch for patrols and respawns while in the area. |only if hardcore
|only if Rogue
step
kill Grand Foreman Puzik Gallywix##7288
|tip Upstairs inside the building, on the top floor.
|tip He is elite, but you should be able to kill him. |only if not hardcore
|tip If you have trouble, try to find someone to help you. |only if not hardcore
|tip This enemy is elite. |only if hardcore
|tip You will likely need help with this if you aren't overleveled. |only if hardcore
|tip Only one head per kill will drop.
|tip He will allegedly spawn every 8 to 10 minutes.
collect Cache of Zanzil's Altered Mixture##8073 |q 2478/6 |goto The Barrens 54.75,5.59
collect Gallywix's Head##8074 |q 2478/4 |goto The Barrens 54.75,5.59
|only if Rogue
step
click Gallywix's Lockbox##129127
|tip Upstairs inside the building, on the top floor.
|tip You will get a debuff after opening it.
Receive the Touch of Zanzil |havebuff Touch of Zanzil##9991 |goto The Barrens 54.75,5.55 |q 2478
|only if Rogue
step
Follow the path |goto The Barrens 54.71,9.86 < 50 |only if walking
Follow the road |goto The Barrens 52.13,18.67 < 30 |only if walking
talk Shenthul##3401
|tip Inside the tent, inside the Cleft of Shadow.
turnin Mission: Possible But Not Probable##2478 |goto Orgrimmar 43.05,53.74
accept Hinott's Assistance##2479 |goto Orgrimmar 43.05,53.74
|only if Rogue
step
_Note for Rogues:_
|tip Now we need to travel to Tarren Mill in Hillsbrad Foothills.
|tip That's where you will complete your class quest.
|tip It's a long run, but it will improve your leveling by allowing you to learn to make Poisons.
Click Here to Continue |confirm |q 2480 |future
|only if Rogue
step
Enter Undercity |goto Tirisfal Glades 61.86,65.03 < 15 |only if walking
talk Michael Garrett##4551
fpath Undercity |goto Undercity 63.28,48.58
|only if Rogue
step
Leave Undercity |goto Undercity 66.19,0.63 < 10 |walk
Follow the road |goto Tirisfal Glades 56.17,65.88 < 30|only if walking
Continue following the road |goto Silverpine Forest 58.14,12.21 < 30 |only if walking
Cross the bridge |goto Silverpine Forest 49.75,28.82 < 15 |only if walking
Follow the road |goto Silverpine Forest 48.71,38.60 < 30 |only if walking
talk Karos Razok##2226
fpath The Sepulcher |goto Silverpine Forest 45.62,42.59
|only if Rogue
step
Follow the road |goto Silverpine Forest 46.48,41.31 < 20 |only if walking
Continue following the road |goto Silverpine Forest 52.85,43.92 < 30 |only if walking
Continue following the road |goto Silverpine Forest 53.88,73.53 < 30 |only if walking
Enter Hillsbrad Foothills |goto Silverpine Forest 66.87,80.22 < 30 |only if walking
Follow the road |goto Hillsbrad Foothills 57.51,36.04 < 30 |only if walking
talk Zarise##2389
fpath Tarren Mill |goto Hillsbrad Foothills 60.14,18.62
|only if Rogue
step
Enter the building |goto Hillsbrad Foothills 61.50,19.43 < 7 |walk
talk Serge Hinott##2391
|tip Inside the building.
turnin Hinott's Assistance##2479 |goto Hillsbrad Foothills 61.63,19.19
accept Hinott's Assistance##2480 |goto Hillsbrad Foothills 61.63,19.19
|only if Rogue
step
Watch the dialogue
|tip Inside the building.
Complete the Cure |q 2480/1 |goto Hillsbrad Foothills 61.49,18.95
|only if Rogue
step
talk Serge Hinott##2391
|tip Inside the building.
turnin Hinott's Assistance##2480 |goto Hillsbrad Foothills 61.58,18.97
|only if Rogue
step
use Hinott's Oil##8095
Remove the Touch of Zanzil |nobuff Touch of Zanzil##9991
|only if Rogue
step
ding 50
|only if not hardcore
step
ding 52
|only if hardcore
step
talk Ormok##3328
accept A Simple Request##8233 |goto Orgrimmar 43.91,54.62
|only if Rogue
step
Follow the road up |goto Hillsbrad Foothills 75.51,23.52 < 10 |only if walking
Enter the cave |goto Hillsbrad Foothills 77.82,19.27 < 10 |walk
Follow the path |goto Alterac Mountains 81.71,77.48 < 10 |only if walking
Enter the building |goto Alterac Mountains 85.46,79.39 < 10 |walk
talk Lord Jorach Ravenholdt##6768
turnin A Simple Request##8233 |goto Alterac Mountains 86.03,78.88
accept Sealed Azure Bag##8234 |goto Alterac Mountains 86.03,78.88
|only if Rogue
step
kill Timbermaw Shaman##6188
collect Sealed Azure Bag##19775 |q 8234/1 |goto Azshara 43.77,25.56
You can find more around:
[41.49,19.55]
|only if Rogue
step
talk Sanath Lim-yo##8395
accept Meeting with the Master##3503 |goto Azshara 28.11,50.09
|only if Rogue
step
Follow the path up |goto Azshara 26.48,44.23 < 15 |only if walking
talk Archmage Xylem##8379
|tip Inside the tower.
turnin Sealed Azure Bag##8234 |goto Azshara 29.71,40.52
accept Encoded Fragments##8235 |goto Azshara 29.71,40.52
|only if Rogue
step
Follow the path down |goto Azshara 27.04,43.31 < 15 |only if walking
talk Nyrill##8399
accept Return Trip##3421 |goto Azshara 36.13,67.82
|only if Rogue
step
kill Forest Ooze##8766
collect 10 Encoded Fragment##20023 |q 8235/1 |goto Azshara 73.40,25.20
You can find more around
[80.13,24.75]
[72.71,23.53]
[74.59,13.08]
[66.10,22.93]
|only if Rogue
step
talk Sanath Lim-yo##8395
accept Meeting with the Master##3503 |goto Azshara 28.11,50.09
|only if Rogue
step
Follow the path up |goto Azshara 26.48,44.23 < 15 |only if walking
talk Archmage Xylem##8379
|tip Inside the tower.
turnin Encoded Fragments##8235 |goto Azshara 29.71,40.52
accept The Azure Key##8236 |goto Azshara 29.71,40.52
|only if Rogue
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8425
|only if Rogue and hardcore
step
Run up the stairs |goto Swamp of Sorrows/0 69.36,56.89 < 7 |walk
Enter the building and swim under the water |goto Swamp of Sorrows/0 70.54,49.78 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 72.69,42.22 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 75.69,45.78 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 78.62,47.47 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 80.22,49.62 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 81.33,42.38 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 78.86,40.74 < 7 |walk
Run down the ramp |goto Swamp of Sorrows/0 76.85,38.82 < 7 |walk
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 8236 |future
|only if Rogue
step
Inside the Temple of Atal'Hakkar:
kill Morphaz##5719
|tip Refer to the Temple of Atal'Hakkar Dungeon guide to accomplish this.
collect Azure Key##20022 |q 8236/1
|only if Rogue
step
Follow the road up |goto Hillsbrad Foothills 75.51,23.52 < 10 |only if walking
Enter the cave |goto Hillsbrad Foothills 77.82,19.27 < 10 |walk
Follow the path |goto Alterac Mountains 81.71,77.48 < 10 |only if walking
Enter the building |goto Alterac Mountains 85.46,79.39 < 10 |walk
talk Lord Jorach Ravenholdt##6768
turnin The Azure Key##8236|goto Alterac Mountains 86.03,78.88
|only if Rogue
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Shaman Class Quests",{
description="This guide will walk you through completing various Shaman Class Quests.",
},[[
step
ding 4
step
talk Seer Ravenfeather##5888
accept Call of Earth##1519 |goto Mulgore 44.35,76.76
|only if Tauren Shaman
step
kill Bristleback Shaman##2953+
|tip They can be pretty spread out around this area.
collect 2 Ritual Salve##6634 |q 1519/1 |goto Mulgore 60.30,80.23
You can find more around [59.92,75.65]
|only if Tauren Shaman
step
talk Seer Ravenfeather##5888
turnin Call of Earth##1519 |goto Mulgore 44.35,76.77
accept Call of Earth##1520 |goto Mulgore 44.35,76.77
|only if Tauren Shaman
step
use the Earth Sapta##6635
talk the Minor Manifestation of Earth##5891
turnin Call of Earth##1520 |goto Mulgore 51.97,80.41
accept Call of Earth##1521 |goto Mulgore 51.97,80.41
|only if Tauren Shaman
step
talk Seer Ravenfeather##5888
turnin Call of Earth##1521 |goto Mulgore 44.35,76.77
|only if Tauren Shaman
step
talk Canaga Earthcaller##5887
accept Call of Earth##1516 |goto Durotar 42.41,69.17
|only if (Orc Shaman) or (Troll Shaman)
step
kill Felstalker##3102+
|tip Inside the cave.
collect 2 Felstalker Hoof##6640 |q 1516/1 |goto Durotar 44.82,54.59
|only if (Orc Shaman) or (Troll Shaman)
step
talk Canaga Earthcaller##5887
turnin Call of Earth##1516 |goto Durotar 42.41,69.17
accept Call of Earth##1517 |goto Durotar 42.41,69.17
|only if (Orc Shaman) or (Troll Shaman)
step
Follow the path |goto Durotar 43.57,69.85 < 20 |only if walking
Follow the path up |goto Durotar 41.56,73.28 < 15 |only if walking
Continue up the path |goto Durotar 40.74,74.35 < 10 |only if walking
Follow the path |goto Durotar 42.49,74.89 < 10 |only if walking
use the Earth Sapta##6635
talk Minor Manifestation of Earth##5891
turnin Call of Earth##1517 |goto Durotar 44.03,76.20
accept Call of Earth##1518 |goto Durotar 44.03,76.20
|only if (Orc Shaman) or (Troll Shaman)
step
Jump down here |goto Durotar 43.73,74.92 < 10 |only if walking
Follow the path |goto Durotar 43.49,69.67 < 30 |only if walking
talk Canaga Earthcaller##5887
turnin Call of Earth##1518 |goto Durotar 42.41,69.17
|only if (Orc Shaman) or (Troll Shaman)
step
ding 10
|only if not hardcore
step
ding 12
|only if hardcore
step
Enter the building |goto Durotar 53.25,42.59 < 7 |walk
talk Swart##3173
|tip Inside the building.
accept Call of Fire##2983 |goto Durotar 54.42,42.58
|only if (Orc Shaman) or (Troll Shaman)
step
talk Narm Skychaser##3066
|tip Inside the building.
accept Call of Fire##2984 |goto Mulgore 47.40,62.58
|only if Tauren Shaman
step
Leave the building |goto Durotar 53.27,42.59 < 7 |walk |only if Orc or Troll
Follow the road |goto Durotar 50.64,43.97 < 15 |only if walking |only if Orc or Troll
Cross the bridge |goto Durotar 34.60,42.31 < 15 |only if walking |only if Orc or Troll
talk Kranal Fiss##5907
turnin Call of Fire##2983 |goto The Barrens 56.03,19.89 |only if Orc or Troll
turnin Call of Fire##2984 |goto The Barrens 56.03,19.89 |only if Tauren
accept Call of Fire##1524 |goto The Barrens 56.03,19.89
|only if Shaman
step
Cross the bridge |goto The Barrens 62.67,19.22 < 15 |only if walking
Follow the path up |goto Durotar 36.59,57.07 < 10 |only if walking
Continue up the path |goto Durotar 36.61,58.19 < 5 |only if walking
Continue up the path |goto Durotar 37.74,58.24 < 5 |only if walking
Continue up the path |goto Durotar 38.94,57.56 < 5 |only if walking
Follow the path |goto Durotar 39.18,58.63 < 5 |only if walking
talk Telf Joolam##5900
|tip On top of the mountain.
turnin Call of Fire##1524 |goto Durotar 38.55,58.96
accept Call of Fire##1525 |goto Durotar 38.55,58.96
|only if Shaman
step
Follow the path down |goto Durotar 39.21,58.52 < 7 |only if walking
Follow the path |goto The Barrens 61.47,20.86 < 40 |only if walking
Kill Razormane enemies around this area
|tip Watch for patrols and respawns while in the area. |only if hardcore
collect Fire Tar##5026 |q 1525/1 |goto The Barrens 54.15,25.01
|only if Shaman
step
Cross the bridge |goto The Barrens 62.67,19.23 < 15 |only if walking
Follow the path |goto Durotar 50.78,43.81 < 15 |only if walking
Continue following the path |goto Durotar 54.15,40.72 < 15 |only if walking
Enter the cave |goto Durotar 52.82,28.82 < 10 |walk
Follow the path |goto Durotar 53.07,27.09 < 10 |walk
kill Burning Blade Cultist##3199+
|tip Inside the cave.
|tip They seem to mostly be towards the back of the cave.
|tip Watch for patrols and respawns while in the area. |only if hardcore
collect Reagent Pouch##6652 |q 1525/2 |goto Durotar 52.12,24.95
|only if Shaman
step
Follow the path |goto Durotar 53.13,27.27 < 10 |walk
Leave the cave |goto Durotar 52.83,28.93 < 10 |walk
Jump down onto the huge long rock |goto Durotar 51.97,31.29 < 15 |only if walking
Follow the path up |goto Durotar 36.59,57.07 < 10 |only if walking
Continue up the path |goto Durotar 36.61,58.19 < 5 |only if walking
Continue up the path |goto Durotar 37.74,58.24 < 5 |only if walking
Continue up the path |goto Durotar 38.94,57.56 < 5 |only if walking
Follow the path |goto Durotar 39.18,58.63 < 5 |only if walking
talk Telf Joolam##5900
|tip On top of the mountain.
turnin Call of Fire##1525 |goto Durotar 38.55,58.96
accept Call of Fire##1526 |goto Durotar 38.55,58.96
|only if Shaman
step
Follow the path up |goto Durotar 38.34,58.52 < 5 |only if walking
use the Fire Sapta##6636
kill Minor Manifestation of Fire##5893
|tip On top of the mountain.
|tip It will be immune to fire damage. |only if hardcore
collect Glowing Ember##6655 |q 1526/1 |goto Durotar 38.84,58.24
|only if Shaman
step
click Brazier of the Dormant Flame##61934
|tip On top of the mountain.
turnin Call of Fire##1526 |goto Durotar 38.95,58.22
accept Call of Fire##1527 |goto Durotar 38.95,58.22
|only if Shaman
step
Follow the path down |goto Durotar 39.19,57.81 < 5 |only if walking
talk Kranal Fiss##5907
turnin Call of Fire##1527 |goto The Barrens 56.04,19.89
|only if Shaman
step
ding 20
step
Enter the building |goto Orgrimmar 40.21,36.95 < 15 |walk
talk Searn Firewarder##5892
|tip Inside the building.
|tip We run back to Crossroads first, instead of hearthing.
|tip We are saving your hearthstone to use in Hillsbrad Foothills, to return to Crossroads quickly.
accept Call of Water##1528 |goto Orgrimmar 37.96,37.74
|only if Shaman
step
talk Islen Waterseer##5901
turnin Call of Water##1528 |goto The Barrens 65.83,43.78
accept Call of Water##1530 |goto The Barrens 65.83,43.78
|only if Shaman
step
Follow the road |goto The Barrens 46.12,67.29 < 30 |only if walking
Follow the path up |goto The Barrens 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1530 |goto The Barrens 43.42,77.41
accept Call of Water##1535 |goto The Barrens 43.42,77.41
|only if Shaman
step
use the Empty Brown Waterskin##7766
collect Filled Brown Waterskin##7769 |q 1535/1 |goto The Barrens/0 44.19,76.90
|only if Shaman
step
Follow the path up |goto The Barrens/0 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1535 |goto The Barrens/0 43.42,77.41
accept Call of Water##1536 |goto The Barrens/0 43.42,77.41
|only if Shaman
step
use the Empty Red Waterskin##7768
collect Filled Red Waterskin##7771 |q 1536/1 |goto Hillsbrad Foothills 62.15,20.75
|only if Shaman
step
Follow the road |goto The Barrens 46.12,67.29 < 30 |only if walking
Follow the path up |goto The Barrens 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1536 |goto The Barrens 43.42,77.41
accept Call of Water##1534 |goto The Barrens 43.42,77.41
|only if Shaman
step
Follow the path |goto The Barrens 38.83,58.05 < 30 |only if walking
use the Empty Blue Waterskin##7767
collect Filled Blue Waterskin##7770 |q 1534/1 |goto Ashenvale 33.55,67.44
|only if Shaman
step
Follow the road |goto The Barrens 46.12,67.29 < 30 |only if walking
Follow the path up |goto The Barrens 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1534 |goto The Barrens 43.42,77.41
accept Call of Water##220 |goto The Barrens 43.42,77.41
|only if Shaman
step
Follow the road |goto The Barrens 46.85,65.69 < 30 |only if walking
talk Islen Waterseer##5901
turnin Call of Water##220 |goto The Barrens 65.83,43.78
accept Call of Water##63 |goto The Barrens 65.83,43.78
|only if Shaman
step
Jump up onto the tree |goto Silverpine Forest/0 42.02,40.67 < 5
Jump down carefully |goto Silverpine Forest/0 39.70,40.98 < 10
Follow the path |goto Silverpine Forest/0 39.09,43.05 < 10
use the Water Sapta##6637
kill Corrupt Water Manifestation##5894
collect Corrupt Manifestation's Bracers##7812 |q 63/1 |goto Silverpine Forest/0 38.84,44.25
|only if Shaman
step
click Brazier of Everfount
turnin Call of Water##63 |goto Silverpine Forest 38.28,44.56
accept Call of Water##100 |goto Silverpine Forest 38.28,44.56
|only if Shaman
step
Watch the dialogue
talk Minor Manifestation of Water##5895
turnin Call of Water##100 |goto Silverpine Forest 38.75,44.62
accept Call of Water##96 |goto Silverpine Forest 38.75,44.62
|only if Shaman
step
talk Islen Waterseer##5901
turnin Call of Water##96 |goto The Barrens 65.83,43.78
|only if Shaman
step
ding 30
step
Enter the building |goto Orgrimmar 40.25,36.98 < 10 |walk
talk Searn Firewarder##5892
|tip Inside the building.
accept Call of Air##1531 |goto Orgrimmar 37.97,37.73
|only if Shaman
step
Follow the path up |goto Thousand Needles 54.68,44.78 < 15 |only if walking
talk Prate Cloudseer##5905
turnin Call of Air##1531 |goto Thousand Needles 53.54,42.65
|only if Shaman
step
ding 52
step
collect 1 Elemental Air##7069
|tip Refer to the "Elemental Air" farming guide to accomplish this.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Shaman
step
collect 1 Elemental Fire##7068
|tip Refer to the "Elemental Fire" farming guide to accomplish this.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Shaman
step
collect 1 Elemental Earth##7067
|tip Refer to the "Elemental Earth" farming guide to accomplish this.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Shaman
step
collect 1 Elemental Water##7070
|tip Refer to the "Elemental Water" farming guide to accomplish this.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Shaman
step
talk Beram Skychaser##3032
|tip Inside the building.
accept Elemental Mastery##8410 |goto Thunder Bluff 22.80,19.40
|only if Shaman
step
talk Bath'rah the Windwatcher##6176
turnin Elemental Mastery##8410 |goto Alterac Mountains 80.50,66.92
accept Spirit Totem##8412 |goto Alterac Mountains 80.50,66.92
|only if Shaman
stickystart "Thick_Black_Claw"
step
Kill enemies around this area
collect 8 Bloodshot Spider Eye##20610 |q 8412/1 |goto Western Plaguelands 33.60,60.40
You can find more around here [58.40,53.60]
|only if Shaman
step
label "Thick_Black_Claw"
Kill enemies around this area
collect 8 Thick Black Claw##20611 |q 8412/2 |goto Western Plaguelands 33.60,60.40
You can find more around here [58.40,53.60]
|only if Shaman
step
talk Bath'rah the Windwatcher##6176
turnin Spirit Totem##8412 |goto Alterac Mountains 80.50,66.92
accept Da Voodoo##8413 |goto Alterac Mountains 80.50,66.92
|only if Shaman
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8425
|only if Shaman and hardcore
step
Run up the stairs |goto Swamp of Sorrows/0 69.36,56.89 < 7 |walk
Enter the building and swim under the water |goto Swamp of Sorrows/0 70.54,49.78 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 72.69,42.22 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 75.69,45.78 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 78.62,47.47 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 80.22,49.62 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 81.33,42.38 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 78.86,40.74 < 7 |walk
Run down the ramp |goto Swamp of Sorrows/0 76.85,38.82 < 7 |walk
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 8413 |future
|only if Shaman
stickystart "Blue_Voodoo_Feathers"
stickystart "Green_Voodoo_Feathers"
step
Inside the Temple of Atal'Hakkar:
collect 2 Amber Voodoo Feather##20606 |q 8413/1
|tip These come from Gasher and Zul'Lor.
|only if Shaman
step
label "Blue_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar:
collect 2 Blue Voodoo Feather##20607 |q 8413/2
|tip These come from Mijan and Hukku.
|only if Shaman
step
label "Green_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar:
collect 2 Green Voodoo Feather##20608 |q 8413/3
|tip These come from Zolo and Loro.
|only if Shaman
step
talk Bath'rah the Windwatcher##6176
turnin Da Voodoo##8413 |goto Alterac Mountains 80.50,66.92
|only if Shaman
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Warlock Class Quests",{
description="This guide will walk you through completing various Warlock Class Quests.",
},[[
step
talk Ruzan##5765
accept Vile Familiars##1485 |goto Durotar 42.59,69.00
|only if Orc Warlock
step
kill Vile Familiar##3101+
|tip Inside and outside the cave.
collect 6 Vile Familiar Head##6487 |q 1485/1 |goto Durotar 45.34,56.36
|only if Orc Warlock
step
talk Ruzan##5765
turnin Vile Familiars##1485 |goto Durotar 42.59,69.00
accept Vile Familiars##1499 |goto Durotar 42.59,69.00
|only if Orc Warlock
step
talk Zureetha Fargaze##3145
turnin Vile Familiars##1499 |goto Durotar 42.85,69.15
|only if Orc Warlock
step
talk Venya Marthand##5667
|tip Inside the building.
accept Piercing the Veil##1470 |goto Tirisfal Glades 30.98,66.41
|only if Scourge Warlock
step
kill Rattlecage Skeleton##1890+
collect 3 Rattlecage Skull##6281 |q 1470/1 |goto Tirisfal Glades 32.73,60.10
|only if Scourge Warlock
step
talk Venya Marthand##5667
|tip Inside the building.
turnin Piercing the Veil##1470 |goto Tirisfal Glades 30.98,66.41
|only if Scourge Warlock
step
ding 10
step
Enter the building |goto Tirisfal Glades 61.56,53.04 < 7 |walk
talk Ageron Kargal##5724
|tip Upstairs inside the building.
accept Halgar's Summons##1478 |goto Tirisfal Glades 61.62,52.67
|only if Scourge Warlock
step
Leave the building |goto Tirisfal Glades 61.56,53.06 < 7 |walk
Enter Undercity |goto Tirisfal Glades 61.88,65.06 < 10 |only if walking
talk Carendin Halgar##5675
turnin Halgar's Summons##1478 |goto Undercity 85.04,26.01
accept Creature of the Void##1473 |goto Undercity 85.04,26.01
|only if Scourge Warlock
step
Leave Undercity |goto Undercity 66.23,0.23 < 10 |walk
Enter the building |goto Tirisfal Glades 51.44,67.70 < 7 |walk
click Perrine's Chest
|tip Inside the building.
collect Egalin's Grimoire##6285 |q 1473/1 |goto Tirisfal Glades 51.06,67.57
|only if Scourge Warlock
step
Leave the building |goto Tirisfal Glades 51.44,67.69 < 7 |walk
Enter Undercity |goto Tirisfal Glades 61.88,65.06 < 10 |only if walking
talk Carendin Halgar##5675
turnin Creature of the Void##1473 |goto Undercity 85.04,26.01
accept The Binding##1471 |goto Undercity 85.04,26.01
|only if Scourge Warlock
step
use the Runes of Summoning##6284
|tip Use them on the pink symbol on the ground.
kill Summoned Voidwalker##5676 |q 1471/1 |goto Undercity 86.62,27.10
|tip Don't forget to summon your imp. |only if hardcore
|only if Scourge Warlock
step
talk Carendin Halgar##5675
turnin The Binding##1471 |goto Undercity 85.04,26.01
|only if Scourge Warlock
step
talk Ophek##3294
|tip Outside, behind the building.
accept Gan'rul's Summons##1506 |goto Durotar 54.37,41.29
|only if Orc Warlock
step
Follow the road |goto Durotar 52.37,40.01 < 30 |only if walking
Enter Orgrimmar |goto Durotar 45.54,12.06 < 20 |only if walking
Follow the path |goto Orgrimmar 51.55,58.13 < 20 |only if walking
Follow the path down |goto Orgrimmar 55.96,41.03 < 15 |walk
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin Gan'rul's Summons##1506 |goto Orgrimmar 48.24,45.29
accept Creature of the Void##1501 |goto Orgrimmar 48.24,45.29
|only if Orc Warlock
step
Follow the path up |goto Orgrimmar 43.93,56.80 < 10 |walk
Follow the path |goto Orgrimmar 38.49,54.16 < 10 |walk
Follow the path |goto Orgrimmar 52.50,85.13 < 20 |only if walking
Leave Orgrimmar |goto Orgrimmar 49.10,94.75 < 20 |only if walking
Enter the cave |goto Durotar 55.02,9.79 < 10 |walk
Follow the path |goto Durotar 53.80,8.83 < 10 |walk
Continue following the path |goto Durotar 52.75,7.87 < 10 |walk
Continue following the path |goto Durotar 51.68,8.23 < 10 |walk
click Burning Blade Stash##58595
|tip Inside the cave.
collect Tablet of Verga##6535 |q 1501/1 |goto Durotar 51.62,9.74
|only if Orc Warlock
step
Follow the path |goto Durotar 51.73,8.10 < 10 |walk
Continue following the path |goto Durotar 52.49,8.31 < 10 |walk
Continue following the path |goto Durotar 54.20,8.92 < 10 |walk
Leave the cave |goto Durotar 55.03,9.87 < 10 |walk
Enter Orgrimmar |goto Durotar 45.54,12.06 < 20 |only if walking
Follow the path |goto Orgrimmar 51.55,58.13 < 20 |only if walking
Follow the path down |goto Orgrimmar 55.96,41.03 < 10 |walk
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin Creature of the Void##1501 |goto Orgrimmar 48.24,45.29
accept The Binding##1504 |goto Orgrimmar 48.24,45.29
|only if Orc Warlock
step
use Glyphs of Summoning##7464
|tip Use it while standing on the pink symbol on the ground.
|tip Inside the tent.
kill Summoned Voidwalker##5676 |q 1504/1 |goto Orgrimmar 49.44,50.02
|only if Orc Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin The Binding##1504 |goto Orgrimmar 48.24,45.29
|only if Orc Warlock
step
ding 20
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent, inside the Cleft of Shadow.
accept Devourer of Souls##1507 |goto Orgrimmar 48.25,45.29
|only if Warlock
step
talk Cazul##5909
turnin Devourer of Souls##1507 |goto Orgrimmar 47.06,46.48
accept Blind Cazul##1508 |goto Orgrimmar 47.06,46.48
|only if Warlock
step
Follow the path up |goto Orgrimmar 43.93,56.92 < 15 |walk
Follow the path |goto Orgrimmar 38.40,54.26 < 20 |only if walking
Enter the building |goto Orgrimmar 38.07,60.65 < 15 |walk
talk Zankaja##5910
|tip Inside the building.
turnin Blind Cazul##1508 |goto Orgrimmar 37.03,59.45
accept News of Dogran##1509 |goto Orgrimmar 37.03,59.45
|only if Warlock
step
talk Gazrog##3464
turnin News of Dogran##1509 |goto The Barrens 51.93,30.32
accept News of Dogran##1510 |goto The Barrens 51.93,30.32
|only if Warlock
step
Follow the road |goto The Barrens 50.82,29.07 < 20 |only if walking
Follow the road |goto The Barrens 39.39,29.65 < 30 |only if walking
Follow the path up |goto Stonetalon Mountains 82.07,98.57 < 15 |only if walking
Follow the path |goto Stonetalon Mountains 77.19,98.73 < 15 |only if walking
Jump down here |goto Stonetalon Mountains 75.01,97.08 < 15 |only if walking
talk Ken'zigla##4197
turnin News of Dogran##1510 |goto Stonetalon Mountains 73.25,95.12
accept Ken'zigla's Draught##1511 |goto Stonetalon Mountains 73.25,95.12
|only if Warlock
step
Follow the path up |goto Stonetalon Mountains 72.89,93.73 < 15 |only if walking
Follow the path |goto Stonetalon Mountains 77.33,98.72 < 15 |only if walking
Follow the road |goto The Barrens 35.84,27.53 < 30 |only if walking
Continue following the road |goto The Barrens 39.43,29.70 < 30 |only if walking
Follow the path |goto The Barrens 50.83,29.09 < 20 |only if walking
talk Grunt Logmar##5911
turnin Ken'zigla's Draught##1511 |goto The Barrens 44.62,59.27
accept Dogran's Captivity##1515 |goto The Barrens 44.62,59.27
|only if Warlock
step
talk Grunt Dogran##5908
|tip Inside the hut.
turnin Dogran's Captivity##1515 |goto The Barrens 43.31,47.89
accept Love's Gift##1512 |goto The Barrens 43.31,47.89
|only if Warlock
step
Follow the path down |goto Orgrimmar 39.74,53.78 < 20 |walk
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin Love's Gift##1512 |goto Orgrimmar 48.25,45.29
accept The Binding##1513 |goto Orgrimmar 48.25,45.29
|only if Warlock
step
use Dogran's Pendant##6626
|tip Use it while standing on the pink symbol on the ground.
|tip Inside the tent.
kill Summoned Succubus##5677 |q 1513/1 |goto Orgrimmar 49.45,50.03
|only if Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin The Binding##1513 |goto Orgrimmar 48.24,45.29
|only if Warlock
step
ding 30
step
talk Gan'rul Bloodeye##5875
|tip Inside the building.
accept Seeking Strahad##2996 |goto Orgrimmar 48.24,45.30
|only if Warlock
step
Follow the path up |goto The Barrens 61.93,36.72 < 15
talk Strahad Farsan##6251
turnin Seeking Strahad##2996 |goto The Barrens 62.63,35.50
accept Tome of the Cabal##1801 |goto The Barrens 62.63,35.50
|only if Warlock
step
talk Jorah Annison##6293
turnin Tome of the Cabal##1758 |goto Undercity 75.91,37.87
accept Tome of the Cabal##1803 |goto Undercity 75.91,37.87
|only if Warlock
step
Follow the path down |goto Hillsbrad Foothills 36.94,65.37 < 30 |only if walking
click Tome of the Cabal##92013
|tip It looks like a blue book on the ground next to some crates.
collect Moldy Tome##6931 |q 1803/1 |goto Hillsbrad Foothills 27.78,72.78
|only if Warlock
step
Enter the cave |goto Thousand Needles 44.09,37.29 < 10 |walk
click Damaged Chest##92423
collect Tattered Manuscript##6997 |q 1803/2 |goto Thousand Needles 43.43,32.69
|only if Warlock
step
talk Jorah Annison##6293
turnin Tome of the Cabal##1803 |goto Undercity 75.91,37.87
accept Tome of the Cabal##1805 |goto Undercity 75.91,37.87
|only if Warlock
step
Follow the path up |goto Wetlands 42.83,41.04
Kill Dragonmaw enemies around this area
collect 3 Rod of Channeling##6930 |q 1805/1 |goto Wetlands 45.09,43.08
|tip They drop from Dragonmaw Bonewarders and Shadowwarders.
You can find more around here [49.48,48.47]
|only if Warlock
step
Follow the path up |goto The Barrens 61.93,36.72 < 15
talk Strahad Farsan##6251
turnin Tome of the Cabal##1805 |goto The Barrens 62.63,35.50
accept The Binding##1471 |goto The Barrens 62.63,35.50
|only if Warlock
step
use the Tome of the Cabal##6999
|tip Use it inside the building.
kill Summoned Felhunter##6268 |q 1471/1 |goto The Barrens 62.60,35.28
|only if Warlock
step
talk Strahad Farsan##6251
turnin The Binding##1471 |goto The Barrens 62.63,35.50
|only if Warlock
step
ding 40
step
talk Zevrost##3326
|tip Inside the building.
accept Summon Felsteed##3631 |goto Orgrimmar 48.48,45.44
|only if Warlock
step
Follow the path up |goto The Barrens 61.93,36.72 < 15
talk Strahad Farsan##6251
turnin Summon Felsteed##3631 |goto The Barrens 62.63,35.50
accept Summon Felsteed##4490 |goto The Barrens 62.63,35.50
|only if Warlock
step
talk Strahad Farsan##6251
turnin Summon Felsteed##4490 |goto The Barrens 62.63,35.50
|only if Warlock
step
ding 53
|only if not hardcore
step
ding 55
|only if hardcore
step
collect 1 Fel Cloth##14256 |q 8420 |future
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Warlock
step
talk Niby the Almighty##14469
accept What Niby Commands##7601 |goto Felwood 41.38,44.86
|only if Warlock
step
talk Impsy##14470
turnin What Niby Commands##7601 |goto Felwood 41.36,45.02
accept Flawless Fel Essence##7602 |goto Felwood 41.36,45.02
accept Hot and Itchy##8420 |goto Felwood 41.36,45.02
'|accept The Wrong Stuff##8421 |or
|only if Warlock
step
talk Impsy##14470
turnin Hot and Itchy##8420 |goto Felwood 41.36,45.02 |only if haveq(8420) or completedq(8420)
accept The Wrong Stuff##8421 |goto Felwood 41.36,45.02
|only if Warlock
step
kill Tainted Ooze##7092+
collect 4 Bloodvenom Essence##20614 |q 8421/2 |goto Felwood 40.92,46.83
You can find more around here [41.93,49.75]
|only if Warlock
step
Kill enemies around this area
collect 10 Rotting Wood##20613 |q 8421/1 |goto Felwood 46.89,24.16
You can find more around here [52.81,21.50]
|only if Warlock
step
talk Impsy##14470
turnin The Wrong Stuff##8421 |goto Felwood 41.36,45.02
accept Trolls of a Feather##8422 |goto Felwood 41.36,45.02
|only if Warlock
step
Enter the building |goto Felwood 35.39,58.54 < 8 |walk
kill Jaedenar Legionnaire##9862
|tip They are found throughout the Shadow Hold.
|tip Watch for patrols and respawns while in the area.	|only if hardcore
collect Flawless Fel Essence (Jaedenar)##18622 |q 7602/2 |goto Felwood 36.25,55.94
|only if Warlock
step
Kill Legashi enemies around this area
collect Flawless Fel Essence (Azshara)##18624 |q 7602/1 |goto Azshara 52.03,18.65
You can find more around here
[61.22,24.87]
[66.09,16.86]
|only if Warlock
step
kill Felguard Sentry##6011
collect Flawless Fel Essence (Dark Portal)##18623 |q 7602/3 |goto Blasted Lands 61.32,54.18
You can find more around here [54.03,54.60]
|only if Warlock
step
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8236
|only if Warlock and hardcore
step
Run up the stairs |goto Swamp of Sorrows/0 69.36,56.89 < 7 |walk
Enter the building and swim under the water |goto Swamp of Sorrows/0 70.54,49.78 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 72.69,42.22 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 75.69,45.78 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 78.62,47.47 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 80.22,49.62 < 7 |walk
Follow the path |goto Swamp of Sorrows/0 81.33,42.38 < 7 |walk
Run down the stairs |goto Swamp of Sorrows/0 78.86,40.74 < 7 |walk
Run down the ramp |goto Swamp of Sorrows/0 76.85,38.82 < 7 |walk
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 8232 |future
|only if Warlock
stickystart "Blue_Voodoo_Feathers"
stickystart "Green_Voodoo_Feathers"
step
Inside the Temple of Atal'Hakkar:
collect 2 Amber Voodoo Feather##20606 |q 8422/1
|tip These come from Gasher and Zul'Lor.
|only if Warlock
step
label "Blue_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar:
collect 2 Blue Voodoo Feather##20607 |q 8422/2
|tip These come from Mijan and Hukku.
|only if Warlock
step
label "Green_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar:
collect 2 Green Voodoo Feather##20608 |q 8422/3
|tip These come from Zolo and Loro.
|only if Warlock
step
talk Impsy##14470
turnin Flawless Fel Essence##7602 |goto Felwood 41.36,45.02
turnin Trolls of a Feather##8422 |goto Felwood 41.36,45.02
accept Kroshius' Infernal Core##7603 |goto Felwood 41.36,45.02
|only if Warlock
step
Follow the road |goto Felwood 38.76,41.70 < 25 |only if walking
Continue following the road |goto Felwood 39.01,37.86 < 25 |only if walking
Follow the path |goto Felwood 41.25,36.95 < 25 |only if walking
use the Fel Fire##18626
kill Kroshius##14467
|tip You may need help.
collect Kroshius' Infernal Core##18625 |q 7603/1 |goto Felwood 45.73,34.81
|only if Warlock
step
talk Niby the Almighty##14469
turnin Kroshius' Infernal Core##7603 |goto Felwood 41.38,44.86
|only if Warlock
step
ding 60
step
collect 35 Black Dragonscale##15416 |q 7628 |future
|tip These are gathered with the Skinning profession.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Warlock
step
collect 10 Elixir of Shadow Power##9264 |q 7626 |future
|tip These are with the Alchemy profession.
|tip It takes 3 Ghost Mushrooms and a Crystal Vial to make one.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Warlock
step
collect 6 Large Brilliant Shard##14344 |q 7627 |future
|tip If you have the Enchanting profession, use your Disenchant ability on level 51-60 blue weapons and armor.
|tip You can also buy them from the Auction House. |only if not selfmade()
|only if Warlock
step
collect 25 Dark Iron Ore##11370 |q 7627 |future
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Warlock
step
collect 3 Arcanite Bar##12360 |q 7630 |future
|tip These are with the Alchemy profession.
|tip It takes 1 Thorium Bar and 1 Arcane Crystal to make one.
|tip Try to find a Alchemist to create one for you.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Warlock
step
Collect 250 Gold |complete _G.GetMoney() >= 2500000 |q 7637 |future
|only if Warlock
step
talk Kurgul##5815
accept Mor'zul Bloodbringer##7562 |goto Orgrimmar 47.52,46.73
|only if Warlock
step
Follow the path |goto Burning Steppes 15.46,40.26 < 15 |only if walking
talk Mor'zul Bloodbringer##14436
turnin Mor'zul Bloodbringer##7562 |goto Burning Steppes 12.69,31.64
accept Rage of Blood##7563 |goto Burning Steppes 12.69,31.64
|only if Warlock
step
Enter the cave |goto Winterspring 65.04,18.78 < 10 |walk
Kill Owlbeast enemies around this area
|tip Watch for respawns while in the area. |only if hardcore
collect 30 Raging Beast's Blood##18590 |goto Winterspring 63.65,16.33
|only if Warlock
step
Follow the path |goto Burning Steppes 15.46,40.26 < 15 |only if walking
talk Mor'zul Bloodbringer##14436
turnin Rage of Blood##7563 |goto Burning Steppes 12.69,31.64
accept Wildeyes##7564 |goto Burning Steppes 12.69,31.64
|only if Warlock
step
talk Gorzeeki Wildeyes##14437
turnin Wildeyes##7564 |goto Burning Steppes 12.43,31.63
accept Lord Banehollow##7623 |goto Burning Steppes 12.43,31.63
|only if Warlock
step
talk Mor'zul Bloodbringer##14436
accept Bell of Dethmoora##7626 |goto Burning Steppes 12.69,31.64
accept Wheel of the Black March##7627 |goto Burning Steppes 12.69,31.64
accept Doomsday Candle##7628 |goto Burning Steppes 12.69,31.64
|only if Warlock
step
talk Gorzeeki Wildeyes##14437
turnin Bell of Dethmoora##7626 |goto Burning Steppes 12.43,31.63
turnin Wheel of the Black March##7627 |goto Burning Steppes 12.43,31.63
turnin Doomsday Candle##7628 |goto Burning Steppes 12.43,31.63
accept Arcanite##7630 |goto Burning Steppes 12.43,31.63
|only if Warlock
step
talk Gorzeeki Wildeyes##14437
turnin Arcanite##7630 |goto Burning Steppes 12.43,31.63
|only if Warlock
step
talk Gorzeeki Wildeyes##14437
buy 6 Shadowy Potion##18802 |q 7623 |goto Burning Steppes 12.43,31.63
|only if Warlock
step
use the Shadowy Potion##18802
|tip use it before you enter Shadow Hold.
|tip It will make most enemies inside friendly for 20 minutes.
Enter the building |goto Felwood 35.42,58.61 < 10 |walk
Run down the ramp |goto Felwood 35.47,58.18 < 10 |walk
Run down the ramp |goto Felwood 36.04,56.42 < 10 |walk
Run up the ramp |goto Felwood 36.69,55.99 < 10 |walk
Follow the path down |goto Felwood 36.64,54.91 < 10 |walk
Run down the ramp |goto Felwood 38.19,54.10 < 5 |c |q 7623 |walk
|only if Warlock
step
Follow the path |goto Felwood 37.10,54.04 < 10 |walk
Cross the water |goto Felwood 37.61,52.21 < 10 |walk
Follow the path up |goto Felwood 36.26,52.52 < 10 |walk
Run down the ramp |goto Felwood 37.20,50.82 < 10 |walk
Continue down the ramp |goto Felwood 38.90,49.72 < 10 |c |q 7623 |walk
|only if Warlock
step
Follow the path	|goto Felwood 39.85,49.23 < 10 |walk
Follow the path |goto Felwood 40.04,47.80 < 10 |walk
Follow the path up |goto Felwood 38.56,46.06 < 10 |walk
Follow the path up |goto Felwood 37.43,46.24 < 10 |walk
Cross the bridge |goto Felwood 38.03,46.52 < 10 |walk
Cross the bridge |goto Felwood 37.33,47.22 < 10 |c |q 7623 |walk
|only if Warlock
step
use the Shadowy Potion##18802
|tip You need to have this buff for the next step.
Get the Taint of Shadow Buff |havebuff Taint of Shadow##23179
|only if Warlock
step
talk Lord Banehollow##9516
|tip Inside the cave.
turnin Lord Banehollow##7623 |goto Felwood 35.93,44.41
accept Ulathek the Traitor##7624 |goto Felwood 35.93,44.41
|only if Warlock
step
Cross the bridge |goto Felwood 36.20,46.09 < 10 |walk
Cross the bridge |goto Felwood 37.95,47.27 < 10 |walk
Run down the ramp |goto Felwood 37.94,45.39 < 10 |walk
Follow the path |goto Felwood 37.65,46.62 < 10 |walk
Continue following the path |goto Felwood 39.57,47.05 < 10 |walk
Cross the bridge |goto Felwood 40.06,48.94  < 10 |walk
talk Ulathek##14523
Remove the Taint of Shadow buff |nobuff Taint of Shadow##23179 |q 7624 |goto Felwood 39.89,49.17
|only if Warlock
step
Cross the bridge |goto Felwood 40.02,48.99 < 10
kill Ulathek##14523
collect The Traitor's Heart##18719 |q 7624/1 |goto Felwood 40.77,48.42
|only if Warlock
step
use the Shadowy Potion##18802
Get the Taint of Shadow Buff |havebuff Taint of Shadow##23179 |q 7624
|only if Warlock
step
Cross the bridge |goto Felwood 40.49,48.48 < 10 |walk
Run down the ramp |goto Felwood 40.04,47.71 < 10 |walk
Run up the ramp |goto Felwood 38.49,46.17 < 10 |walk
Follow the path |goto Felwood 38.22,46.82 < 10 |walk
run up the ramp |goto Felwood 37.35,45.87 < 10 |c |q 7624 |walk
|only if Warlock
step
Cross the bridge |goto Felwood 38.03,46.48 < 10 |walk
Cross the bridge |goto Felwood 37.46,47.35 < 10 |walk
talk Lord Banehollow##9516
|tip Inside the cave.
turnin Ulathek the Traitor##7624 |goto Felwood 35.93,44.41
accept Xorothian Stardust##7625 |goto Felwood 35.93,44.41
|only if Warlock
step
talk Ur'dan##14522
|tip Inside the cave.
buy Xorothian Stardust##18687 |q 7625/1 |goto Felwood 36.17,44.46
|only if Warlock
step
Follow the path |goto Burning Steppes 15.46,40.26 < 15 |only if walking
talk Gorzeeki Wildeyes##14437
turnin Xorothian Stardust##7625 |goto Burning Steppes 12.43,31.63
accept Imp Delivery##7629 |goto Burning Steppes 12.43,31.63
|only if Warlock
step
Incoming Dungeon Steps
|tip The next few steps will send you into 2 different dungeons: Scholomance and then Dire Maul - West.
|tip You will need a group for each instance.
Click Here to Continue |confirm |q 7629 |future
|only if Warlock
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 7629
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
|only if Warlock
step
Inside the Scholomance Dungeon:
use Imp in a Jar##18688
|tip Use it near the Alchemy Station at the start of the room with Ras Frostwhisper.
Watch the dialogue
Create the Parchment |q 7629/1
|only if Warlock
step
Follow the path |goto Burning Steppes 15.46,40.26 < 15 |only if walking
talk Gorzeeki Wildeyes##14437
turnin Imp Delivery##7629 |goto Burning Steppes 12.43,31.63
|only if Warlock
step
talk Gorzeeki Wildeyes##14437
buy J'eevee's Jar##18663 |q 7631 |future |goto Burning Steppes 12.43,31.63
buy Black Lodestone##18629 |q 7631 |future |goto Burning Steppes 12.43,31.63
buy Xorothian glyphs##18670 |q 7631 |future |goto Burning Steppes 12.43,31.63
|only if Warlock
step
talk Mor'zul Bloodbringer##14436
accept Dreadsteed of Xoroth##7631 |goto Burning Steppes 12.69,31.64
|only if Warlock
step
Incoming Dungeon Steps
|tip The next few steps will send you into 2 different dungeons: Scholomance and then Dire Maul - West.
|tip You will need a group for each instance.
Click Here to Continue |confirm |q 7631 |future
|only if Warlock
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 60.32,30.16 < 10 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - West Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 7631
|only if Warlock
step
Inside the Dire Maul - West Dungeon:
use J'eevee's Jar##18663
|tip Use it in the area where Immol'thar is.
|tip Clear the room before starting.
Kill enemies around this area
|tip Focus on Dread Guards as they appear.
|tip They will spawn in waves after using J'eevee's Jar.
|tip Recharge the Bell, Wheel and Candle as they run out of charges.
|tip They will tilt when they need to be recharged.
|tip Use the "Black Lodestone" to fix them, which costs a soul shard.
use Xorothian glyphs##18670
kill Xorothian Dreadsteed##14502
|tip At 50% health, Lord Hel'nurath will appear and need to be killed.
talk Dreadsteed Spirit##14504
turnin Dreadsteed of Xoroth##7631
|only if Warlock
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Cozy Sleeping Bag",{
description="This guide will walk you through obtaining the Cozy Sleeping Bag item.",
},[[
step
click Burned-Out Remains##415106
accept ...and that note you found##79007 |goto The Barrens 46.36,73.90
step
click Nailed Plank##424010
turnin ...and that note you found##79007 |goto Westfall 37.43,50.81
accept Stepping Stones##79192 |goto Westfall 37.43,50.81
step
Follow the path up |goto Stonetalon Mountains 51.02,52.41 < 30 |only if walking
Follow the path through the mountains |goto Stonetalon Mountains 46.10,53.58 < 30 |only if walking
click Pocket Litter##424005
|tip On top of a wooden crate, next to a tent.
turnin Stepping Stones##79192 |goto Stonetalon Mountains 40.75,52.57
accept Scramble##79980 |goto Stonetalon Mountains 40.75,52.57
step
click Mound of Dirt##424012
|tip It looks like a brown pile of dirt on the ground.
|tip In the hills, on the cliffside.
turnin Scramble##79980 |goto Stonetalon Mountains 39.62,49.80
accept Wet Job##79974 |goto Stonetalon Mountains 39.62,49.80
step
Run onto the dam |goto Loch Modan 40.61,13.54 < 30 |only if walking
Jump down carefully here |goto Loch Modan 49.50,13.38 < 10 |only if walking
click Carved Figurine##424007
|tip It looks like a small eagle statue.
|tip On the ledge, overlooking the waterfall.
turnin Wet Job##79974 |goto Loch Modan 49.42,12.90
accept Eagle's Fist##79975 |goto Loch Modan 49.42,12.90
step
Jump up the cart to get onto the wall |goto Hillsbrad Foothills 87.58,47.88 < 10 |only if walking
click Messenger Bag##406918
|tip It looks like a hanging brown pouch.
|tip Next to the doorway on top of the wall.
turnin Eagle's Fist##79975 |goto Arathi Highlands 22.48,24.13
accept This Must Be The Place##79976 |goto Arathi Highlands 22.48,24.13
step
click Hastily Rolled-Up Satchel##424006
|tip It looks like a rolled up sleeping bag.
|tip On the ground, next to the doorway on top of the wall.
turnin This Must Be The Place##79976 |goto Arathi Highlands 22.48,24.13
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\City of Dalaran Key",{
description="This guide will walk you through getting the key to the City of Dalaran.",
condition_suggested=function() return level >= 30 and not completedq(92434) end,
condition_end=function() return completedq(92434) end,
},[[
step
_City of Dalaran Key_
|tip This guide will walk you through acquiring the key open the City of Dalaran dungeon.
|tip You must be level 30 to accept these quests, if you do this at 30 we highly recommend finding a group.
|tip If you did not do this dungeon while leveling, you may have already completed this, if the Dalaran Sewer Key is on your keyring you are attuned all.
|tip Only 1 person needs the key to allow access for the group. They do not need to be a part of your group even, the door is outside.
|confirm
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
accept Prison Break In##544 |goto Hillsbrad Foothills/0 61.60,20.84
accept Key to the City##93680 |goto Hillsbrad Foothills/0 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
accept Stone Tokens##556 |goto Hillsbrad Foothills/0 61.50,20.90
|tip This quest is optional, if you plan on doing this with a large group you can skip it as it would take quite awhile.
step
talk Innkeeper Shay##2388
|tip Inside the building.
home Tarren Mill |goto Hillsbrad Foothills/0 62.74,19.07
stickystart "Collect_Worn_Stone_Tokens"
step
kill Ricter##2411
|tip Walks around.
collect Bloodstone Marble##3689 |q 544/2 |goto Alterac Mountains/0 20.20,84.08
step
kill Alina##2412
|tip Walks around.
|tip Inside the building.
collect Bloodstone Shard##3690 |q 544/3 |goto Alterac Mountains/0 20.35,86.35
step
kill Dermot##2413
|tip Walks around.
|tip Inside the building.
collect Bloodstone Wedge##3691 |q 544/1 |goto Alterac Mountains/0 20.01,86.13
step
click Warden's Footlocker##670427
|tip Inside the building. On your way to the second floor, near {o}Warden BelamooreP{}.
collect Grimy Key##279469 |q 93680/1 |goto Alterac Mountains/0 16.45,89.71
step
kill Kegan Darkmar##2414
|tip Guarded by {o}Warden Belamoore{}.
|tip {o}Level 36{} mage.
|tip Kill Kegan while using {o}doorways and stairs{} to line-of-sight her.
|tip Prevents her from casting spells and hurting you.
|tip Upstairs inside the building.
collect Bloodstone Oval##3688 |q 544/4 |goto Alterac Mountains 17.78,83.20
step
_Destroy This Item:_
|tip Not needed.
trash Belamoore's Research Journal##3711
step
label "Collect_Worn_Stone_Tokens"
kill Dalaran Shield Guard##2271, Dalaran Theurgist##2272, Dalaran Worker##2628, Dalaran Summoner##2358
|tip Don't hit {o}Shield Guards{} with melee when they're {o}glowing{}.
|tip Deals high damage.
|tip Humans.
collect 10 Worn Stone Token##3714 |q 556/1 |goto Alterac Mountains 20.20,82.40
|mapmarker Alterac Mountains/0 17.40,81.00
|mapmarker Alterac Mountains/0 17.60,84.00
|mapmarker Alterac Mountains/0 19.40,86.80
|mapmarker Alterac Mountains/0 22.00,85.20
|only if haveq(556) or readyq(556)
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
turnin Prison Break In##544 |goto Hillsbrad Foothills 61.60,20.84
turnin Key to the City##93680 |goto Hillsbrad Foothills 61.60,20.84
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
accept Dalaran Patrols##545 |goto Hillsbrad Foothills 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
turnin Stone Tokens##556 |goto Hillsbrad Foothills 61.50,20.94
|only if readyq(556) or completedq(556)
step
talk Keeper Bel'varil##2437
|tip Inside the building.
accept Bracers of Binding##557 |goto Hillsbrad Foothills 61.50,20.94
|only if completedq(556)
stickystart "Collect_Earth_Bracers"
step
kill 6 Dalaran Summoner##2358 |q 545/1 |goto Alterac Mountains 23.60,56.40
kill 12 Elemental Slave##2359 |q 545/2 |goto Alterac Mountains 23.60,56.40
|tip Stay East along the mountains when heading North, if you get too close to Dalaran the guards will attack you.
|mapmarker Alterac Mountains/0 9.80,78.20
|mapmarker Alterac Mountains/0 11.20,75.00
|mapmarker Alterac Mountains/0 11.80,80.60
|mapmarker Alterac Mountains/0 13.00,77.60
|mapmarker Alterac Mountains/0 15.20,80.60
|mapmarker Alterac Mountains/0 16.00,75.40
|mapmarker Alterac Mountains/0 17.80,78.60
|mapmarker Alterac Mountains/0 18.20,58.00
|mapmarker Alterac Mountains/0 18.40,54.40
|mapmarker Alterac Mountains/0 18.40,73.40
|mapmarker Alterac Mountains/0 20.40,61.20
|mapmarker Alterac Mountains/0 20.60,70.80
|mapmarker Alterac Mountains/0 23.20,59.20
|mapmarker Alterac Mountains/0 21.20,56.40
|mapmarker Alterac Mountains/0 21.40,65.00
|mapmarker Alterac Mountains/0 21.80,53.20
|mapmarker Alterac Mountains/0 23.60,62.20
step
label "Collect_Earth_Bracers"
kill Elemental Slave##2359+
collect 4 Bracers of Earth Binding##3715 |q 557/1 |goto Alterac Mountains 23.60,56.40
|only if haveq(557) or readyq(557)
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
turnin Dalaran Patrols##545 |goto Hillsbrad Foothills 61.60,20.84
step
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
accept Blood in the Streets##92434 |goto Hillsbrad Foothills 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
turnin Bracers of Binding##557 |goto Hillsbrad Foothills 61.50,20.94
|only if readyq(557) or completedq(557)
step
Head towards Dalaran |goto Alterac Mountains/0 18.89, 52.32
|tip Back to where you were before along the east side of Dalaran, wrap around the North side of the city along Lordamere Lake
step
Find a way into Dalaran along Lordamere Lake |q 92434/1 |goto Silverpine Forest/0 68.75,45.12
step
talk Image of Archmage Modera##269127
turnin Blood in the Streets##92434 |goto Silverpine Forest/0 68.75,45.12
step
talk Image of Archmage Modera##269127
accept Heart of Disruption####96984 |goto Silverpine Forest/0 68.75,45.12
collect Dalaran Sewer Key##277507
step
You are now attuned for the City of Dalaran dungeon and can enter freely. You do not need to keep or complete the quest.
|confirm
]])
