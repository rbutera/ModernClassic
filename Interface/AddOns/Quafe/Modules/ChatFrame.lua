local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local
--local ChatModule = Quafe:NewModule("Chat", "AceHook-3.0")

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

----------------------------------------------------------------
--> Init
----------------------------------------------------------------

local function Quafe_ChatFrame_FontSize()
	--> 增加聊天栏字体大小选项
	for i = 1, 7 do
		CHAT_FONT_HEIGHTS[i] = i + 10
	end
end

local function Quafe_ChatFrame_Init(f)
	CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
	CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
	--CHAT_TIMESTAMP_FORMAT = TIMESTAMP_FORMAT_HHMM_24HR
	F.HideFrame(ChatFrameMenuButton, true)
	if F.IsClassic then

	else
		F.HideFrame(QuickJoinToastButton, true)
	end
	Quafe_ChatFrame_FontSize()
end

----------------------------------------------------------------
--> Skin
----------------------------------------------------------------

local backdrop = {
	bgFile = F.Path("White"),
	edgeFile = "",
	tile = true, tileSize = 16, edgeSize = 0,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
}

local function HideTexture(f)
	f:SetTexture(nil)
	f.SetTexture = function() return end
end

local OldAddMessage = {}
local function AddMessage(self, text, ...)
	text = BetterDate("[%H:%M]", time()).." "..text
	return OldAddMessage[self](self, text, ...)
end

local function Quafe_ChatFrame_Skin_Event(f, event)
	for _, frameName in pairs(CHAT_FRAMES) do
		local ChatFrame = _G[frameName]
		if not ChatFrame.styled then
            local Tab = _G[frameName.."Tab"]
            local EditBox = _G[frameName.."EditBox"]
            local i = ChatFrame:GetID()
			 
			for tex = 1, #CHAT_FRAME_TEXTURES do
				_G[frameName..CHAT_FRAME_TEXTURES[tex]]:SetTexture(nil)
			end
			
			if i and (i ~= 2) then
				--OldAddMessage[ChatFrame] = ChatFrame.Addmessage
				--ChatFrame.AddMessage = AddMessage
			end
			if i == 2 then
				
			end
			
			local ebParts = {"Left", "Mid", "Right", "Middle"}
			for _, ebParts in ipairs(ebParts) do
				if _G[frameName.."EditBox"..ebParts] then
					HideTexture(_G[frameName.."EditBox"..ebParts])
				end
				if _G[frameName.."EditBoxFocus"..ebParts] then
					HideTexture(_G[frameName.."EditBoxFocus"..ebParts])
				end
				if _G[frameName.."Tab"..ebParts] then
					HideTexture(_G[frameName.."Tab"..ebParts])
				end
				if _G[frameName.."TabHighlight"..ebParts] then
					HideTexture(_G[frameName.."TabHighlight"..ebParts])
				end
				if _G[frameName.."TabSelected"..ebParts] then
					HideTexture(_G[frameName.."TabSelected"..ebParts])
				end
			end
			
			F.HideFrame(_G[frameName.."ButtonFrame"], true)
			F.HideFrame(_G[frameName.."EditBoxLanguage"], true)
			if (not F.IsClassic) then
				F.HideFrame(ChatFrame.ScrollBar, true)
			end
			
			ChatFrame: SetShadowColor(0,0,0)
			ChatFrame: SetShadowOffset(1,-1)
			ChatFrame: SetSpacing(1)
			
			ChatFrame: SetFading(true)
			ChatFrame: SetFadeDuration(1.5)  --> 3
			ChatFrame: SetTimeVisible(20)  --> 120
			
			Tab: SetClampedToScreen(true)
			Tab: SetAlpha(0)
			Tab.noMouseAlpha = 0
			ChatFrame: SetClampedToScreen(true)
			
			local FrameBack = CreateFrame("Frame", frameName.."_Backdrop", ChatFrame)
			FrameBack: SetFrameLevel(ChatFrame:GetFrameLevel()-1)
			if i == 2 then
				FrameBack: SetPoint("TOPLEFT", ChatFrame, "TOPLEFT", -3-28,25)
			else
				--FrameBack: SetPoint("TOPLEFT", ChatFrame, "TOPLEFT", -3,3)
				FrameBack: SetPoint("TOPLEFT", ChatFrame, "TOPLEFT", -3-28,3)
			end
			--FrameBack: SetPoint("BOTTOMRIGHT", ChatFrame, "BOTTOMRIGHT", 1+26,-3)
			FrameBack: SetPoint("BOTTOMRIGHT", ChatFrame, "BOTTOMRIGHT", 3,-3)
			FrameBack: SetBackdrop(backdrop)
			FrameBack: SetBackdropColor(F.Color(C.Color.Black, 0.6))
			--FrameBack: SetClampedToScreen(true)
			FrameBack: SetAlpha(1)
			FrameBack: Hide()

			--ChatFrame.ScrollBar: SetThumbTexture(F.Path("Config_Slider"), "ARTWORK")
			local FrameSlider = CreateFrame("Slider", frameName.."_Slider", ChatFrame)
			FrameSlider: SetFrameLevel(FrameBack:GetFrameLevel()+2)
			FrameSlider: SetOrientation("VERTICAL")
			FrameSlider: SetThumbTexture(F.Path("Config_Slider"), "ARTWORK")
			FrameSlider: SetSize(18,0)
			--FrameSlider: SetPoint("TOPRIGHT", FrameBack, "TOPRIGHT", -3,-8)
			--FrameSlider: SetPoint("BOTTOMRIGHT", FrameBack, "BOTTOMRIGHT", -3,8)
			FrameSlider: SetPoint("TOPLEFT", FrameBack, "TOPLEFT", 5,-8)
			FrameSlider: SetPoint("BOTTOMLEFT", FrameBack, "BOTTOMLEFT", 5,8)
			FrameSlider: SetMinMaxValues(1, 2)
			FrameSlider: SetObeyStepOnDrag(true)
			FrameSlider: SetValueStep(1)
			FrameSlider: Enable()
			FrameSlider: SetValue(1)
			FrameSlider: SetAlpha(0)
			
			FrameSlider: SetScript("OnValueChanged", function(self, value)
				local min, max = self:GetMinMaxValues();
				self:GetParent(): SetScrollOffset(max - value);
			end)
			
			ChatFrame.Slider = FrameSlider

			local function Slider_Update(self)
				local numMessages = self:GetNumMessages();
				local isShown = numMessages > 1;
				if isShown then
					self.Slider:SetMinMaxValues(1, numMessages);
					self.Slider:SetValue(numMessages - self:GetScrollOffset());
			
					-- If the chat frame was already faded in, and something caused the scrollbar to show
					-- it also needs to update fading in addition to showing.
					--if (self.hasBeenFaded) then
					--	FCF_FadeInScrollbar(self);
					--end
				end
			end
			ChatFrame.Slider: RegisterEvent("PLAYER_ENTERING_WORLD")
			ChatFrame.Slider: SetScript("OnEvent", function(self, event)
				local numMessages = ChatFrame:GetNumMessages();
				local offset = ChatFrame:GetScrollOffset()
				local isShown = numMessages > 1;
				if isShown then
					self:SetMinMaxValues(1, numMessages);
					self:SetValue(1)
					self:SetValue(numMessages - offset);
				end
				--self: UnregisterEvent("PLAYER_ENTERING_WORLD")
			end)
			ChatFrame:SetOnScrollChangedCallback(function(messageFrame, offset)
				messageFrame.Slider:SetValue(messageFrame:GetNumMessages() - offset);
			end);
			ChatFrame:SetOnDisplayRefreshedCallback(Slider_Update);
			
			local FrameSliderHelp = CreateFrame("Frame", nil, ChatFrame)
			FrameSliderHelp: SetFrameLevel(FrameBack:GetFrameLevel()+1)
			FrameSliderHelp: SetPoint("TOPLEFT", FrameSlider, "TOPLEFT", -14, 30)
			FrameSliderHelp: SetPoint("BOTTOMRIGHT", FrameSlider, "BOTTOMRIGHT", 18, -30)
			
			FrameSliderHelp: SetScript("OnEnter", function(self)
				FrameSlider: SetAlpha(0.9)
			end)
			FrameSliderHelp: SetScript("OnLeave", function(self)
				if not (FrameSlider:IsMouseOver() or FrameBack:IsShown()) then
					FrameSlider: SetAlpha(0)
				end
			end)
			FrameSlider: SetScript("OnLeave", function(self)
				if (not (FrameSlider:IsMouseOver() or FrameSliderHelp:IsMouseOver())) and FrameSliderHelp:IsShown() and (not FrameBack:IsShown()) then
					FrameSlider: SetAlpha(0)
				end
			end)
			
			local FrameSliderBack = FrameSlider:CreateTexture(nil, "BACKGROUND")
			FrameSliderBack: SetTexture(F.Path("White"))
			FrameSliderBack: SetVertexColor(F.Color(C.Color.White2))
			FrameSliderBack: SetWidth(4)
			FrameSliderBack: SetPoint("TOP", FrameSlider, "TOP", 0,0)
			FrameSliderBack: SetPoint("BOTTOM", FrameSlider, "BOTTOM", 0,0)
			FrameSliderBack: SetAlpha(0.6)
			
			EditBox: ClearAllPoints()
			EditBox: SetPoint("TOPLEFT", ChatFrame, "BOTTOMLEFT", 0, -4)
			EditBox: SetPoint("TOPRIGHT", ChatFrame, "BOTTOMRIGHT", -26, -4)

			local EditBoxBack = CreateFrame("Frame", nil, EditBox)
			EditBoxBack: SetFrameLevel(EditBox:GetFrameLevel()-1)
			EditBoxBack: SetPoint("TOPLEFT", EditBox, "TOPLEFT", -3, -3)
			EditBoxBack: SetPoint("BOTTOMRIGHT", EditBox, "BOTTOMRIGHT", 3+26, 3)
			EditBoxBack: SetBackdrop(backdrop)
			EditBoxBack: SetBackdropColor(F.Color(C.Color.Black, 0.6))
			EditBoxBack: Hide()
			
			local EditBoxBack_MenuButton = CreateFrame("Button", frameName.."EditBox_MenuButton", EditBoxBack)
			--EditBoxBack_MenuButton: SetFrameStrata("DIALOG")
			EditBoxBack_MenuButton: SetFrameLevel(EditBox:GetFrameLevel()+1)
			EditBoxBack_MenuButton: SetPoint("TOPLEFT", EditBoxBack, "TOPLEFT", 0,0)
			EditBoxBack_MenuButton: SetPoint("BOTTOMRIGHT", EditBoxBack, "BOTTOMLEFT", 44,0)
			EditBoxBack_MenuButton: RegisterForClicks("LeftButtonUp", "RightButtonUp")
			EditBoxBack_MenuButton: SetScript("OnClick", function(self, button)
				if ChatChannelSwitch then
					if ChatChannelSwitch: IsShown() then
						ChatChannelSwitch: Hide()
					else
						ChatChannelSwitch: SetPoint("BOTTOMLEFT", EditBoxBack_MenuButton, "TOPLEFT", 0,2)
						ChatChannelSwitch: Show()
					end
				end
			end)
			
			--local EditBox_Language = CreateFrame("Button", frameName.."EditBox_Language", EditBoxBack, "SecureActionButtonTemplate")
			local EditBox_Language = CreateFrame("Button", frameName.."EditBox_Language", EditBoxBack)
			EditBox_Language: SetFrameLevel(EditBox:GetFrameLevel()+1)
			EditBox_Language: SetPoint("TOPLEFT", EditBoxBack, "TOPRIGHT", -26, 0)
			EditBox_Language: SetPoint("BOTTOMRIGHT", EditBoxBack, "BOTTOMRIGHT", 0, 0)
			--EditBox_Language: SetNormalFontObject(DialogButtonNormalText)
			EditBox_Language: SetNormalFontObject(DialogButtonHighlightText)
			EditBox_Language: SetText(_G["INPUT_"..EditBox:GetInputLanguage()])
			--EditBox_Language: SetAttribute("type", "click")
			--EditBox_Language: SetAttribute("clickbutton", _G[frameName.."EditBoxLanguage"])
			EditBox_Language: SetScript("OnClick", function(self)
				EditBox: ToggleInputLanguage()
			end)
			EditBox: HookScript("OnInputLanguageChanged", function(self)
				local variable = _G["INPUT_"..self:GetInputLanguage()]
				EditBox_Language: SetText(variable)
			end)
			
			local EditBox_LanguageBorder = EditBox_Language: CreateTexture(nil, "ARTWORK")
			EditBox_LanguageBorder: SetTexture(F.Path("White"))
			EditBox_LanguageBorder: SetVertexColor(F.Color(C.Color.White))
			EditBox_LanguageBorder: SetAlpha(0.9)
			EditBox_LanguageBorder: SetPoint("TOPLEFT", EditBox_Language, "TOPLEFT", 0,-4)
			EditBox_LanguageBorder: SetPoint("BOTTOMRIGHT", EditBox_Language, "BOTTOMLEFT", 2,4)
			
			EditBox: Hide()
			EditBox: HookScript("OnEditFocusGained", function(self)
				--UIFrameFadeIn(EditBoxBack, 0.2, 0, 1)
				EditBoxBack: Show()
				FrameBack: Show()
				FrameSlider: SetAlpha(0.9)
				FrameSliderHelp: Hide()
				--EditBoxBack_MenuButton:Raise();
			end)
			EditBox: HookScript("OnEditFocusLost", function(self)
				--UIFrameFadeOut(EditBoxBack, 0.2, 1, 0)
				EditBoxBack: Hide()
				FrameBack: Hide()
				FrameSlider: SetAlpha(0)
				FrameSliderHelp: Show()
				if ChatChannelSwitch then
					if ChatChannelSwitch: IsShown() then
						ChatChannelSwitch: Hide()
					end
				end
			end)

			if i ~= 1 then
				ChatFrame1EditBox: HookScript("OnEditFocusGained", function(self)
					FrameBack: Show()
					FrameSlider: SetAlpha(0.9)
					FrameSliderHelp: Hide()
				end)
				ChatFrame1EditBox: HookScript("OnEditFocusLost", function(self)
					FrameBack: Hide()
					FrameSlider: SetAlpha(0)
					FrameSliderHelp: Show()
				end)
			end
			
			ChatFrame.styled = true
		end
	end
end

local function Skin_OnEnteringWorld()
	CombatLogQuickButtonFrame_CustomTexture: SetAlpha(0)

	--ChatAlertFrame
	ChatFrameChannelButton: ClearAllPoints();
	ChatFrameChannelButton: SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPLEFT", -3, 3);
	if F.IsClassic then
	else
		ChatFrameToggleVoiceDeafenButton: ClearAllPoints();
		ChatFrameToggleVoiceDeafenButton: SetPoint("BOTTOM", ChatFrameChannelButton, "TOP", 0, 2);
		ChatFrameToggleVoiceMuteButton: ClearAllPoints();
		ChatFrameToggleVoiceMuteButton: SetPoint("BOTTOM", ChatFrameToggleVoiceDeafenButton, "TOP", 0, 2);
	end
	--VoiceActivityManager
end

local function Quafe_ChatFrame_Skin(frame)
	local Skin = CreateFrame("Frame", nil, frame)
	Skin: RegisterEvent("UPDATE_CHAT_WINDOWS")
	Skin: RegisterEvent("UPDATE_FLOATING_CHAT_WINDOWS")
	if F.IsClassic then
	else
		Skin: RegisterEvent("PET_BATTLE_CLOSE")
	end
	Skin: RegisterEvent("PLAYER_ENTERING_WORLD")
	Skin: SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" then
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
			Skin_OnEnteringWorld()
		else
			Quafe_ChatFrame_Skin_Event(self, event)
		end
	end)
end

----------------------------------------------------------------
--> EditBox Channel Toggle Button
----------------------------------------------------------------

local CHAT_CHANNEL = {
	--RAID_WARNING,
	{Text = SAY, Type = "SAY"},
	{Text = YELL, Type = "YELL"},
	{Text = EMOTE, Type = "EMOTE"},
	{Text = PARTY, Type = "PARTY"},
	{Text = RAID, Type = "RAID"},
	{Text = INSTANCE, Type = "INSTANCE_CHAT"},
	{Text = GUILD, Type = "GUILD"},
	{Text = OFFICER, Type = "OFFICER"},
}

local function Quafe_ChatFrame_ChannelToggle(f)
	f.ChatSwitch = CreateFrame("Frame", "ChatChannelSwitch", f)
	f.ChatSwitch: SetSize(44,10)
	--f.ChatSwitch: SetPoint("BOTTOMLEFT", ChatFrame1EditBox, "TOPLEFT", 0,0)
	f.ChatSwitch: Hide()
	
	f.ChatSwitch.Channel = {}
	for i,v in ipairs(CHAT_CHANNEL) do
		f.ChatSwitch.Channel[i] = CreateFrame("Button", nil,f.ChatSwitch)
		f.ChatSwitch.Channel[i]: SetSize(44, 20)
		if i == 1 then
			f.ChatSwitch.Channel[i]: SetPoint("BOTTOM", f.ChatSwitch, "BOTTOM", 0,0)
		else
			f.ChatSwitch.Channel[i]: SetPoint("BOTTOM", f.ChatSwitch.Channel[i-1], "TOP", 0,0)
		end
		
		f.ChatSwitch.Channel[i]: SetBackdrop(backdrop)
		f.ChatSwitch.Channel[i]: SetBackdropColor(F.Color(C.Color.Black, 0.95))
		
		f.ChatSwitch.Channel[i].Text = F.create_Font(f.ChatSwitch.Channel[i], C.Font.Txt, 12, nil, 0)
		f.ChatSwitch.Channel[i].Text: SetPoint("CENTER")
		f.ChatSwitch.Channel[i].Text: SetText(v.Text)
		
		f.ChatSwitch.Channel[i]: RegisterForClicks("AnyUp")
		f.ChatSwitch.Channel[i]: SetScript("OnClick", function(self, button)
			for _, frameName in pairs(CHAT_FRAMES) do
				if _G[frameName.."EditBox"]:HasFocus() then
					_G[frameName.."EditBox"]:SetAttribute("chatType", v.Type)
					ChatEdit_UpdateHeader(_G[frameName.."EditBox"])
				end
			end
			f.ChatSwitch: Hide()
		end)
	end
end

----------------------------------------------------------------
--> Chat History
----------------------------------------------------------------

local function Quafe_ChaTFrame_SaveHistory(event, ...)
	local TEMP = {}
    for i = 1, select('#', ...) do
        TEMP[i] = select(i, ...) or false
    end
	if #TEMP > 0 then
		TEMP["Event"] = event
		table.insert(Quafe_DBP.ChatFrame_History, TEMP)
		if #Quafe_DBP.ChatFrame_History > 100 then
			table.remove(Quafe_DBP.ChatFrame_History, 1)
		end
	end
end

local function Quafe_ChatFrame_DisplayHistory()
	if not Quafe_DBP.ChatFrame_History then return end
	DEFAULT_CHAT_FRAME:AddMessage("--------------------------------")
	for i = 1, #Quafe_DBP.ChatFrame_History do
		ChatFrame_MessageEventHandler(DEFAULT_CHAT_FRAME, Quafe_DBP.ChatFrame_History[i]["Event"], unpack(Quafe_DBP.ChatFrame_History[i]))
	end
	DEFAULT_CHAT_FRAME:AddMessage("--------------------------------")
end

local History_Event = {
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_BN_WHISPER",
	"CHAT_MSG_BN_WHISPER_INFORM",
	"CHAT_MSG_CHANNEL",
	--"CHAT_MSG_EMOTE",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_GUILD_ACHIEVEMENT",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	--"CHAT_MSG_BATTLEGROUND",
	--"CHAT_MSG_BATTLEGROUND_LEADER",
}

local function Quafe_ChatFrame_History(frame)
	if not Quafe_DBP then
		Quafe_DBP = {}
	end
	if not Quafe_DBP.ChatFrame_History then
		Quafe_DBP.ChatFrame_History = {}
	end
	
	local Quafe_ChatFrame_History = CreateFrame("Frame", nil, frame)
	--[[
	--ChatFrame_History: RegisterEvent("CHAT_MSG_BATTLEGROUND")
	--ChatFrame_History: RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER")
    ChatFrame_History: RegisterEvent("CHAT_MSG_BN_WHISPER")
    ChatFrame_History: RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")
    ChatFrame_History: RegisterEvent("CHAT_MSG_CHANNEL")
    ChatFrame_History: RegisterEvent("CHAT_MSG_EMOTE")
    ChatFrame_History: RegisterEvent("CHAT_MSG_GUILD")
    ChatFrame_History: RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
    ChatFrame_History: RegisterEvent("CHAT_MSG_OFFICER")
    ChatFrame_History: RegisterEvent("CHAT_MSG_PARTY")
    ChatFrame_History: RegisterEvent("CHAT_MSG_PARTY_LEADER")
    ChatFrame_History: RegisterEvent("CHAT_MSG_RAID")
    ChatFrame_History: RegisterEvent("CHAT_MSG_RAID_LEADER")
    ChatFrame_History: RegisterEvent("CHAT_MSG_RAID_WARNING")
    ChatFrame_History: RegisterEvent("CHAT_MSG_SAY")
    ChatFrame_History: RegisterEvent("CHAT_MSG_WHISPER")
    ChatFrame_History: RegisterEvent("CHAT_MSG_WHISPER_INFORM")
	ChatFrame_History: RegisterEvent("CHAT_MSG_YELL")
	--]]
	for k, v in ipairs(History_Event) do
		Quafe_ChatFrame_History: RegisterEvent(v)
	end
    Quafe_ChatFrame_History: SetScript("OnEvent", function(self, event, ...)
		Quafe_ChaTFrame_SaveHistory(event, ...)
	end)
	Quafe_ChatFrame_DisplayHistory()

	frame.History = Quafe_ChatFrame_History
end

----------------------------------------------------------------
--> Load
----------------------------------------------------------------

local Quafe_ChatFrame = CreateFrame("Frame", "Quafe_ChatFrame", E)
Quafe_ChatFrame.Init = false

local function Quafe_ChatFrame_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ChatFrame.Enable then
		Quafe_ChatFrame_Init(Quafe_ChatFrame)
		Quafe_ChatFrame_Skin(Quafe_ChatFrame)
		Quafe_ChatFrame_ChannelToggle(Quafe_ChatFrame)
		Quafe_ChatFrame_History(Quafe_ChatFrame)
		Quafe_ChatFrame.Init = true
	end
end

local function Quafe_ChatFrame_Toggle(arg)
	if arg == "ON" then
		Quafe_NoticeReload()
	elseif arg == "OFF" then
		Quafe_NoticeReload()
	end
end

local Quafe_ChatFrame_Config = {
	Database = {
		Quafe_ChatFrame = {
			Enable = true,
		},
	},

	Config = {
		Name = "Quafe "..L['CHAT_FRAME'],
		Type = "Switch",
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ChatFrame.Enable then
				Quafe_ChatFrame_Toggle("OFF")
				Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ChatFrame.Enable = false
				self.Text:SetText(L["OFF"])
			else
				Quafe_ChatFrame_Toggle("ON")
				Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ChatFrame.Enable = true
				self.Text:SetText(L["ON"])
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ChatFrame.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = nil,
	},
}

Quafe_ChatFrame.Load = Quafe_ChatFrame_Load
Quafe_ChatFrame.Config = Quafe_ChatFrame_Config
insert(E.Module, Quafe_ChatFrame)

----------------------------------------------------------------

-- ScrollingMessageFrame:SetScrollOffset(offset)
-- ScrollingMessageFrame:GetScrollOffset()

-- ScrollingMessageFrame:GetMaxLines() - Get the maximum number of lines the frame can display.
-- ScrollingMessageFrame:GetMaxScrollRange()