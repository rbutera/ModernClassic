local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

----------------------------------------------------------------
--> API and Variable
----------------------------------------------------------------

local GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit

----------------------------------------------------------------
--> Nameplate
----------------------------------------------------------------

local function Incompatibility_Check()
	local Incompatibility_Table = {
		"TidyPlates",
		"TidyPlatesContinued",
		"TidyPlates_ThreatPlates",
		"Kui_Nameplates",
		"NeatPlates",
		"Plater Nameplates",
	}
	local Incompatibility = false
	for k,v in ipairs(Incompatibility_Table) do
		if F.IsAddonEnabled(v) then  
			Incompatibility = true
		end
	end
	return Incompatibility
end

local function Nameplate_Artwork(frame)
	local Name = F.Create.Font(frame, "OVERLAY", C.Font["Txt"], 12, "THINOUTLINE")
	Name: SetPoint("TOP", frame, "BOTTOM", 0,-2)
end

local function Nameplate_Create(frame, BasePlate, name)
	local Plate = CreateFrame("Frame", E.Name..(name or BasePlate:GetName()), worldFrame)


	if IsAddOnLoaded("WeakAuras") then
		local Kp = Plate:CreateFrame("Frame")
		Kp:SetFrameLevel(1)

		local Kp_Bg = Plate:CreateFrame("Frame")
		Kp_Bg:SetPoint("TOPLEFT", Plate.Health, 0, 0)
		Kp_Bg:SetPoint("BOTTOMRIGHT", Plate.Cast, 0, 0)

		BasePlate.kui = Kp
		BasePlate.kui.bg = Kp_Bg
	end
end

----------------------------------------------------------------
--> Update
----------------------------------------------------------------

--[[
function CoreEvents:UNIT_HEALTH_FREQUENT(unitid)
    local plate = GetNamePlateForUnit(unitid)

    if plate and plate.TPFrame.Active then
      OnHealthUpdate(plate)
      Addon:UpdateExtensions(plate.TPFrame, unitid, plate.TPFrame.stylename)
    end

	unit.health = UnitHealth(unitid) or 0
	unit.healthmax = UnitHealthMax(unitid) or 1
end
--]]

----------------------------------------------------------------
--> Nameplate Driver
----------------------------------------------------------------

local function NameplateDriver_RgEvent(frame)
    frame: RegisterEvent("NAME_PLATE_CREATED");
	frame: RegisterEvent("FORBIDDEN_NAME_PLATE_CREATED");
	frame: RegisterEvent("NAME_PLATE_UNIT_ADDED");
	frame: RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_ADDED");
	frame: RegisterEvent("NAME_PLATE_UNIT_REMOVED");
	frame: RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_REMOVED");
	frame: RegisterEvent("PLAYER_TARGET_CHANGED");
	frame: RegisterEvent("DISPLAY_SIZE_CHANGED");
	frame: RegisterEvent("UNIT_AURA");
	frame: RegisterEvent("VARIABLES_LOADED");
	frame: RegisterEvent("CVAR_UPDATE");
	frame: RegisterEvent("RAID_TARGET_UPDATE");
	frame: RegisterEvent("UNIT_FACTION");
end

local function NameplateDriver_OnEvent(frame, event, ...)
    if event == "NAME_PLATE_CREATED" then
		--local namePlateFrameBase = ...;
		--self:OnNamePlateCreated(namePlateFrameBase);
	elseif event == "FORBIDDEN_NAME_PLATE_CREATED" then
		--local namePlateFrameBase = ...;
		--self:OnForbiddenNamePlateCreated(namePlateFrameBase);
	elseif event == "NAME_PLATE_UNIT_ADDED" or event == "FORBIDDEN_NAME_PLATE_UNIT_ADDED" then
		--local namePlateUnitToken = ...;
		--self:OnNamePlateAdded(namePlateUnitToken);
	elseif event == "NAME_PLATE_UNIT_REMOVED" or event == "FORBIDDEN_NAME_PLATE_UNIT_REMOVED" then
		--local namePlateUnitToken = ...;
		--self:OnNamePlateRemoved(namePlateUnitToken);
	elseif event == "PLAYER_TARGET_CHANGED" then
		--self:OnTargetChanged();
	elseif event == "DISPLAY_SIZE_CHANGED" then
		--self:UpdateNamePlateOptions();
	elseif event == "UNIT_AURA" then
		--self:OnUnitAuraUpdate(...);
	elseif event == "VARIABLES_LOADED" then
		--self:UpdateNamePlateOptions();
	elseif event == "CVAR_UPDATE" then
		--local name = ...;
		--if name == "SHOW_CLASS_COLOR_IN_V_KEY" or name == "SHOW_NAMEPLATE_LOSE_AGGRO_FLASH" or name == "UNIT_NAMEPLATES_SHOW_FRIENDLY_CLASS_COLORS" then
		--	self:UpdateNamePlateOptions();
		--end
	elseif event == "RAID_TARGET_UPDATE" then
		--self:OnRaidTargetUpdate();
	elseif ( event == "UNIT_FACTION" ) then
		--self:OnUnitFactionChanged(...);
	end
end

local Quafe_NameplateDriver = CreateFrame("Frame", nil, E)

local function Quafe_NameplateDriver_Load()

end
