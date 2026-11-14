local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if ZGV:DoMutex("LevelingCCLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Skyborne Starter (1-13)",{
image=ZGV.IMAGESDIR.."Zephras Isle",
condition_suggested=function() return raceclass('Skyborne') and level <= 13 end,
condition_suggested_exclusive=true,
condition_visible=function() return Skyborne end,
linked = {"Leveling Guides\\Hidden Guides"},
linkedhidden = true,
hardcore = true,
},[[
defaultfor Skyborne
step
_NOTE:_
Wrong Character Race
|tip Guide written for {o}Skyborne{} characters.
|tip Other races may encounter issues.
Click Here to Continue |confirm
|only if not Skyborne
step
_Destroy This Item:_
|tip Saves bag space.
|tip You'll get one later.
trash Hearthstone##6948	|q 92460 |future
|only if not hardcore()
step
_NOTE:_
Manage Your Ammo
|tip Make sure you always have ammo.
|tip You need it to attack enemies.
|tip {o}General Goods{} vendors sell it (also Bow & Gun vendors).
|tip Try to keep your ammo bag full.
Click Here to Continue |confirm |q 92460 |future
|only if Hunter
step
talk Ailee Farheart##251362
accept Coming of Age##92460 |goto Zephras Isle/0 42.83,23.39
step
Kill enemies
|tip Loot items worth at least {o}10 copper{} to sell.
|tip Allows training an ability early.
Click Here to Continue |confirm |goto Zephras Isle/0 44.29,26.44 |q 92460
|only if Warrior or Shaman
step
talk Uualia Suncrest##251537
Sell Items |vendor Uualia Suncrest##251537 |goto Zephras Isle/0 42.75,24.49 |q 92460
|only if Warrior or Shaman
step
talk Rorian the Dayseeker##251361
turnin Coming of Age##92460 |goto Zephras Isle/0 42.06,23.48
accept Harmony in Balance##92461 |goto Zephras Isle/0 42.06,23.48
step
talk Windshaper Boro##251374
Train Abilities |trainer Windshaper Boro##251374 |goto Zephras Isle/0 42.79,23.57 |q 92461
|only if Shaman
step
talk Blademaster Ren##251964
|tip Inside the building.
Train Abilities |trainer Blademaster Ren##251964 |goto Zephras Isle/0 43.65,24.13 |q 92461
|only if Warrior
step
talk Elatrell Featherlight##251368
accept Infestation Investigation##92462 |goto Zephras Isle/0 43.44,24.80
stickystart "Kill_Juvenile_Vuldrens"
step
kill 8 Pesky Cirrusfly##251169 |q 92462/1 |goto Zephras Isle/0 45.79,27.29
|tip Flying insects.
step
label "Kill_Juvenile_Vuldrens"
kill 8 Juvenile Vuldren##250873 |q 92461/1 |goto Zephras Isle/0 44.62,26.12
|tip Winged foxes.
step
Kill enemies
|tip Helps reach level 3 after quest turnins.
|tip Needed for class quest.
ding 2,565 |goto Zephras Isle/0 44.62,26.12
|only if Shaman
step
talk Elatrell Featherlight##251368
turnin Infestation Investigation##92462 |goto Zephras Isle/0 43.44,24.80
accept The Cirrusfly Queen##92463 |goto Zephras Isle/0 43.44,24.80
step
talk Ventaari Brightwish##251487
accept The Gift of Skysight##92598 |goto Zephras Isle/0 42.61,24.39
|only if Horde
step
talk Rorian the Dayseeker##251361
turnin Harmony in Balance##92461	|goto Zephras Isle/0 42.06,23.48
accept Elemental Unrest##92464		|goto Zephras Isle/0 42.06,23.48
accept The Warrior's Path##92532	|goto Zephras Isle/0 42.06,23.48	|only if Warrior
accept The Way of the Hunter##92482	|goto Zephras Isle/0 42.06,23.48	|only if Hunter
accept At Home in the Shadows##92483	|goto Zephras Isle/0 42.06,23.48	|only if Rogue
accept Embracing the Elements##92484	|goto Zephras Isle/0 42.06,23.48	|only if Shaman
accept A Student of Nature##92485	|goto Zephras Isle/0 42.07,23.49	|only if Druid
accept A Student of the Arcane##92481	|goto Zephras Isle/0 42.06,23.48	|only if Mage
accept Embracing the Elements##92484	|goto Zephras Isle/0 42.06,23.48	|only if Shaman
step
talk Dorii Brightwhisper##251379
|tip {o}Ground floor{} inside the building.
turnin A Student of the Arcane##92481 |goto Zephras Isle/0 41.54,23.68
|only if Mage
step
talk Dorii Brightwhisper##251379
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Dorii Brightwhisper##251379 |goto Zephras Isle/0 41.54,23.68 |q 94414 |future
|only if Mage
step
talk Xyton Silverwind##251373
|tip {o}Ground floor{} inside the building.
turnin A Student of Nature##92485 |goto Zephras Isle/0 41.66,23.33
|only if Druid
step
talk Xyton Silverwind##251373
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Xyton Silverwind##251373|goto Zephras Isle/0 41.66,23.33 |q 94414 |future
|only if Druid
step
talk Tai'ree Farsight##251376
turnin The Way of the Hunter##92482 |goto Zephras Isle/0 42.47,23.73
|only if Hunter
step
talk Tai'ree Farsight##251376
Train Abilities |trainer Tai'ree Farsight##251376 |goto Zephras Isle/0 42.47,23.73 |q 94414 |future
|only if Hunter
step
talk Windshaper Boro##251374
turnin Embracing the Elements##92484 |goto Zephras Isle/0 42.79,23.57
accept Call of Earth##92466 |goto Zephras Isle/0 42.79,23.57
|only if Shaman
step
talk Windshaper Boro##251374
Train Abilities |trainer Windshaper Boro##251374 |goto Zephras Isle/0 42.79,23.57 |q 94414 |future
|only if Shaman
step
talk Falorne Fallwind##251371
accept Reading the Ley Lines##92597 |goto Zephras Isle/0 43.33,24.92
|only if Alliance
step
talk Dalia the Collector##251363
accept Harvesting Windstones##93552 |goto Zephras Isle/0 43.37,23.98
step
talk Blademaster Ren##251964
|tip Inside the building.
turnin The Warrior's Path##92532 |goto Zephras Isle/0 43.65,24.13
|only if Warrior
step
talk Akeri Duskblade##251389
|tip Inside the building.
turnin At Home in the Shadows##92483 |goto Zephras Isle/0 43.75,24.35
|only if Rogue
step
talk Akeri Duskblade##251389
|tip Inside the building.
Train Abilities |trainer Akeri Duskblade##251389 |goto Zephras Isle/0 43.75,24.35 |q 94414 |future
|only if Rogue
step
talk Halaan Hawk-Eye##257554
|tip Top of the tower.
accept The Anchors of Zephras##94414 |goto Zephras Isle/0 43.80,24.05
step
talk Halaan Hawk-Eye##257554
|tip Top of the tower.
Select _"Halaan, please lend me your gift."_ |gossip 137720
View the Anchor Pylon |q 94414/1 |goto Zephras Isle/0 43.80,24.05
step
talk Halaan Hawk-Eye##257554
|tip Top of the tower.
turnin The Anchors of Zephras##94414 |goto Zephras Isle/0 43.80,24.05
step
talk Myriaal Mistwake##263113
|tip Top of the tower.
accept Falling With Style##92474 |goto Zephras Isle/0 43.64,24.04
step
Use the Walk on Air Ability |q 92474/1 |goto Zephras Isle/0 43.90,24.04
|tip Jump from the tower toward the {o}northeast{}.
|tip Cast {o}Walk on Air{}.
stickystart "Collect_Windstone_Clusters"
step
talk Yala Windwatcher##249363
turnin Elemental Unrest##92464 |goto Zephras Isle/0 47.29,21.89
accept Agitators##92465 |goto Zephras Isle/0 47.29,21.89
stickystop "Collect_Windstone_Clusters"
stickystart "Collect_Signet_Of_Akir_Shaman"
stickystart "Kill_Roiling_Winds_And_AlAketh_Converts"
stickystart "Collect_Windstone_Clusters"
step
Use Skysight Near the Elemental Convergence |q 92598/1 |goto Zephras Isle/0 48.42,20.39
|tip Cast {o}Skysight{}.
|only if Horde
step
Use Read Ley Line Near the Thendal Grove Ley Line |q 92597/1 |goto Zephras Isle/0 46.29,17.80
|tip Cast {o}Read Ley Line{}.
|only if Alliance
step
label "Collect_Signet_Of_Akir_Shaman"
kill Al'Aketh Convert##251160+
collect Signet of Akir##251924 |q 92466/1 |goto Zephras Isle/0 46.72,19.83
|only if Shaman
step
label "Kill_Roiling_Winds_And_AlAketh_Converts"
kill 6 Roiling Winds##251143 |q 92465/2 |goto Zephras Isle/0 46.72,19.83
kill 7 Al'Aketh Convert##251160  |q 92465/1 |goto Zephras Isle/0 46.72,19.83
step
talk Yala Windwatcher##249363
turnin Agitators##92465 |goto Zephras Isle/0 47.29,21.89
accept Return to Rorian##92469 |goto Zephras Isle/0 47.29,21.89
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Inside or outside the cave.
Die on Purpose |complete isdead |goto Zephras Isle/0 46.72,19.83 |q 92466
|only if Shaman and not hardcore()
stickystop "Collect_Windstone_Clusters"
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 41.05,22.31 |q 92466 |zombiewalk
|only if Shaman and not hardcore()
step
talk Rorian the Dayseeker##251361
turnin Return to Rorian##92469 |goto Zephras Isle/0 42.06,23.48
turnin Falling With Style##92474 |goto Zephras Isle/0 42.07,23.48
|only if Shaman
step
talk Windshaper Boro##251374
turnin Call of Earth##92466 |goto Zephras Isle/0 42.81,23.53
accept Call of Earth##92467 |goto Zephras Isle/0 42.81,23.53
|only if Shaman
step
talk Ventaari Brightwish##251487
turnin The Gift of Skysight##92598 |goto Zephras Isle/0 42.60,24.39
|only if Shaman and Horde
stickystart "Collect_Windstone_Clusters"
step
Follow the path up |goto Zephras Isle/0 48.11,25.78 < 30 |only if walking
use Earth Sapta##6635
|tip Top of the mountain.
talk Minor Manifestation of Earth##251166
turnin Call of Earth##92467 |goto Zephras Isle/0 49.67,23.83
accept Call of Earth##92468 |goto Zephras Isle/0 49.67,23.83
|only if Shaman
step
label "Collect_Windstone_Clusters"
click Raw Windstone##613286+
|tip Blue crystals.
collect 15 Windstone Cluster##258772 |q 93552/1 |goto Zephras Isle/0 45.78,25.04
step
kill Cirrusfly Queen##251404 |q 92463/1 |goto Zephras Isle/0 48.36,28.44
|tip Larger red flying insect.
|tip Flies around.
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Zephras Isle/0 48.36,28.44 |q 92469
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 41.05,22.31 |q 92469 |zombiewalk
|only if not hardcore()
step
talk Rorian the Dayseeker##251361
turnin Return to Rorian##92469 |goto Zephras Isle/0 42.06,23.48
turnin Falling With Style##92474 |goto Zephras Isle/0 42.07,23.48
step
talk Windshaper Boro##251374
turnin Call of Earth##92468 |goto Zephras Isle/0 42.79,23.57
|only if Shaman
step
talk Ventaari Brightwish##251487
turnin The Gift of Skysight##92598 |goto Zephras Isle/0 42.60,24.39
|only if Horde
step
talk Falorne Fallwind##251371
turnin Reading the Ley Lines##92597 |goto Zephras Isle/0 43.33,24.92
|only if Alliance
step
talk Elatrell Featherlight##251368
turnin The Cirrusfly Queen##92463 |goto Zephras Isle/0 43.44,24.80
step
talk Dalia the Collector##251363
turnin Harvesting Windstones##93552 |goto Zephras Isle/0 43.37,23.99
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
talk Blademaster Ren##251964
|tip Inside the building.
Train Abilitie |trainer Blademaster Ren##251964 |goto Zephras Isle/0 43.65,24.13 |q 92471 |future
|only if Warrior
step
talk Akeri Duskblade##251389
|tip Inside the building.
Train Abilities |trainer Akeri Duskblade##251389 |goto Zephras Isle/0 43.75,24.35 |q 92471 |future
|only if Rogue
step
talk Uualia Suncrest##251537
buy Skinning Knife##7005 |goto Zephras Isle/0 42.75,24.49 |q 92471 |future
buy Apprentice's Skinning Satchel##277114 |goto Zephras Isle/0 42.75,24.49 |q 92471 |future
|only if skillmax("Skinning") > 1
step
talk Uualia Suncrest##251537
buy Apprentice's Herb Pouch##277113 |goto Zephras Isle/0 42.75,24.49 |q 92471 |future
|only if skillmax("Herbalism") > 1
step
talk Uualia Suncrest##251537
buy Mining Pick##2901 |goto Zephras Isle/0 42.75,24.49 |q 92471 |future
buy Apprentice's Mining Pack##277115 |goto Zephras Isle/0 42.75,24.49 |q 92471 |future
|only if skillmax("Mining") > 1
step
talk Tai'ree Farsight##251376
Train Abilities |trainer Tai'ree Farsight##251376 |goto Zephras Isle/0 42.47,23.73 |q 92471 |future
|only if Hunter
step
talk Rorian the Dayseeker##251361
accept Aetheen of the Gales##92471 |goto Zephras Isle/0 42.06,23.48
step
talk Dorii Brightwhisper##251379
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Dorii Brightwhisper##251379 |goto Zephras Isle/0 41.54,23.68 |q 92471
|only if Mage
step
talk Xyton Silverwind##251373
|tip {o}Ground floor{} inside the building.
Train Abilities |trainer Xyton Silverwind##251373|goto Zephras Isle/0 41.66,23.33 |q 92471
|only if Druid
step
talk Aetheen of the Gales##251366
turnin Aetheen of the Gales##92471 |goto Zephras Isle/0 42.76,23.66
accept Foul Matriarch##92470 |goto Zephras Isle/0 42.76,23.66
step
talk Windshaper Boro##251374
Train Abilities |trainer Windshaper Boro##251374 |goto Zephras Isle/0 42.79,23.57 |q 92470
|only if Shaman
step
talk Valreaa Valewind##257551
accept Aggressive Encroachment##92473 |goto Zephras Isle/0 42.41,25.15
step
kill Scrawny Ursera##250926+
|tip Outside the cave.
collect 6 Scrawny Ursera Claw##251918 |q 92473/1 |goto Zephras Isle/0 40.58,26.51
stickystart "Kill_Ursera_Scavengers"
step
Enter the cave |goto Zephras Isle/0 38.07,27.26 < 15 |walk |only if not (subzone("Thendal Cave") and indoors())
kill Urs'anah##251115
|tip Walks around.
|tip Downstairs inside the cave.
collect Head of Urs'anah##252665 |q 92470/2 |goto Zephras Isle/0 35.62,26.13
step
label "Kill_Ursera_Scavengers"
kill 8 Ursera Scavenger##250937 |q 92470/1 |goto Zephras Isle/0 38.07,27.26
|tip Inside the cave. |notinsticky
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
|tip Inside or outside the cave.
Die on Purpose |complete isdead |goto Zephras Isle/0 38.07,27.26 |q 92470
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 41.05,22.31 |q 92470 |zombiewalk
|only if not hardcore()
step
Leave the cave |goto Zephras Isle/0 38.07,27.26 < 15 |walk |only if subzone("Thendal Cave") and indoors()
talk Aetheen of the Gales##251366
turnin Foul Matriarch##92470 |goto Zephras Isle/0 42.76,23.66
accept The Next Step##92472 |goto Zephras Isle/0 42.76,23.66
accept The Adventurer##96638 |goto Zephras Isle/0 42.76,23.66
step
talk Valreaa Valewind##257551
turnin Aggressive Encroachment##92473 |goto Zephras Isle/0 42.41,25.15
step
talk Hanaa Nightwind##252095
accept Al'Aketh Thugs##92544 |goto Zephras Isle/0 38.32,30.18
stickystart "Kill_AlAketh_Neophytes_And_Brutes"
step
kill Malduko Cloudcrush##256935 |q 92544/3 |goto Zephras Isle/0 36.05,33.55
|tip Up on the platform.
step
label "Kill_AlAketh_Neophytes_And_Brutes"
kill 4 Al'Aketh Neophyte##251448 |q 92544/2 |goto Zephras Isle/0 37.22,32.91
kill 6 Al'Aketh Brute##251145 |q 92544/1 |goto Zephras Isle/0 37.22,32.91
step
talk Hanaa Nightwind##252095
turnin Al'Aketh Thugs##92544 |goto Zephras Isle/0 38.31,30.18
step
_NOTE:_
While in Zephras Isle
|tip Lookout for {o}tornados{}.
|tip Run into them.
|tip Boosts {o}run speed{}.
Click Here to Continue |confirm |q 96638
step
Kill enemies
|tip Skin them.
skill Skinning,20 |goto Zephras Isle/0 41.28,38.80 |q 97971 |future
|tip Needed for quest soon.
|only if skill("Skinning") > 0
step
Kill enemies
|tip Helps reach level 6 after quest turnins.
ding 5,1210 |goto Zephras Isle/0 41.28,38.80 |only if skill("Skinning") > 0
ding 5,1480 |goto Zephras Isle/0 41.28,38.80 |only if skill("Skinning") < 1
step
talk Raan Wildwind##263664
turnin The Adventurer##96638 |goto Zephras Isle/0 41.67,44.80
accept The Great Outdoors##96101 |goto Zephras Isle/0 41.67,44.80
step
Watch the dialogue
Use the {y}/sit{} Emote Near the Campfire |q 96101/1 |goto Zephras Isle/0 41.67,44.80 |macro /sit
Gain the Boosted Rest Buff |q 96101/2 |goto Zephras Isle/0 41.67,44.80
|tip Takes {o}1 minute{}.
step
talk Raan Wildwind##263664
turnin The Great Outdoors##96101 |goto Zephras Isle/0 41.67,44.80
accept Camping 101: Cooking##96646 |goto Zephras Isle/0 41.67,44.80
accept Camping 101: Skinning##97971 |goto Zephras Isle/0 41.67,44.80
step
talk Mendalass Tattermend##257024
|tip Inside the building.
turnin Camping 101: Skinning##97971 |goto Zephras Isle/0 43.29,43.37
|only if haveq(97971) or completedq(97971)
step
talk Zerril Softbreeze##251905
Select _"Train me."_ |gossip 137551
Learn Cooking From Zerril Softbreeze in Shen'dar Village |q 96646/1 |goto Zephras Isle/0 43.85,43.84
step
talk Zerril Softbreeze##251905
turnin Camping 101: Cooking##96646 |goto Zephras Isle/0 43.85,43.84
step
talk Constable Aonda##251523
|tip Inside the building.
turnin The Next Step##92472 |goto Zephras Isle/0 45.67,45.51
accept Welcome to Shen'dar Village##92514 |goto Zephras Isle/0 45.67,45.51 |only if Horde
accept Welcome to Shen'dar Village##93461 |goto Zephras Isle/0 45.67,45.50 |only if Alliance
step
talk Shenaan Spellwind##254086
|tip Inside the building.
Train Abilities |trainer Shenaan Spellwind##254086 |goto Zephras Isle/0 45.10,45.86 |q 92514 |only if Horde
Train Abilities |trainer Shenaan Spellwind##254086 |goto Zephras Isle/0 45.10,45.86 |q 93461 |only if Alliance
|only if Mage
step
talk Rathiril Sunlance##251903
|tip Inside the building.
Speak with Rathiril Sunlance |q 93461/1 |goto Zephras Isle/0 44.98,46.36
|only if Alliance
step
talk Rathiril Sunlance##251903
|tip Inside the building.
accept The High Order##92596 |goto Zephras Isle/0 44.98,46.36
|only if Alliance
step
Watch the dialogue
|tip Inside the building.
Listen to Rathiril Sunlance |q 92596/1 |goto Zephras Isle/0 44.98,46.36
|only if Alliance
step
talk Rathiril Sunlance##251903
|tip Inside the building.
turnin The High Order##92596 |goto Zephras Isle/0 44.98,46.36
accept A Magical Affront##94413 |goto Zephras Isle/0 44.98,46.36
|only if Alliance
step
talk Corsan Earthrazer##254088
|tip Inside the building.
Train Abilities |trainer Corsan Earthrazer##254088 |goto Zephras Isle/0 44.94,45.10 |q 92514 |only if Horde
Train Abilities |trainer Corsan Earthrazer##254088 |goto Zephras Isle/0 44.94,45.10 |q 93461 |only if Alliance
|only if Warrior
step
talk Elayaa Easewind##254084
|tip Inside the building.
Train Abilities |trainer Elayaa Easewind##254084 |goto Zephras Isle/0 45.26,44.25 |q 92514 |only if Horde
Train Abilities |trainer Elayaa Easewind##254084 |goto Zephras Isle/0 45.26,44.25 |q 93461 |only if Alliance
|only if Hunter
step
talk Naeluna Swiftmend##254081
|tip Inside the building.
Train Abilities |trainer Naeluna Swiftmend##254081 |goto Zephras Isle/0 45.16,44.22 |q 92514 |only if Horde
Train Abilities |trainer Naeluna Swiftmend##254081 |goto Zephras Isle/0 45.16,44.22 |q 93461 |only if Alliance
|only if Druid
step
talk Aarnor Galestrike##254082
Train Abilities |trainer Aarnor Galestrike##254082 |goto Zephras Isle/0 43.45,44.87 |q 92514 |only if Horde
Train Abilities |trainer Aarnor Galestrike##254082 |goto Zephras Isle/0 43.45,44.87 |q 93461 |only if Alliance
|only if Shaman
step
talk Illaya Amberwind##251902
Speak with Illaya Amberwind |q 92514/1 |goto Zephras Isle/0 43.52,44.78
|only if Horde
step
talk Illaya Amberwind##251902
accept The Windshapers##92595 |goto Zephras Isle/0 43.52,44.78
|only if Horde
step
Watch the dialogue
Listen to Illaya |q 92595/1 |goto Zephras Isle/0 43.52,44.78
|only if Horde
step
talk Illaya Amberwind##251902
turnin The Windshapers##92595 |goto Zephras Isle/0 43.52,44.78
accept Meddlesome Mages##94411 |goto Zephras Isle/0 43.52,44.78
|only if Horde
step
talk Miriaan Mistblade##254087
|tip Inside the building.
Train Abilities |trainer Miriaan Mistblade##254087 |goto Zephras Isle/0 43.15,43.26 |q 92514 |only if Horde
Train Abilities |trainer Miriaan Mistblade##254087 |goto Zephras Isle/0 43.15,43.26 |q 93461 |only if Alliance
|only if Rogue
step
talk Coriella Calmbreeze##254089
|tip Inside the building.
Speak with the Innkeeper |q 92514/2 |goto Zephras Isle/0 43.02,43.23 |only if Horde
Speak with the Innkeeper |q 93461/2 |goto Zephras Isle/0 43.02,43.23 |only if Alliance
step
talk Constable Aonda##251523
|tip Inside the building.
turnin Welcome to Shen'dar Village##92514 |goto Zephras Isle/0 45.68,45.50 |only if Horde
turnin Welcome to Shen'dar Village##93461 |goto Zephras Isle/0 45.68,45.50 |only if Alliance
accept The Criminal Element##92517 |goto Zephras Isle/0 45.68,45.50
step
talk Teeri Wellwind##251906
accept Pilfered Windstones##93319 |goto Zephras Isle/0 44.46,44.97
accept Hippogryph Harrassment##92516 |goto Zephras Isle/0 44.46,44.97
step
talk Indari Sunseam##251993
accept The Problem With Prideclaws##92515 |goto Zephras Isle/0 44.68,44.53
step
talk Taleen Shimmerthread##251991
accept A Little Beauty##93951 |goto Zephras Isle/0 44.88,44.19
step
talk Zerril Softbreeze##251905
accept Restocking the Larders##92553 |goto Zephras Isle/0 43.85,43.84
step
talk Naleeia Tattermend##257018
|tip {o}Ground floor{} inside the building.
Train First Aid |skillmax First Aid,75 |goto Zephras Isle/0 43.07,46.31
|tip If possible.
|only if Warrior or Rogue
step
_NOTE:_
Create Bandages in Downtime
|tip While waiting for things like boats.
|tip Increases skill in First Aid.
|tip Need higher skill to make better bandages.
|tip Keep bandages to heal yourself.
Click Here to Continue |confirm |q 92553
|only if Warrior or Rogue
stickystart "Collect_Small_Eggs_And_Strider_Meat"
stickystart "Collect_Prideclaw_Pelts"
step
kill 6 High Order Apprentice##257521 |q 94411/1 |goto Zephras Isle/0 46.42,38.70
|only if Horde
step
kill Windshaper Novice Seer##257532+
Defeat #6# Windshaper Novice Seers |q 94413/1 |goto Zephras Isle/0 38.84,47.58
|only if Alliance
step
label "Collect_Small_Eggs_And_Strider_Meat"
kill Galestrider##251661+
|tip Large walking birds.
collect 3 Small Egg##6889 |q 92553/1 |goto Zephras Isle/0 40.41,45.61
collect 8 Strider Meat##5469 |q 92553/2 |goto Zephras Isle/0 40.41,45.61
|tip Don't vendor them.
step
label "Collect_Prideclaw_Pelts"
kill Prideclaw##251245+
|tip Owl lions.
collect 10 Prideclaw Pelt##252670+ |q 92515/1 |q 92515/1 |goto Zephras Isle/0 40.41,45.61
step
talk Illaya Amberwind##251902
turnin Meddlesome Mages##94411 |goto Zephras Isle/0 43.52,44.78
|only if Horde
step
talk Zerril Softbreeze##251905
turnin Restocking the Larders##92553 |goto Zephras Isle/0 43.85,43.84
step
talk Indari Sunseam##251993
turnin The Problem With Prideclaws##92515 |goto Zephras Isle/0 44.68,44.53
step
talk Rathiril Sunlance##251903
|tip Inside the building.
turnin A Magical Affront##94413 |goto Zephras Isle/0 44.98,46.36
|only if Alliance
stickystart "Collect_Hippogryph_Down"
stickystart "Kill_Hippogryph_Protectors"
stickystart "Kill_Hippogryph_Youths"
step
kill Hippogryph Matriarch##251261 |q 92516/3 |goto Zephras Isle/0 35.05,54.18
|tip Multiple locations.
|mapmarker Zephras Isle/0 33.17,54.59
|mapmarker Zephras Isle/0 34.25,51.25
step
label "Collect_Hippogryph_Down"
click Hippogryph Down##617839
|tip Blue feathers.
collect 8 Hippogryph Down##263493 |q 93951/1 |goto Zephras Isle/0 36.17,54.65
step
label "Kill_Hippogryph_Protectors"
kill 6 Hippogryph Protector##251284 |q 92516/2 |goto Zephras Isle/0 35.31,52.83
step
label "Kill_Hippogryph_Youths"
kill 8 Hippogryph Youth##251291 |q 92516/1 |goto Zephras Isle/0 37.82,53.49
step
talk Teeri Wellwind##251906
turnin Hippogryph Harrassment##92516 |goto Zephras Isle/0 44.47,44.96
step
talk Taleen Shimmerthread##251991
turnin A Little Beauty##93951 |goto Zephras Isle/0 44.88,44.18
stickystart "Collect_Pilfered_Windstones"
stickystart "Kill_Highland_Bandits"
step
Enter the cave |goto Zephras Isle/0 48.97,36.24 < 15 |walk |only if not (subzone("Bandit Hideout") and indoors())
kill "Badwind" Bennic##255534 |q 92517/2 |goto Zephras Isle/0 50.80,33.79
|tip May need help.
|tip Inside the cave.
step
label "Collect_Pilfered_Windstones"
kill Highlands Bandit##251918+
|tip Inside and outside the cave. |notinsticky
collect 10 Pilfered Windstone##257945 |q 93319/1 |goto Zephras Isle/0 48.97,36.24
step
label "Kill_Highland_Bandits"
kill 10 Highlands Bandit##251918 |q 92517/1 |goto Zephras Isle/0 48.97,36.24
|tip Inside and outside the cave. |notinsticky
step
Kill enemies
|tip Helps reach level 8 after quest turnins.
|tip Inside and outside the cave.
ding 7,3470 |goto Zephras Isle/0 48.97,36.24
step
Leave the cave |goto Zephras Isle/0 48.97,36.24 < 15 |walk |only if subzone("Bandit Hideout") and indoors()
talk Teeri Wellwind##251906
turnin Pilfered Windstones##93319 |goto Zephras Isle/0 44.46,44.97
step
talk Constable Aonda##251523
|tip Inside the building.
turnin The Criminal Element##92517 |goto Zephras Isle/0 45.67,45.50
accept Infiltrating the Cult##93036 |goto Zephras Isle/0 45.67,45.50
step
talk Sania Silverstream##251904
|tip Inside the building.
turnin Infiltrating the Cult##93036 |goto Zephras Isle/0 44.82,45.51
accept Falaath Village##92529 |goto Zephras Isle/0 44.82,45.51
step
talk Shenaan Spellwind##254086
|tip Inside the building.
Train Abilities |trainer Shenaan Spellwind##254086 |goto Zephras Isle/0 45.10,45.86 |q 92529
|only if Mage
step
talk Corsan Earthrazer##254088
|tip Inside the building.
Train Abilities |trainer Corsan Earthrazer##254088 |goto Zephras Isle/0 44.94,45.10 |q 92529
|only if Warrior
step
talk Elayaa Easewind##254084
|tip Inside the building.
Train Abilities |trainer Elayaa Easewind##254084 |goto Zephras Isle/0 45.26,44.25 |q 92529
|only if Hunter
step
talk Naeluna Swiftmend##254081
|tip Inside the building.
Train Abilities |trainer Naeluna Swiftmend##254081 |goto Zephras Isle/0 45.16,44.22 |q 92529
|only if Druid
step
talk Aarnor Galestrike##254082
Train Abilities |trainer Aarnor Galestrike##254082 |goto Zephras Isle/0 43.45,44.87 |q 92529
|only if Shaman
step
talk Miriaan Mistblade##254087
|tip Inside the building.
Train Abilities |trainer Miriaan Mistblade##254087 |goto Zephras Isle/0 43.15,43.26 |q 92529
|only if Rogue
step
talk Missionary Jasaan##257065
turnin Falaath Village##92529 |goto Zephras Isle/0 46.89,56.24
accept Among the Faithful##92528 |goto Zephras Isle/0 46.89,56.24
step
label "Gain_Mark_Of_Akir_Buff"
talk Missionary Jasaan##257065
Select _"I seem to have lost my mark of Akir. Would you please bestow it upon me once more?"_ |gossip 137586
Gain the {y}Mark of Akir{} Buff |havebuff Mark of Akir##1254832 |goto Zephras Isle/0 46.89,56.24 |q 92528
|only if haveq(92528)
step
clicknpc Wardrobe##254128
|tip Upstairs inside the building.
Select _"<Hide behind the wardrobe and try to listen in on the cultists' conversation.>"_ |gossip 136768
Watch the dialogue
Learn About the Cultists' Plans |q 92528/1 |goto Zephras Isle/0 48.84,53.94
|only if hasbuff(1254832)
step
'|complete not readyq(92528)	|or	|next "Gain_Mark_Of_Akir_Buff"
'|complete readyq(92528)	|or	|next "Finished_Among_The_Faithful"
|only if haveq(92528)
step
label "Finished_Among_The_Faithful"
talk Constable Aonda##251523
|tip Inside the building.
turnin Among the Faithful##92528 |goto Zephras Isle/0 45.67,45.50
accept Havoc in the Highlands##92550 |goto Zephras Isle/0 45.67,45.50
accept The Western Watch##93926 |goto Zephras Isle/0 45.67,45.50
step
talk Danarii Bellowveil##252172
|tip Inside the building.
accept Stolen Supplies##92551 |goto Zephras Isle/0 45.24,45.19
step
Allow Enemies to Kill You
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Zephras Isle/0 42.48,48.45 |q 93926
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 40.23,63.82 |q 93926 |zombiewalk
|only if not hardcore()
step
clicknpc Peacekeeper Vaaniel##252155
Check in on the Western Watchtower in the Shen'dar Highlands |q 93926/1 |goto Zephras Isle/0 42.33,62.02
step
clicknpc Peacekeeper Vaaniel##252155
turnin The Western Watch##93926 |goto Zephras Isle/0 42.33,62.01
accept A Last Request##93927 |goto Zephras Isle/0 42.33,62.01
step
click Bloody Note
Collect and Read the Note |q 93927/1 |goto Zephras Isle/0 42.37,62.07
step
click Raani Windgazer
|tip Inside the building.
collect Raani's Lucky Feather##263415 |q 93927/3 |goto Zephras Isle/0 41.11,64.08
step
click Arvensus Shadowsong
|tip Inside the building.
collect Shadowsong Family Signet##263418 |q 93927 |goto Zephras Isle/0 40.98,64.07
step
kill Skypriest Aanders##256966 |q 93927/2 |goto Zephras Isle/0 41.08,64.34
|tip Top of the tower.
stickystart "Collect_Stolen_Shendar_Supplies"
stickystart "Kill_Living_Lightning_And_AlAketh_Stormcallers"
step
kill Commander Cyclas##251966
|tip Inside the building.
collect Commander Cyclas's Head##252661 |q 92550/3 |goto Zephras Isle/0 50.37,56.95
step
label "Collect_Stolen_Shendar_Supplies"
kill Al'Aketh Stormcaller##252068+
click Supply Cache+
|tip Brown pouches.
|tip Near and inside buildings.
collect 10 Stolen Shen'dar Supplies##252760+ |q 92551/1 |goto Zephras Isle/0 48.82,55.71
step
label "Kill_Living_Lightning_And_AlAketh_Stormcallers"
kill 4 Living Lightning##251662 |q 92550/2 |goto Zephras Isle/0 48.82,55.71
kill 6 Al'Aketh Stormcaller##252068 |q 92550/1 |goto Zephras Isle/0 48.82,55.71
step
talk Danarii Bellowveil##252172
|tip Inside the building.
turnin Stolen Supplies##92551 |goto Zephras Isle/0 45.24,45.18
step
talk Constable Aonda##251523
|tip Inside the building.
turnin Havoc in the Highlands##92550 |goto Zephras Isle/0 45.67,45.51
turnin A Last Request##93927 |goto Zephras Isle/0 45.67,45.51
accept Deliver the Signet##93948 |goto Zephras Isle/0 45.67,45.51
accept To Valanaar##92579 |goto Zephras Isle/0 45.67,45.51		|only if Horde
accept To Valanaar##92701 |goto Zephras Isle/0 45.64,45.46		|only if Alliance
step
Allow Enemies to Kill You
|tip Make sure your minimap subzone is {o}Shen'dar Highlands{}.
|tip Must be {o}very close{} this location.
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Zephras Isle/0 50.62,58.58 |q 93948
|only if not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 54.99,68.16 |q 93948 |zombiewalk
|only if not hardcore()
step
talk Falfaan Halfwind##271465
|tip Sells strong weapons.
|tip Inside the building.
Select _"I'd like to see your wares."_ |gossip 141556
Buy a Weapon Upgrade |vendor Falfaan Halfwind##271465 |goto Zephras Isle/0 59.40,75.73 |q 93948
step
talk Nyalah Brightfire##257006
|tip Inside the building.
accept Crab Season##93317 |goto Zephras Isle/0 60.64,72.66
step
talk Donaal Downbreeze##255940
|tip Inside the building.
home Valanaar |goto Zephras Isle/0 62.19,72.62
step
talk Alvarion Windfield##252448
|tip Upstairs inside the building.
accept Blood Tithe##92679 |goto Zephras Isle/0 62.10,73.34
step
talk Lotheluum Starbreeze##252359
accept Unnerving Silence##94484 |goto Zephras Isle/0 63.99,75.10
step
talk Ealaane Nimbuswalker##259012
accept Aid For The Refugees##94896 |goto Zephras Isle/0 65.95,74.31
accept The Fate of a Loved One##94897 |goto Zephras Isle/0 65.95,74.31
step
talk Talaanis Shadowsong##252476
|tip Top of the tower.
turnin Deliver the Signet##93948 |goto Zephras Isle/0 66.17,76.52
step
talk Valennia Stormfist##252383
|tip Top of the tower.
turnin To Valanaar##92579 |goto Zephras Isle/0 66.18,76.65		|only if Horde
turnin To Valanaar##92701 |goto Zephras Isle/0 66.18,76.65		|only if Alliance
accept Bugged##93949 |goto Zephras Isle/0 66.18,76.65
accept The Grand Skyseer##92700 |goto Zephras Isle/0 66.18,76.65	|only if Horde
accept The Supreme Magister##92699 |goto Zephras Isle/0 66.18,76.65	|only if Alliance
stickystart "Exterminate_Enchanted_Skyhoppers"
step
talk Elaadrin Evengale##252475
|tip Inside the building.
turnin The Supreme Magister##92699 |goto Zephras Isle/0 66.63,79.94
|only if Alliance
step
talk Dondallion Whisperwind##253204
|tip Inside the building.
accept The Missing Scholar##92727 |goto Zephras Isle/0 66.26,79.89
|only if Alliance
step
talk Iaadaria Bitterwind##253004
|tip Inside the building.
accept Unwelcome Visitors##92741 |goto Zephras Isle/0 66.34,79.51
|only if Alliance
stickystop "Exterminate_Enchanted_Skyhoppers"
step
Jump Off the Cliff
|tip No death penalty at this level.
|tip Fast travel.
Die on Purpose |complete isdead |goto Zephras Isle/0 66.95,80.09 |q 92679
|only if Alliance and not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 54.99,68.16 |q 92679 |zombiewalk
|only if Alliance and not hardcore()
step
click Bloodstained Satchel
turnin The Missing Scholar##92727 |goto Zephras Isle/0 53.33,72.17
accept The Missing Scholar##92849 |goto Zephras Isle/0 53.32,72.16
|only if Alliance
step
_NOTE:_
During the Next Steps
|tip You will carry someone through the cave.
|tip {o}Hurry{}, timed quest.
|tip {o}Getting attacked{} makes you restart.
|tip Enemies have {o}poor sight{} and only attack up close.
|tip Avoid them.
Click Here to Continue |confirm |q 92849
|only if Alliance
step
Enter the cave |goto Zephras Isle/0 51.38,68.52 < 15 |walk |only if not (subzone("Shriekling Den") and indoors())
talk Fillion Flamebreeze##253002
|tip Downstairs inside the cave.
Find Fillion Flamebreeze |q 92849/1 |goto Zephras Isle/0 50.67,65.36
|only if Alliance
step
label "Retry_The_Missing_Scholar"
Enter the cave |goto Zephras Isle/0 51.38,68.52 < 15 |walk |only if not (subzone("Shriekling Den") and indoors())
talk Fillion Flamebreeze##253002
|tip Downstairs inside the cave.
Select _"<Pick him up and carry him.>"_ |gossip 136430
Begin Carrying Fillion Flamebreeze |havebuff Saving Fillion Flamebreeze##1258429 |goto Zephras Isle/0 50.67,65.36 |q 92849
|only if Alliance
step
Follow the path up |goto Zephras Isle/0 51.95,66.56 < 10 |walk |only if subzone("Shriekling Den") and indoors()
Leave the cave |goto Zephras Isle/0 51.38,68.52 < 15 |walk |only if subzone("Shriekling Den") and indoors()
Carry Fillion Flamebreeze to Safety While Avoiding Enemies |q 92849/2 |goto Zephras Isle/0 52.08,69.39
|only if Alliance and hasbuff(1258429)
step
'|complete readyq(92849)	|or	|next "Finished_The_Missing_Scholar"
'|complete not readyq(92849)	|or	|next "Retry_The_Missing_Scholar"
|only if Alliance and haveq(92849)
step
label "Finished_The_Missing_Scholar"
talk Fillion Flamebreeze##253284
turnin The Missing Scholar##92849 |goto Zephras Isle/0 52.08,69.39
accept The Missing Scholar##92850 |goto Zephras Isle/0 52.08,69.39
|only if Alliance
step
Enter the cave |goto Zephras Isle/0 51.38,68.52 < 15 |walk |only if not (subzone("Shriekling Den") and indoors())
kill Shriekling Matriarch##253283
|tip Downstairs inside the cave.
collect Shriekling Matriarch's Head##257107 |q 92850/1 |goto Zephras Isle/0 52.02,65.71
|only if Alliance
stickystart "Exterminate_Enchanted_Skyhoppers"
step
talk Ayessa Dawnsinger##251968
turnin The Grand Skyseer##92700 |goto Zephras Isle/0 59.15,79.78
accept The Broken Construct##93735 |goto Zephras Isle/0 59.15,79.78
|only if Horde
stickystop "Exterminate_Enchanted_Skyhoppers"
step
talk Endaria Mistgaze##254344
accept Unwelcome Spirits##93736 |goto Zephras Isle/0 58.13,78.30
|only if Horde
stickystart "Exterminate_Enchanted_Skyhoppers"
step
talk Riaani Nightwind##256083
turnin The Broken Construct##93735 |goto Zephras Isle/0 59.07,73.00
accept The Broken Construct##93737 |goto Zephras Isle/0 59.07,73.00
|only if Horde
step
Watch the dialogue
Listen to What Riaani Nightwind Has to Say |q 93737/1 |goto Zephras Isle/0 59.08,73.09
|only if Horde
stickystop "Exterminate_Enchanted_Skyhoppers"
step
Enter the cave |goto Zephras Isle/0 51.38,68.52 < 15 |walk |only if not (subzone("Shriekling Den") and indoors())
click Construct Parts##616466+
|tip Piles of metal junk.
|tip Downstairs inside the cave.
collect Crystallized Lightning##260881 |q 93737/2 |goto Zephras Isle/0 52.04,66.67
|only if Horde
step
Leave the cave |goto Zephras Isle/0 51.38,68.52 < 15 |walk |only if subzone("Shriekling Den") and indoors()
talk Aamelia Windfield##252800
|tip Wait for her to return, if missing.
|tip Walks around.
Find Aamelia Windfield |q 92679/1 |goto Zephras Isle/0 46.70,81.94
step
talk Aamelia Windfield##252800
|tip Walks around.
turnin Blood Tithe##92679 |goto Zephras Isle/0 46.70,81.94
accept Make Yourself Useful##92682 |goto Zephras Isle/0 46.70,81.94
accept Ornery Ornery Galestriders##92684 |goto Zephras Isle/0 46.70,81.94
accept Flutterfly Dust##92683 |goto Zephras Isle/0 46.70,81.94
|mapmarker Zephras Isle/0 47.51,78.49
stickystart "Collect_Ripe_Stormapples"
step
kill 5 Hungry Bandit##252802 |q 92682/2 |goto Zephras Isle/0 47.98,83.00
|tip Stealthed.
|tip Multiple locations.
|mapmarker Zephras Isle/0 46.58,79.32
step
label "Collect_Ripe_Stormapples"
click Ripe Stormapple##578937+
|tip Red fruit.
|tip Multiple locations. |notinsticky
collect 10 Ripe Stormapple##253591 |q 92682/1 |goto Zephras Isle/0 47.98,83.00
|mapmarker Zephras Isle/0 46.58,79.32
stickystart "Collect_Flutterfly_Dust"
stickystart "Collect_Lowlands_Galestrider_Tenderloins"
step
talk Malfunctioning Cyclone Construct##250929
|tip Huge armored elemental.
|tip Walks around.
accept What Is My Purpose?##92698 |goto Zephras Isle/0 48.79,78.57
step
label "Collect_Flutterfly_Dust"
use Flutterfly Swatter##253666
|tip On Flutterflies.
|tip Large butterflies.
|tip May be attacked.
click Flutterfly Dust##578959+
|tip Piles of dust.
|tip Appear on the ground.
collect 5 Flutterfly Dust##253595 |q 92683/1 |goto Zephras Isle/0 50.84,77.01
step
label "Collect_Lowlands_Galestrider_Tenderloins"
kill Ornery Galestrider##251707+
|tip Large walking birds.
collect 7 Lowlands Galestrider Tenderloin##253597 |q 92684/1 |goto Zephras Isle/0 50.84,77.01
step
Kill enemies
|tip Helps reach level 10 after quest turnins.
|tip Good time to do class quest.
ding 9,4325 |goto Zephras Isle/0 50.84,77.01
|only if Shaman
step
talk Aamelia Windfield##252800
|tip Walks around.
turnin Make Yourself Useful##92682 |goto Zephras Isle/0 46.70,81.94
turnin Ornery Ornery Galestriders##92684 |goto Zephras Isle/0 46.70,81.94
turnin Flutterfly Dust##92683 |goto Zephras Isle/0 46.70,81.94 |noautoaccept
turnin What Is My Purpose?##92698 |goto Zephras Isle/0 46.70,81.94
accept The Hills Have Eyes##92685 |goto Zephras Isle/0 46.70,81.94
|mapmarker Zephras Isle/0 47.51,78.49
step
talk Sessaria Skystride##252382
accept Call of Fire##97243 |goto Zephras Isle/0 58.32,78.50
|only if Shaman
step
talk Sessaria Skystride##252382
Train Abilities |trainer Sessaria Skystride##252382 |goto Zephras Isle/0 58.31,78.50 |q 97243
|only if Shaman
step
talk Olariaan Swiftburn##268592
turnin Call of Fire##97243 |goto Zephras Isle/0 51.24,86.19
accept Call of Fire##97244 |goto Zephras Isle/0 51.24,86.19
|only if Shaman
step
Allow Enemies to Kill You
|tip Fast travel.
Die on Purpose |complete isdead |goto Zephras Isle/0 50.62,58.58 |q 97244
|only if Shaman and not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 54.99,68.16 |q 97244 |zombiewalk
|only if Shaman and not hardcore()
step
kill Skypriest Faladiel##268602
collect Faladiel's Heart##277267 |q 97244/1 |goto Zephras Isle/0 64.46,63.71
|only if Shaman
step
Allow Enemies to Kill You
|tip Fast travel.
Die on Purpose |complete isdead |goto Zephras Isle/0 62.57,64.77 |q 97244
|only if Shaman and not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Zephras Isle/0 54.99,68.16 |q 97244 |zombiewalk
|only if Shaman and not hardcore()
step
talk Olariaan Swiftburn##268592
turnin Call of Fire##97244 |goto Zephras Isle/0 51.24,86.19
accept Call of Fire##97245 |goto Zephras Isle/0 51.24,86.19
|only if Shaman
stickystart "Collect_Air_Construct_Core"
stickystart "Collect_Bandit_Masks"
step
click Kuramaa's Stump
kill Kuramaa##268605
collect Kuramaa's Mask##277269 |q 97245/1 |q 97245/1 |goto Zephras Isle/0 42.39,68.89
|only if Shaman
step
label "Collect_Air_Construct_Core"
click Construct Parts##616466+
|tip Piles of metal junk.
collect Air Construct Core##260880 |q 93737/4 |goto Zephras Isle/0 44.52,73.90
|only if Horde
step
label "Collect_Bandit_Masks"
kill Bandit Highwayman##252820+
collect 7 Blood-Stained Bandit Mask##253596 |q 92685/1 |goto Zephras Isle/0 44.52,73.90
step
talk Aamelia Windfield##252800
|tip Walks around.
turnin The Hills Have Eyes##92685 |goto Zephras Isle/0 46.71,81.94
accept Standing Our Ground##92693 |goto Zephras Isle/0 46.71,81.94
|mapmarker Zephras Isle/0 47.51,78.49
step
talk Aamelia Windfield##252800
Select _"I'm ready to fight, Aamelia."_ |gossip 136302
Speak with Aamelia Windfield |q 92693/1 |goto Zephras Isle/0 46.71,81.94
step
Watch the dialogue
Follow Aamelia and Make Your Final Stand |q 92693/2 |goto Zephras Isle/0 47.51,78.50
step
talk Aamelia Windfield##252800
|tip Walks around.
turnin Standing Our Ground##92693 |goto Zephras Isle/0 47.51,78.49
accept Deliver the News##92703 |goto Zephras Isle/0 47.51,78.49
|mapmarker Zephras Isle/0 46.70,81.94
step
talk Olariaan Swiftburn##268592
turnin Call of Fire##97245 |goto Zephras Isle/0 51.24,86.19
accept Call of Fire##97257 |goto Zephras Isle/0 51.24,86.19
|only if Shaman
step
Watch the dialogue
use Torch of Eternal Flame##277329
Complete the Ritual with Olariaan |q 97257/1 |goto Zephras Isle/0 51.20,86.01
|only if Shaman
step
click Brazier of Eternal Flame
|tip {o}Hurry{}, timed quest.
Select _"<Lower the flame into the Brazier.>"_ |gossip 140778
Light the Brazier of Eternal Flame |q 97257/2 |goto Zephras Isle/0 58.35,78.83
|only if Shaman
step
talk Sessaria Skystride##252382
turnin Call of Fire##97257 |goto Zephras Isle/0 58.31,78.50
|only if Shaman
stickystart "Exterminate_Enchanted_Skyhoppers"
step
talk Alvarion Windfield##252448
|tip Upstairs inside the building.
turnin Deliver the News##92703 |goto Zephras Isle/0 62.10,73.34
step
label "Exterminate_Enchanted_Skyhoppers"
kill Skyhopper##251727+
|tip Tiny blue insects.
|tip They won't all count.
Exterminate #8# Enchanted Skyhoppers |q 93949/1 |goto Zephras Isle/0 61.03,74.06
step
talk Valennia Stormfist##252383
|tip Upstairs inside the building.
turnin Bugged##93949 |goto Zephras Isle/0 66.18,76.66
step
talk Fillion Flamebreeze##253285
turnin The Missing Scholar##92850 |goto Zephras Isle/0 66.21,79.94
accept Fillion's Mission##99260 |goto Zephras Isle/0 66.21,79.94
|only if Alliance
step
talk Elaadrin Evengale##252475
turnin Fillion's Mission##99260 |goto Zephras Isle/0 66.63,79.94
accept Catching Wind##92840 |goto Zephras Isle/0 66.63,79.94
|only if Alliance
step
talk Anathamaas Aetherwind##252373
|tip Inside the building.
accept Speak with Belann##93791 |goto Zephras Isle/0 65.91,80.57
|only if Mage
step
talk Anathamaas Aetherwind##252373
|tip Inside the building.
Train Abilities |trainer Anathamaas Aetherwind##252373 |goto Zephras Isle/0 65.91,80.57 |q 93791
|only if Mage
step
talk Belann Windwood##256507
|tip Inside the building.
turnin Speak with Belann##93791 |goto Zephras Isle/0 62.90,77.44
accept Boughs in the Wind##93797 |goto Zephras Isle/0 62.90,77.44
|only if Mage
step
talk Lotheluum Starbreeze##252359
accept The Great Ursera Spirit##94006 |goto Zephras Isle/0 63.98,75.09
|only if Druid
step
talk Lotheluum Starbreeze##252359
Train Abilities |trainer Lotheluum Starbreeze##252359 |goto Zephras Isle/0 63.98,75.09 |q 94006
|only if Druid
step
talk Seena Skybreaker##252377
|tip Inside the building.
accept The Skybreaker Bulwark##94003 |goto Zephras Isle/0 59.89,72.86
|only if Warrior
step
talk Seena Skybreaker##252377
|tip Inside the building.
Train Abilities |trainer Seena Skybreaker##252377 |goto Zephras Isle/0 59.89,72.86 |q 98512 |future
|only if Warrior
step
talk Eltheen Nightbreeze##252379
|tip Inside the building.
Train Abilities |trainer Eltheen Nightbreeze##252379 |goto Zephras Isle/0 59.89,72.48 |q 98512 |future
|only if Rogue
step
_NOTE:_
Stronger Ammo Available
|tip Buy level 10 ammo when restocking.
Click Here to Continue |confirm |q 94978 |future
|only if Hunter
step
talk Quel'ana Quickgale##252389
|tip Inside the building.
accept Taming the Beast##94978 |goto Zephras Isle/0 59.57,72.64
|only if Hunter
step
talk Quel'ana Quickgale##252389
|tip Inside the building.
Train Abilities |trainer Quel'ana Quickgale##252389 |goto Zephras Isle/0 59.57,72.64 |q 94978
|only if Hunter
step
use Taming Rod##267272
|tip On a Windsong Crawler.
|tip Crabs.
Tame a Windsong Crawler |q 94978/1 |goto Zephras Isle/0 53.72,77.80
|only if Hunter
stickystart "Gather_Data_Elemental_Currents"
step
click Wind-Infused Bough
|tip Follow the road.
collect Wind-Infused Bough##262668 |q 93797/1 |goto Zephras Isle/0 48.72,67.77
|only if Mage
step
label "Gather_Data_Elemental_Currents"
click Windstone Formation+
|tip Large blue crystals.
|tip Follow the road.		|only if not Mage
Gather #6# Data Elemental Currents |q 92840/1 |goto Zephras Isle/0 47.96,69.22
|only if Alliance
step
talk Quel'ana Quickgale##252389
|tip Inside the building.
turnin Taming the Beast##94978 |goto Zephras Isle/0 59.57,72.64
accept Taming the Beast##94979 |goto Zephras Isle/0 59.57,72.64
|only if Hunter
step
use Taming Rod##267298
|tip On an Ornery Galestrider.
|tip Large walking birds.
|tip Dismiss your pet first.
Tame an Ornery Galestrider |q 94979/1 |goto Zephras Isle/0 57.30,71.27
|only if Hunter
step
talk Quel'ana Quickgale##252389
|tip Inside the building.
turnin Taming the Beast##94979 |goto Zephras Isle/0 59.57,72.64
accept Taming the Beast##94013 |goto Zephras Isle/0 59.57,72.64
|only if Hunter
step
use Taming Rod##264163
|tip On a Vuldren Alpha.
|tip Winged foxes.
|tip Dismiss your pet first.
Tame a Vuldren |q 94013/1 |goto Zephras Isle/0 56.63,67.74
|only if Hunter
step
talk Quel'ana Quickgale##252389
|tip Inside the building.
turnin Taming the Beast##94013 |goto Zephras Isle/0 59.57,72.64
accept Training the Beast##94050 |goto Zephras Isle/0 59.57,72.64
|only if Hunter
step
talk Quel'dora Quickgale##254411
|tip Inside the building.
turnin Training the Beast##94050 |goto Zephras Isle/0 59.60,72.53
|only if Hunter
step
talk Quel'dora Quickgale##254411
|tip Inside the building.
Train Pet Abilities |trainer Quel'dora Quickgale##254411 |goto Zephras Isle/0 59.60,72.53 |q 93737	|only if Horde
Train Pet Abilities |trainer Quel'dora Quickgale##254411 |goto Zephras Isle/0 59.60,72.53 |q 92840	|only if Alliance
|only if Hunter
step
talk Belann Windwood##256507
|tip Inside the building.
turnin Boughs in the Wind##93797 |goto Zephras Isle/0 62.90,77.44
|only if Mage
step
talk Elaadrin Evengale##252475
|tip Inside the building.
turnin Catching Wind##92840 |goto Zephras Isle/0 66.63,79.93
accept In Service of Zephras##92860 |goto Zephras Isle/0 66.63,79.93
|only if Alliance
step
talk Valennia Stormfist##252383
|tip Top of the tower.
turnin In Service of Zephras##92860 |goto Zephras Isle/0 66.18,76.66
accept Tower Defense##93320 |goto Zephras Isle/0 66.18,76.66
|only if Alliance
step
_NOTE:_
Tame Any Beast
|tip Cast {o}Tame Beast{} on any beast.
|tip Temporary pet.
|tip Dismiss your pet first.
Click Here to Continue |confirm |goto Zephras Isle/0 59.80,68.35 |q 98512 |future
|only if Hunter
step
talk Yorana Windyreed##252378
|tip Follow the road.
|tip Inside the building.
turnin Tower Defense##93320 |goto Zephras Isle/0 69.65,67.07
accept Disrupting Logistics##92642 |goto Zephras Isle/0 69.65,67.07
accept Breaking the Breaker##92645 |goto Zephras Isle/0 69.65,67.07
|only if Alliance
step
talk Urs'endris##255853
|tip Walks around.
turnin The Great Ursera Spirit##94006 |goto Zephras Isle/0 69.85,61.75
accept Strength and Mercy##94638 |goto Zephras Isle/0 69.85,61.75
|only if Druid
stickystart "Kill_AlAketh_Healers_And_Brawlers_Alliance"
step
kill Commander Belguilos##252666 |q 92645/1 |goto Zephras Isle/0 65.61,65.59
|tip Upstairs inside the building.
|only if Alliance
step
label "Kill_AlAketh_Healers_And_Brawlers_Alliance"
kill 4 Al'Aketh Healer##254596 |q 92642/1 |goto Zephras Isle/0 65.50,67.03
kill 8 Al'Aketh Brawler##270201 |q 92642/2 |goto Zephras Isle/0 65.50,67.03
|only if Alliance
step
talk Yorana Windyreed##252378
|tip Inside the building.
turnin Disrupting Logistics##92642 |goto Zephras Isle/0 69.65,67.07
turnin Breaking the Breaker##92645 |goto Zephras Isle/0 69.65,67.07
accept Return to Valanaar##92880 |goto Zephras Isle/0 69.65,67.07
|only if Alliance
step
talk Valennia Stormfist##252383
|tip Follow the road.
|tip Top of the tower.
turnin Return to Valanaar##92880 |goto Zephras Isle/0 66.18,76.65
accept The High Elder's Request##92881 |goto Zephras Isle/0 66.18,76.65
|only if Alliance
step
talk Talaanis Shadowsong##252476
|tip Top of the tower.
turnin The High Elder's Request##92881 |goto Zephras Isle/0 66.18,76.52
accept The Turncoat##92643 |goto Zephras Isle/0 66.18,76.52
|only if Alliance
step
talk Fendaal Windstone##273017
accept Al'Aketh Assassins##98512 |goto Zephras Isle/0 56.81,61.11
stickystart "Kill_AlAketh_Assassins"
step
kill Ur'endra##258443 |q 94638/1 |goto Zephras Isle/0 54.41,65.94
|tip Walks around.
|tip Inside the small cave.
|tip Top of the mountain.
|only if Druid
step
Find the Secluded House in Shen'dar Highlands |q 92643/1 |goto Zephras Isle/0 56.04,58.77
|only if Alliance
step
clicknpc Dead Cultist##253372
|tip Inside the building.
Find the Al'Aketh Turncoat |q 92643/2 |goto Zephras Isle/0 56.04,58.77
|only if Alliance
step
clicknpc Dead Cultist##253372
|tip Inside the building.
turnin The Turncoat##92643 |goto Zephras Isle/0 56.04,58.77
accept Unfortunate News##92644 |goto Zephras Isle/0 56.04,58.77
|only if Alliance
step
label "Kill_AlAketh_Assassins"
kill 10 Al'Aketh Assassin##254626 |q 98512/1 |goto Zephras Isle/0 55.62,60.17
step
talk Fendaal Windstone##273017
turnin Al'Aketh Assassins##98512 |goto Zephras Isle/0 56.81,61.10
step
talk Urs'endris##255853
|tip Walks around.
turnin Strength and Mercy##94638 |goto Zephras Isle/0 69.85,61.75
|only if Druid
step
kill Zaal Stormshield##257196
collect Skybreaker Bulwark##263993 |q 94003/1 |goto Zephras Isle/0 56.61,50.37
|only if Warrior
step
_NOTE:_
Tame a Windsong Crawler
|tip Release your temporary pet.
|tip Cast {o}Tame Beast{} on a Windsong Crawler.
|tip Crabs.
Click Here to Continue |confirm |goto Zephras Isle/0 53.05,57.54 |q 93159 |future
|only if Hunter
step
kill Windsong Crawler##254588+
|tip Crabs.
collect 6 Windsong Crawler Meat##257941 |q 93317/1 |goto Zephras Isle/0 53.05,57.54
step
click Construct Parts##616466+
|tip Piles of metal junk.
|tip Underwater.
collect Enchanted Gyrozephyr##260883 |q 93737/3 |goto Zephras Isle/0 51.85,47.73
|only if Horde
step
talk Strange Hermit##251684
accept The Strange Hermit##93159 |goto Zephras Isle/0 53.96,38.90
step
talk Strange Hermit##251684
Select _"What are you?"_ |gossip 135787
Select _"What are all of these contraptions?"_ |gossip 135786
Select _"Sure, why not? (Train Engineering, whatever that is?)"_ |gossip 135785
Learn More About the Strange Hermit |q 93159/1 |goto Zephras Isle/0 53.96,38.91
step
talk Strange Hermit##251684
turnin The Strange Hermit##93159 |goto Zephras Isle/0 53.96,38.91
accept The Forest's Bounty##93160 |goto Zephras Isle/0 53.96,38.91
accept Free the Hollows##93172 |goto Zephras Isle/0 53.96,38.91
stickystart "Collect_Abandoned_Belongings"
stickystart "Free_Wind_Hollows_And_Collect_Wind_Hollow_Essences"
stickystart "Collect_Zephyrseeds"
stickystart "Collect_Shriekling_Talons_And_Pristine_Shrieking_Feathers"
step
clicknpc Resaan Nimbuswalker##259013
Select _"Retrieve the heirloom."_ |gossip 138670
collect Resaan's Heirloom##266434 |q 94897/1 |goto Zephras Isle/0 57.05,29.35
stickystop "Collect_Zephyrseeds"
stickystop "Collect_Shriekling_Talons_And_Pristine_Shrieking_Feathers"
step
label "Collect_Abandoned_Belongings"
click Abandonded Belongings##623295+
|tip Wooden crates.
collect 8 Abandoned Belongings##266433 |q 94896/1 |goto Zephras Isle/0 57.95,31.20
step
label "Free_Wind_Hollows_And_Collect_Wind_Hollow_Essences"
kill Wind Hollow##251676+
|tip Wind elementals.
Free #10# Wind Hollows |q 93172/1 |goto Zephras Isle/0 57.99,31.96
collect 10 Wind Hollow Essence##262357 |q 93736/1 |goto Zephras Isle/0 57.99,31.96 |only if Horde
stickystart "Collect_Zephyrseeds"
stickystart "Collect_Shriekling_Talons_And_Pristine_Shrieking_Feathers"
step
talk Elegael Thornpaw##257944
turnin Unnerving Silence##94484 |goto Zephras Isle/0 61.75,39.15
accept Tears of the Lady##94485 |goto Zephras Isle/0 61.75,39.15
accept Feathers for Binding##94486 |goto Zephras Isle/0 61.75,39.15
accept Unwanted and Unworthy##94487 |goto Zephras Isle/0 61.75,39.15
stickystop "Collect_Shriekling_Talons_And_Pristine_Shrieking_Feathers"
stickystart "Collect_Ladys_Tear_Moss"
stickystart "Collect_Shriekling_Talons_And_Pristine_Shrieking_Feathers"
step
kill Al'Aketh Footsoldier##252665, Al'Aketh Stormchaser##252664
|tip Elves.
collect 10 Bloody Heirloom##265141 |q 94487/1 |goto Zephras Isle/0 64.24,37.30
step
label "Collect_Zephyrseeds"
click Zephyrseed Cone##613238+
|tip Large pine cones.
|tip Near trees.
collect 8 Zephyrseed##257128 |q 93160/1 |goto Zephras Isle/0 59.77,38.58
step
talk Strange Hermit##251684
turnin The Forest's Bounty##93160 |goto Zephras Isle/0 53.96,38.91
turnin Free the Hollows##93172 |goto Zephras Isle/0 53.96,38.91
step
label "Collect_Ladys_Tear_Moss"
click Lady's Tear Moss##619450+
|tip Yellow moss.
|tip Hanging from trees.
collect 8 Lady's Tear Moss##265105 |q 94485/1 |goto Zephras Isle/0 61.44,38.08
step
label "Collect_Shriekling_Talons_And_Pristine_Shrieking_Feathers"
kill Shadowgale Shriekling##256092+
|tip Large walking birds.
collect 8 Shriekling Talons##254378		|q 92741/1 |goto Zephras Isle/0 58.93,38.95	|only if Alliance
collect 20 Pristine Shrieking Feathers##265140	|q 94486/1 |goto Zephras Isle/0 58.93,38.95	|only if haveq(94486) or completedq(94486)
step
talk Elegael Thornpaw##257944
turnin Tears of the Lady##94485 |goto Zephras Isle/0 61.75,39.15
turnin Feathers for Binding##94486 |goto Zephras Isle/0 61.75,39.15
turnin Unwanted and Unworthy##94487 |goto Zephras Isle/0 61.75,39.15
accept The Ties That Bind##94488 |goto Zephras Isle/0 61.75,39.15
accept The Wounds of Betrayal##94489 |goto Zephras Isle/0 61.75,39.15
step
kill Commander Haalien##253622
collect Ripped Missive##265476 |goto Zephras Isle/0 65.53,36.37 |q 94490 |future
collect Commander Haalien's Severed Head##265475 |q 94488/1 |goto Zephras Isle/0 65.53,36.37
step
use Ripped Missive##265476
accept Ripped Missive##94490
step
Enter the cave |goto Zephras Isle/0 63.77,35.86 < 15 |walk |only if not (subzone("Nightclaw Cavern") and indoors())
clicknpc Neyasteel Mossmender##258275
|tip Inside the cave.
Heal the Injured Druid |q 94489/1 |goto Zephras Isle/0 64.00,31.97 |count 1
step
clicknpc Bryaes Galechaser##258277
|tip Inside the cave.
Heal the Injured Druid |q 94489/1 |goto Zephras Isle/0 64.42,31.90 |count 2
step
Follow the path up |goto Zephras Isle/0 64.66,30.24 < 15 |walk
clicknpc Mithraless Sterngale##258288
|tip Upstairs inside the cave.
Heal the Injured Druid |q 94489/1 |goto Zephras Isle/0 65.80,32.96 |count 3
step
clicknpc Baeo Sharpstrike##258289
|tip Upstairs inside the cave.
Heal the Injured Druid |q 94489/1 |goto Zephras Isle/0 65.92,33.55 |count 4
step
clicknpc Naaleos Leafwhisper##258134
|tip Inside the cave.
Heal the Injured Druid |q 94489/1 |goto Zephras Isle/0 64.96,34.95 |count 5
step
clicknpc Telenos Leafwhisper##258137
|tip Inside the cave.
Heal the Injured Druid |q 94489/1 |goto Zephras Isle/0 64.69,35.02 |count 6
step
clicknpc Nayeela Snarlfang##258138
|tip Inside the cave.
Heal the Injured Druid |q 94489/1 |goto Zephras Isle/0 64.52,34.88 |count 7
step
talk Jorel Windsinger##258130
|tip Inside the cave.
Select _"<Leave to tend to the other druids.>"_ |gossip 137859
Find Jorel Windsinger |q 94489/2 |goto Zephras Isle/0 64.48,34.74
step
Leave the cave |goto Zephras Isle/0 63.75,35.89 < 15 |walk |only if subzone("Nightclaw Cavern") and indoors()
talk Elegael Thornpaw##257944
turnin The Ties That Bind##94488 |goto Zephras Isle/0 61.76,39.15
turnin The Wounds of Betrayal##94489 |goto Zephras Isle/0 61.76,39.15
turnin Ripped Missive##94490 |goto Zephras Isle/0 61.76,39.15
accept The Fate of the Den##94491 |goto Zephras Isle/0 61.76,39.15
step
talk Lotheluum Starbreeze##252359
turnin The Fate of the Den##94491 |goto Zephras Isle/0 63.98,75.09
step
talk Lotheluum Starbreeze##252359
Train Abilities |trainer Lotheluum Starbreeze##252359 |goto Zephras Isle/0 63.98,75.09 |q 94896
|only if Druid
step
talk Ealaane Nimbuswalker##259012
turnin Aid For The Refugees##94896 |goto Zephras Isle/0 65.95,74.31
turnin The Fate of a Loved One##94897 |goto Zephras Isle/0 65.95,74.31
step
talk Talaanis Shadowsong##252476
|tip Top of the tower.
turnin Unfortunate News##92644 |goto Zephras Isle/0 66.18,76.52
accept The Cult's True Plans##94568 |goto Zephras Isle/0 66.18,76.52
|only if Alliance
step
talk Talaanis Shadowsong##252476
|tip Top of the tower.
Select _"High Elder, what about this crystal?"_ |gossip 140111
Watch the dialogue
Learn What You Can From the Crystal |q 94568/1 |goto Zephras Isle/0 66.17,76.51
|only if Alliance
step
talk Talaanis Shadowsong##252476
|tip Top of the tower.
turnin The Cult's True Plans##94568 |goto Zephras Isle/0 66.17,76.52
accept Desperate Times##92640 |goto Zephras Isle/0 66.17,76.52
|only if Alliance
step
talk Valennia Stormfist##252383
|tip Top of the tower.
Select _"Elder Shadowsong asked me to report to you for next steps."_ |gossip 137096
Select _"<Nod at Valennia.>"_ |gossip 137095
Speak with Valennia Stormfist |q 92640/1 |goto Zephras Isle/0 66.18,76.66
|only if Alliance
step
talk Ayessa Dawnsinger##251968
Select _"Zephras Isle is in need of the Windshapers!  <Explain Valennia's plan to Ayessa.>"_ |gossip 136542
Select _"Understood."_ |gossip 136541
Recruit the Windshapers |q 92640/2 |goto Zephras Isle/0 59.15,79.79
|only if Alliance
step
talk Iaadaria Bitterwind##253004
turnin Unwelcome Visitors##92741 |goto Zephras Isle/0 66.34,79.50
|only if Alliance
step
talk Elaadrin Evengale##252475
|tip Inside the building.
Select _"Zephras Isle is in need of the High Order!  <Explain Valennia's plan to Elaadrin.>"_ |gossip 136547
Select _"Understood."_ |gossip 136546
Recruit the High Order |q 92640/3 |goto Zephras Isle/0 66.63,79.93
|only if Alliance
step
talk Anathamaas Aetherwind##252373
|tip Inside the building.
Train Abilities |trainer Anathamaas Aetherwind##252373 |goto Zephras Isle/0 65.91,80.57 |q 92640
|only if Mage
step
talk Valennia Stormfist##252383
|tip Top of the tower.
turnin Desperate Times##92640 |goto Zephras Isle/0 66.18,76.66
accept Prepare for Battle##93065 |goto Zephras Isle/0 66.18,76.66
|only if Alliance
step
talk Valennia Stormfist##253844
Find Valennia on the Road |q 93065/1 |goto Zephras Isle/0 61.15,70.92
|only if Alliance
step
talk Valennia Stormfist##253844
turnin Prepare for Battle##93065 |goto Zephras Isle/0 61.15,70.92
|only if Alliance
step
talk Nyalah Brightfire##257006
|tip Inside the building.
turnin Crab Season##93317 |goto Zephras Isle/0 60.64,72.66
step
talk Seena Skybreaker##252377
|tip Inside the building.
turnin The Skybreaker Bulwark##94003 |goto Zephras Isle/0 59.89,72.86
|only if Warrior
step
talk Seena Skybreaker##252377
|tip Inside the building.
Train Abilities |trainer Seena Skybreaker##252377 |goto Zephras Isle/0 59.89,72.86 |q 93737		|only if Horde
Train Abilities |trainer Seena Skybreaker##252377 |goto Zephras Isle/0 59.89,72.86 |q 94947 |future	|only if Alliance
|only if Warrior
step
talk Eltheen Nightbreeze##252379
|tip Inside the building.
Train Abilities |trainer Eltheen Nightbreeze##252379 |goto Zephras Isle/0 59.89,72.48 |q 93737		|only if Horde
Train Abilities |trainer Eltheen Nightbreeze##252379 |goto Zephras Isle/0 59.89,72.48 |q 94947 |future	|only if Alliance
|only if Rogue
step
talk Quel'ana Quickgale##252389
|tip Inside the building.
Train Abilities |trainer Quel'ana Quickgale##252389 |goto Zephras Isle/0 59.57,72.64 |q 93737		|only if Horde
Train Abilities |trainer Quel'ana Quickgale##252389 |goto Zephras Isle/0 59.57,72.64 |q 94947 |future	|only if Alliance
|only if Hunter
step
talk Quel'dora Quickgale##254411
|tip Inside the building.
Train Pet Abilities |trainer Quel'dora Quickgale##254411 |goto Zephras Isle/0 59.60,72.53 |q 93737		|only if Horde
Train Pet Abilities |trainer Quel'dora Quickgale##254411 |goto Zephras Isle/0 59.60,72.53 |q 94947 |future	|only if Alliance
|only if Hunter
step
talk Riaani Nightwind##256083
turnin The Broken Construct##93737 |goto Zephras Isle/0 59.07,72.99
|only if Horde
step
Watch the dialogue
talk Riaani Nightwind##256083
accept The Broken Construct##93738 |goto Zephras Isle/0 59.07,72.99
|only if Horde
step
talk Endaria Mistgaze##254344
turnin Unwelcome Spirits##93736 |goto Zephras Isle/0 58.13,78.30
|only if Horde
step
talk Sessaria Skystride##252382
Train Abilities |trainer Sessaria Skystride##252382 |goto Zephras Isle/0 58.31,78.50 |q 93738
|only if Shaman
step
talk Ayessa Dawnsinger##251968
turnin The Broken Construct##93738 |goto Zephras Isle/0 59.15,79.78
|only if Horde
step
talk Muln Earthfury##259118
|tip Inside the building.
accept Child of Nature##94911 |goto Mulgore/0 33.41,22.57
|only if Horde and Druid
step
talk Alaana Stormwalker##259119
|tip Inside the building.
accept Welcome to Azeroth##95350 |goto Mulgore/0 33.35,22.54
|only if Horde
step
Jump Off the Bridge
|tip Fast travel.
Die on Purpose |complete isdead |goto Mulgore/0 34.30,25.75 |q 97246 |future
|only if Horde and not hardcore()
step
talk Spirit Healer##6491
Select _"Return me to life."_ |gossip 96031
Resurrect at the Spirit Healer |complete not isdead |goto Thunder Bluff/0 56.65,17.66 |q 97246 |future |zombiewalk
|only if Horde and not hardcore()
step
Ride an elevator up to Thunder Bluff |goto Thunder Bluff/0 52.23,25.45 < 40 |only if walking
talk Innkeeper Pala##6746
|tip Inside the building.
home Thunder Bluff |goto Thunder Bluff 45.81,64.71
|only if Horde
step
talk Turak Runetotem##3033
|tip Inside the building.
turnin Child of Nature##94911 |goto Thunder Bluff/0 76.48,27.21
accept Moonglade##94913 |goto Thunder Bluff/0 76.48,27.21
|only if Horde and Druid
step
talk Tal##2995
|tip Top of the tower.
fpath Thunder Bluff |goto Thunder Bluff 46.98,49.84
|only if Horde
step
talk Tal##2995
|tip Open the flight map.
|tip Allows guide to learn your flight paths.
|tip Top of the tower.
fpath Orgrimmar |goto Thunder Bluff 46.98,49.84
|only if Horde
step
talk Thatog##268701
|tip {o}Top floor{} inside the building.
accept Meal Appeal##97246 |goto Orgrimmar/0 55.58,72.19
|only if Horde
step
Run up the stairs |goto Orgrimmar/0 56.40,56.75 < 15 |only if walking
talk Borstan##3368
|tip Inside the building.
turnin Meal Appeal##97246 |goto Orgrimmar/0 57.19,53.33
accept Favorite Food##97249 |goto Orgrimmar/0 57.19,53.33
|only if Horde
step
talk Kor'geld##3348
|tip Inside the building.
accept Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if Horde
stickystart "Collect_Speargrass_Cuttings"
step
click Cattail+
|tip Long brown plants.
collect 2 Handful of Cattails##277278 |q 97242/1 |goto Orgrimmar/0 67.79,30.26
|only if Horde
step
label "Collect_Speargrass_Cuttings"
click Speargrass+
|tip Green grass.
collect 4 Speargrass Cuttings##277279 |q 97242/2 |goto Orgrimmar/0 67.79,30.26
|only if Horde
step
talk Kor'geld##3348
|tip Inside the building.
turnin Yelmak's Medley##97242 |goto Orgrimmar/0 56.06,34.14
|only if Horde
step
talk Yelmak##3347
|tip Walks around.
|tip Inside the building.
accept Whuut's the Rush##97275 |goto Orgrimmar/0 56.84,33.03
|tip May need to wait.
|only if Horde
step
talk Whuut##11046
|tip Inside the building.
turnin Whuut's the Rush##97275 |goto Orgrimmar/0 55.80,32.90
|only if Horde
step
talk Migi##268682
|tip Outside the building.
turnin Favorite Food##97249 |goto Orgrimmar/0 36.55,29.10
|only if Horde
step
talk Thra##268684
|tip Walks around.
|tip Outside the building.
accept Rocks to Rests##97326 |goto Orgrimmar/0 36.78,29.08
|only if Horde
step
click Smooth Boulder+
|tip Brown rocks.
collect 8 Smooth Boulder##277952 |q 97326/1 |goto Orgrimmar/0 43.83,34.70
|only if Horde
step
talk Thra##268684
|tip Walks around.
|tip Outside the building.
turnin Rocks to Rests##97326 |goto Orgrimmar/0 36.78,29.08
|only if Horde
step
talk Thrall##4949
|tip Inside the building.
turnin Welcome to Azeroth##95350 |goto Orgrimmar/0 31.74,37.82
|only if Horde
step
talk Innkeeper Gryshka##6929
|tip Inside the building.
home Orgrimmar |goto Orgrimmar 54.09,68.42
|only if Horde
step
talk Apothecary Johaan##1518
|tip Inside the building.
accept Delivery to Silverpine Forest##445 |goto Tirisfal Glades 59.45,52.40
|only if Horde
step
talk Deathguard Terrence##1738
accept The Argent Emissary##96895 |goto Tirisfal Glades/0 61.50,53.49
|only if Horde
step
talk Hadric Harlson##267009
turnin The Argent Emissary##96895 |goto Tirisfal Glades/0 65.93,61.11
accept The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
accept Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
|only if Horde
stickystart "Kill_Dark_Neophytes_And_Dark_Enforcers"
step
kill Dark Enforcer##275437, Dark Neophyte##267006
click Naxxramas Crystal Fragment+
|tip Black crystals.
collect 12 Necrotic Crystal Fragment##275851 |q 96898/1 |goto Tirisfal Glades/0 68.26,64.73
|only if Horde
step
label "Kill_Dark_Neophytes_And_Dark_Enforcers"
kill 8 Dark Neophyte##267006 |q 96897/1 |goto Tirisfal Glades/0 68.26,64.73
kill 8 Dark Enforcer##275437 |q 96897/2 |goto Tirisfal Glades/0 68.26,64.73
|only if Horde
step
talk Hadric Harlson##267009
turnin The Cult of the Damned##96897 |goto Tirisfal Glades/0 65.93,61.11
turnin Remnants of War##96898 |goto Tirisfal Glades/0 65.93,61.11
|only if Horde
step
talk Michael Garrett##4551
fpath Undercity |goto Undercity 63.28,48.58
|only if Horde
step
talk Alessandro Luca##7683
accept Prompt Potion Runner##97891 |goto Undercity/0 58.62,54.66
|only if Horde
step
Follow the path down |goto Undercity/0 52.83,77.69 < 10 |walk
talk Doctor Martin Felben##11044
Speak to Doctor Martin Felben |q 97891/1 |goto Undercity/0 46.60,74.08
|only if Horde
step
talk Doctor Martin Felben##11044
turnin Prompt Potion Runner##97891 |goto Undercity/0 46.60,74.08
|delay 0.2
|only if Horde
step
_Destroy This Item:_
|tip Not needed.
trash Inert Potion##279023
|only if Horde
step
talk Denaaris Stargale##259084
|tip Inside the building.
accept Welcome to Azeroth##94947 |goto Alterac Mountains/0 12.28,56.31
|only if Alliance
step
talk Alfina Nightgaze##270459
|tip Inside the building.
accept Child of Nature##94912 |goto Alterac Mountains/0 11.71,56.53
|only if Alliance and Druid
step
click Skyborne Portal to Stormwind
|tip Inside the building.
Take the Skyborne Portal to Stormwind |q 94947/1 |goto Alterac Mountains/0 12.04,56.21
|only if Alliance
step
Enter Stormwind Keep |goto Stormwind City 73.09,46.62 < 15 |walk |only if not subzone("Stormwind Keep")
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin Welcome to Azeroth##94947 |goto Stormwind City/0 80.20,38.33
accept Journey to Sentinel Hill##98021 |goto Stormwind City/0 80.20,38.33
|only if Alliance
step
talk Grimand Elmore##1416
|tip Inside the building.
accept Stormpike's Delivery##353 |goto Stormwind City/0 59.72,33.78
|only if Alliance
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Stormwind City/0 69.31,30.56 |q 96408 |future
|tip Walk into the portal.
|only if Alliance
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the tram to Ironforge.
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
accept Deeprun Rat Roundup##6661
|only if Alliance
step
_Inside Deeprun Tram:_
use Rat Catcher's Flute##17117
|tip On Deeprun Rats.
|tip Small grey rats.
|tip Ironforge section of the Deeprun Tram.
Capture #5# Rats |q 6661/1
|only if Alliance
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip Middle platform, near the wall.
|tip Ironforge section of the Deeprun Tram.
turnin Deeprun Rat Roundup##6661
accept Me Brother, Nipsy##6662
|only if Alliance
step
_Inside Deeprun Tram:_
Enter Ironforge |complete zone("Ironforge") |q 96408 |future
|tip Walk into the portal.
|only if Alliance
step
talk Gryth Thurden##1573
fpath Ironforge |goto Ironforge 55.50,47.75
|only if Alliance
step
talk Beldin Steelgrill##1376
accept A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 50.44,49.09
|only if Alliance
step
_NOTE:_
Tame an Ice Claw Bear
|tip Cast {o}Tame Beast{} on an Ice Claw Bear.
|tip Try to find one that's {o}level 9{}.
|tip Release your pet first.
|tip New permanent pet.
Click Here to Continue |confirm |goto Dun Morogh 51.80,44.40 |q 96408 |future
|mapmarker Dun Morogh/0 55.40,43.60
|mapmarker Dun Morogh/0 59.40,52.00
|mapmarker Dun Morogh/0 61.00,56.40
|mapmarker Dun Morogh/0 64.80,60.00
|mapmarker Dun Morogh/0 66.40,50.80
|only if Hunter	and Alliance
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin A Visitor to Dun Morogh##96408 |goto Dun Morogh/0 64.88,58.46
accept Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
|only if Alliance
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
Select _"Earthseer, please share your farsight with me."_ |gossip 139831
Use Farsen's Farsight |q 96392/1 |goto Dun Morogh/0 64.88,58.46
|only if Alliance
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Farsen's Watch##96392 |goto Dun Morogh/0 64.88,58.46
|only if Alliance
step
talk Foreman Stonebrow##1254
accept Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
|only if Alliance
step
kill 6 Rockjaw Skullthumper##1115 |q 432/1 |goto Dun Morogh/0 69.17,58.42
|tip More inside the cave nearby.
|only if Alliance
step
Leave the cave |goto Dun Morogh 70.70,56.49 < 20 |walk |only if subzone("Gol'Bolar Quarry Mine")
talk Foreman Stonebrow##1254
turnin Those Blasted Troggs!##432 |goto Dun Morogh 69.08,56.33
|only if Alliance
step
use Empty Powder Keg##268548
accept Stolen Blasting Powder##95213
|only if Alliance and itemcount(268548) > 0
step
talk Quarrymaster Thesten##1256
turnin Stolen Blasting Powder##95213
|only if Alliance and itemcount(268548) > 0
step
talk Pilot Hammerfoot##1960
|tip Follow the road through the tunnel.
accept The Lost Pilot##419 |goto Dun Morogh 83.89,39.19
|only if Alliance
step
click A Dwarven Corpse
turnin The Lost Pilot##419 |goto Dun Morogh 79.67,36.17
accept A Pilot's Revenge##417 |goto Dun Morogh 79.67,36.17
|only if Alliance
step
kill Mangeclaw##1961
|tip White bear.
|tip Walks around.
collect Mangy Claw##3183 |q 417/1 |goto Dun Morogh/0 78.97,37.02
|only if Alliance
step
talk Pilot Hammerfoot##1960
turnin A Pilot's Revenge##417 |goto Dun Morogh/0 83.89,39.19
|only if Alliance
step
talk Mountaineer Stormpike##1343
|tip Run through the tunnel.
|tip Upstairs inside the building.
turnin Stormpike's Delivery##353 |goto Loch Modan/0 24.76,18.40
accept Stormpike's Order##1338 |goto Loch Modan 24.76,18.40
|only if Alliance
step
talk Thorgrum Borrelson##1572
fpath Thelsamar |goto Loch Modan/0 33.94,50.95
|only if Alliance
step
talk Buliwyf Stonehand##11865
|tip Inside the building.
Train Two-Handed Axes |complete weaponskill("TH_AXE") > 0 |goto Ironforge 61.17,89.52
Train Two-Handed Maces |complete weaponskill("TH_MACE") > 0 |goto Ironforge 61.17,89.52
|only if Warrior and Alliance
step
Enter the Deeprun Tram |complete subzone("Deeprun Tram") |goto Ironforge 76.58,51.14 |q 1338
|tip Walk into the portal.
|only if Alliance
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the tram to Stormwind City.
talk Nipsy##13018
|tip Middle platform, near the wall.
|tip Stormwind City section of the Deeprun Tram.
turnin Me Brother, Nipsy##6662
|only if Alliance
step
_Inside Deeprun Tram:_
Enter Stormwind City |complete zone("Stormwind City") |q 1338
|tip Walk into the portal.
|only if Alliance
step
talk Furen Longbeard##5413
turnin Stormpike's Order##1338 |goto Stormwind City/0 64.60,37.22
|only if Alliance
step
talk Woo Ping##11867
|tip Inside the building.
Train Two-Handed Swords |complete weaponskill("TH_SWORD") > 0	|goto Stormwind City 63.85,69.08	|only if Warrior or Hunter
Train One-Handed Swords |complete weaponskill("SWORD") > 0	|goto Stormwind City 63.85,69.08	|only if Rogue
|only if Alliance and (Warrior or Hunter or Rogue)
step
talk Innkeeper Allison##6740
|tip Inside the building.
home Stormwind City |goto Stormwind City/0 60.39,75.27
|only if Alliance
step
Run up the ramp |goto Stormwind City 67.92,72.64 < 10 |only if walking
talk Dungar Longdrink##352
|tip Inside the building.
fpath Stormwind |goto Stormwind City 70.91,72.51
|only if Alliance
step
|next "Leveling Guides\\Westfall (13-15)"		|only if Alliance
|next "Leveling Guides\\Silverpine Forest (13-15)"	|only if Horde
]])
