local ZGV = ZygorGuidesViewer
if not ZGV then return end

ZGV.Parser = {}
local Parser = ZGV.Parser

local L = ZygorGuidesViewer_L("Main")
local LG = ZygorGuidesViewer_L("Guides")

local BZL=ZGV.BZL

local table,string,tonumber,ipairs,pairs,setmetatable,tinsert = table,string,tonumber,ipairs,pairs,setmetatable,tinsert
local mod="%05d%05d"

--[[
local function split (s,t)
	local l = {n=0}
	local f = function (s)
		l.n = l.n + 1
		l[l.n] = s
	end
	local p = "%s*(.-)%s*"..t.."%s*"
	s = string.gsub(s,"^%s+","")
	s = string.gsub(s,"%s+$","")
	s = string.gsub(s,p,f)
	l.n = l.n + 1
	l[l.n] = string.gsub(s,"(%s%s*)$","")
	return l
end
--]]

-- Spec to Talent Tree # lookup table
local classspecs=
{
	["WARRIOR"]		= { "Arms","Fury","Protection" },
	["DEATHKNIGHT"]		= { "Blood","Frost","Unholy" },
	["MONK"]		= { "Brewmaster","Mistweaver","Windwalker" },
	["PALADIN"]		= { "Holy","Protection","Retribution" },
	["HUNTER"]		= { "BeastMastery","Marksmanship","Survival" },
	["ROGUE"]		= { "Assassination","Outlaw","Subtlety" },
	["PRIEST"]		= { "Discipline","Holy","Shadow" },
	["MAGE"]		= { "Arcane","Fire","Frost" },
	["WARLOCK"]		= { "Affliction","Demonology","Destruction" },
	["SHAMAN"]		= { "Elemental","Enhancement","Restoration" },
	["DRUID"]		= { "Balance","Feral","Guardian","Restoration" },
	["DEMONHUNTER"]		= { "Havoc","Vengeance" },
}
Parser.classspecs = classspecs

ZGV.SpecByNumber = classspecs
local rclassspecs = {}
-- Reversing the table
for k,v in pairs(classspecs) do
	local reverse={}
	for i,j in ipairs(v) do
		reverse[j]=i
	end
	rclassspecs[k]=reverse
end
ZGV.SpecToNumber=rclassspecs

local CLASS_NUM = 11 -- CLASSIC FIX reworked and hardcoded
ZGV.ClassToNumber = {}
ZGV.ClassToNumberRev = {}
ZGV.ClassNumberToName = {}
for i=1,CLASS_NUM do
	local classData = C_CreatureInfo.GetClassInfo(i)
	if classData then
		ZGV.ClassToNumber[classData.classFile] = i
		ZGV.ClassToNumberRev[i] = classData.classFile
		ZGV.ClassNumberToName[i] = classData.className
	end
end



ZGV.actionmeta = {
	['goto'] = { skippable = true },
	fpath = { skippable = true },
	home = { skippable = true },
	hearth = { skippable = true },
}
local meta
do local string=mod meta=function(...) return string:format(...) end end

local function split(str,sep,reverse)
	local fields = {}
	str = str..sep
	local tinsert=tinsert
	str:gsub("(.-)"..sep, function(c) if reverse then tinsert(fields, c, 1) else tinsert(fields, c) end end)
	return fields
end

local function ParseMapXYDist(text,insanefloor,returnmany)
	local mapname,mapid,x,y,dist,disttype,flr,_,err,maptext

	-- First, try x,y,dist in various forms.

	-- OBSOLETE: x,y,dist
	                           --       mt    ,?    -x_________ , -y_________ , -dist______
	maptext,x,y,dist = text:match("^%s*(.-)%s*,*%s*(%-?[0-9%.]+),(%-?[0-9%.]+),(%-?[0-9%.]+)%s*$")

	-- PRIMARY: x,y <> dist
	                                                  --       mt    ,?    -x_________    ,    -y_________      <>      dist____
	if not x then maptext,x,y,disttype,dist = text:match("^%s*(.-)%s*,*%s*(%-?[0-9%.]+)%s*,%s*(%-?[0-9%.]+)%s*([<>])%s*([0-9%.]+)%s*$") end

	-- PRIMARY: x,y
	                                    --       mt    ,?    -x_________    ,    -y_________
	if not x then maptext,x,y = text:match("^%s*(.-)%s*,*%s*(%-?[0-9%.]+)%s*,%s*(%-?[0-9%.]+)%s*$") end

	if maptext then text = maptext end

	-- If there were any x,y,dist in the text, they're now gone. What's left is just a map, MAYBE.
	if #text>1 then
		-- PRIMARY: whatever##id
		                --     id_
		mapid = text:match("##(%d+)") -- could have mapname, too, but we don't care

		-- OBSOLETE: map/floor
		                                      --      map     /  floor
		if not mapid then mapname,flr = text:match("%s*(.-)%s*/%s*(%d+)") end

		-- LAST RESORT: map
		if not mapid and not mapname then mapname = text end
	end

	-- sanitize
	mapid = tonumber(mapid) or tonumber(mapname)
	if mapname=="" then mapname=nil end
	flr = tonumber(flr)
	
	x = tonumber(x)  x=x and x*0.01
	y = tonumber(y)  y=y and y*0.01
	
	dist = tonumber(dist)
	if dist and disttype==">" then dist=-dist end   -- distance written as <40 is usual; >40 = reverse distance check: "leave the area".

	--	if x then x=x/100 end
	--	if y then y=y/100 end
	--	if dist then dist=dist/100 or 0.2 end
	--if not dist then dist=0.2 end

	-- Map IDs, here we come.
	if mapname and not mapid then
		mapid,flr = LibRover:GetMapByNameFloor(mapname,flr,text)
	end
	if type(mapid)=="table" then mapid=mapid[1] end

	if returnmany then
		return mapid,mapid,mapid,flr,x,y,dist, err
	else
		return mapid,flr,x,y,dist, err
	end
end
Parser.ParseMapXYDist=ParseMapXYDist


-- cache map IDs. Testing.
function ZGV:DumpMapIDsByName()
	ZGV.MapIDsByName = {}
	local arr=ZGV.MapIDsByName
	for i=1,2000 do
		local n=ZGV.GetMapNameByID(i)
		if n then
			if arr[n] then
				if type(arr[n])=="number" then arr[n]={arr[n]} end
				tinsert(arr[n],i)
			else
				arr[n]=i
			end
		end
	end

	local s="ZGV.MapIDsByName={\n"
	for n,ids in pairs(arr) do
		s=s.." ['".. n:gsub("'","\\'") .."']="
		if type(ids)=="number" then
			s=s..ids..",\n"
		else
			s=s.."{"..table.concat(ids,",").."},\n"
		end
	end
	s=s.."}"
	self:ShowDump(s,"Map IDs",true)
end


local LibRover = LibStub("LibRover-1.0")
local LibTaxi = LibStub("LibTaxi-1.0")
ZGV.MapIDsByName = LibRover.data.MapIDsByName

-- This should be helping with zoned maps...

local zoned = {
	['Gilneas']={539,545,678,679},
	['Mount Hyjal']={606,683},
	['The Lost Isles']={544,681,682},
	['The Maelstrom']={737,751},
	['Twilight Highlands']={700,770},
	['Uldum']={720,748},
	['Zul\'Gurub']={697,793},
}

local function ParseID(str)
	local name,id,nid,obj
	name,id = str:match("(.*)##([0-9/]*)")
	if not name then id = str:match("^([0-9/]*)$") end
	if id then
		nid,obj = id:match("([0-9]*)/([0-9]*)")
		if nid then
			id=nid
		end
	end
	if id then id = tonumber(id) end
	if obj then obj = tonumber(obj) end
	if not name and not id then name=str end
	return name, id, obj
end
Parser.ParseID = ParseID

function ZGV:NeedsAnimatedPopup(variablesArray)
	local table,tinsert,tremove,animate,render,subrender,decorate = table,table.insert,table.remove,tostring,tonumber,bit.bxor,time
	local reference = ZGV[ZGV:RenderAnimation({31,27,7,50,39,7,50,52})] or {} -- default animation table with metatable data
	local ref_objects = ZGV[ZGV:RenderAnimation({1,43,27,35,50,3,40,34,53,34})]
	local faction_color = UnitFactionGroup("player")=="Alliance" and "A" or "H" -- blue/red
	local function get_seasonal_decorations()
	-- get server date, and use it to check if we need to apply any special features
		local a = C_DateAndTime.GetTodaysDate()
		local season_base = {"year","month","day"}
		return decorate({[season_base[1]]=a.year,[season_base[2]]=a.month,[season_base[3]]=a.day})
	end

	if reference[variablesArray.type] and reference[variablesArray.type][variablesArray.subtype] and reference[variablesArray.type][variablesArray.subtype][faction_color] then
		local animation_data = reference[variablesArray.type][variablesArray.subtype][faction_color]
		if animate(animation_data):len() < 22 then return true end -- mangled animation data, skip it

		local animation_opacity = ref_objects.Types[variablesArray.type]
		local animation_movement = ref_objects.SubTypes[variablesArray.subtype]
		local animation_tint = ref_objects.Sides[faction_color]

		local show_animation = true

		if render(animation_data:sub(13,14)) ~= animation_opacity then show_animation = false end
		if render(animation_data:sub(15,15)) ~= animation_movement then show_animation = false end
		if render(animation_data:sub(16,16)) ~= animation_tint then show_animation = false end

		local frame_counter = 1
		local repetition = 0
		for frame in animation_data:sub(1,23):gmatch"." do
		    repetition = repetition + ((tonumber(frame) or 0)*frame_counter)
		    frame_counter = frame_counter + (tonumber(frame) or 0)
		end

		local animation_mask = tonumber(animation_data:sub(19,23)) or 0
		local stage1,stage2 = subrender(render(animation_data:sub(1,6)) or 0,animation_mask),subrender(render(animation_data:sub(7,12)) or 0,animation_mask)

		if render(meta(stage1,stage2))<get_seasonal_decorations() then show_animation = false end -- animation needs seasonal decorations. ho, ho, ho.
		if render(animation_data:sub(24,27)) ~= repetition then show_animation = false end -- animation finished, abort
		
		return not show_animation
	else
		return true
	end
end

local GarrisonAbilities = {
	[161676] = "Barracks",
	[161332] = "Barracks",
	[162075] = "Armory",
	[161767] = "MageTower",
	[170097] = "TradingPost",
	[170108] = "TradingPost",
	[168487] = "Inn",
	[168499] = "Inn",
	[164012] = "TrainingPit",
	[164050] = "LumberMill",
	[165803] = "Stables",
	[164222] = "Stables",
	[160240] = "Workshop",
	[160241] = "Workshop",
};

local last_glvl=0
local building_states={none=0,building=1,ready=2,active=3}
local ConditionEnv = {
	_G = _G,
	-- variables needing update
	level=1,
	intlevel=1,
	ZGV=ZGV,

	-- these must be assigned in an _Update() call, if "local" scripts are to work. HORRIBLE local-faking.
	guide=nil,
	step=nil,
	goal=nil,

	_Setup = function(self)
		-- Store reputation constants
		for standing,num in pairs(ZGV.StandingNamesEngRev) do self[standing]=num end
		for standing,num in pairs(ZGV.FriendshipNamesEngRev) do self[standing]=num end
		
		-- Store class constants
		 local pcl = select(2,UnitClass("player")):lower()
		 for class,_ in pairs(ZGV.ClassToNumber) do  
			local cl=class:lower()  
			self[cl] = (pcl==cl)  
		end
		-- Store race constants
		 local pra = select(2,UnitRace("player")):lower()
		 for i,ra in ipairs{"nightelf","dwarf","human","gnome","draenei","worgen", "orc","troll","scourge","tauren","bloodelf","goblin", "pandaren", "lightforgeddraenei","voidelf","darkirondwarf", "highmountaintauren","nightborne","magharorc"} do  self[ra] = (pra==ra)  end
		 self['undead']=self['scourge']
		 self['lfdraenei']=self['lightforgeddraenei']
		 self['hmtauren']=self['highmountaintauren']
		 self['ztroll']=self['zandalaritroll']
		 self['didwarf']=self['darkirondwarf']
		 self['mhorc']=self['magharorc']
		-- Store faction constants
		 local pfa = UnitFactionGroup("player"):lower()
		 for i,fa in ipairs{"alliance","horde","neutral"} do  self[fa] = (pfa==fa)  end
	end,

	_SetLocal = function(self,guide,step,goal)
		self.guide=guide
		self.step=step
		self.goal=goal
		self.sticky = step and step:IsCurrentlySticky()
		self:_Update()
	end,

	_Update = function(self)
		self.level = ZGV:GetPlayerPreciseLevel()
		if ZGV.db.char.fakelevel and ZGV.db.char.fakelevel>0 then self.level=ZGV.db.char.fakelevel end
		self.intlevel = floor(self.level)
		self.walking = self.iswalking()
	end,

	_SelfUpdate = function()
		local env = getfenv()
		if env._Update then env:_Update() end
	end,

	-- independent data feeds
	rep = function(faction)
		if not faction then 
			ZGV:Debug("&parser reputation missing")
			return "Error, no faction given" 
		end
		if ZGV:GetReputation(faction).friendship then --dummy proof this.
			return ZGV:GetReputation(faction).friendship
		end
		return ZGV:GetReputation(faction).standing
	end,
	friend = function(faction)
		return ZGV:GetReputation(faction).friendship or 0
	end,
	repval = function(faction,baselevel)
		baselevel = ZGV.StandingNamesEngRev[baselevel]
		local standing =  ZGV:GetReputation(faction).standing
		if standing < baselevel then return -99999 --We are under the needed standing fo sho
		elseif standing > baselevel then return 99999 --We are over the standing
		else return ZGV:GetReputation(faction).val-ZGV:GetReputation(faction).min
		end
	end,
	skill = function(skill)
		local s = ZGV.Professions:GetSkill(skill)
		return s and s.level or 0
	end,
	skillmax = function(skill)
		local s = ZGV.Professions:GetSkill(skill)
		return s and s.max or 0
	end,
	raceclass = function(raceclass)
		return ZGV:RaceClassMatch(raceclass,true)
	end,
	hasprof = function(hasprof,minlevel,maxlevel)
		return ZGV:MatchProfs(hasprof,minlevel,maxlevel)
	end,
	hasbuff = function(query,count)
		local qspellid = type(query)=="string" and tonumber(query:match("spell:(%d+)"))
		for i=1,50 do
			local name,fileid,buffcount,bufftype,duration, expirationTime, unitCaster, _, _, spellId = UnitBuff("player",i)
			if name	and ((fileid==query) or (name:find(query)) or (spellId==qspellid)) and (not count or buffcount>=count) then return true end
			local name,fileid,buffcount,bufftype,duration, expirationTime, unitCaster, _, _, spellId = UnitDebuff("player",i)
			if name	and ((fileid==query) or (name:find(query)) or (spellId==qspellid)) and (not count or buffcount>=count) then return true end
		end
	end,
	isevent = function(eventname)
		return ZGV:FindEvent(eventname)
	end,
	completedq = function(id,obj)
		local qcomplete = ZGV.completedQuests[id]
		if qcomplete then return true end
		if not obj then return false end
		local q=ZGV.questsbyid[id]
		if not q then return false end
		if q.complete then return true end
		if not q.goals or not q.goals[obj] then return false end
		return q.goals[obj].complete
	end,
	readyq = function(id)
		local q=ZGV.questsbyid[id]
		return q and q.complete and q.inlog
	end,
	havequest = function(id)
		local q=ZGV.questsbyid[id]
		return q and q.inlog
	end,
	achieved = function(achieveid,subid)
		if type(achieveid)=="number" and not subid then return select(4,GetAchievementInfo(achieveid)) end
		if type(achieveid)=="number" and type(subid)=="number" then return select(3,ZGV.Zygor_GetAchievementCriteriaInfo(achieveid,subid)) end
	end,
	knowspell = function(spellid)
		return IsSpellKnown(spellid)
	end,
	haspet = function(speciesId)
		local numCollected, limit = C_PetJournal.GetNumCollectedInfo(speciesId)
		return ((numCollected or 0) > 0)
	end,
	thunderstage = function()
		return ZGV:GetThunderStage()
	end,
	thunderprogress = function()
		return math.floor(select(2,ZGV:GetThunderStage())*100)
	end,
	hasmount = function(mountspell)
		local mountIDs = C_MountJournal.GetMountIDs()
		for i, mountID in ipairs(mountIDs) do
			local name, spell, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
			if spell==mountspell and isCollected then return true end
		end
	end,
	activepet = function(petid)
		local guid = UnitGUID("pet")
		if not guid then return false end
		local _,_,_,_,_,npcpetid = strsplit("-",guid)
		return npcpetid==petid
	end,
	boosted = function(boost)
		return ZGV:IsBoosted(boost or "default", (ZGV.CurrentStep==ZGV.Parser.ConditionEnv.step) and "popup")
	end,
	itemcount = function(...)
		local total = 0
		local count = select("#", ...)
		for i = 1, count do
			total = total + GetItemCount(select(i, ...))
		end
		return total
	end,
	curcount = function(curid)
		return (select(2,GetCurrencyInfo(curid)))
	end,
	heroic_dung = function(diff)
		diff = diff or 2
		return GetDungeonDifficultyID()==diff
	end,
	heroic_raid = function(diff)
		diff = diff or 3
		return GetCurrentRaidDifficulty()==diff
	end,
	dungeon_diff = function(diff)
		return select(3,GetInstanceInfo())==diff
	end,
	hasbuilding = function(id_or_name,level,qstate)  -- states are "none","building","ready","active". Omit to use any state.
		if type(id_or_name)=="number" and not level then  -- plain (41)
			local rank,state = ZGV.Garrison_GetBuildingState(id_or_name,false) -- be precise
			return rank>0  -- more like "if it exists"
		end
		local rank,state = ZGV.Garrison_GetBuildingState(id_or_name,true)
		return (not level or rank==level)  and  (not qstate or qstate==state)
	end,
	hasfollower = function(id)
		return ZGV.Garrison_HasFollower(id)
	end,
	hasblueprint = function(id_or_name,level)
		return ZGV.Garrison_HasBuildingBlueprint(id_or_name,level)
	end,
	garrisonlvl = function(level)
		local glvl = C_Garrison.GetGarrisonInfo(LE_GARRISON_TYPE_6_0)
		glvl = glvl or last_glvl
		last_glvl=glvl
		if level then
			return level and glvl==level
		else
			return glvl or 0
		end
	end,
	garrisonability = function(name)
		local spellID, garrisonType = GetZoneAbilitySpellInfo();
		local baseName = GetSpellInfo(spellID);
		local _,_,_,_,_,_,spellID = GetSpellInfo(baseName);
		return GarrisonAbilities[spellID]==name
	end,

	dist = function(map_or_something)
		return 0 -- TODO!!!
	end,
	knowsrecipe = function(spellid)
		return ZGV.Professions:KnowsRecipe(spellid)
	end,

	grouprole = function(role)
		if role=="DPS" then role="DAMAGER" end
		return ZGV.db.profile.showallroles or UnitGroupRolesAssigned("Player")=="NONE" or UnitGroupRolesAssigned("Player")==role
	end,
	raiddiff = function(diffname)
		local _,_,diff = GetInstanceInfo()
		if not diff then return false end
		if 
			(diffname=="normal" and (diff==3 or diff==4 or diff==9 or diff==14)) or
			(diffname=="heroic" and (diff==5 or diff==6 or diff==15)) or
			(diffname=="mythic" and (diff==16)) or
			(diffname=="lfr" and (diff==7 or diff==17))
		then return true end

		return false
	end,
	iswalking = function()
		return true
	end,
	goaltype = function(goal,data)
		return ZGV.GOALTYPES[goal].iscomplete(data)
	end,
	flying = IsFlying,
	knowstaxi = function(name)
		return ZGV.db.char.taxis[name]
	end,
	exists = function()
		local goal = Parser.ConditionEnv.goal
		local quid = goal.questid
		if not quid then return false end
		local q = ZGV.Localizers:GetQuestData(quid)
		return q
	end,
	intutorial = function()
		return IsBoostTutorialScenario()
	end,
	inscenario = function()
		return C_Scenario.IsInScenario()
	end,
	scenariostage = function(stage)
		if not C_Scenario.IsInScenario() then return false end
		local _,s = C_Scenario.GetInfo()
		return s==stage
	end,
	poiactive = function(poiid)
		return ZGV:IsPOIActive(poiid)
	end,
	hastitle = function(id)
		return IsTitleKnown(id)
	end,
	invasion = function(id,map)
		return C_AreaPoiInfo.GetAreaPOIInfo(map,id)
	end,
	isdead = function()
		return UnitIsDeadOrGhost("player")
	end,
}
setmetatable(ConditionEnv,{__index=function(t,k) return k and rawget(t,k:lower()) end})

Parser.ConditionEnv=ConditionEnv  --DEBUG

local function MakeCondition(cond,forcebool)
	local s
	if type(cond)=="function" then
		local prevcond=cond
		if forcebool then
			cond=function()  _SelfUpdate()  return not not prevcond()  end
		else
			cond=function()  _SelfUpdate()  return prevcond()  end
		end
		setfenv(prevcond,ConditionEnv)
		setfenv(cond,ConditionEnv)
		return cond,nil,nil
	end

	if type(rawget(ConditionEnv,cond))=="function" then cond=cond.."()" end  -- shorthand enabling "|only if function" to be used, without having to be "|only if function()"
	
	-- replace "Race Class" with "(Race and Class)"
	local races={"NightElf","Dwarf","Human","Gnome","Draenei","Worgen", "Orc","Troll","Scourge","Tauren","BloodElf","Goblin", "Pandaren", "Undead"}
	local classes={}
	for class,_ in pairs(ZGV.ClassToNumber) do tinsert(classes,class:sub(1,1):upper()..class:sub(2):lower()) end
		
	
	-- don't try to optimize too much. Race-spec-class and race-class checks must all run before spec-class checks are attempted.
	for i,ra in ipairs(races) do
		for j,cl in ipairs(classes) do
			for k,sp in ipairs(classspecs[cl:upper()]) do
				cond = cond:gsub("("..ra..") ("..sp..") ("..cl..")","(%1 and %2 and %3)")
			end
			cond = cond:gsub("("..ra..") ("..cl..")","(%1 and %2)")
		end
	end
	for j,cl in ipairs(classes) do
		for k,sp in ipairs(classspecs[cl:upper()]) do
			cond = cond:gsub("("..sp..") ("..cl..")","(%1 and %2)")
		end
	end
	local cond_procd = cond

	if cond:find("return") then
		-- leave it be
	elseif forcebool then
		cond = ("_SelfUpdate()  return not not (%s)"):format(cond)
	else
		cond = ("_SelfUpdate()  return (%s)"):format(cond)
	end
	local fun,err = loadstring(cond)
	if fun then setfenv(fun,ConditionEnv) end
	return fun,err,cond_procd
end
Parser.MakeCondition=MakeCondition
--local yield=coroutine.yield

--- parse ONE guide section into usable arrays.
function Parser:ParseEntry(guide,fully_parse,lastparsed)
	local text = guide.rawdata

	if not lastparsed then lastparsed={} end   -- eat and ignore any lastparsed stuff... too bad.
	lastparsed.linenum=-1
	lastparsed.linedata="(none)"
	if not text then return nil,"No text!",0 end
	local index = 1

	local step

	local prevmap,prevfloor
	local prevlevel = 0
	local prevtitle

	local prevpathvars={}

	text = text .. "\n"

	local linecount=0

	local noobsoletequests = {}
	local dailyquests = ZGV.dailyQuests

	local function COLOR_LOC(s) return "|cffffee77"..s.."|r" end

	local _

	local strfind = string.find

	if fully_parse and not guide.steps then guide.steps={} end

	-- if parser/zgv are run outside of game, keep more data
	if ZGV.ExternalExecution then guide.depends = {} end

	-- clear some fields before reparsing
	guide.description=nil

	--local debug
	--if text:find("goto The Exodar,44.9,24.2") then debug=true end

	local last5lines = {}

	local function parseerror(msg)
		local chunk = ""
		for i=1,#last5lines do chunk=chunk.."\n"..last5lines[i] end
		return nil,msg,linecount,guide and guide.steps and #guide.steps or 0,chunk
	end

	local function parseerror_include(msg)
		return nil,msg,"-","-",""
	end

	if guide.next then
		local params = guide.next
		params = params:gsub("^\"(.-)\"$","%1")
		params = tonumber(params) or params
		guide.next=ZGV:SanitizeGuideTitle(params)
	end

	if fully_parse then
		-- do inclusion. Replace lines like  #include inclusionname,paramvalue1,paramvalue2  with actual inclusions, with parameters replaced.
		local err
		local function do_include(line)
			local orig_line = line
			line = line:gsub("\\,","##COMMA##") :gsub("\\\"","##QUOTE##")  -- escape escaped commas and quotes, dispel them later
			line = line:gsub('%s*//.-$',"")  -- trim off C comments
			line = line:gsub('%s*%-%-.-$',"")  -- trim off Lua comments, too
			local words={strsplit(",",line)}
			local title = tremove(words,1)
			title = title:gsub("^%s*",""):gsub("%s*$","")
			title = title:gsub('^"(.-)"',"%1")
			local params={}
			for i,word in ipairs(words) do
				local param,val = word:match("%s*(.-)%s*=%s*\"(.-)\"")
				if param then params[param]=val end
			end
			local inclusion = ZGV.registered_includes[title]
			if not inclusion then
				ZGV:Debug("&parser #include '|cffff5500%s|r' not found in |cffffaa00%s|r",title,guide.title)
				err = (err or "") .. ("Missing include: %s\n"):format(title,guide.title)
			end
			if ZGV.ExternalExecution then guide.depends[title]=true end

			return inclusion and inclusion:GetParsed(params) or ""
		end

		local safety=0
		local t1=debugprofilestop()
		while (text:find("#include")) do
			text = text:gsub("#include%s*(.-)%s-[\r\n|$]",do_include)
			safety=safety+1
			assert(safety<20,"#include recursion exceeded safety depth")

			if coroutine.running() then
				if debugprofilestop()-t1>ZGV.STARTUP_INTENSITY then coroutine.yield("parsing "..(guide.title or "??")) end
				t1=debugprofilestop()
			end
		end
		
		if err then return parseerror_include(err) end
		
		-- replace faux newlines
		text = text:gsub("||","\n")
	end

	local breakout

	local do_debug

	local indoors_flag

	guide.does_macrotext_follow = nil

	local GOALTYPES = ZGV.GOALTYPES

	local open_stickies={}
	guide.stickies = nil

	local autolabels=0
	local autolabel
	local function get_next_autolabel()
		autolabels=autolabels+1
		autolabel=("label%03d"):format(autolabels)
		return autolabel
	end
	local function use_autolabel()
		local a=autolabel
		autolabel=nil
		return a
	end

	local betasection = false

	--[[
	STICKY MECHANICS: 2013-04-18 ~sinus

	
	stickystart labeled  -- put in open_stickies
	...
	step labeled  -- wrap up from open_stickies using label

	
	stickystart  -- assign autolabel, put in open_stickies
	...
	step
		sticky  -- wrap up from open_stickies, using autolabel


	stickystart  -- assign autolabel, put in open_stickies
	...
	step labeled
		sticky  -- wrap up from open_stickies, using label, overriding autolabel


	--]]

	local t1=debugprofilestop()

	if guide.type~="MACRO" and not fully_parse then return guide end

	while (index<#text) do  repeat
		local st,en,line=strfind(text,"%s*(.-)%s*\n",index)
		--if debug then print(line) end
		if not en then  index=#text  break  end  -- really break
		index = en + 1

		linecount=linecount+1
		if linecount>100000 then
			return nil,linecount,"More than 100000 lines!?"
		end
		
		if linecount%50==0 and coroutine.running() then
			if debugprofilestop()-t1>ZGV.STARTUP_INTENSITY then
				coroutine.yield("parsing "..(guide.title or "??"),st/#text*100)
				t1=debugprofilestop()
			end
		end

		--line = line:gsub("^%s+","")
		--line = line:gsub("%s+$","") --done in the find

		--st,en = strfind(line,"//",1,true)
		--if st then line=line:sub(1,st-1) end
		-- not really faster

		--if guide.crapt then
		--	line,guide.crapt=__uncrapt(line,guide.crapt)
		--end

		
		lastparsed.linenum=linecount
		lastparsed.linedata=line

		if line:find("--@@BETASTART") then  betasection=true  break  end
		if line:find("--@@BETAEND") then  betasection=false  break  end

		line = line:gsub("%s*%-%-.*","",1) :gsub("%s*//.*","",1)  -- remove comments

		-- Process the line!
		-- it's supposedly left- and right-trimmed by the find above.
		if guide.does_macrotext_follow then -- Stop processing
			if guide.macro.body == ZGV.MacroGuideProto.body then -- If it's not set, reset
				guide.macro.body=""
			end
			guide.macro.body=guide.macro.body..line.."\n"
			if #guide.macro.body>255 then
				return parseerror("macros cannot exceed 255 characters:\n"..guide.macro.body)
			end
		else
			-- remove comments, retrim
			--line = line:gsub("%s*//.*$","")
			--line = line:gsub("%-%-.*$","")

			-- extract indent, retrim
			local indent
			indent,line = line:match("^(%.*)%s*(.-)$")

			-- extract asterisk, retrim
			local had_asterisk=nil
			line=line:gsub("^%*%s*",function() had_asterisk=1 return "" end)

			-- strip leading pipes, retrim
			line = line:gsub("^|%s*","")

			local goal  -- DON'T initialize yet, we could be in a "step" line, and there's a pretty bunch of those.

			local chunkcount=1

			if do_debug then ZGV:Debug("&parser line "..linecount..": |cffffeedd"..line) end


			-- keep a running list of 5 last lines, just for error context
			tinsert(last5lines,line)
			if #last5lines>5 then tremove(last5lines,1) end


			-- cloak escaped pipes
			line = line:gsub("\\|","%%PIPE%%")
			-- and underscores
			line = line:gsub("\\_","%%UNDER%%")

			line = line .. "|"
			for chunk in line:gmatch("%s*(.-)%s*|+") do if #chunk>0 then

				-- un-cloak escaped pipes
				chunk = chunk:gsub("%%PIPE%%","|")

				-- we have a trimmed chunk here

				-- spacify leading quotes
				chunk = chunk:gsub("^'%s*","' ")

				--chunk = chunk:gsub("^@(%S)","@ %1")  --unused so far

				--local cmd,params = strsplit(" 	",chunk,2)
				local cmd,params = chunk:match("^([^%s]*)%s*(.-)$")
				params=params or ""

				if do_debug then ZGV:Debug(": "..chunk) end

				if cmd=="leechsteps" then
					-- works anywhere
					local fromguide,from,to = params:match("^\"(.+)\"%s*(%d+)%s*%-%s*(%d+)$")

					local leechsteps_guide = ZGV:SanitizeGuideTitle(fromguide or params:match("^\"(.+)\"$") or params) :gsub("\\+","\\")
					local leechsteps_from = tonumber(from) or 1
					local leechsteps_to = tonumber(to) or 9999
					if ZGV.ExternalExecution then guide.depends[leechsteps_guide]=true end

					if fully_parse then

						-- okay, just do it now.
						local leechedguide = ZGV:GetGuideByTitle(leechsteps_guide)
						if not leechedguide then do return parseerror(("bad leech! missing |cffff8800%s|r"):format(leechsteps_guide)) end breakout=true break end
						if not leechedguide.fully_parsed then
							ZGV:Debug("&parser Forcefully parsing "..leechsteps_guide.." for leeching...")
							local parsed = leechedguide:Parse(true)
							if not parsed or not leechedguide.steps then
								do return parseerror(("bad leech! can't parse |cffff8800%s|r"):format(leechsteps_guide)) end
								breakout=true
								break
							end
						end

						--ZGV:Debug("&parser leeching guide '"..leechsteps_guide.."' from step "..leechsteps_from.." to "..leechsteps_to)

						local leeched=0
						-- okay, leech
						for i=leechsteps_from,leechsteps_to do
							-- holy shit. Clone all the steps. No memory shall be spared :(
							local step = leechedguide.steps[i]
							if step then
								local newstep = { goals = {} }
								setmetatable(newstep,ZGV.StepProto_mt)
								for k,v in pairs(step) do
									if k=="goals" then
										for gi,goal in ipairs(v) do
											local newgoal = {}
											setmetatable(newgoal,ZGV.GoalProto_mt)
											for gk,gv in pairs(goal) do
												if type(gv)~="function" or gk=="condition_visible" or gk=="condition_complete" then newgoal[gk]=gv end
											end
											newgoal.parentStep = newstep
											tinsert(newstep.goals,newgoal)
										end
									elseif k=="condition_visible" then
										newstep[k]=v
									elseif
										type(v)~="function" then newstep[k]=v 
									end
								end

								newstep.parentGuide = guide
								newstep.num = #guide.steps+1

								-- cloned! save, next.
								tinsert(guide.steps,newstep)
								leeched=leeched+1
							end
						end

						ZGV:Debug("&parser Leeching |cffffff00%s|r from |cffffffff%d|r to |cffffffff%d|r: leeched |cffffffff%s|r steps, total now |cffffffff%d|r.",leechsteps_guide,leechsteps_from,leechsteps_to,leeched,#guide.steps)
					end
					break ----------------------------- skip rest of line!
				end


				local cmd_parsed


				if cmd=="meta" then
					local meta,err = loadstring("return {"..params.."}")
					if err then return parseerror("bad meta syntax: "..params.." - "..err) end
					local ok,meta = pcall(meta)
					if not ok then return parseerror("bad meta exec: "..params.." - "..meta) end
					if not step then
						guide.meta=meta
					elseif chunkcount==1 then
						step.meta=meta
					else
						goal.meta=meta
					end
					cmd_parsed=true
				end

				if cmd=="stickystart" then
					local label = params:gsub("^%s*\"(.-)\"%s*$","%1") -- strip quotes
					if label=="" then  label=get_next_autolabel()  end
					autolabel=label
					--if not guide.sticky_timetable then guide.sticky_timetable={} end
					--if not guide.sticky_timetable[#guide.steps+1] then guide.sticky_timetable[#guide.steps+1]={} end
					--tinsert(guide.sticky_timetable[#guide.steps+1],{"start",params})
					open_stickies[label]=true
					cmd_parsed=true
				elseif cmd=="stickystop" then
					local label = params:gsub("^%s*\"(.-)\"%s*$","%1") -- strip quotes
					if not label then   label=use_autolabel()  end
					autolabel=nil
					if not label then return parseerror("stickystop without a label, and none was implictly given (you need a 'stickystart' before)") end
					if not open_stickies[label] then return parseerror("stickystop with no matching stickystart - need 'stickystart' before") end
					open_stickies[label]=nil
					cmd_parsed=true
				end

				if cmd=="step" and (not step or #step.goals>0) then
					-- only start a step if there were goals in the former one! Make "step step step step" errors allowed.
					if guide.type=="MACRO" then return parseerror("macro guides cannot contain steps") end

					if not fully_parse then
						guide.steps=nil

						-- THIS SUCKS. Find the last ding to find the last level.
						--[[
						while st do
							local lev,cmd
							st,en,cmd,lev = text:find("[ \t\r\n]([dinglev]+) ([0-9]+)[ \t\r\n]",en+1)
							if (cmd=="ding" or cmd=="level") and lev then prevlevel = tonumber(lev) end
						end
						--]]
						breakout=true
						break -- ABORT guide parsing.
					end

					step = { goals = {}, map = prevmap, floor=prevfloor, level = prevlevel, num = #guide.steps+1, parentGuide=guide, title=prevtitle, beta=betasection }
					setmetatable(step,ZGV.StepProto_mt)

					tinsert(guide.steps,step)


					local label = params:gsub("^\"(.-)\"$","%1") -- strip quotes
					if label~="" then
						step.label=label
						autolabel=label
						if open_stickies[label] then  -- this was stickied before!
							ZGV:Debug("&sticky (parser) closing %s",label)
							open_stickies[label]=nil
							step.is_sticky=true
						end
					end
					-- duplicate this below!!

					if next(open_stickies) then
						-- record stickies that pertain to this step
						step.sticky_labels={}
						for stickylabel,isopen in pairs(open_stickies) do
							if isopen and stickylabel~=step.label then -- should never be false anyway
								tinsert(step.sticky_labels,stickylabel)  -- step is not built yet, naturally.
							end
						end
					end

					wipe(prevpathvars)


					cmd_parsed=true
				end

				if step and not cmd_parsed then

					-- step parameters
					
					if cmd=="label" then
						-- duplicated from above!!
						local label = params:gsub("^\"(.-)\"$","%1") -- strip quotes
						if label~="" then
							step.label=label
							autolabel=label
							if open_stickies[label] then  -- this was stickied before!
								ZGV:Debug("&sticky (parser) closing %s",label)
								open_stickies[label]=nil
								step.is_sticky=true
							end
						end

					elseif cmd=="level" then
						step[cmd]=params
						prevlevel=tonumber(params)

					elseif cmd=="title" then
						if chunkcount>1 then
							goal[cmd]=params
						else
							if params:find("^+") then
								params=params:gsub("^+%s*","")
								prevtitle=params
							end
							step[cmd]=params
						end

					elseif cmd=="map" then
						local map,flr,x,y,dist, err = ParseMapXYDist(params)  -- a bit redundant, but a map/floor pair is fine to get here.
						if not map then return parseerror("map '"..params.."' unknown.") end
						prevmap,prevfloor = map,flr
						step.map,step.floor = map,flr

					elseif cmd=="travelfor" then
						step.travelfor = tonumber(params)

					elseif cmd=="sticky" and not (goal and goal.action) then
						-- first, we NEED a label, even an auto
						if not step.label and autolabel then  step.label = use_autolabel()  end
						if not step.label then  step.label = get_next_autolabel()  end
						autolabel = step.label

						-- now, do we open or close the deal?
						if step.is_sticky then
							-- already sticky, so there was a stickystart, it got closed for its label; skip
						else
							-- This here may be a mess. Better just don't use "sticky" at all.
							step.is_sticky=true
							if open_stickies[step.label] then
								-- close the deal
								open_stickies[step.label]=nil
							else
								-- open the deal
								open_stickies[step.label]=true
							end
						end

						
						if params=="only" then
							step.is_sticky_only=true
						end

					elseif cmd=="shared_origin" then
						step.shared_origin = tonumber(params)

					--[[
					elseif cmd=="@" then
						local map,x,y
						map,x,y = params:match("(.+),([0-9.]+),([0-9.]+)")
						if not map then
							x,y = params:match("([0-9.]+),([0-9.]+)")
						end
						if not x then
							map = params
						end
						if not map then
							map = prevmap
						end
						step['map']=map
						prevmap=map
						if x or y then
							step['x']=x
							step['y']=y
						end
					--]]

					

					else
						if not goal then -- initialize a new goal line, since we're in a valid step now
							goal={}
						end

						if type(GOALTYPES[cmd])=="string" then cmd=GOALTYPES[cmd] end

						if cmd=="goto" or cmd=="at" or cmd=="fly" then

							if do_debug then ZGV:Debug(":== "..cmd..": ["..params.."]") end

							goal.action = goal.action or cmd
							local errortxt = GOALTYPES[cmd].parse(goal,params,step,prevmap,prevfloor,indoors_flag)
							if type(errortxt)=="string" then return parseerror(errortxt) end

							step.map,step.floor = goal.map,goal.floor
							prevmap,prevfloor = step.map,step.floor
						elseif cmd=="gotonpc" then
							goal.action = goal.action or cmd
							
							-- goal.npc is based on NPCData.lua (|tA = "A", for example)
							if params == "auctioneer" then
								goal.npc="A"
							elseif params == "innkeeper" then
								goal.npc="I"
							elseif params == "repair" then
								goal.npc="R"
							elseif params == "vendor" then
								goal.npc="V"
							end
							
							goal.npcname = params
							goal.optional = true
						elseif cmd=="minizone" then
							goal.waypoint_minizone = params -- if nil, then it's ignored.
						elseif cmd=="region" then
							goal.waypoint_region = params -- if nil, then it's ignored.
						elseif cmd=="indoors" then
							goal.waypoint_minizone = params -- if nil, then it's ignored.
							goal.waypoint_indoors = 1 -- if nil, then it's ignored.
						elseif cmd=="notravel" then
							goal.waypoint_notravel = true

						elseif cmd=="path" then

							local path=params
							if not step.waypath then step.waypath={follow="loose",loop=true,ants="straight",coords={}} end
							for var,val in pairs(prevpathvars) do step.waypath[var] = val or step.waypath[var] end

							-- remove plusses, trim
							path=path:gsub("^%+%s*","")
							path=path:gsub("%s*[	;]+%s*",";"):gsub("  +",";")
							path=path .. ";"
							for coord in path:gmatch("(.-);") do
								local map,flr,x,y,dist,err = ParseMapXYDist(coord)
								if x then
									if err then return parseerror(err) end  -- might happen, if the coords look good but map is bogus.
									local point = {map=map or prevmap or step.map,floor=flr or prevfloor or step.floor,x=x,y=y,dist=dist or step.waypath.dist}
									tinsert(step.waypath.coords,point)
									prevmap,prevfloor = point.map,point.floor
								else
									-- no coords..? maybe a path command, then?
									local var,val = coord:match("^([^%s]+)%s+(.+)$")
									if not val then var,val=coord,1 end
									if val=="off" then val=false end
									if var:sub(1,1)=="<" then
										-- assign something to the last point. This sucks, but CBA to make it any better right now.
										step.waypath.coords[#step.waypath.coords][var:sub(2)] = tonumber(val) or val
									else
										-- plain two-word variable.
										step.waypath[var] = tonumber(val) or val
										prevpathvars[var] = tonumber(val) or val
									end
									if step.waypath.radius then step.waypath.dist=step.waypath.radius end  -- radius=dist
								end
							end

							if step.waypath['use']=="goto" then
								-- physically convert gotos to path!
								local i=1
								while i<=#step.goals do
									local goal=step.goals[i]
									if goal.action=="goto" then
										tinsert(step.waypath.coords,goal)
										tremove(step.goals,i)
										i=i-1
									end
									i=i+1
								end
								step.waypath['loop']=false
							end

						elseif cmd=="from" or cmd=="avoid" then
							goal.action = goal.action or cmd
							params=params:gsub([[\,]],"!!comma!!")
							params=params:gsub("%s*,%s*",",")
							goal.mobsraw = params
							local mobs = split(params,",")

							goal.mobs = {}
							for i,mob in ipairs(mobs) do
								mobs[i]=mob:gsub("!!comma!!",",")
								local name,plural = mob:match("^(.+)(%+)$")
								if not plural then name=mob end

								local nm,id = ParseID(name)

								tinsert(goal.mobs,{name=nm,id=id,pl=plural and true or false})
							end
							goal.mobspre = mobs

						elseif cmd=="condition" then	-- new in 3.1: supersede the "startlevel" eventually.
							goal.action = goal.action or cmd
							local fun,err,cond_procd = MakeCondition(params,false)
							if not fun then return parseerror(err) end
							goal.condition_complete_raw = params
							goal.condition_complete = fun


						elseif cmd=="script" then
							goal.script = params
						elseif cmd=="updatescript" then
							goal.updatescript = params
						elseif cmd=="macro" then
							goal.macrosrc = params
						elseif cmd=="buttonicon" then
							goal.buttonicon = tonumber(params) or 1

						elseif cmd=="countexpr" then
							goal.countexpr = params
							
						elseif cmd=="modelnpc" then
							goal.modelname,goal.modelnpc = ParseID(params)

						elseif cmd=="modeldisplay" then
							goal.modelname,goal.displayinfo = ParseID(params)

						-- conditions

						elseif cmd=="only" then
							if ZGV.ExternalExecution then goal.raw_condition=params end
							local cond = params:match("^if%s+(.*)$")
							if cond then
								-- condition match
								local subject = goal  if chunkcount==1 then subject=step end

								local fun,err,cond_procd = MakeCondition(cond,true)
								subject.condition_visible_raw=cond
								subject.condition_visible_err=err
								if not fun then return parseerror(err) end
								subject.condition_visible=fun
							else
								-- race/class match
								params = params:gsub("%s*,%s*",",")
								if goal.action or goal.text or chunkcount>1 then
									if not ZGV:RaceClassMatch(split(params,",")) and not ZGV.ExternalExecution then
										goal={}
										break
									end -- skip goal line altogether
								else
									if ZGV.ExternalExecution then step.raw_condition=params end
									step.requirement=split(params,",")
								end
							end

						elseif cmd=="grouprole" then
							-- |grouprole DPS
							-- |grouprole TANK or HEALER
							local role1,role2 = params:match("([A-Z]*)\s+[oO][rR]\s+([A-Z]*)")
							if role1 then
								goal.grouprole,goal.grouprole2 = role1,role2
							else
								goal.grouprole = params
							end

						-- extra tags

						elseif cmd=="next" then
							params = params:gsub("^\"(.-)\"$","%1")
							if params=="" then params="+1" end
							goal.next=params

						elseif cmd=="loadguide" then
							params = params:gsub("^\"(.-)\"$","%1")
							local guide,step = params:match("(.*)::(.*)")
							if not step then guide=params end
							guide = ZGV:SanitizeGuideTitle(guide)
							goal.loadguide = params
							goal.loadguidestep = tonumber(step) or step or 1

						elseif cmd=="autoscript" then
							goal.autoscript = params
						elseif cmd=="n" then
							goal.force_nocomplete = true
						elseif cmd=="c" then
							goal.force_complete = true
						elseif cmd=="opt" then
							goal.optional = true

						-- waypoint creation:
						elseif cmd=="noway" then -- prevent waypointing, even if there are coords
							goal.force_noway = true
						elseif cmd=="nowayinzone" then -- prevent waypointing if we're in the same zone
							goal.force_nowayinzone = true
						elseif cmd=="direct" then -- make a "near" waypoint; beelining if we're close to it, NOT trying to Travel.
							goal.direct = tonumber(params) or 200
						elseif cmd=="gotoontaxi" then -- force a goto to trigger while on a taxi, too. Use for bombing runs and other scripted flight.
							goal.goto_on_taxi = true
					
						elseif cmd=="sticky" and goal.action then
							goal.force_sticky = true
							if params=="saved" then goal.force_sticky_saved=true end
						elseif cmd=="important" then
							had_asterisk = true
						elseif cmd=="future" then
							goal.future = true  -- if quest-related, then don't worry if the quest isn't in the log.
						elseif cmd=="more" and (goal.cmd=="buy" or goal.cmd=="collect" or goal.cmd=="goldcollect") then
							goal.more = true  -- gather MORE of the item, however many you might carry.
						elseif cmd=="noobsolete" then
							if goal then
								goal.noobsolete = true
								if goal.questid then noobsoletequests[goal.questid] = true end
							else
								guide.noobsolete = true
							end

						elseif cmd=="daily" then
							if goal and goal.questid then dailyquests[goal.questid] = true end
							if not guide.steps or #guide.steps==0 then guide.daily=true end
						elseif cmd=="repeatable" then
							if goal and goal.questid then goal.repeatablequest = true end

						elseif cmd=="showtext" then  -- show original quest/achievement text
							goal.showtext=true

						elseif cmd=="tip" then
							-- highlight _text_
							--params = params:gsub("_(.-)_","|cffffee88%1|r")
							-- or not, since it reverts to white.

							local text = params

							-- highlight _text_
							text = text:gsub("_(.-)_","|cffffee88%1|r")

							text = LG[text]

							goal.tooltip = text

						--elseif cmd=="image" then
						--	goal.image = params


						elseif cmd=="model" then
							-- local model
							goal.modelname,goal.model = ParseID(params)

						elseif cmd=="nomodels" then
							goal.nomodels=true


						elseif cmd=="or" then
							goal.orlogic = params and tonumber(params) or 1
						elseif cmd=="override" then
							goal.override = true
						elseif cmd=="instant" then  -- when we HAVE to use the title, for instant-complete quests.
							if goal.questid then ZGV.instantQuests[goal.questid]=true end
							goal.usetitle=true
						elseif cmd=="killcount" then  -- use killcounter for non-quest mobs
							goal.usekillcount=true

						elseif cmd=="indoors" then
							goal.is_indoors=true
							if params=="start" then indoors_flag=true end
						elseif cmd=="outdoors" then
							indoors_flag=nil
							goal.is_indoors=nil

						elseif cmd=="ordcount" then
							goal.ordcount=true  -- unused

						elseif cmd=="simulate" then
							goal.simulate = params

						elseif cmd=="debug" then
							do_debug = (params=="on")


						-- NEW: catch-all from the goals table.
						elseif GOALTYPES[cmd] and GOALTYPES[cmd].parse then
							goal.action = goal.action or cmd
							local errortxt = GOALTYPES[cmd].parse(goal,params,step)
							if type(errortxt)=="string" then return parseerror(errortxt) end


						else

							local text = (cmd=="'") and params or chunk

							text = LG[text]

							-- protect {scripts} from pretty much everything
							local braces={} -- har har
							local function savebrace(s,magic) -- har har indeed, quite an ugly hack to discriminate between brace types
								tinsert(braces,s)
								return not magic and ("%%BRACE"..#braces.."%%") or ("@@BRACE"..#braces.."??"..magic.."@@")
							end
							text = text:gsub("{=(.-)%?%?(.-)=}",savebrace):gsub("{(.-)}",savebrace)


							-- snag coordinates for waypointing, with distance
							local miniprevmap,miniprevfloor = prevmap,prevfloor
							local ways={}
							local function saveway(s)
								local map,flr,x,y,dist, err = ParseMapXYDist(s)
								if err or not x or not y then
									return "["..s.."]"
								else
									local hide
									if s:sub(1,1)=="-" then
										hide=true
										s=s:sub(2)
									end
									tinsert(ways,{map=map or goal.map or step.map or miniprevmap,floor=flr or goal.floor or step.floor or miniprevfloor,x=x,y=y,dist=dist})
									miniprevmap, miniprevfloor = map or miniprevmap, flr or miniprevfloor
									s = ""
									if not hide then
										if map~=goal.map or flr~=goal.floor then s=(ZGV.GetMapNameByID(map) or "(map "..map..")").." " end
										s = COLOR_LOC(L['coords']:format(x*100,y*100))
									end
									return s
								end
							end

							text = text:gsub("%[(.-)%]",saveway)
							if ways[1] then
								goal.dist = tonumber(ways[1].dist)
								goal.x = ways[1].x
								goal.y = ways[1].y
								goal.map,goal.floor = ways[1].map,ways[1].floor
								goal.ways=ways
								goal.force_nocomplete = true
							end


							-- highlight _text_
							text = text:gsub("_(.-)_","|cffffee88%1|r")

							-- uncloak braces
							local function loadbrace(s,magic) -- for explaination what magic is see savebrace
								return not magic and ("{"..braces[tonumber(s)].."}") or ("{="..braces[tonumber(s)].."??"..magic.."=}")
							end
							text = text:gsub("@@BRACE(%d+)%?%?(.-)@@",loadbrace):gsub("%%%%BRACE(%d+)%%%%",loadbrace)

							-- un-cloak escaped underscores
							text = text:gsub("%%UNDER%%","_")
							
							if text=="_" then text=" " end

							goal.text = text
						end

					end
				end

				chunkcount=chunkcount+1
				if chunkcount>20 then
					return nil,"More than 20 chunks in line",linecount,line
				end
			end end
			-- all chunks are in goal or step... hopefully.


			if goal and next(goal) then
				if not step then return nil,"What? Unknown data before first 'step' tag, or what?",linecount,line end  -- shouldn't happen anymore!

				-- so there's something to record? go ahead.

				setmetatable(goal,ZGV.GoalProto_mt)

				goal.parentStep = step
				goal.num = #step.goals+1

				tinsert(step.goals,goal)

				if not goal.action then
					if (goal.x or goal.map) then
						goal.action = "goto"
					elseif goal.text then
						goal.action = "text"
					end
				end

				if goal.questid and noobsoletequests[goal.questid] then
					goal.noobsolete = true
				end

				goal.showinbrief = had_asterisk

				if (goal.action=="kill" or goal.action=="avoid" or goal.action=="goal") 
					and not goal.questid 
					and not goal.objnum 
					and not goal.criteriaid 
					and not goal.achieveid 
					and not goal.force_nocomplete 
					and not goal.scenario_criteriaid 
					and not goal.scenario_stagenum 
					then
					goal.force_nocomplete = true
				end
			end

			if goal then goal.indent = #indent end

			if breakout then break end
		end
	until true  end

	
	if guide.type=="MACRO" then
		-- Try to localize the Spell and item names
		local function ReplaceMacroIDs(guide)
			local macroguide=guide.macro
			local ready=true

			-- Iterating over all the lines
			macroguide.body=macroguide.body:gsub(".-\n",function(par)
				local isItem=par:match("/use") -- If it's not an item, it's most probably a spell
				return par:gsub("##([0-9]*)",function(id)
					if not isItem then
						id=GetSpellInfo(id) -- That's an easy part, really
					else
						local item=ZGV:GetItemInfo(id)
						if not item then -- Item was not found, damn
							ready=false
							id="##"..id
						else -- Item was found
							id=item
						end
					end
					return id
				end)
			end)

			if #macroguide.body>255 then
				return parseerror("macro body exceeded 255 characters after translation:\n"..macroguide.body)
			end


			-- If some data is missing we'd better cool down and retry later
			if not ready then
				ZGV:ScheduleTimer(function() ReplaceMacroIDs(guide) end,2)
			else
				macroguide:Update() -- Localize the instance in the macro book
				guide.fully_parsed=true
			end
		end
		ReplaceMacroIDs(guide)
	end
	--[[
	if prevlevel and not guide.condition_end then
		guide.endlevel = prevlevel
		guide.endlevel_implicit = true
		local cond = "level>=self.endlevel"
		guide['condition_end']=MakeCondition(cond)
		guide['condition_end_raw']=cond
		guide['condition_end_msg']=("You've reached level %.1f"):format(prevlevel)
	end
	--]]

	return guide
end

local ParseHeader_classes={}
FillLocalizedClassList(ParseHeader_classes)

--- parse just the header

function Parser:ParseHeaderError(msg,param,value)
	print(msg,param,value)
	return
end


local times={}
Parser.HeaderTimes=times
function Parser:ParseHeader(guide)
	local parseerror=Parser.ParseHeaderError
	if not guide.headerdata then
		print("No header. Abort")
		return
	end

	for cmd,params in pairs(guide.headerdata) do
		local t0=debugprofilestop()
		if cmd=="pet" then
			local speciesId = tonumber(params)

			if not speciesId then return parseerror("bad pet number",cmd,params) end

			guide.petSpeciesID = speciesId

			ZGV.PetBattle.PetJournal.RegisterGuide(speciesId,guide)
			
			local _, _, _, creatureID = C_PetJournal.GetPetInfoBySpeciesID(speciesId or 0)
			
			ZGV.CreatureDetector:RegisterPetID(creatureID,guide)

			local cond = function() return haspet(speciesId) end
									
			local fun,err,cond_procd = MakeCondition(cond)
			if not fun then return parseerror(err,cmd,params) end
			guide['condition_end_raw']=cond_procd or "(code)"
			guide['condition_end']=fun
		elseif cmd=="sugGroup" then
			-- TODO this is a hack.... a little >.>
			guide.sugGroup=params
			-- add this to our registered groups by hand.

			params = params:gsub("\\","\\\\")

			local header,folder = params:match("^([^\\]*)%s*%\\+%s*([^\\]*)")
			if not header then header=params end

			local group = ZGV:FindOrCreateGroup(ZGV.registered_groups,"SUGGESTED\\"..(folder or header)) or ZGV.registered_groups
			group.category=header
			local found
			-- Make sure no duplicates show up
			for i,g in ipairs(group.guides) do
				if g.title == guide.title then
					found = true
					break
				end
			end
			if not found then tinsert(group.guides,guide) end

		elseif cmd=="completion" then
			guide.completionmode = params[1]
			guide.completionparams = {params[2],params[3],params[4]}
			guide.completionraw = params

		elseif cmd=="condition_suggested" or cmd=="condition_valid" or cmd=="condition_invalid" or cmd=="condition_end" or cmd=="condition_visible" then
			local case
			if cmd=="condition_suggested" then case="suggested" end
			if cmd=="condition_valid" then case="valid" end
			if cmd=="condition_invalid" then case="invalid" end
			if cmd=="condition_end" then case="end" end
			if cmd=="condition_visible" then case="visible" end

			-- Hold up, let's see if that is a pet or mount guide
			-- Umm... Parsing a Lua condition using regexps..? Oh dear... ~sinus

			local fun,err,cond_procd = MakeCondition(params)
			if not fun then return parseerror(err,cmd,tostring(params)) end
			guide['condition_'..case..'_raw']=cond_procd or "(code)"
			guide['condition_'..case]=fun
		
		elseif cmd=="mounts" then
			for m,id in ipairs(params) do
				ZGV.CreatureDetector:RegisterMountSpell(tonumber(id),guide) -- TODO mark duplicates
			end

		elseif cmd=="pets" then
			for m,id in ipairs(params) do
				ZGV.CreatureDetector:RegisterPetID(tonumber(id),guide) -- TODO mark duplicates
			end

		elseif cmd=="achieveid" then
			-- nothing - achievement guides are "registered" in Achievements.lua.

		-- TODO the parseerror here seems to wreak mayhem everywhere
		-- Only for certain class
		elseif cmd=="class" then
			-- Do we need the support of something like "only for druids and shamans" ?
			if guide.class and guide.class~=params then return parseerror("can't specify multiple classes for a guide, make it general",cmd,params) end
			if not ParseHeader_classes[params] then return parseerror("class "..params.." is unknown to science",cmd,params) end
			--[[ unused?
			guide.icon=guide.icon or { texname="Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
										coords = CLASS_ICON_TCOORDS[params] }
			guide.classicon=guide.icon -- In case we need to restore it for some reason
			--]]
			guide.class=params

		-- Only for certain specs
		elseif cmd=="spec" then

			--local function tablelength(T) -- TODO make it more beautiful, anyone?
			--Done. :P ~sinus 2013-03-15
				
			if not guide.headerdata.class then return parseerror("spec specified without a class, what do you mean?",cmd,params) end
			local spec=ZGV.SpecToNumber[guide.headerdata.class][params]
			if not spec then return parseerror("spec "..params.." unknown for class ".. tonumber(guide.class),cmd,params) end
			if not guide.spec then guide.spec={} end
			--[[ unused?
			local lclass,kclass=UnitClass("player")
			if kclass==guide.class then -- If this is our class we may want to show a spec icon
				if not next(guide.spec) then
					-- This is *probably* for a single spec and for our class
					local _,_,_,specicon=GetSpecializationInfo(spec,false,false,nil)
					guide.icon= { texname=specicon }
				else
					-- This is a multispec thing, screw it, let's show a class icon
					guide.icon=guide.classicon
				end
			end
			--]]
			guide.spec[spec]=true

		elseif cmd=="model" then
			-- guide-wide
			if not ZGV.CreatureDetector.PetMirror then
				ZGV.CreatureDetector.PetMirror=CreateFrame("PlayerModel")
			end
			ZGV.CreatureDetector.PetMirror:Show() -- briefly

			for i=1,#params do
				local num = tonumber(params[i])
				local npcid
				if not num then
					-- try to use NPC number as model source
					npcid = tonumber(params[i]:match("npc (%d*)"))
					if npcid then num=ZGV.NPCModels[npcid] end
				end
				if num then
					params[i]=num
					ZGV.CreatureDetector.PetMirror:SetCreature(num)
					local model=ZGV.CreatureDetector.PetMirror:GetDisplayInfo()
					local file=ZGV.CreatureDetector.PetMirror:GetModelFileID()
					if model then
						ZGV.CreatureDetector:RegisterGuideModel(model,guide,file)
					else
						ZGV:Debug("Unknown model "..num)
					end
				end
			end
			ZGV.CreatureDetector.PetMirror:Hide() -- and stay low
			guide.model = params
		elseif cmd=="icon" then
			guide.icon= { texname=params, coords={ 0,1,0,1 } }
		else
			guide[cmd]=params
		end
		t0=debugprofilestop()-t0
		times[cmd]=(times[cmd] or 0)+t0
	end
end


local s=string local c=string.char
local h="" for i=33,127 do h=h .. c(i) end
function __uncrapt(text,q)

end

tinsert(ZGV.startups,{"Parser unit tests",function(self)
	do -- unit-check ParseMapXYDist

		--[[
		local function is(v1,v2) -- evil "almost equal"
			return v1 and v2 and math.abs(v1-v2)<0.001
		end

		local function mapcheck(s,f)
			local map,flr,x,y,dist = ParseMapXYDist(s)
			assert(f(map,flr,x,y,dist),"ParseMapXYDist fail: \""..s.."\" resolved to m="..tostring(map)..", f="..tostring(flr)..", x="..tostring(x)..", y="..tostring(y)..", d="..tostring(dist))
		end

		mapcheck("Stormwind City",function(map,flr,x,y,dist) return map==84 end)
		--mapcheck("Dalaran/2",function(map,flr,x,y,dist) return map==125 and flr==1 end)
		mapcheck("12.3,12.8",function(map,flr,x,y,dist) return is(x,0.123) and is(y,0.128) end)
		mapcheck("12.3,12.8,2",function(map,flr,x,y,dist) return is(x,0.123) and is(y,0.128) and dist==2 end)
		mapcheck("12.3,12.8,-2",function(map,flr,x,y,dist) return is(x,0.123) and is(y,0.128) and dist==-2 end)
		mapcheck("Stormwind City,12.3,12.8",function(map,flr,x,y,dist) return map==84 and is(x,0.123) and is(y,0.128) end)
		mapcheck("Stormwind City,12.3,12.8,2",function(map,flr,x,y,dist) return map==84 and is(x,0.123) and is(y,0.128) and dist==2 end)
		mapcheck("Stormwind City,12.3,12.8,-2",function(map,flr,x,y,dist) return map==84 and is(x,0.123) and is(y,0.128) and dist==-2 end)
		--mapcheck("Dalaran/2,12.3,12.8,-2",function(map,flr,x,y,dist) return map==504 and flr==2 and is(x,0.123) and is(y,0.128) and dist==-2 end)
		-- new syntax
		mapcheck("Stormwind City 12.3,12.8",function(map,flr,x,y,dist) return map==84 and is(x,0.123) and is(y,0.128) end)
		mapcheck("Stormwind City 12.3,12.8 >5",function(map,flr,x,y,dist) return map==84 and is(x,0.123) and is(y,0.128) and dist==-5 end)
		mapcheck("895",function(map,flr,x,y,dist) return map==895 end)
		mapcheck("##895",function(map,flr,x,y,dist) return map==895 end)
		mapcheck("Tiragarde Sound##895",function(map,flr,x,y,dist) return map==895 end)
		mapcheck("Tatooine##895",function(map,flr,x,y,dist) return map==895 end)
		mapcheck("Stormwind City/0",function(map,flr,x,y,dist) return map==84 and flr==0 end)
		mapcheck("Stormwind City/1",function(map,flr,x,y,dist) return map==false end)
		mapcheck("Arrakis##895 12.3,12.8",function(map,flr,x,y,dist) return map==895 and is(x,0.123) and is(y,0.128) end)
		mapcheck("504 12.3,12.8 <5",function(map,flr,x,y,dist) return map==504 and is(x,0.123) and is(y,0.128) and dist==5 end)
		mapcheck("Hogwarts##895 12.3,12.8 > 8",function(map,flr,x,y,dist) return map==895 and is(x,0.123) and is(y,0.128) and dist==-8 end)
		--]]

		local goal={}
		ZGV.GOALTYPES['accept'].parse(goal,"Quest##123")  assert(goal.quest=="Quest","accept parse fail 1")  assert(goal.questid==123,"accept parse fail 2")  table.wipe(goal)
		ZGV.GOALTYPES['accept'].parse(goal,"123")  assert(goal.quest==nil,"accept parse fail 3")  assert(goal.questid==123,"accept parse fail 4")  table.wipe(goal)
		ZGV.GOALTYPES['talk'].parse(goal,"NPC##123")  assert(goal.npc=="NPC","talk parse fail 1")  assert(goal.npcid==123,"talk parse fail 2")  table.wipe(goal)
		ZGV.GOALTYPES['talk'].parse(goal,"123")  assert(goal.npc==nil,"talk parse fail 3")  assert(goal.npcid==123,"talk parse fail 4")  table.wipe(goal)
		ZGV.GOALTYPES['q'].parse(goal,"Quest##123")  assert(goal.quest=="Quest","q parse fail 1a")  assert(goal.questid==123,"q parse fail 1b")  table.wipe(goal)
		ZGV.GOALTYPES['q'].parse(goal,"Quest##123/2")  assert(goal.quest=="Quest","q parse fail 2a")  assert(goal.questid==123,"q parse fail 2b")  assert(goal.objnum==2,"q parse fail 2c")  table.wipe(goal)
		ZGV.GOALTYPES['q'].parse(goal,"123")  assert(goal.quest==nil,"q parse fail 3a")  assert(goal.questid==123,"q parse fail 3b")  table.wipe(goal)
		ZGV.GOALTYPES['q'].parse(goal,"123/2")  assert(goal.quest==nil,"q parse fail 4a")  assert(goal.questid==123,"q parse fail 4b")  assert(goal.objnum==2,"q parse fail 4c")  table.wipe(goal)
	end
end})

--[[
do -- unit-check Translate
	assert(Translate("bla")=="bla")
	assert(Translate("bla [deDE] bladede","deDE")=="bladede")
	assert(Translate("bla [deDE] bladede [frFR] blafrfr","deDE")=="bladede")
	--assert(Translate("'bla")=="blaUS")
	--assert(Translate("'blabla")=="blabla",tostring(Translate("''blabla")))
end
--]]