local MEKA = unpack(select(2, ...))  -->Engine
local E, C, F, L = unpack(Quafe)  -->Engine, Config, Function, Locale

----------------------------------------------------------------
--> API Localization
----------------------------------------------------------------

local _G = getfenv(0)
local format = string.format
local find = string.find
local match = string.match

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
local deg = math.deg

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

local MEKA_HUD = CreateFrame("Frame", nil, E)

local function MEKA_HUD_Toggle(arg1, arg2)
    if not arg1 then
        if arg2 == "OFF" then
            F.MEKA_LOOPHUD_Toggle("OFF")
            F.MEKA_RINGHUD_Toggle("OFF")
            --F.MEKA_Totem_Toggle("OFF")
        elseif arg2 == "LOOP" then
            F.MEKA_LOOPHUD_Toggle("ON")
            F.MEKA_RINGHUD_Toggle("OFF")
            F.MEKA_FCS_Toggle("REFRESH")
            --F.MEKA_Totem_Toggle("ON")
        elseif arg2 == "RING" then
            F.MEKA_LOOPHUD_Toggle("OFF")
            F.MEKA_RINGHUD_Toggle("ON")
            F.MEKA_FCS_Toggle("REFRESH")
            --F.MEKA_Totem_Toggle("ON")
        end
    elseif arg1 == "LOOP" then
        F.MEKA_LOOPHUD_Toggle(arg2)
    elseif arg1 == "RING" then
        F.MEKA_RINGHUD_Toggle(arg2)
        F.MEKA_Class_Toggle("Refresh")
    elseif arg1 == "SCALE" then
        F.MEKA_LOOPHUD_Toggle(arg2)
        F.MEKA_RINGHUD_Toggle(arg2)
        F.MEKA_FCS_Toggle(arg2)
        F.MEKA_Class_Toggle(arg2)
        F.MEKA_CastBar_Toggle(arg2)
        --F.MEKA_Totem_Toggle(arg2)
    end
end

local MEKA_HUD_Config = {
    Database = {
		["MEKA_HUD"] = {
			State = "LOOP",
            Scale = 1,
            LoopPowerNum = true,
            RingTopLeftTrack = "ABSORB",
            CombatShow = true,
		},
	},

    Config = {
        Name = "MEKA HUD",
        Type = "Dropdown",
        Load = function(self)
            if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State then
                self.Config.SubState = Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State
            end
        end,
        Show = function(self)
            if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State then
				self.Text:SetText(L['MEKAHUD'][Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State])
			end
        end,
        DropMenu = {
            [1] = {
                Text = L['MEKAHUD']['OFF'],
                State = "OFF",
                Click = function(self, button)
                    Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State = "OFF"
                    MEKA_HUD_Toggle(nil, "OFF")
                end,
            },
            [2] = {
                Text = L['MEKAHUD']['LOOP'],
                State = "LOOP",
                Click = function(self, button)
                    Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State = "LOOP"
                    MEKA_HUD_Toggle(nil, "LOOP")
                end,
            },
            [3] = {
                Text = L['MEKAHUD']['RING'],
                State = "RING",
                Click = function(self, button)
                    Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.State = "RING"
                    MEKA_HUD_Toggle(nil, "RING")
                end,
            },
        },
        SubRefresh = {
            [1] = {
                Name = L['SCALE'],
                Type = "Slider",
                State = "ALL",
				Click = nil,
                Load = function(self)
                    self.Slider: SetMinMaxValues(0.5, 2)
					self.Slider: SetValueStep(0.05)
                    self.Slider: SetValue(Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale)
					self.Slider: HookScript("OnValueChanged", function(s, value)
                        value = floor(value*100+0.5)/100
						MEKA_HUD_Toggle("SCALE", value)
                        Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.Scale = value
					end)
                end,
                Show = nil,
            },
            [2] = {
                Name = L['COMBAT_SHOW'],
                Type = "Switch",
                State = "ALL",
                Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.CombatShow then
						Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.CombatShow = false
						self.Text:SetText(L["OFF"])
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.CombatShow = true
						self.Text:SetText(L["ON"])
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.CombatShow then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
            },
            [3] = {
                Name = L['POWER_NUM'],
				Type = "Switch",
                State = "LOOP",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.LoopPowerNum then
						Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.LoopPowerNum = false
						self.Text:SetText(L["OFF"])
                        MEKA_HUD_Toggle("LOOP", "PowerNum_OFF")
                        
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.LoopPowerNum = true
						self.Text:SetText(L["ON"])
                        MEKA_HUD_Toggle("LOOP", "PowerNum_ON")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.LoopPowerNum then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
            },
            [4] = {
				Name = L['RING_TOPLEFT'],
				Type = "Dropdown",
                State = "RING",
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack then
						self.Text:SetText(L['RING_TL'][Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack])
					end
				end,
				DropMenu = {
					[1] = {
						Text = L['RING_TL']["COMBO"],
						Click = function(self, button)
							Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack = "COMBO"
                            MEKA_HUD_Toggle("RING", "COMBO")
						end,
					},
					[2] = {
						Text = L['RING_TL']["ABSORB"],
						Click = function(self, button)
							Quafe_DB.Profile[Quafe_DBP.Profile].MEKA_HUD.RingTopLeftTrack = "ABSORB"
                            MEKA_HUD_Toggle("RING", "ABSORB")
						end,
					},
				},
			},
        },
    },
}

MEKA_HUD.Config = MEKA_HUD_Config
local moduelnum = #E.Module
insert(E.Module, moduelnum-5, MEKA_HUD)