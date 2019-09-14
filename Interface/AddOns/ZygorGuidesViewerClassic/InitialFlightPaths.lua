local function loadFlightPaths()
	if not ZGV.db.char.initialFlightPathsLoaded then
		local initialPaths = {
			["Human"] = {
				["Stormwind"] = true,
			},
			["Dwarf"] = {
				["Ironforge"] = true,
			},
			["NightElf"] = {
				["Rut'theran Village"] = true,
			},
			["Gnome"] = {
				["Ironforge"] = true,
			},
			["Orc"] = {
				["Orgrimmar"] = true,
			},
			["Scourge"] = { -- Undead
				["Undercity"] = true,
			},
			["Tauren"] = {
				["Thunder Bluff"] = true,
			},
			["Troll"] = {
				["Orgrimmar"] = true,
			},
		}
		
		local raceName, raceID = UnitRace("player")		
		if initialPaths[raceID] then
			for i,v in pairs(initialPaths[raceID]) do
				ZGV.db.char.taxis[i] = true
			end
			ZGV.db.char.initialFlightPathsLoaded = true
		else
			ZGV:Debug("Missing initial flight paths for race: "..raceID)
		end

		initialPaths = nil
	end
end

tinsert(ZGV.startups, {"InitialFlightPaths loading",loadFlightPaths})
