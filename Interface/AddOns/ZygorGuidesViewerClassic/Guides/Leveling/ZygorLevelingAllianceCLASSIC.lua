local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("LevelingACLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "CLA"
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Human (1-13)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
condition_suggested=function() return raceclass('Human') and level <= 13 end,
condition_suggested_exclusive=true,
next="Leveling Guides\\Leveling (13-20)",
startlevel=1,
endlevel=13,
},[[
step
talk Deputy Willem##823
accept A Threat Within##783 |goto Elwynn Forest 48.17,42.95
step
Enter the building |goto 48.31,41.99 < 15 |walk
talk Marshal McBride##197
|tip Inside the building.
turnin A Threat Within##783 |goto 48.92,41.61
accept Kobold Camp Cleanup##7 |goto 48.92,41.61
step
Leave the building |goto 48.30,42.01 < 10 |walk
talk Deputy Willem##823
accept Eagan Peltskinner##5261 |goto 48.17,42.95
step
talk Eagan Peltskinner##196
|tip Outside the building.
turnin Eagan Peltskinner##5261 |goto 48.94,40.16
accept Wolves Across the Border##33 |goto 48.94,40.16
step
Kill Wolf enemies around this area
collect 8 Tough Wolf Meat##750 |q 33/1 |goto 46.38,38.58
You can find more around: |notinsticky
[45.82,44.02]
[50.16,45.83]
[52.06,40.29]
step
Kill enemies around this area
Reach Level 2 |ding 2 |goto 46.38,38.58
You can find more around: |notinsticky
[45.82,44.02]
[50.16,45.83]
[52.06,40.29]
step
kill 10 Kobold Vermin##6 |q 7/1 |goto 47.49,36.15
You can find more around [51.18,37.25]
step
talk Eagan Peltskinner##196
turnin Wolves Across the Border##33 |goto 48.94,40.16
step
Kill enemies around this area
Reach Level 3 |ding 3 |goto 47.49,36.15
You can find more around [51.18,37.25]
step
Enter the building |goto 48.31,41.99 < 15 |walk
talk Marshal McBride##197
|tip Inside the building.
turnin Kobold Camp Cleanup##7 |goto 48.92,41.61
accept Investigate Echo Ridge##15 |goto 48.92,41.61
accept Glyphic Letter##3104 |goto 48.92,41.61 |only Human Mage
accept Simple Letter##3100 |goto 48.92,41.61 |only Human Warrior
accept Tainted Letter##3105 |goto 48.92,41.61 |only Human Warlock
accept Encrypted Letter##3102 |goto 48.92,41.61 |only Human Rogue
accept Hallowed Letter##3103 |goto 48.92,41.61 |only Human Priest
accept Consecrated Letter##3101 |goto 48.92,41.61 |only Human Paladin
step
Follow the path |goto 49.25,40.74 < 7 |walk
Run up the stairs |goto 49.42,40.26 < 7 |walk
talk Khelden Bremen##198
|tip Upstairs inside the building.
turnin Glyphic Letter##3104 |goto 49.66,39.40
|only if Human Mage
step
Follow the path |goto 49.59,41.82 < 7 |walk
talk Llane Beshere##911
|tip Inside the building.
turnin Simple Letter##3100 |goto 50.24,42.28
|only if Human Warrior
step
Follow the path |goto 49.59,41.82 < 7 |walk
talk Brother Sammuel##925
|tip Inside the building.
turnin Consecrated Letter##3101 |goto 50.43,42.12
|only if Human Paladin
step
Follow the path |goto 49.26,40.75 < 7 |walk
Follow the path |goto 49.74,40.24 < 7 |walk
talk Priestess Anetta##375
|tip Inside the building.
turnin Hallowed Letter##3103 |goto 49.81,39.49
|only if Human Priest
step
Leave the building |goto 48.29,42.00 < 10 |walk
talk Deputy Willem##823
accept Brotherhood of Thieves##18 |goto 48.17,42.93
step
talk Drusilla La Salle##459
turnin Tainted Letter##3105 |goto 49.87,42.65
accept The Stolen Tome##1598 |goto 49.87,42.65
|only if Human Warlock
step
talk Jorik Kerridan##915
|tip Outside, behind the building, in the horse stable.
turnin Encrypted Letter##3102 |goto 50.32,39.92
|only if Human Rogue
step
kill 10 Kobold Worker##257 |q 15/1 |goto 47.49,36.15
You can find more around [51.18,37.25]
stickystart "Collect_Red_Burlap_Bandanas"
step
click Stolen Books
collect Powers of the Void##6785 |q 1598/1 |goto 56.71,43.95
|only if Human Warlock
step
talk Drusilla La Salle##459
turnin The Stolen Tome##1598 |goto 49.87,42.65
|only if Human Warlock
step
label "Collect_Red_Burlap_Bandanas"
kill Defias Thug##38+
collect 12 Red Burlap Bandana##752 |q 18/1 |goto 56.09,42.35
You can find more around [53.20,50.30]
step
Kill enemies around this area
Reach Level 4 |ding 4 |goto 56.09,42.35
You can find more around [53.20,50.30]
step
talk Deputy Willem##823
|tip Outside, in front of the building.
turnin Brotherhood of Thieves##18 |goto 48.17,42.94
accept Bounty on Garrick Padfoot##6 |goto 48.17,42.94
accept Milly Osworth##3903 |goto 48.17,42.94
step
Enter the building |goto 48.28,42.02 < 15 |walk
talk Marshal McBride##197
|tip Inside the building.
turnin Investigate Echo Ridge##15 |goto 48.93,41.61
accept Skirmish at Echo Ridge##21 |goto 48.93,41.61
step
Leave the building |goto 48.29,42.01 < 10 |walk
talk Milly Osworth##9296
|tip Outside, behind the building.
turnin Milly Osworth##3903 |goto 50.69,39.35
accept Milly's Harvest##3904 |goto 50.69,39.35
step
kill Garrick Padfoot##103
collect Garrick's Head##182 |q 6/1 |goto 57.51,48.25
step
click Milly's Harvest+
|tip They look like wooden buckets on the ground around this area.
collect 8 Milly's Harvest##11119 |q 3904/1 |goto 53.88,48.55
step
talk Milly Osworth##9296
turnin Milly's Harvest##3904 |goto 50.69,39.35
accept Grape Manifest##3905 |goto 50.69,39.35
step
Kill enemies around this area
Reach Level 5 |ding 5 |goto 56.09,42.35
You can find more around [53.20,50.30]
step
talk Deputy Willem##823
|tip Outside, in front of the building.
turnin Bounty on Garrick Padfoot##6 |goto 48.17,42.94
step
Enter the building |goto 48.29,42.01 < 15 |walk
Run up the stairs |goto 49.56,41.61 < 7 |walk
talk Brother Neals##952
|tip Upstairs inside the building.
turnin Grape Manifest##3905 |goto 49.47,41.58
step
Leave the building |goto 48.28,42.01 < 10 |walk
Enter the mine |goto 47.67,31.86 < 15 |walk
kill 12 Kobold Laborer##80 |q 21/1 |goto 48.41,29.33
|tip Inside the mine.
step
Leave the mine |goto 47.66,31.89 < 15 |walk
Enter the building |goto 48.27,42.01 < 15 |walk
talk Marshal McBride##197
|tip Inside the building.
turnin Skirmish at Echo Ridge##21 |goto 48.92,41.61
accept Report to Goldshire##54 |goto 48.92,41.61
step
Leave the building |goto 48.28,42.01 < 10 |walk
Follow the path |goto 47.05,47.64 < 20 |only if walking
talk Falkhaan Isenstrider##6774
accept Rest and Relaxation##2158 |goto 45.56,47.74
step
talk Marshal Dughan##240
turnin Report to Goldshire##54 |goto 42.11,65.93
accept The Fargodeep Mine##62 |goto 42.11,65.93
step
Enter the building |goto 42.95,65.65 < 10 |walk
talk William Pestle##253
|tip Inside the building.
accept Kobold Candles##60 |goto 43.32,65.70
step
talk Innkeeper Farley##295
|tip Inside the building.
turnin Rest and Relaxation##2158 |goto 43.77,65.81
step
talk Innkeeper Farley##295
|tip Inside the building.
home Goldshire |goto 43.77,65.81 |q 1097 |future
step
Leave the building |goto 42.96,65.66 < 10 |walk
talk Remy "Two Times"##241
accept Gold Dust Exchange##47 |goto 42.14,67.26
step
Enter the building |goto 43.00,89.40 < 10 |walk
talk Maybell Maclure##251
|tip Inside the building.
accept Young Lovers##106 |goto 43.15,89.62
step
Leave the building |goto 43.00,89.40 < 7 |walk
talk Tommy Joe Stonefield##252
turnin Young Lovers##106 |goto 29.84,85.99
accept Speak with Gramma##111 |goto 29.84,85.99
step
talk "Auntie" Bernice Stonefield##246
accept Lost Necklace##85 |goto 34.48,84.26
step
Enter the building |goto 34.82,84.11 < 10 |walk
talk Gramma Stonefield##248
|tip Inside the building.
turnin Speak with Gramma##111 |goto 34.94,83.86
accept Note to William##107 |goto 34.94,83.86
step
Enter the building |goto 34.82,84.11 < 7 |walk
talk Billy Maclure##247
turnin Lost Necklace##85 |goto 43.13,85.72
accept Pie for Billy##86 |goto 43.13,85.72
step
kill Stonetusk Boar##113+
collect 4 Chunk of Boar Meat##769 |q 86/1 |goto 41.86,87.12
step
Kill enemies around this area
Reach Level 6 |ding 6 |goto 41.86,87.12
step
talk "Auntie" Bernice Stonefield##246
turnin Pie for Billy##86 |goto 34.48,84.26
accept Back to Billy##84 |goto 34.48,84.26
step
talk Billy Maclure##247
turnin Back to Billy##84 |goto 43.13,85.72
accept Goldtooth##87 |goto 43.13,85.72
stickystart "Collect_Gold_Dust"
stickystart "Collect_Large_Candles"
step
Enter the mine |goto 38.97,82.33 < 15 |walk
Scout Through the Fargodeep Mine |q 62/1 |goto 39.61,80.21
|tip Inside the mine.
step
Follow the path |goto 39.76,79.21 < 10 |walk
kill Goldtooth##327
|tip He walks around this area inside the mine.
collect Bernice's Necklace##981 |q 87/1 |goto 41.71,78.04
step
label "Collect_Gold_Dust"
Kill Kobold enemies around this area
|tip Inside the mine.
|tip You can find more outside the mine.
collect 10 Gold Dust##773 |q 47/1 |goto 39.61,80.21
step
label "Collect_Large_Candles"
Kill Kobold enemies around this area
|tip Inside the mine.
|tip You can find more outside the mine.
collect 8 Large Candle##772 |q 60/1 |goto 39.61,80.21
step
Kill enemies around this area
|tip You can find more outside the mine.
Reach Level 7 |ding 7 |goto 39.61,80.21
step
talk William Pestle##253
|tip Inside the building.
turnin Kobold Candles##60 |goto 43.32,65.70
accept Shipment to Stormwind##61 |goto 43.32,65.70
turnin Note to William##107 |goto 43.32,65.70
accept Collecting Kelp##112 |goto 43.32,65.70
step
Leave the building |goto 42.96,65.66 < 10 |walk
talk Remy "Two Times"##241
turnin Gold Dust Exchange##47 |goto 42.14,67.26
accept A Fishy Peril##40 |goto 42.14,67.26
step
talk Marshal Dughan##240
turnin A Fishy Peril##40 |goto 42.11,65.93
accept Further Concerns##35 |goto 42.11,65.93
turnin The Fargodeep Mine##62 |goto 42.11,65.93
accept The Jasperlode Mine##76 |goto 42.11,65.93
step
Kill Murloc enemies around this area
collect 4 Crystal Kelp Frond##1256 |q 112/1 |goto 50.20,66.86
You can find more around [55.90,66.66]
step
Enter the mine |goto 61.71,53.87 < 15 |walk
Follow the path |goto 60.83,51.04 < 10 |walk
Scout Through the Jasperlode Mine |q 76/1 |goto 60.38,49.68
step
Follow the path |goto 61.22,51.37 < 10 |walk
Leave the mine |goto 61.74,53.88 < 15 |c |q 35
step
Kill enemies around this area
Reach Level 8 |ding 8 |goto 62.75,55.31
You can find more inside the mine at [61.69,53.76]
step
talk Guard Thomas##261
turnin Further Concerns##35 |goto 73.97,72.18
accept Find the Lost Guards##37 |goto 73.97,72.18
accept Protect the Frontier##52 |goto 73.97,72.18
step
talk Sara Timberlain##278
|tip In front of the building.
accept Red Linen Goods##83 |goto 79.46,68.78
step
talk Supervisor Raelen##10616
accept A Bundle of Trouble##5545 |goto 81.38,66.11
stickystart "Collect_Bundles_Of_Wood"
stickystart "Kill_Young_Forest_Bears"
stickystart "Kill_Prowlers"
step
click A Half-Eaten Body
turnin Find the Lost Guards##37 |goto 72.65,60.33
accept Discover Rolf's Fate##45 |goto 72.65,60.33
step
click Rolf's Corpse
turnin Discover Rolf's Fate##45 |goto 79.80,55.52
accept Report to Thomas##71 |goto 79.80,55.52
step
label "Collect_Bundles_Of_Wood"
click Bundle of Wood+
|tip They look like small stacks of brown logs at the base of trees around this area.
collect 8 Bundle of Wood##13872 |q 5545/1 |goto 77.69,61.78
You can find more around [83.76,60.88]
step
talk Supervisor Raelen##10616
turnin A Bundle of Trouble##5545 |goto 81.38,66.12
step
talk Guard Thomas##261
turnin Report to Thomas##71 |goto 73.97,72.18
accept Deliver Thomas' Report##39 |goto 73.97,72.18
step
Kill Defias enemies around this area
collect 6 Red Linen Bandana##1019 |q 83/1 |goto 69.61,79.38
You can find more around [89.19,79.51]
step
Kill enemies around this area
Reach Level 9 |ding 9 |goto 69.61,79.38
You can find more around [89.19,79.51]
stickystop "Kill_Young_Forest_Bears"
step
talk William Pestle##253
|tip Inside the building.
turnin Collecting Kelp##112 |goto 43.32,65.71
step
Watch the dialogue
talk William Pestle##253
|tip Inside the building.
accept The Escape##114 |goto 43.32,65.71
step
Leave the building |goto 42.96,65.66 < 10 |walk
talk Marshal Dughan##240
turnin Deliver Thomas' Report##39 |goto 42.11,65.93
accept Cloth and Leather Armor##59 |goto 42.11,65.93
turnin The Jasperlode Mine##76 |goto 42.11,65.93
accept Westbrook Garrison Needs Help!##239 |goto 42.11,65.93
stickystart "Kill_Young_Forest_Bears"
step
talk Guard Thomas##261
accept Bounty on Murlocs##46 |goto 73.97,72.18
step
Kill Murloc enemies around this area
|tip You can find more long the edge of the water to the east and west.
|tip They aren't as closely packed together as the ones here.
collect 8 Torn Murloc Fin##780 |q 46/1 |goto 76.29,83.43
You can find more around: |notinsticky
[84.17,87.41]
[69.08,84.54]
step
label "Kill_Young_Forest_Bears"
kill 5 Young Forest Bear##822 |q 52/2 |goto 79.75,83.26
You can find more around: |notinsticky
[78.02,79.06]
[81.17,77.09]
[77.22,76.65]
[72.88,80.83]
[70.61,74.83]
step
label "Kill_Prowlers"
kill 8 Prowler##118 |q 52/1 |goto 78.93,79.13
step
talk Guard Thomas##261
turnin Bounty on Murlocs##46 |goto 73.97,72.18
turnin Protect the Frontier##52 |goto 73.97,72.18
accept Report to Gryan Stoutmantle##109 |goto 73.97,72.18
step
talk Sara Timberlain##278
|tip In front of the building.
turnin Cloth and Leather Armor##59 |goto 79.46,68.79
turnin Red Linen Goods##83 |goto 79.46,68.79
step
Enter the building |goto 41.83,65.67 < 10 |walk
talk Smith Argus##514
|tip Inside the building.
accept Elmore's Task##1097 |goto 41.71,65.55
step
Leave the building |goto 41.83,65.67 < 7 |walk
Enter the building |goto 43.00,89.40 < 10 |walk
talk Maybell Maclure##251
|tip Inside the building.
turnin The Escape##114 |goto 43.15,89.62
step
Leave the building |goto 43.00,89.40 < 7 |walk
talk "Auntie" Bernice Stonefield##246
turnin Goldtooth##87 |goto 34.49,84.25
step
talk Deputy Rainer##963
turnin Westbrook Garrison Needs Help!##239 |goto 24.23,74.45
accept Riverpaw Gnoll Bounty##11 |goto 24.23,74.45
step
Kill Riverpaw enemies around this area
collect 8 Painted Gnoll Armband##782 |q 11/1 |goto 26.75,86.83
You can find more around [24.75,94.05]
step
Kill enemies around this area
Reach Level 10 |ding 10 |goto 26.75,86.83
You can find more around [24.75,94.05]
step
talk Deputy Rainer##963
turnin Riverpaw Gnoll Bounty##11 |goto 24.23,74.45
step
Follow the road |goto 27.19,77.82 < 30 |c |q 61
step
talk Lyria Du Lac##913
accept A Warrior's Training##1638 |goto 41.09,65.77
|only if Human Warrior
step
Enter the building |goto 42.95,65.66 < 10 |walk
talk Remen Marcot##6121
|tip Downstairs inside the building.
accept Gakin's Summons##1685 |goto 44.49,66.27
|only if Human Warlock
step
Leave the building |goto 42.95,65.65 < 10 |c |q 61
|only if Human Warlock
step
Enter the building |goto Elwynn Forest 42.95,65.64 < 7 |walk
talk Priestess Josetta##377
|tip Upstairs inside the building.
accept Desperate Prayer##5637 |goto Elwynn Forest 43.29,65.72
|only if Human Priest
step
Leave the building |goto 42.95,65.64 < 7 |c |q 5637
|only if Human Priest
step
Follow the road |goto 42.20,64.85 < 30 |only if walking
Enter Stormwind City |goto 32.09,49.38 < 30 |only if walking
Enter the building |goto Stormwind City 56.59,64.87 < 10 |walk
talk Morgan Pestle##279
|tip Inside the building.
turnin Shipment to Stormwind##61 |goto Stormwind City 56.21,64.59
step
Enter the building |goto Stormwind City 71.60,39.93 < 10 |walk
talk Harry Burlguard##6089
|tip Inside the building.
turnin A Warrior's Training##1638 |goto Stormwind City 74.25,37.26
accept Bartleby the Drunk##1639 |goto Stormwind City 74.25,37.26
|only if Human Warrior
step
talk Bartleby##6090
|tip He walks around this area inside the building.
turnin Bartleby the Drunk##1639 |goto 73.83,37.17
accept Beat Bartleby##1640 |goto 73.83,37.17
|tip He will attack you immediately after you accept this quest.
|only if Human Warrior
step
kill Bartleby##6090
|tip He walks around this area inside the building.
|tip He will eventually surrender.
Beat Bartleby |q 1640/1 |goto 73.83,37.17
|only if Human Warrior
step
talk Bartleby##6090
|tip He walks around this area inside the building.
turnin Beat Bartleby##1640 |goto 73.83,37.17
accept Bartleby's Mug##1665 |goto 73.83,37.17
|only if Human Warrior
step
talk Harry Burlguard##6089
|tip Inside the building.
turnin Bartleby's Mug##1665 |goto 74.25,37.26
|only if Human Warrior
step
Leave the building |goto 71.65,39.91 < 10 |c |q 1097
|only if Human Warrior
step
Enter the building |goto Stormwind City 29.15,74.18 < 10 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Gakin's Summons##1685 |goto Stormwind City 25.26,78.56
accept Surena Caledon##1688 |goto Stormwind City 25.26,78.56
|only Human Warlock
step
Leave the building |goto 29.15,74.18 < 10 |walk
Leave Stormwind City |goto Stormwind City 71.02,89.03 < 30 |only if walking
Follow the road |goto Elwynn Forest 42.68,67.14 < 30 |only if walking
Follow the path |goto Elwynn Forest 64.57,74.00 < 30 |only if walking
Enter the building |goto Elwynn Forest 70.93,80.43 < 10 |walk
talk Surena Caledon##881
|tip Inside the building.
collect Surena's Choker##6810 |q 1688/1 |goto Elwynn Forest 71.02,80.78
|only if Human Warlock
step
Follow the road |goto 65.65,74.10 < 30 |only if walking
Continue following the road |goto 42.11,64.65 < 30 |only if walking
Enter Stormwind City |goto 32.09,49.38 < 30 |only if walking
Enter the building |goto Stormwind City 29.15,74.18 < 10 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Surena Caledon##1688 |goto Stormwind City 25.26,78.56
accept The Binding##1689 |goto Stormwind City 25.26,78.56
|only Human Warlock
step
Follow the path down |goto 25.05,79.31 < 7 |walk
Run down the stairs |goto 24.28,78.62 < 7 |walk
Run down the stairs |goto 26.15,79.33 < 7 |walk
use the Bloodstone Choker##6928
|tip Use it while standing on the pink symbol on the ground.
|tip Downstairs inside the building, inside the crypt.
kill Summoned Voidwalker##5676 |q 1689 |goto 25.11,77.46
|only if Human Warlock
step
Follow the path up |goto 26.03,79.83 < 7 |walk
Run up the stairs |goto 23.31,79.68 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Upstairs inside the building, in the basement above the crypt.
turnin The Binding##1689 |goto 25.25,78.53
|only if Human Warlock
step
Follow the path up |goto 26.84,77.14 < 7 |walk
Leave the building |goto 29.15,74.14 < 10 |c |q 1097
|only if Human Warlock
step
Enter the building |goto Stormwind City 43.04,34.51 < 7 |walk
talk High Priestess Laurena##376
|tip Inside the building.
turnin Desperate Prayer##5637 |goto Stormwind City 38.58,26.02
|only if Human Priest
step
Leave the building |goto Stormwind City 43.04,34.51 < 7 |c |q 1097
|only if Human Priest
step
Enter the building |goto 51.83,13.26 < 10 |walk
talk Grimand Elmore##1416
|tip Inside the building.
turnin Elmore's Task##1097 |goto 51.76,12.07
accept Stormpike's Delivery##353 |goto 51.76,12.07
step
Follow the path |goto 60.27,12.57 < 15 |walk
Enter the Deeprun Tram |goto 63.92,8.20 > 2000 |c |q 433 |future
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the Deeprun Tram from Stormwind City to Ironforge.
Click Here After Riding the Tram |confirm |q 433 |future
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip On the middle platform, near the wall.
|tip In the Ironforge section of the Deeprun Tram.
accept Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
use Rat Catcher's Flute##17117
|tip Use it on Deeprun Rats around this area.
|tip They look like small grey rats on the ground around this area.
|tip In the Ironforge section of the Deeprun Tram.
Capture #5# Rats |q 6661/1
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip On the middle platform, near the wall.
|tip In the Ironforge section of the Deeprun Tram.
turnin Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
Enter Ironforge |goto Ironforge 76.51,51.12 < 2000 |noway |c |q 433 |future
step
talk Gryth Thurden##1573
fpath Ironforge |goto Ironforge 55.50,47.75
step
Follow the path |goto 31.04,79.73 < 20 |walk
Leave Ironforge |goto 15.09,85.88 < 15 |walk
Follow the road |goto Dun Morogh 51.47,47.54 < 30 |only if walking
talk Senator Mehr Stonehallow##1977
accept The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Foreman Stonebrow##1254
accept Those Blasted Troggs!##432 |goto 69.08,56.33
stickystart "Kill_Rockjaw_Skullthumpers"
step
Enter the cave |goto 70.52,56.67 < 15 |walk
kill 10 Rockjaw Bonesnapper##1117 |q 433/1 |goto 70.98,54.77
|tip Inside the cave.
step
label "Kill_Rockjaw_Skullthumpers"
kill 6 Rockjaw Skullthumper##1115 |q 432/1 |goto 70.98,54.77
|tip You can find more outside the cave.
step
Leave the cave |goto 70.52,56.67 < 15 |walk
Follow the path up |goto 67.86,57.69 < 15 |only if walking
talk Senator Mehr Stonehallow##1977
turnin The Public Servant##433 |goto 68.67,55.97
step
talk Foreman Stonebrow##1254
turnin Those Blasted Troggs!##432 |goto 69.08,56.33
step
Kill enemies around this area
Reach Level 11 |ding 11 |goto 69.75,58.15
You can find more inside the cave at [70.64,56.55]
step
Follow the road |goto 67.26,52.92 < 30 |only if walking
Continue following the road |goto 78.18,49.39 < 30 |only if walking
Enter the tunnel |goto 81.21,42.70 < 15 |only if walking
Leave the tunnel |goto 82.98,40.34 < 15 |only if walking
talk Pilot Hammerfoot##1960
accept The Lost Pilot##419 |goto 83.89,39.19
step
Follow the path |goto 81.02,36.12 < 30 |only if walking
click A Dwarven Corpse
turnin The Lost Pilot##419 |goto 79.67,36.17
accept A Pilot's Revenge##417 |goto 79.67,36.17
step
kill Mangeclaw##1961
collect Mangy Claw##3183 |q 417/1 |goto 78.31,37.76
step
Follow the path |goto 81.10,36.13 < 30 |only if walking
talk Pilot Hammerfoot##1960
turnin A Pilot's Revenge##417 |goto 83.89,39.19
step
Enter the tunnel |goto 82.96,40.36 < 15 |only if walking
Leave the tunnel |goto 81.22,42.67 < 15 |only if walking
Follow the path |goto 78.64,50.34 < 30 |only if walking
Enter the tunnel |goto 82.30,53.40 < 15 |only if walking
Leave the tunnel |goto 84.20,51.34 < 15 |only if walking
Enter the tunnel |goto 86.25,51.32 < 15 |only if walking
Leave the tunnel |goto Loch Modan 19.54,62.67 < 15 |only if walking
talk Mountaineer Cobbleflint##1089
accept In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.12
step
Enter the building |goto 23.71,75.47 < 15 |walk
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
accept The Trogg Threat##267 |goto 23.23,73.67
stickystart "Kill_Stonesplinter_Troggs"
stickystart "Kill_Stonesplinter_Scouts"
step
Leave the building |goto 23.72,75.48 < 15 |walk
Follow the road up |goto 23.20,70.46 < 20 |only if walking
Follow the path |goto 28.43,65.77 < 30 |only if walking
Kill Stonesplinter enemies around this area
collect 8 Trogg Stone Tooth##2536 |q 267/1 |goto 32.51,73.25
step
label "Kill_Stonesplinter_Troggs"
kill 10 Stonesplinter Trogg##1161 |q 224/1 |goto 32.51,73.25
step
label "Kill_Stonesplinter_Scouts"
kill 10 Stonesplinter Scout##1162 |q 224/2 |goto 32.51,73.25
step
Follow the path |goto 30.64,69.80 < 20 |only if walking
Follow the road down |goto 27.64,65.84 < 30 |only if walking
talk Mountaineer Cobbleflint##1089
turnin In Defense of the King's Lands##224 |goto 22.07,73.13
step
Enter the building |goto 23.71,75.45 < 15 |walk
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
turnin The Trogg Threat##267 |goto 23.23,73.67
step
Leave the building |goto 23.72,75.47 < 15 |walk
Follow the road up |goto 23.20,70.46 < 20 |only if walking
Follow the path |goto 28.43,65.77 < 30 |only if walking
Kill enemies around this area
Reach Level 12 |ding 12 |goto 32.51,73.25
step
Follow the path |goto 30.44,69.42 < 20 |only if walking
Follow the road |goto 28.45,63.62 < 30 |only if walking
talk Thorgrum Borrelson##1572
fpath Thelsamar |goto 33.94,50.95
step
talk Mountaineer Kadrell##1340
|tip He walks around this area.
accept Rat Catching##416 |goto 34.50,47.32
step
Enter the building |goto 35.23,47.75 < 10 |walk
talk Innkeeper Hearthstove##6734
|tip Inside the building.
home Stoutlager Inn |goto 35.53,48.40 |q 416
step
talk Vidra Hearthstove##1963
|tip Inside the building.
accept Thelsamar Blood Sausages##418 |goto 34.83,49.28
stickystart "Collect_Spider_Ichors"
stickystart "Collect_Bear_Meat"
step
Leave the building |goto 35.21,47.76 < 10 |walk
kill Mountain Boar##1190+
collect 3 Boar Intestines##3172 |goto 36.99,34.36 |q 418
You can find more around [29.17,23.57]
step
label "Collect_Spider_Ichors"
kill Forest Lurker##1195+
collect 3 Spider Ichor##3174 |goto 35.69,31.78 |q 418
You can find more around: |notinsticky
[29.17,23.57]
[29.43,48.28]
stickystart "Collect_Tunnel_Rat_Ears"
step
label "Collect_Bear_Meat"
kill Elder Black Bear##1186+
collect 3 Bear Meat##3173 |goto 35.68,32.10 |q 418
You can find more around: |notinsticky
[30.73,25.86]
[28.66,11.57]
[24.03,25.79]
[27.45,28.54]
[28.09,40.94]
step
label "Collect_Tunnel_Rat_Ears"
Kill Tunnel Rat enemies around this area
collect 12 Tunnel Rat Ear##3110 |q 416/1 |goto 24.57,29.79
You can find more around [26.08,43.64]
step
Enter the building |goto 23.53,17.90 < 15 |walk
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Stormpike's Delivery##353 |goto 24.76,18.40
accept Filthy Paws##307 |goto 24.76,18.40
step
Leave the building |goto 23.53,17.90 < 10 |walk
Enter the mine |goto 35.48,18.83 < 15 |walk
click Miners' League Crates+
|tip They look like piles of brown boxes on the ground around this area inside the mine.
collect 4 Miners' Gear##2640 |q 307/1 |goto 35.75,22.42
step
Leave the mine |goto 35.46,18.72 < 15 |walk
Enter the building |goto 23.50,17.89 < 15 |walk
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Filthy Paws##307 |goto 24.76,18.40
step
talk Vidra Hearthstove##1963
|tip Inside the building.
turnin Thelsamar Blood Sausages##418 |goto 34.83,49.29
step
Leave the building |goto 35.22,47.75 < 10 |walk
talk Mountaineer Kadrell##1340
|tip He walks around this area.
turnin Rat Catching##416 |goto 34.61,47.09
step
Follow the path |goto Ironforge 30.83,80.04 < 20 |walk
Leave Ironforge |goto Ironforge 15.15,85.80 < 20 |walk
Follow the path |goto Dun Morogh 43.74,44.12 < 30 |only if walking
Continue following the path |goto Dun Morogh 38.97,38.75 < 30 |only if walking
Follow the path up |goto Dun Morogh 30.71,34.33 < 15 |only if walking
Continue up the path |goto Dun Morogh 31.06,32.56 < 10 |only if walking
Continue up the path |goto Dun Morogh 31.43,32.34 < 10 |only if walking
Continue up the path |goto Dun Morogh 31.14,30.50 < 10 |only if walking
Follow the path down |goto Dun Morogh 32.33,28.63 < 10 |only if walking
Follow the path |goto Dun Morogh 32.74,27.11
Jump to Your Death
|tip Run north from the last travel line in this step, until your map changes to the Wetlands.
|tip While you are in the Wetlands, keep running north and jump off the cliff.
|tip Resurrect at the Spirit Healer near Menethil Harbor.
|tip This is much easier and faster than running all the way through the Wetlands, dying repeatedly.
Resurrect at the Spirit Healer Near Menethil Harbor |goto Wetlands 11.02,43.79 < 50 |noway |c |q 983 |future
step
Cross the bridge |goto Wetlands 12.38,50.30 < 20 |only if walking
Follow the path |goto Wetlands 10.86,55.08 < 20 |only if walking
talk Shellei Brondir##1571
fpath Menethil Harbor |goto Wetlands 9.49,59.69
step
Run up the ramp |goto Darkshore 36.72,43.87 < 10 |walk
talk Wizbang Cranktoggle##3666
|tip Upstairs inside the building.
accept Buzzbox 827##983 |goto Darkshore 36.98,44.14
step
talk Innkeeper Shaussiy##6737
|tip Inside the building.
home Auberdine |goto 37.04,44.12 |q 1001 |future
step
talk Gwennyth Bly'Leggonde##10219
accept Washed Ashore##3524 |goto 36.62,45.59
step
talk Caylais Moonfeather##3841
fpath Auberdine |goto 36.34,45.58
step
Enter the building |goto 38.97,43.56 < 15 |walk
talk Terenthis##3693
|tip Inside the building.
accept How Big a Threat?##984 |goto 39.37,43.48
step
Enter the building |goto 37.77,41.36 < 15 walk
talk Thundris Windweaver##3649
|tip Inside the building.
accept Bashal'Aran##954 |goto 37.39,40.13
step
Leave the building |goto 37.77,41.34 < 15 |walk
kill Pygmy Tide Crawler##2231+
collect 6 Crawler Leg##5385 |q 983/1 |goto 36.12,48.70
step
click Beached Sea Creature
collect Sea Creature Bones##12242 |q 3524/1 |goto 36.39,50.88
step
click Buzzbox 827
turnin Buzzbox 827##983 |goto 36.66,46.26
accept Buzzbox 411##1001 |goto 36.66,46.26
step
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##3524 |goto 36.62,45.59
accept Washed Ashore##4681 |goto 36.62,45.59
step
kill Darkshore Thresher##2185
|tip Underwater around this area.
collect 3 Thresher Eye##5412 |q 1001/1 |goto 31.60,39.75
You can find more around: |notinsticky
[35.39,37.08]
step
click Skeletal Sea Turtle
|tip Underwater.
collect Sea Turtle Remains##12289 |q 4681/1 |goto 31.87,46.32
step
Find a Corrupt Furbolg Camp |q 984/1 |goto 39.26,53.12
step
Enter the building |goto 38.96,43.56 < 15 |walk
talk Terenthis##3693
|tip Inside the building.
turnin How Big a Threat?##984 |goto 39.37,43.48
accept Thundris Windweaver##4761 |goto 39.37,43.48
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin Thundris Windweaver##4761 |goto 37.39,40.13
step
Leave the building |goto 37.76,41.34 < 15 |walk
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##4681 |goto 36.62,45.59
step
Follow the road |goto 40.30,46.37 < 20 |only if walking
Follow the path |goto 42.90,36.58 < 30 |only if walking
Follow the path up |goto 44.25,36.82 < 15 |only if walking
talk Asterion##3650
turnin Bashal'Aran##954 |goto 44.17,36.29
accept Bashal'Aran##955 |goto 44.17,36.29
step
Kill enemies around this area
|tip Only Vile Sprites and Wild Grells will drop the quest item.
collect 8 Grell Earring##5336 |q 955/1 |goto 45.13,38.46
You can find more around [47.72,37.13]
step
talk Asterion##3650
turnin Bashal'Aran##955 |goto 44.17,36.29
step
click Buzzbox 411
turnin Buzzbox 411##1001 |goto 41.96,28.64
step
Kill enemies around this area
Reach Level 13 |ding 13 |goto 45.13,38.46
You can find more around [47.72,37.13]
step
Run up the ramp |goto Stormwind City 72.00,80.49 < 20 |only if walking
Leave Stormwind City |goto Stormwind City 71.06,88.93 < 30 |only if walking
talk Brother Wilhelm##927
accept Tome of Divinity##2998 |goto Elwynn Forest 41.10,66.04
|only if Human Paladin
step
Enter Stormwind City |goto 32.08,49.23 < 30 |only if walking
Enter the building |goto Stormwind City 43.44,35.14 < 15 |walk
talk Duthorian Rall##6171
|tip Inside the building.
turnin Tome of Divinity##2998 |goto Stormwind City 39.81,29.80
|only if Human Paladin
step
use the Tome of Divinity##6775
accept The Tome of Divinity##1642
|only if Human Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1642 |goto 39.81,29.80
accept The Tome of Divinity##1643 |goto 39.81,29.80
|only if Human Paladin
step
Leave the building |goto 43.06,34.49 < 15 |walk
talk Stephanie Turner##6174
turnin The Tome of Divinity##1643 |goto 57.08,61.74
accept The Tome of Divinity##1644 |goto 57.08,61.74
|only if Human Paladin
step
Enter the building |goto 53.99,58.98 < 10 |walk
talk Auctioneer Jaxon##15659
|tip Inside the building.
collect 10 Linen Cloth##2589 |q 1644/1 |goto 53.61,59.76
|tip Buy them from the Auction House.
|only if Human Paladin
step
Leave the building |goto 53.86,58.92 < 7 |walk
talk Stephanie Turner##6174
turnin The Tome of Divinity##1644 |goto 57.08,61.74
accept The Tome of Divinity##1780 |goto 57.08,61.74
|only if Human Paladin
step
Enter the building |goto 43.44,35.14 < 15 |walk
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1780 |goto 39.81,29.80
accept The Tome of Divinity##1781 |goto 39.81,29.80
|only if Human Paladin
step
Leave the building |goto 43.06,34.49 < 15 |walk
Leave Stormwind City |goto 71.05,88.81 < 30 |only if walking
Follow the road |goto Elwynn Forest 42.70,67.19 < 30 |only if walking
Follow the path |goto Elwynn Forest 69.14,70.95 < 30 |only if walking
use the Symbol of Life##6866
|tip Use it on Henze Faulk's corpse.
Ressurect Henze Faulk |q 1786/1 |goto Elwynn Forest 72.60,51.41
|only if Human Paladin
step
talk Henze Faulk##6172
turnin The Tome of Divinity##1786 |goto 72.60,51.41
accept The Tome of Divinity##1787 |goto 72.60,51.41
|only if Human Paladin
step
kill Defias Rogue Wizard##474+
collect Defias Script##6846 |q 1787/1 |goto 74.07,51.57
|only if Human Paladin
step
Follow the road |goto 70.14,70.84 < 30 |only if walking
Continue following the road |goto 42.19,64.92 < 30 |only if walking
Enter Stormwind City |goto 32.07,49.32 < 30 |only if walking
Enter the building |goto Stormwind City 43.44,35.14 < 15 |walk
talk Gazin Tenorm##6173
|tip Inside the building.
turnin The Tome of Divinity##1787 |goto Stormwind City 38.56,26.47
accept The Tome of Divinity##1788 |goto Stormwind City 38.56,26.47
|only if Human Paladin
step
talk Duthorian Rall##6171
|tip Inside the building.
turnin The Tome of Divinity##1788 |goto 39.81,29.80
|only if Human Paladin
step
Leave the building |goto Stormwind City 43.44,35.14 < 15 |c |q 109
|only if Human Paladin
step
Leave Stormwind City |goto Stormwind City 69.76,85.39 < 30 |only if walking
talk Marshal Dughan##240
accept Report to Gryan Stoutmantle##109 |goto Elwynn Forest 42.11,65.93
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Night Elf (1-13)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\NightElf",
condition_suggested=function() return raceclass('NightElf') and level <= 13 end,
condition_suggested_exclusive=true,
next="Leveling Guides\\Leveling (13-20)",
startlevel=1,
endlevel=13
},[[
author support@zygorguides.com
defaultfor NightElf
next Leveling (13-20)
step
talk Conservator Ilthalaine##2079
accept The Balance of Nature##456 |goto Teldrassil 58.69,44.27
stickystart "Kill_Young_Thistle_Boars"
step
kill 7 Young Nightsaber##2031 |q 456/1 |goto 61.93,42.02
step
label "Kill_Young_Thistle_Boars"
kill 4 Young Thistle Boar##1984 |q 456/2 |goto 61.93,42.02
step
Kill enemies around this area
Reach Level 2 |ding 2 |goto 61.93,42.02
step
talk Dirania Silvershine##8583
accept A Good Friend##4495 |goto 60.90,41.96
step
talk Melithar Staghelm##2077
accept The Woodland Protector##458 |goto 59.93,42.48
step
talk Conservator Ilthalaine##2079
turnin The Balance of Nature##456 |goto 58.70,44.27
accept The Balance of Nature##457 |goto 58.70,44.27
accept Simple Sigil##3116 |goto 58.70,44.27 |only NightElf Warrior
accept Encrypted Sigil##3118 |goto 58.70,44.27 |only NightElf Rogue
accept Hallowed Sigil##3119 |goto 58.70,44.27 |only NightElf Priest
accept Etched Sigil##3117 |goto 58.70,44.27 |only NightElf Hunter
accept Verdant Sigil##3120 |goto 58.70,44.27 |only NightElf Druid
step
Enter the building |goto 59.94,42.38 < 15 |walk
Run up the ramp |goto 59.19,40.00 < 10 |walk
talk Alyissia##3593
|tip Inside the building.
turnin Simple Sigil##3116 |goto 59.63,38.45
|only if NightElf Warrior
step
Leave the building |goto 60.02,42.37 < 20 |c |q 458
|only if NightElf Warrior
step
Enter the building |goto 59.94,42.38 < 15 |walk
Run up the ramp |goto 59.19,40.00 < 10 |walk
talk Frahun Shadewhisper##3594
|tip Inside the building.
turnin Encrypted Sigil##3118 |goto 59.64,38.66
|only if NightElf Rogue
step
Leave the building |goto 60.02,42.37 < 20 |c |q 458
|only if NightElf Rogue
step
Run up the ramp |goto 59.97,41.90 < 10 |walk
talk Shanda##3595
|tip Upstairs inside the building.
turnin Hallowed Sigil##3119 |goto 59.17,40.44
|only if NightElf Priest
step
Leave the building |goto 60.02,42.37 < 20 |c |q 458
|only if NightElf Priest
step
Run up the ramp |goto 57.53,41.63 < 15 |only if walking
Enter the building |goto 58.51,40.71 < 10 |walk
talk Ayanna Everstride##3596
|tip Up in the tall tree, inside the building.
turnin Etched Sigil##3117 |goto 58.65,40.45
|only if NightElf Hunter
step
Run up the ramp |goto 57.53,41.63 < 15 |only if walking
Enter the building |goto 58.51,40.71 < 10 |walk
talk Mardant Strongoak##3597
|tip Up in the tall tree, inside the building.
turnin Verdant Sigil##3120 |goto 58.63,40.29
|only if NightElf Druid
step
talk Tarindrella##1992
turnin The Woodland Protector##458 |goto 57.83,45.20
accept The Woodland Protector##459 |goto 57.83,45.20
step
kill Grell##1988+
collect 8 Fel Moss##3297 |q 459/1 |goto 56.08,45.83
You can find more around [54.75,44.01]
step
Kill enemies around this area
Reach Level 3 |ding 3 |goto 56.08,45.83
You can find more around [54.75,44.01]
step
talk Tarindrella##1992
turnin The Woodland Protector##459 |goto 57.83,45.20
step
talk Gilshalan Windwalker##2082
accept Webwood Venom##916 |goto 57.81,41.65
stickystart "Kill_Thistle_Boars"
step
kill 7 Mangy Nightsaber##2032 |q 457/1 |goto 60.12,35.06
You can find more around [62.60,37.94]
step
label "Kill_Thistle_Boars"
kill 7 Thistle Boar##1985 |q 457/1 |goto 60.12,35.06
step
Kill enemies around this area
Reach Level 4 |ding 4 |goto 60.12,35.06
You can find more around [62.60,37.94]
step
kill Webwood Spider##1986+
|tip Inside and outside the cave.
collect 10 Webwood Venom Sac##5166 |q 916/1 |goto 56.80,31.59
step
Follow the path |goto 55.52,32.84 < 20 |only if walking
talk Iverron##8584
turnin A Good Friend##4495 |goto 54.60,32.99
accept A Friend in Need##3519 |goto 54.60,32.99
step
talk Gilshalan Windwalker##2082
turnin Webwood Venom##916 |goto 57.81,41.65
accept Webwood Egg##917 |goto 57.81,41.65
step
talk Conservator Ilthalaine##2079
turnin The Balance of Nature##457 |goto 58.70,44.26
step
talk Dirania Silvershine##8583
turnin A Friend in Need##3519 |goto 60.90,41.96
accept Iverron's Antidote##3521 |goto 60.90,41.96
step
click Hyacinth Mushroom+
|tip They look like clusters of pink mushrooms on the ground around this area.
|tip They are usually at the base of trees.
collect Hyacinth Mushroom##10639 |q 3521/1 |goto 61.07,43.43 |count 1
step
click Hyacinth Mushroom+
|tip They look like clusters of pink mushrooms on the ground around this area.
|tip They are usually at the base of trees.
collect Hyacinth Mushroom##10639 |q 3521/1 |goto 60.35,44.21 |count 2
step
click Hyacinth Mushroom+
|tip They look like clusters of pink mushrooms on the ground around this area.
|tip They are usually at the base of trees.
collect Hyacinth Mushroom##10639 |q 3521/1 |goto 60.52,46.66 |count 3
step
click Hyacinth Mushroom+
|tip They look like clusters of pink mushrooms on the ground around this area.
|tip They are usually at the base of trees.
collect Hyacinth Mushroom##10639 |q 3521/1 |goto 59.78,46.02 |count 4
step
click Hyacinth Mushroom+
|tip They look like clusters of pink mushrooms on the ground around this area.
|tip They are usually at the base of trees.
collect Hyacinth Mushroom##10639 |q 3521/1 |goto 59.50,45.80 |count 5
step
click Hyacinth Mushroom+
|tip They look like clusters of pink mushrooms on the ground around this area.
|tip They are usually at the base of trees.
collect Hyacinth Mushroom##10639 |q 3521/1 |goto 58.97,47.11 |count 6
step
click Hyacinth Mushroom+
|tip They look like clusters of pink mushrooms on the ground around this area.
|tip They are usually at the base of trees.
collect Hyacinth Mushroom##10639 |q 3521/1 |goto 54.45,43.18 |count 7
step
click Moonpetal Lily+
|tip They look like tall flowers with orange petals on the ground around this area.
collect 4 Moonpetal Lily##10641 |q 3521/2 |goto 57.72,37.76
step
kill Webwood Spider##1986+
|tip Inside and outside the cave.
collect Webwood Ichor##10640 |q 3521/3 |goto 56.78,31.55
step
Kill enemies around this area
|tip Inside and outside the cave.
Reach Level 5 |ding 5 |goto 56.78,31.55
step
Enter the cave |goto 56.77,31.52 < 15 |walk
Follow the path down |goto 56.83,28.94 < 10 |walk
Follow the path up |goto 56.21,26.40 < 15 |walk
Continue up the path |goto 55.71,25.10 < 10 |walk
click Webwood Eggs
|tip Upstairs inside the cave.
collect Webwood Egg##5167 |q 917/1 |goto 56.80,26.43
step
talk Gilshalan Windwalker##2082
turnin Webwood Egg##917 |goto 57.81,41.65
accept Tenaron's Summons##920 |goto 57.81,41.65
step
Run up the ramp |goto 57.54,41.62 < 7 |only if walking
Enter the building |goto 59.29,39.09 < 7 |walk
talk Tenaron Stormgrip##3514
|tip At the very top of the tall tree, inside the building.
turnin Tenaron's Summons##920 |goto 59.07,39.45
accept Crown of the Earth##921 |goto 59.07,39.45
step
Leave the building |goto 59.29,39.09 < 7 |walk
talk Dirania Silvershine##8583
turnin Iverron's Antidote##3521 |goto 60.90,41.96
accept Iverron's Antidote##3522 |goto 60.90,41.96
step
use the Crystal Phial##5185
collect Filled Crystal Phial##5184 |q 921/1 |goto 59.94,33.04
step
Follow the path |goto 55.52,32.84 < 20 |only if walking
talk Iverron##8584
turnin Iverron's Antidote##3522 |goto 54.59,32.99
step
Run up the ramp |goto 57.54,41.62 < 10 |only if walking
Enter the building |goto 59.29,39.09 < 7 |walk
talk Tenaron Stormgrip##3514
|tip At the very top of the tall tree, inside the building.
turnin Crown of the Earth##921 |goto 59.07,39.45
accept Crown of the Earth##928 |goto 59.07,39.45
step
Leave the building |goto 59.29,39.09 < 7 |walk
talk Porthannius##6780
accept Dolanaar Delivery##2159 |goto 61.16,47.64
step
Follow the road |goto 61.76,50.98 < 30 |only if walking
talk Zenn Foulhoof##2150
accept Zenn's Bidding##488 |goto 60.45,56.15
stickystart "Collect_Nightsaber_Fangs"
step
kill Strigid Owl##1995
collect 3 Strigid Owl Feather##3411 |q 488/2 |goto 63.65,53.56
You can find more around: |notinsticky
[65.26,51.94]
[67.49,53.76]
step
Kill enemies around this area
Reach Level 6 |ding 6 |goto 63.65,53.56
You can find more around: |notinsticky
[65.26,51.94]
[67.49,53.76]
stickystart "Collect_Webwood_Spider_Silk"
step
label "Collect_Nightsaber_Fangs"
kill Nightsaber##2042+
collect 3 Nightsaber Fang##3409 |q 488/1 |goto 62.05,60.06
You can find more around [59.77,62.02]
step
label "Collect_Webwood_Spider_Silk"
kill Webwood Lurker##1998+
collect 3 Webwood Spider Silk##3412 |q 488/3 |goto 60.36,58.07
You can find more around [61.11,54.53]
step
talk Zenn Foulhoof##2150
turnin Zenn's Bidding##488 |goto 60.45,56.15
step
talk Syral Bladeleaf##2083
accept Seek Redemption!##489 |goto 56.08,57.73
accept Denalan's Earth##997 |goto 56.08,57.73
step
talk Athridas Bearmantle##2078
accept A Troubling Breeze##475 |goto 55.95,57.28
step
Enter the building |goto 55.75,57.23 < 7 |walk
talk Tallonkai Swiftroot##3567
|tip At the top of the tower.
accept Twisted Hatred##932 |goto 55.57,56.95
accept The Emerald Dreamcatcher##2438 |goto 55.57,56.95
step
Leave the building |goto 55.32,56.81 < 7 |walk
Run up the ramp |goto 56.09,59.68 < 10 |walk
talk Innkeeper Keldamyr##6736
|tip Upstairs inside the building.
turnin Dolanaar Delivery##2159 |goto 55.62,59.79
step
talk Innkeeper Keldamyr##6736
|tip Upstairs inside the building.
home Dolanaar |goto 55.62,59.79
step
talk Corithras Moonrage##3515
turnin Crown of the Earth##928 |goto 56.14,61.71
accept Crown of the Earth##929 |goto 56.14,61.71
step
Follow the road |goto 57.64,57.35 < 30 |only if walking
use the Jade Phial##5619
collect Filled Jade Phial##5639 |q 929/1 |goto 63.38,58.08
step
Enter the building |goto 66.23,58.37 < 15 |walk
talk Gaerolas Talvethren##2107
|tip Upstairs inside the building.
turnin A Troubling Breeze##475 |goto 66.26,58.52
accept Gnarlpine Corruption##476 |goto 66.26,58.52
step
Enter the building |goto 67.82,59.46 < 10 |walk
click Tallonkai's Dresser
|tip Inside the building.
collect Emerald Dreamcatcher##8048 |q 2438/1 |goto 68.01,59.63
step
Leave the building |goto 67.82,59.46 < 7 |walk
click Fel Cone+
|tip They look like small brown balls green smoke rising out of them at the base of trees around this area.
collect Fel Cone##3418 |q 489/1 |goto 68.61,57.83 |count 1
step
click Fel Cone+
|tip They look like small brown balls green smoke rising out of them at the base of trees around this area.
collect Fel Cone##3418 |q 489/1 |goto 66.90,61.34 |count 2
step
click Fel Cone+
|tip They look like small brown balls green smoke rising out of them at the base of trees around this area.
collect Fel Cone##3418 |q 489/1 |goto 63.58,62.28 |count 3
step
Kill enemies around this area
Reach Level 7 |ding 7 |goto 64.94,62.82
step
talk Zenn Foulhoof##2150
turnin Seek Redemption!##489 |goto 60.45,56.15
step
talk Athridas Bearmantle##2078
turnin Gnarlpine Corruption##476 |goto 55.95,57.28
accept The Relics of Wakening##483 |goto 55.95,57.28
step
Enter the building |goto 55.75,57.23 < 7 |walk
talk Tallonkai Swiftroot##3567
|tip At the top of the tower.
turnin The Emerald Dreamcatcher##2438 |goto 55.57,56.95
accept Ferocitas the Dream Eater##2459 |goto 55.57,56.95
step
Leave the building |goto 55.32,56.81 < 7 |walk
talk Corithras Moonrage##3515
turnin Crown of the Earth##929 |goto 56.14,61.71
accept Crown of the Earth##933 |goto 56.14,61.71
step
Follow the path |goto 56.94,63.12 < 20 |only if walking
Continue following the path |goto 59.42,64.64 <  30 |only if walking
talk Denalan##2080
|tip He walks around this area.
turnin Denalan's Earth##997 |goto 60.90,68.49
step
Watch the dialogue
talk Denalan##2080
|tip He walks around this area.
accept Timberling Seeds##918 |goto 60.80,68.54
accept Timberling Sprouts##919 |goto 60.80,68.54
stickystart "Collect_Timberling_Seeds"
step
click Timberling Sprout+
|tip They look like green and brown vine balls on the ground around this area.
collect 12 Timberling Sprout##5169 |q 919/1 |goto 59.52,72.20
You can find more around [60.73,65.71]
step
label "Collect_Timberling_Seeds"
kill Timberling##2022+
collect 8 Timberling Seed##5168 |q 918/1 |goto 59.52,72.20
You can find more around [60.73,65.71]
step
talk Denalan##2080
|tip He walks around this area.
turnin Timberling Seeds##918 |goto 60.80,68.54
accept Rellian Greenspyre##922 |goto 60.80,68.54
turnin Timberling Sprouts##919 |goto 60.80,68.54
step
Kill enemies around this area
Reach Level 8 |ding 8 |goto 59.52,72.20
You can find more around [60.73,65.71]
stickystart "Kill_Gnarlpine_Mystics"
step
Follow the path up |goto 59.84,63.91 < 20 |only if walking
Follow the path |goto 63.43,54.14 < 30 |only if walking
kill Ferocitas the Dream Eater##7234
collect Gnarlpine Necklace##8049 |q 2459 |goto 69.37,53.40
step
use the Gnarlpine Necklace##8049
collect Tallonkai's Jewel##8050 |q 2459/2
step
label "Kill_Gnarlpine_Mystics"
kill 7 Gnarlpine Mystic##7235 |q 2459/1 |goto 68.96,52.95
step
Follow the road |goto 62.50,54.50 < 30 |only if walking
Enter the building |goto 55.75,57.23 < 10 |walk
talk Tallonkai Swiftroot##3567
|tip At the top of the tower.
turnin Ferocitas the Dream Eater##2459 |goto 55.57,56.95
step
Leave the building |goto 55.32,56.81 < 7 |walk
talk Moon Priestess Amara##2151
|tip She walks back and forth along this road from Dolanaar to Darnassus.
|tip You may need to search for her.
accept The Road to Darnassus##487 |goto 54.44,58.44
She walks between here and [49.51,53.18]
step
kill 6 Gnarlpine Ambusher##2152 |q 487/1 |goto 46.22,53.46
step
Enter the cave |goto 44.33,57.95 < 15 |walk
Follow the path down and cross the bridge |goto 43.61,60.19 < 7 |walk
click Chest of the Black Feather
|tip Inside the cave.
collect Black Feather Quill##3406 |q 483/2 |goto 43.70,61.22
step
Cross the bridge |goto 43.71,60.04 < 7 |walk
click Chest of Nesting
|tip Inside the cave.
collect Rune of Nesting##3408 |q 483/4 |goto 44.40,60.66
step
Follow the path down |goto 43.38,60.64 < 10 |walk
Continue down the path |goto 42.94,61.50 < 10 |walk
Cross the bridge |goto 44.11,61.61 < 10 |walk
talk Oben Rageclaw##7317
|tip Inside the cave.
accept The Sleeping Druid##2541 |goto 44.94,61.59
stickystart "Collect_Shaman_Voodoo_Charm"
step
Follow the path |goto 44.36,60.26 < 10 |walk
Continue following the path |goto 45.29,60.09 < 10 |walk
Run up the ramp |goto 45.40,58.87 < 10 |walk
Cross the bridge |goto 45.47,58.07 < 10 |walk
Follow the path |goto 46.21,58.22 < 10 |walk
click Chest of the Raven Claw
|tip Inside the cave.
collect Raven Claw Talisman##3405 |q 483/1 |goto 45.65,57.44
step
label "Collect_Shaman_Voodoo_Charm"
kill Gnarlpine Shaman##2009+
|tip Inside the cave.
collect Shaman Voodoo Charm##8363 |q 2541/1 |goto 45.56,58.96
step
Cross the bridge |goto 44.09,61.64 < 10 |walk
talk Oben Rageclaw##7317
|tip Inside the cave.
turnin The Sleeping Druid##2541 |goto 44.94,61.59
accept Druid of the Claw##2561 |goto 44.94,61.59
step
Follow the path |goto 44.36,60.26 < 10 |walk
Continue following the path |goto 45.29,60.09 < 10 |walk
kill Rageclaw##7318
|tip He looks like a night elf that walks around this area inside the cave.
use the Voodoo Charm##8149
|tip Use it on Rageclaw's corpse.
|tip His corpse will be where you killed him.
Release Oben Rageclaw's Spirit |q 2561/1 |goto 45.58,58.42
step
Follow the path |goto 45.59,59.16 < 10 |walk
Continue following the path |goto 44.34,60.30 < 10 |walk
Follow the path down |goto 44.33,61.67 < 10 |walk
click Chest of the Sky
|tip Inside the cave.
collect Sapphire of Sky##3407 |q 483/3 |goto 44.70,62.44
step
Follow the path up |goto 44.35,60.66 < 10 |c |q 2561
step
Cross the bridge |goto 44.06,61.63 < 10 |walk
talk Oben Rageclaw##7317
|tip Inside the cave.
turnin Druid of the Claw##2561 |goto 44.94,61.59
step
Kill enemies around this area
Reach Level 9 |ding 9 |goto 44.25,60.55
step
talk Athridas Bearmantle##2078
turnin The Relics of Wakening##483 |goto 55.95,57.27
accept Ursal the Mauler##486 |goto 55.95,57.27
step
Follow the path |goto 57.59,55.85 < 20 |only if walking
Enter the cave |goto 54.65,52.49 < 15 |walk
Follow the path |goto 53.79,50.64 < 10 |walk
Continue following the path |goto 53.17,49.16 < 10 |walk
kill Lord Melenas##2038
|tip Inside the cave.
collect Melenas' Head##5221 |q 932/1 |goto 52.81,50.20
step
Follow the path |goto 52.72,49.56 < 10 |walk
Continue following the path |goto 53.99,51.10 < 10 |walk
Leave the cave |goto 54.67,52.58 < 15 |walk
Follow the path |goto 57.46,55.62 < 20 |only if walking
Enter the building |goto 55.75,57.23 < 7 |walk
talk Tallonkai Swiftroot##3567
|tip At the top of the tower.
turnin Twisted Hatred##932 |goto 55.57,56.95
step
Leave the building |goto 55.32,56.81 < 7 |walk
talk Moon Priestess Amara##2151
|tip She walks back and forth along this road from Dolanaar to Darnassus.
|tip You may need to search for her.
turnin The Road to Darnassus##487 |goto 54.44,58.44
She walks between here and [49.51,53.18]
step
Follow the road |goto 46.94,49.51 < 30 |only if walking
Follow the path |goto 39.75,52.00 < 30 |only if walking
Continue following the path |goto 40.93,57.98 < 30 |only if walking
use the Tourmaline Phial##5621
collect Filled Tourmaline Phial##5645 |q 933/1 |goto 42.42,67.07
step
click Strange Fruited Plant
accept The Glowing Fruit##930 |goto 42.63,76.10
step
Follow the path down |goto 51.26,75.77 < 20 |only if walking
Follow the path |goto 53.24,70.88 < 30 |only if walking
talk Denalan##2080
|tip He walks around this area.
turnin The Glowing Fruit##930 |goto 60.90,68.49
step
Follow the path up |goto 57.49,63.92 < 20 |only if walking
talk Corithras Moonrage##3515
turnin Crown of the Earth##933 |goto 56.14,61.71
accept Crown of the Earth##7383 |goto 56.14,61.71
step
Follow the road |goto 54.30,58.41 < 30 |only if walking
Follow the path |goto 38.42,50.90 < 30 |only if walking
talk Sentinel Arynia Cloudsbreak##3519
accept The Enchanted Glade##937 |goto 38.31,34.36
step
use the Amethyst Phial##5623
collect Vial of Blessed Water##5646 |q 7383/1 |goto 38.43,34.04
step
Kill Bloodfeather enemies around this area
collect 6 Bloodfeather Belt##5204 |q 937/1 |goto 36.25,38.54
You can find more around [34.55,34.99]
step
Kill enemies around this area
Reach Level 10 |ding 10 |goto 36.25,38.54
You can find more around [34.55,34.99]
step
click Strange Fronded Plant
accept The Shimmering Frond##931 |goto 34.60,28.85
step
talk Sentinel Arynia Cloudsbreak##3519
turnin The Enchanted Glade##937 |goto 38.31,34.36
accept Teldrassil##940 |goto 38.31,34.36
step
Follow the path |goto 37.62,36.84 < 30 |only if walking
Follow the road |goto 39.20,53.00 < 30 |only if walking
Follow the path |goto 54.13,58.27 < 30 |only if walking
talk Corithras Moonrage##3515
turnin Crown of the Earth##7383 |goto 56.14,61.71
accept Crown of the Earth##935 |goto 56.14,61.71
step
Enter the building |goto Teldrassil 55.76,57.24 < 7 |walk
talk Laurna Morninglight##3600
|tip Inside the building.
accept Returning Home##5629 |goto Teldrassil 55.57,56.75
|only if NightElf Priest
step
Leave the building |goto 55.76,57.24 < 7 |c |q 486
|only if NightElf Priest
step
talk Dazalar##3601
accept Taming the Beast##6063 |goto 56.68,59.49
|only if NightElf Hunter
step
use the Taming Rod##15921
|tip Use it on a Webwood Lurker around this area.
Tame a Webwood Lurker |q 6063/1 |goto 59.81,59.06
|only if NightElf Hunter
step
talk Dazalar##3601
turnin Taming the Beast##6063 |goto 56.68,59.49
accept Taming the Beast##6101 |goto 56.68,59.49
|only if NightElf Hunter
step
use the Taming Rod##15922
|tip Use it on a Nightsaber Stalker around this area.
Tame a Nightsaber Stalker |q 6101/1 |goto 55.95,71.98
|only if NightElf Hunter
step
talk Dazalar##3601
turnin Taming the Beast##6101 |goto 56.68,59.49
accept Taming the Beast##6102 |goto 56.68,59.49
|only if NightElf Hunter
step
Follow the road |goto 54.81,58.48 < 30 |only if walking
use the Taming Rod##15923
|tip Use it on a Strigid Screecher around this area.
Tame a Strigid Screecher |q 6102/1 |goto 43.99,51.16
|only if NightElf Hunter
step
Follow the road |goto 45.10,49.62 < 30 |only if walking
talk Dazalar##3601
turnin Taming the Beast##6102 |goto 56.68,59.49
accept Training the Beast##6103 |goto 56.68,59.49
|only if NightElf Hunter
step
Follow the road |goto 54.81,58.48 < 30 |only if walking
Enter Darnassus |goto 36.06,54.39 < 20 |only if walking
Run up the ramp |goto Darnassus 45.70,17.69 < 15 |only if walking
talk Jocaste##4146
|tip Inside the building.
turnin Training the Beast##6103 |goto Darnassus 40.38,8.56
|only if NightElf Hunter
step
Leave Darnassus |goto 86.51,35.77 < 20 |only if walking
Follow the road |goto Teldrassil 38.18,54.48 < 30 |only if walking
Continue following the road |goto Teldrassil 46.98,49.50 < 30 |only if walking
Continue following the road |goto Teldrassil 50.63,56.17 < 30 |c |q 486
|only if NightElf Hunter
step
talk Kal##3602
accept Heeding the Call##5923 |goto Teldrassil 55.95,61.56
|only if NightElf Druid
step
Follow the road |goto 54.81,58.48 < 30 |only if walking
Enter Darnassus |goto 36.06,54.39 < 20 |only if walking
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
Follow the path |goto 42.47,34.44 < 20 |only if walking
talk Great Bear Spirit##11956
Ask it _"What do you represent, spirit?"_
Seek Out the Great Bear Spirit and Learn what it Has to Share with You About the Nature of the Bear |q 5929/1 |goto 39.11,27.51
|only if NightElf Druid
step
Enter the building |goto 56.13,30.98 < 15 |walk
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Great Bear Spirit##5929 |goto 56.21,30.64
accept Back to Darnassus##5931 |goto 56.21,30.64
|only if NightElf Druid
step
talk Sindrayl##10897
fpath Moonglade |goto 48.10,67.34
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
Face Lunaclaw and Earn the Strength of Body and Heart it Possesses |q 6001/1 |goto Darkshore 43.48,45.96
|only if NightElf Druid
step
Leave the cave |goto 42.97,45.44 < 15 |walk
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Body and Heart##6001 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
Leave the building |goto 34.60,6.55 < 7 |walk
Leave Darnassus |goto 86.51,35.77 < 20 |only if walking
Follow the road |goto Teldrassil 38.18,54.48 < 30 |only if walking
Continue following the road |goto Teldrassil 46.98,49.50 < 30 |only if walking
Continue following the road |goto Teldrassil 50.63,56.17 < 30 |c |q 486
|only if NightElf Druid
step
Follow the path |goto 54.12,60.55 < 30 |only if walking
Follow the path up |goto 50.79,66.44 < 30 |only if walking
Follow the path |goto 41.97,76.27 < 30 |only if walking
Continue following the path |goto 40.57,79.75 < 30 |only if walking
kill Ursal the Mauler##2039 |q 486/1 |goto 38.83,79.80
step
Follow the path |goto 57.12,63.24 < 20 |only if walking
talk Denalan##2080
|tip He walks around this area.
turnin The Shimmering Frond##931 |goto 60.90,68.48
step
Follow the path up |goto 57.55,63.93 < 20 |only if walking
talk Athridas Bearmantle##2078
turnin Ursal the Mauler##486 |goto 55.95,57.28
step
Follow the road |goto 54.81,58.48 < 30 |only if walking
Enter Darnassus |goto 36.06,54.39 < 20 |c |q 922
step
talk Mydrannul##4241
accept Nessa Shadowsong##6344 |goto Darnassus 70.68,45.38
|only if NightElf
step
talk Rellian Greenspyre##3517
turnin Rellian Greenspyre##922 |goto 38.19,21.63
step
Enter the building |goto 35.46,10.59 < 7 |walk
talk Arch Druid Fandral Staghelm##3516
|tip At the top of the tower.
turnin Crown of the Earth##935 |goto 34.80,9.24
turnin Teldrassil##940 |goto 34.80,9.24
step
Leave the building |goto 33.91,7.76 < 7 |c |q 6344
step
Enter the building |goto 39.02,76.78 < 10 |walk
talk Priestess Alathea##11401
|tip Upstairs inside the building.
turnin Returning Home##5629 |goto 39.53,81.18
|only if NightElf Priest
step
Leave the building |goto 39.02,76.78 < 10 |c |q 6344
|only if NightElf Priest
step
talk Nessa Shadowsong##10118
turnin Nessa Shadowsong##6344 |goto Teldrassil 56.25,92.43
accept The Bounty of Teldrassil##6341 |goto Teldrassil 56.25,92.43
|only if NightElf
step
Follow the path |goto 56.81,92.64 < 15 |only if walking
talk Vesprystus##3838
turnin The Bounty of Teldrassil##6341 |goto 58.40,94.01
accept Flight to Auberdine##6342 |goto 58.40,94.01
|only if NightElf
step
Enter the building |goto Darkshore 36.77,44.70 < 15 |walk
talk Laird##4200
|tip Inside the building.
turnin Flight to Auberdine##6342 |goto Darkshore 36.77,44.29
accept Return to Nessa##6343 |goto Darkshore 36.77,44.29
|only if NightElf
step
talk Nessa Shadowsong##10118
turnin Return to Nessa##6343 |goto Teldrassil 56.25,92.43
|only if NightElf
step
Kill enemies around this area
Reach Level 11 |ding 11 |goto Darkshore 36.04,47.43
step
talk Gwennyth Bly'Leggonde##10219
accept Washed Ashore##3524 |goto 36.62,45.59
step
Enter the building |goto Darkshore 36.77,44.70 < 15 |walk
talk Wizbang Cranktoggle##3666
|tip Upstairs inside the building.
accept Buzzbox 827##983 |goto Darkshore 36.98,44.14
step
talk Innkeeper Shaussiy##6737
|tip Inside the building.
home Auberdine |goto 37.04,44.12
step
Enter the building |goto 38.97,43.56 < 15 |walk
talk Terenthis##3693
|tip Inside the building.
accept How Big a Threat?##984 |goto 39.37,43.48
step
Enter the building |goto 37.77,41.36 < 15 walk
talk Thundris Windweaver##3649
|tip Inside the building.
accept Bashal'Aran##954 |goto 37.39,40.13
step
Leave the building |goto 37.77,41.34 < 15 |walk
kill Pygmy Tide Crawler##2231+
collect 6 Crawler Leg##5385 |q 983/1 |goto 36.12,48.70
step
click Beached Sea Creature
collect Sea Creature Bones##12242 |q 3524/1 |goto 36.39,50.88
step
click Buzzbox 827
turnin Buzzbox 827##983 |goto 36.66,46.26
accept Buzzbox 411##1001 |goto 36.66,46.26
step
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##3524 |goto 36.62,45.59
accept Washed Ashore##4681 |goto 36.62,45.59
step
kill Darkshore Thresher##2185
|tip Underwater around this area.
collect 3 Thresher Eye##5412 |q 1001/1 |goto 31.60,39.75
You can find more around: |notinsticky
[35.39,37.08]
step
click Skeletal Sea Turtle
|tip Underwater.
collect Sea Turtle Remains##12289 |q 4681/1 |goto 31.87,46.32
step
Find a Corrupt Furbolg Camp |q 984/1 |goto 39.26,53.12
step
Enter the building |goto 38.96,43.56 < 15 |walk
talk Terenthis##3693
|tip Inside the building.
turnin How Big a Threat?##984 |goto 39.37,43.48
accept Thundris Windweaver##4761 |goto 39.37,43.48
step
talk Thundris Windweaver##3649
|tip Inside the building.
turnin Thundris Windweaver##4761 |goto 37.39,40.13
step
Leave the building |goto 37.76,41.34 < 15 |walk
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##4681 |goto 36.62,45.59
step
Follow the road |goto 40.30,46.37 < 20 |only if walking
Follow the path |goto 42.90,36.58 < 30 |only if walking
Follow the path up |goto 44.25,36.82 < 15 |only if walking
Find the Source of the Strange Blue Aura in the Ruins of Bashal'Aran |q 954/1 |goto 44.17,36.29
step
talk Asterion##3650
turnin Bashal'Aran##954 |goto 44.17,36.29
accept Bashal'Aran##955 |goto 44.17,36.29
step
Kill enemies around this area
|tip Only Vile Sprites and Wild Grells will drop the quest item.
collect 8 Grell Earring##5336 |goto 45.13,38.46
You can find more around [47.72,37.13]
step
Kill enemies around this area
Reach Level 12 |ding 12 |goto 45.13,38.46
You can find more around [47.72,37.13]
step
talk Asterion##3650
turnin Bashal'Aran##955 |goto 44.17,36.29
step
click Buzzbox 411
turnin Buzzbox 411##1001 |goto 41.96,28.64
step
talk Shellei Brondir##1571
fpath Menethil Harbor |goto Wetlands 9.49,59.69
step
Cross the bridge |goto 10.97,54.47 < 20 |only if walking
Follow the road |goto 15.29,45.35 < 30 |only if walking
Continue following the road |goto 50.67,39.99 < 30 |only if walking
Enter the tunnel |goto 53.86,70.33 < 15 |only if walking
Leave the tunnel |goto 49.29,70.57 < 15 |only if walking
Follow the path up |goto 48.30,67.28 < 15 |c |q 1338
step
Enter the tunnel |goto 50.14,71.56 < 15 |only if walking
Leave the tunnel |goto 50.17,78.37 < 15 |only if walking
Enter the tunnel |goto 50.64,82.58 < 15 |only if walking
Leave the tunnel |goto 55.15,83.54 < 15 |only if walking
Enter the tunnel |goto Loch Modan 25.28,0.08 < 15 |only if walking
Leave the tunnel |goto Loch Modan 25.57,10.27 < 15 |only if walking
Enter the building |goto Loch Modan 23.53,17.89 < 10 |walk
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
accept Stormpike's Order##1338 |goto Loch Modan 24.76,18.39
step
Leave the building |goto 23.53,17.89 < 10 |walk
Follow the road |goto 27.12,23.74 < 30 |only if walking
talk Thorgrum Borrelson##1572
fpath Thelsamar |goto 33.94,50.95
step
talk Mountaineer Kadrell##1340
|tip He walks around this area.
accept Rat Catching##416 |goto 34.50,47.32
step
Enter the building |goto 35.23,47.75 < 10 |walk
talk Innkeeper Hearthstove##6734
|tip Inside the building.
home Stoutlager Inn |goto 35.53,48.40
step
talk Vidra Hearthstove##1963
|tip Inside the building.
accept Thelsamar Blood Sausages##418 |goto 34.83,49.28
stickystart "Collect_Spider_Ichors"
stickystart "Collect_Bear_Meat"
step
Leave the building |goto 35.21,47.76 < 10 |walk
kill Mountain Boar##1190+
collect 3 Boar Intestines##3172 |goto 36.99,34.36
You can find more around [29.17,23.57]
step
label "Collect_Spider_Ichors"
kill Forest Lurker##1195+
collect 3 Spider Ichor##3174 |goto 35.69,31.78
You can find more around: |notinsticky
[29.17,23.57]
[29.43,48.28]
stickystart "Collect_Tunnel_Rat_Ears"
step
label "Collect_Bear_Meat"
kill Elder Black Bear##1186+
collect 3 Bear Meat##3173 |goto 35.68,32.10
You can find more around: |notinsticky
[30.73,25.86]
[28.66,11.57]
[24.03,25.79]
[27.45,28.54]
[28.09,40.94]
step
label "Collect_Tunnel_Rat_Ears"
Kill Tunnel Rat enemies around this area
collect 12 Tunnel Rat Ear##3110 |goto 24.57,29.79
You can find more around [26.08,43.64]
step
Enter the building |goto 23.53,17.90 < 15 |walk
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
accept Filthy Paws##307 |goto 24.76,18.40
step
Leave the building |goto 23.53,17.90 < 10 |walk
Enter the mine |goto 35.48,18.83 < 15 |walk
click Miners' League Crates+
|tip They look like piles of brown boxes on the ground around this area inside the mine.
collect 4 Miners' Gear##2640 |q 307/1 |goto 35.75,22.42
step
Leave the mine |goto 35.46,18.72 < 15 |walk
Enter the building |goto 23.50,17.89 < 15 |walk
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Filthy Paws##307 |goto 24.76,18.40
step
talk Vidra Hearthstove##1963
|tip Inside the building.
turnin Thelsamar Blood Sausages##418 |goto 34.83,49.29
step
Leave the building |goto 35.22,47.75 < 10 |walk
talk Mountaineer Kadrell##1340
|tip He walks around this area.
turnin Rat Catching##416 |goto 34.61,47.09
step
Kill enemies around this area
Reach Level 13 |ding 13 |goto 26.08,43.64
You can find more around [24.57,29.79]
step
Follow the road |goto 29.36,60.49 < 30 |only if walking
Follow the path up |goto 22.50,70.24 < 20 |only if walking
Enter the tunnel |goto 19.55,62.70 < 15 |only if walking
Leave the tunnel |goto Dun Morogh 86.24,51.32 < 15 |only if walking
Enter the tunnel |goto Dun Morogh 84.21,51.33 < 15 |only if walking
Leave the tunnel |goto Dun Morogh 82.26,53.44 < 15 |only if walking
Follow the road |goto Dun Morogh 77.86,49.71 < 30 |only if walking
Follow the path up |goto Dun Morogh 47.19,41.72 < 20 |only if walking
Enter Ironforge |goto Ironforge 15.23,85.56 < 20 |walk
talk Gryth Thurden##1573
fpath Ironforge |goto Ironforge 55.53,47.77
step
Follow the path |goto 72.81,50.26 < 15 |walk
Enter the Deeprun Tram |goto 77.02,51.26 > 2000 |c |q 1338
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip On the middle platform, near the wall.
|tip In the Ironforge section of the Deeprun Tram.
accept Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
use Rat Catcher's Flute##17117
|tip Use it on Deeprun Rats around this area.
|tip They look like small grey rats on the ground around this area.
|tip In the Ironforge section of the Deeprun Tram.
Capture #5# Rats |q 6661/1
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip On the middle platform, near the wall.
|tip In the Ironforge section of the Deeprun Tram.
turnin Deeprun Rat Roundup##6661
accept Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the Deeprun Tram from Ironforge to Stormwind City.
Click Here After Riding the Tram |confirm |q 6662
step
_Inside Deeprun Tram:_
talk Nipsy##13018
|tip On the middle platform, near the wall.
|tip In the Stormwind City section of the Deeprun Tram.
turnin Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Enter Stormwind City |goto Stormwind City 62.94,9.36 < 2000 |noway |c |q 1338
step
talk Furen Longbeard##5413
turnin Stormpike's Order##1338 |goto Stormwind City 58.09,16.52
step
Run up the ramp |goto 62.39,62.31 < 15 |only if walking
talk Dungar Longdrink##352
|tip Inside the building.
fpath Stormwind City |goto 66.27,62.14
step
Run up the ramp |goto 72.07,80.61 < 20 |only if walking
Follow the road |goto 69.76,85.39 < 20 |only if walking
talk Marshal Dughan##240
accept Report to Gryan Stoutmantle##109 |goto Elwynn Forest 42.11,65.93
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Dwarf & Gnome (1-13)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Dun Morogh",
condition_suggested=function() return (raceclass('Dwarf') or raceclass('Gnome')) and level <= 13 end,
condition_suggested_exclusive=true,
next="Leveling Guides\\Leveling (13-20)",
startlevel=1,
endlevel=13
},[[
step
talk Sten Stoutarm##658
accept Dwarven Outfitters##179 |goto Dun Morogh 29.93,71.20
step
Kill Wolf enemies around this area
collect 8 Tough Wolf Meat##750 |q 179/1 |goto 30.14,74.59
You can find more around [26.93,75.75]
step
Kill enemies around this area
Reach Level 2 |ding 2 |goto 30.14,74.59
You can find more around [26.93,75.75]
step
talk Sten Stoutarm##658
turnin Dwarven Outfitters##179 |goto 29.93,71.20
accept Simple Rune##3106 |goto 29.93,71.20 |only Dwarf Warrior
accept Encrypted Rune##3109 |goto 29.93,71.20 |only Dwarf Rogue
accept Hallowed Rune##3110 |goto 29.93,71.20 |only Dwarf Priest
accept Consecrated Rune##3107 |goto 29.93,71.20 |only Dwarf Paladin
accept Etched Rune##3108 |goto 29.93,71.20 |only Dwarf Hunter
accept Glyphic Memorandum##3114 |goto 29.93,71.20 |only Gnome Mage
accept Simple Memorandum##3112 |goto 29.93,71.20 |only Gnome Warrior
accept Tainted Memorandum##3115 |goto 29.93,71.20 |only Gnome Warlock
accept Encrypted Memorandum##3113 |goto 29.93,71.20 |only Gnome Rogue
accept Coldridge Valley Mail Delivery##233 |goto 29.93,71.20
step
talk Balir Frosthammer##713
accept A New Threat##170 |goto 29.71,71.25
stickystart "Kill_Burly_Rockjaw_Troggs"
step
kill 6 Rockjaw Trogg##707 |q 170/1 |goto 30.65,74.94
step
label "Kill_Burly_Rockjaw_Troggs"
kill 6 Burly Rockjaw Trogg##724 |q 170/2 |goto 30.65,74.94
step
Kill enemies around this area
Reach Level 3 |ding 3 |goto 30.65,74.94
step
talk Balir Frosthammer##713
turnin A New Threat##170 |goto 29.71,71.25
step
Enter the building |goto 28.79,69.05 < 15 |walk
talk Felix Whindlebolt##8416
|tip He walks around this area inside the building.
accept A Refugee's Quandary##3361 |goto 28.51,67.67
step
talk Thran Khorman##912
|tip Inside the building.
turnin Simple Rune##3106 |goto 28.83,67.24
|only if Dwarf Warrior
step
talk Solm Hargrin##916
|tip Inside the building.
turnin Encrypted Rune##3109 |goto 28.37,67.51
|only if Dwarf Rogue
step
talk Branstock Khalder##837
|tip Inside the building.
turnin Hallowed Rune##3110 |goto 28.60,66.39
|only if Dwarf Priest
step
talk Bromos Grummner##926
|tip Inside the building.
turnin Consecrated Rune##3107 |goto 28.83,68.33
|only if Dwarf Paladin
step
talk Thorgas Grimson##895
|tip Inside the building.
turnin Etched Rune##3108 |goto 29.18,67.46
|only if Dwarf Hunter
step
talk Thran Khorman##912
|tip Inside the building.
turnin Simple Memorandum##3112 |goto 28.83,67.24
|only if Gnome Warrior
step
talk Solm Hargrin##916
|tip Inside the building.
turnin Encrypted Memorandum##3113 |goto 28.37,67.51
|only if Gnome Rogue
step
talk Marryk Nurribit##944
|tip Inside the building.
turnin Glyphic Memorandum##3114 |goto 28.71,66.36
|only if Gnome Mage
step
talk Alamar Grimm##460
|tip Upstairs inside the building.
turnin Tainted Memorandum##3115 |goto 28.65,66.14
accept Beginnings##1599 |goto 28.65,66.14
|only if Gnome Warlock
step
Leave the building |goto 28.79,69.07 < 15 |walk
talk Talin Keeneye##714
turnin Coldridge Valley Mail Delivery##233 |goto 22.60,71.43
accept Coldridge Valley Mail Delivery##234 |goto 22.60,71.43
accept The Boar Hunter##183 |goto 22.60,71.43
step
kill 12 Small Crag Boar##708 |q 183/1 |goto 21.52,71.91
step
Kill enemies around this area
Reach Level 4 |ding 4 |goto 21.52,71.91
step
talk Talin Keeneye##714
turnin The Boar Hunter##183 |goto 22.60,71.43
step
talk Grelin Whitebeard##786
turnin Coldridge Valley Mail Delivery##234 |goto 25.08,75.71
step
Enter the cave |goto 26.80,79.86 < 15 |walk
Follow the path |goto 28.00,81.05 < 10 |walk
kill Frostmane Novice##946+
|tip Inside the cave.
|tip There's only a few of them.
collect 3 Feather Charm##6753 |q 1599/1 |goto 28.73,82.58
You can find more around: |notinsticky
[29.34,81.50]
[30.15,82.34]
[30.49,81.05]
|only if Gnome Warlock
step
Leave the cave |goto 26.80,79.86 < 15 |c |q 1599
|only if Gnome Warlock
step
talk Nori Pridedrift##12738
accept Scalding Mornbrew Delivery##3364 |goto 24.98,75.96
step
Enter the building |goto 28.79,69.05 < 15 |walk
talk Durnan Furcutter##836
|tip Inside the building.
turnin Scalding Mornbrew Delivery##3364 |goto 28.77,66.37
accept Bring Back the Mug##3365 |goto 28.77,66.37
step
talk Alamar Grimm##460
|tip Upstairs inside the building.
turnin Beginnings##1599 |goto 28.65,66.14
|only if Gnome Warlock
step
Leave the building |goto 28.79,69.07 < 15 |walk
talk Nori Pridedrift##12738
turnin Bring Back the Mug##3365 |goto 24.98,75.96
step
talk Grelin Whitebeard##786
accept The Troll Cave##182 |goto 25.08,75.71
stickystart "Kill_Frostmane_Troll_Whelps"
step
click Felix's Box
collect Felix's Box##10438 |q 3361/1 |goto 20.88,76.07
step
click Felix's Chest
collect Felix's Chest##16313 |q 3361/2 |goto 22.78,80.00
step
click Felix's Bucket of Bolts
collect Felix's Bucket of Bolts##16314 |q 3361/3 |goto 26.33,79.27
step
label "Kill_Frostmane_Troll_Whelps"
kill 14 Frostmane Troll Whelp##706 |q 182/1 |goto 26.76,79.73
|tip Inside and outside the cave.
You can find more outside the cave around:
[22.78,79.72]
[21.02,76.15]
step
Kill enemies around this area
|tip Inside and outside the cave.
Reach Level 5 |ding 5 |goto 26.76,79.73
You can find more outside the cave around:
[22.78,79.72]
[21.02,76.15]
step
talk Grelin Whitebeard##786
turnin The Troll Cave##182 |goto 25.08,75.71
accept The Stolen Journal##218 |goto 25.08,75.71
step
Enter the cave |goto 26.80,79.86 < 15 |walk
Follow the path |goto 27.73,80.71 < 10 |walk
Follow the path down |goto 28.13,80.11 < 10 |walk
Continue down the path |goto 29.06,78.87 < 10 |walk
kill Grik'nir the Cold##808
|tip Inside the cave.
collect Grelin Whitebeard's Journal##2004 |q 218/1 |goto 30.49,80.16
step
Follow the path up |goto 30.09,79.31 < 10 |walk
Continue up the path |goto 28.40,79.66 < 10 |walk
Follow the path |goto 27.62,80.85 < 10 |walk
Leave the cave |goto 26.75,79.69 < 10 |walk
talk Grelin Whitebeard##786
turnin The Stolen Journal##218 |goto 25.08,75.71
accept Senir's Observations##282 |goto 25.08,75.71
step
Enter the building |goto 28.79,69.05 < 15 |walk
talk Felix Whindlebolt##8416
|tip He walks around this area inside the building.
turnin A Refugee's Quandary##3361 |goto 28.55,67.65
step
Leave the building |goto 28.79,69.05 < 15 |walk
Follow the road up |goto 31.71,72.61 < 20 |only if walking
talk Mountaineer Thalos##1965
turnin Senir's Observations##282 |goto 33.48,71.84
accept Senir's Observations##420 |goto 33.48,71.84
step
talk Hands Springsprocket##6782
accept Supplies to Tannok##2160 |goto 33.85,72.24
step
Enter the tunnel |goto 34.12,71.51 < 15 |only if walking
Leave the tunnel |goto 35.67,65.93 < 15 |c |q 420
step
Kill enemies around this area
Reach Level 6 |ding 6 |goto 35.71,59.82
step
Follow the road |goto 36.64,62.05 < 30 |only if walking
talk Senir Whitebeard##1252
turnin Senir's Observations##420 |goto 46.73,53.83
step
talk Ragnar Thunderbrew##1267
accept Beer Basted Boar Ribs##384 |goto 46.83,52.36
step
Enter the building |goto 46.95,52.04 < 10 |walk
talk Tannok Frosthammer##6806
|tip Inside the building.
turnin Supplies to Tannok##2160 |goto 47.22,52.19
step
talk Innkeeper Belm##1247
|tip Inside the building.
buy Rhapsody Malt##2894 |q 384/2 |goto 47.38,52.52
step
talk Innkeeper Belm##1247
|tip Inside the building.
home Thunderbrew Distillery |goto 47.38,52.52
step
Leave the building |goto 46.95,52.03 < 10 |walk
talk Tharek Blackstone##1872
accept Tools for Steelgrill##400 |goto 46.02,51.68
step
talk Pilot Bellowfiz##1378
accept Stocking Jetsteam##317 |goto 49.43,48.41
step
talk Pilot Stonegear##1377
accept The Grizzled Den##313 |goto 49.62,48.61
step
talk Beldin Steelgrill##1376
turnin Tools for Steelgrill##400 |goto 50.44,49.09
step
talk Loslor Rudge##1694
accept Ammo for Rumbleshot##5541 |goto 50.08,49.42
stickystart "Collect_Crag_Boar_Ribs"
stickystart "Collect_Thick_Bear_Fur"
step
Kill Crag Boar enemies around this area
collect 4 Chunk of Boar Meat##769 |q 317/1 |goto 48.33,48.12
You can find more around: |notinsticky
[50.28,51.52]
[48.34,55.70]
[48.37,60.48]
[44.55,65.31]
[42.18,65.32]
step
label "Collect_Crag_Boar_Ribs"
Kill Crag Boar enemies around this area
collect 6 Crag Boar Rib##2886 |q 384/1 |goto 48.33,48.12
You can find more around: |notinsticky
[50.28,51.52]
[48.34,55.70]
[48.37,60.48]
[44.55,65.31]
[42.18,65.32]
step
label "Collect_Thick_Bear_Fur"
kill Young Black Bear+
collect 2 Thick Bear Fur##6952 |q 317/2 |goto 49.76,51.15
You can find more around: |notinsticky
[45.18,50.18]
[44.96,56.85]
[42.54,59.61]
[39.44,61.23]
step
click Ammo Crate
collect Rumbleshot's Ammo##13850 |q 5541/1 |goto 44.14,56.94
step
Kill Wendigo enemies around this area
|tip Inside and outside the cave.
|tip They respawn quickly, so you'll be better staying close to the cave entrance.
collect 8 Wendigo Mane##2671 |q 313/1 |goto 42.33,54.03
step
Kill enemies around this area
|tip Inside and outside the cave.
Reach Level 7 |ding 7 |goto 42.33,54.03
step
Follow the path up |goto 40.60,62.56 < 20 |only if walking
talk Hegnar Rumbleshot##1243
turnin Ammo for Rumbleshot##5541 |goto 40.68,65.13
step
Follow the road |goto 43.75,64.46 < 30 |only if walking
talk Senir Whitebeard##1252
accept Frostmane Hold##287 |goto 46.73,53.83
step
talk Ragnar Thunderbrew##1267
turnin Beer Basted Boar Ribs##384 |goto 46.83,52.36
step
talk Pilot Bellowfiz##1378
turnin Stocking Jetsteam##317 |goto 49.43,48.41
accept Evershine##318 |goto 49.43,48.41
step
talk Pilot Stonegear##1377
turnin The Grizzled Den##313 |goto 49.62,48.61
step
Enter the building |goto 45.97,48.83 < 10 |walk
talk Razzle Sprysprocket##1269
|tip Inside the building.
accept Operation Recombobulation##412 |goto 45.85,49.37
step
Leave the building |goto 45.97,48.83 < 7 |walk
Follow the path |goto 41.85,47.18 < 30 |only if walking
Follow the path |goto 39.43,48.50 < 20 |only if walking
Follow the path up |goto 35.99,51.92 < 15 |only if walking
talk Tundra MacGrann##1266
|tip On top of the mountain.
|tip As you travel to him, be careful to avoid the elite yeti that walks around this area.
accept Tundra MacGrann's Stolen Stash##312 |goto 34.57,51.65
step
Enter the cave |goto 37.80,53.69 < 15 |walk
click MacGrann's Meat Locker
|tip Inside the cave.
|tip Wait for the elite yeti to leave the cave and walk away before you enter the cave.
collect MacGrann's Dried Meats##2667 |q 312/1 |goto 38.51,53.93
|tip He runs back quickly after he walks down the path a bit.
|tip Try to get into the cave as quick as you can when he leaves it, to give yourself time to run back out safely.
|tip If he attacks you as you leave the cave, just run away.
step
Follow the path up |goto 35.99,51.92 < 15 |only if walking
talk Tundra MacGrann##1266
|tip On top of the mountain.
|tip As you travel to him, be careful to avoid the elite yeti that walks around this area.
turnin Tundra MacGrann's Stolen Stash##312 |goto 34.57,51.65
step
Kill enemies around this area
Reach Level 8 |ding 8 |goto 32.19,49.19
You can find more around [27.99,48.31]
step
talk Rejold Barleybrew##1374
turnin Evershine##318 |goto 30.19,45.73
accept A Favor for Evershine##319 |goto 30.19,45.73
accept The Perfect Stout##315 |goto 30.19,45.73
step
talk Marleth Barleybrew##1375
accept Bitter Rivals##310 |goto 30.19,45.53
step
talk Innkeeper Belm##1247
|tip Inside the building.
buy Thunder Ale##2686 |goto 47.38,52.52 |q 310
step
talk Jarven Thunderbrew##1373
|tip Downstairs inside the building.
accept Distracting Jarven##308 |goto 47.64,52.66
step
click Unguarded Thunder Ale Barrel
|tip Downstairs inside the building.
|tip It may take a moment for it to become Unguarded.
turnin Bitter Rivals##310 |goto 47.70,52.69
accept Return to Marleth##311 |goto 47.70,52.69
step
Leave the building |goto 46.95,52.08 < 10 |walk
Follow the path |goto 42.70,47.20 < 30 |only if walking
Continue following the path |goto 37.36,44.05 < 30 |only if walking
Follow the path up |goto 38.44,42.11 < 20 |only if walking
kill Frostmane Seer##1397+
click Shimmerweed Basket+
|tip They look like tan wooden baskets on the ground around this area.
collect 6 Shimmerweed##2676 |q 315/1 |goto 40.09,42.44
You can find more around [41.81,35.62]
stickystart "Kill_Elder_Crag_Boars"
stickystart "Kill_Snow_Leopards"
step
kill 6 Ice Claw Bear##1196 |q 319/1 |goto 34.50,31.74
You can find more around: |notinsticky
[30.71,39.90]
[27.80,48.14]
[28.11,53.97]
step
label "Kill_Elder_Crag_Boars"
kill 8 Elder Crag Boar##1127 |q 319/2 |goto 34.50,31.74
You can find more around: |notinsticky
[30.71,39.90]
[27.80,48.14]
[28.11,53.97]
step
label "Kill_Snow_Leopards"
kill 8 Snow Leopard##1201 |q 319/3 |goto 34.50,31.74
You can find more around: |notinsticky
[30.71,39.90]
[27.80,48.14]
[28.11,53.97]
step
talk Marleth Barleybrew##1375
turnin Return to Marleth##311 |goto 30.19,45.53
step
talk Rejold Barleybrew##1374
turnin A Favor for Evershine##319 |goto 30.19,45.73
accept Return to Bellowfiz##320 |goto 30.19,45.73
turnin The Perfect Stout##315 |goto 30.19,45.73
accept Shimmer Stout##413 |goto 30.19,45.73
step
Kill enemies around this area
Reach Level 9 |ding 9 |goto 26.36,47.69
You can find more around: |notinsticky
[29.93,42.60]
stickystart "Kill_Frostmane_Headhunters"
step
Enter the cave |goto 24.84,50.89 < 15 |walk
Follow the path  down |goto 22.61,50.53 < 15 |walk
Fully Explore Frostmane Hold |q 287/2 |goto 22.79,52.10
|tip Inside the cave.
step
label "Kill_Frostmane_Headhunters"
kill 5 Frostmane Headhunter##1123 |q 287/1 |goto 24.87,50.90
|tip Inside and outside the cave.
stickystart "Collect_Gyromechanic_Gears"
step
Follow the path up |goto 21.78,50.47 < 15 |walk
Leave the cave |goto 25.07,50.99 < 15 |walk
kill Leper Gnome##1211+
collect 8 Restabilization Cog##3083 |q 412/1 |goto 25.64,43.33
step
label "Collect_Gyromechanic_Gears"
kill Leper Gnome##1211+
collect 8 Gyromechanic Gear##3084 |q 412/2 |goto 25.64,43.33
step
Leave the building |goto 46.95,52.05 < 10 |walk
talk Senir Whitebeard##1252
turnin Frostmane Hold##287 |goto 46.73,53.82
accept The Reports##291 |goto 46.73,53.82
step
Enter the building |goto 45.97,48.84 < 10 |walk
talk Razzle Sprysprocket##1269
|tip Inside the building.
turnin Operation Recombobulation##412 |goto 45.85,49.37
step
Leave the building |goto 45.97,48.85 < 7 |walk
talk Pilot Bellowfiz##1378
turnin Return to Bellowfiz##320 |goto 49.43,48.41
step
Kill enemies around this area
Reach Level 10 |ding 10 |goto 44.39,46.27
step
talk Grif Wildheart##1231
accept Taming the Beast##6064 |goto Dun Morogh 45.81,53.03
|only if Dwarf Hunter
step
use the Taming Rod##15911
|tip Use it on a Large Crag Boar around this area.
Tame a Large Crag Boar |q 6064/1 |goto 48.26,56.81
|only if Dwarf Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6064 |goto 45.81,53.04
accept Taming the Beast##6084 |goto 45.81,53.04
|only if Dwarf Hunter
step
use the Taming Rod##15913
|tip Use it on a Snow Leopard around this area.
Tame a Snow Leopard |q 6084/1 |goto 48.68,58.93
|only if Dwarf Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6084 |goto 45.81,53.04
accept Taming the Beast##6085 |goto 45.81,53.04
|only if Dwarf Hunter
step
use the Taming Rod##15908
|tip Use it on an Ice Claw Bear around this area.
Tame an Ice Claw Bear |q 6085/1 |goto 49.06,62.12
|only if Dwarf Hunter
step
talk Grif Wildheart##1231
turnin Taming the Beast##6085 |goto 45.81,53.04
accept Training the Beast##6086 |goto 45.81,53.04
|only if Dwarf Hunter
step
Follow the path up |goto 47.25,41.65 < 20 |only if walking
Enter Ironforge |goto 53.47,34.90 < 20 |walk
Enter the building |goto Ironforge 66.34,82.50 < 15 |walk
talk Belia Thundergranite##10090
|tip Inside the building.
turnin Training the Beast##6086 |goto Ironforge 70.87,85.80
|only if Dwarf Hunter
step
Leave the building |goto 66.30,82.35 < 15 |walk
Follow the path |goto 30.96,80.43 < 20 |only if walking
Leave Ironforge |goto 15.03,85.95 < 20 |c |q 419 |future
|only if Dwarf Hunter
step
Enter the building |goto 46.96,52.08 < 10 |walk
talk Granis Swiftaxe##1229
|tip Inside the building.
accept Muren Stormpike##1679 |goto Dun Morogh 47.36,52.65
|only if (Dwarf Warrior) or (Gnome Warrior)
step
Leave the building |goto 46.95,52.09 < 10 |walk
Follow the path up |goto 47.20,41.70 < 20 |only if walking
Enter Ironforge |goto 53.47,34.90 < 20 |walk
Enter the building |goto Ironforge 66.34,82.50 < 15 |walk
talk Muren Stormpike##6114
|tip Upstairs inside the building.
turnin Muren Stormpike##1679 |goto Ironforge 62.44,35.59
accept Vejrek##1678 |goto Ironforge 62.44,35.59
|only if (Dwarf Warrior) or (Gnome Warrior)
step
Leave the building |goto 66.30,82.35 < 15 |walk
Follow the path |goto 30.96,80.43 < 20 |only if walking
Leave Ironforge |goto 15.03,85.95 < 20 |walk
Follow the path |goto Dun Morogh 41.92,47.16 < 30 |only if walking
Continue following the path |goto Dun Morogh 36.24,45.96 < 30 |only if walking
Follow the path up |goto Dun Morogh 27.97,56.18 < 20 |only if walking
kill Vejrek##6113
|tip Inside the hut.
collect Vejrek's Head##6799 |q 1678/1 |goto Dun Morogh 27.83,57.95
|only if (Dwarf Warrior) or (Gnome Warrior)
step
Follow the path |goto 31.50,50.67 < 30 |only if walking
Continue following the path |goto 36.76,46.02 < 30 |only if walking
Continue following the path |goto 42.18,47.16 < 30 |only if walking
Follow the path up |goto 47.20,41.70 < 20 |only if walking
Enter Ironforge |goto 53.47,34.90 < 20 |walk
Enter the building |goto Ironforge 66.34,82.50 < 15 |walk
talk Muren Stormpike##6114
|tip Upstairs inside the building.
turnin Vejrek##1678 |goto Ironforge 62.44,35.59
|only if (Dwarf Warrior) or (Gnome Warrior)
step
Leave the building |goto 66.30,82.35 < 15 |walk
Follow the path |goto 30.96,80.43 < 20 |only if walking
Leave Ironforge |goto 15.03,85.95 < 20 |c |q 419 |future
|only if (Dwarf Warrior) or (Gnome Warrior)
step
Follow the path up |goto Dun Morogh 47.20,41.70 < 20 |only if walking
Enter Ironforge |goto Dun Morogh 53.47,34.90 < 20 |walk
talk Lago Blackwrench##6120
accept The Slaughtered Lamb##1715 |goto Ironforge 47.63,9.26
|only if Gnome Warlock
step
Follow the path |goto 72.81,50.26 < 15 |walk
Enter the Deeprun Tram |goto 77.02,51.26
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
Enter Stormwind City |goto Stormwind City 62.94,9.36 < 2000 |noway |c |q 1715
|only if Gnome Warlock
step
Enter the building |goto Stormwind City 29.16,74.16 < 10 |walk
Follow the path down |goto Stormwind City 27.42,76.42 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin The Slaughtered Lamb##1715 |goto Stormwind City 25.26,78.56
accept Surena Caledon##1688 |goto Stormwind City 25.26,78.56
|only if Gnome Warlock
step
Leave the building |goto 29.15,74.18 < 10 |walk
Leave Stormwind City |goto Stormwind City 71.02,89.03 < 30 |only if walking
Follow the road |goto Elwynn Forest 42.68,67.14 < 30 |only if walking
Follow the path |goto Elwynn Forest 64.57,74.00 < 30 |only if walking
Enter the building |goto Elwynn Forest 70.93,80.43 < 10 |walk
talk Surena Caledon##881
|tip Inside the building.
collect Surena's Choker##6810 |q 1688/1 |goto Elwynn Forest 71.02,80.78
|only if Gnome Warlock
step
Follow the road |goto 65.65,74.10 < 30 |only if walking
Continue following the road |goto 42.11,64.65 < 30 |only if walking
Enter Stormwind City |goto 32.09,49.38 < 30 |only if walking
Enter the building |goto Stormwind City 29.15,74.18 < 10 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Surena Caledon##1688 |goto Stormwind City 25.26,78.56
accept The Binding##1689 |goto Stormwind City 25.26,78.56
|only if Gnome Warlock
step
Follow the path down |goto 25.05,79.31 < 5 |walk
Run down the stairs |goto 24.28,78.62 < 7 |c |q 1689
|only if Gnome Warlock
step
Run down the stairs |goto 26.15,79.33 < 7 |walk
use the Bloodstone Choker##6928
|tip Use it while standing on the pink symbol on the ground.
|tip Downstairs inside the building, inside the crypt.
kill Summoned Voidwalker##5676 |q 1689/1 |goto 25.11,77.46
|only if Gnome Warlock
step
Follow the path up |goto 26.03,79.83 < 7 |walk
Run up the stairs |goto 23.31,79.68 < 7 |c |q 1689
|only if Gnome Warlock
step
talk Gakin the Darkbinder##6122
|tip Upstairs inside the building, in the basement above the crypt.
turnin The Binding##1689 |goto 25.25,78.53
|only if Gnome Warlock
step
Leave the building |goto 29.16,74.12 < 10 |walk
Follow the path |goto 60.32,12.56 < 15 |walk
Enter the Deeprun Tram |goto 77.02,51.26
Click Here After Entering Deeprun Tramp |confirm |q 433 |future
|only if Gnome Warlock
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the Deeprun Tram from Stormwind City to Ironforge.
Click Here After Riding the Tram |confirm |q 433 |future
|only if Gnome Warlock
step
_Inside Deeprun Tram:_
Enter Ironforge |goto Ironforge 76.51,51.12 < 2000 |noway |c |q 433 |future
|only if Gnome Warlock
step
Leave Ironforge |goto 15.03,85.95 < 20 |c |q 433 |future
|only if Gnome Warlock
step
Enter the building |goto Dun Morogh 46.95,52.05 < 7 |walk
talk Maxan Anvol##1226
|tip Inside the building.
accept Desperate Prayer##5635 |goto Dun Morogh 47.34,52.18
|only if Dwarf Priest
step
Leave the building |goto 46.95,52.05 < 7 |walk
|only if Dwarf Priest
step
Follow the road |goto Dun Morogh 51.06,47.29 < 30 |only if walking
talk Senator Mehr Stonehallow##1977
accept The Public Servant##433 |goto Dun Morogh 68.67,55.97
step
talk Foreman Stonebrow##1254
accept Those Blasted Troggs!##432 |goto 69.08,56.33
stickystart "Kill_Rockjaw_Skullthumpers"
step
Enter the cave |goto 70.52,56.67 < 15 |walk
kill 10 Rockjaw Bonesnapper##1117 |q 433/1 |goto 70.98,54.77
|tip Inside the cave.
step
label "Kill_Rockjaw_Skullthumpers"
kill 6 Rockjaw Skullthumper##1115 |q 432/1 |goto 70.98,54.77
|tip You can find more outside the cave.
step
Leave the cave |goto 70.52,56.67 < 15 |walk
Follow the path up |goto 67.86,57.69 < 15 |only if walking
talk Senator Mehr Stonehallow##1977
turnin The Public Servant##433 |goto 68.67,55.97
step
talk Foreman Stonebrow##1254
turnin Those Blasted Troggs!##432 |goto 69.08,56.33
step
Follow the path up |goto 68.02,55.59 < 15 |only if walking
Follow the road |goto Dun Morogh 67.26,52.92 < 30 |only if walking
Continue following the road |goto Dun Morogh 78.18,49.39 < 30 |only if walking
Enter the tunnel |goto Dun Morogh 81.21,42.70 < 15 |only if walking
Leave the tunnel |goto Dun Morogh 82.98,40.34 < 15 |only if walking
talk Pilot Hammerfoot##1960
accept The Lost Pilot##419 |goto Dun Morogh 83.89,39.19
step
Follow the path |goto 81.02,36.12 < 30 |only if walking
click A Dwarven Corpse
turnin The Lost Pilot##419 |goto 79.67,36.17
accept A Pilot's Revenge##417 |goto 79.67,36.17
step
kill Mangeclaw##1961
collect Mangy Claw##3183 |q 417/1 |goto 78.31,37.76
step
Follow the path |goto 81.10,36.13 < 30 |only if walking
talk Pilot Hammerfoot##1960
turnin A Pilot's Revenge##417 |goto 83.89,39.19
step
Enter the tunnel |goto 82.96,40.36 < 15 |only if walking
Leave the tunnel |goto 81.22,42.67 < 15 |only if walking
Follow the path |goto 78.64,50.34 < 30 |only if walking
Enter the tunnel |goto 82.30,53.40 < 15 |only if walking
Leave the tunnel |goto 84.20,51.34 < 15 |only if walking
talk Mountaineer Barleybrew##1959
turnin Shimmer Stout##413 |goto 86.28,48.81
accept Stout to Kadrell##414 |goto 86.28,48.81
step
Enter the tunnel |goto 86.25,51.32 < 15 |only if walking
Leave the tunnel |goto Loch Modan 19.54,62.67 < 15 |only if walking
talk Mountaineer Cobbleflint##1089
accept In Defense of the King's Lands##224 |goto Loch Modan 22.07,73.12
step
Enter the building |goto 23.71,75.47 < 15 |walk
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
accept The Trogg Threat##267 |goto 23.23,73.67
stickystart "Kill_Stonesplinter_Troggs"
stickystart "Kill_Stonesplinter_Scouts"
step
Follow the road up |goto 23.20,70.46 < 20 |only if walking
Follow the path |goto 28.43,65.77 < 30 |only if walking
Kill Stonesplinter enemies around this area
collect 8 Trogg Stone Tooth##2536 |q 267/1 |goto 32.51,73.25
step
label "Kill_Stonesplinter_Troggs"
kill 10 Stonesplinter Trogg##1161 |q 224/1 |goto 32.51,73.25
step
label "Kill_Stonesplinter_Scouts"
kill 10 Stonesplinter Scout##1162 |q 224/2 |goto 32.51,73.25
step
Kill enemies around this area
Reach Level 11 |ding 11 |goto 32.51,73.25
step
Follow the path |goto 30.64,69.80 < 20 |only if walking
Follow the road down |goto 27.64,65.84 < 30 |only if walking
talk Mountaineer Cobbleflint##1089
turnin In Defense of the King's Lands##224 |goto 22.07,73.13
step
Enter the building |goto 23.71,75.45 < 15 |walk
talk Captain Rugelfuss##1092
|tip Upstairs inside the building.
turnin The Trogg Threat##267 |goto 23.23,73.67
step
Follow the road up |goto 23.20,70.46 < 20 |only if walking
talk Thorgrum Borrelson##1572
fpath Thelsamar |goto 33.94,50.95
step
talk Mountaineer Kadrell##1340
|tip He walks around this area.
turnin Stout to Kadrell##414 |goto 34.50,47.32
accept Rat Catching##416 |goto 34.50,47.32
accept Mountaineer Stormpike's Task##1339 |goto 34.50,47.32
step
Enter the building |goto 35.23,47.75 < 10 |walk
talk Innkeeper Hearthstove##6734
|tip Inside the building.
home Stoutlager Inn |goto 35.53,48.40
step
talk Vidra Hearthstove##1963
|tip Inside the building.
accept Thelsamar Blood Sausages##418 |goto 34.83,49.28
step
Leave the building |goto 35.21,47.76 < 10 |c |q 418
step
Enter the building |goto 37.18,47.09 < 10 |walk
talk Brock Stoneseeker##1681
|tip Downstairs inside the building.
|tip He sometimes walks out near the entrance of the building.
accept Honor Students##6387 |goto 37.02,47.81
|only if Dwarf or Gnome
step
Leave the building |goto 37.18,47.09 < 7 |c |q 418
|only if Dwarf or Gnome
stickystart "Collect_Spider_Ichors"
stickystart "Collect_Bear_Meat"
step
kill Mountain Boar##1190+
collect 3 Boar Intestines##3172 |q 418/1 |goto 36.99,34.36
You can find more around [29.17,23.57]
step
label "Collect_Spider_Ichors"
kill Forest Lurker##1195+
collect 3 Spider Ichor##3174 |q 418/3 |goto 35.69,31.78
You can find more around: |notinsticky
[29.17,23.57]
[29.43,48.28]
stickystart "Collect_Tunnel_Rat_Ears"
step
label "Collect_Bear_Meat"
kill Elder Black Bear##1186+
collect 3 Bear Meat##3173 |q 418/2 |goto 35.68,32.10
You can find more around: |notinsticky
[30.73,25.86]
[28.66,11.57]
[24.03,25.79]
[27.45,28.54]
[28.09,40.94]
step
label "Collect_Tunnel_Rat_Ears"
Kill Tunnel Rat enemies around this area
collect 12 Tunnel Rat Ear##3110 |q 416/1 |goto 24.57,29.79
You can find more around [26.08,43.64]
step
Kill enemies around this area
Reach Level 12 |ding 12 |goto 24.57,29.79
You can find more around [26.08,43.64]
step
Enter the building |goto 23.53,17.90 < 15 |walk
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Mountaineer Stormpike's Task##1339 |goto 24.76,18.40
accept Stormpike's Order##1338 |goto 24.76,18.40
accept Filthy Paws##307 |goto 24.76,18.40
step
Enter the mine |goto 35.48,18.83 < 15 |walk
click Miners' League Crates+
|tip They look like piles of brown boxes on the ground around this area inside the mine.
collect 4 Miners' Gear##2640 |q 307/1 |goto 35.75,22.42
step
Leave the mine |goto 35.46,18.72 < 15 |walk
Enter the building |goto 23.50,17.89 < 15 |walk
talk Mountaineer Stormpike##1343
|tip Upstairs inside the building.
turnin Filthy Paws##307 |goto 24.76,18.40
step
talk Vidra Hearthstove##1963
|tip Inside the building.
turnin Thelsamar Blood Sausages##418 |goto 34.83,49.29
step
Leave the building |goto 35.22,47.75 < 10 |walk
talk Mountaineer Kadrell##1340
|tip He walks around this area.
turnin Rat Catching##416 |goto 34.61,47.09
step
talk Thorgrum Borrelson##1572
turnin Honor Students##6387 |goto 33.94,50.95
accept Ride to Ironforge##6391 |goto 33.94,50.95
step
Follow the path |goto Ironforge 44.58,49.54 < 10 |walk
talk Senator Barin Redstone##1274
turnin The Reports##291 |goto Ironforge 39.55,57.49
step
Follow the path |goto 44.58,49.54 < 10 |c |q 983 |future
step
Run up the stairs |goto Ironforge 51.88,29.66 < 7 |only if walking
Enter the building |goto Ironforge 49.59,28.51 < 7 |walk
talk Golnir Bouldertoe##4256
|tip Downstairs inside the building.
turnin Ride to Ironforge##6391 |goto Ironforge 51.52,26.30
accept Gryth Thurden##6388 |goto Ironforge 51.52,26.30
|only if Dwarf or Gnome
step
Leave the building |goto 49.59,28.51 < 5 |walk
talk Gryth Thurden##1573
turnin Gryth Thurden##6388 |goto 55.51,47.74
accept Return to Brock##6392 |goto 55.51,47.74
|only if Dwarf or Gnome
step
Enter the building |goto Loch Modan 37.18,47.09 < 10 |walk
talk Brock Stoneseeker##1681
|tip Downstairs inside the building.
|tip He sometimes walks out near the entrance of the building.
turnin Return to Brock##6392 |goto Loch Modan 37.02,47.81
|only if Dwarf or Gnome
step
Leave the building |goto 37.18,47.09 < 7 |c |q 983 |future
|only if Dwarf or Gnome
step
Leave Ironforge |goto Ironforge 15.15,85.80 < 20 |walk
Follow the path |goto Dun Morogh 43.74,44.12 < 30 |only if walking
Continue following the path |goto Dun Morogh 38.97,38.75 < 30 |only if walking
Follow the path up |goto Dun Morogh 30.71,34.33 < 10 |only if walking
Continue up the path |goto Dun Morogh 31.06,32.56 < 7 |only if walking
Continue up the path |goto Dun Morogh 31.43,32.34 < 7 |only if walking
Continue up the path |goto Dun Morogh 31.14,30.50 < 7 |only if walking
Follow the path down |goto Dun Morogh 32.33,28.63 < 7 |only if walking
Follow the path |goto Dun Morogh 32.74,27.11 < 10 |only if walking
Jump to Your Death |havebuff 132331 |goto Wetlands 11.73,43.30 |q 983 |future |notravel
|tip Keep running north and jump off the cliff.
|tip You will die, and arrive at the graveyard next to Menethil Harbor.
|tip This is much easier and faster than running all the way through the Wetlands, potentially dying repeatedly.
step
Return to Life |nobuff 132331 |goto Wetlands 11.73,43.30 |q 983 |future
|tip Resurrect at the Spirit Healer near Menethil Harbor.
step
Cross the bridge |goto Wetlands 12.38,50.30 < 20 |only if walking
Follow the path |goto Wetlands 10.86,55.08 < 20 |only if walking
talk Shellei Brondir##1571
fpath Menethil Harbor |goto Wetlands 9.49,59.69
step
talk Wizbang Cranktoggle##3666
|tip Upstairs inside the building.
accept Buzzbox 827##983 |goto Darkshore 36.98,44.14
step
talk Innkeeper Shaussiy##6737
|tip Inside the building.
home Auberdine |goto 37.04,44.12
step
talk Gwennyth Bly'Leggonde##10219
accept Washed Ashore##3524 |goto 36.62,45.59
step
talk Caylais Moonfeather##3841
fpath Auberdine |goto 36.34,45.58
step
talk Terenthis##3693
|tip Inside the building.
accept How Big a Threat?##984 |goto 39.37,43.48
step
Enter the building |goto 37.77,41.36 < 15 |walk
talk Thundris Windweaver##3649
|tip Inside the building.
accept Bashal'Aran##954 |goto 37.39,40.13
step
Leave the building |goto 37.77,41.34 < 15 |walk
kill Pygmy Tide Crawler##2231+
|tip You can find more in the water nearby.
collect 6 Crawler Leg##5385 |q 983/1 |goto 36.12,48.70
step
click Beached Sea Creature
collect Sea Creature Bones##12242 |q 3524/1 |goto 36.39,50.88
step
click Buzzbox 827
turnin Buzzbox 827##983 |goto 36.66,46.26
accept Buzzbox 411##1001 |goto 36.66,46.26
step
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##3524 |goto 36.62,45.59
accept Washed Ashore##4681 |goto 36.62,45.59
step
kill Darkshore Thresher##2185
|tip Underwater around this area.
collect 3 Thresher Eye##5412 |q 1001/1 |goto 31.60,39.75
You can find more around: |notinsticky
[35.39,37.08]
[32.85,34.45]
step
click Skeletal Sea Turtle
|tip Underwater.
collect Sea Turtle Remains##12289 |q 4681/1 |goto 31.87,46.32
step
Find a Corrupt Furbolg Camp |q 984/1 |goto 39.26,53.12
step
talk Terenthis##3693
|tip Inside the building.
turnin How Big a Threat?##984 |goto 39.37,43.48
accept Thundris Windweaver##4761 |goto 39.37,43.48
step
Enter the building |goto 37.77,41.37 < 15 |walk
talk Thundris Windweaver##3649
|tip Inside the building.
turnin Thundris Windweaver##4761 |goto 37.39,40.13
step
Leave the building |goto 37.76,41.34 < 15 |walk
talk Gwennyth Bly'Leggonde##10219
turnin Washed Ashore##4681 |goto 36.62,45.59
step
Follow the road |goto 40.30,46.37 < 20 |only if walking
Follow the path |goto 42.90,36.58 < 30 |only if walking
Follow the path up |goto 44.25,36.82 < 15 |only if walking
talk Asterion##3650
turnin Bashal'Aran##954 |goto 44.17,36.29
accept Bashal'Aran##955 |goto 44.17,36.29
step
Kill enemies around this area
|tip Only Vile Sprites and Wild Grells will drop the quest item.
collect 8 Grell Earring##5336 |goto 45.13,38.46
You can find more around [47.72,37.13]
step
talk Asterion##3650
turnin Bashal'Aran##955 |goto 44.17,36.29
step
Kill enemies around this area
Reach Level 13 |ding 13 |goto 45.13,38.46
You can find more around [47.72,37.13]
step
click Beached Sea Creature
accept Beached Sea Creature##4723 |goto 41.95,31.59
step
click Buzzbox 411
turnin Buzzbox 411##1001 |goto 41.96,28.64
step
talk Gwennyth Bly'Leggonde##10219
turnin Beached Sea Creature##4723 |goto 36.62,45.59
step
Enter the building |goto Ironforge 27.28,12.31 < 15 |walk
talk Brandur Ironhammer##5149
|tip Inside the building.
accept Tome of Divinity##2997 |goto Ironforge 23.12,6.14
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin Tome of Divinity##2997 |goto 27.64,12.19
accept The Tome of Divinity##1645 |goto 27.64,12.19
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
accept The Tome of Divinity##1646 |goto 27.64,12.19
|only if Dwarf Paladin
step
use the Tome of Divinity##6916
accept The Tome of Divinity##1646
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1646 |goto 27.64,12.19
accept The Tome of Divinity##1647 |goto 27.64,12.19
|only if Dwarf Paladin
step
talk John Turner##6175
|tip He walks around this area
turnin The Tome of Divinity##1647 |goto 21.55,50.80
accept The Tome of Divinity##1648 |goto 21.55,50.80
You can also find him around:
[22.93,61.36]
[32.40,78.58]
[43.09,84.17]
|only if Dwarf Paladin
step
Enter the building |goto 26.14,72.21 < 15 |walk
talk Auctioneer Redmuse##8720
|tip Inside the building.
collect 10 Linen Cloth##2589 |q 1648/1 |goto 24.25,74.57
|tip Buy them from the Auction House.
|only if Dwarf Paladin
step
talk John Turner##6175
|tip He walks around this area
turnin The Tome of Divinity##1648 |goto 21.55,50.80
accept The Tome of Divinity##1778 |goto 21.55,50.80
You can also find him around:
[22.93,61.36]
[32.40,78.58]
[43.09,84.17]
|only if Dwarf Paladin
step
Enter the building |goto Ironforge 27.28,12.31 < 15 |only if walking
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1778 |goto 27.64,12.19
accept The Tome of Divinity##1779 |goto 27.64,12.19
|only if Dwarf Paladin
step
talk Muiredon Battleforge##6178
|tip Upstairs inside the building.
turnin The Tome of Divinity##1779 |goto 23.53,8.29
accept The Tome of Divinity##1783 |goto 23.53,8.29
|only if Dwarf Paladin
step
Follow the path |goto 21.95,63.20 < 20 |walk
Leave Ironforge |goto 15.03,85.95 < 20 |walk
Follow the road |goto Dun Morogh 49.69,46.36 < 30 |only if walking
Follow the path |goto Dun Morogh 73.14,49.95 < 30 |only if walking
use the Symbol of Life##6866
|tip Use it on Narm Faulk's corpse.
Resseurect Narm Faulk |q 1783/1 |goto Dun Morogh 78.32,58.09
|only if Dwarf Paladin
step
talk Narm Faulk##6177
turnin The Tome of Divinity##1783 |goto 78.32,58.09
accept The Tome of Divinity##1784 |goto 78.32,58.09
|only if Dwarf Paladin
step
kill Dark Iron Spy##6123+
collect Dark Iron Script##6847 |q 1784/1 |goto 77.39,61.27
|only if Dwarf Paladin
step
Follow the road |goto 72.88,49.82 < 30 |only if walking
Follow the path up |goto 47.25,41.65 < 20 |only if walking
Enter Ironforge |goto 53.47,34.90 < 20 |walk
Enter the building |goto Ironforge 27.28,12.31 < 15 |only if walking
talk Muiredon Battleforge##6178
|tip Upstairs inside the building.
turnin The Tome of Divinity##1784 |goto Ironforge 23.53,8.29
accept The Tome of Divinity##1785 |goto Ironforge 23.53,8.29
|only if Dwarf Paladin
step
talk Tiza Battleforge##6179
|tip Upstairs inside the building.
turnin The Tome of Divinity##1785 |goto 27.64,12.19
|only if Dwarf Paladin
step
Travel to Ironforge |goto Ironforge 77.02,51.26 < 2000 |c |q 1338
step
Follow the path |goto Ironforge 72.81,50.26 < 15 |walk
Enter the Deeprun Tram |goto Ironforge 77.02,51.26
|tip Walk through the swirling portal.
Click Here After Entering the Deeprun Tram |confirm |q 1338
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip On the middle platform, near the wall.
|tip In the Ironforge section of the Deeprun Tram.
accept Deeprun Rat Roundup##6661
step
_Inside Deeprun Tram:_
use Rat Catcher's Flute##17117
|tip Use it on Deeprun Rats around this area.
|tip They look like small grey rats on the ground around this area.
|tip In the Ironforge section of the Deeprun Tram.
Capture #5# Rats |q 6661/1
step
_Inside Deeprun Tram:_
talk Monty##12997
|tip On the middle platform, near the wall.
|tip In the Ironforge section of the Deeprun Tram.
turnin Deeprun Rat Roundup##6661
step
Watch the dialogue
_Inside Deeprun Tram:_
talk Monty##12997
|tip On the middle platform, near the wall.
|tip In the Ironforge section of the Deeprun Tram.
accept Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Ride the Tram
|tip Ride the Deeprun Tram from Ironforge to Stormwind City.
Click Here After Riding the Tram |confirm |q 6662
step
_Inside Deeprun Tram:_
talk Nipsy##13018
|tip On the middle platform, near the wall.
|tip In the Stormwind City section of the Deeprun Tram.
turnin Me Brother, Nipsy##6662
step
_Inside Deeprun Tram:_
Enter Stormwind City |goto Stormwind City 62.94,9.36 < 2000 |noway |c |q 1338
|tip Walk through the swirling portal.
step
talk Furen Longbeard##5413
turnin Stormpike's Order##1338 |goto Stormwind City 58.09,16.52
step
Enter the building |goto Stormwind City 43.04,34.51 < 7 |walk
talk High Priestess Laurena##376
|tip Inside the building.
turnin Desperate Prayer##5635 |goto Stormwind City 38.58,26.02
|only if Human Priest
step
Leave the building |goto Stormwind City 43.04,34.51 < 7 |c |q 109 |future
|only if Human Priest
step
Run up the ramp |goto 62.39,62.31 < 10 |only if walking
talk Dungar Longdrink##352
|tip Inside the building.
fpath Stormwind |goto 66.27,62.14
step
Run up the ramp |goto 72.07,80.61 < 15 |only if walking
Follow the road |goto 69.76,85.39 < 20 |only if walking
talk Marshal Dughan##240
accept Report to Gryan Stoutmantle##109 |goto Elwynn Forest 42.11,65.93
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (13-20)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (20-25)",
startlevel=13,
endlevel=20,
},[[
step
Follow the road |goto Elwynn Forest 38.77,66.86 < 30 |only if walking
talk Farmer Furlbrow##237
accept The Forgotten Heirloom##64 |goto Westfall 59.96,19.36
step
talk Verna Furlbrow##238
accept Westfall Stew##36 |goto 59.92,19.42
accept Poor Old Blanchy##151 |goto 59.92,19.42
stickystart "Collect_Handfuls_Of_Oats"
step
talk Farmer Saldean##233
accept The Killing Fields##9 |goto 56.04,31.23
step
Enter the building |goto 56.15,31.04 < 7 |walk
talk Salma Saldean##235
|tip Inside the building.
turnin Westfall Stew##36 |goto 56.42,30.52
accept Goretusk Liver Pie##22 |goto 56.42,30.52
accept Westfall Stew##38 |goto 56.42,30.52
stickystart "Collect_Goretusk_Livers"
stickystart "Collect_Goretusk_Snouts"
stickystart "Collect_Stringy_Vulture_Meat"
step
Leave the building |goto 56.15,31.04 < 7 |walk
talk Thor##523
fpath Sentinel Hill |goto 56.55,52.64
step
talk Scout Galiaan##878
accept Red Leather Bandanas##153 |goto 53.98,52.98
step
talk Gryan Stoutmantle##234
turnin Report to Gryan Stoutmantle##109 |goto 56.33,47.52
accept The People's Militia##12 |goto 56.33,47.52
step
talk Captain Danuvin##821
accept Patrolling Westfall##102 |goto 56.43,47.62
stickystart "Kill_Defias_Trappers"
stickystart "Kill_Defias_Smugglers"
step
Kill Defias enemies around this area
collect 15 Red Leather Bandana |q 153/1 |goto 49.35,47.19
You can find more around: |notinsticky
[50.73,40.31]
[46.51,38.74]
step
label "Kill_Defias_Trappers"
kill 15 Defias Trapper##504 |q 12/1 |goto 49.35,47.19
You can find more around: |notinsticky
[50.73,40.31]
[46.51,38.74]
step
label "Kill_Defias_Smugglers"
kill 15 Defias Smuggler##95 |q 12/2 |goto 49.35,47.19
You can find more around: |notinsticky
[50.73,40.31]
[46.51,38.74]
step
Kill enemies around this area
Reach Level 14 |ding 14 |goto 49.35,47.19
stickystop "Collect_Goretusk_Livers"
stickystop "Collect_Goretusk_Snouts"
stickystop "Collect_Stringy_Vulture_Meat"
stickystop "Collect_Handfuls_Of_Oats"
step
Enter the building |goto Stormwind City 54.07,59.00 < 10 |walk
talk Auctioneer Jaxon##15659
|tip Inside the building.
buy 5 Earthroot##2449 |goto Stormwind City 53.61,59.76 |q 6123 |future
|only if NightElf Druid
step
Leave the building |goto 54.07,59.00 < 7 |walk
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
accept Lessons Anew##6121 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
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
collect Filled Cliffspring Falls Sampler##15845 |q 6122/1 |goto Darkshore 54.93,33.32
|only if NightElf Druid
step
Follow the road |goto 47.10,26.84 < 30 |only if walking
Follow the path |goto 42.21,42.33 < 30 |only if walking
Enter the building |goto 37.77,41.36 < 15 |walk
talk Alanndarian Nightsong##3702
|tip Inside the building.
turnin The Principal Source##6122 |goto 37.69,40.66
accept Gathering the Cure##6123 |goto 37.69,40.66
|only if NightElf Druid
step
Leave the building |goto 37.77,41.36 < 10 |walk
Follow the road |goto 40.04,46.77 < 30 |only if walking
click Lunar Fungal Bloom+
|tip They look like clusters of small white-spotted mushrooms on the ground inside the small caves around this area.
collect 12 Lunar Fungus##15851 |q 6123/2 |goto 43.07,45.55
You can find more small caves at:
[43.07,49.24]
[43.38,50.50]
[42.71,52.28]
[45.22,53.45]
[46.30,45.56]
[45.52,50.24]
|only if NightElf Druid
step
Follow the road |goto 39.93,46.07 < 30 |only if walking
Enter the building |goto 37.77,41.36 < 15 |walk
talk Alanndarian Nightsong##3702
|tip Inside the building.
turnin Gathering the Cure##6123 |goto 37.69,40.66
accept Curing the Sick##6124 |goto 37.69,40.66
|only if NightElf Druid
step
Leave the building |goto 37.77,41.34 < 10 |walk
Follow the road |goto 39.55,45.39 < 30 |only if walking
use the Curative Animal Salve##15826
|tip Use it on Sickly Deer around this area.
|tip They look like green diseased deer in areas with trees.
|tip They are spread out all throughout Darkshore.
Cure #10# Sickly Deer |q 6124/1 |goto 41.51,46.08
|only if NightElf Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Curing the Sick##6124 |goto Moonglade 56.21,30.64
accept Power over Poison##6125 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
Enter the building |goto Darnassus 35.52,10.72 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Power over Poison##6125 |goto Darnassus 35.38,8.41
|only if NightElf Druid
step
talk Gryan Stoutmantle##234
turnin The People's Militia##12 |goto Westfall 56.33,47.52
accept The People's Militia##13 |goto Westfall 56.33,47.52
step
talk Scout Galiaan##878
turnin Red Leather Bandanas##153 |goto 53.99,52.98
step
Enter the building |goto 56.53,47.39 < 7 |walk
talk Quartermaster Lewis##491
|tip Inside the building.
accept A Swift Message##6181 |goto 57.00,47.17
|only if Human
step
Leave the building |goto 56.53,47.39 < 10 |walk
talk Thor##523
turnin A Swift Message##6181 |goto 56.56,52.64
accept Continue to Stormwind##6281 |goto 56.56,52.64
|only if Human
step
Enter the building |goto Stormwind City 73.68,47.66 < 10 |walk
talk Osric Strang##1323
|tip Inside the building.
turnin Continue to Stormwind##6281 |goto Stormwind City 74.32,47.24
accept Dungar Longdrink##6261 |goto Stormwind City 74.32,47.24
|only if Human
step
Leave the building |goto 73.68,47.66 < 7 |walk
Run up the ramp |goto 62.46,62.32 < 15 |only if walking
talk Dungar Longdrink##352
turnin Dungar Longdrink##6261 |goto 66.27,62.13
accept Return to Lewis##6285 |goto 66.27,62.13
|only if Human
step
Enter the building |goto Westfall 56.51,47.40 < 10 |walk
talk Quartermaster Lewis##491
|tip Inside the building.
turnin Return to Lewis##6285 |goto Westfall 57.00,47.17
|only if Human
step
Leave the building |goto 56.51,47.40 < 10 |c |q 22
|only if Human
stickystart "Collect_Goretusk_Snouts"
stickystart "Collect_Stringy_Vulture_Meat"
stickystart "Collect_Handfuls_Of_Oats"
step
label "Collect_Goretusk_Livers"
Kill Goretusk enemies around this area
|tip They look like boars.
collect 8 Goretusk Liver##723 |q 22/1 |goto 53.55,41.12
You can find more around: |notinsticky
[60.81,45.54]
[60.01,29.16]
step
label "Collect_Goretusk_Snouts"
Kill Goretusk enemies around this area
|tip They look like boars.
collect 3 Goretusk Snout##731 |q 38/3 |goto 53.55,41.12
You can find more around: |notinsticky
[60.81,45.54]
[60.01,29.16]
step
label "Collect_Stringy_Vulture_Meat"
Kill Fleshripper enemies around this area
|tip They look like vultures.
collect 3 Stringy Vulture Meat##729 |q 38/1 |goto 53.55,41.12
You can find more around: |notinsticky
[60.81,45.54]
[60.01,29.16]
[49.44,27.31]
step
Enter the building |goto 49.53,19.39 < 10 |walk
click Furlbrow's Wardrobe
|tip Inside the building.
collect Furlbrow's Pocket Watch##841 |q 64/1 |goto 49.36,19.24
step
Leave the building |goto 49.53,19.39 < 7 |walk
Kill Riverpaw enemies around this area
collect 8 Gnoll Paw##725 |q 102/1 |goto 52.06,14.98
You can find more around: |notinsticky
[56.88,13.69]
[44.90,13.81]
step
Kill Murloc enemies around this area
collect 3 Murloc Eye##730 |q 38/2 |goto 54.65,10.94
step
Follow the path up |goto 54.63,14.26 < 30 |c |q 151
step
label "Collect_Handfuls_Of_Oats"
click Sack of Oats+
|tip They look like tan grain bags on the ground around this area.
|tip They are spread out around Westfall, usually concentrated near and around farm areas.
|tip Keep an eye out for these as you run around completing other quests.
collect 8 Handful of Oats##1528 |q 151/1 |goto 50.51,20.69
You can find more around: |notinsticky
[57.38,18.41]
step
talk Farmer Furlbrow##237
turnin The Forgotten Heirloom##64 |goto 59.96,19.36
step
talk Verna Furlbrow##238
turnin Poor Old Blanchy##151 |goto 59.92,19.42
stickystart "Collect_Flasks_Of_Oil"
stickystart "Kill_Harvest_Watchers"
step
kill Harvest Watcher##114+
collect 3 Okra##732 |q 38/4 |goto 53.89,32.26
You can find more around [51.03,22.94]
step
label "Collect_Flasks_Of_Oil"
kill Harvest Watcher##114+
collect 5 Flask of Oil##814 |goto 53.89,32.26 |q 103 |future
You can find more around [51.03,22.94]
step
label "Kill_Harvest_Watchers"
kill 20 Harvest Watcher##114 |q 9/1 |goto 53.89,32.26
You can find more around [51.03,22.94]
step
Kill enemies around this area
Reach Level 15 |ding 15 |goto 53.89,32.26
You can find more around [51.03,22.94]
step
talk Farmer Saldean##233
turnin The Killing Fields##9 |goto 56.04,31.23
step
Enter the building |goto 56.15,31.05 < 7 |walk
talk Salma Saldean##235
|tip Inside the building.
turnin Goretusk Liver Pie##22 |goto 56.42,30.52
turnin Westfall Stew##38 |goto 56.42,30.52
step
Leave the building |goto 56.15,31.05 < 7 |walk
talk Captain Danuvin##821
turnin Patrolling Westfall##102 |goto 56.42,47.62
step
talk Cerellean Whiteclaw##3644
accept For Love Eternal##963 |goto Darkshore 35.74,43.71
step
talk Barithras Moonshade##3583
accept Cave Mushrooms##947 |goto 37.32,43.64
step
talk Sentinel Glynda Nal'Shea##2930
|tip She walks around this area.
accept The Red Crystal##4811 |goto 37.70,43.39
step
talk Tharnariun Treetender##3701
accept Plagued Lands##2118 |goto 38.84,43.42
step
talk Terenthis##3693
|tip Inside the building.
accept How Big a Threat?##985 |goto 39.37,43.48
step
talk Gorbold Steelhand##6301
accept Deep Ocean, Vast Sea##982 |goto 38.11,41.17
step
Enter the building |goto 37.77,41.35 < 15 |walk
talk Thundris Windweaver##3649
|tip Inside the building.
accept The Cliffspring River##4762 |goto 37.40,40.13
stickystart "Kill_Blackwood_Windtalkers"
step
Leave the building |goto 37.77,41.35 < 15 |walk
Follow the road |goto 40.06,46.63 < 30 |only if walking
Follow the path |goto 40.64,51.64 < 30 |only if walking
kill 8 Blackwood Pathfinder##2167 |q 985/1 |goto 39.87,53.98
You can find more around [39.96,56.10]
step
label "Kill_Blackwood_Windtalkers"
kill 5 Blackwood Windtalker##2324 |q 985/2 |goto 39.87,53.98
You can find more around [39.96,56.10]
step
use Tharnariun's Hope##7586
|tip Use it on a Rabid Thistle Bear around this area.
|tip Make sure it's very close to you when you use it.
Capture a Rabid Thistle Bear |q 2118/1 |goto 38.32,54.90
step
Follow the road |goto 41.37,54.82 < 30 |only if walking
talk Tharnariun Treetender##3701
turnin Plagued Lands##2118 |goto 38.84,43.42
accept Cleansing of the Infected##2138 |goto 38.84,43.42
step
talk Terenthis##3693
|tip Inside the building.
turnin How Big a Threat?##985 |goto 39.37,43.48
step
Follow the road |goto 39.47,45.11 < 30 |only if walking
Locate the Large, Red Crystal on Darkshore's Eastern Mountain Range |q 4811/1 |goto 47.29,48.69
step
Follow the road |goto 40.02,46.31 < 30 |only if walking
talk Sentinel Glynda Nal'Shea##2930
|tip She walks around this area.
turnin The Red Crystal##4811 |goto 37.71,43.39
accept As Water Cascades##4812 |goto 37.71,43.39
step
use the Empty Water Tube##14338
collect Moonwell Water Tube##14339 |q 4812/1 |goto 37.79,44.06
step
Follow the road |goto 39.47,45.11 < 30 |only if walking
click Mysterious Red Crystal
turnin As Water Cascades##4812 |goto 47.29,48.69
accept The Fragments Within##4813 |goto 47.29,48.69
step
Follow the road |goto 40.91,45.84 < 30 |only if walking
Follow the path |goto 42.91,36.53 < 30 |only if walking
Follow the path up |goto 44.31,36.84 < 15 |only if walking
talk Asterion##3650
accept Bashal'Aran##956 |goto 44.17,36.30
step
kill Deth'ryll Satyr##2212+
collect Ancient Moonstone Seal##5338 |q 956/1 |goto 45.50,36.68
You can find more around: |notinsticky
[45.57,39.70]
[46.75,39.13]
[47.71,36.91]
step
talk Asterion##3650
turnin Bashal'Aran##956 |goto 44.17,36.30
accept Bashal'Aran##957 |goto 44.17,36.30
step
click Buzzbox 411
accept Buzzbox 323##1002 |goto 41.96,28.64
stickystart "Kill_Rabid_Thistle_Bears"
step
Kill Moonstalker enemies around this area
|tip They look like grey tigers.
collect 6 Moonstalker Fang##5413 |q 1002/1 |goto 48.78,26.02
|tip These have a low drop rate.
You can find more around: |notinsticky
[50.64,28.62]
[52.92,27.47]
[44.24,27.17]
[49.22,35.13]
step
label "Kill_Rabid_Thistle_Bears"
kill 20 Rabid Thistle Bear##2164 |q 2138/1 |goto 48.78,26.02
You can find more around: |notinsticky
[50.64,28.62]
[52.92,27.47]
[48.23,32.83]
[44.24,27.17]
step
Kill enemies around this area
Reach Level 16 |ding 16 |goto 48.78,26.02
You can find more around: |notinsticky
[50.64,28.62]
[52.92,27.47]
[48.23,32.83]
[44.24,27.17]
step
click Buzzbox 323
turnin Buzzbox 323##1002 |goto 51.28,24.58
accept Buzzbox 525##1003 |goto 51.28,24.58
step
use the Empty Sampling Tube##12350
|tip In the water, at the bottom of the waterfall.
collect Cliffspring River Sample##12349 |goto 50.84,25.50
step
Follow the path |goto 50.61,23.76 < 20 |only if walking
click Beached Sea Turtle
accept Beached Sea Turtle##4725 |goto 44.23,20.63
step
Swim through the underwater boat window |goto 39.89,27.60 < 3 |walk
click Mist Veil's Lockbox
|tip Inside the sunken ship, at the very bottom.
collect Mist Veil's Lockbox##12192 |q 982/2 |goto 39.63,27.46
step
Swim through the hole in the bottom of the underwater boat |goto 38.73,29.35 < 10 |walk
click Silver Dawning's Lockbox
|tip Inside the sunken ship, at the very bottom.
collect Silver Dawning's Lockbox##12191 |q 982/1 |goto 38.24,28.79
step
Swim through the underwater boat window |goto 38.30,29.31 < 3 |walk
Follow the path |goto 37.52,37.72 < 30 |only if walking
talk Gorbold Steelhand##6301
turnin Deep Ocean, Vast Sea##982 |goto 38.11,41.17
step
Enter the building |goto 37.77,41.35 < 15 |walk
talk Thundris Windweaver##3649
|tip Inside the building.
turnin The Cliffspring River##4762 |goto 37.39,40.13
accept Tools of the Highborne##958 |goto 37.39,40.13
step
Leave the building |goto 37.77,41.35 < 15 |walk
talk Sentinel Glynda Nal'Shea##2930
|tip She walks around this area.
turnin The Fragments Within##4813 |goto 37.70,43.38
step
talk Gwennyth Bly'Leggonde##10219
turnin Beached Sea Turtle##4725 |goto 36.62,45.60
step
talk Tharnariun Treetender##3701
turnin Cleansing of the Infected##2138 |goto 38.84,43.41
accept Tharnariun's Hope##2139 |goto 38.84,43.41
step
Follow the road |goto 40.08,46.71 < 30 |only if walking
talk Sentinel Tysha Moonblade##3639
accept The Fall of Ameth'Aran##953 |goto 40.30,59.73
stickystart "Collect_Anyas_Pendant"
stickystart "Collect_Highborne_Relics"
step
click Lay of Ameth'Aran
Read the Lay of Ameth'Aran |q 953/1 |goto 43.31,58.70
step
click Ancient Flame
Destroy the Seal at the Ancient Flame |q 957/1 |goto 42.37,61.79
step
click Fall of Ameth'Aran
Read the Fall of Ameth'Aran |q 953/2 |goto 42.67,63.10
step
label "Collect_Anyas_Pendant"
kill Anaya Dawnrunner##3667
|tip She looks like a neutral female night elf ghost that walks around this area.
collect Anaya's Pendant##5382 |q 963/1 |goto 42.88,62.51
step
label "Collect_Highborne_Relics"
Kill Highborne enemies around this area
collect 7 Highborne Relic##5360 |q 958/1 |goto 43.07,60.24
step
talk Sentinel Tysha Moonblade##3639
turnin The Fall of Ameth'Aran##953 |goto 40.30,59.73
step
talk Cerellean Whiteclaw##3644
turnin For Love Eternal##963 |goto 35.74,43.71
step
Enter the building |goto 37.77,41.35 < 15 |walk
talk Thundris Windweaver##3649
|tip Inside the building.
turnin Tools of the Highborne##958 |goto 37.40,40.13
step
Follow the path up |goto 37.12,38.44 < 20 |only if walking
Follow the path |goto 42.89,36.55 < 30 |only if walking
Follow the path up |goto 44.29,36.88 < 15 |only if walking
talk Asterion##3650
turnin Bashal'Aran##957 |goto 44.17,36.30
step
Follow the path up |goto 52.40,35.94 < 10 |only if walking
Enter the cave |goto 51.57,37.49 < 15 |walk
kill Den Mother##6788 |q 2139/1 |goto 51.48,38.26
|tip Inside the cave.
stickystart "Collect_Scaber_Stalks"
step
Follow the path up |goto 54.56,31.75 < 15 |only if walking
Enter the cave |goto 54.97,33.37 < 15 |walk
Follow the path up |goto 55.16,33.97 < 10 |walk
click Death Cap
|tip Upstairs inside the cave.
|tip If there's not one here, you can find more downstairs in the side rooms of the cave.
collect Death Cap##5270 |q 947/2 |goto 55.75,36.19
step
label "Collect_Scaber_Stalks"
click Scaber Stalk+
|tip They look like blue mushrooms on the ground around this area inside the cave.
|tip You can find them all throughout the cave.
collect 5 Scaber Stalk##5271 |q 947/1 |goto 55.22,33.92
step
Leave the cave |goto 54.97,33.38 < 15 |c |q 947
step
Kill enemies around this area
Reach Level 17 |ding 17 |goto 52.05,32.15
step
Follow the road |goto 45.45,34.63 < 30 |only if walking
Follow the path |goto 42.10,41.40 < 30 |only if walking
talk Tharnariun Treetender##3701
turnin Tharnariun's Hope##2139 |goto 38.84,43.41
step
talk Barithras Moonshade##3583
turnin Cave Mushrooms##947 |goto 37.32,43.64
step
Enter the building |goto Darnassus 35.49,10.63 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
accept A Lesson to Learn##27 |goto Darnassus 35.37,8.39
|only if NightElf Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin A Lesson to Learn##27 |goto Moonglade 56.21,30.64
accept Trial of the Lake##29 |goto Moonglade 56.21,30.64
|only if NightElf Druid
step
click Bauble Container
|tip It looks like a wicker basket vase on the ground underwater.
|tip They spawn randomly, so you may have to search around this area.
collect Shrine Bauble##15877 |q 29/1 |goto 54.33,55.65
|only if NightElf Druid
step
use the Shrine Bauble##15877
Complete the Trial of the Lake |q 29/2 |goto 35.92,41.38
|only if NightElf Druid
step
talk Tajarri##11799
turnin Trial of the Lake##29 |goto 36.51,40.11
accept Trial of the Sea Lion##272 |goto 36.51,40.11
|only if NightElf Druid
step
Follow the road |goto Darkshore 40.23,46.41 < 30 |only if walking
Follow the path |goto Darkshore 48.43,24.86 < 30 |only if walking
click Strange Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Agility##15883 |goto Darkshore 48.87,11.32 |q 272
|only if NightElf Druid
step
click Strange Lockbox
|tip Underwater.
collect Half Pendant of Aquatic Endurance##15882 |goto Westfall 17.87,33.11 |q 272
|only if NightElf Druid
step
use the Half Pendant of Aquatic Agility##15883
collect Pendant of the Sea Lion##15885 |q 272/1 |goto Moonglade 35.92,41.42
|only if NightElf Druid
step
talk Dendrite Starblaze##11802
|tip Upstairs inside the building.
turnin Trial of the Sea Lion##272 |goto 56.21,30.64
accept Aquatic Form##5061 |goto 56.21,30.64
|only if NightElf Druid
step
Enter the building |goto Darnassus 35.49,10.63 < 15 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Aquatic Form##5061 |goto Darnassus 35.37,8.39
|only if NightElf Druid
stickystart "Kill_Defias_Looters"
step
kill 15 Defias Pillager##589 |q 13/1 |goto Westfall 44.91,69.38
step
label "Kill_Defias_Looters"
kill 15 Defias Looter##590 |q 13/2 |goto 44.91,69.38
step
talk Gryan Stoutmantle##234
turnin The People's Militia##13 |goto 56.33,47.52
accept The People's Militia##14 |goto 56.33,47.52
accept The Defias Brotherhood##65 |goto 56.33,47.52
step
Enter the building |goto 53.00,53.36 < 10 |walk
talk Innkeeper Heather##8931
|tip Inside the building.
home Sentinel Hill |goto 52.86,53.71
stickystart "Kill_Defias_Knuckledusters"
stickystart "Kill_Defias_Highwaymen"
step
Leave the building |goto 53.00,53.36 < 7 |walk
kill 5 Defias Pathstalker##121 |q 14/2 |goto 52.23,73.48
You can find more around: |notinsticky
[52.53,78.60]
[46.39,79.07]
step
label "Kill_Defias_Knuckledusters"
kill 5 Defias Knuckleduster##449 |q 14/3 |goto 52.23,73.48
You can find more around: |notinsticky
[52.53,78.60]
[46.39,79.07]
step
label "Kill_Defias_Highwaymen"
kill 15 Defias Highwayman##122 |q 14/1 |goto 52.23,73.48
You can find more around: |notinsticky
[52.53,78.60]
[46.39,79.07]
step
Leave the building |goto 53.00,53.36 < 7 |walk
talk Gryan Stoutmantle##234
turnin The People's Militia##14 |goto 56.33,47.52
step
Enter the building |goto Loch Modan 35.23,47.74 < 10 |walk
talk Innkeeper Hearthstove##6734
|tip Inside the building.
home Stoutlager Inn |goto Loch Modan 35.53,48.40
step
Leave the building |goto 35.23,47.74 < 10 |walk
Enter the building |goto 37.18,47.10 < 10 |walk
talk Jern Hornhelm##1105
|tip Downstairs inside the building.
|tip He sometimes walks out near the entrance of the building.
accept Ironband's Excavation##436 |goto 37.24,47.39
step
Leave the building |goto 37.17,47.06 < 7 |walk
Follow the path |goto 45.06,64.15 < 30 |only if walking
talk Magmar Fellhew##1345
turnin Ironband's Excavation##436 |goto 64.90,66.65
accept Gathering Idols##297 |goto 64.90,66.65
step
talk Prospector Ironband##1344
accept Excavation Progress Report##298 |goto 65.93,65.62
step
Follow the path |goto 67.77,63.14 < 20 |only if walking
Kill enemies around this area
collect 8 Carved Stone Idol##2636 |q 297/1 |goto 70.31,62.79
step
talk Magmar Fellhew##1345
turnin Gathering Idols##297 |goto 64.90,66.65
step
Kill enemies around this area
Reach Level 18 |ding 18 |goto 67.77,63.14
step
Follow the path |goto 66.22,52.81 < 30 |only if walking
Continue following the path |goto 80.19,59.08 < 30 |only if walking
Enter the building |goto 83.43,62.83 < 15 |walk
talk Marek Ironheart##1154
|tip Inside the building.
accept Crocolisk Hunting##385 |goto 81.75,61.66
step
talk Daryl the Youngling##1187
|tip Inside the building.
accept A Hunter's Boast##257 |goto 83.47,65.46
step
kill 6 Mountain Buzzard##1194 |q 257/1 |goto 80.20,65.20
|tip Try to hurry, this quest is timed.
You can find more around: |notinsticky
[77.04,57.34]
[76.41,73.71]
[74.40,69.25]
step
Follow the path |goto 80.99,59.40 < 30 |only if walking
Enter the building |goto 83.43,62.83 < 15 |walk
talk Daryl the Youngling##1187
|tip Inside the building.
|tip Try to hurry, this quest is timed.
turnin A Hunter's Boast##257 |goto 83.47,65.46
accept A Hunter's Challenge##258 |goto 83.47,65.46
step
Follow the path |goto 78.83,58.75 < 30 |only if walking
Continue following the path |goto 72.32,51.87 < 30 |only if walking
Continue following the path |goto 69.49,50.18 < 30 |only if walking
kill 5 Elder Mountain Boar##1192 |q 258/1 |goto 61.88,38.22
|tip Try to hurry, this quest is timed.
You can find more around: |notinsticky
[63.55,38.14]
step
Follow the path |goto 69.49,50.18 < 30 |only if walking
Continue following the path |goto 75.93,55.02 < 30 |only if walking
Enter the building |goto 83.43,62.83 < 15 |walk
talk Daryl the Youngling##1187
|tip Inside the building.
|tip Try to hurry, this quest is timed.
turnin A Hunter's Challenge##258 |goto 83.47,65.46
step
Follow the path |goto 79.02,58.78 < 30 |only if walking
talk Bingles Blastenheimer##6577
accept Bingles' Missing Supplies##2038 |goto 63.56,47.92
stickystart "Collect_Crocolisk_Skin"
step
kill Loch Crocolisk##1693+
collect 5 Crocolisk Meat##2924 |q 385/1 |goto 54.84,38.49
You can find more around [54.80,54.28]
step
label "Collect_Crocolisk_Skin"
kill Loch Crocolisk##1693+
collect 6 Crocolisk Skin##2925 |q 385/2 |goto 54.84,38.49
You can find more around [54.80,54.28]
step
click Bingles's Toolbucket
collect Bingles' Wrench##7343 |q 2038/1 |goto 48.73,30.09
step
click Bingles' Blastencapper
collect Bingles' Blastencapper##7376 |q 2038/4 |goto 54.21,26.60
step
click Bingles's Toolbucket
collect Bingles' Hammer##7346 |q 2038/3 |goto 51.78,24.09
step
click Bingles' Toolbucket
collect Bingles' Screwdriver##7345 |q 2038/2 |goto 48.37,20.51
step
Run up the ramp |goto 55.39,14.84 < 10 |only if walking
Follow the path |goto 52.89,10.99 < 10 |only if walking
talk Chief Engineer Hinderweir VII##1093
accept A Dark Threat Looms##250 |goto 46.05,13.62
step
click Suspicious Barrel
|tip On the ground next the wall.
turnin A Dark Threat Looms##250 |goto 56.05,13.24
accept A Dark Threat Looms##199 |goto 56.05,13.24
step
Run up the ramp |goto 55.39,14.84 < 10 |only if walking
Follow the path |goto 52.89,10.99 < 10 |only if walking
talk Chief Engineer Hinderweir VII##1093
turnin A Dark Threat Looms##199 |goto 46.05,13.62
step
talk Bingles Blastenheimer##6577
turnin Bingles' Missing Supplies##2038 |goto 63.56,47.91
step
Follow the path |goto 72.32,52.39 < 30 |only if walking
Enter the building |goto 83.43,62.83 < 15 |walk
talk Marek Ironheart##1154
|tip Inside the building.
turnin Crocolisk Hunting##385 |goto 81.76,61.66
step
Leave the building |goto 35.20,47.74 < 7 |walk
Enter the building |goto 37.18,47.10 < 7 |walk
talk Jern Hornhelm##1105
|tip Downstairs inside the building.
|tip He sometimes walks out near the entrance of the building.
turnin Excavation Progress Report##298 |goto 37.24,47.39
accept Report to Ironforge##301 |goto 37.24,47.39
step
Leave the building |goto 37.18,47.10 < 5 |walk
talk Prospector Stormpike##1356
|tip Inside the building.
turnin Report to Ironforge##301 |goto Ironforge 74.64,11.73
step
Run up the ramp |goto Stormwind City 72.15,80.66 < 15 |only if walking
Leave Stormwind City |goto Stormwind City 69.64,85.51 < 20 |only if walking
Follow the road |goto Elwynn Forest 42.77,67.31 < 30 |only if walking
Enter Redridge Mountains |goto 92.00,72.75 < 30 |only if walking
talk Guard Parker##464
accept Encroaching Gnolls##244 |goto Redridge Mountains 15.27,71.46
step
Kill enemies around this area
Reach Level 19 |ding 19 |goto 15.97,63.60
You can find more around [27.42,80.17]
step
talk Deputy Feldon##1070
turnin Encroaching Gnolls##244 |goto 30.74,60.00
accept Assessing the Threat##246 |goto 30.74,60.00
step
talk Ariena Stormfeather##931
fpath Lakeshire |goto 30.59,59.41
step
talk Marshal Marris##382
accept Blackrock Menace##20 |goto 33.51,48.97
step
talk Foreman Oslow##341
accept The Lost Tools##125 |goto 32.14,48.64
step
talk Verner Osgood##415
accept The Price of Shoes##118 |goto 30.98,47.28
step
talk Shawn##8965
accept Hilary's Necklace##3741 |goto 29.32,53.63
step
click Glinting Mound
|tip It looks like a brown pile of dirt on the ground underwater.
|tip It spawns in random locations in the water, so you may need to search around.
collect Hilary's Necklace##10958 |q 3741/1 |goto 19.17,51.76
Also check around [38.03,54.49]
step
click Sunken Chest
|tip Underwater.
collect Oslow's Toolbox##1309 |q 125/1 |goto 41.53,54.67
step
talk Foreman Oslow##341
turnin The Lost Tools##125 |goto 32.14,48.64
accept The Everstill Bridge##89 |goto 32.14,48.64
step
talk Hilary##8962
turnin Hilary's Necklace##3741 |goto 29.24,53.63
step
Enter the building |goto 29.50,46.12 < 10 |walk
talk Bailiff Conacher##900
|tip Inside the building.
accept Solomon's Law##91 |goto 29.72,44.26
step
Leave the building |goto 29.50,46.14 < 10 |walk
talk Dockmaster Baren##381
accept Selling Fish##127 |goto 27.72,47.38
step
Enter the building |goto 26.61,46.37 < 10 |walk
talk Innkeeper Brianna##6727
|tip Inside the building.
home Lakeshire |goto 27.01,44.82
step
talk Darcy##379
|tip She walks around this area inside the building.
accept A Free Lunch##129 |goto 26.75,44.35
step
talk Wiley the Black##266
|tip Upstairs inside the building.
turnin The Defias Brotherhood##65 |goto 26.48,45.35
accept The Defias Brotherhood##132 |goto 26.48,45.35
step
Leave the building |goto 26.61,46.37 < 10 |walk
Enter the building |goto 22.80,44.56 < 10 |walk
talk Chef Breanna##343
|tip Inside the building.
accept Redridge Goulash##92 |goto 22.68,43.84
step
Leave the building |goto 22.81,44.54 < 7 |walk
talk Martie Jainrose##342
accept An Unwelcome Guest##34 |goto 21.86,46.33
step
Follow the path up |goto 21.77,60.12 < 20 |only if walking
talk Guard Parker##464
turnin A Free Lunch##129 |goto 15.27,71.45
accept Visit the Herbalist##130 |goto 15.27,71.45
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##132 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##135 |goto Westfall 56.33,47.52
step
Follow the path |goto Stormwind City 74.69,53.64 < 10 |walk
Enter the building |goto Stormwind City/0 77.14,58.04 < 10 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin The Defias Brotherhood##135 |goto Stormwind City 75.78,59.84
accept The Defias Brotherhood##141 |goto Stormwind City 75.78,59.84
step
Leave the building |goto 77.14,58.04 < 7 |walk
Follow the path |goto 74.69,53.64 < 10 |walk
Run up the ramp |goto 62.44,62.33 < 10 |only if walking
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##141 |goto Westfall 56.33,47.52
accept The Defias Brotherhood##142 |goto Westfall 56.33,47.52
step
Run up the ramp |goto Stormwind City 72.14,80.77 < 15 |only if walking
Leave Stormwind City |goto Stormwind City 69.93,85.00 < 20 |only if walking
Enter the building |goto Elwynn Forest 41.85,65.68 < 10 |walk
talk Smith Argus##514
|tip Inside the building.
turnin The Price of Shoes##118 |goto Elwynn Forest 41.70,65.55
accept Return to Verner##119 |goto Elwynn Forest 41.70,65.55
step
Leave the building |goto Redridge Mountains 26.61,46.38 < 10 |walk
talk Martie Jainrose##342
turnin Visit the Herbalist##130 |goto Redridge Mountains 21.86,46.33
accept Delivering Daffodils##131 |goto Redridge Mountains 21.86,46.33
step
Enter the building |goto 26.60,46.38 < 10 |walk
talk Darcy##379
|tip She walks around this area inside the building.
turnin Delivering Daffodils##131 |goto 26.75,44.34
step
Leave the building |goto 26.61,46.38 < 10 |walk
talk Verner Osgood##415
turnin Return to Verner##119 |goto 30.98,47.27
accept Underbelly Scales##122 |goto 30.98,47.27
accept A Baying of Gnolls##124 |goto 30.98,47.27
stickystart "Collect_Great_Gortusk_Snouts"
stickystart "Collect_Crisp_Spider_Meat"
step
kill Black Dragon Whelp##441+
collect 6 Underbelly Whelp Scale##1221 |q 122/1 |goto 35.34,71.20
You can find more around: |notinsticky
[29.57,75.26]
[47.12,76.91]
step
label "Collect_Great_Gortusk_Snouts"
kill Great Goretusk##547+
|tip If you go to the western area, be careful to avoid Bellygrub.
|tip It's a level 24 boar that walks around that area.
collect 5 Great Goretusk Snout##2296 |q 92/1 |goto 35.34,71.20
|tip Be careful not to accidentally sell these to a vendor.
You can find more around: |notinsticky
[29.57,75.26]
[25.89,59.27]
[15.82,52.97]
step
label "Collect_Crisp_Spider_Meat"
kill Tarantula##442+
collect 5 Crisp Spider Meat##1081 |q 92/3 |goto 20.28,68.29
|tip Be careful not to accidentally sell these to a vendor.
You can find more around [14.40,77.92]
stickystart "Kill_Redridge_Mongrels"
step
kill 6 Redridge Poacher##424 |q 246/2 |goto 31.47,81.01
You can find more around [43.02,71.64]
step
label "Kill_Redridge_Mongrels"
kill 10 Redridge Mongrel##423 |q 246/1 |goto 31.47,81.01
You can find more around [43.02,71.64]
step
talk Deputy Feldon##1070
turnin Assessing the Threat##246 |goto 30.73,60.00
step
talk Verner Osgood##415
turnin Underbelly Scales##122 |goto 30.97,47.27
step
Kill enemies around this area
Reach Level 20 |ding 20 |goto 33.96,71.57
You can find more around [30.46,80.86]
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
Click Here to Continue |confirm |q 2607 |future
|only if Rogue
stickystart "Collect_Murloc_Fins"
step
Follow the path |goto Redridge Mountains/0 39.88,76.26 < 40 |only if walking
Kill Murloc enemies around this area
|tip You can find more in the water nearby.
collect 10 Spotted Sunfish##1467 |q 127/1 |goto Redridge Mountains 49.00,72.02
step
label "Collect_Murloc_Fins"
Kill Murloc enemies around this area
collect 8 Murloc Fin##1468 |goto 49.00,72.02 |q 150 |future
|tip Be careful not to accidentally sell these to a vendor.
step
kill Dire Condor##428+
collect 5 Tough Condor Meat##1080 |q 92/2 |goto 58.04,75.72
You can find more around [47.23,76.89]
step
Follow the path |goto 62.71,76.95 < 30 |only if walking
Kill Blackrock enemies around this area
collect 10 Battleworn Axe##3014 |q 20/1 |goto 71.90,79.39
You can find more around [76.41,74.07]
step
Leave the building |goto 26.61,46.36 < 10 |walk
Enter the building |goto 22.81,44.55 < 10 |walk
talk Chef Breanna##343
|tip Inside the building.
turnin Redridge Goulash##92 |goto 22.68,43.83
step
Leave the building |goto 22.80,44.54 < 10 |walk
talk Dockmaster Baren##381
turnin Selling Fish##127 |goto 27.72,47.38
accept Murloc Poachers##150 |goto 27.72,47.38
step
talk Dockmaster Baren##381
turnin Murloc Poachers##150 |goto 27.72,47.38
step
talk Marshal Marris##382
turnin Blackrock Menace##20 |goto 33.51,48.97
step
talk Lago Blackwrench##6120
accept Gakin's Summons##1685 |goto Ironforge 47.62,9.26
|only if Warlock
step
Enter the building |goto Stormwind City 29.14,74.17 < 15 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Gakin's Summons##1685 |goto Stormwind City 25.26,78.56
accept Devourer of Souls##1507 |goto Stormwind City 25.26,78.56
|only if Warlock
step
Leave the building |goto Stormwind City 29.14,74.17 < 10 |walk
Follow the road |goto Darkshore 39.98,47.69 < 30 |only if walking
Enter Ashenvale |goto Darkshore 43.05,93.50 < 30 |only if walking
Follow the road |goto Ashenvale 29.63,17.12 < 30 |only if walking
talk Daelyshia##4267
fpath Astranaar |goto Ashenvale 34.41,47.99
|only if Warlock
step
Follow the road |goto 38.91,57.93 < 30 |only if walking
Follow the road |goto 67.13,71.87 < 30 |only if walking
Enter the Barrens |goto The Barrens 48.99,5.39 < 20 |only if walking
Follow the road |goto The Barrens 48.55,13.02 < 30 |only if walking
Avoid the Crossroads |goto The Barrens 53.91,30.00 < 30 |only if walking
Follow the road |goto The Barrens 50.43,37.77 < 30 |only if walking
talk Takar the Seer##6244
turnin Devourer of Souls##1507 |goto The Barrens 49.31,57.10
accept Heartswood##1738 |goto The Barrens 49.31,57.10
|only if Warlock
step
Follow the road |goto 51.03,50.04 < 30 |only if walking
Avoid the Crossroads |goto 53.68,29.52 < 30 |only if walking
Follow the road |goto 51.18,15.34 < 30 |only if walking
Enter Ashenvale |goto 48.98,5.37 < 20 |only if walking
Follow the road |goto Ashenvale 68.53,84.01 < 30 |only if walking
Continue following the road |goto Ashenvale 66.87,71.29 < 30 |only if walking
Follow the path |goto Ashenvale 26.14,35.41 < 30 |only if walking
click Heartswood
collect Heartswood##6912 |q 1738/1 |goto Ashenvale 31.49,31.45
|only if Warlock
step
Follow the road |goto 25.58,36.45 < 30 |only if walking
Enter the building |goto Stormwind City 29.14,74.17 < 15 |walk
talk Gakin the Darkbinder##6122
|tip Downstairs inside the building.
turnin Heartswood##1738 |goto Stormwind City 25.26,78.56
accept The Binding##1739 |goto Stormwind City 25.26,78.56
|only if Warlock
step
Follow the path down |goto 24.96,79.42 < 7 |walk
Run down the stairs |goto 24.30,78.63 < 7 |walk
Run down the stairs |goto 26.16,79.32 < 7 |walk
use the Heartswood Core##6913
|tip Use it while standing on the pink symbol on the ground.
|tip Downstairs inside the building, inside the crypt.
kill Summoned Succubus##5677 |q 1739/1 |goto 25.11,77.46
|only if Warlock
step
Follow the path up |goto 26.03,79.83 < 7 |walk
Run up the stairs |goto 23.31,79.68 < 7 |walk
talk Gakin the Darkbinder##6122
|tip Upstairs inside the building, in the basement above the crypt.
turnin The Binding##1739 |goto 25.25,78.56
|only if Warlock
step
Leave the building |goto 29.14,74.17 < 10 |c |q 89
|only if Warlock
stickystart "Collect_Iron_Rivets"
stickystart "Kill_Redridge_Brutes"
stickystart "Kill_Redridge_Mystics"
step
Follow the path up |goto Redridge Mountains 34.92,40.80 < 20 |only if walking
Kill Redridge enemies around this area
|tip Redridge Alphas will not drop the quest item.
collect 5 Iron Pike##2856 |q 89/1 |goto 38.80,32.27
You can find more around: |notinsticky
[34.07,26.10]
[29.21,30.21]
[23.02,36.55]
step
label "Collect_Iron_Rivets"
Kill Redridge enemies around this area
|tip Redridge Alphas will not drop the quest item.
collect 5 Iron Rivet##1013 |q 89/2 |goto 38.80,32.27
You can find more around: |notinsticky
[34.07,26.10]
[29.21,30.21]
[23.02,36.55]
step
label "Kill_Redridge_Brutes"
kill 10 Redridge Brute##426 |q 124/1 |goto 38.80,32.27
You can find more around: |notinsticky
[34.07,26.10]
[29.21,30.21]
[23.02,36.55]
step
label "Kill_Redridge_Mystics"
kill 8 Redridge Mystic##430 |q 124/2 |goto 38.80,32.27
You can find more around: |notinsticky
[34.07,26.10]
[29.21,30.21]
[23.02,36.55]
step
talk Foreman Oslow##341
turnin The Everstill Bridge##89 |goto 32.14,48.64
step
talk Verner Osgood##415
turnin A Baying of Gnolls##124 |goto 30.97,47.27
step
Enter the building |goto Westfall 53.00,53.36 < 10 |walk
talk Innkeeper Heather##8931
|tip Inside the building.
home Sentinel Hill |goto Westfall 52.86,53.72
step
Leave the building |goto 53.00,53.36 < 7 |walk
kill Defias Messenger##550
|tip He walks along the road between Jangolode Mine and Moonbrook.
|tip He walks into Gold Coast Quarry before traveling to either Jangolode Mine or Moonbrook.
|tip Run on the road while looking for him.
|tip He spawns around this location, so it may be easier to kill enemies around this area, waiting for him to either spawn or walk here.
collect A Mysterious Message##1381 |q 142/1 |goto 45.86,67.81
Also check around:
[37.79,44.43]
[30.42,42.34]
[44.44,25.91]
step
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##142 |goto 56.33,47.52
step
talk The Defias Traitor##467
|tip If he is not here, you will have to wait for someone to finish escorting him.
accept The Defias Brotherhood##155 |goto 55.68,47.50
step
Watch the dialogue
|tip Follow the Defias Traitor and protect him as he walks.
|tip He eventually walks to this location.
Escort The Defias Traitor to Discover Where VanCleef is Hiding |q 155/1 |goto 42.54,71.69
step
talk Captain Grayson##392
accept Keeper of the Flame##103 |goto 30.02,86.02
step
talk Captain Grayson##392
turnin Keeper of the Flame##103 |goto 30.02,86.02
accept The Coastal Menace##104 |goto 30.02,86.02
step
kill Old Murk-Eye##391
|tip He walks along the beach around this area.
collect Scale of Old Murk-Eye |q 104/1 |goto 26.61,66.94
Also check around [34.95,84.87]
step
talk Captain Grayson##392
turnin The Coastal Menace##104 |goto 30.02,86.02
step
Kill enemies around this area
Reach Level 21 |ding 21 |goto 34.95,84.87
You can find more around [26.61,66.94]
step
Leave the building |goto 53.00,53.36 < 5 |walk
talk Gryan Stoutmantle##234
turnin The Defias Brotherhood##155 |goto 56.33,47.52
step
talk Innkeeper Shaussiy##6737
|tip Inside the building.
home Auberdine |goto Darkshore 37.04,44.13
step
click WANTED: Murkdeep!
accept WANTED: Murkdeep!##4740 |goto 37.23,44.23
step
talk Barithras Moonshade##3583
accept Onu##948 |goto 37.32,43.64
step
talk Archaeologist Hollee##2913
accept The Absent Minded Prospector##729 |goto 37.44,41.84
step
talk Terenthis##3693
|tip Inside the building.
accept A Lost Master##986 |goto 39.37,43.48
step
talk Sentinel Elissa Starbreeze##3657
|tip Upstairs inside the building.
accept The Tower of Althalaxx##965 |goto 39.05,43.55
step
Follow the road |goto 40.28,46.38 < 30 |only if walking
talk Balthule Shadowstrike##3661
turnin The Tower of Althalaxx##965 |goto 54.97,24.89
accept The Tower of Althalaxx##966 |goto 54.97,24.89
step
kill Dark Strand Fanatic##2336+
collect 4 Worn Parchment##5348 |q 966/1 |goto 55.46,26.77
step
talk Balthule Shadowstrike##3661
turnin The Tower of Althalaxx##966 |goto 54.97,24.89
accept The Tower of Althalaxx##967 |goto 54.97,24.89
step
Follow the road |goto 51.43,24.76 < 30 |only if walking
Continue following the road |goto 40.06,46.75 < 30 |only if walking
Follow the path |goto 41.87,76.70 < 30 |only if walking
talk Onu##3616
turnin Onu##948 |goto 43.55,76.29
accept The Master's Glaive##944 |goto 43.55,76.29
stickystart "Collect_Grizzled_Scalps"
step
Kill Moonstalker enemies around this area
collect 5 Fine Moonstalker Pelt##5386 |q 986/1 |goto 43.52,81.93
You can find more around: |notinsticky
[40.33,81.60]
[41.22,84.67]
step
label "Collect_Grizzled_Scalps"
kill Grizzled Thistle Bear##2165+
collect 4 Grizzled Scalp##5414 |q 1003/1 |goto 40.33,81.60
step
Enter the Master's Glaive |q 944/1 |goto 38.57,86.30
step
use the Phial of Scrying##5251
click Scrying Bowl
|tip It appears on the ground next to you.
turnin The Master's Glaive##944 |goto 38.53,86.17
|tip You can destroy the "Phial of Scrying" item after turning in this quest.
accept The Twilight Camp##949 |goto 38.53,86.17
step
click Twilight Tome
turnin The Twilight Camp##949 |goto 38.54,86.05
accept Return to Onu##950 |goto 38.54,86.05
step
talk Therylune##3584
|tip She walks around this area.
accept Therylune's Escape##945 |goto 38.64,87.34
step
Watch the dialogue
|tip Follow Therylune and protect her as she walks.
|tip She eventually walks to this location.
Escort Therylune Away from the Master's Glaive |q 945/1 |goto 40.40,86.37
step
talk Prospector Remtravel##2917
turnin The Absent Minded Prospector##729 |goto 35.73,83.70
accept The Absent Minded Prospector##731 |goto 35.73,83.70
step
Watch the dialogue
|tip Follow Prospector Remtravel and protect him as he walks.
|tip He is very weak and can die easily, so get the enemies off of him quickly.
|tip He eventually walks back to this location.
Escort Prospector Remtravel |q 731/1 |goto 35.74,83.74
step
Follow the path |goto 35.46,83.22 < 20 |only if walking
click Beached Sea Creature
accept Beached Sea Creature##4733 |goto 31.27,87.42
step
click Beached Sea Turtle
accept Beached Sea Turtle##4732 |goto 31.24,85.63
step
click Beached Sea Turtle
accept Beached Sea Turtle##4731 |goto 31.69,83.72
step
click Beached Sea Creature
accept Beached Sea Creature##4730 |goto 32.66,80.81
step
Kill Greymist enemies around this area
|tip Groups of murlocs will appear near the water and run into the camp.
|tip Kill them to get Murkdeep to appear.
kill Murkdeep##10323 |q 4740/1 |goto 36.51,76.59
step
click Buzzbox 525
turnin Buzzbox 525##1003 |goto 41.40,80.56
step
talk Onu##3616
turnin Return to Onu##950 |goto 43.56,76.29
step
Watch the dialogue
talk Onu##3616
accept Mathystra Relics##951 |goto 43.56,76.29
step
talk Kerlonian Evershade##11218
accept The Sleeper Has Awakened##5321 |goto 44.39,76.43
step
click Kerlonian's Chest
collect Horn of Awakening##13536 |q 5321/2 |goto 44.38,76.31
stickystart "Escort_Kerlonian_Evershade"
step
Follow the road |goto 41.66,76.98 < 30 |only if walking
Follow the path |goto 40.74,86.36 < 30 |only if walking
Follow the path up |goto 45.45,90.70 < 10 |only if walking
talk Sentinel Aynasha##11711
accept One Shot. One Kill.##5713 |goto 45.94,90.29
step
Watch the dialogue
Kill the enemies that attack in waves
kill Marosh the Devious##11714
|tip He will attack after the second wave of enemies
Protect Aynasha |q 5713/1 |goto 45.94,90.29
|tip It may take a minute to complete after killing him.
step
label "Escort_Kerlonian_Evershade"
Enter Ashenvale and follow the road |goto 43.49,94.32 < 30 |only if walking
Enter the building |goto Ashenvale 26.87,36.65 < 10 |walk
Escort Kerlonian Evershade to Maestra's Post |q 5321/2 |goto Ashenvale 27.15,35.92
|tip Kerlonian Evershade will follow you.
|tip He will sometimes stop walking and fall asleep.
|tip Make sure he is next to you at all times.
|tip Avoid walking on the road, or you will get ambushed by groups of enemies.
|tip You can still follow the road, but stay in the forest on the sides.
|tip Lead Kerlonian Evershade to this location inside the building.
|tip Try to hurry, this quest is timed.
step
talk Liladris Moonriver##11219
|tip On the balcony of the building.
turnin The Sleeper Has Awakened##5321 |goto 27.26,35.58
step
Leave the building |goto 26.87,36.66 < 10 |only if walking
talk Sentinel Onaeya##11806
turnin One Shot. One Kill.##5713 |goto 26.60,36.73
step
talk Delgren the Purifier##3663
turnin The Tower of Althalaxx##967 |goto 26.20,38.70
accept The Tower of Althalaxx##970 |goto 26.20,38.70
step
talk Orendil Broadleaf##3847
accept Bathran's Hair##1010 |goto 26.44,38.59
step
Kill Dark Strand enemies around this area
collect Glowing Soul Gem##5366 |q 970/1 |goto 31.39,30.62
step
click Plant Bundle+
|tip They look like small piles of grey straw on the ground around this area.
|tip They can respawn fairly quickly.
collect 5 Bathran's Hair##5437 |q 1010/1 |goto 30.44,24.05
You can find more around: |notinsticky
[31.75,22.70]
[32.29,21.79]
step
Kill enemies around this area
Reach Level 22 |ding 22 |goto 31.68,22.52
step
talk Orendil Broadleaf##3847
turnin Bathran's Hair##1010 |goto 26.44,38.59
accept Orendil's Cure##1020 |goto 26.44,38.59
step
talk Delgren the Purifier##3663
turnin The Tower of Althalaxx##970 |goto 26.20,38.70
accept The Tower of Althalaxx##973 |goto 26.20,38.70
step
Follow the road |goto 25.53,38.43 < 20 |only if walking
Follow the path down |goto 25.77,47.09 < 20 |only if walking
talk Therysil##3585
turnin Therylune's Escape##945 |goto 22.65,51.91
step
Follow the road |goto 26.16,46.68 < 20 |c |q 1008 |future
step
talk Daelyshia##4267
fpath Astranaar |goto 34.41,47.99
step
talk Gwennyth Bly'Leggonde##10219
turnin Beached Sea Creature##4730 |goto Darkshore 36.62,45.59
turnin Beached Sea Turtle##4731 |goto Darkshore 36.62,45.59
turnin Beached Sea Turtle##4732 |goto Darkshore 36.62,45.59
turnin Beached Sea Creature##4733 |goto Darkshore 36.62,45.59
step
talk Sentinel Glynda Nal'Shea##2930
turnin WANTED: Murkdeep!##4740 |goto 37.71,43.39
step
talk Terenthis##3693
|tip Inside the building.
turnin A Lost Master##986 |goto 39.37,43.48
accept A Lost Master##993 |goto 39.37,43.48
step
talk Archaeologist Hollee##2913
turnin The Absent Minded Prospector##731 |goto 37.44,41.84
accept The Absent Minded Prospector##741 |goto 37.44,41.84
step
talk Shindrell Swiftfire##3845
accept The Zoram Strand##1008 |goto Ashenvale 34.67,48.84
step
talk Sentinel Thenysil##4079
accept On Guard in Stonetalon##1070 |goto 34.89,49.79
step
talk Faldreas Goeth'Shael##3996
accept Journey to Stonetalon Peak##1056 |goto 35.77,49.10
step
talk Raene Wolfrunner##3691
|tip Inside the building.
accept Raene's Cleansing##991 |goto 36.62,49.58
accept Culling the Threat##1054 |goto 36.62,49.58
step
talk Innkeeper Kimlya##6738
|tip Upstairs inside the building.
home Astranaar |goto 36.99,49.22
step
Enter the building |goto 37.20,51.86 < 7 |walk
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin Orendil's Cure##1020 |goto 37.37,51.79
step
Watch the dialogue
talk Pelturas Whitemoon##3894
|tip Inside the building.
accept Elune's Tear##1033 |goto 37.37,51.79
step
Leave the building |goto 37.20,51.86 < 5 |walk
Follow the road |goto 32.70,47.09 < 30 |only if walking
Follow the path |goto 25.43,39.20 < 30 |only if walking
click Teronis' Corpse
turnin Raene's Cleansing##991 |goto 20.31,42.33
accept Raene's Cleansing##1023 |goto 20.31,42.33
|tip You can destroy the "Teronis' Journal" item after accepting this quest.
step
Kill Saltspittle enemies around this area
collect Glowing Gem##5463 |q 1023/1 |goto 20.31,42.33
|tip This has a low drop rate.
step
Follow the path |goto 18.45,32.56 < 30 |only if walking
talk Talen##3846
accept The Ancient Statuette##1007 |goto 14.79,31.30
stickystart "Collect_Wrathtail_Heads"
step
click Ancient Statuette
collect Ancient Statuette##5424 |q 1007/1 |goto 14.20,20.64
step
talk Talen##3846
turnin The Ancient Statuette##1007 |goto 14.79,31.30
step
Watch the dialogue
talk Talen##3846
accept Ruuzel##1009 |goto 14.79,31.30
step
kill Ruuzel##3943
|tip She looks like a green naga with pink fins.
|tip She walks clockwise near the water around this small island.
|tip She has 2 bodyguards with her.
collect Ring of Zoram##5445 |q 1009/1 |goto 6.58,13.46
step
talk Talen##3846
turnin Ruuzel##1009 |goto 14.79,31.30
step
label "Collect_Wrathtail_Heads"
Kill Wrathtail enemies around this area
collect 20 Wrathtail Head##5490 |q 1008/1 |goto 13.16,29.67
You can find more around: |notinsticky
[14.91,21.45]
[13.89,15.26]
step
Kill enemies around this area
Reach Level 23 |ding 23 |goto 13.16,29.67
You can find more around: |notinsticky
[14.91,21.45]
[13.89,15.26]
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Raene's Cleansing##1023 |goto 36.62,49.58
accept Raene's Cleansing##1024 |goto 36.62,49.58
accept An Aggressive Defense##1025 |goto 36.62,49.58
step
talk Shindrell Swiftfire##3845
turnin The Zoram Strand##1008 |goto 34.67,48.84
accept Pridewings of Stonetalon##1134 |goto 34.67,48.84
step
Follow the path up |goto 41.60,50.11 < 20 |only if walking
Continue up the path |goto 43.57,45.62 < 30 |only if walking
click Elune's Tear+
|tip They look like white balls on the ground around this area.
collect Elune's Tear##5493 |q 1033/1 |goto 46.24,45.96
step
Follow the path up |goto 46.82,48.96 < 15 |only if walking
Follow the path |goto 51.37,45.68 < 30 |only if walking
talk Shael'dryn##3916
|tip She walks around this area.
turnin Raene's Cleansing##1024 |goto 53.54,46.29
accept Raene's Cleansing##1026 |goto 53.54,46.29
stickystart "Kill_Foulweald_Ursas"
stickystart "Kill_Foulweald_Totemics"
stickystart "Kill_Foulweald_Warriors"
step
Follow the path |goto 51.05,45.80 < 30 |only if walking
Follow the path down |goto 51.22,58.48 < 20 |only if walking
kill Foulweald Den Watcher##3746 |q 1025/1 |goto 50.44,61.25
You can find more around [55.84,62.92]
step
label "Kill_Foulweald_Ursas"
kill 2 Foulweald Ursa##3749 |q 1025/2 |goto 50.44,61.25
You can find more around [55.84,62.92]
step
label "Kill_Foulweald_Totemics"
kill 10 Foulweald Totemic##3750 |q 1025/3 |goto 50.44,61.25
You can find more around [55.84,62.92]
step
label "Kill_Foulweald_Warriors"
kill 12 Foulweald Warrior##3743 |q 1025/4 |goto 50.44,61.25
You can find more around [55.84,62.92]
step
Follow the road |goto 53.42,58.57 < 30 |only if walking
Enter the building |goto 37.20,51.86 < 7 |walk
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin Elune's Tear##1033 |goto 37.37,51.79
step
Watch the dialogue
talk Pelturas Whitemoon##3894
|tip Inside the building.
accept The Ruins of Stardust##1034 |goto 37.37,51.79
step
Leave the building |goto 37.20,51.86 < 5 |walk
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin An Aggressive Defense##1025 |goto 36.62,49.58
step
Follow the path |goto 37.25,59.55 < 30 |only if walking
click Stardust Covered Bush+
|tip They look like bushes with white sparkles floating off of them on the ground around this area.
collect 5 Handful of Stardust##5494 |q 1034/1 |goto 33.27,67.20
step
Follow the path |goto 36.14,68.58 < 30 |only if walking
Continue following the path |goto 37.26,71.45 < 30 |only if walking
Enter the tunnel |goto 42.27,71.09 < 15 |only if walking
Follow the main path and leave the tunnel |goto Stonetalon Mountains 78.24,42.68 < 15 |only if walking
Enter the building |goto Stonetalon Mountains 59.04,62.24 < 10 |walk
talk Ziz Fizziks##4201
|tip Inside the building.
accept Super Reaper 6000##1093 |goto Stonetalon Mountains 58.99,62.60
step
Leave the building |goto 59.04,62.24 < 7 |walk
Follow the path |goto 60.79,64.04 < 30 |only if walking
Continue following the path |goto 60.11,70.51 < 30 |only if walking
Continue following the path |goto 58.98,68.42 < 30 |only if walking
talk Kaela Shadowspear##4080
turnin On Guard in Stonetalon##1070 |goto 59.90,66.85
accept On Guard in Stonetalon##1085 |goto 59.90,66.85
step
talk Gaxim Rustfizzle##4077
turnin On Guard in Stonetalon##1085 |goto 59.52,67.15
accept A Gnome's Respite##1071 |goto 59.52,67.15
stickystart "Kill_Venture_Co_Loggers"
stickystart "Kill_Venture_Co_Deforesters"
step
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
kill 10 Venture Co. Logger##3989 |q 1071/1 |goto 60.44,52.78
You can find more around: |notinsticky
[71.20,56.50]
[70.01,48.11]
[64.24,46.72]
step
label "Kill_Venture_Co_Deforesters"
kill 10 Venture Co. Deforester##3991 |q 1071/2 |goto 60.44,52.78
You can find more around: |notinsticky
[71.20,56.50]
[70.01,48.11]
[64.24,46.72]
step
Kill enemies around this area
Reach Level 24 |ding 24 |goto 60.44,52.78
You can find more around: |notinsticky
[71.20,56.50]
[70.01,48.11]
[64.24,46.72]
step
Follow the path |goto 61.79,58.47 < 40 |only if walking
Enter the building |goto 59.04,62.24 < 10 |walk
talk Ziz Fizziks##4201
|tip Inside the building.
turnin Super Reaper 6000##1093 |goto 58.99,62.60
step
Leave the building |goto 59.04,62.24 < 10 |walk
Follow the path |goto 60.79,64.04 < 30 |only if walking
Continue following the path |goto 60.11,70.51 < 30 |only if walking
Continue following the path |goto 58.98,68.42 < 30 |only if walking
talk Gaxim Rustfizzle##4077
turnin A Gnome's Respite##1071 |goto 59.52,67.15
accept An Old Colleague##1072 |goto 59.52,67.15
accept A Scroll from Mauren##1075 |goto 59.52,67.15
step
Follow the road |goto 56.34,64.34 < 30 |only if walking
Continue following the road |goto 53.12,61.21 < 30 |only if walking
Kill Pridewing enemies around this area
|tip They look like wyverns.
collect 12 Pridewing Venom Sac##5808 |q 1134/1 |goto 51.55,45.08
You can find more around: |notinsticky
[54.89,42.08]
[54.05,39.63]
[45.90,46.08]
step
Follow the path |goto 46.86,31.45 < 20 |only if walking
Continue following the path |goto 43.26,16.17 < 30 |only if walking
talk Keeper Albagorm##3994
turnin Journey to Stonetalon Peak##1056 |goto 37.10,8.10
step
talk Teloren##4407
fpath Stonetalon Peak |goto 36.44,7.18
step
talk Innkeeper Shaussiy##6737
|tip Inside the building.
home Auberdine |goto Darkshore 37.04,44.12
step
Enter the building |goto 37.77,41.36 < 15 |only if walking
Follow the path |goto 37.07,38.39 < 20 |only if walking
Follow the road |goto 42.60,36.66 < 30 |only if walking
click Mathystra Relic+
|tip They look like various small grey-ish colored stone objects on the ground around this area.
|tip They won't all contain the quest item.
collect 6 Mathystra Relic##5273 |q 951/1 |goto 58.64,23.94
You can find more around: |notinsticky
[61.03,21.68]
[58.13,20.36]
[56.88,22.20]
step
talk Gelkak Gyromast##6667
accept Gyromast's Retrieval##2098 |goto 56.65,13.48
stickystart "Collect_Bottom_Of_Gelkaks_Key"
step
click Beached Sea Turtle
accept Beached Sea Turtle##4727 |goto 53.11,18.16
step
label "Collect_Bottom_Of_Gelkaks_Key"
Kill Crawler enemies around this area
|tip They look like crabs.
collect Bottom of Gelkak's Key##7500 |q 2098/3 |goto 52.01,21.19
You can find more around: |notinsticky
[56.97,13.59]
step
Kill Greymist enemmies around this area
|tip Underwater.
collect Middle of Gelkak's Key##7499 |q 2098/2 |goto 54.95,12.16
step
Follow the path |goto 57.24,13.93 < 30 |only if walking
kill Giant Foreststrider##2323+
collect Top of Gelkak's Key##7498 |q 2098/1 |goto 61.19,14.79
You can find more around: |notinsticky
[61.12,10.76]
step
talk Gelkak Gyromast##6667
turnin Gyromast's Retrieval##2098 |goto 56.65,13.48
accept Gyromast's Revenge##2078 |goto 56.65,13.48
step
Locate the Threshwackonator 4100 |goto 55.81,18.29 < 15 |c |q 2078
step
talk The Threshwackonator 4100##6669
Choose _"Insert key"_
Run North on the Beach |goto 55.81,18.29 > 15 |c |q 2078
|tip The Threshwackonator 4100 will follow you.
step
Watch the dialogue
kill The Threshwackonator 4100##6669
Defeat Gelkak's First Mate |q 2078/1 |goto 56.65,13.48
step
talk Gelkak Gyromast##6667
turnin Gyromast's Revenge##2078 |goto 56.65,13.48
|tip You can destroy the "Gyromast's Key" item after turning in this quest.
step
talk Gwennyth Bly'Leggonde##10219
turnin Beached Sea Turtle##4727 |goto 36.62,45.59
step
Follow the road |goto 39.97,48.11 < 30 |only if walking
Follow the path |goto 41.81,76.80 < 30 |only if walking
talk Onu##3616
turnin Mathystra Relics##951 |goto 43.55,76.29
step
Enter the cave |goto 44.58,85.11 < 15 |walk
talk Volcor##3692
|tip Inside the building.
turnin A Lost Master##993 |goto 45.01,85.30
accept Escape Through Force##994 |goto 45.01,85.30 |or
|tip Accept this quest if you are a class that can't stealth.
|tip Volcor will help you fight.
_Or_
accept Escape Through Stealth##995 |goto 45.01,85.30 |or
|tip Accept this quest if you are a class that can stealth.
|tip Volcor run away alone, allowing you to stealth out by yourself.
step
Watch the dialogue
|tip Follow Volcor and protect him as he walks.
|tip He eventually walks to this location.
Help Volcor to the Road |q 994/1 |goto 41.92,81.91
|only if havequest(994) or completedq(994)
step
Watch the dialogue
|tip Volcor will run out of the cave and escape by himself.
|tip Do not follow him.
|tip You can then sneak out of the area stealthed by yourself.
Help Volcor Escape the Cave |q 995/1 |goto 45.01,85.30
|only if havequest(995) or completedq(995)
step
Follow the road |goto 41.55,80.42 < 30 |only if walking
Enter the building |goto 38.96,43.57 < 20 |walk
talk Terenthis##3693
|tip Inside the building.
turnin Escape Through Force##994 |goto 39.37,43.48 |or |only if havequest(994) or completedq(994)
turnin Escape Through Force##995 |goto 39.37,43.48 |or |only if havequest(995) or completedq(995)
step
Follow the path |goto Teldrassil 56.77,92.68 < 20 |only if walking
talk Vesprystus##3838
fpath Rut'theran Village |goto Teldrassil 58.40,94.02
step
Follow the path |goto Darnassus 38.49,48.00 < 20 |only if walking
talk Chief Archaeologist Greywhisker##2912
|tip Outside the building.
turnin The Absent Minded Prospector##741 |goto Darnassus 31.25,84.50
accept The Absent Minded Prospector##942 |goto Darnassus 31.25,84.50
step
talk Shindrell Swiftfire##3845
turnin Pridewings of Stonetalon##1134 |goto Ashenvale 34.67,48.84
accept Kayneth Stillwind##4581 |goto Ashenvale 34.67,48.84
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Trek to Ashenvale##990 |goto 36.62,49.58
step
Enter the building |goto 37.19,51.86 < 10 |walk
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin The Ruins of Stardust##1034 |goto 37.37,51.79
step
Watch the dialogue
talk Pelturas Whitemoon##3894
|tip Inside the building.
accept Fallen Sky Lake##1035 |goto 37.37,51.79
step
Leave the building |goto 37.19,51.86 < 7 |walk
Follow the path |goto 35.39,57.31 < 20 |only if walking
Follow the path |goto 28.40,60.72 < 20 |only if walking
Follow the path up |goto 25.86,63.07 < 15 |only if walking
kill Ilkrud Magthrull##3664
collect Ilkrud Magthrull's Tome##5533 |q 973/1 |goto 25.28,60.69
step
Follow the path |goto 28.41,60.89 < 20 |only if walking
Follow the path |goto 31.28,46.51 < 30 |only if walking
Continue following the path |goto 33.10,41.23 < 30 |only if walking
Continue following the path |goto 36.14,39.67 < 30 |only if walking
Continue following the path |goto 38.48,36.14 < 20 |only if walking
kill Dal Bloodclaw##3987
|tip He looks like a grey furbolg that walks around this area.
collect Dal Bloodclaw's Skull##5544 |q 1054/1 |goto 37.74,34.74
step
Follow the path |goto 38.49,36.13 < 20 |only if walking
Continue following the path |goto 37.86,39.35 < 30 |only if walking
Continue following the path |goto 33.10,41.23 < 30 |only if walking
Follow the road |goto 30.17,47.29 < 30 |only if walking
talk Delgren the Purifier##3663
turnin The Tower of Althalaxx##973 |goto 26.20,38.70
accept The Tower of Althalaxx##1140 |goto 26.20,38.70
step
Follow the road |goto 25.49,38.85 < 20 |only if walking
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Culling the Threat##1054 |goto 36.62,49.58
step
Follow the road |goto 38.43,57.74 < 30 |only if walking
Follow the path down |goto 51.23,58.37 < 30 |c |q 1016 |future
step
Kill enemies around this area
Reach Level 25 |ding 25 |goto 50.18,61.36
You can find more around [55.40,62.84]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (25-30)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (30-35)",
startlevel=25,
endlevel=30,
},[[
step
Enter the building |goto Ashenvale 50.12,66.47 < 15 |walk
talk Sentinel Velene Starstrike##3885
|tip Inside the building.
accept Elemental Bracers##1016 |goto Ashenvale 49.80,67.21
step
kill Befouled Water Elemental##3917+
|tip You can find more in the water surrounding this small island.
collect 5 Intact Elemental Bracer##12220 |goto 48.38,69.68 |q 1016
step
use the Divining Scroll##5456
collect Divined Scroll##5455 |q 1016/1
step
Enter the building |goto 50.12,66.47 < 15 |walk
talk Sentinel Velene Starstrike##3885
|tip Inside the building.
turnin Elemental Bracers##1016 |goto 49.80,67.21
step
Enter the building |goto Ironforge 26.14,72.23 < 15 |walk
talk Auctioneer Redmuse##8720
|tip Inside the building.
|tip Buy the following items from the Auction House.
collect 4 Minor Mana Potion##2455 |goto Ironforge 24.25,74.55 |q 1073 |future
collect 2 Elixir of Minor Fortitude##2458 |goto Ironforge 24.25,74.55 |q 1073 |future
step
talk Lomac Gearstrip##4081
turnin An Old Colleague##1072 |goto 72.10,51.89
accept Ineptitude + Chemicals = Fun##1073 |goto 72.10,51.89
step
talk talk 4081
turnin Ineptitude + Chemicals = Fun##1073 |goto 72.10,51.89
step
Follow the road |goto Redridge Mountains 35.02,44.11 < 30 |only if walking
Follow the path |goto Redridge Mountains 43.30,37.54 < 30 |only if walking
click Practice Lockbox+
|tip They look like grey metal chests.
|tip Inside the building.
|tip Keep clicking them until you reach Lockpicking skill level 75.
Click Here After Reaching Level 75 Lockpicking |confirm |goto Redridge Mountains 51.97,45.15 |q 2607 |future
|only if Rogue
step
Follow the path |goto Stormwind City 74.74,53.70 < 7 |only if walking
Enter the building |goto Stormwind City 77.14,58.02 < 7 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
accept Mathias and the Defias##2360 |goto Stormwind City 75.78,59.85
|only if Rogue
step
Leave the building |goto 77.11,58.00 < 7 |walk
Follow the path |goto 74.67,53.63 < 7 |only if walking
Run up the ramp |goto 62.41,62.29 < 10 |only if walking
talk Agent Kearnen##7024
turnin Mathias and the Defias##2360 |goto Westfall 68.49,70.08
accept Klaven's Tower##2359 |goto Westfall 68.49,70.08
|only if Rogue
step
collect Defias Tower Key##7923 |q 2359/2 |goto 71.63,73.91
|tip Use your "Pickpocket" ability on Malformed Defias Drone.
|tip He walks around this area.
|only if Rogue
step
Enter the building |goto 69.97,74.07 < 7 |walk
click Duskwood Chest
|tip Upstairs inside the building.
|tip You will get a debuff after opening it.
|tip Use your "Sap" ability on Klaven Mortwake nearby before clicking the chest.
|tip He is elite, but you should be fine.
|tip If you have trouble, try to find someone to help you.
collect Klaven Mortwake's Journal##7908 |q 2359/1 |goto 70.41,73.93
|only if Rogue
step
Leave the building |goto 69.95,74.04 < 7 |walk
Follow the path |goto Stormwind City 74.74,53.70 < 7 |only if walking
Enter the building |goto Stormwind City 77.14,58.02 < 7 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin Klaven's Tower##2359 |goto Stormwind City 75.78,59.85
accept The Touch of Zanzil##2607 |goto Stormwind City 75.78,59.85
|only if Rogue
step
talk Doc Mixilpixil##7207
|tip Downstairs inside the building.
turnin The Touch of Zanzil##2607 |goto 78.04,58.77
accept The Touch of Zanzil##2608 |goto 78.04,58.77
|only if Rogue
step
Watch the dialogue
|tip Use the "/lay" emote while targeting Doc Mixilpixil.
Complete the Diagnosis |q 2608/1 |goto 78.04,58.77
|only if Rogue
step
talk Doc Mixilpixil##7207
|tip Downstairs inside the building.
turnin The Touch of Zanzil##2608 |goto 78.04,58.77
|only if Rogue
step
Remove the Touch of Zanzil |nobuff 136230
|tip You will still have the "Touch of Zanzil" debuff.
|tip There is a quest to remove the buff.
|tip The quest makes you gather items in Stormwind City, but gathering the items can cost a lot of silver.
|tip To remove the buff without doing the quest and wasting money, you have 2 options:
|tip If you have First Aid leveled, create an "Anti-Venom" and use it on yourself.
|tip You can also try to buy one from the Auction House, they're usually cheap.
|tip Alternatively, try to ask a Druid player to use their "Cure Poison" ability on you.
|only if Rogue
step
talk Mountaineer Kadrell##1340
|tip He walks around this area.
accept Report to Mountaineer Rockgar##468 |goto Loch Modan/0 34.59,47.26
step
Follow the road |goto 32.15,43.03 < 30 |only if walking
talk Mountaineer Rockgar##1342
turnin Report to Mountaineer Rockgar##468 |goto 25.44,10.38
accept The Algaz Gauntlet##455 |goto 25.44,10.38
stickystart "Kill_Dragonmaw_Grunts"
step
Enter the tunnel |goto 25.56,10.01 < 7 |only if walking
Leave the tunnel |goto 25.27,0.11 < 10 |only if walking
Enter the tunnel |goto Wetlands 55.11,83.54 < 10 |only if walking
Leave the tunnel |goto Wetlands 50.62,82.59 < 10 |only if walking
kill 8 Dragonmaw Scout##2103 |q 455/1 |goto Wetlands 49.03,78.90
You can find more around [47.66,76.02]
step
label "Kill_Dragonmaw_Grunts"
kill 6 Dragonmaw Grunt##2102 |q 455/2 |goto 47.66,76.02
step
Follow the path |goto 48.04,77.62 < 15 |only if walking
Enter the tunnel |goto 50.17,78.36 < 10 |only if walking
Leave the tunnel |goto 50.13,71.55 < 10 |only if walking
Follow the road |goto 48.19,67.41 < 30 |c |q 455
step
Enter the tunnel |goto 49.30,70.56 < 10 |only if walking
Traverse Dun Algaz |q 455/3 |goto 53.87,70.33
step
Leave the tunnel |goto 53.87,70.33 < 10 |only if walking
Follow the road |goto 58.67,65.98 < 30 |only if walking
talk Einar Stonegrip##2093
accept Daily Delivery##469 |goto 49.92,39.37
step
Follow the road |goto 37.97,36.81 < 30 |only if walking
Cross the bridge |goto 12.37,50.35 < 20 |only if walking
talk Tarrel Rockweaver##2096
|tip He walks around this area.
accept In Search of The Excavation Team##305 |goto 11.50,52.14
step
Follow the path |goto 10.78,55.02 < 15 |only if walking
talk James Halloran##2094
|tip He walks around this area.
turnin Daily Delivery##469 |goto 8.51,55.71
accept Young Crocolisk Skins##484 |goto 8.51,55.71
step
talk Karl Boran##1242
|tip He walks around this area.
accept Claws from the Deep##279 |goto Wetlands 8.31,58.53
step
talk First Mate Fitzsimmons##1239
accept The Third Fleet##288 |goto 10.89,59.67
accept The Greenwarden##463 |goto 10.89,59.67
step
Enter the building |goto 10.79,59.76 < 7 |walk
talk Innkeeper Helbrek##1464
|tip Inside the building.
home Deepwater Tavern |goto 10.70,60.95
step
talk Innkeeper Helbrek##1464
|tip Inside the building.
buy Flagon of Mead##2594 |q 288/1 |goto 10.70,60.95
step
talk Archaeologist Flagongut##2911
|tip Upstairs inside the building.
turnin The Absent Minded Prospector##942 |goto 10.84,60.43
accept The Absent Minded Prospector##943 |goto 10.84,60.43
step
Leave the building |goto 10.79,59.77 < 10 |walk
talk First Mate Fitzsimmons##1239
turnin The Third Fleet##288 |goto 10.89,59.67
accept The Cursed Crew##289 |goto 10.89,59.67
step
talk Sida##2111
accept Digging Through the Ooze##470 |goto 11.80,57.99
step
Enter the building |goto 10.30,56.30 < 15 |walk
talk Valstag Ironjaw##2086
|tip Inside the building.
turnin The Algaz Gauntlet##455 |goto 10.10,56.89
accept Report to Captain Stoutfist##473 |goto 10.10,56.89
step
Run up the stairs |goto 9.80,57.77 < 5 |walk
talk Captain Stoutfist##2104
|tip Upstairs inside the building, in the large room.
turnin Report to Captain Stoutfist##473 |goto 9.86,57.49
accept War Banners##464 |goto 9.86,57.49
stickystart "Slay_Bluegill_Murlocs"
step
Leave the building |goto 10.28,56.36 < 10 |walk
kill Gobbler##1259
|tip He looks like a grey murloc that walks around this area.
collect Gobbler's Head##3618 |q 279/2 |goto 17.99,40.38
Also check around [14.45,41.53]
step
label "Slay_Bluegill_Murlocs"
Kill Bluegill enemies around this area
Slay #12# Bluegill Murlocs |q 279/1 |goto 13.64,39.55
step
kill Young Wetlands Crocolisk##1417+
|tip Underwater around this area.
collect 4 Young Crocolisk Skin##3397 |q 484/1 |goto 20.01,46.59
You can find more around: |notinsticky
[27.47,40.25]
[34.44,36.03]
step
Follow the path |goto 34.19,41.09 < 15 |only if walking
Follow the path up |goto 37.11,42.98 < 15 |only if walking
talk Ormer Ironbraid##1078
|tip He walks around this area.
accept Ormer's Revenge##294 |goto 38.18,50.89
step
Enter the cave |goto 38.32,51.59 < 10 |walk
talk Merrin Rockweaver##1076
|tip Inside the cave.
turnin In Search of The Excavation Team##305 |goto 38.91,52.34
accept In Search of The Excavation Team##306 |goto 38.91,52.34
step
talk Prospector Whelgar##1077
|tip Inside the cave.
accept Uncovering the Past##299 |goto 38.81,52.39
step
click Flagongut's Fossil
|tip Inside the cave.
collect Flagongut's Fossil##5234 |q 943/1 |goto 38.86,52.21
stickystart "Kill_Mottled_Screechers"
step
Leave the cave |goto 38.32,51.59 < 10 |walk
Follow the path down |goto 37.10,47.90 < 15 |only if walking
Follow the path |goto 34.02,40.85 < 20 |only if walking
Kill Mottled enemies around this area
|tip They look like raptors.
collect Stone of Relu##5233 |q 943/1 |goto 29.12,44.15
You can find more around: |notinsticky
[25.11,47.95]
[22.90,53.35]
step
label "Kill_Mottled_Raptors"
kill 10 Mottled Raptor##1020 |q 294/1 |goto 29.12,44.15
You can find more around: |notinsticky
[25.11,47.95]
[22.90,53.35]
step
label "Kill_Mottled_Screechers"
kill 10 Mottled Screecher##1021 |q 294/2 |goto 29.12,44.15
You can find more around: |notinsticky
[25.11,47.95]
[22.90,53.35]
step
Follow the path |goto 34.19,41.09 < 15 |only if walking
Follow the path up |goto 37.11,42.98 < 15 |only if walking
talk Ormer Ironbraid##1078
|tip He walks around this area.
turnin Ormer's Revenge##294 |goto 38.18,50.89
accept Ormer's Revenge##295 |goto 38.18,50.89
stickystart "Collect_Golm_Fragment"
stickystart "Collect_Modr_Fragment"
stickystart "Collect_Ados_Fragment"
stickystart "Kill_Mottled_Scytheclaws"
stickystart "Kill_Mottled_Razormaws"
step
Follow the path down |goto 37.10,47.90 < 15 |only if walking
click Loose Soil
|tip It looks like a large pile of dark brown dirt on the ground.
|tip It randomly spawns in multiple locations around this area.
|tip It can also spawn up on the cliff next to the higher level Sarltooth raptor.
|tip If it does, try to get someone to help you, if you can't solo him.
collect Neru Fragment##2661 |q 299/4 |goto 36.51,42.11
Also check:
Around [34.73,45.31]
Around [32.82,48.77]
Around [35.30,49.72]
Up the path at [31.90,50.17]
step
label "Collect_Golm_Fragment"
click Ancient Relic
|tip It looks like a large wide yellow vase sitting upright on the ground.
|tip It randomly spawns in multiple locations around this area.
|tip It can also spawn up on the cliff next to the higher level Sarltooth raptor.
|tip If it does, try to get someone to help you, if you can't solo him.
collect Golm Fragment##2660 |q 299/3 |goto 36.51,42.11
Also check:
Around [34.73,45.31]
Around [32.82,48.77]
Around [35.30,49.72]
Up the path at [31.90,50.17]
step
label "Collect_Modr_Fragment"
click Ancient Relic
|tip It looks like a large tall red vase sitting upright on the ground.
|tip It randomly spawns in multiple locations around this area.
|tip It can also spawn up on the cliff next to the higher level Sarltooth raptor.
|tip If it does, try to get someone to help you, if you can't solo him.
collect Modr Fragment##2659 |q 299/2 |goto 36.51,42.11
Also check:
Around [34.73,45.31]
Around [32.82,48.77]
Around [35.30,49.72]
Up the path at [31.90,50.17]
step
label "Collect_Ados_Fragment"
click Ancient Relic
|tip It looks like a large stone box container on the ground.
|tip It randomly spawns in multiple locations around this area.
|tip It can also spawn up on the cliff next to the higher level Sarltooth raptor.
|tip If it does, try to get someone to help you, if you can't solo him.
collect Ados Fragment##2658 |q 299/1 |goto 36.51,42.11
Also check:
Around [34.73,45.31]
Around [32.82,48.77]
Around [35.30,49.72]
Up the path at [31.90,50.17]
step
label "Kill_Mottled_Scytheclaws"
kill 10 Mottled Scytheclaw##1022 |q 295/1 |goto 34.73,45.31
[32.82,48.77]
[35.30,49.72]
step
label "Kill_Mottled_Razormaws"
kill 10 Mottled Razormaw##1023 |q 295/2 |goto 34.73,45.31
[32.82,48.77]
[35.30,49.72]
step
Follow the path up |goto 37.11,42.98 < 15 |only if walking
talk Ormer Ironbraid##1078
|tip He walks around this area.
turnin Ormer's Revenge##295 |goto 38.18,50.89
accept Ormer's Revenge##296 |goto 38.18,50.89
step
Enter the cave |goto 38.32,51.59 < 10 |walk
talk Prospector Whelgar##1077
|tip Inside the cave.
turnin Uncovering the Past##299 |goto 38.81,52.39
step
Leave the cave |goto 38.32,51.59 < 10 |walk
Follow the path down |goto 37.10,47.90 < 15 |c |q 296
step
Kill enemies around this area
Reach Level 26 |ding 26 |goto 34.73,45.31
[32.82,48.77]
[35.30,49.72]
Follow the path up |goto 31.90,50.17 < 10 |only if walking
kill Sarltooth##1353
|tip Up on the cliff.
|tip You may need help with this.
collect Sarltooth's Talon##3638 |q 296/1 |goto 33.26,51.52
step
Follow the path up |goto 37.11,42.98 < 15 |only if walking
talk Ormer Ironbraid##1078
|tip He walks around this area.
turnin Ormer's Revenge##296 |goto 38.18,50.89
step
Follow the path down |goto 37.10,47.90 < 15 |only if walking
Follow the path |goto 34.02,40.85 < 20 |only if walking
Follow the road |goto 34.79,37.97 < 30 |only if walking
Kill Dragonmaw enemies around this area
collect 8 Dragonmaw War Banner##3337 |q 464/1 |goto 42.95,41.12
You can find more around [45.71,44.48]
step
talk Rethiel the Greenwarden##1244
turnin The Greenwarden##463 |goto 56.37,40.40
accept Tramping Paws##276 |goto 56.37,40.40
stickystart "Kill_Mosshide_Gnolls"
step
kill 10 Mosshide Mongrel##1008 |q 276/2 |goto 61.18,57.60
You can find more around: |notinsticky
[64.11,63.15]
[62.39,70.70]
[55.68,74.52]
step
label "Kill_Mosshide_Gnolls"
kill 15 Mosshide Gnoll##1007 |q 276/1 |goto 64.11,63.15
You can find more around: |notinsticky
[62.39,70.70]
[55.68,74.52]
step
talk Rethiel the Greenwarden##1244
turnin Tramping Paws##276 |goto 56.37,40.40
accept Fire Taboo##277 |goto 56.37,40.40
step
Kill Mosshide enemies around this area
collect 9 Crude Flint##2611 |q 277/1 |goto 45.65,33.83
You can find more around [36.76,28.88]
step
Kill Ooze enemies around this area
|tip Inside and outside the crypt.
collect Sida's Bag##3349 |q 470/1 |goto 44.28,25.51
|tip This has a very low drop rate.
step
talk Rethiel the Greenwarden##1244
turnin Fire Taboo##277 |goto 56.37,40.40
accept Blisters on The Land##275 |goto 56.37,40.40
step
kill Fen Creeper##1040 |q 275/1 |goto 55.06,37.24 |count 4
|tip They are stealthed, usually near or in the water around this area.
|tip You will kill more of these later.
You can find more around: |notinsticky
[53.31,36.23]
[53.96,41.25]
[54.98,46.16]
step
talk Archaeologist Flagongut##2911
|tip Upstairs inside the building.
turnin The Absent Minded Prospector##943 |goto 10.84,60.43
step
Leave the building |goto 10.79,59.77 < 10 |walk
talk Karl Boran##1242
|tip He walks around this area.
turnin Claws from the Deep##279 |goto 8.31,58.53
accept Reclaiming Goods##281 |goto 8.31,58.53
step
talk James Halloran##2094
|tip He walks around this area.
turnin Young Crocolisk Skins##484 |goto 8.51,55.71
accept Apprentice's Duties##471 |goto 8.51,55.71
step
Enter the building |goto 10.30,56.29 < 15 |walk
Run up the stairs |goto 9.79,57.77 < 5 |walk
talk Captain Stoutfist##2104
|tip Upstairs inside the building.
turnin War Banners##464 |goto 9.86,57.48
accept Nek'rosh's Gambit##465 |goto 9.86,57.48
step
Leave the building |goto 10.31,56.29 < 10 |walk
talk Sida##2111
turnin Digging Through the Ooze##470 |goto 11.80,57.99
step
Follow the path |goto 10.81,54.99 < 15 |only if walking
talk Tarrel Rockweaver##2096
turnin In Search of The Excavation Team##306 |goto 11.50,52.14
step
click Damaged Crate
turnin Reclaiming Goods##281 |goto 13.51,41.38
accept The Search Continues##284 |goto 13.51,41.38
step
click Sealed Barrel
turnin The Search Continues##284 |goto 13.61,38.21
accept Search More Hovels##285 |goto 13.61,38.21
step
click Half-buried Barrel
turnin Search More Hovels##285 |goto 13.95,34.81
accept Return the Statuette##286 |goto 13.95,34.81
stickystart "Kill_Cursed_Marines"
stickystart "Kill_Cursed_Sailors"
step
Enter the hole in the side of the ship |goto 14.05,30.54 < 15 |walk
kill First Mate Snellig##1159
|tip Underwater, inside the sunken ship.
collect Snellig's Snuffbox##3619 |q 289/3 |goto 14.08,30.01
step
label "Kill_Cursed_Marines"
kill 5 Cursed Marine##1158 |q 289/2 |goto 14.22,28.53
You can find more around [14.82,24.62]
step
label "Kill_Cursed_Sailors"
kill 13 Cursed Sailor##1157 |q 289/1 |goto 14.22,28.53
You can find more around [14.82,24.62]
stickystart "Kill_Fen_Creepers"
step
kill Giant Wetlands Crocolisk##2089+
collect 6 Giant Crocolisk Skin##3348 |q 471/1 |goto 16.57,28.25
You can find more around: |notinsticky
[20.92,21.92]
[27.08,21.65]
step
label "Kill_Fen_Creepers"
kill Fen Creeper##1040 |q 275/1 |goto 18.45,27.72 |count 12
|tip They are stealthed, usually near or in the water around this area.
You can find more around: |notinsticky
[20.83,28.59]
[22.56,30.11]
[23.49,32.06]
[25.93,31.76]
[27.45,32.68]
[27.49,37.05]
[27.24,38.82]
step
Kill enemies around this area
Reach Level 27 |ding 27 |goto 30.85,32.92
step
talk Rethiel the Greenwarden##1244
turnin Blisters on The Land##275 |goto 56.38,40.40
step
Leave the building |goto 10.79,59.76 < 10 |walk
talk First Mate Fitzsimmons##1239
turnin The Cursed Crew##289 |goto 10.89,59.67
accept Lifting the Curse##290 |goto 10.89,59.67
step
talk Karl Boran##1242
|tip He walks around this area.
turnin Return the Statuette##286 |goto 8.31,58.54
step
talk James Halloran##2094
|tip He walks around this area.
turnin Apprentice's Duties##471 |goto 8.51,55.71
step
talk Collin Mauren##4078
turnin A Scroll from Mauren##1075 |goto Stormwind City 43.09,80.38
step
Enter the building |goto 29.15,74.15 < 7 |walk
talk Zardeth of the Black Claw##1435
|tip Downstairs inside the building.
accept A Noble Brew##335 |goto 26.45,78.66
step
Leave the building |goto 29.15,74.15 < 7 |walk
Run up the ramp |goto 62.36,62.24 < 10 |only if walking
talk Guard Howe##903
accept Blackrock Bounty##128 |goto Redridge Mountains 31.54,57.85
step
click Wanted: Lieutenant Fangore
accept Wanted: Lieutenant Fangore##180 |goto 26.75,46.47
step
Enter the building |goto 26.62,46.36 < 10 |walk
talk Innkeeper Brianna##6727
|tip Inside the building.
home Lakeshire |goto 27.01,44.82
step
Leave the building |goto 26.62,46.36 < 10 |walk
kill Bellygrub##345
|tip He looks like a darker brown boar that walks around this area.
collect Bellygrub's Tusk##3631 |q 34/1 |goto 15.68,49.32
step
talk Martie Jainrose##342
turnin An Unwelcome Guest##34 |goto 21.86,46.33
step
Follow the road |goto 33.03,47.92 < 30 |only if walking
Follow the path |goto 46.98,24.67 < 30 |only if walking
Continue following the path |goto 39.21,14.27 < 20 |only if walking
kill 15 Blackrock Champion##435 |q 128/1 |goto 33.21,6.88
|tip Inside and outside the cave.
|tip They are mostly inside the cave, and the next guide step is inside the cave.
|tip Try to kill them mostly inside the cave.
step
Follow the path inside the cave |goto 31.69,12.88 < 20 |walk
Continue following the path |goto 30.83,14.84 < 10 |walk
Follow the path |goto 28.45,13.64 < 10 |walk
talk Corporal Keeshan##349
|tip Inside the cave.
accept Missing In Action##219 |goto 28.39,12.55
step
Watch the dialogue
|tip Follow Corporal Keeshan and protect him as he walks.
|tip He walks out of the cave and all the way back to Lakeshire.
|tip When you reach the exit of the cave, pull the enemies to him, one group at a time.
|tip He eventually walks to this location.
Escort Corporal Keeshan Back to Redridge |q 219/1 |goto 33.41,48.51 |notravel
step
talk Marshal Marris##382
turnin Missing In Action##219 |goto 33.51,48.97
step
talk Guard Howe##903
turnin Blackrock Bounty##128 |goto 31.54,57.86
stickystart "Collect_Shadowhide_Pendants"
step
Follow the road |goto 34.62,44.68 < 30 |only if walking
Follow the path |goto 43.57,37.66 < 30 |only if walking
Continue following the path |goto 75.76,39.09 < 30 |only if walking
kill Lieutenant Fangore##703
|tip He looks like a gnoll wearing a red robe, and carrying a long sword, that walks around this area.
|tip Try to kite him away, so you can fight him alone.
|tip You may need help with this.
collect Fangore's Paw##3632 |q 180/1 |goto 78.93,38.46
Also check around [84.46,50.51]
step
label "Collect_Shadowhide_Pendants"
Kill Shadowhide enemies around this area
collect 10 Shadowhide Pendant##1075 |q 91/1 |goto 77.98,39.66
You can find more around: |notinsticky
[76.82,54.09]
[83.92,54.28]
step
Leave the building |goto 26.62,46.38 < 10 |walk
Enter the building |goto 29.49,46.13 < 15 |walk
talk Bailiff Conacher##900
|tip Inside the building.
turnin Solomon's Law##91 |goto 29.71,44.27
step
talk Magistrate Solomon##344
|tip Inside the building.
turnin Wanted: Lieutenant Fangore##180 |goto 29.99,44.46
step
Leave the building |goto 29.50,46.16 < 10 |walk
Follow the road |goto 32.87,49.71 < 30 |only if walking
Continue following the road |goto 16.76,70.24 < 30 |only if walking
Enter Duskwood |goto 6.97,89.66 < 30 |only if walking
Follow the road |goto Duskwood 74.08,23.23 < 30 |only if walking
Enter the building |goto Duskwood 75.55,45.37 < 10 |walk
talk Madame Eva##265
|tip She walks around this area inside the building.
accept The Legend of Stalvan##66 |goto 75.82,45.29
accept The Totem of Infliction##101 |goto 75.82,45.29
step
Leave the building |goto 75.55,45.37 < 7 |walk
Enter the building |goto 73.83,46.02 < 10 |walk
talk Innkeeper Trelayne##6790
|tip Inside the building.
home Darkshire |goto 73.87,44.41
step
Leave the building |goto 73.83,46.02 < 10 |walk
talk Commander Althea Ebonlocke##264
|tip She walks around this area.
accept The Night Watch##56 |goto 73.60,46.90
step
Enter the building |goto 72.93,46.81 < 10 |walk
talk Clerk Daltry##267
|tip He walks around this area inside the building.
turnin The Legend of Stalvan##66 |goto 72.52,46.85
accept The Legend of Stalvan##67 |goto 72.52,46.85
step
Leave the building |goto 72.93,46.81 < 7 |walk
talk Calor##663
|tip He walks around this area in front of the building.
accept Worgen in the Woods##173 |goto 75.30,48.05
step
Enter the building |goto 75.23,48.26 < 5 |walk
talk Elaine Carevin##633
|tip Inside the building.
accept Raven Hill##163 |goto 75.33,48.69
accept The Hermit##165 |goto 75.33,48.69
accept Deliveries to Sven##164 |goto 75.33,48.69
step
Leave the building |goto 75.23,48.25 < 7 |walk
talk Herble Baubbletump##3133
|tip He sells a limited amount.
|tip If he doesn't have it for sale, buy one from the Auction House in Stormwind City.
buy Bronze Tube##4371 |goto 77.99,48.33 |q 174 |future
step
Enter the building |goto 79.78,47.69 < 7 |walk
talk Viktori Prism'Antras##276
|tip Inside the building.
accept Look To The Stars##174 |goto 79.80,48.02
step
talk Viktori Prism'Antras##276
|tip Inside the building.
turnin Look To The Stars##174 |goto 79.80,48.02
accept Look To The Stars##175 |goto 79.80,48.02
step
Leave the building |goto 79.78,47.69 < 5 |walk
talk Felicia Maline##2409
fpath Darkshire |goto 77.49,44.29
step
Enter the building |goto Westfall 42.22,66.90 < 10 |walk
click Old Footlocker
|tip Inside the building.
turnin The Legend of Stalvan##67 |goto Westfall 41.51,66.73
accept The Legend of Stalvan##68 |goto Westfall 41.51,66.73
step
Leave the building |goto 42.22,66.90 < 10 |walk
Enter the building |goto Duskwood 72.93,46.81 < 10 |walk
talk Clerk Daltry##267
|tip He walks around this area inside the building.
turnin The Legend of Stalvan##68 |goto Duskwood 72.52,46.85
accept The Legend of Stalvan##69 |goto Duskwood 72.52,46.85
step
Leave the building |goto 72.93,46.81 < 7 |walk
Follow the path |goto 78.00,60.24 < 30 |only if walking
Enter the building |goto 81.67,59.14 < 7 |walk
talk Blind Mary##302
|tip Inside the building.
turnin Look To The Stars##175 |goto 81.99,59.09
accept Look To The Stars##177 |goto 81.99,59.09
stickystart "Kill_Skeletal_Mages"
stickystart "Kill_Skeletal_Warriors"
step
Leave the building |goto 81.67,59.14 < 5 |walk
kill Insane Ghoul##511
|tip He looks like a red corpse that walks around this area.
|tip He can also be inside the building nearby.
collect Mary's Looking Glass##1946 |q 177/1 |goto 79.42,70.31
step
label "Kill_Skeletal_Mages"
kill 6 Skeletal Mage##203 |q 56/2 |goto 79.42,70.31
|tip Keep any "Skeleton Finger" quest items you find.
step
label "Kill_Skeletal_Warriors"
kill 8 Skeletal Warrior##48 |q 56/1 |goto 79.42,70.31
|tip Keep any "Skeleton Finger" quest items you find.
step
Kill enemies around this area
Reach Level 28 |ding 28 |goto 79.42,70.31
step
Follow the road |goto 73.30,57.93 < 30 |only if walking
Follow the path |goto 61.91,61.97 < 30 |only if walking
kill 6 Nightbane Shadow Weaver##533 |q 173/1 |goto 62.96,69.82
step
Follow the road |goto 62.07,61.44 < 30 |only if walking
talk Commander Althea Ebonlocke##264
|tip She walks around this area.
turnin The Night Watch##56 |goto 73.60,46.90
accept The Night Watch##57 |goto 73.60,46.90
step
talk Calor##663
|tip He walks around this area in front of the building.
turnin Worgen in the Woods##173 |goto 75.30,48.05
accept Worgen in the Woods##221 |goto 75.30,48.05
step
Enter the building |goto 79.78,47.69 < 10 |walk
talk Viktori Prism'Antras##276
|tip Inside the building.
turnin Look To The Stars##177 |goto 79.80,48.02
accept Look To The Stars##181 |goto 79.80,48.02
step
Leave the building |goto 79.78,47.69 < 5 |walk
Follow the road |goto 74.41,40.96 < 30 |only if walking
Follow the path |goto 73.63,32.66 < 30 |only if walking
click Tear of Tilloa
collect Tear of Tilloa##2779 |q 335/1 |goto 78.35,35.95
step
Follow the road |goto 73.05,32.85 < 30 |only if walking
Follow the path up |goto 71.18,46.13 < 15 |only if walking
kill 12 Nightbane Dark Runner##205 |q 221/1 |goto 61.26,40.74
You can find more around [63.82,50.94]
step
talk Calor##663
|tip He walks around this area in front of the building.
turnin Worgen in the Woods##221 |goto 75.30,48.05
accept Worgen in the Woods##222 |goto 75.30,48.05
stickystart "Kill_Nightbane_Vile_Fangs"
step
Follow the path |goto 73.04,64.47 < 30 |only if walking
kill 8 Nightbane Tainted One##920 |q 222/2 |goto 73.03,75.08
|tip Inside the mine.
|tip Keep an eye out for the level 32 enemy, Gutspill, who walks around inside the mine.
step
label "Kill_Nightbane_Vile_Fangs"
kill 8 Nightbane Vile Fang##206 |q 222/1 |goto 72.57,71.13
|tip Outside the mine.
step
Follow the road |goto 72.84,58.53 < 30 |only if walking
Follow the path down |goto 43.67,67.31 < 30 |only if walking
Enter the cave |goto 34.07,76.85 < 15 |walk
Follow the path |goto 36.78,77.62 < 10 |walk
Continue following the path |goto 36.83,81.89 < 10 |walk
kill Zzarc' Vul##300
|tip Inside the cave.
collect Ogre's Monocle##1968 |q 181/1 |goto 36.81,83.79
step
Follow the path |goto 36.65,77.46 < 10 |walk
Leave the cave |goto 34.07,76.85 < 15 |walk
Follow the path up |goto 31.43,67.33 < 20 |only if walking
Follow the road |goto 30.75,59.16 < 30 |only if walking
talk Jitters##288
|tip He walks around this area.
turnin Raven Hill##163 |goto 18.16,56.51
accept Jitters' Growling Gut##5 |goto 18.16,56.51
stickystart "Kill_Skeletal_Fiends"
stickystart "Kill_Skeletal_Horrors"
step
Kill Skeletal enemies around this area
collect 10 Skeleton Finger##2378 |q 101/3 |goto 15.20,44.97
You can find more around: |notinsticky
[21.50,47.70]
[22.93,43.21]
step
label "Kill_Skeletal_Fiends"
kill 15 Skeletal Fiend##531 |q 57/1 |goto 15.20,44.97
You can find more around: |notinsticky
[21.50,47.70]
[22.93,43.21]
step
label "Kill_Skeletal_Horrors"
kill 15 Skeletal Horror##202 |q 57/2 |goto 15.20,44.97
You can find more around: |notinsticky
[21.50,47.70]
[22.93,43.21]
step
Kill enemies around this area
collect An Old History Book##2794 |goto 15.20,44.97 |q 337 |future
You can find more around: |notinsticky
[21.50,47.70]
[22.93,43.21]
[23.10,35.90]
step
use An Old History Book##2794
accept An Old History Book##337
stickystart "Collect_Gooey_Spider_Legs"
step
kill Black Widow Hatchling##930+
collect 5 Vial of Spider Venom##1130 |q 101/2 |goto 27.99,50.83
You can find more around: |notinsticky
[33.54,50.07]
[32.44,35.72]
step
label "Collect_Gooey_Spider_Legs"
kill Black Widow Hatchling##930+
collect 6 Gooey Spider Leg##2251 |goto 27.99,50.83 |q 93 |future
|tip Be careful not to accidentally sell these to a vendor.
You can find more around: |notinsticky
[33.54,50.07]
[32.44,35.72]
step
Enter the building |goto 28.03,31.49 < 5 |walk
talk Abercrombie##289
|tip Inside the building.
turnin The Hermit##165 |goto 28.11,31.47
accept Supplies from Darkshire##148 |goto 28.11,31.47
step
Kill enemies around this area
|tip Only enemies that look like ghouls will drop the quest item.
collect 10 Ghoul Fang##1129 |q 101/1 |goto 24.74,36.61
|tip These have a low drop rate.
You can find more inside the crypt at [23.59,34.89]
step
click A Weathered Grave
|tip Leave the crypt, if you went inside there in the previous step.
accept The Weathered Grave##225 |goto 17.72,29.08
step
talk Sven Yorgen##311
turnin Deliveries to Sven##164 |goto 7.78,34.07
accept Sven's Revenge##95 |goto 7.78,34.07
step
talk Chef Grual##272
|tip He walks around this area inside the building.
turnin Jitters' Growling Gut##5 |goto 73.78,43.45
accept Dusky Crab Cakes##93 |goto 73.78,43.45
step
talk Chef Grual##272
|tip He walks around this area inside the building.
turnin Dusky Crab Cakes##93 |goto 73.78,43.45
accept Return to Jitters##240 |goto 73.78,43.45
step
Leave the building |goto 73.82,46.01 < 10 |walk
talk Commander Althea Ebonlocke##264
|tip She walks around this area.
turnin The Night Watch##57 |goto 73.59,46.90
accept The Night Watch##58 |goto 73.59,46.90
step
Enter the building |goto 72.93,46.80 < 10 |walk
talk Sirra Von'Indi##268
|tip Inside the building.
turnin The Weathered Grave##225 |goto 72.64,47.62
accept Morgan Ladimore##227 |goto 72.64,47.62
step
Leave the building |goto 72.93,46.80 < 7 |walk
talk Commander Althea Ebonlocke##264
|tip She walks around this area.
turnin Morgan Ladimore##227 |goto 73.59,46.90
|tip You can destroy the "The Story of Morgan Ladimore" item after turning in this quest.
step
talk Calor##663
|tip He walks around this area in front of the building.
turnin Worgen in the Woods##222 |goto 75.30,48.05
accept Worgen in the Woods##223 |goto 75.30,48.05
step
Enter the building |goto 75.22,48.25 < 5 |walk
talk Jonathan Carevin##661
|tip He walks around inside the building.
turnin Worgen in the Woods##223 |goto 75.32,49.02
step
Leave the building |goto 75.22,48.25 < 7 |walk
Enter the building |goto 75.57,45.37 < 7 |walk
talk Madame Eva##265
|tip She walks around this area inside the building.
turnin The Totem of Infliction##101 |goto 75.81,45.29
turnin Supplies from Darkshire##148 |goto 75.81,45.29
accept Ghost Hair Thread##149 |goto 75.81,45.29
step
Leave the building |goto 75.57,45.37 < 5 |walk
Enter the building |goto 79.79,47.69 < 7 |walk
talk Viktori Prism'Antras##276
|tip Inside the building.
turnin Look To The Stars##181 |goto 79.80,48.02
step
Leave the building |goto 79.79,47.69 < 5 |walk
Enter the building |goto 81.68,59.13 < 7 |walk
talk Blind Mary##302
|tip Inside the building.
turnin Ghost Hair Thread##149 |goto 81.98,59.09
accept Return the Comb##154 |goto 81.98,59.09
step
Leave the building |goto 81.68,59.13 < 5 |walk
Follow the path |goto 77.50,59.86 < 30 |only if walking
Enter the building |goto 75.57,45.37 < 7 |walk
talk Madame Eva##265
|tip She walks around this area inside the building.
turnin Return the Comb##154 |goto 75.81,45.29
accept Deliver the Thread##157 |goto 75.81,45.29
step
Leave the building |goto 75.57,45.37 < 5 |walk
Follow the road |goto 74.97,52.11 < 30 |c |q 95
step
Follow the path |goto 61.89,61.88 < 30 |only if walking
Kill enemies around this area
Reach Level 29 |ding 29 |goto 63.21,72.26
step
Follow the road |goto 61.44,61.78 < 30 |only if walking
click Mound of loose dirt
|tip There are stealthed enemies around this area.
turnin Sven's Revenge##95 |goto 49.86,77.70
accept Sven's Camp##230 |goto 49.86,77.70
step
Follow the road |goto 43.55,65.09 < 30 |only if walking
talk Jitters##288
|tip He walks around this area.
turnin Return to Jitters##240 |goto 18.14,56.52
step
kill 20 Plague Spreader##604 |q 58/1 |goto 23.64,34.89
|tip Outside near the crypt, and inside the crypt.
You can find more surrounding the house outside the crypt around [17.97,33.55]
step
Enter the building |goto 28.02,31.49 < 5 |walk
talk Abercrombie##289
|tip Inside the building.
|tip Leave the crypt, if you went inside there in the previous step.
turnin Deliver the Thread##157 |goto 28.11,31.47
accept Zombie Juice##158 |goto 28.11,31.47
step
talk Sven Yorgen##311
turnin Sven's Camp##230 |goto 7.78,34.07
accept The Shadowy Figure##262 |goto 7.78,34.07
step
talk Tavernkeep Smitts##273
|tip He walks around this area inside the building.
turnin Zombie Juice##158 |goto 73.78,44.48
accept Gather Rot Blossoms##156 |goto 73.78,44.48
step
Leave the building |goto 73.83,46.01 < 10 |walk
talk Commander Althea Ebonlocke##264
|tip She walks around this area.
turnin The Night Watch##58 |goto 73.59,46.90
step
Enter the building |goto 75.55,45.37 < 7 |walk
talk Madame Eva##265
|tip She walks around this area inside the building.
turnin The Shadowy Figure##262 |goto 75.81,45.29
accept The Shadowy Search Continues##265 |goto 75.81,45.29
step
Leave the building |goto 75.55,45.37 < 5 |walk
Enter the building |goto 72.92,46.81 < 10 |walk
talk Clerk Daltry##267
|tip He walks around this area inside the building.
turnin The Shadowy Search Continues##265 |goto 72.53,46.85
accept Inquire at the Inn##266 |goto 72.53,46.85
step
Leave the building |goto 72.92,46.81 < 7 |walk
Enter the building |goto 73.82,46.03 < 7 |walk
talk Tavernkeep Smitts##273
|tip He walks around this area inside the building.
turnin Inquire at the Inn##266 |goto 73.78,44.48
accept Finding the Shadowy Figure##453 |goto 73.78,44.48
step
Leave the building |goto  73.83,45.99 < 7 |walk
Follow the road |goto Westfall 67.13,62.89 < 30 |only if walking
talk Jitters##288
|tip He walks around this area.
turnin Finding the Shadowy Figure##453 |goto Duskwood 18.14,56.52
accept Return to Sven##268 |goto Duskwood 18.14,56.52
step
Kill Skeletal enemies around this area
|tip Only Skeletal Fiends and Skeletal Horrors will drop the quest item.
collect 8 Rot Blossom##1598 |q 156/1 |goto 15.20,44.97
You can find more around: |notinsticky
[21.50,47.70]
[22.93,43.21]
step
talk Sven Yorgen##311
turnin Return to Sven##268 |goto 7.78,34.06
accept Proving Your Worth##323 |goto 7.78,34.06
stickystart "Kill_Skeletal_Healers"
stickystart "Kill_Skeletal_Raiders"
step
Enter the crypt |goto 15.88,38.73 < 10 |walk
kill 3 Skeletal Warder##785 |q 323/3 |goto 15.53,37.02
|tip Inside the crypt.
|tip Be careful of Mor'Ladim, a 35 elite skeleton who walks around this area outside the crypt.
You can find more inside the crypt around [16.01,34.05]
step
label "Kill_Skeletal_Healers"
kill 3 Skeletal Healer##787 |q 323/2 |goto 15.87,38.73
|tip Inside the crypt.
|tip You can find more outside the crypt.
|tip Be careful of Mor'Ladim, a 35 elite skeleton who walks around this area outside the crypt.
You can find more inside the crypt around [16.01,34.05]
step
label "Kill_Skeletal_Raiders"
Run up the stairs |goto 15.44,37.59 < 7 |walk
Leave the crypt |goto 15.87,38.73 < 10 |walk
kill 15 Skeletal Raider##1110 |q 323/1 |goto 15.87,38.73
|tip Inside and outside the crypt.
|tip They seem to be mostly outside the crypt.
|tip If you go to the house to kill more, be careful of the elite enemy upstairs inside the house.
|tip Be careful of Mor'Ladim, a 35 elite skeleton who walks around this area outside the crypt.
You can find more around and inside the house outside the crypt around [17.30,34.99]
step
talk Sven Yorgen##311
|tip Leave the crypt, if you went in there for the previous guide steps.
turnin Proving Your Worth##323 |goto 7.78,34.06
accept Seeking Wisdom##269 |goto 7.78,34.06
step
Enter the building |goto 73.82,46.02 < 7 |walk
talk Tavernkeep Smitts##273
|tip He walks around this area inside the building.
turnin Gather Rot Blossoms##156 |goto 73.78,44.48
accept Juice Delivery##159 |goto 73.78,44.48
step
Leave the building |goto 73.82,46.02 < 7 |walk
Follow the path |goto Westfall 64.22,41.87 < 40 |only if walking
Enter the building |goto Duskwood 28.02,31.48 < 5 |walk
talk Abercrombie##289
|tip Inside the building.
turnin Juice Delivery##159 |goto Duskwood 28.11,31.47
accept Ghoulish Effigy##133 |goto Duskwood 28.11,31.47
step
Kill enemies around this area
|tip Inside and outside the crypt.
|tip Only enemies that look like ghouls will drop the quest item.
collect 7 Ghoul Rib##884 |q 133/1 |goto 23.55,34.98
step
Enter the building |goto 28.02,31.48 < 5 |walk
talk Abercrombie##289
|tip Inside the building.
|tip Leave the crypt, if you went inside of it for the previous guide step.
turnin Ghoulish Effigy##133 |goto 28.11,31.47
accept Ogre Thieves##134 |goto 28.11,31.47
step
click Abercrombie's Crate
collect Abercrombie's Crate##1349 |q 134/1 |goto 33.42,76.34
step
Follow the path up |goto 31.34,67.17 < 15 |only if walking
Enter the building |goto 28.02,31.48 < 5 |walk
talk Abercrombie##289
|tip Inside the building.
|tip Leave the crypt, if you went inside of it for the previous guide step.
turnin Ogre Thieves##134 |goto 28.11,31.47
accept Note to the Mayor##160 |goto 28.11,31.47
step
Leave the building |goto 73.83,46.00 < 7 |walk
Enter the building |goto 72.93,46.81 < 10 |walk
talk Lord Ello Ebonlocke##263
|tip Inside the building.
turnin Note to the Mayor##160 |goto 71.93,46.42
accept Translate Abercrombie's Note##251 |goto 71.93,46.42
step
talk Sirra Von'Indi##268
|tip Inside the building.
turnin Translate Abercrombie's Note##251 |goto 72.64,47.62
accept Wait for Sirra to Finish##401 |goto 72.64,47.62
step
talk Sirra Von'Indi##268
|tip Inside the building.
turnin Wait for Sirra to Finish##401 |goto 72.64,47.62
accept Translation to Ello##252 |goto 72.64,47.62
step
talk Lord Ello Ebonlocke##263
|tip Inside the building.
turnin Translation to Ello##252 |goto 71.93,46.42
|tip You can destroy the "Translated Letter from The Embalmer" item after turning in this quest.
step
Leave the building |goto 72.93,46.81 < 7 |c |q 1274 |future
step
Follow the path up behind the building |goto 71.08,45.94 < 10 |walk
Kill enemies around this area
Reach Level 30 |ding 30 |goto 62.31,43.48
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (30-35)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (35-40)",
startlevel=30,
endlevel=35,
},[[
step
Enter the building |goto Stormwind City 43.05,34.48 < 10 |walk
talk Thomas##4982
|tip He walks around this area inside the building.
accept The Missing Diplomat##1274 |goto Stormwind City 41.53,31.65
step
talk Bishop Farthing##1212
|tip Inside the building.
turnin Seeking Wisdom##269 |goto 39.13,27.90
accept The Doomed Fleet##270 |goto 39.13,27.90
step
Leave the building |goto 43.07,34.47 < 7 |walk
Enter the building |goto 69.07,28.77 < 7 |walk
Follow the path |goto 77.91,20.18 < 7 |walk
talk Bishop DeLavey##4960
|tip Inside the building.
turnin The Missing Diplomat##1274 |goto 78.30,25.44
accept The Missing Diplomat##1241 |goto 78.30,25.44
step
Follow the path |goto 77.04,19.34 < 7 |walk
Continue following the path |goto 72.72,22.87 < 7 |walk
Continue following the path |goto 70.16,11.36 < 7 |walk
talk Milton Sheaf##1440
|tip Inside the building.
turnin An Old History Book##337 |goto 74.16,7.50
accept Southshore##538 |goto 74.16,7.50
step
Follow the path |goto 70.25,11.28 < 7 |walk
Continue following the path |goto 69.78,17.27 < 7 |walk
Continue following the path |goto 72.72,22.86 < 7 |walk
Leave the building |goto 69.05,28.73 < 10 |walk
Follow the path |goto 60.27,68.37 < 20 |only if walking
talk Jorgen##4959
turnin The Missing Diplomat##1241 |goto 73.17,78.42
accept The Missing Diplomat##1242 |goto 73.17,78.42
step
Leave Stormwind City |goto 71.10,88.94 < 30 |only if walking
Enter the building |goto Elwynn Forest 42.95,65.64 < 7 |walk
talk Innkeeper Farley##295
|tip Inside the building.
turnin The Legend of Stalvan##69 |goto Elwynn Forest 43.77,65.80
accept The Legend of Stalvan##70 |goto Elwynn Forest 43.77,65.80
step
click Storage Chest
|tip Upstairs inside the building.
collect An Undelivered Letter##910 |q 70/1 |goto 44.29,65.82
step
Leave the building |goto 42.95,65.65 < 7 |walk
Enter Stormwind City |goto 32.02,49.25 < 30 |only if walking
Enter the building |goto Stormwind City 59.96,64.19 < 7 |walk
talk Elling Trias##482
|tip Upstairs inside the building.
turnin The Missing Diplomat##1242 |goto Stormwind City 59.91,64.17
accept The Missing Diplomat##1243 |goto Stormwind City 59.91,64.17
step
Leave the building |goto 59.97,64.17 < 5 |walk
talk Caretaker Folsom##297
turnin The Legend of Stalvan##70 |goto 29.58,61.93
accept The Legend of Stalvan##72 |goto 29.58,61.93
step
click Sealed Crate
turnin The Legend of Stalvan##72 |goto 29.46,61.58
accept The Legend of Stalvan##74 |goto 29.46,61.58
step
Enter the building |goto 74.90,51.56 < 10 |walk
Enter the building |goto 77.97,48.19 < 10 |walk
talk Wu Shen##5479
|tip Upstairs inside the building.
accept The Islander##1718 |goto 78.68,45.80
|only if Warrior
step
Leave the building |goto 77.97,48.19 < 10 |walk
Leave the building |goto 74.90,51.56 < 10 |c |q 270
|only if Warrior
step
Run up the ramp |goto 62.41,62.29 < 10 |only if walking
Enter the building |goto Wetlands 10.79,59.76 < 7 |walk
talk Glorin Steelbrow##1217
|tip Inside the building.
turnin The Doomed Fleet##270 |goto Wetlands 10.59,60.59
accept Lightforge Iron##321 |goto Wetlands 10.59,60.59
step
Leave the building |goto 10.79,59.77 < 7 |walk
click Waterlogged Chest
turnin Lightforge Iron##321 |goto 12.10,64.17
accept The Lost Ingots##324 |goto 12.10,64.17
step
kill Bluegill Raider##1418+
|tip Underwater and on the land around this area.
collect 5 Lightforge Ingot##2702 |q 324/1 |goto 11.19,64.73
|tip These have a low drop rate.
You can find more around [9.28,70.11]
step
Enter the building |goto 10.79,59.76 < 7 |walk
talk Glorin Steelbrow##1217
|tip Inside the building.
turnin The Lost Ingots##324 |goto 10.59,60.59
accept Blessed Arm##322 |goto 10.59,60.59
step
Leave the building |goto 10.79,59.76 < 7 |walk
talk Innkeeper Kimlya##6738
|tip Upstairs inside the building.
home Astranaar |goto Ashenvale 36.99,49.22
step
Follow the road |goto 32.71,47.08 < 30 |only if walking
Follow the path down |goto 27.93,48.71 < 20 |only if walking
talk Sentinel Melyria Frostshadow##3880
accept The Howling Vale##1022 |goto 22.23,52.98
step
talk Illiyana##3901
accept Vile Satyr! Dryads in Danger!##1021 |goto 21.73,53.34
step
Follow the road |goto 38.44,57.76 < 30 |c |q 1140
step
Follow the road |goto 67.11,71.92 < 30 |only if walking
Enter the Barrens |goto The Barrens 48.98,5.34 < 20 |only if walking
Follow the road |goto The Barrens 48.95,13.40 < 30 |only if walking
Avoid Crossroads and follow the road |goto The Barrens 54.58,33.13 < 30 |only if walking
Continue following the road |goto The Barrens 59.68,38.93 < 30 |only if walking
talk Bragok##16227
fapth Ratchet |goto The Barrens 63.09,37.16
|only if Warrior
step
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
Follow the road |goto 62.68,38.03 < 30 |only if walking
Avoid Crossroads |goto 54.12,30.50 < 40 |only if walking
Follow the road |goto 52.38,20.03 < 30 |only if walking
Enter Ashenvale |goto 48.98,5.38 < 20 |only if walking
Follow the road |goto Ashenvale 68.48,83.68 < 30 |only if walking
Continue following the road |goto Ashenvale 66.88,71.33 < 30 |c |q 1140
|only if Warrior
step
Continue following the road |goto Ashenvale 59.74,62.67 < 30 |only if walking
Follow the path up |goto Ashenvale 63.06,44.21 < 30 |only if walking
Follow the path |goto Ashenvale 65.59,44.43 < 30 |only if walking
click Circle of Imprisonment
Free the Highborne Soul in Night Run |q 1140/1 |goto Ashenvale 66.63,56.98
step
Follow the path |goto 66.62,47.34 < 30 |only if walking
Kill Ancient enemies around this area
|tip They look like walking trees around this area.
collect Wooden Key##5475 |goto 61.60,43.79 |q 1026
You can find more around: |notinsticky
[58.22,41.41]
[60.11,38.71]
[57.67,32.39]
[54.97,34.00]
step
Follow the path up |goto 54.54,34.56 < 15 |only if walking
click Worn Chest
collect Iron Shaft##5464 |q 1026/1 |goto 54.41,35.39
step
Follow the path up |goto 54.17,32.34 < 15 |only if walking
Enter the tunnel |goto 52.92,37.64 < 10 |only if walking
Leave the tunnel |goto 51.28,38.23 < 10 |only if walking
click Tome of Mel'Thandris
View the Tome of Mel'Thandris |q 1022/1 |goto 50.49,39.13
step
Follow the path up |goto 49.99,38.37 < 10 |only if walking
Enter the tunnel |goto 51.33,38.20 < 10 |only if walking
Leave the tunnel |goto 52.92,37.63 < 10 |only if walking
Follow the road |goto 55.85,34.05 < 30 |only if walking
Follow the path up |goto 61.03,45.59 < 20 |only if walking
Follow the path |goto 60.93,51.64 < 30 |only if walking
Continue following the path |goto 57.38,56.02 < 30 |only if walking
Continue following the path |goto 53.02,54.43 < 30 |only if walking
Continue following the path |goto 50.99,52.15 < 30 |only if walking
Continue following the path |goto 51.29,45.61 < 30 |only if walking
talk Shael'dryn##3916
|tip She walks around this area.
turnin Raene's Cleansing##1026 |goto 53.53,46.21
accept Raene's Cleansing##1027 |goto 53.53,46.21
step
Follow the path |goto 50.93,45.99 < 30 |only if walking
Follow the road |goto 51.73,58.12 < 30 |only if walking
Follow the path |goto 83.66,50.23 < 30 |only if walking
talk Kayneth Stillwind##3848
turnin Kayneth Stillwind##4581 |goto 85.27,44.72
accept Forsaken Diseases##1011 |goto 85.27,44.72
step
Follow the path up |goto 83.04,48.28 < 20 |only if walking
talk Anilia##3920
turnin Vile Satyr! Dryads in Danger!##1021 |goto 78.32,44.82
accept The Branch of Cenarius##1031 |goto 78.32,44.82
step
Follow the path |goto 78.35,43.80 < 15 |only if walking
kill Geltharis##4619
collect Branch of Cenarius##5461 |q 1031/1 |goto 78.00,42.42
step
Follow the path down |goto 79.98,47.13 < 20 |only if walking
click Circle of Imprisonment
Free the Highborne Soul in Satyrnaar |q 1140/2 |goto 81.60,48.58
stickystart "Collect_Iron_Pommel"
step
Follow the path up |goto 81.47,51.46 < 20 |only if walking
Follow the road |goto 82.10,53.13 < 20 |only if walking
Continue following the road |goto 77.31,57.09 < 30 |only if walking
Follow the path |goto 76.18,67.33 < 30 |only if walking
click Bottle of Disease
|tip This camp is surrounded by stealthed enemies.
|tip Kill them before running into the camp.
collect Bottle of Disease##5440 |q 1011/1 |goto 75.29,72.22
step
label "Collect_Iron_Pommel"
kill Rotting Slime##3928+
click Rusty Chest+
|tip They appear after you kill the Rotting Slimes.
collect Iron Pommel##5519 |q 1027/1 |goto 74.39,69.78
You can find more around: |notinsticky
[70.95,74.87]
[73.50,73.46]
[74.24,76.26]
step
Follow the path |goto 69.89,75.67 < 30 |only if walking
kill Shadethicket Oracle##3931
collect Fallen Moonstone##5508 |q 1035/1 |goto 66.68,82.19
step
Follow the road |goto 67.73,79.96 < 30 |only if walking
Continue following the road |goto 67.24,71.44 < 30 |only if walking
Follow the path |goto 83.66,50.23 < 30 |only if walking
talk Kayneth Stillwind##3848
turnin Forsaken Diseases##1011 |goto 85.27,44.72
step
Follow the road |goto 87.72,49.78 < 30 |only if walking
Cross the bridge |goto 94.74,47.77 < 20 |only if walking
talk Jarrodenus##12577
fpath Talrendis Point |goto Azshara 11.90,77.59
step
Enter the building |goto Ashenvale 37.19,51.87 < 7 |walk
talk Pelturas Whitemoon##3894
|tip Inside the building.
turnin Fallen Sky Lake##1035 |goto Ashenvale 37.36,51.79
step
Leave the building |goto 37.20,51.86 < 5 |walk
Follow the road |goto 32.71,47.08 < 30 |only if walking
Follow the path down |goto 27.93,48.71 < 20 |only if walking
talk Sentinel Melyria Frostshadow##3880
turnin The Howling Vale##1022 |goto 22.24,52.98
accept Velinde Starsong##1037 |goto 22.24,52.98
step
talk Illiyana##3901
turnin The Branch of Cenarius##1031 |goto 21.73,53.34
accept Satyr Slaying!##1032 |goto 21.73,53.34
step
Follow the path up |goto 26.79,49.21 < 20 |only if walking
Follow the road |goto 28.37,48.37 < 30 |only if walking
Continue following the road |goto 32.19,46.97 < 30 |only if walking
Cross the bridge |goto Azshara 10.56,75.07 < 20 |only if walking
Follow the road |goto Ashenvale 92.55,46.45 < 30 |only if walking
Follow the path down |goto Ashenvale 82.06,52.63 < 20 |only if walking
Kill Bleakheart enemies around this area
|tip Some of them are stealthed, so be careful.
collect 16 Satyr Horns##5481 |q 1032/1 |goto Ashenvale 80.86,50.01
step
Kill enemies around this area
Reach Level 31 |ding 31 |goto 81.03,50.67
step
Follow the road |goto 82.32,52.76 < 20 |only if walking
Cross the bridge |goto 94.74,47.77 < 20 |only if walking
Follow the road |goto 38.27,57.67 < 30 |only if walking
Follow the path |goto 50.15,56.28 < 30 |only if walking
Continue following the path |goto 51.31,45.58 < 30 |only if walking
talk Shael'dryn##3916
|tip She walks around this area.
turnin Raene's Cleansing##1027 |goto 53.54,46.21
step
Watch the dialogue
talk Shael'dryn##3916
|tip She walks around this area.
accept Raene's Cleansing##1028 |goto 53.54,46.21
step
Follow the path |goto 51.25,45.90 < 30 |only if walking
Continue following the path |goto 51.37,52.80 < 30 |only if walking
Follow the path up |goto 53.86,53.93 < 20 |only if walking
Continue up the path |goto 54.72,50.83 < 15 |only if walking
Continue up the path |goto 56.95,52.14 < 15 |only if walking
click Hidden Shrine
turnin Raene's Cleansing##1028 |goto 56.38,49.23
accept Raene's Cleansing##1055 |goto 56.38,49.23
step
Follow the path |goto 53.26,54.50 < 30 |only if walking
Continue following the path |goto 51.08,52.32 < 30 |only if walking
Continue following the path |goto 51.31,45.58 < 30 |only if walking
talk Shael'dryn##3916
|tip She walks around this area.
turnin Raene's Cleansing##1055 |goto 53.54,46.21
accept Raene's Cleansing##1029 |goto 53.54,46.21
step
Follow the path |goto 51.25,45.90 < 30 |only if walking
Follow the road |goto 49.29,57.21 < 30 |only if walking
Continue following the road |goto 41.03,57.60 < 30 |only if walking
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Raene's Cleansing##1029 |goto 36.62,49.58
accept Raene's Cleansing##1030 |goto 36.62,49.58
step
Follow the road |goto 38.37,57.71 < 30 |only if walking
Follow the path down |goto 51.23,58.51 < 30 |only if walking
use Dartol's Rod of Transformation##5462
|tip Use it at this location.
Gain Furbolg Form |havebuff 134297 |goto 54.00,72.61 |q 1030
step
Follow the path up |goto 53.85,73.90 < 20 |only if walking
talk Krolg##3897
turnin Raene's Cleansing##1030 |goto 50.85,75.07
accept Raene's Cleansing##1045 |goto 50.85,75.07
stickystart "Kill_Bloodtooth_Guards"
step
Follow the path |goto 53.77,73.97 < 20 |only if walking
Follow the path up |goto 55.36,76.27 < 30 |only if walking
kill Ran Bloodtooth##3696 |q 1045/1 |goto 54.74,79.61
collect Ran Bloodtooth's Skull##5388 |goto 54.74,79.61 |q 1045
step
label "Kill_Bloodtooth_Guards"
kill 4 Bloodtooth Guard##3932 |q 1045/2 |goto 54.56,79.12
step
Follow the path up |goto 55.06,75.26 < 15 |only if walking
use Dartol's Rod of Transformation##5462
|tip Use it at this location.
Gain Furbolg Form |havebuff 134297 |goto 54.26,74.32 |q 1045
step
Follow the path up |goto 53.85,73.90 < 20 |only if walking
talk Krolg##3897
turnin Raene's Cleansing##1045 |goto 50.85,75.07
accept Raene's Cleansing##1046 |goto 50.85,75.07
step
talk Raene Wolfrunner##3691
|tip Inside the building.
turnin Raene's Cleansing##1046 |goto 36.62,49.58
step
Follow the road |goto 32.71,47.08 < 30 |only if walking
Follow the path down |goto 27.93,48.71 < 20 |only if walking
talk Illiyana##3901
turnin Satyr Slaying!##1032 |goto 21.73,53.34
step
Follow the path up |goto 25.37,48.35 < 20 |only if walking
Follow the road |goto 26.26,45.83 < 30 |only if walking
talk Delgren the Purifier##3663
turnin The Tower of Althalaxx##1140 |goto 26.19,38.70
step
Follow the road |goto 25.54,38.46 < 20 |only if walking
Cross the bridge |goto Darnassus 43.84,41.17 < 15 |only if walking
talk Mathiel##6142
accept Klockmort's Essentials##2925 |goto Darnassus 59.50,45.38
step
Follow the path up |goto 56.62,41.11 < 15 |only if walking
talk Thyn'tel Bladeweaver##8026
turnin Velinde Starsong##1037 |goto 61.78,39.19
accept Velinde's Effects##1038 |goto 61.78,39.19
step
Run up the ramp |goto 58.90,55.50 < 7 |only if walking
talk Auctioneer Golothas##8723
|tip Inside the building.
|tip Buy these items from the Auction House.
|tip Be careful not to accidentally sell these to a vendor.
collect Hillman's Cloak##3719 |goto 56.24,54.04 |q 565 |future
|tip If there's none on the Auction House, try to get a Leatherworker to create one for you in trade chat.
collect Bolt of Woolen Cloth##2997 |goto 56.24,54.04 |q 565 |future
step
Run up the ramp |goto 56.05,79.18 < 7 |only if walking
Cross the bridge |goto 57.63,77.23 < 5 |only if walking
click Velinde's Locker
|tip Upstairs inside the building.
collect Velinde's Journal##5520 |q 1038/1 |goto 62.29,83.24
step
Run up the ramp |goto 62.07,51.91 < 15 |only if walking
talk Thyn'tel Bladeweaver##8026
turnin Velinde's Effects##1038 |goto 61.78,39.19
accept The Barrens Port##1039 |goto 61.78,39.19
step
Enter the building |goto Wetlands 10.79,59.76 < 7 |walk
talk Innkeeper Helbrek##1464
|tip Inside the building.
home Deepwater Tavern |goto Wetlands 10.70,60.96
step
Leave the building |goto 10.79,59.77 < 5 |walk
Follow the path |goto 10.96,54.59 < 20 |only if walking
Follow the path up |goto 16.01,23.09 < 5 |only if walking
kill Captain Halyndor##1160
|tip On the deck of the ship.
collect Intrepid Strongbox Key##2629 |q 290/1 |goto 15.45,23.61
step
Swim underwater through the hole in the bottom of the ship |goto 14.35,23.68 < 5 |walk
click Intrepid's Locked Strongbox
|tip Underwater, at the bottom of the ship.
turnin Lifting the Curse##290 |goto 14.37,24.02
accept The Eye of Paleth##292 |goto 14.37,24.02
step
Swim out of the hole in the ship |goto 14.31,23.69 < 5 |walk
Follow the road |goto 25.10,42.26 < 30 |only if walking
Follow the path up |goto 42.87,40.78 < 30 |only if walking
click Dragonmaw Catapult
turnin Nek'rosh's Gambit##465 |goto 47.40,46.90
step
Follow the road |goto 51.19,40.21 < 30 |only if walking
click Musquash Root
collect Musquash Root##2784 |q 335/2 |goto 64.76,75.29
step
talk Glorin Steelbrow##1217
|tip Inside the building.
turnin The Eye of Paleth##292 |goto 10.59,60.59
accept Cleansing the Eye##293 |goto 10.59,60.59
step
Leave the building |goto 10.79,59.76 < 7 |walk
talk Harlo Barnaby##2097
accept Fall of Dun Modr##472 |goto 10.85,55.90
step
Follow the road |goto 12.48,50.14 < 30 |only if walking
Continue following the road |goto 48.97,27.27 < 30 |only if walking
talk Longbraid the Grim##1071
turnin Fall of Dun Modr##472 |goto 49.80,18.26
step
talk Rhag Garmason##1075
accept The Thandol Span##631 |goto 49.92,18.21
step
Follow the path |goto 51.06,11.72 < 20 |only if walking
Enter the building and run down the stairs |goto 51.36,8.11 < 5 |walk
click Ebenezer Rustlocke's Corpse
|tip Downstairs inside the building.
|tip There are elite enemies inside the building, but they are a couple of levels below you.
|tip You should be able to kill them by yourself, if you're careful.
|tip You will be attacked by two non-elite enemies after turning in the quest.
turnin The Thandol Span##631 |goto 51.28,7.95
accept The Thandol Span##632 |goto 51.28,7.95
step
Run up the stairs |goto 51.04,8.28 < 5 |c |q 632
step
Run up the stairs and leave the building |goto 50.69,8.00 < 5 |walk
Follow the path |goto 51.08,11.74 < 30 |only if walking
talk Rhag Garmason##1075
turnin The Thandol Span##632 |goto 49.92,18.22
accept The Thandol Span##633 |goto 49.92,18.22
step
Cross the bridge |goto 51.11,11.58 < 20 |only if walking
Cross the hanging bridge |goto Arathi Highlands 45.96,88.11 < 10 |only if walking
click Cache of Explosives
Destroy the Cache of Explosives |q 633/1 |goto Arathi Highlands 48.73,88.05
step
Cross the hanging bridge |goto 48.14,88.11 < 10 |only if walking
Cross the bridge |goto 45.47,89.24 < 20 |only if walking
talk Rhag Garmason##1075
turnin The Thandol Span##633 |goto Wetlands 49.92,18.22
accept Plea To The Alliance##634 |goto Wetlands 49.92,18.22
step
Cross the bridge |goto 51.11,11.66 < 20 |only if walking
Follow the road |goto Arathi Highlands 45.39,88.84 < 30 |only if walking
Continue following the road |goto Arathi Highlands 45.09,58.64 < 30 |only if walking
Follow the path down |goto Arathi Highlands 43.96,51.17 < 30 |only if walking
talk Captain Nials##2700
turnin Plea To The Alliance##634 |goto Arathi Highlands 45.83,47.55
step
talk Cedrik Prose##2835
fpath Refuge Pointe |goto 45.76,46.12
step
Follow the path up |goto 44.47,48.47 < 20 |only if walking
Follow the road |goto 42.27,54.87 < 30 |only if walking
Enter Hillsbrad Foothills |goto 20.17,29.54 < 30 |only if walking
talk Darla Harris##2432
fpath Southshore |goto Hillsbrad Foothills 49.34,52.27
step
talk Bartolo Ginsetti##2438
accept Bartolo's Yeti Fur Cloak##565 |goto 49.43,55.53
step
talk Loremaster Dibbs##2277
turnin Southshore##538 |goto 50.57,57.09
step
talk Darren Malvew##2382
accept Costly Menace##564 |goto 52.42,55.96
step
Enter the building |goto 50.45,58.55 < 7 |walk
talk Innkeeper Anderson##2352
|tip Inside the building.
home Southshore |goto 51.17,58.93
step
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
accept Down the Coast##536 |goto 51.46,58.38
stickystart "Kill_Torn_Fin_Oracles"
step
Leave the building |goto 50.45,58.55 < 7 |walk
kill 10 Torn Fin Tidehunter##2377 |q 536/1 |goto 46.55,64.38
|tip You can find more in the water along the shore.
You can find more around: |notinsticky
[43.51,67.70]
[37.04,68.74]
step
label "Kill_Torn_Fin_Oracles"
kill 10 Torn Fin Oracle##2376 |q 536/2 |goto 46.55,64.38
|tip You can find more in the water along the shore.
You can find more around: |notinsticky
[43.51,67.70]
[37.04,68.74]
step
Kill enemies around this area
Reach Level 32 |ding 32 |goto 46.55,64.38
|tip You can find more in the water along the shore.
You can find more around: |notinsticky
[43.51,67.70]
[37.04,68.74]
step
Enter the building |goto 50.45,58.55 < 7 |walk
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Down the Coast##536 |goto 51.46,58.38
accept Farren's Proof##559 |goto 51.46,58.38
step
Leave the building |goto 50.45,58.55 < 7 |walk
Kill Torn Fin enemies around this area
|tip You can find more in the water along the shore.
collect 10 Murloc Head##3716 |q 559/1 |goto 46.55,64.38
You can find more around: |notinsticky
[43.51,67.70]
[37.04,68.74]
step
Enter the building |goto 50.45,58.55 < 7 |walk
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Farren's Proof##559 |goto 51.46,58.38
accept Farren's Proof##560 |goto 51.46,58.38
step
Leave the building |goto 50.45,58.55 < 7 |walk
talk Marshal Redpath##2263
turnin Farren's Proof##560 |goto 49.48,58.73
accept Farren's Proof##561 |goto 49.48,58.73
step
Enter the building |goto 50.45,58.55 < 7 |walk
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Farren's Proof##561 |goto 51.46,58.38
accept Stormwind Ho!##562 |goto 51.46,58.38
stickystart "Kill_Daggerspine_Sirens"
step
Leave the building |goto 50.45,58.55 < 7 |walk
kill 10 Daggerspine Shorehunter##2369 |q 562/1 |goto 53.42,64.21
|tip You can find more in the water along the shore.
You can find more around: |notinsticky
[57.57,66.32]
[60.95,75.24]
step
label "Kill_Daggerspine_Sirens"
kill 10 Daggerspine Siren##2371 |q 562/2 |goto 53.42,64.21
|tip You can find more in the water along the shore.
You can find more around: |notinsticky
[57.57,66.32]
[60.95,75.24]
step
Enter the building |goto 50.45,58.55 < 7 |walk
talk Lieutenant Farren Orinelle##2228
|tip Inside the building.
turnin Stormwind Ho!##562 |goto 51.46,58.38
accept Reassignment##563 |goto 51.46,58.38
step
talk Chef Jessen##2430
|tip Inside the building.
accept Soothing Turtle Bisque##555 |goto 51.89,58.68
step
Leave the building |goto 50.45,58.55 < 7 |walk
Enter the building |goto 49.31,55.49 < 7 |walk
talk Micha Yance##2381
|tip Inside the building.
buy Soothing Spices##3713 |q 555/2 |goto 48.94,55.03
|tip Be careful not to accidentally sell this to a vendor.
step
Leave the building |goto 49.31,55.49 < 7 |walk
kill Snapjaw##2408+
collect 10 Turtle Meat##3712 |q 555/1 |goto 55.82,57.06
|tip Be careful not to accidentally sell these to a vendor.
You can find more around: |notinsticky
[57.26,48.03]
[61.94,43.03]
[65.30,39.18]
[67.57,35.26]
[68.21,23.03]
[70.16,12.16]
step
Kill Yeti enemies around this area
|tip Inside and outside the cave.
|tip Be careful to avoid Tarren Mill, if you went far north for the Turtle Meat in the previous step.
collect 10 Yeti Fur##3720 |q 565/4 |goto 46.23,31.90
stickystart "Kill_Hulking_Mountain_Lions"
step
Follow the path up |goto Alterac Mountains 43.24,77.94 < 20 |only if walking
kill 8 Mountain Lion##2406 |q 564/1 |goto Alterac Mountains 46.70,77.31
You can find more around: |notinsticky
[37.69,85.48]
[32.86,83.10]
step
label "Kill_Hulking_Mountain_Lions"
kill 10 Hulking Mountain Lion##2407 |q 564/2 |goto 46.70,77.31
You can find more around: |notinsticky
[37.69,85.48]
[32.86,83.10]
step
talk Chef Jessen##2430
|tip Inside the building.
turnin Soothing Turtle Bisque##555 |goto Hillsbrad Foothills 51.89,58.68
step
Leave the building |goto 50.45,58.55 < 7 |walk
talk Darren Malvew##2382
turnin Costly Menace##564 |goto 52.42,55.97
step
Enter the building |goto 49.31,55.48 < 7 |walk
talk Micha Yance##2381
|tip Inside the building.
buy Fine Thread##2321 |q 565/2 |goto 48.94,55.03
step
talk Bartolo Ginsetti##2438
turnin Bartolo's Yeti Fur Cloak##565 |goto 49.43,55.53
step
talk Captain Nials##2700
accept Northfold Manor##681 |goto Arathi Highlands 45.83,47.55
stickystart "Kill_Syndicate_Mercenaries"
step
Follow the path up |goto 44.46,48.47 < 20 |only if walking
kill 10 Syndicate Highwayman##2586 |q 681/1 |goto 32.67,29.22
|tip Some of them are stealthed, so be careful.
|tip They are also inside the buildings.
|tip You can find more stealted along the small hill ridges surrounding this village.
step
label "Kill_Syndicate_Mercenaries"
kill 6 Syndicate Mercenary##2589 |q 681/2 |goto 32.67,29.22
|tip They are also inside the buildings.
|tip Be careful, some enemies can be stealthed around this area.
step
talk Captain Nials##2700
turnin Northfold Manor##681 |goto 45.83,47.55
step
Follow the path up |goto 44.46,48.47 < 20 |only if walking
Kill enemies around this area
Reach Level 33 |ding 33 |goto 41.51,42.56
step
talk Roetten Stonehammer##5637
|tip He walks around inside the building.
accept Reclaimers' Business in Desolace##1453 |goto Ironforge 67.91,17.49
step
talk Prospector Stormpike##1356
|tip Inside the building.
turnin Letter to Stormpike##514 |goto 74.64,11.73
step
talk Klockmort Spannerspan##6169
turnin Klockmort's Essentials##2925 |goto 67.93,46.10
step
Enter the building |goto 66.36,82.45 < 7 |walk
talk Pilot Longbeard##2092
|tip Inside the building.
accept The Brassbolts Brothers##1179 |goto 72.73,94.01
step
Leave the building |goto 66.36,82.45 < 7 |walk
Enter the building |goto Stormwind City 53.50,64.86 < 7 |walk
talk Innkeeper Allison##6740
|tip Inside the building.
home Stormwind City |goto Stormwind City 52.62,65.70
step
Leave the building |goto 53.50,64.86 < 5 |walk
talk Archmage Malin##2708
accept Malin's Request##690 |goto 39.77,81.44
step
Enter the building |goto 29.19,74.12 < 7 |walk
talk Zardeth of the Black Claw##1435
|tip Downstairs inside the building.
turnin A Noble Brew##335 |goto 26.45,78.65
accept A Noble Brew##336 |goto 26.45,78.65
step
Go upstairs and leave the building |goto 29.18,74.12 < 5 |walk
Enter the building |goto 43.05,34.48 < 10 |walk
talk Archbishop Benedictus##1284
|tip Inside the building.
turnin Cleansing the Eye##293 |goto 39.59,27.25
step
Leave the building |goto 43.06,34.47 < 10 |walk
Enter the building |goto 51.82,13.27 < 7 |walk
talk Grimand Elmore##1416
|tip Inside the building.
turnin Blessed Arm##322 |goto 51.76,12.06
step
Leave the building |goto 51.82,13.27 < 5 |walk
Enter the building |goto 69.05,28.75 < 10 |walk
Follow the path |goto 72.71,25.85 < 7 |walk
talk Lord Baurles K. Wishock##1439
|tip Inside the building.
turnin A Noble Brew##336 |goto 75.23,31.67
step
Follow the path |goto 72.73,25.89 < 7 |walk
Follow the path |goto 76.68,17.75 < 7 |walk
talk Major Samuelson##2439
|tip Inside the building.
turnin Reassignment##563 |goto 72.60,15.87
step
Follow the path |goto 76.04,17.50 < 7 |walk
Leave the building |goto 69.01,28.83 < 10 |walk
Enter the building |goto 54.11,59.01 < 7 |walk
talk Auctioneer Jaxon##15659
|tip Inside the building.
|tip Buy these items from the Auction House.
collect 4 Lesser Bloodstone Ore##4278 |goto 53.61,59.77 |q 627 |future
step
Run up the ramp |goto 62.41,62.26 < 10 |only if walking
Follow the road |goto Redridge Mountains 29.00,67.62 < 30 |only if walking
Continue following the road |goto Redridge Mountains 7.82,71.56 < 30 |only if walking
talk Marshal Haggard##294
turnin The Legend of Stalvan##74 |goto Elwynn Forest 84.61,69.38
accept The Legend of Stalvan##75 |goto Elwynn Forest 84.61,69.38
step
Enter the building |goto 85.12,69.70 < 7 |walk
click  Marshal Haggard's Chest
|tip Upstairs inside the building.
collect A Faded Journal Page##921 |q 75/1 |goto 85.69,69.55
step
Leave the building |goto 85.11,69.71 < 5 |walk
talk Marshal Haggard##294
turnin The Legend of Stalvan##75 |goto Elwynn Forest 84.61,69.38
accept The Legend of Stalvan##78 |goto Elwynn Forest 84.61,69.38
step
Follow the road |goto Duskwood 87.58,18.12 < 30 |only if walking
talk Watcher Backus##840
|tip He walks along this road.
turnin The Missing Diplomat##1243 |goto Duskwood 73.06,32.80
He walks on the road between this location and [Duskwood 74.84,44.77]
step
Enter the building |goto 73.82,46.02 < 7 |walk
talk Tavernkeep Smitts##273
|tip He walks around this area inside the building.
turnin The Legend of Stalvan##78 |goto 73.78,44.48
accept The Legend of Stalvan##79 |goto 73.78,44.48
step
Leave the building |goto 73.82,46.02 < 7 |walk
talk Commander Althea Ebonlocke##264
|tip She walks around this area.
turnin The Legend of Stalvan##79 |goto 73.59,46.89
accept The Legend of Stalvan##80 |goto 73.59,46.89
step
Enter the building |goto 72.92,46.81 < 10 |walk
talk Clerk Daltry##267
|tip He walks around this area inside the building.
turnin The Legend of Stalvan##80 |goto 72.52,46.85
accept The Legend of Stalvan##97 |goto 72.52,46.85
step
Leave the building |goto 72.93,46.80 < 10 |walk
talk Commander Althea Ebonlocke##264
|tip She walks around this area.
turnin The Legend of Stalvan##97 |goto 73.59,46.89
accept The Legend of Stalvan##98 |goto 73.59,46.89
step
Follow the road |goto 74.86,45.71 < 20 |only if walking
Follow the path |goto 73.57,32.64 < 20 |only if walking
kill Stalvan Mistmantle##315
|tip Inside, or just outside, the building.
collect Mistmantle Family Ring##3629 |q 98/1 |goto 77.35,36.19
step
Follow the road |goto 73.09,32.80 < 20 |only if walking
Enter the building |goto 75.55,45.37 < 7 |walk
talk Madame Eva##265
|tip She walks around this area inside the building.
turnin The Legend of Stalvan##98 |goto 75.82,45.29
step
Leave the building |goto 75.56,45.38 < 5 |walk
Follow the road |goto 74.59,49.24 < 20 |only if walking
Continue following the road |goto 44.27,67.29 < 30 |only if walking
Follow the path |goto Stranglethorn Vale 40.84,4.28 < 30 |only if walking
Follow the path up |goto Stranglethorn Vale 38.56,5.01 < 15 |only if walking
talk Corporal Kaleb##770
accept Krazek's Cookery##210 |goto 37.74,3.30
step
Follow the path |goto 39.27,5.55 < 20 |only if walking
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
Kill enemies around this area
Reach Level 34 |ding 34 |goto 26.04,16.19
You can find more around [30.02,10.56]
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##191 |goto 35.55,10.55
accept Panther Mastery##192 |goto 35.55,10.55
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
Follow the road |goto 35.48,15.56 < 30 |only if walking
Continue following the road |goto 36.80,48.87 < 30 |only if walking
Enter the tunnel to Booty Bay |goto 29.55,72.51 < 10 |only if walking
Leave the tunnel |goto 27.96,73.67 < 10 |only if walking
Enter the building |goto 27.08,77.62 < 5 |walk
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
turnin Krazek's Cookery##210 |goto 26.94,77.21
accept Favor for Krazek##627 |goto 26.94,77.21
step
talk talk 773
|tip Upstairs inside the building, on the top floor.
turnin Favor for Krazek##627 |goto 26.94,77.21
accept Return to Corporal Kaleb##622 |goto 26.94,77.21
accept The Haunted Isle##616 |goto 26.94,77.21
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
turnin The Haunted Isle##616 |goto 27.23,76.87
step
Follow the path and leave the building |goto 26.99,77.49 < 5 |only if walking
Enter the building and run up the stairs |goto 27.52,77.86 < 5 |only if walking
talk Gyll##2859
|tip Upstairs on the balcony of the building.
fpath Booty Bay |goto 27.53,77.79
step
talk Wharfmaster Dizzywig##3453
turnin The Barrens Port##1039 |goto The Barrens 63.35,38.45
step
talk Bragok##16227
fpath Ratchet |goto 63.08,37.16
step
Follow the path |goto 60.01,38.84 < 30 |only if walking
Follow the road |goto 50.98,50.16 < 30 |only if walking
Ride the elevator down |goto Thousand Needles 31.72,23.63 < 15 |only if walking
click Henrig Lonebrow's Journal
|tip It looks like a book in a dead dwarf's hand.
collect Henrig Lonebrow's Journal##5791 |goto Thousand Needles 30.73,24.35 |q 1100 |future
step
use Henrig Lonebrow's Journal##5791
accept Lonebrow's Journal##1100
step
Follow the road |goto 31.46,30.20 < 30 |only if walking
Continue following the road |goto 28.84,33.47 < 30 |only if walking
Follow the path |goto 12.16,16.75 < 30 |only if walking
talk Thyssiana##4319
fpath Thalanaar |goto Feralas 89.50,45.85 |notravel
step
talk Falfindel Waywarder##4048
turnin Lonebrow's Journal##1100 |goto 89.64,46.56
step
Follow the road |goto Thousand Needles 11.69,15.83 < 30 |notravel |only if walking
Continue following the road |goto Thousand Needles 29.52,34.59 < 30 |only if walking
Avoid the Freewind Post elevators |goto Thousand Needles 43.37,48.03 < 30 |only if walking
Avoid the Freewind Post elevators |goto Thousand Needles 43.78,53.34 < 30 |only if walking
Follow the road |goto Thousand Needles 49.43,52.57 < 30 |only if walking
Follow the path |goto Thousand Needles 66.74,55.86 < 30 |only if walking
talk Kravel Koalbeard##4452
accept Rocket Car Parts##1110 |goto Thousand Needles 77.79,77.27
accept Wharfmaster Dizzywig##1111 |goto Thousand Needles 77.79,77.27
accept Hemet Nesingwary##5762 |goto Thousand Needles 77.79,77.27
step
talk Fizzle Brassbolts##4454
accept Salt Flat Venom##1104 |goto 78.06,77.13
step
talk Wizzle Brassbolts##4453
turnin The Brassbolts Brothers##1179 |goto 78.14,77.12
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
|tip You can rarely find more around all of Shimmering Flats, but this is the main location where they spawn.
|tip They take a while to respawn, so keep working on other quests and check back here periodically.
collect 10 Hollow Vulture Bone##5848 |q 1176/1 |goto 87.45,65.73
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
step
label "Collect_Rocket_Car_Parts"
click Rocket Car Rubble##19868+
|tip They look like various machine parts scattered on the ground.
|tip You can find them all throughout the Shimmering Flats.
collect 30 Rocket Car Parts##5798 |q 1110/1 |goto 75.19,56.17
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
talk Pozzik##4630
turnin Load Lightening##1176 |goto 80.18,75.88
accept Goblin Sponsorship##1178 |goto 80.18,75.88
step
talk Trackmaster Zherin##4629
turnin A Bump in the Road##1175 |goto 81.63,77.95
step
Follow the path up |goto 74.17,92.85 < 15 |only if walking
Continue following the path |goto Tanaris 51.11,22.59 < 15 |only if walking
Follow the path |goto Tanaris 51.26,26.48 < 10 |only if walking
Follow the path |goto Tanaris 51.01,28.63 < 10 |only if walking
talk Bera Stonehammer##7823
fpath Gadgetzan |goto Tanaris 51.01,29.34
step
Leave the building |goto Stormwind City 53.42,64.94 < 5 |walk
Enter the building |goto Stormwind City 54.09,59.00 < 7 |walk
talk Auctioneer Jaxon##15659
|tip Inside the building.
|tip Buy these items from the Auction House.
collect 2 Elixir of Water Breathing##5996 |goto Stormwind City 53.61,59.76 |q 6161 |future
|tip You may already have these from an earlier quest reward.
step
Enter the building |goto 39.84,85.25 < 7 |walk
talk Angus Stern##1141
|tip Inside the building.
accept Morgan Stern##1260 |goto 41.50,89.39
step
Leave the building |goto 39.84,85.22 < 5 |walk
Enter the building |goto 43.04,34.44 < 10 |walk
Follow the path |goto 40.73,26.42 < 7 |c |q 6141 |future
step
Run down the ramp |goto 41.28,25.01 < 5 |walk
talk Brother Crowley##12336
|tip Downstairs inside the building.
accept Brother Anton##6141 |goto 42.58,24.22
step
Run up the ramp |goto 40.69,25.88 < 5 |walk
Leave the building |goto 43.03,34.44 < 7 |walk
Run up the ramp |goto 62.40,62.26 < 10 |only if walking
talk Baldruc##4321
fpath Theramore |goto Dustwallow Marsh 67.48,51.30
step
Follow the path |goto Stonetalon Mountains 41.62,15.95 < 20 |only if walking
Continue following the path |goto Stonetalon Mountains 46.90,31.60 < 30 |only if walking
Continue following the path |goto Stonetalon Mountains 42.36,42.47 < 20 |only if walking
Follow the path up |goto Stonetalon Mountains 30.22,75.85 < 20 |only if walking
Follow the road |goto Desolace 53.35,6.17 < 30 |only if walking
Follow the path |goto Desolace 60.95,16.74 < 30 |only if walking
Follow the path up |goto Desolace 67.49,15.76 < 15 |only if walking
talk Vahlarriel Demonslayer##5642
accept Vahlarriel's Search##1437 |goto Desolace 66.44,11.82
step
talk Captain Pentigast##5396
accept Strange Alliance##1382 |goto 66.66,10.93
step
talk Corporal Melkins##5752
accept Centaur Bounty##1387 |goto 66.74,10.87
step
talk Kreldig Ungor##5638
turnin Reclaimers' Business in Desolace##1453 |goto 66.20,9.63
accept The Karnitol Shipwreck##1454 |goto 66.20,9.63
accept Reagents for Reclaimers Inc.##1458 |goto 66.20,9.63
step
talk Baritanas Skyriver##6706
fpath Nijel's Point |goto 64.66,10.54
step
talk Innkeeper Lyshaerya##11103
|tip Inside the building.
home Nijel's Point |goto 66.27,6.56
step
talk Brother Anton##1182
|tip Inside the building.
turnin Brother Anton##6141 |goto 66.52,7.90
step
Follow the path down |goto 67.05,13.04 < 15 |only if walking
click Malem Chest
turnin Vahlarriel's Search##1437 |goto 56.54,17.83
accept Vahlarriel's Search##1465 |goto 56.54,17.83
stickystart "Collect_Hatefury_Horns"
step
Kill Hatefury enemies around this area
collect 10 Hatefury Claw##6246 |q 1458/1 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
step
label "Collect_Hatefury_Horns"
Kill Hatefury enemies around this area
collect 10 Hatefury Horn##6247 |q 1458/2 |goto 75.60,23.34
You can find more around: |notinsticky
[79.65,19.76]
[77.19,15.26]
[72.61,18.28]
step
Follow the path up |goto 67.39,15.50 < 15 |only if walking
talk Vahlarriel Demonslayer##5642
turnin Vahlarriel's Search##1465 |goto 66.44,11.82
accept Vahlarriel's Search##1438 |goto 66.44,11.82
step
talk Kreldig Ungor##5638
turnin Reagents for Reclaimers Inc.##1458 |goto 66.20,9.63
accept Reagents for Reclaimers Inc.##1459 |goto 66.20,9.63
step
Follow the path down |goto 67.05,13.04 < 15 |only if walking
kill Scorpashi Snapper##4696+
collect 10 Scorpashi Venom##6248 |q 1459/1 |goto 69.71,24.65
You can find more around: |notinsticky
[73.86,31.30]
[68.72,33.08]
[65.86,29.09]
[64.70,22.78]
step
Kill enemies around this area
Reach Level 35 |ding 35 |goto 69.71,24.65
You can find more around: |notinsticky
[73.86,31.30]
[68.72,33.08]
[64.70,22.78]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (35-40)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (40-45)",
startlevel=35,
endlevel=40,
},[[
step
talk Bibbly F'utzbuckle##11438
|tip He walks around this area.
accept Bone Collector##5501 |goto Desolace 62.33,38.98
stickystart "Reach_Friendly_With_The_Gelkis_Clan_Centaur"
step
Follow the road |goto 67.81,44.15 < 30 |only if walking
Kill Magram enemies around this area
collect 15 Centaur Ear##6067 |q 1387/1 |goto 70.30,73.77
step
label "Reach_Friendly_With_The_Gelkis_Clan_Centaur"
Kill Magram enemies around this area
|tip Press "U" to open your reputation list.
|tip Select the "Gelkis Clan Centaur" reputation, and select "Show as Experience Bar".
|tip This will show you a progress bar for this reputation, similar to your experience bar.
Reach Friendly Reputation with the Gelkis Clan Centaur |condition rep('Gelkis Clan Centaur') >= Friendly |goto 70.42,73.40 |q 1382
step
Follow the road |goto 67.04,65.72 < 30 |only if walking
talk Smeed Scrabblescrew##11596
accept Kodo Roundup##5561 |goto 60.86,61.86
stickystart "Collect_Kodo_Bones"
stickystart "Collect_Aged_Kodo_Hides"
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
label "Collect_Kodo_Bones"
click Kodo Bones
|tip They look like large white horned animal skulls on the ground around this area.
|tip If a Kodo Apparition appears and attacks you, run away until it leaves you alone, if you can't kill them.
collect 10 Kodo Bone##13703 |q 5501/1 |goto 51.31,58.04
step
label "Collect_Aged_Kodo_Hides"
kill Aged Kodo##4700+
collect 3 Aged Kodo Hide##6249 |q 1459/2 |goto 51.41,58.45
step
Follow the path |goto 48.25,62.99 < 30 |only if walking
Follow the path up |goto 46.76,67.06 < 10 |only if walking
Follow the path down |goto 46.35,70.20 < 10 |only if walking
Follow the road |goto 43.71,76.57 < 30 |only if walking
talk Uthek the Wise##5397
turnin Strange Alliance##1382 |goto 36.22,79.25
accept Raid on the Kolkar##1384 |goto 36.22,79.25
step
talk Kreldig Ungor##5638
turnin Reagents for Reclaimers Inc.##1459 |goto 66.20,9.63
step
talk Corporal Melkins##5752
turnin Centaur Bounty##1387 |goto 66.74,10.87
step
Follow the path down |goto 67.05,13.01 < 15 |only if walking
talk Bibbly F'utzbuckle##11438
|tip He walks around this area.
turnin Bone Collector##5501 |goto 62.33,38.98
step
Kill Kolkar enemies around this area
collect 10 Crude Charm##6079 |q 1384/1 |goto 70.03,41.94
You can find more around: |notinsticky
[72.07,47.01]
[73.61,50.00]
step
Follow the path |goto 68.05,41.72 < 30 |only if walking
Follow the road |goto 59.85,37.71 < 30 |only if walking
click Karnitol's Chest
turnin The Karnitol Shipwreck##1454 |goto 36.11,30.45
accept The Karnitol Shipwreck##1455 |goto 36.11,30.45
step
click Rackmore's Log
accept Claim Rackmore's Treasure!##6161 |goto 36.07,30.41
step
use an Elixir of Water Breathing##5996
|tip If you don't have any, swim next to the bubbling gray rock mounds on the ground underwater around this area.
|tip They will allow you to breath underwater.
Kill Drysnap enemies around this area
|tip They look like lobster underwater around this area.
collect Rackmore's Silver Key##15878 |q 6161/1 |goto 32.78,31.37
|tip This has a low drop rate.
step
Follow the path up |goto 36.05,30.81 < 20 |only if walking
Follow the path |goto 41.95,34.70 < 20 |only if walking
talk Azore Aldamort##11863
accept Sceptre of Light##5741 |goto 38.88,27.17
step
Follow the path up |goto 55.56,32.51 < 30 |only if walking
Follow the path |goto 56.06,29.54 < 10 |only if walking
kill Burning Blade Seer##13019
|tip At the top of the tower.
collect Sceptre of Light##15750 |q 5741/1 |goto 55.17,30.15
step
Enter the building |goto 55.48,27.83 < 10 |walk
Follow the path |goto 55.66,26.69 < 7 |walk
Follow the path |goto 55.51,26.11 < 7 |walk
talk Dalinda Malem##5644
|tip Inside the building.
turnin Vahlarriel's Search##1438 |goto 54.86,26.13
accept Search for Tyranis##1439 |goto 54.86,26.13
step
Follow the path |goto 55.51,26.12 < 7 |walk
Continue following the path |goto 55.64,26.75 < 7 |walk
Leave the building |goto 55.48,27.83 < 7 |walk
Enter the building |goto 53.73,29.42 < 10 |walk
kill Tyranis Malem##5643
|tip Inside the building.
collect Tyranis' Pendant##6767 |q 1439/1 |goto 53.01,29.08
step
Leave the building |goto 53.73,29.42 < 7 |walk
Enter the building |goto 55.48,27.83 < 10 |walk
Follow the path |goto 55.66,26.69 < 7 |walk
Follow the path |goto 55.51,26.11 < 7 |walk
talk Dalinda Malem##5644
|tip Inside the building.
|tip If she's not here, someone may be escorting her.
|tip Wait until she respawns.
turnin Search for Tyranis##1439 |goto 54.86,26.13
accept Return to Vahlarriel##1440 |goto 54.86,26.13
|tip This is an escort quest.
|tip Kill all enemies in this room before starting the quest.
step
Watch the dialogue
|tip Follow Dalinda Malem and protect her as she walks.
|tip She eventually walks to this location.
Rescue Dalinda Malem |q 1440/1 |goto 58.80,30.90
step
Follow the path up |goto 67.49,15.76 < 15 |only if walking
talk Vahlarriel Demonslayer##5642
turnin Return to Vahlarriel##1440 |goto 66.44,11.82
step
talk Kreldig Ungor##5638
turnin The Karnitol Shipwreck##1455 |goto 66.20,9.63
accept The Karnitol Shipwreck##1456 |goto 66.20,9.63
step
Follow the path down |goto 67.05,13.03 < 15 |only if walking
Follow the road |goto 63.16,25.29 < 30 |only if walking
talk Azore Aldamort##11863
turnin Sceptre of Light##5741 |goto 38.89,27.17
accept Book of the Ancients##6027 |goto 38.89,27.17
step
Kill Slitherblade enemies around this area
|tip Underwater.
collect Rackmore's Golden Key##15881 |q 6161/2 |goto 35.20,24.86
stickystart "Collect_Karnitols_Satchel"
step
click Serpent Statue
kill Lord Kragaru##12369
collect Book of the Ancients##15803 |q 6027/1 |goto 28.19,6.62
step
click Rackmore's Chest
|tip On the ground at the base of the tree.
turnin Claim Rackmore's Treasure!##6161 |goto 30.00,8.70
step
label "Collect_Karnitols_Satchel"
Kill Slitherblade enemies around this area
|tip Only Slitherblade Tidehunters and Slitherblade Sea Witches will drop the quest item.
|tip They share spawn points with other types of naga on this island.
|tip Kill all types of naga on this island, to try to get more to spawn.
collect Karnitol's Satchel##6245 |q 1456/1 |goto 28.19,6.62
You can find more underwater around [32.18,9.57]
step
Kill enemies around this area
Reach Level 36 |ding 36 |goto 28.19,6.62
You can find more underwater around [32.18,9.57]
step
Follow the path up |goto 40.99,28.91 < 15 |only if walking
talk Azore Aldamort##11863
turnin Book of the Ancients##6027 |goto 38.89,27.17
step
talk Kreldig Ungor##5638
turnin The Karnitol Shipwreck##1456 |goto 66.20,9.63
accept The Karnitol Shipwreck##1457 |goto 66.20,9.63
step
Follow the path down |goto 67.05,13.03 < 15 |only if walking
Follow the road |goto 68.64,25.27 < 30 |only if walking
Continue following the road |goto 67.83,40.92 < 30 |only if walking
Continue following the road |goto 48.39,75.67 < 30 |only if walking
talk Uthek the Wise##5397
turnin Raid on the Kolkar##1384 |goto 36.22,79.25
accept Stealing Supplies##1370 |goto 36.22,79.25
step
Follow the road |goto 47.02,75.18 < 30 |only if walking
Follow the path |goto 67.07,65.85 < 30 |only if walking
click Sack of Meat+
|tip They look like tan leather bags on the ground near the buildings around this area.
|tip Not all of the tan bags you see will be clickable.
collect 6 Crudely Dried Meat##6069 |q 1370/1 |goto 70.90,75.47
step
Follow the road |goto 66.96,65.74 < 30 |only if walking
Continue following the road |goto 48.39,75.67 < 30 |only if walking
talk Uthek the Wise##5397
turnin Stealing Supplies##1370 |goto 36.22,79.25
accept Ongeku##1373 |goto 36.22,79.25
step
Follow the road |goto 40.42,83.18 < 30 |only if walking
Continue following the road |goto Feralas 45.07,2.43 < 30 |only if walking
Follow the path down |goto Feralas 47.56,37.72 < 20 |only if walking
Ride the boat or swim across the water |goto Feralas 43.39,42.75 < 20 |only if walking
talk Fyldren Moonfeather##8019
fpath Feathermoon |goto Feralas 30.24,43.25
step
Enter the building |goto The Barrens 62.89,36.52 < 7 |walk
talk Gazlowe##3391
|tip Upstairs inside the building.
turnin Goblin Sponsorship##1178 |goto The Barrens 62.68,36.23
accept Goblin Sponsorship##1180 |goto The Barrens 62.68,36.23
step
Leave the building |goto 62.89,36.52 < 5 |walk
talk Wharfmaster Dizzywig##3453
turnin Wharfmaster Dizzywig##1111 |goto 63.35,38.46
accept Parts for Kravel##1112 |goto 63.35,38.46
accept Passage to Booty Bay##1040 |goto 63.35,38.46
step
talk Wharfmaster Lozgil##4631
turnin Goblin Sponsorship##1180 |goto Stranglethorn Vale 26.35,73.56
accept Goblin Sponsorship##1181 |goto Stranglethorn Vale 26.35,73.56
step
talk Caravaneer Ruzzgot##3945
turnin Passage to Booty Bay##1040 |goto 27.37,74.08
accept The Caravan Road##1041 |goto 27.37,74.08
step
Enter the building |goto 27.08,77.62 < 5 |walk
talk Innkeeper Skindle##6807
|tip Inside the building.
home Booty Bay |goto 27.04,77.31
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
turnin Goblin Sponsorship##1181 |goto 27.23,76.87
step
Enter the building |goto Duskwood 72.92,46.80 < 10 |walk
talk Clerk Daltry##267
|tip He walks around this area inside the building.
turnin The Caravan Road##1041 |goto Duskwood 72.53,46.85
accept The Carevin Family##1042 |goto Duskwood 72.53,46.85
step
Leave the building |goto 72.92,46.80 < 7 |walk
Enter the building |goto 75.22,48.26 < 7 |walk
talk Jonathan Carevin##661
|tip He walks around inside the building.
turnin The Carevin Family##1042 |goto 75.32,49.02
accept The Scythe of Elune##1043 |goto 75.32,49.02
step
Leave the building |goto 75.22,48.26 < 5 |walk
Enter the mine |goto 73.03,75.06 < 10 |walk
click Mound of Dirt
|tip Inside the mine.
Find Evidence of the Scythe of Elune |q 1043/1 |goto 73.54,79.13
step
Leave the mine |goto 73.03,75.06 < 10 |walk
Enter the building |goto 75.22,48.26 < 7 |walk
talk Jonathan Carevin##661
|tip He walks around inside the building.
turnin The Scythe of Elune##1043 |goto 75.32,49.02
accept Answered Questions##1044 |goto 75.32,49.02
step
Leave the building |goto 75.22,48.26 < 5 |walk
talk Roetten Stonehammer##5637
|tip He walks around inside the building.
turnin The Karnitol Shipwreck##1457 |goto Ironforge 67.91,17.52
step
Cross the bridge |goto Darnassus 43.82,41.15 < 15 |only if walking
talk Thyn'tel Bladeweaver##8026
turnin Answered Questions##1044 |goto Darnassus 61.77,39.19
step
talk Crank Fizzlebub##2498
|tip Inside the building.
accept Singing Blue Shards##605 |goto Stranglethorn Vale 27.12,77.21
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
accept Investigate the Camp##201 |goto 26.94,77.21
accept Supplies to Private Thorsen##198 |goto 26.94,77.21
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
accept Bloodscalp Ears##189 |goto 27.00,77.12
accept Hostile Takeover##213 |goto 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
accept Goblin Sponsorship##1182 |goto 27.23,76.87
accept The Stone of the Tides##578 |goto 27.23,76.87
step
Follow the path up |goto 27.85,76.74 < 7 |only if walking
Cross the bridge |goto 28.15,76.52 < 7 |only if walking
Enter the building |goto 28.21,77.33 < 5 |walk
talk Drizzlik##2495
|tip Inside the building.
accept Supply and Demand##575 |goto 28.29,77.59
step
Leave the building |goto 28.21,77.33 < 5 |walk
Enter the tunnel |goto 27.95,73.62 < 10 |only if walking
Leave the tunnel |goto 29.59,72.47 < 10 |only if walking
Follow the road |goto 31.02,71.40 < 30 |only if walking
Follow the path |goto 43.83,24.94 < 30 |only if walking
Follow the path up |goto 47.00,22.88 < 15 |only if walking
kill 10 Shadowmaw Panther##684 |q 192/1 |goto 49.23,22.66
|tip They are stealthed around this area.
|tip They share spawn points with Stranglethorn Tigresses, so kill those too, to get more Shadowmaw Panthers to spawn.
|tip Be careful to avoid the level 40 elite non-stealthed black panther, Bhag'thera, if you see him.
You can find more around [46.42,27.34]
stickystart "Collect_Tumbled_Crystals"
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
kill Venture Co. Geologist##1096+
collect 8 Tumbled Crystal##4106 |q 213/1 |goto 44.63,21.45
step
kill 10 Lashtail Raptor##686 |q 195/1 |goto 38.29,19.37
You can find more around: |notinsticky
[38.52,26.06]
[35.81,26.67]
[32.72,24.28]
[30.55,24.12]
step
kill 10 Elder Stranglethorn Tiger##1085 |q 187/1 |goto 34.68,18.95
You can find more around [31.55,19.39]
step
Locate the Hunters' Camp |q 201/1 |goto 35.55,10.55
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##195 |goto 35.66,10.81
accept Raptor Mastery##196 |goto 35.66,10.81
turnin Hemet Nesingwary##5762 |goto 35.66,10.81
step
talk Ajeck Rouack##717
turnin Tiger Mastery##187 |goto 35.62,10.62
accept Tiger Mastery##188 |goto 35.62,10.62
step
talk Sir S. J. Erlgadin##718
turnin Panther Mastery##192 |goto 35.55,10.55
accept Panther Mastery##193 |goto 35.55,10.55
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
stickystart "Collect_Bloodscalp_Ears"
step
Follow the path up |goto 31.81,16.83 < 10 |only if walking
kill Sin'Dall##729
|tip He looks like an orange tiger that walks around this area.
|tip He usually is on top of the hill.
collect Paw of Sin'Dall##3879 |q 188/1 |goto 32.21,17.39
step
label "Collect_Bloodscalp_Ears"
Kill Bloodscalp enemies around this area
|tip You can find a few more along the path in the outskirts circling this camp.
collect 15 Bloodscalp Ear##1519 |q 189/1 |goto 29.36,19.97
You can find more around [33.85,15.53]
step
Follow the path up |goto 26.92,19.17 < 10 |only if walking
kill Crystal Spine Basilisk##689+
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto 27.06,18.51 |or
|tip These have a low drop rate.
You can find more around [25.11,17.42]
_Or_
Click Here to Continue |confirm |q 605 |or
|tip This area is heavily camped, and there's not many spawns.
|tip If there's too many other players, or you've killed them all, just continue.
|tip You will have a chance to complete the quest in another area soon.
step
Locate the Haunted Island |q 578/1 |goto 21.33,21.93
step
Follow the path up |goto 26.92,19.17 < 10 |only if walking
kill Crystal Spine Basilisk##689+
|tip Check to see if they're respawning yet.
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto 27.06,18.51 |or
|tip These have a low drop rate.
You can find more around [25.11,17.42]
_Or_
Click Here to Continue |confirm |q 605 |or
|tip This area can have many players, and there's not many spawns.
|tip If there's too many other players, or you've killed them all, just continue.
|tip You will have a chance to complete the quest in another area soon.
step
Follow the path |goto 27.54,19.83 < 30 |only if walking
talk Ajeck Rouack##717
turnin Tiger Mastery##188 |goto 35.62,10.62
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
kill River Crocolisk##1150+
|tip Along the water around this area.
collect 2 Large River Crocolisk Skin##4053 |q 575/1 |goto 33.45,8.28
You can find more around: |notinsticky
[37.63,9.93]
[40.24,13.68]
step
Follow the road |goto 39.47,7.50 < 30 |only if walking
Follow the path up |goto 39.05,5.20 < 15 |only if walking
talk Private Thorsen##738
|tip He periodically walks along the path to the south, from the Rebel Camp.
|tip If he's not here, wait for him to return.
turnin Supplies to Private Thorsen##198 |goto 37.98,3.42
step
talk Sergeant Yohwa##733
accept The Second Rebellion##203 |goto 38.02,3.33
accept Bad Medicine##204 |goto 38.02,3.33
step
talk Corporal Kaleb##770
turnin Return to Corporal Kaleb##622 |goto 37.74,3.30
step
talk Private Thorsen##738
|tip He periodically walks along the path to the south, from the Rebel Camp.
|tip If he's here, wait for him to start walking, and follow him.
|tip He will eventually get attacked by two Kurzen enemies.
|tip Help him kill the enemies and he will offer you a quest.
accept Jungle Secrets##215 |goto 37.98,3.41
If he's not here, check around:
[40.34,8.44]
step
Follow the road |goto 39.89,8.26 < 30 |only if walking
Follow the path up |goto 39.06,5.21 < 15 |only if walking
talk Lieutenant Doren##469
turnin Jungle Secrets##215 |goto 38.04,3.01
accept Bookie Herod##200 |goto 38.04,3.01
stickystart "Collect_Jungle_Remedies"
stickystart "Kill_Kurzen_Jungle_Fighters"
step
Follow the path |goto 39.27,5.55 < 20 |only if walking
Follow the path up |goto 43.23,10.80 < 15 |only if walking
click Kurzen Supplies
|tip In front of the building.
|tip Be careful to stay out of sight of the enemies near the doorway inside the building.
collect Venom Fern Extract##2634 |q 204/2 |goto 44.10,9.56
step
Enter the building |goto 44.02,9.46 < 7 |walk
click Bookie Herod's Records
|tip Upstairs inside the building.
turnin Bookie Herod##200 |goto 43.67,9.37
accept The Hidden Key##328 |goto 43.67,9.37
step
label "Collect_Jungle_Remedies"
Leave the building |goto 44.02,9.46 < 5 |walk
kill Kurzen Medicine Man##940+
|tip Try to interrupt their spell casts, or drain their mana if you can.
|tip They can heal themselves and other enemies.
collect 7 Jungle Remedy##2633 |q 204/1 |goto 43.88,10.71
step
label "Kill_Kurzen_Jungle_Fighters"
kill 15 Kurzen Jungle Fighter##937 |q 203/1 |goto 43.88,10.71
|tip If you don't have help,stay on western outskirts, around this area, and just wait for the enemies to respawn.
|tip They respawn pretty quickly.
step
Follow the road |goto 39.89,8.26 < 30 |only if walking
Follow the path up |goto 39.06,5.21 < 15 |only if walking
talk Sergeant Yohwa##733
turnin The Second Rebellion##203 |goto 38.02,3.33
turnin Bad Medicine##204 |goto 38.02,3.33
accept Special Forces##574 |goto 38.02,3.33
stickystart "Kill_Kurzen_Headshrinkers"
stickystart "Kill_Kurzen_Commandos"
step
Follow the path |goto 39.27,5.55 < 20 |only if walking
Follow the path up |goto 43.23,10.80 < 15 |only if walking
Enter the cave |goto 45.53,8.33 < 15 |walk
Follow the path |goto 46.53,7.05 < 10 |walk
Follow the path down |goto 47.78,7.81 < 10 |walk
Follow the path |goto 48.78,8.64 < 10 |walk
click Bookie Herod's Strongbox
|tip Downstairs inside the cave.
turnin The Hidden Key##328 |goto 49.61,7.57
accept The Spy Revealed!##329 |goto 49.61,7.57
step
Follow the path up |goto 48.20,8.53 < 7 |c |q 574
step
label "Kill_Kurzen_Headshrinkers"
kill 6 Kurzen Headshrinker##941 |q 574/2 |goto 46.48,7.08
|tip Inside the cave, on the top level.
step
label "Kill_Kurzen_Commandos"
kill 10 Kurzen Commando##938 |q 574/1 |goto 46.48,7.08
|tip They are stealthed upstairs inside the cave, on the same level as the cave entrance.
step
Leave the cave |goto 45.96,8.68 < 15 |c |q 605
step
kill Crystal Spine Basilisk##689+
collect 10 Singing Crystal Shard##3918 |q 605/1 |goto 47.48,9.25
|tip These have a low drop rate.
You can find more around: |notinsticky
[48.85,8.87]
[47.52,5.90]
step
Kill enemies around this area
Reach Level 37 |ding 37 |goto 44.58,9.89
You can find more inside the cave at [45.91,8.68]
step
Follow the path |goto 43.05,9.88 < 40 |only if walking
Follow the road |goto 39.82,8.07 < 30 |only if walking
Follow the path up |goto 39.06,5.21 < 15 |only if walking
talk Lieutenant Doren##469
turnin Special Forces##574 |goto 38.04,3.01
turnin The Spy Revealed!##329 |goto 38.04,3.01
accept Patrol Schedules##330 |goto 38.04,3.01
step
talk Corporal Sethman##1422
turnin Patrol Schedules##330 |goto 37.66,3.39
accept Report to Doren##331 |goto 37.66,3.39
step
talk Lieutenant Doren##469
turnin Report to Doren##331 |goto 38.04,3.01
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
talk Crank Fizzlebub##2498
|tip Inside the building.
turnin Singing Blue Shards##605 |goto 27.12,77.21
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
turnin Investigate the Camp##201 |goto 26.94,77.21
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
turnin Bloodscalp Ears##189 |goto 27.00,77.12
turnin Hostile Takeover##213 |goto 27.00,77.12
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
turnin The Stone of the Tides##578 |goto 27.23,76.87
turnin Goblin Sponsorship##1182 |goto 27.23,76.87
accept Goblin Sponsorship##1183 |goto 27.23,76.87
step
Follow the path up |goto 27.85,76.74 < 7 |only if walking
Cross the bridge |goto 28.15,76.52 < 7 |only if walking
Enter the building |goto 28.21,77.33 < 5 |walk
talk Drizzlik##2495
|tip Inside the building.
turnin Supply and Demand##575 |goto 28.29,77.59
accept Some Assembly Required##577 |goto 28.29,77.59
step
Leave the building |goto 28.21,77.33 < 5 |walk
Enter the building |goto Ironforge 26.13,72.17 < 10 |walk
talk Auctioneer Redmuse##8720
|tip Inside the building.
|tip Buy these items from the Auction House.
collect Moonsteel Broadsword##3853 |goto Ironforge 24.24,74.54 |q 1203 |future
|tip If you can't buy it, ask in trade chat to pay a blacksmith to make it for you.
|tip Be careful not to accidentally sell this to a vendor.
|tip If you can't get one, you can just skip the quest for it later.
collect 2 Elixir of Water Breathing##5996 |goto Ironforge 24.24,74.54 |q 666 |future
|tip You may already have these from an earlier quest reward.
step
talk Prospector Stormpike##1356
|tip Inside the building.
accept Further Mysteries##525 |goto 74.64,11.75
accept Ironband Wants You!##707 |goto 74.64,11.75
step
Enter the building |goto Hillsbrad Foothills 50.45,58.55 < 7 |walk
talk Innkeeper Anderson##2352
|tip Inside the building.
home Southshore |goto Hillsbrad Foothills 51.17,58.93
step
Leave the building |goto 50.45,58.55 < 7 |walk
talk Marshal Redpath##2263
accept Crushridge Bounty##500 |goto 49.48,58.73
step
Enter the building |goto 49.01,59.12 < 10 |walk
talk Magistrate Henry Maleb##2276
|tip Inside the building.
turnin Further Mysteries##525 |goto 48.14,59.11
step
Enter the building |goto 49.00,59.12 < 10 |walk
talk Magistrate Henry Maleb##2276
|tip Inside the building.
accept Syndicate Assassins##505 |goto 48.14,59.11
stickystart "Kill_Syndicate_Thieves"
stickystart "Kill_Syndicate_Footpads"
step
Leave the building |goto 49.02,59.12 < 10 |walk
Follow the road |goto 57.32,35.31 < 30 |only if walking
Follow the path up |goto Alterac Mountains 53.08,65.13 < 20 |only if walking
click Syndicate Documents
accept Foreboding Plans##510 |goto Alterac Mountains 58.32,67.92
accept Encrypted Letter##511 |goto Alterac Mountains 58.32,67.92
step
label "Kill_Syndicate_Thieves"
kill 8 Syndicate Thief##2241 |q 505/2 |goto 58.32,67.92
You can find more around [47.91,82.14]
step
label "Kill_Syndicate_Footpads"
kill 12 Syndicate Footpad##2240 |q 505/1 |goto 58.32,67.92
You can find more around [47.91,82.14]
step
Enter the building |goto Hillsbrad Foothills 49.02,59.12 < 10 |walk
talk Magistrate Henry Maleb##2276
|tip Inside the building.
turnin Syndicate Assassins##505 |goto Hillsbrad Foothills 48.14,59.11
turnin Foreboding Plans##510 |goto Hillsbrad Foothills 48.14,59.11
accept Noble Deaths##512 |goto Hillsbrad Foothills 48.14,59.11
step
Leave the building |goto 49.01,59.12 < 10 |walk
Follow the road |goto 57.15,34.90 < 30 |only if walking
Kill Crushridge enemies around this area
|tip They look like ogres.
collect 9 Dirty Knucklebones##2843 |q 500/1 |goto Alterac Mountains 47.57,61.10
You can find more around: |notinsticky
[49.51,52.14]
[48.47,39.68]
step
Kill Syndicate enemies around this area
|tip Be careful, the Syndicate Spies can be stealthed.
collect 7 Alterac Signet Ring##3505 |q 512/1 |goto 58.16,44.65
You can find more around [62.27,44.04]
step
Follow the road |goto 65.69,46.84 < 30 |only if walking
Continue following the road |goto 79.76,43.47 < 30 |only if walking
talk Bibilfaz Featherwhistle##12596
fpath Chillwind Camp |goto Western Plaguelands 42.93,85.06
step
talk Phin Odelic##2711
accept Hints of a New Plague?##659 |goto Hillsbrad Foothills 50.34,59.05
step
talk Loremaster Dibbs##2277
turnin Encrypted Letter##511 |goto 50.57,57.09
accept Letter to Stormpike##514 |goto 50.57,57.09
step
talk Marshal Redpath##2263
turnin Crushridge Bounty##500 |goto 49.48,58.73
step
Enter the building |goto 49.01,59.12 < 10 |walk
talk Magistrate Henry Maleb##2276
|tip Inside the building.
turnin Noble Deaths##512 |goto 48.14,59.11
step
Leave the building |goto 49.01,59.12 < 10 |walk
talk Skuerto##2789
turnin Malin's Request##690 |goto Arathi Highlands 46.65,47.01
step
talk Apprentice Kryten##2788
accept Worth Its Weight in Gold##691 |goto 46.20,47.75
step
Follow the path |goto 48.79,44.25 < 30 |only if walking
click Shards of Myzrael
accept The Princess Trapped##642 |goto 62.50,33.80
step
Avoid Hammerfall |goto 72.95,40.77 < 30 |only if walking
Kill Drywhisker enemies around this area
|tip You can find more in the cave at the top of the path referenced below.
collect 12 Mote of Myzrael##4435 |q 642/1 |goto 76.13,44.11
|tip These have a low drop rate.
You can find more around [78.07,35.28]
You can find more up the path that starts at [80.84,39.91]
step
Follow the path up |goto 80.90,39.96 < 10 |only if walking
Enter the cave |goto 82.66,36.16 < 10 |walk
Follow the path |goto 83.87,33.30 < 10 |walk
Follow the path up |goto 87.13,31.39 < 7 |walk
Follow the path |goto 84.73,28.93 < 7 |walk
click Iridescent Shards
|tip Upstairs inside the cave.
turnin The Princess Trapped##642 |goto 84.31,30.92
accept Stones of Binding##651 |goto 84.31,30.92
step
Follow the path |goto 83.77,33.75 < 10 |walk
Leave the cave |goto 82.69,36.21 < 10 |walk
Avoid Hammerfall |goto 73.48,41.26 < 30 |only if walking
click Stone of East Binding
collect Cresting Key##4484 |q 651/2 |goto 66.75,29.75
step
talk Quae##2712
turnin Hints of a New Plague?##659 |goto 60.19,53.85
accept Hints of a New Plague?##658 |goto 60.19,53.85
stickystart "Collect_Witherbark_Medicine_Pouches"
stickystart "Collect_Witherbark_Tusks"
step
Follow the path |goto 63.81,53.03 < 30 |only if walking
Follow the path up |goto 68.04,72.17 < 15 |only if walking
Enter the cave |goto 68.32,75.18 < 10 |walk
kill Witherbark Shadow Hunter##2557+
|tip Inside the cave.
collect Shadow Hunter Knife##5040 |q 691/3 |goto 67.59,78.45
step
label "Collect_Witherbark_Medicine_Pouches"
Follow the path |goto 67.52,77.58 < 10 |walk
Leave the cave |goto 68.32,75.18 < 10 |walk
kill Witherbark Witch Doctor##2555+
|tip Inside and outside the cave.
collect 4 Witherbark Medicine Pouch##4522 |q 691/2 |goto 66.66,64.37
You can find more outside the cave around:
[61.45,72.04]
[64.79,72.83]
[70.29,68.39]
[72.11,64.09]
[70.82,60.27]
step
label "Collect_Witherbark_Tusks"
Kill Witherbark enemies around this area
|tip Inside and outside the cave.
collect 10 Witherbark Tusk##4503 |q 691/1 |goto 66.66,64.37
You can find more outside the cave around:
[61.45,72.04]
[64.79,72.83]
[70.29,68.39]
[72.11,64.09]
[70.82,60.27]
step
kill Forsaken Courier##2714
|tip She walks on this road from Go'Shek Farms to Tarren Mill in Hillsbrad Foothills.
|tip You can either kill enemies near the road around this area, waiting for her to walk by, or you can run along the road and try to find her.
|tip She walks with a group of 4 bodyguards with her.
|tip Kite her away from her bodyguards, so you can fight her alone.
|tip You can usually ask in chat if anyone has seen the courier recently, and they will give you a good idea of where to look, if you want to search.
|tip If she makes it to Tarren Mill, she respawns in Arathi Highlands and starts the walk over again.
collect Sealed Folder##4482 |q 658/1 |goto 50.83,59.96
step
Follow the path |goto 58.50,53.83 < 30 |only if walking
talk Quae##2712
turnin Hints of a New Plague?##658 |goto 60.19,53.85
accept Hints of a New Plague?##657 |goto 60.19,53.85
step
talk Kinelory##2713
turnin Hints of a New Plague?##657 |goto 60.24,53.92
accept Hints of a New Plague?##660 |goto 60.24,53.92
step
Watch the dialogue
|tip Follow Kinelory and protect her as she walks.
|tip She eventually walks back to this location.
Protect Kinelory |q 660/1 |goto 60.24,53.92
step
talk Quae##2712
turnin Hints of a New Plague?##660 |goto 60.19,53.85
accept Hints of a New Plague?##661 |goto 60.19,53.85
step
click Stone of Outer Binding
collect Thundering Key##4485 |q 651/3 |goto 52.04,50.77
step
Follow the path down |goto 48.43,44.63 < 30 |only if walking
talk Apprentice Kryten##2788
turnin Worth Its Weight in Gold##691 |goto 46.20,47.75
step
talk Skuerto##2789
accept Wand over Fist##693 |goto 46.65,47.01
step
Follow the path up |goto 44.34,48.60 < 20 |only if walking
Enter the cave |goto 53.75,77.37 < 10 |walk
Follow the path |goto 54.63,79.26 < 7 |walk
kill Kor'gresh Coldrage##2793
|tip Inside the cave.
collect Trelane's Wand of Invocation##4525 |q 693/1 |goto 54.75,81.87
step
Follow the path |goto 54.53,77.88 < 7 |walk
Leave the cave |goto 53.68,77.23 < 10 |c |q 693
step
Kill enemies around this area
|tip You can find more inside the cave nearby.
Reach Level 38 |ding 38 |goto 53.16,76.35
step
Follow the path down |goto 43.89,50.38 < 20 |only if walking
talk Skuerto##2789
turnin Wand over Fist##693 |goto 46.65,47.01
step
Follow the path up |goto 44.38,48.55 < 20 |only if walking
Follow the road |goto 42.44,54.84 < 30 |only if walking
Follow the path |goto 22.85,36.03 < 30 |only if walking
click Stone of West Binding
collect Burning Key##4483 |q 651/1 |goto 25.45,30.16
step
Follow the road |goto 22.85,36.03 < 30 |only if walking
click Stone of Inner Binding
turnin Stones of Binding##651 |goto 36.19,57.37
step
Follow the path |goto 31.22,65.35 < 15 |only if walking
Continue following the path |goto 23.60,70.17 < 15 |only if walking
Enter the tunnel |goto 21.58,75.61 < 10 |only if walking
Leave the tunnel |goto 22.00,79.55 < 10 |only if walking
talk Lolo the Lookout##2766
|tip He walks around this area.
accept Land Ho!##663 |goto 31.78,82.70
step
talk Shakes O'Breen##2610
turnin Land Ho!##663 |goto 32.28,81.38
step
talk First Mate Nilzlix##2767
|tip He walks around this area.
accept Deep Sea Salvage##662 |goto 32.75,81.50
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
Leave the building |goto Hillsbrad Foothills 50.46,58.55 < 7 |walk
talk Phin Odelic##2711
turnin Hints of a New Plague?##661 |goto Hillsbrad Foothills 50.34,59.04
step
Follow the path |goto Tanaris 51.01,28.63 < 10 |only if walking
Follow the path |goto Tanaris 51.26,26.49 < 10 |only if walking
Follow the path up |goto Tanaris 50.24,24.83 < 20 |only if walking
Follow the path down |goto Tanaris 51.56,21.92 < 15 |only if walking
talk Kravel Koalbeard##4452
turnin Parts for Kravel##1112 |goto Thousand Needles 77.79,77.26
step
Watch the dialogue
talk Kravel Koalbeard##4452
accept Delivery to the Gnomes##1114 |goto 77.79,77.27
step
talk Fizzle Brassbolts##4454
turnin Delivery to the Gnomes##1114 |goto 78.06,77.12
accept Martek the Exiled##1106 |goto 78.06,77.12
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
step
Follow the path up |goto 74.16,93.04 < 15 |only if walking
Follow the path down |goto Tanaris 51.39,22.36 < 15 |only if walking
Follow the path |goto Tanaris 51.26,26.49 < 10 |only if walking
Follow the path |goto Tanaris 51.01,28.63 < 10 |only if walking
Enter the building |goto Dustwallow Marsh 66.12,51.56 < 7 |walk
talk Helenia Olden##4897
|tip Inside the building.
buy 3 Soothing Spices##3713 |goto Dustwallow Marsh 66.44,51.46 |q 1218 |future
|tip Be careful not to accidentally sell these to a vendor.
step
Leave the building |goto 66.12,51.57 < 5 |walk
Follow the road |goto 64.56,48.11 < 30 |only if walking
talk Guard Byron##4921
accept They Call Him Smiling Jim##1282 |goto 66.15,46.07
step
Enter the building |goto 66.00,45.20 < 7 |walk
talk Morgan Stern##4794
|tip Inside the building.
turnin Morgan Stern##1260 |goto 66.34,45.47
accept Mudrock Soup and Bugs##1204 |goto 66.34,45.47
step
talk Innkeeper Janene##6272
|tip Inside the building.
home Theramore Isle |goto 66.59,45.22
step
Leave the building |goto 66.00,45.20 < 7 |walk
Enter the building |goto 67.81,47.70 < 10 |walk
Run up the stairs |goto 68.17,48.76 < 5 |walk
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin They Call Him Smiling Jim##1282 |goto 68.21,48.62
step
Leave the building |goto 67.76,47.55 < 7 |walk
Run up the ramp |goto 65.64,45.36 < 7 |only if walking
Kill Mudrock enemies around this area
|tip They look like tortoises.
|tip You can find more in the water nearby.
|tip They seem to respawn fairly quickly.
collect 8 Forked Mudrock Tongue##5883 |q 1204/1 |goto 64.79,42.00
|tip These have a low drop rate.
You can find more around: |notinsticky
[63.08,35.77]
[61.72,30.64]
[61.92,25.24]
step
talk "Swamp Eye" Jarl##4792
accept Soothing Spices##1218 |goto 55.44,26.27
step
talk "Swamp Eye" Jarl##4792
turnin Soothing Spices##1218 |goto 55.44,26.27
accept Jarl Needs Eyes##1206 |goto 55.44,26.27
step
click Loose Dirt
accept The Orc Report##1219 |goto 55.44,25.93
step
Follow the road |goto 53.71,26.66 < 30 |only if walking
Follow the path |goto 46.92,22.72 < 30 |only if walking
talk "Stinky" Ignatz##4880
|tip Kill the enemies that are very close to him before talking to him.
|tip You will be escorting him.
accept Stinky's Escape##1222 |goto 46.88,17.52
step
Watch the dialogue
|tip Follow and protect "Stinky" Ignatz as he walks.
|tip He eventually walks to this location.
Help Stinky Find Bogbean Leaves |q 1222/1 |goto 48.86,24.65
step
Kill Darkmist enemies around this area
collect 40 Unpopped Darkmist Eye##5884 |q 1206/1 |goto 34.63,22.23
You can find more inside the mine at [33.22,22.76]
step
Avoid Brackenwall Village |goto 39.06,30.27 < 30 |only if walking
talk Mudcrush Durtfeet##4503
accept Hungry!##1177 |goto 35.15,38.25
step
click Suspicious Hoofprint
accept Suspicious Hoofprints##1284 |goto 29.70,47.63
step
click Theramore Guard Badge
|tip It looks like a tiny metal object on the floor.
accept Lieutenant Paval Reethe##1252 |goto 29.83,48.24
step
click Black Shield
accept The Black Shield##1253 |goto 29.63,48.59
step
Follow the path to avoid the elite crocolisks |goto 49.04,47.77 < 30 |only if walking
click Gizmorium Shipping Crate
collect Seaforium Booster##5862 |q 1187/1 |goto 54.07,56.48
step
talk Morgan Stern##4794
|tip Inside the building.
turnin Mudrock Soup and Bugs##1204 |goto 66.33,45.47
accept ... and Bugs##1258 |goto 66.33,45.47
turnin Stinky's Escape##1222 |goto 66.33,45.47
|tip Save the "Elixir of Fortitude" quest reward for a future quest.
|tip Becareful not to accidentally sell it to a vendor.
step
Leave the building |goto 65.99,45.20 < 7 |walk
talk Theramore Lieutenant##4947
turnin The Orc Report##1219 |goto 65.07,47.13
accept Captain Vimes##1220 |goto 65.07,47.13
step
Enter the building |goto 67.81,47.70 < 10 |walk
Run up the stairs |goto 68.17,48.76 < 5 |walk
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin Captain Vimes##1220 |goto 68.21,48.62
turnin Suspicious Hoofprints##1284 |goto 68.21,48.62
turnin Lieutenant Paval Reethe##1252 |goto 68.21,48.62
accept Lieutenant Paval Reethe##1259 |goto 68.21,48.62
turnin The Black Shield##1253 |goto 68.21,48.62
accept The Black Shield##1319 |goto 68.21,48.62
step
talk Adjutant Tesoran##4948
|tip Upstairs inside the building.
turnin Lieutenant Paval Reethe##1259 |goto 68.05,48.11
accept Daelin's Men##1285 |goto 68.05,48.11
step
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin Daelin's Men##1285 |goto 68.21,48.62
accept The Deserters##1286 |goto 68.21,48.62
step
Leave the building |goto 67.76,47.55 < 10 |walk
Follow the road |goto 64.89,47.16 < 30 |only if walking
Enter the building |goto 64.69,49.97 < 10 |walk
talk Caz Twosprocket##4941
|tip Inside the building.
turnin The Black Shield##1319 |goto 64.75,50.43
accept The Black Shield##1320 |goto 64.75,50.43
step
Leave the building |goto 64.69,49.94 < 7 |walk
Follow the road |goto 64.89,47.16 < 30 |only if walking
Enter the building |goto 67.81,47.70 < 10 |walk
Run up the stairs |goto 68.17,48.76 < 5 |walk
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin The Black Shield##1320 |goto 68.21,48.62
step
Leave the building |goto 67.76,47.55 < 10 |walk
Follow the road |goto 64.59,46.20 < 20 |only if walking
talk "Swamp Eye" Jarl##4792
turnin Jarl Needs Eyes##1206 |goto 55.44,26.27
accept Jarl Needs a Blade##1203 |goto 55.44,26.27 |only if (itemcount(3853) >= 1 or completedq(1203))
step
talk "Swamp Eye" Jarl##4792
turnin Jarl Needs a Blade##1203 |goto 55.44,26.27
|only if (itemcount(3853) >= 1 or completedq(1203))
stickystart "Reach_Level_40"
step
Follow the path down |goto 57.73,19.98 < 20 |only if walking
Kill Mirefin enemies around this area
collect 8 Mirefin Head##5847 |q 1177/1 |goto 57.33,21.40
You can find more around: |notinsticky
[57.50,16.51]
[54.42,15.92]
step
label "Reach_Level_40"
Kill enemies around this area
Reach Level 40 |ding 40 |goto 57.33,21.40
You can find more around: |notinsticky
[57.50,16.51]
[54.42,15.92]
step
Follow the path up |goto 57.90,18.55 < 20 |only if walking
Follow the road |goto 46.21,22.58 < 30 |only if walking
talk Mudcrush Durtfeet##4503
turnin Hungry!##1177 |goto 35.15,38.25
step
Follow the road |goto 33.40,46.43 < 30 |only if walking
Enter the building |goto 35.73,53.99 < 7 |walk
talk Balos Jacken##5089
|tip Upstairs inside the building.
turnin The Deserters##1286 |goto 36.09,54.30
accept The Deserters##1287 |goto 36.09,54.30
step
Leave the building |goto 35.74,54.00 < 7 |walk
Follow the road |goto 33.31,45.92 < 30 |only if walking
Continue following the road |goto 45.07,22.96 < 30 |only if walking
Continue following the road |goto 58.31,34.61 < 30 |only if walking
Follow the path |goto 64.93,46.84 < 30 |only if walking
Enter the building |goto 67.81,47.70 < 15 |walk
Run up the stairs |goto 68.17,48.76 < 7 |walk
talk Captain Garran Vimes##4944
|tip Upstairs inside the building.
turnin The Deserters##1287 |goto 68.21,48.62
step
Leave the building |goto 67.76,47.55 < 10 |walk
talk First Mate Crazz##2490
accept The Bloodsail Buccaneers##595 |goto Stranglethorn Vale 28.10,76.22
step
Enter the building |goto 27.64,77.09 < 7 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
accept Scaring Shaky##606 |goto 27.78,77.07
step
Leave the building |goto 27.64,77.09 < 7 |walk
Enter the building |goto 27.08,77.62 < 7 |walk
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
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
accept Water Elementals##601 |goto 27.23,76.87
step
Enter the tunnel |goto 27.95,73.60 < 15 |only if walking
Leave the tunnel |goto 29.58,72.47 < 15 |only if walking
click Bloodsail Correspondence
turnin The Bloodsail Buccaneers##595 |goto 27.28,69.52
accept The Bloodsail Buccaneers##597 |goto 27.28,69.52
step
Follow the path |goto 28.38,70.55 < 20 |only if walking
Follow the road |goto 30.67,72.24 < 30 |only if walking
kill Elder Mistvale Gorilla##1557+
collect 5 Mistvale Giblets##3919 |q 606/1 |goto 31.72,67.03
You can find more around: |notinsticky
[33.79,64.66]
[32.18,59.97]
step
Follow the road |goto 30.52,67.45 < 30 |only if walking
Continue following the road |goto 36.18,48.87 < 30 |only if walking
Follow the path |goto 38.53,40.71 < 30 |only if walking
kill 10 Jungle Stalker##687 |q 196/1 |goto 32.80,38.48
You can find more around: |notinsticky
[31.79,41.74]
[28.91,44.29]
[27.19,49.65]
step
kill Snapjaw Crocolisk##1152+
|tip Underwater and on the shores near the water around this area.
collect 5 Snapjaw Crocolisk Skin##4104 |q 577/1 |goto 39.28,30.27
You can find more around: |notinsticky
[40.03,24.70]
[41.52,19.48]
step
talk Hemet Nesingwary##715
turnin Raptor Mastery##196 |goto 35.66,10.81
accept Raptor Mastery##197 |goto 35.66,10.81
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
Follow the path |goto 32.67,13.07 < 30 |only if walking
Continue following the path |goto 30.04,17.29 < 30 |only if walking
kill Lesser Water Elemental##691+
collect 6 Water Elemental Bracers##3923 |q 601/1 |goto 21.13,22.70
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
turnin Water Elementals##601 |goto 27.23,76.87
step
Follow the path up |goto 27.85,76.74 < 10 |only if walking
Cross the bridge |goto 28.15,76.52 < 10 |only if walking
Enter the building |goto 28.21,77.33 < 7 |walk
talk Drizzlik##2495
|tip Inside the building.
turnin Some Assembly Required##577 |goto 28.29,77.59
accept Excelsior##628 |goto 28.29,77.59
step
Leave the building |goto 28.21,77.33 < 7 |walk
talk First Mate Crazz##2490
turnin The Bloodsail Buccaneers##597 |goto 28.10,76.22
accept The Bloodsail Buccaneers##599 |goto 28.10,76.22
step
Enter the building |goto 27.08,77.62 < 7 |walk
talk Fleet Master Seahorn##2487
|tip Upstairs on the balcony of the building.
turnin The Bloodsail Buccaneers##599 |goto 27.17,77.01
step
talk "Shaky" Phillipe##2502
turnin Scaring Shaky##606 |goto 26.90,73.59
accept Return to MacKinley##607 |goto 26.90,73.59
step
Enter the building |goto 27.64,77.09 < 7 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Return to MacKinley##607 |goto 27.78,77.07
step
Leave the building |goto 27.64,77.09 < 7 |walk
Enter the tunnel |goto 27.95,73.60 < 15 |only if walking
Leave the tunnel |goto 29.58,72.47 < 15 |only if walking
Follow the road |goto 30.67,72.24 < 30 |only if walking
Kill enemies around this area
Reach Level 40 |ding 40 |goto 44.88,22.09
|tip This is a very long grind.
|tip You can form a group and run dungeons instead, if you want.
You can find more around: |notinsticky
[41.95,27.84]
[45.40,27.97]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (40-45)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (45-50)",
startlevel=40,
endlevel=45,
},[[
step
Enter the building |goto Ironforge 26.16,72.16 < 15 |walk
talk Auctioneer Redmuse##8720
|tip Buy these items from the Auction House.
|tip If you can't buy them, ask in trade chat to pay someone to make them for you.
|tip The Blue Pearls cannot be created by a profession.
collect Frost Oil##3829 |goto Ironforge 24.24,74.54 |q 713 |future
collect Gyrochronatom##4389 |goto Ironforge 24.24,74.54 |q 714 |future
collect Healing Potion##929 |goto Ironforge 24.24,74.54 |q 715 |future
collect Lesser Invisibility Potion##3823 |goto Ironforge 24.24,74.54 |q 715 |future
collect Patterned Bronze Bracers##2868 |goto Ironforge 24.24,74.54 |q 716 |future
collect 9 Blue Pearl##4611 |goto Ironforge 24.24,74.54 |q 705 |future
step
Enter the building |goto Loch Modan 35.22,47.74 < 10 |walk
talk Innkeeper Hearthstove##6734
|tip Inside the building.
home Stoutlager Inn |goto Loch Modan 35.53,48.40
step
Leave the building |goto 35.22,47.74 < 10 |walk
Enter the building |goto 36.64,48.53 < 10 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
accept Badlands Reagent Run##2500 |goto 37.07,49.38
step
Leave the building |goto 36.64,48.53 < 7 |walk
Follow the path |goto 47.77,66.72 < 30 |only if walking
talk Prospector Ironband##1344
turnin Ironband Wants You!##707 |goto 65.93,65.62
accept Find Agmond##738 |goto 65.93,65.62
step
Follow the path |goto 55.57,67.85 < 30 |only if walking
Enter the Badlands |goto 46.79,78.25 < 30 |only if walking
Follow the path |goto Badlands 51.84,15.51 < 30 |only if walking
Follow the path |goto Badlands 51.77,33.17 < 15 |only if walking
click Crumpled Map
accept A Sign of Hope##720 |goto Badlands 53.03,33.93
step
Follow the path up |goto 50.48,37.05 < 30 |only if walking
talk Prospector Ryedol##2910
turnin A Sign of Hope##720 |goto 53.42,43.40
accept A Dwarf and His Tools##719 |goto 53.42,43.40
step
talk Sigrun Ironhew##2860
accept Mirages##718 |goto 53.80,43.31
step
Kill Shadowforge enemies around this area
collect Ryedol's Lucky Pick##4616 |q 719/1 |goto 52.59,32.20
step
Follow the path |goto 55.84,27.36 < 30 |only if walking
click Excavation Supply Crate
collect Supply Crate##4629 |q 718/1 |goto 66.90,23.43
step
Follow the path |goto 55.77,27.20 < 30 |only if walking
Follow the path up |goto 50.48,37.05 < 30 |only if walking
talk Prospector Ryedol##2910
turnin A Dwarf and His Tools##719 |goto 53.42,43.40
step
talk Sigrun Ironhew##2860
turnin Mirages##718 |goto 53.80,43.31
accept Scrounging##733 |goto 53.80,43.31
step
talk Garek##2888
accept Tremors of the Earth##732 |goto 61.93,54.26
step
talk Rigglefuzz##2817
accept Barbecued Buzzard Wings##703 |goto 42.39,52.93
accept Pearl Diving##705 |goto 42.39,52.93
step
talk Rigglefuzz##2817
turnin Pearl Diving##705 |goto 42.39,52.93
step
talk Martek the Exiled##4618
turnin Martek the Exiled##1106 |goto 42.22,52.69
accept Indurium##1108 |goto 42.22,52.69
step
Follow the path |goto 48.69,53.36 < 30 |only if walking
click Battered Dwarven Skeleton
turnin Find Agmond##738 |goto 50.89,62.41
accept Murdaloc##739 |goto 50.89,62.41
stickystart "Collect_Iridium_Flakes"
stickystart "Kill_Stonevault_Bonesnapper"
step
kill Murdaloc##2945 |q 739/1 |goto 49.63,66.30
step
label "Collect_Iridium_Flakes"
Kill Stonevaule enemies around this area
collect 10 Indurium Flake##5797 |q 1108/1 |goto 50.51,69.96
step
label "Kill_Stonevault_Bonesnapper"
kill 12 Stonevault Bonesnapper##2893 |q 739/2 |goto 50.51,69.96
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
stickystart "Collect_Small_Stone_Shards"
step
kill Lesser Rock Elemental##2735+
collect 5 Rock Elemental Shard##7848 |q 2258/3 |goto 19.46,43.02
step
label "Collect_Small_Stone_Shards"
kill Lesser Rock Elemental##2735+
collect 10 Small Stone Shard##4626 |q 710/1 |goto 19.46,43.02
step
talk Lotwil Veriatus##2921
turnin Study of the Elements: Rock##710 |goto 25.95,44.87
accept Study of the Elements: Rock##711 |goto 25.95,44.87
stickystart "Collect_Buzzard_Gizzards"
stickystart "Collect_Buzzard_Wings"
stickystart "Collect_Crag_Coyote_Fangs"
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
collect Sign of the Earth##4640 |q 732/1
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
|tip Be careful to not accidentally sell these to a vendor.
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
Follow the path up |goto 13.40,81.62 < 30 |only if walking
kill Greater Rock Elemental##2736+
collect 5 Bracers of Rock Binding##4628 |q 712/1 |goto 15.36,88.40
step
Follow the path down |goto 13.21,83.30 < 20 |only if walking
Kill Dustbelcher enemies around this area
collect 7 Scrap Metal##4630 |q 733/1 |goto 11.29,75.60
step
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
step
talk Lucien Tosselwrench##2920
accept Liquid Stone##715 |goto 25.82,44.24
accept Stone Is Better than Cloth##716 |goto 25.82,44.24
step
talk Lucien Tosselwrench##2920
turnin Liquid Stone##715 |goto 25.82,44.24
turnin Stone Is Better than Cloth##716 |goto 25.82,44.24
step
Kill enemies around this area
Reach Level 41 |ding 41 |goto 22.65,55.05
step
talk Lotwil Veriatus##2921
accept This Is Going to Be Hard##778 |goto 25.95,44.86
|tip A Level 45 elemental will appear and attack you, so be prepared.
step
kill Fam'retor Guardian##2919
collect Lotwil's Shackles of Elemental Binding##4847 |q 778/1 |goto 26.10,46.81
step
talk Lotwil Veriatus##2921
turnin This Is Going to Be Hard##778 |goto 25.95,44.86
step
talk Rigglefuzz##2817
turnin Barbecued Buzzard Wings##703 |goto 42.39,52.93
step
talk Garek##2888
turnin Tremors of the Earth##732 |goto 61.93,54.26
step
Leave the building |goto Loch Modan 35.20,47.76 < 10 |walk
Enter the building |goto Loch Modan 36.63,48.53 < 10 |walk
talk Ghak Healtouch##1470
|tip Inside the building.
turnin Badlands Reagent Run##2500 |goto Loch Modan 37.07,49.38
step
Leave the building |goto 36.63,48.51 < 7 |walk
Follow the path |goto 47.77,66.72 < 30 |only if walking
talk Prospector Ironband##1344
turnin Murdaloc##739 |goto 65.93,65.62
step
Follow the path |goto 46.39,66.26 < 30 |only if walking
Continue following the path |goto 39.43,53.49 < 30 |only if walking
Enter the building |goto Stormwind City 63.60,22.83 < 10 |walk
talk Brohann Caskbelly##5384
|tip Inside the building.
accept In Search of The Temple##1448 |goto Stormwind City 64.33,20.66
step
Leave the building |goto 63.60,22.83 < 10 |walk
Enter the building |goto 41.16,63.63 < 10 |walk
talk Mazen Mac'Nadir##338
|tip Inside the building.
accept Mazen's Behest##1363 |goto 41.52,64.38
step
talk Acolyte Dellis##5386
|tip Upstairs inside the building.
turnin Mazen's Behest##1363 |goto 40.97,63.83
accept Mazen's Behest##1364 |goto 40.97,63.83
step
Leave the building |goto 41.19,63.70 < 7 |walk
Run up the ramp and enter the building |goto 39.32,81.50 < 15 |only if walking
talk High Sorcerer Andromath##5694
|tip Upstairs inside the building.
accept Vital Supplies##1477 |goto 37.52,81.67
step
Leave the building |goto 38.46,80.58 < 7 |walk
Run up the ramp |goto 62.42,62.30 < 15 |only if walking
talk Watchmaster Sorigal##5464
turnin Vital Supplies##1477 |goto Duskwood 75.77,46.15
step
Enter the building |goto 73.83,46.03 < 10 |walk
talk Innkeeper Trelayne##6790
|tip Inside the building.
home Darkshire |goto 73.87,44.40
step
Leave the building |goto 73.83,46.02 < 10 |walk
Follow the road |goto 79.16,45.38 < 30 |only if walking
Continue following the road |goto 89.64,41.29 < 30 |only if walking
Cross the bridge |goto Deadwind Pass 41.83,34.69 < 20 |only if walking
Follow the road |goto Deadwind Pass 52.04,43.41 < 20 |only if walking
Kill Whelp enemies around this area
collect 10 Speck of Dream Dust##5803 |q 1116/1 |goto Swamp of Sorrows 14.74,60.20
step
Follow the path |goto 19.06,55.41 < 30 |only if walking
talk Watcher Biggs##5476
accept Encroaching Wildlife##1396 |goto 26.74,59.83
step
Follow the path |goto 17.67,42.35 < 30 |only if walking
Kill enemies around this area
collect Khadgar's Essays on Dimensional Convergence##6065 |q 1364/1 |goto 15.76,38.48
|tip This has a low drop rate.
You can find more around [9.69,32.65]
stickystart "Kill_Young_Sawtooth_Crocolisks"
stickystart "Kill_Sorrow_Spinners"
stickystart "Kill_Swamp_Jaguars"
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
click Scattered Crate
collect Lost Supplies##6172 |goto 45.81,35.58 |q 1423 |future
step
use the Lost Supplies##6172
accept The Lost Supplies##1423
step
talk Magtoor##1776
turnin Noboru the Cudgel##1392 |goto 25.99,31.40
accept Draenethyst Crystals##1389 |goto 25.99,31.40
step
label "Kill_Young_Sawtooth_Crocolisks"
kill 8 Young Sawtooth Crocolisk##1084 |q 1396/1 |goto 24.26,41.68
You can find more around: |notinsticky
[26.24,52.44]
[31.68,47.06]
[30.90,39.17]
[35.26,34.86]
step
label "Kill_Sorrow_Spinners"
kill 10 Sorrow Spinner##858 |q 1396/2 |goto 21.91,40.55
|tip They look like spiders.
You can find more around: |notinsticky
[26.91,46.17]
[24.13,61.24]
[38.10,30.72]
step
label "Kill_Swamp_Jaguars"
kill 10 Swamp Jaguar##767 |q 1396/3 |goto 22.74,42.75
You can find more around: |notinsticky
[30.59,51.52]
[37.17,47.91]
[43.06,42.32]
[37.77,38.04]
[37.85,31.20]
step
talk Watcher Biggs##5476
turnin Encroaching Wildlife##1396 |goto 26.74,59.83
accept The Lost Caravan##1421 |goto 26.74,59.83
stickystart "Collect_Draenethyst_Crystals"
step
kill Ongeku##5622
collect Draenethyst Shard##6190 |q 1373/1 |goto 65.07,21.97
step
click Caravan Chest
collect Wizards' Reagents##6170 |q 1421/1 |goto 64.46,18.34
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
talk Watcher Biggs##5476
turnin The Lost Caravan##1421 |goto 26.74,59.83
accept Driftwood##1398 |goto 26.74,59.83
step
Follow the road |goto 35.80,59.70 < 30 |only if walking
Follow the path |goto Blasted Lands 53.24,11.99 < 20 |only if walking
Follow the path up |goto Blasted Lands 60.43,18.21 < 30 |only if walking
Follow the path |goto Blasted Lands 62.66,19.80 < 20 |only if walking
Enter the building |goto Blasted Lands 66.38,18.99 < 10 |walk
talk Watcher Mahar Ba##5385
|tip Inside the tower, at the top.
turnin Mazen's Behest##1364 |goto Blasted Lands 67.65,19.16
step
Leave the building |goto 66.39,19.00 < 10 |walk
talk Quartermaster Lungertz##5393
turnin The Lost Supplies##1423 |goto 66.52,21.38
step
talk Alexandra Constantine##8609
|tip On top of the wooden platform.
fpath Nethergarde Keep |goto 65.54,24.33
step
talk Watchmaster Sorigal##5464
accept Supplies for Nethergarde##1395 |goto Duskwood 75.77,46.15
step
talk Quartermaster Lungertz##5393
turnin Supplies for Nethergarde##1395 |goto Blasted Lands 66.52,21.38
step
Follow the path |goto 62.82,19.77 < 20 |only if walking
Follow the road |goto 52.25,11.17 < 30 |only if walking
Follow the path |goto 35.98,56.71 < 30 |only if walking
Avoid Stonard |goto Swamp of Sorrows 44.61,44.21 < 30 |only if walking
Search for the Temple of Atal'Hakkar |q 1448/1 |goto Swamp of Sorrows 66.68,49.62
|tip Avoid the elite enemies on the shore surrounding the lake.
stickystart "Collect_Pristine_Crawler_Legs"
step
click Sundried Driftwood+
|tip They look like wooden logs on the ground around this area.
|tip You can find them along this entire coast.
collect 8 Sundried Driftwood##6146 |q 1398/1 |goto 82.89,91.19
You can find more around: |notinsticky
[87.05,79.49]
[92.69,66.61]
[94.31,56.26]
step
label "Collect_Pristine_Crawler_Legs"
Kill Crawler enemies around this area
|tip They look like crabs.
|tip You can find a few more in the water along the shore.
collect 12 Pristine Crawler Leg##5938 |q 1258/1 |goto 84.82,85.11
You can find more around: |notinsticky
[87.37,78.50]
[94.25,58.94]
[94.49,45.41]
[90.25,26.39]
[81.33,10.31]
step
Kill enemies around this area
Reach Level 42 |ding 42 |goto 84.82,85.11
You can find more around: |notinsticky
[87.37,78.50]
[94.25,58.94]
[94.49,45.41]
[90.25,26.39]
[81.33,10.31]
step
Leave the building |goto Duskwood 73.83,46.01 < 10 |walk
Follow the road |goto Duskwood 79.16,45.38 < 30 |only if walking
Continue following the road |goto Duskwood 89.64,41.29 < 30 |only if walking
Cross the bridge |goto Deadwind Pass 41.83,34.69 < 20 |only if walking
Follow the road |goto Deadwind Pass 52.04,43.41 < 20 |only if walking
Continue following the road |goto Swamp of Sorrows 20.38,50.06 < 30 |only if walking
talk Watcher Biggs##5476
turnin Driftwood##1398 |goto Swamp of Sorrows 26.74,59.82
accept Deliver the Shipment##1425 |goto Swamp of Sorrows 26.74,59.82
step
Follow the road |goto 35.80,59.70 < 30 |only if walking
Follow the path |goto Blasted Lands 53.24,11.99 < 20 |only if walking
Follow the path up |goto Blasted Lands 60.43,18.21 < 30 |only if walking
Follow the path |goto Blasted Lands 62.66,19.80 < 20 |only if walking
talk Quartermaster Lungertz##5393
turnin Deliver the Shipment##1425 |goto Blasted Lands 66.52,21.38
step
Enter the building |goto Stormwind City 63.59,22.85 < 10 |walk
talk Brohann Caskbelly##5384
|tip Inside the building.
turnin In Search of The Temple##1448 |goto Stormwind City 64.33,20.66
accept To The Hinterlands##1449 |goto Stormwind City 64.33,20.66
step
Leave the building |goto 63.60,22.85 < 10 |walk
Run up the ramp |goto 62.40,62.27 < 15 |only if walking
step
Enter the building |goto Stranglethorn Vale 27.10,77.66 < 7 |walk
talk Deeg##2488
|tip Upstairs inside the building, on the top floor.
accept Up to Snuff##587 |goto Stranglethorn Vale 26.92,77.35
step
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
turnin Dream Dust in the Swamp##1116 |goto 26.94,77.21
step
Watch the dialogue
talk Krazek##773
|tip Upstairs inside the building, on the top floor.
accept Rumors for Kravel##1117 |goto 26.94,77.21
accept Tran'rek##2864 |goto 26.94,77.21
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
accept Skullsplitter Tusks##209 |goto 27.00,77.13
step
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
accept The Bloodsail Buccaneers##604 |goto 27.17,77.01
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
Run up the ramp |goto 27.86,76.76 < 10 |only if walking
Follow the path |goto 28.39,75.77 < 10 |only if walking
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
step
Follow the path |goto 32.75,73.65 < 30 |only if walking
Follow the path up |goto 29.71,66.37 < 20 |only if walking
Jump down here |goto 27.85,67.41 < 15 |only if walking
Follow the path |goto 24.57,64.60 < 20 |only if walking
Follow the path up |goto 25.73,63.56 < 15 |only if walking
Follow the path |goto 27.35,62.99 < 15 |only if walking
Cross the bridge |goto 28.17,62.71 < 15 |only if walking
kill Naga Explorer##1907+
collect 10 Akiris Reed##4029 |q 617/1 |goto 27.88,62.75
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
step
Kill Skullspliter enemies around this area
collect 18 Skullsplitter Tusk##1524 |q 209/1 |goto 42.69,36.60
You can find more around: |notinsticky
[45.93,32.79]
[47.39,39.42]
[45.33,42.07]
step
Follow the road |goto 43.88,29.01 < 30 |only if walking
Follow the path up |goto 39.06,5.21 < 20 |only if walking
kill Elder Saltwater Crocolisk##2635
collect Elder Crocolisk Skin##4105 |q 628/1 |goto 33.41,32.54
If it's not here, you can find more at:
[29.86,25.63]
[29.29,22.16]
[25.39,19.18]
step
talk Crank Fizzlebub##2498
|tip Inside the building.
turnin Venture Company Mining##600 |goto 27.12,77.21
turnin Zanzil's Secret##621 |goto 27.12,77.21
step
talk Whiskey Slim##2491
|tip Inside the building.
accept Whiskey Slim's Lost Grog##580 |goto 27.13,77.45
step
talk Kebok##737
|tip Upstairs inside the building, on the top floor.
turnin Skullsplitter Tusks##209 |goto 27.00,77.13
step
talk Deeg##2488
|tip Upstairs inside the building, on the top floor.
turnin Up to Snuff##587 |goto 26.92,77.35
step
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
turnin The Bloodsail Buccaneers##604 |goto 27.17,77.01
step
talk Baron Revilgaz##2496
|tip Upstairs, on the balcony of the building.
accept Magical Analysis##602 |goto 27.22,76.87
step
talk Privateer Bloads##2494
|tip He walks around this area.
turnin Akiris by the Bundle##617 |goto 26.76,76.38
accept Akiris by the Bundle##623 |goto 26.76,76.38
He sometimes walks to [27.43,76.78]
step
Enter the building |goto 27.64,77.09 < 7 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Voodoo Dues##609 |goto 27.78,77.07
accept Stoley's Debt##2872 |goto 27.78,77.07
step
Leave the building |goto 27.63,77.09 < 7 |walk
Cross the bridge |goto 28.15,76.52 < 10 |only if walking
Enter the building |goto 28.21,77.33 < 7 |walk
talk Drizzlik##2495
|tip Inside the building.
turnin Excelsior##628 |goto 28.29,77.59
step
Leave the building |goto 28.21,77.33 < 7 |walk
Follow the path |goto 28.16,76.37 < 10 |only if walking
Follow the path |goto 28.14,76.38 < 10 |only if walking
talk Dizzy One-Eye##2493
turnin Keep An Eye Out##576 |goto 28.59,75.90
step
talk Privateer Groy##2616
turnin Akiris by the Bundle##623 |goto Dustwallow Marsh 68.84,53.22
step
Follow the road |goto 67.00,48.02 < 30 |only if walking
Enter the building |goto 66.00,45.20 < 10 |walk
talk Morgan Stern##4794
|tip Inside the building.
turnin ... and Bugs##1258 |goto 66.34,45.47
step
Leave the building |goto 58.44,66.91 < 10 |walk
Follow the road |goto 58.58,67.28 < 30 |only if walking
talk Innkeeper Lyshaerya##11103
|tip Inside the building.
home Nijel's Point |goto Desolace 66.27,6.55
step
talk Brother Anton##1182
|tip Inside the building.
accept Down the Scarlet Path##261 |goto 66.52,7.91
step
talk Kreldig Ungor##5638
accept Reagents for Reclaimers Inc.##1466 |goto 66.20,9.63
step
Follow the path down |goto 67.05,12.91 < 20 |only if walking
Follow the road |goto 63.03,24.34 < 30 |only if walking
Continue following the road |goto 53.00,37.70 < 30 |only if walking
Follow the path |goto 49.16,54.90 < 30 |only if walking
talk Hornizz Brimbuzzle##6019
accept Ghost-o-plasm Round Up##6134 |goto 47.83,61.82
step
Follow the path up |goto 46.76,67.06 < 15 |only if walking
Follow the path down |goto 46.35,70.20 < 15 |only if walking
Follow the road |goto 43.71,76.57 < 30 |only if walking
talk Uthek the Wise##5397
turnin Ongeku##1373 |goto 36.22,79.25
accept Khan Jehn##1374 |goto 36.22,79.25
stickystart "Collect_Nether_Wings"
stickystart "Collect_Felhound_Brains"
step
Follow the road |goto 46.98,75.20 < 30 |only if walking
Follow the path up |goto 52.07,82.38 < 20 |only if walking
kill Doomwarder Captain##4680+
collect 10 Doomwarder Blood##6252 |q 1466/3 |goto 51.71,83.27
step
label "Collect_Nether_Wings"
Kill Nether enemies around this area
|tip They look like succubuses.
collect 10 Nether Wing##6251 |q 1466/2 |goto 51.03,71.80
You can find more around: |notinsticky
[49.69,77.79]
[52.10,82.27]
[54.01,77.40]
[54.26,70.63]
step
label "Collect_Felhound_Brains"
Kill enemies around this area
|tip They look like felhounds.
collect Felhound Brain##6250 |q 1466/1 |goto 51.06,80.69
You can find more around: |notinsticky
[53.78,84.41]
[53.57,77.87]
[56.41,78.38]
[56.11,72.79]
step
Kill enemies around this area
Reach Level 43 |ding 43 |goto 51.03,71.80
You can find more around: |notinsticky
[49.69,77.79]
[52.10,82.27]
[54.01,77.40]
[54.26,70.63]
step
Follow the path up |goto 64.19,75.85 < 20 |only if walking
kill Khan Jehn##5601
|tip He walks in and out of this tent.
collect Khan Jehn's Head##6072 |q 1374/1 |goto 66.39,80.08
stickystart "Kill_Undead_Ravagers"
step
Follow the path |goto 65.21,85.46 < 20 |only if walking
use the Crate of Ghost Magnets##15848
|tip Kill any nearby enemies before using it.
|tip Use it next to the huge bones on the ground around this area.
kill Magrami Spectre##11560+
|tip They continuously walk to the spinning green thing that appears on the ground.
collect 8 Ghost-o-plasm##15849 |q 6134/1 |goto 63.81,91.27
step
label "Kill_Undead_Ravagers"
kill 30 Undead Ravager##11561 |q 261/1 |goto 63.96,91.95
You can find more around: |notinsticky
[59.78,89.83]
[64.52,82.42]
step
Follow the path |goto 58.85,88.94 < 30 |only if walking
Follow the path |goto 48.96,64.86 < 30 |only if walking
talk Hornizz Brimbuzzle##6019
turnin Ghost-o-plasm Round Up##6134 |goto 47.83,61.83
step
Follow the path up |goto 46.76,67.06 < 15 |only if walking
Follow the path down |goto 46.35,70.20 < 15 |only if walking
Follow the road |goto 43.71,76.57 < 30 |only if walking
talk Uthek the Wise##5397
turnin Khan Jehn##1374 |goto 36.22,79.25
step
talk Brother Anton##1182
|tip Inside the building.
turnin Down the Scarlet Path##261 |goto 66.52,7.91
accept Down the Scarlet Path##1052 |goto 66.52,7.91
step
talk Kreldig Ungor##5638
turnin Reagents for Reclaimers Inc.##1466 |goto 66.20,9.63
accept Reagents for Reclaimers Inc.##1467 |goto 66.20,9.63
step
Follow the path |goto Tanaris 51.02,28.62 < 15 |only if walking
talk Senior Surveyor Fizzledowser##7724
accept Gadgetzan Water Survey##992 |goto Tanaris 50.21,27.48
step
talk Tran'rek##7876
turnin Tran'rek##2864 |goto 51.57,26.76
step
click Wanted Poster
accept WANTED: Caliph Scorpidsting##2781 |goto 51.84,27.02
accept WANTED: Andre Firebeard##2875 |goto 51.84,27.02
step
talk Curgle Cranklehop##7763
accept Handle With Care##3022 |goto 52.35,26.91
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
Follow the path |goto 51.87,26.53 < 15 |only if walking
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
|tip Kite him away from his guards, so you can fight him alone.
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
|tip It may take a while to get it, but you are about to have to grind to level 44 anyway.
You can find more around [72.29,44.64]
step
use the Ship Schedule##9250
accept Ship Schedules##2876
step
Kill enemies around this area
Reach Level 44 |ding 44 |goto 73.26,46.42
You can find more around [72.29,44.64]
step
talk Spigot Operator Luglunket##7408
turnin Water Pouch Bounty##1878 |goto 52.48,28.44
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
Follow the path |goto 51.55,29.01 < 15 |only if walking
talk Pratt McGrubben##7852
accept The Mark of Quality##2821 |goto Feralas 30.63,42.71
step
talk Innkeeper Shyria##7736
|tip Inside the building.
home Feathermoon Stronghold |goto 30.97,43.49
step
Enter the building |goto 30.77,45.23 < 15 |walk
talk Latronicus Moonspear##7877
|tip Inside the building.
accept The Missing Courier##4124 |goto 30.38,46.17
step
talk Shandris Feathermoon##3936
|tip Inside the building.
accept The Ruins of Solarsal##2866 |goto 30.28,46.17
step
Leave the building |goto 30.77,45.23 < 15 |walk
Enter the building |goto 31.84,45.01 < 15 |walk
talk Troyas Moonbreeze##7764
|tip Inside the building.
accept In Search of Knowledge##2939 |goto 31.78,45.50
step
talk Angelas Moonbreeze##7900
|tip Inside the building.
accept The High Wilderness##2982 |goto 31.83,45.61
step
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin The Missing Courier##4124 |goto 31.86,45.13
accept The Missing Courier##4125 |goto 31.86,45.13
step
click Solarsal Gazebo
|tip You have to be standing inside of it to be able to click it.
turnin The Ruins of Solarsal##2866 |goto 26.32,52.34
accept Return to Feathermoon Stronghold##2867 |goto 26.32,52.34
step
Jump up here to enter the building |goto 31.01,46.41 < 10 |walk
talk Shandris Feathermoon##3936
|tip Inside the building.
turnin Return to Feathermoon Stronghold##2867 |goto 30.28,46.17
accept Against the Hatecrest##3130 |goto 30.28,46.17
step
talk Latronicus Moonspear##7877
|tip Inside the building.
turnin Against the Hatecrest##3130 |goto 30.38,46.17
accept Against the Hatecrest##2869 |goto 30.38,46.17
step
Kill Hatecrest enemies around this area
collect 10 Hatecrest Naga Scale##9247 |q 2869/1 |goto 28.66,53.05
You can find more around [26.21,51.95]
step
Jump up here to enter the building |goto 31.01,46.41 < 10 |walk
talk Latronicus Moonspear##7877
|tip Inside the building.
turnin Against the Hatecrest##2869 |goto 30.38,46.17
accept Against Lord Shalzaru##2870 |goto 30.38,46.17
step
Follow the path |goto 25.48,64.99 < 20 |only if walking
Enter the cave |goto 26.04,67.33 < 20 |walk
Follow the path up |goto 27.22,69.66 < 10 |walk
kill Lord Shalzaru##8136
|tip Inside the building.
collect Mysterious Relic##9248 |q 2870/1 |goto 28.49,70.45
step
Follow the path down |goto 27.34,69.73
Leave the cave |goto 25.90,67.16 < 20 |c |q 2870
step
Kill enemies around this area
|tip Inside and outside the cave.
Reach Level 45 |ding 45 |goto 25.89,67.12
You can find more around: |notinsticky
[25.44,63.68]
[26.18,54.23]
[28.84,53.96]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (45-50)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (50-55)",
startlevel=45,
endlevel=50,
},[[
step
click Wrecked Row Boat
|tip Underwater.
turnin The Missing Courier##4125 |goto Feralas 45.45,64.97
accept Boat Wreckage##4127 |goto Feralas 45.45,64.97
step
Enter the building |goto 31.84,45.02 < 15 |walk
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin Boat Wreckage##4127 |goto 31.86,45.13
accept The Knife Revealed##4129 |goto 31.86,45.13
step
Enter the building |goto 30.77,45.23 < 15 |walk
talk Latronicus Moonspear##7877
|tip Inside the building.
turnin Against Lord Shalzaru##2870 |goto 30.38,46.17
accept Delivering the Relic##2871 |goto 30.38,46.17
step
talk Vestia Moonspear##7878
|tip Inside the building.
turnin Delivering the Relic##2871 |goto 30.08,45.06
step
Leave the building |goto 30.77,45.23 < 15 |walk
Enter the building |goto 32.34,43.69 < 10 |walk
talk Quintis Jonespyre##7879
|tip Upstairs inside the building.
turnin The Knife Revealed##4129 |goto 32.45,43.79
step
Watch the dialogue
talk Quintis Jonespyre##7879
|tip Upstairs inside the building.
accept Psychometric Reading##4130 |goto 32.45,43.79
step
Leave the building |goto 32.67,44.05 < 7 |walk
Enter the building |goto 31.84,45.02 < 15 |walk
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin Psychometric Reading##4130 |goto 31.86,45.13
accept The Woodpaw Gnolls##4131 |goto 31.86,45.13
step
Run up the ramp |goto 30.92,43.21 < 15 |only if walking
Ride the boat or swim across the water |goto 31.03,39.92 < 20 |only if walking
kill Rogue Vale Screecher##5308+
use Yeh'kinya's Bramble##10699
|tip Use it on their corpses.
talk Screecher Spirit##8612+
|tip They appear after using Yeh'kinya's Bramble on the corpses.
Collect #3# Screecher Spirits |q 3520/1 |goto 42.49,36.47
You can find more around: |notinsticky
[44.46,36.19]
stickystart "Collect_Thick_Yeti_Hides"
step
Follow the path up |goto 47.11,44.49 < 20 |only if walking
Follow the road |goto 48.68,45.02 < 30 |only if walking
Follow the path |goto 54.92,52.74 < 30 |only if walking
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
collect 10 Thick Yeti Hide##8973 |q 2821/1 |goto 56.20,57.02
You can find more through the tunnel at [55.14,56.36]
stickystart "Kill_Gordunni_Shamans"
stickystart "Kill_Gordunni_Warlocks"
step
Follow the road |goto 56.24,51.39 < 30 |only if walking
kill 8 Gordunni Brute##5232 |q 2982/3 |goto 61.00,55.61
You can find more around [59.28,63.51]
step
label "Kill_Gordunni_Shamans"
kill 8 Gordunni Shaman##5236 |q 2982/2 |goto 59.67,66.85
step
label "Kill_Gordunni_Warlocks"
kill 8 Gordunni Warlock##5240 |q 2982/1 |goto 59.22,64.15
You can find more around [61.03,55.64]
step
Follow the road |goto 61.99,52.95 < 30 |only if walking
Follow the path down |goto 64.37,50.01 < 15 |only if walking
Follow the path |goto 64.91,48.18 < 20 |only if walking
Kill enemies around this area
|tip Clear the area around the large cage, to make the next step easier.
Click Here After You Clear the Enemies |confirm |goto 66.69,46.57 |q 2969 |future
step
Follow the path up |goto 65.66,46.77 < 10 |only if walking
Follow the path down |goto 65.81,46.10 < 10 |only if walking
talk Kindal Moonweaver##7956
accept Freedom for All Creatures##2969 |goto 65.94,45.65
step
click Cage Door
|tip Follow the Captured Sprite Darters and protect them.
|tip You have to make sure at least 6 of them survive.
|tip HURRY!  You must complete the quest and turn it in before the timer ends.
Save at Least 6 Sprite Darters from Capture |q 2969/1 |goto 66.67,46.75
step
Follow the path up |goto 65.66,46.77 < 10 |only if walking
Follow the path down |goto 65.81,46.10 < 10 |only if walking
talk Kindal Moonweaver##7956
|tip HURRY!  You must turn it in before the timer ends.
turnin Freedom for All Creatures##2969 |goto 65.94,45.65
step
talk Jer'kai Moonweaver##7957
accept Doling Justice##2970 |goto 65.95,45.61
stickystart "Kill_Grimtotem_Raiders"
stickystart "Kill_Grimtotem_Naturalists"
step
kill 6 Grimtotem Shaman##7727 |q 2970/3 |goto 66.89,46.43
You can find more:
Around [68.71,47.04]
Around [69.59,39.44]
Up the path at [68.26,39.25]
step
label "Kill_Grimtotem_Raiders"
kill 10 Grimtotem Raider##7725 |q 2970/2 |goto 66.89,46.43
You can find more:
Around [68.71,47.04]
Around [69.59,39.44]
Up the path at [68.26,39.25]
step
label "Kill_Grimtotem_Naturalists"
kill 12 Grimtotem Naturalist##7726 |q 2970/1 |goto 66.89,46.43
You can find more:
Around [68.71,47.04]
Around [69.59,39.44]
Up the path at [68.26,39.25]
step
Follow the path up |goto 65.66,46.77 < 10 |only if walking
Follow the path down |goto 65.81,46.10 < 10 |only if walking
talk Jer'kai Moonweaver##7957
turnin Doling Justice##2970 |goto 65.95,45.61
accept Doling Justice##2972 |goto 65.95,45.61
step
click Large Leather Backpacks
turnin The Woodpaw Gnolls##4131 |goto 73.31,56.31
accept The Writhing Deep##4135 |goto 73.31,56.31
step
use the Undelivered Parcel##11463
accept Thalanaar Delivery##4281
step
Follow the path up |goto 72.11,62.68 < 30 |only if walking
Follow the path down |goto 73.69,63.07 < 15 |only if walking
Enter the cave at the bottom of the path |goto 73.17,63.88 < 10 |walk
Follow the path down |goto 72.69,64.56 < 7 |walk
click Zukk'ash Pod
|tip Inside the cave.
turnin The Writhing Deep##4135 |goto 72.08,63.75
accept Freed from the Hive##4265 |goto 72.08,63.75
step
Watch the dialogue
|tip Inside the cave.
Free Raschal |q 4265/1 |goto 72.08,63.77
step
talk Pratt McGrubben##7852
turnin The Mark of Quality##2821 |goto 30.63,42.71
step
Enter the building |goto 31.84,45.01 < 15 |only if walking
talk Angelas Moonbreeze##7900
|tip Inside the building.
turnin The High Wilderness##2982 |goto 31.83,45.61
step
talk Ginro Hearthkindle##7880
|tip Upstairs inside the building.
turnin Freed from the Hive##4265 |goto 31.86,45.13
accept A Hero's Welcome##4266 |goto 31.86,45.13
step
Enter the building |goto 30.76,45.23 < 15 |walk
talk Shandris Feathermoon##3936
|tip Inside the building.
turnin A Hero's Welcome##4266 |goto 30.28,46.17
accept Rise of the Silithid##4267 |goto 30.28,46.17
step
Kill enemies around this area
|tip Inside and outside the cave.
Reach Level 46 |ding 46 |goto 28.72,53.85
You can find more around: |notinsticky
[26.62,52.52]
[25.46,65.08]
step
talk Falfindel Waywarder##4048
turnin Thalanaar Delivery##4281 |goto 89.64,46.57
step
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Handle With Care##3022 |goto Teldrassil 55.50,92.05
accept Favored of Elune?##3661 |goto Teldrassil 55.50,92.05
step
talk Daryn Lightwind##7907
|tip Upstairs inside the building.
turnin In Search of Knowledge##2939 |goto 55.41,92.23
step
click Feralas: A History
|tip Upstairs inside the building.
accept Feralas: A History##2940 |goto 55.22,91.46
step
talk Daryn Lightwind##7907
|tip Upstairs inside the building.
turnin Feralas: A History##2940 |goto 55.41,92.23
accept The Borrower##2941 |goto 55.41,92.23
step
Cross the bridge |goto Darnassus 38.60,48.01 < 20 |only if walking
Enter the building |goto Darnassus 39.06,77.04 < 15 |walk
Run up the ramp |goto Darnassus 40.46,91.67 < 7 |walk
talk Tyrande Whisperwind##7999
|tip Upstairs inside the building.
turnin Doling Justice##2972 |goto Darnassus 39.10,81.59
step
talk Gracina Spiritmight##7740
|tip Upstairs inside the building.
turnin Rise of the Silithid##4267 |goto 41.85,85.62
step
Leave the building |goto 39.06,77.04 < 15 |walk
Follow the path |goto Teldrassil 56.79,92.67 < 20 |only if walking
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
Follow the path |goto Tanaris 51.55,29.02 < 15 |only if walking
talk Curgle Cranklehop##7763
turnin The Borrower##2941 |goto Tanaris 52.36,26.91
accept The Super Snapper FX##2944 |goto Tanaris 52.36,26.91
step
Follow the path |goto 51.55,29.02 < 15 |only if walking
Enter the building |goto Hillsbrad Foothills 50.44,58.55 < 10 |walk
talk Raleigh the Devout##3980
|tip Upstairs inside the building.
turnin Down the Scarlet Path##1052 |goto Hillsbrad Foothills 51.47,58.35
step
Leave the building |goto 50.45,58.55 < 10 |walk
Follow the path |goto 32.08,29.16 < 40 |only if walking
talk Archmage Ansirem Runeweaver##2543
turnin Magical Analysis##602 |goto Alterac Mountains 18.84,78.49
step
Watch the dialogue
talk Archmage Ansirem Runeweaver##2543
accept Ansirem's Key##603 |goto 18.84,78.49
step
Follow the path |goto Hillsbrad Foothills 32.08,29.16 < 40 |only if walking
Follow the road |goto Hillsbrad Foothills 47.74,39.78 < 30 |only if walking
Follow the path |goto Hillsbrad Foothills 66.41,42.83 < 30 |only if walking
Continue following the path |goto Hillsbrad Foothills 75.59,32.78 < 30 |only if walking
Follow the path |goto Hillsbrad Foothills 84.35,32.31 < 30 |only if walking
Follow the road |goto The Hinterlands 9.85,54.94 < 20 |only if walking
Follow the path up |goto The Hinterlands 13.50,47.99 < 20 |only if walking
talk Falstad Wildhammer##5635
turnin To The Hinterlands##1449 |goto The Hinterlands 11.81,46.76
accept Gryphon Master Talonaxe##1450 |goto The Hinterlands 11.81,46.76
step
talk Guthrum Thunderfist##8018
|tip At the top of the path.
fpath Aerie Peak |goto 11.07,46.15
step
Enter the building |goto 11.00,45.67 < 10 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin Gryphon Master Talonaxe##1450 |goto 9.76,44.48
accept Rhapsody Shindigger##1451 |goto 9.76,44.48
accept Witherbark Cages##2988 |goto 9.76,44.48
step
Leave the building |goto 10.99,45.66 < 10 |walk
Enter the building |goto 14.20,45.15 < 20 |only if walking
talk Fraggar Thundermantle##7884
|tip Inside the building.
accept Skulk Rock Clean-up##2877 |goto 14.83,44.56
accept Troll Necklace Bounty##2880 |goto 14.83,44.56
step
talk Innkeeper Thulfram##7744
|tip He walks around upstairs inside the building.
home Wildhammer Keep |goto 14.15,41.57
stickystart "Collect_Troll_Tribal_Necklaces"
stickystart "Collect_Wildkin_Feathers"
step
Leave the building |goto 14.18,45.19 < 20 |walk
Follow the path up |goto 20.81,47.82 < 20 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody Shindigger##1451 |goto 26.94,48.59
accept Rhapsody's Kalimdor Kocktail##1452 |goto 26.94,48.59
step
click First Witherbark Cage
Check the First Cage |q 2988/1 |goto 23.28,58.75
step
click Second Witherbark Cage
Check the Second Cage |q 2988/2 |goto 23.13,58.76
step
Follow the path |goto 30.53,53.53 < 30 |only if walking
Follow the path |goto 32.40,57.21 < 15 |only if walking
click Third Witherbark Cage
Check the Third Cage |q 2988/3 |goto 31.99,57.38
step
label "Collect_Troll_Tribal_Necklaces"
Kill Witherbark enemies around this area
|tip They look like trolls.
collect 5 Troll Tribal Necklace##9259 |q 2880/1 |goto 32.03,58.00
|tip Be careful not to accidentally sell these to a vendor.
You can find more around [23.73,57.89]
stickystart "Kill_Jade_Oozes"
step
kill 10 Green Sludge##2655 |q 2877/1 |goto 47.11,41.36
You can find more around: |notinsticky
[49.04,52.42]
[56.67,43.39]
step
label "Kill_Jade_Oozes"
kill 10 Jade Ooze##2656 |q 2877/2 |goto 47.11,41.36
You can find more around: |notinsticky
[49.04,52.42]
[56.67,43.39]
step
Kill enemies around this area
collect OOX-09/HL Distress Beacon##8704 |goto 47.11,41.36 |q 485 |future
|tip This has a low drop rate.
You can find more around: |notinsticky
[49.04,52.42]
[56.67,43.39]
step
use the OOX-09/HL Distress Beacon##8704
accept Find OOX-09/HL!##485
step
talk Homing Robot OOX-09/HL##7806
turnin Find OOX-09/HL!##485 |goto 49.35,37.66
step
label "Collect_Wildkin_Feathers"
click Wildkin Feather+
|tip They look large brown and white feathers on the ground around this area.
|tip They can be found around most of the Hinterlands, except in the eastern part.
collect 15 Wildkin Feather##10819 |q 3661/1 |goto 44.35,45.43
You can find more around: |notinsticky
[41.01,44.97]
[33.03,43.66]
[33.90,48.74]
[28.43,54.20]
[21.94,52.89]
stickystart "Collect_Snapshot_Of_Gammerita"
step
Follow the road |goto 61.28,53.08 < 30 |only if walking
Follow the path down |goto 71.50,65.09 < 20 |only if walking
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful to avoid Gammmerita, it's the only turtle that will attack you.
|tip It looks like a blue turtle that walks around this area.
collect Pupellyverbos Port##3900 |q 580/1 |goto 77.91,58.29 |count 1
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful to avoid Gammmerita, it's the only turtle that will attack you.
|tip It looks like a blue turtle that walks around this area.
collect Pupellyverbos Port##3900 |q 580/1 |goto 80.02,59.75 |count 2
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful to avoid Gammmerita, it's the only turtle that will attack you.
|tip It looks like a blue turtle that walks around this area.
collect Pupellyverbos Port##3900 |q 580/1 |goto 77.82,65.54 |count 3
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful to avoid Gammmerita, it's the only turtle that will attack you.
|tip It looks like a blue turtle that walks around this area.
collect Pupellyverbos Port##3900 |q 580/1 |goto 79.45,70.30 |count 4
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful to avoid Gammmerita, it's the only turtle that will attack you.
|tip It looks like a blue turtle that walks around this area.
collect Pupellyverbos Port##3900 |q 580/1 |goto 78.71,70.65 |count 5
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful to avoid Gammmerita, it's the only turtle that will attack you.
|tip It looks like a blue turtle that walks around this area.
collect Pupellyverbos Port##3900 |q 580/1 |goto 75.51,70.20 |count 6
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful to avoid Gammmerita, it's the only turtle that will attack you.
|tip It looks like a blue turtle that walks around this area.
collect Pupellyverbos Port##3900 |q 580/1 |goto 77.26,74.96 |count 7
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful of the horde guards nearby.
|tip If you click the bottle from this exact spot, you can get it out of range of the guards.
collect Pupellyverbos Port##3900 |q 580/1 |goto 77.23,75.97 |count 8
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful of the horde town nearby.
collect Pupellyverbos Port##3900 |q 580/1 |goto 78.27,75.58 |count 9
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful of the horde town nearby.
collect Pupellyverbos Port##3900 |q 580/1 |goto 78.51,75.78 |count 10
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful of the horde town nearby.
collect Pupellyverbos Port##3900 |q 580/1 |goto 78.68,76.03 |count 11
step
click Pupellyverbos Port
|tip They look like small dark blue bottles on the ground around this area.
|tip Be careful of the horde guards nearby.
|tip If you click the bottle from this exact spot, you can get it out of range of the guards.
collect Pupellyverbos Port##3900 |q 580/1 |goto 78.81,76.20 |count 12
step
label "Collect_Snapshot_Of_Gammerita"
use the Super Snapper FX##9328
|tip Use it on Gammerita.
|tip It looks like a blue turtle that walks around this area.
|tip Use it as far away from it as you can.
|tip Run away when it attacka you after using the item.
collect Snapshot of Gammerita##9330 |q 2944/1 |goto 75.62,67.03
You can also find it around:
[75.62,67.03]
[80.79,55.59]
step
talk Fraggar Thundermantle##7884
|tip Inside the building.
turnin Skulk Rock Clean-up##2877 |goto 14.84,44.57
turnin Troll Necklace Bounty##2881 |goto 14.84,44.57
step
Leave the building |goto 14.19,45.19 < 20 |only if walking
Follow the path up |goto 12.91,48.27 < 20 |only if walking
Enter the building at the top of the path |goto 11.00,45.67 < 10 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin Witherbark Cages##2988 |goto 9.76,44.47
accept The Altar of Zul##2989 |goto 9.76,44.47
step
Leave the building |goto 10.99,45.66 < 10 |walk
talk Roetten Stonehammer##5637
|tip He walks around inside the building.
turnin Reagents for Reclaimers Inc.##1467 |goto Ironforge 67.91,17.52
step
talk Historian Karnik##2916
|tip Inside the building.
accept Passing the Burden##3448 |goto 77.53,11.83
step
Run up the stairs |goto 31.89,8.28 < 10 |only if walking
Enter the building |goto 32.02,5.49 < 7 |walk
talk Tymor##8507
|tip Inside the building.
turnin Passing the Burden##3448 |goto 30.96,4.82
accept Arcane Runes##3449 |goto 30.96,4.82
accept An Easy Pickup##3450 |goto 30.96,4.82
step
Leave the building |goto 31.96,5.32 < 7 |walk
Enter the building |goto 66.40,82.48 < 10 |walk
talk Xiggs Fuselighter##8517
|tip Inside the building.
turnin An Easy Pickup##3450 |goto 70.88,94.55
accept Signal for Pickup##3451 |goto 70.88,94.55
step
talk Xiggs Fuselighter##8517
|tip Inside the building.
turnin Signal for Pickup##3451 |goto 70.88,94.55
step
Leave the building |goto 66.32,82.33 < 7 |walk
Enter the building |goto Ironforge 26.10,72.19 < 10 |walk
talk Auctioneer Redmuse##8720
|tip Inside the building.
|tip Buy these items from the Auction House.
|tip If you have any Green Hills of Stranglethorn pages in your bank, get them out before buying any of these pages.
collect Green Hills of Stranglethorn - Page 1##2725 |goto Ironforge 24.25,74.53 |q 339 |future |only if ((itemcount(2725) < 1) and (not completedq(339)))
collect Green Hills of Stranglethorn - Page 4##2728 |goto Ironforge 24.25,74.53 |q 339 |future |only if ((itemcount(2728) < 1) and (not completedq(339)))
collect Green Hills of Stranglethorn - Page 6##2730 |goto Ironforge 24.25,74.53 |q 339 |future |only if ((itemcount(2730) < 1) and (not completedq(339)))
collect Green Hills of Stranglethorn - Page 8##2732 |goto Ironforge 24.25,74.53 |q 339 |future |only if ((itemcount(2732) < 1) and (not completedq(339)))
collect Green Hills of Stranglethorn - Page 10##2734 |goto Ironforge 24.25,74.53 |q 340 |future |only if ((itemcount(2734) < 1) and (not completedq(340)))
collect Green Hills of Stranglethorn - Page 11##2735 |goto Ironforge 24.25,74.53 |q 340 |future |only if ((itemcount(2735) < 1) and (not completedq(340)))
collect Green Hills of Stranglethorn - Page 14##2738 |goto Ironforge 24.25,74.53 |q 340 |future |only if ((itemcount(2738) < 1) and (not completedq(340)))
collect Green Hills of Stranglethorn - Page 16##2740 |goto Ironforge 24.25,74.53 |q 340 |future |only if ((itemcount(2740) < 1) and (not completedq(340)))
collect Green Hills of Stranglethorn - Page 18##2742 |goto Ironforge 24.25,74.53 |q 341 |future |only if ((itemcount(2742) < 1) and (not completedq(341)))
collect Green Hills of Stranglethorn - Page 20##2744 |goto Ironforge 24.25,74.53 |q 341 |future |only if ((itemcount(2744) < 1) and (not completedq(341)))
collect Green Hills of Stranglethorn - Page 21##2745 |goto Ironforge 24.25,74.53 |q 341 |future |only if ((itemcount(2745) < 1) and (not completedq(341)))
collect Green Hills of Stranglethorn - Page 24##2748 |goto Ironforge 24.25,74.53 |q 341 |future |only if ((itemcount(2748) < 1) and (not completedq(341)))
collect Green Hills of Stranglethorn - Page 25##2749 |goto Ironforge 24.25,74.53 |q 342 |future |only if ((itemcount(2749) < 1) and (not completedq(342)))
collect Green Hills of Stranglethorn - Page 26##2750 |goto Ironforge 24.25,74.53 |q 342 |future |only if ((itemcount(2750) < 1) and (not completedq(342)))
collect Green Hills of Stranglethorn - Page 27##2751 |goto Ironforge 24.25,74.53 |q 342 |future |only if ((itemcount(2751) < 1) and (not completedq(342)))
step
Enter the building |goto Stranglethorn Vale 27.64,77.09 < 7 |walk
talk "Sea Wolf" MacKinley##2501
|tip Inside the building.
turnin Deliver to MacKinley##2874 |goto Stranglethorn Vale 27.78,77.07
step
Leave the building |goto 27.64,77.09 < 7 |walk
Enter the building |goto 27.08,77.62 < 7 |walk
talk Whiskey Slim##2491
|tip Inside the building.
turnin Whiskey Slim's Lost Grog##580 |goto 27.13,77.45
step
talk Crank Fizzlebub##2498
|tip Inside the building.
turnin Back to Booty Bay##1118 |goto 27.12,77.21
step
talk Innkeeper Skindle##6807
|tip Inside the building.
home Booty Bay |goto 27.04,77.31
step
talk Catelyn the Blade##2542
|tip Upstairs inside the building.
turnin Ansirem's Key##603 |goto 27.28,77.53
accept "Pretty Boy" Duncan##610 |goto 27.28,77.53
step
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
accept The Bloodsail Buccaneers##608 |goto 27.17,77.01
step
Enter the tunnel |goto 27.95,73.59 < 15 |only if walking
Leave the tunnel |goto 29.56,72.46 < 15 |only if walking
kill "Pretty Boy" Duncan##2545
collect Catelyn's Blade##4027 |q 610/1 |goto 27.38,69.41
step
Follow the path |goto 29.34,71.77 < 20 |only if walking
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
Follow the path |goto 32.25,81.77 < 40 |only if walking
Continue following the path |goto 32.75,73.39 < 30 |only if walking
Enter the tunnel |goto 29.54,72.52 < 15 |only if walking
Leave the tunnel |goto 27.96,73.66 < 15 |only if walking
Enter the building |goto 27.08,77.62 < 7 |walk
talk Catelyn the Blade##2542
|tip Upstairs inside the building.
turnin "Pretty Boy" Duncan##610 |goto 27.28,77.53
accept The Curse of the Tides##611 |goto 27.28,77.53
step
talk Fleet Master Seahorn##2487
|tip Upstairs, on the balcony of the building.
turnin The Bloodsail Buccaneers##608 |goto 27.17,77.01
step
Enter the tunnel |goto 27.95,73.59 < 15 |only if walking
Leave the tunnel |goto 29.56,72.46 < 15 |only if walking
Follow the road |goto 30.94,71.75 < 30 |only if walking
Continue following the road |goto 36.09,48.87 < 30 |only if walking
Follow the path |goto 38.45,40.55 < 30 |only if walking
kill Tethis##730
|tip He looks like a blue raptor that walks around this area.
collect Talon of Tethis##3877 |q 197/1 |goto 32.22,40.89
You can also find him around:
[31.17,43.40]
[28.74,44.84]
step
Kill enemies around this area
Reach Level 47 |ding 47 |goto 32.22,40.89
You can find more around: |notinsticky
[31.17,43.40]
[28.74,44.84]
step
Follow the path |goto 32.79,40.42 < 40 |only if walking
Follow the road |goto 39.85,38.58 < 30 |only if walking
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
talk Hemet Nesingwary##715
turnin Raptor Mastery##197 |goto 35.66,10.81
step
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
Follow the path |goto 32.64,13.10 < 30 |only if walking
click Altar of the Tides
|tip Underwater.
Watch the dialogue
kill Gazban##2624
collect Stone of the Tides##4034 |q 611/1 |goto 24.95,23.59
step
talk Baron Revilgaz##2496
|tip Upstairs on the balcony of the building.
turnin The Curse of the Tides##611 |goto 27.23,76.87
step
talk Auctioneer O'reely##15681
|tip Buy these items from the Auction House.
collect 15 Silk Cloth##4306 |goto 26.60,76.37 |q 4449 |future
step
Follow the road |goto Redridge Mountains 34.01,45.49 < 30 |only if walking
Follow the path |goto Redridge Mountains 45.17,19.25 < 30 |only if walking
Enter Burning Steppes |goto Burning Steppes 78.30,77.69 < 20 |only if walking
Follow the path |goto Burning Steppes 78.88,63.45 < 30 |only if walking
Follow the path up |goto Burning Steppes 82.85,63.33 < 15 |only if walking
talk Borgus Stoutarm##2299
fpath Morgan's Vigil |goto Burning Steppes 84.33,68.33
step
Follow the path |goto Loch Modan 40.44,54.48 < 30 |only if walking
Continue following the path |goto Loch Modan 46.94,78.05 < 30 |only if walking
Follow the path |goto Badlands 52.24,17.09 < 30 |only if walking
Continue following the path |goto Badlands 44.61,40.18 < 30 |only if walking
Follow the path up |goto Badlands 4.76,61.31 < 30 |only if walking
Continue following the path |goto Searing Gorge 68.22,53.86 < 30 |only if walking
Follow the path up |goto Searing Gorge 62.77,64.32 < 30 |only if walking
click Wooden Outhouse
accept Caught!##4449 |goto Searing Gorge 65.54,62.24
stickystart "Kill_Dark_Iron_Geologists"
step
talk Dorius Stonetender##8284
accept Suntara Stones##3367 |goto 63.92,60.98
step
Watch the dialoguue
|tip Follow Dorius Stonetender and protect him as he walks.
|tip He eventually walks to this location.
Escort Dorius |q 3367/1 |goto 74.55,19.48
step
click Singed Letter
turnin Suntara Stones##3367 |goto 74.45,19.29
accept Suntara Stones##3368 |goto 74.45,19.29
step
label "Kill_Dark_Iron_Geologists"
Follow the path |goto 70.05,42.36 < 20 |only if walking
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
Follow the path |goto 35.51,25.96 < 20 |only if walking
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
step
talk Lanie Reed##2941
fpath Thorium Point |goto 37.94,30.86
step
talk Curator Thorius##8256
|tip He walks around this area inside the building.
turnin Suntara Stones##3368 |goto Ironforge 72.01,15.53
accept Dwarven Justice##3371 |goto Ironforge 72.01,15.53
stickystart "Collect_Smithing_Tuyere"
stickystart "Collect_Grimesilt_Outhouse_Key"
stickystart "Collect_Golem_Oil"
stickystart "Collect_Hearts_Of_Flame"
stickystart "Kill_Greater_Lava_Spiders"
stickystart "Kill_Heavy_War_Golems"
stickystart "Kill_Dark_Iron_Taskmasters"
stickystart "Kill_Dark_Iron_Slavers"
step
Follow the path |goto Searing Gorge 33.46,49.81 < 30 |only if walking
kill Dark Iron Lookout##8566+
|tip They are around the watch towers on the clifff surrounding the huge pit.
collect Lookout's Spyglass##18960 |q 7728/2 |goto Searing Gorge 33.03,53.44
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
Follow the path down |goto 42.44,30.40 < 15 |walk
talk Dying Archaeologist##8417
|tip Inside the cave.
turnin Dwarven Justice##3371 |goto 41.14,25.57
step
Run up the ramp |goto 44.25,24.20 < 15 |c |q 3443
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
Reach Level 48 |ding 48 |goto 51.73,37.16
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
Follow the path up |goto 67.59,70.55 < 15 |only if walking
kill Margol the Rager##5833
|tip It looks like a blue dinosaur that walks on the path around this area.
|tip You may need help with this.
collect Margol's Horn##10000 |goto 72.25,73.63 |q 3181 |future
step
use Margol's Horn##10000
accept The Horn of the Beast##3181
step
Follow the path down |goto 68.27,71.24 < 20 |only if walking
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
Follow the path up |goto 48.37,59.93 < 15 |only if walking
Follow the path |goto 48.58,59.45 < 20 |only if walking
Follow the road |goto Loch Modan 29.07,61.48 < 20 |only if walking
talk Mountaineer Pebblebitty##3836
turnin The Horn of the Beast##3181 |goto Loch Modan 18.19,84.00
accept Proof of Deed##3182 |goto Loch Modan 18.19,84.00
step
Follow the road |goto 23.24,70.42 < 30 |only if walking
talk Curator Thorius##8256
|tip He walks around this area inside the building.
turnin Proof of Deed##3182 |goto Ironforge 72.01,15.53
accept At Last!##3201 |goto Ironforge 72.01,15.53
step
Follow the road |goto Loch Modan 29.07,61.48 < 20 |only if walking
talk Mountaineer Pebblebitty##3836
turnin At Last!##3201 |goto Loch Modan 18.19,84.00
step
Follow the road |goto 23.24,70.42 < 30 |only if walking
Enter the building |goto Ironforge 20.65,53.22 < 7 |walk
talk Innkeeper Firebrew##5111
|tip Inside the building.
home Ironforge |goto Ironforge 18.16,51.46
step
talk Innkeeper Firebrew##5111
|tip Inside the building.
accept Assisting Arch Druid Staghelm##3790 |goto Ironforge 18.16,51.46
step
Leave the building |goto 20.65,53.22 < 7 |walk
Follow the path |goto Blasted Lands 66.48,22.36 < 20 |only if walking
Follow the path |goto Blasted Lands 62.94,19.74 < 20 |only if walking
Follow the road |goto Blasted Lands 52.30,10.71 < 30 |only if walking
Continue following the road |goto Swamp of Sorrows 35.48,59.34 < 30 |only if walking
click A Soggy Scroll
|tip Underwater, under the bridge.
turnin Cortello's Riddle##624 |goto Swamp of Sorrows 22.86,48.19
accept Cortello's Riddle##625 |goto Swamp of Sorrows 22.86,48.19
step
Follow the road |goto 27.73,57.21 < 30 |only if walking
Avoid Stonard |goto 42.11,46.86 < 30 |only if walking
Follow the path |goto 59.28,60.80 < 30 |only if walking
Continue following the path |goto 74.89,74.66 < 30 |only if walking
kill Jarquia##9916
collect Goodsteel's Balanced Flameberge##11723 |q 4450/4 |goto 94.77,52.05
step
Leave the building |goto Ironforge 20.65,53.22 < 7 |walk
Enter the building |goto Ironforge 26.10,72.20 < 15 |walk
talk Auctioneer Redmuse##8720
|tip Inside the building.
|tip Buy these items from the Auction House.
collect 2 Elixir of Fortitude##3825 |goto Ironforge 24.25,74.55 |q 3842 |future
step
talk Laris Geardawdle##9616
|tip Inside the building.
accept A Little Slime Goes a Long Way##4512 |goto 75.77,23.37
step
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Favored of Elune?##3661 |goto Teldrassil 55.50,92.05
step
talk Daryn Lightwind##7907
|tip Upstairs inside the building.
turnin The Super Snapper FX##2944 |goto 55.41,92.23
accept Return to Troyas##2943 |goto 55.41,92.23
step
Follow the path |goto 56.79,92.64 < 20 |only if walking
talk Pratt McGrubben##7852
accept Improved Quality##7733 |goto Feralas 30.63,42.71
step
talk Innkeeper Shyria##7736
|tip Inside the building.
home Feathermoon Stronghold |goto 30.97,43.49
step
Enter the building |goto 31.84,45.02 < 15 |walk
talk Troyas Moonbreeze##7764
|tip Inside the building.
turnin Return to Troyas##2943 |goto 31.78,45.50
step
Watch the dialogue
talk Troyas Moonbreeze##7764
|tip Inside the building.
accept The Stave of Equinex##2879 |goto 31.78,45.50
step
talk Angelas Moonbreeze##7900
|tip Inside the building.
accept The Sunken Temple##3445 |goto 31.83,45.61
step
Run up the ramp |goto 30.92,43.21 < 15 |only if walking
Ride the boat or swim across the water |goto 31.03,39.92 < 20 |only if walking
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
Kill enemies around this area
use Zorbin's Ultra-Shrinker##18904
|tip Use it on Wave Striders around this area.
|tip They look like tall green giants that walks on the shore and in the water around this area.
Reach Level 49 |ding 49 |goto 46.73,60.23
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
collect Pristine Yeti Hide##18969 |goto 52.19,31.81 |q 7735 |future
|tip This has a low drop rate.
|tip You can also get this item by skinning enemies, if you have Skinning.
You can find more inside the cave at [53.17,31.82]
step
use the Pristine Yeti Hide##18969
accept Pristine Yeti Hide##7735
stickystart "Collect_Ironfur_Livers"
stickystart "Collect_Groddoc_Livers"
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
talk Rockbiter##7765
accept The Giant Guardian##2844 |goto 42.38,22.00
step
Follow the path |goto 39.96,15.89 < 30 |only if walking
click Flame of Byltan
collect Byltan Essence##9258 |goto 38.50,15.80 |q 2879
step
Follow the path up |goto 39.95,13.44 < 20 |only if walking
click Flame of Lahassa
collect Lahassa Essence##9255 |goto 37.76,12.17 |q 2879
step
click Flame of Imbel
collect Imbel Essence##9256 |goto 39.93,9.44 |q 2879
step
Jump up on the ledge |goto 40.33,11.04 < 7 |only if walking
Jump across here |goto 40.59,11.45 < 7 |only if walking
Jump up here |goto 40.97,11.87 < 7 |only if walking
click Flame of Samha
collect Samha Essence##9257 |goto 40.54,12.65 |q 2879
step
use Troyas' Stave##9263
collect Stave of Equinex##9306 |q 2879/1 |goto 38.87,13.23
step
click Equinex Monolith
turnin The Stave of Equinex##2879 |goto 38.87,13.23
accept The Morrow Stone##2942 |goto 38.87,13.23
step
Follow the path up |goto 39.94,13.34 < 20 |only if walking
Follow the path up |goto 37.58,11.17 < 15 |only if walking
talk Shay Leafrunner##7774
turnin The Giant Guardian##2844 |goto 38.22,10.30
accept Wandering Shay##2845 |goto 38.22,10.30
step
click Shay's Chest
collect Shay's Bell##9189 |q 2845/2 |goto 38.25,10.29
step
use Shay's Bell##9189
|tip Shay Leafrunner will follow you.
|tip Protect her as you walk.
|tip She will sometimes wander off and stop following you.
|tip You will see a message in your chat when she wanders off.
|tip When this happens, use Shay's Bell to get her to start following you again.
|tip This quest is timed, so try to hurry.
Take Shay Leafrunner to Rockbiter's Camp |q 2845/1 |goto 42.38,22.00
step
talk Rockbiter##7765
accept Wandering Shay##2845 |goto 42.38,22.00
step
label "Collect_Ironfur_Livers"
kill Ironfur Patriarch##5274+
collect 3 Ironfur Liver##6258 |q 1452/2 |goto 41.10,17.03
You can find more around: |notinsticky
[46.54,24.78]
[44.38,11.94]
step
label "Collect_Groddoc_Livers"
Kill Groddoc enemies around this area
|tip They look like gorillas.
collect 3 Groddoc Liver##6259 |q 1452/3 |goto 41.10,17.03
You can find more around: |notinsticky
[46.54,24.78]
[44.38,11.94]
step
Follow the road |goto 48.13,24.68 < 30 |only if walking
Continue following the road |goto 48.41,33.30 < 30 |only if walking
Follow the path down |goto 47.53,37.63 < 20 |only if walking
talk Zorbin Fandazzle##14637
turnin Again With the Zapped Giants##7725 |goto 44.81,43.42
step
Follow the path up |goto 47.08,44.48 < 20 |only if walking
Follow the road |goto 48.76,45.20 < 30 |only if walking
Follow the path |goto 55.14,53.35 < 30 |only if walking
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
Follow the path up |goto 47.08,44.48 < 20 |only if walking
Follow the road |goto 48.76,45.20 < 30 |only if walking
Continue following the road |goto 62.95,53.63 < 30 |only if walking
Follow the path down |goto 64.37,50.01 < 15 |only if walking
Follow the path up |goto 65.66,46.77 < 10 |only if walking
Follow the path down |goto 65.81,46.10 < 10 |only if walking
talk Kindal Moonweaver##7956
accept An Orphan Looking For a Home##3841 |goto 65.94,45.65
step
Follow the road |goto 69.32,49.45 < 20 |only if walking
Follow the path |goto 59.29,53.77 < 30 |only if walking
Follow the path up |goto 53.95,68.44 < 30 |only if walking
Follow the path up |goto 57.33,75.52 < 15 |only if walking
click Hippogryph Egg
collect Hippogryph Egg##8564 |goto 56.66,75.90 |q 2741 |future
|tip You will use this for a future quest.
|tip Be careful not to accidentally sell this to a vendor.
step
Enter the building |goto 31.84,45.03 < 15 |walk
talk Troyas Moonbreeze##7764
|tip Inside the building.
turnin The Morrow Stone##2942 |goto 31.78,45.50
step
talk Pratt McGrubben##7852
turnin Improved Quality##7733 |goto 30.63,42.71
turnin Pristine Yeti Hide##7735 |goto 30.63,42.71
step
Follow the road |goto Dustwallow Marsh 65.29,50.51 < 20 |only if walking
Run up the ramp and jump over the wall |goto Dustwallow Marsh 63.68,48.00 < 15 |only if walking
Follow the path up |goto Dustwallow Marsh 55.70,50.14 < 20 |only if walking
click Damaged Crate
collect Overdue Package##11724 |q 4450/3 |goto Dustwallow Marsh 54.07,55.90
step
Follow the path |goto 35.30,64.41 < 30 |only if walking
Enter the cave |goto 31.71,65.74 < 15 |walk
click Musty Scroll
|tip Inside the cave.
turnin Cortello's Riddle##624 |goto 31.10,66.15
accept Cortello's Riddle##625 |goto 31.10,66.15
step
Leave the cave |goto 51.96,88.01 < 15 |walk
Follow the path up |goto 53.91,51.46 < 20 |only if walking
Leave the water |goto 80,55.33 < 20 |only if walking
Follow the path |goto 68.10,52.55 < 30 |only if walking
Follow the path |goto Tanaris 51.01,28.63 < 15 |only if walking
talk Senior Surveyor Fizzledowser##7724
accept Noxious Lair Investigation##82 |goto 50.21,27.48
step
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
talk Marin Noggenfogger##7564
accept The Thirsty Goblin##2605 |goto 51.81,28.66
step
talk Krinkle Goodsteel##5411
turnin Ledger from Tanaris##4450 |goto 51.47,28.81
step
Follow the path |goto 51.55,29.03 < 15 |only if walking
Kill Roc enemies around this area
|tip They look like red birds.
collect 3 Roc Gizzard##6257 |q 1452/1 |goto 49.47,35.83
You can find more around [44.14,40.87]
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
Reach Level 50 |ding 50 |goto 29.97,66.48
You can find more around: |notinsticky
[28.18,64.79]
[30.54,64.66]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (50-55)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
next="Leveling Guides\\Leveling (55-60)",
startlevel=50,
endlevel=55,
},[[
step
talk Tooga
|tip He looks like a turtle.
accept Tooga's Quest##1560 |goto Tanaris 28.5,63.1
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
Follow the path |goto 61.92,26.28 < 40 |only if walking
Continue following the path |goto 57.31,29.14 < 40 |only if walking
Continue following the path |goto 53.90,29.76 < 40 |only if walking
Follow the path |goto 51.55,29.03 < 15 |only if walking
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
step
Follow the path |goto 51.55,29.03 < 15 |only if walking
talk Marvon Rivetseeker##7771
turnin Gahz'ridian##3161 |goto 52.71,45.93
step
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
accept Rise of the Silithid##162 |goto 50.21,27.48
step
talk Shreev##4708
accept Safety First##1189 |goto 50.96,27.24
step
Follow the path |goto 51.26,26.49 < 15 |only if walking
Follow the path up |goto 50.68,24.34 < 20 |only if walking
Follow the path down |goto 51.47,22.25 < 20 |only if walking
talk Razzeric##4706
turnin Safety First##1188 |goto Thousand Needles 80.33,76.09
step
talk Quentin##9238
turnin An Orphan Looking For a Home##3841 |goto 78.35,74.73
accept A Short Incubation##3842 |goto 78.35,74.73
step
talk Quentin##9238
turnin A Short Incubation##3842 |goto 78.35,74.73
accept The Newest Member of the Family##3843 |goto 78.35,74.73
step
Follow the path up |goto 74.16,93.07 < 20 |only if walking
Follow the path down |goto Tanaris 51.49,22.25 < 20 |only if walking
Follow the path |goto Tanaris 51.26,26.49 < 15 |only if walking
Follow the path |goto Tanaris 51.01,28.62 < 15 |only if walking
Enter the building |goto The Hinterlands 14.18,45.20 < 20 |only if walking
talk Agnar Beastamer##9660
|tip Downstairs inside the building.
turnin The Newest Member of the Family##3843 |goto The Hinterlands 14.15,43.62
accept Food for Baby##4297 |goto The Hinterlands 14.15,43.62
step
talk Innkeeper Thulfram##7744
|tip He walks around upstairs inside the building.
home Wildhammer Keep |goto 14.15,41.57
step
Leave the building |goto 14.20,45.23 < 20 |walk
Follow the path up |goto 20.81,47.82 < 20 |only if walking
talk Rhapsody Shindigger##5634
turnin Rhapsody's Kalimdor Kocktail##1452 |goto 26.94,48.59
step
click Violet Tragan+
|tip They look like large brown and white mushrooms underwater around this area.
collect Violet Tragan##8526 |q 2641/1 |goto 41.01,59.77
step
Run up the stairs |goto 47.75,66.74 < 20 |only if walking
Search the Altar of Zul |q 2989/1 |goto 48.85,68.45
|tip There are elite enemies at the top of the temple.
|tip Complete the quest goal and immediately run away to safety.
step
kill Silvermane Stalker##2926+
|tip They can be stealthed around this area.
collect 5 Silvermane Stalker Flank##11472 |q 4297/1 |goto 52.34,55.03
You can find more around: |notinsticky
[57.86,47.38]
[59.34,53.32]
[64.32,48.73]
[69.00,50.89]
step
Jump down into the water here |goto 80.81,46.97 < 20 |only if walking
click Cortello's Treasure
|tip Underwater.
turnin Cortello's Riddle##626 |goto 80.81,46.81
step
talk Agnar Beastamer##9660
|tip Downstairs inside the building.
turnin Food for Baby##4297 |goto 14.15,43.62
accept Becoming a Parent##4298 |goto 14.15,43.62
step
talk Agnar Beastamer##9660
|tip Downstairs inside the building.
turnin Becoming a Parent##4298 |goto 14.15,43.62
step
Leave the building |goto 14.20,45.24 < 20 |walk
Follow the path up |goto 12.85,48.25 < 20 |only if walking
Enter the building at the top of the path |goto 11.00,45.67 < 10 |walk
talk Gryphon Master Talonaxe##5636
|tip Inside the building.
turnin The Altar of Zul##2989 |goto 9.76,44.48
accept Thadius Grimshade##2990 |goto 9.76,44.48
step
Leave the building |goto 10.99,45.65 < 10 |walk
Follow the road |goto Dustwallow Marsh 67.00,48.00 < 30 |only if walking
Enter the building |goto Dustwallow Marsh 65.99,45.20 < 10 |walk
talk Innkeeper Janene##6272
|tip Inside the building.
home Theramore Isle |goto Dustwallow Marsh 66.59,45.22
step
Leave the building |goto 58.44,66.91 < 10 |walk
Follow the road |goto 58.59,67.31 < 30 |only if walking
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
Enter the building |goto Blasted Lands 66.40,18.98 < 10 |walk
talk Ambassador Ardalan##7826
|tip Upstairs inside the building, at the top.
accept Petty Squabbles##2783 |goto Blasted Lands 67.56,19.29
step
talk Thadius Grimshade##8022
|tip Upstairs inside the building, at the top.
turnin Thadius Grimshade##2990 |goto 66.90,19.47
step
Leave the building |goto 66.38,19.00 < 7 |walk
Follow the path |goto 62.64,19.85 < 20 |only if walking
Follow the road |goto 52.30,10.72 < 30 |only if walking
talk Fallen Hero of the Horde##7572
turnin Petty Squabbles##2783 |goto Swamp of Sorrows 34.29,66.13
accept A Tale of Sorrow##2801 |goto Swamp of Sorrows 34.29,66.13
step
talk Fallen Hero of the Horde##7572
Tell him _"Please continue, Hero..."_
Listen to a Tale of Sorrow |q 2801/1 |goto 34.29,66.13
step
talk Fallen Hero of the Horde##7572
turnin A Tale of Sorrow##2801 |goto 34.29,66.13
step
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
Kill enemies around this area
Reach Level 51 |ding 51 |goto 48.50,19.78
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
Follow the road |goto 52.10,14.05 < 20 |only if walking
Follow the path |goto 53.21,11.78 < 20 |only if walking
Follow the path |goto 62.61,19.80 < 20 |only if walking
Continue following the path |goto 65.68,20.33 < 30 |only if walking
Enter the building |goto Stormwind City 54.07,59.00 < 10 |walk
talk Auctioneer Jaxon##15659
|tip Inside the building.
|tip Inside the building.
|tip Buy it from the Auction House.
collect Mithril Casing##10561 |goto Stormwind City 53.60,59.76 |q 4244 |future
step
Cross the bridge |goto Darnassus 38.54,48.02 < 20 |only if walking
Enter the building |goto Darnassus 39.04,76.77 < 15 |walk
Run up the ramp |goto Darnassus 40.48,91.67 < 10 |walk
talk Gracina Spiritmight##7740
|tip Upstairs inside the building.
accept March of the Silithid##4493 |goto Darnassus 41.84,85.62
step
Leave the building |goto Dustwallow Marsh 65.99,45.20 < 10 |walk
Follow the road |goto Dustwallow Marsh 66.88,47.57 < 30 |only if walking
Follow the path |goto Tanaris 51.01,28.63 < 15 |only if walking
talk Sprinkle##7583
turnin Sprinkle's Secret Ingredient##2641 |goto Tanaris 51.06,26.87
step
Watch the dialogue
talk Sprinkle##7583
accept Delivery for Marin##2661 |goto 51.06,26.87
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin March of the Silithid##4493 |goto 50.89,26.96
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
talk Muigin##9119
accept Muigin and Larion##4141 |goto 42.94,9.64
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
stickystart "Collect_Power_Crystals"
stickystart "Collect_UnGoro_Soil"
stickystart "Collect_A_Mangled_Journal"
stickystart "Collect_Webbed_Pterrordax_Scales"
stickystart "Collect_Bloodpetals"
stickystart "Collect_Savage_Fronds"
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
stickystop "Collect_Savage_Fronds"
stickystop "Collect_Bloodpetals"
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
stickystart "Collect_Bloodpetals"
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
step
Kill enemies around this area
Reach Level 52 |ding 52 |goto 47.05,17.27
step
click Crate of Foodstuffs
collect Crate of Foodstuffs##11113 |q 3881/1 |goto 68.51,36.54
step
talk Torwa Pathfinder##9619
turnin The Apes of Un'Goro##4289 |goto 71.64,75.97
turnin The Fare of Lar'korwi##4290 |goto 71.64,75.97
accept The Scent of Lar'korwi##4291 |goto 71.64,75.97
accept The Mighty U'cha##4301 |goto 71.64,75.97
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
stickystart "Kill_Frenzied_Pterrordax"
step
Follow the path up |goto 49.20,84.45 < 10 |walk
Continue up the path |goto 49.64,82.55 < 10 |walk
Leave the cave |goto 49.94,81.65 < 10 |walk
click Research Equipment
collect Research Equipment##11112 |q 3881/2 |goto 38.47,66.11
step
talk Krakle##10302
accept Finding the Source##974 |goto 30.93,50.43
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
label "Collect_Bloodpetals"
Kill Bloodpetal enemies around this area
|tip They look like walking plants.
collect 15 Bloodpetal##11316 |q 4141/1 |goto 71.46,38.72
You can find more around: |notinsticky
[69.26,24.59]
[66.08,35.13]
[55.87,34.69]
[41.91,27.10]
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
collect 25 Un'Goro Soil##11018 |q 3764 |future
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
talk Muigin##9119
turnin Muigin and Larion##4141 |goto 42.94,9.64
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
use A Small Pack##11107
|tip You can destroy the Faded Photograph inside the pack.
|tip It's not used for anything.
collect Large Compass##11104 |q 3845/1
collect Curled Map Parchment##11105 |q 3845/2
collect Lion-headed Key##11106 |q 3845/3
step
Follow the path |goto 40.98,3.26 < 15 |walk
Continue following the path |goto 41.87,5.00 < 10 |walk
Continue following the path |goto 43.29,4.65 < 10 |walk
Leave the cave |goto 43.47,6.81 < 15 |walk
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
Reach Level 53 |ding 53 |goto 47.05,17.27
step
Follow the path up |goto 45.99,13.46 < 15 |only if walking
Follow the path |goto Tanaris 51.01,28.63 < 15 |only if walking
talk Tran'rek##7876
turnin Super Sticky##4504 |goto Tanaris 51.57,26.76
step
talk Alchemist Pestlezugg##5594
|tip Inside the building.
turnin Bungle in the Jungle##4496 |goto 50.89,26.96
step
talk Erelas Ambersky##7916
|tip Inside the building.
accept Moontouched Wildkin##978 |goto Teldrassil 55.50,92.05
step
map Darnassus
path	follow loose;	loop;	ants curved
path	36.00,41.30		38.50,47.91		40.25,73.62		49.94,80.49
path	54.88,74.47		57.42,82.41		67.68,57.45		62.02,52.75
path	61.79,40.59		43.80,41.10		36.79,14.21
talk Herald Moonstalker##10878
|tip She looks like a night elf that walks in a clockwise path around Darnassus.
|tip This step's path will take you counter-clockwise to help you find her faster.
accept A Call to Arms: The Plaguelands!##5091
step
Enter the building |goto Darnassus 35.53,10.74 < 10 |walk
talk Arch Druid Fandral Staghelm##3516
|tip At the top of the tower.
turnin Assisting Arch Druid Staghelm##3763 |goto Darnassus 34.80,9.25
accept Un'Goro Soil##3764 |goto Darnassus 34.80,9.25
step
Leave the building |goto 33.90,7.74 < 7 |walk
talk Jenal##9047
turnin Un'Goro Soil##3764 |goto 31.49,8.23
step
Enter the building |goto Darnassus 35.53,10.74 < 10 |walk
talk Arch Druid Fandral Staghelm##3516
|tip At the top of the tower.
accept Morrowgrain Research##3781 |goto 34.80,9.25
step
talk Mathrengyl Bearwalker##4217
|tip Inside the tower, on the middle level.
turnin Morrowgrain Research##3781 |goto 35.37,8.40
step
Leave the building |goto 35.55,10.74 < 7 |walk
Cross the bridge |goto 38.54,48.02 < 20 |only if walking
Enter the building |goto 39.04,76.77 < 15 |walk
Run up the ramp |goto 40.48,91.67 < 10 |walk
talk Gracina Spiritmight##7740
|tip Upstairs inside the building.
turnin Rise of the Silithid##162 |goto 41.84,85.62
step
Leave the building |goto 39.04,76.77 < 15 |walk
Run up the ramp |goto Ashenvale 36.78,49.76 < 10 |only if walking
talk Innkeeper Kimlya##6738
|tip Inside the building.
home Astranaar |goto Ashenvale 36.99,49.22
step
Follow the road |goto Azshara 16.05,75.48 < 30 |only if walking
Continue following the road |goto Azshara 31.23,57.55 < 30 |only if walking
Follow the path |goto Azshara 33.81,54.50 < 20 |only if walking
click Rune of Beth'Amara
collect Rubbing: Rune of Beth'Amara##10563 |q 3449/1 |goto Azshara 36.87,53.19
step
click Rune of Markri
collect Rubbing: Rune of Markri##10565 |q 3449/3 |goto 39.30,55.48
step
Follow the path |goto 39.07,60.03 < 30 |only if walking
click Rune of Sael'hai
collect Rubbing: Rune of Sael'hai##10566 |q 3449/4 |goto 42.34,64.13
step
Follow the path |goto 39.07,60.03 < 30 |only if walking
click Rune of Jin'yael
collect Rubbing: Rune of Jin'yael##10564 |q 3449/2 |goto 39.56,50.31
step
Follow the path down |goto 40.40,47.79 < 20 |only if walking
Follow the path |goto 42.56,48.20 < 30 |only if walking
Follow the path up |goto 46.89,41.50 < 20 |only if walking
Follow the path |goto 44.95,36.18 < 30 |only if walking
Follow the path up |goto 53.02,19.64 < 20 |only if walking
talk Kim'jael##8420
accept Kim'jael Indeed!##3601 |goto 53.45,21.82
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
Follow the path up |goto 46.89,41.50 < 20 |only if walking
Follow the path |goto 44.95,36.18 < 30 |only if walking
Follow the path up |goto 53.02,19.64 < 20 |only if walking
talk Kim'jael##8420
turnin Kim'jael's "Missing" Equipment##5534 |goto 53.45,21.82
step
Follow the path |goto 46.11,31.60 < 40 |only if walking
Follow the path down |goto 45.27,37.09 < 20 |only if walking
Follow the path |goto 48.76,65.18 < 50 |only if walking
Follow the water |goto 66.79,73.70 < 30 |only if walking
Continue following the water |goto 76.57,82.00 < 30 |only if walking
use the Standard Issue Flare Gun##10444
|tip Use it on the wooden platform.
talk Pilot Xiggs Fuselighter##8392
|tip He appears at this location.
turnin Arcane Runes##3449 |goto 77.79,91.46
accept Return to Tymor##3461 |goto 77.79,91.46
step
Follow the road |goto Ashenvale 38.30,57.67 < 30 |only if walking
Continue following the road |goto Ashenvale 59.86,62.19 < 30 |only if walking
Continue following the road |goto Ashenvale 55.82,31.72 < 30 |only if walking
talk Arathandris Silversky##9528
accept Cleansing Felwood##4101 |goto Felwood 54.15,86.83
step
Follow the path up |goto 51.11,84.04 < 30 |only if walking
talk Greta Mosshoof##10922
accept Forces of Jaedenar##5155 |goto 51.21,82.11
step
Enter the building |goto 51.27,81.69 < 10 |walk
talk Eridan Bluewind##9116
|tip Inside the building.
accept The Corruption of the Jadefire##4421 |goto 51.35,81.51
step
Leave the building |goto 51.27,81.69 < 7 |walk
talk Ivy Leafrunner##10924
|tip Inside the building.
accept To Winterspring!##5249 |goto 50.96,81.58
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
talk Grazle##11554
accept Timbermaw Ally##6131 |goto 50.93,85.01
stickystart "Kill_Deadwood_Warriors"
stickystart "Kill_Deadwood_Pathfinders"
stickystart "Kill_Deadwood_Gardeners"
step
Follow the path |goto 49.02,89.29 < 30 |only if walking
kill Overlord Ror##9464
collect Overlord Ror's Claw##15879 |q 6162/1 |goto 48.23,94.27
step
label "Kill_Deadwood_Warriors"
kill 5 Deadwood Warrior##7153 |q 6131/1 |goto 48.32,92.99
You can find more around: |notinsticky
[46.51,88.13]
[48.77,89.62]
step
label "Kill_Deadwood_Pathfinders"
kill 5 Deadwood Pathfinder##7155 |q 6131/2 |goto 48.32,92.99
You can find more around: |notinsticky
[46.51,88.13]
[48.77,89.62]
step
label "Kill_Deadwood_Gardeners"
kill 5 Deadwood Gardener##7154 |q 6131/3 |goto 48.32,92.99
You can find more around: |notinsticky
[46.51,88.13]
[48.77,89.62]
step
Follow the path |goto 49.56,88.70 < 30 |only if walking
talk Grazle##11554
turnin Timbermaw Ally##6131 |goto 50.93,85.02
accept Speak to Nafien##8462 |goto 50.93,85.02
step
use the Package of Empty Ooze Containers##11912
collect 6 Empty Cursed Ooze Jar##11914 |q 4512
collect 6 Empty Tainted Ooze Jar##11948 |q 4512
step
Follow the road |goto 47.46,83.68 < 30 |only if walking
Follow the path |goto 42.09,72.25 < 20 |only if walking
kill Cursed Ooze##7086+
use the Empty Cursed Ooze Jar##11914+
|tip Use them on their corpses.
collect 6 Empty Tainted Ooze Jar##11948 |goto 41.22,71.29 |q 4512/1
You can find more around: |notinsticky
[38.97,72.26]
[40.06,67.15]
[41.93,67.38]
step
Follow the path up |goto 39.63,69.93 < 30 |only if walking
Continue following the path |goto 36.85,66.92 < 20 |only if walking
kill Xavathras##9454 |q 4421/4 |goto 32.24,67.10
step
label "Kill_Jadefire_Felsworns"
kill 11 Jadefire Felsworn##7109 |q 4421/1 |goto 32.90,66.62
You can find more around: |notinsticky
[37.36,67.64]
step
label "Kill_Jadefire_Shadowstalkers"
kill 9 Jadefire Shadowstalker##7110 |q 4421/2 |goto 32.90,66.62
|tip They are stealthed around this area.
You can find more around: |notinsticky
[37.36,67.64]
step
label "Kill_Jadefire_Rogues"
kill 9 Jadefire Rogue##7106 |q 4421/3 |goto 32.90,66.62
You can find more around: |notinsticky
[37.36,67.64]
step
Follow the road |goto 42.64,65.46 < 30 |only if walking
kill Tainted Ooze##7092+
use the Empty Tainted Ooze Jar##11948+
|tip Use them on their corpses.
collect 6 Empty Tainted Ooze Jar##11948 |goto 40.76,59.25 |q 4512/2
You can find more around [40.28,55.59]
stickystart "Kill_Jaedenar_Guardians"
stickystart "Kill_Jaedenar_Adepts"
stickystart "Kill_Jaedenar_Cultists"
step
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
Follow the road |goto 41.37,57.71 < 30 |only if walking
Follow the path |goto 50.17,83.68 < 30 |only if walking
talk Greta Mosshoof##10922
turnin Forces of Jaedenar##5155 |goto 51.21,82.11
accept Collection of the Corrupt Water##5157 |goto 51.21,82.11
step
Enter the building |goto 51.27,81.69 < 10 |walk
talk Eridan Bluewind##9116
|tip Inside the building.
turnin The Corruption of the Jadefire##4421 |goto 51.35,81.51
accept Further Corruption##4906 |goto 51.35,81.51
step
Leave the building |goto 51.27,81.69 < 10 |walk
Follow the path |goto 50.88,86.63 < 30 |only if walking
Kill enemies around this area
Reach Level 54 |ding 54 |goto 48.32,92.99
You can find more around: |notinsticky
[46.51,88.13]
[48.77,89.62]
step
Follow the path |goto 49.56,88.70 < 30 |only if walking
Follow the road |goto 51.08,84.64 < 30 |only if walking
Follow the path |goto 41.24,57.61 < 30 |only if walking
Continue following the path |goto 38.38,59.66 < 20 |only if walking
use the Empty Canteen##12922
collect Corrupt Moonwell Water##12907 |q 5157/1 |goto 35.20,59.87
step
Follow the path |goto 36.73,61.25 < 30 |only if walking
Continue following the path |goto 39.24,58.27 < 30 |only if walking
Follow the road |goto 41.37,57.71 < 30 |only if walking
Follow the path |goto 50.17,83.68 < 30 |only if walking
talk Greta Mosshoof##10922
turnin Collection of the Corrupt Water##5157 |goto 51.21,82.11
accept Seeking Spiritual Aid##5158 |goto 51.21,82.11
step
Follow the road |goto 49.96,83.91 < 30 |only if walking
Follow the path |goto 39.96,45.01 < 30 |only if walking
Explore the Craters in Shatter Scar Vale |q 5156/1 |goto 41.54,42.98
step
label "Kill_Entropic_Beasts"
kill 2 Entropic Beast##9878 |q 5156/2 |goto 41.36,41.19
|tip Be careful to avoid the elite Infernal Sentries around this area.
step
label "Kill_Entropic_Horrors"
kill 2 Entropic Horror##9879 |q 5156/3 |goto 41.36,41.19
|tip Be careful to avoid the elite Infernal Sentries around this area.
stickystart "Kill_Jadefire_Hellcallers"
stickystart "Kill_Jadefire_Betrayers"
stickystart "Kill_Jadefire_Tricksters"
step
Follow the road |goto 39.00,42.37 < 30 |only if walking
Follow the path up |goto 43.18,21.55 < 30 |only if walking
Follow the path |goto 39.79,20.32 < 20 |only if walking
kill Xavaric##10648 |q 4906/4 |goto 39.07,22.35
collect Flute of Xavaric##11668 |goto 39.07,22.35 |q 939 |future
step
use the Flute of Xavaric##11668
accept Flute of Xavaric##939
step
Kill Jadefire enemies around this area
collect 5 Jadefire Felbind##11674 |q 939/1 |goto 40.73,19.72
You can find more around: |notinsticky
[42.87,15.21]
[39.10,21.69]
step
label "Kill_Jadefire_Hellcallers"
kill 8 Jadefire Hellcaller##7111 |q 4906/1 |goto 40.73,19.72
You can find more around: |notinsticky
[42.87,15.21]
[39.10,21.69]
step
label "Kill_Jadefire_Betrayers"
kill 8 Jadefire Betrayer##7108 |q 4906/2 |goto 40.73,19.72
You can find more around: |notinsticky
[42.87,15.21]
step
label "Kill_Jadefire_Tricksters"
kill 8 Jadefire Trickster##7107 |q 4906/3 |goto 40.73,19.72
You can find more around: |notinsticky
[42.87,15.21]
step
Follow the path down |goto 42.53,19.96 < 30 |only if walking
Follow the road |goto 43.99,22.97 < 30 |only if walking
Kill Warpwood enemies around this area
collect 15 Blood Amber##11503 |q 4101/1 |goto 54.83,16.51
You can find more inside the cave at [55.76,16.86]
step
Follow the road |goto 53.87,12.76 < 30 |only if walking
Follow the path |goto 61.80,16.20 < 30 |only if walking
Continue following the path |goto 62.98,23.00 < 30 |only if walking
talk Mishellena##12578
fpath Talonbranch Glade |goto 62.49,24.24
step
Follow the road |goto 64.61,14.86 < 30 |only if walking
talk Nafien##15395
turnin Speak to Nafien##8462 |goto 64.77,8.13
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
talk Sindrayl##10897
fpath Moonglade |goto Moonglade 48.10,67.34
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
click Moontouched Feather+
|tip They look like large blue feathers on the ground around this area.
collect 10 Moontouched Feather##12383 |q 978/1 |goto 31.35,45.53
You can find more at:
[30.95,47.02]
[29.39,46.67]
[30.18,45.24]
[30.30,44.03]
[31.42,43.31]
[32.02,44.25]
[32.79,44.36]
[33.07,44.01]
[34.85,43.20]
step
Follow the road |goto 35.95,42.15 < 30 |only if walking
Continue following the road |goto 53.67,34.46 < 30 |only if walking
Follow the path |goto 59.20,38.75 < 30 |only if walking
Follow the path |goto 60.55,38.20 < 15 |only if walking
talk Harlo Wigglesworth##11755
accept Enraged Wildkin##6604 |goto 61.12,38.43
step
Follow the path |goto 60.56,38.20 < 15 |only if walking
Follow the road |goto 58.75,38.42 < 30 |only if walking
Continue following the road |goto 53.78,33.31 < 30 |only if walking
Follow the path up |goto 53.48,28.64 < 30 |only if walking
Enter the building |goto 51.39,29.82 < 15 |only if walking
talk Wynd Nightchaser##11079
|tip Inside the building.
turnin To Winterspring!##5249 |goto 51.97,30.39
accept The Ruins of Kel'Theril##5244 |goto 51.97,30.39
step
talk Jaron Stoneshaper##10301
|tip Inside the building.
turnin The Ruins of Kel'Theril##5244 |goto 52.14,30.43
turnin Enraged Wildkin##6604 |goto 52.14,30.43
step
Follow the road |goto 54.28,34.54 < 30 |only if walking
Follow the path |goto 61.75,40.10 < 30 |only if walking
talk Maethrya##11138
fpath Everlook |goto 62.33,36.61
step
Enter the building |goto The Barrens 62.52,38.58 < 10 |walk
talk Liv Rizzlefix##8496
|tip Inside the building.
turnin Volcanic Activity##4502 |goto The Barrens 62.45,38.74
step
Leave the building |goto 62.52,38.58 < 10 |walk
talk Islen Waterseer##5901
turnin Seeking Spiritual Aid##5158 |goto 57.38,57.66
step
Watch the dialogue
talk Islen Waterseer##5901
accept Cleansed Water Returns to Felwood##5159 |goto 57.39,57.66
step
Follow the road |goto Ashenvale 38.30,57.67 < 30 |only if walking
Continue following the road |goto Ashenvale 59.86,62.19 < 30 |only if walking
Continue following the road |goto Ashenvale 55.82,31.72 < 30 |only if walking
talk Arathandris Silversky##9528
turnin Cleansing Felwood##4101 |goto Felwood 54.15,86.83
step
talk Arathandris Silversky##9528
Tell her _"Please make me a Cenarion Beacon"_
collect Cenarion Beacon##11511 |goto 54.15,86.83 |q 4103 |future
step
Follow the path up |goto 51.11,84.04 < 30 |only if walking
talk Greta Mosshoof##10922
turnin Cleansed Water Returns to Felwood##5159 |goto 51.21,82.11
accept Dousing the Flames of Protection##5165 |goto 51.21,82.11
step
Enter the building |goto 51.26,81.70 < 10 |walk
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Flute of Xavaric##939 |goto 51.35,81.51
accept Felbound Ancients##4441 |goto 51.35,81.51
turnin Further Corruption##4906 |goto 51.35,81.51
step
Leave the building |goto 51.26,81.70 < 7 |walk
talk Taronn Redfeather##10921
|tip Inside the building.
turnin Verifying the Corruption##5156 |goto 50.89,81.62
stickystart "Collect_Corrupted_Soul_Shards"
step
Follow the road |goto 50.03,83.91 < 30 |only if walking
Follow the path |goto 41.19,57.60 < 30 |only if walking
Continue following the path |goto 38.33,59.87 < 20 |only if walking
Enter the cave |goto 35.41,58.68 < 15 |walk
Follow the path down |goto 36.00,56.50 < 10 |walk
click Brazier of Pain
|tip Inside the cave.
Extinguish the Brazier of Pain |q 5165/1 |goto 36.25,56.27
step
Follow the path up |goto 36.70,55.74 < 10 |walk
click Brazier of Hatred
|tip Inside the cave.
Extinguish the Brazier of Hatred |q 5165/4 |goto 36.49,55.20
step
Follow the path |goto 36.80,54.89 < 10 |walk
Run around the hole in the floor and follow the path down |goto 38.20,54.07 < 10 |c |q 5165
step
Follow the path |goto 37.59,53.98 < 10 |walk
click Brazier of Suffering
|tip Inside the cave.
Extinguish the Brazier of Suffering |q 5165/3 |goto 36.74,53.29
step
click Brazier of Malice
|tip Inside the cave.
Extinguish the Brazier of Malice |q 5165/2 |goto 37.67,52.69
step
Follow the path |goto 37.18,53.99 < 10 |walk
Follow the path up |goto 38.13,54.62 < 10 |c |q 5165
step
Run around the hole in the ground and continue up the path |goto 37.54,54.75 < 10 |walk
Follow the path down |goto 36.58,55.19 < 10 |walk
Follow the path up |goto 35.89,55.98 < 10 |walk
Continue up the path |goto 35.45,58.11 < 10 |walk
Leave the cave |goto 35.42,58.83 < 7 |c |q 5165
step
label "Collect_Corrupted_Soul_Shards"
Kill enemies around this area
collect 6 Corrupted Soul Shard##11515 |goto 35.33,60.66 |q 4103 |future
You can find more around [38.15,60.35]
step
Follow the path |goto 39.23,58.28 < 30 |only if walking
Follow the road |goto 41.38,57.67 < 30 |only if walking
Follow the path |goto 50.27,83.54 < 30 |only if walking
talk Greta Mosshoof##10922
turnin Dousing the Flames of Protection##5165 |goto 51.21,82.11
step
talk Arathandris Silversky##9528
accept Salve via Hunting##4103 |goto 54.15,86.83
step
Follow the path |goto 50.98,87.04 < 30 |only if walking
Kill enemies around this area
Reach Level 55 |ding 55 |goto 48.64,89.58
You can find more around: |notinsticky
[46.18,88.16]
[48.21,93.53]
]])
ZygorGuidesViewer:RegisterGuide("Leveling Guides\\Leveling (55-60)",{
author="support@zygorguides.com",
image=ZGV.DIR.."\\Guides\\Images\\Elwynn Forest",
startlevel=55,
endlevel=60,
},[[
step
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Moontouched Wildkin##978 |goto Teldrassil 55.50,92.04
accept Find Ranshalla##979 |goto Teldrassil 55.50,92.04
step
Cross the bridge |goto Darnassus 38.58,48.10 < 20 |only if walking
Enter the building |goto Darnassus 39.04,76.76 < 15 |walk
use Eridan's Vial##11682
|tip Inside the building.
collect Vial of Blessed Water##5646 |q 4441/1 |goto Darnassus 39.51,83.92
step
Leave the building |goto 39.04,76.76 < 15 |walk
Follow the road |goto Winterspring 61.64,40.26 < 30 |only if walking
Follow the path |goto Winterspring 60.55,38.20 < 15 |only if walking
talk Umi Rumplesnicker##10305
accept Are We There, Yeti?##3783 |goto Winterspring 60.88,37.62
step
Enter the building |goto 61.32,38.72 < 10 |walk
talk Innkeeper Vizzie##11118
|tip Inside the building.
home Everlook |goto 61.36,38.83
step
talk Gregor Greystone##10431
|tip Inside the building.
accept The Everlook Report##6028 |goto 61.35,38.97
accept Duke Nicholas Zverenhoff##6030 |goto 61.35,38.97
step
talk Jessica Redpath##11629
|tip Inside the building.
accept Sister Pamela##5601 |goto 61.28,38.98
step
Leave the building |goto 61.32,38.73 < 7 |walk
Follow the path |goto 60.56,38.20 < 15 |only if walking
Follow the road |goto 58.82,38.78 < 30 |only if walking
Continue following the road |goto 53.78,33.31 < 30 |only if walking
Follow the path up |goto 53.48,28.64 < 30 |only if walking
Enter the building |goto 51.39,29.82 < 15 |only if walking
talk Jaron Stoneshaper##10301
|tip Inside the building.
accept Enraged Wildkin##4861 |goto 52.14,30.43
accept Troubled Spirits of Kel'Theril##5245 |goto 52.14,30.43
step
click Highborne Relic Fragment
collect Second Relic Fragment##12897 |q 5245/2 |goto 50.88,41.71
step
click Highborne Relic Fragment
collect Fourth Relic Fragment##12899 |q 5245/4 |goto 52.42,41.50
step
click Highborne Relic Fragment
collect Third Relic Fragment##12898 |q 5245/3 |goto 53.31,43.43
step
click Highborne Relic Fragment
collect First Relic Fragment##12896 |q 5245/1 |goto 55.14,42.98
|tip You can destroy the "Jaron's Pick" item after collecting this quest item.
step
Follow the path |goto 57.01,41.33 < 30 |only if walking
Follow the road |goto 59.82,39.64 < 30 |only if walking
Kill Ice Thistle enemies around this area
collect 10 Thick Yeti Fur##12366 |q 3783/1 |goto 66.79,43.34
You can find more inside the cave at [67.65,41.75]
step
Follow the road |goto 64.08,43.36 < 30 |only if walking
Follow the path |goto 61.95,60.54 < 30 |only if walking
click Damaged Crate
turnin Enraged Wildkin##4861 |goto 59.00,59.78
accept Enraged Wildkin##4863 |goto 59.00,59.78
step
click Jaron's Wagon
turnin Enraged Wildkin##4863 |goto 61.41,60.68
accept Enraged Wildkin##4864 |goto 61.41,60.68
step
click Jaron's Supplies
|tip The half-buried wooden crate.
collect Jaron's Supplies##12525 |q 4864/1 |goto 61.39,60.73
step
Follow the road |goto 62.01,62.13 < 30 |only if walking
Cross the bridge |goto 62.42,67.44 < 30 |only if walking
Discover Darkwhisper Gorge |q 4842/1 |goto 59.84,74.12
step
Cross the bridge |goto 61.90,70.54 < 30 |only if walking
Follow the road |goto 62.44,66.09 < 30 |only if walking
talk Ranshalla##10300
turnin Find Ranshalla##979 |goto 63.07,59.47
accept Guardians of the Altar##4901 |goto 63.07,59.47
stickystart "Collect_Blue_Feathered_Amulet"
step
Watch the dialogue
|tip Follow Ranshalla and protect her as she walks.
|tip She will help you fight.
click Fire of Elune+
|tip They look like brown torch poles in each of the caves she walks into.
|tip Click them to get her to start walking again.
click Altar of Elune
|tip It looks like a stone table, at this location, that she eventually walks to.
Discover the Secret of the Altar of Elune |q 4901/1 |goto 64.86,63.69
step
label "Collect_Blue_Feathered_Amulet"
Kill Owlbeast enemies around this area
collect Blue-feathered Amulet##12524 |q 4864/2 |goto 65.42,60.38
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
Follow the path |goto 64.01,33.75 < 30 |only if walking
Continue following the path |goto 60.85,36.26 < 30 |only if walking
Follow the road |goto 58.99,39.09 < 30 |only if walking
Continue following the road |goto 53.78,33.31 < 30 |only if walking
Follow the path up |goto 53.48,28.64 < 30 |only if walking
Enter the building |goto 51.39,29.82 < 15 |only if walking
talk Jaron Stoneshaper##10301
|tip Inside the building.
turnin Enraged Wildkin##4864 |goto 52.14,30.43
stickystart "Kill_Winterfall_Pathfinders"
stickystart "Collect_Empty_Firewater_Flask"
step
Follow the road |goto 53.22,34.69 < 30 |only if walking
Follow the path down |goto 44.68,40.13 < 30 |only if walking
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
Follow the road |goto 30.51,42.54 < 30 |only if walking
Continue following the road |goto 44.57,39.85 < 30 |only if walking
Continue following the road |goto 53.84,34.47 < 30 |only if walking
Follow the path |goto 63.31,40.96 < 40 |only if walking
Kill Ice Thistle enemies around this area
|tip Only the Matriarchs or Patriarchs will drop the quest item.
collect 2 Pristine Yeti Horn##12367 |q 977/1 |goto 66.79,43.34
|tip These have a very low drop rate, so may take a while.
You can find more inside the cave at [67.65,41.75]
step
talk Umi Rumplesnicker##10305
turnin Are We There, Yeti?##977 |goto 60.88,37.62
accept Are We There, Yeti?##5163 |goto 60.88,37.62
step
use Umi's Mechanical Yeti##12928
|tip Use it on Legacki.
Scare Legacki |q 5163/1 |goto 61.54,38.62
step
Follow the path |goto 60.56,38.21 < 15 |only if walking
Follow the road |goto 60.83,39.84 < 30 |only if walking
Follow the path |goto 62.01,39.82 < 30 |only if walking
Follow the path |goto Felwood 61.89,14.69 < 30 |only if walking
Follow the path up |goto Felwood 60.71,8.81 < 30 |only if walking
click Deadwood Cauldron
turnin Falling to Corruption##5084 |goto 60.20,5.87
accept Mystery Goo##5085 |goto 60.20,5.87
step
Follow the road up |goto 64.11,15.19 < 20 |only if walking
Enter the tunnel |goto 65.12,8.01 < 15 |walk
Follow the path |goto 66.25,2.90 < 10 |walk
Leave the tunnel |goto 68.44,5.89 < 15 |walk
talk Donova Snowden##9298
turnin Mystery Goo##5085 |goto Winterspring 31.27,45.16
accept Toxic Horrors##5086 |goto Winterspring 31.27,45.16
step
Follow the road |goto 33.19,42.10 < 30 |only if walking
Continue following the road |goto 53.82,34.45 < 30 |only if walking
Follow the path |goto 61.84,39.97 < 30 |only if walking
Enter the building |goto Ironforge 20.67,53.24 < 7 |walk
talk Innkeeper Firebrew##5111
|tip Inside the building.
home Ironforge |goto Ironforge 18.15,51.46
step
Leave the building |goto 20.66,53.21 < 7 |walk
Run up the stairs |goto 31.88,8.36 < 10 |only if walking
Enter the building |goto 32.00,5.50 < 7 |walk
talk Tymor##8507
|tip Inside the building.
turnin Return to Tymor##3461 |goto 30.97,4.82
step
Leave the building |goto 32.02,5.50 < 7 |walk
talk Laris Geardawdle##9616
|tip Inside the building.
turnin A Little Slime Goes a Long Way##4512 |goto 75.77,23.38
step
Watch the dialogue
talk Laris Geardawdle##9616
|tip Inside the building.
accept A Little Slime Goes a Long Way##4513 |goto 75.77,23.38
step
talk Commander Ashlam Valorfist##10838
turnin A Call to Arms: The Plaguelands!##5091 |goto Western Plaguelands 42.70,84.03
accept Clear the Way##5092 |goto Western Plaguelands 42.70,84.03
step
talk Argent Quartermaster Lightspark##10857
accept Argent Dawn Commission##5401 |goto 42.84,83.71
step
use the Argent Dawn Commission##12846
|tip Wearing it will allow Minion's Scourgestones to drop from undead enemies in Western and Eastern Plaguelands.
Gain the Argent Dawn Commission Buff |havebuff 12345 |q 5408 |future
step
talk Argent Officer Pureheart##10840
turnin The Everlook Report##6028 |goto 42.97,83.55
stickystart "Kill_Slavering_Ghouls"
stickystart "Collect_Minions_Scourgestones"
step
kill 10 Skeletal Flayer##1783 |q 5092/1 |goto 48.51,81.13
You can find more:
Around [50.64,77.01]
Inside the crypt at [54.32,79.90]
step
label "Kill_Slavering_Ghouls"
kill 10 Slavering Ghoul##1791 |q 5092/2 |goto 48.51,81.13
You can find more:
Around [50.64,77.01]
Inside the crypt at [54.32,79.90]
step
label "Collect_Minions_Scourgestones"
Kill enemies in around this area
|tip Only undead enemies will drop the quest item.
collect 20 Minion's Scourgestone##12840 |goto 48.51,81.13 |q 9141 |future
|tip Save these for later, when you go to Eastern Plaguelands.
You can find more:
Around [50.64,77.01]
Inside the crypt at [54.32,79.90]
step
Kill enemies around this area
Reach Level 56 |ding 56 |goto 48.51,81.13
You can find more:
Around [50.64,77.01]
Inside the crypt at [54.32,79.90]
step
Follow the path |goto 46.64,81.31 < 30 |only if walking
talk Commander Ashlam Valorfist##10838
turnin Clear the Way##5092 |goto 42.70,84.03
step
Leave the building |goto Ironforge 20.66,53.20 < 7 |walk
Enter the building |goto Ironforge 44.60,49.53 < 15 |walk
talk Royal Historian Archesonus##8879
|tip Inside the building.
accept The Smoldering Ruins of Thaurissan##3702 |goto Ironforge 38.37,55.31
step
talk Royal Historian Archesonus##8879
|tip Inside the building.
Tell her _"I am ready to listen"_
Listen to the Story of Thaurissan |q 3702/1 |goto 38.37,55.31
step
talk Royal Historian Archesonus##8879
|tip Inside the building.
turnin The Smoldering Ruins of Thaurissan##3702 |goto 38.37,55.31
accept The Smoldering Ruins of Thaurissan##3701 |goto 38.37,55.31
step
Leave the building |goto 44.58,49.50 < 15 |walk
talk Oralius##9177
accept Extinguish the Firegut##3823 |goto Burning Steppes 84.56,68.68
accept FIFTY! YEP!##4283 |goto Burning Steppes 84.56,68.68
step
talk Helendis Riverhorn##9562
accept Dragonkin Menace##4182 |goto 85.82,68.94
step
Follow the path down |goto 84.58,66.96 < 20 |only if walking
Follow the path |goto 67.27,44.16 < 30 |only if walking
Follow the path up |goto 63.93,29.93 < 20 |only if walking
talk Tinkee Steamboil##10267
accept Broodling Essence##4726 |goto 65.24,24.00
step
talk Maxwort Uberglint##9536
accept Tablet of the Seven##4296 |goto 65.16,23.92
step
Enter the cave |goto 65.52,23.08 < 15 |walk
talk Yuka Screwspigot##9544
|tip Inside the cave.
turnin Yuka Screwspigot##4324 |goto 66.06,21.95
stickystart "Kill_Black_Drake"
stickystart "Kill_Black_Wyrmkins"
stickystart "Kill_Black_Dragonspawns"
stickystart "Kill_Black_Broodlings"
stickystart "Collect_Blackrock_Medallions_Confirm"
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
label "Kill_Black_Drake"
Leave the cave |goto 94.11,31.92 < 15 |walk
kill Black Drake##7044 |q 4182/3 |goto 86.33,30.69
|tip They look like red dragons flying low to the ground around this area.
|tip You may need help with this, but it's important to do.
Also check around:
[89.89,37.22]
[89.50,56.92]
[81.84,58.36]
step
label "Kill_Black_Wyrmkins"
kill 4 Black Wyrmkin##7041 |q 4182/4 |goto 84.25,27.76
|tip You may need help with this, but it's important to do.
You can find more around: |notinsticky
[88.83,39.34]
[91.82,54.43]
step
label "Kill_Black_Dragonspawns"
kill 10 Black Dragonspawn##7040 |q 4182/2 |goto 84.25,27.76
|tip You may need help with this, but it's important to do.
You can find more around: |notinsticky
[88.83,39.34]
[91.82,54.43]
step
label "Kill_Black_Broodlings"
kill 15 Black Broodling##7047 |q 4182/1 |goto 72.83,28.41
You can find more around: |notinsticky
[80.05,27.94]
[87.34,32.01]
[91.96,35.64]
[89.92,45.69]
[84.65,61.84]
step
label "Collect_Blackrock_Medallions_Confirm"
kill Ember Worg##9690+
|tip They look like brown wolves around this area.
|tip Just kill any that you see while complete the "Dragonkin Menace" quest.
collect Blackrock Medallion##11467 |n
|tip Save any of these that you get for later.
Click Here Once You Reach This Step |confirm |q 4283
|tip That will mean you've completed the "Dragonkin Menace" quest.
stickystart "Kill_Firegut_Brutes"
stickystart "Kill_Firegut_Ogre_Mages"
stickystart "Collect_Dark_Iron_Scraps"
step
kill 7 Firegut Ogre##7033 |q 3823/2 |goto 85.92,46.37
You can find more:
Inside the cave at [77.00,47.68]
Up the path that starts at [75.63,38.36]
Inside the cave at [82.80,38.85]
step
label "Kill_Firegut_Brutes"
kill 7 Firegut Brute##7035 |q 3823/3 |goto 85.92,46.37
You can find more:
Inside the cave at [77.00,47.68]
Up the path that starts at [75.63,38.36]
Inside the cave at [82.80,38.85]
step
label "Kill_Firegut_Ogre_Mages"
kill 15 Firegut Ogre Mage##7034 |q 3823/1 |goto 85.92,46.37
You can find more:
Inside the cave at [77.00,47.68]
Up the path that starts at [75.63,38.36]
Inside the cave at [82.80,38.85]
step
label "Collect_Dark_Iron_Scraps"
Kill Firegut enemies around this area
|tip They look like ogres.
collect 30 Dark Iron Scraps##22528 |goto 85.92,46.37 |q 9131 |future
You can find more:
Inside the cave at [77.00,47.68]
Up the path that starts at [75.63,38.36]
Inside the cave at [82.80,38.85]
step
click Thaurissan Relic+
They look like cylindrical grey stones sitting upright on the ground around this area.
Recover #12# Information |q 3701/1 |goto 68.42,37.33
You can find more around: |notinsticky
[66.04,44.05]
[62.21,40.68]
[58.93,42.59]
[57.80,37.02]
[52.89,35.96]
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
Follow the path |goto 68.40,48.44 < 40 |only if walking
Follow the path up |goto 82.85,63.31 < 20 |only if walking
Follow the path |goto 84.60,66.98 < 15 |only if walking
talk Oralius##9177
turnin Extinguish the Firegut##3823 |goto 84.56,68.67
accept Gor'tesh the Brute Lord##3824 |goto 84.56,68.67
step
talk Helendis Riverhorn##9562
turnin Dragonkin Menace##4182 |goto 85.82,68.95
accept The True Masters##4183 |goto 85.82,68.95
stickystart "Collect_Blackrock_Medallions"
step
Follow the path down |goto 84.57,66.93 < 15 |only if walking
Follow the road |goto 68.09,48.32 < 30 |only if walking
kill Gor'tesh##9176
|tip He walks around this area, in and out of this building.
collect Gor'tesh's Lopped Off Head##11080 |q 3824/1 |goto 39.26,55.36
step
label "Collect_Blackrock_Medallions"
Kill Blackrock enemies around this area
|tip They look like orcs and wolves.
|tip You can find more inside the buildings around this area.
collect 50 Blackrock Medallion##11467 |q 4283/1 |goto 39.31,55.42
You can find more around: |notinsticky
[43.90,56.18]
[49.30,55.43]
[52.98,53.87]
step
Follow the road |goto 54.58,50.78 < 30 |only if walking
Follow the path |goto 68.49,48.49 < 30 |only if walking
Follow the path up |goto 82.85,63.31 < 20 |only if walking
Follow the path |goto 84.60,66.98 < 15 |only if walking
talk Oralius##9177
turnin Gor'tesh the Brute Lord##3824 |goto 84.56,68.67
accept Ogre Head On A Stick = Party##3825 |goto 84.56,68.67
turnin FIFTY! YEP!##4283 |goto 84.56,68.67
step
Follow the path down |goto 84.57,66.97 < 15 |only if walking
Follow the path |goto 75.26,50.71 < 40 |only if walking
Follow the path up |goto 75.63,38.29 < 20 |only if walking
Continue up the path |goto 78.12,39.22 < 15 |only if walking
Continue up the path |goto 79.69,40.94 < 15 |only if walking
click Soft Dirt Mound
Plant Gor'tesh's Head |q 3825/1 |goto 80.99,46.78
step
Follow the path up |goto 82.85,63.31 < 20 |only if walking
Follow the path |goto 84.60,66.98 < 15 |only if walking
talk Oralius##9177
turnin Ogre Head On A Stick = Party##3825 |goto 84.56,68.67
step
Enter the building |goto Redridge Mountains 29.49,46.11 < 15 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4183 |goto Redridge Mountains 29.99,44.45
accept The True Masters##4184 |goto Redridge Mountains 29.99,44.45
step
Leave the building |goto 29.50,46.16 < 10 |walk
Enter the building |goto Stormwind City 69.10,28.69 < 15 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4184 |goto Stormwind City 78.22,17.99
accept The True Masters##4185 |goto Stormwind City 78.22,17.99
step
talk Lady Katrana Prestor##1749
|tip Inside the building.
Tell her _"Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice."_
Seek Advice from Lady Prestor |q 4185/1 |goto 78.11,17.75
step
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The True Masters##4185 |goto 78.22,17.99
accept The True Masters##4186 |goto 78.22,17.99
step
Leave the building |goto 69.01,28.80 < 15 |walk
Run up the ramp |goto 62.40,62.29 < 15 |only if walking
Enter the building |goto Redridge Mountains 29.49,46.11 < 15 |walk
talk Magistrate Solomon##344
|tip Inside the building.
turnin The True Masters##4186 |goto Redridge Mountains 29.99,44.45
accept The True Masters##4223 |goto Redridge Mountains 29.99,44.45
step
Leave the building |goto 29.50,46.15 < 10 |walk
talk Marshal Maxwell##9560
turnin The True Masters##4223 |goto Burning Steppes 84.75,69.02
accept The True Masters##4224 |goto Burning Steppes 84.75,69.02
step
Follow the path down |goto 84.58,66.98 < 15 |only if walking
Follow the path |goto 67.27,44.02 < 30 |only if walking
Follow the path up |goto 63.96,29.79 < 20 |only if walking
talk Ragged John##9563
Tell him _"Official business, John.  I need some information about Marshal Windsor.  Tell me about the last time you saw him."_
Listen to Ragged John's Story |q 4224/1 |goto 65.01,23.76
step
Follow the path |goto 68.50,48.48 < 30 |only if walking
Follow the path up |goto 82.79,63.31 < 20 |only if walking
Follow the path |goto 84.59,66.95 < 15 |only if walking
talk Marshal Maxwell##9560
turnin The True Masters##4224 |goto 84.74,69.01
step
Leave the building |goto Ironforge 20.68,53.22 < 7 |c |q 1019 |future
step
map Ironforge
path	follow strict;	loop;	ants curved
path	32.24,22.90		34.74,33.94		40.38,37.68		48.22,31.09
path	55.91,35.09		57.34,48.56		48.22,57.86		46.33,47.76
path	39.94,44.41		38.43,38.33		34.49,32.86		33.42,21.18
path	39.45,12.40		44.31,10.79		53.02,10.57		58.98,13.76
path	70.47,33.88		71.16,44.77		70.12,55.01		67.38,65.14
path	57.32,78.92		50.14,81.06		39.59,79.17		34.35,74.44
path	24.69,55.32		24.38,38.36		27.70,25.23
talk Courier Hammerfall##10877
|tip He looks like a dwarf that walks in a counter-clockwise path around Ironforge.
|tip This step's path will take you clockwise to help you find him faster.
accept The New Frontier##1019
step
Enter the building |goto 44.55,49.53 < 15 |walk
talk Royal Historian Archesonus##8879
|tip Inside the building.
turnin The Smoldering Ruins of Thaurissan##3701 |goto 38.37,55.30
step
Leave the building |goto 44.68,49.42 < 15 |walk
talk Commander Ashlam Valorfist##10838
accept The Scourge Cauldrons##5215 |goto Western Plaguelands 42.70,84.04
step
talk High Priestess MacDonnell##11053
turnin The Scourge Cauldrons##5215 |goto 42.97,84.50
accept Target: Felstone Field##5216 |goto 42.97,84.50
stickystart "Collect_Bone_Fragments"
step
Follow the road |goto 42.62,80.61 < 30 |only if walking
Follow the path |goto 36.84,73.56 < 30 |only if walking
Follow the path up |goto 35.63,69.07 < 15 |only if walking
kill Cauldron Lord Bilemaw##11075
collect Felstone Field Cauldron Key##13194 |q 5216/1 |goto 37.12,57.18
step
click Scourge Cauldron
turnin Target: Felstone Field##5216 |goto 37.19,56.87
accept Return to Chillwind Camp##5217 |goto 37.19,56.87
step
Enter the building |goto 38.04,54.61 < 10 |walk
talk Janice Felstone##10778
|tip Upstairs inside the building.
accept Better Late Than Never##5021 |goto 38.40,54.05
step
Leave the building |goto 38.03,54.63 < 7 |walk
Enter the building |goto 38.52,55.33 < 10 |walk
click Janice's Parcel
|tip Inside the building.
|tip You will have to click it twice.
turnin Better Late Than Never##5021 |goto 38.73,55.24
accept Better Late Than Never##5023 |goto 38.73,55.24
step
label "Collect_Bone_Fragments"
Leave the building |goto 38.54,55.32 < 7 |walk
Kill enemies in around this area
|tip Only skeleton enemies will drop the quest item.
collect 30 Bone Fragments##22526 |goto 36.76,56.42 |q 9126 |future
step
Leave the building |goto Ironforge 20.66,53.21 < 7 |walk
Enter the building |goto Ironforge 26.12,72.19 < 15 |walk
talk Auctioneer Redmuse##8720
|tip Inside the building.
|tip Buy these items from the Auction House.
collect 2 Thorium Bar##12359 |goto Ironforge 24.25,74.55 |q 6026 |future
collect Golden Rod##11128 |goto Ironforge 24.25,74.55 |q 6026 |future
collect 8 Hi-Explosive Bomb##10562 |goto Ironforge 24.25,74.55 |q 6026 |future
collect 8 Unstable Trigger##10560 |goto Ironforge 24.25,74.55 |q 6026 |future
step
Enter the building |goto Stormwind City 47.79,31.24 < 10 |walk
talk Royal Factor Bathrilor##10782
|tip Upstairs inside the building.
turnin Better Late Than Never##5023 |goto Stormwind City 48.47,30.55
accept Good Natured Emma##5048 |goto Stormwind City 48.47,30.55
step
Leave the building |goto 47.80,31.23 < 7 |c |q 5048
step
map Stormwind City
path	follow strict;	loop;	ants curved
path	52.46,41.98		48.29,49.03		50.15,51.53		55.04,47.69
path	57.64,47.70		59.73,51.45		57.66,55.16		60.62,60.33
path	57.16,54.48		57.05,54.37		55.65,53.48		52.74,55.15
path	50.88,51.60		49.66,51.59		48.32,48.32
talk Ol' Emma##3520
|tip She looks like an old human woman that walks in a counter-clockwise path around Stormwind City.
|tip This step's path will take you clockwise to help you find her faster.
|tip She sometimes stands upstairs inside the house that this path leads you to the doorway of.
|tip Keep an eye on your minimap as you walk around, she will show up as a yellow dot.
turnin Good Natured Emma##5048
accept Good Luck Charm##5050
step
Enter the building |goto 69.11,28.64 < 15 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
accept The First and the Last##6182 |goto 78.23,17.98
step
Leave the building |goto 69.06,28.79 < 15 |walk
Run up the stairs |goto 73.00,51.63 < 15 |only if walking
Follow the path |goto 74.73,53.66 < 10 |only if walking
Enter the building |goto 77.12,58.01 < 10 |walk
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin The First and the Last##6182 |goto 75.79,59.85
accept Honor the Dead##6183 |goto 75.79,59.85
step
talk Master Mathias Shaw##332
|tip Upstairs inside the building.
turnin Honor the Dead##6183 |goto 75.79,59.85
accept Flint Shadowmore##6184 |goto 75.79,59.85
step
Leave the building |goto 77.19,58.19 < 7 |walk
Follow the path |goto 75.41,55.05 < 10 |only if walking
Run up the ramp |goto 62.43,62.28 < 15 |only if walking
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5217 |goto Western Plaguelands 42.97,84.50
accept Target: Dalson's Tears##5219 |goto Western Plaguelands 42.97,84.50
step
talk Flint Shadowmore##12425
turnin Flint Shadowmore##6184 |goto 43.61,84.51
accept The Eastern Plagues##6185 |goto 43.61,84.51
step
Follow the road |goto 42.62,80.61 < 30 |only if walking
Follow the path |goto 36.84,73.56 < 30 |only if walking
Follow the path up |goto 35.63,69.07 < 15 |only if walking
Enter the building |goto 38.04,54.61 < 10 |walk
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Good Luck Charm##5050 |goto 38.40,54.05
accept Two Halves Become One##5051 |goto 38.40,54.05
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
Kill enemies around this area
Reach Level 57 |ding 57 |goto 37.38,56.36
step
Enter the building |goto 38.04,54.61 < 10 |walk
talk Janice Felstone##10778
|tip Upstairs inside the building.
turnin Two Halves Become One##5051 |goto 38.40,54.05
step
Leave the building |goto 38.02,54.65 < 7 |walk
kill Cauldron Lord Malvinious##11077
collect Dalson's Tears Cauldron Key##13195 |q 5219/1 |goto 46.04,52.33
step
click Scourge Cauldron
turnin Target: Dalson's Tears##5219 |goto 46.18,52.02
accept Return to Chillwind Camp##5220 |goto 46.18,52.02
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
Leave the building |goto 47.15,50.22 < 7 |walk
Follow the road |goto 47.07,57.08 < 30 |only if walking
Follow the path |goto 40.31,59.83 < 30 |only if walking
Follow the path |goto 36.57,68.66 < 30 |only if walking
Follow the path up |goto 36.37,73.34 < 15 |only if walking
Follow the road |goto 36.38,78.08 < 30 |only if walking
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5220 |goto 42.97,84.50
accept Target: Writhing Haunt##5222 |goto 42.97,84.50
step
Follow the path |goto 46.61,81.32 < 30 |only if walking
Continue following the path |goto 50.63,76.95 < 30 |only if walking
Follow the path up |goto 51.46,71.39 < 15 |only if walking
kill Cauldron Lord Razarch##11076
collect Writhing Haunt Cauldron Key##13197 |q 5222/1 |goto 53.12,65.96
step
click Scourge Cauldron
turnin Target: Writhing Haunt##5222 |goto 53.02,65.72
accept Return to Chillwind Camp##5223 |goto 53.02,65.72
step
Enter the building |goto 53.60,64.79 < 10 |walk
talk Mulgris Deepriver##10739
|tip Inside the building.
accept The Wildlife Suffers Too##4984 |goto 53.72,64.67
step
Follow the road |goto 49.50,56.70 < 30 |only if walking
kill 8 Diseased Wolf##1817 |q 4984/1 |goto 42.74,54.83
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
accept Glyphed Oaken Branch##4986 |goto 53.72,64.67
step
Follow the path up |goto 52.37,74.71 < 15 |only if walking
Follow the path |goto 46.62,81.33 < 30 |only if walking
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5223 |goto 42.97,84.50
accept Target: Gahrron's Withering##5225 |goto 42.97,84.50
step
Follow the path |goto 46.61,81.32 < 30 |only if walking
Continue following the path |goto 52.14,75.49 < 30 |only if walking
Follow the path |goto 54.99,71.56 < 30 |only if walking
Continue following the path |goto 58.80,62.31 < 30 |only if walking
kill Cauldron Lord Soulwrath##11078
collect Gahrron's Withering Cauldron Key##13196 |q 5225/1 |goto 51.95,24.65
step
click Scourge Cauldron
turnin Target: Gahrron's Withering##5225 |goto 51.91,24.63
accept Return to Chillwind Point##5226 |goto 51.91,24.63
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
Follow the path up |goto 26.62,71.51 < 20 |only if walking
talk Nathanos Blightcaller##11878
|tip His hyenas will not attack you.
accept To Kill With Purpose##6022 |goto 26.54,74.74
accept Un-Life's Little Annoyances##6042 |goto 26.54,74.74
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
talk Khaelyn Steelwing##12617
fpath Light's Hope Chapel |goto 81.63,59.28
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
talk High Priestess MacDonnell##11053
turnin Return to Chillwind Camp##5226 |goto Western Plaguelands 42.97,84.50
step
talk Commander Ashlam Valorfist##10838
accept Mission Accomplished!##5238 |goto 42.70,84.03
step
talk Flint Shadowmore##12425
turnin The Eastern Plagues##6185 |goto 43.61,84.51
step
talk Nathaniel Dumah##11616
accept A Plague Upon Thee##5903 |goto 43.42,84.84
step
Follow the path |goto 74.39,67.69 < 30 |only if walking
kill Gibbering Ghoul##8531+
|tip All around this town.
talk Darrowshire Spirit##11064+
|tip They appear after you kill the Gibbering Ghouls.
Free #15# Darrowshire Spirits |q 5211/1 |goto 59.90,68.41
step
Follow the road |goto 63.09,62.71 < 30 |only if walking
kill 5 Frenzied Plaguehound##8598 |q 5542/3 |goto 62.63,47.95
You can find more around: |notinsticky
[51.17,43.24]
[49.69,35.97]
step
talk Aurora Skycaller##10304
turnin Troubled Spirits of Kel'Theril##5245 |goto 53.51,22.00
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
Follow the road |goto 19.24,73.13 < 30 |only if walking
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
talk Commander Ashlam Valorfist##10838
accept All Along the Watchtowers##5098 |goto Western Plaguelands 42.70,84.03
step
talk Flint Shadowmore##12425
accept The Blightcaller Cometh##6186 |goto 43.61,84.51
step
talk Nathaniel Dumah##11616
turnin A Plague Upon Thee##5903 |goto 43.42,84.84
accept A Plague Upon Thee##5904 |goto 43.42,84.84
step
Follow the path |goto Eastern Plaguelands 70.37,48.89 < 30 |only if walking
click Symbol of Lost Honor
|tip Underwater.
collect Symbol of Lost Honor##14625 |q 5845/1 |goto Eastern Plaguelands 71.30,33.95
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
Leave the building |goto 65.61,75.38 < 7 |walk
Follow the path up |goto 55.17,77.76 < 20 |only if walking
Enter the building |goto 49.28,78.55 < 10 |walk
talk Marlene Redpath##10927
|tip Upstairs inside the building.
turnin Auntie Marlene##5152 |goto 49.17,78.58
accept A Strange Historian##5153 |goto 49.17,78.58
step
Leave the building |goto 49.28,78.55 < 7 |walk
click Joseph Redpath's Monument
collect Joseph's Wedding Ring##12894 |q 5153/1 |goto 49.68,76.77
step
Cross the bridge |goto 49.22,73.14 < 20 |only if walking
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Four |q 5097/4 |goto 46.70,71.10
step
Avoid the big group of enemies in the center of town |goto 44.17,71.56 < 30 |only if walking
Follow the road |goto 41.32,70.69 < 20 |only if walking
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower One |q 5097/1 |goto 40.13,71.52
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
Mark Tower Two |q 5097/2 |goto 42.44,66.27
step
use the Beacon Torch##12815
|tip Use it in front of the tower entrance.
|tip Be careful, there is an elite enemy inside the tower.
|tip Avoid the doorway, making sure the elite inside can't see you.
|tip You can get closer to the tower safely, if the enemy inside can't see you.
Mark Tower Three |q 5097/3 |goto 44.22,63.37
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
Follow the path |goto 49.93,30.78 < 30 |only if walking
Continue following the path |goto 45.83,47.67 < 40 |only if walking
Continue following the path |goto 36.49,68.56 < 30 |only if walking
Follow the path up |goto 35.14,72.88 < 15 |only if walking
Follow the road |goto 36.90,78.75 < 30 |only if walking
talk Nathaniel Dumah##11616
turnin A Plague Upon Thee##6390 |goto 43.42,84.83
step
talk Commander Ashlam Valorfist##10838
turnin All Along the Watchtowers##5097 |goto 42.70,84.03
step
Leave the building |goto Ironforge 20.62,53.21 < 7 |walk
talk Cenarion Emissary Jademoon##15187
accept Taking Back Silithus##8275 |goto Ironforge 58.54,47.31
step
Enter the building |goto Stormwind City 69.08,28.69 < 15 |walk
talk Highlord Bolvar Fordragon##1748
|tip Inside the building.
turnin The Blightcaller Cometh##6186 |goto Stormwind City 78.22,17.98
step
Leave the building |goto 69.09,28.70 < 15 |walk
Run up the ramp |goto 62.40,62.26 < 15 |only if walking
talk Erelas Ambersky##7916
|tip Inside the building.
turnin Guardians of the Altar##4901 |goto Teldrassil 55.50,92.05
accept Wildkin of Elune##4902 |goto Teldrassil 55.50,92.05
step
Enter the building |goto Darnassus 35.52,10.70 < 10 |walk
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building.
turnin Glyphed Oaken Branch##4986 |goto Darnassus 35.38,8.40
step
talk Arch Druid Fandral Staghelm##3516
|tip Upstairs inside the building, at the top.
turnin The New Frontier##1019 |goto 34.82,9.25
accept The New Frontier##6761 |goto 34.82,9.25
turnin Wildkin of Elune##4902 |goto 34.82,9.25
step
talk Mathrengyl Bearwalker##4217
|tip Upstairs inside the building, on the middle floor.
turnin The New Frontier##6761 |goto 35.38,8.40
accept Rabine Saturna##6762 |goto 35.38,8.40
step
Leave the building |goto 35.54,10.75 < 7 |walk
Follow the road |goto Moonglade 40.40,36.43 < 30 |only if walking
Enter the building |goto Moonglade 51.47,41.43 < 15 |walk
talk Rabine Saturna##11801
|tip Inside the building.
turnin Rabine Saturna##6762 |goto Moonglade 51.69,45.09
accept Wasteland##1124 |goto Moonglade 51.69,45.09
accept A Reliquary of Purity##5527 |goto Moonglade 51.69,45.09
step
Follow the road |goto Ashenvale 38.35,57.68 < 30 |only if walking
Continue following the road |goto Ashenvale 59.84,62.28 < 30 |only if walking
Enter Felwood |goto Ashenvale 55.84,31.64 < 30 |only if walking
Follow the path up |goto Felwood 51.15,84.00 < 30 |only if walking
Enter the building |goto Felwood 51.26,81.69 < 10 |walk
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Felbound Ancients##4441 |goto Felwood 51.35,81.51
accept Purified!##4442 |goto Felwood 51.35,81.51
step
Watch the dialogue
talk Eridan Bluewind##9116
|tip Inside the building.
turnin Purified!##4442 |goto 51.35,81.51
step
Leave the building |goto 51.26,81.70 < 7 |walk
Follow the road |goto 49.87,83.90 < 30 |only if walking
Follow the path down |goto 44.69,23.44 < 30 |only if walking
kill Toxic Horror##7132+
collect 3 Toxic Horror Droplet##12822 |q 5086/1 |goto 48.61,23.88
You can find more around [50.89,22.57]
step
Follow the path up |goto 49.69,17.45 < 30 |only if walking
Follow the road |goto 50.17,14.16 < 30 |only if walking
Follow the path |goto 61.36,16.45 < 30 |only if walking
Continue following the path |goto 62.84,23.03 < 30 |only if walking
Follow the path |goto Tanaris 51.01,28.63 < 15 |only if walking
use the Umi's Mechanical Yeti##12928
|tip Use it on Sprinkle.
Scare Sprinkle |q 5163/2 |goto Tanaris 51.06,26.87
step
Follow the path |goto 51.01,28.63 < 15 |only if walking
use the Umi's Mechanical Yeti##12928
|tip Use it on Quixxil.
Scare Quixxil |q 5163/3 |goto Un'Goro Crater 43.67,9.38
step
use the Bag of Empty Ooze Containers##11955
collect 10 Empty Pure Sample Jar##11953 |q 4513
step
Follow the path down |goto 45.21,11.59 < 20 |only if walking
kill Glutinous Ooze##6559+
use the Empty Pure Sample Jar##11953+
|tip Use them on their corpses.
collect 10 Filled Pure Sample Jar##11954 |q 4513/1 |goto 38.28,32.32
You can find more around: |notinsticky
[32.50,33.81]
[27.98,35.95]
[34.61,37.32]
[36.92,40.68]
[39.93,38.85]
[40.17,46.60]
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
turnin Taking Back Silithus##8275 |goto 51.15,38.29
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
Enter the building |goto 49.60,36.02 < 15 |only if walking
talk Commander Mar'alith##15181
|tip Outside, on the balcony of the building.
accept Dearest Natalia##8304 |goto 49.19,34.18
step
Leave the building |goto 49.61,36.02 < 10 |only if walking
Follow the path up |goto 50.30,35.91 < 15 |only if walking
talk Rifleman Torrig##17082
accept Report to Marshal Bluewall##9415 |goto 50.68,34.70
step
talk Cloud Skydancer##15177
fpath Cenarion Hold |goto 50.58,34.45
stickystart "Kill_Tortured_Druids"
stickystart "Kill_Tortured_Sentinels"
step
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
stickystart "Kill_Dredge_Crushers"
stickystart "Collect_Stonelash_Pincer_Stingers"
step
talk Marshal Bluewall##17080
turnin Report to Marshal Bluewall##9415 |goto 33.29,51.05
step
label "Kill_Dredge_Crushers"
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
Leave the building |goto Ironforge 20.67,53.21 < 7 |walk
talk Laris Geardawdle##9616
|tip Inside the building.
turnin A Little Slime Goes a Long Way##4513 |goto Ironforge 75.77,23.37
step
talk Carlin Redpath##11063
turnin Brother Carlin##5210 |goto Eastern Plaguelands 81.52,59.77
accept Villains of Darrowshire##5181 |goto Eastern Plaguelands 81.52,59.77
step
Enter the building |goto 81.15,58.55 < 10 |walk
talk Archmage Angela Dosantos##16116
|tip Inside the building.
accept The Elemental Equation##9128 |goto 81.52,58.27
step
talk Archmage Angela Dosantos##16116
|tip Inside the building.
turnin The Elemental Equation##9128 |goto 81.52,58.27
step
Leave the building |goto 81.15,58.56 < 10 |walk
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
Follow the road |goto Moonglade 40.40,36.43 < 30 |only if walking
talk Umber##11939
|tip Upstairs inside the building.
turnin Umber, Archivist##6844 |goto Moonglade 44.89,35.59
accept Uncovering Past Secrets##6845 |goto Moonglade 44.89,35.59
step
Enter the building |goto 51.47,41.43 < 15 |walk
talk Rabine Saturna##11801
|tip Inside the building.
turnin A Reliquary of Purity##5527 |goto 51.69,45.09
turnin Uncovering Past Secrets##6845 |goto 51.69,45.09
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
turnin Felnok Steelspring##4808 |goto 61.63,38.61
accept Chillwind Horns##4809 |goto 61.63,38.61
step
Follow the path |goto 60.56,38.21 < 15 |only if walking
Follow the road |goto 58.78,38.58 < 30 |only if walking
Continue following the road |goto 53.78,33.19 < 30 |only if walking
Follow the path up |goto 48.56,10.20 < 15 |only if walking
talk Rivern Frostwind##10618
accept Frostsaber Provisions##4970 |goto 49.94,9.84
stickystart "Collect_Chillwind_Meat"
stickystart "Collect_Uncracked_Chillwind_Horns"
step
kill Elder Shardtooth##7445+
collect 5 Shardtooth Meat##12622 |q 4970/1 |goto 58.53,13.93
You can find more around: |notinsticky
[60.95,14.52]
[59.41,17.90]
[57.17,20.49]
[55.23,22.20]
[60.12,21.49]
[60.09,25.17]
step
label "Collect_Chillwind_Meat"
kill Chillwind Ravager##7449+
collect 5 Chillwind Meat##12623 |q 4970/2 |goto 58.53,13.93
You can find more around: |notinsticky
[60.95,14.52]
[59.41,17.90]
[57.17,20.49]
[55.23,22.20]
[60.12,21.49]
step
label "Collect_Uncracked_Chillwind_Horns"
kill Chillwind Ravager##7449+
collect 8 Uncracked Chillwind Horn##12444 |q 4809/1 |goto 58.53,13.93
|tip These have a pretty low drop rate.
You can find more around: |notinsticky
[60.95,14.52]
[59.41,17.90]
[57.17,20.49]
[55.23,22.20]
[60.12,21.49]
step
Follow the path up |goto 48.56,10.20 < 15 |only if walking
talk Rivern Frostwind##10618
accept Frostsaber Provisions##4970 |goto 49.94,9.84
step
Follow the road |goto 57.04,20.31 < 30 |only if walking
Continue following the road |goto 53.68,24.64 < 30 |only if walking
Continue following the road |goto 54.32,34.60 < 30 |only if walking
Follow the path |goto 59.11,38.80 < 30 |only if walking
Follow the path |goto 60.56,38.20 < 15 |only if walking
talk Felnok Steelspring##10468
turnin Chillwind Horns##4809 |goto 61.63,38.61
accept Return to Tinkee##4810 |goto 61.63,38.61
step
Follow the path |goto 60.56,38.20 < 15 |only if walking
Follow the road |goto 60.69,39.77 < 30 |only if walking
Follow the path |goto 61.84,40.04 < 30 |only if walking
Follow the path down |goto Burning Steppes 84.57,66.95 < 15 |only if walking
Follow the path |goto Burning Steppes 67.42,44.29 < 30 |only if walking
Follow the path up |goto Burning Steppes 63.87,30.00 < 20 |only if walking
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
