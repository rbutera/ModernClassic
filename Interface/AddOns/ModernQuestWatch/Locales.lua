local _, S = ...

local L = {
	enUS = {
		UNTRACK_USAGE = "|cff71D5FFShift-Click|r to untrack a quest",
		MOVE_USAGE = "|cff71D5FFAlt-Click|r to move the quest tracker",
		RESET = "Settings have been reset",
	},
	deDE = {
		RESET = "Einstellungen wurden zurückgesetzt",
	},
	esES = {
	},
	esMX = {
	},
	frFR = {
	},
	itIT = {
	},
	koKR = {
		RESET = "설정이 초기화되었습니다",
	},
	ptBR = {
	},
	ruRU = {
	},
	--zhCN = {},
	zhTW = {
		RESET = "設定已經重置",
	},
}

L.zhCN = L.zhTW

S.L = setmetatable(L[GetLocale()] or L.enUS, {__index = function(t, k)
	local v = rawget(L.enUS, k) or k
	rawset(t, k, v)
	return v
end})
