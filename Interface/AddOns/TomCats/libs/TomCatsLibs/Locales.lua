local addon = select(2, ...)
local lib = addon.TomCatsLibs.Locales
local isTranslatedLookup = { }
local isDefaultLanguage = true

setmetatable(lib, {
    __index = function(_, key)
        return key
    end
})

function lib.AddLocaleLookup(locale, lookup)
    if (locale == "enUS") then
        Mixin(lib, lookup)
    elseif (GetLocale() == locale) then
        isDefaultLanguage = false
        for key in pairs(lookup) do
            isTranslatedLookup[key] = true
        end
        Mixin(lib, lookup)
    end
end

function lib.IsTranslationNeeded(key)
    if isDefaultLanguage then return false end
    return not (isTranslatedLookup[key] or false)
end

lib.init = false
