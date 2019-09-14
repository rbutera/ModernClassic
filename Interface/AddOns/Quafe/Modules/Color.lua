local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

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
local mod = mod
local modf = math.modf

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

--- ------------------------------------------------------------
--> Color
--- ------------------------------------------------------------

C.Color.Main0 = {r =   4, g =   4, b =   4}
C.Color.Main1 = {r = 150, g = 254, b = 240}
C.Color.Main2 = {r = 248, g = 192, b =  84}
C.Color.Main3 = {r = 234, g = 162, b =  80}
C.Color.Warn1 = {r = 248, g =  58, b = 106}

C.Color.Theme = {
	["MEKA1"] = {
		Main0 = {r =   4, g =   4, b =   4},
		Main1 = {r = 150, g = 254, b = 240},
		Main2 = {r = 248, g = 192, b =  84},
		Main3 = {r = 150, g = 254, b = 240},
		Warn1 = {r = 248, g =  58, b = 106},
	},
	["MEKA2"] = {
		Main0 = {r =   4, g =   4, b =   4},
		Main1 = {r = 150, g = 254, b = 240},
		Main2 = {r = 248, g = 192, b =  84},
		Main3 = {r = 248, g = 192, b =  84},
		Warn1 = {r = 248, g =  58, b = 106},
	},
	["Overwatch1"] = {
		Main0 = {r =   4, g =   4, b =   4},
		Main1 = {r = 243, g = 244, b = 246},
		Main2 = {r = 248, g = 192, b =  84},
		Main3 = {r = 243, g = 244, b = 246},
		Warn1 = {r = 248, g =  58, b = 106},
	},
	["Overwatch2"] = {
		Main0 = {r =   4, g =   4, b =   4},
		Main1 = {r = 243, g = 244, b = 246},
		Main2 = {r = 248, g = 192, b =  84},
		Main3 = {r =  18, g = 234, b = 252},
		Warn1 = {r = 248, g =  58, b = 106},
	},
	["Blue1"] = {
		Main0 = {r =   4, g =   4, b =   4},
		Main1 = {r =  18, g = 234, b = 252},
		Main2 = {r = 248, g = 192, b =  84},
		Main3 = {r =  18, g = 234, b = 252},
		Warn1 = {r = 248, g =  58, b = 106},
	},
	["Blue2"] = {
		Main0 = {r =   4, g =   4, b =   4},
		Main1 = {r =  18, g = 234, b = 252},
		Main2 = {r = 248, g = 192, b =  84},
		Main3 = {r = 248, g = 192, b =  84},
		Warn1 = {r = 248, g =  58, b = 106},
	},
	["Valkyrja1"] = {
		Main0 = {r =   4, g =   4, b =   4},
		Main1 = {r = 234, g = 162, b =  44},
		Main2 = {r =  18, g = 234, b = 252},
		Main3 = {r = 234, g = 162, b =  44},
		Warn1 = {r = 248, g =  58, b = 106},
	},
}

--- ------------------------------------------------------------
--> Color Pick
--- ------------------------------------------------------------

local Quafe_Color = CreateFrame("Frame", nil, E)

local function Quafe_Color_Load()
	local theme = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.State or "MEKA1"
	if theme == "UD" then
		C.Color.Main1 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main1
		C.Color.Main2 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main2
		C.Color.Main3 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main3
		C.Color.Warn1 = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Warn1
	else
		if not C.Color.Theme[theme] then theme = "MEKA1" end
		C.Color.Main1 = C.Color.Theme[theme].Main1
		C.Color.Main2 = C.Color.Theme[theme].Main2
		C.Color.Main3 = C.Color.Theme[theme].Main3
		C.Color.Warn1 = C.Color.Theme[theme].Warn1
	end
end

local function ColorDropdown_Create()
	local DorpMenu = {}
	local num = 2
	DorpMenu[1] = {
		Text = L['User-Defined'],
		Click = function(self, button)
			Quafe_UDF_ColorPick: Show()
		end,
	}
	for k,v in pairs(C.Color.Theme) do
		DorpMenu[num] = {
			--Text = format("%sCO|r%sL|r%sO|r%sR|r", F.Hex(v.Main1), F.Hex(v.Main2), F.Hex(v.Main3), F.Hex(v.Warn1)),■
			Text = format("%sColor ■|r%s ■|r%s ■|r%s ■|r", F.Hex(v.Main1), F.Hex(v.Main2), F.Hex(v.Main3), F.Hex(v.Warn1)),
			Click = function(self, button)
				Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.State = k
				Quafe_NoticeReload()
			end,
		}
		num = num + 1
	end

	return DorpMenu
end

local Quafe_Color_Config = {
	Database = {
		["Quafe_Color"] = {
			State = "MEKA1",
			Main1 = C.Color.Theme.MEKA1.Main1,
			Main2 = C.Color.Theme.MEKA1.Main2,
			Main3 = C.Color.Theme.MEKA1.Main3,
			Warn1 = C.Color.Theme.MEKA1.Warn1,
		},
	},

	Config = {
		Name = L['COLOR'],
		Type = "Dropdown",
		Show = function(self)
			local theme = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.State
			if theme then
				local color = C.Color.Theme[theme]
				if theme == "UD" then
					self.Text:SetText(L['User-Defined'])
				elseif color then
					self.Text:SetText(format("%sColor ■|r%s ■|r%s ■|r%s ■|r", F.Hex(color.Main1), F.Hex(color.Main2), F.Hex(color.Main3), F.Hex(color.Warn1)))
				end
			end
		end,
		DropMenu = ColorDropdown_Create(),
	},
}

Quafe_Color.Load = Quafe_Color_Load
Quafe_Color.Config = Quafe_Color_Config
tinsert(E.Module, Quafe_Color)