--[[
Name: LibTaxi-1.0
Revision: $Rev: 1 $
Author(s): sinus (sinus@sinpi.net)
Description: A library recording all player's currently known/unknown taxi routes.
Dependencies: None
License: Free for non-commercial use, except for Zygor Guides.
]]

local MAJOR_VERSION = "LibTaxi-1.0"
local MINOR_VERSION = tonumber(("$Revision: 1 $"):match("%d+"))

local addonname,addon = ...
-- #AUTODOC_NAMESPACE prototype

local GAME_LOCALE = GetLocale()

local ZGV,LibRover

do
	local LIB_MAJOR, LIB_MINOR = "LibTaxi-1.0", 1

	local Lib = LibStub:NewLibrary(LIB_MAJOR, LIB_MINOR)
	if not Lib then return end

	addon.Lib = Lib

	Lib.master = { }
	Lib.saved_tables = { }

	--Lib.TaxiNames_Local = nil
	--Lib.TaxiNames_English = nil

	-- Initialize localization. All taxis are stored as ENGLISH - lookups need pre-translation.
		if Lib.TaxiNames_Local then
			for en,lo in pairs(Lib.TaxiNames_Local) do if lo==1 then Lib.TaxiNames_Local[en]=en end end

			Lib.TaxiNames_English = {}
			for en,lo in pairs(Lib.TaxiNames_Local) do
				Lib.TaxiNames_English[lo]=en
			end

			local mt = { __index = function(t,k)  v=rawget(t,k)  if not v then print("|cffff4400Taxi |cffff8800"..k.."|r not translated to "..GetLocale()..", please report this to Zygor") return k elseif v==true then return k else return v end  end }
			setmetatable(Lib.TaxiNames_Local,mt)
			setmetatable(Lib.TaxiNames_English,mt)
		else
			local loc_stub = {}
			setmetatable(loc_stub,{ __index = function(t,k)  return k  end } )
			Lib.TaxiNames_Local = loc_stub
			Lib.TaxiNames_English = loc_stub
		end


	local minimap_exceptions = {
		["Trade District"] = "Stormwind",
		["The Great Forge"] = "Ironforge",
		["Terrace of Light"] = "Shattrath City",
		["The Stair of Destiny"] = "Hellfire Peninsula, The Dark Portal",
		["Valley of Strength"] = "Orgrimmar"
	}

	local ERR_NEWTAXIPATH=ERR_NEWTAXIPATH


	local function IterateCZNN(T)
		for c,cont in pairs(T) do
			for z,zone in pairs(cont) do
				for n,node in pairs(zone) do
					coroutine.yield(c,z,n,node)
				end
			end
		end
	end

	local function is_enemy(f1,f2)
		return (f1=="A" and f2=="H") or (f1=="H" and f2=="A")
	end
	Lib.is_enemy=is_enemy

	-- Add taxi to known. Used only for leeching off QuestHelper (obsolete?)
	local function addTaxi(name)
		local taxi
		if type(name)=="string" then
			local eng = Lib.TaxiNames_English[name] or Lib.TaxiNames_English[name:gsub(", .*","")]
			if type(eng)=="string" then name=eng end
			--print(i..": "..TaxiNodeName(i).." = "..name)
			if not name then
				print("|cffff8888LibTaxi Error: Untranslated taxi "..name.."|r")
				return
			end
			taxi = Lib:FindTaxi(name)
		else
			taxi = name
		end

		if taxi then
			Lib.master[taxi.name]=true
			taxi.known=true
		else
			if ZGV.DEV then print("|cffff8888LibTaxi Error: Unknown taxi "..name.."|r") end  -- DEVed prints at 2014-11-12
		end
	end

	-- two taxi nodes are switching during daily resets
	-- taxi map automatically refreshes knowledge when it is open, but we can also detect them by checking nodes on given map
	local antoran_rotating_nodes = {
		[1993] = true, -- The Veiled Den, Antoran Wastes
		[1992] = true, -- Light's Purchase, Antoran Wastes
	}

	local old_ontaxi
	function Lib.OnEvent(this, event, arg1,arg2)
		if event == "ADDON_LOADED" and arg1==addonname and not Lib.loaded then
			Lib.loaded=true
		elseif event == "TAXIMAP_OPENED" then
			Lib:ScanTaxiMap()
			if ZGV then ZGV:ShowWaypoints() end -- Force arrow to re-check itself -- Jeremiah
			if ZGV and ZGV.db and ZGV.db.profile.debug then ZGV:Debug("do |cffffff00/run ZGV.LibTaxi:DumpNeighborFlights()|r now to save these connections.") end
		elseif event == "UI_INFO_MESSAGE" then
			if arg2==ERR_NEWTAXIPATH then
				Lib:LearnCurrentTaxi()
				if ZGV and ZGV.LibRover then ZGV.LibRover:UpdateNow("quiet") end -- Try to force update of arrow ~~ Jeremiah
			end
		--elseif event == "UPDATE_FACTION" then --Faction update is not needed anymore.
			--Lib:MarkKnownByLevels() --Only needs to be ran once after the faction's information has been made available at startup
			--Lib.frame:UnregisterEvent("UPDATE_FACTION")
		end
	end

	Lib.errors = {}

	--- Gets all the known flight paths, in current locale.
	function Lib:GetTaxis()
		local paths = {}
		for fpath,t in pairs(Lib.master) do paths[Lib.TaxiNames_Local[fpath] or fpath]=t end
		return paths
	end

	--- Gets all the known flight paths, in English.
	function Lib:GetTaxisEnglish()
		local paths = {}
		for fpath,t in pairs(Lib.master) do paths[fpath]=t end
		return paths
	end

	local initialized_continents={}
	function Lib:Startup(newsave)
		ZGV = ZygorGuidesViewer
		LibRover = ZGV.LibRover

		Lib.frame = CreateFrame("Frame", "LibTaxiFrame")
		Lib.frame:RegisterEvent("TAXIMAP_OPENED")
		Lib.frame:RegisterEvent("UI_INFO_MESSAGE")
		Lib.frame:RegisterEvent("ADDON_LOADED")
		--Lib.frame:RegisterEvent("UPDATE_FACTION")
		--Lib.frame:RegisterEvent("UNIT_FLAGS")
		Lib.frame:SetScript("OnEvent", Lib.OnEvent)

		Lib.MapIDsByName = LibRover.data.MapIDsByName or ZGV.MapIDsByName

		Lib.master=newsave

		local LOCALE = GetLocale()
		Lib.master.translation = Lib.master.translation or {}
		Lib.master.translation[LOCALE] = Lib.master.translation[LOCALE] or {}
		Lib.translation = Lib.master.translation[LOCALE]

		Lib:InitializeTaxis()

		setmetatable(newsave,Lib.known_by_continent_mt)
		table.insert(Lib.saved_tables,newsave)

		Lib:CacheTaxiPoints()

		Lib:MergeData()
	
		Lib:MarkKnownTaxis()

		self:Debug("Startup complete.")
	end

	local function warn(message)
		local _, ret = pcall(error, message, 3)
		geterrorhandler()(ret)
	end

	-- return three-way node known status.
	-- true = known, obviously.  false = there's a marker indicating the continent is known, but the node is not.  nil = entirely unknown if known :P
	Lib.known_by_continent_mt = { __index=function(t,i)
			if rawget(t,i) then
				return true
			else
				local c = Lib.path2cont[i]
				if rawget(t,c) then
					return false
				else
					return nil
				end
			end
		end
	}

	Lib.path2cont = {}

	Lib.taxipoints = Lib.taxipoints or addon.LibTaxiData and addon.LibTaxiData.taxipoints

	Lib.flightcost = Lib.flightcost or addon.LibTaxiData and addon.LibTaxiData.flightcost

	addon.LibTaxiData = nil

	local enemyfac = "DON'T PRUNE" or (UnitFactionGroup("player")=="Alliance") and "H" or "A"-- TODO: REMOVE
	function Lib:InitializeTaxis()
		for c,cont in pairs(Lib.taxipoints) do
			for z,zone in pairs(cont) do
				z=LibRover:GetMapByNameFloor(z)
				local n=1
				while n<=#zone do
					local node=zone[n]
					if not node then break end
					if node.faction~=enemyfac then
						Lib.path2cont[node.name] = c
						node.m = z
						node.c = ZGV.GetMapContinent(z)
						node.localname = Lib.translation[node.taxitag]
						--node.level = LibRover and LibRover.data.ZoneContLev[z].level
						n=n+1
					else
						tremove(zone,n)
					end
				end
			end
		end
	end

	-- Get faction info because Andorhal has separate Horde and Alliance flight points with the same name. ~~ Jeremiah
	local playerF
	local factionEnglish = UnitFactionGroup("player")
	if factionEnglish == "Alliance" then
		playerF = "A"
	elseif factionEnglish == "Horde" then
		playerF = "H"
	end

	local aliases={["Stormwind City"]="Stormwind", ["Theramore Isle"]="Theramore"}
	local findtaxi_cache={}
	function Lib:FindTaxi(name,trim)
		if findtaxi_cache[name] then return findtaxi_cache[name] end
	
		if trim and name then name = name:gsub(", .*","") end  -- trim zone names (in european languages, at least)
		name = aliases[name] or name
		for c,z,n,node in ZGV.CoroPairs(Lib.taxipoints,IterateCZNN) do
			if not is_enemy(playerF,node.faction) and ( 
				node.name==name  -- raw name, pretty rare
				or node.name==(type(name)=="string" and name:gsub(", .*",""))  -- node name with zone appended
			)
			then
				findtaxi_cache[name] = node
				return node
			end
		end
	end

	Lib.fc_by_tag = {}
	Lib.fcnames_by_tag = {}
	Lib.fc_by_nodeID = {}
	Lib.fcnames_by_nodeID = {}
	-- cache tag->fcost, tag->fname, nodeID->fcost and nodeID->fname mappings
	function Lib:CacheTaxiTags()
		self:Debug("Caching taxi tags... playerF=%s",playerF)  local t=debugprofilestop()
		-- order flightcosts by tag for quick retrieval
		for cont,conttaxis in pairs(Lib.flightcost) do
			Lib.fc_by_tag[cont] = {}
			Lib.fcnames_by_tag[cont] = {}
			for ti,taxi in pairs(conttaxis) do
				if taxi.nodeID then
					if not is_enemy(taxi.faction,playerF) then
						Lib.fc_by_nodeID[taxi.nodeID] = taxi
					end
					Lib.fcnames_by_nodeID[taxi.nodeID] = taxi.name
				end
				if taxi.tag then
					if not is_enemy(taxi.faction,playerF) then
						Lib.fc_by_tag[cont][taxi.tag] = taxi
					end
					Lib.fcnames_by_tag[cont][taxi.tag] = taxi.name
				end
			end
		end

		self:Debug("Caching taxi tags done, took %.3fms",debugprofilestop()-t)
	end

	Lib.fnode_by_tag = {}
	Lib.fnode_by_nodeID = {}
	-- cache tag->node and nodeID->node mappings
	function Lib:CacheTaxiPoints()
		for c,z,n,node in ZGV.CoroPairs(Lib.taxipoints,IterateCZNN) do
			Lib.fnode_by_tag[c] = Lib.fnode_by_tag[c] or {}
			if not is_enemy(playerF,node.faction) then
				if node.taxitag then Lib.fnode_by_tag[c][node.taxitag]=node end
				if node.taxinodeID then Lib.fnode_by_nodeID[node.taxinodeID]=node end
				node._zone = z
			end
		end
	end
	
	function Lib:FindTaxiByTag(cont,tag)
		if not Lib.fnode_by_tag[cont] then Lib:CacheTaxiPoints() end
		Lib.fnode_by_tag[cont] = Lib.fnode_by_tag[cont] or {}
		return Lib.fnode_by_tag[cont][tag]
	end

	function Lib:FindTaxiByNodeID(nodeID)
		nodeID=tonumber(nodeID)
		if not Lib.fnode_by_nodeID[nodeID] then Lib:CacheTaxiPoints() end
		return Lib.fnode_by_nodeID[nodeID]
	end

	function Lib:GetTaxiDataBySlot()
		local continent = ZGV:GetCurrentMapContinent()

		local taxidata = {}
		for i=1,NumTaxiNodes() do
			local x,y = TaxiNodePosition(i)
			local taxitag = ("%03d:%03d"):format(x*1000,y*1000)
			local type = TaxiNodeGetType(i)
			taxidata[i] = {name = TaxiNodeName(i), slotIndex = i, state = (type=="CURRENT" and 0) or (type=="REACHABLE" and 1) or 2, position={x=x,y=y}, taxitag=taxitag}
		end		
		local taxidata_by_slot = {}
		for i,taxi in ipairs(taxidata) do taxidata_by_slot[taxi.slotIndex]=taxi end
		return taxidata,taxidata_by_slot
	end

	function Lib:ClearAllKnowledge(status)
		for c,cont in pairs(Lib.taxipoints) do
			Lib:ClearContinentKnowledge(c,"all",status)
		end
		if status~=true then table.wipe(Lib.master) end
	end

	function Lib:ClearContinentKnowledge(cont,operator,status)
		if not cont then cont=ZGV.GetCurrentMapContinent() end
		if cont==830 or cont==882 or cont==885 then cont=994 end  -- Argus zones need to have a common continent (not so much for ants!).
		for z,zone in pairs(Lib.taxipoints[cont]) do
			for n,node in ipairs(zone) do
				if node.factionid~=1031
				and (node.taxioperator==operator or operator=="all")
				then
					node.known=status
					if node.nodeID then Lib.master[node.nodeID]=status end
					if node.taxitag then Lib.master[node.taxitag]=status end
				end
			end

			--[[
				local zoneid = LibRover.data.MapIDsByName[z]
				if type(zoneid)=="table" then zoneid=zoneid[1] end  -- might cause trouble on phased maps :/
				zoneid=ZGV.Pointer:SanitizePhase(zoneid)
				if LibRover.MapLevels[zoneid]<UnitLevel("player") then -- only set contin that is our level to false
					for n,node in ipairs(zone) do
						if node.factionid~=1031 then
							if node.known==true then node.known=known end
							if Lib.master[node.name]==true then Lib.master[node.name]=known end
						end
					end
				end
			--]]  -- what was that supposed to do?  mark correct level nodes as unknown? O_o  ~sinus
		end
		Lib.master[cont]=status
	end

	function Lib:MarkContinentSeen(cont)
		self:Debug("Marking all unseen nodes on continent |cffffffff%d|r as |cff000000unknown|r.",cont)
		for z,zone in pairs(self.taxipoints[cont]) do  for ni,node in ipairs(zone) do
				if node.known==nil then self:LearnTaxi(node,false) end
		end  end
	end

	function Lib:MarkKnownTaxis() -- Fill .known fields using saved data.
		local level = UnitLevel("player")
		for c,cont in pairs(Lib.taxipoints) do
			for z,zone in pairs(cont) do
				local zoneid = self.MapIDsByName[z]
				if type(zoneid)=="table" then zoneid=zoneid[1] end  -- might cause trouble on phased maps :/
				zoneid=ZGV and ZGV.Pointer:SanitizePhase(zoneid)
				
				local function knowNode(node,known)
					node.known=known
					if node.taxinodeID then Lib.master[node.taxinodeID]=known end
				end
				
				for n,node in ipairs(zone) do
					if node.taxioperator and node.taxioperator=="blackcat" then  --All blackcats are usable by an alliance character
						self:LearnTaxi(node,true)
					elseif node.quest and IsQuestFlaggedCompleted(node.quest) then  --quest-based nodes are known
						self:LearnTaxi(node,true)
					elseif Lib.master[node.name]~=nil then -- we know it or we know we don't, simplest case
						node.known=Lib.master[node.name]
						if type(node.known)=="string" then node.known=not not node.known end  -- master has tags now, so convert back to boolean
					elseif false and not Lib.master[c] then  -- we didn't scan this continent yet, so let's do some guessing
						-- DON'T GUESS! LibRover will "guess" if it wants to. Leave it as nil (if it wasn't falsified by the continent being seen).

						--[[ if LibRover.data.ZoneContLev[zoneid].level<=level  -- zone is lower level than player, we should know all taxis by now
						  and LibRover.data.ZoneContLev[zoneid].level<85  -- except newer expansions - these are not learned by level
						  then
							if  (node.quest and not ZGV.completedQuests[node.quest]) -- we didn't do the quest
								or (node.factionid and select(3,GetFactionInfoByID(node.factionid))<node.factionstanding) -- we're not esteemed enough
								or (node.condition and not node.condition()) -- condition fail
								or (node.class and select(2,UnitClass("player"))~=node.class) -- we're the wrong class
							then
								node.known = false
							else
								node.known = true
							end
						end --]]

					end
				end
			end
		end
	end

	function Lib:MarkKnownByLevels() -- OLD, REFURBISHED!
		local level = UnitLevel("player")
		for c,cont in pairs(Lib.taxipoints) do  if not Lib.master[c] then
			for z,zone in pairs(cont) do
				local zoneid = self.MapIDsByName[z]
				if type(zoneid)=="table" then zoneid=zoneid[1] end  -- might cause trouble on phased maps :/
				zoneid=ZGV and ZGV.Pointer:SanitizePhase(zoneid)
				--[[if LibRover.MapLevels[zoneid]<=level  -- zone is lower level than player, we should know all taxis by now
				  and LibRover.MapLevels[zoneid]<85  -- Pandaria Zones are not learned by level
				  then
					for n,node in ipairs(zone) do
						if node.known==nil then node.known=true	end

						if  (node.quest and not ZGV.completedQuests[node.quest]) -- we didn't do the quest
							or (node.factionid and select(3,GetFactionInfoByID(node.factionid))<node.factionstanding) -- we're not esteemed enough
							or (node.condition and not node.condition()) -- condition fail
							or (node.class and select(2,UnitClass("player"))~=node.class) -- Class only! woo
						then
							node.known = false
						end

						if not node.known then Lib.master[node.name]=false end

						if Lib.master[node.name]==nil then Lib.master[node.name]=true end
					end
				else --]]
					for n,node in ipairs(zone) do
						if node.taxioperator and node.taxioperator=="blackcat" then node.known = true end --All blackcats are useable by an alliance character

						if node.available then
							self:LearnTaxi(node,node.available) --OVERWRITE. If we gave something special so don't worry about the others
						elseif node.achievemissing then
							-- If the player has the achievement, then the node is missing.
							node.missing = select(13,GetAchievementInfo(node.achievemissing)) -- 13 = whether this toon has the achievement.
						elseif Lib.master[node.name]==false then --if zone is overlevel and for some reason it is false, set it back to nil
							Lib.master[node.name]=nil
						elseif Lib.master[node.name]==true then -- we know a flightpath that is over our level
							node.known=true
						end
					end
				--end
			end
		end  end
	end

	function Lib:ResetKnowledge()
		Lib:ClearAllKnowledge()
		Lib:MarkKnownTaxis()
	end




	local hooked
	function Lib:Debug_HookButtons()
		if ZGV and ZGV.DEV then
			if not hooked then
				hooksecurefunc("TaxiNodeOnButtonEnter",function(button)
					local taxidata,taxidata_by_slot = self:GetTaxiDataBySlot()
					local slot=tonumber(button:GetID())
					local cont=ZGV.GetCurrentMapContinent()
					local taxix,taxiy = TaxiNodePosition(slot)
					local nodeID = taxidata_by_slot[slot] and taxidata_by_slot[slot].nodeID
					local taxitag = ("%03d:%03d"):format(taxix*1000,taxiy*1000)
					local taxinode = nodeID and self:FindTaxiByNodeID(nodeID) or self:FindTaxiByTag(cont,taxitag)
					self:Debug(("Taxi %d = %03d:%03d id %d (%s, node #%s)"):format(slot or 0,taxix*1000 or 0,taxiy*1000 or 0,nodeID or 0,taxinode and taxinode.npc or "npc", taxinode and taxinode.num  or  LibRover.nodes.taxi and #LibRover.nodes.taxi>0 and "???"  or  "Travel-not-initialized"))
				end)
				hooked=true
			end

			if TaxiFrame:IsShown() then
				taxiparent = TaxiFrame
			elseif FlightMapFrame:IsShown() then
				taxiparent = FlightMapFrame
			end

			taxiparent.TaxiFrameButton = taxiparent.TaxiFrameButton or ZGV.ChainCall(CreateFrame("BUTTON","ZGVLibTaxiButton_in_"..taxiparent:GetName(),taxiparent,"UIPanelButtonTemplate"))
			:SetPoint("TOPRIGHT",taxiparent,"TOPRIGHT",0,-20)
			:SetSize(160,20)
			:SetText("[Z] Scan taxi routes")
			:SetScript("OnClick",function() Lib:DeepScanTaxiMap() end)
			:SetScript("OnEnter",function(self) ZGV.ChainCall(GameTooltip) :ClearAllPoints() :ClearLines() :SetOwner(self,"ANCHOR_BOTTOM") :AddLine("Scan connections from this point, update the connections database|nand display it for copy-pasting.",1,1,1) :AddLine("Hold SHIFT to dump ALL continents |cffff8800(may take time!)|r",1,1,1) :Show()  end)
			:SetScript("OnLeave",function() GameTooltip:Hide() end)
			:SetFrameLevel(100)
			--:RegisterForClicks("AnyUp")
			:Hide()
			.__END

			taxiparent.TaxiFrameButton2 = taxiparent.TaxiFrameButton2 or ZGV.ChainCall(CreateFrame("BUTTON","ZGVLibTaxiButton_in_"..taxiparent:GetName(),taxiparent,"UIPanelButtonTemplate"))
			:SetPoint("TOPRIGHT",taxiparent,"TOPRIGHT",0,-40)
			:SetSize(160,20)
			:SetText("[Z] View details")
			:SetScript("OnClick",function() Lib:DEV_ViewTaxiMapData() end)
			:SetFrameLevel(100)
			--:RegisterForClicks("AnyUp")
			:Hide()
			.__END
			if ZGV.db.profile.debug_display then
				taxiparent.TaxiFrameButton:Show()
				taxiparent.TaxiFrameButton2:Show()
			end
		end
	end

	-- Scan an open taxi map for (a) node positions, names and "known" status, (b) node connections.
	function Lib:ScanTaxiMap()
	
		if not TaxiFrame:IsShown() then self:Debug("Map not shown, unable to scan."); return end

		self:Debug_HookButtons()

		local cont = ZGV.GetCurrentMapContinent()

		self:Debug("Scanning map for continent %d...",cont)

		local taxidata,_ = Lib:GetTaxiDataBySlot()

		-- switch to a specific operator
		local current_operator
		for i,taxi in ipairs(taxidata) do
			if taxi.state==0 then
				local taxinode = Lib:FindTaxiByTag(cont,taxi.taxitag)
				if taxinode then
					current_operator=taxinode.taxioperator
				else
					self:Debug("Current taxi nodeID %d %s NOT found in continent %d data! Update please!",taxi.nodeID,taxi.name,cont)
				end
				break
			end
		end

		self:Debug("We're on continent |cffffffff%d|r, and will be flying |cffffffff%s|r airlines.",cont,current_operator or "default")

		local currenttaxi

		local new_discovered=0

		for i,taxi in ipairs(taxidata) do  repeat
			if taxi.state==0 then currenttaxi=i end

			-- check the node itself

			local name = taxi.name

			-- EVIL BLIZZARD: "Temple of Karabor" at Draenor 766:315 is THE SAME as "Tranquil Court", but is DISTANT and has zero hops. Kill it and its kin.
			-- NOT ANYMORE. Distant points are now often zero-hopped. This caused MANY points to be skipped.
			--if GetNumRoutes(i)==0 and taxitype=="DISTANT" and TaxiNodeCost(i)==0 then  self:Debug("Taxi "..name.." gets skipped.")  break  end --continue
			
			local taxitag = ("%03d:%03d"):format(taxi.position.x*1000,taxi.position.y*1000)  -- get rid of this

			-- localize node, if that's even used anymore
			local taxinode = Lib:FindTaxiByTag(cont,taxi.taxitag)
			local fcdata = Lib.fc_by_nodeID[taxi.nodeID] or Lib.fc_by_tag[cont][taxitag]

			local tagstring
			if fcdata and fcdata.tag and fcdata.tag~=taxitag then tagstring=("old tag %s preserved, new tag %s ignored"):format(fcdata.tag,taxitag)
				else tagstring=("tag %s"):format(taxitag) end

			if taxinode then
				--self:Debug("found %s [%s]",taxi.name,taxitag)
				if taxinode.taxioperator == current_operator then
					Lib:LearnTaxi(taxinode, taxi.state==0 or taxi.state==1)
					self:Debug("%s taxi: %s [nodeID %d, %s]",(taxi.state==0 or taxi.state==1) and "|cff88ff88Known" or "|cffff8888Unknown",name,taxi.nodeID,tagstring)
				end
				taxinode.localname = taxinode.localname or taxi.name
				--self:Debug("Taxi: "..taxi.taxitag.." "..taxi.name.." ".. taxitype)
			else
				self:Debug("|cffff8888NPC missing in continent %d data: %s [nodeID %d, %s]",cont,name,taxi.nodeID,tagstring)
				--tinsert(self.errors,("taxi missing in data: %s [%s] [%.5f,%.5f]"):format(name,taxitag,taxix,taxiy))
			end
			
			if not fcdata then
				fcdata = {}
				Lib.flightcost[cont]=Lib.flightcost[cont] or {}
				tinsert(Lib.flightcost[cont],fcdata)
				ZGV:Debug(("New taxi point discovered! %s (nodeID %d, %s)"):format(taxi.name,taxi.nodeID,tagstring))
				new_discovered=new_discovered+1
			end
			fcdata.name = fcdata.name or name
			fcdata.nodeID = fcdata.nodeID or taxi.nodeID
			fcdata.tag = fcdata.tag or taxitag

		until true  end

		-- leech off QH
		if QuestHelper_KnownFlightRoutes then
			for name,_ in pairs(QuestHelper_KnownFlightRoutes) do
				addTaxi(name)
			end
		end

		if ZGV.Pointer.tmp_taxis_assumed then LibRover:UpdateNow() end

		if new_discovered>0 then ZGV:Debug("%d new nodes discovered. You may wish to Scan Taxi Map and update the data now.",new_discovered) 
		else self:Debug("No new nodes discovered.") end

		self:MarkContinentSeen(cont)

		self:CacheTaxiTags()
		self:CacheTaxiPoints()
		self:MergeData()

	end


	-- /run LibTaxi:DeepScanTaxiMap()
	-- /run LibTaxi:DumpFlightCosts()
	-- Called with Dump Taxi Connections button
	function Lib:DeepScanTaxiMap()  -- DEV FUNCTION
		if not TaxiFrame:IsShown() and not FlightMapFrame:IsShown() then self:Debug("Map not shown, unable to scan."); return end
		local cont = ZGV.GetMapContinent(C_Map.GetBestMapForUnit("player"))
		print("Continent is",cont)
		Lib.flightcost[cont] = Lib.flightcost[cont] or {}
		local fccont = Lib.flightcost[cont]

		-- check connections

		local connections=0

		self.fc_by_tag[cont] = self.fc_by_tag[cont] or {}
		self.fcnames_by_tag[cont] = self.fcnames_by_tag[cont] or {}

		local taxidata,taxidata_by_slot = self:GetTaxiDataBySlot()

		local reachable=1

		for dest=1,NumTaxiNodes() do if TaxiNodeGetType(dest)=="REACHABLE" then
			reachable=reachable+1
			local startnode,endnode,starttag,endtag
			local x,y

			for hop=1,GetNumRoutes(dest) do

				startnode=TaxiGetNodeSlot(dest,hop,true)
				x,y = TaxiNodePosition(startnode)
				starttag = ("%03d:%03d"):format(x*1000,y*1000)

				endnode=TaxiGetNodeSlot(dest,hop,false)
				x,y = TaxiNodePosition(endnode)
				endtag = ("%03d:%03d"):format(x*1000,y*1000)

				local hops = ("%s to %s"):format(TaxiNodeName(startnode),TaxiNodeName(endnode))

				if starttag~=endtag then
					local new
					local startnodeID = taxidata_by_slot[startnode] and taxidata_by_slot[startnode].nodeID
					local fcstart = self.fc_by_nodeID[startnodeID] or self.fc_by_tag[cont][starttag]
					if not fcstart then
						fcstart={name=TaxiNodeName(startnode),tag=starttag,nodeID=startnodeID}
						tinsert(fccont,fcstart)
						-- put in cache, too
						self.fc_by_tag[cont][starttag]=fcstart
						if startnodeID then self.fc_by_nodeID[fcstart.nodeID]=fcstart end
						self.fcnames_by_tag[cont][starttag]=fcstart.name
						if startnodeID then self.fcnames_by_nodeID[fcstart.nodeID]=fcstart.name end
						hops = hops .. ("|cff00ff00<-NEW START|r ")
					end

					local endnodeID = taxidata_by_slot[endnode] and taxidata_by_slot[endnode].nodeID
					local fcend = self.fc_by_nodeID[endnodeID] or self.fc_by_tag[cont][endtag]
					if not fcend then
						fcend={name=TaxiNodeName(endnode),tag=endtag,nodeID=endnodeID}
						tinsert(Lib.flightcost[cont],fcend)
						-- put in cache, too
						self.fc_by_tag[cont][endtag]=fcend
						if endnodeID then self.fc_by_nodeID[fcend.nodeID]=fcend end
						self.fcnames_by_tag[cont][endtag]=fcend.name
						if endnodeID then self.fcnames_by_nodeID[fcend.nodeID]=fcend.name end
						hops = hops .. ("|cff00ff00<-NEW END|r ")
					end

					fcstart.neighbors = fcstart.neighbors or {}
					if not fcstart.neighbors[fcend.tag] and not fcstart.neighbors[fcend.nodeID] then new=1 end
					fcstart.neighbors[fcend.tag] = fcstart.neighbors[fcend.tag] or 0

					fcend.neighbors = fcend.neighbors or {}
					if not fcend.neighbors[fcstart.tag] and not fcend.neighbors[fcstart.nodeID] then new=1 end
					fcend.neighbors[fcstart.tag] = fcend.neighbors[fcstart.tag] or 0
					if new then
						connections=connections+1
						hops = hops .. ("|cff00ff00<-NEW|r ")
					end
				end

				startnode=endnode
				starttag=endtag

				print(hops)
			end

		end end


		-- Missing hops have now been given the "0" time. Enough to get connections right.

		print(("=== %d nodes, %d reachable, %d new connections. ==="):format(NumTaxiNodes(),reachable,connections))
		LibTaxi:DEV_DumpFlightCosts()
	end


	function Lib:DEV_ViewTaxiMapData()  -- DEV FUNCTION (simple)
		if not TaxiFrame:IsShown() and not FlightMapFrame:IsShown() then self:Debug("Map not shown, unable to scan."); return end
		local cont = ZGV.GetCurrentMapContinent()

		local ret = {}
		local rett = {}

		local taxidata,taxidata_by_slot = self:GetTaxiDataBySlot()
		
		for dest=1,NumTaxiNodes() do repeat
		
			local x,y = TaxiNodePosition(dest)
			local taxitag = ("%03d:%03d"):format(x*1000,y*1000)

			local taxitype=TaxiNodeGetType(dest)

			local s

			if not taxidata_by_slot[dest] then s = ("%d. %s (%s) - Sanity fault, not in taxidata!"):format(dest,TaxiNodeName(dest),taxitype) tinsert(ret,s) tinsert(rett,{"?"}) break end
			
			local taxi = Lib:FindTaxiByNodeID(taxidata_by_slot[dest].nodeID) or Lib:FindTaxiByTag(cont,taxitag)

			local texkit = taxidata_by_slot[dest].textureKitPrefix or ""

			local s = ("%2d. %s%s%s|r [ID |cffff8800%d|r, |cffffdd00%d|r hops, %s, %s)"):format(
				dest,
				    taxitype=="CURRENT" and "|cffbbff88"
				 or taxitype=="REACHABLE" and "|cff00ff00"
				 or taxitype=="DISTANT" and "|cff888888"
				 or "|cffff0000",
				TaxiNodeName(dest),
				    texkit:match("_Ferry") and "|r - |cff88ddffFERRY|r"
				    or (taxi and taxi.taxioperator=="seahorse" and "|r - |cff88ffddSEAHORSE|r")
				 or "",
				taxidata_by_slot[dest].nodeID,
				GetNumRoutes(dest),
				taxitype,
				taxi and (     (TaxiNodeCost(dest)==0 and taxitype=="DISTANT" and "|cff888888DISABLED|r")
					        or (taxi.known==true and "|cff00ff00KNOWN|r")
					        or (taxi.known==false and "|cffff8800UNKNOWN|r")
					        or "|cffff0000???|r")
				     or "|cffff0000NPC NOT FOUND|r"
				)

			tinsert(ret,s)
			tinsert(rett,taxi or {"?"})

		until true end
		-- Missing hops have now been given the "0" time. Enough to get connections right.

		if Spoo then
			local retz = {}
			for i,s in ipairs(ret) do retz[s]=rett[i] end
			Spoo(nil,nil,retz)
		else
			ZGV:ShowDump(table.concat(ret,"\n"),"Taxi data for continent "..cont)
		end
	end


	
	

	-- And now, the EVIL. Let's peek into a taxi before it flies.
	-- LibTaxi.LastTaxi becomes the node of the last taxi taken!

	local Saved_TakeTaxiNode = TakeTaxiNode
	_G.TakeTaxiNode = function(index)
		local taxidata,taxidata_slots = Lib:GetTaxiDataBySlot()
		local data = taxidata_slots[index]
		if data and (data.nodeID or data.taxitag) then
			Lib.LastTaxi = {fullname=data.name}
			Lib.LastTaxi.node = (data.nodeID and Lib:FindTaxiByNodeID(data.nodeID)) or (data.taxitag and Lib:FindTaxiByTag(ZGV:GetCurrentMapContinent(),data.taxitag))
			ZGV:Debug("LibTaxi: TakeTaxiNode proxy, flying to %s (nodeID %d, taxitag %s)",data.name,data.nodeID or -1,data.taxitag or "-")
			if Lib.LastTaxi.node then
				Lib.LastTaxi.name,Lib.LastTaxi.zone = Lib.LastTaxi.node.name,ZGV.GetMapNameByID(Lib.LastTaxi.node.m)
				--Lib.LastTaxi.name,Lib.LastTaxi.zone = Lib.LastTaxi.node.name,(Lib.LastTaxi.node.m and ZGV.GetMapNameByID(Lib.LastTaxi.node.m) or ("(bad map in '"..Lib.LastTaxi.name.."')")) -- just in case? or was it a bad update that broke in here?
			else
				Lib.LastTaxi.name,Lib.LastTaxi.zone = Lib.LastTaxi.fullname:match("(.*), (.*)")
			end
		else
			ZGV:Debug("LibTaxi: destination taxi not found!")
		end
		Saved_TakeTaxiNode(index,"",true)
	end

	local function __genOrderedIndex( t )
	    local orderedIndex = {}
	    for key in pairs(t) do
		table.insert( orderedIndex, key )
	    end
	    table.sort( orderedIndex )
	    return orderedIndex
	end

	local function orderedNext(t, state)
	    -- Equivalent of the next function, but returns the keys in the alphabetic
	    -- order. We use a temporary ordered key table that is stored in the
	    -- table being iterated.

	    --print("orderedNext: state = "..tostring(state) )
	    if state == nil then
		-- the first time, generate the index
		t.__orderedIndex = __genOrderedIndex( t )
		key = t.__orderedIndex[1]
		return key, t[key]
	    end
	    -- fetch the next value
	    key = nil
	    for i = 1,table.getn(t.__orderedIndex) do
		if t.__orderedIndex[i] == state then
		    key = t.__orderedIndex[i+1]
		end
	    end

	    if key then
		return key, t[key]
	    end

	    -- no more value to return, cleanup
	    t.__orderedIndex = nil
	    return
	end

	local function ordered_pairs(t)
	    -- Equivalent of the pairs() function on tables. Allows to iterate
	    -- in order
	    return orderedNext, t, nil
	end

	function Lib:DEV_FindNodeIDs(operator)
		local continent = ZGV:GetCurrentMapContinent()
		local taxidata = C_TaxiMap:GetAllTaxiNodes(continent)
		local count_ided=0
		local count_alreadyided=0
		local count_failed=0
		local failed={}
		print("Grabbing nodeIDs for continent ",continent)

		-- find IDs for nodes that don't have them yet
		for i,taxi in ipairs(taxidata) do

			local found={}
			for ti,taxicost in ipairs(Lib.flightcost[continent]) do
				if taxicost.name==taxi.name and (taxicost.taxioperator==operator) and not is_enemy(taxicost.faction,playerF) then
					found[#found+1]=taxicost
				end
			end
			if #found==0 then print(taxi.name," - NOT FOUND") count_failed=count_failed+1 failed[#failed+1]=taxi.name
			elseif #found>=2 then print(taxi.name," - FOUND MANY:") for ti,foundt in ipairs(found) do print(foundt.tag) end count_failed=count_failed+1 failed[#failed+1]=taxi.name
			elseif found[1].nodeID then
				count_alreadyided=count_alreadyided+1
			else
				-- 1 found
				--print(taxi.name," - found ",found[1].tag)
				found[1].nodeID=tonumber(taxi.nodeID)
				count_ided=count_ided+1
			end
		end

		-- count remaining
		local remain={}
		local count_remainall=0
		for cont,taxicont in pairs(Lib.flightcost) do
			for ti,taxi in ipairs(taxicont) do
				if not taxi.nodeID then count_remainall=count_remainall+1 end
				if cont==continent and not is_enemy(taxi.faction,playerF) and not taxi.nodeID then
					tinsert(remain,taxi)
				end
			end
		end

		print("FAILED: ")  for i,fname in ipairs(failed) do print(fname) end
		print("REMAIN: ",#remain)  for i,taxi in ipairs(remain) do print(taxi.name)  if i>=10 then print("...") break end end
		print(#taxidata," nodes visible, ",count_alreadyided," nodes already IDed, ",count_ided," nodes IDed now, ",count_failed," failed. ",#remain," remain for this continent. ",count_remainall," remain in total.")
		Lib:DEV_DumpFlightCosts(continent)
	end

	function Lib:DEV_ConvertCostsToNodeID()

		local count_converted=0
		local count_unknown=0
		local count_nonodeid=0
		local count_already=0
		local unique_unknown={}
		local unique_unknown_num=0
		local unique_nonodeid={}
		local unique_nonodeid_num=0

		for contnum,contdata in pairs(self.flightcost) do
			for i,taxi in ipairs(contdata) do
				local new_neighbors={}

				local count_connections_before=0
				local total_cost_before=0
				for tag,cost in pairs(taxi.neighbors or {}) do  total_cost_before=total_cost_before+cost  count_connections_before=count_connections_before+1  end

				for tag,cost in pairs(taxi.neighbors or {}) do
					
					if tonumber(tag) and self.fc_by_nodeID[tag] then
						count_already=count_already+1
						new_neighbors[tag]=cost -- keep it
					else
						local neigh = self.fc_by_tag[contnum][tag]
						if not neigh then
							--print(taxi.name,"has unknown neighbor",tag)
							new_neighbors[tag]=cost -- keep it
							count_unknown=count_unknown+1
							if not unique_unknown[tag] then
								unique_unknown[tag]=cost
								unique_unknown_num=unique_unknown_num+1
							end
						elseif not neigh.nodeID then
							--print(taxi.name,"'s neighbor",tag,"has no nodeID")
							new_neighbors[tag]=cost -- keep it
							count_nonodeid=count_nonodeid+1
							if not unique_nonodeid[tag] then
								unique_nonodeid[tag]=tag.." "..neigh.name
								unique_nonodeid_num=unique_nonodeid_num+1
							end
						else
							new_neighbors[neigh.nodeID]=cost
							count_converted=count_converted+1
						end
					end
				end

				local count_connections_after=0
				local total_cost_after=0
				for tag,cost in pairs(taxi.neighbors or {}) do  total_cost_after=total_cost_after+cost  count_connections_after=count_connections_after+1  end

				if count_connections_before~=count_connections_after then print("|cffff0000ERROR! ",taxi.tag,taxi.name,"had",count_connections_before,"connections, now has",count_connections_after) end
				if total_cost_before~=total_cost_after then print("|cffff0000ERROR! ",taxi.tag,taxi.name,"had",total_cost_before,"costs, now has",total_cost_after) end

				taxi.neighbors=new_neighbors
			end
		end

		local nonodeids = ""
		for tag,tagname in pairs(unique_nonodeid) do nonodeids=nonodeids.." "..tagname.."," end

		print("Converted costs from tag to node ID: ",count_already,"already good,",count_converted,"converted,\n",unique_nonodeid_num,"(",count_nonodeid,") missing nodeID:",nonodeids,"\n",unique_unknown_num,"(",count_unknown,") orphaned:",table.concat(ZGV.TableKeys(unique_unknown),", "))
	end

	-- /run LibTaxi:DumpFlightCosts()
	function Lib:DEV_DumpFlightCosts(onlycont)
		if onlycont==true or not IsShiftKeyDown() then onlycont=ZGV.GetMapContinent(C_Map.GetBestMapForUnit("player")) end

		local s=""
		if not onlycont then s="data.flightcost = {\n" end

		for contnum,contdata in ZGV.OrderedPairs(Lib.flightcost) do  repeat
			if onlycont and contnum~=onlycont then break end  --continue

			s=s.."	["..contnum.."]={\n"
			
			local function tagsort(a,b) return a.tag and b.tag and a.tag<b.tag end
			local function namesort(a,b) return a.name<b.name end
			table.sort(contdata,namesort)

			for i,data in ipairs(contdata) do
				s=s.."		{\n"
				s=s.."			name = \""..data.name.."\",\n"
				
				if data.taxioperator then s=s.."			taxioperator = \""..data.taxioperator.."\",\n" end
				if data.faction then s=s.."			faction = \""..data.faction.."\",\n" end
				if data.comment then s=s.."			comment = \""..data.comment.."\",\n" end

				for k,v in pairs(data) do if k~="taxioperator" and k~="faction" and k~="comment" and k~="name" and k~="neighbors" and k~="tag" and k~="nodeID" then print("Odd data key",k) end end
				
				if data.neighbors then
					s=s.."			neighbors = {\n"

					local sorted_neighs={}
					for ntag,cost in pairs(data.neighbors) do tinsert(sorted_neighs,ntag) end
					table.sort(sorted_neighs,ZGV.NumericSafeSort)

					for j,ntag in ipairs(sorted_neighs) do
						local cost = data.neighbors[ntag]
						local name = self.fcnames_by_nodeID[ntag] or self.fcnames_by_tag[contnum][ntag]
						s = s .. "				["..(tonumber(ntag) and ntag or "\""..ntag.."\"").."] = "..cost..", -- " .. (name or "?") .. "\n"
					end
					s=s.."			},\n"
				end
				if data.tag then s=s.."			tag=\""..data.tag.."\",\n" end
				if data.nodeID then s=s.."			nodeID = "..data.nodeID..",\n" end
				s=s.."		},\n"
			end
			s=s.."	},\n"
		until true end
		if not onlycont then  s=s.."}\n"  end
		ZGV:ShowDump(s,"Paste into LibTaxi/data.lua"..(onlycont and " WHERE APPROPRIATE" or ""))
	end

	--[[ unused?
		function Lib:MergeTags__()  --unused?
			if not LibRover.data.flightcost then return end  -- shouldn't be any anyway
			for contnum,contdata in ipairs(LibRover.data.flightcost) do
				for tag,taxidata in pairs(contdata) do
					local taxinode = Lib:FindTaxi(taxidata.Name, "trim")
					if not taxinode then
						if ZGV.DEV then print("WHOA. Taxi node not found: ",taxidata.Name) end   -- DEVed prints at 2014-11-12
					else
						taxinode.taxitag = tag
						taxinode.pre_costs = taxidata.Neighbors
					end
				end
			end
		end
	--]]

	-- unused for now, but workable and fun!
	local function table_dig_pairs(tab,depth,func,keys)
		keys=keys or {}
		if depth==1 then
			for k,v in pairs(tab) do
				table.insert(keys,k)
				table.insert(keys,v)
				func(unpack(keys))
				table.remove(keys)
				table.remove(keys)
			end
		else
			for k,v in pairs(tab) do
				table.insert(keys,k)
				table_dig_pairs(v,depth-1,func,keys)
				table.remove(keys)
			end
		end
	end


	-- Pull "flightcost" data into taxipoints.
	function Lib:MergeData()
		local FC=Lib.flightcost
		if not FC then print("Need flightcosts data") return end

		-- for each taxi NPC find its nodeID and tag.
		for c,z,ni,node in ZGV.CoroPairs(Lib.taxipoints,IterateCZNN) do repeat
			local found
			for fi,fcdata in pairs(FC[c]) do
				if (node.taxinodeID and node.taxinodeID==fcdata.nodeID) -- perfect match by nodeID
				or (
					not node.taxinodeID -- don't match nodeID-ed nodes by name!
					and not is_enemy(fcdata.faction,node.faction)
					and fcdata.taxioperator==node.taxioperator
					and (
						node.taxitag==fcdata.tag
						or fcdata.name:find(node.name,0,true)
					)
				)
				then
					found=1
					--if node.taxinodeID then tinsert(Lib.errors,"|cffff8888"..node.name.." got nodeID "..node.taxinodeID.." already! Why reassign to "..fcdata.nodeID.."??") end
					node.taxinodeID = fcdata.nodeID
					node.taxitag = fcdata.tag
					break
				end
			end

			if not found then tinsert(Lib.errors,"|cffffff00"..node.name.." ".." ("..z..") (faction:"..(node.faction or "-")..") ["..(node.taxioperator or "").."] didn't get a taxitag, no match found by name in LibTaxi.flightcost") end   -- DEVed prints at 2014-11-12
		until true end

		Lib:CacheTaxiTags()
		Lib:CacheTaxiPoints()

		-- for each taxi NPC assign neighbors by tag. LibRover Node uses this for cost calc.
		for c,z,ni,node in ZGV.CoroPairs(Lib.taxipoints,IterateCZNN) do repeat
			if is_enemy(node.faction,playerF) then break end
			--if not node.taxinodeID then tinsert(Lib.errors,"Why did "..node.name.." not get a nodeID?") break end
			local fcdata = Lib.fc_by_tag[c] and Lib.fc_by_tag[c][node.taxitag]
			if not fcdata then tinsert(Lib.errors,"taxi "..node.name.." has no fcdata?") break end -- shouldn't happen, if the node has a tag...
			if not fcdata.neighbors then break end

			node.taxicosts = {}
			for neighborid_or_tag,cost in pairs(fcdata.neighbors) do
				--print(c,z,ni,neighborid_or_tag,cost)
				local neighbor = (Lib.fnode_by_tag[c] and Lib.fnode_by_tag[c][neighborid_or_tag]) or Lib.fnode_by_nodeID[neighborid_or_tag]
				if neighbor then
					node.taxicosts[neighbor] = cost
				else
					node.taxicosts[c.."-"..neighborid_or_tag..",unused"] = cost -- won't be used, but let's keep it just for debugging
				end
			end
		until true end
	end

	--[[ UNUSED? not even for DEV!
		function Lib:DumpNeighborFlights()

			local s = ""

			for i=1,NumTaxiNodes() do
				x,y=TaxiNodePosition(i)
				x,y=floor(x*1000),floor(y*1000)
				if x < 100 then x = "0"..x end
				if y < 100 then y = "0"..y end
				name=TaxiNodeName(i)

				if GetNumRoutes(i)==1 then
					s= s..("		[\""..x..":"..y.."\"]".." = time, --"..name.."\n")
				elseif GetNumRoutes(i)==0 then
					s=("--[\""..x..":"..y.."\"]".." = time, --"..name.."\n".."[\""..x..":"..y.."\"]".." = {\n	[\"name\"] = \""..name.."\",\n	[\"neighbors\"] = {\n")..s
				end
			end
			s=s.."	},\n},"
			ZGV:ShowDump(s,"Paste these into LibTaxi data.lua into data.flightcost")
		end
	--]]

	--[[ UNUSED? not even for DEV!
		function Lib:DumpAllFlights()

			local s = ""

			for i=1,NumTaxiNodes() do
				x,y=TaxiNodePosition(i)
				x,y=floor(x*1000),floor(y*1000)
				if x < 100 then x = "0"..x end
				if y < 100 then y = "0"..x end
				name=TaxiNodeName(i)

				s=s..("--[\""..x..":"..y.."\"]".." = time, --"..name.."\n".."[\""..x..":"..y.."\"]".." = {\n	[\"name\"] = \""..name.."\",\n	[\"neighbors\"] = {\n").."},\n},\n"
			end
			ZGV:ShowDump(s)
		end
	--]]

	function Lib:GetTaxiByTarget()
		local id = UnitGUID("target")
		--print("Finding taxi by target: "..tostring(id)) -- DEBUGTAXITARGET
		if not id then return end
		id = id:match("Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)")  if not id then return end
		id=tonumber(id)
		--print("NPC ID: "..tostring(id)) -- DEBUGTAXITARGET
		for c,cont in pairs(Lib.taxipoints) do
			for z,zone in pairs(cont) do
				for ni,node in pairs(zone) do
					if node.npcid==id then return node end
				end
			end
		end
	end

	function Lib:DumpTaxiByTarget()  -- DEV
		local node = self:GetTaxiByTarget()
		if node then
			print("You're recognized at: "..node.name..", "..(node.known and "a 'known'" or "an 'unknown'").." taxi.")
		else
			print("I have no idea what taxi point you're at.")
		end
	end

	function Lib:LearnTaxi(node,learn)
		node.known=learn
		Lib.master[node.name]=learn
		if node.taxinodeID then Lib.master[node.taxinodeID]=learn end
		if node.taxitag then Lib.master[node.taxitag]=learn end
	end
	
	function Lib:LearnCurrentTaxi(if_unlearn)
		local learn=true  if if_unlearn==false then learn=false end
		local node = self:GetTaxiByTarget()
		if node then
			self:LearnTaxi(node,learn)
			self:Debug("%slearned by node, %s",(learn and "" or "un"),node.name)
			return
		end

		-- NPC not found? try by name (why would this ever happen!?)
		local name = GetMinimapZoneText()
		name = Lib.TaxiNames_English[name]
		if not name then
			self:Debug("|cffff8888Taxi Error: Unknown zone "..GetMinimapZoneText().."|r")
			return
		end
		name = minimap_exceptions[name] or name
		node=self:FindTaxi(name)
		if node then
			self:LearnTaxi(node,learn)
			self:Debug("%slearned by map, node %s, map %s",(learn and "" or "un"),node.name,GetMinimapZoneText())
			return
		end
		
		self:Debug("Something failed, map is %s, target is %s, but can't find a taxi here",UnitGUID("target"),GetMinimapZoneText())
	end

	function Lib:TestAllFlights()
		local s = ""

		local BZ = LibStub("LibBabble-SubZone-3.0")
		local BZL,BZR = BZ:GetUnstrictLookupTable(),BZ:GetReverseLookupTable()

		for i=1,NumTaxiNodes() do
			local x,y=TaxiNodePosition(i)
			x,y=floor(x*1000),floor(y*1000)
			if x < 100 then x = "0"..x end
			if y < 100 then y = "0"..y end
			local name=TaxiNodeName(i)
			local ttag = x..":"..y


			local tagmatch = Lib:FindTaxiByTag(ZGV.GetCurrentMapContinent(),ttag)

			if not tagmatch then
				s = s.."\n"..ttag.." - No tag match - "..i
			end

		end
		ZGV:ShowDump(s)
	end

	function Lib:Debug(s,...)
		if ZGV and ZGV.db then ZGV:Debug("&LibTaxi "..s,...) end
	end



	--[[
	function Lib:ConvertTag(typ,a,b,c)
		if typ=="raw" then
			return tonumber(("%d:%0d:%0d"):format(a,math.ceil(b*100),math.ceil(c*100)))
		elseif typ=="fme" then
			return a
		end
	end
	--]]

	--[[
	function Lib:TestCurrent()
		for node=1,NumTaxiNodes() do
			local typ=TaxiNodeGetType(node)
			if typ=="CURRENT" then
				local x,y = TaxiNodePosition(node)
				x=Math.floor(
		end
	end
	--]]

	_G['LibTaxi']=Lib



end