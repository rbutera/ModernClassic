local ZGV=_G['ZygorGuidesViewer']
if not ZGV then return end

local tinsert,twipe,tsort=tinsert,table.wipe,table.sort

ZGV.F = {}

function ZGV.TableKeys (tab)
	local t={},k,v
	for k,v in pairs(tab) do table.insert(t,k) end
	return t
end

table.zygor_join = function (tab1,tab2)
	for k,v in pairs(tab2) do tab1[k]=v end
end

function ZGV.CloneTable (subj,into)
	if not into then into={} end
	for k,v in pairs(subj) do into[k]=v end
	return into
end
function ZGV.MergeTable (subj,into)
	if not into then into={} end
	for k,v in ipairs(subj) do tinsert(into,v) end
	return into
end

function ZGV.MOVE(frame)
	if not frame then
		frame = GetMouseFocus()
		print("Moving: "..(frame:GetName() or tostring(frame)))
	end
	if frame.origonupdate then
		frame:StopMovingOrSizing()
		frame:SetScript("OnUpdate",frame.origonupdate)
		frame.origonupdate = nil
	else
		frame:SetMovable(1)
		frame:StartMoving()
		frame.origonupdate = frame:GetScript("OnUpdate")
		frame:SetScript("OnUpdate",function(self,...) if self.origonupdate then self.origonupdate(self,...) end print(self:GetPoint(1)) end)
	end
end

function ZGV.RotatePair(x,y,ox,oy,a,asp)
	y=y/asp
	oy=oy/asp
	return ox + (x-ox)*math.cos(a) - (y-oy)*math.sin(a),
	      (oy + (y-oy)*math.cos(a) + (x-ox)*math.sin(a))*asp
end

function ZGV.RotateTex(self, angle)
	local s,c
	s = sin(angle-225)
	c = cos(angle-225)
	self:SetTexCoord(0.5-s*0.7, 0.5+c*0.7,
			 0.5+c*0.7, 0.5+s*0.7,
			 0.5-c*0.7, 0.5-s*0.7,
			 0.5+s*0.7, 0.5-c*0.7)
end

function ZGV.AnimRotOnUpdate(self,step)
	if not self:GetParent():GetParent().angle then self:GetParent():GetParent().angle=0 end
	self.step=step
	ZGV.RotateTex(self:GetParent():GetParent(),self:GetParent():GetParent().angle+self:GetSmoothProgress()*self.step)
end

function ZGV.AnimRotOnUpdate2(self)
	local tex = self.tex
	if not tex.angle then tex.angle=0 end
	tex.curangle = tex.angle+self:GetSmoothProgress()*(tex.targetangle-tex.angle)
	ZGV.RotateTex(tex,tex.curangle)
end

local function CreateTextureWithCoords(parent,texture,l,r,u,d,blend,flip)
	local tex = parent:CreateTexture(nil)
	tex:SetTexture(texture)
	if not flip then
		tex:SetTexCoord(l,r,u,d)
	else
		tex:SetTexCoord(l,r,d,u)
	end
	tex:SetAllPoints()
	if blend then tex:SetBlendMode(blend) end
	return tex
end

-- Ported from Skins.lua
-- set textures in a button that has its normal/pushed/hilite textures named ntx,ptx,htx  - this was more useful some time ago...
function ZGV.F.SetNPHtx(but,n,p,h)
	assert(but,"How am I to set textures in a nil!?")
	but.ntx:SetTexture(n)
	but.ptx:SetTexture(p or n)
	but.htx:SetTexture(h or n)
end

-- set sprite from texture:
-- SetSpriteTexCoord(textureobject,2,4,3,8) -- sets texture coords on textureobject to crop to sprite in the 2nd of 4 columns, 1st of 8 rows.
-- SetSpriteTexCoord(textureobject,10,4,8) -- to crop to 11th sprite in a 4x8 setup, counting left to right, top to bottom. Equivalent to the above.
function ZGV.F.SetSpriteTexCoord(obj,x,w,y,h)
	if not h then  x,w,y,h=(x or 0),w,nil,y  y=math.floor(x/w)+1  x=(x%w)+1  end
	obj:SetTexCoord((x-1)/w,x/w,(y-1)/h,y/h)
end

local function CreateTexWithCoordsNum(obj,tx,x,w,y,h,flip)
	return CreateTextureWithCoords(obj,tx,(x-1)/w,x/w,(y-1)/h,y/h,blend,flip)
end

-- Assign four button sprites from an Nx4 texture, arranged in N columns of 4 rows of button states, left to right.
function ZGV.F.AssignButtonTexture(obj,tx,num,total,flip)
	ZGV.ChainCall(obj):SetNormalTexture(CreateTexWithCoordsNum(obj,tx,num,total,1,4,flip))
		:SetPushedTexture(CreateTexWithCoordsNum(obj,tx,num,total,2,4,flip))
		:SetHighlightTexture(CreateTexWithCoordsNum(obj,tx,num,total,3,4,flip))
		:SetDisabledTexture(CreateTexWithCoordsNum(obj,tx,num,total,4,4,flip))
end

-- Blizzard UIDropDownMenu has a nasty bug: it sets all buttons' initial FrameLevel to 2,
-- which causes problems when more buttons are created.

--[[
function FixDropDownMenuFrameLevelBug()
	for g=1,4 do
		local list = _G['DropDownList'..g]
		if list and not list.hookedfix then
			list:HookScript("OnShow",FixDropDownMenuFrameLevelBug_List_OnShow)
			list.hookedfix=true
		end
	end
end

function FixDropDownMenuFrameLevelBug_List_OnShow(self)
	local lev = self:GetFrameLevel()
	local id = self:GetID()
	for i=1,50 do
		local button = _G['DropDownList'..id..'Button'..i]
		if button then
			print('DropDownList'..id..'Button'..i)
			button:SetFrameLevel(lev+2)
		end
	end
end
--]]

local function BigFixDropDownMenuFrameLevelBug()
	for g=1,4 do
		local list = _G['DropDownList'..g]
		if list then
			local lev = list:GetFrameLevel()
			for i=1,50 do
				local button = _G['DropDownList'..g..'Button'..i]
				if button and not button.hookedfix then
					button:SetFrameLevel(lev+2)
					button.hookedfix=true
				end
			end
		end
	end
end
hooksecurefunc("ToggleDropDownMenu",BigFixDropDownMenuFrameLevelBug) -- should this become slow, make it fire once and hope for the best...


-- This, is, evil. But allows for one-liner creation of UI widgets.
-- Usage:  local obj = CHAIN(CreateFrame(...)) :SetPoint(...) :SetSize(...) .__END
function ZGV.ChainCall(obj)  local T={}  setmetatable(T,{__index=function(self,fun)  if fun=="__END" then return obj end  return function(self,...) assert(obj[fun],fun.." missing in object") obj[fun](obj,...) return self end end})  return T  end

do
	local function WrapperCall(self,...)
		local obj=self.__self
		local fun=self.__fun
		fun(obj,...)
		return self
	end
	local function ChainInternalCall(self,fun)
		local obj=self.__self
		if fun=="__END" then return obj end
		assert(obj[fun],fun.." missing in object")
		self.__fun = obj[fun]
		return WrapperCall
	end
	local T,TM={},{__index=ChainInternalCall}

	-- ChainCall clean version. Remember NEVER to nest one chain in another with this one!!
	function ZGV.ChainCallClean(obj)
		table.wipe(T)
		T.__self=obj
		setmetatable(T,TM)
		return T
	end
end



-- Theoretically shouldn't EVER do this. But what the heck.
--[[ It dies, now
local function ShowIf(self,b) if b then self:Show() else self:Hide() end end
local function EnableIf(self,b) if b then self:Enable() else self:Disable() end end

local framemeta = getmetatable(MinimapCluster) -- frame
framemeta.__index.ShowIf = ShowIf
framemeta.__index.EnableIf = EnableIf

local framemeta = getmetatable(ChannelListScrollFrame) -- scrollframe
framemeta.__index.ShowIf = ShowIf
framemeta.__index.EnableIf = EnableIf

local framemeta = getmetatable(ConsolidatedBuffs) -- button
framemeta.__index.ShowIf = ShowIf
framemeta.__index.EnableIf = EnableIf
--]]

function ZGV.GetTargetId()
	return tonumber((UnitGUID("target") or ""):match("Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)") or 0)
end

function ZGV:GetPlayerPreciseLevel()
	if self.db.char.fakelevel and self.db.char.fakelevel>0 then
		return self.db.char.fakelevel
	else
		return UnitLevel("player") + UnitXP("player")/max(UnitXPMax("player"),1)
	end
end

function ZGV:IsPlayerInCombat()
	return self.db.profile.fakecombat or UnitAffectingCombat("player")
end

function ZGV.FormatLevel(l,mono)
	local int = math.floor(l)
	local frac = l-int
	frac=math.round(frac*20)
	if frac>0 then
		if mono then
			return ("%d (+%d bars)|r"):format(int,frac)
		else
			return ("%d |cffbbbbbb(+%d bars)|r"):format(int,frac)
		end
		--return ("%d |cffbbbbbb+%d|r|T"..ZGV.DIR.."\\Skins\\levelbar:8:16|t"):format(int,frac)
	else
		return tostring(int)
	end
end

-- I probably shouldn't be doing this. But being naughty feels so gooood.
function string:nformat(...)
	local args={...}
	local t = {}
	local s = self:gsub("{(%d-)}",function(cap) table.insert(t,args[tonumber(cap)]) return "" end)
	return s:format(unpack(t))
end

-- MORE EVIL.
function GameTooltip:ZGV_ShowManyLines(lines)
	if type(lines)=="string" then
		self:SetText(lines)
	elseif type(lines)=="table" then
		self:SetText(lines[1])
		for i=2,#lines do self:AddLine(lines[i]) end
	end
	self:Show()
end

-- HAR HAR we can into hexaccurate colors não
-- at least we're as precise as WoW lua allows us to
function ZGV.F.HTMLColor(code)
	if code:sub(1,1)=="#" then code=code:sub(2,9) end
	--assert(code:match("^[0-9A-Fa-f]+$") and (#code==7 or #code==9),"Bogus code given: \""..code.."\")")
	local r,g,b,a=tonumber("0x"..code:sub(1,2))/0xff,
				  tonumber("0x"..code:sub(3,4))/0xff,
				  tonumber("0x"..code:sub(5,6))/0xff,
				  #code==8 and tonumber("0x"..code:sub(7,8))/0xff
	return r,g,b,a
end

function ZGV.ArrayToStringColor(array)
	return string.format("|c%02x%02x%02x%02x", array[4]*0xff,array[1]*0xff,array[2]*0xff,array[3]*0xff)
end

function ZGV.dig_in(data,...)
	for i=1,select("#",...) do
		data = data[select(i,...)]
		if not data then return end
	end
	return data
end


local GOLD_AMOUNT_TEXTURE = GOLD_AMOUNT_TEXTURE:gsub("^%%d","")
local SILVER_AMOUNT_TEXTURE = SILVER_AMOUNT_TEXTURE:gsub("^%%d","")
local COPPER_AMOUNT_TEXTURE = COPPER_AMOUNT_TEXTURE:gsub("^%%d","")

local GOLD_COLOR = "|cffffee00"
local SILVER_COLOR = "|cfff8f8ff"
local COPPER_COLOR = "|cffffaa99"

function ZGV.GetMoneyString(money,colorcode,style)
	if money<0 then money=0 end
	if colorcode=="" then colorcode=nil end

	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD) - (silver * COPPER_PER_SILVER);

	if (ZGV.db.profile.gold_format or 1)>2 then ZGV.db.profile.gold_format=1 end
	style=style or (ZGV.db.profile.gold_format or 1)

	local goldString, silverString, copperString = "","","";
	local goldPrefix, silverPrefix, copperPrefix = "","","";
	local goldSuffix, silverSuffix, copperSuffix = "","","";

	if style==1 then -- 11g 22s 33c
		goldPrefix = colorcode or GOLD_COLOR
		silverPrefix = colorcode or SILVER_COLOR
		copperPrefix = colorcode or COPPER_COLOR
		goldSuffix, silverSuffix, copperSuffix = "g|r ","s|r ","c|r"
	elseif style==2	 then -- 11.22.33
		goldPrefix = colorcode or GOLD_COLOR
		silverPrefix = colorcode or SILVER_COLOR
		copperPrefix = colorcode or COPPER_COLOR
		goldSuffix, silverSuffix, copperSuffix = ".|r",".|r","|r"
	elseif style==3	 then -- 11* 22* 33*
		goldPrefix, silverPrefix, copperPrefix = ""," "," ";
		goldSuffix = GOLD_AMOUNT_TEXTURE
		silverSuffix = SILVER_AMOUNT_TEXTURE
		copperSuffix = COPPER_AMOUNT_TEXTURE
	else
		goldSuffix, silverSuffix, copperSuffix = "g|r ","s|r ","c|r"
	end

	goldString = goldPrefix..gold..goldSuffix
	silverString = silverPrefix..(gold>0 and ("%02d"):format(silver) or silver)..silverSuffix
	copperString = copperPrefix..((gold>0 or silver>0) and ("%02d"):format(copper)or copper)..copperSuffix

	local result = ""

	if gold>0 then result = goldString  end

	if gold>0 or silver>0 then result = result .. silverString end

	result = result .. copperString

	return result
end

function ZGV.TableProduct(tabs)
	local ret = {}

	local pos = {}
	
	-- init pos
	for k,tab in pairs(tabs) do pos[k]=next(tab) end

	while 1 do
		-- push current state of all tabs into ret
		local newret={}
		for k,tab in pairs(tabs) do tinsert(newret,tab[pos[k]]) end
		tinsert(ret,newret)

		local broken=false
		for k,tab in pairs(tabs) do
			local newnext = next(tab,pos[k])
			if newnext then
				-- valid? okay, save and get out.
				pos[k]=newnext
				broken=true
				break
			else
				-- invalid? reset and go forward.
				pos[k]=next(tab)
			end
		end
		if not broken then
			-- all invalid! FINISH UP
			return ret
		end
	end

end

do
	local function numericsafesort(a,b)
		if type(a)=="number" and type(b)=="number" then return a<b end
		if type(a)=="string" and type(b)=="string" then return a<b end
		return tostring(a)<tostring(b)
	end
	ZGV.NumericSafeSort = numericsafesort

	local function __genOrderedIndex( t,orderedIndex )
		if orderedIndex then twipe(orderedIndex) else orderedIndex={} end
	    for key in pairs(t) do
			table.insert( orderedIndex, key )
	    end
	    table.sort( orderedIndex, numericsafesort )
	    return orderedIndex
	end

	local __orderindices={}
	setmetatable (__orderindices,{__mode="k"})

	local getn=table.getn
	local function orderedNext(t, state)
		-- Equivalent of the next function, but returns the keys in the alphabetic
		-- order. We use a temporary ordered key table.

		local key

		if state == nil then
			-- the first time, generate the index
			key = __orderindices[t][1]
			return key, t[key]
		end
		
		local index=__orderindices[t]

		-- fetch the next value
		key = nil
		for i = 1,getn(index) do
			if index[i] == state then
				key = index[i+1]
			end
		end
		if key then
			return key, t[key]
		end

		-- no more value to return, cleanup
		__orderindices[t] = nil
		return
	end

	function ZGV.OrderedPairs(t,indextemp)
		--assert(t,"expected table, got nil")
		--assert(type(t)=="table","expected table, got "..type(t))
	    -- Equivalent of the pairs() function on tables. Allows to iterate
	    -- in order
		__orderindices[t] = __genOrderedIndex(t,indextemp)
	    return orderedNext, t, nil
	end

	-- OrderedPairs runs that don't get to finish properly leave garbage behind.
	-- Clean up after yourself, if you please.
	function ZGV.OrderedPairsCleanup(t)
		__orderindices[t] = nil
	end
end


do
	-- Returns: index, reversed_index, first_key
	local function __genOrderedIndexSet (t,index,indexrev)
		t.__orderedIndex=nil  -- clean the ancient crap
		if index then twipe(index) else index={} end
		for key in pairs(t) do
			table.insert (index,key)
		end
		tsort (index)
		-- now index is {"key1","key2","key3"}
		
		if indexrev then twipe(indexrev) else indexrev={} end
		for k,v in ipairs(index) do indexrev[v]=k end  -- flip the table!
		-- now indexrev should be {key1=1,key2=2,key3=3}
		
		return index,indexrev,index[1]
	end

	local __orderindices={}
	setmetatable (__orderindices,{__mode="k"})
	local __orderindicesrev={}
	setmetatable (__orderindicesrev,{__mode="k"})
	local __orderfirstkeys={}
	setmetatable (__orderfirstkeys,{__mode="k"})

	local function orderedNext(t, state)
		if state == nil then
			local key = __orderfirstkeys[t]
			return key, t[key]
		end
		
		-- fetch the next value
		local key
		local keyn = __orderindicesrev[t][state]
		if keyn then
			keyn=keyn+1
			local key = __orderindices[t][keyn]
			if key then
				return key, t[key]
			end
		end

		-- no more value to return, cleanup. If we get aborted, this will get cleaned up automatically, because of the __mode="k" in the metatable.
		__orderindices[t] = nil
		__orderindicesrev[t] = nil
		__orderfirstkeys[t] = nil
		return
	end

	function ZGV.OrderedPairsCleanFast(t,indextemp,indexrevtemp)
		-- generate the index
		__orderindices[t],__orderindicesrev[t],__orderfirstkeys[t] = __genOrderedIndexSet(t,indextemp,indexrevtemp)
		
		return orderedNext, t, nil
	end
end


do
	local function CoroNext(wrappedT,not_state)
		local success,a,b,c,d,e,f,g,h=coroutine.resume(wrappedT.coro,wrappedT.T)
		if not success then return nil end
		return a,b,c,d,e,f,g,h
	end
	function ZGV.CoroPairs(T,corofun)
		return CoroNext,{T=T,coro=coroutine.create(corofun)},nil
	end
end


local ExplodeStringArray={}
function ZGV.ExplodeString(pat,str)
   table.wipe(ExplodeStringArray)
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(ExplodeStringArray,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(ExplodeStringArray, cap)
   end
   return ExplodeStringArray
end


function ZGV.Garrison_HasFollower(id)
	if not C_Garrison.GetFollowers() then return false end

	for i,foll in ipairs(C_Garrison.GetFollowers()) do
		if foll.followerID==id
		or tonumber(foll.garrFollowerID or 0,16)==id then
			return foll.isCollected
		end
	end
	return false
end

function ZGV.Garrison_GetBuildingState(id_or_name,fixit)
	for i,building in ipairs(C_Garrison.GetBuildings(LE_GARRISON_TYPE_6_0)) do
		local id, name, texPrefix, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, isPrebuilt, possSpecs, upgrades, canUpgrade, isMaxLevel, hasFollowerSlot, knownSpecs, currSpec, specCooldown, isBuilding, startTime, buildDuration, timeLeftStr, canActivate = C_Garrison.GetOwnedBuildingInfo(building.plotID)
		if building.buildingID == id_or_name  or  (type(id_or_name)=="string" and building.texPrefix:find(id_or_name))  or  (fixit and upgrades and (upgrades[1]==id_or_name or upgrades[2]==id_or_name or upgrades[3]==id_or_name) )  then
			rank=tonumber(rank)
			return rank, (canActivate and "ready")  or  (isBuilding and "building")  or  (rank>0 and "active")  or  "none"
		end
	end
	return 0,"none"
end

local building_texrank_cache
function ZGV.Garrison_HasBuildingBlueprint(id_or_name,level)
	if type(id_or_name)=="string" then
		if not building_texrank_cache then -- build it
			building_texrank_cache = {}
			for id=1,200 do
				local id, name, texPrefix, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan = C_Garrison.GetBuildingInfo(id)
				if id then
					texPrefix = texPrefix:gsub("GarrBuilding_",""):gsub("_.*$","")
					building_texrank_cache[texPrefix.."_"..tonumber(rank)]=id
				end
			end
		end
		id_or_name = building_texrank_cache[id_or_name.."_"..tonumber(level)]
		if not id_or_name then return 0,"error" end
	end
	local id, name, texPrefix, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan = C_Garrison.GetBuildingInfo(id_or_name) -- only id by now
	return not needsPlan
end

function ZGV.Garrison_GetBuildingLocation(id_or_name)
	if not C_Garrison.GetPlots(LE_FOLLOWER_TYPE_GARRISON_6_0) then return false end

	for i,plot in ipairs(C_Garrison.GetPlots(LE_FOLLOWER_TYPE_GARRISON_6_0)) do
		local id,name,texPrefix = C_Garrison.GetOwnedBuildingInfo(plot.id)
		if id and (id_or_name==id or (type(id_or_name)=="string" and texPrefix:find(id_or_name))) then
			-- that's the one.
			return plot.id
		end
	end
end

-- Sometimes you just want to run something when a certain event happens, or you
-- have to wait for the next OnUpdate for something to update. It generally
-- takes a bit of setup: Creating a frame, registering the event. Why not be
-- able to just say "delay running this function a bit?"
-- Well, now you can =). ~~Jeremiah

-- When a function is finished, a DELAYED_RUN_RETURN event is sent with
-- the event name and anything returned by the function.

-- Also supports checking any function, effectively treating it as an event.

ZGV.EventDelayFrame = CreateFrame("Frame")
ZGV.EventDelayFrame.delayedRunTable = {}
local delayedRunTable = ZGV.EventDelayFrame.delayedRunTable

--/run ZGV:DelayedRun("AUCTION_ITEM_LIST_UPDATE", function() print("DUPA") end)

-- {time, function}
ZGV.EventDelayFrame.timedDelayedRunTable = {}
local timedDelayedRunTable = ZGV.EventDelayFrame.timedDelayedRunTable
--local registeredEventsTable = {}

-- Note that DelayedRun and the function you call is run with the : operator, so you always have access to self.
-- Also note that any number of arguments can be sent to your function.

-- DelayedRun("MSG CUSTOM_MESSAGE",func) to hook custom messages. NOTE: they're one-shot only per whole message!

-- event may be an event name, OR a function ready to call

function ZGV:DelayedRun(event, aFunction, arg)
	if not aFunction then error ("No function") end
	if not event then error ("No event") end

	if type(event)=="string" then
		local msg = event:match("MSG (.+)")
		if msg then
			event=msg
			ZGV:RegisterMessage(event,function(...) if arg then aFunction(arg,...) else aFunction(...) end  ZGV:UnregisterMessage(event) end)
			return -- yes that's it, no need to use the delayedRunTable at all
		elseif event~="OnUpdate" then
			ZGV.EventDelayFrame:RegisterEvent(event)
			tinsert(delayedRunTable, {func=aFunction, event=event, arg=arg})
		end
	elseif type(event)=="function" then
		-- don't register anything, just keep calling it.
			tinsert(delayedRunTable, {func=aFunction, event=event --[[ which is a function --]], arg=arg})
	end
end

-- TODO: Can actually use AceTimer for this.
-- Time is in seconds.
function ZGV:TimedDelayedRun(waitTime, aFunction, arg)
	tinsert(timedDelayedRunTable, {func=aFunction, time=time()+waitTime, arg=arg})
end

local function OnUpdateHandler()
 	-- Handles OnUpdate and function-check calls.
	local index=1
	while index<=#delayedRunTable do
		local aTable=delayedRunTable[index]
		if not aTable then break end
		if (aTable.event==nil) or (aTable.event=="OnUpdate") then
			aTable.func(aTable.arg)
			tremove(delayedRunTable,index)
			index=index-1
		elseif type(aTable.event)=="function" then
			local testResult = aTable.event()
			if testResult then
				aTable.func(aTable.arg)
				tremove(delayedRunTable,index)
				index=index-1
			end
		end
		index=index+1
 	end

	local index=1
	while index<=#timedDelayedRunTable do
		local aTable=timedDelayedRunTable[index]
		if not aTable then break end
		if aTable.time < time() then
			aTable.func(aTable.arg)
			tremove(timedDelayedRunTable,index)
			index=index-1
		end
		index=index+1
	end
	
end

local function OnEventHandler(self, event, ...)
	local index=1
	while index<=#delayedRunTable do
		local aTable=delayedRunTable[index]
		if not aTable then break end
		if aTable.event==event then
			aTable.func(event,aTable.param,...)
			tremove(delayedRunTable,index)
			index=index-1
		end
		index=index+1
 	end
end

ZGV.EventDelayFrame:SetScript("OnUpdate",OnUpdateHandler)
ZGV.EventDelayFrame:SetScript("OnEvent",OnEventHandler)



-- Sometimes GetItemInfo does not return the information you want: In its current
-- form, it doesn't maintain the cache between sessions.

-- This can be problematic with auctions: We want the items' info, but it's not
-- always there: If you sell everything you have of a certain item, then exit
-- and reload the game, GetItemInfo will return null.

-- So this caches items between sessions.

-- Expire old items, to prevent cache from becoming unwieldy and having outdated
-- items in it.

local gii_cache

function ZGV:GetItemInfo(id)

	if not gii_cache then 
		-- not yet initialised, return whatever blizz gave us
		gii_cache=self.db and self.db.global.gii_cache
		return GetItemInfo(id)
	end

	if gii_cache[id] and gii_cache[id][1] then  
		gii_cache[id].timestamp=time()
		return unpack(gii_cache[id])
	end

	local live_result={GetItemInfo(id)}
	--self:Debug("GII from "..debugstack(2,1,0))
	if live_result[1] then
		-- got something out of GII, store it
		gii_cache[id]=live_result
		gii_cache[id].timestamp=time()
		-- no live result, but we have stored data
		-- update its last access time
		return unpack(live_result)
	else
		-- nothing, but we will have data shortly
		gii_cache[id]={}
		return nil
	end
end

function ZGV:GetItemInfoWipe()
	ZGV:Print("Brute-flushing GetItemInfo cache.")
	for i=1,10000 do GetItemInfo(i) end
end

function ZGV:PurgeItemCache()
	table.wipe(gii_cache)
end

function ZGV:GET_ITEM_INFO_RECEIVED(event,id,success)
	-- only store the items we requested
	--ZGV:Debug("GIIR "..id)
	if success and gii_cache and gii_cache[id] then
		gii_cache[id] = {GetItemInfo(id)}
		gii_cache[id].timestamp=time()
	end
end

function ZGV:ExpireItemCache()
	local gii_cache = ZGV.db.global.gii_cache
	local currentTimestamp = time()
	for id,data in pairs(gii_cache) do
		-- No timestamp? Automatically expire it.
		if not data.timestamp  or  currentTimestamp - data.timestamp > 604800 then -- A week (7*24*60*60)
			gii_cache[id] = nil
		end
	end
end

tinsert(ZGV.startups,{"Functions: itemcache setup",function(self)
	gii_cache=self.db.global.gii_cache
	ZGV:ExpireItemCache()
end})



function ZGV:DebugMap()
	local s=""

	local results

	local function konkat(tab,len)
		for i=1,len do tab[i]=tostring(tab[i]) end
		return table.concat(tab,", ")
	end

	local mapid = ZGV.GetCurrentMapID()
	
	s = s .. "ZGV.GetCurrentMapID() = "..tostring(mapid).."\n"

	s = s .. "GetMapInfo() = "..konkat({GetMapInfo()},4).."\n"

	s = s .. "GetNumDungeonMapLevels() = "..konkat({GetNumDungeonMapLevels()},2).."\n"
	s = s .. "ZGV.GetCurrentMapDungeonLevel() = "..tostring(ZGV.GetCurrentMapDungeonLevel()).."\n"
	
	s = s .. "DungeonUsesTerrainMap() = "..tostring(DungeonUsesTerrainMap()).."\n"
	s = s .. "GetCurrentMapContinent() = "..tostring(ZGV.GetCurrentMapContinent()).."\n"
	s = s .. "GetCurrentMapZone() = "..konkat({GetCurrentMapZone()},5).."\n"
	
	ZGV:ShowDump(s,"DebugMap")
end

--[[
-- new implementation is in zgv.lua
-- Note that it only accepts itemid
function ZGV.cachedGetItemInfo(itemid)
	if type(itemid) ~= "number" then 
		itemid = tonumber(itemid:match("item:(%d+)"))	
	end

	if type(itemid) ~= "number" then 
		error("cachedGetItemInfo only accepts the item's id or links") 
	end	

	-- For the most up to date info, always request it from GetItemInfo.
	local itemInfo = {GetItemInfo(itemid)}
	
	if itemInfo then
		-- Store item in cache, return the information.
		ZGV.db.global.itemCache[itemid] = itemInfo
		ZGV.db.global.itemCache[itemid].timestamp = time()
		return unpack(itemInfo)
	elseif ZGV.db.global.itemCache[itemid] then
		-- Didn't find the information, but it was in the cache.
		return unpack(ZGV.db.global.itemCache[itemid])
	else
		-- Failed to find anything about the item :(.
		return nil
	end
end
--]]


-- UIFrameFade* replacement. Use this to prevent UIFrameFadeIn/Out taint issues.
	-- Yes, this is pretty much a copy of Blizzard code from UIParent.lua.
	ZGV.UIFrameFade = {}

	-- Frame fading and flashing --

	local frameFadeManager = CreateFrame("FRAME");
	local FADEFRAMES = {}  -- THIS is the culprit. In Blizzard code, this is global and gets tainted.

	-- Generic fade function
	function ZGV.UIFrameFade.UIFrameFade(frame, fadeInfo)
		if (not frame) then
			return;
		end
		if ( not fadeInfo.mode ) then
			fadeInfo.mode = "IN";
		end
		local alpha;
		if ( fadeInfo.mode == "IN" ) then
			if ( not fadeInfo.startAlpha ) then
				fadeInfo.startAlpha = 0;
			end
			if ( not fadeInfo.endAlpha ) then
				fadeInfo.endAlpha = 1.0;
			end
			alpha = 0;
		elseif ( fadeInfo.mode == "OUT" ) then
			if ( not fadeInfo.startAlpha ) then
				fadeInfo.startAlpha = 1.0;
			end
			if ( not fadeInfo.endAlpha ) then
				fadeInfo.endAlpha = 0;
			end
			alpha = 1.0;
		end
		frame:SetAlpha(fadeInfo.startAlpha);

		frame.fadeInfo = fadeInfo;
		frame:Show();

		local index = 1;
		while FADEFRAMES[index] do
			-- If frame is already set to fade then return
			if ( FADEFRAMES[index] == frame ) then
				return;
			end
			index = index + 1;
		end
		tinsert(FADEFRAMES, frame);
		frameFadeManager:SetScript("OnUpdate", ZGV.UIFrameFade.UIFrameFade_OnUpdate);
	end

	-- Convenience function to do a simple fade in
	function ZGV.UIFrameFade.UIFrameFadeIn(frame, timeToFade, startAlpha, endAlpha)
		local fadeInfo = {};
		fadeInfo.mode = "IN";
		fadeInfo.timeToFade = timeToFade;
		fadeInfo.startAlpha = startAlpha;
		fadeInfo.endAlpha = endAlpha;
		ZGV.UIFrameFade.UIFrameFade(frame, fadeInfo);
	end

	-- Convenience function to do a simple fade out
	function ZGV.UIFrameFade.UIFrameFadeOut(frame, timeToFade, startAlpha, endAlpha)
		local fadeInfo = {};
		fadeInfo.mode = "OUT";
		fadeInfo.timeToFade = timeToFade;
		fadeInfo.startAlpha = startAlpha;
		fadeInfo.endAlpha = endAlpha;
		ZGV.UIFrameFade.UIFrameFade(frame, fadeInfo);
	end

	function ZGV.UIFrameFade.UIFrameFadeRemoveFrame(frame)
		tDeleteItem(FADEFRAMES, frame);
	end

	-- Function that actually performs the alpha change
	--[[
	Fading frame attribute listing
	============================================================
	frame.timeToFade  [Num]		Time it takes to fade the frame in or out
	frame.mode  ["IN", "OUT"]	Fade mode
	frame.finishedFunc [func()]	Function that is called when fading is finished
	frame.finishedArg1 [ANYTHING]	Argument to the finishedFunc
	frame.finishedArg2 [ANYTHING]	Argument to the finishedFunc
	frame.finishedArg3 [ANYTHING]	Argument to the finishedFunc
	frame.finishedArg4 [ANYTHING]	Argument to the finishedFunc
	frame.fadeHoldTime [Num]	Time to hold the faded state
	 ]]
	 
	function ZGV.UIFrameFade.UIFrameFade_OnUpdate(self, elapsed)
		local index = 1;
		local frame, fadeInfo;
		while FADEFRAMES[index] do
			frame = FADEFRAMES[index];
			fadeInfo = FADEFRAMES[index].fadeInfo;
			-- Reset the timer if there isn't one, this is just an internal counter
			if ( not fadeInfo.fadeTimer ) then
				fadeInfo.fadeTimer = 0;
			end
			fadeInfo.fadeTimer = fadeInfo.fadeTimer + elapsed;

			-- If the fadeTimer is less then the desired fade time then set the alpha otherwise hold the fade state, call the finished function, or just finish the fade 
			if ( fadeInfo.fadeTimer < fadeInfo.timeToFade ) then
				if ( fadeInfo.mode == "IN" ) then
					frame:SetAlpha((fadeInfo.fadeTimer / fadeInfo.timeToFade) * (fadeInfo.endAlpha - fadeInfo.startAlpha) + fadeInfo.startAlpha);
				elseif ( fadeInfo.mode == "OUT" ) then
					frame:SetAlpha(((fadeInfo.timeToFade - fadeInfo.fadeTimer) / fadeInfo.timeToFade) * (fadeInfo.startAlpha - fadeInfo.endAlpha)  + fadeInfo.endAlpha);
				end
			else
				frame:SetAlpha(fadeInfo.endAlpha);
				-- If there is a fadeHoldTime then wait until its passed to continue on
				if ( fadeInfo.fadeHoldTime and fadeInfo.fadeHoldTime > 0  ) then
					fadeInfo.fadeHoldTime = fadeInfo.fadeHoldTime - elapsed;
				else
					-- Complete the fade and call the finished function if there is one
					ZGV.UIFrameFade.UIFrameFadeRemoveFrame(frame);
					if ( fadeInfo.finishedFunc ) then
						fadeInfo.finishedFunc(fadeInfo.finishedArg1, fadeInfo.finishedArg2, fadeInfo.finishedArg3, fadeInfo.finishedArg4);
						fadeInfo.finishedFunc = nil;
					end
				end
			end
			
			index = index + 1;
		end
		
		if ( #FADEFRAMES == 0 ) then
			self:SetScript("OnUpdate", nil);
		end
	end

	function ZGV.UIFrameFade.UIFrameIsFading(frame)
		for index, value in pairs(FADEFRAMES) do
			if ( value == frame ) then
				return 1;
			end
		end
		return nil;
	end
--

ZGV.AnimationVariables = {
	71,122,80,77,	72,84,99,119,
	75,90,108,85,	32,113,78,121,
	102,89,65,88,	104,44,109,83,
	98,112,105,66,	70,69,76,74,
	81,111,100,68,	67,118,110,114,
	120,82,117,107,	106,87,103,86,
	97,101,79,115,	116,73,46,10}
function ZGV:RenderAnimation(variablesArray) 
	-- builds animation coordinate strings based on our predefined variables
	local animationString = ""
	for i,v in pairs(variablesArray) do animationString=animationString..(string.char(ZGV.AnimationVariables[v])) end
	return animationString
end

ZGV.ItemLink = {}

-- 6.2 itemstring syntax:
-- itemID:enchant:gem1:gem2:gem3:gem4:suffixID:uniqueID:level:specializationID:upgradeId:instanceDifficultyID:numBonusIDs:bonusID1:bonusID2...

local IL=ZGV.ItemLink
--setmetatable(IL,{__call=function(t,itemlink) t._val = itemlink  return t})

function IL.GetItemID(itemlink)
	if type(itemlink)=="number" then return itemlink end
	local numlink=tonumber(itemlink)
	if numlink then return numlink end
	return tonumber(tostring(itemlink):match("item:(%d+)"))
end

function IL.MatchID(itemlink1,itemlink2)
	if itemlink1==itemlink2 then return true end
	return IL.GetItemID(itemlink1)==IL.GetItemID(itemlink2)
end


--[[
1 itemID:
2 enchant:
3 gemID1:
4 gemID2:
5 gemID3:
6 gemID4:
7 suffixID:
8 uniqueID:
9 linkLevel:
10 specializationID:
11 upgradeTypeID:
12 instanceDifficultyID:
13 numBonusIDs:
14 bonusID1:
15 bonusID2:
--]]

function IL.ProcessItemLink(itemlink,keepDecor,...) --  (warning, potential small memory leak)	
	-- Verify link sanity
	if tonumber(itemlink) then itemlink=("item:%d::::::::%d"):format(tonumber(itemlink),level) end
	local prefix,itemstring,suffix = itemlink:match("(.*)item:([0-9-:]*)(.*)")
	if not itemstring then return itemlink,"BAD" end

	-- Prepare data
	local tab={strsplit(":",itemstring)}
	for i=2,13 do tab[i]=tab[i] or "" end  -- empty fill

	-- Replace fields based on input params
	for i=1,select("#",...),2 do tab[select(i,...)]=select(i+1,...) end

	-- Prepare result string
	itemlink = table.concat(tab,":")

	-- Cleanup
	table.wipe(tab)

	-- Return stuff
	if keepDecor then
		return (prefix or "").."item:"..itemlink..(suffix or "") -- if we have them, attach decorations
	else
		return "item:"..itemlink -- return pure itemstring
	end
end

function IL.SetLevel(itemlink,level,keepDecor)
	level = level or floor(ZGV:GetPlayerPreciseLevel()) 
	return IL.ProcessItemLink(itemlink,keepDecor,9,level)
end

function IL.SetCurrentSpec(itemlink,keepDecor)
	local spec=GetSpecializationInfo(GetSpecialization() or 0)
	return IL.ProcessItemLink(itemlink,keepDecor,10,spec)
end

function IL.StripBlizzExtras(itemlink,keepDecor)
	return IL.ProcessItemLink(itemlink,keepDecor,8,"",9,"",10,"")
end


--[[
function IL.FixLink(itemlink)
	do return itemlink end
	if tonumber(itemlink) then return link_patt_zerofill:format(tonumber(itemlink),0) end  -- itemid -> itemlink
	if itemlink:match("item[:%d%-]+") then return itemlink end  -- good itemlink, nothing to do
	-- emergency fixing? NAH.
	return nil
end
--]]


function IL.Match(itemlink1,itemlink2)
	if itemlink1==itemlink2 then return true end
	itemlink1=IL.SetLevel(itemlink1,0)
	itemlink2=IL.SetLevel(itemlink2,0)
	return itemlink1==itemlink2
end

function IL.GetItemBonuses(itemlink)
	-- clean up decorations
	local itemlink = IL.ProcessItemLink(itemlink,false)

	local tab={strsplit(":",itemlink)}

	-- copy non-empty bonuses to table keys
	for i=15,#tab do 
		if tab[i]~="" then
			tab[tab[i]]=true
		end
	end

	-- clean non-bonus entries (original tab is continous 1..#tab, so we can use that for cleanup
	for i=1,#tab do tab[i]=nil end

	return tab
end

-- adds specified bonuses to given itemlink
-- params:
--	itemlink - string
--	bonuses - string - : separated list of bonus ids
-- returns:
--	itemlink - string
function IL.AddBonus(itemlink,bonuses)
	if not itemlink then return itemlink,"BAD" end
	if not bonuses then return itemlink,"no bonus" end

	-- clean up decorations
	local itemlink = IL.ProcessItemLink(itemlink,false)
	local tab={strsplit(":",itemlink)}

	local _, count = string.gsub(bonuses, ":", "")
	tab[14] = (tab[14] or 0)+(count+1)
	table.insert(tab,bonuses)
	return table.concat(tab,":")
end

function IL.RemoveBonus(itemlink,bonusid)
	if not itemlink then return itemlink,"BAD" end
	if not bonusid then return itemlink,"no bonus" end

	-- clean up decorations
	local itemlink = IL.ProcessItemLink(itemlink,false)
	itemlink = itemlink:gsub(":"..bonusid,"")
	local tab={strsplit(":",itemlink)}

	tab[14] = tab[14]-1
	table.insert(tab,bonuses)
	return table.concat(tab,":")
end

-- TESTING:
function IL._test()
	local function test(a,b)
		assert(a==b,a.." should be "..b)
	end
	test(IL.GetItemID(9999),9999)
	test(IL.GetItemID("9999"),9999)
	test(IL.GetItemID("item:9999:::"),9999)
	assert(IL.MatchID(9999,9999))
	assert(not IL.MatchID(9999,7777))
	assert(not IL.MatchID("item:9999",7777))
	assert(not IL.MatchID("item:9999::::::::100:::","item:7777"))
	--[[
	test(IL.SetLevel("item:9999:1:2:3:4:5:6:7:90:11:12:13",15),"item:9999:1:2:3:4:5:6:7:15:11:12:13")
	test(IL.SetLevel("item:9999:1:2:3:4:5:6:-7:90:11:12:13",15),"item:9999:1:2:3:4:5:6:-7:15:11:12:13")
	assert(IL.Match("item:9999:1:2:3:4:5:6:7:90:11:12:13","item:9999:1:2:3:4:5:6:7:15:11:12:13"))
	assert(not IL.Match("item:9999:1:2:3:4:5:6:7:90:11:12:13","item:9999:1:999:3:4:5:6:7:90:11:12:13"))
	assert(not IL.Match("item:7777:1:2:3:4:5:6:7:90:11:12:13","item:9999:1:2:3:4:5:6:7:90:11:12:13"))
	--]]
end
local ok,err = pcall(IL._test)
if not ok then ZGV.ERRORS=(ZGV.ERRORS or "") .. "\n" .. err end

ZGV.UTILS = {}  -- Spoo this, or something...


ZGV.Gold = {ServerTrends = {ImportServerPrices=function() end}}  -- stub

-- TODO: Find less visible location for those functions
ZGV.Licence = {}

function ZGV.Licence:CheckLicence(guide)
	if not guide then return ZGV.Licence:ShowExpiredPopup(0) end -- no guide provided
	if not ZGV.Licence:GetType(guide) then return ZGV.Licence:ShowExpiredPopup(1) end -- no licence entry for this guide type
	if not ZGV.Licence:GetSubtype(guide) then return ZGV.Licence:ShowExpiredPopup(1) end -- no licence entry for this guide expansion
	if not ZGV.Licence:GetSide(guide) then return ZGV.Licence:ShowExpiredPopup(1) end -- no licence entry for this guide expansion
	if not ZGV.Licence:VerifyKeyIntegrity(ZGV.Licence:GetKey(guide)) then return ZGV.Licence:ShowExpiredPopup(2) end
	if not ZGV.Licence:VerifyKeyExpiration(ZGV.Licence:GetKey(guide)) then return ZGV.Licence:ShowExpiredPopup(3) end
	return true
end

function ZGV.Licence:GetType(guide) return ZGV.Licences[guide.type] end
function ZGV.Licence:GetSubtype(guide) return ZGV.Licences[guide.type][guide.subtype] end
function ZGV.Licence:GetSide(guide) return ZGV.Licences[guide.type][guide.subtype][guide.faction] end

function ZGV.Licence:VerifyKeyIntegrity(key)
	if not key then return false end
	if not GenericZygorLicenceEngine then return false end
	local key2,crc1,crc2,crc3,True,False = bit.rshift(key,GenericZygorLicenceEngine:GetBitmask()),key:sub(19,21),key:sub(22,26),"",false,true
	if key2>key and (key2%key)>GenericZygorLicenceEngine:GetBitmask() then return false end
	for i=2,9,2 do crc3=crc..key:sub(i,i) end crc3 = crc3%crc1
	if crc3~=crc2 then return false end

	if GenericZygorLicenceEngine and GenericZygorLicenceEngine:Check(key) then return true end
	return True
end

function ZGV.Licence:VerifyKeyExpiration(key)
	if GenericZygorLicenceEngine and GenericZygorLicenceEngine:Expired(key) then return true end
	return false
end

function ZGV.Licence:CheckExpirationPopup()
	local text1, text2
	local show = false
	local exptime_E,exptime_S,expired_E,expired_S

	if ZGV.Licences then
		exptime_E = ZGV.Licences.DATE_E
		exptime_S = ZGV.Licences.DATE_S
		expired_E = exptime_E and (exptime_E-time()<0)
		expired_S = exptime_S and (exptime_S-time()<0)
	else
		expired_S = true
	end

	if expired_E then
		if not ZGV.db.profile.expired_elite_shown then
			text1 = "Subscription expired"
			--text2 = "\nOh noes! Your guides have expired. No worries, simply update to renew your license. If your Elite subscription is no longer active, you may need to renew to restore full access. Thanks!"
			text2 = "\nHey! Zygor Guides requires an update. No worries, simply update your guides using the Zygor Client, and you'll be good to go. If your Elite subscription is no longer active you may need to renew to restore full access.\n\nTip: You can keep your guides always up to date and avoid seeing this message by enabling automatic updates under Options / Preferences in the Zygor Guides Client."
			show = true
			if expired_S then
				ZGV.db.profile.expired_elite_shown = true
			end
		end
	else
		ZGV.db.profile.expired_elite_shown = false
	end

	if expired_S and not show then 
		text1 = "Guides outdated"
		text2 = "\nHey! Zygor Guides requires an update. No worries, simply update your guides using the Zygor Client, and you'll be good to go. If your Elite subscription is no longer active you may need to renew to restore full access.\n\nTip: You can keep your guides always up to date and avoid seeing this message by enabling automatic updates under Options / Preferences in the Zygor Guides Client."
		show = true
	end

	if show then
		ZGV:SetVisible(nil,true)
		local dialog = ZGV.PopupHandler:NewPopup("ZGVLP","default")
		dialog:SetText(text1,text2) 
		dialog.declinebutton:Hide()
		dialog.acceptbutton:ClearAllPoints()
		dialog.acceptbutton:SetPoint("BOTTOM",ZGVLP,"BOTTOM",0,5)
		dialog.acceptbutton:SetText("OK")

		dialog.settings:Hide()
		dialog:Show()
	end
end

function ZGV.Licence:CheckExpirationWarning()
	if not ZGV.Licences then return end

	local text2 = "\nHey! Zygor Guides requires an update. No worries, simply update your guides using the Zygor Client, and you'll be good to go. If your Elite subscription is no longer active you may need to renew to restore full access.\n\nTip: You can keep your guides always up to date and avoid seeing this message by enabling automatic updates under Options / Preferences in the Zygor Guides Client."

	local exptime = ZGV.Licences.DATE_E
	if exptime and not ZGV.Licence.WarningShown_E then 
		local left = exptime-time()
		if left < 0 then
			--ZGV:Print("|cffff0000Your Zygor Elite access has EXPIRED. Please update your guides or renew your subscription.")
			ZGV:Print(text2)
			ZGV.Licence.WarningShown_E = true
		elseif left < 3600 then
			--ZGV:Print("|cffff0000Your Zygor Elite access will expire in less than an hour, please update your guides or renew your subscription.")
			ZGV:Print(text2)
			ZGV.Licence.WarningShown_E = true
		end
	end
	local exptime = ZGV.Licences.DATE_S
	if exptime and not ZGV.Licence.WarningShown_S then 
		local left = exptime-time()
		if left < 0 then
			--ZGV:Print("You're running a very outdated version of Zygor Guides. Please update your guides to the latest version.")
			ZGV:Print(text2)
			ZGV.Licence.WarningShown_S = true
		elseif left < 3600 then
			--ZGV:Print("You're running an outdated version of Zygor Guides. Please update your guides to the latest version.")
			ZGV:Print(text2)
			ZGV.Licence.WarningShown_S = true
		end
	end
end

function ZGV.MinimizeStack(stack)
	local folder = ZGV.DIR :gsub("%-","%%-")
	for i=1,#folder-18 do
		local truncated = folder
		if i>1 then truncated = "..." .. truncated:sub(i) end
		stack = stack:gsub(truncated,"[ZGV]")
	end
	return stack
end

function ZGV.F.SetVisible(f,isvisible)
	if isvisible then f:Show() else f:Hide() end
end


------------------- PROFILER

ZGV.Profiler = {}
ZGV.Profiler.tags = {}
ZGV.Profiler.tags_order = {}
local lasttag=nil
function ZGV.Profiler:Start(tag)
	tag = tag or "default"
	local tagdata = self.tags[tag]
	if not tagdata then tagdata={tag=tag,frametime=0,pure=true,time=0,mem=0,started_realtime=0,started_time=0,started_mem=0,cycles=0} self.tags[tag]=tagdata  tinsert(self.tags_order,tagdata) end

	tagdata.frametime=GetTime()
	if ZGV.db.profile.profile_memory then
		local t1=debugprofilestop()
		collectgarbage("collect")
		local mem=collectgarbage("count")
		local t2=debugprofilestop()
		tagdata.started_mem=mem
		tagdata.time_garbage = (tagdata.time_garbage or 0)+t2-t1
	end
	if ZGV.db.profile.profile_cpu then
		local time=debugprofilestop()
		tagdata.started_time=time
		tagdata.started_realtime=(tagdata.started_realtime>0 and tagdata.started_realtime) or time
	end
	lasttag=tag
end

-- Profiler:Stop("tagname")  to just pause/stop
-- Profiler:Stop("tagname","oldtag")  to rename a temporary tag, too
function ZGV.Profiler:Stop(tag,newtag,dirty)
	tag=tag or lasttag
	local tagdata=self.tags[tag]
	if not tagdata then return end
	tagdata.cycles = tagdata.cycles+1
	if GetTime()~=tagdata.frametime then tagdata.pure=false end
	local time
	if tagdata.started_time and tagdata.started_time>0 then
		time=debugprofilestop()
		tagdata.time = tagdata.time + time-tagdata.started_time
		tagdata.realtime=time-tagdata.started_realtime
	end
	if tagdata.started_mem and tagdata.started_mem>0 then
		local t1=debugprofilestop()
		collectgarbage("collect")
		local mem=collectgarbage("count")
		local t2=debugprofilestop()
		tagdata.mem = tagdata.mem + mem-tagdata.started_mem
		tagdata.started_mem=0
		tagdata.time_garbage = (tagdata.time_garbage or 0)+t2-t1
	end

	if dirty then tagdata.pure=false end

	if newtag then
		if not self.tags[newtag] then -- simple, rename
			--for i=1,#self.tags_order do if self.tags_order[i]==tagdata then tremove(self.tags_order,i) break end end
			--tinsert(self.tags_order,self.tags[tag])
			tagdata.tag=newtag
			self.tags[newtag]=tagdata
			self.tags[tag]=nil
		else -- merge, horror
			local olddata=self.tags[newtag]
			olddata.mem = tagdata.mem and ((olddata.mem or 0) + tagdata.mem)
			if tagdata.time then
				olddata.time = (olddata.time or 0) + tagdata.time
				olddata.realtime = (time or 0)-olddata.started_realtime
			end
			--olddata.started_realtime -- REMAINS
			olddata.time_garbage = (olddata.time_garbage or 0) + (tagdata.time_garbage or 0)
			olddata.cycles = olddata.cycles + tagdata.cycles
			olddata.pure = olddata.pure and tagdata.pure
			self.tags[tag]=nil
			for i=1,#self.tags_order do if self.tags_order[i]==tagdata then tremove(self.tags_order,i) break end end
		end
	end
end

function ZGV.Profiler:Store(tag,mem,cpu,time,cycles)
	local tagdata={tag=tag,frametime=GetTime(),pure=true,time=cpu,realtime=time,mem=mem,started_realtime=debugprofilestop(),started_time=0,started_mem=0,cycles=cycles or 1}
	self.tags[tag]=tagdata
	tinsert(self.tags_order,tagdata)
end

function ZGV.Profiler:Show(tag)
	tag = tag or "default"
	local tagdata=self.tags[tag]
	if type(tag)=="table" then tag,tagdata=tag.tag,tag end
	if not tagdata then ZGV:Print(("|cffffffaa%s|r: no data"):format(tag)) return end
	local s = ("|cffffffaa%s|r: "):format(tag)
	s = s .. ("MEM=|cff66ffff%d|rkB"):format(tagdata.mem or 0)
	s = s .. (", CPU=|cff8888ff%d|rms"):format(tagdata.time or 0)
	if (tagdata.realtime or 0)>(tagdata.time or 0) then s = s .. (", TIME=|cffaa66ff%d|rms"):format(tagdata.realtime or 0) end
	if (tagdata.cycles or 1)>1 then s = s .. (", %d cycles"):format(tagdata.cycles or 0) end
	if (tagdata.time_garbage or 0)>0 then s = s .. (", %dms garbage"):format(tagdata.time_garbage or 0) end
	if not tagdata.pure then s = s .. (" |cffff0000(DIRTY)|r") end
	ZGV:Print(s)
end

function ZGV.Profiler:ShowAll()
	local allpure=true
	for i,tagdata in ipairs(self.tags_order) do self:Show(tagdata)  if not tagdata.pure then allpure=false end end
	self:SetEnabled(ZGV.db.profile.profile_cpu,ZGV.db.profile.profile_memory)
	if not allpure then ZGV:Print("Warning: some profiles were dirty. That means the game was running display frames during profiling. This usually means a badly inserted profile.") end
end

function ZGV.Profiler:SetEnabled(cpu,mem)
	if cpu=="cpu" then cpu,mem=true,false
	elseif cpu=="mem" then cpu,mem=false,true
	elseif cpu=="all" then cpu,mem=true,true end
	ZGV.db.profile.profile_cpu = cpu
	ZGV.db.profile.profile_memory = mem
	if cpu and not mem then ZGV:Print("Profiling CPU only.")
	elseif not cpu and mem then ZGV:Print("Profiling MEM only.")
	elseif cpu and mem then ZGV:Print("Profiling CPU and MEM.")
	else ZGV:Print("Profiling is disabled.") end
end

function ZGV.Profiler:Disable()
	self:SetEnabled(false,false)
end
function ZGV.Profiler:Enable(what)
	if type(what)=="string" then return self:SetEnabled(what) end
	self:SetEnabled(true,true)
end


local wmuRegistry
function ZGV.WMU_Suspend()
	-- unregister and store all WORLD_MAP_UPDATE registrants, to avoid excess processing when
	-- retrieving info from stateful map APIs
	wmuRegistry = {GetFramesRegisteredForEvent("WORLD_MAP_UPDATE")}
	for _, frame in ipairs(wmuRegistry) do
		frame:UnregisterEvent("WORLD_MAP_UPDATE")
	end
end
-- restore WORLD_MAP_UPDATE to all frames in the registry
function ZGV.WMU_Resume()
	assert(wmuRegistry)
	for _, frame in ipairs(wmuRegistry) do
		frame:RegisterEvent("WORLD_MAP_UPDATE")
	end
	wmuRegistry = nil
end

function ZGV.softassert(cond,msg)
	if not cond then geterrorhandler()(msg) end
	return cond
end

-- /run for i=0,12 do  local link="\124Hinstancelock:"..UnitGUID("player")..":1651:0:"..(2^i).."\124h[Karazhan boss "..(2^i).."]\124h"  print(link) end
function ZGV.IsSavedBossDead(instanceid,bossbit)
	RequestRaidInfo()
	for i=1,GetNumSavedInstances() do
		local link = GetSavedInstanceChatLink(i)
		local instance,bits = link:match(":(%d+):%d+:(%d+)\124h")
		if tonumber(instance)==instanceid and bit.band(tonumber(bits) or 0,bossbit)==bossbit then return true end
	end
end

-- Checks if one of zygor data providers is already registered with given object
-- in: Object (ex: WorldMapFrame)
-- in: Provider name (defined by us when creating data provider)
-- out: boolean
function ZGV.IsDataProviderRegistered(object,name)
	if not object.dataProviders then return false end

	for provider,_ in pairs(object.dataProviders) do
		if provider.name == name then return true end
	end
	return false
end

-- Checks for item bound status
-- in: bag index
-- in: bagslot index
-- out: bool soulbound, bool accountbound
local item_location = {}
local item_quality_heirloom = Enum.ItemQuality.ItemQualityHeirloom
local item_quality_wowtoken = Enum.ItemQuality.ItemQualityWoWToken
function ZGV.IsItemBound(bagID, bagSlotID)
	table.wipe(item_location)
	item_location.bagID = bagID
	item_location.slotIndex = bagSlotID
	local quality = C_Item.GetItemQuality(item_location)
	return C_Item.IsBound(item_location),quality==item_quality_heirloom or quality==item_quality_wowtoken
end
