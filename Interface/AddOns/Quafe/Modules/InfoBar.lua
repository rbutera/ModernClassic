local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

--- ------------------------------------------------------------
--> API Localization
--- ------------------------------------------------------------

local _G = getfenv(0)
local format = string.format
local find = string.find

local min = math.min
local max = math.max
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad
local acos = math.acos
local atan = math.atan
local rad = math.rad
local modf = math.modf

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

local backdrop = {
	bgFile = F.Path("White"),
	edgeFile = "",
	tile = true, tileSize = 0, edgeSize = 0,
	insets = {left = 1, right = 1, top = 1, bottom = 1}
}

local MicroMenuBackdrop = {
	bgFile = F.Path("White"),
	edgeFile = "",
	tile = true, tileSize = 0, edgeSize = 0,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
}

local function GameTooltip_InitPos(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
	GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0,4)
end

local function MBCC_Hide()
	--> Hide MBCC
	local MBCC = _G["Quafe_InfoBar.MBCC"]
	if MBCC and MBCC:IsShown() then
		MBCC:Hide()
	end
end

--- ------------------------------------------------------------
--> MicroMenu
--- ------------------------------------------------------------
local MICROMENU_BUTTONS = {
	[1] = {"CharacterMicroButton", CHARACTER_BUTTON, NEWBIE_TOOLTIP_CHARACTER, "MB_Character"},
	[2] = {"SpellbookMicroButton", SPELLBOOK_ABILITIES_BUTTON, NEWBIE_TOOLTIP_SPELLBOOK, "MB_Spellbook"},
	[3] = {"TalentMicroButton", TALENTS_BUTTON, NEWBIE_TOOLTIP_TALENTS, "MB_Talent"},
	[4] = {"AchievementMicroButton", ACHIEVEMENT_BUTTON, NEWBIE_TOOLTIP_ACHIEVEMENT, "MB_Achievement"},
	[5] = {"QuestLogMicroButton", QUESTLOG_BUTTON, NEWBIE_TOOLTIP_QUESTLOG, "MB_Questlog"},
	[6] = {"GuildMicroButton", LOOKINGFORGUILD, NEWBIE_TOOLTIP_LOOKINGFORGUILDTAB, "MB_Guild"},
	[7] = {"LFDMicroButton", DUNGEONS_BUTTON, NEWBIE_TOOLTIP_LFGPARENT, "MB_LFD"},
	[8] = {"EJMicroButton", ENCOUNTER_JOURNAL, NEWBIE_TOOLTIP_ENCOUNTER_JOURNAL, "MB_EJ"},
	[9] = {"CollectionsMicroButton", COLLECTIONS, NEWBIE_TOOLTIP_MOUNTS_AND_PETS, "MB_Collection"},
	[10] = {"StoreMicroButton", BLIZZARD_STORE, BLIZZARD_STORE, "MB_Shop"},
	[11] = {"MainMenuMicroButton", MAINMENU_BUTTON, NEWBIE_TOOLTIP_MAINMENU, "MB_Menu"},
}

local function MicroMenu_Frame(f)
	local MicroMenu = CreateFrame("Button", "Quafe_InfoBar.MicroMenuButton", f, "SecureHandlerEnterLeaveTemplate")
	MicroMenu: SetSize(32,26)
	MicroMenu: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0,0)
	--MicroMenu: SetAlpha(1)
	MicroMenu: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	MicroMenu: SetAttribute("motionScriptsWhileDisabled", true)
	MicroMenu: SetBackdrop(backdrop)
	MicroMenu: SetBackdropColor(F.Color(C.Color.Main0, 0.6))
	
	local Icon = MicroMenu:CreateTexture("Quafe.InfoBar.MicroMenuButtonIcon", "ARTWORK")
	Icon: SetTexture(F.Path("Icons\\Menu16"))
	Icon: SetVertexColor(F.Color(C.Color.Main1))
	Icon: SetAlpha(0.8)
	Icon: SetSize(16,16)
	Icon: SetPoint("CENTER", MicroMenu, "CENTER", 0,0)

	local MenuContainer = CreateFrame("Frame", nil, MicroMenu, "SecureHandlerEnterLeaveTemplate")
	MenuContainer: SetFrameStrata("HIGH")
	MenuContainer: SetSize(44,10+22*(#MICROMENU_BUTTONS))
	MenuContainer: SetPoint("BOTTOMLEFT", MicroMenu, "TOPLEFT", 0,4)
	MenuContainer: SetBackdrop(backdrop)
	MenuContainer: SetBackdropColor(F.Color(C.Color.Main0, 0.8))
	MenuContainer: Hide()

	local function MicroMenuButton_OnEnter(self, noNormalText)
		if ( self:IsEnabled() or self.minLevel or self.disabledTooltip or self.factionGroup) then
			GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
			GameTooltip:SetPoint("BOTTOMLEFT", self, "BOTTOMRIGHT", 10,-2)
			if ( SHOW_NEWBIE_TIPS == "1" ) then
				if ( self.tooltipText ) then
					GameTooltip:SetText(self.tooltipText, 1.0, 1.0, 1.0);
					GameTooltip:AddLine(self.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
				else
					GameTooltip:SetText(self.tooltipText, 1.0, 1.0, 1.0, 1, true);
				end
				GameTooltip:Show();
			else
				if ( not noNormalText ) then
					GameTooltip:SetText(self.tooltipText, 1.0, 1.0, 1.0);
				end
			end
			if ( not self:IsEnabled() ) then
				if ( self.factionGroup == "Neutral" ) then
					GameTooltip:AddLine(FEATURE_NOT_AVAILBLE_PANDAREN, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
					GameTooltip:Show();
				elseif ( self.minLevel ) then
					GameTooltip:AddLine(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, self.minLevel), RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
					GameTooltip:Show();
				elseif ( self.disabledTooltip ) then
					GameTooltip:AddLine(self.disabledTooltip, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
					GameTooltip:Show();
				end
			end
		end
	end

	local function MicroMenuButton_Update(self)
		local playerLevel = UnitLevel("player");
		local factionGroup = UnitFactionGroup("player");

		if ( factionGroup == "Neutral" ) then
			self[6].factionGroup = factionGroup
			self[7].factionGroup = factionGroup
		else
			self[6].factionGroup = nil
			self[7].factionGroup = nil
		end

		if ( IsTrialAccount() or (IsVeteranTrialAccount() and not IsInGuild()) or factionGroup == "Neutral" or IsKioskModeEnabled() ) then
			self[6]:Disable()
		else
			if ( IsInGuild() ) then
				self[6].tooltipText = GUILD
				self[6].newbieText = NEWBIE_TOOLTIP_GUILDTAB
			else
				self[6].tooltipText = LOOKINGFORGUILD;
				self[6].newbieText = NEWBIE_TOOLTIP_LOOKINGFORGUILDTAB;
			end
		end

		if ( playerLevel < self[7].minLevel or factionGroup == "Neutral" ) then
			--self[7]:Disable();
		else
			--self[7]:Enable();
			self[7]:SetButtonState("NORMAL");
		end
	end

	local Button = {}
	for i = 1,#MICROMENU_BUTTONS do
		Button[i] = CreateFrame("Button", nil, MenuContainer, "SecureActionButtonTemplate")
		Button[i]: SetSize(32,20)
		Button[i]: SetBackdrop(MicroMenuBackdrop)
		Button[i]: SetBackdropColor(F.Color(C.Color.W2, 0.8))
		Button[i]: RegisterForClicks("LeftButtonUp","RightButtonUp")
		Button[i]: SetID(i)

		local Icon = Button[i]:CreateTexture(nil, "OVERLAY")
		Icon: SetTexture(F.Path("Icons\\"..MICROMENU_BUTTONS[i][4]))
		Icon: SetVertexColor(F.Color(C.Color.Main1))
		Icon: SetSize(20,20)
		Icon: SetPoint("CENTER", Button[i], "CENTER", 0,0)

		local Border = Button[i]:CreateTexture(nil, "OVERLAY")
		Border: SetTexture(F.Path("InfoBar\\MB_Normal"))
		Border: SetVertexColor(F.Color(C.Color.Main1))
		Border: SetSize(32,20)
		Border: SetTexCoord(16/64,48/64, 6/32,26/32)
		Border: SetPoint("CENTER", Button[i], "CENTER", 0,0)

		local HighLight = Button[i]:CreateTexture(nil, "BORDER")
		HighLight: SetTexture(F.Path("InfoBar\\MB_Highlight2"))
		HighLight: SetVertexColor(F.Color(C.Color.Main1))
		HighLight: SetAlpha(0.3)
		HighLight: SetSize(32,20)
		HighLight: SetTexCoord(16/64,48/64, 6/32,26/32)
		HighLight: SetPoint("CENTER", Button[i], "CENTER", 0,0)
		HighLight: Hide()
		
		if i == 1 then
			Button[i]: SetPoint("TOP", MenuContainer, "TOP", 0,-6)
			Button[i]: SetAttribute("type", "macro")
			Button[i]: SetAttribute("macrotext", "/run ToggleCharacter('PaperDollFrame')")
		elseif i == 6 then
			Button[i]: SetPoint("TOP", Button[i-1], "BOTTOM", 0,-2)
			Button[i]: SetAttribute("*type1", "click")
			Button[i]: SetAttribute("clickbutton", _G[MICROMENU_BUTTONS[i][1]])
			Button[i]: SetAttribute("*type2", "macro")
			Button[i]: SetAttribute("macrotext", "/guildroster") --/run GuildFrame_Toggle()
		elseif i == 11 then
			Button[i]: SetPoint("TOP", Button[i-1], "BOTTOM", 0,-2)
			Button[i]: SetScript("OnClick", function(self, button)
				if ( not GameMenuFrame:IsShown() ) then
					if ( VideoOptionsFrame:IsShown() ) then
						VideoOptionsFrameCancel:Click();
					elseif ( AudioOptionsFrame:IsShown() ) then
						AudioOptionsFrameCancel:Click();
					elseif ( InterfaceOptionsFrame:IsShown() ) then
						InterfaceOptionsFrameCancel:Click();
					end
					CloseMenus();
					CloseAllWindows()
					PlaySound(SOUNDKIT.IG_MAINMENU_OPEN);
					ShowUIPanel(GameMenuFrame);
				else
					PlaySound(SOUNDKIT.IG_MAINMENU_QUIT);
					HideUIPanel(GameMenuFrame);
					MainMenuMicroButton_SetNormal();
				end
			end)
		else
			Button[i]: SetPoint("TOP", Button[i-1], "BOTTOM", 0,-2)
			Button[i]: SetAttribute("type", "click")
			Button[i]: SetAttribute("clickbutton", _G[MICROMENU_BUTTONS[i][1]])
		end

		Button[i]: SetScript("OnEnter", function(self)
			MicroMenuButton_OnEnter(self)
			HighLight: Show()
		end)
		Button[i]: SetScript("OnLeave", function(self)
			GameTooltip:Hide()
			HighLight: Hide()
		end)

		--Button[i]: RegisterEvent("UPDATE_BINDINGS")
		Button[i].tooltipText = MICROMENU_BUTTONS[i][2]
		Button[i].newbieText = MICROMENU_BUTTONS[i][3]
	end
	--> CharacterMicroButton
	--Button[1].tooltipText = MicroButtonTooltipText(CHARACTER_BUTTON, "TOGGLECHARACTER0")
	--> SpellbookMicroButton
	--Button[2].tooltipText = MicroButtonTooltipText(SPELLBOOK_ABILITIES_BUTTON, "TOGGLESPELLBOOK")
	--> TalentMicroButton
	--Button[3].tooltipText = MicroButtonTooltipText(TALENTS_BUTTON, "TOGGLETALENTS")
	--> AchievementMicroButton
	--Button[4].tooltipText = MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "TOGGLEACHIEVEMENT")
	--> QuestLogMicroButton
	--Button[5].tooltipText = MicroButtonTooltipText(QUESTLOG_BUTTON, "TOGGLEQUESTLOG")
	--> GuildMicroButton
	--Button[6].tooltipText = MicroButtonTooltipText(LOOKINGFORGUILD, "TOGGLEGUILDTAB")
	--> LFDMicroButton
	--Button[7].tooltipText = MicroButtonTooltipText(DUNGEONS_BUTTON, "TOGGLEGROUPFINDER")
	Button[7].minLevel = math.min(SHOW_LFD_LEVEL, SHOW_PVP_LEVEL)
	--> EJMicroButton
	--Button[8].tooltipText = MicroButtonTooltipText(ENCOUNTER_JOURNAL, "TOGGLEENCOUNTERJOURNAL")
	--> CollectionsMicroButton
	--Button[9].tooltipText = MicroButtonTooltipText(COLLECTIONS, "TOGGLECOLLECTIONS")

	MenuContainer: RegisterEvent("PLAYER_ENTERING_WORLD")
	MenuContainer: RegisterEvent("PLAYER_GUILD_UPDATE")
	if not F.IsClassic then
		MenuContainer: RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
	end
	MenuContainer: SetScript("OnEvent", function(self, event, ...)
		MicroMenuButton_Update(Button)
	end)

	MicroMenu: SetFrameRef("Menu", MenuContainer)
	MicroMenu: SetAttribute("_onenter", [[
		local Menu = self:GetFrameRef("Menu")
		Menu:Show()
		Menu:RegisterAutoHide(1)
		Menu:AddToAutoHide(self)
	]])

	MenuContainer: SetAttribute("_onenter", [[
		self:RegisterAutoHide(1)
		self:AddToAutoHide(self)
	]])
	MenuContainer: SetAttribute("_onattributechanged", [[
		if name == "statehidden" and value then
			self:Show()
		end
	]])

	f.MicroMenu = MicroMenu
end

--- ------------------------------------------------------------
--> Time
--- ------------------------------------------------------------

local function Time_Update(f)
	f.Time: SetText(GameTime_GetTime(false))
	C_Timer.After(0.5, function(self) Time_Update(f) end)
end

local function Hook_TimeManagerFrame()
	TimeManagerFrame: SetClampedToScreen(true)
	TimeManagerFrame: ClearAllPoints()
	TimeManagerFrame: SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 20, 40)
	TimeManagerFrame: EnableMouse(true)
	TimeManagerFrame: SetMovable(true)
	TimeManagerFrame: SetUserPlaced(true)
	TimeManagerFrame: RegisterForDrag("LeftButton","RightButton")
	TimeManagerFrame: SetScript("OnDragStart", function(self) self:StartMoving() end)
	TimeManagerFrame: SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
end

local function Time_Frame(f)
	f.TimeFrame = CreateFrame("Button", nil, f)
	f.TimeFrame: SetSize(48,26)
	f.TimeFrame: SetPoint("BOTTOMLEFT", f.MicroMenu, "BOTTOMRIGHT", 0,0)
	--f.TimeFrame: SetAlpha(0.8)
	f.TimeFrame: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	f.TimeFrame: SetBackdrop(backdrop)
	f.TimeFrame: SetBackdropColor(F.Color(C.Color.Main0, 0.6))
	
	f.TimeFrame.Time = F.create_Font(f.TimeFrame, C.Font.NumSmall, 12, nil, 0, "CENTER", "CENTER")
	f.TimeFrame.Time: SetTextColor(F.Color(C.Color.Main1))
	f.TimeFrame.Time: SetAlpha(0.8)
	f.TimeFrame.Time: SetPoint("CENTER", f.TimeFrame, "CENTER", 1,0)
	
	f.TimeFrame: RegisterEvent("PLAYER_LOGIN")
	f.TimeFrame: SetScript("OnEvent", function(self)
		Time_Update(f.TimeFrame)
		Hook_TimeManagerFrame()
	end)
	
	f.TimeFrame: SetScript("OnClick", function(self, button)
		if F.IsClassic then
			TimeManagerClockButton_OnClick(TimeManagerClockButton)
		else
			if button == "LeftButton" then
				ToggleCalendar()
			elseif button == "RightButton" then
				TimeManagerClockButton_OnClick(TimeManagerClockButton)
				--TimeManager_Toggle()
			end
		end
		GameTooltip: Hide()
	end)
	
	f.TimeFrame: SetScript("OnEnter", function(self)
		-- weekday, month, day, year = CalendarGetDate()
		local date, weekday, month, day
		date = C_DateAndTime.GetTodaysDate()
		day = date.day
		weekday = date.weekDay
		month = date.month

		GameTooltip_InitPos(self)
		GameTooltip: SetText(format("%s %s%s", L['MOUTH_LIST'][month],day,L['DAY']))
		GameTooltip: AddLine(L['WEEKDAY_LIST'][weekday], 1,1,1)
		GameTooltip: Show()
		MBCC_Hide()
	end)
	f.TimeFrame: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
end

--- ------------------------------------------------------------
--> Network
--- ------------------------------------------------------------

local function Network_Update(f)
	local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
	local framerate = GetFramerate();
	local latency = latencyHome > latencyWorld and latencyHome or latencyWorld;
	if (latency > 400) then
		f.Icon: SetTexture(F.Path("Icons\\Network16_1"))
	elseif (latency > 200) then
		f.Icon: SetTexture(F.Path("Icons\\Network16_2"))
	else
		f.Icon: SetTexture(F.Path("Icons\\Network16_3"))
	end
end

local function Network_OnUpdate(f)
	f: SetScript("OnUpdate", function(self, elapsed)
		if F.Last1 == 0 then
			Network_Update(f)
		end
	end)
end

local function Network_OnEnter(self)
	local tooltiptext = ""
	GameTooltip_InitPos(self)
	GameTooltip:SetText("信息")

	-- latency
	local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
	tooltiptext = format(MAINMENUBAR_LATENCY_LABEL, latencyHome, latencyWorld);
	GameTooltip:AddLine(" ");
	GameTooltip:AddLine(tooltiptext, 1.0, 1.0, 1.0);
	if ( SHOW_NEWBIE_TIPS == "1" ) then
		GameTooltip:AddLine(NEWBIE_TOOLTIP_LATENCY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
	end
	
	-- framerate
	tooltiptext = format(MAINMENUBAR_FPS_LABEL, GetFramerate());
	GameTooltip:AddLine(" ");
	GameTooltip:AddLine(tooltiptext, 1.0, 1.0, 1.0);
	if ( SHOW_NEWBIE_TIPS == "1" ) then
		GameTooltip:AddLine(NEWBIE_TOOLTIP_FRAMERATE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true);
	end
	
	GameTooltip:Show();
end

local function Network_Frame(f)
	local network = CreateFrame("Button", nil, f)
	network: SetSize(32,26)
	network: SetPoint("BOTTOMLEFT", f.TimeFrame, "BOTTOMRIGHT", 0,0)
	--network: SetAlpha(0.8)
	network: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	network: SetBackdrop(backdrop)
	network: SetBackdropColor(F.Color(C.Color.Main0, 0.6))
	f.Network = network

	f.Network.Icon = F.create_Texture(f.Network, "ARTWORK", "Icons\\Network16_3", C.Color.Main1, 1)
	f.Network.Icon: SetSize(16,16)
	f.Network.Icon: SetAlpha(0.8)
	f.Network.Icon: SetPoint("CENTER", f.Network, "CENTER", 0,0)

	f.Network.IconBg = F.create_Texture(f.Network, "BORDER", "Icons\\Network16_0", C.Color.W2, 0.8)
	f.Network.IconBg: SetSize(16,16)
	f.Network.IconBg: SetAlpha(0.8)
	f.Network.IconBg: SetPoint("CENTER", f.Network, "CENTER", 0,0)

	Network_OnUpdate(f.Network)

	f.Network: SetScript("OnClick", function(self, button)
		
	end)

	f.Network: SetScript("OnEnter", function(self)
		Network_OnEnter(self)
		MBCC_Hide()
	end)
	f.Network: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
end

--- ------------------------------------------------------------
--> Minimap Button Collector
--- ------------------------------------------------------------

local Minimap_Filter = {
	"MiniMapTracking", "MiniMapTrackingButton", "MiniMapTrackingDropDownButton",
	"MiniMapVoiceChatFrame", "MiniMapVoiceChatDropDownButton",
	"MiniMapWorldMapButton",
	"QueueStatusMinimapButton", "QueueStatusMinimapButtonDropDownButton",
	"MinimapZoomIn", "MinimapZoomOut",
	"MiniMapMailFrame",
	"MiniMapBattlefieldFrame",
	"GameTimeFrame",
	"FeedbackUIButton",
	
	"MinimapBackdrop",	
	"TimeManagerClockButton",
	"GarrisonLandingPageMinimapButton"
}

local IgnoreButtonList = {
	"BagSync_MinimapButton",
	"LSItemTrackerMinimapButton",
}
local PreButtonList, ButtonList = {}, {}

local function MBC_HasChildButton(parent)
	for _, child in pairs({parent:GetChildren()}) do
		local name = child:GetName()
		local type = child:GetObjectType()
		
		if name and type and child:HasScript("OnClick") then
			parent.childButton = child
			return child
		end
	end
end

local function isMinimapButton(frame)
	local name = frame:GetName()
	local type = frame:GetObjectType()
	if name and (type == "Button") and frame:HasScript("OnClick") and frame:GetNumRegions() >= 3 then
	--if frame and frame:GetObjectType() == "Button" and frame:GetNumRegions() >= 3 then
		return true
	end
end

local function addButton(f, button)
	if button:GetParent() ~= f then
		button:SetParent(f)
	end
end

local function MBC_AddButton(button)
	if not tContains(ButtonList, button) then
		insert(ButtonList, button)
	end
end

function findButtons(f, frame)
	if frame then
		for i, child in ipairs({frame:GetChildren()}) do
			local name = child:GetName()
			local parent = child:GetParent()
			local parentname = parent:GetName()
			local filter = nil
			for j = 1, #Minimap_Filter do
				if (name == Minimap_Filter[j]) or (parentname == Minimap_Filter[j]) then
					filter = true
				end
			end
			if isMinimapButton(child) and parentname == "Minimap" and (not filter) then
				addButton(f, child)
			else
				findButtons(f, child)
			end	
		end
	end
end

local function CollectButtons(f)
	findButtons(f, Minimap)
end

local function MBC_SkinButton(button)
	do
		button: SetToplevel(false)
		button: ClearAllPoints()
		button: SetScale(1)
		button: SetSize(20,20)
		button: SetHitRectInsets(0,0,0,0)
		button: RegisterForDrag()
		if button: IsMovable() then
			button: SetMovable(false)
		end
		
		if button.dataObject then
			button: SetScript("OnEnter",function(self)
				local obj = self.dataObject
				if obj.OnTooltipShow then
					GameTooltip: SetOwner(self, "ANCHOR_NONE")
					GameTooltip: SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 0,0)
					obj.OnTooltipShow(GameTooltip)
					GameTooltip: Show()
				elseif obj.OnEnter then
					obj.OnEnter(self)
				end
			end)
			button: SetScript("OnLeave", function(self)
				local obj = self.dataObject
				GameTooltip:Hide()
				if obj.OnLeave then obj.OnLeave(self) end
			end)
		else
			button: HookScript("OnEnter",function(self)
				GameTooltip: ClearAllPoints()
				GameTooltip: SetAnchorType("ANCHOR_NONE")
				GameTooltip: SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 0,0)
			end)
		end
	end
	for _, region in pairs({button:GetRegions()}) do
		if region: GetObjectType() == "Texture" then
			region: Hide()
			--local file = tostring(region:GetTexture())
			--if file and ( file:find("Border") or file:find("Background") or file:find("AlphaMask") or file:find(136430) or file:find(136467) ) then
			--	region:SetTexture("")
			--end
		end
	end
	do
		local icon = button.icon or button.Icon or button.texture or _G[button:GetName().."Icon"] or _G[button:GetName().."_Icon"] or button:GetNormalTexture()
		if icon then
			icon: Show()
			icon: ClearAllPoints()
			icon: SetPoint("CENTER")
			icon: SetSize(20,20)
			icon.ClearAllPoints = function() end
			icon.SetPoint = function() end
		end
		local highlight = button: GetHighlightTexture()
		if highlight then
			highlight: ClearAllPoints()
			highlight: SetSize(20,20)
			highlight: SetPoint("CENTER")
			highlight: SetColorTexture(1,1,1,0.5)
		end
	end
end

local function MBC_SkinSpecButton(button)
	local name = button: GetName()
	if find(name, "DBM") then
		if button.icon then
			button.icon: SetTexture(F.Path("Icons\\MBC_DBM"))
		end
	end
	if find(name, "ExorsusRaidTools") then
		if button.icon then
			button.icon: SetTexture(F.Path("Icons\\MBC_ExRT"))
		end
	end
end

local function pos_Collect(f)
	local num = #{f: GetChildren()}
	local x,y
	local Index = 0
	for i, child in ipairs({f: GetChildren()}) do
		MBC_SkinButton(child)
		MBC_SkinSpecButton(child)
		if child:IsShown() then
			Index = Index + 1
		end
		--child: ClearAllPoints()
		y = ceil(Index/4) - 1
		x = Index - y*4 - 1
		child: SetPoint("CENTER", f, "BOTTOMLEFT", 2+14+x*28, 2+14+y*28)
	end
	f: SetSize(4+28*4,4+28*ceil(Index/4))
end

local function MBC_Frame(f)
	local MBCC_TimeToHide = 0
	--local MBCFrame = CreateFrame("Button", nil, f, "SecureHandlerEnterLeaveTemplate")
	local MBCFrame = CreateFrame("Button", nil, f)
	MBCFrame: SetSize(32,26)
	MBCFrame: SetPoint("BOTTOMLEFT", f.Network, "BOTTOMRIGHT", 0,0)
	--MBCFrame: SetAlpha(0.8)
	MBCFrame: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	MBCFrame: SetAttribute("motionScriptsWhileDisabled", true)
	MBCFrame: SetBackdrop(backdrop)
	MBCFrame: SetBackdropColor(F.Color(C.Color.Main0, 0.6))
	
	local Icon = MBCFrame:CreateTexture(nil, "ARTWORK")
	Icon: SetTexture(F.Path("Icons\\Box16"))
	Icon: SetVertexColor(F.Color(C.Color.Main1))
	Icon: SetAlpha(0.8)
	Icon: SetSize(16,16)
	Icon: SetPoint("CENTER", MBCFrame, "CENTER", 0,0)
	
	--local MBContainer = CreateFrame("Frame", "Quafe_InfoBar.MBCC", MBCFrame, "SecureHandlerEnterLeaveTemplate")
	local MBContainer = CreateFrame("Frame", "Quafe_InfoBar.MBCC", MBCFrame)
	MBContainer: SetFrameStrata("HIGH")
	MBContainer: SetPoint("BOTTOMLEFT", MBCFrame, "TOPLEFT", 0,4)
	MBContainer: SetBackdrop(backdrop)
	MBContainer: SetBackdropColor(F.Color(C.Color.Main0, 0.8))
	MBContainer: Hide()

	MBContainer: SetScript("OnUpdate", function(self, elapsed)
		local isOver = self:IsMouseOver()
		if isOver then
			MBCC_TimeToHide = 1
		else
			MBCC_TimeToHide = MBCC_TimeToHide - elapsed
		end
		if MBCC_TimeToHide <= 0 then
			MBCFrame:SetScript("OnUpdate", nil)
			self:Hide()
		end
	end)
	
	MBCFrame: SetScript("OnEnter", function(self)
		if not MBContainer:IsShown() then
			MBContainer:Show()
		end
		MBCC_TimeToHide = 1
		MBCFrame:SetScript("OnUpdate", function(self, elapsed)
			local isOver = self:IsMouseOver()
			if isOver then
				MBCC_TimeToHide = 1
			end
		end)
	end)

	local function MBC_Refresh()
		CollectButtons(MBContainer)
		pos_Collect(MBContainer)
	end
	
	MBCFrame: RegisterEvent("PLAYER_ENTERING_WORLD")
	MBCFrame: SetScript("OnEvent", function(self)
		if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].MBC then
			MBC_Refresh()
		end
	end)
	
	MBCFrame: SetScript("OnClick", function(self, button)
		--if button == "LeftButton" then
		--	if MBContainer:IsShown() then
		--		MBContainer:Hide()
		--	else
		--		MBContainer:Show()
		--	end
		--elseif button == "RightButton" then
		if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].MBC then
			MBC_Refresh()
		end
		--end
		GameTooltip: Hide()
	end)
	
	--f.MBCFrame: SetScript("OnEnter", function(self)
	--	if not self.Hold:IsShown() then
	--		GameTooltip_InitPos(self)
	--		GameTooltip: SetText(L['MBC'])
	--		GameTooltip: Show()
	--	end
	--end)
	--f.MBCFrame: SetScript("OnLeave", function(self)
	--	GameTooltip: Hide()
	--end)

	

	f.MBCFrame = MBCFrame
	f.MBCFrame.Refresh = MBC_Refresh
end

--- ------------------------------------------------------------
--> Friends
--- ------------------------------------------------------------
-- GameTooltip:AddLine("|T"..itemTexture..":0|t ")
-- /run for i,v in pairs(_G) do if type(i)=="string" and i:match("BNET_CLIENT_") then print(i,"=",v) end end
--[[
local ClientIcon = {
	--["BSAp"] = {"Battle.Net", "Interface\\CHATFRAME\\UI-ChatIcon-ArmoryChat"},
	["BSAp"] = {"Battle.Net", "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet"},
	[BNET_CLIENT_APP] = {"Battle.Net", "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet"},
	[BNET_CLIENT_CLNT] = {"CLNT", "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet"},
	[BNET_CLIENT_D3] = {"Diablo 3", "Interface\\CHATFRAME\\UI-ChatIcon-D3"},
	[BNET_CLIENT_HEROES] = {"Heroes of the Storm", "Interface\\CHATFRAME\\UI-ChatIcon-HotS"},
	[BNET_CLIENT_SC] = {"Starcarft", "Interface\\CHATFRAME\\UI-ChatIcon-SC"},
	[BNET_CLIENT_SC2] = {"Starcarft 2", "Interface\\CHATFRAME\\UI-ChatIcon-SC2"},
	[BNET_CLIENT_WOW] = {"World of Warcraft", "Interface\\CHATFRAME\\UI-ChatIcon-WoW"},
	[BNET_CLIENT_WTCG] = {"Hearthstone", "Interface\\CHATFRAME\\UI-ChatIcon-WTCG"},
	[BNET_CLIENT_OVERWATCH] = {"Overwatch", "Interface\\CHATFRAME\\UI-ChatIcon-Overwatch"},
	[BNET_CLIENT_DESTINY2] = {"Destiny 2", "Interface\\CHATFRAME\\UI-ChatIcon-Destiny2"},
}
]]--
local ClientIcon = {
	--[[
	["BSAp"] = {"Battle.Net", "Interface\\FriendsFrame\\Battlenet-Battleneticon"},
	[BNET_CLIENT_APP] = {"Battle.Net", "Interface\\FriendsFrame\\Battlenet-Battleneticon"},
	[BNET_CLIENT_CLNT] = {"CLNT", "Interface\\FriendsFrame\\Battlenet-Battleneticon"},
	[BNET_CLIENT_D3] = {"Diablo 3", "Interface\\FriendsFrame\\Battlenet-D3icon"},
	[BNET_CLIENT_HEROES] = {"Heroes of the Storm", "Interface\\FriendsFrame\\Battlenet-HotSicon"},
	[BNET_CLIENT_SC] = {"Starcarft", "Interface\\FriendsFrame\\Battlenet-SCicon"},
	[BNET_CLIENT_SC2] = {"Starcarft 2", "Interface\\FriendsFrame\\Battlenet-Sc2icon"},
	[BNET_CLIENT_WOW] = {"World of Warcraft", "Interface\\FriendsFrame\\Battlenet-WoWicon"},
	[BNET_CLIENT_WTCG] = {"Hearthstone", "Interface\\FriendsFrame\\Battlenet-WTCGicon"},
	[BNET_CLIENT_OVERWATCH] = {"Overwatch", "Interface\\FriendsFrame\\Battlenet-Overwatchicon"},
	[BNET_CLIENT_DESTINY2] = {"Destiny 2", "Interface\\FriendsFrame\\Battlenet-Destiny2icon"},
	--]]
	["BSAp"] = {"Battle.Net", "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet"}, --Battle.Net Mobile App
	[BNET_CLIENT_APP] = {"Battle.Net", "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet"}, --Battle.Net-Client (App)
	[BNET_CLIENT_CLNT] = {"CLNT", "Interface\\CHATFRAME\\UI-ChatIcon-Battlenet"}, --(CLNT)
	[BNET_CLIENT_D3] = {"Diablo 3", "Interface\\CHATFRAME\\UI-ChatIcon-D3"}, --(D3)
	[BNET_CLIENT_HEROES] = {"Heroes of the Storm", "Interface\\CHATFRAME\\UI-ChatIcon-HotS"}, --(Hero)
	[BNET_CLIENT_SC] = {"Starcarft", "Interface\\CHATFRAME\\UI-ChatIcon-SC"}, --(S1)
	[BNET_CLIENT_SC2] = {"Starcarft 2", "Interface\\CHATFRAME\\UI-ChatIcon-SC2"}, --(S2)
	[BNET_CLIENT_WOW] = {"World of Warcraft", "Interface\\CHATFRAME\\UI-ChatIcon-WoW"}, --(WoW)
	[BNET_CLIENT_WTCG] = {"Hearthstone", "Interface\\CHATFRAME\\UI-ChatIcon-WTCG"}, --(WTCG)
	[BNET_CLIENT_OVERWATCH] = {"Overwatch", "Interface\\CHATFRAME\\UI-ChatIcon-Overwatch"}, --(Pro)
	[BNET_CLIENT_DESTINY2] = {"Destiny 2", "Interface\\CHATFRAME\\UI-ChatIcon-Destiny2"}, --(DST2)
	[BNET_CLIENT_COD] = {"Call of Duty: Black Ops 4", "Interface\\CHATFRAME\\UI-ChatIcon-CallOfDutyBlackOps4"}, --VIPR
}

local function Friend_ListTemplate(f)
	f: SetSize(240,22)

	local Bg = f:CreateTexture(nil, "BORDER")
	Bg: SetTexture(F.Path("StatusBar\\Flat"))
	Bg: SetVertexColor(F.Color(C.Color.W2))
	Bg: SetAllPoints(f)
	Bg: SetBlendMode("BLEND")
	Bg: SetAlpha(0.1)

	local Status = f:CreateTexture(nil, "ARTWORK")
	Status: SetTexture(F.Path("StatusBar\\Raid"))
	Status: SetSize(8,18)
	Status: SetPoint("LEFT", f, "LEFT", 2,0)

	local Icon = f:CreateTexture(nil, "ARTWORK")
	Icon: SetTexture("Interface\\FriendsFrame\\UI-ChatIcon-Battlenet")
	Icon: SetSize(22,22)
	Icon: SetPoint("RIGHT", f, "RIGHT", 0,0)

	local Name = F.create_Font(f, C.Font.Txt, 12, nil, 1, "LEFT", "CENTER")
	Name: SetHeight(1)
	Name: SetPoint("LEFT", Status, "RIGHT", 4,0)
	Name: SetPoint("RIGHT", Icon, "LEFT", -4,0)
	
	f.Bg = Bg
	f.Status = Status
	f.Name = Name
	f.Icon = Icon
end

local function Friend_ListRefresh(f)
	for i = 1, #f.List do
		f.List[i]:Hide()
	end
end

local function Friend_ListUpdate(f)
	Friend_ListRefresh(f)
	local MAX_LINES = 30
	local nameText, nameColor
	local i,j = 1,1
	local BN,WF = 1,1 
	
	local numBNetTotal, numBNetOnline = BNGetNumFriends()
	if numBNetTotal and numBNetTotal >= 1 then
		while (BN <= numBNetTotal) and (i <= numBNetOnline) and (i <= MAX_LINES) do
			local bnetIDAccount, accountName, battleTag, isBattleTagPresence, characterName, bnetIDGameAccount, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR, isReferAFriend, canSummonFriend = BNGetFriendInfo(BN)
			if isOnline then
				local _, _, _, realmName, realmID, faction, _, _, _, zoneName, _, gameText, _, _, _, _, _, isGameAFK, isGameBusy, guid = BNGetGameAccountInfo(bnetIDGameAccount)
				if ( accountName ) then
					nameText = accountName
				else
					nameText = UNKNOWN
				end
				characterName = BNet_GetValidatedCharacterName(characterName, battleTag, client)
				if characterName then
					if (client == BNET_CLIENT_WOW) and bnetIDGameAccount then
						local _, _, _, realmName, realmID, faction, race, class, _, zoneName, level, gameText = BNGetGameAccountInfo(bnetIDGameAccount)
						nameText = format("%s %s(%s-%s)%s", nameText,FRIENDS_WOW_NAME_COLOR_CODE,characterName,class,FONT_COLOR_CODE_CLOSE)
					else
						if ( ENABLE_COLORBLIND_MODE == "1" ) then
							characterName = characterName..CANNOT_COOPERATE_LABEL;
						end
						nameText = format("%s %s(%s)%s", nameText,FRIENDS_OTHER_NAME_COLOR_CODE,characterName,FONT_COLOR_CODE_CLOSE)
					end
				end
				if not f.List[i] then
					f.List[i] = CreateFrame("Button", nil, f)
					Friend_ListTemplate(f.List[i])
					if i == 1 then
						f.List[i]: SetPoint("TOP", f, "TOP", 0,-2)
					else
						f.List[i]: SetPoint("TOP", f.List[i-1], "BOTTOM", 0,-2)
					end
				end
				f.List[i].Bg: SetVertexColor(FRIENDS_BNET_BACKGROUND_COLOR.r, FRIENDS_BNET_BACKGROUND_COLOR.g, FRIENDS_BNET_BACKGROUND_COLOR.b)
				if ( isBnetAFK or isGameAFK ) then
					f.List[i].Status: SetVertexColor(1,1,0)
				elseif ( isBnetDND or isGameBusy ) then
					f.List[i].Status: SetVertexColor(1,0,0)
				else
					f.List[i].Status: SetVertexColor(0,1,0)
				end
				f.List[i].Name: SetText(nameText)
				f.List[i].Name: SetTextColor(FRIENDS_BNET_NAME_COLOR.r,FRIENDS_BNET_NAME_COLOR.g,FRIENDS_BNET_NAME_COLOR.b)
				f.List[i].Icon: SetTexture(ClientIcon[client][2])
				f.List[i]: Show()

				i = i + 1
			end
			BN = BN + 1
		end
	end
	
	local numberOfFriends = C_FriendList.GetNumFriends() or 0
	local onlineFriends = C_FriendList.GetNumOnlineFriends() or 0
	if numberOfFriends and numberOfFriends >= 1 then
		while (WF <= numberOfFriends) and (j <= onlineFriends) and (i <= MAX_LINES) do
			local name, level, class, area, connected, status, note, isRaF, guid = GetFriendInfo(j);
			if connected then
				if not f.List[i] then
					f.List[i] = CreateFrame("Button", nil, f)
					Friend_ListTemplate(f.List[i])
					if i == 1 then
						f.List[i]: SetPoint("TOP", f, "TOP", 0,-2)
					else
						f.List[i]: SetPoint("TOP", f.List[i-1], "BOTTOM", 0,-2)
					end
				end
				f.List[i].Bg: SetVertexColor(FRIENDS_WOW_BACKGROUND_COLOR.r, FRIENDS_WOW_BACKGROUND_COLOR.g, FRIENDS_WOW_BACKGROUND_COLOR.b)
				if ( status == "" ) then
					f.List[i].Status: SetVertexColor(0,1,0)
				elseif ( status == CHAT_FLAG_AFK ) then
					f.List[i].Status: SetVertexColor(1,1,0)
				elseif ( status == CHAT_FLAG_DND ) then
					f.List[i].Status: SetVertexColor(1,0,0)
				end
				nameText = name..", "..format(FRIENDS_LEVEL_TEMPLATE, level, class)
				f.List[i].Name: SetText(nameText)
				f.List[i].Name: SetTextColor(FRIENDS_WOW_NAME_COLOR.r,FRIENDS_WOW_NAME_COLOR.g,FRIENDS_WOW_NAME_COLOR.b)
				f.List[i].Icon: SetTexture(ClientIcon[BNET_CLIENT_WOW][2])
				f.List[i]: Show()

				j = j + 1
				i = i + 1
			end
			WF = WF + 1
		end
	end
	f: SetHeight((i-1)*24+2)
end

local function Friend_List(f)
	
end

local function Friend_Frame(f)
	local Friend = CreateFrame("Button", nil, f)
	Friend: SetSize(48,26)
	Friend: SetPoint("BOTTOMLEFT", f.MBCFrame, "BOTTOMRIGHT", 0,0)
	--Friend: SetAlpha(0.8)
	Friend: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	Friend: SetBackdrop(backdrop)
	Friend: SetBackdropColor(F.Color(C.Color.Main0, 0.6))
	
	local Icon = Friend:CreateTexture(nil, "ARTWORK")
	Icon: SetTexture(F.Path("Icons\\Friend16"))
	Icon: SetVertexColor(F.Color(C.Color.Main1))
	Icon: SetAlpha(0.8)
	Icon: SetSize(16,16)
	Icon: SetPoint("CENTER", Friend, "LEFT", 16,0)
	
	local Num = F.create_Font(Friend, C.Font.NumSmall, 12, nil, 0, "CENTER", "CENTER")
	Num: SetTextColor(F.Color(C.Color.Main1))
	Num: SetAlpha(0.8)
	Num: SetPoint("CENTER", Friend, "RIGHT", -14,0)
	Num: SetText("00")

	local ListHold = CreateFrame("Frame", nil, Friend)
	ListHold: SetFrameStrata("TOOLTIP")
	ListHold: SetWidth(244)
	ListHold: SetPoint("BOTTOMLEFT", Friend, "TOPLEFT", 0,4)
	ListHold: SetBackdrop(backdrop)
	ListHold: SetBackdropColor(F.Color(C.Color.Main0, 0.8))
	ListHold.List = {}
	ListHold: Hide()
	ListHold: SetScript("OnShow", function(self)
		Friend_ListUpdate(self)
	end)

	f.Friend = Friend
	
	f.Friend: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Friend: RegisterEvent("FRIENDLIST_UPDATE")
	f.Friend: RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED")
	f.Friend: RegisterEvent("BN_INFO_CHANGED")
	f.Friend: RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
	f.Friend: RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
	--f.Friend: RegisterEvent("BN_FRIEND_TOON_ONLINE")
	--f.Friend: RegisterEvent("BN_FRIEND_TOON_OFFLINE")
	f.Friend: RegisterEvent("BN_CONNECTED")
	f.Friend: RegisterEvent("BN_DISCONNECTED")
	f.Friend: SetScript("OnEvent", function(self, event, ...)
		local numBNetOnline = select(2,BNGetNumFriends()) or 0
		local numWoWOnline = C_FriendList.GetNumOnlineFriends() or 0
		local num = min(numBNetOnline + numWoWOnline, 99)
		Num: SetText(format("%02d", num))
	end)
	
	f.Friend: SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			ToggleFriendsFrame(1)
		elseif button == "RightButton" then
			
		end
	end)
	
	f.Friend: SetScript("OnEnter", function(self)
		local numBNetOnline = select(2,BNGetNumFriends()) or 0
		local numWoWOnline = C_FriendList.GetNumOnlineFriends() or 0
		if ((numBNetOnline+numWoWOnline) >= 1) then
			ListHold: Show()
			MBCC_Hide()
		end
	end)

	f.Friend: SetScript("OnLeave", function(self)
		ListHold: Hide()
	end)
end

----------------------------------------------------------------
--> Guild
----------------------------------------------------------------

local function Guild_Artwork(frame)
	local Icon = frame:CreateTexture(nil, "ARTWORK")
	Icon: SetTexture(F.Path("Icons\\Guild16"))
	Icon: SetVertexColor(F.Color(C.Color.Main1))
	Icon: SetAlpha(0.8)
	Icon: SetSize(16,16)
	Icon: SetPoint("CENTER", frame, "LEFT", 16,0)
	
	local Num = F.create_Font(frame, C.Font.NumSmall, 12, nil, 0, "CENTER", "CENTER")
	Num: SetTextColor(F.Color(C.Color.Main1))
	Num: SetAlpha(0.8)
	Num: SetPoint("CENTER", frame, "RIGHT", -14,0)
	Num: SetText("00")

	local Flash = CreateFrame("Frame", nil, frame, "Quafe_GarrisonNotificationTemplate")
	Flash: SetFrameLevel(frame: GetFrameLevel())
	Flash: SetAllPoints(frame)
	Flash.Timing = false
	
	local FlashGlow = Flash: CreateTexture(nil, "BORDER")
	FlashGlow: SetTexture(F.Path("White"))
	FlashGlow: SetVertexColor(F.Color(C.Color.Y3))
	FlashGlow: SetAlpha(0.5)
	FlashGlow: SetAllPoints(frame)

	local ListHold = CreateFrame("Frame", nil, frame)
	ListHold: SetFrameStrata("TOOLTIP")
	ListHold: SetWidth(244)
	ListHold: SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0,4)
	ListHold: SetBackdrop(backdrop)
	ListHold: SetBackdropColor(F.Color(C.Color.Main0, 0.8))
	ListHold.List = {}
	ListHold: Hide()
	ListHold: SetScript("OnShow", function(self)
		
	end)

	frame.Icon = Icon
	frame.Num = Num
	frame.List = ListHold
	frame.Flash = Flash
end

--GuildRoster()
--numTotalGuildMembers, numOnlineGuildMembers, numOnlineAndMobileMembers = GetNumGuildMembers()
local function GuildMember_Update(self)
	local numTotalGuildMembers, numOnlineGuildMembers, numOnlineAndMobileMembers = GetNumGuildMembers()
	numOnlineGuildMembers = numOnlineGuildMembers or 0
	self.OnLine = numOnlineGuildMembers
	self.Total = numTotalGuildMembers
	numOnlineGuildMembers = min(numOnlineGuildMembers, 99)
	self.Num: SetText(format("%02d", numOnlineGuildMembers))
end

local function HasUnseenInvitations()
	local invitations = C_Club.GetInvitationsForSelf();
	for i, invitation in ipairs(invitations) do
		if not DISPLAYED_COMMUNITIES_INVITATIONS[invitation.club.clubId] then
			return true;
		end
	end
	
	return false;
end

local function GuildNotification_Update(self)
	self.Flash:SetShown(HasUnseenInvitations() or CommunitiesUtil.DoesAnyCommunityHaveUnreadMessages())
end

local function Guild_Event(self, event, ...)
	if event == "GUILD_ROSTER_UPDATE" then
		GuildMember_Update(self)
	elseif ( event == "INITIAL_CLUBS_LOADED" ) then
		GuildNotification_Update(self)
	elseif ( event == "STREAM_VIEW_MARKER_UPDATED" or event == "CLUB_INVITATION_ADDED_FOR_SELF" or event == "CLUB_INVITATION_REMOVED_FOR_SELF" ) then
		GuildNotification_Update(self)
	end
end

local function Guild_Frame(frame)
	local Guild = CreateFrame("Button", nil, frame)
	Guild: SetSize(48,26)
	Guild: SetPoint("BOTTOMLEFT", frame.Friend, "BOTTOMRIGHT", 0,0)
	Guild: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	Guild: SetBackdrop(backdrop)
	Guild: SetBackdropColor(F.Color(C.Color.Main0, 0.6))
	Guild.tooltipText = GUILD
	
	Guild_Artwork(Guild)

	local EVENT_LIST = {
		"PLAYER_GUILD_UPDATE",
		"BN_DISCONNECTED",
		"BN_CONNECTED",
		"INITIAL_CLUBS_LOADED",
		"STREAM_VIEW_MARKER_UPDATED",
		"CLUB_INVITATION_ADDED_FOR_SELF",
		"CLUB_INVITATION_REMOVED_FOR_SELF",
		"GUILD_ROSTER_UPDATE",
	}

	for k, event in ipairs(EVENT_LIST) do
		Guild: RegisterEvent(event)
	end
	if not F.IsClassic then
		Guild: RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
	end
	Guild: SetScript("OnEvent", Guild_Event)

	GuildRoster()
	GuildMember_Update(Guild)
	GuildNotification_Update(Guild)

	Guild: SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			ToggleGuildFrame()
		elseif button == "RightButton" then
			if IsInGuild() then
				GuildFrame_LoadUI()
				if GuildFrame_Toggle then
					GuildFrame_Toggle()
				end
			else
				ToggleGuildFinder()
			end
		end
	end)

	Guild: SetScript("OnEnter", function(self)
		GameTooltip_InitPos(self)
		GameTooltip:SetText(self.tooltipText)
		GameTooltip:Show()
		MBCC_Hide()
	end)
	Guild: SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	frame.Guild = Guild
end

--- ------------------------------------------------------------
--> MeetingStone (DataBroker.lua)
--- ------------------------------------------------------------

local function MeetingStone_Frame(f)
	f.MeetingStone = CreateFrame("Button", nil, f)
	f.MeetingStone: SetSize(48,26)
	f.MeetingStone: SetPoint("BOTTOMLEFT", f.Guild, "BOTTOMRIGHT", 0,0)
	--f.MeetingStone: SetAlpha(0.8)
	f.MeetingStone: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	f.MeetingStone: SetBackdrop(backdrop)
	f.MeetingStone: SetBackdropColor(F.Color(C.Color.Main0, 0.6))
	
	local Icon = F.create_Texture(f.MeetingStone, "ARTWORK", "Icons\\Meeting16", C.Color.Main1)
	Icon: SetSize(16,16)
	Icon: SetAlpha(0.8)
	Icon: SetPoint("CENTER", f.MeetingStone, "LEFT", 16,0)
	
	f.MeetingStone.Num = F.create_Font(f.MeetingStone, C.Font.NumSmall, 12, nil, 0, "CENTER", "CENTER")
	f.MeetingStone.Num: SetTextColor(F.Color(C.Color.Main1))
	f.MeetingStone.Num: SetAlpha(0.8)
	f.MeetingStone.Num: SetPoint("CENTER", f.MeetingStone, "RIGHT", -14,0)
	f.MeetingStone.Num: SetText("00")
	
	if IsAddOnLoaded("MeetingStone") then
		local MeetingStoneAddon = LibStub("AceAddon-3.0"):GetAddon("MeetingStone")
		local MeetingStoneApp = MeetingStoneAddon:GetModule("App")
		local MeetingStoneDataBroker = MeetingStoneAddon:GetModule("DataBroker")
		local MeetingStoneBrowsePanel = MeetingStoneAddon:GetModule("BrowsePanel")

		local ICON1 = [[|TInterface\AddOns\MeetingStone\Media\DataBroker:12:12:0:0:128:32:0:32:0:32|t]]
		local ICON2 = [[|TInterface\AddOns\MeetingStone\Media\DataBroker:12:12:0:0:128:32:32:65:0:32|t]]
		local ICON3 = [[|TInterface\AddOns\MeetingStone\Media\DataBroker:12:12:0:0:128:32:96:128:0:32|t]]
		
		f.MeetingStone: RegisterEvent("PLAYER_ENTERING_WORLD")
		f.MeetingStone: RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");
		f.MeetingStone: RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED");
		f.MeetingStone: RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED");
		f.MeetingStone: RegisterEvent("LFG_LIST_APPLICANT_UPDATED");
		f.MeetingStone: SetScript("OnEvent", function(self, event, ...)
			if C_LFGList.GetActiveEntryInfo() then
				f.MeetingStone.Num: SetText(format("%02d", C_LFGList.GetNumApplicants()))
			else
				f.MeetingStone.Num: SetText(format("%02d", C_LFGList.GetNumApplications()))
			end
		end)
		
		f.MeetingStone: SetScript("OnClick", function(self, button)
			if button == "LeftButton" then
				MeetingStoneAddon:Toggle()
			else
				
			end
		end)
		f.MeetingStone: SetScript("OnEnter", function(self)
			GameTooltip_InitPos(self)
			GameTooltip:SetText(L['MEETINGSTONE'])
			if C_LFGList.GetActiveEntryInfo() then
				GameTooltip:AddDoubleLine(ICON1.." "..L['申请人数'], C_LFGList.GetNumApplicants(), 1, 1, 1, 1, 1, 1)
			else
				GameTooltip:AddDoubleLine(ICON1.." "..L['申请中活动'], C_LFGList.GetNumApplications(), 1, 1, 1, 1, 1, 1)
			end
			local item = MeetingStoneBrowsePanel:GetCurrentActivity()
			local label = item and format(ICON2.." "..L['“%s”总数'], item.text) or L['活动总数']
			GameTooltip:AddDoubleLine(label, MeetingStoneDataBroker.activityCount or 0, 1, 1, 1, 1, 1, 1)
			if MeetingStoneApp:HasApp() then
                GameTooltip:AddDoubleLine(ICON3.." "..L['关注请求'], MeetingStoneDataBroker.followQueryCount or 0, 1, 1, 1, 1, 1, 1)
            end
			GameTooltip:Show()
			MBCC_Hide()
		end)
		f.MeetingStone: SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
	else
		f.MeetingStone: SetSize(F.Debug,26)
		f.MeetingStone: Hide()
	end
end

--- ------------------------------------------------------------
--> WIM
--- ------------------------------------------------------------

local function ToggleWIM(parent)
	WIM3Menu:ClearAllPoints();
    if(WIM3Menu:IsShown()) then
        WIM3Menu:Hide();
    else
        WIM3Menu:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0,4);
        WIM3Menu:Show();
    end
end

local function WIM_Frame(f)
	local WIM = CreateFrame("Button", nil, f)
	WIM: SetSize(32,26)
	WIM: SetPoint("BOTTOMLEFT", f.MeetingStone, "BOTTOMRIGHT", 0,0)
	WIM: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	WIM: SetBackdrop(backdrop)
	WIM: SetBackdropColor(F.Color(C.Color.Main0, 0.6))

	local Icon = F.create_Texture(WIM, "ARTWORK", "Icons\\Message16", C.Color.Main1)
	Icon: SetSize(16,16)
	Icon: SetAlpha(0.8)
	Icon: SetPoint("CENTER", WIM, "LEFT", 16,0)

	local Flash = CreateFrame("Frame", nil, WIM, "Quafe_GarrisonNotificationTemplate")
	Flash: SetFrameLevel(WIM: GetFrameLevel())
	Flash: SetAllPoints(WIM)
	Flash.Timing = false
	Flash: HookScript("OnShow", function(self)
		if not Flash.Timing then
			Flash.Timing = true
			C_Timer.After(5, function(self)
				Flash:Hide()
				Flash.Timing = false
			end)
		end
	end)
	
	local FlashGlow = Flash: CreateTexture(nil, "BORDER")
	FlashGlow: SetTexture(F.Path("White"))
	FlashGlow: SetVertexColor(F.Color(C.Color.Y3))
	FlashGlow: SetAlpha(0.5)
	FlashGlow: SetAllPoints(WIM)

	WIM: SetScript("OnClick", function(self, button)
		if IsAddOnLoaded("WIM") then
			ToggleWIM(WIM)
		end
	end)

	WIM: SetScript("OnEnter", function(self)
		Flash: Hide()
	end)

	WIM: RegisterEvent("CHAT_MSG_WHISPER")
	WIM: RegisterEvent("CHAT_MSG_BN_WHISPER")
	WIM: SetScript("OnEvent", function(self, event, ...)
		Flash: Show()
	end)

	f.WIM = WIM
end

--- ------------------------------------------------------------
--> InfoBar
--- ------------------------------------------------------------

local InfoBar = CreateFrame("Frame", "Quafe_InfoBar", E)
InfoBar: SetSize(26,26)
InfoBar: SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2,2)
InfoBar.Init = false
InfoBar: Hide()

local function Quafe_InfoBar_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].Enable then
		MicroMenu_Frame(InfoBar)
		Time_Frame(InfoBar)
		Network_Frame(InfoBar)
		MBC_Frame(InfoBar)
		Friend_Frame(InfoBar)
		Guild_Frame(InfoBar)
		MeetingStone_Frame(InfoBar)
		WIM_Frame(InfoBar)

		InfoBar: Show()

		InfoBar.Init = true
	end
end
local function Quafe_InfoBar_Toggle(arg)
	if arg == "ON" then
		Quafe_NoticeReload()
	elseif arg == "OFF" then
		Quafe_NoticeReload()
	elseif arg == "COLOR" then
		
	end
end

local Quafe_InfoBar_Config = {
	Database = {
		["Quafe_InfoBar"] = {
			Enable = true,
			MBC = true,
		},
	},

	Config = {
		Name = "Quafe "..L['INFO_BAR'],
		Type = "Switch",
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].Enable = false
				self.Text:SetText(L["OFF"])
				Quafe_InfoBar_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].Enable = true
				self.Text:SetText(L["ON"])
				Quafe_InfoBar_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['MBC'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].MBC then
						Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].MBC = false
						self.Text:SetText(L["OFF"])
						Quafe_NoticeReload()
					else
						Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].MBC = true
						self.Text:SetText(L["ON"])
						InfoBar.MBCFrame.Refresh()
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_InfoBar"].MBC then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}

InfoBar.Load = Quafe_InfoBar_Load
InfoBar.Config = Quafe_InfoBar_Config
insert(E.Module, InfoBar)


--- ------------------------------------------------------------
--> Exp Bar
--- ------------------------------------------------------------

local function ExpBar_Artwork(frame)
	local BarBack = frame:CreateTexture(nil, "BACKGROUND")
	BarBack: SetTexture(F.Path("White"))
	BarBack: SetVertexColor(F.Color(C.Color.Main0))
	BarBack: SetAlpha(0.25)
	BarBack: SetHeight(8)
	BarBack: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2,2)
	BarBack: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2,2)

	local BarBg = frame:CreateTexture(nil, "BORDER")
	BarBg: SetTexture(F.Path("White"))
	BarBg: SetVertexColor(F.Color(C.Color.Main1))
	BarBg: SetAlpha(0.5)
	BarBg: SetHeight(2)
	BarBg: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,0)
	BarBg: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,0)

	local BarBgL = frame:CreateTexture(nil, "BORDER")
	BarBgL: SetTexture(F.Path("White"))
	BarBgL: SetVertexColor(F.Color(C.Color.Main1))
	BarBgL: SetAlpha(0.5)
	BarBgL: SetSize(2,12)
	BarBgL: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,2)

	local BarBgR = frame:CreateTexture(nil, "BORDER")
	BarBgR: SetTexture(F.Path("White"))
	BarBgR: SetVertexColor(F.Color(C.Color.Main1))
	BarBgR: SetAlpha(0.5)
	BarBgR: SetSize(2,12)
	BarBgR: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,2)
	
	local Bar = CreateFrame("StatusBar", nil, frame)
	Bar: SetStatusBarTexture(F.Path("White"))
	Bar: SetFillStyle("STANDARD_NO_RANGE_FILL")
	Bar: SetStatusBarColor(F.Color(C.Color.Main2))
	Bar: SetMinMaxValues(0,1)
	Bar: SetAlpha(0.9)
	Bar: SetHeight(8)
	Bar: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2,2)
	Bar: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2,2)

	local Vernier = Bar: CreateTexture(nil, "OVERLAY")
	Vernier: SetTexture(F.Path("White"))
	Vernier: SetVertexColor(F.Color(C.Color.Main1))
	Vernier: SetAlpha(0.75)
	Vernier: SetSize(2,12)
	Vernier: SetPoint("BOTTOM", Bar:GetStatusBarTexture(), "BOTTOMRIGHT", 0,0)

	local ExVernier = Bar: CreateTexture(nil, "OVERLAY")
	ExVernier: SetTexture(F.Path("White"))
	ExVernier: SetVertexColor(F.Color(C.Color.Main1))
	ExVernier: SetAlpha(0.75)
	ExVernier: SetSize(2,3)
	ExVernier: SetPoint("TOP", Bar:GetStatusBarTexture(), "BOTTOMRIGHT", 0,-4)

	local Level = F.create_Font(frame, C.Font.NumSmall, 18, nil, 0.75)
	Level: SetTextColor(F.Color(C.Color.Main1))
	Level: SetAlpha(0.9)
	Level: SetPoint("LEFT", frame, "TOPLEFT", 2,-10)
	Level: SetText("30")

	local Value = F.create_Font(frame, C.Font.NumSmall, 14, nil, 0.75)
	Value: SetTextColor(F.Color(C.Color.Main1))
	Value: SetAlpha(0.6)
	Value: SetPoint("RIGHT", frame, "TOPRIGHT", -2,-10)
	Value: SetText("1000/10000")
	
	frame.Bar = Bar
	frame.Level = Level
	frame.Value = Value
end

local function ExpBar_RePos(self, event, ...)
	if event == "ALL" or event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" then
		if UnitInParty("player") then
			self: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 60, -120)
		else
			self: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 60, -40)
		end
	end
end

local function ExpBar_Update(frame)
	frame: SetScript("OnUpdate", function(bar, elapsed)
		local limit = 30/GetFramerate()
		frame.Info.XP = frame.Info.XP + math.min((frame.Info.CurXP-frame.Info.XP)/6, math.max(frame.Info.CurXP-frame.Info.XP, limit))
		if abs(frame.Info.XP - frame.Info.CurXP) <= 1 then
			frame.Info.XP = frame.Info.CurXP
			frame.Bar: SetValue(frame.Info.XP)
			frame.Value: SetText(format("%d/%d", frame.Info.XP, frame.Info.MaxXP))
			frame: SetScript("OnUpdate", nil)
		else
			frame.Bar: SetValue(frame.Info.XP)
			frame.Value: SetText(format("%d/%d", frame.Info.XP, frame.Info.MaxXP))
		end
	end)
end

local function ExpBar_Event(frame, event, ...)
	local newLevel = UnitLevel("player")
	local ShowExp,AzeriteItemLocation
	if F.IsClassic then
		ShowExp = (newLevel < MAX_PLAYER_LEVEL);
		AzeriteItemLocation = false;
	else
		ShowExp = (newLevel < MAX_PLAYER_LEVEL) and (not IsXPUserDisabled());
		AzeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem();
	end
	local DATA = Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"]
	if (ShowExp and DATA.Enable) then
		local minXP = UnitXP("player") or 0
		local maxXP = UnitXPMax("player")
		if frame.Info.MaxXP ~= maxXP then
			frame.Bar: SetMinMaxValues(0,maxXP)
			frame.Info.MaxXP = maxXP
			frame.Info.CurXP = minXP
			ExpBar_Update(frame)
		end
		if frame.Info.CurXP ~= minXP then
			frame.Info.CurXP = minXP
			ExpBar_Update(frame)
		end
		if frame.Info.Level ~= newLevel then
			frame.Info.Level = newLevel
			frame.Level: SetText(frame.Info.Level)
		end
		frame: Show()
	elseif (AzeriteItemLocation and DATA.Enable and DATA.Azerite) then
		local minXP,maxXP = C_AzeriteItem.GetAzeriteItemXPInfo(AzeriteItemLocation)
		local azeriteLevel = C_AzeriteItem.GetPowerLevel(AzeriteItemLocation)
		if frame.Info.MaxXP ~= maxXP then
			frame.Bar: SetMinMaxValues(0,maxXP)
			frame.Info.MaxXP = maxXP
			frame.Info.CurXP = minXP
			ExpBar_Update(frame)
		end
		if frame.Info.CurXP ~= minXP then
			frame.Info.CurXP = minXP
			ExpBar_Update(frame)
		end
		if frame.Info.Level ~= azeriteLevel then
			frame.Info.Level = azeriteLevel
			frame.Level: SetText(frame.Info.Level)
		end
		frame: Show()
	else
		frame: Hide()
	end
end

local function ExpBar_OnEvent(frame)
	frame: SetScript("OnEvent", function(self, event, ...)
		ExpBar_RePos(frame, event, ...)
		ExpBar_Event(frame, event, ...)
	end)
end

local function ExpBar_Refresh(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterEvent("PLAYER_XP_UPDATE")
	frame: RegisterEvent("PLAYER_LEVEL_UP")
	frame: RegisterEvent("GROUP_ROSTER_UPDATE")
	if (not F.IsClassic) and Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Azerite then
		frame: RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
		frame: RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	end
	ExpBar_RePos(frame, "ALL")
	ExpBar_Event(frame, "ALL")
end

local Quafe_ExpBar = CreateFrame("Frame", "Quafe_ExpBar", E)
Quafe_ExpBar: SetSize(440,40)
Quafe_ExpBar: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100, -60)
Quafe_ExpBar.Init = false
Quafe_ExpBar.Info = {}
Quafe_ExpBar.Info.CurXP = 0
Quafe_ExpBar.Info.MaxXP = 1
Quafe_ExpBar.Info.Level = 0
Quafe_ExpBar.Info.XP = 0

local function Quafe_ExpBar_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Enable then
		ExpBar_Artwork(Quafe_ExpBar)
		ExpBar_OnEvent(Quafe_ExpBar)
		ExpBar_Refresh(Quafe_ExpBar)
		Quafe_ExpBar.Init = true
	end
end

local function Quafe_ExpBar_Toggle(arg)
	if arg == "ON" then
		if not Quafe_ExpBar.Init == true then
			Quafe_ExpBar_Load()
		end
	elseif arg == "OFF" then
		Quafe_ExpBar: UnregisterAllEvents()
	elseif arg == "A_ON" then

	elseif arg == "A_OFF" then
		if (not F.IsClassic) then
			Quafe_ExpBar: UnregisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
			Quafe_ExpBar: UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
		end
	end
	ExpBar_Refresh(Quafe_ExpBar)
end

local Quafe_ExpBar_Config = {
	Database = {
		["Quafe_ExpBar"] = {
			Enable = true,
			Azerite = true,
		},
	},

	Config = {
		Name = "Quafe "..L['经验条'],
		Type = "Switch",
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Enable = false
				self.Text:SetText(L["OFF"])
				Quafe_ExpBar_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Enable = true
				self.Text:SetText(L["ON"])
				Quafe_ExpBar_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['艾泽里特'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Azerite then
						Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Azerite = false
						self.Text:SetText(L["OFF"])
						Quafe_ExpBar_Toggle("A_OFF")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Azerite = true
						self.Text:SetText(L["ON"])
						Quafe_ExpBar_Toggle("A_ON")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ExpBar"].Azerite then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}

Quafe_ExpBar.Load = Quafe_ExpBar_Load
Quafe_ExpBar.Config = Quafe_ExpBar_Config
tinsert(E.Module, Quafe_ExpBar)