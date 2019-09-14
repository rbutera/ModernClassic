local name,addon = ...

addon.LibRoverData = addon.LibRoverData or {}
local data=addon.LibRoverData

data.basenodes.DungeonEntrances = {}
data.basenodes.DungeonFloors = {}

do return end
-- TODO

data.basenodes.DungeonEntrances = {
--[[	
--------------------------------------
---   DUNGEON ENTRANCES & EXITS    ---
--------------------------------------
	-- {autotype:portal_dungeon} gives the nice "enter dungeon"/"exit dungeon" mechanics.

	--------------------
	---   KALIMDOR   ---
	--------------------

		-- RAGEFIRE CHASM
			"Orgrimmar/2 70.33,48.92 -x- Ragefire Chasm/1 0.00,0.00 {autotype:portal_dungeon}",

		-- WAILING CAVERNS
			"Northern Barrens/20 28.59,69.26 <radius:15> <nofly:1>",
			"@+ -x- Northern Barrens/20 25.41,50.67 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Northern Barrens/20 24.08,26.47 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Northern Barrens/20 32.28,22.43 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Northern Barrens/20 41.54,29.02 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Northern Barrens/20 49.10,31.95 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Northern Barrens/20 50.62,48.50 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Northern Barrens/20 55.03,66.11 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Wailing Caverns/1 0.00,0.00 {autotype:portal_dungeon}",

		-- BLACKFATHOM DEEPS
			"Ashenvale/0 13.94,13.76 <radius:10> <nofly:1> <title:Enter the underwater cave>",
			"@+ -x- Ashenvale/0 13.16,13.09 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 13.63,11.90 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 13.93,11.14 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 13.68,9.39 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 14.32,9.08 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 14.81,10.39 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 15.69,11.35 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 16.53,11.67 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Ashenvale/0 16.49,10.99 <radius:15> <dark:1> <nofly:1>",
			"@+ -x- Blackfathom Deeps/1 0.00,0.00 {autotype:portal_dungeon}",

		-- ZUL'FARRAK
			"Tanaris/0 39.21,21.21 -x- Zul'Farrak/0 0.00,0.00 {autotype:portal_dungeon}",

		-- RAZORFEN DOWNS
			"Thousand Needles 47.65,23.65 -x- Razorfen Downs/1 0.00,0.00 {autotype:portal_dungeon}",

		-- RAZORFEN KRAUL
			"Southern Barrens 40.72,94.39 -x- Razorfen Kraul 69.89,82.97 {autotype:portal_dungeon}",

		-- MARAUDON: EARTHSONG FALLS
			"Desolace/22 44.3,76.7 -to- Maraudon 28.1,35.5 {template:cityportal}",

		-- MARAUDON: THE WICKED GROTTO
			"Desolace/22 52.4,23.8 -x- Maraudon 78.48,68.45 {autotype:portal_dungeon}",

		-- MARAUDON: FOULSPORE CAVERN
			"Desolace/21 78.4,55.3 -x- Maraudon 62.16,28.18 {autotype:portal_dungeon}",

		-- DIRE MAUL: WARPWOOD QUARTER
			"Feralas/0 64.8,30.2 -x- Dire Maul/5 6.71,38.29 {autotype:portal_dungeon}",
			"Feralas/0 66.77,34.84 -x- Dire Maul/5 28.22,84.76 {autotype:portal_dungeon}",
			"Feralas/0 76.45,35.90 -x- Dire Maul/5 92.12,45.20 {autotype:portal_dungeon}",
			"Dire Maul/6 36.74,38.45 -to- Feralas/0 66.11,26.31 {template:portalDungeonExit}",
			
		-- DIRE MAUL: CAPITAL GARDENS
			"Feralas/0 60.31,31.30 -x- Dire Maul/2 93.42,75.90 {autotype:portal_dungeon}",
			"Feralas/0 60.32,30.12 -x- Dire Maul/2 93.53,47.68 {autotype:portal_dungeon}",
			
		-- DIRE MAUL: GORDOK COMMONS
			"Feralas 62.51,24.89 -x- Dire Maul/1 71.13,93.54 {autotype:portal_dungeon}",

		-- THE BLACK MORASS
			"Tanaris/18 36.3,83.2 -x- The Black Morass 52.06,0.15 {autotype:portal_dungeon}",
			
		-- CULLING OF STRATHOLME
			"Tanaris/18 57.4,82.6  -x- The Culling of Stratholme 87.51,71.21 {autotype:portal_dungeon}",
			
		-- END TIME
			"Tanaris/18 57.6,29.6 -x- End Time 80.73,44.20 {autotype:portal_dungeon}",
			
		-- WELL OF ETERNITY
			"Tanaris/18 22.5,64.4 -x- Well of Eternity 27.82,63.37 {autotype:portal_dungeon}",
			
		-- HOUR OF TWILIGHT
			"Tanaris/18 67.2,29.4 -x- Hour of Twilight 48.51,19.72 {autotype:portal_dungeon}",

		-- THE VORTEX PINNACLE
			"Uldum 76.81,84.55 -x- The Vortex Pinnacle 54.12,16.81 {autotype:portal_dungeon}",
			
		-- HALLS OF ORIGINATION
			"Uldum 69.09,52.97 -x- Halls of Origination/1 49.91,93.73 {autotype:portal_dungeon}",
			
		-- LOST CITY OF THE TOL'VIR
			"Uldum 60.55,64.32 -x- Lost City of the Tol'vir 31.78,16.78 {autotype:portal_dungeon}",



	----------------------------
	---   EASTERN KINGDOMS   ---
	----------------------------

		--Scholomance
			"Western Plaguelands 69.1,72.9 -x- Scholomance/1 18.1,60.9 {autotype:portal_dungeon}",
		
		-- STRATHOLME: MAIN GATE
			"Eastern Plaguelands/0 27.61,11.63 -x- Stratholme/1 68.02,88.46 {autotype:portal_dungeon}",
			"Eastern Plaguelands/0 26.51,11.67 -x- Stratholme/1 64.46,88.52 {autotype:portal_dungeon}",
			
		-- STRATHOLME: SERVICE ENTRACE
			"Eastern Plaguelands/0 43.82,17.42 -x- Stratholme/2 67.74,86.29 {autotype:portal_dungeon}",
			
		--SUNKEN TEMPLE
			"Swamp of Sorrows/0 69.33,55.62 <title:Enter the building>",
			"@+ -x- Swamp of Sorrows/0 70.10,51.03 <dark:1> <onlyhardwire:1> <title:Run down the stairs>",
			"@+ -x- Swamp of Sorrows/0 70.54,48.47 <radius:15> <dark:1> <onlyhardwire:1> <title:Swim under the water>",
			"@+ -x- Swamp of Sorrows/0 70.94,45.95 <radius:15> <dark:1> <onlyhardwire:1> <title:Continue swimming>",
			"@+ -x- Swamp of Sorrows/0 71.57,43.49 <dark:1> <onlyhardwire:1> <title:Follow the path>",
			"@+ -x- Swamp of Sorrows/0 72.89,43.97 <dark:1> <onlyhardwire:1> <title:Follow the stairs down>",
			"@+ -x- Swamp of Sorrows/0 73.94,44.38 <dark:1> <onlyhardwire:1> <title:Follow the path>",
			"@+ -x- Swamp of Sorrows/0 75.00,45.44 <dark:1> <onlyhardwire:1> <title:Continue following the path>",
			"@+ -x- Swamp of Sorrows/0 76.09,45.25 <dark:1> <onlyhardwire:1> <title:Go through the portal>",
			"@+ -x- The Temple of Atal'Hakkar/1 0.00,0.00 {autotype:portal_dungeon}",

		--Scarlet Halls
			"Tirisfal Glades/13 78.5,58.2 -x- Scarlet Halls/1 34.3,90.1 {autotype:portal_dungeon}",
			
		--Scarlet Monastery
			"Tirisfal Glades/13 69.4,25.1 -x- Scarlet Monastery/1 75.7,45.8 {autotype:portal_dungeon}",

		-- ZUL'GURUB
			"Northern Stranglethorn 72.18,32.91 -x- Zul'Gurub 30.23,48.85 {autotype:portal_dungeon}",
			
		-- ZUL'AMAN
			"Ghostlands 82.28,64.3 -x- Zul'Aman 7.32,52.97 {autotype:portal_dungeon}",

		-- DEADMINES
			"Westfall/17 50.94,64.98",
			"@+ -x- Westfall/17 25.8,51.1 <dark:1> <nofly:1> <radius:10> ",
			"@+ -x- The Deadmines/1 26.5,13.4 {autotype:portal_dungeon}",
			"The Deadmines/2 96.17,51.66 -to- Westfall/0 41.15,83.19 <style:portal_dungeon>",
			
		-- SHADOWFANG KEEP
			"Silverpine Forest 44.75,67.79 -x- Shadowfang Keep 69.46,60.97 {autotype:portal_dungeon}",
			
		-- THE STOCKADE
			"Stormwind City 50.42,66.31 -x- The Stockade 50.07,68.09 {autotype:portal_dungeon}",

		-- GNOMEREGAN
			"Dun Morogh/10 30.0,74.7 -x- Gnomeregan 64.33,28.96 {autotype:portal_dungeon}",
			
		-- ULDAMAN
			"Badlands/18 36.7,30.1 -x- Uldaman 67.03,72.71 {autotype:portal_dungeon}",

		-- BLACKROCK DEPTHS
			"Burning Steppes/16 40,17 -x- Blackrock Depths 34.70,77.80 {autotype:portal_dungeon}",
			
		-- BLACKROCK CAVERNS
			"Burning Steppes/15 70.0,53.3 -x- Blackrock Caverns 32.02,70.10 {autotype:portal_dungeon}",
			
		-- LOWER BLACKROCK SPIRE
			"Burning Steppes/14 80.4,41.3 -x- Blackrock Spire/4 37.9,43.3 {autotype:portal_dungeon}",
			
		-- UPPER BLACKROCK SPIRE
			"Burning Steppes/14 79.0,34.0 -x- Upper Blackrock Spire 2/1 37.2,32.5 {autotype:portal_dungeon}",

		-- MAGISTERS' TERRACE
			"Isle of Quel'Danas 61.28,30.92 -x- Magisters' Terrace/2 42.53,90.01 {autotype:portal_dungeon}",
			"Magisters' Terrace/1 4.63,50.20 -to- Isle of Quel'Danas/0 47.10,30.69 {mode:PORTAL}",
			
		-- GRIM BATOL
			"Twilight Highlands 19.14,53.84 -x- Grim Batol 12.15,55.67 {autotype:portal_dungeon}",

		

-----------------------------------
---   RAID ENTRANCES & EXITS    ---
-----------------------------------

	--------------------
	---   KALIMDOR   ---
	--------------------
		-- Temple of Ahn'Qiraj
			"Ahn'Qiraj: The Fallen Kingdom/0 46.78,7.45 -x- Ahn'Qiraj/2 52.00,26.92 {autotype:portal_dungeon}",
			
		-- Ruins of Ahn'Qiraj
			"Ahn'Qiraj: The Fallen Kingdom/0 58.92,14.29 -x- Ruins of Ahn'Qiraj/0 60.51,11.70 {autotype:portal_dungeon}",
			
			
	
	----------------------------
	---   EASTERN KINGDOMS   ---
	----------------------------
		--Molten Core
			"Blackrock Depths/2 68.8,38.2 -x- Molten Core/1 26.6,25.0 <subtype:portaldungeon>",
			"Molten Core/1 26.5,24.3 -x- Burning Steppes/16 54.1,83.1 <subtype:portaldungeon>",
			"Burning Steppes/16 54.1,83.1 -x- Molten Core/1 26.5,24.3 {autotype:portal_dungeon}",
			
		--Blackwing Lair
			"Blackrock Spire/7 54.7,22.5 -x- Blackwing Lair/1 52.5,83.6 <subtype:portaldungeon>",
			"Blackwing Lair/1 52.5,83.6 -x- Burning Steppes/14 65.6,42.2 <subtype:portaldungeon>",
			"Burning Steppes/14 64.3,70.9 -x- Blackwing Lair/1 52.5,83.6 {autotype:portal_dungeon}",	
--]]
}








data.basenodes.DungeonFloors = {
	-- Dungeons

		--Kalimdor
			["Maraudon"] = { --
				"Maraudon/1 15.53,56.75 -x- Maraudon/2 28.99,4.84",
			},
			["Blackfathom Deeps"] = {
				"Blackfathom Deeps/1 61.51,71.88 -x- Blackfathom Deeps/2 39.21,31.65",
				"Blackfathom Deeps/2 47.24,79.12 -x- Blackfathom Deeps/3 43.60,61.06",
			},
			["Dire Maul"] = { -- Can't move between wings so limits the borders.
				"Dire Maul/2 39.22,34.98 -x- Dire Maul/3 56.27,24.42",
				"Dire Maul/2 31.69,72.04 -x- Dire Maul/3 48.30,74.24",
				"Dire Maul/2 20.79,19.09 -x- Dire Maul/3 44.12,13.38",
				"Dire Maul/2 29.47,42.67 -x- Dire Maul/4 75.94,39.95",
				"Dire Maul/5 46.43,63.58 -x- Dire Maul/6 61.27,82.67",
			},
			["End Time"] = { -- End Time
			-- End Time teleporters
				"End Time/1 79.76,45.52		<name:Entryway of Time>		<subtype:teleportnamed>	@et1",
				"End Time/2 41.88,80.19		<name:Azure Dragonshrine>	<subtype:teleportnamed>	@et2",
				"End Time/3 34.34,43.19		<name:Ruby Dragonshrine>	<subtype:teleportnamed>	@et3",
				"End Time/4 75.23,62.82		<name:Obsidium Dragonshrine>	<subtype:teleportnamed>	@et4",
				"End Time/5 46.10,21.40		<name:Emerald Dragonshrine>	<subtype:teleportnamed>	@et5",
				"End Time/6 35.40,79.14		<name:Bronze Dragonshrine>	<subtype:teleportnamed>	@et6",

				"@et1 -x- @et2 {mode:PORTAL}",
				"@et1 -x- @et3 {mode:PORTAL}", "@et2 -x- @et3 {mode:PORTAL}",
				"@et1 -x- @et4 {mode:PORTAL}", "@et2 -x- @et4 {mode:PORTAL}", "@et3 -x- @et4 {mode:PORTAL}",
				"@et1 -x- @et5 {mode:PORTAL}", "@et2 -x- @et5 {mode:PORTAL}", "@et3 -x- @et5 {mode:PORTAL}", "@et4 -x- @et5 {mode:PORTAL}",
				"@et1 -x- @et6 {mode:PORTAL}", "@et2 -x- @et6 {mode:PORTAL}", "@et3 -x- @et6 {mode:PORTAL}", "@et4 -x- @et6 {mode:PORTAL}", "@et5 -x- @et6 {mode:PORTAL}",

			},
			["Halls of Origination"] = {
				"Halls of Origination/1 89.7,49.8 -x- Halls of Origination/2 24.9,49.4",
				"Halls of Origination/1 67.5,52.6 -x- Halls of Origination/2 66.7,48.5",
				"Halls of Origination/1 66.5,48.3 -x- Halls of Origination/3 45.9,47.6",
			},
			["The Culling of Stratholme"] = {
				"The Culling of Stratholme/1 47.47,32.24 -x- The Culling of Stratholme/2 50.63,92.88",
			},
			["Ahn'Qiraj"] = {
				"Ahn'Qiraj/1 34.6,45.0 -x- Ahn'Qiraj/3 66.4,46.3",
				"Ahn'Qiraj/1 33.0,52.4 -x- Ahn'Qiraj/3 50.5,73.0",
				"Ahn'Qiraj/2 49.2,63.3 -x- Ahn'Qiraj/3 47.5,29.3",
			},
			["Dragon Soul"] = {
				"Dragon Soul/1 49.16,59.04 <subtype:dragonrider> -to- Dragon Soul/2 32.66,45.49 {mode:PORTAL}",
				"Dragon Soul/2 22.98,40.36 -to- Dragon Soul/1 50.25,59.76 {mode:PORTAL}",
				"Dragon Soul/1 51.29,59.31 <subtype:dragonrider> -to- Dragon Soul/3 55.38,79.72 {mode:PORTAL}",
				"Dragon Soul/3 57.76,88.77 -to- Dragon Soul/1 50.25,59.76 {mode:PORTAL}",
				"Dragon Soul/1 50.70,60.63 -x- Dragon Soul/4 52.42,14.22 {mode:PORTAL}", --portal from top
				"Dragon Soul/7 31.93,82.91 -to- Dragon Soul/1 50.25,59.76 {mode:PORTAL}",
			},

		--Eastern Kingdom
			["The Deadmines"] = {
				-- TODO there are teleporters in DM that could/should be added. Only useful if you die and need to get back to where you were.
				"The Deadmines/1 65.48,60.02 -x- The Deadmines/2 16.97,88.45",
			},
			["Uldaman"] = {
				"Uldaman/1 46.08,9.57 -x- Uldaman/2 64.77,43.35",
			},
			["Shadowfang Keep"] = {
				"Shadowfang Keep/1 38.18,39.14 -x- Shadowfang Keep/2 60.03,13.01",
				"Shadowfang Keep/1 14.78,88.35 -x- Shadowfang Keep/2 27.49,87.84",
				"Shadowfang Keep/1 34.01,70.58 -x- Shadowfang Keep/7 23.69,75.12",
				"Shadowfang Keep/7 45.49,25.23 -to- Shadowfang Keep/3 44.44,61.70",
				"Shadowfang Keep/3 60.72,31.88 -to- Shadowfang Keep/7 47.37,19.47",
				"Shadowfang Keep/3 45.86,92.67 -x- Shadowfang Keep/4 48.93,77.89",
				"Shadowfang Keep/4 34.60,55.37 -x- Shadowfang Keep/5 48.94,77.32",
				"Shadowfang Keep/5 56.86,44.93 -to- Shadowfang Keep/4 54.68,54.74",
				"Shadowfang Keep/5 34.62,57.88 -x- Shadowfang Keep/6 48.75,90.71",
			},
			["Stratholme"] = {
			},
			["Scholomance"] = {
				"Scholomance/1 81.8,23.9 -x- Scholomance/2 76.0,26.5",
				"Scholomance/2 57.5,92.2 -x- Scholomance/3 49.7,19.2",
				"Scholomance/3 49.8,24.0 -x- Scholomance/4 49.6,28.2",
			},
			["Scarlet Monastery"] = {
				"Scarlet Monastery/1 48.4,88.5 -x- Scarlet Monastery/2 49.1,11.2",
			},
			["Scarlet Halls"] = {
				"Scarlet Halls/1 55.5,13.8 -x- Scarlet Halls/2 47.8,91.1",
			},
			["Gnomeregan"] = {
				"Gnomeregan/1 57.67,50.98 -to- Gnomeregan/2 81.36,46.02",
				"Gnomeregan/1 47.05,86.94 -x- Gnomeregan/2 75.38,74.06",
				"Gnomeregan/1 34.33,61.78 -x- Gnomeregan/2 61.73,61.55",
				"Gnomeregan/2 35.21,88.08 -x- Gnomeregan/3 38.60,50.33",
				"Gnomeregan/3 48.26,71.95 -x- Gnomeregan/4 71.25,77.54",
			},
			["Blackrock Spire"]= {
				"Blackrock Spire/1 66.1,51.1 -x- Blackrock Spire/3 66.0,49.2",
				"Blackrock Spire/3 58.4,47.7 -x- Blackrock Spire/1 56.7,48.3",
				"Blackrock Spire/2 64.8,70.9 -x- Blackrock Spire/1 59.8,70.2",
				"Blackrock Spire/2 59.5,59.3 -x- Blackrock Spire/1 59.4,63.9",
				"Blackrock Spire/2 53.2,52.8 -x- Blackrock Spire/3 57.0,51.2",
				"Blackrock Spire/3 49.9,74.1 -x- Blackrock Spire/2 51.1,74.2",
				"Blackrock Spire/3 46.5,65.8 -x- Blackrock Spire/4 45.1,59.5",
				"Blackrock Spire/4 47.2,42.7 -x- Blackrock Spire/3 55.1,37.6",
				"Blackrock Spire/4 37.2,34.2 -x- Blackrock Spire/5 37.1,32.1",
				"Blackrock Spire/5 33.3,13.3 -x- Blackrock Spire/6 30.4,18.7",
				--"Blackrock Spire/6 29.0,41.4 -x- Blackrock Spire/7 28.4,36.1", -- bfa alpha, cannot find map for floor 7, on live it is... somewhere, but not within BRS
				--"Blackrock Spire/7 30.7,42.7 -to- Blackrock Spire/6 30.6,41.6", --cliff
				--"Blackrock Spire/7 36.4,43.3 -to- Blackrock Spire/6 36.1,41.3",
			},
			["Blackrock Caverns"] = {
				"Blackrock Caverns/1 52.05,20.12 -to- Blackrock Caverns/2 29.97,17.32",
				"Blackrock Caverns/1 49.93,12.98 -x- Blackrock Caverns/2 29.37,13.13",
			},

	--Raids

		-- Old world
			["Karazhan"] = {
				"Karazhan/1 38.3,78.6 -x- Karazhan/2 29.1,80.8",
				"Karazhan/2 38.6,14.1 -x- Karazhan/3 39.8,81.7",
				"Karazhan/1 53.1,64.1 -x- Karazhan/3 52.5,91.3",
				"Karazhan/3 67.0,42.4 -x- Karazhan/4 67.9,42.9",
				"Karazhan/1 37.6,12.8 -x- Karazhan/4 47.2,29.1",
				"Karazhan/4 23.5,49.2 -x- Karazhan/5 45.4,83.7",
				"Karazhan/5 67.9,26.5 -x- Karazhan/6 41.4,13.3",
				"Karazhan/6 64.9,69.2 -x- Karazhan/7 73.2,65.3",
				"Karazhan/8 51.8,58.3 -x- Karazhan/9 61.5,19.2",
				"Karazhan/9 31.0,66.3 -x- Karazhan/10 30.9,59.9",
				"Karazhan/10 37.1,23.1 -x- Karazhan/11 64.0,26.8",
				"Karazhan/10 58.8,56.0 -x- Karazhan/12 47.0,56.0",
				"Karazhan/12 25.9,61.3 -x- Karazhan/13 53.8,78.5",
				"Karazhan/12 39.6,18.8 -x- Karazhan/14 20.6,81.3",
				"Karazhan/14 83.2,57.1 -x- Karazhan/15 82.3,69.8",
				"Karazhan/15 83.2,75.5 -x- Karazhan/16 71.9,70.5",
				"Karazhan/16 66.2,79.3 -x- Karazhan/17 50.9,91.1",
			},
			["Blackwing Lair"] = {
				"Blackwing Lair/1 45.4,27.7 -x- Blackwing Lair/2 49.7,36.0",
				"Blackwing Lair/1 37.6,11.2 -x- Blackwing Lair/2 44.0,22.9",
				"Blackwing Lair/2 49.4,80.3 -x- Blackwing Lair/3 57.0,87.2",
				"Blackwing Lair/3 31.0,37.5 -x- Blackwing Lair/4 22.0,60.9",
			},
			["Blackrock Depths"] = {
				"Blackrock Depths/1 40.7,67.1 -x- Blackrock Depths/2 41.8,92.4",
				"Blackrock Depths/1 67.0,26.3 -x- Blackrock Depths/2 64.9,57.1",
				"Blackrock Depths/1 59.8,30.9 -x- Blackrock Depths/2 59.9,60.1",
				"Blackrock Depths/1 58.7,34.4 -x- Blackrock Depths/2 58.9,64.7",
				"Blackrock Depths/1 55.0,35.6 -x- Blackrock Depths/2 54.2,65.6",
				"Blackrock Depths/1 56.9,51.3 -x- Blackrock Depths/2 56.4,77.5",
				"Blackrock Depths/1 57.3,57.1 -x- Blackrock Depths/2 56.9,85.7",
				"Blackrock Depths/1 54.8,62.9 -x- Blackrock Depths/2 55.2,89.9",
				"Blackrock Depths/1 45.4,63.1 -x- Blackrock Depths/2 44.6,90.0",
				"Blackrock Depths/1 45.0,64.3 -x- Blackrock Depths/2 44.5,91.1",
				"Blackrock Depths/1 46.6,52.5 -x- Blackrock Depths/2 47.5,81.1",
				"Blackrock Depths/1 42.5,46.3 -x- Blackrock Depths/2 42.3,73.6",
				"Blackrock Depths/1 41.6,39.1 -x- Blackrock Depths/2 41.4,68.1",
				"Blackrock Depths/1 53.0,31.8 -x- Blackrock Depths/2 53.0,61.5",
				"Blackrock Depths/1 54.0,27.0 -x- Blackrock Depths/2 53.2,55.6",
			},
			["Naxxramas"] = {
				"Naxxramas/1 68.6,77.7 -x- Naxxramas/5 51.6,47.1",
				"Naxxramas/2 30.7,77.9 -x- Naxxramas/5 55.0,47.1",
				"Naxxramas/3 66.9,21.9 -x- Naxxramas/5 51.7,52.2",
				"Naxxramas/4 32.9,22.4 -x- Naxxramas/5 55.2,52.5",
				"Naxxramas/5 53.5,50.1 -to- Naxxramas/6 73.6,72.8",
				"Naxxramas/6 74.6,73.2 -to- Naxxramas/5 51.3,49.7",
			},
			["Blackwing Descent"] = {
				"Blackwing Descent/1 46.9,42.1 -x- Blackwing Descent/2 47.4,89.8",
			},
			["The Bastion of Twilight"] = {
				"The Bastion of Twilight/1 53.6,85.1 -x- The Bastion of Twilight/2 55.0,6.2",
			},

		--Outlands
			["The Steamvault"]={
				"The Steamvault/1 49.85,29.26 -x- The Steamvault/2 51.23,28.93",
				"The Steamvault/1 51.38,27.47 -to- The Steamvault/2 51.48,29.20",
				"The Steamvault/1 48.01,77.81 -x- The Steamvault/2 46.24,79.55",
				"The Steamvault/1 36.64,73.70 -to- The Steamvault/2 35.59,72.57",
			},
			["The Mechanar"]={
				"The Mechanar/1 41.73,22.82 -x- The Mechanar/2 41.77,31.54",
			},
			["The Arcatraz"]={
				"The Arcatraz/1 65.11,35.34 -x- The Arcatraz/2 89.26,43.76",
				"The Arcatraz/2 36.51,57.12 -x- The Arcatraz/3 26.97,88.52",
			},
			["Sethekk Halls"]={
				"Sethekk Halls/1 48.71,95.13 -x- Sethekk Halls/2 53.33,94.35",
				"Sethekk Halls/2 44.61,27.42 -to- Sethekk Halls/1 51.57,27.55",
			},
			["Auchenai Crypts"]={
				"Auchenai Crypts/1 44.67,17.68 -x- Auchenai Crypts/2 22.77,12.22",
			},
			["Black Temple"]={
				"Black Temple/2 29.58,19.61 -x- Black Temple/1 28.02,74.29",
				"Black Temple/1 63.09,45.70 -x- Black Temple/3 24.31,50.07",
				"Black Temple/3 58.48,91.11 -x- Black Temple/5 66.89,68.26",
				"Black Temple/3 26.28,21.71 -x- Black Temple/6 8.40,59.62",
				"Black Temple/6 67.17,51.10 -x- Black Temple/7 69.01,16.15",
				"Black Temple/7 46.72,35.00 -x- Black Temple/8 52.69,20.84",
				"Black Temple/3 61.32,34.65 -x- Black Temple/4 64.35,39.46",
			},
			["Magisters' Terrace"]={
				"Magisters' Terrace/2 82.88,44.83 -x- Magisters' Terrace/1 83.15,55.44",
			},

		--Northrend
			["The Oculus"] = {
				"The Oculus/1 38.45,50.96 -x- The Oculus/1 47.89,69.3 <subtype:portalclick> {mode:PORTAL}",
			},
			["Utgarde Keep"] = {
				"Utgarde Keep/1 48.5,84.7 -x- Utgarde Keep/2 34.8,64.5",
				"Utgarde Keep/2 53.5,25.3 -x- Utgarde Keep/3 33.1,40.7",
			},
			["Utgarde Pinnacle"] = {
				"Utgarde Pinnacle/1 31.1,75.0 -x- Utgarde Pinnacle/2 42.3,76.6",
				"Utgarde Pinnacle/1 45.9,82.6 -x- Utgarde Pinnacle/2 54.2,79.1",
				"Utgarde Pinnacle/1 54.7,18.0 -x- Utgarde Pinnacle/2 59.6,34.1",
			},
			["Halls of Lightning"] = {
				"Halls of Lightning/1 89.0,53.8 -x- Halls of Lightning/2 57.0,21.3",
			},
			["Azjol-Nerub"] = {
				"Azjol-Nerub/2 41.0,37.3 -x- Azjol-Nerub/3 70.6,31.6",
				"Azjol-Nerub/2 50.3,60.4 -to- Azjol-Nerub/1 22.0,50.7",
			},
			["Drak'Tharon Keep"] = {
				"Drak'Tharon Keep/1 64.4,71.6 -x- Drak'Tharon Keep/2 50.5,71.5",
			},
			["Ulduar"] = {
				-- floor 6 is part of a boss encounter.
				"Ulduar/2 37.24,1.35 -x- Ulduar/3 54.09,78.14",
				"Ulduar/2 36.72,0.61 -x- Ulduar/3 48.21,77.34",
				"Ulduar/3 30.33,74.84 -x- Ulduar/4 35.36,52.21",

				-- Ulduar teleporters
					"Ulduar/1 50.98,85.54 <name:Expedition Base Camp>	<subtype:teleportnamed>	@uld10",
					"Ulduar/1 49.24,47.34 <name:Formation Grounds>		<subtype:teleportnamed>	@uld11",
					"Ulduar/1 48.54,28.08 <name:Colossal Forge>		<subtype:teleportnamed>	@uld12",
					"Ulduar/1 48.51,11.06 <name:Scrapyard>			<subtype:teleportnamed>	@uld13",
					"Ulduar/2 37.32,00.52 <name:Antechamber of Ulduar>	<subtype:teleportnamed>	@uld20",
					"Ulduar/2 37.10,76.41 <name:Shattered Walkway>		<subtype:teleportnamed>	@uld21",
					"Ulduar/3 51.02,54.02 <name:Conservatory of Life>	<subtype:teleportnamed>	@uld30",
					"Ulduar/4 66.60,59.98 <name:Prison of Yogg-Saron>	<subtype:teleportnamed>	@uld40",
					"Ulduar/5 43.65,62.19 <name:Spark of Imagination>	<subtype:teleportnamed>	@uld50",

				"@uld10 -x- @uld11 {mode:PORTAL}",
				"@uld10 -x- @uld12 {mode:PORTAL}", "@uld11 -x- @uld12 {mode:PORTAL}",
				"@uld10 -x- @uld13 {mode:PORTAL}", "@uld11 -x- @uld13 {mode:PORTAL}", "@uld12 -x- @uld13 {mode:PORTAL}",
				"@uld10 -x- @uld20 {mode:PORTAL}", "@uld11 -x- @uld20 {mode:PORTAL}", "@uld12 -x- @uld20 {mode:PORTAL}", "@uld13 -x- @uld20 {mode:PORTAL}",
				"@uld10 -x- @uld21 {mode:PORTAL}", "@uld11 -x- @uld21 {mode:PORTAL}", "@uld12 -x- @uld21 {mode:PORTAL}", "@uld13 -x- @uld21 {mode:PORTAL}", "@uld20 -x- @uld21 {mode:PORTAL}",
				"@uld10 -x- @uld30 {mode:PORTAL}", "@uld11 -x- @uld30 {mode:PORTAL}", "@uld12 -x- @uld30 {mode:PORTAL}", "@uld13 -x- @uld30 {mode:PORTAL}", "@uld20 -x- @uld30 {mode:PORTAL}", "@uld21 -x- @uld30 {mode:PORTAL}",
				"@uld10 -x- @uld40 {mode:PORTAL}", "@uld11 -x- @uld40 {mode:PORTAL}", "@uld12 -x- @uld40 {mode:PORTAL}", "@uld13 -x- @uld40 {mode:PORTAL}", "@uld20 -x- @uld40 {mode:PORTAL}", "@uld21 -x- @uld40 {mode:PORTAL}", "@uld30 -x- @uld40 {mode:PORTAL}",
				"@uld10 -x- @uld50 {mode:PORTAL}", "@uld11 -x- @uld50 {mode:PORTAL}", "@uld12 -x- @uld50 {mode:PORTAL}", "@uld13 -x- @uld50 {mode:PORTAL}", "@uld20 -x- @uld50 {mode:PORTAL}", "@uld21 -x- @uld50 {mode:PORTAL}", "@uld30 -x- @uld50 {mode:PORTAL}", "@uld40 -x- @uld50 {mode:PORTAL}",
			},
			["Trial of the Crusader"] = {
				"Trial of the Crusader/1 51.4,52.4 -to- Trial of the Crusader/2 52.5,73.5",
			},
			["Icecrown Citadel"] = {
				"Icecrown Citadel/1 39.07,85.75 -x- Icecrown Citadel/2 45.60,84.81",
				"Icecrown Citadel/2 45.62,73.77 -x- Icecrown Citadel/3 51.33,83.92",
				"Icecrown Citadel/3 51.85,19.20 -x- Icecrown Citadel/5 51.85,83.82",
				"Icecrown Citadel/4 36.48,89.98 -x- Icecrown Citadel/5 76.71,91.90",
				"Icecrown Citadel/4 50.50,33.31 -x- Icecrown Citadel/5 85.91,53.55",
				"Icecrown Citadel/5 60.68,17.31 -x- Icecrown Citadel/6 78.82,31.45",
				"Icecrown Citadel/5 43.44,16.66 -x- Icecrown Citadel/6 23.19,30.52",
				"Icecrown Citadel/5 52.35,53.69 -x- Icecrown Citadel/7 49.85,39.13",
				"Icecrown Citadel/6 50.65,69.26 -to- Icecrown Citadel/5 51.82,32.29",

				-- ICC teleporters
					"Icecrown Citadel/1 38.98,17.17   <name:Light's Hammer>		<subtype:teleportnamed>	@icc10",
					"Icecrown Citadel/1 38.98,71.11   <name:Oratory of the Damned>	<subtype:teleportnamed>	@icc11",
					"Icecrown Citadel/2 45.60,80.43   <name:Rampart of Skulls>	<subtype:teleportnamed>	@icc20",
					"Icecrown Citadel/3 51.50,76.26   <name:Deathbringer's Rise>	<subtype:teleportnamed>	@icc30",
					"Icecrown Citadel/4 26.11,33.30   <name:Sindragosa's Lair>	<subtype:teleportnamed>	@icc40",
					"Icecrown Citadel/5 51.87,74.32   <name:Upper Spire>		<subtype:teleportnamed>	@icc50",

				"@icc10 -x- @icc11 {mode:PORTAL}",
				"@icc10 -x- @icc20 {mode:PORTAL}", "@icc11 -x- @icc20 {mode:PORTAL}",
				"@icc10 -x- @icc30 {mode:PORTAL}", "@icc11 -x- @icc30 {mode:PORTAL}", "@icc20 -x- @icc30 {mode:PORTAL}",
				"@icc10 -x- @icc40 {mode:PORTAL}", "@icc11 -x- @icc40 {mode:PORTAL}", "@icc20 -x- @icc40 {mode:PORTAL}", "@icc30 -x- @icc40 {mode:PORTAL}",
				"@icc10 -x- @icc50 {mode:PORTAL}", "@icc11 -x- @icc50 {mode:PORTAL}", "@icc20 -x- @icc50 {mode:PORTAL}", "@icc30 -x- @icc50 {mode:PORTAL}", "@icc40 -x- @icc50 {mode:PORTAL}",
			},

		--Maelstrom
			["Throne of the Tides"] = {
				"Throne of the Tides/1 48.9,82.1 -x- Throne of the Tides/2 51.0,53.0",
				"Throne of the Tides/1 50.0,39.7 -x- Throne of the Tides/2 50.0,90.1",
			},

		--Pandaria
			["Stormstout Brewery"] = {
				"Stormstout Brewery/1 28.1,61.1 -x- Stormstout Brewery/2 32.8,59.2",
				"Stormstout Brewery/2 81.5,58.5 -x- Stormstout Brewery/3 33.8,77.9",
				"Stormstout Brewery/3 75.5,33.5 -x- Stormstout Brewery/4 57.6,31.1",
			},
			["Siege of Niuzao Temple"] = {
				"Siege of Niuzao Temple/1 50.3,73.9 -x- Siege of Niuzao Temple/3 21.6,53.6",
				"Siege of Niuzao Temple/2 53.2,81.9 -x- Siege of Niuzao Temple/3 57.1,80.7",
			},
			["Mogu'shan Palace"] = {
				"Mogu'shan Palace/1 49.0,67.0 -x- Mogu'shan Palace/2 55.8,18.9",
				"Mogu'shan Palace/2 71.5,76.2 -x- Mogu'shan Palace/3 58.8,24.3",
			},
			["Temple of the Jade Serpent"] = {
				"Temple of the Jade Serpent/1 27.4,62.7 -x- Temple of the Jade Serpent/2 39.0,22.0",
				"Temple of the Jade Serpent/1 27.0,68.7 -x- Temple of the Jade Serpent/2 46.6,42.5",
			},
			["Shado-Pan Monastery"] = {
				"Shado-Pan Monastery/1 56.0,88.0 -x- Shado-Pan Monastery/2 21.0,85.6",
				"Shado-Pan Monastery/1 36.5,81.8 -x- Shado-Pan Monastery/3 76.9,81.4",
				"Shado-Pan Monastery/1 22.1,69.1 -x- Shado-Pan Monastery/3 12.3,19.2",
				"Shado-Pan Monastery/1 30.7,35.0 -x- Shado-Pan Monastery/4 17.0,72.6",
				"Shado-Pan Monastery/1 44.7,40.1 -x- Shado-Pan Monastery/4 51.3,83.9",
			},
			["Gate of the Setting Sun"] = {
				"Gate of the Setting Sun/1 46.3,33.1 -x- Gate of the Setting Sun/2 50.0,50.8",
			},
			["Mogu'shan Vaults"] = {
				"Mogu'shan Vaults/1 32.2,13.5 -x- Mogu'shan Vaults/2 77.8,81.1",
				"Mogu'shan Vaults/2 28.7,52.1 -x- Mogu'shan Vaults/3 65.7,10.6",
			},
			["Heart of Fear"] = {
				"Heart of Fear/1 32.1,16.3 -x- Heart of Fear/2 66.3,27.2",
			},
			["Sunwell Plateau"] = {
				"Sunwell Plateau/1 67.2,27.3 -x- Sunwell Plateau/2 52.7,14.1",
			},
			["The Bastion of Twilight"] = {
				"The Bastion of Twilight/1 53.7,85.2 -x- The Bastion of Twilight/2 55.1,5.5",
				"The Bastion of Twilight/2 69.8,74.8 -to- The Bastion of Twilight/3 54.8,65.5",
			},
			["Hour of Twilight"] = {
				"Hour of Twilight/1 49.3,81.7 -x- Hour of Twilight/2 49.3,83.0",
			},
			["Firelands"] = {
				"Firelands/1 49.7,1.0 -x- Firelands/3 52.3,81.9",
			},
			["Throne of Thunder"] = {
				"Throne of Thunder/1 83.4,79.6 -x- Throne of Thunder/2 14.8,78.9",
				"Throne of Thunder/2 72.90,20.01 -x- Throne of Thunder/3 20.70,82.15",
				"Throne of Thunder/3 73.1,53.2 -x- Throne of Thunder/4 21.9,21.1",
				"Throne of Thunder/4 34.0,59.0 -x- Throne of Thunder/5 80.2,7.8",
				"Throne of Thunder/5 46.64,22.87 -x- Throne of Thunder/6 20.44,64.75",
				"Throne of Thunder/6 88.13,74.91 -x- Throne of Thunder/7 45.97,10.54",
			},
			["Siege of Orgrimmar"] = {
				"Siege of Orgrimmar/1 44.7,69.2 -x- Siege of Orgrimmar/3 64.6,12.7",
				"Siege of Orgrimmar/2 11.7,71.9 -x- Siege of Orgrimmar/1 26.4,9.8",
				"Siege of Orgrimmar/1 28.5,9.7 -x- Siege of Orgrimmar/2 11.7,71.8",
				"Siege of Orgrimmar/4 34.8,21.6 -x- Siege of Orgrimmar/5 51.7,76.9",
				"Siege of Orgrimmar/5 56.3,29.1 -x- Siege of Orgrimmar/6 80.7,16.3",
				"Siege of Orgrimmar/6 67.9,50.1 -x- Siege of Orgrimmar/7 31.1,20.3",
				"Siege of Orgrimmar/8 78.6,73.6 -x- Siege of Orgrimmar/9 64.0,17.8",
				"Siege of Orgrimmar/8 89.4,62.3 -x- Siege of Orgrimmar/10 23.7,82.3",
				"Siege of Orgrimmar/8 87.7,76.4 -x- Siege of Orgrimmar/11 32.0,14.8",
				"Siege of Orgrimmar/11 65.2,91.5 -x- Siege of Orgrimmar/12 53.7,13.5",
			},

		--Draenor

			-- Draenor raids go here

		--------------------------------
		---  COURT OF STARS DUNGEON  ---
		--------------------------------
		["Court of Stars"] = {
			"Court of Stars/1 63.36,65.91 <radius:15> -x- Court of Stars/2 38.42,40.67 <radius:15>"..
				"{template:building}",

			"Court of Stars/2 47.80,39.54 <radius:15> -x- Court of Stars/3 54.76,53.74 <radius:15>"..
				"{title_atob:Run up the stairs} {title_btoa:Run down the stairs}",



		},
		---- Scenarios -----
		----------------------------
		---  STORMHEIM INVASION  ---
		----------------------------
		["Stormheim Invasion"] = {
			"Stormheim Invasion/1 40.73,43.58 <radius:10> -x- Stormheim Invasion/2 44.02,34.65 <radius:15>"..
			"{title_atob:Follow the path down} {title_btoa:Follow the path up}",
		},

		-------------------------------
		---  HIGHMOUNTAIN INVASION  ---
		-------------------------------
		["Highmountain Invasion"] = {
			"Highmountain Invasion/1 33.73,36.75 <radius:10> -x- Highmountain Invasion/2 38.80,28.00 <radius:15>"..
			"{title_atob:Follow the path down} {title_btoa:Follow the path up}",
		},

		----------------------------
		--- BATTLE OF DAZAR'ALOR ---
		----------------------------
		["Battle of Dazar'alor"] = {
			"Battle of Dazar'alor/0 49.09,11.84 <radius:15> -x- Battle of Dazar'alor/1 42.14,86.65 <radius:15>",
			"Battle of Dazar'alor/1 33.37,8.70 <radius:15> -x- Battle of Dazar'alor/2 47.44,15.53 <radius:15>",
			"Battle of Dazar'alor/2 64.19,80.61 <radius:15> -x- Battle of Dazar'alor/3 64.82,70.72 <radius:15>",
			"Battle of Dazar'alor/3 36.14,58.85 <radius:15> -x- Battle of Dazar'alor/4 47.44,42.53 <radius:15>",
			"Battle of Dazar'alor/4 47.38,16.42 <radius:15> -x- Battle of Dazar'alor/5 48.93,75.17 <radius:15>",
		},
}

--[[
-- translate the flooring zone-folders from names to numbers
	local TEMP={}
	for zone,zonedata in pairs(data.basenodes.DungeonFloors) do
		if type(zone)~="number" then
			local id=data.MapIDsByName[zone]
			if type(id)=="table" then id=id[1] end
			if not id then error("Map "..zone.." has no ID!") end
			zone=id
		end
		TEMP[zone]=zonedata
	end
	data.basenodes.DungeonFloors=TEMP
--]]