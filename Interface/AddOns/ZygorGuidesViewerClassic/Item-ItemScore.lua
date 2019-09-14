local ZGV = ZygorGuidesViewer
if not ZGV then return end

local L = ZGV.L
local G = _G

local tinsert,tremove,print,ipairs,pairs,wipe=tinsert,tremove,print,ipairs,pairs,wipe
local Gratuity = LibStub("LibGratuity-3.0")

local ItemScore = ZGV.ItemScore
LibStub("AceHook-3.0"):Embed(ItemScore)

local item_weapon_types = ItemScore.Item_Weapon_Types
local item_armor_types = ItemScore.Item_Armor_Types
local item_gem_types = ItemScore.Item_Gem_Types

local ItemCache = {}
ItemScore.ItemCache = ItemCache

local function strip_link(itemlink)
	local _,itemstring,_ = itemlink:match("(.*)item:([0-9-:]*)(.*)")
	if itemstring then 	
		return "item:"..itemstring:gsub(":0:","::")
	end
	return false
end
ItemScore.strip_link = strip_link
	
function ItemScore:Initialise()
	-- apply lower armor types as viable
	for class,classrules in pairs(ItemScore.rules) do
		for spec,rule in pairs(classrules) do
			local stats = rule["stats"]
			local types = rule["itemtypes"]

			--stats.DAMAGE_PER_SECOND = stats.DPS stats.DPS = nil -- Switch DPS to the full string.

			-- players use only final armor types, so no fallbacks to lower ones anymore

			types["JEWELERY"] = 1 -- rings, trinkets, necklaces
		end
	end

	-- register all needed events
	self.eventFrame=CreateFrame("Frame")
	ZGV.ChainCall(self.eventFrame)
		:RegisterEvent("LOADING_SCREEN_DISABLED")

		:RegisterEvent("PLAYER_LEVEL_UP")
		--:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED") -- CLASSIC FIX disabled
		--:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED") -- CLASSIC FIX disabled
		:RegisterEvent("CHARACTER_POINTS_CHANGED") -- CLASSIC FIX added
		:RegisterEvent("SKILL_LINES_CHANGED") -- CLASSIC FIX added

		:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
		:RegisterEvent("BAG_UPDATE_DELAYED")

		:RegisterEvent("PLAYER_REGEN_DISABLED")
		:RegisterEvent("PLAYER_REGEN_ENABLED")

		:SetScript("OnEvent",function(self,event,...) ItemScore:OnEvent(event,...) end)
		:Show()

	-- create item popup
	ItemScore.Upgrades:CreatePopup()

	-- set up initial data
	ItemScore:RefreshUserData()
end

function ItemScore:OnEvent(event,arg1,arg2,...)
	--if event == "PLAYER_LEVEL_UP" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_SPECIALIZATION_CHANGED" then
	 -- CLASSIC FIX disabled
	if event == "PLAYER_LEVEL_UP" or event == "CHARACTER_POINTS_CHANGED" or  event == "SKILL_LINES_CHANGED" then
		-- using timer as delay, since in the same frame PLAYER_LEVEL_UP player is still on previous level
		-- and to run it only once, as both PLU and PSC can fire more than once
		ItemScore:DelayedRefreshUserData()
	elseif event == "LOADING_SCREEN_DISABLED" then -- user logged in, see what upgrades we have
		ItemScore.EquipTimer = ItemScore.EquipTimer or ZGV:ScheduleTimer(function() 
			ItemScore.Upgrades:ScoreEquippedItems()
			ItemScore.Upgrades:ScanBagsForUpgrades()
		end,0.5)
	elseif event == "PLAYER_EQUIPMENT_CHANGED" or event == "BAG_UPDATE_DELAYED" then -- bags or equipment changed, see what upgrades we have
		-- on timer to run it only once, since equip/unequip fires both events, and we would get spammed
		ItemScore.EquipTimer = ItemScore.EquipTimer or ZGV:ScheduleTimer(function() 
			ItemScore.Upgrades:ScoreEquippedItems()
			ItemScore.Upgrades:ScanBagsForUpgrades()
		end,0.5)
	elseif event == "PLAYER_REGEN_DISABLED" then -- combat started, kill all upgrade popups
		if ItemScore.Upgrades.EquipPopup then ItemScore.Upgrades.EquipPopup:Hide() end
	elseif event == "PLAYER_REGEN_ENABLED" then -- combat ended, check if anything is waiting for equip
		ItemScore.Upgrades:ProcessPossibleUpgrades()
	end

	if event == "PLAYER_EQUIPMENT_CHANGED" then
		--ItemScore.GearFinder:ClearResults()
	end
end

function ItemScore:DelayedRefreshUserData()
	ItemScore.RefreshTimer = ItemScore.RefreshTimer or ZGV:ScheduleTimer(function() 
		ItemScore:RefreshUserData()
		-- TODO: outleveled heirloom popup
	end,0.5)
end

function ItemScore:RefreshUserData()
	ItemScore.RefreshTimer = nil
	ItemScore:GetEquipmentSkills()
	ItemScore:SetStatWeights()
	ItemScore.Upgrades:ScoreEquippedItems()
	ItemScore.Upgrades:ScanBagsForUpgrades()
end

function ItemScore:SetStatWeights(playerclass,playerlevel)
	self.playerclass = playerclass or (select(2,UnitClass("player")))
	self.playerclassName = (select(1,UnitClass("player")))
	self.playerclassNum = (select(3,UnitClass("player")))
	self.playerlevel = playerlevel or UnitLevel("player")
	self.playerfaction = UnitFactionGroup("player")

	if not ZGV.db.profile.gear_active_build then
		local default,_ = next(ItemScore.rules[ItemScore.playerclass])
		ZGV.db.profile.gear_selected_build = default
		ZGV.db.profile.gear_active_build = default
	end
	local active_spec = ZGV.db.profile.gear_active_build or 1

	ZGV.db.char.badupgrade = ZGV.db.char.badupgrade or {}
	ItemScore.Upgrades.BadUpgrades = ZGV.db.char.badupgrade

	-- create a copy so that the arrays in datatables are left untouched, as we will need them to handle custom weights resets
	self.ActiveRuleSet = {
		itemtypes = {},
		stats = {},
		caps = {},
	}

	-- Copy values from our rules
	for i,v in pairs(ItemScore.rules[self.playerclass][active_spec].itemtypes) do self.ActiveRuleSet.itemtypes[i]=v end
	for i,v in pairs(ItemScore.rules[self.playerclass][active_spec].stats) do self.ActiveRuleSet.stats[i]=v end
	for i,v in pairs(ItemScore.rules[self.playerclass][active_spec].caps) do self.ActiveRuleSet.caps[i]=v end

	-- Update stats with users profile
	local saved_vars_prefix = "gear_"..self.playerclass.."_"..active_spec.."_"
	for index,stat in pairs(ZGV.ItemScore.Keywords) do
		if ZGV.db.profile[saved_vars_prefix..(stat.blizz)] then
			self.ActiveRuleSet.stats[(stat.blizz)]= tonumber(ZGV.db.profile[saved_vars_prefix..(stat.blizz)] or 0)
		end
	end

	-- Set dual wield 
	self.playerDualWield = false
	self.playerDualTwohanders = false
	if self.playerlevel>=10 and IsSpellKnown(674) then
		self.playerDualWield = true
	end

	-- if anything in user info has changed, all cached scores are no longer valid, and item stats could have changed due to level scaling
	-- wipe cached data, we are starting anew
	table.wipe(ItemCache)

	--ItemScore.GearFinder:ClearResults()
end

-- converts ITEM_MOD_CRIT_RATING_SHORT to CRIT
local name_cache = {}
function ItemScore:NormaliseStatName(statname)
	if name_cache[statname] then return name_cache[statname] end

	-- primary and secondary stats
	statname = statname:gsub("_RATING_SHORT$","")
	statname = statname:gsub("_SHORT$","")
	statname = statname:gsub("^ITEM_MOD_","")

	-- tertiary stats
	statname = statname:gsub("^CR_","")

	-- element resist gear
	statname = statname:gsub("_NAME$","")
	
	-- specific case: armor
	if statname=="RESISTANCE0" then statname="ARMOR" end

	name_cache[statname] = statname
	return statname
end

function ItemScore:GetItemDetails(itemlink)
	if not itemlink then return false end
	local itemlinkfull = itemlink
	itemlink = strip_link(itemlink)
	if not itemlink then return false end

	-- if item is not yet cached, grab its data
	if not ItemCache[itemlink] then
		-- that is a new one
		-- local stats = GetItemStats(itemlink) -- revert to this if blizzard starts sending data for X of Y suffix items
		local stats = {}
		local itemName,_,itemRarity,_,itemMinLevel,_,_,_,itemEquipLoc,texture,_,itemClassID,itemSubClassID = ZGV:GetItemInfo(itemlink) 
		local itemlvl,_,baseitemlvl = GetDetailedItemLevelInfo(itemlink) 
		if not (stats and itemName) then return false end

		-- class, spec check, and level check. we need to scan tooltip for those. meh.
		local playerclass, playerspec
		Gratuity:SetHyperlink(itemlink)
		if Gratuity:NumLines()==0 then return false end

		for num=1,Gratuity:NumLines() do
			local line=Gratuity:GetLine(num)

			if not line then break end
			local found_class = line:match( gsub(ITEM_CLASSES_ALLOWED,"%%s","(.*)")) 
			if found_class then playerclass = found_class end
			
			-- gg blizz. some of itemlink from encounter journal report min level 120, even if tooltips states 110. 
			local found_level = line:match( gsub(ITEM_MIN_LEVEL,"%%d","(.*)"))
			if found_level then itemMinLevel = tonumber(found_level) end

			for _,statdata in pairs(ItemScore.Keywords) do
				local sign,value = line:match(statdata.regex)
				if sign and not value then value = sign end
				if value then 
					stats[statdata.blizz] = tonumber(value)
				end
			end
		end

		-- ok, got everything, cache it
		ItemCache[itemlink] = { 
			stats = stats, 
			itemlink = itemlink,
			itemid = ZGV.ItemLink.GetItemID(itemlink),
			itemlinkfull = itemlinkfull,
			minlevel = itemMinLevel,
			type = itemEquipLoc,
			class = itemClassID,
			subclass = itemSubClassID,
			quality = itemRarity,
			validated = false,
			texture = texture,
			itemlvl = itemlvl,
			playerclass = playerclass,
		}

		local slot_1, slot_2, twohander = ItemScore:GetValidSlots(ItemCache[itemlink])
		ItemCache[itemlink].slot = slot_1
		ItemCache[itemlink].slot_2 = slot_2
		ItemCache[itemlink].twohander = twohander

	end
	return ItemCache[itemlink]
end

-- checks what slots can this item be equipped to. automatically called as part of GetItemDetails, but may be called as standalone
-- params:
--	item - array - item object
-- returns:
--	first slot - int/false - main slot for this item
--	second slot - int/false - optional second slot for the item (offhand, rings, trinkets)
--	twohander - bool - is item twohander
local function get_slots_by_type(type)
	if type=="INVTYPE_WEAPON" then return INVSLOT_MAINHAND,INVSLOT_OFFHAND end
	if type=="INVTYPE_2HWEAPON" then return INVSLOT_MAINHAND,INVSLOT_OFFHAND end
	if type=="INVTYPE_FINGER" then return INVSLOT_FINGER1,INVSLOT_FINGER2 end
	if type=="INVTYPE_TRINKET" then return INVSLOT_TRINKET1,INVSLOT_TRINKET2 end
	if type=="INVTYPE_RANGED" then return INVSLOT_RANGED,false end
	if type=="INVTYPE_RANGEDRIGHT" then return INVSLOT_RANGED,false end
	if type=="INVTYPE_THROWN" then return INVSLOT_RANGED,false end
	return ItemScore.TypeToSlot[type], false
end

local rogue_offhand_only = {
	[0] = "AXE",
	[4] = "MACE",
	[7] = "SWORD",
	[13] = "FIST",
	}

function ItemScore:GetValidSlots(item)
	if not item then return end
	local s1, s2 = get_slots_by_type(item.type)

	if item.type=="INVTYPE_WEAPON" and ItemScore.playerDualWield then -- dual wield, 1 handed weapons are valid in offhand
		return s1, s2, false
	end
	if item.type=="INVTYPE_2HWEAPON" then -- two handed items go into main hand slot
		return s1, false, true
	end
	if item.type=="INVTYPE_WEAPON" and not ItemScore.playerDualWield then -- no dual wield, 1 handed weapons are valid only in mainhand
		return s1, false, false
	end

	-- handle special cases
	-- CLASSIC TODO - what should be here? I don't know. 
	--[[
	if (self.playerclass=="ROGUE" and self.playerspec==3) and item.type=="INVTYPE_WEAPON" and rogue_offhand_only[item.subclass] then -- rogue sub, non dagger 1 handed weapons are valid in offhand only
		return s2, false, false
	end
	if (self.playerclass=="ROGUE" and self.playerspec==2) and item.type=="INVTYPE_WEAPON" and item.subclass==15 then -- rogue outlaw, daggers are mainhand only for low levels
		return s2, self.playerlevel<10 and s1, false
	end
	if (self.playerclass=="SHAMAN" and self.playerspec==2) and item.type=="INVTYPE_WEAPON" and item.subclass==15 then -- enhancment shaman, daggers are offhand only for low levels
		return s2, self.playerlevel<20 and s1, false
	end


	--]]

	-- rest is valid in proper slots
	return s1, s2, false
end

-- calculates item score based on item stats and current weights. result is cached
-- params:
--	itemlink - string - item that we are checking
-- return:
--	score - int - -1 or score of given item
--	whitescore - int - -1 or score of given item if item is statless poor or common quality
--	success - bool - was item scored at all
--	comment - string - description
function ItemScore:GetItemScore(itemlink,verbose)
	local item = ItemScore:GetItemDetails(itemlink)
	if not item then return -1, -1, false, "no info yet" end

	local stats = item.stats
	local score,whitescore = 0, 0
	local statweights = self.ActiveRuleSet.stats
	local caps = self.ActiveRuleSet.caps

	-- calculate score based on stats
	for statname,statvalue in pairs(stats) do
		statname = ItemScore:NormaliseStatName(statname)
		local statweight = statweights[statname] or 0

		if caps[statname] then
			local current_rating = ItemScore:GetEquippedStatValue(statname)
			-- reduce value of stats that are already capped, or if player is not at max level
			if (current_rating > caps[statname]) or self.playerlevel < GetMaxPlayerLevel() then
				statweight = statweight / 2
			end
		end
		score = score + statvalue*statweight

		if verbose then table.insert(verbose,("  + |cff00ff00%.1f *  %s|r: |cffaaaaaa * %.1f = |cffffffff%.1f|r"):format(statvalue,statname, statweight, statvalue*statweight))  end
		
	end

	-- use separate score for gray/white statless items, it will only be used to compare between those types
	if score==0 and item.quality < 2 then
		whitescore = whitescore + (item.stats.RESISTANCE0_NAME or 0) -- add armor at value 1
		--whitescore = whitescore + (item.stats.ITEM_MOD_DAMAGE_PER_SECOND_SHORT or 0) -- add dps at value 1 -- since we are using tooltip scanning, dps is stored as short
		whitescore = whitescore + (item.stats.DAMAGE_PER_SECOND or 0) -- add dps at value 1
		if verbose then 
			table.insert(verbose,("  + |cff00ff00%.1f %s|r: |cffaaaaaa * %.1f = |cffffffff%.1f|r"):format(statvalue,"ARMOR", 1, item.stats.RESISTANCE0_NAME))
			table.insert(verbose,("  + |cff00ff00%.1f %s|r: |cffaaaaaa * %.1f = |cffffffff%.1f|r"):format(statvalue,"DPS", 1, item.stats.ITEM_MOD_DAMAGE_PER_SECOND_SHORT))  
		end
	end

	-- adjust armor weights
	if item.class == LE_ITEM_CLASS_ARMOR then
		if verbose then table.insert(verbose,("  ? |cff00ff00Is armor"))  end 
		local types = self.ActiveRuleSet.itemtypes
		local subclass = item_armor_types[item.subclass]
		local limit = types[subclass] or 0
		if verbose then table.insert(verbose,("  ? |cff00ff00limit "..limit.." level "..self.playerlevel))  end 
		-- if limit is below 0, item is good only till given level, with 10 level grace
		if limit < 0 then 
			if verbose then table.insert(verbose,("  ? |cff00ff00Has limit"))   end
			if self.playerlevel >= (-limit+10) then
				if verbose then table.insert(verbose,"  ? |cff00ff00Has limit, past grace") end  
				-- we are over the 10 level grace period, undervalue heavily, and even heavier on white items. I mean, come on, farm a little...
				score = score * 0.5
				whitescore = whitescore * 0.3
			elseif self.playerlevel >= -limit then
				if verbose then table.insert(verbose,"  ? |cff00ff00Has limit, grace period") end  
				 -- we are within grace period, undervalue slightly
				 score = score * 0.9
				whitescore = whitescore * 0.5
				-- allows hunter/pally/warr/sham to transition armor type from level 40 to 50
			end
		end

	end

	-- record scores
	item.score = score
	item.whitescore = whitescore

	return score, whitescore, true, "scored ok"
end


-- checks if item can be equipped by player at the moment. result is cached
-- params:
--	itemlink - string
--	future - anything - for checks for future upgrades. if set, level restriction is not checked
-- returns: 
--	is valid - bool - is item valid for current player
--	is final - bool - was validity really checked (and not skipped due to no gii info)
--	comment - string - verbose description of result
function ItemScore:IsValidItem(itemlink, future)
	if not itemlink then return false, false, "No itemlink" end

	local item = ItemScore:GetItemDetails(itemlink)
	if not item then return false, false, "No info" end

	if item.validated then return item.valid, true, item.validstatus end

	if not item.slot then 
		item.validated = true
		item.valid = false
		item.validstatus = "not equipment"
		return false, true, item.validstatus
	end

	local types = self.ActiveRuleSet.itemtypes
	if not types then return false, false, "No info" end

	-- is something that can be equipped
	local subclass
	if item.class == LE_ITEM_CLASS_ARMOR then
		subclass = item_armor_types[item.subclass]
	elseif item.class == LE_ITEM_CLASS_WEAPON then
		subclass = item_weapon_types[item.subclass]
	else
		item.validated = true
		item.valid = false
		item.validstatus = "not equipment "..(item.class).." "..(item.subclass)
		return false, true, item.validstatus
	end

	-- can equip at current level, cloaks are cloth, but valid for all classes
	local useble_since_level = types[subclass] or (item.type=="INVTYPE_CLOAK" and 1)

	if not useble_since_level then
		item.validated = true
		item.valid = false
		item.validstatus = ("%s is not valid for %s"):format(subclass,self.playerclassName)
		return false, true, item.validstatus
	elseif not future and self.playerlevel < useble_since_level then
		item.validated = true
		item.valid = false
		item.validstatus = ("required level %d to use"):format(useble_since_level)
		return false, true, item.validstatus
	end

	-- do we have skill to use this
	if (subclass~="JEWELERY") and (ItemScore.Skills[subclass] or 0) == 0 then
		item.validated = true
		item.valid = false
		item.validstatus = "no skill "..subclass
		return false, true, item.validstatus
	end

	-- player class
	if item.playerclass then
		local validclass=false
	        for i,v in pairs(ZGV.ExplodeString(", ",item.playerclass)) do
			if v==self.playerclassName then
				validclass=true
				break
			end
		end

		if not validclass then
			item.validated = true
			item.valid = false
			item.validstatus = "wrong class"
			return false, true, item.validstatus
		end
	end

	-- player level
	if not future and item.minlevel and item.minlevel > self.playerlevel then 
		item.validated = true
		item.valid = false
		item.validstatus = ("required level %d to equip"):format(item.minlevel)
		return false, true, item.validstatus
	end

	-- if we are here, it means that none of conditions forced early exit. wheeee have an upgrade
	item.validated = true
	item.valid = true
	item.validstatus = "ok"
	return true, true, "ok"
end

-- returns items equipped in requested slots, used by pointer
-- params:
--	slot - int - numeric identificator of slot to check
-- returns
--	itemlink - string - itemlink of item in first possible slot
--	itemlink2 - string, optional - itemlink of item in second possible slot
function ItemScore:GetItemInSlot(itemslot)
	local s1, s2 = get_slots_by_type(itemslot)

	local itemlink1,itemlink2
	if s1 then itemlink1 = GetInventoryItemLink("player",s1) end
	if s2 then itemlink2 = GetInventoryItemLink("player",s2) end

	return itemlink1 and itemlink1:match("item[:%d]+"),itemlink2 and itemlink2:match("item[:%d]+"), itemlink1,itemlink2
end

-- set of functions to add zygor item info to tooltip
local function get_change(old,new) 
	if old and old>0 then 
		return math.floor(((new*100/old)-100)*100)/100
	else 
		return 100 
	end 
end

local function ItemScore_SetTooltipData(tooltip, tooltipobj)
	tooltipobj=tooltipobj or GameTooltip -- we patch either gametooltip or itemreftooltip

	if ZGV.db.profile.vendor_tooltip and not ItemScore.TooltipPatched then
		local container = GetMouseFocus()
		local itemName,itemlink = tooltipobj:GetItem()
		local parent = tooltipobj:GetParent()

		if not itemlink then ItemScore.TooltipPatched  = true return end

		local _,_,_,_,_,_,_,_,_,_,sellprice = ZGV:GetItemInfo(itemlink)
		local count = container and type(container.count)=="number" and container.count or 1 -- gg elvui. 
		
		if sellprice then
			tooltip:AddLine(" ")
			if count>1 then
				tooltip:AddLine("|cfffe6100Vendor price for "..count..": "..ZGV.GetMoneyString(sellprice*count,nil,3).."|r")
			else
				tooltip:AddLine("|cfffe6100Vendor price: "..ZGV.GetMoneyString(sellprice*count,nil,3).."|r")
			end
		end
	end

	if (ZGV.db.profile.autogear and ZGV.db.profile.itemscore_tooltips) and not ItemScore.TooltipPatched then
		local itemName,itemlink = tooltipobj:GetItem()
		if not itemlink then ItemScore.TooltipPatched  = true return end

		local item = ItemScore:GetItemDetails(itemlink,"temporary") -- temporary item data will be purged 60 seconds after we are done with tooltip
		if not item then ItemScore.TooltipPatched  = true return end

		local fulllink = itemlink
		local itemlink = item.itemlink

		local score, white, success, scorecomment = ItemScore:GetItemScore(itemlink)
		if not success then ItemScore.TooltipPatched  = true return end

		local valid, final, validcomment = ItemScore:IsValidItem(itemlink)
		if not final then ItemScore.TooltipPatched  = true return end
		
		if ZGV.db.profile.debug_display then
			tooltip:AddLine(" ")
			tooltip:AddLine("|r|cfffe6100Zygor debug:|r ")
			tooltip:AddLine("link "..fulllink)
			tooltip:AddLine("stripped "..itemlink)
			if white>0 then
				tooltip:AddLine("white score "..white)
			else
				tooltip:AddLine("score "..score)
			end
			tooltip:AddLine("valid "..(valid and "yes " or "no ")..validcomment)
			tooltip:AddLine("stats:")
			for i,v in pairs(item.stats) do
				tooltip:AddLine(i.." "..v)
			end
		end
		
		local slot_1,slot_2 = item.slot, item.slot_2
		local equipped_item_1, equipped_item_2, change_1, change_2
		if slot_1 then 
			equipped_item_1 = ItemScore.Upgrades.EquippedItems[slot_1]
			change_1 = get_change(equipped_item_1.score,score)
		end
		if slot_2 then 
			equipped_item_2 = ItemScore.Upgrades.EquippedItems[slot_2] 
			change_2 = get_change(equipped_item_2.score,score)
		end

		if valid then
			if (equipped_item_1 and equipped_item_1.score) or (equipped_item_2 and equipped_item_2.score) then -- item can replace something
				local mh, oh, th
				if item.class == LE_ITEM_CLASS_WEAPON then
					ItemScore.Upgrades:ResetWeaponQueue("onlytemp")
					ItemScore.Upgrades:QueueWeapon(itemlink)
					mh, oh, th = ItemScore.Upgrades:ProcessWeaponQueue()
				end

				tooltip:AddLine(" ")
				tooltip:AddLine("|cfffe6100Zygor ItemScore:|r")
				local slotinfo1 = slot_2 and "Slot 1: " or ""
				local slotinfo2 = slot_2 and "Slot 2: " or ""

				-- item in slot 1
				if equipped_item_1.score then
					if itemlink~=equipped_item_1.itemlink then
						local comment = "|r "..slotinfo1..((change_1 > 0) and "Upgrade |cff00ff00" or "Downgrade |cffff0000")
						if ZGV.db.profile.debug then comment = comment..(score-equipped_item_1.score).." " end
						tooltip:AddLine(comment..change_1.."% ")
						if change_1<0 and (mh and mh.itemlink==itemlink) and (oh and oh.itemlink) then
							tooltip:AddLine("       Upgrade with "..oh.itemlinkfull)
						end
					else
						tooltip:AddLine("|r "..slotinfo1.."Equipped")
					end
				else
					tooltip:AddLine("|r "..slotinfo1.."Upgrade |cff00ff00100% ")
				end

				if slot_2 and equipped_item_2.score then
					if itemlink~=equipped_item_2.itemlink then
						local comment = "|r "..slotinfo2..((change_2 > 0) and "Upgrade |cff00ff00" or "Downgrade |cffff0000")
						if ZGV.db.profile.debug then comment = comment..(score-equipped_item_2.score).." " end
						tooltip:AddLine(comment..change_2.."% ")
						if change_2<0 and (mh and mh.itemlink) and (oh and oh.itemlink==itemlink) then
							tooltip:AddLine("       Upgrade with "..mh.itemlinkfull)
						end
					else
						tooltip:AddLine("|r "..slotinfo2.."Equipped")
					end
				elseif slot_2 then
					tooltip:AddLine("|r "..slotinfo2.."Upgrade |cff00ff00100% ")
				end
			elseif score>0 then
				tooltip:AddLine(" ")
				tooltip:AddLine("|cfffe6100Zygor ItemScore:|r")
				tooltip:AddLine("|r  Upgrade |cff00ff00100% ")
			end
		else
			tooltip:AddLine(" ")
			tooltip:AddLine("|cfffe6100Zygor ItemScore:|r")
			tooltip:AddLine("|r  Not a valid item")
		end

		ItemScore.TooltipPatched  = true
	end
	
	if tooltipobj==ItemRefTooltip then ItemRefTooltip:Show() end -- update to new height, have to do it by hand since IRT is called just once
end
local function ItemScore_ClearTooltipData(tooltip, ...) ItemScore.TooltipPatched = false end

-- functions that support itemscore/gearfinder options panel
function ItemScore:UsesCustomWeights(class,build)
	local statset = ZGV.ItemScore.rules[class][build].stats
	local prefix = 'gear_'..class..'_'..build..'_'
	local profile = ZGV.db.profile

	for index=1,#ZGV.ItemScore.Keywords do
		local statname = ZGV.ItemScore.Keywords[index].blizz

		if not profile[prefix..statname] and statset[statname] then
		
		elseif tonumber(profile[prefix..statname]) and not statset[statname] then
			return true
		elseif tonumber(profile[prefix..statname]) and tonumber(statset[statname])~=tonumber(profile[prefix..statname]) then
			return true
		end
	end
	return false
end

ItemScore.Skills = {}
function ItemScore:GetEquipmentSkills()
	table.wipe(ItemScore.Skills)
	table.wipe(ItemCache) -- since items that were rejected due to skill may be valid now

	for i=1, GetNumSkillLines() do
		local skillName, _, _, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);
		local skillTag = ItemScore.SkillNamesRev[skillName]
		if skillTag then
			ItemScore.Skills[skillTag] = skillRank
		end
	end
end

function ItemScore:GetEquippedStatValue(statname)
	local result = 0
	for slotID,item in pairs(ZGV.ItemScore.Upgrades.EquippedItems) do 
		local details = ItemScore:GetItemDetails(item.itemlink)
		if details then
			for sname,svalue in pairs(details.stats) do
				local name = ItemScore:NormaliseStatName(sname)
				if name==statname then
					result = result + svalue
				end
			end
		end
	end
	return result
end

tinsert(ZGV.startups,{"ItemScore",function(self)
	ZGV.db.char.badupgrade = ZGV.db.char.badupgrade or {}
	ItemScore:Initialise()
	--ItemScore.GearFinder:Initialise() -- CLASSIC TODO rework with proper tab hooking 

	GameTooltip:HookScript("OnTooltipSetItem", ItemScore_SetTooltipData)
	GameTooltip:HookScript("OnTooltipCleared", ItemScore_ClearTooltipData)
	ItemRefTooltip:HookScript("OnTooltipCleared", ItemScore_ClearTooltipData)
	hooksecurefunc (GameTooltip, "SetHyperlink", function(tip) ItemScore_SetTooltipData(tip,GameTooltip) end)
	hooksecurefunc (ItemRefTooltip, "SetHyperlink", function(tip) ItemScore_SetTooltipData(tip,ItemRefTooltip) end)
end})