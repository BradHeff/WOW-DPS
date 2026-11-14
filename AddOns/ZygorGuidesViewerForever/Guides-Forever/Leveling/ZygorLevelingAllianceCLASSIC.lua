local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("LevelingACLASSIC") then return end
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
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Human Starter (1-13)",{
image=ZGV.IMAGESDIR.."Elwynn Forest",
condition_suggested=function() return raceclass('Human') and level <= 13 end,
condition_suggested_exclusive=true,
condition_visible=function() return Human end,
hardcore = true,
linked = {"Leveling Guides\\Hidden Guides"},
linkedhidden = true,
next="Leveling Guides\\Westfall (13-15)",
},[[
defaultfor Human
step
_NOTE:_
Wrong Character Race
|tip Guide written for {o}Human{} characters.
|tip Other races may encounter issues.
Click Here to Continue |confirm
|only if not Human
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948	|q 783 |future
|only if not Warlock
step
_NOTE:_
Manage Your Ammo
|tip Make sure you always have ammo.
|tip You need it to attack enemies.
|tip {o}General Goods{} vendors sell it (also Bow & Gun vendors).
|tip Try to keep your ammo bag full.
Click Here to Continue |confirm |q 783 |future
|only if Hunter
step
Kill enemies
|tip Loot items worth at least {o}10 copper{} to sell.
|tip Allows training an ability early.
|tip Increases leveling speed.
Click Here to Continue |confirm |goto Elwynn Forest/0 45.20,42.40 |q 783 |future
|mapmarker Elwynn Forest/0 46.00,36.40
|mapmarker Elwynn Forest/0 46.80,39.60
|mapmarker Elwynn Forest/0 47.40,46.80
|mapmarker Elwynn Forest/0 49.40,37.40
|mapmarker Elwynn Forest/0 50.40,44.20
|mapmarker Elwynn Forest/0 51.80,41.20
|only if Warrior or Warlock
step
talk Brother Danil##152
Sell Items |vendor Brother Danil##152 |goto Elwynn Forest/0 47.49,41.56 |q 783 |future
|only if Warrior or Warlock
step
talk Drusilla La Salle##459
|tip Outside next to the building.
Train Abilities |trainer Drusilla La Salle##459 |goto Elwynn Forest 49.87,42.65 |q 1598 |future
|only if  Warlock
step
talk Drusilla La Salle##459
|tip Outside next to the building.
accept The Stolen Tome##1598 |goto Elwynn Forest 49.87,42.65
|only if Warlock
step
click Stolen Books
|tip Ignore enemies and {o}run inside the tent{}.
|tip Enemies can't hit you.
|tip Zoom camera out.
|tip From inside, click the {o}book pile (right side){} outside.
Click Here to Watch a Video |popuptext youtu.be/SEATloEvXAM
|tip Copy the link into your internet browser.
collect Powers of the Void##6785 |q 1598/1 |goto Elwynn Forest 56.74,43.77
|only if Warlock
step
use Hearthstone##6948
Hearth to Northshire Valley |goto Elwynn Forest/0 48.06,43.65 < 20 |noway |c |q 1598
|only if Warlock
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948	|q 1598
|only if Warlock
step
talk Drusilla La Salle##459
|tip Outside next to the building.
turnin The Stolen Tome##1598 |goto Elwynn Forest 49.87,42.65
|only if Warlock
step
Summon Your Imp |complete warlockpet("Imp") |q 783 |future
|tip Use the {o}Summon Imp{} ability.
|only if Warlock
step
talk Deputy Willem##823
accept A Threat Within##783 |goto Elwynn Forest 48.17,42.95
step
talk Marshal McBride##197
|tip {o}Ground floor{} inside the building.
turnin A Threat Within##783 |goto Elwynn Forest 48.92,41.61
accept Kobold Camp Cleanup##7 |goto Elwynn Forest 48.92,41.61
step
talk Llane Beshere##911
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Llane Beshere##911 |goto Elwynn Forest/0 50.24,42.29 |q 7
|only if Warrior
step
talk Deputy Willem##823
accept Eagan Peltskinner##5261 |goto Elwynn Forest 48.17,42.95
step
talk Eagan Peltskinner##196
|tip Outside the building.
turnin Eagan Peltskinner##5261 |goto Elwynn Forest 48.94,40.16
accept Wolves Across the Border##33 |goto Elwynn Forest 48.94,40.16
stickystart "Kill_Kobold_Vermin"
stickystart "Collect_Tough_Wolf_Meat"
step
kill Kobold Vermin##6+
collect Nibbled-On Book##247834 |n
use Nibbled-On Book##247834
accept Nibbled-On Book##91741 |goto Elwynn Forest 49.30,36.10
step
label "Kill_Kobold_Vermin"
kill 10 Kobold Vermin##6 |q 7/1 |goto Elwynn Forest 49.30,36.10
step
label "Collect_Tough_Wolf_Meat"
kill Timber Wolf##69, Young Wolf##299
collect 8 Tough Wolf Meat##750 |q 33/1 |goto Elwynn Forest/0 48.32,39.12
step
talk Eagan Peltskinner##196
turnin Wolves Across the Border##33 |goto Elwynn Forest 48.94,40.16
step
talk Marshal McBride##197
|tip {o}Ground floor{} inside the building.
turnin Kobold Camp Cleanup##7		|goto Elwynn Forest 48.92,41.61
accept Investigate Echo Ridge##15	|goto Elwynn Forest 48.92,41.61
accept A Scribbled Letter##92479	|goto Elwynn Forest 48.92,41.61		|only if Hunter
accept Glyphic Letter##3104		|goto Elwynn Forest 48.92,41.61		|only if Mage
accept Simple Letter##3100		|goto Elwynn Forest 48.92,41.61		|only if Warrior
accept Tainted Letter##3105		|goto Elwynn Forest 48.92,41.61		|only if Warlock
accept Encrypted Letter##3102		|goto Elwynn Forest 48.92,41.61		|only if Rogue
accept Hallowed Letter##3103		|goto Elwynn Forest 48.92,41.61		|only if Priest
accept Consecrated Letter##3101		|goto Elwynn Forest 48.92,41.61		|only if Paladin
step
talk Llane Beshere##911
|tip {o}Ground floor{} inside the building.
turnin Simple Letter##3100 |goto Elwynn Forest/0 50.24,42.29
|only if Warrior
step
talk Llane Beshere##911
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Llane Beshere##911 |goto Elwynn Forest/0 50.24,42.29 |q 15
|only if Warrior
step
talk Brother Sammuel##925
|tip {o}Ground floor{} inside the building.
turnin Consecrated Letter##3101 |goto Elwynn Forest/0 50.43,42.13
|only if Paladin
step
talk Brother Sammuel##925
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Brother Sammuel##925 |goto Elwynn Forest/0 50.43,42.13 |q 15
|only if Paladin
step
talk Brother Paxton##951
|tip {o}Ground floor{} inside the building.
turnin Nibbled-On Book##91741 |goto Elwynn Forest/0 49.61,40.41
accept Book Inventory##92124 |goto Elwynn Forest/0 49.61,40.41
step
talk Daniel##247229
|tip {o}Ground floor{} inside the building.
turnin Book Inventory##92124 |goto Elwynn Forest/0 49.48,40.68
step
talk Brother Paxton##951
|tip {o}Ground floor{} inside the building.
accept Rascally Rodents##91743 |goto Elwynn Forest/0 49.60,40.41
step
talk Priestess Anetta##375
|tip {o}Ground floor{} inside the building.
turnin Hallowed Letter##3103 |goto Elwynn Forest 49.81,39.49
|only if Priest
step
talk Priestess Anetta##375
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Priestess Anetta##375 |goto Elwynn Forest 49.81,39.49 |q 18 |future
|only if Priest
step
talk Khelden Bremen##198
|tip {o}Middle floor{} inside the building.
turnin Glyphic Letter##3104 |goto Elwynn Forest 49.66,39.41
|only if Mage
step
talk Khelden Bremen##198
|tip {o}Middle floor{} inside the building.
Train Abilities |trainer Khelden Bremen##198 |goto Elwynn Forest 49.66,39.41 |q 18 |future
|only if Mage
step
talk Deputy Willem##823
accept Brotherhood of Thieves##18 |goto Elwynn Forest 48.17,42.93
stickystart "Kill_Kobold_Workers"
step
kill Kobold Worker##257,Kobold Vermin##6
collect 8 Stolen Book##247839 |q 91743/1 |goto Elwynn Forest/0 48.90,35.31
step
label "Kill_Kobold_Workers"
kill 10 Kobold Worker##257 |q 15/1 |goto Elwynn Forest/0 48.90,35.31
step
kill Defias Thug##38+
collect 12 Red Burlap Bandana##752 |q 18/1 |goto Elwynn Forest/0 54.88,46.19
step
talk Tordrin Sternblade##248415
turnin A Scribbled Letter##92479 |goto Elwynn Forest/0 51.21,40.81
|only if Hunter
step
talk Tordrin Sternblade##248415
Train Abilities |trainer Tordrin Sternblade##248415 |goto Elwynn Forest/0 51.21,40.81 |q 18
|only if Hunter
step
talk Jorik Kerridan##915
|tip Outside behind the building.
|tip In the stables.
turnin Encrypted Letter##3102 |goto Elwynn Forest 50.31,39.92
|only if Rogue
step
talk Jorik Kerridan##915
|tip Outside behind the building.
|tip In the stables.
Train Abilities |trainer Jorik Kerridan##915 |goto Elwynn Forest 50.31,39.92 |q 18
|only if Rogue
step
talk Drusilla La Salle##459
|tip Outside next to the building.
turnin Tainted Letter##3105 |goto Elwynn Forest 49.87,42.65
|only if Warlock
step
talk Drusilla La Salle##459
|tip Outside next to the building.
Train Abilities |trainer Drusilla La Salle##459 |goto Elwynn Forest 49.87,42.65 |q 18
|only if Warlock
step
talk Deputy Willem##823
|tip Outside the building.
turnin Brotherhood of Thieves##18 |goto Elwynn Forest 48.17,42.94
accept Milly Osworth##3903 |goto Elwynn Forest 48.17,42.94
accept Bounty on Garrick Padfoot##6 |goto Elwynn Forest 48.17,42.94
step
talk Marshal McBride##197
|tip {o}Ground floor{} inside the building.
turnin Investigate Echo Ridge##15 |goto Elwynn Forest 48.92,41.61
accept Skirmish at Echo Ridge##21 |goto Elwynn Forest 48.92,41.61
step
talk Llane Beshere##911
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Llane Beshere##911 |goto Elwynn Forest/0 50.24,42.29 |q 91743
|only if Warrior
step
talk Brother Sammuel##925
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Brother Sammuel##925 |goto Elwynn Forest/0 50.43,42.13 |q 91743
|only if Paladin
step
talk Brother Paxton##951
|tip {o}Ground floor{} inside the building.
turnin Rascally Rodents##91743 |goto Elwynn Forest/0 49.61,40.41
accept Mining Consultant##91745 |goto Elwynn Forest/0 49.61,40.41
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
talk Priestess Anetta##375
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Priestess Anetta##375 |goto Elwynn Forest 49.81,39.49 |q 3903
|only if Priest
step
talk Khelden Bremen##198
|tip {o}Middle floor{} inside the building.
Train Abilities |trainer Khelden Bremen##198 |goto Elwynn Forest 49.66,39.41 |q 3903
|only if Mage
step
talk Brother Danil##152
buy Skinning Knife##7005 |goto Elwynn Forest/0 47.49,41.57 |q 91745
buy Apprentice's Skinning Satchel##277114 |goto Elwynn Forest/0 47.49,41.57 |q 91745
|only if skillmax("Skinning") > 1
step
talk Brother Danil##152
buy Apprentice's Herb Pouch##277113 |goto Elwynn Forest/0 47.49,41.57 |q 91745
|only if skillmax("Herbalism") > 1
step
talk Brother Danil##152
buy Mining Pick##2901 |goto Elwynn Forest/0 47.49,41.57 |q 91745
buy Apprentice's Mining Pack##277115 |goto Elwynn Forest/0 47.49,41.57 |q 91745
|only if skillmax("Mining") > 1
step
talk Kelsey Fargo##247226
turnin Mining Consultant##91745 |goto Elwynn Forest/0 47.19,32.18
accept The Big Picture##91752 |goto Elwynn Forest/0 47.19,32.18
step
_NOTE:_
Use Weapon Stones
|tip We will train Mining and Blacksmithing.
|tip Allows you to make and use {o}Sharpening Stones{}.		|only if Warrior or Rogue
|tip Allows you to make and use {o}Weightstones{}.		|only if Paladin
|tip Increases damage.
|tip Mine {o}Copper Ore{} as you see it.
|tip Use the {g}Rough Stones{} to make sharpening stones.	|only if Warrior or Rogue
|tip Use the {g}Rough Stones{} to make weightstones.		|only if Paladin
Click Here to Continue |confirm |q 3903
|only if Warrior or Rogue or Paladin
step
talk Kelsey Fargo##247226
buy Mining Pick##2901 |goto Elwynn Forest/0 47.18,32.18
|only if Warrior or Rogue or Paladin
step
talk Kelsey Fargo##247226
Train Apprentice Mining |skillmax Mining,75 |goto Elwynn Forest/0 47.18,32.18
|only if Warrior or Rogue or Paladin
stickystart "Kill_Kobold_Laborers"
step
Enter the mine |goto Elwynn Forest/0 47.68,31.81 < 10 |walk |only if not (subzone("Echo Ridge Mine") and indoors())
kill Shinyfinder Narf##248362
|tip {o}Elite{} kobold.
|tip Inside the mine.
collect Sack of "Picture" Books##247886 |q 91752/1 |goto Elwynn Forest/0 49.21,27.99
step
label "Kill_Kobold_Laborers"
kill 12 Kobold Laborer##80 |q 21/1 |goto Elwynn Forest/0 47.68,31.81
|tip Inside the mine. |notinsticky
step
Leave the mine |goto Elwynn Forest 47.66,31.89 < 15 |walk |only if subzone("Echo Ridge Mine") and indoors()
talk Milly Osworth##9296
|tip Outside, behind the building.
turnin Milly Osworth##3903 |goto Elwynn Forest 50.69,39.35
accept Milly's Harvest##3904 |goto Elwynn Forest/0 50.69,39.35
step
kill Garrick Padfoot##103
collect Garrick's Head##182 |q 6/1 |goto Elwynn Forest 57.51,48.25
step
click Milly's Harvest+
|tip Wooden buckets.
collect 8 Milly's Harvest##11119 |q 3904/1 |goto Elwynn Forest/0 55.10,49.00
|mapmarker Elwynn Forest/0 53.30,48.90
|mapmarker Elwynn Forest/0 53.40,47.60
|mapmarker Elwynn Forest/0 53.90,50.40
step
talk Milly Osworth##9296
|tip Outside, behind the building.
turnin Milly's Harvest##3904 |goto Elwynn Forest 50.69,39.35
accept Grape Manifest##3905 |goto Elwynn Forest/0 50.69,39.35
step
talk Marshal McBride##197
|tip {o}Ground floor{} inside the building.
turnin Skirmish at Echo Ridge##21 |goto Elwynn Forest/0 48.92,41.61
turnin The Big Picture##91752 |goto Elwynn Forest/0 48.92,41.61
accept Follow That Kobold!##91758 |goto Elwynn Forest/0 48.92,41.61
accept Report to Goldshire##54 |goto Elwynn Forest/0 48.92,41.61
accept The Adventurer##96627 |goto Elwynn Forest/0 48.92,41.61
step
talk Priestess Anetta##375
|tip {o}Ground floor{} inside the building.
accept In Favor of the Light##5623 |goto Elwynn Forest 49.81,39.49
|only if Priest
step
talk Brother Neals##952
|tip {o}Top floor{} inside the building.
turnin Grape Manifest##3905 |goto Elwynn Forest/0 49.47,41.59
step
talk Deputy Willem##823
|tip Outside the building.
turnin Bounty on Garrick Padfoot##6 |goto Elwynn Forest 48.17,42.94
step
talk Tordrin Sternblade##248415
|tip Outside, behind the building.
turnin Follow That Kobold!##91758 |goto Elwynn Forest/0 51.21,40.81
accept Shhh! We're Hunting Kobolds##91772 |goto Elwynn Forest/0 51.21,40.81
step
talk Falkhaan Isenstrider##6774
accept Rest and Relaxation##2158 |goto Elwynn Forest 45.56,47.74
step
use Kobold Tracking Kit##247970 |only if not hasbuff(1246031)
click Kobold Tracks+
|tip Muddy footprints with green glow.
|tip On your minimap.
Follow #6# Kobold Tracks |q 91772/1 |goto Elwynn Forest/0 45.10,55.64
step
talk Helene Peltskinner##6306
|tip Inside the building.
accept Rough Wolf Pelts##91751 |goto Elwynn Forest/0 46.24,62.24
|only if skillmax("Skinning") > 1
step
talk Sam Sarsaparilla##263399
turnin The Adventurer##96627 |goto Elwynn Forest/0 44.91,63.34
accept The Great Outdoors##95998 |goto Elwynn Forest/0 44.91,63.34
step
Watch the dialogue
Use the {y}/sit{} Emote Near the Campfire |q 95998/1 |goto Elwynn Forest/0 44.91,63.34 |macro /sit
Gain the Boosted Rest Buff |q 95998/2 |goto Elwynn Forest/0 44.91,63.34
|tip Takes {o}1 minute{}.
step
talk Sam Sarsaparilla##263399
turnin The Great Outdoors##95998		|goto Elwynn Forest/0 44.91,63.34
accept Camping 101: Cooking##96626		|goto Elwynn Forest/0 44.91,63.34
accept Camping 101: Skinning##97924		|goto Elwynn Forest/0 44.91,63.34 |only if skillmax("Skinning") >= 1
step
talk William Pestle##253
|tip Inside the building.
accept Kobold Candles##60 |goto Elwynn Forest 43.32,65.70
step
talk Innkeeper Farley##295
|tip Inside the building.
turnin Rest and Relaxation##2158 |goto Elwynn Forest 43.77,65.81
step
talk Tomas##1430
|tip Inside the building.
Select _"Train me."_ |gossip 96865
Learn Cooking from Tomas in Goldshire |q 96626/1 |goto Elwynn Forest/0 44.37,65.99
step
talk Tomas##1430
|tip Inside the building.
turnin Camping 101: Cooking##96626 |goto Elwynn Forest/0 44.37,65.99
step
talk Maximillian Crowe##906
|tip Downstairs inside the building.
Train Abilities |trainer Maximillian Crowe##906 |goto Elwynn Forest 44.39,66.24 |q 54
|only if Warlock
step
talk Cylina Darkheart##6374
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Cylina Darkheart##6374 |goto Elwynn Forest 44.40,65.99 |q 54
|only if Warlock
step
talk Zaldimar Wefhellt##328
|tip Upstairs inside the building.
Train Abilities |trainer Zaldimar Wefhellt##328 |goto Elwynn Forest 43.25,66.19 |q 54
|only if Mage
step
talk Priestess Josetta##377
|tip Upstairs inside the building.
turnin In Favor of the Light##5623 |goto Elwynn Forest 43.28,65.72
accept Garments of the Light##5624 |goto Elwynn Forest 43.28,65.72
|only if Human Priest
step
talk Priestess Josetta##377
|tip Upstairs inside the building.
Train Abilities |trainer Priestess Josetta##377 |goto Elwynn Forest 43.28,65.72 |q 54
|only if Priest
step
Heal and Fortify Guard Roberts |q 5624/1 |goto Elwynn Forest 48.15,68.05
|tip Cast {o}Lesser Heal (Rank 2){} on Guard Roberts.
|tip Cast {o}Power Word: Fortitude{} on Guard Roberts.
|only if Human Priest
step
talk Priestess Josetta##377
|tip Upstairs inside the building.
turnin Garments of the Light##5624 |goto Elwynn Forest 43.28,65.72
|only if Human Priest
step
talk Keryn Sylvius##917
|tip Upstairs inside the building.
Train Abilities |trainer Keryn Sylvius##917 |goto Elwynn Forest 43.87,65.94 |q 54
|only if Rogue
step
talk Michelle Belle##2329
|tip Upstairs inside the building.
Train First Aid |skillmax First Aid,75 |goto Elwynn Forest 43.39,65.55
|tip If possible.
|only if Warrior or Rogue
step
_NOTE:_
Create Bandages in Downtime
|tip While waiting for things like boats.
|tip Increases skill in First Aid.
|tip Need higher skill to make better bandages.
|tip Keep bandages to heal yourself.
Click Here to Continue |confirm |q 91772
|only if Warrior or Rogue
step
talk Marshal Dughan##240
turnin Shhh! We're Hunting Kobolds##91772 |goto Elwynn Forest/0 42.10,65.93
turnin Report to Goldshire##54 |goto Elwynn Forest/0 42.10,65.93
accept The Fargodeep Mine##62 |goto Elwynn Forest/0 42.10,65.93
step
talk Smith Argus##514
|tip Inside the building.
Train Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Elwynn Forest/0 41.71,65.55
|only if Warrior or Rogue or Paladin
step
talk Remy "Two Times"##241
accept Gold Dust Exchange##47 |goto Elwynn Forest 42.14,67.26
step
talk Brother Wilhelm##927
Train Abilities |trainer Brother Wilhelm##927 |goto Elwynn Forest 41.10,66.04 |q 85 |future
|only if Paladin
step
talk Lyria Du Lac##913
Train Abilities |trainer Lyria Du Lac##913 |goto Elwynn Forest 41.08,65.77 |q 85 |future
|only if Warrior
step
talk Josephine Carson##251507
Train Abilities |trainer Josephine Carson##251507 |goto Elwynn Forest/0 41.15,66.23 |q 85 |future
|only if Hunter
stickystart "Collect_Chunks_Of_Boar_Meat"
step
talk "Auntie" Bernice Stonefield##246
accept Lost Necklace##85 |goto Elwynn Forest 34.48,84.26
step
talk Billy Maclure##247
turnin Lost Necklace##85 |goto Elwynn Forest 43.13,85.72
accept Pie for Billy##86 |goto Elwynn Forest 43.13,85.72
step
talk Maybell Maclure##251
|tip Inside the building.
accept Young Lovers##106 |goto Elwynn Forest 43.15,89.62
step
label "Collect_Chunks_Of_Boar_Meat"
kill Stonetusk Boar##113+
collect 4 Chunk of Boar Meat##769 |goto Elwynn Forest 41.86,87.12 |q 86 |future
|tip Don't vendor them.
step
talk Tommy Joe Stonefield##252
turnin Young Lovers##106 |goto Elwynn Forest 29.84,85.99
accept Speak with Gramma##111 |goto Elwynn Forest 29.84,85.99
step
talk "Auntie" Bernice Stonefield##246
turnin Pie for Billy##86 |goto Elwynn Forest 34.48,84.26
accept Back to Billy##84 |goto Elwynn Forest 34.48,84.26
step
talk Gramma Stonefield##248
|tip Inside the building.
turnin Speak with Gramma##111 |goto Elwynn Forest 34.94,83.86
accept Note to William##107 |goto Elwynn Forest 34.94,83.86
step
talk Billy Maclure##247
turnin Back to Billy##84 |goto Elwynn Forest 43.13,85.72
accept Goldtooth##87 |goto Elwynn Forest 43.13,85.72
stickystart "Collect_Large_Candles_And_Gold_Dust"
step
Enter the mine |goto Elwynn Forest 38.97,82.33 < 15 |walk |only if not (subzone("Fargodeep Mine") and indoors())
Scout Through the Fargodeep Mine |q 62/1 |goto Elwynn Forest 39.61,80.21
|tip Inside the mine.
step
Follow the path inside the mine |goto Elwynn Forest 39.76,79.21 < 10 |walk
kill Goldtooth##327
|tip Walks around.
|tip Inside the mine.
collect Bernice's Necklace##981 |q 87/1 |goto Elwynn Forest 41.71,78.04
step
label "Collect_Large_Candles_And_Gold_Dust"
kill Kobold Tunneler##475, Kobold Miner##40
|tip Inside and outside the mine. |notinsticky
collect 8 Large Candle##772 |q 60/1 |goto Elwynn Forest 38.97,82.33
collect 10 Gold Dust##773 |q 47/1 |goto Elwynn Forest 38.97,82.33
step
Leave the mine |complete not (subzone("Fargodeep Mine") and indoors())
|tip Multiple exits.
|tip Whichever you find first.
|only if haveq(62) or haveq(87) or haveq(47) or haveq(60)
step
talk "Auntie" Bernice Stonefield##246
turnin Goldtooth##87 |goto Elwynn Forest 34.49,84.25
step
kill Stonetusk Boar##113+
|tip Skin them.
Raise Your Skinning Skill to 20 |q 97924/1 |goto Elwynn Forest/0 32.78,85.47
|only if haveq(97924) or completedq(97924)
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Inside and outside the mine.
Die on Purpose |complete isdead |goto Elwynn Forest/0 32.78,85.47 |q 47
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Elwynn Forest/0 39.48,60.53 |q 47 |zombiewalk
|only if not hardcore()
step
talk Remy "Two Times"##241
turnin Gold Dust Exchange##47 |goto Elwynn Forest/0 42.14,67.26
accept A Fishy Peril##40 |goto Elwynn Forest/0 42.14,67.26
step
talk Marshal Dughan##240
turnin A Fishy Peril##40 |goto Elwynn Forest/0 42.11,65.93
accept Further Concerns##35 |goto Elwynn Forest/0 42.11,65.93
turnin The Fargodeep Mine##62 |goto Elwynn Forest/0 42.11,65.93
accept The Jasperlode Mine##76 |goto Elwynn Forest/0 42.11,65.93
step
talk William Pestle##253
|tip Inside the building.
turnin Kobold Candles##60 |goto Elwynn Forest/0 43.32,65.70
turnin Note to William##107 |goto Elwynn Forest/0 43.32,65.70
accept Collecting Kelp##112 |goto Elwynn Forest/0 43.32,65.70
step
talk Helene Peltskinner##6306
|tip Inside the building.
turnin Camping 101: Skinning##97924 |goto Elwynn Forest/0 46.24,62.24
|only if haveq(97924) or completedq(97924)
step
talk Jason Mathers##383
accept A Net Disaster##99127 |goto Elwynn Forest/0 47.46,62.18
step
talk Lee Brown##1651
accept Bottles and Baubles##99143 |goto Elwynn Forest/0 47.61,62.32
step
click Fishing Trap+
|tip Baskets.
|tip Underwater.
|tip Near the water edge.
collect 7 Half-Eaten Fish##286205 |q 99127/1 |goto Elwynn Forest/0 48.18,64.41
step
talk Jason Mathers##383
turnin A Net Disaster##99127 |goto Elwynn Forest/0 47.46,62.18
accept Slimy Menace##99128 |goto Elwynn Forest/0 47.46,62.18
stickystart "Collect_Crystal_Kelp_Fronds"
stickystart "Kill_Murloc_Enemies"
step
click Junk Pile+
collect 6 Shiny Junk |q 99143/1 |goto Elwynn Forest/0 56.13,66.60
step
label "Collect_Crystal_Kelp_Fronds"
kill Murloc##285, Murloc Streamrunner##735
collect 4 Crystal Kelp Frond##1256 |q 112/1 |goto Elwynn Forest/0 54.14,65.60
step
label "Kill_Murloc_Enemies"
kill 4 Murloc Streamrunner##735 |q 99128/2 |goto Elwynn Forest/0 54.14,65.60
kill 7 Murloc##285 |q 99128/1 |goto Elwynn Forest/0 54.14,65.60
step
talk Lee Brown##1651
turnin Bottles and Baubles##99143 |goto Elwynn Forest/0 47.61,62.32
step
talk Jason Mathers##383
turnin Slimy Menace##99128 |goto Elwynn Forest/0 47.46,62.19
accept A Man About a Murloc##99129 |goto Elwynn Forest/0 47.46,62.19
step
talk William Pestle##253
|tip Inside the building.
turnin Collecting Kelp##112 |goto Elwynn Forest/0 43.32,65.71
step
Watch the dialogue
|tip Inside the building.
talk William Pestle##253
accept The Escape##114 |goto Elwynn Forest/0 43.32,65.71
step
talk Maximillian Crowe##906
|tip Downstairs inside the building.
Train Abilities |trainer Maximillian Crowe##906 |goto Elwynn Forest 44.39,66.24 |q 114
|only if Warlock
step
talk Cylina Darkheart##6374
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Cylina Darkheart##6374 |goto Elwynn Forest 44.40,65.99 |q 114
|only if Warlock
step
talk Zaldimar Wefhellt##328
|tip Upstairs inside the building.
Train Abilities |trainer Zaldimar Wefhellt##328 |goto Elwynn Forest 43.25,66.19 |q 114
|only if Mage
step
talk Priestess Josetta##377
|tip Upstairs inside the building.
Train Abilities |trainer Priestess Josetta##377 |goto Elwynn Forest 43.28,65.72 |q 114
|only if Priest
step
talk Keryn Sylvius##917
|tip Upstairs inside the building.
Train Abilities |trainer Keryn Sylvius##917 |goto Elwynn Forest 43.87,65.94 |q 114
|only if Rogue
step
talk Remy "Two Times"##241
turnin A Man About a Murloc##99129 |goto Elwynn Forest/0 42.14,67.26
accept An Enticing Offer##99130 |goto Elwynn Forest/0 42.14,67.26
step
talk Brother Wilhelm##927
Train Abilities |trainer Brother Wilhelm##927 |goto Elwynn Forest 41.10,66.04 |q 114
|only if Paladin
step
talk Lyria Du Lac##913
Train Abilities |trainer Lyria Du Lac##913 |goto Elwynn Forest 41.08,65.77 |q 114
|only if Warrior
step
talk Josephine Carson##251507
Train Abilities |trainer Josephine Carson##251507 |goto Elwynn Forest/0 41.15,66.23 |q 114
|only if Hunter
stickystart "Collect_Vials_Of_Animal_Blood"
stickystart "Collect_Duskweed_Petals"
step
talk Maybell Maclure##251
|tip Inside the building.
turnin The Escape##114 |goto Elwynn Forest 43.15,89.62
step
label "Collect_Vials_Of_Animal_Blood"
kill Stonetusk Boar##113+
collect 6 Vial of Animal Blood##286215 |q 99130/1 |goto Elwynn Forest/0 41.74,86.78
step
label "Collect_Duskweed_Petals"
click Overgrown Duskweed+
|tip Purple flowers.
collect 18 Duskweed Petal##286214 |q 99130/2 |goto Elwynn Forest/0 41.74,86.78
step
talk Remy "Two Times"##241
turnin An Enticing Offer##99130 |goto Elwynn Forest/0 42.14,67.26
accept Baited for Success##99131 |goto Elwynn Forest/0 42.14,67.26
step
talk Innkeeper Farley##295
|tip Inside the building.
home Goldshire |goto Elwynn Forest/0 43.77,65.81
step
talk Jason Mathers##383
turnin Baited for Success##99131 |goto Elwynn Forest/0 47.46,62.19
step
talk Blixie Fitzwink##248248
accept Stolen Enchanting Supplies##91725 |goto Elwynn Forest/0 63.20,72.62
step
talk Hamish Bergwort##248242
|tip Inside the building.
accept Delicate Instruments##91723 |goto Elwynn Forest/0 65.09,69.84
step
talk Guard Thomas##261
turnin Further Concerns##35 |goto Elwynn Forest 73.97,72.18
accept Find the Lost Guards##37 |goto Elwynn Forest 73.97,72.18
accept Protect the Frontier##52 |goto Elwynn Forest 73.97,72.18
step
talk Ormin Pelford##248265
accept Downstream##91733 |goto Elwynn Forest/0 76.53,71.91
step
talk Sara Timberlain##278
accept Red Linen Goods##83 |goto Elwynn Forest 79.46,68.78
step
talk Supervisor Raelen##10616
accept A Bundle of Trouble##5545 |goto Elwynn Forest 81.38,66.11
step
talk Hagar Lowe##248266
|tip Inside the building.
accept Good Steel##91732 |goto Elwynn Forest/0 82.46,63.82
stickystart "Collect_Bundles_Of_Wood"
stickystart "Kill_Young_Forest_Bears"
stickystart "Kill_Prowlers"
stickystart "Collect_Rough_Wolf_Pelts_Skinning"
step
click A Half-Eaten Body
turnin Find the Lost Guards##37 |goto Elwynn Forest 72.65,60.33
accept Discover Rolf's Fate##45 |goto Elwynn Forest 72.65,60.33
step
label "Collect_Bundles_Of_Wood"
click Bundle of Wood+
|tip Small piles of brown logs.
|tip Near the base of trees.
collect 8 Bundle of Wood##13872 |q 5545/1 |goto Elwynn Forest/0 80.54,60.44
step
label "Kill_Young_Forest_Bears"
kill 5 Young Forest Bear##822 |q 52/2 |goto Elwynn Forest/0 80.54,60.44
|mapmarker Elwynn Forest/0 77.34,62.83
|mapmarker Elwynn Forest/0 84.93,61.22
step
label "Kill_Prowlers"
kill 8 Prowler##118 |q 52/1 |goto Elwynn Forest/0 80.54,60.44
|tip Wolves.
|mapmarker Elwynn Forest/0 77.34,62.83
|mapmarker Elwynn Forest/0 84.93,61.22
step
click Rolf's Corpse
turnin Discover Rolf's Fate##45 |goto Elwynn Forest 79.80,55.52
accept Report to Thomas##71 |goto Elwynn Forest 79.80,55.52
stickystart "Collect_Red_Linen_Bandanas"
step
click Stolen Enchanting Supplies+
|tip Wooden crates.
collect 5 Stolen Enchanting Supplies |q 91725/1 |goto Elwynn Forest/0 67.56,41.42
stickystop "Collect_Red_Linen_Bandanas"
stickystart "Collect_Mining_Tools"
stickystart "Kill_Kobold_Geomancers"
step
Run around the mountain and enter the mine |goto Elwynn Forest 61.71,53.87 < 10 |walk |only if not (subzone("Jasperlode Mine") and indoors())
Scout Through the Jasperlode Mine |q 76/1 |goto Elwynn Forest 60.38,49.68
|tip Inside the mine.
stickystop "Collect_Rough_Wolf_Pelts_Skinning"
step
label "Collect_Mining_Tools"
click Mining Tools+
|tip Metal buckets.
|tip Inside the mine. |notinsticky
collect 4 Mining Tools##247816 |q 91732/1 |goto Elwynn Forest 61.71,53.87
step
label "Kill_Kobold_Geomancers"
kill 8 Kobold Geomancer##476 |q 91723/1 |goto Elwynn Forest 61.71,53.87
|tip Inside and outside the mine. |notinsticky
step
label "Collect_Rough_Wolf_Pelts_Skinning"
Leave the mine |goto Elwynn Forest 61.74,53.88 < 10 |walk |only if subzone("Jasperlode Mine") and indoors()
kill Gray Forest Wolf##1922, Prowler##118
|tip Wolves.
|tip Skin them.
collect 7 Rough Wolf Pelt##247877 |q 91751/1 |goto Elwynn Forest/0 64.78,63.38
|only if haveq(91751) or completedq(91751)
step
Leave the mine |goto Elwynn Forest 61.74,53.88 < 10 |walk |only if subzone("Jasperlode Mine") and indoors()
talk Hamish Bergwort##248242
|tip Inside the building.
turnin Delicate Instruments##91723 |goto Elwynn Forest/0 65.09,69.84
accept Delicate Instruments##91724 |goto Elwynn Forest/0 65.09,69.84
step
talk Blixie Fitzwink##248248
turnin Stolen Enchanting Supplies##91725 |goto Elwynn Forest/0 63.20,72.62
step
label "Collect_Red_Linen_Bandanas"
kill Defias Bandit##116, Defias Rogue Wizard##474
collect 6 Red Linen Bandana##1019 |q 83/1 |goto Elwynn Forest/0 69.49,79.29
step
use Westfall Deed##1972
accept Furlbrow's Deed##184
|only if itemcount(1972) > 0
step
click Waterlogged Toolbox
|tip Underwater.
collect Waterlogged Toolbox##247818 |q 91733/3 |goto Elwynn Forest/0 77.26,86.80
step
click Waterlogged Axe
collect Waterlogged Axe##247817 |q 91733/1 |goto Elwynn Forest/0 76.74,82.46
step
click Waterlogged Saw
collect Waterlogged Saw##247813 |q 91733/2 |goto Elwynn Forest/0 74.27,76.41
step
talk Guard Thomas##261
turnin Protect the Frontier##52 |goto Elwynn Forest 73.97,72.18
turnin Report to Thomas##71 |goto Elwynn Forest 73.97,72.18
accept Deliver Thomas' Report##39 |goto Elwynn Forest 73.97,72.18
accept Report to Gryan Stoutmantle##109 |goto Elwynn Forest 73.97,72.18
step
talk Ormin Pelford##248265
turnin Downstream##91733 |goto Elwynn Forest/0 76.53,71.91
step
talk Sara Timberlain##278
turnin Red Linen Goods##83 |goto Elwynn Forest 79.46,68.78
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 10 ammo when restocking.
Click Here to Continue |confirm |q 5545
|only if Hunter
step
talk Supervisor Raelen##10616
turnin A Bundle of Trouble##5545 |goto Elwynn Forest 81.38,66.11
step
talk Hagar Lowe##248266
|tip Inside the building.
turnin Good Steel##91732 |goto Elwynn Forest/0 82.46,63.82
step
kill 8 Defias Rogue Wizard##474 |q 91724/1 |goto Elwynn Forest/0 74.13,51.34
step
talk Hamish Bergwort##248242
|tip Inside the building.
turnin Delicate Instruments##91724 |goto Elwynn Forest/0 65.09,69.84
step
talk Ariena Stormfeather##931
|tip Follow the road carefully.
|tip Higher level enemies.
fpath Lakeshire |goto Redridge Mountains/0 25.50,59.41
step
talk Maximillian Crowe##906
|tip Downstairs inside the building.
Train Abilities |trainer Maximillian Crowe##906 |goto Elwynn Forest 44.39,66.24 |q 39
|only if Warlock
step
talk Remen Marcot##6121
|tip Downstairs inside the building.
accept Gakin's Summons##1685 |goto Elwynn Forest 44.49,66.27
|only if Human Warlock
step
talk Cylina Darkheart##6374
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Cylina Darkheart##6374 |goto Elwynn Forest 44.40,65.99 |q 39
|only if Warlock
step
talk Zaldimar Wefhellt##328
|tip Upstairs inside the building.
Train Abilities |trainer Zaldimar Wefhellt##328 |goto Elwynn Forest 43.25,66.19 |q 39
|only if Mage
step
talk Priestess Josetta##377
|tip Upstairs inside the building.
Train Abilities |trainer Priestess Josetta##377 |goto Elwynn Forest 43.28,65.72 |q 39
|only if Priest
step
talk Priestess Josetta##377
|tip Upstairs inside the building.
accept Desperate Prayer##5635 |goto Elwynn Forest 43.28,65.72
|only if Human Priest
step
talk Keryn Sylvius##917
|tip Upstairs inside the building.
Train Abilities |trainer Keryn Sylvius##917 |goto Elwynn Forest 43.87,65.94 |q 39
|only if Rogue
step
talk Keryn Sylvius##917
|tip Upstairs inside the building.
accept Seek out SI: 7##2205 |goto Elwynn Forest 43.87,65.94
|only if Rogue
step
talk William Pestle##253
|tip Inside the building.
accept Shipment to Stormwind##61 |goto Elwynn Forest/0 43.32,65.70
step
talk Helene Peltskinner##6306
|tip Inside the building.
turnin Rough Wolf Pelts##91751 |goto Elwynn Forest/0 46.24,62.24
|only if haveq(91751) or completedq(91751)
step
talk Marshal Dughan##240
turnin Deliver Thomas' Report##39 |goto Elwynn Forest/0 42.11,65.93
turnin The Jasperlode Mine##76 |goto Elwynn Forest/0 42.11,65.93
accept Westbrook Garrison Needs Help!##239 |goto Elwynn Forest/0 42.11,65.93
step
talk Smith Argus##514
|tip Inside the building.
accept Elmore's Task##1097 |goto Elwynn Forest/0 41.71,65.55
step
talk Brother Wilhelm##927
Train Abilities |trainer Brother Wilhelm##927 |goto Elwynn Forest 41.10,66.04 |q 239
|only if Paladin
step
talk Lyria Du Lac##913
Train Abilities |trainer Lyria Du Lac##913 |goto Elwynn Forest 41.08,65.77 |q 239
|only if Warrior
step
talk Lyria Du Lac##913
accept A Warrior's Training##1638 |goto Elwynn Forest 41.09,65.77
|only if Human Warrior
step
talk Josephine Carson##251507
Train Abilities |trainer Josephine Carson##251507 |goto Elwynn Forest/0 41.15,66.23 |q 94792 |future
|only if Hunter
step
talk Josephine Carson##251507
accept Taming the Beast##94792 |goto Elwynn Forest/0 41.15,66.23
|only if Hunter
step
use Taming Rod##266158
|tip On a Rockhide Boar.
Tame a Rockhide Boar |q 94792/1 |goto Elwynn Forest/0 46.04,77.92
|only if Hunter
step
talk Josephine Carson##251507
turnin Taming the Beast##94792 |goto Elwynn Forest/0 41.15,66.23
accept Taming the Beast##94863 |goto Elwynn Forest/0 41.15,66.23
|only if Hunter
step
use Taming Rod##266253
|tip On a Gray Forest Wolf.
|tip Dismiss your pet first.
Tame a Gray Forest Wolf |q 94863/1 |goto Elwynn Forest/0 65.73,63.52
|only if Hunter
step
talk Josephine Carson##251507
turnin Taming the Beast##94863 |goto Elwynn Forest/0 41.15,66.23
accept Taming the Beast##94864 |goto Elwynn Forest/0 41.15,66.23
|only if Hunter
step
use Taming Rod##266254
|tip On a Young Forest Bear.
|tip Dismiss your pet first.
Tame a Young Forest Bear |q 94864/1 |goto Elwynn Forest/0 46.92,78.34
|only if Hunter
step
talk Josephine Carson##251507
turnin Taming the Beast##94864 |goto Elwynn Forest/0 41.15,66.23
accept Training the Beast##94793 |goto Elwynn Forest/0 41.15,66.23
|only if Hunter
step
talk Isaac Chan##258930
turnin Training the Beast##94793 |goto Elwynn Forest/0 41.79,66.37
|only if Hunter
step
talk Isaac Chan##258930
Train Pet Abilities |trainer Isaac Chan##258930 |goto Elwynn Forest/0 41.79,66.37 |q 239
|only if Hunter
step
_NOTE:_
Tame a Young Forest Bear
|tip Cast {o}Tame Beast{} on a Young Forest Bear.
|tip Find one that's {o}level 9{}, if possible.
|tip Dismiss your pet first.
Click Here to Continue |confirm |q 239 |goto Elwynn Forest/0 46.92,78.34
|only if Hunter
step
talk Deputy Rainer##963
turnin Westbrook Garrison Needs Help!##239 |goto Elwynn Forest 24.23,74.45
accept Riverpaw Gnoll Bounty##11 |goto Elwynn Forest 24.23,74.45
step
kill Riverpaw Runt##97, Riverpaw Outrunner##478
|tip Gnolls.
collect 8 Painted Gnoll Armband##782 |q 11/1 |goto Elwynn Forest/0 28.06,86.38
step
talk Deputy Rainer##963
turnin Riverpaw Gnoll Bounty##11 |goto Elwynn Forest 24.23,74.45
step
talk Farmer Furlbrow##237
turnin Furlbrow's Deed##184 |goto Westfall 59.96,19.36 |only if haveq(184) or completedq(184)
accept The Forgotten Heirloom##64 |goto Westfall 59.96,19.36
step
talk Verna Furlbrow##238
accept Westfall Stew##36 |goto Westfall 59.92,19.42
accept Poor Old Blanchy##151 |goto Westfall 59.92,19.42
step
talk Farmer Saldean##233
accept The Killing Fields##9 |goto Westfall 56.05,31.22
step
talk Salma Saldean##235
|tip Inside the building.
turnin Westfall Stew##36 |goto Westfall 56.42,30.52
accept Westfall Stew##38 |goto Westfall 56.42,30.52
accept Goretusk Liver Pie##22 |goto Westfall 56.42,30.52
step
talk Gryan Stoutmantle##234
turnin Report to Gryan Stoutmantle##109 |goto Westfall/0 56.33,47.52
accept The People's Militia##12 |goto Westfall/0 56.33,47.52
step
talk Captain Danuvin##821
accept Patrolling Westfall##102 |goto Westfall/0 56.42,47.62
step
talk Quartermaster Lewis##491
|tip Inside the building.
accept A Swift Message##6181 |goto Westfall 57.00,47.17
step
talk Thor##523
fpath Sentinel Hill |goto Westfall 56.55,52.64
step
talk Thor##523
turnin A Swift Message##6181 |goto Westfall 56.56,52.64
accept Continue to Stormwind##6281 |goto Westfall 56.56,52.64
step
talk Thor##523
|tip Open the flight map.
|tip Allows guide to learn your flight paths.
fpath Stormwind City |goto Westfall 56.55,52.64
step
talk Morgan Pestle##279
|tip Inside the building.
turnin Shipment to Stormwind##61 |goto Stormwind City/0 63.16,74.41
step
talk Woo Ping##11867
|tip Inside the building.
Train Two-Handed Swords |complete weaponskill("TH_SWORD") > 0	|goto Stormwind City/0 63.88,69.09	|only if Warrior or Paladin or Hunter
Train One-Handed Swords |complete weaponskill("SWORD") > 0	|goto Stormwind City/0 63.88,69.09	|only if Rogue or Warlock or Mage
Train Staves		|complete weaponskill("TH_STAFF") > 0	|goto Stormwind City/0 63.88,69.09	|only if Priest or Warlock
Train Daggers		|complete weaponskill("DAGGER") > 0	|goto Stormwind City/0 63.88,69.09	|only if Mage
|only if Warrior or Paladin or Rogue or Warlock or Mage or Priest or Hunter
step
Enter the building |goto Stormwind City/0 42.21,81.84 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Gakin's Summons##1685 |goto Stormwind City/0 39.22,85.25
accept Surena Caledon##1688 |goto Stormwind City/0 39.22,85.25
|only Warlock
step
kill Surena Caledon##881
|tip Inside the building.
collect Surena's Choker##6810 |q 1688/1 |goto Elwynn Forest 71.02,80.78
|only if Warlock
step
Enter the building |goto Stormwind City/0 42.21,81.84 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Surena Caledon##1688 |goto Stormwind City/0 39.22,85.25
accept The Binding##1689 |goto Stormwind City/0 39.22,85.25
|only if Warlock
step
use Bloodstone Choker##6928
|tip Stand on the pink symbol.
|tip Inside the crypt.
|tip Downstairs inside the building.
kill Summoned Voidwalker##5676 |q 1689/1 |goto Stormwind City/0 36.79,89.56
|only if Warlock
step
talk Gakin the Darkbinder##6122
|tip Above the crypt.
|tip Downstairs inside the building.
turnin The Binding##1689 |goto Stormwind City/0 39.22,85.25
|only if Warlock
step
talk Innkeeper Allison##6740
|tip Inside the building.
home Stormwind City |goto Stormwind City/0 60.39,75.27
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin Seek out SI: 7##2205 |goto Stormwind City/0 78.31,70.74
|only if Rogue
step
talk Osric Strang##1323
|tip Inside the building.
turnin Continue to Stormwind##6281 |goto Stormwind City/0 77.17,60.98
accept Dungar Longdrink##6261 |goto Stormwind City/0 77.17,60.98
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin A Warrior's Training##1638 |goto Stormwind City/0 77.13,53.26
accept Bartleby the Drunk##1639 |goto Stormwind City/0 77.13,53.26
|only if Warrior
step
talk Bartleby##6090
|tip Walks around.
|tip Inside the building.
turnin Bartleby the Drunk##1639 |goto Stormwind City/0 76.76,52.56
accept Beat Bartleby##1640 |goto Stormwind City/0 76.76,52.56
|tip You will be attacked.
|only if Warrior
step
kill Bartleby##6090
|tip Walks around.
|tip Inside the building.
Beat Bartleby |q 1640/1 |goto Stormwind City/0 76.76,52.56
|only if Warrior
step
talk Bartleby##6090
|tip Walks around.
|tip Inside the building.
turnin Beat Bartleby##1640 |goto Stormwind City/0 76.76,52.56
accept Bartleby's Mug##1665 |goto Stormwind City/0 76.76,52.56
|only if Warrior
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin Bartleby's Mug##1665 |goto Stormwind City/0 77.13,53.26
|only if Warrior
step
Enter the building |goto Stormwind City/0 52.96,51.06 < 15 |walk |only if not (subzone("Cathedral of Light") and indoors())
talk High Priestess Laurena##376
|tip Inside the building.
turnin Desperate Prayer##5635 |goto Stormwind City/0 49.52,44.60
|only if Priest
step
talk Grimand Elmore##1416
|tip Inside the building.
turnin Elmore's Task##1097 |goto Stormwind City/0 59.72,33.78
accept Stormpike's Delivery##353 |goto Stormwind City/0 59.72,33.78
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Stormwind City/0 69.31,30.56 |q 96408 |future
|tip Walk into the portal.
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the tram to Ironforge.
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
accept Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
use Rat Catcher's Flute##17117
|tip On Deeprun Rats.
|tip Small grey rats.
|tip Ironforge section of the Deeprun Tram.
Capture #5# Rats |q 6661/1
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
turnin Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
Enter Ironforge |complete zone("Ironforge") |q 96408 |future
|tip Walk into the portal.
step
talk Bixi Wobblebonk##13084
|tip Inside the building.
Train Thrown |complete weaponskill("THROWN") > 0 |goto Ironforge 62.23,89.62
|only if Warrior
step
talk Buliwyf Stonehand##11865
|tip Inside the building.
Train Two-Handed Maces |complete weaponskill("TH_MACE") > 0 |goto Ironforge 61.17,89.52
|only if Warrior
step
talk Gryth Thurden##1573
fpath Ironforge |goto Ironforge 55.50,47.75
step
talk Beldin Steelgrill##1376
accept A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 50.44,49.09
step
talk Rudra Amberstill##1265
|tip Follow the road.
accept Never Saddle on Quality##95212 |goto Dun Morogh/0 63.08,49.85
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 64.88,58.46
accept Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
Select _"Earthseer, please share your farsight with me."_ |gossip 139831
Use Farsen's Farsight |q 96392/1 |goto Dun Morogh/0 64.88,58.46
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
accept Nip 'Em in the Bud##96390 |goto Dun Morogh/0 64.88,58.46
step
talk Senator Mehr Stonehallow##1977
accept The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Foreman Stonebrow##1254
accept Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
step
kill 6 Rockjaw Skullthumper##1115 |q 432/1 |goto Dun Morogh/0 69.17,58.42
|tip More inside the cave nearby.
step
Leave the cave |goto Dun Morogh 70.70,56.49 < 20 |walk |only if subzone("Gol'Bolar Quarry Mine")
talk Foreman Stonebrow##1254
turnin Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
stickystart "Kill_Dark_Iron_Spies"
stickystart "Collect_Pristine_Leopard_Pelts"
stickystart "Kill_Rockjaw_Bonesnappers"
step
kill Dark Iron Spy##6123+
collect Dark Iron Map##274268 |n
use Dark Iron Map##274268
accept Underground Map##96391 |goto Dun Morogh/0 77.46,60.87
step
label "Kill_Dark_Iron_Spies"
kill 10 Dark Iron Spy##6123 |q 96390/1 |goto Dun Morogh/0 77.46,60.87
step
label "Collect_Pristine_Leopard_Pelts"
kill Elder Snow Leopard##260157+
collect 6 Pristine Leopard Pelt##267414 |q 95212/1 |goto Dun Morogh/0 75.24,56.91
step
label "Kill_Rockjaw_Bonesnappers"
kill 10 Rockjaw Bonesnapper##1117 |q 433/1 |goto Dun Morogh/0 75.24,56.91
step
talk Senator Mehr Stonehallow##1977
turnin The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Nip 'Em in the Bud##96390 |goto Dun Morogh/0 64.88,58.46
turnin Underground Map##96391 |goto Dun Morogh/0 64.88,58.46
step
talk Rudra Amberstill##1265
turnin Never Saddle on Quality##95212 |goto Dun Morogh/0 63.08,49.85
step
talk Pilot Hammerfoot##1960
|tip Follow the road through the tunnel.
accept The Lost Pilot##419 |goto Dun Morogh 83.89,39.19
step
click A Dwarven Corpse
turnin The Lost Pilot##419 |goto Dun Morogh 79.67,36.17
accept A Pilot's Revenge##417 |goto Dun Morogh 79.67,36.17
step
kill Mangeclaw##1961
|tip White bear.
|tip Walks around.
collect Mangy Claw##3183 |q 417/1 |goto Dun Morogh/0 78.97,37.02
step
talk Pilot Hammerfoot##1960
turnin A Pilot's Revenge##417 |goto Dun Morogh/0 83.89,39.19
step
talk Mountaineer Stormpike##1343
|tip Run through the tunnel.
|tip Upstairs inside the building.
turnin Stormpike's Delivery##353 |goto Loch Modan/0 24.76,18.40
stickystart "Accept_Mountaineer_Stormpikes_Task"
step
talk Thorgrum Borrelson##1572
fpath Thelsamar |goto Loch Modan/0 33.94,50.95
step
label "Accept_Mountaineer_Stormpikes_Task"
map Loch Modan
path	follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	32.67,49.72	33.27,49.16	33.86,48.37	34.30,47.64	34.91,47.05
path	35.56,46.76	36.09,46.37	37.11,46.01	37.32,45.60	37.37,44.45
path	37.29,43.33	36.73,41.98
talk Mountaineer Kadrell##1340
|tip Walks a large path.
accept Rat Catching##416
accept Mountaineer Stormpike's Task##1339
step
kill Tunnel Rat Scout##1173, Tunnel Rat Vermin##1172, Tunnel Rat Forager##1176
|tip Rat people.
collect 12 Tunnel Rat Ear##3110 |q 416/1 |goto Loch Modan/0 26.99,43.26
|mapmarker Loch Modan/0 24.77,30.34
|mapmarker Loch Modan/0 37.47,17.07
step
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Mountaineer Stormpike's Task##1339 |goto Loch Modan 24.76,18.40
accept Stormpike's Order##1338 |goto Loch Modan 24.76,18.40
accept Filthy Paws##307 |goto Loch Modan/0 24.76,18.40
step
map Loch Modan
path	follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	32.67,49.72	33.27,49.16	33.86,48.37	34.30,47.64	34.91,47.05
path	35.56,46.76	36.09,46.37	37.11,46.01	37.32,45.60	37.37,44.45
path	37.29,43.33	36.73,41.98
talk Mountaineer Kadrell##1340
|tip Walks a large path.
turnin Rat Catching##416
step
talk Mountaineer Cobbleflint##1089
accept In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.12
step
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
accept The Trogg Threat##267 |goto Loch Modan 23.23,73.67
stickystart "Kill_Stonesplinter_Troggs_And_Scouts"
stickystart "Collect_Linen_Cloth_Paladin"
step
Follow the road to the path here |goto Loch Modan 29.32,66.73 < 40 |only if walking and not subzone("Stonesplinter Valley")
kill Stonesplinter Trogg##1161, Stonesplinter Scout##1162
collect 8 Trogg Stone Tooth##2536 |q 267/1 |goto Loch Modan/0 32.79,74.99
|mapmarker Loch Modan/0 27.49,52.97
step
label "Kill_Stonesplinter_Troggs_And_Scouts"
kill 10 Stonesplinter Trogg##1161 |q 224/1 |goto Loch Modan/0 32.79,74.99
kill 10 Stonesplinter Scout##1162 |q 224/2 |goto Loch Modan/0 32.79,74.99
|mapmarker Loch Modan/0 27.49,52.97
step
label "Collect_Linen_Cloth_Paladin"
kill Stonesplinter Trogg##1161, Stonesplinter Scout##1162
collect 10 Linen Cloth##2589 |goto Loch Modan/0 32.79,74.99 |q 1644 |future
|tip Needed for class quest soon.
|tip Don't vendor them.
|mapmarker Loch Modan/0 27.49,52.97
|only if Paladin
step
Leave Stonesplinter Valley and follow the road |goto Loch Modan 30.57,69.69 < 30 |only if walking and subzone("Stonesplinter Valley")
talk Mountaineer Cobbleflint##1089
turnin In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.13
step
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
turnin The Trogg Threat##267 |goto Loch Modan 23.23,73.67
step
talk Elsharin##5498
|tip Top of the tower.
Train Abilities |trainer Elsharin##5498 |goto Stormwind City/0 48.21,87.22 |q 1338
|only if Mage
step
Enter the building |goto Stormwind City/0 42.23,81.82 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Demisette Cloyce##461
|tip Downstairs inside the building.
Train Abilities |trainer Demisette Cloyce##461 |goto Stormwind City/0 39.25,84.96 |q 1338
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.51 |q 1338
|only if Warlock
step
Enter the building |goto Stormwind City/0 52.97,51.06 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.61,46.35 |q 1338
|only if Priest
step
Enter the building |goto Stormwind City/0 52.97,51.06 < 15 |walk |only if not subzone("Cathedral of Light")
talk Duthorian Rall##6171
|tip Inside the building.
accept The Tome of Divinity##1641 |goto Stormwind City/0 50.48,47.48
|only if Human Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1641 |goto Stormwind City/0 50.48,47.48
|only if Human Paladin
step
use Tome of Divinity##6775
accept The Tome of Divinity##1642
|only if Human Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1642 |goto Stormwind City/0 50.48,47.48
accept The Tome of Divinity##1643 |goto Stormwind City/0 50.48,47.48
|only if Human Paladin
step
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.09 |q 1338
|only if Paladin
step
talk Furen Longbeard##5413
turnin Stormpike's Order##1338 |goto Stormwind City/0 64.60,37.22
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 6261
|only if Hunter
step
talk Karrina Mekenda##2879
|tip Inside the building.
Train Pet Abilities |trainer Karrina Mekenda##2879 |goto Stormwind City/0 67.28,36.78 |q 6261
|only if Hunter
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 6261
|only if Warrior
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 6261
|only if Rogue
step
talk Stephanie Turner##6174
turnin The Tome of Divinity##1643 |goto Stormwind City 63.82,72.20
accept The Tome of Divinity##1644 |goto Stormwind City 63.82,72.20
|only if Human Paladin
step
talk Stephanie Turner##6174
turnin The Tome of Divinity##1644 |goto Stormwind City 63.82,72.20
|only if Human Paladin
step
Run up the ramp |goto Stormwind City 67.94,72.62 < 10 |only if walking
talk Dungar Longdrink##352
|tip Inside the building.
turnin Dungar Longdrink##6261 |goto Stormwind City/0 71.29,72.23
accept Return to Lewis##6285 |goto Stormwind City/0 71.29,72.23
step
talk Quartermaster Lewis##491
|tip Inside the building.
turnin Return to Lewis##6285 |goto Westfall 57.00,47.17
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Dwarf & Gnome Starter (1-13)",{
image=ZGV.IMAGESDIR.."Dun Morogh",
condition_suggested=function() return (raceclass('Dwarf') or raceclass('Gnome')) and level <= 13 end,
condition_suggested_exclusive=true,
condition_visible=function() return Dwarf or Gnome end,
hardcore = true,
linked = {"Leveling Guides\\Hidden Guides"},
linkedhidden = true,
next="Leveling Guides\\Westfall (13-15)",
},[[
defaultfor Dwarf,Gnome
step
_NOTE:_
Wrong Character Race
|tip Guide written for {o}Dwarf & Gnome{} characters.
|tip Other races may encounter issues.
Click Here to Continue |confirm
|only if not (Dwarf or Gnome)
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948	|q 179 |future
|only if not hardcore()
step
_NOTE:_
Manage Your Ammo
|tip Make sure you always have ammo.
|tip You need it to attack enemies.
|tip {o}General Goods{} vendors sell it (also Bow & Gun vendors).
|tip Try to keep your ammo bag full.
Click Here to Continue |confirm |q 179 |future
|only if Hunter
step
Kill enemies
|tip Loot items worth at least {o}10 copper{} to sell.
|tip Allows training an ability early.
Click Here to Continue |confirm |goto Dun Morogh 30.60,74.40 |q 179 |future
|mapmarker Dun Morogh/0 26.00,69.40
|mapmarker Dun Morogh/0 26.40,74.20
|mapmarker Dun Morogh/0 27.40,71.20
|mapmarker Dun Morogh/0 28.20,75.60
|mapmarker Dun Morogh/0 28.40,73.40
|mapmarker Dun Morogh/0 29.40,77.20
|mapmarker Dun Morogh/0 30.80,69.40
|mapmarker Dun Morogh/0 30.80,72.40
|only if Warrior or Warlock or Shaman
step
talk Adlin Pridedrift##829
Sell Items |vendor Adlin Pridedrift##829 |goto Dun Morogh/0 30.08,71.52 |q 179 |future
|only if Warrior or Warlock or Shaman
step
Enter the building |goto Dun Morogh/0 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Thran Khorman##912
|tip Inside the building.
Train Abilities |trainer Thran Khorman##912 |goto Dun Morogh 28.83,67.24 |q 179 |future
|only if Warrior
step
Enter the building |goto Dun Morogh/0 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Alamar Grimm##460
|tip Upstairs inside the building.
Train Abilities |trainer Alamar Grimm##460 |goto Dun Morogh/0 28.59,66.23 |q 179 |future
|only if Warlock
step
Enter the building |goto Dun Morogh/0 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Teo Hammerstorm##257446
|tip Upstairs inside the building.
Train Abilities |trainer Teo Hammerstorm##257446 |goto Dun Morogh/0 28.79,66.19 |q 179 |future
|only if Shaman
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
talk Sten Stoutarm##658
accept Dwarven Outfitters##179 |goto Dun Morogh 29.93,71.20
step
kill Ragged Young Wolf##705, Ragged Timber Wolf##704
|tip Wolves.
collect 8 Tough Wolf Meat##750 |q 179/1 |goto Dun Morogh/0 27.96,73.88
step
talk Sten Stoutarm##658
turnin Dwarven Outfitters##179			|goto Dun Morogh 29.93,71.20
accept Coldridge Valley Mail Delivery##233	|goto Dun Morogh 29.93,71.20
accept Simple Rune##3106			|goto Dun Morogh 29.93,71.20	|only Dwarf Warrior
accept Encrypted Rune##3109			|goto Dun Morogh 29.93,71.20	|only Dwarf Rogue
accept Hallowed Rune##3110			|goto Dun Morogh 29.93,71.20	|only Dwarf Priest
accept Consecrated Rune##3107			|goto Dun Morogh 29.93,71.20	|only Dwarf Paladin
accept Etched Rune##3108			|goto Dun Morogh 29.93,71.20	|only Dwarf Hunter
accept Archaic Rune##98581			|goto Dun Morogh 29.93,71.20	|only Dwarf Shaman
accept Glyphic Memorandum##3114			|goto Dun Morogh 29.93,71.20	|only Gnome Mage
accept Simple Memorandum##3112			|goto Dun Morogh 29.93,71.20	|only Gnome Warrior
accept Tainted Memorandum##3115			|goto Dun Morogh 29.93,71.20	|only Gnome Warlock
accept Encrypted Memorandum##3113		|goto Dun Morogh 29.93,71.20	|only Gnome Rogue
accept Hallowed Memorandum##98574		|goto Dun Morogh 29.93,71.20	|only Gnome Priest
step
talk Balir Frosthammer##713
accept A New Threat##170 |goto Dun Morogh 29.71,71.25
step
kill 6 Rockjaw Trogg##707 |q 170/1 |goto Dun Morogh/0 30.58,76.34
kill 6 Burly Rockjaw Trogg##724 |q 170/2 |goto Dun Morogh/0 30.58,76.34
|mapmarker Dun Morogh/0 25.95,74.99
step
talk Balir Frosthammer##713
turnin A New Threat##170 |goto Dun Morogh 29.71,71.25
step
talk Talin Keeneye##714
turnin Coldridge Valley Mail Delivery##233 |goto Dun Morogh/0 22.60,71.43
accept Coldridge Valley Mail Delivery##234 |goto Dun Morogh/0 22.60,71.43
accept The Boar Hunter##183 |goto Dun Morogh/0 22.60,71.43
step
kill 12 Small Crag Boar##708 |q 183/1 |goto Dun Morogh/0 21.61,71.13
step
talk Talin Keeneye##714
turnin The Boar Hunter##183 |goto Dun Morogh/0 22.60,71.43
step
Kill enemies
|tip Helps reach level 4 after quest turnins.
|tip Quest requires level 4 soon.
ding 3,1130 |goto Dun Morogh/0 21.61,71.13
step
talk Grelin Whitebeard##786
turnin Coldridge Valley Mail Delivery##234 |goto Dun Morogh/0 25.08,75.71
|delay 0.2
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
talk Nori Pridedrift##12738
accept Scalding Mornbrew Delivery##3364 |goto Dun Morogh/0 24.98,75.96
step
_NOTE:_
During the Next Steps
|tip {o}Hurry{}, timed quest.
Click Here to Continue |confirm |q 3364
step
Enter the building |goto Dun Morogh/0 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Felix Whindlebolt##8416
|tip Walks around.
|tip Inside the building.
accept A Refugee's Quandary##3361 |goto Dun Morogh/0 28.51,67.67
step
talk Grund Drokda##2756
|tip Inside the building.
accept Grund and Gozwin##97277 |goto Dun Morogh/0 28.67,67.51
step
talk Durnan Furcutter##836
|tip Inside the building.
turnin Scalding Mornbrew Delivery##3364 |goto Dun Morogh/0 28.77,66.37
accept Bring Back the Mug##3365 |goto Dun Morogh/0 28.77,66.37
step
talk Thran Khorman##912
|tip Inside the building.
turnin Simple Rune##3106	|goto Dun Morogh 28.83,67.24 |only if Dwarf
turnin Simple Memorandum##3112	|goto Dun Morogh 28.83,67.24 |only if Gnome
|only if Warrior
step
talk Thran Khorman##912
|tip Inside the building.
Train Abilities |trainer Thran Khorman##912 |goto Dun Morogh 28.83,67.24 |q 170
|only if Warrior
step
talk Solm Hargrin##916
|tip Inside the building.
turnin Encrypted Rune##3109		|goto Dun Morogh 28.37,67.51 |only if Dwarf
turnin Encrypted Memorandum##3113	|goto Dun Morogh 28.37,67.51 |only if Gnome
|only if Rogue
step
talk Solm Hargrin##916
|tip Inside the building.
Train Abilities |trainer Solm Hargrin##916 |goto Dun Morogh 28.37,67.51 |q 170
|only if Rogue
step
talk Branstock Khalder##837
|tip Inside the building.
turnin Hallowed Rune##3110		|goto Dun Morogh 28.60,66.39 |only if Dwarf
turnin Hallowed Memorandum##98574	|goto Dun Morogh 28.60,66.39 |only if Gnome
|only if Priest
step
talk Branstock Khalder##837
|tip Inside the building.
Train Abilities |trainer Branstock Khalder##837 |goto Dun Morogh 28.60,66.39 |q 170
|only if Priest
step
talk Bromos Grummner##926
|tip Inside the building.
turnin Consecrated Rune##3107 |goto Dun Morogh 28.83,68.33
|only if Paladin
step
talk Bromos Grummner##926
|tip Inside the building.
Train Abilities |trainer Bromos Grummner##926 |goto Dun Morogh 28.83,68.33 |q 170
|only if Paladin
step
talk Thorgas Grimson##895
|tip Inside the building.
turnin Etched Rune##3108 |goto Dun Morogh 29.18,67.46
|only if Hunter
step
talk Thorgas Grimson##895
|tip Inside the building.
Train Abilities |trainer Thorgas Grimson##895 |goto Dun Morogh 29.18,67.46 |q 170
|only if Hunter
step
talk Marryk Nurribit##944
|tip Inside the building.
turnin Glyphic Memorandum##3114 |goto Dun Morogh 28.71,66.36
|only if Mage
step
talk Marryk Nurribit##944
|tip Inside the building.
Train Abilities |trainer Marryk Nurribit##944 |goto Dun Morogh 28.71,66.36 |q 170
|only if Mage
step
talk Alamar Grimm##460
|tip Upstairs inside the building.
turnin Tainted Memorandum##3115 |goto Dun Morogh/0 28.59,66.23
accept Beginnings##1599 |goto Dun Morogh/0 28.59,66.23
|only if Warlock
step
talk Alamar Grimm##460
|tip Upstairs inside the building.
Train Abilities |trainer Alamar Grimm##460 |goto Dun Morogh/0 28.59,66.23 |q 170
|only if Warlock
step
talk Teo Hammerstorm##257446
|tip Upstairs inside the building.
Train Abilities |trainer Teo Hammerstorm##257446 |goto Dun Morogh/0 28.79,66.19 |q 98581
|only if Shaman
step
talk Teo Hammerstorm##257446
|tip Upstairs inside the building.
turnin Archaic Rune##98581 |goto Dun Morogh/0 28.79,66.19
accept Call of Earth##94373 |goto Dun Morogh/0 28.79,66.19
|only if Shaman
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
Run up the mountain |goto Dun Morogh/0 26.56,67.54 < 30 |only if walking
kill Snow Leopard Prowler##269075 |q 97277/2 |goto Dun Morogh/0 27.40,62.73
|tip Walks around.
|tip Top of the mountain.
step
click Gozwin's Mechanic's Log
|tip Black book.
|tip Top of the mountain.
collect Gozwin's Mechanic's Log##277976 |q 97277/1 |goto Dun Morogh/0 27.28,62.85
step
Enter the building |goto Dun Morogh/0 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Grund Drokda##2756
|tip Inside the building.
turnin Grund and Gozwin##97277 |goto Dun Morogh/0 28.67,67.51
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
talk Adlin Pridedrift##829
buy Skinning Knife##7005 |goto Dun Morogh/0 30.09,71.58 |q 3365
buy Apprentice's Skinning Satchel##277114 |goto Dun Morogh/0 30.09,71.58 |q 3365
|only if skillmax("Skinning") > 1
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
talk Adlin Pridedrift##829
buy Apprentice's Herb Pouch##277113 |goto Dun Morogh/0 30.09,71.58 |q 3365
|only if skillmax("Herbalism") > 1
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
talk Adlin Pridedrift##829
buy Mining Pick##2901 |goto Dun Morogh/0 30.09,71.58 |q 3365
buy Apprentice's Mining Pack##277115 |goto Dun Morogh/0 30.09,71.58 |q 3365
|only if skillmax("Mining") > 1
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
talk Grelin Whitebeard##786
accept The Troll Cave##182 |goto Dun Morogh 25.08,75.71
step
talk Nori Pridedrift##12738
turnin Bring Back the Mug##3365 |goto Dun Morogh 24.98,75.96
stickystart "Kill_Frostmane_Troll_Whelps"
step
kill Frostmane Novice##946+
|tip Uncommon and spread out.
|tip Inside the cave.
collect 3 Feather Charm##6753 |q 1599/1 |goto Dun Morogh 26.78,79.83
|mapmarker Dun Morogh/0 28.60,83.00
|mapmarker Dun Morogh/0 30.40,79.40
|only if Warlock
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Anywhere inside the cave.
Die on Purpose |complete isdead |goto Dun Morogh 26.78,79.83 |q 1599
|only if Warlock and not hardcore()
stickystop "Kill_Frostmane_Troll_Whelps"
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Dun Morogh 29.55,69.83 |q 1599 |zombiewalk
|only if Warlock and not hardcore()
step
Leave the cave |goto Dun Morogh 26.78,79.83 < 15 |walk |only if (subzone("Coldridge Valley") and indoors()) and hardcore()
Enter the building |goto Dun Morogh 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Alamar Grimm##460
|tip Upstairs inside the building.
turnin Beginnings##1599 |goto Dun Morogh/0 28.59,66.23
|only if Warlock
step
talk Wren Darkspring##6376
|tip Buy available Grimoires.
|tip Upstairs inside the building.
Train Demon Abilities |vendor Wren Darkspring##6376 |goto Dun Morogh/0 28.60,66.16 |q 3361
|only if Warlock
stickystart "Collect_Iceclaw_Bear_Pendants_Shaman"
stickystart "Kill_Frostmane_Troll_Whelps"
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
click Felix's Box
collect Felix's Box##10438 |q 3361/1 |goto Dun Morogh 20.88,76.07
step
click Felix's Chest
collect Felix's Chest##16313 |q 3361/2 |goto Dun Morogh 22.78,80.00
step
click Felix's Bucket of Bolts
collect Felix's Bucket of Bolts##16314 |q 3361/3 |goto Dun Morogh 26.33,79.27
step
label "Collect_Iceclaw_Bear_Pendants_Shaman"
kill Frostmane Troll Whelp##706+
|tip Inside and outside the cave. |notinsticky
collect 2 Iceclaw Bear Pendant##264356 |q 94373/1 |goto Dun Morogh 26.80,79.86
|only if Shaman
step
label "Kill_Frostmane_Troll_Whelps"
kill 14 Frostmane Troll Whelp##706 |q 182/1 |goto Dun Morogh 26.80,79.86
|tip Inside and outside the cave. |notinsticky
step
Leave the cave |goto Dun Morogh 26.78,79.83 < 15 |walk |only if subzone("Coldridge Valley") and indoors()
talk Grelin Whitebeard##786
turnin The Troll Cave##182 |goto Dun Morogh 25.08,75.71
accept The Stolen Journal##218 |goto Dun Morogh 25.08,75.71
step
Enter the cave |goto Dun Morogh 26.80,79.86 < 15 |walk |only if not (subzone("Coldridge Valley") and indoors())
kill Grik'nir the Cold##808
|tip Inside the cave.
collect Grelin Whitebeard's Journal##2004 |q 218/1 |goto Dun Morogh 30.49,80.16
step
Leave the cave |goto Dun Morogh 26.78,79.83 < 15 |walk |only if subzone("Coldridge Valley") and indoors()
talk Grelin Whitebeard##786
turnin The Stolen Journal##218 |goto Dun Morogh 25.08,75.71
accept Senir's Observations##282 |goto Dun Morogh 25.08,75.71
step
Enter the building |goto Dun Morogh 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Felix Whindlebolt##8416
|tip Walks around.
|tip Inside the building.
turnin A Refugee's Quandary##3361 |goto Dun Morogh 28.55,67.65
step
talk Teo Hammerstorm##257446
|tip Upstairs inside the building.
turnin Call of Earth##94373 |goto Dun Morogh/0 28.79,66.19
accept Call of Earth##94374 |goto Dun Morogh/0 28.79,66.19
|only if Shaman
step
Leave the building |goto Dun Morogh 28.79,69.07 < 10 |walk |only if subzone("Anvilmar") and indoors()
Run up the mountain |goto Dun Morogh/0 26.56,67.54 < 30 |only if walking
use Earth Sapta##6635
|tip Top of the mountain.
talk Minor Manifestation of Earth##5891
turnin Call of Earth##94374 |goto Dun Morogh/0 24.89,61.86
accept Call of Earth##94375 |goto Dun Morogh/0 24.89,61.86
|only if Shaman
step
Enter the building |goto Dun Morogh 28.79,69.05 < 10 |walk |only if not (subzone("Anvilmar") and indoors())
talk Teo Hammerstorm##257446
|tip Upstairs inside the building.
turnin Call of Earth##94375 |goto Dun Morogh/0 28.79,66.19
|only if Shaman
step
Leave the building |goto Dun Morogh 28.79,69.05 < 10 |walk |only if subzone("Anvilmar") and indoors()
talk Mountaineer Thalos##1965
turnin Senir's Observations##282 |goto Dun Morogh 33.48,71.84
accept Senir's Observations##420 |goto Dun Morogh 33.48,71.84
accept The Adventurer##96628 |goto Dun Morogh/0 33.48,71.84
step
talk Hands Springsprocket##6782
accept Supplies to Tannok##2160 |goto Dun Morogh 33.85,72.24
stickystart "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
step
Run through the tunnel and follow the road |goto Dun Morogh 34.12,71.51 < 10 |only if walking and subzone("Coldridge Pass")
talk Eric Brighthammer##265813
turnin The Adventurer##96628 |goto Dun Morogh/0 46.71,53.95
accept The Great Outdoors##96608 |goto Dun Morogh/0 46.71,53.95
stickystop "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
step
Watch the dialogue
Use the {y}/sit{} Emote Near the Campfire |q 96608/1 |goto Dun Morogh/0 46.71,53.95 |macro /sit
Gain the Boosted Rest Buff |q 96608/2 |goto Dun Morogh/0 46.71,53.95
|tip Takes {o}1 minute{}.
step
talk Eric Brighthammer##265813
turnin The Great Outdoors##96608		|goto Dun Morogh/0 46.71,53.95
accept Camping 101: Cooking##96629		|goto Dun Morogh/0 46.71,53.95
accept Camping 101: Skinning##96056		|goto Dun Morogh/0 46.71,53.95 |only if skillmax("Skinning") >= 1
step
talk Senir Whitebeard##1252
turnin Senir's Observations##420 |goto Dun Morogh/0 46.77,53.81
accept Secure the Mountain##98322 |goto Dun Morogh/0 46.77,53.81
step
talk Gimrizz Shadowcog##5612
Train Abilities |trainer Gimrizz Shadowcog##5612 |goto Dun Morogh/0 47.33,53.69 |q 2160
|only if Warlock
step
talk Dannie Fizzwizzle##6328
|tip Buy available Grimoires.
Train Demon Abilities |vendor Dannie Fizzwizzle##6328 |goto Dun Morogh 47.28,53.67 |q 2160
|only if Warlock
step
talk Grif Wildheart##1231
Train Abilities |trainer Grif Wildheart##1231 |goto Dun Morogh/0 45.81,53.04 |q 2160
|only if Hunter
step
talk Ragnar Thunderbrew##1267
accept Beer Basted Boar Ribs##384 |goto Dun Morogh 46.83,52.36
step
talk Magis Sparkmantle##1228
|tip Upstairs inside the building.
Train Abilities |trainer Magis Sparkmantle##1228 |goto Dun Morogh/0 47.50,52.08 |q 2160
|only if Mage
step
talk Azar Stronghammer##1232
|tip Upstairs inside the building.
Train Abilities |trainer Azar Stronghammer##1232 |goto Dun Morogh/0 47.60,52.07 |q 2160
|only if Paladin
step
talk Ingrid Dunwald##258113
|tip Upstairs inside the building.
Train Abilities |trainer Ingrid Dunwald##258113 |goto Dun Morogh/0 47.59,51.95 |q 2160
|only if Shaman
step
talk Tannok Frosthammer##6806
|tip Inside the building.
turnin Supplies to Tannok##2160 |goto Dun Morogh 47.22,52.19
step
talk Maxan Anvol##1226
|tip Inside the building.
accept Dawn in the Mountains##99158 |goto Dun Morogh/0 47.34,52.19
step
talk Maxan Anvol##1226
|tip Inside the building.
Train Abilities |trainer Maxan Anvol##1226 |goto Dun Morogh/0 47.34,52.19 |q 5625 |future
|only if Priest
step
talk Maxan Anvol##1226
|tip Inside the building.
accept Accept Garments of the Light##5625 |goto Dun Morogh/0 47.34,52.19
|only if Priest
step
Heal and Fortify Mountaineer Dolf |q 5625/1 |goto Dun Morogh/0 45.81,54.57
|tip Cast {o}Lesser Heal (Rank 2){} on Mountaineer Dolf.
|tip Cast {o}Power Word: Fortitude{} on Mountaineer Dolf.
|only if Priest
step
talk Maxan Anvol##1226
|tip Inside the building.
turnin Accept Garments of the Light##5625 |goto Dun Morogh/0 47.34,52.19
|only if Priest
step
talk Hogral Bakkan##1234
|tip Inside the building.
Train Abilities |trainer Hogral Bakkan##1234 |goto Dun Morogh/0 47.56,52.61 |q 400 |future
|only if Rogue
step
talk Granis Swiftaxe##1229
|tip Inside the building.
Train Abilities |trainer Granis Swiftaxe##1229 |goto Dun Morogh/0 47.36,52.65 |q 400 |future
|only if Warrior
step
talk Gremlock Pilsnor##1699
|tip Inside the building.
Select _"Train me."_ |gossip 96865
Learn Cooking from Gremlock Pilsnor in Kharanos |q 96629/1 |goto Dun Morogh/0 47.67,52.31
step
talk Gremlock Pilsnor##1699
|tip Inside the building.
turnin Camping 101: Cooking##96629 |goto Dun Morogh/0 47.67,52.31
step
talk Tharek Blackstone##1872
accept Tools for Steelgrill##400 |goto Dun Morogh 46.02,51.68
step
talk Tognus Flintfire##1241
|tip Inside the building.
accept Flintfire's Shipment##98321 |goto Dun Morogh/0 45.34,51.94
step
_NOTE:_
Use Weapon Stones
|tip We will train Mining and Blacksmithing.
|tip Allows you to make and use {o}Sharpening Stones{}.		|only if Warrior or Rogue
|tip Allows you to make and use {o}Weightstones{}.		|only if Paladin
|tip Increases damage.
|tip Mine {o}Copper Ore{} as you see it.
|tip Use the {g}Rough Stones{} to make sharpening stones.	|only if Warrior or Rogue
|tip Use the {g}Rough Stones{} to make weightstones.		|only if Paladin
Click Here to Continue |confirm |q 400
|only if Warrior or Rogue or Paladin
step
talk Tognus Flintfire##1241
|tip Walks around.
|tip Inside the building.
Train Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Dun Morogh/0 45.32,51.92
|only if Warrior or Rogue or Paladin
step
talk Thrawn Boltar##1690
|tip Inside the building.
buy Mining Pick##2901 |goto Dun Morogh/0 45.30,51.53
|only if Warrior or Rogue or Paladin
stickystart "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
step
talk Pilot Bellowfiz##1378
accept Stocking Jetsteam##317 |goto Dun Morogh 49.43,48.41
stickystop "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
step
talk Pilot Stonegear##1377
accept The Grizzled Den##313 |goto Dun Morogh 49.62,48.61
step
talk Beldin Steelgrill##1376
turnin Tools for Steelgrill##400 |goto Dun Morogh 50.44,49.09
step
talk Loslor Rudge##1694
accept Ammo for Rumbleshot##5541 |goto Dun Morogh 50.08,49.42
step
talk Yarr Hammerstone##5392
|tip Downstairs inside the building.
Train Apprentice Mining |skillmax Mining,75 |goto Dun Morogh/0 50.01,50.31
|only if Warrior or Rogue or Paladin
stickystart "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
step
talk Father Gavin##1253
turnin Dawn in the Mountains##99158 |goto Dun Morogh/0 57.73,44.88
accept Finding Warmth##99159 |goto Dun Morogh/0 57.73,44.88
step
click Fallen Log+
|tip Grey logs.
collect 14 Mostly Dry Firewood##286339 |q 99159/1 |goto Dun Morogh/0 55.19,47.26
stickystart "Collect_Thick_Bear_Fur"
step
click Ammo Crate
collect Rumbleshot's Ammo##13850 |q 5541/1 |goto Dun Morogh 44.14,56.94
step
talk Mountaineer Gretchen##271546
turnin Secure the Mountain##98322 |goto Dun Morogh/0 44.10,57.07
accept Secure the Mountain##98319 |goto Dun Morogh/0 44.10,57.07
stickystart "Collect_Wendigo_Manes"
stickystart "Collect_Flintfires_Shipments"
step
Enter the cave |goto Dun Morogh/0 42.20,54.13 < 40 |walk |only if not (subzone("The Grizzled Den") and indoors())
Find Mountaineer Cornelius |q 98319/1 |goto Dun Morogh/0 43.03,49.62
|tip Inside the cave.
stickystop "Collect_Thick_Bear_Fur"
stickystop "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
step
label "Collect_Flintfires_Shipments"
click Flintfire's Shipment+
|tip Wooden crates.
|tip Inside the cave.
collect 8 Flintfire's Shipment##280413 |q 98321/1 |goto Dun Morogh/0 42.20,54.13
step
label "Collect_Wendigo_Manes"
kill Young Wendigo##1134, Wendigo##1135
|tip Yetis.
|tip Inside and outside the cave.
collect 8 Wendigo Mane##2671 |q 313/1 |goto Dun Morogh 42.33,54.03
step
Leave the cave |goto Dun Morogh/0 42.20,54.13 < 40 |walk |only if subzone("The Grizzled Den") and indoors()
talk Mountaineer Gretchen##271546
turnin Secure the Mountain##98319 |goto Dun Morogh/0 44.10,57.07
accept Secure the Mountain##98323 |goto Dun Morogh/0 44.10,57.07
step
talk Hegnar Rumbleshot##1243
turnin Ammo for Rumbleshot##5541 |goto Dun Morogh 40.68,65.13
stickystart "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
step
label "Collect_Thick_Bear_Fur"
kill Young Black Bear##1128+
collect 2 Thick Bear Fur##6952 |q 317/2 |goto Dun Morogh 41.40,59.20
|mapmarker Dun Morogh/0 44.95,50.40
step
label "Collect_Chunks_Of_Boar_Meat_And_Crag_Boar_Ribs"
kill Crag Boar##1125, Large Crag Boar##1126
collect 4 Chunk of Boar Meat##769 |goto Dun Morogh 41.40,59.20  |q 317 |future
collect 6 Crag Boar Rib##2886 |goto Dun Morogh 41.40,59.20 |q 384 |future
|tip Don't vendor them.
|mapmarker Dun Morogh/0 46.24,62.51
step
Kill enemies
|tip Skin them.
Raise Your Skinning Skill to 20 |q 96056/1 |goto Dun Morogh 41.40,59.20
|mapmarker Dun Morogh/0 46.24,62.51
|only if haveq(96056) or completedq(96056)
step
talk Senir Whitebeard##1252
turnin Secure the Mountain##98323 |goto Dun Morogh/0 46.77,53.81
accept Frostmane Hold##287 |goto Dun Morogh/0 46.77,53.81
step
talk Innkeeper Belm##1247
|tip Inside the building.
buy Rhapsody Malt##2894 |q 384/2 |goto Dun Morogh 47.38,52.52
step
talk Ragnar Thunderbrew##1267
turnin Beer Basted Boar Ribs##384 |goto Dun Morogh 46.83,52.36
step
talk Tognus Flintfire##1241
|tip Inside the building.
turnin Flintfire's Shipment##98321 |goto Dun Morogh/0 45.34,51.94
step
talk Pilot Bellowfiz##1378
turnin Stocking Jetsteam##317 |goto Dun Morogh 49.43,48.41
accept Evershine##318 |goto Dun Morogh 49.43,48.41
step
talk Pilot Stonegear##1377
turnin The Grizzled Den##313 |goto Dun Morogh 49.62,48.61
step
talk Grif Wildheart##1231
Train Abilities |trainer Grif Wildheart##1231 |goto Dun Morogh/0 45.81,53.04 |q 312 |future
|only if Hunter
step
talk Gimrizz Shadowcog##5612
Train Abilities |trainer Gimrizz Shadowcog##5612 |goto Dun Morogh/0 47.33,53.69 |q 312 |future
|only if Warlock
step
talk Dannie Fizzwizzle##6328
|tip Buy available Grimoires.
Train Demon Abilities |vendor Dannie Fizzwizzle##6328 |goto Dun Morogh 47.28,53.67 |q 312 |future
|only if Warlock
step
talk Magis Sparkmantle##1228
|tip Upstairs inside the building.
Train Abilities |trainer Magis Sparkmantle##1228 |goto Dun Morogh/0 47.50,52.08 |q 312 |future
|only if Mage
step
talk Azar Stronghammer##1232
|tip Upstairs inside the building.
Train Abilities |trainer Azar Stronghammer##1232 |goto Dun Morogh/0 47.60,52.07 |q 312 |future
|only if Paladin
step
talk Ingrid Dunwald##258113
|tip Upstairs inside the building.
Train Abilities |trainer Ingrid Dunwald##258113 |goto Dun Morogh/0 47.59,51.95 |q 312 |future
|only if Shaman
step
talk Maxan Anvol##1226
|tip Inside the building.
Train Abilities |trainer Maxan Anvol##1226 |goto Dun Morogh/0 47.34,52.19 |q 312 |future
|only if Priest
step
talk Hogral Bakkan##1234
|tip Inside the building.
Train Abilities |trainer Hogral Bakkan##1234 |goto Dun Morogh/0 47.56,52.61 |q 312 |future
|only if Rogue
step
talk Granis Swiftaxe##1229
|tip Inside the building.
Train Abilities |trainer Granis Swiftaxe##1229 |goto Dun Morogh/0 47.36,52.65 |q 312 |future
|only if Warrior
step
talk Thamner Pol##2326
|tip Inside the building.
Train First Aid |skillmax First Aid,75 |goto Dun Morogh 47.18,52.61
|tip If possible.
|only if Warrior or Rogue
step
_NOTE:_
Create Bandages in Downtime
|tip While waiting for things like boats.
|tip Increases skill in First Aid.
|tip Need higher skill to make better bandages.
|tip Keep bandages to heal yourself.
Click Here to Continue |confirm |q 312 |future
|only if Warrior or Rogue
step
talk Razzle Sprysprocket##1269
|tip Inside the building.
accept Operation Recombobulation##412 |goto Dun Morogh 45.85,49.37
step
Follow the path |goto Dun Morogh 39.61,48.01 < 40 |only if walking
talk Tundra MacGrann##1266
|tip Avoid the {o}elite yeti{} that walks nearby.
|tip Top of the mountain.
accept Tundra MacGrann's Stolen Stash##312 |goto Dun Morogh 34.57,51.65
step
click MacGrann's Meat Locker
|tip Wait for the {o}elite yeti{} to walk away.
|tip Inside the small cave.
collect MacGrann's Dried Meats##2667 |q 312/1 |goto Dun Morogh 38.51,53.93
|tip {o}HURRY{}.
|tip Yeti runs back quickly.
step
talk Tundra MacGrann##1266
|tip Avoid the {o}elite yeti{} that walks nearby.
|tip Top of the mountain.
turnin Tundra MacGrann's Stolen Stash##312 |goto Dun Morogh 34.57,51.65
step
talk Rejold Barleybrew##1374
turnin Evershine##318 |goto Dun Morogh 30.19,45.73
accept A Favor for Evershine##319 |goto Dun Morogh 30.19,45.73
accept The Perfect Stout##315 |goto Dun Morogh 30.19,45.73
step
talk Marleth Barleybrew##1375
accept Bitter Rivals##310 |goto Dun Morogh 30.19,45.53
step
kill Frostmane Seer##1397+
click Shimmerweed Basket+
|tip Wooden baskets.
|tip Top of the mountain.
collect 6 Shimmerweed##2676 |q 315/1 |goto Dun Morogh/0 41.33,44.27
|mapmarker Dun Morogh/0 41.93,35.25
step
kill 6 Ice Claw Bear##1196 |q 319/1 |goto Dun Morogh/0 32.61,37.37
kill 8 Elder Crag Boar##1127 |q 319/2 |goto Dun Morogh/0 32.61,37.37
kill 8 Snow Leopard##1201 |q 319/3 |goto Dun Morogh/0 32.61,37.37
step
Allow Enemies to Kill You
|tip Anywhere near {o}Brewnall Village{}.
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Dun Morogh/0 32.61,37.37 |q 319
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Dun Morogh 47.05,55.10 |q 319 |zombiewalk
|only if not hardcore()
step
talk Innkeeper Belm##1247
|tip Inside the building.
buy Thunder Ale##2686 |goto Dun Morogh 47.38,52.52 |q 310
step
talk Jarven Thunderbrew##1373
|tip Downstairs inside the building.
accept Distracting Jarven##308 |goto Dun Morogh 47.64,52.66
|only if haveq(310)
step
click Unguarded Thunder Ale Barrel
|tip Takes a moment.
|tip Downstairs inside the building.
turnin Bitter Rivals##310 |goto Dun Morogh 47.70,52.69
accept Return to Marleth##311 |goto Dun Morogh 47.70,52.69
step
talk Father Gavin##1253
turnin Finding Warmth##99159 |goto Dun Morogh/0 57.73,44.88
accept Rime's Wrath##99160 |goto Dun Morogh/0 57.73,44.88
accept Treacherous Cold##99162 |goto Dun Morogh/0 57.73,44.88
step
kill 10 Minor Ice Elemental##276003 |q 99160/1 |goto Dun Morogh/0 55.47,44.41
step
talk Father Gavin##1253
turnin Rime's Wrath##99160 |goto Dun Morogh/0 57.73,44.88
accept Rime's Wrath##99161 |goto Dun Morogh/0 57.73,44.88
step
kill Avala##276009
collect Avala's Core##286325 |q 99161/1 |goto Dun Morogh/0 58.33,42.05
step
talk Father Gavin##1253
turnin Rime's Wrath##99161 |goto Dun Morogh/0 57.73,44.88
step
click Sunhammer's Rifle
collect Sunhammer's Rifle##286359 |q 99162/2 |goto Dun Morogh/0 59.91,50.10
step
click Stoneanvil's Rifle
collect Stoneanvil's Rifle##286360 |q 99162/1 |goto Dun Morogh/0 53.16,58.76
step
talk Innkeeper Belm##1247
|tip Inside the building.
home Thunderbrew Distillery |goto Dun Morogh 47.38,52.52
step
Follow the path |goto Dun Morogh 41.90,47.23 < 40 |only if walking
talk Marleth Barleybrew##1375
turnin Return to Marleth##311 |goto Dun Morogh 30.19,45.53
step
talk Rejold Barleybrew##1374
turnin A Favor for Evershine##319 |goto Dun Morogh 30.19,45.73
accept Return to Bellowfiz##320 |goto Dun Morogh 30.19,45.73
turnin The Perfect Stout##315 |goto Dun Morogh 30.19,45.73
accept Shimmer Stout##413 |goto Dun Morogh/0 30.19,45.73
stickystart "Kill_Frostmane_Headhunters"
step
Enter the cave |goto Dun Morogh 24.84,50.89 < 20 |walk |only if not (subzone("Frostmane Hold") and indoors())
Fully Explore Frostmane Hold |q 287/2 |goto Dun Morogh 21.20,54.00
|tip Inside the cave.
step
label "Kill_Frostmane_Headhunters"
kill 5 Frostmane Headhunter##1123 |q 287/1 |goto Dun Morogh 24.87,50.90
|tip Inside and outside the cave. |notinsticky
|mapmarker Dun Morogh/0 21.40,54.60
|mapmarker Dun Morogh/0 22.40,51.60
|mapmarker Dun Morogh/0 24.00,53.00
|mapmarker Dun Morogh/0 26.00,51.40
step
Leave the cave |goto Dun Morogh 25.07,50.99 < 20 |walk |only if subzone("Frostmane Hold") and indoors()
kill Leper Gnome##1211+
collect 8 Restabilization Cog##3083 |q 412/1 |goto Dun Morogh/0 26.10,39.86
collect 8 Gyromechanic Gear##3084 |q 412/2 |goto Dun Morogh/0 26.10,39.86
step
kill Leper Gnome##1211+
|tip Helps reach level 10 after quest turnins.
ding 9,5900 |goto Dun Morogh/0 26.10,39.86
step
talk Senir Whitebeard##1252
turnin Frostmane Hold##287 |goto Dun Morogh/0 46.77,53.81
accept The Reports##291 |goto Dun Morogh/0 46.77,53.81
step
talk Gimrizz Shadowcog##5612
Train Abilities |trainer Gimrizz Shadowcog##5612 |goto Dun Morogh/0 47.33,53.69 |q 412
|only if Warlock
step
talk Dannie Fizzwizzle##6328
|tip Buy available Grimoires.
Train Demon Abilities |vendor Dannie Fizzwizzle##6328 |goto Dun Morogh 47.28,53.67 |q 412
|only if Warlock
step
talk Magis Sparkmantle##1228
|tip Upstairs inside the building.
Train Abilities |trainer Magis Sparkmantle##1228 |goto Dun Morogh/0 47.50,52.08 |q 412
|only if Mage
step
talk Azar Stronghammer##1232
|tip Upstairs inside the building.
Train Abilities |trainer Azar Stronghammer##1232 |goto Dun Morogh/0 47.60,52.07 |q 412
|only if Paladin
step
talk Ingrid Dunwald##258113
|tip Upstairs inside the building.
Train Abilities |trainer Ingrid Dunwald##258113 |goto Dun Morogh/0 47.59,51.95 |q 412
|only if Shaman
step
talk Ingrid Dunwald##258113
|tip Upstairs inside the building.
accept Call of Fire##94449 |goto Dun Morogh/0 47.59,51.95
|only if Shaman
step
talk Maxan Anvol##1226
|tip Inside the building.
Train Abilities |trainer Maxan Anvol##1226 |goto Dun Morogh/0 47.34,52.19 |q 412
|only if Priest
step
talk Maxan Anvol##1226
|tip Inside the building.
accept Desperate Prayer##5637 |goto Dun Morogh/0 47.34,52.19
|only if Priest
step
talk Hogral Bakkan##1234
|tip Inside the building.
Train Abilities |trainer Hogral Bakkan##1234 |goto Dun Morogh/0 47.56,52.61 |q 412
|only if Rogue
step
talk Granis Swiftaxe##1229
|tip Inside the building.
Train Abilities |trainer Granis Swiftaxe##1229 |goto Dun Morogh/0 47.36,52.65 |q 412
|only if Warrior
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 10 ammo when restocking.
Click Here to Continue |confirm |q 6064 |future
|only if Hunter
step
talk Grif Wildheart##1231
Train Abilities |trainer Grif Wildheart##1231 |goto Dun Morogh/0 45.81,53.04 |q 6064 |future
|only if Hunter
step
talk Grif Wildheart##1231
accept Taming the Beast##6064 |goto Dun Morogh 45.81,53.03
|only if Hunter
step
use Taming Rod##15911
|tip On a Large Crag Boar.
Tame a Large Crag Boar |q 6064/1 |goto Dun Morogh 49.80,53.40
|mapmarker Dun Morogh/0 46.60,63.40
|mapmarker Dun Morogh/0 48.40,47.80
|mapmarker Dun Morogh/0 49.00,58.80
|mapmarker Dun Morogh/0 49.00,61.40
|mapmarker Dun Morogh/0 50.60,47.00
|mapmarker Dun Morogh/0 51.80,50.00
|mapmarker Dun Morogh/0 53.20,47.20
|only if Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6064 |goto Dun Morogh 45.81,53.04
accept Taming the Beast##6084 |goto Dun Morogh 45.81,53.04
|only if Hunter
step
use Taming Rod##15913
|tip On a Snow Leopard.
|tip Dismiss your pet first.
Tame a Snow Leopard |q 6084/1 |goto Dun Morogh 48.20,57.40
|only if Hunter
|mapmarker Dun Morogh/0 46.80,63.60
|mapmarker Dun Morogh/0 48.20,61.00
|mapmarker Dun Morogh/0 50.40,59.40
step
talk Grif Wildheart##1231
turnin Taming the Beast##6084 |goto Dun Morogh 45.81,53.04
accept Taming the Beast##6085 |goto Dun Morogh 45.81,53.04
|only if Hunter
step
use Taming Rod##15908
|tip On an Ice Claw Bear.
|tip Dismiss your pet first.
Tame an Ice Claw Bear |q 6085/1 |goto Dun Morogh 50.20,53.00
|mapmarker Dun Morogh/0 46.00,63.60
|mapmarker Dun Morogh/0 49.80,58.80
|mapmarker Dun Morogh/0 48.80,62.40
|only if Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6085 |goto Dun Morogh 45.81,53.04
accept Training the Beast##6086 |goto Dun Morogh 45.81,53.04
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
turnin Training the Beast##6086 |goto Ironforge 70.87,85.80
|only if Hunter
step
_NOTE:_
Train Your Pet
|tip Learn pet abilities from Pet Trainers.
|tip Cast {o}Beast Training{} to teach your pet.
Click Here to Continue |confirm |q 99162
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
Train Pet Abilities |trainer Belia Thundergranite##10090 |goto Ironforge/0 70.86,85.85 |q 99162
|only if Hunter
step
_NOTE:_
Tame an Ice Claw Bear
|tip Cast {o}Tame Beast{} on an Ice Claw Bear.
|tip Work your way east, if needed.
|tip Dismiss your pet first.
Click Here to Continue |confirm |goto Dun Morogh 51.80,44.40 |q 99162
|mapmarker Dun Morogh/0 55.40,43.60
|mapmarker Dun Morogh/0 59.40,52.00
|mapmarker Dun Morogh/0 61.00,56.40
|mapmarker Dun Morogh/0 64.80,60.00
|mapmarker Dun Morogh/0 66.40,50.80
|only if Hunter
step
talk Razzle Sprysprocket##1269
|tip Inside the building.
turnin Operation Recombobulation##412 |goto Dun Morogh 45.85,49.37
step
talk Pilot Bellowfiz##1378
turnin Return to Bellowfiz##320 |goto Dun Morogh 49.43,48.41
step
talk Beldin Steelgrill##1376
accept A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 50.44,49.09
step
click Coalbeard's Rifle
collect Coalbeard's Rifle##286358 |q 99162/3 |goto Dun Morogh/0 52.11,44.04
step
talk Father Gavin##1253
turnin Treacherous Cold##99162 |goto Dun Morogh/0 57.73,44.88
step
talk Rudra Amberstill##1265
|tip Follow the road.
accept Never Saddle on Quality##95212 |goto Dun Morogh/0 63.08,49.85
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 64.88,58.46
accept Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
Select _"Earthseer, please share your farsight with me."_ |gossip 139831
Use Farsen's Farsight |q 96392/1 |goto Dun Morogh/0 64.88,58.46
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
accept Nip 'Em in the Bud##96390 |goto Dun Morogh/0 64.88,58.46
step
talk Senator Mehr Stonehallow##1977
accept The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Foreman Stonebrow##1254
accept Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
step
kill 6 Rockjaw Skullthumper##1115 |q 432/1 |goto Dun Morogh/0 69.17,58.42
|tip More inside the cave nearby.
step
Leave the cave |goto Dun Morogh 70.70,56.49 < 20 |walk |only if subzone("Gol'Bolar Quarry Mine")
talk Foreman Stonebrow##1254
turnin Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
stickystart "Kill_Dark_Iron_Spies"
stickystart "Collect_Pristine_Leopard_Pelts"
stickystart "Kill_Rockjaw_Bonesnappers"
step
kill Dark Iron Spy##6123+
collect Dark Iron Map##274268 |n
use Dark Iron Map##274268
accept Underground Map##96391 |goto Dun Morogh/0 77.46,60.87
step
label "Kill_Dark_Iron_Spies"
kill 10 Dark Iron Spy##6123 |q 96390/1 |goto Dun Morogh/0 77.46,60.87
step
label "Collect_Pristine_Leopard_Pelts"
kill Elder Snow Leopard##260157+
collect 6 Pristine Leopard Pelt##267414 |q 95212/1 |goto Dun Morogh/0 75.24,56.91
step
label "Kill_Rockjaw_Bonesnappers"
kill 10 Rockjaw Bonesnapper##1117 |q 433/1 |goto Dun Morogh/0 75.24,56.91
step
talk Senator Mehr Stonehallow##1977
turnin The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Nip 'Em in the Bud##96390 |goto Dun Morogh/0 64.88,58.46
turnin Underground Map##96391 |goto Dun Morogh/0 64.88,58.46
step
talk Rudra Amberstill##1265
turnin Never Saddle on Quality##95212 |goto Dun Morogh/0 63.08,49.85
step
talk Pilot Hammerfoot##1960
|tip Follow the road through the tunnel.
accept The Lost Pilot##419 |goto Dun Morogh 83.89,39.19
step
click A Dwarven Corpse
turnin The Lost Pilot##419 |goto Dun Morogh 79.67,36.17
accept A Pilot's Revenge##417 |goto Dun Morogh 79.67,36.17
step
kill Mangeclaw##1961
|tip White bear.
|tip Walks around.
collect Mangy Claw##3183 |q 417/1 |goto Dun Morogh/0 78.97,37.02
step
talk Pilot Hammerfoot##1960
turnin A Pilot's Revenge##417 |goto Dun Morogh/0 83.89,39.19
step
talk Mountaineer Barleybrew##1959
|tip Follow the road through the tunnels.
turnin Shimmer Stout##413 |goto Dun Morogh/0 86.28,48.81
accept Stout to Kadrell##414 |goto Dun Morogh/0 86.28,48.81
step
Follow the path up |goto Dun Morogh/0 86.90,46.97 < 20 |only if walking
talk Bruegs Kindleborn##257597
|tip Inside the small cave.
|tip Top of the mountain.
turnin Call of Fire##94449 |goto Dun Morogh/0 87.56,43.65
accept Call of Fire##94465 |goto Dun Morogh/0 87.56,43.65
|only if Shaman
step
talk Mountaineer Cobbleflint##1089
accept In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.12
step
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
accept The Trogg Threat##267 |goto Loch Modan 23.23,73.67
stickystart "Kill_Stonesplinter_Troggs_And_Scouts"
stickystart "Collect_Linen_Cloth_Paladin"
step
Follow the road to the path here |goto Loch Modan 29.32,66.73 < 40 |only if walking and not subzone("Stonesplinter Valley")
kill Stonesplinter Trogg##1161, Stonesplinter Scout##1162
collect 8 Trogg Stone Tooth##2536 |q 267/1 |goto Loch Modan/0 32.79,74.99
|mapmarker Loch Modan/0 27.49,52.97
step
label "Kill_Stonesplinter_Troggs_And_Scouts"
kill 10 Stonesplinter Trogg##1161 |q 224/1 |goto Loch Modan/0 32.79,74.99
kill 10 Stonesplinter Scout##1162 |q 224/2 |goto Loch Modan/0 32.79,74.99
|mapmarker Loch Modan/0 27.49,52.97
step
label "Collect_Linen_Cloth_Paladin"
kill Stonesplinter Trogg##1161, Stonesplinter Scout##1162
collect 10 Linen Cloth##2589 |goto Loch Modan/0 32.79,74.99 |q 1648 |future
|tip Needed for class quest soon.
|tip Don't vendor them.
|mapmarker Loch Modan/0 27.49,52.97
|only if Paladin
step
Leave Stonesplinter Valley and follow the road |goto Loch Modan 30.57,69.69 < 30 |only if walking and subzone("Stonesplinter Valley")
talk Mountaineer Cobbleflint##1089
turnin In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.13
step
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
turnin The Trogg Threat##267 |goto Loch Modan 23.23,73.67
step
Follow the path up |goto Loch Modan/0 32.10,58.53 < 20 |only if walking
talk Braldir Ashmantle##257808
|tip Top of the mountain.
turnin Call of Fire##94465 |goto Loch Modan/0 32.16,65.99
accept Call of Fire##94466 |goto Loch Modan/0 32.16,65.99
|only if Shaman
step
talk Thorgrum Borrelson##1572
fpath Thelsamar |goto Loch Modan/0 33.94,50.95
step
map Loch Modan
path	follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	32.67,49.72	33.27,49.16	33.86,48.37	34.30,47.64	34.91,47.05
path	35.56,46.76	36.09,46.37	37.11,46.01	37.32,45.60	37.37,44.45
path	37.29,43.33	36.73,41.98
talk Mountaineer Kadrell##1340
|tip Walks a large path.
turnin Stout to Kadrell##414
accept Rat Catching##416
accept Mountaineer Stormpike's Task##1339
step
talk Brock Stoneseeker##1681
|tip Walks around.
|tip Inside and outside the building.
accept Honor Students##6387 |goto Loch Modan 37.02,47.81
step
talk Thorgrum Borrelson##1572
turnin Honor Students##6387 |goto Loch Modan 33.94,50.95
accept Ride to Ironforge##6391 |goto Loch Modan 33.94,50.95
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 291
|only if Warrior
step
talk Buliwyf Stonehand##11865
|tip Inside the building.
Train Two-Handed Axes	|complete weaponskill("TH_AXE") > 0	|goto Ironforge 61.17,89.52	|only if Gnome
Train Two-Handed Maces	|complete weaponskill("TH_MACE") > 0	|goto Ironforge 61.17,89.52
|only if Warrior
step
talk Bixi Wobblebonk##13084
|tip Inside the building.
Train Thrown |complete weaponskill("THROWN") > 0 |goto Ironforge 62.23,89.62
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 291
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
Train Pet Abilities |trainer Belia Thundergranite##10090 |goto Ironforge/0 70.86,85.84 |q 291
|only if Hunter
step
Follow the path |goto Ironforge 44.56,49.58 < 15 |walk |only if not subzone("The High Seat")
talk Senator Barin Redstone##1274
turnin The Reports##291 |goto Ironforge 39.55,57.49
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 6391
|only if Mage
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 6391
|only if Priest
step
talk Brandur Ironhammer##5149
|tip Inside the building.
accept Tome of Divinity##2999 |goto Ironforge 23.12,6.14
|only if Paladin
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 2999
|only if Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin Tome of Divinity##2999 |goto Ironforge 27.64,12.19
accept The Tome of Divinity##1645 |goto Ironforge 27.64,12.19 |instant
|only if Paladin
step
use Tome of Divinity##6916
accept The Tome of Divinity##1646
|only if Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1646 |goto Ironforge 27.64,12.19
accept The Tome of Divinity##1647 |goto Ironforge 27.64,12.19
|only if Paladin
step
map Ironforge
path	follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	21.75,51.75	21.97,54.66	22.70,58.39	23.32,61.81	23.72,63.80
path	25.81,67.98	27.55,71.41	31.72,78.27	36.24,81.32	39.82,83.22
path	42.92,84.10
talk John Turner##6175
|tip Walks in a large path.
turnin The Tome of Divinity##1647
accept The Tome of Divinity##1648
|only if Paladin
step
map Ironforge
path	follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	21.75,51.75	21.97,54.66	22.70,58.39	23.32,61.81	23.72,63.80
path	25.81,67.98	27.55,71.41	31.72,78.27	36.24,81.32	39.82,83.22
path	42.92,84.10
talk John Turner##6175
|tip Walks in a large path.
|tip Should have {o}10 Linen Cloth{} from earlier.
turnin The Tome of Divinity##1648
accept The Tome of Divinity##1778
|only if Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1778 |goto Ironforge 27.64,12.19
accept The Tome of Divinity##1779 |goto Ironforge 27.64,12.19
|only if Paladin
step
talk Muiredon Battleforge##6178
|tip Upstairs inside the building.
turnin The Tome of Divinity##1779 |goto Ironforge 23.53,8.29
accept The Tome of Divinity##1783 |goto Ironforge 23.53,8.29
|only if Paladin
step
talk Balthus Stoneflayer##6291
|tip Downstairs inside the building.
turnin Camping 101: Skinning##96056 |goto Ironforge/0 39.88,32.49
|only if haveq(96056) or completedq(96056)
step
talk Golnir Bouldertoe##4256
|tip Downstairs inside the building.
turnin Ride to Ironforge##6391 |goto Ironforge 51.52,26.30
accept Gryth Thurden##6388 |goto Ironforge 51.52,26.30
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 6388
|only if Warlock
step
talk Lago Blackwrench##6120
accept The Slaughtered Lamb##1715 |goto Ironforge 47.63,9.26
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 6388
|only if Warlock
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 6388
|only if Rogue
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 6388
|only if Shaman
step
talk Gryth Thurden##1573
turnin Gryth Thurden##6388 |goto Ironforge 55.51,47.74
accept Return to Brock##6392 |goto Ironforge 55.51,47.74
step
talk Brock Stoneseeker##1681
|tip Walks around.
|tip Inside and outside the building.
turnin Return to Brock##6392 |goto Loch Modan 37.02,47.81
step
kill Tunnel Rat Scout##1173, Tunnel Rat Vermin##1172, Tunnel Rat Forager##1176
|tip Rat people.
collect 12 Tunnel Rat Ear##3110 |q 416/1 |goto Loch Modan/0 26.99,43.26
|mapmarker Loch Modan/0 24.77,30.34
|mapmarker Loch Modan/0 37.47,17.07
step
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Mountaineer Stormpike's Task##1339 |goto Loch Modan 24.76,18.40
accept Stormpike's Order##1338 |goto Loch Modan 24.76,18.40
accept Filthy Paws##307 |goto Loch Modan/0 24.76,18.40
step
map Loch Modan
path	follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	32.67,49.72	33.27,49.16	33.86,48.37	34.30,47.64	34.91,47.05
path	35.56,46.76	36.09,46.37	37.11,46.01	37.32,45.60	37.37,44.45
path	37.29,43.33	36.73,41.98
talk Mountaineer Kadrell##1340
|tip Walks a large path.
turnin Rat Catching##416
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Ironforge 76.58,51.14 |q 1338
|tip Walk into the portal.
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
accept Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
use Rat Catcher's Flute##17117
|tip On Deeprun Rats.
|tip Small grey rats.
|tip Ironforge section of the Deeprun Tram.
Capture #5# Rats |q 6661/1
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
turnin Deeprun Rat Roundup##6661
accept Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the tram to Stormwind City.
talk Nipsy##13018
|tip Middle platform, near the wall.
|tip Stormwind City section of the Deeprun Tram.
turnin Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Enter Stormwind City |complete zone("Stormwind City") |q 1338
|tip Walk into the portal.
step
talk Grimand Elmore##1416
|tip Inside the building.
accept Stormpike's Delivery##353 |goto Stormwind City 59.71,33.75
step
talk Furen Longbeard##5413
turnin Stormpike's Order##1338 |goto Stormwind City/0 64.60,37.22
step
talk Ilsa Corbin##5480
|tip Upstairs inside the building.
accept A Warrior's Training##1638 |goto Stormwind City 80.36,59.79
|only if Warrior
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin A Warrior's Training##1638 |goto Stormwind City 77.08,53.25
accept Bartleby the Drunk##1639 |goto Stormwind City 77.08,53.25
|only if Warrior
step
talk Bartleby##6090
|tip Walks around.
|tip Inside the building.
turnin Bartleby the Drunk##1639 |goto Stormwind City 76.76,53.18
accept Beat Bartleby##1640 |goto Stormwind City 76.76,53.18
|tip You will be attacked.
|only if Warrior
step
kill Bartleby##6090
|tip Walks around.
|tip Inside the building.
Beat Bartleby |q 1640/1 |goto Stormwind City 76.76,53.18
|only if Warrior
step
talk Bartleby##6090
|tip Walks around.
|tip Inside the building.
turnin Beat Bartleby##1640 |goto Stormwind City 76.76,53.18
accept Bartleby's Mug##1665 |goto Stormwind City 76.76,53.18
|only if Warrior
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin Bartleby's Mug##1665 |goto Stormwind City 77.08,53.25
|only if Warrior
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk High Priestess Laurena##376
|tip Inside the building.
turnin Desperate Prayer##5637 |goto Stormwind City/0 49.52,44.58
|only if Priest
step
Enter the building |goto Stormwind City/0 42.25,81.81 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin The Slaughtered Lamb##1715 |goto Stormwind City 39.23,85.22
accept Surena Caledon##1688 |goto Stormwind City 39.23,85.22
|only if Warlock
step
talk Woo Ping##11867
|tip Inside the building.
Train Two-Handed Swords		|complete weaponskill("TH_SWORD") > 0	|goto Stormwind City 63.85,69.08	|only if Warrior or Paladin
Train Staves			|complete weaponskill("TH_STAFF") > 0	|goto Stormwind City 63.85,69.08	|only if Warrior or Warlock or Priest
Train One-Handed Swords		|complete weaponskill("SWORD") > 0	|goto Stormwind City 63.85,69.08	|only if Warlock or Rogue or Mage
Train Daggers			|complete weaponskill("DAGGER") > 0	|goto Stormwind City 63.85,69.08	|only if Mage
|only if Warrior or Paladin or Warlock or Priest or Rogue or Mage
step
Run up the ramp |goto Stormwind City 67.92,72.64 < 10 |only if walking
talk Dungar Longdrink##352
|tip Inside the building.
fpath Stormwind |goto Stormwind City 70.91,72.51
step
talk Remy "Two Times"##241
accept A Fishy Peril##40 |goto Elwynn Forest/0 42.14,67.26
step
talk Marshal Dughan##240
turnin A Fishy Peril##40 |goto Elwynn Forest/0 42.11,65.93
accept Further Concerns##35 |goto Elwynn Forest/0 42.11,65.93
step
talk Guard Thomas##261
turnin Further Concerns##35 |goto Elwynn Forest 73.97,72.18
accept Find the Lost Guards##37 |goto Elwynn Forest 73.97,72.18
step
talk Ormin Pelford##248265
accept Downstream##91733 |goto Elwynn Forest/0 76.53,71.91
step
talk Sara Timberlain##278
accept Red Linen Goods##83 |goto Elwynn Forest 79.46,68.78
step
talk Supervisor Raelen##10616
accept A Bundle of Trouble##5545 |goto Elwynn Forest 81.38,66.11
stickystart "Collect_Bundles_Of_Wood"
step
click A Half-Eaten Body
turnin Find the Lost Guards##37 |goto Elwynn Forest 72.65,60.33
accept Discover Rolf's Fate##45 |goto Elwynn Forest 72.65,60.33
step
click Rolf's Corpse
turnin Discover Rolf's Fate##45 |goto Elwynn Forest 79.80,55.52
accept Report to Thomas##71 |goto Elwynn Forest 79.80,55.52
step
label "Collect_Bundles_Of_Wood"
click Bundle of Wood+
|tip Small piles of brown logs.
|tip Near the base of trees.
collect 8 Bundle of Wood##13872 |q 5545/1 |goto Elwynn Forest/0 80.54,60.44
step
talk Supervisor Raelen##10616
turnin A Bundle of Trouble##5545 |goto Elwynn Forest 81.38,66.11
step
talk Guard Thomas##261
turnin Report to Thomas##71 |goto Elwynn Forest 73.97,72.18
accept Deliver Thomas' Report##39 |goto Elwynn Forest 73.97,72.18
accept Report to Gryan Stoutmantle##109 |goto Elwynn Forest 73.97,72.18
stickystart "Collect_Red_Linen_Bandanas"
step
kill Surena Caledon##881
|tip Inside the building.
collect Surena's Choker##6810 |q 1688/1 |goto Elwynn Forest 71.02,80.78
|only if Warlock
step
label "Collect_Red_Linen_Bandanas"
kill Defias Bandit##116, Defias Rogue Wizard##474
collect 6 Red Linen Bandana##1019 |q 83/1 |goto Elwynn Forest/0 69.49,79.29
step
use Westfall Deed##1972
accept Furlbrow's Deed##184
|only if itemcount(1972) > 0
step
click Waterlogged Toolbox
|tip Underwater.
collect Waterlogged Toolbox##247818 |q 91733/3 |goto Elwynn Forest/0 77.26,86.80
step
click Waterlogged Axe
collect Waterlogged Axe##247817 |q 91733/1 |goto Elwynn Forest/0 76.74,82.46
step
click Waterlogged Saw
collect Waterlogged Saw##247813 |q 91733/2 |goto Elwynn Forest/0 74.27,76.41
step
talk Ormin Pelford##248265
turnin Downstream##91733 |goto Elwynn Forest/0 76.53,71.91
step
talk Sara Timberlain##278
turnin Red Linen Goods##83 |goto Elwynn Forest 79.46,68.78
step
talk Guard Parker##464
accept Encroaching Gnolls##244 |goto Redridge Mountains/0 10.37,71.26
step
talk Deputy Feldon##1070
|tip Walks around.
turnin Encroaching Gnolls##244 |goto Redridge Mountains/0 25.65,60.00
step
talk Ariena Stormfeather##931
fpath Lakeshire |goto Redridge Mountains 25.50,59.41
step
Enter the building |goto Stormwind City/0 42.21,81.84 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Surena Caledon##1688 |goto Stormwind City/0 39.22,85.25
accept The Binding##1689 |goto Stormwind City/0 39.22,85.25
|only if Warlock
step
use Bloodstone Choker##6928
|tip Stand on the pink symbol.
|tip Inside the crypt.
|tip Downstairs inside the building.
kill Summoned Voidwalker##5676 |q 1689/1 |goto Stormwind City/0 36.79,89.56
|only if Warlock
step
talk Gakin the Darkbinder##6122
|tip Above the crypt.
|tip Downstairs inside the building.
turnin The Binding##1689 |goto Stormwind City/0 39.22,85.25
|only if Warlock
step
talk Innkeeper Allison##6740
|tip Inside the building.
home Stormwind City |goto Stormwind City/0 60.39,75.27
step
talk Marshal Dughan##240
turnin Deliver Thomas' Report##39 |goto Elwynn Forest/0 42.11,65.93
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Night Elf Starter (1-13)",{
image=ZGV.IMAGESDIR.."Teldrassil",
condition_suggested=function() return raceclass('NightElf') and level <= 13 end,
condition_suggested_exclusive=true,
condition_visible=function() return NightElf end,
hardcore = true,
linked = {"Leveling Guides\\Hidden Guides"},
linkedhidden = true,
next="Leveling Guides\\Westfall (13-15)",
},[[
defaultfor NightElf
step
_NOTE:_
Wrong Character Race
|tip Guide written for {o}Night Elf{} characters.
|tip Other races may encounter issues.
Click Here to Continue |confirm
|only if not NightElf
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948 |q 456 |future
|only if not hardcore()
step
_NOTE:_
Manage Your Ammo
|tip Make sure you always have ammo.
|tip You need it to attack enemies.
|tip {o}General Goods{} vendors sell it (also Bow & Gun vendors).
|tip Try to keep your ammo bag full.
Click Here to Continue |confirm |q 456 |future
|only if Hunter
step
Kill enemies
|tip Loot items worth at least {o}10 copper{} to sell.
|tip Allows training an ability early.
Click Here to Continue |confirm |goto Teldrassil/0 58.20,45.40 |q 456 |future
|mapmarker Teldrassil/0 56.40,44.40
|mapmarker Teldrassil/0 60.40,44.20
|mapmarker Teldrassil/0 61.20,41.40
|mapmarker Teldrassil/0 63.00,42.60
|mapmarker Teldrassil/0 64.20,40.80
|only if Warrior
step
talk Dellylah##6091
|tip {o}Ground floor{} inside the building.
Sell Items |vendor Dellylah##6091 |goto Teldrassil/0 59.60,40.69 |q 456 |future
|only if Warrior
step
talk Alyissia##3593
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Alyissia##3593 |goto Teldrassil/0 59.64,38.44 |q 456 |future
|only if Warrior
step
talk Conservator Ilthalaine##2079
accept The Balance of Nature##456 |goto Teldrassil 58.69,44.27
step
kill 4 Young Thistle Boar##1984 |q 456/2 |goto Teldrassil/0 60.40,44.20
kill 7 Young Nightsaber##2031 |q 456/1 |goto Teldrassil/0 60.40,44.20
step
talk Dirania Silvershine##8583
accept A Good Friend##4495 |goto Teldrassil 60.90,41.96
step
talk Melithar Staghelm##2077
accept The Woodland Protector##458 |goto Teldrassil 59.93,42.48
step
talk Conservator Ilthalaine##2079
turnin The Balance of Nature##456 |goto Teldrassil 58.70,44.27
accept The Balance of Nature##457 |goto Teldrassil 58.70,44.27
accept Simple Sigil##3116 |goto Teldrassil 58.70,44.27		|only if NightElf Warrior
accept Encrypted Sigil##3118 |goto Teldrassil 58.70,44.27	|only if NightElf Rogue
accept Hallowed Sigil##3119 |goto Teldrassil 58.70,44.27	|only if NightElf Priest
accept Etched Sigil##3117 |goto Teldrassil 58.70,44.27		|only if NightElf Hunter
accept Verdant Sigil##3120 |goto Teldrassil 58.70,44.27		|only if NightElf Druid
step
talk Shanda##3595
|tip Upstairs inside the building.
accept The Goddess Provides##97979 |goto Teldrassil/0 59.17,40.44
step
Cast Elune's Light |q 97979/1 |goto Teldrassil/0 59.17,40.44
Cast Shadowmeld |q 97979/2 |goto Teldrassil/0 59.17,40.44
step
talk Shanda##3595
|tip Upstairs inside the building.
turnin The Goddess Provides##97979 |goto Teldrassil/0 59.17,40.44
step
talk Alyissia##3593
|tip {o}Ground floor{} inside the building.
turnin Simple Sigil##3116 |goto Teldrassil 59.64,38.44
|only if Warrior
step
talk Alyissia##3593
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Alyissia##3593 |goto Teldrassil/0 59.64,38.44 |q 458
|only if Warrior
step
talk Frahun Shadewhisper##3594
|tip {o}Ground floor{} inside the building.
turnin Encrypted Sigil##3118 |goto Teldrassil 59.64,38.66
accept Second-Story Work##77573 |goto Teldrassil 59.64,38.66
|only if Rogue
step
talk Frahun Shadewhisper##3594
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Frahun Shadewhisper##3594 |goto Teldrassil 59.64,38.66 |q 458
|only if Rogue
step
talk Shanda##3595
|tip Upstairs inside the building.
turnin Hallowed Sigil##3119 |goto Teldrassil 59.17,40.44
|only if Priest
step
talk Shanda##3595
|tip Upstairs inside the building.
Train Abilities |trainer Shanda##3595 |goto Teldrassil 59.17,40.44 |q 458
|only if Priest
step
Run up the large ramp |goto Teldrassil 57.53,41.63 < 15 |only if walking
talk Ayanna Everstride##3596
|tip Up in the tall tree.
|tip In a side room.
turnin Etched Sigil##3117 |goto Teldrassil 58.65,40.45
|only if Hunter
step
talk Ayanna Everstride##3596
|tip Up in the tall tree.
|tip In a side room.
Train Abilities |trainer Ayanna Everstride##3596 |goto Teldrassil 58.65,40.45 |q 458
|only if Hunter
step
Run up the large ramp |goto Teldrassil 57.53,41.63 < 15 |only if walking
talk Mardant Strongoak##3597
|tip Up in the tall tree.
|tip In a side room.
turnin Verdant Sigil##3120 |goto Teldrassil 58.63,40.29
|only if Druid
step
talk Mardant Strongoak##3597
|tip Up in the tall tree.
|tip In a side room.
Train Abilities |trainer Mardant Strongoak##3597 |goto Teldrassil 58.63,40.29 |q 458
|only if Druid
step
talk Tarindrella##1992
|tip Walks around.
turnin The Woodland Protector##458 |goto Teldrassil 57.83,45.20
accept The Woodland Protector##459 |goto Teldrassil 57.83,45.20
accept Nature's Call##97977 |goto Teldrassil/0 57.83,45.20
|delay 0.2
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
talk Lyrai##3587
|tip Upstairs inside the building.
buy Skinning Knife##7005 |goto Teldrassil/0 59.52,40.91 |q 97977
buy Apprentice's Skinning Satchel##277114 |goto Teldrassil/0 59.52,40.91 |q 97977
|only if skillmax("Skinning") > 1
step
talk Lyrai##3587
|tip Upstairs inside the building.
buy Apprentice's Herb Pouch##277113 |goto Teldrassil/0 59.52,40.91 |q 97977
|only if skillmax("Herbalism") > 1
step
talk Lyrai##3587
|tip Upstairs inside the building.
buy Mining Pick##2901 |goto Teldrassil/0 59.52,40.91 |q 97977
buy Apprentice's Mining Pack##277115 |goto Teldrassil/0 59.52,40.91 |q 97977
|only if skillmax("Mining") > 1
stickystart "Collect_Fel_Moss"
step
click Gnarlpine Totem+
|tip Short upright logs.
collect Gnarlpine Totem##279082 |q 97977/1 |goto Teldrassil/0 55.52,44.07
|mapmarker Teldrassil/0 55.06,39.40
step
label "Collect_Fel_Moss"
kill Grell##1988, Grellkin##1989
|tip Imps.
collect 8 Fel Moss##3297 |q 459/1 |goto Teldrassil/0 55.52,44.07
|mapmarker Teldrassil/0 55.06,39.40
step
Kill enemies
|tip Quest requires level 3 soon.
ding 3 |goto Teldrassil/0 55.52,44.07
|mapmarker Teldrassil/0 55.06,39.40
step
talk Gilshalan Windwalker##2082
accept Webwood Venom##916 |goto Teldrassil 57.81,41.65
step
kill 7 Mangy Nightsaber##2032 |q 457/1 |goto Teldrassil/0 60.76,35.55
kill 7 Thistle Boar##1985 |q 457/2 |goto Teldrassil/0 60.76,35.55
stickystart "Collect_Webwood_Venom_Sacs"
step
talk Iverron##8584
turnin A Good Friend##4495 |goto Teldrassil 54.60,32.99
accept A Friend in Need##3519 |goto Teldrassil 54.60,32.99
step
label "Collect_Webwood_Venom_Sacs"
kill Webwood Spider##1986+
|tip Inside and outside the cave. |notinsticky
collect 10 Webwood Venom Sac##5166 |q 916/1 |goto Teldrassil 56.80,31.59
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Inside and outside the cave.
Die on Purpose |complete isdead |goto Teldrassil 56.80,31.59 |q 916
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Teldrassil/0 58.70,42.42 |q 916 |zombiewalk
|only if not hardcore()
step
Leave the cave |goto Teldrassil/0 56.78,31.44 < 20 |walk |only if (subzone("Shadowthread Cave") and indoors()) and hardcore()
talk Gilshalan Windwalker##2082
turnin Webwood Venom##916 |goto Teldrassil 57.81,41.65
accept Webwood Egg##917 |goto Teldrassil 57.81,41.65
step
talk Conservator Ilthalaine##2079
turnin The Balance of Nature##457 |goto Teldrassil 58.70,44.26
step
talk Tarindrella##1992
|tip Walks around.
turnin The Woodland Protector##459 |goto Teldrassil 57.83,45.20
turnin Nature's Call##97977 |goto Teldrassil/0 57.83,45.20
step
talk Alyissia##3593
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Alyissia##3593 |goto Teldrassil/0 59.64,38.44 |q 3519
|only if Warrior
step
talk Frahun Shadewhisper##3594
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Frahun Shadewhisper##3594 |goto Teldrassil 59.64,38.66 |q 3519
|only if Rogue
step
talk Shanda##3595
|tip Upstairs inside the building.
Train Abilities |trainer Shanda##3595 |goto Teldrassil 59.17,40.44 |q 3519
|only if Priest
step
Run up the large ramp |goto Teldrassil 57.53,41.63 < 15 |only if walking
talk Ayanna Everstride##3596
|tip Up in the tall tree.
|tip In a side room.
Train Abilities |trainer Ayanna Everstride##3596 |goto Teldrassil 58.65,40.45 |q 3519
|only if Hunter
step
Run up the large ramp |goto Teldrassil 57.53,41.63 < 15 |only if walking
talk Mardant Strongoak##3597
|tip Up in the tall tree.
|tip In a side room.
Train Abilities |trainer Mardant Strongoak##3597 |goto Teldrassil 58.63,40.29 |q 3519
|only if Druid
step
talk Dirania Silvershine##8583
turnin A Friend in Need##3519 |goto Teldrassil 60.90,41.96
accept Iverron's Antidote##3521 |goto Teldrassil 60.90,41.96
step
click Hyacinth Mushroom+
|tip Clusters of pink mushrooms.
|tip Usually near trees.
collect 7 Hyacinth Mushroom##10639 |q 3521/1 |goto Teldrassil/0 57.01,41.71
step
click Moonpetal Lily+
|tip Large orange flowers.
collect 4 Moonpetal Lily##10641 |q 3521/2 |goto Teldrassil/0 57.69,37.49
stickystart "Collect_Webwood_Ichor"
step
Enter the cave |goto Teldrassil 56.79,31.41 < 20 |walk |only if not (subzone("Shadowthread Cave") and indoors())
Follow the path down |goto Teldrassil 56.83,28.94 < 10 |walk
Follow the path up |goto Teldrassil 55.75,25.49 < 10 |walk
kill Githyiss the Vile##1994
|tip Upstairs inside the cave.
collect Fang of Githyiss##277190 |n
use Fang of Githyiss##277190
accept Fang of Githyiss##97236 |goto Teldrassil/0 56.73,26.33
step
click Webwood Eggs
|tip Upstairs inside the cave.
collect Webwood Egg##5167 |q 917/1 |goto Teldrassil 56.80,26.43
step
label "Collect_Webwood_Ichor"
kill Webwood Spider##1986+
|tip Inside and outside the cave. |notinsticky
collect Webwood Ichor##10640 |q 3521/3 |goto Teldrassil 56.80,31.59
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Inside and outside the cave.
Die on Purpose |complete isdead |goto Teldrassil 56.80,31.59 |q 3521
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Teldrassil/0 58.69,42.42 |q 3521 |zombiewalk
|only if not hardcore()
step
Leave the cave |goto Teldrassil/0 56.78,31.44 < 20 |walk |only if (subzone("Shadowthread Cave") and indoors()) and hardcore()
talk Gilshalan Windwalker##2082
turnin Fang of Githyiss##97236 |goto Teldrassil/0 57.81,41.65
turnin Webwood Egg##917 |goto Teldrassil 57.81,41.65
accept Tenaron's Summons##920 |goto Teldrassil 57.81,41.65
step
Run up the large ramp |goto Teldrassil 57.54,41.62 < 15 |only if walking
talk Tenaron Stormgrip##3514
|tip Top of the tall tree.
|tip In a side room.
turnin Tenaron's Summons##920 |goto Teldrassil 59.07,39.45
accept Crown of the Earth##921 |goto Teldrassil 59.07,39.45
step
talk Dirania Silvershine##8583
turnin Iverron's Antidote##3521 |goto Teldrassil 60.90,41.96
accept Iverron's Antidote##3522 |goto Teldrassil 60.90,41.96
step
_NOTE:_
HURRY
|tip Timed quest.
Click Here to Continue |confirm |q 3522
step
use Crystal Phial##5185
collect Filled Crystal Phial##5184 |q 921/1 |goto Teldrassil 59.94,33.04
step
talk Iverron##8584
turnin Iverron's Antidote##3522 |goto Teldrassil 54.59,32.99
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Inside and outside the cave.
Die on Purpose |complete isdead |goto Teldrassil 56.80,31.59 |q 921
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Teldrassil/0 58.69,42.42 |q 921 |zombiewalk
|only if not hardcore()
step
Leave the cave |goto Teldrassil/0 56.78,31.44 < 20 |walk |only if (subzone("Shadowthread Cave") and indoors()) and hardcore()
talk Shanda##3595
|tip Upstairs inside the building.
accept In Favor of Elune##5622 |goto Teldrassil 59.17,40.44
|only if Priest
step
Leave the cave |goto Teldrassil/0 56.78,31.44 < 20 |walk |only if (subzone("Shadowthread Cave") and indoors()) and hardcore()
Run up the large ramp |goto Teldrassil 57.54,41.62 < 15 |only if walking
talk Tenaron Stormgrip##3514
|tip Top of the tall tree.
|tip In a side room.
turnin Crown of the Earth##921 |goto Teldrassil 59.07,39.45
accept Crown of the Earth##928 |goto Teldrassil 59.07,39.45
step
click Lost Journal
|tip Top of the tall tree.
|tip In a side room.
accept The Adventurer##96630 |goto Teldrassil/0 59.08,39.53
step
talk Porthannius##6780
accept Dolanaar Delivery##2159 |goto Teldrassil 61.16,47.64
step
talk Zenn Foulhoof##2150
|tip Walks around.
accept Zenn's Bidding##488 |goto Teldrassil 60.45,56.15
stickystart "Collect_Strigid_Owl_Feathers"
stickystart "Collect_Nightsaber_Fangs_And_Soft_Saber_Pelts"
stickystart "Collect_Webwood_Spider_Silk_And_Small_Spider_Legs"
step
talk Lyreena Duskblade##265811
turnin The Adventurer##96630 |goto Teldrassil/0 57.57,56.64
accept The Great Outdoors##96606 |goto Teldrassil/0 57.57,56.64
stickystop "Collect_Strigid_Owl_Feathers"
stickystop "Collect_Nightsaber_Fangs_And_Soft_Saber_Pelts"
stickystop "Collect_Webwood_Spider_Silk_And_Small_Spider_Legs"
step
Watch the dialogue
Use the {y}/sit{} Emote Near the Campfire |q 96606/1 |goto Teldrassil/0 57.57,56.64 |macro /sit
Gain the Boosted Rest Buff |q 96606/2 |goto Teldrassil/0 57.57,56.64
|tip Takes {o}1 minute{}.
step
talk Lyreena Duskblade##265811
turnin The Great Outdoors##96606		|goto Teldrassil/0 57.57,56.64
accept Camping 101: Cooking##96634		|goto Teldrassil/0 57.57,56.64
accept Camping 101: Skinning##97949		|goto Teldrassil/0 57.57,56.64 |only if skillmax("Skinning") >= 1
step
talk Syral Bladeleaf##2083
accept Denalan's Earth##997 |goto Teldrassil 56.08,57.73
step
talk Athridas Bearmantle##2078
accept A Troubling Breeze##475 |goto Teldrassil 55.95,57.28
step
talk Laurna Morninglight##3600
|tip {o}Ground floor{} inside the building.
turnin In Favor of Elune##5622 |goto Teldrassil 55.56,56.75
accept Garments of the Moon##5621 |goto Teldrassil 55.56,56.75
|only if Priest
step
talk Laurna Morninglight##3600
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Laurna Morninglight##3600 |goto Teldrassil 55.56,56.75 |q 2159
|only if Priest
step
talk Byancie##6094
|tip {o}Ground floor{} inside the building.
Train First Aid |skillmax First Aid,75 |goto Teldrassil/0 55.29,56.82
|tip If possible.
|only if Warrior or Rogue
step
_NOTE:_
Create Bandages in Downtime
|tip While waiting for things like boats.
|tip Increases skill in First Aid.
|tip Need higher skill to make better bandages.
|tip Keep bandages to heal yourself.
Click Here to Continue |confirm |q 2159
|only if Warrior or Rogue
step
talk Aldia##3608
|tip {o}Middle floor{} inside the building.
accept Soft Saber Pelts##87288 |goto Teldrassil/0 55.51,57.15
step
talk Tallonkai Swiftroot##3567
|tip Top of the tower.
accept Twisted Hatred##932 |goto Teldrassil 55.57,56.95
accept The Emerald Dreamcatcher##2438 |goto Teldrassil 55.57,56.95
step
talk Kyra Windblade##3598
|tip Inside the building.
Train Abilities |trainer Kyra Windblade##3598 |goto Teldrassil/0 56.22,59.20 |q 2159
|only if Warrior
step
talk Innkeeper Keldamyr##6736
|tip Upstairs inside the building.
turnin Dolanaar Delivery##2159 |goto Teldrassil 55.62,59.79
step
talk Jannok Breezesong##3599
|tip Inside the building.
Train Abilities |trainer Jannok Breezesong##3599 |goto Teldrassil/0 56.38,60.14 |q 928
|only if Rogue
step
talk Dazalar##3601
Train Abilities |trainer Dazalar##3601 |goto Teldrassil/0 56.68,59.49 |q 928
|only if Hunter
step
talk Kal##3602
Train Abilities |trainer Kal##3602 |goto Teldrassil/0 55.95,61.56 |q 928
|only if Druid
step
talk Corithras Moonrage##3515
turnin Crown of the Earth##928 |goto Teldrassil 56.14,61.71
accept Crown of the Earth##929 |goto Teldrassil 56.14,61.71
step
Heal and Fortify Sentinel Shaya |q 5621/1 |goto Teldrassil 57.24,63.51
|tip Cast {o}Lesser Heal (Rank 2){} on Sentinel Shaya.
|tip Cast {o}Power Word: Fortitude{} on Sentinel Shaya.
|only if Priest
step
talk Zarrin##6286
Select _"I'd like to train in cooking."_ |gossip 95282
Learn Cooking from Zarrin in Dolanaar |q 96634/1 |goto Teldrassil/0 57.12,61.30
step
talk Zarrin##6286
turnin Camping 101: Cooking##96634 |goto Teldrassil/0 57.12,61.30
accept Recipe of the Kaldorei##4161 |goto Teldrassil/0 57.12,61.30
step
talk Denalan##2080
|tip Walks around.
turnin Denalan's Earth##997 |goto Teldrassil 60.90,68.49
step
Watch the dialogue
talk Denalan##2080
|tip Walks around.
accept Timberling Seeds##918 |goto Teldrassil 60.80,68.54
accept Timberling Sprouts##919 |goto Teldrassil 60.80,68.54
stickystart "Collect_Timberling_Seeds"
step
click Timberling Sprout+
|tip Brown root balls.
collect 12 Timberling Sprout##5169 |q 919/1 |goto Teldrassil/0 61.15,67.60
step
label "Collect_Timberling_Seeds"
kill Timberling##2022+
collect 8 Timberling Seed##5168 |q 918/1 |goto Teldrassil/0 61.15,67.60
step
talk Denalan##2080
|tip Walks around.
turnin Timberling Seeds##918 |goto Teldrassil 60.80,68.54
accept Rellian Greenspyre##922 |goto Teldrassil 60.80,68.54
turnin Timberling Sprouts##919 |goto Teldrassil 60.80,68.54
stickystart "Collect_Strigid_Owl_Feathers"
stickystart "Collect_Nightsaber_Fangs_And_Soft_Saber_Pelts"
stickystart "Collect_Webwood_Spider_Silk_And_Small_Spider_Legs"
step
use Jade Phial##5619
collect Filled Jade Phial##5639 |q 929/1 |goto Teldrassil 63.38,58.08
step
talk Gaerolas Talvethren##2107
|tip Upstairs inside the building.
turnin A Troubling Breeze##475 |goto Teldrassil 66.26,58.52
accept Gnarlpine Corruption##476 |goto Teldrassil 66.26,58.52
step
click Tallonkai's Dresser
|tip Inside the building.
collect Emerald Dreamcatcher##8048 |q 2438/1 |goto Teldrassil 68.01,59.63
step
label "Collect_Strigid_Owl_Feathers"
kill Strigid Owl##1995
collect 3 Strigid Owl Feather##3411 |q 488/2 |goto Teldrassil/0 64.37,52.74
|mapmarker Teldrassil/0 58.40,58.43
step
label "Collect_Nightsaber_Fangs_And_Soft_Saber_Pelts"
kill Nightsaber##2042+
|tip Black tigers.
collect 3 Nightsaber Fang##3409 |q 488/1 |goto Teldrassil/0 59.94,59.16
collect 6 Soft Nightsaber Pelt##280087 |q 87288/1 |goto Teldrassil/0 59.94,59.16 |only if haveq(87288) or completedq(87288)
step
label "Collect_Webwood_Spider_Silk_And_Small_Spider_Legs"
kill Webwood Lurker##1998+
|tip Green spiders.
collect 3 Webwood Spider Silk##3412 |q 488/3 |goto Teldrassil/0 61.99,58.93
collect 7 Small Spider Leg##5465 |q 4161/1 |goto Teldrassil/0 61.99,58.93 |only if haveq(4161) or completedq(4161)
|tip Don't vendor them.
step
Kill enemies
|tip Helps reach level 8 after quest turnins.
ding 7,2205 |goto Teldrassil/0 59.94,59.16 |only if Priest
ding 7,2475 |goto Teldrassil/0 59.94,59.16 |only if not Priest
step
talk Zenn Foulhoof##2150
|tip Walks around.
turnin Zenn's Bidding##488 |goto Teldrassil 60.45,56.15
step
talk Syral Bladeleaf##2083
accept Seek Redemption!##489 |goto Teldrassil 56.08,57.73
step
talk Athridas Bearmantle##2078
turnin Gnarlpine Corruption##476 |goto Teldrassil 55.95,57.28
step
talk Laurna Morninglight##3600
|tip {o}Ground floor{} inside the building.
turnin Garments of the Moon##5621 |goto Teldrassil 55.56,56.75
|only if Priest
step
talk Aldia##3608
|tip {o}Middle floor{} inside the building.
turnin Soft Saber Pelts##87288 |goto Teldrassil/0 55.51,57.15
step
talk Tallonkai Swiftroot##3567
|tip Top of the tower.
turnin The Emerald Dreamcatcher##2438 |goto Teldrassil 55.57,56.95
accept Ferocitas the Dream Eater##2459 |goto Teldrassil 55.57,56.95
step
talk Laurna Morninglight##3600
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Laurna Morninglight##3600 |goto Teldrassil 55.56,56.75 |q 929
|only if Priest
step
talk Kyra Windblade##3598
|tip Inside the building.
Train Abilities |trainer Kyra Windblade##3598 |goto Teldrassil/0 56.22,59.20 |q 929
|only if Warrior
step
talk Jannok Breezesong##3599
|tip Inside the building.
Train Abilities |trainer Jannok Breezesong##3599 |goto Teldrassil/0 56.38,60.14 |q 929
|only if Rogue
step
talk Dazalar##3601
Train Abilities |trainer Dazalar##3601 |goto Teldrassil/0 56.68,59.49 |q 929
|only if Hunter
step
talk Kal##3602
Train Abilities |trainer Kal##3602 |goto Teldrassil/0 55.95,61.56 |q 929
|only if Druid
step
talk Corithras Moonrage##3515
turnin Crown of the Earth##929 |goto Teldrassil 56.14,61.71
accept Crown of the Earth##933 |goto Teldrassil 56.14,61.71
step
talk Zarrin##6286
turnin Recipe of the Kaldorei##4161 |goto Teldrassil 57.12,61.30
stickystart "Collect_Fel_Cones"
stickystart "Kill_Gnarlpine_Mystics"
step
kill Ferocitas the Dream Eater##7234
collect Gnarlpine Necklace##8049 |q 2459 |goto Teldrassil 69.37,53.40
step
use Gnarlpine Necklace##8049
collect Tallonkai's Jewel##8050 |q 2459/2
step
label "Kill_Gnarlpine_Mystics"
kill 7 Gnarlpine Mystic##7235 |q 2459/1 |goto Teldrassil/0 69.23,52.96
step
label "Collect_Fel_Cones"
click Fel Cone+
|tip Brown pine cones with green smoke.
|tip Usually near trees.
collect 3 Fel Cone##3418 |q 489/1 |goto Teldrassil/0 66.70,53.40
|mapmarker Teldrassil/0 58.10,55.40
|mapmarker Teldrassil/0 59.10,62.20
|mapmarker Teldrassil/0 61.60,53.40
|mapmarker Teldrassil/0 62.00,63.90
|mapmarker Teldrassil/0 63.60,62.30
|mapmarker Teldrassil/0 64.30,53.90
|mapmarker Teldrassil/0 64.80,50.90
|mapmarker Teldrassil/0 65.10,65.10
|mapmarker Teldrassil/0 66.20,60.90
|mapmarker Teldrassil/0 68.60,57.90
|mapmarker Teldrassil/0 68.80,55.70
|mapmarker Teldrassil/0 69.00,59.70
step
talk Zenn Foulhoof##2150
|tip Walks around.
turnin Seek Redemption!##489 |goto Teldrassil/0 60.45,56.15
step
Enter the cave |goto Teldrassil/0 54.65,52.45 < 20 |walk |only if not subzone("Fel Rock")
kill Lord Melenas##2038
|tip Satyr.
|tip Multiple locations.
|tip Inside the cave.
collect Melenas' Head##5221 |q 932/1 |goto Teldrassil/0 51.22,50.81
|mapmarker Teldrassil/0 51.40,49.40
|mapmarker Teldrassil/0 51.60,51.60
|mapmarker Teldrassil/0 52.60,49.40
step
Leave the cave |goto Teldrassil/0 54.65,52.45 < 20 |walk |only if subzone("Fel Rock")
talk Laurna Morninglight##3600
|tip {o}Ground floor{} inside the building.
accept The Sisterhood of Elune##98391 |goto Teldrassil/0 55.56,56.74
step
talk Tallonkai Swiftroot##3567
|tip Top of the tower.
turnin Twisted Hatred##932 |goto Teldrassil 55.57,56.95
turnin Ferocitas the Dream Eater##2459 |goto Teldrassil 55.57,56.95
step
click Strange Fruited Plant
accept The Glowing Fruit##930 |goto Teldrassil 42.63,76.10
step
use Tourmaline Phial##5621
collect Filled Tourmaline Phial##5645 |q 933/1 |goto Teldrassil 42.42,67.07
step
Allow Enemies to Kill You
|tip Here, or {o}east of here{}.
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Teldrassil 46.87,71.67 |q 933
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Teldrassil 56.20,63.26 |q 933 |zombiewalk
|only if not hardcore()
step
talk Corithras Moonrage##3515
turnin Crown of the Earth##933 |goto Teldrassil 56.14,61.71
accept Crown of the Earth##7383 |goto Teldrassil 56.14,61.71
step
talk Sentinel Kyra Starsong##2081
|tip Inside the building.
accept The Lost Runner##99046 |goto Teldrassil/0 56.00,59.52
step
talk Innkeeper Keldamyr##6736
|tip Upstairs inside the building.
home Dolanaar |goto Teldrassil 55.62,59.79
step
map Teldrassil
path follow strictbounce;	loop off;	ants straight;		dist 40;	markers none;		arrow hide
path	55.81,58.31	55.50,58.45	54.54,58.48	53.98,58.19	53.59,57.61
path	53.00,57.34	52.68,56.74	52.34,56.44	51.91,56.39	51.60,56.47
path	51.30,56.67	51.00,56.58	50.55,56.09	50.43,55.56	50.50,54.54
path	50.44,54.20	50.20,53.86
talk Moon Priestess Amara##2151
|tip Walks along the road.
accept The Road to Darnassus##487
step
talk Radnaal Maneweaver##6287
turnin Camping 101: Skinning##97949 |goto Teldrassil/0 42.09,49.96
|only if haveq(97949) or completedq(97949)
step
map Teldrassil
path follow strictbounce;	loop off;	ants straight;		dist 40;	markers none;		arrow hide
path	41.53,51.00	41.14,50.80	40.92,50.74	40.59,50.72	40.30,50.74
path	40.11,50.87	39.82,51.19	39.55,51.57	39.45,51.79	39.38,52.13
path	39.30,52.51	39.24,52.79	39.18,52.94	38.96,53.34	38.74,53.68
path	38.50,54.05	38.29,54.36	38.18,54.45	38.02,54.51	37.92,54.56
talk Sentinel Shayla Nightbreeze##2155
|tip Walks along the road.
accept Bounty: Gnarlpine Furbolg##490
stickystart "Kill_Gnarlpine_Ambushers"
step
kill Gnarlpine Ambusher##2152+
collect 15 Gnarlpine Fang##5220 |q 490/1 |goto Teldrassil/0 47.01,53.45
step
label "Kill_Gnarlpine_Ambushers"
kill 6 Gnarlpine Ambusher##2152 |q 487/1 |goto Teldrassil/0 47.01,53.45
step
map Teldrassil
path follow strictbounce;	loop off;	ants straight;		dist 40;	markers none;		arrow hide
path	41.53,51.00	41.14,50.80	40.92,50.74	40.59,50.72	40.30,50.74
path	40.11,50.87	39.82,51.19	39.55,51.57	39.45,51.79	39.38,52.13
path	39.30,52.51	39.24,52.79	39.18,52.94	38.96,53.34	38.74,53.68
path	38.50,54.05	38.29,54.36	38.18,54.45	38.02,54.51	37.92,54.56
talk Sentinel Shayla Nightbreeze##2155
|tip Walks along the road.
turnin Bounty: Gnarlpine Furbolg##490
step
talk Sentinel Eralya Leafshadow##275683
turnin The Lost Runner##99046 |goto Teldrassil/0 37.54,36.81
accept Not Dead Yet##99047 |goto Teldrassil/0 37.54,36.81
step
talk Sentinel Arynia Cloudsbreak##3519
accept The Enchanted Glade##937 |goto Teldrassil 38.31,34.36
step
use Amethyst Phial##18152
collect Filled Amethyst Phial##18151 |q 7383/1 |goto Teldrassil 38.43,34.04
stickystart "Collect_Bloodfeather_Belts"
step
click Strange Fronded Plant
accept The Shimmering Frond##931 |goto Teldrassil 34.60,28.85
step
talk Mist##3568
|tip Escort quest.
|tip Wait until she respawns, if missing.
accept Mist##938 |goto Teldrassil 31.54,31.61 |noautoaccept inparty
step
Lead Mist Safely to Sentinel Arynia Cloudsbreak |q 938/1 |goto Teldrassil 38.31,34.36
|tip {o}Hurry{}, timed quest.
step
Watch the dialogue
talk Sentinel Arynia Cloudsbreak##3519
turnin Mist##938 |goto Teldrassil 38.31,34.36
step
label "Collect_Bloodfeather_Belts"
kill Bloodfeather Rogue##2017, Bloodfeather Sorceress##2018, Bloodfeather Harpy##2015, Bloodfeather Fury##2019, Bloodfeather Matriarch##2021, Bloodfeather Wind Witch##2020
|tip Harpies.
collect 6 Bloodfeather Belt##5204 |q 937/1 |goto Teldrassil/0 36.68,38.55
step
talk Sentinel Arynia Cloudsbreak##3519
turnin The Enchanted Glade##937 |goto Teldrassil 38.31,34.36
accept Darkness in the Glade##98392 |goto Teldrassil/0 38.31,34.36
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Teldrassil 35.40,36.40 |q 922
|mapmarker Teldrassil/0 33.40,35.60
|mapmarker Teldrassil/0 34.20,33.40
|mapmarker Teldrassil/0 35.20,38.80
|mapmarker Teldrassil/0 36.40,41.60
|mapmarker Teldrassil/0 37.20,43.60
|mapmarker Teldrassil/0 37.60,37.80
|mapmarker Teldrassil/0 38.20,40.40
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Darnassus/0 76.98,27.17 |q 922 |zombiewalk
|only if not hardcore()
step
talk Sister Aquinne##7316
turnin The Sisterhood of Elune##98391 |goto Darnassus/0 28.93,45.80
accept The Temple of the Moon##2519 |goto Darnassus/0 28.93,45.80
step
talk Sentinel Dalia Sunblade##8396
|tip Inside the building.
accept Eyes of the Sentinels##98067 |goto Darnassus/0 39.65,89.54
step
talk Priestess A'moora##7313
|tip Upstairs inside the building.
turnin The Temple of the Moon##2519 |goto Darnassus 36.64,85.93
accept Tears of the Moon##2518 |goto Darnassus 36.64,85.93
step
use Lunar Pendant##279378
Place a Sentinel Owl at the Darnassus Bank |q 98067/2 |goto Darnassus/0 40.73,42.72
step
talk Rellian Greenspyre##3517
turnin Rellian Greenspyre##922 |goto Darnassus 38.19,21.63
accept Tumors##923 |goto Darnassus 38.19,21.63
step
use Lunar Pendant##279378
Place a Sentinel Owl at the Cenarion Hold Depths Entrance |q 98067/1 |goto Darnassus/0 33.19,16.12
step
use Lunar Pendant##279378
Place a Sentinel Owl at the Craftsman's Terrace Inn |q 98067/3 |goto Darnassus/0 66.97,15.70
step
use Lunar Pendant##279378
Place a Sentinel Owl at the City Gate |q 98067/4 |goto Teldrassil/0 35.75,54.32
step
talk Sentinel Dalia Sunblade##8396
|tip Inside the building.
turnin Eyes of the Sentinels##98067 |goto Darnassus/0 39.65,89.54
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 7383
|only if Priest
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 7383
|tip Make sure to learn {o}Pick Pocket{}.
|tip Needed for a quest soon.
|only if Rogue
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 10 ammo when restocking.
Click Here to Continue |confirm |q 7383
|only if Hunter
step
talk Jocaste##4146
|tip Upstairs inside the building.
accept The Hunter's Path##6071 |goto Darnassus/0 40.38,8.54
|only if Hunter
step
talk Jocaste##4146
|tip Upstairs inside the building.
Train Abilities |trainer Jocaste##4146 |goto Darnassus/0 40.38,8.54 |q 7383
|only if Hunter
step
talk Denatharion##4218
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Denatharion##4218 |goto Darnassus/0 34.77,7.37 |q 7383
|only if Druid
step
talk Mathrengyl Bearwalker##4217
|tip {o}Middle floor{} inside the building.
accept Moonglade##5921 |goto Darnassus 35.37,8.40
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Moonglade##5921 |goto Moonglade 56.21,30.64
accept Great Bear Spirit##5929 |goto Moonglade 56.21,30.64
|only if Druid
step
talk Great Bear Spirit##11956
Select _"What do you represent, spirit?"_
Seek Out the Great Bear Spirit and Learn what it Has to Share with You About the Nature of the Bear |q 5929/1 |goto Moonglade 39.11,27.51
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Great Bear Spirit##5929 |goto Moonglade 56.21,30.64
accept Back to Darnassus##5931 |goto Moonglade 56.21,30.64
|only if Druid
step
talk Sindrayl##10897
fpath Moonglade |goto Moonglade 48.10,67.34
|only if Druid
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 7383
|only if Warrior
step
talk Kyra Windblade##3598
|tip Inside the building.
accept Elanaria##1684 |goto Teldrassil 56.22,59.20
|only if Warrior
step
talk Dazalar##3601
turnin The Hunter's Path##6071 |goto Teldrassil 56.68,59.49
accept Taming the Beast##6063 |goto Teldrassil 56.68,59.49
|only if Hunter
step
use Taming Rod##15921
|tip On a Webwood Lurker.
|tip Green spiders.
Tame a Webwood Lurker |q 6063/1 |goto Teldrassil/0 61.40,58.55
|only if Hunter
step
talk Dazalar##3601
turnin Taming the Beast##6063 |goto Teldrassil 56.68,59.49
accept Taming the Beast##6101 |goto Teldrassil 56.68,59.49
|only if Hunter
step
talk Corithras Moonrage##3515
turnin Crown of the Earth##7383 |goto Teldrassil 56.14,61.71
accept Crown of the Earth##935 |goto Teldrassil 56.14,61.71
step
talk Denalan##2080
|tip Walks around.
turnin The Shimmering Frond##931 |goto Teldrassil 60.90,68.49
turnin The Glowing Fruit##930 |goto Teldrassil 60.90,68.49
step
use Taming Rod##15922
|tip On a Nightsaber Stalker.
|tip Blue leopards.
|tip Dismiss your pet first.
Tame a Nightsaber Stalker |q 6101/1 |goto Teldrassil/0 61.80,73.00
|only if Hunter
step
talk Dazalar##3601
turnin Taming the Beast##6101 |goto Teldrassil/0 56.68,59.49
accept Taming the Beast##6102 |goto Teldrassil/0 56.68,59.49
|only if Hunter
step
use Taming Rod##15923
|tip On a Strigid Screecher.
|tip Owls.
|tip Dismiss your pet first.
Tame a Strigid Screecher |q 6102/1 |goto Teldrassil/0 64.00,66.20
|only if Hunter
step
talk Dazalar##3601
turnin Taming the Beast##6102 |goto Teldrassil/0 56.68,59.49
accept Training the Beast##6103 |goto Teldrassil/0 56.68,59.49
|only if Hunter
step
talk Jannok Breezesong##3599
|tip Inside the building.
accept The Apple Falls##2241 |goto Teldrassil 56.38,60.14
|only if Rogue
step
talk Laurna Morninglight##3600
|tip {o}Ground floor{} inside the building.
accept Returning Home##5629 |goto Teldrassil 55.57,56.75
|only if Priest
step
talk Byancie##6094
|tip {o}Ground floor{} inside the building.
turnin Not Dead Yet##99047 |goto Teldrassil/0 55.29,56.82
step
map Teldrassil
path follow strictbounce;	loop off;	ants straight;		dist 40;	markers none;		arrow hide
path	55.81,58.31	55.50,58.45	54.54,58.48	53.98,58.19	53.59,57.61
path	53.00,57.34	52.68,56.74	52.34,56.44	51.91,56.39	51.60,56.47
path	51.30,56.67	51.00,56.58	50.55,56.09	50.43,55.56	50.50,54.54
path	50.44,54.20	50.20,53.86
talk Moon Priestess Amara##2151
|tip Walks along the road.
turnin The Road to Darnassus##487
step
Enter the cave in the tree trunk |goto Darnassus 32.12,16.46 < 7 |walk
talk Syurna##4163
|tip Inside the cave.
turnin The Apple Falls##2241 |goto Darnassus 36.99,21.91
accept Destiny Calls##2242 |goto Darnassus 36.99,21.91
|only if Rogue
step
_NOTE:_
Tame a Strigid Hunter
|tip Cast {o}Tame Beast{} on a {o}Strigid Hunter{}.
|tip Owls.
|tip Dismiss your pet first.
Click Here to Continue |confirm |goto Teldrassil/0 40.80,44.80 |q 6103
|mapmarker Teldrassil/0 37.20,29.20
|mapmarker Teldrassil/0 37.40,37.40
|mapmarker Teldrassil/0 38.20,32.60
|mapmarker Teldrassil/0 40.80,30.20
|mapmarker Teldrassil/0 41.80,37.60
|mapmarker Teldrassil/0 44.20,40.00
|mapmarker Teldrassil/0 45.80,30.40
|only if Hunter
stickystart "Collect_Mossy_Tumors"
step
kill Lady Sathrah##7319
|tip Large grey spider.
|tip Walks around.
|tip Multiple locations.
collect Silvery Spinnerets##8344 |q 2518/1 |goto Teldrassil 48.00,25.20
|mapmarker Teldrassil/0 39.20,25.40
|mapmarker Teldrassil/0 41.00,25.60
|mapmarker Teldrassil/0 46.20,24.40
step
collect Sethir's Journal##7737 |q 2242/1 |goto Teldrassil 37.52,24.29
|tip Cast {o}Pickpocket{} on {o}Sethir the Ancient{}.
|tip Purple satyr.
|tip Stands here and walks onto the {o}huge tree branch{} nearby.
|tip {o}Don't attack{}, he summons a group of enemies.
|mapmarker Teldrassil/0 37.20,23.00
|mapmarker Teldrassil/0 37.40,21.20
|only if Rogue
step
label "Collect_Mossy_Tumors"
kill Timberling Trampler##2027, Timberling Mire Beast##2029, Elder Timberling##2030
|tip Swamp elementals.
collect 5 Mossy Tumor##5170 |q 923/1 |goto Teldrassil 42.00,43.60
|mapmarker Teldrassil/0 41.40,41.40
|mapmarker Teldrassil/0 42.00,37.40
|mapmarker Teldrassil/0 43.40,40.20
|mapmarker Teldrassil/0 44.00,43.60
|mapmarker Teldrassil/0 52.40,73.80
|mapmarker Teldrassil/0 41.40,33.40
|mapmarker Teldrassil/0 42.80,29.20
|mapmarker Teldrassil/0 43.20,31.80
|mapmarker Teldrassil/0 43.20,35.80
|mapmarker Teldrassil/0 42.20,25.40
|mapmarker Teldrassil/0 44.20,26.60
step
kill Witchmother Arysa##272046
collect Witchmother Arysa's Amulet##280834 |q 98392/3 |goto Teldrassil/0 34.24,27.92
step
kill Windmistress Gaedress##272044
collect Windmistress Gaedress' Amulet##280832 |q 98392/2 |goto Teldrassil/0 33.18,36.10
step
kill Hatescreech##272034
collect Hatescreech's Amulet##280831 |q 98392/1 |goto Teldrassil/0 35.05,39.28
step
talk Sentinel Arynia Cloudsbreak##3519
turnin Darkness in the Glade##98392 |goto Teldrassil/0 38.32,34.36
accept The Oracle Tree##98398 |goto Teldrassil/0 38.32,34.36
step
click Oracle Tree Bark
turnin The Oracle Tree##98398 |goto Teldrassil/0 36.96,34.04
accept Teldrassil##940 |goto Teldrassil/0 36.96,34.04
step
talk Mydrannul##4241
accept Nessa Shadowsong##6344 |goto Darnassus 70.68,45.38
step
talk Elanaria##4088
turnin Elanaria##1684 |goto Darnassus 57.30,34.61
accept Vorlus Vilehoof##1683 |goto Darnassus 57.30,34.61
|only if Warrior
step
Run around the mountain and follow the path up |goto Teldrassil 48.68,62.73 < 15 |only if walking
kill Vorlus Vilehoof##6128
collect Horn of Vorlus##6805 |q 1683/1 |goto Teldrassil 47.25,63.60
|only if Warrior
step
talk Elanaria##4088
turnin Vorlus Vilehoof##1683 |goto Darnassus 57.30,34.61
|only if Warrior
step
talk Ilyenia Moonfire##11866
Train Thrown |complete weaponskill("TH_STAFF") > 0 |goto Darnassus 57.56,46.73 |only if Warrior
Train Staves |complete weaponskill("TH_STAFF") > 0 |goto Darnassus 57.56,46.73 |only if Warrior or Hunter or Priest
|only if Warrior or Hunter or Priest
step
talk Rellian Greenspyre##3517
turnin Tumors##923 |goto Darnassus 38.19,21.64
step
Enter the cave in the tree trunk |goto Darnassus 32.12,16.46 < 7 |walk
talk Syurna##4163
|tip Inside the cave.
turnin Destiny Calls##2242 |goto Darnassus 36.99,21.91
|only if Rogue
step
talk Jocaste##4146
|tip Inside the building.
turnin Training the Beast##6103 |goto Darnassus 40.38,8.55
|only if Hunter
step
_NOTE:_
Train Your Pet
|tip Learn pet abilities from Pet Trainers.
|tip Cast {o}Beast Training{} to teach your pet.
Click Here to Continue |confirm |q 6344
|only if Hunter
step
talk Silvaria##10089
|tip Top of the building.
Train Pet Abilities |trainer Silvaria##10089 |goto Darnassus/0 42.47,9.17 |q 935
|only if Hunter
step
talk Mathrengyl Bearwalker##4217
|tip {o}Middle floor{} inside the building.
turnin Back to Darnassus##5931 |goto Darnassus 35.38,8.41
accept Body and Heart##6001 |goto Darnassus 35.38,8.41
|only if Druid
step
talk Arch Druid Fandral Staghelm##3516
|tip Walks around.
|tip Top of the tower.
turnin Crown of the Earth##935 |goto Darnassus 34.80,9.24
accept Crown of the Earth##98046 |goto Darnassus/0 34.80,9.24
turnin Teldrassil##940 |goto Darnassus 34.80,9.24
accept Grove of the Ancients##952 |goto Darnassus 34.80,9.24
step
talk Lariia##4092
|tip Inside the building.
turnin Crown of the Earth##98046 |goto Darnassus/0 40.34,88.69
accept Crown of the Earth##98065 |goto Darnassus/0 40.34,88.69
step
talk Priestess A'moora##7313
|tip Upstairs inside the building.
turnin Tears of the Moon##2518 |goto Darnassus 36.64,85.93
accept Sathrah's Sacrifice##2520 |goto Darnassus 36.64,85.93
step
use Sathrah's Sacrifice##8155
|tip Inside the building.
Offer the Sacrifice at the Fountain |q 2520/1 |goto Darnassus 39.21,84.57
step
talk Priestess A'moora##7313
|tip Upstairs inside the building.
turnin Sathrah's Sacrifice##2520 |goto Darnassus 36.64,85.93
step
talk Tyrande Whisperwind##7999
|tip Upstairs inside the building.
turnin Crown of the Earth##98065 |goto Darnassus/0 39.09,81.59
step
talk Priestess Alathea##11401
|tip Upstairs inside the building.
turnin Returning Home##5629 |goto Darnassus 39.53,81.18
accept Stars of Elune##5627 |goto Darnassus 39.53,81.18 |instant
|only if Priest
step
talk Nessa Shadowsong##10118
turnin Nessa Shadowsong##6344 |goto Teldrassil 56.25,92.43
accept The Bounty of Teldrassil##6341 |goto Teldrassil 56.25,92.43
step
talk Vesprystus##3838
turnin The Bounty of Teldrassil##6341 |goto Teldrassil 58.40,94.01
accept Flight to Auberdine##6342 |goto Teldrassil 58.40,94.01
step
talk Vesprystus##3838
|tip Open the flight map.
|tip Allows guide to learn your flight paths.
fpath Auberdine |goto Teldrassil 58.40,94.01
step
talk Laird##4200
|tip Inside the building.
turnin Flight to Auberdine##6342 |goto Darkshore 36.77,44.29
accept Return to Nessa##6343 |goto Darkshore/0 36.77,44.29
step
use Cenarion Moondust##15208
|tip Inside the small cave.
kill Lunaclaw##12138
Face Lunaclaw and Earn the Strength of Body and Heart it Possesses |q 6001/1 |goto Darkshore 43.48,45.96
|only if Druid
step
_NOTE:_
Use Weapon Stones
|tip We will train Mining and Blacksmithing.
|tip Allows you to make and use {o}Sharpening Stones{}.		|only if Warrior or Rogue
|tip Increases damage.
|tip Mine {o}Copper Ore{} as you see it.
|tip Use the {g}Rough Stones{} to make sharpening stones.	|only if Warrior or Rogue
Click Here to Continue |confirm |q 983
|only if Warrior or Rogue
step
talk Delfrum Flintbeard##6299
Train Apprentice Blacksmithing |skillmax Blacksmithing,75 |goto Darkshore/0 38.19,40.94
|only if Warrior or Rogue
step
talk Kurdram Stonehammer##6297
Train Apprentice Mining |skillmax Mining,75 |goto Darkshore/0 38.25,41.01
|only if Warrior or Rogue
step
talk Thelgrum Stonehammer##6298
buy Mining Pick##2901 |goto Darkshore/0 38.22,41.19
|only if Warrior or Rogue
step
talk Nessa Shadowsong##10118
turnin Return to Nessa##6343 |goto Teldrassil/0 56.25,92.44
step
talk Denatharion##4218
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Denatharion##4218 |goto Darnassus/0 34.77,7.37 |q 6001
|only if Druid
step
talk Mathrengyl Bearwalker##4217
|tip {o}Middle floor{} inside the building.
turnin Body and Heart##6001 |goto Darnassus/0 35.38,8.41
|only if Druid
step
Enter the building |goto Stormwind City/0 52.97,51.06 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.61,46.35 |q 96408 |future
|only if Priest
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 96408 |future
|only if Warrior
step
talk Ilsa Corbin##5480
|tip Upstairs inside the building.
accept A Warrior's Training##1638 |goto Stormwind City 80.36,59.79
|only if Warrior
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin A Warrior's Training##1638 |goto Stormwind City 77.08,53.25
accept Bartleby the Drunk##1639 |goto Stormwind City 77.08,53.25
|only if Warrior
step
talk Bartleby##6090
|tip Walks around.
|tip Inside the building.
turnin Bartleby the Drunk##1639 |goto Stormwind City 76.76,53.18
accept Beat Bartleby##1640 |goto Stormwind City 76.76,53.18
|tip You will be attacked.
|only if Warrior
step
kill Bartleby##6090
|tip Walks around.
|tip Inside the building.
Beat Bartleby |q 1640/1 |goto Stormwind City 76.76,53.18
|only if Warrior
step
talk Bartleby##6090
|tip Walks around.
|tip Inside the building.
turnin Beat Bartleby##1640 |goto Stormwind City 76.76,53.18
accept Bartleby's Mug##1665 |goto Stormwind City 76.76,53.18
|only if Warrior
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin Bartleby's Mug##1665 |goto Stormwind City 77.08,53.25
|only if Warrior
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 96408 |future
|only if Rogue
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 96408 |future
|only if Hunter
step
talk Karrina Mekenda##2879
|tip Inside the building.
Train Pet Abilities |trainer Karrina Mekenda##2879 |goto Stormwind City/0 67.28,36.78 |q 96408 |future
|only if Hunter
step
talk Grimand Elmore##1416
|tip Inside the building.
accept Stormpike's Delivery##353 |goto Stormwind City/0 59.72,33.78
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Stormwind City/0 69.31,30.56 |q 96408 |future
|tip Walk into the portal.
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the tram to Ironforge.
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
accept Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
use Rat Catcher's Flute##17117
|tip On Deeprun Rats.
|tip Small grey rats.
|tip Ironforge section of the Deeprun Tram.
Capture #5# Rats |q 6661/1
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
turnin Deeprun Rat Roundup##6661
accept Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Enter Ironforge |complete zone("Ironforge") |q 96408 |future
|tip Walk into the portal.
step
talk Gryth Thurden##1573
fpath Ironforge |goto Ironforge 55.50,47.75
step
talk Beldin Steelgrill##1376
accept A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 50.44,49.09
step
_NOTE:_
Tame an Ice Claw Bear
|tip Cast {o}Tame Beast{} on an Ice Claw Bear.
|tip Try to find one that's {o}level 9{}.
|tip Abandon your pet first.
|tip New permanent pet.
Click Here to Continue |confirm |goto Dun Morogh 51.80,44.40 |q 96408 |future
|mapmarker Dun Morogh/0 55.40,43.60
|mapmarker Dun Morogh/0 59.40,52.00
|mapmarker Dun Morogh/0 61.00,56.40
|mapmarker Dun Morogh/0 64.80,60.00
|mapmarker Dun Morogh/0 66.40,50.80
|only if Hunter
step
talk Rudra Amberstill##1265
|tip Follow the road.
accept Never Saddle on Quality##95212 |goto Dun Morogh/0 63.08,49.85
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 64.88,58.46
accept Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
Select _"Earthseer, please share your farsight with me."_ |gossip 139831
Use Farsen's Farsight |q 96392/1 |goto Dun Morogh/0 64.88,58.46
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
accept Nip 'Em in the Bud##96390 |goto Dun Morogh/0 64.88,58.46
step
talk Senator Mehr Stonehallow##1977
accept The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Foreman Stonebrow##1254
accept Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
step
kill 6 Rockjaw Skullthumper##1115 |q 432/1 |goto Dun Morogh/0 69.17,58.42
|tip More inside the cave nearby.
step
Leave the cave |goto Dun Morogh 70.70,56.49 < 20 |walk |only if subzone("Gol'Bolar Quarry Mine")
talk Foreman Stonebrow##1254
turnin Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
stickystart "Kill_Dark_Iron_Spies"
stickystart "Collect_Pristine_Leopard_Pelts"
stickystart "Kill_Rockjaw_Bonesnappers"
step
kill Dark Iron Spy##6123+
collect Dark Iron Map##274268 |n
use Dark Iron Map##274268
accept Underground Map##96391 |goto Dun Morogh/0 77.46,60.87
step
label "Kill_Dark_Iron_Spies"
kill 10 Dark Iron Spy##6123 |q 96390/1 |goto Dun Morogh/0 77.46,60.87
step
label "Collect_Pristine_Leopard_Pelts"
kill Elder Snow Leopard##260157+
collect 6 Pristine Leopard Pelt##267414 |q 95212/1 |goto Dun Morogh/0 75.24,56.91
step
label "Kill_Rockjaw_Bonesnappers"
kill 10 Rockjaw Bonesnapper##1117 |q 433/1 |goto Dun Morogh/0 75.24,56.91
step
talk Senator Mehr Stonehallow##1977
turnin The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Nip 'Em in the Bud##96390 |goto Dun Morogh/0 64.88,58.46
turnin Underground Map##96391 |goto Dun Morogh/0 64.88,58.46
step
talk Rudra Amberstill##1265
turnin Never Saddle on Quality##95212 |goto Dun Morogh/0 63.08,49.85
step
talk Pilot Hammerfoot##1960
|tip Follow the road through the tunnel.
accept The Lost Pilot##419 |goto Dun Morogh 83.89,39.19
step
click A Dwarven Corpse
turnin The Lost Pilot##419 |goto Dun Morogh 79.67,36.17
accept A Pilot's Revenge##417 |goto Dun Morogh 79.67,36.17
step
kill Mangeclaw##1961
|tip White bear.
|tip Walks around.
collect Mangy Claw##3183 |q 417/1 |goto Dun Morogh/0 78.97,37.02
step
talk Pilot Hammerfoot##1960
turnin A Pilot's Revenge##417 |goto Dun Morogh/0 83.89,39.19
step
talk Mountaineer Stormpike##1343
|tip Run through the tunnel.
|tip Upstairs inside the building.
turnin Stormpike's Delivery##353 |goto Loch Modan/0 24.76,18.40
stickystart "Accept_Mountaineer_Stormpikes_Task"
step
talk Thorgrum Borrelson##1572
fpath Thelsamar |goto Loch Modan/0 33.94,50.95
step
label "Accept_Mountaineer_Stormpikes_Task"
map Loch Modan
path	follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	32.67,49.72	33.27,49.16	33.86,48.37	34.30,47.64	34.91,47.05
path	35.56,46.76	36.09,46.37	37.11,46.01	37.32,45.60	37.37,44.45
path	37.29,43.33	36.73,41.98
talk Mountaineer Kadrell##1340
|tip Walks a large path.
accept Rat Catching##416
accept Mountaineer Stormpike's Task##1339
step
kill Tunnel Rat Scout##1173, Tunnel Rat Vermin##1172, Tunnel Rat Forager##1176
|tip Rat people.
collect 12 Tunnel Rat Ear##3110 |q 416/1 |goto Loch Modan/0 26.99,43.26
|mapmarker Loch Modan/0 24.77,30.34
|mapmarker Loch Modan/0 37.47,17.07
step
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Mountaineer Stormpike's Task##1339 |goto Loch Modan 24.76,18.40
accept Stormpike's Order##1338 |goto Loch Modan 24.76,18.40
accept Filthy Paws##307 |goto Loch Modan/0 24.76,18.40
step
map Loch Modan
path	follow strictbounce;	loop off;	ants straight;		dist 20;	markers none;		arrow hide
path	32.67,49.72	33.27,49.16	33.86,48.37	34.30,47.64	34.91,47.05
path	35.56,46.76	36.09,46.37	37.11,46.01	37.32,45.60	37.37,44.45
path	37.29,43.33	36.73,41.98
talk Mountaineer Kadrell##1340
|tip Walks a large path.
turnin Rat Catching##416
step
talk Mountaineer Cobbleflint##1089
accept In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.12
step
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
accept The Trogg Threat##267 |goto Loch Modan 23.23,73.67
stickystart "Kill_Stonesplinter_Troggs_And_Scouts"
step
Follow the road to the path here |goto Loch Modan 29.32,66.73 < 40 |only if walking and not subzone("Stonesplinter Valley")
kill Stonesplinter Trogg##1161, Stonesplinter Scout##1162
collect 8 Trogg Stone Tooth##2536 |q 267/1 |goto Loch Modan/0 32.79,74.99
|mapmarker Loch Modan/0 27.49,52.97
step
label "Kill_Stonesplinter_Troggs_And_Scouts"
kill 10 Stonesplinter Trogg##1161 |q 224/1 |goto Loch Modan/0 32.79,74.99
kill 10 Stonesplinter Scout##1162 |q 224/2 |goto Loch Modan/0 32.79,74.99
|mapmarker Loch Modan/0 27.49,52.97
step
Leave Stonesplinter Valley and follow the road |goto Loch Modan 30.57,69.69 < 30 |only if walking and subzone("Stonesplinter Valley")
talk Mountaineer Cobbleflint##1089
turnin In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.13
step
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
turnin The Trogg Threat##267 |goto Loch Modan 23.23,73.67
step
talk Buliwyf Stonehand##11865
|tip Inside the building.
Train Two-Handed Axes |complete weaponskill("TH_AXE") > 0 |goto Ironforge 61.17,89.52
Train Two-Handed Maces |complete weaponskill("TH_MACE") > 0 |goto Ironforge 61.17,89.52
|only if Warrior
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Ironforge 76.58,51.14 |q 1338
|tip Walk into the portal.
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the tram to Stormwind City.
talk Nipsy##13018
|tip Middle platform, near the wall.
|tip Stormwind City section of the Deeprun Tram.
turnin Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Enter Stormwind City |complete zone("Stormwind City") |q 1338
|tip Walk into the portal.
step
talk Furen Longbeard##5413
turnin Stormpike's Order##1338 |goto Stormwind City/0 64.60,37.22
step
talk Woo Ping##11867
|tip Inside the building.
Train Two-Handed Swords |complete weaponskill("TH_SWORD") > 0	|goto Stormwind City 63.85,69.08	|only if Warrior or Hunter
Train One-Handed Swords |complete weaponskill("SWORD") > 0	|goto Stormwind City 63.85,69.08	|only if Rogue
Train Staves		|complete weaponskill("TH_STAFF") > 0	|goto Stormwind City 63.85,69.08	|only if Priest
|only if Warrior or Hunter or Rogue or Priest
step
talk Innkeeper Allison##6740
|tip Inside the building.
home Stormwind City |goto Stormwind City/0 60.39,75.27
step
Run up the ramp |goto Stormwind City 67.92,72.64 < 10 |only if walking
talk Dungar Longdrink##352
|tip Inside the building.
fpath Stormwind |goto Stormwind City 70.91,72.51
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Westfall (13-15)",{
image=ZGV.IMAGESDIR.."Westfall",
hardcore = true,
next="Leveling Guides\\Darkshore (15-18)",
},[[
step
talk Farmer Furlbrow##237
turnin Furlbrow's Deed##184		|goto Westfall 59.96,19.36	|only if haveq(184) or completedq(184)
accept The Forgotten Heirloom##64	|goto Westfall 59.96,19.36
accept Report to Gryan Stoutmantle##109 |goto Westfall 59.96,19.36	|only if NightElf or Skyborne
|only if Dwarf or Gnome or NightElf or Skyborne
step
talk Verna Furlbrow##238
accept Westfall Stew##36 |goto Westfall 59.92,19.42
accept Poor Old Blanchy##151 |goto Westfall 59.92,19.42
|only if Dwarf or Gnome or NightElf or Skyborne
step
talk Farmer Saldean##233
accept The Killing Fields##9 |goto Westfall 56.05,31.22
|only if Dwarf or Gnome or NightElf or Skyborne
step
talk Salma Saldean##235
|tip Inside the building.
turnin Westfall Stew##36 |goto Westfall 56.42,30.52
accept Westfall Stew##38 |goto Westfall 56.42,30.52
accept Goretusk Liver Pie##22 |goto Westfall 56.42,30.52
|only if Dwarf or Gnome or NightElf or Skyborne
step
talk Gryan Stoutmantle##234
turnin Journey to Sentinel Hill##98021 |goto Westfall/0 56.33,47.52	|only if Skyborne
turnin Report to Gryan Stoutmantle##109 |goto Westfall/0 56.33,47.52
accept The People's Militia##12 |goto Westfall/0 56.33,47.52
|only if Dwarf or Gnome or NightElf or Skyborne
step
talk Captain Danuvin##821
accept Patrolling Westfall##102 |goto Westfall/0 56.42,47.62
|only if Dwarf or Gnome or NightElf or Skyborne
step
talk Thor##523
fpath Sentinel Hill |goto Westfall 56.55,52.64
|only if Dwarf or Gnome or NightElf or Skyborne
step
talk Scout Galiaan##878
accept Red Leather Bandanas##153 |goto Westfall/0 53.98,52.98
step
talk Alba Fairmoon##253092
|tip Inside the building.
accept Testing the Wells##92742 |goto Westfall/0 52.48,52.95
accept Murloc Gills##92744 |goto Westfall/0 52.48,52.95
stickystart "Kill_Defias_Trappers_And_Smugglers"
stickystart "Collect_Stringy_Vulture_Meat"
stickystart "Collect_Goretusk_Snouts_And_Livers"
stickystart "Collect_Handfuls_Of_Oats"
step
kill Defias Trapper##504, Defias Smuggler##95
collect 15 Red Leather Bandana##829 |q 153/1 |goto Westfall/0 48.85,46.57
|mapmarker Westfall/0 48.19,38.62
|mapmarker Westfall/0 41.22,40.61
step
label "Kill_Defias_Trappers_And_Smugglers"
kill 15 Defias Trapper##504 |q 12/1 |goto Westfall/0 48.85,46.57
kill 15 Defias Smuggler##95 |q 12/2 |goto Westfall/0 48.85,46.57
|mapmarker Westfall/0 48.19,38.62
|mapmarker Westfall/0 41.22,40.61
step
use Well Water Sample Kit##254545
collect Molsen Farm Water Sample##254547 |q 92742/2 |goto Westfall/0 46.06,38.16
step
talk Ozwin Ironsprocket##253395
|tip Inside the building.
accept Harvesting the Harvesters##92909 |goto Westfall/0 51.52,32.31
step
click Furlbrow's Wardrobe##290
|tip Stand outside the building here.
|tip Zoom your camera out.
|tip Angle your camera to see {o}Furlbrow's Wardrobe{}.
|tip Loot it from outside the building.
collect Furlbrow's Pocket Watch##841 |q 64/1 |goto Westfall/0 49.32,19.40
step
kill Riverpaw Gnoll##117, Riverpaw Shaman##1065, Riverpaw Scout##500
|tip Gnolls.
collect 8 Gnoll Paw##725 |q 102/1 |goto Westfall/0 43.68,16.73
|mapmarker Westfall/0 51.79,15.15
|mapmarker Westfall/0 56.89,13.39
stickystop "Collect_Stringy_Vulture_Meat"
stickystop "Collect_Goretusk_Snouts_And_Livers"
stickystop "Collect_Handfuls_Of_Oats"
step
kill Murloc Raider##515, Murloc Coastrunner##126
collect 3 Murloc Eye##730 |q 38/2 |goto Westfall/0 54.37,9.28
|tip Don't vendor them.
collect 7 Longshore Murloc Gill##254548 |q 92744/1 |goto Westfall/0 54.37,9.28
|mapmarker Westfall/0 44.36,9.63
stickystart "Collect_Stringy_Vulture_Meat"
stickystart "Collect_Goretusk_Snouts_And_Livers"
step
use Well Water Sample Kit##254545
collect Jansen Stead Water Sample##254546 |q 92742/1 |goto Westfall/0 56.62,18.62
step
label "Collect_Handfuls_Of_Oats"
click Sack of Oats##2724+
|tip Tan bags.
|tip Next to objects and buildings.
collect 8 Handful of Oats##1528 |q 151/1 |goto Westfall/0 56.60,18.40
|mapmarker Westfall/0 48.40,20.10
|mapmarker Westfall/0 49.00,34.10
|mapmarker Westfall/0 49.40,17.90
|mapmarker Westfall/0 50.60,25.30
|mapmarker Westfall/0 51.20,21.80
|mapmarker Westfall/0 51.20,39.20
|mapmarker Westfall/0 51.40,31.90
|mapmarker Westfall/0 51.70,19.30
|mapmarker Westfall/0 51.80,15.30
|mapmarker Westfall/0 53.20,29.10
|mapmarker Westfall/0 53.40,35.50
|mapmarker Westfall/0 54.00,24.90
|mapmarker Westfall/0 54.40,32.40
|mapmarker Westfall/0 55.10,30.10
|mapmarker Westfall/0 55.20,27.40
|mapmarker Westfall/0 56.10,35.30
|mapmarker Westfall/0 56.30,13.30
|mapmarker Westfall/0 58.40,16.00
|mapmarker Westfall/0 59.10,19.00
step
talk Farmer Furlbrow##237
turnin The Forgotten Heirloom##64 |goto Westfall 59.96,19.36
step
talk Verna Furlbrow##238
turnin Poor Old Blanchy##151 |goto Westfall 59.92,19.42
step
talk Salma Saldean##235
|tip Inside the building.
turnin Goretusk Liver Pie##22 |goto Westfall 56.42,30.52
|only if readyq(22) or completedq(22)
stickystop "Collect_Goretusk_Snouts_And_Livers"
stickystart "Kill_Harvest_Watchers"
stickystart "Collect_Goretusk_Snouts_And_Livers"
step
kill Harvest Watcher##114, Harvest Golem##36
|tip Mechanical golems.
|tip Multiple locations.
collect 3 Okra##732 |q 38/4 |goto Westfall/0 53.98,32.33
collect 5 Harvester Gyrostabilizer##255010 |q 92909/2 |goto Westfall/0 53.98,32.33
collect 15 Golem Isospring##255007 |q 92909/1 |goto Westfall/0 53.98,32.33
|tip Don't vendor them.
|mapmarker Westfall/0 51.22,22.11
|mapmarker Westfall/0 44.79,35.43
|mapmarker Westfall/0 38.67,51.50
step
label "Kill_Harvest_Watchers"
kill 20 Harvest Watcher##114 |q 9/1 |goto Westfall/0 53.98,32.33
|tip Multiple locations. |notinsticky
|mapmarker Westfall/0 51.22,22.11
|mapmarker Westfall/0 44.79,35.43
|mapmarker Westfall/0 38.67,51.50
step
label "Collect_Stringy_Vulture_Meat"
kill Fleshripper##1109, Young Fleshripper##199
|tip Vultures.
|tip Concentrated spawns around here. |notinsticky
|tip Spread out elsewhere. |notinsticky
collect 3 Stringy Vulture Meat##729 |q 38/1 |goto Westfall/0 61.60,44.60
|tip Don't vendor them.
|mapmarker Westfall/0 61.18,31.80
|mapmarker Westfall/0 53.62,19.53
|mapmarker Westfall/0 50.31,34.60
|mapmarker Westfall/0 53.00,41.62
step
label "Collect_Goretusk_Snouts_And_Livers"
kill Goretusk##157, Young Goretusk##454
|tip Boars.
collect 3 Goretusk Snout##731 |q 38/3 |goto Westfall/0 52.20,42.60
collect 8 Goretusk Liver##723 |q 22/1 |goto Westfall/0 52.20,42.60
|tip Don't vendor them.
|mapmarker Westfall/0 49.88,34.78
|mapmarker Westfall/0 61.22,32.03
|mapmarker Westfall/0 53.58,19.12
step
talk Ozwin Ironsprocket##253395
|tip Inside the building.
turnin Harvesting the Harvesters##92909 |goto Westfall/0 51.52,32.31
step
talk Farmer Saldean##233
turnin The Killing Fields##9 |goto Westfall 56.05,31.22
step
talk Salma Saldean##235
|tip Inside the building.
turnin Westfall Stew##38 |goto Westfall 56.42,30.52
turnin Goretusk Liver Pie##22 |goto Westfall 56.42,30.52
step
talk Gryan Stoutmantle##234
turnin The People's Militia##12 |goto Westfall/0 56.33,47.52
accept The Defias Brotherhood##65 |goto Westfall/0 56.33,47.52
step
talk Captain Danuvin##821
turnin Patrolling Westfall##102 |goto Westfall/0 56.42,47.62
step
talk Scout Galiaan##878
turnin Red Leather Bandanas##153 |goto Westfall/0 53.98,52.98
step
talk Alba Fairmoon##253092
|tip Inside the building.
turnin Testing the Wells##92742 |goto Westfall/0 52.48,52.95
turnin Murloc Gills##92744 |goto Westfall/0 52.48,52.95
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 983 |future
|only if Druid
step
talk Elsharin##5498
|tip Top of the tower.
Train Abilities |trainer Elsharin##5498 |goto Stormwind City/0 48.20,87.21 |q 983 |future
|only if Mage
step
Enter the building |goto Stormwind City/0 42.25,81.81 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Demisette Cloyce##461
|tip Downstairs inside the building.
Train Abilities |trainer Demisette Cloyce##461 |goto Stormwind City/0 39.25,84.96 |q 983 |future
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.52 |q 983 |future
|only if Warlock
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.06 |q 983 |future
|only if Paladin
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.64,46.42 |q 983 |future
|only if Priest
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 983 |future
|only if Rogue
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 983 |future
|only if Warrior
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 983 |future
|only if Hunter
step
talk Borgus Steelhand##7232
|tip Inside the building.
accept Business in Auberdine##97894 |goto Stormwind City/0 59.40,34.25
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 983 |future
|only if Shaman
step
talk Vesprystus##3838
fpath Rut'theran Village |goto Teldrassil 58.40,94.02
step
talk Ilyenia Moonfire##11866
Train Bows |complete weaponskill("BOW") > 0 |goto Darnassus 57.56,46.73
Train Staves |complete weaponskill("TH_STAFF") > 0 |goto Darnassus 57.56,46.73
|only if Hunter
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Darkshore (15-18)",{
image=ZGV.IMAGESDIR.."Darkshore",
hardcore = true,
next="Leveling Guides\\Loch Modan (18-19)",
},[[
step
talk Wizbang Cranktoggle##3666
|tip Upstairs inside the building.
accept Buzzbox 827##983 |goto Darkshore/0 36.98,44.14
step
talk Tharnariun Treetender##3701
accept Plagued Lands##2118 |goto Darkshore/0 38.84,43.42
step
talk Terenthis##3693
|tip Inside the building.
accept How Big a Threat?##984 |goto Darkshore/0 39.37,43.48
step
talk Gwennyth Bly'Leggonde##10219
accept Washed Ashore##3524 |goto Darkshore/0 36.62,45.59
step
talk Caylais Moonfeather##3841
fpath Auberdine |goto Darkshore/0 36.34,45.58
stickystart "Collect_Crawler_Legs"
step
click Beached Sea Creature
collect Sea Creature Bones##12242 |q 3524/1 |goto Darkshore 36.39,50.88
step
label "Collect_Crawler_Legs"
kill Pygmy Tide Crawler##2231, Young Reef Crawler##2234
|tip Crabs.
|tip More in the water. |notinsticky
collect 6 Crawler Leg##5385 |q 983/1 |goto Darkshore/0 36.65,53.82
step
Find a Corrupt Furbolg Camp |q 984/1 |goto Darkshore 38.95,53.57
step
use Tharnariun's Hope##7586
|tip On a Rabid Thistle Bear.
|tip Grey bears.
Capture a Rabid Thistle Bear |q 2118/1 |goto Darkshore/0 39.07,57.42
step
click Buzzbox 827
turnin Buzzbox 827##983 |goto Darkshore/0 36.66,46.26
accept Buzzbox 411##1001 |goto Darkshore/0 36.66,46.26
step
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##3524 |goto Darkshore/0 36.62,45.59
accept Washed Ashore##4681 |goto Darkshore/0 36.62,45.59
step
talk Cerellean Whiteclaw##3644
|tip On the dock.
accept For Love Eternal##963 |goto Darkshore 35.74,43.71
stickystart "Collect_Thresher_Eyes"
step
click Skeletal Sea Turtle
|tip Underwater.
collect Sea Turtle Remains##12289 |q 4681/1 |goto Darkshore/0 31.87,46.32
step
label "Collect_Thresher_Eyes"
kill Darkshore Thresher##2185+
|tip Long-neck dinosaurs.
|tip Underwater.
collect 3 Thresher Eye##5412 |q 1001/1 |goto Darkshore/0 32.99,48.68
step
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##4681 |goto Darkshore/0 36.62,45.59
step
talk Tharnariun Treetender##3701
turnin Plagued Lands##2118 |goto Darkshore/0 38.84,43.42
accept Cleansing of the Infected##2138 |goto Darkshore/0 38.84,43.42
step
talk Terenthis##3693
|tip Inside the building.
turnin How Big a Threat?##984 |goto Darkshore/0 39.37,43.48
accept How Big a Threat?##985 |goto Darkshore/0 39.37,43.48
accept Thundris Windweaver##4761 |goto Darkshore/0 39.37,43.48
step
talk Gorbold Steelhand##6301
turnin Business in Auberdine##97894 |goto Darkshore/0 38.11,41.17
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin Thundris Windweaver##4761 |goto Darkshore/0 37.40,40.13
accept The Cliffspring River##4762 |goto Darkshore/0 37.40,40.13
accept Bashal'Aran##954 |goto Darkshore/0 37.40,40.13
accept Tools of the Highborne##958 |goto Darkshore/0 37.40,40.13
step
talk Sentinel Glynda Nal'Shea##2930
|tip Walks around.
accept The Red Crystal##4811 |goto Darkshore/0 37.70,43.39
step
talk Innkeeper Shaussiy##6737
|tip Inside the building.
home Auberdine |goto Darkshore/0 37.04,44.12
stickystart "Collect_Small_Eggs"
stickystart "Collect_Strider_Meat"
step
Locate the Large, Red Crystal on Darkshore's Eastern Mountain Range |q 4811/1 |goto Darkshore/0 47.32,48.66
|tip Up on the hill.
step
label "Collect_Small_Eggs"
kill Moonkin##10158, Raging Moonkin##10160, Moonkin Oracle##10157, Young Moonkin##10159
|tip Owlkins.
collect 9 Small Egg##6889 |goto Darkshore/0 44.40,47.20 |q 2178 |future
|tip Don't vendor them.
|mapmarker Darkshore/0 41.40,47.00
|mapmarker Darkshore/0 42.20,50.80
|mapmarker Darkshore/0 43.00,44.40
|mapmarker Darkshore/0 44.60,53.40
|mapmarker Darkshore/0 45.20,50.20
|mapmarker Darkshore/0 46.00,44.40
|only if skillmax("Cooking") > 1 and skill("Cooking") < 10
step
talk Asterion##3650
turnin Bashal'Aran##954 |goto Darkshore/0 44.17,36.29
accept Bashal'Aran##955 |goto Darkshore/0 44.17,36.29
stickystop "Collect_Strider_Meat"
step
kill Wild Grell##2190, Vile Sprite##2189
|tip Imps.
|tip Try not to kill {o}satyrs{}.
|tip Needed for next quest.
collect 8 Grell Earring##5336 |q 955/1 |goto Darkshore/0 46.19,37.85
step
talk Asterion##3650
turnin Bashal'Aran##955 |goto Darkshore/0 44.17,36.29
accept Bashal'Aran##956 |goto Darkshore/0 44.17,36.29
step
kill Deth'ryll Satyr##2212+
|tip Satyrs.
collect Ancient Moonstone Seal##5338 |q 956/1 |goto Darkshore/0 46.41,37.66
step
talk Asterion##3650
turnin Bashal'Aran##956 |goto Darkshore/0 44.17,36.30
accept Bashal'Aran##957 |goto Darkshore/0 44.17,36.30
stickystart "Collect_Strider_Meat"
step
click Beached Sea Creature##175233
accept Beached Sea Creature##4723 |goto Darkshore 41.88,31.55
step
click Buzzbox 411##17183
turnin Buzzbox 411##1001 |goto Darkshore 41.96,28.64
accept Buzzbox 323##1002 |goto Darkshore 41.96,28.64
stickystart "Collect_Moonstalker_Fangs"
stickystart "Kill_Rabid_Thistle_Bears"
step
click Beached Sea Turtle##176197
accept Beached Sea Turtle##4725 |goto Darkshore 44.21,20.64
step
label "Collect_Strider_Meat"
kill Foreststrider Fledgling##2321+
|tip Large walking birds.
collect 5 Strider Meat##5469 |goto Darkshore/0 46.00,33.00 |q 2178 |future
|tip Don't vendor them.
|mapmarker Darkshore/0 38.40,33.20
|mapmarker Darkshore/0 38.40,36.40
|mapmarker Darkshore/0 39.80,39.60
|mapmarker Darkshore/0 40.40,43.00
|mapmarker Darkshore/0 41.40,34.80
|mapmarker Darkshore/0 42.00,27.00
|mapmarker Darkshore/0 43.00,23.40
|mapmarker Darkshore/0 43.00,40.60
|mapmarker Darkshore/0 43.40,31.40
|mapmarker Darkshore/0 43.40,44.40
|mapmarker Darkshore/0 45.80,22.00
|mapmarker Darkshore/0 45.80,42.40
|mapmarker Darkshore/0 45.00,27.40
|mapmarker Darkshore/0 47.40,39.80
|mapmarker Darkshore/0 49.00,22.60
step
label "Collect_Moonstalker_Fangs"
kill Moonstalker Runt##2070, Moonstalker##2069
|tip Black tigers.
collect 6 Moonstalker Fang##5413 |q 1002/1 |goto Darkshore/0 48.40,31.00
step
label "Kill_Rabid_Thistle_Bears"
kill 20 Rabid Thistle Bear##2164 |q 2138/1 |goto Darkshore/0 49.65,28.26
step
click Buzzbox 323
turnin Buzzbox 323##1002 |goto Darkshore 51.28,24.58
step
use Empty Sampling Tube##12350
|tip In the water.
|tip Bottom of the waterfall.
collect Cliffspring River Sample##12349 |q 4762/1 |goto Darkshore/0 50.84,25.50
step
click Beached Sea Turtle##176196
accept Beached Sea Turtle##4727 |goto Darkshore 53.09,18.15
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 26 |future
|only if Druid
step
talk Mathrengyl Bearwalker##4217
|tip {o}Middle floor{} inside the building.
accept A Lesson to Learn##26 |goto Darnassus 35.37,8.39
accept Lessons Anew##6121 |goto Darnassus 35.37,8.39
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin A Lesson to Learn##26 |goto Moonglade 56.21,30.64
accept Trial of the Lake##29 |goto Moonglade 56.21,30.64
turnin Lessons Anew##6121 |goto Moonglade 56.21,30.64
accept The Principal Source##6122 |goto Moonglade 56.21,30.64
|only if Druid
step
click Bauble Container
|tip Wicker basket vase.
|tip Underwater.
|tip Multiple locations.
collect Shrine Bauble##15877 |goto Moonglade/0 54.70,46.50 |q 29
|mapmarker Moonglade/0 48.00,47.10
|mapmarker Moonglade/0 50.10,50.60
|mapmarker Moonglade/0 52.10,53.40
|mapmarker Moonglade/0 52.90,48.50
|mapmarker Moonglade/0 54.10,50.00
|mapmarker Moonglade/0 54.20,55.60
|mapmarker Moonglade/0 54.20,55.60
|mapmarker Moonglade/0 56.20,53.60
|mapmarker Moonglade/0 58.40,50.90
|mapmarker Moonglade/0 60.50,58.30
|only if Druid
step
use Shrine Bauble##15877
Complete the Trial of the Lake |q 29/1 |goto Moonglade 35.92,41.38
|only if Druid
step
talk Tajarri##11799
turnin Trial of the Lake##29 |goto Moonglade 36.51,40.11
accept Trial of the Sea Lion##272 |goto Moonglade 36.51,40.11
|only if Druid
step
talk Gwennyth Bly'Leggonde##10219
turnin Beached Sea Creature##4723 |goto Darkshore/0 36.62,45.60
turnin Beached Sea Turtle##4725 |goto Darkshore/0 36.62,45.60
turnin Beached Sea Turtle##4727 |goto Darkshore/0 36.62,45.60
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 4811
|only if Warrior
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 4811
|only if Rogue
step
talk Jocaste##4146
|tip Upstairs inside the building.
Train Abilities |trainer Jocaste##4146 |goto Darnassus/0 40.38,8.54 |q 4811
|only if Hunter
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 4811
|only if Priest
step
click WANTED: Murkdeep!
accept WANTED: Jai'vhanel##98025 |goto Darkshore/0 37.23,44.23
step
talk Sentinel Glynda Nal'Shea##2930
|tip Walks around.
turnin The Red Crystal##4811 |goto Darkshore/0 37.71,43.39
accept As Water Cascades##4812 |goto Darkshore/0 37.71,43.39
step
use Empty Water Tube##14338
collect Moonwell Water Tube##14339 |q 4812/1 |goto Darkshore/0 37.79,44.05
step
talk Gorbold Steelhand##6301
buy 9 Mild Spices##2678 |goto Darkshore/0 38.11,41.17 |q 2178 |future
|only if skillmax("Cooking") > 1 and skill("Cooking") < 10
step
skill Cooking,10 |goto Darkshore/0 37.54,41.70 |q 2178 |future
|tip Create {o}Herb Baked Eggs{}.
|tip Needed for a quest soon.
|only if skillmax("Cooking") > 1 and skill("Cooking") < 10
step
talk Alanndarian Nightsong##3702
|tip Inside the building.
accept Easy Strider Living##2178 |goto Darkshore/0 37.69,40.66
|only if skill("Cooking") >= 10
step
talk Alanndarian Nightsong##3702
|tip Inside the building.
turnin Easy Strider Living##2178 |goto Darkshore/0 37.69,40.66
|only if skill("Cooking") >= 10
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin The Cliffspring River##4762 |goto Darkshore/0 37.40,40.13
step
talk Tharnariun Treetender##3701
turnin Cleansing of the Infected##2138 |goto Darkshore/0 38.84,43.41
step
click Mysterious Red Crystal##175524
|tip Up on the hill.
turnin As Water Cascades##4812 |goto Darkshore/0 47.32,48.66
accept The Fragments Within##4813 |goto Darkshore/0 47.32,48.66
step
talk Sentinel Tysha Moonblade##3639
accept The Fall of Ameth'Aran##953 |goto Darkshore/0 40.30,59.73
stickystart "Collect_Anyas_Pendant"
stickystart "Collect_Highborne_Relics"
step
click Lay of Ameth'Aran
Read the Lay of Ameth'Aran |q 953/1 |goto Darkshore/0 43.31,58.70
step
kill Jai'vhanel##270196
|tip Larger owl.
|tip Flies around.
collect Feather of Jai'vhanel##281038 |q 98025/1 |goto Darkshore/0 45.21,58.48
step
click Ancient Flame
Destroy the Seal at the Ancient Flame |q 957/1 |goto Darkshore/0 42.37,61.79
step
click Fall of Ameth'Aran
Read the Fall of Ameth'Aran |q 953/2 |goto Darkshore/0 42.67,63.10
step
label "Collect_Anyas_Pendant"
kill Anaya Dawnrunner##3667
|tip Neutral female night elf ghost.
|tip Wearing a green and yellow robe.
|tip Walks around.
|tip Multiple locations.
collect Anaya's Pendant##5382 |q 963/1 |goto Darkshore/0 42.40,60.40
step
label "Collect_Highborne_Relics"
kill Cursed Highborne##2176, Writhing Highborne##2177, Wailing Highborne##2178
collect 7 Highborne Relic##5360 |q 958/1 |goto Darkshore/0 42.68,60.39
step
talk Sentinel Tysha Moonblade##3639
turnin The Fall of Ameth'Aran##953 |goto Darkshore 40.30,59.73
step
click Beached Sea Creature##175226
accept Beached Sea Creature##4728 |goto Darkshore 36.06,70.86
step
click Beached Sea Turtle
accept Beached Sea Turtle##4722 |goto Darkshore/0 37.14,62.16
step
kill 5 Blackwood Windtalker##2324 |q 985/2 |goto Darkshore/0 39.67,54.31
kill 8 Blackwood Pathfinder##2167 |q 985/1 |goto Darkshore/0 39.67,54.31
step
talk Gwennyth Bly'Leggonde##10219
turnin Beached Sea Creature##4728 |goto Darkshore/0 36.62,45.60
turnin Beached Sea Turtle##4722 |goto Darkshore/0 36.62,45.60
step
talk Gubber Blump##10216
accept Fruit of the Sea##1138 |goto Darkshore 36.09,44.93
step
talk Cerellean Whiteclaw##3644
|tip On the dock.
turnin For Love Eternal##963 |goto Darkshore/0 35.74,43.71
step
talk Sentinel Glynda Nal'Shea##2930
|tip Walks around.
turnin The Fragments Within##4813 |goto Darkshore/0 37.71,43.39
turnin WANTED: Jai'vhanel##98025 |goto Darkshore/0 37.71,43.39
step
talk Terenthis##3693
|tip Inside the building.
turnin How Big a Threat?##985 |goto Darkshore/0 39.37,43.48
step
talk Sentinel Elissa Starbreeze##3657
|tip Upstairs inside the building.
accept The Tower of Althalaxx##965 |goto Darkshore 39.05,43.55
step
talk Gorbold Steelhand##6301
accept Deep Ocean, Vast Sea##982 |goto Darkshore 38.11,41.17
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin Tools of the Highborne##958 |goto Darkshore/0 37.40,40.13
step
talk Asterion##3650
turnin Bashal'Aran##957 |goto Darkshore/0 44.17,36.30
step
click Silver Dawning's Lockbox
|tip {o}Very bottom{} inside the sunken ship.
|tip Swim through a window.
collect Silver Dawning's Lockbox##12191 |q 982/1 |goto Darkshore 38.24,28.80
step
click Mist Veil's Lockbox
|tip {o}Very bottom{} inside the sunken ship.
|tip Swim through a window.
collect Mist Veil's Lockbox##12192 |q 982/2 |goto Darkshore 39.63,27.46
stickystart "Collect_Fine_Crab_Chunks"
step
click Strange Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Agility##15883 |goto Darkshore 48.87,11.32 |q 272
|only if Druid
step
label "Collect_Fine_Crab_Chunks"
kill Reef Crawler##2235+
|tip Crabs.
collect 6 Fine Crab Chunks##12237 |q 1138/1 |goto Darkshore/0 48.65,21.07
step
talk Balthule Shadowstrike##3661
turnin The Tower of Althalaxx##965 |goto Darkshore 54.97,24.89
accept The Tower of Althalaxx##966 |goto Darkshore 54.97,24.89
step
kill Dark Strand Fanatic##2336+
collect 4 Worn Parchment##5348 |q 966/1 |goto Darkshore/0 56.39,26.77
step
talk Balthule Shadowstrike##3661
turnin The Tower of Althalaxx##966 |goto Darkshore 54.97,24.89
accept The Tower of Althalaxx##967 |goto Darkshore 54.97,24.89
step
Kill enemies
|tip Good time to train abilities soon.
ding 18 |goto Darkshore/0 56.39,26.77
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1138
|only if Druid
step
talk Gubber Blump##10216
turnin Fruit of the Sea##1138 |goto Darkshore 36.10,44.93
step
talk Gorbold Steelhand##6301
turnin Deep Ocean, Vast Sea##982 |goto Darkshore 38.11,41.17
step
talk Neal Allen##1448
|tip Walks around.
|tip Inside the building.
buy Bronze Tube##4371 |n
|tip If possible.
|tip Limited supply item.
|tip Needed later for Duskwood quest.
Visit the Vendor |vendor Neal Allen##1448 |goto Wetlands 10.75,56.75 |q 174 |future
|only if itemcount(4371) == 0
step
talk Shellei Brondir##1571
fpath Menethil Harbor |goto Wetlands 9.49,59.69
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 436 |future
|only if Mage
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 436 |future
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 436 |future
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
Train Pet Abilities |trainer Belia Thundergranite##10090 |goto Ironforge/0 70.86,85.84 |q 436 |future
|only if Hunter
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 436 |future
|only if Priest
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 436 |future
|only if Paladin
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 436 |future
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 436 |future
|only if Warlock
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 436 |future
|only if Rogue
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 436 |future
|only if Shaman
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Loch Modan (18-19)",{
image=ZGV.IMAGESDIR.."Loch Modan",
hardcore = true,
next="Leveling Guides\\Redridge & Westfall (19-20)",
},[[
step
click Discarded Fishing Toolbox
|tip Grey metal chest.
|tip Multiple locations.
|tip Underwater.
accept Silver of the Waves##86614 |goto Loch Modan/0 45.70,43.28
|mapmarker Loch Modan/0 48.00,39.70
|mapmarker Loch Modan/0 48.80,54.50
|mapmarker Loch Modan/0 50.60,53.40
step
talk Khara Deepwater##1684
|tip Walks around.
|tip Inside and outside the building.
turnin Silver of the Waves##86614 |goto Loch Modan/0 40.29,39.29
step
talk Jern Hornhelm##1105
|tip Walks around.
|tip Inside and outside the building.
accept Ironband's Excavation##436 |goto Loch Modan 37.24,47.39
stickystart "Collect_Miners_Gear"
step
kill Tunnel Rat Geomancer##1174+
|tip Inside the mine.
collect Fire Tar##5026 |q 94466/1 |goto Loch Modan/0 35.48,18.86
|only if Shaman
step
label "Collect_Miners_Gear"
click Miners' League Crates##271+
|tip Piles of brown boxes.
|tip Inside the mine. |notinsticky
collect 4 Miners' Gear##2640 |q 307/1 |goto Loch Modan/0 35.48,18.86
step
Leave the mine |goto Loch Modan/0 35.48,18.86 < 15 |walk |only if subzone("Silver Stream Mine") and indoors()
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Filthy Paws##307 |goto Loch Modan/0 24.76,18.39
step
Run up the ramp |goto Loch Modan/0 40.54,13.64 < 15 |only if walking
talk Chief Engineer Hinderweir VII##1093
|tip On the dam.
accept A Dark Threat Looms##250 |goto Loch Modan 46.05,13.62
step
click Suspicious Barrel##257
|tip Next to the wall.
turnin A Dark Threat Looms##250 |goto Loch Modan 56.05,13.24
accept A Dark Threat Looms##199 |goto Loch Modan 56.05,13.24
step
Run up the ramp |goto Loch Modan 55.39,14.84 < 15 |only if walking
talk Chief Engineer Hinderweir VII##1093
|tip On the dam.
turnin A Dark Threat Looms##199 |goto Loch Modan 46.05,13.62
step
_NOTE:_
During the Next Steps
|tip Kill enemies as you walk.
|tip Helps reduce grinding all at once soon.
|tip Grinding to avoid a few easy to fail timed quests.
|tip Less frustrating to just grind.
|tip Also, be careful to {o}avoid the group of 3 elite Horde enemies{}.		|only if hardcore{}
|tip They patrol around the right side of the lake.				|only if hardcore{}
Click Here to Continue |confirm |q 385 |future
step
talk Marek Ironheart##1154
|tip Inside the building.
accept Crocolisk Hunting##385 |goto Loch Modan/0 81.76,61.66
accept Twisting the Knife##86758 |goto Loch Modan/0 81.76,61.66
stickystart "Collect_Crocolisk_Skins_And_Meat"
step
kill Daggerfang##270693
|tip Crocolisk.
|tip Walks around.
|tip Spawns here.
collect Marek's Croc-Hunting Knife##279591 |q 86758/1 |goto Loch Modan/0 62.88,51.95
step
label "Collect_Crocolisk_Skins_And_Meat"
kill Loch Crocolisk##1693+
collect 6 Crocolisk Skin##2925 |q 385/2 |goto Loch Modan/0 54.49,38.45
collect 5 Crocolisk Meat##2924 |q 385/1 |goto Loch Modan/0 54.49,38.45
|tip Don't vendor them.
|mapmarker Loch Modan/0 54.76,54.81
step
talk Marek Ironheart##1154
|tip Inside the building.
turnin Crocolisk Hunting##385 |goto Loch Modan 81.75,61.66
turnin Twisting the Knife##86758 |goto Loch Modan 81.75,61.66
step
talk Daryl the Youngling##1187
|tip Inside the building.
accept A Hunter's Boast##257 |goto Loch Modan/0 83.49,65.37
step
kill 6 Mountain Buzzard##1194 |q 257/1 |goto Loch Modan/0 75.32,67.62
|tip {o}Hurry{}, timed quest.
step
talk Daryl the Youngling##1187
|tip Inside the building.
turnin A Hunter's Boast##257 |goto Loch Modan/0 83.49,65.37
accept A Hunter's Challenge##258 |goto Loch Modan/0 83.49,65.37
step
kill 5 Elder Mountain Boar##1192 |q 258/1 |goto Loch Modan/0 76.28,44.42
|tip {o}Hurry{}, timed quest.
|mapmarker Loch Modan/0 64.94,38.30
step
talk Daryl the Youngling##1187
|tip Inside the building.
turnin A Hunter's Challenge##258 |goto Loch Modan/0 83.49,65.37
step
Kill enemies
|tip Helps reach level 19 after quest turnins.
|tip Next quest can be tough.
ding 18,19060 |goto Loch Modan/0 75.60,50.20
|mapmarker Loch Modan/0 58.40,32.40
|mapmarker Loch Modan/0 59.20,38.40
|mapmarker Loch Modan/0 59.80,41.80
|mapmarker Loch Modan/0 60.60,35.40
|mapmarker Loch Modan/0 61.40,32.20
|mapmarker Loch Modan/0 62.20,45.80
|mapmarker Loch Modan/0 62.40,38.40
|mapmarker Loch Modan/0 62.80,41.60
|mapmarker Loch Modan/0 63.60,35.40
|mapmarker Loch Modan/0 65.40,43.60
|mapmarker Loch Modan/0 66.20,33.40
|mapmarker Loch Modan/0 66.20,38.40
|mapmarker Loch Modan/0 68.00,41.00
|mapmarker Loch Modan/0 68.40,44.60
|mapmarker Loch Modan/0 69.00,36.40
|mapmarker Loch Modan/0 71.00,39.00
|mapmarker Loch Modan/0 71.40,43.60
|mapmarker Loch Modan/0 73.20,48.20
|mapmarker Loch Modan/0 73.20,52.40
|mapmarker Loch Modan/0 74.00,40.40
|mapmarker Loch Modan/0 74.40,44.40
|mapmarker Loch Modan/0 76.20,38.20
|mapmarker Loch Modan/0 77.40,46.60
|mapmarker Loch Modan/0 77.80,43.00
|only if hardcore()
step
talk Magmar Fellhew##1345
turnin Ironband's Excavation##436 |goto Loch Modan 64.90,66.65
accept Gathering Idols##297 |goto Loch Modan 64.90,66.65
step
talk Prospector Ironband##1344
accept Excavation Progress Report##298 |goto Loch Modan 65.93,65.62
stickystart "Collect_Carved_Stone_Idols"
step
click Excavation Tools+
|tip Mining hammers.
collect Excavation Tools##278049 |n
use Excavation Tools##278049
accept Excavation Tools##86613 |goto Loch Modan/0 70.29,63.49
step
click Excavation Tools+
|tip Mining hammers.
collect 6 Excavation Tools##278049 |q 86613/1 |goto Loch Modan/0 70.29,63.49
step
label "Collect_Carved_Stone_Idols"
kill Berserk Trogg##1393, Stonesplinter Geomancer##1165, Stonesplinter Digger##1167
|tip Troggs.
collect 8 Carved Stone Idol##2636 |q 297/1 |goto Loch Modan/0 70.29,63.49
step
talk Prospector Ironband##1344
turnin Excavation Tools##86613 |goto Loch Modan/0 65.94,65.62
step
talk Magmar Fellhew##1345
turnin Gathering Idols##297 |goto Loch Modan 64.90,66.65
step
talk Jern Hornhelm##1105
|tip Walks around.
|tip Inside and outside the building.
turnin Excavation Progress Report##298 |goto Loch Modan 37.24,47.39
accept Report to Ironforge##301 |goto Loch Modan 37.24,47.39
step
Follow the road to the path here |goto Loch Modan 29.32,66.73 < 40 |only if walking and not subzone("Stonesplinter Valley")
kill Stonesplinter Seer##1166+
|tip Inside and outside the cave.
collect Reagent Pouch##6652 |q 94466/2 |goto Loch Modan/0 35.14,84.04
|only if Shaman
step
Leave the cave |goto Loch Modan/0 35.14,84.04 < 20 |walk |only if subzone("Stonesplinter Valley") and indoors()
Leave Stonesplinter Valley and follow the road |goto Loch Modan 30.57,69.69 < 30 |only if walking and subzone("Stonesplinter Valley")
Follow the path up |goto Loch Modan/0 32.10,58.53 < 20 |only if walking
talk Braldir Ashmantle##257808
|tip Top of the mountain.
turnin Call of Fire##94466 |goto Loch Modan/0 32.16,65.99
accept Call of Fire##94467 |goto Loch Modan/0 32.16,65.99
|only if Shaman
step
use Fire Sapta##6636
|tip Top of the mountain.
kill Minor Manifestation of Fire##5893
collect Glowing Ember##6655 |q 94467/1 |goto Loch Modan/0 31.90,64.34
|only if Shaman
step
click Brazier of the Dormant Flame##61934
|tip Top of the mountain.
turnin Call of Fire##94467 |goto Loch Modan/0 31.79,64.52
accept Call of Fire##94467 |goto Loch Modan/0 31.79,64.52
|only if Shaman
step
Follow the path up |goto Dun Morogh/0 86.90,46.97 < 20 |only if walking
talk Bruegs Kindleborn##257597
|tip Inside the small cave.
|tip Top of the mountain.
|tip Follow the road.
turnin Call of Fire##94467 |goto Dun Morogh/0 87.56,43.65
|only if Shaman
step
talk Prospector Stormpike##1356
turnin Report to Ironforge##301 |goto Ironforge/0 74.65,11.72
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Redridge & Westfall (19-20)",{
image=ZGV.IMAGESDIR.."Redridge Mountains",
hardcore = true,
next="Leveling Guides\\Darkshore (20-21)",
},[[
step
talk Guard Parker##464
accept Encroaching Gnolls##244 |goto Redridge Mountains/0 10.37,71.26
step
talk Deputy Feldon##1070
|tip Walks around.
turnin Encroaching Gnolls##244 |goto Redridge Mountains/0 25.65,60.00
step
talk Ariena Stormfeather##931
fpath Lakeshire |goto Redridge Mountains 25.50,59.41
step
talk Foreman Oslow##341
accept The Lost Tools##125 |goto Redridge Mountains 27.05,48.64
step
talk Verner Osgood##415
accept The Price of Shoes##118 |goto Redridge Mountains 25.89,47.28
step
talk Magistrate Solomon##344
|tip Inside the building.
accept Messenger to Stormwind##120 |goto Redridge Mountains 24.90,44.45
step
talk Darcy##379
|tip Walks around.
|tip Inside the building.
accept A Free Lunch##129 |goto Redridge Mountains 21.66,44.35
step
talk Wiley the Black##266
|tip Upstairs inside the building.
turnin The Defias Brotherhood##65 |goto Redridge Mountains 21.39,45.35
accept The Defias Brotherhood##132 |goto Redridge Mountains 21.39,45.35
step
talk Shawn##8965
accept Hilary's Necklace##3741 |goto Redridge Mountains 24.23,53.63
step
click Glinting Mud##154357
|tip Large brown pile of dirt.
|tip Underwater.
collect Hilary's Necklace##10958 |q 3741/1 |goto Redridge Mountains/0 23.25,53.36
step
talk Hilary##8962
turnin Hilary's Necklace##3741 |goto Redridge Mountains 24.15,53.63
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##132 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##135 |goto Westfall 56.33,47.52
step
talk General Marcus Jonathan##466
turnin Messenger to Stormwind##120 |goto Stormwind City 69.14,82.71
accept Messenger to Stormwind##121 |goto Stormwind City 69.14,82.71
step
talk Olivia Burnside##2455 |goto Stormwind City 57.53,72.33
Select _"I would like to check my deposit box."_ |gossip 95532
collect 5 Flask of Oil##814 |q 103 |future
|only if itemcount(814) < 5 and itembanked(814) > 0
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin The Defias Brotherhood##135 |goto Stormwind City 78.26,70.73
accept The Defias Brotherhood##141 |goto Stormwind City 78.26,70.73
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##141 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##142 |goto Westfall 56.33,47.52
step
kill Harvest Watcher##114+
|tip Multiple locations.
collect 5 Flask of Oil##814 |goto Westfall/0 53.40,34.60 |q 103 |future
|tip Don't vendor them.
|mapmarker Westfall/0 51.22,22.11
|mapmarker Westfall/0 44.79,35.43
|mapmarker Westfall/0 38.67,51.50
step
map Westfall
path follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	44.53,24.94	44.27,27.96	42.97,29.29	41.82,30.90	41.18,33.12
path	40.47,34.41	39.61,35.04	38.26,36.41	37.74,37.42	36.95,40.48
path	36.88,42.27	36.63,43.26	36.29,43.92	35.55,43.89	32.99,42.88
path	31.45,44.43	32.66,43.01	33.65,43.02	35.26,43.75	37.22,44.73
path	37.83,45.59	38.48,45.34	40.57,48.15	41.68,50.33	42.05,52.53
path	43.11,54.32	43.48,59.14	44.70,64.06	45.61,64.97	45.50,66.47
path	45.89,67.80	45.50,68.91	44.50,69.60
kill Defias Messenger##550
|tip Walks a large path along the road.
|tip Also walks deep into {o}Gold Coast Quarry{} and {o}Jangolode Mine{}.
collect A Mysterious Message##1381 |q 142/1
Spawns at [Westfall/0 44.50,69.60] |noway
step
talk Captain Grayson##392
accept Keeper of the Flame##103 |goto Westfall/0 30.01,86.02
accept The Coastal Menace##104 |goto Westfall/0 30.01,86.02
step
talk Captain Grayson##392
turnin Keeper of the Flame##103 |goto Westfall/0 30.01,86.02
step
kill Old Murk-Eye##391
|tip Larger grey murloc.
|tip Walks along the beach.
collect Scale of Old Murk-Eye##3636 |q 104/1 |goto Westfall/0 32.40,82.60
|mapmarker Westfall/0 26.00,66.40
|mapmarker Westfall/0 26.40,68.80
|mapmarker Westfall/0 28.00,72.80
|mapmarker Westfall/0 28.40,74.80
|mapmarker Westfall/0 28.60,69.20
|mapmarker Westfall/0 29.40,77.00
|mapmarker Westfall/0 29.40,80.20
|mapmarker Westfall/0 30.40,82.60
|mapmarker Westfall/0 34.00,84.60
|mapmarker Westfall/0 34.80,82.40
step
talk Captain Grayson##392
turnin The Coastal Menace##104 |goto Westfall/0 30.01,86.02
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##142 |goto Westfall/0 56.33,47.52
step
talk The Defias Traitor##467
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept The Defias Brotherhood##155 |goto Westfall/0 55.68,47.50 |noautoaccept inparty
step
Escort The Defias Traitor to Discover Where VanCleef is Hiding |q 155/1 |goto Westfall/0 42.55,71.57
|tip Follow and protect The Defias Traitor.
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##155 |goto Westfall 56.33,47.52
step
talk Deputy Feldon##1070
|tip Walks around.
accept Assessing the Threat##246 |goto Redridge Mountains/0 25.65,60.00
accept Show of Force##98407 |goto Redridge Mountains/0 25.65,60.00
step
talk Guard Parker##464
|tip Walks around.
turnin A Free Lunch##129 |goto Redridge Mountains/0 10.37,71.26
accept Visit the Herbalist##130 |goto Redridge Mountains/0 10.37,71.26
stickystart "Kill_Redridge_Poachers"
stickystart "Kill_Redridge_Mongrels"
step
kill Redridge Thrasher##712+
collect 5 Spiked Collar##280911 |q 98407/1 |goto Redridge Mountains/0 25.99,81.81
|mapmarker Redridge Mountains/0 10.53,63.37
step
label "Kill_Redridge_Poachers"
kill 6 Redridge Poacher##424 |q 246/2 |goto Redridge Mountains/0 25.99,81.81
|mapmarker Redridge Mountains/0 37.87,70.26
step
label "Kill_Redridge_Mongrels"
kill 10 Redridge Mongrel##423 |q 246/1 |goto Redridge Mountains/0 25.99,81.81
|mapmarker Redridge Mountains/0 37.87,70.26
|mapmarker Redridge Mountains/0 10.53,63.37
step
Kill enemies
|tip Helps reach level 20 after quest turnins.
|tip Good time to train abilities soon.
ding 19,19400 |goto Redridge Mountains/0 25.99,81.81
|mapmarker Redridge Mountains/0 37.87,70.26
|mapmarker Redridge Mountains/0 10.53,63.37
step
talk Deputy Feldon##1070
|tip Walks around.
turnin Assessing the Threat##246 |goto Redridge Mountains/0 25.65,60.00
turnin Show of Force##98407 |goto Redridge Mountains/0 25.65,60.00
step
Enter the building |goto Stormwind City/0 42.25,81.81 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
accept Devourer of Souls##1716 |goto Stormwind City 39.23,85.22
|only if Warlock
step
talk Demisette Cloyce##461
|tip Downstairs inside the building.
Train Abilities |trainer Demisette Cloyce##461 |goto Stormwind City/0 39.25,84.96 |q 97234 |future
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.52 |q 97234 |future
|only if Warlock
step
talk Elsharin##5498
|tip Top of the tower.
Train Abilities |trainer Elsharin##5498 |goto Stormwind City/0 48.20,87.21 |q 97234 |future
|only if Mage
step
talk Larimaine Purdue##2485
|tip Upstairs inside the tower.
learnspell Teleport: Stormwind##3561 |goto Stormwind City 50.50,85.91
|only if Mage
step
talk Roy Lewells##268568
|tip Inside the building.
accept Reading Room##97234 |goto Stormwind City/0 38.84,62.33
step
talk Sheldras Moontree##5504
Train Abilities |trainer Sheldras Moontree##5504 |goto Stormwind City/0 35.86,67.36 |q 97234
|only if Druid
step
talk Argos Nightwhisper##4984
accept The Corruption Abroad##3765 |goto Stormwind City/0 36.25,67.60
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Duthorian Rall##6171
|tip Inside the building.
accept The Tome of Valor##1793 |goto Stormwind City 50.47,47.47 |instant
|only if Paladin
step
use Tome of Valor##6776
accept The Tome of Valor##1649
|only if Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Valor##1649 |goto Stormwind City 50.47,47.47
|only if Paladin
step
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.06 |q 97234
|only if Paladin
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.64,46.42 |q 97234
|only if Priest
step
talk Brother Kristoff##1444
accept Speaking of Fortitude##343 |goto Stormwind City/0 55.03,54.17
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 97234
|only if Hunter
step
talk Karrina Mekenda##2879
|tip Inside the building.
Train Pet Abilities |trainer Karrina Mekenda##2879 |goto Stormwind City/0 67.29,36.79 |q 97234
|only if Hunter
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 97234
|only if Rogue
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
accept Mathias and the Defias##2360 |goto Stormwind City 78.26,70.74
|only if Rogue
step
talk Renzik "The Shiv"##6946
|tip Upstairs inside the building.
accept Redridge Rendezvous##2281 |goto Stormwind City 78.25,71.13
|only if Rogue
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 97234
|only if Warrior
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 97234
|only if Shaman
step
Enter Stormwind Keep |goto Stormwind City 73.09,46.62 < 15 |walk |only if not subzone("Stormwind Keep")
talk Donyal Tovald##2504
|tip Inside the building.
turnin Reading Room##97234 |goto Stormwind City/0 75.06,30.12
accept Shelf Picked##97237 |goto Stormwind City/0 75.06,30.12
step
click Trollbane Conquests
|tip Green book.
|tip Inside the building.
collect Trollbane Conquests##277194 |q 97237/2 |goto Stormwind City/0 75.62,30.49
step
click Field Accounts of Horde Razings
|tip White scroll on the floor.
|tip Inside the building.
collect Field Accounts of Horde Razings##277196 |q 97237/1 |goto Stormwind City/0 76.06,30.96
step
click The Forsaken Ally
|tip Red book.
|tip Inside the building.
collect The Forsaken Ally##277195 |q 97237/3 |goto Stormwind City/0 76.43,30.44
step
click Cycles of Morality
|tip Black book.
|tip Inside the building.
collect Cycles of Morality##277197 |q 97237/4 |goto Stormwind City/0 76.28,29.17
step
talk Milton Sheaf##1440
|tip Inside the building.
turnin Speaking of Fortitude##343 |goto Stormwind City/0 77.07,30.21
step
talk Roy Lewells##268568
|tip Inside the building.
turnin Shelf Picked##97237 |goto Stormwind City/0 38.84,62.33
step
talk Smith Argus##514
|tip Inside the building.
turnin The Price of Shoes##118 |goto Elwynn Forest/0 41.71,65.55
accept Return to Verner##119 |goto Elwynn Forest/0 41.71,65.55
step
talk Theocritus##313
|tip Top of the tower.
accept A Watchful Eye##94 |goto Elwynn Forest 65.22,69.71
step
click Sunken Chest##32
|tip Underwater.
collect Oslow's Toolbox##1309 |q 125/1 |goto Redridge Mountains 36.44,54.67
step
talk Foreman Oslow##341
turnin The Lost Tools##125 |goto Redridge Mountains 27.05,48.64
accept The Everstill Bridge##89 |goto Redridge Mountains 27.05,48.64
step
talk Verner Osgood##415
turnin Return to Verner##119 |goto Redridge Mountains/0 25.88,47.27
accept Underbelly Scales##122 |goto Redridge Mountains/0 25.88,47.27
accept A Baying of Gnolls##124 |goto Redridge Mountains/0 25.88,47.27
step
kill Black Dragon Whelp##441+
|tip Small flying dragons.
collect 6 Underbelly Whelp Scale##1221 |q 122/1 |goto Redridge Mountains 31.31,74.60
|mapmarker Redridge Mountains/0 18.11,63.20
|mapmarker Redridge Mountains/0 20.71,80.00
|mapmarker Redridge Mountains/0 21.71,76.40
|mapmarker Redridge Mountains/0 23.11,63.80
|mapmarker Redridge Mountains/0 24.31,73.40
|mapmarker Redridge Mountains/0 26.31,69.40
|mapmarker Redridge Mountains/0 26.31,75.80
|mapmarker Redridge Mountains/0 27.31,61.40
|mapmarker Redridge Mountains/0 27.91,64.60
|mapmarker Redridge Mountains/0 29.11,68.20
|mapmarker Redridge Mountains/0 29.31,72.20
|mapmarker Redridge Mountains/0 30.91,64.20
|mapmarker Redridge Mountains/0 39.31,76.00
|mapmarker Redridge Mountains/0 42.31,75.40
|mapmarker Redridge Mountains/0 45.11,77.40
|mapmarker Redridge Mountains/0 45.31,73.20
|mapmarker Redridge Mountains/0 48.91,74.80
|mapmarker Redridge Mountains/0 51.91,73.40
|mapmarker Redridge Mountains/0 53.11,79.20
|mapmarker Redridge Mountains/0 55.51,74.80
|mapmarker Redridge Mountains/0 56.11,78.40
|mapmarker Redridge Mountains/0 60.71,75.20
step
talk Verner Osgood##415
turnin Underbelly Scales##122 |goto Redridge Mountains/0 25.88,47.27
step
talk Magistrate Solomon##344
|tip Inside the building.
turnin Messenger to Stormwind##121 |goto Redridge Mountains 24.90,44.45
step
talk Martie Jainrose##342
turnin Visit the Herbalist##130 |goto Redridge Mountains 16.77,46.33
accept Delivering Daffodils##131 |goto Redridge Mountains 16.77,46.33
step
talk Darcy##379
|tip Walks around.
|tip Inside the building.
turnin Delivering Daffodils##131 |goto Redridge Mountains 21.66,44.34
stickystart "Kill_Redridge_Mystics_And_Brutes"
step
kill Redridge Mystic##430, Redridge Brute##426
|tip Gnolls.
|tip {o}Redridge Alphas{} won't drop them.
collect 5 Iron Pike##2856 |q 89/1 |goto Redridge Mountains/0 18.08,37.27
collect 5 Iron Rivet##1013 |q 89/2 |goto Redridge Mountains/0 18.08,37.27
|mapmarker Redridge Mountains/0 33.35,34.00
step
label "Kill_Redridge_Mystics_And_Brutes"
kill 8 Redridge Mystic##430 |q 124/2 |goto Redridge Mountains/0 18.08,37.27
kill 10 Redridge Brute##426 |q 124/1 |goto Redridge Mountains/0 18.08,37.27
|mapmarker Redridge Mountains/0 33.35,34.00
step
talk Lucius##6966
turnin Redridge Rendezvous##2281 |goto Redridge Mountains 22.97,52.04
accept Alther's Mill##2282 |goto Redridge Mountains 22.97,52.04
|only if Rogue
step
click Practice Lockbox+
|tip Small grey metal chests.
|tip Inside the building.
Reach Skill 95 in Lockpicking |skill Lockpicking,95 |goto Redridge Mountains 46.89,45.22 |q 2282
|only if Rogue
step
click Lucius's Lockbox
|tip Inside the building.
collect Token of Thievery##7871 |q 2282/1 |goto Redridge Mountains 46.95,44.69
|only if Rogue
step
talk Verner Osgood##415
turnin A Baying of Gnolls##124 |goto Redridge Mountains/0 25.88,47.27
step
talk Foreman Oslow##341
turnin The Everstill Bridge##89 |goto Redridge Mountains 27.05,48.64
step
talk Lucius##6966
turnin Alther's Mill##2282 |goto Redridge Mountains 22.97,52.04
|only if Rogue
step
_Destroy This Item:_
|tip Not needed.
trash Certificate of Thievery##7907
|only if Rogue
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Darkshore (20-21)",{
image=ZGV.IMAGESDIR.."Darkshore",
hardcore = true,
next="Leveling Guides\\Ashenvale & Stonetalon Mountains (21-24)",
},[[
step
talk Barithras Moonshade##3583
accept Cave Mushrooms##947 |goto Darkshore 37.32,43.64
step
talk Gershala Nightwhisper##8997
turnin The Corruption Abroad##3765 |goto Darkshore/0 38.33,43.04
step
talk Tharnariun Treetender##3701
accept Tharnariun's Hope##2139 |goto Darkshore 38.84,43.42
step
talk Terenthis##3693
|tip Inside the building.
accept A Lost Master##986 |goto Darkshore 39.37,43.48
step
talk Thundris Windweaver##3649
|tip Inside the building.
accept The Blackwood Corrupted##4763 |goto Darkshore 37.40,40.13
step
talk Archaeologist Hollee##2913
accept The Absent Minded Prospector##729 |goto Darkshore 37.44,41.84
step
use Empty Cleansing Bowl##12346
collect Filled Cleansing Bowl##12347 |goto Darkshore 37.78,44.02 |q 4763
step
click Buzzbox 323
accept Buzzbox 525##1003 |goto Darkshore 51.28,24.58
step
talk Gelkak Gyromast##6667
accept Gyromast's Retrieval##2098 |goto Darkshore 56.65,13.48
stickystart "Collect_Bottom_Of_Gelkaks_Key"
step
kill Greymist Tidehunter##2208, Greymist Oracle##2207
|tip Murlocs.
|tip Underwater.
collect Middle of Gelkak's Key##7499 |q 2098/2 |goto Darkshore 54.95,12.16
step
label "Collect_Bottom_Of_Gelkaks_Key"
kill Raging Reef Crawler##2236, Encrusted Tide Crawler##2233
|tip Crabs.
collect Bottom of Gelkak's Key##7500 |q 2098/3 |goto Darkshore/0 54.76,17.34
stickystart "Collect_Fine_Moonstalker_Pelts"
step
kill Giant Foreststrider##2323+
|tip Large walking birds.
collect Top of Gelkak's Key##7498 |q 2098/1 |goto Darkshore/0 60.55,12.03
step
label "Collect_Fine_Moonstalker_Pelts"
kill Moonstalker Matriarch##2071, Moonstalker Sire##2237
|tip Black tigers.
collect 5 Fine Moonstalker Pelt##5386 |q 986/1 |goto Darkshore/0 61.41,9.81
step
talk Gelkak Gyromast##6667
turnin Gyromast's Retrieval##2098 |goto Darkshore 56.65,13.48
stickystart "Collect_Scaber_Stalks"
step
use Empty Cliffspring Falls Sampler##15844
|tip Entrance of the cave.
collect Filled Cliffspring Falls Sampler##15845 |q 6122/1 |goto Darkshore 54.93,33.32
|only if Druid
step
Enter the cave |goto Darkshore 54.97,33.37 < 20 |walk |only if not (subzone("Cliffspring Falls") and indoors())
click Death Cap
|tip Brown mushrooms.
|tip Upstairs inside the cave.
collect Death Cap##5270 |q 947/2 |goto Darkshore 55.75,36.19
step
label "Collect_Scaber_Stalks"
click Scaber Stalk##11714+
|tip Blue mushrooms.
|tip Inside the cave. |notinsticky
collect 5 Scaber Stalk##5271 |q 947/1 |goto Darkshore 54.97,33.37
step
Leave the cave |goto Darkshore 54.97,33.37 < 20 |walk |only if subzone("Cliffspring Falls") and indoors()
click Blackwood Fruit Stores
|tip May be attacked.
collect Blackwood Fruit Sample##12341 |goto Darkshore/0 52.87,33.38 |q 4763
step
Follow the path up |goto Darkshore 52.40,35.94 < 20 |only if walking
kill Den Mother##6788 |q 2139/1 |goto Darkshore 51.48,38.26
|tip Inside the small cave.
step
click Blackwood Grain Stores
|tip May be attacked.
collect Blackwood Grain Sample##12342 |goto Darkshore/0 50.67,34.99 |q 4763
step
click Blackwood Nut Stores
|tip May be attacked.
collect Blackwood Nut Sample##12343 |goto Darkshore 51.83,33.56 |q 4763
step
use Filled Cleansing Bowl##12347
kill Xabraxxis##10373
|tip Appears nearby.
click Xabraxxis' Demon Bag
|tip Appears on the ground.
collect Talisman of Corruption##12355 |q 4763/1 |goto Darkshore 52.41,33.44
step
talk Alanndarian Nightsong##3702
|tip Inside the building.
turnin The Principal Source##6122 |goto Darkshore 37.69,40.66
|only if Druid
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin The Blackwood Corrupted##4763 |goto Darkshore 37.40,40.13
step
_Destroy These Items:_
|tip Not needed.
trash Blackwood Fruit Sample##12341
trash Blackwood Grain Sample##12342
trash Blackwood Nut Sample##12343
trash Filled Cleansing Bowl##12347
step
talk Barithras Moonshade##3583
turnin Cave Mushrooms##947 |goto Darkshore 37.32,43.64
accept Onu##948 |goto Darkshore 37.32,43.64
step
click WANTED: Murkdeep!
accept WANTED: Murkdeep!##4740 |goto Darkshore 37.23,44.23
step
talk Tharnariun Treetender##3701
turnin Tharnariun's Hope##2139 |goto Darkshore 38.84,43.41
step
talk Terenthis##3693
|tip Inside the building.
turnin A Lost Master##986 |goto Darkshore 39.37,43.48
accept A Lost Master##993 |goto Darkshore 39.37,43.48
step
talk Onu##3616
turnin Grove of the Ancients##952 |goto Darkshore 43.55,76.29 |only if haveq(952) or completedq(952)
turnin Onu##948 |goto Darkshore 43.55,76.29
accept The Master's Glaive##944 |goto Darkshore 43.55,76.29
stickystart "Collect_Grizzled_Scalps"
step
kill Greymist Warrior##2205, Greymist Hunter##2206
|tip Murlocs.
|tip Groups of murlocs run appear near the water.
|tip They run into the camp.
|tip Stand away from the camp for safety.
kill Murkdeep##10323 |q 4740/1 |goto Darkshore 36.51,76.59
|tip Eventually appears.
stickystop "Collect_Grizzled_Scalps"
step
click Beached Sea Creature
accept Beached Sea Creature##4730 |goto Darkshore/0 32.73,80.82
step
click Beached Sea Turtle
|tip Careful to not pull multiple enemies.
accept Beached Sea Turtle##4731 |goto Darkshore/0 31.70,83.70
step
click Beached Sea Turtle
|tip Careful to not pull multiple enemies.
accept Beached Sea Turtle##4732 |goto Darkshore/0 31.27,85.54
step
click Beached Sea Creature
|tip Careful, enemies hidden by terrain.
|tip Try not pull multiple enemies.
accept Beached Sea Creature##4733 |goto Darkshore/0 31.29,87.54
stickystart "Collect_Grizzled_Scalps"
step
talk Prospector Remtravel##2917
|tip Escort quest.
|tip Wait until he respawns, if missing.
turnin The Absent Minded Prospector##729 |goto Darkshore 35.73,83.70
stickystop "Collect_Grizzled_Scalps"
step
_NOTE:_
Consider Skipping Escort Quest
|tip The escort quest in the next step can be very difficult.
|tip Find {o}1-2 players{} to help you.
|tip Otherwise, skip the quest.
Click Here to Continue |confirm |q 731 |future
|only if hardcore()
step
talk Prospector Remtravel##2917
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept The Absent Minded Prospector##731 |goto Darkshore 35.73,83.70 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect {o}Prospector Remtravel{}.
|tip He's weak and can die easily.
|tip Get enemies off him quckly.
|tip Troggs ambush {o}3 times{}.
Escort Prospector Remtravel |q 731/1 |goto Darkshore 35.73,83.70
|only if haveq(731) or completedq(731)
stickystart "Collect_Grizzled_Scalps"
step
Enter the Master's Glaive |q 944/1 |goto Darkshore/0 39.51,86.67
stickystop "Collect_Grizzled_Scalps"
step
use Phial of Scrying##5251
|tip On the table.
click Scrying Bowl
turnin The Master's Glaive##944 |goto Darkshore 38.53,86.17
accept The Twilight Camp##949 |goto Darkshore 38.53,86.17
step
_Destroy This Items:_
|tip Not needed.
trash Phial of Scrying##5251
step
click Twilight Tome
turnin The Twilight Camp##949 |goto Darkshore 38.54,86.05
accept Return to Onu##950 |goto Darkshore 38.54,86.05
accept It's All Fun and Games Until...##98042 |goto Darkshore 38.54,86.05
step
kill Twilight Disciple##2338, Twilight Thug##2339
collect Peerless Eye##279279 |q 98042/1 |goto Darkshore/0 38.89,86.73
step
talk Therylune##3584
|tip Escort quest.
|tip Wait until she respawns, if missing.
|tip Walks around.
accept Therylune's Escape##945 |goto Darkshore 38.64,87.34 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Therylune.
Escort Therylune Away from the Master's Glaive |q 945/1 |goto Darkshore 40.51,87.09
step
use Book: The Powers Below##5352
accept The Powers Below##968
|only if itemcount(5352) > 0
step
talk Volcor##3692
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Inside the small cave.
turnin A Lost Master##993 |goto Darkshore 45.01,85.30
accept Escape Through Stealth##995 |goto Darkshore 45.01,85.30				|only if hardcore()
accept Escape Through Force##994 |goto Darkshore 45.01,85.30 |noautoaccept inparty	|only if not hardcore()
step
Watch the dialogue
|tip Follow and protect Volcor.
|tip Let him get attacked first.
|tip Otherwise he won't stop to help you fight.
Help Volcor to the Road |q 994/1 |goto Darkshore 41.95,81.80
|only if not hardcore()
step
label "Collect_Grizzled_Scalps"
kill Grizzled Thistle Bear##2165+
collect 4 Grizzled Scalp##5414 |q 1003/1 |goto Darkshore/0 40.00,80.00
step
click Buzzbox 525##17185
turnin Buzzbox 525##1003 |goto Darkshore/0 41.40,80.56
step
talk Onu##3616
turnin Return to Onu##950 |goto Darkshore 43.56,76.29
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ashenvale & Stonetalon Mountains (21-24)",{
image=ZGV.IMAGESDIR.."Ashenvale",
hardcore = true,
next="Leveling Guides\\Wetlands (24-25)",
},[[
step
talk Delgren the Purifier##3663
turnin The Tower of Althalaxx##967 |goto Ashenvale 26.20,38.70
accept The Tower of Althalaxx##970 |goto Ashenvale 26.20,38.70
step
talk Orendil Broadleaf##3847
accept Bathran's Hair##1010 |goto Ashenvale 26.44,38.59
step
kill Dark Strand Cultist##3725, Dark Strand Adept##3728, Dark Strand Enforcer##3727, Dark Strand Excavator##3730, Dark Strand Assassin##3879
|tip Low drop rate.
collect Glowing Soul Gem##5366 |q 970/1 |goto Ashenvale 31.39,30.62
step
click Plant Bundle+
|tip Small grey straw bundles.
|tip Reduce {o}Ground Clutter{} setting to {o}1{}.
|tip In {o}System > Graphics{} game settings.
|tip Makes them easier to see.
collect 5 Bathran's Hair##5437 |q 1010/1 |goto Ashenvale/0 31.46,22.81
step
talk Orendil Broadleaf##3847
turnin Bathran's Hair##1010 |goto Ashenvale 26.44,38.59
accept Orendil's Cure##1020 |goto Ashenvale 26.44,38.59
step
talk Delgren the Purifier##3663
turnin The Tower of Althalaxx##970 |goto Ashenvale 26.20,38.70
accept The Tower of Althalaxx##973 |goto Ashenvale 26.20,38.70
step
talk Therysil##3585
turnin Therylune's Escape##945 |goto Ashenvale 22.65,51.91
step
talk Daelyshia##4267
|tip Follow the road.
fpath Astranaar |goto Ashenvale 34.41,47.99
step
talk Shindrell Swiftfire##3845
accept The Zoram Strand##1008 |goto Ashenvale 34.67,48.84
step
talk Sentinel Thenysil##4079
accept On Guard in Stonetalon##1070 |goto Ashenvale/0 34.89,49.79
step
talk Faldreas Goeth'Shael##3996
accept Journey to Stonetalon Peak##1056 |goto Ashenvale/0 35.76,49.10
step
talk Raene Wolfrunner##3691
|tip Inside the building.
accept Raene's Cleansing##991 |goto Ashenvale 36.62,49.58
accept Culling the Threat##1054 |goto Ashenvale 36.62,49.58
step
talk Maluressian##10052
Stable Your Pet |stablemaster Maluressian##10052 |goto Ashenvale 36.51,50.36 |q 1054
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 3){}.
|only if Hunter
step
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin Orendil's Cure##1020 |goto Ashenvale 37.37,51.79
step
Watch the dialogue
|tip Inside the building.
talk Pelturas Whitemoon##3894
accept Elune's Tear##1033 |goto Ashenvale 37.37,51.79
step
Learn the {y}Claw (Rank 3){} Pet Ability |learnspell Claw##2982 |goto Ashenvale 36.40,59.80 |q 1054
|tip Cast {o}Tame Beast{} on an {o}Ashenvale Bear{}.
|tip Brown bears.
|tip Kill enemies nearby.
|mapmarker Ashenvale/0 37.40,61.80
|mapmarker Ashenvale/0 38.80,63.80
|mapmarker Ashenvale/0 40.00,65.40
|mapmarker Ashenvale/0 40.80,61.80
|mapmarker Ashenvale/0 42.20,64.40
|mapmarker Ashenvale/0 42.40,58.40
|mapmarker Ashenvale/0 42.80,61.40
|only if Hunter
step
talk Maluressian##10052
Retrieve Your Pet |stablemaster Maluressian##10052 |goto Ashenvale 36.51,50.36 |q 1054
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 3){} to Your Pet |learnpetspell Claw##16829 |q 1054
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
Follow the road and enter the Barrens |goto The Barrens 48.99,5.39 < 30 |only if walking
talk Takar the Seer##6244
|tip Avoid the Crossroads.
turnin Devourer of Souls##1716 |goto The Barrens 49.31,57.10
accept Heartswood##1738 |goto The Barrens 49.31,57.10
|only if Warlock
step
talk Bragok##16227
fpath Ratchet |goto The Barrens 63.09,37.16
|only if Warlock
step
click Elune's Tear+
|tip White orbs.
collect Elune's Tear##5493 |q 1033/1 |goto Ashenvale 46.24,45.96
step
kill Dal Bloodclaw##3987
|tip Grey furbolg.
|tip Walks around.
collect Dal Bloodclaw's Skull##5544 |q 1054/1 |goto Ashenvale/0 39.56,36.31
|mapmarker Ashenvale/0 38.40,36.60
|mapmarker Ashenvale/0 35.40,32.40
|mapmarker Ashenvale/0 36.20,33.40
|mapmarker Ashenvale/0 36.20,36.60
|mapmarker Ashenvale/0 37.40,35.20
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Culling the Threat##1054 |goto Ashenvale 36.62,49.58
step
talk Innkeeper Kimlya##6738
|tip Inside the building.
home Astranaar |goto Ashenvale 36.99,49.22 |q 942 |future
step
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin Elune's Tear##1033 |goto Ashenvale 37.37,51.79
step
Watch the dialogue
|tip Inside the building.
talk Pelturas Whitemoon##3894
accept The Ruins of Stardust##1034 |goto Ashenvale 37.37,51.79
step
click Stardust Covered Bush+
|tip Bushes with white sparkles.
collect 5 Handful of Stardust##5494 |q 1034/1 |goto Ashenvale 33.42,67.36
step
Leave the Ruins of Stardust |goto Ashenvale 36.12,61.82 < 50 |only if walking and subzone("The Ruins of Stardust")
Enter Fire Scar Shrine and follow the path up |goto Ashenvale 28.39,60.88 < 50 |only if walking
kill Ilkrud Magthrull##3664
|tip Casts {b}Ilkrud's Guardians{} to summon guards.
|tip Interrupt if possible.
collect Ilkrud Magthrull's Tome##5533 |q 973/1 |goto Ashenvale 25.28,60.69
step
Leave Fire Scar Shrine |goto Ashenvale 28.39,60.88 < 50 |only if walking and subzone("Fire Scar Shrine")
talk Delgren the Purifier##3663
|tip Follow the road.
turnin The Tower of Althalaxx##973 |goto Ashenvale 26.20,38.70
step
click Heartswood
collect Heartswood##6912 |q 1738/1 |goto Ashenvale 31.49,31.45
|only if Warlock
step
click Teronis' Corpse
turnin Raene's Cleansing##991 |goto Ashenvale 20.31,42.33
accept Raene's Cleansing##1023 |goto Ashenvale 20.31,42.33
step
kill Saltspittle Puddlejumper##3737, Saltspittle Warrior##3739, Saltspittle Oracle##3742, Saltspittle Muckdweller##3740
|tip Murlocs.
collect Glowing Gem##5463 |q 1023/1 |goto Ashenvale/0 20.34,42.31
step
talk Talen##3846
|tip Run around the mountain.
accept The Ancient Statuette##1007 |goto Ashenvale 14.79,31.30
stickystart "Collect_Wrathtail_Heads"
step
click Ancient Statuette
collect Ancient Statuette##5424 |q 1007/1 |goto Ashenvale 14.20,20.64
step
talk Talen##3846
turnin The Ancient Statuette##1007 |goto Ashenvale 14.79,31.30
step
label "Collect_Wrathtail_Heads"
kill Wrathtail Wave Rider##3713, Wrathtail Sorceress##3717, Wrathtail Razortail##3712, Wrathtail Sea Witch##3715, Wrathtail Priestess##3944, Wrathtail Myrmidon##3711
|tip Nagas.
collect 20 Wrathtail Head##5490 |q 1008/1 |goto Ashenvale/0 14.88,22.47
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1023
|only if Druid
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Raene's Cleansing##1023 |goto Ashenvale 36.62,49.58
step
_Destroy This Item:_
|tip Not needed.
trash Teronis' Journal##5505
step
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin The Ruins of Stardust##1034 |goto Ashenvale 37.37,51.79
step
talk Shindrell Swiftfire##3845
turnin The Zoram Strand##1008 |goto Ashenvale 34.67,48.84
accept Pridewings of Stonetalon##1134 |goto Ashenvale 34.67,48.84
step
talk Gwennyth Bly'Leggonde##10219
turnin Beached Sea Creature##4730 |goto Darkshore/0 36.62,45.59
turnin Beached Sea Turtle##4731 |goto Darkshore/0 36.62,45.59
turnin Beached Sea Turtle##4732 |goto Darkshore/0 36.62,45.59
turnin Beached Sea Creature##4733 |goto Darkshore/0 36.62,45.59
step
talk Sentinel Glynda Nal'Shea##2930
|tip Walks around.
turnin WANTED: Murkdeep!##4740 |goto Darkshore 37.71,43.39
step
talk Archaeologist Hollee##2913
turnin The Absent Minded Prospector##731 |goto Darkshore/0 37.44,41.84 |only if haveq(731) or completedq(731)
accept The Absent Minded Prospector##741 |goto Darkshore/0 37.44,41.84 |only if haveq(731) or completedq(731)
accept Unrequited Love##98461 |goto Darkshore/0 37.44,41.84
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin It's All Fun and Games Until...##98042 |goto Darkshore/0 37.40,40.13
step
talk Terenthis##3693
|tip Inside the building.
turnin Escape Through Stealth##995 |goto Darkshore 39.37,43.48		|only if hardcore()
turnin Escape Through Force##994 |goto Darkshore 39.37,43.48		|only if not hardcore()
step
talk Chief Archaeologist Greywhisker##2912
|tip Outside the building.
turnin The Absent Minded Prospector##741 |goto Darnassus 31.25,84.50
accept The Absent Minded Prospector##942 |goto Darnassus 31.25,84.50
|only if haveq(741) or completedq(741)
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 1134
|only if Warrior
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 1134
|only if Rogue
step
talk Jocaste##4146
|tip Upstairs inside the building.
Train Abilities |trainer Jocaste##4146 |goto Darnassus/0 40.38,8.54 |q 1134
|only if Hunter
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 1134
|only if Priest
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 1134
|only if Mage
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 1134
|only if Paladin
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 1134
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 1134
|only if Warlock
step
Run through the tunnel to Stonetalon Mountains |goto Ashenvale 42.27,71.09 < 15 |only if walking and not zone("Stonetalon Mountains")
talk Kaela Shadowspear##4080
|tip Up on the cliff.
turnin On Guard in Stonetalon##1070 |goto Stonetalon Mountains 59.90,66.85
accept On Guard in Stonetalon##1085 |goto Stonetalon Mountains 59.90,66.85
step
talk Gaxim Rustfizzle##4077
turnin On Guard in Stonetalon##1085 |goto Stonetalon Mountains 59.52,67.15
accept A Gnome's Respite##1071 |goto Stonetalon Mountains 59.52,67.15
step
talk Ziz Fizziks##4201
|tip Inside the building.
accept Super Reaper 6000##1093 |goto Stonetalon Mountains 58.99,62.60
stickystart "Kill_Venture_Co_Loggers_And_Deforesters"
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
label "Kill_Venture_Co_Loggers_And_Deforesters"
kill 10 Venture Co. Logger##3989 |q 1071/1 |goto Stonetalon Mountains 66.60,55.00
kill 10 Venture Co. Deforester##3991 |q 1071/2 |goto Stonetalon Mountains 66.60,55.00
step
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Super Reaper 6000##1093 |goto Stonetalon Mountains 58.99,62.60
step
talk Gaxim Rustfizzle##4077
|tip Up on the cliff.
turnin A Gnome's Respite##1071 |goto Stonetalon Mountains 59.52,67.15
accept An Old Colleague##1072 |goto Stonetalon Mountains 59.52,67.15
accept A Scroll from Mauren##1075 |goto Stonetalon Mountains 59.52,67.15
stickystart "Collect_Pridewing_Venom_Sacs_And_Stonetalon_Supply_Bundles"
step
talk Night Elf Courier##268925
accept Stonetalon Supply Run##86574 |goto Stonetalon Mountains/0 48.69,39.89
step
label "Collect_Pridewing_Venom_Sacs_And_Stonetalon_Supply_Bundles"
kill Pridewing Wyvern##4012, Pridewing Consort##4014, Pridewing Skyhunter##4013, Young Pridewing##4011
|tip Wyverns.
collect 6 Stonetalon Supply Bundle##277917 |q 86574/1 |goto Stonetalon Mountains/0 51.26,42.02 |only if haveq(86574) or completedq(86574)
collect 12 Pridewing Venom Sac##5808 |q 1134/1 |goto Stonetalon Mountains/0 51.26,42.02
step
talk Keeper Albagorm##3994
turnin Journey to Stonetalon Peak##1056 |goto Stonetalon Mountains 37.10,8.10
step
talk Teloren##4407
fpath Stonetalon Peak |goto Stonetalon Mountains 36.44,7.18
step
talk Innkeeper Faralia##16458
|tip Inside the building.
turnin Stonetalon Supply Run##86574 |goto Stonetalon Mountains/0 35.79,5.73
step
talk Shindrell Swiftfire##3845
turnin Pridewings of Stonetalon##1134 |goto Ashenvale 34.67,48.84
step
talk Raene Wolfrunner##3691
|tip Inside the building.
accept An Aggressive Defense##1025 |goto Ashenvale 36.62,49.58
step
talk Sentinel Velene Starstrike##3885
|tip Inside the building.
accept Elemental Bracers##1016 |goto Ashenvale 49.80,67.21
step
kill Befouled Water Elemental##3917+
|tip Careful to avoid {o}Tideress{}.
|tip {o}Level 27{} green water elemental.
collect 5 Intact Elemental Bracer##12220 |n
use Divining Scroll##5456
collect Divined Scroll##5455 |q 1016/1 |goto Ashenvale/0 48.17,69.74
step
talk Sentinel Velene Starstrike##3885
|tip Inside the building.
turnin Elemental Bracers##1016 |goto Ashenvale 49.80,67.21
step
kill Foulweald Den Watcher##3746 |q 1025/1 |goto Ashenvale/0 52.40,62.80
kill 2 Foulweald Ursa##3749 |q 1025/2 |goto Ashenvale/0 52.40,62.80
kill 10 Foulweald Totemic##3750 |q 1025/3 |goto Ashenvale/0 52.40,62.80
kill 12 Foulweald Warrior##3743 |q 1025/4 |goto Ashenvale/0 52.40,62.80
step
Kill enemies
ding 24 |goto Ashenvale/0 52.40,62.80
step
click Gleaming Crescent Pendant
|tip Underwater.
accept Gleaming Crescent Necklace##98027 |goto Ashenvale/0 62.98,71.59
step
talk Jarrodenus##12577
|tip Be {o}very careful{} traveling here.
|tip Follow the road and {o}avoid Horde NPCs{}.
|tip {o}Warsong Outriders{} patrolling the road won't attack.
fpath Talrendis Point |goto Azshara 11.90,77.59
|tip Needed to access some flight paths to Ratchet.
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1025
|only if Druid
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin An Aggressive Defense##1025 |goto Ashenvale 36.62,49.58
step
talk Maliynn##3961
|tip Inside the building.
turnin Gleaming Crescent Necklace##98027 |goto Ashenvale/0 36.62,49.98
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 484 |future
|only if Warrior
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 484 |future
|only if Rogue
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 484 |future
|only if Priest
step
talk Jocaste##4146
|tip Upstairs inside the building.
Train Abilities |trainer Jocaste##4146 |goto Darnassus/0 40.38,8.54 |q 484 |future
|only if Hunter
step
talk Silvaria##10089
|tip Top of the building.
Train Pet Abilities |trainer Silvaria##10089 |goto Darnassus/0 42.47,9.17 |q 484 |future
|only if Hunter
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Wetlands (24-25)",{
image=ZGV.IMAGESDIR.."Wetlands",
hardcore = true,
next="Leveling Guides\\Duskwood & Redridge Mountains (25-27)",
},[[
step
talk James Halloran##2094
|tip Walks around.
accept Young Crocolisk Skins##484 |goto Wetlands 8.51,55.71
step
talk Karl Boran##1242
|tip Walks around.
accept Claws from the Deep##279 |goto Wetlands 8.31,58.53
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 484
|only if Mage
step
talk Milstaff Stormeye##2489
|tip Inside the building.
learnspell Teleport: Ironforge##3562 |goto Ironforge 25.50,7.07
|only if Mage
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 484
|only if Paladin
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 484
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 484
|only if Warlock
step
talk Eldrun Stormbreaker##258098
accept Call of Water##94494 |goto Ironforge/0 47.15,13.87
|only if Shaman
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 484
|only if Shaman
step
talk Gerrig Bonegrip##2786
|tip Downstairs inside the building.
turnin The Powers Below##968 |goto Ironforge/0 50.83,5.62
|only if haveq(968) or completedq(968)
step
talk First Mate Fitzsimmons##1239
|tip Walks around.
accept The Third Fleet##288 |goto Wetlands 10.89,59.67
accept The Greenwarden##463 |goto Wetlands 10.89,59.67
step
talk Innkeeper Helbrek##1464
|tip Walks around.
|tip Inside the building.
home Deepwater Tavern |goto Wetlands 10.70,60.95 |q 66 |future
step
talk Innkeeper Helbrek##1464
|tip Walks around.
|tip Inside the building.
buy Flagon of Mead##2594 |q 288/1 |goto Wetlands 10.70,60.95
step
talk Archaeologist Flagongut##2911
|tip Upstairs inside the building.
turnin The Absent Minded Prospector##942 |goto Wetlands 10.84,60.43
accept The Absent Minded Prospector##943 |goto Wetlands/0 10.84,60.43
|only if haveq(942) or completedq(942)
step
talk First Mate Fitzsimmons##1239
|tip Walks around.
turnin The Third Fleet##288 |goto Wetlands 10.89,59.67
step
talk Caitlin Grassman##1480
|tip Walks around.
|tip Inside the building.
accept Alchemical Hazards##98282 |goto Wetlands/0 11.86,58.82
step
talk Sida##2111
accept Digging Through the Ooze##470 |goto Wetlands 11.80,57.99
step
talk Neal Allen##1448
|tip Walks around.
|tip Inside the building.
buy Bronze Tube##4371 |n
|tip If possible.
|tip Limited supply item.
|tip Needed later for Duskwood quest.
Visit the Vendor |vendor Neal Allen##1448 |goto Wetlands 10.75,56.75 |q 174 |future
|only if itemcount(4371) == 0
step
talk Tarrel Rockweaver##2096
|tip Walks around.
turnin Unrequited Love##98461 |goto Wetlands/0 11.50,52.14
accept In Search of The Excavation Team##305 |goto Wetlands/0 11.50,52.14
stickystart "Slay_Bluegill_Murlocs"
stickystart "Collect_Young_Crocolisk_Skins"
step
kill Gobbler##1259
|tip Grey murloc.
|tip Walks around.
|tip Spawns here.
collect Gobbler's Head##3618 |q 279/2 |goto Wetlands 17.99,40.38
|mapmarker Wetlands/0 15.20,41.20
step
label "Slay_Bluegill_Murlocs"
kill Bluegill Murloc##1024+
Slay #12# Bluegill Murlocs |q 279/1 |goto Wetlands/0 15.85,39.81
step
Enter Whelgar's Excavation Site |goto Wetlands/0 34.19,41.09 < 40 |only if walking and not subzone("Whelgar's Excavation Site")
Follow the path up |goto Wetlands/0 37.11,42.98 < 20 |only if walking
talk Ormer Ironbraid##1078
|tip Walks around.
accept Ormer's Revenge##294 |goto Wetlands/0 38.18,50.89
stickystop "Collect_Young_Crocolisk_Skins"
step
talk Merrin Rockweaver##1076
|tip Inside the small cave.
turnin In Search of The Excavation Team##305 |goto Wetlands/0 38.91,52.34
accept In Search of The Excavation Team##306 |goto Wetlands/0 38.91,52.34
step
click Flagongut's Fossil
|tip Inside the small cave.
collect Flagongut's Fossil##5234 |q 943/2 |goto Wetlands/0 38.86,52.21
|only if haveq(943) or completedq(943)
stickystart "Collect_Stone_Of_Relu"
step
Leave Whelgar's Excavation Site |goto Wetlands/0 34.02,40.85 < 40 |only if walking and subzone("Whelgar's Excavation Site")
kill 10 Mottled Raptor##1020 |q 294/1 |goto Wetlands/0 24.81,47.68
kill 10 Mottled Screecher##1021 |q 294/2 |goto Wetlands/0 24.81,47.68
step
label "Collect_Stone_Of_Relu"
kill Mottled Raptor##1020, Mottled Screecher##1021
|tip Raptors.
collect Stone of Relu##5233 |q 943/1 |goto Wetlands/0 24.81,47.68
|only if haveq(943) or completedq(943)
step
Enter Whelgar's Excavation Site |goto Wetlands/0 34.19,41.09 < 40 |only if walking and not subzone("Whelgar's Excavation Site")
Follow the path up |goto Wetlands/0 37.11,42.98 < 20 |only if walking
talk Ormer Ironbraid##1078
|tip Walks around.
turnin Ormer's Revenge##294 |goto Wetlands/0 38.18,50.89
stickystart "Collect_Young_Crocolisk_Skins"
step
Leave Whelgar's Excavation Site |goto Wetlands/0 34.02,40.85 < 40 |only if walking and subzone("Whelgar's Excavation Site")
talk Howin Kindfeather##270637
accept Razormaw Needling##98245 |goto Wetlands/0 49.35,42.12
accept Trying Times##98246 |goto Wetlands/0 49.35,42.12
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin The Greenwarden##463 |goto Wetlands/0 56.34,40.43
accept Tramping Paws##276 |goto Wetlands/0 56.34,40.43
step
kill Leech Stalker##1111, Cave Stalker##4040
|tip Spiders.
|tip Inside and outside the cave.
collect Unruptured Stalker Gland##280319 |q 98282/1 |goto Wetlands/0 52.63,63.01
stickystop "Collect_Young_Crocolisk_Skins"
stickystart "Kill_Mosshide_Gnolls"
stickystart "Collect_Young_Crocolisk_Skins"
step
Leave the cave |goto Wetlands/0 52.63,63.01 < 30 |walk |only if subzone("Thelgen Rock") and indoors()
kill 10 Mosshide Mongrel##1008 |q 276/2 |goto Wetlands 63.60,62.20
step
label "Kill_Mosshide_Gnolls"
kill 15 Mosshide Gnoll##1007 |q 276/1 |goto Wetlands/0 63.16,67.42
step
label "Collect_Young_Crocolisk_Skins"
kill Young Wetlands Crocolisk##1417+
collect 6 Young Crocolisk Skin##3397 |q 484/1 |goto Wetlands/0 58.83,53.02
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin Tramping Paws##276 |goto Wetlands/0 56.34,40.43
accept Fire Taboo##277 |goto Wetlands/0 56.34,40.43
step
kill Black Ooze##1032, Crimson Ooze##1031, Monstrous Ooze##1033
|tip Inside and outside the crypt.
collect Sida's Bag##3349 |q 470/1 |goto Wetlands/0 44.29,25.36
step
Kill enemies
|tip Helps reach level 25 after quest turnins.
|tip Inside and outside the crypt.
ding 24,23560 |goto Wetlands/0 44.29,25.36	|only if not haveq(943)
ding 24,21160 |goto Wetlands/0 44.29,25.36	|only if haveq(943)
step
talk Archaeologist Flagongut##2911
|tip Upstairs inside the building.
turnin The Absent Minded Prospector##943 |goto Wetlands/0 10.84,60.43
|only if haveq(943) or completedq(943)
step
talk Caitlin Grassman##1480
|tip Walks around.
|tip Inside the building.
turnin Alchemical Hazards##98282 |goto Wetlands/0 11.86,58.82
step
talk Sida##2111
turnin Digging Through the Ooze##470 |goto Wetlands 11.80,57.99
step
talk Tarrel Rockweaver##2096
|tip Walks around.
turnin In Search of The Excavation Team##306 |goto Wetlands 11.50,52.14
step
talk Neal Allen##1448
|tip Walks around.
|tip Inside the building.
buy Bronze Tube##4371 |n
|tip If possible.
|tip Limited supply item.
|tip Needed later for Duskwood quest.
Visit the Vendor |vendor Neal Allen##1448 |goto Wetlands 10.75,56.75 |q 174 |future
|only if itemcount(4371) == 0
step
talk James Halloran##2094
|tip Walks around.
turnin Young Crocolisk Skins##484 |goto Wetlands 8.51,55.71
step
talk Karl Boran##1242
|tip Walks around.
turnin Claws from the Deep##279 |goto Wetlands 8.31,58.53
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 25 ammo when restocking.
Click Here to Continue |confirm |q 1075
|only if Hunter
step
talk Auctioneer Redmuse##8720
|tip Buy from the Auction House, if possible.
|tip Needed for a quest soon.
|tip Inside the building.
collect 2 Elixir of Minor Fortitude##2458 |goto Ironforge/0 24.24,74.57 |q 1073 |future
collect 4 Minor Mana Potion##2455 |goto Ironforge/0 24.24,74.57 |q 1073 |future
step
talk Buliwyf Stonehand##11865
|tip Inside the building.
Train Guns |complete weaponskill("GUN") > 0 |goto Ironforge 61.17,89.52
|only if Hunter
step
talk Lomac Gearstrip##4081
turnin An Old Colleague##1072 |goto Ironforge/0 72.09,51.88
step
talk Lomac Gearstrip##4081
accept Ineptitude + Chemicals = Fun##1073 |goto Ironforge/0 72.09,51.88
|only if completedq(1072) and (itemcount(2458) >= 2 and itemcount(2455) >= 4)
step
talk Lomac Gearstrip##4081
turnin Ineptitude + Chemicals = Fun##1073 |goto Ironforge/0 72.09,51.88
|only if haveq(1073) or completedq(1073)
step
talk Gearcutter Cogspinner##5175
buy Bronze Tube##4371 |n
|tip If possible.
|tip Limited supply item.
|tip Needed later for Duskwood quest.
Visit the Vendor |vendor Gearcutter Cogspinner##5175 |goto Ironforge/0 67.84,42.51 |q 174 |future
|only if itemcount(4371) == 0
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Ironforge/0 76.86,51.19 |q 1075
|tip Walk into the portal.
step
Enter Stormwind City |complete zone("Stormwind City") |q 1075
|tip Ride the tram.
|tip Walk into the portal.
step
talk Billibub Cogspinner##5519
buy Bronze Tube##4371 |n
|tip If possible.
|tip Limited supply item.
|tip Needed later for Duskwood quest.
Visit the Vendor |vendor Billibub Cogspinner##5519 |goto Stormwind City/0 62.42,29.91 |q 174 |future
|only if itemcount(4371) == 0
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Duthorian Rall##6171
|tip Inside the building.
accept The Tome of Valor##1650 |goto Stormwind City 50.47,47.47
|only if Paladin
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
accept Mathias and the Defias##2360 |goto Stormwind City 78.26,70.74
|only if Rogue
step
talk Auctioneer Jaxon##15659
|tip Inside the building.
buy Bronze Tube##4371 |goto Stormwind City/0 61.13,70.67 |q 174 |future
|tip Needed for quest in Duskwood soon.
step
talk Collin Mauren##4078
turnin A Scroll from Mauren##1075 |goto Stormwind City 53.01,86.63
step
talk Larimaine Purdue##2485
|tip Upstairs inside the tower.
learnspell Teleport: Stormwind##3561 |goto Stormwind City 50.50,85.91
|only if Mage
step
Enter the building |goto Stormwind City/0 42.25,81.81 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Heartswood##1738 |goto Stormwind City 39.23,85.22
accept The Binding##1739 |goto Stormwind City 39.23,85.22
|only if Warlock
step
use Heartswood Core##6913
|tip Stand on the pink symbol.
|tip Inside the crypt beneath the building.
kill Summoned Succubus##5677 |q 1739/1 |goto Stormwind City 39.12,84.37
|only if Warlock
step
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
|tip Above the crypt.
turnin The Binding##1739 |goto Stormwind City 39.23,85.22
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.52 |q 94 |future
|only if Warlock
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Duskwood & Redridge Mountains (25-27)",{
image=ZGV.IMAGESDIR.."Redridge Mountains",
hardcore = true,
next="Leveling Guides\\Wetlands (27-29)",
},[[
step
talk Madame Eva##265
|tip Walks around.
|tip Inside the building.
accept The Legend of Stalvan##66 |goto Duskwood 75.82,45.29
accept The Totem of Infliction##101 |goto Duskwood 75.82,45.29
step
talk Innkeeper Trelayne##6790
|tip Inside the building.
home Darkshire |goto Duskwood 73.87,44.41
step
talk Commander Althea Ebonlocke##264
|tip Walks around.
accept The Night Watch##56 |goto Duskwood 73.60,46.90
step
talk Clerk Daltry##267
|tip Walks around.
|tip Inside the building.
turnin The Legend of Stalvan##66 |goto Duskwood 72.52,46.85
accept The Legend of Stalvan##67 |goto Duskwood 72.52,46.85
step
talk Sirra Von'Indi##268
|tip Inside the building.
accept The Valor Family##96139 |goto Duskwood 72.64,47.62
step
talk Elaine Carevin##633
|tip Inside the building.
accept Raven Hill##163 |goto Duskwood 75.33,48.69
accept The Hermit##165 |goto Duskwood 75.33,48.69
accept Deliveries to Sven##164 |goto Duskwood 75.33,48.69
step
talk Felicia Maline##2409
fpath Darkshire |goto Duskwood 77.49,44.29
step
talk Viktori Prism'Antras##276
|tip Walks around.
|tip Inside the building.
accept Look To The Stars##174 |goto Duskwood 79.80,48.02
step
talk Viktori Prism'Antras##276
|tip Walks around.
|tip Inside the building.
turnin Look To The Stars##174 |goto Duskwood 79.80,48.02
accept Look To The Stars##175 |goto Duskwood 79.80,48.02
step
talk Blind Mary##302
|tip Walks around.
|tip Inside the building.
turnin Look To The Stars##175 |goto Duskwood 81.99,59.09
accept Look To The Stars##177 |goto Duskwood 81.99,59.09
stickystart "Collect_Skeleton_Fingers"
stickystart "Kill_Skeletal_Mages_And_Warriors"
step
kill Insane Ghoul##511
|tip Red ghoul.
|tip Walks around.
|tip Inside and outside the building.
collect Mary's Looking Glass##1946 |q 177/1 |goto Duskwood 80.94,71.40
step
label "Collect_Skeleton_Fingers"
kill Skeletal Mage##203, Skeletal Warrior##48
collect 10 Skeleton Finger##2378 |q 101/3 |goto Duskwood/0 79.30,70.19
step
label "Kill_Skeletal_Mages_And_Warriors"
kill 6 Skeletal Mage##203 |q 56/2 |goto Duskwood/0 79.30,70.19
kill 8 Skeletal Warrior##48 |q 56/1 |goto Duskwood/0 79.30,70.19
step
_NOTE:_
Avoid Stitches in Duskwood
|tip Stitches is a {o}level 35 elite abomination{}.
|tip Walks along the main road between Darkshire and Raven Hill.
Click Here to Continue |confirm |q 163
|only if hardcore()
stickystart "Collect_Vials_Of_Spider_Venom_And_Gooey_Spider_Legs"
step
talk Watcher Dodds##888
accept Eight-Legged Menaces##245 |goto Duskwood/0 45.12,67.03
step
click Memory of Valor
|tip Black book.
|tip Inside the building.
collect Raven Hill Tome##281046 |q 96139/1 |goto Duskwood/0 21.19,55.69		|notravel	|only if zone("Duskwood")
collect Raven Hill Tome##281046 |q 96139/1 |goto Duskwood/0 21.19,55.69				|only if not zone("Duskwood")
stickystop "Collect_Vials_Of_Spider_Venom_And_Gooey_Spider_Legs"
step
talk Jitters##288
|tip Walks around.
turnin Raven Hill##163 |goto Duskwood 18.16,56.51
accept Jitters' Growling Gut##5 |goto Duskwood 18.16,56.51
stickystart "Collect_Vials_Of_Spider_Venom_And_Gooey_Spider_Legs"
step
kill 15 Pygmy Venom Web Spider##539 |q 245 |goto Duskwood/0 10.25,49.73
step
talk Sven Yorgen##311
|tip Walks around.
turnin Deliveries to Sven##164 |goto Duskwood/0 7.79,34.00
accept Sven's Revenge##95 |goto Duskwood/0 7.79,34.00
step
talk Lars##893
|tip Walks around.
accept Wolves at Our Heels##226 |goto Duskwood 7.71,33.20
step
kill 8 Rabid Dire Wolf##565 |q 226/2 |goto Duskwood/0 17.69,27.45
kill 12 Starving Dire Wolf##213 |q 226/1 |goto Duskwood/0 17.69,27.45
step
talk Abercrombie##289
|tip Inside the building.
turnin The Hermit##165 |goto Duskwood 28.11,31.47
accept Supplies from Darkshire##148 |goto Duskwood 28.11,31.47
step
label "Collect_Vials_Of_Spider_Venom_And_Gooey_Spider_Legs"
kill Black Widow Hatchling##930, Carrion Recluse##949, Green Recluse##569, Venom Web Spider##217, Pygmy Venom Web Spider##539
|tip Spiders.
collect 5 Vial of Spider Venom##1130 |q 101/2 |goto Duskwood/0 32.02,46.71
collect 6 Gooey Spider Leg##2251 |goto Duskwood/0 32.02,46.71 |q 93 |future
|tip Don't vendor them.
step
kill Flesh Eater##3, Rotted One##948, Bone Chewer##210, Plague Spreader##604, Brain Eater##570
|tip Ghouls.
|tip Inside and outside the crypt.
collect 10 Ghoul Fang##1129 |q 101/1 |goto Duskwood 23.59,34.89
step
Leave the crypt |goto Duskwood 23.59,34.89 < 15 |walk |only if subzone("Dawning Wood Catacombs") and indoors()
talk Lars##893
|tip Walks around.
turnin Wolves at Our Heels##226 |goto Duskwood 7.71,33.20
step
talk Agent Kearnen##7024
turnin Mathias and the Defias##2360 |goto Westfall 68.49,70.08
accept Klaven's Tower##2359 |goto Westfall 68.49,70.08
|only if Rogue
step
collect Defias Tower Key##7923 |q 2359/2 |goto Westfall 71.63,73.91
|tip Cast {o}Pickpocket{} on a Malformed Defias Drone.
|tip Walks around.
|only if Rogue
step
click Duskwood Chest
|tip {o}Sap{} Klaven Mortwake {o}before clicking the chest{}.
|tip You get a debuff after opening it.
|tip {o}Top floor{} inside the building.
collect Klaven Mortwake's Journal##7908 |q 2359/1 |goto Westfall 70.41,73.93
|only if Rogue
step
click Old Footlocker
|tip You will be attacked.
|tip Inside the building.
turnin The Legend of Stalvan##67 |goto Westfall 41.51,66.73
accept The Legend of Stalvan##68 |goto Westfall 41.51,66.73
step
Follow the path up through the mountains |goto Westfall 52.64,72.27 < 60 |only if walking
Follow the path around the mountain |goto Westfall/0 38.75,83.72 < 30 |only if walking
talk Daphne Stilwell##6182
|tip Walks around.
turnin The Tome of Valor##1650 |goto Westfall 42.33,88.64
accept The Tome of Valor##1651 |goto Westfall 42.33,88.64
|only if Paladin
step
Watch the dialogue
Kill the enemies that attack in waves
Protect Daphne Stilwell |q 1651/1 |goto Westfall 42.33,88.64
|only if Paladin
step
talk Daphne Stilwell##6182
|tip Walks around.
turnin The Tome of Valor##1651 |goto Westfall 41.68,89.09
accept The Tome of Valor##1652 |goto Westfall 41.68,89.09
|only if Paladin
step
click Strange Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Endurance##15882 |goto Westfall 17.87,33.11 |q 272
|only if Druid
step
use Half Pendant of Aquatic Agility##15883
collect Pendant of the Sea Lion##15885 |q 272/1 |goto Moonglade 35.92,41.42
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Trial of the Sea Lion##272 |goto Moonglade 56.21,30.64
accept Aquatic Form##5061 |goto Moonglade 56.21,30.64
|only if Druid
step
talk Mathrengyl Bearwalker##4217
|tip {o}Top floor{} inside the building.
turnin Aquatic Form##5061 |goto Darnassus 35.37,8.39
|only if Druid
step
talk Chef Grual##272
|tip Walks around.
|tip Inside the building.
turnin Jitters' Growling Gut##5 |goto Duskwood 73.78,43.45
accept Dusky Crab Cakes##93 |goto Duskwood 73.78,43.45
step
talk Chef Grual##272
|tip Walks around.
|tip Inside the building.
turnin Dusky Crab Cakes##93 |goto Duskwood 73.78,43.45
accept Return to Jitters##240 |goto Duskwood 73.78,43.45
step
_Destroy These Items:_
|tip Not needed.
trash Gooey Spider Leg##2251
step
talk Commander Althea Ebonlocke##264
|tip Walks around.
turnin The Night Watch##56 |goto Duskwood 73.59,46.90
accept The Night Watch##57 |goto Duskwood 73.59,46.90
step
talk Clerk Daltry##267
|tip Walks around.
|tip Inside the building.
turnin The Legend of Stalvan##68 |goto Duskwood 72.52,46.85
accept The Legend of Stalvan##69 |goto Duskwood 72.52,46.85
step
talk Sirra Von'Indi##268
|tip Inside the building.
turnin The Valor Family##96139 |goto Duskwood/0 72.64,47.62
step
talk Madame Eva##265
|tip Walks around.
|tip Inside the building.
turnin The Totem of Infliction##101 |goto Duskwood 75.81,45.29
turnin Supplies from Darkshire##148 |goto Duskwood 75.81,45.29
accept Ghost Hair Thread##149 |goto Duskwood 75.81,45.29
step
_Destroy These Items:_
|tip Not needed.
trash Memories of Valor##281149
step
talk Viktori Prism'Antras##276
|tip Walks around.
|tip Inside the building.
turnin Look To The Stars##177 |goto Duskwood 79.80,48.02
step
talk Blind Mary##302
|tip Walks around.
|tip Inside the building.
turnin Ghost Hair Thread##149 |goto Duskwood 81.98,59.09
accept Return the Comb##154 |goto Duskwood 81.98,59.09
step
talk Madame Eva##265
|tip Walks around.
|tip Inside the building.
turnin Return the Comb##154 |goto Duskwood 75.81,45.29
accept Deliver the Thread##157 |goto Duskwood 75.81,45.29
step
click Mound of loose dirt
|tip Careful, stealthed enemies.
turnin Sven's Revenge##95 |goto Duskwood 49.86,77.70
accept Sven's Camp##230 |goto Duskwood 49.86,77.70
step
talk Watcher Dodds##888
turnin Eight-Legged Menaces##245 |goto Duskwood/0 45.12,67.03
step
talk Abercrombie##289
|tip Inside the building.
turnin Deliver the Thread##157 |goto Duskwood 28.11,31.47
accept Zombie Juice##158 |goto Duskwood 28.11,31.47
step
talk Sven Yorgen##311
|tip Walks around.
turnin Sven's Camp##230 |goto Duskwood/0 7.79,34.00
accept The Shadowy Figure##262 |goto Duskwood/0 7.79,34.00
step
talk Josephine Carson##251507
Train Abilities |trainer Josephine Carson##251507 |goto Elwynn Forest/0 41.15,66.22 |q 69
|only if Hunter
step
talk Brother Wilhelm##927
Train Abilities |trainer Brother Wilhelm##927 |goto Elwynn Forest/0 41.10,66.04 |q 69
|only if Paladin
step
talk Lyria Du Lac##913
Train Abilities |trainer Lyria Du Lac##913 |goto Elwynn Forest/0 41.09,65.77 |q 69
|only if Warrior
step
talk Innkeeper Farley##295
|tip Inside the building.
turnin The Legend of Stalvan##69 |goto Elwynn Forest 43.77,65.80
accept The Legend of Stalvan##70 |goto Elwynn Forest 43.77,65.80
step
talk Maximillian Crowe##906
|tip Downstairs inside the building.
Train Abilities |trainer Maximillian Crowe##906 |goto Elwynn Forest/0 44.39,66.24 |q 70
|only if Warlock
step
talk Cylina Darkheart##6374
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Cylina Darkheart##6374 |goto Elwynn Forest/0 44.40,65.99 |q 70
|only if Warlock
step
talk Zaldimar Wefhellt##328
|tip Upstairs inside the building.
Train Abilities |trainer Zaldimar Wefhellt##328 |goto Elwynn Forest/0 43.24,66.19 |q 70
|only if Mage
step
talk Priestess Josetta##377
|tip Upstairs inside the building.
Train Abilities |trainer Priestess Josetta##377 |goto Elwynn Forest/0 43.28,65.72 |q 70
|only if Priest
step
talk Keryn Sylvius##917
|tip Upstairs inside the building.
Train Abilities |trainer Keryn Sylvius##917 |goto Elwynn Forest/0 43.87,65.94 |q 70
|only if Rogue
step
click Storage Chest
|tip Upstairs inside the building.
collect An Undelivered Letter##910 |q 70/1 |goto Elwynn Forest 44.29,65.82
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Valor##1652 |goto Stormwind City 50.47,47.47
|only if Paladin
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin Klaven's Tower##2359 |goto Stormwind City 78.26,70.74
accept The Touch of Zanzil##2607 |goto Stormwind City 78.26,70.74
|only if Rogue
step
talk Doc Mixilpixil##7207
|tip Downstairs inside the building.
turnin The Touch of Zanzil##2607 |goto Stormwind City 80.01,69.90
accept The Touch of Zanzil##2608 |goto Stormwind City 80.01,69.90
|only if Rogue
step
Watch the dialogue
|tip Type {o}/sit{} in chat while targeting Doc Mixilpixil.
Complete the Diagnosis |q 2608/1 |goto Stormwind City 80.01,69.90
|only if Rogue
step
talk Doc Mixilpixil##7207
|tip Downstairs inside the building.
turnin The Touch of Zanzil##2608 |goto Stormwind City 80.01,69.90
|only if Rogue
step
Remove the Touch of Zanzil |nobuff Touch of Zanzil##9991
|tip Multiple options.
|tip Create {o}Anti-Venom{} with First Aid.
|tip Buy {o}Jungle Remedy{} from Auction House.
|tip Ask a {o}Druid{} to cast {o}Cure Poison{} on you.
|tip Cast {o}Stoneform{} to remove the buff.	|only if Dwarf
|only if Rogue
step
talk Sheldras Moontree##5504
Train Abilities |trainer Sheldras Moontree##5504 |goto Stormwind City/0 35.86,67.36 |q 70
|only if Druid
step
talk Caretaker Folsom##297
turnin The Legend of Stalvan##70 |goto Stormwind City 42.57,72.35
accept The Legend of Stalvan##72 |goto Stormwind City 42.57,72.35
step
click Sealed Crate
|tip You will be attacked.
turnin The Legend of Stalvan##72 |goto Stormwind City 42.48,72.08
accept The Legend of Stalvan##74 |goto Stormwind City 42.48,72.08
step
Enter the building |goto Stormwind City/0 42.25,81.81 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Zardeth of the Black Claw##1435
|tip Downstairs inside the building.
accept A Noble Brew##335 |goto Stormwind City 40.15,85.30
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 34 |future
|only if Shaman
step
talk Marshal Marris##382
accept Blackrock Menace##20 |goto Redridge Mountains 28.42,48.97
step
talk Foreman Oslow##341
accept Alther's Mill##98386 |goto Redridge Mountains/0 27.06,48.64
step
talk Dockmaster Baren##381
accept Selling Fish##127 |goto Redridge Mountains 22.63,47.38
accept Murloc Poachers##150 |goto Redridge Mountains 22.63,47.38
step
talk Martie Jainrose##342
accept An Unwelcome Guest##34 |goto Redridge Mountains 16.77,46.33
step
kill Bellygrub##345
|tip Darker brown boar.
|tip Walks around.
collect Bellygrub's Tusk##3631 |q 34/1 |goto Redridge Mountains 10.59,49.32
step
talk Martie Jainrose##342
turnin An Unwelcome Guest##34 |goto Redridge Mountains 16.77,46.33
stickystart "Kill_Greater_Tarantulas"
step
click Tarantula Egg+
|tip Clusters of large white eggs.
|tip May be attacked.
Destroy #6# Tarantula Eggs |q 98386/2 |goto Redridge Mountains/0 49.29,41.82
step
label "Kill_Greater_Tarantulas"
kill 12 Greater Tarantula##505 |q 98386/1 |goto Redridge Mountains/0 49.29,41.82
step
kill Blackrock Grunt##440, Blackrock Outrunner##485, Blackrock Renegade##437, Blackrock Summoner##4463
|tip Orcs.
collect 10 Battleworn Axe##3014 |q 20/1 |goto Redridge Mountains/0 55.86,43.28
step
kill Murloc Flesheater##422, Murloc Scout##578, Murloc Tidecaller##545
collect 8 Murloc Fin##1468 |q 150/1 |goto Redridge Mountains/0 51.32,53.27
|tip Don't vendor them.
collect 10 Spotted Sunfish##1467 |q 127/1 |goto Redridge Mountains/0 51.32,53.27
step
talk Marshal Marris##382
turnin Blackrock Menace##20 |goto Redridge Mountains 28.42,48.97
step
talk Foreman Oslow##341
turnin Alther's Mill##98386 |goto Redridge Mountains/0 27.05,48.63
step
talk Dockmaster Baren##381
turnin Selling Fish##127 |goto Redridge Mountains 22.63,47.38
turnin Murloc Poachers##150 |goto Redridge Mountains 22.63,47.38
step
_Destroy or Sell These Items:_
|tip Not needed.
trash Murloc Fin##1468
step
talk Madame Eva##265
|tip Walks around.
|tip Inside the building.
turnin The Shadowy Figure##262 |goto Duskwood 75.81,45.29
accept The Shadowy Search Continues##265 |goto Duskwood 75.81,45.29
step
talk Clerk Daltry##267
|tip Walks around.
|tip Inside the building.
turnin The Shadowy Search Continues##265 |goto Duskwood 72.53,46.85
accept Inquire at the Inn##266 |goto Duskwood 72.53,46.85
step
talk Tavernkeep Smitts##273
|tip Walks around.
|tip Inside the building.
turnin Zombie Juice##158 |goto Duskwood 73.78,44.48
accept Gather Rot Blossoms##156 |goto Duskwood 73.78,44.48
turnin Inquire at the Inn##266 |goto Duskwood 73.78,44.48
accept Finding the Shadowy Figure##453 |goto Duskwood 73.78,44.48
step
talk Jitters##288
|tip Walks around.
turnin Return to Jitters##240 |goto Duskwood 18.14,56.52
turnin Finding the Shadowy Figure##453 |goto Duskwood 18.14,56.52
accept Return to Sven##268 |goto Duskwood 18.14,56.52
stickystart "Kill_Skeletal_Fiends_And_Horrors"
step
kill Skeletal Fiend##531, Skeletal Horror##202
|tip Fiends and Horrors.
collect 8 Rot Blossom##1598 |q 156/1 |goto Duskwood/0 19.26,44.70
step
label "Kill_Skeletal_Fiends_And_Horrors"
kill 15 Skeletal Fiend##531 |q 57/1 |goto Duskwood/0 19.26,44.70
kill 15 Skeletal Horror##202 |q 57/2 |goto Duskwood/0 19.26,44.70
step
talk Sven Yorgen##311
|tip Walks around.
turnin Return to Sven##268 |goto Duskwood/0 7.79,34.00
accept Proving Your Worth##323 |goto Duskwood/0 7.79,34.00
step
kill 3 Skeletal Warder##785 |q 323/3 |goto Duskwood/0 15.88,38.72
kill 3 Skeletal Healer##787 |q 323/2 |goto Duskwood/0 15.88,38.72
kill 15 Skeletal Raider##1110 |q 323/1 |goto Duskwood/0 15.88,38.72
|tip Inside and outside the crypt.
|tip Avoid Mor'Ladim, {o}level 35 elite skeleton{}.
|tip Walks around outside the crypt.
step
Kill enemies
|tip Inside and outside the crypt.
|tip Avoid Mor'Ladim, {o}level 35 elite skeleton{}.
|tip Walks around outside the crypt.
ding 27 |goto Duskwood/0 15.88,38.72
step
Run up the stairs and leave the crypt |goto Duskwood/0 15.88,38.72 < 10 |walk |only if subzone("Dawning Wood Catacombs") and indoors()
talk Sven Yorgen##311
|tip Walks around.
turnin Proving Your Worth##323 |goto Duskwood/0 7.79,34.00
accept Seeking Wisdom##269 |goto Duskwood/0 7.79,34.00
step
talk Tavernkeep Smitts##273
|tip Walks around.
|tip Inside the building.
turnin Gather Rot Blossoms##156 |goto Duskwood 73.78,44.48
accept Juice Delivery##159 |goto Duskwood 73.78,44.48
step
talk Commander Althea Ebonlocke##264
|tip Walks around.
turnin The Night Watch##57 |goto Duskwood 73.60,46.90
step
talk Guard Howe##903
accept Blackrock Bounty##128 |goto Redridge Mountains 26.45,57.85
step
talk Verner Osgood##415
accept Howling in the Hills##126 |goto Redridge Mountains/0 25.88,47.27
step
talk Bailiff Conacher##900
|tip Inside the building.
accept Solomon's Law##91 |goto Redridge Mountains 24.63,44.26
step
click Wanted: Lieutenant Fangore
accept Wanted: Lieutenant Fangore##180 |goto Redridge Mountains 21.66,46.47
step
kill Yowler##518
|tip Gnoll with sword.
|tip Walks around.
|tip Multiple locations.
collect Yowler's Paw##3614 |q 126/1 |goto Redridge Mountains/0 22.56,21.38
|mapmarker Redridge Mountains/0 21.11,22.60
|mapmarker Redridge Mountains/0 23.71,23.20
|mapmarker Redridge Mountains/0 23.71,26.00
|mapmarker Redridge Mountains/0 26.31,21.80
stickystart "Collect_Shadowhide_Pendants"
step
kill Lieutenant Fangore##703
|tip Gnoll with red robe and long sword.
|tip Walks around.
|tip Careful, enemies pull with him.
collect Fangore's Paw##3632 |q 180/1 |goto Redridge Mountains/0 75.07,37.82
step
click Old Lion Statue
turnin A Watchful Eye##94 |goto Redridge Mountains 79.27,46.71
step
label "Collect_Shadowhide_Pendants"
kill Rabid Shadowhide Gnoll##434, Shadowhide Gnoll##433, Shadowhide Brute##432, Shadowhide Assassin##579, Shadowhide Warrior##568, Shadowhide Darkweaver##429, Shadowhide Slayer##431
|tip Gnolls.
collect 10 Shadowhide Pendant##1075 |q 91/1 |goto Redridge Mountains/0 72.50,40.92
step
kill 15 Blackrock Champion##435 |q 128/1 |goto Redridge Mountains 28.12,6.88
|tip Inside and outside the cave.
|tip Try to stay inside the cave.
|tip Next step is inside the cave.
step
talk Corporal Keeshan##349
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Inside the cave.
accept Missing In Action##219 |goto Redridge Mountains 23.30,12.55 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Corporal Keeshan.
|tip Carefully pull enemies to him at the cave exit.
Escort Corporal Keeshan Back to Redridge |q 219/1 |goto Redridge Mountains 28.32,48.51 |notravel
step
talk Marshal Marris##382
turnin Missing In Action##219 |goto Redridge Mountains 28.42,48.97
step
talk Verner Osgood##415
turnin Howling in the Hills##126 |goto Redridge Mountains/0 25.88,47.27
step
talk Bailiff Conacher##900
|tip Inside the building.
turnin Solomon's Law##91 |goto Redridge Mountains 24.62,44.27
step
talk Magistrate Solomon##344
|tip Inside the building.
turnin Wanted: Lieutenant Fangore##180 |goto Redridge Mountains 24.90,44.46
step
talk Guard Howe##903
turnin Blackrock Bounty##128 |goto Redridge Mountains 26.45,57.86
step
_Destroy This Item:_
|tip Not needed.
trash Glowing Shadowhide Pendant##1962
step
talk Olivia Burnside##2455
|tip Deposit into the bank.
|tip Inside the building.
bank A Torn Journal Page##916		|goto Stormwind City 64.18,80.48	|q 74
bank Bottle of Zombie Juice##1451	|goto Stormwind City 64.18,80.48	|q 159
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Sarno##7917
|tip Inside the building.
accept Tinkmaster Overspark##2923 |goto Stormwind City 51.05,48.33
step
talk Bishop Farthing##1212
|tip Inside the building.
turnin Seeking Wisdom##269 |goto Stormwind City 49.95,46.00
accept The Doomed Fleet##270 |goto Stormwind City 49.95,46.00
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 2923
|only if Shaman
step
talk Tinkmaster Overspark##7944
turnin Tinkmaster Overspark##2923 |goto Ironforge 69.54,50.32
step
talk Buliwyf Stonehand##11865
|tip Inside the building.
Train Guns		|complete weaponskill("GUN") > 0	|goto Ironforge 61.17,89.52	|only if Hunter or Warrior or Rogue
Train Two-Handed Axes	|complete weaponskill("TH_AXE") > 0	|goto Ironforge 61.17,89.52	|only if Hunter or Warrior or Paladin
Train Two-Handed Maces	|complete weaponskill("TH_MACE") > 0	|goto Ironforge 61.17,89.52	|only if Warrior
Train One-Handed Maces	|complete weaponskill("MACE") > 0	|goto Ironforge 61.17,89.52	|only if Rogue
|only if Hunter or Warrior or Rogue or Paladin
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Wetlands (27-29)",{
image=ZGV.IMAGESDIR.."Wetlands",
hardcore = true,
next="Leveling Guides\\Ashenvale (29-30)",
},[[
step
talk Karl Boran##1242
|tip Walks around.
accept Reclaiming Goods##281 |goto Wetlands/0 8.31,58.53
step
talk James Halloran##2094
|tip Walks around.
accept Apprentice's Duties##471 |goto Wetlands 8.51,55.71
step
talk First Mate Fitzsimmons##1239
accept The Cursed Crew##289 |goto Wetlands/0 10.89,59.67
step
talk Glorin Steelbrow##1217
|tip Inside the building.
turnin The Doomed Fleet##270 |goto Wetlands/0 10.59,60.59
step
talk Innkeeper Helbrek##1464
|tip Walks around.
|tip Inside the building.
home Deepwater Tavern |goto Wetlands/0 10.70,60.96 |q 1242 |future
step
talk Harlo Barnaby##2097
accept Fall of Dun Modr##472 |goto Wetlands/0 10.85,55.90
step
talk Captain Stoutfist##2104
|tip Upstairs inside the building.
accept War Banners##464 |goto Wetlands/0 9.86,57.49
accept From the Ashes##98221 |goto Wetlands/0 9.86,57.49
step
click Damaged Crate
turnin Reclaiming Goods##281 |goto Wetlands/0 13.51,41.38
accept The Search Continues##284 |goto Wetlands/0 13.51,41.38
step
click Sealed Barrel
turnin The Search Continues##284 |goto Wetlands/0 13.61,38.21
accept Search More Hovels##285 |goto Wetlands/0 13.61,38.21
step
click Half-buried Barrel
turnin Search More Hovels##285 |goto Wetlands/0 13.95,34.81
accept Return the Statuette##286 |goto Wetlands/0 13.95,34.81
stickystart "Kill_Cursed_Marines_And_Cursed_Sailors"
step
kill First Mate Snellig##1159
|tip Underwater.
|tip Inside the sunken ship.
collect Snellig's Snuffbox##3619 |q 289/3 |goto Wetlands/0 14.08,30.01
step
label "Kill_Cursed_Marines_And_Cursed_Sailors"
kill 5 Cursed Marine##1158 |q 289/2 |goto Wetlands/0 13.80,29.60
kill 13 Cursed Sailor##1157 |q 289/1 |goto Wetlands/0 13.80,29.60
|mapmarker Wetlands/0 14.80,24.00
step
kill Giant Wetlands Crocolisk##2089+
collect 6 Giant Crocolisk Skin##3348 |q 471/1 |goto Wetlands/0 21.80,23.31
stickystart "Collect_Perfect_Razormaw_Eggs"
step
kill Highland Razormaw##1018, Elder Razormaw##1019
|tip Raptors.
collect 10 Razormaw Incisor##280103 |q 98245/1 |goto Wetlands/0 35.19,18.71
step
label "Collect_Perfect_Razormaw_Eggs"
click Razormaw Eggs##671892+
|tip Pinks eggs.
collect 12 Perfect Razormaw Egg##280132 |q 98246/1 |goto Wetlands/0 35.19,18.71
step
kill Mosshide Brute##1012, Mosshide Trapper##1011, Mosshide Fenrunner##1010, Mosshide Mistweaver##1009, Mosshide Mystic##1013, Mosshide Alpha##1014
|tip Gnolls.
collect 9 Crude Flint##2611 |q 277/1 |goto Wetlands/0 35.21,31.87
step
Enter Whelgar's Excavation Site |goto Wetlands/0 34.19,41.09 < 40 |only if walking and not subzone("Whelgar's Excavation Site")
Follow the path up |goto Wetlands/0 37.11,42.98 < 20 |only if walking
talk Ormer Ironbraid##1078
|tip Walks around.
accept Ormer's Revenge##295 |goto Wetlands/0 38.18,50.89
step
talk Prospector Whelgar##1077
|tip Inside the small cave.
accept Uncovering the Past##299 |goto Wetlands/0 38.81,52.39
stickystart "Collect_Neru_Fragment"
stickystart "Collect_Golm_Fragment"
stickystart "Collect_Modr_Fragment"
stickystart "Collect_Ados_Fragment"
stickystart "Kill_Mottled_Scytheclaws_And_Razormaws"
step
label "Kill_Mottled_Scytheclaws_And_Razormaws"
kill 10 Mottled Scytheclaw##1022 |q 295/1 |goto Wetlands/0 34.14,48.48
kill 10 Mottled Razormaw##1023 |q 295/2 |goto Wetlands/0 34.14,48.48
step
Follow the path up |goto Wetlands/0 37.11,42.98 < 20 |only if walking
talk Ormer Ironbraid##1078
|tip Walks around.
turnin Ormer's Revenge##295 |goto Wetlands/0 38.18,50.89
accept Ormer's Revenge##296 |goto Wetlands/0 38.18,50.89
step
Follow the path up |goto Wetlands/0 31.89,48.63 < 15 |only if walking
kill Sarltooth##1353
|tip Blue raptor.
|tip Up on the cliff.
|tip Walks around.
|tip Sometimes walks in the valley.
collect Sarltooth's Talon##3638 |q 296/1 |goto Wetlands/0 33.26,51.52
|mapmarker Wetlands/0 35.40,47.60
step
label "Collect_Neru_Fragment"
click Loose Soil
|tip Large pile of dirt.
|tip Multiple locations.
|tip Can also be up on the cliff near Sarltooth. |notinsticky
collect Neru Fragment##2661 |q 299/4 |goto Wetlands/0 34.14,48.48
step
label "Collect_Golm_Fragment"
click Ancient Relic
|tip Large wide yellow vase.
|tip Multiple locations. |notinsticky
|tip Can also be up on the cliff near Sarltooth. |notinsticky
collect Golm Fragment##2660 |q 299/3 |goto Wetlands/0 34.14,48.48
step
label "Collect_Modr_Fragment"
click Ancient Relic
|tip Large tall red vase.
|tip Multiple locations. |notinsticky
|tip Can also be up on the cliff near Sarltooth. |notinsticky
collect Modr Fragment##2659 |q 299/2 |goto Wetlands/0 34.14,48.48
step
label "Collect_Ados_Fragment"
click Ancient Relic
|tip Large stone box.
|tip Multiple locations. |notinsticky
|tip Can also be up on the cliff near Sarltooth. |notinsticky
collect Ados Fragment##2658 |q 299/1 |goto Wetlands/0 34.14,48.48
step
Follow the path up |goto Wetlands/0 37.11,42.98 < 20 |only if walking
talk Ormer Ironbraid##1078
|tip Walks around.
turnin Ormer's Revenge##296 |goto Wetlands/0 38.18,50.89
step
talk Prospector Whelgar##1077
|tip Inside the small cave.
turnin Uncovering the Past##299 |goto Wetlands/0 38.81,52.39
stickystart "Collect_Dragonmaw_War_Banners"
step
Leave Whelgar's Excavation Site |goto Wetlands/0 34.02,40.85 < 40 |only if walking and subzone("Whelgar's Excavation Site")
Enter the Angerfang Encampment |goto Wetlands/0 42.99,41.33 < 40 |only if walking and not subzone("Angerfang Encampment")
Follow the path up |goto Wetlands/0 41.66,45.36 < 30 |only if walking
click Attack Plan: Ironforge
|tip Piece of paper.
Destroy the Attack Plan: Ironforge |q 98221/4 |goto Wetlands/0 38.46,46.02
step
click Attack Plan: Menethil Harbor
|tip Piece of paper.
Destroy the Attack Plan: Menethil Harbor |q 98221/1 |goto Wetlands/0 45.59,42.60
step
click Attack Plan: Southshore
|tip Piece of paper.
Destroy the Attack Plan: Southshore |q 98221/3 |goto Wetlands/0 45.42,45.72
step
click Attack Plan: Thelsamar
|tip Piece of paper.
Destroy the Attack Plan: Thelsamar |q 98221/2 |goto Wetlands/0 49.46,46.81
step
label "Collect_Dragonmaw_War_Banners"
kill Dragonmaw Raider##1034, Dragonmaw Swamprunner##1035, Dragonmaw Bonewarder##1057, Dragonmaw Centurion##1036, Dragonmaw Shadowwarder##1038, Dragonmaw Battlemaster##1037
|tip Orcs.
collect 8 Dragonmaw War Banner##3337 |q 464/1 |goto Wetlands/0 46.66,46.89
step
talk Howin Kindfeather##270637
turnin Trying Times##98246 |goto Wetlands/0 49.35,42.12
turnin Razormaw Needling##98245 |goto Wetlands/0 49.35,42.12
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin Fire Taboo##277 |goto Wetlands/0 56.37,40.40
accept Blisters on The Land##275 |goto Wetlands/0 56.37,40.40
step
click Musquash Root
collect Musquash Root##2784 |q 335/2 |goto Wetlands/0 64.76,75.29
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 289
|only if Druid
step
talk First Mate Fitzsimmons##1239
turnin The Cursed Crew##289 |goto Wetlands 10.89,59.67
accept Lifting the Curse##290 |goto Wetlands 10.89,59.67
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 286
|only if Mage
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 286
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 286
|only if Hunter
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 286
|only if Priest
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 286
|only if Paladin
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 286
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 286
|only if Warlock
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 286
|only if Rogue
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 286
|only if Shaman
step
talk Karl Boran##1242
|tip Walks around.
turnin Return the Statuette##286 |goto Wetlands 8.31,58.54
accept Return the Statuette##98189 |goto Wetlands 8.31,58.54
step
talk Sylessa Duskwhisper##270844
|tip Upstairs inside the building.
accept Bloom of the Heavens##98208 |goto Wetlands/0 7.92,55.82
step
talk James Halloran##2094
|tip Walks around.
turnin Apprentice's Duties##471 |goto Wetlands/0 8.51,55.71
accept Crocs of the Sky##98072 |goto Wetlands/0 8.51,55.71
step
talk Captain Stoutfist##2104
|tip Upstairs inside the building.
turnin Return the Statuette##98189 |goto Wetlands/0 9.86,57.49
accept A Friend of the Family##98190 |goto Wetlands/0 9.86,57.49
turnin From the Ashes##98221 |goto Wetlands/0 9.86,57.49
turnin War Banners##464 |goto Wetlands/0 9.86,57.49
accept Nek'rosh's Gambit##465 |goto Wetlands/0 9.86,57.49
step
kill Captain Halyndor##1160
|tip Deck of the ship.
|tip Run up the ramp in the back.
collect Intrepid Strongbox Key##2629 |q 290/1 |goto Wetlands 15.45,23.61
step
click Intrepid's Locked Strongbox
|tip Bottom of the ship.
|tip Underwater.
|tip Swim through the hole in the bottom.
turnin Lifting the Curse##290 |goto Wetlands 14.37,24.02
accept The Eye of Paleth##292 |goto Wetlands 14.37,24.02
step
kill 12 Fen Creeper##1040 |q 275/1 |goto Wetlands 47.40,46.90 |or
|tip Stealthed.
|tip Usually near or in water.
|tip Find as many as you can as you travel here.
|tip Can finish later.
|mapmarker Wetlands/0 17.80,27.40
|mapmarker Wetlands/0 19.40,24.60
|mapmarker Wetlands/0 20.20,32.00
|mapmarker Wetlands/0 21.20,28.40
|mapmarker Wetlands/0 22.00,22.40
|mapmarker Wetlands/0 23.20,25.40
|mapmarker Wetlands/0 23.40,31.40
|mapmarker Wetlands/0 25.40,35.40
|mapmarker Wetlands/0 27.00,39.00
|mapmarker Wetlands/0 27.40,32.20
|mapmarker Wetlands/0 27.40,36.40
|mapmarker Wetlands/0 28.40,21.20
|mapmarker Wetlands/0 29.60,23.60
|mapmarker Wetlands/0 31.20,34.60
|mapmarker Wetlands/0 33.00,24.60
|mapmarker Wetlands/0 35.40,33.20
|mapmarker Wetlands/0 37.40,33.00
|mapmarker Wetlands/0 40.40,32.80
'|complete subzone("Angerfang Encampment") |or
step
click Dragonmaw Catapult
turnin Nek'rosh's Gambit##465 |goto Wetlands 47.40,46.90
step
kill 12 Fen Creeper##1040 |q 275/1 |goto Wetlands/0 46.40,35.20
|tip Stealthed.
|tip Usually near or in water.
|mapmarker Wetlands/0 35.40,33.20
|mapmarker Wetlands/0 37.40,33.00
|mapmarker Wetlands/0 40.40,32.80
|mapmarker Wetlands/0 46.40,29.20
|mapmarker Wetlands/0 55.00,46.60
|mapmarker Wetlands/0 47.40,32.80
|mapmarker Wetlands/0 51.00,32.60
|mapmarker Wetlands/0 53.60,36.40
|mapmarker Wetlands/0 53.60,40.20
|mapmarker Wetlands/0 54.20,42.20
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin Blisters on The Land##275 |goto Wetlands/0 56.37,40.40
step
kill Flamesnorting Whelp##1044, Crimson Whelp##1069, Lost Whelp##1043, Red Whelp##1042
|tip Tiny flying dragons.
collect 8 Pristine Crimson Scale##279385 |q 98072/1 |goto Wetlands/0 63.00,41.84
step
Kill enemies
|tip Higher level enemies soon.
ding 29 |goto Wetlands/0 63.00,41.84
step
talk Rhag Garmason##1075
accept The Thandol Span##631 |goto Wetlands 49.92,18.21
step
talk Longbraid the Grim##1071
turnin Fall of Dun Modr##472 |goto Wetlands 49.80,18.26
step
_NOTE:_
During the Next Step
|tip There are {o}2 elite enemies{} inside the bridge.
|tip Run in and {o}crowd control{} them, or use abilities to {o}escape{}.
|tip Click the corpse and run out quickly.
Click Here to Continue |confirm |q 631
step
Enter the doorway on the bridge and run down the stairs |goto Wetlands 51.36,8.11 < 7 |walk
click Ebenezer Rustlocke's Corpse
|tip You will be attacked.
|tip Downstairs inside the bridge.
turnin The Thandol Span##631 |goto Wetlands 51.28,7.95
accept The Thandol Span##632 |goto Wetlands 51.28,7.95
step
talk Rhag Garmason##1075
turnin The Thandol Span##632 |goto Wetlands 49.92,18.22
accept The Thandol Span##633 |goto Wetlands 49.92,18.22
step
Jump off the bridge into the water |goto Wetlands 50.65,8.53 < 15 |only if walking
click Waterlogged Letter
|tip Rolled up white scroll.
|tip In the hand of a dead dwarf.
|tip Underwater.
collect Waterlogged Envelope##4433 |n
use Waterlogged Envelope##4433
accept Sully Balloo's Letter##637 |goto Arathi Highlands 44.29,92.88 |notravel
step
Leave the water and follow the path up |goto Arathi Highlands/0 52.83,90.38 < 30 |q 633 |notravel
|only if walking and (zone("Wetlands") or zone("Arathi Highlands"))
step
click Cache of Explosives
Destroy the Cache of Explosives |q 633/1 |goto Arathi Highlands 48.73,88.05
step
talk Rhag Garmason##1075
turnin The Thandol Span##633 |goto Wetlands 49.92,18.22
accept Plea To The Alliance##634 |goto Wetlands 49.92,18.22
step
talk Captain Nials##2700
|tip Walks around.
turnin Plea To The Alliance##634 |goto Arathi Highlands 45.83,47.55
step
talk Cedrik Prose##2835
fpath Refuge Pointe |goto Arathi Highlands 45.76,46.12
step
talk Darla Harris##2432
fpath Southshore |goto Hillsbrad Foothills 49.34,52.27
step
kill Snapjaw##2408+
|tip Turtles.
|tip Follow the river north.
collect 10 Turtle Meat##3712 |goto Hillsbrad Foothills 55.20,57.00 |q 555 |future
|tip Don't vendor them.
|mapmarker Hillsbrad Foothills/0 55.20,54.00
|mapmarker Hillsbrad Foothills/0 57.40,48.00
|mapmarker Hillsbrad Foothills/0 59.60,45.20
|mapmarker Hillsbrad Foothills/0 63.80,40.60
|mapmarker Hillsbrad Foothills/0 67.20,31.40
|mapmarker Hillsbrad Foothills/0 67.60,35.40
|mapmarker Hillsbrad Foothills/0 67.80,17.80
|mapmarker Hillsbrad Foothills/0 67.80,21.20
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
talk Bibilfaz Featherwhistle##12596
|tip Follow the road.
fpath Chillwind Camp |goto Western Plaguelands 42.93,85.06
step
talk Glorin Steelbrow##1217
|tip Inside the building.
turnin The Eye of Paleth##292 |goto Wetlands 10.58,60.59
accept Cleansing the Eye##293 |goto Wetlands 10.58,60.59
accept Lightforge Iron##321 |goto Wetlands/0 10.58,60.59
step
click Waterlogged Chest
turnin Lightforge Iron##321 |goto Wetlands 12.10,64.17
accept The Lost Ingots##324 |goto Wetlands 12.10,64.17
stickystart "Collect_Lightforge_Ingots"
step
click Nord'el
collect Nord'el##279915 |q 98208/1 |goto Wetlands/0 12.22,63.74
step
label "Collect_Lightforge_Ingots"
kill Bluegill Raider##1418+
|tip Underwater and on the land.
collect 5 Lightforge Ingot##2702 |q 324/1 |goto Wetlands/0 9.91,68.30
step
talk Glorin Steelbrow##1217
|tip Inside the building.
turnin The Lost Ingots##324 |goto Wetlands 10.59,60.59
accept Blessed Arm##322 |goto Wetlands 10.59,60.59
step
talk Sylessa Duskwhisper##270844
|tip Upstairs inside the building.
turnin Bloom of the Heavens##98208 |goto Wetlands/0 7.92,55.82
accept Bloom of the Heavens##98209 |goto Wetlands/0 7.92,55.82
step
talk James Halloran##2094
|tip Walks around.
turnin Crocs of the Sky##98072 |goto Wetlands/0 8.51,55.71
step
talk Micha Yance##2381
|tip Inside the building.
buy Soothing Spices##3713 |goto Hillsbrad Foothills/0 48.94,55.03 |q 555 |future
step
talk Chef Jessen##2430
|tip Inside the building.
accept Soothing Turtle Bisque##555 |goto Hillsbrad Foothills 51.89,58.68
step
talk Chef Jessen##2430
|tip Inside the building.
turnin Soothing Turtle Bisque##555 |goto Hillsbrad Foothills 51.89,58.68
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin Bloom of the Heavens##98209 |goto Darkshore/0 37.39,40.13
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Ashenvale (29-30)",{
image=ZGV.IMAGESDIR.."Ashenvale",
hardcore = true,
next="Leveling Guides\\Duskwood & Stranglethorn Vale (30-32)",
},[[
step
talk Delgren the Purifier##3663
accept The Tower of Althalaxx##1140 |goto Ashenvale 26.20,38.70
step
talk Sentinel Melyria Frostshadow##3880
accept The Howling Vale##1022 |goto Ashenvale 22.23,52.98
step
talk Illiyana##3901
accept Vile Satyr! Dryads in Danger!##1021 |goto Ashenvale 21.73,53.35
step
talk Shindrell Swiftfire##3845
accept Kayneth Stillwind##4581 |goto Ashenvale 34.67,48.84
step
talk Raene Wolfrunner##3691
|tip Inside the building.
accept Raene's Cleansing##1024 |goto Ashenvale 36.62,49.58
|tip Grey quest, but followups give lots of xp.
step
talk Pelturas Whitemoon##3894
|tip Inside the building.
accept Fallen Sky Lake##1035 |goto Ashenvale 37.37,51.79
step
Follow the road to this path |goto Ashenvale 50.22,56.23 < 50 |only if walking and not subzone("Moonwell")
Continue following the path |goto Ashenvale 51.80,45.73 < 40 |only if walking and not subzone("Moonwell")
talk Shael'dryn##3916
|tip Walks around.
turnin Raene's Cleansing##1024 |goto Ashenvale 53.54,46.29
accept Raene's Cleansing##1026 |goto Ashenvale 53.54,46.29
step
kill Withered Ancient##3919, Crazed Ancient##3834
|tip Walking trees.
|tip Run around the mountain.
collect Wooden Key##5475 |goto Ashenvale/0 62.60,46.80 |q 1026
|mapmarker Ashenvale/0 54.60,34.00
|mapmarker Ashenvale/0 55.00,40.60
|mapmarker Ashenvale/0 56.80,29.80
|mapmarker Ashenvale/0 58.40,36.40
|mapmarker Ashenvale/0 59.80,39.40
|mapmarker Ashenvale/0 61.40,43.20
step
click Worn Chest##19022
collect Iron Shaft##5464 |q 1026/1 |goto Ashenvale 54.41,35.39
step
Follow the path up and through the tunnel |goto Ashenvale 54.17,32.34 < 20 |only if walking and not subzone("The Howling Vale")
click Tome of Mel'Thandris##19027
View the Tome of Mel'Thandris |q 1022/1 |goto Ashenvale 50.49,39.13
step
Run through the tunnel to leave the Howling Vale |goto Ashenvale 51.33,38.20 < 20 |only if walking and subzone("The Howling Vale")
Follow the path up |goto Ashenvale 63.56,43.87 < 30 |only if walking and not subzone("Xavian")
talk Kayneth Stillwind##3848
|tip Walks around.
turnin Kayneth Stillwind##4581 |goto Ashenvale 85.24,44.71
accept Forsaken Diseases##1011 |goto Ashenvale 85.24,44.71
step
talk Maseara Autumnmoon##221269
|tip Walks around.
accept Vengeful Trail##98417 |goto Ashenvale/0 86.26,45.85
stickystart "Collect_Vine_Wrapped_Scroll"
step
click Circle of Imprisonment##19901
|tip Careful, stealthed enemies.
Free the Highborne Soul in Satyrnaar |q 1140/2 |goto Ashenvale 81.60,48.58
step
label "Collect_Vine_Wrapped_Scroll"
click Kurothel's Knapsack
|tip Brown bag.
|tip Near tents and other structures.
collect Vine-Wrapped Scroll##281014 |q 98417 |goto Ashenvale/0 80.92,49.63
step
talk Maseara Autumnmoon##221269
|tip Walks around.
turnin Vengeful Trail##98417 |goto Ashenvale/0 86.26,45.85
accept Shared Fury##98418 |goto Ashenvale/0 86.26,45.85
stickystart "Kill_Xavian_Enemies"
step
talk Anilia##3920
turnin Vile Satyr! Dryads in Danger!##1021 |goto Ashenvale 78.32,44.82
accept The Branch of Cenarius##1031 |goto Ashenvale 78.32,44.82
step
kill Geltharis##4619
|tip Careful, level 32. |only if hardcore()
collect Branch of Cenarius##5461 |q 1031/1 |goto Ashenvale 78.00,42.42
step
label "Kill_Xavian_Enemies"
kill 5 Xavian Betrayer##3754 |q 98418/1 |goto Ashenvale/0 78.78,45.76
kill 5 Xavian Felsworn##3755 |q 98418/2 |goto Ashenvale/0 78.78,45.76
kill 5 Xavian Hellcaller##3757 |q 98418/3 |goto Ashenvale/0 78.78,45.76
kill 5 Xavian Rogue##3752 |q 98418/4 |goto Ashenvale/0 78.78,45.76
step
talk Maseara Autumnmoon##221269
|tip Walks around.
turnin Shared Fury##98418 |goto Ashenvale/0 86.26,45.85
step
talk Sentinel Melyria Frostshadow##3880
turnin The Howling Vale##1022 |goto Ashenvale 22.23,52.98
accept Velinde Starsong##1037 |goto Ashenvale 22.23,52.98
step
talk Illiyana##3901
turnin The Branch of Cenarius##1031 |goto Ashenvale 21.73,53.35
accept Satyr Slaying!##1032 |goto Ashenvale 21.73,53.35
step
talk Maluressian##10052
Stable Your Pet |stablemaster Maluressian##10052 |goto Ashenvale 36.51,50.36 |q 1026
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 4){}.
|only if Hunter
step
Learn the {y}Claw (Rank 4){} Pet Ability |learnspell Claw##3667 |goto Ashenvale 61.60,63.60 |q 1026
|tip Cast {o}Tame Beast{} on an {o}Elder Ashenvale Bear{}.
|tip Kill enemies nearby.
|mapmarker Ashenvale/0 62.20,55.20
|mapmarker Ashenvale/0 63.00,68.60
|mapmarker Ashenvale/0 64.40,58.00
|mapmarker Ashenvale/0 64.40,65.20
|mapmarker Ashenvale/0 66.00,60.80
|only if Hunter
step
talk Maluressian##10052
Retrieve Your Pet |stablemaster Maluressian##10052 |goto Ashenvale 36.51,50.36 |q 1026
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 4){} to Your Pet |learnpetspell Claw##16830 |q 1026
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
Follow the road to this path |goto Ashenvale 50.22,56.23 < 50 |only if walking and not subzone("Moonwell")
talk Shael'dryn##3916
|tip Walks around.
turnin Raene's Cleansing##1026 |goto Ashenvale 53.54,46.29
accept Raene's Cleansing##1027 |goto Ashenvale 53.54,46.29
step
kill Shadethicket Oracle##3931
collect Fallen Moonstone##5508 |q 1035/1 |goto Ashenvale 66.68,82.19
step
kill Rotting Slime##3928+
click Rusty Chest+
|tip Appear on the ground.
collect Iron Pommel##5519 |q 1027/1 |goto Ashenvale/0 69.40,75.80
|mapmarker Ashenvale/0 71.00,72.40
|mapmarker Ashenvale/0 72.40,76.60
|mapmarker Ashenvale/0 73.80,73.80
|mapmarker Ashenvale/0 74.80,70.00
|mapmarker Ashenvale/0 76.60,72.40
|mapmarker Ashenvale/0 77.00,67.40
|mapmarker Ashenvale/0 78.20,64.40
|mapmarker Ashenvale/0 79.00,74.40
step
click Bottle of Disease
|tip Careful, stealthed enemies.
collect Bottle of Disease##5440 |q 1011/1 |goto Ashenvale 75.29,72.22
step
talk Kayneth Stillwind##3848
|tip Walks around.
turnin Forsaken Diseases##1011 |goto Ashenvale 85.24,44.71
stickystart "Collect_Satyr_Horns"
step
Follow the path up |goto Ashenvale/0 71.38,49.63 < 30 |only if walking and not subzone("Night Run")
click Circle of Imprisonment##19901
|tip Careful, stealthed enemies.
Free the Highborne Soul in Night Run |q 1140/1 |goto Ashenvale 66.63,56.98
step
label "Collect_Satyr_Horns"
kill Felmusk Felsworn##3762, Felmusk Rogue##3759, Felmusk Satyr##3758, Felmusk Shadowstalker##3763, Bleakheart Satyr##3765, Bleakheart Hellcaller##3771, Bleakheart Shadowstalker##3770, Bleakheart Trickster##3767, Xavian Felsworn##3755, Xavian Betrayer##3754, Xavian Rogue##3752, Xavian Hellcaller##3757
|tip Satyrs.
|tip Careful, stealthed enemies. |notinsticky
collect 16 Satyr Horns##5481 |q 1032/1 |goto Ashenvale 68.60,53.40
|mapmarker Ashenvale/0 66.20,54.20
|mapmarker Ashenvale/0 66.40,51.80
|mapmarker Ashenvale/0 67.60,54.60
|mapmarker Ashenvale/0 66.60,56.60
step
Follow the road to this path |goto Ashenvale 50.22,56.23 < 70 |only if walking and not subzone("Moonwell")
talk Shael'dryn##3916
|tip Walks around.
turnin Raene's Cleansing##1027 |goto Ashenvale 53.54,46.21
step
Watch the dialogue
talk Shael'dryn##3916
|tip Walks around.
accept Raene's Cleansing##1028 |goto Ashenvale 53.54,46.21
step
Run around the mountain and follow the winding dirt path up to the shrine |goto Ashenvale 56.04,51.28 < 20 |only if walking
click Hidden Shrine##19024
|tip Top of the mountain.
turnin Raene's Cleansing##1028 |goto Ashenvale/0 56.38,49.23
accept Raene's Cleansing##1055 |goto Ashenvale/0 56.38,49.23
step
Run around the mountain and follow the path |goto Ashenvale 51.80,45.73 < 40 |only if walking and not subzone("Moonwell")
talk Shael'dryn##3916
|tip Walks around.
turnin Raene's Cleansing##1055 |goto Ashenvale/0 53.54,46.21
accept Raene's Cleansing##1029 |goto Ashenvale/0 53.54,46.21
step
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin Fallen Sky Lake##1035 |goto Ashenvale/0 37.36,51.79
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Raene's Cleansing##1029 |goto Ashenvale/0 36.62,49.58
accept Raene's Cleansing##1030 |goto Ashenvale/0 36.62,49.58
step
talk Danlaar Nightstride##3963
|tip Inside the building.
Train Abilities |trainer Danlaar Nightstride##3963 |goto Ashenvale/0 50.14,67.95 |q 1030
|only if Hunter
step
talk Caelyb##4320
|tip Inside the building.
Train Pet Abilities |trainer Caelyb##4320 |goto Ashenvale/0 49.72,66.97 |q 1030
|only if Hunter
step
use Dartol's Rod of Transformation##5462
|tip At this location.
Gain Furbolg Form |havebuff Furbolg Form##6405 |goto Ashenvale/0 53.67,73.97 |q 1030
step
talk Krolg##3897
turnin Raene's Cleansing##1030 |goto Ashenvale/0 50.85,75.07
accept Raene's Cleansing##1045 |goto Ashenvale/0 50.85,75.07
stickystart "Kill_Bloodtooth_Guards"
step
Follow the path up |goto Ashenvale/0 55.35,75.83 < 40 |only if walking and not subzone("Bloodtooth Camp")
kill Ran Bloodtooth##3696
collect Ran Bloodtooth's Skull##5388 |q 1045/2 |goto Ashenvale/0 54.74,79.61
step
label "Kill_Bloodtooth_Guards"
kill 4 Bloodtooth Guard##3932 |q 1045/1 |goto Ashenvale/0 54.40,79.40
|mapmarker Ashenvale/0 54.80,75.80
step
use Dartol's Rod of Transformation##5462
|tip At this location.
Gain Furbolg Form |havebuff Furbolg Form##6405 |goto Ashenvale/0 53.67,73.97 |q 1045
step
talk Krolg##3897
turnin Raene's Cleansing##1045 |goto Ashenvale/0 50.85,75.07
accept Raene's Cleansing##1046 |goto Ashenvale/0 50.85,75.07
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Raene's Cleansing##1046 |goto Ashenvale/0 36.62,49.58
|only if haveq(1046) or completedq(1046)
step
talk Illiyana##3901
turnin Satyr Slaying!##1032 |goto Ashenvale/0 21.73,53.34
step
talk Delgren the Purifier##3663
turnin The Tower of Althalaxx##1140 |goto Ashenvale/0 26.19,38.70
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1037
|only if Druid
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 1037
|only if Rogue
step
talk Thyn'tel Bladeweaver##8026
turnin Velinde Starsong##1037 |goto Darnassus 61.78,39.19
accept Velinde's Effects##1038 |goto Darnassus 61.78,39.19
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 1038
|only if Warrior
step
Run up the ramp |goto Darnassus 56.05,79.18 < 10 |only if walking
Cross the bridge |goto Darnassus 57.63,77.23 < 7 |only if walking
click Velinde's Locker
|tip Upstairs inside the building.
collect Velinde's Journal##5520 |q 1038/1 |goto Darnassus 62.29,83.24
step
talk Elissa Dumas##4165
|tip Inside the building.
learnspell Teleport: Darnassus##3565 |goto Darnassus 40.60,82.13
|only if Mage
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 1038
|only if Priest
step
talk Thyn'tel Bladeweaver##8026
turnin Velinde's Effects##1038 |goto Darnassus 61.78,39.19
accept The Barrens Port##1039 |goto Darnassus 61.78,39.19
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 637
|only if Mage
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 637
|only if Paladin
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 637
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 637
|only if Warlock
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 637
|only if Shaman
step
talk Sara Balloo##2695
turnin Sully Balloo's Letter##637 |goto Ironforge 63.48,67.29
step
Watch the dialogue
talk Sara Balloo##2695
accept Sara Balloo's Plea##683 |goto Ironforge 63.48,67.29
step
Follow the path |goto Ironforge 44.56,49.58 < 15 |walk |only if not subzone("The High Seat")
talk King Magni Bronzebeard##2784
turnin Sara Balloo's Plea##683 |goto Ironforge 39.11,56.17
accept A King's Tribute##686 |goto Ironforge 39.11,56.17
step
talk Grand Mason Marblesten##2790
|tip Walks around.
|tip Inside the building.
turnin A King's Tribute##686 |goto Ironforge 39.03,88.02
accept A King's Tribute##689 |goto Ironforge 39.03,88.02
step
talk Pilot Longbeard##2092
|tip Inside the building.
accept The Brassbolts Brothers##1179 |goto Ironforge 72.73,94.01
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Duskwood & Stranglethorn Vale (30-32)",{
image=ZGV.IMAGESDIR.."Duskwood",
hardcore = true,
next="Leveling Guides\\Hillsbrad Foothills & Arathi Highlands (32-33)",
},[[
stickystart "Accept_The_Missing_Diplomat"
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Archbishop Benedictus##1284
|tip Inside the building.
turnin Cleansing the Eye##293 |goto Stormwind City 50.30,45.50
step
label "Accept_The_Missing_Diplomat"
talk Thomas##4982
|tip Walks around.
|tip Inside the building. |notinsticky
accept The Missing Diplomat##1274 |goto Stormwind City 50.91,47.16
step
talk Grimand Elmore##1416
|tip Inside the building.
turnin Blessed Arm##322 |goto Stormwind City 59.71,33.74
accept Armed and Ready##325 |goto Stormwind City 59.71,33.74
step
Enter Stormwind Keep |goto Stormwind City 73.08,46.68 < 15 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin A Friend of the Family##98190 |goto Stormwind City/0 80.20,38.34
accept A Friend of the Family##98191 |goto Stormwind City/0 80.20,38.34
step
talk Bishop DeLavey##4960
|tip Walks around.
|tip Inside the building.
turnin The Missing Diplomat##1274 |goto Stormwind City 80.21,44.10
accept The Missing Diplomat##1241 |goto Stormwind City 80.21,44.10
step
use An Old History Book##2794
accept An Old History Book##337
|only if itemcount(2794) > 0
step
Follow the path |goto Stormwind City 75.90,42.15 < 10 |walk
talk Milton Sheaf##1440
|tip Inside the building.
turnin An Old History Book##337 |goto Stormwind City 77.02,30.20
accept Southshore##538 |goto Stormwind City 77.02,30.20
|only if haveq(337) or completedq(337)
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
turnin A Friend of the Family##98191 |goto Stormwind City/0 48.43,50.22
accept The Shamed Lieutenant##98219 |goto Stormwind City/0 48.43,50.22
step
talk Jorgen##4959
|tip Next to the water.
turnin The Missing Diplomat##1241 |goto Stormwind City 76.25,85.11
accept The Missing Diplomat##1242 |goto Stormwind City 76.25,85.11
step
talk Elling Trias##482
|tip Upstairs inside the building.
turnin The Missing Diplomat##1242 |goto Stormwind City 66.00,74.08
accept The Missing Diplomat##1243 |goto Stormwind City 66.00,74.08
step
talk Olivia Burnside##2455
|tip Deposit into the bank.
|tip Inside the building.
bank Crate of Crash Helmets##5849 |goto Stormwind City 64.26,80.75 |q 1179 |only if haveq(1179) or completedq(1179)
bank Musquash Root##2784 |goto Stormwind City 64.26,80.75 |q 335 |only if haveq(335) or completedq(335)
step
talk Olivia Burnside##2455
|tip Collect from the bank.
|tip Inside the building.
collect A Torn Journal Page##916 |goto Stormwind City 64.26,80.75 |q 74 |only if haveq(74) or completedq(74)
collect Bottle of Zombie Juice##1451 |goto Stormwind City 64.26,80.75 |q 159 |only if haveq(159) or completedq(159)
step
talk Viktori Prism'Antras##276
|tip Inside the building.
accept Look To The Stars##181 |goto Duskwood 79.80,48.02
step
talk Calor##663
|tip Walks around.
accept Worgen in the Woods##173 |goto Duskwood 75.30,48.05
step
talk Commander Althea Ebonlocke##264
|tip Walks around.
accept The Night Watch##58 |goto Duskwood 73.60,46.90
step
talk Innkeeper Trelayne##6790
|tip Inside the building.
home Darkshire |goto Duskwood 73.87,44.41 |q 538 |future
step
map Duskwood
path follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	74.82,44.16	74.53,41.22	73.87,39.60	72.74,38.35	72.28,37.28
path	72.24,35.19	72.58,33.53	73.31,32.54
talk Watcher Backus##840
|tip Walks along the road.
turnin The Missing Diplomat##1243
accept The Missing Diplomat##1244
step
kill 6 Nightbane Shadow Weaver##533 |q 173/1 |goto Duskwood/0 62.45,42.17
step
talk Calor##663
|tip Walks around.
turnin Worgen in the Woods##173 |goto Duskwood 75.30,48.05
accept Worgen in the Woods##221 |goto Duskwood 75.30,48.05
stickystart "Kill_Nightbane_Dark_Runners"
step
kill Nightbane Dark Runner##205, Nightbane Shadow Weaver##533, Nightbane Worgen##898
|tip Worgen.
collect An Old History Book##2794 |n
use An Old History Book##2794
accept An Old History Book##337 |goto Duskwood/0 63.32,45.72
step
label "Kill_Nightbane_Dark_Runners"
kill 12 Nightbane Dark Runner##205 |q 221/1 |goto Duskwood/0 63.32,45.72
step
talk Marshal Haggard##294
turnin The Legend of Stalvan##74 |goto Elwynn Forest 84.61,69.38
accept The Legend of Stalvan##75 |goto Elwynn Forest 84.61,69.38
step
click Marshal Haggard's Chest
|tip You will be attacked.
|tip Upstairs inside the building.
collect A Faded Journal Page##921 |q 75/1 |goto Elwynn Forest 85.69,69.55
step
talk Marshal Haggard##294
turnin The Legend of Stalvan##75 |goto Elwynn Forest 84.61,69.38
accept The Legend of Stalvan##78 |goto Elwynn Forest 84.61,69.38
step
talk Abercrombie##289
|tip Inside the building.
turnin Juice Delivery##159 |goto Duskwood 28.11,31.47
accept Ghoulish Effigy##133 |goto Duskwood 28.11,31.47
stickystart "Kill_Plague_Spreaders"
step
kill Flesh Eater##3, Bone Chewer##210, Plague Spreader##604, Rotted One##948, Brain Eater##570
|tip Ghouls.
|tip Inside and outside the crypt.
collect 7 Ghoul Rib##884 |q 133/1 |goto Duskwood/0 23.93,34.82
step
label "Kill_Plague_Spreaders"
kill 20 Plague Spreader##604 |q 58/1 |goto Duskwood/0 23.93,34.82
|tip Shared spawns with other ghouls.
|tip Inside and outside the crypt. |notinsticky
step
Leave the crypt |goto Duskwood 23.63,34.92 < 15 |walk |only if subzone("Dawning Wood Catacombs") and indoors()
talk Abercrombie##289
|tip Inside the building.
turnin Ghoulish Effigy##133 |goto Duskwood 28.11,31.47
accept Ogre Thieves##134 |goto Duskwood 28.11,31.47
step
click Defias Strongbox
|tip Inside the building.
collect Defias Docket##5947 |q 1244/1 |goto Duskwood 23.93,72.07
step
click Abercrombie's Crate
collect Abercrombie's Crate##1349 |q 134/1 |goto Duskwood 33.42,76.34
step
Enter the cave |goto Duskwood 34.08,77.02 < 15 |walk |only if not (subzone("Vul'Gol Ogre Mound") and indoors())
kill Zzarc' Vul##300
|tip Inside the cave.
|tip Multiple locations.
collect Ogre's Monocle##1968 |q 181/1 |goto Duskwood/0 36.06,80.58
|mapmarker Duskwood/0 35.00,81.40
|mapmarker Duskwood/0 36.80,83.20
|mapmarker Duskwood/0 37.60,79.40
step
Leave the cave |goto Duskwood 34.08,77.02 < 15 |walk |only if subzone("Vul'Gol Ogre Mound") and indoors()
talk Abercrombie##289
|tip Inside the building.
turnin Ogre Thieves##134 |goto Duskwood 28.11,31.47
accept Note to the Mayor##160 |goto Duskwood 28.11,31.47
step
click A Weathered Grave
accept The Weathered Grave##225 |goto Duskwood 17.72,29.08
step
talk Sven Yorgen##311
|tip Walks around.
turnin Armed and Ready##325 |goto Duskwood/0 7.78,34.07
step
talk Tavernkeep Smitts##273
|tip Walks around.
|tip Inside the building.
turnin The Legend of Stalvan##78 |goto Duskwood 73.78,44.48
accept The Legend of Stalvan##79 |goto Duskwood 73.78,44.48
step
talk Commander Althea Ebonlocke##264
|tip Walks around.
turnin The Night Watch##58 |goto Duskwood 73.59,46.89
turnin The Legend of Stalvan##79 |goto Duskwood 73.59,46.89
accept The Legend of Stalvan##80 |goto Duskwood 73.59,46.89
step
talk Clerk Daltry##267
|tip Walks around.
|tip Inside the building.
turnin The Legend of Stalvan##80 |goto Duskwood 72.52,46.85
accept The Legend of Stalvan##97 |goto Duskwood 72.52,46.85
step
talk Sirra Von'Indi##268
|tip Inside the building.
turnin The Weathered Grave##225 |goto Duskwood 72.64,47.62
accept Morgan Ladimore##227 |goto Duskwood 72.64,47.62
step
talk Lord Ello Ebonlocke##263
|tip Inside the building.
turnin Note to the Mayor##160 |goto Duskwood 71.93,46.42
accept Translate Abercrombie's Note##251 |goto Duskwood 71.93,46.42
step
talk Sirra Von'Indi##268
|tip Walks around.
|tip Inside the building.
turnin Translate Abercrombie's Note##251 |goto Duskwood 72.64,47.62
accept Wait for Sirra to Finish##401 |goto Duskwood 72.64,47.62
step
talk Sirra Von'Indi##268
|tip Walks around.
|tip Inside the building.
turnin Wait for Sirra to Finish##401 |goto Duskwood 72.64,47.62
accept Translation to Ello##252 |goto Duskwood 72.64,47.62
step
talk Lord Ello Ebonlocke##263
|tip Inside the building.
turnin Translation to Ello##252 |goto Duskwood 71.93,46.42
step
talk Commander Althea Ebonlocke##264
|tip Walks around.
turnin Morgan Ladimore##227 |goto Duskwood 73.59,46.89
turnin The Legend of Stalvan##97 |goto Duskwood 73.59,46.89
accept The Legend of Stalvan##98 |goto Duskwood 73.59,46.89
step
talk Calor##663
|tip Walks around.
turnin Worgen in the Woods##221 |goto Duskwood 75.30,48.05
accept Worgen in the Woods##222 |goto Duskwood 75.30,48.05
step
_Destroy These Item:_
|tip Not needed.
trash The Story of Morgan Ladimore##2154
trash Translated Letter from The Embalmer##3248
step
talk Viktori Prism'Antras##276
|tip Inside the building.
turnin Look To The Stars##181 |goto Duskwood 79.80,48.02
step
map Duskwood
path follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	74.82,44.16	74.53,41.22	73.87,39.60	72.74,38.35	72.28,37.28
path	72.24,35.19	72.58,33.53	73.31,32.54
talk Watcher Backus##840
|tip Walks along the road.
turnin The Missing Diplomat##1244
accept The Missing Diplomat##1245
stickystart "Collect_Mistmantle_Famiy_Ring"
step
click Tear of Tilloa
collect Tear of Tilloa##2779 |q 335/1 |goto Duskwood/0 78.37,35.90
step
label "Collect_Mistmantle_Famiy_Ring"
kill Stalvan Mistmantle##315
|tip Inside or outside the building. |notinsticky
collect Mistmantle Family Ring##3629 |q 98/1 |goto Duskwood 77.35,36.19
step
talk Madame Eva##265
|tip Walks around.
|tip Inside the building.
turnin The Legend of Stalvan##98 |goto Duskwood 75.82,45.29
step
kill 8 Nightbane Tainted One##920 |q 222/2 |goto Duskwood 73.03,75.08
|tip Inside the mine.
kill 8 Nightbane Vile Fang##206 |q 222/1 |goto Duskwood 73.03,75.08
|tip Outside the mine.
step
Kill enemies
|tip Inside and outside the mine.
ding 32 |goto Duskwood 73.03,75.08
step
talk Private Thorsen##738
|tip Walks the path to the south every {o}20-30 minutes{}.
|tip Two enemies attack him.
|tip Save him to get a quest.
|tip Unlocks a quest chain.
|tip Wait now to save time later.
accept Jungle Secrets##215 |goto Stranglethorn Vale 37.98,3.41
|mapmarker Stranglethorn Vale 40.34,8.44
step
talk Barnil Stonepot##716
accept Welcome to the Jungle##583 |goto Stranglethorn Vale 35.66,10.53
step
talk Hemet Nesingwary##715
turnin Welcome to the Jungle##583 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
accept Tiger Mastery##185 |goto Stranglethorn Vale 35.61,10.62
step
talk Sir S. J. Erlgadin##718
accept Panther Mastery##190 |goto Stranglethorn Vale 35.55,10.55
stickystart "Kill_Young_Panthers"
step
kill 10 Young Stranglethorn Tiger##681 |q 185/1 |goto Stranglethorn Vale/0 34.96,12.57
step
label "Kill_Young_Panthers"
kill 10 Young Panther##683 |q 190/1 |goto Stranglethorn Vale/0 41.16,10.68
step
talk Ajeck Rouack##717
turnin Tiger Mastery##185 |goto Stranglethorn Vale 35.61,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##190 |goto Stranglethorn Vale 35.55,10.55
step
talk Lieutenant Doren##469
turnin Jungle Secrets##215 |goto Stranglethorn Vale 38.04,3.01
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 222
|only if Druid
step
talk Calor##663
|tip Walks around.
turnin Worgen in the Woods##222 |goto Duskwood 75.30,48.05
accept Worgen in the Woods##223 |goto Duskwood 75.30,48.05
step
talk Jonathan Carevin##661
|tip Walks around.
|tip Inside the building.
turnin Worgen in the Woods##223 |goto Duskwood 75.32,49.02
step
talk Elsharin##5498
|tip Top of the tower.
Train Abilities |trainer Elsharin##5498 |goto Stormwind City/0 48.20,87.21 |q 1245
|only if Mage
step
talk Archmage Malin##2708
accept Malin's Request##690 |goto Stormwind City/0 50.50,87.47
|only if Mage
step
Enter the building |goto Stormwind City/0 50.51,90.40 < 10 |walk
talk Connor Rivers##5081
|tip Inside the building.
accept James Hyal##1301 |goto Stormwind City 51.10,95.50
|only if Mage
step
Enter the building |goto Stormwind City 42.27,81.78 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Zardeth of the Black Claw##1435
|tip Downstairs inside the building.
turnin A Noble Brew##335 |goto Stormwind City 40.15,85.29
accept A Noble Brew##336 |goto Stormwind City 40.15,85.29
|only if Mage
step
talk Olivia Burnside##2455
|tip Collect from the bank.
|tip Inside the building.
collect Crate of Crash Helmets##5849 |goto Stormwind City 64.26,80.75 |q 1179 |only if haveq(1179) or completedq(1179)
collect Musquash Root##2784 |goto Stormwind City 64.26,80.75 |q 335 |only if haveq(335) or completedq(335)
|only if Mage
step
talk Auctioneer Jaxon##15659
|tip Buy from the Auction House, if possible.
|tip Needed for future quest.
|tip Inside the building.
buy Hillman's Cloak##3719 |goto Stormwind City/0 61.13,70.67 |q 565 |future
buy Bolt of Woolen Cloth##2997 |goto Stormwind City/0 61.13,70.67 |q 565 |future
|tip Don't vendor them.
|only if Mage
step
talk Elling Trias##482
|tip Upstairs inside the building.
turnin The Missing Diplomat##1245 |goto Stormwind City 66.00,74.08
accept The Missing Diplomat##1246 |goto Stormwind City 66.00,74.08
step
talk Auctioneer Jaxon##15659
|tip Buy from the Auction House, if possible.
|tip Needed for future quest.
|tip Inside the building.
buy Hillman's Cloak##3719 |goto Stormwind City/0 61.13,70.67 |q 565 |future
buy Bolt of Woolen Cloth##2997 |goto Stormwind City/0 61.13,70.67 |q 565 |future
|tip Don't vendor them.
|only if not Mage
step
talk Olivia Burnside##2455
|tip Collect from the bank.
|tip Inside the building.
collect Crate of Crash Helmets##5849 |goto Stormwind City 64.26,80.75 |q 1179 |only if haveq(1179) or completedq(1179)
collect Musquash Root##2784 |goto Stormwind City 64.26,80.75 |q 335 |only if haveq(335) or completedq(335)
|only if not Mage
step
talk Archmage Malin##2708
accept Malin's Request##690 |goto Stormwind City/0 50.50,87.47
|only if not Mage
step
Enter the building |goto Stormwind City/0 50.51,90.40 < 10 |walk
talk Connor Rivers##5081
|tip Inside the building.
accept James Hyal##1301 |goto Stormwind City 51.10,95.50
|only if not Mage
step
Enter the building |goto Stormwind City 42.27,81.78 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Zardeth of the Black Claw##1435
|tip Downstairs inside the building.
turnin A Noble Brew##335 |goto Stormwind City 40.15,85.29
accept A Noble Brew##336 |goto Stormwind City 40.15,85.29
|only if not Mage
step
Enter the building |goto Stormwind City 42.27,81.78 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Demisette Cloyce##461
|tip Downstairs inside the building.
Train Abilities |trainer Demisette Cloyce##461 |goto Stormwind City/0 39.25,84.96 |q 1246
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.52 |q 1246
|only if Warlock
step
talk Gakin the Darkbinder##6122
|tip Inside the building.
accept Seeking Strahad##1798 |goto Stormwind City 39.23,85.21
|only if Warlock
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.06 |q 1246
|only if Paladin
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.64,46.42 |q 1246
|only if Priest
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 1246
|only if Warrior
step
talk Wu Shen##5479
|tip Upstairs inside the building.
accept The Islander##1718 |goto Stormwind City 80.50,59.85
|only if Warrior
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 1246
|only if Rogue
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 1246
|only if Hunter
step
_NOTE:_
During Next Steps
|tip {o}Dashel Stonefist{} attacks after you accept the quest.
|tip Two enemy helpers appear.
|tip Dashel surrenders around {o}25% health{}.
Click Here to Continue |confirm |q 1447 |future
step
talk Dashel Stonefist##4961
|tip You will be attacked.
|tip In the alley between buildings.
turnin The Missing Diplomat##1246 |goto Stormwind City 74.21,59.15
accept The Missing Diplomat##1447 |goto Stormwind City 74.21,59.15
step
kill Dashel Stonefist##4961
Watch the dialogue
Defeat Dashel Stonefist |q 1447/1 |goto Stormwind City 74.21,59.15
step
talk Dashel Stonefist##4961
turnin The Missing Diplomat##1447 |goto Stormwind City 74.21,59.15
accept The Missing Diplomat##1247 |goto Stormwind City 74.21,59.15
step
Enter the building |goto Stormwind City 73.09,46.62 < 15 |walk |only if not (subzone("Stormwind Keep") or subzone("Petitioner's Chamber"))
talk Lord Baurles K. Wishock##1439
|tip Inside the building.
turnin A Noble Brew##336 |goto Stormwind City 77.84,48.92
step
talk Milton Sheaf##1440
|tip Inside the building.
turnin An Old History Book##337 |goto Stormwind City 77.02,30.20
accept Southshore##538 |goto Stormwind City 77.02,30.20
step
talk Elling Trias##482
|tip Upstairs inside the building.
turnin The Missing Diplomat##1247 |goto Stormwind City 66.00,74.08
accept The Missing Diplomat##1248 |goto Stormwind City 66.00,74.08
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 1301
|only if Shaman
step
talk Vincent Hyal##5082
|tip Inside the building.
turnin James Hyal##1301 |goto Wetlands/0 10.83,60.40
accept James Hyal##1302 |goto Wetlands/0 10.83,60.40
step
_NOTE:_
During the Next Steps
|tip Locate {o}Tapoke "Slim" Jahn{} near the building entrance.
|tip He stealths and flees the building after you accept the quest.
|tip Follow and attack him quickly.
|tip He summons a helper.
|tip {o}Sheep Tapoke immediately{} to prevent summoning helper.			|only if Mage
|tip Ignore the helper and focus on killing {o}Tapoke{}.			|only if not Mage
|tip Surrenders around {o}15% health{}.
|tip Helper disappears.
Click Here to Continue |confirm |q 1249 |future
step
talk Mikhail##4963
|tip Inside the building.
turnin The Missing Diplomat##1248 |goto Wetlands 10.60,60.77
accept The Missing Diplomat##1249 |goto Wetlands 10.60,60.77
step
kill Tapoke "Slim" Jahn##4962
Watch the dialogue
Defeat Tapoke Jahn |q 1249/1 |goto Wetlands 10.79,59.60
step
talk Mikhail##4963
|tip Inside the building.
turnin The Missing Diplomat##1249 |goto Wetlands 10.60,60.77
step
talk Tapoke "Slim" Jahn##4962
|tip Inside the building.
accept The Missing Diplomat##1250 |goto Wetlands 10.54,60.26
step
talk Mikhail##4963
|tip Inside the building.
turnin The Missing Diplomat##1250 |goto Wetlands 10.60,60.77
accept The Missing Diplomat##1264 |goto Wetlands 10.60,60.77
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Hillsbrad Foothills & Arathi Highlands (32-33)",{
image=ZGV.IMAGESDIR.."Hillsbrad Foothills",
hardcore = true,
next="Leveling Guides\\Dustwallow Marsh & Thousand Needles (33-34)",
},[[
step
talk Bartolo Ginsetti##2438
accept Bartolo's Yeti Fur Cloak##565 |goto Hillsbrad Foothills/0 49.43,55.53
|only if itemcount(3719) > 0 and itemcount(2997) > 0
step
talk Darren Malvew##2382
accept Costly Menace##564 |goto Hillsbrad Foothills 52.42,55.96
step
talk Loremaster Dibbs##2277
turnin Southshore##538 |goto Hillsbrad Foothills 50.57,57.09
step
talk Innkeeper Anderson##2352
|tip Inside the building.
home Southshore |goto Hillsbrad Foothills/0 51.17,58.93 |q 700 |future
step
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin The Shamed Lieutenant##98219 |goto Hillsbrad Foothills 51.46,58.38
accept Down the Coast##536 |goto Hillsbrad Foothills 51.46,58.38
step
kill 10 Torn Fin Tidehunter##2377 |q 536/1 |goto Hillsbrad Foothills/0 42.79,67.89
kill 10 Torn Fin Oracle##2376 |q 536/2 |goto Hillsbrad Foothills/0 42.79,67.89
|tip More in the water.
step
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Down the Coast##536 |goto Hillsbrad Foothills 51.46,58.38
accept Farren's Proof##559 |goto Hillsbrad Foothills 51.46,58.38
step
kill Torn Fin Tidehunter##2377, Torn Fin Oracle##2376, Torn Fin Coastrunner##2375, Torn Fin Muckdweller##2374
|tip More in the water.
collect 10 Murloc Head##3716 |q 559/1 |goto Hillsbrad Foothills/0 42.79,67.89
step
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Farren's Proof##559 |goto Hillsbrad Foothills 51.46,58.38
accept Farren's Proof##560 |goto Hillsbrad Foothills 51.46,58.38
step
talk Marshal Redpath##2263
turnin Farren's Proof##560 |goto Hillsbrad Foothills 49.48,58.73
accept Farren's Proof##561 |goto Hillsbrad Foothills 49.48,58.73
step
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Farren's Proof##561 |goto Hillsbrad Foothills 51.46,58.38
accept Stormwind Ho!##562 |goto Hillsbrad Foothills 51.46,58.38
step
kill 10 Daggerspine Shorehunter##2369 |q 562/1 |goto Hillsbrad Foothills/0 57.75,68.27
kill 10 Daggerspine Siren##2371 |q 562/2 |goto Hillsbrad Foothills/0 57.75,68.27
|tip More in the water.
step
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Stormwind Ho!##562 |goto Hillsbrad Foothills 51.46,58.38
step
talk Phin Odelic##2711
accept Hints of a New Plague?##659 |goto Hillsbrad Foothills 50.34,59.05
step
talk Magistrate Henry Maleb##2276
|tip Inside the building.
accept Syndicate Assassins##505 |goto Hillsbrad Foothills 48.14,59.11
stickystart "Collect_Yeti_Fur"
step
click Alterac Granite##2714+
|tip Upright grey stones near walls.
|tip Inside the cave.
collect 5 Alterac Granite##4521 |q 689/1 |goto Hillsbrad Foothills/0 45.92,31.63
step
label "Collect_Yeti_Fur"
kill Cave Yeti##2248, Ferocious Yeti##2249
|tip Inside and outside the cave. |notinsticky
collect 10 Yeti Fur##3720 |q 565/4 |goto Hillsbrad Foothills/0 45.92,31.63
|only if haveq(565) or completedq(565)
step
Kill enemies
|tip Inside and outside the cave.
ding 33 |goto Hillsbrad Foothills/0 45.92,31.63
stickystart "Kill_Syndicate_Thieves_And_Footpads"
stickystart "Kill_Mountain_Lion_Enemies"
step
Leave the cave |goto Hillsbrad Foothills 46.18,31.83 < 20 |walk |only if subzone("Darrow Hill") and indoors()
click Syndicate Documents
|tip Multiple locations.
accept Foreboding Plans##510 |goto Alterac Mountains/0 47.91,82.13
accept Encrypted Letter##511 |goto Alterac Mountains/0 47.91,82.13
|mapmarker Alterac Mountains/0 58.32,67.92
step
label "Kill_Syndicate_Thieves_And_Footpads"
kill 8 Syndicate Thief##2241 |q 505/2 |goto Alterac Mountains/0 57.98,67.66
kill 12 Syndicate Footpad##2240 |q 505/1 |goto Alterac Mountains/0 57.98,67.66
|mapmarker Alterac Mountains/0 47.93,80.98
step
label "Kill_Mountain_Lion_Enemies"
kill 8 Mountain Lion##2406 |q 564/1 |goto Alterac Mountains/0 38.38,88.19
kill 10 Hulking Mountain Lion##2407 |q 564/2 |goto Alterac Mountains/0 38.38,88.19
|mapmarker Alterac Mountains/0 45.23,77.09
|mapmarker Alterac Mountains/0 31.40,85.02
step
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
accept Reassignment##563 |goto Hillsbrad Foothills 51.46,58.38
step
talk Barkeep Kelly##2366
|tip Inside the building.
accept Talk of the Town##98463 |goto Hillsbrad Foothills/0 51.56,58.60
step
talk Magistrate Henry Maleb##2276
|tip Inside the building.
turnin Foreboding Plans##510 |goto Hillsbrad Foothills 48.14,59.11
turnin Syndicate Assassins##505 |goto Hillsbrad Foothills 48.14,59.11
step
talk Loremaster Dibbs##2277
turnin Encrypted Letter##511 |goto Hillsbrad Foothills 50.57,57.09
accept Letter to Stormpike##514 |goto Hillsbrad Foothills 50.57,57.09
step
talk Darren Malvew##2382
turnin Costly Menace##564 |goto Hillsbrad Foothills 52.42,55.96
step
talk Micha Yance##2381
|tip Inside the building.
buy Fine Thread##2321 |q 565/2 |goto Hillsbrad Foothills/0 48.94,55.03
|only if haveq(565) or completedq(565)
step
talk Bartolo Ginsetti##2438
turnin Bartolo's Yeti Fur Cloak##565 |goto Hillsbrad Foothills/0 49.43,55.53
|only if haveq(565) or completedq(565)
step
talk Captain Nials##2700
|tip Walks around.
accept Northfold Manor##681 |goto Arathi Highlands 45.83,47.55
step
talk Skuerto##2789
turnin Malin's Request##690 |goto Arathi Highlands/0 46.65,47.01
step
talk Quae##2712
turnin Hints of a New Plague?##659 |goto Arathi Highlands 60.19,53.85
accept Hints of a New Plague?##658 |goto Arathi Highlands 60.19,53.85
step
kill 6 Syndicate Mercenary##2589 |q 681/2 |goto Arathi Highlands/0 32.09,28.54
kill 10 Syndicate Highwayman##2586 |q 681/1 |goto Arathi Highlands/0 32.09,28.54
|tip Careful, stealthed enemies.
|tip More stealthed {o}along the ridges{}.
|tip Also inside buildings.
step
Run through the break in the wall |goto Arathi Highlands/0 24.93,20.84 < 20 |only if walking |notravel
|only if zone ("Arathi Highlands")
step
talk Guthrum Thunderfist##8018
|tip Top of the path.
fpath Aerie Peak |goto The Hinterlands 11.07,46.15
|tip Saves time later.
step
talk Captain Nials##2700
|tip Walks around.
turnin Northfold Manor##681 |goto Arathi Highlands 45.83,47.55
step
talk Roetten Stonehammer##5637
|tip Walks around.
|tip Inside the building.
accept Reclaimers' Business in Desolace##1453 |goto Ironforge 67.91,17.49
|mapmarker Ironforge/0 69.96,21.25
step
talk Prospector Stormpike##1356
|tip Inside the building.
turnin Letter to Stormpike##514 |goto Ironforge 74.64,11.73
step
talk Grand Mason Marblesten##2790
|tip Walks around.
|tip Inside the building.
turnin A King's Tribute##689 |goto Ironforge 39.04,88.05
step
Watch the dialogue
|tip Inside the building.
talk Grand Mason Marblesten##2790
|tip Walks around.
accept A King's Tribute##700 |goto Ironforge 39.04,88.05
step
talk Bailey Stonemantle##2461
|tip Deposit into the bank.
|tip Inside the building.
bank Farren's Report##3721 |goto Ironforge/0 35.93,60.13 |q 563 |only if haveq(563) or completedq(563)
step
Follow the path |goto Ironforge 44.56,49.58 < 15 |walk |only if not subzone("The High Seat")
talk King Magni Bronzebeard##2784
turnin A King's Tribute##700 |goto Ironforge 39.09,56.20
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Dustwallow Marsh & Thousand Needles (33-34)",{
image=ZGV.IMAGESDIR.."Thousand Needles",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale (34-35)",
},[[
step
talk Red Jack Flint##4455
|tip Inside the building.
accept Fiora Longears##1132 |goto Wetlands/0 9.96,57.96
step
talk Baldruc##4321
fpath Theramore |goto Dustwallow Marsh 67.48,51.30
step
talk Helenia Olden##4897
|tip Inside the building.
buy 3 Soothing Spices##3713 |goto Dustwallow Marsh 66.44,51.46 |q 1218 |future
|tip Don't vendor them.
step
talk Fiora Longears##4456
|tip Inside the building.
turnin Fiora Longears##1132 |goto Dustwallow Marsh/0 66.46,45.15
accept Highperch Venom##1135 |goto Dustwallow Marsh/0 66.46,45.15
step
talk Innkeeper Janene##6272
|tip Inside the building.
home Theramore Isle |goto Dustwallow Marsh/0 66.59,45.22 |q 1040 |future
step
talk Guard Byron##4921
accept They Call Him Smiling Jim##1282 |goto Dustwallow Marsh/0 66.16,46.07
step
talk Clerk Lendry##5083
|tip Upstairs inside the building.
turnin James Hyal##1302 |goto Dustwallow Marsh/0 67.88,48.24
step
talk Commander Samaul##4964
|tip Walks around.
|tip Upstairs inside the building.
turnin The Missing Diplomat##1264 |goto Dustwallow Marsh/0 68.02,48.71
accept The Missing Diplomat##1265 |goto Dustwallow Marsh/0 68.02,48.71
step
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin They Call Him Smiling Jim##1282 |goto Dustwallow Marsh/0 68.22,48.62
step
Explore Sentry Point |q 1265/1 |goto Dustwallow Marsh 59.66,41.25
|tip Inside the building.
step
talk Archmage Tervosh##4967
|tip Inside the building.
|tip Quest bugged, sometimes missing.
|tip Skip if missing.
turnin The Missing Diplomat##1265 |goto Dustwallow Marsh 59.66,41.25
accept The Missing Diplomat##1266 |goto Dustwallow Marsh 59.66,41.25
step
talk Archmage Tervosh##4967
|tip Top of the tower.
turnin The Missing Diplomat##1265 |goto Dustwallow Marsh/0 66.42,49.26
accept The Missing Diplomat##1266 |goto Dustwallow Marsh/0 66.42,49.26
step
talk "Swamp Eye" Jarl##4792
accept Soothing Spices##1218 |goto Dustwallow Marsh/0 55.44,26.27
step
talk "Swamp Eye" Jarl##4792
turnin Soothing Spices##1218 |goto Dustwallow Marsh/0 55.44,26.27
step
click Loose Dirt
accept The Orc Report##1219 |goto Dustwallow Marsh/0 55.44,25.93
step
talk Private Hendel##4966
|tip Walks around.
turnin The Missing Diplomat##1266 |goto Dustwallow Marsh 45.22,24.64
step
talk Private Hendel##4966
|tip Walks around.
accept The Missing Diplomat##1324 |goto Dustwallow Marsh 45.22,24.64 |noautoaccept inparty
|tip Multiple enemies attack.
|tip Focus on killing {o}Private Hendel{}.
|tip Helpers run away once he surrenders.
|only if not hardcore()
step
kill Private Hendel##4966
Watch the dialogue
Subdue Private Hendel |q 1324/1 |goto Dustwallow Marsh 45.22,24.64
|only if not hardcore()
step
talk Archmage Tervosh##4967
turnin The Missing Diplomat##1324 |goto Dustwallow Marsh 45.19,24.30
|only if not hardcore()
step
talk Lady Jaina Proudmoore##4968
accept The Missing Diplomat##1267 |goto Dustwallow Marsh/0 45.22,24.24 |instant
|only if not hardcore()
step
talk Mudcrush Durtfeet##4503
|tip Avoid Brackenwall Village.
|tip Careful, higher level enemies.
|tip Follow the road.
accept Hungry!##1177 |goto Dustwallow Marsh 35.15,38.25
step
click Suspicious Hoofprint
accept Suspicious Hoofprints##1284 |goto Dustwallow Marsh/0 29.70,47.63
step
click Theramore Guard Badge
accept Lieutenant Paval Reethe##1252 |goto Dustwallow Marsh/0 29.83,48.24
step
click Black Shield
accept The Black Shield##1253 |goto Dustwallow Marsh/0 29.63,48.59
step
Ride an elevator down |goto Thousand Needles/0 32.23,22.32 < 40 |only if walking
click Henrig Lonebrow's Journal
|tip Small brown book.
|tip In dead dwarf's hand.
collect Henrig Lonebrow's Journal##5791 |goto Thousand Needles 30.73,24.35 |q 1100 |future
step
use Henrig Lonebrow's Journal##5791
accept Lonebrow's Journal##1100
step
talk Thyssiana##4319
fpath Thalanaar |goto Feralas 89.50,45.85
step
talk Kristy Grant##11826
|tip Walks around.
accept Pristine Pesterhide Pelts##98155 |goto Feralas/0 89.40,46.15
step
talk Falfindel Waywarder##4048
turnin Lonebrow's Journal##1100 |goto Feralas/0 89.64,46.56
step
kill Pesterhide Snarler##4249+
|tip Purple hyenas.
|tip Kill other enemies to get them to spawn.
collect 5 Pristine Pesterhide Pelt##279472 |q 98155/1 |goto Thousand Needles/0 11.99,15.97
step
talk Kristy Grant##11826
|tip Walks around.
turnin Pristine Pesterhide Pelts##98155 |goto Feralas/0 89.40,46.15
accept Packaged Pristine Pelts##98156 |goto Feralas/0 89.40,46.15
step
Kill enemies
ding 34 |goto Thousand Needles/0 18.47,22.32
step
Follow the path up |goto Thousand Needles 14.75,32.83 < 20 |only if walking and not subzone("Highperch")
kill Highperch Consort##4109, Highperch Wyvern##4107, Highperch Patriarch##4110
|tip Wyverns.
collect 10 Highperch Venom Sac##5809 |q 1135/1 |goto Thousand Needles/0 11.33,34.84
step
talk Kravel Koalbeard##4452
|tip Avoid Freewind Post.
accept Rocket Car Parts##1110 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
accept Salt Flat Venom##1104 |goto Thousand Needles 78.06,77.13
step
talk Wizzle Brassbolts##4453
turnin The Brassbolts Brothers##1179 |goto Thousand Needles 78.14,77.12
accept Hardened Shells##1105 |goto Thousand Needles 78.14,77.12
step
talk Pozzik##4630
accept Load Lightening##1176 |goto Thousand Needles 80.18,75.89
step
talk Trackmaster Zherin##4629
accept A Bump in the Road##1175 |goto Thousand Needles 81.64,77.95
stickystart "Collect_Rocket_Car_Parts"
stickystart "Kill_Saltstone_Crystalhides"
step
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
stickystart "Collect_Hardened_Tortoise_Shells"
stickystart "Collect_Salty_Scorpid_Venom"
stickystart "Kill_Saltstone_Basilisks"
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
talk Kravel Koalbeard##4452
turnin Rocket Car Parts##1110 |goto Thousand Needles 77.79,77.27
accept Wharfmaster Dizzywig##1111 |goto Thousand Needles 77.79,77.27
accept Hemet Nesingwary Jr.##5762 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin Salt Flat Venom##1104 |goto Thousand Needles 78.06,77.13
step
talk Wizzle Brassbolts##4453
turnin Hardened Shells##1105 |goto Thousand Needles 78.14,77.12
step
talk Pozzik##4630
turnin Load Lightening##1176 |goto Thousand Needles 80.18,75.88
accept Goblin Sponsorship##1178 |goto Thousand Needles 80.18,75.88
step
talk Trackmaster Zherin##4629
turnin A Bump in the Road##1175 |goto Thousand Needles 81.63,77.95
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Package of Pristine Pelts##279481 |goto Tanaris/0 52.30,28.92 |q 98156
step
talk Bera Stonehammer##7823
fpath Gadgetzan |goto Tanaris 51.01,29.34
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1135
|only if Druid
step
talk Fiora Longears##4456
|tip Inside the building.
turnin Highperch Venom##1135 |goto Dustwallow Marsh/0 66.46,45.15
step
talk Theramore Lieutenant##4947
turnin The Orc Report##1219 |goto Dustwallow Marsh 65.07,47.13
accept Captain Vimes##1220 |goto Dustwallow Marsh 65.07,47.13
step
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin Captain Vimes##1220 |goto Dustwallow Marsh 68.21,48.62
turnin Lieutenant Paval Reethe##1252 |goto Dustwallow Marsh 68.21,48.62
accept Lieutenant Paval Reethe##1259 |goto Dustwallow Marsh 68.21,48.62
turnin The Black Shield##1253 |goto Dustwallow Marsh 68.21,48.62
accept The Black Shield##1319 |goto Dustwallow Marsh 68.21,48.62
turnin Suspicious Hoofprints##1284 |goto Dustwallow Marsh 68.21,48.62
step
talk Adjutant Tesoran##4948
|tip Upstairs inside the building.
turnin Lieutenant Paval Reethe##1259 |goto Dustwallow Marsh 68.05,48.11
accept Daelin's Men##1285 |goto Dustwallow Marsh 68.05,48.11
step
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin Daelin's Men##1285 |goto Dustwallow Marsh 68.21,48.62
step
talk Caz Twosprocket##4941
|tip Inside the building.
turnin The Black Shield##1319 |goto Dustwallow Marsh 64.75,50.43
accept The Black Shield##1320 |goto Dustwallow Marsh 64.75,50.43
step
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin The Black Shield##1320 |goto Dustwallow Marsh 68.21,48.62
step
talk Bragok##16227
|tip {o}Follow the coast north{} to The Barrens.		|only if zone("Dustwallow Marsh")
fpath Ratchet |goto The Barrens 63.09,37.16			|only if not zone("Dustwallow Marsh")
fpath Ratchet |goto The Barrens 63.09,37.16	|notravel	|only if zone("Dustwallow Marsh")
step
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Goblin Sponsorship##1178 |goto The Barrens 62.68,36.23
accept Goblin Sponsorship##1180 |goto The Barrens 62.68,36.23
step
talk Strahad Farsan##6251
turnin Seeking Strahad##1798 |goto The Barrens/0 62.63,35.50
accept Tome of the Cabal##1758 |goto The Barrens/0 62.63,35.50
|only if Warlock
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
talk Wharfmaster Dizzywig##3453
turnin Wharfmaster Dizzywig##1111 |goto The Barrens/0 63.35,38.45
accept Parts for Kravel##1112 |goto The Barrens/0 63.35,38.45
turnin The Barrens Port##1039 |goto The Barrens/0 63.35,38.45
accept Passage to Booty Bay##1040 |goto The Barrens/0 63.35,38.45
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale (34-35)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Desolace (35-37)",
},[[
step
talk Wharfmaster Lozgil##4631
turnin Goblin Sponsorship##1180 |goto Stranglethorn Vale 26.35,73.56
accept Goblin Sponsorship##1181 |goto Stranglethorn Vale 26.35,73.56
step
talk Caravaneer Ruzzgot##3945
turnin Passage to Booty Bay##1040 |goto Stranglethorn Vale/0 27.37,74.08
accept The Caravan Road##1041 |goto Stranglethorn Vale/0 27.37,74.08
step
talk Innkeeper Skindle##6807
|tip {o}Ground floor{} inside the building.
home Booty Bay |goto Stranglethorn Vale 27.04,77.31 |q 563 |future
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
accept Singing Blue Shards##605 |goto Stranglethorn Vale 27.12,77.21
step
talk Nixxrax Fillamug##2832
|tip {o}Ground floor{} inside the building.
turnin Talk of the Town##98463 |goto Stranglethorn Vale/0 27.04,77.17
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
accept Investigate the Camp##201 |goto Stranglethorn Vale 26.94,77.21
accept Supplies to Private Thorsen##198 |goto Stranglethorn Vale 26.94,77.21
accept The Haunted Isle##616 |goto Stranglethorn Vale 26.94,77.21
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
accept Hostile Takeover##213 |goto Stranglethorn Vale 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
turnin Goblin Sponsorship##1181 |goto Stranglethorn Vale 27.23,76.87
accept Goblin Sponsorship##1182 |goto Stranglethorn Vale 27.23,76.87
turnin The Haunted Isle##616 |goto Stranglethorn Vale 27.23,76.87
accept The Stone of the Tides##578 |goto Stranglethorn Vale 27.23,76.87
step
talk Viznik Goldgrubber##2625
|tip Deposit into the bank.
bank Kravel's Parts##5800 |goto Stranglethorn Vale 26.54,76.57 |q 1112
step
_Destroy This Item:_
|tip Not needed.
trash Library Scrip##3898
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
accept Supply and Demand##575 |goto Stranglethorn Vale 28.29,77.59
step
talk Gyll##2859
|tip Upper level of the docks.
|tip Up on the balcony of the building.
fpath Booty Bay |goto Stranglethorn Vale 27.53,77.79
step
talk Elsharin##5498
|tip Top of the tower.
Train Abilities |trainer Elsharin##5498 |goto Stormwind City/0 48.20,87.21 |q 5762
|only if Mage
step
talk Clerk Daltry##267
|tip Walks around.
|tip Inside the building.
turnin The Caravan Road##1041 |goto Duskwood/0 72.53,46.86
accept The Carevin Family##1042 |goto Duskwood/0 72.53,46.86
step
talk Jonathan Carevin##661
|tip Inside the building.
turnin The Carevin Family##1042 |goto Duskwood/0 75.32,49.02
accept The Scythe of Elune##1043 |goto Duskwood/0 75.32,49.02
step
Enter the mine |goto Duskwood/0 73.05,75.14 < 15 |walk |only if not (subzone("Roland's Doom") and indoors())
click Mound of Dirt
|tip Inside the mine.
Find Evidence of the Scythe of Elune |q 1043/1 |goto Duskwood/0 73.54,79.13
step
Leave the mine |goto Duskwood/0 73.05,75.14 < 15 |walk |only if subzone("Roland's Doom") and indoors()
talk Private Thorsen##738
|tip Skip if he's not here.
|tip Can try again later.
turnin Supplies to Private Thorsen##198 |goto Stranglethorn Vale 37.98,3.42
step
talk Sergeant Yohwa##733
accept The Second Rebellion##203 |goto Stranglethorn Vale 38.02,3.33
accept Bad Medicine##204 |goto Stranglethorn Vale 38.02,3.33
step
talk Lieutenant Doren##469
accept Bookie Herod##200 |goto Stranglethorn Vale 38.04,3.01
step
_NOTE:_
Save Silk Cloth
|tip Start saving any you find.
|tip Need {o}15 Silk Cloth{} for future quest in Searing Gorge.
|tip Save them now to prevent grinding later.
Click Here to Continue |confirm |q 4449 |future
stickystart "Collect_Large_River_Crocolisk_Skins"
step
Locate the Hunters' Camp |q 201/1 |goto Stranglethorn Vale 35.55,10.55
step
talk Hemet Nesingwary##715
turnin Hemet Nesingwary##5762 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
accept Tiger Mastery##186 |goto Stranglethorn Vale 35.61,10.62
step
talk Sir S. J. Erlgadin##718
accept Panther Mastery##191 |goto Stranglethorn Vale 35.55,10.55
stickystop "Collect_Large_River_Crocolisk_Skins"
stickystart "Collect_Jungle_Remedies"
stickystart "Kill_Kurzen_Jungle_Fighters"
step
click Kurzen Supplies
collect Venom Fern Extract##2634 |q 204/2 |goto Stranglethorn Vale 44.10,9.56
step
click Bookie Herod's Records
|tip Upstairs inside the building.
turnin Bookie Herod##200 |goto Stranglethorn Vale 43.67,9.37
accept The Hidden Key##328 |goto Stranglethorn Vale 43.67,9.37
step
label "Collect_Jungle_Remedies"
kill Kurzen Medicine Man##940, Kurzen Jungle Fighter##937
|tip Medicine Men heal themselves and others.
collect 7 Jungle Remedy##2633 |q 204/1 |goto Stranglethorn Vale/0 46.42,9.48
|tip Don't vendor them.
step
label "Kill_Kurzen_Jungle_Fighters"
kill 15 Kurzen Jungle Fighter##937 |q 203/1 |goto Stranglethorn Vale/0 46.42,9.48
step
kill Crystal Spine Basilisk##689+
|tip Skip once no more to kill.
|tip Can finish later.
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto Stranglethorn Vale/0 48.07,8.31
step
kill 10 Stranglethorn Tiger##682 |q 186/1 |goto Stranglethorn Vale/0 46.06,14.51
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
collect 8 Tumbled Crystal##4106 |q 213/1 |goto Stranglethorn Vale/0 45.17,20.15
step
talk Sergeant Yohwa##733
turnin The Second Rebellion##203 |goto Stranglethorn Vale 38.02,3.33
turnin Bad Medicine##204 |goto Stranglethorn Vale 38.02,3.33
step
talk Corporal Kaleb##770
accept Krazek's Cookery##210 |goto Stranglethorn Vale 37.74,3.30
step
talk Private Thorsen##738
|tip Skip if he's not here.
|tip Can try again later.
turnin Supplies to Private Thorsen##198 |goto Stranglethorn Vale 37.98,3.42
step
label "Collect_Large_River_Crocolisk_Skins"
kill River Crocolisk##1150+
|tip Along the river.
collect 2 Large River Crocolisk Skin##4053 |q 575/1 |goto Stranglethorn Vale/0 37.18,11.19
step
talk Ajeck Rouack##717
turnin Tiger Mastery##186 |goto Stranglethorn Vale 35.61,10.62
accept Tiger Mastery##187 |goto Stranglethorn Vale 35.61,10.62
step
talk Hemet Nesingwary##715
accept Raptor Mastery##194 |goto Stranglethorn Vale 35.66,10.81
step
kill 10 Elder Stranglethorn Tiger##1085 |q 187/1 |goto Stranglethorn Vale/0 33.03,17.92
stickystart "Kill_Stranglethorn_Raptors"
step
kill 10 Panther##736 |q 191/1 |goto Stranglethorn Vale/0 28.70,13.71
step
label "Kill_Stranglethorn_Raptors"
kill 10 Stranglethorn Raptor##685 |q 194/1 |goto Stranglethorn Vale/0 26.83,16.12
step
kill Crystal Spine Basilisk##689+
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto Stranglethorn Vale/0 25.11,17.67
step
Locate the Haunted Island |q 578/1 |goto Stranglethorn Vale 21.33,21.93
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Stranglethorn Vale 21.33,21.93 |q 578
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Stranglethorn Vale/0 38.38,8.96 |q 578 |zombiewalk
|only if not hardcore()
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##194 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
turnin Tiger Mastery##187 |goto Stranglethorn Vale 35.62,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##191 |goto Stranglethorn Vale 35.55,10.55
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
turnin Singing Blue Shards##605 |goto Stranglethorn Vale 27.12,77.21
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
turnin Investigate the Camp##201 |goto Stranglethorn Vale 26.94,77.21
turnin Krazek's Cookery##210 |goto Stranglethorn Vale 26.94,77.21
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
turnin Hostile Takeover##213 |goto Stranglethorn Vale 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
turnin The Stone of the Tides##578 |goto Stranglethorn Vale 27.23,76.87
turnin Goblin Sponsorship##1182 |goto Stranglethorn Vale 27.23,76.87
accept Goblin Sponsorship##1183 |goto Stranglethorn Vale 27.23,76.87
step
talk Viznik Goldgrubber##2625
|tip Deposit into the bank.
bank Fuel Regulator Blueprints##5852 |goto Stranglethorn Vale 26.54,76.57 |q 1183
bank Small Brass Key##2719 |goto Stranglethorn Vale 26.54,76.57 |q 328
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
turnin Supply and Demand##575 |goto Stranglethorn Vale 28.29,77.59
step
talk Jonathan Carevin##661
|tip Inside the building.
turnin The Scythe of Elune##1043 |goto Duskwood/0 75.32,49.02
step
talk Auctioneer Jaxon##15659
|tip Buy from the Auction House, if possible.
|tip Inside the building.
collect 2 Draught of Water Breathing##5996 |goto Stormwind City 61.14,70.67 |q 6161 |future
|only if not (Druid or Warlock)
step
talk Olivia Burnside##2455
|tip Collect from the bank.
|tip Inside the building.
collect Farren's Report##3721			|goto Stormwind City 64.26,80.75 |q 563
collect Package of Pristine Pelts##279481	|goto Stormwind City 64.26,80.75 |q 98156
step
Enter the building |goto Stormwind City 42.27,81.78 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Demisette Cloyce##461
|tip Downstairs inside the building.
Train Abilities |trainer Demisette Cloyce##461 |goto Stormwind City/0 39.25,84.96 |q 563
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.52 |q 563
|only if Warlock
step
talk Kimberly Grant##11827
|tip Walks around.
turnin Packaged Pristine Pelts##98156 |goto Stormwind City/0 37.72,65.11
|mapmarker Stormwind City/0 34.79,62.79
|mapmarker Stormwind City/0 33.19,67.09
|mapmarker Stormwind City/0 36.17,69.39
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.06 |q 563
|only if Paladin
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.64,46.42 |q 563
|only if Priest
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 563
|only if Warrior
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 563
|only if Rogue
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 563
|only if Hunter
step
Enter Stormwind Keep |goto Stormwind City 73.09,46.62 < 15 |walk |only if not subzone("Stormwind Keep")
talk Major Samuelson##2439
|tip Inside the building.
turnin Reassignment##563 |goto Stormwind City 75.80,36.69
step
talk Krom Stoutarm##6294
|tip Inside the building.
turnin Tome of the Cabal##1758 |goto Ironforge/0 74.21,9.42
|only if Warlock
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 1453
|only if Shaman
step
talk Bath'rah the Windwatcher##6176
|tip Inside the building.
turnin The Windwatcher##1791 |goto Alterac Mountains 80.50,66.92
accept Cyclonian##1712 |goto Alterac Mountains 80.50,66.92
|only if Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Desolace (35-37)",{
image=ZGV.IMAGESDIR.."Desolace",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale (37-38)",
},[[
step
Follow the road and run up the path to enter Nijel's Point |goto Desolace 67.49,15.76 < 30 |only if walking and not subzone("Nijel's Point")
talk Baritanas Skyriver##6706
fpath Nijel's Point |goto Desolace 64.66,10.54
step
talk Shelgrayn##11104
Stable Your Pet |stablemaster Shelgrayn##11104 |goto Desolace/0 65.62,7.84 |q 1458 |future
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 5){}.
|only if Hunter
step
Learn the {y}Claw (Rank 5){} Pet Ability |learnspell Claw##2975 |goto Desolace/0 61.80,44.40 |q 1458 |future
|tip Cast {o}Tame Beast{} on an {o}Scorpashi Lasher{}.
|tip Scorpions.
|tip Kill enemies nearby.
|mapmarker Desolace/0 39.00,40.60
|mapmarker Desolace/0 39.20,48.20
|mapmarker Desolace/0 39.40,61.00
|mapmarker Desolace/0 40.00,64.20
|mapmarker Desolace/0 40.20,55.40
|mapmarker Desolace/0 40.40,44.20
|mapmarker Desolace/0 40.80,51.40
|mapmarker Desolace/0 42.00,38.60
|mapmarker Desolace/0 42.40,59.20
|mapmarker Desolace/0 42.60,47.00
|mapmarker Desolace/0 43.00,42.20
|mapmarker Desolace/0 43.00,53.80
|mapmarker Desolace/0 43.00,64.60
|mapmarker Desolace/0 43.60,50.00
|mapmarker Desolace/0 45.00,57.00
|mapmarker Desolace/0 45.20,62.00
|mapmarker Desolace/0 45.60,46.80
|mapmarker Desolace/0 46.00,53.40
|mapmarker Desolace/0 46.80,50.40
|mapmarker Desolace/0 49.00,54.00
|mapmarker Desolace/0 49.40,46.20
|mapmarker Desolace/0 50.80,50.40
|mapmarker Desolace/0 52.60,47.80
|mapmarker Desolace/0 53.80,50.60
|mapmarker Desolace/0 55.00,44.40
|mapmarker Desolace/0 55.60,55.20
|mapmarker Desolace/0 56.20,47.80
|mapmarker Desolace/0 56.80,50.80
|mapmarker Desolace/0 58.20,44.40
|mapmarker Desolace/0 58.20,57.00
|mapmarker Desolace/0 58.40,54.00
|mapmarker Desolace/0 59.20,47.60
|mapmarker Desolace/0 60.00,61.80
|mapmarker Desolace/0 60.20,50.60
|mapmarker Desolace/0 61.20,55.20
|mapmarker Desolace/0 61.20,58.40
|mapmarker Desolace/0 51.60,44.00
|mapmarker Desolace/0 62.60,47.80
|mapmarker Desolace/0 62.80,52.40
|mapmarker Desolace/0 64.20,57.40
|mapmarker Desolace/0 64.20,60.60
|mapmarker Desolace/0 65.60,50.40
|mapmarker Desolace/0 65.60,54.20
|mapmarker Desolace/0 67.20,60.40
|mapmarker Desolace/0 68.60,55.40
|mapmarker Desolace/0 69.40,62.60
|mapmarker Desolace/0 70.40,58.20
|mapmarker Desolace/0 71.80,54.40
|mapmarker Desolace/0 72.40,61.40
|mapmarker Desolace/0 73.40,58.40
|mapmarker Desolace/0 74.40,51.60
|only if Hunter
step
Run up the path to enter Nijel's Point |goto Desolace 67.49,15.76 < 30 |only if walking and not subzone("Nijel's Point")
talk Shelgrayn##11104
Retrieve Your Pet |stablemaster Shelgrayn##11104 |goto Desolace/0 65.62,7.84 |q 1458 |future
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 5){} to Your Pet |learnpetspell Claw##16831 |q 1458 |future
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
talk Innkeeper Lyshaerya##11103
|tip Inside the building.
home Nijel's Point |goto Desolace 66.27,6.56 |q 1186 |future
step
talk Kreldig Ungor##5638
turnin Reclaimers' Business in Desolace##1453 |goto Desolace 66.20,9.63
accept The Karnitol Shipwreck##1454 |goto Desolace 66.20,9.63
accept Reagents for Reclaimers Inc.##1458 |goto Desolace 66.20,9.63
step
talk Corporal Melkins##5752
accept Centaur Bounty##1387 |goto Desolace 66.74,10.87
step
talk Captain Pentigast##5396
accept Strange Alliance##1382 |goto Desolace 66.66,10.93
accept Carved Centaur Totems##93224 |goto Desolace 66.66,10.93
step
talk Vahlarriel Demonslayer##5642
accept Vahlarriel's Search##1437 |goto Desolace 66.44,11.82
step
kill Hatefury Trickster##4671, Hatefury Shadowstalker##4674, Hatefury Hellcaller##4675, Hatefury Betrayer##4673, Hatefury Felsworn##4672, Hatefury Rogue##4670
|tip Satyrs.
|tip Careful, stealthed enemies.
collect 10 Hatefury Claw##6246 |q 1458/1 |goto Desolace/0 74.46,19.79
collect 10 Hatefury Horn##6247 |q 1458/2 |goto Desolace/0 74.46,19.79
step
Kill enemies
ding 36 |goto Desolace/0 74.46,19.79
step
Run up the path to enter Nijel's Point |goto Desolace 67.49,15.76 < 30 |only if walking and not subzone("Nijel's Point")
talk Kreldig Ungor##5638
turnin Reagents for Reclaimers Inc.##1458 |goto Desolace 66.20,9.63
accept Reagents for Reclaimers Inc.##1459 |goto Desolace 66.20,9.63
stickystart "Collect_Aged_Kodo_Hides"
stickystart "Collect_Scorpashi_Venom"
step
click Malem Chest##50961
turnin Vahlarriel's Search##1437 |goto Desolace 56.54,17.83
accept Vahlarriel's Search##1465 |goto Desolace 56.54,17.83
step
talk Azore Aldamort##11863
|tip Up on the cliff.
accept Sceptre of Light##5741 |goto Desolace 38.88,27.17
stickystop "Collect_Scorpashi_Venom"
stickystop "Collect_Aged_Kodo_Hides"
step
click Karnitol's Chest##35251
turnin The Karnitol Shipwreck##1454 |goto Desolace 36.11,30.45
accept The Karnitol Shipwreck##1455 |goto Desolace 36.11,30.45
step
click Rackmore's Log##177787
|tip Small book.
accept Claim Rackmore's Treasure!##6161 |goto Desolace 36.07,30.41
step
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock)
kill Drysnap Pincer##11563, Drysnap Crawler##11562
|tip Lobsters.
|tip Underwater.
collect Rackmore's Silver Key##15878 |q 6161/1 |goto Desolace/0 32.35,32.48
step
talk Kreldig Ungor##5638
turnin The Karnitol Shipwreck##1455 |goto Desolace 66.20,9.63
accept The Karnitol Shipwreck##1456 |goto Desolace 66.20,9.63
step
talk Vahlarriel Demonslayer##5642
turnin Vahlarriel's Search##1465 |goto Desolace 66.44,11.82
accept Vahlarriel's Search##1438 |goto Desolace 66.44,11.82
accept Vahlarriel's Vengeance##97284 |goto Desolace 66.44,11.82
stickystart "Kill_Burning_Blade_Enemies"
stickystart "Collect_Aged_Kodo_Hides"
stickystart "Collect_Scorpashi_Venom"
step
kill Burning Blade Seer##13019
|tip Top of the tower.
collect Sceptre of Light##15750 |q 5741/1 |goto Desolace 55.17,30.15
stickystop "Collect_Aged_Kodo_Hides"
stickystop "Collect_Scorpashi_Venom"
step
talk Dalinda Malem##5644
|tip Escort quest.
|tip Wait until she respawns, if missing.
|tip Inside the building.
turnin Vahlarriel's Search##1438 |goto Desolace 54.86,26.13
accept Search for Tyranis##1439 |goto Desolace 54.86,26.13
step
kill Tyranis Malem##5643
|tip Pull him to building entrance to avoid enemies.
|tip Inside the building.
collect Tyranis' Pendant##6767 |q 1439/1 |goto Desolace 53.01,29.08
step
talk Dalinda Malem##5644
|tip Escort quest.
|tip Wait until she respawns, if missing.
|tip Inside the building.
turnin Search for Tyranis##1439 |goto Desolace 54.86,26.13
accept Return to Vahlarriel##1440 |goto Desolace 54.86,26.13 |noautoaccept inparty
|tip Kill nearby enemies first.
step
Watch the dialogue
|tip Follow and protect Dalinda Malem.
Rescue Dalinda Malem |q 1440/1 |goto Desolace 58.26,30.95
step
label "Kill_Burning_Blade_Enemies"
kill 4 Burning Blade Augur##4663 |q 97284/1 |goto Desolace/0 55.81,28.86
kill 4 Burning Blade Reaver##4664 |q 97284/2 |goto Desolace/0 55.81,28.86
kill 4 Burning Blade Adept##4665 |q 97284/3 |goto Desolace/0 55.81,28.86
kill 4 Burning Blade Felsworn##4666 |q 97284/4 |goto Desolace/0 55.81,28.86
stickystart "Collect_Aged_Kodo_Hides"
stickystart "Collect_Scorpashi_Venom"
step
talk Bibbly F'utzbuckle##11438
|tip Walks around.
accept Bone Collector##5501 |goto Desolace 62.33,38.98
step
kill Magram Outrunner##4639, Magram Scout##4638, Magram Wrangler##4640
|tip Centaurs.
|tip Avoid Magram Pack Runners walking with {o}2 hyena guards{}.
collect 5 Carved Centaur Totem##254432 |q 93224/1 |goto Desolace/0 69.00,69.20
collect 15 Centaur Ear##6067 |q 1387/1 |goto Desolace/0 69.00,69.20
Reach {y}Friendly Reputation{} with Gelkis Clan Centaur |q 1382/1 |goto Desolace/0 69.00,69.20
step
talk Smeed Scrabblescrew##11596
|tip Avoid Ghost Walker Post.
accept Kodo Roundup##5561 |goto Desolace 60.86,61.86
stickystart "Collect_Kodo_Bones"
step
use Kodo Kombobulator##13892
|tip On Kodo enemies.
|tip They will follow you.
|tip {o}Talk to them{} near Smeed Scrabblescrew.
Tame #5# Kodos |q 5561/1 |goto Desolace/0 50.85,58.96
Bring Kodos to [Desolace/0 60.73,61.96]
step
talk Smeed Scrabblescrew##11596
turnin Kodo Roundup##5561 |goto Desolace 60.86,61.86
step
click Extinguished Campfire
|tip Up on the hill.
accept Highway Robbery##79229 |goto Desolace/0 47.54,54.60
step
label "Collect_Aged_Kodo_Hides"
kill Aged Kodo##4700+
collect 3 Aged Kodo Hide##6249 |q 1459/2 |goto Desolace/0 50.85,58.96
step
label "Collect_Kodo_Bones"
click Kodo Bones##176751+
|tip White horned animal skulls.
|tip May be attacked.
collect 10 Kodo Bone##13703 |q 5501/1 |goto Desolace/0 50.85,58.96
step
talk Uthek the Wise##5397
|tip Follow the road.
turnin Strange Alliance##1382 |goto Desolace 36.23,79.25
accept Raid on the Kolkar##1384 |goto Desolace 36.23,79.25
stickystop "Collect_Scorpashi_Venom"
step
talk Corporal Melkins##5752
turnin Centaur Bounty##1387 |goto Desolace 66.74,10.87
step
talk Captain Pentigast##5396
turnin Carved Centaur Totems##93224 |goto Desolace/0 66.66,10.94
step
talk Vahlarriel Demonslayer##5642
turnin Return to Vahlarriel##1440 |goto Desolace 66.44,11.82
turnin Vahlarriel's Vengeance##97284 |goto Desolace 66.44,11.82
step
label "Collect_Scorpashi_Venom"
kill Scorpashi Snapper##4696, Scorpashi Lasher##4697
|tip Scorpions.
|tip Shared spawns with basilisks. |notinsticky
collect 10 Scorpashi Venom##6248 |q 1459/1 |goto Desolace/0 66.25,23.32
step
kill Kolkar Ambusher##12977, Kolkar Waylayer##12976, Kolkar Destroyer##4637, Kolkar Battle Lord##4636, Kolkar Windchaser##4635, Kolkar Mauler##4634, Kolkar Centaur##4632, Kolkar Scout##4633
|tip Centaurs.
collect 10 Crude Charm##6079 |q 1384/1 |goto Desolace/0 71.05,45.77
step
talk Bibbly F'utzbuckle##11438
|tip Walks around.
turnin Bone Collector##5501 |goto Desolace 62.33,38.98
turnin Highway Robbery##79229 |goto Desolace 62.33,38.98
accept On the Lam##79235 |goto Desolace 62.33,38.98
step
talk Azore Aldamort##11863
|tip Up on the cliff.
turnin Sceptre of Light##5741 |goto Desolace 38.89,27.17
accept Book of the Ancients##6027 |goto Desolace 38.89,27.17
stickystart "Collect_Karnitols_Satchel"
stickystart "Collect_Rackmores_Golden_Key"
step
click Serpent Statue
kill Lord Kragaru##12369
collect Book of the Ancients##15803 |q 6027/1 |goto Desolace 28.19,6.62
step
label "Collect_Karnitols_Satchel"
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock) |notinsticky
kill Slitherblade Tidehunter##4716, Slitherblade Sea Witch##4719
|tip Tidehunters and Sea Witches.
|tip Nagas.
|tip Shared spawns with other nagas. |notinsticky
|tip On the island and underwater. |notinsticky
collect Karnitol's Satchel##6245 |q 1456/1 |goto Desolace/0 30.44,8.50
|tip Low drop rate. |notinsticky
|tip Take the time to grind for it. |notinsticky
|tip Skip if not found by {o}10% into level 37{}. |notinsticky
step
label "Collect_Rackmores_Golden_Key"
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock)
kill Slitherblade Naga##4711, Slitherblade Sorceress##4712, Slitherblade Warrior##4713, Slitherblade Tide Priestess##218249, Slitherblade Myrmidon##4714, Slitherblade Oracle##4718, Slitherblade Razortail##4715, Slitherblade Sea Witch##4719, Slitherblade Tidehunter##4716
|tip Nagas. |notinsticky
|tip On islands and underwater. |notinsticky
collect Rackmore's Golden Key##15881 |q 6161/2 |goto Desolace/0 30.44,8.50
step
click Rackmore's Chest##177786
turnin Claim Rackmore's Treasure!##6161 |goto Desolace 30.00,8.70
step
Kill enemies
ding 37 |goto Desolace/0 30.44,8.50
step
Follow the path up |goto Desolace/0 40.74,28.95 < 30 |only if walking
talk Azore Aldamort##11863
|tip Up on the cliff.
turnin Book of the Ancients##6027 |goto Desolace 38.89,27.17
step
talk Uthek the Wise##5397
|tip Follow the path through the mountains.
|tip Avoid the Valley of Spears.
turnin Raid on the Kolkar##1384 |goto Desolace 36.22,79.25
|only if hardcore()
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 1456
|only if Druid
step
talk Kreldig Ungor##5638
turnin The Karnitol Shipwreck##1456 |goto Desolace 66.20,9.63
accept The Karnitol Shipwreck##1457 |goto Desolace 66.20,9.63
turnin Reagents for Reclaimers Inc.##1459 |goto Desolace 66.20,9.63
step
click Lost Shipping Crate
accept Lost Shipping Crate##94841 |goto Desolace/0 64.53,10.34
step
talk Uthek the Wise##5397
turnin Raid on the Kolkar##1384 |goto Desolace 36.22,79.25
|only if not hardcore()
step
Follow the road and run down the path |goto Feralas 47.56,37.72 < 30 |only if walking and not (subzone("The Forgotten Coast") or subzone("Sardor Isle") or subzone("Feathermoon Stronghold") or subzone("Ruins of Solarsal") or subzone("Isle of Dread"))
Ride the boat or swim across the water |goto Feralas 43.39,42.75 < 40 |only if walking and not (subzone("Sardor Isle") or subzone("Feathermoon Stronghold") or subzone("Ruins of Solarsal") or subzone("Isle of Dread"))
talk Fyldren Moonfeather##8019
|tip Careful, higher level enemies.
|tip Rexxar won't attack you on the road.
fpath Feathermoon |goto Feralas 30.24,43.25
|only if not hardcore()
step
talk Innkeeper Fizzgrimble##7733
|tip Inside the building.
accept Overseas Delivery##95144 |goto Tanaris/0 52.51,27.91
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Karnitol's Satchel##6245			|goto Tanaris 52.30,28.91 |q 1457
bank Lost Shipping Crate##276067		|goto Tanaris 52.30,28.91 |q 94841
bank Fizzgrimble's Mysterious Crate##276065	|goto Tanaris 52.30,28.91 |q 95144
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Kravel's Parts##5800 |goto Tanaris 52.30,28.91 |q 1112
collect Fuel Regulator Blueprints##5852 |goto Tanaris 52.30,28.91 |q 1183
step
talk Kravel Koalbeard##4452
turnin Parts for Kravel##1112 |goto Thousand Needles 77.79,77.26
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Delivery to the Gnomes##1114 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin Delivery to the Gnomes##1114 |goto Thousand Needles 78.06,77.12
step
talk Kravel Koalbeard##4452
accept The Rumormonger##1115 |goto Thousand Needles 77.79,77.27
step
talk Pozzik##4630
turnin Goblin Sponsorship##1183 |goto Thousand Needles 80.18,75.88
accept The Eighteenth Pilot##1186 |goto Thousand Needles 80.18,75.88
step
talk Razzeric##4706
turnin The Eighteenth Pilot##1186 |goto Thousand Needles 80.33,76.09
accept Razzeric's Tweaking##1187 |goto Thousand Needles 80.33,76.09
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale (37-38)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Swamp of Sorrows (38-39)",
},[[
step
talk Viznik Goldgrubber##2625
|tip Collect into the bank.
collect Small Brass Key##2719 |goto Stranglethorn Vale 26.54,76.57 |q 328		|only if haveq(1112) or completedq(1112)
step
talk Innkeeper Skindle##6807
|tip {o}Ground floor{} inside the building.
home Booty Bay |goto Stranglethorn Vale 27.04,77.31 |q 661 |future
step
talk Tokal##215643
|tip {o}Ground floor{} inside the building.
turnin On the Lam##79235 |goto Stranglethorn Vale/0 26.99,77.28
accept Cherry for Your Thoughts?##79236 |goto Stranglethorn Vale/0 26.99,77.28
step
talk Nixxrax Fillamug##2832
|tip {o}Ground floor{} inside the building.
buy Cherry Grog##4600 |q 79236/1 |goto Stranglethorn Vale/0 27.04,77.17
step
talk Tokal##215643
|tip {o}Ground floor{} inside the building.
turnin Cherry for Your Thoughts?##79236 |goto Stranglethorn Vale/0 26.99,77.28
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
turnin The Rumormonger##1115 |goto Stranglethorn Vale 26.94,77.21
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
accept Bloodscalp Ears##189 |goto Stranglethorn Vale 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
accept Water Elementals##601 |goto Stranglethorn Vale 27.23,76.87
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
accept Some Assembly Required##577 |goto Stranglethorn Vale 28.29,77.59
step
talk Elsharin##5498
|tip Top of the tower.
Train Abilities |trainer Elsharin##5498 |goto Stormwind City/0 48.20,87.21 |q 207 |future
|only if Mage
step
Enter the building |goto Stormwind City 42.27,81.78 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Demisette Cloyce##461
|tip Downstairs inside the building.
Train Abilities |trainer Demisette Cloyce##461 |goto Stormwind City/0 39.25,84.96 |q 207 |future
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.52 |q 207 |future
|only if Warlock
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.06 |q 207 |future
|only if Paladin
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.64,46.42 |q 207 |future
|only if Priest
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 207 |future
|only if Warrior
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 207 |future
|only if Rogue
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 207 |future
|only if Hunter
step
talk Karrina Mekenda##2879
|tip Inside the building.
Train Pet Abilities |trainer Karrina Mekenda##2879 |goto Stormwind City/0 67.29,36.79 |q 207 |future
|only if Hunter
step
talk Auctioneer Jaxon##15659
|tip Buy from the Auction House, if possible.
|tip Inside the building.
collect 4 Lesser Bloodstone Ore##4278 |goto Stormwind City/0 61.14,70.67 |q 627 |future
step
talk Eldrun Stormbreaker##258098
Train Abilities |trainer Eldrun Stormbreaker##258098 |goto Ironforge/0 47.15,13.87 |q 198
|only if Shaman
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
accept Favor for Krazek##627 |goto Stranglethorn Vale/0 26.94,77.21
|only if itemcount(4278) >= 4
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
turnin Favor for Krazek##627 |goto Stranglethorn Vale/0 26.94,77.21
accept Return to Corporal Kaleb##622 |goto Stranglethorn Vale/0 26.94,77.21
|only if haveq(627) or completedq(627)
step
talk Brother Nimetz##739
accept Kurzen's Mystery##207 |goto Stranglethorn Vale 37.83,3.56
step
talk Private Thorsen##738
|tip Skip if he's not here.
|tip Can try again later.
turnin Supplies to Private Thorsen##198 |goto Stranglethorn Vale 37.98,3.42
step
talk Sergeant Yohwa##733
accept Special Forces##574 |goto Stranglethorn Vale 38.02,3.33
step
talk Corporal Kaleb##770
turnin Return to Corporal Kaleb##622 |goto Stranglethorn Vale 37.74,3.30
step
talk Hemet Nesingwary##715
accept Raptor Mastery##195 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
accept Tiger Mastery##188 |goto Stranglethorn Vale 35.62,10.62
step
talk Sir S. J. Erlgadin##718
accept Panther Mastery##192 |goto Stranglethorn Vale 35.55,10.55
stickystart "Kill_Kurzen_Commandos"
step
talk Wendel Mathers##218230
|tip Inside the building.
accept The Cook in the Cage##97047 |goto Stranglethorn Vale/0 44.27,7.94
stickystop "Kill_Kurzen_Commandos"
stickystart "Collect_Compound_Cage_Key"
stickystart "Kill_Kurzen_Headshrinkers"
stickystart "Kill_Kurzen_Commandos"
stickystart "Collect_Silk_Cloth"
step
Enter the cave |goto Stranglethorn Vale 45.82,8.18 < 40 |walk |only if not (subzone("The Stockpile") and indoors())
click Kurzen Supply Crate
|tip {o}Bottom floor{} inside the cave.
collect Kurzen Fighter's Uniform |q 97047/2 |goto Stranglethorn Vale/0 49.62,7.74
step
click Bookie Herod's Strongbox
|tip {o}Bottom floor{} inside the cave.
turnin The Hidden Key##328 |goto Stranglethorn Vale 49.61,7.57
accept The Spy Revealed!##329 |goto Stranglethorn Vale 49.61,7.57
step
label "Collect_Compound_Cage_Key"
kill Kurzen Elite##939, Kurzen Subchief##978
|tip Elites and Subchiefs.
|tip {o}Bottom floor{} inside the cave.
collect Compound Cage Key##216616 |q 97047/1 |goto Stranglethorn Vale 45.82,8.18
step
label "Kill_Kurzen_Headshrinkers"
kill 6 Kurzen Headshrinker##941 |q 574/2 |goto Stranglethorn Vale 45.82,8.18
|tip {o}Ground level{} inside the cave. |notinsticky
step
label "Kill_Kurzen_Commandos"
kill 10 Kurzen Commando##938 |q 574/1 |goto Stranglethorn Vale 45.82,8.18
|tip Stealthed.
|tip {o}Ground level{} inside the cave. |notinsticky
step
label "Collect_Silk_Cloth"
kill Kurzen Commando##938, Kurzen Elite##939, Kurzen Shadow Hunter##979, Kurzen Subchief##978, Kurzen Headshrinker##941
|tip Throughout the cave. |notinsticky
collect 15 Silk Cloth##4306 |goto Stranglethorn Vale 45.82,8.18 |q 4449 |future |usebank
|tip Needed for future quest in Searing Gorge.
|tip Don't vendor them.
step
Leave the cave |goto Stranglethorn Vale 45.82,8.18 < 40 |walk |only if subzone("The Stockpile") and indoors()
talk Wendel Mathers##218230
|tip Inside the building.
turnin The Cook in the Cage##97047 |goto Stranglethorn Vale/0 44.27,7.94
accept Returning to Port##97048 |goto Stranglethorn Vale/0 44.27,7.94
step
kill Kurzen Medicine Man##940+
|tip Share spawns with other Kurzen enemies.
collect 8 Liferoot##3357 |q 1712/1 |goto Stranglethorn Vale/0 46.42,9.48
|tip Needed for important class quest soon.
|tip Don't vendor them.
|only if Warrior
step
kill 10 Shadowmaw Panther##684 |q 192/1 |goto Stranglethorn Vale/0 47.96,23.85
|tip Stealthed.
|tip Shared spawns with Stranglethorn Tigresses.
|tip Avoid Bhag'thera.
|tip {o}Level 40 elite{} non-stealthed black panther.
|mapmarker Stranglethorn Vale/0 38.65,36.94
stickystart "Kill_Lashtail_Raptors"
step
kill Snapjaw Crocolisk##1152+
|tip In and around the water.
collect 5 Snapjaw Crocolisk Skin##4104 |q 577/1 |goto Stranglethorn Vale/0 40.67,22.28
step
label "Kill_Lashtail_Raptors"
kill 10 Lashtail Raptor##686 |q 195/1 |goto Stranglethorn Vale/0 33.89,23.00
step
kill Sin'Dall##729
|tip Orange tiger.
|tip Usually on top of the hill.
|tip Walks around.
collect Paw of Sin'Dall##3879 |q 188/1 |goto Stranglethorn Vale/0 32.22,17.30
stickystart "Collect_Bloodscalp_Tusks_For_Warriors_And_Ears"
step
click Thoroughly Scavenged Supplies
|tip Up on the hill.
accept Anything of Value##97328 |goto Stranglethorn Vale/0 31.47,12.88
step
click Moon Over the Vale
collect The First Troll Legend##2005 |q 207/1 |goto Stranglethorn Vale 29.48,19.15
step
click Gri'lek the Wanderer
|tip Avoid the {o}elite murlocs{}.
|tip Underwater.
collect The Second Troll Legend##2006 |q 207/2 |goto Stranglethorn Vale 24.75,22.84
stickystop "Collect_Bloodscalp_Tusks_For_Warriors_And_Ears"
step
kill Lesser Water Elemental##691+
collect 6 Water Elemental Bracers##3923 |q 601/1 |goto Stranglethorn Vale/0 20.77,23.20
stickystart "Collect_Stolen_Shipments"
stickystart "Collect_Bloodscalp_Tusks_For_Warriors_And_Ears"
step
Follow the path up |goto Stranglethorn Vale/0 21.51,9.69 < 20 |only if walking
talk Zimmix Sputterspark##268992
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept Where's the Key?##97329 |goto Stranglethorn Vale/0 23.43,12.76
stickystop "Collect_Stolen_Shipments"
stickystop "Collect_Bloodscalp_Tusks_For_Warriors_And_Ears"
stickystart "Collect_Primitive_Key"
stickystart "Collect_Stolen_Shipments"
stickystart "Collect_Bloodscalp_Tusks_For_Warriors_And_Ears"
step
click Fall of Gurubashi
collect The Third Troll Legend##2007 |q 207/3 |goto Stranglethorn Vale 22.95,12.02
step
Follow the path up |goto Stranglethorn Vale 23.84,10.65 < 20 |only if walking
click The Emperor's Tomb
collect The Fourth Troll Legend##2008 |q 207/4 |goto Stranglethorn Vale 24.70,8.93
step
label "Collect_Primitive_Key"
kill Bloodscalp Beastmaster##699, Bloodscalp Berserker##597, Bloodscalp Headhunter##671, Bloodscalp Hunter##595, Bloodscalp Mystic##701, Bloodscalp Scout##588, Bloodscalp Witch Doctor##660
|tip Trolls.
collect Primitive Key##277957 |q 97329/1 |goto Stranglethorn Vale/0 25.07,11.29
step
talk Zimmix Sputterspark##268992
|tip Escort quest.
|tip Wait until he respawns, if missing.
turnin Where's the Key?##97329 |goto Stranglethorn Vale/0 23.43,12.76
step
label "Collect_Stolen_Shipments"
click Stolen Shipment+
|tip Wooden crates.
collect 8 Stolen Shipment##277953 |q 97328/1 |goto Stranglethorn Vale/0 24.69,10.17
step
label "Collect_Bloodscalp_Tusks_For_Warriors_And_Ears"
kill Bloodscalp Axe Thrower##694, Bloodscalp Beastmaster##699, Bloodscalp Berserker##597, Bloodscalp Headhunter##671, Bloodscalp Hunter##595, Bloodscalp Mystic##701, Bloodscalp Scavenger##702, Bloodscalp Scout##588, Bloodscalp Shaman##697, Bloodscalp Warrior##587, Bloodscalp Witch Doctor##660
|tip Trolls.
collect 15 Bloodscalp Ear##1519 |q 189/1 |goto Stranglethorn Vale/0 25.07,11.29
collect 30 Bloodscalp Tusk##3901 |q 1712/2 |goto Stranglethorn Vale/0 25.07,11.29 |only if Warrior
step
Kill enemies
|tip Helps reach level 38 after quest turnins.
ding 37,58760 |goto Stranglethorn Vale/0 25.07,11.29
|only if Druid
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##195 |goto Stranglethorn Vale 35.66,10.81
accept Raptor Mastery##196 |goto Stranglethorn Vale 35.66,10.81
step
talk Ajeck Rouack##717
turnin Tiger Mastery##188 |goto Stranglethorn Vale 35.62,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##192 |goto Stranglethorn Vale 35.55,10.55
accept Panther Mastery##193 |goto Stranglethorn Vale 35.55,10.55
step
talk Brother Nimetz##739
turnin Kurzen's Mystery##207 |goto Stranglethorn Vale 37.83,3.56
accept Troll Witchery##205 |goto Stranglethorn Vale 37.83,3.56
step
talk Private Thorsen##738
|tip Wait until he respawns, if missing.
turnin Supplies to Private Thorsen##198 |goto Stranglethorn Vale 37.98,3.42
step
talk Lieutenant Doren##469
turnin Special Forces##574 |goto Stranglethorn Vale 38.04,3.01
turnin The Spy Revealed!##329 |goto Stranglethorn Vale 38.04,3.01
accept Patrol Schedules##330 |goto Stranglethorn Vale 38.04,3.01
step
talk Corporal Sethman##1422
turnin Patrol Schedules##330 |goto Stranglethorn Vale 37.66,3.39
accept Report to Doren##331 |goto Stranglethorn Vale 37.66,3.39
step
talk Lieutenant Doren##469
turnin Report to Doren##331 |goto Stranglethorn Vale 38.04,3.01
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 189
|only if Druid
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
accept Dream Dust in the Swamp##1116 |goto Stranglethorn Vale/0 26.94,77.21
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
turnin Bloodscalp Ears##189 |goto Stranglethorn Vale 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
turnin Water Elementals##601 |goto Stranglethorn Vale 27.23,76.87
accept Magical Analysis##602 |goto Stranglethorn Vale 27.23,76.87
step
talk Viznik Goldgrubber##2625
|tip Deposit into the bank.
bank Bag of Water Elemental Bracers##3960 |goto Stranglethorn Vale 26.54,76.57 |q 602
bank Silk Cloth##4306 |complete (C_Item.GetItemCount(4306,true) - C_Item.GetItemCount(4306))>=15 |goto Stranglethorn Vale 26.54,76.57 |q 4449 |future
step
talk Captain Aransas##218229
|tip Lower level of the docks.
turnin Returning to Port##97048 |goto Stranglethorn Vale/0 27.68,76.65
step
talk Wharfmaster Lozgil##4631
turnin Anything of Value##97328 |goto Stranglethorn Vale/0 26.35,73.56
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
turnin Some Assembly Required##577 |goto Stranglethorn Vale 28.29,77.59
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Swamp of Sorrows (38-39)",{
image=ZGV.IMAGESDIR.."Swamp of Sorrows",
hardcore = true,
next="Leveling Guides\\Arathi Highlands & Alterac Mountains (39-40)",
},[[
step
talk Elsharin##5498
|tip Top of the tower.
Train Abilities |trainer Elsharin##5498 |goto Stormwind City/0 48.20,87.21 |q 1363 |future
|only if Mage
step
Enter the building |goto Stormwind City 50.50,90.40 < 10 |walk
talk Angus Stern##1141
|tip Inside the building.
accept Morgan Stern##1260 |goto Stormwind City 51.78,93.61
|only if Mage
step
Enter the building |goto Stormwind City/0 51.52,73.69 < 10 |walk
talk Mazen Mac'Nadir##338
|tip Inside the building.
accept Mazen's Behest##1363 |goto Stormwind City 51.80,74.24
|only if Mage
step
talk Acolyte Dellis##5386
|tip Upstairs inside the building.
turnin Mazen's Behest##1363 |goto Stormwind City 51.37,73.82
accept Mazen's Behest##1364 |goto Stormwind City 51.37,73.82
|only if Mage
step
Enter the building |goto Stormwind City/0 51.52,73.69 < 10 |walk
talk Mazen Mac'Nadir##338
|tip Inside the building.
accept Mazen's Behest##1363 |goto Stormwind City 51.80,74.24
step
talk Acolyte Dellis##5386
|tip Upstairs inside the building.
turnin Mazen's Behest##1363 |goto Stormwind City 51.37,73.82
step
Enter the building |goto Stormwind City 50.50,90.40 < 10 |walk
talk Angus Stern##1141
|tip Inside the building.
accept Morgan Stern##1260 |goto Stormwind City 51.78,93.61
step
Enter the building |goto Stormwind City 42.27,81.78 < 10 |walk |only if not (subzone("The Slaughtered Lamb") and indoors())
talk Demisette Cloyce##461
|tip Downstairs inside the building.
Train Abilities |trainer Demisette Cloyce##461 |goto Stormwind City/0 39.25,84.96 |q 1116
|only if Warlock
step
talk Spackle Thornberry##5520
|tip Buy available Grimoires.
|tip Downstairs inside the building.
Train Demon Abilities |vendor Spackle Thornberry##5520 |goto Stormwind City/0 39.54,84.52 |q 1116
|only if Warlock
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.06 |q 1116
|only if Paladin
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Brother Benjamin##5484
|tip Walks around.
|tip Inside the building.
Train Abilities |trainer Brother Benjamin##5484 |goto Stormwind City/0 51.64,46.42 |q 1116
|only if Priest
step
talk Wu Shen##5479
|tip Upstairs inside the building.
Train Abilities |trainer Wu Shen##5479 |goto Stormwind City/0 80.50,59.86 |q 1116
|only if Warrior
step
talk Osborne the Night Man##918
Train Abilities |trainer Osborne the Night Man##918 |goto Stormwind City/0 77.38,65.30 |q 1116
|only if Rogue
step
talk Brohann Caskbelly##5384
|tip Inside the building.
accept In Search of The Temple##1448 |goto Stormwind City 69.42,40.40
step
talk Einris Brightspear##5515
|tip Inside the building.
Train Abilities |trainer Einris Brightspear##5515 |goto Stormwind City/0 67.32,36.23 |q 1116
|only if Hunter
step
_NOTE:_
While Questing in Swamp of Sorrows
|tip Avoid {o}Stonard Scouts{}.
|tip Horde NPCs in Horde camps and patrolling the roads.
|tip They will {o}PVP flag you{}.
Click Here to Continue |confirm |q 1116
|only if hardcore()
step
_NOTE:_
While Questing in Swamp of Sorrows
|tip Kill enemies as you walk.
|tip Reduces grinding all at once.
Click Here to Continue |confirm |q 1116
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
talk Watcher Biggs##5476
accept Encroaching Wildlife##1396 |goto Swamp of Sorrows 26.74,59.83
stickystart "Kill_Young_Sawtooth_Crocolisks"
stickystart "Kill_Sorrow_Spinners"
stickystart "Kill_Swamp_Jaguars"
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
step
talk Magtoor##1776
turnin Noboru the Cudgel##1392 |goto Swamp of Sorrows 25.99,31.40
accept Draenethyst Crystals##1389 |goto Swamp of Sorrows 25.99,31.40
step
kill Adolescent Whelp##740, Dreaming Whelp##741
|tip Tiny flying dragons.
|tip Skip once no more to kill.
|tip Can finish later.
collect 10 Speck of Dream Dust##5803 |q 1116/1 |goto Swamp of Sorrows/0 16.80,58.40
|mapmarker Swamp of Sorrows/0 11.40,62.00
|mapmarker Swamp of Sorrows/0 11.40,65.40
|mapmarker Swamp of Sorrows/0 15.00,61.60
|mapmarker Swamp of Sorrows/0 15.00,66.60
|mapmarker Swamp of Sorrows/0 12.40,57.40
step
label "Kill_Young_Sawtooth_Crocolisks"
kill 8 Young Sawtooth Crocolisk##1084 |q 1396/1 |goto Swamp of Sorrows 24.60,52.40
|mapmarker Swamp of Sorrows/0 21.00,45.60
|mapmarker Swamp of Sorrows/0 23.00,42.40
|mapmarker Swamp of Sorrows/0 23.00,49.40
|mapmarker Swamp of Sorrows/0 23.40,39.40
|mapmarker Swamp of Sorrows/0 25.00,36.00
|mapmarker Swamp of Sorrows/0 25.80,31.40
|mapmarker Swamp of Sorrows/0 26.00,55.20
|mapmarker Swamp of Sorrows/0 27.00,38.60
|mapmarker Swamp of Sorrows/0 27.20,48.80
|mapmarker Swamp of Sorrows/0 27.80,51.80
|mapmarker Swamp of Sorrows/0 29.00,34.40
|mapmarker Swamp of Sorrows/0 30.00,39.60
|mapmarker Swamp of Sorrows/0 30.00,56.60
|mapmarker Swamp of Sorrows/0 30.80,53.40
|mapmarker Swamp of Sorrows/0 31.40,47.80
|mapmarker Swamp of Sorrows/0 32.20,36.20
|mapmarker Swamp of Sorrows/0 33.00,39.60
|mapmarker Swamp of Sorrows/0 33.40,30.60
|mapmarker Swamp of Sorrows/0 34.20,51.40
|mapmarker Swamp of Sorrows/0 34.40,48.20
|mapmarker Swamp of Sorrows/0 34.60,33.60
|mapmarker Swamp of Sorrows/0 35.20,36.60
|mapmarker Swamp of Sorrows/0 37.20,50.40
|mapmarker Swamp of Sorrows/0 37.60,32.80
|mapmarker Swamp of Sorrows/0 39.00,36.00
|mapmarker Swamp of Sorrows/0 41.00,33.00
|mapmarker Swamp of Sorrows/0 44.00,32.80
step
label "Kill_Sorrow_Spinners"
kill 10 Sorrow Spinner##858 |q 1396/2 |goto Swamp of Sorrows 25.40,49.20
|tip Spiders.
|mapmarker Swamp of Sorrows/0 16.20,53.40
|mapmarker Swamp of Sorrows/0 16.60,56.80
|mapmarker Swamp of Sorrows/0 19.20,53.20
|mapmarker Swamp of Sorrows/0 21.40,43.00
|mapmarker Swamp of Sorrows/0 21.40,59.00
|mapmarker Swamp of Sorrows/0 22.00,63.60
|mapmarker Swamp of Sorrows/0 22.40,37.20
|mapmarker Swamp of Sorrows/0 24.40,58.20
|mapmarker Swamp of Sorrows/0 25.00,61.60
|mapmarker Swamp of Sorrows/0 25.40,45.20
|mapmarker Swamp of Sorrows/0 27.60,63.60
|mapmarker Swamp of Sorrows/0 27.80,43.40
|mapmarker Swamp of Sorrows/0 28.20,52.20
|mapmarker Swamp of Sorrows/0 28.60,48.00
|mapmarker Swamp of Sorrows/0 28.80,60.60
|mapmarker Swamp of Sorrows/0 30.20,54.60
|mapmarker Swamp of Sorrows/0 32.00,50.80
|mapmarker Swamp of Sorrows/0 32.80,28.80
|mapmarker Swamp of Sorrows/0 34.60,54.60
|mapmarker Swamp of Sorrows/0 35.40,30.60
|mapmarker Swamp of Sorrows/0 37.60,28.40
|mapmarker Swamp of Sorrows/0 38.00,32.80
|mapmarker Swamp of Sorrows/0 38.40,45.80
|mapmarker Swamp of Sorrows/0 38.80,37.40
|mapmarker Swamp of Sorrows/0 40.40,29.80
|mapmarker Swamp of Sorrows/0 43.20,43.20
|mapmarker Swamp of Sorrows/0 43.60,29.00
|mapmarker Swamp of Sorrows/0 47.40,34.80
step
label "Kill_Swamp_Jaguars"
kill 10 Swamp Jaguar##767 |q 1396/3 |goto Swamp of Sorrows 26.40,47.40
|mapmarker Swamp of Sorrows/0 22.40,42.60
|mapmarker Swamp of Sorrows/0 23.00,39.60
|mapmarker Swamp of Sorrows/0 26.00,31.40
|mapmarker Swamp of Sorrows/0 26.20,35.20
|mapmarker Swamp of Sorrows/0 27.20,39.20
|mapmarker Swamp of Sorrows/0 28.40,43.40
|mapmarker Swamp of Sorrows/0 29.40,53.00
|mapmarker Swamp of Sorrows/0 31.40,50.20
|mapmarker Swamp of Sorrows/0 31.80,30.20
|mapmarker Swamp of Sorrows/0 32.40,35.40
|mapmarker Swamp of Sorrows/0 32.80,44.00
|mapmarker Swamp of Sorrows/0 33.40,53.40
|mapmarker Swamp of Sorrows/0 34.80,30.00
|mapmarker Swamp of Sorrows/0 36.80,45.60
|mapmarker Swamp of Sorrows/0 37.20,40.60
|mapmarker Swamp of Sorrows/0 37.40,37.40
|mapmarker Swamp of Sorrows/0 37.80,48.80
|mapmarker Swamp of Sorrows/0 39.60,30.60
|mapmarker Swamp of Sorrows/0 40.00,44.40
|mapmarker Swamp of Sorrows/0 40.60,36.40
|mapmarker Swamp of Sorrows/0 41.20,39.60
|mapmarker Swamp of Sorrows/0 43.00,44.40
step
talk Watcher Biggs##5476
turnin Encroaching Wildlife##1396 |goto Swamp of Sorrows 26.74,59.83
accept The Lost Caravan##1421 |goto Swamp of Sorrows 26.74,59.83
stickystart "Collect_Draenethyst_Crystals"
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
click Caravan Chest##28024
collect Wizards' Reagents##6170 |q 1421/1 |goto Swamp of Sorrows 64.46,18.34
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
Search for the Temple of Atal'Hakkar |q 1448/1 |goto Swamp of Sorrows 66.68,49.62
|tip Run in the water to avoid higher level enemies.
step
click Galen's Strongbox##32569
turnin Galen's Escape##1393 |goto Swamp of Sorrows 47.81,39.76
|only if not hardcore()
step
talk Magtoor##1776
turnin Draenethyst Crystals##1389 |goto Swamp of Sorrows 25.99,31.40
step
talk Watcher Biggs##5476
turnin The Lost Caravan##1421 |goto Swamp of Sorrows 26.74,59.83
step
kill Adolescent Whelp##740, Dreaming Whelp##741
|tip Tiny flying dragons.
collect 10 Speck of Dream Dust##5803 |q 1116/1 |goto Swamp of Sorrows/0 16.80,58.40
|mapmarker Swamp of Sorrows/0 11.40,62.00
|mapmarker Swamp of Sorrows/0 11.40,65.40
|mapmarker Swamp of Sorrows/0 15.00,61.60
|mapmarker Swamp of Sorrows/0 15.00,66.60
|mapmarker Swamp of Sorrows/0 12.40,57.40
step
Kill enemies
|tip Helps reach level 39 after quest turnins.
ding 38,77300 |goto Swamp of Sorrows 25.40,49.20
|mapmarker Swamp of Sorrows/0 16.20,53.40
|mapmarker Swamp of Sorrows/0 16.60,56.80
|mapmarker Swamp of Sorrows/0 19.20,53.20
|mapmarker Swamp of Sorrows/0 21.40,43.00
|mapmarker Swamp of Sorrows/0 21.40,59.00
|mapmarker Swamp of Sorrows/0 22.00,63.60
|mapmarker Swamp of Sorrows/0 22.40,37.20
|mapmarker Swamp of Sorrows/0 24.40,58.20
|mapmarker Swamp of Sorrows/0 25.00,61.60
|mapmarker Swamp of Sorrows/0 25.40,45.20
|mapmarker Swamp of Sorrows/0 27.60,63.60
|mapmarker Swamp of Sorrows/0 27.80,43.40
|mapmarker Swamp of Sorrows/0 28.20,52.20
|mapmarker Swamp of Sorrows/0 28.60,48.00
|mapmarker Swamp of Sorrows/0 28.80,60.60
|mapmarker Swamp of Sorrows/0 30.20,54.60
|mapmarker Swamp of Sorrows/0 32.00,50.80
|mapmarker Swamp of Sorrows/0 32.80,28.80
|mapmarker Swamp of Sorrows/0 34.60,54.60
|mapmarker Swamp of Sorrows/0 35.40,30.60
|mapmarker Swamp of Sorrows/0 37.60,28.40
|mapmarker Swamp of Sorrows/0 38.00,32.80
|mapmarker Swamp of Sorrows/0 38.40,45.80
|mapmarker Swamp of Sorrows/0 38.80,37.40
|mapmarker Swamp of Sorrows/0 40.40,29.80
|mapmarker Swamp of Sorrows/0 43.20,43.20
|mapmarker Swamp of Sorrows/0 43.60,29.00
|mapmarker Swamp of Sorrows/0 47.40,34.80
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
turnin Dream Dust in the Swamp##1116 |goto Stranglethorn Vale 26.94,77.21
step
Watch the dialogue
|tip {o}Top floor{} inside the building.
talk Krazek##773
accept Rumors for Kravel##1117 |goto Stranglethorn Vale 26.94,77.21
step
talk Auctioneer Jaxon##15659
|tip Buy from the Auction House, if possible.
collect 2 Draught of Water Breathing##5996 |goto Stormwind City/0 61.13,70.67 |q 668 |future |only if not (Druid or Warlock)
step
talk Olivia Burnside##2455
|tip Collect from the bank.
|tip Inside the building.
collect Karnitol's Satchel##6245 |goto Stormwind City 64.26,80.75 |q 1457
collect Bag of Water Elemental Bracers##3960 |goto Stormwind City 64.26,80.75 |q 602
step
talk Olivia Burnside##2455
|tip Deposit into the bank.
|tip Inside the building.
bank Goblin Rumors##5804 |goto Stormwind City/0 64.26,80.75 |q 1117 |future
bank Draenethyst Shard##6190 |goto Stormwind City/0 64.26,80.75 |q 1373		|only if haveq(1373) or completedq(1373)
step
talk Brohann Caskbelly##5384
|tip Inside the building.
turnin In Search of The Temple##1448 |goto Stormwind City 69.42,40.40
accept To The Hinterlands##1449 |goto Stormwind City 69.42,40.40
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Stormwind City 69.10,30.75 |q 1457
|tip Walk into the portal.
|only if not Mage
step
_Inside Deeprun Tram:_
Enter Ironforge |complete zone("Ironforge") |q 1457
|tip Walk into the portal.
|only if not Mage
step
talk Roetten Stonehammer##5637
|tip Walks around.
|tip Inside the building.
turnin The Karnitol Shipwreck##1457 |goto Ironforge 67.91,17.49
|mapmarker Ironforge/0 69.96,21.25
step
talk Prospector Stormpike##1356
|tip Inside the building.
accept Further Mysteries##525 |goto Ironforge 74.64,11.74
step
talk Auctioneer Redmuse##8720
|tip Buy from the Auction House, if possible.
|tip Needed for Whirlwind class quest.
|tip Big weapon upgrade.
|tip Inside the building.
collect 8 Liferoot##3357			|goto Ironforge 24.16,74.67 |q 1712 |future
collect 8 Thundering Charm##4480		|goto Ironforge 24.16,74.67 |q 1714 |future
collect 8 Burning Charm##4479			|goto Ironforge 24.16,74.67 |q 1714 |future
collect 8 Cresting Charm##4481			|goto Ironforge 24.16,74.67 |q 1714 |future
collect 2 Nature Protection Potion##6052	|goto Ironforge 24.16,74.67 |q 1713 |future
|tip Level 40 elite enemy soon.
|tip Hits hard with only Nature damage.
|tip If someone helps you, skip the potions.
|only if Warrior
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Arathi Highlands & Alterac Mountains (39-40)",{
image=ZGV.IMAGESDIR.."Arathi Highlands",
hardcore = true,
next="Leveling Guides\\Dustwallow Marsh (40-40)",
},[[
step
map Hillsbrad Foothills
path	follow strictbounce;	loop off;	ants straight;		dist 50;	markers none;		arrow hide
path	55.64,19.67	55.67,24.84	55.96,29.02	57.76,36.69	62.45,41.43
path	65.74,42.56	68.19,45.57	72.49,48.23	77.21,53.20	80.37,55.32
path	81.99,56.91
map Arathi Highlands
path	20.22,29.62	21.63,31.75	22.57,34.04	22.76,38.68	23.72,43.33
path	25.44,46.63	26.54,49.19	31.09,51.86	34.82,52.25	38.27,53.51
path	39.53,54.77	43.02,55.12	45.37,58.95	46.82,59.78	48.79,59.23
path	50.81,59.99	52.10,61.37	55.34,62.36	56.58,62.96	57.64,62.70
path	59.19,62.94	60.56,61.21	61.12,59.49	60.24,59.11
kill Forsaken Courier##2714
|tip Walks one-way on the road with 4 guards.
|tip Respawns if she reaches Tarren Mill.
|tip Begins walking again in Arathi Highlands.
|tip Can wait for her to respawn at the small house in Arathi.
collect Sealed Folder##4482 |q 658/1
Spawns around [Arathi Highlands/0 60.42,58.99] |noway
step
talk Apprentice Kryten##2788
accept Worth Its Weight in Gold##691 |goto Arathi Highlands 46.20,47.75
step
click Shards of Myzrael##138492
accept The Princess Trapped##642 |goto Arathi Highlands 62.50,33.80
step
kill Drywhisker Kobold##2572, Drywhisker Digger##2574, Drywhisker Surveyor##2573
|tip Kobolds.
|tip More inside the cave up the path.
|tip Avoid Hammerfall.
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
stickystart "Collect_Cresting_Charms_Warrior"
step
Leave the cave |goto Arathi Highlands 82.69,36.21 < 20 |walk |only if subzone("Drywhisker Gorge") and indoors()
click Stone of East Binding
|tip Avoid Hammerfall.
collect Cresting Key##4484 |q 651/2 |goto Arathi Highlands 66.75,29.75
step
label "Collect_Cresting_Charms_Warrior"
kill Cresting Exile##2761+
collect 8 Cresting Charm##4481 |goto Arathi Highlands 66.20,31.60 |q 1714 |future
|mapmarker Arathi Highlands/0 65.00,27.40
|mapmarker Arathi Highlands/0 65.20,29.80
|mapmarker Arathi Highlands/0 67.20,28.40
|mapmarker Arathi Highlands/0 68.60,30.60
|only if Warrior
stickystart "Collect_Witherbark_Medicine_Pouches"
stickystart "Collect_Witherbark_Tusks"
step
kill Witherbark Shadow Hunter##2557+
|tip Inside the cave.
collect Shadow Hunter Knife##5040 |q 691/3 |goto Arathi Highlands 68.32,75.18
|mapmarker Arathi Highlands/0 66.20,80.60
|mapmarker Arathi Highlands/0 67.40,77.40
|mapmarker Arathi Highlands/0 68.00,79.40
|mapmarker Arathi Highlands/0 68.60,82.00
|mapmarker Arathi Highlands/0 70.00,77.40
|tip Don't vendor them.
step
label "Collect_Witherbark_Medicine_Pouches"
Leave the cave |goto Arathi Highlands 68.32,75.18 < 20 |walk |only if subzone("Witherbark Village") and indoors()
kill Witherbark Witch Doctor##2555+
collect 4 Witherbark Medicine Pouch##4522 |q 691/2 |goto Arathi Highlands 65.80,68.00
|mapmarker Arathi Highlands/0 32.40,44.00
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
label "Collect_Witherbark_Tusks"
Leave the cave |goto Arathi Highlands 68.32,75.18 < 20 |walk |only if subzone("Witherbark Village") and indoors()
kill Witherbark Shadow Hunter##2557, Witherbark Headhunter##2556, Witherbark Axe Thrower##2554, Witherbark Witch Doctor##2555
collect 10 Witherbark Tusk##4503 |q 691/1 |goto Arathi Highlands 65.80,68.00
|mapmarker Arathi Highlands/0 32.40,44.00
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
talk Quae##2712
|tip Up on the ridge.
turnin Hints of a New Plague?##658 |goto Arathi Highlands 60.19,53.85
accept Hints of a New Plague?##657 |goto Arathi Highlands 60.19,53.85
step
talk Kinelory##2713
|tip Escort quest.
|tip Wait until she respawns, if missing.
turnin Hints of a New Plague?##657 |goto Arathi Highlands 60.24,53.92
accept Hints of a New Plague?##660 |goto Arathi Highlands 60.24,53.92 |noautoaccept inparty
step
Watch the dialogue
|tip Follow and protect Kinelory.
Protect Kinelory |q 660/1 |goto Arathi Highlands 60.24,53.92
step
talk Quae##2712
turnin Hints of a New Plague?##660 |goto Arathi Highlands 60.19,53.85
accept Hints of a New Plague?##661 |goto Arathi Highlands 60.19,53.85
stickystart "Collect_Thundering_Charms_Warrior"
step
click Stone of Outer Binding
collect Thundering Key##4485 |q 651/3 |goto Arathi Highlands 52.04,50.77
step
label "Collect_Thundering_Charms_Warrior"
kill Thundering Exile##2762+
collect 8 Thundering Charm##4480 |goto Arathi Highlands 52.20,52.60 |q 1714 |future
|mapmarker Arathi Highlands/0 50.40,50.40
|mapmarker Arathi Highlands/0 52.40,47.40
|mapmarker Arathi Highlands/0 53.60,49.20
|only if Warrior
step
talk Apprentice Kryten##2788
turnin Worth Its Weight in Gold##691 |goto Arathi Highlands 46.20,47.75
step
talk Phin Odelic##2711
turnin Hints of a New Plague?##661 |goto Hillsbrad Foothills 50.34,59.04
step
talk Innkeeper Anderson##2352
|tip Inside the building.
home Southshore |goto Hillsbrad Foothills 51.17,58.93 |q 1287 |future
step
talk Marshal Redpath##2263
accept Crushridge Bounty##500 |goto Hillsbrad Foothills 49.48,58.73
step
talk Magistrate Henry Maleb##2276
|tip Inside the building.
turnin Further Mysteries##525 |goto Hillsbrad Foothills 48.14,59.11
accept Dark Council##537 |goto Hillsbrad Foothills 48.14,59.11
accept Noble Deaths##512 |goto Hillsbrad Foothills 48.14,59.11
step
talk Archmage Ansirem Runeweaver##2543
turnin Magical Analysis##602 |goto Alterac Mountains 18.84,78.49
step
Watch the dialogue
talk Archmage Ansirem Runeweaver##2543
accept Ansirem's Key##603 |goto Alterac Mountains 18.84,78.49
stickystart "Collect_Alterac_Signet_Rings"
step
kill Nagaz##2320
|tip Careful, stealthed enemies.
|tip Inside the building.
collect Head of Nagaz##3672 |q 537/2 |goto Alterac Mountains 39.22,14.31
step
click Worn Wooden Chest
|tip Inside the building.
collect Ensorcelled Parchment##3706 |n
use Ensorcelled Parchment##3706
accept The Ensorcelled Parchment##551 |goto Alterac Mountains 39.18,14.66
step
kill 4 Argus Shadow Mage##2318 |q 537/1 |goto Alterac Mountains/0 63.40,43.80
|tip Humans in brown robes.
|tip Careful, stealthed enemies.
|tip Inside buildings. |only if subzone("Strahnbrad")
|mapmarker Alterac Mountains/0 53.20,20.80
|mapmarker Alterac Mountains/0 56.00,27.20
|mapmarker Alterac Mountains/0 57.40,46.00
|mapmarker Alterac Mountains/0 58.40,30.40
|mapmarker Alterac Mountains/0 60.00,43.80
|mapmarker Alterac Mountains/0 61.40,45.40
|mapmarker Alterac Mountains/0 61.80,41.00
|mapmarker Alterac Mountains/0 47.40,17.20
step
label "Collect_Alterac_Signet_Rings"
kill Syndicate Spy##2242, Syndicate Wizard##2319, Syndicate Sentry##2243, Syndicate Saboteur##2245, Syndicate Enforcer##2247, Syndicate Assassin##2246
|tip Careful, stealthed enemies. |notinsticky
collect 7 Alterac Signet Ring##3505 |q 512/1 |goto Alterac Mountains 62.20,45.60
|mapmarker Alterac Mountains/0 47.20,17.20
|mapmarker Alterac Mountains/0 47.80,20.80
|mapmarker Alterac Mountains/0 53.20,21.00
|mapmarker Alterac Mountains/0 53.40,24.40
|mapmarker Alterac Mountains/0 54.00,18.00
|mapmarker Alterac Mountains/0 54.40,28.00
|mapmarker Alterac Mountains/0 56.40,30.60
|mapmarker Alterac Mountains/0 57.00,25.40
|mapmarker Alterac Mountains/0 58.60,28.40
|mapmarker Alterac Mountains/0 59.60,31.40
|mapmarker Alterac Mountains/0 56.40,45.20
|mapmarker Alterac Mountains/0 57.40,41.60
|mapmarker Alterac Mountains/0 59.40,46.80
|mapmarker Alterac Mountains/0 59.80,43.80
|mapmarker Alterac Mountains/0 61.40,40.40
step
kill Crushridge Ogre##2252, Crushridge Brute##2253
|tip Ogres.
collect 9 Dirty Knucklebones##2843 |q 500/1 |goto Alterac Mountains 54.40,52.40
|mapmarker Alterac Mountains/0 44.40,61.40
|mapmarker Alterac Mountains/0 45.20,59.40
|mapmarker Alterac Mountains/0 46.00,63.80
|mapmarker Alterac Mountains/0 47.40,60.00
|mapmarker Alterac Mountains/0 48.00,55.60
|mapmarker Alterac Mountains/0 48.60,63.40
|mapmarker Alterac Mountains/0 49.20,52.40
|mapmarker Alterac Mountains/0 49.40,60.40
|mapmarker Alterac Mountains/0 50.00,55.40
|mapmarker Alterac Mountains/0 50.20,58.40
|mapmarker Alterac Mountains/0 51.40,53.20
|mapmarker Alterac Mountains/0 52.40,51.40
|mapmarker Alterac Mountains/0 53.20,54.60
|mapmarker Alterac Mountains/0 55.60,54.40
step
talk Marshal Redpath##2263
turnin Crushridge Bounty##500 |goto Hillsbrad Foothills 49.48,58.73
step
talk Magistrate Henry Maleb##2276
|tip Inside the building.
turnin Dark Council##537 |goto Hillsbrad Foothills 48.14,59.11
turnin Noble Deaths##512 |goto Hillsbrad Foothills 48.14,59.11
step
talk Loremaster Dibbs##2277
turnin The Ensorcelled Parchment##551 |goto Hillsbrad Foothills 50.57,57.09
step
talk Falstad Wildhammer##5635
turnin To The Hinterlands##1449 |goto The Hinterlands/0 11.81,46.76
accept Gryphon Master Talonaxe##1450 |goto The Hinterlands/0 11.81,46.76
step
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
|tip Top of the path.
turnin Gryphon Master Talonaxe##1450 |goto The Hinterlands/0 9.76,44.48
accept Rhapsody Shindigger##1451 |goto The Hinterlands/0 9.76,44.48
step
Follow the path up |goto The Hinterlands 20.81,47.82 < 30 |only if walking and not subzone("Shindigger's Camp")
talk Rhapsody Shindigger##5634
turnin Rhapsody Shindigger##1451 |goto The Hinterlands/0 26.94,48.59
accept Rhapsody's Kalimdor Kocktail##1452 |goto The Hinterlands/0 26.94,48.59
step
talk Skuerto##2789
accept Wand over Fist##693 |goto Arathi Highlands 46.65,47.01
step
Enter the cave |goto Arathi Highlands 53.75,77.37 < 15 |walk |only if not (subzone("Boulderfist Hall") and indoors())
kill Kor'gresh Coldrage##2793
|tip Inside the cave.
collect Trelane's Wand of Invocation##4525 |q 693/1 |goto Arathi Highlands 54.75,81.87
step
Kill enemies
|tip Helps reach level 40 after quest turnins.
|tip Inside and outside the cave.
ding 39,82700 |goto Arathi Highlands 54.75,81.87
|mapmarker Arathi Highlands/0 49.40,75.40
|mapmarker Arathi Highlands/0 51.20,72.40
|mapmarker Arathi Highlands/0 51.60,77.60
|mapmarker Arathi Highlands/0 53.80,74.60
stickystart "Collect_Burning_Charms_Warrior"
step
Leave the cave |goto Arathi Highlands 53.68,77.23 < 15 |walk |only if subzone("Boulderfist Hall") and indoors()
talk Skuerto##2789
turnin Wand over Fist##693 |goto Arathi Highlands 46.65,47.01
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 40 ammo when restocking.
Click Here to Continue |confirm |q 651
|only if Hunter
step
click Stone of West Binding
collect Burning Key##4483 |q 651/1 |goto Arathi Highlands 25.45,30.16
step
label "Collect_Burning_Charms_Warrior"
kill Burning Exile##2760+
|tip Avoid Refuge Point.
collect 8 Burning Charm##4479 |goto Arathi Highlands 24.40,30.40 |q 1714 |future
|mapmarker Arathi Highlands/0 24.40,28.40
|mapmarker Arathi Highlands/0 24.40,32.40
|mapmarker Arathi Highlands/0 26.40,28.60
|mapmarker Arathi Highlands/0 26.40,30.80
|only if Warrior
step
use Nature Protection Potion##6052
|tip Level 40 elite enemy soon.
|tip Need to use another {o}Nature Protection Potion{} during the fight.
|tip Use one now so cooldown is ready during the fight.
|tip Potion lasts 1 hour, plenty of time.
Click Here to Continue |confirm |q 1713 |future
|only if Warrior and itemcount(6052) > 0
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
|tip Use another {o}Nature Protection Potion{} when first one wears off. |only if itemcount(6052) > 0
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
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Maiden's Folly Log
|tip Brown book in a metal cauldron.
|tip {o}Middle floor{} inside the sunken ship.
collect Maiden's Folly Log##4489 |q 662/2 |goto Arathi Highlands 23.41,85.10
step
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Maiden's Folly Charts
|tip Tan flat scroll.
|tip {o}Middle floor{} inside the sunken ship.
collect Maiden's Folly Charts##4487 |q 662/1 |goto Arathi Highlands 23.04,84.51
step
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Spirit of Silverpine Charts
|tip Tan flat scroll.
|tip {o}Middle floor{} inside the sunken ship.
collect Spirit of Silverpine Charts##4488 |q 662/3 |goto Arathi Highlands 20.45,85.60
step
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman)
click Spirit of Silverpine Log
|tip Open book.
|tip Very bottom inside the ship.
collect Spirit of Silverpine Log##4490 |q 662/4 |goto Arathi Highlands 20.65,85.10
step
label "Collect_Elven_Gems"
equip Goggles of Gem Hunting##4491 |n |only if not equipped(4491)
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman) |notinsticky
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
use Draught of Water Breathing##5996 |only if itemcount(5996) > 0 and not hasbuff(7178) and not (Druid or Warlock or Shaman) |notinsticky
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
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 554 |future
|only if Druid
step
talk Loremaster Dibbs##2277
accept Stormpike's Deciphering##554 |goto Hillsbrad Foothills 50.57,57.09
step
talk Prospector Stormpike##1356
|tip Inside the building.
turnin Stormpike's Deciphering##554 |goto Ironforge 74.64,11.74
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 1260
|only if Mage
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 1260
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 1260
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
Train Pet Abilities |trainer Belia Thundergranite##10090 |goto Ironforge/0 70.86,85.84 |q 1260
|only if Hunter
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 1260
|only if Rogue
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 1260
|only if Warlock
step
talk Briarthorn##5172
|tip Inside the building.
accept Summon Felsteed##4487 |goto Ironforge/0 50.35,5.66
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 1260
|only if Warlock
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 1260
|only if Priest
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Dustwallow Marsh (40-40)",{
image=ZGV.IMAGESDIR.."Dustwallow Marsh",
hardcore = true,
next="Leveling Guides\\Desolace (40-41)",
},[[
step
talk Auctioneer Redmuse##8720
|tip Buy from the Auction House, if possible.
collect Moonsteel Broadsword##3853 |goto Ironforge 24.16,74.67 |q 1203 |future
|tip Needed for quest soon.
|only if level <= 41
step
talk Bailey Stonemantle##2461
|tip Collect from the bank.
|tip Inside the building.
collect Draenethyst Shard##6190 |goto Ironforge/0 35.93,60.13 |q 1373		|only if haveq(1373) or completedq(1373)
step
talk Bailey Stonemantle##2461
|tip Deposit into the bank.
|tip Inside the building.
bank Sample Elven Gem##4502 |goto Ironforge/0 35.93,60.13 |q 669
step
Enter the building |goto Stormwind City 52.98,51.10 < 15 |walk |only if not subzone("Cathedral of Light")
talk Duthorian Rall##6171
|tip Inside the building.
accept The Tome of Nobility##1661 |goto Stormwind City 50.47,47.47 |instant
|only if Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Nobility##1661 |goto Stormwind City 50.47,47.47 |instant
|only if Paladin
step
talk Katherine the Pure##5492
|tip Inside the building.
Train Abilities |trainer Katherine the Pure##5492 |goto Stormwind City/0 48.47,49.06 |q 1260
|only if Paladin
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
Follow the path |goto Ironforge 44.56,49.58 < 15 |walk |only if not subzone("The High Seat")
talk King Magni Bronzebeard##2784
turnin A King's Tribute##700 |goto Ironforge 39.09,56.20
step
_NOTE:_
Optional Dungeon Later
|tip Can run {o}Scarlet Monastery{} dungeon later.
|tip Slower leveling, but potential gear upgrades.
|tip We'll pick up dungeon quests.
|tip Guide will say when it's time to run the dungeon.
Click Here to Run {y}Scarlet Monastery{} Dungeon Later |confirm SMflag |multiq 1050,1053 |future
|tip Skip if you'd rather grind.
step
talk Librarian Mae Paledust##3979
|tip Inside the building.
accept Mythology of the Titans##1050 |goto Ironforge 74.97,12.48
|only if guideflag("SMflag")
step
talk Jartsam##4753
Train Tiger Riding |learnspell Tiger Riding##828 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Strahad Farsan##6251
turnin Summon Felsteed##4487 |goto The Barrens/0 62.63,35.50 |only if haveq(4487)
turnin Summon Felsteed##4488 |goto The Barrens/0 62.63,35.50 |only if haveq(4488)
accept Summon Felsteed##4490 |goto The Barrens/0 62.63,35.50
|only if Warlock
step
talk Strahad Farsan##6251
turnin Summon Felsteed##4490 |goto The Barrens/0 62.63,35.50
|only if Warlock
step
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
accept The Deserters##1286 |goto Dustwallow Marsh 68.21,48.62
step
talk Morgan Stern##4794
|tip Inside the building.
turnin Morgan Stern##1260 |goto Dustwallow Marsh/0 66.33,45.47
accept Mudrock Soup and Bugs##1204 |goto Dustwallow Marsh/0 66.33,45.47
step
kill Mudrock Spikeshell##4397, Mudrock Tortoise##4396
|tip Turtles.
collect 8 Forked Mudrock Tongue##5883 |q 1204/1 |goto Dustwallow Marsh 64.60,42.60
|mapmarker Dustwallow Marsh/0 59.60,15.00
|mapmarker Dustwallow Marsh/0 60.20,18.40
|mapmarker Dustwallow Marsh/0 61.40,21.00
|mapmarker Dustwallow Marsh/0 61.40,27.40
|mapmarker Dustwallow Marsh/0 61.40,30.40
|mapmarker Dustwallow Marsh/0 62.00,24.40
|mapmarker Dustwallow Marsh/0 62.40,33.40
|mapmarker Dustwallow Marsh/0 63.00,35.40
|mapmarker Dustwallow Marsh/0 64.00,38.80
step
kill Mirefin Coastrunner##4362, Mirefin Murloc##4359, Mirefin Muckdweller##4361, Mirefin Puddlejumper##4358, Mirefin Warrior##4360, Mirefin Oracle##4363
|tip Murlocs.
collect 12 Mirefin Head##5847 |q 1177/1 |goto Dustwallow Marsh 58.60,17.60
|mapmarker Dustwallow Marsh/0 53.40,15.80
|mapmarker Dustwallow Marsh/0 54.00,12.20
|mapmarker Dustwallow Marsh/0 55.80,20.40
|mapmarker Dustwallow Marsh/0 57.83,21.37
|mapmarker Dustwallow Marsh/0 59.00,15.40
|mapmarker Dustwallow Marsh/0 59.40,9.80
|mapmarker Dustwallow Marsh/0 62.80,8.00
|mapmarker Dustwallow Marsh/0 63.40,17.60
|mapmarker Dustwallow Marsh/0 63.80,28.00
step
talk "Swamp Eye" Jarl##4792
accept Jarl Needs Eyes##1206 |goto Dustwallow Marsh 55.44,26.27
step
talk "Stinky" Ignatz##4880
|tip Escort quest.
|tip Wait until he respawns, if missing.
|tip Kill nearby raptors first.
accept Stinky's Escape##1222 |goto Dustwallow Marsh 46.89,17.52
step
Watch thed dialogue
|tip Follow and protect "Stinky" Ignatz.
Help Stinky Find Bogbean Leaves |q 1222/1 |goto Dustwallow Marsh 48.86,24.66
step
talk Private Hendel##4966
|tip Walks around.
accept The Missing Diplomat##1324 |goto Dustwallow Marsh 45.22,24.64 |noautoaccept inparty
|tip Multiple enemies attack.
|tip Focus on killing {o}Private Hendel{}.
|tip Helpers run away once he surrenders.
step
kill Private Hendel##4966
Watch the dialogue
Subdue Private Hendel |q 1324/1 |goto Dustwallow Marsh 45.22,24.64
step
talk Archmage Tervosh##4967
turnin The Missing Diplomat##1324 |goto Dustwallow Marsh 45.19,24.30
step
talk Lady Jaina Proudmoore##4968
accept The Missing Diplomat##1267 |goto Dustwallow Marsh/0 45.22,24.24 |instant
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
Leave the mine |goto Dustwallow Marsh/0 33.22,22.75 < 15 |walk |only if subzone("Darkmist Cavern") and indoors()
talk "Swamp Eye" Jarl##4792
turnin Jarl Needs Eyes##1206 |goto Dustwallow Marsh 55.44,26.27
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
talk Mudcrush Durtfeet##4503
|tip Avoid Brackenwall Village.
turnin Hungry!##1177 |goto Dustwallow Marsh 35.15,38.26
step
kill Balos Jacken##5089
|tip Talk to him after he surrenders.
|tip Upstairs inside the building.
turnin The Deserters##1286 |goto Dustwallow Marsh 36.09,54.30
accept The Deserters##1287 |goto Dustwallow Marsh 36.09,54.30
step
click Gizmorium Shipping Crate
collect Seaforium Booster##5862 |q 1187/1 |goto Dustwallow Marsh 54.07,56.49
step
talk Morgan Stern##4794
|tip Inside the building.
turnin Mudrock Soup and Bugs##1204 |goto Dustwallow Marsh 66.34,45.47
accept ... and Bugs##1258 |goto Dustwallow Marsh 66.34,45.47
turnin Stinky's Escape##1222 |goto Dustwallow Marsh 66.34,45.47
step
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin The Deserters##1287 |goto Dustwallow Marsh 68.21,48.62
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Desolace (40-41)",{
image=ZGV.IMAGESDIR.."Desolace",
hardcore = true,
next="Leveling Guides\\Badlands (41-42)",
},[[
step
talk Innkeeper Lyshaerya##11103
|tip Inside the building.
home Nijel's Point |goto Desolace 66.27,6.56 |q 1467 |future
step
talk Brother Anton##1182
|tip Inside the building.
accept Down the Scarlet Path##261 |goto Desolace 66.52,7.91
step
talk Kreldig Ungor##5638
accept Reagents for Reclaimers Inc.##1466 |goto Desolace 66.20,9.63
step
talk Hornizz Brimbuzzle##6019
|tip Avoid Ghost Walker Post.
accept Ghost-o-plasm Round Up##6134 |goto Desolace 47.83,61.82
step
talk Uthek the Wise##5397
turnin Ongeku##1373 |goto Desolace 36.22,79.25
accept Khan Jehn##1374 |goto Desolace 36.22,79.25
|only if not hardcore()
step
_NOTE:_
Begin Finding a Dungeon Group
|tip Good time to run {o}Scarlet Monastery{} dungeon soon.
|tip Start looking for a group.
Click Here to Continue |confirm |multiq 1050,1053 |future
|only if guideflag("SMflag")
stickystart "Collect_Felhound_Brains"
stickystart "Collect_Nether_Wings"
step
kill Doomwarder Captain##4680+
|tip Felguards.
|tip Only location, wait for respawns.
collect 10 Doomwarder Blood##6252 |q 1466/3 |goto Desolace/0 50.40,82.40
|mapmarker Desolace/0 51.40,81.40
|mapmarker Desolace/0 50.80,84.60
|mapmarker Desolace/0 51.60,83.20
step
label "Collect_Felhound_Brains"
kill Mana Eater##4678, Ley Hunter##4685, Mage Hunter##4681
|tip Felhounds.
collect 10 Felhound Brain##6250 |q 1466/1 |goto Desolace/0 53.40,77.20
|mapmarker Desolace/0 50.00,81.40
|mapmarker Desolace/0 50.40,68.00
|mapmarker Desolace/0 51.40,85.40
|mapmarker Desolace/0 53.60,68.00
|mapmarker Desolace/0 55.80,72.60
step
label "Collect_Nether_Wings"
kill Nether Maiden##4679, Nether Sister##4682, Nether Sorceress##4684
|tip Succubuses.
collect 10 Nether Wing##6251 |q 1466/2 |goto Desolace/0 54.20,77.80
|mapmarker Desolace/0 48.40,77.00
|mapmarker Desolace/0 49.80,73.60
|mapmarker Desolace/0 52.20,84.40
|mapmarker Desolace/0 53.20,71.00
stickystart "Kill_Undead_Ravagers"
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
label "Kill_Undead_Ravagers"
kill 30 Undead Ravager##11561 |q 261/1 |goto Desolace 64.60,91.20
|tip Brown skeletons.
|mapmarker Desolace/0 58.20,89.40
|mapmarker Desolace/0 61.40,90.80
|mapmarker Desolace/0 64.00,80.40
|mapmarker Desolace/0 64.00,88.00
|mapmarker Desolace/0 64.20,84.40
step
Kill enemies
|tip Helps reach level 41 after quest turnins.
ding 40,88450 |goto Desolace 64.60,91.20 |only if hardcore()
ding 40,85600 |goto Desolace 64.60,91.20 |only if not hardcore()
|mapmarker Desolace/0 58.20,89.40
|mapmarker Desolace/0 61.40,90.80
|mapmarker Desolace/0 64.00,80.40
|mapmarker Desolace/0 64.00,88.00
|mapmarker Desolace/0 64.20,84.40
step
kill Khan Jehn##5601
|tip Walks around.
|tip In and out of the tent.
collect Khan Jehn's Head##6072 |q 1374/1 |goto Desolace 66.39,80.08
|only if not hardcore()
step
talk Hornizz Brimbuzzle##6019
turnin Ghost-o-plasm Round Up##6134 |goto Desolace 47.83,61.83
step
talk Uthek the Wise##5397
turnin Khan Jehn##1374 |goto Desolace 36.22,79.25
|only if not hardcore()
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Goblin Rumors##5804 |goto Tanaris 52.30,28.91 |q 1117
step
talk Laziphus##9985
Stable Your Pet |stablemaster Laziphus##9985 |goto Tanaris/0 52.25,28.00 |q 1117
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 6){}.
|only if Hunter
step
Learn the {y}Claw (Rank 6){} Pet Ability |learnspell Claw##2976 |goto Tanaris/0 50.00,31.00 |q 1117
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
Retrieve Your Pet |stablemaster Laziphus##9985 |goto Tanaris/0 52.25,28.00 |q 1117
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 6){} to Your Pet |learnpetspell Claw##16832 |q 1117
|tip Use {o}Beast Training{} ability.
|only if Hunter
step
talk Kravel Koalbeard##4452
turnin Rumors for Kravel##1117 |goto Thousand Needles 77.79,77.27
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Back to Booty Bay##1118 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
accept Martek the Exiled##1106 |goto Thousand Needles 78.06,77.12
step
talk Razzeric##4706
turnin Razzeric's Tweaking##1187 |goto Thousand Needles 80.33,76.10
accept Safety First##1188 |goto Thousand Needles 80.33,76.10
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261	|goto Desolace 66.52,7.91
accept Down the Scarlet Path##1052	|goto Desolace 66.52,7.91 |only if guideflag("SMflag")
step
talk Kreldig Ungor##5638
turnin Reagents for Reclaimers Inc.##1466 |goto Desolace 66.20,9.63
accept Reagents for Reclaimers Inc.##1467 |goto Desolace 66.20,9.63
step
talk Jartsam##4753
Train Tiger Riding |learnspell Tiger Riding##828 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto Hillsbrad Foothills/0 51.47,58.35
accept In the Name of the Light##1053 |goto Hillsbrad Foothills/0 51.47,58.35
|only if guideflag("SMflag")
step
_NOTE:_
Starting Dungeon Run
|tip Running {o}Scarlet Monastery{} dungeon now.
|tip We will do {o}Library{}, {o}Armory{}, and {o}Cathedral{} sections.
|tip Meet with your dungeon group.
Click Here to Continue |confirm |multiq 1050,1053 |future
|only if guideflag("SMflag")
step
Enter the Scarlet Monastery {y}Library{} Dungeon |complete zone("Scarlet Monastery") |multiq 1050,1053 |future
|tip Follow your group.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Library{} section.
kill Houndmaster Loksey##3974 |q 1053/4
|tip First boss.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Library{} section.
click Mythology of the Titans##19284
|tip Run through the {o}Gallery of Treasures{}.
|tip Watch for minimap subzone to change back to {o}Scarlet Monastery{}.
|tip Small book below a window.
|tip Left side of the room.
collect Mythology of the Titans##5536 |q 1050/1
|only if guideflag("SMflag")
step
Leave the Scarlet Monastery {y}Library{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1050,1053 |future
|tip Follow your group.
|only if guideflag("SMflag")
step
Enter the Scarlet Monastery {y}Armory{} Dungeon |complete zone("Scarlet Monastery") |multiq 1050,1053 |future
|tip Follow your group.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Armory{} section.
kill Herod##3975 |q 1053/3
|tip Final boss.
|only if guideflag("SMflag")
step
Leave the Scarlet Monastery {y}Armory{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1050,1053 |future
|tip Follow your group.
|only if guideflag("SMflag")
step
Enter the Scarlet Monastery {y}Cathedral{} Dungeon |complete zone("Scarlet Monastery") |multiq 1050,1053 |future
|tip Follow your group.
|only if guideflag("SMflag")
step
_Inside the Scarlet Monastery Dungeon:_
|tip {o}Cathedral{} section.
kill Scarlet Commander Mograine##3976 |q 1053/2
kill High Inquisitor Whitemane##3977 |q 1053/1
|tip Final boss.
|only if guideflag("SMflag")
step
Leave the Scarlet Monastery {y}Cathedral{} Dungeon |complete not zone("Scarlet Monastery") |multiq 1050,1053 |future
|tip Follow your group.
|only if guideflag("SMflag")
step
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin In the Name of the Light##1053 |goto Hillsbrad Foothills 51.47,58.35
|only if guideflag("SMflag")
step
talk Librarian Mae Paledust##3979
|tip Inside the building.
turnin Mythology of the Titans##1050 |goto Ironforge 74.97,12.48
|only if guideflag("SMflag")
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Badlands (41-42)",{
image=ZGV.IMAGESDIR.."Badlands",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale (42-43)",
},[[
step
talk Bryllia Ironbrand##5101
|tip Downstairs inside the building.
Buy Extra Ammo |vendor Bryllia Ironbrand##5101 |goto Ironforge/0 39.23,74.47 |q 1467
|tip Long questing session soon.
|tip No ammo vendor.
|only if Hunter
step
talk Bailey Stonemantle##2461
|tip Deposit into the bank.
|tip Inside the building.
bank Kravel's Scheme##5826 |goto Ironforge 35.92,60.14 |q 1118
bank Seaforium Booster##5862 |goto Ironforge 35.92,60.14 |q 1188
step
talk Auctioneer Redmuse##8720
|tip Buy from the Auction House, if possible.
|tip Needed for easy quest turnins in Badlands soon.
|tip Inside the building.
collect 9 Blue Pearl##4611			|goto Ironforge 24.16,74.67 |q 705 |future
collect Frost Oil##3829				|goto Ironforge 24.16,74.67 |q 713 |future
collect Gyrochronatom##4389			|goto Ironforge 24.16,74.67 |q 714 |future
collect Healing Potion##929			|goto Ironforge 24.16,74.67 |q 715 |future
collect Lesser Invisibility Potion##3823	|goto Ironforge 24.16,74.67 |q 715 |future
collect Patterned Bronze Bracers##2868		|goto Ironforge 24.16,74.67 |q 716 |future
|only if level <= 45
step
talk Roetten Stonehammer##5637
|tip Walks around.
|tip Inside the building.
turnin Reagents for Reclaimers Inc.##1467 |goto Ironforge 67.91,17.49
|mapmarker Ironforge/0 69.96,21.25
step
talk Prospector Stormpike##1356
|tip Inside the building.
accept Ironband Wants You!##707 |goto Ironforge 74.64,11.74
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Innkeeper Hearthstove##6734
|tip Inside the building.
home Stoutlager Inn |goto Loch Modan 35.53,48.40 |q 2500 |future
|only if hardcore()
step
talk Ghak Healtouch##1470
|tip Inside the building.
accept Badlands Reagent Run##2500 |goto Loch Modan 37.07,49.38
step
talk Prospector Ironband##1344
turnin Ironband Wants You!##707 |goto Loch Modan 65.93,65.62
accept Find Agmond##738 |goto Loch Modan 65.93,65.62
stickystart "Collect_Buzzard_Items"
stickystart "Collect_Crag_Coyote_Fangs"
step
talk Prospector Ryedol##2910
accept A Dwarf and His Tools##719 |goto Badlands 53.42,43.40
step
talk Sigrun Ironhew##2860
accept Mirages##718 |goto Badlands 53.80,43.31
stickystart "Collect_Ryedols_Lucky_Pick"
step
click Crumpled Map
|tip Up on the ledge.
accept A Sign of Hope##720 |goto Badlands 53.03,33.93
step
label "Collect_Ryedols_Lucky_Pick"
kill Shadowforge Tunneler##2739, Shadowforge Darkweaver##2740, Shadowforge Warrior##2743, Shadowforge Chanter##2742
|tip Dwarves.
collect Ryedol's Lucky Pick##4616 |q 719/1 |goto Badlands 51.40,32.60
|mapmarker Badlands/0 50.80,28.20
|mapmarker Badlands/0 51.40,30.40
|mapmarker Badlands/0 53.20,34.20
|mapmarker Badlands/0 53.40,31.00
|mapmarker Badlands/0 39.40,27.40
|mapmarker Badlands/0 40.40,25.40
|mapmarker Badlands/0 41.00,34.60
|mapmarker Badlands/0 41.20,29.60
|mapmarker Badlands/0 41.40,27.20
|mapmarker Badlands/0 42.20,32.40
|mapmarker Badlands/0 43.20,28.40
|mapmarker Badlands/0 43.40,30.60
|mapmarker Badlands/0 44.40,33.40
|mapmarker Badlands/0 45.40,30.20
step
click Excavation Supply Crate
|tip Wooden crate.
|tip Multiple locations.
collect Supply Crate##4629 |q 718/1 |goto Badlands 66.61,22.02
|mapmarker Badlands/0 66.80,23.40
step
talk Prospector Ryedol##2910
turnin A Dwarf and His Tools##719 |goto Badlands 53.42,43.40
turnin A Sign of Hope##720 |goto Badlands 53.42,43.40
step
talk Sigrun Ironhew##2860
turnin Mirages##718 |goto Badlands 53.80,43.31
accept Scrounging##733 |goto Badlands 53.80,43.31
step
talk Rigglefuzz##2817
accept Pearl Diving##705 |goto Badlands/0 42.39,52.93 |only if itemcount(4611) >= 9
accept Barbecued Buzzard Wings##703 |goto Badlands 42.39,52.93
step
talk Rigglefuzz##2817
turnin Pearl Diving##705 |goto Badlands/0 42.39,52.93
|only if readyq(705) or completedq(705)
step
talk Martek the Exiled##4618
turnin Martek the Exiled##1106 |goto Badlands 42.22,52.69
accept Indurium##1108 |goto Badlands 42.22,52.69
step
click Battered Dwarven Skeleton
turnin Find Agmond##738 |goto Badlands 50.89,62.41
accept Murdaloc##739 |goto Badlands 50.89,62.41
stickystart "Collect_Iridium_Flakes"
stickystart "Kill_Stonevault_Bonesnapper"
step
kill Murdaloc##2945 |q 739/1 |goto Badlands 49.63,66.30
|tip Walks around.
|mapmarker Badlands/0 49.20,64.60
|mapmarker Badlands/0 50.20,69.60
|mapmarker Badlands/0 51.00,66.00
|mapmarker Badlands/0 53.00,69.20
step
label "Collect_Iridium_Flakes"
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
label "Kill_Stonevault_Bonesnapper"
kill 12 Stonevault Bonesnapper##2893 |q 739/2 |goto Badlands 50.40,68.60
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
talk Rigglefuzz##2817
turnin Barbecued Buzzard Wings##703 |goto Badlands 42.39,52.93
|only if readyq(703) or completedq(703)
step
talk Martek the Exiled##4618
turnin Indurium##1108 |goto Badlands 42.21,52.70
step
Watch the dialogue
talk Martek the Exiled##4618
accept News for Fizzle##1137 |goto Badlands 42.21,52.70
step
talk Lotwil Veriatus##2921
|tip Walks around.
accept Study of the Elements: Rock##710 |goto Badlands 25.95,44.87
accept Coolant Heads Prevail##713 |goto Badlands/0 25.95,44.87 |only if itemcount(3829) > 0
stickystop "Collect_Buzzard_Items"
stickystop "Collect_Crag_Coyote_Fangs"
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
|only if readyq(714) or completedq(714)
step
talk Lucien Tosselwrench##2920
accept Liquid Stone##715 |goto Badlands/0 25.82,44.23
|only if itemcount(929) > 0 and itemcount(3823) > 0
step
talk Lucien Tosselwrench##2920
turnin Liquid Stone##715 |goto Badlands/0 25.82,44.23
|only if haveq(715) or completedq(715)
stickystart "Collect_Rock_Elemental_Shards"
step
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
talk Lotwil Veriatus##2921
|tip Walks around.
turnin Study of the Elements: Rock##711 |goto Badlands 25.95,44.87
accept Study of the Elements: Rock##712 |goto Badlands 25.95,44.87
stickystart "Collect_Scrap_Metal"
stickystart "Collect_Buzzard_Items"
stickystart "Collect_Crag_Coyote_Fangs"
step
kill Greater Rock Elemental##2736+
collect 5 Bracers of Rock Binding##4628 |q 712/1 |goto Badlands 4.40,77.40
|mapmarker Badlands/0 0.80,78.40
|mapmarker Badlands/0 1.40,81.40
|mapmarker Badlands/0 1.60,84.60
|mapmarker Badlands/0 4.20,82.60
|mapmarker Badlands/0 6.40,73.40
|mapmarker Badlands/0 6.60,80.20
|mapmarker Badlands/0 13.20,82.40
|mapmarker Badlands/0 13.20,87.40
|mapmarker Badlands/0 14.40,90.60
|mapmarker Badlands/0 16.20,86.20
|mapmarker Badlands/0 17.40,83.20
step
label "Collect_Rock_Elemental_Shards"
kill Lesser Rock Elemental##2735, Rock Elemental##92, Enraged Rock Elemental##2791, Greater Rock Elemental##2736
collect 5 Rock Elemental Shard##7848 |q 2500/3 |goto Badlands 4.40,77.40
|mapmarker Badlands/0 0.80,78.40
|mapmarker Badlands/0 1.40,81.40
|mapmarker Badlands/0 1.60,84.60
|mapmarker Badlands/0 4.20,82.60
|mapmarker Badlands/0 6.40,73.40
|mapmarker Badlands/0 6.60,80.20
|mapmarker Badlands/0 13.20,82.40
|mapmarker Badlands/0 13.20,87.40
|mapmarker Badlands/0 14.40,90.60
|mapmarker Badlands/0 16.20,86.20
|mapmarker Badlands/0 17.40,83.20
step
label "Collect_Scrap_Metal"
kill Dustbelcher Wyrmhunter##2716, Dustbelcher Shaman##2718, Dustbelcher Mauler##2717, Dustbelcher Ogre Mage##2720, Dustbelcher Lord##2719
|tip Ogres.
collect 7 Scrap Metal##4630 |q 733/1 |goto Badlands 12.40,74.40
|mapmarker Badlands/0 7.00,74.60
|mapmarker Badlands/0 8.00,80.40
|mapmarker Badlands/0 8.20,83.60
|mapmarker Badlands/0 8.60,71.80
|mapmarker Badlands/0 9.40,76.40
|mapmarker Badlands/0 13.40,77.40
step
label "Collect_Buzzard_Items"
kill Giant Buzzard##2831, Buzzard##2830
|tip Group of them at this location. |notinsticky
|tip Spread out elsewhere. |notinsticky
collect 5 Buzzard Gizzard##7847 |q 2500/1 |goto Badlands 17.20,61.00
collect 4 Buzzard Wing##3404 |goto Badlands 17.20,61.00 |q 703 |future
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
step
label "Collect_Crag_Coyote_Fangs"
kill Crag Coyote##2727, Feral Crag Coyote##2728, Elder Crag Coyote##2729
collect 10 Crag Coyote Fang##7846 |q 2500/2 |goto Badlands 20.80,56.80
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
talk Rigglefuzz##2817
turnin Barbecued Buzzard Wings##703 |goto Badlands 42.39,52.93
step
_Destroy These Items:_
|tip Not needed.
trash Buzzard Wing##3404
step
talk Sigrun Ironhew##2860
turnin Scrounging##733 |goto Badlands 53.80,43.31
step
talk Lotwil Veriatus##2921
|tip Walks around.
turnin Study of the Elements: Rock##712 |goto Badlands 25.95,44.87
accept This Is Going to Be Hard##734 |goto Badlands/0 25.95,44.87 |only if completedq(713) and completedq(714)
step
talk Lucien Tosselwrench##2920
turnin This Is Going to Be Hard##734 |goto Badlands/0 25.82,44.24 |only if completedq(713) and completedq(714)
accept This Is Going to Be Hard##777 |goto Badlands/0 25.82,44.24 |only if completedq(713) and completedq(714)
accept Stone Is Better than Cloth##716 |goto Badlands/0 25.82,44.24 |only if itemcount(2868) > 0
step
talk Lucien Tosselwrench##2920
turnin Stone Is Better than Cloth##716 |goto Badlands/0 25.82,44.24
|only if haveq(716) or completedq(716)
step
talk Lotwil Veriatus##2921
|tip Walks around.
turnin This Is Going to Be Hard##777 |goto Badlands/0 25.95,44.86
accept This Is Going to Be Hard##778 |goto Badlands/0 25.95,44.86
|only if completedq(713) and completedq(714)
step
Watch the dialogue
kill Fam'retor Guardian##2919
collect Lotwil's Shackles of Elemental Binding##4847 |q 778/1 |goto Badlands/0 26.10,46.81
|only if completedq(713) and completedq(714)
step
talk Lotwil Veriatus##2921
|tip Walks around.
turnin This Is Going to Be Hard##778 |goto Badlands/0 25.95,44.87
|only if completedq(713) and completedq(714)
step
Kill enemies
|tip Helps reach level 42 after quest turnins.
ding 41,89350 |goto Badlands 20.80,56.80
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
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 2500
|only if Druid and hardcore()
step
Allow Enemies to Kill You
|tip Must be near this location.
|tip Getting Thorium Point flight path.
|tip Saves time later.
|tip Traveling a bit after, don't worry about resurrection sickness.
Die on Purpose |complete isdead |goto Searing Gorge 67.82,51.45 |q 2500
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Searing Gorge 35.50,22.79 |q 2500 |zombiewalk
|only if not hardcore()
step
talk Lanie Reed##2941
fpath Thorium Point |goto Searing Gorge 37.94,30.86
|only if not hardcore()
step
talk Innkeeper Hearthstove##6734
|tip Inside the building.
home Stoutlager Inn |goto Loch Modan 35.53,48.40 |q 603 |future
|only if not hardcore()
step
talk Ghak Healtouch##1470
|tip Inside the building.
turnin Badlands Reagent Run##2500 |goto Loch Modan 37.07,49.38
step
_Destroy These Items:_
|tip Not needed.
trash Crag Coyote Fang##7846
step
talk Prospector Ironband##1344
turnin Murdaloc##739 |goto Loch Modan 65.93,65.62
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 669
|only if Druid and not hardcore()
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 669
|only if Mage
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 669
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 669
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
Train Pet Abilities |trainer Belia Thundergranite##10090 |goto Ironforge/0 70.86,85.84 |q 669
|only if Hunter
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 669
|only if Rogue
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 669
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 669
|only if Warlock
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 669
|only if Priest
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 669
|only if Paladin
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale (42-43)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Swamp of Sorrows (43-43)",
},[[
step
talk Bailey Stonemantle##2461
|tip Collect from the bank.
|tip Inside the building.
collect Sample Elven Gem##4502 |goto Ironforge 35.92,60.14 |q 669
collect Kravel's Scheme##5826 |goto Ironforge 35.92,60.14 |q 1118
step
talk Jartsam##4753
Train Tiger Riding |learnspell Tiger Riding##828 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk High Sorcerer Andromath##5694
|tip Top of the tower.
accept Vital Supplies##1477 |goto Stormwind City 48.71,87.63
step
Enter the building |goto Stormwind City/0 51.52,73.69 < 10 |walk
talk Acolyte Dellis##5386
|tip Upstairs inside the building.
accept Mazen's Behest##1364 |goto Stormwind City 51.37,73.82
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
accept Skullsplitter Tusks##209 |goto Stranglethorn Vale 27.00,77.13
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
turnin Sunken Treasure##669 |goto Stranglethorn Vale 27.17,77.01
step
talk Catelyn the Blade##2542
|tip {o}Middle floor{} inside the building.
turnin Ansirem's Key##603 |goto Stranglethorn Vale 27.28,77.53
accept "Pretty Boy" Duncan##610 |goto Stranglethorn Vale 27.28,77.53
step
talk Innkeeper Skindle##6807
|tip {o}Ground floor{} inside the building.
|tip Inside the building.
home Booty Bay |goto Stranglethorn Vale 27.04,77.31 |q 1258 |future
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
turnin Back to Booty Bay##1118 |goto Stranglethorn Vale/0 27.12,77.21
step
Watch the dialogue
|tip {o}Ground floor{} inside the building.
talk Crank Fizzlebub##2498
accept Venture Company Mining##600 |goto Stranglethorn Vale 27.12,77.21
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
accept Excelsior##628 |goto Stranglethorn Vale 28.29,77.59
step
Run through the tunnel to leave Booty Bay |goto Stranglethorn Vale 28.00,73.46 < 15 |only if walking and (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
kill Elder Mistvale Gorilla##1557+
collect 5 Mistvale Giblets##3919 |q 606/1 |goto Stranglethorn Vale 31.20,68.20
|mapmarker Stranglethorn Vale/0 31.00,60.00
|mapmarker Stranglethorn Vale/0 31.20,65.20
|mapmarker Stranglethorn Vale/0 32.80,61.40
|mapmarker Stranglethorn Vale/0 33.20,64.60
|mapmarker Stranglethorn Vale/0 33.60,67.00
|mapmarker Stranglethorn Vale/0 34.60,62.60
stickystart "Collect_Catelyns_Blade"
step
click Bloodsail Correspondence
turnin The Bloodsail Buccaneers##595 |goto Stranglethorn Vale 27.28,69.52
accept The Bloodsail Buccaneers##597 |goto Stranglethorn Vale 27.28,69.52
step
label "Collect_Catelyns_Blade"
kill "Pretty Boy" Duncan##2545
collect Catelyn's Blade##4027 |q 610/1 |goto Stranglethorn Vale 27.38,69.41
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
talk Catelyn the Blade##2542
|tip {o}Middle floor{} inside the building.
turnin "Pretty Boy" Duncan##610 |goto Stranglethorn Vale 27.28,77.53
accept The Curse of the Tides##611 |goto Stranglethorn Vale 27.28,77.53
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
turnin The Bloodsail Buccaneers##599 |goto Stranglethorn Vale 27.17,77.01
step
talk Privateer Bloads##2494
|tip Walks around.
accept Akiris by the Bundle##617 |goto Stranglethorn Vale 26.76,76.38
|mapmarker Stranglethorn Vale 27.43,76.78
step
Run through the tunnel to leave Booty Bay |goto Stranglethorn Vale 28.00,73.46 < 15 |only if walking and (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
kill Naga Explorer##1907+
collect 10 Akiris Reed##4029 |q 617/1 |goto Stranglethorn Vale 24.40,64.60
|mapmarker Stranglethorn Vale/0 24.00,62.40
|mapmarker Stranglethorn Vale/0 24.40,59.80
|mapmarker Stranglethorn Vale/0 26.00,62.40
|mapmarker Stranglethorn Vale/0 26.80,59.20
|mapmarker Stranglethorn Vale/0 27.80,61.40
|mapmarker Stranglethorn Vale/0 28.00,64.60
stickystart "Collect_Zanzils_Mixture"
step
kill Jon-Jon the Crow##2536
collect Jon-Jon's Golden Spyglass##3925 |q 609/2 |goto Stranglethorn Vale 34.93,51.85
step
kill Maury "Club Foot" Wilkins##2535
collect Maury's Clubbed Foot##3924 |q 609/1 |goto Stranglethorn Vale 35.25,51.26
step
Follow the path to the Ruins of Aboraz |goto Stranglethorn Vale 33.73,53.77 < 30 |only if walking and not (subzone("Ruins of Aboraz") or subzone("The Crystal Shore"))
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
step
kill 10 Jungle Stalker##687 |q 196/1 |goto Stranglethorn Vale 27.20,48.20
|tip Work your way {o}northeast{}.
|mapmarker Stranglethorn Vale/0 23.00,49.80
|mapmarker Stranglethorn Vale/0 26.00,51.20
|mapmarker Stranglethorn Vale/0 27.40,43.20
|mapmarker Stranglethorn Vale/0 30.40,41.80
|mapmarker Stranglethorn Vale/0 31.80,37.80
|mapmarker Stranglethorn Vale/0 33.40,40.40
step
kill Venture Co. Strip Miner##674, Venture Co. Tinkerer##677, Venture Co. Surveyor##676, Venture Co. Foreman##675
|tip Goblins.
collect 10 Singing Blue Crystal##3917 |q 600/1 |goto Stranglethorn Vale 41.40,44.60
|mapmarker Stranglethorn Vale/0 40.20,42.40
|mapmarker Stranglethorn Vale/0 40.40,43.80
|mapmarker Stranglethorn Vale/0 41.40,41.40
|mapmarker Stranglethorn Vale/0 42.00,46.00
step
kill Skullsplitter Warrior##667, Skullsplitter Axe Thrower##696, Skullsplitter Mystic##780, Skullsplitter Scout##782, Skullsplitter Beastmaster##784, Skullsplitter Witch Doctor##670, Skullsplitter Hunter##669, Skullsplitter Berserker##783, Skullsplitter Spiritchaser##672, Skullsplitter Headhunter##781
|tip Trolls.
collect 4 Skullsplitter Fetish##2466 |q 205/1 |goto Stranglethorn Vale 42.20,36.20
|tip Mystics and Witch Doctors.
collect 18 Skullsplitter Tusk##1524 |q 209/1 |goto Stranglethorn Vale 42.20,36.20
|mapmarker Stranglethorn Vale/0 42.40,33.40
|mapmarker Stranglethorn Vale/0 43.40,39.40
|mapmarker Stranglethorn Vale/0 45.00,32.60
|mapmarker Stranglethorn Vale/0 46.00,38.00
|mapmarker Stranglethorn Vale/0 46.40,30.20
|mapmarker Stranglethorn Vale/0 46.40,40.60
|mapmarker Stranglethorn Vale/0 47.00,34.60
step
kill Bhag'thera##728
|tip Unstealthed {o}level 40 elite{} black panther.
|tip Walks around.
|tip Multiple locations.
collect Fang of Bhag'thera##3876 |q 193/1 |goto Stranglethorn Vale 46.37,29.05
|mapmarker Stranglethorn Vale 49.60,24.03
|mapmarker Stranglethorn Vale 48.99,20.20
step
talk Brother Nimetz##739
turnin Troll Witchery##205 |goto Stranglethorn Vale 37.83,3.56
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##193 |goto Stranglethorn Vale 35.55,10.55
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##196 |goto Stranglethorn Vale 35.66,10.81
accept Raptor Mastery##197 |goto Stranglethorn Vale 35.66,10.81
step
kill Elder Saltwater Crocolisk##2635
|tip {o}Level 38 elite{} enemies.
|tip Shared spawns with Saltwater Crocolisks.
collect Elder Crocolisk Skin##4105 |q 628/1 |goto Stranglethorn Vale 29.20,22.40
|mapmarker Stranglethorn Vale/0 21.40,15.80
|mapmarker Stranglethorn Vale/0 22.40,19.00
|mapmarker Stranglethorn Vale/0 25.20,19.20
|mapmarker Stranglethorn Vale/0 29.40,25.20
step
click Altar of the Tides
|tip Stone table.
|tip Underwater.
kill Gazban##2624
|tip Pull him up to the water surface.
collect Stone of the Tides##4034 |q 611/1 |goto Stranglethorn Vale 24.96,23.58
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 600
|only if Druid
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
turnin Venture Company Mining##600 |goto Stranglethorn Vale 27.12,77.21
turnin Zanzil's Secret##621 |goto Stranglethorn Vale/0 27.12,77.21
step
talk Deeg##2488
|tip {o}Top floor{} inside the building.
accept Up to Snuff##587 |goto Stranglethorn Vale 26.92,77.35
step
talk Kebok##737
|tip {o}Top floor{} inside the building.
turnin Skullsplitter Tusks##209 |goto Stranglethorn Vale 27.00,77.13
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
accept The Bloodsail Buccaneers##604 |goto Stranglethorn Vale 27.17,77.01
step
talk Baron Revilgaz##2496
|tip Up on the balcony of the building.
turnin The Curse of the Tides##611 |goto Stranglethorn Vale 27.23,76.87
step
talk Privateer Bloads##2494
|tip Walks around.
turnin Akiris by the Bundle##617 |goto Stranglethorn Vale 26.76,76.38
accept Akiris by the Bundle##623 |goto Stranglethorn Vale 26.76,76.38
|mapmarker Stranglethorn Vale 27.43,76.78
step
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Voodoo Dues##609 |goto Stranglethorn Vale 27.78,77.07
step
talk Drizzlik##2495
|tip Upper level of the docks.
|tip Inside the building.
turnin Excelsior##628 |goto Stranglethorn Vale 28.29,77.59
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
step
label "Kill_Bloodsail_Swashbucklers"
kill 10 Bloodsail Swashbuckler##1563 |q 604/1 |goto Stranglethorn Vale 27.00,82.80
|mapmarker Stranglethorn Vale/0 29.40,80.40
|mapmarker Stranglethorn Vale/0 32.00,79.60
|mapmarker Stranglethorn Vale/0 33.00,77.00
step
Run through the tunnel to enter Booty Bay |goto Stranglethorn Vale 29.56,72.51 < 15 |only if walking and not (subzone("Booty Bay") or subzone("The Old Port Authority") or subzone("The Salty Sailor Tavern"))
talk Dizzy One-Eye##2493
|tip Upper level of the docks.
turnin Keep An Eye Out##576 |goto Stranglethorn Vale 28.59,75.90
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
turnin The Bloodsail Buccaneers##604 |goto Stranglethorn Vale 27.17,77.01
step
talk Deeg##2488
|tip {o}Top floor{} inside the building.
turnin Up to Snuff##587 |goto Stranglethorn Vale 26.92,77.35
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Swamp of Sorrows (43-43)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Tanaris (43-44)",
},[[
step
talk Watchmaster Sorigal##5464
turnin Vital Supplies##1477 |goto Duskwood 75.77,46.15
step
_NOTE:_
While Questing in Swamp of Sorrows
|tip Avoid {o}Stonard Scouts{}.
|tip Horde NPCs in Horde camps and patrolling the roads.
|tip They will {o}PVP flag you{}.
Click Here to Continue |confirm |q 1364
|only if hardcore()
step
talk Watcher Biggs##5476
accept Driftwood##1398 |goto Swamp of Sorrows 26.74,59.83
stickystart "Collect_Pristine_Crawler_Legs"
stickystart "Collect_Khadgars_Essays_On_Dimensional_Convergence_Only_Sticky"
step
click Sundried Driftwood##24798+
|tip Wooden logs.
|tip Avoid Stonard.		|only if not subzone("Misty Reed Strand")
collect 8 Sundried Driftwood##6146 |q 1398/1 |goto Swamp of Sorrows/0 87.30,78.10
|mapmarker Swamp of Sorrows/0 80.40,9.40
|mapmarker Swamp of Sorrows/0 82.30,92.10
|mapmarker Swamp of Sorrows/0 83.40,13.90
|mapmarker Swamp of Sorrows/0 83.50,89.00
|mapmarker Swamp of Sorrows/0 84.40,83.70
|mapmarker Swamp of Sorrows/0 84.70,87.60
|mapmarker Swamp of Sorrows/0 86.00,85.10
|mapmarker Swamp of Sorrows/0 86.20,81.30
|mapmarker Swamp of Sorrows/0 87.20,18.90
|mapmarker Swamp of Sorrows/0 89.70,22.40
|mapmarker Swamp of Sorrows/0 90.00,25.70
|mapmarker Swamp of Sorrows/0 90.50,72.50
|mapmarker Swamp of Sorrows/0 91.00,27.60
|mapmarker Swamp of Sorrows/0 91.70,68.70
|mapmarker Swamp of Sorrows/0 91.80,31.90
|mapmarker Swamp of Sorrows/0 93.20,36.40
|mapmarker Swamp of Sorrows/0 93.40,66.10
|mapmarker Swamp of Sorrows/0 93.70,63.90
|mapmarker Swamp of Sorrows/0 93.80,57.10
|mapmarker Swamp of Sorrows/0 94.30,41.40
|mapmarker Swamp of Sorrows/0 94.50,49.80
|mapmarker Swamp of Sorrows/0 94.70,44.40
|mapmarker Swamp of Sorrows/0 94.90,51.80
|mapmarker Swamp of Sorrows/0 94.90,59.50
step
label "Collect_Pristine_Crawler_Legs"
kill Silt Crawler##922, Monstrous Crawler##1088
|tip Crabs.
|tip {o}Silt Crawlers{} have higher drop rate.
|tip More in the water. |notinsticky
|tip Multiple locations. |notinsticky
collect 12 Pristine Crawler Leg##5938 |q 1258/1 |goto Swamp of Sorrows/0 87.00,77.40
|mapmarker Swamp of Sorrows/0 71.60,5.40
|mapmarker Swamp of Sorrows/0 74.00,3.40
|mapmarker Swamp of Sorrows/0 77.20,4.80
|mapmarker Swamp of Sorrows/0 78.20,95.20
|mapmarker Swamp of Sorrows/0 78.40,7.60
|mapmarker Swamp of Sorrows/0 80.60,4.60
|mapmarker Swamp of Sorrows/0 80.80,93.60
|mapmarker Swamp of Sorrows/0 81.40,10.40
|mapmarker Swamp of Sorrows/0 82.40,88.20
|mapmarker Swamp of Sorrows/0 83.00,13.20
|mapmarker Swamp of Sorrows/0 83.80,93.60
|mapmarker Swamp of Sorrows/0 84.40,80.20
|mapmarker Swamp of Sorrows/0 84.60,8.60
|mapmarker Swamp of Sorrows/0 84.60,90.60
|mapmarker Swamp of Sorrows/0 85.40,15.40
|mapmarker Swamp of Sorrows/0 85.40,85.20
|mapmarker Swamp of Sorrows/0 86.40,20.80
|mapmarker Swamp of Sorrows/0 87.60,81.60
|mapmarker Swamp of Sorrows/0 87.80,88.20
|mapmarker Swamp of Sorrows/0 88.00,18.20
|mapmarker Swamp of Sorrows/0 88.40,23.80
|mapmarker Swamp of Sorrows/0 88.60,85.00
|mapmarker Swamp of Sorrows/0 89.40,74.40
|mapmarker Swamp of Sorrows/0 90.20,27.00
|mapmarker Swamp of Sorrows/0 90.60,71.20
|mapmarker Swamp of Sorrows/0 91.00,19.80
|mapmarker Swamp of Sorrows/0 91.00,81.20
|mapmarker Swamp of Sorrows/0 91.40,77.60
|mapmarker Swamp of Sorrows/0 91.60,24.00
|mapmarker Swamp of Sorrows/0 92.60,74.20
step
label "Collect_Khadgars_Essays_On_Dimensional_Convergence_Only_Sticky"
kill Swampwalker##764, Swampwalker Elder##765, Tangled Horror##766, Mire Lord##1081
|tip Swamp elementals.
collect Khadgar's Essays on Dimensional Convergence##6065 |q 1364/1
|tip Low drop rate.
|only if not subzone("Misty Reed Strand")
|sticky only
step
label "Collect_Khadgars_Essays_On_Dimensional_Convergence_Only_Sticky"
kill Swampwalker##764, Swampwalker Elder##765, Tangled Horror##766, Mire Lord##1081
|tip Swamp elementals.
collect Khadgar's Essays on Dimensional Convergence##6065 |q 1364/1 |goto Swamp of Sorrows/0 13.40,37.40
|tip Low drop rate.
|mapmarker Swamp of Sorrows/0 5.40,31.40
|mapmarker Swamp of Sorrows/0 7.00,34.80
|mapmarker Swamp of Sorrows/0 8.40,30.40
|mapmarker Swamp of Sorrows/0 9.40,37.00
|mapmarker Swamp of Sorrows/0 10.20,27.40
|mapmarker Swamp of Sorrows/0 10.60,34.00
|mapmarker Swamp of Sorrows/0 11.40,39.80
|mapmarker Swamp of Sorrows/0 11.80,30.20
|mapmarker Swamp of Sorrows/0 13.60,33.40
|mapmarker Swamp of Sorrows/0 14.80,40.80
|mapmarker Swamp of Sorrows/0 16.60,32.60
|mapmarker Swamp of Sorrows/0 16.80,36.20
step
talk Watcher Biggs##5476
turnin Driftwood##1398 |goto Swamp of Sorrows 26.74,59.83
accept Deliver the Shipment##1425 |goto Swamp of Sorrows 26.74,59.83
step
talk Watcher Mahar Ba##5385
|tip Top of the tower.
turnin Mazen's Behest##1364 |goto Blasted Lands 67.65,19.16
step
talk Quartermaster Lungertz##5393
turnin Deliver the Shipment##1425 |goto Blasted Lands 66.52,21.38
step
talk Alexandra Constantine##8609
|tip Up on the platform.
fpath Nethergarde Keep |goto Blasted Lands 65.54,24.33
step
talk Watchmaster Sorigal##5464
|tip {o}HURRY{}, timed quest.
accept Supplies for Nethergarde##1395 |goto Duskwood 75.77,46.15
step
talk Quartermaster Lungertz##5393
|tip {o}HURRY{}, timed quest.
turnin Supplies for Nethergarde##1395 |goto Blasted Lands 66.52,21.38
step
talk Whiskey Slim##2491
|tip {o}Ground floor{} inside the building.
accept Whiskey Slim's Lost Grog##580 |goto Stranglethorn Vale 27.13,77.45
step
_NOTE:_
During Next Quest
|tip Next quest has {o}2 hour time limit{}.
|tip Counts down even offline.
|tip You'll turnin the quest soon.
|tip Don't logout before turning in.
Click Here to Continue |confirm |q 1119 |future
step
talk Crank Fizzlebub##2498
|tip {o}Ground floor{} inside the building.
accept Zanzil's Mixture and a Fool's Stout##1119 |goto Stranglethorn Vale 27.12,77.21
step
talk Krazek##773
|tip {o}Top floor{} inside the building.
accept Tran'rek##2864 |goto Stranglethorn Vale 26.94,77.21
step
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
accept Stoley's Debt##2872 |goto Stranglethorn Vale 27.78,77.07
step
talk Privateer Groy##2616
|tip Walks around.
turnin Akiris by the Bundle##623 |goto Dustwallow Marsh 68.84,53.22
|mapmarker Dustwallow Marsh 68.02,51.44
step
talk Morgan Stern##4794
|tip Inside the building.
turnin ... and Bugs##1258 |goto Dustwallow Marsh 66.34,45.47
step
talk Innkeeper Janene##6272
|tip Inside the building.
home Theramore Isle |goto Dustwallow Marsh 66.59,45.22 |q 1707 |future
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Tanaris (43-44)",{
image=ZGV.IMAGESDIR.."Tanaris",
hardcore = true,
next="Leveling Guides\\Feralas & Tanaris (44-48)",
},[[
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Seaforium Booster##5862 |goto Tanaris 52.30,28.91 |q 1188
step
talk Tran'rek##7876
turnin Tran'rek##2864 |goto Tanaris 51.57,26.76
step
talk Shreev##4708
turnin Safety First##1188 |goto Tanaris 50.96,27.24
accept Safety First##1189 |goto Tanaris/0 50.96,27.24
step
talk Kravel Koalbeard##4452
turnin Zanzil's Mixture and a Fool's Stout##1119 |goto Thousand Needles/0 77.79,77.27
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
talk Fizzle Brassbolts##4454
turnin News for Fizzle##1137 |goto Thousand Needles 78.06,77.13
step
talk Pozzik##4630
accept Keeping Pace##1190 |goto Thousand Needles 80.18,75.88
step
talk Razzeric##4706
turnin Safety First##1189 |goto Thousand Needles/0 80.33,76.10
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
talk Spigot Operator Luglunket##7408
accept Water Pouch Bounty##1707 |goto Tanaris 52.48,28.44
step
talk Chief Engineer Bilgewhizzle##7407
accept Wastewander Justice##1690 |goto Tanaris 52.46,28.51
stickystart "Collect_Wastewander_Water_Pouches"
stickystart "Kill_Wastewander_Bandits_And_Thieves"
step
talk Haughty Modiste##15165
accept Pirate Hats Ahoy!##8365 |goto Tanaris/0 66.56,22.27
stickystop "Collect_Wastewander_Water_Pouches"
stickystop "Kill_Wastewander_Bandits_And_Thieves"
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.99,22.36
step
talk Security Chief Bilgewhizzle##7882
|tip Inside the building.
accept Southsea Shakedown##8366 |goto Tanaris/0 67.06,23.89
step
talk Stoley##7881
|tip Inside the building.
turnin Stoley's Debt##2872 |goto Tanaris 67.11,23.98
accept Stoley's Shipment##2873 |goto Tanaris/0 67.11,23.98
stickystart "Kill_Wastewander_Bandits_And_Thieves"
step
label "Collect_Wastewander_Water_Pouches"
kill Wastewander Shadow Mage##5617, Wastewander Thief##5616, Wastewander Bandit##5618, Wastewander Rogue##5615, Wastewander Assassin##5623
|tip Humans.
collect 5 Wastewander Water Pouch##8483 |q 1707/1 |goto Tanaris 62.80,30.40
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
talk Chief Engineer Bilgewhizzle##7407
turnin Wastewander Justice##1690 |goto Tanaris 52.46,28.51
step
talk Spigot Operator Luglunket##7408
turnin Water Pouch Bounty##1707 |goto Tanaris 52.48,28.44
step
kill Wastewander Shadow Mage##5617, Wastewander Thief##5616, Wastewander Bandit##5618, Wastewander Rogue##5615, Wastewander Assassin##5623
|tip Humans.
|tip Run dungeons, if you prefer.
collect Wastewander Water Pouch##8483+ |n
|tip Turn in {o}stacks of 5{} in Gadgetzan for {o}380 xp{}.
expcollect Wastewander Water Pouch##8483,5,380,44
|tip Count will reduce as you grind.
ding 44 |goto Tanaris 62.80,30.40
Turn in Water Pouches at [52.49,28.45]
Ammo available at [67.01,21.99] |only if Hunter
|mapmarker Tanaris/0 59.80,24.00
|mapmarker Tanaris/0 63.20,32.40
|mapmarker Tanaris/0 63.20,34.60
|mapmarker Tanaris/0 64.00,28.40
|mapmarker Tanaris/0 65.20,32.80
step
kill Fire Roc##5429, Roc##5428
|tip Red birds.
|tip Shared spawns with hyenas.
collect 3 Roc Gizzard##6257 |q 1452/1 |goto Tanaris 49.91,35.16
|mapmarker Tanaris/0 40.60,39.20
|mapmarker Tanaris/0 41.40,42.20
|mapmarker Tanaris/0 43.80,39.80
|mapmarker Tanaris/0 45.00,42.80
|mapmarker Tanaris/0 46.80,39.20
|mapmarker Tanaris/0 47.00,48.20
|mapmarker Tanaris/0 47.60,44.80
|mapmarker Tanaris/0 48.40,36.40
|mapmarker Tanaris/0 49.20,41.40
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Fool's Stout Report##5807 |goto Tanaris 52.30,28.91 |q 1122
bank Roc Gizzard##6257 |goto Tanaris 52.30,28.91 |q 1452
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Feralas & Tanaris (44-48)",{
image=ZGV.IMAGESDIR.."Feralas",
hardcore = true,
next="Leveling Guides\\The Hinterlands (48-49)",
},[[
step
_NOTE:_
Multiple Long Grind Sessions
|tip There is a LOT of grinding in this guide.
|tip Higher level zones soon.
|tip Not enough quests to get you high enough level.
|tip Run dungeons until {o}level 48{} to skip grinding.
Click Here to Continue |confirm |q 4124 |future
step
_NOTE:_
Optional Dungeon Later
|tip Can run {o}Zul'Farrak{} dungeon later.
|tip Slower leveling, but potential gear upgrades.
|tip We'll pick up dungeon quests.
|tip Guide will say when it's time to run the dungeon.
Click Here to Run {y}Zul'Farrak{} Dungeon Later |confirm ZFflag |multiq 3527,2768,2865,3042 |future
|tip Skip if you'd rather grind.
step
talk Curgle Cranklehop##7763
accept Handle With Care##3022 |goto Tanaris 52.35,26.91
step
talk Pratt McGrubben##7852
accept The Mark of Quality##2821 |goto Feralas 30.63,42.71
step
talk Innkeeper Shyria##7736
|tip Inside the building.
home Feathermoon Stronghold |goto Feralas 30.97,43.49 |q 82 |future
step
talk Latronicus Moonspear##7877
|tip Inside the building.
accept The Missing Courier##4124 |goto Feralas 30.38,46.17
step
talk Shandris Feathermoon##3936
|tip Inside the building.
accept The Ruins of Solarsal##2866 |goto Feralas 30.28,46.17
step
talk Troyas Moonbreeze##7764
|tip Inside the building.
accept In Search of Knowledge##2939 |goto Feralas 31.78,45.50
step
talk Angelas Moonbreeze##7900
|tip Inside the building.
accept The High Wilderness##2982 |goto Feralas 31.83,45.61
step
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin The Missing Courier##4124 |goto Feralas 31.86,45.13
accept The Missing Courier##4125 |goto Feralas 31.86,45.13
step
click Solarsal Gazebo##142179
|tip Stand inside it.
turnin The Ruins of Solarsal##2866 |goto Feralas 26.32,52.34
accept Return to Feathermoon Stronghold##2867 |goto Feralas 26.32,52.34
step
talk Shandris Feathermoon##3936
|tip Inside the building.
turnin Return to Feathermoon Stronghold##2867 |goto Feralas 30.28,46.17
accept Against the Hatecrest##3130 |goto Feralas 30.28,46.17
step
talk Latronicus Moonspear##7877
|tip Inside the building.
turnin Against the Hatecrest##3130 |goto Feralas 30.38,46.17
accept Against the Hatecrest##2869 |goto Feralas 30.38,46.17
step
_NOTE:_
Begin Finding a Dungeon Group
|tip Good time to run {o}Zul'Farrak{} dungeon soon.
|tip Start looking for a group.
Click Here to Continue |confirm |multiq 3527,2768,2865,3042 |future
|only if guideflag("ZFflag")
step
kill Hatecrest Screamer##5335, Hatecrest Wave Rider##5332, Hatecrest Warrior##5331, Hatecrest Siren##5337, Hatecrest Myrmidon##5334, Hatecrest Sorceress##5336, Hatecrest Serpent Guard##5333
|tip Nagas.
collect 10 Hatecrest Naga Scale##9247 |q 2869/1 |goto Feralas/0 29.00,53.60
|mapmarker Feralas/0 25.40,49.40
|mapmarker Feralas/0 25.40,53.40
|mapmarker Feralas/0 26.40,56.80
|mapmarker Feralas/0 28.40,50.40
|mapmarker Feralas/0 29.60,57.00
|mapmarker Feralas/0 32.20,55.40
step
talk Latronicus Moonspear##7877
|tip Inside the building.
turnin Against the Hatecrest##2869 |goto Feralas 30.38,46.17
accept Against Lord Shalzaru##2870 |goto Feralas 30.38,46.17
step
talk Faralorn##7942
|tip Long grind soon.
|tip Inside the building.
Buy Extra Ammo |vendor Faralorn##7942 |goto Feralas 30.65,43.43 |q 2870
|only if Hunter
step
_NOTE:_
Dangerous Cave
|tip Cave in next step can be dangerous.
|tip Skip quest, if you prefer.
Click Here to Continue |confirm |q 2870
|only if hardcore()
step
Enter the cave |goto Feralas/0 26.09,67.26 < 20 |walk |only if not subzone("Shalzaru's Lair")
kill Lord Shalzaru##8136
|tip May need help.
|tip Inside the cave.
collect Mysterious Relic##9248 |q 2870/1 |goto Feralas/0 28.49,70.45
step
Leave the cave |goto Feralas/0 26.09,67.26 < 20 |walk |only if subzone("Shalzaru's Lair")
kill Hatecrest Myrmidon##5334, Hatecrest Sorceress##5336, Hatecrest Serpent Guard##5333
collect OOX-22/FE Distress Beacon##8705 |n
|tip Low drop rate.
use OOX-22/FE Distress Beacon##8705
accept Find OOX-22/FE!##2766 |goto Feralas/0 25.20,62.80
|mapmarker Feralas/0 23.40,64.20
|mapmarker Feralas/0 24.60,66.80
|mapmarker Feralas/0 26.60,65.00
|mapmarker Feralas/0 27.40,62.40
step
Kill enemies
|tip Higher level zones soon.
|tip Not enough quests to get high enough level.
ding 46 |goto Feralas/0 25.20,62.80
|mapmarker Feralas/0 23.40,64.20
|mapmarker Feralas/0 24.60,66.80
|mapmarker Feralas/0 26.60,65.00
|mapmarker Feralas/0 27.40,62.40
Ammo available at [Feralas/0 30.65,43.43]				|only if Hunter
|only if not guideflag("ZFflag")
step
Leave the cave |goto Feralas 26.09,67.26 < 20 |walk |only if subzone("Shalzaru's Lair")
Swim to this location to avoid fatigue |goto Feralas/0 38.94,74.91 < 30 |only if walking and zone("Feralas") and not subzone("The Forgotten Coast") |notravel
Swim to this location to avoid fatigue |goto Feralas/0 41.29,74.30 < 30 |only if walking and zone("Feralas") and not subzone("The Forgotten Coast") |notravel
click Wrecked Row Boat##164909
|tip Underwater.
turnin The Missing Courier##4125 |goto Feralas 45.45,64.97
accept Boat Wreckage##4127 |goto Feralas 45.45,64.97
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 4127
|only if Druid
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 4127
|only if Mage
step
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin Boat Wreckage##4127 |goto Feralas 31.86,45.13
accept The Knife Revealed##4129 |goto Feralas 31.86,45.13
step
talk Quintis Jonespyre##7879
|tip Top of the tower.
turnin The Knife Revealed##4129 |goto Feralas 32.45,43.79
step
Watch the dialogue
|tip Top of the tower.
talk Quintis Jonespyre##7879
accept Psychometric Reading##4130 |goto Feralas 32.45,43.79
step
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin Psychometric Reading##4130 |goto Feralas 31.86,45.13
accept The Woodpaw Gnolls##4131 |goto Feralas 31.86,45.13
step
talk Latronicus Moonspear##7877
|tip Inside the building.
turnin Against Lord Shalzaru##2870 |goto Feralas 30.38,46.17
accept Delivering the Relic##2871 |goto Feralas 30.38,46.17
step
talk Vestia Moonspear##7878
|tip Inside the building.
turnin Delivering the Relic##2871 |goto Feralas 30.08,45.06
step
kill Vale Screecher##5307, Rogue Vale Screecher##5308
|tip Red flying snakes.
use Yeh'kinya's Bramble##10699
|tip On their corpses.
talk Screecher Spirit##8612+
Collect #3# Screecher Spirits |q 3520/1 |goto Feralas/0 43.20,37.00
|mapmarker Feralas/0 46.20,39.80
|mapmarker Feralas/0 46.00,37.40
|mapmarker Feralas/0 46.40,47.80
|mapmarker Feralas/0 50.20,47.80
|mapmarker Feralas/0 52.60,49.80
|mapmarker Feralas/0 54.20,47.40
|mapmarker Feralas/0 56.20,50.00
|mapmarker Feralas/0 56.80,47.80
|mapmarker Feralas/0 58.40,52.00
|mapmarker Feralas/0 60.40,50.80
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.99,22.36
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
Click Here to Continue |confirm |multiq 3527,2768,2865,3042 |future
|only if guideflag("ZFflag")
step
Enter the Zul'Farrak Dungeon |complete zone("Zul'Farrak") |multiq 3527,2768,2865,3042 |future
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
Leave the Zul'Farrak Dungeon |complete not zone("Zul'Farrak") |multiq 3527,2768,2865,3042 |future
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
Kill enemies
|tip Higher level zones soon.
|tip Not enough quests to get high enough level.
|tip Keep running the {o}Zul'Farrak{} dungeon.
ding 48
|only if guideflag("ZFflag")
stickystart "Collect_Thick_Yeti_Hides"
stickystart "Collect_Groddoc_Livers"
stickystart "Collect_Ironfur_Livers"
step
Follow the road and run through the tunnel |goto Feralas 55.22,56.39 < 20 |only if walking and not (subzone("Feral Scar Vale") and indoors())
talk Homing Robot OOX-22/FE##7807
|tip In the clearing between the tunnel and cave.
turnin Find OOX-22/FE!##2766 |goto Feralas 53.35,55.70
step
label "Collect_Thick_Yeti_Hides"
kill Feral Scar Yeti##5292, Enraged Feral Scar##5295, Hulking Feral Scar##5293
|tip Yetis.
|tip More through the tunnel.
collect 10 Thick Yeti Hide##8973 |q 2821/1 |goto Feralas 55.40,57.40
|mapmarker Feralas/0 52.40,57.40
|mapmarker Feralas/0 53.40,55.40
|mapmarker Feralas/0 55.20,54.40
|mapmarker Feralas/0 50.40,58.40
|mapmarker Feralas/0 51.80,60.60
step
Leave the cave and run  through the tunnel |goto Feralas 55.22,56.39 < 20 |only if walking and subzone("Feral Scar Vale") and indoors()
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
stickystop "Collect_Groddoc_Livers"
stickystop "Collect_Ironfur_Livers"
stickystart "Kill_Gordunni_Warlocks"
stickystart "Collect_Groddoc_Livers"
stickystart "Collect_Ironfur_Livers"
step
kill 8 Gordunni Shaman##5236 |q 2982/2 |goto Feralas 60.40,68.00
|mapmarker Feralas/0 57.80,70.20
|mapmarker Feralas/0 58.40,67.40
|mapmarker Feralas/0 59.40,65.40
|mapmarker Feralas/0 59.80,63.20
|mapmarker Feralas/0 60.20,70.40
|mapmarker Feralas/0 62.80,68.40
step
kill 8 Gordunni Brute##5232 |q 2982/3 |goto Feralas/0 60.40,58.80
|mapmarker Feralas/0 61.80,54.60
|mapmarker Feralas/0 59.65,56.44
step
label "Kill_Gordunni_Warlocks"
kill 8 Gordunni Warlock##5240 |q 2982/1 |goto Feralas/0 60.40,57.00
|mapmarker Feralas/0 59.40,64.60
|mapmarker Feralas/0 58.20,66.40
|mapmarker Feralas/0 60.40,71.00
|mapmarker Feralas/0 61.80,54.40
step
label "Collect_Groddoc_Livers"
kill Groddoc Ape##5260+
|tip Gorillas.
|tip Shared spawns with bears. |notinsticky
collect 3 Groddoc Liver##6259 |q 1452/3 |goto Feralas/0 59.00,61.80
|mapmarker Feralas/0 55.40,52.80
|mapmarker Feralas/0 56.00,55.60
|mapmarker Feralas/0 56.20,60.40
|mapmarker Feralas/0 57.40,53.40
|mapmarker Feralas/0 57.40,57.80
|mapmarker Feralas/0 58.60,56.00
|mapmarker Feralas/0 58.60,59.60
|mapmarker Feralas/0 61.00,60.40
step
label "Collect_Ironfur_Livers"
kill Grizzled Ironfur Bear##5272, Ironfur Bear##5268
|tip Bears.
|tip Shared spawns with apes. |notinsticky
collect 3 Ironfur Liver##6258 |q 1452/2 |goto Feralas/0 59.00,61.80
|mapmarker Feralas/0 50.20,47.40
|mapmarker Feralas/0 51.40,49.60
|mapmarker Feralas/0 52.40,46.00
|mapmarker Feralas/0 54.00,48.40
|mapmarker Feralas/0 55.00,50.20
|mapmarker Feralas/0 55.40,52.80
|mapmarker Feralas/0 56.00,47.00
|mapmarker Feralas/0 56.00,55.60
|mapmarker Feralas/0 56.20,60.40
|mapmarker Feralas/0 57.20,49.60
|mapmarker Feralas/0 57.40,53.40
|mapmarker Feralas/0 57.40,57.80
|mapmarker Feralas/0 58.60,56.00
|mapmarker Feralas/0 58.60,59.60
|mapmarker Feralas/0 59.20,50.80
|mapmarker Feralas/0 61.00,60.40
|mapmarker Feralas/0 61.40,51.60
step
Kill enemies
|tip Clear enemies around the large cage.
|tip Makes next step easier.
Click Here to Continue |confirm |goto Feralas 66.69,46.57 |q 2969 |future
step
Follow the path up |goto Feralas 65.66,46.77 < 10 |only if walking
talk Kindal Moonweaver##7956
accept Freedom for All Creatures##2969 |goto Feralas 65.94,45.65
step
click Cage Door
|tip Releases the Captured Sprite Darters.
|tip Protect as many as you can.
|tip At least {o}6 of them must survive{}.
|tip {o}HURRY{}, timed quest.
Save at Least 6 Sprite Darters from Capture |q 2969/1 |goto Feralas 66.67,46.75
step
Follow the path up |goto Feralas 65.66,46.77 < 10 |only if walking
talk Kindal Moonweaver##7956
|tip {o}HURRY{}, timed quest.
|tip Wait for her to respawn, if missing.
turnin Freedom for All Creatures##2969 |goto Feralas 65.94,45.65
step
talk Jer'kai Moonweaver##7957
accept Doling Justice##2970 |goto Feralas 65.95,45.61
step
kill 6 Grimtotem Shaman##7727 |q 2970/3 |goto Feralas 67.40,46.40
kill 10 Grimtotem Raider##7725 |q 2970/2 |goto Feralas 67.40,46.40
kill 12 Grimtotem Naturalist##7726 |q 2970/1 |goto Feralas 67.40,46.40
|mapmarker Feralas/0 65.40,47.40
|mapmarker Feralas/0 66.60,38.40
|mapmarker Feralas/0 68.80,39.40
step
Follow the path up |goto Feralas 65.66,46.77 < 10 |only if walking
talk Jer'kai Moonweaver##7957
turnin Doling Justice##2970 |goto Feralas 65.95,45.61
accept Doling Justice##2972 |goto Feralas 65.95,45.61
step
click Large Leather Backpacks##164953
turnin The Woodpaw Gnolls##4131 |goto Feralas 73.31,56.31
accept The Writhing Deep##4135 |goto Feralas 73.31,56.31
step
use Undelivered Parcel##11463
accept Thalanaar Delivery##4281
step
_NOTE:_
Dangerous Cave
|tip Cave in next steps can be dangerous.
|tip Skip quests, if you prefer.
|tip You'll have to skip multiple quests if you do.
|tip More grinding later.
Click Here to Continue |confirm |multiq 3764,4496
|only if hardcore()
step
Enter the cave at the bottom of the path |goto Feralas 73.17,63.88 < 15 |walk
Follow the path down |goto Feralas 72.69,64.56 < 10 |walk
click Zukk'ash Pod##164954
|tip Inside the cave.
turnin The Writhing Deep##4135 |goto Feralas 72.08,63.75
accept Freed from the Hive##4265 |goto Feralas 72.08,63.75
step
Watch the dialogue
|tip Inside the cave.
Free Raschal |q 4265/1 |goto Feralas 72.08,63.81
step
talk Pratt McGrubben##7852
turnin The Mark of Quality##2821 |goto Feralas 30.63,42.71
step
talk Angelas Moonbreeze##7900
|tip Inside the building.
turnin The High Wilderness##2982 |goto Feralas 31.83,45.61
accept The Sunken Temple##3445 |goto Feralas 31.83,45.61
step
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin Freed from the Hive##4265 |goto Feralas 31.86,45.13
accept A Hero's Welcome##4266 |goto Feralas 31.86,45.13
step
talk Shandris Feathermoon##3936
|tip Inside the building.
turnin A Hero's Welcome##4266 |goto Feralas 30.28,46.17
accept Rise of the Silithid##4267 |goto Feralas 30.28,46.17
step
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Handle With Care##3022 |goto Teldrassil 55.50,92.05
accept Favored of Elune?##3661 |goto Teldrassil 55.50,92.05
step
talk Daryn Lightwind##7907
|tip Upstairs inside the building.
turnin In Search of Knowledge##2939 |goto Teldrassil 55.41,92.23
step
click Feralas: A History
|tip Upstairs inside the building.
accept Feralas: A History##2940 |goto Teldrassil 55.22,91.46
step
talk Daryn Lightwind##7907
|tip Upstairs inside the building.
turnin Feralas: A History##2940 |goto Teldrassil 55.41,92.23
accept The Borrower##2941 |goto Teldrassil 55.41,92.23
step
talk Garryeth##4209
|tip Deposit into the bank.
bank A Short Note##9329		|goto Darnassus 39.60,41.98 |q 2941
bank Yeh'kinya's Bramble##10699 |goto Darnassus 39.60,41.98 |q 3520
bank Hippogryph Egg##8564	|goto Darnassus 39.60,41.98 |q 2741 |future
bank Ironfur Liver##6258	|goto Darnassus 39.60,41.98 |q 1452
bank Groddoc Liver##6259	|goto Darnassus 39.60,41.98 |q 1452
step
talk Auctioneer Golothas##8723
|tip Buy from the Auction House, if possible.
|tip Saves time in Un'Goro Crater.
|tip Inside the building.
collect 7 Red Power Crystal##11186	|goto Darnassus/0 56.24,54.05 |q 4284 |future
collect 7 Yellow Power Crystal##11188	|goto Darnassus/0 56.24,54.05 |q 4284 |future
collect 7 Green Power Crystal##11185	|goto Darnassus/0 56.24,54.05 |q 4284 |future
collect 7 Blue Power Crystal##11184	|goto Darnassus/0 56.24,54.05 |q 4284 |future
step
talk Garryeth##4209
|tip Deposit into the bank.
bank Red Power Crystal##11186		|goto Darnassus 39.60,41.98 |q 4284 |future
bank Yellow Power Crystal##11188	|goto Darnassus 39.60,41.98 |q 4284 |future
bank Green Power Crystal##11185		|goto Darnassus 39.60,41.98 |q 4284 |future
bank Blue Power Crystal##11184		|goto Darnassus 39.60,41.98 |q 4284 |future
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 4267
|only if Rogue
step
talk Jocaste##4146
|tip Upstairs inside the building.
Train Abilities |trainer Jocaste##4146 |goto Darnassus/0 40.38,8.54 |q 4267
|only if Hunter
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 4267
|only if Warrior
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 4267
|only if Priest
step
talk Gracina Spiritmight##7740
|tip Upstairs inside the building.
turnin Rise of the Silithid##4267 |goto Darnassus 41.85,85.62
step
talk Tyrande Whisperwind##7999
|tip Upstairs inside the building.
turnin Doling Justice##2972 |goto Darnassus 39.10,81.59
step
talk Jartsam##4753
Train Tiger Riding |learnspell Tiger Riding##828 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 4281
|only if Paladin
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 4281
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 4281
|only if Warlock
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
step
talk Faralorn##7942
|tip Long grind soon.
|tip Inside the building.
Buy Extra Ammo |vendor Faralorn##7942 |goto Feralas 30.65,43.43 |q 4281
|only if Hunter
step
Kill enemies
|tip Higher level zones soon.
|tip Not enough quests to get high enough level.
ding 48,67550 |goto Feralas/0 25.20,62.80
|mapmarker Feralas/0 23.40,64.20
|mapmarker Feralas/0 24.60,66.80
|mapmarker Feralas/0 26.60,65.00
|mapmarker Feralas/0 27.40,62.40
Ammo available at [Feralas/0 30.65,43.43]				|only if Hunter
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 4281
|only if Druid
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 4281
|only if Mage
step
talk Falfindel Waywarder##4048
turnin Thalanaar Delivery##4281 |goto Feralas 89.64,46.57
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect A Short Note##9329	|goto Tanaris/0 52.30,28.91 |q 2941
collect Hippogryph Egg##8564	|goto Tanaris/0 52.30,28.91 |q 2741 |future
step
click Egg-O-Matic
accept The Super Egg-O-Matic##2741 |goto Tanaris 52.37,26.97 |instant
step
talk Curgle Cranklehop##7763
turnin The Borrower##2941 |goto Tanaris/0 52.36,26.90
accept The Super Snapper FX##2944 |goto Tanaris/0 52.36,26.90
step
use Egg Crate##8647
collect A Bad Egg##8646			|or
collect An Ordinary Egg##8645		|or
collect A Fine Egg##8644		|or
collect An Extraordinary Egg##8643	|or
|only if itemcount(8647) > 0
step
talk Curgle Cranklehop##7763
accept A Bad Egg##2750			|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8646) > 0
accept An Ordinary Egg##2749		|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8645) > 0
accept A Fine Egg##2748			|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8644) > 0
accept An Extraordinary Egg##2747	|goto Tanaris/0 52.36,26.91	|instant	|only if itemcount(8643) > 0
step
talk Senior Surveyor Fizzledowser##7724
accept Gadgetzan Water Survey##992 |goto Tanaris 50.21,27.48
step
use Untapped Dowsing Widget##8584
|tip Avoid {o}elite enemies{}.
|tip You will be attacked.
collect Tapped Dowsing Widget##8585 |q 992/1 |goto Tanaris 39.09,29.17
step
talk Senior Surveyor Fizzledowser##7724
turnin Gadgetzan Water Survey##992 |goto Tanaris 50.21,27.48
accept Noxious Lair Investigation##82 |goto Tanaris 50.21,27.48
step
kill Centipaar Wasp##5455, Centipaar Stinger##5456, Centipaar Swarmer##5457, Centipaar Worker##5458, Centipaar Sandreaver##5460, Centipaar Tunneler##5459
|tip Insects.
|tip  {o}Swarmers{} spawn minions. |only if hardcore()
|tip  {o}Stingers{} and {o}Wasps{} cast poison DoTs. |only if hardcore()
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
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Noxious Lair Investigation##82 |goto Tanaris 50.89,26.96
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect 3 Roc Gizzard##6257	|goto Tanaris/0 52.30,28.91 |q 1452
collect 3 Ironfur Liver##6258	|goto Tanaris/0 52.30,28.91 |q 1452
collect 3 Groddoc Liver##6259	|goto Tanaris/0 52.30,28.91 |q 1452
step
talk Innkeeper Fizzgrimble##7733
|tip Inside the building.
home Gadgetzan |goto Tanaris/0 52.50,27.91 |q 608 |future
step
talk Jartsam##4753
Train Tiger Riding |learnspell Tiger Riding##828 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 1452
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 1452
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
Train Pet Abilities |trainer Belia Thundergranite##10090 |goto Ironforge/0 70.86,85.84 |q 1452
|only if Hunter
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 1452
|only if Rogue
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 1452
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 1452
|only if Warlock
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 1452
|only if Priest
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.55,4.48 |q 1452
|only if Paladin
step
talk Bryllia Ironbrand##5101
|tip Downstairs inside the building.
Buy Extra Ammo |vendor Bryllia Ironbrand##5101 |goto Ironforge/0 39.23,74.47 |q 1452
|tip Long questing session soon.
|tip No ammo vendor.
|only if Hunter
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\The Hinterlands (48-49)",{
image=ZGV.IMAGESDIR.."The Hinterlands",
hardcore = true,
next="Leveling Guides\\Tanaris (49-49)",
},[[
step
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
|tip Top of the path.
accept Witherbark Cages##2988 |goto The Hinterlands/0 9.76,44.48
stickystart "Collect_Wildkin_Feathers"
step
Follow the path up |goto The Hinterlands 20.81,47.82 < 30 |only if walking and not subzone("Shindigger's Camp")
talk Rhapsody Shindigger##5634
turnin Rhapsody's Kalimdor Kocktail##1452 |goto The Hinterlands/0 26.94,48.59
step
Watch the dialogue
talk Rhapsody Shindigger##5634
accept Rhapsody's Tale##1469 |goto The Hinterlands/0 26.94,48.59
stickystop "Collect_Wildkin_Feathers"
stickystart "Collect_Troll_Tribal_Necklaces"
stickystart "Collect_Wildkin_Feathers"
step
click Third Witherbark Cage
Check the Third Cage |q 2988/3 |goto The Hinterlands 31.99,57.38
step
click First Witherbark Cage
Check the First Cage |q 2988/1 |goto The Hinterlands 23.28,58.75
step
click Second Witherbark Cage
Check the Second Cage |q 2988/2 |goto The Hinterlands 23.13,58.76
step
label "Collect_Troll_Tribal_Necklaces"
kill Witherbark Hideskinner##2651, Witherbark Scalper##2649, Witherbark Venomblood##2652, Witherbark Zealot##2650
|tip Trolls.
collect 5 Troll Tribal Necklace##9259 |goto The Hinterlands 25.20,57.80 |q 2880 |future
|tip Don't vendor them.
|mapmarker The Hinterlands/0 21.40,55.20
|mapmarker The Hinterlands/0 21.40,57.40
|mapmarker The Hinterlands/0 23.20,58.40
|mapmarker The Hinterlands/0 23.40,56.40
|mapmarker The Hinterlands/0 32.60,57.00
|mapmarker The Hinterlands/0 25.20,60.00
|mapmarker The Hinterlands/0 27.40,57.00
|mapmarker The Hinterlands/0 29.40,57.60
|mapmarker The Hinterlands/0 29.40,60.20
|mapmarker The Hinterlands/0 31.20,58.60
|mapmarker The Hinterlands/0 31.40,55.40
|mapmarker The Hinterlands/0 31.60,60.60
step
talk Fraggar Thundermantle##7884
|tip Inside the building.
accept Troll Necklace Bounty##2880 |goto The Hinterlands 14.83,44.56
step
talk Fraggar Thundermantle##7884
|tip Inside the building.
turnin Troll Necklace Bounty##2880 |goto The Hinterlands 14.83,44.56
accept Skulk Rock Clean-up##2877 |goto The Hinterlands 14.83,44.56
stickystop "Collect_Wildkin_Feathers"
step
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
|tip Top of the path.
turnin Witherbark Cages##2988 |goto The Hinterlands 9.76,44.48
accept The Altar of Zul##2989 |goto The Hinterlands 9.76,44.48
step
label "Collect_Wildkin_Feathers"
click Wildkin Feather##153239+
|tip Large brown and white feathers.
|tip Reduce the {o}Ground Clutter{} setting to {o}1{}.
|tip In {o}System > Graphics{} game settings.
|tip Makes them easier to see.
collect 15 Wildkin Feather##10819 |q 3661/1 |goto The Hinterlands/0 22.90,54.90
|mapmarker The Hinterlands/0 15.50,49.10
|mapmarker The Hinterlands/0 15.70,52.40
|mapmarker The Hinterlands/0 15.80,54.70
|mapmarker The Hinterlands/0 18.30,49.70
|mapmarker The Hinterlands/0 19.50,47.20
|mapmarker The Hinterlands/0 20.60,57.40
|mapmarker The Hinterlands/0 21.30,53.30
|mapmarker The Hinterlands/0 22.20,51.00
|mapmarker The Hinterlands/0 40.60,51.00
|mapmarker The Hinterlands/0 23.70,49.60
|mapmarker The Hinterlands/0 24.70,54.00
|mapmarker The Hinterlands/0 24.70,58.60
|mapmarker The Hinterlands/0 25.20,62.00
|mapmarker The Hinterlands/0 25.80,56.90
|mapmarker The Hinterlands/0 26.40,64.70
|mapmarker The Hinterlands/0 27.70,54.20
|mapmarker The Hinterlands/0 28.10,58.10
|mapmarker The Hinterlands/0 28.20,68.40
|mapmarker The Hinterlands/0 28.40,60.40
|mapmarker The Hinterlands/0 28.40,64.40
|mapmarker The Hinterlands/0 29.60,62.00
|mapmarker The Hinterlands/0 31.00,54.40
|mapmarker The Hinterlands/0 31.70,63.90
|mapmarker The Hinterlands/0 33.00,60.40
|mapmarker The Hinterlands/0 33.20,47.50
|mapmarker The Hinterlands/0 33.30,43.00
|mapmarker The Hinterlands/0 33.40,51.70
|mapmarker The Hinterlands/0 33.60,54.40
|mapmarker The Hinterlands/0 34.10,58.00
|mapmarker The Hinterlands/0 35.40,43.00
|mapmarker The Hinterlands/0 36.20,52.70
|mapmarker The Hinterlands/0 37.30,50.40
|mapmarker The Hinterlands/0 37.40,46.00
|mapmarker The Hinterlands/0 38.20,54.00
|mapmarker The Hinterlands/0 38.40,44.20
|mapmarker The Hinterlands/0 42.10,44.00
|mapmarker The Hinterlands/0 42.40,54.40
|mapmarker The Hinterlands/0 42.50,58.40
|mapmarker The Hinterlands/0 44.20,44.40
|mapmarker The Hinterlands/0 45.80,59.90
|mapmarker The Hinterlands/0 46.80,50.00
|mapmarker The Hinterlands/0 47.10,44.30
|mapmarker The Hinterlands/0 48.60,63.40
|mapmarker The Hinterlands/0 48.70,41.30
|mapmarker The Hinterlands/0 50.40,59.40
|mapmarker The Hinterlands/0 51.20,62.70
|mapmarker The Hinterlands/0 51.40,39.40
|mapmarker The Hinterlands/0 52.00,58.00
|mapmarker The Hinterlands/0 55.60,42.30
step
_NOTE:_
During Next Step
|tip {o}Elite enemies{} at top of temple.
|tip Run in to complete the goal, then {o}run away{}.
|tip Jump down on the {o}lower ledges of the temple{}.
|tip Enemies can't hit you there.
|tip {o}Wait on the ledge{} until out of combat.
|tip Make sure you have a potion to use.
|tip Skip quest if you're not comfortable. |only if hardcore()
Click Here to Continue |confirm |q 2989
step
Search the Altar of Zul |q 2989/1 |goto The Hinterlands 48.85,68.45
|tip Top of the temple.
|tip Careful, {o}elite enemies{}.
|tip {o}Jump down on a ledge{} after.
|tip Skip quest if you're not comfortable. |only if hardcore()
step
_NOTE:_
Jump On This Ledge
|tip Enemies can't hit you here.
|tip Wait until out of combat.
Click Here to Continue |confirm |goto The Hinterlands/0 49.12,66.54 |q 2989
step
kill 10 Green Sludge##2655 |q 2877/1 |goto The Hinterlands 48.60,42.60
kill 10 Jade Ooze##2656 |q 2877/2 |goto The Hinterlands 48.60,42.60
|tip Shared spawns.
|mapmarker The Hinterlands/0 43.40,43.80
|mapmarker The Hinterlands/0 44.80,42.00
|mapmarker The Hinterlands/0 45.40,44.20
|mapmarker The Hinterlands/0 45.80,39.40
|mapmarker The Hinterlands/0 47.00,41.40
|mapmarker The Hinterlands/0 55.40,44.40
|mapmarker The Hinterlands/0 56.20,39.00
|mapmarker The Hinterlands/0 56.40,42.40
|mapmarker The Hinterlands/0 58.00,44.00
|mapmarker The Hinterlands/0 58.20,41.00
|mapmarker The Hinterlands/0 60.00,42.60
step
Kill enemies
collect OOX-09/HL Distress Beacon##8704 |n
use OOX-09/HL Distress Beacon##8704
accept Find OOX-09/HL!##485 |goto The Hinterlands/0 57.40,50.40
|tip Skip if not found by {o}level 49{}.
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
talk Homing Robot OOX-09/HL##7806
turnin Find OOX-09/HL!##485 |goto The Hinterlands 49.35,37.66
|only if haveq(485) or completedq(485)
step
Kill enemies
ding 49 |goto The Hinterlands/0 57.40,50.40
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
stickystart "Collect_Pupellyverbos_Ports"
step
Follow the road and follow the path down |goto The Hinterlands 71.50,65.09 < 30 |only if walking and not subzone("The Overlook Cliffs")
use the Super Snapper FX##9328
|tip On Gammerita.
|tip {o}Elite{} blue turtle.
|tip Walks around.
|tip Use item {o}at max distance{}.
|tip {o}Run away{} when attacked.
collect Snapshot of Gammerita##9330 |q 2944/1 |goto The Hinterlands/0 81.40,47.20
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
label "Collect_Pupellyverbos_Ports"
click Pupellyverbos Port+
|tip Small blue bottles.
|tip Avoid Revantusk Village.
|tip Avoid Gammerita. |notinsticky
|tip {o}Elite{} blue turtle. |notinsticky
|tip Walks around. |notinsticky
|tip Reduce the {o}Ground Clutter{} setting to {o}1{}.
|tip In {o}System > Graphics{} game settings.
|tip Makes them easier to see.
collect 12 Pupellyverbos Port##3900 |q 580/1 |goto The Hinterlands 77.80,65.40
|mapmarker The Hinterlands/0 75.40,70.20
|mapmarker The Hinterlands/0 75.70,64.40
|mapmarker The Hinterlands/0 76.20,73.10
|mapmarker The Hinterlands/0 77.40,70.30
|mapmarker The Hinterlands/0 77.70,62.40
|mapmarker The Hinterlands/0 78.00,58.30
|mapmarker The Hinterlands/0 79.30,60.50
|mapmarker The Hinterlands/0 80.00,57.30
|mapmarker The Hinterlands/0 81.00,55.30
|mapmarker The Hinterlands/0 81.40,50.40
step
Kill enemies
|tip Avoid Gammerita.
|tip {o}Elite{} blue turtle.
|tip Walks around.
Grind Until Hearthstone Ready |complete C_Container.GetItemCooldown(6948) == 0 |goto The Hinterlands/0 78.20,68.20 |q 580
|tip Need to hearth back to Gadgetzan.
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
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Atal'ai Tablet Fragment##6287	|goto Tanaris/0 52.30,28.91 |q 1469
bank Super Snapper FX##9328		|goto Tanaris/0 52.30,28.91 |q 2944
bank Snapshot of Gammerita##9330	|goto Tanaris/0 52.30,28.91 |q 2944
bank Pupellyverbos Port##3900		|goto Tanaris/0 52.30,28.91 |q 580
bank Wildkin Feather##10819		|goto Tanaris/0 52.30,28.91 |q 3661
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Tanaris (49-49)",{
image=ZGV.IMAGESDIR.."Tanaris",
hardcore = true,
next="Leveling Guides\\Un'Goro Crater (49-50)",
},[[
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Yeh'kinya's Bramble##10699 |goto Tanaris/0 52.30,28.91 |q 3520
step
talk Chief Engineer Bilgewhizzle##7407
accept More Wastewander Justice##1691 |goto Tanaris 52.46,28.51
step
click Wanted Poster
accept WANTED: Caliph Scorpidsting##2781 |goto Tanaris 51.84,27.02
accept WANTED: Andre Firebeard##2875 |goto Tanaris 51.84,27.02
step
talk Senior Surveyor Fizzledowser##7724
accept The Scrimshank Redemption##10 |goto Tanaris 50.21,27.48
step
talk Marvon Rivetseeker##7771
turnin The Sunken Temple##3445 |goto Tanaris 52.71,45.93
accept Gahz'ridian##3161 |goto Tanaris 52.71,45.93
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
step
talk Jabbey##8139
|tip Inside the building.
Buy Extra Ammo |vendor Jabbey##8139 |goto Tanaris/0 67.01,21.99 |q 2876 |future
|only if Hunter
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
|only if level < 50
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
|only if level < 50
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
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.99,22.36
step
talk Homing Robot OOX-17/TN##7784
|tip Escort quest.
|tip Wait until it respawns, if missing.
turnin Find OOX-17/TN!##351 |goto Tanaris 60.23,64.72
|only if haveq(351) or completedq(351)
step
Enter the cave |goto Tanaris 55.78,68.91 < 15 |walk |only if not (subzone("The Gaping Chasm") and indoors())
Follow the path down |goto Tanaris 57.61,70.67 < 10 |walk
click Scrimshank's Surveying Gear
|tip Inside the cave.
collect Scrimshank's Surveying Gear##8593 |q 10/1 |goto Tanaris 55.97,71.18
step
talk Chief Engineer Bilgewhizzle##7407
turnin WANTED: Caliph Scorpidsting##2781 |goto Tanaris 52.46,28.51
turnin More Wastewander Justice##1691 |goto Tanaris 52.46,28.51
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect 7 Red Power Crystal##11186	|goto Tanaris/0 52.30,28.91 |q 4284 |future
collect 7 Yellow Power Crystal##11188	|goto Tanaris/0 52.30,28.91 |q 4284 |future
collect 7 Green Power Crystal##11185	|goto Tanaris/0 52.30,28.91 |q 4284 |future
collect 7 Blue Power Crystal##11184	|goto Tanaris/0 52.30,28.91 |q 4284 |future
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Stoley's Bottle##9245 |goto Tanaris/0 52.30,28.91 |q 2874
step
talk Marin Noggenfogger##7564
accept The Thirsty Goblin##2605 |goto Tanaris 51.81,28.66
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
talk Tran'rek##7876
accept Thistleshrub Valley##3362 |goto Tanaris 51.57,26.76
step
talk Andi Lynn##11758
accept The Dunemaul Compound##5863 |goto Tanaris 52.82,27.40
step
talk Senior Surveyor Fizzledowser##7724
turnin Insect Part Analysis##113 |goto Tanaris 50.21,27.48
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
collect 30 Gahz'ridian Ornament##8443 |q 3161/1 |goto Tanaris/0 40.30,68.90
|mapmarker Tanaris/0 38.90,73.00
|mapmarker Tanaris/0 39.10,70.70
|mapmarker Tanaris/0 45.60,64.60
|mapmarker Tanaris/0 41.10,71.10
|mapmarker Tanaris/0 41.50,73.70
|mapmarker Tanaris/0 48.20,64.70
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
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Un'Goro Crater (49-50)",{
image=ZGV.IMAGESDIR.."Un'Goro Crater",
hardcore = true,
next="Leveling Guides\\Stranglethorn Vale (50-50)",
},[[
step
_NOTE:_
Optional Dungeon Later
|tip Can run {o}Maraudon{} dungeon later.
|tip Slower leveling, but potential gear upgrades.
|tip We'll pick up dungeon quests.
|tip Guide will say when it's time to run the dungeon.
Click Here to Run {y}Maraudon{} Dungeon Later |confirm Maraflag |multiq 7041,7065,7028,7067,7044,7046,7066 |future
|tip Skip if you'd rather grind.
step
talk Torwa Pathfinder##9619
accept The Apes of Un'Goro##4289 |goto Un'Goro Crater 71.64,75.96
accept The Fare of Lar'korwi##4290 |goto Un'Goro Crater 71.64,75.96
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
talk Torwa Pathfinder##9619
turnin The Scent of Lar'korwi##4291 |goto Un'Goro Crater 71.63,75.97
accept The Bait for Lar'korwi##4292 |goto Un'Goro Crater 71.63,75.97
step
label "Collect_A_Mangled_Journal"
Kill enemies
|tip Any in Un'Goro Crater.
collect A Mangled Journal##11116 |n
use A Mangled Journal##11116
accept Williden's Journal##3884 |goto Un'Goro Crater 67.20,73.00
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
_NOTE:_
Begin Finding a Dungeon Group
|tip Good time to run {o}Maraudon{} dungeon soon.
|tip Start looking for a group.
Click Here to Continue |confirm |multiq 7041,7065,7028,7067,7044,7046,7066 |future
|only if guideflag("Maraflag")
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
talk Muigin##9119
accept Muigin and Larion##4141 |goto Un'Goro Crater/0 42.94,9.64
stickystart "Collect_UnGoro_Soil"
step
kill Bloodpetal Flayer##6510, Bloodpetal Thresher##6511, Bloodpetal Lasher##6509
|tip Walking plants.
collect 15 Bloodpetal##11316 |q 4141/1 |goto Un'Goro Crater 69.20,35.20
|mapmarker Un'Goro Crater/0 63.00,32.60
|mapmarker Un'Goro Crater/0 64.00,29.40
|mapmarker Un'Goro Crater/0 64.40,37.20
|mapmarker Un'Goro Crater/0 66.40,26.00
|mapmarker Un'Goro Crater/0 66.40,33.20
|mapmarker Un'Goro Crater/0 66.40,39.60
|mapmarker Un'Goro Crater/0 67.40,29.60
|mapmarker Un'Goro Crater/0 68.40,20.40
|mapmarker Un'Goro Crater/0 69.40,24.40
|mapmarker Un'Goro Crater/0 69.40,39.00
|mapmarker Un'Goro Crater/0 70.20,31.40
|mapmarker Un'Goro Crater/0 70.40,27.40
|mapmarker Un'Goro Crater/0 71.40,21.40
|mapmarker Un'Goro Crater/0 72.00,36.40
|mapmarker Un'Goro Crater/0 72.20,41.60
|mapmarker Un'Goro Crater/0 73.40,32.40
|mapmarker Un'Goro Crater/0 74.40,43.80
|mapmarker Un'Goro Crater/0 74.60,38.20
|mapmarker Un'Goro Crater/0 75.40,47.60
step
Kill enemies
|tip Helps reach level 50 after quest turnins.
ding 49,117440 |goto Un'Goro Crater 69.20,35.20
|mapmarker Un'Goro Crater/0 63.00,32.60
|mapmarker Un'Goro Crater/0 64.00,29.40
|mapmarker Un'Goro Crater/0 64.40,37.20
|mapmarker Un'Goro Crater/0 66.40,26.00
|mapmarker Un'Goro Crater/0 66.40,33.20
|mapmarker Un'Goro Crater/0 66.40,39.60
|mapmarker Un'Goro Crater/0 67.40,29.60
|mapmarker Un'Goro Crater/0 68.40,20.40
|mapmarker Un'Goro Crater/0 69.40,24.40
|mapmarker Un'Goro Crater/0 69.40,39.00
|mapmarker Un'Goro Crater/0 70.20,31.40
|mapmarker Un'Goro Crater/0 70.40,27.40
|mapmarker Un'Goro Crater/0 71.40,21.40
|mapmarker Un'Goro Crater/0 72.00,36.40
|mapmarker Un'Goro Crater/0 72.20,41.60
|mapmarker Un'Goro Crater/0 73.40,32.40
|mapmarker Un'Goro Crater/0 74.40,43.80
|mapmarker Un'Goro Crater/0 74.60,38.20
|mapmarker Un'Goro Crater/0 75.40,47.60
step
talk Muigin##9119
turnin Muigin and Larion##4141 |goto Un'Goro Crater/0 42.94,9.64
accept A Visit to Gregan##4142 |goto Un'Goro Crater/0 42.94,9.64
stickystop "Collect_UnGoro_Soil"
step
talk Gryfe##10583
fpath Marshal's Refuge |goto Un'Goro Crater 45.23,5.84
step
label "Collect_UnGoro_Soil"
click Un'Goro Dirt Pile+
Kill enemies
collect 20 Un'Goro Soil##11018 |multiq 3764,4496 |future
|tip Don't vendor them.
|sticky only
step
talk Marin Noggenfogger##7564
turnin The Thirsty Goblin##2605 |goto Tanaris 51.81,28.66
accept In Good Taste##2606 |goto Tanaris 51.81,28.66
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Stoley's Bottle##9245		|goto Tanaris/0 52.30,28.92 |q 2874
collect Fool's Stout Report##5807	|goto Tanaris 52.30,28.91 |q 1122
collect 12 Pupellyverbos Port##3900	|goto Tanaris/0 52.30,28.91 |q 580
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank A Carefully-packed Crate##9507	|goto Tanaris 52.30,28.91 |q 3022
bank Torwa's Pouch##11568		|goto Tanaris 52.30,28.91 |q 4292
bank Un'Goro Soil##11018		|goto Tanaris 52.30,28.91 |multiq 3764,4496 |future
bank Bloodpetal##11316			|goto Tanaris 52.30,28.91 |q 4142
bank Linken's Training Sword##11133	|goto Tanaris 52.30,28.91 |q 3908
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
talk Senior Surveyor Fizzledowser##7724
accept Rise of the Silithid##162 |goto Tanaris 50.21,27.48
step
talk Marvon Rivetseeker##7771
turnin Gahz'ridian##3161 |goto Tanaris 52.71,45.93
accept The Stone Circle##3444 |goto Tanaris 52.71,45.93
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 2874
|only if Druid
step
talk Gimblethorn##7799
|tip Deposit into the bank.
|tip Inside the building.
bank Insect Analysis Report##8594 |goto Tanaris 52.30,28.91 |q 162
step
talk Keeper Marandis##13698
|tip On the balcony of the building.
accept Corruption of Earth and Seed##7065 |goto Desolace 63.83,10.67
|only if guideflag("Maraflag")
step
talk Talendria##11715
accept Vyletongue Corruption##7041 |goto Desolace 68.50,8.88
|only if guideflag("Maraflag")
step
talk Willow##13656
|tip Inside the building.
accept Twisted Evils##7028 |goto Desolace 62.20,39.63
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
Click Here to Continue |confirm |multiq 7041,7065,7028,7067,7044,7046,7066 |future
|only if guideflag("Maraflag")
step
Enter the Stone Door of the Maraudon Tunnels |complete subzone("Maraudon") |multiq 7041,7065,7028,7067,7044,7046,7066 |future
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
collect Filled Cerulean Vial##17696 |q 7041/2
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
Enter the Maraudon Dungeon |complete zone("Maraudon") |multiq 7041,7065,7028,7067,7044,7046,7066 |future
|tip Follow your group.
|only if guideflag("Maraflag")
stickystart "Collect_Gem_Of_The_Fifth_Khan"
stickystart "Heal_Vylestem_Vines"
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
label "Heal_Vylestem_Vines"
_Inside the Maraudon Dungeon:_ |notinsticky
use Filled Cerulean Vial##17696
|tip Next to Vylestem Vines.
|tip Tree stumps with large leaves.
|tip {o}Foulspore Cavern{} area.
|tip {o}Orange{} section.
kill Noxxious Scion##13696+
Heal 8 Vylestem Vines |q 7041/1
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
kill Princess Theradras##12201 |q 7065/1
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
Leave the Maraudon Dungeon |complete not zone("Maraudon") |multiq 7041,7065,7028,7067,7044,7046,7066 |future
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
talk Talendria##11715
turnin Vyletongue Corruption##7041 |goto Desolace 68.50,8.88
|only if guideflag("Maraflag")
step
talk Keeper Marandis##13698
|tip On the balcony of the building.
turnin Corruption of Earth and Seed##7065 |goto Desolace 63.83,10.67
|only if guideflag("Maraflag")
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 2874
|only if Mage
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 2874
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 2874
|only if Hunter
step
talk Belia Thundergranite##10090
|tip Inside the building.
Train Pet Abilities |trainer Belia Thundergranite##10090 |goto Ironforge/0 70.86,85.84 |q 2874
|only if Hunter
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 2874
|only if Rogue
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 2874
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 2874
|only if Warlock
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.54,4.50 |q 2874
|only if Paladin
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 2874
|only if Priest
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Stranglethorn Vale (50-50)",{
image=ZGV.IMAGESDIR.."Stranglethorn Vale",
hardcore = true,
next="Leveling Guides\\Searing Gorge (50-51)",
},[[
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
accept The Bloodsail Buccaneers##608 |goto Stranglethorn Vale 27.17,77.01
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
turnin Report Back to Fizzlebub##1122 |goto Stranglethorn Vale 27.12,77.21
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
kill Tethis##730
|tip {o}Level 43 elite{} blue raptor.
|tip Walks around.
|tip Multiple locations.
collect Talon of Tethis##3877 |q 197/1 |goto Stranglethorn Vale 28.80,45.80
|mapmarker Stranglethorn Vale/0 27.00,44.00
|mapmarker Stranglethorn Vale/0 28.20,42.40
|mapmarker Stranglethorn Vale/0 30.40,40.60
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
click A Soggy Scroll
|tip Under the bridge.
|tip Underwater.
turnin Cortello's Riddle##624 |goto Swamp of Sorrows 22.86,48.19
accept Cortello's Riddle##625 |goto Swamp of Sorrows 22.86,48.19
step
talk Fleet Master Seahorn##2487
|tip Up on the balcony of the building.
turnin The Bloodsail Buccaneers##608 |goto Stranglethorn Vale 27.17,77.01
step
talk Innkeeper Skindle##6807
|tip {o}Ground floor{} inside the building.
home Booty Bay |goto Stranglethorn Vale 27.04,77.31 |q 625 |future
step
click Musty Scroll
|tip Inside the small cave.
turnin Cortello's Riddle##625 |goto Dustwallow Marsh 31.10,66.15
accept Cortello's Riddle##626 |goto Dustwallow Marsh 31.10,66.15
step
talk Viznik Goldgrubber##2625
|tip Collect from the bank.
collect Atal'ai Tablet Fragment##6287 |goto Stranglethorn Vale 26.54,76.57 |q 1469
collect 15 Silk Cloth##4306 |goto Stranglethorn Vale 26.54,76.57 |q 4449 |future
step
talk Innkeeper Allison##6740
|tip Inside the building.
home Stormwind City |goto Stormwind City/0 60.36,75.27 |q 3448 |future
step
talk Brohann Caskbelly##5384
|tip Inside the building.
turnin Rhapsody's Tale##1469 |goto Stormwind City 69.42,40.40
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Stormwind City 69.10,30.75 |q 7723 |future
|tip Walk into the portal.
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the tram to Ironforge.
Enter Ironforge |complete zone("Ironforge") |q 7723 |future
|tip Walk into the portal.
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Searing Gorge (50-51)",{
image=ZGV.IMAGESDIR.."Searing Gorge",
hardcore = true,
next="Leveling Guides\\Blasted Lands & Burning Steppes (51-51)",
},[[
step
talk Lanie Reed##2941
fpath Thorium Point |goto Searing Gorge 37.94,30.86
|only if hardcore()
step
talk Hansel Heavyhands##14627
accept Curse These Fat Fingers##7723 |goto Searing Gorge 38.57,27.80
accept Fiery Menace!##7724 |goto Searing Gorge 38.57,27.80
accept Incendosaurs? Whateverosaur is More Like It##7727 |goto Searing Gorge 38.57,27.80
step
click Wanted/Missing/Lost & Found
accept STOLEN: Smithing Tuyere and Lookout's Spyglass##7728 |goto Searing Gorge 37.63,26.53
accept JOB OPPORTUNITY: Culling the Competition##7729 |goto Searing Gorge 37.63,26.53
step
talk Velarok Windblade##8479
accept Divine Retribution##3441 |goto Searing Gorge 39.05,38.99
step
talk Velarok Windblade##8479
Select _"Tell me what drives this vengeance?"_ |gossip 95692
Select _"Continue please."_ |gossip 95530
Select _"Let me confer with my colleagues."_ |gossip 95529
Listen to Velarok's Story |q 3441/1 |goto Searing Gorge 39.05,38.99
step
talk Velarok Windblade##8479
turnin Divine Retribution##3441 |goto Searing Gorge 39.05,38.99
accept The Flawless Flame##3442 |goto Searing Gorge 39.05,38.99
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
accept Caught!##4449 |goto Searing Gorge/0 65.53,62.23
stickystop "Kill_Heavy_War_Golems"
step
kill 8 Dark Iron Geologist##5839 |q 4449/1 |goto Searing Gorge 63.40,61.40
|tip Skip once no more to kill.
|tip Can finish later.
|mapmarker Searing Gorge/0 62.40,58.20
step
map Searing Gorge
path follow strictbounce; loop off; ants straight; dist 30; markers none
path	69.89,76.37	70.62,74.78	70.52,73.19	68.80,71.78	73.37,73.97
path	73.26,76.28	72.73,78.31	72.96,80.31	73.48,82.34
kill Margol the Rager##5833
|tip {o}Level 48 elite{} blue dinosaur.
|tip Walks along the path.
|tip May need help.
collect Margol's Horn##10000 |q 3181 |future
step
use Margol's Horn##10000
accept The Horn of the Beast##3181
stickystart "Collect_Silk_Cloth"
step
kill 8 Dark Iron Geologist##5839 |q 4449/1 |goto Searing Gorge 63.40,61.40
|mapmarker Searing Gorge/0 62.40,58.20
step
label "Collect_Silk_Cloth"
kill Dark Iron Geologist##5839, Dark Iron Watchman##8637
collect 15 Silk Cloth##4306 |q 4449/2 |goto Searing Gorge 63.40,61.40
|mapmarker Searing Gorge/0 62.40,58.20
step
click Wooden Outhouse
turnin Caught!##4449 |goto Searing Gorge 65.54,62.24
step
talk Dorius Stonetender##8284
|tip Escort quest.
|tip Wait until he respawns, if missing.
accept Suntara Stones##3367 |goto Searing Gorge 63.92,60.98 |noautoaccept inparty
|tip Kill all enemies nearby first.
step
Watch the dialogue
|tip Follow and protect Dorius Stonetender.
Escort Dorius |q 3367/1 |goto Searing Gorge 74.42,19.41
step
click Singed Letter
turnin Suntara Stones##3367 |goto Searing Gorge 74.45,19.29
accept Suntara Stones##3368 |goto Searing Gorge 74.45,19.29
stickystart "Kill_Greater_Lava_Spiders"
stickystart "Kill_Heavy_War_Golems"
step
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
Kill enemies
ding 51 |goto Searing Gorge 32.60,42.60
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
Follow the path up to enter Thorium Point |goto Searing Gorge/0 31.52,33.54 < 20 |only if walking and not subzone("Thorium Point")
talk Hansel Heavyhands##14627
turnin Curse These Fat Fingers##7723 |goto Searing Gorge/0 38.59,27.81
turnin Fiery Menace!##7724 |goto Searing Gorge/0 38.59,27.81
turnin Incendosaurs? Whateverosaur is More Like It##7727 |goto Searing Gorge/0 38.59,27.81
step
talk Taskmaster Scrange##14626
turnin STOLEN: Smithing Tuyere and Lookout's Spyglass##7728 |goto Searing Gorge/0 38.98,27.51
turnin JOB OPPORTUNITY: Culling the Competition##7729 |goto Searing Gorge/0 38.98,27.51
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Mountaineer Pebblebitty##3836
turnin The Horn of the Beast##3181 |goto Loch Modan 18.19,84.00
accept Proof of Deed##3182 |goto Loch Modan/0 18.19,84.00
step
talk Jartsam##4753
Train Tiger Riding |learnspell Tiger Riding##828 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Auctioneer Jaxon##15659
|tip Buy from the Auction House, if possible.
|tip Inside the building.
collect 60 Wool Cloth##2592		|goto Stormwind City 61.14,70.67 |q 7791 |future
collect 60 Silk Cloth##4306		|goto Stormwind City 61.14,70.67 |q 7793 |future
collect 60 Mageweave Cloth##4338	|goto Stormwind City 61.14,70.67 |q 7794 |future
collect 60 Runecloth##14047		|goto Stormwind City 61.14,70.67 |q 7795 |future
step
talk Olivia Burnside##2455
|tip Deposit into the bank.
|tip Inside the building.
bank Black Dragonflight Molt##10575	|goto Stormwind City 64.18,80.48 |q 4022 |future
step
talk Clavicus Knavingham##14722
|tip Upstairs inside the building.
accept A Donation of Wool##7791 |goto Stormwind City/0 53.93,81.68 |instant
|only if itemcount(2592) >= 60
step
talk Clavicus Knavingham##14722
|tip Upstairs inside the building.
accept A Donation of Silk##7793 |goto Stormwind City/0 53.93,81.68 |instant
|only if itemcount(4306) >= 60
step
talk Clavicus Knavingham##14722
|tip Upstairs inside the building.
accept A Donation of Mageweave##7794 |goto Stormwind City/0 53.93,81.68 |instant
|only if itemcount(4338) >= 60
step
talk Clavicus Knavingham##14722
|tip Upstairs inside the building.
accept A Donation of Runecloth##7795 |goto Stormwind City/0 53.93,81.68 |instant
|only if itemcount(14047) >= 60 and (completedq(7791) and completedq(7793) and completedq(7794))
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Blasted Lands & Burning Steppes (51-51)",{
image=ZGV.IMAGESDIR.."Blasted Lands",
hardcore = true,
next="Leveling Guides\\Western Plaguelands (51-52)",
},[[
step
talk Ambassador Ardalan##7826
|tip Top of the tower.
accept Petty Squabbles##2783 |goto Blasted Lands 67.57,19.29
step
talk Fallen Hero of the Horde##7572
turnin Petty Squabbles##2783 |goto Swamp of Sorrows 34.29,66.13
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
step
Follow the path up into Morgan's Vigil |goto Burning Steppes 82.85,63.33 < 20 |only if walking and not subzone("Morgan's Vigil")
talk Borgus Stoutarm##2299
fpath Morgan's Vigil |goto Burning Steppes 84.33,68.33
step
talk Oralius##9177
accept Extinguish the Firegut##3823 |goto Burning Steppes 84.56,68.68
step
kill 7 Firegut Ogre##7033 |q 3823/2 |goto Burning Steppes 75.60,50.00
kill 7 Firegut Brute##7035 |q 3823/3 |goto Burning Steppes 75.60,50.00
kill 15 Firegut Ogre Mage##7034 |q 3823/1 |goto Burning Steppes 75.60,50.00
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
step
Follow the path up into Morgan's Vigil |goto Burning Steppes 82.85,63.33 < 20 |only if walking and not subzone("Morgan's Vigil")
talk Oralius##9177
turnin Extinguish the Firegut##3823 |goto Burning Steppes 84.56,68.68
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
stickystart "Accept_A_Call_To_Arms_The_Plaguelands"
step
talk Laris Geardawdle##9616
|tip Inside the building.
accept A Little Slime Goes a Long Way##4512 |goto Ironforge 75.77,23.37
step
talk Curator Thorius##8256
|tip Walks around.
|tip Inside the building.
turnin Proof of Deed##3182 |goto Ironforge 71.20,14.80
turnin Suntara Stones##3368 |goto Ironforge 71.20,14.80
accept At Last!##3201 |goto Ironforge 71.20,14.80
|mapmarker Ironforge/0 63.40,4.60
|mapmarker Ironforge/0 65.20,7.00
|mapmarker Ironforge/0 68.00,8.20
|mapmarker Ironforge/0 69.40,11.60
|mapmarker Ironforge/0 73.00,17.60
|mapmarker Ironforge/0 75.40,19.60
|mapmarker Ironforge/0 76.60,22.40
|mapmarker Ironforge/0 76.80,26.40
step
talk Historian Karnik##2916
accept Passing the Burden##3448 |goto Ironforge/0 77.55,11.84
step
talk Tymor##8507
|tip Inside the building.
turnin Passing the Burden##3448 |goto Ironforge/0 30.97,4.81
accept Arcane Runes##3449 |goto Ironforge/0 30.97,4.81 |only if not completedq(3451)
accept An Easy Pickup##3450 |goto Ironforge/0 30.97,4.81
step
talk Innkeeper Firebrew##5111
|tip Inside the building.
accept Assisting Arch Druid Staghelm##3790 |goto Ironforge 18.15,51.46
step
talk Innkeeper Firebrew##5111
|tip Inside the building.
home Ironforge |goto Ironforge 18.15,51.46 |q 162 |future
step
talk Auctioneer Redmuse##8720
|tip Buy from the Auction House, if possible.
|tip Inside the building.
collect Mithril Casing##10561 |goto Ironforge 24.16,74.67 |q 4244 |future
|tip Needed for quest in Un'Goro Crater.
step
talk Bailey Stonemantle##2461
|tip Collect from the bank.
|tip Inside the building.
collect Super Snapper FX##9328		|goto Ironforge 35.92,60.14 |q 2944
collect Snapshot of Gammerita##9330	|goto Ironforge 35.92,60.14 |q 2944
collect 15 Wildkin Feather##10819	|goto Ironforge 35.92,60.14 |q 3661
step
talk Bailey Stonemantle##2461
|tip Deposit into the bank.
|tip Inside the building.
bank Mithril Casing##10561		|goto Ironforge 35.92,60.14 |q 4244 |future
bank Drawing Kit##10445			|goto Ironforge 35.92,60.14 |q 3449
step
talk Auctioneer Redmuse##8720
|tip Buy from the Auction House, if possible.
|tip Needed for {o}8 quests{}.
|tip Each quest requires {o}60 cloth{}.
|tip Inside the building.
collect 120 Wool Cloth##2592		|goto Ironforge 24.16,74.67 |q 7791 |future
collect 120 Silk Cloth##4306		|goto Ironforge 24.16,74.67 |q 7793 |future
collect 120 Mageweave Cloth##4338	|goto Ironforge 24.16,74.67 |q 7794 |future
collect 120 Runecloth##14047		|goto Ironforge 24.16,74.67 |q 7795 |future
step
talk Mistina Steelshield##14723
accept A Donation of Wool##7802 |goto Ironforge/0 43.22,31.58 |instant
|only if itemcount(2592) >= 60
step
talk Mistina Steelshield##14723
accept A Donation of Silk##7803 |goto Ironforge/0 43.22,31.58 |instant
|only if itemcount(4306) >= 60
step
talk Mistina Steelshield##14723
accept A Donation of Mageweave##7804 |goto Ironforge/0 43.22,31.58 |instant
|only if itemcount(4338) >= 60
step
talk Mistina Steelshield##14723
accept A Donation of Runecloth##7805 |goto Ironforge/0 43.22,31.58 |instant
|only if itemcount(14047) >= 60 and (completedq(7802) and completedq(7803) and completedq(7804))
step
talk Bubulo Acerbus##14724
accept A Donation of Wool##7807 |goto Ironforge/0 74.09,48.22 |instant
|only if itemcount(2592) >= 60
step
talk Bubulo Acerbus##14724
accept A Donation of Silk##7808 |goto Ironforge/0 74.09,48.22 |instant
|only if itemcount(4306) >= 60
step
talk Bubulo Acerbus##14724
accept A Donation of Mageweave##7809 |goto Ironforge/0 74.09,48.22 |instant
|only if itemcount(4338) >= 60
step
talk Bubulo Acerbus##14724
accept A Donation of Runecloth##7811 |goto Ironforge/0 74.09,48.22 |instant
|only if itemcount(14047) >= 60 and (completedq(7807) and completedq(7808) and completedq(7809))
step
talk Xiggs Fuselighter##8517
|tip Inside the building.
turnin An Easy Pickup##3450 |goto Ironforge/0 70.87,94.57
accept Signal for Pickup##3451 |goto Ironforge/0 70.87,94.57
step
talk Xiggs Fuselighter##8517
|tip Inside the building.
turnin Signal for Pickup##3451 |goto Ironforge/0 70.87,94.57
step
label "Accept_A_Call_To_Arms_The_Plaguelands"
map Ironforge
path	follow smart;	loop on;	ants curved;	dist 30;	markers none;		arrow hide
path	57.32,78.92		50.14,81.06		39.59,79.17		34.35,74.44
path	24.69,55.32		24.38,38.36		27.70,25.23		32.24,22.90
path	34.74,33.94		40.38,37.68		48.22,31.09		55.91,35.09
path	57.34,48.56		48.22,57.86		46.33,47.76		39.94,44.41
path	38.43,38.33		34.49,32.86		33.42,21.18		39.45,12.40
path	44.31,10.79		53.02,10.57		58.98,13.76		70.47,33.88
path	71.16,44.77		70.12,55.01		67.38,65.14
talk Courier Hammerfall##10877
|tip Walks a large counter-clockwise path.
accept A Call to Arms: The Plaguelands!##5090
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Mountaineer Pebblebitty##3836
turnin At Last!##3201 |goto Loch Modan 18.19,84.00
step
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
|tip Top of the path.
turnin The Altar of Zul##2989 |goto The Hinterlands 9.76,44.48
|only if haveq(2989) or completedq(2989)
step
talk Fraggar Thundermantle##7884
|tip Inside the building.
turnin Skulk Rock Clean-up##2877 |goto The Hinterlands 14.83,44.56
step
click Violet Tragan+
|tip Brown mushrooms.
|tip Underwater.
collect Violet Tragan##8526 |q 2641/1 |goto The Hinterlands 41.01,59.77
step
click Cortello's Treasure
|tip Bottom of the waterfall.
|tip Underwater.
turnin Cortello's Riddle##626 |goto The Hinterlands 80.81,46.81
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Western Plaguelands (51-52)",{
image=ZGV.IMAGESDIR.."Western Plaguelands",
hardcore = true,
next="Leveling Guides\\Azshara & Felwood (52-52)",
},[[
step
talk Commander Ashlam Valorfist##10838
turnin A Call to Arms: The Plaguelands!##5066 |goto Western Plaguelands 42.70,84.03 |only if haveq(5066) or completedq(5066)
turnin A Call to Arms: The Plaguelands!##5090 |goto Western Plaguelands 42.70,84.03 |only if haveq(5090) or completedq(5090)
turnin A Call to Arms: The Plaguelands!##5091 |goto Western Plaguelands 42.70,84.03 |only if haveq(5091) or completedq(5091)
accept Clear the Way##5092 |goto Western Plaguelands 42.70,84.03
step
talk Argent Officer Pureheart##10840
accept Argent Dawn Commission##5401 |goto Western Plaguelands 42.97,83.55 |instant
step
equip Argent Dawn Commission##12846 |n
|tip Allows {o}Minion's Scourgestones{} to drop.
|tip From undead enemies in Western and Eastern Plaguelands.
Gain the Argent Dawn Commission Buff |havebuff Argent Dawn Commission##17670 |q 5408 |future
step
kill 10 Skeletal Flayer##1783 |q 5092/1 |goto Western Plaguelands 50.80,79.40
kill 10 Slavering Ghoul##1791 |q 5092/2 |goto Western Plaguelands 50.80,79.40
|mapmarker Western Plaguelands/0 49.40,76.20
|mapmarker Western Plaguelands/0 49.40,82.80
|mapmarker Western Plaguelands/0 46.40,80.40
|mapmarker Western Plaguelands/0 54.20,80.40
step
Kill enemies
|tip Helps reach level 52 after quest turnins.
ding 51,148800 |goto Western Plaguelands 50.80,79.40
|mapmarker Western Plaguelands/0 49.40,76.20
|mapmarker Western Plaguelands/0 49.40,82.80
|mapmarker Western Plaguelands/0 46.40,80.40
|mapmarker Western Plaguelands/0 54.20,80.40
step
talk Commander Ashlam Valorfist##10838
turnin Clear the Way##5092 |goto Western Plaguelands 42.70,84.03
accept The Scourge Cauldrons##5215 |goto Western Plaguelands 42.70,84.03
step
talk High Priestess MacDonnell##11053
turnin The Scourge Cauldrons##5215 |goto Western Plaguelands 42.97,84.50
accept Target: Felstone Field##5216 |goto Western Plaguelands/0 42.97,84.50
step
kill Cauldron Lord Bilemaw##11075
collect Felstone Field Cauldron Key##13194 |q 5216/1 |goto Western Plaguelands 37.03,57.11
step
click Scourge Cauldron
turnin Target: Felstone Field##5216 |goto Western Plaguelands 37.19,56.87
accept Return to Chillwind Camp##5217 |goto Western Plaguelands 37.19,56.87
step
talk Janice Felstone##10778
|tip Upstairs inside the building.
accept Better Late Than Never##5021 |goto Western Plaguelands 38.40,54.05
step
click Janice's Parcel
|tip Inside the building.
turnin Better Late Than Never##5021 |goto Western Plaguelands 38.73,55.24
accept Better Late Than Never##5022 |goto Western Plaguelands 38.73,55.24
step
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5217 |goto Western Plaguelands 42.97,84.50
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 3661
|only if Druid
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 3661
|only if Mage
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 3661
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 3661
|only if Hunter
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 3661
|only if Rogue
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 3661
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 3661
|only if Warlock
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.54,4.50 |q 3661
|only if Paladin
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 3661
|only if Priest
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Azshara & Felwood (52-52)",{
image=ZGV.IMAGESDIR.."Felwood",
hardcore = true,
next="Leveling Guides\\Feralas & Azshara (52-53)",
},[[
step
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Favored of Elune?##3661 |goto Teldrassil 55.50,92.05
accept Moontouched Wildkin##978 |goto Teldrassil 55.50,92.05
step
talk Daryn Lightwind##7907
|tip Upstairs inside the building.
turnin The Super Snapper FX##2944 |goto Teldrassil 55.41,92.23
accept Return to Troyas##2943 |goto Teldrassil 55.41,92.23
step
talk Garryeth##4209
|tip Collect from the bank.
|tip Inside the building.
collect Insect Analysis Report##8594	|goto Darnassus 39.60,41.98 |q 162
collect Linken's Training Sword##11133	|goto Darnassus 39.60,41.98 |q 3908
collect Bloodpetal##11316		|goto Darnassus 39.60,41.98 |q 4142
collect 20 Un'Goro Soil##11018		|goto Darnassus 39.60,41.98 |q 3764 |future
step
talk Garryeth##4209
|tip Deposit into the bank.
|tip Inside the building.
bank Janice's Parcel##12724		|goto Darnassus 39.60,41.98 |q 5022
bank Standard Issue Flare Gun##10444	|goto Darnassus 39.60,41.98 |q 3449
bank Violet Tragan##8526		|goto Darnassus 39.60,41.98 |q 2641
step
talk Arch Druid Fandral Staghelm##3516
|tip Walks around.
|tip {o}Top floor{} inside the building.
turnin Assisting Arch Druid Staghelm##3763 |goto Darnassus/0 34.82,9.25 |only if haveq(3763) or completedq(3763)
turnin Assisting Arch Druid Staghelm##3789 |goto Darnassus/0 34.82,9.25 |only if haveq(3789) or completedq(3789)
turnin Assisting Arch Druid Staghelm##3790 |goto Darnassus/0 34.82,9.25 |only if haveq(3790) or completedq(3790)
accept Un'Goro Soil##3764 |goto Darnassus/0 34.82,9.25
step
talk Jenal##9047
|tip Outside the building.
turnin Un'Goro Soil##3764 |goto Darnassus 31.49,8.23
step
talk Jartsam##4753
Train Tiger Riding |learnspell Tiger Riding##828 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Gracina Spiritmight##7740
|tip Upstairs inside the building.
turnin Rise of the Silithid##162 |goto Darnassus 41.84,85.62
accept March of the Silithid##4493 |goto Darnassus 41.84,85.62
step
talk Innkeeper Shaussiy##6737
|tip Inside the building.
home Auberdine |goto Darkshore 37.04,44.13 |q 5158 |future
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
talk Brinna Valanaar##14301
|tip Long questing session.
|tip No ammo vendor.
Buy Extra Ammo |vendor Brinna Valanaar##14301 |goto Azshara 12.00,78.38 |q 8460 |future
|only if Hunter
step
talk Arathandris Silversky##9528
|tip Walks around.
accept Cleansing Felwood##4101 |goto Felwood 54.15,86.83
step
talk Greta Mosshoof##10922
|tip Walks around.
accept Forces of Jaedenar##5155 |goto Felwood 51.21,82.11
step
talk Eridan Bluewind##9116
|tip Inside the building.
accept The Corruption of the Jadefire##4421 |goto Felwood 51.35,81.51
step
talk Grazle##11554
accept Timbermaw Ally##8460 |goto Felwood 50.93,85.01
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
use Package of Empty Ooze Containers##11912
collect 6 Empty Cursed Ooze Jar##11914 |q 4512
collect 6 Empty Tainted Ooze Jar##11948 |q 4512
step
kill Cursed Ooze##7086+
use Empty Cursed Ooze Jar##11914+
|tip On their corpses.
collect 6 Filled Cursed Ooze Jar##11947 |q 4512/1 |goto Felwood 41.60,71.60
|mapmarker Felwood/0 39.80,72.60
|mapmarker Felwood/0 40.80,66.00
|mapmarker Felwood/0 42.60,67.80
stickystart "Kill_Jadefire_Enemies"
step
Follow the path |goto Felwood 36.85,66.92 < 30 |only if walking
kill Xavathras##9454 |q 4421/4 |goto Felwood 32.24,67.10
step
label "Kill_Jadefire_Enemies"
kill 9 Jadefire Shadowstalker##7110 |q 4421/2 |goto Felwood 34.40,66.40
|tip Stealthed.
kill 9 Jadefire Rogue##7106 |q 4421/3 |goto Felwood 34.40,66.40
kill 11 Jadefire Felsworn##7109 |q 4421/1 |goto Felwood 34.40,66.40
|mapmarker Felwood/0 32.20,67.00
|mapmarker Felwood/0 36.40,66.80
|mapmarker Felwood/0 37.20,69.60
step
kill Tainted Ooze##7092+
use Empty Tainted Ooze Jar##11948+
|tip On their corpses.
collect 6 Filled Tainted Ooze Jar##11949 |q 4512/2 |goto Felwood 40.80,59.00
|mapmarker Felwood/0 38.60,49.40
|mapmarker Felwood/0 39.60,54.00
|mapmarker Felwood/0 40.00,56.40
|mapmarker Felwood/0 41.40,50.00
|mapmarker Felwood/0 41.60,45.00
|mapmarker Felwood/0 43.80,48.60
|mapmarker Felwood/0 44.00,46.40
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
talk Greta Mosshoof##10922
|tip Walks around.
turnin Forces of Jaedenar##5155 |goto Felwood 51.21,82.11
accept Collection of the Corrupt Water##5157 |goto Felwood 51.21,82.11
step
talk Eridan Bluewind##9116
|tip Inside the building.
turnin The Corruption of the Jadefire##4421 |goto Felwood 51.35,81.51
accept Further Corruption##4906 |goto Felwood 51.35,81.51
step
talk Taronn Redfeather##10921
|tip Inside the building.
accept Verifying the Corruption##5156 |goto Felwood 50.89,81.62
step
Follow the path into Jaedenar |goto Felwood 38.37,59.85 < 40 |walk
use Empty Canteen##12922
collect Corrupt Moonwell Water##12907 |q 5157/1 |goto Felwood 35.20,59.87
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
stickystart "Kill_Jadefire_Enemies_4906"
step
Follow the path up into Jadefire Run |goto Felwood 43.07,21.32 < 30 |only if walking and not subzone("Jadefire Run")
kill Xavaric##10648 |q 4906/4 |goto Felwood 39.07,22.35
|tip Walks around.
collect Flute of Xavaric##11668 |goto Felwood 39.07,22.35 |q 939 |future
step
use Flute of Xavaric##11668
accept Flute of Xavaric##939
step
kill Jadefire Hellcaller##7111, Jadefire Betrayer##7108, Jadefire Trickster##7107
collect 5 Jadefire Felbind##11674 |q 939/1 |goto Felwood 40.40,20.00
|mapmarker Felwood/0 42.20,18.60
|mapmarker Felwood/0 42.40,14.40
|mapmarker Felwood/0 44.40,13.40
|mapmarker Felwood/0 46.20,14.60
step
label "Kill_Jadefire_Enemies_4906"
kill 8 Jadefire Hellcaller##7111 |q 4906/1 |goto Felwood 40.40,20.00
kill 8 Jadefire Betrayer##7108 |q 4906/2 |goto Felwood 40.40,20.00
kill 8 Jadefire Trickster##7107 |q 4906/3 |goto Felwood 40.40,20.00
|mapmarker Felwood/0 42.20,18.60
|mapmarker Felwood/0 42.40,14.40
|mapmarker Felwood/0 44.40,13.40
|mapmarker Felwood/0 46.20,14.60
step
kill Warpwood Moss Flayer##7100, Warpwood Shredder##7101
|tip Swamp elementals.
|tip Inside and outside the cave.
collect 15 Blood Amber##11503 |q 4101/1 |goto Felwood 55.78,16.85
|mapmarker Felwood/0 54.40,16.20
|mapmarker Felwood/0 58.00,17.60
|mapmarker Felwood/0 57.00,21.00
|mapmarker Felwood/0 59.20,20.40
|mapmarker Felwood/0 54.91,19.04
step
Leave the cave |goto Felwood 55.88,17.15 < 40 |walk |only if subzone("Irontree Cavern")
talk Mishellena##12578
|tip Follow the road.
fpath Talonbranch Glade |goto Felwood 62.49,24.24
step
talk Nafien##15395
|tip Follow the road.
turnin Speak to Nafien##8462 |goto Felwood 64.77,8.13
step
talk Donova Snowden##9298
accept The Videre Elixir##3909 |goto Winterspring 31.27,45.16
turnin It's a Secret to Everybody##3908 |goto Winterspring 31.27,45.16
step
click Moontouched Feather+
|tip Large blue feathers.
|tip Make your way {o}east{}.
collect 10 Moontouched Feather##12383 |q 978/1 |goto Winterspring/0 29.40,46.70
|mapmarker Winterspring/0 30.20,45.20
|mapmarker Winterspring/0 30.30,44.00
|mapmarker Winterspring/0 30.90,47.00
|mapmarker Winterspring/0 31.30,45.50
|mapmarker Winterspring/0 31.50,43.30
|mapmarker Winterspring/0 32.00,44.20
|mapmarker Winterspring/0 32.80,44.30
|mapmarker Winterspring/0 34.80,45.90
|mapmarker Winterspring/0 34.90,43.20
|mapmarker Winterspring/0 35.60,43.80
|mapmarker Winterspring/0 36.40,45.70
|mapmarker Winterspring/0 37.20,45.70
|mapmarker Winterspring/0 37.40,44.20
|mapmarker Winterspring/0 37.50,42.80
|mapmarker Winterspring/0 37.80,45.70
|mapmarker Winterspring/0 38.30,43.80
|mapmarker Winterspring/0 38.60,45.10
|mapmarker Winterspring/0 39.50,39.00
|mapmarker Winterspring/0 40.40,37.50
|mapmarker Winterspring/0 40.50,37.50
|mapmarker Winterspring/0 43.10,42.00
|mapmarker Winterspring/0 43.10,44.10
|mapmarker Winterspring/0 43.60,42.60
|mapmarker Winterspring/0 43.70,44.90
|mapmarker Winterspring/0 44.30,42.20
|mapmarker Winterspring/0 44.90,44.70
|mapmarker Winterspring/0 45.20,44.20
|mapmarker Winterspring/0 45.60,44.00
|mapmarker Winterspring/0 45.70,42.60
|mapmarker Winterspring/0 45.90,41.60
|mapmarker Winterspring/0 46.60,44.20
|mapmarker Winterspring/0 47.90,45.10
|mapmarker Winterspring/0 49.50,40.80
|mapmarker Winterspring/0 50.50,38.00
step
talk Azzleby##11119
Stable Your Pet |stablemaster Azzleby##11119 |goto Winterspring/0 60.39,37.92 |q 4101
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 7){}.
|only if Hunter
step
talk Maethrya##11138
|tip Outside the walls.
fpath Everlook |goto Winterspring 62.33,36.61
step
Learn the {o}Claw (Rank 7){} Pet Ability |learnspell Claw##2977 |goto Felwood/0 47.40,15.40 |q 4101
|tip Cast {o}Tame Beast{} on an {o}Angerclaw Mauler{}.
|tip Diseased brown bears.
|tip Kill enemies nearby.
|mapmarker Felwood/0 39.20,30.80
|mapmarker Felwood/0 41.40,24.40
|mapmarker Felwood/0 44.80,23.80
|mapmarker Felwood/0 45.40,18.40
|only if Hunter
step
talk Taronn Redfeather##10921
|tip Inside the building.
turnin Verifying the Corruption##5156 |goto Felwood 50.89,81.62
step
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Flute of Xavaric##939 |goto Felwood 51.35,81.51
accept Felbound Ancients##4441 |goto Felwood 51.35,81.51
turnin Further Corruption##4906 |goto Felwood 51.35,81.51
step
talk Greta Mosshoof##10922
|tip Walks around.
turnin Collection of the Corrupt Water##5157 |goto Felwood 51.21,82.11
accept Seeking Spiritual Aid##5158 |goto Felwood 51.21,82.11
step
talk Arathandris Silversky##9528
|tip Walks around.
turnin Cleansing Felwood##4101 |goto Felwood 54.15,86.83
step
talk Arathandris Silversky##9528
|tip Walks around.
Select _"I need a Cenarion beacon."_ |gossip 96158
collect Cenarion Beacon##11511 |goto Felwood 54.15,86.83 |q 5882 |future
step
talk Jaelysia##10085
Retrieve Your Pet |stablemaster Azzleby##11119 |goto Darkshore/0 37.40,44.28 |q 7733 |future
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 7){} to Your Pet |learnpetspell Claw##3010 |q 7733 |future
|tip Use {o}Beast Training{} ability.
|only if Hunter
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Feralas & Azshara (52-53)",{
image=ZGV.IMAGESDIR.."Feralas",
hardcore = true,
next="Leveling Guides\\Un'Goro Crater (53-54)",
},[[
step
talk Pratt McGrubben##7852
accept Improved Quality##7733 |goto Feralas 30.63,42.71
step
talk Troyas Moonbreeze##7764
|tip Inside the building.
turnin Return to Troyas##2943 |goto Feralas 31.78,45.50
step
Watch the dialogue
talk Troyas Moonbreeze##7764
|tip Inside the building.
accept The Stave of Equinex##2879 |goto Feralas 31.78,45.50
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
Discover Dire Maul |goto Feralas 59.12,44.62 < 20 |c |q 5527 |future
|tip Run onto the huge ramp.
|tip Careful, {o}elite enemies{}.
|tip Run away after.
|tip Needed for quest later.
stickystart "Collect_Rage_Scar_Yeti_Hides"
step
kill Ferocious Rage Scar##5299, Rage Scar Yeti##5296, Elder Rage Scar##5297
|tip Yetis.
|tip Skin them. |only if skill('Skinning') > 0
|tip Inside and outside the cave.
collect Pristine Yeti Hide##18969 |n
use Pristine Yeti Hide##18969
accept Pristine Yeti Hide##7735 |goto Feralas/0 51.40,32.40
|mapmarker Feralas/0 52.20,29.60
|mapmarker Feralas/0 53.60,32.00
|mapmarker Feralas/0 54.60,33.80
|only if itemcount(18969) == 0 and not (readyq(7733) or completedq(7733))
step
label "Collect_Rage_Scar_Yeti_Hides"
kill Ferocious Rage Scar##5299, Rage Scar Yeti##5296, Elder Rage Scar##5297 |notinsticky
|tip Yetis. |notinsticky
|tip Inside and outside the cave. |notinsticky
collect 10 Rage Scar Yeti Hide##18947 |q 7733/1 |goto Feralas/0 51.40,32.40
|mapmarker Feralas/0 52.20,29.60
|mapmarker Feralas/0 53.60,32.00
|mapmarker Feralas/0 54.60,33.80
step
Leave the cave |goto Feralas/0 53.32,31.85 < 15 |walk |only if subzone("Rage Scar Hold") and indoors()
talk Rockbiter##7765
accept The Giant Guardian##2844 |goto Feralas 42.38,22.00
step
Jump onto this break in the wall from the nearby ledge |goto Feralas 44.62,9.81 < 3 |only if walking
click Evoroot##164798
|tip Inside the building.
collect Evoroot##11242 |goto Feralas 44.55,10.13 |q 3909
step
Jump up on the ledge |goto Feralas 40.33,11.04 < 7 |only if walking
Jump across here |goto Feralas 40.59,11.45 < 7 |only if walking
Jump up here |goto Feralas 40.97,11.87 < 7 |only if walking
click Flame of Samha
|tip Up on the ledge.
collect Samha Essence##9257 |goto Feralas 40.54,12.65 |q 2879
step
click Flame of Imbel##142187
collect Imbel Essence##9256 |goto Feralas 39.93,9.44 |q 2879
step
click Flame of Lahassa##142186
collect Lahassa Essence##9255 |goto Feralas 37.76,12.17 |q 2879
step
click Flame of Byltan##142185
collect Byltan Essence##9258 |goto Feralas 38.50,15.80 |q 2879
step
use Troyas' Stave##9263
collect Stave of Equinex##9306 |q 2879/1 |goto Feralas 38.87,13.23
step
click Equinex Monolith##144063
turnin The Stave of Equinex##2879 |goto Feralas 38.87,13.23
accept The Morrow Stone##2942 |goto Feralas 38.87,13.23
step
talk Shay Leafrunner##7774
turnin The Giant Guardian##2844 |goto Feralas 38.22,10.30
accept Wandering Shay##2845 |goto Feralas 38.22,10.30
step
click Shay's Chest##144054
collect Shay's Bell##9189 |q 2845/1 |goto Feralas 38.25,10.29
step
Watch the dialogue
|tip Protect Shay Leafrunner as she follows you.
|tip Stay close, she wanders off.
|tip Message in chat when she wanders off.
use Shay's Bell##9189
|tip When she wanders off.
Take Shay Leafrunner to Rockbiter's Camp |q 2845/2 |goto Feralas 42.38,22.00
|tip {o}HURRY{}, timed quest.
step
talk Rockbiter##7765
turnin Wandering Shay##2845 |goto Feralas 42.38,22.00
step
talk Gregan Brewspewer##7775
turnin A Visit to Gregan##4142 |goto Feralas 45.12,25.57
step
talk Gregan Brewspewer##7775
|tip Complete {o}The Videre Elixir{} quest.
collect Videre Elixir##11243 |q 3909/1 |goto Feralas 45.12,25.57
|tip {o}DO NOT DRINK IT{}.
|tip Kills you.
step
talk Troyas Moonbreeze##7764
|tip Inside the building.
turnin The Morrow Stone##2942 |goto Feralas 31.78,45.50
step
talk Pratt McGrubben##7852
turnin Improved Quality##7733 |goto Feralas 30.63,42.71
turnin Pristine Yeti Hide##7735 |goto Feralas 30.63,42.71 |only if haveq(7735) or completedq(7735)
step
talk Islen Waterseer##5901
turnin Seeking Spiritual Aid##5158 |goto The Barrens 65.83,43.78
step
talk Innkeeper Wiley##6791
|tip Inside the building.
home Ratchet |goto The Barrens 62.05,39.41 |q 5244 |future
step
click Marvon's Chest##149036
collect Stone Circle##10556 |q 3444/1 |goto The Barrens 62.50,38.54 |usebank
step
talk Liv Rizzlefix##8496
|tip Inside the building.
accept Volcanic Activity##4502 |goto The Barrens 62.45,38.74
step
talk Fuzruckle##3496
|tip Collect from the bank.
collect Drawing Kit##10445			|goto The Barrens 62.64,37.42 |q 3449
collect Standard Issue Flare Gun##10444		|goto The Barrens 62.64,37.42 |q 3449
step
talk Fuzruckle##3496
|tip Desposit into the bank.
bank Stone Circle##10556		|goto The Barrens 62.64,37.42 |q 3444
bank Eridan's Vial##11682		|goto The Barrens 62.64,37.42 |q 4441
bank Filled Cursed Ooze Jar##11947	|goto The Barrens 62.64,37.42 |q 4512
bank Filled Tainted Ooze Jar##11949	|goto The Barrens 62.64,37.42 |q 4512
bank Moontouched Feather##12383		|goto The Barrens 62.64,37.42 |q 978
bank Videre Elixir##11243		|goto The Barrens 62.64,37.42 |q 3909
step
talk Kim'jael##8420
|tip Top of the hill.
accept Kim'jael Indeed!##3601 |goto Azshara 53.45,21.82
step
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
stickystart "Collect_Some_Rune"
step
click Rune of Jin'yael##149480
collect Rubbing: Rune of Jin'yael##10564 |q 3449/2 |goto Azshara 39.56,50.31
step
click Rune of Beth'Amara##149481
collect Rubbing: Rune of Beth'Amara##10563 |q 3449/1 |goto Azshara 36.87,53.19
step
click Rune of Markri##149482
collect Rubbing: Rune of Markri##10565 |q 3449/3 |goto Azshara 39.30,55.48
step
click Rune of Sael'hai##149483
collect Rubbing: Rune of Sael'hai##10566 |q 3449/4 |goto Azshara 42.34,64.13
step
label "Collect_Some_Rune"
kill Spitelash Siren##6195, Spitelash Myrmidon##6196
|tip Sirens and Myrmidons.
|tip Nagas.
collect Some Rune##13815 |q 5534/1 |goto Azshara/0 45.40,54.00
|mapmarker Azshara/0 43.00,45.40
|mapmarker Azshara/0 43.40,50.80
|mapmarker Azshara/0 43.60,56.80
|mapmarker Azshara/0 44.20,59.80
|mapmarker Azshara/0 45.00,41.40
|mapmarker Azshara/0 45.40,48.00
|mapmarker Azshara/0 46.00,63.00
|mapmarker Azshara/0 46.20,45.00
|mapmarker Azshara/0 47.20,50.80
|mapmarker Azshara/0 47.40,57.00
|mapmarker Azshara/0 48.00,42.20
|mapmarker Azshara/0 48.20,65.60
|mapmarker Azshara/0 49.20,60.00
|mapmarker Azshara/0 49.40,53.80
step
Follow the path up |goto Azshara 45.95,38.62 < 30 |only if walking and subzone("The Shattered Strand")
talk Kim'jael##8420
|tip Top of the hill.
turnin Kim'jael's "Missing" Equipment##5534 |goto Azshara 53.45,21.82
step
_NOTE:_
During the Next Steps
|tip {o}Elite enemies{} in southern Azshara.
|tip Avoid them as you run.
|tip Run the long way around the Ruins of Eldarath.
|tip Don't try to run on the beach.
Click Here to Continue |confirm |q 3449
step
Run around the Ruins of Eldarath and cross the bridge |goto Azshara/0 62.36,82.00 < 20 |only if walking
Cross the bridge |goto Azshara/0 65.09,82.32 < 20 |only if walking
Jump down carefully |goto Azshara/0 74.04,87.38 < 20 |only if walking
use Standard Issue Flare Gun##10444
|tip Center of the wooden platform.
talk Pilot Xiggs Fuselighter##8392
|tip Eventually appears nearby.
|tip Sometimes {o}few minutes{}.
turnin Arcane Runes##3449 |goto Azshara 77.80,91.32
accept Return to Tymor##3461 |goto Azshara 77.80,91.32
step
_Destroy This Item:_
|tip Not needed.
trash Standard Issue Flare Gun##10444
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Un'Goro Crater (53-54)",{
image=ZGV.IMAGESDIR.."Un'Goro Crater",
hardcore = true,
next="Leveling Guides\\Winterspring & Felwood (54-56)",
},[[
step
talk Fuzruckle##3496
|tip Collect from the bank.
collect Stone Circle##10556	|goto The Barrens 62.64,37.42 |q 3444
collect Violet Tragan##8526	|goto The Barrens 62.64,37.42 |q 2641
collect Torwa's Pouch##11568	|goto The Barrens 62.64,37.42 |q 4292
collect Mithril Casing##10561	|goto The Barrens 62.64,37.42 |q 4244 |future
step
talk Fuzruckle##3496
|tip Deposit into the bank.
bank Drawing Kit##10445 |goto The Barrens 62.64,37.42 |q 3461
step
talk Tran'rek##7876
accept Super Sticky##4504 |goto Tanaris 51.57,26.76
step
talk Sprinkle##7583
turnin Sprinkle's Secret Ingredient##2641 |goto Tanaris/0 51.06,26.87
step
Watch the dialogue
talk Sprinkle##7583
accept Delivery for Marin##2661 |goto Tanaris/0 51.06,26.87
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin March of the Silithid##4493 |goto Tanaris 50.89,26.96
accept Bungle in the Jungle##4496 |goto Tanaris 50.89,26.96
step
talk Marin Noggenfogger##7564
turnin Delivery for Marin##2661 |goto Tanaris/0 51.81,28.66
accept Noggenfogger Elixir##2662 |goto Tanaris/0 51.81,28.66
step
Watch the dialogue
talk Marin Noggenfogger##7564
turnin Noggenfogger Elixir##2662 |goto Tanaris/0 51.81,28.66
step
talk Marvon Rivetseeker##7771
turnin The Stone Circle##3444 |goto Tanaris 52.71,45.92
step
talk Williden Marshal##9270
accept Expedition Salvation##3881 |goto Un'Goro Crater 43.95,7.14
step
talk Hol'anyee Marshal##9271
accept Alien Ecology##3883 |goto Un'Goro Crater 43.89,7.24
step
talk Spark Nilminer##9272
accept Roll the Bones##3882 |goto Un'Goro Crater 43.50,7.42
step
Enter the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
accept The Northern Pylon##4285 |goto Un'Goro Crater 41.92,2.70
accept The Eastern Pylon##4287 |goto Un'Goro Crater 41.92,2.70
accept The Western Pylon##4288 |goto Un'Goro Crater 41.92,2.70
step
Leave the cave |goto Un'Goro Crater 43.47,6.79 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
click Beware of Pterrordax
accept Beware of Pterrordax##4501 |goto Un'Goro Crater 43.55,8.42
step
talk Spraggle Frock##9997
accept Lost!##4492 |goto Un'Goro Crater/0 43.61,8.50
step
talk Shizzle##9998
accept Shizzle's Flyer##4503 |goto Un'Goro Crater 44.24,11.59
stickystart "Collect_Webbed_Pterrordax_Scales"
stickystart "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
step
click Northern Crystal Pylon
|tip Up on the cliff.
Select _"I want to examine this pylon."_ |gossip 98545
Discover and Examine the Northern Crystal Pylon |q 4285/1 |goto Un'Goro Crater/0 56.48,12.45
step
kill 10 Pterrordax##9166 |q 4501/1 |goto Un'Goro Crater/0 56.00,9.80
|tip Skip once no more to kill.
|tip Can finish later.
|mapmarker Un'Goro Crater/0 57.40,8.20
|mapmarker Un'Goro Crater/0 57.60,12.80
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
stickystart "Collect_Webbed_Pterrordax_Scales"
stickystart "Collect_Dinosaur_Bones_And_Webbed_Diemetradon_Scales"
step
Leave the cave |goto Un'Goro Crater/0 64.23,16.36 < 15 |walk |only if subzone("Fungal Rock") and indoors()
click Crate of Foodstuffs
collect Crate of Foodstuffs##11113 |q 3881/1 |goto Un'Goro Crater/0 68.51,36.54
step
click Eastern Crystal Pylon
|tip Up on the cliff.
Select _"I want to examine this pylon."_ |gossip 96122
Discover and Examine the Eastern Crystal Pylon |q 4287/1 |goto Un'Goro Crater/0 77.24,49.97
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
click Un'Goro Dirt Pile+
Kill enemies
collect 5 Un'Goro Soil##11018 |q 4496/2 |goto Un'Goro Crater/0 34.80,40.00
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
Enter the cave |goto Un'Goro Crater/0 43.47,6.79 < 15 |walk |only if not (subzone("Marshal's Refuge") and indoors())
talk J.D. Collie##9117
|tip Inside the cave.
turnin The Northern Pylon##4285 |goto Un'Goro Crater/0 41.92,2.70
turnin The Eastern Pylon##4287 |goto Un'Goro Crater/0 41.92,2.70
turnin The Western Pylon##4288 |goto Un'Goro Crater/0 41.92,2.70
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
Leave the cave |goto Un'Goro Crater/0 43.47,6.79 < 15 |walk |only if subzone("Marshal's Refuge") and indoors()
talk Hol'anyee Marshal##9271
turnin Alien Ecology##3883 |goto Un'Goro Crater/0 43.89,7.24
step
talk Williden Marshal##9270
turnin Expedition Salvation##3881 |goto Un'Goro Crater/0 43.95,7.14
step
talk Shizzle##9998
turnin Shizzle's Flyer##4503 |goto Un'Goro Crater/0 44.23,11.59
step
talk Karna Remtravel##9618
accept Chasing A-Me 01##4243 |goto Un'Goro Crater/0 46.38,13.44
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
stickystart "Collect_Super_Sticky_Tar"
step
Leave the cave |goto Un'Goro Crater/0 64.23,16.36 < 15 |walk |only if subzone("Fungal Rock") and indoors()
talk Torwa Pathfinder##9619
turnin The Mighty U'cha##4301 |goto Un'Goro Crater 71.63,75.96
step
label "Collect_Super_Sticky_Tar"
kill Tar Beast##6517, Tar Creeper##6527, Tar Lord##6519, Tar Lurker##6518
|tip Swamp elementals.
collect 12 Super Sticky Tar##11834 |q 4504/1 |goto Un'Goro Crater 60.00,33.20
|mapmarker Un'Goro Crater/0 46.40,32.40
|mapmarker Un'Goro Crater/0 46.40,35.40
|mapmarker Un'Goro Crater/0 49.20,34.20
|mapmarker Un'Goro Crater/0 58.20,30.20
|mapmarker Un'Goro Crater/0 60.00,22.40
|mapmarker Un'Goro Crater/0 61.40,30.40
|mapmarker Un'Goro Crater/0 65.00,24.00
|mapmarker Un'Goro Crater/0 41.80,20.60
|mapmarker Un'Goro Crater/0 42.40,16.20
|mapmarker Un'Goro Crater/0 44.60,19.40
|mapmarker Un'Goro Crater/0 45.40,15.40
|mapmarker Un'Goro Crater/0 47.40,22.20
|mapmarker Un'Goro Crater/0 48.40,18.20
|mapmarker Un'Goro Crater/0 49.40,25.20
|mapmarker Un'Goro Crater/0 49.40,28.80
|mapmarker Un'Goro Crater/0 50.60,22.40
|mapmarker Un'Goro Crater/0 52.40,26.20
|mapmarker Un'Goro Crater/0 54.20,23.40
step
talk Linken##8737
accept It's a Secret to Everybody##3908 |goto Un'Goro Crater/0 44.66,8.10
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Bungle in the Jungle##4496 |goto Tanaris/0 50.89,26.96
step
talk Tran'rek##7876
turnin Super Sticky##4504 |goto Tanaris 51.57,26.76
step
talk Gimblethorn##7799
|tip Collect from the bank.
|tip Inside the building.
collect Cenarion Beacon##11511		|goto Tanaris 52.30,28.91 |q 5882 |future
collect Eridan's Vial##11682		|goto Tanaris 52.30,28.91 |q 4441
collect 3 Videre Elixir##11243		|goto Tanaris 52.30,28.91 |q 3909
collect 10 Moontouched Feather##12383	|goto Tanaris 52.30,28.91 |q 978
step
talk Islen Waterseer##5901
accept Cleansed Water Returns to Felwood##5159 |goto The Barrens 65.83,43.78
step
talk Liv Rizzlefix##8496
|tip Inside the building.
turnin Volcanic Activity##4502 |goto The Barrens 62.45,38.74
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 4441
|only if Druid
stickystart "Accept_The_New_Frontier"
step
use Eridan's Vial##11682
|tip Inside the building.
collect Vial of Blessed Water##5646 |q 4441/1 |goto Darnassus 39.51,83.92
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 4441
|only if Priest
step
talk Auctioneer Golothas##8723
|tip Buy from the Auction House, if possible.
|tip Inside the building.
collect 60 Wool Cloth##2592		|goto Darnassus/0 56.24,54.05 |q 10352 |future
collect 60 Silk Cloth##4306		|goto Darnassus/0 56.24,54.05 |q 10354 |future
collect 60 Mageweave Cloth##4338	|goto Darnassus/0 56.24,54.05 |q 7799 |future
collect 60 Runecloth##14047		|goto Darnassus/0 56.24,54.05 |q 7800 |future
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 4441
|only if Warrior
step
talk Raedon Duskstriker##14725
|tip Inside the building.
accept A Donation of Wool##10352 |goto Darnassus/0 64.03,23.01 |instant
|only if itemcount(2592) >= 60
step
talk Raedon Duskstriker##14725
|tip Inside the building.
accept A Donation of Silk##10354 |goto Darnassus/0 64.03,23.01 |instant
|only if itemcount(4306) >= 60
step
talk Raedon Duskstriker##14725
|tip Inside the building.
accept A Donation of Mageweave##7799 |goto Darnassus/0 64.03,23.01 |instant
|only if itemcount(4338) >= 60
step
talk Raedon Duskstriker##14725
|tip Inside the building.
accept A Donation of Runecloth##7800 |goto Darnassus/0 64.03,23.01 |instant
|only if itemcount(14047) >= 60 and (completedq(10352) and completedq(10354) and completedq(7799))
step
label "Accept_The_New_Frontier"
map Darnassus/0
path follow strictbounce;	loop off;	ants straight;		dist 30;	markers none;		arrow hide
path	62.16,40.47	61.77,32.46	61.52,26.39	60.44,22.21	63.41,18.69
path	65.30,15.99	61.37,10.32	57.15,7.62	54.31,10.06	53.65,12.19
path	53.37,15.57	51.40,19.83	49.72,18.85	44.97,19.32	42.60,18.45
path	38.51,21.32	36.53,13.42	35.22,14.00	33.70,15.98	35.27,13.89
path	36.57,13.52	37.56,17.06	37.96,20.05	40.78,26.81	41.01,31.03
path	39.58,35.63	40.25,38.05	43.32,40.91	49.57,41.10	56.78,40.79
path	62.14,40.67	62.06,48.56	62.23,54.68	63.86,55.03	65.53,55.58
path	67.55,56.92	68.03,58.92	67.65,62.14	66.32,65.05	65.17,68.20
path	64.09,71.33	62.63,69.61	60.45,66.37	59.44,67.50	58.07,68.40
path	56.89,70.14	56.19,72.06	53.57,75.54	50.45,75.87	50.06,77.53
path	50.00,80.48	49.60,81.82	47.10,81.90	45.80,79.51	43.79,76.53
path	41.89,74.77	38.95,73.88	38.88,66.20	38.72,57.44	38.62,52.87
path	38.48,46.89	37.25,45.34	36.49,43.42	35.99,41.63	34.03,41.61
path	31.30,41.41	33.68,41.24	36.07,41.04	36.96,39.27	39.33,35.83
path	40.15,37.92	41.44,38.56	43.02,40.79	46.21,41.15	49.46,41.01
path	53.87,40.90	56.71,40.77	62.12,40.58
talk Herald Moonstalker##10878
|tip Walks a large path.
accept The New Frontier##1047
step
talk Jartsam##4753
Train Apprentice Riding |skillmax Riding,75 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Jocaste##4146
|tip Upstairs inside the building.
Train Abilities |trainer Jocaste##4146 |goto Darnassus/0 40.38,8.54 |q 4441
|only if Hunter
step
talk Silvaria##10089
|tip Top of the building.
Train Pet Abilities |trainer Silvaria##10089 |goto Darnassus/0 42.47,9.18 |q 4441
|only if Hunter
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 4441
|only if Rogue
step
talk Arch Druid Fandral Staghelm##3516
|tip Walks around.
|tip {o}Top floor{} inside the building.
turnin The New Frontier##1047 |goto Darnassus/0 34.82,9.25
accept The New Frontier##6761 |goto Darnassus/0 34.82,9.25
accept Morrowgrain Research##3781 |goto Darnassus/0 34.82,9.25
step
talk Mathrengyl Bearwalker##4217
|tip {o}Middle floor{} inside the building.
turnin The New Frontier##6761 |goto Darnassus/0 35.40,8.42
accept Rabine Saturna##6762 |goto Darnassus/0 35.40,8.42
turnin Morrowgrain Research##3781 |goto Darnassus/0 35.40,8.42
step
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Moontouched Wildkin##978 |goto Teldrassil 55.50,92.04
accept Find Ranshalla##979 |goto Teldrassil 55.50,92.04
step
talk Daryn Lightwind##7907
|tip Upstairs inside the building.
accept Starfall##5250 |goto Teldrassil 55.41,92.23
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 5159
|only if Mage
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 5159
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 5159
|only if Warlock
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.54,4.50 |q 5159
|only if Paladin
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Winterspring & Felwood (54-56)",{
image=ZGV.IMAGESDIR.."Winterspring",
hardcore = true,
next="Leveling Guides\\Burning Steppes (56-57)",
},[[
step
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
collect Deadwood Headdress Feather##21377+ |n
|tip Don't vendor them.
|tip Can be turned in later for {o}xp and reputation{}.
collect 6 Corrupted Soul Shard##11515 |goto Felwood 62.40,12.60 |q 5882 |future
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 63.60,9.60
|mapmarker Felwood/0 63.60,6.00
step
talk Greta Mosshoof##10922
|tip Walks around.
turnin Cleansed Water Returns to Felwood##5159 |goto Felwood 51.21,82.11
accept Dousing the Flames of Protection##5165 |goto Felwood 51.21,82.11
step
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Felbound Ancients##4441 |goto Felwood 51.35,81.51
step
Watch the dialogue
talk Eridan Bluewind##9116
|tip Inside the building.
accept Purified!##4442 |goto Felwood 51.35,81.51
step
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Purified!##4442 |goto Felwood 51.35,81.51
step
talk Arathandris Silversky##9528
|tip Walks around.
accept Salve via Hunting##5882 |goto Felwood 54.15,86.83 |instant
step
_Destroy These Items:_
|tip Not needed.
trash Flute of the Ancients##11445
trash Cenarion Beacon##11511
trash Cenarion Plant Salve##11516
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
talk Nafien##15395
|tip Follow the road.
accept Deadwood of the North##8461 |goto Felwood 64.77,8.13
step
label "Kill_Deadwood_Enemies"
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
talk Nafien##15395
|tip Follow the road.
turnin Deadwood of the North##8461 |goto Felwood 64.77,8.13
accept Speak to Salfa##8465 |goto Felwood 64.77,8.13
step
talk Salfa##11556
turnin Speak to Salfa##8465 |goto Winterspring 27.74,34.50
step
talk Donova Snowden##9298
turnin The Videre Elixir##3909 |goto Winterspring/0 31.27,45.16
accept Meet at the Grave##3912 |goto Winterspring/0 31.27,45.16
turnin The New Springs##980 |goto Winterspring/0 31.27,45.16
accept Threat of the Winterfall##5082 |goto Winterspring 31.27,45.16
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
Kill enemies
|tip Helps reach level 55 after quest turnins.
|tip Difficult quest soon.
ding 54,165200 |goto Winterspring 30.00,35.40
|mapmarker Winterspring/0 33.60,37.00
|mapmarker Winterspring/0 40.40,42.40
|mapmarker Winterspring/0 42.60,43.20
step
talk Donova Snowden##9298
turnin Threat of the Winterfall##5082 |goto Winterspring 31.27,45.16
turnin Winterfall Firewater##5083 |goto Winterspring 31.27,45.16
accept Falling to Corruption##5084 |goto Winterspring 31.27,45.16
step
click Deadwood Cauldron##176091
|tip Run away, if needed.
turnin Falling to Corruption##5084 |goto Felwood 60.20,5.87
accept Mystery Goo##5085 |goto Felwood 60.20,5.87
step
talk Donova Snowden##9298
turnin Mystery Goo##5085 |goto Winterspring 31.27,45.16
accept Toxic Horrors##5086 |goto Winterspring 31.27,45.16
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
step
talk Donova Snowden##9298
turnin Toxic Horrors##5086 |goto Winterspring/0 31.27,45.16
accept Winterfall Runners##5087 |goto Winterspring/0 31.27,45.16
accept Strange Sources##4842 |goto Winterspring/0 31.27,45.16
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
|tip Skip if not found by end of path.
|tip Can finish later.
collect Winterfall Crate##12829 |q 5087/1
Spawn around [Winterspring/0 28.07,35.03] |noway
step
talk Wynd Nightchaser##11079
|tip Inside the building.
turnin Starfall##5250 |goto Winterspring 51.97,30.39
accept The Ruins of Kel'Theril##5244 |goto Winterspring 51.97,30.39
step
talk Jaron Stoneshaper##10301
|tip Inside the building.
turnin The Ruins of Kel'Theril##5244 |goto Winterspring 52.14,30.43
accept Troubled Spirits of Kel'Theril##5245 |goto Winterspring 52.14,30.43
accept Enraged Wildkin##4861 |goto Winterspring 52.14,30.43
step
click Highborne Relic Fragment
|tip You will be attacked.
collect Second Relic Fragment##12897 |q 5245/2 |goto Winterspring 50.88,41.71
step
click Highborne Relic Fragment
|tip You will be attacked.
collect Fourth Relic Fragment##12899 |q 5245/4 |goto Winterspring 52.42,41.50
step
click Highborne Relic Fragment
|tip You will be attacked.
collect Third Relic Fragment##12898 |q 5245/3 |goto Winterspring 53.31,43.43
step
click Highborne Relic Fragment
|tip You will be attacked.
collect First Relic Fragment##12896 |q 5245/1 |goto Winterspring 55.14,42.98
step
talk Innkeeper Vizzie##11118
|tip Inside the building.
home Everlook |goto Winterspring 61.36,38.83 |q 3702 |future
step
talk Gregor Greystone##10431
|tip Inside the building.
accept The Everlook Report##6028 |goto Winterspring 61.35,38.97
accept Duke Nicholas Zverenhoff##6030 |goto Winterspring 61.35,38.97
step
talk Izzy Coppergrab##13917
|tip Deposit into the bank.
|tip Inside the building.
bank Irontree Heart##11173		|goto Winterspring/0 61.46,36.97 |q 4084
bank Silvery Claws##11172		|goto Winterspring/0 61.46,36.97 |q 4084
bank Everlook Report##15788		|goto Winterspring/0 61.46,36.97 |q 6028
bank Studies in Spirit Speaking##15790	|goto Winterspring/0 61.46,36.97 |q 6030
bank Jaron's Pick##12891		|goto Winterspring/0 61.46,36.97 |q 5245
bank First Relic Fragment##12896	|goto Winterspring/0 61.46,36.97 |q 5245
bank Second Relic Fragment##12897	|goto Winterspring/0 61.46,36.97 |q 5245
bank Third Relic Fragment##12898	|goto Winterspring/0 61.46,36.97 |q 5245
bank Fourth Relic Fragment##12899	|goto Winterspring/0 61.46,36.97 |q 5245
step
click Damaged Crate
turnin Enraged Wildkin##4861 |goto Winterspring 59.00,59.78
accept Enraged Wildkin##4863 |goto Winterspring 59.00,59.78
step
click Jaron's Wagon
turnin Enraged Wildkin##4863 |goto Winterspring 61.41,60.68
accept Enraged Wildkin##4864 |goto Winterspring 61.41,60.68
step
click Jaron's Supplies
collect Jaron's Supplies##12525 |q 4864/1 |goto Winterspring 61.39,60.73
step
talk Ranshalla##10300
|tip Escort quest.
|tip Wait until she respawns, if missing.
turnin Find Ranshalla##979 |goto Winterspring 63.07,59.47
accept Guardians of the Altar##4901 |goto Winterspring 63.07,59.47 |noautoaccept inparty
stickystart "Collect_Blue_Feathered_Amulet"
step
Watch the dialogue
|tip Follow and protect Ranshalla.
|tip Let enemies {o}attack her first{}.
|tip Otherwise, she won't help fight.
|tip She is tough and unlikely to die.
|tip Try to {o}let her tank{} for you.
click Fire of Elune+
|tip Brown torch poles.
|tip Inside each cave.
click Altar of Elune
|tip Stone table.
|tip At this location.
Discover the Secret of the Altar of Elune |q 4901/1 |goto Winterspring 64.86,63.69
|tip May need help.
step
label "Collect_Blue_Feathered_Amulet"
kill Crazed Owlbeast##7452, Moontouched Owlbeast##7453, Berserk Owlbeast##7454
collect Blue-feathered Amulet##12524 |q 4864/2 |goto Winterspring/0 63.40,59.20
|mapmarker Winterspring/0 64.40,62.40
|mapmarker Winterspring/0 64.80,65.00
|mapmarker Winterspring/0 65.80,60.80
step
Discover Darkwhisper Gorge |q 4842/1 |goto Winterspring 59.84,74.12
|tip Follow the road.
step
talk Jaron Stoneshaper##10301
|tip Inside the building.
turnin Enraged Wildkin##4864 |goto Winterspring 52.14,30.43
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
turnin Strange Sources##4842 |goto Winterspring 31.27,45.16
turnin Winterfall Runners##5087 |goto Winterspring 31.27,45.16
step
talk Salfa##11556
accept Winterfall Activity##8464 |goto Winterspring 27.74,34.50
stickystart "Accept_Deadwood_Ritual_Totem"
step
kill Deadwood Den Watcher##7156, Deadwood Avenger##7157, Deadwood Shaman##7158
|tip Alternatively, run dungeons to reach level 56.
collect Deadwood Headdress Feather##21377+ |n
|tip Turn in {o}stacks of 5{} to Nafien.
|tip Each stack gives {o}50 reputation{}.
Reach {y}Neutral{} Reputation with the Timbermaw Hold Faction |complete rep('Timbermaw Hold') >= Neutral |goto Felwood 63.60,9.60
Turn in Feathers at [64.77,8.13]
Ammo available at [Felwood/0 62.32,25.64]		|only if Hunter
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
use Winterfall Ritual Totem##20742
accept Winterfall Ritual Totem##8471
|only if itemcount(20742) > 0 and level < 56.10
step
talk Kernda##11558
|tip Walks around.
|tip Inside the tunnel.
turnin Deadwood Ritual Totem##8470	|goto Felwood/0 65.49,3.48 |region timbermawhold
turnin Winterfall Ritual Totem##8471	|goto Felwood/0 65.49,3.48 |region timbermawhold	|only if haveq(8471) or completedq(8471)
|mapmarker Felwood/0 65.37,2.49 |region timbermawhold
|mapmarker Felwood/0 65.38,1.17 |region timbermawhold
|only if level < 56.10
step
Kill enemies
ding 56 |goto Felwood 62.40,12.60
Ammo available at [Felwood/0 62.32,25.64]		|only if Hunter
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 63.60,9.60
|mapmarker Felwood/0 63.60,6.00
step
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 4901
|only if Druid
step
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Guardians of the Altar##4901 |goto Teldrassil 55.50,92.05
accept Wildkin of Elune##4902 |goto Teldrassil 55.50,92.05
step
talk Jandria##4091
|tip Inside the building.
Train Abilities |trainer Jandria##4091 |goto Darnassus/0 37.90,82.73 |q 4902
|only if Priest
step
talk Garryeth##4209
|tip Collect from the bank.
collect Black Dragonflight Molt##10575		|goto Darnassus/0 39.60,41.99 |q 4022 |future
collect Janice's Parcel##12724			|goto Darnassus/0 39.60,41.99 |q 5022
collect Drawing Kit##10445			|goto Darnassus/0 39.60,41.99 |q 3461
collect 6 Filled Cursed Ooze Jar##11947		|goto Darnassus/0 39.60,41.99 |q 4512
collect 6 Filled Tainted Ooze Jar##11949	|goto Darnassus/0 39.60,41.99 |q 4512
step
talk Sildanair##4089
Train Abilities |trainer Sildanair##4089 |goto Darnassus/0 61.78,42.21 |q 4902
|only if Warrior
step
talk Jartsam##4753
Train Apprentice Riding |skillmax Riding,75 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
step
talk Jocaste##4146
|tip Upstairs inside the building.
Train Abilities |trainer Jocaste##4146 |goto Darnassus/0 40.38,8.54 |q 4902
|only if Hunter
step
Enter the tree cave |goto Darnassus/0 32.14,16.46 < 7 |walk
talk Syurna##4163
|tip Downstairs inside the tree cave.
Train Abilities |trainer Syurna##4163 |goto Darnassus/0 37.00,21.92 |q 4902
|only if Rogue
step
talk Arch Druid Fandral Staghelm##3516
|tip Walks around.
|tip Top of the tower.
turnin Wildkin of Elune##4902 |goto Darnassus 34.82,9.25
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 3461
|only if Mage
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Burning Steppes (56-57)",{
image=ZGV.IMAGESDIR.."Burning Steppes",
hardcore = true,
next="Leveling Guides\\Western & Eastern Plaguelands (57-58)",
},[[
step
Follow the path |goto Ironforge/0 44.51,49.57 < 15 |walk |only if not subzone("The High Seat")
talk Royal Historian Archesonus##8879
accept The Smoldering Ruins of Thaurissan##3702 |goto Ironforge 38.37,55.31
step
talk Royal Historian Archesonus##8879
Select _"I am ready, Historian Archesonus."_ |gossip 96299
Select _"That is tragic. How did this happen?"_ |gossip 96302
Select _"Interesting, continue please."_ |gossip 97844
Select _"Unbelievable! How dare they??"_ |gossip 96300
Select _"Of course I will help!"_ |gossip 96301
Listen to the Story of Thaurissan |q 3702/1 |goto Ironforge 38.37,55.31
step
talk Royal Historian Archesonus##8879
turnin The Smoldering Ruins of Thaurissan##3702 |goto Ironforge 38.37,55.31
accept The Smoldering Ruins of Thaurissan##3701 |goto Ironforge 38.37,55.31
step
talk Innkeeper Firebrew##5111
|tip Inside the building.
home Ironforge |goto Ironforge 18.15,51.46 |q 3701 |future
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.54,4.50 |q 3461
|only if Paladin
step
talk Tymor##8507
|tip Inside the building.
turnin Return to Tymor##3461 |goto Ironforge 30.97,4.82
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 4512
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 4512
|only if Warlock
step
talk Laris Geardawdle##9616
|tip Inside the building.
turnin A Little Slime Goes a Long Way##4512 |goto Ironforge 75.77,23.37
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
talk Oralius##9177
accept Gor'tesh the Brute Lord##3824 |goto Burning Steppes 84.56,68.68
accept FIFTY! YEP!##4283 |goto Burning Steppes 84.56,68.68
step
talk Helendis Riverhorn##9562
accept Dragonkin Menace##4182 |goto Burning Steppes 85.82,68.94
step
talk Tinkee Steamboil##10267
accept Broodling Essence##4726 |goto Burning Steppes 65.24,24.00
step
talk Maxwort Uberglint##9536
accept Tablet of the Seven##4296 |goto Burning Steppes 65.16,23.92
step
_NOTE:_
During the Next Steps
|tip {o}Elite enemies{}.
|tip May need help.
|tip Important to complete {o}Dragonkin Menace{} quest.
|tip Unlocks more quests that give good xp.
|tip Can skip, but will need to grind later.
Click Here to Continue |confirm |q 4182
stickystart "Collect_Broodling_Essences"
stickystart "Kill_Black_Drake"
stickystart "Kill_Black_Wyrmkins_And_Dragonspawns"
stickystart "Kill_Black_Broodlings"
step
talk Cyrus Therepentous##9459
|tip Inside the small cave.
accept A Taste of Flame##4022 |goto Burning Steppes 95.06,31.57
stickystop "Collect_Broodling_Essences"
stickystop "Kill_Black_Drake"
stickystop "Kill_Black_Wyrmkins_And_Dragonspawns"
stickystop "Kill_Black_Broodlings"
step
talk Cyrus Therepentous##9459
|tip Inside the small cave.
Select _"I do not possess any proof, Cyrus."_ |gossip 95293
Select _"I am ready!"_ |gossip 95295
kill Frenzied Black Drake##9461
|tip {o}Elite enemy{}.
|tip May need help.
collect Black Dragonflight Molt##10575 |q 4022/1 |goto Burning Steppes 95.06,31.57
step
talk Cyrus Therepentous##9459
|tip Inside the small cave.
Select _"I present you with proof of my deeds, Cyrus."_ |gossip 95294
Present the Proof |q 4022/2 |goto Burning Steppes 95.06,31.57
step
talk Cyrus Therepentous##9459
|tip Inside the small cave.
turnin A Taste of Flame##4022 |goto Burning Steppes 95.06,31.57
stickystart "Kill_Black_Drake"
stickystart "Kill_Black_Wyrmkins_And_Dragonspawns"
stickystart "Kill_Black_Broodlings"
step
label "Collect_Broodling_Essences"
use Draco-Incarcinatrix 900##12284
|tip On Black Broodlings.
|tip Small flying dragons.
kill Black Broodling##7047
click Broodling Essence+
|tip Red crystals above their corpses.
collect 8 Broodling Essence##12283 |q 4726/1 |goto Burning Steppes 88.60,29.40
|mapmarker Burning Steppes/0 79.40,30.80
|mapmarker Burning Steppes/0 81.40,27.00
|mapmarker Burning Steppes/0 81.40,59.40
|mapmarker Burning Steppes/0 82.40,62.60
|mapmarker Burning Steppes/0 84.20,55.00
|mapmarker Burning Steppes/0 84.40,58.40
|mapmarker Burning Steppes/0 85.20,61.40
|mapmarker Burning Steppes/0 85.40,30.40
|mapmarker Burning Steppes/0 87.80,32.40
|mapmarker Burning Steppes/0 88.20,57.00
|mapmarker Burning Steppes/0 88.40,44.20
|mapmarker Burning Steppes/0 90.00,47.40
|mapmarker Burning Steppes/0 90.40,40.80
|mapmarker Burning Steppes/0 91.20,58.40
|mapmarker Burning Steppes/0 91.40,31.40
|mapmarker Burning Steppes/0 92.00,35.40
|mapmarker Burning Steppes/0 92.00,44.80
step
label "Kill_Black_Drake"
kill Black Drake##7044 |q 4182/3 |goto Burning Steppes 88.40,32.60
|tip Large red dragons.
|mapmarker Burning Steppes/0 77.40,57.40
|mapmarker Burning Steppes/0 78.20,27.20
|mapmarker Burning Steppes/0 79.40,63.60
|mapmarker Burning Steppes/0 80.00,60.00
|mapmarker Burning Steppes/0 80.20,30.40
|mapmarker Burning Steppes/0 81.00,55.00
|mapmarker Burning Steppes/0 81.20,26.80
|mapmarker Burning Steppes/0 82.40,62.20
|mapmarker Burning Steppes/0 83.00,58.20
|mapmarker Burning Steppes/0 83.40,30.20
|mapmarker Burning Steppes/0 84.20,26.80
|mapmarker Burning Steppes/0 84.20,55.20
|mapmarker Burning Steppes/0 85.20,33.00
|mapmarker Burning Steppes/0 85.60,61.00
|mapmarker Burning Steppes/0 85.80,38.40
|mapmarker Burning Steppes/0 85.80,48.60
|mapmarker Burning Steppes/0 86.40,29.40
|mapmarker Burning Steppes/0 86.40,51.80
|mapmarker Burning Steppes/0 86.80,43.60
|mapmarker Burning Steppes/0 87.00,25.00
|mapmarker Burning Steppes/0 87.40,35.80
|mapmarker Burning Steppes/0 87.40,54.80
|mapmarker Burning Steppes/0 88.00,40.60
|mapmarker Burning Steppes/0 88.20,58.80
|mapmarker Burning Steppes/0 88.40,46.80
|mapmarker Burning Steppes/0 89.00,50.20
|mapmarker Burning Steppes/0 90.00,29.20
|mapmarker Burning Steppes/0 90.20,44.20
|mapmarker Burning Steppes/0 90.40,35.60
|mapmarker Burning Steppes/0 90.60,55.00
|mapmarker Burning Steppes/0 91.20,48.00
|mapmarker Burning Steppes/0 91.40,39.20
|mapmarker Burning Steppes/0 91.40,59.00
|mapmarker Burning Steppes/0 92.00,32.00
|mapmarker Burning Steppes/0 92.60,51.40
|mapmarker Burning Steppes/0 92.80,42.60
|mapmarker Burning Steppes/0 93.60,54.40
step
label "Kill_Black_Wyrmkins_And_Dragonspawns"
kill 4 Black Wyrmkin##7041 |q 4182/4 |goto Burning Steppes 91.60,47.40
kill 10 Black Dragonspawn##7040 |q 4182/2 |goto Burning Steppes 91.60,47.40
|mapmarker Burning Steppes/0 81.40,26.20
|mapmarker Burning Steppes/0 82.20,29.80
|mapmarker Burning Steppes/0 84.40,26.20
|mapmarker Burning Steppes/0 85.60,29.60
|mapmarker Burning Steppes/0 86.00,35.00
|mapmarker Burning Steppes/0 87.00,39.40
|mapmarker Burning Steppes/0 87.40,42.60
|mapmarker Burning Steppes/0 89.00,55.60
|mapmarker Burning Steppes/0 89.20,35.40
|mapmarker Burning Steppes/0 89.40,50.60
|mapmarker Burning Steppes/0 90.40,38.40
|mapmarker Burning Steppes/0 91.60,53.00
|mapmarker Burning Steppes/0 92.40,57.40
step
label "Kill_Black_Broodlings"
kill 15 Black Broodling##7047 |q 4182/1 |goto Burning Steppes 90.40,50.40
|tip Small flying dragons.
|mapmarker Burning Steppes/0 79.40,30.80
|mapmarker Burning Steppes/0 81.40,27.00
|mapmarker Burning Steppes/0 81.40,59.40
|mapmarker Burning Steppes/0 82.40,62.60
|mapmarker Burning Steppes/0 84.20,55.00
|mapmarker Burning Steppes/0 84.40,58.40
|mapmarker Burning Steppes/0 85.20,61.40
|mapmarker Burning Steppes/0 85.40,30.40
|mapmarker Burning Steppes/0 87.80,32.40
|mapmarker Burning Steppes/0 88.20,57.00
|mapmarker Burning Steppes/0 88.40,44.20
|mapmarker Burning Steppes/0 90.00,47.40
|mapmarker Burning Steppes/0 90.40,40.80
|mapmarker Burning Steppes/0 91.20,58.40
|mapmarker Burning Steppes/0 91.40,31.40
|mapmarker Burning Steppes/0 92.00,35.40
|mapmarker Burning Steppes/0 92.00,44.80
stickystart "Recover_Information"
step
click Tablet of the Seven
Select _"Transcribe the tablet."_ |gossip 96146
collect Tablet Transcript##11470 |q 4296/1 |goto Burning Steppes 54.09,40.73
step
label "Recover_Information"
click Thaurissan Relic+
|tip Upright grey stones.
Recover #12# Information |q 3701/1 |goto Burning Steppes 54.10,40.80
|mapmarker Burning Steppes/0 55.40,37.20
|mapmarker Burning Steppes/0 57.40,36.40
|mapmarker Burning Steppes/0 57.90,39.10
|mapmarker Burning Steppes/0 59.70,37.70
|mapmarker Burning Steppes/0 60.30,35.10
|mapmarker Burning Steppes/0 61.90,36.60
|mapmarker Burning Steppes/0 62.60,39.80
|mapmarker Burning Steppes/0 63.50,35.80
|mapmarker Burning Steppes/0 64.20,41.40
|mapmarker Burning Steppes/0 64.60,37.10
|mapmarker Burning Steppes/0 65.60,43.90
|mapmarker Burning Steppes/0 66.10,40.50
stickystart "Collect_Blackrock_Medallions"
step
kill Gor'tesh##9176
|tip Ogre.
|tip Careful, {o}hits hard{}.
|tip May need help.
|tip Walks around.
|tip In and out of the building.
collect Gor'tesh's Lopped Off Head##11080 |q 3824/1 |goto Burning Steppes 39.26,55.36
step
label "Collect_Blackrock_Medallions"
kill Slavering Ember Worg##9694, Blackrock Worg##7055, Blackrock Soldier##7025, Blackrock Sorcerer##7026, Blackrock Slayer##7027, Blackrock Warlock##7028
|tip Orcs and wolves.
collect 50 Blackrock Medallion##11467 |q 4283/1 |goto Burning Steppes 41.20,56.60
|mapmarker Burning Steppes/0 42.40,53.20
|mapmarker Burning Steppes/0 44.40,50.40
|mapmarker Burning Steppes/0 44.40,58.00
|mapmarker Burning Steppes/0 48.40,56.20
|mapmarker Burning Steppes/0 48.40,59.40
|mapmarker Burning Steppes/0 49.60,53.40
|mapmarker Burning Steppes/0 51.80,55.80
|mapmarker Burning Steppes/0 55.60,54.20
step
Follow the path up into Morgan's Vigil |goto Burning Steppes 82.85,63.33 < 20 |only if walking and not subzone("Morgan's Vigil")
talk Oralius##9177
turnin Gor'tesh the Brute Lord##3824 |goto Burning Steppes 84.56,68.67
accept Ogre Head On A Stick = Party##3825 |goto Burning Steppes 84.56,68.67
turnin FIFTY! YEP!##4283 |goto Burning Steppes 84.56,68.67
step
_Destroy These Items:_
|tip Not needed.
trash Blackrock Medallion##11467
step
talk Helendis Riverhorn##9562
turnin Dragonkin Menace##4182 |goto Burning Steppes 85.82,68.95
accept The True Masters##4183 |goto Burning Steppes 85.82,68.95
|only if haveq(4182) or completedq(4182)
step
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4183 |goto Redridge Mountains 24.90,44.45
accept The True Masters##4184 |goto Redridge Mountains 24.90,44.45
|only if haveq(4182) or completedq(4182)
step
Enter Stormwind Keep |goto Stormwind City 73.09,46.63 < 15 |walk |only if not subzone("Stormwind Keep")
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4184 |goto Stormwind City 80.15,38.33		|only if haveq(4182) or completedq(4182)
accept The True Masters##4185 |goto Stormwind City 80.15,38.33		|only if haveq(4182) or completedq(4182)
accept The First and the Last##6182 |goto Stormwind City 80.15,38.33
step
talk Lady Katrana Prestor##1749
|tip Inside the building.
Select _"Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice."_ |gossip 95298
Select _"My apologies, Lady Prestor. "_ |gossip 95782
Select _"Begging your pardon, Lady Prestor. That was not my intent. "_ |gossip 95284
Select _"Thank you for your time, Lady Prestor."_ |gossip 95283
Seek Advice from Lady Prestor |q 4185/1 |goto Stormwind City 80.06,38.15
|only if haveq(4182) or completedq(4182)
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4185 |goto Stormwind City 80.15,38.33
accept The True Masters##4186 |goto Stormwind City 80.15,38.33
|only if haveq(4182) or completedq(4182)
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin The First and the Last##6182 |goto Stormwind City 78.27,70.74
accept Honor the Dead##6183 |goto Stormwind City 78.27,70.74
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin Honor the Dead##6183 |goto Stormwind City 78.27,70.74
accept Flint Shadowmore##6184 |goto Stormwind City 78.27,70.74
step
talk Royal Factor Bathrilor##10782
|tip Upstairs inside the building.
turnin Better Late Than Never##5022 |goto Stormwind City 57.16,48.05
accept Good Natured Emma##5048 |goto Stormwind City 57.16,48.05
step
map Stormwind City
path	follow strict;	loop on;	ants curved;	dist 20;	markers none;		arrow hide
path	52.46,41.98		48.29,49.03		50.15,51.53		55.04,47.69
path	57.64,47.70		59.73,51.45		57.66,55.16		60.62,60.33
path	57.16,54.48		57.05,54.37		55.65,53.48		52.74,55.15
path	50.88,51.60		49.66,51.59		48.32,48.32
talk Ol' Emma##3520
|tip Old human woman.
|tip Walks a large path.
turnin Good Natured Emma##5048
accept Good Luck Charm##5050
Also check upstairs in the house at [Stormwind City/0 60.18,57.02] |noway
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
step
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4186 |goto Redridge Mountains 24.90,44.45
accept The True Masters##4223 |goto Redridge Mountains 24.90,44.45
step
talk Marshal Maxwell##9560
turnin The True Masters##4223 |goto Burning Steppes 84.75,69.02
accept The True Masters##4224 |goto Burning Steppes 84.75,69.02
step
talk Tinkee Steamboil##10267
turnin Broodling Essence##4726 |goto Burning Steppes 65.23,23.99
accept Felnok Steelspring##4808 |goto Burning Steppes 65.23,23.99
step
talk Maxwort Uberglint##9536
turnin Tablet of the Seven##4296 |goto Burning Steppes 65.15,23.91
step
talk Ragged John##9563
Select _"Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him."_ |gossip 95785
Select _"So what did you do?"_ |gossip 95841
Select _"Start making sense, dwarf. I don't want to have anything to do with your cracker, your pappy, or any sort of 'discreditin.' "_ |gossip 96407
Select _"Ironfoe? "_ |gossip 96354
Select _"Interesting... continue, John."_ |gossip 96352
Select _"So that's how Windsor died..."_ |gossip 96350
Select _"So how did he die?"_ |gossip 96348
Select _"Ok, so where the hell is he? Wait a minute! Are you drunk?"_ |gossip 98085
Select _"WHY is he in Blackrock Depths?"_ |gossip 96346
Select _"300? So the Dark Irons killed him and dragged him into the Depths?"_ |gossip 95791
Select _"Ahhh... Ironfoe. "_ |gossip 95789
Select _"Thanks, Ragged John. Your story was very uplifting and informative. "_ |gossip 95787
Listen to Ragged John's Story |q 4224/1 |goto Burning Steppes 65.01,23.76
step
Cross the hanging bridge and follow the path up |goto Burning Steppes 76.13,38.04 < 20 |only if walking
click Soft Dirt Mound
|tip Top of the mountain.
Plant Gor'tesh's Head |q 3825/1 |goto Burning Steppes 80.99,46.78
step
Follow the path up into Morgan's Vigil |goto Burning Steppes 82.85,63.33 < 20 |only if walking and not subzone("Morgan's Vigil")
talk Oralius##9177
turnin Ogre Head On A Stick = Party##3825 |goto Burning Steppes 84.56,68.67
step
talk Marshal Maxwell##9560
turnin The True Masters##4224 |goto Burning Steppes 84.74,69.01
step
Kill enemies
|tip Run dungeons, if you prefer.
ding 57 |goto Burning Steppes 75.60,50.00
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
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Western & Eastern Plaguelands (57-58)",{
image=ZGV.IMAGESDIR.."Burning Steppes",
hardcore = true,
next="Leveling Guides\\Winterspring (58-59)",
},[[
step
talk Lieutenant Rotimer##13843
accept The Sovereign Imperative##7261 |goto Ironforge/0 32.21,63.25
step
talk Bailey Stonemantle##2461
|tip Collect from the bank.
|tip Inside the building.
collect Everlook Report##15788			|goto Ironforge 35.92,60.14 |q 6028
collect Studies in Spirit Speaking##15790	|goto Ironforge 35.92,60.14 |q 6030
collect Jaron's Pick##12891			|goto Ironforge 35.92,60.14 |q 5245
collect First Relic Fragment##12896		|goto Ironforge 35.92,60.14 |q 5245
collect Second Relic Fragment##12897		|goto Ironforge 35.92,60.14 |q 5245
collect Third Relic Fragment##12898		|goto Ironforge 35.92,60.14 |q 5245
collect Fourth Relic Fragment##12899		|goto Ironforge 35.92,60.14 |q 5245
step
talk Bailey Stonemantle##2461
|tip Deposit into the bank.
|tip Inside the building.
bank Tinkee's Letter##12438 |goto Ironforge 35.92,60.14 |q 4808
step
Follow the path |goto Ironforge/0 44.51,49.57 < 15 |walk |only if not subzone("The High Seat")
talk Royal Historian Archesonus##8879
turnin The Smoldering Ruins of Thaurissan##3701 |goto Ironforge 38.37,55.31
step
talk Innkeeper Anderson##2352
|tip Inside the building.
home Southshore |goto Hillsbrad Foothills 51.17,58.93 |q 5211 |future
step
talk Lieutenant Haggerdin##13841
turnin The Sovereign Imperative##7261 |goto Alterac Mountains/0 39.46,81.23
step
talk High Priestess MacDonnell##11053
accept Target: Dalson's Tears##5219 |goto Western Plaguelands 42.97,84.50
step
talk Commander Ashlam Valorfist##10838
accept All Along the Watchtowers##5097 |goto Western Plaguelands 42.70,84.03
step
talk Argent Officer Pureheart##10840
turnin The Everlook Report##6028 |goto Western Plaguelands 42.97,83.55
step
talk Flint Shadowmore##12425
turnin Flint Shadowmore##6184 |goto Western Plaguelands 43.61,84.51
step
talk Marlene Redpath##10927
|tip Walks around.
|tip {o}Both floors{} inside the building.
accept Little Pamela##5142 |goto Western Plaguelands/0 49.13,78.52
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower Four |q 5097/4 |goto Western Plaguelands 46.70,71.10
step
talk Mulgris Deepriver##10739
|tip Inside the building.
accept The Wildlife Suffers Too##4984 |goto Western Plaguelands 53.72,64.67
stickystart "Kill_Diseased_Wolves"
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower Three |q 5097/3 |goto Western Plaguelands 44.22,63.37
step
label "Kill_Diseased_Wolves"
kill 8 Diseased Wolf##1817 |q 4984/1 |goto Western Plaguelands 44.20,59.60
|tip Shared spawns with spiders.
|mapmarker Western Plaguelands/0 39.40,48.60
|mapmarker Western Plaguelands/0 42.40,47.00
|mapmarker Western Plaguelands/0 42.40,56.40
|mapmarker Western Plaguelands/0 43.40,39.80
|mapmarker Western Plaguelands/0 43.80,50.80
|mapmarker Western Plaguelands/0 50.20,64.20
|mapmarker Western Plaguelands/0 45.20,42.20
|mapmarker Western Plaguelands/0 45.40,47.80
|mapmarker Western Plaguelands/0 46.80,39.40
|mapmarker Western Plaguelands/0 47.60,45.40
|mapmarker Western Plaguelands/0 48.20,61.60
|mapmarker Western Plaguelands/0 49.80,38.80
|mapmarker Western Plaguelands/0 50.40,48.00
|mapmarker Western Plaguelands/0 50.40,52.20
|mapmarker Western Plaguelands/0 51.20,58.00
|mapmarker Western Plaguelands/0 51.60,69.40
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
kill Cauldron Lord Malvinious##11077
collect Dalson's Tears Cauldron Key##13195 |q 5219/1 |goto Western Plaguelands 46.18,52.38
step
click Scourge Cauldron
turnin Target: Dalson's Tears##5219 |goto Western Plaguelands 46.18,52.02
accept Return to Chillwind Camp##5220 |goto Western Plaguelands 46.18,52.02
step
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Good Luck Charm##5050 |goto Western Plaguelands 38.40,54.05
accept Two Halves Become One##5051 |goto Western Plaguelands 38.40,54.05
step
kill Jabbering Ghoul##10801
|tip Ghoul with a pitchfork.
|tip Walks around.
|tip Multiple spawn locations.
collect Good Luck Other-Half-Charm##12722 |n
use Good Luck Other-Half-Charm##12722
collect Good Luck Charm##12723 |q 5051/1 |goto Western Plaguelands 37.80,57.60
|mapmarker Western Plaguelands/0 36.20,57.40
|mapmarker Western Plaguelands/0 36.80,58.60
|mapmarker Western Plaguelands/0 37.20,55.40
|mapmarker Western Plaguelands/0 38.60,55.20
step
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Two Halves Become One##5051 |goto Western Plaguelands 38.40,54.05
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower Two |q 5097/2 |goto Western Plaguelands 42.44,66.27
step
use Beacon Torch##12815
|tip Tower entrance.
|tip Avoid the {o}elite enemy{} inside.
Mark Tower One |q 5097/1 |goto Western Plaguelands 40.13,71.52
step
talk Commander Ashlam Valorfist##10838
turnin All Along the Watchtowers##5097 |goto Western Plaguelands 42.70,84.03
accept Scholomance##5533 |goto Western Plaguelands 42.70,84.03
step
_Destroy This Item:_
|tip Not needed.
trash Beacon Torch##12815
step
talk Alchemist Arbington##11056
turnin Scholomance##5533 |goto Western Plaguelands/0 42.66,83.77
step
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5220 |goto Western Plaguelands 42.97,84.50
accept Target: Writhing Haunt##5222 |goto Western Plaguelands 42.97,84.50
step
talk Nathaniel Dumah##11616
accept A Plague Upon Thee##5903 |goto Western Plaguelands 43.42,84.84
step
talk Flint Shadowmore##12425
accept The Eastern Plagues##6185 |goto Western Plaguelands 43.61,84.51
step
kill Cauldron Lord Razarch##11076
collect Writhing Haunt Cauldron Key##13197 |q 5222/1 |goto Western Plaguelands 53.02,66.06
step
click Scourge Cauldron
turnin Target: Writhing Haunt##5222 |goto Western Plaguelands 53.02,65.72
accept Return to Chillwind Camp##5223 |goto Western Plaguelands 53.02,65.72
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
click Mangled Human Remains
|tip Human skeleton.
collect SI:7 Insignia (Turyen)##16002 |q 6185/3 |goto Eastern Plaguelands 24.28,63.65
step
Uncover the Blightcaller |q 6185/4 |goto Eastern Plaguelands 22.79,63.73
|tip Avoid the {o}elite enemies{} nearby.
step
click Mangled Human Remains
|tip Human skeleton.
|tip Avoid the {o}elite enemies{} nearby.
collect SI:7 Insignia (Fredo)##16001 |q 6185/2 |goto Eastern Plaguelands 22.79,63.73
step
click Mangled Human Remains
|tip Human skeleton.
collect SI:7 Insignia (Rutger)##16003 |q 6185/1 |goto Eastern Plaguelands 24.28,68.12
step
talk Pamela Redpath##10926
|tip Walks around.
|tip Inside the crumbled house.
turnin Little Pamela##5142 |goto Eastern Plaguelands 31.15,77.98
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
|tip Helps reach level 58 after quest turnins.
ding 57,189550 |goto Eastern Plaguelands/0 34.52,71.50
Ammo available at [Eastern Plaguelands/0 79.54,63.77]		|only if Hunter
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
kill 5 Plaguehound##8597 |q 5542/2 |goto Eastern Plaguelands/0 59.54,64.29
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
talk Caretaker Alen##11038
|tip Walks around.
accept Zaeldarr the Outcast##6021 |goto Eastern Plaguelands 69.92,53.64
accept The Restless Souls##5281 |goto Eastern Plaguelands 69.92,53.64
step
talk Duke Nicholas Zverenhoff##11039
turnin Duke Nicholas Zverenhoff##6030 |goto Eastern Plaguelands 71.62,50.09
step
talk Carlin Redpath##11063
turnin Uncle Carlin##5241 |goto Eastern Plaguelands 71.70,50.04
accept Defenders of Darrowshire##5211 |goto Eastern Plaguelands 71.70,50.04
step
talk Khaelyn Steelwing##12617
fpath Light's Hope Chapel |goto Eastern Plaguelands 71.80,49.60
stickystart "Kill_Frenzied_Plaguehounds"
stickystart "Free_Darrowshire_Spirits"
step
talk Aurora Skycaller##10304
turnin Troubled Spirits of Kel'Theril##5245 |goto Eastern Plaguelands 46.50,16.03
step
_Destroy This Item:_
|tip Not needed.
trash Jaron's Pick##12891
step
click Large Termite Mound##177464+
|tip Large stones leaking green ooze.
|tip Work your way west.
collect 100 Plagueland Termites##15043 |q 5903/1 |goto Eastern Plaguelands/0 39.65,26.93
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
stickystop "Kill_Frenzied_Plaguehounds"
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
label "Kill_Frenzied_Plaguehounds"
kill 5 Frenzied Plaguehound##8598 |q 5542/3 |goto Eastern Plaguelands 38.84,30.98
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
talk Loganaar##12042
Train Abilities |trainer Loganaar##12042 |goto Moonglade/0 52.53,40.57 |q 5223
|only if Druid
step
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5223 |goto Western Plaguelands 42.97,84.50
accept Target: Gahrron's Withering##5225 |goto Western Plaguelands 42.97,84.50
step
talk Alchemist Arbington##11056
accept Skeletal Fragments##5537 |goto Western Plaguelands 42.66,83.77
step
talk Flint Shadowmore##12425
turnin The Eastern Plagues##6185 |goto Western Plaguelands 43.61,84.51
accept The Blightcaller Cometh##6186 |goto Western Plaguelands 43.61,84.51
step
talk Nathaniel Dumah##11616
turnin A Plague Upon Thee##5903 |goto Western Plaguelands 43.42,84.84
accept A Plague Upon Thee##5904 |goto Western Plaguelands 43.42,84.84
step
_Destroy These Items:_
|tip Not needed.
trash Plagueland Termites##15043
stickystart "Collect_Skeletal_Fragments"
step
talk Marlene Redpath##10927
|tip Walks around.
|tip {o}Both floors{} inside the building.
turnin Auntie Marlene##5152 |goto Western Plaguelands 49.13,78.52
accept A Strange Historian##5153 |goto Western Plaguelands 49.13,78.52
step
click Joseph Redpath's Monument
collect Joseph's Wedding Ring##12894 |q 5153/1 |goto Western Plaguelands 49.68,76.77
step
label "Collect_Skeletal_Fragments"
kill Skeletal Flayer##1783, Skeletal Sorcerer##1784
collect 15 Skeletal Fragments##14619 |q 5537/1 |goto Western Plaguelands 50.80,79.40
|mapmarker Western Plaguelands/0 49.40,76.20
|mapmarker Western Plaguelands/0 49.40,82.80
|mapmarker Western Plaguelands/0 46.40,80.40
|mapmarker Western Plaguelands/0 54.20,80.40
step
talk Chromie##10667
|tip Upstairs inside the building.
turnin A Strange Historian##5153 |goto Western Plaguelands 39.45,66.76
accept The Annals of Darrowshire##5154 |goto Western Plaguelands 39.45,66.76
accept A Matter of Time##4971 |goto Western Plaguelands 39.45,66.76
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
use Temporal Displacer##12627
|tip Near large structures with blue lights.
kill 15 Temporal Parasite##10717 |q 4971/1 |goto Western Plaguelands 45.00,63.00
|tip Another can spawn when they die.
|mapmarker Western Plaguelands/0 47.40,66.40
|mapmarker Western Plaguelands/0 48.00,62.80
|mapmarker Western Plaguelands/0 49.20,68.40
|mapmarker Western Plaguelands/0 49.80,66.40
step
talk Chromie##10667
|tip Upstairs inside the building.
turnin The Annals of Darrowshire##5154 |goto Western Plaguelands 39.45,66.76
accept Brother Carlin##5210 |goto Western Plaguelands 39.45,66.76
turnin A Matter of Time##4971 |goto Western Plaguelands 39.45,66.76
accept Counting Out Time##4972 |goto Western Plaguelands 39.45,66.76
step
_Destroy These Items:_
|tip Not needed.
trash Ruined Tome##15696
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
talk Chromie##10667
|tip Upstairs inside the building.
turnin Counting Out Time##4972 |goto Western Plaguelands 39.45,66.76
step
talk Alchemist Arbington##11056
turnin Skeletal Fragments##5537 |goto Western Plaguelands/0 42.66,83.77
step
talk Carlin Redpath##11063
turnin Brother Carlin##5210 |goto Eastern Plaguelands/0 71.70,50.03
accept Villains of Darrowshire##5181 |goto Eastern Plaguelands/0 71.70,50.03
turnin Defenders of Darrowshire##5211 |goto Eastern Plaguelands/0 71.70,50.03
step
talk Jessica Chambers##16256
|tip Inside the building.
home Light's Hope Chapel |goto Eastern Plaguelands/0 71.80,48.52 |q 4808 |future
step
talk Caretaker Alen##11038
|tip Walks around.
turnin Zaeldarr the Outcast##6021 |goto Eastern Plaguelands 69.92,53.64
step
click Horgus' Skull##176208
|tip Underwater.
collect Skull of Horgus##12956 |q 5181/1 |goto Eastern Plaguelands/0 44.34,41.18
step
click Shattered Sword of Marduk##176209
collect Shattered Sword of Marduk##12957 |q 5181/2 |goto Eastern Plaguelands/0 46.86,55.43
stickystart "Kill_Diseased_Grizzlies"
step
kill Cauldron Lord Soulwrath##11078
|tip Walks around.
collect Gahrron's Withering Cauldron Key##13196 |q 5225/1 |goto Western Plaguelands 62.78,58.75
step
click Scourge Cauldron
turnin Target: Gahrron's Withering##5225 |goto Western Plaguelands 62.56,58.57
accept Return to Chillwind Point##5226 |goto Western Plaguelands 62.56,58.57
step
label "Kill_Diseased_Grizzlies"
kill 8 Diseased Grizzly##1816 |q 4985/1 |goto Western Plaguelands 59.80,60.20
|tip Shared spawns with spiders.
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
|mapmarker Western Plaguelands/0 66.40,51.00
|mapmarker Western Plaguelands/0 66.60,45.20
|mapmarker Western Plaguelands/0 67.80,48.00
step
talk Mulgris Deepriver##10739
|tip Inside the building.
turnin The Wildlife Suffers Too##4985 |goto Western Plaguelands 53.72,64.67
accept Glyphed Oaken Branch##4986 |goto Western Plaguelands 53.72,64.67
step
click Northridge Lumber Mill Crate
|tip Inside the building.
Select _"Place Termite Barrel on the crate."_ |gossip 97332
click Termite Barrel
|tip Appears on the crate.
turnin A Plague Upon Thee##5904 |goto Western Plaguelands 48.35,32.00
accept A Plague Upon Thee##6389 |goto Western Plaguelands 48.35,32.00
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
|tip Wait for him to come outside.
step
talk Kirsta Deepshadow##11610
turnin Unfinished Business##6023 |goto Western Plaguelands 51.92,28.06
step
talk Carlin Redpath##11063
turnin Villains of Darrowshire##5181 |goto Eastern Plaguelands/0 71.70,50.03
step
talk Nathaniel Dumah##11616
turnin A Plague Upon Thee##6389 |goto Western Plaguelands 43.42,84.83
step
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5226 |goto Western Plaguelands 42.97,84.50
step
talk Commander Ashlam Valorfist##10838
accept Mission Accomplished!##5237 |goto Western Plaguelands 42.70,84.03 |instant
step
talk Dink##7312
|tip Inside the building.
Train Abilities |trainer Dink##7312 |goto Ironforge/0 27.16,8.56 |q 6186
|only if Mage
step
talk Cenarion Emissary Jademoon##15187
accept Taking Back Silithus##8275 |goto Ironforge 58.54,47.32
step
talk Bilban Tosslespanner##5114
|tip Inside the building.
Train Abilities |trainer Bilban Tosslespanner##5114 |goto Ironforge/0 65.90,88.41 |q 6186
|only if Warrior
step
talk Regnus Thundergranite##5117
|tip Inside the building.
Train Abilities |trainer Regnus Thundergranite##5117 |goto Ironforge/0 69.87,82.90 |q 6186
|only if Hunter
step
talk Fenthwick##5167
|tip Inside the building.
Train Abilities |trainer Fenthwick##5167 |goto Ironforge/0 65.90,88.41 |q 6186
|only if Rogue
step
talk Briarthorn##5172
|tip Inside the building.
Train Abilities |trainer Briarthorn##5172 |goto Ironforge/0 50.35,5.66 |q 6186
|only if Warlock
step
talk Jubahl Corpseseeker##6382
|tip Buy available Grimoires.
|tip Inside the building.
Train Demon Abilities |vendor Jubahl Corpseseeker##6382 |goto Ironforge/0 50.35,5.66 |q 6186
|only if Warlock
step
talk Beldruk Doombrow##5148
|tip Inside the building.
Train Abilities |trainer Beldruk Doombrow##5148 |goto Ironforge/0 24.54,4.50 |q 6186
|only if Paladin
step
talk Toldren Deepiron##5143
|tip Inside the building.
Train Abilities |trainer Toldren Deepiron##5143 |goto Ironforge/0 25.21,10.74 |q 6186
|only if Priest
step
talk Ultham Ironhorn##4772
Train Ram Riding |learnspell Ram Riding##826 |goto Dun Morogh/0 63.94,50.10
Buy a mount from Veron Amberstill nearby at [Dun Morogh/0 63.47,50.56]
|only if Dwarf and discountgold('Ironforge',1000000)
step
talk Binjy Featherwhistle##7954
Train Mechanostrider Piloting |learnspell Mechanostrider Piloting##553 |goto Dun Morogh/0 49.15,48.13
Buy a mount from Milli Featherwhistle nearby at [Dun Morogh/0 49.13,47.95]
|only if Gnome and discountgold('Gnomeregan Exiles',1000000)
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Ironforge/0 76.86,51.19 |q 6186
|tip Walk into the portal.
step
Enter Stormwind City |complete zone("Stormwind City") |q 6186
|tip Ride the tram.
|tip Walk into the portal.
step
Enter Stormwind Keep |goto Stormwind City 73.07,46.69 < 15 |walk |only if not subzone("Stormwind Keep")
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The Blightcaller Cometh##6186 |goto Stormwind City 80.15,38.32
step
talk Randal Hunter##4732
Train Horse Riding |learnspell Horse Riding##824 |goto Elwynn Forest/0 84.32,64.87
Buy a mount from Katie Hunter nearby at [Elwynn Forest/0 84.15,65.49]
|only if Human and discountgold('Stormwind',1000000)
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Winterspring (58-59)",{
image=ZGV.IMAGESDIR.."Winterspring",
hardcore = true,
next="Leveling Guides\\Silithus (59-60)",
},[[
step
talk Azzleby##11119
Stable Your Pet |stablemaster Azzleby##11119 |goto Winterspring/0 60.39,37.92 |q 4808
|tip Taming a temporary pet soon.
|tip Learning {o}Claw (Rank 8){}.
|only if Hunter
step
Learn the {y}Claw (Rank 8){} Pet Ability |learnspell Claw##3666 |goto Winterspring/0 57.80,26.40 |q 4808
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
Retrieve Your Pet |stablemaster Azzleby##11119 |goto Winterspring/0 60.39,37.92 |q 4808
|tip Abandon your temporary pet.
|only if Hunter
step
Teach {y}Claw (Rank 8){} to Your Pet |learnpetspell Claw##3009 |q 4808
|tip Use {o}Beast Training{} ability.
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
bank Glyphed Oaken Branch##12663 |goto Winterspring/0 61.46,36.97 |q 4986
step
talk Felnok Steelspring##10468
turnin Felnok Steelspring##4808 |goto Winterspring 61.63,38.61
accept Chillwind Horns##4809 |goto Winterspring/0 61.63,38.61
step
talk Innkeeper Vizzie##11118
|tip Inside the building.
home Everlook |goto Winterspring 61.36,38.83 |q 5527 |future
step
talk Umi Rumplesnicker##10305
accept Are We There, Yeti?##3783 |goto Winterspring/0 60.88,37.62
stickystart "Collect_Uncracked_Chillwind_Horns"
step
kill Ice Thistle Yeti##7458, Ice Thistle Matriarch##7459, Ice Thistle Patriarch##7460
|tip Yetis.
|tip Inside and outside the cave.
collect 10 Thick Yeti Fur##12366 |q 3783/1 |goto Winterspring 67.65,41.75
|mapmarker Winterspring/0 64.20,39.80
|mapmarker Winterspring/0 64.40,41.80
|mapmarker Winterspring/0 65.80,44.80
|mapmarker Winterspring/0 69.20,40.00
|mapmarker Winterspring/0 71.40,40.40
step
Leave the cave |goto Winterspring 67.65,41.75 < 30 |walk |only if subzone("Ice Thistle Hills") and indoors()
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##3783 |goto Winterspring 60.88,37.62
accept Are We There, Yeti?##977 |goto Winterspring 60.88,37.62
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
step
Leave the cave |goto Winterspring 67.65,41.75 < 30 |walk |only if subzone("Ice Thistle Hills") and indoors()
Run up and over the mountain |goto Winterspring/0 65.83,38.46 < 30 |only if walking and not subzone("Winterfall Village")
kill 8 Winterfall Shaman##7439		|q 8464/1 |goto Winterspring/0 67.80,37.80
kill 8 Winterfall Den Watcher##7440	|q 8464/2 |goto Winterspring/0 67.80,37.80
kill 8 Winterfall Ursa##7438		|q 8464/3 |goto Winterspring/0 67.80,37.80
|mapmarker Winterspring/0 65.40,37.40
|mapmarker Winterspring/0 66.20,35.00
|mapmarker Winterspring/0 66.40,38.60
|mapmarker Winterspring/0 67.60,35.60
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
turnin Are We There, Yeti?##977 |goto Winterspring 60.88,37.62
accept Are We There, Yeti?##5163 |goto Winterspring 60.88,37.62
step
use Umi's Mechanical Yeti##12928
|tip On Legacki.
Scare Legacki |q 5163/1 |goto Winterspring 61.54,38.62
step
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto Winterspring/0 61.63,38.61
step
talk Izzy Coppergrab##13917
|tip Collect from the bank.
|tip Inside the building.
collect Glyphed Oaken Branch##12663	|goto Winterspring/0 61.46,36.97 |q 4986
collect Irontree Heart##11173		|goto Winterspring/0 61.46,36.97 |q 4084
collect 11 Silvery Claws##11172		|goto Winterspring/0 61.46,36.97 |q 4084
step
talk Salfa##11556
turnin Winterfall Activity##8464 |goto Winterspring 27.74,34.50			|only if not zone("Winterspring")
turnin Winterfall Activity##8464 |goto Winterspring 27.74,34.50 |notravel	|only if zone("Winterspring")
step
talk Sindrayl##10897
fpath Moonglade |goto Moonglade 48.10,67.34
step
talk Keeper Remulos##11832
turnin Seed of Life##7066 |goto Moonglade 36.18,41.79
|only if guideflag("Maraflag")
step
talk Rabine Saturna##11801
|tip Inside the building.
turnin Rabine Saturna##6762 |goto Moonglade 51.68,45.09
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
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Silver Heart##4084 |goto Felwood 51.35,81.51
accept Aquementas##4005 |goto Felwood 51.35,81.51
step
talk Mathrengyl Bearwalker##4217
|tip {o}Middle floor{} inside the building.
turnin Glyphed Oaken Branch##4986 |goto Darnassus/0 35.38,8.43
step
talk Jartsam##4753
Train Apprentice Riding |skillmax Riding,75 |goto Darnassus/0 38.69,15.84
Buy a mount from Lelanai nearby at [Darnassus/0 38.28,15.36]
|only if NightElf and discountgold('Darnassus',1000000)
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
turnin Taking Back Silithus##8275 |goto Silithus 51.15,38.29
accept Securing the Supply Lines##8280 |goto Silithus 51.15,38.29
step
talk Cloud Skydancer##15177
|tip Top of the path.
fpath Cenarion Hold |goto Silithus/0 50.58,34.45
step
talk Geologist Larksbane##15183
accept The Twilight Mystery##8284 |goto Silithus 49.67,37.46
step
talk Bor Wildmane##15306
accept Secret Communication##8318 |goto Silithus 48.57,37.78
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
ding 60 |goto Felwood 62.40,12.60
Turn in Feathers at [64.77,8.13]
|mapmarker Felwood/0 60.00,6.60
|mapmarker Felwood/0 60.40,8.60
|mapmarker Felwood/0 61.40,10.80
|mapmarker Felwood/0 62.40,7.60
|mapmarker Felwood/0 63.60,9.60
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
accept Field Duty##8507 |goto Silithus 49.98,36.34
step
use the Unsigned Field Duty Papers##21143
collect 1 Prepared Field Duty Papers##23024 |q 8507
step
talk Captain Blackanvil##15440
accept Field Duty Papers##8508 |goto Silithus 32.96,52.08
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
accept Field Duty##8507 |goto Silithus 49.98,36.34
step
use the Unsigned Field Duty Papers##21143
collect 1 Prepared Field Duty Papers##23024 |q 8507
step
talk Captain Blackanvil##15440
accept Field Duty Papers##8508 |goto Silithus 32.96,52.08
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
|tip There are elite enemies around this area. |only if hardcore()
|tip It's adviced to venture into these areas with a group when possible. |only if hardcore()
talk Cenarion Scout Azenel##15610
Select _"I'm here to retrieve your report."_
collect Hive'Zora Scout Report##21158 |q 8534/1 |goto Silithus 23.63,62.43
|only if haveq(8534)
step
Enter the cave |goto Silithus 54.88,88.05 < 20 |walk
Follow the path down |goto Silithus 53.57,88.96 < 10 |walk
Follow the path down |goto Silithus 53.12,93.24 < 10 |walk
|tip There are elite enemies around this area. |only if hardcore()
|tip It's adviced to venture into these areas with a group when possible. |only if hardcore()
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
accept Field Duty##8507 |goto Silithus 49.98,36.34
step
use the Unsigned Field Duty Papers##21143
collect 1 Prepared Field Duty Papers##23024 |q 8507
step
talk Captain Blackanvil##15440
accept Field Duty Papers##8508 |goto Silithus 32.96,52.08
step
collect 1 Signed Field Duty Papers##20810 |q 8507/1
step
talk Windcaller Kaldon##15540
|tip Choose a logistics assignment.
|tip Logistics Assignments require you to donate various materials to the Cenarion effort.
turnin Field Duty##8507 |goto Silithus 49.98,36.34
step
label "Begin_Logistics_Assignment"
use the Logistics Assignment##21132
Open the Logistics Assignment |complete itemcount(21132) == 0
step
use the Logistics Task Briefing IV##21257
accept The Ironforge Brigade Needs Explosives!##8778
|only if itemcount(21257) >= 1 or haveq(8778)
step
use the Logistics Task Briefing V##21259
accept Scrying Materials##8779
|only if itemcount(21259) >= 1 or haveq(8779)
step
use the Logistics Task Briefing VI##21260
accept Arms for the Field##8781
|only if itemcount(21260) >= 1 or haveq(8781)
step
use the Logistics Task Briefing VII##21263
accept Armor Kits for the Field##8780
|only if itemcount(21263) >= 1 or haveq(8780)
step
use the Logistics Task Briefing X##20806
accept Bandages for the Field##8496
|only if itemcount(20806) >= 1 or haveq(8496)
stickystart "Collect_5_Goblin_Rocket_Fuel"
stickystart "Collect_10_Dense_Blasting_Powder"
step
collect 6 Oil of Immolation##8956 |q 8778/1
|tip Craft them with Alchemy or purchase them from the Auction House. |only if not selfmade()
|tip You can create them with Alchemy. |only if selfmade()
|tip Each one requires 1 Firebloom, 1 Goldthorn, and 1 Crystal Vial to create.
|only if haveq(8778)
step
label "Collect_5_Goblin_Rocket_Fuel"
collect 5 Goblin Rocket Fuel##9061 |q 8778/2
|tip Craft them with Alchemy or purchase them from the Auction House. |only if not selfmade()
|tip You can create them with Alchemy. |only if selfmade()
|tip Each one requires 1 Firebloom, 1 Volatile Rum, and 1 Leaded Vial to create.
|only if haveq(8778)
step
label "Collect_10_Dense_Blasting_Powder"
collect 10 Dense Blasting Powder##15992 |q 8778/3
|tip Craft them with Engineering or purchase them from the Auction House.
|tip Each one requires 2 Dense Stone to create.
|only if haveq(8778)
stickystart "Collect_1_Large_Radiant_Shard"
stickystart "Collect_1_Huge_Emerald"
step
collect 1 Large Brilliant Shard##14344 |q 8779/1
|tip Disenchant item level 56-65 rare items or purchase it from the Auction House. |only if not selfmade()
|tip Disenchant item level 56-65 rare items. |only if selfmade()
|tip Blackrock Depths and Dire Maul are good sources for these items.
|only if haveq(8779)
step
label "Collect_1_Large_Radiant_Shard"
collect 1 Large Radiant Shard##11178 |q 8779/2
|tip Disenchant item level 46-50 rare items or purchase it from the Auction House. |only if not selfmade()
|tip Disenchant item level 46-50 rare items. |only if selfmade()
|tip Zul'Farrak, Dire Maul, and Stratholme are good sources for these items.
|only if haveq(8779)
step
label "Collect_1_Huge_Emerald"
collect 1 Huge Emerald##12364 |q 8779/3
|tip Gather it with Mining or purchase it from the Auction House. |only if not selfmade()
|tip Gather it with Mining. |only if selfmade()
|tip It can be mined from any type of Thorium vein.
|only if haveq(8779)
step
collect 2 Moonsteel Broadsword##3853 |q 8781/1
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 8 Steel Bars, 2 Strong Flux, 2 Heavy Grinding Stones, 3 Moonstone, and 3 Heavy Leather to create.
|only if haveq(8781)
stickystart "Collect_8_Heavy_Armor_Kits"
step
collect 8 Rugged Armor Kit##15564 |q 8780/1
|tip Craft them with Leatherworking or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Leatherworking. |only if selfmade()
|tip Each one requires 5 Rugged Leather to create.
|only if haveq(8780)
step
label "Collect_8_Heavy_Armor_Kits"
collect 8 Heavy Armor Kit##4265 |q 8780/2
|tip Craft them with Leatherworking or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Leatherworking. |only if selfmade()
|tip Each one requires 5 Heavy Leather and 1 Fine Thread to create.
|only if haveq(8780)
stickystart "Collect_30_Heavy_Mageweave_Bandage"
stickystart "Collect_30_Heavy_Silk_Bandage"
step
collect 30 Heavy Runecloth Bandage##14530 |q 8496/1
|tip Craft them with First Aid or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with First Aid. |only if selfmade()
|tip Each one requires 2 Runecloth to create.
|only if haveq(8496)
step
label "Collect_30_Heavy_Mageweave_Bandage"
collect 30 Heavy Mageweave Bandage##8545 |q 8496/2
|tip Craft them with First Aid or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with First Aid. |only if selfmade()
|tip Each one requires 2 Mageweave Cloth to create.
|only if haveq(8496)
step
label "Collect_30_Heavy_Silk_Bandage"
collect 30 Heavy Silk Bandage##6451 |q 8496/3
|tip Craft them with First Aid or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with First Aid. |only if selfmade()
|tip Each one requires 2 Silk Cloth to create.
|only if haveq(8496)
step
talk Geologist Larksbane##15183
turnin Scrying Materials##8779 |goto Silithus 49.67,37.35 |next "Open_Followup_Logistics_Assignment"
|only if haveq(8779)
step
talk Windcaller Proudhorn##15191
turnin Bandages for the Field##8496 |goto Silithus 51.15,38.29 |next "Open_Followup_Logistics_Assignment"
|only if haveq(8496)
step
talk Arcanist Nozzlespring##15444
turnin The Ironforge Brigade Needs Explosives!##8778 |goto Silithus 32.54,52.03 |next "Open_Followup_Logistics_Assignment"
|only if haveq(8778)
step
talk Janela Stouthammer##15443
turnin Arms for the Field##8781 |goto Silithus 32.88,52.53 |next "Open_Followup_Logistics_Assignment" |only if haveq(8781)
turnin Armor Kits for the Field##8780 |goto Silithus 32.88,52.53 |next "Open_Followup_Logistics_Assignment" |only if haveq(8780)
|only if haveq(8781,8780)
step
label "Open_Followup_Logistics_Assignment"
use the Followup Logistics Assignment##20805
Open the Followup Logistics Assignment |complete itemcount(20805) == 0
step
use the Logistics Task Briefing I##20807
accept Desert Survival Kits##8497
|only if itemcount(20807) >= 1 or haveq(8497)
step
use the Logistics Task Briefing II##20939
accept Boots for the Guard##8805
|only if itemcount(20939) >= 1 or haveq(8805)
step
use the Logistics Task Briefing III##20940
accept Grinding Stones for the Guard##8541
|only if itemcount(20940) >= 1 or haveq(8541)
step
use the Logistics Task Briefing VIII##21262
accept Uniform Supplies##8782
|only if itemcount(21262) >= 1 or haveq(8782)
step
use the Logistics Task Briefing IX##21265
accept Extraordinary Materials##8783
|only if itemcount(21265) >= 1 or haveq(8783)
step
use the Logistics Task Briefing XI##21514
accept The Ultimate Deception##8829
|only if itemcount(21514) >= 1 or haveq(8829)
stickystart "Collect_Powerful_Anti-Venom"
stickystart "Collect_Smoked_Desert_Dumplings"
step
kill Toxic Horror##7132+
collect 4 Globe of Water##7079 |q 8497/1 |goto Felwood 48.75,24.16
|tip You can also purchase these from the Auction House. |only if not selfmade()
|only if haveq(8497)
step
label "Collect_Powerful_Anti-Venom"
collect 4 Powerful Anti-Venom##19440 |q 8497/2
|tip Craft them with First Aid or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with First Aid. |only if selfmade()
|tip Each one requires 1 Huge Venom Sac to create.
|only if haveq(8497)
step
label "Collect_Smoked_Desert_Dumplings"
collect 4 Smoked Desert Dumplings##20452 |q 8497/3
|tip Craft them with Cooking or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Cooking. |only if selfmade()
|tip Each one requires 1 Sandworm Meat and 1 Soothing Spices to create.
|only if haveq(8497)
step
collect 3 Ornate Mithril Boots##7936 |q 8805/1
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 14 Mithril Bars, 2 Truesilver Bars, 4 Thick Leather, 1 Solid Grinding Stone, and 1 Aquamarine to create.
|only if haveq(8805)
stickystart "Collect_Solid_Grinding_Stone"
stickystart "Collect_Heavy_Grinding_Stone"
step
collect 10 Dense Grinding Stone##12644 |q 8541/1
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 4 Dense Stone to create.
|only if haveq(8541)
step
label "Collect_Solid_Grinding_Stone"
collect 10 Solid Grinding Stone##7966 |q 8541/2
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 4 Solid Stone to create.
|only if haveq(8541)
step
label "Collect_Heavy_Grinding_Stone"
collect 10 Heavy Grinding Stone##3486 |q 8541/3
|tip Craft them with Blacksmithing or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Blacksmithing. |only if selfmade()
|tip Each one requires 3 Heavy Stone to create.
|only if haveq(8541)
stickystart "Collect_Bolt_of_Runecloth"
stickystart "Collect_Ironweb_Spider_Silk"
step
collect 1 Mooncloth##14342 |q 8782/1
|tip Craft it with Tailoring or purchase it from the Auction House. |only if not selfmade()
|tip Craft them with Tailoring. |only if selfmade()
|tip It requires 2 Felcloth and a daily Tailoring cooldown to create.
|only if haveq(8782)
step
label "Collect_Bolt_of_Runecloth"
collect 2 Bolt of Runecloth##14048 |q 8782/2
|tip Craft them with Tailoring or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Tailoring. |only if selfmade()
|tip Each one requires 5 Runecloth to create.
|only if haveq(8782)
step
label "Collect_Ironweb_Spider_Silk"
kill Plague Lurker##1824+
collect 1 Ironweb Spider Silk##14227 |q 8782/3 |goto Western Plaguelands 62.20,49.48
|tip You can also purchase it from the Auction House. |only if not selfmade()
|only if haveq(8782)
stickystart "Collect_Enchanted_Leather"
step
collect 10 Enchanted Thorium Bar##12655 |q 8783/1
|tip Craft them with Enchanting or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Enchanting. |only if selfmade()
|tip Each one requires 1 Thorium Bar and 3 Dream Dust to create.
|only if haveq(8783)
step
label "Collect_Enchanted_Leather"
collect 10 Solid Grinding Stone##12810 |q 8783/2
|tip Craft them with Enchanting or purchase them from the Auction House. |only if not selfmade()
|tip Craft them with Enchanting. |only if selfmade()
|tip Each one requires 1 Rugged Leather and 1 Lesser Eternal Essence to create.
|only if haveq(8783)
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
turnin Desert Survival Kits##8497 |goto Silithus 51.87,39.14
|only if haveq(8497)
step
talk Vish Kozus##15182
|tip At the top of the tower.
turnin Grinding Stones for the Guard##8541 |goto Silithus 50.75,33.65 |only if haveq(8541)
turnin Boots for the Guard##8805 |goto Silithus 50.75,33.65 |only if haveq(8805)
|only if haveq(8541,8805)
step
talk Windcaller Proudhorn##15191
turnin Uniform Supplies##8782 |goto Silithus 51.15,38.29
|only if haveq(8782)
step
talk Vargus##15176
turnin Extraordinary Materials##8783 |goto Silithus 51.23,38.86
|only if haveq(8783)
step
talk Aurel Goldleaf##15282
turnin The Ultimate Deception##8829 |goto Silithus 51.96,38.15
|only if haveq(8829)
step
collect 1 Logistics Assignment##21132 |next "Begin_Logistics_Assignment"
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Druid Class Quests",{
description="This guide will walk you through completing various Druid Class Quests.",
},[[
step
ding 10
step
talk Denatharion##4218
accept Heeding the Call##5923 |goto Darnassus/0 34.77,7.36
|only if NightElf Druid and (not completedq(5921)) and (not haveq(5921))
step
Follow the road |goto Darnassus/0 54.81,58.48 < 30 |only if walking
Enter Darnassus |goto Darnassus/0 36.06,54.39 < 20 |only if walking
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Heeding the Call##5923 |goto Darnassus 35.38,8.41
accept Moonglade##5921 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Moonglade##5921 |goto Moonglade 56.21,30.64
accept Great Bear Spirit##5929 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
Follow the path |goto Moonglade 42.47,34.44 < 20 |only if walking
talk Great Bear Spirit##11956
Select _"What do you represent, spirit?"_ |gossip 97167
Select _"I seek to understand the importance of strength of the body."_ |gossip 97129
Select _"I seek to understand the importance of strength of the heart."_ |gossip 97168
Select _"I have heard your words, Great Bear Spirit, and I understand.  I now seek your blessings to fully learn the way of the Claw."_ |gossip 95968
Seek Out the Great Bear Spirit and Learn what it Has to Share with You About the Nature of the Bear |q 5929/1 |goto Moonglade 39.11,27.51
|only if NightElf Druid
step
Enter the building |goto Moonglade 56.13,30.98 < 15 |walk
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Great Bear Spirit##5929 |goto Moonglade 56.21,30.64
accept Back to Darnassus##5931 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
talk Sindrayl##10897
fpath Moonglade |goto Moonglade 48.10,67.34
|only if NightElf Druid
step
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Back to Darnassus##5931 |goto Darnassus 35.38,8.41
accept Body and Heart##6001 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
Enter the cave |goto Darkshore 43.06,45.55 < 15 |walk
use the Cenarion Moondust##15208
|tip Inside the cave.
kill Lunaclaw##12138
|tip This enemy is level 12. |only if hardcore()
|tip The area is surrounded by level 13 enemies. |only if hardcore()
|tip The Owlbear enemies around here aggro from quite a bit away, so it may be safe to level up to 11 or even 12 before attempting the quest. |only if hardcore()
talk Lunaclaw Spirit##12144
Select _"You have fought well, spirit.  I ask you to grant me the strength of your body and the stength of your heart."_ |gossip 97127
Face Lunaclaw and Earn the Strength of Body and Heart it Possesses |q 6001/1 |goto Darkshore 43.48,45.96
|only if NightElf Druid
step
Leave the cave |goto Darkshore 42.97,45.44 < 15 |walk
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Body and Heart##6001 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
ding 14
step
collect 5 Earthroot##2449 |q 6123 |future
|tip You can gather these with the Herbalism Profession.
|tip Refer to the Earthroot Gathering Guide to accomplish this.
|tip You can also purchase them from the Auction House. |only if not selfmade()
step
Enter the building |goto Darnassus 35.52,10.72 < 7 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
accept Lessons Anew##6121 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
cast Teleport: Moonglade##18960
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Lessons Anew##6121 |goto Moonglade 56.21,30.64
accept The Principal Source##6122 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
Follow the road |goto Darkshore 40.33,46.35 < 30 |only if walking
Follow the path |goto Darkshore 46.41,32.14 < 30 |only if walking
Follow the path up |goto Darkshore 54.64,31.76 < 20 |only if walking
use the Empty Cliffspring Falls Sampler##15844
|tip At the entrance of the cave.
|tip There may be around 4 naga around the cave entrance. |only if hardcore()
|tip Pull them carefully before attempting to fill the sampler. |only if hardcore()
|tip Stormscale Sirens are ranged attackers that may heal. |only if hardcore()
|tip Enemies around here may run away in fear when at low health. |only if hardcore()
collect Filled Cliffspring Falls Sampler##15845 |q 6122/1 |goto Darkshore 54.93,33.32
|only if NightElf Druid
step
Follow the road |goto Darkshore 47.10,26.84 < 30 |only if walking
Follow the path |goto Darkshore 42.21,42.33 < 30 |only if walking
Enter the building |goto Darkshore 37.77,41.36 < 10 |walk
talk Alanndarian Nightsong##3702
|tip Inside the building.
turnin The Principal Source##6122 |goto Darkshore 37.69,40.66
accept Gathering the Cure##6123 |goto Darkshore 37.69,40.66
|only if NightElf Druid
step
Leave the building |goto Darkshore 37.77,41.36 < 10 |walk
Follow the road |goto Darkshore 40.04,46.77 < 30 |only if walking
click Lunar Fungal Bloom##177750+
|tip They look like clusters of small white-spotted mushrooms on the ground inside the small caves around this area.
|tip Watch for respawns while in the area. |only if hardcore()
|tip Owlbear enemies around here have an abnormal aggro radius. |only if hardcore()
collect 12 Lunar Fungus##15851 |q 6123/2 |goto Darkshore 43.07,45.55
You can find more small caves at: |notinsticky
[43.07,49.24]
[43.38,50.50]
[42.71,52.28]
[45.22,53.45]
[46.30,45.56]
[45.52,50.24]
|only if NightElf Druid
step
Follow the road |goto Darkshore 39.93,46.07 < 30 |only if walking
Enter the building |goto Darkshore 37.77,41.36 < 10 |walk
talk Alanndarian Nightsong##3702
|tip Inside the building.
turnin Gathering the Cure##6123 |goto Darkshore 37.69,40.66
accept Curing the Sick##6124 |goto Darkshore 37.69,40.66
|only if NightElf Druid
step
_Destroy This Item:_
|tip It is no longer needed.
trash Lunar Fungus##15851
|only if itemcount(15851) > 0
step
Leave the building |goto Darkshore 37.77,41.34 < 10 |walk
Follow the road |goto Darkshore 39.55,45.39 < 30 |only if walking
use the Curative Animal Salve##15826
|tip Use it on Sickly Deer around this area.
|tip They look like green diseased deer in areas with trees.
|tip They are spread out all throughout Darkshore.
Cure #10# Sickly Deer |q 6124/1 |goto Darkshore 41.51,46.08
|only if NightElf Druid
step
cast Teleport: Moonglade##18960
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Curing the Sick##6124 |goto Moonglade 56.21,30.64
accept Power over Poison##6125 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
Enter the building |goto Darnassus 35.52,10.72 < 7 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Power over Poison##6125 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
ding 16
step
Enter the building |goto Darnassus 35.49,10.63 < 7 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
accept A Lesson to Learn##26 |goto Darnassus 35.37,8.39
|only if NightElf Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin A Lesson to Learn##26 |goto Moonglade 56.21,30.64
accept Trial of the Lake##29 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
click Bauble Container
|tip It looks like a wicker basket vase on the ground underwater.
|tip They spawn randomly, so you may have to search around this area.
|tip Don't linger in the water for any reason. |only if hardcore()
collect Shrine Bauble##15877 |goto Moonglade 54.33,55.65 |q 29 |future
|only if NightElf Druid
step
use the Shrine Bauble##15877
Complete the Trial of the Lake |q 29/1 |goto Moonglade 35.92,41.38
|only if NightElf Druid
step
talk Tajarri##11799
turnin Trial of the Lake##29 |goto Moonglade 36.51,40.11
accept Trial of the Sea Lion##272 |goto Moonglade 36.51,40.11
|only if NightElf Druid
step
Follow the road |goto Darkshore 40.23,46.41 < 30 |only if walking
Follow the path |goto Darkshore 48.43,24.86 < 30 |only if walking
click Strange Lockbox
|tip Underwater.
|tip If you fight enemies around here, make sure you do so above water. |only if hardcore()
collect Half Pendant of Aquatic Agility##15883 |goto Darkshore 48.87,11.32 |q 272
|only if NightElf Druid
step
click Strange Lockbox
|tip Underwater.
|tip If you fight enemies around here, make sure you do so above water. |only if hardcore()
|tip You should wait until you quest into Loch Modan to do this portion of the quest. |only if hardcore()
collect Half Pendant of Aquatic Endurance##15882 |goto Westfall 17.87,33.11 |q 272
|only if NightElf Druid
step
use the Half Pendant of Aquatic Agility##15883
collect Pendant of the Sea Lion##15885 |q 272/1 |goto Moonglade 35.92,41.42
|only if NightElf Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Trial of the Sea Lion##272 |goto Moonglade 56.21,30.64
accept Aquatic Form##5061 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
Enter the building |goto Darnassus 35.49,10.63 < 7 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Aquatic Form##5061 |goto Darnassus 35.37,8.39
|only if NightElf Druid
step
ding 52
step
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
accept Torwa Pathfinder##9063|goto Darnassus 35.38,8.41
|only if NightElf Druid
step
talk Torwa Pathfinder##9619
turnin Torwa Pathfinder##9063 |goto Un'Goro Crater 71.63,75.96
accept Bloodpetal Poison##9052 |goto Un'Goro Crater 71.63,75.96
|only if NightElf Druid
step
Kill Gorishi enemies around this area
|tip Gorishi Workers may call for help when at low health. |only if hardcore() |notinsticky
|tip Watch for patrols and respawns while in the cave. 	|only if hardcore() |notinsticky
collect 8 Gorishi Sting##22435 |q 9052/1 |goto Un'Goro Crater 50.40,78.60
|only if NightElf Druid
step
click Bloodcap
|tip They look like vines entwined in a ball.
|tip They are all over Un'Goro Crater.
collect 8 Bloodcap##22434 |q 9052/2 |goto Un'Goro Crater 71.90,57.40
You Can Find More Around [53.50,14.90]
[34.60,30.60]
|only if NightElf Druid
step
talk Torwa Pathfinder##9619
turnin Bloodpetal Poison##9052 |goto Un'Goro Crater 71.63,75.96
accept Toxic Test##9051 |goto Un'Goro Crater 71.63,75.96
|only if NightElf Druid
step
use the Devilsaur Barb##22432
|tip Use it on roaming Devilsaur around Un'Goro Crater.
|tip Root the Devisaur before trying to use the Barb and run away after you accomplish this. |only if hardcore()
Stab a Devilsaur with the Barb |q 9051/1 |goto Un'Goro Crater 67.31,33.89
|only if NightElf Druid
step
talk Torwa Pathfinder##9619
turnin Toxic Test##9051 |goto Un'Goro Crater 71.63,75.96
accept A Better Ingredient##9053 |goto Un'Goro Crater 71.63,75.96
|only if NightElf Druid
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 9053
|only if NightElf Druid and hardcore()
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
|only if NightElf Druid
step
Inside the Temple of Atal'Hakkar Dungeon:
kill Atal'alarion##8580
|tip Refer to the Temple of Atal'Hakkar Dungeon Guide to accomplish that.
collect Putrid Vine##22444 |q 9053/1
|only if NightElf Druid
step
Leave the Temple of Atal'Hakkar Dungeon
Click Here to Continue |confirm |q 9053 |future
|only if NightElf Druid
step
talk Torwa Pathfinder##9619
turnin A Better Ingredient##9053 |goto Un'Goro Crater 71.63,75.96
|only if NightElf Druid
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Priest Class Quests",{
description="This guide will walk you through completing various Priest Class Quests.",
},[[
step
ding 10
step
Enter the building |goto Dun Morogh 46.95,52.05 < 7 |walk
talk Maxan Anvol##1226
|tip Inside the building.
accept Desperate Prayer##5637 |goto Dun Morogh 47.34,52.18
|only if Dwarf Priest
step
Enter the building |goto Stormwind City 52.98,51.14 < 7 |walk
talk High Priestess Laurena##376
|tip Inside the building.
turnin Desperate Prayer##5637 |goto Stormwind City 49.53,44.57
|only if Dwarf Priest
step
Enter the building |goto Elwynn Forest 42.95,65.64 < 7 |walk
talk Priestess Josetta##377
|tip Upstairs inside the building.
accept Desperate Prayer##5637 |goto Elwynn Forest 43.29,65.72
|only if Human Priest
step
Enter the building |goto Stormwind City 52.98,51.14 < 7 |walk
talk High Priestess Laurena##376
|tip Inside the building.
turnin Desperate Prayer##5637 |goto Stormwind City 49.53,44.57
|only if Human Priest
step
Enter the building |goto Teldrassil 55.76,57.24 < 7 |walk
talk Laurna Morninglight##3600
|tip Inside the building.
accept Returning Home##5629 |goto Teldrassil 55.57,56.75
|only if NightElf Priest
step
talk Priestess Alathea##11401
|tip Upstairs inside the building.
turnin Returning Home##5629 |goto Darnassus 39.53,81.18
|only if NightElf Priest
step
ding 20
step
talk High Priest Rohan##11406
|tip Inside the building.
accept A Lack of Fear##5641 |goto Ironforge 24.72,8.14
turnin A Lack of Fear##5641 |goto Ironforge 24.72,8.14
|only if Dwarf Priest
step
Enter the building |goto Stormwind City 52.98,51.14 < 7 |walk
talk High Priestess Laurena##376
|tip Inside the building.
accept Arcane Feedback##5676 |goto Stormwind City 49.53,44.57
turnin Arcane Feedback##5676 |goto Stormwind City 49.53,44.57
|only if Human Priest
step
talk Priestess Alathea##11401
|tip Upstairs inside the building.
accept Elune's Grace##5672 |goto Darnassus 39.53,81.18
turnin Elune's Grace##5672 |goto Darnassus 39.53,81.18
|only if NightElf Priest
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Warrior Class Quests",{
description="This guide will walk you through completing various Warrior Class Quests.",
},[[
step
ding 10
step
talk Lyria Du Lac##913
accept A Warrior's Training##1638 |goto Elwynn Forest 41.09,65.77 |or
'|complete completedq(1679) |or
|only if Human Warrior
step
Enter the building |goto Stormwind City 75.08,55.33 < 7 |walk
talk Harry Burlguard##6089
|tip Inside the building.
turnin A Warrior's Training##1638 |goto Stormwind City 77.13,53.27
accept Bartleby the Drunk##1639 |goto Stormwind City 77.13,53.27 |or
'|complete completedq(1678) |or
|only if Human Warrior
step
talk Bartleby##6090
|tip He walks around this area inside the building.
turnin Bartleby the Drunk##1639 |goto Stormwind City 76.80,53.20
accept Beat Bartleby##1640 |goto Stormwind City 76.80,53.20 |or
'|complete completedq(1678) |or
|tip He will attack you immediately after you accept this quest.
|only if Human Warrior
step
talk Bartleby##6090
|tip He walks around this area inside the building.
turnin Beat Bartleby##1640 |goto Stormwind City 76.80,53.20
accept Bartleby's Mug##1665 |goto Stormwind City 76.80,53.20
|only if Human Warrior
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin Bartleby's Mug##1665 |goto Stormwind City 77.13,53.27
|only if Human Warrior
step
talk Granis Swiftaxe##1229
|tip Inside the building.
accept Muren Stormpike##1679 |goto Dun Morogh 47.36,52.65 |or
'|complete completedq(1638) |or
|only if (Dwarf Warrior) or (Gnome Warrior)
step
talk Muren Stormpike##6114
|tip Upstairs inside the building.
turnin Muren Stormpike##1679 |goto Ironforge 70.78,90.27
accept Vejrek##1678 |goto Ironforge 70.78,90.27 |or
'|complete completedq(1665) |or
|only if (Dwarf Warrior) or (Gnome Warrior)
step
Follow the path up |goto Dun Morogh 27.97,56.18 < 20 |only if walking
kill Vejrek##6113
|tip Inside the hut.
collect Vejrek's Head##6799 |q 1678/1 |goto Dun Morogh 27.83,57.95 |or
'|complete completedq(1665)
|only if (Dwarf Warrior) or (Gnome Warrior)
step
talk Muren Stormpike##6114
|tip Upstairs inside the building.
turnin Vejrek##1678 |goto Ironforge/0 70.78,90.29 |or
'|complete completedq(1665)
|only if (Dwarf Warrior) or (Gnome Warrior)
step
talk Kyra Windblade##3598
accept Elanaria##1684 |goto Teldrassil 56.22,59.19
|only if NightElf Warrior
step
talk Elanaria##4088
turnin Elanaria##1684 |goto Darnassus 57.29,34.61
accept Vorlus Vilehoof##1683 |goto Darnassus 57.29,34.61
|only if NightElf Warrior
step
Follow the path |goto Teldrassil 48.78,61.64
Follow the path up |goto Teldrassil 49.02,63.24
Continue up the path |goto Teldrassil 47.98,64.47
kill Vorlus Vilehoof##6128
collect Horn of Vorlus##6805 |q 1683/1 |goto Teldrassil 47.26,63.52
|only if NightElf Warrior
step
talk Elanaria##4088
turnin Vorlus Vilehoof##1683 |goto Darnassus 57.29,34.61
|only if NightElf Warrior
step
ding 30
step
_NOTE:_
Incoming Difficult Quest
|tip You're going to be tasked with surviving the Affray, which is a combat trial.
|tip You'll be tasked with killing waves of enemies with very little downtime afforded in between.
|tip If possible, you may want to get help for this.
Click Here to Continue |confirm |q 1718 |future
|only if Warrior and hardcore()
step
Enter the building |goto Stormwind City 80.00,61.72 < 7 |walk
talk Wu Shen##5479
|tip Upstairs inside the building.
accept The Islander##1718 |goto Stormwind City 80.55,59.87
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
|tip Avoid using AoE abilities as they may aggro the other affray contestants. |only if hardcore()
|tip When you defeat an enemy, don't stand near the grate or it will force the next opponent. |only if hardcore()
|tip Eat or Bandage after each opponent. |only if hardcore()
|tip Step back after each opponent spawns. |only if hardcore()
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
_NOTE:_
Incoming Difficult Quest
|tip "The Summoning" quest coming up after Cyclonian has you facing a level 40 elite enemy.
|tip You will likely need help with this.
Click Here to Continue |confirm |q 1713 |future
|only if Warrior and hardcore()
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
|tip This is a level 40 Elite enemy. |only if hardcore()
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
Enter the building |goto Stormwind City 80.00,61.72 < 7 |walk
talk Wu Shen##5479
|tip Upstairs inside the building.
accept A Troubled Spirit##8417 |goto Stormwind City 80.55,59.87
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
|tip Watch for patrols and respawns around this area. |only if hardcore()
|only if Warrior
step
label "Kill_Shadowsworn_Cultitst"
kill 10 Shadowsworn Cultist##6004 |q 8424/2 |goto Blasted Lands 65.17,32.83
|tip Watch for patrols and respawns around this area. |only if hardcore() |notinsticky
|only if Warrior
step
label "Kill_Shadowsworn_Thug"
kill 20 Shadowsworn Thug##6005 |q 8424/3 |goto Blasted Lands 65.17,32.83
|tip Watch for patrols and respawns around this area. |only if hardcore() |notinsticky
|only if Warrior
step
talk Fallen Hero of the Horde##7572
turnin War on the Shadowsworn##8424 |goto Swamp of Sorrows 34.29,66.15
accept Voodoo Feathers##8425 |goto Swamp of Sorrows 34.29,66.15
|only if Warrior
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 9053
|only if Warrior and hardcore()
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
talk Dazalar##3601
accept Taming the Beast##6063 |goto Teldrassil 56.68,59.49
|only if NightElf Hunter
step
use the Taming Rod##15921
|tip Use it on a Webwood Lurker around this area.
Tame a Webwood Lurker |q 6063/1 |goto Teldrassil 59.81,59.06
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
|only if NightElf Hunter
step
talk Dazalar##3601
turnin Taming the Beast##6063 |goto Teldrassil 56.68,59.49
accept Taming the Beast##6101 |goto Teldrassil 56.68,59.49
|only if NightElf Hunter
step
use the Taming Rod##15922
|tip Use it on a Nightsaber Stalker around this area.
Tame a Nightsaber Stalker |q 6101/1 |goto Teldrassil 55.95,71.98
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
|only if NightElf Hunter
step
talk Dazalar##3601
turnin Taming the Beast##6101 |goto Teldrassil 56.68,59.49
accept Taming the Beast##6102 |goto Teldrassil 56.68,59.49
|only if NightElf Hunter
step
Follow the road |goto Teldrassil 54.81,58.48 < 30 |only if walking
use the Taming Rod##15923
|tip Use it on a Strigid Screecher around this area.
Tame a Strigid Screecher |q 6102/1 |goto Teldrassil 43.99,51.16
|only if NightElf Hunter
step
Follow the road |goto Teldrassil 45.10,49.62 < 30 |only if walking
talk Dazalar##3601
turnin Taming the Beast##6102 |goto Teldrassil 56.68,59.49
accept Training the Beast##6103 |goto Teldrassil 56.68,59.49
|only if NightElf Hunter
step
Follow the road |goto Teldrassil 54.81,58.48 < 30 |only if walking
Enter Darnassus |goto Teldrassil 36.06,54.39 < 20 |only if walking
Run up the ramp |goto Darnassus 45.70,17.69 < 15 |only if walking
talk Jocaste##4146
|tip Inside the building.
turnin Training the Beast##6103 |goto Darnassus 40.38,8.56
|only if NightElf Hunter
step
talk Grif Wildheart##1231
accept Taming the Beast##6064 |goto Dun Morogh 45.81,53.03
|only if Dwarf Hunter
step
use the Taming Rod##15911
|tip Use it on a Large Crag Boar around this area.
Tame a Large Crag Boar |q 6064/1 |goto Dun Morogh 48.26,56.81
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
|only if Dwarf Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6064 |goto Dun Morogh 45.81,53.04
accept Taming the Beast##6084 |goto Dun Morogh 45.81,53.04
|only if Dwarf Hunter
step
use the Taming Rod##15913
|tip Use it on a Snow Leopard around this area.
Tame a Snow Leopard |q 6084/1 |goto Dun Morogh 48.68,58.93
|tip Dismiss it after you tame it.
|tip It may attack you after you dismiss it.
|only if Dwarf Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6084 |goto Dun Morogh 45.81,53.04
accept Taming the Beast##6085 |goto Dun Morogh 45.81,53.04
|only if Dwarf Hunter
step
use the Taming Rod##15908
|tip Use it on an Ice Claw Bear around this area.
Tame an Ice Claw Bear |q 6085/1 |goto Dun Morogh 49.06,62.12
You can usually find another one around [50.11,53.57]
|only if Dwarf Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6085 |goto Dun Morogh 45.81,53.04
accept Training the Beast##6086 |goto Dun Morogh 45.81,53.04
|only if Dwarf Hunter
step
Enter the building |goto Ironforge 66.34,82.50 < 7 |walk
talk Belia Thundergranite##10090
|tip Inside the building.
turnin Training the Beast##6086 |goto Ironforge 70.87,85.80
|only if Dwarf Hunter
step
ding 50
|only if not hardcore()
step
ding 52
|only if hardcore()
step
talk Dorion##4205
|tip Upstairs inside the building.
accept The Hunter's Charm##8151 |goto Darnassus 42.21,7.26
|only if Hunter
step
Follow the path up |goto Azshara 42.09,42.45
talk Ogtinc##8405
turnin The Hunter's Charm##8151 |goto Azshara 42.40,42.62
accept Courser Antlers##8153 |goto Azshara 42.40,42.62
|only if Hunter
step
kill Mosshoof Courser##8761
|tip They are scattered all over the area.
|tip These have a low drop rate. |only if hardcore()
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
|tip They look like 3 headed beasts. |only if hardcore()
|tip They are underwater around this area.
|tip Watch for patroling elites while here. |only if hardcore()
|tip When you fight them, be sure that you arne't underwater. |only if hardcore()
|tip These enemies cannot be tracked. |only if hardcore()
|tip They also have a very low spawn rate. |only if hardcore()
collect 6 Wavethrasher Scale##20087 |q 8231/1 |goto Azshara 52.61,41.87
|tip These may have a low drop rate.
You can find more around here [59.77,37.36]
[67.20,33.08]
|tip The coordinates below are a bit further out, but there are more.
[72.19,35.39]
[84.34,33.76]
[86.73,25.65]
|only if Hunter
step
Follow the path up |goto Azshara 42.09,42.45
talk Ogtinc##8405
turnin Wavethrashing##8231 |goto Azshara 42.40,42.62
accept The Green Drake##8232 |goto Azshara 42.40,42.62
|only if Hunter
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8232
|only if Hunter and hardcore()
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
_NOTE:_
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
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Rogue Class Quests",{
description="This guide will walk you through completing various Rogue Class Quests.",
},[[
step
ding 10
step
talk Hogral Bakkan##1234
accept Road to Salvation##2218 |goto Dun Morogh/0 47.56,52.61
|only if Rogue
step
talk Hulfdan Blackbeard##5165
|tip Downstairs inside the building.
turnin Road to Salvation##2218 |goto Ironforge/0 51.94,14.82
accept Simple Subterfugin'##2238 |goto Ironforge/0 51.94,14.82
|only if Rogue
step
talk Onin##6886
|tip On top of the platform.
turnin Simple Subterfugin'##2238 |goto Dun Morogh/0 25.16,44.45
accept Onin's Report##2239 |goto Dun Morogh/0 25.16,44.45
|only if Rogue
step
talk Hulfdan Blackbeard##5165
|tip Downstairs inside the building.
turnin Onin's Report##2239 |goto Ironforge/0 51.94,14.82
|only if Rogue
step
ding 16
|only if not hardcore()
step
ding 21
|tip We are waiting until 21 because the quest sends you to an area with level 23s.
|only if hardcore()
step
talk Lord Tony Romano##13283
|tip Inside the building.
Train the "Pick Lock" Ability |complete knowspell(1804) |goto Stormwind City 80.27,68.57
|only if Rogue
step
talk Gerald Crawley##3090
|tip Inside the building.
buy 1 Thieves' Tools##5060 |goto Redridge Mountains 20.00,41.15
|only if Rogue
step
Follow the road |goto Redridge Mountains 29.93,44.11 < 30 |only if walking
Follow the path |goto Redridge Mountains 38.21,37.54 < 30 |only if walking
click Practice Lockbox+
|tip They look like grey metal chests.
|tip Inside the building.
|tip Keep clicking them until you reach Lockpicking skill level 75.
Reach Level 75 in Lockpicking |skill Lockpicking,75 |goto Redridge Mountains 46.88,45.15 |q 2607 |future
|only if Rogue
step
ding 20
|only if not hardcore()
step
Follow the path |goto Stormwind City 77.51,65.99 < 7 |only if walking
Enter the building |goto Stormwind City 79.36,69.33 < 7 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
accept Mathias and the Defias##2360 |goto Stormwind City 78.31,70.75
|only if Rogue
step
Leave the building |goto Stormwind City 79.34,69.32 < 7 |walk
Follow the path |goto Stormwind City 77.45,65.93 < 7 |only if walking
Leave Stormwind |goto Stormwind City 74.69,93.21 < 30 |only if walking
Follow the road |goto Elwynn Forest 27.55,77.78 < 30 |only if walking
Enter Westfall |goto Elwynn Forest 20.73,79.79 < 20 |only if walking
talk Thor##523
fpath Sentinel Hill |goto Westfall 56.56,52.64
|only if Rogue
step
talk Agent Kearnen##7024
turnin Mathias and the Defias##2360 |goto Westfall 68.49,70.08
accept Klaven's Tower##2359 |goto Westfall 68.49,70.08
|only if Rogue
step
collect Defias Tower Key##7923 |q 2359/2 |goto Westfall 71.63,73.91
|tip Use your "Pickpocket" ability on Malformed Defias Drone.
|tip He walks around this area.
|tip Look out for the pair of Defias Drones patrolling as well. |only if hardcore()
|only if Rogue
step
Enter the building |goto Westfall 69.97,74.07 < 7 |walk
click Duskwood Chest##123214
|tip Upstairs inside the building.
|tip You will get a debuff after opening it.
|tip Use your "Sap" ability on Klaven Mortwake nearby before clicking the chest.
|tip He is elite, but you should be fine.
|tip If you have trouble, try to find someone to help you.
collect Klaven Mortwake's Journal##7908 |q 2359/1 |goto Westfall 70.41,73.93
|only if Rogue
step
Leave the building |goto Westfall 69.95,74.04 < 7 |walk
Follow the path |goto Stormwind City 77.51,65.99 < 7 |only if walking
Enter the building |goto Stormwind City 79.36,69.33 < 7 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin Klaven's Tower##2359 |goto Stormwind City 78.31,70.75
accept The Touch of Zanzil##2607 |goto Stormwind City 78.31,70.75
|only if Rogue
step
talk Doc Mixilpixil##7207
|tip Downstairs inside the building.
turnin The Touch of Zanzil##2607 |goto Stormwind City 80.06,69.91
accept The Touch of Zanzil##2608 |goto Stormwind City 80.06,69.91
|only if Rogue
step
Watch the dialogue
|tip Use the "/lay" emote while targeting Doc Mixilpixil.
Complete the Diagnosis |q 2608/1 |goto Stormwind City 80.06,69.91
|only if Rogue
step
talk Doc Mixilpixil##7207
|tip Downstairs inside the building.
turnin The Touch of Zanzil##2608 |goto Stormwind City 80.06,69.91
|only if Rogue
step
Remove the Touch of Zanzil |nobuff Touch of Zanzil##9991
|tip You will still have the "Touch of Zanzil" debuff.
|tip There is a quest to remove the buff.
|tip The quest makes you gather items in Stormwind City, but gathering the items can cost a lot of silver.
|tip To remove the buff without doing the quest and wasting money, you have 2 options:
|tip If you have First Aid leveled, create an "Anti-Venom" and use it on yourself.
|tip You can also try to buy one from the Auction House, they're usually cheap. |only if not selfmade()
|tip Alternatively, try to ask a Druid player to use their "Cure Poison" ability on you.
|only if Rogue
step
ding 50
|only if not hardcore()
step
ding 52
|tip We are waiting until 52 because there are higher level enemies around the are which you'll be questing.
|only if hardcore()
step
talk Lord Tony Romano##13283
|tip Inside the building.
accept A Simple Request##8233 |goto Stormwind City 80.28,68.57
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
|tip You can also Pickpocket them.
|tip Watch for patrols and respawns while in the area. |only if hardcore()
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
|tip Pickpocket them before killing them.
|tip Kill Mistwing Ravagers if you run out of oozes to kill. |only if hardcore()
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
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8236
|only if Rogue and hardcore()
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
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Mage Class Quests",{
description="This guide will walk you through completing various Mage Class Quests.",
},[[
step
ding 10
step
talk Zaldimar Wefhellt##328
|tip Upstairs inside the building.
accept Speak with Jennea##1860 |goto Elwynn Forest 43.25,66.19
|only if Mage
step
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
turnin Speak with Jennea##1860 |goto Stormwind City 49.50,85.84
accept Mirror Lake##1861 |goto Stormwind City 49.50,85.84
|only if Mage
step
use Jennea's Flask##7207
|tip Use it while in the water.
collect Mirror Lake Water Sample##7206 |q 1861/1 |goto Elwynn Forest 28.78,61.47
step
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
turnin Mirror Lake##1861 |goto Stormwind City 49.50,85.84
|only if Mage
step
ding 15
step
talk Dink##7312
|tip Inside the building
accept Report to Jennea##1919 |goto Ironforge 27.18,8.58
|only if Gnome Mage
step
talk Zaldimar Wefhellt##328
|tip Upstairs inside the building.
accept Report to Jennea##1919 |goto Elwynn Forest 43.25,66.19
|only if Human Mage
step
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
turnin Report to Jennea##1919 |goto Stormwind City 49.50,85.84
accept Investigate the Blue Recluse##1920 |goto Stormwind City 49.50,85.84
|only if Mage
step
click Chest of Containment Coffers##105174
|tip Upstairs inside the tower.
collect Chest of Containment Coffers##7247 |q 1920/2 |goto Stormwind City 49.54,85.61
|only if Mage
step
click Cantation of Manifestation##105175
|tip Upstairs inside the tower.
collect Cantation of Manifestation##7308 |q 1920/3 |goto Stormwind City 49.62,85.40
|only if Mage
step
Enter the building |goto Stormwind City 50.55,90.49 < 5 |walk
use Cantation of Manifestation##7308
|tip Inside the building.
|tip This will cause Rift Spawns to appear.
kill Rift Spawn##6492
use Chest of Containment Coffers##7247
click Filled Containment Coffer##103574
collect 1 Filled Containment Coffer##7292 |complete itemcount(7292) >= 1 |q 1920/1 |goto Stormwind City 51.12,95.56
|only if Mage
step
use Cantation of Manifestation##7308
|tip Inside the building.
|tip This will cause Rift Spawns to appear.
kill Rift Spawn##6492
use Chest of Containment Coffers##7247
click Filled Containment Coffer##103574
collect 2 Filled Containment Coffer##7292 |complete itemcount(7292) >= 2 |q 1920/1|goto Stormwind City 50.98,96.25
|only if Mage
step
use Cantation of Manifestation##7308
|tip Downstairs inside the building.
|tip This will cause Rift Spawns to appear.
kill Rift Spawn##6492
use Chest of Containment Coffers##7247
click Filled Containment Coffer##103574
collect 3 Filled Containment Coffer##7292 |complete itemcount(7292) >= 3 |q 1920/1 |goto Stormwind City 50.98,94.77
|only if Mage
step
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
turnin Investigate the Blue Recluse##1920 |goto Stormwind City 49.50,85.84
accept Gathering Materials##1921 |goto Stormwind City 49.50,85.84
|only if Mage
stickystart "Collect_10_Linen"
step
Enter the mine |goto Loch Modan 35.47,19.08 < 8 |walk
click Miners' League Crates##271
|tip Inside the mine.
|tip Keep an eye out for patrols and casters. |only if hardcore()
collect 6 Charged Rift Gem##7249 |q 1921/2 |goto Loch Modan 35.85,22.58
|only if Mage
step
label "Collect_10_Linen"
collect 10 Linen Cloth##2589 |q 1921/1
|tip These drop from Tunnel Rat enemies inside the cave.
|tip Keep an eye out for patrols and casters while in the cave. |only if hardcore() |notinsticky
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Mage
step
talk Wynne Larson##1309
|tip Inside the building
turnin Gathering Materials##1921 |goto Stormwind City 51.84,83.51
accept Manaweave Robe##1941 |goto Stormwind City 51.84,83.51
|only if Mage
step
ding 26
step
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
accept High Sorcerer Andromath##1939 |goto Stormwind City 49.50,85.84
|only if Mage
step
talk High Sorcerer Andromath##5694
|tip Upstairs inside the tower.
turnin High Sorcerer Andromath##1939 |goto Stormwind City 48.71,87.61
accept Ur's Treatise on Shadow Magic##1938 |goto Stormwind City 48.71,87.61
|only if Mage
step
click Ur's Treatise on Shadow Magic##103628
|tip Upstairs inside the tower.
collect Ur's Treatise on Shadow Magic##7266 |q 1938/1 |goto Redridge Mountains 73.78,47.64
|only if Mage
step
talk High Sorcerer Andromath##5694
|tip Upstairs inside the tower.
turnin Ur's Treatise on Shadow Magic##1938 |goto Stormwind City 48.71,87.61
accept Pristine Spider Silk##1940 |goto Stormwind City 48.71,87.61
|only if Mage
step
Kill enemies around this area
collect 8 Pristine Spider Silk##7267 |q 1940/1 |goto Duskwood 31.38,26.95
You can find more around here [34.42,56.77]
|only if Mage
step
talk Wynne Larson##1309
|tip Inside the building
turnin Pristine Spider Silk##1940 |goto Stormwind City 51.84,83.51
Watch the dialogue
accept Astral Knot Garment##1942 |goto Stormwind City 51.84,83.51
|only if Mage
step
ding 30
|only if not hardcore()
step
ding 34
|tip We are waiting until this level because you will be traveling through higher level areas.
|only if not hardcore()
step
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
accept Journey to the Marsh##1947 |goto Stormwind City 49.50,85.84
|only if Mage
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
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Scarlet Monastery (Library) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 1951
|only if Mage and hardcore()
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
Enter the Portal |goto Tirisfal Glades/0 85.33,32.27 < 7 |walk
Enter the Scarlet Monastery - Library Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway |q 1951
step
Inside the Scarlet Monastery Library Dungeon:
click Rituals of Power##103664
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
turnin Mage's Wand##1952 |goto Dustwallow Marsh 46.06,57.09 |noautoaccept
|only if Mage
step
ding 40
|only if Mage and not hardcore()
step
ding 45
|tip We are waiting until level 45 because there is an elite enemy that will need to be killed.
|tip It will be level 40, but you may need help as it still hits hard.
|only if Mage and hardcore()
step
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
accept Return to the Marsh##1953 |goto Stormwind City 49.50,85.84
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Return to the Marsh##1953 |goto Dustwallow Marsh 46.06,57.09
accept The Infernal Orb##1954 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
kill Burning Blade Summoner##4668
|tip You may have to look around for them. |only if hardcore()
|tip Watch out for patrols and respawns while in the area. |only if hardcore()
collect Infernal Orb##7291 |q 1954/1 |goto Desolace 53.34,79.05
|only if Mage
step
_NOTE:_
Incoming Elite Quest
|tip During the quest "The Exorcism", you will be tasked with killing The Demon of the Orb, which is a level 40 elite enemy.
|tip It will deal a lot of a damage.
|tip If you are unable to get help, you should have your best healing potions ready.
Click Here to Continue |confirm |q 1955 |future
|only if Mage and hardcore()
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
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Uldaman dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 1956
|only if Mage and hardcore()
step
Enter the Uldaman Dungeon with Your Group |goto Uldaman/0 0.00,0.00 < 500 |c |q 1956
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
talk Jennea Cannon##5497
|tip Upstairs inside the tower.
accept Tabetha's Task##2861 |goto Stormwind City 49.50,85.84
|only if Mage
step
talk Tabetha##6546
|tip Inside the building.
turnin Tabetha's Task##2861 |goto Dustwallow Marsh 46.06,57.09
accept Tiara of the Deep##2846 |goto Dustwallow Marsh 46.06,57.09
|only if Mage
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Zul'Farrak dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 2846
|only if Mage and hardcore()
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
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Dire Maul (North) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7463 |future
|only if Mage and hardcore()
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
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Dire Maul (East) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7463 |future
|only if Mage and hardcore()
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
Continue following the path |goto Feralas/0 64.85,30.18 < 7 |only if walking
Enter the Dire Maul - East Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 7463 |future
step
Inside the Dire Maul East Dungeon:
kill Hydrospawn##13280
|tip Refer to the Dire Maul East Dungeon guide to accomplish this.
collect Hydrospawn Essence##18299
|only if Mage
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Dire Maul (North) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7463 |future
|only if Mage and hardcore()
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
turnin Arcane Refreshment##7463
|only if Mage
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Paladin Class Quests",{
description="This guide will walk you through completing various Paladin Class Quests.",
},[[
step
ding 12
step
Enter the building |goto Stormwind City 53.29,51.63 < 7 |walk
talk Duthorian Rall##6171
|tip Inside the building.
accept The Tome of Divinity##1641 |goto Stormwind City 50.48,47.49
|only if Human Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1641 |goto Stormwind City 50.48,47.49
|only if Human Paladin
step
use the Tome of Divinity##6775
accept The Tome of Divinity##1642
|only if Human Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1642 |goto Stormwind City 50.48,47.49
accept The Tome of Divinity##1643 |goto Stormwind City 50.48,47.49
|only if Human Paladin
step
Leave the building |goto Stormwind City 53.00,51.12 < 7 |walk
talk Stephanie Turner##6174
turnin The Tome of Divinity##1643 |goto Stormwind City 63.84,72.21
accept The Tome of Divinity##1644 |goto Stormwind City 63.84,72.21
|only if Human Paladin
step
Enter the building |goto Stormwind City 61.45,70.07 < 7 |walk
talk Auctioneer Jaxon##15659
|tip Inside the building.
|tip Buy these items from the Auction House.
|tip Or, refer to the Linen Cloth farming guide to accomplish this.
collect 10 Linen Cloth##2589 |q 1644/1 |goto Stormwind City 61.16,70.68
|only if Human Paladin and selfmade()
step
Leave the building |goto Stormwind City 61.35,70.03 < 7 |walk
talk Stephanie Turner##6174
turnin The Tome of Divinity##1644 |goto Stormwind City 63.84,72.21
accept The Tome of Divinity##1780 |goto Stormwind City 63.84,72.21
|only if Human Paladin
step
Enter the building |goto Stormwind City 53.29,51.63 < 7 |walk
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1780 |goto Stormwind City 50.48,47.49
accept The Tome of Divinity##1781 |goto Stormwind City 50.48,47.49
|only if Human Paladin
step
talk Gazin Tenorm##6173
|tip Inside the building.
turnin The Tome of Divinity##1781 |goto Stormwind City 49.51,44.90
accept The Tome of Divinity##1786 |goto Stormwind City 49.51,44.90
|only if Human Paladin
step
Leave the building |goto Stormwind City 53.00,51.12 < 7 |walk
Leave Stormwind City |goto Stormwind City 74.65,93.16 < 30 |only if walking
Follow the road |goto Elwynn Forest 42.70,67.19 < 30 |only if walking
Follow the path |goto Elwynn Forest 69.14,70.95 < 30 |only if walking
use the Symbol of Life##6866
|tip Watch for Defias Rogue Wizards around here. |only if hardcore()
|tip They are ranged attackers with an abnormal sized aggro radius. |only if hardcore()
|tip Use it on Henze Faulk's corpse.
Ressurect Henze Faulk |q 1786/1 |goto Elwynn Forest 72.60,51.41
|only if Human Paladin
step
talk Henze Faulk##6172
turnin The Tome of Divinity##1786 |goto Elwynn Forest 72.60,51.41
accept The Tome of Divinity##1787 |goto Elwynn Forest 72.60,51.41
|only if Human Paladin
step
kill Defias Rogue Wizard##474+
|tip They are ranged attackers with an abnormal sized aggro radius. |only if hardcore()
collect Defias Script##6846 |q 1787/1 |goto Elwynn Forest 74.07,51.57
|only if Human Paladin
step
Follow the road |goto Elwynn Forest 70.14,70.84 < 30 |only if walking
Continue following the road |goto Elwynn Forest 42.19,64.92 < 30 |only if walking
Enter Stormwind City |goto Elwynn Forest 32.07,49.32 < 30 |only if walking
Enter the building |goto Stormwind City 53.29,51.63 < 7 |walk
talk Gazin Tenorm##6173
|tip Inside the building.
turnin The Tome of Divinity##1787 |goto Stormwind City 49.51,44.92
accept The Tome of Divinity##1788 |goto Stormwind City 49.51,44.92
|only if Human Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1788 |goto Stormwind City 50.48,47.49
|only if Human Paladin
step
Enter the building |goto Ironforge 27.28,12.31 < 10 |walk
talk Brandur Ironhammer##5149
|tip Inside the building.
accept Tome of Divinity##2997 |goto Ironforge 23.12,6.14
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin Tome of Divinity##2997 |goto Ironforge 27.64,12.19
accept The Tome of Divinity##1645 |goto Ironforge 27.64,12.19
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
accept The Tome of Divinity##1646 |goto Ironforge 27.64,12.19
|only if Dwarf Paladin
step
use the Tome of Divinity##6916
accept The Tome of Divinity##1646
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1646 |goto Ironforge 27.64,12.19
accept The Tome of Divinity##1647 |goto Ironforge 27.64,12.19
|only if Dwarf Paladin
step
talk John Turner##6175
|tip He walks around this area
turnin The Tome of Divinity##1647 |goto Ironforge 21.55,50.80
accept The Tome of Divinity##1648 |goto Ironforge 21.55,50.80
You can also find him around: |notinsticky
[22.93,61.36]
[32.40,78.58]
[43.09,84.17]
|only if Dwarf Paladin
step
Enter the building |goto Ironforge 26.14,72.21 < 10 |walk
talk Auctioneer Redmuse##8720
|tip Inside the building.
collect 10 Linen Cloth##2589 |q 1648/1 |goto Ironforge 24.25,74.57
|tip Buy them from the Auction House.
|only if Dwarf Paladin and selfmade()
step
talk John Turner##6175
|tip He walks around this area
turnin The Tome of Divinity##1648 |goto Ironforge 21.55,50.80
accept The Tome of Divinity##1778 |goto Ironforge 21.55,50.80
You can also find him around: |notinsticky
[22.93,61.36]
[32.40,78.58]
[43.09,84.17]
|only if Dwarf Paladin
step
Enter the building |goto Ironforge 27.28,12.31 < 10 |only if walking
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1778 |goto Ironforge 27.64,12.19
accept The Tome of Divinity##1779 |goto Ironforge 27.64,12.19
|only if Dwarf Paladin
step
talk Muiredon Battleforge##6178
|tip Upstairs inside the building.
turnin The Tome of Divinity##1779 |goto Ironforge 23.53,8.29
accept The Tome of Divinity##1783 |goto Ironforge 23.53,8.29
|only if Dwarf Paladin
step
Follow the road |goto Dun Morogh 49.69,46.36 < 30 |only if walking
Follow the path |goto Dun Morogh 73.14,49.95 < 30 |only if walking
use the Symbol of Life##6866
|tip Use it on Narm Faulk's corpse.
Resseurect Narm Faulk |q 1783/1 |goto Dun Morogh 78.32,58.09
|only if Dwarf Paladin
step
talk Narm Faulk##6177
turnin The Tome of Divinity##1783 |goto Dun Morogh 78.32,58.09
accept The Tome of Divinity##1784 |goto Dun Morogh 78.32,58.09
|only if Dwarf Paladin
step
kill Dark Iron Spy##6123+
collect Dark Iron Script##6847 |q 1784/1 |goto Dun Morogh 77.39,61.27
|only if Dwarf Paladin
step
Follow the road |goto Dun Morogh 72.88,49.82 < 30 |only if walking
Follow the path up |goto Dun Morogh 47.25,41.65 < 20 |only if walking
Enter Ironforge |goto Dun Morogh 53.47,34.90 < 20 |walk
Enter the building |goto Ironforge 27.28,12.31 < 15 |only if walking
talk Muiredon Battleforge##6178
|tip Upstairs inside the building.
turnin The Tome of Divinity##1784 |goto Ironforge 23.53,8.29
accept The Tome of Divinity##1785 |goto Ironforge 23.53,8.29
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1785 |goto Ironforge 27.64,12.19
|only if Dwarf Paladin
step
ding 20
|only if not hardcore()
step
ding 24
|tip We are waiting until 24 becuase there will be a difficult quest coming up.
|tip You will need to defeat 3 waves of enemies.
|tip The first wave has 3 enemies, the second has 4 and the final has 5.
|tip Even at this level, you may still need help with this.
|only if hardcore()
step
talk Duthorian Rall##6171
|tip Inside the building.
accept The Tome of Valor##1794 |goto Stormwind City 50.48,47.49 |or
accept The Tome of Valor##1793 |goto Stormwind City 50.48,47.49 |or
|only if Paladin
step
use the Tome of Valor##6776
accept The Tome of Valor##1649
|only if Paladin
step
talk Duthorian Rall##6171
turnin The Tome of Valor##1649 |goto Stormwind City 50.48,47.49
accept The Tome of Valor##1650 |goto Stormwind City 50.48,47.49
|only if Paladin
step
Follow the path up |goto Westfall 38.34,81.95 < 15 |only if walking
Follow the path down |goto Westfall 40.13,86.97 < 15 |only if walking
talk Daphne Stilwell##6182
|tip She walks around the area.
turnin The Tome of Valor##1650 |goto Westfall 42.71,88.40
accept The Tome of Valor##1651 |goto Westfall 42.71,88.40
|only if Paladin
step
kill Defias Raider##6180
|tip You may need help with this.
|tip They spawn in waves, the first has 3, the second has 4 and the third has 5.
Protect Daphne Stillwell from the Defias |q 1651/1 |goto Westfall 42.29,88.57
|only if Paladin
step
talk Daphne Stilwell##6182
|tip She walks around the area.
turnin The Tome of Valor##1651 |goto Westfall 42.71,88.40
accept The Tome of Valor##1652 |goto Westfall 42.71,88.40
|only if Paladin
step
talk Duthorian Rall##6171
turnin The Tome of Valor##1652 |goto Stormwind City 50.48,47.49
accept The Test of Righteousness##1653 |goto Stormwind City 50.48,47.49
|only if Paladin
step
talk Jordan Stilwell##6181
turnin The Test of Righteousness##1653 |goto Dun Morogh 52.48,36.92
accept The Test of Righteousness##1654 |goto Dun Morogh 52.48,36.92
|only if Paladin
step
_NOTE:_
Incoming Dungeon Steps
|tip The next couple of steps will be taking you to the Deadmines and Shadowfang Keep dungeons.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 1654 |future
|only if Paladin and hardcore()
step
Enter the building |goto Westfall/0 42.57,71.83 < 5 |walk
Jump down here |goto Westfall/0 43.42,72.89 < 5 |walk
Follow the path |goto Westfall/0 42.40,75.87 < 10 |walk
Follow the path |goto Westfall/0 41.79,78.54 < 10 |walk
Jump down here |goto Westfall/0 39.64,78.12 < 10 |walk
Enter the Deadmines Dungeon with Your Group |goto The Deadmines/0 0.00,0.00 < 500 |c |q 1654
step
Inside the Deadmines Dungeon:
|tip You can skip this step for now and do it later if you're unable to get a group. |only if hardcore()
kill Goblin Woodcarver##641
collect Whitestone Oak Lumber##6994 |q 1654/1
|only if Paladin
step
Enter the Shadowfang Keep Dungeon with Your Group |goto Shadowfang Keep/0 0.00,0.00 < 500 |c |q 1654
step
Inside the Shadowfang Keep Dungeon:
|tip You can skip this step for now and do it later if you're unable to get a group. |only if hardcore()
click Jordan's Smithing Hammer##91138
|tip Inside the stable area of the dungeon.
collect Jordan's Smithing Hammer##6895 |q 1654/3
|only if Paladin
step
_NOTE:_
Incoming Elite Area
|tip The area you're about to venture into is surrounded by level 20 elite enemies.
|tip If you're able, you may want to get help before continuing.
Click Here to Continue |confirm |q 1655 |future
|only if Paladin and hardcore()
step
talk Bailor Stonehand##6241
|tip Inside the building.
accept Bailor's Ore Shipment##1655 |goto Loch Modan 35.96,44.92
|only if Paladin
step
click Bailor's Ore##92420
|tip It looks like a crate next to a tree stump.
collect Jordan's Ore Shipment##6992 |q 1655/1 |goto Loch Modan 71.62,21.55
|only if Paladin
step
talk Bailor Stonehand##6241
|tip Inside the building.
|tip You may need help with this.
turnin Bailor's Ore Shipment##1655 |goto Loch Modan 35.96,44.92
collect Jordan's Ore Shipment##6992 |q 1654/2
|only if Paladin
step
talk Thundris Windweaver##3649
|tip Inside the building.
accept Seeking the Kor Gem##1442 |goto Darkshore 37.40,40.13
|only if Paladin
step
_NOTE:_
Incoming Elite Area
|tip The area you're about to venture into is surrounded by level 22 elite enemies.
|tip If you're able, you may want to get help before continuing.
Click Here to Continue |confirm |q 1442 |future
|only if Paladin and hardcore()
step
Follow the path |goto Ashenvale 14.11,14.87 < 15 |only if walking
Jump down into the water |goto Kalimdor 43.97,35.37 < 20 |walk
Enter the underwater cave |goto Kalimdor 43.94,35.27 < 7 |walk
Kill Blackfathom enemies around this area
|tip They are elite enemies.
|tip You may need help with this. |only if not hardcore()
|tip You will likely need help with this task unless you are overleveled. |only if hardcore()
collect Corrupted Kor Gem##6995 |q 1442/1 |goto Kalimdor 43.82,35.14
|only if Paladin
step
talk Thundris Windweaver##3649
|tip Inside the building.
accept Seeking the Kor Gem##1442 |goto Darkshore 37.40,40.13
collect Purified Kor Gem##7083 |q 1654/4
|only if Paladin
step
talk Jordan Stilwell##6181
turnin The Test of Righteousness##1654 |goto Dun Morogh 52.48,36.92
accept The Test of Righteousness##1806 |goto Dun Morogh 52.48,36.92
|only if Paladin
step
Watch the dialogue
talk Jordan Stilwell##6181
turnin The Test of Righteousness##1806 |goto Dun Morogh 52.48,36.92
|only if Paladin
step
ding 40
step
talk Duthorian Rall##6171
|tip Inside the building.
accept The Tome of Nobility##1661 |goto Stormwind City 50.49,47.50
turnin The Tome of Nobility##1661 |goto Stormwind City 50.49,47.50
|only if Paladin
step
ding 52
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
accept Chillwind Point##8415 |goto Stormwind City 48.41,50.16
|only if Paladin
step
talk Commander Ashlam Valorfist##10838
turnin Chillwind Point##8415 |goto Western Plaguelands 42.70,84.03
accept Dispelling Evil##8414 |goto Western Plaguelands 42.70,84.03
|only if Paladin
step
Kill enemies around this area
|tip Avoid Flesh Golems that patrol around the area.
collect 20 Minion's Scourgestone##12840 |q 8414/1 |goto Western Plaguelands 40.65,70.27
You can find more around here [44.38,69.97]
|only if Paladin
step
talk High Priest Thel'danis##1854
|tip He patrols around the area.
turnin Dispelling Evil##8414 |goto Western Plaguelands 52.09,83.35
accept Inert Scourgestones##8416 |goto Western Plaguelands 52.09,83.35
|only if Paladin
step
talk Commander Ashlam Valorfist##10838
turnin Inert Scourgestones##8416 |goto Western Plaguelands 42.70,84.03
accept Forging the Mightstone##8418 |goto Western Plaguelands 42.70,84.03
|only if Paladin
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8236
|only if Paladin and hardcore()
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
|only if Paladin
stickystart "Blue_Voodoo_Feathers"
stickystart "Green_Voodoo_Feathers"
step
Inside the Temple of Atal'Hakkar:
collect 2 Amber Voodoo Feather##20606 |q 8418/1
|tip These come from Gasher and Zul'Lor.
|only if Paladin
step
label "Blue_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar:
collect 2 Blue Voodoo Feather##20607 |q 8418/2
|tip These come from Mijan and Hukku.
|only if Paladin
step
label "Green_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar:
collect 2 Green Voodoo Feather##20608 |q 8418/3
|tip These come from Zolo and Loro.
|only if Paladin
step
talk Commander Ashlam Valorfist##10838
turnin Forging the Mightstone##8418 |goto Western Plaguelands 42.70,84.03
|only if Paladin
step
ding 60
step
talk Duthorian Rall##6171
|tip Inside the building.
accept Lord Grayson Shadowbreaker##7638 |goto Stormwind City 50.49,47.49
|only if Paladin
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
turnin Lord Grayson Shadowbreaker##7638 |goto Stormwind City 48.41,50.18
accept Emphasis on Sacrifice##7637 |goto Stormwind City 48.41,50.18
|only if Paladin
step
Collect 150 Gold |complete _G.GetMoney() >= 1500000 |q 7637 |future
|only if Paladin
step
talk High Priest Rohan##11406
|tip He walks around inside the building.
turnin Emphasis on Sacrifice##7637 |goto Ironforge 26.98,7.30
accept To Show Due Judgment##7639 |goto Ironforge 26.98,7.30
|only if Paladin
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
turnin To Show Due Judgment##7639|goto Stormwind City 48.41,50.18
accept Exorcising Terrordale##7640 |goto Stormwind City 48.41,50.18
|only if Paladin
step
use the Exorcism Censer##18752
|tip Use it on the green circles on the ground around this area.
|tip The green circles can also appear inside buildings.
kill 25 Terrordale Spirit##14564 |q 7640/1 |goto Eastern Plaguelands 15.97,25.26
|tip 3 will spawn at a time.
|tip You may need help with this.
You can find more around here [17.92,31.06]
|only if Paladin
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
turnin xorcising Terrordale##7640|goto Stormwind City 48.41,50.18
accept The Work of Grimand Elmore##7641 |goto Stormwind City 48.41,50.18
|only if Paladin
step
talk Grimand Elmore##1416
|tip Inside the building.
turnin The Work of Grimand Elmore##7641 |goto Stormwind City 59.71,33.77
accept Collection of Goods##7642 |goto Stormwind City 59.71,33.77
|only if Paladin
step
Collect 150 Gold |complete _G.GetMoney() >= 1500000 |q 7642/5 |future
|only if Paladin
step
collect 10 Arthas##8836 |q 7642/2
|tip If you have the Herbalism profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Paladin
step
collect 40 Runecloth##14047 |q 7642/3
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House. |only if not selfmade()
|only if Paladin
step
collect 6 Arcanite Bar##12360 |q 7642/4
|tip These are made by Alchemists.
|tip It takes 1 Thorium Bar and 1 Arcane Crystal to make one.
|tip Try to find a Alchemist to create one for you.
|only if Paladin
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Stratholme (Undead) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7642
|only if Paladin and hardcore()
step
click Elders' Square Service Gate |goto Eastern Plaguelands/0 41.43,17.71 < 10 |walk
|tip This requires the Key to the City, which drops from Magistrate barthilas in Stratholme - Live.
Enter the Stratholme - Undead Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 7642
step
Inside the Stratholme - Undead Dungeon:
click Stratholme Supply Crate
|tip They look like brown boxes along the walls of the dungeon.
collect 5 Stratholme Holy Water##13180 |q 7642/1
|only if Paladin
step
talk Grimand Elmore##1416
|tip Inside the building.
turnin Collection of Goods##7642 |goto Stormwind City 59.71,33.77
|only if Paladin
step
Follow Grimand Elmore
Watch the dialogue
accept Grimand's Finest Work##7648 |goto Stormwind City 59.71,33.77
|only if Paladin
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
turnin Grimand's Finest Work##7648 |goto Stormwind City 48.41,50.18
accept Ancient Equine Spirit##7643 |goto Stormwind City 48.41,50.18
|only if Paladin
step
talk Argent Quartermaster Lightspark##10857
buy 20 Enriched Manna Biscuit##13724 |q 7643 |future |goto Western Plaguelands 42.84,83.72
|tip You must be Friendy with The Argent Dawn to purchase these.
|tip Quest at Light's Hope Chapel in Eastern Plaguelands to accomplish this.
|only if Paladin
step
Collect 50 Gold |complete _G.GetMoney() >= 500000 |q 7637 |future
|only if Paladin
step
talk Merideth Carlson##2357
|tip Standing inside the stable.
accept Manna-Enriched Horse Feed##7645 |goto Hillsbrad Foothills 52.18,55.50
|only if Paladin
step
talk Merideth Carlson##2357
|tip Standing inside the stable.
turnin Manna-Enriched Horse Feed##7645 |goto Hillsbrad Foothills 52.18,55.50
|only if Paladin
step
collect Manna-Enriched Horse Feed##18775 |q 7643/1
|only if Paladin
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Diremaul (West) dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7643
|only if Paladin and hardcore()
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 60.32,30.16 < 10 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - West Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 7643
step
Inside the Diremaul - West Dungeon:
kill Tendris Warpwood##11489
talk Ancient Equine Spirit##14566
|tip It appears after you kill Tendris Warpwood.
turnin Ancient Equine Spirit##7643
accept Blessed Arcanite Barding##7644
|only if Paladin
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
turnin Blessed Arcanite Barding##7644 |goto Stormwind City 48.41,50.18
accept The Divination Scryer##7646 |goto Stormwind City 48.41,50.18
|only if Paladin
step
collect 1 Azerothian Diamond##12800 |q 7646/1
|tip These are gathered with the mining profession.
|tip Refer to the Thorium farming guide to gather them.
|tip You can also purchase it from the auction house. |only if not selfmade()
|only if Paladin
step
collect 1 Pristine Black Diamond##18335 |q 7646/2
|tip These are a random world drop.
|tip High level instance enemies have a chance to drop them.
|tip You can also purchase them from the auction house. |only if not selfmade()
|only if Paladin
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
turnin The Divination Scryer##7646 |goto Stormwind City 48.41,50.18
accept Judgment and Redemption##7647 |goto Stormwind City 48.41,50.18
|only if Paladin
step
use Lord Grayson's Satchel##18804
collect Divination Scryer##18746
collect Blessed Arcanite Barding##18792 |q 7647/2
|only if Paladin
step
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Scholomance dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 7647
|only if Paladin and hardcore()
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
|only if Paladin
step
Inside the Scholomance Dungeon:
use the Divination Scryer##18746
|tip Use it in the room with the boss Rattlegore after you have cleared it.
Kill enemies around this area
|tip They will spawn in waves.
|tip Make sure your group is prepared before using the Divination Scryer.
|tip If you wipe you will need to abandon and restart the quest.
kill Death Knight Darkreaver##14516
collect Charger's Lost Soul##18749 |q 7647/1
|only if Paladin
step
Inside the Scholomance Dungeon:
use the Charger's Lost Soul##18749
talk Darkreaver's Fallen Charger##14568
turnin Judgment and Redemption##7647
|only if Paladin
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Warlock Class Quests",{
description="This guide will walk you through completing various Warlock Class Quests.",
},[[
step
talk Drusilla La Salle##459
accept The Stolen Tome##1598 |goto Elwynn Forest 49.87,42.65
|only if Human Warlock
step
click Stolen Books##83763
collect Powers of the Void##6785 |q 1598/1 |goto Elwynn Forest 56.71,43.95
|only if Human Warlock
step
talk Drusilla La Salle##459
turnin The Stolen Tome##1598 |goto Elwynn Forest 49.87,42.65
|only if Human Warlock
step
talk Alamar Grimm##460
|tip Upstairs inside the building.
accept Beginnings##1599 |goto Dun Morogh/0 28.59,66.23
|only if Gnome Warlock
step
Enter the cave |goto Dun Morogh 26.80,79.86 < 15 |walk
Follow the path |goto Dun Morogh 28.00,81.05 < 10 |walk
kill Frostmane Novice##946+
|tip Inside the cave.
|tip There's only a few of them.
collect 3 Feather Charm##6753 |q 1599/1 |goto Dun Morogh 28.73,82.58
You can find more around: |notinsticky
[29.34,81.50]
[30.15,82.34]
[30.49,81.05]
|only if Gnome Warlock
step
Leave the cave |goto Dun Morogh 26.80,79.86 < 15 |c |q 1599
|only if Gnome Warlock
step
talk Alamar Grimm##460
|tip Upstairs inside the building.
turnin Beginnings##1599 |goto Dun Morogh/0 28.59,66.23
|only if Gnome Warlock
step
ding 10
step
Follow the path up |goto Dun Morogh 47.20,41.70 < 20 |only if walking
Enter Ironforge |goto Dun Morogh 53.47,34.90 < 20 |walk
talk Lago Blackwrench##6120
accept The Slaughtered Lamb##1715 |goto Ironforge 47.63,9.26
|only if Gnome Warlock
step
Follow the path |goto Ironforge 72.81,50.26 < 15 |walk
Enter the Deeprun Tram |goto Ironforge 77.02,51.26
Click Here After Entering Deeprun Tramp |confirm |q 1715
|only if Gnome Warlock
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the Deeprun Tram from Ironforge to Stormwind City.
Click Here After Riding the Tram |confirm |q 1715
|only if Gnome Warlock
step
_Inside Deeprun Tram:_
Enter Stormwind City |goto Stormwind City 68.38,31.68 < 2000 |noway |c |q 1715
|only if Gnome Warlock
step
Enter the building |goto Stormwind City 42.24,81.82 < 10 |walk
Follow the path down |goto Stormwind City 40.89,83.57 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin The Slaughtered Lamb##1715 |goto Stormwind City 39.22,85.23
accept Surena Caledon##1688 |goto Stormwind City 39.22,85.23
|only if Gnome Warlock
step
_NOTE:_
Incoming Difficult Quest
|tip The area where the next quest NPC is has a lot of potenial adds.
|tip Additionally, inside the building along side here are 2 other enemies.
Click Here to Continue |confirm |q 1688 |future
|only if (Gnome Warlock) and hardcore()
step
Leave the building |goto Stormwind City 42.23,81.84 < 10 |walk
Leave Stormwind City |goto Stormwind City 74.63,93.33 < 30 |only if walking
Follow the road |goto Elwynn Forest 42.68,67.14 < 30 |only if walking
Follow the path |goto Elwynn Forest 64.57,74.00 < 30 |only if walking
Enter the building |goto Elwynn Forest 70.93,80.43 < 10 |walk
kill Surena Caledon##881
|tip Inside the building.
|tip There are other enemies inside the building that will pull with her. |only if hardcore()
|tip If you clear the outer area, you might be able to utilize fear. |only if hardcore()
|tip You may need help with this. |only if hardcore()
collect Surena's Choker##6810 |q 1688/1 |goto Elwynn Forest 71.02,80.78
|only if Gnome Warlock
step
Follow the road |goto Elwynn Forest 65.65,74.10 < 30 |only if walking
Continue following the road |goto Elwynn Forest 42.11,64.65 < 30 |only if walking
Enter Stormwind City |goto Elwynn Forest 32.09,49.38 < 30 |only if walking
Enter the building |goto Stormwind City 42.23,81.84 < 10 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Surena Caledon##1688 |goto Stormwind City 39.22,85.23
accept The Binding##1689 |goto Stormwind City 39.22,85.23
|only if Gnome Warlock
step
Follow the path down |goto Stormwind City 39.06,85.81 < 5 |walk
Run down the stairs |goto Stormwind City 38.47,85.27 < 7 |c |q 1689
|only if Gnome Warlock
step
Run down the stairs |goto Stormwind City 39.91,85.82 < 7 |walk
use the Bloodstone Choker##6928
|tip Use it while standing on the pink symbol on the ground.
|tip Downstairs inside the building, inside the crypt.
kill Summoned Voidwalker##5676 |q 1689/1 |goto Stormwind City 39.11,84.37
|tip Don't forget to summon your imp. |only if hardcore()
|only if Gnome Warlock
step
Follow the path up |goto Stormwind City 39.82,86.21 < 7 |walk
Run up the stairs |goto Stormwind City 37.71,86.09 < 7 |c |q 1689
|only if Gnome Warlock
step
talk Gakin the Darkbinder##6122
|tip Upstairs inside the building, in the basement above the crypt.
turnin The Binding##1689 |goto Stormwind City 39.22,85.20
|only if Gnome Warlock
step
Enter the building |goto Elwynn Forest 42.95,65.65 < 10 |walk
talk Remen Marcot##6121
|tip Downstairs inside the building.
accept Gakin's Summons##1685 |goto Elwynn Forest 44.49,66.27
|only if (Human Warlock) and not haveq(1688) and not completedq(1688)
step
Enter the building |goto Stormwind City 42.23,81.84 < 10 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Gakin's Summons##1685 |goto Stormwind City 39.22,85.23
accept Surena Caledon##1688 |goto Stormwind City 39.22,85.23
|only Human Warlock
step
_NOTE:_
Incoming Difficult Quest
|tip The area where the next quest NPC is has a lot of potenial adds.
|tip Additionally, inside the building along side here are 2 other enemies.
Click Here to Continue |confirm |q 1688 |future
|only if (Human Warlock) and hardcore()
step
Leave the building |goto Stormwind City 42.23,81.84 < 10 |walk
Leave Stormwind City |goto Stormwind City 74.63,93.33 < 30 |only if walking
Follow the road |goto Elwynn Forest 42.68,67.14 < 30 |only if walking
Follow the path |goto Elwynn Forest 64.57,74.00 < 30 |only if walking
Enter the building |goto Elwynn Forest 70.93,80.43 < 10 |walk
kill Surena Caledon##881
|tip Inside the building.
|tip There are other enemies inside the building that will pull with her. |only if hardcore()
|tip If you clear the outer area, you might be able to utilize fear.|only if hardcore()
|tip You may need help with this. |only if hardcore()
collect Surena's Choker##6810 |q 1688/1 |goto Elwynn Forest 71.02,80.78
|only if Human Warlock
step
Follow the road |goto Elwynn Forest 65.65,74.10 < 30 |only if walking
Continue following the road |goto Elwynn Forest 42.11,64.65 < 30 |only if walking
Enter Stormwind City |goto Elwynn Forest 32.09,49.38 < 30 |only if walking
Enter the building |goto Stormwind City 42.23,81.84 < 10 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Surena Caledon##1688 |goto Stormwind City 39.22,85.23
accept The Binding##1689 |goto Stormwind City 39.22,85.23
|only Human Warlock
step
Follow the path down |goto Stormwind City 39.06,85.81 < 7 |walk
Run down the stairs |goto Stormwind City 38.47,85.27 < 7 |walk
Run down the stairs |goto Stormwind City 39.91,85.82 < 7 |walk
use the Bloodstone Choker##6928
|tip Use it while standing on the pink symbol on the ground.
|tip Downstairs inside the building, inside the crypt.
kill Summoned Voidwalker##5676 |q 1689 |goto Stormwind City 39.11,84.37
|tip Don't forget to summon your imp. |only if hardcore()
|only if Human Warlock
step
Follow the path up |goto Stormwind City 39.82,86.21 < 7 |walk
Run up the stairs |goto Stormwind City 37.71,86.09 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Upstairs inside the building, in the basement above the crypt.
turnin The Binding##1689 |goto Stormwind City 39.22,85.20
|only if Human Warlock
step
ding 20
step
talk Lago Blackwrench##6120
accept Gakin's Summons##1717 |goto Ironforge 47.62,9.26
|only if Warlock and not haveq(1716) and not completedq(1716)
step
Enter the building |goto Stormwind City 42.23,81.83 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Gakin's Summons##1717 |goto Stormwind City 39.22,85.23
accept Devourer of Souls##1716 |goto Stormwind City 39.22,85.23
|only if Warlock
step
Leave the building |goto Stormwind City 42.23,81.83 < 7 |walk
Follow the road |goto Darkshore 39.98,47.69 < 30 |only if walking
Enter Ashenvale |goto Darkshore 43.05,93.50 < 30 |only if walking
Follow the road |goto Ashenvale 29.63,17.12 < 30 |only if walking
talk Daelyshia##4267
fpath Astranaar |goto Ashenvale 34.41,47.99
|only if Warlock
step
Follow the road |goto Ashenvale 38.91,57.93 < 30 |only if walking
Follow the road |goto Ashenvale 67.13,71.87 < 30 |only if walking
Enter the Barrens |goto The Barrens 48.99,5.39 < 20 |only if walking
Follow the road |goto The Barrens 48.55,13.02 < 30 |only if walking
Avoid the Crossroads |goto The Barrens 53.91,30.00 < 30 |only if walking
Follow the road |goto The Barrens 50.43,37.77 < 30 |only if walking
talk Takar the Seer##6244
turnin Devourer of Souls##1716 |goto The Barrens 49.31,57.10
accept Heartswood##1738 |goto The Barrens 49.31,57.10
|only if Warlock
step
Follow the road |goto The Barrens 51.03,50.04 < 30 |only if walking
Avoid the Crossroads |goto The Barrens 53.68,29.52 < 30 |only if walking
Follow the road |goto The Barrens 51.18,15.34 < 30 |only if walking
Enter Ashenvale |goto The Barrens 48.98,5.37 < 20 |only if walking
Follow the road |goto Ashenvale 68.53,84.01 < 30 |only if walking
Continue following the road |goto Ashenvale 66.87,71.29 < 30 |only if walking
Follow the path |goto Ashenvale 26.14,35.41 < 30 |only if walking
click Heartswood##93192
collect Heartswood##6912 |q 1738/1 |goto Ashenvale 31.49,31.45
|only if Warlock
step
Follow the road |goto Ashenvale 25.58,36.45 < 30 |only if walking
Enter the building |goto Stormwind City 42.23,81.83 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Heartswood##1738 |goto Stormwind City 39.22,85.23
accept The Binding##1739 |goto Stormwind City 39.22,85.23
|only if Warlock
step
Follow the path down |goto Stormwind City 38.99,85.89 < 7 |walk
Run down the stairs |goto Stormwind City 38.48,85.28 < 7 |walk
Run down the stairs |goto Stormwind City 39.92,85.81 < 7 |walk
use the Heartswood Core##6913
|tip Use it while standing on the pink symbol on the ground.
|tip Downstairs inside the building, inside the crypt.
kill Summoned Succubus##5677 |q 1739/1 |goto Stormwind City 39.11,84.37
|only if Warlock
step
Follow the path up |goto Stormwind City 39.82,86.21 < 7 |walk
Run up the stairs |goto Stormwind City 37.71,86.09 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Upstairs inside the building, in the basement above the crypt.
turnin The Binding##1739 |goto Stormwind City 39.22,85.23
|only if Warlock
step
ding 30
step
Enter the building |goto Stormwind City 42.19,81.83 < 8 |walk
talk Gakin the Darkbinder##6122
|tip Inside the building.
accept Seeking Strahad##1798 |goto Stormwind City 39.22,85.21
|only if Warlock
step
Follow the path up |goto The Barrens 61.93,36.72 < 15
talk Strahad Farsan##6251
turnin Seeking Strahad##1798 |goto The Barrens 62.63,35.50
accept Tome of the Cabal##1758 |goto The Barrens 62.63,35.50
|only if Warlock
step
talk Krom Stoutarm##6294
|tip Inside the building.
turnin Tome of the Cabal##1758 |goto Ironforge 74.21,9.42
accept Tome of the Cabal##1802 |goto Ironforge 74.21,9.42
|only if Warlock
step
Follow the path down |goto Hillsbrad Foothills 36.94,65.37 < 30 |only if walking
click Tome of the Cabal##92013
|tip It looks like a blue book on the ground next to some crates.
|tip Try to pull the murlocs away one at a time when possible. |only if hardcore()
collect Moldy Tome##6931 |q 1802/1 |goto Hillsbrad Foothills 27.78,72.78
|only if Warlock
step
Enter the cave |goto Thousand Needles 44.09,37.29 < 10 |walk
click Damaged Chest##92423
collect Tattered Manuscript##6997 |q 1802/2 |goto Thousand Needles 43.43,32.69
|only if Warlock
step
talk Krom Stoutarm##6294
|tip Inside the building.
turnin Tome of the Cabal##1802 |goto Ironforge 74.21,9.42
accept Tome of the Cabal##1804 |goto Ironforge 74.21,9.42
|only if Warlock
step
Follow the path up |goto Wetlands 42.83,41.04
Kill Dragonmaw enemies around this area
collect 3 Rod of Channeling##6930 |q 1804/1 |goto Wetlands 45.09,43.08
|tip They drop from Dragonmaw Bonewarders and Shadowwarders.
You can find more around here [49.48,48.47]
|only if Warlock
step
Follow the path up |goto The Barrens 61.93,36.72 < 15
talk Strahad Farsan##6251
turnin Tome of the Cabal##1804 |goto The Barrens 62.63,35.50
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
Enter the building |goto Stormwind City 42.17,81.88 < 8 |walk
talk Demisette Cloyce##461
|tip Inside the building.
accept Summon Felsteed##4487 |goto Stormwind City 39.25,84.97 |or
accept Summon Felsteed##4488 |goto Stormwind City 39.25,84.97 |or
|only if Warlock
step
Follow the path up |goto The Barrens 61.93,36.72 < 15
talk Strahad Farsan##6251
turnin Summon Felsteed##4487 |goto The Barrens 62.63,35.50 |or
turnin Summon Felsteed##4488 |goto The Barrens 62.63,35.50 |or
accept Summon Felsteed##4490 |goto The Barrens 62.63,35.50
|only if Warlock
step
talk Strahad Farsan##6251
turnin Summon Felsteed##4490 |goto The Barrens 62.63,35.50
|only if Warlock
step
ding 53
|only if not hardcore()
step
ding 55
|only if hardcore()
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
|tip Watch for patrols and respawns while in the area.	|only if hardcore()
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
_NOTE:_
Incoming Dungeon Step
|tip The next couple of steps will be taking you to the Sunken Temple dungeon.
|tip You will need a group to complete the dungeon as well as the quest.
|tip If you don't have a group, wait until you do before continuing.
Click Here to Continue |confirm |q 8236
|only if Warlock and hardcore()
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
Inside the Temple of Atal'Hakkar Dungeon:
collect 2 Amber Voodoo Feather##20606 |q 8422/1
|tip These come from Gasher and Zul'Lor.
|only if Warlock
step
label "Blue_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar Dungeon:
collect 2 Blue Voodoo Feather##20607 |q 8422/2
|tip These come from Mijan and Hukku.
|only if Warlock
step
label "Green_Voodoo_Feathers"
Inside the Temple of Atal'Hakkar Dungeon:
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
talk Spackle Thornberry##5520
|tip Downstairs inside the building.
accept Mor'zul Bloodbringer##7562 |goto Stormwind City 39.53,84.53
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
|tip Watch for respawns while in the area. |only if hardcore()
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
Cross the bridge |goto Felwood 40.06,48.94 < 10 |c |q 7624 |walk
talk Ulathek##14523
Remove the Taint of Shadow buff |nobuff Taint of Shadow##23179 |q 7624 |goto Felwood 39.89,49.17
|only if Warlock
step
Cross the bridge |goto Felwood 40.02,48.99 < 10 |walk
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
run up the ramp |goto Felwood 37.35,45.87 < 10 |c |q 7625 |walk
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
_NOTE:_
Incoming Dungeon Steps
|tip The next few steps will send you into 2 different dungeons: Scholomance and then Dire Maul - West.
|tip You will need a group for each instance.
Click Here to Continue |confirm |q 7629 |future
|only if Warlock
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c
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
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Season of Discovery Items\\Cozy Sleeping Bag",{
description="This guide will walk you through obtaining the Cozy Sleeping Bag item.",
},[[
step
click Burned-Out Remains##415107
|tip It looks like a skeleton with clothes on, in the pile of wooden boards.
accept ...and that note you found##79008 |goto Westfall 37.41,50.70
step
click Burned-Out Remains##415106
turnin ...and that note you found##79008 |goto The Barrens 46.36,73.90
accept Stepping Stones##79192 |goto The Barrens 46.36,73.90
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
condition_end=function() return completedq(92458) end,
},[[
step
_NOTE:_
Getting the City of Dalaran Key
|tip Needed to open the City of Dalaran dungeon.
|tip Only one group member needs the key.
|tip Anyone can open the door, it's outside.
Click Here to Continue |confirm |q 92432 |future
step
talk Emissary Jacques##247264
accept An Alarming Request##92432 |goto Hillsbrad Foothills/0 48.30,60.10
step
talk Image of Archmage Modera##269127
turnin An Alarming Request##92432 |goto Silverpine Forest/0 68.60,45.20
accept Heart of Disruption##92458 |goto Silverpine Forest/0 68.60,45.20 |instant
|tip Gives you the key.
]])
