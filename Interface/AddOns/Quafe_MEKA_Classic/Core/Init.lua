----------------------------------------------------------------
-- Init
----------------------------------------------------------------

local AddonName, Engine = ...
Engine[1] = {}

local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale

_G[AddonName] = Engine

MEKA.Name = AddonName
MEKA.Path = function(tex)
	return format("%s%s%s%s", "Interface\\AddOns\\", AddonName, "\\Media\\", tex)
end