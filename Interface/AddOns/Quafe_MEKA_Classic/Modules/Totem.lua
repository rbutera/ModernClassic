local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale
if F.IsClassic then return end

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
--> Totem
--- ------------------------------------------------------------

local ICON_TEXTURE = {
	-->萨满
	["511726"] = C.Color.G1, --图腾掌握
	["136013"] = C.Color.G1, --闪电奔涌图腾
	["135790"] = C.Color.R3, --火元素
	["136024"] = C.Color.Y3, --土元素
	["136108"] = C.Color.Y2, --战栗图腾
	["136013"] = C.Color.B1, --电能图腾
	["1020304"] = C.Color.W3, --风暴元素
	["135127"] = C.Color.B1, --治疗之泉图腾
	["538569"] = C.Color.G1, --治疗之潮图腾
	["136080"] = C.Color.R3, --先祖护佑图腾
	-->死亡骑士
	["298674"] = C.Color.R3, --黑暗冲裁者
	["458967"] = C.Color.R3, --黑锋石像鬼
	-->牧师
	["136214"] = C.Color.Bar["F5512C"], --摧心魔
	-->武僧
	["620831"] = C.Color.G1, --青龙雕像
	["627607"] = C.Color.Y3, --玄牛雕像
}

local function Totem_OnClick(self, mouseButton)
	local cannotDismiss = GetTotemCannotDismiss(self.Slot)
	if ( not cannotDismiss ) then
		if ( mouseButton == "RightButton" and self.Slot > 0 ) then
			DestroyTotem(self.Slot);
		end
	end
end

local function Totem_ForClick(self)
	self: SetAttribute("type2","destroytotem")
	self: SetAttribute("totem-slot", self:GetID())
end

local function Totem_OnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT')
	--GameTooltip_SetDefaultAnchor(GameTooltip, self);
	GameTooltip:SetTotem(self.Slot);
end

local function Totem_NumUpdate(frame, d)
   local d1,d2,n1,n2,n3 = 0,0,0,0,0
	if d then
		if d < 0 then d = 0 end
		if d > 540 then d = 540 end
		if d > 60 then
			d1 = "m"
			d2 = floor(d/60)
		else
			d2 = floor(d/10)
			d1 = max(floor(d - d2*10), 0)
		end
		if d2 >= 1 then
			n1 = d2
			n2 = "b"
			n3 = d1
		else
			n1 = "b"
			n2 = d1
			n3 = "b"
		end
		frame.Num[1]: SetTexture(F.Path("N12\\N"..n1))
		frame.Num[2]: SetTexture(F.Path("N12\\N"..n2))
		frame.Num[3]: SetTexture(F.Path("N12\\N"..n3))
	end
end

local function TotemButton_Update(button, startTime, duration, icon)
	if ( duration > 0 ) then
		button.Info.Duration = duration
		button.Info.Remain = max(duration + startTime - GetTime(), 0)
		button:SetScript("OnUpdate", function(self, elapsed)
			if F.Last25H == 0 then
				Totem_NumUpdate(button, button.Info.Remain)
			end
			button.Info.Remain = button.Info.Remain - elapsed
		end)
		button: SetAlpha(1)
	else
		button.Info.Duration = 0
		button.Info.Remain = 0
		Totem_NumUpdate(button, button.Info.Remain)
		button:SetScript("OnUpdate", nil)
		button: SetAlpha(0)
	end
end
--[[
local function Totem_OnEvent(self)
	local haveTotem, name, startTime, duration, icon;
	local slot;
	local button;
	local buttonIndex = 1;
	local priorities = STANDARD_TOTEM_PRIORITIES
	if (F.PlayerClass == "SHAMAN") then
		priorities = SHAMAN_TOTEM_PRIORITIES
	end
	for i=1, MAX_TOTEMS do
		slot = priorities[i];
		haveTotem, name, startTime, duration, icon = GetTotemInfo(slot);
		if ( haveTotem ) then
			local tex = tostring(icon)
			if ICON_TEXTURE[tex] then
				self.Totems[buttonIndex].BgG:SetVertexColor(F.Color(ICON_TEXTURE[tex]))
			else
				self.Totems[buttonIndex].BgG:SetVertexColor(F.Color(C.Color.W3))
			end
			self.Totems[buttonIndex].Slot = slot
			local cannotDismiss = GetTotemCannotDismiss(slot)
			if ( not cannotDismiss ) then
				self.Totems[buttonIndex]: SetID(slot)
			else
				self.Totems[buttonIndex]: SetID(0)
			end
			TotemButton_Update(self.Totems[buttonIndex], startTime, duration, icon)
			buttonIndex = buttonIndex + 1
		else
			self.Totems[buttonIndex].Slot = 0
			self.Totems[buttonIndex]:Hide()
		end
	end
end
--]]
local function Totem_OnEvent(self)
	local haveTotem, name, startTime, duration, icon;
	for i=1, MAX_TOTEMS do
		haveTotem, name, startTime, duration, icon = GetTotemInfo(i);
		if ( haveTotem ) then
			local tex = tostring(icon)
			if ICON_TEXTURE[tex] then
				self.Totems[i].BgG:SetVertexColor(F.Color(ICON_TEXTURE[tex]))
			else
				self.Totems[i].BgG:SetVertexColor(F.Color(C.Color.Main1))
			end
			self.Totems[i].Slot = i
			--self.Totems[i]: SetAlpha(1)
			TotemButton_Update(self.Totems[i], startTime, duration, icon)
		else
			self.Totems[i].Slot = 0
			self.Totems[i]: SetAlpha(0)
		end
	end
end

local function Totem_RgEvent(frame)
	frame:RegisterEvent("PLAYER_TOTEM_UPDATE");
	frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	frame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	frame:RegisterEvent("PLAYER_TALENT_UPDATE");
end

local function Totem_Template(frame, index)
	local Button = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate", index)
	Button: SetSize(42,30)
	Button: RegisterForClicks("RightButtonUp")
	Button.Slot = index
	Button.Info = {}

	local Bg = F.Create.Texture(Button, "BACKGROUND", 1, MEKA.Path("Totem"..index), C.Color.Main0, 0.75, {36,27}, {28/128,100/128, 5/64,59/64})
	Bg: SetPoint("CENTER")

	local BgG = F.Create.Texture(Button, "BORDER", 1, MEKA.Path("Totem"..index), C.Color.Main1, 0.5, {36,27}, {28/128,100/128, 5/64,59/64})
	BgG: SetPoint("CENTER")

	local BgSd = F.Create.Texture(Button, "BORDER", 1, MEKA.Path("Totem"..index.."_Sd"), C.Color.Main0, 0.25, {36,27}, {28/128,100/128, 5/64,59/64})
	BgSd: SetPoint("CENTER")

	local Num = {}
	for i = 1,3 do
		Num[i] = F.Create.Texture(Button, "OVERLAY", 1, F.Path("N12\\N".."9"), C.Color.Main1, 0.9, {32,32})
	end

	Button.Bg = Bg
	Button.BgG = BgG
	Button.Num = Num
	Button: SetAlpha(0)

	Button: SetScript("OnEnter", Totem_OnEnter)
	Button: SetScript("OnLeave", function(self)
		GameTooltip:Hide();
	end)

	return Button
end

local function Totem_PosNum(frame, radius, angle)
	for i = 1,3 do
		frame.Num[i]: SetRotation(rad(angle-180))
		frame.Num[i]: SetPoint("CENTER", UIParent, "CENTER", (radius-1+4*(2-i))*cos(rad(angle)), (radius-1+4*(2-i))*sin(rad(angle)))
	end
end

local function Totem_Create(frame)
	local Totems = {}
	for i = 1,4 do
		Totems[i] = Totem_Template(frame, i)
	end
	Totems[1]: SetPoint("CENTER", UIParent, "CENTER", -359.5,47.5)
	Totem_PosNum(Totems[1], 362, 172.5)
	Totems[2]: SetPoint("CENTER", UIParent, "CENTER", -356.5,66.25)
	Totem_PosNum(Totems[2], 362, 169.5)
	Totems[3]: SetPoint("CENTER", UIParent, "CENTER", -389.25,51.25)
	Totem_PosNum(Totems[3], 393, 172.5)
	Totems[4]: SetPoint("CENTER", UIParent, "CENTER", -386,71.5)
	Totem_PosNum(Totems[4], 393, 169.5)

	--Totems[1]: SetScript("OnClick", Totem_OnClick)
	--Totems[2]: SetScript("OnClick", Totem_OnClick)
	--Totems[3]: SetScript("OnClick", Totem_OnClick)
	--Totems[4]: SetScript("OnClick", Totem_OnClick)
	Totem_ForClick(Totems[1])
	Totem_ForClick(Totems[2])
	Totem_ForClick(Totems[3])
	Totem_ForClick(Totems[4])

	frame.Totems = Totems
end

local MEKA_Totem = CreateFrame("Frame", "Quafe_MEKA_Totem", E)
MEKA_Totem.Init = false

local function MEKA_Totem_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State and Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State ~= "OFF" then
		Totem_Create(MEKA_Totem)
		Totem_RgEvent(MEKA_Totem)
		MEKA_Totem: SetScript("OnEvent", Totem_OnEvent)
		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale then
			MEKA_Totem: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale)
		end
		MEKA_Totem.Init = true
	end
end

local function MEKA_Totem_Toggle(arg)
	if arg == "ON" then
		if not MEKA_Totem.Init then
			MEKA_Totem_Load()
		end
		if not InCombatLockdown() then
			MEKA_Totem: Show()
		end
	elseif arg == "OFF" then
		if not InCombatLockdown() then
			MEKA_Totem: Hide()
		end
	elseif type(arg) == "number" then
		MEKA_Totem: SetScale(arg)
	end
end

MEKA_Totem.Load = MEKA_Totem_Load
F.MEKA_Totem_Toggle = MEKA_Totem_Toggle
insert(E.Module, MEKA_Totem)