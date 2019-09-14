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

----------------------------------------------------------------
--> 
----------------------------------------------------------------

local function BGU_Player_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_DISPLAYPOWER" then
		local powerType = UnitPowerType("player")
		frame.ShowMana = false
		if powerType ~= 0 then
			local maxmana = UnitPowerMax("player", 0)
			if maxmana ~= 0 then
				frame.ShowMana = true
			end
		end

		F.Smooth_Health("player")
		F.Smooth_Power("player")
		F.Smooth_Absorb("player")
		if frame.ShowMana then
			F.Smooth_Mana("player")
		end
	end
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		F.Smooth_Health("player")
	end
	if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		F.Smooth_Power("player")
		if frame.ShowMana then
			F.Smooth_Mana("player")
		end
	end
	if event == "UNIT_ABSORB_AMOUNT_CHANGED" or event == "UNIT_MAXHEALTH" then
		F.Smooth_Absorb("player")
	end
end

local function BGU_Player_RegEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "player", "vehicle")
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", "player", "vehicle")
	frame: RegisterUnitEvent("UNIT_POWER_FREQUENT", "player", "vehicle")
	frame: RegisterUnitEvent("UNIT_MAXPOWER", "player", "vehicle")
	if not F.IsClassic then
		frame: RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", "player", "vehicle")
		frame: RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
		frame: RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	end
	--frame: RegisterUnitEvent("UNIT_PET", "player")
	--frame: RegisterEvent("PET_UI_UPDATE")
	frame: RegisterEvent("UNIT_DISPLAYPOWER")
end

local function BGU_Pet_Event(frame, event, ...)
	if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "UNIT_PET" or event == "PET_UI_UPDATE" then
		--if UnitInVehicle("player") or UnitExists("pet") then
		if F.IsClassic then
			if UnitExists("pet") then
				frame.ShowPet = true
			else
				frame.ShowPet = false
			end
		else
			if UnitHasVehiclePlayerFrameUI("player") or UnitExists("pet") then
				frame.ShowPet = true
			else
				frame.ShowPet = false
			end
		end
		F.Smooth_Health("pet")
		F.Smooth_Power("pet")
	end
	if event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		F.Smooth_Health("pet")
	end
	if event == "UNIT_POWER_UPDATE" or event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER" then
		F.Smooth_Power("pet")
	end
end

local function BGU_Pet_RegEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterUnitEvent("UNIT_HEALTH", "pet", "player")
	frame: RegisterUnitEvent("UNIT_MAXHEALTH", "pet", "player")
	frame: RegisterUnitEvent("UNIT_POWER_UPDATE", "pet", "player")
	frame: RegisterUnitEvent("UNIT_MAXPOWER", "pet", "player")
	frame: RegisterUnitEvent("UNIT_PET", "player")
	frame: RegisterEvent("PET_UI_UPDATE")
	if not F.IsClassic then
		frame: RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
		frame: RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	end
	--frame: RegisterEvent("UNIT_DISPLAYPOWER")
end

local function Create_OnEvent(frame)
	local BGUPlayer = CreateFrame("Frame", nil, frame)
	BGUPlayer.ShowMana = false
	BGUPlayer: SetScript("OnEvent", function(self, event, ...)
		BGU_Player_Event(self, event, ...)
	end)

	local BGUPet = CreateFrame("Frame", nil, frame)
	BGUPet.ShowPet = false
	BGUPet: SetScript("OnEvent", function(self, event, ...)
		BGU_Pet_Event(self, event, ...)
	end)

	frame.BGUPlayer = BGUPlayer
	frame.BGUPet = BGUPet
end

local function BGU_OnUpdate(frame)
	frame: SetScript("OnUpdate", function(self, elpased)
		F.Smooth_Update(E.Value["player"].Health)
		F.Smooth_Update(E.Value["player"].Power)
		F.Smooth_Update(E.Value["player"].Absorb)
		if frame.BGUPlayer.ShowMana then
			F.Smooth_Update(E.Value["player"].Mana)
		end
		if frame.BGUPet.ShowPet then
			F.Smooth_Update(E.Value["pet"].Health)
			F.Smooth_Update(E.Value["pet"].Power)
		end
	end)
end

local BackgroundUpdate = CreateFrame("Frame", nil, E)
local function BGU_Load()
	Create_OnEvent(BackgroundUpdate)
	BGU_Player_RegEvent(BackgroundUpdate.BGUPlayer)
	BGU_Pet_RegEvent(BackgroundUpdate.BGUPet)
	BGU_OnUpdate(BackgroundUpdate)
end
BackgroundUpdate.Load = BGU_Load()
tinsert(E.Module, BackgroundUpdate)