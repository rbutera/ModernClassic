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

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

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

local function Name_Color_Update(frame, denied)
	local eColor = {}
	if UnitIsPlayer(frame.Unit) then
		local eClass = select(2, UnitClass(frame.Unit))
		eColor = C.Color.Class[eClass] or C.Color.White
	else
		if denied and (not UnitPlayerControlled(frame.Unit) and UnitIsTapDenied(frame.Unit)) then
			eColor = C.Color.Denied
		else
			local red, green, blue, alpha = UnitSelectionColor(frame.Unit)
			eColor.r = red or 1
			eColor.g = green or 1
			eColor.b = blue or 1
			if eColor.r == 0 and eColor.g == 0 then
				eColor.r = 56/255
				eColor.g = 154/255
			end
		end
	end
	local name, realm = UnitName(frame.Unit)
	return format("%s%s|r", F.Hex(eColor),name)	
end

local function Create_Backdrop(f, i1,i2,i3,i4, c1,a1, c2,a2)
	local backdrop = {
		bgFile = F.Path("StatusBar\\Flat"), 
		edgeFile = F.Path("White"), 
		tile = false, tileSize = 0, edgeSize = e, 
		insets = { left = i1, right = i2, top = i3, bottom = i4 }
	}
	f: SetBackdrop(backdrop)
	f: SetBackdropColor(F.Color(c1, a1))
	f: SetBackdropBorderColor(F.Color(c2, a2))
end

local function Castbar1_Artwork(frame)
	local Bar1 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bar1"), C.Color.Main1, 1, {90,26}, {228/256,48/256,6/64,58/64})
	Bar1: SetPoint("LEFT", frame, "LEFT", 0, 0)

	local Bar2 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bar1"), C.Color.Main1, 1, {90,26}, {48/256,228/256,6/64,58/64})
	Bar2: SetPoint("LEFT", Bar1, "RIGHT", 0, 0)

	local Bg1 = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_Target_Bar1"), C.Color.Main0, 0.65, {90,26}, {228/256,48/256,6/64,58/64})
	Bg1: SetPoint("LEFT", frame, "LEFT", 0, 0)

	local Bg1G = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bar1"), C.Color.Main0, 0.5, {90,26}, {228/256,48/256,6/64,58/64})
	Bg1G: SetPoint("LEFT", frame, "LEFT", 0, 0)

	local Bg1_Sd = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bar1_Sd"), C.Color.Main0, 0.25, {90,26}, {228/256,48/256,6/64,58/64})
	Bg1_Sd: SetPoint("LEFT", frame, "LEFT", 0, 0)

	local Bg2 = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_Target_Bar1"), C.Color.Main0, 0.65, {90,26}, {48/256,228/256,6/64,58/64})
	Bg2: SetPoint("RIGHT", frame, "RIGHT", 0, 0)

	local Bg2G = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bar1"), C.Color.Main0, 0.5, {90,26}, {48/256,228/256,6/64,58/64})
	Bg2G: SetPoint("RIGHT", frame, "RIGHT", 0, 0)

	local Bg2_Sd = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bar1_Sd"), C.Color.Main0, 0.25, {90,26}, {88/256,228/256,6/64,58/64})
	Bg2_Sd: SetPoint("RIGHT", frame, "RIGHT", 0, 0)

	local Bd1 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bd3"), C.Color.Warn1, 1, {22,26}, {10/64,54/64,6/64,58/64})
	Bd1: SetPoint("LEFT", frame, "RIGHT", -4, 0)

	local Bd1_Sd = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bd3_Sd"), C.Color.Main0, 0.25, {22,26}, {10/64,54/64,6/64,58/64})
	Bd1_Sd: SetPoint("LEFT", frame, "RIGHT", -4, 0)

	local Bd2 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bd3"), C.Color.Warn1, 1, {22,26}, {54/64,10/64,6/64,58/64})
	Bd2: SetPoint("RIGHT", frame, "LEFT", 4, 0)

	local Bd2_Sd = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bd3_Sd"), C.Color.Main0, 0.25, {22,26}, {54/64,10/64,6/64,58/64})
	Bd2_Sd: SetPoint("RIGHT", frame, "LEFT", 4, 0)

	local Bd3 = F.Create.Texture(frame, "OVERLAY", 1, MEKA.Path("IFF_Target_Bd4"), C.Color.Main0, 0.9, {8,16}, {1,0,0,1})
	Bd3: SetPoint("LEFT", frame, "LEFT", 14, 0)

	local Bd4 = F.Create.Texture(frame, "OVERLAY", 1, MEKA.Path("IFF_Target_Bd4"), C.Color.Main0, 0.9, {8,16}, {0,1,0,1})
	Bd4: SetPoint("RIGHT", frame, "RIGHT", -14, 0)

	local Icon = F.Create.Texture(frame, "OVERLAY", 1, nil, nil, 1, {16,16}, {0.08,0.92,0.08,0.92})
	Icon: SetPoint("LEFT", frame, "LEFT", 26, 0)

	local Txt = F.Create.Font(frame, "OVERLAY", C.Font.Txt, 12, nil, nil, {{r=0,g=0,b=0},0}, {0,0}, "LEFT", "CENTER")
	Txt: SetSize(90,8)
	Txt: SetPoint("LEFT", Icon, "RIGHT", 4,-1)
	Txt: SetTextColor(F.Color(C.Color.Main0))

	local Num = F.Create.Font(frame, "OVERLAY", C.Font.NumSmall, 12, nil, nil, {{r=0,g=0,b=0},0}, {0,0}, "RIGHT", "CENTER")
	Num: SetPoint("RIGHT", frame, "RIGHT", -26,0)
	Num: SetTextColor(F.Color(C.Color.Main0))

	frame.Bar1 = Bar1
	frame.Bar2 = Bar2
	frame.Bg1 = Bg1
	frame.Bg2 = Bg2
	frame.Bd1 = Bd1
	frame.Bd2 = Bd2
	frame.Icon = Icon
	frame.Text = Txt
	frame.Num = Num
end

local function Castbar1_ColorUpdate(frame, color)
	frame.Bar1: SetVertexColor(F.Color(color))
	frame.Bar2: SetVertexColor(F.Color(color))
	frame.Bg1: SetVertexColor(F.Color(color))
	frame.Bg2: SetVertexColor(F.Color(color))
end

local function Castbar1_BarUpdate(frame, value)
	value = value or 0
	value = min(max(value, 0), 1)
	frame.Bar1: SetSize(6+84*value,26)
	frame.Bar1: SetTexCoord(228/256,(228-12-168*value)/256,6/64,58/64)
	frame.Bar2: SetSize(6+84*value,26)
	frame.Bar2: SetTexCoord((228-12-168*value)/256,228/256,6/64,58/64)
end

local function CastBar1_UnpdateNum(frame, blank)
	if blank then
		frame.Num: SetText("")
	else
		if frame.Channeling then
			frame.Num: SetText(F.FormatTime(frame.Value, 1))
		else
			frame.Num: SetText(F.FormatTime(frame.MaxValue-frame.Value, 1))
		end
	end
end

local function CastBar1_ApplyUpdate(frame, value)
	if value then
		Castbar1_BarUpdate(frame, value)
	end
	Castbar1_BarUpdate(frame, frame.Value/frame.MaxValue)
	CastBar1_UnpdateNum(frame, value)
	frame.Bd1: SetAlpha(0.4+0.6*F.Alpha4)
	frame.Bd2: SetAlpha(0.4+0.6*F.Alpha4)
end

local function CastBar1_ApplyAlpha(frame, alpha)
	frame: SetAlpha(alpha)
end

local CAST_COLOR = {
	Cast = C.Color.Blue,
	Shield = C.Color.Yellow,
	Stop = C.Color.Green,
	Fail = C.Color.Red,
}

local function CastBar1_ApplyColor(frame, state, notInterruptible)
	if state == "Start" then
		if notInterruptible then
			Castbar1_ColorUpdate(frame, CAST_COLOR.Shield)
			--PlayerCastBar_ColorNum(frame, CAST_COLOR.Shield)
		else
			Castbar1_ColorUpdate(frame, CAST_COLOR.Cast)
			--PlayerCastBar_ColorNum(frame, CAST_COLOR.Cast)
		end
	elseif state == "Finished" then
		Castbar1_ColorUpdate(frame, CAST_COLOR.Stop)
		--PlayerCastBar_ColorNum(frame, CAST_COLOR.Stop)
	elseif state == "Failed" then
		Castbar1_ColorUpdate(frame, CAST_COLOR.Fail)
		--PlayerCastBar_ColorNum(frame, CAST_COLOR.Fail)
	end
end

local function Castbar1_Create(frame)
	local CastBar = CreateFrame("frame", nil, frame)
	CastBar: SetSize(180,26)
	CastBar: SetPoint("BOTTOM", frame, "TOP", 0,6)

	Castbar1_Artwork(CastBar)

	CastBar.Unit = frame.Unit
	CastBar.EnableCastbar = true
	CastBar.ShowCastbar = true
	CastBar.ShowTradeSkills = true
	CastBar.ApplyUpdate = CastBar1_ApplyUpdate
	CastBar.ApplyAlpha = CastBar1_ApplyAlpha
	CastBar.ApplyColor = CastBar1_ApplyColor
	F.CastBar_Create(CastBar)

	CastBar: HookScript("OnShow", function(self)
		frame.Aura.SlideUp: Play()
	end)
	CastBar: HookScript("OnHide", function(self)
		frame.Aura.SlideDown: Play()
	end)

	frame.CastBar = CastBar
end

--- ------------------------------------------------------------
--> Target
--- ------------------------------------------------------------

local function Target_Name(frame)
	local Name = F.create_Font(frame, C.Font.Txt, 14, nil, 0, "LEFT")
	Name: SetSize(110,8)
	Name: SetPoint("TOPLEFT", frame, "TOPLEFT", 22,-12)
	Name: SetAlpha(1)

	local Level = F.create_Font(frame, C.Font.NumSmall, 12, nil, 0)
	Level: SetPoint("TOPLEFT", Name, "BOTTOMLEFT", -1,-6)
	Level: SetAlpha(1)

	local Num = F.create_Font(frame, C.Font.NumSmall, 12, nil, 0)
	Num: SetPoint("TOPLEFT", Level, "BOTTOMLEFT", -4,-4)
	Num: SetAlpha(1)

	frame.Name = Name
	frame.Level = Level
	frame.Num = Num
end

local function Target_Aura(frame)
	frame.Aura = CreateFrame("Frame", nil, frame, "MEKA_LoopHUD_AuraSlideTemplate")
	
	frame.Aura.size = 26
	frame.Aura.gap = 0
	frame.Aura.fontsize = 10
	frame.Aura.limit = 20
	frame.bufflimit = 10
	frame.debufflimit = 10
	frame.Aura.perline = 5
	frame.Aura.growthH = "RIGHT"
	frame.Aura.growthV = "TOP"
	frame.Aura.unit = frame.Unit
	frame.Aura.type = "Aura"
	frame.Aura.filter = nil
	
	frame.Aura: SetSize(frame.Aura.size*frame.Aura.perline, frame.Aura.size)
	frame.Aura: SetPoint("BOTTOM", frame, "TOP", 4,2)
	
	F.Aura_Create(frame.Aura)
end

local function Target_Artwork(frame)
	local Bg = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bg"), C.Color.Main0, 0.75, {137,62}, {119/512,393/512,2/128,126/128})
	Bg: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local BgGlow = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_Target_Bg"), C.Color.Main1, 0.15, {137,62}, {119/512,393/512,2/128,126/128})
	BgGlow: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd1 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bd1"), C.Color.Main1, 0.75, {137,62}, {119/512,393/512,2/128,126/128})
	Bd1: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd2 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bd2"), C.Color.Main1, 0.25, {137,62}, {119/512,393/512,2/128,126/128})
	Bd2: SetPoint("CENTER", frame, "CENTER", 0, 0)
end

local function Target_Event(frame, event, ...)
	if not UnitExists(frame.Unit) then return end
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "UNIT_FACTION" then
		local lColor = {}
		local level = UnitLevel(frame.Unit)
		local classification = UnitClassification(frame.Unit)
		if level then
			if level < 0 then
				level = "Boss"
			else
				level = format("Lv %s",level)
			end
			if classification == "elite" then
				level = format("%s Elite",level)
			elseif classification == "rare" then
				level = format("%s Rare",level)
			elseif classification == "rareelite" then
				level = format("%s RareElite",level)
			elseif classification == "worldboss" then
				level = format("%s WorldBoss",level)
			end
		end
		if classification == "elite" or classification == "rareelite" or classification == "worldboss" then
			lColor = C.Color.Y2
		elseif classification == "rare" then
			lColor = C.Color.W3
		else
			lColor = C.Color.B1
		end
		frame.Name: SetText(Name_Color_Update(frame, true))
		frame.Level: SetText(format("%s%s|r", F.Hex(lColor),level))
	end
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" or event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH"  or event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER" then
		local MinHealth,MaxHealth = UnitHealth(frame.Unit),UnitHealthMax(frame.Unit)
		local MinPower,MaxPower = UnitPower(frame.Unit),UnitPowerMax(frame.Unit)
		if MinHealth and MinPower then
			if UnitIsDeadOrGhost(frame.Unit) then
				frame.Num: SetText(format("%s%s|r %s%s|r", F.Hex(C.Color.R3),F.FormatNum(MaxHealth, 1),F.Hex(C.Color.B1),F.FormatNum(MaxPower, 1)))
			else
				frame.Num: SetText(format("%s%s|r %s%s|r", F.Hex(C.Color.R3),F.FormatNum(MinHealth, 1),F.Hex(C.Color.B1),F.FormatNum(MinPower, 1)))
			end
		end
	end
end

local function Target_OnEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterEvent("PLAYER_TARGET_CHANGED")
	frame: RegisterUnitEvent("UNIT_FACTION", "target")
	frame: RegisterUnitEvent("UNIT_HEALTH", "target")
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", "target")
	frame: RegisterUnitEvent("UNIT_POWER_UPDATE", "target")
	frame: RegisterUnitEvent("UNIT_MAXPOWER", "target")
	
	frame: SetScript("OnEvent", function(self, event, ...)
		Target_Event(self, event, ...)
	end)
end

local function Target_Frame(frame)
	local Target = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	Target.Unit = "target"
	Target: SetSize(137,62)
	Target: SetPoint("CENTER", frame, "CENTER", 506,-60)
	
	F.init_Unit(Target, Target.Unit, true)
	Target: SetScript("OnEnter", F.UnitFrame_OnEnter)
	Target: SetScript("OnLeave", F.UnitFrame_OnLeave)
	
	Target_Artwork(Target)
	Target_Name(Target)
	Target_Aura(Target)
	Castbar1_Create(Target)
	Target.CastBar: RegisterEvent("PLAYER_TARGET_CHANGED")
	
	Target_OnEvent(Target)

	frame.Target = Target
end

--- ------------------------------------------------------------
--> Target of Target
--- ------------------------------------------------------------

local function TargetTarget_Name(frame)
	local Name = F.create_Font(frame, C.Font.Txt, 12, nil, 0, "LEFT")
	Name: SetSize(110,8)
	Name: SetPoint("TOPLEFT", frame, "TOPLEFT", 22,-12)
	Name: SetAlpha(1)

	frame.Name = Name
end

local function TargetTarget_Artwork(frame)
	local Bg = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_ToT_Bg"), C.Color.Main0, 0.75, {143,42}, {113/512,399/512,22/128,106/128})
	Bg: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local BgGlow = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_ToT_Bg"), C.Color.Main1, 0.15, {143,42}, {113/512,399/512,22/128,106/128})
	BgGlow: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd1 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_ToT_Bd1"), C.Color.Main1, 0.75, {143,42}, {113/512,399/512,22/128,106/128})
	Bd1: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd2 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_ToT_Bd2"), C.Color.Main1, 0.25, {143,42}, {113/512,399/512,22/128,106/128})
	Bd2: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local HealthBar = F.create_StatusBar(frame, "StatusBar\\Flat")
	HealthBar: SetStatusBarColor(F.Color(C.Color.Main1))
	HealthBar: SetAlpha(1)
	HealthBar: SetFrameLevel(frame:GetFrameLevel()+2)
	HealthBar: SetSize(98,4)
	HealthBar: SetPoint("LEFT", frame, "LEFT", 20,-8)
	HealthBar: SetMinMaxValues(0, 1)
	HealthBar: SetValue(1)
	Create_Backdrop(HealthBar, 0,0,2,0, C.Color.Main1,0.5, C.Color.W3,0)

	local Vernier = frame: CreateTexture(nil, "ARTWORK")
	Vernier: SetTexture(F.Path("White"))
	Vernier: SetVertexColor(F.Color(C.Color.Main2))
	Vernier: SetSize(2, 3)
	Vernier: SetAlpha(0.9)
	Vernier: SetPoint("TOP", HealthBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0,-2)

	frame.HealthBar = HealthBar
end

local function TargetTarget_Update(frame)
	if UnitExists(frame.Unit) then
		if F.Last10 == 0 then
			frame.Name: SetText(Name_Color_Update(frame))
		end
		if F.Last25 == 0 then
			local minHealth,maxHealth = UnitHealth(frame.Unit),UnitHealthMax(frame.Unit)
			local percent = minHealth/(maxHealth+F.Debug)
			frame.HealthBar: SetValue(percent)
		end
	end
end

local function TargetTarget_OnUpdate(frame)
	frame: SetScript("OnUpdate", function(self, elapsed)
		TargetTarget_Update(self)
	end)
end

local function TargetTarget_Frame(frame)
	local TargetTarget = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	TargetTarget.Unit = "targettarget"
	TargetTarget: SetSize(143,42)
	TargetTarget: SetPoint("CENTER", frame, "CENTER", 496,-120)
	
	F.init_Unit(TargetTarget, TargetTarget.Unit, true)
	TargetTarget: SetScript("OnEnter", F.UnitFrame_OnEnter)
	TargetTarget: SetScript("OnLeave", F.UnitFrame_OnLeave)
	
	TargetTarget_Artwork(TargetTarget)
	TargetTarget_Name(TargetTarget)
	
	TargetTarget_OnUpdate(TargetTarget)

	frame.TargetTarget = TargetTarget
end

--- ------------------------------------------------------------
--> Focus
--- ------------------------------------------------------------

local function Focus_Aura(frame)
	frame.Aura = CreateFrame("Frame", nil, frame, "MEKA_LoopHUD_AuraSlideTemplate")
	
	frame.Aura.size = 26
	frame.Aura.gap = 0
	frame.Aura.fontsize = 10
	frame.Aura.limit = 20
	frame.bufflimit = 10
	frame.debufflimit = 10
	frame.Aura.perline = 5
	frame.Aura.growthH = "RIGHT"
	frame.Aura.growthV = "TOP"
	frame.Aura.unit = frame.Unit
	frame.Aura.type = "Aura"
	frame.Aura.filter = nil
	
	frame.Aura: SetSize(frame.Aura.size*frame.Aura.perline, frame.Aura.size)
	frame.Aura: SetPoint("BOTTOM", frame, "TOP", -4,2)
	
	F.Aura_Create(frame.Aura)
end

local function Focus_Name(frame)
	local Name = F.create_Font(frame, C.Font.Txt, 14, nil, 0, "LEFT")
	Name: SetSize(110,8)
	Name: SetPoint("TOPLEFT", frame, "TOPLEFT", 14,-12)
	Name: SetAlpha(1)
	
	frame.Name = Name
end

local function Focus_Artwork(frame)
	local Bg = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Target_Bg"), C.Color.Main0, 0.75, {137,62}, {393/512,119/512,2/128,126/128})
	Bg: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local BgGlow = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_Target_Bg"), C.Color.Main1, 0.15, {137,62}, {393/512,119/512,2/128,126/128})
	BgGlow: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd1 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bd1"), C.Color.Main1, 0.75, {137,62}, {393/512,119/512,2/128,126/128})
	Bd1: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd2 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_Target_Bd2"), C.Color.Main1, 0.25, {137,62}, {393/512,119/512,2/128,126/128})
	Bd2: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local HealthBar = F.create_StatusBar(frame, "StatusBar\\Flat")
	HealthBar: SetStatusBarColor(F.Color(C.Color.Main1))
	HealthBar: SetAlpha(1)
	HealthBar: SetFrameLevel(frame:GetFrameLevel()+2)
	HealthBar: SetSize(98,4)
	HealthBar: SetPoint("LEFT", frame, "LEFT", 18,-2)
	HealthBar: SetMinMaxValues(0, 1)
	HealthBar: SetValue(1)
	Create_Backdrop(HealthBar, 0,0,2,0, C.Color.Main1,0.5, C.Color.W3,0)

	local HealthBarVernier = frame: CreateTexture(nil, "ARTWORK")
	HealthBarVernier: SetTexture(F.Path("White"))
	HealthBarVernier: SetVertexColor(F.Color(C.Color.Main2))
	HealthBarVernier: SetSize(2, 3)
	HealthBarVernier: SetAlpha(0.9)
	HealthBarVernier: SetPoint("TOP", HealthBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0,-2)
	
	local PowerBar = F.create_StatusBar(frame, "StatusBar\\Flat")
	PowerBar: SetStatusBarColor(F.Color(C.Color.Main1))
	PowerBar: SetAlpha(1)
	PowerBar: SetFrameLevel(frame:GetFrameLevel()+2)
	PowerBar: SetSize(98,4)
	PowerBar: SetPoint("LEFT", HealthBar, "LEFT", 2,-14)
	PowerBar: SetMinMaxValues(0, 1)
	PowerBar: SetValue(1)
	Create_Backdrop(PowerBar, 0,0,2,0, C.Color.Main1,0.5, C.Color.W3,0)

	local PowerBarVernier = frame: CreateTexture(nil, "ARTWORK")
	PowerBarVernier: SetTexture(F.Path("White"))
	PowerBarVernier: SetVertexColor(F.Color(C.Color.Main2))
	PowerBarVernier: SetSize(2, 3)
	PowerBarVernier: SetAlpha(0.9)
	PowerBarVernier: SetPoint("TOP", PowerBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0,-2)

	frame.HealthBar = HealthBar
	frame.PowerBar = PowerBar
end

local function Focus_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_FOCUS_CHANGED" or event == "UNIT_FACTION" then
		if UnitExists(frame.Unit) then
			frame.Name: SetText(Name_Color_Update(frame, true))
		end
	end
	F.Smooth_Health(frame.Unit)
	F.Smooth_Power(frame.Unit)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_FOCUS_CHANGED" then
		E.Value[frame.Unit].Health.Cur = 0
		E.Value[frame.Unit].Power.Cur = 0
	end
end

local function Focus_OnEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterEvent("PLAYER_FOCUS_CHANGED")
	frame: RegisterUnitEvent("UNIT_FACTION", "focus")
	frame: RegisterUnitEvent("UNIT_HEALTH", "focus")
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", "focus")
	frame: RegisterUnitEvent("UNIT_POWER_UPDATE", "focus")
	frame: RegisterUnitEvent("UNIT_MAXPOWER", "focus")
	
	frame: SetScript("OnEvent", function(self, event, ...)
		Focus_Event(self, event, ...)
	end)
end

local function Focus_Update(f, elapsed)
	if UnitExists(f.Unit) then
		F.Smooth_Update(E.Value[f.Unit].Health)
		F.Smooth_Update(E.Value[f.Unit].Power)
		if F.Last25 == 0 then
			f.HealthBar: SetValue(E.Value[f.Unit].Health.Cur)
			--f.HPValue: SetText(F.FormatNum(E.Value[f.Unit].Health.Cur*E.Value[f.Unit].Health.Max, 2))
			f.PowerBar: SetValue(E.Value[f.Unit].Power.Cur)
			--f.PPValue: SetText(F.FormatNum(E.Value[f.Unit].Power.Cur*E.Value[f.Unit].Power.Max, 2))
		end
	end
end

local function Focus_OnUpdate(frame)
	frame: SetScript("OnUpdate", function(self, elapsed)
		Focus_Update(self, elapsed)
	end)
end

local function Focus_Frame(frame)
	local Focus = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	Focus.Unit = "focus"
	Focus: SetSize(137,62)
	Focus: SetPoint("CENTER", frame, "CENTER", -506,-60)
	--Focus: SetClampedToScreen(true)
	
	F.init_Unit(Focus, Focus.Unit, true)
	Focus: SetScript("OnEnter", F.UnitFrame_OnEnter)
	Focus: SetScript("OnLeave", F.UnitFrame_OnLeave)
	
	Focus_Artwork(Focus)
	Focus_Name(Focus)
	Focus_Aura(Focus)
	Castbar1_Create(Focus)
	Focus.CastBar: RegisterEvent("PLAYER_FOCUS_CHANGED")

	Focus_OnEvent(Focus)
	Focus_OnUpdate(Focus)

	frame.Focus = Focus
end

--- ------------------------------------------------------------
--> Target of Focus
--- ------------------------------------------------------------

local function FocusTarget_Name(frame)
	local Name = F.create_Font(frame, C.Font.Txt, 12, nil, 0, "LEFT")
	Name: SetSize(122,8)
	Name: SetPoint("TOPLEFT", frame, "TOPLEFT", 16,-12)
	Name: SetAlpha(1)

	frame.Name = Name
end

local function FocusTarget_Artwork(frame)
	local Bg = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_ToT_Bg"), C.Color.Main0, 0.75, {143,42}, {399/512,113/512,22/128,106/128})
	Bg: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local BgGlow = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_ToT_Bg"), C.Color.Main1, 0.15, {143,42}, {399/512,113/512,22/128,106/128})
	BgGlow: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd1 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_ToT_Bd1"), C.Color.Main1, 0.75, {143,42}, {399/512,113/512,22/128,106/128})
	Bd1: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local Bd2 = F.Create.Texture(frame, "ARTWORK", 1, MEKA.Path("IFF_ToT_Bd2"), C.Color.Main1, 0.25, {143,42}, {399/512,113/512,22/128,106/128})
	Bd2: SetPoint("CENTER", frame, "CENTER", 0, 0)

	local HealthBar = F.create_StatusBar(frame, "StatusBar\\Flat")
	HealthBar: SetStatusBarColor(F.Color(C.Color.Main1))
	HealthBar: SetAlpha(1)
	HealthBar: SetFrameLevel(frame:GetFrameLevel()+2)
	HealthBar: SetSize(98,4)
	HealthBar: SetPoint("LEFT", frame, "LEFT", 22,-8)
	HealthBar: SetMinMaxValues(0, 1)
	HealthBar: SetValue(1)
	Create_Backdrop(HealthBar, 0,0,2,0, C.Color.Main1,0.5, C.Color.W3,0)

	local Vernier = frame: CreateTexture(nil, "ARTWORK")
	Vernier: SetTexture(F.Path("White"))
	Vernier: SetVertexColor(F.Color(C.Color.Main2))
	Vernier: SetSize(2, 3)
	Vernier: SetAlpha(0.9)
	Vernier: SetPoint("TOP", HealthBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0,-2)

	frame.HealthBar = HealthBar
end

local function FocusTarget_Update(frame)
	if UnitExists(frame.Unit) then
		if F.Last10 == 0 then
			frame.Name: SetText(Name_Color_Update(frame))
		end
		if F.Last25 == 0 then
			local minHealth,maxHealth = UnitHealth(frame.Unit),UnitHealthMax(frame.Unit)
			local percent = minHealth/(maxHealth+F.Debug)
			frame.HealthBar: SetValue(percent)
		end
	end
end

local function FocusTarget_OnUpdate(frame)
	frame: SetScript("OnUpdate", function(self, elapsed)
		FocusTarget_Update(self)
	end)
end

local function FocusTarget_Frame(frame)
	local FocusTarget = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	FocusTarget.Unit = "focustarget"
	FocusTarget: SetSize(143,42)
	FocusTarget: SetPoint("CENTER", frame, "CENTER", -496,-120)
	FocusTarget.pauseUpdate = true
	
	F.init_Unit(FocusTarget, FocusTarget.Unit, true)
	FocusTarget: SetScript("OnEnter", F.UnitFrame_OnEnter)
	FocusTarget: SetScript("OnLeave", F.UnitFrame_OnLeave)
	
	FocusTarget_Artwork(FocusTarget)
	FocusTarget_Name(FocusTarget)
	
	FocusTarget_OnUpdate(FocusTarget)

	frame.FocusTarget = FocusTarget
end

--- ------------------------------------------------------------
--> Identification Friend of Foe
--- ------------------------------------------------------------

local MEKA_IFF = CreateFrame("Frame", "MEKA_IFF", E)
MEKA_IFF: SetSize(12,12)
MEKA_IFF: SetPoint("CENTER", UIParent, "CENTER", 0,0)
MEKA_IFF.Init = false

local function MEKA_IFF_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Enable then
		Target_Frame(MEKA_IFF)
		TargetTarget_Frame(MEKA_IFF)
		--Focus_Frame(MEKA_IFF)
		--FocusTarget_Frame(MEKA_IFF)

		if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Scale then
			MEKA_IFF: SetScale(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Scale)
		end

		MEKA_IFF.Target.Aura.bufflimit = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.BuffLimit or 10
		--MEKA_IFF.Focus.Aura.bufflimit = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.BuffLimit or 10
		MEKA_IFF.Target.Aura.debufflimit = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.DebuffLimit or 10
		--MEKA_IFF.Focus.Aura.debufflimit = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.DebuffLimit or 10

		MEKA_IFF.Init = true
	end
end

local function MEKA_IFF_Toggle(arg1, arg2)
	if arg1 == "ON" then
		if not MEKA_IFF.Init then
			MEKA_IFF_Load()
		end
		MEKA_IFF: Show()
		--MEKA_IFF.Mover: Show()
	elseif arg1 == "OFF" then
		MEKA_IFF: Hide()
		--MEKA_IFF.Mover: Hide()
	elseif type(arg1) == "number" then
		if arg2 == "SCALE" then
			MEKA_IFF: SetScale(arg1)
		elseif arg2 == "BUFF" then
			MEKA_IFF.Target.Aura.bufflimit = arg1
			--MEKA_IFF.Focus.Aura.bufflimit = arg1
		elseif arg2 == "DEBUFF" then
			MEKA_IFF.Target.Aura.debufflimit = arg1
			--MEKA_IFF.Focus.Aura.debufflimit = arg1
		end
	end
end

local MEKA_IFF_Config = {
	Database = {
		["MEKA_IFF"] = {
			["Enable"] = true,
			Scale = 1,
			BuffLimit = 12,
			DebuffLimit = 12,
		},
		["MEKA_Focus"] = {
			["PosX"] = -500,
			["PosY"] = 160,
		},
	},

	Config = {
		Name = "MEKA "..L['IFF'],
		Type = "Switch",
		Click = function(self, button)
			if InCombatLockdown() then return end
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_IFF_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Enable = true
				self.Text:SetText(L["ON"])
				MEKA_IFF_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['SCALE'],
                Type = "Slider",
				Click = nil,
                Load = function(self)
                    self.Slider: SetMinMaxValues(0.5, 2)
					self.Slider: SetValueStep(0.05)
                    self.Slider: SetValue(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Scale)
					self.Slider: HookScript("OnValueChanged", function(s, value)
                        value = floor(value*100+0.5)/100
						MEKA_IFF_Toggle(value, "SCALE")
                        Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.Scale = value
					end)
                end,
                Show = nil,
			},
			[2] = {
				Name = L['DEBUFF_LIMIT_NUM'],
                Type = "Slider",
				Click = nil,
                Load = function(self)
                    self.Slider: SetMinMaxValues(1, 40)
					self.Slider: SetValueStep(1)
                    self.Slider: SetValue(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.DebuffLimit)
					self.Slider: HookScript("OnValueChanged", function(s, value)
                        value = floor(value*100+0.5)/100
						MEKA_IFF_Toggle(value, "DEBUFF")
                        Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.DebuffLimit = value
					end)
                end,
                Show = nil,
			},
			[3] = {
				Name = L['BUFF_LIMIT_NUM'],
                Type = "Slider",
				Click = nil,
                Load = function(self)
                    self.Slider: SetMinMaxValues(1, 40)
					self.Slider: SetValueStep(1)
                    self.Slider: SetValue(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.BuffLimit)
					self.Slider: HookScript("OnValueChanged", function(s, value)
                        value = floor(value*100+0.5)/100
						MEKA_IFF_Toggle(value, "BUFF")
                        Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_IFF.BuffLimit = value
					end)
                end,
                Show = nil,
			},
		},
	},
}

MEKA_IFF.Load = MEKA_IFF_Load
MEKA_IFF.Config = MEKA_IFF_Config
tinsert(E.Module, MEKA_IFF)

--- ------------------------------------------------------------
--> Boss
--- ------------------------------------------------------------

local function Boss_Buff(frame)
	frame.Aura = CreateFrame("Frame", nil, frame)
	
	frame.Aura.size = 22
	frame.Aura.gap = 0
	frame.Aura.fontsize = 10
	frame.Aura.limit = 6
	frame.Aura.perline = 6
	frame.Aura.growthH = "LEFT"
	frame.Aura.growthV = "TOP"
	frame.Aura.unit = frame.Unit
	frame.Aura.type = "Boss"
	frame.Aura.filter = "HELPFUL"
	
	frame.Aura: SetSize(frame.Aura.size*frame.Aura.perline, frame.Aura.size)
	frame.Aura: SetPoint("TOPRIGHT", frame, "TOPLEFT", -14,0)
	
	F.Aura_Create(frame.Aura)
end

local function Boss_Debuff(frame)
	frame.Aura = CreateFrame("Frame", nil, frame)
	
	frame.Aura.size = 22
	frame.Aura.gap = 0
	frame.Aura.fontsize = 10
	frame.Aura.limit = 6
	frame.Aura.perline = 6
	frame.Aura.growthH = "LEFT"
	frame.Aura.growthV = "TOP"
	frame.Aura.unit = frame.Unit
	frame.Aura.type = "Boss"
	frame.Aura.filter = "HARMFUL"
	
	frame.Aura: SetSize(frame.Aura.size*frame.Aura.perline, frame.Aura.size)
	frame.Aura: SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", -14,0)
	
	F.Aura_Create(frame.Aura)
end

local function Boss_Name(frame)
	local Name = F.Create.Font(frame, "OVERLAY", C.Font.Txt, 10, nil, nil, {C.Color.Main0,0.9}, {1,1}, "LEFT", "CENTER")
	Name: SetSize(60,8)
	Name: SetPoint("LEFT", frame, "LEFT", 42,13)
	Name: SetAlpha(1)
	
	frame.Name = Name
end

local function Boss_Artwork(frame)
	local Bg1 = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Boss_Bg1"), C.Color.Main0, 0.5, {157,50}, {99/512,413/512,14/128,114/128})
	Bg1: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bg1Sd = F.Create.Texture(frame, "BACKGROUND", 1, MEKA.Path("IFF_Boss_Bg1_Sd"), C.Color.Main0, 0.25, {157,50}, {99/512,413/512,14/128,114/128})
	Bg1Sd: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Indicator = F.Create.Texture(frame, "ARTOWRK", 1, MEKA.Path("IFF_Boss_Bd1"), C.Color.Main1, 0.25, {19,20}, {13/64,51/64,12/64,52/64})
	Indicator: SetPoint("RIGHT", frame, "RIGHT", -7,0)

	local HealthBar = F.Create.Texture(frame, "ARTOWRK", 1, MEKA.Path("IFF_Boss_Bar1"), C.Color.Main1, 0.9, {142,16}, {114/512,398/512,0,1})
	HealthBar: SetPoint("BOTTOMLEFT", frame, "LEFT", 8,1)

	local HealthBarBg = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_Boss_Bar1"), C.Color.Main1, 0.25, {142,16}, {114/512,398/512,0,1})
	HealthBarBg: SetPoint("BOTTOMLEFT", frame, "LEFT", 8,1)

	local PowerBar = F.Create.Texture(frame, "ARTOWRK", 1, MEKA.Path("IFF_Boss_Bar1"), C.Color.Main1, 0.9, {142,16}, {114/512,398/512,1,0})
	PowerBar: SetPoint("TOPLEFT", frame, "LEFT", 8,-1)

	local PowerBarBg = F.Create.Texture(frame, "BORDER", 1, MEKA.Path("IFF_Boss_Bar1"), C.Color.Main1, 0.25, {142,16}, {114/512,398/512,1,0})
	PowerBarBg: SetPoint("TOPLEFT", frame, "LEFT", 8,-1)

	local Percent = F.Create.Font(frame, "OVERLAY", C.Font.NumOW, 20, nil, nil, {C.Color.Main0,0.9}, {1,1}, "CENTER", "CENTER")
	Percent: SetPoint("CENTER", frame, "LEFT", 21, 0)

	frame.HealthBar = HealthBar
	frame.PowerBar = PowerBar
	frame.Percent = Percent
	frame.Indicator = Indicator
end

local function Boss_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT" or event == "UNIT_TARGETABLE_CHANGED" or event == "UNIT_FACTION" then
		if UnitExists(frame.Unit) then
			frame.Name: SetText(Name_Color_Update(frame, true))
		end
	end
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TARGET_CHANGED" then
		if UnitIsUnit(frame.Unit, "target") then
			frame.Indicator: SetVertexColor(F.Color(C.Color.Warn1))
			frame.Indicator: SetAlpha(0.9)
		else
			frame.Indicator: SetVertexColor(F.Color(C.Color.Main1))
			frame.Indicator: SetAlpha(0.25)
		end
	end

	local MinHealth, MaxHealth, PerHealth = UnitHealth(frame.Unit), UnitHealthMax(frame.Unit)
	local MinPower, MaxPower, PerPower = UnitPower(frame.Unit), UnitPowerMax(frame.Unit)
	if MinHealth == 0 or MaxHealth == 0 then
		PerHealth = 0
	else
		PerHealth = floor(MinHealth/MaxHealth*1e4)/1e4
	end
	if MinPower == 0 or MaxPower == 0 then
		PerPower = 0
	else
		PerPower = floor(MinPower/MaxPower*1e4)/1e4
	end

	frame.HealthBar: SetSize(1+140*PerHealth,16)
	frame.HealthBar: SetTexCoord(114/512,(116+280*PerHealth)/512,0,1)
	frame.PowerBar: SetSize(1+140*PerPower,16)
	frame.PowerBar: SetTexCoord(114/512,(116+280*PerPower)/512,1,0)
	if PerHealth > 0.2 then
		frame.Percent: SetText(F.Hex(C.Color.Main1)..F.FormatPercent(PerHealth).."|r")
	else
		frame.Percent: SetText(F.Hex(C.Color.Warn1)..F.FormatPercent(PerHealth).."|r")
	end
end

local function Boss_OnEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	frame: RegisterEvent("UNIT_TARGETABLE_CHANGED")
	frame: RegisterEvent("PLAYER_TARGET_CHANGED")
	frame: RegisterUnitEvent("UNIT_FACTION", frame.Unit)
	frame: RegisterUnitEvent("UNIT_HEALTH", frame.Unit)
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", frame.Unit)
	frame: RegisterUnitEvent("UNIT_POWER_UPDATE", frame.Unit)
	frame: RegisterUnitEvent("UNIT_MAXPOWER", frame.Unit)
	frame: SetScript("OnEvent", function(self, event, ...)
		Boss_Event(self, event, ...)
	end)
end

local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES or 5

local MEKA_BossFrame = CreateFrame("Frame", "MEKA_BossFrame", E)
MEKA_BossFrame: SetSize(157, 300)
MEKA_BossFrame.Init = false

local function MEKA_BossFrame_Joystick_Update(self, elapsed)
	local x2 = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.PosX
	local y2 = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.PosY
	local x0,y0 = MEKA_BossFrame: GetCenter()
	local x1,y1 = self: GetCenter()
	local step = floor(1/(GetFramerate())*1e3)/1e3
	if x0 ~= x1 then
		x2 = x2 + (x1-x0)*step/2
	end
	if y0 ~= y1 then
		y2 = y2 + (y1-y0)*step/2
	end
	MEKA_BossFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT",x2, y2)
	Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.PosX = x2
	Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.PosY = y2
end

local function MEKA_BossFrame_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.Enable then
		MEKA_BossFrame: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.PosX,Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.PosY)

		F.CreateJoystick(MEKA_BossFrame, 142, 270+10*4, "MEKA "..L['BOSS_FRAME'])
		MEKA_BossFrame.Joystick.postUpdate = MEKA_BossFrame_Joystick_Update

		local Boss = {}
		for i = 1,MAX_BOSS_FRAMES do
			Boss[i] = CreateFrame("Button", "MEKA_BossFrame_Boss"..i, MEKA_BossFrame, "SecureUnitButtonTemplate")
			Boss[i].Unit = "boss"..i
			Boss[i]: SetSize(157,50)
			if i == 1 then
				Boss[i]: SetPoint("TOP", MEKA_BossFrame, "TOP", 0,0)
			else
				Boss[i]: SetPoint("TOP", Boss[i-1], "BOTTOM", 0,-10)
			end

			F.init_Unit(Boss[i], Boss[i].Unit, true)
			Boss[i]: SetScript("OnEnter", F.UnitFrame_OnEnter)
			Boss[i]: SetScript("OnLeave", F.UnitFrame_OnLeave)

			Boss_Artwork(Boss[i])
			Boss_Name(Boss[i])
			Boss_Buff(Boss[i])
			Boss_Debuff(Boss[i])

			Boss_OnEvent(Boss[i])

			MEKA_BossFrame["Boss"..i] = Boss[i]
		end
		MEKA_BossFrame.Init = true
	end
end

local function MEKA_BossFrame_Toggle(arg)
	if arg == "ON" then
		if not MEKA_BossFrame.Init then
			MEKA_BossFrame_Load()
		end
		MEKA_BossFrame: Show()
		MEKA_BossFrame.Mover: Show()
	elseif arg == "OFF" then
		MEKA_BossFrame: Hide()
		MEKA_BossFrame.Mover: Hide()
	end
end

local MEKA_BossFrame_Config = {
	Database = {
		["MEKA_BossFrame"] = {
			["Enable"] = true,
			["PosX"] = -340,
			["PosY"] = -100,
		},
	},

	Config = {
		Name = "MEKA "..L['BOSS_FRAME'],
		Type = "Switch", --Switch, Trigger, Blank, Dropdown
		Click = function(self, button)
			if InCombatLockdown() then return end
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.Enable = false
				self.Text:SetText(L["OFF"])
				MEKA_BossFrame_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.Enable = true
				self.Text:SetText(L["ON"])
				MEKA_BossFrame_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_BossFrame.Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = nil,
	},
}

MEKA_BossFrame.Load = MEKA_BossFrame_Load
MEKA_BossFrame.Config = MEKA_BossFrame_Config
tinsert(E.Module, MEKA_BossFrame)
