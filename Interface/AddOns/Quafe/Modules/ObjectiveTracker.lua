local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local asin = math.asin
local cos = math.cos
local acos = math.acos
local atan = math.atan
local rad = math.rad
local modf = math.modf

local insert = table.insert

if F.IsClassic then return end
--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------

local function ObjectiveTracker_Frame(frame)
	frame.Blocks = ObjectiveTrackerBlocksFrame
	frame.Blocks: SetParent(frame)
	frame.Blocks: ClearAllPoints()
	frame.Blocks: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
	frame.Blocks: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,0)
	
	--> Hook
	local function hook_ObjectiveTracker_Update(reason, id)
		if ObjectiveTrackerFrame.MODULES then
			for i = 1, #ObjectiveTrackerFrame.MODULES do
				ObjectiveTrackerFrame.MODULES[i].Header.Background: SetAtlas(nil)
				ObjectiveTrackerFrame.MODULES[i].Header.Text: SetFont(STANDARD_TEXT_FONT, 14, nil)
				ObjectiveTrackerFrame.MODULES[i].Header.Text: SetShadowColor(0, 0, 0, 1)
				ObjectiveTrackerFrame.MODULES[i].Header.Text: SetShadowOffset(1, 1)
			end
			local numEntries, numQuests = GetNumQuestLogEntries()
			ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(TRACKER_HEADER_QUESTS.."  "..numQuests.."/"..MAX_QUESTS)
		end
	end
	hooksecurefunc("ObjectiveTracker_Update", hook_ObjectiveTracker_Update)
	
	local function hook_SetBlockHeader(self, block, text, questLogIndex, isQuestComplete)
		block.HeaderText: SetFont(STANDARD_TEXT_FONT, 14, nil)
		block.HeaderText: SetShadowColor(0, 0, 0, 1)
		block.HeaderText: SetShadowOffset(1, 1)
	end
	hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", hook_SetBlockHeader)
	
	local function hook_AddObjective(self, block, objectiveKey, textOrTextFunc, lineType, useFullHeight, dashStyle, colorStyle)
		local line = self:GetLine(block, objectiveKey, lineType)
		line.Text: SetFont(STANDARD_TEXT_FONT, 14, nil)
		line.Text: SetShadowColor(0, 0, 0, 1)
		line.Text: SetShadowOffset(1, 1)
	end
	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", hook_AddObjective)
	
	--> Hide
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton: SetScript("OnClick", nil)
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton: Hide()
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton: ClearAllPoints()
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton: SetParent(nil)
	
	if ( ObjectiveTrackerFrame.collapsed ) then
		ObjectiveTracker_Expand()
	end
	
	ObjectiveTrackerFrame.HeaderMenu.Title:SetText("")
end

----------------------------------------------------------------
--> Load
----------------------------------------------------------------

local Quafe_ObjectiveTracker = CreateFrame("Frame", "Quafe_ObjectiveTracker", E)
Quafe_ObjectiveTracker: SetSize(222, 540)
Quafe_ObjectiveTracker.Init = false
Quafe_ObjectiveTracker: Hide()

local function Joystick_Update(self, elapsed)
	local x2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.PosX
	local y2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.PosY
	local x0,y0 = Quafe_ObjectiveTracker: GetCenter()
	local x1,y1 = self: GetCenter()
	local step = floor(1/(GetFramerate())*1e3)/1e3
	if x0 ~= x1 then
		x2 = x2 + (x1-x0)*step/2
	end
	if y0 ~= y1 then
		y2 = y2 + (y1-y0)*step/2
	end
	Quafe_ObjectiveTracker: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT",x2, y2)
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.PosX = x2
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.PosY = y2
end

local function ObjectiveTracker_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.Enable then
		Quafe_ObjectiveTracker: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.PosX, Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.PosY)
		F.CreateJoystick(Quafe_ObjectiveTracker, 260,540, "Quafe_ObjectiveTracker")
		Quafe_ObjectiveTracker.Joystick.postUpdate = Joystick_Update
		
		Quafe_ObjectiveTracker: Show()
		ObjectiveTracker_Frame(Quafe_ObjectiveTracker)
		Quafe_ObjectiveTracker.Init = true
	end
end

local function Quafe_ObjectiveTracker_Toggle(arg)
	if arg == "ON" then
		if not Quafe_ObjectiveTracker.Init then
			ObjectiveTracker_Load()
		end
		Quafe_ObjectiveTracker: Show()
		Quafe_ObjectiveTracker.Mover: Show()
	elseif arg == "OFF" then
		Quafe_ObjectiveTracker: Hide()
		Quafe_ObjectiveTracker.Mover: Hide()
		Quafe_Config.NoticeReload()
	end
end

local Quafe_ObjectiveTracker_Config = {
	Database = {
		Quafe_ObjectiveTracker = {
			Enable = true,
			PosX = -100,
			PosY = -180,
		},
	},
	Config = {
		Name = "Quafe "..L['OBJECTIVE_TRACKER'],
		Type = "Switch",
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.Enable = false
				self.Text:SetText(L["OFF"])
				Quafe_ObjectiveTracker_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.Enable = true
				self.Text:SetText(L["ON"])
				Quafe_ObjectiveTracker_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ObjectiveTracker.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = nil,
	},
}

Quafe_ObjectiveTracker.Load = ObjectiveTracker_Load
Quafe_ObjectiveTracker.Config = Quafe_ObjectiveTracker_Config
insert(E.Module, Quafe_ObjectiveTracker)
