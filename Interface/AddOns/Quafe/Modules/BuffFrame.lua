local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

--- ------------------------------------------------------------
--> API Localization
--- ------------------------------------------------------------

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
 
--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------
-- Taken from RayUI

local create_Backdrop = function(f)
	local d1 = 4
	local d2 = 8
	if f.Shadow then return end
	f.Shadow = CreateFrame("Frame", nil, f)
	f.Shadow: SetFrameLevel(0)
	f.Shadow: SetFrameStrata(f:GetFrameStrata())
	f.Shadow:SetPoint("TOPLEFT", -d1, d1)
	f.Shadow:SetPoint("BOTTOMLEFT", -d1, -d1)
	f.Shadow:SetPoint("TOPRIGHT", d1, d1)
	f.Shadow:SetPoint("BOTTOMRIGHT", d1, -d1)
	f.Shadow: SetBackdrop({
		edgeFile = F.Path("EdgeFile\\EdgeFile_Backdrop"),
		edgeSize = d2,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	f.Shadow: SetBackdropColor( .05,.05,.05, 0)
	f.Shadow: SetBackdropBorderColor(C.Color.Black[1],C.Color.Black[2],C.Color.Black[3],0.9)
end
	
local formatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then 
		return format("%dd", floor(s/day + 0.5)), s % day
	elseif s >= hour then	
		return format("%dh", floor(s/hour + 0.5)), s % hour
	elseif s >= minute then
		return format("%dm", floor(s/minute + 0.5)), s % minute
	elseif s >= minute / 12 then
		return floor(s + 0.5), (s * 100 - floor(s * 100))/100
	end
	return format("%.1f", s), (s * 100 - floor(s * 100))/100 
end

local function Aura_OnUpdate(button, elapsed)
	if button.remain then
		button.CD: SetText(formatTime(button.remain))
		if ( button.remain < BUFF_DURATION_WARNING_TIME ) then
			button.CD: SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		else 
			button.CD: SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
		button.remain = max(button.remain - elapsed, 0)
	end
end

local function Aura_Update(button, index)
	local filter = button:GetParent():GetAttribute("filter")
	local unit = button:GetParent():GetAttribute("unit")
	local name, icon, count, dispelType, duration, expires, caster, isStealable,  nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, _, nameplateShowAll, timeMod = UnitAura(unit, index , filter)
	if name then
		button.Icon: SetTexture(icon)
		if ( duration > 0 ) and ( expires > 0 ) then
			local remain = expires - GetTime()
			if not button.remain then
				button.remain = remain
				button: SetScript("OnUpdate", Aura_OnUpdate)
			else
				button.remain = remain
			end
		else
			button: SetScript("OnUpdate", nil)
			button.remain = nil
			button.CD: SetText(" ")
		end

		if count > 1 then
			button.Ct: SetText(count)
		else
			button.Ct: SetText(" ")
		end	

		if filter == "HARMFUL" then
			local color = DebuffTypeColor[dispelType] or DebuffTypeColor.none
			button.Shadow: SetBackdropBorderColor(F.Color(color))
		end
	end
end

local textureMapping = {
	[1] = 16,	--Main hand
	[2] = 17,	--Off-hand
	[3] = 18,	--Ranged 
}

local function Enchant_Update(button, index)
	local quality = GetInventoryItemQuality("player", index)
	local texture = GetInventoryItemTexture("player", index)
	--local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantId = GetWeaponEnchantInfo()
	local remain,count = 0,0
	if index == textureMapping[1] then
		remain = mainHandExpiration
		count = mainHandCharges
	elseif index == textureMapping[2] then
		remain = offHandExpiration
		count = offHandCharges
	elseif index == textureMapping[3] then
		remain = mainHandExpiration
		count = mainHandCharges
	end

	if texture then
		button.Icon: SetTexture(texture)
	end

	if quality then
		button.Shadow: SetBackdropBorderColor(GetItemQualityColor(quality))
	end

	if (remain) and (remain > 0) then
		remain = remain/1000
		if not button.remain then
			button.remain = remain
			button: SetScript("OnUpdate", Aura_OnUpdate)
		else
			button.remain = remain
		end
	else
		button: SetScript("OnUpdate", nil)
		button.remain = nil
		button.CD: SetText(" ")
	end

	if (count) and (count > 1) then
		button.Ct: SetText(count)
	else
		button.Ct: SetText(" ")
	end
end

local function OnAttributeChanged(button, attribute, value)
	if(attribute == "index") then
		Aura_Update(button, value)
	elseif(attribute == "target-slot") then
		Enchant_Update(button, value)
	end
end

local function Icon_Art(button)
	button.Icon = button:CreateTexture(nil, "BORDER")
	button.Icon: SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.Icon: SetAllPoints(button)

	button.CD = button:CreateFontString(nil, "OVERLAY")
	button.CD: SetFont(C.Font.NumSmall, 12, "OUTLINE")--"THINOUTLINE,MONOCHROME"
	button.CD: SetShadowColor(0,0,0,0.25)
	button.CD: SetShadowOffset(1,-1)
	button.CD: SetJustifyH("CENTER")
	button.CD: SetPoint("TOP", button, "BOTTOM", 0,-2)

	button.Ct = button:CreateFontString(nil, "OVERLAY")
	button.Ct: SetFont(C.Font.NumSmall, 12, "OUTLINE")
	button.Ct: SetShadowColor(0,0,0,0.25)
	button.Ct: SetShadowOffset(1,1)
	button.Ct: SetJustifyH("CENTER")
	button.Ct: SetPoint("TOPRIGHT", button, "TOPRIGHT", 1,2)

	create_Backdrop(button)

	button:SetScript("OnAttributeChanged", OnAttributeChanged)
end

function Quafe_BuffFrameButton_OnLoad(self)
	Icon_Art(self)
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
end

--- ------------------------------------------------------------
-->
--- ------------------------------------------------------------

local Buff_Create = function(f)
	f.Buff = CreateFrame("Frame", "Quafe_BuffFrame.Buff", f, "SecureAuraHeaderTemplate")
	f.Buff.size = 26
	f.Buff.fontsize = 12

	f.Buff: SetAttribute("unit", "player")
	f.Buff: SetAttribute("filter", "HELPFUL")
	f.Buff: SetAttribute("separateOwn", 1)
	f.Buff: SetAttribute("sortMethod", "INDEX") --"INDEX", "NAME", "TIME"
	f.Buff: SetAttribute("sortDirection", "+") --"+", "-"
	f.Buff: SetAttribute("includeWeapons", 1)
	f.Buff: SetAttribute("consolidateTo", 0)
	f.Buff: SetAttribute("point", "TOPRIGHT")
	f.Buff: SetAttribute("minWidth", f.Buff.size)
	f.Buff: SetAttribute("minHeight", f.Buff.size)
	f.Buff: SetAttribute("xOffset", -(f.Buff.size+6))
	f.Buff: SetAttribute("wrapAfter", 0)
	f.Buff: SetAttribute("maxWraps", 0)
	f.Buff: SetAttribute("template", "Quafe_AuraButtonTemplate")
	f.Buff: SetAttribute("weaponTemplate", "Quafe_AuraButtonTemplate")
	RegisterStateDriver(f.Buff, "visibility", "[petbattle] hide; show")
	f.Buff: SetSize(f.Buff.size,f.Buff.size)
	f.Buff: SetPoint("TOPRIGHT", f, "TOPRIGHT", 0,0)
end

local Debuff_Create = function(f)
	f.Debuff = CreateFrame("Frame", "Quafe_BuffFrame.Debuff", f, "SecureAuraHeaderTemplate")
	f.Debuff.size = 26
	f.Debuff.fontsize = 12

	f.Debuff: SetAttribute("unit", "player")
	f.Debuff: SetAttribute("filter", "HARMFUL")
	f.Debuff: SetAttribute("separateOwn", 1)
	f.Debuff: SetAttribute("sortMethod", "INDEX") --"INDEX", "NAME", "TIME"
	f.Debuff: SetAttribute("sortDirection", "+") --"+", "-"
	f.Debuff: SetAttribute("includeWeapons", 1)
	f.Debuff: SetAttribute("consolidateTo", 0)
	f.Debuff: SetAttribute("point", "TOPRIGHT")
	f.Debuff: SetAttribute("minWidth", f.Debuff.size)
	f.Debuff: SetAttribute("minHeight", f.Debuff.size)
	f.Debuff: SetAttribute("xOffset", -(f.Debuff.size+6))
	f.Debuff: SetAttribute("wrapAfter", 0)
	f.Debuff: SetAttribute("maxWraps", 0)
	f.Debuff: SetAttribute("template", "Quafe_AuraButtonTemplate")
	RegisterStateDriver(f.Debuff, "visibility", "[petbattle] hide; show")
	f.Debuff: SetSize(f.Debuff.size,f.Debuff.size)
	f.Debuff: SetPoint("TOPRIGHT", f.Buff, "BOTTOMRIGHT", 0,-70)
end
--[[
local BuffFrame_Create = function(f)
	f.BuffFrame = CreateFrame("Frame", "Qot.BuffFrame", f)
	f.BuffFrame: SetSize(10,10)
	f.BuffFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -30, -30)
	Buff_Create(f.BuffFrame)
	Debuff_Create(f.BuffFrame)
end
]]--

----------------------------------------------------------------
--> Load
----------------------------------------------------------------

local Quafe_BuffFrame = CreateFrame("Frame", "Quafe_Default_BuffFrame", E)
Quafe_BuffFrame: SetSize(300,100)
--Quafe_BuffFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -30, -30)
Quafe_BuffFrame.Init = false
Quafe_BuffFrame: Hide()

local function Joystick_Update(self, elapsed)
	local x2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_BuffFrame.PosX
	local y2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_BuffFrame.PosY
	local x0,y0 = Quafe_BuffFrame: GetCenter()
	local x1,y1 = self: GetCenter()
	local step = floor(1/(GetFramerate())*1e3)/1e3
	if x0 ~= x1 then
		x2 = x2 + (x1-x0)*step/2
	end
	if y0 ~= y1 then
		y2 = y2 + (y1-y0)*step/2
	end
	--x2 = floor(x2+0.5)
	--y2 = floor(y2+0.5)
	Quafe_BuffFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT",x2, y2)
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_BuffFrame.PosX = x2
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_BuffFrame.PosY = y2
end

local function Quafe_BuffFrame_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_BuffFrame"].Enable then
		Quafe_BuffFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_BuffFrame.PosX, Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_BuffFrame.PosY)
		
		F.CreateJoystick(Quafe_BuffFrame, 320,120, "Quafe_BuffFrame")
		Quafe_BuffFrame.Joystick.postUpdate = Joystick_Update

		Quafe_BuffFrame: Show()
		Buff_Create(Quafe_BuffFrame)
		Debuff_Create(Quafe_BuffFrame)
		Quafe_BuffFrame.Init = true
		BuffFrame: Hide()
		TemporaryEnchantFrame: Hide()
	end
end

local function Quafe_BuffFrame_Toggle(arg)
	if arg == "ON" then
		if not Quafe_BuffFrame.Init then
			Quafe_BuffFrame_Load()
		end
		Quafe_BuffFrame: Show()
		Quafe_BuffFrame.Mover: Show()
		BuffFrame: Hide()
		TemporaryEnchantFrame: Hide()
	elseif arg == "OFF" then
		Quafe_BuffFrame: Hide()
		Quafe_BuffFrame.Mover: Hide()
		BuffFrame: Show()
		TemporaryEnchantFrame: Show()
	end
end

local Quafe_BuffFrame_Config = {
	Database = {
		["Quafe_BuffFrame"] = {
			["Enable"] = true,
			["PosX"] = -30,
			["PosY"] = -30,
		},
	},

	Config = {
		Name = "Quafe "..L['BUFF_FRAME'],
		Type = "Switch", --Switch, Trigger, Blank, Dropdown
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_BuffFrame"].Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_BuffFrame"].Enable = false
				self.Text:SetText(L["OFF"])
				Quafe_BuffFrame_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_BuffFrame"].Enable = true
				self.Text:SetText(L["ON"])
				Quafe_BuffFrame_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_BuffFrame"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = nil,
	},
}

Quafe_BuffFrame.Load = Quafe_BuffFrame_Load
Quafe_BuffFrame.Config = Quafe_BuffFrame_Config
tinsert(E.Module, Quafe_BuffFrame)

----------------------------------------------------------------
--[[
RAID_BUFF_1 Stats
RAID_BUFF_2 Stamina
RAID_BUFF_3 Attack Power
RAID_BUFF_4 Haste
RAID_BUFF_5 Spell Power
RAID_BUFF_6 Critical Strike
RAID_BUFF_7 Mastery
RAID_BUFF_8 Multistrike
RAID_BUFF_9 Versatility
The highest raid buff category number is indicated by NUM_LE_RAID_BUFF_TYPES.
name, rank, texture, duration, expiration, spellId, slot = GetRaidBuffTrayAuraInfo()
	Arguments:     
		nil - The id of the aura slot (number)
	Returns:
		name - The name of the active aura (string)
		rank - The rank of the active aura (string)
		texture - The texture path of the active aura (string)
		duration - The duration of the active aura (number)
		expiration - The expiration time of the active aura (number)
		spellId - The spell ID of the active aura (number)
		slot - The buff slot of the active aura (number)
----------------------------------------------------------------

local textureMapping = {
	[1] = 16,	--Main hand
	[2] = 17,	--Off-hand
	[3] = 18,	--Ranged
};

function TemporaryEnchantFrame_Update(...)
	local RETURNS_PER_ITEM = 4;
	local numVals = select("#", ...);
	local numItems = numVals / RETURNS_PER_ITEM;
	if ( numItems == 0 ) then
		TemporaryEnchantFrame_Hide();
		return;
	end
	
	local enchantIndex = 0;
	for itemIndex = numItems, 1, -1 do	--Loop through the items from the back.
		local hasEnchant, enchantExpiration, enchantCharges = select(RETURNS_PER_ITEM * (itemIndex - 1) + 1, ...);
		if ( hasEnchant ) then
			enchantIndex = enchantIndex + 1;
			local enchantButton = _G["TempEnchant"..enchantIndex];
			local textureName = GetInventoryItemTexture("player", textureMapping[itemIndex]);
			enchantButton:SetID(textureMapping[itemIndex]);
			_G[enchantButton:GetName().."Icon"]:SetTexture(textureName);
			enchantButton:Show();
			-- Show buff durations if necessary
			if ( enchantExpiration ) then
				enchantExpiration = enchantExpiration/1000;
			end	
			AuraButton_UpdateDuration(enchantButton, enchantExpiration);
			-- Handle flashing
			if ( enchantExpiration and enchantExpiration < BUFF_WARNING_TIME ) then
				enchantButton:SetAlpha(BuffFrame.BuffAlphaValue);
			else
				enchantButton:SetAlpha(1.0);
			end
		end
	end
	--Hide unused enchants
	for i=enchantIndex+1, NUM_TEMP_ENCHANT_FRAMES do
		_G["TempEnchant"..i]:Hide();
		_G["TempEnchant"..i.."Duration"]:Hide();
	end
	-- Position buff
	frameTemporaryEnchantFrame:SetWidth(enchantIndex * 32);
	if ( BuffFrame.numEnchants ~= enchantIndex ) then
		BuffFrame.numEnchants = enchantIndex;
		BuffFrame_Update();
	end
end 
--]]