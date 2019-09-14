local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

----------------------------------------------------------------
--> Handler
----------------------------------------------------------------

local LOCALE = GetLocale()

local function Debug_Test()
    local LocaleList = {
        "zhTW",
        "enUS",
    }
    for i, l in ipairs(LocaleList) do
        LOCALE = l
        --LOCALE = "123"
        for k1,v1 in pairs(C.Locale["zhCN"]) do
            for k2,v2 in pairs(C.Locale) do
                if not v2[k1] then
                    DEFAULT_CHAT_FRAME:AddMessage("Missing locale: "..k2.." "..k1)
                end
            end
        end
    end
end
--Debug_Test()

if not C.Locale[LOCALE] then
    C.Locale[LOCALE] = {}
end
for k,v in pairs(C.Locale[LOCALE]) do
    L[k] = v
end
setmetatable(L, { __index = C.Locale["enUS"] })
