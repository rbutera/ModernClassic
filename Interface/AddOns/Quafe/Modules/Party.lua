local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

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
--> 
--- ------------------------------------------------------------

local function Party_Debuff(frame, unit)
	local Aura = CreateFrame("Frame", nil, frame)
	Aura: SetFrameLevel(frame:GetFrameLevel()+3)
	
	Aura.size = 24
	Aura.gap = 0
	Aura.fontsize = 12
	Aura.limit = 8
	Aura.perline = 4
	Aura.growthH = "RIGHT"
	Aura.growthV = "TOP"
	Aura.unit = unit
	Aura.filter = "HARMFUL"
	
	Aura: SetSize(Aura.size*Aura.perline, Aura.size)
	Aura: SetPoint("TOP", frame, "TOP", 0,4)
	--F.Aura_Create(Aura)
	F.Aura_Template(Aura)

	return Aura
end

local function PartyPortrait_Update(self, unit)
	if not self.Portrait then return end
	local isAvailable
	if unit then
		isAvailable = UnitIsConnected(unit) and UnitIsVisible(unit)
	end
	if(not isAvailable) then
		self.Portrait:SetCamDistanceScale(0.25)
		self.Portrait:SetPortraitZoom(0)
		self.Portrait:SetPosition(0, 0, 0.25)
		self.Portrait:ClearModel()
		self.Portrait:SetModel([[Interface\Buttons\TalkToMeQuestionMark.m2]])
	else
		self.Portrait:SetCamDistanceScale(0.9)
		self.Portrait:SetPortraitZoom(1)
		self.Portrait:SetPosition(0, 0, 0)
		self.Portrait:ClearModel()
		self.Portrait:SetUnit(unit)
	end
end

local function PartyHealth_Update(self, unit)
	if unit then
		local minHealth,maxHealth = UnitHealth(unit),UnitHealthMax(unit)
		local h1,h2 = 0,0
		if maxHealth == 0 or minHealth == 0 then
			h1 = 0
			h2 = 0
		else
			h1 = floor(minHealth/maxHealth*1e4)/1e4
			h2 = floor(minHealth/maxHealth*1e2)
		end
		self.HealthBar: SetSize(100*h1+F.Debug,10)
		self.HealthBar: SetTexCoord(14/128,(14+100*h1)/128, 3/16,13/16)
		self.Percent: SetText(format("%d%s", h2,"%"))
	end
end

local function PartyName_Update(self, unit)
	if unit then
		local name = UnitName(unit) or "???"
		self.Name: SetText(name)
	end
end

local function GroupRoleIndicator_Update(frame, event)
	local role = UnitGroupRolesAssigned(frame.Unit) --TANK, HEALER, DAMAGER, NONE
	if(role == 'TANK' or role == 'HEALER' or role == 'DAMAGER') then
		frame.GroupRoleIndicator:SetTexCoord(GetTexCoordsForRoleSmallCircle(role))
		frame.GroupRoleIndicator:Show()
	else
		frame.GroupRoleIndicator:Hide()
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

local function UnitFrame_UpdateUnitEvents(frame)
	local unit = frame.Unit;
	local displayedUnit;
	if ( unit ~= frame.DisplayedUnit ) then
		displayedUnit = frame.DisplayedUnit;
	end
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_HEALTH", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_HEALTH_FREQUENT", unit, displayedUnit);
	--frame: RegisterUnitEvent("UNIT_MAXPOWER", unit, displayedUnit);
	--frame: RegisterUnitEvent("UNIT_POWER_UPDATE", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_AURA", unit, displayedUnit);
	if not F.IsClassic then
		frame: RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", unit, displayedUnit);
		frame: RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE", unit, displayedUnit);
		frame: RegisterUnitEvent("UNIT_HEAL_PREDICTION", unit, displayedUnit);
	end
	frame: RegisterUnitEvent("PLAYER_FLAGS_CHANGED", unit, displayedUnit);
	frame: RegisterUnitEvent("UNIT_CLASSIFICATION_CHANGED", unit, displayedUnit);

	frame: RegisterUnitEvent('UNIT_MODEL_CHANGED', unit, displayedUnit)
	frame: RegisterUnitEvent('UNIT_PORTRAIT_UPDATE', unit, displayedUnit)
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

local function PartyButton_UpdateAll(frame)
	if not F.IsClassic then
		InVehicle_Update(frame)
		GroupRoleIndicator_Update(frame)
	end
	PartyName_Update(frame, frame.DisplayedUnit)
	PartyHealth_Update(frame, frame.DisplayedUnit)
	PartyPortrait_Update(frame, frame.DisplayedUnit)
	RaidTargetIndicator_Update(frame)
	GroupLeaderIndicator_Update(frame)
	frame.Debuff.unit = frame.DisplayedUnit
	frame.Debuff:AuraOnEvent()
end

local function PartyButton_OnEvent(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		PartyButton_UpdateAll(self)
	elseif event == "GROUP_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED" or event == "UNIT_CONNECTION" then
		PartyButton_UpdateAll(self)
		GroupLeaderIndicator_Update(self)
	elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" then
		PartyButton_UpdateAll(self)
		PartyButton_UpdateAll(self)
	elseif event == "UNIT_MODEL_CHANGED" or event == "UNIT_PORTRAIT_UPDATE" then
		PartyPortrait_Update(self, self.DisplayedUnit)
	elseif event == "PLAYER_ROLES_ASSIGNED" then
		GroupRoleIndicator_Update(self)
	elseif event == "UNIT_NAME_UPDATE" then
		PartyName_Update(self, self.DisplayedUnit)
	elseif event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" then
		PartyHealth_Update(self, self.DisplayedUnit)
	elseif event == "UNIT_AURA" then
		self.Debuff:AuraOnEvent()
	elseif (event == "RAID_TARGET_UPDATE") then
		RaidTargetIndicator_Update(self)
	end
end

local function PartyButton_OnShow(self)
	PartyButton_OnEvent(self, "PLAYER_ENTERING_WORLD")
end

local function PartyButton_RgEvent(frame)
	frame: RegisterEvent('PLAYER_ENTERING_WORLD')
	frame: RegisterEvent('GROUP_ROSTER_UPDATE')
	--frame: RegisterEvent('VARIABLES_LOADED')
	if not F.IsClassic then
		frame: RegisterEvent('PLAYER_ROLES_ASSIGNED')
		frame: RegisterEvent('UNIT_ENTERED_VEHICLE')
		frame: RegisterEvent('UNIT_EXITED_VEHICLE')
	end
	frame: RegisterEvent('PARTY_MEMBER_ENABLE')
	frame: RegisterEvent('PARTY_MEMBER_DISABLE')
	frame: RegisterEvent('UNIT_OTHER_PARTY_CHANGED')
	frame: RegisterEvent('UNIT_CONNECTION')
	frame: RegisterUnitEvent("UNIT_NAME_UPDATE", frame.Unit)
	frame: RegisterEvent("RAID_TARGET_UPDATE")

	UnitFrame_UpdateUnitEvents(frame)
end

local function PartyMember_Template(frame, unit)
	local button = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	button: SetSize(106,60)
	button.Unit = unit
	button.DisplayedUnit = unit

	F.init_Unit(button, button.Unit, true)
	button: SetScript("OnEnter", F.UnitFrame_OnEnter)
	button: SetScript("OnLeave", F.UnitFrame_OnLeave)

	local Portrait = CreateFrame("PlayerModel", nil, button)
	Portrait: SetSize(100,26)
	Portrait: SetPoint("TOP", button, "TOP", 0, -2)

	local Bg = F.Create.Texture(button, "BACKGROUND", 1, F.Path("StatusBar\\Raid"), C.Color.Main0, 0.6, {104,60})
	Bg: SetPoint("CENTER", button, "CENTER", 0, 0)

	local BgG = F.Create.Texture(button, "BACKGROUND", 2, F.Path("StatusBar\\Raid"), C.Color.Main1, 0.1, {104,60})
	BgG: SetPoint("CENTER", button, "CENTER", 0, 0)

	local HealthBg = F.Create.Texture(button, "BORDER", 1, F.Path("Party\\HealthBar"), C.Color.W2, 0.1, {100,10}, {14/128,114/128, 3/16,13/16})
	HealthBg: SetPoint("BOTTOM", button, "BOTTOM", 0, 2)

	local HealthBar = F.Create.Texture(button, "ARTWORK", 1, F.Path("Party\\HealthBar"), C.Color.Main1, 0.9, {100,10}, {14/128,114/128, 3/16,13/16})
	HealthBar: SetPoint("LEFT", HealthBg, "LEFT", 0, 0)

	local Name = F.Create.Font(button, "ARTWORK", C.Font.Txt, 12, nil, C.Color.Main1, {C.Color.Main0}, {1,-1})
	Name: SetSize(104,10)
	Name: SetPoint("TOP", button, "TOP", 0, -34)

	local Percent = F.Create.Font(Portrait, "OVERLAY", C.Font.NumSmall, 14, nil, C.Color.Main1, {C.Color.Main0}, {1,-1})
	Percent: SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 4, 34)

	local Help = CreateFrame("Frame", nil, Portrait)
	Help: SetPoint("TOPLEFT", -2,2)
	Help: SetPoint("BOTTOMRIGHT", 2,-2)
	Help: SetBackdrop({
		bgFile = F.Path("StatusBar\\Raid"), 
		edgeFile = F.Path("StatusBar\\Flat"), 
		tile = false, tileSize = 1, edgeSize = 2, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	Help: SetBackdropColor(F.Color(C.Color.W1, 0))
	Help: SetBackdropBorderColor(F.Color(C.Color.Main1, 0.9))

	local GroupRoleIndicator = F.Create.Texture(Help, "ARTWORK", 1, F.Path("Raid_RoleIcon"), C.Color.Main1, 0.9, {16,16})
	GroupRoleIndicator: SetPoint("BOTTOMRIGHT", Help, "BOTTOMRIGHT", -2,2)
	GroupRoleIndicator: Hide()

	local RaidTargetIndicator = F.Create.Texture(Help, "ARTWORK", 1, "Interface\\TargetingFrame\\UI-RaidTargetingIcons", nil, 0.9, {16,16})
	RaidTargetIndicator: SetPoint("CENTER", Help, "BOTTOM", 0,0)
	RaidTargetIndicator: Hide()

	local GroupLeaderIndicator = F.Create.Texture(Help, "OVERLAY", 1, "", C.Color.Main1, 0.9, {16,16})
	GroupLeaderIndicator: SetPoint("BOTTOMRIGHT", GroupRoleIndicator, "BOTTOMLEFT", -2,1)
	GroupLeaderIndicator: Hide()

	button.Portrait = Portrait
	button.HealthBar = HealthBar
	button.Name = Name
	button.Percent = Percent
	button.GroupRoleIndicator = GroupRoleIndicator
	button.RaidTargetIndicator = RaidTargetIndicator
	button.GroupLeaderIndicator = GroupLeaderIndicator
	button.Debuff = Party_Debuff(button, button.Unit)

	return button
end

local Quafe_Party = CreateFrame("Frame", "Quafe_Party", E, "SecureHandlerAttributeTemplate")
Quafe_Party: SetSize(540, 60)
Quafe_Party: SetClampedToScreen(true)
Quafe_Party: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 60,-32)
Quafe_Party.Init = false


local function Quafe_Party_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_PartyRaid.Party then
		local Party = {}
		for i = 1,4 do
			Party[i] = PartyMember_Template(Quafe_Party, "party"..i)
			--Party[i] = PartyMember_Template(Quafe_Party, "player")
			if i == 1 then
				Party[i]: SetPoint("LEFT", Quafe_Party, "LEFT", 0, 0)
			else
				Party[i]: SetPoint("LEFT", Party[i-1], "RIGHT", 10, 0)
			end
			Party[i]: SetScript("OnEvent", PartyButton_OnEvent)
			Party[i]: SetScript("OnShow", PartyButton_OnShow)
			PartyButton_RgEvent(Party[i])

			Quafe_Party.Party = Party
		end
		Quafe_Party.Init = true
	end
end

local function Quafe_Party_Toggle(arg)
	if arg == "ON" then
		if not Quafe_Party.Init then
			Quafe_Party_Load()
		else
			if not Quafe_Party:IsForbidden() then
				for i = 1,4 do
					PartyButton_RgEvent(Quafe_Party.Party[i])
				end
				Quafe_Party: Show()
			end
		end
	elseif arg == "OFF" then
		if not Quafe_Party:IsForbidden() then
			Quafe_Party: Hide()
			for i = 1,4 do
				Quafe_Party.Party[i]: UnregisterAllEvents()
			end
		end
		--Quafe_NoticeReload()
	elseif arg == "COLOR" then
		
	end
end

local Quafe_Party_Config = {
	Database = {
		["Quafe_Party"] = {
			Enable = true,
		},
	},

	Config = {
		Name = "Quafe "..L['PARTY_FRAME'],
		Type = "Switch",
		Click = function(self, button)
			if InCombatLockdown() then return end
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Party"].Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Party"].Enable = false
				self.Text:SetText(L["OFF"])
				Quafe_Party_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Party"].Enable = true
				self.Text:SetText(L["ON"])
				Quafe_Party_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Party"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = nil,
	},
}

Quafe_Party.Load = Quafe_Party_Load
--Quafe_Party.Config = Quafe_Party_Config
F.Quafe_Party_Toggle = Quafe_Party_Toggle
insert(E.Module, Quafe_Party)




