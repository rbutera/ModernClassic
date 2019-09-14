local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

----------------------------------------------------------------
--> API Localization
----------------------------------------------------------------

local _G = getfenv(0)
local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

local find = string.find

----------------------------------------------------------------
--> 删除物品加 Delete
----------------------------------------------------------------

local function QuickDeleteGood_Load()
	hooksecurefunc(StaticPopupDialogs.DELETE_GOOD_ITEM, 'OnShow', function(box)
		box.editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
	end)
end
local QuickDeleteGood = {}
QuickDeleteGood.Load = QuickDeleteGood_Load()
insert(E.Module, QuickDeleteGood)

----------------------------------------------------------------
--> Character Frame
----------------------------------------------------------------
-- itemLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemString)
-- "itemLink" = GetInventoryItemLink("unit", slotId)
-- current, maximum = GetInventoryItemDurability(slotID)
-- itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataID, itemSellPrice = GetItemInfo(itemID or "itemString" or "itemName" or "itemLink") 
----------------------------------------------------------------

--local LibItemUpgradeInfo = LibStub:GetLibrary("LibItemUpgradeInfo-1.0")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.7000")

local PosSlot = {[0] = "Top", [1] = "Right", [2] = "Right", [3] = "Right", [4] = "Right", [5] = "Right", [6] = "Left", [7] = "Left", [8] = "Left", [9] = "Right", [10] = "Left", [11] = "Left", [12] = "Left", [13] = "Left", [14] = "Left", [15] = "Right", [16] = "Top", [17] = "Top", [18] = "Top"}

local function Get_ItemGem(itemLink)
	if not itemLink then return end
	local num = 0
	local gems = {}
	local stats = GetItemStats(itemLink)
	if stats then
		for k, v in pairs(stats) do
			if find(k, "EMPTY_SOCKET_") then
				num = num + v
			end
		end
	end
	if num > 0 then
		for i = 1, num do
			local name, link = GetItemGem(itemLink, i)
			insert(gems, {Name = name, Link = link})
		end
	end
	return num, gems
end

local function Create_GemButton(f)
	local frame = CreateFrame("Button", nil, f)
	frame: SetSize(12,12)
	frame.Bg = F.create_Texture(frame, "BACKGROUND", "Addition_Gem1")
	frame.Bg: SetSize(12,12)
	frame.Bg: SetPoint("CENTER", frame, "CENTER", 0,0)
	
	frame.Icon = F.create_Texture(frame, "BORDER")
	frame.Icon: SetSize(10,10)
	frame.Icon: SetPoint("CENTER", frame, "CENTER", 0,0)
	
	frame.Bd = F.create_Texture(frame, "OVERLAY", "Addition_Gem2")
	frame.Bd: SetSize(12,12)
	frame.Bd: SetPoint("CENTER", frame, "CENTER", 0,0)
	frame: SetScript("OnEnter", function(self)
		if self.ItemLink then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(self.ItemLink)
			GameTooltip:Show()
		end
	end)
	frame: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
	return frame
end

local function Create_ItemGem(f, itemLink, slotID)
	local num, gems = Get_ItemGem(itemLink)
	if num and num > 0 then
		for i = 1, num do
			if not f["Gem"..i] then
				f["Gem"..i] =Create_GemButton(f)
			end
			if gems[i]["Link"] then
				f["Gem"..i].ItemLink = gems[i]["Link"]
				local itemType, itemSubType, _,_, itemTexture = select(6, GetItemInfo(gems[i]["Link"]))
				f["Gem"..i].Icon: SetTexture(itemTexture)
			else
				f["Gem"..i].ItemLink = nil
				f["Gem"..i].Icon: SetTexture("")
				--f["Gem"..i].Icon: SetTexture("Interface\\ItemSocketingFrame\\UI-EmptySocket")
			end
			if PosSlot[slotID] == "Right" then
				if i == 1 then
					f["Gem"..i]: SetPoint("TOPLEFT", f, "TOPRIGHT", 10, 0)
				else
					f["Gem"..i]: SetPoint("TOP", f["Gem"..(i-1)], "BOTTOM", 0, 0)
				end
			elseif PosSlot[slotID] == "Left" then
				if i == 1 then
					f["Gem"..i]: SetPoint("TOPRIGHT", f, "TOPLEFT", -10, 0)
				else
					f["Gem"..i]: SetPoint("TOP", f["Gem"..(i-1)], "BOTTOM", 0, 0)
				end
			elseif PosSlot[slotID] == "Top" then
				if i == 1 then
					f["Gem"..i]: SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 8)
				else
					f["Gem"..i]: SetPoint("LEFT", f["Gem"..(i-1)], "RIGHT", 0, 0)
				end
			end
			f["Gem"..i]:Show()
		end
		for i = num+1, 4 do
			if f["Gem"..i] then
				f["Gem"..i]:Hide()
			end
		end
	else
		for i = 1, 4 do
			if f["Gem"..i] then
				f["Gem"..i]:Hide()
			end
		end
	end
end

local function Hook_PaperDollSlotButton(self, unit)
	local slotID = self:GetID()
	local itemLvel, itemLink, itemQuality, bug
	--local itemLink = GetInventoryItemLink("player", slotID)
	--local itemLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemLink)
	--local itemLevel = select(2, LibItemInfo:GetItemInfo(itemLink))
	local textureName = GetInventoryItemTexture(unit, self:GetID())
	if unit and textureName then
		itemLevel, _, itemLink, quality = select(2, LibItemInfo:GetUnitItemInfo(unit, slotID))
		if (slotID == 16) or (slotID == 17) then
			local _, mlevel, _, _, mquality = LibItemInfo:GetUnitItemInfo(unit, 16)
			local _, olevel, _, _, oquality = LibItemInfo:GetUnitItemInfo(unit, 17)
			if (mlevel > 0 and olevel > 0 and (mquality == 6 or oquality == 6)) then
				itemLevel = max(mlevel,olevel)
			end
		end
	else
		itemLevel = 0
	end
	local curDura, maxDura = GetInventoryItemDurability(slotID)
	
	if not self.ItemFrame then
		local ItemFrame = CreateFrame("Frame", nil, self)
		ItemFrame: SetFrameLevel(self:GetFrameLevel()+1)
		ItemFrame: SetAllPoints(self)
		
		self.ItemFrame = ItemFrame
		self.ItemFrame.Level = F.create_Font(self.ItemFrame, C.Font.NumSmall, 12, "OUTLINE", 0, "CENTER", "CENTER")
		self.ItemFrame.Level: SetTextColor(F.Color(C.Color.W4))
		self.ItemFrame.Level: SetAlpha(0.9)
		self.ItemFrame.Level: SetPoint("CENTER", self.ItemFrame, "CENTER", 1,0)
		
		local DuraBar = CreateFrame("StatusBar", nil, self.ItemFrame)
		DuraBar: SetStatusBarTexture(F.Path("StatusBar\\Flat"))
		DuraBar: SetStatusBarColor(F.Color(C.Color.Y2))
		DuraBar: SetRotatesTexture(true)
		if PosSlot[slotID] == "Right" then
			DuraBar: SetOrientation("VERTICAL")
			DuraBar: SetPoint("BOTTOMLEFT", self.ItemFrame, "BOTTOMRIGHT", 1,1)
			DuraBar: SetPoint("TOPRIGHT", self.ItemFrame, "TOPRIGHT", 5,-1)
		elseif PosSlot[slotID] == "Left" then
			DuraBar: SetOrientation("VERTICAL")
			DuraBar: SetPoint("BOTTOMLEFT", self.ItemFrame, "BOTTOMLEFT", -5,1)
			DuraBar: SetPoint("TOPRIGHT", self.ItemFrame, "TOPLEFT", -1,-1)
		elseif PosSlot[slotID] == "Top" then
			DuraBar: SetOrientation("HORIZONTAL")
			DuraBar: SetPoint("BOTTOMLEFT", self.ItemFrame, "TOPLEFT", 1,1)
			DuraBar: SetPoint("TOPRIGHT", self.ItemFrame, "TOPRIGHT", -1,5)
		end
		DuraBar: SetMinMaxValues(0, 1)
		DuraBar: SetValue(0)
		self.ItemFrame.DuraBar = DuraBar
		
		self.ItemFrame.DuraBarBg = F.create_Texture(self.ItemFrame, "BACKGROUND", "White", C.Color.W1, 0.9)
		self.ItemFrame.DuraBarBg: SetAllPoints(self.ItemFrame.DuraBar)
	end
	if itemLevel and (itemLevel > 0) then
		self.ItemFrame.Level: SetText(itemLevel)
	else
		self.ItemFrame.Level: SetText("")
	end
	if maxDura then
		self.ItemFrame.DuraBar: SetValue(curDura/(maxDura+F.Debug))
		self.ItemFrame.DuraBar: Show()
	else
		self.ItemFrame.DuraBar: Hide()
	end
	Create_ItemGem(self.ItemFrame, itemLink, slotID)
end


local function Hook_EquipmentFlyout_DisplayButton(button, paperDollItemSlot)
	local location = button.location;
	if ( not location ) then
		return;
	end
	local player, bank, bags, voidStorage, slotID, bagID, tab, voidSlot = EquipmentManager_UnpackLocation(location)
	if (not (player or bank or bags)) then 
		return;
	end
	local itemLink, itemLevel
	if bags then
		itemLink = GetContainerItemLink(bagID, slotID)
		itemLevel = select(2, LibItemInfo:GetContainerItemLevel(bagID, slotID))
	else
		itemLink = GetInventoryItemLink("player", slotID)
		itemLevel = select(2, LibItemInfo:GetItemInfo(itemLink))
	end
	--local itemLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemLink)
	
	if not button.ItemFrame then
		local ItemFrame = CreateFrame("Frame", nil, button)
		ItemFrame: SetFrameLevel(button:GetFrameLevel()+1)
		ItemFrame: SetAllPoints(button)
		
		button.ItemFrame = ItemFrame
		button.ItemFrame.Level = F.create_Font(button.ItemFrame, C.Font.NumSmall, 12, "OUTLINE", 0, "CENTER", "CENTER")
		button.ItemFrame.Level: SetTextColor(F.Color(C.Color.W4))
		button.ItemFrame.Level: SetAlpha(0.9)
		button.ItemFrame.Level: SetPoint("CENTER", button.ItemFrame, "CENTER", 1,0)
	end
	if itemLevel  and (itemLevel > 0) then
		button.ItemFrame.Level: SetText(itemLevel)
	else
		button.ItemFrame.Level: SetText("")
	end
end

local function CharacterFramePlus_Load()
	hooksecurefunc("PaperDollItemSlotButton_Update", function(self)
		Hook_PaperDollSlotButton(self, "player")
	end)
	if F.IsClassic then
		
	else
		hooksecurefunc("EquipmentFlyout_DisplayButton", function(button, paperDollItemSlot)
			Hook_EquipmentFlyout_DisplayButton(button, paperDollItemSlot)
		end)
	end
end
local CharacterFramePlus = {}
CharacterFramePlus.Load = CharacterFramePlus_Load()
insert(E.Module, CharacterFramePlus)

--- ------------------------------------------------------------
--> TradeSkill Frame
--- ------------------------------------------------------------
--[[
function F.TradeSkillFrame()
	if not IsAddOnLoaded("Blizzard_TradeSkillUI") then
		LoadAddOn("Blizzard_TradeSkillUI")
	end
	local TSF = CreateFrame("Frame", nil ,UIParent)
	TSF: RegisterEvent("ADDON_LOADED", "Blizzard_TradeSkillUI")
	TSF: SetScript("OnEvent", function(self,event,name)
		if event == "ADDON_LOADED" then
			TradeSkillFrame: SetHeight(596)
			--TradeSkillFrameScrollChild: SetHeight(510)
			TradeSkillFrame.RecipeInset: SetHeight(510)
			TradeSkillFrame.DetailsInset: SetHeight(490)
			TradeSkillFrame.RecipeList: SetHeight(505)
			TradeSkillFrame.DetailsFrame: SetHeight(485)
			TradeSkillFrame.DetailsFrame.Background: SetHeight(483)
			
			HybridScrollFrame_CreateButtons(TradeSkillFrame.RecipeList, "TradeSkillRowButtonTemplate", 0, 0);
			
			local ROW_HEIGHT = 16;
			local LIST_FULL_HEIGHT = 505;
			
			local function Hook_TradeSkillRecipeListMixin_RefreshDisplay(self)
				HybridScrollFrame_Update(self, #self.dataList * ROW_HEIGHT, 505)
			end
			hooksecurefunc(TradeSkillFrame.RecipeList, "RefreshDisplay", function(self)
				Hook_TradeSkillRecipeListMixin_RefreshDisplay(self)
				local parent = TradeSkillFrameScrollChild: GetParent()
			end)
			
			local function Hook_TradeSkillRecipeListMixin_UpdateFilterBar(self)
				if self.FilterBar:IsShown() then
					self:SetHeight(LIST_FULL_HEIGHT - ROW_HEIGHT)
					self:SetPoint("TOPLEFT", 7, -83 - ROW_HEIGHT);
					self.LearnedTab:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 10, 3 + ROW_HEIGHT);
					self.scrollBar:SetPoint("TOPLEFT", self, "TOPRIGHT", 1, -14 + ROW_HEIGHT);
				else
					self:SetHeight(LIST_FULL_HEIGHT)
					self:SetPoint("TOPLEFT", 7, -83);
					self.LearnedTab:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 10, 3);
					self.scrollBar:SetPoint("TOPLEFT", self, "TOPRIGHT", 1, -14);
				end
			end
			
			hooksecurefunc(TradeSkillFrame.RecipeList, "UpdateFilterBar", function(self)
				Hook_TradeSkillRecipeListMixin_UpdateFilterBar(self)
			end)
		end
	end)
end
]]--
--F.TradeSkillFrame()

--[[
MERCHANT_ITEMS_PER_PAGE = 12;
--BUYBACK_ITEMS_PER_PAGE = 14;
--MAX_MERCHANT_CURRENCIES = 7
MerchantFrame: SetHeight(544)

local function Hook_MerchantFrame_UpdateMerchantInfo(self)
	MerchantItem11:SetPoint("TOPLEFT", "MerchantItem9", "BOTTOMLEFT", 0, -8);
end

hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function(self)
	Hook_MerchantFrame_UpdateMerchantInfo(self)
end)
--]]

--[[
local function Hook_CompactRaidFrameManager_UpdateShown(self)
	self:Show()
end
hooksecurefunc("CompactRaidFrameManager_UpdateShown", function(self)
	Hook_CompactRaidFrameManager_UpdateShown(self)
end)

local function Hook_CompactRaidFrameManager_UpdateOptionsFlowContainer(self)
	local container = self.displayFrame.optionsFlowContainer;
	
	--> 配置
	FlowContainer_AddObject(container, self.displayFrame.profileSelector);
	self.displayFrame.profileSelector:Show();
	
	--> 队列
	--FlowContainer_AddObject(container, self.displayFrame.filterOptions);
	--self.displayFrame.filterOptions:Show();
	
	FlowContainer_AddLineBreak(container);
	FlowContainer_AddSpacer(container, 20);
	FlowContainer_AddObject(container, self.displayFrame.lockedModeToggle);
	FlowContainer_AddObject(container, self.displayFrame.hiddenModeToggle);
	self.displayFrame.lockedModeToggle:Show();
	self.displayFrame.hiddenModeToggle:Show();
	
	FlowContainer_ResumeUpdates(container);
	local usedX, usedY = FlowContainer_GetUsedBounds(container);
	self:SetHeight(usedY + 40);
end
hooksecurefunc("CompactRaidFrameManager_UpdateOptionsFlowContainer", function(self)
	Hook_CompactRaidFrameManager_UpdateOptionsFlowContainer(self)
end)
--]]
--[[
local function Hook_CompactRaidGroup_UpdateUnits(frame)
	if ( not IsInRaid() ) then
		CompactUnitFrame_SetUnit(_G[frame:GetName().."Member1"], "raid1");
	end
end
hooksecurefunc("CompactRaidGroup_UpdateUnits", function(self)
	Hook_CompactRaidGroup_UpdateUnits(self)
end)
--]]
--[[
local function GuildRoster()
	if not (GetLocale() == "zhCN") then return end
	if not IsAddOnLoaded("Blizzard_GuildUI") then
		LoadAddOn("Blizzard_GuildUI")
	end
	local Icon_Class = {
		["WARRIOR"]			= {  0/128, 32/128,   0/128, 32/128},
		["MAGE"]			= { 32/128, 64/128,   0/128, 32/128},
		["ROGUE"]			= { 64/128, 96/128,   0/128, 32/128},
		["DRUID"]			= { 96/128,128/128,   0/128, 32/128},
		["HUNTER"]			= {  0/128, 32/128,  32/128, 64/128},
		["DEATHKNIGHT"]		= { 32/128, 64/128,  64/128, 96/128},
		["PRIEST"]			= { 64/128, 96/128,  32/128, 64/128},
		["WARLOCK"]			= { 96/128,128/128,  32/128, 64/128},
		["PALADIN"]			= {  0/128, 32/128,  64/128, 96/128},
		["SHAMAN"]			= { 32/128, 64/128,  32/128, 64/128},
		["MONK"]			= { 64/128, 96/128,  64/128, 96/128},
		["DEMONHUNTER"]		= { 96/128,128/128,  64/128, 96/128},
	}

	local function Hook_GuildRoster_Update()
		local scrollFrame = GuildRosterContainer;
		local offset = HybridScrollFrame_GetOffset(scrollFrame);
		local buttons = scrollFrame.buttons;
		local numButtons = #buttons;
		local button, index, class;
		local totalMembers, onlineMembers, onlineAndMobileMembers = GetNumGuildMembers();
		local currentGuildView = GetCVar("guildRosterView")
		for i = 1, numButtons do
			button = buttons[i];		
			index = offset + i;

			local fullName, rank, rankIndex, level, class, zone, note, officernote, online, isAway, classFileName, achievementPoints, achievementRank, isMobile, canSoR, repStanding = GetGuildRosterInfo(index);
			local onlineOrMobile = online or isMobile;
			local maxAchievementsPoints = GetGuildRosterLargestAchievementPoints();
			-- numVisible
			local visibleMembers = onlineAndMobileMembers;
			if ( GetGuildRosterShowOffline() ) then
				visibleMembers = totalMembers;
			end
			if ( fullName and index <= visibleMembers ) then
				--button.icon:SetTexture(F.Path("Icon_Class"))
				--button.icon:SetTexCoord(unpack(Icon_Class[classFileName]))
				button.icon:ClearAllPoints()
				button.icon:SetPoint("LEFT", button.string1, "RIGHT", GUILD_ROSTER_COLUMN_DATA.level.width-36,0)
			end
		end
	end
	hooksecurefunc("GuildRoster_Update", function(self)
		Hook_GuildRoster_Update(self)
	end)

	local function Hook_WhoList_Update()
		local ButtonVariable, ButtonLevel, ButtonClass
		for i=1, WHOS_TO_DISPLAY, 1 do
			ButtonVariable = _G["WhoFrameButton"..i.."Variable"]
			ButtonVariable: SetWidth(90)
			ButtonLevel = _G["WhoFrameButton"..i.."Level"]
			ButtonLevel: SetWidth(38)
			ButtonClass = _G["WhoFrameButton"..i.."Class"]
			ButtonClass: SetWidth(75)
		end
	end
	hooksecurefunc("WhoList_Update", function(self)
		Hook_WhoList_Update()
	end)

	local GR = CreateFrame("Frame", nil ,UIParent)
	GR: RegisterEvent("PLAYER_ENTERING_WORLD")
	GR: SetScript("OnEvent", function(self,event,arg1)
		GUILD_ROSTER_COLUMN_DATA.level.width = 48 --40
		--GUILD_ROSTER_COLUMN_DATA.level.stringJustify="LEFT"
		GUILD_ROSTER_COLUMN_DATA.name.width = 91 --81
		GUILD_ROSTER_COLUMN_DATA.wideName.width = 112 --101
		GUILD_ROSTER_COLUMN_DATA.zone.width = 120 --136
		GUILD_ROSTER_COLUMN_DATA.note.width = 66 --76
		GUILD_ROSTER_COLUMN_DATA.achievement.width = 122 --136
		GUILD_ROSTER_COLUMN_DATA.skill.width = 74 --63
		GUILD_ROSTER_COLUMN_DATA.reputation.width = 122 --136
		GuildRoster_SetView(GetCVar("guildRosterView"))
		Hook_GuildRoster_Update()

		WhoFrameColumn_SetWidth(_G["WhoFrameColumnHeader1"], 84) --83
		--WhoFrameColumn_SetWidth(_G["WhoFrameColumnHeader2"], 90) --105
		WhoFrameColumn_SetWidth(_G["WhoFrameColumnHeader3"], 40) --32
		WhoFrameColumn_SetWidth(_G["WhoFrameColumnHeader4"], 81) --92

		self: UnregisterAllEvents()
	end)
	
end

local GuildLevelFix = {}
GuildLevelFix.Load = GuildRoster()
insert(E.Module, GuildLevelFix)
--]]
--- ------------------------------------------------------------
--> NamePlate
--- ------------------------------------------------------------

----------------------------------------------------------------
-- CompactUnitFrame_OnLoad(self)
----------------------------------------------------------------

local function Hook_DefaultCompactNamePlateFrameSetup(self, options)
	if not self:IsForbidden() then
		if self.healthBar then
			self.healthBar: SetStatusBarTexture(F.Path("StatusBar\\Raid"))
		end
		if self.powerBar then
			self.powerBar: SetStatusBarTexture(F.Path("StatusBar\\Raid"))
		end
		if self.castBar then
			self.castBar: SetStatusBarTexture(F.Path("StatusBar\\Raid"))
		end
	end
end
hooksecurefunc("DefaultCompactNamePlateFrameSetup", function(self, options)
	Hook_DefaultCompactNamePlateFrameSetup(self, options)
end)

--- ------------------------------------------------------------
--> CompactRaid
--- ------------------------------------------------------------

----------------------------------------------------------------
-- CompactUnitFrame_UpdateAll(self)
-- CompactRaidGroup_InitializeForGroup(frame, groupIndex)
----------------------------------------------------------------

local function Hook_DefaultCompactUnitFrameSetup(self)
	if not self:IsForbidden() then
		local name = self:GetName()
		if name then
			if _G[name.."HealthBar"] then
				_G[name.."HealthBar"]: SetStatusBarTexture(F.Path("StatusBar\\Raid"))
			end
			if _G[name.."PowerBar"] then
				_G[name.."PowerBar"]: SetStatusBarTexture(F.Path("StatusBar\\Raid"))
			end
			if _G[name.."Background"] then
				_G[name.."Background"]: SetTexture(F.Path("StatusBar\\Raid"))
				_G[name.."Background"]: SetVertexColor(F.Color(C.Color.W1))
			end
		end
	end
end
hooksecurefunc("DefaultCompactUnitFrameSetup", function(self)
	Hook_DefaultCompactUnitFrameSetup(self)
end)

--- ------------------------------------------------------------
--> Tooltip
--- ------------------------------------------------------------

--[[
if not GuildControlUIRankSettingsFrameRosterLabel then
	GuildControlUIRankSettingsFrameRosterLabel = CreateFrame("frame")
	GuildControlUIRankSettingsFrameRosterLabel:Hide()
end
--]]
--- ------------------------------------------------------------
--> New
--- ------------------------------------------------------------

local Wormhole_List = {
	18986, --安全传送器：加基森
	18984, --空间撕裂器：永望镇
	30542, --空间撕裂器：52区
	48933, --虫洞发生器：诺森德
	87215, --虫洞发生器：帕达利亚
	112059, --虫洞离心机（德拉诺）
	151652, --虫洞发生器：阿古斯
}

-- "COMBAT_LOG_EVENT_UNFILTERED"
-- CombatLogGetCurrentEventInfo()

--[[
PlayerPowerBarAlt:SetMovable(true)
PlayerPowerBarAlt:SetUserPlaced(true)

local fPA = CreateFrame("Frame")
fPA:RegisterEvent("UNIT_POWER_BAR_SHOW")
fPA:RegisterEvent("UNIT_POWER")
fPA:SetScript("OnEvent", function()
	PlayerPowerBarAlt:ClearAllPoints()
	PlayerPowerBarAlt:SetPoint("TOP","oUF_BrethrenRFBossPower","TOP")	
end)
--]]