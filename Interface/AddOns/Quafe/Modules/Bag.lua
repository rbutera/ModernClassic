local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale
--if F.IsClassic then return end

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad
local find = string.find
local insert = table.insert
local GetItemClassInfo = _G.GetItemClassInfo
local GetItemSubClassInfo = _G.GetItemSubClassInfo
--local LibItemUpgradeInfo = LibStub:GetLibrary("LibItemUpgradeInfo-1.0")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.7000")

--- ------------------------------------------------------------
--> Bag
--- ------------------------------------------------------------

-- texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered = GetContainerItemInfo(bag, slot);
-- itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemID or "itemString" or "itemName" or "itemLink")
-- itemID, itemType, itemSubType, itemEquipLoc, itemTexture, itemClassID, itemSubClassID = GetItemInfoInstant(itemLink) 
-- GetItemClassInfo(classIndex)
-- GetItemSubClassInfo(classIndex, subClassIndex)
-- ITEM_QUALITY_COLORS

--local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, reforging, Name = 
--string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")

--local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, reforging, Name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")

--local itemString = string.match(itemLink, "item[%-?%d:]+")

--[[
ITEM_QUALITY0_DESC = "Poor";
ITEM_QUALITY1_DESC = "Common";
ITEM_QUALITY2_DESC = "Uncommon";
ITEM_QUALITY3_DESC = "Rare";
ITEM_QUALITY4_DESC = "Epic";
ITEM_QUALITY5_DESC = "Legendary";
ITEM_QUALITY6_DESC = "Artifact";
ITEM_QUALITY7_DESC = "Heirloom";
ITEM_QUALITY8_DESC = "WoW Token";

	ITEMCLASS = {
		["Elixir"] =				{L = 1,  C = {r= 46, g=204, b=113}, T = "Bag_Elixir"},			--药剂
		["Food"] =					{L = 2,  C = {r= 46, g=204, b=113}, T = "Bag_Food"},			--食物
		[ITEMCLASS_Consumable] =	{L = 3,  C = {r= 46, g=204, b=113}, T = "Bag_Consumable"},		--消耗品 Consumable 
		[GetItemClassInfo(12)] =	{L = 4,  C = {r=241, g=196, b= 15}, T = "Bag_Quest"},			--任务
		[GetItemClassInfo(2)] =		{L = 5,  C = {r=231, g= 76, b= 60}, T = "Bag_Weapon"},			--武器
		[GetItemClassInfo(4)] =		{L = 6,  C = {r=231, g= 76, b= 60}, T = "Bag_Armor"},			--护甲
		[GetItemClassInfo(3)] =		{L = 7,  C = {r=155, g= 89, b=182}, T = "White"},				--宝石
		[GetItemClassInfo(16)] =	{L = 8,  C = {r=155, g= 89, b=182}, T = "White"},				--雕文
		[GetItemClassInfo(8)] =		{L = 9,  C = {r=155, g= 89, b=182}, T = "White"},				--物品强化
		[GetItemClassInfo(9)] =		{L = 10, C = {r=236, g=240, b=241}, T = "White"},				--配方
		[GetItemClassInfo(7)] =		{L = 11, C = {r= 52, g=152, b=219}, T = "White"},				--商业技能
		[GetItemClassInfo(5)] =		{L = 12, C = {r= 52, g=152, b=219}, T = "White"},				--材料
		[GetItemClassInfo(13)] = 	{L = 13, C = {r= 52, g=152, b=219}, T = "White"},				--钥匙
		[GetItemClassInfo(15)] =	{L = 14, C = {r=155, g= 89, b=182}, T = "White"},				--杂项
		["Other"] = 				{L = 15, C = {r= 22, g=160, b=133}, T = "White"},				--其它
		["Sale"] =					{L = 16, C = {r= 52, g= 73, b= 94}, T = "White"},				--垃圾
	}

--]]

--[[
local function Get_FullItemClass()
	local COMPILED_ITEM_CLASSES = {}
	local classIndex = 0
	local className = GetItemClassInfo(classIndex)

	while className and className ~= "" do
		COMPILED_ITEM_CLASSES[classIndex] = {
			name = className,
			subClasses = {},
		}

		local subClassIndex = 0
		local subClassName = GetItemSubClassInfo(classIndex, subClassIndex)

		while subClassName and subClassName ~= "" do
			COMPILED_ITEM_CLASSES[classIndex].subClasses[subClassIndex] = subClassName

			subClassIndex = subClassIndex + 1
			subClassName = GetItemSubClassInfo(classIndex, subClassIndex)
		end

		classIndex = classIndex + 1
		className = GetItemClassInfo(classIndex)
	end
	return COMPILED_ITEM_CLASSES
end

local COMPILED_ITEM_CLASSES = Get_FullItemClass()
for k1, v1 in pairs(COMPILED_ITEM_CLASSES) do
	for k2, v2 in pairs(v1.subClasses) do
		print(k1, v1.name, k2, v2)
	end
end
--]]

--[[
local RefEquipmentSlots = {
	INVTYPE_AMMO = 0,
	INVTYPE_HEAD = 1,
	INVTYPE_NECK = 2,
	INVTYPE_SHOULDER = 3,
	INVTYPE_BODY = 4,
	INVTYPE_CHEST = 5,
	INVTYPE_ROBE = 5,
	INVTYPE_WAIST = 6,
	INVTYPE_LEGS = 7,
	INVTYPE_FEET = 8,
	INVTYPE_WRIST = 9,
	INVTYPE_HAND = 10,
	INVTYPE_FINGER = 11,
	INVTYPE_TRINKET = 12,
	INVTYPE_CLOAK = 13,
	INVTYPE_WEAPON = 14,
	INVTYPE_SHIELD = 15,
	INVTYPE_2HWEAPON = 16,
	INVTYPE_WEAPONMAINHAND = 18,
	INVTYPE_WEAPONOFFHAND = 19,
	INVTYPE_HOLDABLE = 20,
	INVTYPE_RANGED = 21,
	INVTYPE_THROWN = 22,
	INVTYPE_RANGEDRIGHT = 23,
	INVTYPE_RELIC = 24,
	INVTYPE_TABARD = 25
}
local ItemCategories = {
	AUCTION_CATEGORY_WEAPONS,  --武器
	AUCTION_CATEGORY_ARMOR,  --护甲
	AUCTION_CATEGORY_CONTAINERS,  --容器
	AUCTION_CATEGORY_CONSUMABLES,  --消耗品
	AUCTION_CATEGORY_ITEM_ENHANCEMENT,  --物品附魔
	AUCTION_CATEGORY_GLYPHS,  --雕文
	AUCTION_CATEGORY_TRADE_GOODS,  --杂货
	AUCTION_CATEGORY_RECIPES,  --配方
	AUCTION_CATEGORY_GEMS,  --宝石
	AUCTION_CATEGORY_MISCELLANEOUS,  --杂项
	AUCTION_CATEGORY_QUEST_ITEMS,
	AUCTION_CATEGORY_BATTLE_PETS
}

local sortingCache = {
	[1] = {}, --BAG
	[2] = {}, --ID
	[3] = {}, --PETID
	[4] = {}, --STACK
	[5] = {}, --MAXSTACK
	[6] = {}, --MOVES
}
--]]

local Bag = {}
local BagFree = {}
local BagNew = {}
local Bank = {}
local BankFree = {}
local Reagent = {}
local ReagentFree = {}

local config = {
	buttonSize = 32,
	iconSize = 28,
	buttonGap = 3,
	border = 8,
	perLine = 12,
	bankperLine = 18,
	reagentperLine = 18,
}

local SlotNum = {
	["Total"] = 0,
	["Free"] = 0,
	["Bag0"] = 0,
	["Bag1"] = 0,
	["Bag2"] = 0,
	["Bag3"] = 0,
	["Bag4"] = 0,
	["Bank"] = 0,
	["BankFree"] = 0,
}

local ITEMCLASS = {}
local ITEMCLASS_Consumable = GetItemClassInfo(0)
local ITEMCLASS_Weapon = GetItemClassInfo(2)
local ITEMCLASS_Armor = GetItemClassInfo(4)
local ITEMCLASS_Miscellaneous = GetItemClassInfo(15)
local function Init_ItemClass()
	wipe(ITEMCLASS)
	if F.IsClassic then
		ITEMCLASS = {
			--["New"] = 				{L = 1,  C = C.Color.B1, T = "Bag_New"},         --新物品
			["Elixir"] =				{L = 1,  C = C.Color.Y1, T = "Bag_Elixir",			D = GetItemSubClassInfo(0, 1)},         --药剂
			["Food"] =					{L = 2,  C = C.Color.Y1, T = "Bag_Food",			D = GetItemSubClassInfo(0, 5)},			--食物
			[ITEMCLASS_Consumable] =	{L = 3,  C = C.Color.Y1, T = "Bag_Consumable",		D = ITEMCLASS_Consumable},	   			--消耗品
			[GetItemClassInfo(12)] =	{L = 4,  C = C.Color.Y1, T = "Bag_Quest",			D = GetItemClassInfo(12)},				--任务
			[ITEMCLASS_Weapon] =		{L = 5,  C = C.Color.Y1, T = "Bag_Weapon",			D = ITEMCLASS_Weapon},					--武器
			[ITEMCLASS_Armor] =			{L = 6,  C = C.Color.Y1, T = "Bag_Armor",			D = ITEMCLASS_Armor},					--护甲
			[GetItemClassInfo(3)] =		{L = 7,  C = C.Color.Y1, T = "Bag_Gem",				D = GetItemClassInfo(3)},				--宝石
			--[GetItemClassInfo(16)] =	{L = 8,  C = C.Color.Y1, T = "Bag_Glyphs",			D = GetItemClassInfo(16)},		  		--雕文
			[GetItemClassInfo(8)] =		{L = 9,  C = C.Color.Y1, T = "Bag_Upgrade",			D = GetItemClassInfo(8)},				--物品强化
			[GetItemClassInfo(9)] =		{L = 10, C = C.Color.Y1, T = "Bag_Glyph",			D = GetItemClassInfo(9)},				--配方
			[GetItemClassInfo(7)] =		{L = 11, C = C.Color.Y1, T = "Bag_Trade",			D = GetItemClassInfo(7)},				--商业技能
			[GetItemClassInfo(5)] =		{L = 12, C = C.Color.Y1, T = "Bag_Material",		D = GetItemClassInfo(5)},				--材料
			[GetItemClassInfo(13)] = 	{L = 13, C = C.Color.Y1, T = "Bag_Key",				D = GetItemClassInfo(13)},				--钥匙
			[ITEMCLASS_Miscellaneous] =	{L = 14, C = C.Color.Y1, T = "Bag_Goods",			D = ITEMCLASS_Miscellaneous},			--杂项
			["Other"] = 				{L = 15, C = C.Color.Y1, T = "Bag_Other",			D = OTHER},								--其它
			["Hearthstone"] =			{L = 16, C = C.Color.Y1, T = "Bag_Hearthstone"},	--炉石
			["Sale"] =					{L = 17, C = C.Color.Y1, T = "Bag_Junk"},			--垃圾
		}
		ITEMCLASS.Elixir.SubClass = {
			[GetItemSubClassInfo(0, 1)] = {L = 1},  --药水
			[GetItemSubClassInfo(0, 2)] = {L = 2},  --药剂
			--[GetItemSubClassInfo(0, 3)] = {L = 3},  --合剂
			--[GetItemSubClassInfo(0, 7)] = {L = 4},  --绷带
		}
		ITEMCLASS.Food.SubClass = {
			--[GetItemSubClassInfo(0, 5)] = {L = 1},  --餐饮供应商
		}
	else
		ITEMCLASS = {
			--["New"] = 				{L = 1,  C = C.Color.B1, T = "Bag_New"},         --新物品
			["Elixir"] =				{L = 1,  C = C.Color.Y1, T = "Bag_Elixir",			D = GetItemSubClassInfo(0, 1)},         --药剂
			["Food"] =					{L = 2,  C = C.Color.Y1, T = "Bag_Food",			D = GetItemSubClassInfo(0, 5)},			--食物
			[ITEMCLASS_Consumable] =	{L = 3,  C = C.Color.Y1, T = "Bag_Consumable",		D = ITEMCLASS_Consumable},	   			--消耗品
			[GetItemClassInfo(12)] =	{L = 4,  C = C.Color.Y1, T = "Bag_Quest",			D = GetItemClassInfo(12)},				--任务
			[ITEMCLASS_Weapon] =		{L = 5,  C = C.Color.Y1, T = "Bag_Weapon",			D = ITEMCLASS_Weapon},					--武器
			[ITEMCLASS_Armor] =			{L = 6,  C = C.Color.Y1, T = "Bag_Armor",			D = ITEMCLASS_Armor},					--护甲
			[GetItemClassInfo(3)] =		{L = 7,  C = C.Color.Y1, T = "Bag_Gem",				D = GetItemClassInfo(3)},				--宝石
			[GetItemClassInfo(16)] =	{L = 8,  C = C.Color.Y1, T = "Bag_Glyphs",			D = GetItemClassInfo(16)},		  		--雕文
			[GetItemClassInfo(8)] =		{L = 9,  C = C.Color.Y1, T = "Bag_Upgrade",			D = GetItemClassInfo(8)},				--物品强化
			[GetItemClassInfo(9)] =		{L = 10, C = C.Color.Y1, T = "Bag_Glyph",			D = GetItemClassInfo(9)},				--配方
			[GetItemClassInfo(7)] =		{L = 11, C = C.Color.Y1, T = "Bag_Trade",			D = GetItemClassInfo(7)},				--商业技能
			[GetItemClassInfo(5)] =		{L = 12, C = C.Color.Y1, T = "Bag_Material",		D = GetItemClassInfo(5)},				--材料
			[GetItemClassInfo(13)] = 	{L = 13, C = C.Color.Y1, T = "Bag_Key",				D = GetItemClassInfo(13)},				--钥匙
			[ITEMCLASS_Miscellaneous] =	{L = 14, C = C.Color.Y1, T = "Bag_Goods",			D = ITEMCLASS_Miscellaneous},			--杂项
			["Other"] = 				{L = 15, C = C.Color.Y1, T = "Bag_Other",			D = OTHER},								--其它
			["Hearthstone"] =			{L = 16, C = C.Color.Y1, T = "Bag_Hearthstone"},	--炉石
			["Sale"] =					{L = 17, C = C.Color.Y1, T = "Bag_Junk"},			--垃圾
		}
		ITEMCLASS.Elixir.SubClass = {
			[GetItemSubClassInfo(0, 1)] = {L = 1},  --药水
			[GetItemSubClassInfo(0, 2)] = {L = 2},  --药剂
			[GetItemSubClassInfo(0, 3)] = {L = 3},  --合剂
			[GetItemSubClassInfo(0, 7)] = {L = 4},  --绷带
		}
		ITEMCLASS.Food.SubClass = {
			[GetItemSubClassInfo(0, 5)] = {L = 1},  --餐饮供应商
		}
	end

	ITEMCLASS.Hearthstone.itemID = {
		["6948"] =		{L = 1},   --炉石
		["140192"] =	{L = 2},   --达拉然炉石
		["110560"] =	{L = 3},   --要塞炉石
		["141605"] =	{L = 4},   --飞行管理员的哨子
		["65360"] =		{L = 5},   --协同披风
		["63206"] =		{L = 6},   --协和披风
		["63352"] =		{L = 7},   --协作披风
		["46874"] =		{L = 8},   --银色北伐军战袍
		["128353"] =	{L = 9},   --海军上将的罗盘
		["37863"] =	    {L = 10},  --黑铁遥控器
		["32757"] =	    {L = 11},  --卡拉波神圣勋章
		["118663"] =	{L = 12},  --卡拉波圣物
	}
end

local BANKITEMCLASS = {}
local function Init_BankItemClass()
	wipe(BANKITEMCLASS)
	if F.IsClassic then
		BANKITEMCLASS = {
			["Elixir"] =				{L = 1,  C = C.Color.Y1, T = "Bag_Elixir",			D = GetItemSubClassInfo(0, 1)},         --药剂
			["Food"] =					{L = 2,  C = C.Color.Y1, T = "Bag_Food",			D = GetItemSubClassInfo(0, 5)},			--食物
			[ITEMCLASS_Consumable] =	{L = 3,  C = C.Color.Y1, T = "Bag_Consumable",		D = ITEMCLASS_Consumable},     			--消耗品
			[GetItemClassInfo(12)] =	{L = 4,  C = C.Color.Y1, T = "Bag_Quest",			D = GetItemClassInfo(12)},				--任务
			[ITEMCLASS_Weapon] =		{L = 5,  C = C.Color.Y1, T = "Bag_Weapon",			D = ITEMCLASS_Weapon},         			--武器
			[ITEMCLASS_Armor] =			{L = 6,  C = C.Color.Y1, T = "Bag_Armor",			D = ITEMCLASS_Armor},					--护甲
			[GetItemClassInfo(3)] =		{L = 7,  C = C.Color.Y1, T = "Bag_Gem",				D = GetItemClassInfo(3)},				--宝石
			--[GetItemClassInfo(16)] =	{L = 8,  C = C.Color.Y1, T = "Bag_Glyphs",			D = GetItemClassInfo(16)},	    	    --雕文
			[GetItemClassInfo(8)] =		{L = 9,  C = C.Color.Y1, T = "Bag_Upgrade",			D = GetItemClassInfo(8)},				--物品强化
			[GetItemClassInfo(9)] =		{L = 10, C = C.Color.Y1, T = "Bag_Glyph",			D = GetItemClassInfo(9)},				--配方
			[GetItemClassInfo(7)] =		{L = 11, C = C.Color.Y1, T = "Bag_Trade",			D = GetItemClassInfo(7)},				--商业技能
			[GetItemClassInfo(5)] =		{L = 12, C = C.Color.Y1, T = "Bag_Material",		D = GetItemClassInfo(5)},				--材料
			[GetItemClassInfo(13)] = 	{L = 13, C = C.Color.Y1, T = "Bag_Key",				D = GetItemClassInfo(13)},				--钥匙
			[ITEMCLASS_Miscellaneous] =	{L = 14, C = C.Color.Y1, T = "Bag_Goods",			D = ITEMCLASS_Miscellaneous},			--杂项
			["Other"] = 				{L = 15, C = C.Color.Y1, T = "Bag_Other",			D = OTHER},								--其它
			["Sale"] =					{L = 17, C = C.Color.Y1, T = "Bag_Junk"},			--垃圾
		}
		BANKITEMCLASS.Elixir.SubClass = {
			[GetItemSubClassInfo(0, 1)] = {L = 1},  --药水
			[GetItemSubClassInfo(0, 2)] = {L = 2},  --药剂
			--[GetItemSubClassInfo(0, 3)] = {L = 3},  --合剂
			--[GetItemSubClassInfo(0, 7)] = {L = 4},  --绷带
		}
		BANKITEMCLASS.Food.SubClass = {
			--[GetItemSubClassInfo(0, 5)] = {L = 1},  --餐饮供应商
		}
	else
		BANKITEMCLASS = {
			["Elixir"] =				{L = 1,  C = C.Color.Y1, T = "Bag_Elixir",			D = GetItemSubClassInfo(0, 1)},         --药剂
			["Food"] =					{L = 2,  C = C.Color.Y1, T = "Bag_Food",			D = GetItemSubClassInfo(0, 5)},			--食物
			[ITEMCLASS_Consumable] =	{L = 3,  C = C.Color.Y1, T = "Bag_Consumable",		D = ITEMCLASS_Consumable},     			--消耗品
			[GetItemClassInfo(12)] =	{L = 4,  C = C.Color.Y1, T = "Bag_Quest",			D = GetItemClassInfo(12)},				--任务
			[ITEMCLASS_Weapon] =		{L = 5,  C = C.Color.Y1, T = "Bag_Weapon",			D = ITEMCLASS_Weapon},         			--武器
			[ITEMCLASS_Armor] =			{L = 6,  C = C.Color.Y1, T = "Bag_Armor",			D = ITEMCLASS_Armor},					--护甲
			[GetItemClassInfo(3)] =		{L = 7,  C = C.Color.Y1, T = "Bag_Gem",				D = GetItemClassInfo(3)},				--宝石
			[GetItemClassInfo(16)] =	{L = 8,  C = C.Color.Y1, T = "Bag_Glyphs",			D = GetItemClassInfo(16)},	    	    --雕文
			[GetItemClassInfo(8)] =		{L = 9,  C = C.Color.Y1, T = "Bag_Upgrade",			D = GetItemClassInfo(8)},				--物品强化
			[GetItemClassInfo(9)] =		{L = 10, C = C.Color.Y1, T = "Bag_Glyph",			D = GetItemClassInfo(9)},				--配方
			[GetItemClassInfo(7)] =		{L = 11, C = C.Color.Y1, T = "Bag_Trade",			D = GetItemClassInfo(7)},				--商业技能
			[GetItemClassInfo(5)] =		{L = 12, C = C.Color.Y1, T = "Bag_Material",		D = GetItemClassInfo(5)},				--材料
			[GetItemClassInfo(13)] = 	{L = 13, C = C.Color.Y1, T = "Bag_Key",				D = GetItemClassInfo(13)},				--钥匙
			[ITEMCLASS_Miscellaneous] =	{L = 14, C = C.Color.Y1, T = "Bag_Goods",			D = ITEMCLASS_Miscellaneous},			--杂项
			["Other"] = 				{L = 15, C = C.Color.Y1, T = "Bag_Other",			D = OTHER},								--其它
			["Sale"] =					{L = 17, C = C.Color.Y1, T = "Bag_Junk"},			--垃圾
		}
		BANKITEMCLASS.Elixir.SubClass = {
			[GetItemSubClassInfo(0, 1)] = {L = 1},  --药水
			[GetItemSubClassInfo(0, 2)] = {L = 2},  --药剂
			[GetItemSubClassInfo(0, 3)] = {L = 3},  --合剂
			[GetItemSubClassInfo(0, 7)] = {L = 4},  --绷带
		}
		BANKITEMCLASS.Food.SubClass = {
			[GetItemSubClassInfo(0, 5)] = {L = 1},  --餐饮供应商
		}
	end
end

local function ButtonHighLight_Create(frame, color)
	frame: SetBackdrop({
		bgFile = F.Path("StatusBar\\Raid"),
		edgeFile = F.Path("White"), 
		edgeSize = 2,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	frame: SetBackdropColor(F.Color(color, 0))
	frame: SetBackdropBorderColor(F.Color(color, 0))
	
	frame: HookScript("OnEnter", function(self)
		self: SetBackdropColor(F.Color(color,1))
		self: SetBackdropBorderColor(F.Color(color,1))
		self.Tex: SetVertexColor(F.Color(C.Color.Config.Back))
	end)
	frame: HookScript("OnLeave", function(self)
		self: SetBackdropColor(F.Color(color,0))
		self: SetBackdropBorderColor(F.Color(color,0))
		self.Tex: SetVertexColor(F.Color(color))
	end)
end

local function Button_Template(f)
	local button = CreateFrame("Button", nil, f)
	button: SetSize(24,24)
	button: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	F.create_Backdrop(button, 2, 8, 4, C.Color.Y1,0, C.Color.W4,0.9)
	button.Bg: SetAlpha(0)
	
	button.Icon = button:CreateTexture(nil, "ARTOWRK")
	button.Icon: SetSize(16,16)
	button.Icon: SetPoint("CENTER", button, "CENTER", 0,0)
	button.Icon: SetVertexColor(F.Color(C.Color.W3))
	
	button: SetScript("OnEnter", function(self)
		self.Bg: SetAlpha(1)
		if self.tooltipText then
			GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
			GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0,4)
			GameTooltip:SetText(self.tooltipText)
			GameTooltip:Show()
		end
		--self.Icon: SetVertexColor(F.Color(C.Color.Config.Back))
	end)
	button: SetScript("OnLeave", function(self)
		self.Bg: SetAlpha(0)
		GameTooltip:Hide()
		--self.Icon: SetVertexColor(F.Color(C.Color.W3))
	end)
	
	return button
end

local function Sell_Junk()
	local JUNK_NUM = 0
	for k,v in ipairs(Bag) do
		if v.itemType then
			if v.itemType == "Sale" then
				if JUNK_NUM < 12 then
					PickupContainerItem(v.bagID, v.slotID)
					PickupMerchantItem(0)
					JUNK_NUM = JUNK_NUM + 1
				else
					DEFAULT_CHAT_FRAME:AddMessage("Sell:"..JUNK_NUM)
					return
				end
			end
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("Sell:"..JUNK_NUM)
end

local function Init_BagGap(f, classtable, p)
	local parent
	if p then
		parent = p
	else
		parent = f
	end
	for k, v in pairs(classtable) do
		local frame = CreateFrame("Button", nil, parent)
		frame: SetSize(config.buttonSize, config.buttonSize)

		local icon = frame:CreateTexture(nil, "ARTWORK")
		icon: SetSize(config.iconSize, config.iconSize)
		icon: SetPoint("CENTER", frame, "CENTER", 0,0)
		icon: SetTexture(F.Path(v.T))
		icon: SetVertexColor(F.Color(v.C))
		
		local shadow = frame:CreateTexture(nil, "BORDER")
		shadow: SetSize(config.iconSize, config.iconSize)
		shadow: SetPoint("CENTER", icon, "CENTER", 2,2)
		shadow: SetTexture(F.Path(v.T))
		shadow: SetVertexColor(F.Color(C.Color.W2))
		shadow: SetAlpha(0.5)

		if v.D then
			frame: SetScript("OnEnter", function(self)
				GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
				GameTooltip: SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 0,4)
				GameTooltip: SetText(v.D)
				GameTooltip: Show()
			end)
			frame: SetScript("OnLeave", function(self)
				GameTooltip: Hide()
			end)
		end

		f["BagIcon"..k] = frame
		f["BagIcon"..k].Tex = icon
	end

	--> NewItem
	local NewItem = CreateFrame("Button", nil, parent)
	NewItem: SetSize(config.buttonSize, config.buttonSize)

	local NewItemIcon = NewItem:CreateTexture(nil, "ARTWORK")
	NewItemIcon: SetSize(config.iconSize, config.iconSize)
	NewItemIcon: SetPoint("CENTER", NewItem, "CENTER", 0,0)
	NewItemIcon: SetTexture(F.Path("Bag_New"))
	NewItemIcon: SetVertexColor(F.Color(C.Color.Y1))

	f["BagIconNew"] = NewItem
	f["BagIconNew"].Tex = NewItemIcon
	
	local numfree = CreateFrame("Button", nil, parent)
	numfree: SetSize(config.buttonSize, config.buttonSize)
	f["BagIconFree"] = numfree
	
	local freetext = F.create_Font(numfree, C.Font.NumOW, 21, nil, 1, "CENTER", "CENTER")
	freetext: SetTextColor(F.Color(C.Color.Y2, 1))
	freetext: SetPoint("CENTER", numfree, "CENTER", 0,0)
	f["BagIconFreeText"] = freetext

	f["BagIconNew"]: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f["BagIconNew"]: SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			GameTooltip: Hide()
			if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Manual" or Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Closing" then
				f:FullUpdate_BagItem()
			end
		end
	end)
	f["BagIconNew"]: SetScript("OnEnter", function(self)
		if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Manual" or Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Closing" then
			GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
			GameTooltip: SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 0,4)
			GameTooltip: SetText(L['BAG_GROUP_REFRESH'])
			GameTooltip: Show()
		end
	end)
	f["BagIconNew"]: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
	ButtonHighLight_Create(f["BagIconNew"], C.Color.Y1)

	f["BagIconSale"]: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f["BagIconSale"]: SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			GameTooltip: Hide()
			Sell_Junk()
		end
	end)
	f["BagIconSale"]: SetScript("OnEnter", function(self)
		GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip: SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 0,4)
		GameTooltip: SetText(L['SELL_JUNK'])
		GameTooltip: Show()
	end)
	f["BagIconSale"]: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
	ButtonHighLight_Create(f["BagIconSale"], C.Color.Y1)
end

local function BagGap_Reset(f, classtable)
	for k, v in pairs(classtable) do
		f["BagIcon"..k]: ClearAllPoints()
		f["BagIcon"..k]: Hide()
	end
	f["BagIconNew"]: ClearAllPoints()
	f["BagIconNew"]: Hide()
	f["BagIconFree"]: ClearAllPoints()
	f["BagIconFree"]: Hide()
end

local function Create_ButtonBg(f, e, d)
	local backdrop = {
		bgFile = F.Path("White"),
		edgeFile = F.Path("White"),
		tile = false, tileSize = 0, edgeSize = e, 
		insets = { left = d, right = d, top = d, bottom = d }
	}
	f: SetBackdrop(backdrop)
end

local function Create_BagFrame(f, bagID)
	local button = CreateFrame("Button", "Quafe_Bag"..bagID, f)
	button: SetID(bagID)
	
	return button
end

local function Create_BagItemButton(f, bagID, slotID)
	local template
	if bagID == BANK_CONTAINER then 
		template = "BankItemButtonGenericTemplate"
	elseif bagID == REAGENTBANK_CONTAINER then
		template = "ReagentBankItemButtonGenericTemplate"
		--template = "BankItemButtonGenericTemplate"
	else
		template = "ContainerFrameItemButtonTemplate"
	end
	
	--local button = CreateFrame("CheckButton", "Quafe_Bag"..bagID.."Slot"..slotID, f, template)
	local button = CreateFrame(F.IsClassic and "CheckButton" or "ItemButton", "Quafe_Bag"..bagID.."Slot"..slotID, f, template)
	button: SetSize(config.buttonSize, config.buttonSize)
	button: SetID(slotID)
	button.bagID = bagID
	button.slotID = slotID
	button:Show()
	
	if bagID == BANK_CONTAINER then 
		button: SetFrameLevel(4)
	elseif bagID == REAGENTBANK_CONTAINER then
		button: SetFrameLevel(8)
	end

	local slotName = button: GetName()

	button.Border = CreateFrame("Frame", nil, button)
	button.Border: SetFrameLevel(button:GetFrameLevel()+1)
	button.Border: SetAllPoints(button)

	Create_ButtonBg(button.Border, 1, 0)
	button.Border: SetBackdropColor(F.Color(C.Color.W1, 0))
	button.Border: SetBackdropBorderColor(F.Color(C.Color.W4, 0.9))
	
	button.icon: SetAllPoints(button)
	button.icon: SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.Count: SetFont(C.Font.NumSmall, 11, "OUTLINE")
	button.Count: SetTextColor(197/255, 202/255, 233/255, 1)
	button.Count: ClearAllPoints()
	button.Count: SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1,2)
	
	button.Level = F.create_Font(button, C.Font.NumSmall, 12, "OUTLINE", 0, "CENTER", "CENTER")
	button.Level: SetTextColor(F.Color(C.Color.W4))
	button.Level: SetAlpha(0.9)
	button.Level: SetPoint("CENTER", button, "CENTER", 1,0)
	--[[
	if (not button.NewItemTexture) then
		button.NewItemTexture = button:CreateTexture(nil, "OVERLAY", 1);
	end
	button.NewItemTexture: SetTexture(F.Path("Bag_Icon_Quality"))
	button.NewItemTexture: SetVertexColor(0/255, 200/255, 248/255)
	button.NewItemTexture: SetBlendMode("BLEND")
	button.NewItemTexture: SetAlpha(1)
	button.NewItemTexture: SetSize(14,14)
	button.NewItemTexture: ClearAllPoints()
	button.NewItemTexture: SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 2,2)
	button.NewItemTexture: Hide()
	--]]
	if (not button.NewItemTextureSkin) then
		local Flash = CreateFrame("Frame", nil, button, "Quafe_GarrisonNotificationTemplate")
		Flash: SetAllPoints(button)
		
		local FlashGlow = Flash: CreateTexture(nil, "BORDER")
		FlashGlow: SetTexture(F.Path("White"))
		FlashGlow: SetVertexColor(F.Color(C.Color.W3))
		FlashGlow: SetAlpha(0.75)
		FlashGlow: SetAllPoints(button)

		button.NewItemTexture = Flash
		button.NewItemTextureSkin = true
	end
	button.NewItemTexture: Hide()
	
	if(not button.BattlepayItemTexture) then
		button.BattlepayItemTexture = button:CreateTexture(nil, "OVERLAY", 1);
	end
	button.BattlepayItemTexture: SetTexture("")
	button.BattlepayItemTexture: Hide()

	if(not button.JunkIcon) then
		button.JunkIcon = button:CreateTexture(nil, "OVERLAY", 1);
	end
	button.JunkIcon: SetTexture([[Interface\BUTTONS\UI-GroupLoot-Coin-Up]])
	button.JunkIcon: SetSize(14,14)
	button.JunkIcon: ClearAllPoints()
	button.JunkIcon: SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 2,0)

	if (not button.UpgradeIcon) then
		button.UpgradeIcon = button: CreateTexture(nil, "OVERLAY", 1);
	end
	--Texture:SetAtlas("atlasName"[, useAtlasSize, "filterMode"])
	button.UpgradeIcon: SetAtlas("bags-greenarrow", true)
	button.UpgradeIcon: SetSize(18,20)
	button.UpgradeIcon: ClearAllPoints()
	button.UpgradeIcon: SetPoint("TOPLEFT", button, "TOPLEFT", -2,2)
	button.UpgradeIcon: Hide()

	button.QuestIcon = _G[slotName.."IconQuestTexture"] or button: CreateTexture(nil, "OVERLAY", 2)
	button.QuestIcon: SetTexture(F.Path("Bag_Icon_Quest"))
	button.QuestIcon: SetVertexColor(F.Color(C.Color.W3))
	button.QuestIcon: SetBlendMode("BLEND")
	button.QuestIcon: SetAlpha(1)
	button.QuestIcon: SetSize(24,24)
	button.QuestIcon: ClearAllPoints()
	button.QuestIcon: SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 2,2)

	button.QualityIcon = button: CreateTexture(nil, "OVERLAY", 2)
	--button.QualityIcon: SetTexture(F.Path("Bag_Icon_Quality"))
	--button.QualityIcon: SetSize(12,12)
	--button.QualityIcon: SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 2,2)
	button.QualityIcon: SetTexture(F.Path("Bag_Icon_Glow"))
	button.QualityIcon: SetSize(config.buttonSize, config.buttonSize)
	button.QualityIcon: SetPoint("CENTER", button, "CENTER", 0,0)
	button.QualityIcon: SetVertexColor(F.Color(C.Color.W3))
	
	button: SetNormalTexture("")
	_G[slotName.."NormalTexture"]:ClearAllPoints()
	_G[slotName.."NormalTexture"]:SetAllPoints(button)
	button: SetPushedTexture(F.Path("Button\\Bag_Pushed"))
	button: SetHighlightTexture(F.Path("Button\\Bag_Hightlight"))
	
	button.cooldown = _G[format("%sCooldown", slotName)]
	button.cooldown: ClearAllPoints()
	button.cooldown: SetAllPoints(button)
	
	return button
end

local function Sort_BagItem(ItemTable)
	local function SortFunc(v1, v2)
		if (not v1.itemType) and (not v2.itemType) then
			if v1.bagID ~= v2.bagID then
				return v1.bagID < v2.bagID
			else
				return v1.slotID < v2.slotID
			end
		elseif not v1.itemType then
			return false
		elseif not v2.itemType then
			return true
		elseif ITEMCLASS[v1.itemType].L ~= ITEMCLASS[v2.itemType].L then
			return ITEMCLASS[v1.itemType].L < ITEMCLASS[v2.itemType].L
		elseif v1.itemType == "Hearthstone" then
			if v1.itemID ~= v2.itemID then
				return ITEMCLASS.Hearthstone.itemID[v1.itemID].L < ITEMCLASS.Hearthstone.itemID[v2.itemID].L
			end
		elseif v1.itemSubType and v2.itemSubType and (v1.itemSubType ~= v2.itemSubType) then
			if ITEMCLASS[v1.itemType].SubClass and ITEMCLASS[v2.itemType].SubClass then
				return ITEMCLASS[v1.itemType].SubClass[v1.itemSubType].L < ITEMCLASS[v2.itemType].SubClass[v2.itemSubType].L
			elseif ITEMCLASS[v1.itemType].SubClass then
				return true
			elseif ITEMCLASS[v2.itemType].SubClass then
				return false
			else
				return v1.itemSubType < v2.itemSubType
			end
		else
			if v1.itemType == "Food" then
				if v1.itemLevel ~= v2.itemLevel then
					return v1.itemLevel > v2.itemLevel
				elseif v1.itemID ~= v2.itemID then
					return v1.itemID > v2.itemID
				else
					return v1.itemCount > v2.itemCount
				end
			elseif v1.itemType == ITEMCLASS_Consumable then
				if v1.itemLevel ~= v2.itemLevel then
					return v1.itemLevel > v2.itemLevel
				elseif v1.itemID ~= v2.itemID then
					if v1.itemID and v2.itemID then
						return v1.itemID > v2.itemID
					--elseif v1.itemID then
					--	return true
					--elseif v2.itemID then
					--	return false
					else
						return v1.itemName < v2.itemName
					end
				else
					return v1.itemCount > v2.itemCount
				end
			elseif v1.itemType == ITEMCLASS_Weapon then
				if v1.itemSubType and v2.itemSubType and (v1.itemSubType ~= v2.itemSubType) then
					return v1.itemSubType < v2.itemSubType
				elseif v1.itemLevel ~= v2.itemLevel then
					return v1.itemLevel > v2.itemLevel
				elseif v1.itemQuality ~= v2.itemQuality then
					return v1.itemQuality > v2.itemQuality
				elseif v1.itemID ~= v2.itemID then
					if v1.itemID and v2.itemID then
						return v1.itemID > v2.itemID
					--elseif v1.itemID then
					--	return true
					--elseif v2.itemID then
					--	return false
					else
						return v1.itemName < v2.itemName
					end
				else
					return v1.itemCount > v2.itemCount
				end
			elseif v1.itemType == ITEMCLASS_Armor then
				if (v1.itemSubType and v2.itemSubType) and (v1.itemSubType ~= v2.itemSubType) then
					return v1.itemSubType < v2.itemSubType
				elseif (v1.itemEquipLoc and v2.itemEquipLoc) and (v1.itemEquipLoc ~= v2.itemEquipLoc) then
					return v1.itemEquipLoc < v2.itemEquipLoc
				elseif v1.itemLevel ~= v2.itemLevel then
					return v1.itemLevel > v2.itemLevel
				elseif v1.itemQuality ~= v2.itemQuality then
					return v1.itemQuality > v2.itemQuality
				elseif v1.itemID ~= v2.itemID then
					if v1.itemID and v2.itemID then
						return v1.itemID > v2.itemID
					--elseif v1.itemID then
					--	return true
					--elseif v2.itemID then
					--	return false
					else
						return v1.itemName < v2.itemName
					end
				else
					return v1.itemCount > v2.itemCount
				end
			else
				if v1.itemSubType and v2.itemSubType and (v1.itemSubType ~= v2.itemSubType) then
					return v1.itemSubType < v2.itemSubType
				elseif (v1.itemLevel and v2.itemLevel and (v1.itemLevel ~= v2.itemLevel)) then
					return v1.itemLevel > v2.itemLevel
				elseif v1.itemID ~= v2.itemID then
					if v1.itemID and v2.itemID then
						return v1.itemID > v2.itemID
					--elseif v1.itemID then
					--	return true
					--elseif v2.itemID then
					--	return false
					else
						return v1.itemName < v2.itemName
					end
				else
					return v1.itemCount > v2.itemCount
				end
			end
		end
	end
	table.sort(ItemTable, SortFunc)
end

--[[
local function Update_CIMI(button)
	--CIMI_AddToFrame(button, ContainerFrameItemButton_CIMIUpdateIcon)
    --ContainerFrameItemButton_CIMIUpdateIcon(button.CanIMogItOverlay)
end
--]]

local function Update_SlotItem(slot, v)
	SetItemButtonTexture(slot, v.itemTexture or F.Path("Bag_Slot")) --Interface\Paperdoll\UI-PaperDoll-Slot-Bag
	--SetItemButtonQuality(itemButton, quality, itemID)
	SetItemButtonCount(slot,  v.itemCount)
	SetItemButtonDesaturated(slot, v.itemLocked, 0.5,0.5,0.5)
	if not F.IsClassic then
		ContainerFrameItemButton_UpdateItemUpgradeIcon(slot);

		local isQuestItem, questId, isActiveQuest = GetContainerItemQuestInfo(v.bagID, v.slotID)
		if isQuestItem then
			slot.QuestIcon: Show()
		else
			slot.QuestIcon: Hide()
		end
	else
		slot.QuestIcon: Hide()
	end

	if v.itemQuality == 0 then
		slot.JunkIcon: Show()
	else
		slot.JunkIcon: Hide()
	end
	if v.itemQuality and (v.itemQuality > 1) then
		local color = ITEM_QUALITY_COLORS[v.itemQuality]
		slot.QualityIcon: SetVertexColor(color.r,color.g,color.b)
		slot.QualityIcon: Show()
		slot.Border: SetBackdropBorderColor(color.r,color.g,color.b, 0.9)
	else
		slot.QualityIcon: Hide()
		slot.Border: SetBackdropBorderColor(F.Color(C.Color.W4, 0.9))
	end
	
	local isNewItem = C_NewItems.IsNewItem(v.bagID, v.slotID)
	if isNewItem then
		slot.NewItemTexture: Show()
	else
		slot.NewItemTexture: Hide()
	end
	
	if (v.itemType == ITEMCLASS_Weapon) or (v.itemType == ITEMCLASS_Armor) then
		slot.Level: SetText(v.itemLevel)
	else
		slot.Level: SetText("")
	end
	
	local start, duration, enable = GetContainerItemCooldown(v.bagID, v.slotID)
	CooldownFrame_Set(slot.cooldown, start, duration, enable)
	if duration > 0 and enable == 0 then
		SetItemButtonTextureVertexColor(slot, 0.4, 0.4, 0.4)
	else
		SetItemButtonTextureVertexColor(slot, 1, 1, 1)
	end

	local isBattlePayItem = IsBattlePayItem(v.bagID, v.slotID)
	--Update_CIMI(slot)
end

local function Update_BagItem(f)
	for k,v in ipairs(Bag) do
		Update_SlotItem(f["Bag"..v.bagID]["Slot"..v.slotID], v)
	end
	for k,v in ipairs(BagFree) do
		Update_SlotItem(f["Bag"..v.bagID]["Slot"..v.slotID], v)
	end
end

local function Pos_BagItem(f, pos)
	local x,y
	local z = 0
	local it = ""
	BagGap_Reset(f, ITEMCLASS)
	for k,v in ipairs(Bag) do
		z = z + 1
		if it ~= v.itemType then
			it = v.itemType
			y = floor((z+config.perLine-1)/config.perLine) - 1
			x = z - y * config.perLine - 1
			f["BagIcon"..it]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
			f["BagIcon"..it]: Show()
			z = z + 1
		end
		y = floor((z+config.perLine-1)/config.perLine) - 1
		x = z - y * config.perLine - 1
		f["Bag"..v.bagID]["Slot"..v.slotID]: ClearAllPoints()
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetAlpha(1)
	end
	
	local newgap = false
	local freegap = false
	for k,v in ipairs(BagFree) do
		z = z + 1
		if (not newgap) and v.itemType then
			y = floor((z+config.perLine-1)/config.perLine) - 1
			x = z- y * config.perLine - 1
			f["BagIconNew"]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
			f["BagIconNew"]: Show()
			z = z + 1
			newgap = true
		end
		if (not freegap) and (not v.itemType) then
			y = floor((z+config.perLine-1)/config.perLine) - 1
			x = z- y * config.perLine - 1
			f["BagIconFree"]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
			f["BagIconFreeText"]: SetText(SlotNum.Free)
			f["BagIconFree"]: Show()
			z = z + 1
			freegap = true
		end
		y = floor((z+config.perLine-1)/config.perLine) - 1
		x = z- y * config.perLine - 1
		f["Bag"..v.bagID]["Slot"..v.slotID]: ClearAllPoints()
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetAlpha(1)
	end

	f.Bags: SetHeight((config.buttonSize+config.buttonGap*2)*ceil(z/config.perLine)+config.border*2)
	f: SetHeight((config.buttonSize+config.buttonGap*2)*ceil(z/config.perLine)+config.border*2+ 48+2)
end

local function Insert_BagItem(f)
	wipe(Bag)
	wipe(BagFree)
	for b = 0, NUM_BAG_SLOTS do
		if not f["Bag"..b] then
			f["Bag"..b] = Create_BagFrame(f, b)
		end
		for s = 1, ContainerFrame_GetContainerNumSlots(b) do
			if not f["Bag"..b]["Slot"..s] then
				f["Bag"..b]["Slot"..s] = Create_BagItemButton(f["Bag"..b], b, s)
			end
			local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered = GetContainerItemInfo(b, s)
			if texture then
				local _, itemID = strsplit(":", itemLink)
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
				--local itemID, itemType, itemSubType, itemEquipLoc, itemTexture, itemClassID, itemSubClassID = GetItemInfoInstant(itemLink) 
				if (itemType == ITEMCLASS_Weapon) or (itemType == ITEMCLASS_Armor) then
					--local itemRealLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemLink)
					--local itemRealLevel = select(2, LibItemInfo:GetItemInfo(itemLink))
					local itemRealLevel = select(2, LibItemInfo:GetContainerItemLevel(b, s))
					itemLevel = itemRealLevel or itemLevel
				end
				itemType = itemType or "Other"
				if not ITEMCLASS[itemType] then
					itemType = "Other"
				end
				if quality == 0 then
					itemType = "Sale"
				end
				if itemType == ITEMCLASS_Consumable then
					if ITEMCLASS.Elixir.SubClass[itemSubType] then
						itemType = "Elixir"
					end
					if ITEMCLASS.Food.SubClass[itemSubType] then
						itemType = "Food"
					end
				end
				if ITEMCLASS.Hearthstone.itemID[itemID] then
					itemType = "Hearthstone"
				end
				insert(Bag, {
					bagID = b, slotID = s, 
					itemName = itemName, itemID = itemID, 
					itemTexture = texture, itemCount = itemCount, 
					itemType = itemType, itemSubType = itemSubType, itemEquipLoc = itemEquipLoc,
					itemQuality = quality, itemLevel = itemLevel,
					itemLocked = locked,
				})
			else
				insert(BagFree, {
					bagID = b, slotID = s, 
					itemName = nil, itemID = nil,
					itemTexture = nil, itemCount = 0, 
					itemType = nil, itemSubType = nil, 
					itemQuality = nil, itemLevel = nil,
					itemLocked = nil,
				})
			end
		end
	end
	SlotNum.Free = #BagFree
	SlotNum.Total = SlotNum.Free + #Bag
end

local function Remove_BagItem(frame)
	for i, v in ipairs(Bag) do
		local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered = GetContainerItemInfo(v.bagID, v.slotID)
		if texture then
			local _, itemID = strsplit(":", itemLink)
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
			if (itemType == ITEMCLASS_Weapon) or (itemType == ITEMCLASS_Armor) then
				--local itemRealLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemLink)
				--local itemRealLevel = select(2, LibItemInfo:GetItemInfo(itemLink))
				local itemRealLevel = select(2, LibItemInfo:GetContainerItemLevel(v.bagID, v.slotID))
				itemLevel = itemRealLevel or itemLevel
			end
			itemType = itemType or "Other"
			if not ITEMCLASS[itemType] then
				itemType = "Other"
			end
			if quality == 0 then
				itemType = "Sale"
			end
			if itemType == ITEMCLASS_Consumable then
				if ITEMCLASS.Elixir.SubClass[itemSubType] then
					itemType = "Elixir"
				end
				if ITEMCLASS.Food.SubClass[itemSubType] then
					itemType = "Food"
				end
			end
			if ITEMCLASS.Hearthstone.itemID[itemID] then
				itemType = "Hearthstone"
			end
			v.itemName = itemName
			v.itemID = itemID
			v.itemTexture = texture
			v.itemCount = itemCount
			v.itemType = itemType
			v.itemSubType = itemSubType
			v.itemEquipLoc = itemEquipLoc
			v.itemQuality = quality
			v.itemLevel = itemLevel
			v.itemLocked = locked
		else
			tremove(Bag, i)
			tinsert(BagFree, {
				bagID = v.bagID, slotID = v.slotID, 
				itemName = nil, itemID = nil,
				itemTexture = nil, itemCount = 0, 
				itemType = nil, itemSubType = nil, 
				itemQuality = nil, itemLevel = nil,
				itemLocked = nil,
			})
		end
	end
	SlotNum.Free = #BagFree
	for i, v in ipairs(BagFree) do
		local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered = GetContainerItemInfo(v.bagID, v.slotID)
		if texture then
			local _, itemID = strsplit(":", itemLink)
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
			if (itemType == ITEMCLASS_Weapon) or (itemType == ITEMCLASS_Armor) then
				--local itemRealLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemLink)
				--local itemRealLevel = select(2, LibItemInfo:GetItemInfo(itemLink))
				local itemRealLevel = select(2, LibItemInfo:GetContainerItemLevel(v.bagID, v.slotID))
				itemLevel = itemRealLevel or itemLevel
			end
			itemType = itemType or "Other"
			if not ITEMCLASS[itemType] then
				itemType = "Other"
			end
			if quality == 0 then
				itemType = "Sale"
			end
			if itemType == ITEMCLASS_Consumable then
				if ITEMCLASS.Elixir.SubClass[itemSubType] then
					itemType = "Elixir"
				end
				if ITEMCLASS.Food.SubClass[itemSubType] then
					itemType = "Food"
				end
			end
			if ITEMCLASS.Hearthstone.itemID[itemID] then
				itemType = "Hearthstone"
			end
			v.itemName = itemName
			v.itemID = itemID
			v.itemTexture = texture
			v.itemCount = itemCount
			v.itemType = itemType
			v.itemSubType = itemSubType
			v.itemEquipLoc = itemEquipLoc
			v.itemQuality = quality
			v.itemLevel = itemLevel
			v.itemLocked = locked
			SlotNum.Free = SlotNum.Free - 1
		else
			v.itemName = nil
			v.itemID = nil
			v.itemTexture = nil
			v.itemCount = nil
			v.itemType = nil
			v.itemSubType = nil
			v.itemEquipLoc = nil
			v.itemQuality = nil
			v.itemLevel = nil
			v.itemLocked = nil
		end
	end
end

local function Remove_BagFreeItem(frame)
	for i, v in ipairs(BagFree) do
		local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered = GetContainerItemInfo(v.bagID, v.slotID)
		if texture then
			local _, itemID = strsplit(":", itemLink)
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
			if (itemType == ITEMCLASS_Weapon) or (itemType == ITEMCLASS_Armor) then
				--local itemRealLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemLink)
				--local itemRealLevel = select(2, LibItemInfo:GetItemInfo(itemLink))
				local itemRealLevel = select(2, LibItemInfo:GetContainerItemLevel(v.bagID, v.slotID))
				itemLevel = itemRealLevel or itemLevel
			end
			itemType = itemType or "Other"
			if not ITEMCLASS[itemType] then
				itemType = "Other"
			end
			if quality == 0 then
				itemType = "Sale"
			end
			if itemType == ITEMCLASS_Consumable then
				if ITEMCLASS.Elixir.SubClass[itemSubType] then
					itemType = "Elixir"
				end
				if ITEMCLASS.Food.SubClass[itemSubType] then
					itemType = "Food"
				end
			end
			if ITEMCLASS.Hearthstone.itemID[itemID] then
				itemType = "Hearthstone"
			end
			v.itemName = itemName
			v.itemID = itemID
			v.itemTexture = texture
			v.itemCount = itemCount
			v.itemType = itemType
			v.itemSubType = itemSubType
			v.itemEquipLoc = itemEquipLoc
			v.itemQuality = quality
			v.itemLevel = itemLevel
			v.itemLocked = locked
		end
	end
	SlotNum.Free = #BagFree
end

local function FullUpdate_BagItem(frame)
	Insert_BagItem(frame)
	Sort_BagItem(Bag)
	Update_BagItem(frame)
	Pos_BagItem(frame, frame.Bags)
end

local function LimitedUpdate_BagItem(frame)
	Remove_BagItem(frame)
	Sort_BagItem(Bag)
	Sort_BagItem(BagFree)
	Update_BagItem(frame)
	Pos_BagItem(frame, frame.Bags)
end

local function ManualUpdate_BagItem(frame)
	Remove_BagFreeItem(frame)
	Sort_BagItem(Bag)
	Update_BagItem(frame)
	Pos_BagItem(frame, frame.Bags)
end

local function Update_ItemLock(self, ...)
	if (not (self and self:IsShown())) then return end
	local bagID, slotID = ...
	if bagID and slotID and self["Bag"..bagID] and self["Bag"..bagID]["Slot"..slotID] then
		local _, _, locked, quality = GetContainerItemInfo(bagID, slotID)
		local button = self["Bag"..bagID]["Slot"..slotID]
		SetItemButtonDesaturated(button, locked, 0.5,0.5,0.5)
		if locked then
			if quality and (quality > 1) then
				button.QualityIcon: SetVertexColor(0.5,0.5,0.5)
				button.Border: SetBackdropBorderColor(0.5,0.5,0.5, 0.9)
			end
		else
			if quality and (quality > 1) then
				local color = ITEM_QUALITY_COLORS[quality]
				button.QualityIcon: SetVertexColor(color.r,color.g,color.b)
				button.Border: SetBackdropBorderColor(color.r,color.g,color.b, 0.9)
			end
		end
	end
end

local function Update_ItemCooldown(frame, ...)
	if (not frame) then return end
	local itemButton
	for bagID = BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		if _G[format("Quafe_Bag%s", bagID)] then
			for slotID = 1, ContainerFrame_GetContainerNumSlots(bagID)do
				local start, duration, enable = GetContainerItemCooldown(bagID, slotID)
				itemButton = _G[format("Quafe_Bag%sSlot%s", bagID, slotID)]
				if itemButton then
					CooldownFrame_Set(itemButton.cooldown, start, duration, enable)
					if duration > 0 and enable == 0 then
						SetItemButtonTextureVertexColor(itemButton, 0.4, 0.4, 0.4)
					else
						SetItemButtonTextureVertexColor(itemButton, 1, 1, 1)
					end
				end
			end
		end
	end
end

local function Update_ItemUpgradeIcons(frame)
	if F.IsClassic then return end
	local itemButton
	for bagID = BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		if _G[format("Quafe_Bag%s", bagID)] then
			for slotID = 1, ContainerFrame_GetContainerNumSlots(bagID)do
				itemButton = _G[format("Quafe_Bag%sSlot%s", bagID, slotID)]
				if itemButton then
					ContainerFrameItemButton_UpdateItemUpgradeIcon(itemButton)
				end
			end
		end
	end
end

local function Search_BagItem(frame, ...)
	if (not (frame and frame:IsShown())) then return end
	local itemButton
	for bagID = 0, NUM_BAG_SLOTS do
		for slotID = 1, ContainerFrame_GetContainerNumSlots(bagID) do
			local _, _, _, quality, _, _, _, isFiltered = GetContainerItemInfo(bagID, slotID)
			itemButton = frame["Bag"..bagID]["Slot"..slotID]
			if itemButton then
				if isFiltered then
					SetItemButtonDesaturated(item, 1)
					itemButton:SetAlpha(0.4)
					--itemButton.searchOverlay:Show();
					if quality and (quality > 1) then
						itemButton.QualityIcon: SetVertexColor(0.5,0.5,0.5)
						itemButton.Border: SetBackdropBorderColor(0.5,0.5,0.5, 0.9)
					end
				else
					SetItemButtonDesaturated(item)
					itemButton:SetAlpha(1)
					--itemButton.searchOverlay:Hide();
					if quality and (quality > 1) then
						local color = ITEM_QUALITY_COLORS[quality]
						itemButton.QualityIcon: SetVertexColor(color.r,color.g,color.b)
						itemButton.Border: SetBackdropBorderColor(color.r,color.g,color.b, 0.9)
					end
				end
			end
		end
	end
end

--- ------------------------------------------------------------
--> Currency
--- ------------------------------------------------------------

local function Currency_Frame(f)
	local currency = CreateFrame("Frame", nil, f)
	currency: SetSize((config.buttonSize+config.buttonGap*2)*config.perLine+config.border*2, 48)
	currency: SetPoint("TOP", f, "TOP", 0,0)
	F.create_Backdrop(currency, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0.9)
	f.Currency = currency

	local money = F.create_Font(currency, C.Font.NumOW, 21, nil, 1, "RIGHT", "CENTER")
	money: SetTextColor(F.Color(C.Color.Y2, 1))
	money: SetSize(180,14)
	money: SetPoint("RIGHT", currency, "RIGHT", -33,0)
	f.Currency.Money = money

	local MoneyHelp = CreateFrame("Button", nil, currency)
	MoneyHelp: SetAllPoints(money)
	MoneyHelp.List = {}
	MoneyHelp.Total = 0
	MoneyHelp: SetScript("OnEnter", function(self)
		if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Gold then
			wipe(self.List)
			self.Total = 0
			for k,v in pairs(Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Gold) do
				self.Total = self.Total + v.Gold
				tinsert(self.List, v)
			end
			table.sort(self.List, function(v1, v2)
				return v1.Gold > v2.Gold 
			end)
			GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
			GameTooltip:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0,-10)
			GameTooltip:AddDoubleLine(TOTAL, format("%s%s", self.Total, F.Hex(C.Color.Y2).."G|r"), 1,1,1,1,1,1)
			--GameTooltip:SetText(format(GOLD_AMOUNT_TEXTURE, self.Total), 1,1,1)
			GameTooltip:AddLine(" ")
			for i = 1,#self.List do
				if i <= 20 then
					GameTooltip:AddDoubleLine(self.List[i]["Name"].."-"..self.List[i]["Realm"], format("%s%s", self.List[i]["Gold"],F.Hex(C.Color.Y2).."G|r"), 1, 1, 1, 1, 1, 1)
				end
			end
			GameTooltip: Show()
		end
	end)
	MoneyHelp: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	local closebutton = CreateFrame("Button", nil, currency)
	closebutton: SetSize(24,30)
	closebutton: SetPoint("RIGHT", currency, "RIGHT", -2,0)
	closebutton: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	F.create_Backdrop(closebutton, 0, 0, 0, C.Color.Y1,0, C.Color.W1,0)
	
	local closebuttonicon = F.create_Font(closebutton, C.Font.NumOW, 21, nil, 0, "CENTER", "CENTER")
	closebuttonicon: SetPoint("CENTER", closebutton, "CENTER", 0,0)
	closebuttonicon: SetTextColor(F.Color(C.Color.W3))
	closebuttonicon: SetText("X")
	
	closebutton: SetScript("OnClick", function(self, button)
		f:Hide()
	end)
	closebutton: SetScript("OnEnter", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Y1,1))
		closebuttonicon: SetTextColor(F.Color(C.Color.Config.Back))
	end)
	closebutton: SetScript("OnLeave", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Config.Exit,0))
		closebuttonicon: SetTextColor(F.Color(C.Color.W3))
	end)
	
	local menubutton = CreateFrame("Button", nil, currency)
	menubutton: SetSize(24,30)
	menubutton: SetPoint("LEFT", currency, "LEFT", 2,0)
	F.create_Backdrop(menubutton, 0, 0, 0, C.Color.Y1,0, C.Color.W1,0)
	
	local menubuttonicon = F.create_Texture(menubutton, "ARTWORK", "Bag_Menu", C.Color.W3, 1)
	menubuttonicon: SetSize(24,30)
	menubuttonicon: SetTexCoord(4/32,28/32, 1/32,31/32)
	menubuttonicon: SetPoint("CENTER", menubutton, "CENTER", 0,0)
	
	menubutton: SetScript("OnClick", function(self, button)
		if f.Extra then
			if f.Extra: IsShown() then
				f.Extra: Hide()
			else
				f.Extra: Show()
			end
		end
	end)
	menubutton: SetScript("OnEnter", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Y1,1))
		menubuttonicon: SetVertexColor(F.Color(C.Color.Config.Back))
	end)
	menubutton: SetScript("OnLeave", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Config.Exit,0))
		menubuttonicon: SetVertexColor(F.Color(C.Color.W3))
	end)
end

local function BagExtra_Frame(f)
	local bagextra = CreateFrame("Frame", "Quafe_BagExtra", f)
	bagextra: SetSize((config.buttonSize+config.buttonGap*2)*config.perLine+config.border*2, 36)
	bagextra: SetPoint("BOTTOM", f, "TOP", 0,2)
	F.create_Backdrop(bagextra, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0.9)
	bagextra: Hide()
	f.Extra = bagextra
	
	local editbox = CreateFrame("EditBox", "Quafe_BagEditBox", bagextra, "BagSearchBoxTemplate")
	editbox: SetSize(120,16)
	editbox: SetPoint("LEFT", bagextra, "LEFT", 35,0)
	editbox: SetAutoFocus(false)
	editbox.Left: Hide()
	editbox.Middle: Hide()
	editbox.Right: Hide()
	F.create_Backdrop(editbox, 6, 8, 6, C.Color.W2,0, C.Color.W4,0.9)

	local AddSlotButton = CreateFrame("Button", nil, bagextra)
	AddSlotButton: SetSize(24,24)
	AddSlotButton: SetPoint("LEFT", editbox, "RIGHT", 16, 0)
	AddSlotButton: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	F.create_Backdrop(AddSlotButton, 2, 8, 4, C.Color.Y1,0, C.Color.W4,0.9)
	AddSlotButton.Bg: SetAlpha(0)
	AddSlotButton.tooltipText = BACKPACK_AUTHENTICATOR_INCREASE_SIZE

	local AddSlotButtonIcon = AddSlotButton:CreateTexture(nil, "ARTOWRK")
	AddSlotButtonIcon: SetTexture(F.Path("Bag_Button3"))
	AddSlotButtonIcon: SetSize(18,18)
	AddSlotButtonIcon: SetPoint("CENTER", AddSlotButton, "CENTER", 0,0)
	AddSlotButtonIcon: SetVertexColor(F.Color(C.Color.W3))

	AddSlotButton: RegisterEvent("BAG_OPEN")
	AddSlotButton: RegisterEvent("BAG_UPDATE")
	AddSlotButton: SetScript("OnEvent", function(self, event, ...)
		local size = ContainerFrame_GetContainerNumSlots(0)
		local extended = size > BACKPACK_BASE_SIZE
		if extended then
			AddSlotButton: Hide()
		else
			AddSlotButton: Show()
		end
	end)

	AddSlotButton: SetScript("OnClick", function(self, button, ...)
		StaticPopup_Show("BACKPACK_INCREASE_SIZE")
		ContainerFrame_SetBackpackForceExtended(true)
	end)

	AddSlotButton: SetScript("OnEnter", function(self)
		self.Bg: SetAlpha(1)
		if self.tooltipText then
			GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
			GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0,4)
			GameTooltip:SetText(self.tooltipText)
			GameTooltip:Show()
		end
	end)
	AddSlotButton: SetScript("OnLeave", function(self)
		self.Bg: SetAlpha(0)
		GameTooltip:Hide()
	end)
	
	local lastbutton
	for bagID = 0, NUM_BAG_SLOTS do
		local button
		if F.IsClassic then
			if bagID == 0 then
				button = CreateFrame("CheckButton", "Quafe_BagBackpack", bagextra, "Quafe_BackpackButtonClassicTemplate")
				
			else
				button = CreateFrame("CheckButton", "Quafe_BagBag"..(bagID-1).."Slot", bagextra, "Quafe_BagSlotButtonClassicTemplate")
			end
		else
			if bagID == 0 then
				button = CreateFrame("ItemButton", "Quafe_BagBackpack", bagextra, "Quafe_BackpackButtonTemplate")
			else
				--local button = CreateFrame("CheckButton", "Quafe_BagButton"..bagID, bagextra, "ItemButtonTemplate")
				button = CreateFrame("ItemButton", "Quafe_BagBag"..(bagID-1).."Slot", bagextra, "Quafe_BagSlotButtonTemplate")
			end
		end
		button: SetSize(24,24)
		local invID
		if bagID == 0 then
			invID = bagID
			button: SetPoint("RIGHT", bagextra, "RIGHT", -33-30*4,0)
		else
			invID = ContainerIDToInventoryID(bagID)
			button: SetPoint("LEFT", lastbutton, "RIGHT", 6,0)
		end
		button.invID = invID
		button.bagID = bagID
		button: SetID(invID)
		
		button: SetNormalTexture("")
		button.icon: SetAllPoints(button)
		button.icon: SetTexCoord(0.1,0.9, 0.1,0.9)
		
		button.Border = CreateFrame("Frame", nil, button)
		button.Border: SetFrameLevel(button:GetFrameLevel()+1)
		button.Border: SetAllPoints(button)

		Create_ButtonBg(button.Border, 1, 0)
		button.Border: SetBackdropColor(F.Color(C.Color.W1, 0))
		button.Border: SetBackdropBorderColor(F.Color(C.Color.W4, 0.9))

		if button.IconBorder then
			--button.IconBorder: SetTexture("")
			--button.IconBorder: Hide()
			button.IconBorder: SetAlpha(0)
		end
		
		--button: RegisterForDrag("LeftButton", "RightButton")
		--button: RegisterForClicks("anyUp")
		--[[
		button: SetScript("OnClick", function(self, btn)
			if(PutItemInBag(self.invID)) then return end
			if not IsShiftKeyDown() then
				PickupBagFromSlot(self.invID)
			end
		end)
		button: SetScript("OnReceiveDrag", function(self)
			if(PutItemInBag(self.invID)) then return end
			if not IsShiftKeyDown() then
				PickupBagFromSlot(self.invID)
			end
		end)
		button: SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			if ( GameTooltip:SetInventoryItem("player", self:GetID()) ) then
				local bindingKey = GetBindingKey("TOGGLEBAG"..(4 -  (self:GetID() - CharacterBag0Slot:GetID())))
				if ( bindingKey ) then
					GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..bindingKey..")"..FONT_COLOR_CODE_CLOSE)
				end
				GameTooltip: Show()
			else
				GameTooltip:SetText(EQUIP_CONTAINER, 1.0, 1.0, 1.0)
			end
		end)
		button: SetScript("OnLeave", function(self)
			GameTooltip: Hide()
		end)
		--]]
		lastbutton = button
		f.Extra["Bag"..bagID] = button
	end
	
	f.Extra: RegisterEvent("BAG_UPDATE")
	--f.Extra: RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	f.Extra: RegisterEvent("ITEM_LOCK_CHANGED")
	f.Extra: SetScript("OnEvent", function(self, event, ...)
		for bagID = 0, NUM_BAG_SLOTS do
			if bagID == 0 then
				f.Extra["Bag"..bagID].icon:SetTexture([[Interface\Buttons\Button-Backpack-Up]])
			else
				local icon = GetInventoryItemTexture("player", f.Extra["Bag"..bagID].invID)
				f.Extra["Bag"..bagID].icon:SetTexture(icon or [[Interface\Paperdoll\UI-PaperDoll-Slot-Bag]])
			end
			f.Extra["Bag"..bagID].icon:SetDesaturated(IsInventoryItemLocked(f.Extra["Bag"..bagID].invID))
		end
	end)
end

--- ------------------------------------------------------------
--> Can I Mog it
--- ------------------------------------------------------------

local CIMI_Load = false
local function CanIMogIt_Load()
	if IsAddOnLoaded("CanIMogIt") and (not CIMI_Load) then
		--> UpdateIcon functions
		function QuafeItemButton_CIMIUpdateIcon(self)
			if not self or not self:GetParent() then return end
			if not CIMI_CheckOverlayIconEnabled(self) then
				self.CIMIIconTexture:SetShown(false)
				self:SetScript("OnUpdate", nil)
				return
			end
			local bag = self:GetParent().bagID
			local slot = self:GetParent().slotID
			CIMI_SetIcon(self, QuafeItemButton_CIMIUpdateIcon, CanIMogIt:GetTooltipText(nil, bag, slot))
		end
		
		--> Begin adding to frames
		function CIMI_QuafeAddFrame(event, addonName)
			if event ~= "PLAYER_LOGIN" and event ~= "BANKFRAME_OPENED" and not CIMIEvents[event] then return end
			-- Add to frames
			-- Bags
			for bagID = BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
				for slotID = 1, MAX_CONTAINER_ITEMS do
					local frame = _G["Quafe_Bag"..bagID.."Slot"..slotID]
					if frame then
						CIMI_AddToFrame(frame, QuafeItemButton_CIMIUpdateIcon)
					end
				end
			end
			--C_Timer.After(.5, function() CIMI_QuafeAddFrame() end)
		end
		CanIMogIt.frame:AddEventFunction(CIMI_QuafeAddFrame)
		
		--> Event functions
		function CIMI_QuafeUpdate(self, event, ...)
			--CIMI_QuafeAddFrame(nil, "BANKFRAME_OPENED")
			for bagID = BANK_CONTAINER, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
				for slotID = 1, MAX_CONTAINER_ITEMS do
					local frame = _G["Quafe_Bag"..bagID.."Slot"..slotID]
					if frame then
						QuafeItemButton_CIMIUpdateIcon(frame.CanIMogItOverlay)
					end
				end
			end
		end
		--CanIMogIt: RegisterMessage("ResetCache", CIMI_QuafeUpdate)
		
		--function CIMI_QuafeEvents(self, event, ...)
		function CIMI_QuafeEvents(event)
			-- Update based on wow events
			if not CIMIEvents[event] then return end
			CIMI_QuafeUpdate()
		end
		--hooksecurefunc(CanIMogIt.frame, "ItemOverlayEvents", CIMI_QuafeEvents)
		CanIMogIt.frame:AddOverlayEventFunction(CIMI_QuafeEvents)

		--C_Timer.After(15, function() CanIMogIt:ResetCache() end)
		CIMI_Load = true
	end
	--[[
	function Quafe_UpdateAfter()
        C_Timer.After(.5, function() CIMI_QuafeAddFrame(nil, "PLAYER_LOGIN") end)
        C_Timer.After(.5, function() CanIMogIt.frame:ItemOverlayEvents("BAG_UPDATE") end)
    end
	--]]
end
--[[
local function CIMI_LoadCheck()
	if IsAddOnLoaded("CanIMogIt") then
		Update_CIMI = function(button)
			CIMI_AddToFrame(button, ContainerFrameItemButton_CIMIUpdateIcon)
			ContainerFrameItemButton_CIMIUpdateIcon(button.CanIMogItOverlay)
		end
	end
end
--]]
--- ------------------------------------------------------------
--> Bag Frame
--- ------------------------------------------------------------

local function PlayerMoney_Update(frame)
	local money = GetMoney()
	local gold = floor(abs(money / 10000))
	local silver = floor(abs(mod(money / 100, 100)))
	local copper = floor(abs(mod(money, 100)))
	frame.Currency.Money: SetText(format("%s%s%s%s%s%s", gold,"|cff616161G|r",silver,"|cff616161S|r",copper,"|cff616161C|r"))

	if C.PlayerGuid and C.PlayerName and C.PlayerRealm then
		if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Gold[C.PlayerGuid] then
			Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Gold[C.PlayerGuid]["Gold"] = floor(abs(money / 10000))
		else
			Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Gold[C.PlayerGuid] = {
				Name = C.PlayerName,
				Realm = C.PlayerRealm,
				Class = C.PlayerClass,
				Gold = floor(abs(money / 10000)),
			}
		end
	end
end

local function Bag_Frame(frame)
	local BagFrame = CreateFrame("Frame", "Quafe_BagFrame", UIParent)
	BagFrame: SetFrameStrata("HIGH")
	BagFrame: SetFrameLevel(2)
	BagFrame: SetSize((config.buttonSize+config.buttonGap*2)*config.perLine+config.border*2, 48)
	--BagFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -40,-240)
	BagFrame: SetPoint("RIGHT", UIParent, "RIGHT", -80,0)
	table.insert(UISpecialFrames, "Quafe_BagFrame");

	function BagFrame: FullUpdate_BagItem()
		FullUpdate_BagItem(self)
	end
	
	BagFrame: SetClampedToScreen(true)
	BagFrame: SetMovable(true)
	BagFrame: SetUserPlaced(true)

	frame.BagFrame = BagFrame

	Currency_Frame(frame.BagFrame)
	BagExtra_Frame(frame.BagFrame)

	local bags = CreateFrame("Frame", nil, frame.BagFrame)
	bags: SetSize((config.buttonSize+config.buttonGap*2)*config.perLine+config.border*2, config.buttonSize+config.border*2)
	bags: SetPoint("TOP", frame.BagFrame.Currency, "BOTTOM", 0,-2)
	F.create_Backdrop(bags, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0.9)
	frame.BagFrame.Bags = bags
	
	Init_ItemClass()
	Init_BagGap(frame.BagFrame, ITEMCLASS)
	Insert_BagItem(frame.BagFrame)

	frame.BagFrame.Currency: EnableMouse(true)
	frame.BagFrame.Currency: RegisterForDrag("LeftButton","RightButton")
	frame.BagFrame.Currency: SetScript("OnDragStart", function(self) frame.BagFrame:StartMoving() end)
	frame.BagFrame.Currency: SetScript("OnDragStop", function(self) frame.BagFrame:StopMovingOrSizing() end)

	local function Bag_Toggle()
		if frame.BagFrame: IsShown() then
			frame.BagFrame: Hide()
		else
			frame.BagFrame: Show()
		end
	end

	local function Bag_Open()
		frame.BagFrame:Show()
	end

	local function Bag_Close()
		frame.BagFrame:Hide()
	end

	frame.BagFrame: RegisterEvent("PLAYER_LOGIN")
	frame.BagFrame: RegisterEvent("PLAYER_ENTERING_WORLD")
	--frame.BagFrame: RegisterEvent("BAG_OPEN");
	--frame.BagFrame: RegisterEvent("BAG_CLOSED");
	--frame.BagFrame: RegisterEvent("QUEST_ACCEPTED");
	--frame.BagFrame: RegisterEvent("UNIT_QUEST_LOG_CHANGED");
	frame.BagFrame: RegisterEvent("UNIT_INVENTORY_CHANGED")
	if not F.IsClassic then
		frame.BagFrame: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	end
	frame.BagFrame: RegisterEvent("BAG_UPDATE")
	frame.BagFrame: RegisterEvent("BAG_UPDATE_DELAYED")
	frame.BagFrame: RegisterEvent("BAG_NEW_ITEMS_UPDATED")
	frame.BagFrame: RegisterEvent("ITEM_LOCK_CHANGED")
	--frame.BagFrame: RegisterEvent("ITEM_UNLOCKED")
	frame.BagFrame: RegisterEvent("BAG_UPDATE_COOLDOWN")
	frame.BagFrame: RegisterEvent("INVENTORY_SEARCH_UPDATE")
	frame.BagFrame: RegisterEvent("PLAYER_MONEY")
	frame.BagFrame: SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_LOGIN" then
			self:Hide()
			--ToggleBag = Bag_Toggle
			ToggleAllBags = Bag_Toggle
			ToggleBackpack = Bag_Toggle
			OpenBag = Bag_Open
			OpenAllBags = Bag_Open
			OpenBackpack = Bag_Open
			CloseAllBags = Bag_Close
			CloseBackpack = Bag_Close
		elseif event == "PLAYER_ENTERING_WORLD" then
			FullUpdate_BagItem(self)
			PlayerMoney_Update(self)
		elseif event == "PLAYER_MONEY" then
			PlayerMoney_Update(self)
		elseif event == "BAG_OPEN" then

		elseif event == "BAG_CLOSED" then

		elseif event == "BAG_UPDATE" then
			if self:IsShown() then
				if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Manual" then
					LimitedUpdate_BagItem(self)
				elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Closing" then
					LimitedUpdate_BagItem(self)
				elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Always" then
					FullUpdate_BagItem(self)
				end
			end
		elseif event == "BAG_UPDATE_DELAYED" then
			
		elseif event == "BAG_NEW_ITEMS_UPDATED" then
			Update_BagItem(self)
		elseif event == "UNIT_INVENTORY_CHANGED" then
			Update_ItemUpgradeIcons(self)
		elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
			Update_ItemUpgradeIcons(self)
		elseif event == "ITEM_LOCK_CHANGED" then
			Update_ItemLock(self, ...)
		elseif event == "BAG_UPDATE_COOLDOWN" then
			Update_ItemCooldown(self, ...)
		elseif event == "INVENTORY_SEARCH_UPDATE" then
			Search_BagItem(self, ...)
		end
	end)
	
	frame.BagFrame: SetScript("OnShow", function(self)
		if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Manual" then
			if self.FullUpdate then
				LimitedUpdate_BagItem(self)
			else
				FullUpdate_BagItem(self)
				C_Timer.After(2, function() FullUpdate_BagItem(self) end)
				self.FullUpdate = true
			end
		elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Closing" then
			if self.FullUpdate then
				LimitedUpdate_BagItem(self)
			else
				FullUpdate_BagItem(self)
				C_Timer.After(2, function() FullUpdate_BagItem(self) end)
				self.FullUpdate = true
			end
		elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Always" then
			if self.FullUpdate then
				FullUpdate_BagItem(self)
			else
				FullUpdate_BagItem(self)
				C_Timer.After(2, function() FullUpdate_BagItem(self) end)
				self.FullUpdate = true
			end
		end
		--Quafe_UpdateAfter()
	end)
	frame.BagFrame: SetScript("OnHide", function(self)
		if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Manual" then
			LimitedUpdate_BagItem(self)
		elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Closing" then
			FullUpdate_BagItem(self)
		elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Always" then
			FullUpdate_BagItem(self)
		end
	end)
end

--- ------------------------------------------------------------
--> Bank Frame
--- ------------------------------------------------------------

local Bank_BagID = {-3,-1,5,6,7,8,9,10,11}

local function Create_BankFrame(f, bagID)
	local button = CreateFrame("Button", "Quafe_Bag"..bagID, f)
	button: SetID(bagID)
	button.isBag = 1
	
	return button
end

local function Sort_ReagentItem(ItemTable)
	local function SortFunc(v1, v2)
		if v1.itemType ~= v2.itemType then
			return v1.itemType < v2.itemType
		elseif v1.itemSubType ~= v2.itemSubType then
			return v1.itemSubType < v2.itemSubType
		elseif v1.itemLevel ~= v2.itemLevel then
			return v1.itemLevel > v2.itemLevel
		elseif v1.itemID ~= v2.itemID then
			if v1.itemID and v2.itemID then
				return v1.itemID > v2.itemID
			elseif v1.itemID then
				return true
			elseif v2.itemID then
				return false
			else
				return v1.itemName < v2.itemName
			end
		else
			return v1.itemCount > v2.itemCount
		end
	end
	table.sort(ItemTable, SortFunc)
end

local function Update_BankItem(f)
	for k,v in ipairs(Bank) do
		Update_SlotItem(f["Bag"..v.bagID]["Slot"..v.slotID], v)
	end
	for k,v in ipairs(BankFree) do
		Update_SlotItem(f["Bag"..v.bagID]["Slot"..v.slotID], v)
	end
end

local function Update_ReagentItem(f)
	for k,v in ipairs(Reagent) do
		Update_SlotItem(f["Bag"..v.bagID]["Slot"..v.slotID], v)
	end
	for k,v in ipairs(ReagentFree) do
		Update_SlotItem(f["Bag"..v.bagID]["Slot"..v.slotID], v)
	end
end

local function Pos_BankItem(f, pos)
	local x,y
	local z = 0
	local it = ""
	BagGap_Reset(f, BANKITEMCLASS)
	for k,v in ipairs(Bank) do
		z = z + 1
		if it ~= v.itemType then
			it = v.itemType
			y = floor((z+config.bankperLine-1)/config.bankperLine) - 1
			x = z - y * config.bankperLine - 1
			f["BagIcon"..it]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
			f["BagIcon"..it]: Show()
			z = z + 1
		end
		y = floor((z+config.bankperLine-1)/config.bankperLine) - 1
		x = z - y * config.bankperLine - 1
		f["Bag"..v.bagID]["Slot"..v.slotID]: ClearAllPoints()
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetAlpha(1)
	end
	
	for k,v in ipairs(BankFree) do
		z = z + 1
		if k == 1 then
			y = floor((z+config.bankperLine-1)/config.bankperLine) - 1
			x = z - y * config.bankperLine - 1
			f["BagIconFree"]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
			f["BagIconFreeText"]: SetText(SlotNum.BankFree)
			f["BagIconFree"]: Show()
			z = z + 1
		end
		y = floor((z+config.bankperLine-1)/config.bankperLine) - 1
		x = z- y * config.bankperLine - 1
		f["Bag"..v.bagID]["Slot"..v.slotID]: ClearAllPoints()
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetAlpha(1)
	end

	f.Bags: SetHeight((config.buttonSize+config.buttonGap*2)*ceil(z/config.bankperLine)+config.border*2)
	f: SetHeight((config.buttonSize+config.buttonGap*2)*ceil(z/config.bankperLine)+config.border*2+ 48+2)
end

local function Pos_ReagentItem(f, pos)
	local x,y
	local z = 0
	for k,v in ipairs(Reagent) do
		z = z + 1
		y = floor((z+config.reagentperLine-1)/config.reagentperLine) - 1
		x = z - y * config.reagentperLine - 1
		f["Bag"..v.bagID]["Slot"..v.slotID]: ClearAllPoints()
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetAlpha(1)
	end
	
	for k,v in ipairs(ReagentFree) do
		z = z + 1
		y = floor((z+config.reagentperLine-1)/config.reagentperLine) - 1
		x = z- y * config.reagentperLine - 1
		f["Bag"..v.bagID]["Slot"..v.slotID]: ClearAllPoints()
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetPoint("TOPLEFT", pos, "TOPLEFT", config.border+config.buttonGap+x*(config.buttonSize+config.buttonGap*2), -config.border-config.buttonGap-y*(config.buttonSize+config.buttonGap*2))
		f["Bag"..v.bagID]["Slot"..v.slotID]: SetAlpha(1)
	end

	pos: SetHeight((config.buttonSize+config.buttonGap*2)*ceil(z/config.reagentperLine)+config.border*2)
end

local function Insert_BankItem(f)
	wipe(Bank)
	wipe(BankFree)
	wipe(Reagent)
	wipe(ReagentFree)
	for _, b in ipairs(Bank_BagID) do
		if not f["Bag"..b] then
			f["Bag"..b] = Create_BankFrame(f, b)
			if b == REAGENTBANK_CONTAINER then
				f["Bag"..b]: SetParent(f.Reagent)
			else
				f["Bag"..b]: SetParent(f.Bags)
			end
		end
		for s = 1, ContainerFrame_GetContainerNumSlots(b) do
			if not f["Bag"..b]["Slot"..s] then
				f["Bag"..b]["Slot"..s] = Create_BagItemButton(f["Bag"..b], b, s)
			end
			local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered = GetContainerItemInfo(b, s)
			if texture then
				local _, itemID = strsplit(":", itemLink)
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
				if b == REAGENTBANK_CONTAINER then
					itemType = itemType or "Other"
					itemSubType = itemSubType or "Other"
					insert(Reagent, {
						bagID = b, slotID = s, 
						itemName = itemName, itemID = itemID, 
						itemTexture = texture, itemCount = itemCount, 
						itemType = itemType, itemSubType = itemSubType, 
						itemQuality = quality, itemLevel = itemLevel,
						itemLocked = locked,
					})
				else
					if (itemType == ITEMCLASS_Weapon) or (itemType == ITEMCLASS_Armor) then
						--local itemRealLevel = LibItemUpgradeInfo:GetUpgradedItemLevel(itemLink)
						--local itemRealLevel = select(2, LibItemInfo:GetItemInfo(itemLink))
						local itemRealLevel = select(2, LibItemInfo:GetContainerItemLevel(b, s))
						itemLevel = itemRealLevel or itemLevel
					end
					itemType = itemType or "Other"
					if not BANKITEMCLASS[itemType] then
						itemType = "Other"
					end
					if quality == 0 then
						itemType = "Sale"
					end
					if itemType == ITEMCLASS_Consumable then
						if BANKITEMCLASS.Elixir.SubClass[itemSubType] then
							itemType = "Elixir"
						end
						if BANKITEMCLASS.Food.SubClass[itemSubType] then
							itemType = "Food"
						end
					end
					insert(Bank, {
						bagID = b, slotID = s, 
						itemName = itemName, itemID = itemID, 
						itemTexture = texture, itemCount = itemCount, 
						itemType = itemType, itemSubType = itemSubType, 
						itemQuality = quality, itemLevel = itemLevel,
						itemLocked = locked,
					})
				end
			else
				if b == REAGENTBANK_CONTAINER then
					insert(ReagentFree, {
						bagID = b, slotID = s, 
						itemName = nil, itemID = nil,
						itemTexture = nil, itemCount = 0, 
						itemType = nil, itemSubType = nil, 
						itemQuality = nil, itemLevel = nil,
						itemLocked = nil,
					})
				else
					insert(BankFree, {
						bagID = b, slotID = s, 
						itemName = nil, itemID = nil,
						itemTexture = nil, itemCount = 0, 
						itemType = nil, itemSubType = nil, 
						itemQuality = nil, itemLevel = nil,
						itemLocked = nil,
					})
				end
			end
		end
	end
	SlotNum.BankFree = #BankFree
	SlotNum.Bank = SlotNum.BankFree + #Bank
	SlotNum.ReagentFree = #ReagentFree
	SlotNum.Reagent = SlotNum.ReagentFree + #Reagent
end

local function FullUpdate_BankItem(f)
	Insert_BankItem(f)
	
	Sort_BagItem(Bank)
	Update_BankItem(f)
	Pos_BankItem(f, f.Bags)

	if not F.IsClassic then
		Sort_ReagentItem(Reagent)
		Update_ReagentItem(f)
		Pos_ReagentItem(f, f.Reagent)
	end
end

local function Search_BankItem(frame, ...)
	if (not frame and frame:IsShown()) then return end
	local itemButton
	for _, bagID in ipairs(Bank_BagID) do
		for slotID = 1, ContainerFrame_GetContainerNumSlots(bagID) do
			local _, _, _, quality, _, _, _, isFiltered = GetContainerItemInfo(bagID, slotID)
			itemButton = frame["Bag"..bagID]["Slot"..slotID]
			if itemButton then
				if isFiltered then
					SetItemButtonDesaturated(item, 1)
					itemButton:SetAlpha(0.4)
					--itemButton.searchOverlay:Show();
					if quality and (quality > 1) then
						itemButton.QualityIcon: SetVertexColor(0.5,0.5,0.5)
						itemButton.Border: SetBackdropBorderColor(0.5,0.5,0.5, 0.9)
					end
				else
					SetItemButtonDesaturated(item)
					itemButton:SetAlpha(1)
					--itemButton.searchOverlay:Hide();
					if quality and (quality > 1) then
						local color = ITEM_QUALITY_COLORS[quality]
						itemButton.QualityIcon: SetVertexColor(color.r,color.g,color.b)
						itemButton.Border: SetBackdropBorderColor(color.r,color.g,color.b, 0.9)
					end
				end
			end
		end
	end
end

local function Reagent_Frame(f)
	local Reagent = CreateFrame("Frame", "Quafe_BankReagent", f)
	Reagent: SetFrameLevel(5)
	Reagent: SetSize((config.buttonSize+config.buttonGap*2)*config.reagentperLine + config.border*2, 48)
	--Reagent: SetPoint("TOPLEFT", f, "TOPLEFT", 20, -68)
	Reagent: SetPoint("TOP", f.Extra, "BOTTOM", 0,-2)
	F.create_Backdrop(Reagent, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0.9)

	--reagent: SetClampedToScreen(true)
	--reagent: SetMovable(true)
	--reagent: SetUserPlaced(true)
	--reagent: EnableMouse(true)
	--reagent: RegisterForDrag("LeftButton","RightButton")
	--reagent: SetScript("OnDragStart", function(self) self:StartMoving() end)
	--reagent: SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	--[[
	local closebutton = CreateFrame("Button", nil, reagent)
	closebutton: SetSize(24,30)
	closebutton: SetPoint("TOPRIGHT", reagent, "TOPRIGHT", -2,-6)
	closebutton: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	F.create_Backdrop(closebutton, 0, 0, 0, C.Color.Config.Exit,0, C.Color.W1,0)
	
	local closebuttonicon = F.create_Font(closebutton, C.Font.NumOW, 21, nil, 0, "CENTER", "CENTER")
	closebuttonicon: SetPoint("CENTER", closebutton, "CENTER", 0,0)
	closebuttonicon: SetTextColor(F.Color(C.Color.W3))
	closebuttonicon: SetText("X")
	
	closebutton: SetScript("OnClick", function(self, button)
		reagent: Hide()
	end)
	closebutton: SetScript("OnEnter", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Config.Exit,1))
		closebuttonicon: SetTextColor(F.Color(C.Color.Config.Back))
	end)
	closebutton: SetScript("OnLeave", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Config.Exit,0))
		closebuttonicon: SetTextColor(F.Color(C.Color.W3))
	end)
	--]]

	local RegentUnlockInfo = CreateFrame("Frame", "Quafe_BankReagent.UnlockInfo", Reagent)
	RegentUnlockInfo: SetAllPoints(Reagent)
	RegentUnlockInfo: SetFrameLevel(18)
	RegentUnlockInfo: EnableMouse(true)
	F.create_Backdrop(RegentUnlockInfo, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0)

	local RegentUnlockInfoText = F.create_Font(RegentUnlockInfo, C.Font.Txt, 14, nil, 1, "CENTER", "CENTER")
	RegentUnlockInfoText: SetSize(512,32)
	RegentUnlockInfoText: SetPoint("BOTTOM", RegentUnlockInfo, "CENTER", 0, 0)
	RegentUnlockInfoText: SetText(REAGENTBANK_PURCHASE_TEXT)

	local RegentUnlockInfoTitle = F.create_Font(RegentUnlockInfo, C.Font.Txt, 22, nil, 1, "CENTER", "CENTER")
	RegentUnlockInfoTitle: SetSize(384,0)
	RegentUnlockInfoTitle: SetPoint("BOTTOM", RegentUnlockInfoText, "TOP", 0, 8)
	RegentUnlockInfoTitle: SetText(REAGENT_BANK)

	local RegentUnlockInfoCost = F.create_Font(RegentUnlockInfo, C.Font.Txt, 14, nil, 1, "RIGHT", "CENTER")
	RegentUnlockInfoCost: SetSize(384,21)
	RegentUnlockInfoCost: SetPoint("TOPRIGHT", RegentUnlockInfoText, "BOTTOM", -10, -8)
	RegentUnlockInfoCost: SetText(COSTS_LABEL)

	local RegentUnlockInfoPurchaseButton = CreateFrame("Button", nil, RegentUnlockInfo, "UIPanelButtonTemplate")
	RegentUnlockInfoPurchaseButton: SetSize(124,21)
	RegentUnlockInfoPurchaseButton: SetPoint("TOPLEFT", RegentUnlockInfoText, "BOTTOM", 10, -8)
	--RegentUnlockInfoPurchaseButton: SetFont(C.Font.Txt, 14, nil)
	RegentUnlockInfoPurchaseButton: SetText(BANKSLOTPURCHASE)
	RegentUnlockInfoPurchaseButton: SetScript("OnClick", function(self, button)
		PlaySound(852)
		StaticPopup_Show("CONFIRM_BUY_REAGENTBANK_TAB")
	end)

	Reagent: RegisterEvent("BANKFRAME_OPENED")
	Reagent: RegisterEvent("REAGENTBANK_PURCHASED")
	Reagent: SetScript("OnEvent", function(self, event)
		if event == "BANKFRAME_OPENED" then
			if(not IsReagentBankUnlocked()) then
				local cost = GetReagentBankCost()
				local gold = floor(abs(cost / 10000))
				local silver = floor(abs(mod(cost / 100, 100)))
				local copper = floor(abs(mod(cost, 100)))
				local hexcolor = F.Hex(C.Color.Y2)
				RegentUnlockInfoCost: SetText(format("%s%s%s%s%s%s%s", COSTS_LABEL, gold, hexcolor.."G|r",silver, hexcolor.."S|r",copper, hexcolor.."C|r"))
				RegentUnlockInfo: Show()
			else
				RegentUnlockInfo: Hide()
			end
		end
		if event == "REAGENTBANK_PURCHASED" then
			RegentUnlockInfo: Hide()
		end
	end)
	
	f.Reagent = Reagent
end

local function BankExtra_Frame(f)
	local bagextra = CreateFrame("Frame", "Quafe_BankExtra", f)
	bagextra: SetFrameLevel(3)
	bagextra: SetSize((config.buttonSize+config.buttonGap*2)*config.bankperLine+config.border*2, 48)
	bagextra: SetPoint("TOP", f, "TOP", 0,0)
	F.create_Backdrop(bagextra, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0.9)
	f.Extra = bagextra
	
	local editbox = CreateFrame("EditBox", "Quafe_BankEditBox", bagextra, "BagSearchBoxTemplate")
	editbox: SetSize(120,16)
	editbox: SetPoint("LEFT", bagextra, "LEFT", 35,0)
	editbox: SetAutoFocus(false)
	editbox.Left: Hide()
	editbox.Middle: Hide()
	editbox.Right: Hide()
	F.create_Backdrop(editbox, 6, 8, 6, C.Color.W2,0, C.Color.W4,0.9)
	
	if not F.IsClassic then
		local ToggleButton = Button_Template(bagextra)
		ToggleButton: SetPoint("LEFT", editbox, "RIGHT", 16, 0)
		ToggleButton.Icon: SetTexture(F.Path("Bag_Button1"))
		ToggleButton.tooltipText = REAGENT_BANK
		ToggleButton: SetScript("OnClick", function(self)
			--PlaySound(852)
			PlaySoundFile(F.Path("Sound\\Show.ogg"), "Master")
			if f.Bags:IsShown() then
				f.Bags: Hide()
				f.Reagent: Show()
				self.tooltipText = BANK
			else
				f.Bags: Show()
				f.Reagent: Hide()
				self.tooltipText = REAGENT_BANK
			end
			GameTooltip:SetText(self.tooltipText)
		end)
		
		local DepositButton = Button_Template(bagextra)
		DepositButton: SetPoint("LEFT", ToggleButton, "RIGHT", 2, 0)
		DepositButton.Icon: SetTexture(F.Path("Bag_Button2"))
		DepositButton.tooltipText = REAGENTBANK_DEPOSIT
		DepositButton: SetScript("OnClick", function(self)
			--PlaySound(852)
			PlaySoundFile(F.Path("Sound\\Show.ogg"), "Master")
			DepositReagentBank()
		end)
	end

--> Purchase
	local PurchaseButton = CreateFrame("Button", nil, bagextra)
	PurchaseButton: SetSize(24,24)
	if F.IsClassic then
		PurchaseButton: SetPoint("LEFT", editbox, "RIGHT", 16, 0)
	else
		PurchaseButton: SetPoint("LEFT", DepositButton, "RIGHT", 2, 0)
	end
	PurchaseButton: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	F.create_Backdrop(PurchaseButton, 2, 8, 4, C.Color.Y1,0, C.Color.W4,0.9)
	PurchaseButton.Bg: SetAlpha(0)
	PurchaseButton.tooltipText = BANKSLOTPURCHASE_LABEL

	local PurchaseButtonIcon = PurchaseButton:CreateTexture(nil, "ARTOWRK")
	PurchaseButtonIcon: SetTexture(F.Path("Bag_Button3"))
	PurchaseButtonIcon: SetSize(18,18)
	PurchaseButtonIcon: SetPoint("CENTER", PurchaseButton, "CENTER", 0,0)
	PurchaseButtonIcon: SetVertexColor(F.Color(C.Color.W3))

	PurchaseButton: RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	PurchaseButton: RegisterEvent("BANKFRAME_OPENED")
	PurchaseButton: SetScript("OnEvent", function(self, event, ...)
		local numSlots,full = GetNumBankSlots()
		local cost = GetBankSlotCost(numSlots)
		BankFrame.nextSlotCost = cost
		if (full) then
			self: Hide()
		else
			self: Show()
		end
	end)

	PurchaseButton: SetScript("OnClick", function(self, button, ...)
		PlaySound(852)
		StaticPopup_Show("CONFIRM_BUY_BANK_SLOT")
	end)
	
	PurchaseButton: SetScript("OnEnter", function(self)
		self.Bg: SetAlpha(1)
		if self.tooltipText then
			GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
			GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0,4)
			GameTooltip:SetText(self.tooltipText)
			GameTooltip:Show()
		end
		--self.Icon: SetVertexColor(F.Color(C.Color.Config.Back))
	end)
	PurchaseButton: SetScript("OnLeave", function(self)
		self.Bg: SetAlpha(0)
		GameTooltip:Hide()
		--self.Icon: SetVertexColor(F.Color(C.Color.W3))
	end)
	--StaticPopup_Show("CONFIRM_BUY_BANK_SLOT");
	--StaticPopup_Show("CONFIRM_BUY_REAGENTBANK_TAB")
	
	--> Close
	local closebutton = CreateFrame("Button", nil, bagextra)
	closebutton: SetSize(24,30)
	closebutton: SetPoint("RIGHT", bagextra, "RIGHT", -2,0)
	closebutton: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	F.create_Backdrop(closebutton, 0, 0, 0, C.Color.Config.Exit,0, C.Color.W1,0)
	
	local closebuttonicon = F.create_Font(closebutton, C.Font.NumOW, 21, nil, 0, "CENTER", "CENTER")
	closebuttonicon: SetPoint("CENTER", closebutton, "CENTER", 0,0)
	closebuttonicon: SetTextColor(F.Color(C.Color.W3))
	closebuttonicon: SetText("X")
	
	closebutton: SetScript("OnClick", function(self, button)
		f:Hide()
	end)
	closebutton: SetScript("OnEnter", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Y1,1))
		closebuttonicon: SetTextColor(F.Color(C.Color.Config.Back))
	end)
	closebutton: SetScript("OnLeave", function(self)
		self.Bg: SetBackdropColor(F.Color(C.Color.Config.Exit,0))
		closebuttonicon: SetTextColor(F.Color(C.Color.W3))
	end)
	
	--> Bank Slot
	local lastbutton
	for bagID = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		local button
		if F.IsClassic then
			button = CreateFrame("CheckButton", "Quafe_BankButton"..bagID, bagextra, "Quafe_BankSlotButtonClassicTemplate")
		else
			button = CreateFrame("ItemButton", "Quafe_BankButton"..bagID, bagextra, "Quafe_BankSlotButtonTemplate")
		end
		button: SetSize(24,24)
		if bagID == NUM_BAG_SLOTS+1 then
			button: SetPoint("RIGHT", bagextra, "RIGHT", -33-30*6,0)
		else
			button: SetPoint("LEFT", lastbutton, "RIGHT", 6,0)
		end
		
		local invID = BankButtonIDToInvSlotID(bagID-4, 1)
		button.invID = invID
		button.bagID = bagID
		button: SetID(bagID - 4)
		
		button: SetNormalTexture("")
		button.icon: SetAllPoints(button)
		button.icon: SetTexCoord(0.1,0.9, 0.1,0.9)
		
		button.Border = CreateFrame("Frame", nil, button)
		button.Border: SetFrameLevel(button:GetFrameLevel()+1)
		button.Border: SetAllPoints(button)

		Create_ButtonBg(button.Border, 1, 0)
		button.Border: SetBackdropColor(F.Color(C.Color.W1, 0))
		button.Border: SetBackdropBorderColor(F.Color(C.Color.W4, 0.9))

		if button.IconBorder then
			--button.IconBorder: SetTexture("")
			--button.IconBorder: Hide()
			button.IconBorder: SetAlpha(0)
		end

		--[[
		button: RegisterForDrag("LeftButton", "RightButton")
		button: RegisterForClicks("anyUp")
		
		button: SetScript("OnClick", function(self, btn)
			if(PutItemInBag(self.invID)) then return end
			if not IsShiftKeyDown() then
				PickupBagFromSlot(self.invID)
			end
		end)
		button: SetScript("OnReceiveDrag", function(self)
			if(PutItemInBag(self.invID)) then return end
			if not IsShiftKeyDown() then
				PickupBagFromSlot(self.invID)
			end
		end)
		button: SetScript("OnEnter", function(self)
			--GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
			GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0,4)
			if ( GameTooltip:SetInventoryItem("player", self:GetID()) ) then
				local bindingKey = GetBindingKey("TOGGLEBAG"..(4 -  (self:GetID() - CharacterBag0Slot:GetID())))
				if ( bindingKey ) then
					GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..bindingKey..")"..FONT_COLOR_CODE_CLOSE)
				end
			else
				--GameTooltip:SetText(EQUIP_CONTAINER, 1.0, 1.0, 1.0)
				GameTooltip:SetText(self.tooltipText, 1.0, 1.0, 1.0)
			end
			GameTooltip: Show()
		end)
		button: SetScript("OnLeave", function(self)
			GameTooltip: Hide()
		end)
		--]]
		lastbutton = button
		f.Extra["Bag"..bagID] = button
	end
	
	f.Extra: RegisterEvent("BAG_UPDATE")
	f.Extra: RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	f.Extra: RegisterEvent("BANKFRAME_OPENED")
	f.Extra: RegisterEvent("ITEM_LOCK_CHANGED")
	f.Extra: SetScript("OnEvent", function(self, event, ...)
		local numSlots,full = GetNumBankSlots()
		for bagID = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
			local icon = GetInventoryItemTexture("player", f.Extra["Bag"..bagID].invID)
			f.Extra["Bag"..bagID].icon: SetTexture(icon or [[Interface\Paperdoll\UI-PaperDoll-Slot-Bag]])
			f.Extra["Bag"..bagID].icon: SetDesaturated(IsInventoryItemLocked(f.Extra["Bag"..bagID].invID))
			if bagID <= NUM_BAG_SLOTS+numSlots then
				SetItemButtonTextureVertexColor(f.Extra["Bag"..bagID], 1.0,1.0,1.0);
				f.Extra["Bag"..bagID].tooltipText = BANK_BAG
			else
				SetItemButtonTextureVertexColor(f.Extra["Bag"..bagID], 1.0,0.1,0.1);
				f.Extra["Bag"..bagID].tooltipText = BANK_BAG_PURCHASE
			end
		end
	end)
end

local function Bank_Frame(f)
	local bank = CreateFrame("Frame", "Quafe_BankFrame", UIParent)
	bank: SetFrameStrata("HIGH")
	bank: SetFrameLevel(2)
	bank: SetSize((config.buttonSize+config.buttonGap*2)*config.bankperLine + config.border*2, 48)
	--bank: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20,-200)
	bank: SetPoint("LEFT", UIParent, "LEFT", 20,0)
	table.insert(UISpecialFrames, "Quafe_BankFrame");
	
	bank: SetClampedToScreen(true)
	bank: SetMovable(true)
	bank: SetUserPlaced(true)
	--bank: EnableMouse(true)
	--bank: RegisterForDrag("LeftButton","RightButton")
	--bank: SetScript("OnDragStart", function(self) self:StartMoving() end)
	--bank: SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	
	BankExtra_Frame(bank)
	if not F.IsClassic then
		Reagent_Frame(bank)
	end
	f.Bank = bank
	
	local bags = CreateFrame("Frame", nil, bank)
	bags: SetFrameLevel(3)
	bags: SetSize((config.buttonSize+config.buttonGap*2)*config.bankperLine+config.border*2, config.buttonSize+config.border*2)
	bags: SetPoint("TOP", bank.Extra, "BOTTOM", 0,-2)
	F.create_Backdrop(bags, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0.9)
	f.Bank.Bags = bags
	
	Init_BankItemClass()
	Init_BagGap(f.Bank, BANKITEMCLASS, f.Bank.Bags)
	Insert_BankItem(f.Bank)

	f.Bank.Extra: EnableMouse(true)
	f.Bank.Extra: RegisterForDrag("LeftButton","RightButton")
	f.Bank.Extra: SetScript("OnDragStart", function(self) f.Bank:StartMoving() end)
	f.Bank.Extra: SetScript("OnDragStop", function(self) f.Bank:StopMovingOrSizing() end)
	
	f.Bank: RegisterEvent("BANKFRAME_OPENED")
	f.Bank: RegisterEvent("BANKFRAME_CLOSED")
	f.Bank: RegisterEvent("PLAYER_LOGIN")
	f.Bank: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Bank: RegisterEvent("BAG_UPDATE")
	f.Bank: RegisterEvent("BAG_UPDATE_DELAYED")
	--f.Bank: RegisterEvent("BAG_NEW_ITEMS_UPDATED")
	f.Bank: RegisterEvent("ITEM_LOCK_CHANGED")
	f.Bank: RegisterEvent("BAG_UPDATE_COOLDOWN")
	f.Bank: RegisterEvent("INVENTORY_SEARCH_UPDATE")
	f.Bank: SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_LOGIN" then
			self:Hide()
			self.Bags:Show()
			if not F.IsClassic then
				self.Reagent:Hide()
			end
			BankFrame:UnregisterAllEvents()
			insert(UISpecialFrames, "BankFrame");
			--Quafe_UpdateAfter()
		elseif event == "PLAYER_ENTERING_WORLD" then
			FullUpdate_BankItem(self)
		elseif event == "BANKFRAME_OPENED" then
			self: Show()
			self.Bags:Show()
			if not F.IsClassic then
				self.Reagent:Hide()
			end
			FullUpdate_BankItem(self)
			C_Timer.After(2, function() FullUpdate_BankItem(self) end)
			--Quafe_UpdateAfter()
		elseif event == "BANKFRAME_CLOSED" then
			self: Hide()
		elseif event == "BAG_UPDATE" then
			if self:IsShown() then
				FullUpdate_BankItem(self)
			end
		elseif event == "ITEM_LOCK_CHANGED" then
			Update_ItemLock(self, ...)
		elseif event == "BAG_UPDATE_COOLDOWN" then
			Update_ItemCooldown(self, ...)
		elseif event == "INVENTORY_SEARCH_UPDATE" then
			Search_BankItem(self, ...)
		end
	end)

	f.Bank: SetScript("OnHide", function(self)
		StaticPopup_Hide("CONFIRM_BUY_BANK_SLOT")
		CloseBankFrame()
	end)
end

--- ------------------------------------------------------------
--> Container Frame
--- ------------------------------------------------------------

local Quafe_Container = CreateFrame("Frame", nil, E)
Quafe_Container.Init = false

local function Quafe_Container_Load()
	if F.IsAddonEnabled("EuiScript") then return end
	if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Enable then
		Bag_Frame(Quafe_Container)
		Bank_Frame(Quafe_Container)
		CanIMogIt_Load()
		--CIMI_LoadCheck()
		Quafe_Container.Init = true
	end
end

local function Quafe_Container_Toggle(arg)
	if arg == "ON" then
		Quafe_NoticeReload()
	elseif arg == "OFF" then
		Quafe_NoticeReload()
	end
end

local Quafe_Container_Config = {
	Database = {
		["Quafe_Container"] = {
			Enable = true,
			Gold = {},
			RefreshRate = "Closing", --Always, Closing, Manual
		},
	},

	Config = {
		Name = "Quafe "..L['BAG'],
		Type = "Switch",
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Enable = false
				self.Text:SetText(L["OFF"])
				Quafe_Container_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Enable = true
				self.Text:SetText(L["ON"])
				Quafe_Container_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['GROUP_REFRESH_RATE'],
				Type = "Dropdown",
				Click = function(self, button)
					
				end,
				Load = function(self)

				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container then
						if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Manual" then
							self.Text:SetText(L['手动刷新'])
						elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Closing" then
							self.Text:SetText(L['关闭时刷新'])
						elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate == "Always" then
							self.Text:SetText(L['实时刷新'])
						end
					end
				end,
				DropMenu = {
					[1] = {
						Text = L['手动刷新'],
						Click = function(self, button) 
							Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate = "Manual"
						end,
					},
					[2] = {
						Text = L['关闭时刷新'],
						Click = function(self, button) 
							Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate = "Closing"
						end,
					},
					[3] = {
						Text = L['实时刷新'],
						Click = function(self, button) 
							Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Container.RefreshRate = "Always"
						end,
					},
				},
			},
			[2] = {
				Name = L['重置金币数据'],
				Type = "Trigger",
				Click = function(self, button)
					wipe(Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Container"].Gold)
					DEFAULT_CHAT_FRAME:AddMessage("Quafe "..L['背包金币数据已重置'])
				end,
				Show = function(self)
					self.Text:SetText(L['CONFIRM'])
				end,
			},
		},
	},
}

Quafe_Container.Load = Quafe_Container_Load
Quafe_Container.Config = Quafe_Container_Config
tinsert(E.Module, Quafe_Container)
