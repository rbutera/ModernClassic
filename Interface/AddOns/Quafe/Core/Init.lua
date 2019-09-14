----------------------------------------------------------------
-- Init
----------------------------------------------------------------

local AddonName, Engine = ...
local Quafe_UIParent = CreateFrame("Frame", "Quafe_UIParent", UIParent)
Quafe_UIParent: SetSize(12,12)
Quafe_UIParent: SetPoint("CENTER", UIParent, "CENTER", 0,0)

Engine[1] = Quafe_UIParent
Engine[2] = {}	-->C, Config and Constant
Engine[3] = {}	-->F, Function and Lib
Engine[4] = {}	-->L, Locale

local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale
--This should be at the top of every file inside of the Quafe AddOn:	
--local E, C, F, L = unpack(select(2, ...))

_G[AddonName] = Engine	-->Allow other addons to use Engine
--This is how another addon imports the Quafe engine:	
--local E, C, F, L = unpack(Quafe)
--(learned from Tukui)

E.Name = AddonName
E.Version = tonumber(GetAddOnMetadata(E.Name, "Version"))

E.Module = {}
E.Config = {}
E.AuraUpdate = {
	AuraList = {},
	UnitList = {"player", "target"},
}
E.Aurawatch = {}
E.AurawatchStyle = {}
E.FCS_Refresh = {}
E.Database = {
	Reset = false,
	Global = {},
	Profile = {
		Default = {},
	},
}
E.Value = {
	["player"] = {
		Health = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Power = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Mana = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Absorb = {Min = 0, Max = 0, Per = 0, Cur = 0},
	},
	["target"] = {
		Health = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Power = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Mana = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Absorb = {Min = 0, Max = 0, Per = 0, Cur = 0},
	},
	["focus"] = {
		Health = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Power = {Min = 0, Max = 0, Per = 0, Cur = 0},
	},
	["pet"] = {
		Health = {Min = 0, Max = 0, Per = 0, Cur = 0},
		Power = {Min = 0, Max = 0, Per = 0, Cur = 0},
	},
}
E.Aura = {}
E.CombatLogList = {}


--F.Media = "Interface\\AddOns\\"..AddonName.."\\Media\\"
F.Path = function(tex)
	--return format("%s%s%s%s", "Interface\\AddOns\\", AddonName, "\\Media\\", tex)
	return "Interface\\AddOns\\"..AddonName.."\\Media\\"..tex
end

----------------------------------------------------------------
-- Slash
----------------------------------------------------------------

--> Reload UI
SlashCmdList.RELOADUI = ReloadUI
SLASH_RELOADUI1 = "/rl"

--> Calendar
SlashCmdList["CALENDAR"] = function()
	ToggleCalendar()
end
SLASH_CALENDAR1 = "/cl"
SLASH_CALENDAR2 = "/calendar"

--> Clear Focus
SlashCmdList.CLEARFOCUS = ClearFocus

--> C.Color.Pink Config Frame
SlashCmdList["QUAFE"] = function(msg)
	msg = msg:lower()
	if msg == "reset" then
		F.Reset()
		DEFAULT_CHAT_FRAME:AddMessage("Quafe UI has be reset")
	elseif msg == "aurawatch reset" then
		wipe(Quafe_DB.Global.AuraWatch)
		Quafe_DB.Global.AuraWatch = E.Aurawatch
	else
		if _G["Quafe_Config"] then _G["Quafe_Config"]: Show() end
	end
end
SLASH_QUAFE1 = "/quafe"
SLASH_QUAFE2 = "/qf"


--[[

SET overrideArchive "0" --和谐

SetCVar("cameraDistanceMaxZoomFactor", 2.6) --视野距离 默认1.9，最大2.6。

--]]


