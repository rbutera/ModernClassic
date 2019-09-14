local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

----------------------------------------------------------------
--> API Localization
----------------------------------------------------------------

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

----------------------------------------------------------------
--> Load
----------------------------------------------------------------

--> sourced from Blizzard_ArenaUI/Blizzard_ArenaUI.lua
local MAX_ARENA_ENEMIES = MAX_ARENA_ENEMIES or 5
--> sourced from FrameXML/TargetFrame.lua
local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES or 5
--> sourced from FrameXML/PartyMemberFrame.lua
local MAX_PARTY_MEMBERS = MAX_PARTY_MEMBERS or 4

local BlizzardFrameHide = CreateFrame("Frame", nil, E)
local function Load()
	if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PlayerFrame == false then
		F.HideUnitFrame("PlayerFrame")
	end
	if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.TargetFrame == false then
		F.HideUnitFrame("TargetFrame")
	end
	if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.FocusFrame == false then
		F.HideUnitFrame("FocusFrame")
	end
	if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PartyFrame == false then
		for i = 1, MAX_PARTY_MEMBERS do
			F.HideUnitFrame(string.format('PartyMemberFrame%d', i))
		end
	end
	if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.BossFrame == false then
		for i = 1, MAX_BOSS_FRAMES do
			F.HideUnitFrame(string.format('Boss%dTargetFrame', i))
		end
	end
end
local BlizzardFrameHide_Config = {
	Database = {
		Blizzard = {
			PlayerFrame = false,
			TargetFrame = false,
			FocusFrame = false,
			PartyFrame = false,
			BossFrame = false,
		},
	},

	Config = {
		Name = L["BLIZZARD_FRAMES"],
		Type = "Blank",
		Sub = {
			[1] = {
				Name = L['PLAYER_FRAME'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PlayerFrame then
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PlayerFrame = false
						self.Text:SetText(L["OFF"])
						F.HideUnitFrame("PlayerFrame")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PlayerFrame = true
						self.Text:SetText(L["ON"])
						Quafe_NoticeReload()
					end
				end,
				Show = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PlayerFrame then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
			[2] = {
				Name = L['TARGET_FRAME'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.TargetFrame then
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.TargetFrame = false
						self.Text:SetText(L["OFF"])
						F.HideUnitFrame("TargetFrame")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.TargetFrame = true
						self.Text:SetText(L["ON"])
						Quafe_NoticeReload()
					end
				end,
				Show = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.TargetFrame then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
			[3] = {
				Name = L['FOCUS_FRAME'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.FocusFrame then
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.FocusFrame = false
						self.Text:SetText(L["OFF"])
						F.HideUnitFrame("FocusFrame")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.FocusFrame = true
						self.Text:SetText(L["ON"])
						Quafe_NoticeReload()
					end
				end,
				Show = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.FocusFrame then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
			[4] = {
				Name = L['PARTY_FRAME'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PartyFrame then
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PartyFrame = false
						self.Text:SetText(L["OFF"])
						for i = 1, MAX_PARTY_MEMBERS do
							F.HideUnitFrame(string.format('PartyMemberFrame%d', i))
						end
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PartyFrame = true
						self.Text:SetText(L["ON"])
						Quafe_NoticeReload()
					end
				end,
				Show = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.PartyFrame then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
			[5] = {
				Name = L['BOSS_FRAME'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.BossFrame then
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.BossFrame = false
						self.Text:SetText(L["OFF"])
						for i = 1, MAX_BOSS_FRAMES do
							F.HideUnitFrame(string.format('Boss%dTargetFrame', i))
						end
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.BossFrame = true
						self.Text:SetText(L["ON"])
						Quafe_NoticeReload()
					end
				end,
				Show = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Blizzard.BossFrame then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}
BlizzardFrameHide.Load = Load
BlizzardFrameHide.Config = BlizzardFrameHide_Config
tinsert(E.Module, BlizzardFrameHide)


