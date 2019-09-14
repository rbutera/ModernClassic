local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

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

local GetTime = GetTime

----------------------------------------------------------------
--> API and Variable
----------------------------------------------------------------

local Icon_Class = {
	["WARRIOR"]			= {  0/128, 32/128,   0/128, 32/128},
	["MAGE"]			= { 32/128, 64/128,   0/128, 32/128},
	["ROGUE"]			= { 64/128, 96/128,   0/128, 32/128},
	["DRUID"]			= { 96/128,128/128,   0/128, 32/128},
	["HUNTER"]			= {  0/128, 32/128,  32/128, 64/128},
	["DEATHKNIGHT"]		= { 32/128, 64/128,  32/128, 64/128},
	["PRIEST"]			= { 64/128, 96/128,  32/128, 64/128},
	["WARLOCK"]			= { 96/128,128/128,  32/128, 64/128},
	["PALADIN"]			= {  0/128, 32/128,  64/128, 96/128},
	["SHAMAN"]			= { 32/128, 64/128,  64/128, 96/128},
	["MONK"]			= { 64/128, 96/128,  64/128, 96/128},
	["DEMONHUNTER"]		= { 96/128,128/128,  64/128, 96/128},
}

local function Name_Color_Update(frame, unit)
	local eColor = {}
	if UnitIsPlayer(unit) then
		local eClass = select(2, UnitClass(unit))
		eColor = C.Color.Class[eClass] or C.Color.White
	else
		local red, green, blue, alpha = UnitSelectionColor(unit)
		eColor.r = red or 1
		eColor.g = green or 1
		eColor.b = blue or 1
	end
	local name, realm = UnitName(unit)
	return F.Hex(eColor)..name.."|r"
end

local function GroupRoleIndicator_Update(frame, event)
	if F.IsClassic then
		frame.GroupRoleIndicator:Hide()
		return
	end
	local role = UnitGroupRolesAssigned(frame.Unit) --TANK, HEALER, DAMAGER, NONE
	if(role == 'TANK' or role == 'HEALER' or role == 'DAMAGER') then
		frame.GroupRoleIndicator:SetTexCoord(GetTexCoordsForRoleSmallCircle(role))
		frame.GroupRoleIndicator:Show()
	else
		frame.GroupRoleIndicator:Hide()
	end
end

local function ReadyCheckIndicator_Update(frame)
	if (not frame.ReadyCheckIndicator or frame.ReadyCheckDecay and GetReadyCheckTimeLeft() <= 0) then
		return
	end
	local status = GetReadyCheckStatus(frame.Unit)
	frame.ReadyCheckStatus = status
	if (status == "ready") then
		frame.ReadyCheckIndicator:SetTexture(F.Path("ReadyCheck_Ready"))
		frame.ReadyCheckIndicator:Show()
	elseif (status == "notready") then
		frame.ReadyCheckIndicator:SetTexture(F.Path("ReadyCheck_NotReady"))
		frame.ReadyCheckIndicator:Show()
	elseif (status == "waiting" ) then
		frame.ReadyCheckIndicator:SetTexture(F.Path("ReadyCheck_Waiting"))
		frame.ReadyCheckIndicator:Show()
	else
		frame.ReadyCheckIndicator:Hide()
	end
end

local function ReadyCheckIndicator_Finish(frame)
	if (not frame.ReadyCheckIndicator) then return end
	if ( frame:IsVisible() ) then
		frame.ReadyCheckDecay = CUF_READY_CHECK_DECAY_TIME

		if (frame.ReadyCheckStatus == "waiting") then
			frame.ReadyCheckIndicator: SetTexture(F.Path("ReadyCheck_NotReady"))
			frame.ReadyCheckIndicator: Show()
		end
	else
		ReadyCheckIndicator_Update(frame)
	end
end

local function ReadyCheckIndicator_Decay(frame, elapsed)
	if (frame.ReadyCheckDecay) then
		if (frame.ReadyCheckDecay > 0) then
			frame.ReadyCheckDecay = frame.ReadyCheckDecay - elapsed
		else
			frame.ReadyCheckDecay = nil
			ReadyCheckIndicator_Update(frame)
		end
	end
end

local function InRange_Update(frame)
	local inRange, checkedRange = UnitInRange(frame.DisplayedUnit);
	if ( checkedRange and not inRange ) then	--If we weren't able to check the range for some reason, we'll just treat them as in-range (for example, enemy units)
		frame:SetAlpha(0.55);
	else
		frame:SetAlpha(1);
	end
end

local function UnitFrame_UpdateUnitEvents(frame)
	local unit = frame.Unit;
	local displayedUnit;
	if ( unit ~= frame.DisplayedUnit ) then
		displayedUnit = frame.DisplayedUnit;
	end
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_HEALTH", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_HEALTH_FREQUENT", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_MAXPOWER", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_POWER_UPDATE", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_AURA", unit, displayedUnit);
	if not F.IsClassic then
		frame: RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", unit, displayedUnit);
		frame: RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE", unit, displayedUnit);
		frame: RegisterUnitEvent("UNIT_HEAL_PREDICTION", unit, displayedUnit);
	end
	frame: RegisterUnitEvent("PLAYER_FLAGS_CHANGED", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_CLASSIFICATION_CHANGED", unit, displayedUnit);
end

local function InVehicle_Update(frame)
	local shouldTargetVehicle = UnitHasVehicleUI(frame.Unit);
	local unitVehicleToken;

	if ( shouldTargetVehicle ) then
		local raidID = UnitInRaid(frame.Unit);
		if ( raidID and not UnitTargetsVehicleInRaidUI(frame.Unit) ) then
			shouldTargetVehicle = false;
		end
	end

	if ( shouldTargetVehicle ) then
		local prefix, id, suffix = string.match(frame.Unit, "([^%d]+)([%d]*)(.*)")
		unitVehicleToken = prefix.."pet"..id..suffix;
		if ( not UnitExists(unitVehicleToken) ) then
			shouldTargetVehicle = false;
		end
	end

	if ( shouldTargetVehicle ) then
		if ( not frame.HasValidVehicleDisplay ) then
			frame.HasValidVehicleDisplay = true;
			frame.DisplayedUnit = unitVehicleToken;
			UnitFrame_UpdateUnitEvents(frame);
		end
	else
		if ( frame.HasValidVehicleDisplay ) then
			frame.HasValidVehicleDisplay = false;
			frame.DisplayedUnit = frame.Unit;
			UnitFrame_UpdateUnitEvents(frame);
		end
	end
end

local function RaidTargetIndicator_Update(frame)
	local index = GetRaidTargetIndex(frame.Unit)
	if index then
		SetRaidTargetIconTexture(frame.RaidTargetIndicator, index)
		frame.RaidTargetIndicator: Show()
	else
		frame.RaidTargetIndicator: Hide()
	end
end

local function GroupLeaderIndicator_Update(frame)
	if (not frame.GroupLeaderIndicator) then return end
	local IsLeader = UnitIsGroupLeader(frame.Unit)
	local IsAssistant = UnitIsGroupAssistant(frame.Unit)
	if IsLeader then
		frame.GroupLeaderIndicator: SetTexture(F.Path("Raid_Leader"))
		frame.GroupLeaderIndicator: Show()
	elseif IsAssistant then
		frame.GroupLeaderIndicator: SetTexture(F.Path("Raid_Assistant"))
		frame.GroupLeaderIndicator: Show()
	else
		frame.GroupLeaderIndicator: Hide()
	end
end

local function CenterStatusIcon_Update(frame)
	if (not frame.CenterStatusIcon) then return end
	if (UnitInOtherParty(frame.Unit)) then
		frame.CenterStatusIcon: SetTexture(F.Path("Raid_Phasing"))
		frame.CenterStatusIcon: Show()
	elseif (UnitHasIncomingResurrection(frame.Unit)) then
		frame.CenterStatusIcon: SetTexture(F.Path("Raid_Resurrect"))
		frame.CenterStatusIcon: Show()
	elseif (not F.IsClassic) and (C_IncomingSummon.HasIncomingSummon(frame.Unit)) then
		local status = C_IncomingSummon.IncomingSummonStatus(frame.Unit)
		if(status == Enum.SummonStatus.Pending) then
			frame.centerStatusIcon: SetAtlas("Raid-Icon-SummonPending")
			frame.centerStatusIcon: Show()
		elseif( status == Enum.SummonStatus.Accepted ) then
			frame.centerStatusIcon: SetAtlas("Raid-Icon-SummonAccepted")
			frame.centerStatusIcon: Show()
		elseif( status == Enum.SummonStatus.Declined ) then
			frame.centerStatusIcon: SetAtlas("Raid-Icon-SummonDeclined")
			frame.centerStatusIcon: Show()
		end
	elseif (not F.IsClassic) and (not UnitInPhase(frame.Unit) or UnitIsWarModePhased(frame.Unit)) then
		frame.CenterStatusIcon: SetTexture(F.Path("Raid_Phasing"))
		frame.CenterStatusIcon: Show()
	else
		frame.CenterStatusIcon: Hide()
	end
end

----------------------------------------------------------------
--> Raid5
----------------------------------------------------------------

local function Raid5_Debuff(frame, unit)
	local Aura = CreateFrame("Frame", nil, frame)
	
	Aura.size = 24
	Aura.gap = 0
	Aura.fontsize = 12
	Aura.limit = 8
	Aura.perline = 4
	Aura.growthH = "RIGHT"
	Aura.growthV = "BOTTOM"
	Aura.unit = unit
	Aura.filter = "HARMFUL"
	
	Aura: SetSize(Aura.size*Aura.perline, Aura.size)
	Aura: SetPoint("TOP", frame, "BOTTOM", 0,-2)
	F.Aura_Template(Aura)

	return Aura
end

local function Raid5_Buff(frame, unit)
	local Aura = CreateFrame("Frame", nil, frame)
	
	Aura.size = 24
	Aura.gap = 0
	Aura.fontsize = 12
	Aura.limit = 8
	Aura.perline = 4
	Aura.growthH = "RIGHT"
	Aura.growthV = "TOP"
	Aura.unit = unit
	Aura.filter = "RAID HELPFUL"
	
	Aura: SetSize(Aura.size*Aura.perline, Aura.size)
	Aura: SetPoint("BOTTOM", frame, "TOP", 0,2)
	F.Aura_Template(Aura)

	return Aura
end

local function RaidName_Update(self, unit)
	local name = UnitName(unit) or "???"
	self.Name: SetText(name)
end

local function Raid5Button_BarUpdate(bar, value)
	if not value then return end
	value = min(1, max(F.Debug, value))
	bar: SetSize(100*value, 50)
	bar: SetTexCoord(78/256,(78+100*value)/256, 7/64,57/64)
end

local function Raid5_Health_Update(self, unit)
	local minHealth = UnitHealth(unit)
	local maxHealth = UnitHealthMax(unit)
	if minHealth and maxHealth and maxHealth > 0 then
		Raid5Button_BarUpdate(self.HpBar, minHealth/maxHealth)
		--[[
		self.Bar2: SetValue(minHealth)
		self.Bar3: SetValue(minHealth)
		local d = minHealth/maxHealth
		local r,g,b
		if d == 1 then
			r = 10/255
			g = 10/255
		else
			r = 254/255
			g = (10+200*d)/255
		end
		self.Bar2: SetStatusBarColor(r, g, 10/255)
		self.Bar3: SetStatusBarColor(r, g, 10/255)
		--]]
	end
end

local function Raid5_MaxHealth_Update(self, unit)
	--local maxHealth = UnitHealthMax(unit)
	--if maxHealth then
	--	self.Bar2: SetMinMaxValues(0, maxHealth)
	--	self.Bar3: SetMinMaxValues(0, maxHealth)
	--end
end

local function Raid5_Power_Update(self, unit)
	local minPower = UnitPower(unit)
	local maxPower = UnitPowerMax(unit)
	if minPower then
		Raid5Button_BarUpdate(self.PpBar, minPower/maxPower)
		--self.Bar1: SetValue(minPower)
	end
end

local function Raid5_MaxPower_Update(self, unit)
	--local maxPower = UnitPowerMax(unit)
	--if maxPower then
	--	self.Bar1: SetMinMaxValues(0, maxPower)
	--end
end

local function Raid5_ClassColor_Update(self, unit)
	local eColor = {}
	if ( not UnitIsConnected(unit) ) then
		eColor = {r = 0.5, g = 0.5, b = 0.5}
	elseif UnitIsPlayer(unit) then
		local eClass = select(2, UnitClass(unit))
		eColor = C.Color.Class[eClass] or C.Color.White
	else
		local red, green, blue, alpha = UnitSelectionColor(unit)
		eColor.r = red or 1
		eColor.g = green or 1
		eColor.b = blue or 1
		if eColor.r == 0 and eColor.g == 0 then
			eColor.r = 56/255
			eColor.g = 154/255
		end
	end
	--self.Bar1: SetStatusBarColor(F.Color(eColor))
	--self.Bar1: SetBackdropColor(F.Color(eColor, 0.6))

	self.HpBar: SetVertexColor(F.Color(eColor))
	self.PpBar: SetVertexColor(F.Color(eColor))
end

local function Raid5Button_UpdateAll(frame)
	if not F.IsClassic then
		InVehicle_Update(frame)
	end
	RaidName_Update(frame, frame.DisplayedUnit)
	Raid5_ClassColor_Update(frame, frame.DisplayedUnit)
	Raid5_MaxHealth_Update(frame, frame.DisplayedUnit)
	Raid5_Health_Update(frame, frame.DisplayedUnit)
	Raid5_MaxPower_Update(frame, frame.DisplayedUnit)
	Raid5_Power_Update(frame, frame.DisplayedUnit)
	GroupRoleIndicator_Update(frame)
	ReadyCheckIndicator_Update(frame)
	RaidTargetIndicator_Update(frame)
	GroupLeaderIndicator_Update(frame)
	CenterStatusIcon_Update(frame)
	frame.Buff.unit = frame.DisplayedUnit
	frame.Debuff.unit = frame.DisplayedUnit
	frame.Buff:AuraOnEvent()
	frame.Debuff:AuraOnEvent()
end

local function Raid5Button_OnEvent(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		Raid5Button_UpdateAll(self)
	elseif event == "UNIT_NAME_UPDATE" then
		RaidName_Update(self, self.DisplayedUnit)
	elseif event == "GROUP_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED" or event == "UNIT_CONNECTION" then
		Raid5Button_UpdateAll(self)
		GroupLeaderIndicator_Update(self)
	elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" then
		Raid5Button_UpdateAll(self)
	elseif event == "UNIT_HEALTH_FREQUENT" then
		Raid5_Health_Update(self, self.DisplayedUnit)
	elseif event == "UNIT_MAXHEALTH" then
		Raid5_MaxHealth_Update(self, self.DisplayedUnit)
		Raid5_Health_Update(self, self.DisplayedUnit)
	elseif event == "UNIT_POWER_UPDATE" then
		Raid5_Power_Update(self, self.DisplayedUnit)
	elseif event == "UNIT_MAXPOWER" then
		Raid5_MaxPower_Update(self, self.DisplayedUnit)
		Raid5_Power_Update(self, self.DisplayedUnit)
	elseif event == "PLAYER_ROLES_ASSIGNED" then
		GroupRoleIndicator_Update(self)
	elseif event == "UNIT_AURA" then
		self.Buff:AuraOnEvent()
		self.Debuff:AuraOnEvent()
	elseif ( event == "READY_CHECK" ) then
		ReadyCheckIndicator_Update(self);
	elseif ( event == "READY_CHECK_FINISHED" ) then
		ReadyCheckIndicator_Finish(self)
	elseif ( event == "READY_CHECK_CONFIRM" ) then
		ReadyCheckIndicator_Update(self);
	elseif (event == "RAID_TARGET_UPDATE") then
		RaidTargetIndicator_Update(self)
	elseif (event == "INCOMING_RESURRECT_CHANGED") then
		CenterStatusIcon_Update(self)
	elseif (event == "UNIT_OTHER_PARTY_CHANGED") then
		CenterStatusIcon_Update(self)
	elseif (event == "UNIT_PHASE" or event == "UNIT_FLAGS") then
		CenterStatusIcon_Update(self)
	elseif (event == "INCOMING_SUMMON_CHANGED") then
		CenterStatusIcon_Update(self)
	end
end

local function Raid5Button_OnShow(self)
	Raid5Button_OnEvent(self, "PLAYER_ENTERING_WORLD")
end

local function Raid5Button_RgEvent(frame)
	frame: RegisterEvent('PLAYER_ENTERING_WORLD')

	frame: RegisterEvent('GROUP_ROSTER_UPDATE')
	frame: RegisterEvent("PARTY_LEADER_CHANGED")
	frame: RegisterEvent("PLAYER_ROLES_ASSIGNED")
	frame: RegisterEvent('PARTY_MEMBER_ENABLE')
	frame: RegisterEvent('PARTY_MEMBER_DISABLE')
	frame: RegisterEvent('UNIT_OTHER_PARTY_CHANGED')
	frame: RegisterEvent('UNIT_CONNECTION')

	frame: RegisterUnitEvent("UNIT_NAME_UPDATE", frame.Unit)

	frame: RegisterEvent("READY_CHECK")
	frame: RegisterEvent("READY_CHECK_FINISHED")
	frame: RegisterEvent("READY_CHECK_CONFIRM")
	frame: RegisterEvent("RAID_TARGET_UPDATE")

	frame: RegisterUnitEvent("UNIT_PHASE", frame.Unit)
	frame: RegisterUnitEvent("UNIT_FLAGS", frame.Unit)
	frame: RegisterUnitEvent("INCOMING_RESURRECT_CHANGED", frame.Unit)
	frame: RegisterUnitEvent("UNIT_OTHER_PARTY_CHANGED", frame.Unit)

	if not F.IsClassic then
		frame: RegisterEvent('UNIT_ENTERED_VEHICLE')
		frame: RegisterEvent('UNIT_EXITED_VEHICLE')
		frame: RegisterUnitEvent("INCOMING_SUMMON_CHANGED", frame.Unit)
	end

	UnitFrame_UpdateUnitEvents(frame)
end

local function Raid5Button_OnUpdate(frame, elapsed)
	ReadyCheckIndicator_Decay(frame, elapsed)
	InRange_Update(frame)
end

local function Raid5Button_Template(frame, unit)
	local button = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	button: SetSize(100,50)
	button.Unit = unit
	button.DisplayedUnit = unit

	F.init_Unit(button, button.Unit, true)
	button: SetScript("OnEnter", F.UnitFrame_OnEnter)
	button: SetScript("OnLeave", F.UnitFrame_OnLeave)

	local HpBar = F.Create.Texture(button, "ARTWORK", 1, F.Path("Party\\Raid_H"), nil, 0.9, {100,50}, {78/256,178/256, 7/64,57/64})
	HpBar: SetPoint("LEFT", button, "LEFT", 0,0)

	local HpBarBg = F.Create.Texture(button, "BORDER", 1, F.Path("Party\\Raid_H"), C.Color.W2, 0.5, {100,50}, {78/256,178/256, 7/64,57/64})
	HpBarBg: SetPoint("LEFT", button, "LEFT", 0,0)

	local PpBar = F.Create.Texture(button, "ARTWORK", 1, F.Path("Party\\Raid_P"), nil, 0.9, {100,50}, {78/256,178/256, 7/64,57/64})
	PpBar: SetPoint("LEFT", button, "LEFT", 0,0)

	local PpBarBg = F.Create.Texture(button, "BORDER", 1, F.Path("Party\\Raid_P"), C.Color.W2, 0.5, {100,50}, {78/256,178/256, 7/64,57/64})
	PpBarBg: SetPoint("LEFT", button, "LEFT", 0,0)

	local Bar1 = CreateFrame("StatusBar", nil, button)
	Bar1: SetStatusBarTexture(F.Path("StatusBar\\Raid"), "ARTWORK")
	Bar1: SetSize(100,4)
	Bar1: SetPoint("CENTER")
	Bar1: SetBackdrop({ 
		bgFile = F.Path("StatusBar\\Raid"), 
		edgeFile = "", tile = false, tileSize = 0, edgeSize = 0, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})

	local Bar2 = CreateFrame("StatusBar", nil, button)
	Bar2: SetStatusBarTexture(F.Path("StatusBar\\Raid"), "ARTWORK")
	Bar2: SetSize(100,20)
	Bar2: SetPoint("TOPLEFT")

	local Bar3 = CreateFrame("StatusBar", nil, button)
	Bar3: SetStatusBarTexture(F.Path("StatusBar\\Raid"), "ARTWORK")
	Bar3: SetSize(100,20)
	Bar3: SetPoint("BOTTOMLEFT")

	local Bg = F.Create.Texture(button, "BACKGROUND", 1, F.Path("StatusBar\\Raid"), C.Color.Main0, 0.6)
	Bg: SetAllPoints(button)

	local Help = CreateFrame("Frame", nil, button)
	Help: SetFrameLevel(button:GetFrameLevel()+2)

	local Name = F.Create.Font(Help, "BORDER", C.Font.Txt, 12, nil, C.Color.W3, {C.Color.Main0}, {1,-1}, "CENTER", "CENTER")
	Name: SetSize(100,10)
	--Name: SetPoint("CENTER", button, "CENTER", 0, 13)
	Name: SetPoint("CENTER", button, "CENTER", 0,0)

	local NameBg = F.Create.Texture(Help, "BACKGROUND", 1, F.Path("StatusBar\\Raid"), C.Color.Main0, 0.3, {100,20})
	NameBg: SetPoint("CENTER", button, "CENTER")

	local Text = F.Create.Font(Help, "BORDER", C.Font.NumSmall, 14, nil, C.Color.W3, {C.Color.Main0}, {1,-1}, "CENTER", "CENTER")
	Text: SetPoint("CENTER", button, "CENTER", 0, -13)

	local GroupRoleIndicator = F.Create.Texture(Help, "ARTWORK", 1, F.Path("Raid_RoleIcon"), nil, 0.9, {16,16})
	GroupRoleIndicator: SetPoint("TOPLEFT", button, "TOPLEFT", 2,-2)

	local ReadyCheckIndicator = F.Create.Texture(Help, "OVERLAY", 1, F.Path("ReadyCheck_Waiting"), nil, 0.9, {24,24})
	ReadyCheckIndicator: SetPoint("CENTER", button, "CENTER", 0,0)

	local RaidTargetIndicator = F.Create.Texture(Help, "ARTWORK", 1, "Interface\\TargetingFrame\\UI-RaidTargetingIcons", nil, 0.9, {16,16})
	RaidTargetIndicator: SetPoint("BOTTOM", button, "CENTER", 0,6)

	local GroupLeaderIndicator = F.Create.Texture(Help, "ARTWORK", 1, "", nil, 0.9, {16,16})
	GroupLeaderIndicator: SetPoint("TOPLEFT", GroupRoleIndicator, "TOPRIGHT", 2,1)

	local CenterStatusIcon = F.Create.Texture(Help, "ARTWORK", 1, "", nil, 0.9, {32,32})
	CenterStatusIcon: SetPoint("CENTER", button, "CENTER", 0,0)

	Bar1:Hide()
	Bar2:Hide()
	Bar3:Hide()
	button.Bar1 = Bar1
	button.Bar2 = Bar2
	button.Bar3 = Bar3
	button.HpBar = HpBar
	button.PpBar = PpBar
	button.Name = Name
	button.GroupRoleIndicator = GroupRoleIndicator
	button.ReadyCheckIndicator = ReadyCheckIndicator
	button.RaidTargetIndicator = RaidTargetIndicator
	button.GroupLeaderIndicator = GroupLeaderIndicator
	button.CenterStatusIcon = CenterStatusIcon
	button.Buff = Raid5_Debuff(button, button.DisplayedUnit)
	button.Debuff = Raid5_Buff(button, button.DisplayedUnit)

	return button
end

local Quafe_Raid5 = CreateFrame("Frame", "Quafe_Raid5", E, "SecureHandlerAttributeTemplate")
Quafe_Raid5: SetSize(540, 50)
Quafe_Raid5.Init = false

local function Raid5_Joystick_Update(self, elapsed)
	if not Quafe_Raid5 then return end
	local x2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5_PosX
	local y2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5_PosY
	local x0,y0 = Quafe_Raid5: GetCenter()
	local x1,y1 = self: GetCenter()
	local step = floor(1/(GetFramerate())*1e3)/1e3
	if x0 ~= x1 then
		x2 = x2 + (x1-x0)*step/2
	end
	if y0 ~= y1 then
		y2 = y2 + (y1-y0)*step/2
	end

	Quafe_Raid5: SetPoint("CENTER", UIParent, "CENTER", x2, y2)
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5_PosX = x2
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5_PosY = y2
end

local function Quafe_Raid5_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_PartyRaid"].Raid5 then
		RegisterStateDriver(Quafe_Raid5, "visibility", "[@raid6,exists]hide;[@party1,exists]show;hide")
		local Party = {}
		for i = 1,5 do
			if i == 1 then
				Party[i] = Raid5Button_Template(Quafe_Raid5, "player")
				Party[i]: SetPoint("LEFT", Quafe_Raid5, "LEFT", 0, 0)
			else
				Party[i] = Raid5Button_Template(Quafe_Raid5, "party"..(i-1))
				Party[i]: SetPoint("LEFT", Party[i-1], "RIGHT", 10, 0)
			end
			Party[i]: SetScript("OnEvent", Raid5Button_OnEvent)
			Party[i]: SetScript("OnShow", Raid5Button_OnShow)
			Party[i]: SetScript("OnUpdate", Raid5Button_OnUpdate)
			Raid5Button_RgEvent(Party[i])
			Raid5Button_OnShow(Party[i])
		end
		Quafe_Raid5.Party = Party

		Quafe_Raid5: SetPoint("CENTER", UIParent, "CENTER", Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5_PosX, Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5_PosY)
		function Quafe_Raid5.MoverOnShow()
			--UnregisterStateDriver(Quafe_Raid5, "visibility")
			--Quafe_Raid5: Show()
		end
		function Quafe_Raid5.MoverOnHide()
			--RegisterStateDriver(Quafe_Raid5, "visibility", "[@raid6,exists]hide;[@party1,exists]show;hide")
		end
		F.CreateJoystick(Quafe_Raid5, 540,50, "Quafe "..L['RAID5'])
		Quafe_Raid5.Joystick.postUpdate = Raid5_Joystick_Update

		Quafe_Raid5.Init = true
	end
end

local function Quafe_Raid5_Toggle(arg)
	if arg == "ON" then
		if not Quafe_Raid5.Init then
			Quafe_Raid5_Load()
		else
			if not Quafe_Raid5:IsForbidden() then
				RegisterStateDriver(Quafe_Raid5, "visibility", "[@raid6,exists]hide;[@party1,exists]show;hide")
				for i = 1,5 do
					Raid5Button_RgEvent(Quafe_Raid5.Party[i])
				end
				Quafe_Raid5: Show()
			end
		end
	elseif arg == "OFF" then
		if not Quafe_Raid5:IsForbidden() then
			UnregisterStateDriver(Quafe_Raid5, "visibility")
			Quafe_Raid5: Hide()
			for i = 1,5 do
				Quafe_Raid5.Party[i]: UnregisterAllEvents()
			end
		end
		--Quafe_NoticeReload()
	elseif arg == "COLOR" then
		
	end
end

Quafe_Raid5.Load = Quafe_Raid5_Load
F.Quafe_Raid5_Toggle = Quafe_Raid5_Toggle
insert(E.Module, Quafe_Raid5)

----------------------------------------------------------------
--> Raid40
----------------------------------------------------------------

local function Raid40Header_Frame(frame)
	do
		local header = CreateFrame("Frame", "Quafe_Raid40HealGroup", frame, "SecureRaidGroupHeaderTemplate")
		header: SetSize(72, 36)
		header: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 60,-200)
		header: SetClampedToScreen(true)

		header: SetAttribute("point", "LEFT")
		header: SetAttribute("xOffset", 4)
		header: SetAttribute("yOffset", -4)
		header: SetAttribute("sortMethod", "INDEX")
		header: SetAttribute("sortDir", "ASC")
		header: SetAttribute("minWidth", 100)
		header: SetAttribute("minHeight", 60)
		header: SetAttribute("showSolo", "true")
		header: SetAttribute("showPlayer", "true")
		header: SetAttribute("showParty", "true")
		header: SetAttribute("template", "Quafe_PartyFrameTemplate")
		--header: SetAttribute("templateType", "Frame")
		header: SetMovable(true)

		frame.Raid40 = header
	end
end

----------------------------------------------------------------
--> 
----------------------------------------------------------------

local Quafe_PartyRaid = CreateFrame("Frame", "Quafe_PartyRaid", E)

local function Quafe_PartyRaid_Toggle(arg)
	if arg == "PARTY_ON" then
		F.Quafe_Party_Toggle("ON")
	elseif arg == "PARTY_OFF" then
		F.Quafe_Party_Toggle("OFF")
	elseif arg == "RAID5_ON" then
		F.Quafe_Raid5_Toggle("ON")
	elseif arg == "RAID5_OFF" then
		F.Quafe_Raid5_Toggle("OFF")
	end
end

local Quafe_PartyRaid_Config = {
	Database = {
		["Quafe_PartyRaid"] = {
			Enable = true,
			Party = true,
			Raid5 = false,
			Raid5_PosX = 0,
			Raid5_PosY = -360,
		},
	},

	Config = {
		Name = "Quafe "..L['PARTY_RAID'],
		Type = "Blank",
		Sub = {
			[1] = {
				Name = L['PARTY_FRAME'],
				Type = "Switch",
				Click = function(self, button)
					if InCombatLockdown() then return end
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Party then
						Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Party = false
						self.Text:SetText(L["OFF"])
						Quafe_PartyRaid_Toggle("PARTY_OFF")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Party = true
						self.Text:SetText(L["ON"])
						Quafe_PartyRaid_Toggle("PARTY_ON")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Party then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
			[2] = {
				Name = L['RAID5'],
				Type = "Switch",
				Click = function(self, button)
					if InCombatLockdown() then return end
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5 then
						Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5 = false
						self.Text:SetText(L["OFF"])
						Quafe_PartyRaid_Toggle("RAID5_OFF")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5 = true
						self.Text:SetText(L["ON"])
						Quafe_PartyRaid_Toggle("RAID5_ON")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Raid5 then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}

Quafe_PartyRaid.Load = Quafe_PartyRaid_Load
Quafe_PartyRaid.Config = Quafe_PartyRaid_Config
insert(E.Module, Quafe_PartyRaid)


--[[

local heal = UnitGetIncomingHeals(unit[, healer]);

Parameters

    unit 
        UnitId - Unit to query healing for
    healer (Optional) 
        UnitId - Filter heals done by unit

Returns

    heal 
        Integer - Predicted health from incoming heal



]]--

--[[
local function QuafeRaidButton_OnLoad(self)
	if self.Init then return end
	self.Init = true
	self: RegisterForClicks("AnyDown")
	self: SetAttribute("*type1", "target")
	self: SetAttribute("*type2", "togglemenu")
	self: SetAttribute("shift-type1", "focus")
	self: SetAttribute("ctrl-type1", "focus")
	self: SetAttribute("toggleForVehicle", true)

	self: SetScript("OnEnter", function(self)
		local unit = self:GetAttribute("unit")
		if unit then
			GameTooltip_SetDefaultAnchor(GameTooltip, self);
			if ( GameTooltip:SetUnit(unit, self.hideStatusOnTooltip) ) then
				self.UpdateTooltip = F.UnitFrame_UpdateTooltip;
			else
				self.UpdateTooltip = nil;
			end
			local r, g, b = GameTooltip_UnitColor(unit);
			GameTooltipTextLeft1:SetTextColor(r, g, b);
			GameTooltip: Show()
		end
	end)
	self: SetScript("OnLeave", F.UnitFrame_OnLeave)

	self.Name: SetFont(C.Font.Txt, 12, nil)
	self.Name: SetShadowColor(0.02,0.02,0.02,0.9)
	self.Name: SetShadowOffset(1,-1)
	self.Name: SetTextColor(F.Color(C.Color.W3))

	self.Text: SetFont(C.Font.Txt, 12, nil)
	self.Text: SetShadowColor(0.02,0.02,0.02,0.9)
	self.Text: SetShadowOffset(1,-1)
	self.Text: SetTextColor(F.Color(C.Color.W3))

	self.Bar1: SetBackdrop({ 
		bgFile = F.Path("StatusBar\\Raid"), 
		edgeFile = "", tile = false, tileSize = 0, edgeSize = 0, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})

	local unit = self:GetAttribute("unit")
	if not self.Buff then
		self.Buff = Raid5_Debuff(self, unit)
	end
	if not self.Debuff then
		self.Debuff = Raid5_Buff(self, unit)
	end
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");
	self:RegisterEvent("UNIT_CONNECTION");
	self:RegisterEvent("PLAYER_ROLES_ASSIGNED");
	self:RegisterEvent("UNIT_ENTERED_VEHICLE");
	self:RegisterEvent("UNIT_EXITED_VEHICLE");
	self:RegisterEvent("UNIT_PET");
	self:RegisterEvent("READY_CHECK");
	self:RegisterEvent("READY_CHECK_FINISHED");
	self:RegisterEvent("READY_CHECK_CONFIRM");
	self:RegisterEvent("PARTY_MEMBER_DISABLE");
	self:RegisterEvent("PARTY_MEMBER_ENABLE");
	self:RegisterEvent("INCOMING_RESURRECT_CHANGED");
	self:RegisterEvent("UNIT_OTHER_PARTY_CHANGED");
	self:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED");
	self:RegisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED");
	self:RegisterEvent("UNIT_PHASE");
	self:RegisterEvent("UNIT_FLAGS");
	self:RegisterEvent("GROUP_JOINED");
	self:RegisterEvent("GROUP_LEFT");
	self:RegisterEvent("INCOMING_SUMMON_CHANGED");

	self: RegisterEvent('PLAYER_ENTERING_WORLD')
	self: RegisterEvent('GROUP_ROSTER_UPDATE')
	self: RegisterEvent("UNIT_DISPLAYPOWER")
	self: RegisterEvent("UNIT_POWER_BAR_SHOW")
	self: RegisterEvent("UNIT_POWER_BAR_HIDE")
	self: RegisterEvent("UNIT_NAME_UPDATE")
	self: RegisterEvent("UNIT_HEALTH_FREQUENT")
	self: RegisterEvent("UNIT_MAXHEALTH")
	self: RegisterEvent("UNIT_POWER_UPDATE")
	self: RegisterEvent("UNIT_MAXPOWER")
end
--]]