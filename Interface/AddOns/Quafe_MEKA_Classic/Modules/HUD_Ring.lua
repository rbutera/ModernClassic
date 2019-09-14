local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale
--if F.IsClassic then return end

----------------------------------------------------------------
--> API Localization
----------------------------------------------------------------

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

local LibThreatClassic = LibStub:GetLibrary("ThreatClassic-1.0")
local function UnitDetailedThreatSituation(unit, target)
	return LibThreatClassic:UnitDetailedThreatSituation(unit, target)
	--isTanking, threatStatus, threatPercent, rawThreatPercent, threatValue
end

----------------------------------------------------------------
--> API and Variable
----------------------------------------------------------------

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

local RADIUS = {
	Ring1 = 324,
	Ring2 = 370, --364
	Ring3 = 300,
}

----------------------------------------------------------------
--> Frame
----------------------------------------------------------------

local function RingBar1_Template(frame)
	frame.Bar1 = CreateFrame("Frame", nil, frame)
	local bar = {}
	for i = 1, 10 do
		bar[i] = frame.Bar1:CreateTexture(nil, "OVERLAY")
		bar[i]: SetVertexColor(F.Color(C.Color.Main2))
		bar[i]: SetAlpha(0.9)
		bar[i]: SetSize(64,64)
		if frame.Direction == "Right" then
			bar[i]: SetTexture(MEKA.Path("RingBar\\Bar1Right_11"))
			bar[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(-38+3*i)), RADIUS.Ring1*sin(rad(-38+3*i)))
			F.RotateTexture(bar[i], -38+3*i)
		elseif frame.Direction == "Left" then
			bar[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_11"))
			bar[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(-142-3*i)), RADIUS.Ring1*sin(rad(-142-3*i)))
			F.RotateTexture(bar[i], 38-3*i)
		end

		local Backdrop = frame.Bar1:CreateTexture(nil, "BACKGROUND")
		Backdrop: SetTexture(MEKA.Path("RingBar\\Bar1Right_11"))
		Backdrop: SetVertexColor(F.Color(C.Color.W1))
		Backdrop: SetAlpha(0.25)
		Backdrop: SetSize(64,64)
		Backdrop: SetPoint("CENTER", bar[i], "CENTER", 0,0)

		local Border = frame.Bar1:CreateTexture(nil, "BORDER")
		Border: SetTexture(MEKA.Path("RingBar\\Bar1_Border"))
		Border: SetVertexColor(F.Color(C.Color.W1))
		Border: SetAlpha(0.5)
		Border: SetSize(64,64)
		Border: SetPoint("CENTER", bar[i], "CENTER", 0,0)

		local BorderGlow = frame.Bar1:CreateTexture(nil, "ARTWORK")
		BorderGlow: SetTexture(MEKA.Path("RingBar\\Bar1_Border"))
		BorderGlow: SetVertexColor(F.Color(C.Color.Main2))
		BorderGlow: SetAlpha(0.5)
		BorderGlow: SetSize(64,64)
		BorderGlow: SetPoint("CENTER", bar[i], "CENTER", 0,0)

		bar[i].BdG = BorderGlow

		if frame.Direction == "Right" then
			F.RotateTexture(Backdrop, -38+3*i)
			F.RotateTexture(Border, -38+3*i)
			F.RotateTexture(BorderGlow, -38+3*i)
		elseif frame.Direction == "Left" then
			F.RotateTexture(Backdrop, -142-3*i)
			F.RotateTexture(Border, -142-3*i)
			F.RotateTexture(BorderGlow, -142-3*i)
		end
	end
	
	frame.Bar1.Bar = bar
end

local function RingBar2_Template(frame)
	frame.Bar2 = CreateFrame("Frame", nil, frame)

	local Bar = frame.Bar2:CreateTexture(nil, "BACKGROUND")
	Bar: SetTexture(MEKA.Path("RingBar2_Fill_1"))
	Bar: SetVertexColor(F.Color(C.Color.Main0))
	Bar: SetAlpha(0.75)
	Bar: SetSize(64,64)
	if frame.Direction == "Right" then
		Bar: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring2*cos(rad(-34.2)), RADIUS.Ring2*sin(rad(-34.2)))
		F.RotateTexture(Bar, -34.2)
	elseif frame.Direction == "Left" then
		Bar: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring2*cos(rad(-145.8)), RADIUS.Ring2*sin(rad(-145.8)))
		F.RotateTexture(Bar, -145.8)
	end

	local Glow = frame.Bar2:CreateTexture(nil, "BORDER")
	Glow: SetTexture(MEKA.Path("RingBar2_Fill_1"))
	Glow: SetVertexColor(F.Color(C.Color.Main1))
	Glow: SetAlpha(0.15)
	Glow: SetSize(64,64)
	Glow: SetPoint("CENTER", Bar, "CENTER", 0,0)
	if frame.Direction == "Right" then
		F.RotateTexture(Glow, -34.2)
	elseif frame.Direction == "Left" then
		F.RotateTexture(Glow, -145.8)
	end

	local Border = frame.Bar2:CreateTexture(nil, "ARTWORK")
	Border: SetTexture(MEKA.Path("RingBar2_Border1_1"))
	Border: SetVertexColor(F.Color(C.Color.Main1))
	Border: SetAlpha(0.95)
	Border: SetSize(64,64)
	Border: SetPoint("CENTER", Bar, "CENTER", 0,0)
	if frame.Direction == "Right" then
		F.RotateTexture(Border, -34.2)
	elseif frame.Direction == "Left" then
		F.RotateTexture(Border, -145.8)
	end

	local Num = {}
	for i = 1,3 do
		Num[i] = frame.Bar2: CreateTexture(nil, "OVERLAY")
		if i == 1 then
			Num[i]: SetTexture(MEKA.Path("N12\\N".."1"))
		else
			Num[i]: SetTexture(MEKA.Path("N12\\N".."0"))
		end
		Num[i]: SetVertexColor(F.Color(C.Color.Main1))
		Num[i]: SetAlpha(0.9)
		Num[i]: SetSize(32,32)

		local Bg = frame.Bar2: CreateTexture(nil, "BORDER")
		Bg: SetTexture(MEKA.Path("N12\\N".."0"))
		Bg: SetVertexColor(F.Color(C.Color.Main1))
		Bg: SetAlpha(0.3)
		Bg: SetSize(32,32)
		Bg: SetPoint("CENTER", Num[i], "CENTER", 0,0)
		Num[i].Bg = Bg
		
		if frame.Direction == "Right" then
			Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.Ring2-18+8*i)*cos(rad(-34.2)), (RADIUS.Ring2-18+8*i)*sin(rad(-34.2)))
			F.RotateTexture(Num[i], -34.2)
			F.RotateTexture(Num[i].Bg, -34.2)
		elseif frame.Direction == "Left" then
			Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.Ring2-20+8*(4-i))*cos(rad(-145.8)), (RADIUS.Ring2-20+8*(4-i))*sin(rad(-145.8)))
			F.RotateTexture(Num[i], 34.2)
			F.RotateTexture(Num[i].Bg, 34.2)
		end
	end

	frame.Bar2.Bar = Bar
	frame.Bar2.Glow = Glow
	frame.Bar2.Border = Border
	frame.Bar2.Num = Num
end

local function RingBar3_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame)
	
	local Bars = {}
	for i = 1, 10 do
		Bars[i] = Bar:CreateTexture(nil, "OVERLAY")
		
		Bars[i]: SetVertexColor(F.Color(C.Color.Main1))
		Bars[i]: SetAlpha(0.75)
		Bars[i]: SetSize(32,32)
		if frame.Direction == "Right" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_0"))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring3*cos(rad(-38+3*i)), RADIUS.Ring3*sin(rad(-38+3*i)))
			F.RotateTexture(Bars[i], -38+3*i)
		elseif frame.Direction == "Left" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_0"))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring3*cos(rad(-142-3*i)), RADIUS.Ring3*sin(rad(-142-3*i)))
			F.RotateTexture(Bars[i], 38-3*i)
		end

		local Backdrop = Bar:CreateTexture(nil, "BACKGROUND")
		Backdrop: SetTexture(MEKA.Path("RingBar\\Bar3_6"))
		Backdrop: SetVertexColor(F.Color(C.Color.W1))
		Backdrop: SetAlpha(0.9)
		Backdrop: SetSize(32,32)
		Backdrop: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		local Glow = Bar:CreateTexture(nil, "BORDER")
		Glow: SetTexture(MEKA.Path("RingBar\\Bar3_6"))
		Glow: SetVertexColor(F.Color(C.Color.Main1))
		Glow: SetAlpha(0.5)
		Glow: SetSize(32,32)
		Glow: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		if frame.Direction == "Right" then
			F.RotateTexture(Backdrop, -38+3*i)
			F.RotateTexture(Glow, -38+3*i)
		elseif frame.Direction == "Left" then
			F.RotateTexture(Backdrop, -142-3*i)
			F.RotateTexture(Glow, -142-3*i)
		end
	end
	
	frame.Bar3 = Bar
	frame.Bar3.Bars = Bars
end

local function RingBar4_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame)

	local Bars = {}
	for i = 1, 5 do
		Bars[i] = Bar:CreateTexture(nil, "OVERLAY")
		Bars[i]: SetVertexColor(F.Color(C.Color.Main2))
		Bars[i]: SetAlpha(0.9)
		Bars[i]: SetSize(64,64)
		if frame.Direction == "Right" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_11"))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(23-3*i)), RADIUS.Ring1*sin(rad(23-3*i)))
			F.RotateTexture(Bars[i], -157-3*i)
		elseif frame.Direction == "Left" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Right_11"))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(157+3*i)), RADIUS.Ring1*sin(rad(157+3*i)))
			F.RotateTexture(Bars[i], 157+3*i)
		end

		local Backdrop = Bar:CreateTexture(nil, "BACKGROUND")
		Backdrop: SetTexture(MEKA.Path("RingBar\\Bar1Right_11"))
		Backdrop: SetVertexColor(F.Color(C.Color.W1))
		Backdrop: SetAlpha(0.25)
		Backdrop: SetSize(64,64)
		Backdrop: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		local Border = Bar:CreateTexture(nil, "BORDER")
		Border: SetTexture(MEKA.Path("RingBar\\Bar1_Border"))
		Border: SetVertexColor(F.Color(C.Color.W1))
		Border: SetAlpha(0.5)
		Border: SetSize(64,64)
		Border: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		local BorderGlow = Bar:CreateTexture(nil, "ARTWORK")
		BorderGlow: SetTexture(MEKA.Path("RingBar\\Bar1_Border"))
		BorderGlow: SetVertexColor(F.Color(C.Color.Main2))
		BorderGlow: SetAlpha(0.5)
		BorderGlow: SetSize(64,64)
		BorderGlow: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		if frame.Direction == "Right" then
			F.RotateTexture(Backdrop, 23-3*i)
			F.RotateTexture(Border, 23-3*i)
			F.RotateTexture(BorderGlow, 23-3*i)
		elseif frame.Direction == "Left" then
			F.RotateTexture(Backdrop, 157+3*i)
			F.RotateTexture(Border, 157+3*i)
			F.RotateTexture(BorderGlow, 157+3*i)
		end
	end
	
	frame.Bar4 = Bar
	frame.Bar4.Bars = Bars
	frame.Bar4: Hide()
end

local function RingBar5_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame)
	
	local Bars = {}
	for i = 1, 6 do
		Bars[i] = Bar:CreateTexture(nil, "OVERLAY")
		Bars[i]: SetVertexColor(F.Color(C.Color.Main1))
		Bars[i]: SetAlpha(0.75)
		Bars[i]: SetSize(32,32)
		if frame.Direction == "Right" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_0"))
			--Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring3*cos(rad(23-3*i)), RADIUS.Ring3*sin(rad(23-3*i)))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring3*cos(rad(5+3*i)), RADIUS.Ring3*sin(rad(5+3*i)))
			F.RotateTexture(Bars[i], 5+3*i)
		elseif frame.Direction == "Left" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_0"))
			--Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring3*cos(rad(157+3*i)), RADIUS.Ring3*sin(rad(157+3*i)))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring3*cos(rad(175-3*i)), RADIUS.Ring3*sin(rad(175-3*i)))
			F.RotateTexture(Bars[i], -5-3*i)
		end

		local Backdrop = Bar:CreateTexture(nil, "BACKGROUND")
		Backdrop: SetTexture(MEKA.Path("RingBar\\Bar3_6"))
		Backdrop: SetVertexColor(F.Color(C.Color.W1))
		Backdrop: SetAlpha(0.9)
		Backdrop: SetSize(32,32)
		Backdrop: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		local Glow = Bar:CreateTexture(nil, "BORDER")
		Glow: SetTexture(MEKA.Path("RingBar\\Bar3_6"))
		Glow: SetVertexColor(F.Color(C.Color.Main1))
		Glow: SetAlpha(0.5)
		Glow: SetSize(32,32)
		Glow: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		if frame.Direction == "Right" then
			F.RotateTexture(Backdrop, 5+3*i)
			F.RotateTexture(Glow, 5+3*i)
		elseif frame.Direction == "Left" then
			F.RotateTexture(Backdrop, -5-3*i)
			F.RotateTexture(Glow, -5-3*i)
		end

		Bars[i].B = Backdrop
		Bars[i].G = Glow
	end
	
	frame.Bar5 = Bar
	frame.Bar5.Bars = Bars
end

local function RingBar7_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame)

	local Bars = {}
	for i = 1, 6 do
		Bars[i] = Bar:CreateTexture(nil, "OVERLAY")
		Bars[i]: SetVertexColor(F.Color(C.Color.Main2))
		Bars[i]: SetAlpha(0.9)
		Bars[i]: SetSize(64,64)
		if frame.Direction == "Right" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Right_0"))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(5+3*i)), RADIUS.Ring1*sin(rad(5+3*i)))
			F.RotateTexture(Bars[i], 8+3*i)
		elseif frame.Direction == "Left" then
			Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_0"))
			Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(175-3*i)), RADIUS.Ring1*sin(rad(175-3*i)))
			F.RotateTexture(Bars[i], -8-3*i)
		end

		local Backdrop = Bar:CreateTexture(nil, "BACKGROUND")
		Backdrop: SetTexture(MEKA.Path("RingBar\\Bar1Right_11"))
		Backdrop: SetVertexColor(F.Color(C.Color.W1))
		Backdrop: SetAlpha(0.25)
		Backdrop: SetSize(64,64)
		Backdrop: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		local Border = Bar:CreateTexture(nil, "BORDER")
		Border: SetTexture(MEKA.Path("RingBar\\Bar1_Border"))
		Border: SetVertexColor(F.Color(C.Color.W1))
		Border: SetAlpha(0.5)
		Border: SetSize(64,64)
		Border: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		local BorderGlow = Bar:CreateTexture(nil, "ARTWORK")
		BorderGlow: SetTexture(MEKA.Path("RingBar\\Bar1_Border"))
		BorderGlow: SetVertexColor(F.Color(C.Color.Main2))
		BorderGlow: SetAlpha(0.5)
		BorderGlow: SetSize(64,64)
		BorderGlow: SetPoint("CENTER", Bars[i], "CENTER", 0,0)

		if frame.Direction == "Right" then
			F.RotateTexture(Backdrop, 5+3*i)
			F.RotateTexture(Border, 5+3*i)
			F.RotateTexture(BorderGlow, 5+3*i)
		elseif frame.Direction == "Left" then
			F.RotateTexture(Backdrop, 175-3*i)
			F.RotateTexture(Border, 175-3*i)
			F.RotateTexture(BorderGlow, 175-3*i)
		end

		Bars[i].B = Backdrop
		Bars[i].Bd = Border
		Bars[i].G = BorderGlow
	end
	
	frame.Bar7 = Bar
	frame.Bar7.Info = {}
	frame.Bar7.Bars = Bars
	frame.Bar7: Hide()
end

local function RingBar5_Update(frame, value, max)
	if not value then value = 0 end
	if value > 1 then value = 1 end
	if value < 0 then value = 0 end
	local v1 = value*max
	local v2 = floor((v1 - floor(v1))*6 + 0.5)

	for i = 1,6 do
		if i <= v1 then
			frame.Bar5.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_6"))
		elseif (i > v1) and (i <= (v1+1)) then
			frame.Bar5.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_"..v2))
		else
			frame.Bar5.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_0"))
		end
	end
end

local function RingBar7_Update(frame, value, perc, combo)
	if not value then value = 0 end
	if combo then
		for i = 1,5 do
			if i <= value then
				frame.Bar7.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_11"))
				if i <= (value-5) then
					frame.Bar7.Bars[i]: SetVertexColor(F.Color(C.Color.Warn1))
					frame.Bar7.Bars[i]: SetAlpha(0.9)
				else
					frame.Bar7.Bars[i]: SetVertexColor(F.Color(C.Color.Main2))
					frame.Bar7.Bars[i]: SetAlpha(0.9)
				end
			else
				frame.Bar7.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_0"))
				frame.Bar7.Bars[i]: SetVertexColor(F.Color(C.Color.W3))
				frame.Bar7.Bars[i]: SetAlpha(0.6)
			end
		end
	else
		for i = 1,6 do
			if i <= value then
				frame.Bar7.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_11"))
				frame.Bar7.Bars[i]: SetVertexColor(F.Color(C.Color.Main2))
				frame.Bar7.Bars[i]: SetAlpha(0.9)
			else
				frame.Bar7.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_0"))
				frame.Bar7.Bars[i]: SetVertexColor(F.Color(C.Color.W3))
				frame.Bar7.Bars[i]: SetAlpha(0.6)
			end
		end
	end
	if perc then
		local v = floor((perc)*11 + 0.5)
		for i = 1,6 do
			if (i > value) and (i <= (value + 1)) then
				frame.Bar7.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1Left_"..v))
			end
		end
	end
end

local function RingBar7_RuneUpdate(frame, ready, index, value)
	if not value then value = 0 end
	if ready then
		frame.Bar7.Bars[index]: SetTexture(MEKA.Path("RingBar\\Bar1Left_11"))
		frame.Bar7.Bars[index]: SetVertexColor(F.Color(C.Color.Main2))
		frame.Bar7.Bars[index]: SetAlpha(0.9)
	else
		local v = floor((value)*11 + 0.5)
		v = min(11, max(0, v))
		frame.Bar7.Bars[index]: SetTexture(MEKA.Path("RingBar\\Bar1Left_"..v))
		frame.Bar7.Bars[index]: SetVertexColor(F.Color(C.Color.W3))
		frame.Bar7.Bars[index]: SetAlpha(0.6)
	end
end

local function RingBar7_UpdateMax(frame, value)
	if not value then value = 0 end
	for i = 1, 6 do
		if i <= value then
			frame.Bar7.Bars[i]: Show()
			frame.Bar7.Bars[i].B: Show()
			frame.Bar7.Bars[i].Bd: Show()
			frame.Bar7.Bars[i].G: Show()

			frame.Bar5.Bars[i]: Show()
			frame.Bar5.Bars[i].B: Show()
			frame.Bar5.Bars[i].G: Show()
		else
			frame.Bar7.Bars[i]: Hide()
			frame.Bar7.Bars[i].B: Hide()
			frame.Bar7.Bars[i].Bd: Hide()
			frame.Bar7.Bars[i].G: Hide()

			frame.Bar5.Bars[i]: Hide()
			frame.Bar5.Bars[i].B: Hide()
			frame.Bar5.Bars[i].G: Hide()
		end
	end
end

local function Border1_Create(frame)
	local Border = CreateFrame("Frame", nil, frame)
	Border: SetSize(34,34)

	local TopBorder = Border:CreateTexture(nil, "BACKGROUND")
	TopBorder: SetTexture(MEKA.Path("RingBar\\Border1"))
	TopBorder: SetVertexColor(F.Color(C.Color.W1))
	TopBorder: SetAlpha(0.9)
	TopBorder: SetSize(34,120)
	TopBorder: SetPoint("BOTTOM", Border, "CENTER", 0,0)

	local TopGlow = Border:CreateTexture(nil, "BORDER")
	TopGlow: SetTexture(MEKA.Path("RingBar\\Border1"))
	TopGlow: SetVertexColor(F.Color(C.Color.Main1))
	TopGlow: SetAlpha(0.5)
	TopGlow: SetSize(34,120)
	TopGlow: SetPoint("BOTTOM", Border, "CENTER", 0,0)

	local BottomBorder = Border:CreateTexture(nil, "BACKGROUND")
	BottomBorder: SetTexture(MEKA.Path("RingBar\\Border1"))
	BottomBorder: SetVertexColor(F.Color(C.Color.W1))
	BottomBorder: SetAlpha(0.9)
	BottomBorder: SetSize(34,120)
	BottomBorder: SetPoint("TOP", Border, "CENTER", 0,0)

	local BottomGlow = Border:CreateTexture(nil, "BORDER")
	BottomGlow: SetTexture(MEKA.Path("RingBar\\Border1"))
	BottomGlow: SetVertexColor(F.Color(C.Color.Main1))
	BottomGlow: SetAlpha(0.5)
	BottomGlow: SetSize(34,120)
	BottomGlow: SetPoint("TOP", Border, "CENTER", 0,0)

	if frame.Direction == "Right" then
		Border: SetPoint("CENTER", frame, "CENTER", 264,0)

		TopBorder: SetTexCoord(15/64,49/64, 124/128,4/128)
		TopGlow: SetTexCoord(15/64,49/64, 124/128,4/128)

		BottomBorder: SetTexCoord(15/64,49/64, 4/128,124/128)
		BottomGlow: SetTexCoord(15/64,49/64, 4/128,124/128)
	elseif frame.Direction == "Left" then
		Border: SetPoint("CENTER", frame, "CENTER", -264,0)

		TopBorder: SetTexCoord(49/64,15/64, 124/128,4/128)
		TopGlow: SetTexCoord(49/64,15/64, 124/128,4/128)

		BottomBorder: SetTexCoord(49/64,15/64, 4/128,124/128)
		BottomGlow: SetTexCoord(49/64,15/64, 4/128,124/128)
	end

	frame.Border1 = Border
end

local function Border2_Create(frame)
	local Border = CreateFrame("Frame", nil, frame)
	Border: SetSize(56,56)

	local TopBorder = Border:CreateTexture(nil, "BACKGROUND")
	TopBorder: SetTexture(MEKA.Path("HUD_Border3"))
	TopBorder: SetVertexColor(F.Color(C.Color.W1))
	TopBorder: SetAlpha(0.9)
	TopBorder: SetSize(56,158)
	TopBorder: SetPoint("BOTTOM", Border, "CENTER", 0,53)

	local TopGlow = Border:CreateTexture(nil, "BORDER")
	TopGlow: SetTexture(MEKA.Path("HUD_Border3"))
	TopGlow: SetVertexColor(F.Color(C.Color.Main1))
	TopGlow: SetAlpha(0.5)
	TopGlow: SetSize(56,158)
	TopGlow: SetPoint("BOTTOM", Border, "CENTER", 0,53)

	local BottomBorder = Border:CreateTexture(nil, "BACKGROUND")
	BottomBorder: SetTexture(MEKA.Path("HUD_Border3"))
	BottomBorder: SetVertexColor(F.Color(C.Color.W1))
	BottomBorder: SetAlpha(0.9)
	BottomBorder: SetSize(56,158)
	BottomBorder: SetPoint("TOP", Border, "CENTER", 0,-53)

	local BottomGlow = Border:CreateTexture(nil, "BORDER")
	BottomGlow: SetTexture(MEKA.Path("HUD_Border3"))
	BottomGlow: SetVertexColor(F.Color(C.Color.Main1))
	BottomGlow: SetAlpha(0.5)
	BottomGlow: SetSize(56,158)
	BottomGlow: SetPoint("TOP", Border, "CENTER", 0,-53)

	if frame.Direction == "Right" then
		Border: SetPoint("CENTER", frame, "CENTER", 402,0)

		TopBorder: SetTexCoord(4/64,60/64, 207/256,49/256)
		TopGlow: SetTexCoord(4/64,60/64, 207/256,49/256)

		BottomBorder: SetTexCoord(4/64,60/64, 49/256,207/256)
		BottomGlow: SetTexCoord(4/64,60/64, 49/256,207/256)
	elseif frame.Direction == "Left" then
		Border: SetPoint("CENTER", frame, "CENTER", -402,0)

		TopBorder: SetTexCoord(60/64,4/64, 207/256,49/256)
		TopGlow: SetTexCoord(60/64,4/64, 207/256,49/256)

		BottomBorder: SetTexCoord(60/64,4/64, 49/256,207/256)
		BottomGlow: SetTexCoord(60/64,4/64, 49/256,207/256)
	end

	frame.Border2 = Border
end

local function Border3_Create(frame)
	local Border = CreateFrame("Frame", nil, frame)
	Border: SetSize(120,140) --240,280
	Border: SetPoint("CENTER", frame, "CENTER", 330,104)

	local FCS_Bd1 = Border:CreateTexture(nil, "ARTWORK")
	FCS_Bd1: SetTexture(MEKA.Path("RingBar\\Border3_1"))
	FCS_Bd1: SetVertexColor(F.Color(C.Color.Main1))
	FCS_Bd1: SetAlpha(0.5)
	FCS_Bd1: SetSize(120,140)
	FCS_Bd1: SetTexCoord(8/256,248/256, 116/512,396/512)
	FCS_Bd1: SetPoint("CENTER", Border, "CENTER", 0,0)

	local FCS_Bd1Sd = frame.Border1:CreateTexture(nil, "BACKGROUND")
	FCS_Bd1Sd: SetTexture(MEKA.Path("RingBar\\Border3_1_Sd"))
	FCS_Bd1Sd: SetVertexColor(F.Color(C.Color.Main0))
	FCS_Bd1Sd: SetAlpha(0.25)
	FCS_Bd1Sd: SetSize(120,140) --82,144
	FCS_Bd1Sd: SetTexCoord(8/256,248/256, 116/512,396/512)
	FCS_Bd1Sd: SetPoint("CENTER", Border, "CENTER", 0,0)

	local FCS_Bd2 = frame.Border1:CreateTexture(nil, "ARTWORK")
	FCS_Bd2: SetTexture(MEKA.Path("RingBar\\Border3_2"))
	FCS_Bd2: SetVertexColor(F.Color(C.Color.Main1))
	FCS_Bd2: SetAlpha(0.9)
	FCS_Bd2: SetSize(120,140) --244，280
	FCS_Bd2: SetTexCoord(8/256,248/256, 116/512,396/512)
	FCS_Bd2: SetPoint("CENTER", Border, "CENTER", 0,0)

	local FCS_Bd2Sd = frame.Border1:CreateTexture(nil, "BACKGROUND")
	FCS_Bd2Sd: SetTexture(MEKA.Path("RingBar\\Border3_2_Sd"))
	FCS_Bd2Sd: SetVertexColor(F.Color(C.Color.Main0))
	FCS_Bd2Sd: SetAlpha(0.25)
	FCS_Bd2Sd: SetSize(120,140)
	FCS_Bd2Sd: SetTexCoord(8/256,248/256, 116/512,396/512)
	FCS_Bd2Sd: SetPoint("CENTER", Border, "CENTER", 0,0)

	frame.Border3 = Border
end

local function Block_Create(frame)
	local Block = CreateFrame("Frame", nil, frame)
	Block: SetSize(106,58)

	local Border = Block:CreateTexture(nil, "BORDER")
	Border: SetTexture(MEKA.Path("RingBar\\Border2"))
	Border: SetVertexColor(F.Color(C.Color.W1))
	Border: SetAlpha(0)
	Border: SetSize(106,58)
	Border: SetPoint("CENTER")

	local Bd1 = Block:CreateTexture(nil, "ARTOWRK")
	Bd1: SetTexture(MEKA.Path("RingBar\\Border2"))
	Bd1: SetVertexColor(F.Color(C.Color.Main1))
	Bd1: SetAlpha(0.75)
	Bd1: SetSize(106,58)
	Bd1: SetPoint("CENTER")

	local BorderBg = Block:CreateTexture(nil, "BACKGROUND")
	BorderBg: SetTexture(MEKA.Path("RingBar\\Border2_Bg"))
	BorderBg: SetVertexColor(F.Color(C.Color.Main0))
	BorderBg: SetAlpha(0.75)
	BorderBg: SetSize(106,58)
	BorderBg: SetPoint("CENTER")

	local BgGlow = F.Create.Texture(Block, "BORDER", 1, MEKA.Path("RingBar\\Border2_Bg"), C.Color.Main1, 0.15, {106,58})
	BgGlow: SetPoint("CENTER", Block, "CENTER", 0, 0)

	if frame.Direction == "Right" then
		Block: SetPoint("LEFT", frame, "CENTER", 307,0)
		Border: SetTexCoord(11/128,117/128, 3/64,61/64)
		Bd1: SetTexCoord(11/128,117/128, 3/64,61/64)
		BorderBg: SetTexCoord(11/128,117/128, 3/64,61/64)
		BgGlow: SetTexCoord(11/128,117/128, 3/64,61/64)
	elseif frame.Direction == "Left" then
		Block: SetPoint("RIGHT", frame, "CENTER", -307,0)
		Border: SetTexCoord(117/128,11/128, 3/64,61/64)
		Bd1: SetTexCoord(117/128,11/128, 3/64,61/64)
		BorderBg: SetTexCoord(117/128,11/128, 3/64,61/64)
		BgGlow: SetTexCoord(117/128,11/128, 3/64,61/64)
	end

	frame.Block = Block
end

local function ClassIcon_Create(frame)
	local Info = CreateFrame("Frame", nil, frame.Block)
	Info: SetSize(32,32)

	local ClassIcon = Info: CreateTexture(nil, "ARTWORK")
	ClassIcon: SetTexture(F.Path("Icon_Class"))
	ClassIcon: SetSize(32,32)
	ClassIcon: SetPoint("CENTER", Info, "CENTER", 0,0)

	local Indicator = Info: CreateTexture(nil, "ARTWORK")
	Indicator: SetSize(32,32)
	Indicator: SetPoint("CENTER", Info, "CENTER", 0,0)

	if frame.Direction == "Right" then
		Info: SetPoint("CENTER", frame.Block, "LEFT", 28,0)
	elseif frame.Direction == "Left" then
		Info: SetPoint("CENTER", frame.Block, "RIGHT", -28,0)
	end

	frame.Info = Info
	frame.Info.ClassIcon = ClassIcon
	frame.Info.Indicator = Indicator
end

local function HealthPercent_Create(frame)
	local HealthPercent = CreateFrame("Frame", nil, frame.Block)
	HealthPercent: SetSize(32,32)

	local Text = F.create_Font(HealthPercent, C.Font["NumOW"], 24, nil, 0.9, "CENTER", "CENTER")
	Text: SetTextColor(F.Color(C.Color.Main1))
	Text: SetPoint("CENTER", HealthPercent, "CENTER", 0, 0)

	if frame.Direction == "Right" then
		HealthPercent: SetPoint("CENTER", frame.Block, "LEFT", 30,0)
	elseif frame.Direction == "Left" then
		HealthPercent: SetPoint("CENTER", frame.Block, "RIGHT", -30,0)
	end

	frame.HealthPercent = HealthPercent
	frame.HealthPercent.Text = Text
end

local function LeftFrame(frame)
	local Left = CreateFrame("Frame", nil, frame)
	Left: SetSize(4,4)
	Left: SetPoint("CENTER", frame, "CENTER", 0,0)
	Left.Direction = "Left"
	Left.Unit = "player"

	RingBar1_Template(Left)
	RingBar2_Template(Left)
	RingBar3_Template(Left)
	RingBar4_Template(Left)
	RingBar5_Template(Left)
	RingBar7_Template(Left)
	F.LoopBar6_Template(Left)
	Border1_Create(Left)
	--Border2_Create(Left)
	Block_Create(Left)
	HealthPercent_Create(Left)

	Left.HealthValue = F.create_Font(Left.Block, C.Font["NumSmall"], 12, nil, 0.9, "RIGHT", "CENTER")
	Left.HealthValue: SetTextColor(F.Color(C.Color.Main1))
	Left.HealthValue: SetPoint("BOTTOMRIGHT", Left.Block, "RIGHT", -53, 0.5)
	Left.PowerValue = F.create_Font(Left.Block, C.Font["NumSmall"], 12, nil, 0.9, "RIGHT", "CENTER")
	Left.PowerValue: SetTextColor(F.Color(C.Color.Main1))
	Left.PowerValue: SetPoint("TOPRIGHT", Left.Block, "RIGHT", -53, -0.5)

	frame.Left = Left
end

local function RightFrame(frame)
	local Right = CreateFrame("Frame", nil, frame)
	Right: SetSize(4,4)
	Right: SetPoint("CENTER", frame, "CENTER", 0,0)
	Right.Direction = "Right"
	Right.Unit = "target"

	RingBar1_Template(Right)
	RingBar2_Template(Right)
	RingBar3_Template(Right)
	Border1_Create(Right)
	--Border2_Create(Right)
	Border3_Create(Right)
	Block_Create(Right)
	ClassIcon_Create(Right)
	HealthPercent_Create(Right)

	Right.HealthValue = F.create_Font(Right.Block, C.Font["NumSmall"], 12, nil, 0.9, "LEFT", "CENTER")
	Right.HealthValue: SetTextColor(F.Color(C.Color.Main1))
	Right.HealthValue: SetPoint("BOTTOMLEFT", Right.Block, "LEFT", 53, 0.5)
	Right.PowerValue = F.create_Font(Right.Block, C.Font["NumSmall"], 12, nil, 0.9, "LEFT", "CENTER")
	Right.PowerValue: SetTextColor(F.Color(C.Color.Main1))
	Right.PowerValue: SetPoint("TOPLEFT", Right.Block, "LEFT", 53, 0.5)

	frame.Right = Right
end

----------------------------------------------------------------
--> Update
----------------------------------------------------------------

local function RingBar1_Update(frame, value)
	if not value then value = 0 end
	if value > 1 then value = 1 end
	if value < 0 then value = 0 end
	local v1 = value*10
	local v2 = floor((v1 - floor(v1))*11 + 0.5)
	local d = frame.Direction

	for i = 1,10 do
		if i <= v1 then
			frame.Bar1.Bar[i]: SetTexture(MEKA.Path("RingBar\\Bar1"..d.."_11"))
		elseif (i > v1) and (i <= (v1+1)) then
			frame.Bar1.Bar[i]: SetTexture(MEKA.Path("RingBar\\Bar1"..d.."_"..v2))
		else
			frame.Bar1.Bar[i]: SetTexture(MEKA.Path("RingBar\\Bar1"..d.."_0"))
		end
	end
	if value <= 0.2 then
		for i = 1,10 do
			frame.Bar1.Bar[i]: SetVertexColor(F.Color(C.Color.Warn1))
			frame.Bar1.Bar[i].BdG: SetVertexColor(F.Color(C.Color.Warn1))
		end
	else
		for i = 1,10 do
			frame.Bar1.Bar[i]: SetVertexColor(F.Color(C.Color.Main2))
			frame.Bar1.Bar[i].BdG: SetVertexColor(F.Color(C.Color.Main2))
		end
	end
end

local function RingBar2_Update(frame, value)
	if not value then value = 0 end
	if value > 1 then value = 1 end
	if value < 0 then value = 0 end
	local r = value*25.4

	if frame.Direction == "Right" then
		frame.Bar2.Bar: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring2*cos(rad(-34.2+r)), RADIUS.Ring2*sin(rad(-34.2+r)))
		F.RotateTexture(frame.Bar2.Bar, -34.2+r)
		F.RotateTexture(frame.Bar2.Glow, -34.2+r)
		F.RotateTexture(frame.Bar2.Border, -34.2+r)
	elseif frame.Direction == "Left" then
		frame.Bar2.Bar: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring2*cos(rad(-145.8-r)), RADIUS.Ring2*sin(rad(-145.8-r)))
		F.RotateTexture(frame.Bar2.Bar, -145.8-r)
		F.RotateTexture(frame.Bar2.Glow, -145.8-r)
		F.RotateTexture(frame.Bar2.Border, -145.8-r)
	end

	for i = 1,3 do
		if frame.Direction == "Right" then
			frame.Bar2.Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.Ring2-18+8*i)*cos(rad(-34.2+r)), (RADIUS.Ring2-18+8*i)*sin(rad(-34.2+r)))
			F.RotateTexture(frame.Bar2.Num[i], -34.2+r)
			F.RotateTexture(frame.Bar2.Num[i].Bg, -34.2+r)
		elseif frame.Direction == "Left" then
			frame.Bar2.Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.Ring2-20+8*(4-i))*cos(rad(-145.8-r)), (RADIUS.Ring2-20+8*(4-i))*sin(rad(-145.8-r)))
			F.RotateTexture(frame.Bar2.Num[i], 34.2-r)
			F.RotateTexture(frame.Bar2.Num[i].Bg, 34.2-r)
		end
	end
end

local function RingBar2Num_Update(frame, value)
	if not value then value = 0 end
	if value > 1 then value = 1 end
	if value < 0 then value = 0 end

	local d,d1,d2,d3 = 0,0,0,0,0
	d = floor(value*100 + 0.5)
	
	d1 = floor(d/100 - floor(d/1e3)*10) or 0
	d2 = floor(d/10 - floor(d/100)*10) or 0
	d3 = floor(d - floor(d/10)*10) or 0

	if d1 == 0 then
		d1 = "b"
		if d2 == 0 then
			d2 = "b"
		end
	end

	frame.Bar2.Num[1]:SetTexture(MEKA.Path("N12\\N"..d1))
	frame.Bar2.Num[2]:SetTexture(MEKA.Path("N12\\N"..d2))
	frame.Bar2.Num[3]:SetTexture(MEKA.Path("N12\\N"..d3))
end

local function RingBar3_Update(frame, value)
	if not value then value = 0 end
	if value > 1 then value = 1 end
	if value < 0 then value = 0 end
	local v1 = value*10
	local v2 = floor((v1 - floor(v1))*6 + 0.5)

	for i = 1,10 do
		if i <= v1 then
			frame.Bar3.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_6"))
		elseif (i > v1) and (i <= (v1+1)) then
			frame.Bar3.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_"..v2))
		else
			frame.Bar3.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_0"))
		end
	end
end

local REVERSE_DIRECTION = {
	["Left"] = "Right",
	["Right"] = "Left",
}

local function RingBar4_Update(frame, value)
	if not value then value = 0 end
	if value > 1 then value = 1 end
	if value < 0 then value = 0 end
	local v1 = value*10
	local v2 = floor((v1 - floor(v1))*11 + 0.5)
	local d = REVERSE_DIRECTION[frame.Direction]

	for i = 1,5 do
		if i <= v1 then
			frame.Bar4.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1"..d.."_11"))
		elseif (i > v1) and (i <= (v1+1)) then
			frame.Bar4.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1"..d.."_"..v2))
		else
			frame.Bar4.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar1"..d.."_0"))
		end
	end
end

local function RingBar5_Update(frame, value)
	if not value then value = 0 end
	if value > 1 then value = 1 end
	if value < 0 then value = 0 end
	local v1 = value*5
	local v2 = floor((v1 - floor(v1))*6 + 0.5)

	for i = 1,5 do
		if i <= v1 then
			frame.Bar3.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_6"))
		elseif (i > v1) and (i <= (v1+1)) then
			frame.Bar3.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_"..v2))
		else
			frame.Bar3.Bars[i]: SetTexture(MEKA.Path("RingBar\\Bar3_0"))
		end
	end
end

local function HUD_Player_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_DISPLAYPOWER" or event == "UNIT_MAXPOWER" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" then
		frame.ShowMana = false
		local powerType = UnitPowerType("player")
		if powerType ~= 0 then
			local maxmana = UnitPowerMax("player", 0)
			if maxmana ~= 0 then
				frame.ShowMana = true
			end
		end
	end
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_PET" or event == "PET_UI_UPDATE" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" then
		if UnitExists("pet") then
			frame.ShowPet = true
		else
			frame.ShowPet = false
		end
		frame.Bar6: SetShown(frame.ShowPet)
	end
end

local function HUD_Player_Update(frame, elapsed)
	if F.Last25 == 0 then
		RingBar1_Update(frame, E.Value[frame.Unit].Health.Cur)
		RingBar2_Update(frame, E.Value[frame.Unit].Power.Cur)
		RingBar4_Update(frame, E.Value[frame.Unit].Absorb.Cur)
		if frame.ShowMana then
			RingBar3_Update(frame, E.Value[frame.Unit].Mana.Cur)
		else
			RingBar3_Update(frame, 0)
		end
	end

	if F.Last10 == 0 then
		RingBar2Num_Update(frame, E.Value[frame.Unit].Power.Cur)
		frame.HealthValue: SetText(F.FormatNum(E.Value[frame.Unit].Health.Cur*E.Value[frame.Unit].Health.Max, 1))
		frame.PowerValue: SetText(F.FormatNum(E.Value[frame.Unit].Power.Cur*E.Value[frame.Unit].Power.Max, 1))
		frame.HealthPercent.Text: SetText(F.FormatPercent(E.Value[frame.Unit].Health.Cur))
	end
	
	if frame.ShowPet then
		F.LoopBar6_Update(frame, E.Value["pet"].Health.Cur)
		F.LoopBar6_Update(frame, nil, E.Value["pet"].Power.Cur)
	end
end

local function HUD_Left_Update(frame)
	frame.Left: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame.Left: RegisterEvent("UNIT_PET")
	frame.Left: RegisterEvent("PET_UI_UPDATE")
	--frame.Left: RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
	--frame.Left: RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	frame.Left: RegisterUnitEvent("UNIT_DISPLAYPOWER")
	--frame.Left: RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
	--frame.Left: RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
	frame.Left: RegisterUnitEvent("UNIT_MAXPOWER", "player")
	frame.Left: SetScript("OnEvent", function(self, event, ...)
		HUD_Player_Event(self, event, ...)
	end)
	frame.Left: SetScript("OnUpdate", function(self,  elapsed)
		HUD_Player_Update(self, self.Direction, elapsed)
	end)
end

local function Threat_Update(frame)
	if UnitAffectingCombat("player") and UnitExists("target") and not UnitIsDeadOrGhost("target") then
		if UnitCanAttack("player", "target") and not (UnitIsDead("target") or UnitIsFriend("player", "target") or UnitPlayerControlled("target")) then
			--isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
			local status, threatpct = select(2, UnitDetailedThreatSituation("player", "target"))
			if status and threatpct then
				threatpct = threatpct/100
				RingBar3_Update(frame, threatpct)
			else
				RingBar3_Update(frame, 0)
			end
		else
			RingBar3_Update(frame, 0)
		end
	else
		RingBar3_Update(frame, 0)
	end
end

local function Threat_RegisterCallback(frame)
	LibThreatClassic.RegisterCallback(frame, "ThreatUpdated", function()
		Threat_Update(frame)
	end)
end

local function HUD_Target_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "UNIT_FACTION" then
		F.Smooth_Health(frame.Unit)
		F.Smooth_Power(frame.Unit)

		if UnitExists(frame.Unit) then
			frame.Block: Show()
			frame.Bar1: Show()
			frame.Bar2: Show()
			frame.Bar3: Show()
		else
			frame.Block: Hide()
			frame.Bar1: Hide()
			frame.Bar2: Hide()
			frame.Bar3: Hide()
		end
		
		if UnitExists(frame.Unit) then
			local eColor = {}
			local lColor = {}
			local isPlayer = UnitIsPlayer(frame.Unit) 
			local isDenied = false
			if isPlayer then
				local eClass = select(2, UnitClass(frame.Unit))
				eColor = C.Color.Class[eClass] or C.Color.White
				if Icon_Class[eClass] then
					frame.Info.ClassIcon: SetTexCoord(unpack(Icon_Class[eClass]))
				else
					frame.Info.ClassIcon: SetTexCoord(0,F.Debug, 0,F.Debug)
				end
			else
				if (not UnitPlayerControlled(frame.Unit) and UnitIsTapDenied(frame.Unit)) then
					isDenied = true
					eColor = C.Color.Denied
				else
					local red, green, blue, alpha = UnitSelectionColor(frame.Unit)
					eColor.r = red or 1
					eColor.g = green or 1
					eColor.b = blue or 1
				end
			end
			
			local isPVP = UnitIsPVP(frame.Unit)
			local factionGroup = UnitFactionGroup(frame.Unit)
			--local isQuest = UnitIsQuestBoss(frame.Unit)
			local isQuest = false
			if isQuest then
				frame.Info: SetAlpha(1)
				frame.HealthPercent: SetAlpha(0)
				frame.Info.Indicator: SetTexture(F.Path("Icon_Quest"))
				frame.Info.Indicator: SetAlpha(1)
				frame.Info.ClassIcon: SetAlpha(0)
				if isPVP and factionGroup == "Alliance" then
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.B1))
				elseif isPVP and factionGroup == "Horde" then
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.R1))
				elseif isDenied then
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.Denied))
				else
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.Y2))
				end
			elseif isPlayer then
				frame.Info: SetAlpha(1)
				frame.HealthPercent: SetAlpha(0)
				frame.Info.Indicator: SetAlpha(0)
				frame.Info.ClassIcon: SetAlpha(1)
			else
				frame.Info.ClassIcon: SetAlpha(0)
				if isPVP and factionGroup == "Alliance" then
					frame.Info: SetAlpha(1)
					frame.HealthPercent: SetAlpha(0)
					frame.HealthPercent: SetAlpha(0)
					frame.Info.Indicator: SetTexture(F.Path("Icon_PVP_Alliance"))
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.B1))
					frame.Info.Indicator: SetAlpha(1)
				elseif isPVP and factionGroup == "Horde" then
					frame.Info: SetAlpha(1)
					frame.HealthPercent: SetAlpha(0)
					frame.HealthPercent: SetAlpha(0)
					frame.Info.Indicator: SetTexture(F.Path("Icon_PVP_Horde"))
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.R1))
					frame.Info.Indicator: SetAlpha(1)
				elseif isDenied then
					frame.Info: SetAlpha(1)
					frame.HealthPercent: SetAlpha(0)
					frame.Info.Indicator: SetTexture(F.Path("Icon_TapDenied"))
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.Denied))
					frame.Info.Indicator: SetAlpha(1)
				else
					frame.Info: SetAlpha(0)
					frame.HealthPercent: SetAlpha(1)
					frame.Info.Indicator: SetAlpha(0)
					frame.Info.ClassIcon: SetAlpha(0)
				end
			end
		end
	end
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		F.Smooth_Health(frame.Unit)
	end
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		F.Smooth_Power(frame.Unit)
	end
	if event == "PLAYER_TARGET_CHANGED" then
		E.Value[frame.Unit].Health.Cur = 0
		E.Value[frame.Unit].Power.Cur = 0
	end
	if event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_TARGET_CHANGED" or event == "UNIT_THREAT_LIST_UPDATE" or event == "UNIT_THREAT_SITUATION_UPDATE" then
		Threat_Update(frame)
	end
end

local function HUD_Target_Update(frame, elapsed)
	if UnitExists(frame.Unit) then
		F.Smooth_Update(E.Value[frame.Unit].Health)
		F.Smooth_Update(E.Value[frame.Unit].Power)
		if F.Last25 == 0 then
			RingBar1_Update(frame, E.Value[frame.Unit].Health.Cur)
			RingBar2_Update(frame, E.Value[frame.Unit].Power.Cur)
		end
		if F.Last10 == 0 then
			RingBar2Num_Update(frame, E.Value[frame.Unit].Power.Cur)
			frame.HealthValue: SetText(F.FormatNum(E.Value[frame.Unit].Health.Cur*E.Value[frame.Unit].Health.Max, 1))
			frame.PowerValue: SetText(F.FormatNum(E.Value[frame.Unit].Power.Cur*E.Value[frame.Unit].Power.Max, 1))
			frame.HealthPercent.Text: SetText(F.FormatPercent(E.Value[frame.Unit].Health.Cur))
		end
	end
end

local function HUD_Right_Update(frame)
	frame.Right: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame.Right: RegisterEvent("PLAYER_TARGET_CHANGED")
	frame.Right: RegisterUnitEvent("UNIT_FACTION", "target")
	frame.Right: RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "target")
	frame.Right: RegisterUnitEvent("UNIT_MAXHEALTH", "target")
	frame.Right: RegisterUnitEvent("UNIT_POWER_FREQUENT", "target")
	frame.Right: RegisterUnitEvent("UNIT_MAXPOWER", "target")
	frame.Right: RegisterEvent("PLAYER_REGEN_DISABLED")
	frame.Right: RegisterEvent("PLAYER_REGEN_ENABLED")
	--frame.Right: RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE", "target")
	--frame.Right: RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", "target")
	frame.Right: SetScript("OnEvent", function(self, event, ...)
		HUD_Target_Event(self, event, ...)
	end)
	frame.Right: SetScript("OnUpdate", function(self,  elapsed)
		HUD_Target_Update(self, elapsed)
	end)
	Threat_RegisterCallback(frame.Right)
end

----------------------------------------------------------------
--> HUD
----------------------------------------------------------------

local HUD_EVENT = {
	"PLAYER_ENTERING_WORLD",
	"PLAYER_TARGET_CHANGED",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
}

local function HUD_SlideUpdate(self)
	if (Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.CombatShow and UnitAffectingCombat("player")) or UnitExists("target") then
		if self.State == "Hide" then
			self.State = "Show"
			self:SetAlpha(1)
		end
	else
		if self.State == "Show" then
			self.State = "Hide"
			self:SetAlpha(0)
		end
	end
end

local function HUD_OnEvent(frame)
	for k, event in ipairs(HUD_EVENT) do
		frame: RegisterEvent(event)
	end
	frame: SetScript("OnEvent", function(self, event, ...)
		HUD_SlideUpdate(self)
	end)
end

local function HUD_OnUpdate(frame)
	frame: SetScript("OnUpdate", function(self)
		if F.Last2 == 0 then
			HUD_SlideUpdate(self)
		end
	end)
end

local MEKA_RINGHUD = CreateFrame("Frame", nil, E, "MEKA_HUD_SlideTemplate")
MEKA_RINGHUD: SetSize(12,12)
MEKA_RINGHUD: SetPoint("CENTER", UIParent, "CENTER", 0,0)
MEKA_RINGHUD.Init = false
MEKA_RINGHUD.State = "Hide"
--MEKA_RINGHUD: Hide()
MEKA_RINGHUD: SetAlpha(0)

local function MEKA_RINGHUD_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State == "RING" then
		LeftFrame(MEKA_RINGHUD)
		RightFrame(MEKA_RINGHUD)
		F.TargetArrow_Create(MEKA_RINGHUD)

		HUD_Left_Update(MEKA_RINGHUD)
		HUD_Right_Update(MEKA_RINGHUD)

		HUD_OnEvent(MEKA_RINGHUD)
		HUD_OnUpdate(MEKA_RINGHUD)

		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale then
			MEKA_RINGHUD: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale)
		end

		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack then
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack == "COMBO" then
				--MEKA_RINGHUD.Left.Bar4: Hide()
				MEKA_RINGHUD.Left.Bar7: Show()
			elseif Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack == "ABSORB" then
				MEKA_RINGHUD.Left.Bar4: Show()
				MEKA_RINGHUD.Left.Bar7: Hide()
				RingBar7_UpdateMax(MEKA_RINGHUD.Left, 5)
			end
		end

		MEKA_RINGHUD.Init = true
	end
end

local function MEKA_RINGHUD_Toggle(arg)
	if arg == "ON" then
		if not MEKA_RINGHUD.Init then
			MEKA_RINGHUD_Load()
		end
		HUD_OnEvent(MEKA_RINGHUD)
		HUD_OnUpdate(MEKA_RINGHUD)
	elseif arg == "OFF" then
		MEKA_RINGHUD: UnregisterAllEvents()
		MEKA_RINGHUD: SetScript("OnUpdate", nil)
		MEKA_RINGHUD: Hide()
	elseif arg == "COMBO" then
		--MEKA_RINGHUD.Left.Bar4: Hide()
		--MEKA_RINGHUD.Left.Bar7: Show()
	elseif arg == "ABSORB" then
		MEKA_RINGHUD.Left.Bar4: Show()
		MEKA_RINGHUD.Left.Bar7: Hide()
		RingBar7_UpdateMax(MEKA_RINGHUD.Left, 5)
	elseif type(arg) == "number" then
		MEKA_RINGHUD: SetScale(arg)
	end
end

local RING_SHOW_COMBO = false

local function MEKA_RINGHUD_ClassPoints_Update(frame, event, ...)
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State ~= "RING" or Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack ~= "COMBO" then return end 
	if not (MEKA_RINGHUD and MEKA_RINGHUD.Left) then return end

	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_MAXPOWER" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "UPDATE_SHAPESHIFT_FORM" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" then
		if C.RTL or (F.PlayerClass == "DEATHKNIGHT") then
			MEKA_RINGHUD.Left.Bar4: Hide()
			MEKA_RINGHUD.Left.Bar7: Show()
		else
			MEKA_RINGHUD.Left.Bar4: Show()
			MEKA_RINGHUD.Left.Bar7: Hide()
		end

		if C.RTL and frame.Info.MP > 0 then
			RingBar7_UpdateMax(MEKA_RINGHUD.Left, frame.Info.MP)
		elseif F.PlayerClass == "DEATHKNIGHT" then
			RingBar7_UpdateMax(MEKA_RINGHUD.Left, 6)
		else
			RingBar7_UpdateMax(MEKA_RINGHUD.Left, 5)
		end
	end
	
	if frame.Info.CP > 0 then
		RingBar7_Update(MEKA_RINGHUD.Left, frame.Info.CP, nil, true)
		MEKA_RINGHUD.Left.Bar4: Hide()
		MEKA_RINGHUD.Left.Bar7: Show()
		RING_SHOW_COMBO = true
	else
		if frame.Info.E then
			RingBar7_Update(MEKA_RINGHUD.Left, frame.Info.E, frame.Info.PP)
		end
		RING_SHOW_COMBO = false
	end
end

local function MEKA_RINGHUD_ClassPoints_RuneUpdate(frame)
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State ~= "RING" or Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack ~= "COMBO" then return end 
	if not (MEKA_RINGHUD and MEKA_RINGHUD.Left) then return end
	if RING_SHOW_COMBO then return end
	for i = 1,6 do
		RingBar7_RuneUpdate(MEKA_RINGHUD.Left, frame.Rune[i].ready, i, frame.Rune[i].timer/frame.Rune[i].duration)
	end
end

local MEKA_RINGHUD_Config = {
	Database = {
		["MEKA_HUD"] = {
			Enable = true,
		},
	},

	Config = {
		Name = "MEKA ".."HUD",
		Type = "Switch", --Switch, Trigger, Blank, Dropdown
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_RINGHUD_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Enable = true
				self.Text:SetText(L["ON"])
				MEKA_RINGHUD_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = nil,
	},
}

MEKA_RINGHUD.Load = MEKA_RINGHUD_Load
--MEKA_RINGHUD.Config = MEKA_RINGHUD_Config
F.MEKA_RINGHUD_Toggle = MEKA_RINGHUD_Toggle
F.MEKA_RINGHUD_ClassPoints_Update = MEKA_RINGHUD_ClassPoints_Update
F.MEKA_RINGHUD_ClassPoints_RuneUpdate = MEKA_RINGHUD_ClassPoints_RuneUpdate
tinsert(E.Module, MEKA_RINGHUD)