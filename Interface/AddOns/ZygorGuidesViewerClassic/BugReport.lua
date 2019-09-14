local addon,ZGV = ...

local L = ZGV.L

local table,string,tonumber,tostring,ipairs,pairs,setmetatable = table,string,tonumber,tostring,ipairs,pairs,setmetatable

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local CHAIN = ZGV.ChainCall
local AceGUI = LibStub("AceGUI-3.0-Z")
local ui = ZGV.UI

local BZL,BZR=ZGV.BZL,ZGV.BZR

local BugReport = {Items={}}
--local BugReport = ZGV.BugReport

--[[
local function tostr(val)
	if type(val)=="string" then
		return '"'..val..'"'
	elseif type(val)=="number" then
		return tostring(val)
	elseif not val then
		return "nil"
	elseif type(val)=="boolean" then
		return tostring(val).." ["..type(val).."]"
	end
end
--]]

local dropDownOptions = {
	"Guide Viewer",
	"Waypoint Arrow",
	"Travel System",
	"Gear System",
	"Notification Center",
	"Sticky Steps",
	"Pet Battle UI",
	"General Guide Content Errors",
	"Other",
}

tinsert(ZGV.startups,{"BugReport pruning dumps",function(self)
	ZGV:PruneDumps()
end})

local function superconcat(table,glue)
	local s=""
	for i=1,#table do
		if #s>0 then s=s..glue end
		s=s..tostring(table[i])
	end
	return s
end

local function SkinData(property)
--[[	if ZGV.CurrentSkinStyle.id=="midnight" and property=="Backdrop" then
		return {
				bgFile = "Interface/Tooltips/UI-Tooltip-Background",
				edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
				tile = true, tileSize = 32, edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			}
	else--]]
		return ZGV.CurrentSkinStyle:SkinData(property)
	--end
end

-- misc:
local function CreateDumpFrameBasic()
	local name = "ZygorGuidesViewer_DumpFrameBasic"

	local frame = CHAIN(ui:Create("Frame",UIParent,name))
		:SetSize(900,570)
		:SetPoint("CENTER", UIParent, "CENTER")
		:SetFrameStrata("FULLSCREEN")
		:Hide()
		.__END
	if ZGV.DEV then frame:CanDrag(true) end

	ZGV.dumpFrameBasic = frame
	tinsert(UISpecialFrames, name)

	local scroll = CHAIN(ui:Create("ScrollChild",frame,name.."Scroll","editbox"))
		:SetBackdrop(SkinData("BugBackdrop"))
		:SetBackdropColor(unpack(SkinData("BugBackdropColor")))
		:SetPoint("TOPLEFT", frame, 8, -50)
		:MySetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 38)
		:HookScript("OnShow",function(me) me.child:SetFocus(true) end)
	.__END
	frame.scroll = scroll

	scroll.child:SetScript("OnEscapePressed", function() frame.save=nil frame:Hide() end)
	frame.editBox = scroll.child

	local close = CHAIN(CreateFrame("Button", nil, frame))
		:SetPoint("TOPRIGHT", frame, "TOPRIGHT",-5,-5)
		:SetSize(15,15)
		:SetScript("OnClick",function() frame:Hide() end)
	.__END
	ZGV.F.AssignButtonTexture(close,(SkinData("TitleButtons")),6,32)

	local title = CHAIN(frame:CreateFontString(nil,"OVERLAY"))
		:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
		:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -30, -45)
		:SetFont(FONTBOLD,14)
		:SetJustifyH("CENTER")
		:SetJustifyV("TOP")
		.__END
	frame.title = title

	frame.OKButton = CHAIN(ui:Create("Button",frame))
		:SetSize(200,25)
		:SetText("OK")
		:SetFont(FONTBOLD,14)
		:SetPoint("BOTTOM", frame, "BOTTOM",0,5)
		--		:SetScript("OnClick",function(self) if frame.save and frame.timestamp then ZGV:SaveDump(frame.editBox:GetText(),frame.timestamp) frame.save=nil frame.timestamp=nil end  frame:Hide()  end)
		:SetScript("OnClick",function(self)
			if ZygorGuidesViewer_DumpFrameReport and ZygorGuidesViewer_DumpFrameReport:IsShown() then
				ZygorGuidesViewer_DumpFrameReport.text = frame.editBox:GetText()  -- save modified text
			end
			frame:Hide()
		end)
	.__END

	if ZGV.DEV then
		local oldreports = CHAIN(ui:Create("DropDown",frame))
			:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,0)
			:SetWidth(125)
			:SetText("Old Reports")
		.__END
		oldreports.frame:Show()

		if ZGV.db.global.bugreports then
			for time,report in pairs(ZGV.db.global.bugreports) do
				oldreports:AddItem(date("%m/%d/%y %H:%M:%S",time),nil,function(self)
					frame.editBox:SetText(report.text:gsub("%%%%","\n"))
				end)
			end
		end

		frame.oldreports = oldreports
	end
end

local function CreateDumpFrameReport()
	local name = "ZygorGuidesViewer_DumpFrameReport"

	local frame = CHAIN(ui:Create("Frame",UIParent,name))
		:SetSize(500,470)
		:SetPoint("CENTER", UIParent, "CENTER")
		:SetFrameStrata("FULLSCREEN")
		:Hide()
		.__END
	if ZGV.DEV then frame:CanDrag(true) end

	ZGV.dumpFrameReport = frame
	tinsert(UISpecialFrames, name)

	local title = CHAIN(frame:CreateFontString(nil,"OVERLAY"))
		:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
		:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -30, -45)
		:SetFont(FONTBOLD,15)
		:SetText(L['bugreport_header'])
		:SetJustifyH("LEFT")
		:SetJustifyV("TOP")
	.__END
	frame.title = title

	-- DropDown
		local selector = CHAIN(ui:Create("DropDown",frame))
			:SetPoint("TOPLEFT",title,"BOTTOMLEFT",0,10)
			:SetWidth(200)
			:SetText(L['bugreport_bugtype'])
		.__END
		selector.frame:Show()

		for i,opt in pairs(dropDownOptions) do
			selector:AddItem(opt)
		end

		frame.selector = selector

	-- Box 1
		frame.header1 = CHAIN(frame:CreateFontString(nil,"OVERLAY"))
			:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -25)
			:SetWidth(460)
			:SetFont(FONT,14)
			:SetJustifyH("LEFT")
			:SetJustifyV("TOP")
			:SetWordWrap(true)
			:SetText(L['bugreport_description'])
		.__END

		frame.scroll1 = CHAIN(ui:Create("ScrollChild",frame,name.."Scroll1","editbox"))
			:SetBackdrop(SkinData("BugBackdrop"))
			:SetBackdropColor(unpack(SkinData("BugBackdropColor")))
			--:SetHideWhenUseless(1)
			:SetSize(480,135)
			:SetPoint("TOPLEFT", frame.header1, "BOTTOMLEFT", 0, -10)
			:MySetPoint("BOTTOMRIGHT", frame, "RIGHT", -10, 0)
		.__END

		CHAIN(frame.scroll1.child)
			:SetScript("OnEscapePressed", function() frame.save=nil frame:Hide() end)
			:SetScript("OnTabPressed", function() frame.edit2Box:SetFocus(true) end)
			:SetFont(FONT,12)

		frame.edit1Box = frame.scroll1.child

	-- Box 2
		frame.header2= CHAIN(frame:CreateFontString(nil,"OVERLAY"))
			:SetPoint("TOPLEFT", frame.scroll1, "BOTTOMLEFT",0,-10)
			:SetFont(FONT,14)
			:SetJustifyH("LEFT")
			:SetJustifyV("TOP")
			:SetWidth(460)
			:SetWordWrap(true)
			:SetText(L['bugreport_info'])
		.__END

		frame.scroll2 = CHAIN(ui:Create("ScrollChild",frame,name.."Scroll2","editbox"))
			:SetBackdrop(SkinData("BugBackdrop"))
			:SetBackdropColor(unpack(SkinData("BugBackdropColor")))
			--:SetHideWhenUnless(1)
			:SetSize(480,135)
			:SetPoint("TOPLEFT", frame.header2, "BOTTOMLEFT", 0, -10)
			:MySetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 35)
		.__END

		CHAIN(frame.scroll2.child)
			:SetScript("OnEscapePressed", function() frame.save=nil frame:Hide() end)
			:SetScript("OnTabPressed", function() frame.edit1Box:SetFocus(true) end)
			:SetFont(FONT,12)

		frame.edit2Box = frame.scroll2.child

	--[[
	-- Box 3
		frame.header3 = CHAIN(frame:CreateFontString(nil,"OVERLAY"))
			:SetPoint("TOPLEFT", frame.editFrame2, "BOTTOMLEFT",0,-10)
			:SetFont(FONT,14)
			:SetJustifyH("CENTER")
			:SetJustifyV("TOP")
			:SetText("What information do you think will be important for fixing the issue?")
		.__END

		frame.edit3Box = CHAIN(CreateFrame("EditBox", nil, frame))
			:SetMultiLine(true)
			--:SetMaxLetters(999999)
			:EnableMouse(true)
			:SetAutoFocus(false)
			:SetFont(FONT,12)
			:SetWidth(400)
			:SetHeight(270)
			:SetScript("OnEscapePressed", function() frame.save=nil frame:Hide() end)
			:SetScript("OnTabPressed", function() frame.edit1Box:SetFocus(true) end)
			.__END

		frame.editFrame3 = CHAIN(CreateFrame("Button", name, frame))
			:SetBackdrop(SkinData("Backdrop"))
			:SetBackdropColor(unpack(SkinData("GuideBackdropColor")))
			:SetBackdropBorderColor(unpack(SkinData("GuideBackdropBorderColor")))
			:SetSize(480,100)
			:SetPoint("TOPLEFT", frame.header3, "BOTTOMLEFT", 0, -10)
			:RegisterForClicks("LeftButton")
			:EnableMouse(true)
			:SetScript("OnClick", function() frame.edit1Box:SetFocus(true) end)
		.__END

		frame.edit3Box:SetAllPoints(frame.editFrame3)

	--]]

	local close = CHAIN(CreateFrame("Button", nil, frame))
		:SetPoint("TOPRIGHT", frame, "TOPRIGHT",-5,-5)
		:SetSize(15,15)
		:SetScript("OnClick",function() frame:Hide() end)
	.__END
	ZGV.F.AssignButtonTexture(close,(SkinData("TitleButtons")),6,32)

	frame.OKButton = CHAIN(ui:Create("Button",frame))
		:SetSize(200,25)
		:SetText(L['bugreport_button_save'])
		:SetFont(FONTBOLD,14)
		:SetPoint("BOTTOM", frame, "BOTTOM",0,5)
		:SetScript("OnClick",function(self)
			local function safexml(s)  return s:gsub("<","&lt;"):gsub(">","&gt;")  end
			if frame.save and frame.timestamp and frame.text then
				local text = "<report timestamp=\"" .. frame.timestamp .. "\">"
					  ..   "<type>" .. safexml(frame.selector.text:GetText()) .."</type>"
				          ..   "<description>" .. safexml(frame.edit1Box:GetText()) .."</description>"
				          ..   "<info>" .. safexml(frame.edit2Box:GetText()) .."</info>"
				          ..   "<body>" .. safexml(frame.text) .."</body>"
					  .. "</report>"
				ZGV:SaveDump(text, frame.timestamp)
				frame.save=nil
				frame.timestamp=nil
			end
			frame:Hide()
		end)
	.__END

	local viewbut = CHAIN(ui:Create("Button",frame))
		:SetSize(100,25)
		:SetText(L['bugreport_button_view'])
		:SetFont(FONTBOLD,14)
		:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT",5,5)
		:SetScript("OnClick",function(self)
			if frame.text then
				ZGV:ShowDump(frame.text,"Bug Report Contents")
			end
		end)
	.__END
end

local function dumpquest(quest)
	local s = ("%d. \"%s\" ##%d (lv=%d%s):\n"):format(quest.index,quest.title,quest.id,quest.level,quest.complete and ", complete" or "")
	if quest.goals then
		for i,goal in ipairs(quest.goals) do
			s = s .. ("... %d. \"%s\" (%s, %s/%s%s)\n"):format(i,goal.leaderboard,goal.type,goal.num,goal.needed,goal.complete and ", complete" or "")
		end
	end
	return s
end

local function anytostring(s)
	if type(s)=="table" then
		return superconcat(s,",")
	else
		return tostring(s)
	end
end

local BugReportFlags = {guide=1,step=1,player=1,questlog=1,inventory=1,parselog=1,itemscore=1}

function ZGV:GetBugReport(maint)
	local s = ""

	s = s .. ("Zygor Guides Viewer v%s\n"):format(self.version)
	s = s .. ("Guide: %s\nStep: %d\n"):format(self.CurrentGuideName or "no guide",self.CurrentStepNum or 0)
	s = s .. "\n"

	if maint then
		s = s .. "\nMAINTENANCE OPTIONS THAT WERE ENABLED PROPERLY: ______________\nMAINTENANCE OPTION THAT CAUSED DISCONNECTION: _______________\n\n"
	end

	if BugReportFlags.player then
		s = s .. "--- Player information ---\n"
		s = s .. ("Race: %s  Class: %s  Level: %.2f   Faction: %s\n"):format(
			select(2,UnitRace("player")),select(2,UnitClass("player")), self:GetPlayerPreciseLevel(),UnitFactionGroup("player"))
		local mapid = C_Map.GetBestMapForUnit("player") or -1
		local coords = C_Map.GetPlayerMapPosition(mapid,"player")
		local x,y = coords.x,coords.y
		microname=microname or ""
		s = s .. ("Position: |cffffeeaa%s ##%d %.2f,%.2f|r (zone:'%s', realzone:'%s', subzone:'%s', minimapzone:'%s')\n"):format(
		 ZGV.GetMapNameByID(mapid) or "?",mapid, (x or 0)*100,(y or 0)*100,
		 GetZoneText(),GetRealZoneText(),GetSubZoneText(),GetMinimapZoneText())
		if GetLocale()~="enUS" then
			--s = s .. ("    enUS: realzone:'%s' zone:'%s' subzone:'%s' minimapzone:'%s')\n"):format(tostring(BZR[GetRealZoneText()]),tostring(BZR[GetZoneText()]),BZR[GetSubZoneText()] or "("..GetSubZoneText()..")",BZR[GetMinimapZoneText()] or "("..GetMinimapZoneText()..")")
			s = s .. ("Locale: %s\n"):format(GetLocale())
		end
		if UnitClass("target") then
			s = s .. ("Target: %s ##%s\n"):format(UnitName("target"),ZGV.GetTargetId())
		end

		--[[ disabled for classic
		s = s .. "\n\n--Professions\n"
		local profTable = {GetProfessions()}
		local found
		for num,prof in pairs (profTable) do
			found = true
			name,_,level,maxlevel=GetProfessionInfo(prof)
			s = s..(" %s - Current Level: %d Max Level: %d\n"):format(name,level,maxlevel)
		end
		if not found then s = s.. "NONE" end
		--]]

		s = s .. "\n\n--Enabled Addons\n"
		local numAddons  = GetNumAddOns()
		for i=1,numAddons do
			local name,_,_,enabled = GetAddOnInfo(i)
			if enabled then s = s .. " "..name .. "\n" end
		end

	end

	if BugReportFlags.parselog then
		s = s .. "\n\n--- Parser Errors ---\n"..(ZGV.ParseLog~="" and ZGV.ParseLog or "NONE\n").."\n"
	end

	if BugReportFlags.guide then
		s = s .. "\n\n--- GUIDE ---\n"
		if self.CurrentGuide and not self.CurrentGuide.parse_failed then
			s = s .. ("Guide: %s\n"):format(tostring(self.CurrentGuide.title_short))
			local g = self.CurrentGuide
			s = s .. ("Type: %s  Parsed: %s  Fully: %s\n"):format(tostring(g.type),g.parsed and "yes" or "no", g.fully_parsed and "yes" or "no")
			s = s .. ("Startlevel: %s  Endlevel: %s\n"):format(tostring(g.startlevel),tostring(g.endlevel))
			s = s .. ("Next: %s \n"):format(tostring(g.next))
			local labels = ""
			for label,steps in pairs(g.steplabels) do
				labels = labels .. " " .. label .. "="
				for i,step in ipairs(steps) do
					labels = labels .. tostring(step) .. ","
				end
			end
			s = s .. ("Steps: %d  Labels: %s\n"):format(#g.steps,labels)
		else
			s = s .. "(no guide loaded)\n"
		end
	end

	if BugReportFlags.step then
		local step = self.CurrentStep
		s = s .. "\n\n--- STEP ---\n"
		if step then
			for k,v in pairs(step) do
				local f

				if k=="map" then
					f=(ZGV.GetMapNameByID(step.map) or '') .. '#'..tostring(step.map) .. " /"..tostring(step.floor)
				elseif k=="waypath" then
					f=(#v.coords).." points"
				elseif k~="goals" and k~="num" and k~="L"
				 and k~="isobsolete" and k~="isauxiliary"
				 and k~="parentGuide"
				 and k~="prepared"
				 and type(v)~="function" then
					f = anytostring(v)
				end
				if f then
					s = s .. ("  %s: %s\n"):format(k,f)
				end
			end
			local complete,possible,progress = step:IsComplete()
			s = s .. ("  (%s, %s, %s)\n"):format(complete and "COMPLETE" or "incomplete", possible and "POSSIBLE" or "impossible", step:IsAuxiliary() and "AUX" or "not aux")

			s = s .. "Goals: \n"

			for i,goal in ipairs(step.goals) do
				s = s .. ("%d. %s %s\n"):format(i,(". "):rep(goal.indent),goal.text and "\""..goal.text.."\"" or "<"..goal:GetText()..">")
				for k,v in pairs(goal) do
					local f
					-- hide these completely
					if k~="map" and k~="mapL" and k~="x" and k~="y" and k~="dist" and k~="floor"
					and k~="L"
					and k~="indent" and k~="text" and k~="parentStep" and k~="num" and k~="status"
					-- these get their own display
					and k~="item" and k~="itemid"
					and k~="castspell" and k~="castspellid"
					and k~="quest" and k~="questid" and k~="questreqs"
					and k~="lasttext" and k~="lastbrief" and k~="lastshowcompleteness"
					and k~="mobs"
					and k~="target" and k~="targetid" and k~="objnum"
					and k~="condition_visible_raw" and k~="condition_complete_raw"
					and type(v)~="function" then
						f = anytostring(v)
					end
					if f then
						s = s .. ("    %s: %s\n"):format(k,f)
					end
				end
				if goal.x or goal.y or goal.action=="goto" then
					local map
					if goal.map then
						map = (ZGV.GetMapNameByID(goal.map) or '') .. ' |r#|cff888888'..tostring(goal.map) .. " |r/|cffffaa00"..tostring(goal.floor)
					else
						map = "unknown"
					end
					s = s .. ("    map: |cffffdd00%s |cffaaff00%s,%s"):format(map,goal.x or "-",goal.y or "-")
					if goal.dist then s = s .. ("|cffff8800 %s%s"):format(goal.dist>0 and ">" or "<",math.abs(goal.dist)) else s = s .. ("|cffff8800 (no dist)") end
					s = s .. "|r\n"
				end
				if goal.itemid or goal.item then
					s = s .. ("   item: \"%s\"  ##%s"):format(tostring(goal.item),tostring(goal.itemid))
					if goal.itemid then
						local a={ZGV:GetItemInfo(goal.itemid)}
						s = s .. ("  ZGV:GetItemInfo(%d) == %s\n"):format(goal.itemid,superconcat(a,","))
					elseif goal.item then
						local a={ZGV:GetItemInfo(goal.item)}
						s = s .. ("  ZGV:GetItemInfo(\"%s\") == %s\n"):format(goal.item,superconcat(a,","))
					end
				end
				if goal.castspellid or goal.castspell then
					s = s .. ("   castspell: \"%s\"  ##%s"):format(tostring(goal.castspell),tostring(goal.castspellid))
					if goal.castspellid then
						local a={GetSpellInfo(goal.castspellid)}
						s = s .. ("  GetSpellInfo(%d) == %s\n"):format(goal.castspellid,superconcat(a,","))
					elseif goal.castspell then
						local a={GetSpellInfo(goal.castspell)}
						s = s .. ("  GetSpellInfo(\"%s\") == %s\n"):format(goal.castspell,superconcat(a,","))
					end
				end
				if goal.questid and goal.quest then
					local questdata,inlog = ZGV.Localizers:GetQuestData(goal.questid)
					s = s .. ("    quest: \"%s\" ##%s"):format(questdata and questdata.title or "?",tostring(goal.questid))
					if goal.questid then
						if goal.objnum then
							if questdata and questdata.goals then
								local goaltext = questdata.goals[goal.objnum].item
								if not goaltext then goaltext="???" end
								s = s .. (" goal %d: \"%s\""):format(goal.objnum,goaltext)
							else
								s = s .. (" goal %d"):format(goal.objnum)
							end
						else
							s = s .. (" (no goal)")
						end
						if inlog then
							s = s .. "  - quest in log "
						else
							s = s .. "  - quest not in log "
						end
						if self.completedQuests[goal.questid] then
							s = s .. "(id: completed)"
						else
							s = s .. "(id: not completed)"

							-- deprecating title storing totally, since GetQuestID is here.
							--[[
							if self.completedQuestTitles[goal.quest] then
								s = s .. " (title: completed)"
							else
								s = s .. " (title: not completed)"
							end
							--]]
						end
					end
					s = s .. "\n"
				end
				if goal.target then
					s = s .. ("    target: \"%s\""):format(goal.target)
					if goal.targetid then
						s = s .. (" ##%d\n"):format(goal.targetid)
					end
					s = s .. "\n"
				end
				if goal.mobs then
					s = s .. "    mobs: "
					for k,v in ipairs(goal.mobs) do
						s = s .. v.name .. "  "
					end
					s = s .. "\n"
				end
				if goal.questreqs and #goal.questreqs>0 then
					s = s .. "    questreqs: "..superconcat(goal.questreqs,",").."\n"
				end
				if goal.condition_visible then
					s = s .. "    visibility condition: "..goal.condition_visible_raw.."\n"
				end
				if goal.condition_complete then
					s = s .. "    completion condition: "..goal.condition_complete_raw.."\n"
				end

				s = s .. "    Status: "..goal:GetStatus()

				if goal:IsCompleteable() then
					local comp,poss,prog,explanation,isbad = goal:IsComplete()
					s = s .. (" (%s, %s, %s progress, %s, '%s'%s)\n"):format(comp and "|cff00ff00COMPLETE|r" or "|cffffaa00incomplete|r", poss and "|cffbbff00POSSIBLE|r" or "|cff880000impossible|r", tostring(prog), step:IsAuxiliary() and "|cff8888ffAUX|r" or "|cff8888aanot aux|r" , tostring(explanation) or "-", isbad and " WARNING" or "")
				else
					s = s .. "  (|cff008800not completable|r)\n"
				end
			end
		else
			s = s .. "No current step loaded.\n"
		end
	end

	--[[ disabled for classic
	if BugReportFlags.itemscore then
		local ItemScore = ZGV.ItemScore
		local Upgrades = ItemScore.Upgrades

		s = s .. "\n\n-- Auto Equip Information --"

		s = s .. ("Class: %s\nLevel: %s\nSpec: %s\n"):format(ItemScore.playerclass,ItemScore.playerlevel,select(2,GetSpecializationInfo(ItemScore.playerspec or 0)))
		if Upgrades.EquippedItems then
			s = s.."\nCurrent Gear\n"

			for slot,info in pairs(Upgrades.EquippedItems) do
				s = s.."   "..slot.. (" - %s scored: %d\n"):format(info.itemlink or "no item", info.score or 0)
			end
		end
		if Upgrades.UpgradeQueue then
			s = s.."\nPossible Upgrades\n"

			for slot,info in pairs(Upgrades.UpgradeQueue) do
				if info.itemlink then
					s = s.."   "..slot.. (" - %s scored: %d\n"):format(info.itemlink or "no item", info.score or 0)
				end
			end
		end

		if ZGV.db.profile.autogear then
			s = s.."\nGearfinder Dungeons\n"
			for dungeon,dungeondata in pairs(ZygorGuidesViewer.ItemScore.Items) do
				local valid, future, ident, maxscale, mythic, comment = ZGV.ItemScore.GearFinder:IsValidDungeon(dungeondata.dungeon, dungeondata.instanceId)
				s = s..(" - %s %s %s\n"):format(dungeon, (valid and "valid" or "invalid"), comment or "")
			end
		end
	end
	--]]

	if BugReportFlags.questlog then
		s = s .. "\n\n--- Cached quest log ---\n"
		if self.quests then
			for index,quest in pairs(self.quests) do
				s = s .. dumpquest(quest)
			end
		else
			s = s .. "(no quest log)"
		end
		s = s .. "\n"

		s = s .. "--- Cached quests, by ID ---\n"
		if self.questsbyid then
			for id,quest in pairs(self.questsbyid) do
				s = s .. ("#%d: %s\n"):format(id,quest.title)
			end
		else
			s = s .. "(no quest log)"
		end
	end

	if BugReportFlags.inventory then
		s = s .. "\n\n--- Inventory ---\n"
		local inventory={}
		for bag=-2,4 do
			for slot=1,GetContainerNumSlots(bag) do
				local item = GetContainerItemLink(bag,slot)
				if item then
					local tex,count = GetContainerItemInfo(bag,slot)
					local id,name = string.match(item,"item:(%d-):.-|h%[(.-)%]")
					if name then
						tinsert(inventory,("    %s ##%d x%d\n"):format(name or "?",id or 0,count or 0))
					else
						id,name = string.match(item,"battlepet:(%d-):.-|h%[(.-)%]")
						if name then
							tinsert(inventory,("    CAGED PET: %s ##%d x%d\n"):format(name or "?",id or 0,count or 0))
						else
							tinsert(inventory,"    ? "..item)
						end
					end
				end
			end
		end
		table.sort(inventory)
		s = s .. table.concat(inventory,"")
	end

	s = s .. "\n\n-- Buffs --\n"
	for i=1,30 do
		local name,texid = UnitBuff("player",i)
		if name then s=s..("%s (%d)\n"):format(name,texid) end
	end
	s = s .. "\n\n-- Debuffs --\n"
	for i=1,30 do
		local name,texid = UnitDebuff("player",i)
		if name then s=s..("%s (%d)\n"):format(name,texid) end
	end

	s = s .. "\n\n-- Pet action bar --\n"
	for i=1,12 do
		local name,texid = GetPetActionInfo(i)
		if name then s=s..("%d. %s (\"%s\")\n"):format(i,name,texid) end
	end

	s = s .. "\n\n-- Flight Paths --\n"
	if self.LibTaxi then
		s = s .. table.concat(ZGV.TableKeys(self.db.char.taxis)," , ")
	end

	if ZGV.db.profile.pathfinding and LibRover.RESULTS then
		s = s .. "\n\n-- Travel Route --\n"
		for k,v in ipairs(LibRover.RESULTS) do
			s = s .. (" %d. %s\n"):format(k,v:tostring())
		end
		if #LibRover.RESULTS_SKIPPED_START>0 then
			s = s .. "  Skipped at start:\n"
			for k,v in ipairs(LibRover.RESULTS_SKIPPED_START) do
				s = s .. (" %s\n"):format(v:tostring())
			end
		end
		if #LibRover.RESULTS_SKIPPED_END>0 then
			s = s .. "  Skipped at end:\n"
			for k,v in ipairs(LibRover.RESULTS_SKIPPED_END) do
				s = s .. (" %s\n"):format(v:tostring())
			end
		end
		s = s .. "\n\n"
	end

	s = s .. "\n\n-- Options --\n"
	s = s .. "Profile:\n"
	for k,v in pairs(self.db.profile) do s = s .. "  "..k.." = "..anytostring(v)..",  " end

	--s = s .. self:DumpVal(self.quests,0,4,true)
	--self:Print(s)
	if self.ErrorLogger_GetErrors then
		local errors = self:ErrorLogger_GetErrors()
		if #errors>0 then
			s = s .. "-- Errors --\n"
			for ei,err in ipairs(errors) do s = s .. "----------------\nTime: "..(err.time or "?").."\nCount: "..(err.count or 1).."\nError: \n"..tostring(err.message).."\n----------------\n" end
		end
	end

	s = s .. "-- Log --\n"
	s = s .. self.Log:Dump(100)

	return s
end

function ZGV:BugReport(maint)
	local report = ZGV:GetBugReport(maint)

	local title = maint and "Zygor Guides Viewer" or (self.CurrentGuideName or L["report_notitle"])
	local author = maint and "zygor@zygorguides.com" or (self.CurrentGuide and self.CurrentGuide.author or L["report_noauthor"])

	title = L["report_title"..(ZGV.DEV and "_2" or "")]:format(title,author)

	Screenshot()

	self:DelayedShowReportDialog(report)
end


function ZGV:SaveDump(text,timestamp)
	ZGV.db.global.bugreports = ZGV.db.global.bugreports or {}
	ZGV.db.global.bugreports[timestamp]={text=text}
	if ZGV.DEV then ZGV:Print("Bug report saved for upload.") end
end

function ZGV:PruneDumps()
	if not ZGV.db.global.bugreports then return end
	for timestamp,report in pairs(ZGV.db.global.bugreports) do
		if time()-timestamp > 86400*7 then ZGV.db.global.bugreports[timestamp]=nil end  -- delete week-old
		if #report.text==0 then ZGV.db.global.bugreports[timestamp]=nil end
	end
end


function ZGV:ShowDump(text,title,editable,action,cursorpos)
	local f

	HideUIPanel(InterfaceOptionsFrame)
	HideUIPanel(ZygorGuidesViewerMaintenanceFrame)

	if type(text)=="table" then text=ZGV:Serialize(text) end

	if not self.dumpFrameBasic then CreateDumpFrameBasic() end
	f = self.dumpFrameBasic

	f.editBox:SetText(text)
	f.title:SetText(title or "Generic dump:")
	f:SetFrameLevel(999)

	if action == "copy" then
		self.dumpFrame.editBox:HighlightText(0)
		self.dumpFrame.editBox:SetFocus(true)
	end

	ShowUIPanel(f)
end

--local DELAYFRAME
function ZGV:DelayedShowReportDialog(report)
	--if not DELAYFRAME then DELAYFRAME=CreateFrame("FRAME") end
	--DELAYFRAME:SetScript("OnUpdate",function(self) ZGV:ShowReportDialog(report) self:SetScript("OnUpdate",nil) end)
	ZGV:ScheduleTimer(function() ZGV:ShowReportDialog(report) end, 0.5)
end

function ZGV:ShowReportDialog(report)
	if not self.dumpFrameReport then CreateDumpFrameReport() end
	f = self.dumpFrameReport

	f.timestamp = time()
	f.save = true
	f.text = report

	-- SAVE disabled as it just doesn't work..!
	f.OKButton:Hide()

	-- Clear the text
	f.edit1Box:SetText("")
	f.edit2Box:SetText("")
	--f.edit3Box:SetText("")

	ShowUIPanel(f)

	f.edit1Box:SetFocus(true)
end

function ZGV:DumpVal(val,lev,maxlev,nofun)
	if not lev then lev=1 end
	if not maxlev then maxlev=1 end

	if lev>maxlev then return ("...") end
	local s = ""
	if type(val)=="string" then
		s = ('"%s"'):format(val)
	elseif type(val)=="number" then
		s = ("%s"):format(tostring(val))
	elseif type(val)=="function" then
		s = ("")
	elseif type(val)=="table" then
		s = "\n"
		for k,v in pairs(val) do
			if type(k)~="string" or not k:find("^parent")
			then
				if type(v)~="function" then
					s = s .. ("   "):rep(lev) .. ("%s=%s"):format(k,self:DumpVal(v,lev+1,maxlev,nofun))
				elseif not nofun then
					s = s .. ("   "):rep(lev) .. ("%s(function)\n"):format(k)
				end
			end
		end
	end

	return s.."\n"
end

local looped

local lua_reserved_words = {}
for _, v in ipairs ({
    "and", "break", "do", "else", "elseif", "end", "false",
    "for", "function", "if", "in", "local", "nil", "not", "or",
    "repeat", "return", "then", "true", "until", "while"
}) do lua_reserved_words [v] = true end
local function safe_word(s)
	return not lua_reserved_words[s] and s:match("^%a[%a%d_]*$")
end

local function escape(s)
	return '"' .. s:gsub('\\','\\\\'):gsub('"','\\"') .. '"'
end

local function alphasort(a,b)
	local na,nb=tonumber(a),tonumber(b)
	if na and nb then return na<nb end
	if na and not nb then return true end
	if nb and not na then return false end
	return tostring(a)<tostring(b)
end

function ZGV:Serialize(val,lev,ignore)
	lev=lev or 0
	if lev==0 then looped={} end
	local s = ""
	local indent = ""
	for i=1,lev do indent=indent.."  " end

	if type(val)=="string" then
		s = ('"%s"'):format(val)
	elseif type(val)=="number" then
		s = ("%s"):format(tostring(val))
	elseif type(val)=="function" then
		s = ("nil  --function")
	elseif type(val)=="table" then
		if looped[val] then return "nil"," --loop!" end
		looped[val]=true
		s = "{"
		local keys = {}
		for k,v in pairs(val) do tinsert(keys,k) end
		table.sort(keys,alphasort)
		for _,k in ipairs(keys) do
			if ignore and ignore[k] then k=k.."_ignored" end
			local v = val[k]
			s = s .. "\n" .. indent .. "  "
			if type(k)=="number" then s = s .. "[" .. tostring(k) .. "]"
			elseif type(k)=="string" then
				if safe_word(k) then s = s .. k
				else s = s .. '[' .. escape(k) .. ']'
				end
			end
			local ser,cmt = self:Serialize(v,lev+1,ignore)
			s = s .. " = " .. ser .. "," .. (cmt or "")
		end
		s = s .. "\n" .. indent .. "}"
	elseif type(val)=="nil" then
		s = "nil"
	elseif type(val)=="boolean" then
		s = tostring(val)
	end

	return s
end
