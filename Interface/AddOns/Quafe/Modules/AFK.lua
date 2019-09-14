local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale
if F.IsClassic then return end

--- ------------------------------------------------------------
--> API Localization
--- ------------------------------------------------------------

local _G = getfenv(0)
local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

local find = string.find

--- ------------------------------------------------------------
--> AFK
--- ------------------------------------------------------------

local prevAFKState = false
local camSpeed = 0.05

local function ToggleAwayMode(afk)
	if afk then
		--SetView(4)
		MoveViewLeftStart(camSpeed)
	end
	if not afk then
		MoveViewLeftStop()
		SetView(5)
	end
end

local function AwayMode_Event(self, event)
	if InCombatLockdown() then return end
	--if event == "PLAYER_FLAGS_CHANGED" then
		local isAFK = UnitIsAFK("player")
		if isAFK and not prevAFKState then
			prevAFKState = true
			ToggleAwayMode(true)
		elseif not isAFK and prevAFKState then
			prevAFKState = false
			ToggleAwayMode(false)
		end
	--end
end

local function AwayMode_OnEvent(frame)
	--SetCVar("AutoClearAFK", 1)
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	frame:RegisterEvent("PLAYER_FLAGS_CHANGED")
	frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	frame:RegisterEvent("LFG_PROPOSAL_SHOW")
	frame:RegisterEvent("TAXIMAP_OPENED")
	frame:RegisterEvent("TAXIMAP_CLOSED")
	frame:SetScript("OnEvent", function(self, event)
		AwayMode_Event(self, event)
	end)
end

--- ------------------------------------------------------------
--> Load
--- ------------------------------------------------------------

local AwayMode = CreateFrame("Frame", nil, E)
local function Load()
	AwayMode_OnEvent(AwayMode)
end
AwayMode.Load = Load
insert(E.Module, AwayMode)


