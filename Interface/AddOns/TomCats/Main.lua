local _, addon = ...
local TCL = addon.TomCatsLibs

addon.defaultCVars = {
    miniWorldMap = false
}

function TomCatsGetCVar(cvar)
    if addon.savedVariables.character.cvars[cvar] ~= nil then
        return addon.savedVariables.character.cvars[cvar]
    else
        return addon.defaultCVars[cvar]
    end
end

function TomCatsSetCVar(cvar, val)
    addon.savedVariables.character.cvars[cvar] = val
end


local function ADDON_LOADED(_, event, arg1)
    if (arg1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        addon.savedVariables.character.cvars = addon.savedVariables.character.cvars or { }
    end
end
