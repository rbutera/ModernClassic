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
	Aura: SetPointSetPoint("TOP", frame, "TOP", 0,4)
	F.Aura_Create(Aura)

	return Aura
end

local function PartyMember_Template(frame)
	local button = CreateFrame("Button", nil, frame, "SecureUnitButtonTemplate")
	button: SetSize(106,60)

	local Portrait = CreateFrame("PlayerModel", nil, button)
	Portrait: SetSize(100,26)
	Portrait: SetPoint("TOP", button, "TOP", 0, -2)

	local Bg = F.Create.Texture(button, "BACKGROUND", 1, F.Path("StatusBar\\Raid"), C.Color.Main0, 0.6, {104,60})
	Bg: SetPoint("CNETER", button, "CENTER", 0, 0)

	local BgG = F.Create.Texture(button, "BACKGROUND", 2, F.Path("StatusBar\\Raid"), C.Color.Main1, 0.1, {104,60})
	BgG: SetPoint("CNETER", button, "CENTER", 0, 0)

	local HealthBg = F.Create.Texture(button, "BORDER", 1, F.Path("Party\\HealthBar"), C.Color.W2, 0.1, {100,10}, {14/128,114/128, 3/16,13/16})
	HealthBg: SetPoint("BOTTOM", button, "BOTTOM", 0, 2)

	local HealthBar = F.Create.Texture(button, "ARTWORK", 1, F.Path("Party\\HealthBar"), C.Color.Main1, 0.9, {100,10}, {14/128,114/128, 3/16,13/16})
	HealthBar: SetPoint("LEFT", HealthBg, "LEFT", 0, 0)

	local Name = F.Create.Font(button, "ARTWORK", C.Font.Txt, 12, nil, C.Color.Main1)
	Name: SetPoint("TOP", button, "TOP", 0, -34)

	local Percent = F.Create.Font(button, "OVERLAY", C.Font.NumSmall, 14, nil, C.Color.Main1, C.Color.Main0, {1,-1})
	Name: SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 4, 34)

	local help = CreateFrame("Frame", nil, Portrait)
	help: SetPoint("TOPLEFT", -2,2)
	help: SetPoint("BOTTOMRIGHT", 2,-2)
	help: SetBackdrop({
		bgFile = F.Path("StatusBar\\Raid"), 
		edgeFile = F.Path("StatusBar\\Flat"), 
		tile = false, tileSize = 1, edgeSize = 2, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	help: SetBackdropColor(F.Color(C.Color.W1, 0))
	help: SetBackdropBorderColor(F.Color(C.Color.Main1, 0.9))

	button.Portrait = Portrait
	button.HealthBar = HealthBar
	button.Name = Name
	button.Percent = Percent
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
		self.ArtFrame.HealthBar: SetSize(100*h1+F.Debug,10)
		self.ArtFrame.HealthBar: SetTexCoord(14/128,(14+100*h1)/128, 3/16,13/16)
		self.ArtFrame.Percent: SetText(format("%d%s", h2,"%"))
	end
end

local function PartyName_Update(self, unit)
	if unit then
		local name = UnitName(unit) or "???"
		self.ArtFrame.Name: SetText(name)
	end
end

function PartyButton_OnLoad(self)
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

	local help = CreateFrame("Frame", nil, self.Portrait)
	help: SetPoint("TOPLEFT", -2,2)
	help: SetPoint("BOTTOMRIGHT", 2,-2)
	help: SetBackdrop({
		bgFile = F.Path("StatusBar\\Raid"), 
		edgeFile = F.Path("StatusBar\\Flat"), 
		tile = false, tileSize = 1, edgeSize = 2, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	help: SetBackdropColor(F.Color(C.Color.W1, 0))
	help: SetBackdropBorderColor(F.Color(C.Color.Main1, 0.9))
	self.Portrait.Border = help

	self.ArtFrame.HealthBarBg: SetVertexColor(F.Color(C.Color.W2))
	self.ArtFrame.HealthBarBg: SetAlpha(0.6)
	self.ArtFrame.HealthBar: SetVertexColor(F.Color(C.Color.Main1))
	self.ArtFrame.HealthBar: SetAlpha(0.9)
	self.ArtFrame.HealthBar: ClearAllPoints()
	self.ArtFrame.HealthBar: SetPoint("LEFT", self.ArtFrame.HealthBarBg, "LEFT", 0,0)
	self.ArtFrame.HealthBar: SetSize(100,10)
	self.ArtFrame.HealthBar: SetTexCoord(14/128,114/128, 3/16,13/16)

	self.ArtFrame.Bg: SetVertexColor(F.Color(C.Color.W1))
	self.ArtFrame.Bg_Glow: SetVertexColor(F.Color(C.Color.Main1))

	self.ArtFrame.Name: SetFont(C.Font.Txt, 12, nil)
	self.ArtFrame.Name: SetTextColor(F.Color(C.Color.Main1))
	self.ArtFrame.Percent: SetFont(C.Font.NumSmall, 14, nil)
	self.ArtFrame.Percent: SetTextColor(F.Color(C.Color.Main1))

	local unit = self:GetAttribute("unit")
	
	if not self.Debuff then
		self.Debuff = Party_Debuff(self, unit)
	end

	self: RegisterEvent('PLAYER_ENTERING_WORLD')
	self: RegisterEvent('GROUP_ROSTER_UPDATE')
	self: RegisterEvent('VARIABLES_LOADED')
	self: RegisterEvent('UNIT_ENTERED_VEHICLE')
	self: RegisterEvent('UNIT_EXITED_VEHICLE')
	self: RegisterEvent('PARTY_MEMBER_ENABLE')
	self: RegisterEvent('PARTY_MEMBER_DISABLE')
	self: RegisterEvent('UNIT_OTHER_PARTY_CHANGED')
	self: RegisterEvent('UNIT_CONNECTION')
	self: RegisterEvent('UNIT_MODEL_CHANGED')
	self: RegisterEvent('UNIT_PORTRAIT_UPDATE')
	self: RegisterEvent("UNIT_HEALTH")
	self: RegisterEvent("UNIT_MAXHEALTH")
	self: RegisterEvent("UNIT_NAME_UPDATE")
end

function PartyButton_OnShow(self)
	local unit = self:GetAttribute("unit")
	PartyPortrait_Update(self, unit)
	PartyName_Update(self, unit)
	PartyHealth_Update(self, unit)
end

function PartyButton_OnEvent(self, event, ...)
	local unit = self:GetAttribute("unit")
	self.Debuff.unit = unit
	--local guid = UnitGUID(unit)
	if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_CONNECTION" or event == "UNIT_MODEL_CHANGED" or event == "UNIT_PORTRAIT_UPDATE" then
		PartyPortrait_Update(self, unit)
	end
	--if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_CONNECTION" then
	if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "UNIT_NAME_UPDATE" then
		PartyName_Update(self, unit)
	end
	if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_CONNECTION" or event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" then
		PartyHealth_Update(self, unit)
	end
end

local function PartyHeader_Frame(f)
	do
		local header = CreateFrame("Frame", "Quafe_PartyGroup", f, "SecurePartyHeaderTemplate")
		header: SetSize(100, 60)
		header: SetPoint("LEFT", f, "LEFT", 0,0)
		header: SetClampedToScreen(true)

		header: SetAttribute("point", "LEFT")
		header: SetAttribute("xOffset", 10)
		header: SetAttribute("yOffset", 0)
		header: SetAttribute("sortMethod", "INDEX")
		header: SetAttribute("sortDir", "ASC")
		header: SetAttribute("minWidth", 100)
		header: SetAttribute("minHeight", 60)
		--header: SetAttribute("showPlayer", "true")
		--header: SetAttribute("showSolo", "true")
		header: SetAttribute("template", "Quafe_PartyFrameTemplate")
		--header: SetAttribute("templateType", "Frame")
		header: SetMovable(true)

		f.Header = header
	end
end

local Quafe_Party = CreateFrame("Frame", "Quafe_Party", E)
Quafe_Party: SetSize(540, 60)
Quafe_Party: SetClampedToScreen(true)
Quafe_Party: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 60,-32)
Quafe_Party.Init = false


local function Quafe_Party_Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_Party"].Enable then
		PartyHeader_Frame(Quafe_Party)
		Quafe_Party.Header: Show()
		Quafe_Party.Init = true
	end
end

local function Quafe_Party_Toggle(arg)
	if arg == "ON" then
		if not Quafe_Party.Init then
			Quafe_Party_Load()
		else
			if not Quafe_Party:IsForbidden() then
				Quafe_Party: Show()
			end
		end
	elseif arg == "OFF" then
		if not Quafe_Party:IsForbidden() then
			Quafe_Party: Hide()
		end
		Quafe_NoticeReload()
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
Quafe_Party.Config = Quafe_Party_Config
insert(E.Module, Quafe_Party)