local name,addon = ...

addon.LibRoverData = addon.LibRoverData or {}
local data=addon.LibRoverData

data.version={
	nodes_version = 1,  -- Increase this when working on the nodes. Bake the connections using the Debug menu when you're done.
}

-- These are kept strictly unique. Make up bogus names if you need to.
-- If multiple numbers are given, then only the first one is used here; others are used by Pointer to define phasedMaps.

data.MapIDsByName = {

--World Zones
["Azeroth"] = {[0]=947},
["Eastern Kingdoms"]={[0]=1415},
["Kalimdor"]={[0]=1414},

-------------------------------------
-------    EASTERN KINGDOMS   -------
-------------------------------------

["Alterac Mountains"]={[0]=1416},
["Arathi Highlands"]={[0]=1417},
["Badlands"]={[0]=1418},
["Blasted Lands"]={[0]=1419},
["Burning Steppes"]={[0]=1428},
["Deadwind Pass"]={[0]=1430},
["Dun Morogh"]={[0]=1426},
["Duskwood"]={[0]=1431},
["Eastern Plaguelands"]={[0]=1423},
["Elwynn Forest"]={[0]=1429},
["Hillsbrad Foothills"]={[0]=1424},
["Ironforge"]={[0]=1455},
["Loch Modan"]={[0]=1432},
["Redridge Mountains"]={[0]=1433},
["Searing Gorge"]={[0]=1427},
["Silverpine Forest"]={[0]=1421},
["Stormwind City"]={[0]=1453},
["Stranglethorn Vale"]={[0]=1434},
["Swamp of Sorrows"]={[0]=1435},
["The Hinterlands"]={[0]=1425},
["Tirisfal Glades"]={[0]=1420},
["Undercity"]={[0]=1458},
["Western Plaguelands"]={[0]=1422},
["Westfall"]={[0]=1436},
["Wetlands"]={[0]=1437},

--Kalimdor
["Ashenvale"]={[0]=1440},
["Azshara"]={[0]=1447},
["Darkshore"]={[0]=1439},
["Darnassus"]={[0]=1457},
["Desolace"]={[0]=1443},
["Durotar"]={[0]=1411},
["Dustwallow Marsh"]={[0]=1445},
["Felwood"]={[0]=1448},
["Feralas"]={[0]=1444},
["Moonglade"]={[0]=1450},
["Mulgore"]={[0]=1412},
["Orgrimmar"]={[0]=1454},
["Silithus"]={[0]=1451},
["Stonetalon Mountains"]={[0]=1442},
["Tanaris"]={[0]=1446},
["Teldrassil"]={[0]=1438},
["The Barrens"]={[0]=1413},
["Thousand Needles"]={[0]=1441},
["Thunder Bluff"]={[0]=1456},
["Un'Goro Crater"]={[0]=1449},
["Winterspring"]={[0]=1452},


--Battlegrounds
["Alterac Valley"]={[0]=1459},
["Arathi Basin"]={[0]=1461},
["Warsong Gulch"]={[0]=1460},

--Instanced Zones/Misc
["Eastern Kingdoms B"]={[0]=1463},
["Kalimdor B"]={[0]=1464},

}

data.MapNamesByID = {}
data.FloorByID = {}
data.MapGroupIDs = {}
for mapname,mapdata in pairs(data.MapIDsByName) do 
	for floornum,floormap in pairs(mapdata) do
		if floornum~="default" then
			data.MapNamesByID[floormap] = {mapname,floornum}
			data.FloorByID[floormap] = floornum
			data.MapGroupIDs[floormap] = mapname
		end
	end
end



-- /run D={}  for i=1,1000 do pcall(EJ_SelectInstance,i) local _, _, _, _, _, _, dungeonMapId, _ = EJ_GetInstanceInfo()  D[dungeonMapId or 0]=true end  ZGV:ShowDump(ZGV:Serialize(D),"")
-- This is used by |goto implementation to detect which maps cannot be positioned anymore.
data.DungeonMaps = {
  [934] = true,
}


--[[
	YE OLDE HELP TEXT

	Okay, to clarify, there's multiple ways to write a map link now. It's a mess, but it works.

	The first, simplest way, is two nodes linked, written in plain text (let's hope they're accessible by some means):
		"First Zone/2 11.22,33.44 -x- Second Zone/3 55.66,77.88",

	The "-x-" means it's a crossing, two-way. You can use "-to-" to make a one-way link.


	NODE NAMES:

	Adding @something after the node coordinates gives the node a name, for later reuse.
		"Stormwind 11.22,33.44 -x- Elwynn Forest 55.66,77.88 @stormgate",
		"Elwynn 77.77,66.66 -x- @stormgate",

	You can also use @+ to indicate the last node created or mentioned, whether it was named or not.
		"Stormwind 11.22,33.44 -x- Elwynn Forest 55.66,77.88",
		"@+ -x- Elwynn 77.77,66.66",

	This allows for easy chaining of nodes.


	ONE NODE?

	You can create just one node:
		"Solitary 11.1,22.2"

	This only makes sense if you @+ link to it later, or give it an explicit @name and refer to that.


	ADDITIONAL NODE DATA:

	Writing <field:value> after a node's coordinates assigns additional data.
		"Stormwind 11.1,22.2 <title:Watch out, dog poo> <radius:5>"

	Data fields include (among others):
		'title' to caption a node,
		'radius' to set the node's player-detection radius,
		'region' to assign a node to a special region,
		'nofly' set to 1 means the node cannot be flown to,
		'dark' set to 1 means the node can only be seen by the player from a small distance, but suffers no penalty when chained between other nodes


	ADDITIONAL LINK DATA:

	Writing {field:value} after both nodes assigns data to their link:
		"Stormwind 11.1,22.2 -x- Elwynn Forest 55.5,66.6 {cost:999}"   -- this is a very time-costly connection


	ADVANCED FORMAT:

	If that's not enough, you can use a "raw" format to write node links:
		{ "@+" , "Orgrimmar/1 11.1,22.2" , template="portalauto", faction="H", cost=123 }

	Within that, you can go even deeper and write the node(s) in raw mode, too:
		{ "@+" , {"Orgrimmar/1 11.1,22.2",title="Something in Orgri",region="whatever"} , oneway=1 }

	Very advanced, messy, "fake zone"-based mapping (Maraudon the Zone of Nightmares) makes extensive use of that.

--]]


data.basenodes = {}

data.basenodes.setup = {
	--"REGION fuselightbtspre Badlands 79.1,31.6 <150",
}



-- These zone pairs see directly into each other, as they share "green" borders.
data.greenborders = {

	{"Western Plaguelands","Eastern Plaguelands"},
	{"Feralas","Thousand Needles"},
	{"The Barrens","Durotar"},
	{"Mulgore","Thunder Bluff"},
	{"Elwynn Forest","Duskwood"},
	{"Westfall","Duskwood"},
	{"Westfall","Elwynn Forest"},
	{"Hillsbrad Foothills","Alterac Mountains"},
	--{"The Temple of Atal'Hakkar","Swamp of Sorrows"},
}

data.walls = {
}



-- These define zone-wide flags, if that's needed.
data.zoneflags = {
	--["Razorfen Kraul"]={dark=1},
}


--[[
	These lines define how each point's text displays, depending on their "situation".
	The keys of this dictionary adhere to a quirky, but logical pattern of "a_b__c_d", which means:
		a = "this type of connection"
		_ = "to"
		b = "this type of point"
		_ = "and"
		_ = "then"
		c = "that type of connection"
		_ = "to"
		d = "that type of point".
	So, a "start" point that you "walk" to (all paths start like that), after which you'll "fly" to a "border" point, is in a situation of "walk_start__fly_border" ("walk to start, and then fly to border").
	You can supply just "a_b", or just "b".
	A point attribute <template:nameoftemplate> overrides the point's basic type for the purpose of this list. Thus, a point can stay a "portal", but have the flavour of "portalclick" if it has a <template:portalclick> attribute and have a special display of "Click portal", matching a "portalclick" type.
	A connection attribute {template:nameoftemplate} overrides the mode of transport for the purpose of this list. Thus, if a connection has {template:portalauto} one can match for "portalauto_*" to show descriptions for that connection, or match for "*_*__portalauto_*" to match for NEXT connection's type and perhaps show an appropriate text on the previous node before a portal.
	A connection attribute that is not found in this list, is looked up in the list above, for easy two-way descriptions.
	Asterisks denote wildcards.
	One can also use the text part of the dictionary to refer to other entries in the list.
	Entries are checked in the file's order. First match gets the cake.

	So, for example: 
		"taxi" - matches points of type "taxi", to display them as "Talk to {npc}\nFly to {next_name}, {next_map}".
		"portalauto" - matches points of template "portalauto", to display them as "Enter portal to {next_map}".
		"*_*__pinkportal" - matches any point AFTER which there's a pinkportal connection.
--]]

data.point_context_templates = {
	{'start_start',"Start at {node}"}, -- dev purposes only
	{'walk_start',"You are here"},

	{'whistle',"Use Flight Master's Whistle"},
	{'taxi_taxi__taxi_taxi',"passfp"},
	{'taxi_ferry__taxi_ferry',"passfp"},
	{'forced_taxi__taxi_taxi',"Arrive at {name}, {map}\nFly again to {next_name}"},
	{'forced_ferry__taxi_ferry',"Arrive at {name}, {map}\nTake the Ferry again to {next_name}"},
	{'*_ferry__taxi_ferry',"Talk to {npc}\nTake the Ferry to {next_name}"},
	--{'taxi_taxi__taxi_taxi',"arrive"},

	{'*_taxi__taxi_taxi',"taxi"},
	{'taxi_taxi',"arrivefp"},
	{'taxi_ferry',"arrivefp"},
	{'taxi_argusportal',"arrivefp"},
	{'taxi_argushub',"arrivefp"},

	{'taxi',"Talk to {npc}\nFly to {next_name}"},
	{'taxilearn',"Talk to {npc}\nLearn a new flight point\nFly to {next_name}"},
	{'taxidumb',"Arrive at your destination"},

	{'*_ship__ship_ship',"Ride the Boat to {next_port}"}, {'ship_ship',"arrive"},
	{'*_zeppelin__zeppelin_zeppelin',"Ride the Zeppelin to {next_port}"}, {'zeppelin_zeppelin',"arrive"},

	{'*_*__pandarope_*',"Click the Rope on the Ground\nto Swing to {next_map}"},

	{'*_portal__portal_*',"portalclick"}, {'portal*_*',"arrive"},
	{'*_portal__portalauto_*',"portalauto"},-- {'portalauto_X',"arrive"},
	{'*_portal__portalDungeonEnter_*',"portalauto"},-- {'portaldungeon_X',"arrive"},
	{'*_portal__portalDungeonExit_*',"Use the Portal to Leave {map}"},-- {'portaldungeon_X',"arrive"},
	{'portalauto',"Enter the Portal to {next_map}"},
	{'portaldungeon',"Enter the Portal to {next_map}"},
	{'portalclick',"Click the Portal to {next_map}"},
	{'*_teleportnamed',"Teleport to {next_name}"},
	--{'portal',"Click the Portal to {next_map}\nTeleport to {next_map}"},
	{'pinkportal',"Go Through the Pink Portal to {next_map}"},
	{'*_*__pinkportal_*',"Go Through the Pink Portal to {next_map}"},
	{'*_*__darkportal_*',"Enter the Green Portal\nTeleport to {next_map}"},
	{'darkportal',"Enter the Green Portal\nTeleport to {next_map}"},
	{'*_*__cityportal_*',"Enter the Circular Portal\nTeleport to {next_map}"},
	{'cityportal',"Enter the Circular Portal\nTeleport to {next_map}"},
	{'blackcat',"Talk to the Nightsaber Rider\nto Travel to {next_name}"},
	{'moltentele',"Talk to Lothos Riftwaker\n Teleport to {next_map}"},
	{'orbofcommand',"Click the Orb of Command\n Teleport to {next_map}"},
	{'dragonrider',"Talk to the Dragon\n Arrive at {next_map}"},
	{'*_*__transporter_*',"Enter the Transporter"},
	{'transporter_*',"Leave the Transporter"},
	{'argusportal',"Use the Lightforged Beacon\nto Teleport to {next_name}"},
	{'argushub',"Use the Navigaton Console\nto Teleport to {next_name}"},

	{'walk_border',"walk_map"}, {'border_border',"walk_map"},

	{'arrive',"Arrive at {map}"},
	{'arrivefp',"Arrive at {name}"},
	{'passfp',"Pass {name}, {map}"},

	{'*_tram__tram_tram',"tram"}, {'tram_tram',"arrive"},
	{'tram',"Ride the Tram to {next_map}"},

	{'deathgate',"Cast Death Gate to Acherus"},
	{'teleport',"Cast Teleport to {map}"},

	{'courtesymage',"Find a Mage to Teleport you to {map}\nNo Direct Path Available"},
	{'courtesywarlock',"No Path to {map} Available"},
	{'courtesy',"Use a Courtesy!"},

	{'teleport_ask',"Use a Mage Portal to {map}"},
	{'useitem',"Use {item}"},
	{'*_temp__mole_*',"{next_title}"}, -- not used; .title overrides this

	{'hearth',"Hearth to {name}"},
	{'ghearth',"Hearth to Your Garrison"},
	{'astralrecall',"Cast Astral Recall to Teleport to {name}"},

	{'*_door',"Click to Open the Door"},
	{'walk',"Go to {node}"},
	{'swim',"Swim to {node}"},
	{'walk_map',"Go to {bordermap}"},
	{'fly',"Go to {node}"},
	{'travel','walk'},
}


data.connection_templates = {
	['building'] = {
		["Enter the building"]={'title_atob'},
		["Leave the building"]={'title_btoa'},
	},
	['cave'] = {
		["Enter the cave"]={'title_atob'},
		["Leave the cave"]={'title_btoa'},
	},
	['mine'] = {
		["Enter the mine"]={'title_atob'},
		["Leave the mine"]={'title_btoa'},
	},
	['tunnel'] = {
		["Enter tunnel"]={'title_atob'},
		["Exit tunnel"]={'title_btoa'},
	},
	['longtunnel'] = {
		["Enter tunnel"]={'title_atob'},
		["Go through tunnel"]={'title_btoa'},
	},
	['barrow'] = {
		["Enter barrow"]={'title_atob'},
		["Exit barrow"]={'title_btoa'},
	},
	['tomb'] = {
		["Enter tomb"]={'title_atob'},
		["Exit tomb"]={'title_btoa'},
	},
	['pathup'] = {
		["Go up the path"]={'title_atob'},
		["Go down the path"]={'title_btoa'},
	},
}





data.ZoneMeta = {
	["(all micros)"] = {hostile=true},
	["Caverns of Time"] = {hostile=false},
	["Deeprun Tram/1"] = {hostile=false},
	["Deeprun Tram/2"] = {hostile=false},
	[831] = {hostile=false},
	[886] = {hostile=false},
	[883] = {hostile=false},
}

--[[
--]]
