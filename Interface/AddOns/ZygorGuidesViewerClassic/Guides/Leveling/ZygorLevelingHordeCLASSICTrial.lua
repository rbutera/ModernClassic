local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Horde" then return end
if ZGV:DoMutex("LevelingHCLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
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
