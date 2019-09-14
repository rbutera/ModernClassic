local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("LevelingACLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
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
