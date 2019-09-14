local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale
--if F.IsClassic then return end

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

local GetTime = GetTime

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

--local classFileName = select(2, UnitClass("player"))

-- exists = tContains(table, value)

local UNIT_LIST = {}
local WATCHER_FILTER = {}
local RADIUS = {
	R1 = 351,
	R2 = 414,
	R3 = 457,
}

----------------------------------------------------------------
--> Aura Wathcher
----------------------------------------------------------------

----------------------------------------------------------------
--> Bar
----------------------------------------------------------------

local function Bar_Template(frame)
    local Main = CreateFrame("Frame", nil, frame)
    Main: SetSize(12, 12)

	local Bar = F.Create.Texture(Main, "ARTWORK", 1, MEKA.Path("PitaBar\\Bar1_156"), C.Color.Main1, 1, {128,32})
	Bar: SetPoint("CENTER", Main, "CENTER", 0,0)

	local Bg = F.Create.Texture(Main, "BACKGROUND", 1, MEKA.Path("PitaBar\\Bar1_156"), C.Color.Main0, 0.5, {128,32})
	Bg: SetPoint("CENTER", Main, "CENTER", 0,0)

	local BgSd = F.Create.Texture(Main, "BACKGROUND", 1, MEKA.Path("PitaBar\\Bar1_156"), C.Color.Main0, 0.25, {128,32})
	BgSd: SetPoint("CENTER", Main, "CENTER", 0,0)

	local BgG = F.Create.Texture(Main, "BORDER", 1, MEKA.Path("PitaBar\\Bar1_156"), C.Color.Main0, 0.15, {128,32})
	BgG: SetPoint("CENTER", Main, "CENTER", 0,0)

    frame.Main = Main
	frame.Main.Bar = Bar
	frame.Main.Bg = Bg
	frame.Main.BgSd = BgSd
	frame.Main.BgG = BgG
end

local function BarNum_Template(frame)
	local Hold = CreateFrame("Frame", nil, frame)
	Hold: SetSize(12, 12)

	local Bg = F.Create.Texture(Hold, "BACKGROUND", 1, MEKA.Path("PitaBar\\Bar1_Bg1"), C.Color.Main0, 0.5, {64,32})
	Bg: SetPoint("CENTER", Hold, "CENTER", 0,0)

	local BgSd = F.Create.Texture(Hold, "BACKGROUND", 1, MEKA.Path("PitaBar\\Bar1_Bg1_Sd"), C.Color.Main0, 0.25, {64,32})
	BgSd: SetPoint("CENTER", Hold, "CENTER", 0,0)

	local BgG = F.Create.Texture(Hold, "BORDER", 1, MEKA.Path("PitaBar\\Bar1_Bg1"), C.Color.Main1, 0.15, {64,32})
	BgG: SetPoint("CENTER", Hold, "CENTER", 0,0)

	local Num = {}
	for i = 1,3 do
		Num[i] = F.Create.Texture(Hold, "OVERLAY", 1, F.Path("N12\\N".."9"), C.Color.Main1, 0.9, {32,32})
	end

	frame.NumHold = Hold
	frame.NumHold.Num = Num
	frame.NumHold.Bg = Bg
	frame.NumHold.BgSd = BgSd
	frame.NumHold.BgG = BgG
end

local function BarCount_Template(frame)
	local Hold = CreateFrame("Frame", nil, frame)
	Hold: SetSize(12, 12)

	local Bg = F.Create.Texture(Hold, "BACKGROUND", 1, MEKA.Path("PitaBar\\Bar1_Bg2"), C.Color.Main0, 0.5, {64,32})
	Bg: SetPoint("CENTER", Hold, "CENTER", 0,0)

	local BgSd = F.Create.Texture(Hold, "BACKGROUND", 1, MEKA.Path("PitaBar\\Bar1_Bg2_Sd"), C.Color.Main0, 0.25, {64,32})
	BgSd: SetPoint("CENTER", Hold, "CENTER", 0,0)

	local BgG = F.Create.Texture(Hold, "BORDER", 1, MEKA.Path("PitaBar\\Bar1_Bg2"), C.Color.Main1, 0.15, {64,32})
	BgG: SetPoint("CENTER", Hold, "CENTER", 0,0)

	local Num = {}
	for i = 1,3 do
		Num[i] = F.Create.Texture(Hold, "OVERLAY", 1, F.Path("N12\\N".."9"), C.Color.Main1, 0.9, {32,32})
	end

	frame.CountHold = Hold
	frame.CountHold.Num = Num
	frame.CountHold.Bg = Bg
	frame.CountHold.BgSd = BgSd
	frame.CountHold.BgG = BgG
end

local function Bar_Rotate(frame, direction)
	local r = rad(frame.Info.Angle)
	frame.Main: SetPoint("CENTER", frame, "CENTER", RADIUS.R1*cos(r), RADIUS.R1*sin(r))
	frame.NumHold: SetPoint("CENTER", frame, "CENTER", RADIUS.R2*cos(r), RADIUS.R2*sin(r))
	frame.CountHold: SetPoint("CENTER", frame, "CENTER", RADIUS.R3*cos(r), RADIUS.R3*sin(r))

	frame.Main.Bar: SetRotation(r)
	frame.Main.Bg: SetRotation(r)
	frame.Main.BgSd: SetRotation(r)
	frame.Main.BgG: SetRotation(r)

	frame.NumHold.Bg: SetRotation(r)
	frame.NumHold.BgSd: SetRotation(r)
	frame.NumHold.BgG: SetRotation(r)

	frame.CountHold.Bg: SetRotation(r)
	frame.CountHold.BgSd: SetRotation(r)
	frame.CountHold.BgG: SetRotation(r)

	for i = 1,3 do
		if direction == "Left" then
			frame.NumHold.Num[i]: SetRotation(rad(frame.Info.Angle-180))
			frame.NumHold.Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.R2-1+4*(2-i))*cos(r),  (RADIUS.R2-1+4*(2-i))*sin(r))
			frame.CountHold.Num[i]: SetRotation(rad(frame.Info.Angle-180))
			frame.CountHold.Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.R3-1+4*(2-i))*cos(r),  (RADIUS.R3-1+4*(2-i))*sin(r))
		elseif direction == "Right" then
			frame.NumHold.Num[i]: SetRotation(r)
			frame.NumHold.Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.R2+1-4*(2-i))*cos(r),  (RADIUS.R2+1-4*(2-i))*sin(r))
			frame.CountHold.Num[i]: SetRotation(r)
			frame.CountHold.Num[i]: SetPoint("CENTER", frame, "CENTER", (RADIUS.R3+1-4*(2-i))*cos(r),  (RADIUS.R3+1-4*(2-i))*sin(r))
		end
	end
end

local function BarButton_Template(frame)
	local Button = CreateFrame("Frame", nil, frame)
	Button: SetSize(12,12)
	Button: SetPoint("CENTER", frame, "CENTER", 0,0)
	Button.Info = {}

	Bar_Template(Button)
	BarNum_Template(Button)
	BarCount_Template(Button)

	return Button
end

----------------------------------------------------------------
--> Icon
----------------------------------------------------------------

local ICON_NUM36 = {
	["0"] = {  0/512, 31/512},
	["1"] = { 31/512, 62/512},
	["2"] = { 62/512, 93/512},
	["3"] = { 93/512,124/512},
	["4"] = {124/512,155/512},
	["5"] = {155/512,186/512},
	["6"] = {186/512,217/512},
	["7"] = {217/512,248/512},
	["8"] = {248/512,279/512},
	["9"] = {279/512,310/512},
	["m"] = {310/512,341/512},
	["b"] = {511/512,512/512},
}

local ICON_NUM22 = {
	["0"] = {  0/256, 22/256},
	["1"] = { 22/256, 44/256},
	["2"] = { 44/256, 66/256},
	["3"] = { 66/256, 88/256},
	["4"] = { 88/256,110/256},
	["5"] = {110/256,132/256},
	["6"] = {132/256,154/256},
	["7"] = {154/256,176/256},
	["8"] = {176/256,198/256},
	["9"] = {198/256,220/256},
	["b"] = {255/256,256/256},
}

local function Icon_Template(frame)
	local Main = CreateFrame("Frame", nil, frame, "MEKA_FCS_IconWarn_Template")
	Main: SetFrameLevel(frame:GetFrameLevel()+1)
	Main: SetSize(64,41)
	Main: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Front = CreateFrame("Frame", nil, Main)
	Front: SetAllPoints(Main)

	local Bg = Main: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(MEKA.Path("FCS_Icon_Bg"))
	Bg: SetVertexColor(F.Color(C.Color.Main0))
	Bg: SetAlpha(0.75)
	Bg: SetSize(64,41)
	Bg: SetTexCoord(0,1, 23/128,105/128)
	Bg: SetPoint("CENTER", Main, "CENTER", 0,0)

    local Glow = Main: CreateTexture(nil, "BACKGROUND")
	Glow: SetTexture(MEKA.Path("FCS_Icon_Glow"))
	Glow: SetVertexColor(F.Color(C.Color.Main0))
	Glow: SetAlpha(0.75)
	Glow: SetSize(64,41)
	Glow: SetTexCoord(0,1, 23/128,105/128)
	Glow: SetPoint("CENTER", Main, "CENTER", 0,0)

	local Gloss = F.Create.Texture(Main, "BACKGROUND", 1, MEKA.Path("FCS_Icon_Gloss"), C.Color.Main2, 0, {72,49}, {56/256,200/256, 15/128,113/128})
	Gloss: SetPoint("CENTER", Main, "CENTER", 0,0)

    local Bd = Main: CreateTexture(nil, "ARTWROK")
	Bd: SetTexture(MEKA.Path("FCS_Icon_Border"))
	Bd: SetVertexColor(F.Color(C.Color.Main1))
	Bd: SetAlpha(0.25)
	Bd: SetSize(64,41)
	Bd: SetTexCoord(0,1, 23/128,105/128)
	Bd: SetPoint("CENTER", Main, "CENTER", 0,0)

    local Border = Main: CreateTexture(nil, "ARTWORK")
	Border: SetTexture(MEKA.Path("FCS_Icon_Border"))
	Border: SetVertexColor(F.Color(C.Color.Main1))
	Border: SetAlpha(0)
	Border: SetSize(64,39)
	Border: SetTexCoord(0,1, 25/128,103/128)
	Border: SetPoint("BOTTOM", Main, "BOTTOM", 0,0)

    local Icon = Main: CreateTexture(nil, "ARTWORK")
    Icon: SetTexture("Interface\\InventoryItems\\WoWUnknownItem01")
	--Icon: SetMask("Interface\\GLUES\\Models\\UI_Dwarf\\UI_Goblin_GodRaysMask")
	Icon: SetMask("Interface\\CHATFRAME\\UI-ChatIcon-CallOfDutyBlackOps4") --使命召唤图标
    Icon: SetSize(28,28)
    Icon: SetPoint("CENTER", Main, "CENTER", -2,0)
	Icon: SetDesaturated(true)
	Icon: SetVertexColor(F.Color(C.Color.Main1))
    Icon: SetAlpha(0.9)

	local IconGloss = Main: CreateTexture(nil, "OVERLAY")
    IconGloss: SetTexture(MEKA.Path("FCS_Icon_IconBorder"))
    IconGloss: SetSize(32,32)
    IconGloss: SetPoint("CENTER", Icon, "CENTER", 0,0)
	IconGloss: SetVertexColor(F.Color(C.Color.Main1))
    IconGloss: SetAlpha(0.95)

	local IconAlter = Front: CreateTexture(nil, "BORDER")
	IconAlter: SetSize(32,32)
	IconAlter: SetVertexColor(F.Color(C.Color.Main1))
	IconAlter: SetAlpha(0.9)

	local IconAlterGloss = Front: CreateTexture(nil, "BACKGROUND")
	IconAlterGloss: SetSize(32,32)
	IconAlterGloss: SetPoint("CENTER", IconAlter, "CENTER", 2,2)
	IconAlterGloss: SetVertexColor(F.Color(C.Color.Main0))
	IconAlterGloss: SetAlpha(0)

    local Bar = Main: CreateTexture(nil, "ARTWORK")
	Bar: SetTexture(MEKA.Path("FCS_Icon_Fill"))
	Bar: SetVertexColor(F.Color(C.Color.Main1))
	Bar: SetAlpha(0.5)
	Bar: SetSize(64,41)
	Bar: SetTexCoord(0,1, 23/128,105/128)
	Bar: SetPoint("BOTTOM", Main, "BOTTOM", 0,0)

    local Indicator = Main: CreateTexture(nil, "ARTWORK")
	Indicator: SetTexture(MEKA.Path("FCS_Icon_Indicator1"))
	Indicator: SetVertexColor(F.Color(C.Color.Main1))
	Indicator: SetAlpha(0.9)
	Indicator: SetSize(64,41)
	Indicator: SetTexCoord(0,1, 23/128,105/128)
	Indicator: SetPoint("BOTTOM", Main, "BOTTOM", 0,0)

	local IndicatorBack = Main: CreateTexture(nil, "BACKGROUND")
	IndicatorBack: SetTexture(MEKA.Path("FCS_Icon_Indicator1"))
	IndicatorBack: SetVertexColor(F.Color(C.Color.Main0))
	IndicatorBack: SetAlpha(0.75)
	IndicatorBack: SetSize(64,41)
	IndicatorBack: SetTexCoord(0,1, 23/128,105/128)
	IndicatorBack: SetPoint("BOTTOM", Main, "BOTTOM", 0,0)

    local IndicatorGlow = Main: CreateTexture(nil, "BACKGROUND")
	IndicatorGlow: SetTexture(MEKA.Path("FCS_Icon_Indicator1Glow"))
	IndicatorGlow: SetVertexColor(F.Color(C.Color.Main0))
	IndicatorGlow: SetAlpha(0.75)
	IndicatorGlow: SetSize(64,41)
	IndicatorGlow: SetTexCoord(0,1, 23/128,105/128)
	IndicatorGlow: SetPoint("BOTTOM", Main, "BOTTOM", 0,0)

	local Num = {}
	for i = 1,3 do
		Num[i] = Front: CreateTexture(nil, "OVERLAY")
		Num[i]: SetSize(16,16)
		Num[i]: SetVertexColor(F.Color(C.Color.Main1))

		Num[i].Back = Front: CreateTexture(nil, "ARTWORK")
		Num[i].Back: SetSize(16,16)
		Num[i].Back: SetVertexColor(F.Color(C.Color.Main0))
	end

	local Count = {}
	for i = 1,3 do
		Count[i] = Front: CreateTexture(nil, "OVERLAY")
		Count[i]: SetSize(11,11)
		Count[i]: SetVertexColor(F.Color(C.Color.Main1))

		Count[i].Back = Front: CreateTexture(nil, "ARTWORK")
		Count[i].Back: SetSize(11,11)
		Count[i].Back: SetVertexColor(F.Color(C.Color.Main0))
	end

	frame.Main = Main
	frame.Main.Bar = Bar
	frame.Main.Border = Border
    frame.Main.Icon = Icon
	frame.Main.IconGloss = IconGloss
	frame.Main.IconAlter = IconAlter
	frame.Main.IconAlterGloss = IconAlterGloss

    frame.Main.Indicator = Indicator
	frame.Main.IndicatorBack = IndicatorBack
    frame.Main.IndicatorGlow = IndicatorGlow
    frame.Main.Num = Num
	frame.Main.Count = Count

	frame.Main.Bg = Bg
	frame.Main.BgGlow = Glow
	frame.Main.Bd = Bd
	frame.Main.Gloss = Gloss
end

local function Icon_Direction(frame)
	if frame.Main.Direction == "Right" then
		frame.Main.Bar: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.Border: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.Gloss: SetTexCoord(200/256,56/256, 15/128,113/128)
		frame.Main.Indicator: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.IndicatorBack: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.IndicatorGlow: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.Bg: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.BgGlow: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.Bd: SetTexCoord(1,0, 23/128,105/128)
		frame.Main.Icon: SetPoint("CENTER", frame.Main, "CENTER", 2,0)
		frame.Main.IconAlter: SetPoint("CENTER", frame.Main, "CENTER", 1,0)
		for i = 1,3 do
			frame.Main.Num[i]: SetTexture(MEKA.Path("FCS_Icon_Num36Right"))
			frame.Main.Num[i]: SetPoint("CENTER", frame.Main, "CENTER", -9+5*i,0)
			frame.Main.Num[i].Back: SetTexture(MEKA.Path("FCS_Icon_Num36Right"))
			frame.Main.Num[i].Back: SetPoint("CENTER", frame.Main.Num[i], "CENTER", 2,2)

			frame.Main.Count[i]: SetTexture(MEKA.Path("FCS_Icon_Num22Right"))
			frame.Main.Count[i]: ClearAllPoints()
			frame.Main.Count[i]: SetPoint("BOTTOMLEFT", frame.Main, "BOTTOMLEFT", 3+7*i,2)
			frame.Main.Count[i].Back: SetTexture(MEKA.Path("FCS_Icon_Num22Right"))
			frame.Main.Count[i].Back: SetPoint("CENTER", frame.Main.Count[i], "CENTER", 1,1)
		end
	elseif frame.Main.Direction == "Left" then
		frame.Main.Bar: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.Border: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.Gloss: SetTexCoord(56/256,200/256, 15/128,113/128)
		frame.Main.Indicator: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.IndicatorBack: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.IndicatorGlow: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.Bg: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.BgGlow: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.Bd: SetTexCoord(0,1, 23/128,105/128)
		frame.Main.Icon: SetPoint("CENTER", frame.Main, "CENTER", -2,0)
		frame.Main.IconAlter: SetPoint("CENTER", frame.Main, "CENTER", -1,0)
		for i = 1,3 do
			frame.Main.Num[i]: SetTexture(MEKA.Path("FCS_Icon_Num36Left"))
			frame.Main.Num[i]: SetPoint("CENTER", frame.Main, "CENTER", -11+5*i,0)
			frame.Main.Num[i].Back: SetTexture(MEKA.Path("FCS_Icon_Num36Left"))
			frame.Main.Num[i].Back: SetPoint("CENTER", frame.Main.Num[i], "CENTER", -2,2)

			frame.Main.Count[i]: SetTexture(MEKA.Path("FCS_Icon_Num22Left"))
			frame.Main.Count[i]: ClearAllPoints()
			frame.Main.Count[i]: SetPoint("BOTTOMRIGHT", frame.Main, "BOTTOMRIGHT", -3-7*i,2)
			frame.Main.Count[i].Back: SetTexture(MEKA.Path("FCS_Icon_Num22Left"))
			frame.Main.Count[i].Back: SetPoint("CENTER", frame.Main.Count[i], "CENTER", -1,1)
		end
	end
end

local function IconButton_Template(frame)
	local Button = CreateFrame("Frame", nil, frame)
	Button: SetSize(64,41)
	Button: SetPoint("CENTER", frame, "CENTER", 0,0)
	Button.Info = {}

	Icon_Template(Button)

	return Button
end

local ICON_POS = {
	[1] = {230-30, 156+20},
	[2] = {168-30, 156+20},
	[3] = {203-30, 202+20},
	[4] = {141-30, 202+20},
	[5] = { 79-30, 202+20},
}

local function IconButton_Rotate(frame, direction)
	if direction == "Left" then
		frame.Main.Direction = "Left"
		frame.Main: ClearAllPoints()
		frame.Main: SetPoint("CENTER", frame, "CENTER", -ICON_POS[frame.Info.Angle][1],-ICON_POS[frame.Info.Angle][2])
	elseif direction == "Right" then
		frame.Main.Direction = "Right"
		frame.Main: ClearAllPoints()
		frame.Main: SetPoint("CENTER", frame, "CENTER", ICON_POS[frame.Info.Angle][1],-ICON_POS[frame.Info.Angle][2])
	end
	Icon_Direction(frame)
end

----------------------------------------------------------------
--> Update
----------------------------------------------------------------

local function Button_Refresh(frame, All)
	if All then
		frame.Info.SpellID = nil
		frame.Info.SpellName = nil
		frame.Info.AuraID = nil
		frame.Info.Unit = nil
		frame.Info.AuraCaster = nil
		frame: Hide()
	end
	--> Aura
	frame.Info.AuraExist = false
	frame.Info.AuraCount = 0
	frame.Info.AuraNum = 0
	frame.Info.AuraExpires = 0
	frame.Info.AuraDuration = 0
	frame.Info.AuraRemain = 0
	frame.Info.AuraRemain1 = 0
	frame.Info.AuraRemain2 = 0
	frame.Info.ShowAura = 0

	frame.Info.AuraExist2 = false
	frame.Info.AuraCount2 = 0
	frame.Info.AuraNum2 = 0
	frame.Info.AuraExpires2 = 0
	frame.Info.AuraDuration2 = 0
	frame.Info.AuraRemain2 = 0
	--> Spell
	frame.Info.SpellUsable = true
	--frame.Info.SpellOom = false
	frame.Info.SpellCharge = 0
	frame.Info.SpellMaxCharge = 0
	frame.Info.SpellStart = 0
	frame.Info.SpellDuration = 0
	frame.Info.SpellRemain = 0
	frame.Info.SpellEnabled = 1
	frame.Info.ShowSpell = 0
	--> Special
	frame.Info.SpecialCount = 0
end

local function Button_RefreshAura(frame)
	frame.Info.AuraExist = false
	frame.Info.AuraCount = 0
	frame.Info.AuraNum = 0
	frame.Info.AuraExpires = 0
	frame.Info.AuraDuration = 0
	frame.Info.AuraRemain = 0
	frame.Info.ShowAura = 0

	frame.Info.AuraExist2 = false
	frame.Info.AuraCount2 = 0
	frame.Info.AuraNum2 = 0
	frame.Info.AuraExpires2 = 0
	frame.Info.AuraDuration2 = 0
	frame.Info.AuraRemain2 = 0
end

local function Button_RefreshSpell(frame)
	frame.Info.SpellUsable = true
	--frame.Info.SpellOom = false
	frame.Info.SpellCharge = 0
	frame.Info.SpellMaxCharge = 0
	frame.Info.SpellStart = 0
	frame.Info.SpellDuration = 0
	frame.Info.GCD = 1.5
	frame.Info.SpellRemain = 0
	frame.Info.SpellEnabled = 1
	frame.Info.ShowSpell = 0
end

local START_ANGLE = {
	["OFF"] = 28.5,
	["LOOP"] = 28.5,
	["RING"] = 22.5,
}

local function BarButton_Init(frame, filter)
	if not frame then return end
	if frame.Info.NumButton > 0 then
		for i = 1, frame.Info.NumButton do
			if frame.Button[i] then
				Button_Refresh(frame.Button[i], true)
			end
		end
	end
	--wipe(UNIT_LIST)

	frame.Info.NumButton = 0
	local NUM = {}
	NUM.MEKA_BL = 0
	NUM.MEKA_BR = 0
	NUM.Max = 5

	for k,v in pairs(filter) do
		if v and v.Show and NUM[v.Style] and NUM[v.Style] < NUM.Max then
			NUM[v.Style] = NUM[v.Style] + 1
			frame.Info.NumButton = frame.Info.NumButton + 1
			if not frame.Button[frame.Info.NumButton] then
				frame.Button[frame.Info.NumButton] = BarButton_Template(frame)
			end
			--[[
			if v.Style == "MEKA_BL" then
				frame.Button[frame.Info.NumButton].Info.Angle = 171.5-4*(NUM[v.Style]-1)
				Bar_Rotate(frame.Button[frame.Info.NumButton], "Left")
			elseif v.Style == "MEKA_BR" then
				--frame.Button[frame.Info.NumButton].Info.Angle = 10+6*(NUM[v.Style]-1)
				frame.Button[frame.Info.NumButton].Info.Angle = 28.5-3*(NUM[v.Style]-1)
				Bar_Rotate(frame.Button[frame.Info.NumButton], "Right")
			end
			--]]
			if v.Style == "MEKA_BR" then
				--frame.Button[frame.Info.NumButton].Info.Angle = 10+6*(NUM[v.Style]-1)
				frame.Button[frame.Info.NumButton].Info.Angle = START_ANGLE[Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State]-3*(NUM[v.Style]-1)
				Bar_Rotate(frame.Button[frame.Info.NumButton], "Right")
			end
			frame.Button[frame.Info.NumButton]: Show()
			if v.Spell then
				local name, rank, fileID, _,_,_, spellID = GetSpellInfo(v.Spell)
				frame.Button[frame.Info.NumButton].Info.SpellName = name
				frame.Button[frame.Info.NumButton].Info.SpellID = name
				frame.Button[frame.Info.NumButton].Info.SpellColor = v.SpellColor
                --frame.Button[frame.Info.NumButton].Main.Icon: SetTexture(fileID)
			end
			if v.Aura then
				frame.Button[frame.Info.NumButton].Info.AuraID = v.Aura
				frame.Button[frame.Info.NumButton].Info.AuraID2 = v.Aura2
				frame.Button[frame.Info.NumButton].Info.Unit = v.Unit
				frame.Button[frame.Info.NumButton].Info.AuraCaster = v.Caster
				frame.Button[frame.Info.NumButton].Info.Filter = v.Filter
				frame.Button[frame.Info.NumButton].Info.AuraColor = v.AuraColor
				if not tContains(UNIT_LIST, v.Unit) then
					tinsert(UNIT_LIST, v.Unit)
				end
                local name, rank, fileID, _,_,_, spellID = GetSpellInfo(v.Aura)
				if fileID then
					--frame.Button[frame.Info.NumButton].Main.Icon: SetTexture(fileID)
				end
			end
		end
	end
end

local function IconButton_Init(frame, filter)
	if not frame then return end
	if frame.Info.NumButton > 0 then
		for i = 1, frame.Info.NumButton do
			if frame.Button[i] then
				Button_Refresh(frame.Button[i], true)
			end
		end
	end
	--wipe(UNIT_LIST)

	frame.Info.NumButton = 0
	local NUM = {}
	NUM.MEKA_IL = 0
	NUM.MEKA_IR = 0
	NUM.Max = 5

	for k,v in pairs(filter) do
		if v and v.Show and NUM[v.Style] and NUM[v.Style] < NUM.Max then
			NUM[v.Style] = NUM[v.Style] + 1
			frame.Info.NumButton = frame.Info.NumButton + 1
			if not frame.Button[frame.Info.NumButton] then
				frame.Button[frame.Info.NumButton] = IconButton_Template(frame)
			end
			if v.Style == "MEKA_IL" then
				frame.Button[frame.Info.NumButton].Info.Angle = NUM[v.Style]
				IconButton_Rotate(frame.Button[frame.Info.NumButton], "Left")
			elseif v.Style == "MEKA_IR" then
				frame.Button[frame.Info.NumButton].Info.Angle = NUM[v.Style]
				IconButton_Rotate(frame.Button[frame.Info.NumButton], "Right")
			end
			frame.Button[frame.Info.NumButton]: Show()
			if v.Icon and v.Icon ~= C.WatcherIcon[1] then
				frame.Button[frame.Info.NumButton].Main.IconAlter: SetTexture(F.Path("Watcher\\"..v.Icon))
				frame.Button[frame.Info.NumButton].Main.IconAlterGloss: SetTexture(F.Path("Watcher\\"..v.Icon))
				frame.Button[frame.Info.NumButton].Main.Icon: Hide()
				frame.Button[frame.Info.NumButton].Main.IconGloss: Hide()
			else
				frame.Button[frame.Info.NumButton].Main.IconAlter: SetTexture("")
				frame.Button[frame.Info.NumButton].Main.IconAlterGloss: SetTexture("")
				frame.Button[frame.Info.NumButton].Main.Icon: Show()
				frame.Button[frame.Info.NumButton].Main.IconGloss: Show()
			end
			if v.Spell then
				local name, rank, fileID, _,_,_, spellID = GetSpellInfo(v.Spell)
				frame.Button[frame.Info.NumButton].Info.SpellName = name
				frame.Button[frame.Info.NumButton].Info.SpellID = spellID
				frame.Button[frame.Info.NumButton].Info.IconID = fileID
				frame.Button[frame.Info.NumButton].Info.SpellColor = v.SpellColor
				frame.Button[frame.Info.NumButton].Main.Icon: SetTexture(fileID)
			end
			if v.Aura then
				frame.Button[frame.Info.NumButton].Info.AuraID = v.Aura
				frame.Button[frame.Info.NumButton].Info.AuraID2 = v.Aura2
				frame.Button[frame.Info.NumButton].Info.Unit = v.Unit
				frame.Button[frame.Info.NumButton].Info.AuraCaster = v.Caster
				frame.Button[frame.Info.NumButton].Info.Filter = v.Filter
				frame.Button[frame.Info.NumButton].Info.AuraColor = v.AuraColor
				if not tContains(UNIT_LIST, v.Unit) then
					tinsert(UNIT_LIST, v.Unit)
				end
				local name, rank, fileID, _,_,_, spellID = GetSpellInfo(v.Aura)
				if fileID then
					frame.Button[frame.Info.NumButton].Main.Icon: SetTexture(fileID)
				end
			end
		end
	end
end

local function Watcher_AuraUpdate(f, unit, name, icon, count, duration, expires, caster, spellID)
	for i = 1, f.Info.NumButton do
		local AuraID = f.Button[i].Info.AuraID
		local AuraID2 = f.Button[i].Info.AuraID2
		if AuraID then
			if (f.Button[i].Info.Unit == unit) and ((f.Button[i].Info.AuraCaster and ((f.Button[i].Info.AuraCaster == "ALL_UNIT") or (f.Button[i].Info.AuraCaster == caster))) or (not f.Button[i].Info.AuraCaster) and caster == "player") then
				if type(AuraID) == "table" then
					local d = 1
					while d and AuraID[d] do
						if (AuraID[d] == name) or (AuraID[d] == tostring(spellID)) then
							f.Button[i].Info.AuraExist = true
							f.Button[i].Info.AuraRemain = expires - GetTime()
							f.Button[i].Info.AuraDuration = duration
							f.Button[i].Info.AuraCount = count
							f.Button[i].Info.AuraNum = f.Button[i].Info.AuraNum + 1
							f.Button[i].Info.ShowAura = 1
                            --f.Button[i].Info.Icon = icon
							d = nil
						else
							d = d + 1
						end
					end
				elseif (AuraID == name) or (AuraID == tostring(spellID)) then
					f.Button[i].Info.AuraExist = true
					f.Button[i].Info.AuraRemain = expires - GetTime()
					f.Button[i].Info.AuraDuration = duration
					f.Button[i].Info.AuraCount = count
					f.Button[i].Info.AuraNum = f.Button[i].Info.AuraNum + 1
					f.Button[i].Info.ShowAura = 1
                    --f.Button[i].Info.Icon = icon
				end
				if AuraID2 and (AuraID2 == name) or (AuraID2 == tostring(spellID)) then
					f.Button[i].Info.AuraExist2 = true
					f.Button[i].Info.AuraRemain2 = expires - GetTime()
					f.Button[i].Info.AuraDuration2 = duration
					f.Button[i].Info.AuraCount2 = count
					f.Button[i].Info.ShowAura = 1
				end
			end
		end
	end
end

local function Watcher_AuraEvent(frame)
	if (not frame) or (not frame.BarWatcher) or (not frame.IconWatcher) then return end
	for i = 1, frame.BarWatcher.Info.NumButton do
		Button_RefreshAura(frame.BarWatcher.Button[i])
	end
	for i = 1, frame.IconWatcher.Info.NumButton do
		Button_RefreshAura(frame.IconWatcher.Button[i])
	end
	local name, icon, count, dispelType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3
	for k, v in ipairs(UNIT_LIST) do
		local NumBuff,NumDebuff = 1, 1
		local b,d
		while NumBuff == 1 or b do
			b = false
			name, icon, count, dispelType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID = F.UnitAura(v, NumBuff, "HELPFUL")
			if name then
				b = true
				Watcher_AuraUpdate(frame.BarWatcher, v, name, icon, count, duration, expirationTime, unitCaster, spellID)
				Watcher_AuraUpdate(frame.IconWatcher, v, name, icon, count, duration, expirationTime, unitCaster, spellID)
			end
			NumBuff = NumBuff + 1
		end

		while NumDebuff == 1 or d do
			d = false
			name, icon, count, dispelType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID = F.UnitAura(v, NumDebuff, "HARMFUL")
			if name then
				d = true
				Watcher_AuraUpdate(frame.BarWatcher, v, name, icon, count, duration, expirationTime, unitCaster, spellID)
				Watcher_AuraUpdate(frame.IconWatcher, v, name, icon, count, duration, expirationTime, unitCaster, spellID)
			end
			NumDebuff = NumDebuff + 1
		end
	end
end

local function Watcher_SpellEvent(f)
	if not f then return end
	local GCD = 1.5
	for i = 1, f.Info.NumButton do
		Button_RefreshSpell(f.Button[i])
		local SpellID = f.Button[i].Info.SpellID
		if SpellID then
			local start, duration, enabled = GetSpellCooldown(SpellID)
			local charges, maxCharges, chargeStart, chargeDuration = GetSpellCharges(SpellID)
			if maxCharges then
				--if maxCharges <= 1 then charges = 0 end
			else
				charges = GetSpellCount(SpellID)
			end
			if not (chargeStart and chargeDuration) then
				chargeDuration = 0
				chargeStart = 0
			end
			if charges and charges >= 1 then
				if chargeStart == (2^32 / 1000 - chargeDuration) then
					chargeStart = 0
				end
				f.Button[i].Info.SpellStart = chargeStart or 0
				f.Button[i].Info.SpellDuration = chargeDuration or 0
			else
				f.Button[i].Info.SpellStart = start or 0
				f.Button[i].Info.SpellDuration = duration or 0
			end
			if f.Button[i].Info.SpellStart ~= 0 then
				if f.Button[i].Info.SpellDuration > GCD then 
					f.Button[i].Info.SpellRemain = max(f.Button[i].Info.SpellDuration + f.Button[i].Info.SpellStart - GetTime(), 0)
					f.Button[i].Info.ShowSpell = 1
				else
					f.Button[i].Info.SpellStart = 0
				end
			end
			f.Button[i].Info.SpellEnabled = enabled
			f.Button[i].Info.SpellCharge = charges
			f.Button[i].Info.SpellMaxCharge = maxCharges
			f.Button[i].Info.GCD = GCD
		end
	end
end

local function Watcher_SpellUsable(frame)
	for i = 1, frame.Info.NumButton do
		if frame.Button[i] then
			local SpellID = frame.Button[i].Info.SpellID
			if SpellID then
				local isUsable, notEnoughMana = IsUsableSpell(SpellID)
				--local isOverlayed = IsSpellOverlayed(SpellID)
				--isUsable - 1 if the spell is castable; otherwise nil (1nil) 
				--notEnoughMana - 1 if the player lacks the resources (e.g. mana, energy, runes) to cast the spell; otherwise nil (1nil) 
				local name = GetSpellInfo(SpellID)
				local inRange = IsSpellInRange(name, "target") or 1
				--if (UnitExists("target") and name) then
				--	inRange = IsSpellInRange(name, "target") or 1
				--	--inRange - 1 if the player is near enough to cast the spell on the unit; 0 if not in range; nil if the unit is not a valid target for the spell (1nil) 
				--else
				--	inRange = 1
				--end

				if ((inRange == 0) or (not isUsable)) then
					frame.Button[i].SpellUsable = false
				else
					frame.Button[i].SpellUsable = true
				end

				if frame.Button[i].SpellUsable then
					if (frame.Button[i].Info.SpellDuration > frame.Button[i].Info.GCD) then
						if frame.Button[i].Info.SpellCharge and frame.Button[i].Info.SpellCharge >= 1 then
							--frame.Button[i].Main.Border: SetVertexColor(F.Color(C.Color.Main1))
						else
							--frame.Button[i].Main.Border: SetVertexColor(F.Color(C.Color.R3))
						end
					else
						--frame.Button[i].Main.Border: SetVertexColor(F.Color(C.Color.Main1))
					end
				else
					--frame.Button[i].Main.Border: SetVertexColor(F.Color(C.Color.R3))
				end
			end
		end
	end
end

local function Watcher_SpellActivation(frame)
	if F.IsClassic then return end
	for i = 1, frame.Info.NumButton do
		if frame.Button[i] and frame.Button[i].Info.SpellID then
			if IsSpellOverlayed(frame.Button[i].Info.SpellID) then
				frame.Button[i].Main.Gloss: SetAlpha(0.9)
			else
				frame.Button[i].Main.Gloss: SetAlpha(0)
			end
		end
	end
end

local function Watcher_SpellUpdateIcon(frame)
	for i = 1, frame.Info.NumButton do
		if frame.Button[i] then
			local SpellID = frame.Button[i].Info.SpellID
			if SpellID then
				icon = GetSpellTexture(SpellID)
				if icon ~= frame.Button[i].Info.IconID then
					frame.Button[i].Info.IconID = icon
					frame.Button[i].Main.Icon: SetTexture(icon)
				end
			end
		end
	end
end

local function Bar_BarUpdate(frame, d, show)
	if (not d) or d < 0 then d = 0 end
	if d > 1 then d = 1 end
	if d == 0 then
		frame.Main:Hide()
	else
		frame.Main:Show()
		d = floor(78 * d + 0.5) * 2
        frame.Main.Bar: SetTexture(MEKA.Path("PitaBar\\Bar1_"..d))
	end
end

local function Bar_NumUpdate(frame, d, show)
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
		frame.NumHold.Num[1]: SetTexture(F.Path("N12\\N"..n1))
		frame.NumHold.Num[2]: SetTexture(F.Path("N12\\N"..n2))
		frame.NumHold.Num[3]: SetTexture(F.Path("N12\\N"..n3))
		frame.NumHold: Show()
	else
		frame.NumHold: Hide()
	end
end

local function Bar_CountUpdate(frame, c, n, showone)
	local d1,d2,n1,n2,n3 = 0,0,0,0,0,0
	local d = nil
	if n then
		if n > 1 then
			d = n
		elseif c and c > 1 then
			d = c
		end
	else
		if c and ((c > 1) or (showone and c >= 1)) then
			d = c
		end
	end
	if d then
		if d < 0 then d = 0 end
		if d > 99 then d = 99 end
		d2 = floor(d/10)
		d1 = max(floor(d - d2*10), 0)
		if d2 >= 1 then
			n1 = d2
			n2 = "b"
			n3 = d1
		else
			n1 = "b"
			n2 = d1
			n3 = "b"
		end
		frame.CountHold.Num[1]: SetTexture(F.Path("N12\\N"..n1))
		frame.CountHold.Num[2]: SetTexture(F.Path("N12\\N"..n2))
		frame.CountHold.Num[3]: SetTexture(F.Path("N12\\N"..n3))
		frame.CountHold:Show()
	else
		frame.CountHold:Hide()
	end
end

local function Bar_Update(frame, elapsed, ...)
	--local GCD = select(2,GetSpellCooldown(61304))
	local GCD = 1.5
	for i = 1, frame.Info.NumButton do
		local Button = frame.Button[i]
		if Button.Info.AuraExist then
			if Button.Info.AuraRemain > 0 then
				Bar_BarUpdate(Button, Button.Info.AuraRemain/(Button.Info.AuraDuration+F.Debug))
				Bar_NumUpdate(Button, Button.Info.AuraRemain)
				Bar_CountUpdate(Button, Button.Info.AuraCount, Button.Info.AuraNum)
				frame.Button[i].Info.AuraRemain = frame.Button[i].Info.AuraRemain - elapsed
			else
				Bar_BarUpdate(Button, 1)
				Bar_NumUpdate(Button, nil)
				Bar_CountUpdate(Button, Button.Info.AuraCount, Button.Info.AuraNum)
			end
			Button.Main.Bar: SetVertexColor(F.Color(Button.Info.AuraColor))
			Button.Main.BgG: SetVertexColor(F.Color(Button.Info.AuraColor))
		elseif (Button.Info.SpellStart > 0) and (Button.Info.SpellDuration > 0) and (Button.Info.SpellRemain > 0) and (Button.Info.SpellRemain <= Button.Info.SpellDuration) then
			Bar_BarUpdate(Button, (Button.Info.SpellDuration-Button.Info.SpellRemain)/(Button.Info.SpellDuration+F.Debug))
			Bar_NumUpdate(Button, Button.Info.SpellRemain)
			Bar_CountUpdate(Button, Button.Info.SpellCharge, nil, true)
			frame.Button[i].Info.SpellRemain = frame.Button[i].Info.SpellRemain - elapsed
			Button.Main.Bar: SetVertexColor(F.Color(Button.Info.SpellColor))
            Button.Main.BgG: SetVertexColor(F.Color(Button.Info.SpellColor))
		elseif Button.Info.SpellEnabled == 0 then --0 if the spell is active (Stealth, Shadowmeld, Presence of Mind, etc) and the cooldown will begin as soon as the spell is used/cancelled; 1 otherwise. 
			Bar_BarUpdate(Button, 1)
			Bar_NumUpdate(Button, nil)
			Bar_CountUpdate(Button, Button.Info.SpellCharge)
			Button.Main.Bar: SetVertexColor(F.Color(Button.Info.SpellColor))
            Button.Main.BgG: SetVertexColor(F.Color(Button.Info.SpellColor))
		else
			Bar_BarUpdate(Button, 0)
			Bar_NumUpdate(Button, nil)
			Bar_CountUpdate(Button, Button.Info.SpellCharge)
		end
		--Bar_UpdateWarn(Button)
	end
end

local function FCS_BarWathcher(frame)
	local BarWatcher = CreateFrame("Frame", "MEKA_FCS_BarWatcher", frame)
	BarWatcher: SetSize(12,12)
	BarWatcher: SetPoint("CENTER", frame, "CENTER", 0,0)
	BarWatcher.Info = {}
	BarWatcher.Info.NumButton = 0
	BarWatcher.Button = {}

	frame.BarWatcher = BarWatcher
end

local function Icon_BarUpdate(frame, d1, d2, show)
	if (not d1) or d1 < 0 then d1 = 0 end
	if d1 > 1 then d1 = 1 end
	
	frame.Main.Bar: SetSize(64,4+33*d1)
	if frame.Main.Direction == "Left" then
		frame.Main.Bar: SetTexCoord(0,1, (105-8-66*d1)/128,105/128)
	elseif frame.Main.Direction == "Right" then
		frame.Main.Bar: SetTexCoord(1,0, (105-8-66*d1)/128,105/128)
	end

	if d2 then
		if d2 < 0 then d2 = 0 end
		if d2 > 1 then d2 = 1 end
		frame.Main.Border: SetSize(64,1+39*d2)
		if frame.Main.Direction == "Left" then
			frame.Main.Border: SetTexCoord(0,1, (105-2-78*d2)/128,105/128)
		elseif frame.Main.Direction == "Right" then
			frame.Main.Border: SetTexCoord(1,0, (105-2-78*d2)/128,105/128)
		end
		frame.Main.Border: SetAlpha(1)
	else
		frame.Main.Border: SetAlpha(0)
	end
end

local function Icon_NumUpdate(frame, remain)
	local d1,d2,n1,n2,n3 = 0,0,0,0,0
	if remain then
		if remain < 0 then remain = 0 end
		remain = floor(remain+0.5)
		if remain > 540 then remain = 540 end
		if remain > 60 then
			d1 = floor(remain/60)
			d2 = "m"
		else
			d1 = floor(remain/10)
			d2 = max(floor(remain - d1*10), 0)
		end
		if d1 >= 1 then
			n1 = tostring(d1)
			n2 = "b"
			n3 = tostring(d2)
		else
			n1 = "b"
			n2 = tostring(d2)
			n3 = "b"
		end
		frame.Main.Icon: SetAlpha(0)
		frame.Main.IconGloss: SetAlpha(0)
		frame.Main.IconAlter: SetAlpha(0)
		frame.Info.ToFlash = true
	else
		n1 = "b"
		n2 = "b"
		n3 = "b"
		frame.Main.Icon: SetAlpha(0.9)
		frame.Main.IconGloss: SetAlpha(0.25)
		frame.Main.IconAlter: SetAlpha(0.9)
		if frame.Info.ToFlash then
			frame.Info.ToFlash = false
			frame.Main.Flash: Play()
		end
	end
	frame.Main.Num[1]:SetTexCoord(ICON_NUM36[n1][1],ICON_NUM36[n1][2], 0,1)
	frame.Main.Num[2]:SetTexCoord(ICON_NUM36[n2][1],ICON_NUM36[n2][2], 0,1)
	frame.Main.Num[3]:SetTexCoord(ICON_NUM36[n3][1],ICON_NUM36[n3][2], 0,1)
	frame.Main.Num[1].Back:SetTexCoord(ICON_NUM36[n1][1],ICON_NUM36[n1][2], 0,1)
	frame.Main.Num[2].Back:SetTexCoord(ICON_NUM36[n2][1],ICON_NUM36[n2][2], 0,1)
	frame.Main.Num[3].Back:SetTexCoord(ICON_NUM36[n3][1],ICON_NUM36[n3][2], 0,1)
end

local function Icon_CountUpdate(frame, count, num, total, showone)
	local shownum
    if not total then 
		total = 1
		shownum = true
	end
	if num and num > 1 then
		count = num
	end
	if not count then
		count = 0
	end
	if showone then
		count = max(count, 1)
	end
	if total <= 3 then
		frame.Main.Indicator: SetTexture(MEKA.Path("FCS_Icon_Indicator"..total))
		frame.Main.IndicatorBack: SetTexture(MEKA.Path("FCS_Icon_Indicator"..total))
		frame.Main.IndicatorGlow: SetTexture(MEKA.Path("FCS_Icon_Indicator"..total.."Glow"))
		--frame.Main.Count: SetText("")
	else
		frame.Main.Indicator: SetTexture(MEKA.Path("FCS_Icon_Indicator1"))
		frame.Main.IndicatorBack: SetTexture(MEKA.Path("FCS_Icon_Indicator1"))
		frame.Main.IndicatorGlow: SetTexture(MEKA.Path("FCS_Icon_Indicator1Glow"))
		--frame.Main.Count: SetText(count)
	end
	if total == 3 then
		frame.Main.Indicator: SetSize(64,9+11*count)
		if frame.Main.Direction == "Left" then
			frame.Main.Indicator: SetTexCoord(0,1, (105-18-22*count)/128,105/128)
		elseif frame.Main.Direction == "Right" then
			frame.Main.Indicator: SetTexCoord(1,0, (105-18-22*count)/128,105/128)
		end
	elseif total == 2 then
		frame.Main.Indicator: SetSize(64,9+16*count)
		if frame.Main.Direction == "Left" then
			frame.Main.Indicator: SetTexCoord(0,1, (105-18-32*count)/128,105/128)
		elseif frame.Main.Direction == "Right" then
			frame.Main.Indicator: SetTexCoord(1,0, (105-18-32*count)/128,105/128)
		end
	else
		if count >= 1 then
			frame.Main.Indicator: SetSize(64,41)
			if frame.Main.Direction == "Left" then
				frame.Main.Indicator: SetTexCoord(0,1, 23/128,105/128)
			elseif frame.Main.Direction == "Right" then
				frame.Main.Indicator: SetTexCoord(1,0, 23/128,105/128)
			end
		else
			frame.Main.Indicator: SetSize(64,9)
			if frame.Main.Direction == "Left" then
				frame.Main.Indicator: SetTexCoord(0,1, (105-18)/128,105/128)
			elseif frame.Main.Direction == "Right" then
				frame.Main.Indicator: SetTexCoord(1,0, (105-18)/128,105/128)
			end
		end
	end

	local d = {}
	local d1,d2,d3
	if (total <= 3 and (not shownum)) or count <= 1 then
		d1 = "b"
		d2 = "b"
		d3 = "b"
	else
		count = min(count, 999)
		if frame.Main.Direction == "Left" then
			for w in gmatch(string.reverse(tostring(count)), "(%d)") do
				insert(d, w)
			end
		elseif frame.Main.Direction == "Right" then
			for w in gmatch(tostring(count), "(%d)") do
				insert(d, w)
			end
		end
	end
	d1 = d[1] or "b"
	d2 = d[2] or "b"
	d3 = d[3] or "b"
	frame.Main.Count[1]:SetTexCoord(ICON_NUM22[d1][1],ICON_NUM22[d1][2], 5/32,27/32)
	frame.Main.Count[2]:SetTexCoord(ICON_NUM22[d2][1],ICON_NUM22[d2][2], 5/32,27/32)
	frame.Main.Count[3]:SetTexCoord(ICON_NUM22[d3][1],ICON_NUM22[d3][2], 5/32,27/32)
	frame.Main.Count[1].Back:SetTexCoord(ICON_NUM22[d1][1],ICON_NUM22[d1][2], 5/32,27/32)
	frame.Main.Count[2].Back:SetTexCoord(ICON_NUM22[d2][1],ICON_NUM22[d2][2], 5/32,27/32)
	frame.Main.Count[3].Back:SetTexCoord(ICON_NUM22[d3][1],ICON_NUM22[d3][2], 5/32,27/32)
end

local function Icon_Update(frame, elapsed, ...)
	local GCD = 1.5
	for i = 1, frame.Info.NumButton do
		local Button = frame.Button[i]
		local d1, d2, n1, c1, c2, c3, CountShow
		if Button.Info.SpellID and Button.Info.AuraID then
			d1 = (Button.Info.SpellDuration-Button.Info.SpellRemain)/(Button.Info.SpellDuration+F.Debug)
			d2 = Button.Info.AuraRemain/(Button.Info.AuraDuration+F.Debug)
			n1 = Button.Info.SpellRemain
			c1 = Button.Info.SpellCharge
			c2 = nil
			c3 = Button.Info.SpellMaxCharge
			if Button.Info.SpellEnabled == 0 then
				d1 = 0
				c1 = nil
			end
			if Button.Info.AuraRemain > 0 then
				frame.Button[i].Info.AuraRemain = frame.Button[i].Info.AuraRemain - elapsed
			elseif Button.Info.AuraExist then
				d2 = 1
			end
			if (Button.Info.SpellStart > 0) and (Button.Info.SpellDuration > 0) and (Button.Info.SpellRemain > 0) then
				frame.Button[i].Info.SpellRemain = frame.Button[i].Info.SpellRemain - elapsed
			else
				d1 = 0
				n1 = nil
				CountShow = true
				frame.Button[i].Info.ShowSpell = 0
			end
			frame.Button[i].Main.Border: SetVertexColor(F.Color(Button.Info.AuraColor))
		elseif Button.Info.AuraID then
			d1 = Button.Info.AuraRemain/(Button.Info.AuraDuration+F.Debug)
			d2 = Button.Info.AuraRemain2/(Button.Info.AuraDuration2+F.Debug)
			n1 = Button.Info.AuraRemain
			c1 = Button.Info.AuraCount
			c2 = Button.Info.AuraNum
			if Button.Info.AuraExist then
				CountShow = true
			end
			if Button.Info.AuraRemain > 0 then
				CountShow = true
				frame.Button[i].Info.AuraRemain = frame.Button[i].Info.AuraRemain - elapsed
			else
				n1 = nil
				if Button.Info.AuraExist then
					d1 = 1
				end
			end
			if Button.Info.AuraRemain2 > 0 then
				frame.Button[i].Info.AuraRemain2 = frame.Button[i].Info.AuraRemain2 - elapsed
			elseif Button.Info.AuraExist2 then
				d2 = 1
			end
			Button.Main.Border: SetVertexColor(F.Color(Button.Info.AuraColor))
		elseif Button.Info.SpellID then
			d1 = (Button.Info.SpellDuration-Button.Info.SpellRemain)/(Button.Info.SpellDuration+F.Debug)
			d2 = nil
			n1 = Button.Info.SpellRemain
			c1 = Button.Info.SpellCharge
			c2 = nil
			c3 = Button.Info.SpellMaxCharge
			if Button.Info.SpellEnabled == 0 then
				d1 = 0
				c1 = nil
			end
			--if (Button.Info.SpellStart > 0) and (Button.Info.SpellDuration > 0) and (Button.Info.SpellRemain > 0) and (Button.Info.SpellRemain <= Button.Info.SpellDuration) then
			if (Button.Info.SpellStart > 0) and (Button.Info.SpellDuration > 0) and (Button.Info.SpellRemain > 0) then
				frame.Button[i].Info.SpellRemain = frame.Button[i].Info.SpellRemain - elapsed
			else
				d1 = 0
				n1 = nil
				CountShow = true
				frame.Button[i].Info.ShowSpell = 0
			end
		end
		Icon_BarUpdate(Button, d1, d2)
		Icon_NumUpdate(Button, n1)
		Icon_CountUpdate(Button, c1, c2, c3, CountShow)
	end
end

local function FCS_IconWathcher(frame)
	local IconWatcher = CreateFrame("Frame", "MEKA_FCS_IconWatcher", frame)
	IconWatcher: SetSize(12,12)
	IconWatcher: SetPoint("CENTER", frame, "CENTER", 0,0)
	IconWatcher.Info = {}
	IconWatcher.Info.NumButton = 0
	IconWatcher.Button = {}

	frame.IconWatcher = IconWatcher
end

----------------------------------------------------------------
--> Watcher Update
----------------------------------------------------------------

local function Watcher_Refresh(frame)
	local classFileName = select(2, UnitClass("player"))
	local specID = (F.IsClassic and 1) or GetSpecialization() or 0
	if classFileName then
		if Quafe_DB.Global.AuraWatch and Quafe_DB.Global.AuraWatch[classFileName] and Quafe_DB.Global.AuraWatch[classFileName][specID] then
			BarButton_Init(frame.BarWatcher, Quafe_DB.Global.AuraWatch[classFileName][specID])
			IconButton_Init(frame.IconWatcher, Quafe_DB.Global.AuraWatch[classFileName][specID])
		end
	end
	Watcher_AuraEvent(frame)
	Watcher_SpellEvent(frame.BarWatcher)
	Watcher_SpellEvent(frame.IconWatcher)
end

local function Watcher_OnEvent(self, event, ...)
	if event == "PLAYER_LOGIN" or event == "PLAYER_SPECIALIZATION_CHANGED" then
		Watcher_Refresh(self)
	end

	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "GROUP_ROSTER_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE" or event == "CHARACTER_POINTS_CHANGED" then
		Watcher_AuraEvent(self)
		Watcher_SpellEvent(self.BarWatcher)
		Watcher_SpellEvent(self.IconWatcher)
		Watcher_SpellUpdateIcon(self.IconWatcher)
		Watcher_SpellActivation(self.IconWatcher)
	end

	if event == "PLAYER_TARGET_CHANGED" or event == "UNIT_AURA" then
		Watcher_AuraEvent(self)
	end
	
	if event == "SPELL_UPDATE_COOLDOWN" or event == "SPELL_UPDATE_USABLE" then
		Watcher_SpellEvent(self.BarWatcher)
		Watcher_SpellEvent(self.IconWatcher)
		Watcher_SpellUpdateIcon(self.IconWatcher)
	end

	if event == "SPELLS_CHANGED" then --icon change
		Watcher_SpellEvent(self.IconWatcher)
		Watcher_SpellUpdateIcon(self.IconWatcher)
	end

	if event == "SPELL_UPDATE_ICON" then
		Watcher_SpellUpdateIcon(self.IconWatcher)
	end

	if event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" or event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" then
		Watcher_SpellActivation(self.IconWatcher)
	end
end

local function Watcher_OnUpdate(self, elapsed, ...)
	Bar_Update(self.BarWatcher, elapsed, ...)
	Icon_Update(self.IconWatcher, elapsed, ...)
	Watcher_SpellUsable(self.IconWatcher)
end

local function FCS_Fade(frame)
	local ShowFrame = 0
	for i = 1, frame.Info.NumButton do
		if frame.Button[i] and frame.Button[i].Info then 
			if frame.Button[i].Info.ShowAura then
				ShowFrame = ShowFrame + frame.Button[i].Info.ShowAura
			end
			if frame.Button[i].Info.ShowSpell then
				ShowFrame = ShowFrame + frame.Button[i].Info.ShowSpell
			end
		end
	end
	if ShowFrame == 0 then
		frame: Hide()
	else
		frame: Show()
	end
end

local function FCS_OnEvent(self)
	self: RegisterEvent("PLAYER_LOGIN")
	self: RegisterEvent("PLAYER_ENTERING_WORLD")
	--self: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	self: RegisterEvent("PLAYER_TARGET_CHANGED")
	self: RegisterEvent("UNIT_AURA")
	self: RegisterEvent("SPELL_UPDATE_COOLDOWN")
	self: RegisterEvent("SPELLS_CHANGED") --icon changes
	self: RegisterEvent("SPELL_UPDATE_USABLE")
	self: RegisterEvent("SPELL_UPDATE_ICON")
	--self: RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
	--self: RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
	--self: RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
	--self: RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	self: RegisterEvent("PLAYER_REGEN_DISABLED")
	self: RegisterEvent("PLAYER_REGEN_ENABLED")
	self: RegisterEvent("PLAYER_TOTEM_UPDATE")
	self: SetScript("OnEvent", function(self, event, ...)
		Watcher_OnEvent(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" then
			if UnitAffectingCombat("player") or UnitExists("target") then
				self.BarWatcher:SetAlpha(1)
				self.IconWatcher:SetAlpha(1)
			else
				self.BarWatcher:SetAlpha(0.4)
				self.IconWatcher:SetAlpha(0.4)
			end
		end
		FCS_Fade(self.BarWatcher)
		FCS_Fade(self.IconWatcher)
	end)
end

local function FCS_OnUpdate(self)
	local Elapsed_Help = 0
	self: SetScript("OnUpdate", function(self, elapsed, ...)
		Elapsed_Help = Elapsed_Help + elapsed
		if (F.Last25H == 0) then
			Watcher_OnUpdate(self, Elapsed_Help, ...)
			Elapsed_Help = 0
		end
		if (F.Last5 == 0) then
			FCS_Fade(self.BarWatcher)
			FCS_Fade(self.IconWatcher)
		end
	end)
end

----------------------------------------------------------------
--> Load
----------------------------------------------------------------

local MEKA_FCS = CreateFrame("Frame", nil, E)
MEKA_FCS: SetSize(12,12)
MEKA_FCS: SetPoint("CENTER", UIParent, "CENTER", 0,0)
MEKA_FCS.Init = false
MEKA_FCS: Hide()

local function MEKA_FCS_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_FCS.Enable then
		FCS_BarWathcher(MEKA_FCS)
		FCS_IconWathcher(MEKA_FCS)

		Watcher_Refresh(MEKA_FCS)
		FCS_OnEvent(MEKA_FCS)
		FCS_OnUpdate(MEKA_FCS)

		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale then
			MEKA_FCS: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale)
		end

		MEKA_FCS.Init = true
		MEKA_FCS: Show()
	end
end

local function MEKA_FCS_Toggle(arg)
	if arg == "ON" then
		if not MEKA_FCS.Init then
			MEKA_FCS_Load()
		end
		MEKA_FCS: Show()
	elseif arg == "OFF" then
		MEKA_FCS: Hide()
	elseif arg == "REFRESH" then
		Watcher_Refresh(MEKA_FCS)
	elseif type(arg) == "number" then
		MEKA_FCS: SetScale(arg)
	end
end

local function MEKA_FCS_Refresh()
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_FCS.Enable and MEKA_FCS then
		Watcher_Refresh(MEKA_FCS)
	end
end

local MEKA_FCS_Config = {
	Database = {
		["MEKA_FCS"] = {
			Enable = true,
		},
	},

	Config = {
		Name = "MEKA "..L['FCS'],
		Type = "Switch", --Switch, Trigger, Blank, Dropdown
		Click = function(self, button)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_FCS.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_FCS.Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_FCS_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_FCS.Enable = true
				self.Text:SetText(L["ON"])
				MEKA_FCS_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_FCS.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = nil,
	},
}

MEKA_FCS.Load = MEKA_FCS_Load
MEKA_FCS.Config = MEKA_FCS_Config
F.MEKA_FCS_Toggle = MEKA_FCS_Toggle
tinsert(E.Module, MEKA_FCS)
tinsert(E.FCS_Refresh, MEKA_FCS_Refresh)