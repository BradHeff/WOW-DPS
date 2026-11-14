local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("DungeonACLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Hall of Thanes (15-25)",{
image=ZGV.IMAGESDIR.."Hall of Thanes",
description="This guide will walk you through the Hall of Thanes dungeon.",
lfgid=16919,
},[[
step
Enter the Hall of Thanes Dungeon with Your Group |goto Ironforge/0 27.98,47.78 |c
step
_Inside the Hall of Thanes Dungeon:_
kill Faldrim Anvilmar##261306
|tip He patrols around the middle of Anvilmar's Rest.
|tip Clear trash around the boss before engaging.
|tip {r}Anvilmar's Curse{} will slow the tank's attacks, generating threat slower than normal.
Slay Faldrim Anvilmar |q 96395/1 |only if haveq(96395)
|confirm
step
_Inside the Hall of Thanes Dungeon:_
kill Magmatus##261316
kill Dark Iron Summoner##263438
|tip Pull Magmatus away from the Summoner and the rest of the group can handle the Summoner.
|tip Focus down the Dark Iron Summoner first.
|tip Magmatus will cast {r}Combust{} on random party members dealing heavy damage.
|tip Magmatus also has a {r}Fire Nova{} ability he uses periodically.
|confirm
step
Inside the Hall of Thanes Dungeon:
kill Plunder##261311
|tip {r}Knockback{} is the only mechanic in this fight, the tank should put their back to a wall.
|tip Pull Plunder to a safe area so you don't get knocked into other enemies.
|tip Decide a wall to gather at and stick to it for the fight.
|confirm
step
_Inside the Hall of Thanes Dungeon:_
kill Dark Iron Looter##263396
|tip Clear the Dark Iron Looters around the room before engaging the boss.
kill Lesser Stone Golem##263466
|tip Focus down the golems one by one.
kill Durgen Dirgehammer##261319
|tip He will use an area of effect version of {r}Fear{}.
|tip Use stuns to manage fear.
|tip The tank will be taking additional damage from {r}Rend{}.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Wailing Caverns (15-25)",{
image=ZGV.IMAGESDIR.."Wailing Caverns",
description="This guide will walk you through the Wailing Caverns dungeon.",
lfgid=718,
},[[
step
Enter the Wailing Caverns Dungeon with Your Group |goto Wailing Caverns/0 0.00,0.00 < 500 |c
step
kill Kresh##3653
|tip Kresh has no abilities, it is a simple tank and spank fight.
Click Here to Continue |confirm
step
kill Lady Anacondra##3671
|tip Interrupt her "Sleep" ability.
Click Here to Continue |confirm
step
kill Lord Cobrahn##3669
|tip After pulling, immediately kill the three Deviate Pythons before switching to Lord Cobrahn.
|tip Interrupt his "Sleep" ability.
Click Here to Continue |confirm
step
kill Deviate Faerie Dragon##5912
|tip It's located in the Winding Chasm before Lord Pythas.
|tip This is a rare mob that may not be available.
Click Here to Continue |confirm
step
kill Lord Pythas##3670
|tip Interrupt his "Sleep" ability.
|tip After pulling, CC the Druid of the Fang and kill the other add before switching to Pythas.
Click Here to Continue |confirm
step
kill Skum##3674
|tip "Chained Bolt" does damage to players near each other so melee DPS should spread out around the boss to avoid damage.
Click Here to Continue |confirm
step
kill Lord Serpentis##3673
|tip Interrupt his "Sleep" ability.
Click Here to Continue |confirm
step
kill Verdan the Everliving##5775
|tip "Grasping Vines" roots all players within 10 yards, knocks them down and does damage so the healer should try to keep the group's health topped off as much as possible.
Click Here to Continue |confirm
step
kill Mutanus the Devourer##3654
|tip Mutanus is spawned during an optional dungeon event that can occur if the four Lords of the Fang bosses have been defeated.
|tip These four bosses include Lady Anacondra, Lord Cobrahn, Lord Pythas and Lord Serpentis.
|tip The event is started by escorting the Disciple of Naralex through the dungeon.
|tip The Disciple of Naralex is found at the start of the dungeon.
|tip Once the Disciple reaches the ritual stone where Naralex sleeps, you will be attacked by waves of enemies.
|tip Mutanus' "Thunderclap" ability does high damage to the tank and any nearby melee DPS so ranged DPS is better for this fight.
|tip He also has two abilities, "Terrify" and "Naralex's Nightmare" that both stun/sleep players so the healer should try to keep the group's health topped off as much as possible.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Ruins of Lordaeron (15-20)",{
author="support@zygorguides.com",
image=ZGV.IMAGESDIR.."Ruins of Lordaeron",
description="This guide will walk you through the Ruins of Lordaeron dungeon.",
lfgid=16611,
},[[
step
Enter the Ruins of Lordaeron Dungeon with Your Group |goto Undercity/0 72.31,11.40 < 50 |c
|tip Our recommended route:
|tip Head straight (East) after you zone.
|tip Then down, (South).
step
kill Witherfang##250483
|tip Witherfang patrols in the area East and slightly South of where you first zone in.
|tip Kill adds before focusing on the boss.
|tip Remove {r}Leech Poison{} from the tank as it appears.
Click Here to Continue |confirm
step
kill The Baron##250660
|tip At the end of the first area (Straight South from the entrance).
|tip He performs an {r}AoE Cleave{} ability that is 360 degrees. Stay out of melee unless you need to be.
|tip Also he will {r}Knock{} the tank up into the air, if the tank does not have their back to a wall they will likely drop threat.
Click Here to Continue |confirm
step
kill The Abandoned##250631
|tip This boss is summoned from a statue in the Southwest corner of the map (West from The Baron).
|tip First 3 waves of enemies will spawn and then The Abandoned will follow.
|tip Kick or stun him when he casts {r}Drain Life{}.
Click Here to Continue |confirm
step
kill Viktor the Vile##256035
|tip Near the south-western edge of the map there will be a fireplace that summons Viktor.
|tip You will need to defeat 3 waves of enemies and then Viktor will spawn.
|tip Let the tank get AoE threat and play smart. This can be a hard gauntlet to get through.
|tip Remove {r}Leech Poison{} from the tank as it appears.
Click Here to Continue |confirm
step
kill Bjork##256097
|tip Found on the Western side of the dungeon, to the North
|tip Simple tank and spank with a knockback on the tank, place your back to a wall if you are tanking him.
Click Here to Continue |confirm
step
kill Rath'mael##250657
|tip Back towards the center of the dungeon, still on the Western side.
|tip Kick or stun him to prevent his {r}Flamestrike{} from going off.
|tip There will also be {r}Pulsing AoE damage{} coming from him affecting all players in melee range for the entire fight.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Deadmines (17-26)",{
image=ZGV.IMAGESDIR.."Deadmines",
description="This guide will walk you through the Deadmines dungeon.",
lfgid=1581,
},[[
step
Enter the building |goto Westfall/0 42.57,71.83 < 5 |walk
Jump down here |goto Westfall/0 43.42,72.89 < 5 |walk
Follow the path |goto Westfall/0 42.40,75.87 < 10 |walk
Follow the path |goto Westfall/0 41.79,78.54 < 10 |walk
Jump down here |goto Westfall/0 39.64,78.12 < 10 |walk
Enter the Deadmines Dungeon with Your Group |goto The Deadmines/0 0.00,0.00 < 500 |c
step
kill Rhahk'Zor##644
|tip Before the encounter, you can pull the 2 Defias Watchman without drawing aggro from the boss.
|tip If you cannot do this, use CC on one archer.
|tip If you can't CC, kill the adds before the boss.
|tip Be careful of patrolling elites.
Click Here to Continue |confirm
step
kill Miner Johnson##3586
|tip This is a rare mob that may not be available.
|tip He will be surrounded by Defias Miners that aren't elite.
|tip Try picking them off before engaging Miner Johnson.
|tip Click the line below if the rare spawn isn't available.
Click Here to Continue |confirm
step
kill Sneed's Shredder##642
|tip Clear the entire room before engaging Sneed's Shredder.
|tip It uses an ability called "Terrify" that will cause you to run in fear.
|tip Once the Shredder is killed, Sneed will hop out and the tank will need to pick it up quickly.
|tip It will disarm the tank so give them time to get aggro.
Click Here to Continue |confirm
step
kill Gilnid##1763
|tip A Goblin Engineer will pull when you engage him.
|tip CC the engineer, or it will summing a Remote Controlled Golem, which is immune to most abilities.
|tip If the Golem is summoned focus on the engineer.
Click Here to Continue |confirm
step
kill Mr. Smite##646
|tip When you approach the plank, he will automatically engage your group.
|tip There will be two Defias Blackguard that are stealthed.
|tip They need to die before you begin damaging Mr. Smite.
|tip At 66% and 33% he will stun the group for nearly 10 seconds.
|tip At 33% he will gain the ability to stun your tank.
|tip It will be important to keep your tank healed up.
Click Here to Continue |confirm
step
kill Captain Greenskin##647
|tip CC adds next to Captain Greenskin before pulling.
|tip Start the encounter by killing the adds, CCing as many as possible.
Click Here to Continue |confirm
step
kill Edwin VanCleef##639
|tip When you begin the encounter, there will be two Defias Blackguard that break stealth.
|tip CC and kill them before attacking Edwin VanCleef.
|tip At 50% he will summon two more adds.
|tip Repeat the process from before, killing the adds.
|tip Finish the encounter after.
Click Here to Continue |confirm
step
kill Cookie##645
|tip This is a bonus boss, on a little island below.
|tip If you want to be safe, you can clear the adds below before jumping down.
|tip Interrupt "Cookie's Cooking" spell or it heals him.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Shadowfang Keep (22-30)",{
image=ZGV.IMAGESDIR.."Shadowfang Keep",
description="This guide will walk you through the Shadowfang Keep dungeon.",
lfgid=209,
},[[
step
Enter the Shadowfang Keep Dungeon with Your Group |goto Shadowfang Keep/0 0.00,0.00 < 500 |c
step
kill Rethilgore##3914
|tip This is a straight forward encounter, with his only ability being "Soul Drain"
|tip It will immobilize the target and gain health while casting it.
Click Here to Continue |confirm
step
kill Shadow Charger##3865
|tip Pulling one of the 3 horses in the stable will pull all 3.
|tip Use CC on at least one of the horses if possible as they deal high damage.
|tip Focus them down one at a time.
|tip Make sure your healer is prepared for the enounter before starting.
Click Here to Continue |confirm
step
kill Razorclaw the Butcher##3886
|tip Clear the room before starting the encounter.
|tip The fight itself is a simple enough.
Click Here to Continue |confirm
step
kill Baron Silverlaine##3887
|tip Healers will need to watch for the "Veil of Shadow" ability when it is cast.
|tip If you have a hybrid class in your group, support the healer when this ability goes off.
|tip Veil of Shadows will reduce incoming healing by 75%.
Click Here to Continue |confirm
step
kill Commander Springvale##4278
|tip This encounter starts with two adds.
|tip Start by focus DPSing the Haunted Servitor.
|tip You can either kill the Wailing Guardsman next, or have a Warlock or Hunter pet Off-tank it.
Click Here to Continue |confirm
step
kill Odo the Blindwatcher##4279
|tip This encounter starts with two adds.
|tip They have the "Disarm" and "Cleave" abilities, so be sure to keep them away from the group as a tank.
|tip You can use CC or focus DPS them down quickly.
Click Here to Continue |confirm
step
kill Deathsworn Captain##3872
|tip This is a rare mob that may not be available.
|tip The tank should keep this boss 10 yards away from the group to avoid the AoE Silence it uses.
Click Here to Continue |confirm
step
kill Fenrus the Devourer##4274
|tip This boss has a dot ability and is otherwise simple.
Click Here to Continue |confirm
step
kill Wolf Master Nados##3927
|tip In the he room where this encounter takes place, there are 4 adds that should be killed beforehand.
|tip During the fight, he will summon additional Worg that should be killed.
Click Here to Continue |confirm
step
kill Archmage Arugal##4275
|tip For this encounter, you will want to have ranged DPS and Healers stand at the platform you entered the room in.
|tip As the encounter progresses, Arugal will teleport around the room.
|tip His standard attack, "Shadow Bolt" hits very hard.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Stockade (22-30)",{
image=ZGV.IMAGESDIR.."The Stockade",
description="This guide will walk you through The Stockade dungeon.",
lfgid=717,
},[[
step
Enter The Stockade Dungeon with Your Group |goto The Stockade/0 0.00,0.00 < 500 |c
step
kill Targorr the Dread##1696
|tip There will be Defias enemies surrounding him in the room.
|tip Use CC on the Defias before the encounter.
|tip DPS should focus on the adds before engaging Targorr the Dread.
|tip Finish off the CC'd adds after killing the boss.
Click Here to Continue |confirm
step
kill Kam Deepfury##1666
|tip There will be Defias enemies surrounding him in the room.
|tip Use CC on the Defias before the encounter.
|tip DPS should focus on the adds before engaging Kam Deepfury.
|tip Finish off the CC'd adds after killing the boss.
Click Here to Continue |confirm
step
kill Hamhock##1717
|tip There will be two Defias enemies along side Hamhock.
|tip Use CC on them if possible before starting the enounter.
|tip All DPS should focus on killing a single add at a time before switching to Hamhock.
|tip Hamhock will cast "Chain Lightning" which will deal heavy damage to bunched up allies, so spread out as best as possible.
Click Here to Continue |confirm
step
kill Bazil Thredd##1716
|tip It will be important to keep the tank topped off during this encounter.
|tip His "Smoke Bomb" ability will stun the group for 4 seconds upon use.
|tip Bazil Thredd deals high amounts of single target damage.
Click Here to Continue |confirm
step
kill Dextren Ward##1663
|tip His "Intimidating Shout" ability will cause your group to run in fear.
|tip It is important to clear any area around him before engaging.
|tip If you pull extra adds during the fear, be sure to use CC abilities on them as best you can.
|tip DPS should focus down Dextren Ward as soon as possible.
Click Here to Continue |confirm
step
kill Bruegal Ironknuckle##1720
|tip This is a rare mob that may not be available.
|tip Clear adds before engaging him and kill the boss.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Excavation Site (24-29)",{
author="support@zygorguides.com",
image=ZGV.IMAGESDIR.."Excavation Site ",
description="This guide will walk you through the Excavation Site dungeon.",
lfgid=16732,
hideif=ZGV.IsClassicSoD,
},[[
step
Follow the path |goto Wetlands/0 53.27,65.81
Enter the Excavation Site dungeon with Your Group |goto 48.22,56.49
step
_Inside the Excavation Site Wetlands Dungeon:_
|tip Clear trash around Saltspine before engaging.
kill Saltspine##260322
|tip Casts {r}Tendon Rip{} on the tank, cause severely reduced movement speed.
|tip Ranged stay at least 10 yards away to avoid being afflicted by {r}Dust Storm{}, which reduces hit chance by 25%.
|confirm
step
_Inside the Excavation Site Wetlands Dungeon:_
|tip Clear the trash around Shardtooth before engaging.
kill Shardtooth##260325
|tip Either crowd control both Thicket Hunters or just one while you focus down the other.
|tip They apply {r}Infected Wound{} to the tank, dispel this quickly.
|tip Applies {r}Rend{}, a bleed, to the tank as well.
|tip Casts {r}Terrifying Roar{}, an AoE 5 second fear, make sure you are tanking the boss in an area clear of mobs.
|tip Can be Slowed and Stunned to help mitigate the {r}Enrage{} at 30%
|confirm
step
_Inside the Excavation Site Wetlands Dungeon:_
click Archival Panel
|tip To the right of the boss.
kill Relic Guardian##260326
|tip High tank damage encounter.
|tip Ranged keep away to avoid damage from {r}Thunderclap{}.
|tip The tank will get knocked back.
|tip Uses a five second stun on the tank occasionally.
|tip Utilize stuns and slows on the boss to help mitigate damage during those times.
|confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackfathom Deeps (24-32)",{
image=ZGV.IMAGESDIR.."Blackfathom Deeps",
description="This guide will walk you through the Blackfathom Deeps dungeon.",
lfgid=719,
hideif=ZGV.IsClassicSoD,
},[[
step
Jump into the water |goto Ashenvale/0 14.12,13.88 < 10 |walk
Swim underwater into the cave |goto Ashenvale/0 13.28,13.23 < 10 |walk
Follow the path |goto Ashenvale/0 13.90,10.92 < 10 |walk
Follow the path |goto Ashenvale/0 13.74,9.38 < 10 |walk
Follow the path |goto Ashenvale/0 14.37,9.20 < 10 |walk
Follow the path |goto Ashenvale/0 16.50,11.61 < 10 |walk
Enter the Blackfathom Deeps Dungeon with Your Group |goto Blackfathom Deeps/0 0.00,0.00 < 500 |c
step
kill Ghamoo-ra##4887
|tip Ghamoo-ra has high armor so melee damage will be significantly reduced.
|tip Spread out as best as possible to avoid taking damage from "Trample".
Click Here to Continue |confirm
step
kill Lady Sarevess##4831
|tip Lady Sarevess will be patrolling a cave with 2 other Naga.
|tip It's recommended that you kill them before engaging her.
|tip Use CC abilities on her two bodyguards that accompany her.
|tip Kill the adds before starting DPS on her.
Click Here to Continue |confirm
step
kill Gelihast##6243
|tip Before starting the encounter, clear the room of the Murlocs.
|tip Be careful not to pull them with the boss while clearing them out.
|tip Once the room is clear of adds, kill Gelihast.
Click Here to Continue |confirm
step
kill Twilight Lord Kelris##4832
|tip Kelris will cast the "Sleep" ability on a random party member.
|tip The healer should keep the tank topped off in case they get slept.
|tip If there is a hybrid class in the group and the healer is slept, you may need to assist.
Click Here to Continue |confirm
step
kill Old Serra'kis##4830
|tip To unlock the door, click each brazier one at a time and defeat the wave of enemies that spawn from them.
|tip This is an optional encounter.
|tip It takes place underwater.
|tip Keep your eye out for air vents underwater.
Click Here to Continue |confirm
step
kill Aku'mai##4829
|tip Aku'mai deals high damage to a single target during "Frenzied Rage".
|tip This ability lasts for 15 seconds.
|tip High healing will be required for these phases.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Gnomeregan (29-38)",{
image=ZGV.IMAGESDIR.."Gnomeregan",
description="This guide will walk you through the Gnomeregan dungeon.",
lfgid=721,
hideif=ZGV.IsClassicSoD,
},[[
step
Enter the building |goto Dun Morogh/0 24.29,39.77 < 7 |walk
Ride the elevator down |goto Dun Morogh/0 23.41,39.21 < 10 |walk
Follow the path |goto Dun Morogh/0 21.98,36.73 < 10 |walk
Follow the path |goto Dun Morogh/0 19.93,36.02 < 10 |walk
Enter the Gnomeregan Dungeon with Your Group |goto Gnomeregan/0 0.00,0.00 < 500 |c
step
kill Grubbis##7361
|tip This boss spawns from an event started by "Blastmaster Emi Shortfuse".
|tip She will trigger an explosive tha twill cause mobs to spawn from a cave.
|tip Grubbis will eventually spawn.
Click Here to Continue |confirm
step
kill Viscous Fallout##7079
|tip Before engaging in this encounter, it is recommended that you clear the trash in the room.
|tip After that, the fight itself is simple.
Click Here to Continue |confirm
step
kill Electrocutioner 6000##6235
|tip This encounter is standard.
|tip DPS the boss down and move on.
Click Here to Continue |confirm
step
kill Crowd Pummeler 9-60##6229
|tip For this encounter, place the groups back against the wall to avoid being knocked off the ledge.
Click Here to Continue |confirm
step
kill Dark Iron Ambassador##6228
|tip This is a rare mob that may not be available.
|tip Click the line below to continue.
Click Here to Continue |confirm
step
kill Mekgineer Thermaplugg##7800
|tip For this encounter, the DPS in the group should focus down "Walking Bombs" as they close in on the group.
|tip Other than that, kill Thermaplugg in between them.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Kraul (30-40)",{
image=ZGV.IMAGESDIR.."Razorfen Kraul",
description="This guide will walk you through the Razorfen Kraul dungeon.",
lfgid=491,
},[[
step
Enter the Razorfen Kraul Dungeon with Your Group |goto Razorfen Kraul/0 0.00,0.00 < 500 |c
step
kill Roogug##6168
|tip Clear the area before engaging Roogug.
|tip If you have a warlock in your group, Banish the elemental at his side..
Click Here to Continue |confirm
step
kill Aggem Thorncurse##4424
|tip During the encounter, he will summon a boar.
|tip DPS should focus target the boar down then switch back to the boss.
Click Here to Continue |confirm
step
kill Death Speaker Jargba##4428
|tip For this encounter, he will be assisted by two caster allies.
|tip It is important to use CC abilities on them before starting the encounter.
|tip DPS should focus down the adds before switching to the boss.
|tip Death Speaker Jargba will use the "Dominate Mind" ability which will Mind Control a party member.
|tip Save all cooldowns for the boss.
Click Here to Continue |confirm
step
kill Overlord Ramtusk##4420
|tip Overlord Ramtusk deals high single target damage.
|tip He has two allies that should be CC'd.
|tip CC should be focused on the Spearhides if possible.
|tip Kill Ramtusk then the adds after.
Click Here to Continue |confirm
step
kill Agathelos the Raging##4422
|tip Agathelos the Raging deals massive single target damage.
|tip You might need back up heals if the healer can't keep up.
Click Here to Continue |confirm
step
kill Blind Hunter##4425
|tip This is a rare mob that may not be available.
|tip Have the casters stop casting when Blind Hunter is using it's "Sonic Boom" ability.
|tip Click the line below if the boss isn't there.
Click Here to Continue |confirm
step
kill Earthcaller Halmgar##4842
|tip Clear the platform before engaging then pull the boss.
|tip Kill the totem he summons as soon as they appear.
|tip If you have a Warlock, you can banish the elemental.
Click Here to Continue |confirm
step
kill Charlga Razorflank##4421
|tip Charlga Razorflank deals high damage.
|tip Pull them down fromt he hut and tank them at the platform below.
|tip The group should spread out if possible.
|tip Interrupt the "Chain Bolt" ability whenever it's being cast.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\City of Dalaran (30-38)",{
author="support@zygorguides.com",
image=ZGV.IMAGESDIR.."City of Dalaran",
description="This guide will walk you through the City of Dalaran dungeon.",
lfgid=16560,
hideif=ZGV.IsClassicSoD,
},[[
step
Enter the City of Dalaran Dungeon with Your Group |goto Silverpine Forest/0 69.28,45.55
step
_Inside the City of Dalaran Dungeon:_
talk Rexxie Copperclutch##268743
accept Opportunistic Education##96987
step
_Inside the City of Dalaran Dungeon:_
kill Atrexis the Grave Knight##247126
|tip Casts {r}Summon Frail Skeleton{}, which spawns adds that must be focused down.
|tip Allow the tank to establish threat on them before attacking.
Slay Atrexis |q 96986/1 |only if haveq(96986)
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Lyn the Ignored##247032
|tip Casts {r}Shadow Bolt Volley{} which hits everyone pretty hard.
|tip Casts {r}Curse of Thorns{} which should be dispelled if possible.
|tip Party members afflicted have a chance to take shadow damage when attacking.
|tip Occasionally summons non-elite skeleton adds that should be burned down.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Arcane Anomaly##245999
|tip Adds will spawn at the edges of the boss arena when engaging.
|tip To avoid them, simply stay within the circle.
|tip Casts {r}Focal Blast{} which rotates {g}Counterclockwise{} through the boss arena.
|tip Move and avoid being hit by the ability, as it's very likely to kill.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Mana Phantom##269475+
|tip Casts {r}Mana Burn{} on random targets.
|tip Focus down each Mana Phantom before focusing on the boss.
kill Arcanic Enigma##246016
|tip Healer stand away from the rest of ranged to avoid potential AOE {r}Silence{}.
|tip {r}Arcane Manalings{} spont continuously during the encounter and should be AOE'd down.
|tip Casts {r}Manamorph{} on random players which lasts for 8 seconds, healer should dispel.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Unstable Sentinel##246017
|tip {o}Angry Tomes{} will spawn during the fight, which should be focused down before returning to the boss.
|tip Ranged should stay at max range during the duration of the fight.
|tip {r}Malfunction{} deals AOE damage to players within 25 yards of the boss.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Fel Ancient##246003
|tip Casts {r}Fel Timbers{} which leaves green pools on the floor.
|tip Move out of them immediately.
|tip {r}Entangle{} can overlap and trap you on the patches.
|tip It targets two party members rooting them where they were hit.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Mana Devourer##246008
|tip IMMUNE to Arcane Spells.
|tip {r}Debilitate{} deals damage to everyone within 45 yards, also draining 200 mana.
|tip Casts {r}Drain Vitality{} on the current target.
|tip It leaves a DoT that lasts 10 seconds.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Shade of the Archmage##246020
|tip Spread out as much as possible.
|tip {r} Bounding Mana{} targets random players and throwns a projectile at them, that boomerangs back to the boss and hits players caught in the path.
|tip Range should keep max distance when possible to avoid {r}Arcane Explosion{}.
|tip When the boss is out of mana, he will cast {r}Mass Polymorph{}, followed by {r}Evocation{} to regenerate mana.
|tip Ranged can {g}line of sight{} Mass Polymorph, but make sure the boss does not leave the arena or it will reset.
collect Arcane Mote##251961 |q 96984/1 |only if haveq(96984)
|confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Graveyard) (29-35)",{
image=ZGV.IMAGESDIR.."Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Graveyard) dungeon.",
lfgid=798,
},[[
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
Enter the Portal |goto Tirisfal Glades/0 84.84,30.51 < 7 |walk
Enter the Scarlet Monastery - Graveyard Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway
step
kill Interrogator Vishas##3983
|tip Clear the area before engaging Interrogator Vishas.
|tip He will use "Immolate" throughout the fight, so be ready for extra healing.
Click Here to Continue |confirm
step
kill Bloodmage Thalnos##4543
|tip For this encounter, ranged DPS should spread out to avoid taking damage from AoE attacks.
Click Here to Continue |confirm
step
kill Azshir the Sleepless##6490
|tip This is a rare mob that may not be available.
|tip If you see an "Unfettered Spirit", you will be able to spawn this boss.
|tip There are 6 different spawn points across the Graveyard that appear in intervals of 10 to 15 minutes.
|tip Every 10 to 15 minutes, instead of an Unfettered Spirit, Azshir the Sleepless has a chance to spawn.
|tip It will use the "Terrify" ability which will fear the group.
|tip It will also use an ability called "Call of the Grave" which will damage an ally even after the boss is dead.
Click Here to Continue |confirm
step
kill Fallen Champion##6488
|tip This is a rare mob that may not be available.
|tip If you see an "Unfettered Spirit", you will be able to spawn this boss.
|tip There are 6 different spawn points across the Graveyard that appear in intervals of 10 to 15 minutes.
|tip Every 10 to 15 minutes, instead of an Unfettered Spirit, Azshir the Sleepless has a chance to spawn.
|tip The Fallen Champion only uses melee abilities, including "Cleave" so spread out when possible.
Click Here to Continue |confirm
step
kill Ironspine##6489
|tip This is a rare mob that may not be available.
|tip If you see an "Unfettered Spirit", you will be able to spawn this boss.
|tip There are 6 different spawn points across the Graveyard that appear in intervals of 10 to 15 minutes.
|tip Every 10 to 15 minutes, instead of an Unfettered Spirit, Azshir the Sleepless has a chance to spawn.
|tip Ironspine will use the ability "Poison Cloud" so spread out to avoid it.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Library) (31-37)",{
image=ZGV.IMAGESDIR.."Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Library) dungeon.",
lfgid=799,
},[[
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
Enter the Portal |goto Tirisfal Glades/0 85.33,32.27 < 7 |walk
Enter the Scarlet Monastery - Library Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway
step
kill Houndmaster Loksey##3974
|tip For this encounter, Loksey will be accompanied by 3 elite Scarlet Tracking Hounds.
|tip They will need to either be CC'd or killed immidiately.
|tip Once the hounds are dealt with, kill Houndmaster Loksey.
Click Here to Continue |confirm
step
kill Arcanist Doan##6487
|tip For this encounter, he will cast "Detonation" which will damage the entire group.
|tip When he does this, use the pillars to line of sight the ability.
|tip This fight is very healing intensive, so if you have a hybrid class, additional healing may be required.
|tip He will also cast "Silence" on casters.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Armory) (35-40)",{
image=ZGV.IMAGESDIR.."Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Armory) dungeon.",
lfgid=796,
},[[
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
click Armory Door |goto Tirisfal Glades/0 85.41,31.59 < 7 |walk
|tip You will need The Scarlet Key from the chest behind Arcanist Doan in the Library to open this.
|tip A rogue with 175 Lockpicking skill can pick it and a Truesilver Key opens it too.
|tip Engineers can also blast the door open.
Enter the Portal |goto Tirisfal Glades/0 85.67,31.76 < 7 |walk
Enter the Scarlet Monastery - Armory Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway
step
kill Herod##3975
|tip The tank should keep Herod at the center of the room.
|tip He will use the "Whirlwind" ability, he will become immune to magic damage.
|tip Anyone at the center of the room should move from it to avoid getting hit by it, including the tank.
|tip Casters should stay on the ledge above at all times.
|tip When Herod dies, a group of non-elites will rush the room.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery (Cathedral) (36-42)",{
image=ZGV.IMAGESDIR.."Scarlet Monastery",
description="This guide will walk you through the Scarlet Monastery (Cathedral) dungeon.",
lfgid=797,
},[[
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
click Cathedral Door |goto Tirisfal Glades/0 85.21,30.86 < 7 |walk
|tip You will need The Scarlet Key from the chest behind Arcanist Doan in the Library to open this.
|tip A rogue with 175 Lockpicking skill can pick it and a Truesilver Key opens it too.
|tip Engineers can also blast the door open.
Enter the Portal |goto Tirisfal Glades/0 85.32,30.48 < 7 |walk
Enter the Scarlet Monastery - Cathedral Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway
step
kill Scarlet Commander Mograine##3976
|tip Clear the Cathedral before starting this encounter.
|tip He will use the ability "Hammer of Justice" which will stun the target for 3 seconds.
|tip He will use the "Divine Shield" ability, which will make him invulnerable to all damage.
Click Here to Continue |confirm
step
kill High Inquisitor Whitemane##3977
|tip She will primarily cast "Holy Smite", dealing magic damage to the tank.
|tip When she is near death, she will sleep the entire party and revive Mograine.
|tip Both of their health bars will return to full adn the tank will need to pick up Mograine immidiately.
|tip DPS should focus on Whitemane, then Mograine.
Click Here to Continue |confirm
step
kill High Inquisitor Fairbanks##4542
|tip He will cast "Curse of Blood" on a party member, which can be dispelled by a mage or a druid.
|tip He will also use "Fear" and "Sleep" on random party members.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Downs (37-43)",{
image=ZGV.IMAGESDIR.."Razorfen Downs",
description="This guide will walk you through the Razorfen Downs dungeon.",
lfgid=722,
},[[
step
Enter the Razorfen Downs Dungeon with Your Group |goto Razorfen Downs 0.00,0.00 < 500 |c
step
kill Tuten'kash##7355
|tip Clear the room and ring the gong to begin the encounter.
|tip After each wave, you will need to ring the gong again until the boss appears.
|tip The tank should face the boss away from the group when it spawns.
|tip It's "Web Spray" ability will immobilize any ally in front of it.
Click Here to Continue |confirm
step
kill Mordresh Fire Eye##7357
|tip Before engaging, clear the enemies around Mordresh.
|tip The last pack of skeletons will draw the aggro of the boss.
|tip This boss is vulnerable to melee damage.
|tip Be sure to interrupt the "Fireball" ability.
Click Here to Continue |confirm
step
kill Glutton##8567
|tip Have the tank move out of it's "Disease Cloud" ability.
|tip Heavy heals will be needed when Glutton enrages.
Click Here to Continue |confirm
step
kill Ragglesnout##7354
|tip This is a rare mob that may not be available.
|tip He will use "Dominate Mind" on a random group member, including the tank or healer.
|tip It'll be important to have a back up healer or tank in case this happens.
|tip Interrupt his "Heal" ability when possible.
Click Here to Continue |confirm
step
kill Amnennar the Coldbringer##7358
|tip The tank should tank him facing the tent where he's at.
|tip The group should then stack on top of the tank to reduce damage from "Frost Nova".
|tip He will summon "Frost Spectres".
|tip As soon as one appears, the damage should switch and kill it quickly.
Click Here to Continue |confirm
step
kill Plaguemaw the Rotting##7356
|tip This is an optional fight.
|tip Speak with Belnistrasz to start the event.
|tip Waves of enemies will spawn and may require additional off tanks.
|tip When Belnistrasz is finished channeling, Plaguemaw the Rotting will spawn.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Uldaman (42-52)",{
image=ZGV.IMAGESDIR.."Uldaman",
description="This guide will walk you through the Uldaman dungeon.",
lfgid=1337,
},[[
step
Enter the Uldaman Dungeon with Your Group |goto Uldaman/0 0.00,0.00 < 500 |c
step
kill Revelosh##6910
|tip Use Crowd Control abilities on the 2 Stonevault Rockcheres if possible.
|tip If you have no Crowd Control, burn them down before the boss.
|tip Interrupt his "Chain Lightning" ability when possible.
Click Here to Continue |confirm
step
kill Ironaya##7228
|tip She is immune to Damage Over Time effects.
|tip The tank should face her away from the rest of the group to avoid them being hit with "Arcing Smash".
|tip Range spread out.
Click Here to Continue |confirm
step
kill Obsidian Sentinel##7023
|tip This boss is immunity to Damage Over Time abilities.
|tip At 66% and 33% Health, it will spawn two Obsidian Shards.
|tip DPS should switch to killing these before going back to the boss.
Click Here to Continue |confirm
step
kill Ancient Stone Keeper##7206
|tip This boss has immunity to Damage Over Time abilities.
|tip It also casts the ability "Sand Storms", which will cast Slow and Silence on those caught in it.
|tip Range spread out.
Click Here to Continue |confirm
step
kill Galgann Firehammer##7291
|tip He will be accompanied by Shadowforge Geologists.
|tip Heavy AoE damage will be inflicted upon your group.
|tip The Tank should pick up Galgann Firehammer and move him away from the Shadowforge Geologist.
|tip Keep him faced away from the group.
|tip Use Crowd Control abilities on one Shadowforge Geologist, then kill the other.
|tip After, then kill the last Shadowforge Geologist.
|tip Then, switch to Galgann and kill him.
Click Here to Continue |confirm
step
kill Grimlok##4854
|tip He is accompanied by a Stonevault Geomancer, Stonevault Brawler and a Jadespine Basilisk.
|tip Use a Crowd Control ability on one of the adds.
|tip Then, use all cooldowns and burn down Grimlok as fast as possible.
|tip After, deal with the adds.
Click Here to Continue |confirm
step
kill Archaedas##2748
|tip He will summon adds through the encounter.
|tip When they appear, all DPS should kill them as soon as possible.
|tip The fight is long, so healers should conserve mana when possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Zul'Farrak (44-49)",{
image=ZGV.IMAGESDIR.."Zul'Farrak",
description="This guide will walk you through the Zul'Farrak dungeon.",
lfgid=1176,
},[[
step
Enter the Zul'Farrak Dungeon with Your Group |goto Zul'Farrak/0 0.00,0.00 < 500 |c
stickystart "Kill_Zerillis"
step
kill Antu'sul##8127
|tip During the encounter, he will summon "Sul'lithuz Broodlings" and "Servants of Antu'sul".
|tip When they appear, all DPS should switch to the adds and kill them.
|tip He will summon various totems that should be destroyed as soon as they appear.
Click Here to Continue |confirm
step
kill Theka the Martyr##7272
|tip This is a mini boss found in the dungeon.
|tip He will cast "Fevered Plague" on group members, dealing damage over time.
|tip When he reaches 30% health, he will become immune to physical and shadow damage.
Click Here to Continue |confirm
step
kill Witch Doctor Zum'rah##7271
|tip Zum'rah will cast "Shadow Bolt Volley" which will need to be interrupted.
|tip He will also summon zombies from nearby graves that will attack you.
|tip All DPS should switch to the zombies before moving back to the boss.
|tip Whenever he summons a totem, you should also focus on those.
Click Here to Continue |confirm
step
kill Nekrum Gutchewer##7796
kill Shadowpriest Sezz'ziz##7275
|tip He will be accompanied by Shadowpriest Sezz'ziz.
|tip Have DPS burn down Nekrum Gutchewer before burning down Sezz'ziz.
|tip Be sure to interrupt Sezz'ziz' "Heal" ability throughout the encounter.
|tip After Nekrum has been defeated, quickly burn down Sezz'ziz.
Click Here to Continue |confirm
step
kill Sergeant Bly##7604
|tip He will be accompanied by a group of other elites.
|tip DPS should prioritize killing Murta Grimgut and Oro Eyegouge before all else.
Click Here to Continue |confirm
step
kill Chief Ukorz Sandscalp##7267
|tip Make sure the tank faces the bosses away from the group.
|tip Melee allies should damage him from behind to avoid its "Cleave" ability.
|tip Kill Ruuzlu, then Ukorz.
Click Here to Continue |confirm
step
kill Hydromancer Velratha##7795
|tip She patrols around a room filled with elite enemies.
|tip Clear as many as you can without pulling her.
|tip Once you've cleared a safe spot, pull Velratha into the hallway from where you fought Sergeant Bly.
Click Here to Continue |confirm
step
kill Gahz'rilla##7273
|tip To summon Gahz'rilla, you will need the "Sacred Mallet" that drops from Qiaga the Keeper in the Hinterlands.
|tip You will then need to use the mallet at the altar in Jintha'Alor, also found in the Hinterlands.
|tip Clear the entire room before ringing the gong with the "Mallet of Zul'Farrak".
|tip When engaging, the tank should face him away from the group.
|tip If you don't, the group will be tossed up in the air.
Click Here to Continue |confirm
step
label "Kill_Zerillis"
kill Zerillis##10082
|tip This is a rare mob that may not be available.
|tip He wanders all over the first half of the dungeon.
|tip Line of sight him into melee range as soon as possible.
|tip Afterwards, the fight is straight forward.
Click Here to Continue |confirm |notinsticky
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon (Wicked Grotto - Purple) (45-53)",{
image=ZGV.IMAGESDIR.."Maraudon",
description="This guide will walk you through the Maraudon (Wicked Grotto - Purple) dungeon.",
lfgid=2100,
},[[
step
click Stone Door
Enter the building |goto Desolace/0 29.11,62.56 < 5 |walk
Jump down here |goto Desolace/0 28.06,64.21 < 7 |c |walk
step
Jump down here |goto Desolace/0 27.84,62.83 < 10
Follow the path |goto Desolace/0 29.32,61.24 < 7 |walk
Follow the path |goto Desolace/0 29.67,58.58 < 7 |walk
Enter the Maraudon - Purple Dungeon with Your Group |goto Maraudon/0 0.00,0.00 < 500 |c
step
kill Lord Vyletongue##12236
|tip Have the entire group stack on top of each other to avoid the bosses ranged abilities.
|tip He will occasionally use his "Blink" ability, causing him to move away from the group.
|tip Be sure to stack in melee range of the boss as soon as possible whenever this happens.
|tip If you have a Warlock, you can banish the one of the two adds that appear.
|tip Defeat the boss, then finish the adds.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon (Foulspore Cavern - Orange) (45-53)",{
image=ZGV.IMAGESDIR.."Maraudon",
description="This guide will walk you through the Maraudon (Foulspore Cavern - Orange) dungeon.",
lfgid=2101,
},[[
step
click Stone Door
Enter the building |goto Desolace/0 29.11,62.56 < 5 |walk
Jump down here |goto Desolace/0 28.06,64.21 < 7 |c |walk
step
Jump down here |goto Desolace/0 27.84,62.83 < 10
Follow the path |goto Desolace/0 29.39,64.03 < 7 |walk
Run up the stairs |goto Desolace/0 31.30,64.06 < 10 |walk
Follow the path |goto Desolace/0 34.29,65.57 < 10 |walk
Follow the path |goto Desolace/0 35.14,62.71 < 7 |walk
Enter the Maraudon (Foulspore Cavern - Orange) Dungeon with Your Group |goto Maraudon/0 0.00,0.00 < 500 |c
step
kill Noxxion##13282
|tip Noxxion will use "Toxic Volley" which will deal damage to the entire group.
|tip During the fight, he will split into tiny versions of himself which need to be killed before you can resume damaging him again.
Click Here to Continue |confirm
step
kill Razorlash##
|tip Razorlash uses the "Cleave" ability, so ranged sould stand at max range to avoid additional damage to the group.
|tip It will also use the "Puncture" ability which will deal heavy damage to its target.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon (Poison Falls - Inner) (48-57)",{
image=ZGV.IMAGESDIR.."Maraudon",
description="This guide will walk you through the Maraudon (Poison Falls - Inner) dungeon.",
},[[
step
click Stone Door
Enter the building |goto Desolace/0 29.11,62.56 < 5 |walk
Jump down here |goto Desolace/0 28.06,64.21 < 7 |c |walk
step
Jump down here |goto Desolace/0 27.84,62.83 < 10
Follow the path |goto Desolace/0 29.32,61.24 < 7 |walk
Follow the path |goto Desolace/0 29.67,58.58 < 7 |walk
Enter the Maraudon - Purple Dungeon with Your Group |goto Maraudon/0 0.00,0.00 < 500 |c
step
kill Meshlok the Harvester##12237
|tip Meshlock patrols the waters near the start.
|tip This is a rare mob that may not be available.
|tip Ranged should stay spread out and it should be tanked away from the group.
|tip Earth Shock can interrupt spellcasting.
Click Here to Continue |confirm
step
kill Celebras the Cursed##12225
|tip The tank should pick up Corrupt Forces of Nature whenever they spawn.
|tip Focus on killing Celebras first.
|tip Interrupt Wrath whenever possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon (Earth Song Falls - Inner) (48-57)",{
image=ZGV.IMAGESDIR.."Maraudon",
description="This guide will walk you through the Maraudon (Earth Song Falls - Inner) dungeon.",
lfgid=2102,
},[[
step
click Stone Door
Enter the building |goto Desolace/0 29.11,62.56 < 5 |walk
Jump down here |goto Desolace/0 28.06,64.21 < 7 |c |walk
step
Jump down here |goto Desolace/0 27.84,62.83 < 10
Jump down here |goto Desolace/0 29.81,60.75 < 7 |walk
use Scepter of Celebras##17191
|tip This is a reward from a short quest chain given by Cavindra outside the Foulspore Cavern - Orange dungeon.
click Portal to Inner Maraudon |goto Desolace/0 29.24,61.18
Enter the Maraudon (Earth Song Falls - Inner) Dungeon with Your Group |goto Maraudon/0 0.00,0.00 < 500 |noway |c
step
kill Landslide##12203
|tip The tank should keep him where he spawns.
|tip The tank should also keep their back to the wall when possible.
|tip Ranged stay at a distance.
|tip Ranged will also need to avoid the "Theradrim Shardling" that spawns, which will disappear once the boss dies.
Click Here to Continue |confirm
step
kill Princess Theradras##12201
|tip She has the ability "Repulsive Gaze" which will fear the entire group.
|tip Use "Fear Ward" on the tank if possible.
|tip Warriors ability "Berserker Rage" can negate the fear.
|tip Also, use "Tremor Totem" if possible.
|tip Ranged group members should stay at max range to avoid being knocked back by "Dust Field".
Click Here to Continue |confirm
step
kill Rotgrip##13596
|tip Jump down into the water.
|tip Rotgrip deals high damage, so the fight will be very heal intensive.
|tip You may need support heals.
|tip Its ability "Puncture" will deal damage over time increasing this damage.
Click Here to Continue |confirm
step
kill Tinkerer Gizlock##13601
|tip The tank should face him away from the group to avoid taking damage from "Gobling Dragon Gun".
|tip After, the group should stack in close melee rang to prevent Gizlock from using his "Bomb" and "Shoot" abilities.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Temple of Atal'Hakkar (50-60)",{
image=ZGV.IMAGESDIR.."The Temple of Atal'Hakkar",
description="This guide will walk you through The Temple of Atal'Hakkar dungeon.",
lfgid=1477,
hideif=ZGV.IsClassicSoD,
},[[
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
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c
step
kill Atal'alarion##8580
|tip Clear the trash in the area as you travel around the platform.
|tip Once cleared, the group will need to spread out and click each Atal'ai Statue in the numbered order indicated on the map.
|tip The Atal'ai Statue will be green if done correctly and Atal'alrion will appear at the center of the room.
|tip He has a threat clearing abilitiy, so it will be important for the tank to keep taunt available.
|tip He will also knock players into the air who will take fall damage after.
|tip Healers should focus on the member who got knocked into the air as soon as they land.
|tip Tanks should keep the boss near a wall and be prepared to kite if the group healer gets knocked into the air.
Click Here to Continue |confirm
step
Kill the Atal'ai Defenders
|tip There will be 6 sub bosses you need to kill.
|tip To start, clear the Pit of Refuse of all mobs.
|tip You'll run up the stairs and reach an area similar to the Atal'ai Statue area for the previous boss.
|tip Instead of activating the Atal'ai Statues, there will be the bosses Loro, Gasher, Mijan, Zolo, Zul'lor and Hukku.
Click Here to Continue |confirm
step
kill Jammal'an the Prophet##5710
kill Ogom the Wretched##5711
|tip After defeating the Atal'ai Defenders, the way to Jammal'an will open up.
|tip Clear the trash in the Lair of the Chosen, watching out for Atal'ai Deathwalkers "Fear" abilitiy.
|tip Ghosts will spawn when some of the enemies die here, all of which you can do is kite run away from them.
|tip Engage once all enemies are clear.
|tip Separate Jammal'an and Ogum when the fight starts, killing Ogom as soon as possible.
|tip Then, spread out as best you can.
|tip Jammal'an will use the "Hex of Jammal'an" ability, transforming a party member into a hostil Berserker.
|tip Switch damage to the "Hex of Jammal'an" then burn down the boss as quick as possible.
Click Here to Continue |confirm
step
kill Dreamscythe##5721
kill Weaver##5720
|tip The tank should keep their back to the wall and keep all drakes facing away from the party.
|tip All of their abilities hit in front of it, so this will save you needless healing.
Click Here to Continue |confirm
step
kill Hazzas##5722
kill Morphaz##5719
|tip Similar to the last encounter, the tank should keep their back to the wall and keep all drakes facing away from the party.
|tip All of their abilities hit in front of it, so this will save you needless healing.
Click Here to Continue |confirm
step
kill Shade of Eranikus##5709
|tip Clear all dragon enemies before pulling this boss or they will swarm you.
|tip All ranged should stay at max distance to avoid being stunned by its "War Stomp" ability.
|tip The abilities "Fade" for Priest, "Blessing of Salvation" for Paladin and "Feint" for Rogues should be used to mitigate threat when possible.
|tip The target with the highest threat will be the target of Eranikus' "Deep Slumber" ability, which will make you unable to act for 15 seconds.
|tip Melee never stand in front of this boss.
|tip This is a long fight so side heals might be necessary.
Click Here to Continue |confirm
step
kill Avatar of Hakkar##8443
|tip Clear trash in the Sanctum of the Fallen God.
|tip This boss can only be summoned by using the "Egg of Hakkar" which is for the quest "The God Hakkar".
|tip Players whom have completed the quest can use "Yeh'kinya's Scroll" to summon as well.
|tip Once used, kill adds that spawn.
|tip Eventually, a Hakkari Bloodkeeper spawns.
|tip Collect the "Hakkari Blood" from their corpse and extinguish the Braziers in the room.
|tip Repeat the process until all are extinguished.
|tip The Avatar of Hakkar will use "Cause Insanity" on random players.
|tip CC or Stun the player if possible until it wears off.
|tip He will also use "Shadow Word: Pain" which should be dispelled when possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackrock Depths (52-60)",{
image=ZGV.IMAGESDIR.."Blackrock Depths",
description="This guide will walk you through the Blackrock Depths dungeon.",
lfgid=1584,
},[[
step
Run down the chain |goto Searing Gorge/0 37.25,94.39 < 5 |walk
Enter the building |goto Searing Gorge/0 35.91,100.22 < 7 |c
step
Continue down and run down the chain |goto Searing Gorge/0 34.86,99.20 < 5 |walk
Enter the building |goto Searing Gorge/0 32.55,94.94 < 5 |walk
Follow the path |goto Searing Gorge/0 26.88,83.87 < 30 |walk
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c
step
kill High Interrogator Gerstahn##9018
|tip Her most dangerous ability is "Psychic Scream" which will fear the entire group, possibly leading to adds being pulled.
|tip "Fear Ward" and "Tremor Totem" will come in very handy during this encounter.
|tip Fight her in a corner of the room to try and control where your party runs during fear.
|tip Dispel her "Shadow Word: Pain" when applicable.
|tip Interrupt her "Mana Burn" when possible also.
|tip The "Prison Cell Key" is important to loot from her before moving on.
Click Here to Continue |confirm
step
kill Lord Roccor##9025
|tip This boss can use "Earth Shock" which will interrupt any casters spells and prevent casting for 2 seconds.
|tip It also casts "Flame Shock" which will leave a dot on a party member.
Click Here to Continue |confirm
step
kill Houndmaster Grebmar##9319
|tip Before engaging him, pull and kill the two packs of hounds patrolling the room with him.
|tip Range should keep their distance to avoid being interrupted with "Pummel".
|tip Other than that, this is a pretty straight forward encounter.
Click Here to Continue |confirm
step
Defeat the Ring of the Law
|tip There are multiple bosses that can appear in this event.
|tip Gorosh the Dervish: Spread out to avoid "Whirlwind" damage and try to heal outside of "Mortal Strike".
|tip Grizzle: Range should stay at max distance to avoid "Earth Shock".
|tip Eviscerator: If applicable, have a priest use "Shadow Protection".
|tip Ok'Thor the Breaker: He will use "Polymorph" on a random player in the group, which will need to be dispelled asap.
|tip Anub'Shiah: Dispel it's "Curse of Tongues" and "Enveloping Web" abilities immidiately.
|tip Hedrum the Creeper: Dispel the it's "Paralyzing Poison" and "Baneful Poison" when possible.
Click Here to Continue |confirm
step
kill Fineous Darkvire##9056
|tip Clear all enemies along the path he patrols before engaging.
|tip This boss hits very hard, so extra healing may be required.
|tip Be sure to interrupt his "Holy Light" as to not prolong the encounter.
|tip Ranged should keep their distance as he will interrupt you otherwise.
Click Here to Continue |confirm
step
kill Lord Incendius##9017
|tip The most important thing for this encounter is to not get knocked off the platform.
|tip Avoid its "Mighty Blow" ability to ensure that.
Click Here to Continue |confirm
step
kill Pyromancer Loregrain##9024
|tip This is an optional boss and may be skipped.
|tip Destroy his totems when they are summoned.
Click Here to Continue |confirm
step
kill Bael'Gar##9016
|tip This is an optional boss and may be skipped.
|tip He will spawn adds which need to be killed quickly.
|tip The tank will need to face him away from the group to prevent damage from "Magma Splash".
Click Here to Continue |confirm
step
kill General Angerforge##9033
|tip This boss is optional.
|tip During the encounter, he will summon adds which need to be AoE'd down.
|tip Aside from the tanks picking up adds, the fight is straight forward.
Click Here to Continue |confirm
step
kill Golem Lord Argelmach##8983
|tip This boss is optional.
|tip Have the group spread out as far as possible.
Click Here to Continue |confirm
step
kill Phalanx##9502
|tip Purchase 6 Dark Iron Ale Mugs from Plugger and give them to Private Rocknot.
|tip This will enrage him and cause Phalanx to burst through the door.
|tip The group should spread out as far as possible to avoid "Thunderclap".
|tip Heavy AoE healing will be needed for the encounter.
Click Here to Continue |confirm
step
kill Ambassador Flamelash##9156
|tip During the encounter, adds will spawn.
|tip They will need to be killed before reaching Flamelash.
Click Here to Continue |confirm
step
kill Panzor the Invincible##8923
|tip This is a rare mob that may not be available.
|tip Casters need to watch out for its "Spell Reflection" ability.
Click Here to Continue |confirm
step
Defeat the Chest of the Seven Encounter
|tip They will spawn and come at you one at a time.
|tip Each possesses a couple of weakened abilities from a class.
|tip Interrupt whenever possible and burn them down quickly.
Click Here to Continue |confirm
step
kill Magmus##9938
|tip To open the door, kill Shadowforge Flame Keepers and collect two Shadowforge Torches.
|tip Use them to light the braziers that open the door to Magmus.
|tip For this encounter, the tank will need to position Magmus properly.
|tip If this doesn't happen, the group will take heavy damage from the flame vents in the room.
Click Here to Continue |confirm
step
kill Emperor Dagran Thaurissan##9019
|tip During the encounter, your group will need to decide what to do with Princess Moira Bronzebeard.
|tip Keep her CC'd if you chose to save her while keeping her away from AoE damage.
|tip If you fail to keep her controlled, have a group member dedicated to interrupting her healing abilities.
|tip Kill adds then focus on the boss.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scholomance (58-60)",{
image=ZGV.IMAGESDIR.."Scholomance",
description="This guide will walk you through the Scholomance dungeon.",
lfgid=2057,
},[[
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
kill Blood Steward of Kirtonos##14861
|tip She has 3 abilities to look out for:
|tip "Curse of Impotence" reduces magic damage output on the target and can be removed by a Mage or Druid.
|tip "Curse of Weakness" reduces the melee damage output on the target and can be removed by a Mage or Druid.
|tip "Paralyzing Poison" should be removed by a Druid, Shaman or Paladin if possible.
Click Here to Continue |confirm
step
kill Kirtonos the Herald##10506
|tip This boss is summoned by "Blood of Innocents", obtained from Blood Steward of Kirtonos, Doctor Theolen Krastinov and Jandice Barov.
|tip Use it on the porch to summon Kirtonos.
|tip The tank should keep their back to the wall to prevent knockback.
|tip While in human form, he will use various curses that can be dispelled by Mages and Druids.
|tip Once he transforms into a Gargoyle, the fight becomes very straight forward.
Click Here to Continue |confirm
step
kill Jandice Barov##10503
|tip She will use the ability "Curse of Blood" which should be dispelled by Mages and Druids.
|tip She will also summon Illusions of herself, which will need to be killed.
|tip They cannot be AoE'd so you will need to single target damage all of them.
Click Here to Continue |confirm
step
kill Rattlegore##11622
|tip Carefully clear the area around Rattlegore before engaging.
|tip He hits hard, so this fight will be healing intensive.
|tip The tank should face him away from the group.
|tip The Viewing Room Key comes from this encounter, which lets you progress further into the dungeon.
Click Here to Continue |confirm
step
kill Marduk Blackpool##10433
|tip The tank should keep Marduk stationary when possible.
|tip Range should stand far enough back to avoid being hit by Defiling Aura.
|tip When he casts "Shadow Shield", melee will take extra damage each time they hit.
Click Here to Continue |confirm
step
kill Vectus##10432
|tip Avoid standing in his "Flamestrikes" radius when cast.
Click Here to Continue |confirm
step
kill Ras Frostwhisper##10508
|tip Clear the area around him before engaging.
|tip The tank should face him away from the group.
|tip If possible, interrupt his "Fear" ability, as well as his "Frostbolt Volley".
Click Here to Continue |confirm
step
kill Instructor Malicia##10505
|tip For this encounter, it is important to interrupt her "Heal" ability.
|tip Druids and Mages should keep an eye out for "Call of the Grave" which sould be dispelled as soon as possible.
Click Here to Continue |confirm
step
kill Doctor Theolen Krastinov##11261
|tip The tank should pull Theolen and keep their back to the wall.
|tip The tank should also save defensive abilities for when the boss reaches 50% health.
|tip He will gain 50% increased attack speed at that point, making the fight healing intensive.
Click Here to Continue |confirm
step
kill Lorekeeper Polkelt##10901
|tip He should be tanked at the lower level of the room, while all ranged stay at the top level and DPS/Heal from the balcony.
|tip Anyone afflicted by "Volatile Infection" needs to move away from the rest of the party.
Click Here to Continue |confirm
step
kill The Ravenian##10507
|tip The tank should stand with their back to a wall, facing Ravenian away from the group.
|tip Melee watch out for its "Cleave" and "Sundering Cleave" ability.
Click Here to Continue |confirm
step
kill Lord Alexei Barov##10504
|tip He is accompanied by two skeleton body guards which can be CC'd with either a Priests "Shackle Undead" or a Paladins "Turn Undead".
|tip In the room, there is green liquid on the ground which the group must stay out of.
|tip The tank must bull Alexei to max range from range so they don't take damage from "Unholy Aura".
|tip Mages and Druids must dispel "Veil of Shadow" when a party member is afflicted with it.
Click Here to Continue |confirm
step
kill Lady Illucia Barov##10502
|tip She used the "Dominate Mind" ability on random party members.
|tip Use CC abilities on them when it happens.
|tip Clear the entire room to avoid pulling adds from her "Fear" ability.
|tip She also uses the "Silence" ability, which will disable nearby casters from using spells.
Click Here to Continue |confirm
step
kill Darkmaster Gandling##1853
|tip The tank should keep him where he spawns if possible, while ranged stay stay at the top of the stairs.
|tip During the encounter, he will teleport a random player to one of the rooms where previous bosses were.
|tip That player will be locked in until the kill all enemies inside.
|tip This includes the tank!
|tip If the tank is teleported, you will need to kit the boss around the room until they are out.
|tip Interrupt "Arcane Missile" on rotation.
|tip Mages and Druids should dispel "Improved Shadow Bolt" as soon as possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Stratholme - Live (58-60)",{
image=ZGV.IMAGESDIR.."Stratholme",
description="This guide will walk you through the Stratholme - Live dungeon.",
lfgid=2017,
},[[
step
Enter the Stratholme - Live Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c
stickystart "Kill_Postmaster_Malown"
step
click Premium Siabi Tobacco
|tip It's a small wooden box on the ground.
kill Fras Siabi##11058
|tip Spread out as best you can to avoid being hit by "Flame Breath".
|tip He will use "Smoke Bomb" which will stun anybody caught by it.
Click Here to Continue |confirm
step
kill Skul##10393
|tip This is a rare mob that may not be available.
|tip There are two spots he can spawn; Just before Fras Siabi and on the east portion of the map.
|tip Interrup its spells when possible.
Click Here to Continue |confirm
step
kill Hearthsinger Forresten##10558
|tip This is a rare mob that may not be available.
|tip He can spawn after the rat gate.
|tip Spread out a little to avoid being hit with "Multi-Shot".
|tip He will randomly cast "Enchanting Lullaby" on a random player.
Click Here to Continue |confirm
step
kill The Unforgiven##10516
|tip This boss spawns as you walk through the gate at the opposite end to where Timmy the Cruel is.
|tip Be sure your health and mana are healed up before passing through the gate.
|tip He will have non elite adds along with him.
Click Here to Continue |confirm
step
label "Kill_Postmaster_Malown"
kill Postmaster Malown##11143
|tip To summon this boss, kill "Stratholme Couriers" found throughout the instance.
|tip Collect the "Market Row Postbox Keys".
|tip Next, find and open 3 of the locked Mailboxes.
|tip Each mailbox will spawn a group of hard-hitting elites.
|tip Let the tank open them if possible.
|tip On the 3rd, Malown will spawn close to where Fras Siabi was.
|tip If you haven't already, clear the area to avoid pulling adds during "Fear".
|tip Mages and Druids should dispel "Curse of Tongues" when possible.
Click Here to Continue |confirm |notinsticky
step
kill Timmy the Cruel##10808
|tip He will heal while using "Ravenous Claw", but other than that the fight is straight forward.
Click Here to Continue |confirm
step
kill Malor the Zealous##11032
|tip During the fight, he will use the "Lay on Hands" ability which will heal him significantly.
|tip The chest behind him contains the "Medallion of Faith" for the quest The Medallion of Faith.
Click Here to Continue |confirm
step
click Blacksmithing Plans
|tip They are on the floor near boxes in the room.
kill Crimson Hammersmith##11120
|tip This mob can be skipped if no one in the group needs the "Bottom Half of Advanced Armorsmithing: Volume II" for Blacksmithing.
Click Here to Continue |confirm
step
kill Cannon Master Willey##10997
|tip He has no special abilities to account for.
Click Here to Continue |confirm
step
kill Archivist Galford##10811
|tip His ability "Burning Winds" is a high damage DoT that will make this fight healing intensive.
|tip If the tank is hit with the ability, the Galford may swap targets.
Click Here to Continue |confirm
step
kill Balnazzar##10813
|tip He uses the "Domination" ability on random players in the group.
|tip Use CC on them to mitigate any damage they might do to the part.
|tip Casters should stand at max range to avoid being feared.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Stratholme - Undead (58-60)",{
image=ZGV.IMAGESDIR.."Stratholme",
description="This guide will walk you through the Stratholme dungeon.",
lfgid=2018,
},[[
step
click Elders' Square Service Gate |goto Eastern Plaguelands/0 41.43,17.71 < 10 |walk
|tip This requires the Key to the City, which drops from Magistrate barthilas in Stratholme - Live.
Enter the Stratholme - Undead Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c
step
kill Magistrate Barthilas##10435
|tip The tank should keep their back to the wall.
|tip He uses the "Mighty Blow" ability which will knockback the tank.
Click Here to Continue |confirm
stickystart "Kill_Stonespine"
step
kill Nerub'enkan##10437
|tip During the fight, it will summon "Crypt Scarabs" which will need to be AoE'd down.
|tip It also uses "Pierce Armor" on the tank.
|tip When this happens, the tank should use damage mitigating abilities.
Click Here to Continue |confirm
step
click Blacksmithing Plans
|tip They are near the buildings to the right of Baroness Anastari.
kill Black Guard Swordsmith##11121
|tip This mob can be skipped if no one in the group needs the "Bottom Half of Advanced Armorsmithing: Volume I" for Blacksmithing.
Click Here to Continue |confirm
step
kill Baroness Anastari##10436
|tip She will use the "Possess" ability which will mind control a random party member.
|tip To break the Possess, you will need to damage the target to 50% health.
|tip "Banshee Curse" should be dispelled by Mages and Druids.
|tip She will also use the "Silence" ability randomly throughout the encounter.
Click Here to Continue |confirm
step
label "Kill_Stonespine"
kill Stonespine##10809
|tip This is a rare mob that may not be available.
|tip It uses the "Vicious Rend" ability which will inflict heavy damage to the target.
Click Here to Continue |confirm |notinsticky
step
kill Maleki the Pallid##10438
|tip He uses the ability "Ice Tomb" which most of the time will target the tank.
|tip DPS should slow when this happen so they don't pull aggro.
Click Here to Continue |confirm
step
kill Ramstein the Gorger##10439
|tip Clear the room before engaging the boss.
|tip Tank him with your back when possible.
Click Here to Continue |confirm
step
kill Baron Rivendare##10440
|tip The tank should pull him to the right side of the room.
|tip Ranged should stand atop the bone piles located throughout the room.
|tip Melee stack up behind the boss to avoid the "Cleave" ability.
|tip When the adds spawn, dps should focus them down before going back to the boss.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul East (58-60)",{
image=ZGV.IMAGESDIR.."Dire Maul",
description="This guide will walk you through the Dire Maul - East dungeon.",
lfgid=2557,
},[[
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
Continue following the path |goto Feralas/0 64.85,30.18 < 7 |only if walking
Enter the Dire Maul - East Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c
step
kill Pusillin##14354
|tip He drops the "Crescent Key" which is needed for progression in the dungeon.
|tip To start, engaging him will cause 4 Wildspawn Imps to spawn.
|tip AoE them down as quickly as possible.
|tip Interrupt his "Fireball" ability when possible.
|tip When he has the "Spirit of Runn Tum" buff, he has a 50% chance to reflect spells back to casters.
Click Here to Continue |confirm
step
kill Lethtendris##14327
|tip Interrupt her "Void Bolt" when possible.
|tip Mages and Druids should dispel "Curse of Tongues" and "Curse of Thorns" when group members are afflicted.
|tip Kill her imp, Pimgib, then her after.
Click Here to Continue |confirm
step
kill Hydrospawn##13280
|tip Kill the Hydrolings that spawn before focusing on the boss.
Click Here to Continue |confirm
step
kill Zevrim Thornhoof##11490
|tip During the encounter, he will teleport random group members to his ritual and cast "Sacrifice" on them.
|tip The target will need big heals to survive.
|tip He will also use an AoE ability "Shadow Word: Pain" which should be dispelled as quickly as possible.
Click Here to Continue |confirm
step
kill Alzzin the Wildshaper##11492
|tip Clear all mobs as you go down the ramp, or they will aggro as adds when you begin the encounter.
|tip During the encounter, Alzzin will shapeshift, dropping all established aggro.
|tip Give the tank time to establish aggro before resuming DPS.
|tip Cleanse the "Wither" spell he casts when possible.
|tip When he casts "Wither" it can also be interrupted.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul North (58-60)",{
image=ZGV.IMAGESDIR.."Dire Maul",
description="This guide will walk you through the Dire Maul - North dungeon.",
lfgid=2558,
},[[
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 62.49,24.89 < 5 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - North Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c
step
kill Guard Mol'dar##14326
|tip Ranged should keep at a distance to avoid his "Knock Away" and "Shield Charge" abilities.
Click Here to Continue |confirm
step
kill Stomper Kreeg##14322
|tip His main ability is "Booze Spit" which will reduce the groups accuracy by 75%.
Click Here to Continue |confirm
step
kill Guard Fengus##14321
|tip Like Mol'dar, ranged should keep a distance to avoid being hit by "Knock Away" and "Shield Charge".
Click Here to Continue |confirm
step
kill Guard Slip'kik##14323
|tip Like Mol'dar, ranged should keep a distance to avoid being hit by "Knock Away" and "Shield Charge".
Click Here to Continue |confirm
step
kill Captain Kromcrush##14325
|tip He hits hard so the fight will be healing intensive.
|tip He uses the ability "Intimidating Shout" which will fear your group, so clear the room.
|tip At 50% Health he summons 2 Gordok Reavers, which should be CC'd.
|tip Casters stay at max range of the boss.
Click Here to Continue |confirm
step
kill Cho'Rush the Observer##14324
kill King Gordok##11501
|tip DPS should focus on killing Cho'Rush first.
|tip Keep an eye out for King Gordok's "Heal" ability and interrupt it when possible.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul West (58-60)",{
image=ZGV.IMAGESDIR.."Dire Maul",
description="This guide will walk you through the Dire Maul - West dungeon.",
lfgid=2559,
},[[
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 60.32,30.16 < 10 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - West Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c
step
kill Tendris Warpwood##11489
|tip Clear all ancients in the area before engaging Tendris.
|tip Melee should move away when it uses the "Trample" ability.
|tip Range stand at max distance to avoid being hit with "Entangle".
Click Here to Continue |confirm
step
kill Magister Kalendris##11487
|tip Dispel "Shadow Word: Pain" when an ally is afflicted by it.
|tip Interrupt his "Mind Blast" and "Mind Flay" spells when possible.
|tip Use CC abilities on group members who are afflicted by "Dominate Mind".
Click Here to Continue |confirm
step
kill Tsu'zee##11467
|tip This will be a healing intensive encounter.
|tip Dispel her "Blind" ability on allies when afflicted.
Click Here to Continue |confirm
step
kill Illyanna Ravenoak##11488
|tip The group should stand in melee range to avoid her abilities.
|tip Kill Illyanna, then Ferra after.
Click Here to Continue |confirm
step
kill Immol'thar##11496
|tip He will use the "Eye of Immol'thar" ability during the encounter, spawning eye enemies around the room.
|tip Designate a ranged attack to deal with them.
|tip At 50% health, he will enrage, increasing his attack speed by 60%.
|tip At this point, it will become a healing intensive encounter.
Click Here to Continue |confirm
step
kill Prince Tortheldrin##11486
|tip This is a healing intensive fight.
|tip The tank should face their back to the wall to avoid being knocked back by his "Arcane Blast" ability.
|tip When Arcane Blast is used, his aggro will reset, so it's best to stop DPS until the tank can establish aggro once more.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul North Tribute (58-60)",{
image=ZGV.IMAGESDIR.."Dire Maul",
description="This guide will walk you through the Dire Maul North dungeon.",
lfgid=2558,
},[[
step
collect Frost Oil##3829
|tip An Alchemist can make this with 4 Khadgar's Whisker, 2 Wintersbite and 1 Leaded Vial.
|tip You can also purchase this from the Auction House.
step
collect Thorium Widget##15994
|tip An Engineer can make this with 3 Thorium Bars and 1 Runecloth.
|tip You can also purchase this from the Auction House.
step
Enter Dire maul - North
|tip In the Tribute run, you won't be killing any boss save for King Gordok.
Click Here to Continue |confirm
step
Avoid Guard Mol'dar
|tip To accomplish this, avoid entering the Courtyard in the first area.
|tip Run along the ledges of the room.
Click Here to Continue |confirm
step
Avoid Stomper Kreeg
|tip He has a short aggro range.
|tip By moving along the left side of the room as soon as you enter the instance you will completely avoid him.
Click Here to Continue |confirm
step
Avoid Guard Fengus
|tip Hug the right side of the room, the use the ramp up North to sneak to Fengus' Chest.
|tip He patrols around the area so keep an eye out.
click Fengus's Chest
collect Gordok Courtyard Key##18266
Click Here to Continue |confirm
step
Avoid Guard Slip'kik
|tip Clear the room of trash while watching for his patrol.
click Broken Trap
turnin A Broken Trap##1193
|tip Activate the trap, then drag Guard Slip'kik to it.
Click Here to Continue |confirm
step
For Captain Kromcrush:
use the Gordok Ogre Suit##18258
|tip Clear nearby trash without pulling him before doing this.
talk Captain Kromcrush##14325
Select _"Um, I'm taking some prisoners we found outside before the king for punishment."_
|tip If someone else in the group has the suit and you don't, they will need to do this.
|tip A member of the group will need the Gordok Inner Door Key from Guard Mol'dar from a previous run.
Click Here to Continue |confirm
step
kill King Gordok##11501
|tip Use CC on Cho'Rush the Observer when possible.
|tip Be sure not to kill Cho'Rush the Observer.
step
click Gordok Tribute
|tip It's at Gordok's seat just before the boss encounter.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Lower Blackrock Spire (55-60)",{
image=ZGV.IMAGESDIR.."Lower Blackrock Spire",
description="This guide will walk you through the Lower Blackrock Spire dungeon.",
lfgid=1583,
},[[
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c
step
kill Spirestone Butcher##9219
|tip This is a rare mob that may not be available.
Click Here to Continue |confirm
step
kill Spirestone Battle Lord##9218
|tip This is a rare mob that may not be available.
Click Here to Continue |confirm
step
kill Highlord Omokk##9196
|tip CC one of the two adds that accompany him.
|tip The tank should stand away from the group after picking up Highlord Omokk.
|tip Ranged should stand with their backs to a wall.
|tip If you can't CC more than one, kill the add, then Omokk.
|tip Omokk hits hard so the fight will be healing intensive.
Click Here to Continue |confirm
step
kill Shadow Hunter Vosh'gajin##9236
|tip She will be accompanied by 2 "Smolderthorn Shadow Priests".
|tip CC one of them.
|tip The tank should take Shadow Hunter Vosh'gajin away from the group.
|tip DPS down the Priests one at a time, then focus on Shadow Hunter Vosh'gajin.
|tip Mages and Druids should remove the "Curse of Blood" ability.
|tip Spread out as best as possible to avoid multiple group members being afflicted by "Hex".
Click Here to Continue |confirm
step
kill War Master Voone##9237
|tip Clear the rooms leading up to him before engaging.
|tip War master Voone hits hard, so this will be a healing intensive fight.
|tip Wait for the tank to establish aggro before DPS jumps in.
|tip The tank should have their back to a wall during the encounter.
|tip If Voone changes targets, all DPS should stop until the tank re establishes aggro.
Click Here to Continue |confirm
step
kill Bannok Grimaxe##9596
|tip This is a rare mob that may not be available.
|tip He can spawn in any of the packs of mobs around tents, and sometimes patrols.
Click Here to Continue |confirm
step
kill Mother Smolderweb##10596
|tip On the way to her, Druids can use the "Hibernate" ability to CC them if one is available.
|tip When you reach her, the tank should face her away from the group to avoid her "Crystallize" ability.
|tip Her "Mother's Milk" ability will temporarily stun party members.
Click Here to Continue |confirm
step
kill Crystal Fang##10376
|tip This is a rare mob that may not be available.
Click Here to Continue |confirm
step
kill Urok Doomhowl##10584
|tip Collect the Pike on the ledge just after Mother Smolderweb.
|tip Whoever picked up Omokk's Head should do this.
|tip Clear the room of ogres then combine the two to summon Urok Doomhowl.
|tip After, waves of elite ogres will spawn.
|tip Clicking the pike will insta kill one of the ogres every 30 seconds.
|tip Use CC on additional ogres to mitigate damage to the group.
|tip Eventually, Urok will spawn.
|tip Let your tank establish aggro before engaging.
Click Here to Continue |confirm
step
kill Quartermaster Zigris##9736
|tip Clear the entire room that he patrols before engaging him.
|tip Avoid him when possible, until the room is clear by waiting for him to patrol past the group.
Click Here to Continue |confirm
step
kill Halycon##10220
|tip Halycon will be accompanied by "Worg Pups" which will need to be AoE'd down.
|tip The tank should pick up Halycon while this is happening, establishing aggro.
|tip Once the adds are taken care of, DPS should move to Halycon.
|tip Replenish health and mana as soon as it dies as the next boss will be entering the room.
Click Here to Continue |confirm
step
kill Gizrul the Slavener##10268
|tip This boss hits hard, so it will be a healing intensive fight.
|tip It heals with each use of "Fatal Bite", dealing out massive damage to the tank.
|tip It will also use the "Infected Bite" ability on your tank.
|tip Let the tank establish aggro before starting DPS.
Click Here to Continue |confirm
step
kill Overlord Wyrmthalak##9568
|tip The tank needs to face Wyrmthalak away from the group.
|tip Melee be sure to stand behind him to avoid its "Cleave" ability.
|tip CC adds as the spawn and DPS Overlord Wyrmthalak as fast as possible, moving to the adds after he is dealth with.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Upper Blackrock Spire (55-60)",{
image=ZGV.IMAGESDIR.."Upper Blackrock Spire",
description="This guide will walk you through the Upper Blackrock Spire dungeon.",
lfgid=1582,
},[[
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c
step
click Blackrock Altar
|tip This will start the fight.
kill Pyroguard Emberseer##9816
|tip The Tank should keep him away from the group.
|tip Melee will need extra heals during the encounter from its AoE attacks.
Click Here to Continue |confirm
step
kill Solakar Flamewreath##10264
|tip Clear all dragon spawn before starting the event.
|tip Click on father flame and take the item to start the event.
|tip DPS need to focus down "Rookery Hatchers" as quickly as possible.
|tip AoE down whelps that spawn meanwhile.
|tip Tanks pick up "Rookery Guardians" as soon as they appear.
|tip Tanks should have their backs to the wall for these.
|tip After a bit, Solakar will spawn, who will also need to be tanked with against the wall.
|tip Finish off the whelps before switching DPS to Solakar.
|tip Hug the wall after to avoid spawning additional whelps.
Click Here to Continue |confirm
step
kill Jed Runewatcher##10509
|tip This is a rare mob that may not be available.
|tip The tank should have their back to the wall.
|tip All ranged should be at max distance as well.
Click Here to Continue |confirm
step
kill Goraluk Anvilcrack##10899
|tip The tank should have their back to the wall.
|tip All ranged should be at max distance as well.
Click Here to Continue |confirm
step
kill Warchief Rend Blackhand##10429
kill Gyth##10339
|tip They will spawn after clearing the gauntlet of orcs and dragon spawn.
|tip Focus on Flame Tongues, Dragonguard, Dragon Spawn, Chromatic Dragonspawn, Chromatic Whelps then Blackhand Orcs in that order.
|tip When Gyth appears, the tank should face it away from the group.
|tip At 20%, Rend will join the fight.
|tip The Offtank should immediately grab Rend.
|tip Finish off Gyth before switching to Warchief Rend Blackhand.
|tip Melee move out of range when he casts the "Whirlwind" ability.
Click Here to Continue |confirm
step
kill The Beast##10430
|tip It's "Berserker Charge" ability targets the player with the most aggro.
|tip The tanks must ensure that they have the highest aggro at all times.
|tip All ranged should stand at max range to avoid its "Fear" ability.
|tip The final ability will be "Flamebreak".
|tip It will knockback anyone near it, so the tanks should fight The Beast with their back to the wall.
Click Here to Continue |confirm
step
kill General Drakkisath##10363
|tip To start, if you have a hunter, you can have them kite General Drakkisath into The Beasts room and feign death while the group burns down the "Chromatic Elite Guards".
|tip You can also tank all 3 where they stand, AoEing down the Elite Guards as quickly as possible.
|tip Melee should stand behind Drakkisath at all times.
|tip The Tank should have their back to the wall.
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Hall of Thanes Quests",{
author="support@zygorguides.com",
image=ZGV.IMAGESDIR.."Hall of Thanes",
description="This guide will walk you through completing the Hall of Thanes quests.",
condition_suggested=function() return level >= 13 and level <= 21 and not completedq(96391) end,
condition_end=function() return completedq(96391) end,
},[[
step
Reach Level 13 |ding 13
|tip Use the Leveling guides to accomplish this.
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
accept Farsen's Watch##96392 |goto Dun Morogh/0 64.85,58.43
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
Select _"Eartheer, please share your farsight with me."_ |gossip 139831
Use Farsen's Farsight |q 96392/1 |goto Dun Morogh/0 64.85,58.43
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Farsen's Watch##96392 |goto Dun Morogh/0 64.85,58.43
step
kill Dark Iron Spy##6123
collect Dark Iron Map##274268
use Dark Iron Map##274268
accept Underground Map##96391 |goto Dun Morogh/0 77.02,60.70
|tip You do not need the next quest but can pick it up if you want the XP from extra dwarves and the quest.
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
turnin Underground Map##96391 |goto Dun Morogh/0 64.85,58.43
turnin Nip 'Em in the Bud##96390 |goto Dun Morogh/0 64.85,58.43 |only if readyq(96390)
step
talk Earthseer Farsen##264936
|tip Up on the mountain.
accept Old Ironforge Incursion##96393 |goto Dun Morogh/0 64.85,58.43
step
Enter the The High Seat |goto Ironforge/0 44.37,49.65 < 10
Run down the ramp |goto Ironforge/0 44.20,51.95 < 15
|tip Immediately to your left inside the Throne Room is a ramp.
|tip Once you enter the chamber below stick to your left and head up to Afadra.
talk Afadra Dunwall##264943
|tip Downstairs beneath The High Seat.
accept The Restless Dead##96394 |goto Ironforge/0 32.78,47.68
step
Run down the ramp |goto Ironforge/0 36.17,51.12 < 5
talk Thom Filch##265003
|tip Down the spiral ramp towards the dungeon.
accept Important Heirlooms##96403 |goto Ironforge/0 32.22,44.44
step
Enter the Hall of Thanes Dungeon with Your Group |goto Ironforge/0 27.98,47.78 |c |q 96393
step
_Inside the Hall of Thanes Dungeon:_
talk Ghostly Attendant##26502
accept An Ancient Grudge##96395
stickystart "THE_RESTLESS_DEAD"
stickystart "IMPORTANT_HEIRLOOMS"
step
_Inside the Hall of Thanes Dungeon:_
kill Faldrim Anvilmar##261306
|tip He patrols around the middle of Anvilmar's Rest.
|tip Clear trash around the boss before engaging.
|tip {r}Anvilmar's Curse{} will slow the tank's attacks, generating threat slower than normal.
Slay Faldrim Anvilmar |q 96395/1 |only if haveq(96395)
|confirm
step
_Inside the Hall of Thanes Dungeon:_
kill Magmatus##261316
kill Dark Iron Summoner##263438
|tip Pull Magmatus away from the Summoner and the rest of the group can handle the Summoner.
|tip Focus down the Dark Iron Summoner first.
|tip Magmatus will cast {r}Combust{} on random party members dealing heavy damage.
|tip Magmatus also has a {r}Fire Nova{} ability he uses periodically.
|confirm
step
_Inside the Hall of Thanes Dungeon:_
kill Plunder##261311
|tip {r}Knockback{} is the only mechanic in this fight, the tank should put their back to a wall.
|tip Pull Plunder to a safe area so you don't get knocked into other enemies.
|tip Decide a wall to gather at and stick to it for the fight.
|confirm
step
_Inside the Hall of Thanes Dungeon:_
kill Dark Iron Looter##263396
|tip Clear the Dark Iron Looters around the room before engaging the boss.
kill Lesser Stone Golem##263466
|tip Focus down the golems one by one.
kill Durgen Dirgehammer##261319
|tip He will use an area of effect version of {r}Fear{}.
|tip Use stuns to manage fear.
|tip The tank will be taking additional damage from {r}Rend{}.
collect Durgen Dirgehammer's Head##274286 |q 96393/1 |only if haveq(96393)
|confirm
step
_Inside the Hall of Thanes Dungeon:_
click Treaty of Understanding##
|tip Lying against the wall inside the Reliquary of Kings.
|tip It will be inside one of the vaults
accept The Treaty of Understanding##98423
step
label "THE_RESTLESS_DEAD"
_Inside the Hall of Thanes Dungeon:_
kill 15 Enraged Apparition##263389 |q 96394/1
kill 10 Tormented Soul##263390 |q 96394/2
step
label "IMPORTANT_HEIRLOOMS"
_Inside the Hall of Thanes Dungeon:_
click Heirloom Coffer##
|tip Scattered throughout the dungeon.
|tip There are approximately 24 of them in the final area of the dungeon.
collect 8 Dwarvern Heirloom |q 96403/1
step
_Inside the Hall of Thanes Dungeon:_
talk Ghostly Attendant##26502
turnin An Ancient Grudge##96395
step
talk Thom Filch##265003
|tip Just outside the dungeon.
turnin Important Heirlooms##96403 |goto Ironforge/0 32.22,44.44
step
Run up the ramp |goto Ironforge/0 36.17,51.12 < 5
talk Afadra Dunwall##264943
|tip Downstairs beneath The High Seat.
turnin The Restless Dead##96394 |goto Ironforge/0 32.78,47.68
step
talk King Magni Bronzebeard##2784 |goto Ironforge/0 39.10,56.21
turnin The Treaty of Understanding##98423 |goto Ironforge/0 39.10,56.21
turnin Old Ironforge Incursion##96393 |goto Ironforge/0 39.10,56.21
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Wailing Caverns Quests",{
image=ZGV.IMAGESDIR.."Wailing Caverns",
description="This guide will walk you through completing the Wailing Caverns quests.",
condition_suggested=function() return level >= 15 and level <= 25 and not completedq(3370) end,
condition_end=function() return completedq(3370) end,
},[[
step
Reach Level 15 |ding 15
|tip Use the Leveling guides to accomplish this.
step
talk Mebok Mizzyrix##3446
accept Raptor Horns##865 |goto The Barrens 62.37,37.62
step
kill Sunscale Scytheclaw##3256+
|tip They look like purple raptors.
collect 5 Intact Raptor Horn##5055 |q 865/1 |goto The Barrens 43.36,15.57
You can find more around [45.27,14.94]
step
talk Mebok Mizzyrix##3446
turnin Raptor Horns##865 |goto The Barrens 62.37,37.62
accept Smart Drinks##1491 |goto The Barrens 62.37,37.62
step
talk Crane Operator Bigglefuzz##3665
accept Trouble at the Docks##959 |goto The Barrens 63.09,37.61
step
Follow the path up |goto The Barrens 50.32,35.44 < 10 |only if walking
Continue up the path |goto The Barrens 49.17,34.09 < 10 |only if walking
Follow the path |goto The Barrens 48.09,32.95 < 10 |only if walking
Follow the path down |goto The Barrens 47.28,33.56 < 10 |only if walking
Jump down here |goto The Barrens 45.86,35.86 < 10 |only if walking
Jump down carefully here |goto The Barrens 45.77,36.16 < 5 |c |q 3370 |future |or
|tip Aim for the stone.
'|complete completedq(1486) and completedq(1487)
step
Enter the cave |goto The Barrens 45.85,35.95 < 5 |walk
talk Nalpak##5767
|tip Inside the cave.
accept Deviate Hides##1486 |goto The Barrens 45.98,35.66
step
talk Ebru##5768
|tip Inside the cave.
accept Deviate Eradication##1487 |goto The Barrens 46.01,35.74
step
Enter the cave |goto The Barrens 45.97,36.33 < 10 |walk
Follow the path |goto The Barrens 45.91,35.62 < 10 |walk
Continue follow the path |goto The Barrens 46.26,34.98 < 10 |walk
Follow the path |goto The Barrens 45.94,34.24 < 10 |walk
kill Mad Magglish##3655
|tip He is stealthed inside the cave.
collect 99-Year-Old Port##5334 |q 959/1 |goto The Barrens 45.69,33.60
You can also find him around: |notinsticky
[46.84,34.63]
[46.47,35.50]
step
Enter the Wailing Caverns Dungeon with Your Group |goto Wailing Caverns/0 0.00,0.00 < 500 |c |q 3370 |future
stickystart "Collect_6_Wailing_Essence"
stickystart "Collect_20_Deviate_Hide"
stickystart "Slay_7_Deviate_Ravager"
stickystart "Slay_7_Deviate_Viper"
stickystart "Slay_7_Deviate_Shambler"
stickystart "Slay_7_Deviate_Dreadfang"
step
_Inside the Wailing Caverns Dungeon:_
kill Lady Anacondra##3671
|tip She is the first boss of the dungeon.
|tip She can spawn at several locations in the Screaming Gully.
Click Here to Continue |confirm |q 3370 |future
step
_Inside the Wailing Caverns Dungeon:_
kill Lord Cobrahn##3669
|tip He is the second boss of the dungeon.
|tip Follow the water path west from the Screaming Gully into the Pit of Fangs.
|tip Follow the path up and around through the Pit of Fangs.
Click Here to Continue |confirm |q 3370 |future
step
_Inside the Wailing Caverns Dungeon:_
kill Lord Pythas##3670
|tip He is the third boss of the dungeon.
|tip Leave the Pit of Fangs and reenter the Screaming Gully.
|tip Follow the water path east to briefly enter The Wailing Caverns and then the Crag of the Everliving.
|tip Continue through the Crag of the Everliving to reach the Winding Chasm.
|tip Immediately after reaching the Winding Chasm, follow the right path northeast through the small pool of water.
|tip He is back in the northern part of the Winding Chasm.
Click Here to Continue |confirm |q 3370 |future
step
_Inside the Wailing Caverns Dungeon:_
kill Lord Serpentis##3673
|tip After killing Lord Pythas in the Winding Chasm, head southeast to enter The Wailing Caverns.
|tip Continue south a short distance and head left after reaching an area with lots of small white candles on the ground and a Druid of the Fang.
|tip You will now be back in the Winding Chasm, continue straight southeast through this cave section, passing a pool of water on your left.
|tip You will reach a fenced off area with two Druid of the Fang guards and an optional boss, Skum.
|tip Follow the path to the right of the fence and continue going southwest to reach the Crag of the Everliving.
|tip Carefully jump across the gap by the small waterfall and continue along this upper path to reach Lord Serpentis.
Click Here to Continue |confirm |q 3370 |future
step
label "Collect_6_Wailing_Essence"
_Inside the Wailing Caverns Dungeon:_ |notinsticky
Kill Ectoplasm enemies around this area
|tip They are found throughout the dungeon.
collect 6 Wailing Essence##6464 |q 1491/1
step
label "Collect_20_Deviate_Hide"
_Inside the Wailing Caverns Dungeon:_ |notinsticky
Kill Deviate enemies around this area
|tip They are found throughout the dungeon.
collect 20 Deviate Hide##6443 |q 1486/1
step
label "Slay_7_Deviate_Ravager"
_Inside the Wailing Caverns Dungeon:_ |notinsticky
kill 7 Deviate Ravager##3636 |q 1487/1
|tip They are found in the Screaming Gully.
step
label "Slay_7_Deviate_Viper"
_Inside the Wailing Caverns Dungeon:_ |notinsticky
kill 7 Deviate Viper##5755 |q 1487/2
|tip They are found in the Pit of Fangs.
step
label "Slay_7_Deviate_Shambler"
_Inside the Wailing Caverns Dungeon:_ |notinsticky
kill 7 Deviate Shambler##5761 |q 1487/3
|tip They are found in the Crag of the Everliving.
step
label "Slay_7_Deviate_Dreadfang"
_Inside the Wailing Caverns Dungeon:_ |notinsticky
kill 7 Deviate Dreadfang##5056 |q 1487/4
|tip They are found in the Winding Chasm.
step
_Inside the Wailing Caverns Dungeon:_
talk Disciple of Naralex##3678
|tip He is standing at the dungeon entrance.
Select _"Let the event begin!"_
|tip This will only be an available option once the previous bosses have been killed.
Escort the Disciple of Naralex
|tip Kill the enemies that spawn and attack and don't let him die.
|tip This will be easier if the Screaming Gully is already cleared of enemies.
kill Mutanus the Devourer##3654
|tip He will spawn at Dreamer's Rock, after several waves of enemies.
collect Glowing Shard##10441 |n
use the Glowing Shard##10441
accept The Glowing Shard##3366 |or
'|accept The Glowing Shard##6981 |or
step
Leave the Wailing Caverns Dungeon
Click Here to Continue |confirm |q 3370 |future
step
Follow the path up |goto Wailing Caverns/0 47.59,34.46 < 7 |only if walking
Cross the bridge |goto Wailing Caverns/0 47.52,33.91 < 7 |only if walking
Continue following the path |goto Wailing Caverns/0 47.41,32.89 < 7 |only if walking
Cross the water |goto Wailing Caverns/0 46.91,32.63 < 10 |only if walking
Continue following the path |goto Wailing Caverns/0 45.86,33.34 < 10 |only if walking
Leave the cave |goto Wailing Caverns/0 45.95,36.21 < 7 |c |q 3370 |future
step
Follow the path up |goto Wailing Caverns/0 50.32,35.44 < 10 |only if walking
Continue up the path |goto Wailing Caverns/0 49.17,34.09 < 10 |only if walking
Follow the path |goto Wailing Caverns/0 48.09,32.95 < 10 |only if walking
Follow the path down |goto Wailing Caverns/0 47.28,33.56 < 10 |only if walking
Jump down here |goto Wailing Caverns/0 45.86,35.86 < 10 |only if walking
Jump down carefully here |goto Wailing Caverns/0 45.77,36.16 < 5 |c |q 3370 |future |or
|tip Aim for the stone.
'|complete completedq(1486) and completedq(1487) |or
step
Enter the cave |goto The Barrens 45.85,35.95 < 5 |walk
talk Nalpak##5767
|tip Inside the cave.
turnin Deviate Hides##1486 |goto The Barrens 45.98,35.66
step
talk Ebru##5768
|tip Inside the cave.
turnin Deviate Eradication##1487 |goto The Barrens 46.01,35.74
step
talk Mebok Mizzyrix##3446
turnin Smart Drinks##1491 |goto The Barrens 62.37,37.62
step
talk Crane Operator Bigglefuzz##3665
turnin Trouble at the Docks##959 |goto The Barrens 63.09,37.61
step
talk Sputtervalve##3442
Select _"Tell me about the Glowing Shard."_
Speak with Someone in Ratchet About the Glowing Shard |q 3366/1 |goto The Barrens 62.98,37.22 |only if haveq(3366) or completedq(3366)
Speak with Someone in Ratchet About the Glowing Shard |q 6981/1 |goto The Barrens 62.98,37.22 |only if haveq(6981) or completedq(6981)
step
Follow the path up |goto The Barrens 50.32,35.44 < 10 |only if walking
Continue up the path |goto The Barrens 49.17,34.09 < 10 |only if walking
talk Falla Sagewind##8418
|tip Inside the building.
turnin The Glowing Shard##3366 |goto The Barrens 48.18,32.78 |only if haveq(3366) or completedq(3366)
turnin The Glowing Shard##6981 |goto The Barrens 48.18,32.78 |only if haveq(6981) or completedq(6981)
accept In Nightmares##3370 |goto The Barrens 48.18,32.78
step
Enter the building |goto Darnassus 35.52,10.69 < 5 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin In Nightmares##3370 |goto Darnassus 35.40,8.40
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Deadmines Quests",{
image=ZGV.IMAGESDIR.."Deadmines",
description="This guide will walk you through completing The Deadmines quests.",
condition_suggested=function() return level >= 16 and level <= 25 and not completedq(168) end,
condition_end=function() return completedq(168) end,
},[[
step
Reach Level 16 |ding 16
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 68.90,42.09
talk Wilder Thistlenettle##656
|tip Inside the building.
accept Oh Brother...##167 |goto Stormwind City 70.32,40.85
accept Collecting Memories##168 |goto Stormwind City 70.32,40.85
step
talk Shoni the Shilent##6579
accept Underground Assault##2040 |goto Stormwind City 62.64,34.14
step
talk Gryan Stoutmantle##234
accept The Defias Brotherhood##65 |goto Westfall 56.33,47.52
step
Enter the building |goto Redridge Mountains 21.52,46.41 < 7 |walk
talk Wiley the Black##266
|tip Upstairs inside the building.
turnin The Defias Brotherhood##65 |goto Redridge Mountains 21.39,45.35
accept The Defias Brotherhood##132 |goto Redridge Mountains 21.39,45.35
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##132 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##135 |goto Westfall 56.33,47.52
step
Follow the path |goto Stormwind City 77.47,65.94 < 7 |walk
Enter the building |goto Stormwind City 79.36,69.35 < 7 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin The Defias Brotherhood##135 |goto Stormwind City 78.31,70.74
accept The Defias Brotherhood##141 |goto Stormwind City 78.31,70.74
step
Follow the path |goto Stormwind City 77.47,65.94 < 7 |walk
Run up the ramp |goto Stormwind City 67.99,72.67 < 7 |only if walking
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##141 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##142 |goto Westfall 56.33,47.52
step
map Westfall
path loop on
path	45.59,65.05	43.36,58.68	41.42,49.74	37.96,44.77
path	32.28,43.11	36.95,43.09	37.97,36.80	43.89,28.63
path	44.45,25.85
Check For the Defias Messenger Along This Path
kill Defias Messenger##550
|tip He walks along the road between Jangolode Mine and Moonbrook.
|tip He walks into Gold Coast Quarry before traveling to either Jangolode Mine or Moonbrook.
|tip Run on the road while looking for him.
|tip He spawns around this location, so it may be easier to kill enemies around this area while waiting for him to either spawn or walk here.
collect A Mysterious Message##1381 |q 142/1
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##142 |goto Westfall 56.33,47.52
step
talk The Defias Traitor##467
|tip This is an escort quest.
|tip If he's not here, someone may be escorting him.
|tip Wait until he respawns.
accept The Defias Brotherhood##155 |goto Westfall 55.68,47.50 |noautoaccept
step
Watch the dialogue
|tip Follow the Defias Traitor and protect him as he walks.
|tip He eventually walks to this location.
Escort The Defias Traitor to Discover Where VanCleef is Hiding |q 155/1 |goto Westfall 42.54,71.69
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##155 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##166 |goto Westfall 56.33,47.52
step
Enter the building |goto Westfall 56.51,47.41 < 5 |only if walking
talk Scout Riell##820
|tip At the top of the tower.
accept Red Silk Bandanas##214 |goto Westfall 56.67,47.35
step
Enter the building |goto Westfall 42.56,71.74 < 5 |walk
Follow the path up |goto Westfall 43.38,71.95 < 5 |only if walking
Follow the path |goto Westfall 42.90,72.70 < 5 |only if walking
Run down the ramp |goto Westfall 43.40,72.82 < 5 |only if walking
Follow the path |goto Westfall 43.81,73.37 < 7 |only if walking
Jump down here |goto Westfall 43.27,74.14 < 7 |c |q 168
stickystart "Collect_Miners_Union_Cards"
step
Follow the path |goto Westfall 41.60,75.95 < 15 |only if walking
Continue following the path |goto Westfall 41.08,76.97 < 15 |only if walking
Cross the bridge |goto Westfall 41.12,79.68 < 10 |only if walking
Follow the path |goto Westfall 41.09,79.93 < 7 |only if walking
kill Foreman Thistlenettle##626
|tip He looks like a ghoul.
|tip He walks around this area.
collect Thistlenettle's Badge##1875 |q 167/1 |goto Westfall 41.08,80.08
step
label "Collect_Miners_Union_Cards"
Kill Undead enemies around this area
collect 4 Miners' Union Card##1894 |q 168/1 |goto Westfall 40.96,80.12
step
Enter the Deadmines Dungeon with Your Group |goto The Deadmines/0 0.00,0.00 < 500 |c |q 168
stickystart "Collect_10_Red_Silk_Bandanas"
step
_Inside The Deadmines Dungeon:_
kill Sneed's Shredder##642
|tip The second boss of the dungeon.
collect Gnoam Sprecklesprocket##7365 |q 2040/1
step
_Inside The Deadmines Dungeon:_
kill Edwin Vancleef##639
|tip The last boss of the dungeon.
|tip Aboard the ship.
collect Head of VanCleef##3637 |q 166/1
step
_Inside The Deadmines Dungeon:_
kill Edwin Vancleef##639
|tip The last boss of the dungeon.
|tip Aboard the ship.
collect An Unsent Letter##2874 |q 373 |future
step
use An Unsent Letter##2874
accept The Unsent Letter##373
step
label "Collect_10_Red_Silk_Bandanas"
_Inside The Deadmines Dungeon:_ |notinsticky
Kill Defias enemies around this area
|tip They are found throughout the dungeon.
collect 10 Red Silk Bandanas##915 |q 214/1
step
Leave The Deadmines Dungeon
Click Here to Continue |confirm |q 168
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##166 |goto Westfall 56.33,47.52
step
Enter the building |goto Westfall 56.51,47.41 < 5 |only if walking
talk Scout Riell##820
|tip At the top of the tower.
turnin Red Silk Bandanas##214 |goto Westfall 56.67,47.35
step
Enter the building |goto Stormwind City 56.73,48.55 < 5 |walk
talk Baros Alexston##1646
turnin The Unsent Letter##373 |goto Stormwind City 57.75,47.86
step
talk Shoni the Shilent##6579
turnin Underground Assault##2040 |goto Stormwind City 62.64,34.14
step
Enter the building |goto Stormwind City 68.92,42.06 < 5 |walk
talk Wilder Thistlenettle##656
|tip Inside the building
turnin Oh Brother...##167 |goto Stormwind City 70.32,40.85
turnin Collecting Memories##168 |goto Stormwind City 70.32,40.85
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Ruins of Lordaeron Quests",{
author="support@zygorguides.com",
image=ZGV.IMAGESDIR.."Ruins of Lordaeron",
description="This guide will walk you through completing the Ruins of Lordaeron quests.",
condition_suggested=function() return level >= 16 and level <= 29 and not completedq(92422) end,
condition_end=function() return completedq(92422) end,
},[[
step
Reach level 16 |ding 16
|tip Use the Leveling guides to accomplish this.
step
Enter the Ruins of Lordaeron Dungeon with Your Group |goto Undercity/0 72.01,11.48 |c |q 92422
step
_Inside the Ruins of Lordaeron dungeon:_
talk Captain Truman##265701
accept Abominable Creatures##95250
stickystart "Accept_Bloodied_Insignias"
stickystart "Collect_Bloodied_Insignias"
step
_Inside the Ruins of Lordaeron dungeon:_
kill The Baron##250660
collect Head of the Baron##268518
|tip The second boss of the dungeon.
|tip Continue South along the Eastern part of the dungeon and you will see him.
step
stickystart "Collect_Blood_Stained_Letter"
_Inside the Ruins of Lordaeron dungeon:_
kill Rath'mael##250657
|tip On the West side of the dungeon.
Slay Rath'mael |q 92422 |only if haveq(92422)
step
label "Accept_Bloodied_Insignias"
kill Cadaver##250621, Fallen Berserker##250656, Fallen Necromancer##255964, Flesh Golem##255109, Ghoul##250627, Living Monstrosity##250689, Mangled Cadaver##250623, Plague Ghoul##250630, Ragged Ghoul##250622, Skeletal Mage##250624, Skeletal Soldier##250626, Skeleton##250618
|tip Any Undead enemy in the dungeon has a chance to drop this.
collect Bloodied Insignia##268535
use Bloodied Insignia##268535
accept Bloodied Insignia##95195
step
label "Collect_Bloodied_Insignias"
kill Cadaver##250621, Fallen Berserker##250656, Fallen Necromancer##255964, Flesh Golem##255109, Ghoul##250627, Living Monstrosity##250689, Mangled Cadaver##250623, Plague Ghoul##250630, Ragged Ghoul##250622, Skeletal Mage##250624, Skeletal Soldier##250626, Skeleton##250618
|tip Any Undead enemy in the dungeon has a chance to drop these.
collect 10 Bloodied Insignia##268540+ |q 95195/1
|only if haveq(95195)
step
label "Collect_Blood_Stained_Letter"
Inside the Ruins of Lordaeron Dungeon:
collect Blood-Stained Letter##251522
use Blood-Stained Letter##251522
accept Remember That I Love You##92415
|tip Spawns on the ground next to Edward Heartweaver's corpse.
|tip It is within the Rath'mael's graveyard area.
accept Remember That I Love You##92415
step
_Inside the Ruins of Lordaeron dungeon:_
collect Crest of Lordaeron##268579
use Crest of Lordaeron##268579
accept Crest of Lordaeron##95189
|tip The spawn location of this item is _very_ random.
|tip Check the base and tops of the towers, along the ramparts, the crypts.
step
_Inside the Ruins of Lordaeron dungeon:_
talk talk Captain Truman##265701
turnin Abominable Creatures##95250
step
talk General Marcus Jonathan##466
turnin Bloodied Insignia##95195 |goto Stormwind City/0 64.55,74.67
|tip He wanders around central Trade District some.
step
talk Orphan Matron Nightingale##14450
turnin Remember That I Love You##92415 |goto Stormwind City/0 56.31,53.99
accept Remember That I Love You##95161 |goto Stormwind City/0 56.31,53.99
step
talk Lady Dena Kennedy##15991
Enter the Stomwind Keep |goto Stormwind City/0 73.34,46.39 < 10
turnin Crest of Lordaeron##95189 |goto Stormwind City/0 69.83,28.57
step
talk Avette Fellwood##228
turnin Remember That I Love You##35161 |goto Duskwood/0 73.22,44.83
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackfathom Deeps Quests",{
image=ZGV.IMAGESDIR.."Blackfathom Deeps",
description="This guide will walk you through completing the Blackfathom Deeps quests.",
condition_suggested=function() return level >= 20 and level <= 32 and not completedq(971) end,
condition_end=function() return completedq(971) end,
hideif=ZGV.IsClassicSoD,
},[[
step
Reach Level 20 |ding 20
|tip Use the Leveling guides to accomplish this.
step
talk Argos Nightwhisper##4984
accept The Corruption Abroad##3765 |goto Stormwind City 36.24,67.59
step
Run up the stairs |goto Ironforge 51.24,9.84 < 5 |only if walking
talk Gerrig Bonegrip##2786
|tip Inside the building.
accept Knowledge in the Deeps##971 |goto Ironforge 50.82,5.60
step
talk Gershala Nightwhisper##8997
turnin The Corruption Abroad##3765 |goto Darkshore 38.33,43.04
accept Researching the Corruption##1275 |goto Darkshore 38.33,43.04
step
Run up the ramp |goto Darnassus 56.46,20.41 < 5 |only if walking
talk Argent Guard Manados##4784
|tip Inside the building.
accept Twilight Falls##1199 |goto Darnassus 55.23,24.00
step
talk Dawnwatcher Shaedlass##4786
|tip Inside the building.
accept In Search of Thaelrid##1198 |goto Darnassus 55.37,25.00
step
Jump into the water |goto Ashenvale/0 14.12,13.88 < 10 |walk
Swim underwater into the cave |goto Ashenvale/0 13.28,13.23 < 10 |walk
Follow the path |goto Ashenvale/0 13.90,10.92 < 10 |walk
Follow the path |goto Ashenvale/0 13.74,9.38 < 10 |walk
Follow the path |goto Ashenvale/0 14.37,9.20 < 10 |walk
Follow the path |goto Ashenvale/0 16.50,11.61 < 10 |walk
Enter the Blackfathom Deeps Dungeon with Your Group |goto Blackfathom Deeps/0 0.00,0.00 < 500 |c |q 971
stickystart "Collect_10_Twilight_Pendants"
stickystart "Collect_8_Corrupted_Brain_Stems"
step
_Inside the Blackfathom Deeps Dungeon:_
click Pitted Iron Chest
|tip Follow the path inside the dungeon to enter The Drowned Sacellum.
|tip Swim to the south side of the room and then jump across the platforms to reach the southwest path.
|tip Continue following the path to enter The Pool of Ask'ar.
|tip It is underwater to the north of Gamoo-ra.
collect Lorgalis Manuscript##5359 |q 971/1
step
_Inside the Blackfathom Deeps Dungeon:_
talk Argent Guard Thaelrid##4787
|tip Head southwest again in The Pool of Ask'ar and swim into the underwater cave.
|tip He is laying on the ground inside the underwater cave.
turnin In Search of Thaelrid##1198
accept Blackfathom Villainy##1200
step
_Inside the Blackfathom Deeps Dungeon:_
kill Twilight Lord Kelris##4832
|tip The fourth boss of the dungeon.
|tip Leave the underwater cave and reenter the main room in The Pool of Ask'ar.
|tip Swim south and follow the path to the left to reach the Moonshrine Ruins.
|tip Follow the path southeast through the Moonshrine Ruins into the Moonshrine Sanctum.
collect Head of Kelris##5881 |q 1200/1
step
label "Collect_10_Twilight_Pendants"
_Inside the Blackfathom Deeps Dungeon:_ |notinsticky
Kill Twilight enemies around this area
|tip They are found throughout the instance.
collect 10 Twilight Pendant##5879 |q 1199/1
step
label "Collect_8_Corrupted_Brain_Stems"
_Inside the Blackfathom Deeps Dungeon:_ |notinsticky
Kill Blackfathom and Fallenroot enemies around this area
|tip They are found throughout the instance.
collect 8 Corrupted Brain Stem##5952 |q 1275/1
step
Leave the Blackfathom Deeps Dungeon
Click Here to Continue |confirm |q 971
step
talk Gershala Nightwhisper##8997
turnin Researching the Corruption##1275 |goto Darkshore 38.33,43.04
step
Run up the ramp |goto Darnassus 56.46,20.41 < 5 |only if walking
talk Argent Guard Manados##4784
|tip Inside the building.
turnin Twilight Falls##1199 |goto Darnassus 55.23,24.00
step
talk Dawnwatcher Selgorm##4783
|tip Inside the building.
turnin Blackfathom Villainy##1200 |goto Darnassus 56.17,24.38
step
Run up the stairs |goto Ironforge 51.24,9.84 < 5 |only if walking
talk Gerrig Bonegrip##2786
|tip Inside the building.
turnin Knowledge in the Deeps##971 |goto Ironforge 50.82,5.60
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Excavation Site Quests",{
author="support@zygorguides.com",
image=ZGV.IMAGESDIR.."Excavation Site",
description="This guide will walk you through completing the Excavation Site quests.",
condition_suggested=function() return level >= 24 and level <= 31 and not completedq(95810) end,
condition_end=function() return completedq(95810) end,
},[[
step
Reach Level 24 |ding 24
|tip Use the Leveling guides to accomplish this.
step
talk Dorin Songblade##956
|tip Inside the building.
accept Songblade Search##95772 |goto Redridge Mountains/0 25.72,46.43
step
talk James Halloran##2094
|tip Walks around.
accept Young Crocolisk Skins##484 |goto Wetlands/0 8.51,55.71
step
talk Caitlin Grassman##1480
|tip Inside the building.
accept Lost in the Thicket Things##95647 |goto Wetlands/0 11.88,58.86
step
label "Collect_Young_Crocolisk_Skins"
kill Young Wetlands Crocolisk##1417+
collect 4 Young Crocolisk Skin##3397 |q 484/1 |goto Wetlands/0 61.80,56.40
|mapmarker Wetlands/0 50.00,32.20
|mapmarker Wetlands/0 50.60,34.40
|mapmarker Wetlands/0 51.20,38.60
|mapmarker Wetlands/0 52.20,36.20
|mapmarker Wetlands/0 52.80,41.00
|mapmarker Wetlands/0 53.40,38.60
|mapmarker Wetlands/0 53.60,32.40
|mapmarker Wetlands/0 54.00,42.60
|mapmarker Wetlands/0 54.40,45.60
|mapmarker Wetlands/0 56.40,47.60
|mapmarker Wetlands/0 58.20,50.00
|mapmarker Wetlands/0 58.80,52.00
|mapmarker Wetlands/0 59.40,63.40
|mapmarker Wetlands/0 60.20,54.20
|mapmarker Wetlands/0 62.00,62.40
|mapmarker Wetlands/0 62.20,59.40
|mapmarker Wetlands/0 63.40,65.40
|mapmarker Wetlands/0 63.40,73.00
|mapmarker Wetlands/0 63.80,69.00
|mapmarker Wetlands/0 63.80,75.80
|mapmarker Wetlands/0 65.80,73.60
step
talk James Halloran##2094
|tip Walks around.
turnin Young Crocolisk Skins##484 |goto Wetlands/0 8.51,55.71
accept Highland Hides##98815 |goto Wetlands/0 8.51,55.71
step
talk First Mate Fitzsimmons##1239
|tip Walks around.
accept The Greenwarden##463 |goto Wetlands 10.89,59.67
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin The Greenwarden##463 |goto Wetlands/0 56.34,40.43
accept Tramping Paws##276 |goto Wetlands/0 56.34,40.43
stickystart "Kill_Mosshide_Gnolls"
step
kill 10 Mosshide Mongrel##1008 |q 276/2 |goto Wetlands 60.40,58.20
|mapmarker Wetlands/0 55.40,74.60
|mapmarker Wetlands/0 59.40,55.40
|mapmarker Wetlands/0 60.00,70.40
|mapmarker Wetlands/0 60.80,72.60
|mapmarker Wetlands/0 61.80,61.60
|mapmarker Wetlands/0 62.00,66.40
|mapmarker Wetlands/0 62.00,70.60
|mapmarker Wetlands/0 63.20,55.60
|mapmarker Wetlands/0 63.40,63.00
|mapmarker Wetlands/0 63.60,58.40
|mapmarker Wetlands/0 63.60,60.60
|mapmarker Wetlands/0 63.80,68.20
|mapmarker Wetlands/0 65.00,65.60
step
label "Kill_Mosshide_Gnolls"
kill 15 Mosshide Gnoll##1007 |q 276/1 |goto Wetlands 63.60,62.20
|mapmarker Wetlands/0 56.00,74.60
|mapmarker Wetlands/0 61.00,71.60
|mapmarker Wetlands/0 62.40,68.20
|mapmarker Wetlands/0 62.80,65.20
|mapmarker Wetlands/0 65.00,65.80
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin Tramping Paws##276 |goto Wetlands/0 56.34,40.43
accept Fire Taboo##277 |goto Wetlands/0 56.34,40.43
step
kill Mosshide Brute##1012, Mosshide Trapper##1011, Mosshide Fenrunner##1010, Mosshide Mistweaver##1009, Mosshide Mystic##1013, Mosshide Alpha##1014
|tip Gnolls.
collect 9 Crude Flint##2611 |q 277/1 |goto Wetlands/0 30.40,28.40
|mapmarker Wetlands/0 27.40,28.20
|mapmarker Wetlands/0 28.40,31.60
|mapmarker Wetlands/0 33.00,26.00
|mapmarker Wetlands/0 34.00,29.40
|mapmarker Wetlands/0 37.00,30.60
|mapmarker Wetlands/0 39.20,27.60
|mapmarker Wetlands/0 26.40,36.40
|mapmarker Wetlands/0 29.40,35.00
|mapmarker Wetlands/0 30.80,31.80
|mapmarker Wetlands/0 32.40,34.80
|mapmarker Wetlands/0 36.00,34.40
|mapmarker Wetlands/0 39.60,34.60
|mapmarker Wetlands/0 42.40,31.40
|mapmarker Wetlands/0 43.20,34.60
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin Fire Taboo##277 |goto Wetlands/0 56.37,40.40
accept Blisters on The Land##275 |goto Wetlands/0 56.37,40.40
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
accept Horrors in the Highland##95646 |goto Wetlands/0 56.34,40.43
step
Follow the path |goto Wetlands/0 53.27,65.81
Enter the Excavation Site Dungeon with Your Group |goto Wetlands/0 48.22,56.49 |c
step
_Inside the Excavation Site Wetlands Dungeon:_
|tip Clear trash around Saltspine before engaging.
kill Saltspine##260322
|tip Uses {r}Tendon Rip{} on the current target, cause severely reduced movement speed.
|tip Ranged stay at least 10  yards away to avoid being afflicted by {r}Dust Storm{}, which reduces hit chance by 25%.
|confirm
step
_Inside the Excavation Site Wetlands Dungeon:_
|tip Clear the trash around Shardtooth before engaging.
kill Shardtooth##260325
|tip Either crowd control both Thicket Hunters or just one while you focus down the other.
|tip They apply {r}Infected Wound{} to the tank, dispel this quickly.
|tip Applies {r}Rend{}, a bleed, to the tank as well.
|tip Casts {r}Terrifying Roar{}, an AoE 5 second fear, make sure you are tanking the boss in an area clear of mobs.
|tip Can be Slowed and Stunned to help mitigate the {r}Enrage{} at 30%
|confirm
step
label "Collect_Raptor_Meat"
_Inside the Excavation Site Wetlands Dungeon:_
kill Shadetooth##260325, Thicket Lurker##260800, Thicket Stalker##271732, Thicket Hunter##260801
collect 4 Thicket Raptor Meat##271100 |q 97249/1
|only if haveq(97249) or completedq(97249)
step
label  "Collect_Thicket_Raptor_Hide"
_Inside the Excavation Site Wetlands Dungeon:_
kill Shadetooth##260325, Thicket Lurker##260800, Thicket Stalker##271732, Thicket Hunter##260801
collect 4 Thicket Raptor Hide##284845 |q 98815/1
|only if haveq(98815) or completedq(98815)
stickystart "Kill_Dragonmaw_Enemies"
step
_Inside the Excavation Site Wetlands Dungeon:_
clicknpc Daewyn Songblade##
|tip Inside of a tent south of the Highland Horror.
turnin Songblade Search##95772
accept Fallen in the Fen##95795
|only if haveq(95772) or completedq(95772)
step
_Inside the Excavation Site Wetlands Dungeon:_
kill Highland Horror##260808
|tip Near the Lost Dig Site area with the dragonmaw.
collect Horrible Rootcore##270180 |q 95646/1
|only if haveq(95646) or completedq(95646)
step
label "Kill_Dragonmaw_Enemies"
_Inside the Excavation Site Wetlands Dungeon:_
kill 2 Dragonmaw Saboteur##275045+ |q 95682/1
kill 4 Dragonmaw Warder##275044+ |q 95682/2
|only if haveq(95682) or completedq(95682)
step
_Inside the Excavation Site Wetlands Dungeon:_
talk Ardin Grassman##262681
|tip On a ramp to the right, just before the Relic Guardian.
Learn What Happened to Adrin Grassman |q 95647/1
step
_Inside the Excavation Site Wetlands Dungeon:_
talk Ardin Grassman##262681
|tip On a ramp to the right, just before the Relic Guardian.
turnin Lost in the Thicket Things##95647
accept Heartwoven##95809
step
_Inside the Excavation Site Wetlands Dungeon:_
click Archival Panel
|tip To the right of the boss.
kill Relic Guardian##260326
|tip High tank damage encounter.
|tip Ranged keep away to avoid damage from {r}Thunderclap{}.
|tip The tank will be knocked around often.
|tip Uses a five second stun on the tank occasionally.
|tip Utilize stuns and slows on the boss to help mitigate damage during those times.
collect Titan Relic##270865 |n	|only if not completedq(95810)
use the Titan Relic##270865	|only if not completedq(95810)
accept Lost Relic Carry##95810	|only if not completedq(95810)
|confirm
step
talk Prospector Whelgar##1077
|tip Inside the small cave.
turnin Lost Relic Carry##95810 |goto Wetlands/0 38.81,52.39
step
talk Rethiel the Greenwarden##1244
|tip Walks around.
turnin Horrors in the Highland##95646 |goto Wetlands/0 56.34,40.43
step
talk James Halloran##2094
|tip Walks around.
turnin Highland Hides##98815 |goto Wetlands/0 8.51,55.71
step
talk Caitlin Grassman##1480
|tip Inside the building.
turnin Heartwoven##95809 |goto Wetlands/0 11.88,58.86
step
talk Dorin Songblade##956
|tip Inside the building.
turnin Fallen in the Fen##95795 |goto Redridge Mountains/0 25.72,46.43
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\The Stockade Quests",{
image=ZGV.IMAGESDIR.."The Stockade",
description="This guide will walk you through completing The Stockade quests.",
condition_suggested=function() return level >= 25 and level <= 30 and not completedq(378) end,
condition_end=function() return completedq(378) end,
},[[
step
Reach Level 25 |ding 25
|tip Use the Leveling guides to accomplish this.
step
talk Motley Garmason##1074
accept The Dark Iron War##303 |goto Wetlands 49.67,18.24
stickystart "Slay_Dark_Iron_Tunnelers"
stickystart "Slay_Dark_Iron_Saboteurs"
stickystart "Slay_Dark_Iron_Demolitionists"
step
kill 15 Dark Iron Dwarf##1051 |q 303/1 |goto Wetlands 48.56,16.64
|tip You may need help with this.
step
label "Slay_Dark_Iron_Tunnelers"
kill 5 Dark Iron Tunneler##1053 |q 303/2 |goto Wetlands 48.11,15.75
|tip You may need help with this.
You can find more around [46.80,16.26]
step
label "Slay_Dark_Iron_Saboteurs"
kill 5 Dark Iron Saboteur##1052 |q 303/3 |goto Wetlands 48.56,16.64
|tip You may need help with this.
You can find more around [46.80,16.26]
step
label "Slay_Dark_Iron_Demolitionists"
kill 5 Dark Iron Demolitionist##1054 |q 303/4 |goto Wetlands 47.45,15.44
|tip Inside the buildings around this area.
|tip You may need help with this.
step
talk Motley Garmason##1074
turnin The Dark Iron War##303 |goto Wetlands 49.67,18.24
accept The Fury Runs Deep##378 |goto Wetlands 49.67,18.24
step
talk Guard Berton##859
accept What Comes Around...##386 |goto Redridge Mountains 21.17,46.57
step
Enter the building |goto Duskwood 72.88,46.83 < 5 |walk
talk Councilman Millstipe##270
|tip He walks around inside the building.
accept Crime and Punishment##377 |goto Duskwood 71.92,47.79
step
talk Nikova Raskol##1721
|tip She walks around this area.
accept The Color of Blood##388 |goto Stormwind City 76.65,60.49
step
kill Edwin Vancleef##639
|tip This is the final boss of the Deadmines dungeon.
|tip Use our Dungeon guides to accomplish this.
collect An Unsent Letter##2874 |q 373 |future
step
use An Unsent Letter##2874
accept The Unsent Letter##373
step
Enter the building |goto Stormwind City 56.73,48.55 < 5 |walk
talk Baros Alexston##1646
turnin The Unsent Letter##373 |goto Stormwind City 57.75,47.86
accept Bazil Thredd##389 |goto Stormwind City 57.75,47.86
step
Enter the building |goto Stormwind City 52.33,69.91 < 5 |walk
talk Warden Thelwater##1719
|tip Inside the building.
turnin Bazil Thredd##389 |goto Stormwind City 51.48,69.38
accept The Stockade Riots##391 |goto Stormwind City 51.48,69.38
accept Quell The Uprising##387 |goto Stormwind City 51.48,69.38
step
Enter The Stockade Dungeon with Your Group |goto The Stockade/0 0.00,0.00 < 500 |c |q 378
stickystart "Kill_10_Defias_Prisoners"
stickystart "Kill_8_Defias_Convicts"
stickystart "Kill_8_Defias_Insurgents"
stickystart "Collect_10_Red_Wool_Bandanas"
step
_Inside The Stockade Dungeon:_
kill Targorr the Dread##1696
|tip He is the first boss of the dungeon.
|tip He should be in one of the side rooms at the start of the dungeon or the single room straight to the north.
collect Head of Targorr##3630 |q 386/1
step
_Inside The Stockade Dungeon:_
kill Kam Deepfury##1666
|tip He is the second boss of the dungeon.
|tip After entering, head north and follow the path east, he is in the second small room on the left.
collect Head of Deepfury##3640 |q 378/1
step
_Inside The Stockade Dungeon:_
kill Bazil Thredd##1716
|tip He is the fourth boss of the dungeon.
|tip Follow the east path all the way to the end.
collect Head of Bazil Thredd##2926 |q 391/1
step
_Inside The Stockade Dungeon:_
kill Dextren Ward##1663
|tip He is the fifth boss of the dungeon.
|tip Follow the west path all the way to the end.
collect Hand of Dextren Ward##3628 |q 377/1
step
label "Kill_10_Defias_Prisoners"
_Inside The Stockade Dungeon:_ |notinsticky
kill 10 Defias Prisoner##1706 |q 387/1
step
label "Kill_8_Defias_Convicts"
_Inside The Stockade Dungeon:_ |notinsticky
kill 8 Defias Convict##1711 |q 387/2
step
label "Kill_8_Defias_Insurgents"
_Inside The Stockade Dungeon:_ |notinsticky
kill 8 Defias Insurgent##1715 |q 387/3
step
label "Collect_10_Red_Wool_Bandanas"
_Inside The Stockade Dungeon:_ |notinsticky
Kill Defias enemies around this area
collect 10 Red Wool Bandana##2909 |q 388/1
step
talk Warden Thelwater##1719
|tip Inside the building.
turnin The Stockade Riots##391 |goto Stormwind City 51.48,69.38
turnin Quell The Uprising##387 |goto Stormwind City 51.48,69.38
step
Leave the building |goto Stormwind City 52.37,69.98 < 5 |walk
talk Nikova Raskol##1721
|tip She walks around this area.
turnin The Color of Blood##388 |goto Stormwind City 76.46,63.66
step
Enter the building |goto Duskwood 72.88,46.83 < 5 |walk
talk Councilman Millstipe##270
|tip He walks around inside the building.
turnin Crime and Punishment##377 |goto Duskwood 71.92,47.79
step
talk Guard Berton##859
turnin What Comes Around...##386 |goto Redridge Mountains 21.17,46.57
step
talk Motley Garmason##1074
turnin The Fury Runs Deep##378 |goto Wetlands 49.67,18.24
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Gnomeregan Quests",{
image=ZGV.IMAGESDIR.."Gnomeregan",
description="This guide will walk you through completing the Gnomeregan quests.",
condition_suggested=function() return level >= 25 and level <= 38 and not completedq(2928) end,
condition_end=function() return completedq(2928) end,
hideif=ZGV.IsClassicSoD,
},[[
step
Reach Level 25 |ding 25
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 52.89,50.93 < 5 |walk
talk Brother Sarno##7917
|tip Inside the building.
accept Tinkmaster Overspark##2923 |goto Stormwind City 51.06,48.36
step
talk Shoni the Shilent##6579
accept Gyrodrillmatic Excavationators##2928 |goto Stormwind City 62.63,34.11
step
talk Mathiel##6142
accept Klockmort's Essentials##2925 |goto Darnassus 59.48,45.38
step
talk Klockmort Spannerspan##6169
turnin Klockmort's Essentials##2925 |goto Ironforge 67.98,46.13
accept Essential Artificials##2924  |goto Ironforge 67.98,46.13
step
talk Tinkmaster Overspark##7944
turnin Tinkmaster Overspark##2923 |goto Ironforge 69.56,50.32
accept Save Techbot's Brain!##2922 |goto Ironforge 69.56,50.32
step
talk Gnoarn##6569
accept The Day After##2927 |goto Ironforge 69.18,50.56
step
talk Master Mechanic Castpipe##7950
accept Data Rescue##2930 |goto Ironforge 69.82,48.08
step
talk High Tinker Mekkatorque##7937
accept The Grand Betrayal##2929 |goto Ironforge 68.76,48.96
step
Enter the building |goto Dun Morogh 45.97,48.83 < 5 |walk
talk Ozzie Togglevolt##1268
|tip Inside the building.
turnin The Day After##2927 |goto Dun Morogh 45.88,49.38
accept Gnogaine##2926 |goto Dun Morogh 45.88,49.38
step
Enter the building |goto Dun Morogh/0 24.29,39.77 < 7 |walk
Ride the elevator down |goto Dun Morogh/0 23.41,39.21 < 10 |walk
Follow the path |goto Dun Morogh/0 21.98,36.73 < 10 |walk
Follow the path |goto Dun Morogh/0 19.93,36.02 < 10 |walk
Enter the Gnomeregan Dungeon with Your Group |goto Gnomeregan/0 0.00,0.00 < 500 |c |q 2928
step
Kill Addled enemies around this area
collect White Punch Card##9279 |goto Gnomeregan/0 43.27,52.87 |q 2930 |future
step
kill Techbot##6231
|tip You may need help with this.
collect Techbot's Memory Core##9277 |q 2922/1 |goto Gnomeregan/0 43.11,52.81
step
Run up the stairs |goto Gnomeregan/0 43.20,52.87 < 7 |only if walking
Cross the bridge |goto Gnomeregan/0 43.38,53.01 < 10 |only if walking
click Matrix Punchograph 3005-A
Choose _"Acquire Higher Level Access Card"_
collect Yellow Punch Card##9280 |goto Gnomeregan/0 43.37,52.89 |q 2930 |future
step
use the Empty Leaden Collection Phial##9283
|tip Use it on Irradiated Invaders or Irradiated Pillagers.
collect Full Leaden Collection Phial##9284 |q 2926/1 |goto Gnomeregan/0 43.38,53.23
You can find more around [43.08,53.54]
step
Enter the building |goto Dun Morogh 45.97,48.83 < 5 |walk
talk Ozzie Togglevolt##1268
|tip Inside the building.
turnin Gnogaine##2926 |goto Dun Morogh 45.88,49.38
accept The Only Cure is More Green Glow##2962 |goto Dun Morogh 45.88,49.38
step
Enter the building |goto Dun Morogh/0 24.29,39.77 < 7 |walk
Ride the elevator down |goto Dun Morogh/0 23.41,39.21 < 10 |walk
Follow the path |goto Dun Morogh/0 21.98,36.73 < 10 |walk
Follow the path |goto Dun Morogh/0 19.93,36.02 < 10 |walk
Enter the Gnomeregan Dungeon with Your Group |goto Gnomeregan/0 0.00,0.00 < 500 |c |q 2928
stickystart "Collect_24_Robo-Mechanical_Guts"
stickystart "Collect_12_Essential_Artificial"
step
_Inside the Gnomeregan Dungeon:_
click Matrix Punchograph 3005-B
|tip Stay on the upper levels of The Hall of Gears and follow the path around to the southwest to enter The Dormitory.
|tip After entering The Dormitory, follow the path around to the left to continue to The Dormitory's lower level.
|tip It is up against the wall in the lowest level of The Dormitory area.
Choose _"Acquire Higher Level Access Card"_
collect Blue Punch Card##9282 |q 2930 |future
step
_Inside the Gnomeregan Dungeon:_
kill Viscous Fallout##7079
|tip It is the first boss of the dungeon.
|tip It is in the lower level of the Hall of Gears.
|tip Leave The Dormitory and reenter The Hall of Gears and then jump down to the lower level.
use the Heavy Leaden Collection Phial##9364
|tip Use it on a living Irradiated Slime.
collect High Potency Radioactive Fallout##9365 |q 2962/1
step
_Inside the Gnomeregan Dungeon:_
kill Electrocutioner 6000##6235
|tip He is the third boss of the dungeon.
|tip He is in the center of the upper level of the Launch Bay.
|tip Follow the west path from The Hall of Gears to enter the Launch Bay.
collect Workshop Key##6893 |q 2930 |future
step
_Inside the Gnomeregan Dungeon:_
click Matrix Punchograph 3005-C
|tip It's up in the Launch Bay platform, with Electrocutioner 6000.
Choose _"Acquire Higher Level Access Card"_
collect Red Punch Card##9281 |q 2930 |future
step
_Inside the Gnomeregan Dungeon:_
click Miatrix Punchograph 3005-D
|tip It is found in the lower level of the Engineering Labs, along with Crowd Pummeler 9-60.
|tip Stay on the upper level of the Launch Bay and follow the southeast path to reach the Engineering Labs.
|tip After entering the Engineering Labs, go left and follow it a short distance to ride an elevator down to the lower level.
|tip It is on the opposite side of the large structure in the center of the room after getting off the elevator.
Choose _"Acquire Higher Level Access Card"_
collect Prismatic Punch Card##9316 |q 2930/1
step
label "Collect_24_Robo-Mechanical_Guts"
_Inside the Gnomeregan Dungeon:_ |notinsticky
Kill enemies around this area
collect 24 Robo-mechanical Guts##9309 |q 2928/1
step
label "Collect_12_Essential_Artificial"
_Inside the Gnomeregan Dungeon:_ |notinsticky
click Artificial Extrapolator##142344+
|tip They look like square upright machines scattered all over the instance.
collect 12 Essential Artificial##9278 |q 2924/1
step
_Inside the Gnomeregan Dungeon:_
kill Mekgineer Thermaplugg##7800 |q 2929/1
|tip He is the last boss of the dungeon.
|tip Leave the Engineering Labs through the lower level and follow the southwest path up and out, then continue west after the path splits.
step
Leave the Gnomeregan Dungeon
Click Here to Continue |confirm |q 2928
step
talk Klockmort Spannerspan##6169
turnin Essential Artificials##2924 |goto Ironforge 67.98,46.13
step
talk Tinkmaster Overspark##7944
turnin Save Techbot's Brain!##2922 |goto Ironforge 69.56,50.32
step
talk Master Mechanic Castpipe##7950
turnin Data Rescue##2930 |goto Ironforge 69.82,48.08
step
talk High Tinker Mekkatorque##7937
turnin The Grand Betrayal##2929 |goto Ironforge 68.76,48.96
step
Enter the building |goto Dun Morogh 45.97,48.83 < 5 |walk
talk Ozzie Togglevolt##1268
|tip Inside the building.
turnin The Only Cure is More Green Glow##2962 |goto Dun Morogh 45.88,49.38
step
talk Shoni the Shilent##6579
turnin Gyrodrillmatic Excavationators##2928 |goto Stormwind City 62.63,34.11
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Kraul Quests",{
image=ZGV.IMAGESDIR.."Razorfen Kraul",
description="This guide will walk you through completing the Razorfen Kraul quests.",
condition_suggested=function() return level >= 29 and level <= 40 and not completedq(1142) end,
condition_end=function() return completedq(1142) end,
},[[
step
Reach Level 29 |ding 29
|tip Use the Leveling guides to accomplish this.
step
talk Mebok Mizzyrix##3446
accept Blueleaf Tubers##1221 |goto The Barrens 62.37,37.62
step
click Snufflenose Command Stick##68865
collect Snufflenose Command Stick##6684 |q 1221/4|goto The Barrens 62.34,37.61
step
click Snufflenose Owner's Manual##21530
collect Snufflenose Owner's Manual##5897 |q 1221/3 |goto The Barrens 62.34,37.63
step
click Crate with Holes##21277
collect Crate With Holes##5880 |q 1221/2 |goto The Barrens 62.33,37.63
step
click Henrig Longbrow's Journal##19861
|tip It will be in the hand of a corpse on the ground.
collect Henrig Lonebrow's Journal##5791 |q 1100 |future |goto Thousand Needles 30.73,24.35
step
use Henrig Lonebrow's Journal##5791
accept Longbrow's Jounral##1100 |goto Thousand Needles 30.73,24.35
step
talk Falfindel Waywarder##4048
turnin Longbrow's Jounral##1100 |goto Feralas 89.63,46.57
accept The Crone of the Kraul##1101 |goto Feralas 89.63,46.57
step
Enter the Razorfen Kraul Dungeon with Your Group |goto Razorfen Kraul/0 0.00,0.00 < 500 |c |q 1142 |future
step
_Inside the Razorfen Kraul Dungeon:_
use the Crate With Holes##5880
|tip This will summon a gopher.
use the Snufflenose Command Stick##6684
|tip This will allow you to command the gopher.
|tip Once past Overlord Ramtusk, go to the biggest hill from the area with many bridges.
collect 6 Blueleaf Tuber##5876 |q 1221/1
step
_Inside the Razorfen Kraul Dungeon:_
kill Charlga Razorflank##4421
collect Razorflank's Medallion##5792 |q 1101/1
step
_Inside the Razorfen Kraul Dungeon:_
talk Heralath Fallowbrook##4510
|tip Inside the tent.
|tip Jump down from the platform where Charlga Razorflank was and head to the tent to the left.
accept Mortality Wanes##1142
step
_Inside the Razorfen Kraul Dungeon:_
talk Willix the Importer##4508
|tip Inside the building.
|tip This is an escort quest.
accept Willix the Importer##1144
stickystart "Treshala's Pendant"
step
_Inside the Razorfen Kraul Dungeon:_
Escort Willix the Importer out of Razorfen Kraul |q 1144/1
step
_Inside the Razorfen Kraul Dungeon:_
talk Willix the Importer##4508
|tip He will be at the entrance after the completion of the escort quest.
turnin Willix the Importer##1144
step
label "Treshala's Pendant"
_Inside the Razorfen Kraul Dungeon:_ |notinsticky
Kill Razorfen enemies around this area
collect Treshala's Pendant##5825 |q 1142/1
step
talk Mebok Mizzyrix##3446
turnin Blueleaf Tubers##1221 |goto The Barrens 62.37,37.62
step
talk Falfindel Waywarder##4048
turnin The Crone of the Kraul##1101 |goto Feralas 89.63,46.57
step
Run up the ramp |goto Darnassus 67.68,61.26 < 10 |only if walking
Continue up the ramp |goto Darnassus 63.69,57.75 < 10 |only if walking
Cross the bridge |goto Darnassus 65.71,61.63 < 10 |only if walking
talk Treshala Fallowbrook##4521
turnin Mortality Wanes##1142 |goto Darnassus 69.55,67.79
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\City of Dalaran Quests",{
author="support@zygorguides.com",
image=ZGV.IMAGESDIR.."City of Dalaran",
description="This guide will walk you through completing the City of Dalaran quests.",
condition_suggested=function() return level >= 30 and level <= 40 and not completedq(92458) end,
condition_end=function() return completedq(92458) end,
},[[
step
Reach level 30 |ding 30
|tip Use the Leveling guides to accomplish this.
step
talk High Sorcerer Andromath##5694
|tip Top of the tower.
accept Power Overwhelming##92489 |goto Stormwind City/0 48.71,87.63
step
talk Shylamiir##5502
|tip Inside the building.
accept A Green Sample##92456 |goto Stormwind City/0 31.24,62.82
step
talk Emissary Jacques##247264
accept An Alarming Request##92432 |goto Hillsbrad Foothills/0 48.30,60.10
step
talk Image of Archmage Modera##269127
turnin An Alarming Request##92432 |goto Silverpine Forest/0 68.60,45.20
accept Heart of Disruption##92458 |goto Silverpine Forest/0 68.60,45.20
accept Starving Arcane##92457 |goto Silverpine Forest/0 68.60,45.20
step
Enter the City of Dalaran Dungeon with Your Group |goto Silverpine Forest/0 69.28,45.55
stickystart "Kill_Remnants_and_Echoes"
step
_Inside the City of Dalaran Dungeon:_
kill Atrexis the Grave Knight##247126
|tip Casts {r}Summon Frail Skeleton{}, which spawns adds that must be focused down on priority.
|tip Allow the tank to establish threat on them before attacking.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Lyn the Ignored##247032
|tip Casts {r}Shadow Bolt Volley{} which hits everyone pretty hard.
|tip Casts {r}Curse of Thorns{} which should be dispelled if possible.
|tip Party members afflicted have a chance to take shadow damage when attacking.
|tip Occasionally summons non-elite skeleton adds that should be burned down.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Arcane Anomaly##245999
|tip Adds will spawn at the edges of the boss arena when engaging.
|tip Casts {r}Focal Blast{} which rotates {g}counter clockwise{} through the boss arena.
|tip Move and avoid being hit by the ability, as it's very likely to kill.
|tip {r}Arcane Bolt{} is cast at random party members.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Mana Phantom##269475+
|tip Casts {r}Mana Burn{} on random targets.
|tip Focus down each Mana Phantom before focusing on the boss.
kill Arcanic Enigma##246016
|tip Healer stand away from the rest of ranged to avoid potential AOE {r}Silence{}.
|tip {r}Arcane Manalings{} spont continuously during the encounter and should be AOE'd down.
|tip Casts {r}Manamorph{} on random players which lasts for 8 seconds can be mitigated by magic dispel abilities.
Slay the Arcanic Enigma |q 92489/1 |only if haveq(92489)
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Unstable Sentinel##246017
|tip {o}Angry Tomes{} will spawn during the fight, which should be focused down before returning to the boss.
|tip Ranged should stay at max range during the duration of the fight.
|tip {r}Malfunction{} deals AOE damage to players within 25 yards of the boss.
|tip With a 2 second cast timer, everyone should try to move out of the AoE.
|confirm
stickystart "Collect_Fel_Infused_Blossom"
step
_Inside the City of Dalaran Dungeon:_
kill Fel Ancient##246003
|tip Casts {r}Fel Timbers{} which leaves green pools on the floor.
|tip Move out of them immediately.
|tip {r}Entangle{} can overlap and trap you on the patches.
|tip It targets two party members rooting them where they were hit.
|confirm
step
label "Collect_Fel_Infused_Blossom"
_Inside the City of Dalaran Dungeon:_
click Fel Infused Blossom
collect Fel Infused Blossom##251983 |q 92456/1
|tip Next to the Fel Ancient
step
_Inside the City of Dalaran Dungeon:_
kill Mana Devourer##246008
|tip IMMUNE to Arcane Spells.
|tip {r}Debilitate{} deals damage to everyone within 45 yards, also draining 200 mana.
|tip Casts {r}Drain Vitality{} on the current target.
|tip It leaves a DoT that lasts 10 seconds.
|confirm
step
_Inside the City of Dalaran Dungeon:_
kill Shade of the Archmage##246020
|tip Spread out as much as possible.
|tip {r} Bounding Mana{} targets random players and throwns a projectile at them, that boomerangs back to the boss and hits players caught in the path.
|tip Range should keep max distance when possible to avoid {r}Arcane Explosion{}.
|tip When the boss is out of mana, he will cast {r}Mass Polymorph{}, followed by {r}Evocation{} to regenerate mana.
|tip Ranged can {g}line of sight{} Mass Polymorph, but make sure the boss does not leave the arena or it will reset.
collect Arcane Mote##251961 |q 92458/1 |only if haveq(92458)
|confirm
step
label "Kill_Remnants_and_Echoes"
_Inside the City of Dalaran Dungeon:_
kill 8 Seeking Remnant##247003+		|q 92457/1
kill 8 Saturated Remnant##247001+	|q 92457/2
kill 8 Mana Echo##246600+	|q 92457/3
step
talk Image of Archmage Modera##269127
turnin Heart of Disruption##92458 |goto Silverpine Forest/0 68.60,45.20
turnin Starving Arcane##92457 |goto Silverpine Forest/0 68.60,45.20
accept Friend of the Kirin Tor##92459 |goto Silverpine Forest/0 68.60,45.20
step
_Inside the City of Dalaran Dungeon:_
talk Archmage Celindra##252085
|tip Inside the Violet Citadel area.
turnin Friend of the Kirin Tor##92459
step
talk High Sorcerer Andromath##5694
|tip Top of the tower.
turnin Power Overwhelming##92489 |goto Stormwind City/0 48.71,87.63
step
talk Shylamiir##5502
|tip Inside the building.
turnin A Green Sample##92456 |goto Stormwind City/0 31.24,62.82
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Library Quests",{
image=ZGV.IMAGESDIR.."Scarlet Monastery",
description="This guide will walk you through completing the Razorfen Kraul Quests.",
},[[
step
Reach Level 34 |ding 34
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 52.86,50.85 < 6 |walk
Run down the ramp |goto Stormwind City 51.66,43.86 < 6 |walk
talk Brother Crowley##12336
|tip Inside the building.
accept Brother Anton##6141 |goto Stormwind City 52.62,43.18
step
Run up the ramp |goto Stormwind City 51.16,44.46 < 6 |walk
Leave the building |goto Stormwind City 52.86,50.85 < 6 |walk
talk Brother Anton##1182
|tip Inside the building.
turnin Brother Anton##6141 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##261 |goto Desolace 66.52,7.90
step
kill 30 Undead Ravager##11561 |q 261/1 |goto Desolace 64.09,91.64
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##1052 |goto Desolace 66.52,7.90
step
talk Librarian Mae Paledust##3979
accept Mythology of the Titans##1050 |goto Ironforge 74.97,12.46
step
talk Magus Ovlek##264265
accept Past Due##96800 |goto Alterac Mountains/0 9.91, 63.37
|tip Inside Dalaran City.
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto Hillsbrad Foothills 51.46,58.36
accept In the Name of the Light##1053 |goto Hillsbrad Foothills 51.46,58.36
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
Enter the Portal |goto Tirisfal Glades/0 85.33,32.27 < 7 |walk
Enter the Scarlet Monastery - Library Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway |q 1053
stickystart "Collect_Magic_of_Runemasters"
stickystart "Collect_Mythology_of_Titans"
step
Inside the Scarlet Monastery Library Dungeon:
kill Houndmaster Loksey##3974 |q 1053/4
|tip He is the first boss of the dungeon.
|tip Follow the path to enter Huntsman's Cloister, then continue south to the small room.
step
kill Arcanist Doan##6487
|tip For this encounter, he will cast "Detonation" which will damage the entire group.
|tip When he does this, use the pillars to line of sight the ability.
|tip This fight is very healing intensive, so if you have a hybrid class, additional healing may be required.
|tip He will also cast "Silence" on casters.
Click Here to Continue |confirm
step
label "Collect_Mythology_of_Titans"
_Inside the Scarlet Monastery Library Dungeon:_
click Mythology of the Titans##19284
|tip Continue through Huntsman's Cloister to enter the Gallery of Treasures.
|tip Once through the Gallery of Treasures the map will change back to Scarlet Monastery.
|tip It will be on the ground on the left side of the room.
|tip It looks like a small book on the ground below a window.
collect Mythology of the Titans##5536 |q 1050/1
step
label "Collect_Magic_of_Runemasters"
_Inside the Scarlet Monastery: Library Dungeon:_
click The Lost Magic of the Runemasters##650929
collect The Lost Magic of the Runemasters##273169 |q 96800/1
step
Leave the Scarlet Monastery Library Dungeon
Click Here to Continue |confirm |q 1050
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin In the Name of the Light##1053 |goto Hillsbrad Foothills 51.46,58.36
|tip This quest requires you to kill bosses in Scarlet Monastery - Library, Armory and Cathedral.
|tip Use the Scarlet Monastery Armory Quests and Scarlet Monastery Cathedral Quests guides to accomplish this.
|tip If you haven't completed the other objectives yet, skip this for now.
step
talk Magus Ovlek##264265
turnin Past Due##96800 |goto Alterac Mountains/0 9.91, 63.37
|tip Inside Dalaran City.
step
talk Librarian Mae Paledust##3979
turnin Mythology of the Titans##1050 |goto Ironforge 74.97,12.46
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Armory Quests",{
image=ZGV.IMAGESDIR.."Scarlet Monastery",
description="This guide will walk you through completing the Razorfen Kraul Quests.",
},[[
step
Reach Level 38 |ding 38
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 52.86,50.85 < 6 |walk
Run down the ramp |goto Stormwind City 51.66,43.86 < 6 |walk
talk Brother Crowley##12336
|tip Inside the building.
accept Brother Anton##6141 |goto Stormwind City 52.62,43.18
step
talk Brother Anton##1182
|tip Inside the building.
turnin Brother Anton##6141 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##261 |goto Desolace 66.52,7.90
step
kill 30 Undead Ravager##11561 |q 261/1 |goto Desolace 64.09,91.64
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##1052 |goto Desolace 66.52,7.90
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto Hillsbrad Foothills 51.46,58.36
accept In the Name of the Light##1053 |goto Hillsbrad Foothills 51.46,58.36
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
click Armory Door |goto Tirisfal Glades/0 85.41,31.59 < 7 |walk
|tip You will need The Scarlet Key from the chest behind Arcanist Doan in the Library to open this.
|tip A rogue with 175 Lockpicking skill can pick it and a Truesilver Key opens it too.
|tip Engineers can also blast the door open.
Enter the Portal |goto Tirisfal Glades/0 85.67,31.76 < 7 |walk
Enter the Scarlet Monastery - Armory Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway |q 1053
step
Inside the Scarlet Monastery Armory Dungeon:
kill Herod##3975 |q 1053/3
|tip He is the only boss of the dungeon, found all the way at the end.
step
Leave the Scarlet Monastery Armory Dungeon
Click Here to Continue |confirm |q 1053
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin In the Name of the Light##1053 |goto Hillsbrad Foothills 51.46,58.36
|tip This quest requires you to kill bosses in Scarlet Monastery - Library, Armory and Cathedral.
|tip Use the Scarlet Monastery Library Quests and Scarlet Monastery Cathedral Quests guides to accomplish this.
|tip If you haven't completed the other objectives yet, skip this for now.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scarlet Monastery Cathedral Quests",{
image=ZGV.IMAGESDIR.."Scarlet Monastery",
description="This guide will walk you through completing the Scarlet Monastery Cathedral Quests.",
},[[
step
Reach Level 40 |ding 40
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 52.86,50.85 < 6 |walk
Run down the ramp |goto Stormwind City 51.66,43.86 < 6 |walk
talk Brother Crowley##12336
|tip Inside the building.
accept Brother Anton##6141 |goto Stormwind City 52.62,43.18
step
talk Brother Anton##1182
|tip Inside the building.
turnin Brother Anton##6141 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##261 |goto Desolace 66.52,7.90
step
kill 30 Undead Ravager##11561 |q 261/1 |goto Desolace 64.09,91.64
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261 |goto Desolace 66.52,7.90
accept Down the Scarlet Path##1052 |goto Desolace 66.52,7.90
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto Hillsbrad Foothills 51.46,58.36
accept In the Name of the Light##1053 |goto Hillsbrad Foothills 51.46,58.36
step
Enter the building |goto Tirisfal Glades/0 82.65,32.88 < 7 |walk
click Cathedral Door |goto Tirisfal Glades/0 85.21,30.86 < 7 |walk
|tip You will need The Scarlet Key from the chest behind Arcanist Doan in the Library to open this.
|tip A rogue with 175 Lockpicking skill can pick it and a Truesilver Key opens it too.
|tip Engineers can also blast the door open.
Enter the Portal |goto Tirisfal Glades/0 85.32,30.48 < 7 |walk
Enter the Scarlet Monastery - Cathedral Dungeon with Your Group |goto Scarlet Monastery/0 0.00,0.00 < 500 |c |noway |q 1053
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill Scarlet Commander Mograine##3976 |q 1053/2
|tip He is the last boss of the dungeon, found all the way at the end.
step
Inside the Scarlet Monastery Cathedral Dungeon:
kill High Inquisitor Whitemane##3977 |q 1053/1
|tip She is the last boss of the dungeon, found all the way at the end.
step
Leave the Scarlet Monastery Cathedral Dungeon
Click Here to Continue |confirm |q 1053
step
Enter the building |goto Hillsbrad Foothills 50.47,58.56 < 6 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin In the Name of the Light##1053 |goto Hillsbrad Foothills 51.46,58.36
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Razorfen Downs Quests",{
image=ZGV.IMAGESDIR.."Razorfen Downs",
description="This guide will walk you through completing the Razorfen Downs Quests.",
},[[
step
Reach Level 39 |ding 39
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 52.86,50.85 < 7 |walk
talk Archbishop Benedictus##1284
|tip Inside the building.
accept Bring the Light##3636 |goto Stormwind City 50.30,45.53
step
Follow the path |goto The Barrens 45.30,89.28 < 20 |only if walking
Follow the path up |goto The Barrens 49.10,94.49
talk Myriam Moonsinger##12866
accept A Host of Evil##6626 |goto The Barrens 49.01,94.94
stickystart "Kill_8_Razorfen_Thronweavers"
stickystart "Kill_8_Death's_Head_Cultists"
step
kill 8 Razorfen Battleguard##7873 |q 6626/1 |goto The Barrens 48.59,95.47
You can find more around [48.22,92.41]
step
label "Kill_8_Razorfen_Thronweavers"
kill 8 Razorfen Thornweaver##7874 |q 6626/2 |goto The Barrens 48.14,92.26
step
label "Kill_8_Death's_Head_Cultists"
kill 8 Death's Head Cultist##7872 |q 6626/3 |goto The Barrens 46.68,87.95
You can find more around [48.22,92.41] |notinsticky
step
Follow the path up |goto The Barrens 49.10,94.49
talk Myriam Moonsinger##12866
turnin A Host of Evil##6626 |goto The Barrens 49.01,94.94
step
Enter the Razorfen Downs Dungeon with Your Group |goto Razorfen Downs 0.00,0.00 < 500 |c |q 3636
step
Inside the Razorfen Downs Dungeon:
click Holding Pen
|tip It looks like a large wooden fence on the north side of The Murder Pens.
|tip Follow the path left along the north side of the dungeon to reach the Spiral of Thorns and eventually The Caller's Chamber.
|tip Continue through The Caller's Chamber to reach The Murder Pens and immediately go left.
|tip Be sure to clear each area of enemies as you go.
talk Belnistrasz##8516
|tip Inside the Holding Pen.
accept Scourge of the Downs##3523
step
Inside the Razorfen Downs Dungeon:
talk Belnistrasz##8516
|tip Inside the Holding Pen.
turnin Scourge of the Downs##3523
accept Extinguishing the Idol##3525
|tip This is an escort quest.
|tip Accepting this quest will automatically start the escort after a few seconds.
|tip All group members will need to accept it at the same time to avoid missing the quest.
step
Inside the Razorfen Downs Dungeon:
Follow and protect Belnistrasz
Kill the enemies that attack in waves
kill Plaguemaw the Rotting##7356
Escort Belnistrasz to the Quilboar's Idol |q 3525/1
step
Inside the Razorfen Downs Dungeon:
click Belnistrasz's Brazier
|tip It will be in the room where he was channeling.
turnin Extinguishing the Idol##3525
step
Inside the Razorfen Downs Dungeon:
kill Amnennar the Coldbringer##7358 |q 3636/1
|tip He is the last boss of the dungeon.
|tip Follow the left path out of the Belnistrasz escort room, then go right in the Spiral of Thorns and jump down.
|tip From here, go west and follow the path as it wraps up and around, eventually reaching Amnennar at the top.
step
Leave the Razorfen Downs Dungeon
Click Here to Continue |confirm |q 3636
step
Enter the building |goto Stormwind City 52.86,50.85 < 7 |walk
talk Archbishop Benedictus##1284
|tip Inside the building.
turnin Bring the Light##3636 |goto Stormwind City 50.30,45.53
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Uldaman Quests",{
image=ZGV.IMAGESDIR.."Uldaman",
description="This guide will walk you through completing the Uldaman Quests.",
},[[
step
Reach Level 38 |ding 38
|tip Use the Leveling guides to accomplish this.
step
Follow the path |goto Loch Modan 46.86,77.59 < 20 |only if walking
Kill Shadowforge enemies around this area
|tip You may need help with this.
|tip You can find more inside the cave.
collect Shattered Necklace##7666 |goto Badlands 45.10,12.01 |q 2198 |future
step
use the Shattered Necklace##7666
accept The Shattered Necklace##2198
step
talk Talvash del Kissel##6826
turnin The Shattered Necklace##2198 |goto Ironforge 36.37,3.62
accept Lore for a Price##2199 |goto Ironforge 36.36,3.62
step
collect 5 Silver Bar##2842 |q 2199/1
|tip If you have the Mining profession, you can gather these.
|tip Search the guide menu for the item(s) to use the farming guides.
|tip You can also purchase them from the Auction House.
step
talk Talvash del Kissel##6826
turnin Lore for a Price##2199 |goto Ironforge 36.36,3.62
accept Back to Uldaman##2200 |goto Ironforge 36.36,3.62
step
talk Prospector Stormpike##1356
accept The Lost Dwarves##2398 |goto Ironforge 74.62,11.79
step
Follow the path |goto Badlands 51.84,15.51 < 30 |only if walking
Follow the path |goto Badlands 51.77,33.17 < 15 |only if walking
click Crumpled Map
accept A Sign of Hope##720 |goto Badlands 53.03,33.93
step
Follow the path up |goto Badlands 50.48,37.05 < 30 |only if walking
talk Prospector Ryedol##2910
turnin A Sign of Hope##720 |goto Badlands 53.42,43.40
accept A Sign of Hope##721 |goto Badlands 53.42,43.40
step
Follow the path |goto Badlands/0 51.90,15.69 < 20 |only if walking
Enter the cave |goto Badlands/0 54.50,57.78 < 7 |walk
talk Hammertoe Grez##2909
|tip Inside the cave.
Find Hammertoe Grez in Uldaman |q 721/1 |goto Badlands/0 54.04,57.67
step
talk Hammertoe Grez##2909
|tip Inside the cave.
turnin A Sign of Hope##721 |goto Badlands/0 54.04,57.67
accept Amulet of Secrets##722 |goto Badlands/0 54.04,57.67
step
kill Magregan Deepshadow##2932
|tip He patrols through the tunnels before the entrance.
|tip He has a slow respawn rate.
collect Hammertoe's Amulet##4635 |q 722/1 |goto Badlands/0 53.85,57.95
step
talk Hammertoe Grez##2909
|tip Inside the cave.
turnin Amulet of Secrets##722 |goto Badlands/0 54.04,57.67
accept Prospect of Faith##723 |goto Badlands/0 54.04,57.67
step
Leave the cave |goto Badlands/0 54.48,57.78 < 5 |walk
talk Prospector Ryedol##2910
turnin Prospect of Faith##723 |goto Badlands 53.42,43.40
accept Prospect of Faith##724 |goto Badlands 53.42,43.40
step
talk Prospector Stormpike##1356
accept Ironband Wants You!##707 |goto Ironforge 74.70,11.72
step
talk Historian Karnik##2916
turnin Prospect of Faith##724 |goto Ironforge 77.57,11.83
accept Passing Word of a Threat##725 |goto Ironforge 77.57,11.83
step
talk Advisor Belgrum##2918
turnin Passing Word of a Threat##725 |goto Ironforge 77.32,9.75
accept Passing Word of a Threat##726 |goto Ironforge 77.32,9.75
step
talk Historian Karnik##2916
turnin Passing Word of a Threat##726 |goto Ironforge 77.57,11.83
accept An Ambassador of Evil##762 |goto Ironforge 77.57,11.83
step
Enter the building |goto Loch Modan 36.64,48.53 < 7 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
accept Badlands Reagent Run##2500 |goto Loch Modan 37.07,49.38
step
talk Prospector Ironband##1344
turnin Ironband Wants You!##707 |goto Loch Modan 65.94,65.62
accept Find Agmond##738 |goto Loch Modan 65.94,65.62
step
click Battered Dwarven Skeleton
turnin Find Agmond##738 |goto Badlands 50.89,62.40
accept Murdaloc##739 |goto Badlands 50.89,62.40
step
kill Murdaloc##2945 |q 739/1 |goto Badlands 49.63,66.27
step
kill 12 Stonevault Bonesnapper##2893 |q 739/2 |goto Badlands 51.18,68.27
step
Enter the building |goto Badlands 42.93,29.93 < 10 |walk
Follow the path |goto Badlands 43.10,28.83 < 7 |walk
Run down the stairs |goto Badlands 42.20,26.74 < 7 |walk
Continue down the stairs |goto Badlands 41.24,27.44 < 7 |walk
kill Ambassador Infernus##2745
|tip Downstairs inside the building.
|tip You may need help with this.
collect Ambassador Infernus' Bracer##4621 |q 762/1 |goto Badlands 42.10,28.90
stickystart "Collect_Buzzard_Gizzards"
stickystart "Collect_Crag_Coyote_Fangs"
step
kill Lesser Rock Elemental##2735+
collect 5 Rock Elemental Shard##7848 |q 2500/3 |goto Badlands 19.46,43.02
step
label "Collect_Buzzard_Gizzards"
Kill Buzzard enemies around this area
collect 5 Buzzard Gizzard##7847 |q 2500/1 |goto Badlands 16.82,59.84
You can find more around: |notinsticky
[12.45,69.20]
[17.43,48.90]
[25.63,62.04]
[33.36,59.65]
[28.67,72.03]
[24.51,74.45]
[18.90,77.65]
step
label "Collect_Crag_Coyote_Fangs"
Kill Coyote enemies around this area
collect 10 Crag Coyote Fang##7846 |q 2500/2 |goto Badlands 23.75,55.12
You can find more around: |notinsticky
[14.18,65.72]
[31.58,65.16]
step
talk Prospector Ironband##1344
turnin Find Agmond##738 |goto Loch Modan 65.94,65.62
accept Agmond's Fate##704 |goto Loch Modan 65.94,65.62
step
Enter the building |goto Loch Modan 36.63,48.53 < 7 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
turnin Badlands Reagent Run##2500 |goto Loch Modan 37.07,49.38
accept Uldaman Reagent Run##17 |goto Loch Modan 37.07,49.38
step
talk Advisor Belgrum##2918
turnin An Ambassador of Evil##762 |goto Ironforge 77.32,9.75
accept The Lost Tablets of Will##1139 |goto Ironforge 77.32,9.75
step
Enter the Uldaman Dungeon with Your Group |goto Uldaman/0 0.00,0.00 < 500 |c |q 2279 |future
stickystart "Collect_4_Carved_Stone_Urn"
stickystart "Collect_12_Magenta_Cap_Cluster"
step
Inside the Uldaman Dungeon:
talk Remains of a Paladin##6912
|tip He's laying on the ground surrounded by enemies.
turnin Back to Uldaman##2200
accept Find the Gems##2201
step
Inside the Uldaman Dungeon:
talk Baelog##6906
|tip He is the first boss of the dungeon.
|tip Follow the path through the first corridor to enter the big open room, then follow the left corridor and enter the room to the south to reach Dig Two.
turnin The Lost Dwarves##2398
accept The Hidden Chamber##2240
step
Inside the Uldaman Dungeon:
click Baelog's Chest
|tip On the table behind Baelog.
collect Gni'kiv Medallion##7740 |q 2240 |future
step
Inside the Uldaman Dungeon:
click Conspicuous Urn
|tip It looks like a tall brown urn in the southeastern side of Dig Two, to the right of the large double doors.
collect Shattered Necklace Topaz##7671 |q 2201/3
step
Inside the Uldaman Dungeon:
kill Revelosh##6910
|tip He is the second boss of the dungeon.
|tip Leave Dig Two and go left.
collect The Shaft of Tsol##7741 |q 2240 |future
step
Inside the Uldaman Dungeon:
use The Shaft of Tsol##7741
collect Staff of Prehistoria##7733 |q 2240 |future
step
Inside the Uldaman Dungeon:
click Keystone
|tip In the Map Chamber, just after Revelosh.
|tip This will only be usable by someone with the Staff of Prehistoria.
|tip This will open the locked door, guarded by the boss Ironaya.
|tip After defeating Ironaya, enter the room she was in.
Explore the Hidden Chamber |q 2240/1
step
Inside the Uldaman Dungeon:
click Shadowforge Cache##113757
|tip Looting this will cause a few enemies to spawn.
|tip It looks like a stone chest on the northwestern side of Dig Three.
|tip Proceed north and follow the western-most path.
|tip After passing through the caves with bats you'll reach a more open area with a pit of non-elite scorpions.
|tip Go left here and immediately left again to reach Dig Three.
collect Shattered Necklace Ruby##7669 |q 2201/1
step
Inside the Uldaman Dungeon:
click Tablet of Will
|tip It is against the wall in Dig Three.
collect Tablet of Will##5824 |q 1139/1
step
Inside the Uldaman Dungeon:
kill Grimlok##4854
|tip Leave Dig Three and go left, then continue left to the end of The Stone Vault.
collect Shattered Necklace Sapphire##7670 |q 2201/2
step
Inside the Uldaman Dungeon:
use Talvash's Phial of Scrying##7667
click Talvash's Scrying Bowl##112877
turnin Find the Gems##2201
accept Restoring the Necklace##2204
step
Inside the Uldaman Dungeon:
click Altar of The Keepers
kill Archaedas##2748
|tip He is the last boss of the dungeon.
|tip Leave The Stone Vault and follow the left path to reach the Hall of the Crafters.
collect Shattered Necklace Power Source##7672 |q 2204/1
step
Inside the Uldaman Dungeon:
click The Discs of Norgannon
|tip In the room behind Archaedas.
|tip You will only be able to access this room after Archadas is defeated.
accept The Platinum Discs##2278
|only if level >=40
step
Inside the Uldaman Dungeon:
talk Lore Keeper of Norgannon##7172
Select _"Who are the Earthen?"_
Learn What Lore That the Stone Watcher Has to Offer |q 2278/1
|only if level >=40
step
Inside the Uldaman Dungeon:
click The Discs of Norgannon
turnin The Platinum Discs##2278
accept The Platinum Discs##2279
|only if level >=40
step
label "Collect_4_Carved_Stone_Urn"
Inside the Uldaman Dungeon: |notinsticky
click Carved Stone Urn
|tip They are scattered throughout the instance.
collect 4 Carved Stone Urn##4610 |q 704/1
step
label "Collect_12_Magenta_Cap_Cluster"
Inside the Uldaman Dungeon: |notinsticky
click Magenta Cap Cluster##126049+
|tip They look like a pair of mushrooms along the walls of the cave areas.
|tip You can find more outside of the dungeon.
collect 12 Magenta Cap Cluster##8047 |q 2202/1
step
Leave the Uldaman Dungeon
Click Here to Continue |confirm |q 1139
step
talk Prospector Ironband##1344
turnin Agmond's Fate##704 |goto Loch Modan 65.93,65.62
step
Enter the building |goto Loch Modan 36.63,48.52 < 5 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
turnin Uldaman Reagent Run##17 |goto Loch Modan 37.07,49.37
step
Run up the stairs |goto Ironforge 31.94,8.36 < 5 |only if walking
Enter the building |goto Ironforge 31.98,5.42 < 5 |walk
talk Tymor##8507
|tip Inside the building.
turnin Passing the Burden##3448 |goto Ironforge 30.98,4.81
step
talk High Explorer Magellas##5387
turnin The Platinum Discs##2279 |goto Ironforge 69.93,18.54
accept The Platinum Discs##2439 |goto Ironforge 69.93,18.54
|only if level >=40
step
Enter the building |goto Ironforge 34.08,62.42 < 7 |walk
talk Dinita Stonemantle##7292
|tip Inside the building.
turnin The Platinum Discs##2439 |goto Ironforge 33.48,60.21
step
talk Talvash del Kissel##6826
turnin Restoring the Necklace##2204|goto Ironforge 36.36,3.62
step
talk Prospector Stormpike##1356
turnin The Hidden Chamber##2240 |goto Ironforge 74.66,11.73
step
talk Advisor Belgrum##2918
turnin The Lost Tablets of Will##1139 |goto Ironforge 77.32,9.75
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Zul'Farrak Quests",{
image=ZGV.IMAGESDIR.."Zul'Farrak",
description="This guide will walk you through completing the Zul'Farrak Quests.",
},[[
step
Reach Level 40 |ding 40
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto The Hinterlands 11.00,45.68 < 7 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
accept Witherbark Cages##2988 |goto The Hinterlands 9.76,44.48
step
click First Witherbark Cage
Check the First Cage |q 2988/1 |goto The Hinterlands 23.28,58.75
step
click Second Witherbark Cage
Check the Second Cage |q 2988/2 |goto The Hinterlands 23.13,58.76
step
Follow the path |goto The Hinterlands 30.53,53.53 < 30 |only if walking
Follow the path |goto The Hinterlands 32.40,57.21 < 15 |only if walking
click Third Witherbark Cage
Check the Third Cage |q 2988/3 |goto The Hinterlands 31.99,57.38
step
Follow the path up |goto The Hinterlands 12.91,48.27 < 15 |only if walking
Enter the building at the top of the path |goto The Hinterlands 11.00,45.67 < 7 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin Witherbark Cages##2988 |goto The Hinterlands 9.76,44.47
accept The Altar of Zul##2989 |goto The Hinterlands 9.76,44.47
step
Run up the stairs |goto The Hinterlands 47.75,66.74 < 15 |only if walking
Search the Altar of Zul |q 2989/1 |goto The Hinterlands 48.85,68.45
|tip There are elite enemies at the top of the temple.
|tip Complete the quest goal and immediately run away to safety.
step
Follow the path up |goto The Hinterlands 12.85,48.25 < 15 |only if walking
Enter the building at the top of the path |goto The Hinterlands 11.00,45.67 < 7 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin The Altar of Zul##2989 |goto The Hinterlands 9.76,44.48
accept Thadius Grimshade##2990 |goto The Hinterlands 9.76,44.48
step
talk Thadius Grimshade##8022
|tip Upstairs inside the building, at the top.
turnin Thadius Grimshade##2990 |goto Blasted Lands 66.90,19.47
accept Nekrum's Medallion##2991 |goto Blasted Lands 66.90,19.47
step
Run up the stairs |goto The Hinterlands 47.74,66.60 < 10 |only if walking
kill Qiaga the Keeper##7996
|tip At the top of the Altar of Zul.
|tip You may need help with this.
collect Sacred Mallet##9241 |goto The Hinterlands 48.66,68.25 |q 2770 |future
step
Run up the stairs |goto The Hinterlands 66.67,66.75 < 10 |only if walking
Continue up the stairs |goto The Hinterlands 67.91,69.04 < 10 |only if walking
Follow the path |goto The Hinterlands 67.78,70.69 < 10 |only if walking
Run up the stairs |goto The Hinterlands 65.07,68.93 < 10 |only if walking
Follow the path |goto The Hinterlands 63.77,70.68 < 10 |only if walking
Continue following the path |goto The Hinterlands 65.39,72.99 < 10 |q 2770 |future
step
Run up the stairs |goto The Hinterlands 67.16,73.31 < 10 |only if walking
Follow the path |goto The Hinterlands 64.54,74.99 < 10 |only if walking
Run up the stairs |goto The Hinterlands 62.17,71.38 < 10 |only if walking
Continue up the stairs |goto The Hinterlands 59.92,70.16 < 10 |only if walking
Follow the path |goto The Hinterlands 59.16,74.13 < 10 |q 2770 |future
step
use the Sacred Mallet##9241
collect Mallet of Zul'Farrak##9240 |goto The Hinterlands 59.64,77.90 |q 2770 |future
step
Enter the building |goto Dustwallow Marsh 45.88,57.22 < 5 |walk
talk Tabetha##6546
|tip Inside the building.
accept Tiara of the Deep##2846 |goto Dustwallow Marsh 46.06,57.09
step
talk Wizzle Brassbolts##4453
accept Gahz'rilla##2770 |goto Thousand Needles 78.14,77.11
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.98,22.36
step
kill Vale Screecher##5307+
|tip These have a low spawn rate.
use Yeh'Kinya's Bramble##10699
|tip Use it on their corpse.
talk Screecher Spirit##8612+
collect 3 Screecher Spirits |q 3520/1 |goto Feralas 58.31,57.70
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.98,22.36
accept The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
talk Chief Engineer Bilgewhizzle##7407
accept Divino-matic Rod##2768 |goto Tanaris 52.46,28.51
step
talk Tran'rek##7876
accept Scarab Shells##2865 |goto Tanaris 51.57,26.76
step
talk Trenton Lighthammer##7804
accept Troll Temper##3042 |goto Tanaris 51.42,28.75
step
Enter the Zul'Farrak Dungeon with Your Group |goto Zul'Farrak/0 0.00,0.00 < 555 |c |q 2991
stickystart "Collect_5_Uncracked_Scarab_Shell"
stickystart "Collect_20_Troll_Temper"
step
Inside the Zul'Farrak Dungeon:
kill Theka the Martyr##7272
|tip He is the second boss of the dungeon.
|tip Follow the path north and then go right when the path splits.
|tip Quickly go left afterwards and then north.
collect First Mosh'aru Tablet##10660 |q 3527/1
stickystart "Collect_Divino-matic_Rod"
step
Inside the Zul'Farrak Dungeon:
Kill the enemies that attack in waves
|tip Continue following the path west and run up the stairs to reach the top of the large pyramid.
|tip Kill the Sandfury Executioner and then open the cages to start the event.
kill Nekrum Gutchewer##7796
|tip He will be killable after you release them from captivity and clear the temple event.
collect Nekrum's Medallion##9471 |q 2991/1
step
label "Collect_Divino-matic_Rod"
Inside the Zul'Farrak Dungeon: |notinsticky
kill Sergeant Bly##7604
|tip He will be killable after you release them from captivity and clear the temple event.
collect Divino-matic Rod##8548 |q 2768/1
step
Inside the Zul'Farrak Dungeon:
kill Hydromancer Velratha##7795
|tip Follow the path southeast to reach the large room with a pool in the center.
|tip She walks around this area.
collect Tiara of the Deep##9234 |q 2846/1
collect Second Mosh'aru Tablet##10661 |q 3527/2
step
Inside the Zul'Farrak Dungeon:
use the Mallet of Zul'Farrak##9240
|tip Clear the room.
|tip Use it near the gong atop the pool of water.
kill Gahz'rilla##7273
collect Gahz'rilla's Electrified Scale##8707 |q 2770/1
step
label "Collect_5_Uncracked_Scarab_Shell"
Inside the Zul'Farrak Dungeon: |notinsticky
kill Scarab##7269
|tip They are found all around the instance, but mostly in the scarab room with Theka the Martyr.
collect 5 Uncracked Scarab Shell##9238 |q 2865/1
step
label "Collect_20_Troll_Temper"
Inside the Zul'Farrak Dungeon: |notinsticky
Kill enemies around this area
|tip These drop from troll enemies inside of Zul'Farrak.
|tip It will likely take multiple runs to complete.
collect 20 Troll Temper##9523 |q 3042/1
step
Leave the Zul'Farak Dungeon
Click Here to Continue |confirm |q 2991
step
talk Yeh'kinya##8579
turnin The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
talk Chief Engineer Bilgewhizzle##7407
turnin Divino-matic Rod##2768 |goto Tanaris 52.46,28.51
step
talk Tran'rek##7876
turnin Scarab Shells##2865 |goto Tanaris 51.57,26.76
step
talk Trenton Lighthammer##7804
turnin Troll Temper##3042 |goto Tanaris 51.42,28.75
step
talk Wizzle Brassbolts##4453
turnin Gahz'rilla##2770 |goto Thousand Needles 78.14,77.11
step
Enter the building |goto Dustwallow Marsh 45.88,57.22 < 5 |walk
talk Tabetha##6546
|tip Inside the building.
turnin Tiara of the Deep##2846 |goto Dustwallow Marsh 46.06,57.09
step
talk Thadius Grimshade##8022
|tip Upstairs inside the building, at the top.
turnin Nekrum's Medallion##2991 |goto Blasted Lands 66.90,19.47
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Maraudon Quests",{
image=ZGV.IMAGESDIR.."Maraudon",
description="This guide will walk you through completing the Maraudon Quests.",
},[[
step
Reach Level 45 |ding 45
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Dustwallow Marsh 65.73,48.61 < 7 |walk
talk Archmage Tervosh##4967
|tip At the top of the tower.
accept Shadowshard Fragments##7070 |goto Dustwallow Marsh 66.42,49.26
step
talk Talendria##11715
|tip Upstairs inside the building.
accept Vyletongue Corruption##7041 |goto Desolace 68.50,8.87
step
Run up the ramp |goto Desolace 64.66,9.23 < 10 |only if walking
talk Keeper Marandis##13698
accept Corruption of Earth and Seed##7065 |goto Desolace 63.82,10.66
step
talk Willow##13656
|tip Inside the building.
accept Twisted Evils##7028 |goto Desolace 62.19,39.63
step
talk Centuar Pariah##13717
|tip He walks around this area.
accept The Pariah's Instructions##7067 |goto Desolace 51.47,87.41
You may also find him around: |notinsticky
[48.23,87.69]
[43.95,86.00]
step
Run up the stairs |goto Desolace 29.84,62.54 < 7 |only if walking
click Stone Door
Enter the building |goto Desolace 38.43,57.98 < 5 |q 7066 |future
step
kill The Nameless Prophet##13718
|tip He spawns in multiple locations outside of the Maraudon dungeon.
|tip You may need help with this.
collect Amulet of Spirits##17757 |goto Desolace 38.31,57.96 |q 7067
You may also find him at: |notinsticky
[38.32,58.18]
[38.20,58.05]
[38.39,57.96]
step
Run down the stairs |goto Desolace 38.25,57.99 < 7 |only if walking
Follow the path |goto Desolace 38.43,57.85 < 10 |only if walking
Continue following the path |goto Desolace 38.64,57.71 < 7 |only if walking
Continue following the path |goto Desolace 38.53,57.55 < 10 |only if walking
Continue following the path |goto Desolace 38.48,57.34 < 7 |q 7067
step
Continue following the path |goto Desolace 29.44,57.22 < 7 |only if walking
Jump down here |goto Desolace 28.80,56.17 < 7 |q 7067
step
Enter the cave |goto Desolace 28.71,56.20 < 5 |only if walking
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Gelk.
|tip He walks around this area.
kill Gelk##13741
collect Gem of the Second Khan##17762 |goto Desolace 38.47,57.29 |q 7067
step
Follow the path |goto Desolace 38.46,57.08 < 5 |only if walking
Kill Shadowshard enemies around this area
collect 10 Shadowshard Fragment##17756 |q 7070/1 |goto Desolace 28.32,54.47
step
Follow the path |goto Desolace 29.58,55.54 < 7 |only if walking
Continue following the path |goto Desolace 29.46,57.25 < 7 |only if walking |q 7067
step
Jump down here |goto Desolace 38.53,57.60 < 5 |only if walking
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Kolk.
kill Kolk##13742
collect Gem of the First Khan##17761 |goto Desolace 38.50,57.72 |q 7067
step
Follow the path |goto Desolace 38.60,57.95 < 10 |only if walking
Continue following the path |goto Desolace 38.44,58.13 < 7 |only if walking
Continue following the path |goto Desolace 38.49,58.22 < 7 |q 7067
step
talk Cavindra##Cavindra
accept Legend of Maraudon##7044	|goto Desolace 38.76,58.13
step
Follow the path |goto Desolace 38.82,58.31 < 7 |only if walking
use Coated Cerulean Vial##17693
collect Filled Cerulean Vial##17696 |q 7041/2 |goto Desolace 38.92,58.36
step
Follow the path |goto Desolace 39.08,58.01 < 10 |only if walking
Continue following the path |goto Desolace 39.35,58.03 < 7 |only if walking
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Magra.
|tip He walks around this area.
kill Magra##13740
collect Gem of the Third Khan##17763 |goto Desolace 39.20,57.68 |q 7067
step
Follow the path |goto Desolace 39.21,57.84 < 10 |only if walking
Continue following the path |goto Desolace 39.35,58.04 < 10 |only if walking
Enter the Maraudon (Foulspore Cavern - Orange) Dungeon with Your Group |goto Maraudon/0 0.00,0.00 < 500 |c |q 7046 |future
stickystart "Collect_Gem_of_the_Fifth_Khan"
stickystart "Heal_Vylestem_Vines"
stickystart "Collect_15_Theradric_Crystal_Carving"
step
Inside the Maraudon Dungeon:
kill Noxxion##13282
|tip It is the first boss on the Orange side of Maraudon.
|tip After entering the dungeon, run up the stairs and follow the path to the right whenever possible.
collect Celebrian Rod##17702 |q 7044/2
step
label "Collect_Gem_of_the_Fifth_Khan"
Inside the Maraudon Dungeon: |notinsticky
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Veng.
|tip He walks around the Orange side of Maraudon.
kill Veng##13738
collect Gem of the Fifth Khan##17765 |q 7067
step
label "Heal_Vylestem_Vines"
Inside the Maraudon Dungeon: |notinsticky
use the Filled Cerulean Vial##17696
|tip While in the Foulspore Cavern, or Orange side of Maraudon, there will be tree stumps with a red top.
|tip You won't be able to target them.
|tip They have five leaves growing out of them.
|tip Use the Filled Cerulean Vial near them and Noxxious Scion will spawn.
kill Noxxious Scion##13696+
Heal 8 Vylestem Vines |q 7041/1
step
Leave the Maraudon - Orange Dungeon
Click Here to Continue |confirm |q 7067
stickystop "Collect_15_Theradric_Crystal_Carving"
step
Follow the path |goto Maraudon/0 39.21,58.04 < 7 |only if walking
Continue following the path |goto Maraudon/0 39.08,58.26 < 7 |only if walking
Continue following the path |goto Maraudon/0 38.82,58.29 < 10 |only if walking
Continue following the path |goto Maraudon/0 38.59,58.23 < 7 |only if walking
Continue following the path |goto Desolace 29.61,64.71 < 7 |q 7067
step
Jump down here |goto Desolace 27.84,62.83 < 10
Follow the path |goto Desolace 29.32,61.24 < 7 |walk
Follow the path |goto Desolace 29.67,58.58 < 7 |walk
Enter the Maraudon - Purple Dungeon with Your Group |goto Maraudon/0 0.00,0.00 < 500 |c |q 7066 |future
stickystart "Collect_15_Theradric_Crystal_Carving"
step
Inside the Maraudon Dungeon:
use the Amulet of Spirits##17757
|tip Use it on the Spirit of Maraudos.
|tip He walks around The Wicked Grotto in the Purple side of Maraudon.
kill Maraudos##13739
collect Gem of the Fourth Khan##17764 |q 7067
step
Inside the Maraudon Dungeon:
use the Gem of the Fifth Khan##17765
collect Amulet of Union##17758 |q 7067/1
step
Inside the Maraudon Dungeon:
kill Lord Vyletongue##12236
|tip He is Purple side of Maraudon.
|tip Proceed through The Wicked Grotto and enter the Vyletongue Seat.
|tip He is in a small room on the northern side.
collect Celebrian Diamond##17703 |q 7044/1
step
Inside the Maraudon Dungeon:
kill Celebras the Cursed##12225
|tip He is Purple side of Maraudon.
|tip Continue through the Vyletongue Seat and into the Poison Falls.
|tip Once you reach the Poison Falls, continue working your way west and then south, where he will be on a small island.
talk Celebras the Redeemed##13716
|tip He will appear after you kill Celebras the Cursed.
turnin Legend of Maraudon##7044
accept The Scepter of Celebras##7046
step
Inside the Maraudon Dungeon:
Follow Celebras the Redeemed
|tip Click the stone he leads you to.
click Incantations of Celebras
Watch the Dialogue
Create the Scepter of Celebras |q 7046/1
step
Inside the Maraudon Dungeon:
talk Celebras the Redeemed##13716
turnin The Scepter of Celebras##7046
step
Inside the Maraudon Dungeon:
kill Princess Theradras##12201 |q 7065/1
|tip She is the last boss on the Purple side of Maraudon.
|tip Continue going south and jump down the waterfall.
|tip Continue following the path south through the dungeon to reach Zaetar's Grave.
|tip Princess Theradras is found at the end of Zaetar's Grave.
step
Inside the Maraudon Dungeon:
talk Zaetar's Spirit##12238
|tip He will appear at the center of the room once Princess Theradras is killed.
accept Seed of Life##7066
step
label "Collect_15_Theradric_Crystal_Carving"
Inside the Maraudon Dungeon: |notinsticky
Kill enemies around this area
|tip These drop from enemies inside of Maraudon.
collect 15 Theradric Crystal Carving##17684 |q 7028/1
step
Leave the Maraudon Dungeon
Click Here to Continue |confirm |q 7066
step
talk Centuar Pariah##13717
|tip He walks around this area.
turnin The Pariah's Instructions##7067 |goto Desolace 51.47,87.41
You may also find him around: |notinsticky
[48.23,87.69]
[43.95,86.00]
step
talk Willow##13656
|tip Inside the building.
turnin Twisted Evils##7028 |goto Desolace 62.19,39.63
step
talk Talendria##11715
|tip Upstairs inside the building.
turnin Vyletongue Corruption##7041 |goto Desolace 68.50,8.87
step
Run up the ramp |goto Desolace 64.66,9.23 < 10 |only if walking
talk Keeper Marandis##13698
turnin Corruption of Earth and Seed##7065 |goto Desolace 63.82,10.66
step
Enter the building |goto Dustwallow Marsh 65.73,48.61 < 7 |walk
talk Archmage Tervosh##4967
|tip At the top of the tower.
turnin Shadowshard Fragments##7070 |goto Dustwallow Marsh 66.42,49.26
step
talk Keeper Remulos##11832
turnin Seed of Life##7066 |goto Moonglade 36.18,41.82
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Temple of Atal'Hakkar Quests",{
image=ZGV.IMAGESDIR.."The Temple of Atal'Hakkar",
description="This guide will walk you through completing the Temple of Atal'Hakkar Quests.",
hideif=ZGV.IsClassicSoD,
},[[
step
Reach Level 47 |ding 47
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 68.89,42.12 < 8 |walk
talk Brohann Caskbelly##5384
accept In Search of The Temple##1448 |goto Stormwind City 69.44,40.43
step
Search for the Temple of Atal'Hakkar |q 1448/1 |goto Swamp of Sorrows 66.82,59.39
step
Enter the building |goto Stormwind City 68.89,42.12 < 8 |walk
talk Brohann Caskbelly##5384
turnin In Search of The Temple##1448 |goto Stormwind City 69.44,40.43
accept To The Hinterlands##1449 |goto Stormwind City 69.44,40.43
step
talk Falstad Wildhammer##5635
turnin To The Hinterlands##1449 |goto The Hinterlands 11.81,46.76
accept Gryphon Master Talonaxe##1450 |goto The Hinterlands 11.81,46.76
step
Run up the ramp |goto The Hinterlands 11.75,46.90 < 10 |only if walking
Enter the building |goto The Hinterlands 11.00,45.68 < 10 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin Gryphon Master Talonaxe##1450 |goto The Hinterlands 9.75,44.48
accept Rhapsody Shindigger##1451 |goto The Hinterlands 9.75,44.48
step
Follow the path up |goto The Hinterlands 21.02,47.81 < 15 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody Shindigger##1451 |goto The Hinterlands 26.94,48.59
accept Rhapsody's Kalimdor Kocktail##1452 |goto The Hinterlands 26.94,48.59
step
Kill Roc enemies around this area
collect 3 Roc Gizzard##6257 |q 1452/1 |goto Tanaris 43.48,40.36
step
Enter the building |goto Feralas 31.84,45.02 < 5 |walk
talk Angelas Moonbreeze##7900
accept The Sunken Temple##3445 |goto Feralas 31.83,45.61
step
Kill Ironfur enemies around this area
|tip They share a spawn with Groddoc enemies around this area.
collect 3 Ironfur Liver##6258 |q 1452/2 |goto Feralas 49.93,30.39
You can find more around [46.20,25.09]
step
Kill Groddoc enemies around this area
|tip They share a spawn with Ironfur enemies around this area.
collect 3 Groddoc Liver##6259 |q 1452/3 |goto Feralas 49.93,30.39
You can find more around [46.20,25.09]
step
Follow the path up |goto The Hinterlands 21.02,47.81 < 15 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody's Kalimdor Kocktail##1452 |goto The Hinterlands 26.94,48.59
Watch the Dialogue
accept Rhapsody's Tale##1469 |goto The Hinterlands 26.94,48.59
step
Enter the building |goto Stormwind City 68.93,42.08 < 8 |walk
talk Brohann Caskbelly##5384
|tip Inside the building.
turnin Rhapsody's Tale##1469 |goto Stormwind City 69.45,40.41
accept Into The Temple of Atal'Hakkar##1475 |goto Stormwind City 69.45,40.41
step
talk Marvon Rivetseeker##7771
turnin The Sunken Temple##3445 |goto Tanaris 52.71,45.92
accept The Stone Circle##3444 |goto Tanaris 52.71,45.92
step
click Marvon's Chest
collect Stone Circle##10556 |q 3444/1 |goto The Barrens 62.50,38.54
step
talk Marvon Rivetseeker##7771
turnin The Stone Circle##3444 |goto Tanaris 52.71,45.92
accept Into the Depths##3446 |goto Tanaris 52.71,45.92
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.98,22.36
step
kill Vale Screecher##5307+
|tip These have a low spawn rate.
use Yeh'Kinya's Bramble##10699
|tip Use it on their corpse.
talk Screecher Spirit##8612+
Collect 3 Screecher Spirits |q 3520/1 |goto Feralas 58.31,57.70
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.98,22.36
accept The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
Enter the Zul'Farrak Dungeon with Your Group |goto Zul'Farrak/0 0.00,0.00 < 555 |c |q 3527 |future
|tip You may need help with this quest.
step
Inside the Zul'Farrak Dungeon:
kill Theka the Martyr##7272
|tip Follow the path north and then go right when the path splits.
|tip Quickly go left afterwards and then north.
|tip He is the second boss of the dungeon.
|tip You may need help with this.
collect First Mosh'aru Tablet##10660 |q 3527/1
step
Inside the Zul'Farrak Dungeon:
kill Hydromancer Velratha##7795
|tip Follow the path west to reach an open room with a large pyramid on the western side.
|tip Continue following the path southeast to reach the large room with a pool in the center.
|tip She walks around this area.
|tip You may need help with this.
collect Second Mosh'aru Tablet##10661 |q 3527/2
step
Leave the Zul'Farrak Dungeon
Click Here to Continue |confirm |q 3527 |future
step
talk Yeh'kinya##8579
turnin The Prophecy of Mosh'aru##3527 |goto Zul'Farrak/0 66.98,22.36
accept The Ancient Egg##4787 |goto Zul'Farrak/0 66.98,22.36
step
Follow the path |goto The Hinterlands 35.78,64.12 < 15 |only if walking
Run up the stairs |goto The Hinterlands 33.09,73.80 < 15 |only if walking
Jump down here |goto The Hinterlands 33.11,75.53 < 7 |only if walking
talk Atal'ai Exile##5598
accept Jammal'an the Prophet##1446 |goto The Hinterlands 33.75,75.22
step
Follow the path |goto The Hinterlands 35.79,64.07 < 15 |only if walking
Run up the stairs |goto The Hinterlands 66.70,66.71 < 8 |only if walking
Follow the path |goto The Hinterlands 66.63,68.83 < 10 |only if walking
Run up the stairs |goto The Hinterlands 67.93,69.12 < 10 |only if walking
Follow the path |goto The Hinterlands 67.78,70.73 < 10 |q 4787
step
Run up the stairs |goto The Hinterlands 65.08,68.94 < 8 |only if walking
Follow the path |goto The Hinterlands 63.69,70.44 < 10 |only if walking
Continue following the path |goto The Hinterlands 65.38,72.92 < 10 |only if walking
Run up the stairs |goto The Hinterlands 67.14,73.37 < 8 |only if walking
Follow the path |goto The Hinterlands 67.15,75.46 < 10 |q 4787
step
Follow the path |goto The Hinterlands 64.52,74.83 < 10 |only if walking
Run up the stairs |goto The Hinterlands 62.16,71.38 < 10 |only if walking
Continue up the stairs |goto The Hinterlands 59.96,70.17 < 10 |only if walking
Follow the path |goto The Hinterlands 58.68,70.28 < 10 |only if walking
Continue following the path |goto The Hinterlands 59.15,74.30 < 10 |q 4787
step
Enter the cave |goto The Hinterlands 58.61,79.19 < 10 |walk
Follow the path down |goto The Hinterlands 58.26,82.31 < 10 |walk
Follow the path up |goto The Hinterlands 54.81,83.42 < 10 |walk
click Ancient Egg##175889
|tip Inside the cave.
|tip You may need help with this.
collect Ancient Egg##12402 |q 4787/1 |goto The Hinterlands 57.52,86.78
step
talk Yeh'kinya##8579
turnin The Ancient Egg##4787 |goto Tanaris 66.98,22.36
accept The God Hakkar##3528 |goto Tanaris 66.98,22.36
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
accept Muigin and Larion##4141 |goto Un'Goro Crater 42.94,9.65
step
label "Collect_Bloodpetals"
Kill Bloodpetal enemies around this area
|tip They look like walking plants.
collect 15 Bloodpetal##11316 |q 4141/1 |goto Un'Goro Crater 71.46,38.72
|tip These have a low drop rate.
You can find more around: |notinsticky
[69.26,24.59]
[66.08,35.13]
[55.87,34.69]
[41.91,27.10]
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
turnin Muigin and Larion##4141 |goto Un'Goro Crater 42.94,9.65
accept A Visit to Gregan##4142 |goto Un'Goro Crater 42.94,9.65
step
Follow the path up |goto Feralas 47.28,44.56 < 15 |only if walking
Follow the path |goto Feralas 48.66,44.98 < 15 |only if walking
Continue following the path |goto Feralas 47.87,36.21 < 15 |only if walking
Follow the path down |goto Feralas 48.22,32.73 < 15 |only if walking
Follow the path up |goto Feralas 45.70,25.74 < 15 |only if walking
talk Gregan Brewspewer##7775
turnin A Visit to Gregan##4142 |goto Feralas 45.12,25.56
accept Haze of Evil##4143 |goto Feralas 45.12,25.56
step
Run up the stairs |goto Swamp of Sorrows 69.31,57.06 < 10 |only if walking
Enter the Temple |goto Swamp of Sorrows 69.99,52.99 < 7
Run down the stairs |goto Swamp of Sorrows 69.58,51.44 < 7 |q 3528
step
Swim through the water |goto Swamp of Sorrows 70.22,51.69 < 7 |walk
Run up the stairs |goto Swamp of Sorrows 71.74,45.81 < 5 |walk
Run down the stairs |goto Swamp of Sorrows 72.70,42.22 < 5 |only if walking
Follow the path |goto Swamp of Sorrows 75.83,44.85 < 5 |only if walking
Continue following the path |goto Swamp of Sorrows 76.02,45.96 < 5 |q 3528
step
Follow the path |goto Swamp of Sorrows 56.89,75.91 < 5 |only if walking
click Atal'ai Tablet##37099+
|tip They look like silver stone tablets along the walls around this area.
collect 10 Atal'ai Tablet##6288 |q 1475/1 |goto Swamp of Sorrows 56.76,76.01
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
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 3528
stickystart "Collect_20_Fetish_of_Hakkar"
stickystart "Collect_5_Atal'ai_Haze"
step
Inside the Temple of Atal'Hakkar Dungeon:
|tip After entering the dungeon follow the left path and then go down the stairs to reach the Hall of Serpents.
|tip Run around the outside ring and clear each of the small inside rooms.
click Atal'ai Statue##148830+
|tip Click the serpent statues in the inside rooms in this order:
|tip South, north, southwest, southeast, northwest then finally the northeast altar.
|tip Atal'alarion will appear after clicking the statues in the correct order; jump down and kill him.
kill Atal'alarion##8580
click Altar of Hakkar
|tip At the top of the stairs in The Pit of Refuse.
turnin Into the Depths##3446
accept Secret of the Circle##3447
step
Inside the Temple of Atal'Hakkar Dungeon:
click Idol of Hakkar##148838
|tip In the center of the room in The Pit of Refuse.
turnin Secret of the Circle##3447
step
Inside the Temple of Atal'Hakkar Dungeon:
kill Jammal'an the Prophet##5710
|tip Follow the path up and out of The Pit of Refuse.
|tip Follow the left path again and go up three large sets of stairs, immediately go right to follow a short hallway and reach the upper level of The Pit of Sacrifice.
|tip There should be an elite enemy named Hukku channeling a spell on this balcony; kill him and then go back down the short hallway, but turn right and continue up the stairs to the Hall of the Cursed.
|tip Proceed around this room, following each set of stairs up or down to find additional balconies with named enemies channeling a spell.
|tip There are a total of six named elites that need to be killed in order to remove that barrier blocking the way to Jammal'an the Prophet.
|tip After all six balconies have been cleared, drop down from the final balcony into The Pit of Sacrifice.
|tip Follow the southeast path to reach Jammal'an the Prophet.
collect Head of Jammal'an##6212 |q 1446/1
step
Inside the Temple of Atal'Hakkar Dungeon:
kill Shade of Eranikus##5709
|tip Return to the main central room in The Pit of Sacrifice and follow the southern path.
collect Essence of Eranikus##10454 |q 3373 |future
step
Inside the Temple of Atal'Hakkar Dungeon:
use the Essence of Eranikus##10454
accept The Essence of Eranikus##3373
step
Inside the Temple of Atal'Hakkar Dungeon:
click Essence Font##148512
|tip It looks like a stone table in the northeastern corner of the room with the Shade of Eranikus.
turnin The Essence of Eranikus##3373
step
Inside the Temple of Atal'Hakkar Dungeon:
use the Egg of Hakkar##10465
|tip Use it next to the skeleton laying on the ground in the Sanctum of the Fallen God.
|tip Return to the main central room in The Pit of Sacrifice and follow the southwestern path to reach the Sanctum of the Fallen God.
Kill the enemies that spawn in waves
kill Hakkari Bloodkeeper##8438+
collect Hakkari Blood##10460 |n
|tip Use it to put out the braziers in each corner of the room.
click Eternal Flame##148420+
kill Avatar of Hakkar##8443
|tip It will spawn after the four Eternal Flames have been extinguished.
collect Essence of Hakkar##10663 |q 3528
step
Inside the Temple of Atal'Hakkar Dungeon:
use the Essence of Hakkar##10663
Fill the Egg of Hakkar |q 3528/1
step
label "Collect_20_Fetish_of_Hakkar"
Inside the Temple of Atal'Hakkar Dungeon: |notinsticky
Kill Atal'ai enemies around this area
collect 20 Fetish of Hakkar##6181 |q 1445/1
|tip These can also drop outside of the instance.
step
label "Collect_5_Atal'ai_Haze"
Inside the Temple of Atal'Hakkar Dungeon: |notinsticky
Kill enemies around this area
|tip Murk Worms, Deep Lurkers and Saturated Oozes specifically drop the quest item.
collect 5 Atal'ai Haze##11318 |q 4143/1
step
Leave the Temple of Atal'Hakkar
Click Here to Continue |confirm |q 3528
step
Enter the building |goto Stormwind City 68.93,42.08 < 8 |walk
talk Brohann Caskbelly##5384
|tip Inside the building.
turnin Into The Temple of Atal'Hakkar##1475 |goto Stormwind City 69.45,40.41
step
Follow the path |goto The Hinterlands 35.78,64.12 < 15 |only if walking
Run up the stairs |goto The Hinterlands 33.09,73.80 < 15 |only if walking
Jump down here |goto The Hinterlands 33.11,75.53 < 7 |only if walking
talk Atal'ai Exile##5598
turnin Jammal'an the Prophet##1446 |goto The Hinterlands 33.75,75.22
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
turnin Haze of Evil##4143 |goto Un'Goro Crater 42.94,9.65
step
talk Yeh'kinya##8579
turnin The God Hakkar##3528 |goto Tanaris 66.98,22.36
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackrock Depths Quests",{
image=ZGV.IMAGESDIR.."Blackrock Depths",
description="This guide will walk you through completing the Blackrock Depths Quests.",
},[[
step
Reach Level 52 |ding 52
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Tanaris 66.99,23.87 < 5 |walk
talk Yorba Screwspigot##9706
|tip Inside the building.
accept Yuka Screwspigot##4324 |goto Tanaris 67.04,24.01
step
Enter the building |goto Ironforge 44.12,50.01 < 8 |walk
talk Royal Historian Archesonus##8879
|tip Inside the building.
accept The Smoldering Ruins of Thaurissan##3702 |goto Ironforge 38.37,55.29
step
talk Royal Historian Archesonus##8879
|tip Inside the building.
Select _"I am ready to listen."_
Hear the Story of Thaurissan |q 3702/1 |goto Ironforge 38.37,55.29
step
talk Royal Historian Archesonus##8879
|tip Inside the building.
turnin The Smoldering Ruins of Thaurissan##3702 |goto Ironforge 38.37,55.29
accept The Smoldering Ruins of Thaurissan##3701 |goto Ironforge 38.37,55.29
step
talk Enohar Thunderbrew##9540
accept Ragnar Thunderbrew##4128 |goto Blasted Lands 63.64,20.63
step
talk Ragnar Thunderbrew##1267
turnin Ragnar Thunderbrew##4128 |goto Dun Morogh 46.83,52.36
accept Hurley Blackbreath##4126 |goto Dun Morogh 46.83,52.36
step
Follow the path up |goto Burning Steppes 82.76,63.28 < 10 |only if walking
talk Oralius##9177
accept The Good Stuff##4286 |goto Burning Steppes 84.56,68.69
step
talk Helendis Riverhorn##9562
accept Dragonkin Menace##4182 |goto Burning Steppes 85.82,68.94
step
talk Jalinda Sprig##9561
accept Overmaster Pyron##4262 |goto Burning Steppes 85.41,70.05
stickystart "Kill_Black_Wyrmkins"
stickystart "Kill_Black_Dragonspawns"
stickystart "Kill_Black_Broodlings"
step
kill Black Drake##7044 |q 4182/3 |goto Burning Steppes 86.33,30.69
|tip They look like red dragons flying low to the ground around this area.
|tip If you have trouble, try to find someone to help you.
|tip It's important to get this quest completed.
Also check around: |notinsticky
[89.89,37.22]
[89.50,56.92]
[81.84,58.36]
step
label "Kill_Black_Wyrmkins"
kill 4 Black Wyrmkin##7041 |q 4182/4 |goto Burning Steppes 84.25,27.76
|tip If you have trouble, try to find someone to help you.
|tip It's important to get this quest completed.
You can find more around: |notinsticky
[88.83,39.34]
[91.82,54.43]
step
label "Kill_Black_Dragonspawns"
kill 10 Black Dragonspawn##7040 |q 4182/2 |goto Burning Steppes 84.25,27.76
|tip If you have trouble, try to find someone to help you.
|tip It's important to get this quest completed.
You can find more around: |notinsticky
[88.83,39.34]
[91.82,54.43]
step
label "Kill_Black_Broodlings"
kill 15 Black Broodling##7047 |q 4182/1 |goto Burning Steppes 72.83,28.41
You can find more around: |notinsticky
[80.05,27.94]
[87.34,32.01]
[91.96,35.64]
[89.92,45.69]
[84.65,61.84]
step
click Thaurissan Relic##153556+
|tip They look like small rectangular stones on the ground around this area.
Recover #12# Pieces of Information |q 3701/1 |goto Burning Steppes 67.17,38.19
step
talk Helendis Riverhorn##9562
turnin Dragonkin Menace##4182 |goto Burning Steppes 85.82,68.95
accept The True Masters##4183 |goto Burning Steppes 85.82,68.95
step
Enter the building |goto Ironforge 44.12,50.01 < 7 |walk
talk Royal Historian Archesonus##8879
|tip Inside the building.
turnin The Smoldering Ruins of Thaurissan##3701 |goto Ironforge 38.37,55.29
step
talk King Magni Bronzebeard##2784
|tip Inside the building.
accept Kharan Mighthammer###4341 |goto Ironforge 39.12,56.18
step
Enter the building |goto Redridge Mountains 24.40,46.11 < 7 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4183 |goto Redridge Mountains 24.90,44.45
accept The True Masters##4184 |goto Redridge Mountains 24.90,44.45
step
Enter the building |goto Stormwind City 73.14,46.63 < 7 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4184 |goto Stormwind City 80.20,38.35
accept The True Masters##4185 |goto Stormwind City 80.20,38.35
step
talk Lady Katrana Prestor##1749
|tip Inside the building.
Select _"Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice."_
Seek Advice from Lady Prestor |q 4185/1 |goto Stormwind City 80.11,38.17
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4185 |goto Stormwind City 80.20,38.35
accept The True Masters##4186 |goto Stormwind City 80.20,38.35
step
Enter the building |goto Redridge Mountains 24.40,46.11 < 7 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4186 |goto Redridge Mountains 24.90,44.45
accept The True Masters##4223 |goto Redridge Mountains 24.90,44.45
step
Follow the path up |goto Burning Steppes 82.76,63.28 < 10 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4223 |goto Burning Steppes 84.75,69.02
accept The True Masters##4224 |goto Burning Steppes 84.75,69.02
step
talk Ragged John##9563
Select _"Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him."_
Listen to Ragged John's Story |q 4224/1 |goto Burning Steppes 65.01,23.76
step
Follow the path up |goto Burning Steppes 82.76,63.28 < 10 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4224 |goto Burning Steppes 84.74,69.01
accept Marshal Windsor##4241 |goto Burning Steppes 84.74,69.01
step
talk Kalaran Windblade##8479
accept Divine Retribution##3441 |goto Searing Gorge 39.05,38.99
step
talk Kalaran Windblade##8479
Select _"Tell me what drives this vengeance?"_
Listen to Kalaran's Story |q 3441/1 |goto Searing Gorge 39.05,38.99
step
talk Kalaran Windblade##8479
turnin Divine Retribution##3441 |goto Searing Gorge 39.05,38.99
accept The Flawless Flame##3442 |goto Searing Gorge 39.05,38.99
stickystart "Collect_Hearts_Of_Flame"
step
Kill enemies around this area
|tip Only Tempered War Golems, Heavy War Golems, and Magma Elementals will drop this quest item.
collect 4 Golem Oil##10511 |q 3442/2 |goto Searing Gorge 48.59,38.32
You can find more around: |notinsticky
[43.27,39.20]
[36.56,40.58]
[32.26,46.19]
[25.43,53.98]
[31.52,72.23]
step
label "Collect_Hearts_Of_Flame"
Kill Elemental enemies around this area
|tip Heavy War Golems will not drop this quest item.
collect 4 Heart of Flame##10509 |q 3442/1 |goto Searing Gorge 42.58,38.58
You can find more around: |notinsticky
[39.22,41.58]
[31.18,43.67]
[25.43,53.98]
[31.52,72.23]
step
talk Kalaran Windblade##8479
turnin The Flawless Flame##3442 |goto Searing Gorge 39.05,38.99
accept Forging the Shaft##3443 |goto Searing Gorge 39.05,38.99
step
Jump down here |goto Searing Gorge 49.32,43.74 < 15 |only if walking
Enter the cave |goto Searing Gorge 49.58,45.49 < 10 |walk
Cross the bridge |goto Searing Gorge 47.78,42.60 < 15 |walk
Follow the path |goto Searing Gorge 42.02,35.57 < 15 |walk
Kill Dark Iron enemies around this area
|tip Inside the cave, all throughout.
|tip You can also find some outside, near Thorium Point.
collect 8 Thorium Plated Dagger##10551 |q 3443/1 |goto Searing Gorge 43.38,34.94
step
Follow the path |goto Searing Gorge 50.59,38.45 < 15 |walk
Continue following the path |goto Searing Gorge 47.21,42.94 < 15 |walk
Leave the cave |goto Searing Gorge 47.53,46.72 < 15 |walk
Jump down carefully here |goto Searing Gorge 48.98,46.87 < 10 |only if walking
Follow the path up |goto Searing Gorge 58.08,41.10 < 15 |only if walking
Follow the path |goto Searing Gorge 65.38,34.61 < 30 |only if walking
talk Kalaran Windblade##8479
turnin Forging the Shaft##3443 |goto Searing Gorge 39.06,38.99
accept The Flame's Casing##3452 |goto Searing Gorge 39.06,38.99
step
Follow the path down |goto Searing Gorge 34.86,25.83 < 20 |only if walking
Follow the path |goto Searing Gorge 31.32,33.57 < 30 |only if walking
Kill Twilight enemies around this area
|tip They are elite enemies, you will likely need help with this.
|tip Try to find someone to help you.
|tip Doing this quest unlocks more quests that give easy experience, so it's important to get it done.
collect Symbol of Ragnaros##10552 |q 3452/1 |goto Searing Gorge 24.62,35.13
|tip This has a low drop rate.
You can find more inside the cave at [21.89,36.36]
You can find more up the path that starts at [24.23,33.12]
step
Follow the path |goto Searing Gorge 26.48,34.56 < 30 |only if walking
talk Kalaran Windblade##8479
turnin The Flame's Casing##3452 |goto Searing Gorge 39.05,38.99
accept The Torch of Retribution##3453 |goto Searing Gorge 39.05,38.99
step
Watch the dialogue
Witness the Creation of the Torch |q 3453/1 |goto Searing Gorge 39.05,38.99
step
talk Kalaran Windblade##8479
turnin The Torch of Retribution##3453 |goto Searing Gorge 39.05,38.99
accept The Torch of Retribution##3454 |goto Searing Gorge 39.05,38.99
step
click Torch of Retribution##149047
turnin The Torch of Retribution##3454 |goto Searing Gorge 39.06,39.06
step
talk Kalaran Windblade##8479
accept Squire Maltrake##3462 |goto Searing Gorge 39.05,39.00
step
talk Squire Maltrake##8509
turnin Squire Maltrake##3462 |goto Searing Gorge 39.16,38.99
accept Set Them Ablaze!##3463 |goto Searing Gorge 39.16,38.99
step
Follow the path |goto Searing Gorge 33.70,49.71 < 30 |only if walking
Run up the ramp |goto Searing Gorge 33.50,53.64 < 15 |only if walking
click Sentry Brazier##149032
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Northern Tower Ablaze |q 3463/4 |goto Searing Gorge 33.31,54.49
step
Run up the ramp |goto Searing Gorge 35.92,59.85 < 15 |only if walking
click Sentry Brazier##149025
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Western Tower Ablaze |q 3463/1 |goto Searing Gorge 35.67,60.68
step
Follow the path |goto Searing Gorge 35.00,72.13 < 30 |only if walking
Continue following the path |goto Searing Gorge 43.33,72.09 < 30 |only if walking
Run up the ramp |goto Searing Gorge 44.10,61.85 < 15 |only if walking
click Sentry Brazier##149030
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Southern Tower Ablaze |q 3463/2 |goto Searing Gorge 44.03,60.91
step
Cross the hanging bridge |goto Searing Gorge 52.48,57.95 < 15 |only if walking
Run up the ramp |goto Searing Gorge 50.19,55.61 < 15 |only if walking
click Sentry Brazier##149031
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Eastern Tower Ablaze |q 3463/3 |goto Searing Gorge 50.06,54.74
step
Follow the path |goto Searing Gorge 67.99,50.25 < 30 |only if walking
Continue following the path |goto Searing Gorge 66.79,34.56 < 30 |only if walking
talk Squire Maltrake##8509
turnin Set Them Ablaze!##3463 |goto Searing Gorge 39.17,39.00
step
Watch the dialogue
click Hoard of the Black Dragonflight##149502
accept Trinkets...##3481 |goto Searing Gorge 38.86,38.99
step
click Hoard of the Black Dragonflight##149502
turnin Trinkets...##3481 |goto Searing Gorge 38.86,38.99
|tip Save the Hoard of the Black Dragonflight for later.
step
talk Maxwort Uberglint##9536
accept The Heart of the Mountain##4123 |goto Burning Steppes 65.15,23.91
step
Enter the cave |goto Burning Steppes 65.65,22.68 < 7 |walk
talk Yuka Screwspigot##9544
|tip Inside the cave.
turnin Yuka Screwspigot##4324 |goto Burning Steppes 66.06,21.95
accept Ribbly Screwspigot##4136 |goto Burning Steppes 66.06,21.95
step
Enter the cave |goto Burning Steppes 94.43,31.86 < 7 |walk
talk Cyrus Therepentous##9459
|tip Inside the cave.
accept A Taste of Flame##4022 |goto Burning Steppes 95.07,31.56
step
use the Hoard of the Black Dragonflight##10569
collect Black Dragonflight Molt##10575 |q 4022/1
step
talk Cyrus Therepentous##9459
|tip Inside the cave.
turnin A Taste of Flame##4022 |goto Burning Steppes 95.07,31.56
accept A Taste of Flame##4024 |goto Burning Steppes 95.07,31.56
step
Enter Blackrock Mountain |goto Searing Gorge/0 34.80,85.37 < 7 |walk
Jump into the lava |complete isdead |goto Searing Gorge/0 34.62,95.45 |q 3801 |future
|tip You will need to be dead to talk to the next quest giver.
step
Enter Blackrock Mountain |goto Searing Gorge/0 34.80,85.37 < 7 |walk |zombiewalk
Jump into the lava |goto Searing Gorge/0 34.62,95.45 < 7 |only if walking |zombiewalk
Run up the chain |goto Searing Gorge/0 33.53,96.61 < 5 |only if walking |zombiewalk
Enter the building |goto Searing Gorge/0 36.06,98.76 < 5 |only if walking |zombiewalk
talk Franclorn Forgewright##8888
|tip You must be dead to talk to him.
accept Dark Iron Legacy##3801 |goto Searing Gorge/0 35.50,100.38 |zombiewalk
step
talk Franclorn Forgewright##8888
|tip You must be dead to talk to him.
turnin Dark Iron Legacy##3801 |goto Searing Gorge/0 35.50,100.38 |zombiewalk
accept Dark Iron Legacy##3802 |goto Searing Gorge/0 35.50,100.38 |zombiewalk
step
Run down the chain |goto Searing Gorge/0 34.30,98.02 < 5 |only if walking
Enter the building |goto Searing Gorge/0 32.54,94.96 < 5 |walk
kill Overmaster Pyron##9026 |q 4262/1 |goto Searing Gorge/0 26.36,77.69
|tip He patrols around this area.
|tip You may need help with this.
step
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c |q 4123
stickystart "Collect_Dark_Keeper_Key"
stickystart "Collect_Dark_Iron_Fanny_Packs"
step
Inside the Blackrock Depths Dungeon:
Kill Anvilrage dwarves at the beginning of the dungeon
|tip Just clear the first few rooms of the dungeon, killing all the Anvilrage dwarves and resetting the instance if needed, until you get the item drop.
collect A Crumpled Up Note##11446 |complete itemcount(11446) == 1 or haveq(4264) or completedq(4264)
step
Inside the Blackrock Depths Dungeon:
use A Crumpled Up Note##11446
accept A Crumpled Up Note##4264
step
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
|tip After entering the dungeon, go straight into the Detention Block and then take the first right.
|tip Follow this path around until you can go left into a room at the back of this long hallway.
collect Prison Cell Key##11140 |q 4341 |future
step
Inside the Blackrock Depths Dungeon:
click Cell Door
|tip Leave the room with High Interrogator Gerstahn and continue left through the tunnel.
|tip While in the tunnel, open the second interactable Cell Door on the right.
talk Kharan Mighthammer##9021
|tip Inside the cell.
turnin Kharan Mighthammer##4341
accept Kharan's Tale##4342
step
Inside the Blackrock Depths Dungeon:
talk Kharan Mighthammer##9021
|tip Inside the cell.
Select _"All is not lost, Kharan!"_
Hear Kharan's Tale |q 4342/1
step
Inside the Blackrock Depths Dungeon:
talk Kharan Mighthammer##9021
|tip Inside the cell.
turnin Kharan's Tale##4342
accept The Bearer of Bad News##4361
step
Inside the Blackrock Depths Dungeon:
click Cell Door
|tip Leave the cell that was holding Kharan Mighthammer.
|tip Stick to the left wall.
|tip Open the door two cells down to gain access to Marshal Windsor.
talk Marshal Windsor##9023
|tip Inside the cell.
turnin Marshal Windsor##4241
turnin A Crumpled Up Note##4264
accept Abandoned Hope##4242
accept A Shred of Hope##4282
step
Inside the Blackrock Depths Dungeon:
kill Fineous Darkvire##9056
|tip Leave the tunnel and head east through the Detention Block and then turn left after reaching the Halls of the Law to start the Ring of the Law event.
|tip Complete the event and then exit through the west gate to enter the Eastern Garrison, immediately take a sharp right and go up the stairs to reach the upper level of the arena.
|tip Follow the path around the arena and go down the ramp on the other side, go left and across the bridge to The Domicile.
|tip Continue down the ramps in The Domicile to enter Shadowforge City, take the second door on the right to enter the Hall of Crafting.
|tip Fight down to the lower level of the Hall of Crafting.
|tip Fineous walks around this area.
collect Ironfel##10999 |q 3802/1
step
Inside the Blackrock Depths Dungeon:
click Monument of Franclorn Forgewright##164689
|tip Retrace your steps back through the Hall of Crafting, Shadowforge City and The Domicile to cross the bridge and reach the Shrine of Thaurissan.
|tip Continue straight until you reach the deadend with the Monument of Franclorn Forgewright sitting against the far wall.
turnin Dark Iron Legacy##3802
step
Inside the Blackrock Depths Dungeon:
kill Bael'Gar##9016
|tip Turn around and cross the bridge in Shadowforge City to once again reach The Domicile.
|tip Follow the same path as before to reach the Hall of Crafting where you killed Fineous Darkvire.
|tip Continue down through the Hall of Crafting's lower level to reach the boss Lord Incendius.
|tip Defeat him and keep going to reach the Dark Iron Highway.
|tip Bael'Gar is at the very end of the Dark Iron Highway.
use the Altered Black Dragonflight Molt##11231
|tip Use it on Bael'Gars corpse.
collect Encased Fiery Essence##11230 |q 4024/1
step
Inside the Blackrock Depths Dungeon:
kill General Angerforge##9033
|tip Run back down the Dark Iron Highway, take the first right and unlock the gate on your left.
|tip Unlock the first door on your left to enter East Garrison.
|tip In the lower part of this room, click the Shadowforge Lock, then run up the two sets of stairs and follow the hallway on the left just before the third set of stairs.
|tip Follow the path through the hallway to reach the West Garrison.
|tip When you reach a room with stairs on your left, go down them to find General Angerforge.
collect Marshal Windsor's Lost Information##11464 |q 4282/1
step
Inside the Blackrock Depths Dungeon:
kill Golem Lord Argelmach##8983
|tip Go back up the stairs next to General Angerforge and continue north to reach The Manufactory and Golem Lord Argelmach.
collect Marshal Windsor's Lost Information##11465 |q 4282/2
step
Inside the Blackrock Depths Dungeon:
talk Mistress Nagmara##9500
|tip Turn around to leave The Manufactory, but go left instead and follow the path to reach The Grim Guzzler.
|tip She walks around the Grim Guzzler.
accept The Love Potion##4201
step
Inside the Blackrock Depths Dungeon:
talk Ribbly Screwspigot##9543
|tip He's at the bottom level of the Grim Guzzler.
Select _"Your family says hello, Ribbly. And they want your head!"_
kill Ribbly Screwspigot##9543
collect Ribbly's Head##11313 |q 4136/1
step
Inside the Blackrock Depths Dungeon:
click Thunderbrew Lager Keg##164911+
|tip They look like wooden kegs sitting in a side room in the lower section of The Grim Guzzler.
|tip Destroy all three kegs to spawn Hurley Blackbreath.
kill Hurley Blackbreath##9537
collect Lost Thunderbrew Recipe##11312 |q 4126/1
step
label "Collect_Dark_Keeper_Key"
Inside the Blackrock Depths Dungeon: |notinsticky
Kill enemies around this area
collect 12 Relic Coffer Key##11078 |q 4123 |future
step
Inside the Blackrock Depths Dungeon:
click Relic Coffer Door
|tip Open all 12 of them inside of the Black Vault after clearing the room.
|tip Proceed back through The Domicile to reach the Shadowforge City, then take the first door on the right to enter The Black Vault.
kill Watchman Doomgrip##9476
|tip He will spawn once all 12 Relic Coffer Doors have been opened.
click Heart of the Mountain##165554
|tip It looks like a small red crystal sitting on a purple pillow against the wall underneath the Dark Coffer.
collect The Heart of the Mountain##11309 |q 4123/1
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin A Shred of Hope##4282
|tip Make sure everyone turns this quest in before anyone accepts the next one.
|tip Accepting Jail Break! will start the escort quest and other party members will not be able to interact with Marshal Windsor.
accept Jail Break!##4322
|tip He will walk around the Detention Block and Halls of the Law, so clearing these beforehand can be helpful.
step
Inside the Blackrock Depths Dungeon:
Follow and protect Marshal Windsor
|tip He will walk around the Detention Block and Halls of the Law, so clearing these beforehand can be helpful.
|tip There will be a few cells he will have you open. Sometimes you'll have to fight the prisoners or talk to a friendly NPC to free them.
|tip Eventually he will walk back to the dungeon entrance and escape.
Help Marshal Windsor Escape the Blackrock Depths |q 4322/1
step
label "Collect_Dark_Iron_Fanny_Packs"
Inside the Blackrock Depths Dungeon: |notinsticky
Kill enemies around this area
|tip Dwarf enemies drop these.
collect 20 Dark Iron Fanny Pack##11468 |q 4286/1
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm |q 4123
step
Follow the path up |goto Burning Steppes 82.76,63.28 < 10 |only if walking
talk Marshal Maxwell##9560
turnin Jail Break!##4322 |goto Burning Steppes 84.75,69.02
turnin Abandoned Hope##4242 |goto Burning Steppes 84.74,69.02
step
talk Oralius##9177
turnin The Good Stuff##4286 |goto Burning Steppes 84.56,68.69
step
talk Jalinda Sprig##9561
turnin Overmaster Pyron##4262 |goto Burning Steppes 85.41,70.06
accept Incendius!##4263 |goto Burning Steppes 85.41,70.06
step
Enter the building |goto Ironforge 44.12,50.01 < 8 |walk
talk King Magni Bronzebeard##2784
|tip Inside the building.
turnin The Bearer of Bad News##4361 |goto Ironforge 39.10,56.22
accept The Fate of the Kingdom##4362 |goto Ironforge 39.10,56.22
step
talk Ragnar Thunderbrew##1267
turnin Hurley Blackbreath##4126 |goto Dun Morogh 46.83,52.36
step
talk Maxwort Uberglint##9536
turnin The Heart of the Mountain##4123 |goto Burning Steppes 65.15,23.91
step
Enter the cave |goto Burning Steppes 65.65,22.68 < 7 |walk
talk Yuka Screwspigot##9544
|tip Inside the cave.
turnin Ribbly Screwspigot##4136 |goto Burning Steppes 66.06,21.95
step
Enter the cave |goto Burning Steppes 94.43,31.86 < 7 |walk
talk Cyrus Therepentous##9459
|tip Inside the cave.
turnin A Taste of Flame##4024 |goto Burning Steppes 95.07,31.56
step
collect 4 Gromsblood##8846 |q 4201/1
|tip These are gathered with the Herbalism Profession.
|tip Load the "Gromsblood Farming Guide" to accomplish this.
|tip You can also buy these from the Auction House.
step
Kill Cliff enemies around this area
|tip These are elite.
|tip You may need help.
collect 10 Giant Silver Vein##11405 |q 4201/2 |goto Azshara 44.81,85.43
You Can Find More At These Locations:
[48.72,87.54]
[52.63,85.45]
[58.25,89.50]
[60.45,89.81]
[59.12,83.27]
[52.13,78.62]
step
Follow the path up |goto Un'Goro Crater 31.19,51.48 < 10 |only if walking
use Nagmara's Vial##11412
|tip You must be in the water.
collect Nagmara's Filled Vial##11413 |q 4201/3 |goto Un'Goro Crater 31.99,50.01
step
Continue down and run down the chain |goto Un'Goro Crater 34.86,99.20 < 5 |walk
Enter the building |goto Un'Goro Crater 32.55,94.94 < 5 |walk
Follow the path |goto Un'Goro Crater 26.88,83.87 < 30 |walk
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c |q 4363 |future
step
Inside the Blackrock Depths Dungeon:
kill Lord Incendius##9017 |q 4263/1
|tip After entering the dungeon, go left through the Shadowforge Gate and head north to reach the Dark Iron Highway.
|tip Continue east through the Dark Iron Highway to reach the Shadowforge City and Lord Incendius.
step
Inside the Blackrock Depths Dungeon:
talk Mistress Nagmara##9500
|tip She walks around The Grim Guzzler.
|tip Go back through the Dark Iron Highway and go left to enter the Detention Block.
|tip Go through the Shadowforge Gate and then through the East Garrison Door.
|tip In the lower part of this room, click the Shadowforge Lock, then run up the two sets of stairs and follow the hallway on the left just before the third set of stairs.
|tip Follow the path through the hallway to reach the West Garrison, then go right and down the ramp to reach The Manufactory.
|tip Take another right and follow the path to reach The Grim Guzzler.
turnin The Love Potion##4201
step
Inside the Blackrock Depths Dungeon:
kill Emperor Dagran Thaurissan##9019
|tip Don't kill Princess Moira Bronzebeard during the encounter.
|tip Interrupt her heals otherwise the encounter will be complicated.
|tip You will not be able to turn in the quest if you kill her.
|tip Leave The Grim Guzzler through the northeast door that is now open, go through the door on your first left and down the ramps.
|tip Go left again through the Chamber of Enchantment and north through the Mold Foundry.
|tip Continue through the Summoners' Tomb to reach The Lyceum.
|tip Kill the Shadowforge Flame Keepers in the center of the room and use the Shadowforge Torches that they drop to light the Shadowforge Braziers in the east side of the room in order to proceed.
|tip Proceed east through The Iron Hall, defeat Magmus and then finally enter The Imperial Seat.
Slay Emperor Dagran Thaurissan |q 4362/1
step
Inside the Blackrock Depths Dungeon:
talk Princess Moira Bronzebeard##8929
|tip She is in the room where Emperor Dagran Thaurissan was.
turnin The Fate of the Kingdom##4362
accept The Princess's Surprise##4363
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm |q 4363
step
Follow the path up |goto Burning Steppes 82.76,63.28 < 10 |only if walking
talk Jalinda Sprig##9561
turnin Incendius!##4263 |goto Burning Steppes 85.41,70.06
step
Enter the building |goto Ironforge 44.12,50.01 < 7 |walk
talk King Magni Bronzebeard##2784
|tip Inside the building.
turnin The Princess's Surprise##4363 |goto Ironforge 39.10,56.22
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul East Quests",{
image=ZGV.IMAGESDIR.."Dire Maul",
description="This guide will walk you through completing the Dire Maul East Quests.",
},[[
step
Reach Level 56 |ding 56
|tip Use the Leveling guides to accomplish this.
step
talk Rabine Saturna##11801
|tip Inside the building.
accept A Reliquary of Purity##5527 |goto Moonglade 51.69,45.10
step
click Dusty Reliquary##179565
|tip Inside the building.
collect Reliquary of Purity##22201 |goto Silithus 63.23,55.36 |q 5527
step
talk Rabine Saturna##11801
|tip Inside the building.
turnin A Reliquary of Purity##5527 |goto Moonglade 51.69,45.10
accept Shards of the Felvine##5526 |goto Moonglade 51.69,45.10
step
talk Latronicus Moonspear##7877
accept Lethtendris's Web##7488 |goto Feralas 30.38,46.18
step
talk Azj'Tordin##14355
|tip On top of the platform.
accept Pusillin and the Elder Azj'Tordin##7441 |goto Feralas 76.91,37.35
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
Continue following the path |goto Feralas/0 64.85,30.18 < 7 |only if walking
Enter the Dire Maul - East Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 5526
step
Inside the Dire Maul East Dungeon:
talk Pusillin##14354
|tip He's in the northwest part of the Warpwood Quarter.
Select _"Game? Are you crazy?"_
|tip He will run off after speaking to him.
|tip If you don't do this, he will not be killable later.
Click Here to Continue |confirm |q 7441
step
Inside the Dire Maul East Dungeon:
talk Pusillin##14354
|tip He's in the southern part of the Warpwood Quarter, near the dungeon entrance.
Select _"Why you little..."_
|tip He will run off after speaking to him.
|tip If you don't do this, he will not be killable later.
Click Here to Continue |confirm |q 7441
step
Inside the Dire Maul East Dungeon:
talk Pusillin##14354
|tip He's in the northeastern part of the Warpwood Quarter.
Select _"Mark my words, I will catch you, Imp. And when I do!"_
|tip He will run off after speaking to him.
|tip If you don't do this, he will not be killable later.
Click Here to Continue |confirm |q 7441
step
Inside the Dire Maul East Dungeon:
talk Pusillin##14354
|tip Follow the northeastern path from the Warpwood Quarter to reach The Hidden Reach.
|tip Continue east down the path through The Hidden Reach to find him.
Select _"DIE!"_
|tip He will be in the Hidden Reach, straight through the tunnel.
|tip He will run off after speaking to him.
|tip If you don't do this, he will not be killable later.
Click Here to Continue |confirm |q 7441
step
Inside the Dire Maul East Dungeon:
talk Pusillin##14354
|tip Continue southeast and run up the ramp to the small upper platform.
Select _"Prepare to meet your maker."_
kill Pusillin##14354
collect Book of Incantations##18261 |q 7441/1
collect Crescent Key##18249 |q 7463 |future |only if Mage
step
Inside the Dire Maul East Dungeon:
kill Lethtendris##14327
|tip After killing Pusillin go west up the ramps back the way you came through The Hidden Reach.
|tip After going up the ramps and before reentering the Warpwood Quarter, enter the left room.
|tip Go south in this room and then run up the large ramp to reach the upper level to find Lethtendris.
collect Lethtendris's Web##18426 |q 7488/1
step
Inside the Dire Maul East Dungeon:
kill Zevrim Thornhoof##11490
|tip This boss must be defeated to gain access to the last boss, Alzzin the Wildshaper.
|tip After killing Lethtendris follow the southeastern path down the spiral ramp.
|tip Once in the next room go north and follow the ramp up.
Click Here to Continue |confirm |q 5526
step
Inside the Dire Maul East Dungeon:
|tip After killing Zevrim Thornhoof jump off the west side of the platform.
|tip Follow the path in the southwestern part of the room to reach The Conservatory.
|tip Go north through The Conservatory to find Ironbark the Redeemed.
talk Ironbark the Redeemed##14241
|tip He walks around this area.
Select _"Thank you Ironbark. We are ready for you to open the door."_
Click Here to Continue |confirm |q 5526
step
Inside the Dire Maul East Dungeon:
kill Alzzin the Wildshaper##11492
|tip After talking to Ironbark the Redeemed, continue north through The Conservatory.
click Felvine Shard##179559
|tip It looks like a small glowing red object sitting on the ground next to a twisted vine plant next to the boss.
collect Felvine Shard##18501 |q 5526
step
use the Reliquary of Purity##18539
|tip Use it next to the twisted vine plant next to the boss.
Seal the Reliquary of Purity |q 5526/1
step
Leave the Dire Maul East Dungeon
Click Here to Continue |confirm |q 5526
step
talk Latronicus Moonspear##7877
turnin Lethtendris's Web##7488 |goto Feralas 30.38,46.18
step
talk Azj'Tordin##14355
|tip On top of the platform.
turnin Pusillin and the Elder Azj'Tordin##7441 |goto Feralas 76.91,37.35
step
talk Rabine Saturna##11801
|tip Inside the building.
turnin Shards of the Felvine##5526 |goto Moonglade 51.69,45.10
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul West Quests",{
image=ZGV.IMAGESDIR.."Dire Maul",
description="This guide will walk you through completing the Dire Maul West Quests.",
},[[
step
Reach Level 56 |ding 56
|tip Use the Leveling guides to accomplish this.
step
kill Pusillin##14354
|tip He is the first boss in the Dire Maul East dungeon.
|tip Use the Dire Maul East dungeon guide to accomplish this.
collect Crescent Key##18249 |q 7462 |future
|tip This item is required to enter Dire Maul West.
|tip If someone else in the group has it you can skip this step.
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 60.32,30.16 < 10 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - West Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 7462 |future
step
Inside the Dire Maul West Dungeon:
Clear the First Pylon
|tip Head west a short distance in Capital Gardens and kill the enemies around the large glowing blue pylon.
|tip Kill the Arcane Aberrations and Mana Remnant.
|tip This pylon must be deactivated in order to fight Immol'thar.
Click Here to Continue |confirm |q 7462 |future
step
Inside the Dire Maul West Dungeon:
Clear the Second Pylon
|tip Pass through the archways in the northwest part of Capital Gardens to enter the Court of the Highborne.
|tip Go through the archway on the northern side of the Court of the Highborne and then go up the ramp.
|tip Proceed east to the pylon.
|tip Kill the Arcane Aberrations and Mana Remnant.
|tip This pylon must be deactivated in order to fight Immol'thar.
Click Here to Continue |confirm |q 7462 |future
step
Inside the Dire Maul West Dungeon:
talk Shen'dralar Ancient##14358
|tip She is above the platform overseeing Tendris Warpwood.
|tip Head south from the second pylon to reach the Shen'dralar Ancient.
accept The Madness Within##7461
step
Inside the Dire Maul West Dungeon:
Clear the Third Pylon
|tip Follow the path south and west.
|tip Kill the Arcane Aberrations and Mana Remnant.
|tip This pylon must be deactivated in order to fight Immol'thar.
Click Here to Continue |confirm |q 7462 |future
step
Inside the Dire Maul West Dungeon:
click Door
|tip The door is behind Tendris Warpwood.
|tip Jump down to the lower level of the Court of the Highborne.
|tip You will need the Crescent Key from Dire Maul East or a Rogue to open this.
|tip Follow the path to reach the Prison of Immol'thar.
Click Here to Continue |confirm |q 7462 |future
step
Inside the Dire Maul West Dungeon:
kill Immol'thar##11496
|tip Clear the remaining two pylons in this room in order to engage him.
Slay Immol'thar |q 7461/1
step
Inside the Dire Maul West Dungeon:
click Door
|tip Follow the tunnel in the northeastern part of the Prison of Immol'thar.
|tip You will need the Crescent Key from Dire Maul East or a Rogue to open this.
Click Here to Continue |confirm |q 7462 |future
step
Inside the Dire Maul West Dungeon:
kill Prince Tortheldrin##11486
|tip Once inside The Athenaeum, jump down.
|tip He is underneath the platform that you are on after entering the room.
Slay Prince Tortheldrin |q 7461/2
step
Inside the Dire Maul West Dungeon:
talk Shen'dralar Ancient##14358
|tip She is above the platform overseeing Tendris Warpwood.
|tip Go back up the ramp in The Athenaeum, and east through the Prison of Immol'thar.
|tip Go up the ramp in the Court of the Highborne, then north and up a second ramp, then follow the path east and south to reach her.
turnin The Madness Within##7461
accept The Treasure of the Shen'dralar##7462
step
Inside the Dire Maul West Dungeon:
click Treasure of the Shen'dralar
|tip It looks like a large stone chest underneath the ramp in The Athenaeum.
|tip Go back through the Prison of Immol'thar and reenter The Athenaeum.
turnin The Treasure of the Shen'dralar##7462
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Dire Maul North Quests",{
image=ZGV.IMAGESDIR.."Dire Maul",
description="This guide will walk you through completing the Dire Maul North Quests.",
},[[
step
Reach Level 56 |ding 56
|tip Use the Leveling guides to accomplish this.
step
collect 4 Bolt of Runecloth##14048 |q 5518 |future
|tip You can have a Tailor make these with 20 Runecloth.
|tip You can also purchase these from the auction house.
step
collect 8 Rugged Leather##8170 |q 5518 |future
|tip Use the Rugged Leather farming guide to accomplish this.
|tip You can also purchase these from the Auction House.
step
Enter the building |goto Stormwind City 54.11,81.63 < 5 |walk
talk Alexandra Bolero##1347
|tip Inside the building.
buy 2 Rune Thread##14341 |goto Stormwind City 53.14,81.76 |q 5518 |future
step
talk Scholar Runethorn##14374
|tip She patrols along the road.
accept Elven Legends##7482 |goto Feralas 31.09,44.10
step
kill Pusillin##14354
|tip He is the first boss in the Dire Maul East dungeon.
|tip Use the Dire Maul East dungeon guide to accomplish this.
collect Crescent Key##18249 |q 7482
|tip This item is required to enter Dire Maul West.
|tip If someone else in the group has it you can skip this step.
step
Run up the ramp |goto Feralas/0 59.13,44.67 < 20 |only if walking
Follow the path |goto Feralas/0 59.52,39.51 < 15 |only if walking
Continue following the path |goto Feralas/0 61.72,38.78 < 15 |only if walking
Continue following the path |goto Feralas/0 61.15,34.87 < 7 |only if walking
click Door |goto Feralas/0 62.49,24.89 < 5 |walk
|tip You need a Crescent Key to unlock this door.
|tip This drops from Pusillin in the "Dire Maul - East" dungeon.
Enter the Dire Maul - North Dungeon with Your Group |goto Dire Maul/0 0.00,0.00 < 500 |c |q 7482
step
Inside the Dire Maul North Dungeon:
click Conservatory Door
|tip Jump down into the courtyard.
|tip Once there, head west down a ramp with the Conservatory Door.
|tip Run through the tunnel to reach The Athenaeum.
|tip You will need the Crescent Key from Dire Maul East or a Rogue to open this.
click Skeletal Remains of Kariel Winthalus##179544
|tip On the ground next to an elf and a bookcase in the north part of the room.
Find the Skeletal Remains of Master Kariel Winthalus |q 7482/1
step
Inside the Dire Maul North Dungeon:
click Fengus's Chest##179516
|tip It looks like a brown and black chest in the middle of the courtyard.
|tip Leave The Athenaeum and go back through the long tunnel to return to Dire Maul North.
|tip Head west into the second large open room.
collect Gordok Courtyard Key##18266 |q 7482
step
Inside the Dire Maul North Dungeon:
click Gordok Courtyard Door
|tip It is on the western side of the room.
Click Here to Continue |confirm |q 7482
step
Inside the Dire Maul North Dungeon:
talk Knot Thimblejack##14338
|tip Follow the tunnel to reach the Halls of Destruction.
|tip He is in the northeast corner of the Halls of Destruction.
accept The Gordok Ogre Suit##5518
step
Inside the Dire Maul North Dungeon:
click Ogre Tannin Basket##179499
|tip It is up the ramp just above where Knot Thimblejack is, in the northwest corner of the room.
|tip Only one person in your group will be able to collect this.
collect Ogre Tannin##18240 |q 5518/4
step
Inside the Dire Maul North Dungeon:
talk Knot Thimblejack##14338
|tip He is in the northeast corner of the Halls of Destruction.
turnin The Gordok Ogre Suit##5518
step
Inside the Dire Maul North Dungeon:
Kill Guard enemies around this area
|tip Guard Mol'dar, Slip'kik, Fengus and Captain Kromcrush can drop the key.
|tip The guards can be found in the Halls of Destruction and in each of the large open rooms at the beginning of the dungeon.
|tip Captain Kromcrush is found in Gordok's Seat, which is reached by going through the upper level of the Halls of Destruction.
|tip It also has a small chance to drop from Gordok trash mobs throughout the dungeon.
collect Gordok Shackle Key##18250 |q 5525 |future
step
Inside the Dire Maul North Dungeon:
talk Knot Thimblejack##14338
|tip He is in the northeast corner of the Halls of Destruction.
turnin Free Knot!##7429
step
Inside the Dire Maul North Dungeon:
talk Stomper Kreeg##14322
|tip You will only be able to speak with him after a tribute run.
|tip Use the Dire Maul North Tribute dungeon guide to accomplish this.
accept The Gordok Taste Test##5528
step
Inside the Dire Maul North Dungeon:
talk Captain Kromcrush##14325
|tip To do this, you will need to do a tribute run.
|tip Use the Dire Maul North Tribute dungeon guide to accomplish this.
accept Unfinished Gordok Business##7703
step
Inside the Dire Maul West Dungeon:
click The Prince's Chest##179545
|tip Run back to the start of the instance and enter the Library through the courtyard door.
|tip The chest will be behind where he stands.
collect Gauntlet of Gordok Might##18336 |q 7703/1
step
Inside the Dire Maul North Dungeon:
talk Captain Kromcrush##14325
|tip To do this, you will need to do a tribute run.
|tip You may need to run another Tribute Run to accomplish this.
turnin Unfinished Gordok Business##7703
step
Leave the Dire Maul North Dungeon
Click Here to Continue |confirm |q 7482
step
talk Scholar Runethorn##14374
|tip She patrols along the road.
turnin Elven Legends##7482 |goto Feralas 31.09,44.10
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Lower Blackrock Spire Quests",{
image=ZGV.IMAGESDIR.."Lower Blackrock Spire",
description="This guide will walk you through completing the Lower Blackrock Spire Quests.",
},[[
step
Reach Level 57 |ding 57
|tip Use the Leveling guides to accomplish this.
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.98,22.36
step
kill Vale Screecher##5307
|tip These have a low spawn rate.
use Yeh'Kinya's Bramble##10699
|tip Use it on their corpse.
talk Screecher Spirit##8612
collect 3 Screecher Spirits |q 3520/1 |goto Feralas 58.31,57.70
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.98,22.36
accept The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
Enter the Zul'Farrak Dungeon with Your Group |goto Zul'Farrak/0 0.00,0.00 < 555 |c |q 3527
step
Inside the Zul'Farrak Dungeon:
kill Theka the Martyr##7272
|tip He is the second boss of the dungeon.
|tip Follow the path north and then go right when the path splits.
|tip Quickly go left afterwards and then north.
collect First Mosh'aru Tablet##10660 |q 3527/1
step
Inside the Zul'Farrak Dungeon:
kill Hydromancer Velratha##7795
|tip Continue following the path west to reach the room with a large pyramid on the western side.
|tip Follow the path southeast to reach the large room with a pool in the center.
|tip She walks around this area.
collect Second Mosh'aru Tablet##10661 |q 3527/2
step
Leave the Zul'Farrak Dungeon
Click Here to Continue |confirm |q 3527
step
talk Yeh'kinya##8579
turnin The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
accept The Ancient Egg##4787 |goto Tanaris 66.98,22.36
step
Follow the path |goto The Hinterlands 35.79,64.07 < 15 |only if walking
Run up the stairs |goto The Hinterlands 66.70,66.71 < 8 |only if walking
Follow the path |goto The Hinterlands 66.63,68.83 < 10 |only if walking
Run up the stairs |goto The Hinterlands 67.93,69.12 < 10 |only if walking
Follow the path |goto The Hinterlands 67.78,70.73 < 10 |q 4787 |future
step
Run up the stairs |goto The Hinterlands 65.08,68.94 < 8 |only if walking
Follow the path |goto The Hinterlands 63.69,70.44 < 10 |only if walking
Continue following the path |goto The Hinterlands 65.38,72.92 < 10 |only if walking
Run up the stairs |goto The Hinterlands 67.14,73.37 < 8 |only if walking
Follow the path |goto The Hinterlands 67.15,75.46 < 10 |q 4787 |future
step
Follow the path |goto The Hinterlands 64.52,74.83 < 10 |only if walking
Run up the stairs |goto The Hinterlands 62.16,71.38 < 10 |only if walking
Continue up the stairs |goto The Hinterlands 59.96,70.17 < 10 |only if walking
Follow the path |goto The Hinterlands 58.68,70.28 < 10 |only if walking
Continue following the path |goto The Hinterlands 59.15,74.30 < 10 |q 4787 |future
step
Enter the cave |goto The Hinterlands 58.61,79.19 < 10 |walk
Follow the path down |goto The Hinterlands 58.26,82.31 < 10 |walk
Follow the path up |goto The Hinterlands 54.81,83.42 < 10 |walk
click Ancient Egg##175889
|tip Inside the cave.
|tip You may need help with this.
collect Ancient Egg##12402 |q 4787/1 |goto The Hinterlands 57.52,86.78
step
talk Yeh'kinya##8579
turnin The Ancient Egg##4787 |goto Tanaris 66.98,22.36
accept The God Hakkar##3528 |goto Tanaris 66.98,22.36
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
Enter The Temple of Atal'Hakkar Dungeon with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 3528
step
Inside the Temple of Atal'Hakkar Dungeon:
use the Egg of Hakkar##10465
|tip Use it next to the skeleton laying on the ground in the Sanctum of the Fallen God.
|tip After entering the dungeon, follow the left path and go up three large sets of stairs, immediately go right to follow a short hallway to reach the upper level of The Pit of Sacrifice and jump down.
|tip Follow the southwestern path to reach the Sanctum of the Fallen God.
Kill the enemies that spawn in waves
kill Hakkari Bloodkeeper##8438+
collect Hakkari Blood##10460 |n
|tip Use it to put out the braziers in each corner of the room.
click Eternal Flame##148420+
kill Avatar of Hakkar##8443
|tip It will spawn after the four Eternal Flames have been extinguished.
collect Essence of Hakkar##10663 |q 3528
step
Inside the Temple of Atal'Hakkar Dungeon:
use the Essence of Hakkar##10663
Fill the Egg of Hakkar |q 3528/1
step
Leave the Temple of Atal'Hakkar Dungeon
Click Here to Continue |confirm |q 3528
step
talk Yeh'kinya##8579
turnin The God Hakkar##3528 |goto Tanaris 66.98,22.36
step
talk Prospector Ironboot##10460
accept The Lost Tablets of Mosh'aru##5065 |goto Tanaris 66.89,24.03
step
Follow the path up |goto Eastern Plaguelands 56.27,15.93 < 10 |only if walking
click Fourth Mosh'aru Tablet##175488
collect Fourth Mosh'aru Tablet |q 5065/2 |goto Eastern Plaguelands 63.74,10.23
step
click Third Mosh'aru Tablet##175487
|tip At the top of the temple.
collect Third Mosh'aru Tablet |q 5065/1 |goto Eastern Plaguelands 63.45,7.85
step
talk Prospector Ironboot##10460
turnin The Lost Tablets of Mosh'aru##5065 |goto Tanaris 66.89,24.03
accept The Final Tablets##4788 |goto Tanaris 66.89,24.03
step
talk Helendis Riverhorn##9562
accept Put Her Down##4701 |goto Burning Steppes 85.82,68.94
step
talk Ragged John##9563
accept Mother's Milk##4866 |goto Burning Steppes 65.01,23.77
step
talk Kibler##10260
|tip Inside the cave.
accept Kibler's Exotic Pets##4729 |goto Burning Steppes 65.88,21.92
accept En-Ay-Es-Tee-Why##4862 |goto Burning Steppes 65.88,21.92
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 5002 |future
stickystart "Collect_Unadorned_Seal_of_Ascension"
step
Inside the Lower Blackrock Spire Dungeon:
talk Warosh##10799
|tip He patrols around Hordemar City.
|tip After entering the dungeon, follow the path right in the Hall of Blackhand to reach Hordemar City.
accept Urok Doomhowl##4867
step
Inside the Lower Blackrock Spire Dungeon:
click Roughshod Pike##175886
|tip It is standing upright in a wooden weapon rack along the left wall after crossing the second bridge in Hordemar City.
collect Roughshod Pike##12533 |q 4867 |future
|tip If someone else in your group looted it you can skip this step.
step
Inside the Lower Blackrock Spire Dungeon:
talk Bijou##10257
|tip Once you pass the second bridge, jump into the groove in the ground.
|tip Bijou will be down there.
accept Bijou's Belongings##5001
step
Inside the Lower Blackrock Spire Dungeon:
click Bijou's Belongings##175334
|tip It looks like a small wooden and metal chest on the lowest level of Hordemar City.
|tip It can be found anywhere from Hordemar to the Skitterweb Tunnels.
collect Bijou's Belongings##12345 |q 5001/1
step
Inside the Lower Blackrock Spire Dungeon:
talk Bijou##10257
|tip Bijou will be down in a groove at Hordemar City.
turnin Bijou's Belongings##5001
accept Message to Maxwell##5002
step
Leave the Blackrock Spire Dungeon
Click Here to Continue |confirm |q 5002
stickystop "Collect_Unadorned_Seal_of_Ascension"
step
Follow the path up |goto Burning Steppes 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Message to Maxwell##5002 |goto Burning Steppes 84.75,69.02
accept Maxwell's Mission##5081 |goto Burning Steppes 84.75,69.02
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 4788
step
label "Collect_Unadorned_Seal_of_Ascension"
Inside the Lower Blackrock Spire Dungeon: |notinsticky
Kill enemies around this area
collect Unadorned Seal of Ascension##12219 |q 4742 |future
step
Inside the Lower Blackrock Spire Dungeon:
talk Vaelan##10296
|tip Run up the ramp near where you entered Lower Blackrock Spire.
|tip A little way closer to the entrance of the dungeon, just before the area where Warosh patrols.
Watch the Dialogue
Select _"As you wish, Vaelan."_
accept Seal of Ascension##4742
step
Inside the Lower Blackrock Spire Dungeon:
click Fifth Mosh'aru Tablet##175949
|tip Cross the two bridges into Hordemar City, then jump down to where Bijou is.
|tip Run down the ramp, then back up directly across.
|tip Run up the stairs to the left.
|tip On the far side of the wall in the room with Shadow Hunter Vosh'gajin.
collect Fifth Mosh'aru Tablet##12740 |q 4788/1
step
Inside the Lower Blackrock Spire Dungeon:
kill War Master Voone##9237 |q 5081/1
|tip Follow the ramps back down to the lowest level of Tazz'Alaor.
|tip Follow the path in the southwestern corner of the room.
step
Inside the Lower Blackrock Spire Dungeon:
kill War Master Voone##9237
|tip Follow the ramps back down to the lowest level of Tazz'Alaor.
|tip Follow the path in the southwestern corner of the room.
collect Gemstone of Smolderthorn##12335 |q 4742/2
|tip This isn't a 100% drop rate.
|tip You may need to roll against group members to get this.
step
Inside the Lower Blackrock Spire Dungeon:
click Sixth Mosh'aru Tablet##175950
|tip On the wall in the room with War Master Voone.
collect Sixth Mosh'aru Tablet##12741 |q 4788/2
step
Inside the Lower Blackrock Spire Dungeon:
kill Highlord Omokk##9196 |q 5081/2
|tip Return to the upper level of the dungeon again and proceed through Hordemar City.
|tip Continue past the groove in the ground where Bijou is and go west with all of the ogres to reach Mok'Doom.
|tip He is in the back of the room along the north side.
step
Inside the Lower Blackrock Spire Dungeon:
kill Highlord Omokk##9196
|tip Return to the upper level of the dungeon again and proceed through Hordemar City.
|tip Continue past the groove in the ground where Bijou is and go west with all of the ogres to reach Mok'Doom.
|tip He is in the back of the room along the north side.
collect Omokk's Head##12534 |q 4867 |future
collect Gemstone of Spirestone##12336 |q 4742/1
|tip This isn't a 100% drop rate.
|tip You may need to roll against group members to get this.
stickystart "Destroy_15_Spire_Spider_Eggs"
step
Inside the Lower Blackrock Spire Dungeon:
kill Mother Smolderweb##10596
|tip In the lower part of the dungeon, in the upper level of the Skitterweb Tunnels.
Gain the "Mother's Milk" Buff |havebuff Mother's Milk##16468 |q 4866
|tip If you are able to dispel the poison, make sure you don't.
step
label "Destroy_15_Spire_Spider_Eggs"
Inside the Lower Blackrock Spire Dungeon: |notinsticky
click Spire Spider Egg##175588+
|tip In the upper level of the Skitterweb Tunnels.
collect 15 Spire Spider Egg##12530 |q 4862/1
step
Inside the Lower Blackrock Spire Dungeon:
use Omokk's Head##12534
|tip Use it near the pile of bones up the ramp past Mother Smolderweb.
|tip It looks like a large pile of skulls in Hordemar City.
kill Urok Doomhowl##10584
|tip He will appear after a wave of ogres.
collect Warosh's Mojo##12712 |q 4867/1
step
Inside the Lower Blackrock Spire Dungeon:
use the Empty Worg Pup Cage##12262
|tip Use it on a Bloodaxe Worg Pup.
|tip They are in the same room as Halycon.
|tip After killing Urok Doomhowl, follow the path southwest down the hallway past a room of scorpions on your right.
|tip Go through the doorway, up the stairs and then go right to reach Halycon's Lair.
Capture a Caged Worg Pup |q 4729/1
step
Inside the Lower Blackrock Spire Dungeon:
kill Halycon##10220 |q 4701/1
|tip Inside Halycon's Lair.
step
Inside the Lower Blackrock Spire Dungeon:
kill Overlord Wyrmthalak##9568 |q 5081/3
|tip Final boss of Lower Blackrock Spire, inside the Chamber of Battle.
|tip After killing Halycon, go up the first small set of stairs on your left in the hallway room before Halycon's Lair.
|tip Cross this room and continue up the small set of stairs on the opposite side, continue forward to reach the Chamber of Battle.
step
Inside the Lower Blackrock Spire Dungeon:
kill Overlord Wyrmthalak##9568
|tip Final boss of Lower Blackrock Spire, inside the Chamber of Battle.
|tip After killing Halycon, go up the first small set of stairs on your left in the hallway room before Halycon's Lair.
|tip Cross this room and continue up the small set of stairs on the opposite side, continue forward to reach the Chamber of Battle.
collect Gemstone of Bloodaxe##12337 |q 4742/3
|tip This isn't a 100% drop rate.
|tip You may need to roll against group members to get this.
step
Inside the Lower Blackrock Spire Dungeon:
talk Warosh##10799
|tip He patrols near the start of Lower Blackrock Spire.
turnin Urok Doomhowl##4867
step
Inside the Lower Blackrock Spire Dungeon:
talk Vaelan##10296
|tip Run up the ramp near where you entered Lower Blackrock Spire.
turnin Seal of Ascension##4742
step
Leave the Blackrock Spire Dungeon
Click Here to Continue |confirm |q 4788
step
Follow the path up |goto Burning Steppes 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Maxwell's Mission##5081 |goto Burning Steppes 84.75,69.02
step
talk Helendis Riverhorn##9562
turnin Put Her Down##4701 |goto Burning Steppes 85.82,68.94
step
Return to Ragged John |q 4866/1 |goto Burning Steppes 65.01,23.77
step
talk Ragged John##9563
turnin Mother's Milk##4866 |goto Burning Steppes 65.01,23.77
step
talk Kibler##10260
|tip Inside the cave.
turnin Kibler's Exotic Pets##4729 |goto Burning Steppes 65.88,21.92
turnin En-Ay-Es-Tee-Why##4862 |goto Burning Steppes 65.88,21.92
step
talk Prospector Ironboot##10460
turnin The Final Tablets##4788 |goto Tanaris 66.89,24.03
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Scholomance Quests",{
image=ZGV.IMAGESDIR.."Scholomance",
description="This guide will walk you through completing the Scholomance Quests.",
},[[
step
Reach Level 50 |ding 50
|tip Use the Leveling guides to accomplish this.
step
map Stormwind City
path loop off
path	70.06,49.77	67.41,46.20	63.87,48.56	60.69,51.87	59.99,51.13
path	57.35,55.10	58.86,58.20	53.59,64.05	52.28,60.81	46.09,65.83
path	46.54,67.08	43.69,70.53	44.41,78.15	37.29,78.02	35.14,81.35
path	31.59,80.68	32.45,71.04	34.86,68.86	33.50,63.81	31.68,59.99
path	36.44,51.39	38.83,47.84	37.49,44.91	44.06,39.52	46.24,36.51
path	47.84,33.47	50.01,34.65	52.66,31.53	51.66,28.51	54.31,25.69
path	58.24,33.77	64.58,30.63	67.37,29.41
talk Crier Goodman##2198
|tip He's a Human that walks around in a large path around Stormwind.
accept A Call to Arms: The Plaguelands!##5091
step
talk Tinkee Steamboil##10267
accept Broodling Essence##4726 |goto Burning Steppes 65.24,24.00
step
use the Draco-Incarcinatrix 900##12284
|tip Use it on Broodling enemies around this area.
|tip They look like small flying dragons.
Kill Broodling enemies around this area
click Broodling Essence##175264+
|tip They look like red floating crystals that appear above their corpses after you kill them.
collect 8 Broodling Essence##12283 |q 4726/1 |goto Burning Steppes 59.26,32.49
You can find more around: |notinsticky
[72.83,28.41]
[80.05,27.94]
[87.34,32.01]
[91.96,35.64]
step
Follow the path up |goto Burning Steppes 63.92,29.88 < 15 |only if walking
talk Tinkee Steamboil##10267
turnin Broodling Essence##4726 |goto Burning Steppes 65.23,23.99
accept Felnok Steelspring##4808 |goto Burning Steppes 65.23,23.99
step
talk Felnok Steelspring##10468
turnin Felnok Steelspring##4808 |goto Winterspring 61.63,38.61
accept Chillwind Horns##4809 |goto Winterspring 61.63,38.61
step
kill Chillwind Ravager##7449+
|tip They look like chimeras.
|tip They share spawn points with the bears, so kill them too.
collect 8 Uncracked Chillwind Horn##12444 |q 4809/1 |goto Winterspring 59.97,21.54
You can find more around: |notinsticky
[54.75,22.59]
[59.18,18.02]
[60.13,12.28]
[57.99,14.79]
step
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto Winterspring 61.63,38.61
accept Return to Tinkee##4810 |goto Winterspring 61.63,38.61
step
talk Tinkee Steamboil##10267
turnin Return to Tinkee##4810 |goto Burning Steppes 65.23,23.99
step
talk Felnok Steelspring##10468
accept Tinkee Steamboil##4907 |goto Winterspring 61.63,38.61
step
talk Tinkee Steamboil##10267
turnin Tinkee Steamboil##4907 |goto Burning Steppes 65.23,23.99
accept Egg Freezing##4734 |goto Burning Steppes 65.23,23.99
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 4734
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
use the Eggscilloscope Prototype##12286
|tip Use it on the eggs in The Rookery, just past Pyroguard Emberseer.
|tip Don't get too close or they will hatch if they aren't frozen.
Test the Eggscilloscope Prototype |q 4734/1
step
Leave the Blackrock Spire Dungeon
Click Here to Continue |confirm |q 4734
step
talk Tinkee Steamboil##10267
turnin Egg Freezing##4734  |goto Burning Steppes 65.23,23.99
accept Egg Collection##4735 |goto Burning Steppes 65.23,23.99
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 4735
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
use the Eggscilloscope Prototype##12286
|tip Use it on the eggs in The Rookery, just past Pyroguard Emberseer.
|tip Use it to freeze the eggs.
|tip Don't get too close or they will hatch if they aren't frozen.
use the Collectronic Module##12287
|tip Use it to collect the eggs.
collect 8 Collected Dragon Egg##12241 |q 4735/1
step
Leave the Blackrock Spire Dungeon
Click Here to Continue |confirm |q 4735
step
talk Tinkee Steamboil##10267
turnin Egg Collection##4735 |goto Burning Steppes 65.23,23.99
accept Leonid Barthalomew##5522 |goto Burning Steppes 65.23,23.99
step
talk Leonid Barthalomew the Revered##11036
|tip Inside the building.
turnin Leonid Barthalomew##5522 |goto Eastern Plaguelands 71.89,48.29
accept Betina Bigglezink##5531 |goto Eastern Plaguelands 71.89,48.29
step
talk Betina Bigglezink##11035
turnin Betina Bigglezink##5531 |goto Eastern Plaguelands 71.66,49.93
accept Plagued Hatchlings##5529 |goto Eastern Plaguelands 71.66,49.93
accept Dawn's Gambit##4771 |goto Eastern Plaguelands 71.66,49.93
step
talk Commander Ashlam Valorfist##10838
turnin A Call to Arms: The Plaguelands!##5091 |goto Western Plaguelands 42.70,84.03
accept Clear the Way##5092 |goto Western Plaguelands 42.70,84.03
stickystart "Kill_Slavering_Ghouls"
step
kill 10 Skeletal Flayer##1783 |q 5092/1 |goto Western Plaguelands 48.51,81.13
You can find more around [50.64,77.01] |notinsticky
step
label "Kill_Slavering_Ghouls"
kill 10 Slavering Ghoul##1791 |q 5092/2 |goto Western Plaguelands 48.51,81.13
You can find more around [50.64,77.01] |notinsticky
step
talk Commander Ashlam Valorfist##10838
turnin Clear the Way##5092 |goto Western Plaguelands 42.70,84.03
accept All Along the Watchtowers##5097 |goto Western Plaguelands 42.70,84.03
step
Cross the bridge |goto Western Plaguelands 49.22,73.14 < 20 |only if walking
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Four |q 5097/4 |goto Western Plaguelands 46.70,71.10
step
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower One |q 5097/1 |goto Western Plaguelands 40.13,71.52
step
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Two |q 5097/2 |goto Western Plaguelands 42.44,66.27
step
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Three |q 5097/3 |goto Western Plaguelands 44.22,63.37
step
talk Commander Ashlam Valorfist##10838
turnin All Along the Watchtowers##5097 |goto Western Plaguelands 42.70,84.03
step
Reach Level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
talk Commander Ashlam Valorfist##10838
accept Scholomance##5533 |goto Western Plaguelands 42.70,84.03
step
talk Alchemist Arbington##11056
turnin Scholomance##5533 |goto Western Plaguelands 42.67,83.77
accept Skeletal Fragments##5537 |goto Western Plaguelands 42.67,83.77
step
Follow the path |goto Western Plaguelands 46.57,81.32 < 30 |only if walking
Kill Skeletal enemies around this area
|tip Only enemies that look like skeletons will drop the quest item.
collect 15 Skeletal Fragments##14619 |q 5537/1 |goto Western Plaguelands 50.35,78.60
You can find more inside and outside the crypt at [54.33,79.90]
step
Follow the path |goto Western Plaguelands 46.58,81.33 < 30 |only if walking
talk Alchemist Arbington##11056
turnin Skeletal Fragments##5537 |goto Western Plaguelands 42.67,83.77
accept Mold Rhymes With...##5538 |goto Western Plaguelands 42.67,83.77
step
talk Krinkle Goodsteel##5411
turnin Mold Rhymes With...##5538 |goto Tanaris 51.46,28.82
|tip Turning this quest in will cost 15 gold.
accept Fire Plume Forged##5801 |goto Tanaris 51.46,28.82
step
collect 2 Thorium Bar##12359 |q 5801 |future
|tip These are made with the Mining Profession.
|tip It requires 1 Thorium Ore each.
|tip You can also purchase these from the Auction House.
step
use the Skeleton Key Mold##14644
|tip You must be in the lake of lava.
collect Unfinished Skeleton Key##14645 |q 5801/1 |goto Un'Goro Crater 48.78,47.19
step
talk Alchemist Arbington##11056
turnin Fire Plume Forged##5801 |goto Western Plaguelands 42.67,83.77
accept Araj's Scarab##5803 |goto Western Plaguelands 42.67,83.77
step
kill Araj the Summoner##1852
|tip You may need help with this.
click Araj's Phylactery##177241
collect Araj's Scarab##14610 |q 5803/1 |goto Western Plaguelands 45.27,69.21
step
talk talk Alchemist Arbington##11056
turnin Araj's Scarab##5803 |goto Western Plaguelands 42.67,83.77
step
talk Commander Ashlam Valorfist##10838
accept The Key to Scholomance##5505 |goto Western Plaguelands 42.70,84.04
step
talk Weldon Barov##11023
accept Barov Family Fortune##5343 |goto Western Plaguelands 43.46,83.73
step
talk Eva Sarkhoff##11216
Select _"The pleasure is mine madam. Might I ask what it is that you are doing here?"_
|tip Click through the dialogue.
accept Doctor Theolen Krastinov, the Butcher##5382 |goto Western Plaguelands 70.22,73.72
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 5343
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
Inside the Scholomance Dungeon:
click The Deed to Southshore##176486
|tip It looks like an open white scroll laying on a table in the northeastern part of The Reliquary.
|tip After entering the dungeon, follow the path forward to enter The Reliquary.
collect The Deed to Southshore##13450 |q 5343/3
stickystart "Slay_20_Plagued_Hatchlings"
step
Inside the Scholomance Dungeon:
click The Deed to Tarren Mill##176487
|tip It looks like an open white scroll laying on a table to the left as you enter The Great Ossuary.
|tip Proceed through the Iron Gate on the north side of The Reliquary to reach the Chamber of Summoning.
|tip Continue straight through the dungeon to reach The Great Ossuary.
collect The Deed to Tarren Mill##13451 |q 5343/4
step
label "Slay_20_Plagued_Hatchlings"
Inside the Scholomance Dungeon:
kill 20 Plagued Hatchling##10678 |q 5529/1
|tip They are inside The Great Ossuary.
step
Inside the Scholomance Dungeon:
kill Rattlegore##11622
|tip He is downstairs inside The Great Ossuary.
|tip Jump down into one of the holes on the sides of the room to reach the lower level.
collect Viewing Room Key##13873 |q 5343
|tip This key is required to progress further into the dungeon.
|tip If someone else in the group already has it you can skip this step.
step
Inside the Scholomance Dungeon:
use the Dawn's Gambit##12368
|tip Use it in The Viewing Room.
|tip Go back upstairs after killing Rattlegore and head north in The Great Ossuary to return to the previous room (the map will just say Scholomance).
|tip Go right through the Iron Gate, clear the room and open the Viewing Room Door using the key.
|tip Clear the room before using it.
Place the Dawn's Gmabit |q 4771/1
step
Inside the Scholomance Dungeon:
kill Vectus##10432
|tip In the Viewing room.
Slay Vectus |q 4771/2
step
Inside the Scholomance Dungeon:
click The Deed to Brill##176484
|tip It looks like an open white scroll sitting on a ledge near the boss on the southwestern part of The Laboratory.
|tip Run back up the stairs to return to The Viewing Room.
|tip Go through the Iron Gate on the south side of The Viewing Room and go down the stairs to reach The Laboratory.
collect The Deed to Brill##13471 |q 5343/1
step
Inside the Scholomance Dungeon:
click Remains of Eva Sarkhoff##176544
|tip They look like a pile of bloodied bones in the northern part of the room with Doctor Theolen Krastinov.
|tip Go through the Iron Gate on the eastern side of The Viewing Room and go down the stairs to reach the Headmaster's Study.
|tip Staying on the upper level of the Headmaster's Study, head around the outside of the room and enter the room across from the entrance on the eastern side.
Burn the Remains of Eva Sarkhoff |q 5382/2
step
Inside the Scholomance Dungeon:
click Remains of Lucien Sarkhoff##176545
|tip They look like a pile of bloodied bones in the southeastern part of the room with Doctor Theolen Krastinov.
Burn the Remains of Lucien Sarkhoff |q 5382/3
step
Inside the Scholomance Dungeon:
kill Doctor Theolen Krastinov##11261 |q 5382/1
step
Inside the Scholomance Dungeon:
click The Deed to Caer Darrow##176485
|tip It looks like an open white scroll laying on a table on the eastern side of the Barov Family Vault.
|tip Return to the Headmaster's Study and jump down, then turn around and enter the eastern room to reach the Barov Family Vault.
collect The Deed to Caer Darrow##13448 |q 5343/2
step
Leave the Scholomance Dungeon
Click Here to Continue |confirm |q 5343
step
talk Eva Sarkhoff##11216
turnin Doctor Theolen Krastinov, the Butcher##5382 |goto Western Plaguelands 70.22,73.72
accept Krastinov's Bag of Horrors##5515 |goto Western Plaguelands 70.22,73.72
step
talk Weldon Barov##11023
turnin Barov Family Fortune##5343 |goto Western Plaguelands 43.46,83.73
step
talk Betina Bigglezink##11035
turnin Plagued Hatchlings##5529 |goto Eastern Plaguelands 71.66,49.94
|tip This will unlock the next quest, which drops from inside Scholomance.
turnin Dawn's Gambit##4771 |goto Eastern Plaguelands 71.66,49.93
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 5515
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
Inside the Scholomance Dungeon:
kill Jandice Barov##10503
|tip After entering the dungeon, follow the path forward to enter The Reliquary.
|tip Go left and proceed through the Iron Gate on the north side of the room to reach the Chamber of Summoning.
|tip Proceed into the next main room and then follow the path to the right and go down the stairs.
|tip Jandice is in the northeastern part of this room.
collect Krastinov's Bag of Horrors##13725 |q 5515/1
step
Inside the Scholomance Dungeon:
kill Plagued Hatchling##10678+
collect Healthy Dragon Scale##13920 |q 5582 |future
step
use the Healthy Dragon Scale##13920
accept Healthy Dragon Scale##5582
step
Leave the Scholomance Dungeon
Click Here to Continue |confirm |q 5515
step
talk Eva Sarkhoff##11216
turnin Krastinov's Bag of Horrors##5515 |goto Western Plaguelands 70.22,73.72
accept Kirtonos the Herald##5384 |goto Western Plaguelands 70.22,73.72
step
talk Betina Bigglezink##11035
turnin Healthy Dragon Scale##5582 |goto Eastern Plaguelands 71.66,49.94
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 5384
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
Inside the Scholomance Dungeon:
click Brazier of the Herald
|tip After entering the dungeon, follow the path forward to enter The Reliquary.
|tip Go left and proceed through the Iron Gate on the north side of the room to reach the Chamber of Summoning.
|tip Follow the path out to the right to the balcony.
|tip Clear the Chamber of Summoning before doing this.
kill Kirtonos the Herald##10506 |q 5384/1
|tip Drag him back into the gate.
step
Leave the Scholomance Dungeon
Click Here to Continue |confirm |q 5384
step
talk Eva Sarkhoff##11216
turnin Kirtonos the Herald##5384 |goto Western Plaguelands 70.22,73.72
step
Reach Level 57 |ding 57
|tip Use the Leveling guides to accomplish this.
step
use the Spectral Essence##13544
Equip the Spectral Essence
talk Magistrate Marduke##11286
|tip You must have the Spectral Essence equipped to see him.
accept The Human, Ras Frostwhisper##5461 |goto Western Plaguelands 70.57,74.11
step
click Keepsake of Remembrance##176630
|tip At the top of the tower.
|tip If it's not there, check in the fireplaces of nearby buildings.
collect Keepsake of Remembrance##13585 |q 5461/1 |goto Arathi Highlands 17.91,69.41
step
use the Spectral Essence##13544
Equip the Spectral Essence
talk Magistrate Marduke##11286
|tip You must have the Spectral Essence equipped to see him.
turnin The Human, Ras Frostwhisper##5461 |goto Western Plaguelands 70.57,74.11
accept The Dying, Ras Frostwhisper##5462 |goto Western Plaguelands 70.57,74.11
step
talk Leonid Barthalomew the Revered##11036
|tip Inside the building.
turnin The Dying, Ras Frostwhisper##5462 |goto Eastern Plaguelands 71.88,48.29
accept Menethil's Gift##5463 |goto Eastern Plaguelands 71.88,48.29
step
click Elders' Square Service Gate |goto Eastern Plaguelands/0 41.43,17.71 < 10 |walk
|tip This requires the Key to the City, which drops from Magistrate barthilas in Stratholme - Live.
Enter the Stratholme - Undead Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5464 |future
step
Inside the Stratholme - Undead Dungeon:
click Menethil's Gift##176631
|tip It looks like a large orange circular symbol on the floor in the room with Baron Rivendare.
|tip Follow the path north and then east through the two Gauntlet Gates to reach the Gauntlet.
|tip This requires the Key to the City or a Rogue with leveled lockpicking to open.
|tip Continue following the path north and then west to reach Slaughter Square.
|tip Enter the building in Slaughter Square and go downstairs.
turnin Menethil's Gift##5463
accept Menethil's Gift##5464
step
Leave the Stratholme Dungeon
Click Here to Continue |confirm |q 5464
step
talk Leonid Barthalomew the Revered##11036
|tip Inside the building.
turnin Menethil's Gift##5463 |goto Eastern Plaguelands 71.88,48.29
accept Soulbound Keepsake##5465 |goto Eastern Plaguelands 71.88,48.29
step
use the Spectral Essence##13544
Equip the Spectral Essence
talk Magistrate Marduke##11286
|tip You must have the Spectral Essence equipped to see him.
turnin Soulbound Keepsake##5465 |goto Western Plaguelands 70.57,74.11
accept The Lich, Ras Frostwhisper##5466 |goto Western Plaguelands 70.57,74.11
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 5466
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
Inside the Scholomance Dungeon:
kill Rattlegore##11622
|tip After entering the dungeon, follow the path forward to enter The Reliquary.
|tip Go left and proceed through the Iron Gate on the north side of the room to reach the Chamber of Summoning.
|tip Continue straight through the dungeon to reach The Great Ossuary.
|tip Jump down into one of the holes on the sides of the room to reach the lower level with Rattlegore.
collect Viewing Room Key##13873 |q 5466
|tip This key is required to progress further into the dungeon.
|tip If someone else in the group already has it you can skip this step.
step
Inside the Scholomance Dungeon:
use the Soulbound Keepsake##13752
|tip Use it on Ras Frostwhisper.
kill Ras Frostwhisper##10508
|tip He is inside The Laboratory.
|tip Go back upstairs after killing Rattlegore and head north in The Great Ossuary to return to the previous room (the map will just say Scholomance).
|tip Go right through the Iron Gate, clear the room and open the Viewing Room Door using the key.
|tip Continue through the Iron Gate on the south side of The Viewing Room and go down the stairs to reach The Laboratory.
collect Human Head of Ras Frostwhisper##13626 |q 5466/1
step
Leave the Scholomance Dungeon
Click Here to Continue |confirm |q 5466
step
use the Spectral Essence##13544
Equip the Spectral Essence
talk Magistrate Marduke##11286
|tip You must have the Spectral Essence equipped to see him.
turnin The Lich, Ras Frostwhisper##5466 |goto Western Plaguelands 70.57,74.11
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Stratholme - Live Side Quests",{
image=ZGV.IMAGESDIR.."Stratholme",
description="This guide will walk you through completing the Stratholme - Live Side Quests.",
},[[
step
Reach Level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
talk Smokey LaRue##11033
accept The Great Fras Siabi##5214 |goto Eastern Plaguelands 70.87,48.44
step
talk Duke Nicholas Zverenhoff##11039
accept The Archivist##5251 |goto Eastern Plaguelands 71.63,50.09
step
talk Caretaker Alen##11038
|tip He walks around this area.
accept The Restless Souls##5281 |goto Eastern Plaguelands 70.09,53.57
step
talk Egan##11140
|tip Inside the building.
turnin The Restless Souls##5281 |goto Eastern Plaguelands 11.36,26.60
accept The Restless Souls##5282 |goto Eastern Plaguelands 11.36,26.60
step
Enter the cave |goto Eastern Plaguelands 12.18,22.60 < 10 |walk
Follow the path |goto Eastern Plaguelands 10.71,25.10 < 15 |walk
Leave the cave |goto Eastern Plaguelands 5.10,32.85 < 15 |walk
talk Tirion Fordring##1855
|tip He walks around this area.
accept Demon Dogs##5542 |goto Eastern Plaguelands 5.16,35.57
accept Blood Tinged Skies##5543 |goto Eastern Plaguelands 5.16,35.57
accept Carrion Grubbage##5544 |goto Eastern Plaguelands 5.16,35.57
stickystart "Kill_Plaguehound_Runts"
stickystart "Collect_Slabs_Of_Carrion_Worm_Meat"
step
label "Kill_Plaguebats"
kill 30 Plaguebat##8600 |q 5543/1 |goto Eastern Plaguelands 37.26,70.91
You can find more around: |notinsticky
[42.24,69.81]
[35.16,74.32]
[27.42,69.07]
[19.99,68.52]
[18.56,77.87]
[33.76,82.90]
step
label "Kill_Plaguehound_Runts"
kill 20 Plaguehound Runt##8596 |q 5542/1 |goto Eastern Plaguelands 37.26,70.91
You can find more around: |notinsticky
[42.24,69.81]
[27.42,69.07]
[19.99,68.52]
[18.56,77.87]
[33.76,82.90]
step
label "Collect_Slabs_Of_Carrion_Worm_Meat"
kill Carrion Grub##8603+
collect 15 Slab of Carrion Worm Meat##13853 |q 5544/1 |goto Eastern Plaguelands 37.26,70.91
You can find more around: |notinsticky
[42.24,69.81]
[35.16,74.32]
[27.42,69.07]
[19.99,68.52]
[18.56,77.87]
[33.76,82.90]
step
kill 5 Plaguehound##8597 |q 5542/2 |goto Eastern Plaguelands 61.35,57.79
You can find more around: |notinsticky
[76.41,66.59]
[71.11,56.12]
step
label "Kill_Frenzied_Plaguehounds"
kill 5 Frenzied Plaguehound##8598 |q 5542/3 |goto Eastern Plaguelands 54.71,39.40
You can find more around: |notinsticky
[51.17,43.24]
[49.69,35.97]
step
talk Tirion Fordring##1855
|tip He walks around this area.
turnin Demon Dogs##5542 |goto Eastern Plaguelands 5.16,35.57
turnin Blood Tinged Skies##5543 |goto Eastern Plaguelands 5.16,35.57
turnin Carrion Grubbage##5544 |goto Eastern Plaguelands 5.16,35.57
accept Redemption##5742 |goto Eastern Plaguelands 5.16,35.57
step
talk Tirion Fordring##1855
|tip He walks around this area.
|tip Type "/sit" into your chat, or press X.
|tip You must be sitting for the dialogue option to appear when you talk to him.
Select _"I am ready to hear your tale, Tirion."_
Listen to Tirion's Tale |q 5742/1 |goto Eastern Plaguelands 5.16,35.57
step
talk Tirion Fordring##1855
|tip He walks around this area.
turnin Redemption##5742 |goto Eastern Plaguelands 5.16,35.57
accept Of Forgotten Memories##5781 |goto Eastern Plaguelands 5.16,35.57
step
click Loose Dirt Mound##177240
|tip Mercutio Filthgorger appears with a group of 3 guards with him.
|tip Try to kite Mercutio Filthgorger away from his guards, so you can fight him by himself.
|tip If you have trouble, try to find someone to help you.
kill Mercutio Filthgorger##11886
collect Taelan's Hammer##14613 |q 5781/1 |goto Eastern Plaguelands 23.83,74.45
step
Follow the path |goto Eastern Plaguelands 9.09,51.59 < 30 |only if walking
talk Tirion Fordring##1855
|tip He walks around this area.
turnin Of Forgotten Memories##5781 |goto Eastern Plaguelands 5.16,35.57
accept Of Lost Honor##5845 |goto Eastern Plaguelands 5.16,35.57
step
click Symbol of Lost Honor##177264
|tip Underwater.
collect Symbol of Lost Honor##14625 |q 5845/1 |goto Eastern Plaguelands 62.51,26.79
step
talk Tirion Fordring##1855
|tip He walks around this area.
turnin Of Lost Honor##5845 |goto Eastern Plaguelands 5.16,35.57
accept Of Love and Family##5846 |goto Eastern Plaguelands 5.16,35.57
step
talk Artist Renfray##11936
|tip Inside the building.
turnin Of Love and Family##5846 |goto Western Plaguelands 65.77,75.37
accept Of Love and Family##5848 |goto Western Plaguelands 65.77,75.37
step
Enter the Stratholme - Live Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5282
stickystart "Free_15_Souls"
step
Inside the Stratholme - Live Dungeon:
click Premius Siabi Tobacco
|tip It looks like a small wooden crate on the ground.
|tip Turn left twice into King's Square.
kill Fras Siabi##11058
collect Siabi's Premium Tobacco##13172 |q 5214/1
step
Inside the Stratholme - Live Dungeon:
click The Bastion Door
|tip Go north and then west once you enter Market Row to reach Crusader's Square.
|tip This requires The Scarlet Key from the Scarlet Monastery dungeon or a Rogue with leveled lockpicking to open.
click Malor's Strongbox##176112
|tip Enter The Hall of Lights, go down the hall and enter the small room on the left.
|tip In the same room as Malor the Zealous.
|tip It looks like a small toolbox in the corner of the room.
collect Medallion of Faith##12845 |q 5122 |future
step
Inside the Stratholme - Live Dungeon:
click Hall of High Command
|tip This requires The Scarlet Key from the Scarlet Monastery dungeon or a Rogue with leveled lockpicking to open.
|tip Go across the hall from The Hall of Lights to enter The Scarlet Bastion.
kill Archivist Galford##10811
|tip He is near the end of The Scarlet Bastion across from Grand Crusader Dathrohan.
Slay Archivist Galford |q 5251/1
step
Inside the Stratholme - Live Dungeon:
click Unfinished Painting##177287
|tip In the same room as Archivist Galford.
collect Of Love and Family##14679 |q 5848/1
step
Inside the Stratholme - Live Dungeon:
click Scarlet Archive##176245
|tip It looks like a small brown book on the table in the room where Archivist Galford is.
Burn the Archive |q 5251/2
step
label "Free_15_Souls"
Inside the Stratholme - Live Dungeon:
Equip Egan's Blaster
|tip It should be in your inventory.
use Egan's Blaster##13289
|tip Use it on Spectral Citizens.
|tip This will cause Restless Spirits to spawn.
|tip Use Egan's Blaster on the Restless Spirits after.
Free 15 Souls |q 5282/1
step
Leave the Stratholme - Live Dungeon
Click Here to Continue |confirm |q 5282
step
click Elders' Square Service Gate |goto Eastern Plaguelands/0 41.43,17.71 < 10 |walk
|tip This requires the Key to the City, which drops from Magistrate barthilas in Stratholme - Live.
Enter the Stratholme - Undead Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5122 |future
step
Inside the Stratholme - Undead Dungeon:
click Service Entrance Gate
|tip This requires the Key to the City or a Rogue with leveled lockpicking to open.
talk Aurius##10931
|tip Inside the chapel to the right as you enter.
accept The Medallion of Faith##5122
step
Leave the Stratholme - Undead Dungeon
Click Here to Continue |confirm |q 5122
step
talk Egan##11140
|tip Inside the building.
turnin The Restless Souls##5282 |goto Stratholme/0 14.45,33.74
step
Leave Strathlome Dungeon |goto Eastern Plaguelands 41.47,17.98 < 5 |walk
Enter the cave |goto Eastern Plaguelands 12.18,22.60 < 10 |walk
Follow the path |goto Eastern Plaguelands 10.71,25.10 < 15 |walk
Leave the cave |goto Eastern Plaguelands 5.10,32.85 < 15 |walk
talk Tirion Fordring##1855
|tip He walks around this area.
turnin Of Love and Family##5848 |goto Eastern Plaguelands 5.16,35.57
step
talk Smokey LaRue##11033
turnin The Great Fras Siabi##5214 |goto Eastern Plaguelands 70.87,48.44
step
talk Duke Nicholas Zverenhoff##11039
turnin The Archivist##5251 |goto Eastern Plaguelands 71.63,50.09
step
Enter the Stratholme - Live Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5262 |future
step
Inside the Scholomance - Live Dungeon:
kill Balnazzar##10813
|tip He is the last boss of the Live Side of Stratholme.
|tip He is at the very end of The Scarlet Bastion, across from where Archivist Galford was.
collect Head of Balnazzar##13250 |q 5262 |future
step
use the Head of Balnazzar##13250
accept The Truth Comes Crashing Down##5262
step
Leave the Stratholme - Live Dungeon
Click Here to Continue |confirm |q 5262
step
talk Duke Nicholas Zverenhoff##11039
turnin The Truth Comes Crashing Down##5262 |goto Eastern Plaguelands 71.63,50.09
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Stratholme - Undead Side Quests",{
image=ZGV.IMAGESDIR.."Stratholme",
description="This guide will walk you through completing the Stratholme - Undead Side Quests.",
},[[
step
Reach Level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
talk Eva Sarkhoff##11216
Select _"The pleasure is mine madam. Might I ask what it is that you are doing here?"_
|tip Click through the dialogue.
accept Doctor Theolen Krastinov, the Butcher##5382 |goto Western Plaguelands 70.22,73.72
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 5382
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
Inside the Scholomance Dungeon:
kill Rattlegore##11622
|tip After entering the dungeon, follow the path forward to enter The Reliquary.
|tip Go left and proceed through the Iron Gate on the north side of the room to reach the Chamber of Summoning.
|tip Continue straight through the dungeon to reach The Great Ossuary.
|tip Jump down into one of the holes on the sides of the room to reach the lower level with Rattlegore.
collect Viewing Room Key##13873 |q 5382
|tip This key is required to progress further into the dungeon.
|tip If someone else in the group already has it you can skip this step.
step
Inside the Scholomance Dungeon:
click Remains of Eva Sarkhoff##176544
|tip They look like a pile of bloodied bones in the northern part of the room with Doctor Theolen Krastinov.
|tip Go back upstairs after killing Rattlegore and head north in The Great Ossuary to return to the previous room (the map will just say Scholomance).
|tip Go right through the Iron Gate, clear the room and open the Viewing Room Door using the key.
|tip Take a quick left in The Viewing Room, go through the Iron Gate and follow the stairs down to reach the Headmaster's Study.
|tip Staying on the upper level of the Headmaster's Study, head around the outside of the room and enter the room across from the entrance on the eastern side.
Burn the Remains of Eva Sarkhoff |q 5382/2
step
Inside the Scholomance Dungeon:
click Remains of Lucien Sarkhoff##176545
|tip They look like a pile of bloodied bones in the southeastern part of the room with Doctor Theolen Krastinov.
Burn the Remains of Lucien Sarkhoff |q 5382/3
step
Inside the Scholomance Dungeon:
kill Doctor Theolen Krastinov##11261 |q 5382/1
step
Leave the Scholomance Dungeon
Click Here to Continue |confirm |q 5382
step
talk Eva Sarkhoff##11216
turnin Doctor Theolen Krastinov, the Butcher##5382 |goto Western Plaguelands 70.22,73.72
accept Krastinov's Bag of Horrors##5515 |goto Western Plaguelands 70.22,73.72
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 5515
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
Inside the Scholomance Dungeon:
kill Jandice Barov##10503
|tip After entering the dungeon, follow the path forward to enter The Reliquary.
|tip Go left and proceed through the Iron Gate on the north side of the room to reach the Chamber of Summoning.
|tip Proceed into the next main room and then follow the path to the right and go down the stairs.
|tip Jandice is in the northeastern part of this room.
collect Krastinov's Bag of Horrors##13725 |q 5515/1
step
Leave the Scholomance Dungeon
Click Here to Continue |confirm |q 5515
step
talk Eva Sarkhoff##11216
turnin Krastinov's Bag of Horrors##5515 |goto Western Plaguelands 70.22,73.72
accept Kirtonos the Herald##5384 |goto Western Plaguelands 70.22,73.72
step
Enter the Scholomance Dungeon with Your Group |goto Scholomance/0 0.00,0.00 < 500 |c |q 5384
|tip This requires the Skeleton Key from the quest "The Key to Scholomance".
step
Inside the Scholomance Dungeon:
click Brazier of the Herald
|tip After entering the dungeon, follow the path forward to enter The Reliquary.
|tip Go left and proceed through the Iron Gate on the north side of the room to reach the Chamber of Summoning.
|tip Follow the path out to the right to the balcony.
|tip Clear the Chamber of Summoning before doing this.
kill Kirtonos the Herald##10506 |q 5384/1
|tip Drag him back into the gate.
step
Leave the Scholomance Dungeon
Click Here to Continue |confirm |q 5384
step
talk Eva Sarkhoff##11216
turnin Kirtonos the Herald##5384 |goto Western Plaguelands 70.22,73.72
step
Reach Level 57 |ding 57
|tip Use the Leveling guides to accomplish this.
step
use the Spectral Essence##13544
Equip the Spectral Essence
talk Magistrate Marduke##11286
|tip You must have the Spectral Essence equipped to see him.
accept The Human, Ras Frostwhisper##5461 |goto Western Plaguelands 70.57,74.11
step
click Keepsake of Remembrance##176630
|tip It looks like a small red book at the top of the tower.
|tip If it's not there, check in the fireplaces of nearby buildings.
collect Keepsake of Remembrance##13585 |q 5461/1 |goto Arathi Highlands 17.91,69.41
step
use the Spectral Essence##13544
Equip the Spectral Essence
talk Magistrate Marduke##11286
|tip You must have the Spectral Essence equipped to see him.
turnin The Human, Ras Frostwhisper##5461 |goto Western Plaguelands 70.57,74.11
accept The Dying, Ras Frostwhisper##5462 |goto Western Plaguelands 70.57,74.11
step
talk Leonid Barthalomew the Revered##11036
|tip Inside the building.
turnin The Dying, Ras Frostwhisper##5462 |goto Eastern Plaguelands 71.88,48.29
accept Menethil's Gift##5463 |goto Eastern Plaguelands 71.88,48.29
step
talk Duke Nicholas Zverenhoff##11039
accept The Archivist##5251 |goto Eastern Plaguelands 71.63,50.09
step
Enter the Stratholme - Live Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5251
step
Inside the Stratholme - Live Dungeon:
click The Bastion Door
|tip Go left after entering, then north and then west once you enter Market Row to reach Crusader's Square.
|tip This requires The Scarlet Key from the Scarlet Monastery dungeon or a Rogue with leveled lockpicking to open.
click Malor's Strongbox##176112
|tip Enter The Hall of Lights, go down the hall and enter the small room on the left.
|tip In the same room as Malor the Zealous.
|tip It looks like a small toolbox in the corner of the room.
collect Medallion of Faith##12845 |q 5122 |future
step
Inside the Stratholme - Live Dungeon:
click Hall of High Command
|tip This requires The Scarlet Key from the Scarlet Monastery dungeon or a Rogue with leveled lockpicking to open.
|tip Go across the hall from The Hall of Lights to enter The Scarlet Bastion.
kill Archivist Galford##10811
|tip He is near the end of The Scarlet Bastion across from Grand Crusader Dathrohan.
Slay Archivist Galford |q 5251/1
step
Inside the Stratholme - Live Dungeon:
click Scarlet Archive##176245
|tip It looks like a small brown book on the table in the room where Archivist Galford is.
Burn the Archive |q 5251/2
step
Leave the Stratholme - Live Dungeon
Click Here to Continue |confirm |q 5251
step
talk Duke Nicholas Zverenhoff##11039
turnin The Archivist##5251 |goto Eastern Plaguelands 71.63,50.09
step
Enter the Stratholme - Live Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5262 |future
step
Inside the Scholomance - Live Dungeon:
kill Balnazzar##10813
|tip He is the last boss of the Live Side of Stratholme.
|tip He is at the very end of The Scarlet Bastion, across from where Archivist Galford was.
collect Head of Balnazzar##13250 |q 5262 |future
step
use the Head of Balnazzar##13250
accept The Truth Comes Crashing Down##5262
step
Leave the Stratholme - Live Dungeon
Click Here to Continue |confirm |q 5262
step
talk Duke Nicholas Zverenhoff##11039
turnin The Truth Comes Crashing Down##5262 |goto Eastern Plaguelands 71.63,50.09
accept Above and Beyond##5263 |goto Eastern Plaguelands 71.63,50.09
step
talk Betina Bigglezink##11035
accept The Flesh Does Not Lie##5212 |goto Eastern Plaguelands 71.66,49.93
step
talk Leonid Barthalomew the Revered##11036
|tip Inside the building.
accept Houses of the Holy##5243 |goto Eastern Plaguelands 71.89,48.29
step
click Elders' Square Service Gate |goto Eastern Plaguelands/0 41.43,17.71 < 10 |walk
|tip This requires the Key to the City, which drops from Magistrate barthilas in Stratholme - Live.
Enter the Stratholme - Undead Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5263
stickystart "Collect_20_Plagued_Flesh_Sample"
stickystart "Collect_5_Stratholme_Holy_Water"
step
Inside the Stratholme - Undead Dungeon:
click Service Entrance Gate
|tip This requires the Key to the City or a Rogue with leveled lockpicking to open.
talk Aurius##10931
|tip Inside the chapel to the right as you enter.
accept The Medallion of Faith##5122 |q 5125 |future
step
Inside the Stratholme - Undead Dungeon:
kill Baron Rivendare##10440
|tip Enter the building in Slaughter Square and go downstairs.
collect Head of Baron Rivendare##13251 |q 5263/1
step
Inside the Stratholme - Undead Dungeon:
talk Aurius##10917
|tip On the floor in the room with Baron Rivendare.
|tip He appears if you've completed The Medallion of Faith quest.
|tip He will not appear again if you fail to kill the Baron and you will have to wait for a reset to try again.
accept Aurius' Reckoning##5125
step
Inside the Stratholme - Undead Dungeon:
click Menethil's Gift##176631
|tip It looks like a large orange circular symbol on the floor in the room with Baron Rivendare.
turnin Menethil's Gift##5463
accept Menethil's Gift##5464
step
label "Collect_20_Plagued_Flesh_Sample"
Inside the Stratholme - Undead Dungeon: |notinsticky
Kill enemies around this area
collect 20 Plagued Flesh Sample##13174 |q 5212/1
step
label "Collect_5_Stratholme_Holy_Water"
Inside the Stratholme - Undead Dungeon: |notinsticky
click Stratholme Supply Crate##181085+
|tip They look like brown boxes along the walls of the dungeon.
|tip They will sometimes spawn enemies instead.
collect 5 Stratholme Holy Water##13180 |q 5243/1
step
Leave Stratholme - Undead Dungeon
Click Here to Continue |confirm |q 5243
step
talk Duke Nicholas Zverenhoff##11039
turnin Above and Beyond##5263 |goto Eastern Plaguelands 71.63,50.09
step
talk Betina Bigglezink##11035
turnin The Flesh Does Not Lie##5212 |goto Eastern Plaguelands 71.66,49.93
accept The Active Agent##5213 |goto Eastern Plaguelands 71.66,49.93
step
talk Leonid Barthalomew the Revered##11036
|tip Inside the building.
turnin Menethil's Gift##5464 |goto Eastern Plaguelands 71.88,48.29
turnin Houses of the Holy##5243 |goto Eastern Plaguelands 71.89,48.29
step
click Elders' Square Service Gate |goto Eastern Plaguelands/0 41.43,17.71 < 10 |walk
|tip This requires the Key to the City, which drops from Magistrate barthilas in Stratholme - Live.
Enter the Stratholme - Undead Dungeon with Your Group |goto Stratholme/0 0.00,0.00 < 500 |c |q 5213
step
Inside the Stratholme - Undead Dungeon:
click Scourge Data##176249
|tip It looks like a small metal box in one of the three Ziggurats in The Gauntlet area.
|tip Follow the path north and then east through the two Gauntlet Gates to reach the Gauntlet.
|tip This requires the Key to the City or a Rogue with leveled lockpicking to open.
collect Scourge Data##13176 |q 5213/1
step
Leave Stratholme - Undead Dungeon
Click Here to Continue |confirm |q 5213
step
talk Betina Bigglezink##11035
turnin The Active Agent##5213 |goto Eastern Plaguelands 71.66,49.93
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Upper Blackrock Spire Quests",{
image=ZGV.IMAGESDIR.."Upper Blackrock Spire",
description="This guide will walk you through completing the Upper Blackrock Quests.",
},[[
step
Reach Level 57 |ding 57
|tip Use the Leveling guides to accomplish this.
step
Enter the building |goto Stormwind City 73.33,46.41 < 15 |only if walking
talk Count Remington Ridgewell##2285
|tip Inside the building.
accept Mayara Brightwing##4766 |goto Stormwind City 76.93,47.82
step
talk Mayara Brightwing##9565
turnin Mayara Brightwing##4766 |goto Burning Steppes 84.84,69.12
accept Doomrigger's Clasp##4764 |goto Burning Steppes 84.84,69.12
step
talk Tinkee Steamboil##10267
accept Broodling Essence##4726 |goto Burning Steppes 65.24,24.00
step
Follow the path up |goto Burning Steppes 82.89,63.37 < 7 |only if walking
talk Helendis Riverhorn##9562
accept Dragonkin Menace##4182 |goto Burning Steppes 85.82,68.95
stickystart "Slay_Black_Dragonspawns"
stickystart "Slay_Black_Drake"
stickystart "Slay_Black_Wrymkins"
stickystart "Broodling_Essence"
step
kill 15 Black Broodling##7047 |q 4182/1 |goto Burning Steppes 89.18,53.85
You can find more around [91.51,35.35]
step
label "Slay_Black_Dragonspawns"
kill 10 Black Dragonspawn##7040 |q 4182/2 |goto Burning Steppes 92.05,53.82
|tip These enemies are Elite, you may need a group to complete this.
You can find more around: |notinsticky
[88.72,37.56]
[84.45,27.50]
step
label "Slay_Black_Drake"
kill 1 Black Drake##7044 |q 4182/3 |goto Burning Steppes 89.18,53.85
|tip These enemies are Elite, you may need a group to complete this.
You can find more around [91.51,35.35] |notinsticky
step
label "Slay_Black_Wrymkins"
kill 4 Black Wyrmkin##7041 |q 4182/4 |goto Burning Steppes 92.05,53.82
|tip These enemies are Elite, you may need a group to complete this.
You can find more around: |notinsticky
[88.72,37.56]
[84.45,27.50]
step
label "Broodling_Essence"
use the Draco-Incarcinatrix 900##12284
|tip Use it on Broodling enemies around this area.
|tip They look like small flying dragons.
Kill Broodling enemies around this area
click Broodling Essence##175264+
|tip They look like red floating crystals that appear above their corpses after you kill them.
collect 8 Broodling Essence##12283 |q 4726/1 |goto Burning Steppes 59.26,32.49
You can find more around: |notinsticky
[72.83,28.41]
[80.05,27.94]
[87.34,32.01]
[91.96,35.64]
step
Follow the path up |goto Burning Steppes 82.89,63.37 < 7 |only if walking
talk Helendis Riverhorn##9562
turnin Dragonkin Menace##4182 |goto Burning Steppes 85.82,68.95
accept The True Masters##4183 |goto Burning Steppes 85.82,68.95
step
Enter the building |goto Redridge Mountains 24.42,46.07 < 5 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4183 |goto Redridge Mountains 24.89,44.45
accept The True Masters##4184 |goto Redridge Mountains 24.89,44.45
step
Enter the building |goto Stormwind City 73.21,46.56 < 7 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4184 |goto Stormwind City 80.20,38.35
accept The True Masters##4185 |goto Stormwind City 80.20,38.35
step
talk Lady Katrana Prestor##1749
|tip Inside the building.
Select _"Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice."_
|tip Click through the dialogue.
Receive Advice From Lady Prestor |q 4185/1 |goto Stormwind City 80.10,38.17
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4185 |goto Stormwind City 80.20,38.35
accept The True Masters##4186 |goto Stormwind City 80.20,38.35
step
Enter the building |goto Redridge Mountains 24.42,46.07 < 5 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4186 |goto Redridge Mountains 24.89,44.45
accept The True Masters##4223 |goto Redridge Mountains 24.89,44.45
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4223 |goto Burning Steppes/0 84.75,69.02
accept The True Masters##4224 |goto Burning Steppes/0 84.75,69.02
step
Follow the path up |goto Burning Steppes/0 63.86,30.11 < 10 |only if walking
talk Ragged John##9563
Select _"Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him."_
|tip Click through the dialogue.
Hear Ragged John's Story |q 4224/1 |goto Burning Steppes/0 65.02,23.76
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4224 |goto Burning Steppes/0 84.75,69.02
accept Marshal Windsor##4241 |goto Burning Steppes/0 84.75,69.02
step
Run down the chain |goto Searing Gorge/0 37.25,94.39 < 5 |walk
Enter the building |goto Searing Gorge/0 35.91,100.22 < 7 |c
step
Continue down and run down the chain |goto Searing Gorge/0 34.86,99.20 < 5 |walk
Enter the building |goto Searing Gorge/0 32.55,94.94 < 5 |walk
Follow the path |goto Searing Gorge/0 26.88,83.87 < 30 |walk
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c |q 4241
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
|tip After entering the dungeon, go straight into the Detention Block and then take the first right.
|tip Follow this path around until you can go left into a room at the back of this long hallway.
collect Prison Cell Key##11140 |q 4241
|tip You need this key to unlock Marshal Windsor's cell door.
|tip If someone else in the group already has the key you can skip this step.
|tip A Rogue can also pick the lock.
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip Leave High Interrogator Gerstahn's room and go left, then open the first Cell Door on your right.
turnin Marshal Windsor##4241
accept Abandoned Hope##4242
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm |q 4242
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Abandoned Hope##4242 |goto Burning Steppes/0 84.75,69.02
step
Run down the chain |goto Searing Gorge/0 37.25,94.39 < 5 |walk
Enter the building |goto Searing Gorge/0 35.91,100.22 < 7 |c
step
Continue down and run down the chain |goto Searing Gorge/0 34.86,99.20 < 5 |walk
Enter the building |goto Searing Gorge/0 32.55,94.94 < 5 |walk
Follow the path |goto Searing Gorge/0 26.88,83.87 < 30 |walk
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c |q 4264 |future
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
Kill Anvilrage dwarves at the beginning of the dungeon
|tip Just clear the first few rooms of the dungeon, killing all the Anvilrage dwarves and resetting the instance if needed, until you get the item drop.
collect A Crumpled Up Note##11446 |complete itemcount(11446) == 1 or haveq(4264) or completedq(4264)
step
Inside the Blackrock Depths Dungeon:
use A Crumpled Up Note##11446
accept A Crumpled Up Note##4264
step
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
|tip After entering the dungeon, go straight into the Detention Block and then take the first right.
|tip Follow this path around until you can go left into a room at the back of this long hallway.
collect Prison Cell Key##11140 |q 4264
|tip You need this key to unlock Marshal Windsor's cell door.
|tip If someone else in the group already has the key you can skip this step.
|tip A Rogue can also pick the lock.
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip Leave High Interrogator Gerstahn's room and go left, then open the first Cell Door on your right.
turnin A Crumpled Up Note##4264
accept A Shred of Hope##4282
step
Inside the Blackrock Depths Dungeon:
kill General Angerforge##9033
|tip Run north through the Detention Block and unlock the East Garrison Door to enter the East Garrison.
|tip In the lower part of this room, click the Shadowforge Lock, then run up the two sets of stairs and follow the hallway on the left just before the third set of stairs.
|tip Follow the path through the hallway to reach the West Garrison.
|tip When you reach a room with stairs on your left, go down them to find General Angerforge.
collect Marshal Windsor's Lost Information##11464 |q 4282/1
step
Inside the Blackrock Depths Dungeon:
kill Golem Lord Argelmach##8983
|tip Go back up the stairs next to General Angerforge and continue north to reach The Manufactory and Golem Lord Argelmach.
collect Marshal Windsor's Lost Information##11465 |q 4282/2
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin A Shred of Hope##4282
|tip Make sure everyone turns this quest in before anyone accepts the next one.
|tip Accepting Jail Break! will start the escort quest and other party members will not be able to interact with Marshal Windsor.
accept Jail Break!##4322
step
Inside the Blackrock Depths Dungeon:
Follow and protect Marshal Windsor
|tip He will walk around the Detention Block and Halls of the Law, so clearing these beforehand can be helpful.
|tip There will be a few cells he will have you open. Sometimes you'll have to fight the prisoners or talk to a friendly NPC to free them.
|tip Eventually he will walk back to the dungeon entrance and escape.
Protect Marshal Windor During your Escape |q 4322/1
step
Leave the Blackrock Depths Dungeon
Click Here to Continue |confirm |q 4322
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Jail Break!##4322 |goto Burning Steppes/0 84.75,69.02
accept Stormwind Rendezvous##6402 |goto Burning Steppes/0 84.75,69.02
step
talk Squire Rowe##17804 |goto Stormwind City 74.24,90.26
Select _"Let Marshal Windsor know that I am ready."_
|confirm |q 6402
step
talk Reginald Windsor##12580
turnin Stormwind Rendezvous##6402 |goto Stormwind City 73.61,91.04
accept The Great Masquerade##6403 |goto Stormwind City 73.61,91.04
step
Watch the dialogue
Follow Reginald Windsor through Stormwind |goto Stormwind City 72.30,47.70 < 10 |q 6403
step
talk Reginald Windsor##12580 |goto Stormwind City 72.30,47.70
Select _"I am ready, as are my forces. Let us end this masquerade!"_
|confirm |q 6403
step
Enter the building |goto Stormwind City 73.20,46.59 < 7 |walk
Watch the dialogue
kill Onyxia's Elite Guard##12739+
|tip Inside the building.
Complete Reginald Windsor's March |q 6403/1 |goto Stormwind City 80.10,38.32
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The Great Masquerade##6403 |goto Stormwind City 80.20,38.35
accept The Dragon's Eye##6501 |goto Stormwind City 80.20,38.35
step
Follow the path up |goto Stormwind City 69.13,47.56 < 15 |only if walking
talk Tinkee Steamboil##10267
turnin Broodling Essence##4726 |goto Stormwind City 70.15,43.00
accept Felnok Steelspring##4808 |goto Stormwind City 70.15,43.00
step
talk Felnok Steelspring##10468
turnin Felnok Steelspring##4808 |goto Winterspring 61.63,38.61
accept Chillwind Horns##4809 |goto Winterspring 61.63,38.61
step
kill Chillwind Ravager##7449+
|tip They look like chimeras.
|tip They share spawn points with the bears, so kill them too.
collect 8 Uncracked Chillwind Horn##12444 |q 4809/1 |goto Winterspring 59.97,21.54
You can find more around: |notinsticky
[54.75,22.59]
[59.18,18.02]
[60.13,12.28]
[57.99,14.79]
step
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto Winterspring 61.63,38.61
accept Return to Tinkee##4810 |goto Winterspring 61.63,38.61
step
Follow the path up |goto Winterspring 59.30,43.21 < 10 |only if walking
Enter the cave |goto Winterspring 57.15,49.93 < 7 |walk
Follow the path down |goto Winterspring 54.65,49.94 < 10 |only if walking
Step onto the Blue Rune |goto Winterspring 52.65,55.78
|tip Inside the cave.
Teleport to Haleh |goto Winterspring 54.56,51.27 < 5 |noway |q 6501
step
talk Haleh##10929
turnin The Dragon's Eye##6501 |goto Winterspring 54.55,51.20
accept Drakefire Amulet##6502 |goto Winterspring 54.55,51.20
step
talk Tinkee Steamboil##10267
turnin Return to Tinkee##4810 |goto Burning Steppes 65.23,23.99
step
talk Felnok Steelspring##10468
accept Tinkee Steamboil##4907 |goto Winterspring 61.63,38.61
step
talk Tinkee Steamboil##10267
turnin Tinkee Steamboil##4907 |goto Burning Steppes 65.23,23.99
accept Egg Freezing##4734 |goto Burning Steppes 65.23,23.99
step
talk Duke Hydraxis##13278
accept Poisoned Water##6804 |goto Azshara 79.28,73.69
accept Stormers and Rumblers##6805 |goto Azshara 79.28,73.69
stickystart "Kill_15_Desert_Rumbler"
step
kill 15 Dust Stormer##11744 |q 6805/1 |goto Silithus 19.84,22.23
You can find more around:
[22.87,13.34]
[29.37,15.01]
step
label "Kill_15_Desert_Rumbler"
kill 15 Desert Rumbler##11746 |q 6805/2 |goto Silithus 19.84,22.23
You can find more around: |notinsticky
[22.87,13.34]
[29.37,15.01]
step
use the Aspect of Neptulon##17310
|tip Use it on Plague Ravagers and Blighted Surge around this area.
kill Discordant Surge##13279+
collect 12 Discordant Bracers##17309 |q 6804/1 |goto Eastern Plaguelands 54.69,67.76
step
talk Duke Hydraxis##13278
turnin Poisoned Water##6804 |goto Azshara 79.28,73.69
turnin Stormers and Rumblers##6805 |goto Azshara 79.28,73.69
accept Eye of the Emberseer##6821 |goto Azshara 79.28,73.69
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 6502
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Lower Blackrock Spire Dungeon:
kill Overlord Wyrmthalak##9568
|tip After entering the dungeon, follow the path right in the Hall of Blackhand to reach Hordemar City.
|tip Proceed across the bridges through Hordemar City and jump down into the groove in the ground where Bijou is.
|tip Jump down to the west from Bijou and follow the path west around Hordemar City, eventually heading south to reach the Skitterweb Tunnels.
|tip Follow the path up and out of the Skitterweb Tunnels to reenter the upper levels of Hordemar City.
|tip Follow the path up, kill the group of ogres and then follow the path south along the western wall through the short hallway and up the small set of stairs.
|tip Turn right twice to go up another small set of stairs.
|tip Cross this room and continue up the small set of stairs on the opposite side, continue forward to reach the Chamber of Battle.
collect General Drakkisath's Command##12780 |q 5089 |future
step
use General Drakkisath's Command##12780
accept General Drakkisath's Command##5089
step
Leave the Blackrock Spire Dungeon
Click Here to Continue |confirm |q 5089
step
talk Marshal Maxwell##9560
turnin General Drakkisath's Command##5089 |goto Burning Steppes 84.75,69.01
accept General Drakkisath's Demise##5102 |goto Burning Steppes 84.75,69.01
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 6502
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
kill Pyroguard Emberseer##9816
|tip After entering the dungeon, follow the path to the left to enter the Upper Blackrock Spire.
|tip Someone in your group must have the Seal of Ascension in order to open the door.
|tip Clear the enemies in the first room to unlock the door to the next room.
|tip Kill the Blackhand Incarcerators to release Pyroguard Emberseer.
collect Eye of the Emberseer##17322 |q 6821/1
step
Inside the Upper Blackrock Spire Dungeon:
use the Eggscilloscope Prototype##12286
|tip Use it on the eggs in The Rookery, just past Pyroguard Emberseer.
|tip Don't get too close or they will hatch if they aren't frozen.
Test the Eggscilloscope Prototype |q 4734/1
step
Inside the Upper Blackrock Spire Dungeon:
click Doomrigger's Coffer##175382
|tip At the center of The Rookery, just before the ramp.
collect Doomrigger's Clasp##12352 |q 4764/1
step
Inside the Upper Blackrock Spire Dungeon:
talk Awbee##10740
|tip Proceed through the upper level of The Rookery to reach the Hall of Blackhand.
|tip Go east in the Hall of Blackhand and jump down into the Blackrock Stadium to start the encounter.
|tip Kill the enemies that attack, then finally Gyth and Warchief Rend Blackhand.
|tip Exit the stadium to the south.
|tip It's on the ledge just past the door after the Gyth and Warchief Rend Blackhand encounter.
accept The Matron Protectorate##5160
step
Inside the Upper Blackrock Spire Dungeon:
kill The Beast##10430
|tip Head east up the stairs from Awbee and go right into The Furnace, followed by a left to reach The Beast.
collect Finkle's Skinner##12709 |n
|tip This is a rare drop and may take multiple attempts to get.
|tip If you don't have Skinning or you don't want to do this you can skip this step but you will have to skip the next quest.
use Finkle's Skinner##12709
Skin The Beast
|tip This requires level 315 Skinning to accomplish.
|tip You can achieve this with the "Enchant Gloves - Skinning" along with Finkle's Skinner equipped.
|confirm |q 5047 |future
step
Inside the Upper Blackrock Spire Dungeon:
talk Finkle Einhorn##10776
|tip He will appear after skinning The Beast.
Select _"How the hell did you get in there to begin with?"_
accept Finkle Einhorn, At Your Service!##5047
step
Leave the Blackrock Spire Dungeon
Click Here to Continue |confirm |q 4764
step
talk Tinkee Steamboil##10267
turnin Egg Freezing##4734  |goto Burning Steppes 65.23,23.99
accept Egg Collection##4735 |goto Burning Steppes 65.23,23.99
step
talk Mayara Brightwing##9565
turnin Doomrigger's Clasp##4764 |goto Burning Steppes 84.84,69.12
step
talk Marshal Maxwell##9560
turnin General Drakkisath's Demise##5102 |goto Burning Steppes 84.75,69.01
step
talk Malyfous Darkhammer##10637
turnin Finkle Einhorn, At Your Service!##5047 |goto Winterspring 60.99,38.78
step
Follow the path up |goto Winterspring 59.30,43.21 < 10 |only if walking
Enter the cave |goto Winterspring 57.15,49.93 < 7 |walk
Follow the path down |goto Winterspring 54.65,49.94 < 10 |only if walking
Step onto the Blue Rune |goto Winterspring 52.65,55.78
|tip Inside the cave.
Teleport to Haleh |goto Winterspring 54.56,51.27 < 5 |noway |q 6502
step
talk Haleh##10929
turnin Drakefire Amulet##6502 |goto Winterspring 54.55,51.20
|tip Completing this quest will award you with a Darkfire Amulet, which will allow you to enter the Onyxia's Lair raid.
|tip You must keep it in your inventory in order to enter the raid instance.
step
talk Jeziba##10976
|tip Upstairs inside the building.
turnin Wrath of the Blue Flight##5162 |goto Western Plaguelands 39.38,66.78
accept Catalogue of the Wayward##5164 |goto Western Plaguelands 39.38,66.78
step
click Catalogue of the Wayward##176192
|tip It looks like a blue book on the bedside table upstairs inside the building.
turnin Catalogue of the Wayward##5164 |goto Western Plaguelands 39.35,66.60
step
talk Duke Hydraxis##13278
turnin Eye of the Emberseer##6821 |goto Azshara 79.28,73.69
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 6502
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
use the Eggscilloscope Prototype##12286
|tip Use it on the eggs in The Rookery, just past Pyroguard Emberseer.
|tip Use it to freeze the eggs.
|tip Don't get too close or they will hatch if they aren't frozen.
use the Collectronic Module##12287
|tip Use it to collect the eggs.
collect 8 Collected Dragon Egg##12241 |q 4735/1
step
Leave the Blackrock Spire Dungeon
Click Here to Continue |confirm |q 4735
step
talk Tinkee Steamboil##10267
turnin Egg Collection##4735 |goto Burning Steppes 65.23,23.99
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackfathom Deeps Raid (25)",{
image=ZGV.IMAGESDIR.."Blackfathom Deeps",
description="This guide will walk you through the Blackfathom Deeps raid.",
hideif=not ZGV.IsClassicSoD,
},[[
step
_Inside the Blackfathom Deeps Raid:_
kill Baron Aquanis##79099
_EVERYONE_ |grouprole EVERYONE
|tip When afflicted by "Depth Charge", move into the water. |grouprole EVERYONE
|tip Return as soon as the debuff is gone. |grouprole EVERYONE
|tip Move platforms to avoid taking damage from "Thunderstorms". |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Face the baron away from the group to avoid unnecessary damage from "Bubble Beam". |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Stand behind the boss to avoid "Bubble Beam". |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Stand behind the boss to avoid "Bubble Beam". |grouprole HEALER
Click Here to Continue |confirm
step
_Inside the Blackfathom Deeps Raid:_
kill Ghamoo-Ra##201722
_EVERYONE_ |grouprole EVERYONE
|tip Avoid bubbles that appear on the floor. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Tank swap after two stacks of "Crunch Armor". |grouprole TANK
_HEALER_ |grouprole HEALER
|tip Top everyones health off when the shells are about to break. |grouprole HEALER
|tip There will be massive raid-wide damage once the shell is broken. |grouprole HEALER
Click Here to Continue |confirm
step
_Inside the Blackfathom Deeps Raid:_
kill Lady Sarevess##204068
_EVERYONE_ |grouprole EVERYONE
|tip Don't stand in frosted areas. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip The main tank should be on the boss. |grouprole TANK
|tip The off-tank should move elite mobs away from the boss. |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Focus down Lady Sarevess as the elite will despawn upon her death. |grouprole DAMAGE
Click Here to Continue |confirm
step
_Inside the Blackfathom Deeps Raid:_
kill Gelihast##204921
_EVERYONE_ |grouprole EVERYONE
|tip Avoid damage from "Shadow Crash" by not standing in the purple areas. |grouprole EVERYONE
|tip Avoid contact with the Shadow Murlocs that appear when Gelihast is at 10% health. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip The main tank should drag the boss to the center of the room. |grouprole TANK
|tip Tank swap after 2 stacks of "Shadow Strike". |grouprole TANK
Click Here to Continue |confirm
step
_Inside the Blackfathom Deeps Raid:_
kill Lorgus Jett##207356
_EVERYONE_ |grouprole EVERYONE
|tip Focus down the waves of enemies to start the fight. |grouprole EVERYONE
_DPS_ |grouprole DAMAGE
|tip Focus down elite enemies first. |grouprole DAMAGE
|tip Interrupt the Priestess' healing abilities. |grouprole DAMAGE
|tip When Lorgus Jett summons "Corrupted Lightning Shield Totem" focus it down as priority. |grouprole DAMAGE
Click Here to Continue |confirm
step
_Inside the Blackfathom Deeps Raid:_
kill Twilight Lord Kelris##209678
_EVERYONE_ |grouprole EVERYONE
|tip Avoid damage from "Shadow Crash" by not standing in the purple areas. |grouprole EVERYONE
|tip If you're afflicted by "Sleep", kill the priestess quickly and click the portal to return to the fight. |grouprole EVERYONE
_DPS_ |grouprole DAMAGE
|tip Interrupt both "Mind Blast" and "Shadowy Chains" as a priority. |grouprole DAMAGE
Click Here to Continue |confirm
step
_Inside the Blackfathom Deeps Raid:_
kill Aku'mai##213334
_TANK_ |grouprole TANK
|tip After 3 to 4 stacks of "Corrosion" drag the boss to a Cleansing Pool and stand there. |grouprole TANK
|tip Tank swap with Taunt if the current main tank has 3 to 4 stacks of "Shadow Seep". |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Don't stand in front of the boss to avoid damage from "Corrosive Blast". |grouprole DAMAGE
|tip Once the tank has 3 to 4 stacks of Corrosion, prepare to focus down the adds that spawn after they move to the Cleansing Pool. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Don't stand in front of the boss to avoid damage from "Corrosive Blast". |grouprole HEALER
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Blackfathom Deeps Raid Quests",{
image=ZGV.IMAGESDIR.."Blackfathom Deeps",
description="This guide will walk you through the Blackfathom Deeps raid quests.",
hideif=not ZGV.IsClassicSoD,
},[[
step
ding 25
step
talk Gerrig Bonegrip##2786
accept Knowledge in the Deeps##78923 |goto Ironforge 50.60,6.20
step
talk Argent Guard Manados##4784
accept Twilight Falls##78925 |goto Darnassus 55.20,23.60
step
talk Davius Voidstar##214876
accept Baron Aquanis##79099 |goto Darkshore 36.80,43.60
step
talk Gershala Nightwhisper##8997
accept Researching the Corruption##78926 |goto Darkshore 38.40,43.00
step
Jump into the water |goto Ashenvale/0 14.12,13.88 < 10 |walk
Swim underwater into the cave |goto Ashenvale/0 13.28,13.23 < 10 |walk
Follow the path |goto Ashenvale/0 13.90,10.92 < 10 |walk
Follow the path |goto Ashenvale/0 13.74,9.38 < 10 |walk
Follow the path |goto Ashenvale/0 14.37,9.20 < 10 |walk
Follow the path |goto Ashenvale/0 16.50,11.61 < 10 |walk
Enter the Blackfathom Deeps Raid with Your Group |goto Blackfathom Deeps/0 0.00,0.00 < 500 |c |q 78916 |future
stickystart "Collect_10_Twilight_Pendants"
stickystart "Collect_8_Corrupted_Brain_Stems"
step
_Inside the Blackfathom Deeps Raid:_
kill Baron Aquanis##79099
collect Strange Water Globe##211818 |q 79099/1
_EVERYONE_ |grouprole EVERYONE
|tip When afflicted by "Depth Charge", move into the water. |grouprole EVERYONE
|tip Return as soon as the debuff is gone. |grouprole EVERYONE
|tip Move platforms to avoid taking damage from "Thunderstorms". |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Face the baron away from the group to avoid unnecessary damage from "Bubble Beam". |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Stand behind the boss to avoid "Bubble Beam". |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Stand behind the boss to avoid "Bubble Beam". |grouprole HEALER
step
_Inside the Blackfathom Deeps Raid:_
click Pitted Iron Chest##13949
|tip In the northern area of Ghamoo-ra's room.
collect Lorgalis Manuscript##5359 |q 78923/1
step
_Inside the Blackfathom Deeps Raid:_
talk Argent Guard Thaelrid##4787
|tip He is stealthed by the Altar of Teleportation.
accept Blackfathom Villainy##78921
step
_Inside the Blackfathom Deeps Raid:_
kill Twilight Lord Kelris##209678
collect Head of Kelris##5881 |q 78921/1
_EVERYONE_ |grouprole EVERYONE
|tip Avoid damage from "Shadow Crash" by not standing in the purple areas. |grouprole EVERYONE
|tip If you're afflicted by "Sleep", kill the priestess quickly and click the portal to return to the fight. |grouprole EVERYONE
_DPS_ |grouprole DAMAGE
|tip Interrupt both "Mind Blast" and "Shadowy Chains" as a priority. |grouprole DAMAGE
step
_Inside the Blackfathom Deeps Raid:_
kill Aku'mai##213334
collect Perfect Blackfathom Pearl##209693 |n
use the Perfect Blackfathom Pearl##209693
accept Heart of the Void##78916
_TANK_ |grouprole TANK
|tip After 3 to 4 stacks of "Corrosion" drag the boss to a Cleansing Pool and stand there. |grouprole TANK
|tip Tank swap with Taunt if the current main tank has 3 to 4 stacks of "Shadow Seep". |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Don't stand in front of the boss to avoid damage from "Corrosive Blast". |grouprole DAMAGE
|tip Once the tank has 3 to 4 stacks of Corrosion, prepare to focus down the adds that spawn after they move to the Cleansing Pool. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Don't stand in front of the boss to avoid damage from "Corrosive Blast". |grouprole HEALER
step
label "Collect_10_Twilight_Pendants"
_Inside the Blackfathom Deeps Raid:_
Kill Twilight enemies around this area
collect 10 Twilight Pendant##5879 |q 78925/1
step
label "Collect_8_Corrupted_Brain_Stems"
_Inside the Blackfathom Deeps Raid:_
Kill enemies around this area
|tip Both Fallenroot and Blackfathom enemies drop them.
|tip They look like Naga and Satyr.
collect 8 Corrupted Brain Stem##5952 |q 78926/1
step
Leave the Blackfathom Deeps Raid
Click Here to Continue |confirm |q 78916
step
talk Dawnwatcher Selgorm##4783
turnin Heart of the Void##78916 |goto Darnassus 56.00,24.60
turnin Blackfathom Villainy##78921 |goto Darnassus 56.00,24.60
step
talk Argent Guard Manados##4784
turnin Twilight Falls##78925 |goto Darnassus 55.20,23.60
step
talk Davius Voidstar##214876
turnin Baron Aquanis##79099 |goto Darkshore 36.80,43.60
step
talk Gershala Nightwhisper##8997
turnin Researching the Corruption##78926 |goto Darkshore 38.40,43.00
step
talk Gerrig Bonegrip##2786
turnin Knowledge in the Deeps##78923 |goto Ironforge 50.60,6.20
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Gnomeregan Raid (40)",{
image=ZGV.IMAGESDIR.."Gnomeregan",
description="This guide will walk you through the Gnomeregan raid.",
hideif=not ZGV.IsClassicSoD,
},[[
step
kill Grubbis##7361
_EVERYONE_ |grouprole EVERYONE
|tip Stay out of the green gas clouds spawned by Grubbis. |grouprole EVERYONE
|tip More gas clouds spawn the longer the battle goes on. |grouprole EVERYONE
|tip Utilize Nature Protection Potions near the start of the fight and at 30% if available. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Drag adds into the green clouds that Grubbis spawns. |grouprole TANK
|tip Keep Grubbis out of the gas. |grouprole TANK
|tip Have the off-tank on Chomper. |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Focus down Chomper before moving to Grubbis. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Be ready for damage spikes between Tanks and DPS. |grouprole HEALER
Click Here to Continue |confirm
step
kill Viscous Fallout##7079
_EVERYONE_ |grouprole EVERYONE
|tip Avoid poison puddles left on the ground by the boss. |grouprole EVERYONE
|tip Coordinate cooldowns with raid in safe spots |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Save damage mitigation skills for poison attacks. |grouprole TANK
|tip Move the boss away from bindings on the ground. |grouprole TANK
|tip Also keep the boss out of gas clouds that appear. |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Kill the 3 "Irradiated Goo" that spawn before they reach the bindings as a priority. |grouprole DAMAGE
|tip Failure to kill them will spawn Desiccated Fallout. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip There will be damage spikes due to the bosses AoE attacks. |grouprole HEALER
|tip Remove Toxic effects when possible. |grouprole HEALER
Click Here to Continue |confirm
step
kill Electrocutioner 6000##6235
_EVERYONE_ |grouprole EVERYONE
|tip "Static Arc" targets the player furthest away from it. |grouprole EVERYONE
|tip Afflicted player will take 500% extra damage and the affect will bounce to the two closest players to the target. |grouprole EVERYONE
|tip Have 2 teams of 3 althernating positions for this. |grouprole EVERYONE
|tip "Static Field" targets a random player granting a debuff. |grouprole EVERYONE
|tip The target should move away from the group, but not further away fromt he boss as the alternating groups. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Soak Gnomeregan Pummel to mitigate damage for others who may get hit. |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Don't stand in front of the boss. |grouprole DAMAGE
|tip Focus down the adds that spawn throughout the fight. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Don't stand in front of the boss. |grouprole HEALER
|tip Try to heal through the Immobilizing effects inflicted throughout the fight. |grouprole HEALER
|tip At 25% health it will charge random players dealing heavy damage. |grouprole HEALER
Click Here to Continue |confirm
step
kill Crowd Pummeler 9-60##6229
_EVERYONE_ |grouprole EVERYONE
|tip For this encounter, place the groups back against the wall to avoid being knocked off the ledge. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Soak damage from "Crowd Pummel" and "Arcing Smash" to mitigate group damage. |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Don't stand in front of the boss to avoid damage from "Arcing Smash". |grouprole DAMAGE
|tip Be wary of the "Crowd Pummel's" danger area. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip AoE healing will be required during "Crowd Pummel". |grouprole HEALER
|tip However it is still important to prioritize the tank during this time. |grouprole HEALER
Click Here to Continue |confirm
step
kill Dark Iron Ambassador##6228
_TANK_ |grouprole TANK
|tip Resist the wave of Fireball and Knock Away, staying steady despite all odds. |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Avoid dealing damage while "Fire Shield II" is active. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Heal through "Fireball's" damage. |grouprole HEALER
|tip Watch the tanks position during "Knock Away" and try to keep up. |grouprole HEALER
Click Here to Continue |confirm
step
Defeat the Menagerie
_EVERYONE_ |grouprole EVERYONE
|tip The enemies must all die at the same time or they will keep respawning. |grouprole EVERYONE
|tip Avoid "STX-13/LL" (the sheep) during the encounter as it stuns anyone near it. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip The Main Tank picks up "STX-25/NB" (squirrel) as well as "STX-37CN" (chicken). |grouprole TANK
|tip The Off-Tank picks up "STX-04/BD" (dragon). |grouprole TANK
|tip Announce when Flame Breath is about to go off so people can avoid it. |grouprole TANK
_DPS_ |grouprole DAMAGE
|tip Avoid STX-04/BD's Flame Breath. |grouprole DAMAGE
|tip Prioritize DPS on the egg that STX-37CN (chicken) spawns. |grouprole DAMAGE
|tip Interrupt STX-25/NB's (squirrel) "Widget Volley" as it is cast. |grouprole DAMAGE
|tip Casters should utilize the red buttons on the pillars every 30 seconds to swap health for mana. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip Avoid STX-04/BD's Flame Breath. |grouprole HEALER
step
kill STX-96/FR##
kill Mekgineer Thermaplugg##7800
|tip Jumps out after STX-96/FR is defeated and needs to be killed.
_Phase 1 (Fire)_
_TANK_ |grouprole TANK
|tip Furnace Surge channels for 3 seconds causing "Sprocketfire". |grouprole TANK
|tip This stacks on the main tank. |grouprole TANK
|tip Tank-swap when the stacks are high. |grouprole TANK
|tip Run away from the boss during the cast time. |grouprole TANK
_Phase 2 (Frost)_
_EVERYONE_ |grouprole EVERYONE
|tip Every "Cooling Discharge" cast applies a stack of Freezing. |grouprole EVERYONE
|tip "Freezing" stacks and will freeze a player after 11. |grouprole EVERYONE
|tip Avoid Frost patches as the apply stacks of Freezing. |grouprole EVERYONE
|tip "Free Action Potions" work to remove the stacks. |grouprole EVERYONE
|tip Druids can shift out of the stacks. |grouprole EVERYONE
|tip Priests can dispell the stacks. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip The boss applies the Freezing debuff will be applied to the main tank. |grouprole TANK
_Phase 3 (Nature)_
_EVERYONE_ |grouprole EVERYONE
|tip Interrupt "Toxic Ventilation" when it happens. |grouprole EVERYONE
|tip It won't have a cast bar. |grouprole EVERYONE
|tip It's an AoE attack that applies "Radiation Sickness" which increases nature damage taken. |grouprole EVERYONE
|tip It can be dispelled. |grouprole EVERYONE
|tip Avoid green clouds on the ground caused by bombs blowing up as they will apply stacks. |grouprole EVERYONE
_Phase 4_
_EVERYONE_ |grouprole EVERYONE
|tip During this phase, the boss will use all of the abilities from the previous 3 phases. |grouprole EVERYONE
Click Here to Continue |confirm
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Gnomeregan Raid Quests",{
image=ZGV.IMAGESDIR.."Gnomeregan",
description="This guide will walk you through the Gnomeregan raid quests.",
hideif=not ZGV.IsClassicSoD,
},[[
step
ding 40
step
talk Mathiel##6142
accept Klockmort's Essentials##80135 |goto Darnassus/0 59.50,45.38
step
talk Brother Sarno##7917
|tip Inside the building.
accept Tinkmaster Overspark##80138 |goto Stormwind City/0 51.06,48.40
step
talk Shoni the Shilent##6579
accept Gyrodrillmatic Excavationators##80181 |goto Stormwind City/0 62.63,34.11
step
talk Klockmort Spannerspan##6169
turnin Klockmort's Essentials##80135 |goto Ironforge/0 67.91,46.11
accept Essential Artificials##80136 |goto Ironforge/0 67.91,46.11
step
talk Tinkmaster Overspark##7944
turnin Tinkmaster Overspark##80138 |goto Ironforge/0 69.54,50.33
accept Save Techbot's Brain!##80137 |goto Ironforge/0 69.54,50.33
step
talk High Tinker Mekkatorque##7937
accept The Grand Betrayal##80180 |goto Ironforge/0 68.73,48.96
step
Enter the building |goto Dun Morogh/0 45.96,48.84
talk Ozzie Togglevolt##1268
|tip Inside the building.
accept Gnogaine##80139 |goto Dun Morogh/0 45.89,49.38
step
Kill Iradiated enemies outside the Gnomeregan Instance
|tip They will be glowing bright green.
use the Empty Leaden Collection Phial##9283
|tip You can use it on glowing green corpses or when their hands glow green and are casting on you.
collect Full Leaden Collection Phial##9284 |q 80139/1 |goto Dun Morogh/0 21.75,34.29
step
kill Techbot##216666
|tip In the area just before Gnomeregan.
|tip Instead of turning left, head straight to a circular platform.
|tip It has a potentially long respawn timer.
collect Techbot's  Memory Core##9277 |q 80137/1 |goto Dun Morogh/0 21.84,32.09
step
Enter the building |goto Dun Morogh/0 45.96,48.84
talk Ozzie Togglevolt##1268
|tip Inside the building.
turnin Gnogaine##80139 |goto Dun Morogh/0 45.89,49.38
step
talk Tinkmaster Overspark##7944
turnin Save Techbot's Brain!##80137 |goto Ironforge/0 69.54,50.33
step
Enter the building |goto Dun Morogh/0 24.31,39.80 < 7 |walk
Ride the elevator down |goto Dun Morogh/0 23.42,39.16 < 10 |walk
Follow the path |goto Dun Morogh/0 20.33,35.95 < 10 |walk
Follow the path |goto Dun Morogh/0 19.02,39.08 < 10 |walk
Enter the Gnomeregan Dungeon with Your Group |goto Gnomeregan/0 0.00,0.00 < 500 |c |q 80324
stickystart "Collect_12_Essential_Artificials"
stickystart "Collect_3_Grime-Encrusted_Objects"
stickystart "Collect_Grime-Encrusted_Ring"
step
label "Collect_24_Robo-mechanical_Guts"
collect 24 Robo-mechanical Guts##9309 |q 80181
|tip These drop from enemies throughout the instance.
step
label "Collect_12_Essential_Artificials"
click Artificial Extrapolator##142344+
collect 12 Essential Artificial##9278 |q 80136/1
|tip They look like large rectangular boxes found throughout Gnomeregan.
|tip Check around Crowd Pummeler 9-60 and Electrocutioner 6000.
step
label "Collect_3_Grime-Encrusted_Objects"
collect 3 Grime-Encrusted Object##9308+ |q 80158 |future
step
label "Collect_Grime-Encrusted_Ring"
Kill Dark Iron Enemies around this area
|tip They look like dwarves.
collect Grime-Encrusted Ring##9326 |n
use the Grime-Encrusted Ring##9326
accept Grime-Encrusted Ring##79986
step
click The Sparklematic 5200##142487
|tip It's in the Clean Room area.
turnin Grime-Encrusted Ring##79986
step
click The Sparklematic 5200##142487
|tip It's in the Clean Room area.
|tip These require Grime-Encrusted objects to complete.
accept The Sparklematic 5200!##80153 |or
accept The Sparklematic 5200!##80158 |or
accept The Sparklematic 5200!##80157 |or
step
click The Sparklematic 5200##142487
|tip It's in the Clean Room area.
|tip These require Grime-Encrusted objects to complete.
accept The Sparklematic 5200!##80153 |or 2
accept The Sparklematic 5200!##80158 |or 2
accept The Sparklematic 5200!##80157 |or 2
step
click The Sparklematic 5200##142487
|tip It's in the Clean Room area.
|tip These require Grime-Encrusted objects to complete.
accept The Sparklematic 5200!##80153 |or 3
accept The Sparklematic 5200!##80158 |or 3
accept The Sparklematic 5200!##80157 |or 3
step
kill STX-96/FR##218538
kill Mekgineer Thermaplugg##7800 |q 80180/1
|tip Jumps out after STX-96/FR is defeated and needs to be killed.
collect Thermaplugg's Engineering Notes##217350 |q 80324 |future
_Phase 1 (Fire)_
_TANK_ |grouprole TANK
|tip Furnace Surge channels for 3 seconds causing "Sprocketfire". |grouprole TANK
|tip This stacks on the main tank. |grouprole TANK
|tip Tank-swap when the stacks are high. |grouprole TANK
|tip Run away from the boss during the cast time. |grouprole TANK
_Phase 2 (Frost)_
_EVERYONE_ |grouprole EVERYONE
|tip Every "Cooling Discharge" cast applies a stack of Freezing. |grouprole EVERYONE
|tip "Freezing" stacks and will freeze a player after 11. |grouprole EVERYONE
|tip Avoid Frost patches as the apply stacks of Freezing. |grouprole EVERYONE
|tip "Free Action Potions" work to remove the stacks. |grouprole EVERYONE
|tip Druids can shift out of the stacks. |grouprole EVERYONE
|tip Priests can dispell the stacks. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip The boss applies the Freezing debuff will be applied to the main tank. |grouprole TANK
_Phase 3 (Nature)_
_EVERYONE_ |grouprole EVERYONE
|tip Interrupt "Toxic Ventilation" when it happens. |grouprole EVERYONE
|tip It won't have a cast bar. |grouprole EVERYONE
|tip It's an AoE attack that applies "Radiation Sickness" which increases nature damage taken. |grouprole EVERYONE
|tip It can be dispelled. |grouprole EVERYONE
|tip Avoid green clouds on the ground caused by bombs blowing up as they will apply stacks. |grouprole EVERYONE
_Phase 4_
_EVERYONE_ |grouprole EVERYONE
|tip During this phase, the boss will use all of the abilities from the previous 3 phases. |grouprole EVERYONE
step
use Thermaplugg's Engineering Notes##217350
accept The Mad King##80324
step
talk Kernobee##7850
|tip He can be found in the Dormitory area in the room at the North facing wall.
|tip He will follow you and can be killed by enemies, so it may be best to clear the area before accepting.
|tip Try clicking the chat bubble to target him.
|tip This quest is allegedly bugged and not giving credit for completion.
accept A Fine Mess##79985
step
Escort Kernobee out of Gnomeregan |q 79985/1
|tip This quest can be buggy.
|tip You may not get credit even though you complete the objective.
step
Enter the building |goto Dun Morogh/0 45.96,48.84
talk Ozzie Togglevolt##1268
|tip Inside the building.
turnin Gnogaine##80139 |goto Dun Morogh/0 45.89,49.38
step
talk Klockmort Spannerspan##6169
turnin Essential Artificials##80136 |goto Ironforge/0 67.91,46.11
step
talk High Tinker Mekkatorque##7937
turnin The Grand Betrayal##80180 |goto Ironforge/0 68.73,48.96
turnin The Mad King##80324 |goto Ironforge/0 68.73,48.96
step
talk Shoni the Shilent##6579
turnin Gyrodrillmatic Excavationators##80181 |goto Stormwind City/0 62.63,34.11
step
talk Scooty##7853
turnin A Fine Mess##79985 |goto Stranglethorn Vale 27.60,77.48
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Blackwing Lair Attunement",{
description="This guide will walk you through becoming attuned for the Blackwing Lair raid.",
hideif=ZGV.IsClassicSoM,
},[[
step
Reach level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Follow the path up |goto Searing Gorge/0 48.83,63.66 < 5 |walk
Enter the building |goto Searing Gorge/0 48.91,63.92 < 5 |walk
Follow the path |goto Searing Gorge/0 48.95,63.93 < 5 |walk
Follow the path down |goto Searing Gorge/0 49.01,64.12 < 5 |walk
kill Scarshield Quartermaster##9046
|tip He walks around this area.
collect Blackhand's Command##18987 |goto Searing Gorge/0 49.12,64.10 |complete itemcount(18987) == 1 or haveq(7761) or completedq(7761)
step
use Blackhand's Command##18987
accept Blackhand's Command##7761
step
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |q 7761
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
kill General Drakkisath##10363
|tip Use the Dungeon guides to accomplish this.
click Drakkisath's Brand##179880
|tip It looks like a large glowing blue totem behind General Drakkisath.
turnin Blackhand's Command##7761
|tip Turning this in will allow you to teleport directly to Blackwing Lair by clicking the Orb of Command.
|tip It is located down the southern hallway outside of the dungeon entrance.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Molten Core Attunement",{
description="This guide will walk you through becoming attuned for the Molten Core raid.",
},[[
step
Reach level 55 |ding 55
|tip Use the Leveling guides to accomplish this.
step
Run down the chain |goto Searing Gorge/0 37.25,94.39 < 5 |walk
Enter the building |goto Searing Gorge/0 35.91,100.22 < 7 |c
step
Continue down and run down the chain |goto Searing Gorge/0 34.86,99.20 < 5 |walk
talk Lothos Riftwaker##14387
accept Attunement to the Core##7848 |goto Searing Gorge/0 48.41,63.82
step
Follow the path |goto Searing Gorge/0 26.88,83.87 < 30 |walk
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c |q 7848
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
Reach the room with Lord Incendius
|tip The fastest way to reach him is to pick the locked door to the left after entering the dungeon.
|tip Continue straight through the Detention Block and into the Dark Iron Hallway.
|tip Follow the path north east through the Dark Iron Hallway and through the Shadowforge City.
|tip If you are doing a normal dungeon run you can use the Dungeon guides to accomplish this.
Jump down from Lord Incendius' platform and into the lava below
Hug the left side of the room and you'll be able to swim from the lava up onto a small section of land
Follow this left wall as far as you can, after a short while you'll have to swim through lava
You'll pass a small island with Fireguard Destroyers on it and then past them will be a bridge
Follow the path up and across the bridge, killing the addional Fireguard Destroyers
On the left side of the bridge, before the green portal is the Core Fragment
click Core Fragment##179553
collect Core Fragment##18412 |q 7848/1
step
talk Lothos Riftwaker##14387
turnin Attunement to the Core##7848 |goto Blackrock Depths/0 48.41,63.82
|tip Turning this in will allow you to teleport directly to Molten Core by talking to Lothos Riftwaker.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Onyxia's Lair Attunement",{
description="This guide will walk you through becoming attuned for the Onyxia's Lair raid.",
},[[
step
Reach level 48 |ding 48
|tip Use the Leveling guides to accomplish this.
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Helendis Riverhorn##9562
accept Dragonkin Menace##4182 |goto Burning Steppes/0 85.82,68.95
stickystart "Slay_Black_Dragonspawns"
stickystart "Slay_Black_Drake"
stickystart "Slay_Black_Wrymkins"
step
kill 15 Black Broodling##7047 |q 4182/1 |goto Burning Steppes/0 89.18,53.85
You can find more around [91.51,35.35]
step
label "Slay_Black_Dragonspawns"
kill 10 Black Dragonspawn##7040 |q 4182/2 |goto Burning Steppes/0 92.05,53.82
|tip These enemies are Elite, you may need a group to complete this.
You can find more around: |notinsticky
[88.72,37.56]
[84.45,27.50]
step
label "Slay_Black_Drake"
kill 1 Black Drake##7044 |q 4182/3 |goto Burning Steppes/0 89.18,53.85
|tip These enemies are Elite, you may need a group to complete this.
You can find more around [91.51,35.35]
step
label "Slay_Black_Wrymkins"
kill 4 Black Wyrmkin##7041 |q 4182/4 |goto Burning Steppes/0 92.05,53.82
|tip These enemies are Elite, you may need a group to complete this.
You can find more around: |notinsticky
[88.72,37.56]
[84.45,27.50]
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Helendis Riverhorn##9562
turnin Dragonkin Menace##4182 |goto Burning Steppes/0 85.82,68.95
accept The True Masters##4183 |goto Burning Steppes/0 85.82,68.95
step
Enter the building |goto Redridge Mountains 24.42,46.07 < 5 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4183 |goto Redridge Mountains 24.89,44.45
accept The True Masters##4184 |goto Redridge Mountains 24.89,44.45
step
Enter the building |goto Stormwind City 73.21,46.56 < 7 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4184 |goto Stormwind City 80.20,38.35
accept The True Masters##4185 |goto Stormwind City 80.20,38.35
step
talk Lady Katrana Prestor##1749
|tip Inside the building.
Select _"Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice."_
|tip Click through the dialogue.
Receive Advice From Lady Prestor |q 4185/1 |goto Stormwind City 80.10,38.17
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4185 |goto Stormwind City 80.20,38.35
accept The True Masters##4186 |goto Stormwind City 80.20,38.35
step
Enter the building |goto Redridge Mountains 24.42,46.07 < 5 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4186 |goto Redridge Mountains 24.89,44.45
accept The True Masters##4223 |goto Redridge Mountains 24.89,44.45
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4223 |goto Burning Steppes/0 84.75,69.02
accept The True Masters##4224 |goto Burning Steppes/0 84.75,69.02
step
Follow the path up |goto Burning Steppes/0 63.86,30.11 < 10 |only if walking
talk Ragged John##9563
Select _"Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him."_
|tip Click through the dialogue.
Hear Ragged John's Story |q 4224/1 |goto Burning Steppes/0 65.02,23.76
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4224 |goto Burning Steppes/0 84.75,69.02
accept Marshal Windsor##4241 |goto Burning Steppes/0 84.75,69.02
step
Run down the chain |goto Searing Gorge/0 37.25,94.39 < 5 |walk
Enter the building |goto Searing Gorge/0 35.91,100.22 < 7 |c
step
Continue down and run down the chain |goto Searing Gorge/0 34.86,99.20 < 5 |walk
Enter the building |goto Searing Gorge/0 32.55,94.94 < 5 |walk
Follow the path |goto Searing Gorge/0 26.88,83.87 < 30 |walk
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c |q 4241
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
|tip She is the fourth boss in the dungeon.
|tip Use the Dungeon guides to accomplish this.
collect Prison Cell Key##11140 |q 4241
|tip You need this key to unlock Marshal Windsor's cell door.
|tip If someone else in the group already has the key you can skip this step.
|tip A Rogue can also pick the lock.
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin Marshal Windsor##4241
accept Abandoned Hope##4242
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Abandoned Hope##4242 |goto Burning Steppes/0 84.75,69.02
step
Reach level 50 |ding 50
|tip Use the Leveling guides to accomplish this.
step
Run down the chain |goto Searing Gorge/0 37.25,94.39 < 5 |walk
Enter the building |goto Searing Gorge/0 35.91,100.22 < 7 |c
step
Continue down and run down the chain |goto Searing Gorge/0 34.86,99.20 < 5 |walk
Enter the building |goto Searing Gorge/0 32.55,94.94 < 5 |walk
Follow the path |goto Searing Gorge/0 26.88,83.87 < 30 |walk
Enter the Blackrock Depths Dungeon with Your Group |goto Blackrock Depths/0 0.00,0.00 < 500 |c |q 4264 |future
|tip This quest requires you to progress through the Blackrock Depths dungeon.
|tip You will likely need a full group to complete the quest.
step
Inside the Blackrock Depths Dungeon:
Kill Anvilrage dwarves at the beginning of the dungeon
|tip Just clear the first few rooms of the dungeon, killing all the Anvilrage dwarves and resetting the instance if needed, until you get the item drop.
collect A Crumpled Up Note##11446 |complete itemcount(11446) == 1 or haveq(4264) or completedq(4264)
step
use A Crumpled Up Note##11446
accept A Crumpled Up Note##4264
step
Inside the Blackrock Depths Dungeon:
kill High Interrogator Gerstahn##9018
|tip She is the fourth boss in the dungeon.
|tip Use the Dungeon guides to accomplish this.
collect Prison Cell Key##11140 |q 4264
|tip You need this key to unlock Marshal Windsor's cell door.
|tip If someone else in the group already has the key you can skip this step.
|tip A Rogue can also pick the lock.
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin A Crumpled Up Note##4264
accept A Shred of Hope##4282
step
Inside the Blackrock Depths Dungeon:
kill General Angerforge##9033
|tip Use the Dungeon guides to accomplish this.
collect Marshal Windsor's Lost Information##11464 |q 4282/1
step
Inside the Blackrock Depths Dungeon:
kill Golem Lord Argelmach##8983
|tip Use the Dungeon guides to accomplish this.
collect Marshal Windsor's Lost Information##11465 |q 4282/2
step
Inside the Blackrock Depths Dungeon:
talk Marshal Windsor##9023
|tip He is in a prison cell inside the Detention Block.
|tip After entering the dungeon enter the first room and then take the third tunnel on the right.
|tip If you enter the Halls of the Law you went too far.
turnin A Shred of Hope##4282
|tip Make sure everyone turns this quest in before anyone accepts the next one.
|tip Accepting Jail Break! will start the escort quest and other party members will not be able to interact with Marshal Windsor.
accept Jail Break!##4322
step
Inside the Blackrock Depths Dungeon:
Follow and protect Marshal Windsor
|tip He will walk around the Detention Block and Halls of the Law, so clearing these beforehand can be helpful.
|tip There will be a few cells he will have you open. Sometimes you'll have to fight the prisoners or talk to a friendly NPC to free them.
|tip Eventually he will walk back to the dungeon entrance and escape.
Jail Break! |q 4322/1
step
Follow the path up |goto Burning Steppes/0 82.89,63.37 < 7 |only if walking
talk Marshal Maxwell##9560
turnin Jail Break!##4322 |goto Burning Steppes/0 84.75,69.02
accept Stormwind Rendezvous##6402 |goto Burning Steppes/0 84.75,69.02
step
talk Squire Rowe##17804 |goto Stormwind City 74.24,90.26
Select _"Let Marshal Windsor know that I am ready."_
|confirm |q 6402
step
talk Reginald Windsor##12580
turnin Stormwind Rendezvous##6402 |goto Stormwind City 73.61,91.04
accept The Great Masquerade##6403 |goto Stormwind City 73.61,91.04
step
Watch the dialogue
Follow Reginald Windsor through Stormwind |goto Stormwind City 72.30,47.70 < 10 |q 6403
step
talk Reginald Windsor##12580 |goto Stormwind City 72.30,47.70
Select _"I am ready, as are my forces. Let us end this masquerade!"_
|confirm |q 6403
step
Enter the building |goto Stormwind City 73.20,46.59 < 7 |walk
Watch the dialogue
kill Onyxia's Elite Guard##12739+
|tip Inside the building.
Complete Reginald Windsor's March |q 6403/1 |goto Stormwind City 80.10,38.32
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The Great Masquerade##6403 |goto Stormwind City 80.20,38.35
accept The Dragon's Eye##6501 |goto Stormwind City 80.20,38.35
step
Follow the path up |goto Winterspring 59.30,43.21 < 10 |only if walking
Enter the cave |goto Winterspring 57.15,49.93 < 7 |walk
Follow the path down |goto Winterspring 54.65,49.94 < 10 |only if walking
Step onto the Blue Rune |goto Winterspring 52.65,55.78
|tip Inside the cave.
Teleport to Haleh |goto Winterspring 54.56,51.27 < 5 |noway |q 6501
step
talk Haleh##10929
turnin The Dragon's Eye##6501 |goto Winterspring 54.55,51.20
accept Drakefire Amulet##6502 |goto Winterspring 54.55,51.20
step
Run up the chain |goto Searing Gorge/0 37.25,94.29 < 5 |walk
Jump down here |goto Searing Gorge/0 37.79,92.44 < 5 |walk
Jump to the balcony |goto Searing Gorge/0 39.72,95.58 < 5 |walk
Enter the Blackrock Spire Dungeon with Your Group |goto Blackrock Spire/0 0.00,0.00 < 500 |c |q 6502
|tip This quest requires you to progress through the Upper Blackrock Spire dungeon.
|tip You will likely need a 10 person raid group to complete the quest.
step
Inside the Upper Blackrock Spire Dungeon:
kill General Drakkisath##10363
|tip Use the Dungeon guides to accomplish this.
collect Blood of the Black Dragon Champion##16663 |q 6502/1
step
Follow the path up |goto Winterspring 59.30,43.21 < 10 |only if walking
Enter the cave |goto Winterspring 57.15,49.93 < 7 |walk
Follow the path down |goto Winterspring 54.65,49.94 < 10 |only if walking
Step onto the Blue Rune |goto Winterspring 52.65,55.78
|tip Inside the cave.
Teleport to Haleh |goto Winterspring 54.56,51.27 < 5 |noway |q 6502
step
talk Haleh##10929
turnin Drakefire Amulet##6502 |goto Winterspring 54.55,51.20
|tip Completing this quest will award you with a Darkfire Amulet, which will allow you to enter the Onyxia's Lair raid.
|tip You must keep it in your inventory in order to enter the raid instance.
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Raid Attunements\\Naxxramas Attunement",{
description="This guide will walk you through becoming attuned for the Naxxramas raid.",
hideif=ZGV.IsClassicSoM,
},[[
step
Reach level 60 |ding 60
|tip Use the Leveling guides to accomplish this.
step
talk Archmage Angela Dosantos##16116
|tip Inside the building.
accept The Dread Citadel - Naxxramas##9121 |goto Eastern Plaguelands 71.71,48.70 |only if rep("Argent Dawn") < Revered or completedq(9121)
accept The Dread Citadel - Naxxramas##9122 |goto Eastern Plaguelands 71.71,48.70 |only if rep("Argent Dawn") == Revered or completedq(9122)
accept The Dread Citadel - Naxxramas##9123 |goto Eastern Plaguelands 71.71,48.70 |only if rep("Argent Dawn") == Exalted or completedq(9123)
stickystart "Collect_Nexus_Crystals"
stickystart "Collect_1_Righteous_Orb"
stickystart "Reach_Honored_Reputation"
step
collect 5 Arcane Crystal##12363 |q 9121/1 |only if haveq(9121) or completedq(9121)
collect 3 Arcane Crystal##12363 |q 9122/1 |only if haveq(9122) or completedq(9122)
|tip Farm them from Rich Thorium Veins with Mining or purchase them from the Auction House.
step
label "Collect_Nexus_Crystals"
collect 2 Nexus Crystal##20725 |q 9121/2 |only if haveq(9121) or completedq(9121)
collect 1 Nexus Crystal##20725 |q 9122/2 |only if haveq(9122) or completedq(9122)
|tip Disenchant them from epic items with Enchanting or purchase them from the Auction House.
step
label "Collect_1_Righteous_Orb"
collect 1 Righteous Orb##12811 |q 9121/3
|tip Farm it from Crimson Elites in Western Plaguelands, Crimson mobs in Stratholme Live, or purchase it from the Auction House.
|only if haveq(9121) or completedq(9121)
step
label "Reach_Honored_Reputation"
Reach Honored Reputation with the Argent Dawn |q 9121/4
|only if haveq(9121) or completedq(9121)
step
talk Archmage Angela Dosantos##16116
|tip Inside the building.
turnin The Dread Citadel - Naxxramas##9121 |goto Eastern Plaguelands 71.71,48.70 |only if haveq(9121) or completedq(9121)
turnin The Dread Citadel - Naxxramas##9122 |goto Eastern Plaguelands 71.71,48.70 |only if haveq(9122) or completedq(9122)
turnin The Dread Citadel - Naxxramas##9123 |goto Eastern Plaguelands 71.71,48.70 |only if haveq(9123) or completedq(9123)
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Sunken Temple Raid Quests (25)",{
image=ZGV.IMAGESDIR.."The Temple of Atal'Hakkar",
description="This guide will walk you through the Sunken Temple raid quests.",
hideif=not ZGV.IsClassicSoD,
},[[
step
ding 50
step
talk Maginor Dumas##331
|tip Upstairs inside the building.
accept Magecraft##8250 |goto Stormwind City 49.24,87.78
|only if Mage
step
talk Lord Grayson Shadowbreaker##928
|tip Inside the building.
accept Chillwind Point##8415 |goto Stormwind City 48.41,50.16
|only if Paladin
step
talk Brother Joshua##5489
|tip Inside the building.
accept Cenarion Aid##8254 |goto Stormwind City 49.70,44.86
|only if Priest
step
talk Lord Tony Romano##13283
|tip Inside the building.
accept A Simple Request##8233 |goto Stormwind City 80.28,68.57
|only if Rogue
step
Enter the building |goto Stormwind City 42.17,81.88 < 8 |walk
talk Demisette Cloyce##461
|tip Inside the building.
accept An Imp's Request##8419 |goto Stormwind City 39.25,84.97
|only if Warlock
step
Enter the building |goto Stormwind City 80.00,61.72 < 7 |walk
talk Wu Shen##5479
|tip Upstairs inside the building.
accept A Troubled Spirit##8417 |goto Stormwind City 80.55,59.87
|only if Warrior
step
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
accept Torwa Pathfinder##9063|goto Darnassus 35.38,8.41
|only if NightElf Druid
step
talk Dorion##4205
|tip Upstairs inside the building.
accept The Hunter's Charm##8151 |goto Darnassus 42.21,7.26
|only if Hunter
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
[34.600,30.600]
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
talk Sanath Lim-yo##8395
turnin Magecraft##8250 |goto Azshara 28.11,50.09
|only if Mage
step
talk Archmage Xylem##8379
|tip Inside the tower.
accept Magic Dust##8251 |goto Azshara 28.11,50.09
step
Kill Blood Elf enemies around this area
collect 10 Glittering Dust##20028 |q 8251/1 |goto Azshara 56.94,29.30
|only if Mage
step
talk Sanath Lim-yo##8395
accept Meeting with the Master##3503 |goto Azshara 28.11,50.09
|only if Mage
step
talk Archmage Xylem##8379
|tip Inside the tower.
turnin Magic Dust##8251 |goto Azshara 28.11,50.09
accept The Siren's Coral##8252 |goto Azshara 28.11,50.09
|only if Mage
step
kill Spitelash Siren##6195+
collect 6 Enchanted Coral##20029 |q 8252/1 |goto Azshara 47.65,43.93
You can find more around: |notinsticky
[46.76,53.80]
[48.51,64.11]
|only if Mage
step
talk Sanath Lim-yo##8395
accept Meeting with the Master##3503 |goto Azshara 28.11,50.09
|only if Mage
step
talk Archmage Xylem##8379
|tip Inside the tower.
turnin The Siren's Coral##8252 |goto Azshara 28.11,50.09
accept Destroy Morphaz##8253 |goto Azshara 28.11,50.09
|only if Mage
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
talk Impsy##14470
turnin An Imp's Request##8419 |goto Felwood 41.36,45.02
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
Enter the building |goto Stormwind City 68.89,42.12 < 8 |walk
talk Brohann Caskbelly##5384
accept In Search of The Temple##1448 |goto Stormwind City 69.44,40.43
step
Search for the Temple of Atal'Hakkar |q 1448/1 |goto Swamp of Sorrows 66.82,59.39
step
Enter the building |goto Stormwind City 68.89,42.12 < 8 |walk
talk Brohann Caskbelly##5384
turnin In Search of The Temple##1448 |goto Stormwind City 69.44,40.43
accept To The Hinterlands##1449 |goto Stormwind City 69.44,40.43
step
talk Falstad Wildhammer##5635
turnin To The Hinterlands##1449 |goto The Hinterlands 11.81,46.76
accept Gryphon Master Talonaxe##1450 |goto The Hinterlands 11.81,46.76
step
Run up the ramp |goto The Hinterlands 11.75,46.90 < 10 |only if walking
Enter the building |goto The Hinterlands 11.00,45.68 < 10 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin Gryphon Master Talonaxe##1450 |goto The Hinterlands 9.75,44.48
accept Rhapsody Shindigger##1451 |goto The Hinterlands 9.75,44.48
step
Follow the path up |goto The Hinterlands 21.02,47.81 < 15 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody Shindigger##1451 |goto The Hinterlands 26.94,48.59
accept Rhapsody's Kalimdor Kocktail##1452 |goto The Hinterlands 26.94,48.59
step
Kill Roc enemies around this area
collect 3 Roc Gizzard##6257 |q 1452/1 |goto Tanaris 43.48,40.36
step
Enter the building |goto Feralas 31.84,45.02 < 5 |walk
talk Angelas Moonbreeze##7900
accept The Sunken Temple##3445 |goto Feralas 31.83,45.61
step
Kill Ironfur enemies around this area
|tip They share a spawn with Groddoc enemies around this area.
collect 3 Ironfur Liver##6258 |q 1452/2 |goto Feralas 49.93,30.39
You can find more around [46.20,25.09]
step
Kill Groddoc enemies around this area
|tip They share a spawn with Ironfur enemies around this area.
collect 3 Groddoc Liver##6259 |q 1452/3 |goto Feralas 49.93,30.39
You can find more around [46.20,25.09]
step
Follow the path up |goto The Hinterlands 21.02,47.81 < 15 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody's Kalimdor Kocktail##1452 |goto The Hinterlands 26.94,48.59
Watch the Dialogue
accept Rhapsody's Tale##1469 |goto The Hinterlands 26.94,48.59
step
Enter the building |goto Stormwind City 68.93,42.08 < 8 |walk
talk Brohann Caskbelly##5384
|tip Inside the building.
turnin Rhapsody's Tale##1469 |goto Stormwind City 69.45,40.41
accept Into The Temple of Atal'Hakkar##82098 |goto Stormwind City 69.45,40.41
step
talk Marvon Rivetseeker##7771
turnin The Sunken Temple##3445 |goto Tanaris 52.71,45.92
accept The Stone Circle##3444 |goto Tanaris 52.71,45.92
step
click Marvon's Chest
collect Stone Circle##10556 |q 3444/1 |goto The Barrens 62.50,38.54
step
talk Marvon Rivetseeker##7771
turnin The Stone Circle##3444 |goto Tanaris 52.71,45.92
accept Into the Depths##3446 |goto Tanaris 52.71,45.92
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto Tanaris 66.98,22.36
step
kill Vale Screecher##5307+
|tip These have a low spawn rate.
use Yeh'Kinya's Bramble##10699
|tip Use it on their corpse.
talk Screecher Spirit##8612+
Collect 3 Screecher Spirits |q 3520/1 |goto Feralas 58.31,57.70
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto Tanaris 66.98,22.36
accept The Prophecy of Mosh'aru##3527 |goto Tanaris 66.98,22.36
step
Enter the Zul'Farrak Dungeon with Your Group |goto Zul'Farrak/0 0.00,0.00 < 555 |c |q 3527 |future
|tip You may need help with this quest.
step
Inside the Zul'Farrak Dungeon:
kill Theka the Martyr##7272
|tip Follow the path north and then go right when the path splits.
|tip Quickly go left afterwards and then north.
|tip He is the second boss of the dungeon.
|tip You may need help with this.
collect First Mosh'aru Tablet##10660 |q 3527/1
step
Inside the Zul'Farrak Dungeon:
kill Hydromancer Velratha##7795
|tip Follow the path west to reach an open room with a large pyramid on the western side.
|tip Continue following the path southeast to reach the large room with a pool in the center.
|tip She walks around this area.
|tip You may need help with this.
collect Second Mosh'aru Tablet##10661 |q 3527/2
step
Leave the Zul'Farrak Dungeon
Click Here to Continue |confirm |q 3527 |future
step
talk Yeh'kinya##8579
turnin The Prophecy of Mosh'aru##3527 |goto Zul'Farrak/0 66.98,22.36
accept The Ancient Egg##4787 |goto Zul'Farrak/0 66.98,22.36
step
Follow the path |goto The Hinterlands 35.78,64.12 < 15 |only if walking
Run up the stairs |goto The Hinterlands 33.09,73.80 < 15 |only if walking
Jump down here |goto The Hinterlands 33.11,75.53 < 7 |only if walking
talk Atal'ai Exile##5598
accept Jammal'an the Prophet##82104 |goto The Hinterlands 33.75,75.22
step
Follow the path |goto The Hinterlands 35.79,64.07 < 15 |only if walking
Run up the stairs |goto The Hinterlands 66.70,66.71 < 8 |only if walking
Follow the path |goto The Hinterlands 66.63,68.83 < 10 |only if walking
Run up the stairs |goto The Hinterlands 67.93,69.12 < 10 |only if walking
Follow the path |goto The Hinterlands 67.78,70.73 < 10 |q 4787
step
Run up the stairs |goto The Hinterlands 65.08,68.94 < 8 |only if walking
Follow the path |goto The Hinterlands 63.69,70.44 < 10 |only if walking
Continue following the path |goto The Hinterlands 65.38,72.92 < 10 |only if walking
Run up the stairs |goto The Hinterlands 67.14,73.37 < 8 |only if walking
Follow the path |goto The Hinterlands 67.15,75.46 < 10 |q 4787
step
Follow the path |goto The Hinterlands 64.52,74.83 < 10 |only if walking
Run up the stairs |goto The Hinterlands 62.16,71.38 < 10 |only if walking
Continue up the stairs |goto The Hinterlands 59.96,70.17 < 10 |only if walking
Follow the path |goto The Hinterlands 58.68,70.28 < 10 |only if walking
Continue following the path |goto The Hinterlands 59.15,74.30 < 10 |q 4787
step
Enter the cave |goto The Hinterlands 58.61,79.19 < 10 |walk
Follow the path down |goto The Hinterlands 58.26,82.31 < 10 |walk
Follow the path up |goto The Hinterlands 54.81,83.42 < 10 |walk
click Ancient Egg##175889
|tip Inside the cave.
|tip You may need help with this.
collect Ancient Egg##12402 |q 4787/1 |goto The Hinterlands 57.52,86.78
step
talk Yeh'kinya##8579
turnin The Ancient Egg##4787 |goto Tanaris 66.98,22.36
accept The God Hakkar##82095 |goto Tanaris 66.98,22.36
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
accept Muigin and Larion##4141 |goto Un'Goro Crater 42.94,9.65
step
label "Collect_Bloodpetals"
Kill Bloodpetal enemies around this area
|tip They look like walking plants.
collect 15 Bloodpetal##11316 |q 4141/1 |goto Un'Goro Crater 71.46,38.72
|tip These have a low drop rate.
You can find more around: |notinsticky
[69.26,24.59]
[66.08,35.13]
[55.87,34.69]
[41.91,27.10]
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
turnin Muigin and Larion##4141 |goto Un'Goro Crater 42.94,9.65
accept A Visit to Gregan##4142 |goto Un'Goro Crater 42.94,9.65
step
Follow the path up |goto Feralas 47.28,44.56 < 15 |only if walking
Follow the path |goto Feralas 48.66,44.98 < 15 |only if walking
Continue following the path |goto Feralas 47.87,36.21 < 15 |only if walking
Follow the path down |goto Feralas 48.22,32.73 < 15 |only if walking
Follow the path up |goto Feralas 45.70,25.74 < 15 |only if walking
talk Gregan Brewspewer##7775
turnin A Visit to Gregan##4142 |goto Feralas 45.12,25.56
accept Haze of Evil##82099 |goto Feralas 45.12,25.56
step
Run up the stairs |goto Swamp of Sorrows 69.31,57.06 < 10 |only if walking
Enter the Temple |goto Swamp of Sorrows 69.99,52.99 < 7
Run down the stairs |goto Swamp of Sorrows 69.58,51.44 < 7 |q 82095
step
Swim through the water |goto Swamp of Sorrows 70.22,51.69 < 7 |walk
Run up the stairs |goto Swamp of Sorrows 71.74,45.81 < 5 |walk
Run down the stairs |goto Swamp of Sorrows 72.70,42.22 < 5 |only if walking
Follow the path |goto Swamp of Sorrows 75.83,44.85 < 5 |only if walking
Continue following the path |goto Swamp of Sorrows 76.02,45.96 < 5 |q 82095
step
Follow the path |goto Swamp of Sorrows 56.89,75.91 < 5 |only if walking
click Atal'ai Tablet##37099+
|tip They look like silver stone tablets along the walls around this area.
collect 10 Atal'ai Tablet##6288 |q 82098/1 |goto Swamp of Sorrows 56.76,76.01
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
Enter The Temple of Atal'Hakkar Raid with Your Group |goto The Temple of Atal'Hakkar/0 0.00,0.00 < 500 |c |q 82095
stickystart "Collect_20_Fetish_of_Hakkar"
stickystart "Collect_5_Atal'ai_Haze"
step
Inside the Temple of Atal'Hakkar Raid:
click Atal'ai Statue##148830
|tip There are 6 of them.
|tip Enemies will spawn behind you after interacting with the statues.
|tip They can be tamed instead of fighting if you have a Lone Wolf Hunter in the group.
|tip
kill Atal'alarion##218624
_EVERYONE_ |grouprole EVERYONE
|tip The boss places pillars around the room, each pillar up buffs the boss. |grouprole EVERYONE
|tip Anyone who gets knocked back into a pillar will destroy it. |grouprole EVERYONE
|tip You can destroy the pillars with this ability however and you should prioritize doing so. |grouprole EVERYONE
|tip Always be positioned to be knocked into pillars. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Keep him faced away from the group. |grouprole TANK
|tip During "Demolishing Smash", all aggro will drop so you can tank swap if desired. |grouprole TANK
|tip Regardless, try to re-establish aggro quickly. |grouprole TANKS
_DPS_ |grouprole DAMAGE
|tip Allow the tank to re-establish aggro after each Demolishing Smash. |grouprole DAMAGE
_HEALER_ |grouprole HEALER
|tip For each pillar with dragons impaled on the, his damage will increase. |grouprole HEALER
|tip Demolishing Smash does 1500 damage to the entire raid, make sure nobody has less health than this before the cast goes off! |grouprole HEALER
collect Putrid Vine##22444 |q 9053/1 |only if NightElf Druid |or
Click Here to Continue |confirm |or
step
Inside the Temple of Atal'Hakkar Raid:
click Altar of Hakkar
|tip At the top of the stairs in The Pit of Refuse.
turnin Into the Depths##3446
accept Secret of the Circle##3447
step
Inside the Temple of Atal'Hakkar Raid:
click Idol of Hakkar##148838
|tip In the center of the room in The Pit of Refuse.
turnin Secret of the Circle##3447
step
Inside the Temple of Atal'Hakkar Raid:
kill Atal'ai Defenders Controller##221732 Controller##221732s
_EVERYONE_ |grouprole EVERYONE
|tip This is a gauntlet style fight. |grouprole EVERYONE
|tip Enemies will appear one at a time. |grouprole EVERYONE
|tip When one is killed, they will be turned into an unkillable ghost that needs to be CC'd by either a Priest or a Hunter. |grouprole EVERYONE
|tip Keep the ghosts controlled. |grouprole EVERYONE
|tip
|tip Melee need to move out of Zul'lor's slam. |grouprole EVERYONE
|tip Focus down Totems for Mijan. |grouprole EVERYONE
|tip Interrupt Zolo's "Chain Lightning" casts. |grouprole EVERYONE
|tip Loro will reset threat while active so be mindful to let the tanks establish aggro. |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Move the current target out of AoEs if they appear. |grouprole TANK
|tip "Gasher" will need to be kited if his stacks get high. |grouprole TANK
|tip When "Loro" is active, be ready to taunt when aggro resets. |grouprole TANK
|tip
_DPS_ |grouprole DAMAGE
|tip Always focus down the live boss and ignore the ghosts unless you're on CC duty. |grouprole DAMAGE
|tip Melee need to be wary of Thorns on the active boss, as well as AoEs that may crop up during the fight. |grouprole TANK
|tip
_HEALER_ |grouprole HEALER
|tip If you're on CC duty keep an eye out for your target. |grouprole HEALER
|tip
collect 2 Amber Voodoo Feather##20606 |q 8418/1 |only if Paladin
collect 2 Amber Voodoo Feather##20606 |q 8422/1 |only if Warlock
collect 2 Amber Voodoo Feather##20606 |q 8425/1 |only if Warrior
|tip These come from Gasher and Zul'Lor. |only if Paladin and Warlock and Warrior
collect 2 Blue Voodoo Feather##20607 |q 8418/2 |only if Paladin
collect 2 Blue Voodoo Feather##20607 |q 8422/2 |only if Warlock
collect 2 Blue Voodoo Feather##20607 |q 8425/2 |only if Warrior
|tip These come from Mijan and Hukku. |only if Paladin and Warlock and Warrior
collect 2 Green Voodoo Feather##20608 |q 8418/3 |only if Paladin
collect 2 Green Voodoo Feather##20608 |q 8422/3 |only if Warlock
collect 2 Green Voodoo Feather##20608 |q 8425/3 |only if Warrior
|tip These come from Zolo and Loro. |only if Paladin and Warlock and Warrior
Click Here to Continue |confirm
step
kill Jammal'an the Prophet##218721, Ogom the Wretched##218718
IMPORTANT:
|tip The mechanics may change weekly.
|tip Depending on such, Jammal'an the Prophet may be the one who is killed first.
_EVERYONE_ |grouprole EVERYONE
|tip Focus Ogom until he dies, damage on Jammal'an does not matter in phase 1. |grouprole EVERYONE
|tip
|tip Stay stacked until "Holy Nova" appears on the ground below you, then move out of them as a group. |grouprole EVERYONE
|tip If Ogrom is the main boss, in place of Holy Nova he will cast an AoE "Hammer of Justice". |grouprole EVERYONE
|tip
|tip This fight is mostly about managing dispels and decurses, if your group is low on these, DPS may have to help out. |grouprole EVERYONE
_DPS_ |grouprole DAMAGE
|tip Focus down Ogom the Wretched first. |grouprole DAMAGE
|tip Help decurse if needed as this curse is very potent. |grouprole DPS |only if Mage
|tip Establish a kick rotation for "Smite" as it's a high damage spell. |grouprole DPS
|tip
_HEALER_ |grouprole HEALER
|tip "Holy Fire" needs to be dispelled as it's a very heavy damage DOT. |grouprole HEALER
|tip If Ogom is the main boss, prioritize dispelling "Hammer of Justice". |grouprole HEALER
|tip Prioritize decursing targets immediately as the curse is very powerful. |grouprole HEALER
|tip In phase 2, dispel the fear from "Psychic Scream". |grouprole HEALER
|tip "Mass Penance" deals huge raid wide damage in phase 2, be prepared to top up important members. |grouprole HEALER
|tip During Phase 2, prioritize dispelling "Shadow Sermon: Pain" as it is a large amount of damage on players. |grouprole HEALER
collect Head of Jammal'an##6212 |q 82104/1
Click Here to Continue |confirm
step
Inside the Temple of Atal'Hakkar Raid:
kill Morphaz##221942, Hazzas##221943
_EVERYONE_ |grouprole EVERYONE
|tip Unless you're a tank, don't stand in front of or behind the boss. |grouprole EVERYONE
|tip Hazzas casts "Animate Flames" at 80%. |grouprole EVERYONE
|tip The adds must be killed as soon as they appear. |grouprole EVERYONE
|tip They drop flame patches where they die that are important later. |grouprole EVERYONE
|tip After casting Animate Flames, Hazzas will start to cast "Lucid Dreams", where you can now attack Morphaz. |grouprole EVERYONE
|tip Morphaz takes 100% bonus damage during this slumber. |grouprole EVERYONE
|tip However you have to leave the dream world before Morphaz before casts "Eternal Slumber" or you will die. |grouprole EVERYONE
|tip Only roughly 6 players can leave the dream world and live, other players will need to stand in the fire the Animated Flames dropped to avoid being sent down.
|tip They can also run over other players to wake them up. |grouprole EVERYONE
|tip At 30% hp, Hazzas will send you into the dream once more, however now there are no fire patches. |grouprole EVERYONE
|tip You need to burn Morphaz before your group dies. |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Make sure you're not bouncing around to help the raid not have to reposition as much. |grouprole TANK
|tip
collect Tooth of Morphaz##20019 |q 8232/1 |only if Hunter
collect Arcane Shard##20085 |q 8253/1 |only if Mage
collect Blood of Morphaz##20025 |q 8257/1 |only if Priest
collect Azure Key##20022 |q 8236/1 |only if Rogue
Click Here to Continue |confirm
step
Inside the Temple of Atal'Hakkar Raid:
PHASE 1
_EVERYONE_ |grouprole EVERYONE
|tip Nature Resistance potions as well as Poison Cleansing Potions should be utilized here. |grouprole EVERYONE
|tip Druids and Paladins need to prioritize cleansing "Lethargic Poison". |only if Alliance |grouprole EVERYONE
|tip Shaman should use Poison Cleanse totoem for "Lethargic Poison". |only if Horde |grouprole EVERYONE
|tip Ranged stack up and move as a group for "Deep Slumber". |grouprole EVERYONE
|tip During "Waking Nightmare" the raid must enter the clouds left behind by Deep Slumber before the cast ends or get killed. |grouprole EVERYONE
|tip Establish an interrupt rotation for "Bellowing Roar".
|tip You are likely to wipe if one goes off.
PHASE 2
|tip At 70%, the boss sleeps and Summons 2 Lumbering Dreamwalkers. |grouprole EVERYONE
|tip They must be interrpted. |grouprole EVERYONE
|tip Afterwhich, after around every 10 seconds, the boss will spawn 5 whelplings. |grouprole EVERYONE
|tip AoE them down, otherwise repeating tactics from the first phase. |grouprole EVERYONE
PHASE 3
|tip At 40%, 2 Lumbering Dreamwalkers will spawn again. |grouprole EVERYONE
|tip This is identical to the previous phase, except this time with the whelpings, 3 Nightmare Scalebanes. |grouprole EVERYONE
|tip Prioritize killing the adds. |grouprole EVERYONE
|tip Avoid "Acid Rain". |grouprole EVERYONE
|tip At 10%, all DPS should focus down the boss. |grouprole EVERYONE
|tip Adds will be spawning faster than you can kill them likely. |grouprole EVERYONE
|tip They can be stunned and feared. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Tank the boss on a ledge in the room. |grouprole TANK
|tip This helps control the adds when they spawn. |grouprole TANK
|tip Tank swap after "Corrosive Breath". |grouprole TANK
_DPS_ |grouprole DPS
|tip Ranged should stack to bait Deep Slumber spawning, then run out as a group after it spawns. |grouprole DPS
collect Essence of Eranikus##10454 |q 82102 |future
Click Here to Continue |confirm
step
Inside the Temple of Atal'Hakkar Raid:
use the Essence of Eranikus##10454
accept The Essence of Eranikus##82102
step
Inside the Temple of Atal'Hakkar Raid:
click Essence Font##148512
|tip It looks like a stone table in the northeastern corner of the room with the Shade of Eranikus.
turnin The Essence of Eranikus##82102
step
Inside the Temple of Atal'Hakkar Raid:
Complete the Egg of Hakkar Quest
|tip
kill Avatar of Hakkar##221394
_EVERYONE_ |grouprole EVERYONE
|tip Have a ranged stack and a melee stack. |grouprole EVERYONE
|tip Anyone who gets Corrupted Blood must leave the stack to not spread the debuff to other players. |grouprole EVERYONE
|tip Anyone who gets Corrupted Blood should move behind the tank until Avatar of Hakkar uses his breath attack.  |grouprole EVERYONE
|tip The breath will remove your debuff. |grouprole EVERYONE
|tip Players will periodically get mind controlled, do not kill them! |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Keep the boss faced away from the raid as he does a breath attack. |grouprole TANK
|tip
_HEALER_ |grouprole HEALER
|tip Any player who gets cleansed of their "Corrupted Blood" debuff cannot be healed for 5 seconds after, be sure to top them up before hand. |grouprole HEALER
|tip "Power Word: Shield" is a great loophole to help save a player during these 5 seconds as it doesn't technically heal. |grouprole HEALER |only if Priest
|tip Purge any player that gets mind controlled to save them. |grouprole HEALER |only if Horde
|tip
collect Essence of Hakkar##10663 |q 82095
collect Scapula of the Fallen Avatar##221346 |q 82081 |future
step
Inside the Temple of Atal'Hakkar Raid:
use the Scapula of the Fallen Avatar##221346
accept A Broken Ritual##82081 |or
accept A Broken Ritual##82083 |or
step
Inside the Temple of Atal'Hakkar Raid:
use the Essence of Hakkar##10663
Fill the Egg of Hakkar |q 82095/1
step
label "Collect_20_Fetish_of_Hakkar"
Inside the Temple of Atal'Hakkar Raid: |notinsticky
Kill Atal'ai enemies around this area
collect 20 Fetish of Hakkar##6181 |q 1445/1
|tip These can also drop outside of the instance. |notinsticky
step
label "Collect_5_Atal'ai_Haze"
Inside the Temple of Atal'Hakkar Raid: |notinsticky
Kill enemies around this area
|tip Murk Worms, Deep Lurkers and Saturated Oozes specifically drop the quest item. |notinsticky
collect 5 Atal'ai Haze##11318 |q 82099/1
step
Leave the Temple of Atal'Hakkar
Click Here to Continue |confirm |q 82095
step
Enter the building |goto Stormwind City 68.93,42.08 < 8 |walk
talk Brohann Caskbelly##5384
|tip Inside the building.
turnin Into The Temple of Atal'Hakkar##82098 |goto Stormwind City 69.45,40.41
step
Follow the path |goto The Hinterlands 35.78,64.12 < 15 |only if walking
Run up the stairs |goto The Hinterlands 33.09,73.80 < 15 |only if walking
Jump down here |goto The Hinterlands 33.11,75.53 < 7 |only if walking
talk Atal'ai Exile##5598
turnin Jammal'an the Prophet##82104 |goto The Hinterlands 33.75,75.22
step
Follow the path up |goto Un'Goro Crater 45.72,13.08 < 10 |only if walking
talk Muigin##9119
turnin Haze of Evil##82099 |goto Un'Goro Crater 42.94,9.65
step
talk Yeh'kinya##8579
turnin The God Hakkar##82095 |goto Tanaris 66.98,22.36
step
talk Molthor##14875
turnin A Broken Ritual##82081 |goto Stranglethorn Vale 15.00,15.20 |or
turnin A Broken Ritual##82083 |goto Stranglethorn Vale 15.00,15.20 |or
step
talk Torwa Pathfinder##9619
turnin A Better Ingredient##9053 |goto Un'Goro Crater 71.63,75.96
|only if NightElf Druid
step
Follow the path up |goto Azshara 42.09,42.45
talk Ogtinc##8405
turnin The Green Drake##8232 |goto Azshara 42.40,42.62
|only if Hunter
step
talk Sanath Lim-yo##8395
accept Meeting with the Master##3503 |goto Azshara 28.11,50.09
|only if Mage
step
talk Archmage Xylem##8379
|tip Inside the tower.
turnin Destroy Morphaz##8253 |goto Azshara 28.11,50.09
|only if Mage
step
talk Commander Ashlam Valorfist##10838
turnin Forging the Mightstone##8418 |goto Western Plaguelands 42.70,84.03
|only if Paladin
step
talk Greta Mosshoof##10922
turnin Blood of Morphaz##8257 |goto Felwood 51.20,82.20
|only if Priest
step
Follow the road up |goto Hillsbrad Foothills 75.51,23.52 < 10 |only if walking
Enter the cave |goto Hillsbrad Foothills 77.82,19.27 < 10 |walk
Follow the path |goto Alterac Mountains 81.71,77.48 < 10 |only if walking
Enter the building |goto Alterac Mountains 85.46,79.39 < 10 |walk
talk Lord Jorach Ravenholdt##6768
turnin The Azure Key##8236|goto Alterac Mountains 86.03,78.88
|only if Rogue
step
talk Impsy##14470
turnin Trolls of a Feather##8422 |goto Alterac Mountains 41.36,45.02
|only if Warlock
step
talk Fallen Hero of the Horde##7572
turnin Voodoo Feathers##8425 |goto Swamp of Sorrows 34.29,66.15
|only if Warrior
]])
ZygorGuidesViewer:RegisterGuide("Dungeon Guides\\Sunken Temple Raid (25)",{
image=ZGV.IMAGESDIR.."The Temple of Atal'Hakkar",
description="This guide will walk you through the Sunken Temple raid.",
hideif=not ZGV.IsClassicSoD,
},[[
step
click Atal'ai Statue##148830
|tip There are 6 of them.
|tip Enemies will spawn behind you after interacting with the statues.
|tip They can be tamed instead of fighting if you have a Lone Wolf Hunter in the group.
|tip
kill Atal'alarion##218624
_EVERYONE_ |grouprole EVERYONE
|tip The boss places pillars around the room, each pillar up buffs the boss. |grouprole EVERYONE
|tip Anyone who gets knocked back into a pillar will destroy it. |grouprole EVERYONE
|tip You can destroy the pillars with this ability however and you should prioritize doing so. |grouprole EVERYONE
|tip Always be positioned to be knocked into pillars. |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Keep him faced away from the group. |grouprole TANK
|tip During "Demolishing Smash", all aggro will drop so you can tank swap if desired. |grouprole TANK
|tip Regardless, try to re-establish aggro quickly. |grouprole TANKS
|tip
_DPS_ |grouprole DAMAGE
|tip Allow the tank to re-establish aggro after each Demolishing Smash. |grouprole DAMAGE
|tip
_HEALER_ |grouprole HEALER
|tip For each pillar with dragons impaled on the, his damage will increase. |grouprole HEALER
|tip Demolishing Smash does 1500 damage to the entire raid, make sure nobody has less health than this before the cast goes off! |grouprole HEALER
|tip
Click Here to Continue |confirm
step
kill Festering Rotslime##218819
_EVERYONE_ |grouprole EVERYONE
|tip The boss moves around in a circle, poisoning the raid as it moves. |grouprole EVERYONE
|tip People afflicted by the poison will have their movement speed reduced by 60%. |grouprole EVERYONE
|tip When the poison is dispelled, it will leave a green patch on the ground that deals damage over time to anyone that walks over it. |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Help the DPS take dwn the objects that spawn at the sides of the room. |grouprole TANK
|tip
_DPS_ |grouprole DAMAGE
|tip Melee should prioritize killing the objects on the side of the room, such as "Atal'ai Slabs, Atal'ai Masks and Atal'ai Candles". |grouprole DAMAGE
|tip This will cause the boss to slow down.
|tip
Click Here to Continue |confirm
step
kill Atal'ai Defenders Controller##221732 Controller##221732s
_EVERYONE_ |grouprole EVERYONE
|tip This is a gauntlet style fight. |grouprole EVERYONE
|tip Enemies will appear one at a time. |grouprole EVERYONE
|tip When one is killed, they will be turned into an unkillable ghost that needs to be CC'd by either a Priest or a Hunter. |grouprole EVERYONE
|tip Keep the ghosts controlled. |grouprole EVERYONE
|tip
|tip Melee need to move out of Zul'lor's slam. |grouprole EVERYONE
|tip Focus down Totems for Mijan. |grouprole EVERYONE
|tip Interrupt Zolo's "Chain Lightning" casts. |grouprole EVERYONE
|tip Loro will reset threat while active so be mindful to let the tanks establish aggro. |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Move the current target out of AoEs if they appear. |grouprole TANK
|tip "Gasher" will need to be kited if his stacks get high. |grouprole TANK
|tip When "Loro" is active, be ready to taunt when aggro resets. |grouprole TANK
|tip
_DPS_ |grouprole DAMAGE
|tip Always focus down the live boss and ignore the ghosts unless you're on CC duty. |grouprole DAMAGE
|tip Melee need to be wary of Thorns on the active boss, as well as AoEs that may crop up during the fight. |grouprole TANK
|tip
_HEALER_ |grouprole HEALER
|tip If you're on CC duty keep an eye out for your target. |grouprole HEALER
|tip
Click Here to Continue |confirm
step
kill Dreamscythe##220833, Weaver##220864
_EVERYONE_ |grouprole EVERYONE
|tip Stay towards the center of the room to avoid getting knocked back into poison. |grouprole EVERYONE
|tip Just be sure to not fall into the hole in the middle! |grouprole EVERYONE
|tip Both dragons have a knockback, a frontal cone breath, and share a health pool. |grouprole EVERYONE
|tip You will fight Dreamscythe until 80% hp, then Weaver until 60% hp, then both at once until they die. |grouprole EVERYONE
|tip Weaver's knockback has a longer cast time than Dreamscythe's so be prepared for a second knockback shortly after if they're being fought at the same time. |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip You'll want to tank swap at 2 stacks of "Acid Breath". |grouprole TANK
|tp It's very likely that your tank will die at 3 stacks. |grouprole TANK
|tip Have another tank taunt off if you start taking too much damage. |grouprole TANK
|tip
Click Here to Continue |confirm
step
kill Jammal'an the Prophet##218721, Ogom the Wretched##218718
IMPORTANT:
|tip The mechanics may change weekly.
|tip Depending on such, Jammal'an the Prophet may be the one who is killed first.
_EVERYONE_ |grouprole EVERYONE
|tip Focus Ogom until he dies, damage on Jammal'an does not matter in phase 1. |grouprole EVERYONE
|tip
|tip Stay stacked until "Holy Nova" appears on the ground below you, then move out of them as a group. |grouprole EVERYONE
|tip If Ogrom is the main boss, in place of Holy Nova he will cast an AoE "Hammer of Justice". |grouprole EVERYONE
|tip
|tip This fight is mostly about managing dispels and decurses, if your group is low on these, DPS may have to help out. |grouprole EVERYONE
|tip
_DPS_ |grouprole DAMAGE
|tip Focus down Ogom the Wretched first. |grouprole DAMAGE
|tip Help decurse if needed as this curse is very potent. |grouprole DPS |only if Mage
|tip Establish a kick rotation for "Smite" as it's a high damage spell. |grouprole DPS
|tip
_HEALER_ |grouprole HEALER
|tip "Holy Fire" needs to be dispelled as it's a very heavy damage DOT. |grouprole HEALER
|tip If Ogom is the main boss, prioritize dispelling "Hammer of Justice". |grouprole HEALER
|tip Prioritize decursing targets immediately as the curse is very powerful. |grouprole HEALER
|tip In phase 2, dispel the fear from "Psychic Scream". |grouprole HEALER
|tip "Mass Penance" deals huge raid wide damage in phase 2, be prepared to top up important members. |grouprole HEALER
|tip During Phase 2, prioritize dispelling "Shadow Sermon: Pain" as it is a large amount of damage on players. |grouprole HEALER
|tip
Click Here to Continue |confirm
step
kill Morphaz##221942, Hazzas##221943
_EVERYONE_ |grouprole EVERYONE
|tip Unless you're a tank, don't stand in front of or behind the boss. |grouprole EVERYONE
|tip Hazzas casts "Animate Flames" at 80%. |grouprole EVERYONE
|tip The adds must be killed as soon as they appear. |grouprole EVERYONE
|tip They drop flame patches where they die that are important later. |grouprole EVERYONE
|tip After casting Animate Flames, Hazzas will start to cast "Lucid Dreams", where you can now attack Morphaz. |grouprole EVERYONE
|tip Morphaz takes 100% bonus damage during this slumber. |grouprole EVERYONE
|tip However you have to leave the dream world before Morphaz before casts "Eternal Slumber" or you will die. |grouprole EVERYONE
|tip Only roughly 6 players can leave the dream world and live, other players will need to stand in the fire the Animated Flames dropped to avoid being sent down.
|tip They can also run over other players to wake them up. |grouprole EVERYONE
|tip At 30% hp, Hazzas will send you into the dream once more, however now there are no fire patches. |grouprole EVERYONE
|tip You need to burn Morphaz before your group dies. |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Make sure you're not bouncing around to help the raid not have to reposition as much. |grouprole TANK
|tip
Click Here to Continue |confirm
step
kill Shade of Eranikus##218571
PHASE 1
_EVERYONE_ |grouprole EVERYONE
|tip Nature Resistance potions as well as Poison Cleansing Potions should be utilized here. |grouprole EVERYONE
|tip Druids and Paladins need to prioritize cleansing "Lethargic Poison". |only if Alliance |grouprole EVERYONE
|tip Shaman should use Poison Cleanse totoem for "Lethargic Poison". |only if Horde |grouprole EVERYONE
|tip Ranged stack up and move as a group for "Deep Slumber". |grouprole EVERYONE
|tip During "Waking Nightmare" the raid must enter the clouds left behind by Deep Slumber before the cast ends or get killed. |grouprole EVERYONE
|tip Establish an interrupt rotation for "Bellowing Roar".
|tip You are likely to wipe if one goes off.
|tip
PHASE 2
|tip At 70%, the boss sleeps and Summons 2 Lumbering Dreamwalkers. |grouprole EVERYONE
|tip They must be interrpted. |grouprole EVERYONE
|tip Afterwhich, after around every 10 seconds, the boss will spawn 5 whelplings. |grouprole EVERYONE
|tip AoE them down, otherwise repeating tactics from the first phase. |grouprole EVERYONE
|tip
PHASE 3
|tip At 40%, 2 Lumbering Dreamwalkers will spawn again. |grouprole EVERYONE
|tip This is identical to the previous phase, excite this time with the whelpings, 3 Nightmare Scalebanes. |grouprole EVERYONE
|tip Prioritize killing the adds. |grouprole EVERYONE
|tip The ranged group will likely no longer be able to stack to due having to dodge "Acid Rain". |grouprole EVERYONE
|tip
|tip At 10%, all DPS should focus down the boss. |grouprole EVERYONE
|tip Adds will be spawning faster than you can kill them likely. |grouprole EVERYONE
|tip They can be stuned and feared, so when possible do so. |grouprole EVERYONE
_TANK_ |grouprole TANK
|tip Tank the boss on a ledge in the room. |grouprole TANK
|tip This helps control the adds when they spawn. |grouprole TANK
|tip Tank swap after "Corrosive Breath". |grouprole TANK
|tip
_DPS_ |grouprole DPS
|tip Ranged should stack to bait Deep Slumber spawning, then run out as a group after it spawns. |grouprole DPS
Click Here to Continue |confirm
step
Complete the Egg of Hakkar Quest
|tip
kill Avatar of Hakkar##221394
_EVERYONE_ |grouprole EVERYONE
|tip Have a ranged stack and a melee stack. |grouprole EVERYONE
|tip Anyone who gets Corrupted Blood must leave the stack to not spread the debuff to other players. |grouprole EVERYONE
|tip Anyone who gets Corrupted Blood should move behind the tank until Avatar of Hakkar uses his breath attack.  |grouprole EVERYONE
|tip The breath will remove your debuff. |grouprole EVERYONE
|tip Players will periodically get mind controlled, do not kill them! |grouprole EVERYONE
|tip
_TANK_ |grouprole TANK
|tip Keep the boss faced away from the raid as he does a breath attack. |grouprole TANK
|tip
_HEALER_ |grouprole HEALER
|tip Any player who gets cleansed of their "Corrupted Blood" debuff cannot be healed for 5 seconds after, be sure to top them up before hand. |grouprole HEALER
|tip "Power Word: Shield" is a great loophole to help save a player during these 5 seconds as it doesn't technically heal. |grouprole HEALER |only if Priest
|tip Purge any player that gets mind controlled to save them. |grouprole HEALER |only if Horde
|tip
Click Here to Continue |confirm
]])
