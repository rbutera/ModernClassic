assert(not _G['ZGV'],"Two ZygorGuideViewers loaded!\nWe're doomed!")

local addonName,ZygorGuidesViewer = ...

ZygorGuidesViewer = LibStub("AceAddon-3.0"):NewAddon(ZygorGuidesViewer,addonName, "AceConsole-3.0","AceEvent-3.0","AceTimer-3.0","AceHook-3.0")

local ZGV=ZygorGuidesViewer
--global exports
_G['ZygorGuidesViewer']=ZygorGuidesViewer
_G['ZGV']=ZGV

ZGV.L = ZygorGuidesViewer_L("Main")
ZGV.LS = ZygorGuidesViewer_L("G_string")

ZGV.CLASSIC_SCALE_ADJUST = UIParent:GetEffectiveScale()

local L = ZGV.L
local LI = ZGV.LI
local LC = ZGV.LC
local LQ = ZGV.LQ
local LS = ZGV.LS

ZGV.HBD = LibStub("HereBeDragons-ZGV")
ZGV.HBDPins = LibStub("HereBeDragons-Pins-ZGV")

local HBD=ZGV.HBD
local HBDPins=ZGV.HBDPins

--ZGV.name = L['name_plain']

ZGV.Vars={}

-- Time to add some testing. ~~ Jeremiah
ZGV.TestFramework = {}
ZGV.TestFramework.UnitTests = {} -- Not used yet.
ZGV.UseUnitTesting = false -- Turn off before release! 


local DIR = "Interface\\AddOns\\"..addonName
ZGV.DIR = DIR
local SKINDIR = ""


ZYGORGUIDESVIEWER_COMMAND = "zygor"
ZYGORGUIDESVIEWERFRAME_TITLE = "ZygorGuidesViewer"

BINDING_HEADER_ZYGORGUIDES = L["name_plain"]
BINDING_NAME_ZYGORGUIDES_OPENGUIDE = L["binding_togglewindow"]
BINDING_NAME_ZYGORGUIDES_PREV = L["binding_prev"]
BINDING_NAME_ZYGORGUIDES_NEXT = L["binding_next"]
BINDING_NAME_ZYGOR_WAYPOINT_NEXT = L["binding_waypoint_next"]
BINDING_NAME_ZYGOR_WAYPOINT_PREV = L["binding_waypoint_prev"]


local build = tonumber(select(2,GetBuildInfo()),nil)
ZGV.Expansion_Cata = true
ZGV.Expansion_Mists = (build>=15799)
ZGV.Expansion_Warlords = (build>=18566)
ZGV.Expansion_Legion = (build>=22248)

ZGV.Patch_7_2 = (build>=23721)

-- local libs

local BZ = LibStub("LibBabble-SubZone-3.0")
local BZL = BZ:GetUnstrictLookupTable()
local BZR = setmetatable({_table=BZ:GetReverseLookupTable()},{__index=function(t,k) return t._table[k] or k end})
ZGV.BZL = BZL
ZGV.BZR = BZR
local BF = LibStub("LibBabble-Faction-3.0")
local BFL = BF:GetUnstrictLookupTable()
local BFR = BF:GetReverseLookupTable()
ZGV.BFL = BFL
ZGV.BFR = BFR
--local Dewdrop = AceLibrary("Dewdrop-2.0")
ZGV.LibTaxi = LibStub("LibTaxi-1.0")


-- localizing common functions

local _G,assert,table,string,tinsert,tremove,tonumber,tostring,type,ipairs,pairs,setmetatable,math,resume,status,yield,debugprofilestop =
      _G,assert,table,string,tinsert,tremove,tonumber,tostring,type,ipairs,pairs,setmetatable,math,coroutine.resume,coroutine.status,coroutine.yield,debugprofilestop


ZGV.registeredguides = {}
ZGV.registeredmapspotsets = {}
ZGV.guidesets = {}
ZGV.registered_groups = { groups={},guides={}}


ZGV.CartographerDatabase = { }


local MAX_GUIDES_HISTORY = 30


ZGV.STARTUP_INTENSITY=10
ZGV.startups = {}
ZGV.LIBROVER_MANAGED_STARTUP=true



ZGV.CFG = {}
ZGV.CFG.LINES_PER_STEP = 30

local LINES_PER_STEP = ZGV.CFG.LINES_PER_STEP


ZGV.StepLimit = 20
ZGV.stepframes = {}
ZGV.spotframes = {}

ZGV.mentionedQuests = {}

ZGV.MapIDsByName = LibRover.data.MapIDsByName

-- TODO these should be culled and moved into Skin styles
local STEP_LINE_SPACING = 3
local MIN_HEIGHT=80
local ICON_INDENT=17
ZGV.ICON_INDENT = ICON_INDENT  -- so that other files can access it; silly, I know
local STEP_SPACING = 2
ZGV.STEP_SPACING=STEP_SPACING
-- ZGV.STEPMARGIN_X=3
-- ZGV.STEPMARGIN_Y=3

local LINE_MARGIN_TOP = 3
local LINE_MARGIN_BOTTOM = 3


-- This gets really useful, probably move to functions or make it ZGV member?
local function SkinData(parm)
	return ZGV.CurrentSkinStyle:SkinData(parm)
end


ZGV.MIN_STEP_HEIGHT=12
ZGV.MIN_SPOT_HEIGHT=40

local MIN_WIDTH = 260
local TOP_HEIGHT = 65

--local FONT = STANDARD_TEXT_FONT
local FONT=L['MainFont']
local FONTBOLD=L['MainFontBold']
ZGV.Font = FONT
ZGV.FontBold = FONTBOLD

local lastcompletion=0


--ZGV.CLEAR_GUIDE_RAWDATA_AFTER_PARSING = 1
-- DON'T. Guides that are UNloaded have their .steps cleared - they need rawdata to be parsed again!


--ZGV.BUTTONS_INLINE=true


-- BAD GLOBALS!

local math_modf=math.modf
math.round=function(n) local x,y=math_modf(n) return n>0 and (y>=0.5 and x+1 or x) or (y<=-0.5 and x-1 or x) end
local round=math.round


StaticPopupDialogs['ZYGORGUIDESVIEWER_HELP'] = {
	text = L['static_help'],
	button1 = OKAY,
	hideOnEscape = 1,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs['ZYGORGUIDESVIEWER_SIS'] = {
	text = L['static_sis'],
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function(self) ZGV:SIS_Activate() end,
	hideOnEscape = 1,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs['ZYGORGUIDESVIEWER_DEFAULT'] = {
	text = L['static_caption'].."%s",
	button1 = OKAY,
	hideOnEscape = 1,
	timeout = 0,
	whileDead = 1,
}

ZGV.loadtime = debugprofilestop()
ZGV.loadtimeGT = GetTime()

function ZGV:OnInitialize()
	ZGV.db = LibStub("AceDB-3.0"):New("ZygorGuidesViewerClassicSettings")
	
	ZGV.db.global.gii_cache=ZGV.db.global.gii_cache or {}

	ZGV.db.global.sv_version = tonumber(ZGV.db.global.sv_version) or 1  + 1

	self:WarnAboutDebugSettings()

	assert(ZGV.version,"Ver.lua missing!")
	--print("zgv oninit")
	--if not CHECK then CHECK = 3 end

--	if not ZygorGuidesViewerMiniFrame then error("Zygor Guide Viewer step frame not loaded.") end

	
	ZGV.Profiler:Store("file-load-total",ZGV.loading_memory_total,ZGV.loading_time_total,ZGV.loading_time_total)
	ZGV.loading_time_total=nil
	ZGV.loading_memory_total=nil


	ZGV.starttime = debugprofilestop()

	local t1=debugprofilestop()

	self:Debug ("&startup Initializing...")

	if self.db.profile.do_disable_profiler then
		SetCVar("scriptProfile","0")
		self.db.profile.do_disable_profiler = nil
	end
	if (GetCVar("scriptProfile")=="1") then
		self:Debug("Somebody set us up a bomb: Lua profiler is enabled. Disabling it on next reload")
		self.ProfilerMode=true
		self.db.profile.do_disable_profiler = true
	end

	self:Options_Initialize()

	ZGV:Print("Loading...")
	
	
	if IsShiftKeyDown() then
		self:Debug ("MAINTENANCE MODE!")

		-- DISABLE all maint settings
		for k,v in pairs(self.db.char) do if k:match("^maint_") then self.db.char[k]=false end end

		ZygorGuidesViewerMaintenanceFrame:Show()
	
	else
		
		-- ENABLE all maint settings. They should be enabled already, by default, anyway...
		for k,v in pairs(self.db.char) do if k:match("^maint_") then self.db.char[k]=true end end
	end



	self.db.char.completedQuests=nil --wipe and flush

	self.CurrentStepNum = self.db.char.step
	self.CurrentGuideName = self.db.char.guidename and self.db.char.guidename:gsub("ataclsym","ataclysm")  -- TODO: remove after a while. Ugly fix.

	self.briefstepexpansionlines = {}
	self.briefstepexpansionspeedlines = {}

	self.QuestCacheTime = 0
	self.QuestCacheUndertimeRepeats = 0
	self.StepCompletion = {}
	self.recentlyAcceptedQuests = {}
	self.recentlyLostQuests = {}
	self.recentlyCompletedQuests = {}
	self.LastSkip = 1

	self.quests = {}
	self.questsbyid = {}
	self.reputations = {}

	self.bandwidth = 0

	self.TomTomWaypoints = {}

	self.instantQuests = {}
	self.dailyQuests = self.dailyQuests or {}

	self.completionelapsed = 0
	self.completionintervaldefault = 1.0 -- when sitting on a step, waiting for it to complete.
	self.completionintervallong = 1.0 -- when starting skipping through steps
	self.completionintervalmin = 0.01 -- after skipping through some steps
	self.completionintervalspeed = 0.8 -- multiplier of speed at each step in a row
	self.completioninterval = self.completionintervaldefault
	self.completionstreak = 0

	self:Debug ("&startup Initializing step 2...")
	self.db.char.lastlogin = time()

	-- initialize/convert history
	if not self.db.char.guides_history_ZGV4clear then self.db.char.guides_history={} self.db.char.guides_history_ZGV4clear=true end
	if not tonumber((next(self.db.char.guides_history))) then -- convert back to flat
		local g={}
		for gtype,guide in pairs(self.db.char.guides_history) do  tinsert(g,guide)  end
		self.db.char.guides_history=g
	end


	self:ClearRecentActivities() -- just to make sure they're not nils

	--self.AutoskipTemp = true

	self:Debug ("&startup Initializing skin...")

	self:SetSkin(self.db.profile.skin,self.db.profile.skinstyle)
	if not self.Frame then
		self:Print("Cannot initialize skin: "..self.db.profile.skin.."... Resetting skin.")
		self:SetSkin()
		assert(self.Frame,"Cannot initialize any skin, sorry")
	end
	ZygorGuidesViewerFrame = self.Frame

	self.frameNeedsResizing = 0

	self.Frame:SetScale(self.db.profile.framescale)
	self.Frame:AlignFrame()
	self:UpdateLocking()
	self:ReanchorFrame()

	if ZGV.DEV and LibTaxi and LibTaxi.errors and next(LibTaxi.errors) then ZGV:Print("DEV: LibTaxi reports errors. See LibTaxi.errors") end

	self:Debug ("&startup Initialized in %.2f",debugprofilestop()-t1)

	-- Making sure no Bag Addon can see our dearest minimap icons
	local trueMinimapGetChildren=Minimap.GetChildren
	assert(trueMinimapGetChildren) -- if that ever breaks we might need to reschedule the operation or something
	function Minimap:GetChildren()
		local res={ trueMinimapGetChildren(self) }
		for k,v in pairs(res) do
			if v.isZygorWaypoint then
				table.remove(res,k) -- Nothing to see here, move along
			end
		end
		return unpack(res)
	end

	--[[
	if ZygorTalentAdvisor and ZygorTalentAdvisor.revision > self.revision then
		self.revision = ZygorTalentAdvisor.revision
		self.version = ZygorTalentAdvisor.version
		self.date = ZygorTalentAdvisor.date
	end
	--]]

	ZGV.LibRover:DoStartup()

	-- home detection, fire-and-forget style.
	hooksecurefunc("ConfirmBinder",function() ZygorGuidesViewer.recentlyHomeChanged=true end)

	if self.DEV then
		ZGV.DebugFrame = ZGV.ChainCall(CreateFrame("FRAME","ZygorDebugFrame",UIParent)) :SetPoint("TOPLEFT") :SetSize(1,1) .__END
		ZGV.DebugFrame.text1 = ZGV.ChainCall(ZGV.DebugFrame:CreateFontString()) :SetPoint("TOPLEFT") :SetFontObject(SystemFont_Tiny) .__END
		if self.db.profile.fpsgraph then
			ZGV:StartFPSFrame()
		end
	end
	
	if self.ERRORS then self:Print("Errors were detected on startup, see ZGV.ERRORS") end

	self:Debug("&startup Initialized")
end

function ZGV:OnEnable()

	self:Debug("&startup Enabling...")

	local t1=debugprofilestop()

	ZygorGuidesViewerMapIcon:Show()

	self:UpdateMapButton()
	self:UpdateSkin()

	self:AddEventHandler("UNIT_INVENTORY_CHANGED")

	-- combat detection for hiding in combat
	self:AddEventHandler("PLAYER_REGEN_DISABLED")
	self:AddEventHandler("PLAYER_REGEN_ENABLED")
	--self:AddEventHandler("WORLD_MAP_UPDATE")

	self:AddEventHandler("SPELL_UPDATE_COOLDOWN")

	self:AddEventHandler("PLAYER_CONTROL_GAINED")  -- try to force current zone updates; should prevent GoTo lines from locking up after a taxi flight

	self:AddEventHandler("PLAYER_ENTERING_WORLD")  -- cache current map id
	self:AddEventHandler("ZONE_CHANGED")
	self:AddEventHandler("ZONE_CHANGED_INDOORS")
	self:AddEventHandler("ZONE_CHANGED_NEW_AREA")
	self:AddEventHandler("NEW_WMO_CHUNK")
	
	--[[ bfa alpha change
	self:AddEventHandler("MAP_BAR_UPDATE")
	--]]

	self:AddEventHandler("COMBAT_LOG_EVENT_UNFILTERED")
	self:AddEventHandler("LOADING_SCREEN_DISABLED")
	self:AddEventHandler("LOADING_SCREEN_ENABLED")

	self:AddEventHandler("TAXIMAP_OPENED")

	self:AddEventHandler("GET_ITEM_INFO_RECEIVED")

	self:AddEventHandler("PLAYER_LEVEL_UP") -- legion popups

	--self:AddEventHandler("UPDATE_VEHICLE_ACTIONBAR") -- refresh actionbar when vehicle/pet is summoned/dismissed

	self:AddMessageHandler("ZGV_LOADING_TOPLEVEL_GROUPS_UPDATED")

	if self.db.profile.poketarget then
		self:AddEventHandler("UPDATE_MOUSEOVER_UNIT")
		self:AddEventHandler("CURSOR_UPDATE")
	end
		

	--self:Hook_QuestChoice()

	hooksecurefunc(AreaPOIPinMixin,"OnAcquired", function(self) 
		self:EnableMouse(true)
		self:SetScript("OnMouseUp",function(self) ZGV:SuggestGuideFromBlizzardIcon(self) end)
	end)	

	--self.Localizers:PruneNPCs()  -- off until we start doing it by data, not by name. ~sinus 2013-04-09

	self.Log.entries = self.db.char.debuglog
	self.Log:Add("Viewer started. ---------------------------")

	-- waiting for QUEST_LOG_UPDATE for true initialization...

	if ZGV_DEV then ZGV_DEV() end
	self:SetBeta()
	--if ZGV.BETA and ZygorGuidesViewerFrame_DevLabel then ZygorGuidesViewerFrame_DevLabel:SetText("BETA") end

	if self.db.profile.frame_anchor then
		self.db.profile.frame_anchor[2]=UIParent
		self.Frame:GetParent():ClearAllPoints()
		self.Frame:GetParent():SetPoint(unpack(self.db.profile.frame_anchor))
	end

	self:Debug("&startup Enabled in %.2f ms",debugprofilestop()-t1)

	self.loading=""
end

function ZGV:OnDisable()
--	self:UnregisterAllEvents()
	UnsetWaypointAddon()

	ZygorGuidesViewerMapIcon:Hide()
	self.Frame:Hide()
end

-- Compare two guides or guide groups. Sort wisely according to either registered_sortings or registration order (first-come-first-serve)
local function CompGroups(a,b)
	local aname=ZGV.GuideTitles[a.name]
	local bname=ZGV.GuideTitles[b.name]

	local sa=ZGV.registered_sortings[aname or a.title_short]
	local sb=ZGV.registered_sortings[bname or b.title_short]

	if sa and sb then return sa<sb else return a.ord<b.ord end
end

local function SortGroups(group,recurse)
	table.sort(group.groups,CompGroups)
	table.sort(group.guides,CompGroups)
	if recurse then for i,gr in ipairs(group.groups) do
		SortGroups(gr,recurse)
	end end
end


function ZGV:Startup_LoadGuides_Threaded()
	local full_load = self.db.profile.loadguidesfully

	if #self.registeredguides>0 then
		self.loading = L['loading_guides']


		-- prune banned first
		local newreg = {}
		for i=1,#self.registeredguides do
			local guide=self.registeredguides[i]
			if self.GuideFuncs:IsGuideBanned(guide.title) or (guide.beta and not ZGV.BETA) then
				self.registeredguides[i]=nil
			else
				tinsert(newreg,guide)
				guide.num=#newreg
			end
		end
		self.registeredguides = newreg

		-- FAST START: load current guide first!
		self:LoadInitialGuide("fastload")

		local t=debugprofilestop()
		local count_total=#self.registeredguides
		local count=0
		for i,guide in ipairs(self.registeredguides) do repeat
			guide:ParseHeader()
			if full_load then guide:Parse(full_load) end
			--if guide.type=="pet" or guide.type=="mount" then
			--	guide:Parse(true) -- Those guys are useful for detector
			--end

			-- if parsed then assign to a group
			local group,tit = guide.title:match("^(.*)\\+(.-)$")
			group = group and self:FindOrCreateGroup(self.registered_groups,group) or self.registered_groups
			guide.ord=#group.guides+1
			tinsert(group.guides,guide)


			count=count+1
			if debugprofilestop()-t>(self.LOADGUIDES_INTENSITY or self.STARTUP_INTENSITY) then  -- let it take us down to 3fps, it's the startup. -- NOOOO! - 2016-03-28 21:21:06 sinus
				self.loadprogress = i/#self.registeredguides
				self:SendMessage("ZGV_LOADING")
				yield("loadguides: " .. (full_load and "parsing fully" or "parsing headers"),count/count_total*100)
				t=debugprofilestop()
			end
		until true end
		yield("loadguides: " .. (full_load and "parsed fully" or "parsed headers"))

		for i,guide in ipairs(self.registeredguides) do
			if guide.startlevel and not guide.endlevel and guide.next then
				local nextg = self:GetGuideByTitle(guide.next)
				if nextg and nextg.startlevel then
					guide.endlevel = nextg.startlevel
				end
			end
			--[[
			-- too fast for progress, eh?
			self.loadprogress = i/#self.registeredguides
			self:SendMessage("ZGV_LOADING")
			yield()
			--]]
		end

		yield("loadguides: startleveling")
	end

	-- sort guides, according to preset sortings.
	SortGroups(self.registered_groups,"recurse")
	yield("loadguides: sorting groups")

	--[[
	if #self.registeredmapspotsets>0 then
		for i,guide in ipairs(self.registeredmapspotsets) do
			if guide.rawdata then
				local parsedset,err,line,linedata = self.MapSpotSetProto.ParseRaw(guide)
				if parsedset then
					self.loadprogress = i/#self.registeredmapspotsets
					guide:Show()
				else
					if err then
						self:Print(L["message_errorloading_full"]:format(guide.title,line,linedata,err))
					else
						self:Print(L["message_errorloading_brief"]:format(guide.title))
					end
					guide.rawdata=nil
				end
				yield()
			end
			self:SendMessage("ZGV_LOADING")
		end

		local tab1 = self.Frame.Border.Tab1
		--tab1:SetPoint("LEFT",self.Frame.Border,"TOPLEFT",65,-12)
		tab1:SetText("Guides")
		tab1:SetNormalFontObject(ZGVFTabFont)
		--PanelTemplates_TabResize(self.Tab1,0);
		--_G[self.Tab1:GetName().."HighlightTexture"]:SetWidth(self.Tab1:GetTextWidth() + 20);
		tab1:SetScript("OnClick",function() ZGV:SetDisplayMode("guide") end)
		tab1:Show()

		local tab2 = self.Frame.Border.Tab2
		tab2:SetPoint("LEFT",tab1,"RIGHT")
		tab2:SetText("Spots")
		tab2:SetNormalFontObject(ZGVFTabFont)
		--ZGVFrameTab2Text:SetText("Spots")
		--PanelTemplates_TabResize(self.Tab2,0);
		--_G[self.Tab2:GetName().."HighlightTexture"]:SetWidth(self.Tab2:GetTextWidth() + 20);
		tab2:SetScript("OnClick",function() ZGV:SetDisplayMode("gold") end)
		tab2:Show()

		self.Frame:AlignFrame()
	end
	yield("map spots")
	--]]

	-- WIPE!
	--self.ParseQuestChains=nil
	--self.CreateReverseQuestChains=nil
	self.RegisterGuide=function() ZGV:Print("Too late to RegisterGuide at this point!") end
	self.RegisterMapSpots=nil

	self:SendMessage("ZGV_LOADING")

	self.guidesloaded=true

	--self:UpdateGuideMenuButton()

	yield("loadguides: complete.")
end

ZGV.maint_done={}
local function waitformaint(maint)
	while not ZGV.db.char[maint] do yield("waiting for "..maint) end
	ZGV.maint_done[maint]=true
end


function ZGV:StartupModule_Threaded(startup,timeleft)
	timeleft = timeleft or ZGV.STARTUP_INTENSITY
	
	self:Debug("&startup Starting module: |cffffffff%s|r, allotted time: |cffffddee%d|rms",startup.name,timeleft)

	local t0=debugprofilestop()
	local t=t0
	repeat
		if self.db.profile.safe_startup then t=debugprofilestop() yield("Before startup module: ".. startup.name .." ...") end

		local t1 = debugprofilestop()
		ZGV.Profiler:Start("startup-module-"..startup.name)
		local ok,ret = coroutine.resume(startup.thread,timeleft)
		ZGV.Profiler:Stop()
		t1 = debugprofilestop()-t1

		if self.db.profile.safe_startup then t=debugprofilestop() yield(("Startup module: |cffffddee%s|r took %d ms"):format(startup.name,t1)) end

		--if not self.db.profile.safe_startup then self:Debug("&startup Startup module: %s in %d ms",name,t1) end
		if not ok then  self:ErrorThrow("Error during initialization sequence '"..startup.name.."':\n"..ret.."\n-- STACKTRACE: --\n"..ZGV.MinimizeStack(debugstack(startup.thread)))  end

		--if self.db.profile.safe_startup then t=debugprofilestop() yield("Finished startup module: "..name..(" in %d ms"):format(t1))
		--elseif debugprofilestop()-t>100 then t=debugprofilestop() yield("(startup modules up to "..i..")") end
		
		if debugprofilestop()-t>timeleft then t=debugprofilestop() timeleft=yield("(startup modules up to "..startup.name..")",ret) or timeleft end

	until coroutine.status(startup.thread)=="dead"

	self:Debug("&startup Starting module: |cffffffff%s|r done in |cffffddee%d|rms.",startup.name,debugprofilestop()-t0)
end

ZGV.startups_late = {}

local function _StartupThread()
	local self=ZGV
		
	waitformaint("maint_startup_01") ----------------------------------
	
	self.loading="Loading..."

	--self.registeredmapspotsets = {}
	waitformaint("maint_startup_pointer") ---------------------


	if self.Pointer then self.Pointer:Startup() end
	if self.Foglight then self.Foglight:Startup() end
	LibTaxi:Startup(ZGV.db.char.taxis)

	ZGV.HBD:FixPhasedContinents()
	
	waitformaint("maint_startup_modules") ---------------------

	if ZGV.db.profile.debug and ChatFrame1 and ChatFrame1.SetMaxLines then ChatFrame1:SetMaxLines(2000) end

	local popup = ZGV.PopupHandler:NewPopup("GenericPopup","default")


	yield("Before startups.")

	-- startup 'modules'
	ZGV.Profiler:Start("startup-total")
	ZGV.Profiler:Stop("startup-total")
	for i,startup in ipairs(self.startups) do
		if type(startup)=="table" then  startup.name,startup.func=unpack(startup)
		elseif type(startup)=="function" then  self.startups[i]={name="unnamed("..i..")",func=startup}  startup=self.startups[i]  end
		startup.late=startup.async
		startup.thread = coroutine.create(function() startup.func(self) end)
	end
	for i,startup in ipairs(self.startups) do  if not startup.late then ZGV:StartupModule_Threaded(startup) end end

	ZGV.Profiler:Start("startup-total")
	ZGV.Profiler:Stop("startup-total")

	self:Debug("&startup Startup modules (early) are done.")


	-- TODO maybe... for now let it be standalone
	--[[
	-- startup gearfinder
	if self.db.profile.autogear then
		self.ItemScore.GearFinder:DoStartup()
		yield("&startup gear cache thread initializing...")
		-- wait until it finishes caching. Careful not to cycle forever!
		local max_gear_cycles=100
		while max_gear_cycles>0 and not self.ItemScore.GearFinder.cached do yield("gear init") max_gear_cycles=max_gear_cycles-1 end
		if max_gear_cycles<=0 then self:Error("Gearfinder caching took over 100 cycles!") end
		print(max_gear_cycles)
	end
	--]]



	self.Parser.ConditionEnv:_Setup()


	waitformaint("maint_startup_loadguides") ----------------------------

	--self.Frame:SetShown(self.db.profile.enable_viewer)

	-- fast start!
	self:SetVisible(nil,self.db.profile.enable_viewer)
	self:UpdateFrame(true)
	--self:UpdateGuideMenuButton()

	self:Startup_LoadGuides_Threaded()

	if #self.ParseLog>0 then
		self:ShowDump(self.ParseLog,"Errors in guides",true)
	end


	self:Debug("&startup Guides loaded. ---------")

	--[[
	self:Debug("Caching follow-ups...")
	self:CacheMentionedFollowups()
	self:Debug("Cached.")
	yield(1)
	--]]

	-- wait for asyncs to finish
	--while #ZGV.startup_async_threads and not ZGV.startup_async_threads.alldead do yield("waiting for asyncs...") end

	-- run "late" startups
	for i,startup in ipairs(self.startups) do  if startup.late then ZGV:StartupModule_Threaded(startup) end end

	self.startups=nil  -- clear out, save memory

	self:Debug("&startup Startup modules (late) are done.")


	waitformaint("maint_startup_final") ----------------------------

	self.loading="Cleaning up..."
	--collectgarbage("step",10000)
	--yield("garbage collected? why?")

	--self.MagicKey:CreateFrame()
	--self.magickeytimer = self:ScheduleRepeatingTimer("SetMagicKey", 0.2)

	self.pause = true
	self.completiontimer = self:ScheduleRepeatingTimer("TryToCompleteStep", 0.1)
	self.maptimer = self:ScheduleRepeatingTimer("CacheCurrentMapID", 1.0)

	--if self.DEV then self:ScheduleRepeatingTimer("ThunderStageForceUpdate", 10.0) end -- TEMPORARY TIMING OF THUNDER ISLE

	--self.notetimer = self:ScheduleRepeatingTimer("ShowWaypoints", 1)
	--self.dailytimer = self:ScheduleRepeatingTimer("QuestTracking_ResetDailies", 5)

	--self:CancelTimer(self.startuptimer,true)


	--while self.LibRover and self.LibRover.startup_thread and not self.LibRover.ready do yield("waiting for Travel") end
	--while self.ItemScore and self.ItemScore.GearFinder and self.ItemScore.GearFinder.started and not self.ItemScore.GearFinder.cached do yield("waiting for GearFinder") end

	
	self:SendMessage("ZGV_GUIDES_PARSED", "done")

	self:Print(L['welcome_guides']:format(#self.registeredguides))

	self.Checklist:CatchEvent("_GUIDES_LOADED_")

	self:SetVisible(nil,self.db.profile.enable_viewer)
	self:UpdateFrame(true)

	ZGV.Licence:CheckExpirationPopup()

	if not ZGV.db.profile.delayed_startup then
		self:LoadInitialGuide()
	end


	if not self.db.profile.ranconfig2 then
		self.Config:Run()
	end



	self:Debug("Loading time - guides: %.2f",self.loading_time_guides or -1)
	self:Debug("Loading time - DEV: %.2f",self.loading_time_DEV or -1)
	self:Debug("Loading time - total: %.2f",self.loading_time_total or -1)

	--if ZGV.AnimatePopup then ZGV:ShowAnimatedPopup() end -- if we have animated popup, show it

	--collectgarbage()
	self.pause = nil
	return "end"
end

-- This gets called every frame on startup, by MasterFrame. Needs to return true to confirm successful startup.
local thread
local startup_time=0
local startup_frames,startup_ticks=0,0
local last_gettime
local displayedInCombatWarning = false

ZGV.startuptimes={}
function ZGV:StartupStep()  -- called from MasterFrame
	if not last_gettime then last_gettime=GetTime() end
	if last_gettime==GetTime() then return end  -- ah-ha, NOT loaded then!

	 -- CLASSIC FIX disabled
	--if (UnitExists("player") and UnitInVehicle("player")) then self.loading_screen_disabled = true end -- Blizz... if we are in vehicle, loading_screen_disabled will never fire after loading
	if not self.loading_screen_disabled then return end

	
	if not thread then
		thread = coroutine.create(_StartupThread)
		self:Debug("&startup Startup thread created.")
		return
	end

	-- If player is in combat, show a warning and wait for combat to end, since it breaks Pointer.
		if ZGV:IsPlayerInCombat() then
			if not displayedInCombatWarning then
				ZygorGuidesViewerFrameMaster:SetAlpha(0)
				self:Print("You are in combat! Zygor Guides will resume loading when you're safe again.")
				displayedInCombatWarning = true
			end
			return
		end 
		if displayedInCombatWarning then
			displayedInCombatWarning = false
			ZygorGuidesViewerFrameMaster:SetAlpha(1)
		end
	--

	startup_frames = startup_frames + 1

	local thistime=0
	local thisframet = debugprofilestop()
	self:Debug("&startup Startup frame %d...",startup_frames)
	while debugprofilestop()-thisframet<self.STARTUP_INTENSITY do
		local t = debugprofilestop()

		if GetFramerate()<40 then ZGV.STARTUP_INTENSITY=5
		elseif GetFramerate()<60 then ZGV.STARTUP_INTENSITY=10
		else ZGV.STARTUP_INTENSITY=20 end

		local good,ret,progress = resume(thread,max(0,self.STARTUP_INTENSITY-debugprofilestop()+thisframet))  -- THIS IS WHERE STARTUP THINGS HAPPEN.

		t = debugprofilestop()-t	startup_ticks = startup_ticks + 1	startup_time=startup_time + t
		self:Debug("&startup &_SUB0 Startup frame %d tick %d |cffeeff88%s|r (%d%%) took |cffffeeaa%d|rms",startup_frames,startup_ticks,tostring(ret),progress or 100,t)

		self.startuptimes[ret]=(self.startuptimes[ret] or 0) + t

		if not good then
			self.loading=nil
			self:Print("ERROR initializing, check the Lua errors and report them, please.")
			error("ERROR in startup frame ".. startup_frames ..": ".. tostring(ret) .."\nin\n".. debugstack(thread))
			ZygorGuidesViewerFrameMaster:SetScript("OnUpdate",nil)
			break
		elseif status(thread)=="dead" then
			self:Debug("&startup COMPLETE!");
			self:Debug("Startup complete in %.2f (%d ticks in %d frames)",startup_time,startup_ticks,startup_frames)
			self:Debug("From file load to variables = %.2f",ZGV.starttime-ZGV.loadtime)
			self:Debug("Total startup (realtime) = %.2f",debugprofilestop()-ZGV.starttime)
			self.startuptimes['_total realtime']=debugprofilestop()-ZGV.starttime
			self.startuptimes['_total pure']=startup_time
			self.startuptimes['_total initial']=ZGV.starttime-ZGV.loadtime
			self.loading=nil
			self.initialized = true
			ZygorGuidesViewerFrameMaster:SetScript("OnUpdate",nil)
			break
		
		elseif ret and type(ret)=="string" and ret:find("waiting") then
			self:Debug("&startup Waiting: %s",ret)
		
			break
		
		elseif ret and ret==1 then
			self.master_forceupdate=true  -- that doesn't do anything anymore...
			self.loading=nil
			break
		else
			-- just happily continue
		end

		if self.db.profile.safe_startup then break end
	end
end

function ZGV:LOADING_SCREEN_DISABLED()
	self:Debug("LOADING_SCREEN_DISABLED! Let's go!")
	self.loading_screen_disabled=true
end

function ZGV:LOADING_SCREEN_ENABLED()
	self:Debug("LOADING_SCREEN_ENABLED! Freeze!")
	self.loading_screen_disabled=false
end

-- my event handling. Multiple handlers allowed, just for the heck of it.

local meta_newtables = {__index = function(tbl, key) tbl[key] = {} return tbl[key] end}
ZGV.Events=setmetatable({},meta_newtables)
function ZGV:AddEventHandler(event,handler)
	tinsert(self.Events[event],handler or true)
	if #self.Events[event]==1 then self:RegisterEvent(event,"EventHandler") end
end

function ZGV:AddMessageHandler(event,handler)
	tinsert(self.Events[event],handler or true)
	if #self.Events[event]==1 then self:RegisterMessage(event,"EventHandler") end
end

function ZGV:RemoveHandler(event,removehandler)
    for num,handler in ipairs(self.Events[event]) do
        if handler == removehandler then
            tremove(self.Events[event],num)
			return
        end
    end
end

function ZGV:EventHandler(event,...)
	for i,hand in ipairs(self.Events[event]) do
		local func
		if type(hand)=="function" then  -- call given function
			hand(self,event,...)
		elseif type(hand)=="string" then  -- call function in self by name
			assert(self[hand],"No function "..hand.." in event handler!")
			self[hand](self,event,...)
		elseif type(hand)=="table" then  -- call method in object, given as {object,"method"}
			assert(hand[1][hand[2]],"No function "..hand[2].." in given object!")
			hand[1][hand[2]](hand[1],event,...)
		elseif hand==true then  -- call self:EVENT_NAME
			assert(type(self[event])=="function","No function "..event.." in event handler!")
			self[event](self,event,...)
		else
			error("What's "..tostring(hand).."? Not a valid message/event handler!")
		end
	end
end

function ZGV:LoadInitialGuide(fastload)
	--if not self.guidesloaded then self:ErrorThrow("Guides failed to load! Cannot load initial guide.") return end
	if self.CurrentGuide then return end

	--if self.db.char["starting"] then
	if ZGV.db.char.maint_startup_startguide then
		if self.db.char.guidename and string.find(self.db.char.guidename,"GOLD\\Crafting\\") then
			if ZGV.Goldguide then
				if ZGV.db.char.goldguide_crafting_guides[1] then
					local chore = ZGV.db.char.goldguide_crafting_guides[1].chore
					setmetatable(chore,{__index=ZGV.Goldguide.Crafting})
					--chore:GetRecipeReagents()
					ZGV.Goldguide.Crafting.GenerateGuide(chore)
				end
			else
				ZGV.Gold.generate_guide()
			end
		else
			ZGV:Debug("Loading initial guide: %s step %d",self.db.char.guidename or "?",self.db.char.step or 0)
			self:SetGuide(self.db.char.guidename,self.db.char.step)
		end

		if not self.CurrentGuide and not fastload then
			if self.db.char.tabguides and next(self.db.char.tabguides) then -- try loading one of existing tabs first
				local _,guidedata = next(self.db.char.tabguides)
				self:SetGuide(guidedata.title,guidedata.step)
			else -- look for starter guide
				self:Print("Finding proper starter section.")
				local gs = self:FindSuggestedGuides()
				if gs['LEVELING'] then gs=gs['LEVELING'] end
				if not gs or #gs==0 then
					self:Print("No guides suggested for your char. Please open guide menu and select the guide you want to use.")
				elseif #gs==1 then
					self:SetGuide(gs[1])
				else --many
					local was_excl
					for gi,guide in ipairs(gs) do
						if guide.condition_suggested_exclusive then
							self:SetGuide(guide)
							was_excl=true
						end
					end
					if not was_excl then
						self:Print("There were "..#gs.." guides suggested. Loading first one.")
						self:SetGuide(gs[1])
					end
				end
				--self.db.char["starting"] = false
			end
		end
	end

	self:QuestTracking_CacheQuestLog("LoadInitialGuide")  -- just in case it didn't get cached before.

	self.frameNeedsResizing = 1
	self:AlignFrame()
	self:UpdateFrame(true)
end

ZGV.GuideTitles = {
	["SUGGESTED"]=L['guidepicker_suggested'],["RECENT"]=L['guidepicker_recent'],["SEARCH"]=L['guidepicker_searchresults'],
	["LEVELING"]=L['guidepicker_leveling'] ,
	["EVENTS"]=L['guidepicker_events'] ,
	["DAILIES"]=L['guidepicker_dalies'] ,
	["LOREMASTER"]=L['guidepicker_loremaster'] ,
	["GOLD"]=L['guidepicker_gold'] ,
	["PROFESSIONS"]=L['guidepicker_professions'] ,
	["PETSMOUNTS"]=L['guidepicker_pets'] ,
	["ACHIEVEMENTS"]=L['guidepicker_achievements'] ,
	["TITLES"]=L['guidepicker_titles'] ,
	["REPUTATIONS"]=L['guidepicker_reps'] ,
	["MACROS"]=L['guidepicker_macros'] ,
	["DUNGEONS"]=L['guidepicker_dungeon'] ,
	["GEAR"]=L['guidepicker_gear'] ,
}
setmetatable(ZGV.GuideTitles,{__index=function(i,v) return v end})

function ZGV:GetGuideByTitle(title)
	if not title then return end
	title = ZGV:SanitizeGuideTitle(title)  -- code-side fix for "common" guides.
	for i,v in ipairs(self.registeredguides) do
		if v.title==title then return v end
	end
end



-- ###########################################################################################################################################################
-- ###########################################################################################################################################################



ZGV.StepHistory = {}

function ZGV.StepHistory:Prune()
	local _gsh = ZGV.db.char.guidestephistory   if not _gsh then return end

	local to_remove={}
	for guide,history in pairs(_gsh) do
		if time()-(history.lasttime or 1548000000) > 86400*180  or  guide:find("SHARED\\")  then -- 6 months old, or it's a shared guide that shouldn't've been recorded here anyway
			tinsert(to_remove,guide)
		end
	end
	for i,guide in ipairs(to_remove) do _gsh[guide]=nil end
end

function ZGV.StepHistory:AddGuide(name)
	local _gsh = ZGV.db.char.guidestephistory
	_gsh[name] = _gsh[name] or {}
	local _gshn=_gsh[name]
	if _gshn[1] then _gsh[name]={['steps']=_gshn} _gshn=_gsh[name] end  -- convert old data
	_gshn.steps = _gshn.steps or {}
	_gshn.lasttime = time()
	return _gshn
end

function ZGV.StepHistory:AddStep(name,num)
	local _gshns = ZGV.db.char.guidestephistory[name].steps
	if _gshns[#_gshns]~=num then
		tinsert(_gshns,num)
	end
end

function ZGV.StepHistory:GetPreviousValidStep(name)
	local step
	local _gshns = ZGV.db.char.guidestephistory[name].steps
	local hlen = #_gshns
	local stepnum
	local backed=0
	local okaytostay
	repeat
		-- pop stepnum from history
		stepnum = _gshns[hlen-backed]

		-- valid number?
		if stepnum then
			-- history popped 'pop'erly, hurr durr

			-- get the step
			s = ZGV.CurrentGuide.steps[stepnum]
			if s then
				backed = backed + 1
				step = s
			end
		else
			-- we broke history or it just ran out, whatever

			ZGV:Debug("step history broken, omg")


			-- TODO: Currently, when running out of history, we default to the first valid of the guide. Needs a message / confirmation.

			s = ZGV.CurrentGuide:GetFirstValidStep()  -- always returns something, or breaks.
			if s then
				backed = hlen  -- rewind it all
				step = s
				okaytostay = true
			end
		end
	until (step:AreRequirementsMet() or ZGV.db.profile.showwrongsteps) and (step~=ZGV.CurrentStep or okaytostay)
	return step,backed
end

function ZGV.StepHistory:Back(name,num)
	local _gshns = ZGV.db.char.guidestephistory[name].steps
	local step
	for i=1,num do step=tremove(_gshns) end
	return step
end

function ZGV.StepHistory:HasHistory(name)
	local _gshns = ZGV.db.char.guidestephistory[name].steps
	return _gshns and #_gshns>0
end



-- ###########################################################################################################################################################
-- ###########################################################################################################################################################



function ZGV:SetGuide(name,step,hack,silent) --hack used for testing
	if not name then return end

	step=step or 1
	--self:Debug("SetGuide "..name.." ("..tostring(step)..")")

	ZGV.db.char.guideTurnInsOnly = false
	--[[ -- tabs say no more auto cleanup
	if ZGV.db.char.forceCleanUp then
		ZGV:ShowQuestCleanup(true) -- true = automated, will not show popup if there are no quests to abandon
		ZGV.db.char.forceCleanUp = false
	end
	--]]

	local guide
	if type(name)=="number" then
		local num = name
		if self.registeredguides[num] then
			guide = self.registeredguides[num]
		else
			self:Print("Cannot find guide number: "..num,nil,"FORCE")
			--return false
		end
	elseif type(name)=="string" then
		name = name :gsub("^Zygor's Alliance ","") :gsub("^Zygor's Horde ","")  -- code-side fix for "common" guides.
		:gsub("^Zygor's ","")

		guide = self:GetGuideByTitle(name)
		if not guide then
			self:Print("Cannot find guide: "..name,nil,"FORCE")
			self:Debug("Cannot find guide: "..name)
			return false
		end
	else
		guide=name  --omg, object
	end

	--if guide.is_stored then guide = self.db.global.storedguides[name] end

	local err

	self:Debug("SetGuide to %s",guide.title)

	if guide then
		local status,msg = guide:GetStatus()
		if hack then 
			status = "INVALID"; 
			--msg = "TESTING" 
		end
		if status=="INVALID" and not ZGV.db.char.goodbadguides[guide.title] then
			if not self.BadGuidePopup then
				self.BadGuidePopup =  ZGV.PopupHandler:NewPopup("ZygorBadPopup","default")

				self.BadGuidePopup.OnAccept = function(self)
					ZGV.db.char.goodbadguides[self.guide.title]=true
					ZGV:SetGuide(self.guide,self.step)
				end

				self.BadGuidePopup.OnDecline = function(self)
					ZGV.GuideMenu:OpenGuide(self.guide)
				end

				self.BadGuidePopup.noMinimize = 1 --Can not minimize this one
			end


			self.BadGuidePopup:SetText(L['static_badguide']:format(guide.title_short,msg or ""))

			self.BadGuidePopup.guide=guide
			self.BadGuidePopup.step=step

			self.BadGuidePopup:Show()
			return "BAD"
		end

		-- unload guides
		if self.CurrentGuide and self.CurrentGuide~=guide then self.CurrentGuide:Unload() end

		guide:Parse(true)

		if guide.steps then
			--self.MapNotes = _G["ZygorGuides_"..faction.."Mapnotes"]
			local name = guide.title

			self.CurrentGuide = guide
			self.CurrentGuideName = name
			self.db.char.guidename = name

			self.StepHistory:Prune()
			self.StepHistory:AddGuide(name)


			-- History support moved to tabs:AssignGuide

			self.CurrentStep = nil
			self.CurrentStepNum = nil

			self.LastSkip = 1

			if guide.headerdata.singlestep then step=guide.headerdata.singlestep end

			local stepobj = guide:GetFirstValidStep(step) -- make sure it's valid
			if stepobj then
				--self:QuestTracking_ResetDailies(true)
				name=name:gsub(self.CurrentGuide.type,ZGV.GuideTitles[self.CurrentGuide.type]) -- make LEVELING-Leveling and such.
				
				 -- don't announce switched world quest guides
				if not silent then self:Print(L["message_loadedguide"]:format(name,step)) end
				self:Debug("Guide loaded: "..name)

				self:SendMessage("ZGV_GUIDE_LOADED",guide.title)

				-- History support moved to tabs:AssignGuide

				self:FocusStep(stepobj.num,true)

				ZGV.Tabs.AddButton:UnlockHighlight()
			else
				err = "No valid steps!"
			end
		else
			err = "Guide not parsed"
		end
	else
		err = L["message_missingguide"]:format(name)
	end

	if err then
		self:Print("Unable to load guide "..guide.title..": "..err)
		self.db.char['guide'] = nil
		self.db.char['step'] = nil
		self.CurrentGuide = nil
		self.CurrentStep = nil
	end

	if self.CurrentGuide and not self.CurrentGuide.headerdata.shared and self.db.profile.share_masterslave==2 then  -- disable slave mode if user picks another guide
		ZGV:SetOption("Share","share_masterslave 0")
		ZGV:Print("Share: slave mode deactivated.")
	elseif self.CurrentGuide.headerdata.shared and self.db.profile.share_masterslave~=2 then 
		self.db.profile.share_masterslave=2 -- reenable slave mode if user tabs back in to shared tab
		ZGV:Print("Share: slave mode reactivated.")
	end

	self.pause = nil
	self.completioninterval = self.completionintervaldefault

	-- Clear info about guide that was set to set to turn-ins-only mode 
	self.db.char.guideTurnInsOnly = false

	self:UpdateFrame(true)

	ZGV.ProgressBar:Update()
	ZGV.Tabs:UpdateCurrentTab()
end

function ZGV:FindSuggestedGuides()
	local suggested={}
	local suggroups={}
	for i,guide in ipairs(self.registeredguides) do
		local status=guide:GetStatus()
		if status=="SUGGESTED" then
			if not suggested[guide.type] then suggested[guide.type]={} end
			tinsert(suggested[guide.type],guide)
		end
		if guide.sugGroup and (status=="VALID" or status=="SUGGESTED") then
			if not suggroups[guide.sugGroup] then suggroups[guide.sugGroup]={} end
			tinsert(suggroups[guide.sugGroup],guide)
		end
	end
	return suggested,suggroups
end

function ZGV:GetGuideFolderInfo(folder)
	local suggest
	for i,guide in ipairs(folder.guides) do
		if guide:GetStatus()=="SUGGESTED" then suggest=true end
	end
	if not suggest then
		for i,group in ipairs(folder.groups) do
			if self:GetGuideFolderInfo(group) then suggest=true end
		end
	end
	return suggest
end

-- function ZGV:SearchForCompleteableGoal() --removed

function ZGV:ClearRecentActivities()
	if not self.recentlyVisitedCoords then --First time, intialize them all as tables
		self.recentlyVisitedCoords = {}
		self.recentlyCompletedGoals = {}
		self.recentlyChangedGoals = {}
		self.recentlyCompletedQuests = {} --only for instant repeatables, which sucks.
		self.recentlyAcceptedQuests = {}
		self.recentlyStickiedGoals = {}
		self.recentGoalProgress = {}
		self.recentCooldownsPulsing = {}
		self.recentCooldownsStarted = {}
		self.recentlyHomeChanged = false
		self.recentlyDiscoveredFlightpath = false
		self.recentlyLearnedRecipes = {}
		self.recentKills = {}
	else --wipe them. Creating them new every time is silly.
		wipe(self.recentlyVisitedCoords)
		wipe(self.recentlyCompletedGoals)
		wipe(self.recentlyChangedGoals)
		wipe(self.recentlyCompletedQuests) --only for instant repeatables, which sucks.
		wipe(self.recentlyAcceptedQuests)
		wipe(self.recentlyStickiedGoals)
		wipe(self.recentGoalProgress)
		wipe(self.recentCooldownsPulsing)
		wipe(self.recentCooldownsStarted)
		self.recentlyHomeChanged = false
		self.recentlyDiscoveredFlightpath = false
		wipe(self.recentlyLearnedRecipes)
		wipe(self.recentKills)
		-- self.completedQuestTitles = {} -- let's not use this anymore, with GetQuestID available
	end
	self.step_share_onceflag = nil
end

function ZGV:FocusStep(num,forcefocus)
	if type(num)=="string" and self.CurrentGuide.steplabels then local s=num  num=self.CurrentGuide.steplabels[num]  if num then num=num[1] end  self:Debug("FocusStep: "..s.." = "..tostring(num))  end
	if type(num)=="table" then num=num.num end
	if not num or num<=0 then return end
	if not self.CurrentGuide then return end
	if not self.CurrentGuide.steps then return end
	if num>#self.CurrentGuide.steps then return end
	if self.CurrentGuide.headerdata.singlestep then num=self.CurrentGuide.headerdata.singlestep end

	--[[ CreatureViewer removal, 7.0
	ZGV.CreatureViewer.models={}
	ZGV.CreatureViewer.Frame:Hide()
	--]]

	self:Debug("FocusStep "..num..(quiet and " (quiet)" or ""))

	if self.CurrentGuide.type ~= "SHARED" then  -- don't store history for those, it just doesn't work
		-- Record step into history
		if self.LastSkip>0 and self.CurrentStep then
			self.StepHistory:AddStep(self.CurrentGuide.title,self.CurrentStep.num)
			if self.db.char.guides_history[1] and self.db.char.guides_history[1][1]==self.CurrentGuide.title then
				self.db.char.guides_history[1][2]=self.CurrentStep.num
			end
		end
	end

	local prevFocus = (self.CurrentStep and self.CurrentStep.isFocused) or (not self.CurrentStep and true)

	self.CurrentStepNum = num
	self.db.char.step = num
	self.CurrentStep = self.CurrentGuide.steps[num]
	self.CurrentGuide.CurrentStepNum = num

	if prevFocus or forcefocus then ZGV:SetStepFocus(self.CurrentStep) end

	self:ClearRecentActivities()

	-- Whoa whoa. The step might load a different guide at this point! Play safe.
	local cs=self.CurrentStep
	local cg=self.CurrentGuide
	self.CurrentStep:PrepareCompletion(true)
	self.CurrentStep:OnEnter()

	if (cs~=self.CurrentStep) or (cg~=self.CurrentGuide) then self:Debug("FocusStep: guide or step changed! bailing.") return end

	self.stepchanged = true

	for i,goal in ipairs(self.CurrentStep.goals) do
		if goal:IsComplete() then
			self.recentlyCompletedGoals[goal]=true
			goal:SaveStickyComplete()
		end
	end

	local stepcomplete,steppossible = self.CurrentStep:IsComplete()
	if self.pause then
		if (self.db.profile.skipimpossible and not steppossible)
		--or (self.db.profile.skipobsolete and self.CurrentStep:IsObsolete())
		or (self.db.profile.skipauxsteps and self.CurrentStep:IsAuxiliarySkippable())
		then
			stepcomplete=true
			--self.pause=nil

			-- InventoryManager.lua
			if ZGV.db.profile.load_im and ZGV.IM then
				ZGV.IM:BagFullCheck()
			end
		end
		self.LastSkip=1
		if not stepcomplete then
			self:Debug("unpausing")
			self.pause=nil
		end
	end
	--and self.LastSkip~=0) then self.AutoskipTemp=false else self.AutoskipTemp=true end


	-- add to last-guides history 
	--[[ Why? We do that it setguide, and we have set curret step already at the beggining of FocusStep
 	if not self.db.char.guides_history_ZGV45clear then self.db.char.guides_history={} self.db.char.guides_history_ZGV45clear=true end
	local history = self.db.char.guides_history
	local found
	for gi,guidestep in ipairs(history) do
		if guidestep[1]==self.CurrentGuide.title then guidestep[2]=self.CurrentStepNum found=1 break end
	end

	if not found then
		tinsert(history,{self.CurrentGuide.title,self.CurrentStepNum})
	end
	if #history>20 then tremove(history,1) end
	--]]

	-- TRACK QUESTS
	if ZGV.db.profile.autotrackquests then
		for gi,goal in ipairs(cs.goals) do
			if goal.questid then self:TrackQuest(goal.questid) break end
		end
	end


	-- SANITIZE MAPS. In case there's zoning involved.
	if cs.map then cs.map=self.Pointer:SanitizePhase(cs.map) end
	for gi,goal in ipairs(cs.goals) do
		if goal.map then goal.map=self.Pointer:SanitizePhase(goal.map) end
	end


	-- pre-fetch the next step's translation, this seems like a good place to do it
	local nextstep,stepnum,guide=self.CurrentStep:GetNextStep()
	if nextstep then nextstep:Translate() end


	self:SendMessage("ZGV_STEP_CHANGED",num)

	if not quiet then
		self:FocusStepUnquiet()
	end

	--self:TryToDisplayCreature()
	--self:UpdateMinimapArrow(true)

	--Hide goal image popup if it exists
	if ZGV.GoalPopupImageFrame then
		ZGV.GoalPopupImageFrame:Hide()
	end

	--Maybe show map preview
	if ZGV.db.profile.preview and (not GetPlayerFacing() or ZGV.db.char.fakeinstance) and ZGV.db.profile.preview_control=="step" then
		ZGV.PointerMap:ShowPreview()
	end

	if ZGV.Gold.Appraiser and ZGV.Gold.Appraiser.Loaded and ZGV.Gold.Appraiser.AddGuideItemsToBuy then
		ZGV.Gold.Appraiser:AddGuideItemsToBuy()
	end

	ZGV:SetActionButtons()
	ZGV.Tabs:UpdateCurrentTab()

	-- if user changed guide/step, he may need to equip/dequip quest gear
	if not self.skipping then
		ZGV.ItemScore.Upgrades:ScanBagsForUpgrades()
	end

	ZGV.QuestDB:MaybeShowButton()
end

function ZGV:SetActionButtons()
	if not ZGV.db.profile.enable_actionbuttons then return end -- disabled
	if not ZGV.ActionBar or not ZGV.ActionBar.Frame then return end -- we are too early
	if not ZGV.CurrentStep then return end -- we will retry on step focus
	if InCombatLockdown() then return end -- we will retry on PLAYER_REGEN_ENABLED

	ZGV.ActionBar:ClearBar()

	-- current step
	for gi,goal in ipairs(ZGV.CurrentStep.goals) do
		if goal:IsVisible() then
			if goal.castspell and goal.castspellid then
				ZGV.ActionBar:SetButton("spell",goal.castspellid)
			elseif goal.item or goal.itemid then
				ZGV.ActionBar:SetButton("item",goal.itemid  or  goal.item)
			--elseif goal.macro then
			--	ZGV.ActionBar:SetButton("macro",goal.macro)
			elseif goal.script and goal.script:find("DoEmote") then
				ZGV.ActionBar:SetButton("emote",goal.macro)
			elseif goal.petaction then
				local num,name,subtext,tex = ZGV.FindPetActionInfo(goal.petaction)
				if num then
					ZGV.ActionBar:SetButton("petaction",num)
				end
			end
		end -- if goal visible
	end -- for goal in step

	-- stickies
	for si,step in ipairs(ZGV:GetStickiesAt(ZGV.CurrentStep.num)) do
		if not step:IsComplete() then
			for gi,goal in ipairs(step.goals) do
				if goal:IsVisible() then
					if goal.castspell and goal.castspellid then
						ZGV.ActionBar:SetButton("spell",goal.castspellid)
					elseif goal.item or goal.itemid then
						ZGV.ActionBar:SetButton("item",goal.itemid  or  goal.item)
					--elseif goal.macro then
					--	ZGV.ActionBar:SetButton("macro",goal.macro)
					elseif goal.script and goal.script:find("DoEmote") then
						ZGV.ActionBar:SetButton("emote",goal.script)
					elseif goal.petaction then
						local num,name,subtext,tex = ZGV.FindPetActionInfo(goal.petaction)
						if num then
							ZGV.ActionBar:SetButton("petaction",num)
						end
					end
				end -- if goal visible
			end -- for goal in step
		end -- if step visible
	end -- for step in stickies
end

function ZGV:FocusStepQuiet(num)
	return self:FocusStep(num,true)
end

function ZGV:FocusStepUnquiet()
	self:StopFlashAnimation()
	self.frameNeedsResizing = self.frameNeedsResizing + 1
	self:UpdateFrame(true)
	self:ScrollToCurrentStep()
	self:UpdateCooldowns()

	--self:UpdateCartographerExport()  -- moved to Waypoints where it belongs.
	
	self:GetFocusedStep():ResetCurrentWaypoint()
	self:ShowWaypoints()

	--[[
	-- Stickies don't get waypoints now, as of 2015-06-18.
	local stickies = self:GetStickiesAt(nil)
	for _,sticky in ipairs(stickies) do
		if not sticky:IsComplete() or self.CurrentStep:IsComplete() then self:ShowWaypoints("sticky",sticky) end
	end
	--]]
end

function ZGV:TrackQuest(id)
	local q = ZGV.questsbyid[id]
	if not q or not q.inlog then return end
	if not IsQuestWatched(q.index) then
		AddQuestWatch(q.index)
		--WatchFrame_Update(self)
	end
	SetSuperTrackedQuestID(q.id)
end

function ZGV:PointToQuest(map,id)
	local _,x,y,obj = QuestPOIGetIconInfo(id)
	if x and y then
		self.Pointer:SetWaypoint(map,x,y)
	end
end

-- return step = step obj
-- return backed = num of valid history skips
function ZGV:GetPreviousValidStep()
	return self.StepHistory:GetPreviousValidStep(self.db.char.guidename)
end

function ZGV:PreviousStep(fast,forcefocus)
	if not self.CurrentGuide then return end

	if self.completionstreak==0 then ZGV.completioninterval=ZGV.completionintervallong end  -- first skip

	-- reset completion timers
	lastcompletion=GetTime()
	self.completionelapsed=0

	self.LastSkip = -1
	self.lastskip_rec = -1

	self.autopause = IsAltKeyDown() and IsControlKeyDown()

	local guidename = self.db.char.guidename

	local step,backed = self:GetPreviousValidStep(guidename)
	if self.autopause then step=self.CurrentGuide.steps[self.CurrentStepNum-1] end  -- HACK.
	if not step then return end

	self:Debug("PreviousStep to "..step.num..(fast and ' (fast)' or ''))

	-- drop 'backed' history states
	self.StepHistory:Back(guidename,backed)

	if not self.StepHistory:HasHistory(guidename) then
		self.fastforward = false
		self.skipping = false
		self.pause = true
	else
		self.fastforward = fast
		self.skipping = fast
		self.pause = not fast
	end

	if self.autopause then self.pause=true self.fastforward=false end

	self:FocusStep(step,forcefocus)

	ZGV.ProgressBar:Update()
end

function ZGV:SkipStep(fast,hack,forcefocus) --Hack used for testing, forces showing endguide popup
	if not self.CurrentGuide then return end

	if self.completionstreak then ZGV.completioninterval=ZGV.completionintervallong end  -- first skip

	-- reset completion timers
	lastcompletion=GetTime()
	self.completionelapsed=0

	self.LastSkip = 1
	self.lastskip_rec = 1
	self.fastforward = fast
	self.skipping = fast

	local nextstep

	self.autopause = IsAltKeyDown() and IsControlKeyDown()

	if self.autopause then  -- forced next+1 step
		nextstep=self.CurrentGuide.steps[self.CurrentStepNum+1]
		self.CurrentStep.needsreload=nil
	end  -- HACK.

	if self.CurrentStep.needsreload then return self:ReloadStep(fast) end

	if not nextstep and not hack then  -- when not forced, that is: usually.
		local nextstep2,stepnum,guide

		if fast and self.db.profile.instantskip then nextstep2,stepnum,guide=self.CurrentStep:GetNextCompletableStep() self:Debug("Next completable step is: %d",stepnum)
		else nextstep2,stepnum,guide=self.CurrentStep:GetNextValidStep() self:Debug("Next valid step is: %d",stepnum) end  -- always returns a step, unless we're at the end.

		if guide then
			--print("ABOUT TO JUMP GUIDES to:",guide,stepnum)
			self:SetGuide(guide,stepnum)
			return
		end
		nextstep=nextstep2
	end

	self:Debug("SkipStep to ".. (nextstep and nextstep.num or "?") ..(fast and ' (fast)' or ''))

	if (not nextstep or hack) and (not self.CurrentGuide.headerdata.poiloader) --[[or (self.CurrentStep and (self.CurrentStep.num == #self.CurrentGuide.steps))--]] then
		-- final step
		self.pause = true
		self.fastforward = false
		self.skipping = false
		if self.CurrentGuide.next and ZGV.db.profile.n_popup_guides and not hack then
			local nextguide = ZGV:GetGuideByTitle(ZGV.CurrentGuide.next)
			if nextguide then
				nextguide:AdvertiseWithPopup()
			end
		elseif not self.CurrentGuide.headerdata.singlestep then
			if not self.EndGuidePopup then
				self.EndGuidePopup = ZGV.PopupHandler:NewPopup("ZygorEndPopup","default")
				
				self.EndGuidePopup.declinebutton:Hide()
				ZGV.ChainCall(self.EndGuidePopup.acceptbutton)
					:ClearAllPoints()
					:SetPoint("BOTTOM",self.EndGuidePopup,"BOTTOM",0,5)

				self.EndGuidePopup.noMinimize = 1 --Can not minimize this one
			end

			self.EndGuidePopup:SetText(L['dialog_endguide'])
			self.EndGuidePopup:Show("unique")
		end
		return
	end

	self.pause = not fast
	if self.autopause then self.pause=true end

	self:FocusStep(nextstep,forcefocus) -- simple enough

	--[[
	else
		-- last step! or something went wrong and GetNextValidStep couldn't find anything to hop onto.

		--if self.CurrentStep.num == #self.CurrentGuide.steps then  -- never mind! assuming loss of next step = end of guide. Wondering if this is safe... ~sinus 2011-08-16
			self.pause = true
			self.fastforward = false
			if self.CurrentGuide.next then
				if not self.NextGuidePopup then
					self.NextGuidePopup = ZGV.PopupHandler:NewPopup("ZygorNextPopup","default")

					self.NextGuidePopup.noMinimize = 1 --Can not minimize this one
				end

				if self.NextGuidePopup.nextguide ~= self.CurrentGuide.next then
					self.NextGuidePopup.nextguide=self.CurrentGuide.next
					self.NextGuidePopup.OnAccept = function(self)
						ZGV:SetGuide(ZGV.NextGuidePopup.nextguide)
					end

					self.NextGuidePopup:SetText(L['dialog_nextguide']:format(self:GetShortGuideTitle(self.CurrentGuide.next)))
					self.NextGuidePopup:Show()
					self.NextGuidePopup.declinebutton:Show()
					self.NextGuidePopup.acceptbutton:Show()
					return
				end

				--self:SetGuide(self.CurrentGuide.next,1)
				--return
			elseif self.CurrentGuide.steps and #self.CurrentGuide.steps>1 then
				if not self.EndGuidePopup then
					self.EndGuidePopup = ZGV.PopupHandler:NewPopup("ZygorEndPopup","default")
					
					self.EndGuidePopup.declinebutton:Hide()
					ZGV.ChainCall(self.EndGuidePopup.acceptbutton)
						:ClearAllPoints()
						:SetPoint("BOTTOM",self.EndGuidePopup,"BOTTOM",0,5)

					self.EndGuidePopup.noMinimize = 1 --Can not minimize this one
				end

				self.EndGuidePopup:SetText(L['dialog_endguide'])
				self.EndGuidePopup:Show()
				return
			end
		--else
		--	error("Missed the end of the guide..?")
		--end
	end
	--]]

	ZGV.ProgressBar:Update()
end

function ZGV:ReloadStep(fast)
	self.LastSkip=1
	self.pause = not fast
	self.fastforward = fast
	self.skipping = fast
	self.CurrentStep.needsreload = nil
	self:FocusStep(self.CurrentStepNum)
end

--- A quest is 'interesting' if any follow-ups to it appear anywhere in the guides and they're not gray.
-- As of 3.1, no follow-ups are tracked.

--[[
local followupcache={}
function ZGV:GetMentionedFollowups(questid)
	if followupcache[questid] then return followupcache[questid] end
	local q,f
	local live = {questid}
	local fups = {}
	local lev
	--self:Debug("Caching mentioned followups of "..questid)
	local cycles=0
	while #live>0 do
		cycles=cycles+1
		assert(cycles<1000,"Quest "..questid.." has infinitely resolving live followups: "..table.concat(live,","))

		q = tremove(live,1)
		lev = self.mentionedQuests[q]
		if lev then tinsert(fups,{q,lev}) end

		f = self.RevChains[q]
		if f then
			for i=1,#f do
				-- make sure there are no circular references
				if f[i]==questid then break end
				local found
				-- don't add stuff that's already in the live group
				for l=1,#live do if live[l]==f[i] or live[l]==questid then found=true break end end
				-- and don't add stuff that's already in followups
				if not found then for l=1,#fups do if fups[l][1]==f[i] then found=true break end end end
				if found then break end
				tinsert(live,f[i])

				--error("Circular quest reference: "..q.." requires "..f[i]..", already required by "..questid)  -- screw it, they MAY require old quests, just not in circles. Fix circles quietly.
			end
		end
		assert(#live<1000,"Quest "..questid.." has live followups > 1000: "..table.concat(live,","))
	end
	followupcache[questid]=fups
	return fups
end

-- A quest's "maximum chained level" can be safely cached, I guess.
-- MAY YIELD.
function ZGV:CacheMentionedFollowups()
	local f,maxlev
	self.maxQuestLevels = {}
	local count=0
	for qid,lev in pairs(self.mentionedQuests) do
		--self.loadprogress=count/30000
		count=count+1
		if count>100 then count=0 yield() end
		f=ZGV:GetMentionedFollowups(qid)
		for i=1,#f do
			if f[i][2]>lev then lev=f[i][2] end
		end
		self.maxQuestLevels[qid]=lev
	end
end
--]]

--- Attempt to complete current step.
-- 09-09-24:
local lastnextsuggested
local goalsneedanimating={}
function ZGV:TryToCompleteStep(force)
	-- initial bail-out checks
		if not self.loading_screen_disabled then return end
		if not self.CurrentStep or not self.CurrentGuide then return end

		if self.BUTTONS_INLINE then
			if self.actionsvisible and InCombatLockdown() then return end
		end

		-- frame hidden? bail.
		if not self.Frame:IsVisible() or self.Frame:GetAlpha()<0.1 then return end
	--

	-- out-of-schedule check
		self.CurrentStep:CheckVisitedGotos()
	--

	--== prevent overtime checks. Only proceed with the completion once every self.completioninterval (which varies from self.completionintervallong to self.completionintervalmin).
		local t=GetTime()
		local elapsed=t-lastcompletion
		lastcompletion=t
		self.completionelapsed=self.completionelapsed+elapsed

		local interval=self.completioninterval
		if self.completionelapsed<interval and not force then  -- Too fast. Abort completion checks and, obviously, the subsequent skipping, too.
			return
		end
		self.completionelapsed = 0
	--

	local stepcomplete,steppossible = self.CurrentStep:IsComplete()

	local completing = stepcomplete


	-- smart skipping: treat invalid or impossible or skippable as completed
	if (not self.CurrentStep:AreRequirementsMet()
	or (self.db.profile.skipimpossible and not steppossible))
	and self.fastforward -- but only skip invalids/impossibles if we're already skipping forward!
	--or (self.db.profile.skipobsolete and self.CurrentStep:IsObsolete())
	--or (self.db.profile.skipauxsteps and self.CurrentStep:IsAuxiliarySkippable())
	then
		completing=true
		--self.pause=nil
	end

	if completing and self.Sync and self.Sync:IsEnabled() then
		if self.Sync:IsClearToProceed(self.CurrentStepNum) then -- check synced party members. Who is on the same step, but has it incomplete?
			ZGV.Sync:Debug("Party members completed the step, moving on.")
		else
			ZGV.Sync:Debug("Waiting for party members to complete step.")
			completing = false
		end
	end

	if not completing then
		interval = self.completionintervaldefault
		self.pause=nil
	end

	local confirmcompleted = false
	local confirmfound = false
	wipe(goalsneedanimating)
	local step = self.CurrentStep
	for i,goal in ipairs(step.goals) do  if goal:IsCompleteable() then
		local iscomplete,ispossible,done,needed = goal:IsComplete()
		if iscomplete and not self.recentlyCompletedGoals[goal] then
			self.recentlyCompletedGoals[goal] = true
			goalsneedanimating[goal] = true
			goal:OnCompleted()
			self:SendMessage("ZGV_GOAL_COMPLETED",step.num,i)
			self:Debug("Goal completed: step %d goal %d",step.num,i)
		elseif not iscomplete and self.recentlyCompletedGoals[goal] then
			self.recentlyCompletedGoals[goal] = false
			goalsneedanimating[goal] = nil
			goal:OnUncompleted()
			self:SendMessage("ZGV_GOAL_UNCOMPLETED",step.num,i)
			self:Debug("Goal uncompleted: step %d goal %d",step.num,i)
		end

		if self.recentGoalProgress[goal]==nil then self.recentGoalProgress[goal]=done end
		if self.recentGoalProgress[goal]~=done and (goal.action~="goto" or (self.recentGoalProgress[goal]==1 ~= done==1)) then  -- announce and animate anything BUT a goto.
			goal.dirtytext=true
			goalsneedanimating[goal]=true
			self:SendMessage("ZGV_GOAL_PROGRESS",step.num,i)
			self:Debug("Goal progress: step %d goal %d progress %d->%d",step.num,i,self.recentGoalProgress[goal] or -1,done or -1)
		end
		self.recentGoalProgress[goal] = done

		if goal.action == "confirm" and goal.always then
			confirmfound = true
			if goal.status == "complete" then confirmcompleted = true end
		end
	end end
	if confirmfound and confirmcompleted ~= true then completing = false end

	if self.pause or self.db.profile.dontprogress then
		interval = self.completionintervaldefault
		self.LastSkip = 1
		self.completionstreak=0
	else
		if completing then
			--self.recentlyCompletedQuests = {} -- forget it! We're skipping the step, already.
			self:Debug("Skipping step: "..self.CurrentStepNum.." ("..(stepcomplete and "complete" or (steppossible and "possible?" or "impossible"))..")")
			local s=""
			for gn,goal in ipairs(self.CurrentStep.goals) do s=s..goal:GetDebugDump().."\n" end
			self:Debug("Skipped goals were:\n%s",s)

			if self.lasttriedstep and self.lasttriedstep==self.CurrentStep and not self.lastwascompleted then
				--newly completed!
				PlaySound(self.db.profile.completesound)
				if self.db.profile.flashborder then
					self.delayFlash=1
				end
			end

			-- do, do, do the SKIP!
			if self.LastSkip<0 then 
				self:PreviousStep(true) 
			else 
				if not ZGV.QuestDB:MaybeStopOnThisStep() then -- unless not
					self:SkipStep(true) 
				end
			end
			if not self.fastforward then interval=self.completionintervallong end -- first skip, set speed to slow and begin speeding up.

			self.fastforward=true

			interval = interval * self.completionintervalspeed
			if interval<self.completionintervalmin then interval=self.completionintervalmin end
			self.completionstreak=self.completionstreak+1
			--skipped=skipped+1
			--if skipped>100 then break end

			--self:UpdateFrame()
			--updated=true

			--self.completioninterval = self.completionshortinterval


			--ZygorGuidesViewerFrame_CoverFlash_blink:Play()

			--stepcomplete = self.CurrentStep:IsComplete()
		else
			interval = self.completionintervaldefault
			self.pause=nil
			self.fastforward=nil
			self.skipping = false
			self.LastSkip = 1
			self.completionstreak = 0
			--self.completioninterval = self.completionlonginterval
		end

		--[[
		if updated and not self.db.profile.showallsteps then
			self.stepframes[1].slideup:Play()
		end
		--]]

		--if not stepcomplete then self.AutoskipTemp=true end

		--if not updated then self:UpdateFrame() end
	end

	-- self:MaybeSuggestNextGuide()  -- Patch 7.3.5: don't suggest next levels. Players progress to the end of the guide, always. It doesn't make much sense to skip. TODO: detect when they've actually outleveled the current zone!
	self:UpdateFrame()

	self.lasttriedstep = self.CurrentStep
	self.lastwascompleted = stepcomplete

	self.completioninterval = interval
end

function ZGV:MaybeSuggestNextGuide()
	--if self.CurrentGuide.title:find("Pandaria 85") then return end  -- don't suggest when in there. simple. -- 6/25/2013 We can suggest Pandaria again.
	-- And now check if the next guide is up for suggesting.
	-- However, don't bother suggesting others when we're exclusive and still suggested.
	-- Also, do not show the suggest if we are on last step of the guide, we will soon switch anyway and we avoid issues with popup queue
	if self.CurrentGuide.condition_suggested_exclusive then return end
	if self.CurrentStepNum == #self.CurrentGuide.steps then return end  -- proceed normally

	-- ELSE...
	local nextguidetitle = self.CurrentGuide.next
	if not nextguidetitle or ZGV.db.char.ignoredguides[nextguidetitle] or (ZGV.tempguideblock and ZGV.tempguideblock[nextguidetitle]) then return end  -- boo.

	local nextguide = self:GetGuideByTitle(nextguidetitle)
	if nextguide then
		local nextsuggested = (nextguide:GetStatus()=="SUGGESTED")
		ZGV.suggesting = nextsuggested
		if not lastnextsuggested and nextsuggested and self.db.profile.n_popup_guides then -- plain guide popup block is in AWP
			nextguide:AdvertiseWithPopup()
		end
		lastnextsuggested = nextsuggested
	end
end

function ZGV:InitializeDropDown(frame)
	if not self.guidesloaded then return end

	local guides = ZygorGuidesViewer.registeredguides

	if not guides then return end

	for i,guide in ipairs(guides) do

--		ChatFrame1:AddMessage(section)
		local info = {}
		info.text = guide.title
		info.value = guide.title
		info.func = ZGVFSectionDropDown_Func
		if (self.CurrentGuideName == guide.title) then
			info.checked = 1
		else
			info.checked = nil
		end
		info.button = 1
--		if (i == 1) then
--			info.isTitle = 1
--		end
		UIDropDownFork_AddButton(info)
	end
	UIDropDownFork_SetText(frame, self.CurrentGuideName)
end


function ZGV:UpdateLocking()
	self.Frame:UpdateLocking()
end

function ZGV:StopFlashAnimation()
	if not self.stepframes[20] or not self.stepframes[20].lines[20] then return end
	for s=1,20 do
		for l=1,LINES_PER_STEP do
			local anim_w2g = self.stepframes[s].lines[l].anim_w2g
			if not anim_w2g then break end
			anim_w2g:Stop()
		end
	end
end

--[[
function ZGV:HideCooldown(arg)
	arg.cooldown:Hide()
	self.recentCooldownsPulsing[goal] = 2
end
--]]

function ZGV:UpdateCooldowns()
	--self:Debug("UpdateCooldowns")
	if not self.CurrentStep then return end
	local stepframe = self.stepframes[self.CurrentStepframeNum]
	if not stepframe then return end
	for j=1,#self.stepframes do
		for i=1,LINES_PER_STEP do if self.actionbuttons[j] and self.actionbuttons[j][i] then
			local cooldown = self.actionbuttons[j][i].cd
			if not cooldown then return end
			local goal = stepframe.lines[i].goal
			if goal and goal:IsActionable() then
				--cooldown:Show()
				--self:Debug("goal "..i.." actionable")
				if goal.castspell or goal.castspellid then
					local start,dur,en = GetSpellCooldown(goal.castspellid or goal.castspell)
					CooldownFrame_Set(cooldown, start, dur, en)
					if start>0 then cooldown:Show() else cooldown:Hide() end
					--self:Debug(("spell: %d,%d,%d"):format(start,dur,en))
				elseif goal.itemid then
					local start,dur,en = GetItemCooldown(goal.itemid)
					CooldownFrame_Set(cooldown, start, dur, en)
					if start>0 then cooldown:Show() else cooldown:Hide() end
					--self:Debug(("item: %d,%d,%d"):format(start,dur,en))
				elseif goal.petaction then
					local num,name,x,tex
					if type(goal.petaction)=="number" then
						num = goal.petaction
					else
						num,name,x,tex = ZGV.FindPetActionInfo(goal.petaction)
					end
					local start,dur,en = GetPetActionCooldown(num)
					CooldownFrame_Set(cooldown, start, dur, en)
					if start>0 then cooldown:Show() else cooldown:Hide() end
				end
			else
				cooldown:Hide()
			end
		end end
	end
end

local function gradient(a,b,p)
	return a+(b-a)*p
end

local function fromRGBA(ob)
	return ob.r,ob.g,ob.b,ob.a
end

local function fromRGB_a(ob,a)
	return ob.r,ob.g,ob.b,a
end

local function fromRGBmul_a(ob,mul,a)
	return ob.r*mul,ob.g*mul,ob.b*mul,a
end

local function fromRGB(ob)
	return ob.r,ob.g,ob.b
end

--local function gradientRGBA(f,t,p)  --removed

function ZGV:SetDisplayMode(mode)
	self.db.profile.displaymode=mode
	self:UpdateFrame(true)
end

local getstickies_temp={}
function ZGV:GetStickiesAt(stepnum,only_incomplete)
	stepnum = stepnum or self.CurrentStepNum
	local step = self.CurrentGuide.steps[stepnum]
	wipe(getstickies_temp)
	if step.stickies then
		for _,stickystep in ipairs(step.stickies) do
			if not only_incomplete or not stickystep:IsComplete() then
				tinsert(getstickies_temp,stickystep)
			end
		end
	end
	return getstickies_temp
end

local Tpi=6.2832
local cardinals = {"N","NW","W","SW","S","SE","E","NE","N"}
local function GetCardinalDirName(angle)
	for i=1,9 do
		if Tpi*((i*2)-1)/16>angle then return cardinals[i] end
	end
end
local function GetCardinalDirNum(angle)
	while angle<0 do angle=angle+Tpi end
	while angle>Tpi do angle=angle-Tpi end
	local ret=1
	for i=1,16 do
		if Tpi*((i*2)-1)/32>angle then ret=i break end
	end
	return ret
end

local itemsources={"vendor","drop","ore","herb","skin"}

local gold_ox,gold_oy=0,0

local actionicon={
	["accept"]=5,
	["turnin"]=6,
	["kill"]=7,
	["from"]=7,
	["get"]=8,
	["collect"]=8,
	["goldcollect"]=8,
	["goldtracker"]=8,
	["buy"]=8,
	["goal"]=9,
	["home"]=10,
	["fpath"]=11,
	["goto"]=12,
	["talk"]=13,
	["next"]=14,
	["poi_treasure"]=15,
	["poi_rare"]=16,
	["poi_questobjective"]=8,
	["poiannounce"]=0,
	["poiaccess"]=0,
	["poicurrency"]=0,
	["image"]=9,
}
setmetatable(actionicon,{__index=function() return 2 end})

local poi_actions = {poi_treasure=1, poi_rare=1, poi_questobjective=1, poiannounce=1, poiaccess=1, poicurrency=1}

local goals_temp = {}

local function mix(a,b,perc)
	if not a then return end
	return a+(b-a)*perc
end
local function mix4(a,b,c,d,u,v,w,x)
	return mix(a,u,x),mix(b,v,x),mix(c,w,x),mix(d,1,x)
end
ZGV.mix4 = mix4

function ZGV:UpdateFrameAddStep(step,mode)
	if ZGV.framenum>ZGV.StepLimit then return end

	step:PrepareCompletion()

	if (mode == "sticky") then
		local iscomplete, ispossible = step:IsComplete()
		if iscomplete then return end  -- refuse to add completed stickies
	end
	if not step:AreRequirementsMet() and not self.db.profile.showwrongsteps then return end  -- refuse to add wrong steps

	self.stepframes[ZGV.framenum].step = step
	self.stepframes[ZGV.framenum].stepnum = step.num
	self.stepframes[ZGV.framenum].is_sticky = (mode == "sticky")
	ZGV.framenum=ZGV.framenum+1
end


function ZGV:UpdateFrame(full,onupdate)
	do return self:DoUpdateFrame(full,onupdate) end  -- bandaid bypass
	self.updateframe_dirty=true
	self.updateframe_dirty_full=full
	self.updateframe_dirty_onupdate=onupdate
	if not self.updateframetimer then self.updateframetimer = self:ScheduleRepeatingTimer("UpdateFrame_Schedule", 0.01) end
end

function ZGV:UpdateFrame_Schedule() -- called each frame
	if self.updateframe_dirty then
		self:DoUpdateFrame(self.updateframe_dirty_full,self.updateframe_dirty_onupdate)
		self.updateframe_dirty=false
		self.updateframe_dirty_full=nil
		self.updateframe_dirty_onupdate=nil
	end
end

function ZGV:DoUpdateFrame(full,onupdate)
	if full then self.stepchanged=true end

	if not self.Frame or not self.Frame:IsVisible() then return end

	ZGV.Licence:CheckExpirationWarning()

	--if InCombatLockdown() then return end
	--[[
	--		self.Frame:SetAlpha(0.5)
		return
	else
	--		self.Frame:SetAlpha(1.0)
	end
	--]]

	--self:Debug("updatemini")

	--if ZygorGuidesViewerMiniFrame_bdflash:IsPlaying() and not ZygorGuidesViewerMiniFrame_bdflash:IsDone() then return end

	self.db.profile.displaymode="guide"

	local focusedstep = ZGV:GetFocusedStep()

	local minh = 0

	local Scroll = ZygorGuidesViewerFrame_Scroll

	local tabh = ZygorGuidesViewerFrame_Border_TabBack:GetHeight()

	local do_showwaypoints

	--if self.loading then ZygorGuidesViewerFrame_Border_GuideBack_SectionTitle:SetText(self.loading:format((self.loadprogress or 0)*100)) end

	local showbriefsteps = self.db.profile.showbriefsteps-- and self.db.profile.minimode

	self.Frame.Border.Guides:Show()
	--self.Frame.Border.Gold:Hide() - bfa alpha change unused frame

	if self.CurrentGuide and self.CurrentGuide.steps and self.CurrentGuide.fully_parsed then

		-- hide spot frames, if visible
		if self.spotframes[1] and self.spotframes[1]:IsVisible() then for i,spotframe in ipairs(self.spotframes) do spotframe:Hide() end end

		local showallsteps = (self.db.profile.showcountsteps==0)
		if showallsteps then
			if ZygorGuidesViewerFrame_ScrollScrollBar:GetValue()<1 then ZygorGuidesViewerFrame_ScrollScrollBar:SetValue(self.CurrentStepNum) end
			ZygorGuidesViewerFrame_ScrollScrollBar:Show()
		else
			ZygorGuidesViewerFrame_ScrollScrollBar:Hide()
		end

		--if full then
			ZygorGuidesViewerFrame_ScrollScrollBar:SetMinMaxValues(1,#self.CurrentGuide.steps>0 and #self.CurrentGuide.steps or 1)
			ZygorGuidesViewerFrame_Border_Guides_StepNum.Step:SetText(self.CurrentStepNum)
			--ZygorGuidesViewerFrame_Border_GuideBack_SectionTitle:SetText(self.CurrentGuide.title_short)
		--end

		Scroll:Show()

		local totalheight = 0

		local stepnum,stepdata

		local firststep = (showallsteps and math.floor(ZygorGuidesViewerFrame_ScrollScrollBar:GetValue()) or self.CurrentStepNum) or 1
		firststep=max(1,firststep)
		local laststep = showallsteps and #self.CurrentGuide.steps or self.CurrentStepNum+self.db.profile.showcountsteps-1
		laststep=min(laststep,#self.CurrentGuide.steps)

		--self:Debug("first step "..firststep..", last step "..laststep)
		-- run through buttons and assign steps for them

		local nomoredisplayed=false

		local icon_indent = self.db.profile.goalicons and ICON_INDENT or 0

		
		local stickies
		if self.db.profile.stickyon and (self.db.profile.stickydisplay==3 or self.db.profile.stickydisplay==4) and not showallsteps then
			stickies = self:GetStickiesAt(firststep)
		end
		ZGV.CurrentStickies = stickies

		-- FIRST, assign steps to frames.
			
			-- automate adding steps to stepframes. Refuse to add completed stickies, or wrong steps.
				ZGV.framenum=1

			-- "First" step goes, well, first.
				ZGV:UpdateFrameAddStep(self.CurrentGuide.steps[firststep])
			
			-- Now the stickies that accompany it, if any.
				if stickies then
					for _,sticky in ipairs(stickies) do
						if not iscomplete then  ZGV:UpdateFrameAddStep(sticky,"sticky")  end
					end
				end

			-- And now any future steps, if any.
				for stepnum=firststep+1,laststep do  ZGV:UpdateFrameAddStep(self.CurrentGuide.steps[stepnum])  end

			-- Clear out steps from further frames.
				for f=self.framenum,self.StepLimit do self.stepframes[f].step=nil self.stepframes[f].stepnum=nil end

		-- All steps are assigned to their stepframes!

		-- SECOND, display frames.

		for stepframenum = 1,self.StepLimit do repeat
			--frame = _G['ZygorGuidesViewerFrame_Step'..stepframenum]
			local frame = self.stepframes[stepframenum]
			local stepdata = frame.step

			--print(stepframenum,stepdata,stepdata and ZGV:IsStepFocused(stepdata))

			if stepdata and ZGV:IsStepFocused(stepdata) then 
				for j,line in pairs(frame.lines) do line.clicker:Show() end
			else
				for j,line in pairs(frame.lines) do line.clicker:Hide() end
			end
			
			if not stepdata or nomoredisplayed then
				frame:Hide()
				break  --continue
			end




			--[[
			if not self.stepchanged and not stepdata:NeedsUpdating() or (nomoredisplayed and not frame:IsVisible()) then
				break --continue
			end
			--]]
			--print("Displaying step "..frame.stepnum)

			stepdata:PrepareCompletion()

			--#### position step frame

			frame:SetWidth(showallsteps and ZygorGuidesViewerFrame_ScrollChild:GetWidth() or Scroll:GetWidth()) -- this is needed so the text lines below can access proper widths

			-- out of screen space? bail.
			-- but only in all steps mode!
			local top=frame:GetTop()
			local bottom=Scroll:GetBottom()
			if showallsteps and top and bottom and top<bottom then
				frame:Hide()
				nomoredisplayed=true
				break --continue!
			end

			--#### fill it with text

			local changed,dirty = stepdata:Translate()
			if dirty then
				self.frameNeedsUpdating=true
			end
			if changed and not dirty then
				do_showwaypoints = true  -- kinda overkill, but works. Refresh all waypoints if something got translated.
			end

			frame.lines[1].label:ClearAllPoints()

			local line=0
			local lineframe

			local did_header
			local numbertext = self.db.profile.stepnumbers and L['step_num']:format(self.stepframes[stepframenum].stepnum)
			local leveltext = (stepdata.level and stepdata.level>0 and self.db.profile.stepnumbers) and L['step_level']:format(stepdata.level or "?")
			local reqtext = stepdata.requirement and (stepdata:AreRequirementsMet() and "|cff44aa44" or "|cffbb0000") .. L["stepreq"]:format((table.concat(stepdata.requirement,L["stepreqor"])):gsub("!([a-zA-Z ]+)",L["stepreqnot"]:format("%1")))
			local titletext -- = stepdata:GetTitle()  titletext=titletext and " "..titletext
			local betatext = (self.CurrentGuide.beta or stepdata.beta) and L['stepbeta']

			if showbriefsteps and not reqtext then
				lineframe.briefhidden = true
			end

			if (numbertext or leveltext or reqtext or titletext or betatext) then
				line=line+1  lineframe=frame.lines[line]
				lineframe.label:SetText((numbertext or "")..(leveltext or "")..(reqtext or "")..(titletext or "")..(betatext or ""))
				--lineframe.label:SetMultilineIndent(1)
				lineframe.goal = nil
				lineframe.label:SetFont(FONT,round(self.db.profile.fontsecsize))
				lineframe.icon:Hide()
				lineframe.back:Show()
				-- TODO how about we let skin decide?
				lineframe.back:SetBackdropColor(0,0,0,0.3*ZGV.db.profile.opacitymain)
				lineframe.back:SetBackdropBorderColor(0,0,0,0.3*ZGV.db.profile.opacitymain)
				lineframe.isheader=true
			end

			lineframe=frame.lines[line+1] -- sic; set up one line ahead.
			lineframe.label:SetFont(FONT,self.db.profile.fontsize)
			lineframe.back:Hide()
			lineframe.isheader=nil

			if (stepdata:AreRequirementsMet() or self.db.profile.showwrongsteps) then
				--#### insert goals

				local goals

				---------------------- STICKIES INLINE ----------------------
				-- does a sticky live in here?
				-- DISABLED for now. self.db.profile.stickydisplay is now only 3 or 4. No inline stickies.
				--[=[
					if self.db.profile.stickyon and self.db.profile.stickydisplay<3 then
						local stickies = self:GetStickiesAt(stepnum)
						for _,sticky in ipairs(stickies) do
							-- we have a sticky!!
							--print("sticky",sticky.step.label)

							local complete,possible = sticky.step:IsComplete()

							if not complete or stepdata:IsComplete() then
								-- method one (only one so far)
								if not goals then 
									goals=goals_temp
									wipe(goals)
									ZGV.MergeTable(stepdata.goals,goals)
								end

								ZGV.MergeTable(sticky.step.goals,goals)
							end
						end
					end
				--]=]

				if not goals then goals=stepdata.goals end

				local canhidetravel=false
				if not self.db.profile.showinlinetravel or frame.is_sticky then for i,goal in ipairs(goals) do if not goal:IsInlineTravel() then canhidetravel=true break end end end


				local hadstickies
				for i,goal in ipairs(goals) do
					if goal:IsCompleteable() and not frame.is_sticky then canhidetravel=false end

					if full then goal.dirtytext = true end

					-- STICKIES inline-ish

					-- DISABLED for now. self.db.profile.stickydisplay is now only 3 or 4. No inline stickies.
					--[=[
						if (self.db.profile.stickyon and self.db.profile.showcountsteps==1) and goal.parentStep.is_sticky and goal.parentStep~=ZGV.CurrentStep and (self.db.profile.stickydisplay==1 or self.db.profile.stickydisplay==2) then
							if hadstickies~=goal.parentStep then
								--lineframe.label:SetFont(FONT,round(self.db.profile.fontsecsize or self.db.profile.fontsize + (self.CurrentSkinStyle.StepFontSizeMod or 0))) -- TODO skindata() friendly?
								line=line+1  lineframe=frame.lines[line]
								lineobj=lineframe
								if self.db.profile.stickydisplay==1 then
									lineobj.label:SetText("")
								elseif self.db.profile.stickydisplay==2 then
									lineobj.label:SetFont(FONT,round(self.db.profile.fontsecsize))
									lineobj.label:SetText("- also -")
									lineobj.indent=0
								end
								lineobj:SetHeight(2)
								lineobj.back:SetBackdropColor(1,1,1,1)
								lineobj.briefhidden = showbriefsteps
								lineobj.goal=nil
								lineobj.special="stickyseparator"
								hadstickies=goal.parentStep
								--lineframe.label:SetMultilineIndent(1)
							end
						end
					--]=]

					local status = goal:GetStatus()

					if self.recentlyChangedGoals[goal] ~= status then  -- TODO: move all "goal changes state" code here?
						self.recentlyChangedGoals[goal] = status
						--if goal.x then do_showwaypoints = true end -- in case we need to advance to an incomplete point. May be overkill, but why not.
						-- sinus 2016-11-16 20:21:08 - no, let's only advance from goals being completed, in goal:OnComplete.
					end

					if status=="hidden" and not self.db.profile.showwrongsteps then
						-- don't display the line, simple
					elseif canhidetravel and goal:IsInlineTravel() then
						-- don't display inline travel if it's to be hidden

					--elseif goal.parentStep and goal.parentStep.is_sticky and goal.action=="goto" and not self.db.profile.stickygoto then
					--	-- hide gotos in stickies, when so configured

					--elseif goal:IsInlineTravel() and not goal.force_walk and LibRover:CanFlyAt(goal.map) then
					--	-- skip travel lines player can just fly over.

					elseif self.db.profile.collapsecompleted and goal:CanBeIndentHidden() and not stepdata:IsComplete() then
						-- collapse the line, if completed children say so

					else
						local briefhidden = showbriefsteps
							and (
								not goal:IsCompleteable()
								or (self.db.profile.hidecompletedinbrief and status=="complete" and not stepdata:IsComplete())
							)
							and not goal.showinbrief
						--steptext = steptext .. ("  "):rep(goal.indent or 0) .. goal:GetText() .. "|n"
						local indent = ("  "):rep(showbriefsteps and 0 or (goal.indent or 0))
						--local goaltxt = goal:GetText(stepnum>=self.CurrentStepNum)
						--local goaltxt = goal:GetText(true,self.db.profile.showbriefsteps and (self.briefstepexpansion<=0.1 --[[or stepdata~=self.briefstepexpanded--]]))
						local goaltxt = goal:GetText(true,showbriefsteps and ((self.briefstepexpansionlines[stepframenum] or 0)<=0.1 --[[or stepdata~=self.briefstepexpanded--]]))

						if self.db.profile.showwrongsteps and status=="hidden" then goaltxt = "|cff880000[*BAD*]|r "..goaltxt end

						if goaltxt~="?" and goaltxt~="" and lineframe then
							line=line+1  lineframe=frame.lines[line]
							--local link = ((goal.tooltip and not self.db.profile.tooltipsbelow) or (goal.x and not self.db.profile.windowlocked)) and " |cffdd44ff*|r" or ""  -- goto asterisk
							--if stepdata:IsCurrentlySticky() then link="" end
							if not lineframe then error ("line "..line.." does not exist") end
							if not lineframe.label then error ("label in line "..line.." does not exist") end
							if not goal or not goal.action then error("invalid goal") end
							lineframe.label:SetFont(FONT,round(goal.action~="info" and self.db.profile.fontsize + (self.CurrentSkinStyle.StepFontSizeMod or 0) or self.db.profile.fontsecsize)) -- TODO skindata() friendly?
							lineframe.label:SetText(indent..goaltxt)
							lineframe.goal = goal
							lineframe.briefhidden = briefhidden
							lineframe.special = (goal.parentStep and goal.parentStep.is_sticky and goal.parentStep~=ZGV.CurrentStep and "stickyline")
							--lineframe.label:SetMultilineIndent(1)

						end

						if (goaltxt=="?" or self.db.profile.tooltipsbelow) and goal.tooltip then
							line=line+1  lineframe=frame.lines[line]
							lineframe.label:SetFont(FONT,round(self.db.profile.fontsecsize))
							lineframe.label:SetText(indent.."|cffeeeecc".. goal.tooltip.."|r")
							--lineframe.label:SetMultilineIndent(1)
							lineframe.goal = nil
							lineframe.tipgoal = goal
							lineframe.briefhidden = true
							lineframe.special = (goal.parentStep.is_sticky and goal.parentStep~=ZGV.CurrentStep and "stickyline")
						end
						if goal.loadguideZZZZ then
							line=line+1  lineframe=frame.lines[line]
							lineframe.label:SetFont(FONT,round(self.db.profile.fontsecsize))
							local guide = goal.loadguide:match("\\([^\\]+)$")
							if guide then
								local g,step = guide:match("(.*)::(%d+)")
								if g then guide=g end
								lineframe.label:SetText(indent.."|cffeeeecc".. guide .."|r")
								--lineframe.label:SetMultilineIndent(1)
								lineframe.goal = goal
								--lineframe.special = (goal.parentStep.is_sticky and goal.parentStep~=ZGV.CurrentStep and "stickyline")
							end
						end
						if self.Sync and goal:IsCompleteable() and self.Sync:IsEnabled() and self.db.profile.share_showparty then
							local partystatus,color=self.Sync:GetStepGoalPartyStatusText(goal.parentStep.num,goal.num)
							if partystatus then
								line=line+1  lineframe=frame.lines[line]
								lineframe.label:SetFont(FONT,round(self.db.profile.fontsecsize))
								lineframe.label:SetText(indent..partystatus)
								if color then lineframe.back:SetBackdropColor(ZGV.F.HTMLColor(color)) end
								lineframe.goal = nil
								lineframe.tipgoal = nil
								lineframe.briefhidden = true
							end
						end
					end
				end
			end

			-- add synced party members' step numbers at the last line
			if self.Sync and stepdata==ZGV.CurrentStep and self.Sync:IsEnabled() and self.db.profile.share_showparty then
				local aheadbehind = self.Sync:GetAheadBehind()
				if aheadbehind then
					line=line+1  lineframe=frame.lines[line]
					lineframe.label:SetFont(FONT,round(self.db.profile.fontsecsize))
					lineframe.label:SetText(aheadbehind)
					lineframe.goal=nil
				end
			end

			-- ALL collapsed? come on...
			local allcoll=true
			for l=1,line do
				if not frame.lines[l].briefhidden or not showbriefsteps then
					allcoll=false
					break
				end
			end
			if allcoll then
				line=line+1  lineframe=frame.lines[line]
				lineframe.label:SetFont(FONT,round(self.db.profile.fontsecsize))
				lineframe.label:SetText("|cffaaaaaa"..L['stepcollapsed'].."|r")
				--lineframe.label:SetMultilineIndent(1)
				lineframe.goal = nil
				lineframe.briefhidden = false
				lineframe.special = "allcollapsed"
			end

			local TMP_TRUNCATE = true
			local heightleft = 400
			if showallsteps and TMP_TRUNCATE then
				if stepframenum>1 then
					local stepbottom = self.stepframes[stepframenum-1]:GetBottom()
					local scrollbottom = Scroll:GetBottom()
					if stepbottom and scrollbottom then
						heightleft = stepbottom-scrollbottom - 2*SkinData("StepLineMarginY") - 5
					else
						heightleft = 0
						--self:Debug("Error in step height calculation! step "..stepframenum.." stepbottom="..tostring(stepbottom).." scrollbottom="..tostring(scrollbottom)..", forcing update")
						self.frameNeedsUpdating=true
					end
				end

				if heightleft<self.MIN_STEP_HEIGHT then
					frame:Hide()
					nomoredisplayed=true
					break --continue
				end
			end

			local height=0
			--frame.goallines={}
			local textheight
			frame.truncated=nil
			local abort


			local untruncated_text_width = frame:GetWidth()-icon_indent-2*SkinData("StepLineMarginX")-2
			if untruncated_text_width<0 then untruncated_text_width=untruncated_text_width+ZygorGuidesViewerFrame_ScrollChild:GetWidth() end  -- BFA 8.0.1.26530 bug: step's frame has a width of 0 here...
			for l=1,LINES_PER_STEP do
				local lineframe = frame.lines[l]
				local text = lineframe.label
				if l<=line and not frame.truncated then
					text:SetWidth(untruncated_text_width)
					-- print("QWEQWE ",stepframenum,l,frame:GetName(),"width",frame:GetWidth(),untruncated_text_width)
					local lineheight

					textheight = text:GetHeight()
					--if text:IsTruncated() then textheight=textheight+self.db.profile.fontsize+6 end
					lineheight = textheight + STEP_LINE_SPACING + LINE_MARGIN_BOTTOM - 1 

					if lineframe.special=="stickyseparator" then
						if self.db.profile.stickydisplay==1 then
							lineheight=2
						elseif self.db.profile.stickydisplay==2 then
							--lineframe.label:SetText("- also -")
							--lineheight = textheight + STEP_LINE_SPACING
						end
					end

					if lineframe.briefhidden and showbriefsteps --[[and stepdata==self.CurrentStep--]] then
						--lineheight = lineheight * self.briefstepexpansion
						lineheight = lineheight * (self.briefstepexpansionlines[stepframenum] or 0)

						--lineframe:SetAlpha(self.briefstepexpansion)
						lineframe:SetAlpha(self.briefstepexpansionlines[stepframenum] or 0)
						text:SetAlpha(self.briefstepexpansionlines[stepframenum] or 0)
						lineframe.icon:SetAlpha(self.briefstepexpansionlines[stepframenum] or 0)
					else
						lineframe:SetAlpha(1)
						text:SetAlpha(1)
						lineframe.icon:SetAlpha(1)
					end

					height = height + lineheight

					--text:SetWidth(ZygorGuidesViewerFrameScroll:GetWidth()-30)

					if TMP_TRUNCATE and showallsteps and height>heightleft then
						lineframe.goal=nil
						if l<=2 then
							abort=true
							break
						else
							frame.truncated=true
							frame.lines[l-1].label:SetText("   . . .")
							frame.lines[l-1].goal=nil
							lineframe:Hide()
							height=height-lineheight
						end
					else
						lineframe:Show()
						--if lineframe.goal then frame.goallines[lineframe.goal.num]=lineframe end
					end

					lineframe:SetHeight(lineheight)
					-- print("QWEQWE line",l,"height",lineheight)
				else
					lineframe:Hide()
					lineframe.goal = nil
				end
			end

			if abort then
				frame:Hide()
				nomoredisplayed=true
				break --continue
			end


			--#### display it all properly

			--[[
			if height<self.MIN_STEP_HEIGHT then
				frame.lines[1]:SetPoint("TOPLEFT",frame,ZGV.STEPMARGIN_X,-4)
				frame.lines[1]:SetPoint("TOPRIGHT",frame,-ZGV.STEPMARGIN_X,-4)
				height=self.MIN_STEP_HEIGHT
			else
				frame.lines[1]:SetPoint("TOPLEFT",frame,ZGV.STEPMARGIN_X,-4)
				frame.lines[1]:SetPoint("TOPRIGHT",frame,-ZGV.STEPMARGIN_X,-4)
			end
			-- how about NO special cases
			--]]

			frame.lines[1]:SetPoint("TOPLEFT",frame,SkinData("StepLineMarginX"),-SkinData("StepLineMarginY"))
			frame.lines[1]:SetPoint("TOPRIGHT",frame,-SkinData("StepLineMarginX"),-SkinData("StepLineMarginY"))

			--self:Debug("step "..stepframenum.." height "..height)

			if not frame.truncated or not TMP_TRUNCATE then
				frame:SetHeight(height + 2*SkinData("StepLineMarginY"))
			else
				frame:SetHeight(heightleft + 2*SkinData("StepLineMarginY"))
			end

			--end

			if stepframenum>1 then totalheight = totalheight + STEP_SPACING end
			totalheight = totalheight + frame:GetHeight()



			if stepdata==self.CurrentStep and showallsteps then
				frame.border:Show()
			else
				frame.border:Hide()
			end

			--[[
			if self.db.profile.showallsteps and totalheight>ZygorGuidesViewerFrameScroll:GetHeight() then
				nomoredisplayed=true
				frame:Hide()
				break --continue
			end
			--]]

			if showallsteps and frame.truncated then
				nomoredisplayed=true
			end


			--oookay, frame is visible, let's fill it for real
			frame:Show()

			-- STICKY COLORS
			local sr,sg,sb,sa = 0.4,0.4,0.4,0.5
			sa = sa * self.db.profile.opacitymain

			if frame.is_sticky and self.db.profile.stickydisplay==3 then
				frame:SetBackdropBorderColor(sr,sg,sb,1)
			else
				frame:SetBackdropBorderColor(0,0,0,1)
			end

			--// Show icons and backgrounds for all lines of the step.

				for l=1,LINES_PER_STEP do

					line = frame.lines[l]
					if not line then break end

					local icon = line.icon
					local back = line.back

					local goal = line.goal

					line.label:SetPoint("TOPLEFT",line.isheader and 0 or icon_indent+2,(l==1 and -2 or -1))

					if goal then
						local label = line.label
						local clicker = line.clicker
						local anim_w2g = line.anim_w2g
						local anim_w2r = line.anim_w2r
						local anim_r2r = line.anim_r2r

						local status,done,needed = goal:GetStatus()
						local progress = (done or 0)/(needed or 1)

						-- prepare completion effects

						-- set justCompleted only once per completion
						-- except if this is the goal that when completed makes guide progress to 
						local needsAnimating = goalsneedanimating[goal]

						-- ICONS
						if goal and self.db.profile.goalicons then
							label:SetPoint("TOPLEFT",icon_indent+2,-LINE_MARGIN_TOP+1)
							icon:SetPoint("TOPLEFT",line,"TOPLEFT",1,-2)
							icon:SetSize(self.CurrentSkinStyle.StepLineIconSize * self.db.profile.fontsize,self.CurrentSkinStyle.StepLineIconSize * self.db.profile.fontsize) -- TODO SkinData friendly?
							icon:Show()

							if goal.next or goal.loadguide then
								icon:SetIcon(actionicon.next)
							elseif goal.action=="achieve" and goal.achieveid then
								icon:SetTexture(goal.achieveicon)
								icon:SetTexCoord(0,1,0,1)
							elseif poi_actions[goal.action] then
								icon:SetIcon(actionicon[goal.action])
							elseif status=="passive" then

								if goal.action=="talk" or goal.action=="from" or goal.action=="goto" or
								goal.action=="goldcollect" or goal.action=="goldtracker" or (goal.action=="image" and not goal.inline) then
									icon:SetIcon(actionicon[goal.action])
								elseif (goal.action=="image" and goal.inline) then
									icon:SetIcon(0)
								else
									icon:SetIcon(1)
								end
								icon:SetDesaturated(false)

							elseif status=="incomplete" then

								icon:SetIcon(actionicon[goal.action])
								icon:SetDesaturated(false)

							elseif status=="complete" then

								icon:SetIcon(3)
								icon:SetDesaturated(false)

							elseif status=="impossible" then

								icon:SetIcon(actionicon[goal.action])
								icon:SetDesaturated(true)

							elseif status=="obsolete" then

								--icon:SetIcon(actionicon[goal.action])
								--icon:SetDesaturated(false)
								icon:SetIcon(actionicon[goal.action])
								icon:SetDesaturated(true)

							else	-- maybe hidden, maybe WTF
								icon:SetIcon(1)
							end
						else
							label:SetPoint("TOPLEFT",0,-1)
							icon:Hide()
						end


						-- BACKGROUNDS

						if self.db.profile.goalbackgrounds then

							back:Show()

							-- COLORS

							local r,g,b,a=0,0,0,0

							if status=="passive" then
								--if line.special=="stickyline" then
								--	r,g,b,a = 0.2,0.15,0,1
								--else
									r,g,b,a = 0,0,0,0
								--end
								--[[
								if self.db.profile.highlight_goto and goal.x and ZGV.Pointer.DestinationWaypoint and ZGV.Pointer.DestinationWaypoint.goal==goal then
									r,g,b,a = 1,1,1,0.1
								end
								--]]

							elseif status=="incomplete" then

								local inc=self.db.profile.goalbackincomplete
								local pro=self.db.profile.goalbackprogressing
								local com=self.db.profile.goalbackcomplete
								r,g,b = self.gradient3(self.db.profile.goalbackprogress and progress*0.7 or 0,  inc.r,inc.g,inc.b, pro.r,pro.g,pro.b, com.r,com.g,com.b, 0.5)
								a = self.db.profile.goalbackincomplete.a

								--local r,g,b,a = gradientRGBA(self.db.profile.goalbackincomplete,self.db.profile.goalbackcomplete,self.db.profile.goalbackprogress and progress*0.7 or 0)

							elseif status=="complete" then

								r,g,b,a = fromRGBA(self.db.profile.goalbackcomplete)

							elseif status=="impossible" then

								r,g,b,a = fromRGBA(self.db.profile.goalbackimpossible)


							elseif status=="warning" then

								r,g,b,a = fromRGBA(self.db.profile.goalbackwarning)
							end

							-- FLASHES

							a = a * ZGV.db.profile.opacitymain

							if (goal.action~="goto" and goal.action~="fly") and self.db.profile.goalupdateflash and needsAnimating and self.frameNeedsResizing==0 then

								if line.special=="stickyline" then  r,g,b,a=mix4(sr,sg,sb,sa, r,g,b,0.3)  end

								goal.needsAnimating=nil

								anim_w2r.r,anim_w2r.g,anim_w2r.b,anim_w2r.a = r,g,b,a
								anim_w2r:Play()
								--self:Debug("Animating progress: %s",goal:GetText())
								goalsneedanimating[goal]=nil

								-- self.completionelapsed = 0  -- experimental delay

							elseif status=="complete" and needsAnimating and self.db.profile.goalcompletionflash and self.frameNeedsResizing==0 then

								anim_w2g:Play()
								goalsneedanimating[goal]=nil
								--self:Debug("Animating completion.")

								-- self.completionelapsed = 0  -- experimental delay
							end

							if  (anim_w2r:IsDone() or not anim_w2r:IsPlaying()) 
							and (anim_w2g:IsDone() or not anim_w2g:IsPlaying())
							and (anim_r2r:IsDone() or not anim_r2r:IsPlaying()) then
								if line.special=="stickyline" and self.db.profile.stickycolored then  r,g,b,a=mix4(sr,sg,sb,sa, r,g,b,a*0.5)  end
								back:SetBackdropColor(r,g,b,a)
								back:SetBackdropBorderColor(r,g,b,a)
							end

						else
							back:Hide()
						end

						if status=="impossible" then
							line:SetAlpha(0.4)
						else
							line:SetAlpha(1.0)
						end

					elseif line.isheader then
						-- leave it! it should handle its own back.

					elseif line.special=="stickyseparator" and self.db.profile.stickydisplay==1 then
						icon:Hide()
						back:SetBackdropColor(sr,sg,sb,1)
						back:SetBackdropBorderColor(sr,sg,sb,1)
						back:Show()
					elseif line.special=="stickyline" and self.db.profile.stickycolored then
						icon:Hide()
						back:SetBackdropColor(sr,sg,sb,sa)
						back:SetBackdropBorderColor(sr,sg,sb,sa)
						back:Show()
					else
						-- no goal? ah, subtitle.
						icon:Hide()
						back:SetBackdropColor(0,0,0,1)
						back:SetBackdropBorderColor(0,0,0,1)
						back:Hide()
					end

					-- Highlight for multi-waypoint cycling
					--if ZGV.CurrentStep.current_waypoint_goal and ZGV.CurrentStep.goals[ZGV.CurrentStep.current_waypoint_goal].action=="goto" then
					if ZGV.db.profile.highlight_goto and ZGV:IsStepFocused(stepdata) and goal and goal.num==stepdata.current_waypoint_goal_num
					-- and ZGV.CurrentStep.numberMappedGoals and ZGV.CurrentStep.numberMappedGoals > 1
					then
						local currentBackdropColor = {line.back:GetBackdropColor()}
						if currentBackdropColor[1]+currentBackdropColor[2]+currentBackdropColor[3]+currentBackdropColor[4]==0 then currentBackdropColor={1,1,1,0.1}
						else
							currentBackdropColor[1] = min(1,currentBackdropColor[1] + 0.1)
							currentBackdropColor[2] = min(1,currentBackdropColor[2] + 0.1)
							currentBackdropColor[3] = min(1,currentBackdropColor[3] + 0.1)
							--currentBackdropColor[4] = min(1,currentBackdropColor[4] + 0.2)
						end
						--currentBackdropColor[4] = ZGV.db.profile.opacitymain
						line.back:SetBackdropColor(unpack(currentBackdropColor))
					end
			
				end
			--\\

			if showallsteps then
				if stepdata.num<self.CurrentStepNum then
					frame:SetAlpha(0.3)
				elseif stepdata.num==self.CurrentStepNum then
					frame:SetAlpha(1.0)
				else
					frame:SetAlpha(0.8)
				end
			else
				if stepdata==focusedstep or ZGV.CurrentStep==focusedstep and frame.is_sticky then -- focused step or it's sticky
					if stepframenum==1 or frame.is_sticky then
						frame:SetAlpha(1.0)
					else
						frame:SetAlpha(0.8-0.4*((stepframenum-1)/(self.db.profile.showcountsteps-1)))
					end
				elseif MouseIsOver(frame) then
					frame:SetAlpha(0.65)
				else
					frame:SetAlpha(0.3)
				end
			end

			--[[
			if stepnum==self.CurrentStepNum then
				--frame:EnableMouse(0)
				--frame:SetScript("OnClick",nil)
			else
				--frame:EnableMouse(1)
			end
			--]]

			--[[
			if stepnum==self.CurrentStepNum then
				frame:SetBackdrop({ edgeFile = ZGV.DIR.."\\Skins\\default\\midnight\\border", edgeSize = 12,  })
			else
				frame:SetBackdrop({ edgeFile = ZGV.DIR.."\\Skins\\default\\midnight\\border", edgeSize = 12 })
			end
			--]]

			-- TODO this is really dirty
			self.db.profile.stepbackalpha=1.0 * ZGV.db.profile.opacitymain * ZGV.db.profile.opacitymain  -- twice, to make it more transparent, as it's overlaid on normal window background anyway.
			if stepdata:AreRequirementsMet() then
				if stepdata:IsComplete() and self.Sync and self.Sync:IsClearToProceed() then
					frame:SetBackdropColor(fromRGBmul_a(self.db.profile.goalbackcomplete,0.5,self.db.profile.stepbackalpha))
					if (not SkinData("StepBackdropPersistentBorder")) then
						frame:SetBackdropBorderColor(fromRGBmul_a(self.db.profile.goalbackcomplete,0.5,self.db.profile.stepbackalpha))
					end
					--frame:SetBackdropColor(0,0.7,0,0.5)
				elseif (self.db.profile.skipobsolete and stepdata:IsObsolete()) then
					frame:SetBackdropColor(fromRGBmul_a(self.db.profile.goalbackobsolete,0.5,self.db.profile.stepbackalpha))
					if (not SkinData("StepBackdropPersistentBorder")) then
						frame:SetBackdropBorderColor(fromRGBmul_a(self.db.profile.goalbackobsolete,0.5,self.db.profile.stepbackalpha))
					end
				elseif (self.db.profile.skipauxsteps and stepdata:IsAuxiliarySkippable()) then
					frame:SetBackdropColor(fromRGBmul_a(self.db.profile.goalbackaux,0.5,self.db.profile.stepbackalpha))
					if (not SkinData("StepBackdropPersistentBorder")) then
						frame:SetBackdropBorderColor(fromRGBmul_a(self.db.profile.goalbackaux,0.5,self.db.profile.stepbackalpha))
					end
				else
					local r,g,b = unpack(self.CurrentSkinStyle.StepBackdropColor or {0,0,0})
					frame:SetBackdropColor(r,g,b,self.db.profile.stepbackalpha)
					if (not SkinData("StepBackdropPersistentBorder")) then
						frame:SetBackdropBorderColor(0,0,0,self.db.profile.stepbackalpha)
					end
				end
			else
				frame:SetBackdropColor(0.5,0.0,0.0,self.db.profile.stepbackalpha)
				if (not SkinData("StepBackdropPersistentBorder")) then
					frame:SetBackdropBorderColor(0.5,0.0,0.0,self.db.profile.stepbackalpha)
				end
			end

			if not self.db.profile.showstepborders then
				frame:SetBackdropColor(0,0,0,0)
				frame:SetBackdropBorderColor(0,0,0,0)
			end

			--text:Show()

		until true end

		--[[ DO NOT REATTACH.
			for stepframenum = 1,self.StepLimit do
				local frame = self.stepframes[stepframenum]
				local prevframe = self.stepframes[stepframenum-1]
				if prevframe then
					if (prevframe.step and prevframe.step:IsComplete()) or prevframe:GetHeight()==0 then
						local attachable_frame = find_attachable_frame(stepframenum)
						frame:SetPoint("TOPLEFT",attachable_frame,"BOTTOMLEFT",0,-ZGV.STEP_SPACING)
						frame:SetPoint("TOPRIGHT",attachable_frame,"BOTTOMRIGHT",0,-ZGV.STEP_SPACING)
					else
						frame:SetPoint("TOPLEFT",prevframe:GetName(),"BOTTOMLEFT",0,-ZGV.STEP_SPACING)
						frame:SetPoint("TOPRIGHT",prevframe:GetName(),"BOTTOMRIGHT",0,-ZGV.STEP_SPACING)
					end
				end
			end
		--]]


		self.stepchanged=false

		-- set minimum frame size to one step
		minh = self.stepframes[1]:GetHeight() + TOP_HEIGHT + ZygorGuidesViewerFrame_Border_TabBack:GetHeight()

		self:UpdateFrameCurrent()

		--self:HighlightCurrentStep()

		-- steps displayed, clear the remaining slots

	--[[
	else -- no current guide?

		local guides = self:GetGuides()
		if #guides>0 then
			ZGV:Print(L["guide_notselected"])
		else
			ZGV:Print(L["guide_notloaded"])
		end
		for i,stepframe in ipairs(self.stepframes) do stepframe:Hide() end
		self.ProgressBar:Hide()
		minh=0
	--]]
	end

	if minh<MIN_HEIGHT+tabh then minh=MIN_HEIGHT+tabh end
	self.Frame:SetMinResize(MIN_WIDTH,minh)
	if not InCombatLockdown() then 
		if self.Frame:GetHeight()<minh-0.01 then self.Frame:SetHeight(minh) end
	end


	self:ResizeFrame()

	if do_showwaypoints then
		self:ShowWaypoints()  
	end

	if self.delayFlash and self.delayFlash>0 then
		self.delayFlash=2 --ready to flash!
		--ZygorGuidesViewerFrame_bdflash:StartRGB(1,1,1,1,0,1,0,1)
	end
end


function ZGV:ClearFrameCurrent()
	if InCombatLockdown() then return end
	for j=1,#self.stepframes do
		for i=1,LINES_PER_STEP do if self.actionbuttons[j] and self.actionbuttons[j][i] then
			self.actionbuttons[j][i]:Hide()
			self.petactionbuttons[j][i]:Hide()
			self.actionbuttons[j][i].cd:Hide()
		end end
	end
end


function ZGV:UpdateFrameCurrent()
	-- current step!
	self:ClearFrameCurrent()

	if not self.CurrentStep then	return end -- hey, it may be missing, if the whole guide is for another class

	local name, line,label,icon,back,clicker,anim_w2g,anim_w2r,action,petaction,cooldown, lastlabel
	local height = 0

	if not self.stepframes[1].stepnum then return end

	local framenum = (self.CurrentStepNum - self.stepframes[1].stepnum + 1)

	for framenum=1,#self.stepframes do
		if self.stepframes[framenum]:IsVisible() then
			if framenum<1 or framenum>self.StepLimit then
				self.CurrentStepframeNum = nil
				--return self:ClearFrameCurrent()
			else
				self.CurrentStepframeNum = framenum
			end

			local stepframe = self.stepframes[framenum]
			if not stepframe.lines[1].icon then
				ZygorGuidesViewerFrame_Step_Setup(framenum)
			end

			--if not stepframe:IsVisible() then
			--	return self:ClearFrameCurrent()
			--end

			--textline(1):ClearAllPoints()
			--textline(1):SetPoint("TOPLEFT",stepframe,"TOPLEFT",0,self.CurrentStep.requirement and -textline(1):GetHeight()-STEP_LINE_SPACING or 0)
			--textline(1):SetPoint("TOPRIGHT",stepframe,"TOPRIGHT",0,self.CurrentStep.requirement and -textline(1):GetHeight()-STEP_LINE_SPACING or 0)

			if self.BUTTONS_INLINE then
				if not InCombatLockdown() then self.actionsvisible = false end
			end

			for i=1,LINES_PER_STEP do  -- update all lines
				--local linenum = (self.CurrentStep.requirement and i+1 or i)

				line = stepframe.lines[i]
				if not line then break end
				label = line.label
				icon = line.icon
				back = line.back
				clicker = line.clicker
				anim_w2g = line.anim_w2g
				anim_w2r = line.anim_w2r

				clicker:SetFrameLevel(back:GetFrameLevel()+1)

				-- don't even touch this in combat.

				local goal = line.goal

				if goal then
					lastlabel = label

					-- ACTION BUTTONS
					-- all non-action code: get the hell out.

					if not InCombatLockdown() and not stepframe.slideup:IsPlaying() then
						if goal:IsActionable() then
							if not self.actionbuttons[framenum][i] then
								ZGV:AddActionButtons(framenum,i)
							end

							action = self.actionbuttons[framenum][i]
							petaction = self.petactionbuttons[framenum][i]

							if not InCombatLockdown() then
								action:SetHitRectInsets(0,-clicker:GetWidth()+15,0,0)
								action:SetHighlightTexture(nil,nil,nil,nil)--remove highlighting for the buttons
							end

							--	cooldown:Show()
							--self:Debug("showing cooldown "..i)
							local vis

							if not self.BUTTONS_INLINE then
								action:SetFrameLevel(ZygorGuidesViewerFrame:GetFrameLevel()+5)
								petaction:SetFrameLevel(ZygorGuidesViewerFrame:GetFrameLevel()+5)
							end

							if goal.castspell and goal.castspellid then
								action:SetAttribute("type","spell")
								action:SetAttribute("spell",goal.castspell)
								action.spellid = goal.castspellid
								action.tex:SetTexture(select(3, GetSpellInfo(goal.castspellid or goal.castspell)) or "Interface\\Icons\\Spell_Nature_FaerieFire")
								action.goal = goal
								--action:SetScript("OnClick",function(self) PetActionButton_OnClick(self,"LeftButton") end)
								vis=true
								--	local start,dur,en = GetSpellCooldown(goal.castspellid or goal.castspell)
								--DoCooldown(cooldown,start,dur,en)

							elseif goal.item or goal.itemid then
								action:SetAttribute("type","item")
								if goal.itemuse then
									action:SetAttribute("item",goal.itemid and "item:"..goal.itemid  or  goal.item)
								end
								--[[
								if PlayerHasToy(goal.itemid) then  -- it's a toy!
									action:SetAttribute("type","action")
									action:SetAttribute("action",C_ToyBox.GetToyLink(goal.itemid))
								end
								--]]
								--ZGV:Debug("&display Goal %d shows item %d",goal.num,goal.itemid)
								action.tex:SetTexture(select(10, ZGV:GetItemInfo(goal.itemid or goal.item)) or "Interface\\Icons\\INV_Misc_Bag_08")
								action.goal = goal
								vis=true
								--local start,dur,en = GetItemCooldown(goal.itemid or goal.item)
								--DoCooldown(cooldown,start,dur,en)

							elseif goal.macro then
								action:SetAttribute("type","macro")
								--action:SetAttribute("macro","ZygorGuidesMacro"..goal.num)
								action:SetAttribute("macro",goal.macro)
								ZGV:Debug("&display Goal %d shows macro %d",goal.num,goal.macro)
								local tex = select(2,GetMacroInfo(goal.macro))
								--if tex and tex:find("\\0") then tex=nil end
								action.tex:SetTexture(tex)
								action.goal = goal
								vis=true

							elseif goal.petaction then
								local num,name,_,tex = ZGV.FindPetActionInfo(goal.petaction)
								if num then
									petaction:SetID(num)
									petaction.tooltipName=name
									petaction.tooltipSubtext=subtext
									--action:SetScript("OnClick",function(self) PetActionButton_OnClick(self,"LeftButton") end)
									petaction.icon:SetTexture(tex)
									petaction:Show()
									petaction:ClearAllPoints()
									petaction:SetPoint("CENTER",UIParent,"BOTTOMLEFT",(icon:GetLeft() or 0)+8 or 0,(icon:GetBottom() or 0)+8)
									petaction:SetScale(self.db.profile.framescale)
								else
									petaction:Hide()
								end
								petaction.goal = goal
							else
								-- error("IsActionable but no item/spell!")
								-- might happen when leaving combat. Just ignore silently.

								--[[
								if not InCombatLockdown() then
									action:Hide()
								end
								cooldown:Hide()
								--]]
								action.goal = nil
								petaction.goal = nil
							end

							if vis and goal.parentStep.isFocused then
								action:Show()
								action:SetScale(self.db.profile.framescale)
								if self.BUTTONS_INLINE then
									action:SetParent(clicker)
									action:ClearAllPoints()
									action:SetPoint("CENTER",clicker,"LEFT",8,0)
									self.actionsvisible = true
								else
									action:ClearAllPoints()
									action:SetPoint("CENTER",UIParent,"BOTTOMLEFT",(icon:GetLeft() or 0) +8,(icon:GetBottom() or 0)+8)
								end
							end

							--cooldown:Show()
						else
							if self.actionbuttons[framenum][i] then
								self.actionbuttons[framenum][i]:Hide()
								self.petactionbuttons[framenum][i]:Hide()
							end
						end

					end

					-- ICON stuff moved to all steps handler
					if self.BUTTONS_INLINE then
						if self.actionbuttons[framenum][i] then
							if self.actionbuttons[framenum][i]:IsShown() then icon:Hide() end
						end
					end
				else
					if self.actionbuttons[framenum][i] then
						if not InCombatLockdown() then 
							self.actionbuttons[framenum][i]:Hide() 
							self.petactionbuttons[framenum][i]:Hide() 
						end
						self.actionbuttons[framenum][i].cd:Hide()
					end
				end
			
			
			
			
			
			end
		end
	end
end

function ZGV:SetFrameScale(scale)
	scale = self.db.profile.framescale
	frame:SetScale(scale)
end

function ZGV:ReanchorFrame()
	local frame = self.Frame
	local framemaster = frame:GetParent()
	local upsideup = not self.db.profile.resizeup


	local tabbar_height = 2
	if #ZGV.registeredmapspotsets>0 then
		tabbar_height = 20
	end


	frame:ClearAllPoints()
	local tabh = ZygorGuidesViewerFrame_Border_TabBack:GetHeight()

	if frame.sizedleft then
		local q,w,e,x,y = framemaster:GetPoint()
		framemaster:ClearAllPoints()
		framemaster:SetPoint(q,w,e,x+frame:GetLeft()-frame.sizedleft,y)
		frame.sizedleft=nil
	end

	if upsideup then
		--frame:SetPoint("TOP",nil,"TOP",(left+right)/2-(uiwidth/2/scale),top-uiheight/scale)
		--frame:SetPoint("TOP",frame:GetParent(),"BOTTOMLEFT",left+width/2,top)
		frame:SetPoint("TOPLEFT",framemaster,"TOPLEFT",0,0)
		frame:SetClampRectInsets(0,0,-48-tabh,0)
	else
		--frame:SetPoint("BOTTOM",nil,"BOTTOM",(left+right)/2-(uiwidth/2/scale),bottom)
		--frame:SetPoint("BOTTOM",frame:GetParent(),"BOTTOMLEFT",left+width/2,bottom)
		frame:SetPoint("BOTTOMLEFT",framemaster,"BOTTOMLEFT",0,0)
		frame:SetClampRectInsets(0,0,0,48+tabh)
	end

	--frame:UpdateMiniMode()
end

function ZGV:AlignFrame()
	self.Frame:AlignFrame()
	self.db.profile.frame_anchor = {self.Frame:GetParent():GetPoint()}
end

function ZGV:UpdateSkin()
	self.Frame:UpdateSkin()
end

function ZGV:ResizeFrame()
	--autosize
	--if (self.db.profile.autosize) then
	--print("resize")
	if self.frameNeedsResizing then
		if self.frameNeedsResizing>0 then self.frameNeedsResizing = self.frameNeedsResizing - 1 end
		if self.frameNeedsResizing>0 then return nil end
	end
	if not self.db then return end

	--[[
	if ZygorGuidesViewerFrame_Border_Bottom:GetRect() then
		local xsize = select(3,ZygorGuidesViewerFrame_Border_Bottom:GetRect())/200
		local ysize = select(4,ZygorGuidesViewerFrame_Border_Left:GetRect())/100
		local ysize2 = select(4,ZygorGuidesViewerFrame_Border_Right:GetRect())/100
		ZygorGuidesViewerFrame_Border_Left:SetTexCoord(0.2,0.8,0,1*ysize)
		ZygorGuidesViewerFrame_Border_Right:SetTexCoord(0.2,0.8,0,1*ysize2)
		ZygorGuidesViewerFrame_Border_Bottom:SetTexCoord(0,-xsize,1,-xsize,0,xsize,1,xsize)
	end
	--]]

	--ZygorGuidesViewerFrame_Border:SetBackdropColor(self.db.profile.skincolors.back[1],self.db.profile.skincolors.back[2],self.db.profile.skincolors.back[3],self.db.profile.backopacity)


	--self:Debug("resizing from "..tostring(ZygorGuidesViewerFrame:GetHeight()))

	if self.db.profile.showcountsteps==0 or self.db.profile.displaymode=="gold" then
		ZygorGuidesViewerFrame_ScrollScrollBar:Show()
	else
		-- only autoresize when showing ONE step. If we have many steps, the user handles resizing.
		ZygorGuidesViewerFrame_ScrollScrollBar:Hide()
		--if not self.CurrentStepNum or not _G['ZygorGuidesViewerFrame_Step'..self.CurrentStepNum] then return end
		local height = 0
		for i=1,self.StepLimit do
			if self.stepframes[i]:IsShown() then
				if i>1 then height = height + STEP_SPACING end
				height = height + self.stepframes[i]:GetHeight()
			end
		end

		--local tabh = ZygorGuidesViewerFrame_Border_TabBack:GetHeight()

		--height = height + TOP_HEIGHT + tabh
		height = height + TOP_HEIGHT
		--self:Debug("Height "..height.."  min "..MIN_HEIGHT)
		--if height < MIN_HEIGHT + tabh then height=MIN_HEIGHT + tabh end
		if height < MIN_HEIGHT then height=MIN_HEIGHT end
		if not InCombatLockdown() then
			self.Frame:SetHeight(height+ZGV.CurrentSkinStyle:SkinData("ProgressBarSpaceHeight") + ZGV.CurrentSkinStyle:SkinData("TabsHeight") + (ZGV.db.profile.resizeup and 10 or -2))
		end
	end

	-- do not call this on the same frame, as getwidth/height inside will be broken
	-- self:ScheduleTimer(function() ZGV.ProgressBar:Refresh() end,0)
	


	--self:Debug(("%d %d"):format(left,bottom))
--		ZygorGuidesViewerFrame:SetHeight(ZygorGuidesViewerFrame_Text:GetHeight()+35)


--	if ZygorGuidesViewerFrame_ActiveStep_Line1:GetTop() then
		--ZygorGuidesViewerFrame_Resize.max = ZygorGuidesViewerFrame_Line1:GetTop()-ZygorGuidesViewerFrame_TextInfo2:GetBottom()+35
		--ZygorGuidesViewerFrame_Resize:Stop()
		--ZygorGuidesViewerFrame_Resize:Play()

--		ZygorGuidesViewerFrame:SetHeight(ZygorGuidesViewerFrame_ActiveStep_Line1:GetTop()-ZygorGuidesViewerFrame_TextInfo2:GetBottom()+35)
--	end

--	end
end

function ZGV:GoalProgress(goal)
	return "epic fail"
end

function ZGV:ScrollToCurrentStep()
--	if self.ForceScrollToCurrentStep and self.CurrentStep then
--		self.ForceScrollToCurrentStep = false
		if self.CurrentStep and self.db.profile.displaymode=="guide" then

			local height=0
			local step
			if self.db.profile.showcountsteps==0 then
				local topstep = self.stepframes[1].stepnum
				if not topstep then return end
				if self.stepframes[1].stepnum>self.CurrentStepNum --above
				or (topstep+self.StepLimit-1<self.CurrentStepNum) --way below
--				or (ZygorGuidesViewerFrame_Step1:GetTop()-_G['ZygorGuidesViewerFrame_Step'..(self.CurrentStepNum-topstep+1)]:GetBottom()+STEP_SPACING>ZygorGuidesViewerFrameScroll:GetHeight()) --barely offscreen
				or not self.stepframes[self.CurrentStepNum-topstep+1]:IsShown()
				or self.stepframes[self.CurrentStepNum-topstep+1].truncated
				then
					ZygorGuidesViewerFrame_ScrollScrollBar:SetValue(self.CurrentStepNum)
					ZygorGuidesViewerFrame_ScrollScrollBar:Show()
				end
			else
				ZygorGuidesViewerFrame_ScrollScrollBar:Hide()
			end
		end
--	else
--		self.ForceScrollToCurrentStep = true
--	end
end

function ZGV:IsVisible()
	return self.Frame:IsVisible()
end

function ZGV:SetVisible(info,onoff)
	if onoff then 
		self.Frame:Show() 
		self.db.profile.enable_viewer = true
	else 
		self.Frame:Hide() 
		self.db.profile.enable_viewer = false
	end
end

function ZGV:ToggleFrame()
	if self.Frame:IsShown() then 
		self.Frame:Hide() 
		self.db.profile.enable_viewer = false
	else 
		self.Frame:Show() 
		self.db.profile.enable_viewer = true
		ZGV.Tabs:ReanchorTabs()
	end
end

function ZGV:IsDefaultFitting(default)
	-- deprecated?
	local _,race = UnitRace("player")
	local _,class = UnitClass("player")
	if (class=="DEATHKNIGHT") then race=class end
	default=default:upper()
	race=race:upper()
	class=class:upper()
	return race==default or class==default or race.." "..class==default
end

--- Checks if the player's race/class matches the requirements.
-- @param requirement May be a string or a table of strings (which are then ORed).
-- @return true if matching, false if not.
RaceClassMatchCache={}
function ZGV:RaceClassMatch(fit)
	-- get string identifier for given query, either uppercase string or comma joined array
	local fitstring = (type(fit)=="table" and table.concat(fit,",") or fit:upper())
	if RaceClassMatchCache[fitstring]~=nil then return RaceClassMatchCache[fitstring] end

	if type(fit)=="table" then
		for i,v in ipairs(fit) do if self:RaceClassMatch(v) then 
			-- cache both partial and full result
			RaceClassMatchCache[v] = true
			RaceClassMatchCache[fitstring] = true
			return true 
		end end
		-- cache both full result
		RaceClassMatchCache[fitstring] = false
		return false --otherwise
	end

	local _,race = UnitRace("player")
	local _,class = UnitClass("player")
	local faction = UnitFactionGroup("player")
	race=race:upper()
	class=class:upper()
	faction=faction:upper()
	fit=fit:upper()
	local neg=false
	if fit:sub(1,1)=="!" then
		neg=true
		fit=fit:sub(2)
	end

	fit=fit :gsub("UNDEAD","SCOURGE") :gsub("LFDRAENEI","LIGHTFORGEDDRAENEI") :gsub("HMTAUREN","HIGHMOUNTAINTAUREN") :gsub("ZTROLL","ZANDALARITROLL")
	local ret = (race==fit or class==fit or faction==fit or race.." "..class==fit)
	
	-- cache both full result
	RaceClassMatchCache[fitstring] = ret

	if neg then return not ret else return ret end
end




function ZGV:RaceClassMatch(fit)
	if type(fit)=="table" then
		for i,v in ipairs(fit) do if self:RaceClassMatch(v) then return true end end
		return false --otherwise
	end

	local _,race = UnitRace("player")
	local _,class = UnitClass("player")
	local faction = UnitFactionGroup("player")
	race=race:upper()
	class=class:upper()
	faction=faction:upper()
	fit=fit:upper()
	local neg=false
	if fit:sub(1,1)=="!" then
		neg=true
		fit=fit:sub(2)
	end
	local ret = (race==fit or class==fit or faction==fit or race.." "..class==fit)
	if neg then return not ret else return ret end
end

function ZGV:RaceClassMatchList(list)
	list=list..","
	local st,en=1
	for fit in list:gmatch("(.-),") do
		if self:RaceClassMatch(fit) then return true end
	end
end

--[[
local spamthrot_sec=5
local spamthrot_msgs=5
local spamthrot_last=""
local spamthrot_last_repeated=false
local spamthrot_squelch=30
local spamthrot_squelch_time=0
local spamthrot_times={}  for i=1,spamthrot_msgs do spamthrot_times[i]=0 end
local spamthrot
--]]
function ZGV:Print(s,ifdebug,force)
	if ifdebug then self:Debug(s) end

	if not force and not self.db.profile.noisy then return end

	--[[
	if not ZGV.DEV and not ZGV.db.profile.debug and not force then  -- spam throttle on clients only
		if s==spamthrot_last then
			if not spamthrot_last_repeated then
				ChatFrame1:AddMessage(L['name']..": (last message repeats)")
				spamthrot_last_repeated=true
			end
			return
		end

		spamthrot_last=s
		
		local time = time()
		if time<spamthrot_squelch_time then return end
		spamthrot_last=s
		
		for i=1,spamthrot_msgs-1 do spamthrot_times[i]=spamthrot_times[i+1] end
		spamthrot_times[spamthrot_msgs]=time
		if spamthrot_times[5]-spamthrot_times[1]<spamthrot_sec then
			ChatFrame1:AddMessage(L['name']..": "..tostring(s))  -- last one in
			ChatFrame1:AddMessage(L['name']..": "..("%d messages under %d seconds, silencing for %d seconds. Use |cffffee00/zygor noisy|r to silence permanently."):format(spamthrot_msgs,spamthrot_sec,spamthrot_squelch))
			spamthrot_squelch_time=time+spamthrot_squelch
			return
		end
	end
	--]]
	
	ChatFrame1:AddMessage(L['name']..": "..tostring(s))
end

local thunder_stack
function ZGV:ThunderStageForceUpdate()
	do return end  -- TODO: reimplement this with C_Map
	if thunder_stack then return end
	if WorldMapFrame:IsShown() and GetCurrentMapAreaID()~=928 then --Wait for them to close the map then update
		ZGV.WaitingOnThunderStage = true
		return
	end
	thunder_stack=1

	ZGV.WaitingOnThunderStage = nil

	local lastmap,lastfloor

	ZGV.WMU_Suspend()
	if GetCurrentMapAreaID()~=928 then
		lastmap,lastfloor = GetCurrentMapAreaID(),ZGV.GetCurrentMapDungeonLevel()
		SetMapByID(928) --Thunder Isle
	end

	if C_MapBar.GetTag()=="THUNDER_ISLE" then
		ZGV.db.char.thunderstage = (C_MapBar.GetPhaseIndex() + 1) or 1
		ZGV.db.char.thunderprogress = (C_MapBar.GetCurrentValue()/C_MapBar.GetMaxValue()) or 0

		--[[
		if ZGV.DEV then
			-- TEMPORARY TIMING OF THUNDER ISLE
			if not ZGV.db.global.thundertimes then ZGV.db.global.thundertimes={} end
			local val = C_MapBar.GetCurrentValue()
			if val>0 and ZGV.db.global.thunderprogress_last~=val then
				ZGV.db.global.thundertimes[time()] = val
				ZGV.db.global.thunderprogress_last=val
			end
		end
		--]]
	end

	if lastmap then SetMapByID(lastmap) SetDungeonMapLevel(lastfloor) end
	ZGV.WMU_Resume()
	thunder_stack=nil
end

function ZGV:GetThunderStage()
	if not ZGV.db.char.thunderstage or ZGV.WaitingOnThunderStage then
		ZGV:ThunderStageForceUpdate()
	end

	return (ZGV.db.char.thunderstage or 1),(ZGV.db.char.thunderprogress or 0)
end




	local function avgdev(data,basetime,progtime)
		local cnt,totaldev=0,0
		for time,prog in pairs(data) do
			cnt=cnt+1
			local dev = (time-basetime) * progtime  -  prog
			totaldev=totaldev+dev
		end
		return totaldev/cnt
	end

	function ZGV:AnalyzeThunderData(reset)
		local mintime,maxtime=9999999999,0
		local progs = ZGV.db.global.thundertimes
		if reset then wipe(progs) end
		for time,data in pairs(progs) do
			if time<mintime then mintime=time end
			if time>maxtime then maxtime=time end
		end

		local progtime=(progs[maxtime]-progs[mintime])/(maxtime-mintime)


		-- at this point,   progress = (time()-zerotime) * progtime

		local minprog,maxprog=0.01,5
		local mindev,maxdev=99999999,0

		for i=1,20 do
			progtime=(minprog+maxprog)/2
			local zerotime = mintime - progs[mintime]/progtime
			print ("progtime",progtime,"dev",avgdev(progs,zerotime,progtime))
			if avgdev(progs,zerotime,progtime)<0 then
				minprog=progtime
			else maxprog=progtime
			end
		end

		local zerotime =  mintime - progs[mintime]/progtime

		print("progress/time = ",progtime)

		local s = ""
		for t=mintime,maxtime do
			if progs[t] then
				local expected = (t-mintime) * progtime + progs[mintime]
				print("time",t,"progress",progs[t],"deviation",progs[t]-expected)
				s = s .. t .. "\t" .. progs[t] .. "\n"
			end
		end
		ZGV:ShowDump(s)

		local fulldate = zerotime + 1000000/progtime

		print("|cffffbb001000000|cff88ff00 estimated in ",fulldate," = |cffffbb00",date("%Y-%m-%d %H:%M:%S",fulldate))
	end

	function ZGV:GetThunderStageQQ()
		do return 1 end -- TODO: reimplement

		if WorldMapFrame:IsShown() and GetCurrentMapAreaID()~=928 then  -- wrong map shown! should we force it or not..?
			if ZGV.db.char.thunderstage then
				-- cached? return that
				return ZGV.db.char.thunderstage
			else
				-- FORCE. EVIL.
				SetMapByID(928) --Thunder Isle
			end
		end

		if GetCurrentMapAreaID()~=928 then return ZGV.db.char.thunderstage end  -- the best we can do, if we weren't forcing it

		local stage = (C_MapBar and C_MapBar.BarIsShown() and C_MapBar.GetPhaseIndex() + 1)  or  1

		ZGV.db.char.thunderstage = stage  -- save

		last_thunder_check = GetTime()

		return ZGV.db.char.thunderstage
	end

function ZGV:MatchProfs(fitprof,levelmin,levelmax)
	local data = self.Professions:GetSkill(fitprof)
	if not data then return false end

	if not data.active then
		return false --We don't have this profession so forget it.
	elseif data.level > 0 then --sanity check.
		return data.level>=levelmin and data.level<levelmax
	end
end

local eventtex = {
	[235485]="FEAST OF WINTER VEIL",
	[235484]="FEAST OF WINTER VEIL",
	[235482]="FEAST OF WINTER VEIL",
	[235477]="NOBLEGARDEN",
	[235476]="NOBLEGARDEN",
	[235475]="NOBLEGARDEN",
	[235474]="MIDSUMMER FIRE FESTIVAL",
	[235473]="MIDSUMMER FIRE FESTIVAL",
	[235472]="MIDSUMMER FIRE FESTIVAL",
	[235471]="LUNAR FESTIVAL",
	[235470]="LUNAR FESTIVAL",
	[235469]="LUNAR FESTIVAL",
	[235468]="LOVE IS IN THE AIR",
	[235467]="LOVE IS IN THE AIR",
	[235466]="LOVE IS IN THE AIR",
	[235465]="PILGRIM'S BOUNTY",  -- shared with HARVEST FESTIVAL
	[235464]="PILGRIM'S BOUNTY",  -- shared with HARVEST FESTIVAL
	[235463]="PILGRIM'S BOUNTY",  -- shared with HARVEST FESTIVAL
	[235462]="HALLOW'S END",
	[235461]="HALLOW'S END",
	[235460]="HALLOW'S END",
	[307365]="DAY OF THE DEAD",
	[840589]="DAY OF THE DEAD",
	[307364]="DAY OF THE DEAD",
	[235448]="DARKMOON FAIRE",
	[235447]="DARKMOON FAIRE",
	[235446]="DARKMOON FAIRE",
	[235445]="CHILDREN'S WEEK",
	[235444]="CHILDREN'S WEEK",
	[235443]="CHILDREN'S WEEK",
	[235442]="BREWFEST",
	[235441]="BREWFEST",
	[235440]="BREWFEST",
	[235457]="FIREWORKS SPECTACULAR", -- shared with "FIREWORKS CELEBRATION" on new year
	--[1129677]="PET BATTLE BONUS EVENT",
	--[1467045]="LEGION DUNGEON EVENT",
	--[1616334]="PVP BRAWL: TEMPLE OF HOTMOGU",
}

function ZGV:FindEvent(eventName)
	eventName=eventName:upper()
	local dateobject = (C_Calendar.GetDate and C_Calendar.GetDate()) or (C_DateAndTime.GetCurrentCalendarTime and C_DateAndTime.GetCurrentCalendarTime())
	local month,day,year = dateobject.month,dateobject.monthDay,dateobject.year

	local numEvents = C_Calendar.GetNumDayEvents(0, day);
	
	for event=1, numEvents do
		local eventdata = C_Calendar.GetDayEvent(0,day,event)
		if eventdata then
			local texture = eventtex[eventdata.iconTexture]
			eventdata.title=eventdata.title:upper()
			if (texture=="HARVEST FESTIVAL" and month>=11) then
				texture="PILGRIM'S BOUNTY" --Lovely work around for Harvest Festival and Pilgrim's Bounty having the same texture
			end

			if eventdata.calendarType=="HOLIDAY" --We don't care about any other events
			and eventdata.sequenceType~="END"  --If it is the last day of a holiday it ended at 2am so ignore it.
			and (eventName==eventdata.title or eventName==texture) then --Does the ring fit?
				return true
			end
		end	
	end
	return false -- Nothing else was returned, so the event is not active.
end


function ZGV:UNIT_INVENTORY_CHANGED(event,unit)
	self:UpdateFrame(true)
	if unit=="player" then
		self:TryToCompleteStep(true)
	end
end

--local MapBarLastupdate=0
function ZGV:MAP_BAR_UPDATE(event)
	--local time = GetTime();
	--if MapBarLastupdate~= time then
	--	MapBarLastupdate = time
		ZGV:ThunderStageForceUpdate()
	--end
end

-- handled in QuestTracking; duplicating it here may cause race conditions and bad quest detection
--[[
function ZGV:QUEST_LOG_UPDATE(event,unit)
	self:Debug("QUEST_LOG_UPDATE")
	self:UpdateFrame(true)
	if unit=="player" then
		self:TryToCompleteStep(true)
	end
end
--]]

local blobstate=nil
function ZGV:PLAYER_REGEN_DISABLED()
	--ZygorGuidesViewerFrame_Cover:Show()
	--ZygorGuidesViewerFrame_Cover:EnableMouse(true)
	self:UpdateCooldowns()
	if self.db.profile.hideincombat then
		if self.Frame:IsVisible() then
			ZGV.UIFrameFade.UIFrameFadeOut(self.Frame,0.5,1.0,0.0)
			self.hiddenincombat = true
		end

		--[[ CreatureViewer removal, 7.0
		if self.CV.Frame:IsVisible() then
			ZGV.UIFrameFade.UIFrameFadeOut(self.CV.Frame,0.5,1.0,0.0)
			self.cvhiddenincombat = true
		end
		--]]
	end
--[[
	blobstate = WorldMapBlobFrame:IsShown()
	WorldMapBlobFrame:SetParent(nil)
	--WorldMapBlobFrame:ClearAllPoints()
	WorldMapBlobFrame:Hide()
	WorldMapBlobFrame.Hide = function() blobstate=nil end
	WorldMapBlobFrame.Show = function() blobstate=true end
--]]
end

function ZGV:UPDATE_VEHICLE_ACTIONBAR()
	self:SetActionButtons()
end

function ZGV:PLAYER_REGEN_ENABLED()
	--ZygorGuidesViewerFrame_Cover:Hide()
	--ZygorGuidesViewerFrame_Cover:EnableMouse(false)
	if self.CurrentStep then self.CurrentStep:PrepareCompletion(true) end
	self:UpdateFrameCurrent()
	self:UpdateCooldowns()
	self:SetActionButtons()

	if self.hiddenincombat then
		ZGV.UIFrameFade.UIFrameFadeIn(self.Frame,0.5,0.0,1.0)
		self.hiddenincombat = nil
	end

	--[[ CreatureViewer removal, 7.0
	if self.cvhiddenincombat then
		ZGV.UIFrameFade.UIFrameFadeIn(self.CV.Frame,0.5,0.0,1.0) --This will fade the creature viewer to the same level as the window. Not a bad thing imo
		self.cvhiddenincombat = nil
	end
	--]]

	self:UpdateLocking()
--[[
	WorldMapBlobFrame:SetParent(WorldMapFrame)
	--WorldMapBlobFrame:SetAllPoints(WorldMapDetailFrame)
	WorldMapBlobFrame.Hide = nil
	WorldMapBlobFrame.Show = nil
	if blobstate then WorldMapBlobFrame:Show() end
--]]
	if self.call_after_combat then self.call_after_combat() self.call_after_combat=nil end
end

function ZGV:SPELL_UPDATE_COOLDOWN()
	--self:Debug("Updating cooldowns")
	self:UpdateFrameCurrent()
	self:UpdateCooldowns()
end

function ZGV:PLAYER_CONTROL_GAINED()
	GetRealZoneText()
	self:TryToCompleteStep(true)
	self:CacheCurrentMapID()
end

function ZGV:WORLD_MAP_UPDATE()
	self:CacheCurrentMapID()
	self:CachePOIs()
end

function ZGV:NEW_WMO_CHUNK()
	-- if not WorldMapFrame:IsVisible() then ZGV.WMU_Suspend() SetMapToCurrentZone() ZGV.WMU_Resume() end  -- force map reset, otherwise floor numbers will still be wrong  -- TODO: reimplement with C_Map? maybe? maybe not?
	self:CacheCurrentMapID()
end

function ZGV:PLAYER_ENTERING_WORLD()
	self:Debug("PLAYER_ENTERING_WORLD! Let's go!")
	self.loading_screen_disabled=true
	self:CacheCurrentMapID()
end

function ZGV:ZONE_CHANGED_INDOORS()
	-- if not WorldMapFrame:IsVisible() then ZGV.WMU_Suspend() SetMapToCurrentZone() ZGV.WMU_Resume() end   -- TODO: reimplement with C_Map? maybe? maybe not?
	self:CacheCurrentMapID()
end

function ZGV:ZONE_CHANGED()
	self:CacheCurrentMapID()
end

function ZGV:ZONE_CHANGED_NEW_AREA()
	-- if not WorldMapFrame:IsVisible() then ZGV.WMU_Suspend() SetMapToCurrentZone() ZGV.WMU_Resume() end   -- TODO: reimplement with C_Map? maybe? maybe not?
	self:CacheCurrentMapID()
end

function ZGV:TAXIMAP_OPENED()
	if self.db.profile.autotaxi and self.CurrentStep then
		local destination
		for gi,goal in ipairs(self.CurrentStep.goals) do
			--if goal.action=="fly" and goal.map==ZGV.CurrentMapID then

			if goal.action=="fly" then
				destination = goal.landing
				break
			end
		end
		if destination then
			self:Debug("Autotaxi destination: "..destination)
			local dest_i
			for i=1,NumTaxiNodes() do
				if TaxiNodeName(i):find(destination)==1 then
					dest_i=i
					destination = TaxiNodeName(i)
					break
				end
			end
			if not dest_i then
				self:Debug("Cannot fly to "..destination..": destination not found on map.")
			elseif TaxiNodeGetType(dest_i)~="REACHABLE" then
				self:Print("Cannot fly to "..destination..": destination unreachable.")
			elseif TaxiNodeCost(dest_i)>GetMoney() then
				self:Print("Cannot fly to "..destination..": not enough money.")
			else
				-- finally!
				self:Print("Taking taxi to ".. TaxiNodeName(dest_i)..".")
				TakeTaxiNode(dest_i)
			end
		end
	end
end

ZGV.CurrentMapID,ZGV.CurrentMapFloor = 0,0

function ZGV:CacheCurrentMapID()
	if not self.loading_screen_disabled then return end

	local _,_,m,f=LibRover:GetPlayerPosition()
	if m and m~=0 then
		ZGV.CurrentMapID,ZGV.CurrentMapFloor = m,f
	end
	-- HBD migration snip: various astrolabe stupidity workarounds
end

function ZGV:FindData(array,what,data)
	if not (type(array)=="table") then return nil end
	local i,d
	for i,d in pairs(array) do if d[what]==data then return d end end
end

function ZGV:Frame_OnShow()
	if ZGV.initialized then PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN) end
	self:Debug("ZGV:Frame_OnShow")
	--ZygorGuidesViewerFrame_Filter()
	--[[
	if UnitFactionGroup("player")=="Horde" then
		ZygorGuidesViewerFrameTitleAlliance:Hide()
	else
		ZygorGuidesViewerFrameTitleHorde:Hide()
	end
	--]]

	if ZGV.Poi then WorldMapFrame:AddDataProvider(ZGV.Poi.DataProvider) end

	if self.CurrentStep then
		self.db.profile.enable_viewer = true
		self:UpdateFrame(true)
		self:AlignFrame()

		if self.db.profile.hidearrowwithguide then
			self:ShowWaypoints()
		end

		--[[ CreatureViewer removal, 7.0
		-- Trying to show the modelviewer frame
		-- During startup operation we may be shown numerous times,
		-- so let's make sure we're trying to do a nice thing
		if self.db.profile.mv_enabled and self.CV then
			self:TryToDisplayCreature(true)
		end
		--]]
	end
end

function ZGV:Frame_OnHide()
	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
	self.db.profile.enable_viewer = false

	if not InCombatLockdown() then
		for j=1,#self.stepframes do
			for i=1,LINES_PER_STEP do if self.actionbuttons[j] and self.actionbuttons[j][i] then
				self.actionbuttons[j][i]:Hide()
				self.petactionbuttons[j][i]:Hide()
				self.actionbuttons[j][i].cd:Hide()
			end end
		end
	end

	--[[

	-- this is a HELL ugly hack.
	-- "Do not hide when it's the World Map that hid us".
	if not WorldMapFrame.blockWorldMapUpdate -- this would mean we're enlarging the small map
	and not debugstack():find("TOGGLEWORLDMAP") -- UGLY hack
	then
		if self.db.profile.hidearrowwithguide then
			self:Debug("Hiding arrow with guide")
			self:ShowWaypoints("clear")
		end

		-- if modelviewer is on, also hide it as well
		if self.CV.Frame:IsShown() then
			self:Debug("Hiding modelviewer with guide.")
			self.CV:Hide()
		end
	end
	--]]

	--[[ CreatureViewer removal, 7.0
	if self.CV then self.CV:Hide() end
	--]]
end

function ZGV:SetStepFocus(step)

	if step.isFocused or (step:IsCurrentlySticky() and ZGV.CurrentStep.isFocused) then return end  -- no change.

	-- defocus everything
	if ZGV.CurrentGuide and ZGV.CurrentGuide.steps then
		for i,v in pairs(ZGV.CurrentGuide.steps) do
			v.isFocused = false
		end
	end

	if step.is_sticky then
		step = ZGV.CurrentStep
	end
	

	step.isFocused = true
	
	self:Debug("Focus changed to step %s (%s)",step.num, "guide")
	
	
	if ZGV.focusedguide ~= step.parentGuide then 
	-- if we changed guide, then force refresh, otherwise refresh was triggered somewhere else already
		ZGV.focusedguide = step.parentGuide
		ZGV:UpdateFrame()
	end
	
	--ZGV:ShowWaypoints()  -- will be done later anyway, no need
end

function ZGV:IsStepFocused(step)
	if step.isFocused then return true end
	if ZGV.CurrentStep.isFocused and step:IsCurrentlySticky() then return true end
	return false
end


function ZGV:GetFocusedStep()
	if ZGV.CurrentStep and ZGV.CurrentStep.isFocused then
		return ZGV.CurrentStep
	else
		return nil
	end	
end

ZGV.GoalClickedTime = GetTime()

function ZGV:GoalOnClick(goalframe,button)
	--timer is a hack to make sure multiple consecutive goals arent clicked
	--at the same time. 0.2 seconds between clicks distinguishes between humans
	local curTime = GetTime()
	if curTime - self.GoalClickedTime < 0.2 then  return  end
	self.GoalClickedTime = curTime
	goalframe = goalframe:GetParent()
	local stepframe = goalframe:GetParent()
	local goal = goalframe.goal or goalframe.tipgoal

	if not goal then return end

	if not goal.parentStep.isFocused then 
		return 
	end

	if self.db.profile.showcountsteps>0 and stepframe.step~=self.CurrentStep and not stepframe.is_sticky then return end -- no clicking on non-current steps in compact mode
	
	--if stepframe:GetScript("OnClick") then stepframe:GetScript("OnClick")(stepframe,button) end

	--local num=goalframe.goalnum
	self:Debug("goal clicked, step %s goal %s ",goal.parentStep.num,goal.num)
	--local goal = self.CurrentStep.goals[num]

	--if button=="LeftButton" and not goal.parentStep.isFocused then ZGV:SetStepFocus(goal.parentStep) end -- grab focus for clicked step

	if button=="LeftButton" and not goal.parentStep.isFocused then return end -- don't act if we are not focused

	if button=="LeftButton" then
		goal:OnClick(button)
	else
		ZGV:OpenQuickStepMenu(stepframe,goalframe)
	end
end

function ZGV:GoalOnEnter(goalframe)
	local goal = goalframe:GetParent().goal or goalframe:GetParent().tipgoal
	if not goal then return end

	local step = goal.parentStep

	if not step.isFocused or step:IsCurrentlySticky() then 
		return 
	end

	local wayline,infoline,image

	if goal.tooltip and not self.db.profile.tooltipsbelow then
		infoline = "|cff00ff00"..goal.tooltip.."|r"
	end
	local tooltipline = goal:GetTooltip()
	if goal.x and goal.y and goal.map then
		-- if locked or force_noway, then no clicking, bare info.
		local tipformat = (self.db.profile.windowlocked or goal.force_noway) and 'tooltip_waypoint_coords' or 'tooltip_waypoint'
		local coords = math.round(goal.x*100)..";"..math.round(goal.y*100)
		local map = (ZGV.GetMapNameByID(goal.map) or ('#'..goal.map)).." "
		wayline = L[tipformat]	:format(goal.waytitle and (goal.waytitle.." ("..map..coords..")") or map..coords)
	end

	if goal.image then
		image = DIR.."\\Images\\"..goal.image..".tga"
	end

	if infoline or wayline or image or goal.itemid or tooltipline then
		GameTooltip:SetOwner(self.Frame,"ANCHOR_BOTTOM") --GameTooltip moved above the Viewer
		GameTooltip:ClearAllPoints()
		--[[
		GameTooltip:ClearAllPoints()
		GameTooltip:SetOwner(goalframe,"ANCHOR_TOP") --GameTooltip moved above the goal. Cursor overlaps it when it's below.
		--]]
		--GameTooltip:SetOwner(goalframe,"ANCHOR_TOPLEFT")
		--GameTooltip:SetPoint("BOTTOM",goalframe,"TOP")

		if goal.itemid then
			GameTooltip:SetOwner(goalframe,"ANCHOR_LEFT") -- Items tooltip to the left of the line
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOMRIGHT",goalframe,"TOPLEFT")

			GameTooltip:SetHyperlink("item:"..goal.itemid)
			--else
			--	GameTooltip:SetText(goal:GetText())
		end

		local lines={}

		local lines=1
		if infoline then  GameTooltip:AddLine(infoline,1,1,1)  lines=lines+1  end
		if wayline then  GameTooltip:AddLine(wayline,1,1,1)  lines=lines+1  end
		if tooltipline then  GameTooltip:AddLine(tooltipline,1,1,1)  lines=lines+1  end

		for line=1,lines do  if _G['GameTooltipTextLeft'..line]:GetWidth()>300 then _G['GameTooltipTextLeft'..line]:SetWidth(300) end  end
		GameTooltip:Show()

		if image then
			local img

			--[[
			local img = _G['GameTooltipZygorImage']
			if not img then
				img = GameTooltip:CreateTexture("GameTooltipZygorImage","ARTWORK")
			end
			--]]
			img = GameTooltipTexture1
			GameTooltip:AddLine(" ")
			GameTooltip:AddTexture(image)
			img:ClearAllPoints()
			img:SetPoint("TOPLEFT",_G['GameTooltipTextLeft'..lines],"BOTTOMLEFT")
			--img:SetTexture(image)
			img:SetWidth(128)
			img:SetHeight(128)
			img:Show()
			GameTooltip:Show()
			GameTooltip:SetHeight(150 + lines*20)
		end
	end

	if (IsModifiedClick("DRESSUP") and goal.itemid and IsDressableItem("item:"..goal.itemid)) then
		ShowInspectCursor()
	else
		ResetCursor()
	end
end

function ZGV:GoalOnLeave(goalframe,num)
	if goalframe and (GameTooltip:GetOwner()==goalframe or GameTooltip:GetOwner()==self.Frame) then GameTooltip:Hide() end
end


local function insert_guides(arr,guides)
	local data
	for i,guide in ipairs(guides) do
		data = ZGV:GetGuideByTitle(guide.full)
		local item = {
			text = guide.step and L['menu_last_entry']:format(guide.short or "?",guide.step) or (guide.short or "?"),
			checked = function() return ZGV.CurrentGuideName==guide.full end,
			func = function()  CloseDropDownMenus()  ZGV:SetGuide(guide.full,guide.step) end,
			tooltipTitle = data and data.description and guide.short,
			tooltipText = data and data.description,
			tooltipOnButton = true,
		}
		tinsert(arr,item)
	end
end

local function group_to_array(group)
	local arr = {}
	for i,group in ipairs(group.groups) do
		local item = {
			text = group.name,
			hasArrow = true,
			menuList = group_to_array(group),
			keepShownOnClick = true,
			func = function(self) _G[self:GetName().."Check"]:Hide() end,
			--notCheckable = true
		}
		--if #item.menuTable>0 then
			tinsert(arr,item)
		--end
	end
	insert_guides(arr,group.guides)
	return arr
end

function ZGV:GetMostRecentGuide(gtype)
	local guides = self.db.char.guides_history[gtype]
	if guides and guides[1] then
		local firstguide = guides[1]
		local g = self:GetGuideByTitle(firstguide[1])
		if g then
			g.CurrentStepNum = firstguide[2]
			return g

		end
		return unwrapped
	end
	return nil

end

-- RETIRE AFTER NEW MENU
function ZGV:GetGuidesHistory(gtype)
	local unwrapped={}
	for gi,guide_and_step in ipairs(self.db.char.guides_history) do
		if not gtype or guide_and_step[1]:find(gtype.."\\",1,1)==1 then
			local g = self:GetGuideByTitle(guide_and_step[1])
			if g then
				g.CurrentStepNum = guide_and_step[2]
				tinsert(unwrapped,g)
			end
		end
	end
	return unwrapped
end

function ZGV:OpenGuideMenu(path)
	if self.Menu then 
		if path=="HOME" and ZGV.CurrentGuide and not ZGV.CurrentGuideName:match("GOLD\\") and not ZGV.CurrentGuideName:match("PETSMOUNTS\\Pets") then
			ZGV.GuideMenu:Show()
			ZGV.GuideMenu:Open("Current")
			return
		end
		ZGV.GuideMenu:Show(path)
	end
end

function ZGV:FakeCompleteGoal(goal,docomplete)
	if docomplete==nil then docomplete=not self.recentlyCompletedGoals[goal] end
	if docomplete then
		--self.recentlyCompletedGoals[goal]=true
		self.recentlyStickiedGoals[goal]=true
	else
		self.recentlyCompletedGoals[goal]=false
		self.recentlyStickiedGoals[goal]=false
		self.recentlyVisitedCoords[goal]=false
	end
	--goal.fake_complete = true
	self.pause=nil
	self.LastSkip=1
	--self.AutoskipTemp = true
	self:TryToCompleteStep(true)
end

function ZGV:FakeCompleteQuest(questid,docomplete,questtitle)
	self.completedQuests[questtitle]=docomplete
	if questid then self.completedQuests[questid]=docomplete end
	self:Print("Marking quest '"..questtitle.."'"..(questid and " (#"..questid..")" or "").." as "..(docomplete and "completed" or "incomplete"))
	self:TryToCompleteStep(true)
end

function ZGV:OpenMapToQuest(questid)
	if self.questsbyid[questid] and WorldMap_OpenToQuest then -- 3.3.0
		WorldMap_OpenToQuest(questid)
		local done,posX,posY,obj = QuestPOIGetIconInfo(questid)
		if posX or posY then
			local q = self.questsbyid[questid]
			local title
			if q then title=q.title end
			self:Debug("Setting waypoint to POI: "..posX.." "..posY)
			self.Pointer:SetWaypoint(nil,nil,posX*100,posY*100,{title=title,type="manual"})
		end
	end
end

function ZGV:FindNextActiveQuest()
	if not self.CurrentGuide then return end
	for stepnum=self.CurrentStep.num+1,#self.CurrentGuide.steps do
		local step=self.CurrentGuide.steps[stepnum]
		if not step then break end
		for gi,goal in ipairs(step.goals) do
			if goal.questid and PlayerIsOnQuest(goal.questid) then
				self:FocusStep(stepnum)
				return
			end
		end
	end
	self:Print("No steps found that match quests in your log.")
end

local lastquestid,lastquesttitle
local showqiretries=0
--[[
function ZGV:ShowQuestInfo(questid,questtitle,indump)
	self:Debug("Showing chains for "..tostring(questid).." '"..tostring(questtitle).."'")
	if not questid then questid=lastquestid questtitle=lastquesttitle else showqiretries=0 end
	lastquestid=questid lastquesttitle=questtitle showqiretries=showqiretries+1

	--if InCombatLockdown() then return end
	local max = self.maxQuestLevels[questid] or -1
	local lev = self.mentionedQuests[questid] or -1
	local col = GetQuestDifficultyColor(lev)
	local s
	if (max>lev) then
		s = ("Quest |cff%02x%02x%02x[|Hquest:%d:%d|h%s|h]|r (#%d) [level %s + chains to %s]"):format(col.r*255,col.g*255,col.b*255,questid,UnitLevel("player"),questtitle,questid,lev>0 and lev or "?",max>0 and max or "?")
	else
		s = ("Quest |cff%02x%02x%02x[|Hquest:%d:%d|h%s|h]|r (#%d) [level %s]"):format(col.r*255,col.g*255,col.b*255,questid,UnitLevel("player"),questtitle,questid,lev>0 and lev or "?")
	end

	local pre = self.Chains[questid]
	if pre then
		if type(pre)=="number" then
			s = s .. "\nPrerequisite:"
			pre={"",pre}
		else
			s = s .. "\nPrerequisites ("..(pre[1]=="AND" and "ALL" or "ANY").."):"
		end
		for i=2,#pre do
			local id = tonumber(pre[i])
			local quest,inlog = self.Localizers:GetQuestData(id)
			lev = self.mentionedQuests[id] or -1
			local caching=nil
			if (quest and not caching) then
				col = GetQuestDifficultyColor(lev)
				s=s..("\n- |cff%02x%02x%02x[|Hquest:%d:%d|h%s|h]|r (#%d) [level %s]"):format(col.r*255,col.g*255,col.b*255,id,UnitLevel("player"),quest.title,id,lev>0 and lev or "?")
			else
				if showqiretries<5 then
					if showqiretries==1 then self:Print("Retrieving quest information, please wait...") end
					self:ScheduleTimer("ShowQuestInfo",1) return
				else
					s=s.."\n- #"..id.." (retrieving quest information, please try again)"
					caching=true
				end
			end
		end
	end
	local mentioned = self:GetMentionedFollowups(questid)
	local q
	if #mentioned>1 then
		q = "Follow-ups:"
		for i=2,#mentioned do
			local id = tonumber(mentioned[i][1])
			local quest = self.Localizers:GetQuestData(id)
			lev = mentioned[i][2]
			local caching=nil
			if (quest and not caching) then
				col = GetQuestDifficultyColor(lev)
				q=q..("\n- |cff%02x%02x%02x[|Hquest:%d:%d|h%s|h]|r (#%d) [level %s]"):format(col.r*255,col.g*255,col.b*255,id,UnitLevel("player"),quest.title,id,lev>0 and lev or "?")
			else
				if showqiretries<5 then
					if showqiretries==1 then self:Print("Retrieving quest information, please wait...") end
					self:ScheduleTimer("ShowQuestInfo",1) return
				else
					q=q.."\n- #"..id.." (retrieving quest information, please try again)"
					caching=true
				end
			end
		end
	else
		q = "No follow-ups."
	end

	local rem=""
	local remaining = self:GetQuestRemainingInChain(questid)
	if remaining then
		rem = "\n\n"..remaining.." quests remain till end of chain."
	end

	if indump then
		self:ShowDump(s.."\n"..q..rem,"Quest information",false)
	else
		self:Print("Quest information:")
		local ss = s.."\n"..q..rem
		local sslines = {strsplit("\n",ss)}
		for i,l in ipairs(sslines) do print(l) end
	end
end

function ZGV:ToggleWatchQuest(questid)
end
--]]

function ZGV:OpenQuickStepMenu(stepframe,goalframe)
	local ZGVFMenu = ZGV.CurrentSkin.name=="Default" and ZGVF_Default_Menu or ZGVF_Default_Menu
	ZGVFMenu.stepframe=stepframe
	ZGVFMenu.goalframe=goalframe

	local step = stepframe.step
	local goal = goalframe.goal or goalframe.tipgoal

	local menu = {
		{
			text = L['qmenu_step']:format(step.num,step.level or "?"),
			isTitle = true,
			notCheckable=true,
		}
	}
	tinsert(menu,{
		text = L['qmenu_step_skip'],
		tooltipTitle = L['qmenu_step_skip'],
		tooltipText = L["qmenu_step_skip_desc"],
		tooltipOnButton = true,
		func = function() self:SkipStep(true) end,
		--icon = ZGV.DIR .. "\\Skins\\minimaparrow-green-dot",
		keepShownOnClick = false,
	})


	if goal:IsCompleteable() or (goal.map and goal.x) then
		tinsert(menu,{
			text = L['qmenu_goal']:format(goal:GetText():gsub("%|r",""):gsub("%|c........","")),
			isTitle = true,
			notCheckable=true,
		})
	end

	if goal.map and goal.x then
		local map = ZGV.GetMapNameByID(goal.map) or ('#'..goal.map)
		tinsert(menu,{
			text = L['qmenu_goal_waypoint']:format(map,goal.x*100,goal.y*100),
			tooltipTitle = L['qmenu_goal_waypoint']:format(map,goal.x*100,goal.y*100),
			tooltipText = L['qmenu_goal_waypoint_desc'],
			tooltipOnButton = true,
			func = function()  self.Pointer:CycleWaypointTo(goal)  end,
			isNotRadio=true,
		})
	end

	--[[ CreatureViewer removal, 7.0
		local id = goal.npcid or (goal.mobs and goal.mobs[1] and goal.mobs[1].id) or (goal.action=="kill" and goal.targetid)
		if id then
			local name = self.Localizers:GetTranslatedNPC(id) or "(creature)"
			tinsert(menu,{
				text = L['qmenu_goal_creature_data']:format(name),
				tooltipTitle = L['qmenu_goal_creature'],
				tooltipTitleText = L['qmenu_goal_creature_desc']:format(name),
				tooltipOnButton = true,
				func = function()
					self.db.profile.viewcreature=true
					self.CreatureViewer:ShowCreature(id,name)
					if self.CreatureViewer.failed then
						self:Print("Creature is not yet available - too far.")
					end
				end,
				--Try both and hopefully one works.
				isNotRadio=true,
			})
		end
	--]]

	if goal:IsCompleteable() then
		tinsert(menu,{
			text = L['qmenu_goal_complete'],
			tooltipTitle = L['qmenu_goal_complete'],
			tooltipText = L['qmenu_goal_complete_desc'],
			tooltipOnButton = true,
			checked = function()  return goal:IsComplete()  end,
			func = function()  self:FakeCompleteGoal(goal,not self.recentlyCompletedGoals[goal])  end,
			isNotRadio=true,
		})
		if goal.quest then
			local quest,inlog = self.Localizers:GetQuestData(goal.quest.id)
			local title = quest and quest.title or "?"
			tinsert(menu,{
				text = L['qmenu_quest']:format(title),
				isTitle = true,
				notCheckable = true,
			})
			--[[
			-- no quest info anymore
			tinsert(menu,{
				text = L['qmenu_quest_info']:format(title),
				tooltipTitle = L['qmenu_quest_info']:format(title),
				tooltipText = L['qmenu_quest_info_desc'],
				tooltipOnButton = true,
				func = function() self:ShowQuestInfo(goal.quest.id,title,IsShiftKeyDown())  end,
			})
			--]]
			if inlog then
				local ind=goal.quest.index
				tinsert(menu,{
					text = L['qmenu_quest_openlog'],
					tooltipTitle = L['qmenu_quest_openlog'],
					tooltipText = L['qmenu_quest_openlog_desc'],
					tooltipOnButton = true,
					func = function() QuestMapFrame_OpenToQuestDetails(goal.quest.id) end,
				})
				tinsert(menu,{
					text = L['qmenu_quest_watched'],
					tooltipTitle = L['qmenu_quest_watched'],
					tooltipText = L['qmenu_quest_watched_desc'],
					tooltipOnButton = true,
					checked = function() return IsQuestWatched(ind) end,
					func = function()
						if IsQuestWatched(ind) then
							RemoveQuestWatch(ind)
							--WatchFrame_Update()
						else
							if ( GetNumQuestWatches() < MAX_WATCHABLE_QUESTS ) then
								AddQuestWatch(ind)
								--WatchFrame_Update()
							end
						end
					end,
					isNotRadio=true,
				})
				local quest_map = GetQuestUiMapID and GetQuestUiMapID(goal.quest.id)
				if quest_map and quest_map>0 then
					tinsert(menu,{
						text = L['qmenu_quest_openmap'],
						tooltipTitle = L['qmenu_quest_openmap'],
						tooltipText = L['qmenu_quest_openmap_desc'],
						tooltipOnButton = true,
						func = function()  OpenWorldMap(quest_map)  ZGV:PointToQuest(quest_map,goal.quest.id)  end,
					})
				end
			end

			-- woo, LightHeaded support!
			if LightHeaded then
				tinsert(menu,{
					text = L['qmenu_quest_lightheaded'],
					tooltipTitle = L['qmenu_quest_lightheaded'],
					tooltipText = L['qmenu_quest_lightheaded_desc'],
					tooltipOnButton = true,
					func = function()
						if IsShiftKeyDown() then
							local s = LightHeaded:GetPageText(goal.quest.id)
							self:ShowDump(s,"Quest info - courtesy of LightHeaded",false)
						else
							ShowUIPanel(QuestLogFrame)
							LightHeaded:UpdateFrame(goal.quest.id, LightHeaded.db.profile.singlepage and -1 or 1)
						end
					end,
				})
			end

			if self.db.profile.debug then
				tinsert(menu,{
					text = "(debug) force quest complete",
					tooltipTitle = self.completedQuests[goal.questid] and L['qmenu_quest_complete_tip'] or L['qmenu_quest_complete_in_tip'],
					tooltipText = self.completedQuests[goal.questid] and L['qmenu_quest_complete_desc'] or L['qmenu_quest_complete_in_desc'],
					checked = function()  return self.completedQuests[goal.questid]  end,
					func = function()  self:FakeCompleteQuest(goal.questid,not self.completedQuests[goal.questid],goal.quest.title)  end,
					isNotRadio=true,
				})
				tinsert(menu,{
					text = "(debug) trace quest log changes for this quest",
					checked = function()  return self.DEBUG_QUEST_ID==goal.questid  end,
					func = function()  if self.DEBUG_QUEST_ID==goal.questid then self.DEBUG_QUEST_ID=nil self:Debug("Not tracing.") else self.DEBUG_QUEST_ID=goal.questid self:Debug("Tracing quest %d",goal.questid) end end,
					isNotRadio=true,
				})
			end
			--[[
			tinsert(menu,{
				text = L['qmenu_quest_complete'],
				tooltipTitle = self.completedQuests[goal.quest.id] and L['qmenu_quest_complete_tip'] or L['qmenu_quest_complete_in_tip'],
				tooltipText = self.completedQuests[goal.quest.id] and L['qmenu_quest_complete_desc'] or L['qmenu_quest_complete_in_desc'],
				checked = function()  return self.completedQuests[goal.quest.id]  end,
				func = function()  self:FakeCompleteQuest(goal.quest.id,not self.completedQuests[goal.quest.id],goal.quest.title)  end,
				isNotRadio=true,
			})
			--]]
		end
	end
	if self.borderfadedout and not self.db.profile.delayshowborder then
		tinsert(menu,{
			text = L['opt_group_display'],
			isTitle = true,
			notCheckable=true,
		})
		tinsert(menu,{
			text = L['qmenu_border_restore'],
			tooltipTitle = L['qmenu_border_restore'],
			tooltipText = L['qmenu_border_restore_desc'],
			tooltipOnButton = true,
			--checked = function()  return self.db.profile.hideborder  end,
			func = function()  
				ZGV:Guides_Mini_to_Full()
				end,
			isNotRadio=true,
		})
	end

	tinsert(menu,{
		text = L['qmenu_shareto'],
		hasArrow = true,
		menuList = {
			{ text = L['qmenu_shareto_party'], checked = function() return self.db.profile.share_target=="PARTY" end, func = function() self.db.profile.share_target="PARTY"  CloseDropDownForks() end },
			{ text = L['qmenu_shareto_raid'], checked = function() return self.db.profile.share_target=="RAID" end, func = function() self.db.profile.share_target="RAID" CloseDropDownForks() end },
			{ text = L['qmenu_shareto_say'], checked = function() return self.db.profile.share_target=="SAY" end, func = function() self.db.profile.share_target="SAY" CloseDropDownForks() end },
		}
	})

	local rolegoals
	for i,g in ipairs(step.goals) do  if g.grouprole then   rolegoals=true  break  end end
	if rolegoals then
		tinsert(menu,{
			text = L['qmenu_share_allgrouproles'],
			func = function() step:ShareToChat(self.db.profile.share_target or "SAY","rolegoals","brand") end,
		})
	end

	--[[
		{
			text = L['opt_miniresizeup'],
			tooltipTitle = L['opt_miniresizeup'],
			func = function() self:SetOption("Display","resizeup") end,
			checked = function() return self.db.profile.resizeup end,
			isNotRadio=true,
			keepShownOnClick = true,
		},
		{
			text = L['opt_hideincombat'],
			tooltipTitle = L['opt_hideincombat'],
			tooltipText = L['opt_hideincombat_desc'],
			checked = function()  return self.db.profile.hideincombat  end,
			func = function()  self:SetOption("Display","hideincombat")  end,
			isNotRadio=true,
			keepShownOnClick = true,
		},
		{
			text = L['opt_configuration'],
			tooltipTitle = L['opt_configuration'],
			tooltipText = L['opt_configuration_desc'],
			isNotRadio=true,
			notCheckable=true,
			func = function()  self:OpenOptions()  end,
		},
		{
			name = L['opt_group_step'],
			isTitle = true,
		},
		{
			text = L["opt_do_searchforgoal"],
			notCheckable = true,
			func = function() ZGV:SearchForCompleteableGoal() end
		}
	--]]

	tinsert(menu,{
		text = L['qmenu_close'],
		hasArrow = false,
		func = function()  CloseDropDownForks() end,
	})

	EasyFork(menu,ZGVFMenu,goalframe:GetName(),0,0,"MENU",3)  -- replacement for EasyMenu, just not as insecure.
end

--[[
function ZGV:OpenQuickSteps()
	local menu = {
		{
			text=L["opt_showcountsteps"],
			isTitle = true,
			notCheckable = true,
		},
		{
			text=L["opt_showbriefsteps"],
			func=function() self:SetOption("Step","showbriefsteps") end,
			checked=function() return self.db.profile.showbriefsteps end,
			isNotRadio = true,
		},
		{
			text=L["opt_showcountsteps_all"],
			func=function() self:SetOption("Step","showcountsteps 0") end,
			checked=function() return self.db.profile.showallsteps end,
		},
		{
			text='1',
			func=function() self:SetOption("Step","showcountsteps 1") end,
			checked=function() return not self.db.profile.showallsteps and self.db.profile.showcountsteps==1 end,
		},
		{
			text='2',
			func=function() self:SetOption("Step","showcountsteps 2") end,
			checked=function() return not self.db.profile.showallsteps and self.db.profile.showcountsteps==2 end,
		},
		{
			text='3',
			func=function() self:SetOption("Step","showcountsteps 3") end,
			checked=function() return not self.db.profile.showallsteps and self.db.profile.showcountsteps==3 end,
		},
		{
			text='4',
			func=function() self:SetOption("Step","showcountsteps 4") end,
			checked=function() return not self.db.profile.showallsteps and self.db.profile.showcountsteps==4 end,
		},
		{
			text='5',
			func=function() self:SetOption("Step","showcountsteps 5") end,
			checked=function() return not self.db.profile.showallsteps and self.db.profile.showcountsteps==5 end,
		},
	}

	ZGVFMenu.onHide = function()
		ZGVFMenu.stepframe=nil
		ZGVFMenu.goalframe=nil
	end

	EasyFork(menu,ZGVFMenu,"cursor",0,0,"MENU",3)
end
--]]

function ZGV:OpenMapToQuestGoal(questid,goalnum)
end

local function split(str,sep)
	local fields = {}
	str = str..sep
	str:gsub("(.-)"..sep, function(c) tinsert(fields, c) end)
	return fields
end

function ZGV:FindOrCreateGroup(group,title)
	local path = split(title,"\\")

	-- create one
	local partialpath
	for i=1,#path do
		local found = false
		for n,gr in ipairs(group.groups) do
			if gr.name==path[i] then
				found=true
				group=gr
			end
		end
		partialpath = (partialpath and partialpath.."\\" or "") .. path[i]
		if not found then
			local gr = {name=path[i],fullpath=partialpath,groups={},guides={},ord=#group.groups+1}
			tinsert(group.groups,gr)
			if i==1 then  -- we're at top level
				SortGroups(group, false and "no recurse")
				self:SendMessage("ZGV_LOADING_TOPLEVEL_GROUPS_UPDATED")
			end
			group=gr
		end
	end
	return group
end

-- IN: "Zygor's Alliance Leveling Guides"
-- OUT: "Leveling"
function ZGV:SanitizeGuideTitle(title)
	if not title then return end
	title = title:gsub([[\\]],[[\]])
	title = title :gsub("^Zygor's ","")
	title = title :gsub("^Alliance ","") :gsub("^Horde ","")  -- code-side fix for "common" guides.
	--title = title :gsub(" Guide$","") :gsub(" Guides$","")

	-- fix old-style guide paths
	title = title
		:gsub("^Event.-\\","EVENTS\\")
		:gsub("^Dail.-\\","DAILIES\\")
		:gsub("^Leveling.-\\","LEVELING\\")
		:gsub("^Loremaster.-\\","LOREMASTER\\")
		:gsub("^Profession.-\\","PROFESSIONS\\")
		:gsub("^Achievement.-\\","ACHIEVEMENTS\\")
		:gsub("^Pet.-\\","PETSMOUNTS\\")
		:gsub("^Reputation.-\\","REPUTATIONS\\")
		:gsub("^Title.-\\","TITLES\\")
		:gsub("^Macro.-\\","MACROS\\")
		:gsub("^Dungeon.-\\","DUNGEONS\\")
		:gsub("^Gear.-\\","GEAR\\")
		:gsub("^Test Guide.-\\","TEST\\")
		:gsub("^Misc.-\\","MISC\\")

	return title
end

function ZGV:GetShortGuideTitle(longtitle)
	local sane = ZGV:SanitizeGuideTitle(longtitle)
	return sane:match("([^\\]*)$") or longtitle
end

function ZGV:RegisterGuide(title,header,data)
	title = self:SanitizeGuideTitle(title)

	local guide = ZGV.GuideProto:New(title,header,data)

	if ZGV.BETAguides and guide then guide.beta=true end

	tinsert(self.registeredguides,guide)
end

function ZGV.BETASTART()
	ZGV.BETAguides=true
end
function ZGV.BETAEND()
	ZGV.BETAguides=false
end

ZGV.registered_mapspotset_groups = { groups={},guides={}}

function ZGV:RegisterMapSpots(title,data)
	local group,tit = title:match("^(.*)\\+(.-)$")
	if group then
		group = self:FindOrCreateGroup(self.registered_mapspotset_groups,group)
	else
		group = self.registered_mapspotset_groups
	end

	local set = self.MapSpotSetProto:NewRaw(title,tit or title,data)

	tinsert(group.guides,{full=title,short=tit or title,num=#self.registeredmapspotsets+1})
	tinsert(self.registeredmapspotsets,set)
end

ZGV.registered_sortings = {}
local test=0
function ZGV:RegisterGuideSorting(array)
	for i,gr in ipairs(array) do
		self.registered_sortings[gr]=i
	end
end

ZGV.registered_includes = {}
function ZGV:RegisterInclude(title,text)
	self.registered_includes[title]={text=text}

	self.registered_includes[title].GetParsed = function (self,params)
		local function parse_param(param)
			return params and params[param] or ""
		end
		return self.text:gsub("%%(%w+)%%",parse_param)
	end
end

ZGV.registered_functions = {}
function ZGV:RegisterFunction(title,func)
	self.registered_functions[title]={func=func}

	self.registered_functions[title].GetParsed = function (self,params)
		local function parse_param(param)
			return params[param] or ""
		end
		local text = func()
		return text:gsub("%%(%w+)%%",parse_param)
	end
end

--[[
function ZGV:UnregisterGuide(name)
	local data
	if type(name)=="number" then
		if self.registeredguides[name] then
			data = self.registeredguides[name].data
			table.remove(self.registeredguides,name)
			self:Print("Unregistered guide number: "..name)
		else
			self:Print("Cannot find guide number: "..name)
			return false
		end
	else
		local i,v
		for i,v in ipairs(self.registeredguides) do
			if v.title==name then
				data = v
				table.remove(self.registeredguides,i)
				self:Print("Unregistered guide: "..name)
			end
		end
		if not data then
			self:Print("Cannot find guide: "..name)
			return false
		end
	end
	if data.is_stored then
		self.db.global.storedguides[name] = nil
		self:Print("Removed stored data for: "..name)
	end
	return true
end
--]]

-- Simulate a yieldable pcall.
-- As it's not possible to yield inside pcall, let's use a coroutine to trap errors instead.
function ZGV.coroutine_safe_pcall(f,arg)
	local co = coroutine.create(f)
	while true do
		local status, a,b,c,d,e = coroutine.resume(co,arg)
		if coroutine.status(co) == "suspended" then -- it yielded! pass the yield if possible, otherwise just continue immediately
			arg = coroutine.running() and coroutine.yield(a)
		else -- it returned or crashed! return the error or any normal return values.
			return status, a,b,c,d,e
		end
	end
end


--[[
function ZGV:RegisterStoredGuides()
	local k,v
	for k,v in pairs(self.db.global.storedguides) do
		table.insert(self.registeredguides,{title=k,data=v,is_stored=true})
		self:Print("Retrieved guide "..k.." from storage.")
	end
end
--]]

function ZGV:UpdateMapButton()
	if self.db.profile.showmapbutton then ZygorGuidesViewerMapIcon:Show() else ZygorGuidesViewerMapIcon:Hide() end
end

function ZGV:GetGuides()
	if not ZygorGuidesViewer or not ZygorGuidesViewer.db or not ZygorGuidesViewer.registeredguides then return {} end
	local t = {}
	for i,data in ipairs(ZygorGuidesViewer.registeredguides) do
		t[i]=data.title
	end
	return t
end

function ZGV.GetGuidesRev()
	if not ZygorGuidesViewer or not ZygorGuidesViewer.db or not ZygorGuidesViewer.registeredguides then return {} end
	local t = {}
	for i,data in ipairs(ZygorGuidesViewer.registeredguides) do
		t[data.title]=i
	end
	return t
end

ZGV.ProfilerRunning=nil -- Just not to forget

function ZGV:ProfilerEnable()
	SetCVar("scriptProfile","1")
	ReloadUI()
end

-- This attempts to create a CSV profile report based on any ZGV function we can get our hands on
-- If you are doing funny stuff with functions, keep in mind that any function is accounted only once
-- so if a function is encountered in several namespaces, you only get one
function ZGV:ProfilerReport()
    -- Sanity
    if GetCVar("scriptProfile")~="1" and not self.ProfilerMode then
        self:Print("Profiling is not enabled, cannot do this, sorry. Please enable the profiler in Zygor settings and rety.")
        return
    end

	if self.ProfilerRunning then
		local gscope=getfenv(0) -- Global scope
		local culprits={} -- Table of all functions we are interested in
		local tablesVisited={} -- Tables we have already touched, a countermeasure against cyclical links
		tablesVisited[tablesVisited]=true
		tablesVisited[culprits]=true

		local function tryToRegisterFunc(f,n)
			if not culprits[f] or #culprits[f]>#n then
				culprits[f]={name=n} -- Yeah the function is the table key, you saw it right ~aprotas
			end
		end

		-- First, let's gather the culprits
		inspect=function(obj,objname) -- local func to recursively inspect an object and its subobjects and so on
			tablesVisited[obj]=true
			for kk,vv in pairs(obj) do
				if type(vv)=="function" then
					tryToRegisterFunc(vv,objname..":"..tostring(kk))
					elseif type(vv)=="table" and not tablesVisited[vv] then
					inspect(vv,objname.."."..tostring(kk))
				end
			end
		end
		inspect(gscope,"")

		-- Getting the data and saving them in a database
		self.db.profile.profiler_stats={}
		for fun,tab in pairs(culprits) do
			tab.fulltime,tab.count=GetFunctionCPUUsage(fun,true)
			tab.puretime,_=GetFunctionCPUUsage(fun,false)
			if tab.count>0 then -- We don't want THIS much litter, do we?
				table.insert(self.db.profile.profiler_stats,{name=tab.name,fulltime=tab.fulltime,
						puretime=tab.puretime,count=tab.count,fullavg=tab.fulltime/tab.count,pureavg=tab.puretime/tab.count})
			end
		end

		-- Nice, now we have to sort it and find 100-top entries, I guess that's gonna be enough for testing and not too much for overflood
		table.sort(self.db.profile.profiler_stats,function(n1,n2)return n1.fulltime>n2.fulltime end)

		local s=""
		s="fulltime,puretime,count,fullavg,pureavg,func\n"
		for i=1,min(#self.db.profile.profiler_stats,100) do
			local v=self.db.profile.profiler_stats[i]
			s=s..v.fulltime..","..v.puretime..","..v.count..","..v.fullavg..","..v.pureavg..","..v.name.."\n"
		end

		self:ShowDump(s,"Profiler Report",true) -- TODO emails and stuff,make it readonly
		self:Print("Profiler report created.")
		self.ProfilerRunning=nil
	else
		self:Print("Profiling recording started.")
		self.ProfilerRunning=true
	end
    -- Reset the counters
    ResetCPUUsage()
end


local math_floor = math.floor
local function round(num, digits)
	-- banker's rounding
	local mantissa = 10^digits
	local norm = num*mantissa
	norm = norm + 0.5
	local norm_f = math_floor(norm)
	if norm == norm_f and (norm_f % 2) ~= 0 then
		return (norm_f-1)/mantissa
	end
	return norm_f/mantissa
end
function ZGV:Test (arg1,arg2)
	local a={GetMapZones(ZGV.GetCurrentMapContinent())}
	local x,y = GetPlayerMapPosition("player")
	local id = round(x*10000, 0) + round(y*10000, 0)*10001
	self:Print("You're in "..a[GetCurrentMapZone()].." at Cart2 coords "..id)
end

function ZGV:Echo (s)
	--if not self.db.profile.silent then
	self:Print(tostring(s))
	--end
end


local debugcolor="|cffff88dd"

local last_t=0
local mscycle=false
local mscolors={"|cffffcc00","|cffffaa00"}
local timecolor=mscolors[1]

ZGV.DEBUG_DEPTH=0
ZGV.DEBUG_STACK={}

local framestart_t = 0
local display={}
function ZGV:Debug (msg,...)
	local profile = ZGV.db and ZGV.db.profile   if not profile then return end
	if not profile.debug then return end
	
	--local initial_time=debugprofilestop()

	table.wipe(display)
	for i=1,select("#",...) do display[i]=select(i,...) or "nil" end
	-- just in case:
	table.insert(display,0) table.insert(display,0) table.insert(display,0)

	local depth=0
	if profile.debug_showdepth then debugstack():gsub("\n",function() depth=depth+1 end) end

	local flagsmsg
	local stack_depth=2
	local stackflag,stack_delayed_change
	local show_warning
	local replace_id
	while msg:sub(1,1)=="&" do
		local flag,rest = msg:match("^&([a-zA-Z0-9_]+)%s*(.*)$")
		if flag then
			if flag=="_SUB0" then
				stack_depth=nil
			elseif flag=="_SUB" then
				stack_depth=3
			elseif flag=="_SUB2" then
				stack_depth=4
			elseif flag=="_SUB3" then
				stack_depth=5
			elseif flag=="_PUSH" then
				stack_delayed_change=1
				stackflag = "-> "
				tinsert(ZGV.DEBUG_STACK,msg)
			elseif flag=="_POP" then
				ZGV.DEBUG_DEPTH=max(0,ZGV.DEBUG_DEPTH-1)
				tremove(ZGV.DEBUG_STACK)
				stackflag = "<- "
			elseif flag=="_WARN" then
				show_warning=true
			elseif flag=="_REPLACE" then
				replace_id,rest = rest:match("^(%S+)%s*(.*)$")
			else
				local flagdata = ZGV.db.profile.debug_flags and ZGV.db.profile.debug_flags[flag]
				if flagdata==false then return end -- otherwise assume it SET!
				if type(flagdata)=="table" then
					if not flagdata.enabled then return end
					if flagdata.color then flag = "|c"..flagdata.color..flag.."|r" end
				end
				flagsmsg = (flagsmsg and (flagsmsg.." ") or "") .. "[" .. flag .. "]"
			end
			msg = rest
		else
			msg="?"..msg:sub(2) -- failsafe, cut the & off
		end
	end

	--[[
		-- maybe... no.
		if ZGV.SHOW_STACKDEPTH_IN_DEBUG then
		local i=0
		msg:gsub("\n",
	--]]

	if stackflag then msg = stackflag..msg end
	msg = strrep("- ",ZGV.DEBUG_DEPTH) .. msg
	if stack_delayed_change then ZGV.DEBUG_DEPTH=ZGV.DEBUG_DEPTH+stack_delayed_change end

	if flagsmsg then msg = flagsmsg.." "..msg end
	if replace_id then msg = msg .. " |c00000000["..replace_id.."]" end
	msg = strrep(".",depth) .. " " .. msg
	local formatted_msg = format(tostring(msg),unpack(display)) :gsub("|r",debugcolor)

	local func
	if stack_depth and profile.debug_showcall then
		func = debugstack(stack_depth,1,-1)
		func = func:match("^(.-)\n") or func
		func = func:gsub(".*\\([^\\]-:%d+): in function `(.-)'","%1:%2") or func
		func = func:gsub(".*\\([^\\]-:%d+): in function.-string \"*(:.-)\"","%1:%2") or func
		func = func:gsub(".*\\([^\\]-:%d+): in function <.->","%1:<local>") or func
	end

	if true then -- self and self.db and self.db.profile and self.db.profile.debug and not self.db.profile.quiet then
		self.DebugI = (self.DebugI or 0) + 1
		--func = func:match("in function `(.-)'") or func
		--func = func:match("in function.-string \"*(:.-)\"") or func
		local current_time = debugprofilestop()
		local t = GetTime()
		if t~=last_t then
			framestart_t = current_time
			mscycle=not mscycle
			last_t=t
			timecolor=mscolors[mscycle and 1 or 2]
		end
		local debugms = current_time-framestart_t

		local chatframe = ZGV.debugframe
		if not chatframe then
			chatframe = _G[ZGV.db.profile.debug_frame or "ChatFrame1"]
			ZGV.debugframe = chatframe
		end
		if not chatframe then chatframe=ChatFrame1 end

		local message
		if func then
			message = ("|cffffee77Z|r: %s%06.03f+%03d|r |cff00ddbb#%d: %s%s  |cffaaaaaa(%s)"):format(timecolor,(t-self.loadtimeGT),debugms,self.DebugI,debugcolor,formatted_msg,func)
		elseif self.db.profile.debug_fps then
			message = ("|cffffee77Z|r: %s%06.03f+%03d|r@%03d |cff00ddbb#%d: %s%s"):format(timecolor,(t-self.loadtimeGT),debugms,GetFramerate(),self.DebugI,debugcolor,formatted_msg)
		else
			message = ("|cffffee77Z|r: %s%06.03f+%03d|r |cff00ddbb#%d: %s%s"):format(timecolor,(t-self.loadtimeGT),debugms,self.DebugI,debugcolor,formatted_msg)
		end

		local replace_at
		if replace_id then  -- find same message in history
			local buffer = chatframe.historyBuffer
			local i=buffer.elements.headIndex or #buffer.elements
			local maxdist=10 -- how far back we can replace
			local dist=0
			repeat
				local msg=buffer.elements[i]
				if not msg then break end
				if msg.message:find("|c00000000["..replace_id,1,true) then replace_at=i break end
				i=i-1
				if i<1 then i=#buffer.elements end
				dist=dist+1
			until replace_at or dist>=maxdist
		end
		if replace_at then
			chatframe.historyBuffer.elements[replace_at].message=message
			chatframe:MarkDisplayDirty()
		else
			chatframe:AddMessage(message)
		end
		if show_warning then
			RaidNotice_AddMessage(RaidWarningFrame, "[|cffff8800Z|r] "..formatted_msg, HIGHLIGHT_FONT_COLOR);
		end
	end
	if func then
		self.Log:Add("%s (%s)",formatted_msg,func)
	else
		self.Log:Add("%s",formatted_msg)
	end

	--local debug_time=debugprofilestop()-initial_time
end


-- HACKS
function ZGV:ListQuests(from,to)
	local CQI=Cartographer_QuestInfo
	local qlog = ""
	for i=from,to do
		local level = CQI:PeekQuest(i)
		--if not level then level=0 end
		if level then
			local title,_,_,_,nobjs = CQI:GetQuestText(i,level)
			--if not title then title = CQI:GetQuestText(i,level) end -- well, they said to repeat it...
			--self:Print(i..": |cff808080|Hquest:"..i..":"..level.."|h["..tostring(title).."]|h|r "..(type(objs)=="table" and "{"..table.concat(nobjs,",").."}" or ""))
			qlog = qlog .. i..": "..tostring(title)..(type(nobjs)=="table" and " {"..table.concat(nobjs,",").."}" or "") .. "|n"
		end
	end
	if Chatter then
		Chatter:GetModule("Chat Copy").editBox:SetText(qlog)
		Chatter:GetModule("Chat Copy").editBox:HighlightText(0)
		Chatter:GetModule("Chat Copy").frame:Show()
	end
end

function ZGV:ReloadTranslation()
	for i,guide in ipairs(self.registeredguides) do
		for s,step in ipairs(guide.steps) do
			for g,goal in ipairs(step.goals) do
				goal.L=false
			end
		end
	end
end

-- used for steps and goals
--[[
function ZGV.ConditionTrue(subject,case)
	if not subject.conditions then return false end
	local f=subject.conditions[case]
	if type(f)=="function" then
		return f()
	elseif type(f)=="string" then
		f=subject.conditions[f]
		assert(type(f)=="function","What? This step has cross-referencing conditions? wtf.")
		return not f()
	end
end
--]]

function ZGV.gradient3(perc,ar,ag,ab,br,bg,bb,cr,cg,cb, middle)
	if perc >= 1 then
		return cr,cg,cb
	elseif perc<=0 then
		return ar,ag,ab
	else
		if perc<=middle then
			perc=perc/middle
			return ar+(br-ar)*perc, ag+(bg-ag)*perc, ab+(bb-ab)*perc
		else
			perc=(perc-middle)/(1-middle)
			return br+(cr-br)*perc, bg+(cg-bg)*perc, bb+(cb-bb)*perc
		end
	end
end

--hooksecurefunc("WorldMapFrame_UpdateQuests",function() if not InCombatLockdown() then text=nil end end)
--hooksecurefunc("QuestInfo_Display",function() if not InCombatLockdown() then shownFrame=nil bottomShownFrame=nil end end)



--[[


function FindAch_AchievementFrame_OnShow(self)
	local editbox = AchievementFrame_FindAch_Edit
	if not editbox then
		editbox = CreateFrame("EditBox","AchievementFrame_FindAch_Edit",AchievementFrame,"InputBoxTemplate")
		editbox:SetSize(150,30)
		editbox:SetPoint("TOPLEFT",AchievementFrame,"TOPLEFT",150,15)
		editbox:Show()
		editbox:SetFocus(false)
	end
end

function FindAch_Listen_OnEvent(self,event,...)
	if event=="ADDON_LOADED" and ...=="Blizzard_AchievementUI" then
		AchievementFrame:HookScript("OnShow",FindAch_AchievementFrame_OnShow)
	end
end
local frame=CreateFrame("FRAME","FindAch_Listen")
frame:SetScript("OnEvent",FindAch_Listen_OnEvent)
frame:RegisterEvent("ADDON_LOADED")

--]]

-- encraption.
function ZGV:CraptOnReload(name)

end


function ZGV:COMBAT_LOG_EVENT_UNFILTERED(event,time,evtype,a1,a2,a3,a4,a5)
	--print(evtype,a3)
	if evtype=="PARTY_KILL" then
		if a3==UnitName("player") then
			self.MagicKey.retarget_time = GetTime()
			self:SetMagicKey()
		end
	end
end


-- CONVENIENCE: /re for Reload
SLASH_RE1 = "/re"
function SlashCmdList.RE(text)  ReloadUI()  end

local lastbind
function ZGV:SetMagicKey(reset)
	if not self.MagicKey.FR then return end
	if reset then lastbind=nil end

	if not ZGV.db.profile.magickey or ZGV.db.profile.magickey==""
		or InCombatLockdown()
		or not ZGV.CurrentStep or not ZGV.CurrentStep.goals or not ZGV.Frame:IsShown()
		then
			self.MagicKey.FR:Hide()
			return
		end

	self.MagicKey.FR:Show()

	local bind,bind2

	local function DoBind(bind,bind2,desc)
		if not bind then
			self.MagicKey:SetHint("")
		end

		if lastbind~=(bind2 or bind) then
			if bind=="CLICK" then
				SetBindingClick(self.db.profile.magickey,bind2)
			else
				SetBinding(self.db.profile.magickey,bind)
			end
			lastbind=bind2 or bind
			self:Debug("Magic Key binding: "..tostring(bind2 or bind))
		end

		self.MagicKey:SetHint(desc)
	end

	-- turn in quests
	if self.db.profile.magickey_acceptturnin and GossipFrame:IsShown() or QuestFrame:IsShown() then
		for gi,g in ipairs(self.CurrentStep.goals) do
			if g.action=="accept" or g.action=="turnin" then
				return DoBind("CLICK","ZygorGuidesViewer_MagicKeyHint_Button", "Accept/Turn In")
			end
		end
	end

	-- suggest retargeting corpses
	if self.db.profile.magickey_targetcorpse and self.MagicKey.retarget_time and (GetTime()-self.MagicKey.retarget_time < 3) and not UnitName("target") then
		return DoBind("TARGETLASTTARGET",nil, "Target corpse")
	end


	local targetid = self.GetTargetId()
	if self.db.profile.magickey_loot and UnitIsDead("target") then
		return DoBind("InteractTarget",nil,"Loot")
	end

	for gi,g in ipairs(self.CurrentStep.goals) do
		if g:IsComplete() then
			-- do nothing ;P

		elseif targetid and ((UnitName("target") == g.target) or (targetid == (g.npcid or (g.mobs and g.mobs[1] and g.mobs[1].id)))) then
			-- interact in its varieties
			local hint
			if UnitIsFriend("target","player") and self.db.profile.magickey_talk then
				return DoBind("InteractTarget",nil,"Talk")
			elseif not UnitIsFriend("target","player") and self.db.profile.magickey_attack then
				return DoBind("InteractTarget",nil,"Attack")
			end

		elseif g.macro then
			local src = g.macrosrc
			local hint
			if src then
				local npc = src:match("/target (.+)\n")
				if npc then
					if self.db.profile.magickey_target then
						return DoBind("MACRO "..g.macro, nil, "Target: "..npc)
					end
				else
					if self.db.profile.magickey_itemspell then
						return DoBind("MACRO "..g.macro, nil, "Use macro: "..g:GetText())
					end
				end
			else
				return DoBind("MACRO "..g.macro, nil, "(macro?)")
			end


		elseif _G['ZygorGuidesViewerFrame_Act'..(g.num+1)..'Action']:IsShown() then
			if self.db.profile.magickey_itemspell then
				return DoBind("CLICK","ZygorGuidesViewerFrame_Act"..(g.num+1).."Action", g:GetText())
			end
		end

		--[[
		if (g.action=="kill" and g.target) or (g.action=="talk" and g.npcid) or (g.action=="from" and (g.mobs and g.mobs[1] and g.mobs[1].name)) then
			firstname=(g.target or g.npcid) or (g.mobs and g.mobs[1] and g.mobs[1].name)

			break
		end
		--]]
	end

	return DoBind(nil,nil,nil)
end

function ZGV.MagicButton_OnClick(but)
	ZGV:QuestAutoStuff()
end

-- SECURE!
function ZGV:MagicRaidMarker()
	if not ZGV.db.profile.targetonclick then return ZGV end
	
	ZGV.db.profile.magicmarker_mob=8
	ZGV.db.profile.magicmarker_npc=4
	if not UnitIsFriend("target","player") and ZGV.db.profile.magicmarker_mob and ZGV.db.profile.magicmarker_mob>0 then
		local icon = GetRaidTargetIndex("target")
		if icon~=ZGV.db.profile.magicmarker_mob then
			SetRaidTarget("target",ZGV.db.profile.magicmarker_mob)
		end
	elseif UnitIsFriend("target","player") and ZGV.db.profile.magicmarker_npc and ZGV.db.profile.magicmarker_npc>0 then
		local icon = GetRaidTargetIndex("target")
		if icon~=ZGV.db.profile.magicmarker_npc then
			SetRaidTarget("target",ZGV.db.profile.magicmarker_npc)
		end
	end
	return ZGV  -- for chaining
end
ZGV.MRM = ZGV.MagicRaidMarker

function ZGV:MacroClickGoal(stepnum,goalnum)
	if self.CurrentGuide and self.CurrentGuide.steps[stepnum] and self.CurrentGuide.steps[stepnum].goals[goalnum] then self.CurrentGuide.steps[stepnum].goals[goalnum]:OnClick() end
end
ZGV.CG = ZGV.MacroClickGoal

function ZGV:ShowAnimatedPopup()
	local dialog = ZGV.PopupHandler:NewPopup(ZGV:RenderAnimation({10,1,48,31,3}),"default")

	local animation1 = {24,43,25,52,7,40,27,26,53,27,34,39,13,50,41,26,27,40,50,35}
	local animation2 = {56,18,34,43,40,13,47,43,27,35,50,52,13,21,49,38,50,13,50,41,26,27,40,50,35,55,13,3,11,50,49,52,50,13,43,26,35,49,53,50,13,53,34,13,40,50,39,50,8,13,16,34,43,40,13,11,27,7,50,39,52,50,55,13,54,17,13,16,34,43,40,13,30,11,27,53,50,13,23,50,23,25,50,40,52,21,27,26,13,21,49,52,13,50,39,35,50,35,13,16,34,43,13,8,27,11,11,13,39,50,50,35,13,53,34,13,40,50,39,50,8,13,16,34,43,40,13,52,43,25,52,7,40,27,26,53,27,34,39,13,53,34,13,40,50,52,53,34,40,50,13,17,43,11,11,13,49,7,7,50,52,52,22,13,34,53,21,50,40,8,27,52,50,13,16,34,43,40,13,49,7,7,50,52,52,13,8,27,11,11,13,25,50,13,11,27,23,27,53,50,35,55}
	
	-- Not perfect, since we are reusing SetText to play animation. Needs refactoring
	dialog:SetText(ZGV:RenderAnimation(animation1),ZGV:RenderAnimation(animation2)) 

	-- Hide buttons, as they mess up animation frames on higher speeds
	dialog.acceptbutton:Hide()
	dialog.declinebutton:Hide()
	dialog.settings:Hide()
	dialog.minimize:Hide()

	dialog:Show()
end

function ZGV:Unparse(id,y,m,d)
	local c,b=string.char,string.byte
	local function enc(a)
		print("coding "..a)
		return c(a%10+1+16*math.floor(a/10))
	end
	local s=("%08d%2d%2d%2d"):format(id,y%100,m,d)
	--local s="12345678010203"
	local s2=""
	for di,i in ipairs{id/100000,id/1000,id/10,id,y,m,d} do s2=s2..enc(b(math.floor(i)%10)) end
	return s2
end

function ZGV:DoMutex(m)
	ZygorGuidesViewer.GuideMenuTier = nil
	if self.guidesets[m] then return true else self.guidesets[m]=true end
end

local flatlist
function ZGV:GetFlatListOfGroups(source,search,target,notoplevel,curlevel)
	if not source then  -- start!
		source=self.registered_groups
		if target then flatlist=target else flatlist={} end
	end
	curlevel=curlevel or 1
	if not source.groups then return end
	for gi,g in pairs(source.groups) do
		if not (notoplevel and curlevel==1)
		and (not search  or  g.name and (g.name:lower():find(search,1,true) or g.name:lower():gsub("%p",""):find(search,1,true))) then
			tinsert(flatlist,g)
		end
		if #g.groups>0 then self:GetFlatListOfGroups(g,search,target,notoplevel,curlevel+1) end
	end
	return flatlist
end

function ZGV:FindGuides(sub)
	local logic="AND"
	if sub:sub(1,3)=="OR " then
		logic="OR"
		sub=sub:sub(4)
	end
	sub=sub:lower()
	local found={}
	self:GetFlatListOfGroups(nil,sub,found, "notoplevel")
	--[[
	for gi,g in pairs(self.registered_groups.groups) do
		if g.name and (g.name:lower():find(sub,1,true) or g.name:lower():gsub("%p",""):find(sub,1,true)) then
			tinsert(found,g)
		end
	end
	--]]

	local already_found={}
	local function do_find(sub,scope,into)
		for gi,g in pairs(scope) do
			if not (g.type=="TEST") and not (logic=="OR" and already_found[g]) then
				if (g.title_short and g.title_short:lower():find(sub,1,true)) then
					if not (ZGV.db.profile.gmhidecompleted and (g:GetStatus()=="OUTLEVELED" or g:GetStatus()=="COMPLETE")) then
						tinsert(into,g)
						already_found[g]=true
					end
				elseif g.keywords then
					for _,word in pairs(g.keywords) do
						if word:lower():find(sub,1,true) then
							tinsert(into,g)
							already_found[g]=true
							break
						end
					end
				end
			end
		end
	end

	local firstword=true
	for word in sub:gmatch("([^%s]+)") do
		if firstword or logic=="OR" then
			do_find(word,self.registeredguides,found)
		else
			local temp={}
			do_find(word,found,temp)
			found=temp
		end
		firstword=false
	end
	return found
end

function ZGV:UnloadUnusedGuides()
	self:Debug("Unimplemented: unloading unused guides.")
end

function ZGV:ClearCurrentGuide()
	self.CurrentGuide=nil
	self.db.profile.guidename=nil
	self:UpdateFrame()
end

-- WARNING Heuristic in this thread. We assume that this is called only after all the guides are registered
-- and therefore, to optimize things a bit, we cache the results of parsing, so that subsequent request to
-- load the same type will immediately return. This will malfunction if the guides are added online between
-- the calls to this function. ~aprotas

local guideTypesLoaded={}

function ZGV:LoadGuidesByType(guidetype)
	assert(guidetype)
	if guideTypesLoaded[guidetype] then return end

	local t1=debugprofilestop()
	for gi,g in pairs(self.registeredguides) do
		if g.type==guidetype then
			g:Parse(true)
		end
	end
	ZGV:Debug("&startup Loaded guides by type: %s = %dms",guidetype,debugprofilestop()-t1)
	guideTypesLoaded[guidetype]=true
end

function ZGV:LoadNeededGuides()
	local t0=debugprofilestop()
	for gi,g in pairs(self.registeredguides) do
		if g.need_to_parse then
			local success = g:Parse(true)
			g.need_to_parse = nil
			if debugprofilestop()-t0>100 then return nil end  -- 0.1s allowed here
		end
	end
	return true
end

ZGV.ParseLog = ""

function ZGV:Error(s,...)
	if (...) then s=s:format(...) end
	self:Print("|cffff0000ERROR:|r "..s)
	ZGV.ParseLog = ZGV.ParseLog .. s .. "\n"
	return s
end

function ZGV:ErrorThrow(...)
	local s = self:Error(...)
	geterrorhandler()(s)
end

-- HBD migration snip: Ship Arrival Times 


local lasttime,lastmem=GetTime(),0
local memavg={0,0,0,0,0}
function ZGV:MemHogging()
	UpdateAddOnMemoryUsage()
	local mem = GetAddOnMemoryUsage(addonName)
	local time = GetTime()
	if time~=lasttime and mem~=lastmem then
		local total=0
		for i=1,4 do memavg[i]=memavg[i+1] total=total+memavg[i+1] end
		local kbs = floor((mem-lastmem)/(time-lasttime))
		memavg[5]=kbs

		kbs=(kbs+total)/5

		ZGV.DebugFrame.text1:SetText(("%s %d"):format(strrep(".",kbs/3),kbs))
	end
	lasttime,lastmem=time,mem
end

local memmark=0
function ZGV:MemHogStart()
	UpdateAddOnMemoryUsage()
	memmark=GetAddOnMemoryUsage(addonName)
end

function ZGV:MemHogStop(desc)
	UpdateAddOnMemoryUsage()
	local memmark2=GetAddOnMemoryUsage(addonName)
	print("|cff00ff88",desc,("%.1f"):format(memmark2-memmark))
end

function ZGV:MemHogTest()
	self:MemHogStart()
	self:MemHogStop()
	self:MemHogStart()
	self:MemHogStop()
	self:MemHogStart()
	local a={}
	for i=1,1000 do a[i]={} end
	self:MemHogStop()
end


function ZGV:StartFPSFrame()
	if not ZGV.FPSFrame then
		local SIZE=300
		local MAXFPS=60
		ZGV.FPSFrame = ZGV.ChainCall(CreateFrame("FRAME","ZygorFPSFrame",UIParent)) :SetPoint("BOTTOMLEFT") :SetSize(SIZE+11,MAXFPS) :SetFrameStrata("DIALOG") .__END
		ZGV.FPSFrame.back = ZGV.ChainCall(ZGV.FPSFrame:CreateTexture()) :SetAllPoints() :SetColorTexture(0,0,0,1) .__END
		ZGV.FPSFrame.bars={}
		ZGV.FPSFrame.fpsbars={}
		for b=1,SIZE do
			tinsert(ZGV.FPSFrame.bars, ZGV.ChainCall(ZGV.FPSFrame:CreateTexture()) :SetPoint("BOTTOMLEFT",ZGV.FPSFrame,"BOTTOMLEFT",b,0) :SetSize(1,MAXFPS) :SetColorTexture(1,1,1) :SetDrawLayer("ARTWORK",1) .__END)
			tinsert(ZGV.FPSFrame.fpsbars, ZGV.ChainCall(ZGV.FPSFrame:CreateTexture()) :SetPoint("BOTTOMLEFT",ZGV.FPSFrame,"BOTTOMLEFT",b,0) :SetSize(1,2) :SetColorTexture(1,1,1) :SetDrawLayer("ARTWORK",2) .__END)
		end
		ZGV.FPSFrame.fpsbar = ZGV.ChainCall(ZGV.FPSFrame:CreateTexture()) :SetPoint("BOTTOMLEFT",ZGV.FPSFrame.bars[SIZE],"BOTTOMRIGHT",3,0) :SetSize(5,MAXFPS) :SetColorTexture(1,1,1) :SetDrawLayer("ARTWORK",1) .__END
		ZGV.FPSFrame.hicbar = ZGV.ChainCall(ZGV.FPSFrame:CreateTexture()) :SetPoint("BOTTOMLEFT",ZGV.FPSFrame.bars[SIZE],"BOTTOMRIGHT",10,0) :SetSize(5,MAXFPS) :SetColorTexture(1,1,1) :SetDrawLayer("ARTWORK",1) .__END

		tinsert(ZGV.FPSFrame.bars,ZGV.FPSFrame.fpsbar)

		local barheights={}
		local fpslineheights={}
		for b=1,SIZE do barheights[b]=0 fpslineheights[b]=0 end

		local hiccup=0
		function ZGV.FPSFrame:OnUpdate(elapsed)
			local t1=debugprofilestop()
			--local fps=GetFramerate()
			local n=floor(min(max(1,elapsed*100),SIZE))  -- n bars to cover
			for b=1,SIZE-n do
				barheights[b]=barheights[b+n]
				fpslineheights[b]=fpslineheights[b+n]
			end

			local fps=1/elapsed
			local h=min(fps,MAXFPS)
			local avgfps=min(MAXFPS,GetFramerate())
			for b=SIZE-n+1,SIZE do
				barheights[b]=h
				fpslineheights[b]=avgfps
			end

			local h=min(max(GetFramerate(),1),MAXFPS)
			barheights[SIZE+1]=h  -- fpsbar

			local elams = elapsed*1000
			if elams>50 then --20fps, awful
				hiccup=hiccup+ (elams/50) * 8
			--elseif elams>17 then --60fps, expected
			--	hiccup=hiccup+ ( (elams-17) ) / 10
			end
			hiccup = min(max(0,hiccup-elapsed*5),MAXFPS)
			self.hicbar:SetHeight(min(max(1,hiccup),MAXFPS))


			for b=1,SIZE+1 do
				local h1=barheights[b]/MAXFPS
				local r=(h1<0.5) and 1 or 2-(h1*2)
				local g=(h1<0.5) and h1*2 or 1
				self.bars[b]:SetColorTexture(r,g,0)

				self.bars[b]:SetHeight(barheights[b])
				if b<=SIZE then self.fpsbars[b]:SetPoint("BOTTOMLEFT",b,fpslineheights[b]) end
			end

			local h1=hiccup/MAXFPS
			local r=(h1<0.5) and h1*2 or 1
			local g=(h1<0.5) and 1 or 2-(h1*2)
			self.hicbar:SetColorTexture(r,g,0)

		end
		ZGV.FPSFrame:SetScript("OnUpdate",ZGV.FPSFrame.OnUpdate)
	end
	ZGV.FPSFrame:SetShown(ZGV.db.profile.fpsgraph)
end


ZGV.Quest_Choices = {}
function ZGV:ZGV__QUEST_CHOICE_SENT(event,id,choice)
	ZGV:Debug("Quest choice: choice id |cffffeeaa%d|r, selected |cffffeeaa%d|r",id,choice)
	ZGV.Quest_Choices[id]=choice
end

function ZGV:Hook_QuestChoice()
	hooksecurefunc("SendQuestChoiceResponse",function(...) ZGV.Surrogate_SendQuestChoiceResponse(...) end)
	ZGV:AddMessageHandler("ZGV__QUEST_CHOICE_SENT")
end

function ZGV.Surrogate_SendQuestChoiceResponse(choice)
	local id = GetQuestChoiceInfo()
	ZGV:SendMessage("ZGV__QUEST_CHOICE_SENT",id,choice)
end

--local Gratuity = LibStub("LibGratuity-3.0")
--[[
function ZGV:UPDATE_MOUSEOVER_UNIT()
	if not ZGV.TargetPingFrame then
		ZGV.TargetPingFrame = ZGV.ChainCall(CreateFrame("FRAME","ZGVTargetPingFrame")) :SetSize(100,100) .__END
		ZGV.TargetPingFrame.tex = ZGV.ChainCall(ZGV.TargetPingFrame:CreateTexture()) :SetPoint("CENTER") :SetTexture(ZGV.DIR.."\\skins\\minimaparrow-ant") :SetAlpha(0.3) :SetBlendMode("ADD") .__END
		ZGV.TargetPingFrame:SetScript("OnUpdate",function(self,elapsed)
			if self.cycle>0 then
				self.tex:SetAlpha(self.cycle*0.3)
				local siz=self.cycle*10+60
				self.tex:SetSize(siz,siz)
				self.cycle=self.cycle-elapsed*3
			end
			if self.cycle<=0 then self:Hide() end
		end)
		ZGV.TargetPingFrame.cycle=0
	end

	local npc = GameTooltipTextLeft1:GetText()
	if npc and self.CurrentStep and self.CurrentStep.goals then
		local found
		for g,goal in ipairs(ZGV.CurrentStep.goals) do
			if npc==goal.target or npc==goal.npc then
				found=true
				break
			elseif goal.mobs then
				for m,mob in ipairs(goal.mobs) do
					if mob.name==npc then found=true break end
				end
			end
		end
		if found then
			PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT)
			ZGV.TargetPingFrame:ClearAllPoints()
			local x,y=GetCursorPosition()
			ZGV.TargetPingFrame:SetPoint("CENTER",nil,"BOTTOMLEFT",x,y)
			ZGV.TargetPingFrame.cycle=1
			ZGV.TargetPingFrame:Show()
		end
	end
end
--]]

ZGV.Spark={}

-- These were sparks. They were distracting. Leaving for future.
-- Actually, they're fun.
function ZGV:UPDATE_MOUSEOVER_UNIT()
	local time=GetTime()
	if not ZGV.TargetPingFrame then
		ZGV.TargetPingFrame = ZGV.ChainCall(CreateFrame("FRAME","ZGVTargetPingFrame")) :SetSize(1,1) :SetPoint("BOTTOMLEFT") .__END
		local NUMFLY=20
		ZGV.TargetPingFrame.tex={}
		local function Fly(tex,elapsed)
			tex.life=tex.life-elapsed
			if tex.life<=0 then tex.life=0.001 end
			local siz = tex.siz*tex.life
			tex:SetSize(siz,siz)
			tex.y=tex.y+tex.dy*elapsed
			tex.dy=tex.dy-elapsed*45
			tex.x=tex.x+tex.dx*elapsed
			tex:SetPoint("CENTER",tex:GetParent(),"BOTTOMLEFT",tex.x,tex.y)
		end
		local function Start(tex,x,y)
			tex.dx=60*(random()-0.5)
			tex.dy=60*(random()-0.3)
			tex.x=x+tex.dx*random()*0.3
			tex.y=y+tex.dy*random()*0.3
			tex.siz=random(5,10)
			tex.life=1
			tex:Show()
		end
		for i=1,NUMFLY do
			ZGV.TargetPingFrame.tex[i] = ZGV.ChainCall(ZGV.TargetPingFrame:CreateTexture()) :SetPoint("CENTER") :SetSize(20,20) :SetTexture(ZGV.DIR.."\\skins\\minimaparrow-ant") :SetBlendMode("ADD") .__END
			ZGV.TargetPingFrame.tex[i].Fly = Fly
			ZGV.TargetPingFrame.tex[i].Start = Start
			ZGV.TargetPingFrame.tex[i].life=0
		end
		ZGV.TargetPingFrame.nexttex=1
		ZGV.TargetPingFrame.firing=0

		-- continuous firing.
		---[[
		ZGV.TargetPingFrame:SetScript("OnUpdate",function(self,elapsed)
			if self.firing then
				--self.firing=self.firing-elapsed
				local x,y=GetCursorPosition()
				-- generate new
				self.nexttex=self.nexttex+1  if self.nexttex>NUMFLY then self.nexttex=1 end
				self.tex[self.nexttex]:Start(x,y)
			end
			for i=1,NUMFLY do local t=self.tex[i]  if t.life>0.01 then t:Fly(elapsed) else t:Hide() end end
			if not GameTooltip:IsShown() or GameTooltip:GetAlpha()<0.9 then self.firing=nil end
		end)
		function ZGV.TargetPingFrame:Start()
			PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT)
			--self:SetPoint("CENTER",nil,"BOTTOMLEFT",x,y)
			self.firing=1
			self:Show()
		end
		--]]

		--[[
		ZGV.TargetPingFrame:SetScript("OnUpdate",function(self,elapsed)
			if self.tex[1].life<0 then return end
			for i=1,NUMFLY do local t=self.tex[i]  if t.life>0.01 then t:Fly(elapsed) else t:Hide() end end
		end)
		function ZGV.TargetPingFrame:Start()
			PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT)
			--self:SetPoint("CENTER",nil,"BOTTOMLEFT",x,y)
			local x,y=GetCursorPosition()
			for i=1,NUMFLY do  self.tex[i]:Start(x,y)  end
			self:Show()
		end
		--]]
	end

	if ZGV.Spark.LastEvent=="CURSOR_UPDATE" and ZGV.Spark.LastCursorUpdate~=time then return end

	local npc = GameTooltip:IsShown() and GameTooltip:GetAlpha()>0.9 and GameTooltipTextLeft1:GetText()
	if npc and self.CurrentStep and self.CurrentStep.goals then
		local found
		for g,goal in ipairs(ZGV.CurrentStep.goals) do
			if npc==goal.target or npc==goal.npc then
				found=true
				break
			elseif goal.mobs then
				for m,mob in ipairs(goal.mobs) do
					if mob.name==npc then found=true break end
				end
			end
		end
		if found then
			ZGV.TargetPingFrame:Start()
		else
			ZGV.TargetPingFrame.firing=nil
		end
	else
		ZGV.TargetPingFrame.firing=nil
	end
	ZGV.Spark.LastEvent="UPDATE_MOUSEOVER_UNIT"
end
function ZGV:CURSOR_UPDATE()
	--ZGV:UPDATE_MOUSEOVER_UNIT()
	ZGV.Spark.LastCursorUpdate=GetTime()
	if ZGV.TargetPingFrame then ZGV.TargetPingFrame.firing=nil end
	ZGV.Spark.LastEvent="CURSOR_UPDATE"
end
--

function ZGV:WarnAboutDebugSettings()
	if self.db.profile.fakecombat then self:Print("WARNING, DEBUG: Faked combat is on.") end
	if self.db.profile.fakeskills and next(self.db.profile.fakeskills) then self:Print("WARNING, DEBUG: Fake professions are set.") end
	if self.db.profile.fakereps and next(self.db.profile.fakereps) then self:Print("WARNING, DEBUG: Fake reputations are set.") end
	if self.db.profile.fakelevel then self:Print("WARNING, DEBUG: Fake level is set to "..self.db.profile.fakelevel) end
end

local legion_popup_class = { "Warrior","Paladin","Hunter","Rogue","Priest","Death Knight","Shaman","Mage","Warlock","Monk","Druid","Demon Hunter" }
function ZGV:PLAYER_LEVEL_UP(event,level)
	local title,message,guide
	local _,_,classnum = UnitClass("player")
	local classname = legion_popup_class[classnum]

	if level==101 then
		guide = ZGV:GetGuideByTitle("Leveling Guides\\Legion (100-110)\\"..classname.." Order Hall Quests")
		title = "First Class Order Hall Quest Available"
		message = "\nA new Class Order Hall questline is now available.\nWould you like to load the guide for this?"
	elseif level==102 then
		--if ZGV:RaceClassMatch("DEMONHUNTER") then
		--	guide = ZGV:GetGuideByTitle("Leveling Guides\\Starter Guides\\Demon Hunter (98-100)")
		--else
			guide = ZGV:GetGuideByTitle("Leveling Guides\\Legion (100-110)\\"..classname.." Intro & Artifacts")
		--end
		title = "Additional Artifact Weapons Now Available"
		message = "\nYou can now unlock the artifact \nweapons for your other class specs. \nWould you like to load the guide for this?\n"
	elseif level==103 then
		guide = ZGV:GetGuideByTitle("Leveling Guides\\Legion (100-110)\\"..classname.." Order Hall Quests")
		title = "Additional Order Hall Quests Available"
		message = "\nAdditional Order Hall quests are now available.\nWould you like to load the guide for this?"
	elseif level==110 then
		guide = ZGV:GetGuideByTitle("Leveling Guides\\Legion (100-110)\\"..classname.." Order Hall Quests")
		title = "Additional Order Hall Quests Available"
		message = "\nAdditional Order Hall quests are now available.\nWould you like to load the guide for this?"
	end

	if guide then
		guide:LegionPopup(title,message,level)
	end
end

local POIcache={}
function ZGV:CachePOIs()
	local mapid = ZGV.GetCurrentMapID() or 0
	POIcache[mapid]=POIcache[mapid] or {}
	table.wipe(POIcache[mapid])
	for i=1,GetNumMapLandmarks() do
		local _, _, _, _, _, _, _, _, _, areaID, poiID, _ = C_WorldMap.GetMapLandmarkInfo(i)
		if poiID then POIcache[mapid][poiID]=true end
	end
end

function ZGV:IsPOIActive(poiid)
	for map,pois in pairs(POIcache) do
		if pois[poiid] then return true end
	end
end
ZGV.POIcache=POIcache

-- hooked from blizzard world map icons (those that have poiID defined) to load guide step tied to that specific object
-- uses guides defined in guidetitles array
-- checks all steps for rare-12345 label matching poiID number
function ZGV:SuggestGuideFromBlizzardIcon(object)
	local poiID = object and object.areaPoiID
	if not poiID then return end

	local guidetitles = {
		["Dailies Guides\\Legion\\Broken Shore Rares"] = {content="rare elite", prefix="rare"},
		["Dungeon Guides\\Legion Scenarios\\Argus Invasions"] = {content="invasion point", prefix="invasion"},
	}

	local step_guide, step_label, content, prefix
	for guidetitle,guidedata in pairs(guidetitles) do
		local guide = self:GetGuideByTitle(guidetitle)
		if not guide then return end
		if not guide.parsed then guide:Parse(true) end  -- possible FPS hit!
		content,prefix = guidedata.content, guidedata.prefix
		for labelname,labeldata in pairs(guide.steplabels) do
			if labelname == prefix.."-"..poiID then
				step_label = labeldata[1]
				step_guide = guide
			end
		end
		if step_label then break end
	end

	if not step_label then
		ZGV:Debug("&_SUB &worldquests no label for object "..poiID)
		return
	end
	
	if ZGV.CurrentGuide==step_guide then
		ZGV:Debug("&_SUB &worldquests switching to "..poiID)
		ZGV:FocusStep(step_label,true)
	else
		ZGV:Debug("&_SUB &worldquests popup for "..poiID)
		ZGV.NotificationCenter.AddButton(
		"worldquest",
		object.description~="" and object.description or object.name,
		"Click here to open the guide for this "..content,
		ZGV.DIR.."\\Skins\\guideicons-big",
		{0, 0.25, 0, 0.25},
		function() ZGV:SetGuide(step_guide.title,step_label) end,
		nil,
		1,
		10, --poptime
		30, --removetime
		false, --quiet
		nil,--onopen
		"worldquest")
	end

end


local SimpleThreadFrame = CreateFrame("FRAME","ZygorGuidesViewerSimpleThreadFrame")
SimpleThreadFrame.threads = {}
local function SimpleThreadFrame_OnUpdate(frame,elapsed)
	for thread,tparm in pairs(frame.threads) do
		if coroutine.status(thread)~="dead" then
			local ok,err = coroutine.resume(thread,unpack(tparm))
			if not ok then ZGV:Error("Timerize error: "..tostring(err)) end
		else
			frame.threads[thread]=nil
			if next(frame.threads)==nil then SimpleThreadFrame:SetScript("OnUpdate",nil) end
		end
	end
end

function ZGV:Timerize(func,...)
	local thread = coroutine.create(func)
	SimpleThreadFrame.threads[thread]={...}
	SimpleThreadFrame:SetScript("OnUpdate",SimpleThreadFrame_OnUpdate)
end


-- Startup Checklist. Eventually abandoned, but may be useful someday.
	local Checklist = {}
	local CL=Checklist
	ZGV.Checklist = Checklist
	Checklist.events_sequence = {}
	Checklist.events_fired = {}
	Checklist.framenum = 0
	Checklist.starttime = debugprofilestop()

	function Checklist:SetupListener()
		local Listener = CreateFrame("FRAME","ZygorGuidesViewerChecklistListener")
		Listener:SetScript("OnEvent", ZGV.Checklist.FrameOnEvent)
		Listener:SetScript("OnUpdate", ZGV.Checklist.FrameOnUpdate)
		Listener:UnregisterAllEvents()

		-- listed in usual startup order
		Listener:RegisterEvent("ADDON_LOADED")
		Listener:RegisterEvent("VARIABLES_LOADED")
		Listener:RegisterEvent("SPELLS_CHANGED") -- not on all startups
		Listener:RegisterEvent("PLAYER_LOGIN")
		Listener:RegisterEvent("PLAYER_ENTERING_WORLD")
		Listener:RegisterEvent("QUEST_LOG_UPDATE")
		Listener:RegisterEvent("PLAYER_ALIVE") -- not on all startups
		Listener:RegisterEvent("ZONE_CHANGED_NEW_AREA") -- does NOT fire on a reload

		Listener:RegisterEvent("PLAYER_CONTROL_GAINED")
		Listener:RegisterEvent("NEW_WMO_CHUNK")
		self.Listener = Listener
	end

	function Checklist:CatchEvent(event,...)
		if not self.events_fired[event] then
			self.events_fired[event] = 1
			--frame:UnregisterEvent(event)
			local s = event.." f=" .. self.framenum .. (" t=%.3f"):format(debugprofilestop()-self.starttime)
				.. "  DG ".. ((abs((ZGV.HBD:TranslateZoneCoordinates(0.5,0.5,1077,0,1018,0) or 0) - 0.41)<0.1) and "OK" or "FAIL")
				.. "  TSL ".. ((abs((ZGV.HBD:TranslateZoneCoordinates(0.5,0.5,1072,0,1024,0) or 0) - 0.347)<0.1) and "OK" or "FAIL")
				.. "  you're in "..ZGV.GetMapNameByID(C_Map.GetBestMapForUnit("player") or 0)
			--print(s)
			tinsert(self.events_sequence,s)
		end
		if self.events_fired["_FIRST_FRAME_"] and self.events_fired["QUEST_LOG_UPDATE"] and self.events_fired["_GUIDES_LOADED_"] and self.events_fired["ZONE_CHANGED_NEW_AREA"] then
			if ZGV.db.profile.delayed_startup then
				print("*** Starting up from checklist!")
				ZGV:LoadInitialGuide()
			else
				print("*** Checklist complete! Would start now.")
			end
			self.Listener:UnregisterAllEvents()
			self.Listener:Hide()
		end
	end

	function Checklist.FrameOnUpdate(frame,elapsed)
		Checklist.framenum = Checklist.framenum + 1
		Checklist:CatchEvent("_FIRST_FRAME_")
		frame:SetScript("OnUpdate",nil)
	end
	function Checklist.FrameOnEvent(frame,event,...)
		Checklist:CatchEvent(event,...)
	end
	--Checklist:SetupListener()
--

function ZGV.IsLegionOn()
	return PlayerCompletedQuest(44663) or ZGV:GetPlayerPreciseLevel()>=101
end


local collectors = {
	[14] = {Horde=11, Alliance=116}, -- arathi highlands warfront
	[62] = {Horde=118, Alliance=117}, -- darkshore warfront
}
function ZGV.InPhase(phasename)
	if not phasename then return true end
	if phasename==ZGV.db.profile.fakephase then return true end

	local level = UnitLevel('player')
	local faction = UnitFactionGroup("player")
	local hasbuff = ZGV.Parser.ConditionEnv.hasbuff
	local state
	local getmapartid = C_Map.GetMapArtID
	local getstate = C_ContributionCollector.GetState

	phasename = phasename:lower():gsub(" ","")

	if phasename=="bfa" then
		if faction=="Horde" then 
			local quest=ZGV.questsbyid[50769]
			return PlayerCompletedQuest(50769) or (quest and quest.inlog)
		else
			local quest=ZGV.questsbyid[46728]
			return PlayerCompletedQuest(46728) or (quest and quest.inlog)
		end
	elseif phasename=="olddarnassus" then
		return getmapartid(62)==67
	elseif phasename=="oldundercity" then
		return getmapartid(18)==19
	elseif (phasename=="oldsilithius" or phasename=="oldsilithus") then
		return getmapartid(81)==86
	elseif phasename=="oldblastedlands" then
		return getmapartid(17)==18
	elseif phasename=="newblastedlands" then
		return getmapartid(17)==628
	elseif phasename=="oldpeak" then
		return hasbuff("spell:609811")
	elseif phasename=="oldarathi" then
		return getmapartid(14)==15
	elseif phasename=="newarathi" then
		return getmapartid(14)==1137
	elseif phasename=="olddustwallow" then
		return getmapartid(70)==75
	elseif phasename=="newdustwallow" then
		return getmapartid(70)==498
	elseif phasename=="warfrontarathiassault" then
		return getstate(collectors[14][faction])<=2 -- state is the same no matter what timetravel phase you are in
	elseif phasename=="warfrontarathicontrol" then
		return getstate(collectors[14][faction])>=3 -- ^
	elseif phasename=="warfrontdarkshoreassault" then
		return getstate(collectors[62][faction])<=2 -- ^
	elseif phasename=="warfrontdarkshorecontrol" then
		return getstate(collectors[62][faction])>=3 -- ^
	end
end

function ZGV:TestPhases()
	local phases = {"olddarnassus","oldundercity","oldsilithus","oldblastedlands","bfa","oldarathi","newarathi","olddustwallow","newdustwallow","oldpeak","warfrontarathiassault","warfrontarathicontrol","warfrontdarkshoreassault","warfrontdarkshorecontrol"}
	for i,ph in ipairs(phases) do
		print(ph,":",ZGV.InPhase(ph) and "|cff00ff00YES" or "|cffff0000NO")
	end
end

function ZGV:IsBoostedChar()
	return IsQuestFlaggedCompleted(34398)
end

function ZGV.IsLegionBoatLock()
	return (IsQuestFlaggedCompleted(40519) or IsQuestFlaggedCompleted(43926)) and not (IsQuestFlaggedCompleted(40593) or IsQuestFlaggedCompleted(40607))
end

function ZGV:SetBeta(val)
	if val~=nil then ZGV.BETA=val return end
	if self.db.profile.debug_beta~=nil then ZGV.BETA=self.db.profile.debug_beta return end
	ZGV.BETA = self.Licences and self.Licences.DATE_E and self.Licences.DATE_E>time()
end



function ZGV:FakeWidescreen()
	WorldFrame:ClearAllPoints()
	WorldFrame:SetPoint("TOPLEFT",ParentUI,"TOPLEFT",0,-150)
	WorldFrame:SetPoint("BOTTOMRIGHT",ParentUI,"BOTTOMRIGHT",0,150)
end

function ZGV:SaveChromieProgress()
	do return 0 end -- TODO: reimplement

	-- returns the number of cleared dragonshrines in Death of Chromie scenario, increased by 1 to mimic |count 1..8
	if not C_Scenario.IsInScenario() then return 1 end

	ZGV.DragonShrineCount = ZGV.DragonShrineCount or 1

	if GetCurrentMapAreaID()~=1177 then return ZGV.DragonShrineCount end
	local count = 5
	for i=1,GetNumMapLandmarks() do
		local _, name, _, _, _, _, _, _, _, areaID, poiID, _, atlasIcon, _ = C_WorldMap.GetMapLandmarkInfo(i)
		if poiID~=5325 then
			count=count-1
		end
	end
	ZGV.DragonShrineCount = count
	return count
end

local dragonshrines = {
	[5317] = "Obsidian", -- Zorathides
	[5318] = "Obsidian", -- dragonshrine
	[5319] = "Ruby", -- Talar Icechill 
	[5320] = "Ruby", -- dragonshrine
	[5321] = "Azure", -- Void Garg 
	[5322] = "Azure", -- dragonshrine
	[5323] = "Emerald", -- Thalas Vyle
	[5324] = "Emerald", -- dragonshrine
}
function ZGV:IsDragonshrineUp(name)
	do return false end -- TODO: reimplement
	
	if not C_Scenario.IsInScenario() then return false end

	if not ZGV.DragonShrineCache then ZGV.DragonShrineCache={} end
	if GetCurrentMapAreaID()~=1177 then return ZGV.DragonShrineCache[name] end
	for i=1,GetNumMapLandmarks() do
		local _, _, _, _, _, _, _, _, _, areaID, poiID, _ = C_WorldMap.GetMapLandmarkInfo(i)
		if dragonshrines[poiID] and dragonshrines[poiID]==name then
			ZGV.DragonShrineCache[name]=true
			return true
		end
	end
	ZGV.DragonShrineCache[name]=false
	return false
end

function ZGV:IsBoosted(boost,do_popup)
	boost = boost or "default"
	self:Debug("Isboosted? "..boost.." "..tostring(do_popup))
	ZGV.db.char.isboosted = ZGV.db.char.isboosted or {}
	boosted = ZGV.db.char.isboosted[boost]
	if type(boosted)=="boolean" then return boosted end
	if boost=="any" or boost=="at all" then return ZGV.db.char.isboosted[90] or ZGV.db.char.isboosted[100] or ZGV.db.char.isboosted[110] end
	if not do_popup then return nil end

	if ZGV.PopupHandler:IsInNC("ZygorBoostConfirm") then return nil end

	-- popup time
	if not self.BoostConfirmPopup then
		self.BoostConfirmPopup =  ZGV.PopupHandler:NewPopup("ZygorBoostConfirm","default")

		local popup = self.BoostConfirmPopup
		popup.acceptbutton:SetText("Yes, I did.")
		popup.OnAccept = function(self)
			ZGV.db.char.isboosted[self.boost]=true
			if ZGV.db.char.isboosted[110] then ZGV.db.char.isboosted[100]=true end
			if ZGV.db.char.isboosted[100] then ZGV.db.char.isboosted[90]=true end
		end
		popup.declinebutton:SetText("No, I didn't.")
		popup.OnDecline = function(self)
			ZGV.db.char.isboosted[self.boost]=false
		end

		popup.noMinimize = 1 --Can not minimize this one
	end
	self.BoostConfirmPopup:SetText("Have you boosted this character to level "..boost.."?")
	self.BoostConfirmPopup.boost = boost

	self:Debug("IsBoosted showing popup")
	self.BoostConfirmPopup:Show()

	return nil
end

function ZGVTEST()
	ZygorMapDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin);

	ZygorMapDataProviderMixin.name="ZygorMapDataProviderMixin"

	function ZygorMapDataProviderMixin:RemoveAllData()
		self:GetMap():RemoveAllPinsByTemplate("ZygorPinTemplate");
	end

	local num_pins = 100

	function ZygorMapDataProviderMixin:RefreshAllData(fromOnShow)
		self:RemoveAllData();
		local mapID = self:GetMap():GetMapID();

		self.pins = self.pins or {}
		for i=1,num_pins do
			pin = self:GetMap():AcquirePin("ZygorPinTemplate")
			pin:SetPosition(0.5,0.5)
			pin:SetScale(50)
			--self.pin:GetRegions():SetTexture(1,1,1,1)
			pin:Show()
			self.pins[i]=pin
			pin.offset=i*4/num_pins
			pin.r=0.4-i*0.002
			pin:SetScript("OnMouseUp",function() print("clicked") end)
		end
	end

	ZygorMapDataProvider = CreateFromMixins(ZygorMapDataProviderMixin)

	WorldMapFrame:AddDataProvider(ZygorMapDataProvider)
	WorldMapFrame:RefreshAllDataProviders()

	ZGV:ScheduleRepeatingTimer(function()
		if ZygorMapDataProvider.pins then 
			for i,pin in ipairs(ZygorMapDataProvider.pins) do
				local t=GetTime() + pin.offset
				pin:SetPosition(0.5+pin.r*math.sin(t*1),0.5+pin.r*math.cos((t+3.1415/4)*2))
			end
			local t1=debugprofilestop()
			for i=1,num_pins do 
				local z = C_Map.GetMapPosFromWorldPos(1,{x=1,y=1}) -- waste memory :(
			end
			local t2=debugprofilestop()
			local t={x=1,y=1}
			for i=1,num_pins do 
				local x = t.x*12345.678/65432.123+98765.432
				local y = t.y*65434.565/34564.453+12345.678
				t.x=t.x+x
				t.y=t.y+y
			end
			local t3=debugprofilestop()
			print(("C_Map:%.2fms vs raw: %.2fms"):format(t2-t1,t3-t2))
		end
	end,0.01)
end
