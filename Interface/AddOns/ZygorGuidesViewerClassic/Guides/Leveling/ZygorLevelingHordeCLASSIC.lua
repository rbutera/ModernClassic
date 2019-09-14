local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("LevelingHCLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Undead (1-12)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
condition_suggested=function() return raceclass('Undead') and level <= 12 end,
condition_suggested_exclusive=true,
next="Leveling Guides\\Leveling (12-20)",
startlevel=1,
endlevel=12,
},[[
author support@zygorguides.com
defaultfor Scourge
next Leveling (13-20)
step
Run up the stairs |goto Tirisfal Glades 29.99,72.48 < 5 |walk
Leave the crypt |goto Tirisfal Glades 30.32,72.10 < 7 |walk
talk Undertaker Mordo##1568
accept Rude Awakening##363 |goto Tirisfal Glades 30.22,71.65
step
Enter the building |goto 31.39,66.20 < 7 |walk
talk Shadow Priest Sarvis##1569
|tip Inside the building.
turnin Rude Awakening##363 |goto 30.84,66.20
accept The Mindless Ones##364 |goto 30.84,66.20
step
talk Venya Marthand##5667
|tip Inside the building.
accept Piercing the Veil##1470 |goto 30.98,66.41
|only if Scourge Warlock
stickystart "Kill_Wretched_Zombies"
step
Leave the building |goto 31.41,66.20 < 7 |walk
kill 8 Mindless Zombie##1501 |goto 31.96,63.30
step
label "Kill_Wretched_Zombies"
kill 8 Wretched Zombie##1502 |goto 31.96,63.30
step
Kill enemies around this area
Reach Level 2 |ding 2 |goto 31.96,63.30
step
kill Rattlecage Skeleton##1890+
collect 3 Rattlecage Skull##6281 |q 1470/1 |goto 32.73,60.10
|only if Scourge Warlock
step
Enter the building |goto 31.39,66.20 < 7 |walk
talk Shadow Priest Sarvis##1569
|tip Inside the building.
turnin The Mindless Ones##364 |goto 30.84,66.20
accept Simple Scroll##3095 |goto 30.84,66.20 |only if Scourge Warrior
accept Tainted Scroll##3099 |goto 30.84,66.20 |only if Scourge Warlock
accept Encrypted Scroll##3096 |goto 30.84,66.20 |only if Scourge Rogue
accept Hallowed Scroll##3097 |goto 30.84,66.20 |only if Scourge Priest
accept Glyphic Scroll##3098 |goto 30.84,66.20 |only if Scourge Mage
accept Rattling the Rattlecages##3901 |goto 30.84,66.20
step
talk Novice Elreth##1661
|tip Inside the building.
accept The Damned##376 |goto 30.86,66.05
step
Leave the building |goto 31.39,66.20 < 7 |walk
Enter the building |goto 32.22,65.62 < 7 |walk
talk Dannal Stern##2119
|tip Inside the building.
turnin Simple Scroll##3095 |goto 32.69,65.56
|only if Scourge Warrior
step
Leave the building |goto 32.22,65.62 < 7 |c |q 376
|only if Scourge Warrior
step
talk Maximillion##2126
|tip Inside the building.
turnin Tainted Scroll##3099 |goto 30.91,66.34
|only if Scourge Warlock
step
talk Venya Marthand##5667
|tip Inside the building.
turnin Piercing the Veil##1470 |goto 30.98,66.41
|only if Scourge Warlock
step
Leave the building |goto 31.39,66.20 < 7 |c |q 376
|only if Scourge Warlock
step
Leave the building |goto 31.39,66.20 < 7 |walk
Enter the building |goto 32.22,65.62 < 7 |walk
talk David Trias##2122
|tip Inside the building.
turnin Encrypted Scroll##3096 |goto 32.53,65.65
|only if Scourge Rogue
step
Leave the building |goto 32.22,65.62 < 7 |c |q 376
|only if Scourge Rogue
step
talk Dark Cleric Duesten##2123
|tip Inside the building.
turnin Hallowed Scroll##3097 |goto 31.11,66.03
|only if Scourge Priest
step
Leave the building |goto 31.39,66.20 < 7 |c |q 376
|only if Scourge Priest
step
talk Isabella##2124
|tip Inside the building.
turnin Glyphic Scroll##3098 |goto 30.94,66.06
|only if Scourge Mage
step
Leave the building |goto 31.39,66.20 < 7 |c |q 376
|only if Scourge Mage
stickystart "Collect_Scavenger_Paws"
stickystart "Collect_Duskbat_Wings"
step
kill 12 Rattlecage Skeleton##1890 |q 3901/1 |goto 32.93,60.75
step
Kill enemies around this area
Reach Level 3 |ding 3 |goto 32.93,60.75
step
label "Collect_Scavenger_Paws"
kill Young Scavenger##1508+
collect 6 Scavenger Paw##3265 |q 376/1 |goto 32.35,57.69
You can find more around: |notinsticky
[35.07,58.45]
[30.07,62.32]
step
label "Collect_Duskbat_Wings"
kill Duskbat##1512+
collect 6 Duskbat Wing##3264 |q 376/2 |goto 32.35,57.69
You can find more around: |notinsticky
[35.07,58.45]
[30.07,62.32]
step
Kill enemies around this area
Reach Level 4 |ding 4 |goto 32.35,57.69
You can find more around: |notinsticky
[35.07,58.45]
[30.07,62.32]
step
Enter the building |goto 31.38,66.20 < 7 |walk
talk Novice Elreth##1661
|tip Inside the building.
turnin The Damned##376 |goto 30.86,66.05
accept Marla's Last Wish##6395 |goto 30.86,66.05
step
talk Shadow Priest Sarvis##1569
|tip Inside the building.
turnin Rattling the Rattlecages##3901 |goto 30.83,66.20
step
Leave the building |goto 31.38,66.20 < 7 |walk
talk Executor Arren##1570
accept Night Web's Hollow##380 |goto 32.15,66.01
step
talk Deathguard Saltain##1740
accept Scavenging Deathknell##3902 |goto 31.61,65.60
step
click Equipment Boxes+
|tip They look like piles of brown boxes on the ground outside near buildings, and inside the buildings around this area.
collect 6 Scavenged Goods##11127 |q 3902/1 |goto 32.60,63.50
step
talk Deathguard Saltain##1740
turnin Scavenging Deathknell##3902 |goto 31.61,65.60
step
kill 10 Young Night Web Spider##1504 |q 380/1 |goto 28.55,58.19
|tip Outside the mine.
step
Enter the mine |goto 26.84,59.40 < 10 |walk
kill 8 Night Web Spider##1505 |q 380/2 |goto 26.84,59.41
|tip Inside the mine.
step
Leave the mine |goto 26.84,59.41 < 10 |c |q 6395
step
Kill enemies around this area
Reach Level 5 |ding 5 |goto 28.55,58.19
You can find more around [28.10,55.58]
step
kill Samuel Fipps##1919
collect Samuel's Remains##16333 |goto 36.68,61.57 |q 6395
step
click Marla's Grave
Bury Samuel's Remains |q 6395/1 |goto 31.17,65.08
step
talk Executor Arren##1570
turnin Night Web's Hollow##380 |goto 32.15,66.01
accept The Scarlet Crusade##381 |goto 32.15,66.01
step
Enter the building |goto 31.38,66.20 < 7 |walk
talk Novice Elreth##1661
|tip Inside the building.
turnin Marla's Last Wish##6395 |goto 30.86,66.05
step
Leave the building |goto 31.38,66.20 < 7 |walk
Kill Scarlet enemies around this area
collect 12 Scarlet Armband##3266 |q 381/1 |goto 36.89,67.95
step
talk Executor Arren##1570
turnin The Scarlet Crusade##381 |goto 32.15,66.01
accept The Red Messenger##382 |goto 32.15,66.01
step
kill Meven Korgal##1667
collect Scarlet Crusade Documents##2885 |q 382/1 |goto 36.56,68.53
step
Kill enemies around this area
Reach Level 6 |ding 6 |goto 37.00,68.20
step
talk Executor Arren##1570
turnin The Red Messenger##382 |goto 32.15,66.01
accept Vital Intelligence##383 |goto 32.15,66.01
step
talk Calvin Montague##6784
accept A Rogue's Deal##8 |goto 38.23,56.79
step
Follow the road |goto 38.41,55.57 < 15 |only if walking
talk Deathguard Simmer##1519
accept Fields of Grief##365 |goto 40.91,54.17
step
talk Gordo##10666
|tip He looks like an abomination that walks along this road to the east.
accept Gordo's Task##5481 |goto 43.72,54.34
He walks along the road between here and [55.15,52.32]
step
click Gloom Weed+
|tip They look like small scraggly purple plants on the ground around this area.
|tip They can be pretty far spread out, so you may have to search around.
collect 3 Gloom Weed##12737 |q 5481/1 |goto 51.42,55.05
You can find more around: |notinsticky
[51.52,51.98]
[50.62,55.23]
[49.97,56.40]
[48.82,58.67]
[43.78,56.19]
[44.92,52.98]
step
Cross the bridge |goto 52.51,54.45 < 20 |only if walking
talk Deathguard Dillinger##1496
accept A Putrid Task##404 |goto 58.20,51.45
step
talk Junior Apothecary Holland##10665
|tip He walks around this area.
turnin Gordo's Task##5481 |goto 58.25,49.76
accept Doom Weed##5482 |goto 58.25,49.76
step
Enter the building |goto 59.58,52.12 < 7 |walk
talk Apothecary Johaan##1518
|tip Inside the building.
accept A New Plague##367 |goto 59.45,52.40
step
Leave the building |goto 59.58,52.12 < 7 |walk
talk Executor Zygand##1515
turnin Vital Intelligence##383 |goto 60.59,51.76
accept At War With The Scarlet Crusade##427 |goto 60.59,51.76
step
click Wanted!
accept Wanted: Maggot Eye##398 |goto 60.73,51.52
step
talk Deathguard Burgess##1652
accept Proof of Demise##374 |goto 60.93,52.01
step
Enter the building |goto 60.90,51.51 < 10 |walk
talk Magistrate Sevren##1499
|tip Inside the building.
accept Graverobbers##358 |goto 61.26,50.84
step
Leave the building |goto 60.89,51.53 < 10 |walk
Enter the building |goto 61.56,53.06 < 7 |walk
talk Innkeeper Renee##5688
|tip Inside the building.
turnin A Rogue's Deal##8 |goto 61.71,52.05
step
talk Innkeeper Renee##5688
|tip Inside the building.
home Gallows' End Tavern |goto 61.71,52.05
step
Leave the building |goto 61.56,53.05 < 7 |walk
kill Decrepit Darkhound##1547+
collect 5 Darkhound Blood##2858 |q 367/1 |goto 63.45,47.18
You can find more around [58.94,56.45]
step
Kill enemies around this area
Reach Level 7 |ding 7 |goto 63.45,47.18
You can find more around [58.94,56.45]
step
Enter the building |goto 59.58,52.12 < 7 |walk
talk Apothecary Johaan##1518
|tip Inside the building.
turnin A New Plague##367 |goto 59.45,52.40
accept A New Plague##368 |goto 59.45,52.40
step
Leave the building |goto 59.58,52.12 < 7 |walk
Kill enemies around this area
|tip Only enemies that look like zombies will drop the quest item.
collect 7 Putrid Claw##2855 |q 404/1 |goto 53.25,57.00
You can find more around [52.04,52.14]
step
talk Deathguard Dillinger##1496
turnin A Putrid Task##404 |goto 58.20,51.45
accept The Mills Overrun##426 |goto 58.20,51.45
step
Enter the building |goto 61.55,53.05 < 7 |walk
talk Coleman Farthing##1500
|tip Inside the building.
accept Deaths in the Family##354 |goto 61.72,52.29
accept The Haunted Mills##362 |goto 61.72,52.29
step
talk Gretchen Dedmar##1521
|tip Upstairs inside the building.
accept The Chill of Death##375 |goto 61.89,52.73
step
Leave the building |goto 61.56,53.06 < 7 |walk
talk Abigail Shiel##2118
buy Coarse Thread##2320 |q 375/2 |goto 61.03,52.37
step
Cross the bridge and follow the road |goto 53.64,53.22 < 20 |only if walking
Follow the path |goto 38.81,55.70 < 15 |only if walking
talk Calvin Montague##6784
accept A Rogue's Deal##590 |goto 38.23,56.79
|tip He will attack you.
step
kill Calvin Montague##6784
|tip He will eventually surrender.
Watch the dialogue
Defeat Calvin Montague |q 590/1 |goto 38.23,56.79
step
Watch the dialogue
talk Calvin Montague##6784
turnin A Rogue's Deal##590 |goto 38.23,56.79
step
Follow the path |goto 38.38,55.57 < 15 |only if walking
Continue following the path |goto 39.27,53.75 < 20 |only if walking
click Tirisfal Pumpkin+
|tip They look like large orange pumpkins on the ground around this area.
collect 10 Tirisfal Pumpkin##2846 |q 365/1 |goto 35.82,50.82
stickystart "Kill_Scarlet_Warriors"
step
kill Scarlet Warrior##1535+
collect 10 Scarlet Insignia Ring##2875 |q 374/1 |goto 32.19,48.70
step
label "Kill_Scarlet_Warriors"
kill 10 Scarlet Warrior##1535 |q 427/1 |goto 32.19,48.70
step
Kill enemies around this area
Reach Level 8 |ding 8 |goto 32.19,48.70
stickystart "Collect_Notched_Ribs"
stickystart "Collect_Blackened_Skulls"
stickystart "Accept_A_Letter_Undelivered"
step
Follow the road |goto 34.31,48.15 < 30 |only if walking
kill Greater Duskbat##1553+
collect 5 Duskbat Pelt##2876 |q 375/1 |goto 45.53,53.17
|tip These have a low drop rate.
You can find more around [39.37,42.28]
step
kill Devlin Agamand##1657
|tip He looks like an armored skeleton mage.
collect Devlin's Remains##2831 |q 362/1 |goto 47.34,40.77
step
Enter the building |goto 49.37,36.03 < 7 |walk
kill Nissa Agamand##1655
|tip She looks like the ghost of a woman that walks around inside the building.
|tip She can be upstairs or downstairs.
collect Nissa's Remains##2828 |q 354/2 |goto 49.54,36.02
step
Leave the building |goto 49.37,36.03 < 7 |c |q 354
step
Kill enemies around this area
Reach Level 9 |ding 9 |goto 47.73,35.28
step
kill Gregor Agamand##1654
|tip He looks like a ghoul that walks around this area.
collect Gregor's Remains##2829 |q 354/1 |goto 45.74,29.38
step
kill Thurman Agamand##1656
|tip He looks like a zombie that walks around this area.
collect Thurman's Remains##2830 |q 354/3 |goto 43.64,35.41
step
label "Collect_Notched_Ribs"
Kill Soldier enemies around this area
|tip They look like armored skeletons around this area.
|tip All around this whole area.
collect 5 Notched Rib##3162 |q 426/1 |goto 47.73,35.28
step
label "Collect_Blackened_Skulls"
kill Darkeye Bonecaster##1522+
|tip All around this whole area.
collect 3 Blackened Skull##3163 |q 426/2 |goto 47.73,35.28
step
label "Accept_A_Letter_Undelivered"
Kill enemies around this area
|tip Only enemies that look like skeletons will drop the quest item.
|tip All around this whole area.
collect A Letter to Yvette##2839 |n
use A Letter to Yvette##2839
accept A Letter Undelivered##361 |goto 47.73,35.28
step
talk Coleman Farthing##1500
|tip Inside the building.
turnin Deaths in the Family##354 |goto 61.72,52.29
turnin The Haunted Mills##362 |goto 61.72,52.29
accept Speak with Sevren##355 |goto 61.72,52.29
step
talk Yvette Farthing##1560
|tip Inside the building.
turnin A Letter Undelivered##361 |goto 61.58,52.60
step
talk Gretchen Dedmar##1521
|tip Upstairs inside the building.
turnin The Chill of Death##375 |goto 61.89,52.73
step
Leave the building |goto 61.56,53.05 < 7 |walk
talk Deathguard Burgess##1652
turnin Proof of Demise##374 |goto 60.93,52.00
step
Enter the building |goto 60.90,51.52 < 10 |walk
talk Magistrate Sevren##1499
|tip Inside the building.
turnin Speak with Sevren##355 |goto 61.26,50.84
step
Leave the building |goto 60.90,51.53 < 10 |walk
talk Executor Zygand##1515
turnin At War With The Scarlet Crusade##427 |goto 60.59,51.77
accept At War With The Scarlet Crusade##370 |goto 60.59,51.77
step
Enter the building |goto 59.58,52.13 < 7 |walk
talk Apothecary Johaan##1518
|tip Inside the building.
turnin Fields of Grief##365 |goto 59.45,52.40
accept Fields of Grief##407 |goto 59.45,52.40
accept Delivery to Silverpine Forest##445 |goto 59.45,52.40
step
Leave the building |goto 59.58,52.13 < 7 |walk
talk Deathguard Dillinger##1496
turnin The Mills Overrun##426 |goto 58.20,51.45
step
Kill enemies around this area
Reach Level 10 |ding 10 |goto 53.62,57.23
step
talk Father Lankester##4607
accept Touch of Weakness##5658 |goto Undercity 49.14,14.61
|only if Scourge Priest
step
talk Aelthalyste##4606
turnin Touch of Weakness##5658 |goto Undercity 49.27,17.11
|only if Scourge Priest
step
Enter the building |goto 61.56,53.04 < 7 |walk
talk Ageron Kargal##5724
|tip Upstairs inside the building.
accept Halgar's Summons##1478 |goto 61.62,52.67
|only if Scourge Warlock
step
Leave the building |goto 61.56,53.06 < 7 |walk
Enter Undercity |goto 61.88,65.06 < 10 |only if walking
talk Carendin Halgar##5675
turnin Halgar's Summons##1478 |goto Undercity 85.04,26.01
accept Creature of the Void##1473 |goto Undercity 85.04,26.01
|only if Scourge Warlock
step
Leave Undercity |goto 66.23,0.23 < 10 |walk
Enter the building |goto Tirisfal Glades 51.44,67.70 < 7 |walk
click Perrine's Chest
|tip Inside the building.
collect Egalin's Grimoire##6285 |q 1473/1 |goto Tirisfal Glades 51.06,67.57
|only if Scourge Warlock
step
Leave the building |goto 51.44,67.69 < 7 |walk
Enter Undercity |goto 61.88,65.06 < 10 |only if walking
talk Carendin Halgar##5675
turnin Creature of the Void##1473 |goto Undercity 85.04,26.01
accept The Binding##1471 |goto Undercity 85.04,26.01
|only if Scourge Warlock
step
use the Runes of Summoning##6284
|tip Use them on the pink symbol on the ground.
kill Summoned Voidwalker##5676 |q 1471/1 |goto 86.62,27.10
|only if Scourge Warlock
step
talk Carendin Halgar##5675
turnin The Binding##1471 |goto 85.04,26.01
|only if Scourge Warlock
step
Leave Undercity |goto 66.23,0.23 < 10 |c |q 370
|only if Scourge Warlock
step
Enter the building |goto Tirisfal Glades 61.55,53.05 < 7 |c |q 407
step
talk Austil de Mon##2131
|tip Inside the building.
accept Speak with Dillinger##1818 |goto 61.85,52.54
|only if Scourge Warrior
step
Leave the building |goto 61.56,53.05 < 7 |walk
talk Deathguard Dillinger##1496
turnin Speak with Dillinger##1818 |goto 58.20,51.45
accept Ulag the Cleaver##1819 |goto 58.20,51.45
|only if Scourge Warrior
step
click Doors
kill Ulag the Cleaver##6390 |q 1819/1 |goto 59.64,48.09
|only if Scourge Warrior
step
talk Deathguard Dillinger##1496
turnin Ulag the Cleaver##1819 |goto 58.20,51.45
accept Speak with Coleman##1820 |goto 58.20,51.45
|only if Scourge Warrior
step
Enter the building |goto 61.56,53.04 < 7 |walk
talk Coleman Farthing##1500
|tip Inside the building.
turnin Speak with Coleman##1820 |goto 61.72,52.29
|only if Scourge Warrior
step
talk Captured Scarlet Zealot##1931
|tip Downstairs inside the building.
turnin Fields of Grief##407 |goto 61.97,51.29
stickystart "Collect_Doom_Weed"
stickystart "Collect_Embalming_Ichors"
step
Leave the building |goto 61.57,53.05 < 7 |walk
Follow the path |goto 60.38,46.09 < 20 |only if walking
kill 8 Rot Hide Graverobber##1941 | q 358/1 |goto 55.37,42.34
stickystart "Kill_Rot_Hide_Mongrels"
step
label "Collect_Doom_Weed"
click Doom Weed+
|tip They look like small green and purple scraggly plants on the ground around this area.
|tip They can be pretty spread out, so you may need to search around.
collect 10 Doom Weed##13702 |q 5482/1 |goto 57.17,35.72
You can find a few more around [56.98,40.63]
step
label "Collect_Embalming_Ichors"
Kill Rot Hide enemies around this area
collect 8 Embalming Ichor##2834 | q 358/3 |goto 59.10,36.18
step
label "Kill_Rot_Hide_Mongrels"
kill 5 Rot Hide Mongrel##1675 | q 358/2 |goto 59.10,36.18
step
kill Maggot Eye##1753
|tip Inside the building.
collect Maggot Eye's Paw##3635 |q 398/1 |goto 58.66,30.76
step
Kill Vile Fin enemies around this area
collect 5 Vile Fin Scale##2859 |q 368/1 |goto 59.86,28.31
You can find more around [62.06,29.45]
step
Follow the road |goto 61.17,34.80 < 30 |only if walking
talk Executor Zygand##1515
turnin Wanted: Maggot Eye##398 |goto 60.58,51.77
step
Enter the building |goto 60.90,51.52 < 10 |walk
talk Magistrate Sevren##1499
|tip Inside the building.
turnin Graverobbers##358 |goto 61.26,50.85
accept Forsaken Duties##359 |goto 61.26,50.85
step
Leave the building |goto 60.89,51.53 < 10 |walk
Enter the building |goto 59.58,52.12 < 7 |walk
talk Apothecary Johaan##1518
|tip Inside the building.
turnin A New Plague##368 |goto 59.45,52.40
accept A New Plague##369 |goto 59.45,52.40
step
Leave the building |goto 59.58,52.12 < 7 |walk
talk Junior Apothecary Holland##10665
|tip He walks around this area.
turnin Doom Weed##5482 |goto 57.97,49.71
stickystart "Kill_Scarlet_Zealots"
stickystart "Kill_Scarlet_Missionaries"
step
Enter the building |goto 51.44,67.70 < 7 |walk
kill Captain Perrine##1662 |q 370/1 |goto 51.13,67.80
|tip Inside the building.
step
label "Kill_Scarlet_Zealots"
kill 3 Scarlet Zealot##1537 |q 370/2 |goto 52.04,67.78
step
label "Kill_Scarlet_Missionaries"
kill 3 Scarlet Missionary##1536 |q 370/3 |goto 52.04,67.78
step
Kill enemies around this area
Reach Level 11 |ding 11 |goto 52.04,67.78
step
talk Executor Zygand##1515
turnin At War With The Scarlet Crusade##370 |goto 60.58,51.76
accept At War With The Scarlet Crusade##371 |goto 60.58,51.76
step
talk Deathguard Linnea##1495
turnin Forsaken Duties##359 |goto 65.49,60.25
accept Return to the Magistrate##360 |goto 65.49,60.25
accept Rear Guard Patrol##356 |goto 65.49,60.25
stickystart "Kill_Wandering_Spirits"
step
kill 8 Bleeding Horror##1529 |q 356/1 |goto 75.54,60.85
step
label "Kill_Wandering_Spirits"
kill 8 Wandering Spirit##1532 |q 356/2 |goto 75.54,60.85
stickystart "Kill_Scarlet_Friars"
step
Follow the path up |goto 79.31,57.29 < 10 |only if walking
Enter the building |goto 79.18,55.98 < 7 |walk
kill Captain Vachon##1664 |q 371/1 |goto 78.82,56.13
|tip Inside the building.
step
label "Kill_Scarlet_Friars"
kill 5 Scarlet Friar##1538 |q 371/2 |goto 79.79,55.85
step
kill Vicious Night Web Spider##1555+
collect 4 Vicious Night Web Spider Venom##2872 |q 369/1 |goto 84.20,53.16
You can find more around: |notinsticky
[88.35,53.73]
[89.50,51.06]
step
Leave the building |goto 61.56,53.05 < 7 |walk
Enter the building |goto 60.90,51.51 < 10 |walk
talk Magistrate Sevren##1499
|tip Inside the building.
turnin Return to the Magistrate##360 |goto 61.26,50.84
step
Leave the building |goto 60.90,51.52 < 10 |walk
talk Executor Zygand##1515
turnin At War With The Scarlet Crusade##371 |goto 60.58,51.77
step
Enter the building |goto 59.58,52.12 < 7 |walk
talk Apothecary Johaan##1518
|tip Inside the building.
turnin A New Plague##369 |goto 59.45,52.40
accept A New Plague##492 |goto 59.45,52.40
step
Leave the building |goto 59.58,52.12 < 7 |walk
Enter the building |goto 61.56,53.06 < 7 |walk
talk Captured Mountaineer##2211
|tip Downstairs inside the building.
turnin A New Plague##492 |goto 61.94,51.40
step
Leave the building |goto 61.56,53.06 < 7 |walk
talk Deathguard Linnea##1495
turnin Rear Guard Patrol##356 |goto 65.49,60.25
step
Follow the road |goto 60.51,62.79 < 30 |c |q 435 |future
step
Kill enemies around this area
Reach Level 12 |ding 12 |goto 52.04,67.78
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Tauren (1-12)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
condition_suggested=function() return raceclass('Tauren') and level <= 12 end,
condition_suggested_exclusive=true,
next="Leveling Guides\\Leveling (12-20)",
startlevel=1,
endlevel=12,
},[[
author support@zygorguides.com
defaultfor Tauren
next Leveling (13-20)
step
talk Grull Hawkwind##2980
accept The Hunt Begins##747 |goto Mulgore 44.87,77.08
step
Enter the building |goto 44.32,76.21 < 15 |walk
talk Chief Hawkwind##2981
|tip Inside the building.
accept A Humble Task##752 |goto 44.18,76.06
stickystart "Collect_Plainstrider_Feathers"
step
kill Plainstrider##2955+
collect 7 Plainstrider Meat##4739 |q 747/1 |goto 45.94,82.61
step
label "Collect_Plainstrider_Feathers"
kill Plainstrider##2955+
collect 7 Plainstrider Feather##4740 |q 747/2 |goto 45.94,82.61
step
Kill enemies around this area
Reach Level 2 |ding 2 |goto 45.94,82.61
step
talk Greatmother Hawkwind##2991
turnin A Humble Task##752 |goto 50.03,81.16
accept A Humble Task##753 |goto 50.03,81.16
step
click Water Pitcher
collect Water Pitcher##4755 |q 753/1 |goto 50.21,81.36
step
talk Grull Hawkwind##2980
turnin The Hunt Begins##747 |goto 44.87,77.08
accept The Hunt Continues##750 |goto 44.87,77.08
accept Simple Note##3091 |goto 44.87,77.08 |only Tauren Warrior
accept Rune-Inscribed Note##3093 |goto 44.87,77.08 |only Tauren Shaman
accept Etched Note##3092 |goto 44.87,77.08 |only Tauren Hunter
accept Verdant Note##3094 |goto 44.87,77.08 |only Tauren Druid
step
talk Meela Dawnstrider##3062
|tip Inside the building.
turnin Rune-Inscribed Note##3093 |goto 45.01,75.94
|only if Tauren Shaman
step
talk Gart Mistrunner##3060
|tip Inside the building.
turnin Verdant Note##3094 |goto 45.09,75.93
|only if Tauren Druid
step
Enter the building |goto 44.32,76.21 < 15 |walk
talk Chief Hawkwind##2981
|tip Inside the building.
turnin A Humble Task##753 |goto 44.18,76.06
accept Rites of the Earthmother##755 |goto 44.18,76.06
step
talk Grull Hawkwind##2980
|tip Inside the building.
turnin Simple Note##3091 |goto 44.01,76.13
|only if Tauren Warrior
step
talk Lanka Farshot##3061
|tip Inside the building.
turnin Etched Note##3092 |goto 44.26,75.69
|only if Tauren Hunter
step
kill Mountain Cougar##2961+
collect 10 Mountain Cougar Pelt##4742 |q 750/1 |goto 46.34,90.51
step
Kill enemies around this area
Reach Level 3 |ding 3 |goto 46.34,90.51
step
talk Seer Graytongue##2982
turnin Rites of the Earthmother##755 |goto 42.58,92.18
accept Rite of Strength##757 |goto 42.58,92.18
step
talk Grull Hawkwind##2980
turnin The Hunt Continues##750 |goto 44.87,77.08
accept The Battleboars##780 |goto 44.87,77.08
step
talk Brave Windfeather##3209
|tip She walks around this area.
accept Break Sharptusk!##3376 |goto 44.94,77.04
stickystart "Collect_Battleboar_Flanks"
step
kill Battleboar##2966+
collect 8 Battleboar Snout##4848 |goto 53.47,80.22
step
label "Collect_Battleboar_Flanks"
kill Battleboar##2966+
collect 8 Battleboar Flank##4849 |goto 53.47,80.22
step
Kill enemies around this area
Reach Level 4 |ding 4 |goto 53.47,80.22
step
talk Seer Ravenfeather##5888
accept Call of Earth##1519 |goto 44.73,76.18
|only if Tauren Shaman
stickystart "Collect_Bristleback_Belts"
stickystart "Collect_Ritual_Salves"
step
Enter the tunnel |goto 58.15,85.02 < 15 |only if walking
Leave the tunnel |goto 59.69,83.29 < 15 |only if walking
Follow the path |goto 62.65,80.87 < 20 |only if walking
Continue following the path |goto 62.60,78.75 < 20 |only if walking
Enter the building |goto 64.28,77.98 < 15 |walk
kill Chief Sharptusk Thornmantle##8554
|tip Inside the building.
collect Chief Sharptusk Thornmantle's Head##10459 |q 3376/1 |goto 64.70,77.66
step
label "Collect_Bristleback_Belts"
Kill Bristleback enemies around this area
collect 12 Bristleback Belt##4770 |q 757/1 |goto 63.58,78.00
step
label "Collect_Ritual_Salves"
kill Bristleback Shaman##2953+
|tip They can be pretty spread out around this area.
collect 2 Ritual Salve##6634 |q 1519/1 |goto 63.87,80.34
You can find more around [59.92,75.65]
|only if Tauren Shaman
step
Kill enemies around this area
Reach Level 5 |ding 5 |goto 63.58,78.00
step
talk Grull Hawkwind##2980
turnin The Battleboars##780 |goto 44.87,77.08
step
talk Brave Windfeather##3209
|tip She walks around this area.
turnin Break Sharptusk!##3376 |goto 44.94,77.04
step
talk Seer Ravenfeather##5888
turnin Call of Earth##1519 |goto 44.73,76.19
accept Call of Earth##1520 |goto 44.73,76.19
|only if Tauren Shaman
step
Enter the building |goto 44.32,76.21 < 15 |walk
talk Chief Hawkwind##2981
|tip Inside the building.
turnin Rite of Strength##757 |goto 44.18,76.06
accept Rites of the Earthmother##763 |goto 44.18,76.06
step
use the Earth Sapta##6635
talk the Minor Manifestation of Earth
turnin Call of Earth##1520 |goto 53.88,80.56
accept Call of Earth##1521 |goto 53.88,80.56
|only if Tauren Shaman
step
talk Seer Ravenfeather##5888
turnin Call of Earth##1521 |goto 44.73,76.19
|only if Tauren Shaman
step
Follow the path |goto 39.45,82.40 < 20 |only if walking
talk Antur Fallow##6775
accept A Task Unfinished##1656 |goto 38.52,81.56
step
Follow the path |goto 36.41,79.59 < 30 |only if walking
talk Ruul Eagletalon##2985
accept Dangers of the Windfury##743 |goto 47.36,62.02
step
talk Baine Bloodhoof##2993
turnin Rites of the Earthmother##763 |goto 47.52,60.17
accept Sharing the Land##745 |goto 47.52,60.17
accept Rite of Vision##767 |goto 47.52,60.17
step
Enter the building |goto 46.82,60.55 < 15 |walk
talk Innkeeper Kauth##6747
|tip Inside the building.
turnin A Task Unfinished##1656 |goto 46.62,61.09
step
talk Innkeeper Kauth##6747
|tip Inside the building.
home Bloodhoof Village |goto 46.62,61.09
step
Leave the building |goto 46.81,60.53 < 10 |walk
talk Zarlman Two-Moons##3054
turnin Rite of Vision##767 |goto 47.76,57.54
accept Rite of Vision##771 |goto 47.76,57.54
step
talk Maur Raincaller##3055
accept Mazzranache##766 |goto 46.99,57.07
step
Enter the building |goto 48.64,58.84 < 15 |walk
talk Harken Windtotem##2947
|tip Inside the building.
accept Swoop Hunting##761 |goto 48.71,59.33
step
talk Mull Thunderhorn##2948
accept Poison Water##748 |goto 48.53,60.40
|only if Tauren
stickystart "Collect_Plainstrider_Scales"
stickystart "Collect_Prairie_Wolf_Paws"
stickystart "Collect_Plainstrider_Talons"
stickystart "Collect_Swoop_Gizzards"
stickystart "Collect_Trophy_Swoop_Quills"
stickystart "Collect_Ambercorns"
step
kill Prairie Wolf##2958+
collect Prairie Wolf Heart##4804 |q 766/1 |goto 39.77,60.43
step
label "Collect_Plainstrider_Scales"
kill Adult Plainstrider##2956+
collect Plainstrider Scale##4806 |q 766/3 |goto 39.77,60.43
step
label "Collect_Prairie_Wolf_Paws"
kill Prairie Wolf##2958+
collect 6 Prairie Wolf Paw##4758 |q 748/1 |goto 39.77,60.43
|only if Tauren
step
label "Collect_Plainstrider_Talons"
kill Adult Plainstrider##2956+
collect 4 Plainstrider Talon##4759 |q 748/1 |goto 39.77,60.43
|only if Tauren
step
label "Collect_Swoop_Gizzards"
kill Wiry Swoop##2969+
|tip They are pretty spread out around this area.
|tip You can find more to the north and south.
collect Swoop Gizzard##4807 |q 766/4 |goto 39.77,60.43
step
label "Collect_Trophy_Swoop_Quills"
kill Wiry Swoop##2969+
|tip They are pretty spread out around this area.
|tip You can find more to the north and south.
collect 8 Trophy Swoop Quill##4769 |q 761/1 |goto 39.77,60.43
step
label "Collect_Ambercorns"
click Ambercorn+
|tip They look like small brown pine cones on the ground near trees around this area.
collect 2 Ambercorn##4809 |q 771/2 |goto 38.83,59.75
You can find another one at [38.83,59.75]
step
Kill enemies around this area
Reach Level 6 |ding 6 |goto 39.77,60.43
step
talk Baine Bloodhoof##2993
accept Dwarven Digging##746 |goto 47.51,60.16
step
talk Mull Thunderhorn##2948
turnin Poison Water##748 |goto 48.53,60.39
|only if Tauren
step
Enter the building |goto 48.76,59.76 < 15 |walk
talk Harken Windtotem##2947
|tip Inside the building.
turnin Swoop Hunting##761 |goto 48.71,59.33
step
click Well Stone+
|tip They look like flat grey rocks on the ground around this area.
collect 2 Well Stone##4808 |q 771/1 |goto 53.50,66.20
step
Kill enemies around this area
Reach Level 7 |ding 7 |goto 54.49,67.70
stickystart "Kill_Palemane_Skinners"
stickystart "Kill_Palemane_Poachers"
step
kill 10 Palemane Tanner##2949 |q 745/1 |goto 53.94,72.53
You can find more around [48.08,71.60]
step
label "Kill_Palemane_Skinners"
kill 8 Palemane Skinner##2950 |q 745/2 |goto 53.94,72.53
You can find more around [48.08,71.60]
step
label "Kill_Palemane_Poachers"
kill 5 Palemane Poacher##2951 |q 745/3 |goto 53.94,72.53
You can find more around [48.08,71.60]
step
Kill Windfury enemies around this area
collect 8 Windfury Talon##4751 |q 743/1 |goto 63.26,70.44
You can find more around [66.26,68.80]
step
Leave the building |goto 46.81,60.54 < 10 |walk
talk Baine Bloodhoof##2993
turnin Sharing the Land##745 |goto 47.51,60.16
step
talk Ruul Eagletalon##2985
turnin Dangers of the Windfury##743 |goto 47.35,62.02
step
talk Mull Thunderhorn##2948
accept Winterhoof Cleansing##754 |goto 48.53,60.40
|only if Tauren
step
talk Zarlman Two-Moons##3054
turnin Rite of Vision##771 |goto 47.76,57.54
accept Rite of Vision##772 |goto 47.76,57.54
step
use the Winterhoof Cleansing Totem##5411
Cleanse the Winterhoof Water Well |q 754/1 |goto 53.64,66.15
|only if Tauren
step
Kill enemies around this area
Reach Level 8 |ding 8 |goto 53.64,66.15
step
talk Morin Cloudstalker##2988
|tip He walks along the road west of this point.
accept The Ravaged Caravan##749 |goto 59.72,62.45
He walks between here and [51.94,59.61]
step
talk Mull Thunderhorn##2948
turnin Winterhoof Cleansing##754 |goto 48.53,60.39
accept Thunderhorn Totem##756 |goto 48.53,60.39
|only if Tauren
step
click Sealed Supply Crate
turnin The Ravaged Caravan##749 |goto 53.74,48.18
accept The Ravaged Caravan##751 |goto 53.74,48.18
stickystart "Collect_Cougar_Claws"
stickystart "Collect_Stalker_Claws"
step
kill Flatland Cougar##3035+
collect Flatland Cougar Femur##4805 |q 766/2 |goto 46.78,40.19
You can find more around: |notinsticky
[51.33,35.52]
[37.14,43.56]
step
label "Collect_Cougar_Claws"
kill Flatland Cougar##3035+
collect 6 Cougar Claws##4802 |q 756/2 |goto 46.78,40.19
You can find more around: |notinsticky
[51.33,35.52]
[37.14,43.56]
|only if Tauren
step
label "Collect_Stalker_Claws"
kill Prairie Stalker##2959+
collect 6 Stalker Claws##4801 |q 756/1 |goto 46.78,40.19
You can find more around: |notinsticky
[51.33,35.52]
[37.14,43.56]
|only if Tauren
step
Kill Bael'dun enemies around this area
collect 5 Prospector's Pick##4702 |goto 33.08,48.20 |q 746
You can find more around [31.97,48.76]
step
Kill enemies around this area
Reach Level 9 |ding 9 |goto 33.08,48.20
You can find more around [31.97,48.76]
step
Follow the path |goto 35.31,46.24 < 30 |only if walking
Follow the path up |goto 34.46,37.31 < 30 |only if walking
Enter the cave |goto 33.31,36.45 < 15 |walk
talk Seer Wiserunner##2984
|tip Inside the cave.
turnin Rite of Vision##772 |goto 32.72,36.09
accept Rite of Wisdom##773 |goto 32.72,36.09
step
Leave the building |goto 46.81,60.57 < 10 |walk
talk Maur Raincaller##3055
turnin Mazzranache##766 |goto 46.98,57.07
step
talk Mull Thunderhorn##2948
turnin Thunderhorn Totem##756 |goto 48.53,60.40
|only if Tauren
step
Watch the dialogue
talk Mull Thunderhorn##2948
accept Thunderhorn Cleansing##758 |goto 48.53,60.40
|only if Tauren
step
use the Thunderhorn Cleansing Totem##5415
Cleanse the Thunderhorn Water Well |q 758/1 |goto 44.59,45.43
|only if Tauren
step
talk Mull Thunderhorn##2948
turnin Thunderhorn Cleansing##758 |goto 48.53,60.40
accept Wildmane Totem##759 |goto 48.53,60.40
|only if Tauren
step
talk Morin Cloudstalker##2988
|tip He walks along the road east of this point.
turnin The Ravaged Caravan##751 |goto 51.94,59.61
accept The Venture Co.##764 |goto 51.94,59.61
accept Supervisor Fizsprocket##765 |goto 51.94,59.61
He walks between here and [59.72,62.45]
step
kill Prairie Wolf Alpha##2960+
collect 8 Prairie Alpha Tooth##4803 |q 759/1 |goto 64.01,58.98
You can find more around [65.56,66.34]
|only if Tauren
step
Kill enemies around this area
Reach Level 10 |ding 10 |goto 64.01,58.98
step
talk Mull Thunderhorn##2948
turnin Wildmane Totem##759 |goto 48.53,60.40
|only if Tauren
step
Watch the dialogue
talk Mull Thunderhorn##2948
accept Wildmane Cleansing##760 |goto 48.53,60.40
|only if Tauren
step
talk Skorn Whitecloud##3052
accept The Hunter's Way##861 |goto 46.76,60.23
step
talk Krang Stonehoof##3063
accept Veteran Uzzek##1505 |goto Mulgore 49.52,60.58
|only if Tauren Warrior
step
Enter the Barrens |goto 69.49,60.50 < 30 |only if walking
talk Omusa Thunderhorn##10378
fpath Camp Taurajo |goto The Barrens 44.45,59.15
|only if Tauren Warrior
step
Follow the road |goto 47.66,55.60 < 30 |only if walking
Follow the path |goto 52.06,32.11 < 20 |only if walking
talk Devrak##3615
fpath Crossroads |goto 51.51,30.34
|only if Tauren Warrior
step
Follow the road |goto 53.84,22.61 < 30 |only if walking
talk Uzzek##5810
turnin Veteran Uzzek##1505 |goto 61.38,21.11
accept Path of Defense##1498 |goto 61.38,21.11
|only if Tauren Warrior
step
Cross the bridge |goto 62.68,19.22 < 20 |only if walking
Follow the path |goto Durotar 39.18,32.15 < 20 |only if walking
kill Thunder Lizard##3130+
collect 5 Singed Scale##6486 |q 1498/1 |goto Durotar 39.27,28.29
|only if Tauren Warrior
step
Follow the path |goto 39.16,32.31 < 20 |only if walking
Cross the bridge |goto 34.60,42.28 < 20 |only if walking
talk Uzzek##5810
turnin Path of Defense##1498 |goto The Barrens 61.38,21.11
|only if Tauren Warrior
step
Follow the road |goto 55.91,22.14 < 30 |only if walking
Follow the path |goto 51.87,29.19 < 20 |only if walking
Enter Mulgore |goto 71.63,60.56 < 30 |only if walking
Follow the path |goto Mulgore 57.36,60.92 < 30 |c |q 746
|only if Tauren Warrior
step
Enter the building |goto Mulgore 48.16,59.53 < 15 |walk
talk Narm Skychaser##3066
|tip Inside the building.
accept Call of Fire##2984 |goto Mulgore 48.39,59.16
|only if Tauren Shaman
step
Enter the Barrens |goto 69.49,60.50 < 30 |only if walking
talk Omusa Thunderhorn##10378
fpath Camp Taurajo |goto The Barrens 44.45,59.15
|only if Tauren Shaman
step
Follow the road |goto 47.66,55.60 < 30 |only if walking
Follow the path |goto 52.06,32.11 < 20 |only if walking
talk Devrak##3615
fpath The Crossroads |goto 51.51,30.34
|only if Tauren Shaman
step
talk Kranal Fiss##5907
turnin Call of Fire##2984 |goto 56.03,19.89
accept Call of Fire##1524 |goto 56.03,19.89
|only if Tauren Shaman
step
Cross the bridge |goto 62.67,19.22 < 20 |only if walking
Follow the path up |goto Durotar 36.59,57.07 < 15 |only if walking
Continue up the path |goto Durotar 36.61,58.19 < 7 |only if walking
Continue up the path |goto Durotar 37.74,58.24 < 7 |only if walking
Continue up the path |goto Durotar 38.94,57.56 < 7 |only if walking
Follow the path |goto Durotar 39.18,58.63 < 7 |only if walking
talk Telf Joolam##5900
|tip On top of the mountain.
turnin Call of Fire##1524 |goto Durotar 38.55,58.96
accept Call of Fire##1525 |goto Durotar 38.55,58.96
|only if Tauren Shaman
step
Follow the path down |goto 39.21,58.52 < 10 |only if walking
Follow the path |goto The Barrens 61.47,20.86 < 40 |only if walking
Kill Razormane enemies around this area
collect Fire Tar##5026 |q 1525/1 |goto The Barrens 54.15,25.01
|only if Tauren Shaman
step
Cross the bridge |goto 62.67,19.23 < 20 |only if walking
Follow the path |goto Durotar 50.78,43.81 < 20 |only if walking
Continue following the path |goto Durotar 54.15,40.72 < 20 |only if walking
Enter the cave |goto Durotar 52.82,28.82 < 15 |walk
Follow the path |goto Durotar 53.07,27.09 < 10 |walk
kill Burning Blade Cultist##3199+
|tip Inside the cave.
|tip They seem to mostly be towards the back of the cave.
collect Reagent Pouch##6652 |q 1525/2 |goto Durotar 52.12,24.95
|only if Tauren Shaman
step
Follow the path |goto 53.13,27.27 < 10 |walk
Leave the cave |goto 52.83,28.93 < 15 |walk
Jump down onto the huge long rock |goto 51.97,31.29 < 15 |only if walking
Follow the path up |goto 36.59,57.07 < 15 |only if walking
Continue up the path |goto 36.61,58.19 < 7 |only if walking
Continue up the path |goto 37.74,58.24 < 7 |only if walking
Continue up the path |goto 38.94,57.56 < 7 |only if walking
Follow the path |goto 39.18,58.63 < 7 |only if walking
talk Telf Joolam##5900
|tip On top of the mountain.
turnin Call of Fire##1525 |goto 38.55,58.96
accept Call of Fire##1526 |goto 38.55,58.96
|only if Tauren Shaman
step
Follow the path up |goto 38.34,58.52 < 7 |only if walking
use the Fire Sapta##6636
kill Minor Manifestation of Fire##5893
|tip On top of the mountain.
collect Glowing Ember##6655 |q 1526/1 |goto 38.84,58.24
|only if Tauren Shaman
step
click Brazier of the Dormant Flame
|tip On top of the mountain.
turnin Call of Fire##1526 |goto 38.95,58.22
accept Call of Fire##1527 |goto 38.95,58.22
|only if Tauren Shaman
step
Follow the path down |goto 39.19,57.81 < 7 |only if walking
talk Kranal Fiss##5907
turnin Call of Fire##1527 |goto The Barrens 56.04,19.89
|only if Tauren Shaman
step
Follow the path |goto 51.87,29.19 < 20 |only if walking
Enter Mulgore |goto 71.63,60.56 < 30 |only if walking
Follow the path |goto Mulgore 57.36,60.92 < 30 |c |q 746
|only if Tauren Shaman
step
talk Yaw Sharpmane##3065
accept Taming the Beast##6061 |goto Mulgore 47.82,55.69
|only if Tauren Hunter
step
use the Taming Rod##15914
|tip Use it on an Adult Plainstrider around this area.
Tame an Adult Plainstrider |q 6061/1 |goto 43.81,51.82
|tip Dismiss it after you tame it.
You can find more around [40.11,57.35]
|only if Tauren Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast##6061 |goto 47.82,55.69
accept Taming the Beast##6087 |goto 47.82,55.69
|only if Tauren Hunter
step
use the Taming Rod##15915
|tip Use it on a Prairie Stalker around this area.
Tame a Prairie Stalker |q 6087/1 |goto 46.48,49.06
|tip Dismiss it after you tame it.
|only if Tauren Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast##6087 |goto 47.82,55.69
accept Taming the Beast##6088 |goto 47.82,55.69
|only if Tauren Hunter
step
use the Taming Rod##15916
|tip Use it on a Swoop around this area.
Tame a Swoop |q 6088/1 |goto 46.48,49.06
|only if Tauren Hunter
step
talk Yaw Sharpmane##3065
turnin Taming the Beast#6088 |goto 47.82,55.69
accept Training the Beast##6089 |goto 47.82,55.69
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
Ride the elevator down |goto 31.81,65.90 < 10 |only if walking
Follow the path |goto Mulgore 42.46,39.35 < 30 |c |q 746
|only if Tauren Hunter
step
Enter the building |goto Mulgore 48.16,59.53 < 15 |walk
talk Gennia Runetotem##3064
|tip Inside the building.
accept Mulgore Heeding the Call##5926 |goto Mulgore 48.48,59.64
|only if Tauren Druid
step
Ride the elevator up |goto Thunder Bluff 31.80,65.96 < 10 |only if walking
Enter the building |goto Thunder Bluff 58.66,46.92 < 15 |walk
Cross the bridge |goto Thunder Bluff 61.44,40.20 < 10 |walk
Enter the building |goto Thunder Bluff 74.09,29.91 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Heeding the Call##5926 |goto Thunder Bluff 76.46,27.23
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
Follow the path |goto 42.47,34.44 < 20 |only if walking
talk Great Bear Spirit##11956
Ask it _"What do you represent, spirit?"_
Seek Out the Great Bear Spirit and Learn what it Has to Share with You About the Nature of the Bear |q 5930/1 |goto 39.11,27.51
|only if Tauren Druid
step
talk Faustron##12740
fpath Moonglade |goto 32.11,66.60
|only if Tauren Druid
step
Follow the road |goto 40.77,35.81 < 20 |only if walking
Enter the building |goto 56.13,30.98 < 15 |walk
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Great Bear Spirit##5930 |goto 56.21,30.64
accept Back to Thunder Bluff##5932 |goto 56.21,30.64
|only if Tauren Druid
step
Locate Bunthen Plainswind |goto 44.28,45.86 < 10 |c |q 5932
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
Ride the elevator down |goto 31.81,65.90 < 10 |only if walking
Enter the Barrens |goto Mulgore 69.61,60.47 < 30 |only if walking
Follow the path up |goto The Barrens 41.60,58.95 < 15 |only if walking
use the Cenarion Lunardust##15710
kill Lunaclaw##12138
Face Lunaclaw and Earn the Strength of Body and Heart it Possesses |q 6002/1 |goto The Barrens 42.00,60.86
|only if Tauren Druid
step
Enter Mulgore |goto 41.54,58.56 < 30 |only if walking
Cross the bridge |goto Mulgore 48.13,53.43 < 20 |only if walking
Ride the elevator up |goto Thunder Bluff 31.80,65.96 < 10 |only if walking
Enter the building |goto Thunder Bluff 58.66,46.92 < 15 |walk
Cross the bridge |goto Thunder Bluff 61.44,40.20 < 10 |walk
Enter the building |goto Thunder Bluff 74.09,29.91 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Body and Heart##6002 |goto Thunder Bluff 76.46,27.23
|only if Tauren Druid
step
Ride the elevator down |goto 31.81,65.90 < 10 |only if walking
Follow the path |goto Mulgore 42.46,39.35 < 30 |c |q 746
|only if Tauren Druid
stickystart "Kill_Venture_Co_Supervisors"
stickystart "Kill_Venture_Co_Workers"
step
Follow the path up |goto Mulgore 61.77,48.52 < 20 |only if walking
use the Prospector's Pick##4702+
|tip Use them next to the Forge.
collect 5 Broken Tools##4703 |q 746/1 |goto Mulgore 61.17,47.22
step
Enter the mine |goto 61.56,46.90 < 10 |walk
kill Supervisor Fizsprocket##3051
|tip Inside the mine.
collect Fizsprocket's Clipboard##4819 |q 765/1 |goto 64.90,43.31
step
label "Kill_Venture_Co_Supervisors"
kill 6 Venture Co. Supervisor##2979 |q 764/2 |goto 63.35,44.41
|tip Inside the mine.
|tip You can find more outside the mine.
step
label "Kill_Venture_Co_Workers"
Leave the mine |goto 61.45,47.20 < 15 |walk
kill 14 Venture Co. Worker##2978 |q 764/1 |goto 60.12,48.74
|tip You can mind more inside the mine up the hill nearby.
step
Follow the path |goto 58.85,48.91 < 40 |only if walking
Continue following the path |goto 56.36,43.59 < 30 |only if walking
talk Lorekeeper Raintotem##3233
accept A Sacred Burial##833 |goto 59.86,25.63
stickystart "Kill_Bristleback_Interlopers"
step
talk Ancestral Spirit##2994
turnin Rite of Wisdom##773 |goto 61.45,21.02
accept Journey into Thunder Bluff##775 |goto 61.45,21.02
step
label "Kill_Bristleback_Interlopers"
kill 8 Bristleback Interloper##3232 |q 833/1 |goto 61.22,21.26
step
talk Lorekeeper Raintotem##3233
turnin A Sacred Burial##833 |goto 59.86,25.63
step
Kill enemies around this area
Reach Level 11 |ding 11 |goto 61.22,21.26
step
Leave the building |goto 46.81,60.54 < 10 |walk
talk Baine Bloodhoof##2993
turnin Dwarven Digging##746 |goto 47.51,60.17
step
talk Morin Cloudstalker##2988
|tip He walks along the road east of this point.
turnin The Venture Co.##764 |goto 51.94,59.61
turnin Supervisor Fizsprocket##765 |goto 51.94,59.61
He walks between here and [59.72,62.45]
step
Ride the elevator up |goto Thunder Bluff 31.80,65.96 < 10 |only if walking
talk Eyahn Eagletalon##2987
accept Preparation for Ceremony##744 |goto Thunder Bluff 37.67,59.60
step
talk Cairne Bloodhoof##3057
|tip Inside the building.
turnin Journey into Thunder Bluff##775 |goto 60.29,51.68
accept Rites of the Earthmother##776 |goto 60.29,51.68
stickystart "Collect_Flatland_Prowler_Claws"
step
Ride the elevator down |goto 54.21,26.95 < 10 |only if walking
use the Wildmane Cleansing Totem##5416
Cleanse the Wildmane Well |q 760/1 |goto Mulgore 42.77,14.21
|only if Tauren
step
map Mulgore
path	follow loose;	loop;	ants curved
path	52.96,13.88		51.18,13.64		49.41,16.44		51.55,22.83
path	52.27,31.29		54.97,31.45		53.67,25.94		54.39,18.86
kill Arra'chea##3058
|tip It looks like a dark grey kodo that walks clockwise in a path around this whole area.
|tip This step's path will take you counter-clockwise to help you find it faster.
collect Horn of Arra'chea##4841 |q 776/1
stickystart "Collect_Bronze_Feathers"
step
kill Windfury Sorceress##2964+
collect 6 Azure Feather##4752 |q 744/1 |goto 55.99,16.24
You can find more around: |notinsticky
[54.44,11.34]
[51.93,6.71]
[39.73,6.93]
[36.60,11.33]
step
label "Collect_Bronze_Feathers"
kill Windfury Matriarch##2965+
collect 6 Bronze Feather##4753 |q 744/2 |goto 55.99,16.24
[54.44,11.34]
[51.93,6.71]
[39.73,6.93]
[36.60,11.33]
step
label "Collect_Flatland_Prowler_Claws"
kill Flatland Prowler##3566+
collect 4 Flatland Prowler Claw##5203 |q 861/1 |goto 45.10,17.36
You can find more around: |notinsticky
[51.03,13.25]
[39.72,12.05]
step
Kill enemies around this area
Reach Level 12 |ding 12 |goto 45.10,17.36
step
Follow the path up |goto Thunder Bluff 60.13,19.21 < 20 |only if walking
Ride the elevator up |goto Thunder Bluff 54.26,26.90 < 10 |only if walking
Enter the building |goto Thunder Bluff 74.09,29.90 < 15 |walk
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
accept The Barrens Oases##886 |goto Thunder Bluff 78.61,28.54
step
talk Cairne Bloodhoof##3057
|tip Inside the building.
turnin Rites of the Earthmother##776
step
talk Eyahn Eagletalon##2987
turnin Preparation for Ceremony##744 |goto 37.71,59.57
step
talk Melor Stonehoof##3441
turnin The Hunter's Way##861 |goto 61.53,80.89
accept Sergra Darkthorn##860 |goto 61.53,80.89
step
Leave the building |goto Mulgore 46.81,60.54 < 10 |walk
talk Mull Thunderhorn##2948
turnin Wildmane Cleansing##760 |goto Mulgore 48.53,60.39
|only if Tauren
step
Enter the Barrens |goto 69.29,60.46 < 30 |c |q 860
step
talk Omusa Thunderhorn##10378
fpath Camp Taurajo |goto The Barrens 44.45,59.15
step
talk Kirge Sternhorn##3418
accept Journey to the Crossroads##854 |goto 44.88,58.61
|only if Tauren
step
Follow the road |goto 47.41,57.43 < 30 |only if walking
Follow the path |goto 52.08,32.21 < 20 |only if walking
talk Tonga Runetotem##3448
turnin The Barrens Oases##886 |goto 52.26,31.93
step
talk Sergra Darkthorn##3338
turnin Sergra Darkthorn##860 |goto 52.23,31.01
step
talk Thork##3429
turnin Journey to the Crossroads##854 |goto 51.50,30.87
|only if Tauren
step
talk Devrak##3615
fpath Crossroads |goto 51.50,30.34
step
Follow the road |goto 55.47,22.17 < 30 |only if walking
Cross the bridge |goto 62.68,19.22 < 20 |only if walking
Follow the path |goto Durotar 40.61,32.90 < 30 |only if walking
Follow the road |goto Durotar 46.64,21.63 < 30 |only if walking
Enter Orgrimmar |goto Durotar 45.52,12.07 < 20 |only if walking
Enter the building |goto Orgrimmar 47.47,65.13 < 15 |only if walking
talk Doras##3310
|tip At the top of the tower.
fpath Orgrimmar |goto Orgrimmar 45.13,63.90
step
Follow the path |goto 52.51,85.25 < 20 |only if walking
Leave Orgrimmar |goto 49.08,94.77 < 20 |only if walking
Enter Undercity |goto Tirisfal Glades 61.86,65.03 < 15 |only if walking
talk Michael Garrett##4551
fpath Undercity |goto Undercity 63.28,48.58
step
Leave Undercity |goto 66.19,0.63 < 10 |walk
Follow the road |goto Tirisfal Glades 56.17,65.88 < 30 |c |q 435 |future
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Orc & Troll (1-12)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
condition_suggested=function() return (raceclass('Orc') or raceclass('Troll')) and level <= 12 end,
condition_suggested_exclusive=true,
next="Leveling Guides\\Leveling (12-20)",
startlevel=1,
endlevel=12,
},[[
author support@zygorguides.com
defaultfor Orc
next Leveling (13-20)
step
talk Kaltunk##10176
accept Your Place In The World##4641 |goto Durotar 43.29,68.54
step
talk Ruzan##5765
accept Vile Familiars##1485 |goto 42.59,69.00
|only if Orc Warlock
step
Enter the cave |goto 42.28,68.42 < 7 |walk
talk Gornek##3143
|tip Inside the cave.
turnin Your Place In The World##4641 |goto 42.06,68.33
accept Cutting Teeth##788 |goto 42.06,68.33
step
Leave the cave |goto 42.31,68.43 < 7 |walk
kill 10 Mottled Boar##3098 |q 788/1 |goto 44.23,70.68
You can find more around [44.45,64.80]
step
Kill enemies around this area
Reach Level 2 |ding 2 |goto 44.23,70.68
step
talk Zureetha Fargaze##3145
accept Vile Familiars##792 |goto 42.85,69.14
|only if not Orc Warlock
step
Enter the cave |goto 42.28,68.42 < 7 |walk
talk Gornek##3143
|tip Inside the cave.
turnin Cutting Teeth##788 |goto 42.06,68.33
accept Simple Parchment##2383 |goto 42.06,68.33 |only Orc Warrior
accept Rune-Inscribed Parchment##3089 |goto 42.06,68.33 |only Orc Shaman
accept Encrypted Parchment##3088 |goto 42.06,68.33 |only Orc Rogue
accept Etched Parchment##3087 |goto 42.06,68.33 |only Orc Hunter
accept Tainted Parchment##3090 |goto 42.06,68.33 |only Orc Warlock
accept Simple Tablet##3065 |goto 42.06,68.33 |only Troll Warrior
accept Etched Tablet##3082 |goto 42.06,68.33 |only Troll Hunter
accept Encrypted Tablet##3083 |goto 42.06,68.33 |only Troll Rogue
accept Hallowed Tablet##3085 |goto 42.06,68.33 |only Troll Priest
accept Rune-Inscribed Tablet##3084 |goto 42.06,68.33 |only Troll Shaman
accept Glyphic Tablet##3086 |goto 42.06,68.33 |only Troll Mage
accept Sting of the Scorpid##789 |goto 42.06,68.33
step
talk Rwag##3155
|tip Inside the cave.
turnin Encrypted Parchment##3088 |goto 41.28,68.00
|only if Orc Rogue
step
talk Rwag##3155
|tip Inside the cave.
turnin Encrypted Tablet##3083 |goto 41.28,68.00
|only if Troll Rogue
step
talk Nartok##3156
|tip Inside the cave.
turnin Tainted Parchment##3090 |goto 40.65,68.51
|only if Orc Warlock
step
Leave the cave |goto 42.31,68.43 < 7 |walk
talk Galgar##9796
accept Galgar's Cactus Apple Surprise##4402 |goto 42.73,67.24
step
talk Ken'jai##3707
turnin Hallowed Tablet##3085 |goto 42.36,68.82
|only if Troll Priest
step
talk Frang##3153
turnin Simple Parchment##2383 |goto 42.89,69.43
|only if Orc Warrior
step
talk Frang##3153
turnin Simple Tablet##3065 |goto 42.89,69.43
|only if Troll Warrior
step
talk Shikrik##3157
turnin Rune-Inscribed Parchment##3089 |goto 42.39,69.00
|only if Orc Shaman
step
talk Shikrik##3157
turnin Rune-Inscribed Tablet##3084 |goto 42.39,69.00
|only if Troll Shaman
step
talk Jen'shan##3154
turnin Etched Parchment##3087 |goto 42.84,69.32
|only if Orc Hunter
step
talk Jen'shan##3154
turnin Etched Tablet##3082 |goto 42.84,69.32
|only if Troll Hunter
step
talk Mai'ah##5884
turnin Glyphic Tablet##3086 |goto 42.51,69.04
|only if Troll Mage
stickystart "Grind_To_Level_3"
step
click Cactus Apple+
|tip They look like green cactuses with small round red balls on them on the ground around this area.
collect 10 Cactus Apple##11583 |q 4402/1 |goto 44.03,67.01
You can find more around: |notinsticky
[44.38,65.05]
[45.73,64.55]
[45.83,63.09]
[43.65,62.78]
[44.86,61.67]
[46.39,60.45]
[44.86,58.88]
step
label "Grind_To_Level_3"
Kill enemies around this area
Reach Level 3 |ding 3 |goto 44.57,64.33
You can find more around [45.11,57.47]
step
label "Collect_Vile_Familiar_Heads"
kill Vile Familiar##3101+
|tip Inside and outside the cave.
collect 6 Vile Familiar Head##6487 |q 1485/1 |goto 45.34,56.36
|only if Orc Warlock
step
talk Foreman Thazz'ril##11378
accept Lazy Peons##5441 |goto 44.62,68.64
step
talk Galgar##9796
turnin Galgar's Cactus Apple Surprise##4402 |goto 42.73,67.24
step
talk Ruzan##5765
turnin Vile Familiars##1485 |goto 42.59,69.00
accept Vile Familiars##1499 |goto 42.59,69.00
|only if Orc Warlock
step
talk Zureetha Fargaze##3145
turnin Vile Familiars##1499 |goto 42.85,69.15
|only if Orc Warlock
stickystart "Collect_Scorpid_Worker_Tails"
step
use the Foreman's Blackjack##16114
|tip Use it on Lazy Peons around this area.
|tip They look like orcs sleeping on the ground around this area.
|tip If they aren't sleeping, either wait for them to sleep, or go to a different location.
Awaken #5# Peons |q 5441/1 |goto 44.98,69.13
You can find more around: |notinsticky
[44.68,72.81]
[42.35,73.24]
[41.25,72.68]
[47.56,69.34]
[47.18,65.46]
[46.84,60.79]
step
talk Foreman Thazz'ril##11378
turnin Lazy Peons##5441 |goto 44.62,68.64
accept Thazz'ril's Pick##6394 |goto 44.62,68.64
stickystop "Collect_Scorpid_Worker_Tails"
step
Follow the path |goto 43.85,66.94 < 30 |c |q 790 |future
step
Kill enemies around this area
Reach Level 4 |ding 4 |goto 44.39,64.46
stickystart "Collect_Scorpid_Worker_Tails"
step
talk Hana'zua##3287
accept Sarkoth##790 |goto 40.60,62.59
step
Follow the path up |goto 40.70,65.10 < 10 |only if walking
kill Sarkoth##3281
|tip It looks like a darker colored scorpion that walks around this area.
collect Sarkoth's Mangled Claw##4905 |q 790/1 |goto 40.50,66.82
step
label "Collect_Scorpid_Worker_Tails"
kill Scorpid Worker##3124+
collect 10 Scorpid Worker Tail##4862 |q 789/1 |goto 40.50,66.82
You can find more around [40.71,62.39]
step
talk Hana'zua##3287
turnin Sarkoth##790 |goto 40.60,62.59
accept Sarkoth##804 |goto 40.60,62.59
step
Follow the path up |goto 40.70,65.10 < 10 |only if walking
Jump down and enter the cave |goto 42.29,68.43 < 7 |walk
talk Gornek##3143
|tip Inside the cave.
turnin Sting of the Scorpid##789 |goto 42.05,68.32
turnin Sarkoth##804 |goto 42.05,68.32
stickystart "Collect_Vile_Familiar_Heads"
stickystart "Kill_Vile_Familiars"
step
Leave the cave |goto 42.29,68.43 < 7 |walk
Follow the path |goto 43.85,66.94 < 30 |c |q 6394 |future
step
Kill enemies around this area
Reach Level 5 |ding 5 |goto 44.39,64.46
step
Enter the cave |goto 45.34,56.36 < 10 |walk
Follow the path |goto 44.42,54.58 < 10 |walk
click Thazz'ril's Pick
|tip Inside the cave.
collect Thazz'ril's Pick##16332 |q 6394/1 |goto 43.73,53.79
step
Follow the path |goto 44.40,54.57 < 10 |walk
Follow the path |goto 44.98,54.87 < 10 |only if walking
Leave the cave |goto 45.33,56.44 < 10 |c |q 794 |future
step
label "Kill_Vile_Familiars"
kill 12 Vile Familiar##3101 |q 792/1 |goto 45.34,56.36
|tip Inside and outside the cave.
|only if not Orc Warlock
step
talk Foreman Thazz'ril##11378
turnin Thazz'ril's Pick##6394 |goto 44.62,68.64
step
talk Zureetha Fargaze##3145
turnin Vile Familiars##792 |goto 42.85,69.15 |only if not Orc Warlock
accept Burning Blade Medallion##794 |goto 42.85,69.15
step
talk Canaga Earthcaller##5887
accept Call of Earth##1516 |goto 42.41,69.17
|only if Shaman
step
Follow the path |goto 43.89,67.09 < 30 |c |q 794
step
Kill enemies around this area
Reach Level 6 |ding 6 |goto 45.41,57.60
stickystart "Collect_Felstalker_Hoofs"
step
Enter the cave |goto 45.34,56.36 < 10 |walk
Follow the path |goto 44.78,54.36 < 10 |walk
Continue following the path |goto 44.45,52.74 < 10 |walk
Continue following the path |goto 43.39,52.01 < 10 |walk
kill Yarrog Baneshadow##3183
|tip Inside the cave.
collect Burning Blade Medallion##4859 |q 794/1 |goto 42.71,52.95
step
label "Collect_Felstalker_Hoofs"
kill Felstalker##3102+
|tip Inside the cave.
collect 2 Felstalker Hoof##6640 |q 1516/1 |goto 44.82,54.59
|only if Shaman
step
talk Zureetha Fargaze##3145
turnin Burning Blade Medallion##794 |goto 42.85,69.15
accept Report to Sen'jin Village##805 |goto 42.85,69.15
step
talk Canaga Earthcaller##5887
turnin Call of Earth##1516 |goto 42.41,69.17
accept Call of Earth##1517 |goto 42.41,69.17
|only if Shaman
step
Follow the path |goto 43.57,69.85 < 20 |only if walking
Follow the path up |goto 41.56,73.28 < 15 |only if walking
Continue up the path |goto 40.74,74.35 < 10 |only if walking
Follow the path |goto 42.49,74.89 < 10 |only if walking
use the Earth Sapta##6635
talk Minor Manifestation of Earth##5891
turnin Call of Earth##1517 |goto 44.03,76.20
accept Call of Earth##1518 |goto 44.03,76.20
|only if Shaman
step
Jump down here |goto 43.73,74.92 < 10 |only if walking
Follow the path |goto 43.49,69.67 < 30 |only if walking
talk Canaga Earthcaller##5887
turnin Call of Earth##1518 |goto 42.41,69.17
|only if Shaman
step
Follow the road |goto 47.98,67.45 < 30 |only if walking
talk Ukor##6786
accept A Peon's Burden##2161 |goto 52.06,68.31
step
talk Lar Prowltusk##3140
|tip He walks around this area.
accept Thwarting Kolkar Aggression##786 |goto 54.19,73.29
Also check around:
[54.63,74.72]
[54.09,76.49]
step
talk Master Gadrin##3188
turnin Report to Sen'jin Village##805 |goto 55.95,74.72
accept Minshina's Skull##808 |goto 55.95,74.72
accept Zalazane##826 |goto 55.95,74.72
accept Report to Orgnil##823 |goto 55.95,74.72
step
talk Master Vornal##3304
accept A Solvent Spirit##818 |goto 55.94,74.39
step
talk Vel'rin Fang##3194
|tip Inside the building.
accept Practical Prey##817 |goto 55.96,73.92
step
Follow the road |goto 52.62,66.66 < 30 |only if walking
Follow the path |goto 52.46,44.41 < 15 |only if walking
talk Orgnil Soulscar##3142
turnin Report to Orgnil##823 |goto 52.25,43.15
accept Dark Storms##806 |goto 52.25,43.15
step
talk Gar'Thok##3139
|tip Upstairs inside the building.
accept Vanquish the Betrayers##784 |goto 51.95,43.50
accept Encroachment##837 |goto 51.95,43.50
step
Enter the building |goto 51.84,41.95 < 7 |walk
talk Innkeeper Grosk##6928
|tip Inside the building.
turnin A Peon's Burden##2161 |goto 51.52,41.65
step
talk Innkeeper Grosk##6928
|tip Inside the building.
home Razor Hill |goto 51.52,41.65
step
Leave the building |goto 51.84,41.95 < 7 |walk
talk Cook Torka##3191
|tip He walks around this area.
accept Break a Few Eggs##815 |goto 51.11,42.45
step
Follow the path |goto 50.66,43.91 < 15 |only if walking
Follow the path up |goto 48.00,42.81 < 15 |only if walking
talk Furl Scornbrow##3147
|tip At the top of the tower.
accept Carry Your Weight##791 |goto 49.89,40.38
step
Follow the path |goto 52.49,44.54 < 15 |c |q 818
step
Kill enemies around this area
Reach Level 7 |ding 7 |goto 58.57,44.15
stickystart "Collect_Intact_Makrura_Eyes"
step
kill Pygmy Surf Crawler##3106+
|tip Underwater around this area.
collect 8 Crawler Mucus##4888 |q 818/2 |goto 62.40,47.97
You can find more underwater around [64.42,56.09]
step
label "Collect_Intact_Makrura_Eyes"
Kill Makrura enemies around this area
|tip Underwater around this area.
collect 4 Intact Makrura Eye##4887 |q 818/1 |goto 62.40,47.97
You can find more underwater around [64.42,56.09]
stickystart "Kill_Kul_Tiras_Sailors"
stickystart "Kill_Kul_Tiras_Marines"
stickystart "Grind_To_Level_8"
step
Kill Kul Tiras enemies around this area
collect 8 Canvas Scraps##4870 |q 791/1 |goto 58.21,57.44
You can find more around [57.72,52.62]
step
label "Kill_Kul_Tiras_Sailors"
kill 10 Kul Tiras Sailor##3128 |q 784/1 |goto 58.21,57.44
You can find more around [57.72,52.62]
step
label "Kill_Kul_Tiras_Marines"
kill 8 Kul Tiras Marine##3129 |q 784/2 |goto 58.21,57.44
You can find more around [57.72,52.62]
step
label "Grind_To_Level_8"
Kill enemies around this area
|tip You will have to enter the fort nearby next, and it's easier if you're at least level 8 already.
Reach Level 8 |ding 8 |goto 49.86,49.33
step
Enter the building |goto 58.99,58.30 < 10 |walk
Run up the stairs |goto 59.86,58.28 < 5 |walk
kill Lieutenant Benedict##3192 |q 784/3 |goto 59.71,58.27
|tip Upstairs inside the building.
collect Benedict's Key##4882 |goto 59.71,58.27 |q 830 |future
step
Follow the path |goto 59.23,57.98 < 5 |walk
Run up the stairs |goto 59.90,57.87 < 5 |walk
click Benedict's Chest
|tip Upstairs, on top of the building.
collect Aged Envelope##4881 |goto 59.26,57.66 |q 830 |future
step
use the Aged Envelope##4881
accept The Admiral's Orders##830
step
Leave the building |goto 51.83,41.94 < 7 |walk
talk Gar'Thok##3139
|tip Upstairs inside the building.
turnin Vanquish the Betrayers##784 |goto 51.95,43.50
accept From The Wreckage....##825 |goto 51.95,43.50
turnin The Admiral's Orders##830 |goto 51.95,43.50
accept The Admiral's Orders##831 |goto 51.95,43.50
step
Follow the path |goto 52.46,44.53 < 15 |only if walking
click Gnomish Toolbox+
|tip They look like grey metal chests on the ground underwater around this area.
collect 3 Gnomish Tools##4863 |q 825/1 |goto 62.02,46.29
You can find more around: |notinsticky
[61.96,42.14]
[64.36,53.46]
stickystart "Kill_Razormane_Scouts"
step
kill 4 Razormane Quilboar##3111 |q 837/1 |goto 49.86,49.33
step
label "Kill_Razormane_Scouts"
kill 4 Razormane Scout##3112 |q 837/2 |goto 49.86,49.33
step
Follow the path |goto 52.49,44.54 < 15 |only if walking
talk Gar'Thok##3139
|tip Upstairs inside the building.
turnin From The Wreckage....##825 |goto 51.95,43.50
step
Follow the path |goto 50.66,43.91 < 15 |only if walking
Follow the path up |goto 48.00,42.81 < 15 |only if walking
talk Furl Scornbrow##3147
|tip At the top of the tower.
turnin Carry Your Weight##791 |goto 49.89,40.38
step
Follow the path |goto 52.49,44.54 < 15 |c |q 786
step
Kill enemies around this area
Reach Level 9 |ding 9 |goto 58.21,57.44
You can find more around [57.72,52.62]
step
Follow the path |goto 52.69,70.96 < 30 |only if walking
Follow the path |goto 50.85,79.14 < 15 |only if walking
Enter the building |goto 49.89,80.80 < 7 |walk
click Attack Plan: Valley of Trials
|tip Inside the building.
Destroy the Attack Plan: Valley of Trials |q 786/1 |goto 49.82,81.28
step
Leave the building |goto 49.89,80.80 < 7 |walk
click Attack Plan: Sen'jin Village
Destroy the Attack Plan: Sen'jin Village |q 786/2 |goto 47.66,77.34
step
Follow the path |goto 47.66,80.69 < 20 |only if walking
click Attack Plan: Orgrimmar
Destroy the Attack Plan: Orgrimmar |q 786/3 |goto 46.23,78.95
step
Follow the path |goto 50.88,79.14 < 15 |only if walking
talk Lar Prowltusk##3140
|tip He walks around this area.
turnin Thwarting Kolkar Aggression##786 |goto 54.19,73.29
Also check around:
[54.63,74.72]
[54.09,76.49]
step
talk Master Vornal##3304
turnin A Solvent Spirit##818 |goto 55.94,74.39
stickystart "Collect_Taillasher_Eggs"
stickystart "Collect_Durotar_Tiger_Fur"
stickystart "Kill_Hexed_Trolls"
stickystart "Kill_Voodoo_Trolls"
step
kill Zalazane##3205
|tip He walks around this area.
collect Zalazane's Head##4866 |q 826/3 |goto 67.29,87.05
step
click Imprisoned Darkspear
|tip They look like skulls on the ground.
collect Minshina's Skull##4864 |q 808/1 |goto 67.45,87.81
step
label "Kill_Hexed_Trolls"
kill 8 Hexed Troll##3207 |q 826/1 |goto 67.17,86.99
You can find more around [67.36,83.45]
step
label "Kill_Voodoo_Trolls"
kill 8 Voodoo Troll##3206 |q 826/2 |goto 67.17,86.99
You can find more around [67.36,83.45]
step
label "Collect_Taillasher_Eggs"
click Taillasher Eggs+
|tip They look like clusters of purple eggs on the ground near trees around this area.
collect 3 Taillasher Egg##4890 |q 815/1 |goto 64.56,73.28
You can find more at:
[61.37,78.34]
[60.33,82.86]
[59.78,89.67]
[63.00,94.44]
step
label "Collect_Durotar_Tiger_Fur"
kill Durotar Tiger##3121+
collect 4 Durotar Tiger Fur##4892 |q 817/1 |goto 65.28,80.55
You can find more around: |notinsticky
[59.78,89.67]
[60.33,82.86]
step
talk Master Gadrin##3188
turnin Minshina's Skull##808 |goto 55.95,74.72
turnin Zalazane##826 |goto 55.95,74.72
|tip You will receive a "Faintly Glowing Skull" item as a quest reward.
|tip Be careful not to accidentally sell it to a vendor.
step
talk Vel'rin Fang##3194
|tip Inside the building.
turnin Practical Prey##817 |goto 55.95,73.93
step
Kill enemies around this area
Reach Level 10 |ding 10 |goto 67.17,86.99
You can find more around [67.36,83.45]
step
Leave the building |goto 51.81,41.96 < 7 |walk
talk Cook Torka##3191
|tip He walks around this area.
turnin Break a Few Eggs##815 |goto 51.11,42.45
step
Enter the building |goto Durotar 53.25,42.59 < 7 |walk
talk Tarshaw Jaggedscar##3169
|tip Inside the building.
accept Veteran Uzzek##1505 |goto Durotar 54.19,42.46
|only if Warrior
step
Leave the building |goto 53.27,42.59 < 7 |walk
Follow the road |goto 50.64,43.97 < 15 |only if walking
Cross the bridge |goto 34.60,42.31 < 15 |only if walking
talk Uzzek##5810
turnin Veteran Uzzek##1505 |goto The Barrens 61.38,21.11
accept Path of Defense##1498 |goto The Barrens 61.38,21.11
|only if Warrior
step
Cross the bridge |goto 62.68,19.22 < 15 |only if walking
Follow the path |goto Durotar 39.18,32.15 < 15 |only if walking
kill Thunder Lizard##3130+
collect 5 Singed Scale##6486 |q 1498/1 |goto Durotar 39.27,28.29
|only if Warrior
step
Follow the path |goto 39.16,32.31 < 15 |only if walking
Cross the bridge |goto 34.60,42.28 < 15 |only if walking
talk Uzzek##5810
turnin Path of Defense##1498 |goto The Barrens 61.38,21.11
|only if Warrior
step
Cross the bridge |goto 62.67,19.22 < 15 |c |q 837
|only if Warrior
step
talk Ophek##3294
|tip Outside, behind the building.
accept Gan'rul's Summons##1506 |goto Durotar 54.37,41.29
|only if Warlock
step
Follow the road |goto 52.37,40.01 < 30 |only if walking
Enter Orgrimmar |goto 45.54,12.06 < 20 |only if walking
Follow the path |goto Orgrimmar 51.55,58.13 < 20 |only if walking
Follow the path down |goto Orgrimmar 55.96,41.03 < 15 |walk
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin Gan'rul's Summons##1506 |goto Orgrimmar 48.24,45.29
accept Creature of the Void##1501 |goto Orgrimmar 48.24,45.29
|only if Warlock
step
Follow the path up |goto 43.93,56.80 < 10 |walk
Follow the path |goto 38.49,54.16 < 10 |walk
Follow the path |goto 52.50,85.13 < 20 |only if walking
Leave Orgrimmar |goto 49.10,94.75 < 20 |only if walking
Enter the cave |goto Durotar 55.02,9.79 < 10 |walk
Follow the path |goto Durotar 53.80,8.83 < 10 |walk
Continue following the path |goto Durotar 52.75,7.87 < 10 |walk
Continue following the path |goto Durotar 51.68,8.23 < 10 |walk
click Burning Blade Stash
|tip Inside the cave.
collect Tablet of Verga##6535 |q 1501/1 |goto Durotar 51.62,9.74
|only if Warlock
step
Follow the path |goto 51.73,8.10 < 10 |walk
Continue following the path |goto 52.49,8.31 < 10 |walk
Continue following the path |goto 54.20,8.92 < 10 |walk
Leave the cave |goto 55.03,9.87 < 10 |walk
Enter Orgrimmar |goto 45.54,12.06 < 20 |only if walking
Follow the path |goto Orgrimmar 51.55,58.13 < 20 |only if walking
Follow the path down |goto Orgrimmar 55.96,41.03 < 10 |walk
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin Creature of the Void##1501 |goto Orgrimmar 48.24,45.29
accept The Binding##1504 |goto Orgrimmar 48.24,45.29
|only if Warlock
step
use Glyphs of Summoning##7464
|tip Use it while standing on the pink symbol on the ground.
|tip Inside the tent.
kill Summoned Voidwalker##5676 |q 1504/1 |goto 49.44,50.02
|only if Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin The Binding##1474 |goto 48.24,45.29
|only if Warlock
step
Follow the path up |goto 43.93,56.80 < 10 |walk
Follow the path |goto 38.49,54.16 < 10 |walk
Follow the path |goto 52.50,85.13 < 20 |only if walking
Leave Orgrimmar |goto 49.10,94.75 < 20 |only if walking
Follow the path |goto Durotar 45.92,24.46 < 30 |c |q 837
|only if Warlock
step
Enter the building |goto Durotar 53.25,42.59 < 7 |walk
talk Swart##3173
|tip Inside the building.
accept Call of Fire##2983 |goto Durotar 54.42,42.58
|only if Shaman
step
Leave the building |goto 53.27,42.59 < 7 |walk
Follow the road |goto 50.64,43.97 < 15 |only if walking
Cross the bridge |goto 34.60,42.31 < 15 |only if walking
talk Kranal Fiss##5907
turnin Call of Fire##2983 |goto The Barrens 56.03,19.89
accept Call of Fire##1524 |goto The Barrens 56.03,19.89
|only if Shaman
step
Cross the bridge |goto 62.67,19.22 < 15 |only if walking
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
Follow the path down |goto 39.21,58.52 < 7 |only if walking
Follow the path |goto The Barrens 61.47,20.86 < 40 |only if walking
Kill Razormane enemies around this area
collect Fire Tar##5026 |q 1525/1 |goto The Barrens 54.15,25.01
|only if Shaman
step
Cross the bridge |goto 62.67,19.23 < 15 |only if walking
Follow the path |goto Durotar 50.78,43.81 < 15 |only if walking
Continue following the path |goto Durotar 54.15,40.72 < 15 |only if walking
Enter the cave |goto Durotar 52.82,28.82 < 10 |walk
Follow the path |goto Durotar 53.07,27.09 < 10 |walk
kill Burning Blade Cultist##3199+
|tip Inside the cave.
|tip They seem to mostly be towards the back of the cave.
collect Reagent Pouch##6652 |q 1525/2 |goto Durotar 52.12,24.95
|only if Shaman
step
Follow the path |goto 53.13,27.27 < 10 |walk
Leave the cave |goto 52.83,28.93 < 10 |walk
Jump down onto the huge long rock |goto 51.97,31.29 < 15 |only if walking
Follow the path up |goto 36.59,57.07 < 10 |only if walking
Continue up the path |goto 36.61,58.19 < 5 |only if walking
Continue up the path |goto 37.74,58.24 < 5 |only if walking
Continue up the path |goto 38.94,57.56 < 5 |only if walking
Follow the path |goto 39.18,58.63 < 5 |only if walking
talk Telf Joolam##5900
|tip On top of the mountain.
turnin Call of Fire##1525 |goto 38.55,58.96
accept Call of Fire##1526 |goto 38.55,58.96
|only if Shaman
step
Follow the path up |goto 38.34,58.52 < 5 |only if walking
use the Fire Sapta##6636
kill Minor Manifestation of Fire##5893
|tip On top of the mountain.
collect Glowing Ember##6655 |q 1526/1 |goto 38.84,58.24
|only if Shaman
step
click Brazier of the Dormant Flame
|tip On top of the mountain.
turnin Call of Fire##1526 |goto 38.95,58.22
accept Call of Fire##1527 |goto 38.95,58.22
|only if Shaman
step
Follow the path down |goto 39.19,57.81 < 5 |only if walking
talk Kranal Fiss##5907
turnin Call of Fire##1527 |goto The Barrens 56.04,19.89
|only if Shaman
step
Cross the bridge |goto 62.67,19.22 < 15 |c |q 837
|only if Shaman
step
talk Thotar##3171
|tip Inside the building.
accept Taming the Beast##6062 |goto Durotar 51.85,43.49
|only if Hunter
step
Follow the path |goto 52.48,44.53 < 15 |only if walking
use the Taming Rod##15917
|tip Use it on a Dire Mottled Boar around this area.
Tame a Dire Mottled Boar |q 6062/1 |goto 51.84,47.23
|tip Dismiss it after you tame it.
|only if Hunter
step
Follow the path |goto 52.46,44.32 < 15 |only if walking
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6062 |goto 51.85,43.49
accept Taming the Beast##6083 |goto 51.85,43.49
|only if Hunter
step
Follow the path |goto 54.36,39.59 < 20 |only if walking
use the Taming Rod##15919
|tip Use it on a Surf Crawler around this area.
Tame a Surf Crawler |q 6083/1 |goto 59.01,27.64
|tip Dismiss it after you tame it.
|only if Hunter
step
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6083 |goto 51.85,43.49
accept Taming the Beast##6082 |goto 51.85,43.49
|only if Hunter
step
Follow the path |goto 50.66,43.92 < 15 |only if walking
use the Taming Rod##15920
|tip Use it on an Armored Scorpid around this area.
Tame an Armored Scorpid |q 6082/1 |goto 45.21,45.77
|only if Hunter
step
Follow the path |goto 50.79,43.82 < 15 |only if walking
talk Thotar##3171
|tip Inside the building.
turnin Taming the Beast##6082 |goto 51.85,43.49
accept Training the Beast##6081 |goto 51.85,43.49
|only if Hunter
step
Follow the road |goto 52.38,39.19 < 30 |only if walking
Enter Orgrimmar |goto 45.54,12.06 < 20 |only if walking
Follow the path |goto Orgrimmar 51.81,57.97 < 20 |only if walking
Follow the path |goto Orgrimmar 62.92,38.87 < 20 |only if walking
Follow the path up |goto Orgrimmar 71.64,25.95 < 15 |only if walking
Follow the path up |goto Orgrimmar 67.68,14.51 < 7 |only if walking
talk Ormak Grimshot##3352
turnin Training the Beast##6081 |goto Orgrimmar 66.05,18.54
|only if Hunter
step
Follow the path |goto 67.42,39.25 < 20 |only if walking
Continue following the path |goto 51.54,58.21 < 20 |only if walking
Follow the path |goto 52.50,85.13 < 20 |only if walking
Leave Orgrimmar |goto 49.10,94.75 < 20 |only if walking
Follow the path |goto Durotar 45.92,24.46 < 30 |c |q 837
|only if Hunter
step
Enter the building |goto Durotar 53.24,42.59 < 10 |walk
talk Tai'jin##3706
|tip Inside the building.
accept Hex of Weakness##5652 |goto Durotar 54.26,42.93
|only if Troll Priest
step
Leave the building |goto 53.24,42.59 < 10 |walk
Follow the road |goto 52.38,39.19 < 30 |only if walking
Enter Orgrimmar |goto 45.54,12.06 < 20 |only if walking
talk Ur'kyo##6018
|tip Inside the building.
turnin Hex of Weakness##5652 |goto Orgrimmar 35.59,87.83
|only if Troll Priest
stickystart "Kill_Razormane_Battleguards"
step
kill 4 Razormane Dustrunner##3113 |q 837/3 |goto Durotar 42.94,39.44
step
label "Kill_Razormane_Battleguards"
kill 4 Razormane Battleguard##3114 |q 837/4 |goto 42.94,39.44
step
Enter the building |goto 43.11,30.44 < 7 |walk
talk Misha Tor'kren##3193
|tip She walks around inside the building.
accept Lost But Not Forgotten##816 |goto 43.11,30.24
step
Leave the building |goto 43.11,30.44 < 7 |walk
Follow the path up |goto 47.14,35.57 < 30 |only if walking
talk Gar'Thok##3139
|tip Upstairs inside the building.
turnin Encroachment##837 |goto 51.95,43.50
step
Follow the road |goto 52.40,38.91 < 30 |only if walking
talk Rezlak##3293
accept Winds in the Desert##834 |goto 46.37,22.94
step
Kill enemies around this area
Reach Level 11 |ding 11 |goto 43.49,20.79
step
Follow the path |goto 45.54,27.05 < 30 |only if walking
Follow the path |goto 46.25,30.05 < 15 |only if walking
click Stolen Supply Sack+
|tip They look like tan bags on the ground around this area.
collect 5 Sack of Supplies##4918 |q 834/1 |goto 47.28,30.52
You can find more around: |notinsticky
[48.33,33.75]
[49.09,33.10]
[49.63,32.13]
step
Follow the road |goto 50.84,31.20 < 15 |only if walking
talk Rezlak##3293
turnin Winds in the Desert##834 |goto 46.37,22.94
accept Securing the Lines##835 |goto 46.37,22.94
stickystart "Kill_Dustwind_Savages"
step
Follow the path |goto 49.68,28.45 < 15 |only if walking
Enter the tunnel |goto 51.95,27.44 < 10 |only if walking
Leave the tunnel |goto 53.75,27.79 < 10 |only if walking
kill 8 Dustwind Storm Witch##3118 |q 835/2 |goto 53.89,24.97
You can find more down the path that starts at [53.98,22.49]
step
label "Kill_Dustwind_Savages"
kill 12 Dustwind Savage##3117 |q 835/1 |goto 53.89,24.97
You can find more down the path that starts at [53.98,22.49]
step
Enter the tunnel |goto 53.68,27.77 < 10 |only if walking
Leave the tunnel |goto 51.84,27.44 < 10 |only if walking
Follow the path |goto 50.22,27.11 < 15 |only if walking
Follow the road |goto 49.02,28.52 < 20 |only if walking
talk Rezlak##3293
turnin Securing the Lines##835 |goto 46.37,22.94
step
Follow the path |goto 41.84,18.65 < 7 |only if walking
talk Rhinag##3190
|tip Between the huge rocks.
accept Need for a Cure##812 |goto 41.54,18.60
step
Enter Orgrimmar |goto 45.52,12.08 < 20 |only if walking
Enter the building |goto Orgrimmar 40.24,36.97 < 10 |walk
talk Nazgrel##3230
|tip Inside the building.
turnin The Admiral's Orders##831 |goto Orgrimmar 32.27,35.82
step
talk Thrall##4949
|tip Inside the building.
accept Hidden Enemies##5726 |goto 31.80,37.82
step
Leave the building |goto 40.26,36.96 < 7 |walk
talk Kor'ghan##3189
|tip Inside the Cleft of Shadow.
accept Finding the Antidote##813 |goto 47.24,53.59 |sticky saved
step
Follow the path |goto 52.50,85.13 < 15 |only if walking
Leave Orgrimmar |goto 49.10,94.75 < 20 |only if walking
kill Venomtail Scorpid##3127+
collect 4 Venomtail Poison Sac##4886 |q 813/1 |goto Durotar 44.51,19.31 |sticky saved
You can find more around [40.11,17.86]
step
Enter Orgrimmar |goto 45.52,12.08 < 20 |only if walking
talk Kor'ghan##3189
|tip Inside the Cleft of Shadow.
turnin Finding the Antidote##813 |goto Orgrimmar 47.24,53.59 |sticky saved
step
Follow the path |goto 52.50,85.13 < 20 |only if walking
Leave Orgrimmar |goto 49.10,94.75 < 20 |only if walking
Follow the path |goto Durotar 41.84,18.65 < 7 |only if walking
talk Rhinag##3190
|tip Between the huge rocks.
turnin Need for a Cure##812 |goto Durotar 41.54,18.60
step
kill Dreadmaw Crocolisk##3110+
collect Kron's Amulet##4891 |q 816/1 |goto Durotar 36.24,21.58
|tip This has a low drop rate.
You can find more around: |notinsticky
[Durotar 34.80,26.38]
[The Barrens 63.24,13.93]
step
Kill enemies around this area
Reach Level 12 |ding 12 |goto Durotar 36.24,21.58
You can find more around: |notinsticky
[Durotar 34.80,26.38]
[The Barrens 63.24,13.93]
step
Cross the rocks |goto Durotar 38.22,26.77 < 15 |only if walking
Jump down onto the large flat rock here |goto Durotar 39.36,26.44 < 10 |only if walking
Enter the building |goto Durotar 43.10,30.42 < 7 |walk
talk Misha Tor'kren##3193
|tip Inside the building.
turnin Lost But Not Forgotten##816 |goto Durotar 43.10,30.24
step
Follow the path |goto 39.20,32.39 < 20 |only if walking
Continue following the path |goto 39.96,24.24 < 20 |only if walking
Continue following the path |goto 41.61,25.10 < 15 |only if walking
use the Faintly Glowing Skull##4945
|tip Use it on Fizzle Darkstorm, it will damage him.
|tip He looks like a goblin with and imp pet that walks around this area.
kill Fizzle Darkstorm##3203
|tip He looks like a goblin that walks around this area with an imp minion.
collect Fizzle's Claw##4869 |q 806/1 |goto 42.28,26.59
step
Leave the building |goto 51.82,41.95 < 7 |walk
talk Orgnil Soulscar##3142
turnin Dark Storms##806 |goto 52.25,43.15
accept Margoz##828 |goto 52.25,43.15
step
Follow the road |goto 52.37,39.32 < 30 |only if walking
Follow the path |goto 47.35,21.91 < 30 |only if walking
Continue following the path |goto 51.02,16.52 < 30 |only if walking
talk Margoz##3208
turnin Margoz##828 |goto 56.41,20.04
accept Skull Rock##827 |goto 56.41,20.04
stickystart "Collect_Searing_Collars"
step
Enter the cave |goto 55.00,9.76 < 10 |walk
Kill Burning Blade enemies around this area
|tip Inside the cave.
collect Lieutenant's Insignia##14544 |q 5726/1 |goto 53.80,9.31
|tip This has a low drop rate.
step
label "Collect_Searing_Collars"
Kill Burning Blade enemies around this area
|tip Inside the cave.
collect 6 Searing Collar##4871 |q 827/1 |goto 53.80,9.31
step
Follow the path |goto 54.27,8.91 < 10 |walk
Leave the cave |goto 55.04,9.85 < 10 |walk
talk Margoz##3208
turnin Skull Rock##827 |goto 56.41,20.03
accept Neeru Fireblade##829 |goto 56.41,20.03
step
Enter Orgrimmar |goto Durotar 45.53,12.08 < 20 |only if walking
talk Neeru Fireblade##3216
|tip Inside the tent, inside the Cleft of Shadow.
turnin Neeru Fireblade##829 |goto Orgrimmar 49.49,50.59
accept Ak'Zeloth##809 |goto Orgrimmar 49.49,50.59
step
Enter the building |goto 40.23,37.00 < 10 |walk
talk Thrall##4949
|tip Inside the building.
turnin Hidden Enemies##5726 |goto 31.79,37.82
accept Hidden Enemies##5727 |goto 31.79,37.82
step
Leave the building |goto 40.26,36.96 < 7 |walk
talk Neeru Fireblade##3216
|tip Inside the tent, inside the Cleft of Shadow.
Tell him _"You may speak frankly, Neeru..."_
Gauge Neeru Fireblade's Reaction to Your Being a Member of the Burning Blade |q 5727/1 |goto 49.49,50.59
step
Enter the building |goto 40.23,37.00 < 10 |walk
talk Thrall##4949
|tip Inside the building.
turnin Hidden Enemies##5727 |goto 31.79,37.82
|tip You can destroy the "Lieutenant's Insignia" quest item after you turn in this quest.
step
Leave the building |goto 40.26,36.96 < 10 |walk
Follow the path |goto 52.50,85.13 < 20 |only if walking
Leave Orgrimmar |goto 49.10,94.75 < 20 |c |q 451 |future
step
Kill enemies around this area
|tip Inside the cave.
Reach Level 13 |ding 13 |goto Durotar 55.03,9.86
step
Enter Undercity |goto Tirisfal Glades 61.86,65.03 < 10 |only if walking
talk Michael Garrett##4551
fpath Undercity |goto Undercity 63.28,48.58
step
Leave Undercity |goto Undercity 66.19,0.63 < 10 |walk
Follow the road |goto Tirisfal Glades 56.17,65.88 < 30 |c |q 435 |future
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (12-20)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (20-25)",
startlevel=12,
endlevel=20,
},[[
stickystart "Collect_Discolored_Worg_Hearts"
step
Enter Silverpine Forest |goto Silverpine Forest 67.40,5.82 < 30 |only if walking
Follow the path |goto Silverpine Forest 61.48,10.78 < 30 |only if walking
Enter the building |goto Silverpine Forest 56.30,9.25 < 7 |walk
talk Deathstalker Erland##1978
|tip Inside the building.
|tip If he's not here, someone else may be doing the escort quest.
|tip If you don't want to wait for him to respawn, you can skip this quest.
accept Escorting Erland##435 |goto Silverpine Forest 56.19,9.18
step
Watch the dialogue
|tip Follow Deathstalker Erland and protect him as he walks.
|tip He eventually walks to this location.
Erland Must Reach Rane Yorick |q 435/1 |goto 54.30,13.43
step
talk Rane Yorick##1950
turnin Escorting Erland##435 |goto 53.46,13.43
accept The Deathstalkers' Report##449 |goto 53.46,13.43
step
label "Collect_Discolored_Worg_Hearts"
Kill Worg enemies around this area
|tip They look like black wolves.
collect 6 Discolored Worg Heart##3164 |goto 57.05,11.75 |q 429 |future
|tip Be careful not to accidentally sell these to a vendor.
You can find more around: |notinsticky
[60.92,11.16]
[65.26,8.37]
step
Follow the road |goto 54.84,16.67 < 30 |only if walking
Cross the bridge |goto 49.77,28.76 < 15 |only if walking
Follow the road |goto 50.97,36.80 < 30 |only if walking
talk Karos Razok##2226
fpath The Sepulcher |goto 45.62,42.60
step
talk Dalar Dawnweaver##1938
|tip He walks around this area.
accept Prove Your Worth##421 |goto 44.20,39.78
step
talk Shadow Priest Allister##2121
accept Border Crossings##477 |goto 43.98,40.93
step
talk Innkeeper Bates##6739
home The Sepulcher |goto 43.18,41.28
step
talk Deathguard Podrig##6389
accept Supplying the Sepulcher##6321 |goto 43.43,41.68
|only if Scourge
step
talk Apothecary Renferrel##1937
turnin Delivery to Silverpine Forest##445 |goto 42.80,40.87 |only if Scourge
accept A Recipe For Death##447 |goto 42.80,40.87
step
Enter the crypt |goto 43.09,41.39 < 7 |walk
talk High Executor Hadrec##1952
|tip Downstairs inside the crypt.
turnin The Deathstalkers' Report##449 |goto 43.43,40.87
accept Speak with Renferrel##3221 |goto 43.43,40.87
accept Lost Deathstalkers##428 |goto 43.43,40.87
accept The Dead Fields##437 |goto 43.43,40.87
step
Run up the stairs |goto 42.70,40.97 < 5 |walk
Leave the crypt |goto 43.10,41.38 < 5 |c |q 3221
step
talk Apothecary Renferrel##1937
turnin Speak with Renferrel##3221 |goto 42.80,40.87
accept Zinge's Delivery##1359 |goto 42.80,40.87
step
talk Karos Razok##2226
turnin Supplying the Sepulcher##6321 |goto 45.62,42.60
accept Ride to the Undercity##6323 |goto 45.62,42.60
|only if Scourge
step
talk Gordon Wendham##4556
turnin Ride to the Undercity##6323 |goto Undercity 61.49,41.80
accept Michael Garrett##6322 |goto Undercity 61.49,41.80
|only if Scourge
step
talk Michael Garrett##4551
turnin Michael Garrett##6322 |goto 63.26,48.56
accept Return to Podrig##6324 |goto 63.26,48.56
|only if Scourge
step
talk Deathguard Podrig##6389
turnin Return to Podrig##6324 |goto Silverpine Forest 43.42,41.68
|only if Scourge
stickystart "Collect_Grizzled_Bear_Hearts"
step
Follow the road |goto Silverpine Forest 46.30,41.43 < 20 |only if walking
kill 5 Moonrage Whitescalp##1769 |q 421/1 |goto Silverpine Forest 49.54,35.83
You can find more around: |notinsticky
[Silverpine Forest 50.87,41.75]
[Silverpine Forest 53.89,39.63]
[Silverpine Forest 54.54,43.80]
[Silverpine Forest 52.26,47.97]
step
label "Collect_Grizzled_Bear_Hearts"
kill Ferocious Grizzled Bear##1778+
collect 6 Grizzled Bear Heart##3253 |q 447/1 |goto 49.54,35.83
You can find more around: |notinsticky
[50.87,41.75]
[53.89,39.63]
[54.54,43.80]
[52.26,47.97]
step
Follow the road |goto 48.11,39.05 < 30 |only if walking
Follow the path |goto 46.22,41.49 < 20 |only if walking
talk Dalar Dawnweaver##1938
|tip He walks around this area.
turnin Prove Your Worth##421 |goto 44.20,39.78
accept Arugal's Folly##422 |goto 44.20,39.78
step
Follow the road |goto 46.29,41.44 < 20 |only if walking
Cross the bridge |goto 49.74,30.06 < 15 |only if walking
Enter the building |goto 52.81,27.80 < 7 |walk
click Dusty Spellbooks
|tip Upstairs inside the building.
|tip You will be attacked after you loot it.
collect Remedy of Arugal##3155 |q 422/1 |goto 52.82,28.58
step
Leave the building |goto 52.81,27.80 < 7 |walk
Follow the road |goto 51.14,24.36 < 30 |only if walking
talk Rane Yorick##1950
|tip She may be fighting nearby.
turnin Lost Deathstalkers##428 |goto 53.46,13.42
accept Wild Hearts##429 |goto 53.46,13.42
stickystart "Collect_Essence_Of_Nightlash"
step
Enter the Dead Fields |q 437/2 |goto 45.44,21.01
step
label "Collect_Essence_Of_Nightlash"
Kill Rot Hide enemies around this area
kill Nightlash##1983
|tip She will eventually spawn at this location, once you've killed enough Rot Hide enemies.
collect Essence of Nightlash##3622 |q 437/1 |goto 45.44,21.01
step
kill Moss Stalker##1780+
|tip Inside and outside the mine.
|tip Be careful of the elite worgen that walks around this area.
collect 6 Skittering Blood##3254 |q 447/2 |goto 35.65,13.58
step
Kill enemies around this area
|tip Inside and outside the mine.
Reach Level 14 |ding 14 |goto 35.65,13.58
step
talk Apothecary Renferrel##1937
turnin Wild Hearts##429 |goto 42.80,40.86
accept Return to Quinn##430 |goto 42.80,40.86
step
Enter the crypt |goto 43.09,41.39 < 7 |walk
talk High Executor Hadrec##1952
|tip Downstairs inside the crypt.
turnin The Dead Fields##437 |goto 43.43,40.87
accept The Decrepit Ferry##438 |goto 43.43,40.87
step
Run up the stairs |goto 42.70,40.97 < 5 |walk
Leave the crypt |goto 43.10,41.38 < 5 |walk
talk Dalar Dawnweaver##1938
|tip He walks around this area.
turnin Arugal's Folly##422 |goto 44.20,39.78
accept Arugal's Folly##423 |goto 44.20,39.78
step
Follow the path down |goto Undercity 52.84,77.62 < 7 |walk
talk Master Apothecary Faranell##2055
turnin A Recipe For Death##447 |goto Undercity 48.82,69.29
step
talk Apothecary Zinge##5204
turnin Zinge's Delivery##1359 |goto 50.13,67.99
accept Sample for Helbrim##1358 |goto 50.13,67.99
step
Enter Orgrimmar |goto Durotar 45.52,12.07 < 20 |only if walking
Enter the building |goto Orgrimmar 47.53,65.22 < 7 |only if walking
talk Doras##3310
|tip At the top of the tower.
fpath Orgrimmar |goto Orgrimmar 45.12,63.89
|only if Scourge
step
Follow the path |goto 52.56,85.09 < 20 |only if walking
Leave Orgrimmar |goto 49.11,94.91 < 20 |c |q 840 |future
|only if Scourge
step
Follow the road |goto Durotar 47.29,23.21 < 30 |only if walking
Continue following the road |goto Durotar 52.38,33.50 < 30 |only if walking
Follow the road |goto Durotar 52.23,42.43 < 30 |only if walking
talk Takrin Pathseeker##3336
accept Conscript of the Horde##840 |goto Durotar 50.85,43.59
step
Cross the bridge |goto 34.60,42.31 < 20 |only if walking
talk Kargal Battlescar##3337
turnin Conscript of the Horde##840 |goto The Barrens 62.26,19.38
accept Crossroads Conscription##842 |goto The Barrens 62.26,19.38
step
talk Ak'Zeloth##3521
turnin Ak'Zeloth##809 |goto 62.34,20.07
|only if Orc or Troll
step
Follow the road |goto 54.41,22.57 < 30 |only if walking
Follow the path |goto 52.34,29.37 < 20 |c |q 844 |future
step
talk Zargh##3489
accept Meats to Orgrimmar##6365 |goto 52.62,29.84
|only if Orc or Troll
step
talk Sergra Darkthorn##3338
turnin Crossroads Conscription##842 |goto 52.24,31.01
accept Plainstrider Menace##844 |goto 52.24,31.01
step
talk Tonga Runetotem##3448
accept The Forgotten Pools##870 |goto 52.26,31.93
step
talk Gazrog##3464
accept Raptor Thieves##869 |goto 51.93,30.32
step
talk Thork##3429
accept Disrupt the Attacks##871 |goto 51.50,30.87
accept Supplies for the Crossroads##5041 |goto 51.50,30.87
step
talk Darsok Swiftdagger##3449
|tip At the top of the tower.
accept Harpy Raiders##867 |goto 51.62,30.89
step
talk Devrak##3615
fpath Crossroads |goto 51.50,30.34
step
talk Devrak##3615
turnin Meats to Orgrimmar##6365 |goto 51.50,30.34
accept Ride to Orgrimmar##6384 |goto 51.50,30.34
|only if Orc or Troll
step
talk Apothecary Helbrim##3390
turnin Sample for Helbrim##1358 |goto 51.44,30.15
accept Wharfmaster Dizzywig##1492 |goto 51.44,30.15
accept Fungal Spores##848 |goto 51.44,30.15
step
Enter the building |goto Orgrimmar 54.02,68.86 < 7 |walk
talk Innkeeper Gryshka##6929
|tip Inside the building.
turnin Ride to Orgrimmar##6384 |goto Orgrimmar 54.09,68.41
accept Doras the Wind Rider Master##6385 |goto Orgrimmar 54.09,68.41
|only if Orc or Troll
step
Enter the building |goto 47.45,65.08 < 7 |walk
talk Doras##3310
|tip At the top of the tower.
turnin Doras the Wind Rider Master##6385 |goto 45.12,63.89
accept Return to the Crossroads.##6386 |goto 45.12,63.89
|only if Orc or Troll
step
talk Zargh##3489
turnin Return to the Crossroads.##6386 |goto The Barrens 52.62,29.84
|only if Orc or Troll
stickystart "Collect_Raptor_Heads"
step
Kill Plainstrider enemies around this area
collect 7 Plainstrider Beak##5087 |q 844/1 |goto The Barrens 53.39,28.28
You can find more:
Around [53.31,32.92]
Around [51.13,32.58]
Around [49.21,29.26]
Around [51.70,27.37]
On top of the mountain up the path that starts at [50.30,35.38]
stickystart "Kill_Razormane_Water_Seekers"
stickystart "Kill_Razormane_Thornweavers"
stickystart "Kill_Razormane_Hunters"
step
Follow the path |goto 54.33,27.01 < 50 |only if walking
click Chen's Empty Keg
collect Chen's Empty Keg##4926 |goto 55.70,27.29 |q 819 |future
step
use Chen's Empty Keg##4926
accept Chen's Empty Keg##819
step
label "Kill_Razormane_Water_Seekers"
kill 8 Razormane Water Seeker##3267 |q 871/1 |goto 55.57,26.71
You can find more around [54.26,25.66]
step
label "Kill_Razormane_Thornweavers"
kill 8 Razormane Thornweaver##3268 |q 871/2 |goto 55.57,26.71
You can find more around [54.26,25.66]
step
label "Kill_Razormane_Hunters"
kill 3 Razormane Hunter##3265 |q 871/3 |goto 55.57,26.71
|tip They walk with wolf pets around this area.
You can find more around [54.26,25.66]
step
Kill enemies around this area
Reach Level 15 |ding 15 |goto 53.84,34.19
step
talk Sergra Darkthorn##3338
turnin Plainstrider Menace##844 |goto 52.24,31.01
accept The Zhevra##845 |goto 52.24,31.01
step
talk Thork##3429
turnin Disrupt the Attacks##871 |goto 51.50,30.87
accept The Disruption Ends##872 |goto 51.50,30.87
step
kill Zhevra Runner##3242+
collect 4 Zhevra Hooves##5086 |q 845/1 |goto 53.84,34.19
You can find more around: |notinsticky
[50.68,38.06]
[48.88,36.65]
[53.55,37.80]
step
talk Sergra Darkthorn##3338
turnin The Zhevra##845 |goto 52.23,31.01
accept Prowlers of the Barrens##903 |goto 52.23,31.01
step
talk Auctioneer Stampi##8674
collect 5 Earthroot##2449 |goto Thunder Bluff 40.40,51.77 |q 6128 |future
|tip Buy them from the Auction House.
|only if Druid
step
Enter the building |goto 74.17,29.89 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
accept Lessons Anew##6126 |goto 76.47,27.23
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
collect Filled Dreadmist Peak Sampler##15843 |q 6127/1 |goto The Barrens 48.41,18.89
|only if Druid
step
Follow the path down |goto 49.22,20.39 < 20 |only if walking
Follow the path |goto 52.34,29.37 < 20 |only if walking
talk Tonga Runetotem##3448
turnin The Principal Source##6127 |goto 52.26,31.93
accept Gathering the Cure##6128 |goto 52.26,31.93
|only if Druid
step
Follow the path |goto 50.09,40.90 < 30 |only if walking
kill Lost Barrens Kodo##3234+
collect 5 Kodo Horn##15852 |q 6128/2 |goto 51.93,43.65
You can find more around: |notinsticky
[52.71,45.41]
[55.16,45.59]
[47.25,43.31]
[45.77,43.28]
[44.82,40.80]
|only if Druid
step
talk Tonga Runetotem##3448
turnin Gathering the Cure##6128 |goto 52.26,31.93
accept Curing the Sick##6129 |goto 52.26,31.93
|only if Druid
step
use the Curative Animal Salve##15826
|tip Use it on Sickly Gazelles around this area.
|tip They look like green gazelles all around the northern area of the Barrens.
Cure #10# Sickly Gazelles |q 6129/1 |goto 50.17,31.12
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
stickystart "Kill_Razormane_Geomancers"
stickystart "Kill_Razormane_Defenders"
step
Follow the path |goto The Barrens 55.85,24.41 < 60 |only if walking
click Crossroads' Supply Crates
|tip Inside the hut.
collect Crossroads' Supply Crates##12708 |q 5041/1 |goto 59.41,24.75
stickystop "Collect_Raptor_Heads"
step
label "Kill_Razormane_Geomancers"
kill 8 Razormane Geomancer##3269 |q 872/1 |goto 58.99,24.66
You can find more around [57.20,24.98]
step
label "Kill_Razormane_Defenders"
kill 8 Razormane Defender##3266 |q 872/2 |goto 58.99,24.66
You can find more around [57.20,24.98]
step
kill Kreenig Snarlsnout##3438
|tip He walks around this area.
collect Kreenig Snarlsnout's Tusk##5063 |q 872/3 |goto 58.53,27.04
step
Jump down here |goto 60.89,27.57 < 20 |only if walking
Follow the path |goto 64.57,34.44 < 50 |only if walking
Enter the building |goto 62.89,36.52 < 7 |walk
talk Gazlowe##3391
|tip Upstairs inside the building.
accept Southsea Freebooters##887 |goto 62.68,36.23
step
Leave the building |goto 62.88,36.51 < 7 |walk
talk Bragok##16227
fpath Ratchet |goto 63.09,37.16
step
talk Sputtervalve##3442
accept Samophlange##894 |goto 62.98,37.22
step
talk Wharfmaster Dizzywig##3453
turnin Wharfmaster Dizzywig##1492 |goto 63.35,38.45
accept Miner's Fortune##896 |goto 63.35,38.45
step
click WANTED
accept WANTED: Baron Longshore##895 |goto 62.59,37.47
step
talk Mebok Mizzyrix##3446
accept Raptor Horns##865 |goto 62.37,37.62
step
talk Brewmaster Drohn##3292
turnin Chen's Empty Keg##819 |goto 62.26,38.39
accept Chen's Empty Keg##821 |goto 62.26,38.39
step
talk Captain Thalo'thas Brightsun##3339
accept The Guns of Northwatch##891 |goto 62.29,39.03
stickystart "Kill_Southsea_Brigands"
stickystart "Kill_Southsea_Cannoneers"
step
Follow the path |goto 62.73,39.77 < 20 |only if walking
kill Baron Longshore##3467
|tip He walks around this area.
|tip He can spawn in 3 different camps around this area.
collect Baron Longshore's Head##5084 |q 895/1 |goto 64.22,47.13
He can also be around:
[63.64,49.18]
[62.66,49.73]
step
label "Kill_Southsea_Brigands"
kill 12 Southsea Brigand##3381 |q 887/1 |goto 63.79,45.59
You can find more around [63.67,49.07]
step
label "Kill_Southsea_Cannoneers"
kill 6 Southsea Cannoneer##3382 |q 887/2 |goto 63.79,45.59
You can find more around [63.67,49.07]
step
Follow the path |goto 63.21,42.66 < 20 |only if walking
Enter the building |goto 62.89,36.52 < 7 |walk
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Southsea Freebooters##887 |goto 62.68,36.23
accept The Missing Shipment##890 |goto 62.68,36.23
turnin WANTED: Baron Longshore##895 |goto 62.68,36.23
step
Leave the building |goto 62.89,36.52 < 7 |walk
talk Wharfmaster Dizzywig##3453
turnin The Missing Shipment##890 |goto 63.35,38.45
accept The Missing Shipment##892 |goto 63.35,38.45
step
Enter the building |goto 62.89,36.52 < 7 |walk
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin The Missing Shipment##892 |goto 62.68,36.23
accept Stolen Booty##888 |goto 62.68,36.23
step
Leave the building |goto 62.90,36.53 < 7 |walk
Follow the path |goto 62.07,38.77 < 15 |only if walking
Continue following the path |goto 62.73,39.77 < 20 |only if walking
click Fragile - Do NOT Drop
collect Telescopic Lens##5077 |q 888/2 |goto 63.58,49.24
step
click Drizzlik's Emporium
collect Shipment of Boots##5076 |q 888/1 |goto 62.63,49.64
step
Kill enemies around this area
Reach Level 16 |ding 16  |goto 63.79,45.59
You can find more around [63.67,49.07]
step
Follow the path |goto 63.21,42.66 < 20 |only if walking
Enter the building |goto 62.89,36.52 < 7 |walk
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Stolen Booty##888 |goto 62.68,36.23
step
Leave the building |goto 62.89,36.52 < 7 |walk
talk Thork##3429
turnin The Disruption Ends##872 |goto 51.50,30.87
turnin Supplies for the Crossroads##5041 |goto 51.50,30.87
step
talk Mankrik##3432
accept Consumed by Hatred##899 |goto 51.95,31.58
accept Lost in Battle##4921 |goto 51.95,31.58
stickystart "Collect_Raptor_Heads"
stickystart "Collect_Plainstrider_Kidneys"
step
Kill Savannah enemies around this area
|tip They look like lions.
collect 5 Savannah Lion Tusk##4893 |q 821/1 |goto 54.80,30.23
You can find more around: |notinsticky
[53.49,27.21]
[51.68,26.25]
step
label "Collect_Plainstrider_Kidneys"
kill Greater Plainstrider##3244+
collect 5 Plainstrider Kidney##4894 |q 821/2 |goto 53.39,28.28
You can find more:
Around [53.31,32.92]
Around [51.13,32.58]
Around [49.21,29.26]
Around [51.70,27.37]
On top of the mountain up the path that starts at [50.30,35.38]
step
Follow the road |goto 48.44,28.09 < 30 |only if walking
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
accept Centaur Bracers##855 |goto 45.34,28.41
accept Kolkar Leaders##850 |goto 45.34,28.41
stickystart "Collect_Fungal_Spores"
stickystart "Collect_Centaur_Bracers"
step
Explore the Waters of the Forgotten Pools |q 870/1 |goto 45.07,22.53
|tip Underwater.
step
label "Collect_Fungal_Spores"
click Laden Mushroom+
|tip They look like large blue mushrooms on the ground around this area.
collect 4 Fungal Spores##5012 |q 848/1 |goto 45.19,21.98
step
kill Barak Kodobane##3394
|tip He walks around this area.
collect Barak's Head##5022 |q 850/1 |goto 42.72,23.61
step
label "Collect_Centaur_Bracers"
Kill Kolkar enemies around this area
collect 15 Centaur Bracers##5030 |q 855/1 |goto 42.15,24.84
You can find more around: |notinsticky
[42.26,26.72]
[43.52,26.12]
[45.72,25.59]
[44.37,23.07]
step
Kill Witchwing enemies around this area
collect 8 Witchwing Talon##5064 |q 867/1 |goto 40.60,17.44
step
kill Savannah Prowler##3425+
collect 7 Prowler Claws##5096 |q 903/1 |goto 40.80,20.78
You can find more around: |notinsticky
[40.68,22.70]
[41.43,23.76]
[40.98,26.93]
[41.45,28.57]
[42.74,33.64]
step
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
turnin Kolkar Leaders##850 |goto 45.34,28.41
turnin Centaur Bracers##855 |goto 45.34,28.41
accept Verog the Dervish##851 |goto 45.34,28.41
step
Kill enemies around this area
Reach Level 17 |ding 17 |goto 42.15,24.84
You can find more around: |notinsticky
[42.26,26.72]
[43.52,26.12]
[45.72,25.59]
[44.37,23.07]
stickystop "Collect_Raptor_Heads"
step
Enter the building |goto Thunder Bluff 74.15,29.89 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
accept A Lesson to Learn##26 |goto Thunder Bluff 76.47,27.22
|only if Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin A Lesson to Learn##26 |goto Moonglade 56.21,30.65
accept Trial of the Lake##28 |goto Moonglade 56.21,30.65
|only if Druid
step
click Bauble Container
|tip It looks like a wicker vase on the ground underwater.
|tip They spawn randomly, so you may have to search around this area.
collect Shrine Bauble##15877 |q 28/1 |goto 54.33,55.65
|only if Druid
step
use the Shrine Bauble##15877
Complete the Trial of the Lake |q 28/2 |goto 35.92,41.38
|only if Druid
step
talk Tajarri##11799
turnin Trial of the Lake##28 |goto 36.51,40.11
accept Trial of the Sea Lion##30 |goto 36.51,40.11
|only if Druid
step
Follow the path |goto The Barrens 52.92,12.63 < 40 |only if walking
click Strong Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Agility##15883 |goto The Barrens 56.68,8.32 |q 30
|only if Druid
step
Follow the road |goto Silverpine Forest 46.22,41.49 < 20 |only if walking
Continue following the road |goto Silverpine Forest 51.33,36.98 < 30 |only if walking
Follow the path |goto Silverpine Forest 52.57,54.58 < 30 |only if walking
click Dalaran Crate
turnin Border Crossings##477 |goto Silverpine Forest 49.91,60.32
accept Maps and Runes##478 |goto Silverpine Forest 49.91,60.32
step
Follow the road |goto 52.34,53.55 < 30 |only if walking
Follow the path |goto 52.94,40.60 < 30 |only if walking
click Corpse Laden Boat
turnin The Decrepit Ferry##438 |goto 58.39,34.84
accept Rot Hide Clues##439 |goto 58.39,34.84
step
Follow the road |goto 50.40,34.67 < 20 |only if walking
Cross the bridge |goto 49.75,30.06 < 15 |only if walking
Enter the building |goto 53.40,13.27 < 7 |walk
talk Quinn Yorick##1951
|tip Upstairs inside the building.
turnin Return to Quinn##430 |goto 53.43,12.59
step
Leave the building |goto 53.40,13.27 < 7 |walk
talk Rane Yorick##1950
accept Ivar the Foul##425 |goto 53.46,13.43
step
Enter the building |goto 52.00,14.07 < 7 |walk
kill Ivar the Foul##1971
|tip Inside the building.
collect Ivar's Head##3621 |q 425/1 |goto 51.53,13.91
step
Leave the building |goto 52.00,14.07 < 7 |walk
talk Rane Yorick##1950
turnin Ivar the Foul##425 |goto 53.46,13.43
stickystart "Collect_Glutton_Shackles"
step
Follow the road |goto 54.25,17.88 < 30 |only if walking
Follow the path |goto 51.66,22.55 < 30 |only if walking
kill Moonrage Darksoul##1782+
|tip Be careful of the elite worgen that walks around this area.
collect 3 Darksoul Shackle##3157 |q 423/2 |goto 45.98,28.13
You can find more around: |notinsticky
[41.39,29.68]
[38.63,24.59]
step
label "Collect_Glutton_Shackles"
kill Moonrage Glutton##1779+
|tip Be careful of the elite worgen that walks around this area.
collect 6 Glutton Shackle##3156 |q 423/1 |goto 45.98,28.13
You can find more around: |notinsticky
[41.39,29.68]
[38.63,24.59]
step
click Strong Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Endurance##15882 |goto Silverpine Forest 29.54,29.53 |q 30
|only if Druid
step
use the Half Pendant of Aquatic Agility##15883
collect Pendant of the Sea Lion##15885 |q 30/1 |goto Moonglade 35.92,41.42
|only if Druid
step
Follow the road |goto 41.76,35.10 < 20 |only if walking
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Trial of the Sea Lion##30 |goto 56.21,30.64
accept Aquatic Form##31 |goto 56.21,30.64
|only if Druid
step
Enter the building |goto Thunder Bluff 74.15,29.89 < 15 |walk
talk Turak Runetotem##3033
|tip Inside the building.
turnin Aquatic Form##31 |goto Thunder Bluff 76.47,27.22
|only if Druid
step
Enter the crypt |goto Silverpine Forest 43.08,41.39 < 5 |walk
talk High Executor Hadrec##1952
|tip Downstairs inside the crypt.
turnin Rot Hide Clues##439 |goto Silverpine Forest 43.43,40.87
accept The Engraved Ring##440 |goto Silverpine Forest 43.43,40.87
step
Run up the stairs |goto 42.72,40.91 < 5 |walk
Leave the crypt |goto 43.09,41.38 < 5 |walk
talk Shadow Priest Allister##2121
turnin Maps and Runes##478 |goto 43.98,40.93
accept Dalar's Analysis##481 |goto 43.98,40.93
step
talk Dalar Dawnweaver##1938
|tip He walks around this area.
turnin Arugal's Folly##423 |goto 44.19,39.78
accept Arugal's Folly##424 |goto 44.19,39.78
turnin Dalar's Analysis##481 |goto 44.19,39.78
accept Dalaran's Intentions##482 |goto 44.19,39.78
step
talk Shadow Priest Allister##2121
turnin Dalaran's Intentions##482 |goto 43.98,40.93
accept Ambermill Investigations##479 |goto 43.98,40.93
step
Follow the road |goto 46.24,41.51 < 20 |only if walking
Continue following the road |goto 51.43,37.17 < 30 |only if walking
Follow the path |goto 54.47,48.06 < 15 |only if walking
Follow the path up |goto 55.82,48.47 < 15 |only if walking
Enter the mine |goto 56.54,46.01 < 7 |walk
kill Grimson the Pale##1972
|tip Inside the mine.
collect Head of Grimson##3634 |q 424/1 |goto 58.58,44.85
stickystart "Reach_Level_18"
step
Leave the mine |goto 56.54,46.01 < 7 |walk
Follow the road |goto 53.00,56.46 < 30 |only if walking
Follow the path |goto 54.06,61.14 < 30 |only if walking
Kill Dalaran enemies around this area
collect 8 Dalaran Pendant##3354 |q 479/1 |goto 59.13,64.34
step
label "Reach_Level_18"
Kill enemies around this area
Reach Level 18 |ding 18 |goto 59.13,64.34
step
Follow the road |goto 53.51,59.48 < 30 |only if walking
Continue following the road |goto 49.38,38.02 < 30 |only if walking
Follow the path |goto 46.26,41.52 < 20 |only if walking
talk Dalar Dawnweaver##1938
|tip He walks around this area.
turnin Arugal's Folly##424 |goto 44.19,39.78
step
talk Shadow Priest Allister##2121
turnin Ambermill Investigations##479 |goto 43.98,40.94
step
Enter the building |goto Tirisfal Glades 60.90,51.51 < 10 |walk
talk Magistrate Sevren##1499
|tip Inside the building.
turnin The Engraved Ring##440 |goto Tirisfal Glades 61.26,50.85
accept Raleigh and the Undercity##441 |goto Tirisfal Glades 61.26,50.85
step
Leave the building |goto 60.90,51.51 < 10 |walk
talk Apothecary Helbrim##3390
turnin Fungal Spores##848 |goto The Barrens 51.44,30.15
step
talk Thork##3429
accept Report to Kadrak##6541 |goto 51.50,30.87
step
talk Darsok Swiftdagger##3449
|tip At the top of the tower.
turnin Harpy Raiders##867 |goto 51.62,30.90
accept Harpy Lieutenants##875 |goto 51.62,30.90
step
talk Sergra Darkthorn##3338
turnin Prowlers of the Barrens##903 |goto 52.24,31.01
accept Echeyakee##881 |goto 52.24,31.01
step
talk Tonga Runetotem##3448
turnin The Forgotten Pools##870 |goto 52.26,31.93
accept The Stagnant Oasis##877 |goto 52.26,31.93
step
label "Collect_Raptor_Heads"
Kill Sunscale enemies around this area
|tip They look like purple raptors all around ths Barrens.
|tip Just kill them as you see them.
collect 12 Raptor Head##5062 |q 869/1 |goto 53.04,33.69
You can find more around: |notinsticky
[54.18,36.03]
[56.14,39.05]
[57.67,38.41]
[57.59,42.29]
[58.73,39.95]
[57.50,36.31]
[56.00,33.56]
[58.59,34.12]
step
talk Gazrog##3464
turnin Raptor Thieves##869 |goto 51.93,30.32
accept Stolen Silver##3281 |goto 51.93,30.32
step
talk Apothecary Helbrim##3390
accept Apothecary Zamah##853 |goto 51.44,30.15
stickystart "Collect_Raptor_Heads"
step
Follow the road |goto 52.06,32.29 < 20 |only if walking
clicknpc Beaten Corpse##10668
Choose _"I inspect the body further."_
Find Mankrik's Wife |q 4921/1 |goto 49.33,50.32
step
Follow the road |goto 48.15,53.82 < 30 |only if walking
talk Mangletooth##3430
accept Tribes at War##878 |goto 44.55,59.24
step
talk Omusa Thunderhorn##10378
fpath Camp Taurajo |goto 44.45,59.15
step
Enter Mulgore |goto 41.54,58.59 < 30 |only if walking
Cross the bridge |goto Mulgore 48.13,53.45 < 20 |only if walking
Ride the elevator up |goto Thunder Bluff 31.78,66.01 < 10 |only if walking
Enter the building |goto Thunder Bluff 45.39,52.30 < 10 |walk
talk Tal##2995
|tip At the top of the tower.
fpath Thunder Bluff |goto Thunder Bluff 46.98,49.84
|only if not Tauren
step
Enter the cave |goto 29.98,29.94 < 10 |walk
talk Apothecary Zamah##3419
|tip Inside the cave.
turnin Apothecary Zamah##853 |goto 22.81,20.90
step
talk Clarice Foster##5543
|tip She walks around this area inside the cave.
accept Until Death Do Us Part##264 |goto 24.72,22.30
step
Leave the cave |goto 29.98,29.94 < 10 |walk
Enter the building |goto The Barrens 52.03,30.18 < 7 |walk
talk Innkeeper Boorand Plainswind##3934
|tip Inside the building.
home The Crossroads |goto The Barrens 51.99,29.89
step
Leave the building |goto 52.03,30.18 < 7 |walk
talk Mankrik##3432
turnin Lost in Battle##4921 |goto 51.95,31.58
step
Follow the road |goto 50.82,29.07 < 20 |only if walking
Continue following the road |goto 39.43,29.70 < 30 |only if walking
talk Seereth Stonebreak##4049
accept Goblin Invaders##1062 |goto 35.26,27.88
step
talk Makaba Flathoof##11857
accept Avenge My Village##6548 |goto 35.19,27.79
stickystart "Kill_Grimtotem_Ruffians"
step
Follow the path |goto Stonetalon Mountains 82.09,96.48 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 80.58,93.45 < 20 |only if walking
kill 8 Grimtotem Ruffian##11910 |q 6548/1 |goto Stonetalon Mountains 82.02,88.63
step
label "Kill_Grimtotem_Ruffians"
kill 6 Grimtotem Mercenary##11911 |q 6548/2 |goto 82.02,88.63
step
Follow the path |goto 80.52,93.47 < 20 |only if walking
Continue following the path |goto 82.20,96.56 < 20 |only if walking
talk Makaba Flathoof##11857
turnin Avenge My Village##6548 |goto The Barrens 35.19,27.79
accept Kill Grundig Darkcloud##6629 |goto The Barrens 35.19,27.79
stickystart "Kill_Grimtotem_Brutes"
step
Follow the path |goto Stonetalon Mountains 82.09,96.48 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 80.58,93.45 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 75.89,91.45 < 20 |only if walking
Follow the path |goto Stonetalon Mountains 71.50,88.59 < 15 |only if walking
kill Grundig Darkcloud##11858 |q 6629/1 |goto Stonetalon Mountains 73.65,86.13
step
label "Kill_Grimtotem_Brutes"
kill 6 Grimtotem Brute##11912 |q 6629/2 |goto 73.65,86.60
You can find more around [71.76,86.49]
step
Enter the building |goto 73.64,86.09 < 7 |walk
talk Kaya Flathoof##11856
|tip Inside the building.
accept Protect Kaya##6523 |goto 73.48,85.59
step
Watch the dialogue
|tip Follow Kaya Flathoof and protect her as she walks.
|tip She eventually walks to this location.
|tip You will be attacked by a group of 3 enemies near the end of the escort.
|tip Kill the Grimtotem Sorcerer first, when the group of enemies appears.
Escort Kaya to Camp Aparaje |q 6523/1 |goto 77.10,90.84
step
Follow the path up |goto 79.82,90.44 < 20 |only if walking
Follow the path |goto 80.77,95.31 < 20 |only if walking
talk Makaba Flathoof##11857
turnin Kill Grundig Darkcloud##6629 |goto The Barrens 35.19,27.79
turnin Protect Kaya##6523 |goto The Barrens 35.19,27.79
accept Kaya's Alive##6401 |goto The Barrens 35.19,27.79
step
Leave the building |goto 52.04,30.18 < 7 |walk
Follow the road |goto 52.33,29.34 < 20 |only if walking
Follow the path |goto 55.58,19.79 < 20 |only if walking
use the Horn of Echeyakee##10327
kill Echeyakee##3475
|tip He looks like a white lion that spawns nearby.
collect Echeyakee's Hide##5100 |q 881/1 |goto 55.85,17.08
step
click Control Console
turnin Samophlange##894 |goto 52.41,11.64
accept Samophlange##900 |goto 52.41,11.64
step
click Main Control Valve
|tip Two enemies will appear and attack you.
Shut Off the Main Control Valve |q 900/1 |goto 52.33,11.57
step
click the Regulator Valve
|tip One enemy will appear and attack you.
Shut Off the Regulator Valve |q 900/3 |goto 52.29,11.40
step
click the Fuel Control Valve
|tip You will not be attacked.
Shut Off the Fuel Control Valve |q 900/2 |goto 52.40,11.41
step
click Control Console
turnin Samophlange##900 |goto 52.41,11.64
accept Samophlange##901 |goto 52.41,11.64
step
Enter the building |goto 52.92,10.55 < 7 |walk
kill Tinkerer Sniggles##3471
|tip Inside the building.
collect Console Key##5089 |q 901/1 |goto 52.84,10.39
step
click Control Console
turnin Samophlange##901 |goto 52.41,11.64
accept Samophlange##902 |goto 52.41,11.64
stickystart "Collect_Intact_Raptor_Horns"
step
Kill enemies around this area
Reach Level 19 |ding 19 |goto 47.09,14.08
step
kill Witchwing Slayer##3278+
|tip Be careful to avoid Sister Rathtalon.
|tip She looks like an elite green harpy that flies around this area.
|tip There are also Witchwing Ambusher harpies that can stealth, so be careful.
collect 6 Harpy Lieutenant Ring##5065 |goto 39.46,15.20
|tip These have a low drop rate.
step
label "Collect_Intact_Raptor_Horns"
kill Sunscale Scytheclaw##3256+
|tip They look like purple raptors.
collect 5 Intact Raptor Horn##5055 |q 865/1 |goto 43.36,15.57
You can find more around [45.27,14.94]
step
Follow the path |goto 52.80,13.00 < 40 |only if walking
talk Wizzlecrank's Shredder##3439
accept Ignition##858 |goto 56.51,7.45
step
Follow the path up |goto 56.46,8.48 < 10 |only if walking
kill Supervisor Lugwizzle##3445
|tip He walks around this area on both levels of the platform.
collect Ignition Key##5050 |q 858/1 |goto 56.20,8.25
step
talk Wizzlecrank's Shredder##3439
turnin Ignition##858 |goto 56.51,7.45
accept The Escape##863 |goto 56.51,7.45
step
Watch the dialogue
|tip Follow Wizzlecrank's Shredder and protect him as he walks.
|tip He eventually walks to this location.
Escort Wizzlecrank Out of the Venture Co. Drill Site |q 863/1 |goto 55.35,7.70
step
Follow the path up |goto 61.54,6.68 < 30 |only if walking
Kill Venture Co. enemies around this area
collect Cats Eye Emerald##5097 |q 896/1 |goto 61.61,4.61
|tip This has a low drop rate.
step
Leave the building |goto 52.03,30.18 < 7 |walk
talk Darsok Swiftdagger##3449
|tip At the top of the tower.
turnin Harpy Lieutenants##875 |goto 51.62,30.90
accept Serena Bloodfeather##876 |goto 51.62,30.90
step
talk Sergra Darkthorn##3338
turnin Echeyakee##881 |goto 52.23,31.00
step
talk Sputtervalve##3442
turnin Samophlange##902 |goto 62.98,37.22
|tip You can destroy the "Control Console Operating Manual" item after you turn in this quest.
turnin The Escape##863 |goto 62.98,37.22
accept Ziz Fizziks##1483 |goto 62.98,37.22
accept Wenikee Boltbucket##3921 |goto 62.98,37.22
step
talk Wharfmaster Dizzywig##3453
turnin Miner's Fortune##896 |goto 63.35,38.45
step
talk Mebok Mizzyrix##3446
turnin Raptor Horns##865 |goto 62.37,37.62
accept Deepmoss Spider Eggs##1069 |goto 62.37,37.62
step
Follow the path |goto 59.88,38.96 < 30 |only if walking
click Bubbling Fissure
|tip Underwater.
Test the Dried Seeds |q 877/1 |goto 55.61,42.74
step
kill Verog the Dervish##3395
|tip Kill Kolkar enemies around this whole area.
|tip Eventually, you will see a red yelled message in your chat window.
|tip The yelled message says "I am summoned! Intruders, come to my tent and face your death!"
|tip He spawns at this location.
collect Verog's Head##5023 |q 851/1 |goto 52.91,41.77
Kill Kolkar enemies around [54.70,43.15]
step
Kill enemies around this area
Reach Level 20 |ding 20 |goto 55.53,42.70
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (20-25)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (25-30)",
startlevel=20,
endlevel=25,
},[[
step
_Note for Rogues:_
|tip You will begin the questline that rewards you with the ability to make Poisons later.
|tip The quest will be easier to complete at a higher level.
|tip You will need Lockpicking skill of at least 75, so start try to work on that now, as you can, while questing.
Click Here to Continue |confirm |q 2480 |future
|only if Rogue
step
talk Tonga Runetotem##3448
turnin The Stagnant Oasis##877 |goto The Barrens 52.26,31.93
accept Altered Beings##880 |goto The Barrens 52.26,31.93
step
kill Oasis Snapjaw##3461+
|tip Underwater and along the edges of the water around this area.
collect 8 Altered Snapjaw Shell##5098 |q 880/1 |goto 55.53,42.70
step
talk Tonga Runetotem##3448
turnin Altered Beings##880 |goto 52.26,31.93
accept Mura Runetotem##3301 |goto 52.26,31.93
step
Follow the road |goto 52.34,29.30 < 20 |only if walking
Follow the path |goto 48.89,12.85 < 30 |only if walking
talk Wenikee Boltbucket##9316
turnin Wenikee Boltbucket##3921 |goto 49.05,11.16
accept Nugget Slugs##3922 |goto 49.05,11.16
step
Follow the road |goto 48.76,6.87 < 30 |only if walking
talk Kadrak##8582
|tip At the top of the tower.
turnin Report to Kadrak##6541 |goto 48.12,5.42
step
Follow the path |goto 49.01,12.98 < 30 |only if walking
click Tool Bucket+
|tip They look like grey metal buckets with tools in them on the ground around this area.
collect 15 Nugget Slug##11143 |q 3922/1 |goto 55.71,9.46
You can find more around: |notinsticky
[56.83,8.79]
[57.16,9.09]
[57.32,7.18]
[56.44,7.50]
[55.90,6.83]
step
Follow the path |goto 54.57,10.21 < 50 |only if walking
Follow the path |goto 48.89,12.85 < 30 |only if walking
talk Wenikee Boltbucket##9316
turnin Nugget Slugs##3922 |goto 49.05,11.16
|tip You can destroy any extra "Nugget Slug" quest items after you turn in this quest.
step
Follow the path up |goto 46.14,13.10 < 10 |only if walking
Follow the path |goto 45.54,9.73 < 20 |only if walking
Continue following the path |goto 43.58,9.01 < 30 |only if walking
Continue following the path |goto 41.82,11.28 < 30 |only if walking
Follow the path down |goto 40.58,10.32 < 10 |only if walking
kill Serena Bloodfeather##3452
collect Serena's Head##5067 |q 876/1 |goto 39.16,12.17
step
Follow the path |goto 41.07,19.52 < 60 |only if walking
Continue following the path |goto 43.91,25.88 < 60 |only if walking
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
turnin Verog the Dervish##851 |goto 45.34,28.41
accept Hezrul Bloodmark##852 |goto 45.34,28.41
step
Follow the road |goto 47.73,28.01 < 30 |only if walking
Follow the path |goto 50.81,29.06 < 20 |only if walking
talk Darsok Swiftdagger##3449
|tip At the top of the tower.
turnin Serena Bloodfeather##876 |goto 51.62,30.90
step
talk Raleigh Andrean##2050
turnin Raleigh and the Undercity##441 |goto Undercity 61.99,42.72
accept A Husband's Revenge##530 |goto Undercity 61.99,42.72
step
click Yuriv's Tombstone
turnin Until Death Do Us Part##264 |goto Silverpine Forest 44.20,42.69
step
talk Mura Runetotem##8385
turnin Mura Runetotem##3301 |goto 42.91,41.99
step
Enter the crypt |goto 43.10,41.39 < 7 |walk
talk High Executor Hadrec##1952
|tip Downstairs inside the crypt.
accept Rot Hide Ichor##443 |goto 43.43,40.87
step
Run up the stairs |goto 42.71,40.95 < 5 |walk
Leave the crypt |goto 43.10,41.38 < 5 |walk
Follow the road |goto 46.32,41.47 < 20 |only if walking
Continue following the road |goto 52.86,43.74 < 30 |only if walking
kill Valdred Moray##2332
|tip He walks around this area.
collect Valdred's Hands##3613 |q 530/1 |goto 45.88,84.92
step
Follow the path up |goto 51.95,72.25 < 20 |only if walking
Follow the road |goto 53.70,71.60 < 30 |only if walking
Continue following the road |goto 49.91,37.76 < 40 |only if walking
Follow the path |goto 46.28,41.47 < 20 |only if walking
talk Innkeeper Bates##6739
home The Sepulcher |goto 43.18,41.28
stickystart "Collect_Rot_Hide_Ichors"
stickystart "Reach_Level_21"
step
Follow the road |goto 46.30,41.46 < 20 |only if walking
Follow the path up |goto 64.59,32.37 < 20 |only if walking
Kill Rot Hide enemies around this area
collect A Talking Head##3317 |goto 68.31,35.72 |q 460 |future
|tip This has a very low drop rate.
You can find more around [65.74,30.02]
step
use A Talking Head##3317
accept Resting in Pieces##460
step
label "Collect_Rot_Hide_Ichors"
Kill Rot Hide enemies around this area
collect 8 Rot Hide Ichor##3236 |q 443/1 |goto 65.74,30.02
|tip These have a low drop rate.
You can find more around [68.31,35.72]
step
label "Reach_Level_21"
Kill enemies around this area
Reach Level 21 |ding 21 |goto 68.31,35.72
You can find more around [65.74,30.02]
step
Follow the path |goto 65.78,30.02 < 15 |only if walking
Continue following the path |goto 66.05,27.00 < 15 |only if walking
Continue following the path |goto 67.28,24.62 < 10 |only if walking
click A Shallow Grave
turnin Resting in Pieces##460 |goto 67.86,24.84
accept The Hidden Niche##461 |goto 67.86,24.84
step
Follow the path |goto 67.22,24.67 < 15 |only if walking
Enter the building |goto 65.74,24.98 < 10 |only if walking
Run up the stairs |goto 65.69,23.37 < 5 |only if walking
Run up the stairs |goto 65.33,23.31 < 5 |only if walking
click Dusty Shelf
|tip It looks like an empty wooden bookcase.
|tip On the roof of the building, in a side room.
turnin The Hidden Niche##461 |goto 65.34,24.81
accept Wand to Bethor##491 |goto 65.34,24.81
step
talk Apothecary Renferrel##1937
turnin Rot Hide Ichor##443 |goto 42.80,40.86
accept Rot Hide Origins##444 |goto 42.80,40.86
step
talk Raleigh Andrean##2050
turnin A Husband's Revenge##530 |goto Undercity 61.99,42.72
step
talk Bethor Iceshard##1498
|tip At the top of the stairs.
turnin Rot Hide Origins##444 |goto 84.09,17.47
turnin Wand to Bethor##491 |goto 84.09,17.47
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent, inside the Cleft of Shadow.
accept Devourer of Souls##1507 |goto Orgrimmar 48.25,45.29
|only if Warlock
step
talk Cazul##5909
turnin Devourer of Souls##1507 |goto 47.06,46.48
accept Blind Cazul##1508 |goto 47.06,46.48
|only if Warlock
step
Follow the path up |goto 43.93,56.92 < 15 |walk
Follow the path |goto 38.40,54.26 < 20 |only if walking
Enter the building |goto 38.07,60.65 < 15 |walk
talk Zankaja##5910
|tip Inside the building.
turnin Blind Cazul##1508 |goto 37.03,59.45
accept News of Dogran##1509 |goto 37.03,59.45
|only if Warlock
step
talk Gazrog##3464
turnin News of Dogran##1509 |goto The Barrens 51.93,30.32
accept News of Dogran##1510 |goto The Barrens 51.93,30.32
|only if Warlock
step
Follow the road |goto 50.82,29.07 < 20 |only if walking
Follow the road |goto 39.39,29.65 < 30 |only if walking
Follow the path up |goto Stonetalon Mountains 82.07,98.57 < 15 |only if walking
Follow the path |goto Stonetalon Mountains 77.19,98.73 < 15 |only if walking
Jump down here |goto Stonetalon Mountains 75.01,97.08 < 15 |only if walking
talk Ken'zigla##4197
turnin News of Dogran##1510 |goto Stonetalon Mountains 73.25,95.12
accept Ken'zigla's Draught##1511 |goto Stonetalon Mountains 73.25,95.12
|only if Warlock
step
Follow the path up |goto 72.89,93.73 < 15 |only if walking
Follow the path |goto 77.33,98.72 < 15 |only if walking
Follow the road |goto The Barrens 35.84,27.53 < 30 |only if walking
Continue following the road |goto 39.43,29.70 < 30 |only if walking
Follow the path |goto The Barrens 50.83,29.09 < 20 |only if walking
talk Grunt Logmar##5911
turnin Ken'zigla's Draught##1511 |goto The Barrens 44.62,59.27
accept Dogran's Captivity##1515 |goto The Barrens 44.62,59.27
|only if Warlock
step
talk Grunt Dogran##5908
|tip Inside the hut.
turnin Dogran's Captivity##1515 |goto 43.31,47.89
accept Love's Gift##1512 |goto 43.31,47.89
|only if Warlock
step
Follow the path down |goto Orgrimmar 39.74,53.78 < 20 |walk
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin Love's Gift##1512 |goto Orgrimmar 48.25,45.29
accept The Binding##1474 |goto Orgrimmar 48.25,45.29
|only if Warlock
step
use Dogran's Pendant##6626
|tip Use it while standing on the pink symbol on the ground.
|tip Inside the tent.
kill Summoned Succubus##5677 |q 1474/1 |goto 49.45,50.03
|only if Warlock
step
talk Gan'rul Bloodeye##5875
|tip Inside the tent.
turnin The Binding##1474 |goto 48.24,45.29
|only if Warlock
step
Follow the path |goto Orgrimmar 42.98,3.15 < 20 |only if walking
Run up the ramp |goto Orgrimmar 42.26,36.67 < 15 |only if walking
Enter the building |goto Orgrimmar 40.21,36.95 < 15 |walk
talk Searn Firewarder##5892
|tip Inside the building.
accept Call of Water##1528 |goto Orgrimmar 37.96,37.74
|only if Shaman
step
talk Islen Waterseer##5901
turnin Call of Water##1528 |goto The Barrens 65.83,43.78
accept Call of Water##1530 |goto The Barrens 65.83,43.78
|only if Shaman
step
Follow the road |goto 46.12,67.29 < 30 |only if walking
Follow the path up |goto 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1530 |goto 43.42,77.41
accept Call of Water##1535 |goto 43.42,77.41
|only if Shaman
step
use the Empty Brown Waterskin##7766
collect Filled Brown Waterskin##7769 |q 1535/1 |goto 43.42,77.41
|only if Shaman
step
Follow the path up |goto 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1535 |goto 43.42,77.41
accept Call of Water##1536 |goto 43.42,77.41
|only if Shaman
step
Follow the road |goto 46.85,65.69 < 30 |only if walking
Follow the road |goto Silverpine Forest 46.48,41.31 < 20 |only if walking
Continue following the road |goto Silverpine Forest 52.85,43.92 < 30 |only if walking
Continue following the road |goto Silverpine Forest 53.88,73.53 < 30 |only if walking
Enter Hillsbrad Foothills |goto Silverpine Forest 66.87,80.22 < 30 |only if walking
Follow the road |goto Hillsbrad Foothills 57.51,36.04 < 30 |only if walking
talk Zarise##2389
fpath Tarren Mill |goto Hillsbrad Foothills 60.14,18.62
|only if Shaman
step
use the Empty Red Waterskin##7768
collect Filled Red Waterskin##7771 |q 1536/1 |goto 62.15,20.75
|only if Shaman
step
Follow the road |goto The Barrens 46.12,67.29 < 30 |only if walking
Follow the path up |goto The Barrens 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1536 |goto The Barrens 43.42,77.41
accept Call of Water##1534 |goto The Barrens 43.42,77.41
|only if Shaman
step
Follow the road |goto 46.85,65.69 < 30 |only if walking
Follow the road |goto 52.64,22.79 < 30 |only if walking
Continue following the road |goto 48.43,12.63 < 30 |only if walking
Enter Ashenvale |goto 48.97,5.35 < 15 |only if walking
Follow the road |goto Ashenvale 66.93,71.28 < 30 |only if walking
Follow the path |goto Ashenvale 38.83,58.05 < 30 |only if walking
use the Empty Blue Waterskin##7767
collect Filled Blue Waterskin##7770 |q 1534/1 |goto Ashenvale 33.55,67.44
|only if Shaman
step
Follow the road |goto 38.91,57.92 < 30 |only if walking
Continue following the road |goto 67.10,71.67 < 30 |only if walking
Enter the Barrens |goto The Barrens 48.98,5.34 < 30 |only if walking
Follow the road |goto The Barrens 48.39,12.60 < 30 |only if walking
Follow the road |goto The Barrens 46.12,67.29 < 30 |only if walking
Follow the path up |goto The Barrens 44.28,77.29 < 15 |only if walking
talk Brine##5899
turnin Call of Water##1534 |goto The Barrens 43.42,77.41
accept Call of Water##220 |goto The Barrens 43.42,77.41
|only if Shaman
step
Follow the road |goto 46.85,65.69 < 30 |only if walking
talk Islen Waterseer##5901
turnin Call of Water##220 |goto 65.83,43.78
accept Call of Water##63 |goto 65.83,43.78
|only if Shaman
step
Jump up next to the tree |goto Silverpine Forest 42.18,40.90 < 7 |only if walking
Jump down here |goto Silverpine Forest 41.60,41.77 < 7 |only if walking
use the Water Sapta##6637
kill Corrupt Minor Manifestation of Water##58
collect Corrupt Manifestation's Bracers##7812 |goto Silverpine Forest 38.77,44.26
|only if Shaman
step
click Brazier of Everfount
turnin Call of Water##63 |goto 38.28,44.56
accept Call of Water##100 |goto 38.28,44.56
|only if Shaman
step
Watch the dialogue
talk Minor Manifestation of Water##5895
turnin Call of Water##100 |goto 38.75,44.62
accept Call of Water##96 |goto 38.75,44.62
|only if Shaman
step
Follow the path |goto 36.96,42.85 < 20 |only if walking
Continue following the path |goto 38.93,31.99 < 30 |only if walking
Cross the bridge |goto 49.76,28.78 < 20 |only if walking
Follow the road |goto 48.55,38.65 < 30 |only if walking
talk Islen Waterseer##5901
turnin Call of Water##96 |goto The Barrens 65.83,43.78
|only if Shaman
step
talk Korran##3428
accept Egg Hunt##868 |goto The Barrens 51.07,29.63
step
talk Darsok Swiftdagger##3449
|tip At the top of the tower.
accept Letter to Jin'Zil##1060 |goto 51.62,30.90
step
Enter the building |goto 52.03,30.18 < 7 |walk
talk Innkeeper Boorand Plainswind##3934
|tip Inside the building.
home The Crossroads |goto 51.99,29.89
step
Leave the building |goto 52.03,30.18 < 7 |walk
talk Sergra Darkthorn##3338
accept The Angry Scytheclaws##905 |goto 52.23,31.00
step
Follow the path |goto 52.06,32.10 < 20 |only if walking
Continue following the path |goto 50.44,35.65 < 30 |c |q 852
step
map The Barrens
path follow loose; loop on; ants curved; dist 20
path	47.59,37.23		46.17,36.83		45.45,36.74		45.26,37.28
path	45.54,37.98		44.97,39.16		46.37,41.78		46.93,41.93
path	47.58,41.23		48.63,40.37		48.01,38.43
kill Hezrul Bloodmark##3396
|tip He walks around this area with 2 bodyguards.
|tip He walks in a clockwise pattern, so this path will help you find him faster.
collect Hezrul's Head##5025 |q 852/1
stickystart "Collect_Sunscale_Feathers"
step
Follow the path |goto 57.35,52.24 < 20 |only if walking
click Stolen Silver
collect Stolen Silver##5061 |q 3281/1 |goto 58.03,53.87
step
label "Collect_Sunscale_Feathers"
Kill Sunscale enemies around this area
|tip They look like purple raptors all around ths Barrens.
|tip The Sunscale Scytheclaws have the highest chance to drop these.
collect 3 Sunscale Feather##5165 |goto 58.03,53.87 |q 905
|tip Be careful not to accidentally sell these to a vendor.
You can find more around: |notinsticky
[57.35,52.24]
stickystart "Collect_Theramore_Medals"
step
Follow the path |goto 57.35,52.39 < 20 |only if walking
Follow the path down |goto 58.28,51.80 < 30 |only if walking
Follow the path |goto 62.16,53.49 < 15 |only if walking
Follow the path up |goto 61.10,53.80 < 15 |only if walking
Enter the building |goto 62.96,56.70 < 7 |only if walking
kill Cannoneer Smythe##3454 |q 891/3 |goto 63.17,56.58
|tip At the top of the tower.
step
Enter the building |goto 60.53,55.05 < 7 |only if walking
kill Cannoneer Whessan##3455 |q 891/2 |goto 60.43,54.78
|tip At the top of the tower.
step
label "Collect_Theramore_Medals"
Kill Theramore enemies around this area
collect 10 Theramore Medal##5078 |q 891/4 |goto 61.60,54.94
step
Enter the bulding |goto 61.60,54.94 < 7 |walk
kill Captain Fairmount##3393 |q 891/1 |goto 61.85,54.65
|tip Upstairs inside the tower.
step
talk Gilthares Firebough##3465
|tip Inside the building, on the bottom floor, near the entrance.
|tip If he's not here, another player may be doing the escort quest.
|tip Either kill enemies around this area, waiting for him to respawn, or skip it.
accept Free From the Hold##898 |goto 61.97,54.96
step
Watch the dialogue
|tip Follow Gilthares Firebough and protect him as he walks.
|tip He eventually walks to this location.
|tip The enemies you walk through are much lower level than you, so clear the path in front of him as he walks.
Escort Gilthares Firebough Back to Ratchet |q 898/1 |goto 62.27,39.06 |notravel
step
talk Captain Thalo'thas Brightsun##3339
turnin The Guns of Northwatch##891 |goto 62.29,39.03
turnin Free From the Hold##898 |goto 62.29,39.03
step
Follow the path up |goto 61.53,37.94 < 30 |only if walking
click Blue Raptor Nest
Visit the Blue Raptor Nest |q 905/1 |goto 52.60,46.11
step
click Red Raptor Nest
Visit the Red Raptor Nest |q 905/3 |goto 52.46,46.57
step
click Yellow Raptor Nest
Visit the Yellow Raptor Nest |q 905/2 |goto 52.02,46.47
|tip You can destroy any extra "Sunscale Feather" quest items after you complete this goal.
step
Kill enemies around this area
Reach Level 22 |ding 22 |goto 53.48,48.66
stickystart "Collect_Blood_Shard"
stickystart "Kill_Bristleback_Water_Seekers"
stickystart "Kill_Bristleback_Thornweavers"
stickystart "Kill_Bristleback_Geomancers"
stickystart "Collect_Thunder_Lizard_Horn"
step
Kill Bristleback enemies around this area
collect 60 Bristleback Quilboar Tusk##5085 |q 899/1 |goto 52.96,53.58
You can find more around: |notinsticky
[51.20,56.06]
[43.94,51.84]
[43.38,48.54]
step
label "Collect_Blood_Shard"
Kill Bristleback enemies around this area
collect Blood Shard##5075 |goto 52.96,53.58 |q 5052 |future
|tip Be careful not to accidentally sell this to a vendor.
step
label "Kill_Bristleback_Water_Seekers"
kill 6 Bristleback Water Seeker##3260 |q 878/1 |goto 52.92,53.69
You can find more around: |notinsticky
[51.20,56.06]
[43.94,51.84]
[43.38,48.54]
step
label "Kill_Bristleback_Thornweavers"
kill 12 Bristleback Thornweaver##3261 |q 878/2 |goto 52.92,53.69
You can find more around: |notinsticky
[51.20,56.06]
[43.94,51.84]
[43.38,48.54]
step
label "Kill_Bristleback_Geomancers"
kill 12 Bristleback Geomancer##3263 |q 878/3 |goto 52.92,53.69
You can find more around: |notinsticky
[51.20,56.06]
[43.94,51.84]
[43.38,48.54]
step
label "Collect_Thunder_Lizard_Horn"
kill Stormsnout##3240+
collect Thunder Lizard Horn##4895 |q 821/3 |goto 52.53,55.02
|tip This has a low drop rate.
You can find more around: |notinsticky
[49.43,53.80]
[46.25,56.15]
[46.73,50.16]
step
talk Tatternack Steelforge##3433
accept Weapons of Choice##893 |goto 45.10,57.68
step
talk Mangletooth##3430
turnin Tribes at War##878 |goto 44.55,59.24
accept Blood Shards of Agamaggan##5052 |goto 44.55,59.24
step
talk Mangletooth##3430
turnin Blood Shards of Agamaggan##5052 |goto 44.55,59.24
accept Betrayal from Within##879 |goto 44.55,59.24
step
talk Brewmaster Drohn##3292
turnin Chen's Empty Keg##821 |goto 62.26,38.39
accept Chen's Empty Keg##822 |goto 62.26,38.39
step
talk Gazrog##3464
turnin Stolen Silver##3281 |goto 51.93,30.32
step
talk Sergra Darkthorn##3338
turnin The Angry Scytheclaws##905 |goto 52.23,31.01
accept Jorn Skyseer##3261 |goto 52.23,31.01
step
talk Mankrik##3432
turnin Consumed by Hatred##899 |goto 51.95,31.58
step
talk Tonga Runetotem##3448
accept Hamuul Runetotem##1489 |goto 52.26,31.93
step
talk Jorn Skyseer##3387
turnin Jorn Skyseer##3261 |goto 44.86,59.14
accept Ishamuhale##882 |goto 44.86,59.14
accept Melor Sends Word##1130 |goto 44.86,59.14
step
talk Melor Stonehoof##3441
turnin Melor Sends Word##1130 |goto Thunder Bluff 61.54,80.90
accept Steelsnap##1131 |goto Thunder Bluff 61.54,80.90
step
Enter the building |goto 74.08,29.89 < 7 |walk
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
turnin Hamuul Runetotem##1489 |goto 78.60,28.56
accept Nara Wildmane##1490 |goto 78.60,28.56
step
talk Nara Wildmane##5770
|tip Inside the building.
turnin Nara Wildmane##1490 |goto 75.65,31.62
step
Leave the building |goto 74.08,29.89 < 7 |c |q 742 |future
step
map Thunder Bluff
path follow strict; loop on; ants curved; dist 20
path	43.31,60.55	42.71,56.37	39.75,52.04	37.13,51.84	36.42,55.39
path	37.65,61.32	39.52,63.00	43.31,60.37	44.40,68.49	46.13,69.24
path	48.79,66.90	49.93,62.30	56.57,61.87	57.10,59.04	56.37,54.59
path	58.20,53.77	59.03,50.99	58.08,48.89	56.38,48.00	54.17,48.84
path	52.72,51.74	54.12,53.82	56.18,55.10	57.12,60.23	56.10,62.19
path	49.94,62.33	49.12,66.66	45.91,69.29	44.41,68.71
talk Bluff Runner Windstrider##10881
|tip He walks around in Thunder Bluff.
accept The Ashenvale Hunt##742
step
Follow the path up |goto The Barrens 59.68,38.32 < 20 |only if walking
Follow the path |goto The Barrens 59.29,37.11 < 30 |only if walking
kill Zhevra Charger##3426+
collect Fresh Zhevra Carcass##10338 |goto The Barrens 60.55,32.81 |q 882
step
use the Fresh Zhevra Carcass##10338
kill Ishamuhale##3257
collect Ishamuhale's Fang##5101 |q 882/1 |goto 59.89,30.29
step
Leave the building |goto 52.03,30.19 < 7 |walk
talk Jorn Skyseer##3387
turnin Ishamuhale##882 |goto 44.86,59.14
step
Follow the road |goto 50.82,29.07 < 20 |only if walking
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
turnin Hezrul Bloodmark##852 |goto 45.34,28.41
step
Follow the road |goto 39.42,29.68 < 30 |only if walking
Follow the path up |goto Stonetalon Mountains 82.07,98.57 < 15 |only if walking
Follow the path |goto Stonetalon Mountains 77.19,98.73 < 15 |only if walking
Jump down here |goto Stonetalon Mountains 75.01,97.08 < 15 |only if walking
Enter the cave |goto Stonetalon Mountains 74.22,97.13 < 10 |walk
talk Witch Doctor Jin'Zil##3995
|tip Inside the cave.
turnin Letter to Jin'Zil##1060 |goto Stonetalon Mountains 74.54,97.94
accept Jin'Zil's Forest Magic##1058 |goto Stonetalon Mountains 74.54,97.94
step
Leave the cave |goto 74.16,96.96 < 10 |walk
talk Darn Talongrip##11821
accept Report to Kadrak##6542 |goto Stonetalon Mountains 73.25,94.90
step
talk Xen'Zilla##12816
|tip Inside the building.
accept Blood Feeders##6461 |goto 71.24,95.02
step
Follow the road |goto 71.16,89.29 < 20 |only if walking
Follow the path |goto 51.64,61.06 < 20 |only if walking
Continue following the path |goto 48.66,60.86 < 30 |only if walking
talk Tammra Windfield##11864
turnin Kaya's Alive##6401 |goto 47.46,58.38
step
talk Tharm##4312
fpath Sun Rock Retreat |goto 45.13,59.84
step
Follow the path up |goto 44.63,61.84 < 15 |only if walking
Continue up the path |goto 44.88,63.31 < 15 |only if walking
talk Mor'rogal##11861
accept Boulderslide Ravine##6421 |goto 47.22,64.05
step
talk Tsunaman##11862
|tip It walks around this area.
accept Trouble in the Deeps##6562 |goto 47.37,64.29
stickystart "Collect_Resonite_Crystals"
step
Follow the path down |goto 48.65,63.18 < 15 |only if walking
Follow the path |goto 49.83,60.94 < 20 |only if walking
Follow the road |goto 53.23,61.82 < 30 |only if walking
Follow the path up |goto 67.09,88.51 < 20 |only if walking
Follow the path up |goto 63.23,93.87 < 15 |only if walking
Enter the cave |goto 61.49,92.85 < 15 |walk
Investigate the Cave in Boulderslide Ravine |q 6421/2 |goto 58.63,90.38
|tip Inside the cave.
step
label "Collect_Resonite_Crystals"
click Resonite Crystal+
|tip They look like pink crystals on the ground around this area inside the cave.
collect 10 Resonite Crystal##16581 |q 6421/1 |goto 60.55,91.45
stickystart "Kill_Deepmoss_Venomspitters"
stickystart "Kill_Deepmoss_Creepers"
step
Leave the cave |goto 61.62,92.99 < 15 |walk
Follow the path |goto 63.93,93.64 < 20 |only if walking
Follow the road |goto 67.45,86.18 < 30 |only if walking
Follow the path up |goto 58.14,76.09 < 15 |only if walking
click Deepmoss Eggs+
|tip They look like large white eggs on the ground around this area.
|tip Sometimes enemies will spawn after looting them.
|tip Be careful to avoid Besseleth.
|tip She looks like an elite orange spider that can spawn in multiple locations around this area.
collect 15 Deepmoss Egg##5570 |q 1069/1 |goto 53.25,73.45
step
label "Kill_Deepmoss_Venomspitters"
kill 7 Deepmoss Venomspitter##4007 |q 6461/2 |goto 53.25,73.45
|tip Be careful to avoid Besseleth.
|tip She looks like an elite orange spider that can spawn in multiple locations around this area.
step
label "Kill_Deepmoss_Creepers"
kill 10 Deepmoss Creeper##4005 |q 6461/1 |goto 53.25,73.45
|tip Be careful to avoid Besseleth.
|tip She looks like an elite orange spider that can spawn in multiple locations around this area.
step
Kill enemies around this area
|tip Be careful to avoid Besseleth.
|tip She looks like an elite orange spider that can spawn in multiple locations around this area.
Reach Level 23 |ding 23 |goto 53.25,73.45
step
Follow the path |goto 55.42,76.26 < 20 |only if walking
Follow the path |goto 61.06,69.06 < 30 |only if walking
Enter the building |goto 59.04,62.24 < 7 |walk
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Ziz Fizziks##1483 |goto 58.99,62.60
accept Super Reaper 6000##1093 |goto 58.99,62.60
stickystart "Kill_Venture_Co_Loggers"
step
Leave the building |goto 59.04,62.24 < 7 |walk
kill Venture Co. Operator##3988+
collect Super Reaper 6000 Blueprints##5734 |q 1093/1 |goto 62.33,53.49
|tip This has a low drop rate.
You can find more around: |notinsticky
[66.16,52.01]
[66.49,45.90]
[70.97,43.13]
[73.02,49.47]
[74.68,55.44]
step
label "Kill_Venture_Co_Loggers"
kill 15 Venture Co. Logger##3989 |q 1062/1 |goto 60.44,52.78
You can find more around: |notinsticky
[71.20,56.50]
[70.01,48.11]
[64.24,46.72]
step
Follow the path |goto 61.79,58.47 < 40 |only if walking
Enter the building |goto 59.04,62.24 < 7 |walk
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Super Reaper 6000##1093 |goto 58.99,62.60
accept Further Instructions##1094 |goto 58.99,62.60
step
Leave the building |goto 59.04,62.24 < 7 |walk
Follow the path |goto 60.70,63.55 < 30 |only if walking
Follow the road |goto 59.93,72.65 < 30 |only if walking
Follow the path |goto 70.28,89.01 < 20 |only if walking
Follow the path up |goto 71.93,91.79 < 15 |only if walking
talk Xen'Zilla##12816
|tip Inside the building.
turnin Blood Feeders##6461 |goto 71.25,95.03
step
Follow the path up |goto 72.89,93.73 < 15 |only if walking
Follow the path |goto 77.33,98.72 < 15 |only if walking
talk Seereth Stonebreak##4049
turnin Goblin Invaders##1062 |goto The Barrens 35.26,27.88
step
Watch the dialogue
talk Seereth Stonebreak##4049
accept Shredding Machines##1068 |goto 35.26,27.88
step
Leave the building |goto The Barrens 52.03,30.18 < 7 |walk
Follow the road |goto The Barrens 52.36,28.13 < 30 |only if walking
Continue following the road |goto 48.43,12.63 < 30 |only if walking
talk Kadrak##8582
|tip At the top of the tower.
turnin Report to Kadrak##6542 |goto 48.12,5.42
step
Follow the path |goto 47.82,5.21 < 15 |only if walking
Follow the road |goto Ashenvale 68.62,86.73 < 30 |only if walking
Follow the road |goto Ashenvale 67.29,71.35 < 30 |only if walking
Follow the path |goto  Ashenvale 71.10,69.17 < 20 |only if walking
Follow the path |goto Ashenvale 73.51,63.56 < 15 |only if walking
talk Vhulgra##12616
fpath Splintertree Post |goto Ashenvale 73.18,61.59
step
talk Senani Thunderheart##12696
turnin The Ashenvale Hunt##742 |goto 73.78,61.46
accept The Ashenvale Hunt##6383 |goto 73.78,61.46
step
Follow the path |goto 73.51,63.56 < 15 |only if walking
Follow the road |goto 70.84,69.68 < 30 |only if walking
Avoid Astranaar |goto 36.09,56.90 < 20 |only if walking
Follow the path |goto 34.52,54.02 < 20 |only if walking
Follow the road |goto 28.84,48.35 < 20 |only if walking
Follow the path |goto 25.36,38.69 < 30 |only if walking
Continue following the path |goto 18.47,32.58 < 30 |only if walking
Continue following the path |goto 16.72,30.16 < 30 |only if walking
talk Andruk##11901
fpath Zoram'gar Outpost |goto 12.23,33.80
step
talk Je'neu Sancrea##12736
|tip Inside the building.
turnin Trouble in the Deeps##6562 |goto 11.57,34.29
step
talk Marukai##12719
|tip Inside the building.
accept Naga at the Zoram Strand##6442 |goto 11.69,34.90
step
Kill Wrathtail enemies around this area
collect 20 Wrathtail Head##5490 |q 6442/1 |goto 12.68,29.52
You can find more around [14.62,19.38]
step
talk Marukai##12719
|tip Inside the building.
turnin Naga at the Zoram Strand##6442 |goto 11.69,34.90
step
Follow the path up |goto Stonetalon Mountains 44.63,61.81 < 15 |only if walking
Continue up the path |goto Stonetalon Mountains 44.88,63.31 < 15 |only if walking
talk Mor'rogal##11861
turnin Boulderslide Ravine##6421 |goto Stonetalon Mountains 47.22,64.05
step
talk Tsunaman##11862
|tip He walks around this area.
accept Elemental War##6393 |goto 47.37,64.29
step
talk Sputtervalve##3442
turnin Further Instructions##1094 |goto The Barrens 62.98,37.22
accept Further Instructions##1095 |goto The Barrens 62.98,37.22
step
talk Mebok Mizzyrix##3446
turnin Deepmoss Spider Eggs##1069 |goto 62.37,37.62
|tip You can destroy any extra "Deepmoss Egg" quest items after you turn in this quest.
step
talk Jorn Skyseer##3387
accept Enraged Thunder Lizards##907 |goto 44.86,59.14
stickystart "Collect_Hoof_Of_Lakotamani"
stickystart "Reach_Level_24"
step
kill Stormsnout##3240+
collect 3 Thunder Lizard Blood##5143 |q 907/1 |goto 46.11,55.98
You can find more around: |notinsticky
[48.67,55.70]
[47.00,51.14]
step
label "Collect_Hoof_Of_Lakotamani"
kill Lakota'mani##3474
|tip It looks like a grey kodo that walks around this area.
collect Hoof of Lakota'mani##5099 |goto 46.73,50.93 |q 883 |future
He can also be around [50.09,53.20]
step
use the Hoof of Lakota'mani##5099
accept Lakota'mani##883
step
label "Reach_Level_24"
Kill enemies around this area
Reach Level 24 |ding 24 |goto 46.11,55.98
You can find more around: |notinsticky
[48.67,55.70]
[47.00,51.14]
step
talk Jorn Skyseer##3387
turnin Enraged Thunder Lizards##907 |goto 44.86,59.14
accept Cry of the Thunderhawk##913 |goto 44.86,59.14
turnin Lakota'mani##883 |goto 44.86,59.14
step
kill Thunderhawk Hatchling##3247+
collect Thunderhawk Wings##5164 |q 913/1 |goto 46.73,50.93
You can find more around: |notinsticky
[50.27,53.70]
[46.58,49.90]
step
talk Jorn Skyseer##3387
turnin Cry of the Thunderhawk##913 |goto 44.86,59.14
step
Enter the building |goto 45.35,58.81 < 7 |walk
talk Innkeeper Byula##7714
|tip Inside the building.
home Camp Taurajo |goto 45.58,59.04
stickystart "Collect_Kodo_Liver"
step
Leave the building |goto 45.35,58.82 < 7 |walk
kill Owatanka##3473
|tip It looks like a blue thunder lizard that walks around this area.
collect Owatanka's Tailspike##5102 |goto 49.80,61.46 |q 884 |future
He can also be around [45.48,62.53]
step
use Owatanka's Tailspike##5102
accept Owatanka##884
step
label "Collect_Kodo_Liver"
map The Barrens
path	follow loose;	loop;	ants curved;	dist 30
path	47.97,61.40		46.05,61.19		45.21,64.58
path	46.82,66.59		48.41,63.48		48.59,62.02
Kill Kodo enemies around this area
|tip There is a group of them that walks together around the southern part of the Barrens.
collect Kodo Liver##4896 |q 822/3
step
click Silithid Mound+
|tip They look like larger rocks with green liquid oozing out of their tops on the ground around this area.
|tip You may sometimes be attacked by enemies that appear after you loot them.
collect 12 Silithid Egg##5058 |goto 47.99,70.25
You can find more around: |notinsticky
[44.96,69.37]
[43.02,70.49]
[44.57,72.12]
step
talk Gann Stonespire##3341
|tip He walks north and south along this road.
accept Gann's Reclamation##843 |goto 46.13,75.54
He walks between here and [46.09,84.11]
stickystart "Collect_Razormane_Backstabber"
stickystart "Collect_Razormane_Wand"
stickystart "Collect_Razormane_War_Shield"
stickystart "Collect_Washte_Pawnes_Feather"
step
kill Kuz##3436
|tip He walks around this area.
collect Kuz's Skull##5074 |q 879/1 |goto 45.44,80.02
He walks between here and around the burned buildings around [44.11,80.70]
step
kill Nak##3434
|tip He walks around this area.
|tip Be careful, some enemies are stealthed around this area.
collect Nak's Skull##5073 |q 879/2 |goto 43.82,83.10
step
Follow the path up |goto 41.30,80.66 < 15 |only if walking
Enter the building |goto 40.30,80.72 < 10 |walk
kill Lok Orcbane##3435
|tip Inside the building.
collect Lok's Skull##5072 |q 879/3 |goto 40.15,80.54
step
label "Collect_Razormane_Backstabber"
Kill Razormane enemies around this area
|tip Only Razormane Pathfinders and Razormane Stalkers will drop the quest item.
|tip Be careful, some enemies are stealthed around this area.
collect Razormane Backstabber##5093 |q 893/1 |goto 44.19,80.61
|tip Be careful not to accidentally sell this to a vendor.
You can find more around: |notinsticky
[43.82,83.10]
[42.14,81.41]
[41.65,78.79]
step
label "Collect_Razormane_Wand"
kill Razormane Seer##3458+
|tip Be careful, some enemies are stealthed around this area.
collect Charred Razormane Wand##5092 |q 893/2 |goto 42.14,81.41
|tip This has a low drop rate.
|tip Be careful not to accidentally sell this to a vendor.
You can find more around [41.65,78.79]
step
label "Collect_Razormane_War_Shield"
kill Razormane Warfrenzy##3459+
|tip Be careful, some enemies are stealthed around this area.
collect Razormane War Shield##5094 |q 893/3 |goto 42.14,81.41
|tip This has a low drop rate.
|tip Be careful not to accidentally sell this to a vendor.
You can find more around [41.65,78.79]
stickystart "Collect_Lightning_Glands"
stickystart "Collect_Thunderhawk_Saliva_Gland"
step
label "Collect_Washte_Pawnes_Feather"
kill Washte Pawne##3472
|tip It looks like a red thunderhawk that flies around this area.
collect Washte Pawne's Feather##5103 |goto 43.18,80.92 |q 885 |future
Also check around:
[44.43,78.35]
[44.46,74.76]
[46.78,79.18]
[47.63,80.29]
step
use Washte Pawne's Feather##5103
accept Washte Pawne##885
step
label "Collect_Lightning_Glands"
kill Stormhide##3238+
collect 5 Lightning Gland##4898 |q 822/1 |goto 44.88,78.18
You can find more around: |notinsticky
[44.96,75.36]
[47.81,75.13]
[47.18,79.21]
step
label "Collect_Thunderhawk_Saliva_Gland"
kill Greater Thunderhawk##3249+
collect Thunderhawk Saliva Gland##4897 |q 822/2 |goto 44.88,78.18
You can find more around: |notinsticky
[44.96,75.36]
[47.81,75.13]
[47.18,79.21]
stickystart "Kill_Baeldun_Excavators"
stickystart "Kill_Baeldun_Foremen"
step
Follow the path down |goto 46.34,85.00 < 20 |only if walking
kill Prospector Khazgorm##3392
|tip He walks around this area.
collect Khazgorm's Journal##5006 |q 843/3 |goto 47.55,85.26
He can also be around [48.33,86.22]
step
label "Kill_Baeldun_Excavators"
kill 15 Bael'dun Excavator##3374 |q 843/1 |goto 47.41,84.99
step
label "Kill_Baeldun_Foremen"
kill 5 Bael'dun Foreman##3375 |q 843/2 |goto 47.41,84.99
step
Follow the path up |goto 46.93,84.65 < 20 |only if walking
talk Gann Stonespire##3341
|tip He walks north and south along this road.
turnin Gann's Reclamation##843 |goto 46.09,84.11
accept Revenge of Gann##846 |goto 46.09,84.11
He walks between here and [46.13,75.54]
step
Kill enemies around this area
Reach Level 25 |ding 25 |goto 47.81,75.13
You can find more around: |notinsticky
[47.18,79.21]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (25-30)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (30-35)",
startlevel=25,
endlevel=30,
},[[
stickystart "Collect_Wood_Pulp"
stickystart "Collect_Sodium_Nitrate"
step
Follow the path up |goto The Barrens 48.01,83.10 < 20 |only if walking
Kill Bael'dun enemies around this area
|tip Inside and outside the building.
|tip They respawn fairly quickly, so it's safer to stay outside the building if you're solo.
collect 6 Nitroglycerin##5017 |q 846/1 |goto The Barrens 48.75,84.49
step
label "Collect_Wood_Pulp"
Kill Bael'dun enemies around this area
|tip Inside and outside the building.
|tip They respawn fairly quickly, so it's safer to stay outside the building if you're solo.
collect 6 Wood Pulp##5018 |q 846/2 |goto 48.75,84.49
step
label "Collect_Sodium_Nitrate"
Kill Bael'dun enemies around this area
|tip Inside and outside the building.
|tip They respawn fairly quickly, so it's safer to stay outside the building if you're solo.
collect 6 Sodium Nitrate##5019 |q 846/3 |goto 48.75,84.49
step
talk Gann Stonespire##3341
|tip He walks north and south along this road.
turnin Revenge of Gann##846 |goto 46.13,75.54
accept Revenge of Gann##849 |goto 46.13,75.54
He walks between here and [46.09,84.11]
step
Follow the path down |goto 46.30,84.97 < 20 |only if walking
click Bael Modan Flying Machine
|tip At the top of the wooden platform.
|tip You can click it from far away.
Destroy the Bael Modan Flying Machine |q 849/1 |goto 47.00,85.60
step
Follow the path up |goto 46.53,85.38 < 20 |only if walking
talk Gann Stonespire##3341
|tip He walks north and south along this road.
turnin Revenge of Gann##849 |goto 46.09,84.11
He walks between here and [46.13,75.54]
step
Leave the building |goto 45.35,58.82 < 7 |walk
talk Tatternack Steelforge##3433
turnin Weapons of Choice##893 |goto 45.10,57.69
step
talk Jorn Skyseer##3387
turnin Owatanka##884 |goto 44.86,59.13
turnin Washte Pawne##885 |goto 44.86,59.13
step
talk Mangletooth##3430
turnin Betrayal from Within##879 |goto 44.55,59.24
accept Betrayal from Within##906 |goto 44.55,59.24
step
talk Brewmaster Drohn##3292
turnin Chen's Empty Keg##822 |goto 62.26,38.39
step
talk Thork##3429
turnin Betrayal from Within##906 |goto 51.50,30.87
step
talk Korran##3428
turnin Egg Hunt##868 |goto 51.07,29.63
|tip You can destroy any extra "Silithid Egg" quest items you may have after you turn in this quest.
step
Follow the path |goto The Barrens 62.37,39.44 < 15 |only if walking
Follow the path onto the ship |goto The Barrens 64.18,45.49 < 7 |only if walking
click Buccaneer's Strongbox+
|tip They look like grey metal chests.
|tip Inside the ship, on the middle level.
|tip Keep clicking them until you reach Lockpicking skill level 75.
Click Here After Reaching Level 75 Lockpicking |confirm |goto The Barrens 65.07,45.44 |q 2480 |future
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
Perform the Shattered Salute |q 2460/1 |goto 43.05,53.74
|tip Target Shenthul and type "/salute" into your chat to perform the Salute emote.
|only if Rogue
step
talk Shenthul##3401
|tip Inside the tent, inside the Cleft of Shadow.
turnin The Shattered Salute##2460 |goto 43.05,53.74
accept Deep Cover##2458 |goto 43.05,53.74
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
turnin Deep Cover##2458 |goto 55.44,5.56
accept Mission: Possible But Not Probable##2478 |goto 55.44,5.56
|only if Rogue
step
collect Silixiz's Tower Key##8072 |q 2478/5 |goto 54.80,5.97
|tip Use your "Pickpocket" ability on Foreman Silixiz.
|only if Rogue
step
Enter the building |goto 54.87,5.86 < 7 |walk
kill 2 Mutated Venture Co. Drone##7310 |q 2478/1 |goto 54.71,5.73
|tip Inside the building, on the bottom floor.
|only if Rogue
step
kill 2 Venture Co. Patroller##7308 |q 2478/3 |goto 54.81,5.59
|tip Upstairs inside the building, on the lower middle floor.
|only if Rogue
step
kill 2 Venture Co. Lookout##7307 |q 2478/2 |goto 54.63,5.64
|tip Upstairs on the balcony of the building, on the upper middle floor.
|only if Rogue
step
kill Grand Foreman Puzik Gallywix##7288
|tip Upstairs inside the building, on the top floor.
|tip He is elite, but you should be able to kill him.
|tip If you have trouble, try to find someone to help you.
collect Cache of Zanzil's Altered Mixture##8073 |q 2478/6 |goto 54.75,5.59
collect Gallywix's Head##8074 |q 2478/4 |goto 54.75,5.59
|only if Rogue
step
click Gallywix's Lockbox
|tip Upstairs inside the building, on the top floor.
|tip You will get a debuff after opening it.
Receive the Touch of Zanzil |havebuff 136230 |goto 54.75,5.55 |q 2478
|only if Rogue
step
Follow the path |goto 54.71,9.86 < 50 |only if walking
Follow the road |goto 52.13,18.67 < 30 |only if walking
talk Shenthul##3401
|tip Inside the tent, inside the Cleft of Shadow.
turnin Mission: Possible But Not Probable##2478 |goto Orgrimmar 43.05,53.74
accept Hinott's Assistance##2479 |goto Orgrimmar 43.05,53.74
|only if Rogue
step
talk Shadow Priest Allister##2121
accept Beren's Peril##516 |goto Silverpine Forest 43.98,40.93
step
talk Apothecary Renferrel##1937
accept Journey to Hillsbrad Foothills##493 |goto 42.80,40.87
stickystart "Kill_Ravenclaw_Guardians"
step
Follow the road |goto 46.46,41.31 < 20 |only if walking
Continue following the road |goto 52.93,42.41 < 30 |only if walking
Continue following the road |goto 54.93,75.62 < 30 |only if walking
Follow the path up |goto 60.35,74.70 < 10 |only if walking
Enter the cave |goto 60.44,72.37 < 10 |walk
kill 6 Ravenclaw Drudger##1974 |q 516/1 |goto 59.48,70.59
|tip Inside and outside the cave.
step
label "Kill_Ravenclaw_Guardians"
kill 6 Ravenclaw Guardian##1973 |q 516/2 |goto 59.48,70.59
|tip Inside the cave.
step
Leave the cave |goto 60.44,72.37 < 10 |walk
Follow the road |goto 60.83,78.13 < 30 |only if walking
talk Deathstalker Lesh##2214
accept Time To Strike##494 |goto Hillsbrad Foothills 20.78,47.40
step
Follow the road |goto 32.34,50.22 < 30 |only if walking
Continue following the road |goto 57.30,35.42 < 30 |only if walking
talk Zarise##2389
fpath Tarren Mill |goto 60.14,18.62
step
Enter the building |goto 61.49,19.43 < 7 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Journey to Hillsbrad Foothills##493 |goto 61.44,19.06
accept Elixir of Suffering##496 |goto 61.44,19.06
accept Elixir of Pain##501 |goto 61.44,19.06
step
talk Serge Hinott##2391
|tip Inside the building.
turnin Hinott's Assistance##2479 |goto Hillsbrad Foothills 61.63,19.19
accept Hinott's Assistance##2480 |goto Hillsbrad Foothills 61.63,19.19
|only if Rogue
step
Watch the dialogue
|tip Inside the building.
Complete the Cure |q 2480/1 |goto 61.49,18.95
|only if Rogue
step
talk Serge Hinott##2391
|tip Inside the building.
turnin Hinott's Assistance##2480 |goto 61.58,18.97
|only if Rogue
step
use Hinott's Oil##8095
Remove the Touch of Zanzil |nobuff 136230
|only if Rogue
step
Leave the building |goto 61.49,19.43 < 7 |walk
talk High Executor Darthalia##2215
|tip She walks around this area.
turnin Time To Strike##494 |goto 62.33,20.46
accept Battle of Hillsbrad##527 |goto 62.33,20.46
step
Enter the building |goto 62.51,19.63 < 7 |walk
talk Innkeeper Shay##2388
|tip Inside the building.
home Tarren Mill |goto 62.78,19.02
step
Leave the building |goto 62.51,19.63 < 7 |walk
click WANTED
accept WANTED: Syndicate Personnel##549 |goto 62.62,20.73
step
Enter the building |goto 62.90,20.56 < 7 |walk
talk Krusk##2229
|tip Inside the building.
accept The Rescue##498 |goto 63.24,20.66
stickystart "Collect_Dull_Iron_Key"
stickystart "Kill_Syndicate_Rogues"
stickystart "Kill_Syndicate_Watchmen"
stickystart "Reach_Level_26"
step
Leave the building |goto 62.90,20.56 < 7 |walk
Follow the road |goto 63.74,41.89 < 30 |only if walking
Follow the path |goto 76.55,46.48 < 15 |only if walking
Cross the bridge |goto 77.38,44.67 < 10 |only if walking
Follow the path up |goto 78.28,43.33 < 10 |only if walking
Continue up the path |goto 79.37,42.99 < 10 |only if walking
kill Jailor Marlgen##2428
|tip He can spawn in multiple locations, and may walk around this area at the top of the path.
collect Burnished Gold Key##3499 |goto 77.71,39.59 |q 498
Also check inside the crumbled building around [79.81,40.25]
step
click Locked Ball and Chain
|tip It looks like a grey metal ball chained to the leg of the orc.
|tip Inside the crumbled building.
Rescue Tog'thar |q 498/2 |goto 79.79,39.64
step
label "Collect_Dull_Iron_Key"
kill Jailor Eston##2427
|tip He can spawn in multiple locations, and may walk around this area.
collect Dull Iron Key##3467 |goto 79.50,41.63 |q 498
Also check inside the building around [75.12,41.84]
step
click Locked Ball and Chain
|tip It looks like a grey metal ball chained to the leg of the orc.
|tip Inside the building.
Rescue Drull |q 498/1 |goto 75.33,41.50
step
label "Kill_Syndicate_Rogues"
kill 10 Syndicate Rogue##2260 |q 549/1 |goto 77.54,43.90
|tip All around this area inside Durnholde Keep.
step
label "Kill_Syndicate_Watchmen"
kill 10 Syndicate Watchman##2261 |q 549/2 |goto 77.54,43.90
|tip All around this area inside Durnholde Keep.
step
label "Reach_Level_26"
Kill enemies around this area
Reach Level 26 |ding 26 |goto 77.54,43.90
|tip All around this area inside Durnholde Keep.
stickystart "Collect_Gray_Bear_Tongues"
step
Run up the stairs |goto 80.60,44.10 < 5 |only if walking
Follow the path |goto 76.55,46.48 < 15 |only if walking
kill Giant Moss Creeper##2349+
collect Creeper Ichor##3477 |q 496/2 |goto 74.60,57.52
|tip This has a very low drop rate.
You can find more around: |notinsticky
[71.70,60.30]
[71.65,51.41]
[78.19,51.51]
[82.00,52.48]
[84.84,48.81]
step
label "Collect_Gray_Bear_Tongues"
kill Elder Gray Bear##2356+
collect 10 Gray Bear Tongue##3476 |q 496/1 |goto 74.60,57.52
|tip These have a low drop rate.
You can find more around: |notinsticky
[71.70,60.30]
[71.65,51.41]
[78.19,51.51]
[82.00,52.48]
[84.84,48.81]
step
Leave the building |goto 62.51,19.64 < 7 |walk
talk High Executor Darthalia##2215
|tip She walks around this area.
turnin WANTED: Syndicate Personnel##549 |goto 62.33,20.46
step
Enter the building |goto 62.91,20.57 < 7 |walk
talk Krusk##2229
|tip Inside the building.
turnin The Rescue##498 |goto 63.24,20.66
step
Leave the building |goto 62.91,20.57 < 7 |walk
Enter the building |goto 61.49,19.43 < 7 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Elixir of Suffering##496 |goto 61.44,19.06
accept Elixir of Suffering##499 |goto 61.44,19.06
step
talk Umpi##2230
|tip Inside the building.
turnin Elixir of Suffering##499 |goto 61.55,19.15
step
Leave the building |goto 61.49,19.43 < 7 |walk
kill Starving Mountain Lion##2384+
collect 10 Mountain Lion Blood##3496 |q 501/1 |goto 54.40,30.76
You can find more around: |notinsticky
[48.87,34.91]
[43.40,38.66]
[39.09,35.64]
[48.97,44.40]
[54.96,44.29]
step
Enter the building |goto 61.49,19.43 < 7 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Elixir of Pain##501 |goto 61.44,19.06
accept Elixir of Pain##502 |goto 61.44,19.06
stickystart "Kill_Hillsbrad_Farmers"
stickystart "Kill_Hillsbrad_Farmhands"
step
Leave the building |goto 61.49,19.43 < 7 |walk
Follow the road |goto 56.91,36.65 < 30 |only if walking
Follow the path |goto 42.48,44.54 < 30 |only if walking
kill Farmer Getz##2403 |q 527/4 |goto 36.74,39.44
|tip Inside the building.
He can also be:
Inside the barn at [35.13,37.54]
In the field around [35.35,40.80]
step
talk Stanley##2274
|tip He looks like a small wolf that walks around this area in front of the building.
|tip After you turn in the quest, he will become enraged and attack you.
turnin Elixir of Pain##502 |goto 32.66,35.32
step
Enter the building |goto 32.92,35.24 < 7 |walk
kill Farmer Ray##232 |q 527/3 |goto 33.68,35.42
He can also be upstairs inside the building at [33.22,34.76]
step
label "Kill_Hillsbrad_Farmers"
Leave the building |goto 32.92,35.24 < 7 |walk
kill 6 Hillsbrad Farmer##2266 |q 527/1 |goto 31.24,37.49
You can find more around [34.79,40.52]
step
label "Kill_Hillsbrad_Farmhands"
kill 6 Hillsbrad Farmhand##2360 |q 527/2 |goto 31.24,37.49
You can find more around [34.79,40.52]
step
Follow the road |goto 41.79,45.08 < 30 |only if walking
talk High Executor Darthalia##2215
|tip She walks around this area.
turnin Battle of Hillsbrad##527 |goto 62.33,20.46
step
talk Shadow Priest Allister##2121
turnin Beren's Peril##516 |goto Silverpine Forest 43.98,40.93
step
talk Braelyn Firehand##4198
accept Cenarius' Legacy##1087 |goto Stonetalon Mountains 45.94,60.42
step
talk Tammra Windfield##11864
accept Cycle of Rebirth##6301 |goto 47.46,58.38
step
talk Maggran Earthbinder##11860
accept Calling in the Reserves##5881 |goto 47.20,61.15
accept Harpies Threaten##6282 |goto 47.20,61.15
step
Enter the building |goto 47.80,61.44 < 7 |walk
talk Innkeeper Jayka##7731
|tip Inside the building.
home Sun Rock Retreat |goto 47.47,62.13
stickystart "Collect_Courser_Eyes"
stickystart "Collect_Stonetalon_Sap"
step
Leave the building |goto 47.81,61.45 < 7 |walk
Follow the path |goto 49.77,60.91 < 20 |only if walking
Follow the road |goto 52.56,56.73 < 30 |only if walking
click Gaea Seed+
|tip They look large brown pine cones on the ground around this area.
|tip Be careful to avoid Sorrow Wing.
|tip It looks like a level 27 elite grey windstrider that flies around this area.
collect 10 Gaea Seed##16205 |q 6301/1 |goto 49.33,44.09
You can find more around: |notinsticky
[46.39,38.89]
[50.48,36.81]
step
label "Collect_Courser_Eyes"
Follow the path |goto 46.87,31.51 < 20 |only if walking
kill Antlered Courser##4018+
|tip They look like deer.
collect 30 Courser Eye##5585 |q 1058/3 |goto 45.07,24.08
You can find more around [39.86,10.89]
stickystart "Collect_Twilight_Whiskers"
step
kill Fey Dragon##4016+
|tip They look like small blue dragons.
|tip They are uncommon and spread out around this area.
collect Fey Dragon Scale##5583 |q 1058/4 |goto 37.41,21.06
You can find more around: |notinsticky
[39.66,13.58]
[33.14,13.21]
step
label "Collect_Stonetalon_Sap"
kill Sap Beast##4020+
|tip They look like green oozes.
|tip The Corrosive Sap Beasts will not drop the quest item.
collect 5 Stonetalon Sap##5582 |q 1058/1 |goto 34.16,18.16
You can find more around [38.75,17.26]
stickystart "Kill_Sons_Of_Cenarius"
stickystart "Kill_Daughters_Of_Cenarius"
stickystart "Kill_Cenarion_Botanists"
stickystart "Reach_Level_27"
step
label "Collect_Twilight_Whiskers"
kill Twilight Runner##4067+
|tip They look like blue jaguars with white spots.
collect 5 Twilight Whisker##5584 |q 1058/2 |goto 31.89,10.01
step
label "Kill_Sons_Of_Cenarius"
kill 4 Son of Cenarius##4057 |q 1087/1 |goto 36.09,12.57
|tip They have Treant Ally bodyguards that look like walking trees.
|tip Be careful to svoid Sentinel Amarassan, the level 27 elite night elf that walks around this area.
step
label "Kill_Daughters_Of_Cenarius"
kill 4 Daughter of Cenarius##4053 |q 1087/2 |goto 36.09,12.57
|tip Be careful to svoid Sentinel Amarassan, the level 27 elite night elf that walks around this area.
step
label "Kill_Cenarion_Botanists"
kill 4 Cenarion Botanist##4051 |q 1087/3 |goto 36.09,12.57
|tip Be careful to svoid Sentinel Amarassan, the level 27 elite night elf that walks around this area.
step
label "Reach_Level_27"
Kill enemies around this area
|tip Be careful to svoid Sentinel Amarassan, the level 27 elite night elf that walks around this area.
Reach Level 27 |ding 27 |goto 36.09,12.57
step
Follow the path |goto 41.62,15.97 < 20 |only if walking
Follow the path down |goto 46.49,27.53 < 30 |only if walking
Follow the road |goto 46.37,36.71 < 30 |only if walking
Continue following the road |goto 51.55,49.42 < 30 |only if walking
Follow the path up |goto 50.84,52.43 < 20 |only if walking
Jump down here |goto 48.54,57.77 < 15 |only if walking
talk Tammra Windfield##11864
turnin Cycle of Rebirth##6301 |goto 47.46,58.38
accept New Life##6381 |goto 47.46,58.38
step
talk Braelyn Firehand##4198
turnin Cenarius' Legacy##1087 |goto 45.94,60.42
step
Follow the path |goto 49.40,60.98 < 20 |only if walking
Continue following the path |goto 52.11,61.15 < 30 |only if walking
Continue following the path |goto 56.49,64.01 < 30 |only if walking
Enter the building |goto 59.04,62.24 < 7 |walk
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Further Instructions##1095 |goto 58.99,62.60
accept Gerenzo Wrenchwhistle##1096 |goto 58.99,62.60
step
Leave the building |goto 59.04,62.24 < 7 |walk
kill XT:9##4074 |q 1068/2 |goto 61.80,56.23
|tip It looks like a grey metal goblin machine that walks around this area.
Also check around:
[62.37,52.14]
[66.41,55.81]
step
kill XT:4##4073 |q 1068/1 |goto 64.63,46.59
|tip It looks like a grey metal goblin machine that walks around this area.
Also check around [68.24,47.46]
step
Follow the path up |goto 68.94,39.83 < 15 |only if walking
Run down the stairs |goto 64.55,38.04 < 10 |only if walking
kill Gerenzo Wrenchwhistle##4202
|tip Up on the wooden platform.
|tip He can spawn in other locations on this platform, so search around if he's not here.
collect Gerenzo's Mechanical Arm##5736 |q 1096/1 |goto 64.49,40.25
step
Follow the path |goto 61.96,58.21 < 40 |only if walking
Enter the building |goto 59.04,62.24 < 7 |walk
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Gerenzo Wrenchwhistle##1096 |goto 58.99,62.60
step
Leave the building |goto 59.04,62.24 < 7 |walk
Follow the path |goto 60.68,63.53 < 30 |only if walking
Follow the road |goto 59.91,72.17 < 30 |only if walking
Follow the path up |goto 71.86,91.75 < 15 |only if walking
Enter the cave |goto 74.23,97.12 < 10 |walk
talk Witch Doctor Jin'Zil##3995
|tip Inside the cave.
turnin Jin'Zil's Forest Magic##1058 |goto 74.54,97.94
step
Leave the cave |goto 74.17,97.00 < 10 |walk
Follow the path up |goto 72.89,93.73 < 10 |only if walking
Follow the path |goto 77.33,98.72 < 15 |only if walking
talk Seereth Stonebreak##4049
turnin Shredding Machines##1068 |goto The Barrens 35.26,27.88
step
Leave the building |goto Stonetalon Mountains 47.80,61.45 < 7 |walk
talk Zangen Stonehoof##4721
accept The Sacred Flame##1195 |goto Thunder Bluff 54.96,51.38
step
Follow the road |goto The Barrens 46.84,65.71 < 30 |only if walking
talk Grish Longrunner##12576
|tip This npc gets killed fairly often by Alliance players entering Thousand Needles.
|tip If he's not here, just wait until he respawns.
turnin Calling in the Reserves##5881 |goto Thousand Needles 31.86,21.66
step
talk Brave Moonhorn##10079
accept Message to Freewind Post##4542 |goto 32.24,22.16
step
Ride an elevator down |goto 31.72,23.62 < 10 |only if walking
Follow the road |goto 30.94,28.80 < 30 |only if walking
Continue following the road |goto 29.81,41.92 < 30 |only if walking
Ride the elevator up |goto 46.72,48.23 < 10 |only if walking
talk Nyse##4317
fpath Freewind Post |goto 45.14,49.11
step
talk Elu##10377
|tip He walks around this area.
accept Wind Rider##4767 |goto 44.93,48.93
step
talk Hagar Lightninghoof##10539
accept Alien Egg##4821 |goto 44.64,50.29
step
talk Cliffwatcher Longhorn##10537
turnin Message to Freewind Post##4542 |goto 45.65,50.80
accept Pacify the Centaur##4841 |goto 45.65,50.80
step
click Wanted Poster - Arnak Grimtotem
accept Wanted - Arnak Grimtotem##5147 |goto 46.00,50.84
stickystart "Kill_Galak_Wranglers"
stickystart "Kill_Galak_Windchasers"
step
Ride the elevator down |goto 46.72,48.26 < 10 |only if walking
kill 12 Galak Scout##4094 |q 4841/1 |goto 45.73,41.01
You can find more around [41.63,37.69]
step
label "Kill_Galak_Wranglers"
kill 10 Galak Wrangler##4093 |q 4841/2 |goto 45.73,41.01
You can find more around [41.63,37.69]
step
label "Kill_Galak_Windchasers"
kill 6 Galak Windchaser##4096 |q 4841/3 |goto 45.73,41.01
You can find more around [41.63,37.69]
step
Ride the elevator up |goto Thousand Needles 46.72,48.23 < 10 |only if walking
talk Cliffwatcher Longhorn##10537
turnin Pacify the Centaur##4841 |goto Thousand Needles 45.65,50.80
accept Grimtotem Spying##5064 |goto Thousand Needles 45.65,50.80
step
Follow the path |goto Ashenvale 73.51,63.53 < 15 |only if walking
talk Kuray'bin##12867
accept Ashenvale Outrunners##6503 |goto Ashenvale 71.10,68.12
step
kill 9 Ashenvale Outrunner##12856 |q 6503/1 |goto 74.63,71.67
|tip They look like stealthed night elves around this area.
|tip They tend be near the trees around this area.
|tip Be careful to avoid Sharptalon.
|tip It looks like a level 31, large blue bird that flies low to the ground around this area.
You can find more around: |notinsticky
[71.07,75.21]
[76.89,71.90]
step
Follow the path |goto 70.09,75.49 < 20 |only if walking
talk Torek##12858
|tip Make sure 3 Splintertree Raiders are next to him before talking to him.
|tip If you don't see them, wait until they appear.
|tip This is an escort quest, and they will not help you if they are not there.
accept Torek's Assault##6544 |goto 68.34,75.30
step
Watch the dialogue
|tip Follow Torek and protect him as he walks.
|tip He eventually walks to this location.
|tip A group of 4 enemies will spawn inside the building, so be prepared.
|tip Torek must survive.
kill Duriel Moonfire##12860
Take Silverwing Outpost |q 6544/1 |goto 64.66,75.34
step
Leave the building |goto 65.06,75.34 < 10 |walk
Follow the road |goto 67.41,71.25 < 30 |only if walking
Follow the path |goto 71.12,69.17 < 30 |only if walking
talk Kuray'bin##12867
turnin Ashenvale Outrunners##6503 |goto 71.10,68.12
step
Follow the path |goto 73.51,63.52 < 15 |only if walking
talk Ertog Ragetusk##12877
turnin Torek's Assault##6544 |goto 73.03,62.47
step
Enter the building |goto 73.72,60.94 < 7 |walk
talk Innkeeper Kaylisk##12196
|tip Inside the building.
home Splintertree Post |goto 73.99,60.64
step
Leave the building |goto 73.72,60.94 < 7 |walk
talk Karang Amakkar##12757
accept Between a Rock and a Thistlefur##216 |goto 11.90,34.53
step
talk Mitsuwa##12721
accept Troll Charm##6462 |goto 11.65,34.85
step
talk Muglash##12717
|tip If he's not here, another player may be doing the escort quest.
|tip Just wait for him to respawn.
accept Vorsha the Lasher##6641 |goto 12.06,34.63
step
Watch the dialogue
|tip Follow Muglash and protect him as he walks.
click Naga Brazier
|tip It looks like a puple flame brazier.
|tip Click it when Muglash tells you to.
Kill the enemies that attack in waves
kill Vorsha the Lasher##12940
Watch the dialogue
Defeat Vorsha the Lasher |q 6641/1 |goto 9.62,27.66
step
talk Warsong Runner##12863
turnin Vorsha the Lasher##6641 |goto 12.22,34.21
stickystart "Kill_Thistlefur_Shamans"
stickystart "Reach_Level_28"
step
Follow the path |goto 14.52,30.91 < 30 |only if walking
Follow the road |goto 25.53,37.73 < 20 |only if walking
Follow the path |goto 30.30,46.76 < 30 |only if walking
kill 12 Thistlefur Avenger##3925 |q 216/1 |goto 31.29,44.45
You can find more around: |notinsticky
[32.36,42.50]
[33.22,39.12]
[35.85,32.36]
step
label "Kill_Thistlefur_Shamans"
kill 12 Thistlefur Shaman##3924 |q 216/2 |goto 31.29,44.45
You can find more around: |notinsticky
[32.36,42.50]
[33.22,39.12]
[35.85,32.36]
step
label "Reach_Level_28"
Kill enemies around this area
Reach Level 28 |ding 28 |goto 31.29,44.45
You can find more around: |notinsticky
[32.36,42.50]
[33.22,39.12]
[35.85,32.36]
step
Follow the path up |goto 37.48,32.25 < 20 |only if walking
Enter the cave |goto 38.41,30.57 < 10 |walk
Follow the path |goto 39.47,30.99 < 10 |walk
click Troll Chest+
|tip They look like small brown wooden boxes on the ground all throughout the cave.
collect 8 Troll Charm##16602 |q 6462/1 |goto 39.94,32.08
step
Follow the path |goto 40.28,32.16 < 10 |walk
Continue following the path |goto 40.88,33.58 < 10 |walk
talk Ruul Snowhoof##12818
|tip Inside the cave.
accept Freedom to Ruul##6482 |goto 41.49,34.50
step
Escort Ruul from the Thistlefurs |q 6482/1 |goto 38.56,37.47
|tip Follow Ruul Snowhoof and protect him as he walks.
|tip He leaves the cave and eventually walks to this location.
step
talk Yama Snowhoof##12837
|tip Inside the building.
turnin Freedom to Ruul##6482 |goto 74.11,60.92
step
Leave the building |goto 73.71,60.94 < 7 |walk
talk Mastok Wrilehiss##12737
accept Stonetalon Standstill##25 |goto 73.67,60.01
step
talk Pixel##12724
accept Satyr Horns##6441 |goto 73.06,61.48
step
Follow the path |goto 73.52,63.51 < 15 |only if walking
kill Sharptalon##12676
|tip He looks like a large blue bird that flies low to the ground around this area.
|tip If you have any trouble killing him, you can fight him to about 30% health, then kite him to the guards at Splintertree Post.
|tip The guards will help you kill him.
collect Sharptalon's Claw##16305 |goto 73.12,70.56 |q 2 |future
Also check around:
[71.49,70.10]
[75.87,69.74]
[76.51,68.03]
[78.15,65.74]
step
use Sharptalon's Claw##16305
accept Sharptalon's Claw##2
step
Follow the path |goto 73.51,63.52 < 15 |only if walking
talk Senani Thunderheart##12696
turnin Sharptalon's Claw##2 |goto 73.78,61.46
stickystart "Collect_Shadumbras_Head"
step
Follow the path |goto 73.52,63.51 < 15 |only if walking
Follow the road |goto 70.80,69.68 < 30 |only if walking
Follow the path |goto 56.38,58.66 < 30 |only if walking
kill Laughing Sister##4054+
collect Etched Phial##5867 |goto 58.64,55.75 |q 1195
You can find more around [60.63,52.19]
step
label "Collect_Shadumbras_Head"
kill Shadumbra##12677
|tip It looks like a black panther that walks around this area.
collect Shadumbra's Head##16304 |goto 60.76,52.01 |q 24 |future
Also check around:
[57.44,56.03]
[54.45,54.80]
step
use Shadumbra's Head##16304
accept Shadumbra's Head##24
step
Follow the path up |goto 62.95,44.36 < 20 |only if walking
Follow the path |goto 65.43,44.07 < 20 |only if walking
Kill Felmusk enemies around this area
|tip They look like satyrs.
|tip Some of them are stealthed around this area, so be careful.
collect 16 Satyr Horns##5481 |q 6441/1 |goto 66.36,52.48
You can find more around: |notinsticky
[66.77,55.65]
[68.58,53.57]
step
Jump down and follow the road |goto 63.92,52.01 < 30 |only if walking
Continue following the road |goto 59.78,63.36 < 30 |only if walking
Follow the path down |goto 61.54,68.35 < 20 |only if walking
use the Etched Phial##5867
collect Filled Etched Phial##5868 |q 1195/1 |goto 60.20,72.90
stickystart "Collect_Befouled_Water_Globe"
stickystart "Kill_Befouled_Water_Elementals"
step
Follow the path |goto 58.77,72.47 < 10 |only if walking
Continue following the path |goto 55.17,69.40 < 30 |only if walking
Scout the Gazebo on Mystral Lake that Overlooks the Nearby Alliance Outpost |q 25/2 |goto 48.92,69.57
step
label "Collect_Befouled_Water_Globe"
kill Tideress##12759
|tip It looks like a darker green colored water elemental that moves around this area.
|tip It moves in the water of the whole lake, and on this small island, so you may need to search around for it.
collect Befouled Water Globe##16408 |goto 48.11,69.78 |q 1918 |future
step
use the Befouled Water Globe##16408
accept The Befouled Element##1918
step
label "Kill_Befouled_Water_Elementals"
kill 12 Befouled Water Elemental##3917 |q 25/1 |goto 48.11,69.78
|tip You can find more in the water around this area.
step
map Ashenvale
path	follow strict;	loop;	ants curved;	dist 30
path	43.34,68.43		41.75,68.07		39.83,65.29		39.62,63.45
path	40.00,65.52		41.18,65.80		42.85,63.11		44.39,64.54
path	43.16,63.81		41.33,66.84		42.10,68.41
kill Ursangous##12678
|tip He looks like a grey night elf druid bear that walks around this area.
collect Ursangous's Paw##16303 |q 23 |future
step
use Ursangous's Paw##16303
accept Ursangous's Paw##23
step
Leave the building |goto 73.72,60.93 < 7 |walk
talk Senani Thunderheart##12696
turnin Shadumbra's Head##24 |goto 73.78,61.46
turnin Ursangous's Paw##23 |goto 73.78,61.46
accept The Hunt Completed##247 |goto 73.78,61.46
step
talk Mastok Wrilehiss##12737
turnin Stonetalon Standstill##25 |goto 73.66,60.01
turnin The Befouled Element##1918 |goto 73.66,60.01
accept Je'neu of the Earthen Ring##824 |goto 73.66,60.01
step
talk Pixel##12724
turnin Satyr Horns##6441 |goto 73.06,61.48
step
talk Je'neu Sancrea##12736
|tip Inside the building.
turnin Je'neu of the Earthen Ring##824 |goto 11.57,34.29
step
talk Karang Amakkar##12757
turnin Between a Rock and a Thistlefur##216 |goto 11.90,34.53
step
talk Mitsuwa##12721
|tip Inside the building.
turnin Troll Charm##6462 |goto 11.65,34.85
stickystart "Collect_Incendrites"
stickystart "Kill_Bloodfury_Harpies"
stickystart "Kill_Bloodfury_Ambushers"
stickystart "Kill_Bloodfury_Slayers"
stickystart "Kill_Bloodfury_Roguefeathers"
stickystart "Reach_Level_29"
step
Follow the path up |goto Stonetalon Mountains 44.63,61.81 < 15 |only if walking
Follow the path down |goto Stonetalon Mountains 43.53,65.33 < 15 |only if walking
Continue down the path |goto Stonetalon Mountains 41.16,70.69 < 20 |only if walking
Follow the path |goto Stonetalon Mountains 37.90,67.87 < 20 |only if walking
click Gaea Dirt Mound+
|tip They look like piles of green and brown dirt on the ground around this area.
Plant #10# Gaea Seeds |q 6381/1 |goto Stonetalon Mountains 32.25,68.16
step
label "Collect_Incendrites"
Kill enemies around this area
|tip Only enemies that look like fire elementals will drop the quest item.
collect 10 Incendrites##16312 |q 6393/1 |goto 29.65,64.44
You can find more around: |notinsticky
[31.27,73.77]
[35.92,72.58]
[34.86,64.96]
step
label "Kill_Bloodfury_Harpies"
kill 7 Bloodfury Harpy##4022 |q 6282/1 |goto 34.51,62.27
You can find more around: |notinsticky
[32.26,60.12]
[32.44,65.30]
step
label "Kill_Bloodfury_Ambushers"
kill 7 Bloodfury Ambusher##4025 |q 6282/2 |goto 30.24,62.84
You can find more around: |notinsticky
[34.51,62.27]
[32.44,65.30]
step
label "Kill_Bloodfury_Slayers"
kill 7 Bloodfury Slayer##4024 |q 6282/3 |goto 35.96,68.52
You can find more around [28.83,69.50]
step
label "Kill_Bloodfury_Roguefeathers"
kill 7 Bloodfury Roguefeather##4023 |q 6282/4 |goto 35.96,68.52
You can find more around [28.83,69.50]
step
label "Reach_Level_29"
Kill enemies around this area
Reach Level 29 |ding 29 |goto 32.25,68.16
step
Follow the path up |goto 37.93,67.96 < 15 |only if walking
Continue up the path |goto 41.37,70.24 < 15 |only if walking
Follow the path down |goto 43.62,65.04 < 15 |only if walking
Follow the path up |goto 44.93,63.37 < 15 |only if walking
talk Tsunaman##11862
|tip It walks around this area.
turnin Elemental War##6393 |goto 47.19,64.42
step
talk Maggran Earthbinder##11860
turnin Harpies Threaten##6282 |goto 47.19,61.14
accept Bloodfury Bloodline##6283 |goto 47.19,61.14
step
talk Tammra Windfield##11864
turnin New Life##6381 |goto 47.46,58.38
step
Follow the path up |goto 44.63,61.81 < 15 |only if walking
Follow the path down |goto 43.53,65.33 < 15 |only if walking
Continue down the path |goto 41.16,70.68 < 20 |only if walking
Follow the path |goto 37.90,67.87 < 20 |only if walking
kill Bloodfury Ripper##12579
|tip She looks like a blue harpy that flies around this area.
|tip She's elite, but pretty easy to solo.
|tip If you can't solo her, try to get someone to help, otherwise you can skip the quest.
collect Bloodfury Ripper's Remains##16190 |q 6283/1 |goto 30.76,61.92
step
Follow the path up |goto 37.93,67.96 < 15 |only if walking
Continue up the path |goto 41.37,70.24 < 15 |only if walking
Follow the path down |goto 43.62,65.04 < 15 |only if walking
Follow the path |goto 44.86,61.13 < 20 |only if walking
talk Maggran Earthbinder##11860
turnin Bloodfury Bloodline##6283 |goto 47.20,61.15
step
talk Zangen Stonehoof##4721
turnin The Sacred Flame##1195 |goto Thunder Bluff 54.97,51.39
accept The Sacred Flame##1196 |goto Thunder Bluff 54.97,51.39
step
talk Deathguard Samsa##2418
accept Souvenirs of Death##546 |goto Hillsbrad Foothills 62.11,19.71
step
click Dangerous!
|tip It looks like a wanted poster on the doorway of the building.
accept Dangerous!##567 |goto 62.55,19.69
step
talk High Executor Darthalia##2215
|tip She walks around this area.
accept Battle of Hillsbrad##528 |goto 62.33,20.45
stickystart "Kill_Citizen_Wilkes"
stickystart "Kill_Hillsbrad_Peasants"
stickystart "Collect_Hillsbrad_Human_Skulls"
step
Follow the road |goto 51.24,39.20 < 30 |only if walking
kill Farmer Kalaba##2451 |q 567/4 |goto 34.68,46.04
|tip She walks around this area carrying a pitchfork.
step
label "Kill_Citizen_Wilkes"
kill Citizen Wilkes##2449 |q 567/2 |goto 32.60,35.89
|tip He walks on the path between the eastern small house and the northern large house carrying a lantern.
You can also check for him around:
[32.53,39.96]
[34.76,38.61]
[36.34,39.40]
step
label "Kill_Hillsbrad_Peasants"
kill 15 Hillsbrad Peasant##2267 |q 528/1 |goto 35.02,46.69
stickystop "Collect_Hillsbrad_Human_Skulls"
step
Follow the road |goto 41.25,45.54 < 30 |only if walking
talk High Executor Darthalia##2215
|tip She walks around this area.
turnin Battle of Hillsbrad##528 |goto 62.33,20.45
accept Battle of Hillsbrad##529 |goto 62.33,20.45
stickystart "Kill_Hillsbrad_Apprentice_Blacksmiths"
stickystart "Collect_Hillsbrad_Human_Skulls"
step
Follow the road |goto 51.24,39.20 < 30 |only if walking
Follow the path |goto 33.61,49.54 < 30 |only if walking
kill Blacksmith Verringtan##2404 |q 529/1 |goto 32.17,45.65
|tip Inside the building.
He can also be outside the building around [32.10,44.42]
step
click Shipment of Iron
|tip Inside the building.
collect Shipment of Iron##3564 |q 529/3 |goto 32.04,45.43
step
label "Kill_Hillsbrad_Apprentice_Blacksmiths"
kill 4 Hillsbrad Apprentice Blacksmith##2265 |q 529/2 |goto 32.04,45.43
|tip Inside and outside the building.
stickystop "Collect_Hillsbrad_Human_Skulls"
step
Follow the road |goto 33.66,49.67 < 30 |only if walking
talk High Executor Darthalia##2215
|tip She walks around this area.
turnin Battle of Hillsbrad##529 |goto 62.33,20.45
accept Battle of Hillsbrad##532 |goto 62.33,20.45
stickystart "Kill_Hillsbrad_Councilmen"
stickystart "Collect_Hillsbrad_Human_Skulls"
step
Follow the road |goto 51.24,39.20 < 30 |only if walking
Follow the path |goto 33.61,49.54 < 30 |only if walking
Run up the stairs |goto 31.64,42.26 < 15 |only if walking
Enter the building |goto 30.46,42.20 < 10 |walk
kill Clerk Horrace Whitesteed##2448 |q 567/1 |goto 29.81,42.42
|tip Inside the building.
step
kill Magistrate Burnside##2335 |q 532/1 |goto 29.67,41.64
|tip Inside the building.
step
click Hillsbrad Proclamation
|tip Inside the building.
Destroy the Hillsbrad Proclamation |q 532/3 |goto 29.73,41.75
step
click Hillsbrad Town Registry
|tip Inside the building.
collect Hillsbrad Town Registry##3657 |q 532/4 |goto 29.52,41.54
step
Leave the building |goto 30.46,42.20 < 10 |c |q 532
step
label "Kill_Hillsbrad_Councilmen"
kill 5 Hillsbrad Councilman##2387 |q 532/2 |goto 30.46,42.20
|tip Inside and outside the building.
step
label "Collect_Hillsbrad_Human_Skulls"
Kill Hillsbrad enemies around this area
collect 30 Hillsbrad Human Skull##3692 |q 546/1 |goto 34.96,46.24
You can find more around: |notinsticky
[34.82,40.83]
[31.46,37.58]
step
Follow the road |goto 41.25,45.54 < 30 |only if walking
Enter the building |goto 61.50,19.44 < 7 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
accept Elixir of Agony##509 |goto 61.44,19.06
step
Leave the building |goto 61.50,19.44 < 7 |walk
talk Deathguard Samsa##2418
turnin Souvenirs of Death##546 |goto 62.11,19.71
step
talk High Executor Darthalia##2215
|tip She walks around this area.
turnin Battle of Hillsbrad##532 |goto 62.33,20.45
accept Battle of Hillsbrad##539 |goto 62.33,20.45
step
click Mudsnout Blossom+
|tip They look like large white and blue mushrooms on the ground around this area.
collect 6 Mudsnout Blossoms##3502 |q 509/1 |goto 64.26,61.28
step
Kill enemies around this area
Reach Level 30 |ding 30 |goto 64.26,61.28
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (30-35)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (35-40)",
startlevel=30,
endlevel=35,
},[[
step
Enter the building |goto Hillsbrad Foothills 62.51,19.61 < 7 |walk
talk Innkeeper Shay##2388
|tip Inside the building.
home Tarren Mill |goto Hillsbrad Foothills 62.79,19.02
step
Leave the building |goto 62.51,19.61 < 7 |walk
Enter the building |goto 61.50,19.44 < 7 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Elixir of Agony##509 |goto 61.44,19.06
accept Elixir of Agony##513 |goto 61.44,19.06
stickystart "Kill_Miner_Hackett"
stickystart "Kill_Hillsbrad_Miners"
step
Leave the building |goto 61.50,19.43 < 7 |walk
Follow the road |goto 51.24,39.20 < 30 |only if walking
Follow the path |goto 35.75,49.13 < 30 |only if walking
Follow the path down |goto 29.53,59.81 < 20 |only if walking
Follow the path |goto 26.82,59.97 < 20 |only if walking
Enter the mine |goto 26.51,58.61 < 7 |q 539
step
Follow the path |goto 28.35,57.21 < 10 |walk
Follow the path |goto 30.11,57.32 < 10 |walk
kill Foreman Bonds##2305 |q 539/1 |goto 31.21,56.01
|tip Inside the mine.
|tip Try to kill him quickly when he's at about 10% health, or he will summon 2 dwarf enemies.
step
label "Kill_Miner_Hackett"
Follow the path |goto 30.22,57.86 < 10 |walk
kill Miner Hackett##2450 |q 567/3 |goto 31.12,58.62
|tip Inside the mine.
|tip He can spawn in multiple locations inside the mine.
He can also be around:
[30.60,56.38]
[31.97,52.28]
[29.70,56.02]
step
label "Kill_Hillsbrad_Miners"
kill 10 Hillsbrad Miner##2269 |q 539/2 |goto 29.89,57.74
|tip Inside the mine.
step
Leave the building |goto 62.51,19.62 < 7 |walk
talk High Executor Darthalia##2215
|tip She walks around this area.
turnin Dangerous!##567 |goto 62.33,20.46
turnin Battle of Hillsbrad##539 |goto 62.33,20.46
step
Follow the path down |goto Undercity 52.87,77.59 < 7 |walk
Continue down the path |goto Undercity 47.75,76.27 < 7 |walk
talk Master Apothecary Faranell##2055
turnin Elixir of Agony##513 |goto Undercity 48.82,69.27
step
Enter the building |goto Orgrimmar 76.56,32.87 < 10 |walk
talk Sorek##3354
|tip Inside the building.
accept The Islander##1718 |goto Orgrimmar 80.40,32.37
|only if Warrior
step
Leave the building |goto Orgrimmar 76.56,32.87 < 10 |walk
talk Klannoc Macleod##6236
turnin The Islander##1718 |goto The Barrens 68.62,49.17
accept The Affray##1719 |goto The Barrens 68.62,49.17
|only if Warrior
step
Step on the Grate to Begin the Affray |q 1719/1 |goto 68.61,48.72
|only if Warrior
step
kill Affray Challenger##6240+
|tip You will have to kill six of them before Big Will will appear.
|tip They will fight them one at a time.
kill Big Will##6238 |q 1719/2 |goto 68.61,48.72
|tip It may take a while before he appears.
|only if Warrior
step
talk Klannoc Macleod##6236
turnin The Affray##1719 |goto 68.62,49.17
|only if Warrior
step
Enter the building |goto Orgrimmar 40.25,36.98 < 10 |walk
talk Searn Firewarder##5892
|tip Inside the building.
accept Call of Air##1531 |goto Orgrimmar 37.97,37.73
|only if Shaman
step
Leave the building |goto 40.25,36.98 < 10 |c |q 1531
|only if Shaman
step
Enter the building |goto Thunder Bluff 44.99,62.09 < 7 |walk
talk Innkeeper Pala##6746
|tip Inside the building.
home Thunder Bluff |goto Thunder Bluff 45.82,64.71
step
Enter the building |goto Thousand Needles 45.95,51.07 < 7 |walk
talk Rau Cliffrunner##4722
|tip Inside the building.
turnin The Sacred Flame##1196 |goto Thousand Needles 46.14,51.72
accept The Sacred Flame##1197 |goto Thousand Needles 46.14,51.72
step
Leave the building |goto 45.95,51.07 < 7 |walk
Ride the elevator down |goto 47.06,48.85 < 10 |only if walking
Follow the road |goto 49.41,52.47 < 30 |only if walking
click Alien Egg
|tip It looks like a large white egg sitting upright on the ground.
|tip It can spawn in multiple locations.
collect Alien Egg##12467 |q 4821/1 |goto 52.33,55.21
Also check around:
[56.35,50.36]
step
Follow the path up |goto 54.68,44.78 < 15 |c |q 1149 |future
step
talk Prate Cloudseer##5905
turnin Call of Air##1531 |goto 53.54,42.65
|only if Shaman
step
Enter the cave |goto 53.67,42.51 < 10 |walk
talk Dorn Plainstalker##2986
|tip Inside the cave.
accept Test of Faith##1149 |goto 53.94,41.48
step
Watch the dialogue
Teleport to the Plateau |goto 26.43,31.29 < 20 |noway |c |q 1149
step
Jump down here |goto 26.43,32.41
|tip You won't die.
Return to Dorn Plainstalker |goto 53.89,41.62 < 20 |noway |c |q 1149
step
talk Dorn Plainstalker##2986
|tip Inside the cave.
turnin Test of Faith##1149 |goto 53.94,41.48
step
Leave the cave |goto 53.66,42.69 < 10 |walk
Enter the cave |goto 44.05,37.34 < 10 |walk
Follow the path |goto 44.24,35.60 < 10 |walk
Follow the path |goto 43.46,35.28 < 10 |walk
Continue following the path |goto 42.06,34.68 < 10 |walk
click Ancient Brazier
|tip Inside the cave.
collect Cloven Hoof##5869 |q 1197/1 |goto 42.01,31.51
step
Follow the path up |goto 41.69,32.65 < 10 |walk
Continue up the path |goto 42.10,34.77 < 10 |walk
Follow the path |goto 44.37,35.77 < 10 |walk
Leave the cave |goto 44.02,37.39 < 10 |walk
Ride the elevator up |goto 46.73,48.05 < 10 |only if walking
talk Hagar Lightninghoof##10539
turnin Alien Egg##4821 |goto 44.64,50.29
accept Serpent Wild##4865 |goto 44.64,50.29
step
Enter the building |goto 45.94,51.06 < 7 |walk
talk Rau Cliffrunner##4722
|tip Inside the building.
turnin The Sacred Flame##1197 |goto 46.14,51.71
step
Leave the building |goto 45.94,51.06 < 7 |walk
Ride the elevator down |goto 46.60,48.39 < 10 |only if walking
Follow the road |goto 44.57,46.45 < 30 |only if walking
Continue following the road |goto 29.07,33.80 < 30 |only if walking
talk Motega Firemane##10428
|tip He walks around this area.
turnin Serpent Wild##4865 |goto 21.54,32.35
accept Sacred Fire##5062 |goto 21.54,32.35
step
Follow the road |goto 23.96,32.25 < 30 |only if walking
Follow the path up |goto 31.24,36.88 < 10 |only if walking
Cross the hanging bridge |goto 33.13,35.33 < 7 |only if walking
Cross the hanging bridge |goto 31.97,31.32 < 7 |only if walking
Cross the hanging bridge |goto 33.27,28.56 < 7 |only if walking
Cross the hanging bridge |goto 34.94,31.85 < 7 |only if walking
Enter the building |goto  34.11,39.49 < 7 |walk
click Document Chest
|tip Inside the building.
collect Secret Note #2##12766 |q 5064/2 |goto 33.78,39.97
step
Leave the building |goto 34.11,39.48 < 7 |walk
Cross the hanging bridge |goto 35.71,39.40 < 7 |only if walking
Enter the building |goto 38.97,41.15 < 7 |walk
click Document Chest
|tip Inside the building.
collect Secret Note #3##12768 |q 5064/3 |goto 39.32,41.52
step
Leave the building |goto 38.97,41.15 < 7 |walk
Cross the hanging bridge |goto 38.32,40.38 < 7 |only if walking
Cross the hanging bridge |goto 33.26,36.30 < 7 |only if walking
click Document Chest
collect Secret Note #1##12765 |q 5064/1 |goto 31.80,32.59
step
Cross the hanging bridge |goto 32.36,33.46 < 7 |only if walking
Cross the hanging bridge |goto 34.21,35.80 < 7 |only if walking
Cross the hanging bridge |goto 35.65,30.98 < 7 |only if walking
Cross the hanging bridge |goto 37.62,31.50 < 7 |only if walking
kill Arnak Grimtotem##10896
|tip He walks around this area.
collect Arnak's Hoof##12884 |q 5147/1 |goto 38.08,26.85
step
talk Lakota Windsong##10646
|tip This is an escort quest.
|tip If she's not here, someone else may be escorting her.
|tip Wait until she respawns.
accept Free at Last##4904 |goto 37.99,26.59
step
Watch the dialogue
|tip Follow Lakota Windsong and protect her as she walks.
|tip Try to clear the path in front of her, as much as you can.
|tip You will be attacked by 2 enemies that spawn on each plateau as you walk.
|tip She eventually walks to this location.
Escort Lakota Windsong from the Darkcloud Pinnacle |q 4904/1 |goto 30.97,37.09
step
Follow the path |goto 32.22,35.15 < 20 |only if walking
click Incendia Agave+
|tip They look like yellow-brown spikey plants on the ground around the water, and underwater, around this area.
collect 10 Incendia Agave##12732 |q 5062/1 |goto 33.37,32.86
You can find more around: |notinsticky
[35.62,35.09]
[36.84,37.54]
step
Leave the building |goto Thunder Bluff 45.01,62.25 < 7 |walk
talk Magatha Grimtotem##4046
|tip Inside the tent.
turnin Sacred Fire##5062 |goto Thunder Bluff 69.86,30.92
accept Arikara##5088 |goto Thunder Bluff 69.86,30.92
step
talk Cliffwatcher Longhorn##10537
turnin Wanted - Arnak Grimtotem##5147 |goto Thousand Needles 45.65,50.80
turnin Grimtotem Spying##5064 |goto Thousand Needles 45.65,50.80
step
Enter the building |goto 45.94,51.07 < 7 |walk
talk Thalia Amberhide##10645
|tip Inside the building.
turnin Free at Last##4904 |goto 45.97,51.61
step
talk Innkeeper Abeqwa##11116
|tip Inside the building.
home Freewind Post |goto 46.07,51.51
step
Leave the building |goto 45.94,51.07 < 7 |walk
Ride the elevator down |goto 46.72,48.26 < 10 |c |q 5088
step
Kill enemies around this area
Reach Level 31 |ding 31 |goto 45.73,41.01
You can find more around [41.63,37.69]
step
Follow the road |goto 39.51,44.61 < 30 |only if walking
Continue following the road |goto 33.09,43.02 < 30 |only if walking
Follow the path up |goto 31.24,36.88 < 10 |only if walking
Cross the hanging bridge |goto 33.13,35.33 < 7 |only if walking
Cross the hanging bridge |goto 31.97,31.32 < 7 |only if walking
Cross the hanging bridge |goto 33.24,28.50 < 7 |only if walking
Cross the hanging bridge |goto 35.67,30.99 < 7 |only if walking
Cross the hanging bridge |goto 37.15,33.10 < 7 |only if walking
click Sacred Fire of Life
|tip Clear the area of enemies first.
Light the Sacred Fire of Life |q 5088/2 |goto 38.02,35.32
step
kill Arikara##10882
|tip It's elite, but pretty easy to kill.
|tip If you have trouble killing it, either try to get someone to help you, or skip the quest.
collect Arikara Serpent Skin##12925 |q 5088/1 |goto 38.29,35.54
step
Cross the hanging bridge |goto 37.72,35.00 < 7 |only if walking
Cross the hanging bridge |goto 36.91,31.77 < 7 |only if walking
Cross the hanging bridge |goto 34.54,30.84 < 7 |only if walking
Cross the hanging bridge |goto 32.31,28.64 < 7 |only if walking
Cross the hanging bridge |goto 32.90,32.59 < 7 |only if walking
Follow the path down |goto 33.13,35.52 < 10 |only if walking
Follow the road |goto 27.17,34.06 < 30 |only if walking
talk Motega Firemane##10428
turnin Arikara##5088 |goto 21.55,32.35
step
map Thousand Needles
path	follow loose;	loop;	ants curved;	dist 30
path	18.21,26.63		17.18,29.62		14.66,30.75		11.08,22.60
path	13.29,19.81		14.83,19.58		17.19,18.92		18.71,24.78
kill Steelsnap##4548
|tip He looks like a brown hyena that walks around this area with 2 purple hyena guards.
|tip If you need to, kite him away from his bodyguards, so you can fight him alone.
collect Steelsnap's Rib##5837 |q 1131/1
step
map Thousand Needles
path	follow loose;	loop;	ants curved;	dist 30
path	18.02,26.90		22.84,31.56		25.28,34.25		29.62,33.67
path	31.58,30.56		33.09,30.70		35.02,28.28		33.92,25.74
path	30.81,23.83		27.60,23.15		25.09,23.65		20.54,22.11
path	15.80,23.14		15.22,25.55
kill Galak Messenger##10617
|tip He looks like a black centaur that runs quickly around this area in a large path.
collect Assassination Note##12564 |q 4881 |future
step
use the Assassination Note##12564
accept Assassination Plot##4881
step
talk Kanati Greycloud##10638
turnin Assassination Plot##4881 |goto 21.26,32.07
accept Protect Kanati Greycloud##4966 |goto 21.26,32.07
|tip You will be attacked by a group of 3 enemies, so be ready.
step
Kill the enemies that attack
Protect Kanati Greycloud |q 4966/1 |goto 21.10,31.21
step
talk Kanati Greycloud##10638
turnin Protect Kanati Greycloud##4966 |goto 21.26,32.07
step
Follow the path up |goto 14.75,32.83 < 10 |only if walking
click Highperch Wyvern Egg+
|tip They look like large eggs with blue spots on them on the ground around this area.
collect 10 Highperch Wyvern Egg##12356 |q 4767/1 |goto 11.22,36.01
step
Follow the path up |goto 13.17,39.51 < 10 |only if walking
Follow the path |goto 16.49,41.53 < 15 |only if walking
talk Pao'ka Swiftmountain##10427
|tip This is an escort quest.
|tip If he's not here, someone else may be escorting him.
|tip Wait until he respawns.
accept Homeward Bound##4770 |goto 17.89,40.57
step
Watch the dialogue
|tip Follow Pao'ka Swiftmountain and protect him as he walks.
|tip Try to clear the path as he walks, as much as you can.
|tip A group of 3 wyverns will ambush you once you reach the wide open area, so be ready.
|tip He eventually walks to this location.
|tip If you find it too difficult, try to get someone to help you, or skip the quest.
Escort Pao'ka Swiftmountain to Safety |q 4770/1 |goto 15.16,32.67
step
talk Motega Firemane##10428
turnin Homeward Bound##4770 |goto 21.55,32.35
step
Leave the building |goto 45.94,51.06 < 7 |walk
talk Elu##10377
|tip He walks around this area.
turnin Wind Rider##4767 |goto Thousand Needles 44.93,48.93
step
talk Melor Stonehoof##3441
turnin Steelsnap##1131 |goto Thunder Bluff 61.53,80.90
accept Frostmaw##1136 |goto Thunder Bluff 61.53,80.90
step
Enter the building |goto Orgrimmar 54.01,68.87 < 7 |walk
talk Innkeeper Gryshka##6929
|tip Inside the building.
home Orgrimmar |goto Orgrimmar 54.10,68.41
step
talk Novice Thaivand##2429
accept Helcular's Revenge##552 |goto Hillsbrad Foothills 63.88,19.66
step
Follow the path |goto 54.91,29.45 < 30 |only if walking
Kill Yeti enemies around this area
|tip Inside and outside the cave.
collect Helcular's Rod##3708 |q 552/1 |goto 46.21,31.86
|tip This has a very low drop rate.
step
Follow the path |goto 53.95,30.25 < 30 |only if walking
talk Novice Thaivand##2429
|tip Leave the cave, if you went in there for the previous guide step.
turnin Helcular's Revenge##552 |goto 63.88,19.66
step
Enter the building |goto 62.91,20.56 < 7 |walk
talk Krusk##2229
|tip Inside the building.
accept Regthar Deathgate##1361 |goto 63.24,20.65
step
Leave the building |goto 62.91,20.56 < 7 |walk
Follow the road |goto 63.72,41.84 < 30 |only if walking
Enter Arathi Highlands |goto Hillsbrad Foothills 81.93,56.88 < 20 |only if walking
Follow the road |goto Arathi Highlands 26.25,48.73 < 30 |only if walking
Continue following the road |goto Arathi Highlands 51.14,59.65 < 30 |only if walking
Follow the path |goto Arathi Highlands 74.56,37.94 < 15 |only if walking
talk Gor'mul##2792
|tip He walks around this area.
accept Hammerfall##655 |goto Arathi Highlands 72.67,34.12
step
talk Tor'gan##2706
turnin Hammerfall##655 |goto 74.71,36.29
accept Raising Spirits##672 |goto 74.71,36.29
step
Follow the path |goto 74.56,37.95 < 15 |only if walking
kill Highland Strider##2559+
collect 10 Highland Raptor Eye##4512 |q 672/1 |goto 68.04,35.31
|tip These have a low drop rate.
You can find more around [60.44,43.32]
step
Follow the path |goto 74.59,37.95 < 15 |only if walking
talk Tor'gan##2706
turnin Raising Spirits##672 |goto 74.71,36.29
accept Raising Spirits##674 |goto 74.71,36.29
step
talk Gor'mul##2792
|tip He walks around this area.
turnin Raising Spirits##674 |goto 72.67,34.12
accept Raising Spirits##675 |goto 72.67,34.12
step
talk Tor'gan##2706
turnin Raising Spirits##675 |goto 74.71,36.29
step
Follow the path |goto 74.56,37.95 < 15 |only if walking
Kill enemies around this area
Reach Level 32 |ding 32 |goto 68.04,35.31
You can find more around [60.44,43.32]
step
Follow the path |goto 74.56,37.94 < 15 |only if walking
Run up the stairs |goto 73.49,34.08 < 7 |only if walking
talk Urda##2851
|tip She walks around this area.
fpath Hammerfall |goto 73.06,32.68
step
talk Thysta##1387
fpath Grom'gol |goto Stranglethorn Vale 32.54,29.35
step
Follow the path |goto 32.78,28.75 < 15 |only if walking
Follow the road |goto 38.47,23.16 < 30 |only if walking
Follow the path down |goto 35.22,14.66 < 20 |only if walking
talk Barnil Stonepot##716
accept Welcome to the Jungle##583 |goto 35.66,10.53
step
talk Hemet Nesingwary##715
turnin Welcome to the Jungle##583 |goto 35.66,10.81
accept Raptor Mastery##194 |goto 35.66,10.81
step
talk Ajeck Rouack##717
accept Tiger Mastery##185 |goto 35.61,10.62
step
talk Sir S. J. Erlgadin##718
accept Panther Mastery##190 |goto 35.55,10.55
step
Collect Green Hills of Stranglethorn Pages
|tip These can drop from Humanoid enemies in Stranglethorn Vale.
|tip Just keep any that you find while questing.
|tip You can sell any duplicates you find on the Auction House.
|tip You can buy any missing pages that you need from the Auction House, usually.
|tip Check the main Horde Auction House in a major city, as well as the Neutral Auction House in Booty Bay, later.
|tip If you manage to collect them all, accept the quest in this camp and complete it.
Click Here to Continue |confirm |q 338 |future
step
kill 10 Young Stranglethorn Tiger##681 |q 185/1 |goto 35.23,12.83
You can find more around: |notinsticky
[33.42,11.47]
[31.79,9.19]
step
talk Ajeck Rouack##717
turnin Tiger Mastery##185 |goto 35.61,10.62
accept Tiger Mastery##186 |goto 35.61,10.62
step
kill 10 Young Panther##683 |q 190/1 |goto 41.70,12.28
You can find more around: |notinsticky
[42.40,10.56]
[41.06,8.26]
step
Follow the path up |goto 43.88,14.22 < 20 |only if walking
kill 10 Stranglethorn Tiger##682 |q 186/1 |goto 45.28,14.27
You can find more around: |notinsticky
[47.77,13.18]
[46.73,16.86]
step
talk Ajeck Rouack##717
turnin Tiger Mastery##186 |goto 35.61,10.62
accept Tiger Mastery##187 |goto 35.61,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##190 |goto 35.55,10.55
accept Panther Mastery##191 |goto 35.55,10.55
step
Follow the path up |goto 30.79,8.27 < 20 |only if walking
kill 10 Panther##736 |q 191/1 |goto 30.02,10.56
You can find more around: |notinsticky
[28.35,12.13]
[28.55,16.11]
step
kill 10 Stranglethorn Raptor##685 |q 194/1 |goto 26.04,16.19
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##191 |goto 35.55,10.55
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##194 |goto 35.66,10.81
accept Raptor Mastery##195 |goto 35.66,10.81
step
talk Barnil Stonepot##716
accept Chapter I##339
|only if ((itemcount(2725) >= 1) and (itemcount(2728) >= 1) and (itemcount(2730) >= 1) and (itemcount(2732) >= 1) and (not completedq(339)))
step
talk Barnil Stonepot##716
turnin Chapter I##339
|only if ((itemcount(2725) >= 1) and (itemcount(2728) >= 1) and (itemcount(2730) >= 1) and (itemcount(2732) >= 1) and (not completedq(339)))
step
talk Barnil Stonepot##716
accept Chapter II##340
|only if ((itemcount(2734) >= 1) and (itemcount(2735) >= 1) and (itemcount(2738) >= 1) and (itemcount(2740) >= 1) and (not completedq(340)))
step
talk Barnil Stonepot##716
turnin Chapter II##340
|only if ((itemcount(2734) >= 1) and (itemcount(2735) >= 1) and (itemcount(2738) >= 1) and (itemcount(2740) >= 1) and (not completedq(340)))
step
talk Barnil Stonepot##716
accept Chapter III##341
|only if ((itemcount(2742) >= 1) and (itemcount(2744) >= 1) and (itemcount(2745) >= 1) and (itemcount(2748) >= 1) and (not completedq(341)))
step
talk Barnil Stonepot##716
turnin Chapter III##341
|only if ((itemcount(2742) >= 1) and (itemcount(2744) >= 1) and (itemcount(2745) >= 1) and (itemcount(2748) >= 1) and (not completedq(341)))
step
talk Barnil Stonepot##716
accept Chapter IV##342
|only if ((itemcount(2749) >= 1) and (itemcount(2750) >= 1) and (itemcount(2751) >= 1) and (not completedq(342)))
step
talk Barnil Stonepot##716
turnin Chapter IV##342
|only if ((itemcount(2749) >= 1) and (itemcount(2750) >= 1) and (itemcount(2751) >= 1) and (not completedq(342)))
step
talk Barnil Stonepot##716
turnin The Green Hills of Stranglethorn##338
|only if ((itemcount(2756) >= 1) and (itemcount(2757) >= 1) and (itemcount(2758) >= 1) and (itemcount(2759) >= 1) and (not completedq(338)))
step
talk Korran##3428
accept The Swarm Grows##1145 |goto The Barrens 51.07,29.63
step
Follow the road |goto 50.80,29.06 < 15 |only if walking
talk Regthar Deathgate##3389
|tip Upstairs inside the building.
turnin Regthar Deathgate##1361 |goto 45.34,28.41
accept The Kolkar of Desolace##1362 |goto 45.34,28.41
step
Follow the path |goto 50.82,29.07 < 15 |only if walking
Ride the elevator down |goto Thousand Needles 46.72,48.26 < 10 |only if walking
Follow the road |goto Thousand Needles 48.53,51.66 < 30 |only if walking
Follow the path |goto Thousand Needles 66.81,55.88 < 30 |only if walking
talk Kravel Koalbeard##4452
accept Rocket Car Parts##1110 |goto Thousand Needles 77.79,77.27
accept Wharfmaster Dizzywig##1111 |goto Thousand Needles 77.79,77.27
accept Hemet Nesingwary##5762 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
accept Salt Flat Venom##1104 |goto 78.06,77.13
step
talk Wizzle Brassbolts##4453
accept Hardened Shells##1105 |goto 78.14,77.12
step
talk Pozzik##4630
accept Load Lightening##1176 |goto 80.18,75.89
step
talk Trackmaster Zherin##4629
accept A Bump in the Road##1175 |goto 81.64,77.95
stickystart "Kill_Saltstone_Crystalhides"
stickystart "Collect_Hollow_Vulture_Bones"
stickystart "Collect_Hardened_Tortoise_Shells"
stickystart "Collect_Salty_Scorpid_Venom"
stickystart "Kill_Saltstone_Basilisks"
stickystart "Collect_Rocket_Car_Parts"
step
kill 6 Saltstone Gazer##4150 |q 1175/3 |goto 77.51,87.20
step
label "Kill_Saltstone_Crystalhides"
kill 10 Saltstone Crystalhide##4151 |q 1175/2 |goto 77.51,87.20
step
label "Collect_Hollow_Vulture_Bones"
Kill Salt Flats enemies around this area
|tip They look like vultures.
collect 10 Hollow Vulture Bone##5848 |q 1176/1 |goto 87.45,65.73
You can find more around: |notinsticky
[84.59,70.96]
[70.96,74.76]
[70.43,69.31]
[73.70,58.89]
[80.76,59.34]
step
label "Collect_Hardened_Tortoise_Shells"
Kill Sparkleshell enemies around this area
|tip They look like turtles.
collect 9 Hardened Tortoise Shell##5795 |q 1105/1 |goto 82.19,55.36
You can find more around: |notinsticky
[77.41,53.72]
[73.05,56.51]
[74.82,63.33]
step
label "Collect_Salty_Scorpid_Venom"
Kill Scorpid enemies around this area
|tip They look like scorpions.
collect 6 Salty Scorpid Venom##5794 |q 1104/1 |goto 71.67,73.16
You can find more around: |notinsticky
[74.16,56.27]
[78.83,52.96]
[84.63,62.92]
[87.30,69.38]
step
label "Kill_Saltstone_Basilisks"
kill 10 Saltstone Basilisk##4147 |q 1175/1 |goto 77.73,59.22
You can find more around: |notinsticky
[73.41,57.27]
[70.97,66.69]
[77.48,52.40]
step
label "Collect_Rocket_Car_Parts"
click Rocket Car Rubble##19868+
|tip They look like various machine parts scattered on the ground.
|tip You can find them all throughout the Shimmering Flats.
collect 30 Rocket Car Parts##5798 |q 1110/1 |goto 75.19,56.17
step
Kill enemies around this area
|tip All around the Shimmering Flats.
|tip Grinding the last couple of bars before turning in quests will allow you to get a large chunk of experience into the next level right away, when you turn in the quests.
Reach Level 33 |ding 33 |goto 75.19,56.17
step
talk Kravel Koalbeard##4452
turnin Rocket Car Parts##1110 |goto 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin Salt Flat Venom##1104 |goto 78.06,77.13
step
talk Wizzle Brassbolts##4453
turnin Hardened Shells##1105 |goto 78.14,77.12
step
talk Fizzle Brassbolts##4454
accept Martek the Exiled##1106 |goto 78.06,77.13
step
talk Pozzik##4630
turnin Load Lightening##1176 |goto 80.18,75.88
accept Goblin Sponsorship##1178 |goto 80.18,75.88
step
talk Trackmaster Zherin##4629
turnin A Bump in the Road##1175 |goto 81.63,77.95
step
Follow the path up |goto 74.20,93.41 < 15 |only if walking
Continue following the path |goto Tanaris 51.41,22.34 < 15 |only if walking
talk Bulkrek Ragefist##7824
fpath Gadgetzan |goto Tanaris 51.60,25.44
step
talk Cliffwatcher Longhorn##10537
accept Family Tree##5361 |goto Thousand Needles 45.65,50.80
step
Enter the building |goto Orgrimmar 53.62,64.65 < 7 |walk
talk Auctioneer Thathung##8673
collect 2 Elixir of Water Breathing##5996 |goto 55.68,62.83 |q 1482 |future
|tip Buy them from the Auction House.
|tip These are needed for underwater quests in Desolace soon.
|only if not Undead
step
talk Belgrom Rockmaul##4485
turnin The Swarm Grows##1145 |goto 75.23,34.23
accept The Swarm Grows##1146 |goto 75.23,34.23
step
talk Craven Drok##5639
|tip He walks around this area inside the Cleft of Shadow.
accept Alliance Relations##1431 |goto 46.76,50.43
step
Enter the building |goto 22.28,53.78 < 7 |walk
talk Keldran##5640
|tip He walks around inside the building.
turnin Alliance Relations##1431 |goto 22.56,52.63
accept Alliance Relations##1432 |goto 22.56,52.63
step
Leave the building |goto 22.29,53.84 < 7 |walk
Follow the path up |goto Stonetalon Mountains 44.63,61.97 < 15 |only if walking
Follow the path down |goto Stonetalon Mountains 43.52,65.44 < 15 |only if walking
Continue down the path |goto Stonetalon Mountains 41.22,70.58 < 15 |only if walking
Follow the path |goto Stonetalon Mountains 37.82,67.94 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 30.23,75.72 < 15 |only if walking
Follow the road |goto Desolace 53.38,6.02 < 30 |only if walking
talk Bibbly F'utzbuckle##11438
|tip He walks around this area.
accept Bone Collector##5501 |goto Desolace 62.33,38.98
step
Follow the road |goto 67.12,38.89 < 30 |only if walking
talk Smeed Scrabblescrew##11596
accept Kodo Roundup##5561 |goto 60.86,61.86
step
use the Kodo Kombobulator##13892
|tip Use it on Kodo enemies around this area.
|tip You can find more all around this bone graveyard area.
Tame #5# Kodos |q 5561/1 |goto 54.45,63.19
|tip You must bring them back to Smeed Scrabblescrew to tame them.
|tip Talk to the kodos after you bring them to Smeed Scrabblescrew.
Bring the Kodos back to [60.73,61.96]
step
talk Smeed Scrabblescrew##11596
turnin Kodo Roundup##5561 |goto 60.86,61.86
step
Follow the path up |goto 57.60,56.38 < 20 |only if walking
talk Felgur Twocuts##5395
turnin The Kolkar of Desolace##1362 |goto 56.20,59.57
accept Khan Dez'hepah##1365 |goto 56.20,59.57
step
talk Gurda Wildmane##5412
accept Gelkis Alliance##1368 |goto 56.29,59.68
step
talk Nataka Longhorn##11259
turnin Family Tree##5361 |goto 55.41,55.81
accept Catch of the Day##5386 |goto 55.41,55.81
step
Cross the bridge |goto 54.70,55.06 < 7 |only if walking
talk Takata Steelblade##5641
turnin Alliance Relations##1432 |goto 52.57,54.39
accept Alliance Relations##1433 |goto 52.57,54.39
accept Befouled by Satyr##1434 |goto 52.57,54.39
step
talk Maurin Bonesplitter##4498
turnin Alliance Relations##1433 |goto 52.24,53.44
accept The Burning of Spirits##1435 |goto 52.24,53.44
step
Follow the road |goto 49.72,45.57 < 30 |only if walking
Enter the building |goto 73.24,42.41 < 7 |walk
kill Khan Dez'hepah##5600
|tip Inside the building.
collect Khan Dez'hepah's Head##6066 |q 1365/1 |goto 73.38,41.62
He can also spawn in the tent at [74.68,48.84]
step
Follow the road |goto 67.81,51.41 < 30 |only if walking
Kill Magram enemies around this area
|tip Press "U" to open your reputation list.
|tip Select the "Gelkis Clan Centaur" reputation, and select "Show as Experience Bar".
|tip This will show you a progress bar for this reputation, similar to your experience bar.
|tip You will have to kill at least one enemy before you can see the reputation.
Reach Friendly Reputation with the Gelkis Clan Centaur |condition rep('Gelkis Clan Centaur') >= Friendly |goto 70.42,73.40 |q 1368
step
Kill enemies around this area
Reach Level 34 |ding 34 |goto 70.42,73.40
step
Follow the path up |goto 57.70,56.35 < 15 |only if walking
talk Felgur Twocuts##5395
turnin Khan Dez'hepah##1365 |goto 56.20,59.56
accept Centaur Bounty##1366 |goto 56.20,59.56
step
Follow the road |goto 50.33,75.54 < 30 |only if walking
talk Uthek the Wise##5397
turnin Gelkis Alliance##1368 |goto 36.23,79.25
accept Stealing Supplies##1370 |goto 36.23,79.25
step
Follow the path up |goto 26.27,74.83 < 15 |only if walking
talk Roon Wildmane##11877
accept Hunting in Stranglethorn##5763 |goto 25.05,72.28
step
talk Taiga Wisemane##11624
accept Hand of Iruxos##5381 |goto 25.81,68.22
step
Enter the building |goto 24.54,68.64 < 7 |walk
talk Innkeeper Sikewa##11106
|tip Inside the building.
home Shadowprey Village |goto 24.09,68.22
step
talk Drulzegar Skraghook##12340
accept Other Fish to Fry##6143 |goto 23.32,72.87
step
talk Mai'Lahii##12031
|tip Inside the building.
accept Clam Bait##6142 |goto 22.65,71.97
step
talk Thalon##6726
fpath Shadowprey Village |goto 21.60,74.13
step
use an Elixir of Water Breathing##5996
|tip If you don't have any, swim next to the bubbling gray rock mounds on the ground underwater around this area.
|tip They will allow you to breath underwater.
click Shellfish Trap+
|tip They look like yellow wooden cages on the ground underwater around this area.
|tip Some of them may be empty, or cause and enemy to appear.
|tip They respawn pretty quickly, and may contain Shellfish again.
collect 10 Shellfish##13545 |goto 19.80,76.23 |q 5386
step
talk Jinar'Zillen##11317
|tip On the dock.
|tip Turn in the "Fish in a Bucket" quest twice.
collect 2 Bloodbelly Fish##13546 |q 5386/1 |goto 22.45,73.12
|tip Be careful not to accidentally sell these to a vendor.
|tip You can destroy any extra "Shellfish" items you may have, after you collect the "Bloodbelly Fish" items.
step
Swim along the coast |goto 22.00,69.48 < 30 |only if walking
Continue swimming along the coast |goto 28.45,37.26 < 30 |only if walking
click Rackmore's Log
accept Claim Rackmore's Treasure!##6161 |goto 36.07,30.41
step
Follow the path |goto 41.59,34.00 < 15 |only if walking
talk Azore Aldamort##11863
accept Sceptre of Light##5741 |goto 38.88,27.17
stickystart "Collect_Infused_Burning_Gems"
stickystart "Collect_Flayed_Demon_Skin"
step
Follow the path up |goto 55.56,32.51 < 30 |only if walking
Follow the path |goto 56.06,29.54 < 15 |only if walking
kill Burning Blade Seer##13019
|tip At the top of the tower.
collect Sceptre of Light##15750 |q 5741/1 |goto 55.17,30.15
step
Enter the building |goto 55.35,27.54 < 10 |walk
click Hand of Iruxos Crystal
|tip Inside the building.
|tip Kill all of the enemies in this room before clicking it.
|tip A level 37 enemy will appear, so be prepared to fight.
kill Demon Spirit##11876
collect Demon Box##13542 |q 5381/1 |goto 54.97,26.65
step
Leave the building |goto 55.35,27.54 < 10 |c |q 1435
step
label "Collect_Infused_Burning_Gems"
use the Burning Gem##6436
|tip Use it on Burning Blade enemies around this area when they are low health.
collect 15 Infused Burning Gem##6435 |q 1435/1 |goto 55.20,28.90
step
label "Collect_Flayed_Demon_Skin"
Kill Burning Blade enemies around this area
collect Flayed Demon Skin##20310 |goto 56.06,29.54 |q 1480 |future
|tip This has a low drop rate.
step
use the Flayed Demon Skin##20310
accept The Corrupter##1480
step
Follow the path |goto 56.07,29.58 < 15 |only if walking
Follow the path up |goto 57.53,56.38 < 15 |only if walking
talk Nataka Longhorn##11259
turnin Catch of the Day##5386 |goto 55.42,55.81
step
Cross the bridge |goto 54.72,55.08 < 10 |only if walking
talk Maurin Bonesplitter##4498
turnin The Burning of Spirits##1435 |goto 52.24,53.44
turnin The Corrupter##1480 |goto 52.24,53.44
accept The Corrupter##1481 |goto 52.24,53.44
stickystart "Kill_Hatefury_Rogues"
stickystart "Kill_Hatefury_Felsworns"
stickystart "Kill_Hatefury_Betrayers"
stickystart "Kill_Hatefury_Hellcallers"
step
Follow the road |goto 49.72,45.57 < 30 |only if walking
kill Hatefury Shadowstalker##4674+
collect Shadowstalker Scalp##6441 |q 1481/1 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
step
label "Kill_Hatefury_Rogues"
kill 7 Hatefury Rogue##4670 |q 1434/1 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
step
label "Kill_Hatefury_Felsworns"
kill 7 Hatefury Felsworn##4672 |q 1434/2 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
step
label "Kill_Hatefury_Betrayers"
kill 7 Hatefury Betrayer##4673 |q 1434/3 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
step
label "Kill_Hatefury_Hellcallers"
kill 7 Hatefury Hellcaller##4675 |q 1434/4 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
step
Kill enemies around this area
|tip This is a longer grind.
|tip You could run a dungeon instead, if you want.
|tip You are about to have to kill higher level nagas.
|tip Most classes will find it much easier to do if they are at least level 35.
Reach Level 35 |ding 35 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (35-40)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (40-45)",
startlevel=35,
endlevel=40,
},[[
step
Follow the path up |goto Desolace 57.60,56.33 < 15 |only if walking
Cross the bridge |goto Desolace 54.73,55.09 < 10 |only if walking
talk Takata Steelblade##5641
turnin Befouled by Satyr##1434 |goto Desolace 52.57,54.38
accept Alliance Relations##1436 |goto Desolace 52.57,54.38
step
talk Maurin Bonesplitter##4498
turnin The Corrupter##1481 |goto 52.25,53.45
accept The Corrupter##1482 |goto 52.25,53.45
step
Follow the path |goto 48.97,40.77 < 40 |only if walking
Continue following the path |goto 42.14,33.16 < 30 |only if walking
talk Azore Aldamort##11863
turnin Sceptre of Light##5741 |goto 38.89,27.17
accept Book of the Ancients##6027 |goto 38.89,27.17
stickystart "Collect_Softshelled_Clam_Meats"
step
use an Elixir of Water Breathing##5996
|tip If you don't have any, swim next to the bubbling gray rock mounds on the ground underwater around this area.
|tip They will allow you to breath underwater.
Kill Drysnap enemies around this area
|tip They look like lobster underwater around this area.
collect Rackmore's Silver Key##15878 |q 6161/1 |goto 32.78,31.37
|tip This has a low drop rate.
stickystart "Collect_Rackmores_Golden_Key"
stickystart "Kill_Slitherblade_Nagas"
stickystart "Kill_Slitherblade_Sorceresses"
step
label "Collect_Softshelled_Clam_Meats"
click Giant Softshell Clam+
|tip They look like large white clam shells on the ground underwater around this area.
kill Enraged Reef Crawler##12347+
|tip They look like crabs underwater around this area.
collect Soft-shelled Clam##15874 |n
use the Soft-shelled Clam##15874+
collect 10 Soft-shelled Clam Meat##15924 |q 6142/1 |goto 33.70,27.83
stickystart "Collect_Oracle_Crystal"
stickystart "Kill_Slitherblade_Myrmidons"
step
label "Collect_Rackmores_Golden_Key"
Kill Slitherblade enemies around this area
|tip Underwater.
collect Rackmore's Golden Key##15881 |q 6161/2 |goto 35.20,24.86
step
click Rackmore's Chest
|tip On the ground at the base of the tree.
turnin Claim Rackmore's Treasure!##6161 |goto 30.00,8.70
step
click Serpent Statue
kill Lord Kragaru##12369
collect Book of the Ancients##15803 |q 6027/1 |goto 28.19,6.62
step
label "Collect_Oracle_Crystal"
kill Slitherblade Oracle##4718+
|tip Underwater and on the islands around this area.
collect Oracle Crystal##6442 |q 1482/1 |goto 28.19,6.43
You can find more around: |notinsticky
[33.97,10.16]
[31.74,15.64]
[32.93,21.73]
step
label "Kill_Slitherblade_Myrmidons"
kill 7 Slitherblade Myrmidon##4714 |q 6143/1 |goto 32.12,18.59
|tip Underwater and on the islands around this area.
step
label "Kill_Slitherblade_Nagas"
kill 7 Slitherblade Naga##4711 |q 6143/2 |goto 35.20,24.86
|tip Underwater and on the islands around this area.
step
label "Kill_Slitherblade_Sorceresses"
kill 5 Slitherblade Sorceress##4712 |q 6143/3 |goto 35.20,24.86
|tip Underwater and on the islands around this area.
step
Follow the path up |goto 40.99,28.91 < 15 |only if walking
talk Azore Aldamort##11863
turnin Book of the Ancients##6027 |goto 38.89,27.17
step
Follow the path |goto 43.25,30.42 < 40 |only if walking
Follow the path up |goto 55.89,53.49 < 10 |only if walking
Cross the bridge |goto 54.72,55.08 < 10 |only if walking
talk Maurin Bonesplitter##4498
turnin The Corrupter##1482 |goto 52.25,53.44
step
Watch the dialogue
talk Maurin Bonesplitter##4498
accept The Corrupter##1484 |goto 52.25,53.44
step
talk Takata Steelblade##5641
turnin The Corrupter##1484 |goto 52.57,54.38
step
click Kodo Bones
|tip They look like large white horned animal skulls on the ground around this area.
|tip If a Kodo Apparition appears and attacks you, run away until it leaves you alone, if you can't kill them.
collect 10 Kodo Bone##13703 |q 5501/1 |goto 51.31,58.04
stickystart "Collect_Centaur_Ears"
step
Follow the path |goto 55.75,62.38 < 30 |only if walking
Follow the path |goto 67.13,66.06 < 20 |only if walking
click Sack of Meat+
|tip They look like tan leather bags on the ground near the buildings around this area.
|tip Not all of the tan bags you see will be clickable.
collect 6 Crudely Dried Meat##6069 |q 1370/1 |goto 70.90,75.47
step
label "Collect_Centaur_Ears"
Kill Magram enemies around this area
collect 15 Centaur Ear##6067 |q 1366/1 |goto 70.30,73.77
step
Follow the path up |goto 57.68,56.38 < 15 |only if walking
talk Felgur Twocuts##5395
turnin Centaur Bounty##1366 |goto 56.19,59.56
step
talk Bibbly F'utzbuckle##11438
|tip He walks around this area.
turnin Bone Collector##5501 |goto 62.33,38.98
step
Leave the building |goto 24.54,68.64 < 7 |walk
talk Taiga Wisemane##11624
turnin Hand of Iruxos##5381 |goto 25.81,68.22
step
talk Drulzegar Skraghook##12340
turnin Other Fish to Fry##6143 |goto 23.32,72.87
step
talk Mai'Lahii##12031
|tip Inside the building.
turnin Clam Bait##6142 |goto 22.64,71.97
step
Follow the path up |goto 27.16,75.91 < 30 |only if walking
talk Uthek the Wise##5397
turnin Stealing Supplies##1370 |goto 36.23,79.25
accept Ongeku##1373 |goto 36.23,79.25
step
Follow the path |goto 26.58,75.48 < 30 |only if walking
Follow the path |goto 22.83,72.57 < 15|only if walking
Follow the road |goto The Barrens 46.86,65.67 < 30 |only if walking
Enter Dustwallow Marsh |goto The Barrens 49.94,78.42 < 30 |only if walking
click Suspicious Hoofprint
accept Suspicious Hoofprints##1268 |goto Dustwallow Marsh 29.70,47.63
step
click Theramore Guard Badge
|tip It looks like a tiny metal object on the floor.
accept Lieutenant Paval Reethe##1269 |goto 29.83,48.24
step
click Black Shield
accept The Black Shield##1251 |goto 29.63,48.59
step
talk Krog##4926
turnin Suspicious Hoofprints##1268 |goto 36.42,31.88
turnin Lieutenant Paval Reethe##1269 |goto 36.42,31.88
turnin The Black Shield##1251 |goto 36.42,31.88
accept The Black Shield##1321 |goto 36.42,31.88
step
talk Do'gol##5087
turnin The Black Shield##1321 |goto 36.53,30.80
step
talk Shardi##11899
fpath Brackenwall Village |goto 35.56,31.88
step
Kill enemies around this area
Reach Level 36 |ding 36 |goto 37.81,26.64
step
Enter the building |goto The Barrens 62.89,36.52 < 7 |walk
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Goblin Sponsorship##1178 |goto The Barrens 62.68,36.23
accept Goblin Sponsorship##1180 |goto The Barrens 62.68,36.23
step
Leave the building |goto 62.90,36.53 < 7 |walk
talk Wharfmaster Dizzywig##3453
turnin Wharfmaster Dizzywig##1111 |goto 63.35,38.45
accept Parts for Kravel##1112 |goto 63.35,38.45
step
talk Wharfmaster Lozgil##4631
turnin Goblin Sponsorship##1180 |goto Stranglethorn Vale 26.34,73.56
accept Goblin Sponsorship##1181 |goto Stranglethorn Vale 26.34,73.56
step
Follow the path up |goto 27.85,76.74 < 7 |only if walking
Cross the bridge |goto 28.15,76.52 < 7 |only if walking
Enter the building |goto 28.21,77.33 < 5 |walk
talk Drizzlik##2495
|tip Inside the building.
accept Supply and Demand##575 |goto 28.29,77.59
step
Leave the building |goto 28.21,77.33 < 5 |walk
Enter the building |goto 27.08,77.62 < 5 |walk
talk Crank Fizzlebub##2498
|tip Inside the building.
accept Singing Blue Shards##605 |goto 27.12,77.21
step
talk Innkeeper Skindle##6807
|tip Inside the building.
home Booty Bay |goto 27.04,77.31
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
accept Investigate the Camp##201 |goto 26.95,77.21
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
accept Bloodscalp Ears##189 |goto 27.00,77.12
accept Hostile Takeover##213 |goto 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
turnin Goblin Sponsorship##1181 |goto 27.23,76.87
accept Goblin Sponsorship##1182 |goto 27.23,76.87
step
talk Gringer##2858
|tip Upstairs on the balcony of the building.
fpath Booty Bay |goto 26.87,77.10
step
talk Commander Aggro'gosh##2464
|tip He walks around this area.
accept The Defense of Grom'gol##568 |goto 32.17,28.90
step
talk Far Seer Mok'thardin##2465
accept Mok'thardin's Enchantment##570 |goto 32.12,29.24
step
talk Nimboya##2497
accept Hunt for Yenniku##581 |goto 32.16,27.73
step
talk Kin'weelay##2519
accept Bloody Bone Necklaces##596 |goto 32.27,27.71
stickystart "Collect_Bloodscap_Tusks"
stickystart "Collect_Bloodscalp_Ears"
stickystart "Collect_Bloody_Bone_Necklaces"
step
Follow the path |goto 32.07,27.30 < 15 |only if walking
Follow the path up |goto 26.92,19.17 < 15 |only if walking
kill Crystal Spine Basilisk##689+
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto 27.06,18.51
You can find more around [25.11,17.42]
step
label "Collect_Bloodscap_Tusks"
Kill Bloodscalp enemies around this area
|tip You can find a few more along the path in the outskirts circling this camp.
collect 9 Bloodscalp Tusk##3901 |q 581/1 |goto 29.36,19.97
You can find more around [33.85,15.53]
step
label "Collect_Bloodscalp_Ears"
Kill Bloodscalp enemies around this area
|tip You can find a few more along the path in the outskirts circling this camp.
collect 15 Bloodscalp Ear##1519 |q 189/1 |goto 29.36,19.97
You can find more around [33.85,15.53]
step
label "Collect_Bloody_Bone_Necklaces"
Kill Bloodscalp enemies around this area
|tip You can find a few more along the path in the outskirts circling this camp.
collect 25 Bloody Bone Necklace##3915 |q 596/1 |goto 29.36,19.97
|tip These have a low drop rate.
You can find more around [33.85,15.53]
step
kill 10 Elder Stranglethorn Tiger##1085 |q 187/1 |goto 33.27,18.77
You can find more around [31.47,16.21]
stickystart "Kill_Lashtail_Raptors"
step
kill 10 Lashtail Raptor##686 |q 195/1 |goto 30.50,23.96
You can find more around: |notinsticky
[32.63,23.93]
[35.83,25.97]
[38.79,25.47]
step
label "Kill_Lashtail_Raptors"
kill 15 Lashtail Raptor##686 |q 568/1 |goto 30.50,23.96
You can find more around: |notinsticky
[32.63,23.93]
[35.83,25.97]
[38.79,25.47]
step
talk Commander Aggro'gosh##2464
|tip He walks around this area.
turnin The Defense of Grom'gol##568 |goto 32.17,28.91
accept The Defense of Grom'gol##569 |goto 32.17,28.91
step
talk Nimboya##2497
turnin Hunt for Yenniku##581 |goto 32.16,27.72
accept Headhunting##582 |goto 32.16,27.72
step
talk Kin'weelay##2519
turnin Bloody Bone Necklaces##596 |goto 32.27,27.70
step
Follow the path |goto 32.06,27.29 < 15 |only if walking
Continue following the path |goto 22.62,17.43 < 30 |only if walking
kill Bloodscalp Headhunter##671+
collect 20 Shrunken Head##1532 |goto 20.29,12.82 |q 582
You can find more: |notinsticky
Up the path that starts at [21.42,10.11]
Up the path that starts at [23.81,10.66]
step
Locate the Hunters' Camp |q 201/1 |goto 35.55,10.55
step
talk Sir S. J. Erlgadin##718
accept Panther Mastery##192 |goto 35.55,10.55
step
talk Ajeck Rouack##717
turnin Tiger Mastery##187 |goto 35.62,10.62
accept Tiger Mastery##188 |goto 35.62,10.62
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##195 |goto 35.66,10.81
accept Raptor Mastery##196 |goto 35.66,10.81
turnin Hemet Nesingwary##5762 |goto 35.66,10.81
turnin Hunting in Stranglethorn##5763 |goto 35.66,10.81
step
Follow the path up |goto 31.81,16.83 < 10 |only if walking
kill Sin'Dall##729
|tip He looks like an orange tiger that walks around this area.
|tip He's usually on top of this hill, though.
collect Paw of Sin'Dall##3879 |q 188/1 |goto 32.21,17.39
step
talk Ajeck Rouack##717
turnin Tiger Mastery##188 |goto 35.62,10.62
step
kill River Crocolisk##1150+
|tip Along the water around this area.
collect 2 Large River Crocolisk Skin##4053 |q 575/1 |goto 33.45,8.28
You can find more around: |notinsticky
[37.63,9.93]
[40.24,13.68]
stickystart "Collect_Tumbled_Crystals"
stickystart "Reach_Level_38"
step
Follow the path up |goto 42.25,18.10 < 10 |only if walking
kill Foreman Cozzle##4723
|tip Inside the building at the top of the platform.
collect Cozzle's Key##5851 |goto 42.65,18.35 |q 1182
step
Enter the building |goto 43.45,20.36 < 7 |walk
click Cozzle's Footlocker
|tip Inside the building.
collect Fuel Regulator Blueprints##5852 |q 1182/1 |goto 43.34,20.34
step
label "Collect_Tumbled_Crystals"
Leave the building |goto 43.45,20.36 < 7 |walk
kill Venture Co. Geologist##1096+
collect 8 Tumbled Crystal##4106 |q 213/1 |goto 44.63,21.45
step
label "Reach_Level_37"
Kill enemies around this area
Reach Level 37 |ding 37 |goto 44.63,21.45
stickystart "Collect_Shadowmaw_Claws"
stickystart "Kill_Shadowmaw_Panthers"
step
Follow the path up |goto 46.93,22.91 < 15 |only if walking
kill Stranglethorn Tigress##772+
|tip They share spawn points with Shadowmaw Panthers, so kill those too, to get more Stranglethorn Tigresses to spawn.
|tip Be careful to avoid the level 40 elite non-stealthed black panther, Bhag'thera, if you see him.
collect Pristine Tigress Fang##3839|q 570/2 |goto 49.23,22.66
|tip This has a low drop rate.
You can find more around [46.42,27.34]
step
label "Collect_Shadowmaw_Claws"
kill Shadowmaw Panther##684+
|tip They are stealthed around this area.
|tip They share spawn points with Stranglethorn Tigresses, so kill those too, to get more Shadowmaw Panthers to spawn.
|tip Be careful to avoid the level 40 elite non-stealthed black panther, Bhag'thera, if you see him.
collect 8 Shadowmaw Claw##3838 |q 570/1 |goto 49.23,22.66
You can find more around [46.42,27.34]
step
label "Kill_Shadowmaw_Panthers"
kill 10 Shadowmaw Panther##684 |q 192/1 |goto 49.23,22.66
|tip They are stealthed around this area.
You can find more around [46.42,27.34]
stickystart "Kill_Moshogg_Witch_Doctors"
step
kill 10 Mosh'Ogg Brute##1142 |q 569/1 |goto 37.40,31.30
step
label "Kill_Moshogg_Witch_Doctors"
kill 5 Mosh'Ogg Witch Doctor##1144 |q 569/2 |goto 37.40,31.30
step
Follow the road |goto 38.50,23.16 < 30 |only if walking
Follow the path down |goto 35.19,14.63 < 30 |only if walking
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##192 |goto 35.56,10.55
step
talk Crank Fizzlebub##2498
|tip Inside the building.
turnin Singing Blue Shards##605 |goto 27.12,77.21
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
turnin Bloodscalp Ears##189 |goto 27.00,77.13
turnin Hostile Takeover##213 |goto 27.00,77.13
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
turnin Investigate the Camp##201 |goto 26.94,77.21
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
turnin Goblin Sponsorship##1182 |goto 27.23,76.87
accept Goblin Sponsorship##1183 |goto 27.23,76.87
step
Cross the bridge |goto 28.15,76.52 < 7 |only if walking
Enter the building |goto 28.21,77.33 < 5 |walk
talk Drizzlik##2495
|tip Inside the building.
turnin Supply and Demand##575 |goto 28.29,77.59
accept Some Assembly Required##577 |goto 28.29,77.59
step
talk Commander Aggro'gosh##2464
|tip He walks around this area.
turnin The Defense of Grom'gol##569 |goto 32.17,28.90
step
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##570 |goto 32.12,29.24
step
talk Nimboya##2497
turnin Headhunting##582 |goto 32.16,27.73
step
Watch the dialogue
talk Nimboya##2497
accept Trollbane##638 |goto 32.16,27.73
step
talk Genavie Callow##4486
accept To Steal From Thieves##1164 |goto Undercity 63.83,49.45
step
talk Auctioneer Naxxremis##15683
|tip Buy these items from the Auction House.
collect Moonsteel Broadsword##3853 |goto 64.39,35.82 |q 1203 |future
collect 2 Elixir of Water Breathing##5996 |goto 64.39,35.82 |q 629 |future
step
Enter the building |goto Hillsbrad Foothills 61.58,20.61 < 7 |walk
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
accept Prison Break In##544 |goto Hillsbrad Foothills 61.60,20.84
step
talk Keeper Bel'varil##2437
accept Stone Tokens##556 |goto 61.50,20.93
step
Leave the building |goto 61.58,20.61 < 7 |walk
talk Tallow##2770
accept The Hammer May Fall##676 |goto 61.87,19.58
step
Enter the building |goto 62.51,19.62 < 7 |walk
talk Innkeeper Shay##2388
|tip Inside the building.
buy Southshore Stout##3703 |goto 62.78,19.03 |q 535 |future
step
Leave the building |goto 62.51,19.62 < 7 |walk
Enter the building |goto 62.91,20.56 < 7 |walk
talk Krusk##2229
|tip Inside the building.
accept Infiltration##533 |goto 63.23,20.66
step
Leave the building |goto 62.91,20.56 < 7 |walk
Follow the road |goto 55.70,14.65 < 30 |only if walking
Follow the path up |goto Alterac Mountains 53.13,64.92 < 15 |only if walking
talk Henchman Valik##2333
accept Valik##535 |goto Alterac Mountains 57.17,69.51
step
talk Henchman Valik##2333
turnin Valik##535 |goto 57.17,69.51
collect Syndicate Missive##3601 |q 533/1 |goto 57.17,69.51
step
Follow the path up |goto 49.43,69.37 < 15 |only if walking
Kill Mountain Lion enemies around this area
collect Fresh Carcass##5810 |goto 47.09,77.02 |q 1136
You can find more around [39.03,87.28]
step
Follow the path |goto 41.79,77.11 < 20 |only if walking
Enter the cave |goto 37.55,68.05 < 15 |walk
use the Fresh Carcass##5810
|tip Inside the cave.
kill Frostmaw##4504
|tip He walks to the entrance of the cave.
collect Frostmaw's Mane##5811 |q 1136/1 |goto 37.53,66.33
stickystart "Collect_Worn_Stone_Tokens"
step
Leave the cave |goto 37.50,68.17 < 15 |walk
Follow the path |goto 20.95,84.22 < 10 |only if walking
kill Ricter##2411
|tip He walks around this area.
collect Bloodstone Marble##3689 |q 544/2 |goto 20.20,84.08
step
Enter the building |goto 20.46,86.09 < 7 |walk
kill Alina##2412
|tip She walks around inside the building.
collect Bloodstone Shard##3690 |q 544/3 |goto 20.35,86.35
step
kill Dermot##2413
|tip He walks around inside the building.
collect Bloodstone Wedge##3691 |q 544/1 |goto 20.01,86.13
step
Leave the building |goto 20.45,86.10 < 7 |walk
Follow the path |goto 20.95,84.22 < 10 |only if walking
Enter the building |goto 18.65,84.41 < 7 |walk
kill Kegan Darkmar##2414
|tip Upstairs inside the building.
collect Bloodstone Oval##3688 |q 544/4 |goto 17.78,83.20
step
label "Collect_Worn_Stone_Tokens"
Leave the building |goto 18.67,84.42 < 7 |walk
Kill Dalaran enemies around this area
|tip They can also be in the buildings around this area.
collect 10 Worn Stone Token##3714 |q 556/1 |goto 19.33,82.59
You can find more around [16.58,76.69]
step
Follow the path up |goto 25.96,81.99 < 30 |only if walking
Follow the path |goto 31.10,80.00 < 20 |only if walking
Avoid the Alliance camp |goto 40.82,85.03 < 20 |only if walking
Follow the path up |goto 43.26,77.94 < 20 |only if walking
Enter the building |goto Hillsbrad Foothills 61.58,20.61 < 7 |walk
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
turnin Prison Break In##544 |goto Hillsbrad Foothills 61.60,20.84
accept Dalaran Patrols##545 |goto Hillsbrad Foothills 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
turnin Stone Tokens##556 |goto 61.50,20.94
accept Bracers of Binding##557 |goto 61.50,20.94
step
Leave the building |goto 61.58,20.61 < 7 |walk
Enter the building |goto 62.52,19.60 < 7 |walk
talk Innkeeper Shay##2388
home Tarren Mill |goto 62.77,19.01
step
Leave the building |goto 62.52,19.60 < 7 |walk
Enter the building |goto 62.90,20.56 < 7 |walk
talk Krusk##2229
|tip Inside the building.
turnin Infiltration##533 |goto 63.23,20.66
stickystart "Kill_Dalaran_Summoners"
stickystart "Kill_Elemental_Slaves"
step
Leave the building |goto 62.90,20.56 < 7 |walk
Follow the path up |goto Alterac Mountains 49.47,69.23 < 20 |only if walking
Avoid the Alliance camp |goto 41.67,83.29 < 20 |only if walking
Follow the path |goto Alterac Mountains 36.15,84.32 < 20 |only if walking
kill Elemental Slave##2359+
collect 4 Bracers of Earth Binding##3715 |q 557/1 |goto Alterac Mountains 15.84,77.20
|tip These have a low drop rate.
You can find more around [Alterac Mountains 22.02,62.28]
step
label "Kill_Dalaran_Summoners"
kill 6 Dalaran Summoner##2358 |q 545/1 |goto 15.84,77.20
You can find more around [22.02,62.28]
step
label "Kill_Elemental_Slaves"
kill 12 Elemental Slave##2359 |q 545/2 |goto 15.84,77.20
You can find more around [22.02,62.28]
step
Leave the building |goto Hillsbrad Foothills 62.52,19.60 < 7 |walk
Enter the building |goto Hillsbrad Foothills 61.58,20.61 < 7 |walk
talk Magus Wordeen Voidglare##2410
|tip Inside the building.
turnin Dalaran Patrols##545 |goto Hillsbrad Foothills 61.60,20.84
step
talk Keeper Bel'varil##2437
|tip Inside the building.
turnin Bracers of Binding##557 |goto 61.50,20.94
step
Leave the building |goto 61.58,20.61 < 7 |walk
Enter the building |goto Arathi Highlands 73.79,33.00 < 7 |walk
talk Innkeeper Adegwa##9501
|tip Inside the building.
home Hammerfall |goto Arathi Highlands 73.84,32.47
step
Leave the building |goto 73.79,32.98 < 7 |walk
talk Zengu##2703
turnin Trollbane##638 |goto 73.80,33.95
step
talk Tor'gan##2706
accept Foul Magics##671 |goto 74.71,36.29
accept Guile of the Raptor##701 |goto 74.71,36.29
step
Follow the path |goto 74.57,37.92 < 15 |only if walking
click Shards of Myzrael
accept The Princess Trapped##642 |goto 62.54,33.75
stickystart "Reach_Level_38"
step
Kill Drywhisker enemies around this area
|tip You can find more in the cave at the top of the path referenced below.
collect 12 Mote of Myzrael##4435 |q 642/1 |goto 76.13,44.11
You can find more: |notinsticky
Around [78.07,35.28]
Up the path that starts at [80.84,39.91]
step
label "Reach_Level_38"
Kill enemies around this area
Reach Level 38 |ding 38 |goto 76.13,44.11
You can find more: |notinsticky
Around [78.07,35.28]
Up the path that starts at [80.84,39.91]
step
Follow the path up |goto 80.90,39.96 < 10 |only if walking
Enter the cave |goto 82.66,36.16 < 15 |walk
Follow the path |goto 83.87,33.30 < 15 |walk
Follow the path up |goto 87.13,31.39 < 10 |walk
Follow the path |goto 84.73,28.93 < 10 |walk
click Iridescent Shards
|tip Upstairs inside the cave.
turnin The Princess Trapped##642 |goto 84.31,30.92
accept Stones of Binding##651 |goto 84.31,30.92
step
Follow the path |goto 83.77,33.75 < 15 |walk
Leave the cave |goto 82.69,36.21 < 15 |walk
Follow the path |goto 73.48,41.26 < 30 |only if walking
click Stone of East Binding
collect Cresting Key##4484 |q 651/2 |goto 66.75,29.75
step
kill Kenata Dabyrie##4480
|tip Inside the building.
collect Kenata's Head##5830 |q 1164/1 |goto 56.37,36.08
step
kill Marcel Dabyrie##4481
|tip Inside the building.
collect Marcel's Head##5832 |q 1164/2 |goto 54.14,38.16
step
kill Fardel Dabyrie##4479
collect Fardel's Head##58312 |q 1164/3 |goto 56.54,38.70
step
click Stone of Outer Binding
collect Thundering Key##4485 |q 651/3 |goto 52.06,50.69
step
kill Highland Fleshstalker##2561+
collect 12 Raptor Heart##4513 |q 701/1 |goto 52.35,66.84
|tip These have a low drop rate.
You can find more around [47.45,77.65]
stickystart "Kill_Boulderfist_Ogres"
step
Follow the road |goto 45.09,58.72 < 30 |only if walking
Enter the cave |goto 34.81,44.14 < 15 |walk
kill 10 Boulderfist Enforcer##2564 |q 676/2 |goto 33.74,44.92
|tip Inside the cave.
step
Leave the cave |goto 34.82,44.15 < 15 |c |q 676
step
label "Kill_Boulderfist_Ogres"
kill 8 Boulderfist Ogre##2562 |q 676/1 |goto 36.32,43.60
You can find more around: |notinsticky
[32.61,40.22]
[33.17,48.05]
step
Kill Syndicate enemies around this area
|tip Some of them are stealthed, so be careful.
|tip They are also inside the buildings.
|tip You can find more stealted along the small hill ridges surrounding this village.
collect 10 Bloodstone Amulet##4495 |q 671/1 |goto 32.67,29.22
|tip These have a low drop rate.
step
click Stone of West Binding
collect Burning Key##4483 |q 651/1 |goto 25.52,30.12
step
Follow the road |goto 22.85,36.03 < 30 |only if walking
click Stone of Inner Binding
turnin Stones of Binding##651 |goto 36.19,57.37
step
Follow the path |goto 31.22,65.35 < 20 |only if walking
Continue following the path |goto 23.60,70.17 < 20 |only if walking
Enter the tunnel |goto 21.58,75.61 < 15 |only if walking
Leave the tunnel |goto 22.00,79.55 < 15 |only if walking
talk Lolo the Lookout##2766
|tip He walks around this area.
accept Land Ho!##663 |goto 31.78,82.70
step
talk Shakes O'Breen##2610
turnin Land Ho!##663 |goto 32.28,81.38
step
talk First Mate Nilzlix##2767
|tip He walks around this area.
accept Deep Sea Salvage##662 |goto 32.77,81.47
step
talk Captain Steelgut##2769
accept Drowned Sorrows##664 |goto 34.00,80.79
step
talk Professor Phizzlethorpe##2768
accept Sunken Treasure##665 |goto 33.87,80.55
step
Watch the dialogue
|tip Follow Professor Phizzlethorpe as he walks.
|tip He eventually walks back to this location.
Kill the enemies that attack
|tip Inside the cave.
|tip Two level 40 water elementals will attack you.
Defend Professor Phizzlethorpe |q 665/1 |goto 33.87,80.55
step
talk Doctor Draxlegauge##2774
turnin Sunken Treasure##665 |goto 33.86,80.45
accept Sunken Treasure##666 |goto 33.86,80.45
step
Equip the Goggles of Gem Hunting
|tip They should be in your bags.
Click Here After Equipping The Goggles |confirm |q 666
step
use an Elixir of Water Breathing##5996
|tip If you don't have any water breathing potions, skip the next few steps in the water and abandon the quests.
|tip They're extremely difficult and time consuming to do without water breathing.
Gain Water Breathing |havebuff 135859 |q 666
stickystart "Collect_Elven_Gems"
stickystart "Kill_Daggerspine_Sorceresses"
stickystart "Kill_Daggerspine_Raiders"
step
Swim through the sunken ship window |goto 23.44,85.43 < 3 |walk
click Maiden's Folly Log
|tip It looks like a large brown book in a grey metal cauldron.
|tip On the middle floor of the sunken ship.
collect Maiden's Folly Log##4489 |q 662/2 |goto 23.41,85.10
step
click Maiden's Folly Charts
|tip It looks like a tan scroll laying flat on a wooden ledge.
|tip On the middle floor of the sunken ship.
collect Maiden's Folly Charts##4487 |q 662/1 |goto 23.04,84.51
step
Swim through the sunken ship window |goto 22.74,85.05 < 3 |walk
Swim through the sunken ship window |goto 20.85,85.60 < 3 |walk
click Spirit of Silverpine Charts
|tip It looks like a tan scroll laying flat on a wooden crate next to a cannon.
|tip On the middle floor of the sunken ship.
collect Spirit of Silverpine Charts##4488 |q 662/3 |goto 20.45,85.60
step
Swim through the sunken ship window and enter the hole at the bottom of the ship |goto 20.30,84.79 < 3 |walk
click Spirit of Silverpine Log
|tip It looks like an open book laying on the ground.
|tip At the very bottom of the ship.
collect Spirit of Silverpine Log##4490 |q 662/4 |goto 20.65,85.10
step
label "Collect_Elven_Gems"
click Calcified Elven Gem+
|tip They look like large gray stones on the ground underwater around this area.
|tip If you are wearing the Goggles of Gen Hunting, they will appear on your minimap as yellow dots.
collect 10 Elven Gem##4492 |q 666/1 |goto 25.03,85.70
You can find more around: |notinsticky
[24.65,90.70]
[18.60,90.36]
[19.70,84.18]
step
label "Kill_Daggerspine_Sorceresses"
kill 3 Daggerspine Sorceress##2596 |q 664/2 |goto 22.83,87.29
|tip Underwater around this area.
step
label "Kill_Daggerspine_Raiders"
kill 10 Daggerspine Raider##2595 |q 664/1 |goto 22.83,87.29
|tip Underwater around this area.
step
talk First Mate Nilzlix##2767
|tip He walks around this area.
turnin Deep Sea Salvage##662 |goto 32.80,81.48
step
talk Captain Steelgut##2769
turnin Drowned Sorrows##664 |goto 34.00,80.79
step
talk Doctor Draxlegauge##2774
turnin Sunken Treasure##666 |goto 33.85,80.45
accept Sunken Treasure##668 |goto 33.85,80.45
step
Equip Your Regular Head Armor
Click Here After Equipping Your Regular Head Armor |confirm |q 668
step
talk Shakes O'Breen##2610
turnin Sunken Treasure##668 |goto 32.29,81.38
accept Sunken Treasure##669 |goto 32.29,81.38
step
Leave the building |goto 73.79,32.98 < 7 |walk
talk Drum Fel##2771
turnin The Hammer May Fall##676 |goto 74.24,33.91
accept Call to Arms##677 |goto 74.24,33.91
step
talk Tor'gan##2706
turnin Foul Magics##671 |goto 74.71,36.29
turnin Guile of the Raptor##701 |goto 74.71,36.29
accept Guile of the Raptor##702 |goto 74.71,36.29
step
talk Gor'mul##2792
|tip He walks around this area.
turnin Guile of the Raptor##702 |goto 72.55,34.01
step
Watch the dialogue
talk Gor'mul##2792
|tip He walks around this area.
accept Guile of the Raptor##847 |goto 72.55,34.01
step
talk Tor'gan##2706
turnin Guile of the Raptor##847 |goto 74.71,36.29
stickystart "Kill_Witherbark_Axe_Throwers"
stickystart "Kill_Witherbark_Witch_Doctors"
stickystart "Reach_Level_39"
step
Follow the path |goto 74.57,37.93 < 15 |only if walking
kill 10 Witherbark Headhunter##2556 |q 677/2 |goto 66.66,64.37
You can find more around: |notinsticky
[61.45,72.04]
[64.79,72.83]
[70.29,68.39]
[72.11,64.09]
[70.82,60.27]
step
label "Kill_Witherbark_Axe_Throwers"
kill 10 Witherbark Axe Thrower##2554 |q 677/1 |goto 66.66,64.37
You can find more around: |notinsticky
[61.45,72.04]
[64.79,72.83]
[70.29,68.39]
[72.11,64.09]
[70.82,60.27]
step
label "Kill_Witherbark_Witch_Doctors"
kill 8 Witherbark Witch Doctor##2555 |q 677/3 |goto 66.66,64.37
You can find more around: |notinsticky
[61.45,72.04]
[64.79,72.83]
[70.29,68.39]
[72.11,64.09]
[70.82,60.27]
step
label "Reach_Level_39"
Kill enemies around this area
Reach Level 39 |ding 39 |goto 66.66,64.37
You can find more around: |notinsticky
[61.45,72.04]
[64.79,72.83]
[70.29,68.39]
[72.11,64.09]
[70.82,60.27]
step
Follow the path |goto 74.57,37.94 < 15 |only if walking
Run up the stairs |goto 73.49,34.09 < 7 |only if walking
talk Drum Fel##2771
turnin Call to Arms##677 |goto 74.24,33.91
accept Call to Arms##678 |goto 74.24,33.91
stickystart "Kill_Boulderfist_Brutes"
step
Follow the path |goto 74.56,37.90 < 15 |only if walking
Continue following the path |goto 57.52,52.43 < 30 |only if walking
kill 4 Boulderfist Magus##2567 |q 678/2 |goto 52.77,74.81
step
label "Kill_Boulderfist_Brutes"
kill 10 Boulderfist Brute##2566 |q 678/1 |goto 52.77,74.81
step
Leave the building |goto 73.78,32.97 < 10 |walk
talk Drum Fel##2771
turnin Call to Arms##678 |goto 74.24,33.91
step
talk Genavie Callow##4486
turnin To Steal From Thieves##1164 |goto Undercity 63.84,49.45
step
Enter the building |goto Orgrimmar 22.29,53.90 < 7 |walk
talk Keldran##5640
|tip He walks around inside the building.
turnin Alliance Relations##1436 |goto Orgrimmar 22.56,52.64
step
Leave the building |goto 22.29,53.90 < 7 |walk
Enter the building |goto The Barrens 52.03,30.19 < 7 |walk
talk Innkeeper Boorand Plainswind##3934
|tip Inside the building.
home The Crossroads |goto The Barrens 51.99,29.89
step
Leave the building |goto 52.02,30.18 < 7 |walk
Ride the elevator down |goto Thousand Needles 46.72,48.26 < 10 |only if walking
Follow the road |goto Thousand Needles 48.53,51.66 < 30 |only if walking
Follow the path |goto Thousand Needles 66.23,55.71 < 30 |only if walking
talk Moktar Krin##4483
turnin The Swarm Grows##1146 |goto Thousand Needles 67.58,63.94
accept The Swarm Grows##1147 |goto Thousand Needles 67.58,63.94
step
talk Kravel Koalbeard##4452
turnin Parts for Kravel##1112 |goto 77.79,77.27
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Delivery to the Gnomes##1114 |goto 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin Delivery to the Gnomes##1114 |goto 78.06,77.12
step
talk Kravel Koalbeard##4452
accept The Rumormonger##1115 |goto 77.79,77.27
step
talk Pozzik##4630
turnin Goblin Sponsorship##1183 |goto 80.18,75.88
accept The Eighteenth Pilot##1186 |goto 80.18,75.88
step
talk Razzeric##4706
turnin The Eighteenth Pilot##1186 |goto 80.33,76.09
accept Razzeric's Tweaking##1187 |goto 80.33,76.09
stickystart "Kill_Silithid_Hive_Drones"
stickystart "Kill_Silithid_Invaders"
stickystart "Accept_Parts_Of_The_Swarm"
stickystart "Collect_Silithid_Heart"
stickystart "Collect_Silithid_Talons"
stickystart "Collect_Intact_Silithid_Carapaces"
step
kill 5 Silithid Searcher##4130 |q 1147/1 |goto 70.52,83.14
|tip These can only be found on the outskirts of these ruins.
|tip They aren't in the trenches or the nearby cave.
You can find more around: |notinsticky
[67.24,82.00]
step
label "Kill_Silithid_Hive_Drones"
kill 5 Silithid Hive Drone##4133 |q 1147/2 |goto 69.50,84.74
You can find more inside the cave at [66.32,86.18]
step
label "Kill_Silithid_Invaders"
kill 5 Silithid Invader##4131 |q 1147/3 |goto 66.32,86.18
|tip Inside the cave.
|tip They share spawn points with Silithid Hive Drones inside the cave.
|tip Kill those also, if you can't find any Silithid Invaders.
step
Leave the cave |goto 66.32,86.18 < 10 |c |q 1147
step
label "Accept_Parts_Of_The_Swarm"
Kill Silithid enemies around this area
collect Cracked Silithid Carapace##5877 |n
use the Cracked Silithid Carapace##5877
accept Parts of the Swarm##1148 |goto 69.50,84.74
step
label "Collect_Silithid_Heart"
Kill Silithid enemies around this area
collect Silithid Heart##5855 |q 1148/1 |goto 69.50,84.74
|tip This has a low drop rate.
You can find more inside the cave at [66.32,86.18]
|only if havequest(1148) or completedq(1148)
step
label "Collect_Silithid_Talons"
Kill Silithid enemies around this area
collect 5 Silithid Talon##5854 |q 1148/2 |goto 69.50,84.74
|tip These have a low drop rate.
|only if havequest(1148) or completedq(1148)
step
label "Collect_Intact_Silithid_Carapaces"
Kill Silithid enemies around this area
collect 3 Intact Silithid Carapace##5853 |q 1148/3 |goto 69.50,84.74
|tip These have a low drop rate.
|only if havequest(1148) or completedq(1148)
step
talk Moktar Krin##4483
turnin The Swarm Grows##1147 |goto 67.58,63.95
step
Leave the building |goto The Barrens 52.03,30.18 < 7 |walk
talk Korran##3428
turnin Parts of the Swarm##1148 |goto The Barrens 51.07,29.63
accept Parts of the Swarm##1184 |goto The Barrens 51.07,29.63
step
talk Shadi Mistrunner##8363
|tip Inside the building.
buy 3 Soothing Spices##3713 |goto Thunder Bluff 40.64,64.00 |q 1218 |future
|tip Be careful not to accidentally sell these to a vendor.
step
talk Melor Stonehoof##3441
turnin Frostmaw##1136 |goto 61.53,80.90
accept Deadmire##1205 |goto 61.53,80.90
step
talk Nazeer Bloodpike##4791
accept Theramore Spies##1201 |goto Dustwallow Marsh 35.21,30.66
step
talk Do'gol##5087
accept The Black Shield##1322 |goto 36.52,30.80
step
talk Mudcrush Durtfeet##4503
accept Hungry!##1177 |goto 35.15,38.25
stickystart "Collect_Acidic_Venom_Sacs"
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 37.05,38.41 |count 1
|tip It walks around this small area stealthed.
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 38.04,37.41 |count 2
|tip It walks around this small area stealthed.
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 38.05,34.07 |count 3
|tip It walks around this small area stealthed.
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 40.52,33.39 |count 4
|tip It walks around this small area stealthed.
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 40.64,35.29 |count 5
|tip It walks around this small area stealthed.
step
label "Collect_Acidic_Venom_Sacs"
Kill Darkfang enemies around this area
|tip They look like orange spiders.
|tip They can be pretty spread out.
collect 6 Acidic Venom Sac##5959 |q 1322/1 |goto 36.98,48.88
You can find more around: |notinsticky
[37.47,52.27]
[34.08,52.43]
[33.94,54.67]
[40.23,47.83]
[38.86,54.98]
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 37.05,38.41 |count 6
|tip It walks around this small area stealthed.
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 38.04,37.41 |count 7
|tip It walks around this small area stealthed.
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 38.05,34.07 |count 8
|tip It walks around this small area stealthed.
step
kill Theramore Infiltrator##4834 |q 1201/1 |goto 40.52,33.39 |count 9
|tip It walks around this small area stealthed.
step
Kill Mirefin enemies around this area
collect 12 Mirefin Head##5847 |q 1177/1 |goto 54.42,15.92
You can find more around [57.50,16.51]
step
Follow the path up |goto 57.88,18.38 < 10 |only if walking
talk "Swamp Eye" Jarl##4792
accept Soothing Spices##1218 |goto 55.43,26.27
|tip You will need the Soothing Spices you purchased in Thunder Bluff earlier in this guide.
step
talk "Swamp Eye" Jarl##4792
turnin Soothing Spices##1218 |goto 55.43,26.27
accept Jarl Needs Eyes##1206 |goto 55.43,26.27
step
click Loose Dirt
accept The Lost Report##1238 |goto 55.44,25.93
step
talk "Stinky" Ignatz##4880
accept Stinky's Escape##1270 |goto 46.88,17.52
step
Watch the dialogue
|tip Follow and protect "Stinky" Ignatz as he walks.
|tip He eventually walks to this location.
Help Stinky Find Bogbean Leaves |q 1270/1 |goto 48.86,24.65
step
Avoid the nearby tower |goto 46.69,22.30 < 30 |only if walking
Kill Darkmist enemies around this area
|tip Inside and outside the mine.
collect 40 Unpopped Darkmist Eye##5884 |q 1206/1 |goto 33.22,22.76
step
Follow the path |goto 35.18,29.36 < 10 |only if walking
talk Nazeer Bloodpike##4791
turnin Theramore Spies##1201 |goto 35.21,30.66
accept The Theramore Docks##1202 |goto 35.21,30.66
turnin The Lost Report##1238 |goto 35.21,30.66
step
talk Do'gol##5087
turnin The Black Shield##1322 |goto 36.53,30.80
accept The Black Shield##1323 |goto 36.53,30.80
step
talk Krog##4926
turnin The Black Shield##1323 |goto 36.42,31.88
step
talk Mudcrush Durtfeet##4503
turnin Hungry!##1177 |goto 35.15,38.25
step
Follow the road |goto 37.17,40.02 < 30 |only if walking
Avoid the tower nearby |goto 46.29,21.73 < 30 |only if walking
talk "Swamp Eye" Jarl##4792
turnin Jarl Needs Eyes##1206 |goto 55.43,26.27
accept Jarl Needs a Blade##1203 |goto 55.44,26.27 |only if (itemcount(3853) >= 1 or completedq(1203))
step
talk "Swamp Eye" Jarl##4792
turnin Jarl Needs a Blade##1203 |goto 55.44,26.27
|only if havequest(1203) or completedq(1203)
step
click Loose Dirt
accept The Severed Head##1239 |goto 55.44,25.93
step
Follow the road |goto 54.84,30.17 < 30 |only if walking
Follow the path |goto 63.08,42.27 < 30 |only if walking
Continue following the path |goto 67.53,43.20 < 30 |only if walking
click Captain's Footlocker
|tip Underwater.
collect Captain's Documents##5882 |q 1202/1 |goto 71.56,51.17
step
Leave the building |goto The Barrens 52.03,30.17 < 7 |walk
talk Nazeer Bloodpike##4791
turnin The Theramore Docks##1202 |goto Dustwallow Marsh 35.21,30.66
turnin The Severed Head##1239 |goto Dustwallow Marsh 35.21,30.66
accept The Troll Witchdoctor##1240 |goto Dustwallow Marsh 35.21,30.66
step
talk Mebok Mizzyrix##3446
turnin Stinky's Escape##1270 |goto The Barrens 62.37,37.62
step
talk First Mate Crazz##2490
accept The Bloodsail Buccaneers##595 |goto Stranglethorn Vale 28.10,76.22
step
Enter the building |goto 27.64,77.09 < 5 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
accept Scaring Shaky##606 |goto 27.78,77.07
step
Leave the building |goto 27.64,77.09 < 5 |walk
Enter the building |goto 27.08,77.62 < 5 |walk
talk Innkeeper Skindle##6807
|tip Inside the building.
home Booty Bay |goto 27.04,77.31
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
turnin The Rumormonger##1115 |goto 26.94,77.21
accept Dream Dust in the Swamp##1116 |goto 26.94,77.21
step
talk Fleet Master Seahorn##2487
|tip Upstairs on the balcony of the building.
turnin Sunken Treasure##669 |goto 27.17,77.01
step
talk Far Seer Mok'thardin##2465
accept Mok'thardin's Enchantment##572 |goto 32.12,29.24
step
talk Kin'weelay##2519
turnin The Troll Witchdoctor##1240 |goto 32.27,27.71
step
Watch the dialogue
talk Kin'weelay##2519
accept The Vile Reef##629 |goto 32.27,27.71
step
click Bubbling Cauldron
accept Marg Speaks##1261 |goto 32.22,27.65
step
Kill enemies around this area
Reach Level 40 |ding 40 |goto 29.94,22.27
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (40-45)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (45-50)",
startlevel=40,
endlevel=45,
},[[
stickystart "Kill_Jungle_Stalkers"
step
kill Jungle Stalker##687+
collect 10 Jungle Stalker Feather##3863 |q 572/1 |goto Stranglethorn Vale 33.70,38.83
|tip These have a low drop rate.
|tip Be careful to avoid Tethis.
|tip He looks like a level 43 elite blue raptor that walks around this area.
You can find more around: |notinsticky
[Stranglethorn Vale 31.79,41.74]
[Stranglethorn Vale 28.91,44.29]
[Stranglethorn Vale 27.19,49.65]
step
label "Kill_Jungle_Stalkers"
kill 10 Jungle Stalker##687 |q 196/1 |goto 33.70,38.83
|tip Be careful to avoid Tethis.
|tip He looks like a level 43 elite blue raptor that walks around this area.
You can find more around: |notinsticky
[31.79,41.74]
[28.91,44.29]
[27.19,49.65]
step
Follow the path |goto 32.80,28.74 < 15 |only if walking
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##572 |goto 32.12,29.24
accept Mok'thardin's Enchantment##571 |goto 32.12,29.24
step
Follow the path |goto 32.06,27.32 < 15 |only if walking
click Gri'lek the Wanderer
|tip Underwater.
collect Tablet Shard##4094 |q 629/1 |goto 24.83,23.04
step
Follow the path |goto 32.07,27.31 < 15 |only if walking
talk Kin'weelay##2519
turnin The Vile Reef##629 |goto 32.27,27.70
step
Follow the path |goto 32.78,28.75 < 15 |only if walking
kill Snapjaw Crocolisk##1152+
|tip Underwater and on the shores near the water around this area.
collect 5 Snapjaw Crocolisk Skin##4104 |q 577/1 |goto 41.52,19.48
You can find more around: |notinsticky
[40.03,24.70]
[39.28,30.27]
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##196 |goto 35.66,10.81
accept Raptor Mastery##197 |goto 35.66,10.81
step
Leave the building |goto 27.08,77.62 < 5 |walk
Cross the bridge |goto 28.15,76.52 < 7 |only if walking
Enter the building |goto 28.21,77.32 < 5 |walk
talk Drizzlik##2495
|tip Inside the building.
turnin Some Assembly Required##577 |goto 28.29,77.59
accept Excelsior##628 |goto 28.29,77.59
step
Leave the building |goto 28.21,77.33 < 5 |walk
Enter the tunnel |goto 27.92,73.71 < 10 |only if walking
Leave the tunnel |goto 29.59,72.43 < 10 |only if walking
click Bloodsail Correspondence
turnin The Bloodsail Buccaneers##595 |goto 27.28,69.52
accept The Bloodsail Buccaneers##597 |goto 27.28,69.52
stickystart "Collect_Mistvale_Giblets"
step
Follow the path |goto 28.38,70.55 < 20 |only if walking
Follow the road |goto 30.67,72.24 < 30 |only if walking
kill Elder Mistvale Gorilla##1557+
collect Aged Gorilla Sinew##3862 |q 571/1 |goto 31.72,67.03
|tip This has a very low drop rate.
You can find more around: |notinsticky
[33.79,64.66]
[32.18,59.97]
step
label "Collect_Mistvale_Giblets"
kill Elder Mistvale Gorilla##1557+
collect 5 Mistvale Giblets##3919 |q 606/1 |goto 31.72,67.03
|tip These have a low drop rate.
You can find more around: |notinsticky
[33.79,64.66]
[32.18,59.97]
step
Follow the road |goto 30.83,69.13 < 30 |only if walking
Enter the tunnel |goto 29.56,72.51 < 10 |only if walking
Leave the tunnel |goto 27.95,73.67 < 10 |only if walking
talk "Shaky" Phillipe##2502
turnin Scaring Shaky##606 |goto 26.90,73.59
accept Return to MacKinley##607 |goto 26.90,73.59
step
talk First Mate Crazz##2490
turnin The Bloodsail Buccaneers##597 |goto 28.10,76.21
accept The Bloodsail Buccaneers##599 |goto 28.10,76.21
step
Enter the building |goto 27.64,77.09 < 5 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Return to MacKinley##607 |goto 27.78,77.07
step
Leave the building |goto 27.64,77.09 < 5 |walk
Enter the building |goto 27.08,77.62 < 5 |walk
talk Fleet Master Seahorn##2487
|tip Upstairs on the balcony of the building.
turnin The Bloodsail Buccaneers##599 |goto 27.17,77.01
step
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##571 |goto 32.12,29.24
accept Mok'thardin's Enchantment##573 |goto 32.12,29.24
step
talk Kin'weelay##2519
accept Split Bone Necklace##598 |goto 32.27,27.71
step
Enter the building |goto 31.32,29.57 < 7 |walk
talk Innkeeper Thulbek##5814
|tip Inside the building.
home Grom'gol Base Camp |goto 31.49,29.75
step
Leave the building |goto 31.32,29.57 < 7 |walk
talk Auctioneer Naxxremis##15683
|tip Buy these items from the Auction House.
|tip If you can't get them, that's okay, but you will have to skip some quests later in the guide.
collect 2 Elixir of Water Breathing##5996 |goto Undercity 64.39,35.82 |q 1424 |future
collect Frost Oil##3829 |goto Undercity 64.39,35.82 |q 713 |future
collect Gyrochronatom##4389 |goto Undercity 64.39,35.82 |q 714 |future
collect Healing Potion##929 |goto Undercity 64.39,35.82 |q 715 |future
collect Lesser Invisibility Potion##3823 |goto Undercity 64.39,35.82 |q 715 |future
collect Patterned Bronze Bracers##2868 |goto Undercity 64.39,35.82 |q 716 |future
collect 9 Blue Pearl##4611 |goto Undercity 64.39,35.82 |q 705 |future
step
Follow the path |goto Arathi Highlands 74.57,37.91 < 15 |only if walking
Follow the road |goto Arathi Highlands 44.66,63.02 < 30 |only if walking
Cross the bridge |goto Arathi Highlands 44.00,81.58 < 20 |only if walking
Cross the bridge |goto Arathi Highlands 45.48,89.30 < 20 |only if walking
Follow the road |goto Wetlands 50.98,11.94 < 20 |only if walking
Continue following the road |goto Wetlands 50.50,39.76 < 30 |only if walking
Enter the tunnel |goto Wetlands 53.87,70.33 < 15 |only if walking
Follow the path up |goto Wetlands 48.04,67.50 < 15 |c |q 1106
step
Enter the tunnel |goto 50.14,71.53 < 15 |only if walking
Enter the tunnel |goto 50.62,82.57 < 15 |only if walking
Enter the tunnel |goto 55.65,84.87 < 15 |only if walking
Follow the road |goto Loch Modan 27.40,24.26 < 30 |only if walking
Avoid Thelsamar |goto Loch Modan 32.93,52.96 < 30 |only if walking
Follow the path |goto Loch Modan 39.32,53.26 < 30 |only if walking
Enter the Badlands |goto Loch Modan 47.35,82.06 < 30 |only if walking
Follow the path |goto Badlands 51.93,15.94 < 30 |only if walking
Continue following the path |goto Badlands 45.70,51.41 < 30 |only if walking
talk Rigglefuzz##2817
accept Barbecued Buzzard Wings##703 |goto Badlands 42.39,52.93
accept Pearl Diving##705 |goto Badlands 42.39,52.93
step
talk Rigglefuzz##2817
turnin Pearl Diving##705 |goto 42.39,52.93
step
talk Martek the Exiled##4618
turnin Martek the Exiled##1106 |goto 42.22,52.69
accept Indurium##1108 |goto 42.22,52.69
step
Follow the path |goto 48.69,53.36 < 30 |only if walking
Kill Stonevaule enemies around this area
collect 10 Indurium Flake##5797 |q 1108/1 |goto 50.51,69.96
step
Follow the path |goto 48.69,53.36 < 30 |only if walking
talk Martek the Exiled##4618
turnin Indurium##1108 |goto 42.21,52.70
step
Watch the dialogue
talk Martek the Exiled##4618
accept News for Fizzle##1137 |goto 42.21,52.70
step
talk Lotwil Veriatus##2921
accept Study of the Elements: Rock##710 |goto 25.95,44.87
accept Coolant Heads Prevail##713 |goto 25.95,44.87
step
talk Lotwil Veriatus##2921
turnin Coolant Heads Prevail##713 |goto 25.95,44.87
accept Gyro... What?##714 |goto 25.95,44.87
step
talk Lotwil Veriatus##2921
turnin Gyro... What?##714 |goto 25.95,44.87
step
kill Lesser Rock Elemental##2735+
collect 10 Small Stone Shard##4626 |q 710/1 |goto 19.46,43.02
step
talk Lotwil Veriatus##2921
turnin Study of the Elements: Rock##710 |goto 25.95,44.87
accept Study of the Elements: Rock##711 |goto 25.95,44.87
step
Kill enemies around this area
Reach Level 41 |ding 41 |goto 19.46,43.02
You can find more around [17.43,58.87]
step
Follow the path |goto 14.15,44.31 < 15 |only if walking
talk Gorrik##2861
fpath Kargath |goto 3.99,44.78
step
talk Neeka Bloodscar##5394
|tip At the top of the tower.
accept Coyote Thieves##1419 |goto 6.48,47.18
accept Report to Helgrum##1420 |goto 6.48,47.18
step
Enter the building |goto 3.83,46.98 < 7 |walk
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
accept Badlands Reagent Run##2258 |goto 2.42,46.06
step
talk Gorn##1068
|tip Inside the building.
accept Broken Alliances##782 |goto 2.91,45.60
step
Leave the building |goto 3.83,46.97 < 7 |walk
Follow the path |goto 9.18,43.23 < 15 |only if walking
kill Lesser Rock Elemental##2735+
collect 5 Rock Elemental Shard##7848 |q 2258/3 |goto 20.96,45.87
stickystart "Collect_Buzzard_Gizzards"
stickystart "Collect_Buzzard_Wings"
stickystart "Collect_Crag_Coyote_Fangs"
stickystart "Collect_Coyote_Jawbones"
step
Follow the path up |goto 37.40,73.32 < 30 |only if walking
kill Rock Elemental##92+
collect 3 Large Stone Slab##4627 |q 711/1 |goto 39.30,77.11
You can find more around [43.56,84.04]
step
talk Lotwil Veriatus##2921
turnin Study of the Elements: Rock##711 |goto 25.95,44.87
accept Study of the Elements: Rock##712 |goto 25.95,44.87
step
path follow loose;	loop;	ants curved
path	33.87,60.40		40.75,55.11		48.60,48.61		52.19,51.24
path	52.44,57.78		61.45,69.44		47.76,72.01		25.24,73.18
path	21.57,78.39		15.13,78.39		11.57,73.43		13.36,65.68
path	19.40,58.22		25.82,55.26
kill Boss Tho'grun##2944
|tip He walks in a counter-clockwise path, so this step's path will help you find him faster.
|tip He looks like an armored ogre that walks with 5 other ogres.
|tip Lure him away from his bodyguards, so you can fight him alone.
collect Sign of the Earth##4640 |q 782/1
step
label "Collect_Buzzard_Gizzards"
Kill Buzzard enemies around this area
collect 5 Buzzard Gizzard##7847 |q 2258/1 |goto 16.82,59.84
You can find a more around:
[12.45,69.20]
[17.43,48.90]
[25.63,62.04]
[33.36,59.65]
[28.67,72.03]
[24.51,74.45]
[18.90,77.65]
step
label "Collect_Buzzard_Wings"
Kill Buzzard enemies around this area
collect 4 Buzzard Wing##3404 |q 703/1 |goto 16.82,59.84
|tip Be careful not to accidentally sell these to a vendor.
You can find a more around:
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
collect 10 Crag Coyote Fang##7846 |q 2258/2 |goto 23.75,55.12
You can find more around: |notinsticky
[14.18,65.72]
[31.58,65.16]
step
label "Collect_Coyote_Jawbones"
Kill Coyote enemies around this area
collect 30 Coyote Jawbone##6166 |q 1419/1 |goto 23.75,55.12
You can find more around: |notinsticky
[14.18,65.72]
[31.58,65.16]
step
Follow the path up |goto 13.40,81.62 < 30 |only if walking
kill Greater Rock Elemental##2736+
collect 5 Bracers of Rock Binding##4628 |q 712/1 |goto 15.36,88.40
step
Follow the path |goto 5.88,57.79 < 20 |only if walking
Enter the building |goto 3.85,47.00 < 7 |walk
talk Jarkal Mossmeld##6868
|tip Upstairs inside the building.
turnin Badlands Reagent Run##2258 |goto 2.42,46.06
step
talk Gorn##1068
|tip Inside the building.
turnin Broken Alliances##782 |goto 2.91,45.61
step
Leave the building |goto 3.83,46.97 < 7 |walk
talk Neeka Bloodscar##5394
|tip At the top of the tower.
turnin Coyote Thieves##1419 |goto 6.48,47.18
step
Follow the path |goto 10.95,42.94 < 15 |only if walking
talk Lotwil Veriatus##2921
turnin Study of the Elements: Rock##712 |goto 25.95,44.87
accept This Is Going to Be Hard##734 |goto 25.95,44.87
step
talk Lucien Tosselwrench##2920
turnin This Is Going to Be Hard##734 |goto 25.82,44.25
accept This Is Going to Be Hard##777 |goto 25.82,44.25
step
talk Lotwil Veriatus##2921
turnin This Is Going to Be Hard##777 |goto 25.95,44.86
accept This Is Going to Be Hard##778 |goto 25.95,44.86
|tip A Level 45 elemental will appear and attack you, so be prepared.
step
kill Fam'retor Guardian##2919
collect Lotwil's Shackles of Elemental Binding##4847 |q 778/1 |goto 26.10,46.81
step
talk Lotwil Veriatus##2921
turnin This Is Going to Be Hard##778 |goto 25.95,44.86
step
talk Lucien Tosselwrench##2920
accept Liquid Stone##715 |goto 25.82,44.24
accept Stone Is Better than Cloth##716 |goto 25.82,44.24
step
talk Lucien Tosselwrench##2920
turnin Liquid Stone##715 |goto 25.82,44.24
turnin Stone Is Better than Cloth##716 |goto 25.82,44.24
step
talk Rigglefuzz##2817
turnin Barbecued Buzzard Wings##703 |goto 42.39,52.93
step
Leave the building |goto Stranglethorn Vale 31.33,29.59 < 7 |walk
Follow the path |goto Stranglethorn Vale 32.78,28.75 < 15 |only if walking
Follow the road |goto Stranglethorn Vale 38.55,23.32 < 30 |only if walking
Follow the path |goto Stranglethorn Vale 39.29,5.55 < 20 |only if walking
Cross the bridge |goto Stranglethorn Vale 40.79,4.11 < 20 |only if walking
Follow the road |goto Duskwood 45.06,65.60 < 30 |only if walking
Avoid Darkshire |goto Duskwood 78.37,53.04 < 20 |only if walking
Follow the road |goto Duskwood 82.17,45.36 < 20 |only if walking
Follow the path up |goto Duskwood 86.22,39.90 < 20 |only if walking
talk Deathstalker Zraedus##5418
accept Nothing But The Truth##1372 |goto Duskwood 87.81,35.63
step
talk Apothecary Faustin##5414
turnin Nothing But The Truth##1372 |goto 87.46,35.25
accept Nothing But The Truth##1383 |goto 87.46,35.25
step
Follow the road |goto 87.73,40.68 < 30 |only if walking
Cross the bridge |goto Deadwind Pass 41.83,34.69 < 20 |only if walking
Follow the road |goto Deadwind Pass 52.04,43.41 < 20 |only if walking
Kill Whelp enemies around this area
collect 10 Speck of Dream Dust##5803 |q 1116/1 |goto Swamp of Sorrows 14.74,60.20
step
Follow the path |goto 17.67,42.35 < 30 |only if walking
Enter the cave |goto 6.46,31.45 < 15 |walk
talk Mire Lord##1081
|tip Inside the cave.
collect Mire Lord Fungus##6081 |q 1383/2 |goto 5.51,31.39
step
Follow the path |goto 17.67,42.35 < 30 |c |q 1392 |future
step
path	follow loose;	loop;	ants curved
path	32.39,35.38		33.15,43.58		37.34,46.76		42.24,33.84
path	47.11,38.83		49.86,40.28		54.02,39.21		55.84,35.85
kill Noboru the Cudgel##5477
collect Noboru's Cudgel##6196 |q 1392 |future
step
use Noboru's Cudgel##6196
accept Noboru the Cudgel##1392
step
talk Magtoor##1776
turnin Noboru the Cudgel##1392 |goto 25.99,31.40
accept Draenethyst Crystals##1389 |goto 25.99,31.40
step
Follow the path |goto 44.77,49.40 < 15 |only if walking
Enter the building |goto 45.26,55.32 < 15 |walk
talk Innkeeper Karakul##6930
|tip Inside the building.
home Stonard |goto 45.16,56.65
step
talk Dar##5591
|tip Inside the building.
accept Lack of Surplus##698 |goto 44.70,57.20
accept Fresh Meat##1430 |goto 44.70,57.20
step
Leave the building |goto 45.25,55.32 < 10 |walk
talk Breyk##6026
fpath Stonard |goto 46.07,54.82
step
Enter the building |goto 46.92,54.03 < 15 |walk
talk Helgrum the Swift##1442
|tip Upstairs inside the building.
turnin Report to Helgrum##1420 |goto 47.74,55.20
step
talk Fel'zerul##1443
|tip Upstairs inside the building.
accept Pool of Tears##1424 |goto 47.93,54.80
step
Leave the building |goto 47.75,56.83 < 10 |walk
Follow the path |goto 47.91,58.49 < 15 |only if walking
use an Elixir of Water Breathing##5996
click Atal'ai Artifact+
|tip Avoid the elite enemies on the shore surrounding the lake.
|tip They look like various small objects on the ground underwater around this area.
|tip You can find them all around this large large.
collect 10 Atal'ai Artifact##6175 |q 1424/1 |goto 67.14,58.70
stickystart "Collect_Unprepared_Sawtooth_Flanks"
step
kill Shadow Panther##768+
|tip They are stealthed.
collect 5 Shadow Panther Heart##6080 |q 1372/1 |goto 74.13,25.39
You can find more around: |notinsticky
[69.89,26.11]
[70.54,11.08]
step
label "Collect_Unprepared_Sawtooth_Flanks"
kill Sawtooth Snapper##1087+
collect 8 Unprepared Sawtooth Flank##6169 |q 698/1 |goto 75.12,18.47
You can find more around [83.03,33.42]
step
talk Tok'Kar##5592
turnin Lack of Surplus##698 |goto 81.32,80.97
accept Lack of Surplus##699 |goto 81.32,80.97
step
kill Sawtooth Snapper##1087+
collect 6 Sawtooth Snapper Claw##6168 |q 698/1 |goto 83.03,33.42
You can find more around [75.12,18.47]
stickystart "Collect_Draenethyst_Crystals"
step
kill Ongeku##5622
collect Draenethyst Shard##6190 |q 1373/1 |goto 65.07,21.97
step
talk Galen Goodward##5391
accept Galen's Escape##1393 |goto 65.41,18.23
step
Watch the dialogue
|tip Follow Galen Goodward and protect him as he walks.
|tip He eventually walks to this location.
Escort Galen Out of the Fallow Sanctuary |q 1393/1 |goto 51.71,29.57
step
label "Collect_Draenethyst_Crystals"
click Draenethyst Crystal+
|tip They look like large clusters of blue crystals on the ground around this area.
collect 6 Draenethyst Crystal##6071 |q 1389/1 |goto 55.74,27.60
You can find more around [63.50,22.72]
step
click Galen's Strongbox
turnin Galen's Escape##1393 |goto 47.81,39.76
step
talk Magtoor##1776
turnin Draenethyst Crystals##1389 |goto 25.99,31.40
step
Follow the path |goto 44.77,49.40 < 15 |only if walking
Enter the building |goto 47.01,54.13 < 15 |walk
talk Fel'zerul##1443
|tip Upstairs inside the building.
turnin Pool of Tears##1424 |goto 47.93,54.79
accept The Atal'ai Exile##1429 |goto 47.93,54.79
step
Leave the building |goto 47.76,56.94 < 10 |walk
Follow the path |goto 47.91,58.49 < 15 |only if walking
talk Tok'Kar##5592
turnin Lack of Surplus##699 |goto 81.32,80.97
accept Threat From the Sea##1422 |goto 81.32,80.97
step
talk Katar##5593
turnin Threat From the Sea##1422 |goto 83.75,80.42
accept Threat From the Sea##1426 |goto 83.75,80.42
stickystart "Kill_Marsh_Murlocs"
stickystart "Kill_Marsh_Inkspewers"
step
kill Marsh Flesheater##751 |q 1426/3 |goto 88.11,78.45 |count 1
step
Follow the path |goto 79.16,95.33 < 20 |only if walking
kill 3 Marsh Flesheater##751 |q 1426/3 |goto 71.74,97.29 |count 3
step
Follow the path |goto 79.34,95.01 < 20 |only if walking
kill 4 Marsh Flesheater##751 |q 1426/3 |goto 88.11,78.45 |count 4
|tip This is the same one you killed two steps ago.
|tip Kill enemies around this area until it respawns.
stickystop "Kill_Marsh_Murlocs"
step
kill Monstrous Crawler##1088+
collect 10 Monstrous Crawler Leg##6184 |q 1430/1 |goto 93.11,69.89
You can find more around: |notinsticky
[93.58,62.33]
[94.91,56.29]
[95.88,46.18]
[93.62,35.66]
[94.07,32.69]
[92.55,30.02]
[91.33,20.02]
stickystart "Kill_Marsh_Murlocs"
step
kill 5 Marsh Flesheater##751 |q 1426/3 |goto 88.11,78.45 |count 5
step
Follow the path |goto 79.16,95.33 < 20 |only if walking
kill 7 Marsh Flesheater##751 |q 1426/3 |goto 71.74,97.29 |count 7
step
Follow the path |goto 79.34,95.01 < 20 |only if walking
kill 8 Marsh Flesheater##751 |q 1426/3 |goto 88.11,78.45 |count 8
|tip This is the same one you killed two steps ago.
|tip Kill enemies around this area until it respawns.
step
Follow the path |goto 79.16,95.33 < 20 |only if walking
kill 10 Marsh Flesheater##751 |q 1426/3 |goto 71.74,97.29 |count 10
|tip These are the same ones you killed two steps ago.
|tip Kill enemies around this area until they respawn.
step
Follow the path |goto 79.42,94.83 < 20 |c |q 1426
step
label "Kill_Marsh_Murlocs"
kill 10 Marsh Murloc##747 |q 1426/1 |goto 82.88,91.02
You can find more around [87.69,78.14]
step
label "Kill_Marsh_Inkspewers"
kill 10 Marsh Inkspewer##750 |q 1426/2 |goto 82.88,91.02
You can find more around [87.69,78.14]
step
Kill enemies around this area
Reach Level 42 |ding 42 |goto 84.05,87.46
step
talk Katar##5593
turnin Threat From the Sea##1426 |goto 83.76,80.43
accept Threat From the Sea##1427 |goto 83.76,80.43
step
talk Tok'Kar##5592
turnin Threat From the Sea##1427 |goto 81.31,80.97
step
talk Dar##5591
|tip Inside the building.
turnin Fresh Meat##1430 |goto 44.70,57.21
step
Leave the building |goto 45.24,55.35 < 10 |walk
Follow the path |goto Stranglethorn Vale 32.07,27.32 < 15 |only if walking
kill Elder Saltwater Crocolisk##2635
collect Elder Crocolisk Skin##4105 |q 628/1 |goto Stranglethorn Vale 29.86,25.63
If it's not here, you can find more at:
[29.29,22.16]
[25.39,19.18]
step
Follow the path |goto 32.06,27.31 < 15 |only if walking
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
accept The Bloodsail Buccaneers##604 |goto 27.17,77.01
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
accept Skullsplitter Tusks##209 |goto 27.00,77.13
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
turnin Dream Dust in the Swamp##1116 |goto 26.94,77.21
step
talk Deeg##2488
|tip Upstairs inside the building, on the top floor.
accept Up to Snuff##587 |goto 26.92,77.35
step
talk Innkeeper Skindle##6807
|tip Inside the building.
home Booty Bay |goto 27.04,77.31
step
talk Crank Fizzlebub##2498
|tip Inside the building.
accept Venture Company Mining##600 |goto 27.12,77.21
accept Zanzil's Secret##621 |goto 27.12,77.21
step
Leave the building |goto 27.08,77.63 < 7 |walk
talk Privateer Bloads##2494
|tip He walks around this area.
accept Akiris by the Bundle##617 |goto 26.76,76.38
He sometimes walks to [27.43,76.78]
step
Enter the building |goto 27.64,77.09 < 7 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
accept Voodoo Dues##609 |goto 27.78,77.07
step
Leave the building |goto 27.63,77.08 < 7 |walk
Cross the bridge |goto 28.15,76.51 < 10 |only if walking
Enter the building |goto 28.21,77.34 < 7 |walk
talk Drizzlik##2495
|tip Inside the building.
turnin Excelsior##628 |goto 28.29,77.59
step
Leave the building |goto 28.21,77.32 < 7 |walk
Cross the bridge |goto 28.31,76.93 < 10 |only if walking
Follow the path |goto 28.16,76.37 < 15 |only if walking
talk Dizzy One-Eye##2493
accept Keep An Eye Out##576 |goto 28.59,75.90
stickystart "Collect_Snuff"
stickystart "Collect_Dizzys_Eye"
stickystart "Kill_Bloodsail_Swashbucklers"
step
Enter the tunnel |goto 27.95,73.61 < 15 |only if walking
Leave the tunnel |goto 29.54,72.53 < 15 |only if walking
Follow the path |goto 30.86,72.28 < 30 |only if walking
Continue following the path |goto 32.89,73.75 < 30 |only if walking
click Bloodsail Charts
|tip It looks like a brown piece of paper laying on a wooden crate.
collect Bloodsail Charts##3920 |q 604/2 |goto 27.15,82.69
step
click Bloodsail Orders
|tip It looks like a white unrolled scroll.
collect Bloodsail Orders##3921 |q 604/1 |goto 27.18,82.66
It can also be in the small wooden boat at [27.74,83.13]
step
label "Collect_Snuff"
Kill Bloodsail enemies around this area
collect 15 Snuff##3910 |q 587/1 |goto 27.07,82.90
You can find more around: |notinsticky
[29.78,81.38]
[32.96,73.85]
step
label "Collect_Dizzys_Eye"
Kill Bloodsail enemies around this area
collect Dizzy's Eye##3897 |q 576/1 |goto 27.07,82.90
You can find more around: |notinsticky
[29.78,81.38]
[32.96,73.85]
step
label "Kill_Bloodsail_Swashbucklers"
kill 10 Bloodsail Swashbuckler##1563 |q 604/1 |goto 27.07,82.90
You can find more around: |notinsticky
[29.78,81.38]
[32.96,73.85]
stickystart "Collect_Akiris_Reeds"
stickystart "Kill_Naga_Explorers"
step
Follow the path |goto 32.75,73.65 < 30 |only if walking
Follow the path up |goto 29.71,66.37 < 20 |only if walking
Jump down here |goto 27.85,67.41 < 15 |only if walking
Follow the path |goto 24.57,64.60 < 20 |only if walking
Follow the path up |goto 25.73,63.56 < 15 |only if walking
Follow the path |goto 27.35,62.99 < 15 |only if walking
Cross the bridge |goto 28.17,62.71 < 15 |only if walking
click The Holy Spring
collect Holy Spring Water##737 |q 573/2 |goto 28.92,61.96
step
label "Collect_Akiris_Reeds"
kill Naga Explorer##1907+
collect 10 Akiris Reed##4029 |q 617/1 |goto 27.88,62.75
You can find more around: |notinsticky
[27.00,63.02]
[25.43,62.88]
[26.04,60.45]
step
label "Kill_Naga_Explorers"
kill 10 Naga Explorer##1907 |q 573/1 |goto 27.88,62.75
You can find more around: |notinsticky
[27.00,63.02]
[25.43,62.88]
[26.04,60.45]
stickystart "Collect_Zanzils_Mixture"
step
Cross the bridge |goto 27.19,58.95 < 15 |only if walking
Follow the path |goto 29.63,57.09 < 20 |only if walking
Follow the path |goto 30.08,54.17 < 15 |only if walking
Follow the path |goto 34.08,51.96 < 15 |only if walking
kill Jon-Jon the Crow##2536
collect Jon-Jon's Golden Spyglass##3925 |q 609/2 |goto 34.93,51.85
step
kill Maury "Club Foot" Wilkins##2535
collect Maury's Clubbed Foot##3924 |q 609/1 |goto 35.25,51.26
step
Follow the road |goto 33.46,52.67 < 30 |only if walking
Follow the path |goto 34.10,54.05 < 15 |only if walking
kill Chucky "Ten Thumbs"##2537
collect Chucky's Huge Ring##3926 |q 609/3 |goto 40.00,58.24
step
label "Collect_Zanzils_Mixture"
Kill Zanzil enemies around this area
collect 12 Zanzil's Mixture##4016 |q 621/1 |goto 40.00,58.24
You can find more around [34.12,51.96]
step
Follow the path up |goto 38.00,56.42 < 20 |only if walking
Follow the road |goto 33.44,53.67 < 30 |only if walking
Continue following the road |goto 35.90,48.86 < 20 |only if walking
Follow the path up |goto 40.39,42.90 < 20 |only if walking
Kill Venture Co. enemies around this area
collect 10 Singing Blue Crystal##3917 |q 600/1 |goto 41.22,43.95
stickystart "Collect_Skullsplitter_Tusks"
step
Kill Skullspliter enemies around this area
collect 25 Split Bone Necklace##3916 |q 598/1 |goto 42.69,36.60
|tip These have a very low drop rate.
You can find more around: |notinsticky
[45.93,32.79]
[47.39,39.42]
[45.33,42.07]
step
label "Collect_Skullsplitter_Tusks"
Kill Skullspliter enemies around this area
collect 18 Skullsplitter Tusk##1524 |q 209/1 |goto 42.69,36.60
You can find more around: |notinsticky
[45.93,32.79]
[47.39,39.42]
[45.33,42.07]
step
Kill enemies around this area
Reach Level 43 |ding 43 |goto 42.69,36.60
You can find more around: |notinsticky
[45.93,32.79]
[47.39,39.42]
[45.33,42.07]
step
talk Crank Fizzlebub##2498
|tip Inside the building.
turnin Venture Company Mining##600 |goto 27.12,77.21
turnin Zanzil's Secret##621 |goto 27.12,77.21
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
turnin Skullsplitter Tusks##209 |goto 27.00,77.13
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
accept Rumors for Kravel##1117 |goto 26.94,77.21
accept Tran'rek##2864 |goto 26.94,77.21
step
talk Deeg##2488
|tip Upstairs inside the building, on the top floor.
turnin Up to Snuff##587 |goto 26.92,77.35
step
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
turnin The Bloodsail Buccaneers##604 |goto 27.17,77.01
step
talk Far Seer Mok'thardin##2465
turnin Mok'thardin's Enchantment##573 |goto 32.12,29.24
step
talk Kin'weelay##2519
turnin Split Bone Necklace##598 |goto 32.27,27.71
step
talk Nimboya##2497
accept Grim Message##2932 |goto 32.16,27.72
step
talk Privateer Bloads##2494
|tip He walks around this area.
turnin Akiris by the Bundle##617 |goto 26.76,76.38
He sometimes walks to [27.43,76.78]
step
Enter the building |goto 27.64,77.09 < 7 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Voodoo Dues##609 |goto 27.78,77.07
accept Stoley's Debt##2872 |goto 27.78,77.07
step
Leave the building |goto 27.63,77.09 < 7 |walk
Follow the path |goto 28.14,76.38 < 15 |only if walking
talk Dizzy One-Eye##2493
turnin Keep An Eye Out##576 |goto 28.59,75.90
step
Enter the cave |goto Dustwallow Marsh 36.83,32.41 < 15 |walk
talk Draz'Zilb##4501
|tip Inside the cave.
accept Identifying the Brood##1169 |goto Dustwallow Marsh 37.15,33.08
step
Leave the cave |goto 36.81,32.41 < 15 |walk
Follow the path |goto 37.53,31.66 < 15 |only if walking
talk Ogron##4983
accept Questioning Reethe##1273 |goto 40.96,36.69
step
Watch the dialogue
|tip Follow Ogron as he walks.
|tip He eventually walks to this location.
kill Lieutenant Caldwell##5046
Question Reethe with Ogron |q 1273/1 |goto 42.65,38.07
step
kill Deadmire##4841
|tip He looks like a white crocodile that walks in the water around this area.
collect Deadmire's Tooth##5945 |q 1205/1 |goto 42.64,49.15
You can also find him around:
[43.76,49.96]
[45.66,52.97]
[47.47,54.70]
[47.72,55.92]
[46.97,58.63]
[45.93,61.11]
[44.99,62.10]
step
click Gizmorium Shipping Crate
collect Seaforium Booster##5862 |q 1187/1 |goto 54.07,56.48
step
Follow the path |goto 54.94,58.12 < 15 |only if walking
Kill Muckshell enemies around this area
|tip In the water.
collect Jeweled Pendant##5942 |q 1261/1 |goto 56.97,61.32
|tip This has a low drop rate.
You can find more around: |notinsticky
[55.05,63.62]
[59.71,67.50]
[60.49,61.94]
stickystart "Collect_Searing_Hearts"
step
Follow the path up |goto 55.83,65.06 < 20 |only if walking
Kill Searing enemies around this area
|tip They look like small flying dragons.
|tip Be careful, there are many elite enemies around this area.
collect 15 Searing Tongue##5840 |q 1169/1 |goto 51.32,71.47
You can find more around: |notinsticky
[49.05,69.21]
[46.18,67.86]
[45.13,73.13]
[42.29,77.43]
[46.11,82.37]
[48.46,78.42]
step
label "Collect_Searing_Hearts"
Kill Searing enemies around this area
|tip They look like small flying dragons.
|tip Be careful, there are many elite enemies around this area.
collect 15 Searing Heart##5841 |q 1169/2 |goto 51.32,71.47
You can find more around: |notinsticky
[49.05,69.21]
[46.18,67.86]
[45.13,73.13]
[42.29,77.43]
[46.11,82.37]
[48.46,78.42]
step
Avoid the Stonemaul Ruins |goto 40.73,68.22 < 30 |only if walking
Kill enemies around this area
Reach Level 44 |ding 44 |goto 41.76,55.93
You can find more around [43.26,47.17]
step
Follow the path |goto 36.20,33.20 < 20 |only if walking
talk Krog##4926
turnin Questioning Reethe##1273 |goto 36.42,31.88
accept The Black Shield##1276 |goto 36.42,31.88
step
Enter the cave |goto 36.83,32.42 < 15 |walk
talk Draz'Zilb##4501
|tip Inside the cave.
turnin Identifying the Brood##1169 |goto 37.15,33.08
step
Watch the dialogue
|tip Inside the cave.
talk Draz'Zilb##4501
accept The Brood of Onyxia##1170 |goto 37.15,33.08
step
Leave the cave |goto 36.80,32.36 < 15 |walk
talk Overlord Mok'Morokk##4500
turnin The Brood of Onyxia##1170 |goto 36.30,31.42
accept The Brood of Onyxia##1171 |goto 36.30,31.42
step
Enter the cave |goto 36.83,32.42 < 15 |walk
talk Draz'Zilb##4501
|tip Inside the cave.
turnin The Brood of Onyxia##1171 |goto 37.15,33.08
step
Leave the cave |goto 36.80,32.36 < 15 |walk
talk Nazeer Bloodpike##4791
turnin Marg Speaks##1261 |goto 35.21,30.66
accept Report to Zor##1262 |goto 35.21,30.66
step
Enter the building |goto Thunder Bluff 44.95,62.00 < 15 |only if walking
Cross the bridge |goto Thunder Bluff 47.67,68.76 < 10 |only if walking
Enter the building |goto Thunder Bluff 54.56,80.09 < 10 |walk
talk Mosarn##4943
|tip Inside the building.
turnin The Black Shield##1276 |goto Thunder Bluff 54.01,80.78
step
talk Melor Stonehoof##3441
turnin Deadmire##1205 |goto 61.54,80.91
step
Enter the building |goto Desolace 24.54,68.65 < 10 |walk
talk Innkeeper Sikewa##11106
|tip Inside the building.
home Shadowprey Village |goto Desolace 24.09,68.21
step
Leave the building |goto 24.54,68.64 < 10 |walk
talk Taiga Wisemane##11624
accept Portals of the Legion##5581 |goto 25.81,68.22
step
Follow the path |goto 26.26,74.76 < 30 |only if walking
talk Uthek the Wise##5397
turnin Ongeku##1373 |goto 36.22,79.25
accept Khan Jehn##1374 |goto 36.22,79.25
step
Follow the path up |goto 44.19,70.30 < 20 |only if walking
Continue up the path |goto 45.69,70.94 < 15 |only if walking
Follow the path down |goto 46.23,69.30 < 15 |only if walking
Follow the path |goto 47.97,64.33 < 30 |only if walking
talk Hornizz Brimbuzzle##6019
accept Ghost-o-plasm Round Up##6134 |goto 47.83,61.82
step
Follow the path up |goto 51.15,55.38 < 15 |only if walking
talk Takata Steelblade##5641
accept The Corrupter##1488 |goto 52.57,54.38
step
Follow the path up |goto 64.47,48.73 < 20 |c |q 1383
step
path	follow loose;	loop;	ants curved
path	68.33,49.60		67.24,44.18		66.29,42.75		65.20,38.02
path	65.42,33.18		65.79,29.49		66.23,33.12		66.70,36.10
path	67.91,41.13		69.22,45.47
kill Deepstrider Giant##4686
|tip It looks like a huge green giant holding a large mallet.
|tip He walks in a counter-clockwise pattern, so this path will help you find him faster.
collect Deepstrider Tumor##6082	|q 1383/3
step
Follow the path |goto 67.77,64.14 < 30 |only if walking
kill Khan Jehn##5601
|tip He walks in and out of this tent.
collect Khan Jehn's Head##6072 |q 1374/1 |goto 66.39,80.08
step
Follow the path |goto 65.21,85.46 < 20 |only if walking
use the Crate of Ghost Magnets##15848
|tip Kill any nearby enemies before using it.
|tip Use it next to the huge bones on the ground around this area.
kill Magrami Spectre##11560+
|tip They continuously walk to the spinning green thing that appears on the ground.
collect 8 Ghost-o-plasm##15849 |q 6134/1 |goto 63.81,91.27
step
Follow the path |goto 62.04,91.13 < 20 |only if walking
click Demon Portal
kill Demon Portal Guardian##11937
Banish the Demon Portal |q 5581/1 |goto 53.17,84.03 |count 1
step
click Demon Portal
kill Demon Portal Guardian##11937
Banish the Demon Portal |q 5581/1 |goto 52.70,81.92 |count 2
step
click Demon Portal
kill Demon Portal Guardian##11937
Banish the Demon Portal |q 5581/1 |goto 51.48,81.09 |count 3
step
click Demon Portal
kill Demon Portal Guardian##11937
Banish the Demon Portal |q 5581/1 |goto 53.13,80.10 |count 4
step
click Demon Portal
kill Demon Portal Guardian##11937
Banish the Demon Portal |q 5581/1 |goto 53.90,79.14 |count 5
step
click Demon Portal
kill Demon Portal Guardian##11937
Banish the Demon Portal |q 5581/1 |goto 53.90,79.14 |count 6
stickystart "Kill_Lord_Azrethoc"
step
kill Jugkar Grim'rod##5771 |q 1488/2 |goto 55.91,77.76
step
label "Kill_Lord_Azrethoc"
kill Lord Azrethoc##5760 |q 1488/1 |goto 56.83,79.69
|tip He looks like a brown winged demon that walks around this area.
You can also find him around [56.80,73.68]
step
Follow the path up |goto 58.03,56.48 < 20 |only if walking
Cross the bridge |goto 54.72,55.08 < 15 |only if walking
talk Takata Steelblade##5641
turnin The Corrupter##1488 |goto 52.57,54.39
step
talk Hornizz Brimbuzzle##6019
turnin Ghost-o-plasm Round Up##6134 |goto 47.83,61.82
step
Follow the path up |goto 46.87,66.79 < 15 |only if walking
Follow the road |goto 42.45,77.50 < 30 |only if walking
talk Uthek the Wise##5397
turnin Khan Jehn##1374 |goto 36.23,79.25
step
Follow the path up |goto 26.42,75.09 < 20 |only if walking
talk Taiga Wisemane##11624
turnin Portals of the Legion##5581 |goto 25.81,68.22
step
Follow the path |goto Tanaris 51.26,26.51 < 15 |only if walking
talk Tran'rek##7876
turnin Tran'rek##2864 |goto Tanaris 51.57,26.76
step
click Wanted Poster
accept WANTED: Caliph Scorpidsting##2781 |goto 51.84,27.02
accept WANTED: Andre Firebeard##2875 |goto 51.84,27.02
step
Enter the building |goto 52.38,27.91 < 10 |walk
talk Innkeeper Fizzgrimble##7733
|tip Inside the building.
home Gadgetzan |goto 52.51,27.91
step
talk Spigot Operator Luglunket##7408
accept Water Pouch Bounty##1707 |goto 52.48,28.44
step
talk Chief Engineer Bilgewhizzle##7407
accept Wastewander Justice##1690 |goto 52.46,28.51
step
talk Senior Surveyor Fizzledowser##7724
accept Gadgetzan Water Survey##992 |goto 50.21,27.48
step
Follow the path up |goto 50.34,24.76 < 20 |only if walking
Follow the path down |goto 51.49,22.21 < 20 |only if walking
talk Kravel Koalbeard##4452
turnin Rumors for Kravel##1117 |goto Thousand Needles 77.79,77.27
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Back to Booty Bay##1118 |goto 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin News for Fizzle##1137 |goto 78.06,77.13
step
talk Razzeric##4706
turnin Razzeric's Tweaking##1187 |goto 80.33,76.10
accept Safety First##1188 |goto 80.33,76.10
step
talk Pozzik##4630
accept Keeping Pace##1190 |goto 80.18,75.88
step
talk Zamek##4709
|tip Click "Complete Quest" to complete "Zamek's Distraction".
Click Here After Completing Zamek's Distraction |confirm |goto 79.81,77.02 |q 1190
step
Enter the building |goto 77.52,77.60 < 10 |walk
click Rizzle's Unguarded Plans
|tip Inside the building.
turnin Keeping Pace##1190 |goto 77.22,77.42
accept Rizzle's Schematics##1194 |goto 77.22,77.42
step
Leave the building |goto 77.52,77.59 < 10 |walk
talk Pozzik##4630
turnin Rizzle's Schematics##1194 |goto 80.18,75.88
step
Follow the path up |goto 74.15,93.05 < 20 |only if walking
Follow the path down |goto Tanaris 51.44,22.32 < 20 |only if walking
Follow the path |goto Tanaris 51.26,26.48 < 15 |only if walking
talk Shreev##4708
turnin Safety First##1188 |goto Tanaris 50.96,27.24
stickystart "Kill_Wastewander_Bandits"
stickystart "Kill_Wastewander_Thives"
step
Follow the path |goto 51.55,29.02 < 15 |only if walking
Kill Wastewander enemies around this area
collect 5 Wastewander Water Pouch##8483 |q 1707/1 |goto 59.82,24.34
|tip These have a low drop rate.
You can find more around [63.51,30.31]
step
label "Kill_Wastewander_Bandits"
kill 10 Wastewander Bandit##5618 |q 1690/1 |goto 59.82,24.34
You can find more around [63.51,30.31]
step
label "Kill_Wastewander_Thives"
kill 10 Wastewander Thief##5616 |q 1690/2 |goto 59.82,24.34
You can find more around [63.51,30.31]
step
talk Haughty Modiste##15165
accept Pirate Hats Ahoy!##8365 |goto 66.56,22.27
step
talk Yeh'kinya##8579
accept Screecher Spirits##3520 |goto 66.99,22.36
step
Enter the building |goto 66.99,23.87 < 10 |walk
talk Security Chief Bilgewhizzle##7882
|tip Inside the building.
accept Southsea Shakedown##8366 |goto 67.06,23.89
step
talk Stoley##7881
|tip Inside the building.
turnin Stoley's Debt##2872 |goto 67.11,23.98
accept Stoley's Shipment##2873 |goto 67.11,23.98
step
path	follow loose;	loop;	ants curved
path	63.84,31.89		63.30,37.23		62.29,37.83		59.52,41.19
path	58.71,38.17		61.87,33.42
kill Caliph Scorpidsting##7847
|tip He walks in a counter-clockwise pattern, so this path will help you find him faster.
|tip He walks with 2 stealthed guards with him, so be careful.
collect Caliph Scorpidsting's Head##8723 |q 2781/1
stickystart "Collect_Southsea_Pirate_Hats"
stickystart "Kill_Southsea_Pirates"
stickystart "Kill_Southsea_Freebooters"
stickystart "Kill_Southsea_Dock_Workers"
stickystart "Kill_Southsea_Swashbucklers"
stickystart "Collect_Ship_Schedule"
step
Enter the tunnel |goto 68.62,41.45 < 15 |only if walking
Follow the path |goto 73.18,45.56 < 20 |only if walking
Enter the building |goto 72.61,46.82 < 10 |walk
click Stolen Cargo
|tip Upstairs inside the building.
collect Stoley's Shipment##9244 |q 2873/1 |goto 72.19,46.77
step
Leave the building |goto 72.61,46.82 < 10 |walk
kill Andre Firebeard##7883
|tip Kite him away from the other enemies, so you can fight him alone.
collect Firebeard's Head##9246 |q 2875/1 |goto 73.37,47.14
step
label "Collect_Southsea_Pirate_Hats"
Kill Southsea enemies around this area
collect 20 Southsea Pirate Hat##20519 |q 8365/1 |goto 73.26,46.42
You can find more around [72.29,44.64]
step
label "Kill_Southsea_Pirates"
kill 10 Southsea Pirate##7855 |q 8366/1 |goto 73.26,46.42
You can find more around [72.29,44.64]
step
label "Kill_Southsea_Freebooters"
kill 10 Southsea Freebooter##7856 |q 8366/2 |goto 73.26,46.42
You can find more around [72.29,44.64]
step
label "Kill_Southsea_Dock_Workers"
kill 10 Southsea Dock Worker##7857 |q 8366/3 |goto 73.76,47.42
|tip You can find more up on the wooden platforms nearby.
step
label "Kill_Southsea_Swashbucklers"
kill 10 Southsea Swashbuckler##7858 |q 8366/4 |goto 75.19,45.96
You can find more in the buildings around [72.96,47.07]
step
label "Collect_Ship_Schedule"
Kill Southsea enemies around this area
collect Pirate's Footlocker##9276 |n
|tip These have a low drop rate.
use Pirate's Footlocker##9276+
collect Ship Schedule##9250 |goto 73.26,46.42 |q 2876 |future
|tip This has a low drop rate inside the Pirate's Footlockers.
|tip It may take a while to get it, but you are about to have to grind to level 45 anyway.
You can find more around [72.29,44.64]
step
use the Ship Schedule##9250
accept Ship Schedules##2876
step
Kill enemies around this area
Reach Level 45 |ding 45 |goto 73.26,46.42
You can find more around [72.29,44.64]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (45-50)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (50-55)",
startlevel=45,
endlevel=50,
},[[
step
talk Spigot Operator Luglunket##7408
turnin Water Pouch Bounty##1878 |goto Tanaris 52.48,28.44
step
talk Chief Engineer Bilgewhizzle##7407
turnin Wastewander Justice##1690 |goto 52.46,28.51
accept More Wastewander Justice##1691 |goto 52.46,28.51
turnin WANTED: Caliph Scorpidsting##2781 |goto 52.46,28.51
step
Follow the path |goto 51.01,28.63 < 15 |only if walking
Avoid the nearby elite enemies |goto 40.25,31.70 < 30 |only if walking
use the Untapped Dowsing Widget##8584
|tip Use it in the water.
|tip Once you get the Tapped Dowsing Widget, run away to safety immediately.
|tip Multiple higher level enemies appear after using the item.
collect Tapped Dowsing Widget##8585 |q 992/1 |goto 39.09,29.17
step
Avoid the nearby elite enemies |goto 40.25,31.70 < 30 |only if walking
Follow the path up |goto 49.75,27.75 < 15 |only if walking
talk Senior Surveyor Fizzledowser##7724
turnin Gadgetzan Water Survey##992 |goto 50.21,27.48
step
Follow the path |goto 51.56,29.00 < 15 |only if walking
talk Haughty Modiste##15165
turnin Pirate Hats Ahoy!##8365 |goto 66.56,22.27
step
Enter the building |goto 66.99,23.87 < 10 |walk
talk Security Chief Bilgewhizzle##7882
|tip Inside the building.
turnin WANTED: Andre Firebeard##2875 |goto 67.06,23.89
turnin Ship Schedules##2876 |goto 67.06,23.89
turnin Southsea Shakedown##8366 |goto 67.06,23.89
step
talk Stoley##7881
|tip Inside the building.
turnin Stoley's Shipment##2873 |goto 67.11,23.97
accept Deliver to MacKinley##2874 |goto 67.11,23.97
stickystart "Kill_Wastewander_Assassins"
stickystart "Kill_Wastewander_Shadow_Mages"
step
kill 8 Wastewander Rogue##5615 |q 1691/1 |goto 60.87,32.74
|tip They are stealthed around this area.
You can find more around: |notinsticky
[61.84,34.67]
[59.99,37.02]
[58.85,36.63]
[58.81,39.22]
[60.52,39.06]
[63.40,37.65]
[64.43,39.57]
[65.32,36.89]
step
label "Kill_Wastewander_Assassins"
kill 6 Wastewander Assassin##5623 |q 1691/2 |goto 60.87,32.74
You can find more around: |notinsticky
[61.84,34.67]
[59.99,37.02]
[58.85,36.63]
[58.81,39.22]
[60.52,39.06]
[63.40,37.65]
[64.43,39.57]
[65.32,36.89]
step
label "Kill_Wastewander_Shadow_Mages"
kill 10 Wastewander Shadow Mage##5617 |q 1691/3 |goto 60.87,32.74
You can find more around: |notinsticky
[61.84,34.67]
[59.99,37.02]
[58.85,36.63]
[58.81,39.22]
[60.52,39.06]
[63.40,37.65]
[64.43,39.57]
[65.32,36.89]
step
Follow the path |goto 51.54,29.02 < 15 |only if walking
talk Chief Engineer Bilgewhizzle##7407
turnin More Wastewander Justice##1691 |goto 52.46,28.51
step
Follow the path |goto 51.87,26.54 < 15 |only if walking
Ride the elevator down |goto Thousand Needles 46.63,48.35 < 10 |only if walking
Follow the road |goto Thousand Needles 43.00,47.09 < 30 |only if walking
Continue following the road |goto Thousand Needles 29.06,33.81 < 30 |only if walking
Follow the road up |goto Thousand Needles 7.58,10.54 < 20 |only if walking
Continue following the road |goto Feralas 84.59,41.75 < 30 |only if walking
Follow the path |goto Feralas 76.69,43.24 < 20 |only if walking
talk Krueg Skullsplitter##4544
accept A New Cloak's Sheen##2973 |goto 75.94,42.74
step
talk Rok Orhan##7777
|tip She walks around this area wearing red armor.
accept The Ogres of Feralas##2980 |goto 76.01,43.51
step
talk Orwin Gizzmick##8021
accept Gordunni Cobalt##2987 |goto 75.70,44.30
step
talk Shyn##8020
fpath Camp Mojache |goto 75.45,44.36
step
talk Hadoken Swiftstrider##7875
accept War on the Woodpaw##2862 |goto 74.91,42.47
step
Enter the building |goto 74.69,43.00 < 10 |walk
talk Jangdor Swiftstrider##7854
|tip Inside the building.
accept The Mark of Quality##2822 |goto 74.43,42.91
step
Leave the building |goto 74.69,43.00 < 7 |walk
talk Witch Doctor Uzer'i##8115
accept A Strange Request##3121 |goto 74.42,43.36
step
Enter the building |goto 74.63,44.69 < 15 |walk
talk Innkeeper Greul##7737
home Camp Mojache |goto 74.80,45.18
stickystart "Collect_Gordunni_Cobalt"
stickystart "Kill_Gordunni_Ogres"
stickystart "Kill_Gordunni_Ogre_Mages"
stickystart "Kill_Gordunni_Brutes"
step
Leave the building |goto 74.64,44.69 < 10 |walk
Follow the path |goto 78.46,42.32 < 30 |only if walking
Follow the path up |goto 74.89,35.26 < 15 |only if walking
Follow the path |goto 76.29,32.90 < 15 |only if walking
click Gordunni Scroll
collect Gordunni Scroll##9370 |goto 75.13,29.73 |q 2978 |future
step
use the Gordunni Scroll##9370
accept The Gordunni Scroll##2978
step
label "Collect_Gordunni_Cobalt"
Follow the path |goto 76.50,30.97 < 20 |only if walking
use Orwin's Shovel##9466
|tip Use it next to glowing blue circles on the ground around this area.
click Gordunni Dirt Mound+
|tip They look like piles of dirt that appear on the ground after using Orwin's Shovel.
|tip The dirt mounds will glow blue if they contain the quest item.
collect 12 Gordunni Cobalt##9463 |q 2987/1 |goto 75.74,33.79
You can find more further along the paths that start at:
[76.00,34.20]
[76.30,33.02]
step
label "Kill_Gordunni_Ogres"
kill 10 Gordunni Ogre##5229 |q 2975/1 |goto 75.74,33.79
You can find more further along the paths that start at:
[76.00,34.20]
[76.30,33.02]
step
label "Kill_Gordunni_Ogre_Mages"
kill 10 Gordunni Ogre Mage##5237 |q 2975/2 |goto 75.74,33.79
You can find more further along the paths that start at:
[76.00,34.20]
[76.30,33.02]
step
label "Kill_Gordunni_Brutes"
kill 5 Gordunni Brute##5232 |q 2975/3 |goto 75.74,33.79
You can find more further along the paths that start at:
[76.00,34.20]
[76.30,33.02]
step
Kill Woodpaw enemies around this area
collect 10 Woodpaw Gnoll Mane##9237 |q 2862/1 |goto 72.68,36.94
You can find more around [72.71,39.53]
step
kill Sprite Darter##5278+
collect 10 Iridescent Sprite Darter Wing##9369 |q 2973/1 |goto 70.01,47.07
You can find more around: |notinsticky
[67.77,47.94]
[66.20,47.56]
[64.37,48.63]
step
Follow the road |goto 71.13,48.70 < 30 |only if walking
talk Hadoken Swiftstrider##7875
turnin War on the Woodpaw##2862 |goto 74.91,42.47
accept Alpha Strike##2863 |goto 74.91,42.47
step
talk Orwin Gizzmick##8021
turnin Gordunni Cobalt##2987 |goto 75.70,44.31
step
talk Krueg Skullsplitter##4544
turnin A New Cloak's Sheen##2973 |goto 75.94,42.74
accept A Grim Discovery##2974 |goto 75.94,42.74
step
talk Rok Orhan##7777
|tip She walks around this area wearing red armor.
turnin The Ogres of Feralas##2975 |goto 76.01,43.51
accept The Ogres of Feralas##2980 |goto 76.01,43.51
turnin The Gordunni Scroll##2978 |goto 76.01,43.51
accept Dark Ceremony##2979 |goto 76.01,43.51
step
Follow the road |goto 74.36,44.16 < 20 |only if walking
Jump down here |goto 72.73,48.58 < 20 |only if walking
kill Woodpaw Alpha##5258 |q 2863/1 |goto 74.34,54.96 |count 1
|tip There should be a Woodpaw Alpha in this small camp.
step
kill Woodpaw Alpha##5258 |q 2863/1 |goto 75.48,56.48 |count 2
|tip There should be a Woodpaw Alpha in this small camp.
step
kill Woodpaw Alpha##5258 |q 2863/1 |goto 73.27,56.17 |count 3
|tip There should be a Woodpaw Alpha in this small camp.
step
kill Woodpaw Alpha##5258 |q 2863/1 |goto 72.40,56.55 |count 4
|tip There should be a Woodpaw Alpha in this small camp.
step
kill Woodpaw Alpha##5258 |q 2863/1 |goto 71.42,55.92 |count 5
|tip There should be a Woodpaw Alpha in this small camp.
step
Follow the road |goto 70.37,49.04 < 30 |only if walking
talk Hadoken Swiftstrider##7875
turnin Alpha Strike##2863 |goto 74.91,42.46
accept Woodpaw Investigation##2902 |goto 74.91,42.46
step
Follow the road |goto 74.34,44.25 < 20 |only if walking
Follow the path |goto 71.29,48.83 < 30 |only if walking
click Woodpaw Battle Map
turnin Woodpaw Investigation##2902 |goto 71.63,55.92
accept The Battle Plans##2903 |goto 71.63,55.92
step
Kill Grimtotem enemies around this area
collect 20 Grimtotem Horn##9460 |q 2974/1 |goto 67.85,46.40
You can find more around [69.66,39.93]
step
Kill enemies around this area
Reach Level 46 |ding 46 |goto 67.85,46.40
You can find more around [69.66,39.93]
step
Leave the building |goto 74.65,44.72 < 10 |walk
talk Hadoken Swiftstrider##7875
turnin The Battle Plans##2903 |goto 74.91,42.47
accept Zukk'ash Infestation##7730 |goto 74.91,42.47
accept Stinglasher##7731 |goto 74.91,42.47
step
talk Krueg Skullsplitter##4544
turnin A Grim Discovery##2974 |goto 75.94,42.74
stickystart "Collect_Zukkash_Carapaces"
step
Follow the road |goto 74.33,44.20 < 20 |only if walking
Jump down here |goto 72.71,48.64 < 20 |only if walking
Follow the path down |goto 75.70,60.82 < 20 |only if walking
kill Stinglasher##14661
|tip He looks like a flying green bug, flying around this area, with a small green cloud below him.
|tip He sometimes temporarily goes inside the bug caves around this area, but most of the time he's outside.
collect Stinglasher's Glands##18962 |q 7731/1 |goto 76.98,61.55
He can also be around [73.73,63.06]
step
label "Collect_Zukkash_Carapaces"
Kill Zukk'ash enemies around this area
|tip You can find more inside the bug caves around this area.
collect 20 Zukk'ash Carapace##18961 |q 7730/1 |goto 74.55,62.08
step
Follow the road |goto 70.06,49.23 < 30 |only if walking
Cross the bridge |goto 63.74,51.16 < 20 |only if walking
kill Rogue Vale Screecher##5308+
use Yeh'kinya's Bramble##10699
|tip Use it on their corpses.
talk Screecher Spirit##8612+
|tip They appear after using Yeh'kinya's Bramble on the corpses.
Collect #3# Screecher Spirits |q 3520/1 |goto 60.77,49.94
You can find more around: |notinsticky
[58.94,51.11]
[56.89,47.94]
[55.67,46.84]
[53.22,46.90]
[52.27,49.13]
stickystart "Kill_Gordunni_Warlocks"
step
kill 5 Gordunni Mauler##5234 |q 2980/3 |goto 61.00,55.61
You can find more around [60.77,57.89]
stickystart "Kill_Gordunni_Shamans"
step
kill Gordunni Mage-Lord##5239+
collect Gordunni Orb##9371 |q 2979/1 |goto 59.67,66.85
step
label "Kill_Gordunni_Shamans"
kill 10 Gordunni Shaman##5236 |q 2980/1 |goto 59.67,66.85
step
label "Kill_Gordunni_Warlocks"
kill 10 Gordunni Warlock##5240 |q 2980/2 |goto 59.22,64.15
You can find more around [61.03,55.64]
stickystart "Collect_Thick_Yeti_Hides"
step
kill Feral Scar Yeti##5292+
collect OOX-22/FE Distress Beacon##8705 |goto 56.20,57.02 |q 2766 |future
|tip This has a low drop rate.
You can find more through the tunnel at [55.14,56.36]
step
use the OOX-22/FE Distress Beacon##8705
accept Find OOX-22/FE!##2766
step
Enter the tunnel |goto 55.15,56.36 < 15 |only if walking
Leave the tunnel |goto 53.87,55.60 < 15 |only if walking
talk Homing Robot OOX-22/FE##7807
turnin Find OOX-22/FE!##2766 |goto 53.35,55.70
step
label "Collect_Thick_Yeti_Hides"
Enter the tunnel |goto 53.89,55.61 < 15 |only if walking
Leave the tunnel |goto 55.16,56.36 < 15 |only if walking
Kill Feral Scar Yeti##5292+
collect 10 Thick Yeti Hide##8973 |q 2822/1 |goto 56.20,57.02
You can find more through the tunnel at [55.14,56.36]
step
Follow the road |goto 55.82,51.37 < 30 |only if walking
Cross the bridge |goto 63.40,52.45 < 20 |only if walking
Follow the road |goto 64.60,50.09 < 20 |only if walking
Enter the building |goto 74.69,43.00 < 10 |walk
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin The Mark of Quality##2821 |goto 74.43,42.91
step
Leave the building |goto 74.70,43.00 < 7 |walk
talk Hadoken Swiftstrider##7875
turnin Zukk'ash Infestation##7730 |goto 74.91,42.47
turnin Stinglasher##7731 |goto 74.91,42.47
accept Zukk'ash Report##7732 |goto 74.91,42.47
step
talk Rok Orhan##7777
|tip She walks around this area wearing red armor.
turnin Dark Ceremony##2979 |goto 76.01,43.51
accept The Gordunni Orb##3002 |goto 76.01,43.51
turnin The Ogres of Feralas##2980 |goto 76.01,43.51
step
Follow the path |goto Orgrimmar 51.65,57.92 < 20 |only if walking
Run up the stairs |goto Orgrimmar 56.33,56.94 < 15 |only if walking
Enter the building |goto Orgrimmar 57.05,45.87 < 10 |walk
talk Zilzibin Drumlore##7010
|tip Inside the building.
turnin Zukk'ash Report##7732 |goto Orgrimmar 56.28,46.67
step
Leave the building |goto 57.01,45.92 < 7 |walk
Enter the building |goto 58.91,37.66 < 15 |walk
talk Dran Droffers##6986
|tip Inside the building.
accept Ripple Recovery##649 |goto 59.48,36.59
step
talk Malton Droffers##6987
|tip Inside the building.
turnin Ripple Recovery##649 |goto 59.64,36.92
accept Ripple Recovery##650 |goto 59.64,36.92
step
Follow the path |goto 62.79,38.89 < 15 |only if walking
talk Belgrom Rockmaul##4485
turnin Parts of the Swarm##1184 |goto 75.23,34.24
turnin A Grim Discovery##2976 |goto 75.23,34.24
accept Betrayed##3504 |goto 75.23,34.24
step
Follow the path |goto 67.54,39.18 < 15 |only if walking
Follow the path down |goto 55.21,40.69 < 20 |only if walking
talk Neeru Fireblade##3216
|tip Inside the tent.
turnin A Strange Request##3121 |goto 49.47,50.59
accept Return to Witch Doctor Uzer'i##3122 |goto 49.47,50.59
step
Follow the path up |goto 43.92,56.88 < 15 |only if walking
Follow the path |goto 39.42,50.16 < 20 |only if walking
Run up the ramp |goto 42.27,36.80 < 15 |only if walking
Enter the building |goto 40.27,36.98 < 15 |walk
talk Zor Lonetree##4047
|tip Inside the building.
turnin Report to Zor##1262 |goto 38.93,38.38
accept Service to the Horde##7541 |goto 38.93,38.38
step
Leave the building |goto 40.34,36.93 < 15 |walk
Follow the path |goto 38.10,55.11 < 20 |only if walking
Continue following the path |goto 42.10,67.67 < 20 |only if walking
Enter the building |goto 38.73,83.29 < 15 |walk
talk Uthel'nay##7311
|tip Inside the building.
turnin The Gordunni Orb##3002 |goto 39.16,86.24
step
Leave the building |goto Feralas 74.65,44.72 < 10 |walk
talk Witch Doctor Uzer'i##8115
turnin Return to Witch Doctor Uzer'i##3122 |goto Feralas 74.42,43.36
step
Watch the dialogue
talk Witch Doctor Uzer'i##8115
accept Testing the Vessel##3123 |goto 74.42,43.36
accept Natural Materials##3128 |goto 74.42,43.36
step
Follow the road |goto 74.30,44.42 < 30 |only if walking
kill Sprite Darter##5278+
collect 6 Encrusted Minerals##9589 |q 3128/2 |goto 70.01,47.07
You can find more around: |notinsticky
[67.77,47.94]
[66.20,47.56]
[64.37,48.63]
stickystart "Collect_Splintered_Logs"
stickystart "Collect_Resilient_Sinew"
stickystart "Collect_Metallic_Fragments"
stickystart "Collect_Long_Elegant_Feathers"
step
Follow the road |goto 69.46,49.41 < 20 |only if walking
Cross the bridge |goto 63.73,51.15 < 20 |only if walking
Follow the path |goto 59.34,53.65 < 30 |only if walking
Follow the path up |goto 54.10,68.24 < 30 |only if walking
Follow the path up |goto 57.33,75.52 < 15 |only if walking
click Hippogryph Egg
collect Hippogryph Egg##8564 |goto 56.66,75.90 |q 2741 |future
|tip You will use this for a future quest.
|tip Be careful not to accidentally sell this to a vendor.
step
label "Collect_Splintered_Logs"
kill Wandering Forest Walker##7584+
|tip They look like walking trees.
|tip They walk around this area, so kill enemies around this spot, and wait for it to come here.
|tip There is only one spawned at a time, so you will have to wait for it to respawn after you kill one.
collect 2 Splintered Log##9590 |q 3128/1 |goto 57.40,73.34
step
label "Collect_Resilient_Sinew"
Kill Frayfeather enemies around this area
collect 20 Resilient Sinew##9591 |q 3128/3 |goto 54.53,72.54
You can find more around [55.80,63.09]
step
label "Collect_Metallic_Fragments"
Kill Frayfeather enemies around this area
collect 40 Metallic Fragments##9592 |q 3128/4 |goto 54.53,72.54
You can find more around [55.80,63.09]
step
label "Collect_Long_Elegant_Feathers"
kill Frayfeather Hippogryph##5300+
|tip The other types of Frayfeather enemies will not drop the quest item.
collect 10 Long Elegant Feather##4589 |goto 56.04,62.91 |q 7842 |future
|tip Be careful not to accidentally sell these to a vendor.
step
Kill enemies around this area
Reach Level 47 |ding 47 |goto 55.80,63.09
You can find more around [54.53,72.54]
step
Leave the building |goto 74.65,44.71 < 10 |walk
talk Witch Doctor Uzer'i##8115
turnin Natural Materials##3128 |goto 74.42,43.36
step
Follow the path |goto Ashenvale 73.53,63.54 < 15 |only if walking
Follow the road |goto Ashenvale 75.04,65.16 < 30 |only if walking
Cross the bridge |goto Ashenvale 94.74,47.78 < 20 |only if walking
talk Loh'atu##11548
accept Spiritual Unrest##5535 |goto Azshara 11.37,78.16
accept A Land Filled with Hatred##5536 |goto Azshara 11.37,78.16
stickystart "Kill_Highborne_Lichlings"
step
Follow the path up |goto 13.45,73.32 < 20 |only if walking
kill 6 Highborne Apparition##6116 |q 5535/1 |goto 14.66,72.47
You can find more around [17.21,68.82]
step
label "Kill_Highborne_Lichlings"
kill 6 Highborne Lichling##6117 |q 5535/2 |goto 17.21,68.82
You can find more around [14.66,72.47]
stickystart "Kill_Haldarr_Trickster"
stickystart "Kill_Haldarr_Felsworns"
step
Follow the path up |goto 19.36,62.52 < 20 |only if walking
kill 6 Haldarr Satyr##6125 |q 5536/1 |goto 19.82,61.38
step
label "Kill_Haldarr_Trickster"
kill 2 Haldarr Trickster##6126 |q 5536/2 |goto 19.82,61.38
step
label "Kill_Haldarr_Felsworns"
kill 2 Haldarr Felsworn##6127 |q 5536/3 |goto 19.82,61.38
step
Follow the road |goto 16.24,75.25 < 30 |only if walking
talk Loh'atu##11548
turnin Spiritual Unrest##5535 |goto 11.37,78.17
turnin A Land Filled with Hatred##5536 |goto 11.37,78.17
step
Follow the path |goto 16.45,74.82 < 30 |only if walking
Follow the path |goto 19.04,53.16 < 30 |only if walking
talk Ag'tor Bloodfist##8576
turnin Betrayed##3504 |goto 22.26,51.48
step
talk Kroum##8610
fpath Valormok |goto 21.96,49.62
step
Follow the path |goto Orgrimmar 52.56,85.15 < 20 |only if walking
Leave Orgrimmar |goto Orgrimmar 49.13,94.82 < 20 |only if walking
Enter Undercity |goto Tirisfal Glades 61.87,65.06 < 15 |only if walking
talk Oran Snakewrithe##7825
accept Lines of Communication##2995 |goto Undercity 73.06,32.85
step
Follow the path down |goto 52.86,77.57 < 10 |walk
talk Chemist Cuely##8390
accept Seeping Corruption##3568 |goto 48.71,71.42
step
talk Apothecary Zinge##5204
accept Errand for Apothecary Zinge##232 |goto 50.13,67.99
step
Follow the path up |goto 47.90,76.49 < 10 |walk
Follow the path |goto 52.84,77.65 < 10 |walk
talk Alessandro Luca##7683
turnin Errand for Apothecary Zinge##232 |goto 58.62,54.67
accept Errand for Apothecary Zinge##238 |goto 58.62,54.67
step
Follow the path down |goto 52.86,77.57 < 10 |walk
talk Apothecary Zinge##5204
turnin Errand for Apothecary Zinge##238 |goto 50.13,67.99
accept Into the Field##243 |goto 50.13,67.99
step
Follow the path up |goto 47.90,76.49 < 10 |walk
Follow the path |goto 52.84,77.65 < 10 |walk
Enter the building |goto Hillsbrad Foothills 62.51,19.63 < 10 |walk
talk Innkeeper Shay##2388
|tip Inside the building.
home Tarren Mill |goto Hillsbrad Foothills 62.78,19.03
step
Leave the building |goto 62.51,19.63 < 10 |walk
Follow the path up |goto 74.29,23.08 < 20 |only if walking
Follow the path into the Hinterlands |goto 83.90,32.47 < 30 |only if walking
Follow the path up |goto The Hinterlands 20.80,47.91 < 20 |only if walking
talk Gilveradin Sunchaser##7801
turnin Ripple Recovery##650 |goto The Hinterlands 26.71,48.59
accept A Sticky Situation##77 |goto The Hinterlands 26.71,48.59
step
Jump down here |goto 28.01,48.01 < 15 |only if walking
Follow the road |goto 50.08,44.02 < 30 |only if walking
Follow the path down |goto 72.48,66.10 < 20 |only if walking
Jump down here |goto 74.77,63.47 < 20 |only if walking
Follow the path |goto 76.97,77.54 < 30 |only if walking
talk Smith Slagtree##14737
|tip He walks around this area.
accept Vilebranch Hooligans##7839 |goto 77.23,80.12
step
talk Mystic Yayo'jin##14739
|tip She walks around inside the building.
accept Cannibalistic Cousins##7844 |goto 78.80,78.24
step
talk Otho Moji'ko##14738
|tip Inside the building.
accept Message to the Wildhammer##7841 |goto 79.40,79.09
step
talk Huntsman Markhor##14741
accept Stalking the Stalkers##7828 |goto 79.16,79.52
accept Hunt the Savages##7829 |goto 79.16,79.52
accept Avenging the Fallen##7830 |goto 79.16,79.52
step
talk Gorkas##4314
fpath Revantusk Village |goto 81.70,81.76
stickystart "Collect_OOX09HL_Distress_Beacon"
step
Follow the path |goto 76.94,77.49 < 30 |only if walking
Follow the path up |goto 76.47,61.10 < 20 |only if walking
Continue up the path |goto 72.24,66.14 < 20 |only if walking
kill 10 Silvermane Stalker##2926 |q 7828/1 |goto 69.37,59.11
|tip They can be stealthed around this area.
You can find more around: |notinsticky
[73.24,56.13]
[76.40,50.71]
[67.43,50.01]
[63.14,49.58]
stickystart "Collect_Wildkin_Muisek"
stickystart "Kill_Savage_Owlbeasts"
stickystart "Kill_Vilebranch_Scalpers"
stickystart "Kill_Vilebranch_Soothsayers"
step
click Slagtree's Lost Tools
|tip It looks like a small silver metal bucket with tools in it.
|tip It can be in five different locations.
collect Slagtree's Lost Tools##19033 |q 7839/1 |goto 72.6, 53.0
It can also spawn at:
[71.0, 48.6]
[66.4, 44.7]
On top of the hill at [57.40,42.55]
[53.3, 38.8]
stickystart "Collect_Skylord_Plume"
step
label "Collect_Wildkin_Muisek"
kill Savage Owlbeast##2929+
|tip They are pretty spread out all around the eastern side of the Hinterlands.
use the Wildkin Muisek Vessel##9618
|tip Use it on their corpses.
collect 10 Wildkin Muisek##9594 |q 3123/1 |goto 62.58,40.86
You can find more around: |notinsticky
[61.52,41.91]
[61.68,44.29]
[60.92,46.42]
[56.16,46.07]
[53.05,48.90]
[55.80,51.57]
[60.39,54.06]
[65.74,57.99]
step
label "Kill_Savage_Owlbeasts"
kill 20 Savage Owlbeast##2929 |q 7829/1 |goto 62.58,40.86
|tip They are pretty spread out all around the eastern side of the Hinterlands.
You can find more around: |notinsticky
[61.52,41.91]
[61.68,44.29]
[60.92,46.42]
[56.16,46.07]
[53.05,48.90]
[55.80,51.57]
[60.39,54.06]
[65.74,57.99]
step
label "Collect_Skylord_Plume"
kill Razorbeak Skylord##2659+
|tip They look like flying eagle beasts.
|tip There are on two in the zone.
|tip One of them flies low to the ground around this area.
collect Skylord Plume##19025 |q 7830/1 |goto 63.82,51.93
You can find the other one around [52.98,51.68]
stickystop "Kill_Vilebranch_Scalpers"
stickystop "Kill_Vilebranch_Soothsayers"
step
Enter the cave |goto 57.46,38.88 < 15 |walk
click Horde Supply Crate+
|tip They look like brown wooden boxes on the ground inside the cave.
collect 10 Hinterlands Honey Ripple##8684 |q 77/1 |goto 57.36,41.68
step
label "Collect_OOX09HL_Distress_Beacon"
Kill enemies around this area
collect OOX-09/HL Distress Beacon##8704 |goto 57.36,41.68 |q 485 |future
step
use the OOX-09/HL Distress Beacon##8704
accept Find OOX-09/HL!##485
step
Leave the cave |goto 57.43,38.82 < 15 |walk
talk Homing Robot OOX-09/HL##7806
turnin Find OOX-09/HL!##485 |goto 49.35,37.66
stickystart "Kill_Vilebranch_Scalpers"
stickystart "Kill_Vilebranch_Soothsayers"
step
Follow the path |goto 46.98,46.73 < 30 |only if walking
kill 10 Silvermane Howler##2925 |q 7828/2 |goto 49.43,58.50
You can find more around: |notinsticky
[46.93,59.87]
[43.32,61.80]
step
label "Kill_Vilebranch_Scalpers"
kill 15 Vilebranch Scalper##4466 |q 7844/1 |goto 47.53,66.44
You can find more around: |notinsticky
[65.40,44.84]
[70.49,48.38]
step
label "Kill_Vilebranch_Soothsayers"
kill 10 Vilebranch Soothsayer##4467 |q 7844/2 |goto 47.53,66.44
You can find more around: |notinsticky
[65.40,44.84]
[70.49,48.38]
stickystart "Collect_Witherbark_Skulls"
step
click Venom Bottle
accept Venom Bottles##2933 |goto 31.55,57.76
step
label "Collect_Witherbark_Skulls"
Kill Witherbark enemies around this area
collect 20 Witherbark Skull##9320 |goto 23.29,58.10 |q 2932
You can find more around [32.58,57.96]
step
use Nimboya's Pike##15002
collect Nimboya's Laden Pike##9319 |q 2932
step
use Nimboya's Laden Pike##9319
Place the Grim Message |q 2932/1 |goto 31.97,57.98
stickystart "Kill_Highvale_Scouts"
stickystart "Kill_Highvale_Outrunners"
stickystart "Kill_Highvale_Rangers"
stickystart "Kill_Highvale_Marksmen"
step
Enter the building |goto 31.42,48.68 < 15 |walk
click Highvale Records
|tip Inside the building.
Burn the Highvale Records |q 2995/1 |goto 31.98,46.83
step
talk Rin'ji##7780
|tip Inside the building.
accept Rin'ji is Trapped!##2742 |goto 30.73,46.97
step
Watch the dialogue
|tip Follow and protect Rin'ji as he walks.
|tip You will be attacked by two groups of enemies along the way.
|tip He eventually walks to this location.
Escort Rin'ji to Safety |q 2742/1 |goto 34.64,56.38
step
click Highvale Notes
Burn the Highvale Notes |q 2995/2 |goto 29.63,48.66
step
click Highvale Report
Burn the Highvale Report |q 2995/3 |goto 28.56,46.05
step
label "Kill_Highvale_Scouts"
kill 15 Highvale Scout##2692 |q 7841/1 |goto 31.74,49.40
|tip You can find more around this area, surrounding this building.
step
label "Kill_Highvale_Outrunners"
kill 15 Highvale Outrunner##2691 |q 7841/2 |goto 31.74,49.40
|tip You can find more around this area, surrounding this building.
step
label "Kill_Highvale_Rangers"
kill 15 Highvale Ranger##2694 |q 7841/3
|tip You can find more around this area, surrounding this building.
step
label "Kill_Highvale_Marksmen"
kill 15 Highvale Marksman##2693 |q 7841/4
|tip You can find more around this area, surrounding this building.
step
Follow the path |goto 27.98,53.58 < 30 |only if walking
Follow the path up |goto 20.44,48.08 < 20 |only if walking
talk Gilveradin Sunchaser##7801
turnin A Sticky Situation##77 |goto 26.71,48.59
accept Ripple Delivery##81 |goto 26.71,48.59
step
Jump down here |goto 28.01,48.01 < 15 |only if walking
Follow the road |goto 50.08,44.02 < 30 |only if walking
Follow the path down |goto 72.48,66.10 < 20 |only if walking
click Rin'ji's Secret
turnin Rin'ji is Trapped!##2742 |goto 86.30,59.01
accept Rin'ji's Secret##2782 |goto 86.30,59.01
step
Follow the path |goto 76.96,77.41 < 30 |only if walking
talk Smith Slagtree##14737
|tip He walks around this area.
turnin Vilebranch Hooligans##7839 |goto 77.24,80.12
step
talk Mystic Yayo'jin##14739
|tip She walks around inside the building.
turnin Cannibalistic Cousins##7844 |goto 78.80,78.25
step
talk Otho Moji'ko##14738
|tip Inside the building.
turnin Message to the Wildhammer##7841 |goto 79.40,79.08
accept Another Message to the Wildhammer##7842 |goto 79.40,79.08
step
talk Otho Moji'ko##14738
|tip Inside the building.
turnin Another Message to the Wildhammer##7842 |goto 79.40,79.08
step
talk Huntsman Markhor##14741
turnin Stalking the Stalkers##7828 |goto 79.16,79.53
turnin Hunt the Savages##7829 |goto 79.16,79.53
turnin Avenging the Fallen##7830 |goto 79.16,79.53
step
Kill enemies around this area
Reach Level 48 |ding 48 |goto 76.03,70.28
step
Save your hearthstone, fly to Tarren Mill, then enter the building |goto Hillsbrad Foothills 61.50,19.45 < 10 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Venom Bottles##2933 |goto Hillsbrad Foothills 61.44,19.06
accept Undamaged Venom Sac##2934 |goto Hillsbrad Foothills 61.44,19.06
stickystart "Collect_Undamaged_Venom_Sac"
step
Follow the path up |goto 74.29,23.08 < 20 |only if walking
Follow the path into the Hinterlands |goto 83.90,32.47 < 30 |only if walking
Follow the path |goto The Hinterlands 14.36,53.04 < 40 |only if walking
Continue following the path |goto The Hinterlands 29.60,62.67 < 30 |only if walking
Follow the path down |goto The Hinterlands 35.81,63.99 < 20 |only if walking
Follow the path up |goto The Hinterlands 33.50,74.12 < 10 |only if walking
Jump down here |goto The Hinterlands 33.20,74.97 < 10 |only if walking
talk Atal'ai Exile##5598
|tip Standing on a ledge on the side of the building.
turnin The Atal'ai Exile##1429 |goto The Hinterlands 33.75,75.21
accept Return to Fel'Zerul##1444 |goto The Hinterlands 33.75,75.21
step
label "Collect_Undamaged_Venom_Sac"
kill Witherbark Broodguard##2686+
collect Undamaged Venom Sac##9322 |q 2934/1 |goto 34.38,72.92
|tip This has a low drop rate.
step
Leave the building |goto Hillsbrad Foothills 62.51,19.63 < 10 |walk
Enter the building |goto Hillsbrad Foothills 61.50,19.45 < 10 |walk
talk Apothecary Lydon##2216
|tip Inside the building.
turnin Undamaged Venom Sac##2934 |goto Hillsbrad Foothills 61.44,19.07
step
talk Oran Snakewrithe##7825
turnin Rin'ji's Secret##2782 |goto Undercity 73.07,32.85
turnin Lines of Communication##2995 |goto Undercity 73.07,32.85
accept Oran's Gratitude##8273 |goto Undercity 73.07,32.85
step
Leave Undercity |goto 66.27,0.29 < 15 |only if walking
talk Nimboya##2497
turnin Grim Message##2932 |goto Stranglethorn Vale 32.16,27.73
step
Follow the path |goto 32.78,28.75 < 15 |only if walking
kill Tethis##730
|tip He looks like a blue raptor that walks around this area.
collect Talon of Tethis##3877 |q 197/1 |goto 32.22,40.89
You can also find him around:
[31.17,43.40]
[28.74,44.84]
step
Follow the path |goto 32.79,40.42 < 40 |only if walking
Follow the road |goto 38.54,23.33 < 30 |only if walking
talk Hemet Nesingwary##715
turnin Raptor Mastery##197 |goto 35.66,10.81
step
talk Sir S. J. Erlgadin##718
accept Panther Mastery##193 |goto 35.55,10.55
step
Follow the road |goto 35.52,15.35 < 30 |only if walking
Follow the path up |goto 45.77,28.58 < 20 |only if walking
kill Bhag'thera##728
|tip He looks like an unstealthed black panther.
|tip He can spawn in multiple locations.
collect Fang of Bhag'thera##3876 |q 193/1 |goto 46.37,29.05
|tip
Cross this tree bridge to get to the other locations: [48.92,28.04]
|tip
You can also find him around:
[49.60,24.03]
[48.99,20.20]
step
Follow the road |goto 42.90,24.51 < 30 |only if walking
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##193 |goto 35.55,10.55
step
talk Hemet Nesingwary##715
accept Big Game Hunter##208 |goto 35.66,10.81
step
Follow the road |goto 35.52,15.35 < 30 |only if walking
Follow the path up |goto 39.32,34.56 < 30 |only if walking
kill King Bangalash##731
|tip He looks like a white tiger that walks around this area.
collect Head of Bangalash##3880 |q 208/1 |goto 38.21,35.57
step
Follow the road |goto 41.34,30.57 < 30 |only if walking
talk Hemet Nesingwary##715
turnin Big Game Hunter##208 |goto 35.66,10.81
step
Follow the road |goto 35.52,15.35 < 30 |only if walking
Follow the path |goto 38.49,23.56 < 30 |only if walking
Follow the path |goto 32.80,28.74 < 15 |only if walking
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
accept The Bloodsail Buccaneers##608 |goto 27.17,77.00
step
talk Innkeeper Skindle##6807
|tip Inside the building.
home Booty Bay |goto 27.04,77.31
step
talk Crank Fizzlebub##2498
|tip Inside the building.
turnin Back to Booty Bay##1118 |goto 27.12,77.21
step
Leave the building |goto 27.08,77.62 < 7 |walk
Enter the building |goto 27.64,77.09 < 7 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Deliver to MacKinley##2874 |goto 27.78,77.07
step
Leave the building |goto 27.64,77.08 < 7 |walk
Enter the tunnel |goto 27.93,73.66 < 15 |only if walking
Leave the tunnel |goto 29.57,72.48 < 15 |only if walking
Follow the path |goto 31.58,72.33 < 30 |only if walking
click Half-Buried Bottle+
|tip They look like tiny green glass bottles on the ground along the shores around this area.
|tip You will likely have to click at least a few of them until you find the quest item.
|tip They can also be underwater.
|tip They may not be at every location.
collect Carefully Folded Note##4098 |goto 34.29,73.77 |q 594 |future
You can find more around: |notinsticky
[34.0,76.8]
[33.8,77.7]
[36.1,80.5]
[36.56,77.08]
[37.79,76.88]
[39.73,77.42]
[36.26,70.56]
[37.41,64.50]
[38.1,63.5]
[38.81,60.32]
[40.18,60.20]
step
use the Carefully Folded Note##4098
accept Message in a Bottle##594
step
talk Princess Poobah##2634
turnin Message in a Bottle##594 |goto 38.53,80.58
step
Run up the ramp |goto 33.66,87.48 < 10 |only if walking
Follow the path down |goto 33.21,88.36 < 7 |walk
kill Captain Stillwater##2550 |q 608/1 |goto 32.87,88.20
|tip Downstairs inside the ship.
|tip On the middle floor.
step
click Cortello's Riddle
|tip It looks like a rolled up scroll.
|tip Downstairs inside the ship.
|tip On the bottom floor.
|tip It can spawn in multiple locations.
collect Cortello's Riddle##4056 |goto 33.55,88.02 |q 624 |future |or
|tip
Click Here if the Scroll is Not Here |confirm |or
step
Run up the ramp |goto 30.17,89.43 < 10 |only if walking
Follow the path down |goto 30.71,90.15 < 7 |walk
kill Fleet Master Firallon##2546 |q 608/3 |goto 30.58,90.64
|tip Downstairs inside the ship.
|tip On the middle floor.
step
click Cortello's Riddle
|tip It looks like a rolled up scroll.
|tip Downstairs inside the ship.
|tip On the bottom floor.
|tip It can spawn in multiple locations.
collect Cortello's Riddle##4056 |goto 30.64,90.17 |q 624 |future |or
|tip
Click Here if the Scroll is Not Here |confirm |or
step
Run up the ramp |goto 29.89,89.33 < 10 |only if walking
kill Captain Keelhaul##2548 |q 608/2 |goto 29.20,88.34
|tip He walks aroudn this are, downstairs inside the ship.
|tip On the middle floor.
step
click Cortello's Riddle
|tip It looks like a rolled up scroll.
|tip Downstairs inside the ship.
|tip On the bottom floor.
|tip It can spawn in multiple locations.
|tip If it wasn't at the first 2 locations, it should be here.
collect Cortello's Riddle##4056 |goto 29.20,88.60 |q 624 |future |or
step
use Cortello's Riddle##4056
accept Cortello's Riddle##624
step
Leave the building |goto 27.08,77.63 < 7 |walk
Follow the path |goto 27.34,77.14 < 15 |only if walking
talk Auctioneer O'reely##15681
|tip Buy these items from the Auction House.
collect 15 Silk Cloth##4306 |goto 26.60,76.37 |q 4449 |future
step
Enter the building |goto 27.08,77.63 < 7 |walk
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
turnin The Bloodsail Buccaneers##608 |goto 27.17,77.00
step
Follow the path up |goto Badlands 5.75,60.58 < 30 |only if walking
Continue following the path |goto Searing Gorge 68.22,53.86 < 30 |only if walking
Follow the path up |goto Searing Gorge 62.77,64.32 < 30 |only if walking
click Wooden Outhouse
accept Caught!##4449 |goto Searing Gorge 65.54,62.24
step
kill 8 Dark Iron Geologist##5839 |q 4449/1 |goto 63.13,60.28
step
Follow the path up |goto 62.77,64.32 < 30 |only if walking
click Wooden Outhouse
turnin Caught!##4449 |goto 65.54,62.24
accept Ledger from Tanaris##4450 |goto 65.54,62.24
step
click Goodsteel Ledger
|tip It appears on the ground.
collect Goodsteel Ledger##11727 |q 4450/1 |goto 65.50,62.19
step
kill Glassweb Spider##5856+
collect 20 Solid Crystal Leg Shaft##11725 |q 4450/2 |goto 62.51,71.05
You can find more around: |notinsticky
[60.99,53.10]
[66.89,52.46]
[67.95,36.35]
[73.30,18.44]
step
Follow the path |goto 67.99,50.25 < 30 |only if walking
Continue following the path |goto 66.79,34.56 < 30 |only if walking
talk Kalaran Windblade##8479
accept Divine Retribution##3441 |goto 39.05,38.99
step
talk Kalaran Windblade##8479
Ask him _"Tell me what drives this vengeance?"_
Listen to Kalaran's Story |q 3441/1 |goto 39.05,38.99
step
talk Kalaran Windblade##8479
turnin Divine Retribution##3441 |goto 39.05,38.99
accept The Flawless Flame##3442 |goto 39.05,38.99
step
Follow the path up |goto 31.52,33.54 < 15 |only if walking
Follow the path |goto 35.22,26.40 < 20 |only if walking
talk Grisha##3305
fpath Thorium Point |goto 34.85,30.87
step
click Wanted/Missing/Lost & Found
accept WANTED: Overseer Maltorius##7701 |goto 37.63,26.53
|tip You will need a group to complete this quest later.
|tip If you can, alert some friends to have them available later when you need them, to get the quest done faster.
accept STOLEN: Smithing Tuyere and Lookout's Spyglass##7728 |goto 37.63,26.53
accept JOB OPPORTUNITY: Culling the Competition##7729 |goto 37.63,26.53
step
talk Hansel Heavyhands##14627
accept Curse These Fat Fingers##7723 |goto 38.57,27.80
accept Fiery Menace!##7724 |goto 38.57,27.80
accept Incendosaurs? Whateverosaur is More Like It##7727 |goto 38.57,27.80
step
talk Master Smith Burninate##14624
accept What the Flux?##7722 |goto 38.80,28.49
stickystart "Collect_Smithing_Tuyere"
stickystart "Collect_Grimesilt_Outhouse_Key"
stickystart "Collect_Golem_Oil"
stickystart "Collect_Hearts_Of_Flame"
stickystart "Kill_Greater_Lava_Spiders"
stickystart "Kill_Heavy_War_Golems"
stickystart "Kill_Dark_Iron_Taskmasters"
stickystart "Kill_Dark_Iron_Slavers"
step
Follow the path |goto 33.46,49.81 < 30 |only if walking
kill Dark Iron Lookout##8566+
|tip They are around the watch towers on the clifff surrounding the huge pit.
collect Lookout's Spyglass##18960 |q 7728/2 |goto 33.03,53.44
You can find more around: |notinsticky
[35.40,59.82]
[43.47,63.52]
[52.47,57.97]
step
label "Collect_Smithing_Tuyere"
kill Dark Iron Steamsmith##5840+
|tip They have a roughly 5 minute respawn time.
|tip Work on the other quests around this area while waiting for them to respawn.
collect Smithing Tuyere##18959 |q 7728/1 |goto 39.13,49.64
You can find more around [42.86,51.59]
step
label "Collect_Grimesilt_Outhouse_Key"
Kill Dark Iron enemies around this area
collect Grimesilt Outhouse Key##11818 |goto 39.13,49.64 |q 4451 |future
|tip This has a low drop rate.
You can find more around: |notinsticky
[42.59,50.65]
[43.93,40.43]
step
use the Grimesilt Outhouse Key##11818
accept The Key to Freedom##4451
step
label "Collect_Golem_Oil"
Kill enemies around this area
|tip Only Tempered War Golems, Heavy War Golems, and Magma Elementals will drop the quest item.
collect 4 Golem Oil##10511 |q 3442/2 |goto 48.59,38.32
You can find more around: |notinsticky
[43.27,39.20]
[36.56,40.58]
[32.26,46.19]
[25.43,53.98]
[31.52,72.23]
step
label "Collect_Hearts_Of_Flame"
Kill Elemental enemies around this area
|tip They can be fire or rock elementals.
collect 4 Heart of Flame##10509 |q 3442/1 |goto 48.59,38.32
You can find more around: |notinsticky
[43.27,39.20]
[36.56,40.58]
[32.26,46.19]
[25.43,53.98]
[31.52,72.23]
step
talk Kalaran Windblade##8479
turnin The Flawless Flame##3442 |goto 39.05,38.99
accept Forging the Shaft##3443 |goto 39.05,38.99
stickystart "Collect_Thorium_Plated_Daggers"
step
label "Kill_Greater_Lava_Spiders"
kill 20 Greater Lava Spider##5858 |q 7724/1 |goto 28.78,44.44
You can find more around: |notinsticky
[29.23,55.00]
[29.51,72.50]
step
label "Kill_Heavy_War_Golems"
kill 20 Heavy War Golem##5854 |q 7723/1	|goto 32.42,49.43
You can find more around: |notinsticky
[37.02,42.98]
[47.99,38.64]
step
Find a Group to Help You
|tip You are about to complete a difficult group quest.
Click Here to Continue |confirm |q 7701
step
Jump down here |goto 49.32,43.74 < 15 |only if walking
Enter the cave |goto 49.58,45.49 < 10 |c |q 7701
step
Cross the bridge |goto 47.78,42.60 < 15 |walk
Follow the path |goto 42.02,35.57 < 15 |walk
kill Overseer Maltorius##14621
|tip Inside the cave.
|tip You will likely need a group to help you with this.
collect Head of Overseer Maltorius##18946 |q 7701/1 |goto 40.77,35.90
step
click Secret Plans: Fiery Flux
|tip Inside the cave.
collect Secret Plans: Fiery Flux##18922 |q 7722/1 |goto 40.44,35.74
step
label "Collect_Thorium_Plated_Daggers"
Kill Dark Iron enemies around this area
|tip Inside the cave, all throughout.
|tip You can also find some outside, near Thorium Point.
collect 8 Thorium Plated Dagger##10551 |q 3443/1 |goto 43.38,34.94
step
label "Kill_Dark_Iron_Taskmasters"
kill 15 Dark Iron Taskmaster##5846 |q 7729/1 |goto 43.38,34.94
|tip Inside the cave, all throughout.
|tip You can also find some outside, near Thorium Point.
step
label "Kill_Dark_Iron_Slavers"
kill 15 Dark Iron Slaver##5844 |q 7729/2 |goto 43.38,34.94
|tip Inside the cave, all throughout.
|tip You can also find some outside, near Thorium Point.
step
Cross the bridge |goto 44.44,37.30 < 15 |walk
Jump down here |goto 47.73,41.92 < 10 |walk
kill 20 Incendosaur##9318 |q 7727/1 |goto 51.73,37.16
|tip Inside the cave.
You can find more around: |notinsticky
[50.37,24.75]
[45.03,21.73]
step
Kill enemies around this area
|tip Inside the cave.
Reach Level 49 |ding 49 |goto 51.73,37.16
You can find more around: |notinsticky
[50.37,24.75]
[45.03,21.73]
step
Follow the path |goto 50.59,38.45 < 15 |walk
Continue following the path |goto 47.21,42.94 < 15 |walk
Leave the cave |goto 47.53,46.72 < 15 |walk
Jump down carefully here |goto 48.98,46.87 < 10 |only if walking
Follow the path up |goto 58.08,41.10 < 15 |only if walking
Follow the path |goto 65.38,34.61 < 30 |only if walking
talk Kalaran Windblade##8479
turnin Forging the Shaft##3443 |goto 39.06,38.99
accept The Flame's Casing##3452 |goto 39.06,38.99
step
Follow the path up |goto 31.52,33.46 < 15 |only if walking
Follow the path |goto 35.30,25.83 < 20 |only if walking
talk Lookout Captain Lolo Longstriker##14634
turnin WANTED: Overseer Maltorius##7701 |goto 37.74,26.57
step
talk Hansel Heavyhands##14627
turnin Curse These Fat Fingers##7723 |goto 38.59,27.81
turnin Fiery Menace!##7724 |goto 38.59,27.81
turnin Incendosaurs? Whateverosaur is More Like It##7727 |goto 38.59,27.81
step
talk Taskmaster Scrange##14626
turnin STOLEN: Smithing Tuyere and Lookout's Spyglass##7728 |goto 38.98,27.51
turnin JOB OPPORTUNITY: Culling the Competition##7729 |goto 38.98,27.51
step
talk Master Smith Burninate##14624
turnin What the Flux?##7722 |goto 38.80,28.50
step
Follow the path down |goto 34.86,25.83 < 20 |only if walking
Follow the path |goto 31.32,33.57 < 30 |only if walking
Kill Twilight enemies around this area
|tip You may need help with this.
collect Symbol of Ragnaros##10552 |q 3452/1 |goto 24.62,35.13
|tip This has a pretty low drop rate.
You can find more inside the cave at [21.89,36.36]
You can find more up the path that starts at [24.23,33.12]
step
Follow the path |goto 26.48,34.56 < 30 |only if walking
talk Kalaran Windblade##8479
turnin The Flame's Casing##3452 |goto 39.05,38.99
accept The Torch of Retribution##3453 |goto 39.05,38.99
step
Watch the dialogue
Witness the Creation of the Torch |q 3453/1 |goto 39.05,38.99
step
talk Kalaran Windblade##8479
turnin The Torch of Retribution##3453 |goto 39.05,38.99
accept The Torch of Retribution##3454 |goto 39.05,38.99
step
click Torch of Retribution
turnin The Torch of Retribution##3454 |goto 39.06,39.26
step
talk Kalaran Windblade##8479
accept Squire Maltrake##3462 |goto 39.05,39.00
step
talk Squire Maltrake##8509
turnin Squire Maltrake##3462 |goto 39.16,38.99
accept Set Them Ablaze!##3463 |goto 39.16,38.99
step
Follow the path |goto 33.70,49.71 < 30 |only if walking
Run up the ramp |goto 33.50,53.64 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Northern Tower Ablaze |q 3463/4 |goto 33.31,54.49
step
Run up the ramp |goto 35.92,59.85 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Western Tower Ablaze |q 3463/1 |goto 35.67,60.68
step
Follow the path |goto 35.00,72.13 < 30 |only if walking
Continue following the path |goto 43.33,72.09 < 30 |only if walking
Run up the ramp |goto 44.10,61.85 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Southern Tower Ablaze |q 3463/2 |goto 44.03,60.91
step
Cross the hanging bridge |goto 52.48,57.95 < 15 |only if walking
Run up the ramp |goto 50.19,55.61 < 15 |only if walking
click Sentry Brazier
|tip On the metal platform of the tower.
|tip You have to equip the Torch of Retribution.
|tip Remember to re-equip your normal weapon after.
Set the Eastern Tower Ablaze |q 3463/3 |goto 44.03,60.91
step
Cross the hanging bridge |goto 51.42,55.64 < 15 |only if walking
Follow the path up |goto 63.37,64.65 < 30 |only if walking
click Wooden Outhouse
turnin The Key to Freedom##4451 |goto 65.53,62.23
step
Follow the path |goto 67.99,50.25 < 30 |only if walking
Continue following the path |goto 66.79,34.56 < 30 |only if walking
talk Squire Maltrake##8509
turnin Set Them Ablaze!##3463 |goto 39.17,39.00
step
Watch the dialogue
click Hoard of the Black Dragonflight
accept Trinkets...##3481 |goto 38.86,38.99
step
click Hoard of the Black Dragonflight
turnin Trinkets...##3481 |goto 38.86,38.99
step
use the Hoard of the Black Dragonflight##10569
collect Black Dragonflight Molt##10575 |q 4022 |future
|tip Keep this, you'll need it for a future quest.
step
Follow the path |goto 32.13,47.85 < 30 |only if walking
Follow the path up |goto 33.53,75.22 < 20 |only if walking
Enter Blackrock Mountain |goto Blackrock Mountain 48.58,63.21 < 10 |only if walking
Follow the path |goto Blackrock Mountain 48.56,63.40 < 10 |only if walking
Continue following the path |goto Blackrock Mountain 48.50,63.72 < 15 |only if walking
Continue following the path |goto Blackrock Mountain 48.45,63.82 < 15 |only if walking
Continue following the path |goto Blackrock Mountain 48.33,64.20 < 15 |only if walking
Follow the path |goto Blackrock Mountain 48.55,64.66 < 15 |only if walking
Leave Blackrock Mountain |goto Blackrock Mountain 48.66,65.02 < 15 |only if walking
Follow the road |goto Burning Steppes 32.53,52.34 < 30 |only if walking
Follow the path up |goto Burning Steppes 64.60,23.14 < 15 |only if walking
talk Vahgruk##13177
|tip The enemies in this zone are too high for your level.
|tip If you die running here, just resurrect at the spirit healer.
fpath Flame Crest |goto Burning Steppes 65.68,24.21
step
Enter the building |goto Swamp of Sorrows 45.24,55.33 < 10 |walk
talk Innkeeper Karakul##6930
|tip Inside the building.
home Stonard |goto Swamp of Sorrows 45.16,56.65
step
Leave the building |goto 45.25,55.34 < 7 |walk
Enter the building |goto 46.95,54.07 < 15 |walk
talk Fel'zerul##1443
|tip Upstairs inside the building.
turnin Return to Fel'Zerul##1444 |goto 47.93,54.79
step
Leave the building |goto 46.76,53.87 < 10 |walk
Follow the path |goto 43.46,55.04 < 15 |only if walking
Continue following the path |goto 36.33,56.70 < 30 |only if walking
talk Fallen Hero of the Horde##7572
accept Fall From Grace##2784 |goto 34.29,66.13
step
talk Fallen Hero of the Horde##7572
Ask him _"Why are you here?"_
Listen to the Tale of Sorrow |q 2784/1 |goto 34.29,66.13
step
talk Fallen Hero of the Horde##7572
turnin Fall From Grace##2784 |goto 34.29,66.13
accept The Disgraced One##2621 |goto 34.29,66.13
step
click A Soggy Scroll
|tip Underwater, under the bridge.
turnin Cortello's Riddle##624 |goto 22.86,48.19
accept Cortello's Riddle##625 |goto 22.86,48.19
step
Follow the path up |goto 11.92,51.42 < 20 |only if walking
Enter Deadwind Pass |goto Deadwind Pass 59.13,41.20 < 20 |only if walking
Follow the road |goto Deadwind Pass 51.49,42.84 < 20 |only if walking
Cross the bridge |goto Deadwind Pass 43.69,34.40 < 20 |only if walking
Enter Duskwood |goto Duskwood 90.34,41.35 < 30 |only if walking
Follow the path up |goto Duskwood 87.07,39.90 < 30 |only if walking
talk Apothecary Faustin##5414
turnin Nothing But The Truth##1383 |goto  |goto Duskwood 87.45,35.25
step
Watch the dialogue
talk Apothecary Faustin##5414
accept Nothing But The Truth##1388 |goto 87.45,35.25
step
talk Deathstalker Zraedus##5418
turnin Nothing But The Truth##1388 |goto 87.81,35.62
accept Nothing But The Truth##1391 |goto 87.81,35.62
step
Leave the building |goto Swamp of Sorrows 45.25,55.35 < 10 |walk
talk Infiltrator Marksen##5416
turnin Nothing But The Truth##1391 |goto Swamp of Sorrows 44.29,52.43
step
Enter the building |goto 46.95,54.07 < 15 |walk
talk Dispatch Commander Ruag##7623
|tip Upstairs inside the building.
turnin The Disgraced One##2621 |goto 47.79,54.95
accept The Missing Orders##2622 |goto 47.79,54.95
step
Leave the building |goto 46.79,53.92 < 10 |walk
Enter the building |goto 45.25,55.33 < 15 |walk
talk Bengor##7643
|tip Inside the building.
turnin The Missing Orders##2622 |goto 44.98,57.34
accept The Swamp Talker##2623 |goto 44.98,57.34
step
Leave the building |goto 45.25,55.33 < 10 |walk
Follow the path |goto 47.90,58.45 < 15 |only if walking
talk Katar##5593
accept Continued Threat##1428 |goto 83.76,80.41
stickystart "Kill_Marsh_Inkspewers_1428"
stickystart "Kill_Marsh_Flesheaters_1428"
stickystart "Kill_Marsh_Oracles_1428"
step
Enter the cave |goto 66.22,76.75 < 20 |walk
Follow the path |goto 64.40,82.08 < 15 |walk
Continue following the path |goto 63.41,84.99 < 15 |walk
Follow the path up |goto 64.48,89.66 < 15 |walk
Continue up the path |goto 63.67,91.42 < 15 |walk
kill Swamp Talker##950
|tip Upstairs inside the cave.
collect Warchief's Orders##8463 |q 2623/1 |goto 62.60,88.08
step
label "Kill_Marsh_Inkspewers_1428"
kill 10 Marsh Inkspewer##750 |q 1428/1 |goto 63.32,84.96
|tip Inside the cave.
step
label "Kill_Marsh_Flesheaters_1428"
kill 10 Marsh Flesheater##751 |q 1428/2 |goto 63.32,84.96
|tip Inside the cave.
step
label "Kill_Marsh_Oracles_1428"
kill 10 Marsh Oracle##752 |q 1428/3 |goto 63.32,84.96
|tip Inside the cave.
step
Follow the path |goto 65.59,81.07 < 20 |walk
Leave the cave |goto 66.37,76.54 < 20 |walk
talk Katar##5593
turnin Continued Threat##1428 |goto 83.75,80.42
step
kill Jarquia##9916
collect Goodsteel's Balanced Flameberge##11723 |q 4450/4 |goto 94.77,52.05
step
Follow the path |goto 47.90,58.51 < 15 |only if walking
Follow the path |goto 43.46,55.04 < 15 |only if walking
Continue following the path |goto 36.33,56.70 < 30 |only if walking
talk Fallen Hero of the Horde##7572
turnin The Swamp Talker##2623 |goto 34.29,66.13
accept A Tale of Sorrow##2801 |goto 34.29,66.13
step
talk Fallen Hero of the Horde##7572
Tell him _"Please continue, Hero..."_
Listen to a Tale of Sorrow |q 2801/1 |goto 34.29,66.13
step
talk Fallen Hero of the Horde##7572
turnin A Tale of Sorrow##2801 |goto 34.29,66.13
step
Follow the road |goto 36.79,56.62 < 30 |only if walking
Follow the path |goto 43.46,55.04 < 15 |only if walking
talk Whiskey Slim##2491
|tip Inside the building.
accept Whiskey Slim's Lost Grog##580 |goto Stranglethorn Vale 27.13,77.45
step
Leave the building |goto 27.08,77.62 < 7 |walk
Enter the cave |goto Dustwallow Marsh 36.84,32.43 < 15 |walk
talk Draz'Zilb##4501
|tip Inside the cave.
accept The Brood of Onyxia##1172 |goto Dustwallow Marsh 37.15,33.08
step
Leave the cave |goto 36.80,32.35 < 15 |walk
Follow the path |goto 37.52,31.65 < 15 |only if walking
click Damaged Crate
collect Overdue Package##11724 |q 4450/3 |goto 54.07,55.90
step
Follow the path |goto 50.40,63.16 < 30 |only if walking
click Egg of Onyxia+
|tip They look like large brown spikey eggs grouped together.
Destroy #5# Eggs of Onyxia |q 1172/1 |goto 53.57,72.52
You can find more at:
[48.39,75.98]
[56.65,75.40]
step
Follow the path |goto 34.15,65.15 < 30 |only if walking
Enter the cave |goto 31.71,65.74 < 15 |walk
click Musty Scroll
|tip Inside the cave.
turnin Cortello's Riddle##624 |goto 31.10,66.15
accept Cortello's Riddle##625 |goto 31.10,66.15
step
Leave the cave |goto 31.77,65.72 < 15 |walk
Follow the road |goto 34.59,62.48 < 30 |only if walking
Enter the cave |goto 36.81,32.36 < 15 |walk
talk Draz'Zilb##4501
|tip Inside the cave.
turnin The Brood of Onyxia##1172 |goto 37.15,33.08
step
Leave the cave |goto 36.79,32.33 < 15 |walk
talk Overlord Mok'Morokk##4500
accept Challenge Overlord Mok'Morokk##1173 |goto 36.30,31.42
step
Watch the dialogue
kill Overlord Mok'Morokk##4500
|tip He  will eventually surrender at around 30% health.
Drive Overlord Mok'Morokk from Brackenwall Village |q 1173/1 |goto 36.30,31.42
step
Enter the cave |goto 36.81,32.36 < 15 |walk
talk Draz'Zilb##4501
|tip Inside the cave.
turnin Challenge Overlord Mok'Morokk##1173 |goto 37.15,33.08
step
Leave the cave |goto 36.79,32.33 < 15 |walk
talk Witch Doctor Uzer'i##8115
turnin Testing the Vessel##3123 |goto Feralas 74.42,43.36
accept Hippogryph Muisek##3124 |goto Feralas 74.42,43.36
accept The Sunken Temple##3380 |goto Feralas 74.42,43.36
step
Enter the building |goto 74.68,42.99 < 10 |walk
talk Jangdor Swiftstrider##7854
|tip Inside the building.
accept Improved Quality##7734 |goto 74.43,42.91
step
Leave the building |goto 74.69,43.00 < 10 |walk
talk Talo Thornhoof##7776
|tip Inside the tent.
accept Dark Heart##3062 |goto 76.18,43.83
accept Vengeance on the Northspring##3063 |goto 76.18,43.83
accept The Strength of Corruption##4120 |goto 76.18,43.83
step
Enter the building |goto 74.64,44.70 < 15 |walk
talk Innkeeper Greul##7737
|tip Inside the building.
home Camp Mojache |goto 74.66,44.76
step
Leave the building |goto 74.61,44.67 < 10 |walk
Follow the road |goto 73.90,45.34 < 30 |only if walking
Kill enemies around this area
Reach Level 50 |ding 50 |goto 67.50,47.21
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (50-55)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (55-60)",
startlevel=50,
endlevel=55,
},[[
step
Follow the road |goto Feralas 69.15,49.55 < 20 |only if walking
Cross the bridge |goto Feralas 63.73,51.14 < 20 |only if walking
Follow the path |goto Feralas 59.31,53.72 < 30 |only if walking
Kill Frayfeather enemies around this area
use the Hippogryph Muisek Vessel##9619
|tip Use it on their corpses.
collect 10 Hippogryph Muisek##9595 |q 3124/1 |goto Feralas 56.03,63.05
You can find more around: |notinsticky
[54.06,65.91]
[54.21,70.46]
step
Leave the building |goto 74.64,44.72 < 10 |walk
talk Witch Doctor Uzer'i##8115
turnin Hippogryph Muisek##3124 |goto 74.42,43.36
accept Faerie Dragon Muisek##3125 |goto 74.42,43.36
step
Follow the road |goto 74.33,44.31 < 20 |only if walking
kill Sprite Darter##5278+
use the Faerie Dragon Muisek Vessel##9620
|tip Use it on their corpses.
collect 8 Faerie Dragon Muisek##9596 |q 3125/1 |goto 70.00,46.91
You can find more around: |notinsticky
[68.36,48.10]
[66.03,47.52]
[64.35,48.69]
step
Follow the road |goto 73.01,47.65 < 30 |only if walking
talk Witch Doctor Uzer'i##8115
turnin Faerie Dragon Muisek##3125 |goto 74.42,43.36
accept Treant Muisek##3126 |goto 74.42,43.36
step
Follow the road |goto 74.32,44.23 < 20 |only if walking
Follow the path |goto 72.76,44.73 < 30 |only if walking
kill Wandering Forest Walker##7584+
|tip They look like walking trees.
|tip One of them walks around this area.
|tip Come back here after killing the second one, and wait for this one to respawn.
use the Treant Muisek Vessel##9606
|tip Use it on their corpses.
collect 3 Treant Muisek##9593 |q 3126/1 |goto 73.58,39.93
You can find another one walking around [73.67,54.07]
step
talk Witch Doctor Uzer'i##8115
turnin Treant Muisek##3126 |goto 74.42,43.36
accept Mountain Giant Muisek##3127 |goto 74.42,43.36
step
Follow the road |goto 74.32,44.23 < 20 |only if walking
Cross the bridge |goto 63.74,51.17 < 20 |only if walking
Follow the path |goto 58.11,53.16 < 30 |only if walking
Enter the tunnel |goto 55.14,56.36 < 15 |only if walking
Leave the tunnel |goto 53.86,55.61 < 15 |only if walking
talk Homing Robot OOX-22/FE##7807
accept Rescue OOX-22/FE!##2767 |goto 53.35,55.70
step
Watch the dialogue
|tip Follow the Homing Robot OOX-22/FE and protect it as it walks.
|tip It eventually walks to this location.
Escort OOX-22/FE to the Dock Along the Forgotten Coast |q 2767/1 |goto 45.70,43.40
step
talk Zorbin Fandazzle##14637
accept Zapped Giants##7003 |goto 44.81,43.42
accept Fuel for the Zapping##7721 |goto 44.81,43.42
stickystart "Collect_Water_Elemental_Cores"
step
use Zorbin's Ultra-Shrinker##18904
|tip Use it on Wave Striders around this area.
|tip They look like tall green giants that walks on the shore and in the water around this area.
|tip This quest item only lasts for 2 hours.
|tip If you need a new one, abandon the quest and accept it again from the goblin in the previous guide step.
kill Zapped Wave Strider##14638+
collect 15 Miniaturization Residue##18956 |q 7003/1 |goto 44.38,50.11
You can find more around: |notinsticky
[46.63,59.79]
[45.36,67.94]
[40.03,37.38]
[36.09,33.74]
step
label "Collect_Water_Elemental_Cores"
Kill Sea enemies around this area
|tip They look like water elementals.
|tip Up and down this whole shore.
collect 10 Water Elemental Core##18958 |q 7721/1 |goto 46.73,60.23
You can find more around: |notinsticky
[46.30,52.00]
[40.71,37.59]
step
talk Zorbin Fandazzle##14637
turnin Zapped Giants##7003 |goto 44.81,43.42
accept Again With the Zapped Giants##7725 |goto 44.81,43.42
|tip Destroy the Zorbin's Ultra-Shrinker item before accepting this quest.
|tip This will give you a new item lasting for 2 hours.
turnin Fuel for the Zapping##7721 |goto 44.81,43.42
stickystart "Collect_Perfect_Yeti_Hide"
step
Follow the path up |goto 46.28,37.56 < 20 |only if walking
Follow the path |goto 48.27,38.00 < 30 |only if walking
Follow the path up |goto 51.42,32.47 < 15 |only if walking
Kill Rage Scar enemies around this area
collect 10 Rage Scar Yeti Hide##18947 |q 7734/1 |goto 52.19,31.81
You can find more inside the cave at [53.17,31.82]
step
label "Collect_Perfect_Yeti_Hide"
Kill Rage Scar enemies around this area
collect Perfect Yeti Hide##18972 |goto 52.19,31.81 |q 7738 |future
|tip You can also get this item by skinning enemies, if you have Skinning.
You can find more inside the cave at [53.17,31.82]
step
use the Perfect Yeti Hide##18972
accept Perfect Yeti Hide##7738
stickystart "Collect_Mountain_Giant_Muiseks"
step
Follow the path |goto 48.99,27.00 < 30 |only if walking
Continue following the path |goto 48.17,24.67 < 30 |only if walking
Follow the path up |goto 45.62,25.69 < 15 |only if walking
use the Zorbin's Ultra-Shrinker##18904
|tip Use it on enemies around this area.
|tip They look like rock giants.
Kill enemies around this area
collect 10 Miniaturization Residue##18956 |q 7725/1 |goto 40.25,24.48
You can find more around [37.96,20.91]
step
label "Collect_Mountain_Giant_Muiseks"
Kill enemies around this area
|tip They look like rock giants.
use the Mountain Giant Muisek Vessel##9621
|tip Use it on their corpses.
collect 7 Mountain Giant Muisek##9597 |q 3127/1 |goto 40.25,24.48
You can find more around [37.96,20.91]
stickystart "Kill_Northspring_Harpies"
stickystart "Kill_Northspring_Roguefeathers"
stickystart "Kill_Northspring_Slayers"
stickystart "Kill_Northspring_Windcallers"
step
Kill Northspring enemies around this area
collect Horn of Hatetalon##9530 |goto 39.64,14.79 |q 3062
You can find more around [39.19,9.95]
step
use the Horn of Hatetalon##9530
kill Edana Hatetalon##8075
|tip You may need help with this.
collect Edana's Dark Heart##9528 |q 3062/1 |goto 40.55,8.59
step
label "Kill_Northspring_Harpies"
kill 4 Northspring Harpy##5362 |q 3063/1 |goto 39.64,14.79
You can find more around [39.19,9.95]
step
label "Kill_Northspring_Roguefeathers"
kill 4 Northspring Roguefeather##5363 |q 3063/2 |goto 39.64,14.79
You can find more around [39.19,9.95]
step
label "Kill_Northspring_Slayers"
kill 4 Northspring Slayer##5364 |q 3063/3 |goto 39.64,14.79
You can find more around [39.19,9.95]
step
label "Kill_Northspring_Windcallers"
kill 4 Northspring Windcaller##5366 |q 3063/4 |goto 39.64,14.79
You can find more around [39.19,9.95]
step
Follow the road |goto 45.87,12.05 < 30 |only if walking
Follow the path down |goto 47.53,37.63 < 20 |only if walking
talk Zorbin Fandazzle##14637
turnin Again With the Zapped Giants##7725 |goto 44.81,43.42
step
Leave the building |goto 74.65,44.71 < 10 |walk
talk Witch Doctor Uzer'i##8115
turnin Mountain Giant Muisek##3127 |goto 74.42,43.37
accept Weapons of Spirit##3129 |goto 74.42,43.37
step
talk talk 8115
turnin Weapons of Spirit##3129 |goto 74.42,43.37
step
Enter the building |goto 74.68,43.00 < 10 |walk
talk Jangdor Swiftstrider##7854
|tip Inside the building.
turnin Improved Quality##7733 |goto 74.43,42.91
turnin Perfect Yeti Hide##7738 |goto 74.43,42.91
step
Leave the building |goto 74.69,42.99 < 10 |walk
talk Talo Thornhoof##7776
|tip Inside the building.
turnin Dark Heart##3062 |goto 76.18,43.83
turnin Vengeance on the Northspring##3063 |goto 76.18,43.83
step
Follow the path |goto Tanaris 51.87,26.53 < 15 |only if walking
talk Tran'rek##7876
accept Thistleshrub Valley##3362 |goto Tanaris 51.57,26.76
accept Super Sticky##4504 |goto Tanaris 51.57,26.76
step
click Egg-O-Matic
accept The Super Egg-O-Matic##2741 |goto 52.37,26.97
step
talk Andi Lynn##11758
accept The Dunemaul Compound##5863 |goto 52.82,27.40
step
Enter the building |goto 52.38,27.91 < 10 |walk
talk Innkeeper Fizzgrimble##7733
|tip Inside the building.
home Gadgetzan |goto 52.51,27.92
step
Leave the building |goto 52.38,27.91 < 7 |walk
talk Chief Engineer Bilgewhizzle##7407
turnin Into the Field##243 |goto 52.46,28.51
accept Slake That Thirst##379 |goto 52.46,28.51
step
talk Marin Noggenfogger##7564
accept The Thirsty Goblin##2605 |goto 51.81,28.66
step
talk Krinkle Goodsteel##5411
turnin Ledger from Tanaris##4450 |goto 51.47,28.81
step
talk Senior Surveyor Fizzledowser##7724
accept Noxious Lair Investigation##82 |goto 50.21,27.48
step
talk Marvon Rivetseeker##7771
turnin The Sunken Temple##3380 |goto 52.71,45.93
accept The Stone Circle##3444 |goto 52.71,45.93
accept Gahz'ridian##3161 |goto 52.71,45.93
step
Kill Centipaar enemies around this area
collect 5 Centipaar Insect Parts##8587 |q 82/1 |goto 35.74,42.06
stickystart "Kill_Dunemaul_Brutes"
stickystart "Kill_Dunemaul_Enforcers"
step
Follow the path up |goto 37.51,46.15 < 20 |only if walking
Enter the cave |goto 41.09,57.35 < 15 |walk
kill Gor'marok the Ravager##12046 |q 5863/3 |goto 41.50,57.81
|tip Inside the small cave.
step
label "Kill_Dunemaul_Brutes"
kill 10 Dunemaul Brute##5474 |q 5863/1 |goto 40.32,52.49
You can find more around [39.05,56.57]
step
label "Kill_Dunemaul_Enforcers"
kill 10 Dunemaul Enforcer##5472 |q 5863/2 |goto 40.32,52.49
You can find more around [39.05,56.57]
step
click Gahz'ridian+
|tip They look like small piles of sand on the ground around this area.
collect 30 Gahz'ridian Ornament##8443 |q 3161/1 |goto 40.45,72.67
You can find more around [46.96,65.87]
stickystart "Kill_Gnarled_Thistleshrubs"
stickystart "Kill_Thistleshrub_Rootshapers"
step
Follow the path |goto 30.70,67.87 < 30 |only if walking
kill Thistleshrub Dew Collector##5481+
collect Laden Dew Gland##8428 |q 2605/1 |goto 29.97,66.48
You can find more around: |notinsticky
[28.18,64.79]
[30.54,64.66]
step
label "Kill_Gnarled_Thistleshrubs"
kill 8 Gnarled Thistleshrub##5490 |q 3362/1 |goto 29.97,66.48
You can find more around: |notinsticky
[28.18,64.79]
[30.54,64.66]
step
label "Kill_Thistleshrub_Rootshapers"
kill 8 Thistleshrub Rootshaper##5485 |q 3362/2 |goto 29.97,66.48
You can find more around: |notinsticky
[28.18,64.79]
[30.54,64.66]
step
Kill enemies around this area
Reach Level 51 |ding 51 |goto 29.97,66.48
You can find more around: |notinsticky
[28.18,64.79]
[30.54,64.66]
step
talk Tooga
|tip He looks like a turtle.
accept Tooga's Quest##1560 |goto 28.5,63.1
He can also be at [31.79,74.15]
step
Follow the path |goto 36.36,71.72 < 50 |only if walking
Continue following the path |goto 41.51,66.36 < 50 |only if walking
Continue following the path |goto 47.89,56.47 < 50 |only if walking
Continue following the path |goto 51.09,44.80 < 50 |only if walking
Continue following the path |goto 57.42,32.62 < 50 |only if walking
Lead Tooga to Torta |q 1560/1 |goto 66.57,25.67
|tip He will follow you.
|tip Protect Tooga as you walk.
step
talk Torta##6015
turnin Tooga's Quest##1560 |goto 66.57,25.67
step
Enter the building |goto 66.99,23.87 < 7 |walk
talk Yorba Screwspigot##9706
|tip Inside the building.
accept Yuka Screwspigot##4324 |goto 67.03,24.01
step
talk Yeh'kinya##8579
turnin Screecher Spirits##3520 |goto 66.99,22.36
step
Kill Wastewander enemies around this area
|tip Some of them are stealthed, so be careful.
collect 5 Wastewander Water Pouch##8483 |q 379/1 |goto 63.65,31.65
You can find more around [59.51,38.22]
step
Leave the building |goto 52.38,27.91 < 7 |walk
talk Chief Engineer Bilgewhizzle##7407
turnin Slake That Thirst##379 |goto 52.46,28.51
step
talk Marin Noggenfogger##7564
turnin The Thirsty Goblin##2605 |goto 51.81,28.66
accept In Good Taste##2606 |goto 51.81,28.66
step
talk Sprinkle##7583
turnin In Good Taste##2606 |goto 51.06,26.87
accept Sprinkle's Secret Ingredient##2641 |goto 51.06,26.87
step
Enter the building |goto 50.98,27.00 < 7 |walk
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Noxious Lair Investigation##82 |goto 50.89,26.96
step
Leave the building |goto 50.99,26.99 < 7 |walk
talk Senior Surveyor Fizzledowser##7724
accept The Scrimshank Redemption##10 |goto 50.21,27.48
step
talk Tran'rek##7876
turnin Thistleshrub Valley##3362 |goto 51.57,26.76
step
talk Andi Lynn##11758
turnin The Dunemaul Compound##5863 |goto 52.82,27.40
step
use the Model 4711-FTZ Power Source##8524
accept Tanaris Field Sampling##654
stickystart "Collect_Acceptable_Basilisk_Samples"
stickystart "Collect_Acceptable_Hyena_Samples"
stickystart "Collect_Acceptable_Scorpid_Samples"
stickystart "Collect_OOX17TN_Distress_Beacon"
step
Follow the path |goto 51.55,29.03 < 15 |only if walking
talk Marvon Rivetseeker##7771
turnin Gahz'ridian##3161 |goto 52.71,45.93
step
label "Collect_Acceptable_Basilisk_Samples"
path	follow loose;	loop;	ants curved
path	54.62,46.54		56.48,54.00		58.06,48.57		60.53,51.42
path	60.40,47.91		62.96,43.26		59.64,41.16		57.97,44.98
path	55.23,39.76		56.15,33.96		53.60,32.01		51.17,34.23
path	50.94,38.14		54.05,36.34		50.86,45.76
Kill Glasshide enemies around this area
|tip They look like basilisks.
|tip You can find them all throughout Tanaris.
collect Untested Basilisk Sample##9437+ |n
use the Untested Basilisk Sample##9437+
|tip Not all of the samples will be acceptable.
collect 8 Acceptable Basilisk Sample##9440 |q 654/1
step
label "Collect_Acceptable_Hyena_Samples"
path	follow loose;	loop;	ants curved
path	54.62,46.54		56.48,54.00		58.06,48.57		60.53,51.42
path	60.40,47.91		62.96,43.26		59.64,41.16		57.97,44.98
path	55.23,39.76		56.15,33.96		53.60,32.01		51.17,34.23
path	50.94,38.14		54.05,36.34		50.86,45.76
Kill Blisterpaw enemies around this area
|tip They look like hyenas.
|tip You can find them all throughout Tanaris.
collect Untested Hyena Sample##9439+ |n
use the Untested Hyena Sample##9439+
|tip Not all of the samples will be acceptable.
collect 8 Acceptable Hyena Sample##9441 |q 654/2
step
label "Collect_Acceptable_Scorpid_Samples"
path	follow loose;	loop;	ants curved
path	54.62,46.54		56.48,54.00		58.06,48.57		60.53,51.42
path	60.40,47.91		62.96,43.26		59.64,41.16		57.97,44.98
path	55.23,39.76		56.15,33.96		53.60,32.01		51.17,34.23
path	50.94,38.14		54.05,36.34		50.86,45.76
Kill Scorpid enemies around this area
|tip They look like scorpions.
|tip You can find them all throughout Tanaris.
collect Untested Scorpid Sample##9442+ |n
use the Untested Scorpid Sample##9442+
|tip Not all of the samples will be acceptable.
collect 8 Acceptable Scorpid Sample##9438 |q 654/3
step
label "Collect_OOX17TN_Distress_Beacon"
path	follow loose;	loop;	ants curved
path	54.62,46.54		56.48,54.00		58.06,48.57		60.53,51.42
path	60.40,47.91		62.96,43.26		59.64,41.16		57.97,44.98
path	55.23,39.76		56.15,33.96		53.60,32.01		51.17,34.23
path	50.94,38.14		54.05,36.34		50.86,45.76
Kill enemies around this area
collect OOX-17/TN Distress Beacon##8623 |q 351 |future
|tip This has a low drop rate.
step
use the OOX-17/TN Distress Beacon##8623
accept Find OOX-17/TN!##351
step
Follow the path up |goto 60.20,64.05 < 15 |only if walking
talk Homing Robot OOX-17/TN##7784
turnin Find OOX-17/TN!##351 |goto 60.23,64.71
step
Follow the path down |goto 55.87,70.27 < 20 |only if walking
Enter the cave |goto 55.78,68.91 < 10 |c |q 10
step
Follow the path down |goto 55.93,68.37 < 10 |walk
Continue following the path down |goto 56.17,68.34 < 10 |walk
Follow the path |goto 56.55,68.72 < 10 |walk
Follow the path up |goto 57.19,70.16 < 10 |walk
Follow the path down |goto 57.61,70.67 < 10 |walk
Follow the path |goto 57.38,71.30 < 10 |walk
click Scrimshank's Surveying Gear
|tip Inside the cave.
collect Scrimshank's Surveying Gear##8593 |q 10/1 |goto 55.97,71.18
step
Leave the building |goto 52.38,27.91 < 7 |walk
talk Chief Engineer Bilgewhizzle##7407
turnin Tanaris Field Sampling##654 |goto 52.46,28.51
accept Return to Apothecary Zinge##864 |goto 52.46,28.51
step
talk Senior Surveyor Fizzledowser##7724
turnin The Scrimshank Redemption##10 |goto 50.21,27.48
accept Insect Part Analysis##110 |goto 50.21,27.48
step
Enter the building |goto 50.99,27.00 < 10 |walk
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Insect Part Analysis##110 |goto 50.89,26.96
accept Insect Part Analysis##113 |goto 50.89,26.96
step
Leave the building |goto 50.99,27.00 < 7 |walk
talk Senior Surveyor Fizzledowser##7724
turnin Insect Part Analysis##113 |goto 50.21,27.48
accept Rise of the Silithid##32 |goto 50.21,27.48
step
Follow the path |goto 51.26,26.49 < 15 |walk
Enter the building |goto Orgrimmar 53.98,68.85 < 10 |walk
talk Innkeeper Gryshka##6929
|tip Inside the building.
home Orgrimmar |goto Orgrimmar 54.09,68.41
step
Enter the building |goto 47.49,65.18 < 10 |only if walking
talk Jediga##8587
accept Stealing Knowledge##3517 |goto Azshara 22.56,51.42
step
talk Sanath Lim-yo##8395
accept A Meeting with the Master##3381 |goto 28.11,50.09
stickystart "Collect_Tablet_Of_BethAmara"
stickystart "Collect_Tablet_Of_Jinyael"
stickystart "Collect_Tablet_Of_Saelhai"
step
Follow the road |goto 29.27,56.05 < 30 |only if walking
Continue following the road |goto 32.08,57.05 < 20 |only if walking
click Tablet of Markri
|tip It looks like a stone rectangle with green glowing runes on it.
|tip It can spawn in multiple locations, so keep an eye out for it as you walk around this area.
collect Tablet of Markri##10540 |q 3517/3 |goto 34.66,55.62
It can also be at:
[35.69,56.50]
[40.00,64.17]
[37.92,47.77]
[39.85,45.88]
step
label "Collect_Tablet_Of_BethAmara"
click Tablet of Beth'Amara
|tip It looks like a stone rectangle with pink glowing runes on it.
|tip It can spawn in multiple locations, so keep an eye out for it as you walk around this area.
collect Tablet of Beth'Amara##10538 |q 3517/1 |goto 35.20,58.00
It can also be at:
[39.53,64.29]
[38.89,53.45]
[37.08,51.84]
[39.59,48.16]
step
label "Collect_Tablet_Of_Jinyael"
click Tablet of Jin'yael
|tip It looks like a stone rectangle with blue glowing runes on it.
|tip It can spawn in multiple locations, so keep an eye out for it as you walk around this area.
collect Tablet of Jin'yael##10539 |q 3517/2 |goto 36.44,54.02
It can also be at:
[38.30,53.42]
[37.41,60.66]
[36.27,62.19]
step
label "Collect_Tablet_Of_Saelhai"
click Tablet of Sael'hai
|tip It looks like a stone rectangle with yellow glowing runes on it.
|tip It can spawn in multiple locations, so keep an eye out for it as you walk around this area.
collect Tablet of Sael'hai##10541 |q 3517/4 |goto 35.90,53.53
It can also be at:
[37.31,48.10]
[38.58,54.58]
[37.15,60.54]
[41.48,65.02]
step
use the Box of Empty Vials##10695
collect Empty Vial Labeled #1##10687 |q 3568
collect Empty Vial Labeled #2##10688 |q 3568
collect Empty Vial Labeled #3##10689 |q 3568
collect Empty Vial Labeled #4##10690 |q 3568
step
Jump down here |goto 39.77,58.44 < 20 |only if walking
use the Empty Vial Labeled #1##10687
|tip Use it in the water.
collect Filled Vial Labeled #1##10691 |q 3568/1 |goto 47.70,61.05
step
use the Empty Vial Labeled #2##10688
|tip Use it in the water.
collect Filled Vial Labeled #2##10692 |q 3568/2 |goto 47.86,51.55
step
use the Empty Vial Labeled #3##10689
|tip Use it in the water.
collect Filled Vial Labeled #3##10693 |q 3568/3 |goto 48.60,48.56
step
use the Empty Vial Labeled #4##10690
|tip Use it in the water.
collect Filled Vial Labeled #4##10694 |q 3568/4 |goto 47.41,46.28
step
Follow the path |goto 46.84,40.79 < 20 |only if walking
kill Thunderhead Stagwing##6377+
collect 2 Undamaged Hippogryph Feather##10450 |q 3381/1 |goto 45.15,34.36
You can find more around: |notinsticky
[45.53,32.06]
[41.73,28.40]
[41.17,31.48]
[41.01,36.90]
[38.09,39.60]
[35.38,43.86]
step
Follow the path |goto 34.14,45.19 < 40 |only if walking
talk Sanath Lim-yo##8395
turnin A Meeting with the Master##3381 |goto 28.11,50.09
step
talk Jediga##8587
turnin Stealing Knowledge##3517 |goto 22.56,51.42
accept Delivery to Magatha##3518 |goto 22.56,51.42
accept Delivery to Jes'rimon##3541 |goto 22.56,51.42
accept Delivery to Andron Gant##3542 |goto 22.56,51.42
accept Delivery to Archmage Xylem##3561 |goto 22.56,51.42
step
talk Sanath Lim-yo##8395
accept Meeting with the Master##3503 |goto 28.11,50.09 |or
Teleport Up the Mountain |goto 26.33,46.23 < 20 |noway |c |q 3561 |or
step
Follow the path up |goto 26.53,43.88 < 15 |only if walking
Enter the building |goto 29.22,40.71 < 15 |walk
talk Archmage Xylem##8379
|tip Upstairs inside the building.
turnin Delivery to Archmage Xylem##3561 |goto 29.71,40.52
accept Xylem's Payment to Jediga##3565 |goto 29.71,40.52
step
Leave the building |goto 29.21,40.73 < 10 |walk
Follow the path down |goto 26.90,42.85 < 20 |only if walking
talk Nyrill##8399
accept Return Trip##3421 |goto 26.47,46.28 |or
Teleport to the Ground |goto 28.02,50.15 < 20 |noway |c |q 3565 |or
step
talk Jediga##8587
turnin Xylem's Payment to Jediga##3565 |goto 22.56,51.42
step
Enter the building |goto Thunder Bluff 50.98,36.92 < 15 |only if walking
Cross the hanging bridge |goto Thunder Bluff 55.94,34.45 < 10 |only if walking
talk Magatha Grimtotem##4046
|tip Inside the tent.
turnin Delivery to Magatha##3518 |goto Thunder Bluff 69.87,30.91
accept Magatha's Payment to Jediga##3562 |goto Thunder Bluff 69.87,30.91
step
Follow the path |goto Orgrimmar 51.65,58.10 < 20 |only if walking
Run up the stairs |goto Orgrimmar 56.42,56.92 < 15 |only if walking
Enter the building |goto Orgrimmar 57.06,45.88 < 10 |walk
talk Zilzibin Drumlore##7010
|tip Inside the building.
turnin Rise of the Silithid##32 |goto Orgrimmar 56.27,46.67
accept March of the Silithid##4494 |goto Orgrimmar 56.27,46.67
step
Leave the building |goto 57.01,45.88 < 10 |walk
Enter the building |goto 58.97,37.57 < 10 |walk
talk Dran Droffers##6986
|tip Inside the building.
turnin Ripple Delivery##81 |goto 59.48,36.59
step
Leave the building |goto 58.93,37.55 < 10 |walk
Enter the building |goto 56.48,35.24 < 10 |walk
talk Jes'rimon##8659
|tip Upstairs inside the building.
turnin Delivery to Jes'rimon##3541 |goto 55.51,34.09
accept Jes'rimon's Payment to Jediga##3563 |goto 55.51,34.09
accept Bone-Bladed Weapons##4300 |goto 55.51,34.09
step
Follow the path |goto 52.15,57.67 < 20 |only if walking
Follow the path |goto 52.56,85.15 < 20 |only if walking
Leave Orgrimmar |goto 49.13,94.82 < 20 |only if walking
Enter Undercity |goto Tirisfal Glades 61.87,65.06 < 15 |only if walking
talk Andron Gant##6522
turnin Delivery to Andron Gant##3542 |goto Undercity 54.82,76.35
accept Andron's Payment to Jediga##3564 |goto Undercity 54.82,76.35
step
Follow the path down |goto 52.92,77.65 < 10 |walk
talk Chemist Cuely##8390
turnin Seeping Corruption##3570 |goto 48.71,71.40
step
Watch the dialogue
talk Chemist Cuely##8390
accept Seeping Corruption##3569 |goto 48.71,71.40
step
talk Thersa Windsong##8393
turnin Seeping Corruption##3569 |goto 49.03,70.82
step
talk Chemist Cuely##8390
turnin Seeping Corruption##3569 |goto 48.71,71.40
step
talk Apothecary Zinge##5204
turnin Return to Apothecary Zinge##864 |goto 50.14,67.97
accept Vivian Lagrave##4133 |goto 50.14,67.97
step
talk Chemist Fuely##10136
accept A Sample of Slime...##4293 |goto 47.47,73.35
accept ... and a Batch of Ooze##4294 |goto 47.47,73.35
step
Follow the path up |goto 47.89,76.57 < 10 |walk
Follow the path |goto 52.87,77.64 < 10 |walk
talk Katoom the Angler##14740
accept Snapjaws, Mon!##7815 |goto The Hinterlands 80.33,81.53
accept Gammerita, Mon!##7816 |goto The Hinterlands 80.33,81.53
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 79.60,81.61 |count 1
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 78.40,82.32 |count 2
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 77.35,83.27 |count 3
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 76.26,85.63 |count 4
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 75.09,86.09 |count 5
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 74.94,88.40 |count 6
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 73.30,92.10 |count 7
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 73.87,93.45 |count 8
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 73.25,95.45 |count 9
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 76.12,81.75 |count 10
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 78.29,77.73 |count 11
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
collect Pupellyverbos Port##3900 |q 580/1 | |goto 79.08,78.86 |count 12
step
talk Otho Moji'ko##14738
|tip Inside the building.
accept The Final Message to the Wildhammer##7843 |goto 79.38,79.08
step
Enter the building |goto 78.54,80.72 < 15 |walk
talk Lard##14731
|tip Inside the building.
accept Lard Lost His Lunch##7840 |goto 78.14,81.38
stickystart "Kill_Saltwater_Snapjaws"
step
Leave the building |goto 78.54,80.72 < 10 |walk
Follow the path |goto 76.94,77.46 < 30 |only if walking
kill Gammerita##7977 |goto 75.62,67.03
|tip It looks like a blue turtle that walks around this area.
collect Katoom's Best Lure##19023 |q 7816/1 |goto 75.62,67.03
You can also find it around:
[77.45,62.32]
[80.79,55.59]
step
click Lard's Picnic Basket
Kill the enemies that attack
collect Lard's Lunch##19034 |q 7840 |goto 84.47,41.22
step
click Cortello's Treasure
|tip Underwater.
turnin Cortello's Riddle##626 |goto 80.81,46.81
step
label "Kill_Saltwater_Snapjaws"
kill 15 Saltwater Snapjaw##2505 |q 7815/1 |goto 81.83,52.01
You can find more around [76.49,69.69]
step
Follow the path up |goto 76.17,61.15 < 20 |only if walking
Follow the path |goto 71.39,65.06 < 20 |only if walking
Follow the road |goto 60.76,52.52 < 40 |only if walking
click Violet Tragan+
|tip They look like large brown and white mushrooms underwater around this area.
collect Violet Tragan##8526 |q 2641/1 |goto 41.04,59.79
step
Follow the path |goto 30.59,53.71 < 30 |only if walking
use the Final Message to the Wildhammer##19036
|tip Be careful, Alliance NPC enemies sometimes walk near this location.
Deliver the Message to the Wildhammer |q 7843/1 |goto 14.39,48.03
step
Follow the path |goto 30.56,53.07 < 50 |only if walking
Follow the road |goto 52.54,44.10 < 50 |only if walking
Follow the path down |goto 72.39,66.11 < 20 |only if walking
Jummp down here |goto 74.85,63.45 < 20 |only if walking
Follow the path |goto 76.95,77.49 < 30 |only if walking
talk Otho Moji'ko##14738
|tip Inside the building.
turnin The Final Message to the Wildhammer##7843 |goto 79.40,79.08
step
Enter the building |goto 78.54,80.72 < 15 |walk
talk Lard##14731
|tip Inside the building.
turnin Lard Lost His Lunch##7840 |goto 78.14,81.38
step
talk Katoom the Angler##14740
turnin Snapjaws, Mon!##7815 |goto 80.33,81.53
turnin Gammerita, Mon!##7816 |goto 80.33,81.53
step
Kill enemies around this area
Reach Level 52 |ding 52 |goto 76.49,69.69
You can find more around [81.83,52.01]
step
talk Jediga##8587
turnin Magatha's Payment to Jediga##3562 |goto Azshara 22.56,51.42
turnin Jes'rimon's Payment to Jediga##3563 |goto Azshara 22.56,51.42
turnin Andron's Payment to Jediga##3564 |goto Azshara 22.56,51.42
step
click Marvon's Chest
collect Stone Circle##10556 |q 3444/1 |goto The Barrens 62.50,38.54
step
talk Liv Rizzlefix##8496
|tip Inside the building.
accept Volcanic Activity##4502 |goto 62.45,38.74
step
Enter the building |goto Stranglethorn Vale 28.29,76.17 < 7 |walk
talk Oglethorpe Obnoticus##7406
|tip Inside the building.
turnin Rescue OOX-22/FE!##2767 |goto Stranglethorn Vale 28.36,76.35
step
Leave the building |goto 28.29,76.17 < 7 |walk
Enter the building |goto 27.08,77.62 < 7 |walk
talk Whiskey Slim##2491
|tip Inside the building.
turnin Whiskey Slim's Lost Grog##580 |goto 27.13,77.45
step
Follow the path |goto Swamp of Sorrows 43.48,55.03 < 15 |only if walking
Follow the road |goto Swamp of Sorrows 35.76,59.48 < 30 |only if walking
talk Bloodmage Drazial##7505
accept Snickerfang Jowls##2581 |goto Blasted Lands 50.55,14.21
accept A Boar's Vitality##2583 |goto Blasted Lands 50.55,14.21
accept The Decisive Striker##2585 |goto Blasted Lands 50.55,14.21
step
talk Bloodmage Lynnore##7506
accept The Basilisk's Bite##2601 |goto 50.64,14.30
accept Vulture's Vigor##2603 |goto 50.64,14.30
stickystart "Collect_Blasted_Boar_Lungs"
stickystart "Collect_Scorpok_Pincers"
stickystart "Collect_Basilisk_Brains"
stickystart "Collect_Vulture_Gizzards"
step
Kill Snickerfang enemies around this area
|tip They look like hyenas.
|tip They share spawn locations with other enemies.
|tip If you can't find any at these locations, kill other enemies to get them to spawn.
collect 5 Snickerfang Jowl##8391 |goto 47.21,21.18 |q 2581
You can find more around: |notinsticky
[44.82,24.87]
[45.44,35.35]
[50.96,38.09]
step
label "Collect_Blasted_Boar_Lungs"
Kill Boar enemies around this area
|tip They share spawn locations with other enemies.
|tip If you can't find any at these locations, kill other enemies to get them to spawn.
collect 6 Blasted Boar Lung##8392 |goto 57.51,28.74 |q 2583
You can find more around: |notinsticky
[61.82,28.49]
[59.11,35.83]
[59.52,43.48]
[51.59,52.84]
step
label "Collect_Scorpok_Pincers"
kill Scorpok Stinger##5988+
|tip They share spawn locations with other enemies.
|tip If you can't find any at these locations, kill other enemies to get them to spawn.
collect 6 Scorpok Pincer##8393 |goto 49.10,18.12 |q 2585
You can find more around: |notinsticky
[45.29,21.33]
[44.61,29.11]
[52.04,30.03]
[56.81,21.17]
step
label "Collect_Basilisk_Brains"
Kill Redstone enemies around this area
|tip They look like basilisks.
|tip They share spawn locations with other enemies.
|tip If you can't find any at these locations, kill other enemies to get them to spawn.
collect 11 Basilisk Brain##8394 |goto 55.08,28.94 |q 2601
You can find more around: |notinsticky
[61.75,27.98]
[46.52,50.46]
[59.71,43.76]
step
label "Collect_Vulture_Gizzards"
kill Black Slayer##5982+
|tip Bonepickers will also drop the quest item.
|tip They look like vultures.
collect 14 Vulture Gizzard##8396 |goto 48.50,19.78 |q 2603
You can find more around: |notinsticky
[45.45,35.25]
[53.42,37.61]
[55.04,43.80]
[59.33,42.05]
[56.46,36.51]
[58.82,27.97]
[62.28,26.43]
step
talk Kum'isha the Collector##7363
accept Everything Counts In Large Amounts##3501 |goto 51.97,35.64
|only if itemcount(10593) > 0
step
talk Kum'isha the Collector##7363
turnin Everything Counts In Large Amounts##3501 |goto 51.97,35.64
|only if havequest(3501) or completedq(3501)
step
talk Bloodmage Lynnore##7506
turnin The Basilisk's Bite##2601 |goto 50.64,14.30
turnin Vulture's Vigor##2603 |goto 50.64,14.30
step
talk Bloodmage Drazial##7505
turnin Snickerfang Jowls##2581 |goto 50.55,14.21
turnin A Boar's Vitality##2583 |goto 50.55,14.21
turnin The Decisive Striker##2585 |goto 50.55,14.21
step
Enter the building |goto Orgrimmar 53.64,64.64 < 15 |walk
talk Auctioneer Thathung##8673
|tip Inside the building.
|tip Buy it from the Auction House.
collect Mithril Casing##10561 |goto Orgrimmar 55.69,62.86 |q 4244 |future
step
Follow the path |goto Tanaris 51.26,26.48 < 15 |only if walking
talk Sprinkle##7583
turnin Sprinkle's Secret Ingredient##2641 |goto Tanaris 51.06,26.87
step
Watch the dialogue
talk Sprinkle##7583
accept Delivery for Marin##2661 |goto 51.06,26.87
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin March of the Silithid##4494 |goto 50.89,26.96
accept Bungle in the Jungle##4496 |goto 50.89,26.96
step
talk Marin Noggenfogger##7564
turnin Delivery for Marin##2661 |goto 51.81,28.66
accept Noggenfogger Elixir##2662 |goto 51.81,28.66
step
Watch the dialogue
talk Marin Noggenfogger##7564
turnin Noggenfogger Elixir##2662 |goto 51.81,28.66
step
Follow the path |goto 51.55,29.03 < 15 |only if walking
talk Marvon Rivetseeker##7771
turnin The Stone Circle##3444 |goto 52.71,45.92
step
Avoid the Dunemaul Compound |goto 42.12,59.44 < 50 |only if walking
Follow the path down |goto 27.04,56.57 < 30 |only if walking
talk Torwa Pathfinder##9619
accept The Apes of Un'Goro##4289 |goto Un'Goro Crater 71.64,75.96
accept The Fare of Lar'korwi##4290 |goto Un'Goro Crater 71.64,75.96
stickystart "Collect_Power_Crystals"
stickystart "Collect_UnGoro_Soil"
stickystart "Collect_Savage_Fronds"
step
click Fresh Threshadon Carcass
|tip Avoid the elite t-rex that sometimes walks near this location.
collect Piece of Threshadon Carcass##11504 |q 4290/1 |goto 68.75,56.66
step
talk Karna Remtravel##9618
accept Chasing A-Me 01##4243 |goto 46.38,13.45
stickystop "Collect_Power_Crystals"
stickystop "Collect_UnGoro_Soil"
stickystop "Collect_Savage_Fronds"
step
Follow the path up |goto 45.72,13.15 < 15 |only if walking
talk Shizzle##9998
accept Shizzle's Flyer##4503 |goto 44.24,11.59
step
click Beware of Pterrordax
accept Beware of Pterrordax##4501 |goto 43.55,8.42
step
talk Spark Nilminer##9272
accept Roll the Bones##3882 |goto 43.50,7.42
step
talk Hol'anyee Marshal##9271
accept Alien Ecology##3883 |goto 43.89,7.24
step
talk Williden Marshal##9270
accept Expedition Salvation##3881 |goto 43.95,7.14
step
talk Gryfe##10583
fpath Marshal's Refuge |goto 45.23,5.84
step
talk Larion##9118
accept Larion and Muigin##4145 |goto 45.54,8.72
stickystart "Collect_Power_Crystals"
stickystart "Collect_UnGoro_Soil"
stickystart "Collect_A_Mangled_Journal"
stickystart "Collect_Webbed_Pterrordax_Scales"
step
Follow the path down |goto 45.24,11.64 < 20 |only if walking
Follow the path |goto 50.36,18.06 < 30 |only if walking
Follow the path up |goto 54.83,13.49 < 15 |only if walking
kill 6 Pterrordax##9166 |q 4501/1 |goto 56.89,9.16 |count 6
stickystop "Collect_Webbed_Pterrordax_Scales"
step
Kil Tar enemies around this area
collect 12 Super Sticky Tar##11834 |q 4504/1 |goto 52.41,26.94
You can find more around: |notinsticky
[47.03,17.67]
[43.82,19.99]
stickystart "Collect_Webbed_Pterrordax_Scales"
step
Follow the path |goto 50.36,18.06 < 40 |only if walking
Follow the path up |goto 54.83,13.49 < 15 |only if walking
kill 10 Pterrordax##9166 |q 4501/1 |goto 56.89,9.16
step
label "Collect_Webbed_Pterrordax_Scales"
kill Pterrordax##9166+
collect 8 Webbed Pterrordax Scale##11831 |q 4503/2 |goto 56.89,9.16
stickystart "Collect_Savage_Fronds"
step
kill 5 Bloodpetal Flayer##6510 |q 4145/3 |goto 57.09,16.45
You can find more around [56.74,24.61]
stickystop "Collect_Savage_Fronds"
stickystart "Collect_UnGoro_Thunderer_Pelts"
stickystart "Collect_UnGoro_Stomper_Pelts"
step
kill Un'Goro Gorilla##6514+
|tip The gorillas share spawn points.
|tip If you can't find any more of these, kill the other types of gorillas to get them to spawn.
collect 2 Un'Goro Gorilla Pelt##11478 |q 4289/1 |goto 62.73,17.93
You can find more inside the cave at [63.95,16.44]
step
label "Collect_UnGoro_Stomper_Pelts"
kill Un'Goro Stomper##6513+
|tip The gorillas share spawn points.
|tip If you can't find any more of these, kill the other types of gorillas to get them to spawn.
collect 2 Un'Goro Stomper Pelt##11479 |q 4289/2 |goto 62.73,17.93
You can find more inside the cave at [63.95,16.44]
step
label "Collect_UnGoro_Thunderer_Pelts"
kill Un'Goro Thunderer##6516+
|tip All around inside the cave.
|tip The gorillas share spawn points.
|tip If you can't find any more of these, kill the other types of gorillas to get them to spawn.
collect 2 Un'Goro Thunderer Pelt##11480 |q 4289/3 |goto 64.05,16.34
step
Enter the cave |goto 63.88,16.44 < 15 |walk
Follow the path |goto 65.87,16.75 < 10 |walk
talk A-Me 01##9623
|tip Inside the cave.
turnin Chasing A-Me 01##4243 |goto 67.65,16.76
accept Chasing A-Me 01##4244 |goto 67.65,16.76
step
talk A-Me 01##9623
|tip Inside the cave.
turnin Chasing A-Me 01##4244 |goto 67.65,16.76
accept Chasing A-Me 01##4245 |goto 67.65,16.76
stickystart "Collect_Savage_Fronds"
step
Watch the dialogue
|tip Follow A-Me 01 and protect her as she walks.
|tip She eventually walks to this location.
Protect A-Me 01 Until You Reach Karna Remtravel |q 4245/1 |goto 46.47,13.43
step
talk Karna Remtravel##9618
turnin Chasing A-Me 01##4245 |goto 46.38,13.45
stickystart "Collect_Dinosaur_Bones"
stickystart "Collect_Webbed_Diemetradon_Scales"
stickystart "Collect_UnGoro_Slime_Samples"
step
Kill enemies around this area
Reach Level 53 |ding 53 |goto 47.05,17.27
stickystart "Kill_Bloodpetal_Lashers"
step
kill 5 Bloodpetal Thresher##6511 |q 4145/4 |goto 56.59,34.46
You can find more around: |notinsticky
[61.68,36.93]
[69.81,29.80]
step
label "Kill_Bloodpetal_Lashers"
kill 5 Bloodpetal Lasher##6509 |q 4145/1 |goto 69.81,29.80
You can find more around: |notinsticky
[61.68,36.93]
[56.59,34.46]
step
click Crate of Foodstuffs
collect Crate of Foodstuffs##11113 |q 3881/1 |goto 68.51,36.54
step
talk Torwa Pathfinder##9619
turnin The Apes of Un'Goro##4289 |goto 71.64,75.97
turnin The Fare of Lar'korwi##4290 |goto 71.64,75.97
accept The Scent of Lar'korwi##4291 |goto 71.64,75.97
accept The Mighty U'cha##4301 |goto 71.64,75.97
stickystart "Collect_White_Ravasaur_Claws"
step
kill Lar'korwi Mate##9683
|tip Stand on the pile of purple eggs to get it to appear.
collect 2 Ravasaur Pheromone Gland##11509 |q 4291/1 |goto 67.32,73.05
You can find more eggs at:
[62.87,80.48]
[60.92,72.23]
[66.60,66.73]
step
click A Wrecked Raft
accept It's a Secret to Everybody##3844 |goto 63.02,68.50
step
click A Small Pack
|tip Underwater.
turnin It's a Secret to Everybody##3844 |goto 63.12,69.02
accept It's a Secret to Everybody##3845 |goto 63.12,69.02
step
label "Collect_White_Ravasaur_Claws"
Kill Ravasaur enemies around this area
collect 8 White Ravasaur Claw##11477 |q 4300/1 |goto 65.60,70.85
You can find more around [67.02,59.15]
step
talk Torwa Pathfinder##9619
turnin The Scent of Lar'korwi##4291 |goto 71.63,75.97
accept The Bait for Lar'korwi##4292 |goto 71.63,75.97
stickystart "Collect_Gorishi_Scent_Gland"
step
Follow the path down |goto 50.53,78.43 < 20 |only if walking
Enter the cave |goto 49.95,81.70 < 10 |walk
Follow the path down |goto 49.48,83.08 < 10 |walk
use the Unused Scraping Vial##11132
|tip Inside the cave.
collect Hive Wall Sample##11131 |q 3883/1 |goto 48.74,85.21
step
Follow the path up |goto 49.20,84.45 < 10 |walk
Continue up the path |goto 49.64,82.55 < 10 |walk
Leave the cave |goto 49.94,81.65 < 10 |c |q 4496
step
label "Collect_Gorishi_Scent_Gland"
Kill Gorishi enemies around this area
|tip You can find more inside the bug cave in the ground nearby.
collect Gorishi Scent Gland##11837 |q 4496/1 |goto 50.66,77.01
stickystart "Kill_Bloodpetal_Trappers"
stickystart "Kill_Frenzied_Pterrordax"
step
click Research Equipment
collect Research Equipment##11112 |q 3881/2 |goto 38.47,66.11
step
talk Krakle##10302
accept Finding the Source##974 |goto 30.93,50.43
step
label "Kill_Bloodpetal_Trappers"
kill 5 Bloodpetal Trapper##6512 |q 4145/2 |goto 39.85,53.54
You can find more around [34.49,37.63]
step
label "Kill_Frenzied_Pterrordax"
kill 15 Frenzied Pterrordax##9167 |q 4501/2 |goto 34.49,37.63
You can find more around: |notinsticky
[39.05,47.06]
[28.28,33.06]
[24.15,38.86]
[27.09,46.40]
step
label "Collect_Dinosaur_Bones"
Kill Diemetradon enemies around this area
collect 8 Dinosaur Bone##11114 |q 3882/1 |goto 59.18,53.99
You can find more around: |notinsticky
[56.74,63.47]
[49.24,61.78]
[50.79,67.25]
[45.26,68.91]
[41.52,56.95]
step
label "Collect_Webbed_Diemetradon_Scales"
Kill Diemetradon enemies around this area
collect 8 Webbed Diemetradon Scale##11830 |q 4503/1 |goto 59.18,53.99
You can find more around: |notinsticky
[56.74,63.47]
[49.24,61.78]
[50.79,67.25]
[45.26,68.91]
[41.52,56.95]
step
label "Collect_UnGoro_Slime_Samples"
Kill Ooze enemies around this area
collect 40 Un'Goro Slime Sample##12235 |goto 57.48,65.95 |q 4294
You can find more around: |notinsticky
[45.09,68.24]
[38.49,48.67]
[38.42,31.93]
[27.92,35.59]
[25.51,45.45]
step
label "Collect_Savage_Fronds"
Kill Bloodpetal enemies around this area
|tip They look like walking plants.
collect 30 Savage Frond##22529 |goto 71.46,38.72 |q 9136 |future
You can find more around: |notinsticky
[69.26,24.59]
[66.08,35.13]
[55.87,34.69]
[41.91,27.10]
step
label "Collect_UnGoro_Soil"
click Un'Goro Dirt Pile+
|tip They look like piles of dark brown dirt on the ground around this area.
|tip You can find them all over the entire zone.
Kill enemies around this area
|tip Any enemy in Un'Goro Crater can drop the quest item.
collect 25 Un'Goro Soil##11018 |q 3761 |future
|tip Be careful not to accidentally sell these to a vendor.
step
label "Collect_Power_Crystals"
click Power Crystal+
|tip They look clusters of red, yellow, green, or blue crystals on the ground around this area.
|tip They tend to be around the base of trees, or near the cliffs surrounding Un'Goro Crater.
|tip You can find them all over the entire zone.
collect 7 Red Power Crystal##11186 |q 4284 |future |only if (11186) < 7
collect 7 Yellow Power Crystal##11188 |q 4284 |future |only if (11188) < 7
collect 7 Green Power Crystal##11185 |q 4284 |future |only if (11185) < 7
collect 7 Blue Power Crystal##11184 |q 4284 |future |only if (11184) < 7
step
label "Collect_A_Mangled_Journal"
Kill enemies around this area
|tip Any enemy in Un'Goro Crater can drop the quest item.
collect A Mangled Journal##11116 |q 3884 |future
step
use A Mangled Journal##11116
accept Williden's Journal##3884
step
Follow the path up |goto 42.96,14.36 < 20 |only if walking
talk Shizzle##9998
turnin Shizzle's Flyer##4503 |goto 44.23,11.59
step
talk Spraggle Frock##9997
turnin Beware of Pterrordax##4501 |goto 43.62,8.50
accept Lost!##4492 |goto 43.62,8.50
step
talk Spark Nilminer##9272
turnin Roll the Bones##3882 |goto 43.50,7.43
step
talk Hol'anyee Marshal##9271
turnin Alien Ecology##3883 |goto 43.89,7.24
step
talk Williden Marshal##9270
turnin Expedition Salvation##3881 |goto 43.95,7.14
turnin Williden's Journal##3884 |goto 43.95,7.14
step
Enter the cave |goto 43.47,6.81 < 15 |walk
Follow the path |goto 43.15,4.48 < 10 |walk
Continue following the path |goto 41.51,4.86 < 10 |walk
Continue following the path |goto 41.25,2.21 < 15 |walk
talk J.D. Collie##9117
|tip Inside the cave.
accept Crystals of Power##4284 |goto 41.92,2.70
step
talk J.D. Collie##9117
|tip Inside the cave.
turnin Crystals of Power##4284 |goto 41.92,2.70
accept The Northern Pylon##4285 |goto 41.92,2.70
accept The Eastern Pylon##4287 |goto 41.92,2.70
accept The Western Pylon##4288 |goto 41.92,2.70
step
Follow the path |goto 40.98,3.26 < 15 |walk
Continue following the path |goto 41.87,5.00 < 10 |walk
Continue following the path |goto 43.29,4.65 < 10 |walk
Leave the cave |goto 43.47,6.81 < 15 |walk
talk Larion##9118
turnin Larion and Muigin##4145 |goto 45.54,8.72
accept Marvon's Workshop##4147 |goto 45.54,8.72
step
use A Small Pack##11107
|tip You can destroy the Faded Photograph inside the pack.
|tip It's not used for anything.
collect Large Compass##11104 |q 3845/1
collect Curled Map Parchment##11105 |q 3845/2
collect Lion-headed Key##11106 |q 3845/3
step
talk Linken##8737
turnin It's a Secret to Everybody##3845 |goto 44.66,8.11
accept It's a Secret to Everybody##3908 |goto 44.66,8.11
stickystart "Collect_UnGoro_Ash"
stickystart "Collect_Core_Of_Elements_Confirm"
step
Follow the path down |goto 45.24,11.64 < 20 |only if walking
Follow the path up |goto 52.84,42.05 < 20 |only if walking
Follow the path up |goto 52.33,45.52 < 15 |only if walking
Continue up the path |goto 51.18,47.35 < 15 |only if walking
use Krakle's Thermometer##12472
Find the Hottest Area of Fire Plume Ridge |q 974/1 |goto 49.70,45.74
step
label "Collect_UnGoro_Ash"
Kill enemies around this area
|tip They look like fire elementals on and around this volcano mountain.
|tip Avoid the elite enemy in the cave at the top of the mountain.
collect 9 Un'Goro Ash##11829 |q 4502/1 |goto 50.98,47.18
step
label "Collect_Core_Of_Elements_Confirm"
Kill enemies around this area
|tip They look like fire elementals on and around this volcano mountain.
|tip Avoid the elite enemy in the cave at the top of the mountain.
collect Core of Elements##22527 |n
|tip You don't need a specific amount, just save any of these that you find
|tip They will be needed for a later quest.
Click Here to Continue |confirm |q 9128 |future
step
Follow the path |goto 52.64,45.77 < 20 |only if walking
Follow the path up |goto 52.32,47.34 < 15 |only if walking
Enter the cave |goto 52.44,51.07 < 15 |walk
talk Ringo##9999
|tip Inside the cave.
turnin Lost!##4492 |goto 51.90,49.85
accept A Little Help From My Friends##4491 |goto 51.90,49.85
step
Leave the cave |goto 52.50,51.16 < 15 |walk
Follow the path down |goto 54.19,50.77 < 15 |only if walking
Follow the path |goto 56.72,43.18 < 30 |only if walking
Follow the path up |goto 46.04,13.45 < 15 |only if walking
Watch the dialogue
|tip Ringo will follow you, protect him as you walk.
|tip He will pass out multiple times as he walks, so make sure he is with you at all times.
use Spraggle's Canteen##11804
|tip Use it on Ringo to revive him when he passes out.
Escort Ringo to Spraggle Frock at Marshal's Refuge |q 4491/1 |goto 43.62,8.51
step
talk Spraggle Frock##9997
turnin A Little Help From My Friends##4491 |goto 43.62,8.51
step
Follow the path down |goto 45.24,11.64 < 20 |only if walking
Follow the path |goto 50.36,18.06 < 30 |only if walking
Follow the path up |goto 54.83,13.49 < 15 |only if walking
click Northern Crystal Pylon
Discover and Examine the Northern Crystal Pylon |q 4285/1 |goto 56.48,12.45
step
Enter the cave |goto 63.94,16.39 < 15 |walk
Follow the path |goto 65.98,15.65 < 10 |walk
Continue following the path |goto 69.08,17.63 < 10 |walk
Continue following the path |goto 69.41,16.57 < 10 |walk
Continue following the path |goto 68.61,13.57 < 10 |walk
kill U'cha##9622
|tip Inside the cave.
collect U'cha's Pelt##11476 |q 4301/1 |goto 68.15,12.58
step
Follow the path |goto 67.12,15.31 < 10 |walk
Continue following the path |goto 64.94,16.63 < 10 |walk
Leave the cave |goto 63.88,16.43 < 15 |walk
Follow the path up |goto 76.66,48.69 < 15 |only if walking
click Eastern Crystal Pylon
Discover and Examine the Eastern Crystal Pylon |q 4287/1 |goto 77.24,49.97
step
use Torwa's Pouch##11568
collect Preserved Threshadon Meat##11569 |q 4292
collect Preserved Pheromone Mixture##11570 |q 4292
step
use the Preserved Threshadon Meat##11569
|tip Use this first.
use the Preserved Pheromone Mixture##11570
|tip Use this second.
kill Lar'korwi##9684
collect Lar'korwi's Head##11510 |q 4292/1 |goto 79.92,49.90
step
Follow the path down |goto 77.53,50.54 < 20 |only if walking
talk Torwa Pathfinder##9619
turnin The Bait for Lar'korwi##4292 |goto 71.63,75.96
turnin The Mighty U'cha##4301 |goto 71.63,75.96
step
Follow the path up |goto 24.20,61.28 < 15 |only if walking
click Western Crystal Pylon
Discover and Examine the Western Crystal Pylon |q 4288/1 |goto 23.79,59.19
step
talk Krakle##10302
turnin Finding the Source##974 |goto 30.93,50.44
accept The New Springs##980 |goto 30.93,50.44
step
Follow the path up |goto 43.01,14.27 < 15 |only if walking
Enter the cave |goto 43.47,6.81 < 15 |walk
Follow the path |goto 43.15,4.48 < 10 |walk
Continue following the path |goto 41.51,4.86 < 10 |walk
Continue following the path |goto 41.25,2.21 < 15 |walk
talk J.D. Collie##9117
|tip Inside the cave.
turnin The Northern Pylon##4285 |goto 41.92,2.70
turnin The Eastern Pylon##4287 |goto 41.92,2.70
turnin The Western Pylon##4288 |goto 41.92,2.70
accept Making Sense of It##4321 |goto 41.92,2.70
step
talk J.D. Collie##9117
|tip Inside the cave.
turnin Making Sense of It##4321 |goto 41.92,2.70
step
Follow the path |goto 40.98,3.26 < 15 |walk
Continue following the path |goto 41.87,5.00 < 10 |walk
Continue following the path |goto 43.29,4.65 < 10 |walk
Leave the cave |goto 43.47,6.81 < 15 |walk
Follow the path down |goto 45.24,11.64 < 20 |only if walking
Kill enemies around this area
Reach Level 54 |ding 54 |goto 47.05,17.27
step
Follow the path up |goto 45.99,13.46 < 15 |only if walking
Follow the path |goto Tanaris 51.87,26.53 < 15 |only if walking
talk Tran'rek##7876
turnin Super Sticky##4504 |goto Tanaris 51.57,26.76
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Bungle in the Jungle##4496 |goto 50.89,26.96
step
Enter the building |goto Thunder Bluff 50.98,36.86 < 15 |only if walking
Cross the hanging bridge |goto Thunder Bluff 55.87,34.46 < 10 |only if walking
Enter the building |goto Thunder Bluff 74.16,29.88 < 15 |walk
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
accept Un'Goro Soil##3761 |goto Thunder Bluff 78.59,28.55
step
Leave the building |goto 74.03,29.98 < 10 |walk
talk Ghede##9076
turnin Un'Goro Soil##3761 |goto 77.45,21.98
step
Enter the building |goto 74.16,29.88 < 15 |walk
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
accept Morrowgrain Research##3782 |goto 78.59,28.57
step
Leave the building |goto 74.03,29.98 < 10 |walk
talk Bashana Runetotem##9087
|tip Inside the building.
turnin Morrowgrain Research##3782 |goto 71.06,34.15
step
Enter the building |goto The Barrens 62.52,38.57 < 10 |walk
talk Liv Rizzlefix##8496
|tip Inside the building.
turnin Marvon's Workshop##4147 |goto The Barrens 62.45,38.73
turnin Volcanic Activity##4502 |goto The Barrens 62.45,38.73
step
Enter the building |goto Stranglethorn Vale 27.08,77.62 < 7 |walk
talk Shadowmage Vivian Lagrave##9078
turnin Vivian Lagrave##4133 |goto Badlands 2.90,47.76
step
talk Hierophant Theodora Mulvadania##9079
accept The Rise of the Machines##4061 |goto 3.02,47.80
step
talk Thal'trak Proudtusk##9082
|tip He walks along the path near Kargath.
accept Dreadmaul Rock##3821 |goto 3.36,48.07
You may also find him around:
[6.77,43.75]
[10.16,42.89]
[4.43,51.83]
[5.85,57.51]
step
talk Tinkee Steamboil##10267
accept Broodling Essence##4726 |goto Burning Steppes 65.24,24.00
step
talk Maxwort Uberglint##9536
accept Tablet of the Seven##4296 |goto 65.16,23.92
step
Enter the cave |goto 65.52,23.08 < 15 |walk
talk Yuka Screwspigot##9544
|tip Inside the cave.
turnin Yuka Screwspigot##4324 |goto 66.06,21.95
step
Leave the cave |goto 65.49,23.13 < 15 |walk
use the Draco-Incarcinatrix 900
|tip Use it on Broodling enemies around this area.
|tip They look like small flying dragons.
|tip It has a very small range, so get close to them to use it.
Kill Broodling enemies around this area
click Broodling Essence+
|tip They look like red floating crystals that appear above their corpses after you kill them.
collect 8 Broodling Essence##12283 |q 4726/1 |goto 59.26,32.49
You can find more around: |notinsticky
[72.83,28.41]
[80.05,27.94]
[87.34,32.01]
[91.96,35.64]
step
Enter the cave |goto 94.11,31.92 < 15 |walk
talk Cyrus Therepentous##9459
|tip Inside the cave.
accept A Taste of Flame##4022 |goto 95.06,31.57
step
talk Cyrus Therepentous##9459
|tip Inside the cave.
turnin A Taste of Flame##4022 |goto 95.06,31.57
step
Leave the cave |goto 94.05,31.98 < 15 |walk
Follow the path |goto 86.40,31.18 < 30 |only if walking
Continue following the path |goto 76.59,32.46 < 30 |only if walking
Follow the path up |goto 75.39,38.29 < 15 |only if walking
Continue up the path |goto 78.15,39.28 < 15 |only if walking
click Sha'ni Proudtusk's Remains
talk Sha'ni Proudtusk##9136
turnin Dreadmaul Rock##3821 |goto 79.79,45.52
accept Krom'Grul##3822 |goto 79.79,45.52
step
Enter the cave |goto 81.07,44.88 < 15 |walk
kill Krom'Grul##8977
|tip Inside the cave.
|tip He may not be here.
collect Sha'ni's Nose-Ring##11058 |q 3822/1 |goto 81.65,43.83 |or |next "Collect_Dark_Iron_Scraps"
_Or_
Click Here if He's Not in this Cave |confirm |or |next "West_Cave"
step
label "West_Cave"
Enter the cave |goto 77.00,47.68 < 10 |walk
kill Krom'Grul##8977
|tip Inside the cave.
|tip He may not be here.
|tip He sometimes walks around, so check this entire cave before deciding he's not in this cave.
collect Sha'ni's Nose-Ring##11058 |q 3822/1 |goto 79.01,44.34 |or |next "Collect_Dark_Iron_Scraps"
_Or_
Click Here if He's Not in this Cave |confirm |or |next "East_Cave"
step
label "East_Cave"
Follow the path |goto 77.47,46.27 < 10 |walk
Leave the cave |goto 76.92,47.76 < 15 |walk
Follow the path up |goto 77.95,34.53 < 15 |only if walking
Enter the cave |goto 82.80,38.85 < 15 |walk
Follow the path |goto 81.32,41.82 < 10 |walk
Follow the path |goto 79.87,44.43 < 10 |walk
kill Krom'Grul##8977
|tip Inside the cave.
|tip He should be here, if you already checked the other 2 caves.
collect Sha'ni's Nose-Ring##11058 |q 3822/1 |goto 79.69,47.38
step
Follow the path |goto 80.34,45.27 < 10 |walk
Continue following the path |goto 80.44,42.71 < 10 |walk
Continue following the path |goto 81.51,41.16 < 10 |walk
Leave the cave |goto 82.87,38.77 < 15 |c |q 3822 |next "Collect_Dark_Iron_Scraps"
step
label "Collect_Dark_Iron_Scraps"
Kill Firegut enemies around this area
|tip They look like ogres.
collect 30 Dark Iron Scraps##22528 |goto 75.63,38.36 |q 9131 |future
You can find more in the caves at:
[77.00,47.68]
[82.80,38.85]
step
kill War Reaver##7039+
collect 10 Fractured Elemental Shard##11266 |q 4061/1 |goto 67.95,38.14
You can find more around: |notinsticky
[63.32,41.34]
[59.91,35.25]
[53.03,38.88]
step
click Tablet of the Seven
collect Tablet Transcript##11470 |q 4296/1 |goto 54.09,40.73
step
Follow the path up |goto 63.92,29.88 < 15 |only if walking
talk Tinkee Steamboil##10267
turnin Broodling Essence##4726 |goto 65.23,23.99
accept Felnok Steelspring##4808 |goto 65.23,23.99
step
talk Maxwort Uberglint##9536
turnin Tablet of the Seven##4296 |goto 65.15,23.91
step
talk Hierophant Theodora Mulvadania##9079
turnin The Rise of the Machines##4061 |goto Badlands 3.02,47.81
accept The Rise of the Machines##4062 |goto Badlands 3.02,47.81
step
talk Thal'trak Proudtusk##9082
|tip He walks along the path near Kargath.
turnin Krom'Grul##3822 |goto 3.36,48.07
You may also find him around:
[6.77,43.75]
[10.16,42.89]
[4.43,51.83]
[5.85,57.51]
step
Follow the path |goto 7.11,43.53 < 20 |only if walking
talk Lotwil Veriatus##2921
turnin The Rise of the Machines##4062 |goto 25.94,44.87
step
Enter the building |goto Orgrimmar 47.45,65.14 < 10 |only if walking
talk Ag'tor Bloodfist##8576
accept Betrayed##3505 |goto Azshara 22.26,51.48
step
Follow the path |goto 27.60,50.12 < 30 |only if walking
Continue following the path |goto 43.15,36.73 < 30 |only if walking
Follow the path up |goto 53.02,19.64 < 20 |only if walking
talk Kim'jael##8420
accept Kim'jael Indeed!##3601 |goto 53.45,21.82
stickystart "Kill_Blood_Elf_Reclaimers"
stickystart "Kill_Blood_Elf_Surveyors"
step
Follow the path up |goto 55.26,28.01 < 20 |only if walking
click Kim'jael's Equipment
|tip They look like wooden boxes on the ground around this area.
|tip Some of them may be empty.
|tip They respawn, and can contain new items, so check them repeatedly.
collect Kim'Jael's Compass##10717 |q 3601/1 |goto 56.09,30.20
collect Kim'Jael's Scope##10715 |q 3601/2 |goto 56.09,30.20
collect Kim'Jael's Stuffed Chicken##10722 |q 3601/3 |goto 56.09,30.20
collect Kim'Jael's Wizzlegoober##10718 |q 3601/4 |goto 56.09,30.20
You can find more boxes at:
[56.29,28.76]
[57.03,28.30]
[58.55,29.05]
[58.76,28.71]
[59.61,30.93]
step
Find Magus Rimtori's Camp |q 3505/1 |goto 59.30,31.00
step
label "Kill_Blood_Elf_Reclaimers"
kill 10 Blood Elf Reclaimer##6199 |q 3505/2 |goto 58.98,29.54
You can find more around: |notinsticky
[57.83,26.05]
[55.24,26.84]
[56.07,29.74]
step
label "Kill_Blood_Elf_Surveyors"
kill 10 Blood Elf Surveyor##6198 |q 3505/3 |goto 58.98,29.54
You can find more around: |notinsticky
[57.83,26.05]
[55.24,26.84]
[56.07,29.74]
step
click Kaldorei Tome of Summoning
turnin Betrayed##3505 |goto 59.51,31.30
accept Betrayed##3506 |goto 59.51,31.30
step
click Arcane Focusing Crystal
Kill the enemies that attack
kill Magus Rimtori##8578
collect Head of Magus Rimtori##10597 |q 3506/1 |goto 59.55,31.52
step
Follow the path up |goto 53.02,19.64 < 20 |only if walking
talk Kim'jael##8420
turnin Kim'jael Indeed!##3601 |goto 53.45,21.82
accept Kim'jael's "Missing" Equipment##5534 |goto 53.45,21.82
step
Follow the path |goto 46.11,31.60 < 40 |only if walking
Follow the path down |goto 45.27,37.09 < 20 |only if walking
Kill Spitelash enemies around this area
collect Some Rune##13815 |q 5534/1 |goto 47.65,43.93
|tip This has a low drop rate.
You can find more around: |notinsticky
[46.76,53.80]
[48.51,64.11]
step
Follow the path |goto 46.88,41.01 < 20 |only if walking
Follow the path |goto 44.82,36.98 < 20 |only if walking
Continue following the path |goto 41.99,37.17 < 30 |only if walking
Continue following the path |goto 27.60,50.13 < 30 |only if walking
talk Ag'tor Bloodfist##8576
turnin Betrayed##3506 |goto 22.26,51.48
accept Betrayed##3507 |goto 22.26,51.48
step
Follow the path |goto 27.60,50.12 < 30 |only if walking
Continue following the path |goto 43.15,36.73 < 30 |only if walking
Follow the path up |goto 53.02,19.64 < 20 |only if walking
talk Kim'jael##8420
turnin Kim'jael's "Missing" Equipment##5534 |goto 53.45,21.82
step
Follow the path |goto Orgrimmar 51.62,57.97 < 20 |only if walking
Enter the building |goto Orgrimmar 56.47,35.25 < 10 |walk
talk Jes'rimon##8659
|tip Upstairs on the balcony of the building.
turnin Bone-Bladed Weapons##4300 |goto Orgrimmar 55.52,34.09
step
Follow the path |goto 62.81,38.96 < 20 |only if walking
talk Belgrom Rockmaul##4485
turnin Betrayed##3507 |goto 75.22,34.24
step
Follow the path |goto 67.60,39.26 < 20 |only if walking
Continue following the path |goto 52.15,57.59 < 20 |only if walking
Enter the building |goto 47.48,65.16 < 10 |only if walking
Follow the path |goto Ashenvale 73.52,63.51 < 15 |only if walking
Follow the path |goto Ashenvale 72.14,64.02 < 20 |only if walking
Continue following the path |goto Ashenvale 66.42,61.55 < 30 |only if walking
Follow the road |goto Ashenvale 63.80,52.48 < 30 |only if walking
Continue following the road |goto Ashenvale 55.82,31.72 < 30 |only if walking
Follow the path up |goto Felwood 51.11,84.04 < 30 |only if walking
talk Greta Mosshoof##10922
accept Forces of Jaedenar##5155 |goto Felwood 51.21,82.11
step
talk Taronn Redfeather##10921
|tip Inside the building.
accept Verifying the Corruption##5156 |goto 50.89,81.62
step
Follow the road |goto 49.83,83.89 < 30 |only if walking
talk Maybess Riverbreeze##9529
|tip She walks around this area.
accept Cleansing Felwood##4102 |goto 46.68,82.98
step
Follow the road |goto 47.36,82.26 < 30 |only if walking
Follow the path |goto 42.09,72.25 < 20 |only if walking
kill Cursed Ooze##7086+
collect 40 Felwood Slime Sample##12230 |goto 41.22,71.29 |q 4293
You can find more around: |notinsticky
[38.97,72.26]
[40.06,67.15]
[41.93,67.38]
stickystart "Kill_Jaedenar_Guardians"
stickystart "Kill_Jaedenar_Adepts"
stickystart "Kill_Jaedenar_Cultists"
step
Follow the road |goto 42.64,65.46 < 30 |only if walking
Follow the path |goto 41.12,57.60 < 20 |only if walking
kill 4 Jaedenar Hound##7125 |q 5155/1 |goto 38.87,58.49
|tip You can find more in the caves nearby in this area.
You can find more around: |notinsticky
[37.87,60.72]
[35.12,60.26]
step
label "Kill_Jaedenar_Guardians"
kill 4 Jaedenar Guardian##7113 |q 5155/2 |goto 38.87,58.49
|tip You can find more in the caves nearby in this area.
You can find more around: |notinsticky
[37.87,60.72]
[35.12,60.26]
step
label "Kill_Jaedenar_Adepts"
kill 6 Jaedenar Adept##7115 |q 5155/3 |goto 38.87,58.49
|tip You can find more in the caves nearby in this area.
You can find more around: |notinsticky
[37.87,60.72]
[35.12,60.26]
step
label "Kill_Jaedenar_Cultists"
kill 6 Jaedenar Cultist##7112 |q 5155/4 |goto 38.87,58.49
|tip You can find more in the caves nearby in this area.
You can find more around: |notinsticky
[37.87,60.72]
[35.12,60.26]
step
Follow the path |goto 39.23,58.26 < 30 |only if walking
Follow the road |goto 41.38,57.58 < 30 |only if walking
Follow the path |goto 40.89,50.69 < 30 |only if walking
Continue following the path |goto 37.84,49.02 < 20 |only if walking
Continue following the path |goto 35.80,49.69 < 20 |only if walking
talk Winna Hazzard##9996
accept Well of Corruption##4505 |goto 34.21,52.34
step
talk Dreka'Sur##9620
accept A Husband's Last Battle##6162 |goto 34.80,52.73
step
talk Trull Failbane##10306
accept Wild Guardians##4521 |goto 34.73,52.80
step
talk Brakkar##11900
fpath Bloodvenom Post |goto 34.44,53.96
stickystart "Kill_Entropic_Beasts"
stickystart "Kill_Entropic_Horrors"
step
Follow the path |goto 35.78,49.66 < 20 |only if walking
Follow the path up |goto 37.86,48.28 < 30 |only if walking
Explore the Craters in Shatter Scar Vale |q 5156/1 |goto 41.54,42.98
step
label "Kill_Entropic_Beasts"
kill 2 Entropic Beast##9878 |q 5156/2 |goto 41.36,41.19
|tip Be careful to avoid the elite Infernal Sentries around this area.
step
label "Kill_Entropic_Horrors"
kill 2 Entropic Horror##9879 |q 5156/3 |goto 41.36,41.19
|tip Be careful to avoid the elite Infernal Sentries around this area.
step
Kill enemies around this area
|tip Be careful to avoid the elite Infernal Sentries around this area.
Reach Level 55 |ding 55 |goto 41.36,41.19
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (55-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
startlevel=55,
endlevel=60,
},[[
author support@zygorguides.com
stickystart "Kill_Angerclaw_Grizzlies"
stickystart "Kill_Felpaw_Ravagers"
step
Follow the road |goto Felwood 39.15,37.57 < 30 |only if walking
Continue following the road |goto Felwood 41.14,24.18 < 30 |only if walking
Follow the path |goto Felwood 48.96,15.31 < 30 |only if walking
Kill Warpwood enemies around this area
collect 15 Blood Amber##11503 |q 4102/1 |goto Felwood 54.83,16.51
You can find more inside the cave at [55.76,16.86]
step
label "Kill_Angerclaw_Grizzlies"
kill 12 Angerclaw Grizzly##8957 |q 4120/1 |goto 53.01,15.91
You can find more around: |notinsticky
[56.24,21.15]
[56.77,25.02]
[54.68,24.72]
[53.48,28.22]
[58.13,16.84]
[61.85,17.37]
[64.07,20.11]
step
label "Kill_Felpaw_Ravagers"
kill 12 Felpaw Ravager##8961 |q 4120/2 |goto 56.24,21.15
You can find more around: |notinsticky
[56.77,25.02]
[54.68,24.72]
[53.48,28.22]
[58.13,16.84]
[61.85,17.37]
[64.07,20.11]
step
Follow the road |goto 64.18,15.20 < 20 |only if walking
talk Nafien##15395
accept Deadwood of the North##8461 |goto 64.77,8.13
stickystart "Kill_Deadwood_Avengers"
stickystart "Kill_Deadwood_Shamans"
stickystart "Timbermaw_Hold_Unfriendly"
step
kill 6 Deadwood Den Watcher##7156 |q 8461/1 |goto 63.08,8.82
You can find more around: |notinsticky
[60.37,8.40]
[60.18,6.14]
[62.67,12.48]
step
label "Kill_Deadwood_Avengers"
kill 6 Deadwood Avenger##7157 |q 8461/2 |goto 63.08,8.82
You can find more around: |notinsticky
[60.37,8.40]
[60.18,6.14]
[62.67,12.48]
step
label "Kill_Deadwood_Shamans"
kill 6 Deadwood Shaman##7158 |q 8461/3 |goto 63.08,8.82
You can find more around: |notinsticky
[60.37,8.40]
[60.18,6.14]
[62.67,12.48]
step
label "Timbermaw_Hold_Unfriendly"
Kill Deadwood enemies around this area
Reach Unfriendly Reputation with the Timbermaw Hold Faction |condition rep('Timbermaw Hold') >= Unfriendly |goto 63.08,8.82
You can find more around: |notinsticky
[60.37,8.40]
[60.18,6.14]
[62.67,12.48]
step
Follow the road |goto 64.18,15.20 < 20 |only if walking
talk Nafien##15395
|tip You may have Deadwood Headdress Feathers from killing Deadwood enemies nearby.
|tip Turn in any feathers you have with the "Feathers for Nafien" repeatable quest.
|tip It's not necessary to grind this reputation right now.
turnin Deadwood of the North##8461 |goto 64.77,8.13
accept Speak to Salfa##8465 |goto 64.77,8.13
step
Enter the tunnel |goto 65.13,8.01 < 10 |walk
Run down the stairs |goto 66.03,3.31 < 10 |walk
Follow the path |goto 65.36,2.34 < 10 |walk
Leave the tunnel |goto 0.00,0.00 < 10 |walk
talk Faustron##12740
fpath Moonglade |goto Moonglade 32.09,66.61
step
Follow the road up |goto 35.17,65.99 < 15 |only if walking
Enter the tunnel |goto 35.74,72.49 < 10 |walk
Run up the stairs |goto Felwood 65.85,3.54 < 10 |walk
Follow the path |goto Felwood 66.26,2.90 < 10 |walk
Leave the tunnel |goto Felwood 68.40,5.84 < 10 |walk
talk Salfa##11556
turnin Speak to Salfa##8465 |goto Winterspring 27.74,34.50
accept Winterfall Activity##6241 |goto Winterspring 27.74,34.50
step
talk Donova Snowden##9298
accept Threat of the Winterfall##5082 |goto 31.27,45.17
turnin The New Springs##980 |goto 31.27,45.17
accept Strange Sources##4842 |goto 31.27,45.17
turnin It's a Secret to Everybody##3844 |goto 31.27,45.17
step
Follow the road |goto 33.52,41.98 < 30 |only if walking
Continue following the road |goto 47.25,39.41 < 30 |only if walking
Continue following the road |goto 53.67,34.46 < 30 |only if walking
Follow the path |goto 59.20,38.75 < 30 |only if walking
talk Yugrek##11139
fpath Everlook |goto 60.47,36.30
step
Follow the path |goto 60.55,38.20 < 15 |only if walking
talk Umi Rumplesnicker##10305
accept Are We There, Yeti?##3783 |goto 60.88,37.62
step
talk Harlo Wigglesworth##11755
accept A Little Luck##6606 |goto 61.12,38.43
step
Enter the building |goto 61.32,38.72 < 10 |walk
talk Innkeeper Vizzie##11118
|tip Inside the building.
home Everlook |goto 61.36,38.83
step
talk Gregor Greystone##10431
|tip Inside the building.
accept The Everlook Report##6029 |goto 61.35,38.97
accept Duke Nicholas Zverenhoff##6030 |goto 61.35,38.97
step
talk Jessica Redpath##11629
|tip Inside the building.
accept Sister Pamela##5601 |goto 61.28,38.98
step
Leave the building |goto 61.32,38.73 < 7 |walk
talk Felnok Steelspring##10468
turnin Felnok Steelspring##4808 |goto 61.63,38.61
step
talk Witch Doctor Mau'ari##10307
turnin A Little Luck##6606 |goto 61.92,38.30
step
Follow the path |goto 60.56,38.20 < 15 |only if walking
Follow the road |goto 60.57,39.76 < 30 |only if walking
Kill Ice Thistle enemies around this area
collect 10 Thick Yeti Fur##12366 |q 3783/1 |goto 66.79,43.34
You can find more inside the cave at [67.65,41.75]
step
Follow the road |goto 64.08,43.36 < 30 |only if walking
Cross the bridge |goto 62.42,67.44 < 30 |only if walking
Discover Darkwhisper Gorge |q 4842/1 |goto 59.84,74.12
step
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##3783 |goto 60.88,37.62
accept Are We There, Yeti?##977 |goto 60.88,37.62
step
Follow the path |goto 60.56,38.21 < 15 |only if walking
Follow the path |goto 60.93,36.11 < 20 |only if walking
Continue following the path |goto 64.58,33.67 < 30 |only if walking
kill 8 Winterfall Den Watcher##7440 |q 5082/2 |goto 66.92,35.15
kill 8 Winterfall Den Watcher##7440 |q 6241/2 |goto 66.92,35.15
step
Follow the path |goto 64.47,33.70 < 30 |only if walking
kill 15 Raging Owlbeast##7451 |q 4521/1 |goto 60.13,34.07
You can find more around: |notinsticky
[58.04,33.18]
[54.70,32.29]
[55.70,28.23]
[51.38,33.81]
step
kill 15 Ragged Owlbeast##7450 |q 4521/2 |goto 54.55,37.31
You can find more around: |notinsticky
[52.48,38.20]
[51.43,39.38]
[49.83,39.97]
[47.37,42.74]
[45.24,42.58]
[46.82,37.49]
[45.54,35.78]
[44.28,37.81]
[42.53,36.68]
[38.76,38.12]
stickystart "Kill_Winterfall_Pathfinders"
stickystart "Collect_Empty_Firewater_Flask"
step
kill 8 Winterfall Totemic##7441 |q 5082/1 |goto 41.78,43.14
kill 8 Winterfall Totemic##7441 |q 6241/1 |goto 41.78,43.14
You can find more around: |notinsticky
[39.46,43.70]
[30.57,37.17]
step
label "Kill_Winterfall_Pathfinders"
kill 8 Winterfall Pathfinder##7442 |q 5082/3 |goto 41.78,43.14
kill 8 Winterfall Pathfinder##7442 |q 6241/3 |goto 41.78,43.14
You can find more around: |notinsticky
[39.46,43.70]
[30.57,37.17]
step
label "Collect_Empty_Firewater_Flask"
Kill Winterfall enemies around this area
collect Empty Firewater Flask##12771 |goto 41.78,43.14 |q 5083 |future
You can find more around: |notinsticky
[39.46,43.70]
[30.57,37.17]
step
use the Empty Firewater Flask##12771
accept Winterfall Firewater##5083
step
talk Donova Snowden##9298
turnin Strange Sources##4842 |goto 31.27,45.16
turnin Threat of the Winterfall##5082 |goto 31.27,45.16
turnin Winterfall Firewater##5083 |goto 31.27,45.16
accept Falling to Corruption##5084 |goto 31.27,45.16
step
Follow the road |goto 29.93,42.27 < 30 |only if walking
talk Salfa##11556
turnin Winterfall Activity##6241 |goto 27.74,34.50
step
Follow the path |goto 60.56,38.20 < 15 |only if walking
Follow the road |goto 60.57,39.76 < 30 |only if walking
Kill Ice Thistle enemies around this area
|tip Only the Matriarchs or Patriarchs will drop the quest item.
collect 2 Pristine Yeti Horn##12367 |q 977/1 |goto 66.79,43.34
|tip These have a very low drop rate, so may take a while.
You can find more inside the cave at [67.65,41.75]
step
Follow the road |goto 63.07,41.85 < 30 |only if walking
Follow the path |goto 60.47,39.63 < 30 |only if walking
Follow the path |goto 60.56,38.20 < 15 |walk
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##977 |goto 60.88,37.62
accept Are We There, Yeti?##5163 |goto 60.88,37.62
step
use Umi's Mechanical Yeti##12928
|tip Use it on Legacki.
Scare Legacki |q 5163/1 |goto 61.54,38.62
step
Follow the path |goto 60.56,38.20 < 15 |only if walking
talk Trull Failbane##10306
turnin Wild Guardians##4521 |goto Felwood 34.73,52.79
step
Follow the path |goto 35.88,49.47 < 20 |only if walking
Follow the road |goto 41.50,51.37 < 30 |only if walking
Cross the bridge |goto 43.44,74.68 < 20 |only if walking
talk Maybess Riverbreeze##9529
|tip She walks around this area.
turnin Cleansing Felwood##4101 |goto 46.72,83.07
step
talk Maybess Riverbreeze##9529
|tip She walks around this area.
Tell her _"Please make me a Cenarion Beacon."_
collect Cenarion Beacon##11511 |goto 46.72,83.07 |q 5882 |future
step
Kill enemies around this area
collect 6 Corrupted Soul Shard##11515 |goto 49.00,82.82 |q 5882 |future
You can find more around [48.73,78.84]
step
talk Maybess Riverbreeze##9529
|tip She walks around this area.
turnin Salve via Hunting##5882 |goto 46.72,83.07
step
Follow the path |goto 50.21,83.69 < 30 |only if walking
talk Greta Mosshoof##10922
turnin Forces of Jaedenar##5155 |goto 51.21,82.11
accept Collection of the Corrupt Water##5157 |goto 51.21,82.11
step
talk Taronn Redfeather##10921
|tip Inside the building.
turnin Verifying the Corruption##5156 |goto 50.89,81.62
step
talk Grazle##11554
accept Timbermaw Ally##6131 |goto 50.93,85.01
stickystart "Kill_Deadwood_Pathfinders"
stickystart "Kill_Deadwood_Gardeners"
step
kill 5 Deadwood Warrior##7153 |q 6131/1 |goto 48.77,89.62
You can find more around: |notinsticky
[46.51,88.13]
[48.32,92.99]
step
label "Kill_Deadwood_Pathfinders"
kill 5 Deadwood Pathfinder##7155 |q 6131/2 |goto 48.77,89.62
You can find more around: |notinsticky
[46.51,88.13]
[48.32,92.99
step
label "Kill_Deadwood_Gardeners"
kill 5 Deadwood Gardener##7154 |q 6131/3 |goto 48.77,89.62
You can find more around: |notinsticky
[46.51,88.13]
[48.32,92.99
step
Kill enemies around this area
Reach Level 56 |ding 56 |goto 48.32,92.99
You can find more around: |notinsticky
[46.51,88.13]
[48.77,89.62]
step
Follow the path |goto 49.56,88.70 < 30 |only if walking
talk Grazle##11554
turnin Timbermaw Ally##6131 |goto 50.93,85.02
accept Speak to Nafien##8462 |goto 50.93,85.02
step
Follow the road |goto 47.56,83.79 < 30 |only if walking
Follow the path |goto 42.11,72.25 < 20 |only if walking
Follow the path up |goto 38.68,69.52 < 30 |only if walking
Follow the path |goto 36.77,66.93 < 30 |only if walking
use the Hardened Flasket##12566
collect Filled Flasket##12567 |q 4505/1 |goto 32.41,66.58
step
Follow the path |goto 38.19,66.66 < 30 |only if walking
Follow the road |goto 42.45,65.00 < 30 |only if walking
Follow the path |goto 41.15,57.60 < 30 |only if walking
Continue following the path |goto 38.26,60.08 < 30 |only if walking
use the Empty Canteen##12922
collect Corrupt Moonwell Water##12907 |q 5157/1 |goto 35.19,59.95
step
Follow the path |goto 36.57,61.28 < 30 |only if walking
Continue following the path |goto 39.21,58.30 < 30 |only if walking
Follow the road |goto 41.36,57.50 < 30 |only if walking
Follow the path down |goto 40.86,50.88 < 30 |only if walking
Continue following the path |goto 37.51,49.03 < 20 |only if walking
Follow the path up |goto 35.20,49.58 < 30 |only if walking
talk Winna Hazzard##9996
turnin Well of Corruption##4505 |goto 34.21,52.34
step
Watch the dialogue
talk Winna Hazzard##9996
accept Corrupted Sabers##4506 |goto 34.21,52.34
step
talk Dreka'Sur##9620
turnin A Husband's Last Battle##6162 |goto 34.80,52.73
step
Follow the path |goto 35.93,49.44 < 20 |only if walking
Follow the road |goto 41.19,50.83 < 30 |only if walking
Follow the path |goto 41.57,63.62 < 30 |only if walking
Follow the path up |goto 39.68,64.95 < 20 |only if walking
Follow the path |goto 38.21,66.68 < 30 |only if walking
use Winna's Kitten Carrier##12565
|tip Use it next to the green moonwell.
|tip A Corrupted Saber will begin following you.
Click Here Once the Corrupted Saber is Following You |confirm |goto 32.42,66.59 |q 4506
step
Follow the path |goto 36.57,61.28 < 30 |only if walking
Continue following the path |goto 39.21,58.30 < 30 |only if walking
Follow the road |goto 41.36,57.50 < 30 |only if walking
Follow the path down |goto 40.86,50.88 < 30 |only if walking
Continue following the path |goto 37.51,49.03 < 20 |only if walking
Follow the path up |goto 35.20,49.58 < 30 |only if walking
talk Corrupted Saber##10042
|tip It should still be following you.
Choose _"I want to release the corrupted saber to Winna."_
Return the Corrupted Cat to Winna Hazzard |q 4506/1 |goto 34.21,52.34
step
talk Winna Hazzard##9996
turnin Corrupted Sabers##4506 |goto 34.21,52.34
step
Follow the path |goto 35.93,49.44 < 20 |only if walking
Follow the road |goto 41.19,50.83 < 30 |only if walking
Cross the bridge |goto 43.44,74.72 < 20 |only if walking
Follow the road |goto 47.67,83.83 < 30 |only if walking
Follow the path up |goto 50.20,83.67 < 30 |only if walking
talk Greta Mosshoof##10922
turnin Collection of the Corrupt Water##5157 |goto 51.21,82.11
step
Follow the road |goto 49.96,83.97 < 30 |only if walking
Cross the bridge |goto 43.79,75.37 < 20 |only if walking
Cross the bridge |goto 41.01,48.74 < 20 |only if walking
Follow the road |goto 38.69,41.10 < 30 |only if walking
Continue following the road |goto 41.11,24.24 < 30 |only if walking
Follow the path |goto 61.74,15.15 < 30 |only if walking
Follow the path up |goto 60.53,8.02 < 30 |only if walking
click Deadwood Cauldron
turnin Falling to Corruption##5084 |goto 60.20,5.87
accept Mystery Goo##5085 |goto 60.20,5.87
step
Follow the road up |goto 64.11,15.19 < 20 |only if walking
talk Nafien##15395
turnin Speak to Nafien##8462 |goto 64.77,8.13
step
Enter the tunnel |goto 65.12,8.01 < 15 |walk
Follow the path |goto 66.25,2.90 < 10 |walk
Leave the tunnel |goto 68.44,5.89 < 15 |walk
talk Donova Snowden##9298
turnin Mystery Goo##5085 |goto Winterspring 31.27,45.16
accept Toxic Horrors##5086 |goto Winterspring 31.27,45.16
step
Follow the path |goto 60.56,38.20 < 15 |only if walking
Follow the path |goto Orgrimmar 52.55,85.06 < 20 |only if walking
Leave Orgrimmar |goto Orgrimmar 49.11,94.95 < 20 |only if walking
Enter Undercity |goto Tirisfal Glades 61.88,65.05 < 20 |c |q 5094 |future
step
talk Innkeeper Norman##6741
home Undercity |goto 67.73,37.89
step
talk Harbinger Balthazad##10879
|tip He walks around this area in the middle of Undercity.
|tip He's wearing holding a lantern, wearing a white shirt.
accept A Call to Arms: The Plaguelands!##5094 |goto 63.81,44.07
step
Follow the path |goto 62.94,48.61 < 15 |walk
Follow the path down |goto 52.91,77.53 < 10 |walk
click Testing Equipment
|tip It looks like a bowl with red liquid in it, on the table.
|tip Turn in the "Testing for Corruption - Felwood" quest.
collect Corrupt Tested Sample##15103 |n
use the Corrupt Tested Sample##15103
collect 5 Corrupted Felwood Sample##12234 |q 4293/1 |goto 47.85,73.45
|tip Keep repeating this process until you get all of these.
step
click Testing Equipment
|tip It looks like a bowl with green liquid in it, on the table.
|tip Turn in the "Testing for Impurities - Un'Goro Crater" quest.
collect Un'Goro Tested Sample##15102 |n
use the Un'Goro Tested Sample##15102
collect 5 Pure Un'Goro Sample##12236 |q 4294/1 |goto 47.74,73.55
|tip Keep repeating this process until you get all of these.
step
talk Chemist Fuely##10136
turnin A Sample of Slime...##4293 |goto 47.45,73.36
turnin ... and a Batch of Ooze##4294 |goto 47.45,73.36
accept Melding of Influences##4642 |goto 47.45,73.36
step
Destroy Extra Slime Samples
|tip Destroy any Felwood Slime Samples and Un'Goro Slime Samples you may have.
|tip You don't need them anymore.
Click Here to Continue |confirm |q 4642
step
Follow the path up |goto 48.05,76.76 < 10 |walk
talk Auctioneer Rhyker##15686
|tip Buy these items from the Auction House.
collect 2 Thorium Bar##12359 |goto 60.47,46.45 |q 6026 |future
collect Golden Rod##11128 |goto 60.47,46.45 |q 6026 |future
collect 8 Hi-Explosive Bomb##10562 |goto 60.47,46.45 |q 6026 |future
collect 8 Unstable Trigger##10560 |goto 60.47,46.45 |q 6026 |future
step
Leave Undercity |goto 66.23,0.23 < 15 |only if walking
Follow the road |goto Tirisfal Glades 65.16,59.89 < 30 |only if walking
talk Mickey Levine##11615
accept A Plague Upon Thee##6389 |goto Tirisfal Glades 83.29,72.33
step
talk High Executor Derrington##10837
turnin A Call to Arms: The Plaguelands!##5093 |goto 83.13,68.93
accept Scarlet Diversions##5096 |goto 83.13,68.93
step
click Box of Incendiaries
collect Flame in a Bottle##12814 |goto 83.17,69.09 |q 5096
step
talk Argent Officer Garush##10839
turnin The Everlook Report##6028 |goto 83.19,68.45
accept Argent Dawn Commission##5503 |goto 83.19,68.45
step
use the Argent Dawn Commission##12846
|tip Wearing it will allow Minion's Scourgestones to drop from undead enemies in Western and Eastern Plaguelands.
Gain the Argent Dawn Commission Buff |havebuff 12345 |q 5402 |future
stickystart "Collect_Minions_Scourgestones"
stickystart "Collect_Bone_Fragments"
step
Follow the road |goto 84.50,70.40 < 20 |only if walking
Enter the building |goto Western Plaguelands 38.04,54.61 < 10 |walk
talk Janice Felstone##10778
|tip Upstairs inside the building.
accept Better Late Than Never##5021 |goto Western Plaguelands 38.40,54.05
step
Leave the building |goto 38.03,54.63 < 7 |walk
Enter the building |goto 38.52,55.33 < 10 |walk
click Janice's Parcel
|tip Inside the building.
|tip You will have to click it twice.
turnin Better Late Than Never##5021 |goto 38.73,55.24
accept Better Late Than Never##5023 |goto 38.73,55.24
step
Leave the building |goto 38.54,55.32 < 7 |walk
click Command Tent
use the Scourge Banner##12807
Destroy the Command Tent and Plant the Scourge Banner in the Camp |q 5096/1 |goto 40.68,51.98
step
label "Collect_Minions_Scourgestones"
Kill enemies in around this area
|tip Only undead enemies will drop the quest item.
collect 20 Minion's Scourgestone##12840 |goto 36.76,56.42 |q 9141 |future
step
label "Collect_Bone_Fragments"
Kill enemies in around this area
|tip Only skeleton enemies will drop the quest item.
collect 30 Bone Fragments##22526 |goto 36.76,56.42 |q 9126 |future
step
Follow the road |goto 33.16,60.34 < 30 |only if walking
Follow the path |goto Tirisfal Glades 84.55,70.40 < 20 |only if walking
talk High Executor Derrington##10837
turnin Scarlet Diversions##5096 |goto Tirisfal Glades 83.13,68.93
accept The Scourge Cauldrons##5228 |goto Tirisfal Glades 83.13,68.93
step
talk Shadow Priestess Vandis##11055
turnin The Scourge Cauldrons##5228 |goto 83.03,71.91
accept Target: Felstone Field##5229 |goto 83.03,71.91
step
Follow the road |goto 84.50,70.40 < 20 |only if walking
kill Cauldron Lord Bilemaw##11075
collect Felstone Field Cauldron Key##13194 |q 5229/1 |goto Western Plaguelands 37.12,57.18
step
click Scourge Cauldron
turnin Target: Felstone Field##5229 |goto 37.19,56.87
accept Return to the Bulwark##5230 |goto 37.19,56.87
step
Follow the road |goto 33.16,60.34 < 30 |only if walking
Follow the path |goto Tirisfal Glades 84.55,70.40 < 20 |only if walking
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5230 |goto Tirisfal Glades 83.04,71.91
accept Target: Dalson's Tears##5231 |goto Tirisfal Glades 83.04,71.91
step
Follow the road |goto 84.50,70.40 < 20 |only if walking
kill Cauldron Lord Malvinious##11077
collect Dalson's Tears Cauldron Key##13195 |q 5231/1 |goto 46.04,52.33
step
click Scourge Cauldron
turnin Target: Dalson's Tears##5231 |goto Western Plaguelands 46.18,52.02
accept Return to the Bulwark##5232 |goto Western Plaguelands 46.18,52.02
step
Enter the building |goto 47.52,50.94 < 10 |walk
click Mrs. Dalson's Diary
|tip Inside the building.
accept Mrs. Dalson's Diary##5058 |goto 47.79,50.67
step
Leave the building |goto 47.52,50.94 < 7 |walk
kill Wandering Skeleton##10816
|tip It looks like a white skeleton that spawns here and walks around this area around the buildings nearby.
|tip You can wait here until it walks by here, or respawns, or you can search around the building.
collect Dalson Outhouse Key##12738 |goto 47.85,49.32 |q 5059 |future
step
click Outhouse
accept Locked Away##5059 |goto 48.11,49.71
|tip Farmer Dalson will appear and attack you.
step
kill Farmer Dalson##10836
collect Dalson Cabinet Key##12739 |goto 48.11,49.71
step
Enter the building |goto 47.14,50.19 < 10 |walk
click Locked Cabinet
|tip Upstairs inside the building.
accept Locked Away##5060 |goto 47.37,49.65
step
Leave the building |goto 47.14,50.20 < 7 |walk
Follow the road |goto 45.94,57.14 < 30 |only if walking
Follow the path |goto Tirisfal Glades 84.55,70.40 < 20 |only if walking
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5232 |goto Tirisfal Glades 83.04,71.91
accept Target: Writhing Haunt##5222 |goto Tirisfal Glades 83.04,71.91
step
Follow the road |goto 84.50,70.40 < 20 |only if walking
Follow the path |goto Western Plaguelands 49.52,56.90 < 30 |only if walking
Enter the building |goto Western Plaguelands 53.60,64.79 < 10 |walk
talk Mulgris Deepriver##10739
|tip Inside the building.
accept The Wildlife Suffers Too##4984 |goto Western Plaguelands 53.72,64.67
step
kill Cauldron Lord Razarch##11076
collect Writhing Haunt Cauldron Key##13197 |q 5222/1 |goto 53.12,65.96
step
click Scourge Cauldron
turnin Target: Writhing Haunt##5222 |goto 53.02,65.72
accept Return to the Bulwark##5234 |goto 53.02,65.72
step
Follow the road |goto 48.34,56.91 < 30 |only if walking
Follow the path |goto Tirisfal Glades 84.55,70.40 < 20 |only if walking
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5234 |goto Tirisfal Glades 83.04,71.91
accept Target: Gahrron's Withering##5225 |goto Tirisfal Glades 83.04,71.91
step
Follow the road |goto 84.50,70.40 < 20 |only if walking
Continue following the road |goto Western Plaguelands 37.44,60.43 < 30 |only if walking
kill 8 Diseased Wolf##1817 |q 4984/1 |goto Western Plaguelands 42.74,54.83
You can find more around: |notinsticky
[45.96,48.00]
[46.92,39.81]
step
Follow the path |goto 49.52,56.90 < 30 |only if walking
Enter the building |goto 53.60,64.79 < 10 |walk
talk Mulgris Deepriver##10739
|tip Inside the building.
turnin The Wildlife Suffers Too##4984 |goto 53.72,64.67
accept The Wildlife Suffers Too##4985 |goto 53.72,64.67
step
kill 8 Diseased Grizzly##1816 |q 4985/1 |goto 56.81,63.63
You can find more around: |notinsticky
[58.69,58.24]
[57.20,52.78]
[61.55,52.23]
step
Follow the road |goto 56.19,56.08 < 30 |only if walking
Follow the path |goto 49.52,56.90 < 30 |only if walking
Enter the building |goto 53.60,64.79 < 10 |walk
talk Mulgris Deepriver##10739
|tip Inside the building.
turnin The Wildlife Suffers Too##4985 |goto 53.72,64.67
accept Glyphed Oaken Branch##4987 |goto 53.72,64.67
step
Kill enemies around this area
Reach Level 57 |ding 57 |goto 56.81,63.63
You can find more around: |notinsticky
[58.69,58.24]
[57.20,52.78]
[61.55,52.23]
step
kill Cauldron Lord Soulwrath##11078
collect Gahrron's Withering Cauldron Key##13196 |q 5225/1 |goto 51.95,24.65
step
click Scourge Cauldron
turnin Target: Gahrron's Withering##5225 |goto 51.91,24.63
accept Return to the Bulwark##5236 |goto 51.91,24.63
step
Follow the road |goto 61.29,55.09 < 30 |only if walking
Cross the bridge |goto 69.82,50.26 < 20 |only if walking
Follow the path up the coast |goto Eastern Plaguelands 12.46,71.89 < 20 |only if walking
Continue following the path |goto Eastern Plaguelands 7.55,53.51 < 30 |only if walking
talk Tirion Fordring##1855
accept Demon Dogs##5542 |goto Eastern Plaguelands 7.56,43.70
accept Blood Tinged Skies##5543 |goto Eastern Plaguelands 7.56,43.70
accept Carrion Grubbage##5544 |goto Eastern Plaguelands 7.56,43.70
stickystart "Kill_Plaguebats"
stickystart "Kill_Plaguehound_Runts"
stickystart "Collect_Slabs_Of_Carrion_Worm_Meat"
step
Follow the path |goto 7.25,52.69 < 30 |only if walking
Continue following the path |goto 12.00,61.72 < 30 |only if walking
Follow the path up |goto 29.11,73.55 < 20 |only if walking
click Mangled Human Remains
collect SI:7 Insignia (Turyen)##16002 |q 6185/4 |goto 28.81,74.88
step
click Mangled Human Remains
|tip It looks like a human skeleton on the ground nearby.
|tip Stand here to stay out of range of the elite enemies nearby.
collect SI:7 Insignia (Fredo)##16001 |q 6185/3 |goto 27.28,74.96
step
click Mangled Human Remains
collect SI:7 Insignia (Rutger)##16003 |q 6185/2 |goto 28.81,79.85
Uncover the Blightcaller |q 6185/1 |goto 28.81,79.85
step
Follow the path |goto 36.01,81.28 < 30 |only if walking
Continue following the path |goto 38.25,91.65 < 30 |only if walking
talk Pamela Redpath##10926
|tip She walks around this area inside this crumbled house.
turnin Sister Pamela##5601 |goto 36.45,90.80
accept Pamela's Doll##5149 |goto 36.45,90.80
stickystop "Kill_Plaguebats"
stickystop "Kill_Plaguehound_Runts"
stickystop "Collect_Slabs_Of_Carrion_Worm_Meat"
stickystart "Collect_Pamelas_Dolls_Left_Side"
stickystart "Collect_Pamelas_Dolls_Right_Side"
step
click Pamela's Doll's Head
|tip It looks like a brown ball, with two X's for eyes, with flies buzzing around it.
|tip It can be in any of the 3 buildings around this area.
collect Pamela's Doll's Head##12886 |goto 39.07,91.53 |q 5149
step
label "Collect_Pamelas_Dolls_Left_Side"
click Pamela's Doll's Left Side
|tip It looks like a brown half of a doll, with one arm and one leg, with flies buzzing around it.
|tip It can be in any of the 3 buildings around this area.
collect Pamela's Doll's Left Side##12887 |goto 39.07,91.53 |q 5149
step
label "Collect_Pamelas_Dolls_Right_Side"
click Pamela's Doll's Right Side
|tip It looks like a brown half of a doll, with one arm and one leg, with flies buzzing around it.
|tip It can be in any of the 3 buildings around this area.
collect Pamela's Doll's Right Side##12888 |goto 39.07,91.53 |q 5149
step
use Pamela's Doll's Head##12886
collect Pamela's Doll##12885 |q 5149/1
step
talk Pamela Redpath##10926
|tip She walks around this area inside this crumbled house.
turnin Pamela's Doll##5149 |goto 36.45,90.80
accept Auntie Marlene##5152 |goto 36.45,90.80
accept Uncle Carlin##5241 |goto 36.45,90.80
stickystart "Kill_Plaguehound_Runts"
stickystart "Collect_Slabs_Of_Carrion_Worm_Meat"
step
label "Kill_Plaguebats"
kill 30 Plaguebat##8600 |q 5543/1 |goto 43.24,82.95
You can find more around: |notinsticky
[42.24,69.81]
[35.16,74.32]
[27.42,69.07]
[19.99,68.52]
[18.56,77.87]
[33.76,82.90]
step
label "Kill_Plaguehound_Runts"
kill 20 Plaguehound Runt##8596 |q 5542/1 |goto 43.24,82.95
You can find more around: |notinsticky
[42.24,69.81]
[27.42,69.07]
[19.99,68.52]
[18.56,77.87]
[33.76,82.90]
step
label "Collect_Slabs_Of_Carrion_Worm_Meat"
kill Carrion Grub##8603+
collect 15 Slab of Carrion Worm Meat##13853 |q 5544/1 |goto 43.24,82.95
You can find more around: |notinsticky
[42.24,69.81]
[35.16,74.32]
[27.42,69.07]
[19.99,68.52]
[18.56,77.87]
[33.76,82.90]
step
Follow the road |goto 38.41,79.42 < 40 |only if walking
Avoid Corin's Crossing |goto 56.19,79.14 < 30 |only if walking
Follow the path |goto 74.19,70.52 < 30 |only if walking
kill 5 Plaguehound##8597 |q 5542/2 |goto 76.41,66.59
You can find more around [70.01,68.38]
step
talk Caretaker Alen##11038
|tip He walks around this area.
accept The Restless Souls##5281 |goto 79.54,63.77
accept Zaeldarr the Outcast##6021 |goto 79.54,63.77
step
talk Duke Nicholas Zverenhoff##11039
turnin Duke Nicholas Zverenhoff##6030 |goto 81.43,59.82
collect Argent Dawn Valor Token##12844 |goto 81.43,59.82 |q 9141 |future
|tip Turn in the repeatable "Minion's Scourgestones" quest to get this.
|tip Don't use the item, it is needed to turn in for a quest in a few steps.
step
talk Carlin Redpath##11063
turnin Uncle Carlin##5241 |goto 81.52,59.77
accept Defenders of Darrowshire##5211 |goto 81.52,59.77
step
talk Smokey LaRue##11033
accept That's Asking A Lot##6026 |goto 80.61,57.97
step
talk Smokey LaRue##11033
turnin That's Asking A Lot##6026 |goto 80.61,57.97
step
talk Dispatch Commander Metz##16212
accept They Call Me "The Rooster"##9141 |goto 81.05,57.55
step
talk Dispatch Commander Metz##16212
turnin They Call Me "The Rooster"##9141 |goto 81.05,57.55
step
talk Georgia##12636
fpath Light's Hope Chapel |goto 80.22,57.01
stickystart "Free_Darrowshire_Spirits"
step
Follow the path |goto 74.39,67.69 < 30 |only if walking
Kill enemies around this area
|tip All around this town.
|tip Only Undead enemies will drop the quest item.
collect 7 Living Rot##15447 |n
|tip Get these as fast as you can.
|tip They only last for 10 minutes before they disappear.
use Mortar and Pestle##15454
collect Coagulated Rot##15448 |q 6022/1 |goto 59.90,68.41
step
label "Free_Darrowshire_Spirits"
kill Gibbering Ghoul##8531+
|tip All around this town.
talk Darrowshire Spirit##11064+
|tip They appear after you kill the Gibbering Ghouls.
Free #15# Darrowshire Spirits |q 5211/1 |goto 59.90,68.41
step
kill 20 Noxious Plaguebat##8601 |q 6042/1 |goto 61.96,61.16
You can find more around: |notinsticky
[54.34,58.88]
[49.30,62.57]
[52.57,56.21]
[54.57,50.34]
[60.98,55.50]
stickystart "Kill_Frenzied_Plaguehounds"
step
kill 10 Monstrous Plaguebat##8602 |q 6042/2 |goto 60.85,48.81
You can find more around: |notinsticky
[51.17,43.24]
[49.69,35.97]
[48.56,26.97]
[52.38,24.42]
step
label "Kill_Frenzied_Plaguehounds"
kill 5 Frenzied Plaguehound##8598 |q 5542/3 |goto 62.63,47.95
You can find more around: |notinsticky
[51.17,43.24]
[49.69,35.97]
step
click Large Termite Mound+
|tip They look like large brown and white stones cracked open with green goo leaking out of the top of them around this area.
collect 100 Plagueland Termites##15043 |q 5901/1 |goto 45.90,34.10
You can find more at:
[42.19,38.20]
[42.84,34.28]
[40.61,31.38]
[36.03,31.81]
[32.08,35.71]
[26.47,37.57]
[25.22,37.89]
[28.46,32.49]
[26.16,29.78]
[23.87,25.24]
[22.45,21.52]
[20.40,27.00]
stickystart "Collect_Crypt_Fiend_Parts"
step
Follow the road |goto 18.52,33.21 < 30 |only if walking
Enter the building |goto 14.59,33.47 < 10 |walk
talk Egan##11140
|tip Inside the building.
turnin The Restless Souls##5281 |goto 14.45,33.74
step
talk Augustus the Touched##12384
|tip Inside the building.
accept Augustus' Receipt Book##6164 |goto 14.45,33.48
step
Enter the building |goto 17.56,33.03 < 10 |walk
click Augustus' Receipt Book
|tip Upstairs inside the building.
collect Augustus' Receipt Book##15884 |q 6164/1 |goto 17.43,31.09
step
Leave the building |goto 17.56,33.02 < 10 |walk
Enter the building |goto 14.59,33.47 < 10 |walk
talk Augustus the Touched##12384
|tip Inside the building.
turnin Augustus' Receipt Book##6164 |goto 14.45,33.48
step
label "Collect_Crypt_Fiend_Parts"
Kill Crypt enemies around this area
|tip They look like large insects.
|tip They take 5 minutes to respawn.
collect 30 Crypt Fiend Parts##22525 |goto 16.57,32.94 |q 9124 |future
You can find more in the tunnel at [15.33,29.35]
|tip Be careful in the tunnel, there are many enemies that are pretty close together.
|tip Sometimes an elite level 60 enemy walks around inside of the tunnel.
|tip Don't go too far into the tunnel, so you can come back and kill the enemies outside the tunnel when they respawn.
step
Enter the tunnel |goto 15.38,29.31 < 15 |walk
Follow the path |goto 14.76,31.62 < 10 |walk
Continue following the path |goto 13.77,31.96 < 10 |walk
Continue following the path |goto 13.46,33.13 < 10 |walk
Continue following the path |goto 11.21,34.61 < 10 |walk
Continue following the path |goto 10.15,37.42 < 10 |walk
Follow the path |goto 7.96,38.54 < 10 |walk
Leave the tunnel |goto 7.26,41.05 < 15 |c |q 5542
|tip If you find it too difficult to walk through this tunnel, you can skip this step.
|tip Instead, you will have to run the long way around to reach the location of the next step.
step
talk Tirion Fordring##1855
turnin Demon Dogs##5542 |goto 7.57,43.70
turnin Blood Tinged Skies##5543 |goto 7.57,43.70
turnin Carrion Grubbage##5544 |goto 7.57,43.70
accept Redemption##5742 |goto 7.57,43.70
step
talk Tirion Fordring##1855
|tip Type "/sit" into your chat, or press X.
|tip You must be sitting for the dialogue option to appear when you talk to him.
Tell him _"I am ready to hear your tale, Tirion."_
Listen to Tirion's Tale |q 5742/1 |goto 7.57,43.70
step
talk Tirion Fordring##1855
turnin Redemption##5742 |goto 7.57,43.70
accept Of Forgotten Memories##5781 |goto 7.57,43.70
step
Follow the path |goto 7.25,52.69 < 30 |only if walking
Continue following the path |goto 12.00,61.72 < 30 |only if walking
Follow the path up |goto 26.62,71.51 < 20 |only if walking
talk Nathanos Blightcaller##11878
|tip His hyenas will not attack you.
turnin To Kill With Purpose##6022 |goto 26.54,74.74
turnin Un-Life's Little Annoyances##6042 |goto 26.54,74.74
step
Enter the crypt |goto 27.86,85.48 < 10 |walk
talk Zaeldarr the Outcast##12250
|tip Downstairs inside the crypt.
collect Zaeldarr's Head##15785 |q 6021/1 |goto 27.46,84.88
step
Run up the stairs |goto 27.54,86.15 < 10 |c |q 6021
step
Leave the crypt |goto 27.85,85.50 < 10 |walk
click Loose Dirt Mound
|tip Mercutio Filthgorger appears by himself first, then 3 other enemies appear shortly after.
|tip Pull Mercutio Filthgorger far away quickly, so you can fight him by himself.
kill Mercutio Filthgorger##11886
collect Taelan's Hammer##14613 |q 5781/1 |goto 28.31,86.88
step
Follow the road |goto 25.98,79.74 < 30 |only if walking
Follow the path |goto 18.94,72.74 < 40 |only if walking
Continue following the path |goto 11.93,61.49 < 30 |only if walking
Continue following the path |goto 7.23,52.25 < 30 |only if walking
talk Tirion Fordring##1855
turnin Of Forgotten Memories##5781 |goto 7.56,43.70
accept Of Lost Honor##5845 |goto 7.56,43.70
step
Follow the path |goto 7.25,52.69 < 30 |only if walking
Continue following the path |goto 12.00,61.72 < 30 |only if walking
Follow the road |goto 19.21,73.06 < 30 |only if walking
Avoid Corin's Crossing |goto 56.19,79.14 < 30 |only if walking
Follow the path |goto 74.19,70.52 < 30 |only if walking
talk Caretaker Alen##11038
|tip He walks around this area.
turnin Zaeldarr the Outcast##6021 |goto 79.54,63.77
step
talk Carlin Redpath##11063
turnin Defenders of Darrowshire##5211 |goto 81.52,59.76
step
talk Rayne##16135
accept Savage Flora##9136 |goto 81.20,59.00
step
talk Rayne##16135
turnin Savage Flora##9136 |goto 81.20,59.00
step
Enter the building |goto 81.15,58.55 < 7 |walk
talk Rohan the Assassin##16131
|tip Inside the building.
accept Bonescythe Digs##9126 |goto 81.43,58.51
step
talk Rohan the Assassin##16131
|tip Inside the building.
turnin Bonescythe Digs##9126 |goto 81.43,58.51
step
talk Huntsman Leopold##16132
|tip Inside the building.
accept Cryptstalker Armor Doesn't Make Itself...##9124 |goto 81.50,58.55
step
talk Huntsman Leopold##16132
|tip Inside the building.
turnin Cryptstalker Armor Doesn't Make Itself...##9124 |goto 81.50,58.55
step
talk Korfax, Champion of the Light##16112
|tip Inside the building.
accept Binding the Dreadnaught##9131 |goto 81.79,58.07
step
talk Korfax, Champion of the Light##16112
|tip Inside the building.
turnin Binding the Dreadnaught##9131 |goto 81.79,58.07
step
Leave the building |goto 81.17,58.54 < 10 |walk
Follow the path |goto 70.37,48.89 < 30 |only if walking
click Symbol of Lost Honor
|tip Underwater.
collect Symbol of Lost Honor##14625 |q 5845/1 |goto 71.30,33.95
step
Kill enemies around this area
Reach Level 58 |ding 58 |goto 60.85,48.81
You can find more around: |notinsticky
[51.17,43.24]
[49.69,35.97]
[48.56,26.97]
[52.38,24.42]
step
Cross the bridge |goto 63.12,52.10 < 30 |only if walking
Follow the path |goto 75,64.33 < 30 |only if walking
Follow the road |goto 55.84,72.13 < 30 |only if walking
Follow the path |goto 18.94,72.74 < 40 |only if walking
Continue following the path |goto 11.93,61.49 < 30 |only if walking
Continue following the path |goto 7.23,52.25 < 30 |only if walking
talk Tirion Fordring##1855
turnin Of Lost Honor##5845 |goto 7.56,43.70
accept Of Love and Family##5846 |goto 7.56,43.70
step
Follow the path |goto 7.22,52.75 < 30 |only if walking
Continue following the path |goto 13.32,73.77 < 30 |only if walking
Cross the water |goto Western Plaguelands 70.78,59.57 < 40 |only if walking
Follow the path |goto Western Plaguelands 65.27,72.80 < 20 |only if walking
Enter the building |goto Western Plaguelands 65.61,75.38 < 10 |walk
talk Artist Renfray##11936
|tip Inside the building.
turnin Of Love and Family##5846 |goto Western Plaguelands 65.77,75.37
step
talk Royal Overseer Bauhaus##10781
turnin Better Late Than Never##5021 |goto Undercity 69.78,43.15
accept The Jeremiah Blues##5049 |goto Undercity 69.78,43.15
step
talk Jeremiah Payson##8403
|tip Under the stairs.
turnin The Jeremiah Blues##5049 |goto 67.60,44.16
accept Good Luck Charm##5050 |goto 67.60,44.16
step
talk Harbinger Balthazad##10879
|tip He walks around this area in the middle of Undercity.
|tip He's wearing holding a lantern, wearing a white shirt.
accept The New Frontier##1004 |goto 63.81,44.07
accept Camp Mojache##7492 |goto 63.81,44.07
step
Leave Undercity |goto 66.23,0.23 < 15 |only if walking
Follow the road |goto Tirisfal Glades 65.16,59.89 < 30 |only if walking
talk Shadow Priestess Vandis##11055
turnin Return to the Bulwark##5236 |goto Tirisfal Glades 83.03,71.91
step
talk Mickey Levine##11615
turnin A Plague Upon Thee##5901 |goto 83.29,72.33
|tip After turning in this quest, you can destroy any more Plagueland Termites you have.
accept A Plague Upon Thee##5902 |goto 83.29,72.33
step
talk High Executor Derrington##10837
accept Mission Accomplished!##5237 |goto 83.13,68.94
accept All Along the Watchtowers##5098 |goto 83.13,68.94
step
Follow the road |goto 84.50,70.40 < 20 |only if walking
Enter the building |goto Western Plaguelands 38.04,54.61 < 10 |walk
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Good Luck Charm##5050 |goto Western Plaguelands 38.40,54.05
accept Two Halves Become One##5051 |goto Western Plaguelands 38.40,54.05
step
Leave the building |goto 38.02,54.65 < 7 |walk
kill Jabbering Ghoul##10801
|tip It looks like a green ghoul holding a pitchfork.
|tip He can possibly spawn in multiple locations, and may walk around this area.
collect Good Luck Other-Half-Charm##12722 |goto 36.84,58.23 |q 5051
step
use the Good Luck Other-Half-Charm##12722
collect Good Luck Charm##12723 |q 5051/1
step
Enter the building |goto 38.04,54.61 < 10 |walk
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Two Halves Become One##5051 |goto 38.40,54.05
step
Leave the building |goto 38.02,54.65 < 7 |walk
Follow the path |goto 46.16,47.50 < 30 |only if walking
click Northridge Lumber Mill Crate
|tip Inside the building.
Choose _"Place Termite Barrel on the crate."_
click Termite Barrel
|tip It appears on top of the crate.
turnin A Plague Upon Thee##5902 |goto 48.35,32.00
accept A Plague Upon Thee##6390 |goto 48.35,32.00
step
Follow the path down |goto 50.64,29.34 < 30 |only if walking
talk Kirsta Deepshadow##11610
accept Unfinished Business##6004 |goto 51.92,28.06
step
Follow the path |goto 49.96,30.61 < 30 |only if walking
kill 2 Scarlet Medic##10605 |q 6004/1 |goto 51.67,44.39
step
label "Kill_Scarlet_Hunters"
kill 2 Scarlet Hunter##1831 |q 6004/2 |goto 51.67,44.39
step
label "Kill_Scarlet_Mages"
kill 2 Scarlet Mage##1826 |q 6004/3 |goto 50.47,41.12
step
label "Kill_Scarlet_Knights"
kill 2 Scarlet Knight##1833 |q 6004/4 |goto 50.47,41.12
step
Follow the path |goto 48.58,40.28 < 30 |only if walking
Follow the path down |goto 49.83,30.51 < 30 |only if walking
talk Kirsta Deepshadow##11610
turnin Unfinished Business##6004 |goto 51.92,28.06
accept Unfinished Business##6023 |goto 51.92,28.06
step
Follow the path |goto 49.96,30.61 < 30 |only if walking
Follow the path |goto 51.58,39.81 < 30 |only if walking
Follow the path up |goto 55.23,34.61 < 20 |only if walking
kill Huntsman Radley##11613 |q 6023/1 |goto 57.83,36.09
step
Follow the path |goto 54.74,32.40 < 30 |only if walking
kill Cavalier Durgen##11611 |q 6023/2 |goto 54.50,23.84
|tip He walks back and forth, between this spot and the top of the tower.
|tip Wait outside the tower near this spot, he will eventually walk outside.
|tip Pull him away into the road nearby, so you can fight him alone.
step
Jump down here |goto 53.32,26.64 < 15 |only if walking
talk Kirsta Deepshadow##11610
turnin Unfinished Business##6023 |goto 51.92,28.06
step
Follow the path |goto 49.96,30.61 < 30 |only if walking
Continue following the path |goto 48.43,44.14 < 30 |only if walking
Continue following the path |goto 51.28,66.37 < 30 |only if walking
Jump down here |goto 52.43,71.44 < 15 |only if walking
Follow the path up |goto 52.39,74.73 < 15 |only if walking
Enter the building |goto 49.29,78.56 < 10 |walk
talk Marlene Redpath##10927
|tip Upstairs inside the building.
turnin Auntie Marlene##5152 |goto 49.17,78.58
accept A Strange Historian##5153 |goto 49.17,78.58
step
click Joseph Redpath's Monument
collect Joseph's Wedding Ring##12894 |q 5153/1 |goto 49.68,76.77
step
Cross the bridge |goto 49.22,73.14 < 20 |only if walking
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Four |q 5098/4 |goto 46.70,71.10
step
Avoid the big group of enemies in the center of town |goto 44.17,71.56 < 30 |only if walking
Follow the road |goto 41.32,70.69 < 20 |only if walking
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower One |q 5098/1 |goto 40.13,71.52
step
Enter the building |goto 39.57,68.38 < 10 |walk
talk Chromie##10667
|tip Upstairs inside the building.
turnin A Strange Historian##5153 |goto 39.45,66.76
accept The Annals of Darrowshire##5154 |goto 39.45,66.76
accept A Matter of Time##4971 |goto 39.45,66.76
step
Leave the building |goto 39.58,68.38 < 10 |walk
Hug the outside of this building to get to the entrance |goto 43.81,70.34 < 10 |only if walking
Enter the building |goto 44.09,69.22 < 10 |walk
click Musty Tome+
|tip They look like blue books on the floor inside this building.
|tip Only one of them is the real book, and it's random.
|tip If you click fake books, enemies will spawn, so try to only click the real book.
|tip To identify the real book, zoom in your view, mouse over the books to highlight them, and look at the book pages.
|tip The fake books will have very blurry pages, with the top half of pages shaded darker than the bottom half of pages.
|tip The real book pages look sharper, with more clear horizontal lines, and the top half and bottom half of the pages are not shaded differently.
collect Annals of Darrowshire##12900 |q 5154/1 |goto 43.52,69.55
step
Leave the building and try to avoid the enemies nearby |goto 44.09,69.22 < 10 |walk
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Two |q 5098/2 |goto 42.44,66.27
step
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Three |q 5098/3 |goto 44.22,63.37
step
use the Temporal Displacer##12627
|tip Use it near the cylinder structures with blue light shining out of them around this area.
kill 10 Temporal Parasite##10717 |q 4971/1 |goto 45.05,62.61
You can find more around: |notinsticky
[46.76,62.38]
[48.07,62.86]
[47.79,65.63]
[49.90,66.60]
[49.23,68.60]
step
Avoid the big group of enemies in the center of town |goto 43.29,66.54 < 30 |only if walking
Enter the building |goto 39.57,68.38 < 10 |walk
talk Chromie##10667
|tip Upstairs inside the building.
turnin A Matter of Time##4971 |goto 39.45,66.76
turnin The Annals of Darrowshire##5154 |goto 39.45,66.76
accept Counting Out Time##4972 |goto 39.45,66.76
accept Brother Carlin##5210 |goto 39.45,66.76
step
Leave the building |goto 39.58,68.38 < 10 |walk
click Small Lockbox
|tip Inside the crumbled building.
collect Andorhal Watch##12638 |q 4972/1 |goto 38.29,69.63 |count 1
step
click Small Lockbox
|tip Inside the crumbled building.
collect Andorhal Watch##12638 |q 4972/1 |goto 38.88,68.06 |count 2
step
click Small Lockbox
|tip Inside the crumbled building.
collect Andorhal Watch##12638 |q 4972/1 |goto 40.27,68.17 |count 3
step
click Small Lockbox
|tip Inside the crumbled building.
collect Andorhal Watch##12638 |q 4972/1 |goto 40.85,67.14 |count 4
step
click Small Lockbox
|tip Inside the crumbled building.
collect Andorhal Watch##12638 |q 4972/1 |goto 40.32,66.48 |count 5
step
Enter the building |goto 39.57,68.38 < 10 |walk
talk Chromie##10667
|tip Upstairs inside the building.
turnin Counting Out Time##4972 |goto 39.45,66.76
step
Leave the building |goto 39.58,68.38 < 10 |walk
Follow the road |goto 35.23,60.59 < 30 |only if walking
Follow the path |goto Tirisfal Glades 84.55,70.40 < 20 |only if walking
talk Mickey Levine##11615
turnin A Plague Upon Thee##6390 |goto Tirisfal Glades 83.29,72.33
step
talk High Executor Derrington##10837
turnin All Along the Watchtowers##5098 |goto 83.13,68.93
|tip After you turn in this quest, you can destroy the Beacon Torch quest item.
accept Scholomance##838 |goto 83.13,68.93
step
talk Apothecary Dithers##11057
turnin Scholomance##838 |goto 83.28,69.23
accept Skeletal Fragments##964 |goto 83.28,69.23
step
Follow the road |goto 84.53,70.39 < 20 |only if walking
Kill Skeletal enemies around this area
collect 15 Skeletal Fragments##14619 |q 964/1 |goto Western Plaguelands 36.64,57.74
step
Follow the road |goto 33.66,60.47 < 30 |only if walking
Follow the path |goto Tirisfal Glades 84.55,70.40 < 20 |only if walking
talk Apothecary Dithers##11057
turnin Skeletal Fragments##964 |goto Tirisfal Glades 83.28,69.23
step
Follow the road |goto 75.12,67.19 < 30 |only if walking
Enter Orgrimmar |goto Orgrimmar 49.10,94.97 < 20 |only if walking
Enter the building |goto Orgrimmar 54.02,68.89 < 10 |walk
talk Innkeeper Gryshka##6929
|tip Inside the building.
home Orgrimmar |goto Orgrimmar 54.09,68.41
step
talk Cenarion Emissary Blackhoof##15188
accept Taking Back Silithus##8276 |goto 47.49,65.76
step
Enter the building |goto Thunder Bluff 51.00,36.92 < 15 |only if walking
Cross the hanging bridge |goto Thunder Bluff 55.87,34.46 < 10 |only if walking
Enter the building |goto Thunder Bluff 74.19,29.89 < 15 |walk
talk Nara Wildmane##5770
|tip Inside the building.
turnin Glyphed Oaken Branch##4986 |goto Thunder Bluff 75.65,31.61
step
talk Arch Druid Hamuul Runetotem##5769
|tip Inside the building.
turnin The New Frontier##1000 |goto 78.60,28.55
accept Rabine Saturna##1123 |goto 78.60,28.55
step
Follow the road |goto Moonglade 41.01,35.40 < 30 |only if walking
Enter the building |goto Moonglade 51.47,41.45 < 15 |walk
talk Rabine Saturna##11801
|tip Inside the building.
turnin Rabine Saturna##1123 |goto Moonglade 51.68,45.09
accept Wasteland##1124 |goto Moonglade 51.68,45.09
accept A Reliquary of Purity##5527 |goto Moonglade 51.68,45.09
step
Enter the building |goto Orgrimmar 47.50,65.18 < 10 |only if walking
talk Talo Thornhoof##7776
|tip Inside the building.
turnin The Strength of Corruption##4120 |goto Feralas 76.18,43.83
turnin Camp Mojache##7492 |goto Feralas 76.18,43.83
step
Follow the path |goto Tanaris 51.26,26.50 < 15 |only if walking
use the Umi's Mechanical Yeti##12928
|tip Use it on Sprinkle.
Scare Sprinkle |q 5163/2 |goto Tanaris 51.06,26.87
step
Follow the path |goto 51.26,26.50 < 15 |only if walking
use the Umi's Mechanical Yeti##12928
|tip Use it on Quixxil.
Scare Quixxil |q 5163/3 |goto Un'Goro Crater 43.67,9.38
step
Follow the path down |goto 45.18,11.57 < 20 |only if walking
use the Encased Corrupt Ooze##12288
|tip Use it on a Primal Ooze.
kill Gargantuan Ooze##9621
collect Merged Ooze Sample##12291 |q 4642/1 |goto 46.86,24.76
step
Follow the path up |goto 29.34,22.42 < 20 |only if walking
Continue up the path |goto 29.84,10.28 < 20 |only if walking
Follow the path |goto Silithus 83.91,14.18 < 30 |only if walking
talk Layo Starstrike##13220
|tip Inside the building.
turnin Wasteland##1124 |goto Silithus 81.87,18.93
accept The Spirits of Southwind##1125 |goto Silithus 81.87,18.93
step
Follow the road |goto 70.17,34.79 < 30 |only if walking
Follow the path |goto 52.07,36.73 < 20 |only if walking
talk Windcaller Proudhorn##15191
turnin Taking Back Silithus##8276 |goto 51.15,38.29
accept Securing the Supply Lines##8280 |goto 51.15,38.29
step
click Wanted Poster: Deathclasp
accept Wanted - Deathclasp, Terror of the Sands##8283
step
talk Beetix Ficklespragg##15189
|tip She walks around this area upstairs inside the building.
accept Deadly Desert Venom##8277 |goto 51.71,38.58
step
Follow the path |goto 50.34,37.00 < 20 |only if walking
talk Geologist Larksbane##15183
accept The Twilight Mystery##8284 |goto 49.67,37.34
step
talk Bor Wildmane##15306
accept Secret Communication##8318 |goto 48.57,37.78
step
talk Scout Bloodfist##17081
accept Report to General Kirika##9416 |goto 48.95,36.69
step
talk Runk Windtamer##15178
fpath Cenarion Hold |goto 48.68,36.68
step
Enter the building |goto 49.60,36.02 < 15 |only if walking
talk Commander Mar'alith##15181
|tip Outside, on the balcony of the building.
accept Dearest Natalia##8304 |goto 49.19,34.18
stickystart "Kill_Tortured_Druids"
stickystart "Kill_Tortured_Sentinels"
step
Leave the building |goto 49.61,36.02 < 10 |only if walking
Follow the path down |goto 52.09,36.72 < 20 |only if walking
Follow the path |goto 61.67,51.64 < 20 |only if walking
Enter the building |goto 63.45,54.05 < 15 |walk
click Dusty Reliquary
|tip Inside the building.
collect Reliquary of Purity##22201 |q 5527/1 |goto 63.23,55.34
step
label "Kill_Tortured_Druids"
kill 8 Tortured Druid##12178 |q 1125/1 |goto 62.96,53.11
|tip You can find more inside the buildings around this area.
step
label "Kill_Tortured_Sentinels"
kill 8 Tortured Sentinel##12179 |q 1125/2 |goto 62.96,53.11
|tip You can find more inside the buildings around this area.
stickystart "Collect_Stonelash_Scorpid_Stingers"
stickystart "Collect_Sand_Skitterer_Fangs"
stickystart "Kill_Dredge_Strikers"
step
Follow the path |goto 61.69,51.69 < 20 |only if walking
talk Layo Starstrike##13220
|tip Inside the building.
turnin The Spirits of Southwind##1125 |goto 81.87,18.93
accept Hive in the Tower##1126 |goto 81.87,18.93
step
Follow the path |goto 61.48,48.93 < 30 |only if walking
Continue following the path |goto 61.69,51.72 < 20 |only if walking
Enter the building |goto 60.45,52.83 < 15 |walk
click Hive'Ashi Pod
|tip At the top of the tower.
kill Hive'Ashi Ambusher##13301+
collect Encrusted Silithid Object##17346 |q 1126/1 |goto 60.35,52.55
stickystop "Collect_Stonelash_Scorpid_Stingers"
stickystop "Collect_Sand_Skitterer_Fangs"
stickystop "Kill_Dredge_Strikers"
step
Kill enemies around this area
|tip You can find more inside the buildings around this area.
kill Hive'Ashi Drone##13136+
|tip They appear after you kill the Tortured elf enemies around this area.
collect Brann Bronzebeard's Lost Letter##20461 |goto 62.96,53.11 |q 8308 |future
step
use Brann Bronzebeard's Lost Letter##20461
accept Brann Bronzebeard's Lost Letter##8308
step
Kill enemies around this area
|tip You can find more inside the buildings around this area.
Reach Level 59 |ding 59 |goto 62.96,53.11
stickystart "Collect_Stonelash_Scorpid_Stingers"
stickystart "Collect_Sand_Skitterer_Fangs"
stickystart "Kill_Dredge_Strikers"
step
Follow the path |goto 61.69,51.69 < 20 |only if walking
talk Layo Starstrike##13220
|tip Inside the building.
turnin Hive in the Tower##1126 |goto 81.87,18.93
accept Umber, Archivist##6844 |goto 81.87,18.93
step
Follow the path |goto 72.12,30.46 < 30 |only if walking
Continue following the path |goto 66.40,27.39 < 30 |only if walking
Kill Twilight enemies around this area
collect 10 Encrypted Twilight Text##20404 |q 8318/1 |goto 66.89,19.00
|tip These have a pretty low drop rate.
You can find more inside the cave at [68.88,15.22]
step
label "Collect_Stonelash_Scorpid_Stingers"
kill Stonelash Scorpid##11735+
|tip They look like scorpions.
collect 8 Stonelash Scorpid Stinger##20373 |q 8277/1 |goto 60.63,17.19
You can find more around: |notinsticky
[51.92,17.95]
[52.50,30.60]
[68.54,32.78]
[59.11,23.46]
step
label "Collect_Sand_Skitterer_Fangs"
kill Sand Skitterer##11738+
|tip They look like spiders.
collect 8 Sand Skitterer Fang##20376 |q 8277/2 |goto 60.63,17.19
You can find more around: |notinsticky
[51.92,17.95]
[52.50,30.60]
[68.54,32.78]
[59.11,23.46]
step
label "Kill_Dredge_Strikers"
kill 15 Dredge Striker##11740 |q 8280/1 |goto 60.63,17.19
You can find more around: |notinsticky
[51.92,17.95]
[52.50,30.60]
[68.54,32.78]
[59.11,23.46]
step
Following the path |goto 52.06,36.78 < 20 |only if walking
talk Windcaller Proudhorn##15191
turnin Securing the Supply Lines##8280 |goto 51.15,38.29
accept Stepping Up Security##8281 |goto 51.15,38.29
step
talk Beetix Ficklespragg##15189
|tip She walks around this area upstairs inside the building.
turnin Deadly Desert Venom##8277 |goto 51.71,38.58
accept Noggle's Last Hope##8278 |goto 51.71,38.58
step
Follow the path |goto 50.34,37.00 < 20 |only if walking
talk Bor Wildmane##15306
turnin Secret Communication##8318 |goto 48.58,37.78
stickystart "Collect_Core_Of_Elements"
step
Follow the path down |goto 48.69,34.92 < 15 |only if walking
Follow the path |goto 44.08,35.53 < 30 |only if walking
Follow the path |goto 30.35,16.88 < 40 |only if walking
click Twilight Tablet Fragment+
|tip They look like small blue-glowing broken pieces of stone tablets on the ground around this area.
collect 8 Twilight Tablet Fragment##20378 |q 8284/1 |goto 24.33,11.94
step
label "Collect_Core_Of_Elements"
Kill enemies around this area
|tip They look like air and rock elementals.
collect 30 Core of Elements##22527 |goto 23.01,12.28 |q 9128 |future
You can find more around: |notinsticky
[31.53,18.08]
[28.22,29.43]
[19.10,27.73]
step
Kill Twilight enemies around this area
collect 10 Encrypted Twilight Text##20404 |goto 27.34,33.46 |q 8323 |future
|tip These have a pretty low drop rate.
stickystart "Collect_Stonelash_Pincer_Stingers"
step
kill 20 Dredge Crusher##11741 |q 8281/1 |goto 27.26,43.55
You can find more around: |notinsticky
[36.54,50.40]
[37.93,60.76]
[47.11,59.42]
[57.55,60.78]
step
label "Collect_Stonelash_Pincer_Stingers"
kill Stonelash Pincer##11736+
collect 3 Stonelash Pincer Stinger##20374 |q 8278/2 |goto 27.26,43.55
You can find more around: |notinsticky
[36.54,50.40]
[37.93,60.76]
[47.11,59.42]
[57.55,60.78]
step
talk General Kirika##17079
turnin Report to General Kirika##9416 |goto 50.75,69.55
stickystart "Collect_Stonelash_Flayer_Stingers"
stickystart "Collect_Rock_Stalker_Fangs"
step
talk Rutgar Glyphshaper##15170
turnin Brann Bronzebeard's Lost Letter##8308 |goto 41.28,88.45
step
talk Rutgar Glyphshaper##15170
Tell him _"Hello, Rutgar. The Commander has sent me here to gather some information about his missing wife."_
Question Rutgar |q 8304/2 |goto 41.28,88.45
step
talk Frankal Stonebridge##15171
Tell him _"Hello, Frankal. I've heard that you might have some information as to the whereabouts of Mistress Natalia Mar'alith."_
Question Frankal |q 8304/1 |goto 40.82,88.85
step
label "Collect_Stonelash_Flayer_Stingers"
kill Stonelash Flayer##11737+
collect 3 Stonelash Flayer Stinger##20375 |q 8278/1 |goto 45.96,71.47
You can find more around: |notinsticky
[45.15,82.20]
[36.97,86.68]
[28.44,80.89]
[35.23,71.64]
step
label "Collect_Rock_Stalker_Fangs"
kill Rock Stalker##11739+
collect 3 Rock Stalker Fang##20377 |q 8278/3 |goto 45.96,71.47
You can find more around: |notinsticky
[45.15,82.20]
[36.97,86.68]
[28.44,80.89]
[35.23,71.64]
step
Follow the road |goto 42.86,72.53 < 30 |only if walking
Follow the path |goto 47.12,40.65 < 30 |only if walking
talk Windcaller Proudhorn##15191
turnin Stepping Up Security##8281 |goto 51.15,38.29
step
talk Beetix Ficklespragg##15189
|tip She walks around this area upstairs inside the building.
turnin Noggle's Last Hope##8278 |goto 51.71,38.58
step
talk Noggle Ficklespragg##15190
|tip Upstairs inside the building.
accept Noggle's Lost Satchel##8282 |goto 51.62,38.50
step
Follow the path |goto 50.34,37.02 < 20 |only if walking
talk Geologist Larksbane##15183
turnin The Twilight Mystery##8284 |goto 49.68,37.34
accept The Deserter##8285 |goto 49.68,37.34
step
Enter the building |goto 49.61,36.05 < 15 |only if walking
talk Commander Mar'alith##15181
|tip Outside, on the balcony of the building.
turnin Dearest Natalia##8304 |goto 49.19,34.18
step
Leave the building |goto 49.60,36.00 < 15 |only if walking
Follow the path |goto 50.47,37.69 < 20 |only if walking
Follow the path |goto 45.23,54.37 < 30 |only if walking
Enter the cave |goto 66.32,70.03 < 15 |walk
talk Hermit Ortell##15194
|tip Inside the cave.
turnin The Deserter##8285 |goto 67.19,69.76
accept The Twilight Lexicon##8279 |goto 67.19,69.76
step
Leave the cave |goto 66.28,70.06 < 15 |walk
kill Twilight Keeper Havunth##11804
|tip He looks like an orc that walks around this area wearing a bright purple robe.
|tip You can wait around this spot to avoid going into the camp looking for him.
collect Twilight Lexicon - Chapter 3##20396 |q 8279/3 |goto 42.00,44.13
step
kill Twilight Keeper Mayna##15200
|tip She walks around this area.
collect Twilight Lexicon - Chapter 1##20394 |q 8279/1 |goto 26.46,36.45
step
Follow the path up |goto 19.91,47.62 < 15 |only if walking
Follow the path |goto 20.68,52.43 < 15 |only if walking
Continue following the path |goto 17.45,62.34 < 15 |only if walking
Follow the path up |goto 18.25,68.26 < 15 |only if walking
Continue up the path |goto 19.29,70.42 < 15 |only if walking
Jump down here |goto 17.99,71.75 < 15 |only if walking
Follow the path down |goto 18.53,74.31 < 15 |only if walking
kill Twilight Keeper Exeter##11803
collect The Twilight Lexicon##8279 |q 8279/2 |goto 16.09,86.37
step
Follow the path |goto 29.63,84.72 < 40 |only if walking
Follow the path up |goto 42.36,90.81 < 15 |only if walking
kill Deathclasp##15196
|tip He walks around this area.
|tip You may need help with this.
collect Deathclasp's Pincer##20385 |q 8283/1 |goto 44.94,91.23
step
click Noggle's Satchel
collect Noggle's Satchel##20379 |q 8282/1 |goto 44.57,91.36
step
Follow the path |goto 55.17,63.52 < 30 |only if walking
Enter the cave |goto 66.32,70.03 < 15 |walk
talk Hermit Ortell##15194
|tip Inside the cave.
turnin The Twilight Lexicon##8279 |goto 67.19,69.76
accept A Terrible Purpose##8287 |goto 67.19,69.76
accept True Believers##8323 |goto 67.19,69.76
step
talk Hermit Ortell##15194
|tip Inside the cave.
turnin True Believers##8323 |goto 67.19,69.76
step
Leave the cave |goto 66.28,70.06 < 15 |walk
Follow the road |goto 45.20,52.54 < 30 |only if walking
Follow the path up |goto 45.64,43.35 < 30 |only if walking
talk Noggle Ficklespragg##15190
|tip Upstairs inside the building.
turnin Noggle's Lost Satchel##8282 |goto 51.63,38.50
step
Follow the path |goto 50.34,37.02 < 20 |only if walking
Enter the building |goto 49.61,36.05 < 15 |only if walking
talk Commander Mar'alith##15181
|tip Outside, on the balcony of the building.
turnin A Terrible Purpose##8287 |goto 49.19,34.18
step
Leave the building |goto 49.60,36.00 < 15 |only if walking
Follow the path up |goto 50.43,35.93 < 15 |only if walking
Enter the building |goto 50.81,33.88 < 10 |only if walking
talk Vish Kozus##15182
|tip At the top of the tower.
turnin Wanted - Deathclasp, Terror of the Sands##8283 |goto 50.75,33.65
step
Follow the path |goto Orgrimmar 52.47,85.10 < 20 |only if walking
Leave Orgrimmar |goto Orgrimmar 49.12,94.94 < 20 |only if walking
Enter Undercity |goto Tirisfal Glades 61.88,65.05 < 20 |only if walking
Follow the path down |goto Undercity 52.82,77.71 < 10 |walk
talk Chemist Fuely##10136
turnin Melding of Influences##4642 |goto Undercity 47.46,73.35
step
Follow the path up |goto 47.88,76.52 < 10 |walk
Enter the building |goto Eastern Plaguelands 81.15,58.55 < 10 |walk
talk Archmage Angela Dosantos##16116
|tip Inside the building.
accept The Elemental Equation##9128 |goto Eastern Plaguelands 81.52,58.27
step
talk Archmage Angela Dosantos##16116
|tip Inside the building.
turnin The Elemental Equation##9128 |goto 81.52,58.27
step
Leave the building |goto 81.15,58.56 < 10 |walk
talk Carlin Redpath##11063
turnin Brother Carlin##5210 |goto 81.52,59.77
accept Villains of Darrowshire##5181 |goto 81.52,59.77
step
Follow the path |goto 76.19,55.28 < 30 |only if walking
click Horgus' Skull
|tip Underwater.
collect Skull of Horgus##12956 |q 5181/1 |goto 51.11,49.94
step
Follow the path |goto 49.71,55.83 < 30 |only if walking
Jump down here |goto 50.52,65.38 < 15 |only if walking
Follow the path |goto 53.22,70.36 < 20 |only if walking
Follow the path |goto 55.52,68.77 < 20 |only if walking
click Shattered Sword of Marduk
collect Shattered Sword of Marduk##12957 |q 5181/2 |goto 53.92,65.76
step
Follow the path |goto 55.31,69.42 < 20 |only if walking
Follow the path up |goto 51.17,71.06 < 20 |only if walking
Follow the path |goto 49.20,75.21 < 30 |only if walking
Avoid Corin's Crossing |goto 54.87,78.88 < 30 |only if walking
Follow the path |goto 72.39,68.66 < 30 |only if walking
talk Carlin Redpath##11063
turnin Villains of Darrowshire##5181 |goto 81.51,59.77
step
Leave Undercity |goto 66.23,0.23 < 15 |only if walking
Enter Orgrimmar |goto Durotar 45.56,12.07 < 20 |only if walking
Enter the building |goto Orgrimmar 47.50,65.20 < 10 |only if walking
talk Trull Failbane##10306
accept Wild Guardians##4741 |goto Felwood 34.73,52.79
step
Follow the path |goto 35.78,49.56 < 20 |only if walking
Follow the path up |goto 37.56,48.44 < 30 |only if walking
Follow the road |goto 39.31,44.53 < 30 |only if walking
Continue following the road |goto 41.15,24.09 < 30 |only if walking
Follow the path down |goto 44.69,23.44 < 30 |only if walking
kill Toxic Horror##7132+
collect 3 Toxic Horror Droplet##12822 |q 5086/1 |goto 48.61,23.88
You can find more around [50.89,22.57]
step
Follow the path up |goto 52.34,26.83 < 30 |only if walking
Follow the path |goto 56.49,20.20 < 30 |only if walking
Follow the road |goto 58.89,16.25 < 30 |only if walking
Continue following the road |goto 64.40,15.08 < 30 |only if walking
Enter the tunnel |goto 65.13,8.01 < 10 |walk
Run down the stairs |goto 66.03,3.31 < 10 |walk
Follow the path |goto 65.36,2.34 < 10 |walk
Leave the tunnel |goto 0.00,0.00 < 10 |walk
Follow the road |goto Moonglade 40.73,35.75 < 30 |only if walking
talk Umber##11939
|tip Upstairs inside the building.
turnin Umber, Archivist##6844 |goto Moonglade 44.89,35.59
accept Uncovering Past Secrets##6845 |goto Moonglade 44.89,35.59
step
Enter the building |goto 51.47,41.44 < 15 |walk
talk Rabine Saturna##11801
|tip Inside the building.
turnin A Reliquary of Purity##5527 |goto 51.68,45.08
turnin Uncovering Past Secrets##6845 |goto 51.68,45.08
step
talk Umber##11939
|tip Upstairs inside the building.
accept Under the Chitin Was...##1185 |goto 44.89,35.59
step
Follow the road up |goto 35.17,65.99 < 15 |only if walking
Enter the tunnel |goto 35.74,72.49 < 10 |walk
Run up the stairs |goto Felwood 65.85,3.54 < 10 |walk
Follow the path |goto Felwood 66.26,2.90 < 10 |walk
Leave the tunnel |goto Felwood 68.40,5.84 < 10 |walk
talk Donova Snowden##9298
turnin Toxic Horrors##5086 |goto Winterspring 31.27,45.17
accept Winterfall Runners##5087 |goto Winterspring 31.27,45.17
step
kill Winterfall Runner##10916+
|tip They look like a group of 3 white furbolgs that walk back and forth along this road.
|tip Check these locations, and if you don't find them, wait at the location in this step closest to Everlook.
|tip They will eventually walk past this location.
collect Winterfall Crate##12829 |q 5087/1 |goto 30.04,42.55
You can also find them around:
[46.96,39.54]
[53.55,33.96]
step
Follow the path down |goto 32.31,42.44 < 30 |only if walking
talk Donova Snowden##9298
turnin Winterfall Runners##5087 |goto 31.27,45.17
step
Follow the road |goto 33.15,42.13 < 30 |only if walking
Continue following the road |goto 54.52,34.91 < 30 |only if walking
Follow the path |goto 60.55,38.20 < 15 |only if walking
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##5163 |goto 60.88,37.62
accept A Yeti of Your Own##8798 |goto 60.88,37.62 |only if skill('Engineering') >= 250
step
talk Umi Rumplesnicker##10305
turnin A Yeti of Your Own##8798 |goto 60.88,37.62
|only if havequest(8798) or completedq(8798)
step
Enter the building |goto 61.32,38.72 < 10 |walk
talk Innkeeper Vizzie##11118
|tip Inside the building.
home Everlook |goto 61.36,38.83
step
talk Felnok Steelspring##10468
accept Chillwind Horns##4809 |goto 61.63,38.61
stickystart "Kill_Moontouched_Owlbeasts"
step
Follow the path |goto 60.56,38.20 < 15 |only if walking
Follow the road |goto 60.71,39.74 < 20 |only if walking
Continue following the road |goto 64.71,45.18 < 30 |only if walking
Follow the path up |goto 63.11,59.12 < 30 |only if walking
Kill Owlbeast enemies around this area
|you You can find more inside the small caves around this area.
collect Blue-feathered Necklace##12558 |goto 65.45,60.06 |q 4882 |future
You can find more around [64.97,63.19]
step
use the Blue-feathered Necklace##12558
accept Guarding Secrets##4882
step
label "Kill_Moontouched_Owlbeasts"
kill 13 Moontouched Owlbeast##7453 |q 4741/1 |goto 65.45,60.06
|you You can find more inside the small caves around this area.
You can find more around [64.97,63.19]
step
Follow the path down |goto 64.67,59.84 < 30 |only if walking
Follow the road |goto 62.67,58.50 < 30 |only if walking
Continue following the road |goto 64.72,45.16 < 30 |only if walking
Follow the path |goto 60.49,39.67 < 30 |only if walking
talk Trull Failbane##10306
turnin Wild Guardians##4741 |goto Felwood 34.73,52.79
accept Wild Guardians##4721 |goto Felwood 34.73,52.79
turnin Guarding Secrets##4882 |goto Felwood 34.73,52.79
accept Guarding Secrets##4882 |goto Felwood 34.73,52.79
step
Follow the path |goto Winterspring 60.56,38.21 < 15 |only if walking
Follow the path down |goto Winterspring 59.47,32.23 < 30 |only if walking
Follow the path |goto Winterspring 59.91,27.42 < 30 |only if walking
kill Chillwind Ravager##7449+
collect 8 Uncracked Chillwind Horn##12444 |q 4809/1 |goto 59.97,21.54
|tip These have a pretty low drop rate.
You can find more around: |notinsticky
[54.75,22.59]
[59.18,18.02]
[60.13,12.28]
[57.99,14.79]
step
kill 10 Berserk Owlbeast##7454 |q 4721/1 |goto 63.18,21.91
|tip You can find more through the tunnel nearby.
You can find more around: |notinsticky
[66.17,22.72]
[67.65,21.98]
[66.09,19.38]
[64.99,18.71]
step
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto 61.63,38.61
accept Return to Tinkee##4810 |goto 61.63,38.61
step
Follow the path |goto 60.56,38.21 < 15 |only if walking
talk Trull Failbane##10306
turnin Wild Guardians##4721 |goto Felwood 34.73,52.79
step
Enter the building |goto Thunder Bluff 51.00,36.92 < 15 |only if walking
Cross the hanging bridge |goto Thunder Bluff 55.87,34.46 < 10 |only if walking
Enter the building |goto Thunder Bluff 74.19,29.89 < 15 |walk
talk Nara Wildmane##5770
|tip Inside the building.
turnin Guarding Secrets##4883 |goto Thunder Bluff 75.65,31.61
step
talk Tinkee Steamboil##10267
turnin Return to Tinkee##4810 |goto Burning Steppes 65.23,23.99
step
Follow the path |goto Winterspring 60.56,38.20 < 15 |only if walking
Follow the road |goto Winterspring 60.71,39.74 < 20 |only if walking
Continue following the road |goto Winterspring 64.71,45.18 < 30 |only if walking
Follow the path up |goto Winterspring 63.11,59.12 < 30 |only if walking
Kill enemies around this area
|you You can find more inside the small caves around this area.
Reach Level 60 |ding 60 |goto Winterspring 65.45,60.06
|tip Instead of grinding, you could also get into a group and run the Blackrock Depths or Stratholme dungeons.
You can find more around [64.97,63.19]
]])
