local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("LevelingACLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Startup Guide Wizard")
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
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Westfall (13-15)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Darkshore (15-18)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Loch Modan (18-19)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Redridge & Westfall (19-20)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Darkshore (20-21)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ashenvale & Stonetalon Mountains (21-24)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Wetlands (24-25)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Duskwood & Redridge Mountains (25-27)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Wetlands (27-29)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Ashenvale (29-30)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Duskwood & Stranglethorn Vale (30-32)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Hillsbrad Foothills & Arathi Highlands (32-33)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Dustwallow Marsh & Thousand Needles (33-34)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale (34-35)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Desolace (35-37)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale (37-38)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Swamp of Sorrows (38-39)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Arathi Highlands & Alterac Mountains (39-40)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Dustwallow Marsh (40-40)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Desolace (40-41)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Badlands (41-42)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale (42-43)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Swamp of Sorrows (43-43)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Tanaris (43-44)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Feralas & Tanaris (44-48)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\The Hinterlands (48-49)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Tanaris (49-49)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Un'Goro Crater (49-50)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Stranglethorn Vale (50-50)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Searing Gorge (50-51)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Blasted Lands & Burning Steppes (51-51)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Western Plaguelands (51-52)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Azshara & Felwood (52-52)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Feralas & Azshara (52-53)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Un'Goro Crater (53-54)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Winterspring & Felwood (54-56)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Burning Steppes (56-57)")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Western & Eastern Plaguelands (57-58)")
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
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Rogue Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Mage Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Paladin Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Warlock Class Quests")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\Season of Discovery Items\\Cozy Sleeping Bag")
ZygorGuidesViewer:RegisterGuidePlaceholder("Leveling Guides\\City of Dalaran Key")
