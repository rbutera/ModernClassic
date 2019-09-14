do return end

local ZGV = ZygorGuidesViewer
if not (ZGV and ZGV.ItemScore) then return end

local L = ZGV.L
local G = _G
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local CHAIN = ZGV.ChainCall
local ui = ZGV.UI
local SkinData = ui.SkinData

local tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop=tinsert,tremove,print,ipairs,pairs,wipe,debugprofilestop

local ItemScore = ZGV.ItemScore
local GearFinder = {}
ItemScore.GearFinder = GearFinder

local PAST_DUNGEONS_LIMIT = 1 -- how many levels can user be above previous expansion cap before we start ignoring its dungeon
local FUTURE_DUNGEONS_LIMIT = 5 -- how many levels to look ahead for future upgrades


function GearFinder:Initialise()
	GearFinder:TrimDatabase()
	GearFinder:CreateMainFrame()
	CharacterFrame:HookScript("OnShow", function() GearFinder:CreateSystemTab() end)
	CharacterFrame:HookScript("OnHide", function() GearFinder:RestoreBlizzardFrame() end)
end

-- remove all non-player class drops, and all bosses that do not drop anything for player
function GearFinder:TrimDatabase() 
	local player = ZGV.ItemScore.playerclass

	for i,instance in pairs(ZygorGuidesViewer.ItemScore.Items) do
		for bossindex,boss in pairs(instance) do
			if type(boss)=="table" then
				for classindex,class in pairs(boss) do
					if type(class)=="table" then -- strip non quest drops for classes other than current
						if classindex~=player and classindex~="quest" then
							boss[classindex]=nil
						end
					end
				end
				if not boss[player] or #boss[player]==0 then -- strip bosses that do not offer anything to current class
					instance[bossindex]=nil
				end
			end
		end
	end
end

-- checks if gear from specific dungeon can be suggested
--	dungeon - int - dungeon id, as used in ZGV.Dungeons
--	instance - int - dungeon id, as used in ZGV.Dungeons
-- returns:
--	valid - bool - can be suggested now
--	future - bool - may contains upgrades later (level, ilvl, attunment)
--	ident - string or int - identificator of dungeon
--	maxscale - int - maximum level up to which drops are scaled
--	mythic - bool - is this a mythic dungeon
--	comment - string - verbose message
function GearFinder:IsValidDungeon(dungeon, instanceId)
	local ident = dungeon
	if ident==0 then ident="e_"..instanceId end

	local dungeon = ZGV.Dungeons[ident]

	if not dungeon then return false, false, ident, 0, false, "no dungeon" end

	-- handle permanent rejects
	if dungeon.expansionLevel>GetExpansionLevel() then return false, false, ident, 0, false, "no expansion" end
	if dungeon.difficulty and not ZGV.db.profile["gear_"..dungeon.difficulty] then return false, false, ident, 0, false, "instance filtered out" end
	if dungeon.isHoliday then return false, false, ident, 0, false, "holiday dungeons not supported" end
	if dungeon.minLevel and dungeon.minLevel > (ItemScore.playerlevel+FUTURE_DUNGEONS_LIMIT) then return false, false, ident, 0, false, "need way higher level" end
	if dungeon.maxScaleLevel < (ItemScore.playerlevel-PAST_DUNGEONS_LIMIT) then return false, false, ident, 0, false, "outleveled" end

	local mythic = dungeon.difficulty==23 and dungeon.maxScaleLevel == MAX_PLAYER_LEVEL_TABLE[GetAccountExpansionLevel()]

	-- handle future rejects
	if dungeon.minLevel and dungeon.minLevel > ItemScore.playerlevel then return false, true, ident, dungeon.maxScaleLevel, mythic, "need higher level" end

	-- attunements
	if dungeon.attunement_achieve then
		local _,_,_,complete = GetAchievementInfo(dungeon.attunement_achieve)
		if not complete then return false, true, ident, dungeon.maxScaleLevel, mythic, "attunement needed" end
	end	
	if dungeon.attunement_quest and not IsQuestFlaggedCompleted(dungeon.attunement_quest) then return false, true, ident, dungeon.maxScaleLevel, mythic, "attunement needed" end
	if dungeon.attunement_queston and not (IsQuestFlaggedCompleted(dungeon.attunement_queston) or ZGV.Parser.ConditionEnv.havequest(dungeon.attunement_queston)) then return false, true, ident, dungeon.maxScaleLevel, mythic, "attunement needed" end

	return true, true, ident, dungeon.maxScaleLevel, mythic, "ok"
end

GearFinder.UpgradeQueue = {
	[INVSLOT_MAINHAND] = {},
	[INVSLOT_OFFHAND] = {},
	[INVSLOT_HEAD] = {},
	[INVSLOT_NECK] = {},
	[INVSLOT_SHOULDER] = {},
	[INVSLOT_BACK] = {},
	[INVSLOT_CHEST] = {},
	[INVSLOT_WRIST] = {},
	[INVSLOT_HAND] = {},
	[INVSLOT_WAIST] = {},
	[INVSLOT_LEGS] = {},
	[INVSLOT_FEET] = {},
	[INVSLOT_FINGER1] = {},
	[INVSLOT_FINGER2] = {},
	[INVSLOT_TRINKET1] = {},
	[INVSLOT_TRINKET2] = {},
}

-- those slots should not have the same item suggested
local slot_pairs = {
	[INVSLOT_MAINHAND] = INVSLOT_OFFHAND,
	[INVSLOT_FINGER1] = INVSLOT_FINGER2,
	[INVSLOT_TRINKET1] = INVSLOT_TRINKET2,
}

-- checks if gearfounder got upgrades for all slots, so that we may skip looking for future upgrades
-- no params
-- returns
--	bool - are all slots filled
local function are_all_slots_filled()
	for slot,data in pairs(GearFinder.UpgradeQueue) do
		if not next(data) then
			return false
		end
	end
	return true
end

-- checks if item should be considered for weapon upgrade - don't switch between 2h and 1h when looking in dungeons
-- params:
--	current - bool - if user is using 2h weapon now
--	item - array - item that we will be checking
-- returns
--	valid - bool - should we queue this item
local function is_replacement(uses2h, item)
	if not item then return false end

	if (item.class == LE_ITEM_CLASS_WEAPON) or (item.type=="INVTYPE_HOLDABLE" or item.type=="INVTYPE_SHIELD") then
		return item.twohander == uses2h
	end

	return true
end

-- main worker function. goes first through all items prepared for scoring, if upgrades for all slots are not found, checks future items
-- sorts result slots by highest score and calls display when it is done
-- no params, no returns
local function loot_score_dungeon_thread()
	local total_current, total_future = 0,0
	for _,dungeon in pairs(GearFinder.ItemsToScore) do total_current = total_current + #dungeon end
	for _,dungeon in pairs(GearFinder.ItemsToMaybeScore) do total_future = total_future + #dungeon end
	local total = total_current + total_future

	GearFinder.MainFrame.Progress:SetPercent(0,"noanim")
	GearFinder.MainFrame.Progress:Show()
	local success_counter = 0


	local equipped_weapon = GetInventoryItemLink("player",INVSLOT_MAINHAND) and ItemScore:GetItemDetails(GetInventoryItemLink("player",INVSLOT_MAINHAND))
	local twohander_equipped = equipped_weapon and equipped_weapon.twohander

	while true do
		local fail_counter = 0
		for ident,dungeon in pairs(GearFinder.ItemsToScore) do
			for index,itemdata in pairs(dungeon) do
				local itemlink = itemdata.itemlink
				local item = ItemScore:GetItemDetails(itemlink)
				if not item then
					fail_counter = fail_counter + 1
				else
					success_counter = success_counter + 1
					local is_upgrade, slot, change, score, comment, slot_2, change_2  = ItemScore.Upgrades:IsUpgrade(itemlink)
					if is_upgrade and is_replacement(twohander_equipped,item)  then
						item.ident = ident
						item.boss = itemdata.boss
						item.encounterId = itemdata.encounterId
						item.quest = itemdata.quest
						if not (item.quest and IsQuestFlaggedCompleted(item.quest)) then
							table.insert(GearFinder.UpgradeQueue[slot],item)

							if slot_2 then table.insert(GearFinder.UpgradeQueue[slot_2],item) end
						end
					end
					GearFinder.ItemsToScore[ident][index]=nil
				end
			end
			ZGV:Debug("&gear current scored %d of %d/%d",success_counter,total_current,total)
			ZGV:Debug("&gear current failed %d",fail_counter)
			coroutine.yield()
			ready = success_counter / total * 100
			GearFinder.MainFrame.Progress:SetPercent(ready)
		end
		if fail_counter==0 then break end
	end

	GearFinder.DungeonItemsScored = true
	local t2 = debugprofilestop()
	ZGV:Debug("&gear scoring current took %d",t2-GearFinder.TimeScoreStart)

	for i,slotupgrades in pairs(GearFinder.UpgradeQueue) do 
		table.sort(slotupgrades,function(a,b) return a.score>b.score end)
	end

	-- remove duplicates from primary/secondary slots
	for first,second in pairs(slot_pairs) do
		local first_equipped = ItemScore:GetItemDetails(ItemScore.Upgrades.EquippedItems[first].itemlink)
		local second_equipped = ItemScore:GetItemDetails(ItemScore.Upgrades.EquippedItems[second].itemlink)
		local first_queue = GearFinder.UpgradeQueue[first]
		local second_queue = GearFinder.UpgradeQueue[second]

		if first_queue[1] and second_queue[1] and first_queue[1]==second_queue[1] then
			if not first_equipped or twohand then
				ZGV:Debug("&itemscore SDG same item, drop second, no first")
				table.remove(second_queue,1)
			elseif not first_equipped then		
				ZGV:Debug("&itemscore SDG same item, drop first, no second")
				table.remove(first_queue,1)
			elseif second_queue[2] then
				ZGV:Debug("&itemscore SDG same item, drop second, has options")
				table.remove(second_queue,1)
			elseif first_queue[2] then
				ZGV:Debug("&itemscore SDG same item, drop first, has options")
				table.remove(first_queue,1)
			else
				ZGV:Debug("&itemscore SDG same item, drop second, no choice")
				table.remove(second_queue,1)
			end
		end
	end

	if are_all_slots_filled() then 
		GearFinder.ResultsReady=true 
		GearFinder.MainFrame.Progress:Hide()
		ZGV:CancelTimer(GearFinder.AntsTimer) 
		GearFinder:DisplayResults()
		return
	else
		GearFinder:DisplayResults()
		GearFinder.AntsMode = "future "
	end

	table.sort(GearFinder.FutureDungeons,function(a,b) if a.minLevel==b.minLevel then return a.min_ilevel<b.min_ilevel else return a.minLevel<b.minLevel end end)
	while true do
		local fail_counter = 0
		for _,dungeon in ipairs(GearFinder.FutureDungeons) do
			for index,itemdata in pairs(GearFinder.ItemsToMaybeScore[dungeon.ident]) do
				local itemlink = itemdata.itemlink
				local item = ItemScore:GetItemDetails(itemlink)
				if not item then 
					fail_counter = fail_counter + 1
				else
					success_counter = success_counter + 1
					local is_upgrade, slot, change, score, comment, slot_2, change_2 = ItemScore.Upgrades:IsUpgrade(itemlink,"future")
					-- only record future items for slots that do not have upgrades from current dungeons
					if slot and not GearFinder.UpgradeQueue[slot][1] then
						if is_upgrade and is_replacement(twohander_equipped,item) then
							item.ident = dungeon.ident
							item.boss = itemdata.boss
							item.encounterId = itemdata.encounterId
							item.future = true
							item.quest = itemdata.quest
							if not (item.quest and IsQuestFlaggedCompleted(item.quest)) then
								table.insert(GearFinder.UpgradeQueue[slot],item)

								if slot_2 then table.insert(GearFinder.UpgradeQueue[slot_2],item) end
							end
						end
					end
					GearFinder.ItemsToMaybeScore[dungeon.ident][index]=nil
				end
			end
			ready = success_counter / total * 100
			ZGV:Debug("&gear future scored %d of %d/%d",success_counter,total_future,total)
			ZGV:Debug("&gear future failed %d",fail_counter)
			GearFinder.MainFrame.Progress:SetPercent(ready)
			coroutine.yield()
		end
		if fail_counter==0 then break end
	end

	for i,slotupgrades in pairs(GearFinder.UpgradeQueue) do 
		table.sort(slotupgrades,function(a,b) return a.score>b.score end)
	end

	local t3 = debugprofilestop()
	ZGV:Debug("&gear scoring future took %d",t3-t2)
	ZGV:Debug("&gear scoring all took %d",t3-GearFinder.TimeScoreStart)
	GearFinder.ResultsReady=true
	GearFinder.MainFrame.Progress:Hide()

	ZGV:CancelTimer(GearFinder.AntsTimer) 
	GearFinder.AntsTimer = nil
	GearFinder:DisplayResults()
end

-- show crawling dots while calculation is running
-- executed on timer
-- no params
-- no returns
local function progress_dots()
	local progress_time = math.floor(debugprofilestop())%1500

	local progress_dots = ""
	if progress_time < 500 then
		progress_dots = "."
	elseif progress_time < 1000 then
		progress_dots = ".."
	else
		progress_dots = "..."
	end

	local Buttons = GearFinder.MainFrame.Buttons
	for i,v in pairs(GearFinder.UpgradeQueue) do
		local button = Buttons[i]
		if not button.link then
			button.itemdungeon:SetText("Searching for "..GearFinder.AntsMode.. "upgrades"..progress_dots)
		end
	end
end

-- prepares item lists for worker thread to work on
-- items from valid dungeons are added to ItemsToScore
-- items from dungeons that are not valid, but can be valid soon to ItemsToMaybeScore and dungeons to FutureDungeons
-- starts thread and resumes it 10 times a second
-- no params
-- no returns
GearFinder.ItemsToScore = {}
GearFinder.ItemsToMaybeScore = {}
GearFinder.FutureDungeons = {}
function GearFinder:ScoreDungeonItems()
	if GearFinder.ResultsReady then return end

	GearFinder.TimeScoreStart = debugprofilestop()
	GearFinder.MainFrame.overlay:Hide()

	GearFinder.DungeonItemsScored = false

	local player = ZGV.ItemScore.playerclass
	for i,v in pairs(GearFinder.UpgradeQueue) do table.wipe(v) end
	table.wipe(GearFinder.ItemsToScore)
	table.wipe(GearFinder.ItemsToMaybeScore)
	table.wipe(GearFinder.FutureDungeons)

	local faction = self.playerfaction=="Alliance" and 1 or 2

	for dungeon,dungeondata in pairs(ZygorGuidesViewer.ItemScore.Items) do
		local valid, future, ident, maxscale, mythic, comment = GearFinder:IsValidDungeon(dungeondata.dungeon, dungeondata.instanceId)
		local capped_player_level = math.min(maxscale, ItemScore.playerlevel)

		if valid then
			GearFinder.ItemsToScore[ident] = {}
			for boss,bossdata in pairs(dungeondata) do
				if type(bossdata)=="table" then
					for _,itemlink in pairs(bossdata[player]) do
						if type(itemlink)=="number" then itemlink = "item:"..itemlink end
						itemlink = ZGV.ItemLink.SetLevel(itemlink,capped_player_level,false)
						local qname if bossdata.quest and bossdata.quest[faction] then qname=C_QuestLog.GetQuestInfo(bossdata.quest[faction]) end -- prefetch quest name
						table.insert(GearFinder.ItemsToScore[ident],{itemlink=itemlink,boss=bossdata.boss, encounterId=bossdata.encounterId, quest=bossdata.quest and bossdata.quest[faction], questname=qname})
					end
				end
			end
		elseif future then
			GearFinder.ItemsToMaybeScore[ident] = {}

			-- fill table with future dungeons, so we can sort it by minlevel,ilvl requirements later
			local dungeon = ZGV.Dungeons[ident] 
			table.insert(GearFinder.FutureDungeons,{ident=ident,minLevel=dungeon.minLevel or 0,min_ilevel=dungeon.min_ilevel or 0})

			for boss,bossdata in pairs(dungeondata) do
				if type(bossdata)=="table" then
					for _,itemlink in pairs(bossdata[player]) do
						if type(itemlink)=="number" then itemlink = "item:"..itemlink end
						itemlink = ZGV.ItemLink.SetLevel(itemlink,capped_player_level,false)
						local qname if bossdata.quest and bossdata.quest[faction] then qname=C_QuestLog.GetQuestInfo(bossdata.quest[faction]) end -- prefetch quest name
						table.insert(GearFinder.ItemsToMaybeScore[ident],{itemlink=itemlink,boss=bossdata.boss, encounterId=bossdata.encounterId, quest=bossdata.quest and bossdata.quest[faction], questname=qname})
					end
				end
			end
		end
	end

	GearFinder.ScoreThread = coroutine.create(loot_score_dungeon_thread)
	GearFinder.ScoreTimer = ZGV:ScheduleRepeatingTimer(function()
		local ok,ret = coroutine.resume(GearFinder.ScoreThread)
		if not ok then print("THREAD ERROR "..ret) end
		if coroutine.status(GearFinder.ScoreThread)=="dead" then 
			ZGV:CancelTimer(GearFinder.ScoreTimer) 
		end
	end,
	0.1)
	GearFinder.AntsMode = ""
	GearFinder.AntsTimer = ZGV:ScheduleRepeatingTimer(function() progress_dots() end, 0.5)
end

-- used to make item slots in gear finder window. creates texture and fontstrings, sets tooltip calls
-- params
--	object - array - int texture id, int slot id, string slot name
-- returns:
--	button - frame - pack of objects that make one slot
local function make_button(object)
	local button = CHAIN(CreateFrame("Button",nil,GearFinder.MainFrame))
		:SetFrameLevel(GearFinder.MainFrame:GetFrameLevel()+2)
		:SetSize(240,40)
	.__END	
		button:SetScript("OnEnter",function()
			if button.dungeonguide then
				button.loadguide:Show()
			end
		end)
		button:SetScript("OnLeave",function()
			button.loadguide:Hide()
		end)


	button.tooltiphandler = CHAIN(CreateFrame("Button",nil,button))
		:SetFrameLevel(button:GetFrameLevel()+1)
		:SetPoint("TOPLEFT")
		:SetSize(40,40)
	.__END	
		button.itemicon = CHAIN(button.tooltiphandler:CreateTexture()) 
			:SetSize(40,40)
			:SetPoint("TOPLEFT",button) 
			:SetTexture(object[1])
		.__END

		button.tooltiphandler:SetScript("OnEnter",function()
			GameTooltip:SetOwner(button, "ANCHOR_CURSOR")
			if button.link then
				GameTooltip:SetHyperlink(button.link)
			else
				GameTooltip:SetText(button.slotName)
			end
			GameTooltip:Show()
		end)
		button.tooltiphandler:SetScript("OnLeave",function()
			GameTooltip:FadeOut()
		end)


	button.itemlink = CHAIN(button:CreateFontString())
		:SetPoint("TOPLEFT",button.itemicon,"TOPRIGHT",5,0)
		:SetFont(FONT,12)
		:SetText("")
		:SetWidth(200)
		:SetJustifyH("LEFT")
		:SetWordWrap(false)
	.__END

	button.itemdungeon = CHAIN(button:CreateFontString())
		:SetPoint("TOPLEFT",button.itemlink,"BOTTOMLEFT",0,-3)
		:SetFont(FONT,10)
		:SetText("No upgrade found")
		:SetWidth(200)
		:SetJustifyH("LEFT")
		:SetWordWrap(false)
	.__END
	button.itemencounter = CHAIN(button:CreateFontString())
		:SetPoint("TOPLEFT",button.itemdungeon,"BOTTOMLEFT",0,-3)
		:SetFont(FONT,10)
		:SetText("")
		:SetWidth(200)
		:SetJustifyH("LEFT")
		:SetWordWrap(false)
	.__END

	button.loadguide = CHAIN(CreateFrame("Button", nil, button, nil))
		:SetBackdrop(SkinData("GuideBackdrop"))
		:SetBackdropColor(0,0,0,1)
		:SetBackdropBorderColor(0,0,0,0)
		:SetSize(SkinData("TabsHeight"),SkinData("TabsHeight"))
		:SetPoint("RIGHT")
		:Hide()
		:SetScript("OnUpdate",tabs_update_handler) 
		:SetScript("OnEnter",function() 
			button.loadguide:Show()
			GameTooltip:SetOwner(button, "ANCHOR_TOP")
			GameTooltip:SetText(ZGV.L['frame_selectguide'])
			GameTooltip:AddLine(ZGV.L['frame_selectguide_left'],0,1,0)
			GameTooltip:Show()
		end)
		:SetScript("OnLeave",function() 
			button.loadguide:Hide()
			GameTooltip:Hide()
		end)
		:SetScript("OnClick",function(self,b) 
			if button.dungeonguide then
				ZGV.Tabs:LoadGuideToTab(button.dungeonguide,button.dungeonguide.CurrentStepNum or 1)
			end
		end)
	.__END
	ZGV.F.AssignButtonTexture(button.loadguide,SkinData("TitleButtons"),23,32)

	button.slotID = object[2]
	button.slotName = object[3]
	button.slotTexture = object[1]
	button.dungeonguide = nil
	return button
end

-- update gearfinder window to use current skin
-- no params
-- no returns
function GearFinder:ApplySkin()
	local MF = self.MainFrame 

	MF.Logo:SetTexture(SkinData("TitleLogo"))
	MF.Logo:SetSize(unpack(SkinData("TitleLogoSize")))

	MF.CenterColumn:SetPoint("LEFT",MF,"LEFT",SkinData("GuideMenuMargin"),0)
	MF.CenterColumn:SetPoint("RIGHT",MF,"RIGHT",-SkinData("GuideMenuMargin"),0)
	MF.CenterColumn:SetBackdropColor(unpack(SkinData("GuideMenuMenuBackground")))

	MF.FooterSettingsButton:SetPoint("BOTTOMRIGHT",-SkinData("GuideMenuFooterElementsOffset"),5)
	ZGV.F.AssignButtonTexture(MF.FooterSettingsButton,(SkinData("TitleButtons")),5,32)

	MF.Progress:SetTexture(SkinData("ProgressBarTextureFile"))
	MF.Progress:SetDecor(SkinData("ProgressBarDecorUse"))

	ZGV.F.AssignButtonTexture(MF.AddButton,SkinData("TitleButtons"),23,32)

end

-- creates main frame, with header and footer, adds entries for all equip slots and guide info
-- no params
-- no returns
function GearFinder:CreateMainFrame()
	if self.MainFrame then return end

	self.MainFrame = CHAIN(ui:Create("Frame",UIParent,"ZygorGearFinder"))
		:SetWidth(700)
		:SetPoint("TOPLEFT",CharacterFrame,"TOPLEFT")
		:SetPoint("BOTTOMLEFT",CharacterFrame,"BOTTOMLEFT")
		:SetFrameStrata("HIGH")
		:SetFrameLevel(CharacterFrame:GetFrameLevel()+1)
		:SetToplevel(enable)
		.__END


	local MF = self.MainFrame 

	MF.Logo = CHAIN(MF:CreateTexture())
		:SetPoint("TOP",MF,"TOP",0,-3) 
	.__END
	MF.Title = CHAIN(MF:CreateFontString())
		:SetPoint("TOPLEFT",8,-8)
		:SetFont(FONT,14) 
		:SetTextColor(unpack(SkinData("TabSelectedColor")))
		:SetText("Gear Finder")
	 .__END
	MF.close = CHAIN(CreateFrame("Button",nil,MF))
		:SetPoint("TOPRIGHT",-5,-5)
		:SetSize(17,17)
		:SetScript("OnClick", function() 
			MF:Hide()
			HideUIPanel(CharacterFrame) 
		end)
		.__END
	ZGV.F.AssignButtonTexture(MF.close,(SkinData("TitleButtons")),6,32)


	-- Footer
	MF.FooterSettingsButton = CHAIN(CreateFrame("Button",nil,MF))
		:SetPoint("BOTTOMRIGHT",-5,5)
		:SetSize(15,15)
		:SetScript("OnClick",function() ZGV:OpenOptions("gear") end)
	.__END

	-- black container
	MF.CenterColumn = CHAIN(ui:Create("Frame", MF))
		:SetPoint("TOP",MF.Logo,"BOTTOM")
		:SetPoint("BOTTOM",MF.FooterSettingsButton,"TOP")
		:EnableMouse(true)
		.__END


	local left_column = {
		{136515,INVSLOT_HEAD,INVTYPE_HEAD},
		{136519,INVSLOT_NECK,INVTYPE_NECK},
		{136526,INVSLOT_SHOULDER,INVTYPE_SHOULDER},
		{136512,INVSLOT_BACK,INVTYPE_CLOAK},
		{136512,INVSLOT_CHEST,INVTYPE_CHEST},
		{136530,INVSLOT_WRIST,INVTYPE_WRIST},
		{136518,INVSLOT_MAINHAND,INVTYPE_WEAPON},
		{136524,INVSLOT_OFFHAND,INVTYPE_WEAPONOFFHAND},
	}

	local right_column = {
		{136515,INVSLOT_HAND,INVTYPE_HAND},
		{136529,INVSLOT_WAIST,INVTYPE_WAIST},
		{136517,INVSLOT_LEGS,INVTYPE_LEGS},
		{136513,INVSLOT_FEET,INVTYPE_FEET},
		{136514,INVSLOT_FINGER1,INVTYPE_FINGER},
		{136514,INVSLOT_FINGER2,INVTYPE_FINGER},
		{136528,INVSLOT_TRINKET1,INVTYPE_TRINKET},
		{136528,INVSLOT_TRINKET2,INVTYPE_TRINKET},
	}

	MF.Buttons = {}
	local previous = nil
	for i,object in ipairs(left_column) do
		local button = make_button(object)
	
		if previous then
			button:SetPoint("TOPLEFT",previous,"BOTTOMLEFT",0,-6)
		else
			button:SetPoint("TOPLEFT",MF.CenterColumn,"TOPLEFT",10,-10)
		end
		previous = button
		MF.Buttons[object[2]] = button
	end

	local previous = nil
	for i,object in ipairs(right_column) do
		local button = make_button(object)
	
		if previous then
			button:SetPoint("TOPLEFT",previous,"BOTTOMLEFT",0,-6)
		else
			button:SetPoint("TOPLEFT",MF.Buttons[INVSLOT_HEAD],"TOPRIGHT",20,0)
		end
		previous = button
		MF.Buttons[object[2]] = button
	end

	MF.DungeonImage = CHAIN(MF.CenterColumn:CreateTexture(nil,"LOW")) 
		:SetSize(140,89) 
		:SetPoint("TOPRIGHT",-10,-10) 
		:SetTexture(ZGV.DIR.."\\Skins\\menu_noguide")
		:SetTexCoord(0,220/256,0,139/256)
	.__END

	MF.DungeonMessage = CHAIN(MF.CenterColumn:CreateFontString())
		:SetPoint("TOPLEFT",MF.DungeonImage,"BOTTOMLEFT",0,-10)
		:SetFont(FONT,10)
		:SetText("Suggested dungeon:")
		:SetWidth(120)
		:SetJustifyH("CENTER")
		:Hide()
	.__END

	MF.AddButton = CHAIN(CreateFrame("Button", nil, MF.CenterColumn, nil))
		:SetBackdrop(SkinData("GuideBackdrop"))
		:SetBackdropColor(0,0,0,1)
		:SetBackdropBorderColor(0,0,0,0)
		:SetSize(SkinData("TabsHeight"),SkinData("TabsHeight"))
		:SetScript("OnUpdate",tabs_update_handler) 
		:SetScript("OnEnter",function() 
			GameTooltip:SetOwner(MF.AddButton, "ANCHOR_TOP")
			GameTooltip:SetText(ZGV.L['frame_selectguide'])
			GameTooltip:AddLine(ZGV.L['frame_selectguide_left'],0,1,0)
			GameTooltip:Show()
		end)
		:SetScript("OnLeave",function() 
			GameTooltip:Hide()
		end)
		:SetScript("OnClick",function(self,button) 
			if GearFinder.BestDungeonGuide then
				ZGV.Tabs:LoadGuideToTab(GearFinder.BestDungeonGuide,GearFinder.BestDungeonGuide.CurrentStepNum or 1)
			end
		end)
		:SetPoint("TOPRIGHT",MF.DungeonMessage,"BOTTOMRIGHT",20,-10)
		:Hide()
	.__END

	MF.DungeonName = CHAIN(MF.CenterColumn:CreateFontString())
		:SetPoint("TOPLEFT",MF.DungeonMessage,"BOTTOMLEFT",0,-10)
		:SetFont(FONT,12)
		:SetText("")
		:SetWidth(120)
		:SetJustifyH("CENTER")
	.__END
	MF.DungeonDesc = CHAIN(MF.CenterColumn:CreateFontString())
		:SetPoint("TOPLEFT",MF.DungeonName,"BOTTOMLEFT",0,0)
		:SetFont(FONT,10)
		:SetText("")
		:SetWidth(120)
		:SetJustifyH("CENTER")
	.__END


	MF.Progress = CHAIN(ui:Create("ProgressBar",MF))
		:SetSize(500,7)
		:SetFrameLevel(MF:GetFrameLevel()+3)
		:ClearAllPoints()
		:SetPoint("BOTTOMLEFT",MF,"BOTTOMLEFT",5,5)
		:SetDecor(SkinData("ProgressBarDecorUse"))
		:SetAnim(true)
		--:Hide()
	.__END

	tinsert(UISpecialFrames, "ZygorGearFinder") -- allows the frame to be closable with ESC keypress

	MF.overlay = CHAIN(ui:Create("Button",MF))
		:SetSize(300,300)
		:SetPoint("TOPLEFT",MF,"TOPLEFT",10,-27)
		:SetPoint("BOTTOMRIGHT",MF,"BOTTOMRIGHT",-10,20)
		:SetFont(FONT,12)
		:SetScript("OnClick", function() GearFinder:ScoreDungeonItems() end)
		:SetScript("OnEnter",function()
			GameTooltip:SetOwner(MF.overlay, "ANCHOR_CURSOR")
			GameTooltip:SetText("Click to refresh")
			GameTooltip:Show()
		end)
		:SetScript("OnLeave",function()
			GameTooltip:FadeOut()
		end)

		:SetBackdropColor(0,0,0,0.7)
		:SetHighlightBackdropColor(0,0,0,0.7)
		:SetNormalBackdropColor(0,0,0,0.7)
		:SetBackdropBorderColor(0,0,0,0.7)
		:SetFrameLevel(MF:GetFrameLevel()+5)
		:SetTexture(ZGV.DIR.."\\Skins\\refresh")
		:Hide()
	.__END

	MF.overlay.tex:ClearAllPoints()
	MF.overlay.tex:SetPoint("CENTER")


	GearFinder:ApplySkin()
	MF:Hide()
end

-- unhide elements of blizzard ui we hid when showing our frame
-- no params
-- no returns
function GearFinder:RestoreBlizzardFrame()
	CharacterFrameInset:Show()
	CharacterFramePortrait:Show()
	CharacterFrameBg:Show()
	CharacterFrameTitleText:Show()
	CharacterFrameCloseButton:Show()

	if CharacterFramePortraitFrame then
		CharacterFramePortraitFrame:Show()
		CharacterFrameTitleBg:Show()
		CharacterFrameLeftBorder:Show()
		CharacterFrameTopBorder:Show()
		CharacterFrameRightBorder:Show()
		CharacterFrameBottomBorder:Show()
		CharacterFrameTopTileStreaks:Show()
		CharacterFrameTopRightCorner:Show()
		CharacterFrameBotLeftCorner:Show()
		CharacterFrameBotRightCorner:Show()
	end

	if CharacterFrame.NineSlice then
		for i,v in pairs(CharacterFrame.NineSlice) do
			if type(v)=="table" and v.Show then v:Show() end
		end
		CharacterFrame.TitleBg:Show()
		CharacterFrame.TopTileStreaks:Hide()
	end
end

-- support function for character frame system tab creation
local function OnZygorTabClick(self) 
	if ZygorGearFinder:IsVisible() then return end
	ToggleCharacter("ZygorGearFinder")
	PanelTemplates_SetTab(CharacterFrame, self:GetID())

	CharacterFrameInset:Hide()
	CharacterFramePortrait:Hide()
	CharacterFrameBg:Hide()
	CharacterFrameTitleText:Hide()
	CharacterFrameCloseButton:Hide()

	if CharacterFramePortraitFrame then
		CharacterFramePortraitFrame:Hide()
		CharacterFrameTitleBg:Hide()
		CharacterFrameLeftBorder:Hide()
		CharacterFrameTopBorder:Hide()
		CharacterFrameRightBorder:Hide()
		CharacterFrameBottomBorder:Hide()
		CharacterFrameTopTileStreaks:Hide()
		CharacterFrameTopRightCorner:Hide()
		CharacterFrameBotLeftCorner:Hide()
		CharacterFrameBotRightCorner:Hide()
	end

	if CharacterFrame.NineSlice then
		for i,v in pairs(CharacterFrame.NineSlice) do
			if type(v)=="table" and v.Hide then v:Hide() end
		end
		CharacterFrame.TitleBg:Hide()
		CharacterFrame.TopTileStreaks:Hide()
	end

	GearFinder:ScoreDungeonItems()
end

-- support function for character frame system tab creation
local function ZygorTabAnchor()
	local tab = GearFinder.BlizzardTab
	if not tab then return end
	if tab.Anchored then return end

	for i=1,CharacterFrame.numTabs do
		local previous = _G["CharacterFrameTab"..i]
		if previous and previous~=tab and previous:IsVisible() then
			tab:SetPoint("LEFT", previous, "RIGHT", -16, 0)
			tab.Anchored = true
		end
	end
end


-- support function for character frame system tab creation
local function OnNonZygorClick()
	GearFinder:RestoreBlizzardFrame()
end

-- attaches zygor gearfinder tab button to blizzard character frame, hooks functions to show/hide our frame and blizz elements
-- no params
-- no returns
function GearFinder:CreateSystemTab()
	if not ZGV.db.profile.autogear then return end

	if self.BlizzardTab then
		ZygorTabAnchor()
		return
	end

	local n = CharacterFrame.numTabs + 1
	local tab = CreateFrame("Button", "CharacterFrameTab"..n, CharacterFrame, "CharacterFrameTabButtonTemplate")
	tab:SetID(n)
	tab:SetText("|cfffe6000Gear Finder")
	tab:SetNormalFontObject(GameFontHighlightSmall)
	tab:Show()
	tab:SetScript("OnClick", OnZygorTabClick)
	tab.Zygor = true
	self.BlizzardTab = tab

	ZygorTabAnchor()


	PanelTemplates_SetNumTabs(CharacterFrame, n)
	PanelTemplates_EnableTab(CharacterFrame, n)
	PanelTemplates_TabResize(_G["CharacterFrameTab4"], nil, 100, nil, nil);

	ItemScore:Hook("CharacterFrameTab_OnClick", OnNonZygorClick, true)
	ItemScore:Hook("CharacterFrame_Expand", OnNonZygorClick, true)

	table.insert(CHARACTERFRAME_SUBFRAMES,"ZygorGearFinder")

end

function GearFinder:UpdateSystemTab()
	if ZGV.db.profile.autogear then
		if not self.BlizzardTab then 
			GearFinder:CreateSystemTab()
		end
		self.BlizzardTab:Show()
	else
		if self.BlizzardTab then 
			self.BlizzardTab:Hide()
			GearFinder:RestoreBlizzardFrame()
			if CharacterFrame:IsVisible() and GearFinder.MainFrame:IsVisible() then
				GearFinder.MainFrame:Hide()
				ToggleCharacter("PaperDollFrame")
			end
		end
	end
end

-- maps difficulty id to display name (normal, heroic etc)
local diff_to_name = {
	[1]=PLAYER_DIFFICULTY1,
	[2]=PLAYER_DIFFICULTY2,
	[3]=PLAYER_DIFFICULTY1,
	[4]=PLAYER_DIFFICULTY1,
	[5]=PLAYER_DIFFICULTY2,
	[6]=PLAYER_DIFFICULTY2,
	[7]=PLAYER_DIFFICULTY3,
	[23]=PLAYER_DIFFICULTY6,
	[24]=PLAYER_DIFFICULTY_TIMEWALKER,
	[17]=PLAYER_DIFFICULTY3,
	[14]=PLAYER_DIFFICULTY1,
	[15]=PLAYER_DIFFICULTY2,
	[16]=PLAYER_DIFFICULTY6,
}

local function find_dungeon_guide(ident)
	local dungeon = ZGV.Dungeons[ident]

	if not dungeon then return false end

	local dungeon_guide, dungeon_map, dungeon_lfg

	if type(dungeon.map)=="table" then
		for i,v in pairs(dungeon.map) do
			if not dungeon_map or v<dungeon_map then dungeon_map = v end
		end
	else
		dungeon.map = dungeon.map
	end
	dungeon_map = tonumber(dungeon_map)
	dungeon_lfg = tonumber(dungeon.id)

	if dungeon_lfg then
		for g,guide in ipairs(ZGV.registeredguides) do -- check by lfg codes first, for winded instances
			if tonumber(guide.lfgid)==(dungeon_lfg) then dungeon_guide=guide break end
		end
	end

	if not dungeon_guide and dungeon_map then
		for g,guide in ipairs(ZGV.registeredguides) do -- if nothing, then use dungeon maps
			if tonumber(guide.mapid)==tonumber(dungeon_map) then dungeon_guide=guide break end
		end
	end

	return dungeon_guide,dungeon
end

-- displays result of scoring all dungeon items
-- fills all slots, dims slots with future items or without anything found
-- looks for guide matching dungeon with most results, show image if it has one, sets guide to be loaded from button
-- no params
-- no returns
function GearFinder:DisplayResults()
	if not GearFinder.MainFrame then return end

	local MF = GearFinder.MainFrame

	local dungeons = {}	

	local Buttons = MF.Buttons
	for i,v in pairs(GearFinder.UpgradeQueue) do
		local upgrade = v[1]
		local button = Buttons[i]
		if upgrade then
			local name,itemlink = ZGV:GetItemInfo(upgrade.itemlink)
			button.itemicon:SetTexture(upgrade.texture)
			button.itemlink:SetText(itemlink)
			button.link = itemlink -- so that tooltip can pull it
			button.itemicon:SetDesaturated(upgrade.future)
			button:SetAlpha(1)

			local dungeon = ZGV.Dungeons[upgrade.ident]
			button.itemdungeon:SetText(dungeon and dungeon.name or "unknown")

			if upgrade.future then
				button:SetAlpha(0.5)
			else
				dungeons[upgrade.ident] = (dungeons[upgrade.ident] or 0) + 1
				button.dungeonguide, button.dungeon = find_dungeon_guide(upgrade.ident)
			end

			if upgrade.future then
				if dungeon.minLevel and dungeon.minLevel > ItemScore.playerlevel then 
					button.itemencounter:SetText("(requires level "..dungeon.minLevel..")")
				end
			else
				if upgrade.quest then 
					button.itemencounter:SetText("Quest: "..(upgrade.questname or C_QuestLog.GetQuestInfo(upgrade.quest) or ""))
				elseif upgrade.encounterId then 
					button.itemencounter:SetText(EJ_GetEncounterInfo(upgrade.encounterId))
				end
			end
		else
			button.itemicon:SetTexture(button.slotTexture)
			button.itemlink:SetText(" ")
			button.link = nil
			if not GearFinder.AntsTimer then
				button.itemdungeon:SetText("No upgrade found")
			end
			button.itemencounter:SetText(" ")
			button.itemicon:SetDesaturated(false)
			button:SetAlpha(0.5)
		end
	end

	-- find best dungeon
	local sorted_dungeons = {}
	for i,v in pairs(dungeons) do
		table.insert(sorted_dungeons,{i,v})
	end

	table.sort(sorted_dungeons,function(x,y) return x[2]>y[2] end)

	local best_dungeon = sorted_dungeons[1]

	if best_dungeon then
		-- find guide for it 
		local dungeon_guide, dungeon = find_dungeon_guide(best_dungeon[1])
		if dungeon_guide then 
			GearFinder.BestDungeonGuide = dungeon_guide

			MF.DungeonMessage:Show()
			if dungeon_guide.image then 
				MF.DungeonImage:SetTexture(dungeon_guide.image) 
				MF.DungeonImage:SetTexCoord(0,1,0,1)
			end
			MF.AddButton:Show()
		else
			MF.AddButton:Hide()
		end

		MF.DungeonName:SetText(dungeon.name)
		MF.DungeonName:Show()
		MF.DungeonDesc:SetText(diff_to_name[dungeon.difficulty] .. "\n\n"..best_dungeon[2].." items found")
		MF.DungeonDesc:Show()
	end

end

-- clears all displayed results, to be used when gearfinder/itemscore settings are changed or when user changes level/spec
-- no params
-- no returns
function GearFinder:ClearResults()
	if not GearFinder.MainFrame then return end
	local MF = GearFinder.MainFrame
	GearFinder.ResultsReady = false

	for i,v in pairs(ItemScore.GearFinder.UpgradeQueue) do 
		table.wipe(v) 
	end

	MF.DungeonMessage:Hide()
	MF.DungeonImage:SetTexture(ZGV.DIR.."\\Skins\\menu_noguide")
	MF.DungeonImage:SetTexCoord(0,220/256,0,139/256)
	MF.DungeonName:Hide()
	MF.DungeonDesc:Hide()
	MF.AddButton:Hide()

	for i,button in pairs(MF.Buttons) do
		button.itemicon:SetTexture(button.slotTexture)
		button.itemlink:SetText(" ")
		button.link = nil
		button.dungeonguide = nil
		button.itemdungeon:SetText("No upgrade found")
		button.itemencounter:SetText(" ")
		button.itemicon:SetDesaturated(false)
		button:SetAlpha(0.5)
	end

	MF.overlay:Show()
end