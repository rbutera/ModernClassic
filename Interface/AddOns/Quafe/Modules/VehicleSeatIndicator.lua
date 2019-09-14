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
--> VehicleSeatIndicator
--- ------------------------------------------------------------

local function RemoveAnchor(f)
	for i, alertSubSystem in pairs(AlertFrame.alertFrameSubSystems) do
		if alertSubSystem.anchorFrame == f then
			tremove(AlertFrame.alertFrameSubSystems, i)
			return 
		end
	end
end

local Quafe_VehicleSeat = CreateFrame("Frame", "Quafe_VehicleSeatIndicator", E)
Quafe_VehicleSeat:SetSize(128,128)

local function Joystick_Update(self, elapsed)
	local x2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_VehicleSeat.PosX
	local y2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_VehicleSeat.PosY
	local x0,y0 = Quafe_VehicleSeat: GetCenter()
	local x1,y1 = self: GetCenter()
	local step = floor(1/(GetFramerate())*1e3)/1e3
	if x0 ~= x1 then
		x2 = x2 + (x1-x0)*step/2
	end
	if y0 ~= y1 then
		y2 = y2 + (y1-y0)*step/2
	end
	Quafe_VehicleSeat: SetPoint("CENTER", UIParent, "BOTTOM",x2, y2)
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_VehicleSeat.PosX = x2
	Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_VehicleSeat.PosY = y2
end

local function Quafe_VehicleSeat_Load()
	Quafe_VehicleSeat:SetPoint("CENTER", UIParent, "BOTTOM", Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_VehicleSeat.PosX,Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_VehicleSeat.PosY)
	F.CreateJoystick(Quafe_VehicleSeat, 128,120, "Quafe_VehicleSeatIndicator")
	Quafe_VehicleSeat.Joystick.postUpdate = Joystick_Update

    RemoveAnchor(VehicleSeatIndicator)
    VehicleSeatIndicator:SetParent(Quafe_VehicleSeat)
    VehicleSeatIndicator:ClearAllPoints()
	VehicleSeatIndicator:SetPoint("CENTER", Quafe_VehicleSeat, "CENTER", 0,0)
	hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(self)
		self:ClearAllPoints()
		getmetatable(self).__index.SetPoint(self, "CENTER", Quafe_VehicleSeat, "CENTER", 0,0)
	end)
end

Quafe_VehicleSeat_Config = {
	Database = {
		["Quafe_VehicleSeat"] = {
			["PosX"] = -600,
			["PosY"] = 80,
		},
	},
}

Quafe_VehicleSeat.Load = Quafe_VehicleSeat_Load
Quafe_VehicleSeat.Config = Quafe_VehicleSeat_Config
if not F.IsClassic then
	tinsert(E.Module, Quafe_VehicleSeat)
end