local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

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

local function RemoveAnchor(f)
	for i, alertSubSystem in pairs(AlertFrame.alertFrameSubSystems) do
		if alertSubSystem.anchorFrame == f then
			tremove(AlertFrame.alertFrameSubSystems, i)
			return 
		end
	end
end

--- ------------------------------------------------------------
--> TalkingHead
--- ------------------------------------------------------------
--["TalkingHeads-Horde"] = {Name = CreateColor(0.28, 0.02, 0.02), Text = CreateColor(1, 1, 1), Shadow = CreateColor(0.0, 0.0, 0.0, 1.0)},
--["TalkingHeads-Alliance"] = {Name = CreateColor(0.02, 0.17, 0.33), Text = CreateColor(1, 1, 1), Shadow = CreateColor(0.0, 0.0, 0.0, 1.0)},
--["TalkingHeads-Neutral"] = {Name = CreateColor(0.33, 0.16, 0.02), Text = CreateColor(1, 1, 1), Shadow = CreateColor(0.0, 0.0, 0.0, 1.0)},
local talkingHeadFontColor = {
	["TalkingHeads-Horde"] = {Name = CreateColor(1, 0.07, 0.07), Text = CreateColor(1, 1, 1), Shadow = CreateColor(0.0, 0.0, 0.0, 1.0)},
	["TalkingHeads-Alliance"] = {Name = CreateColor(0.06, 0.49, 1), Text = CreateColor(1, 1, 1), Shadow = CreateColor(0.0, 0.0, 0.0, 1.0)},
	["TalkingHeads-Neutral"] = {Name = CreateColor(1, 0.49, 0.06), Text = CreateColor(1, 1, 1), Shadow = CreateColor(0.0, 0.0, 0.0, 1.0)},
	["Normal"] = {Name = CreateColor(1, 0.82, 0.02), Text = CreateColor(1, 1, 1), Shadow = CreateColor(0.0, 0.0, 0.0, 1.0)},
}

local function TalkingHead_RePos(f)
	if not f.Style then
		TalkingHeadFrame.ignoreFramePositionManager = true
		TalkingHeadFrame: ClearAllPoints()
		TalkingHeadFrame: SetAllPoints(f)
		RemoveAnchor(TalkingHeadFrame)

		TalkingHeadFrame.NameFrame: ClearAllPoints()
		TalkingHeadFrame.NameFrame: SetAllPoints(f)
		TalkingHeadFrame.NameFrame.Name: SetPoint("TOPLEFT", TalkingHeadFrame.PortraitFrame.Portrait, "TOPRIGHT", 8, -4);

		TalkingHeadFrame.TextFrame: ClearAllPoints()
		TalkingHeadFrame.TextFrame: SetAllPoints(f)
		TalkingHeadFrame.TextFrame.Text: ClearAllPoints()
		TalkingHeadFrame.TextFrame.Text: SetPoint("TOPLEFT", TalkingHeadFrame.NameFrame.Name, "BOTTOMLEFT", 0,-3)
		TalkingHeadFrame.TextFrame.Text: SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -8,10)
		
		TalkingHeadFrame.BackgroundFrame: ClearAllPoints()
		TalkingHeadFrame.BackgroundFrame: SetAllPoints(f)
		TalkingHeadFrame.BackgroundFrame.TextBackground: Hide()
		F.HideFrame(TalkingHeadFrame.BackgroundFrame.TextBackground)
		if not TalkingHeadFrame.BackgroundFrame.TextBackgroundAlter then
			local Bg = TalkingHeadFrame.BackgroundFrame: CreateTexture(nil, "BACKGROUND")
			Bg: SetTexture(F.Path("StatusBar\\Raid"))
			Bg: SetAllPoints(f)
			Bg: SetVertexColor(F.Color(C.Color.W1, 0.8))
			TalkingHeadFrame.BackgroundFrame.TextBackgroundAlter = Bg
		end
		
		TalkingHeadFrame.PortraitFrame: SetAllPoints(f)
		TalkingHeadFrame.PortraitFrame.Portrait: SetTexture(F.Path("TalkingHead_Border"))
		TalkingHeadFrame.PortraitFrame.Portrait: ClearAllPoints()
		TalkingHeadFrame.PortraitFrame.Portrait: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 6,6)
		TalkingHeadFrame.PortraitFrame.Portrait: SetPoint("TOPRIGHT", f, "TOPLEFT", 104-20,-6)
		TalkingHeadFrame.PortraitFrame.Portrait: Hide()
		F.HideFrame(TalkingHeadFrame.PortraitFrame.Portrait)
		if not TalkingHeadFrame.PortraitFrame.Border then
			local Border = TalkingHeadFrame.PortraitFrame: CreateTexture(nil, "OVERLAY")
			Border: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 6,6)
			Border: SetPoint("TOPRIGHT", f, "TOPLEFT", 104-20,-6)
			Border: SetTexture(F.Path("TalkingHead_Border"))
			TalkingHeadFrame.PortraitFrame.Border = Border
		end
		
		TalkingHeadFrame.MainFrame: ClearAllPoints()
		TalkingHeadFrame.MainFrame: SetAllPoints(f)
		TalkingHeadFrame.MainFrame.Model: ClearAllPoints()
		TalkingHeadFrame.MainFrame.Model: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 8,8)
		TalkingHeadFrame.MainFrame.Model: SetPoint("TOPRIGHT", f, "TOPLEFT", 102-20,-8)
		TalkingHeadFrame.MainFrame.Model.PortraitBg: ClearAllPoints()
		TalkingHeadFrame.MainFrame.Model.PortraitBg: SetAllPoints(TalkingHeadFrame.MainFrame.Model)
		TalkingHeadFrame.MainFrame.Overlay: Hide()
		F.HideFrame(TalkingHeadFrame.MainFrame.Overlay)
		TalkingHeadFrame.MainFrame.CloseButton: ClearAllPoints()
		TalkingHeadFrame.MainFrame.CloseButton: SetPoint("TOPRIGHT", f, "TOPRIGHT", -2,-2)
		
		f.Style = true
	end
	local displayInfo, cameraID, vo, duration, lineNumber, numLines, name, text, isNewTalkingHead, textureKitID = C_TalkingHead.GetCurrentLineInfo();
	if ( displayInfo and displayInfo ~= 0 ) then
		local textureKit
		if ( textureKitID ~= 0 ) then
			textureKit = GetUITextureKitInfo(textureKitID);
		else
			textureKit = "Normal";
		end
		local nameColor = talkingHeadFontColor[textureKit].Name;
		local textColor = talkingHeadFontColor[textureKit].Text;
		local shadowColor = talkingHeadFontColor[textureKit].Shadow;
		TalkingHeadFrame.NameFrame.Name:SetTextColor(nameColor:GetRGB());
		TalkingHeadFrame.NameFrame.Name:SetShadowColor(shadowColor:GetRGBA());
		TalkingHeadFrame.TextFrame.Text:SetTextColor(textColor:GetRGB());
		TalkingHeadFrame.TextFrame.Text:SetShadowColor(shadowColor:GetRGBA());
	else
		TalkingHeadFrame.NameFrame.Name: SetTextColor(1, 0.82, 0.02)
		TalkingHeadFrame.NameFrame.Name: SetShadowColor(0,0,0, 1)
		TalkingHeadFrame.TextFrame.Text: SetTextColor(1,1,1)
		TalkingHeadFrame.TextFrame.Text: SetShadowColor(0,0,0, 1)
	end
end

local function TalkingHead_Frame(f)
	if F.IsClassic then return end
	f.TalkingHead = CreateFrame("Frame", nil, f)
	f.TalkingHead: SetSize(640+80, 110-20)
	f.TalkingHead: SetPoint("TOP", f, "TOP", 0,0)
	
	f.TalkingHead: RegisterEvent("TALKINGHEAD_REQUESTED")
	--f.TalkingHead: RegisterEvent("ADDON_LOADED")
	f.TalkingHead: SetScript("OnEvent", function(self, event, arg1)
		if event == "TALKINGHEAD_REQUESTED" then
			TalkingHead_RePos(f.TalkingHead)
		end
		--[[
		if event == "ADDON_LOADED" then
			if arg1 == "Blizzard_TalkingHeadUI" then
				print("Load")
				local THF = TalkingHeadFrame
				THF.ignoreFramePositionManager = true
				THF: ClearAllPoints()
				THF: SetAllPoints(f.TalkingHead)
				RemoveAnchor(THF)
			end
		end
		--]]
	end)
end

--- ------------------------------------------------------------
--> Toast
--- ------------------------------------------------------------

local function Toast_Groups(f)
	

end

local function Toast_Frame(f)
	f.Toast = CreateFrame("Frame", nil, f)
	f.Toast: SetSize(640,80)
	f.Toast: SetPoint("TOP", f, "TOP", 0,0)

end

--- ------------------------------------------------------------
--> Notification
--- ------------------------------------------------------------


local Notification = CreateFrame("Frame", "Quafe_Notification", E)
Notification: SetSize(640,80)
Notification: SetPoint("TOP", UIParent, "TOP", 0,-4)
function Notification.Load()
	TalkingHead_Frame(Notification)
end
insert(E.Module, Notification)
