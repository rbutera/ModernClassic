local ZGV=ZygorGuidesViewer
if not ZGV then return end

ZGV.QuestDB = {}
local QuestDB = ZGV.QuestDB

local L = ZGV.L
local RaceClassMatch = ZGV.RaceClassMatch

ZGV.Quest_Guide_Cache = {}

function ZGV.QuestDB:Init()
	-- move quests from faction array to common
	if UnitFactionGroup("player")=="Alliance" then 
		ZGV.Quest_Cache = ZGV.Quest_Cache_Alliance
		ZGV.Quest_Cache_Horde = nil
	elseif UnitFactionGroup("player")=="Horde" then 
		ZGV.Quest_Cache = ZGV.Quest_Cache_Horde		
		ZGV.Quest_Cache_Alliance = nil
	else
		ZGV.Quest_Cache = {}
		ZGV.Quest_Cache_Horde = nil
		ZGV.Quest_Cache_Alliance = nil
	end
	
	-- clear blocks that cannot be reached, set valid functions where needed
	for gname,guidequests in pairs(ZGV.Quest_Cache) do
		for index,questdata in pairs(guidequests) do if type(questdata)=="table" then
			local wipe = false
			-- only conditions cannot change during single gameplay session, so depending on RCM result either unset the condition (if RCM is valid), or remove whole quest pack (if invalid)
			if questdata.cond then 
				if RaceClassMatch(_,questdata.cond) then
					questdata.cond = nil
				else
					guidequests[index] = nil
				end
			end

			-- only if conditions result on the other hand can change at any time, so create them from string, set enviroment, and leave it to be queried properly
			if questdata.cond_if then 
				questdata.cond_if_raw = questdata.cond_if
				questdata.cond_if = ZGV.Parser.MakeCondition(questdata.cond_if_raw)
				setfenv(questdata.cond_if,ZGV.Parser.ConditionEnv)
			end
		end end
	end
	
end

function ZGV.QuestDB:GetGuidesForQuest(id)
	if not id then return false end
	if not ZGV.Quest_Cache then return false end

	if ZGV.Quest_Guide_Cache[id] then 
		return ZGV.Quest_Guide_Cache[id][1],ZGV.Quest_Guide_Cache[id][2]
	else
		ZGV.Quest_Guide_Cache[id] = {false,{}}
	end

	local results = ZGV.Quest_Guide_Cache[id][2]

	id = tostring(id) -- switch to string, since questpacks we are matching against here are strings
	for guideTitle,guide in pairs(ZGV.Quest_Cache) do
		for j,questpack in pairs(guide) do
			if questpack.ids:match(id) then
				for quest in questpack.ids:gmatch('([^,]+)') do
					if quest==id then
						results[guideTitle]=true
					end
				end
			end
		end
	end

	id = tonumber(id)
	local find_action = "accept" -- find accept step, assuming the quest is not completed
	if IsQuestFlaggedCompleted(id) then find_action = "turnin" end -- if it is, route to turnin step and pause
		
	for guideTitle,v in pairs(results) do
		local guide = ZGV:GetGuideByTitle(guideTitle)
		if guide then
			guide:Parse(true)
			local guide_checked = false
			for stepNum,step in pairs(guide.steps) do
				for _,goal in pairs(step.goals) do
					if goal.action==find_action and goal.questid==id then
						results[guideTitle]=stepNum
						guide_checked = true
						break
					end
					if guide_checked then break end
				end
				if guide_checked then break end
			end
		else
			results[guideTitle] = nil
		end
	end

	if next(results) then
		ZGV.Quest_Guide_Cache[id][1] = true
		return true, results
	else
		ZGV.Quest_Guide_Cache[id][1] = false
		return false, results
	end
end

hooksecurefunc("QuestLog_SetSelection",function(questIndex) ZGV.QuestDB:SetQuestForButton(questIndex) end) -- CLASSIC FIX modified

function ZGV.QuestDB:CreateButton()
	local iconFrame = CreateFrame("Button", "ZygorQuestFinder", QuestLogFrame)
	iconFrame:SetSize(24,24)
	iconFrame:SetPoint("TOPRIGHT",QuestLogFrame,"TOPRIGHT",-70,-180)
	iconFrame:SetScript("OnLeave",function() GameTooltip:Hide() end)
	iconFrame:SetScript("OnClick", function(...) ZGV.QuestDB:SuggestGuidesForQuest(ZGV.QuestDB.questID) end)
	iconFrame:SetScript("OnEnter",function(self)
		GameTooltip:ClearAllPoints()
		GameTooltip:ClearLines()
		GameTooltip:SetOwner(self,"ANCHOR_TOPLEFT")
		GameTooltip:AddLine(L['questframe_button']:format(ZGV.QuestDB.questName))
		GameTooltip:Show()
	end)

	iconFrame.tex=iconFrame:CreateTexture("ZygorQuestFinderTexture","OVERLAY")
	iconFrame.tex:SetAllPoints(true)
	iconFrame.tex:SetTexture(ZGV.DIR.."\\Skins\\findinzygor")
	--iconFrame.tex:SetTexCoord(0,0,0,1/2 , 1,0,1,1/2)

	iconFrame:Hide()

	ZGV.QuestDB.SearchIcon = iconFrame
end

function ZGV.QuestDB:SetQuestForButton(questIndex)
	local questLogTitleText, _, _, _, _, _, _, questID, _ = GetQuestLogTitle(questIndex);
	if not ZGV.Quest_Cache then return false end

	local status,results = ZGV.QuestDB:GetGuidesForQuest(questID)
	if ZGV.QuestDB:GetGuidesForQuest(questID) then
		ZGV.QuestDB.questID = questID
		ZGV.QuestDB.questName = questLogTitleText
		ZGV.QuestDB.SearchIcon:Show()
	else
		ZGV.QuestDB.SearchIcon:Hide()
	end

end

function ZGV.QuestDB:MaybeShowButton()
	if not ZGV.CurrentGuide then 
		ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
		return 
	end

	if not ZGV.CurrentGuide.QuestSearchID then 
		ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
		return 
	end
	
	if ZGV.CurrentStep:IsComplete() then
		ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
		return 
	end
		
	local show_button = true
	for i,goal in pairs(ZGV.CurrentStep.goals) do
		if goal.questid==ZGV.CurrentGuide.QuestSearchID then
			ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()
			if goal.action=="turnin" then 
				ZGV.CurrentGuide.QuestSearchID = nil 
				end -- stop tracking once we display turnin step for this quest
			return
		end
	end

	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Show()
	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial.Blink:Stop();
	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial.Blink:Play();
end

function ZGV.QuestDB:MaybeStopOnThisStep()
	if not ZGV.CurrentGuide then return false end
	if not ZGV.CurrentGuide.QuestSearchID then return false end
	
	local show_button = true
	for i,goal in pairs(ZGV.CurrentStep.goals) do
		if goal.questid==ZGV.CurrentGuide.QuestSearchID and goal.action=="turnin" then
			return true
		end
	end
	return false
end


function ZGV.QuestDB:SuggestGuidesForQuest(questID)
	ZGV.GuideMenu:Show("QuestSearch",tonumber(questID))
end

function ZGV.QuestDB:FocusNextStepForQuest()
	if not ZGV.CurrentGuide then return false end
	if not ZGV.CurrentGuide.QuestSearchID then return false end

	local questID = ZGV.CurrentGuide.QuestSearchID
	
	for i,step in ipairs(ZGV.CurrentGuide.steps) do
		if i>ZGV.CurrentStepNum then
			for j,goal in pairs(step.goals) do
				if goal.questid==questID then
					ZGV:FocusStep(i,true)
					return true
				end
			end
		end
	end

	return false
end

tinsert(ZGV.startups,{"Quest DB",function(self)
	ZGV.QuestDB:Init()
	ZGV.QuestDB:CreateButton()
end})