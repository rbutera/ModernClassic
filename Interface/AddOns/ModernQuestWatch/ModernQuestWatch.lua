local NAME, S = ...
local L = S.L

ModernQuestWatch = CreateFrame("Frame")
local MQW = ModernQuestWatch
local AnchorFrame = CreateFrame("Frame")
local ClickFrames = {}
local db

local defaults = {
	db_version = 2,
	point = {"TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", 0, 0},
}

hooksecurefunc("QuestWatch_Update", function()
	local watchTextIndex = 1
	for i = 1, GetNumQuestWatches() do
		local questIndex = GetQuestIndexForWatch(i)
		if questIndex then
			local numObjectives = GetNumQuestLeaderBoards(questIndex)
			if numObjectives > 0 then
				local headerText = _G["QuestWatchLine"..watchTextIndex]
				watchTextIndex = watchTextIndex + 1
				local objectivesGroup = {}
				local objectivesCompleted = 0

				for j = 1, numObjectives do
					local finished = select(3, GetQuestLogLeaderBoard(j, questIndex))
					if finished then
						objectivesCompleted = objectivesCompleted + 1
					end
					tinsert(objectivesGroup, _G["QuestWatchLine"..watchTextIndex])
					watchTextIndex = watchTextIndex + 1
				end
				MQW:SetClickFrame(i, questIndex, headerText, objectivesGroup, objectivesCompleted == numObjectives)
			end
		end
	end
	-- hide/show frames so it doesnt eat clicks, since we cant parent to a FontString
	for _, frame in pairs(ClickFrames) do
		frame[GetQuestIndexForWatch(frame.watchIndex) and "Show" or "Hide"](frame)
	end
end)

local function OnMouseUp(self)
	if IsShiftKeyDown() then -- untrack quest
		local questID = GetQuestIDFromLogIndex(self.questIndex)
		for index, value in ipairs(QUEST_WATCH_LIST) do
			if value.id == questID then
				tremove(QUEST_WATCH_LIST, index)
			end
		end
		RemoveQuestWatch(self.questIndex)
		QuestWatch_Update()
	else -- open to quest log
		if QuestLogEx then -- https://www.wowinterface.com/downloads/info24980-QuestLogEx.html
			ShowUIPanel(QuestLogExFrame)
			QuestLogEx:QuestLog_SetSelection(self.questIndex)
			QuestLogEx:Maximize()
		elseif ClassicQuestLog then -- https://www.wowinterface.com/downloads/info24937-ClassicQuestLogforClassic.html
			ShowUIPanel(ClassicQuestLog)
			QuestLog_SetSelection(self.questIndex)
		else
			ShowUIPanel(QuestLogFrame)
			QuestLog_SetSelection(self.questIndex)
			local valueStep = QuestLogListScrollFrame.ScrollBar:GetValueStep()
			QuestLogListScrollFrame.ScrollBar:SetValue(self.questIndex*valueStep/2)
		end
	end
	QuestLog_Update()
end

local function OnEnter(self)
	if self.completed then
		-- use normal colors instead as highlight
		self.headerText:SetTextColor(.75, .61, 0)
		for _, text in ipairs(self.objectiveTexts) do
			text:SetTextColor(.8, .8, .8)
		end
	else
		self.headerText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b) -- 1, .82, 0
		for _, text in ipairs(self.objectiveTexts) do
			text:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b) -- 1, 1, 1
		end
	end
end

function MQW:SetClickFrame(watchIndex, questIndex, headerText, objectiveTexts, completed)
	if not ClickFrames[watchIndex] then
		ClickFrames[watchIndex] = CreateFrame("Frame")
		ClickFrames[watchIndex]:SetScript("OnMouseUp", OnMouseUp)
		ClickFrames[watchIndex]:SetScript("OnEnter", OnEnter)
		ClickFrames[watchIndex]:SetScript("OnLeave", QuestWatch_Update)
	end
	local f = ClickFrames[watchIndex]
	f:SetAllPoints(headerText)
	f.watchIndex = watchIndex
	f.questIndex = questIndex
	f.headerText = headerText
	f.objectiveTexts = objectiveTexts
	f.completed = completed
end

function MQW:Initialize()
	AnchorFrame:SetSize(1, 1)
	QuestWatchFrame:SetMovable(true)
	QuestWatchFrame:SetClampedToScreen(true)
	QuestWatchFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background"})
	QuestWatchFrame:SetBackdropColor(0, 0, 0, 0)
	QuestWatchFrame:RegisterForDrag("LeftButton")
	QuestWatchFrame:SetScript("OnDragStart", QuestWatchFrame.StartMoving)
	QuestWatchFrame:SetScript("OnDragStop", function(frame)
		frame:StopMovingOrSizing()
		frame:SetUserPlaced(false) -- we dont want it to be a character-specific UIParent managed frame
		local effectiveScale = UIParent:GetEffectiveScale()
		local right = frame:GetRight() * effectiveScale
		local top = frame:GetTop() * effectiveScale
		db.point = {"TOPRIGHT", "UIParent", "BOTTOMLEFT", right, top}
	end)

	-- block FramePositionDelegate.UIParentManageFramePositions from moving this on every OnAttributeChanged
	local oldSetPoint = QuestWatchFrame.SetPoint
	QuestWatchFrame.SetPoint = function(frame, point, relativeTo, relativePoint, x, y, override)
		if override then
			oldSetPoint(frame, point, relativeTo, relativePoint, x, y)
		end
	end
end

function MQW:ADDON_LOADED(addon)
	if addon == NAME then
		if not ModernQuestWatchDB or ModernQuestWatchDB.db_version < defaults.db_version then
			ModernQuestWatchDB = CopyTable(defaults)
		end
		db = ModernQuestWatchDB
		self:Initialize()
		self:SetPosition(unpack(db.point))
		self:UnregisterEvent("ADDON_LOADED")
	end
end

-- only auto track quests when autoQuestWatch is enabled
-- in Classic this cvar would only track quests for 5 minutes when an objective is updated
function MQW:QUEST_ACCEPTED(questIndex)
	-- tracking otherwise untrackable quests (without any objectives) would still count against the watch limit
	-- calling AddQuestWatch() while on the max watch limit silently fails
	if GetCVarBool("autoQuestWatch") and GetNumQuestLeaderBoards(questIndex) ~= 0 and GetNumQuestWatches() < MAX_WATCHABLE_QUESTS then
		AutoQuestWatch_Insert(questIndex, QUEST_WATCH_NO_EXPIRE)
	end
end

-- only make the frame movable when mouseovering and pressing alt
function MQW:MODIFIER_STATE_CHANGED()
	if QuestWatchFrame:IsMouseOver() then
		if IsAltKeyDown() then -- easier than checking for event payload imo
			QuestWatchFrame:EnableMouse(true)
			QuestWatchFrame:SetBackdropColor(0, 1, 0, .5)
		else
			QuestWatchFrame:EnableMouse(false)
			QuestWatchFrame:SetBackdropColor(0, 0, 0, 0)
			-- avoid getting stuck to the cursor when alt is released while dragging
			QuestWatchFrame:StopMovingOrSizing()
		end
	else
		if QuestWatchFrame:IsMouseEnabled() then
			-- avoid leaving the backdrop enabled when alt is still pressed but not mouseovering
			QuestWatchFrame:EnableMouse(false)
			QuestWatchFrame:SetBackdropColor(0, 0, 0, 0)
		end
	end
end

-- use a separate anchor frame to make it expand down/leftwards only
function MQW:SetPosition(point, relativeTo, relativePoint, x, y)
	AnchorFrame:ClearAllPoints()
	AnchorFrame:SetPoint(point, relativeTo, relativePoint, x, y)
	QuestWatchFrame:ClearAllPoints()
	QuestWatchFrame:SetPoint("TOPRIGHT", AnchorFrame, "TOPRIGHT", 0, 0, true)
end

function MQW:PrintMessage(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage("Modern QuestWatch: "..msg, r, g, b)
end

function MQW:OnEvent(event, ...)
	self[event](self, ...)
end

MQW:RegisterEvent("ADDON_LOADED")
MQW:RegisterEvent("QUEST_ACCEPTED")
MQW:RegisterEvent("MODIFIER_STATE_CHANGED")
MQW:SetScript("OnEvent", MQW.OnEvent)

for i, v in pairs({"mqw", "modernquestwatch"}) do
	_G["SLASH_MODERNQUESTWATCH"..i] = "/"..v
end

function SlashCmdList.MODERNQUESTWATCH(msg)
	if msg == "reset" then
		ModernQuestWatchDB = CopyTable(defaults)
		db = ModernQuestWatchDB
		MQW:SetPosition(unpack(db.point))
		MQW:PrintMessage(L.RESET, 1, 1, 0)
	else
		MQW:PrintMessage(L.UNTRACK_USAGE)
		MQW:PrintMessage(L.MOVE_USAGE)
		MQW:PrintMessage("|cffFFFF00/mqw reset|r - "..RESET_TO_DEFAULT)
	end
end
