local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

local _G = getfenv(0)
local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local asin = math.asin
local cos = math.cos
local acos = math.acos
local tan = math.tan
local atan = math.atan
local rad = math.rad
local modf = math.modf
local GetTime = _G.GetTime

----------------------------------------------------------------
-- Numbers
----------------------------------------------------------------

local Num_Left24 = {
	[0] = {  0/256, 12/256, 6/32,26/32},
	[1] = { 12/256, 24/256, 6/32,26/32},
	[2] = { 24/256, 36/256, 6/32,26/32},
	[3] = { 36/256, 48/256, 6/32,26/32},
	[4] = { 48/256, 60/256, 6/32,26/32},
	[5] = { 60/256, 72/256, 6/32,26/32},
	[6] = { 72/256, 84/256, 6/32,26/32},
	[7] = { 84/256, 96/256, 6/32,26/32},
	[8] = { 96/256,108/256, 6/32,26/32},
	[9] = {108/256,120/256, 6/32,26/32},
	["K"] = {120/256,132/256, 6/32,26/32},
	["M"] = {132/256,144/256, 6/32,26/32},
	["G"] = {144/256,156/256, 6/32,26/32},
	["T"] = {156/256,168/256, 6/32,26/32},
	["W"] = {168/256,180/256, 6/32,26/32},
	["Y"] = {180/256,192/256, 6/32,26/32},
	["."] = {192/256,204/256, 6/32,26/32},
	["N"] = {255/256,256/256, 6/32,26/32},
}

local Num_Left16 = {
	[0] = {  0/256, 10/256, 1/16,15/16},
	[1] = { 10/256, 20/256, 1/16,15/16},
	[2] = { 20/256, 30/256, 1/16,15/16},
	[3] = { 30/256, 40/256, 1/16,15/16},
	[4] = { 40/256, 50/256, 1/16,15/16},
	[5] = { 50/256, 60/256, 1/16,15/16},
	[6] = { 60/256, 70/256, 1/16,15/16},
	[7] = { 70/256, 80/256, 1/16,15/16},
	[8] = { 80/256, 90/256, 1/16,15/16},
	[9] = { 90/256,100/256, 1/16,15/16},
	["K"] = {100/256,110/256, 1/16,15/16},
	["M"] = {110/256,120/256, 1/16,15/16},
	["G"] = {120/256,130/256, 1/16,15/16},
	["T"] = {130/256,140/256, 1/16,15/16},
	["W"] = {140/256,150/256, 1/16,15/16},
	["Y"] = {150/256,160/256, 1/16,15/16},
	["."] = {160/256,170/256, 1/16,15/16},
	["N"] = {255/256,256/256, 1/16,15/16},
}

local function InfoNum_Template(frame, pos)
	local InfoNum = CreateFrame("Frame", nil, frame)
	local Num = {}
	for i = 1,4 do
		Num[i] = InfoNum: CreateTexture(nil, "ARTWORK")
		Num[i]: SetTexture(MEKA.Path("Number_Left24"))
		Num[i]: SetSize(12,20)
		Num[i]: SetTexCoord(Num_Left24[0][1],Num_Left24[0][2], Num_Left24[0][3],Num_Left24[0][4])
		Num[i]: SetVertexColor(F.Color(C.Color.Main1))
		Num[i]: SetAlpha(0.9)
		if i == 1 then
			Num[i]: SetPoint("BOTTOMRIGHT", pos, "CENTER", 19,-3)
		else
			Num[i]: SetPoint("BOTTOMRIGHT", Num[i-1], "BOTTOMLEFT", 2.5,-1.3)
		end

		Num[i].Bg = InfoNum: CreateTexture(nil, "BORDER")
		Num[i].Bg: SetTexture(MEKA.Path("Number_Left24"))
		Num[i].Bg: SetSize(12,20)
		Num[i].Bg: SetTexCoord(Num_Left24[0][1],Num_Left24[0][2], Num_Left24[0][3],Num_Left24[0][4])
		Num[i].Bg: SetVertexColor(F.Color(C.Color.Main1))
		Num[i].Bg: SetAlpha(0.3)
		Num[i].Bg: SetPoint("CENTER", Num[i], "CENTER", 0,0)
	end
	for i = 5,8 do
		Num[i] = InfoNum: CreateTexture(nil, "ARTWORK")
		Num[i]: SetTexture(MEKA.Path("Number_Left16"))
		Num[i]: SetSize(10,14)
		Num[i]: SetTexCoord(Num_Left16[0][1],Num_Left16[0][2], Num_Left16[0][3],Num_Left16[0][4])
		Num[i]: SetVertexColor(F.Color(C.Color.Main1))
		Num[i]: SetAlpha(0.6)
		if i == 5 then
			Num[i]: SetPoint("TOPRIGHT", pos, "CENTER", 18,-3)
		else
			Num[i]: SetPoint("BOTTOMRIGHT", Num[i-1], "BOTTOMLEFT", 3,-1.1)
		end

		Num[i].Bg = InfoNum: CreateTexture(nil, "BORDER")
		Num[i].Bg: SetTexture(MEKA.Path("Number_Left16"))
		Num[i].Bg: SetSize(10,14)
		Num[i].Bg: SetTexCoord(Num_Left16[0][1],Num_Left16[0][2], Num_Left16[0][3],Num_Left16[0][4])
		Num[i].Bg: SetVertexColor(F.Color(C.Color.Main1))
		Num[i].Bg: SetAlpha(0.3)
		Num[i].Bg: SetPoint("CENTER", Num[i], "CENTER", 0,0)
	end

	frame.InfoNum = InfoNum
	frame.Num = Num
end

local function InfoDurability_Template(frame, pos)
	local InfoDurability = CreateFrame("Frame", nil, frame)
	--INVSLOT_AMMO = 0
	--INVSLOT_HEAD = 1
	--INVSLOT_NECK = 2
	--INVSLOT_SHOULDER = 3
	--INVSLOT_BODY = 4 (shirt)
	--INVSLOT_CHEST = 5
	--INVSLOT_WAIST = 6 --腰
	--INVSLOT_LEGS = 7
	--INVSLOT_FEET = 8
	--INVSLOT_WRIST = 9 --腕
	--INVSLOT_HAND = 10
	--INVSLOT_FINGER1 = 11
	--INVSLOT_FINGER2 = 12
	--INVSLOT_TRINKET1 = 13
	--INVSLOT_TRINKET2 = 14
	--INVSLOT_BACK = 15
	--INVSLOT_MAINHAND = 16
	--INVSLOT_OFFHAND = 17
	--INVSLOT_RANGED = 18
	--INVSLOT_TABARD = 19 --战袍

	--current, maximum = GetInventoryItemDurability(slot)
end

local function Health_Artwork(frame)
	local Front = CreateFrame("Frame", nil, frame)
	Front: SetFrameLevel(frame:GetFrameLevel()+1)

	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(MEKA.Path("Left2_Backdrop"))
	Bg: SetSize(138,126)
	Bg: SetTexCoord(59/256,197/256, 65/256,191/256)
	Bg: SetVertexColor(F.Color(C.Color.Main0))
	Bg: SetAlpha(0.75)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd = frame: CreateTexture(nil, "ARTWORK")
	Bd: SetTexture(MEKA.Path("Left2_Border"))
	Bd: SetSize(138,126)
	Bd: SetTexCoord(59/256,197/256, 65/256,191/256)
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.95)
	Bd: SetPoint("CENTER", Bg, "CENTER", 0,0)

	local BarBg = frame: CreateTexture(nil, "BORDER")
	BarBg: SetTexture(MEKA.Path("Left_Bar1Bg"))
	BarBg: SetSize(80,78)
	BarBg: SetTexCoord(24/128,104/128, 25/128,103/128)
	BarBg: SetVertexColor(F.Color(C.Color.Main1))
	BarBg: SetAlpha(0.25)
	BarBg: SetPoint("CENTER", frame, "CENTER", 6,0)

	local Bar = frame: CreateTexture(nil, "BORDER")
	Bar: SetTexture(MEKA.Path("Left_Bar1"))
	Bar: SetSize(80,78)
	Bar: SetTexCoord(0/8192,80/8192, 0/256,80/256)
	Bar: SetVertexColor(F.Color(C.Color.Main1))
	Bar: SetAlpha(0.5)
	Bar: SetPoint("CENTER", BarBg, "CENTER", 0,0)

	local BarEx = Front: CreateTexture(nil, "OVERLAY")
	BarEx: SetTexture(MEKA.Path("Left_Bar1"))
	BarEx: SetSize(80,78)
	BarEx: SetTexCoord(0/8192,80/8192, 80/256,160/256)
	BarEx: SetVertexColor(F.Color(C.Color.Main1))
	BarEx: SetAlpha(1)
	BarEx: SetPoint("CENTER", BarBg, "CENTER", 0,0)

	local BarEnd = Front: CreateTexture(nil, "ARTWORK")
	BarEnd: SetTexture(MEKA.Path("Left_Bar1End"))
	BarEnd: SetSize(80,78)
	BarEnd: SetTexCoord(24/128,104/128, 25/128,103/128)
	BarEnd: SetVertexColor(F.Color(C.Color.Main1))
	BarEnd: SetAlpha(1)
	BarEnd: SetPoint("CENTER", BarBg, "CENTER", 0,0)

	InfoNum_Template(frame, BarBg)

	frame.Bar = Bar
	frame.BarBg = BarBg
	frame.BarEx = BarEx
	frame.BarEnd = BarEnd
	frame.Bd = Bd
end

local function Power_Artwork(frame)
	local Front = CreateFrame("Frame", nil, frame)
	Front: SetFrameLevel(frame:GetFrameLevel()+1)

	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(MEKA.Path("Left1_Backdrop"))
	Bg: SetSize(138,132)
	Bg: SetTexCoord(59/256,197/256, 62/256,194/256)
	Bg: SetVertexColor(F.Color(C.Color.Main0))
	Bg: SetAlpha(0.75)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd = frame: CreateTexture(nil, "ARTWORK")
	Bd: SetTexture(MEKA.Path("Left1_Border"))
	Bd: SetSize(138,132)
	Bd: SetTexCoord(59/256,197/256, 62/256,194/256)
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.95)
	Bd: SetPoint("CENTER", Bg, "CENTER", 0,0)

	local BarBg = frame: CreateTexture(nil, "BORDER")
	BarBg: SetTexture(MEKA.Path("Left_Bar1Bg"))
	BarBg: SetSize(80,78)
	BarBg: SetTexCoord(24/128,104/128, 25/128,103/128)
	BarBg: SetVertexColor(F.Color(C.Color.Main1))
	BarBg: SetAlpha(0.25)
	BarBg: SetPoint("CENTER", frame, "CENTER", 6,3)

	local Bar = Front: CreateTexture(nil, "BORDER")
	Bar: SetTexture(MEKA.Path("Left_Bar1"))
	Bar: SetSize(80,78)
	Bar: SetTexCoord(0/8192,80/8192, 0/256,80/256)
	Bar: SetVertexColor(F.Color(C.Color.Main1))
	Bar: SetAlpha(0.5)
	Bar: SetPoint("CENTER", BarBg, "CENTER", 0,0)

	local BarEx = Front: CreateTexture(nil, "OVERLAY")
	BarEx: SetTexture(MEKA.Path("Left_Bar1"))
	BarEx: SetSize(80,78)
	BarEx: SetTexCoord(0/8192,80/8192, 80/256,160/256)
	BarEx: SetVertexColor(F.Color(C.Color.Main1))
	BarEx: SetAlpha(1)
	BarEx: SetPoint("CENTER", BarBg, "CENTER", 0,0)

	local BarEnd = Front: CreateTexture(nil, "ARTWORK")
	BarEnd: SetTexture(MEKA.Path("Left_Bar1End"))
	BarEnd: SetSize(80,78)
	BarEnd: SetTexCoord(24/128,104/128, 25/128,103/128)
	BarEnd: SetVertexColor(F.Color(C.Color.Main1))
	BarEnd: SetAlpha(1)
	BarEnd: SetPoint("CENTER", BarBg, "CENTER", 0,0)

	InfoNum_Template(frame, BarBg)

	frame.Bar = Bar
	frame.BarBg = BarBg
	frame.BarEx = BarEx
	frame.BarEnd = BarEnd
	frame.Bd = Bd
end

local function Mana_Artwork(frame)
	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(MEKA.Path("Left3_Backdrop"))
	Bg: SetSize(86,94)
	Bg: SetTexCoord(21/128,107/128, 17/128,111/128)
	Bg: SetVertexColor(F.Color(C.Color.Main0))
	Bg: SetAlpha(0.75)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd = frame: CreateTexture(nil, "ARTWORK")
	Bd: SetTexture(MEKA.Path("Left3_Border"))
	Bd: SetSize(86,94)
	Bd: SetTexCoord(21/128,107/128, 17/128,111/128)
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.95)
	Bd: SetPoint("CENTER", Bg, "CENTER", 0,0)

	local Info = CreateFrame("Frame", nil, frame)

	local BarBg = Info: CreateTexture(nil, "BORDER")
	BarBg: SetTexture(MEKA.Path("Left_Bar2"))
	BarBg: SetSize(50,50)
	BarBg: SetTexCoord(0/4096,50/4096, 0/64,50/64)
	BarBg: SetVertexColor(F.Color(C.Color.Main1))
	BarBg: SetAlpha(0.25)
	BarBg: SetPoint("CENTER", frame, "CENTER", 0,5)

	local Bar = Info: CreateTexture(nil, "BORDER")
	Bar: SetTexture(MEKA.Path("Left_Bar2"))
	Bar: SetSize(50, 50)
	Bar: SetTexCoord(2300/4096,2350/4096, 0/64,50/64)
	Bar: SetVertexColor(F.Color(C.Color.Main1))
	Bar: SetAlpha(0.5)
	Bar: SetPoint("CENTER", BarBg, "CENTER", 0,0)

	local Num = {}
	for i = 1,3 do
		Num[i] = Info: CreateTexture(nil, "ARTWORK")
		Num[i]: SetTexture(MEKA.Path("Number_Left24"))
		Num[i]: SetSize(12,20)
		Num[i]: SetTexCoord(Num_Left24[0][1],Num_Left24[0][2], Num_Left24[0][3],Num_Left24[0][4])
		Num[i]: SetVertexColor(F.Color(C.Color.Main1))
		Num[i]: SetAlpha(0.9)
		if i == 1 then
			Num[i]: SetPoint("RIGHT", BarBg, "CENTER", 4,-1)
		else
			Num[i]: SetPoint("BOTTOMRIGHT", Num[i-1], "BOTTOMLEFT", 2.5,-1.3)
		end

		Num[i].Bg = Info: CreateTexture(nil, "BORDER")
		Num[i].Bg: SetTexture(MEKA.Path("Number_Left24"))
		Num[i].Bg: SetSize(12,20)
		Num[i].Bg: SetTexCoord(Num_Left24[0][1],Num_Left24[0][2], Num_Left24[0][3],Num_Left24[0][4])
		Num[i].Bg: SetVertexColor(F.Color(C.Color.Main1))
		Num[i].Bg: SetAlpha(0.3)
		Num[i].Bg: SetPoint("CENTER", Num[i], "CENTER", 0,0)
	end

	local PlaceHold = CreateFrame("Frame", nil, frame)
	PlaceHold: SetSize(50,50)
	PlaceHold: SetPoint("CENTER", frame, "CENTER", 0,5)
	PlaceHold.Index = 0

	local PhIcon = PlaceHold: CreateTexture(nil, "BORDER")
	PhIcon: SetTexture(MEKA.Path("Left3_Border_Blank_Icon"))
	PhIcon: SetSize(86,94)
	PhIcon: SetTexCoord(21/128,107/128, 17/128,111/128)
	PhIcon: SetVertexColor(F.Color(C.Color.Main1))
	PhIcon: SetAlpha(0.25)
	PhIcon: SetPoint("CENTER", Bg, "CENTER", 0,0)

	local PhBg = PlaceHold: CreateTexture(nil, "BORDER")
	PhBg: SetTexture(MEKA.Path("Left3_Border_Blank_Bg"))
	PhBg: SetSize(86,94)
	PhBg: SetTexCoord(21/128,107/128, 17/128,111/128)
	PhBg: SetVertexColor(F.Color(C.Color.Main1))
	PhBg: SetAlpha(0.15)
	PhBg: SetPoint("CENTER", Bg, "CENTER", 0,0)

	local PhBar = PlaceHold: CreateTexture(nil, "ARTWORK")
	PhBar: SetTexture(MEKA.Path("Left_Bar3"))
	PhBar: SetSize(54, 54)
	PhBar: SetTexCoord(0/2048,54/2048, 5/64,59/64)
	PhBar: SetVertexColor(F.Color(C.Color.Main1))
	PhBar: SetAlpha(0.25)
	PhBar: SetPoint("CENTER", PlaceHold, "CENTER", 0,0)

	PlaceHold: SetScript("OnUpdate", function(self)
		if PlaceHold.Index > 28 then
			PlaceHold.Index = 0
		end
		if F.Last25H == 0 then
			PhBar: SetTexCoord(54*PlaceHold.Index/2048,54*(PlaceHold.Index+1)/2048, 5/64,59/64)
			PlaceHold.Index = PlaceHold.Index + 1
		end
	end)

	frame.Info = Info
	frame.PH = PlaceHold
	frame.Bar = Bar
	frame.BarBg = BarBg
	frame.Bd = Bd
	frame.Num = Num
	frame.PhIcon = PhIcon
	frame.PhBar = PhBar
	frame.PhBg = PhBg
end

local function Happiness_OnEnter(frame, mana)
	frame: HookScript("OnEnter", function(self)
		if ( mana.tooltip ) then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(mana.tooltip);
			if ( mana.tooltipDamage ) then
				GameTooltip:AddLine(mana.tooltipDamage, "", 1, 1, 1);
			end
			if ( mana.tooltipLoyalty ) then
				GameTooltip:AddLine(mana.tooltipLoyalty, "", 1, 1, 1);
			end
		end
		GameTooltip:Show()
	end)
end

local function MEKA_InitUnit(frame)
	F.init_Unit(frame, frame.Unit, true)
	frame: SetScript("OnEnter", F.UnitFrame_OnEnter)
	frame: SetScript("OnLeave", F.UnitFrame_OnLeave)
end

local function MEKA_PlayerFrame_Create(frame)
	local Health = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	Health.Unit = "player"
	Health: SetSize(138,132)
	Health: SetPoint("CENTER", frame, "CENTER", 96,-34)
	Health_Artwork(Health)
	MEKA_InitUnit(Health)

	local Power = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	Power.Unit = "player"
	Power: SetSize(138,132)
	Power: SetPoint("CENTER", frame, "CENTER", 86,-162)
	Power_Artwork(Power)
	MEKA_InitUnit(Power)

	local Mana = CreateFrame("Frame", nil, frame)
	Mana: SetSize(86,94)
	Mana: SetPoint("CENTER", frame, "CENTER", 0,0)
	Mana_Artwork(Mana)

	local Pet = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	Pet.Unit = "pet"
	Pet: SetSize(86,94)
	Pet: SetPoint("CENTER", Mana, "CENTER", 0,0)
	MEKA_InitUnit(Pet)
	Happiness_OnEnter(Pet, Mana)

	local Bd = frame: CreateTexture(nil, "ARTWORK")
	Bd: SetTexture(MEKA.Path("Left_Border"))
	Bd: SetSize(62,224)
	Bd: SetTexCoord(1/64,63/64, 16/256,240/256)
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.95)
	Bd: SetPoint("CENTER", frame, "CENTER", -34,-94)

	frame.Health = Health
	frame.Power = Power
	frame.Mana = Mana
	frame.Border = Bd
end

----------------------------------------------------------------
--> Update
----------------------------------------------------------------

local function Update_Num(value)
	if not value then value = 0 end
	local d,d1,d2,d3,d4 = 0,0,0,0,0
	d = floor(value + 0.5)
	if d >= 1e9 then
		d = d/1e9
		d1 = "G"
	elseif d >= 1e6 then
		d = d/1e6
		d1 = "M"
	elseif d >= 1e4 then
		d = d/1e3
		d1 = "K"
	else
		d1 = "N"
	end

	if d1 == "N" then
		d4 = floor(d/1e3) or 0
		d3 = floor(d/100 - floor(d/1e3)*10) or 0
		d2 = floor(d/10 - floor(d/100)*10) or 0
		d1 = floor(d - floor(d/10)*10) or 0
	else
		d4 = floor(d/100 - floor(d/1e3)*10) or 0
		d3 = floor(d/10 - floor(d/100)*10) or 0
		if d4 == 0 and d3 == 0 then
			d4 = floor(d - floor(d/10)*10) or 0
			d3 = "."
			d2 = floor(d*10 - floor(d)*10) or 0
		else
			d2 = floor(d - floor(d/10)*10) or 0
		end
	end

	if d4 == 0 then
		d4 = "N"
		if d3 == 0 then
			d3 = "N"
			if d2 == 0 then
				d2 = "N"
			end
		end
	end

	return d1,d2,d3,d4
end

local function Update_InfoNum(frame, value)
	local d1,d2,d3,d4 = Update_Num(value)
	frame.Num[1]: SetTexCoord(Num_Left24[d1][1],Num_Left24[d1][2], Num_Left24[d1][3],Num_Left24[d1][4])
	frame.Num[2]: SetTexCoord(Num_Left24[d2][1],Num_Left24[d2][2], Num_Left24[d2][3],Num_Left24[d2][4])
	frame.Num[3]: SetTexCoord(Num_Left24[d3][1],Num_Left24[d3][2], Num_Left24[d3][3],Num_Left24[d3][4])
	frame.Num[4]: SetTexCoord(Num_Left24[d4][1],Num_Left24[d4][2], Num_Left24[d4][3],Num_Left24[d4][4])
end

local function Update_InfoMaxNum(frame, value)
	local d1,d2,d3,d4 = Update_Num(value)
	frame.Num[5]: SetTexCoord(Num_Left16[d1][1],Num_Left16[d1][2], Num_Left16[d1][3],Num_Left16[d1][4])
	frame.Num[6]: SetTexCoord(Num_Left16[d2][1],Num_Left16[d2][2], Num_Left16[d2][3],Num_Left16[d2][4])
	frame.Num[7]: SetTexCoord(Num_Left16[d3][1],Num_Left16[d3][2], Num_Left16[d3][3],Num_Left16[d3][4])
	frame.Num[8]: SetTexCoord(Num_Left16[d4][1],Num_Left16[d4][2], Num_Left16[d4][3],Num_Left16[d4][4])
end

local function Update_RingBar1(frame, value)
	if not value then value = 0 end
	value = floor(value*63+0.5)
	frame.Bar: SetTexCoord((5040-80*value)/8192,(5040+80-80*value)/8192, 0/256,80/256)
	frame.BarEx: SetTexCoord((5040-80*value)/8192,(5040+80-80*value)/8192, 80/256,160/256)
end

local function Update_RingBar2(frame, value)
	if not value then value = 0 end
	value = floor(value*46+0.5)
	frame.Bar: SetTexCoord((2300-50*value)/4096,(2300+50-50*value)/4096, 0/64,50/64)
end

local function Update_Health(frame, unit)
	if F.Last25 == 0 then
		Update_RingBar1(frame, E.Value[unit].Health.Cur)
	end

	if F.Last10 == 0 then
		Update_InfoNum(frame, E.Value[unit].Health.Cur * E.Value[unit].Health.Max)
		Update_InfoMaxNum(frame, E.Value[unit].Health.Max)
	end
end

local function Update_Power(frame, unit)
	if F.Last25H == 0 then
		Update_RingBar1(frame, E.Value[unit].Power.Cur)
	end

	if F.Last10H == 0 then
		Update_InfoNum(frame, E.Value[unit].Power.Cur * E.Value[unit].Power.Max)
		Update_InfoMaxNum(frame, E.Value[unit].Power.Max)
	end
end

local function Update_Mana(frame, parent)
	if F.Last25 == 0 then
		if parent.ShowPet then
			Update_RingBar2(frame, E.Value["pet"].Health.Cur)
		elseif parent.ShowMana then
			Update_RingBar2(frame, E.Value["player"].Mana.Cur)
		else
			Update_RingBar2(frame, 0)
		end
	end
	
	if F.Last10 == 0 then
		local d,d1,d2,d3 = 0,0,0,0
		if parent.ShowPet then
			d = E.Value.pet.Health.Cur
		elseif parent.ShowMana then
			d = E.Value.player.Mana.Cur
		else
			d = 0
		end
		d3 = floor(d)
		d2 = floor(d*10 - floor(d)*10) or 0
		d1 = floor(d*100 - floor(d*10)*10) or 0

		if d3 == 0 then
			d3 = "N"
		end

		frame.Num[1]: SetTexCoord(Num_Left24[d1][1],Num_Left24[d1][2], Num_Left24[d1][3],Num_Left24[d1][4])
		frame.Num[2]: SetTexCoord(Num_Left24[d2][1],Num_Left24[d2][2], Num_Left24[d2][3],Num_Left24[d2][4])
		frame.Num[3]: SetTexCoord(Num_Left24[d3][1],Num_Left24[d3][2], Num_Left24[d3][3],Num_Left24[d3][4])
	end
end

local function Player_Update(frame, elapsed)
	Update_Health(frame.Health, "player")
	Update_Power(frame.Power, "player")
	Update_Mana(frame.Mana, frame)
end

local function Update_PetColor(frame, color)
	frame.Bar: SetVertexColor(F.Color(color))
	frame.BarBg: SetVertexColor(F.Color(color))
	frame.Bd: SetVertexColor(F.Color(color))
	for i = 1,3 do
		frame.Num[i]: SetVertexColor(F.Color(color))
		frame.Num[i].Bg: SetVertexColor(F.Color(color))
	end
end

local function SetHappiness(frame)
	local happiness, damagePercentage, loyaltyRate = GetPetHappiness();
	--> 1 = unhappy, 2 = content, 3 = happy
	local hasPetUI, isHunterPet = HasPetUI();

	if ( not happiness or not isHunterPet ) then
		Update_PetColor(frame, C.Color.Main1)
		frame.tooltip = nil
		return;	
	end

	if ( happiness == 1 ) then
		Update_PetColor(frame, C.Color.Warn1)
	elseif ( happiness == 2 ) then
		Update_PetColor(frame, C.Color.Main2)
	elseif ( happiness == 3 ) then
		Update_PetColor(frame, C.Color.Main1)
	end

	frame.tooltip = _G["PET_HAPPINESS"..happiness];
	frame.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage);
	if ( loyaltyRate < 0 ) then
		frame.tooltipLoyalty = _G["LOSING_LOYALTY"];
	elseif ( loyaltyRate > 0 ) then
		frame.tooltipLoyalty = _G["GAINING_LOYALTY"];
	else
		frame.tooltipLoyalty = nil;
	end
end

local function SetManaBar(frame)
	frame.InVehicle = false
	frame.ShowPet = false
	frame.ShowMana = false

	if F.IsClassic then
		if UnitExists("pet") then
			frame.ShowPet = true
		end
	else
		if UnitHasVehiclePlayerFrameUI("player") then
			frame.InVehicle = true
			frame.ShowPet = true
		elseif UnitExists("pet") then
			frame.ShowPet = true
		end
	end

	if (not frame.ShowPet) then
		local powerType = UnitPowerType("player")
		if powerType ~= 0 then
			local maxmana = UnitPowerMax("player", 0)
			if maxmana ~= 0 then
				frame.ShowMana = true
			end
		end
		if frame.ShowMana then
			
		else
			
		end
	end
	if frame.ShowPet or frame.ShowMana then
		if frame.Mana.PH: IsShown() then
			frame.Mana.Info: Show()
			frame.Mana.PH: Hide()
		end
	else
		if frame.Mana.Info: IsShown() then
			frame.Mana.Info: Hide()
			frame.Mana.PH: Show()
		end
	end
end

local function Player_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		SetManaBar(frame)
		SetHappiness(frame.Mana)
	elseif event == "UNIT_PET" then
		SetManaBar(frame)
		SetHappiness(frame.Mana)
	elseif event == "PET_UI_UPDATE" then
		SetManaBar(frame)
		SetHappiness(frame.Mana)
	elseif event == "UNIT_ENTERED_VEHICLE" then 
		SetManaBar(frame)
	elseif event == "UNIT_EXITED_VEHICLE" then
		SetManaBar(frame)
	elseif event == "UNIT_DISPLAYPOWER" then
		SetManaBar(frame)
		SetHappiness(frame.Mana)
	elseif event == "UNIT_HAPPINESS" then
		SetHappiness(frame.Mana)
	end
end

local function Player_OnEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterUnitEvent("UNIT_PET", "player")
	frame: RegisterEvent("PET_UI_UPDATE")
	if F.IsClassic then
		frame: RegisterEvent("UNIT_HAPPINESS")
	else
		frame: RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
		frame: RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
		frame: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	end
	frame: RegisterEvent("UNIT_DISPLAYPOWER")
	frame: RegisterEvent("PLAYER_REGEN_DISABLED")
	frame: RegisterEvent("PLAYER_REGEN_ENABLED")
	frame: SetScript("OnEvent", function(self, event, ...)
		Player_Event(self, event, ...)
	end)
end

local function Player_OnUpdate(frame)
	frame: SetScript("OnUpdate", function(self, elapsed)
		Player_Update(self, elapsed)
	end)
end

----------------------------------------------------------------
--> Minimap
----------------------------------------------------------------

local hide_Stuff = function()
	local dummy = function() end
	local _G = getfenv(0)

	local frames_Retail = {
		--"MiniMapVoiceChatFrame",
		--"MiniMapWorldMapButton",
		"MinimapZoneTextButton",
		--"MiniMapTrackingButton",
		"MiniMapMailFrame",
		"MiniMapMailBorder",
		"MiniMapInstanceDifficulty",
		"MinimapNorthTag",
		"MinimapZoomOut",
		"MinimapZoomIn",
		"MinimapBackdrop",
		"GameTimeFrame",
		"GuildInstanceDifficulty",
		"MinimapBorderTop",
		--"MinimapBorder",
		"MinimapBackdrop",
	}

	local frames_Classic = {
		"MinimapZoneTextButton",
		"MiniMapMailFrame",
		"MiniMapMailBorder",
		"MinimapNorthTag",
		"MinimapZoomOut",
		"MinimapZoomIn",
		"MinimapBackdrop",
		"GameTimeFrame",
		"MinimapBorderTop",
		"MinimapBackdrop",
		"MinimapToggleButton",
	}

	local frames = F.IsClassic and frames_Classic or frames_Retail
	for i in pairs(frames) do
		local texture = _G[frames[i]]
		if texture then
			texture:Hide()
			texture.Show = dummy
		else
			print(frames[i])
		end
	end

	

	GameTimeFrame:SetAlpha(0)
	GameTimeFrame:EnableMouse(false)
	
	LoadAddOn("Blizzard_TimeManager")
	TimeManagerClockButton.Show = TimeManagerClockButton.Hide
	TimeManagerClockButton:Hide()
end

local Mouse_Wheel = function()
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript("OnMouseWheel", function(self, d)
		local Zoom,maxZoom = Minimap:GetZoom(),Minimap:GetZoomLevels()
		if d > 0 then
			Minimap:SetZoom((Zoom+1 >= maxZoom and maxZoom) or Zoom+1)
		elseif d < 0 then
			Minimap:SetZoom((Zoom-1 <= 0 and 0) or Zoom-1)
		end
	end)
end

--> Garrison Tab
local function GarrisonTabButton_Template(frame)
	local TabButton = CreateFrame("CheckButton", nil, frame)
	TabButton: SetSize(32,24)
	TabButton: SetNormalTexture("Interface\\ICONS\\WoW_Store")
	TabButton: SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
	TabButton: SetCheckedTexture("Interface\\Buttons\\CheckButtonHilight")

	local TabButtonBg = TabButton: CreateTexture(nil, "BACKGROUND")
	TabButtonBg: SetTexture("Interface\\SpellBook\\SpellBook-SkillLineTab")
	TabButtonBg: SetRotation(math.rad(-90))
	TabButtonBg: SetSize(48,64)
	TabButtonBg: SetPoint("TOPRIGHT", TabButton, "TOPRIGHT", 3,11)

	TabButton.Bg = TabButtonBg
	return TabButton
end

local GarrsionTabButtons = {
	[1] = {
		ID = LE_GARRISON_TYPE_6_0,
		Icon = "Interface\\ICONS\\Achievement_Level_100",
	},
	[2] = {
		ID = LE_GARRISON_TYPE_7_0,
		Icon = "Interface\\ICONS\\Achievement_Level_110",
	},
	[3] = {
		ID = LE_GARRISON_TYPE_8_0,
		Icon = "Interface\\ICONS\\INV_level120",
	},
}

local function GarrisonTabButton_Check(self, frame)
	local ButtonAble = true
	for i = 1, #self.TabButton do
		if GarrisonLandingPage then
			if self.TabButton[i]:GetID() == GarrisonLandingPage.garrTypeID then
				self.TabButton[i]:SetChecked(true)
			else
				self.TabButton[i]:SetChecked(false)
			end
			frame.GarrisonType = frame.GarrisonType or C_Garrison.GetLandingPageGarrisonType()
			if not frame.GarrisonType then
				ButtonAble = false
			end
			if frame.GarrisonType and frame.GarrisonType == self.TabButton[i]:GetID() then
				self.TabButton[i]: Enable()
				ButtonAble = false
			else
				if ButtonAble then
					self.TabButton[i]: Enable()
				else
					self.TabButton[i]: Disable()
				end
			end
		end
	end	
end

local function GarrisonTabButton_Create(frame)
	local QuafeGarrisonTab = CreateFrame("Frame", "QuafeGarrisonTab", UIParent)
	QuafeGarrisonTab: SetSize(32,32)
	QuafeGarrisonTab.ToLoad = true
	
	local TabButton = {}
	for k,v in ipairs(GarrsionTabButtons) do
		TabButton[k] = GarrisonTabButton_Template(QuafeGarrisonTab)
		TabButton[k]: SetNormalTexture(v.Icon)
		TabButton[k]: SetID(v.ID)
		TabButton[k]: SetScript("OnClick", function(self)
			HideUIPanel(GarrisonLandingPage)
			ShowGarrisonLandingPage(self:GetID())
		end)
		if k == 1 then
			TabButton[k]: SetPoint("TOPRIGHT", QuafeGarrisonTab, "TOPRIGHT", 0,0)
		else
			TabButton[k]: SetPoint("TOPRIGHT", TabButton[k-1], "TOPRIGHT", -56,0)
		end
	end

	QuafeGarrisonTab: SetScript("OnShow", function(self)
		GarrisonTabButton_Check(self, frame)
	end)

	frame.GarrisonTab = QuafeGarrisonTab
	frame.GarrisonTab.TabButton = TabButton
end

local function GarrisonTabButton_Refresh(frame)
	if GarrisonLandingPage and frame.GarrisonTab.ToLoad then
		frame.GarrisonTab.ToLoad = false
		frame.GarrisonTab: SetParent(GarrisonLandingPage)
		frame.GarrisonTab: SetPoint("TOPRIGHT", GarrisonLandingPage, "BOTTOMRIGHT", -82,12)
		GarrisonTabButton_Check(frame.GarrisonTab, frame)
	end		
end

--> Garrison Button
local function Garrison_UpdateIcon(frame)
	frame.GarrisonType = C_Garrison.GetLandingPageGarrisonType();
	if (frame.GarrisonType == LE_GARRISON_TYPE_6_0) then
		frame.title = GARRISON_LANDING_PAGE_TITLE;
		frame.description = MINIMAP_GARRISON_LANDING_PAGE_TOOLTIP;
	elseif (frame.GarrisonType == LE_GARRISON_TYPE_7_0) then
		frame.title = ORDER_HALL_LANDING_PAGE_TITLE;
		frame.description = MINIMAP_ORDER_HALL_LANDING_PAGE_TOOLTIP;
	elseif (frame.GarrisonType == LE_GARRISON_TYPE_8_0) then
		frame.title = GARRISON_TYPE_8_0_LANDING_PAGE_TITLE;
		frame.description = GARRISON_TYPE_8_0_LANDING_PAGE_TOOLTIP;
	end
end

local function Extra_Garrison(frame)
	local Garrison = CreateFrame("Button", nil, frame)
	Garrison: SetSize(20,20)
	Garrison: SetPoint("CENTER", frame, "CENTER", -13,14)

	local Bg = Garrison: CreateTexture(nil, "BORDER")
	Bg: SetTexture(MEKA.Path("MinimapInfoBg1"))
	Bg: SetSize(64,64)
	Bg: SetVertexColor(F.Color(C.Color.Main1))
	Bg: SetAlpha(0.25)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,5)

	local Icon = Garrison: CreateTexture(nil, "ARTOWRK")
	Icon: SetTexture(MEKA.Path("MinimapInfo_Garrison"))
	Icon: SetSize(32,32)
	Icon: SetVertexColor(F.Color(C.Color.Main1))
	Icon: SetAlpha(0.75)
	Icon: SetPoint("CENTER", Garrison, "CENTER", 0,0)

	local Notification = CreateFrame("Frame", nil, Garrison, "MEKA_GarrisonNotificationTemplate")
	Notification: SetFrameLevel(Garrison: GetFrameLevel())
	Notification: SetSize(20,20)
	Notification: SetPoint("CENTER", Garrison, "CENTER", 0,0)
	Notification: Hide()

	local NotificatioGlow = Notification: CreateTexture(nil, "BORDER")
	NotificatioGlow: SetTexture(MEKA.Path("MinimapInfoBg1"))
	NotificatioGlow: SetSize(64,64)
	NotificatioGlow: SetVertexColor(F.Color(C.Color.Main1))
	NotificatioGlow: SetAlpha(0.5)
	NotificatioGlow: SetPoint("CENTER", frame, "CENTER", 0,5)

	GarrisonTabButton_Create(Garrison)

	Garrison: SetScript("OnClick", function(self, button)
		GarrisonLandingPage_Toggle()
		GarrisonTabButton_Refresh(self)
	end)

	Garrison: SetScript("OnEnter", function(self)
		Icon: SetAlpha(1)
		if self.title and self.description then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			GameTooltip:SetText(self.title, 1, 1, 1);
			GameTooltip:AddLine(self.description, nil, nil, nil, true);
			GameTooltip:Show();
		end
	end)
	Garrison: SetScript("OnLeave", function(self)
		Icon: SetAlpha(0.75)
		GameTooltip:Hide();
	end)

	Garrison: RegisterEvent("GARRISON_SHOW_LANDING_PAGE")
	Garrison: RegisterEvent("GARRISON_HIDE_LANDING_PAGE")
	Garrison: RegisterEvent("GARRISON_BUILDING_ACTIVATABLE")
	Garrison: RegisterEvent("GARRISON_BUILDING_ACTIVATED")
	Garrison: RegisterEvent("GARRISON_TALENT_COMPLETE")
	Garrison: RegisterEvent("GARRISON_ARCHITECT_OPENED")
	Garrison: RegisterEvent("GARRISON_MISSION_FINISHED")
	Garrison: RegisterEvent("GARRISON_MISSION_NPC_OPENED")
	Garrison: RegisterEvent("GARRISON_SHIPYARD_NPC_OPENED")
	Garrison: RegisterEvent("GARRISON_INVASION_AVAILABLE")
	Garrison: RegisterEvent("GARRISON_INVASION_UNAVAILABLE")
	Garrison: RegisterEvent("SHIPMENT_UPDATE")
	--Garrison: RegisterEvent("ZONE_CHANGED_NEW_AREA");
	--Garrison: RegisterEvent("ZONE_CHANGED");
	--Garrison: RegisterEvent("ZONE_CHANGED_INDOORS");
	Garrison: SetScript("OnEvent", function(self, event, ...)
		if (event == "GARRISON_HIDE_LANDING_PAGE") then
			--Notification: Show()
			--Garrison_UpdateIcon(self)
		elseif (event == "GARRISON_SHOW_LANDING_PAGE") then
			Garrison_UpdateIcon(self)
			--Notification: Hide()
		elseif ( event == "GARRISON_BUILDING_ACTIVATABLE" ) then
			Notification: Show()
		elseif ( event == "GARRISON_BUILDING_ACTIVATED" or event == "GARRISON_ARCHITECT_OPENED") then
			Notification: Hide()
		elseif ( event == "GARRISON_TALENT_COMPLETE") then
			Notification: Show()
		elseif ( event == "GARRISON_MISSION_FINISHED" ) then
			Notification: Show()
		elseif ( event == "GARRISON_MISSION_NPC_OPENED" ) then
			Notification: Hide()
		elseif ( event == "GARRISON_SHIPYARD_NPC_OPENED" ) then
			Notification: Hide()
		elseif (event == "GARRISON_INVASION_AVAILABLE") then
			Notification: Show()
		elseif (event == "GARRISON_INVASION_UNAVAILABLE") then
			Notification: Hide()
		elseif (event == "SHIPMENT_UPDATE") then
			local shipmentStarted, isTroop = ...
			if (shipmentStarted) then
				Notification: Show()
			end
		end
	end)

	hooksecurefunc("GarrisonMinimap_ClearPulse", function()
		Notification: Hide()
	end)

	frame.Garrison = Garrison
	frame.Garrison.Bg = Bg
	frame.Garrison.Notification = Notification
end

local function Extra_Mail(frame)
	local Mail = CreateFrame("Button", nil, frame)
	Mail: SetSize(20,20)
	Mail: SetPoint("CENTER", frame, "CENTER", 16,10)
	Mail.NewMail = false

	local Bg = frame: CreateTexture(nil, "BORDER")
	Bg: SetTexture(MEKA.Path("MinimapInfoBg2"))
	Bg: SetSize(64,64)
	Bg: SetVertexColor(F.Color(C.Color.Main1))
	Bg: SetAlpha(0.25)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,5)

	local Icon = Mail: CreateTexture(nil, "ARTOWRK")
	Icon: SetTexture(MEKA.Path("MinimapInfo_Mail"))
	Icon: SetSize(32,32)
	Icon: SetVertexColor(F.Color(C.Color.Main1))
	Icon: SetAlpha(0.75)
	Icon: SetPoint("CENTER", Mail, "CENTER", 0,0)

	local Notification = CreateFrame("Frame", nil, Mail, "MEKA_GarrisonNotificationTemplate")
	Notification: SetFrameLevel(Mail: GetFrameLevel())
	Notification: SetSize(20,20)
	Notification: SetPoint("CENTER", Mail, "CENTER", 0,0)
	Notification: Hide()

	local NotificatioGlow = Notification: CreateTexture(nil, "BORDER")
	NotificatioGlow: SetTexture(MEKA.Path("MinimapInfoBg2"))
	NotificatioGlow: SetSize(64,64)
	NotificatioGlow: SetVertexColor(F.Color(C.Color.Main1))
	NotificatioGlow: SetAlpha(0.5)
	NotificatioGlow: SetPoint("CENTER", frame, "CENTER", 0,5)

	Mail: RegisterEvent("UPDATE_PENDING_MAIL")
	Mail: RegisterEvent("PLAYER_ENTERING_WORLD")
	Mail: SetScript("OnEvent", function(self,event)
		if event == "PLAYER_ENTERING_WORLD" then
			self: UnregisterEvent("PLAYER_ENTERING_WORLD")
		end
		if ( HasNewMail() ) then
			Notification: Show()
			if( GameTooltip: IsOwned(self) ) then
				MinimapMailFrameUpdate()
			end
		else
			Notification: Hide()
		end
	end)
	
	Mail: SetScript("OnEnter", function(self)
		Icon: SetAlpha(1)
		GameTooltip: SetOwner(self, "ANCHOR_RIGHT")
		Notification: Hide()
		if( GameTooltip:IsOwned(self) ) then
			if ( HasNewMail() ) then
				MinimapMailFrameUpdate()
			else
				GameTooltip: SetText(L['NO_MAIL'])
			end
		end
	end)
	Mail: SetScript("OnLeave", function(self)
		Icon: SetAlpha(0.75)
		GameTooltip: Hide()
	end)

	frame.Mail = Mail
	frame.Mail.Bg = Bg
end

local function Extra_Queue(frame)
	local Queue = CreateFrame("Button", nil, frame)
	Queue: SetSize(20,20)
	Queue: SetPoint("CENTER", frame, "CENTER", -4,-11)

	local QueueHold = CreateFrame("Frame", nil, Queue)
	QueueHold: SetSize(20,20)
	QueueHold: SetPoint("CENTER", Queue, "CENTER", 0,0)

	local Bg = frame: CreateTexture(nil, "BORDER")
	Bg: SetTexture(MEKA.Path("MinimapInfoBg3"))
	Bg: SetSize(64,64)
	Bg: SetVertexColor(F.Color(C.Color.Main1))
	Bg: SetAlpha(0.25)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,5)

	local Icon = Queue: CreateTexture(nil, "ARTOWRK")
	Icon: SetTexture(MEKA.Path("MinimapInfo_LFD"))
	Icon: SetSize(32,32)
	Icon: SetVertexColor(F.Color(C.Color.Main1))
	Icon: SetAlpha(0.75)
	Icon: SetPoint("CENTER", Queue, "CENTER", 0,0)

	QueueStatusMinimapButton: SetParent(QueueHold)
	QueueStatusMinimapButton: ClearAllPoints()
	QueueStatusMinimapButton.ClearAllPoints = function() end
	QueueStatusMinimapButton: SetPoint("CENTER", QueueHold, "CENTER", 0, 0)
	QueueStatusMinimapButton: SetFrameStrata(QueueHold:GetFrameStrata())
	QueueStatusMinimapButton: SetFrameLevel(QueueHold:GetFrameLevel()+1)
	QueueStatusMinimapButton.SetPoint = function() end
	QueueStatusMinimapButtonBorder: Hide()
	
	QueueStatusMinimapButton: SetHighlightTexture("") 
	QueueStatusMinimapButtonIcon: SetSize(32,32)
	--QueueStatusMinimapButtonIconTexture: SetTexture(F.Path("Minimap_Icon_Queue"))
	--QueueStatusMinimapButtonIconTexture: SetVertexColor(F.Color(C.Color.W3))

	frame.Queue = Queue
	frame.Queue.Bg = Bg
end

----------------------------------------------------------------
--> MEKA_Minimap
----------------------------------------------------------------

local function Main_Artwork(frame)
	local Front = CreateFrame("Frame", nil, frame)
	Front: SetFrameLevel(frame:GetFrameLevel()+1)
	
	local Back = CreateFrame("Frame", nil, Minimap)
	Back: SetFrameLevel(frame:GetFrameLevel()-1)

	local Bg = Back: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(MEKA.Path("Right1_Backdrop"))
	Bg: SetSize(190,184)
	Bg: SetTexCoord(33/256,223/256, 36/256,220/256)
	Bg: SetVertexColor(0.01, 0.01, 0.01)
	Bg: SetAlpha(0.75)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd = Front: CreateTexture(nil, "OVERLAY")
	Bd: SetTexture(MEKA.Path("Right1_Border"))
	Bd: SetSize(190,184)
	Bd: SetTexCoord(33/256,223/256, 36/256,220/256)
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.95)
	Bd: SetPoint("CENTER", Bg, "CENTER", 0,0)

	Minimap: SetSize(138,138)
	Minimap: SetFrameLevel(frame:GetFrameLevel())
	Minimap: SetFrameStrata(frame:GetFrameStrata())
	Minimap: SetParent(frame)
	Minimap: ClearAllPoints()
	Minimap: SetPoint("CENTER", frame, "CENTER", -7,5)
	Minimap: SetScale(1)
	Minimap: SetAlpha(1)

	Minimap: SetMaskTexture(MEKA.Path("MinimapMask"))
	Minimap: SetPlayerTexture(MEKA.Path("MinimapArrow"))
	if not F.IsClassic then
		Minimap: SetArchBlobRingScalar(0.8)
		Minimap: SetQuestBlobRingScalar(0.8)
	end

	Minimap: SetScript("OnMouseUp", function(self, button)
		Minimap:StopMovingOrSizing()
		if F.IsClassic then
			if (button == "LeftButton") then
				Minimap_OnClick(self)
			elseif (button == "RightButton") then
				Minimap_OnClick(self)
			end
		else
			if (button == "LeftButton") then
				Minimap_OnClick(self)
			elseif (button == "RightButton") then
				ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, -(Minimap:GetWidth()*1.2),(Minimap:GetHeight()*2))
			elseif (button == "MiddleButton") then
				ToggleCalendar()
			end
		end
	end)

	hide_Stuff()
	Mouse_Wheel()

	frame.Bd = Bd
end

local function Extra_Artwork(frame)
	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(MEKA.Path("Left3_Backdrop"))
	Bg: SetSize(86,94)
	Bg: SetTexCoord(107/128,21/128, 17/128,111/128)
	Bg: SetVertexColor(0.01, 0.01, 0.01)
	Bg: SetAlpha(0.75)
	Bg: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd = frame: CreateTexture(nil, "ARTWORK")
	Bd: SetTexture(MEKA.Path("Left3_Border"))
	Bd: SetSize(86,94)
	Bd: SetTexCoord(107/128,21/128, 17/128,111/128)
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.95)
	Bd: SetPoint("CENTER", Bg, "CENTER", 0,0)

	frame.Bd = Bd
end

local function MEKA_MinimapFrame_Create(frame)
	local Main = CreateFrame("Frame", nil, frame)
	Main: SetSize(190,184)
	Main: SetPoint("CENTER", frame, "CENTER", -73,-111)

	Main_Artwork(Main)

	local Extra = CreateFrame("Frame", nil, frame)
	Extra: SetSize(86,94)
	Extra: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd = frame: CreateTexture(nil, "ARTWORK")
	Bd: SetTexture(MEKA.Path("Left_Border"))
	Bd: SetSize(62,224)
	Bd: SetTexCoord(63/64,1/64, 16/256,240/256)
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.95)
	Bd: SetPoint("CENTER", frame, "CENTER", 34,-94)

	Extra_Artwork(Extra)
	Extra_Mail(Extra)
	if not F.IsClassic then
		Extra_Garrison(Extra)
		Extra_Queue(Extra)
	end

	frame.Border = Bd
end

----------------------------------------------------------------
--> Warning
----------------------------------------------------------------

local function Health_Warning_Event(LeftFrame, RightFrame, event, ...)
	local Unit = "player"
	local MinHealth,MaxHealth = UnitHealth(Unit),UnitHealthMax(Unit)
	local Percent = MinHealth/(MaxHealth+F.Debug)
	if Percent <= 0.2 then
		Update_PlayeButtonrColor(LeftFrame.Health, C.Color.Warn1)
		Update_PlayeButtonrColor(LeftFrame.Power, C.Color.Warn1)
		Update_PlayeButtonrColor(LeftFrame.Mana, C.Color.Warn1)
	else
		Update_PlayeButtonrColor(LeftFrame.Health, C.Color.Main1)
		Update_PlayeButtonrColor(LeftFrame.Power, C.Color.Main1)
		Update_PlayeButtonrColor(LeftFrame.Mana, C.Color.Main1)
	end
end

local function MEKA_Warning_OnEvent(frame, LeftFrame, RightFrame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	--frame: RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "player", "vehicle")
	frame: RegisterUnitEvent("UNIT_HEALTH", "player", "vehicle")
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", "player", "vehicle")
	if not F.IsClassic then
		frame: RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
		frame: RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	end
	frame: HookScript("OnEvent", function(self, event, ...)
		Health_Warning_Event(LeftFrame, RightFrame, event, ...)
	end)
end

----------------------------------------------------------------
--> Load
----------------------------------------------------------------

local MEKA_PlayerFrame = CreateFrame("Frame", "MEKA_PlayerFrame", E)
MEKA_PlayerFrame: SetSize(86,94)
MEKA_PlayerFrame: SetFrameStrata("LOW")
MEKA_PlayerFrame.Init = false

local MEKA_MinimapFrame = CreateFrame("Frame", "MEKA_MinimapFrame", E)
MEKA_MinimapFrame: SetSize(86,94)
MEKA_MinimapFrame: SetFrameStrata("LOW")

local function Joystick_Update(self, elapsed)
	local x2 = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosX
	local y2 = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosY
	local x0,y0 = MEKA_PlayerFrame: GetCenter()
	local x1,y1 = self: GetCenter()
	local step = floor(1/(GetFramerate())*1e3)/1e3
	if x0 ~= x1 then
		x2 = x2 + (x1-x0)*step/2
	end
	if y0 ~= y1 then
		y2 = y2 + (y1-y0)*step/2
	end
	MEKA_PlayerFrame: SetPoint("CENTER", UIParent, "BOTTOMLEFT", x2,y2)
	MEKA_MinimapFrame: SetPoint("CENTER", UIParent, "BOTTOMRIGHT", -x2,y2)
	Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosX = x2
	Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosY = y2
end

local function MEKA_PlayerFrame_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Enable then
		MEKA_PlayerFrame: SetPoint("CENTER", UIParent, "BOTTOMLEFT", Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosX,Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosY)
		MEKA_MinimapFrame: SetPoint("CENTER", UIParent, "BOTTOMRIGHT", -Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosX,Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.PosY)
		F.CreateJoystick(MEKA_PlayerFrame, 86,94, "MEKA_PlayerFrame")
		MEKA_PlayerFrame.Joystick.postUpdate = Joystick_Update

		MEKA_PlayerFrame_Create(MEKA_PlayerFrame)
		Player_OnEvent(MEKA_PlayerFrame)
		Player_OnUpdate(MEKA_PlayerFrame)

		MEKA_MinimapFrame_Create(MEKA_MinimapFrame)

		--MEKA_Warning_OnEvent(MEKA_PlayerFrame, MEKA_PlayerFrame, MEKA_MinimapFrame)

		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Scale then
			MEKA_PlayerFrame: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Scale)
			MEKA_MinimapFrame: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Scale)
		end

		MEKA_PlayerFrame.Init = true
	end
end

local function MEKA_PlayerFrame_Toggle(arg)
	if arg == "ON" then
		if not MEKA_PlayerFrame.Init then
			MEKA_PlayerFrame_Load()
			if not MEKA_PlayerFrame:IsShown() then
				MEKA_PlayerFrame: Show()
				MEKA_MinimapFrame: Show()
			end
		end
	elseif arg == "OFF" then
		MEKA_PlayerFrame: Hide()
	elseif type(arg) == "number" then
		MEKA_PlayerFrame: SetScale(arg)
		MEKA_MinimapFrame: SetScale(arg)
	end
end

local MEKA_PlayerFrame_Config = {
	Database = {
		["MEKA_PlayerFrame"] = {
			["Enable"] = true,
			["PosX"] = 160,
			["PosY"] = 300,
			Scale = 1,
		},
	},

	Config = {
		Name = "MEKA "..L['PLAYER_FRAME'],
		Type = "Switch",
		Click = function(self, button)
			if InCombatLockdown() then return end
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_PlayerFrame_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Enable = true
				self.Text:SetText(L["ON"])
				MEKA_PlayerFrame_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
                Name = L['SCALE'],
                Type = "Slider",
                State = "ALL",
				Click = nil,
                Load = function(self)
                    self.Slider: SetMinMaxValues(0.5, 2)
					self.Slider: SetValueStep(0.05)
                    self.Slider: SetValue(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Scale)
					self.Slider: HookScript("OnValueChanged", function(s, value)
                        value = floor(value*100+0.5)/100
						MEKA_PlayerFrame_Toggle(value)
                        Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_PlayerFrame.Scale = value
					end)
                end,
                Show = nil,
            },
		},
	},
}

MEKA_PlayerFrame.Load = MEKA_PlayerFrame_Load
MEKA_PlayerFrame.Config = MEKA_PlayerFrame_Config
tinsert(E.Module, MEKA_PlayerFrame)