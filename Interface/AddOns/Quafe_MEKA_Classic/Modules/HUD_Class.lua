local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale

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

local BurstHaste = {
	"146555", --暴怒之鼓
	"178207", --狂怒战鼓
	"230935", --高山战鼓
	"2825", --嗜血
	"32182", --英勇
	"80353", --时间扭曲
	"90355", --远古狂乱
	"160452", --虚空之风
}

--- ------------------------------------------------------------
--> Ammo amount
--- ------------------------------------------------------------

--[[
PLAYER_EQUIPMENT_CHANGED
UNIT_INVENTORY_CHANGED
BAG_UPDATE
--]]
--local ammoCount = GetInventoryItemCount("player", ammoSlot);

local function AmmoCount_Artwork(frame)
	frame.Text = F.create_Font(frame, C.Font["NumSmall"], 12, nil, 0.8, "LEFT", "CENTER")
	frame.Text: SetPoint("LEFT", frame, "RIGHT", 10,0)
end

local function AmmoCount_RgEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	frame: RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
	frame: RegisterEvent("BAG_UPDATE")
end

local function AmmoCount_OnEvent(frame)
	frame: SetScript("OnEvent", function(self, event)
		local ammo = GetInventoryItemCount("player", 0);
		if ammo > 0 then
			if frame.State == "Hide" then
				frame: Show()
				frame.State = "Show"
			end
			self.Text: SetText(F.FormatNum(ammo, 1, false))
		end
	end)
end

local function AmmoCount_Frame(frame)
	local AmmoCount = CreateFrame("Frame", nil, frame)
	AmmoCount: SetSize(8, 42)
	--AmmoCount: SetPoint("CENTER", frame, "CENTER", -113,0)
	AmmoCount: SetPoint("CENTER", frame, "CENTER", 0,0)
	AmmoCount: Hide()
	AmmoCount.State = "Hide"

	AmmoCount_Artwork(AmmoCount)
	AmmoCount_RgEvent(AmmoCount)
	AmmoCount_OnEvent(AmmoCount)

	frame.AmmoCount = AmmoCount
end


--- ------------------------------------------------------------
--> Auto shot
--- ------------------------------------------------------------

--['自动射击'] = 75
--frame:RegisterEvent("START_AUTOREPEAT_SPELL")
--frame:RegisterEvent("STOP_AUTOREPEAT_SPELL")

local PlayerGuid = UnitGUID("player")

local function AutoShot_Artwork(frame, pos)
	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("TieBar4\\Bar1"))
	Bg: SetVertexColor(F.Color(C.Color.W1))
	Bg: SetAlpha(0.6)
	Bg: SetSize(8, 42)
	Bg: SetTexCoord(12/16,4/16, 11/64,53/64)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bg_Glow = frame: CreateTexture(nil, "BORDER")
	Bg_Glow: SetTexture(F.Path("TieBar4\\Bar1"))
	Bg_Glow: SetVertexColor(F.Color(C.Color.W3))
	Bg_Glow: SetAlpha(0.1)
	Bg_Glow: SetSize(8, 42)
	Bg_Glow: SetTexCoord(12/16,4/16, 11/64,53/64)
	Bg_Glow: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bar = frame: CreateTexture(nil, "ARTWORK")
	Bar: SetTexture(F.Path("TieBar4\\Bar1"))
	Bar: SetVertexColor(F.Color(C.Color.B3))
	Bar: SetAlpha(1)
	Bar: SetSize(8, 42)
	Bar: SetTexCoord(12/16,4/16, 11/64,53/64)
	Bar: SetPoint("BOTTOM", Bg, "BOTTOM", 0,0)

	local nonius = frame: CreateTexture(nil, "OVERLAY")
	nonius: SetTexture(F.Path("TieBar4\\Border1"))
	nonius: SetVertexColor(F.Color(C.Color.W3))
	nonius: SetAlpha(1)
	nonius: SetSize(32,32)
	nonius: SetPoint("CENTER", pos, "CENTER", 118*cos(rad(170)), 118*sin(rad(170)))
	F.RotateTexture(nonius, -10)

	local Bd = CreateFrame("Frame", nil, frame)
	for i = 1,3 do
		Bd[i] = Bd: CreateTexture(nil, "BACKGROUND")
		Bd[i]: SetTexture(F.Path("TieBar4\\Border2"))
		Bd[i]: SetVertexColor(F.Color(C.Color.W3))
		Bd[i]: SetAlpha(0.8)
		Bd[i]: SetSize(8,8)
		Bd[i]: SetPoint("CENTER", p, "CENTER", 121*cos(rad(190-10*(i-1))), 121*sin(rad(190-10*(i-1))))
		F.RotateTexture(Bd[i], 190-10*(i-1))
	end

	frame.Text = F.create_Font(frame, C.Font["NumSmall"], 12, nil, 0.8, "LEFT", "CENTER")
	frame.Text: SetPoint("LEFT", Bg, "RIGHT", 20,0)

	frame.Bar = Bar
	frame.Nonius = nonius
end

local function Mirror_Refresh(f)
	f.Mode = "UNKNOWN"
	f.Duration = 0
	f.Text: SetText(" ")
end

local function AutoShotBar_Update(frame, d, p)
	if d > 1 then d = 1 end
	if d < 0 then d = 0 end
	local r = d * 20

	frame.Bar: SetSize(8, 42*d+F.Debug)
	frame.Bar: SetTexCoord(12/16,4/16, (11+42*abs(1-d))/64,53/64)
	frame.Nonius: SetPoint("CENTER", p, "CENTER", 118*cos(rad(190-r)), 118*sin(rad(190-r)))
	F.RotateTexture(frame.Nonius, 10-r)
end

local function AutoShot_Update(frame, d, pos)
	if not d then return end
	local normal = true
	frame: SetAlpha(1)
	frame.Bar: SetVertexColor(F.Color(C.Color.B3))
	local duration = d
	frame: SetScript("OnUpdate", function(self, elapsed)
		AutoShotBar_Update(frame, (1-d/duration), pos)
		if d < 0.5 and normal then
			frame.Bar: SetVertexColor(F.Color(C.Color.R3))
			normal = false
		end
		d = d - elapsed
		if d < 0 then
			self: SetScript("OnUpdate", nil)
			self: SetAlpha(0)
		end
	end)
end

local function AutoShot_Event(frame, event, pos)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		--local timestamp, subevent, _, sourceGuid, sourceName, sourceFlags, sourceRaidFlags, destGuid, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()
		local eventInfo = {CombatLogGetCurrentEventInfo()}
		if eventInfo[2] == "RANGE_DAMAGE" and eventInfo[4] == PlayerGuid then
			--[13] 自动射击
			--speed, lowDmg, hiDmg, posBuff, negBuff, percent = UnitRangedDamage("player")
			local speed = UnitRangedDamage("player")
			AutoShot_Update(frame, speed, pos)
		end
	end
end

local function AutoShot_RgEvent(frame)
	frame: RegisterEvent("START_AUTOREPEAT_SPELL")
	frame: RegisterEvent("STOP_AUTOREPEAT_SPELL")
	frame: RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local function AutoShot_OnEvent(frame, pos)
	frame: SetScript("OnEvent", function(self, event)
		AutoShot_Event(self, event, pos)
	end)
end

local function AutoShot_Frame(frame)
	local AutoShot = CreateFrame("Frame", nil, frame)
	AutoShot: SetSize(8, 42)
	AutoShot: SetPoint("CENTER", frame, "CENTER", -113,0)
	AutoShot: SetAlpha(0)

	AutoShot_Artwork(AutoShot, frame)
	AutoShot_RgEvent(AutoShot)
	AutoShot_OnEvent(AutoShot, frame)
	AmmoCount_Frame(AutoShot)

	frame.AutoShot = AutoShot
end

local function AutoShot_Toggle(frame, arg1)
	if not frame.AutoShot then return end
	if arg1 == "ON" then
		AutoShot_RgEvent(frame.AutoShot)
		frame.AutoShot: Show()
	elseif arg1 == "OFF" then
		frame.AutoShot: UnregisterAllEvents()
		frame.AutoShot: Hide()
	end
end

--- ------------------------------------------------------------
--> Load
--- ------------------------------------------------------------

local MEKA_Class = CreateFrame("Frame", "MEKA_ClassBar", E)
MEKA_Class: SetSize(202,54)
MEKA_Class: SetPoint("CENTER", UIParent, "CENTER", 0,0)
MEKA_Class.Init = false
MEKA_Class.Info = {}

local function MEKA_Class_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].Enable then
		AutoShot_Frame(MEKA_Class)
	end
end

local function MEKA_Class_Toggle(arg1, arg2)
	if not arg2 then
		if arg1 == "ON" then
			MEKA_Class: Show()
			if not MEKA_Class.Init then
				MEKA_Class_Load()
			end
		elseif arg1 == "OFF" then
			MEKA_Class: Hide()
		elseif arg1 == "Refresh" then
			--MEKA_Class_Point_Toggle(MEKA_Class, arg1)
		elseif type(arg1) == "number" then
			MEKA_Class: SetScale(arg1)
		end
		AutoShot_Toggle(MEKA_Class, arg1)
		--MEKA_Class_Point_Toggle(MEKA_Class, arg1)
		--MEKA_Class_Runes_Toggle(MEKA_Class, arg1)
	elseif arg2 == "ClassPoint" then
		--MEKA_Class_Point_Toggle(MEKA_Class, arg1)
	elseif arg2 == "Rune" then
		--MEKA_Class_Runes_Toggle(MEKA_Class, arg1)
	elseif arg2 == "AutoShot" then
		AutoShot_Toggle(MEKA_Class, arg1)
	end
end

local MEKA_Class_Config = {
	Database = {
		["MEKA_Class"] = {
			Enable = true,
			ClassPoint = true,
			Rune = true,
			AutoShot = true,
		},
	},

	Config = {
		Name = "MEKA "..L['CLASS'],
		Type = "Switch",
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_Class_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].Enable = true
				self.Text:SetText(L["ON"])
				MEKA_Class_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['AUTOSHOT_BAR'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].AutoShot then
						Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].AutoShot = false
						self.Text:SetText(L["OFF"])
						MEKA_Class_Toggle("OFF", "AutoShot")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].AutoShot = true
						self.Text:SetText(L["ON"])
						MEKA_Class_Toggle("ON", "AutoShot")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_Class"].AutoShot then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}

MEKA_Class.Load = MEKA_Class_Load
MEKA_Class.Config = MEKA_Class_Config
F.MEKA_Class_Toggle = MEKA_Class_Toggle
insert(E.Module, MEKA_Class)