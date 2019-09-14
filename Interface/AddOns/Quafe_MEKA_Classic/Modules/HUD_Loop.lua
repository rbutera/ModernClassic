local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale
--if F.IsClassic then return end

----------------------------------------------------------------
--> API Localization
----------------------------------------------------------------

local _G = getfenv(0)
local format = string.format
local find = string.find
local match = string.match

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
local deg = math.deg

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
	Ring1 = 315,
	Ring2 = 346,
	Ring3 = 300,
}

----------------------------------------------------------------
--> Frame
----------------------------------------------------------------

local function Border1_Template(frame)
	local Border = CreateFrame("Frame", nil, frame)
	Border: SetSize(78,330) --156,658+2

	local Border1 = Border:CreateTexture(nil, "BORDER")
	Border1: SetVertexColor(F.Color(C.Color.Main1))
	Border1: SetAlpha(0.5)
	Border1: SetSize(78,330)--68,528
	Border1: SetTexCoord(50/256,206/256, 182/1024,842/1024)
	Border1: SetPoint("CENTER", Border, "CENTER", 0,0)

	local Border1Sd = Border:CreateTexture(nil, "BACKGROUND")
	Border1Sd: SetVertexColor(F.Color(C.Color.Main0))
	Border1Sd: SetAlpha(0.25)
	Border1Sd: SetSize(78,330)
	Border1Sd: SetTexCoord(50/256,206/256, 182/1024,842/1024)
	Border1Sd: SetPoint("CENTER", Border, "CENTER", 0,0)

	if frame.Direction == "Left" then
		Border: SetPoint("CENTER", frame, "CENTER", -290,0) --579
		Border1: SetTexture(MEKA.Path("LoopBar\\Border1_1"))
		Border1Sd: SetTexture(MEKA.Path("LoopBar\\Border1_1_Sd"))
	elseif frame.Direction == "Right" then
		Border: SetPoint("CENTER", frame, "CENTER", 290,0)
		Border1: SetTexture(MEKA.Path("LoopBar\\Border1_2"))
		Border1Sd: SetTexture(MEKA.Path("LoopBar\\Border1_2_Sd"))
	end

	frame.Border1 = Border
end

local function Border2_Template(frame)
	local Border = CreateFrame("Frame", nil, frame)
	Border: SetSize(34,208) --66+2,414+2

	local Border1 = Border:CreateTexture(nil, "BORDER")
	Border1: SetVertexColor(F.Color(C.Color.Main1))
	Border1: SetAlpha(0.9)
	Border1: SetSize(34,208)
	Border1: SetTexCoord(30/128,98/128, 48/512,462/512)
	Border1: SetPoint("CENTER", Border, "CENTER", 0,0)

	local Border1Sd = Border:CreateTexture(nil, "BACKGROUND")
	Border1Sd: SetVertexColor(F.Color(C.Color.Main0))
	Border1Sd: SetAlpha(0.25)
	Border1Sd: SetSize(34,208)
	Border1Sd: SetTexCoord(30/128,98/128, 48/512,462/512)
	Border1Sd: SetPoint("CENTER", Border, "CENTER", 0,0)

	if frame.Direction == "Left" then
		Border: SetPoint("CENTER", frame, "CENTER", -236,0) --473
		Border1: SetTexture(MEKA.Path("LoopBar\\Border2_1"))
		Border1Sd: SetTexture(MEKA.Path("LoopBar\\Border2_1_Sd"))
	elseif frame.Direction == "Right" then
		Border: SetPoint("CENTER", frame, "CENTER", 236,0)
		Border1: SetTexture(MEKA.Path("LoopBar\\Border2_2"))
		Border1Sd: SetTexture(MEKA.Path("LoopBar\\Border2_2_Sd"))
	end

	frame.Border2 = Border
end

local function Border2_PowerNum_Update(frame, per, maxvalue)
	local value
	if E.Value[frame.Unit].Power.Type == 0 then
		value = per*100
	else
		value = per*maxvalue
	end
	local n1,n2,n3,n4,n5 = 0,0,0,0,0
	if not value then
		n1 = "b"
		n2 = "b"
		n3 = "b"
		n4 = "b"
		n5 = "b"
	else
		value = min(max(value, 0), 999)
		n1 = floor(value/100)
		n2 = "b"
		n3 = floor(value/10 - n1*10)
		n4 = "b"
		n5 = floor(value-floor(value/10)*10)
		if n1 == 0 and n3 == 0 then
			n1 = "b"
			n3 = n5
			n5 = "b"
		elseif n1 == 0 then
			n1 = "b"
			n2 = n3
			n3 = "b"
			n4 = n5
			n5 = "b"
		end
	end
	frame.PowerNum.Num[1]: SetTexture(F.Path("N12\\N"..n1))
	frame.PowerNum.Num[2]: SetTexture(F.Path("N12\\N"..n2))
	frame.PowerNum.Num[3]: SetTexture(F.Path("N12\\N"..n3))
	frame.PowerNum.Num[4]: SetTexture(F.Path("N12\\N"..n4))
	frame.PowerNum.Num[5]: SetTexture(F.Path("N12\\N"..n5))
end

local function Border2_Player_Artwork(frame)
	local PowerNum = CreateFrame("Frame", nil, frame.Border2)
	PowerNum: SetSize(12,12)
	PowerNum: SetPoint("CENTER", frame, "CENTER", -234,0)

	local Num = {}
	for i = 1,5 do
		Num[i] = F.Create.Texture(PowerNum, "OVERLAY", 1, F.Path("N12\\N".."9"), C.Color.Main1, 0.9, {32,32})
		Num[i]: SetPoint("CENTER", PowerNum, "CENTER", -12+4*i,-1)
	end

	frame.PowerNum = PowerNum
	frame.PowerNum.Num = Num
end

local function Border2_PowerNum_Toggle(frame, arg)
	if not (frame and frame.PowerNum) then return end
	if arg == "ON" then
		--frame.PowerNum: Show()
		frame.PowerNum: SetScript("OnUpdate", function(self)
			if F.Last10 == 0 then
				Border2_PowerNum_Update(frame, E.Value[frame.Unit].Power.Cur, E.Value[frame.Unit].Power.Max)
			end
		end)
	elseif arg == "OFF" then
		--frame.PowerNum: Hide()
		frame.PowerNum: SetScript("OnUpdate", nil)
	end
end

local function Border2_Target_Artwork(frame)
	local Back = frame.Border2:CreateTexture(nil, "BACKGROUND")
	Back: SetTexture(MEKA.Path("LoopBar\\Border2_4"))
	Back: SetVertexColor(F.Color(C.Color.Main0))
	Back: SetAlpha(0.75)
	Back: SetSize(40,45)
	Back: SetTexCoord(24/128,104/128, 19/128,109/128)
	Back: SetPoint("CENTER", frame, "CENTER", 234,0)

	local BackGlow = frame.Border2:CreateTexture(nil, "BORDER")
	BackGlow: SetTexture(MEKA.Path("LoopBar\\Border2_4"))
	BackGlow: SetVertexColor(F.Color(C.Color.Main1))
	BackGlow: SetAlpha(0.15)
	BackGlow: SetSize(40,45)
	BackGlow: SetTexCoord(24/128,104/128, 19/128,109/128)
	BackGlow: SetPoint("CENTER", Back, "CENTER", 0,0)

	local BackSd = frame.Border2:CreateTexture(nil, "BACKGROUND")
	BackSd: SetTexture(MEKA.Path("LoopBar\\Border2_4_Sd"))
	BackSd: SetVertexColor(F.Color(C.Color.Main0))
	BackSd: SetAlpha(0.25)
	BackSd: SetSize(40,45)
	BackSd: SetTexCoord(24/128,104/128, 19/128,109/128)
	BackSd: SetPoint("CENTER", Back, "CENTER", 0,0)

	local FCS_Bd1 = frame.Border1:CreateTexture(nil, "ARTWORK")
	FCS_Bd1: SetTexture(MEKA.Path("LoopBar\\Border2_5"))
	FCS_Bd1: SetVertexColor(F.Color(C.Color.Main1))
	FCS_Bd1: SetAlpha(0.9)
	FCS_Bd1: SetSize(40,72) --82,144
	FCS_Bd1: SetTexCoord(24/128,104/128, 56/256,200/256)
	FCS_Bd1: SetPoint("CENTER", frame, "CENTER", 277,115)

	local FCS_Bd1Sd = frame.Border1:CreateTexture(nil, "BACKGROUND")
	FCS_Bd1Sd: SetTexture(MEKA.Path("LoopBar\\Border2_5_Sd"))
	FCS_Bd1Sd: SetVertexColor(F.Color(C.Color.Main0))
	FCS_Bd1Sd: SetAlpha(0.25)
	FCS_Bd1Sd: SetSize(40,72) --82,144
	FCS_Bd1Sd: SetTexCoord(24/128,104/128, 56/256,200/256)
	FCS_Bd1Sd: SetPoint("CENTER", FCS_Bd1, "CENTER", 0,0)

	local FCS_Bd2 = frame.Border1:CreateTexture(nil, "ARTWORK")
	FCS_Bd2: SetTexture(MEKA.Path("LoopBar\\Border2_6"))
	FCS_Bd2: SetVertexColor(F.Color(C.Color.Main1))
	FCS_Bd2: SetAlpha(0.5)
	FCS_Bd2: SetSize(122,140) --244，280
	FCS_Bd2: SetTexCoord(6/256,250/256, 116/512,396/512)
	FCS_Bd2: SetPoint("CENTER", frame, "CENTER", 322,138)

	local FCS_Bd2Sd = frame.Border1:CreateTexture(nil, "BACKGROUND")
	FCS_Bd2Sd: SetTexture(MEKA.Path("LoopBar\\Border2_6_Sd"))
	FCS_Bd2Sd: SetVertexColor(F.Color(C.Color.Main0))
	FCS_Bd2Sd: SetAlpha(0.25)
	FCS_Bd2Sd: SetSize(122,140)
	FCS_Bd2Sd: SetTexCoord(6/256,250/256, 116/512,396/512)
	FCS_Bd2Sd: SetPoint("CENTER", FCS_Bd2, "CENTER", 0,0)

	local Info = CreateFrame("Frame", nil, frame.Block)
	Info: SetSize(32,32)
	Info: SetPoint("CENTER", Back, "CENTER", 0,0)

	local ClassIcon = frame.Border2: CreateTexture(nil, "ARTWORK")
	ClassIcon: SetTexture(F.Path("Icon_Class"))
	ClassIcon: SetSize(28,28)
	ClassIcon: SetPoint("CENTER", Info, "CENTER", 0,0)
	ClassIcon: SetAlpha(0)

	local Indicator = frame.Border2:CreateTexture(nil, "ARTWORK")
	Indicator: SetSize(32,32)
	Indicator: SetPoint("CENTER", Info, "CENTER", 0,0)
	Indicator: SetAlpha(0)

	frame.Info = Info
	frame.Info.ClassIcon = ClassIcon
	frame.Info.Indicator = Indicator
end

local function Border3_Template(frame)
	local Border = CreateFrame("Frame", nil, frame)
	Border: SetSize(208,34)
	Border: SetPoint("CENTER", frame, "CENTER", 0,236)

	local Border1 = Border:CreateTexture(nil, "BORDER")
	Border1: SetTexture(MEKA.Path("LoopBar\\Border2_3"))
	Border1: SetVertexColor(F.Color(C.Color.Main1))
	Border1: SetAlpha(0.9)
	Border1: SetSize(208,34)
	Border1: SetTexCoord(48/512,462/512, 30/128,98/128)
	Border1: SetPoint("CENTER", Border, "CENTER", 0,0)

	local Border1Sd = Border:CreateTexture(nil, "BACKGROUND")
	Border1Sd: SetTexture(MEKA.Path("LoopBar\\Border2_3_Sd"))
	Border1Sd: SetVertexColor(F.Color(C.Color.Main0))
	Border1Sd: SetAlpha(0.25)
	Border1Sd: SetSize(208,34)
	Border1Sd: SetTexCoord(48/512,462/512, 30/128,98/128)
	Border1Sd: SetPoint("CENTER", Border, "CENTER", 0,0)

	frame.Border3 = Border
end

local function LoopBar1_Template(frame, angle)
	local Bar = CreateFrame("Frame", nil, frame)
	Bar.Angle = angle

	local Bars = {}
	for i = 1,10 do
		Bars[i] = Bar:CreateTexture(nil, "ARTWORK")
		Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
		Bars[i]: SetVertexColor(F.Color(C.Color.Main3))
		Bars[i]: SetAlpha(0.75)
		Bars[i]: SetSize(32,32)
		Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(angle-3*i)), RADIUS.Ring1*sin(rad(angle-3*i)))
		Bars[i]: SetRotation(rad(angle-3*i))

		Bars[i].Sd = Bar:CreateTexture(nil, "BACKGROUND")
		Bars[i].Sd: SetTexture(MEKA.Path("LoopBar\\Bar1_12_Sd"))
		Bars[i].Sd: SetVertexColor(F.Color(C.Color.Main0))
		Bars[i].Sd: SetAlpha(0.25)
		Bars[i].Sd: SetSize(32,32)
		Bars[i].Sd: SetPoint("CENTER", Bars[i], "CENTER", 0,0)
		Bars[i].Sd: SetRotation(rad(angle-3*i))

		Bars[i].Bk = Bar:CreateTexture(nil, "BACKGROUND")
		Bars[i].Bk: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
		Bars[i].Bk: SetVertexColor(F.Color(C.Color.Main0))
		Bars[i].Bk: SetAlpha(0.75)
		Bars[i].Bk: SetSize(32,32)
		Bars[i].Bk: SetPoint("CENTER", Bars[i], "CENTER", 0,0)
		Bars[i].Bk: SetRotation(rad(angle-3*i))

		Bars[i].BkG = Bar:CreateTexture(nil, "BORDER")
		Bars[i].BkG: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
		Bars[i].BkG: SetVertexColor(F.Color(C.Color.Main3))
		Bars[i].BkG: SetAlpha(0.15)
		Bars[i].BkG: SetSize(32,32)
		Bars[i].BkG: SetPoint("CENTER", Bars[i], "CENTER", 0,0)
		Bars[i].BkG: SetRotation(rad(angle-3*i))
	end

	Flash = Bar:CreateTexture(nil, "OVERLAY")
	Flash: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
	Flash: SetVertexColor(F.Color(C.Color.Main3))
	Flash: SetAlpha(0)
	Flash: SetSize(32,32)
	Flash: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(angle-3)), RADIUS.Ring1*sin(rad(angle-3)))
	Flash: SetRotation(rad(angle-3))

	frame.Bar1 = Bar
	frame.Bar1.Bars = Bars
	frame.Bar1.Flash = Flash
end

local function LoopBar1_Update(frame, value)
	if not value then
		value = 0
	elseif value > 1 then
		value = 1
	elseif value < 0 then
		value = 0
	end

	if (not frame.Bar1.OldValue) or (frame.Bar1.OldValue ~= value) then
		frame.Bar1.OldValue = value
		local v1 = value*10
		local v2 = floor((v1 - floor(v1))*12 + 0.5)
		local r = rad(frame.Bar1.Angle-3*min(10, floor(v1)+1))

		for i = 1,10 do
			if i <= v1 then
				frame.Bar1.Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
			elseif (i > v1) and (i <= (v1+1)) then
				frame.Bar1.Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_"..v2))
			else
				frame.Bar1.Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_0"))
			end
		end

		if value > 0 and value < 1 then
			frame.Bar1.Flash: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(r), RADIUS.Ring1*sin(r))
			frame.Bar1.Flash: SetRotation(r)
			frame.Bar1.Flash: SetAlpha(0.2+0.8*F.Alpha4)
			if value <= 0.2 then
				frame.Bar1.Flash: SetVertexColor(F.Color(C.Color.Warn1))
				for i = 1,10 do
					frame.Bar1.Bars[i]: SetVertexColor(F.Color(C.Color.Warn1))
				end
			elseif value <= 0.35 then
				frame.Bar1.Flash: SetVertexColor(F.Color(C.Color.Main2))
				for i = 1,10 do
					frame.Bar1.Bars[i]: SetVertexColor(F.Color(C.Color.Main2))
				end
			else
				frame.Bar1.Flash: SetVertexColor(F.Color(C.Color.Main3))
				for i = 1,10 do
					frame.Bar1.Bars[i]: SetVertexColor(F.Color(C.Color.Main3))
				end
			end
		else
			frame.Bar1.Flash: SetAlpha(0)
			for i = 1,10 do
				frame.Bar1.Bars[i]: SetVertexColor(F.Color(C.Color.Main3))
			end
		end
	else
		if value > 0 and value < 1 then
			frame.Bar1.Flash: SetAlpha(0.2+0.8*F.Alpha4)
		else
			frame.Bar1.Flash: SetAlpha(0)
		end
	end
end

local function LoopBar2_Template(frame, angle)
	local Bar = CreateFrame("Frame", nil, frame)
	Bar.Angle = angle

	local Bars = {}
	for i = 1,5 do
		Bars[i] = Bar:CreateTexture(nil, "ARTWORK")
		Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
		Bars[i]: SetVertexColor(F.Color(C.Color.Main3))
		Bars[i]: SetAlpha(0.75)
		Bars[i]: SetSize(32,32)
		Bars[i]: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(angle-3*i)), RADIUS.Ring1*sin(rad(angle-3*i)))
		Bars[i]: SetRotation(rad(angle-3*i))

		Bars[i].Sd = Bar:CreateTexture(nil, "BACKGROUND")
		Bars[i].Sd: SetTexture(MEKA.Path("LoopBar\\Bar1_12_Sd"))
		Bars[i].Sd: SetVertexColor(F.Color(C.Color.Main0))
		Bars[i].Sd: SetAlpha(0.25)
		Bars[i].Sd: SetSize(32,32)
		Bars[i].Sd: SetPoint("CENTER", Bars[i], "CENTER", 0,0)
		Bars[i].Sd: SetRotation(rad(angle-3*i))

		Bars[i].Bk = Bar:CreateTexture(nil, "BACKGROUND")
		Bars[i].Bk: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
		Bars[i].Bk: SetVertexColor(F.Color(C.Color.Main0))
		Bars[i].Bk: SetAlpha(0.75)
		Bars[i].Bk: SetSize(32,32)
		Bars[i].Bk: SetPoint("CENTER", Bars[i], "CENTER", 0,0)
		Bars[i].Bk: SetRotation(rad(angle-3*i))

		Bars[i].BkG = Bar:CreateTexture(nil, "BORDER")
		Bars[i].BkG: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
		Bars[i].BkG: SetVertexColor(F.Color(C.Color.Main3))
		Bars[i].BkG: SetAlpha(0.15)
		Bars[i].BkG: SetSize(32,32)
		Bars[i].BkG: SetPoint("CENTER", Bars[i], "CENTER", 0,0)
		Bars[i].BkG: SetRotation(rad(angle-3*i))
	end

	Flash = Bar:CreateTexture(nil, "OVERLAY")
	Flash: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
	Flash: SetVertexColor(F.Color(C.Color.Main3))
	Flash: SetAlpha(0)
	Flash: SetSize(32,32)
	Flash: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(rad(angle-3)), RADIUS.Ring1*sin(rad(angle-3)))
	Flash: SetRotation(rad(angle-3))

	frame.Bar2 = Bar
	frame.Bar2.Bars = Bars
	frame.Bar2.Flash = Flash
end

local function LoopBar2_Update(frame, value)
	if not value then
		value = 0
	elseif value > 1 then
		value = 1
	elseif value < 0 then
		value = 0
	end

	if (not frame.Bar2.OldValue) or (frame.Bar2.OldValue ~= value) then
		frame.Bar2.OldValue = value

		local v1 = value*5
		local v2 = floor((v1 - floor(v1))*12 + 0.5)
		local r = rad(frame.Bar2.Angle-3*min(5, floor(v1)+1))

		for i = 1,5 do
			if i <= v1 then
				frame.Bar2.Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_12"))
			elseif (i > v1) and (i <= (v1+1)) then
				frame.Bar2.Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_"..v2))
			else
				frame.Bar2.Bars[i]: SetTexture(MEKA.Path("LoopBar\\Bar1_0"))
			end
		end

		if value > 0 and value < 1 then
			frame.Bar2.Flash: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring1*cos(r), RADIUS.Ring1*sin(r))
			frame.Bar2.Flash: SetRotation(r)
			frame.Bar2.Flash: SetAlpha(0.2+0.8*F.Alpha4)
		else
			frame.Bar2.Flash: SetAlpha(0)
		end
	else
		if value > 0 and value < 1 then
			frame.Bar2.Flash: SetAlpha(0.2+0.8*F.Alpha4)
		else
			frame.Bar2.Flash: SetAlpha(0)
		end
	end
end

local function LoopBar3_Template(frame, a1, a2)
	local Bar = CreateFrame("Frame", nil, frame)
	Bar.Angle = a2 - a1
	Bar.AngleStart = a1
	Bar.AngleEnd = a2

	local Vernier = Bar:CreateTexture(nil, "ARTWORK")
	Vernier: SetTexture(MEKA.Path("LoopBar\\Bar2"))
	Vernier: SetVertexColor(F.Color(C.Color.Main1))
	Vernier: SetAlpha(1)
	Vernier: SetSize(32,32)
	Vernier: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring2*cos(rad(a1)), RADIUS.Ring2*sin(rad(a1)))
	Vernier: SetRotation(rad(a1))

	local VernierSd = Bar:CreateTexture(nil, "BACKGROUND")
	VernierSd: SetTexture(MEKA.Path("LoopBar\\Bar2_Sd"))
	VernierSd: SetVertexColor(F.Color(C.Color.Main0))
	VernierSd: SetAlpha(0.25)
	VernierSd: SetSize(32,32)
	VernierSd: SetPoint("CENTER", Vernier, "CENTER", 0,0)

	frame.Bar3 = Bar
	frame.Bar3.Vernier = Vernier
	frame.Bar3.VernierSd = VernierSd
end

local function LoopBar3_Update(frame, value)
	if not value then
		value = 0
	elseif value > 1 then
		value = 1
	elseif value < 0 then
		value = 0
	end

	if (not frame.Bar3.OldValue) or (frame.Bar3.OldValue ~= value) then
		frame.Bar3.OldValue = value

		local r = value * frame.Bar3.Angle + frame.Bar3.AngleStart

		frame.Bar3.Vernier: SetPoint("CENTER", frame, "CENTER", RADIUS.Ring2*cos(rad(r)), RADIUS.Ring2*sin(rad(r)))
		frame.Bar3.Vernier: SetRotation(rad(r))
		frame.Bar3.VernierSd: SetRotation(rad(r))
	end
end

local function LoopBar4_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame)

	local Scroll = CreateFrame("ScrollFrame", nil, Bar)
	Scroll: SetSize(1024, 512)

	local RingHold = CreateFrame("Frame", nil, Scroll)
	RingHold: SetSize(1024, 1024)
	Scroll: SetScrollChild(RingHold)

	if frame.Direction == "Left" then
		Bar.Base = 0
		Scroll: SetPoint("BOTTOM", frame, "CENTER", 0,0)
	elseif frame.Direction == "Right" then
		Bar.Base = 180
		Scroll: SetPoint("TOP", frame, "CENTER", 0,0)
		Scroll: SetVerticalScroll(512)
	end

	local Ring = RingHold:CreateTexture(nil, "ARTWORK")
	Ring: SetTexture(MEKA.Path("LoopBar\\Bar3"))
	Ring: SetSize(1024, 1024)
    Ring: SetPoint("CENTER", RingHold, "CENTER", 0,0)
    Ring: SetVertexColor(F.Color(C.Color.Main2))
	Ring: SetAlpha(1)
	Ring: SetRotation(rad(Bar.Base))

	frame.Bar4 = Bar
	frame.Bar4.Ring = Ring
end

local function LoopBar4_Update(frame, value)
	if not value then
		value = 0
	elseif value > 1 then
		value = 1
	elseif value < 0 then
		value = 0
	end

	if (not frame.Bar4.OldValue) or (frame.Bar4.OldValue ~= value) then
		frame.Bar4.OldValue = value

		local r = value*30
		frame.Bar4.Ring: SetRotation(rad(frame.Bar4.Base-r))
	end
end

local function LoopBar5_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame)

	local Scroll1 = CreateFrame("ScrollFrame", nil, Bar)
	Scroll1: SetSize(1024, 512)
	local RingHold1 = CreateFrame("Frame", nil, Scroll1)
	RingHold1: SetSize(1024, 1024)
	Scroll1: SetScrollChild(RingHold1)

	local Scroll2 = CreateFrame("ScrollFrame", nil, Bar)
	Scroll2: SetSize(1024, 512)
	local RingHold2 = CreateFrame("Frame", nil, Scroll2)
	RingHold2: SetSize(1024, 1024)
	Scroll2: SetScrollChild(RingHold2)

	if frame.Direction == "Left" then
		Bar.Base = 0
		Scroll1: SetPoint("BOTTOM", frame, "CENTER", 0,0)
		Scroll2: SetPoint("TOP", frame, "CENTER", 0,0)
		Scroll2: SetVerticalScroll(512)
	elseif frame.Direction == "Right" then
		Bar.Base = 180
		Scroll1: SetPoint("TOP", frame, "CENTER", 0,0)
		Scroll1: SetVerticalScroll(512)
		Scroll2: SetPoint("BOTTOM", frame, "CENTER", 0,0)
	end

	local Ring1A = RingHold1:CreateTexture(nil, "ARTWORK")
	Ring1A: SetTexture(MEKA.Path("LoopBar\\Bar4"))
	Ring1A: SetSize(1024, 1024)
    Ring1A: SetPoint("CENTER", RingHold1, "CENTER", 0,0)
    Ring1A: SetVertexColor(F.Color(C.Color.Main1))
	Ring1A: SetAlpha(1)
	Ring1A: SetRotation(rad(Bar.Base))

	local Ring1B = RingHold1:CreateTexture(nil, "BORDER")
	Ring1B: SetTexture(MEKA.Path("LoopBar\\Bar4"))
	Ring1B: SetSize(1024, 1024)
    Ring1B: SetPoint("CENTER", RingHold1, "CENTER", 0,0)
    Ring1B: SetVertexColor(F.Color(C.Color.Main2))
	Ring1B: SetAlpha(1)
	Ring1B: SetRotation(rad(Bar.Base))

	local Ring2 = RingHold2:CreateTexture(nil, "ARTWORK")
	Ring2: SetTexture(MEKA.Path("LoopBar\\Bar4"))
	Ring2: SetSize(1024, 1024)
    Ring2: SetPoint("CENTER", RingHold2, "CENTER", 0,0)
    Ring2: SetVertexColor(F.Color(C.Color.Main1))
	Ring2: SetAlpha(1)
	Ring2: SetRotation(rad(Bar.Base+180))

	local Ring1Bg = RingHold1:CreateTexture(nil, "BACKGROUND")
	Ring1Bg: SetTexture(MEKA.Path("LoopBar\\Bar4_Sd"))
	Ring1Bg: SetSize(1024, 1024)
    Ring1Bg: SetPoint("CENTER", RingHold1, "CENTER", 0,0)
    Ring1Bg: SetVertexColor(F.Color(C.Color.Main0))
	Ring1Bg: SetAlpha(0.25)
	Ring1Bg: SetRotation(rad(Bar.Base-30))

	local Ring2Bg = RingHold2:CreateTexture(nil, "BACKGROUND")
	Ring2Bg: SetTexture(MEKA.Path("LoopBar\\Bar4_Sd"))
	Ring2Bg: SetSize(1024, 1024)
    Ring2Bg: SetPoint("CENTER", RingHold2, "CENTER", 0,0)
    Ring2Bg: SetVertexColor(F.Color(C.Color.Main0))
	Ring2Bg: SetAlpha(0.25)
	Ring2Bg: SetRotation(rad(Bar.Base-150))

	local Bd1 = Bar:CreateTexture(nil, "ARTWORK")
	Bd1: SetTexture(MEKA.Path("RingBar\\Castbar1_Bd1"))
	Bd1: SetVertexColor(F.Color(C.Color.Main1))
	Bd1: SetAlpha(0.9)
	Bd1: SetSize(32,32)
	
	local Bd2 = Bar:CreateTexture(nil, "ARTWORK")
	Bd2: SetTexture(MEKA.Path("RingBar\\Castbar1_Bd1"))
	Bd2: SetVertexColor(F.Color(C.Color.Main1))
	Bd2: SetAlpha(0.9)
	Bd2: SetSize(32,32)

	local Bd3 = Bar:CreateTexture(nil, "ARTWORK")
	Bd3: SetTexture(MEKA.Path("RingBar\\Castbar1_Bd1"))
	Bd3: SetVertexColor(F.Color(C.Color.Main1))
	Bd3: SetAlpha(0.9)
	Bd3: SetSize(32,32)

	if frame.Direction == "Left" then
		Bd1: SetPoint("CENTER", frame, "CENTER", 275*cos(rad(149)), 275*sin(rad(149)))
		Bd1: SetRotation(rad(59))
		Bd2: SetPoint("CENTER", frame, "CENTER", 275*cos(rad(-179)), 275*sin(rad(-179)))
		Bd2: SetRotation(rad(-89))
		Bd3: SetPoint("CENTER", frame, "CENTER", 275*cos(rad(-149)), 275*sin(rad(-149)))
		Bd3: SetRotation(rad(-59))
	elseif frame.Direction == "Right" then
		Bd1: SetPoint("CENTER", frame, "CENTER", 275*cos(rad(-31)), 275*sin(rad(-31)))
		F.RotateTexture(Bd1, 59)
		Bd2: SetPoint("CENTER", frame, "CENTER", 275*cos(rad(1)), 275*sin(rad(1)))
		F.RotateTexture(Bd2, -89)
		Bd3: SetPoint("CENTER", frame, "CENTER", 275*cos(rad(31)), 275*sin(rad(31)))
		Bd3: SetRotation(rad(-59))
	end

	frame.Bar5 = Bar
	frame.Bar5.Ring1A = Ring1A
	frame.Bar5.Ring1B = Ring1B
	frame.Bar5.Ring2 = Ring2
	frame.Bar5.Bg1 = Ring1Bg
	frame.Bar5.Bg2 = Ring2Bg
	frame.Bar5.Bd1 = Bd1
	frame.Bar5.Bd2 = Bd2
	frame.Bar5.Bd3 = Bd3
	frame.Bar5: Hide()
end

local function LoopBar5_Update(frame, value1, bothway, value2)
	if not value1 then
		value1 = 0
	elseif value1 > 1 then
		value1 = 1
	elseif value1 < 0 then
		value1 = 0
	end

	if (not frame.Bar5.OldValue1) or (frame.Bar5.OldValue1 ~= value1) then
		frame.Bar5.OldValue1 = value1

		value1 = value1*30

		frame.Bar5.Ring1A: SetRotation(rad(frame.Bar5.Base-value1))
		if bothway then
			frame.Bar5.Ring2: SetRotation(rad(frame.Bar5.Base+180+value1))
		end
	end

	if (not frame.Bar5.OldValue2) or (frame.Bar5.OldValue2 ~= value2) then
		frame.Bar5.OldValue2 = value2

		if value2 then
			if value2 > 1 then
				value2 = 1
			elseif value2 < 0 then
				value2 = 0
			end
			value2 = value2*30
			frame.Bar5.Ring1B: SetRotation(rad(frame.Bar5.Base-value2))
		end
	end
end

local function LoopBar6_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame)
	Bar.Angle = -15
	Bar.AngleStart = 165

	local Border = F.Create.Texture(Bar, "ARTWORK", 1, MEKA.Path("LoopBar\\Bar5"), C.Color.Main1, 0.5, {51,101}, {13/128,115/128,27/256,229/256})
	Border: SetPoint("CENTER", frame, "CENTER", -342, 142)

	local BorderSd = F.Create.Texture(Bar, "BACKGROUND", 1, MEKA.Path("LoopBar\\Bar5_Sd"), C.Color.Main0, 0.25, {51,101}, {13/128,115/128,27/256,229/256})
	BorderSd: SetPoint("CENTER", Border, "CENTER", 0, 0)

	local Vernier1 = F.Create.Texture(Bar, "ARTWORK", 1, MEKA.Path("LoopBar\\Bar2"), C.Color.Main2, 0.9, {32,32}, nil)
	Vernier1: SetPoint("CENTER", frame, "CENTER", 390*cos(rad(Bar.AngleStart)), 390*sin(rad(Bar.AngleStart)))
	Vernier1: SetRotation(rad(Bar.AngleStart))

	local Vernier1Sd = F.Create.Texture(Bar, "BACKGROUND", 0.25, MEKA.Path("LoopBar\\Bar2_Sd"), C.Color.Main0, 0.25, {32,32}, nil)
	Vernier1Sd: SetPoint("CENTER", Vernier1, "CENTER", 0, 0)
	Vernier1Sd: SetRotation(rad(Bar.AngleStart))

	local Vernier2 = F.Create.Texture(Bar, "ARTWORK", 1, MEKA.Path("LoopBar\\Bar2"), C.Color.Main1, 0.9, {32,32}, nil)
	Vernier2: SetPoint("CENTER", frame, "CENTER", 410*cos(rad(Bar.AngleStart)), 410*sin(rad(Bar.AngleStart)))
	Vernier2: SetRotation(rad(Bar.AngleStart))

	local Vernier2Sd = F.Create.Texture(Bar, "BACKGROUND", 0.25, MEKA.Path("LoopBar\\Bar2_Sd"), C.Color.Main0, 0.25, {32,32}, nil)
	Vernier2Sd: SetPoint("CENTER", Vernier2, "CENTER", 0, 0)
	Vernier2Sd: SetRotation(rad(Bar.AngleStart))

	frame.Bar6 = Bar
	frame.Bar6.Vernier1 = Vernier1
	frame.Bar6.Vernier1Sd = Vernier1Sd
	frame.Bar6.Vernier2 = Vernier2
	frame.Bar6.Vernier2Sd = Vernier2Sd
	frame.Bar6: Hide()
end
F.LoopBar6_Template = LoopBar6_Template

local function LoopBar6_Update(frame, value1, value2, zero1, zero2)
	if value1 then
		if value1 > 1 then
			value1 = 1
		elseif value1 < 0 then
			value1 = 0
		end
		value1 = value1 * frame.Bar6.Angle + frame.Bar6.AngleStart
		frame.Bar6.Vernier1: SetPoint("CENTER", frame, "CENTER", 390*cos(rad(value1)), 390*sin(rad(value1)))
		frame.Bar6.Vernier1: SetRotation(rad(value1))
		frame.Bar6.Vernier1Sd: SetRotation(rad(value1))
	end
	if value2 then
		if value2 > 1 then
			value2 = 1
		elseif value2 < 0 then
			value2 = 0
		end
		value2 = value2 * frame.Bar6.Angle + frame.Bar6.AngleStart
		frame.Bar6.Vernier2: SetPoint("CENTER", frame, "CENTER", 410*cos(rad(value2)), 410*sin(rad(value2)))
		frame.Bar6.Vernier2: SetRotation(rad(value2))
		frame.Bar6.Vernier2Sd: SetRotation(rad(value2))
	end
	if zero1 then
		zero1 = 0 * frame.Bar6.Angle + frame.Bar6.AngleStart
		frame.Bar6.Vernier1: SetPoint("CENTER", frame, "CENTER", 390*cos(rad(zero1)), 390*sin(rad(zero1)))
		frame.Bar6.Vernier1: SetRotation(rad(zero1))
		frame.Bar6.Vernier1Sd: SetRotation(rad(zero1))
	end
	if zero2 then
		zero2 = 0 * frame.Bar6.Angle + frame.Bar6.AngleStart
		frame.Bar6.Vernier2: SetPoint("CENTER", frame, "CENTER", 410*cos(rad(zero2)), 410*sin(rad(zero2)))
		frame.Bar6.Vernier2: SetRotation(rad(zero2))
		frame.Bar6.Vernier2Sd: SetRotation(rad(zero2))
	end
end
F.LoopBar6_Update = LoopBar6_Update

local function Num48_Template(frame, angle)
	local Num48 = CreateFrame("Frame", nil, frame)

	local Nums = {}
	for i = 1,3 do
		Nums[i] = Num48:CreateTexture(nil, "ARTWORK")
		Nums[i]: SetTexture(F.Path("N48\\N0"))
		Nums[i]: SetSize(32,32)
		Nums[i]: SetVertexColor(F.Color(C.Color.Main1))
		Nums[i]: SetAlpha(1)

		if frame.Direction == "Left" then
			Nums[i]: SetPoint("CENTER", frame, "CENTER", (330-10*(i-1))*cos(rad(angle)), (330-10*(i-1))*sin(rad(angle)))
			Nums[i]: SetRotation(rad(180+angle))
		elseif frame.Direction == "Right" then
			Nums[i]: SetPoint("CENTER", frame, "CENTER", (310+10*(i-1))*cos(rad(angle)), (310+10*(i-1))*sin(rad(angle)))
			Nums[i]: SetRotation(rad(angle))
		end
	end

	frame.Num48 = Num48
	frame.Num48.Nums = Nums
end

local function Num48_Update(frame, value)
	local d1,d2,d3,n1,n2,n3 = 0,0,0
	if value then
		if value > 100 then
			value = 100
		elseif value < 0 then
			value = 0
		end

		d1 = floor(value)
		d2 = floor((value-d1)*10)
		d3 = floor(value*100-floor(value*10)*10)
		if d1 == 0 and d2 == 0 then
			n1 = d3
			n2 = "d"
			n3 = floor(value*1e4-floor(value*1e3)*10)
		else
			n1 = d1
			n2 = d2
			n3 = d3
		end
	else
		n1 = "b"
		n2 = "b"
		n3 = "b"
	end
	frame.Num48.Nums[1]: SetTexture(F.Path("N48\\N"..n1))
	frame.Num48.Nums[2]: SetTexture(F.Path("N48\\N"..n2))
	frame.Num48.Nums[3]: SetTexture(F.Path("N48\\N"..n3))
end

local function rTP_RotateArrow(x1, y1)
	local x2,y2 = WorldFrame:GetCenter()
	local x3 = x1-x2
	local y3 = y1-y2
	local d = deg(atan(y3/x3))

	if x3 >= 0 and y3 >= 0 then
		d = d
	elseif x3 >= 0 and y3 <= 0 then
		d = d
	elseif x3 <= 0 and y3 >= 0 then
		d = (180+d)
	elseif x3 <= 0 and y3 <= 0 then
		d = (d-180)
	end
	return d
end

local function TargetArrow_PosArrow(frame, angle)
	angle = rad(angle)
	frame.Icon1: SetPoint("CENTER", frame, "CENTER", 206*cos(angle), 206*sin(angle))
	frame.Icon1: SetRotation(angle)
	frame.Icon2: SetPoint("CENTER", frame, "CENTER", 206*cos(angle), 206*sin(angle))
	frame.Icon2: SetRotation(angle)
	frame.IconSd: SetPoint("CENTER", frame, "CENTER", 206*cos(angle), 206*sin(angle))
	frame.IconSd: SetRotation(angle)
end

local function TargetArrow_SetShow(frame, isshow)
	frame.Icon1: SetShown(isshow)
	frame.Icon2: SetShown(isshow)
	frame.IconSd: SetShown(isshow)
end

local function TargetArrow_Create(frame)
	--> rTargetPointer(zork)
	--local SEARCH_TARGET, HAS_FOCUS, LAST_POINT, NP_INDEX, PLATES = false, false, {}, nil, {}
	--local UPDATE_ELAPSED, UPDATE_INTERVAL = 0,0.1
	local SEARCH_TARGET

	local Arrow = CreateFrame("Frame", nil, frame)
	Arrow: SetSize(8,8)
	Arrow: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Icon1 = Arrow:CreateTexture(nil, "ARTWORK")
	Icon1: SetTexture(MEKA.Path("LoopBar\\Border2_7_1"))
	Icon1: SetSize(32,32)
	Icon1: SetVertexColor(F.Color(C.Color.Main2))
	Icon1: SetAlpha(1)

	local Icon2 = Arrow:CreateTexture(nil, "ARTWORK")
	Icon2: SetTexture(MEKA.Path("LoopBar\\Border2_7_2"))
	Icon2: SetSize(32,32)
	Icon2: SetVertexColor(F.Color(C.Color.Main1))
	Icon2: SetAlpha(1)

	local IconSd = Arrow:CreateTexture(nil, "ARTWORK")
	IconSd: SetTexture(MEKA.Path("LoopBar\\Border2_7_Sd"))
	IconSd: SetSize(32,32)
	IconSd: SetVertexColor(F.Color(C.Color.Main0))
	IconSd: SetAlpha(0.25)

	Arrow.Icon1 = Icon1
	Arrow.Icon2 = Icon2
	Arrow.IconSd = IconSd

	local Sizer = CreateFrame("Frame", nil, WorldFrame)
	local Timer = CreateFrame("Frame")

	local function TargetArrow_RePos()
		local plate = C_NamePlate.GetNamePlateForUnit("target", issecure());
		if (plate) then
			if (not plate:IsForbidden()) then
				Sizer: ClearAllPoints()
				Sizer: SetPoint("TOPRIGHT", plate, "CENTER", 0,0)
				Sizer: SetPoint("BOTTOMLEFT", WorldFrame, "BOTTOMLEFT", 0,0)
				TargetArrow_PosArrow(Arrow, rTP_RotateArrow(Sizer:GetSize()))
				Sizer: Show()
				TargetArrow_SetShow(Arrow, true)
			else
				TargetArrow_SetShow(Arrow, false)
			end
			SEARCH_TARGET = false
		else
			TargetArrow_SetShow(Arrow, false)
		end
	end

	local function TargetArrow_Update()
		Timer: SetScript("OnUpdate", function(self, elapsed)
			if F.Last5 == 0 then
				TargetArrow_RePos()
				if (not SEARCH_TARGET) then
					self: SetScript("OnUpdate", nil)
				end
			end
		end)
	end
	--[[
	Timer: SetScript("OnUpdate", function(self, elapsed)
		if F.Last5 == 0 then
			Sizer: Hide()
			local index = 1
			local plate
			if SEARCH_TARGET then
				while index do
					plate = _G["NamePlate"..index]
					if plate then
						--if UnitIsUnit("target", "nameplate"..index) then --> Bug: 单位nameplateN 和 框体NamePlateN 可能不一致
						if plate:IsShown() and plate:GetAlpha() == 1 then
							index = false
							if not plate:IsForbidden() then
								Sizer: ClearAllPoints()
								Sizer: SetPoint("TOPRIGHT", plate, "CENTER", 0,0)
								Sizer: SetPoint("BOTTOMLEFT", WorldFrame, "BOTTOMLEFT", 0,0)
								TargetArrow_PosArrow(Arrow, rTP_RotateArrow(Sizer:GetSize()))
								Sizer: Show()
								TargetArrow_SetShow(Arrow, true)
								break
							else
								TargetArrow_SetShow(Arrow, false)
							end
						else
							index = index + 1
							TargetArrow_SetShow(Arrow, false)
						end
					else
						index = false
						TargetArrow_SetShow(Arrow, false)
					end
				end
			end
		end
	end)
	--]]
	Sizer: SetScript("OnSizeChanged", function(self, x, y)
		if self:IsShown() then
			TargetArrow_PosArrow(Arrow, rTP_RotateArrow(x, y))
		end
	end)
	Sizer: Hide()

	Arrow: RegisterEvent("PLAYER_TARGET_CHANGED")
	Arrow: RegisterEvent("NAME_PLATE_CREATED");
	--Arrow: RegisterEvent("FORBIDDEN_NAME_PLATE_CREATED");
	Arrow: RegisterEvent("NAME_PLATE_UNIT_ADDED");
	--Arrow: RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_ADDED");
	Arrow: RegisterEvent("NAME_PLATE_UNIT_REMOVED");
	--Arrow: RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_REMOVED");
	Arrow: SetScript("OnEvent", function(self, event, ...)
		Sizer: Hide()
		TargetArrow_SetShow(Arrow, false)
		if UnitExists("target") and not UnitIsUnit("target","player") then
			SEARCH_TARGET = true
			TargetArrow_RePos()
			TargetArrow_Update()
			--Timer: Show()
		else
			SEARCH_TARGET = false
			--Timer: Hide()
		end
	end)
end
F.TargetArrow_Create = TargetArrow_Create

local function LeftFrame_Create(frame)
	local Left = CreateFrame("Frame", nil, frame)
	Left: SetSize(4,4)
	Left: SetPoint("CENTER", frame, "CENTER", 0,0)
	Left.Direction = "Left"
	Left.Unit = "player"

	Border1_Template(Left)
	Border2_Template(Left)
	--Border3_Template(Left)
	LoopBar1_Template(Left, 178.5+3)
	LoopBar2_Template(Left, -151.5+3)
	LoopBar3_Template(Left, -150,-165)
	LoopBar4_Template(Left)
	LoopBar5_Template(Left)
	LoopBar6_Template(Left)
	Num48_Template(Left, -172.5)
	Border2_Player_Artwork(Left)

	frame.Left = Left
end

local function RightFrame_Create(frame)
	local Right = CreateFrame("Frame", nil, frame)
	Right: SetSize(4,4)
	Right: SetPoint("CENTER", frame, "CENTER", 0,0)
	Right.Direction = "Right"
	Right.Unit = "target"

	Border1_Template(Right)
	Border2_Template(Right)
	Border2_Target_Artwork(Right)
	LoopBar1_Template(Right, -1.5+3)
	LoopBar3_Template(Right, 0,-30)
	LoopBar4_Template(Right)
	LoopBar5_Template(Right)
	Right.Bar5: Show()
	Right.Bar5: SetAlpha(0)
	Right.Bar5.Bg2: Hide()
	Right.Bar5.Bd3: Hide()
	Num48_Template(Right, 7.5)

	frame.Right = Right
end

----------------------------------------------------------------
--> Update
----------------------------------------------------------------

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
		LoopBar1_Update(frame, E.Value[frame.Unit].Health.Cur)
		LoopBar2_Update(frame, E.Value[frame.Unit].Power.Cur)
		LoopBar4_Update(frame, E.Value[frame.Unit].Absorb.Cur)
	end

	if F.Last10 == 0 then
		if frame.ShowMana then
			LoopBar3_Update(frame, E.Value[frame.Unit].Mana.Cur)
			if not frame.Bar3:IsShown() then
				frame.Bar3:SetShown(true)
			end
		else
			if frame.Bar3:IsShown() then
				frame.Bar3:SetShown(false)
			end
		end

		if frame.ShowPet then
			LoopBar6_Update(frame, E.Value["pet"].Health.Cur)
			LoopBar6_Update(frame, nil, E.Value["pet"].Power.Cur)
		end

		if frame.Insane then
			LoopBar5_Update(frame, E.Value[frame.Unit].Power.Cur, true)
		end
		Num48_Update(frame, E.Value[frame.Unit].Health.Cur)
	end
end

local PowerColor = {
	--Insane = { r = 132, g = 52, b = 254 },
	Insane = { r = 168, g = 112, b = 254 },
}
local DeathKnight_CombatLog = {
	LogON = false,
}
local DeathKnight_Damage5 = {}

local function Priest_Event(frame, event, ...)
	if event == "PLAYER_LOGIN" then
		frame: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	end
	if event == "PLAYER_LOGIN" or event == "PLAYER_SPECIALIZATION_CHANGED" then
		if GetSpecialization() == SPEC_PRIEST_SHADOW then
			--frame: RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
			frame: RegisterUnitEvent("UNIT_AURA", "player")
			event = "UNIT_AURA"
			frame.Bar5.Bd2: Hide()
			frame.Bar5.Ring1A: SetVertexColor(F.Color(PowerColor.Insane))
			frame.Bar5.Ring2: SetVertexColor(F.Color(PowerColor.Insane))
		else
			frame: UnregisterEvent("UNIT_AURA")
			frame.Bar5: Hide()
			if frame.Insane then
				frame.Insane = nil
			end
		end
	elseif (event == "UNIT_AURA") then
		if GetSpecialization() == SPEC_PRIEST_SHADOW then
			local insane = IsInsane();  --194249 虚空形态
			if (insane and not frame.Insane) then
				--> Gained insanity
				frame.Bar5: Show()
			elseif (not insane and frame.Insane) then
				--> Lost insanity
				frame.Bar5: Hide()
			end
			frame.Insane = insane;
		end
	end
end

local function DeathKnight_Event(frame, event, ...)
	if event == "PLAYER_LOGIN" then
		DeathKnight_CombatLog.LogON = true
		DeathKnight_CombatLog.LogEvent = function(timestamp, eventParam, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, Param12, Param13, Param14, Param15, Param16, Param17, Param18, Param19, Param20, Param21, Param22, Param23, Param24)
			if destName ~= F.PlayerName then return end
			local damage = 0
			--if strfind(eventParam, "_DAMAGE") then
			if eventParam == "SWING_DAMAGE" then
				damage = Param12 or 0
			elseif eventParam == "SPELL_DAMAGE" or eventParam == "SPELL_PERIODIC_DAMAGE" or eventParam == "SPELL_BUILDING_DAMAGE" then
				damage = Param15 or 0
			end
			tinsert(DeathKnight_Damage5, {T = 5, D = damage})
		end
		tinsert(E.CombatLogList, DeathKnight_CombatLog)
		frame.Bar5.Bg2: Hide()
		frame.Bar5.Bd3: Hide()
	end
end

local function HUD_Player_EventExtra(frame, event, ...)
	if F.PlayerClass == "PRIEST" then
		if not F.IsClassic then
			Priest_Event(frame, event, ...)
		end
	elseif F.PlayerClass == "DEATHKNIGHT" then
		DeathKnight_Event(frame, event, ...)
	end
end

local function DeathKnight_Update(frame, elapsed)
	if F.PlayerClass ~= "DEATHKNIGHT" then return end
	local Damage2,Damage3 = 0,0
	if DeathKnight_Damage5[1] then
		for k,v in ipairs(DeathKnight_Damage5) do
			if (v.T > 0) then
				if (v.T < 2) then
					Damage2 = Damage2 + v.D
				elseif (v.T < 5) then
					Damage3 = Damage3 + v.D
				end
			end
			v.T = v.T - elapsed
		end
		while (DeathKnight_Damage5[1] and DeathKnight_Damage5[1].T <=0) do
			table.remove(DeathKnight_Damage5, 1)
		end
	end
	if F.Last25 == 0 then
		if (Damage2 + Damage3) > 0 then
			frame.Bar5: Show()
		else
			frame.Bar5: Hide()
		end
		LoopBar5_Update(frame, Damage3/(E.Value[frame.Unit].Health.Max+F.Debug), false, (Damage2+Damage3)/(E.Value[frame.Unit].Health.Max+F.Debug))
	end
end

local function HUD_Player_UpdateExtra(frame, elapsed)
	if F.PlayerClass == "DEATHKNIGHT" then
		DeathKnight_Update(frame, elapsed)
	end
end

local function HUD_Left_Update(frame)
	frame.Left: RegisterEvent("PLAYER_LOGIN")
	frame.Left: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame.Left: RegisterEvent("UNIT_PET")
	frame.Left: RegisterEvent("PET_UI_UPDATE")
	if not F.IsClassic then
		frame.Left: RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
		frame.Left: RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	end
	frame.Left: RegisterUnitEvent("UNIT_DISPLAYPOWER")
	frame.Left: RegisterUnitEvent("UNIT_MAXPOWER", "player")
	frame.Left: SetScript("OnEvent", function(self, event, ...)
		HUD_Player_Event(self, event, ...)
		HUD_Player_EventExtra(self, event, ...)
	end)
	frame.Left: SetScript("OnUpdate", function(self, elapsed)
		HUD_Player_Update(self, elapsed)
		HUD_Player_UpdateExtra(self, elapsed)
	end)
end

local function HUD_Target_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "UNIT_FACTION" then
		F.Smooth_Health(frame.Unit)
		F.Smooth_Power(frame.Unit)
		F.Smooth_Absorb(frame.Unit)

		frame.ShowMana = false
		local powerType = UnitPowerType(frame.Unit)
		if powerType ~= 0 then
			local maxmana = UnitPowerMax(frame.Unit, 0)
			if maxmana ~= 0 then
				frame.ShowMana = true
			end
		end
		
		if frame.ShowMana then
			F.Smooth_Mana(frame.Unit)
		end

		if UnitExists(frame.Unit) then
			local isPlayer = UnitIsPlayer(frame.Unit) 
			local isDenied = false
			if isPlayer then
				local eClass = select(2, UnitClass(frame.Unit))
				if Icon_Class[eClass] then
					frame.Info.ClassIcon: SetTexCoord(unpack(Icon_Class[eClass]))
				else
					frame.Info.ClassIcon: SetTexCoord(0,F.Debug, 0,F.Debug)
				end
			else
				if (not UnitPlayerControlled(frame.Unit) and UnitIsTapDenied(frame.Unit)) then
					isDenied = true
				end
			end
			local isPVP = UnitIsPVP(frame.Unit)
			local factionGroup = UnitFactionGroup(frame.Unit)
			local isQuest
			if F.IsClassic then
				
			else
				isQuest = UnitIsQuestBoss(frame.Unit)
			end
			if isQuest then
				frame.Info: SetAlpha(1)
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
				frame.Info.Indicator: SetAlpha(0)
				frame.Info.ClassIcon: SetAlpha(1)
			else
				frame.Info.ClassIcon: SetAlpha(0)
				if isPVP and factionGroup == "Alliance" then
					frame.Info: SetAlpha(1)
					frame.Info.Indicator: SetTexture(F.Path("Icon_PVP_Alliance"))
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.B1))
					frame.Info.Indicator: SetAlpha(1)
				elseif isPVP and factionGroup == "Horde" then
					frame.Info: SetAlpha(1)
					frame.Info.Indicator: SetTexture(F.Path("Icon_PVP_Horde"))
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.R1))
					frame.Info.Indicator: SetAlpha(1)
				elseif isDenied then
					frame.Info: SetAlpha(1)
					frame.Info.Indicator: SetTexture(F.Path("Icon_TapDenied"))
					frame.Info.Indicator: SetVertexColor(F.Color(C.Color.Denied))
					frame.Info.Indicator: SetAlpha(1)
				else
					frame.Info: SetAlpha(0)
					frame.Info.Indicator: SetAlpha(0)
					frame.Info.ClassIcon: SetAlpha(0)
				end
			end
		else
			LoopBar1_Update(frame, 0)
			LoopBar3_Update(frame, 0)
			LoopBar4_Update(frame, 0)
			Num48_Update(frame, 0)
		end
	end
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		F.Smooth_Health(frame.Unit)
	end
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		F.Smooth_Power(frame.Unit)
		if frame.ShowMana then
			F.Smooth_Mana(frame.Unit)
		end
	end
	if event == "UNIT_ABSORB_AMOUNT_CHANGED" or event == "UNIT_MAXHEALTH" then
		F.Smooth_Absorb(frame.Unit)
	end
	if event == "PLAYER_TARGET_CHANGED" then
		E.Value[frame.Unit].Health.Cur = 0
		E.Value[frame.Unit].Power.Cur = 0
		E.Value[frame.Unit].Mana.Cur = 0
		E.Value[frame.Unit].Absorb.Cur = 0
	end
end

local function HUD_Target_Update(frame, elapsed)
	if UnitExists(frame.Unit) then
		F.Smooth_Update(E.Value[frame.Unit].Health)
		F.Smooth_Update(E.Value[frame.Unit].Power)
		F.Smooth_Update(E.Value[frame.Unit].Mana)
		F.Smooth_Update(E.Value[frame.Unit].Absorb)

		if F.Last25 == 0 then
			LoopBar1_Update(frame, E.Value[frame.Unit].Health.Cur)
			LoopBar3_Update(frame, E.Value[frame.Unit].Power.Cur)
			LoopBar4_Update(frame, E.Value[frame.Unit].Absorb.Cur)
		end

		if F.Last10 == 0 then
			Num48_Update(frame, E.Value[frame.Unit].Health.Cur)
		end
	end
end

local THREAT_COLOR = {
	[1] = C.Color.Main1,
	[2] = C.Color.Main2,
	[3] = C.Color.Warn1,
	[4] = C.Color.Warn1,
}

local THREAT_COLOR_TANK = {
	[1] = C.Color.Warn1,
	[2] = C.Color.Warn1,
	[3] = C.Color.Main2,
	[4] = C.Color.Main1,
}

local function Threat_IsTank(unit)
	local role
	if F.IsClassic then
	else
		role = GetSpecializationRoleByID(GetInspectSpecialization(unit))
	end
	if role and role == "TANK" then
		return true
	else
		return false
	end
end

local function Threat_Update(frame)
	if UnitAffectingCombat("player") and UnitExists("target") and not UnitIsDeadOrGhost("target") then
		if UnitCanAttack("player", "target") and not (UnitIsDead("target") or UnitIsFriend("player", "target") or UnitPlayerControlled("target")) then
			--isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
			local status, threatpct = select(2, UnitDetailedThreatSituation("player", "target"))
			if status and threatpct then
				threatpct = threatpct/100
				frame.Bar5: SetAlpha(1)
				--if frame.IsTank then
				--	frame.Bar5.Ring1A: SetVertexColor(F.Color(THREAT_COLOR_TANK[status+1]))
				--else
					frame.Bar5.Ring1A: SetVertexColor(F.Color(THREAT_COLOR[status+1]))
				--end
				LoopBar5_Update(frame, threatpct)
			else
				frame.Bar5: SetAlpha(0)
			end
		else
			frame.Bar5: SetAlpha(0)
		end
	else
		frame.Bar5: SetAlpha(0)
	end
end

local function Threat_RegisterCallback(frame)
	LibThreatClassic.RegisterCallback(frame, "ThreatUpdated", function()
		Threat_Update(frame)
	end)
end

local function Threat_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_SPECIALIZATION_CHANGED" then
		--frame.IsTank = Threat_IsTank("player")
		Threat_Update(frame)
	elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_TARGET_CHANGED" or event == "UNIT_THREAT_LIST_UPDATE" or event == "UNIT_THREAT_SITUATION_UPDATE" then
		Threat_Update(frame)
	end
end

local function HUD_Right_Update(frame)
	--frame.Right: RegisterEvent("PLAYER_LOGIN")
	frame.Right: RegisterEvent("PLAYER_ENTERING_WORLD")
	if not F.IsClassic then
		frame.Right: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
		frame.Right: RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", "target")
		frame.Right: RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE", "target")
		frame.Right: RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", "target")
	end
	frame.Right: RegisterEvent("PLAYER_TARGET_CHANGED")
	frame.Right: RegisterUnitEvent("UNIT_FACTION", "target")
	frame.Right: RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "target")
	frame.Right: RegisterUnitEvent("UNIT_MAXHEALTH", "target")
	frame.Right: RegisterUnitEvent("UNIT_POWER_FREQUENT", "target")
	frame.Right: RegisterUnitEvent("UNIT_MAXPOWER", "target")
	frame.Right: RegisterEvent("PLAYER_REGEN_DISABLED")
	frame.Right: RegisterEvent("PLAYER_REGEN_ENABLED")
	frame.Right: SetScript("OnEvent", function(self, event, ...)
		HUD_Target_Event(self, event, ...)
		Threat_Event(self, event, ...)
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

local MEKA_LOOPHUD = CreateFrame("Frame", nil, E)
MEKA_LOOPHUD: SetSize(12,12)
MEKA_LOOPHUD: SetPoint("CENTER", UIParent, "CENTER", 0,0)
MEKA_LOOPHUD.Init = false
MEKA_LOOPHUD.State = "Hide"
--MEKA_LOOPHUD: Hide()
MEKA_LOOPHUD: SetAlpha(0)

local function MEKA_LOOPHUD_Load()
	--if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.Enable then
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State == "LOOP" then
		LeftFrame_Create(MEKA_LOOPHUD)
		RightFrame_Create(MEKA_LOOPHUD)
		TargetArrow_Create(MEKA_LOOPHUD)

		HUD_Left_Update(MEKA_LOOPHUD)
		HUD_Right_Update(MEKA_LOOPHUD)

		HUD_OnEvent(MEKA_LOOPHUD)
		HUD_OnUpdate(MEKA_LOOPHUD)

		--if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.PowerNum then
		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.LoopPowerNum then
			Border2_PowerNum_Toggle(MEKA_LOOPHUD.Left, "ON")
		else
			Border2_PowerNum_Toggle(MEKA_LOOPHUD.Left, "OFF")
		end

		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale then
			MEKA_LOOPHUD: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale)
		end

		MEKA_LOOPHUD.Init = true
	end
end

local function MEKA_LOOPHUD_Toggle(arg)
	if arg == "ON" then
		if not MEKA_LOOPHUD.Init then
			MEKA_LOOPHUD_Load()
		end
		HUD_OnEvent(MEKA_LOOPHUD)
		HUD_OnUpdate(MEKA_LOOPHUD)
	elseif arg == "OFF" then
		MEKA_LOOPHUD: UnregisterAllEvents()
		MEKA_LOOPHUD: SetScript("OnUpdate", nil)
		--MEKA_LOOPHUD: Hide()
		MEKA_LOOPHUD: SetAlpha(0)
		Border2_PowerNum_Toggle(MEKA_LOOPHUD.Left, "OFF")
	elseif arg == "PowerNum_ON" then
		Border2_PowerNum_Toggle(MEKA_LOOPHUD.Left, "ON")
	elseif arg == "PowerNum_OFF" then
		Border2_PowerNum_Toggle(MEKA_LOOPHUD.Left, "OFF")
	elseif type(arg) == "number" then
		MEKA_LOOPHUD: SetScale(arg)
	end
end

local MEKA_LOOPHUD_Config = {
	Database = {
		["MEKA_LOOPHUD"] = {
			Enable = true,
			PowerNum = true,
		},
	},

	Config = {
		Name = "MEKA ".."LoopHUD",
		Type = "Switch", --Switch, Trigger, Blank, Dropdown
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_LOOPHUD_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.Enable = true
				self.Text:SetText(L["ON"])
				MEKA_LOOPHUD_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['POWER_NUM'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.PowerNum then
						Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.PowerNum = false
						self.Text:SetText(L["OFF"])
						MEKA_LOOPHUD_Toggle("PowerNum_OFF")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.PowerNum = true
						self.Text:SetText(L["ON"])
						MEKA_LOOPHUD_Toggle("PowerNum_ON")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_LOOPHUD.PowerNum then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}

MEKA_LOOPHUD.Load = MEKA_LOOPHUD_Load
--MEKA_LOOPHUD.Config = MEKA_LOOPHUD_Config
F.MEKA_LOOPHUD_Toggle = MEKA_LOOPHUD_Toggle
tinsert(E.Module, MEKA_LOOPHUD)