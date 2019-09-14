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

--- ------------------------------------------------------------
--> Create Player CastBar
--- ------------------------------------------------------------

local function PlayerCastBar_ColorRing(frame, color)
	frame.LR.Ring: SetVertexColor(F.Color(color))
	frame.RR.Ring: SetVertexColor(F.Color(color))
end

local function PlayerCastBar_UpdateRing(frame, d)
	if not d then d = 1 end
	d = min(max(d, 0), 1)
	if frame.LR then
		frame.LR.Ring:SetRotation(math.rad(frame.LR.Base-frame.LR.Range*d))
	end
	if frame.RR then
		frame.RR.Ring:SetRotation(math.rad(frame.RR.Base+frame.RR.Range*d))
	end
end

local function Ring_Artwork(frame, size, texture, bgangle)
	local SC = CreateFrame("Frame", nil, frame)
	SC: SetSize(size, size)
	frame: SetScrollChild(SC)
	
	local Ring = SC:CreateTexture(nil, "ARTWORK")
	Ring: SetTexture(MEKA.Path(texture))
	Ring: SetSize(size, size)
    Ring: SetPoint("CENTER")
    Ring: SetVertexColor(F.Color(C.Color.Main1))
	Ring: SetAlpha(1)
	--Ring: SetBlendMode("BLEND")
	Ring: SetRotation(math.rad(frame.Base))

	local RingBg = SC:CreateTexture(nil, "BACKGROUND")
	RingBg: SetTexture(MEKA.Path(texture.."_Sd"))
	RingBg: SetSize(size, size)
    RingBg: SetPoint("CENTER")
    RingBg: SetVertexColor(F.Color(C.Color.Main0))
	RingBg: SetAlpha(0.25)
	RingBg: SetRotation(math.rad(frame.Base+bgangle))

	frame.Ring = Ring
	frame.RingBg = RingBg
end

local function Create_Ring(frame, size, texture)
	frame.LR = CreateFrame("ScrollFrame", nil, frame)
	frame.LR: SetSize((size)/2, size)
	frame.LR: SetPoint("RIGHT", frame, "CENTER", 0,0)
	frame.LR.Base = 0
	frame.LR.Range = 30
	Ring_Artwork(frame.LR, size, texture, -30)
	
	frame.RR = CreateFrame("ScrollFrame", nil, frame)
	frame.RR: SetSize((size)/2, size)
	frame.RR: SetPoint("LEFT", frame, "CENTER", 0,0)
	frame.RR: SetHorizontalScroll((size)/2)
	frame.RR.Base = -180
	frame.RR.Range = 30
	Ring_Artwork(frame.RR, size, texture, 30)
end

local function PlayerCastBar_Artwork(frame)
	local LeftBD = frame:CreateTexture(nil, "ARTWORK")
	LeftBD: SetTexture(MEKA.Path("RingBar\\Castbar1_Bd1"))
	LeftBD: SetVertexColor(F.Color(C.Color.Warn1))
	LeftBD: SetAlpha(0.9)
	LeftBD: SetSize(32,32)
	LeftBD: SetPoint("CENTER", frame, "CENTER", 175*cos(rad(-122)), 175*sin(rad(-122)))
	F.RotateTexture(LeftBD, -32)

	local RightBD = frame:CreateTexture(nil, "ARTWORK")
	RightBD: SetTexture(MEKA.Path("RingBar\\Castbar1_Bd1"))
	RightBD: SetVertexColor(F.Color(C.Color.Warn1))
	RightBD: SetAlpha(0.9)
	RightBD: SetSize(32,32)
	RightBD: SetPoint("CENTER", frame, "CENTER", 175*cos(rad(-58)), 175*sin(rad(-58)))
	F.RotateTexture(RightBD, 32)

	local Num = {}
	for i = 1,7 do
		Num[i] = frame:CreateTexture(nil, "ARTWORK")
		Num[i]: SetTexture(MEKA.Path("N12\\N0"))
		Num[i]: SetVertexColor(F.Color(C.Color.Warn1))
		Num[i]: SetAlpha(1)
		Num[i]: SetSize(32,32)
		Num[i]: SetPoint("CENTER", frame, "CENTER", 190*cos(rad(-90-12+3*i)), 190*sin(rad(-90-12+3*i)))
		F.RotateTexture(Num[i], -12+3*i)
	end

	frame.Num = Num
end

local function PlayerCastBar_ColorNum(frame, color)
	for i = 1,7 do
		frame.Num[i]: SetVertexColor(F.Color(color))
	end
end

local function Conversion_Time(time)
	local v1,v2,v3
	if time then
		if time < 0 then time = 0 end
		if time > 99 then time = 99 end
	else
		time = 0 
	end
	if time < 10 then
		time = time * 10
		v2 = "p"
	else
		v2 = "b"
	end
	v1 = floor(time/10)
	v3 = floor(time) - v1*10
	return v1,v2,v3
end

local function PlayerCastBar_UnpdateNum(frame, blank)
	if blank then
		for i = 1,7 do
			frame.Num[i]: SetTexture(MEKA.Path("N12\\Nb"))
		end
	else
		frame.Num[4]: SetTexture(MEKA.Path("N12\\Nslash"))
		local v1,v2,v3,v4,v5,v6
		if frame.Channeling then
			v1,v2,v3 = Conversion_Time(frame.Value)
		else
			v1,v2,v3 = Conversion_Time(frame.MaxValue-frame.Value)
		end

		v4,v5,v6 = Conversion_Time(frame.MaxValue)
		if v2 == "p" then
			frame.Num[1]: SetTexture(MEKA.Path("N12\\N"..v1))
			frame.Num[2]: SetTexture(MEKA.Path("N12\\N"..v2))
			frame.Num[3]: SetTexture(MEKA.Path("N12\\N"..v3))
		elseif v2 == "b" then
			frame.Num[1]: SetTexture(MEKA.Path("N12\\N"..v2))
			frame.Num[2]: SetTexture(MEKA.Path("N12\\N"..v1))
			frame.Num[3]: SetTexture(MEKA.Path("N12\\N"..v3))
		end
		if v5 == "p" then
			frame.Num[5]: SetTexture(MEKA.Path("N12\\N"..v4))
			frame.Num[6]: SetTexture(MEKA.Path("N12\\N"..v5))
			frame.Num[7]: SetTexture(MEKA.Path("N12\\N"..v6))
		elseif v5 == "b" then
			frame.Num[5]: SetTexture(MEKA.Path("N12\\N"..v4))
			frame.Num[6]: SetTexture(MEKA.Path("N12\\N"..v6))
			frame.Num[7]: SetTexture(MEKA.Path("N12\\N"..v5))
		end
	end
end

local function PlayerCastBar_ApplyUpdate(frame, value)
	if value then
		PlayerCastBar_UpdateRing(frame, value)
	end
	PlayerCastBar_UpdateRing(frame, frame.Value/frame.MaxValue)
	PlayerCastBar_UnpdateNum(frame, value)
end

local function PlayerCastBar_ApplyAlpha(frame, alpha)
	frame: SetAlpha(alpha)
end

local CAST_COLOR = {
	Cast = C.Color.Blue,
	Shield = C.Color.Yellow,
	Stop = C.Color.Green,
	Fail = C.Color.Red,
}

local function PlayerCastBar_ApplyColor(frame, state, notInterruptible)
	if state == "Start" then
		if notInterruptible then
			PlayerCastBar_ColorRing(frame, CAST_COLOR.Shield)
			PlayerCastBar_ColorNum(frame, CAST_COLOR.Shield)
		else
			PlayerCastBar_ColorRing(frame, CAST_COLOR.Cast)
			PlayerCastBar_ColorNum(frame, CAST_COLOR.Cast)
		end
	elseif state == "Finished" then
		PlayerCastBar_ColorRing(frame, CAST_COLOR.Stop)
		PlayerCastBar_ColorNum(frame, CAST_COLOR.Stop)
	elseif state == "Failed" then
		PlayerCastBar_ColorRing(frame, CAST_COLOR.Fail)
		PlayerCastBar_ColorNum(frame, CAST_COLOR.Fail)
	end
end

local function PlayerCastBar_Create(frame)
	local PlayerCastBar = CreateFrame("frame", "MEKA_PlayerCastBar", frame)
	PlayerCastBar: SetSize(16, 16)
	PlayerCastBar: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	PlayerCastBar.RingSize = 512

	Create_Ring(PlayerCastBar, PlayerCastBar.RingSize, "RingBar\\Castbar1")
	PlayerCastBar_Artwork(PlayerCastBar)

	PlayerCastBar.Unit = "player"
	PlayerCastBar.EnableCastbar = true
	PlayerCastBar.ShowCastbar = true
	PlayerCastBar.ShowTradeSkills = true
	PlayerCastBar.ApplyUpdate = PlayerCastBar_ApplyUpdate
	PlayerCastBar.ApplyAlpha = PlayerCastBar_ApplyAlpha
	PlayerCastBar.ApplyColor = PlayerCastBar_ApplyColor
	F.CastBar_Create(PlayerCastBar)

	frame.PlayerCastBar = PlayerCastBar
end

--- ------------------------------------------------------------
--> Create Pet CastBar
--- ------------------------------------------------------------

local function PetCastBar_Artwork(frame)
	local LeftBD = frame:CreateTexture(nil, "ARTWORK")
	LeftBD: SetTexture(MEKA.Path("RingBar\\Castbar1_Bd1"))
	LeftBD: SetVertexColor(F.Color(C.Color.Warn1))
	LeftBD: SetAlpha(0.9)
	LeftBD: SetSize(32,32)
	LeftBD: SetPoint("CENTER", frame, "CENTER", 150*cos(rad(-122)), 150*sin(rad(-122)))
	F.RotateTexture(LeftBD, -32)

	local RightBD = frame:CreateTexture(nil, "ARTWORK")
	RightBD: SetTexture(MEKA.Path("RingBar\\Castbar1_Bd1"))
	RightBD: SetVertexColor(F.Color(C.Color.Warn1))
	RightBD: SetAlpha(0.9)
	RightBD: SetSize(32,32)
	RightBD: SetPoint("CENTER", frame, "CENTER", 150*cos(rad(-58)), 150*sin(rad(-58)))
	F.RotateTexture(RightBD, 32)

	local Num = {}
	for i = 1,7 do
		Num[i] = frame:CreateTexture(nil, "ARTWORK")
		Num[i]: SetTexture(MEKA.Path("N12\\N0"))
		Num[i]: SetVertexColor(F.Color(C.Color.Warn1))
		Num[i]: SetAlpha(1)
		Num[i]: SetSize(32,32)
		Num[i]: SetPoint("CENTER", frame, "CENTER", 135*cos(rad(-90-16+4*i)), 135*sin(rad(-90-16+4*i)))
		F.RotateTexture(Num[i], -16+4*i)
	end

	frame.Num = Num
end

local function PetCastBar_OnEvent(frame, event, ...)
	local arg1 = ...;
	if ( event == "UNIT_PET" ) then
		if ( arg1 == "player" ) then
			frame.ShowCastbar = UnitIsPossessed("pet");

			if ( not frame.ShowCastbar ) then
				frame: Hide();
			elseif ( frame.Casting or frame.Channeling ) then
				frame: Show();
			end
		end
		return
	end
end

local function PetCastBar_Create(frame)
	local PetCastBar = CreateFrame("frame", "MEKA_PetCastBar", frame)
	PetCastBar: SetSize(16, 16)
	PetCastBar: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	PetCastBar.RingSize = 512

	Create_Ring(PetCastBar, PetCastBar.RingSize, "RingBar\\Castbar2")
	PetCastBar_Artwork(PetCastBar)

	PetCastBar: RegisterEvent("UNIT_PET")

	PetCastBar.Unit = "pet"
	PetCastBar.EnableCastbar = true
	PetCastBar.ShowCastbar = UnitIsPossessed("pet")
	PetCastBar.ShowTradeSkills = false
	PetCastBar.ApplyUpdate = PlayerCastBar_ApplyUpdate
	PetCastBar.ApplyAlpha = PlayerCastBar_ApplyAlpha
	PetCastBar.ApplyColor = PlayerCastBar_ApplyColor
	PetCastBar.ApplyEvent = PetCastBar_OnEvent
	F.CastBar_Create(PetCastBar)

	frame.PetCastBar = PetCastBar
end

----------------------------------------------------------------
--> GCD
----------------------------------------------------------------

local function GCD_Artwork(frame)
	local Bg1 = frame: CreateTexture(nil, "BACKGROUND")
	Bg1: SetTexture(MEKA.Path("RingBar\\Bar5_Bar"))
	Bg1: SetVertexColor(F.Color(C.Color.Main0))
	Bg1: SetAlpha(0.65)
	Bg1: SetSize(55,32)
	Bg1: SetTexCoord(0/4096,110/4096, 0,1)
	Bg1: SetPoint("BOTTOMLEFT", frame, "BOTTOM", 0,0)

	local BgGlow1 = frame: CreateTexture(nil, "BORDER")
	BgGlow1: SetTexture(MEKA.Path("RingBar\\Bar5_Bar"))
	BgGlow1: SetVertexColor(F.Color(C.Color.Main1))
	BgGlow1: SetAlpha(0.15)
	BgGlow1: SetSize(55,32)
	BgGlow1: SetTexCoord(0/4096,110/4096, 0,1)
	BgGlow1: SetPoint("BOTTOMLEFT", frame, "BOTTOM", 0,0)

	local Bg2 = frame: CreateTexture(nil, "BACKGROUND")
	Bg2: SetTexture(MEKA.Path("RingBar\\Bar5_Bar"))
	Bg2: SetVertexColor(F.Color(C.Color.Main0))
	Bg2: SetAlpha(0.65)
	Bg2: SetSize(55,32)
	Bg2: SetTexCoord(110/4096,0/4096, 0,1)
	Bg2: SetPoint("BOTTOMRIGHT", frame, "BOTTOM", 0,0)

	local BgGlow2 = frame: CreateTexture(nil, "BORDER")
	BgGlow2: SetTexture(MEKA.Path("RingBar\\Bar5_Bar"))
	BgGlow2: SetVertexColor(F.Color(C.Color.Main1))
	BgGlow2: SetAlpha(0.15)
	BgGlow2: SetSize(55,32)
	BgGlow2: SetTexCoord(110/4096,0/4096, 0,1)
	BgGlow2: SetPoint("BOTTOMRIGHT", frame, "BOTTOM", 0,0)

	local Gloss = frame: CreateTexture(nil, "BACKGROUND")
	Gloss: SetTexture(MEKA.Path("RingBar\\Bar5_Bar"))
	Gloss: SetVertexColor(F.Color(C.Color.Main1))
	Gloss: SetAlpha(0.25)
	Gloss: SetSize(114,32)
	Gloss: SetTexCoord(3868/4096,4096/4096, 0,1)
	Gloss: SetPoint("BOTTOM", frame, "BOTTOM", 0,0)

	local BarR = frame: CreateTexture(nil, "ARTWORK")
	BarR: SetTexture(MEKA.Path("RingBar\\Bar5_Bar"))
	BarR: SetVertexColor(F.Color(C.Color.Main1))
	BarR: SetAlpha(1)
	BarR: SetSize(55,32)
	BarR: SetTexCoord(0/4096,110/4096, 0,1)
	BarR: SetPoint("BOTTOMLEFT", frame, "BOTTOM", 0,0)

	local BarL = frame: CreateTexture(nil, "ARTWORK")
	BarL: SetTexture(MEKA.Path("RingBar\\Bar5_Bar"))
	BarL: SetVertexColor(F.Color(C.Color.Main1))
	BarL: SetAlpha(1)
	BarL: SetSize(55,32)
	BarL: SetTexCoord(110/4096,0/2048, 0,1)
	BarL: SetPoint("BOTTOMRIGHT", frame, "BOTTOM", 0,0)

	frame.BarL = BarL
	frame.BarR = BarR
	frame.Gloss = Gloss
end



local function GCD_Update(frame, d, remain)
	if not d then d = 0 end
	if d > 1 then d = 1 end
	if d < 0 then d = 0 end

	--f.Bar: SetSize(154, 34*d+F.Debug)
	--f.Bar: SetTexCoord(51/256,205/256, (15+34*abs(1-d))/64,49/64)
	--f.Text: SetText(format("%.1f", remain))

	d = floor(d*22+0.5)
	frame.BarR: SetTexCoord((110*abs(22-d))/4096,(110*abs(23-d))/4096, 0,1)
	frame.BarL: SetTexCoord((110*abs(23-d))/4096,(110*abs(22-d))/4096, 0,1)

	if remain <= frame.SQW then
		frame.BarL: SetVertexColor(F.Color(C.Color.Main2))
		frame.BarR: SetVertexColor(F.Color(C.Color.Main2))
		frame.Gloss: SetVertexColor(F.Color(C.Color.Main2))
	else
		frame.BarL: SetVertexColor(F.Color(C.Color.Main1))
		frame.BarR: SetVertexColor(F.Color(C.Color.Main1))
		frame.Gloss: SetVertexColor(F.Color(C.Color.Main1))
	end
end

local function Get_GCD()
	local start, duration, enabled = GetSpellCooldown(61304)
	local remain = max((GetTime() - start), 0)
	return remain, duration
end

local function Get_GCD_Classic(unit, guid, spell)
	local start, duration, remain = 0,0,0
	if unit == "player" then
		start, duration = GetSpellCooldown(spell)
		if duration and duration > 0 and duration <= 1.5 then
			remain = max((GetTime() - start), 0)
		else
			duration = 0
		end
	end
	return remain, duration
end

local function GCD_Frame(f)
	f.GCD = CreateFrame("Frame", nil, f)
	f.GCD: SetSize(112,82)
	f.GCD: SetPoint("TOP", f, "CENTER", 0,0)
	f.GCD.SQW = 0.4
	f.GCD: Hide()
	GCD_Artwork(f.GCD)

	f.GCD: RegisterEvent("SPELL_UPDATE_COOLDOWN")
	f.GCD: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.GCD: RegisterEvent("CVAR_UPDATE")
	--f.GCD: RegisterEvent("PLAYER_REGEN_DISABLED")
	--f.GCD: RegisterEvent("PLAYER_REGEN_ENABLED")
	f.GCD: SetScript("OnEvent", function(self,event)
		if event == "PLAYER_ENTERING_WORLD" or event == "SPELL_UPDATE_COOLDOWN" then
			f.GCD.Remain, f.GCD.CD = Get_GCD()
			if (f.GCD.Remain > 0 and f.GCD.CD > f.GCD.Remain) then
				f.GCD: Show()
				f.GCD: SetScript("OnUpdate", function(self, elapsed)
					if f.GCD.Remain > 0 and f.GCD.CD > f.GCD.Remain then
						GCD_Update(self, f.GCD.Remain/f.GCD.CD, f.GCD.CD-f.GCD.Remain)
						f.GCD.Remain = f.GCD.Remain + elapsed
					else
						GCD_Update(self, 0, 0)
						f.GCD: Hide()
						f.GCD: SetScript("OnUpdate", nil)
					end
				end)
			end
		end
		if event == "PLAYER_ENTERING_WORLD" or event == "CVAR_UPDATE" then
			self.SQW = GetCVar("SpellQueueWindow")/1000
		end
	end)
end

local function GCD_Classic_Frame(frame)
	frame.GCD = CreateFrame("Frame", nil, frame)
	frame.GCD: SetSize(112,82)
	frame.GCD: SetPoint("TOP", f, "CENTER", 0,0)
	frame.GCD.SQW = 0.4
	frame.GCD: Hide()
	GCD_Artwork(frame.GCD)

	frame.GCD: RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
	frame.GCD: RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
	frame.GCD: RegisterEvent("CVAR_UPDATE")
	frame.GCD: SetScript("OnEvent", function(self, event, arg1, arg2, arg3)
		if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED" then
			frame.GCD.Remain, frame.GCD.CD = Get_GCD_Classic(arg1, arg2, arg3)
			if (frame.GCD.Remain > 0 and frame.GCD.CD > frame.GCD.Remain) then
				frame.GCD: Show()
				frame.GCD: SetScript("OnUpdate", function(self, elapsed)
					if frame.GCD.Remain > 0 and frame.GCD.CD > frame.GCD.Remain then
						GCD_Update(self, frame.GCD.Remain/frame.GCD.CD, frame.GCD.CD-frame.GCD.Remain)
						frame.GCD.Remain = frame.GCD.Remain + elapsed
					else
						GCD_Update(self, 0, 0)
						frame.GCD: Hide()
						frame.GCD: SetScript("OnUpdate", nil)
					end
				end)
			end
		end
		if event == "PLAYER_ENTERING_WORLD" or event == "CVAR_UPDATE" then
			self.SQW = GetCVar("SpellQueueWindow")/1000
		end
	end)
end

--- ------------------------------------------------------------
--> Mirror
--- ------------------------------------------------------------

local function Mirror_Artwork(f, p)
	local Bg = f: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("TieBar4\\Bar1"))
	Bg: SetVertexColor(F.Color(C.Color.W1))
	Bg: SetAlpha(0.6)
	Bg: SetSize(8, 42)
	Bg: SetTexCoord(4/16,12/16, 11/64,53/64)
	Bg: SetPoint("CENTER", f, "CENTER", 0,0)

	local Bg_Glow = f: CreateTexture(nil, "BORDER")
	Bg_Glow: SetTexture(F.Path("TieBar4\\Bar1"))
	Bg_Glow: SetVertexColor(F.Color(C.Color.W3))
	Bg_Glow: SetAlpha(0.1)
	Bg_Glow: SetSize(8, 42)
	Bg_Glow: SetTexCoord(4/16,12/16, 11/64,53/64)
	Bg_Glow: SetPoint("CENTER", f, "CENTER", 0,0)

	local Bar = f: CreateTexture(nil, "ARTWORK")
	Bar: SetTexture(F.Path("TieBar4\\Bar1"))
	Bar: SetVertexColor(F.Color(C.Color.B3))
	Bar: SetAlpha(0.8)
	Bar: SetSize(8, 42)
	Bar: SetTexCoord(4/16,12/16, 11/64,53/64)
	Bar: SetPoint("BOTTOM", Bg, "BOTTOM", 0,0)

	local nonius = f: CreateTexture(nil, "OVERLAY")
	nonius: SetTexture(F.Path("TieBar4\\Border1"))
	nonius: SetVertexColor(F.Color(C.Color.W3))
	nonius: SetAlpha(0.8)
	nonius: SetSize(32,32)
	nonius: SetPoint("CENTER", p, "CENTER", 118*cos(rad(10)), 118*sin(rad(10)))
	F.RotateTexture(nonius, 10)

	local Bd = CreateFrame("Frame", nil, f)
	for i = 1,3 do
		Bd[i] = Bd: CreateTexture(nil, "BACKGROUND")
		Bd[i]: SetTexture(F.Path("TieBar4\\Border2"))
		Bd[i]: SetVertexColor(F.Color(C.Color.W3))
		Bd[i]: SetAlpha(0.8)
		Bd[i]: SetSize(8,8)
		Bd[i]: SetPoint("CENTER", p, "CENTER", 121*cos(rad(-10+10*(i-1))), 121*sin(rad(-10+10*(i-1))))
		F.RotateTexture(Bd[i], -10+10*(i-1))
	end

	f.Text = F.create_Font(f, C.Font["NumSmall"], 12, nil, 0.8, "LEFT", "CENTER")
	--f.Text: SetPoint("LEFT", Bg, "RIGHT", 20,0)
	f.Text: SetPoint("RIGHT", Bg, "LEFT", -10,0)

	f.Bar = Bar
	f.Nonius = nonius
end

local function Mirror_Refresh(f)
	f.Mode = "UNKNOWN"
	f.Duration = 0
	f.Text: SetText(" ")
end

local function TieBar4_Update(f, d, p)
	if not d then d = 0 end
	if d > 1 then d = 1 end
	if d < 0 then d = 0 end
	local r = d * 20

	f.Bar: SetSize(8, 42*d+F.Debug)
	f.Bar: SetTexCoord(4/16,12/16, (11+42*abs(1-d))/64,53/64)
	f.Nonius: SetPoint("CENTER", p, "CENTER", 118*cos(rad(-10+r)), 118*sin(rad(-10+r)))
	F.RotateTexture(f.Nonius, -10+r)
end

local function Mirror_Update(f, p)
	if f.Mode ~= "UNKNOWN" then
		local value = GetMirrorTimerProgress(f.Mode)
		value = value > f.Duration and f.Duration or value
		TieBar4_Update(f, value/f.Duration, p)
		f.Text: SetText(F.FormatTime(value/1000))
	else
		for i = 1, MIRRORTIMER_NUMTIMERS do
			if i == 2 then
				local timer, initial, maxvalue, scale, paused, label = GetMirrorTimerInfo(i)
				if timer ~= "UNKNOWN" then
					f.Mode = timer
					f.Duration = maxvalue
				end
			end
		end
	end
end

local function Mirror_OnUpdate(f, p)
	f: SetScript("OnUpdate", function(self, elapsed)
		Mirror_Update(self, p)
	end)
end

local function Mirror_Event(f, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "MIRROR_TIMER_START" or event == "MIRROR_TIMER_PAUSE" then
		local currentTime = GetTime()
		Mirror_Refresh(f)
		for i = 1, MIRRORTIMER_NUMTIMERS do
			--1 = Fatigue, 2 = Breath, 3 = Feign Death.
			if i == 2 then
				local timer, initial, maxvalue, scale, paused, label = GetMirrorTimerInfo(i)
				--timer: "EXHAUSTION", "BREATH", and "FEIGNDEATH", or "UNKNOWN"
				if timer ~= "UNKNOWN" then
					f.Mode = timer
					f.Duration = maxvalue
				end
			end
		end
		if event == "PLAYER_ENTERING_WORLD" then
			if f.Mode == "UNKNOWN" then
				f: Hide()
			else
				f: Show()
			end
		end
	end
	
	if event == "MIRROR_TIMER_START" then
		f: Show()
	elseif event == "MIRROR_TIMER_STOP" then
		f: Hide()
	end
end

local function Mirror_OnEvent(f)
	f: RegisterEvent("PLAYER_ENTERING_WORLD")
	f: RegisterEvent("MIRROR_TIMER_PAUSE")
	f: RegisterEvent("MIRROR_TIMER_START")
	f: RegisterEvent("MIRROR_TIMER_STOP")
	f: RegisterEvent("READY_CHECK")
	f: RegisterEvent("READY_CHECK_FINISHED")
	--f: RegisterEvent("LFG_PROPOSAL_FAILED")
	--f: RegisterEvent("LFG_PROPOSAL_SUCCEEDED")
	f: SetScript("OnEvent", function(self, event)
		Mirror_Event(self, event)
	end)
end

local function Mirror_Frame(f)
	local Mirror = CreateFrame("Frame", nil, f)
	Mirror: SetSize(8, 42)
	Mirror: SetPoint("CENTER", f, "CENTER", 113,0)

	Mirror_Artwork(Mirror, f)
	Mirror_Refresh(Mirror)
	Mirror_OnEvent(Mirror, f)
	Mirror_OnUpdate(Mirror, f)

	f.Mirror = Mirror
end

--- ------------------------------------------------------------
--> MEKA CastBar
--- ------------------------------------------------------------

local MEKA_CastBar = CreateFrame("frame", nil, E)
MEKA_CastBar: SetSize(16, 16)
MEKA_CastBar: SetPoint("CENTER", UIParent, "CENTER", 0,0)
MEKA_CastBar.Init = false

local function MEKA_CastBar_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].Enable then
		PlayerCastBar_Create(MEKA_CastBar)
		PetCastBar_Create(MEKA_CastBar)
		if F.IsClassic then
			GCD_Classic_Frame(MEKA_CastBar)
		else
			GCD_Frame(MEKA_CastBar)
		end
		Mirror_Frame(MEKA_CastBar)
		F.HideFrame(CastingBarFrame, true, true)
		F.HideFrame(PetCastingBarFrame, true, true)
		--F.HideFrame(MirrorTimer1, true, true)
		F.HideFrame(MirrorTimer2, true, true)
		--F.HideFrame(MirrorTimer3, true, true)

		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale then
			MEKA_CastBar: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale)
		end

		MEKA_CastBar.Init = true
	end
end

local function MEKA_CastBar_Toggle(arg1, arg2)
	if arg1 == "ON" then
		if not arg2 then
			MEKA_CastBar: Show()
			if not MEKA_CastBar.Init then
				MEKA_CastBar_Load()
			end
		elseif arg2 == "Player" then
			MEKA_CastBar.PlayerCastBar.EnableCastbar = true
			MEKA_CastBar.PetCastBar.EnableCastbar = true
		end
	elseif arg1 == "OFF" then
		if not arg2 then
			MEKA_CastBar: Hide()
		elseif arg2 == "Player" then
			MEKA_CastBar.PlayerCastBar.EnableCastbar = false
			MEKA_CastBar.PetCastBar.EnableCastbar = false
		end
	elseif type(arg1) == "number" then
		MEKA_CastBar: SetScale(arg1)
	end
end

local MEKA_CastBar_Config = {
	Database = {
		["MEKA_CastBar"] = {
			Enable = true,
			PlayerCastBar = true,
		},
	},

	Config = {
		Name = "MEKA "..L['施法条'],
		Type = "Switch",
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_CastBar_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].Enable = true
				self.Text:SetText(L["ON"])
				MEKA_CastBar_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['PLAYER'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].PlayerCastBar then
						Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].PlayerCastBar = false
						self.Text:SetText(L["OFF"])
						MEKA_CastBar_Toggle("OFF", "Player")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].PlayerCastBar = true
						self.Text:SetText(L["ON"])
						MEKA_CastBar_Toggle("ON", "Player")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["MEKA_CastBar"].PlayerCastBar then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}

MEKA_CastBar.Load = MEKA_CastBar_Load
MEKA_CastBar.Config = MEKA_CastBar_Config
F.MEKA_CastBar_Toggle = MEKA_CastBar_Toggle
tinsert(E.Module, MEKA_CastBar)