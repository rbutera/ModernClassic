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
local modf = math.modf

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

local GetTime = GetTime

--- ------------------------------------------------------------
--> Assistants Init
--- ------------------------------------------------------------

local Quafe_Assistant = CreateFrame("Frame", "Quafe_Assistant", E)

--- ------------------------------------------------------------
--> SoulStone
--- ------------------------------------------------------------

--UNIT_SPELLCAST_START
--arg1 Unit casting the spell
--arg2 Spell lineID counter
--arg3 Spell ID (added in 4.0)

--"UNIT_SPELLCAST_SENT"
--arg1 Unit casting the spell
--arg2 <no longer produced>
--arg3 Complex string similar to a GUID. For Flare this appeared: Cast-3-3783-1-7-1543-000197DD84. 1543 is the SpellID. Identification of the rest of that string is needed.
--arg4 Varies. Occasionally the Spell ID, but not always. Occasionally the target, but not always.

--local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("unit")

local SoulStone_List = {
	20707, --灵魂石
	20484, --复生
	61999, --复活盟友
}

local function SoulStoneNotification_StyleName(name)
	if UnitIsPlayer(name) then
		local eClass = select(2, UnitClass(name))
		local eColor = C.Color.Class[eClass] or C.Color.White
		return string.format("\124Hunit:%s:%s\124h%s[%s]\124r\124h", UnitGUID(name), name, F.Hex(eColor), name)
	else
		return "["..name.."]"
	end
end

local function SoulStoneNotification_Event(self, event, ...)
	local arg1, arg2, arg3, arg4 = ...
	if event == "UNIT_SPELLCAST_SENT" then
		if arg1 == "player" and tContains(SoulStone_List, arg4) then
			self.TargetName = arg2
		end
	end
	if event == "UNIT_SPELLCAST_START" then
		if arg1 == "player" and tContains(SoulStone_List, arg3) then
			if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone then
				if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone == "player" then
					DEFAULT_CHAT_FRAME:AddMessage(GetSpellLink(arg3).." >>> "..SoulStoneNotification_StyleName(self.TargetName))
				elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone == "instance" then
					if self.TargetName == F.PlayerName then
						DEFAULT_CHAT_FRAME:AddMessage(GetSpellLink(arg3).." >>> "..SoulStoneNotification_StyleName(self.TargetName))
					else
						SendChatMessage(GetSpellLink(arg3).." >>> "..SoulStoneNotification_StyleName(self.TargetName), IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup(1) and "PARTY")
					end
				end
			end
		end
	end
end

local function SoulStoneNotification_OnEvent(frame)
	frame:RegisterEvent("UNIT_SPELLCAST_SENT")
	frame:RegisterEvent("UNIT_SPELLCAST_START")
	frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	frame: SetScript("OnEvent", function(self, event, ...)
		SoulStoneNotification_Event(self, event, ...)
	end)
end

local function Quafe_SSN_Toggle(arg)
	if arg == "ON" then
		if not Quafe_Assistant.SSN.Init then
			SoulStoneNotification_OnEvent(Quafe_Assistant.SSN)
			Quafe_Assistant.SSN.Init = true
			Quafe_Assistant.SSN.RE = true
		elseif not Quafe_Assistant.SSN.RE then
			Quafe_Assistant.SSN:RegisterEvent("UNIT_SPELLCAST_SENT")
			Quafe_Assistant.SSN:RegisterEvent("UNIT_SPELLCAST_START")
			Quafe_Assistant.SSN.RE = true
		end
	elseif arg == "OFF" then
		if Quafe_Assistant.SSN.RE then
			Quafe_Assistant.SSN:UnregisterEvent("UNIT_SPELLCAST_SENT")
			Quafe_Assistant.SSN:UnregisterEvent("UNIT_SPELLCAST_START")
			Quafe_Assistant.SSN.RE = false
		end
	end
end

local function SoulStoneNotification_Create(frame)
	local SSN = CreateFrame("Frame", nil, frame)
	SSN.Init = false
	SSN.RE = false
	frame.SSN = SSN

	if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone then
		Quafe_SSN_Toggle("ON")
	end
end

--- ------------------------------------------------------------
--> 职业大厅信息栏
--- ------------------------------------------------------------

local Quafe_SkinOrderHall = CreateFrame("Frame", nil, E)
Quafe_SkinOrderHall.Info = {}
Quafe_SkinOrderHall.Init = false

local function SkinOrderHall_New()
	OrderHallCommandBar.Background: SetAlpha(0.5)
	OrderHallCommandBar.Background: SetTexture(F.Path("StatusBar\\Raid"))
	OrderHallCommandBar.Background: SetVertexColor(F.Color(C.Color.W1))
end

local function SkinOrderHall_Old()
	OrderHallCommandBar.Background: SetAlpha(Quafe_SkinOrderHall.Info.Alpha)
	OrderHallCommandBar.Background: SetTexture(Quafe_SkinOrderHall.Info.Texture)
	OrderHallCommandBar.Background: SetVertexColor(Quafe_SkinOrderHall.Info.Color)
end

local function SkinOrderHall_Load()
	if F.IsClassic then return end
	if (not IsAddOnLoaded("Blizzard_OrderHallUI")) then
		LoadAddOn("Blizzard_OrderHallUI")
	end
	Quafe_SkinOrderHall.Info.Alpha = OrderHallCommandBar.Background:GetAlpha()
	Quafe_SkinOrderHall.Info.Texture = OrderHallCommandBar.Background:GetTexture()
	Quafe_SkinOrderHall.Info.Color = OrderHallCommandBar.Background:GetVertexColor()
	SkinOrderHall_New()
	Quafe_SkinOrderHall.Init = true
end

local function Quafe_SOH_Toggle(arg)
	if arg == "ON" then
		if not Quafe_SkinOrderHall.Init then
			SkinOrderHall_Load()
		else
			SkinOrderHall_New()
		end
	elseif arg == "OFF" then
		SkinOrderHall_Old()
	end
end

--- ------------------------------------------------------------
--> Character Frame
--- ------------------------------------------------------------

local Quafe_CharacterFrame = CreateFrame("Frame", nil, E)
Quafe_CharacterFrame.Init = false



--- ------------------------------------------------------------
--> Assistants
--- ------------------------------------------------------------

local function Quafe_Assistant_Load()
	SoulStoneNotification_Create(Quafe_Assistant)
	if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SkinOrderHall then
		SkinOrderHall_Load()
	end
end

local Quafe_Assistant_Config = {
	Database = {
		["Quafe_Assistant"] = {
			SoulStone = false,
			SkinOrderHall = true,
		},
	},

	Config = {
		Name = L['ASSISTANT'],
		Type = "Blank", --Switch, Trigger, Blank, Dropdown
		Sub = {
			[1] = {
				Name = L['AUTO_SCALE'],
				Text = L['START'],
				Type = "Trigger",
				Click = function(self, button)
					F.AutoScale()
				end,
				Show = function(self)

				end,
			},
			[2] = {
				Name = L['RESURRECTION_NOTIFICATION'],
				Text = L["OFF"],
				Type = "Dropdown",
				Click = function(self, button)

				end,
				Load = function(self)

				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone then
						if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone == "player" then
							self.Text:SetText(L['PLAYER'])
						elseif Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone == "instance" then
							self.Text:SetText(INSTANCE)
						end
					else
						self.Text:SetText(L["OFF"])
					end
				end,
				DropMenu = {
					[1] = {
						Text = L['OFF'],
						Click = function(self, button) 
							Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone = false
							Quafe_SSN_Toggle("OFF")
						end,
					},
					[2] = {
						Text = L['PLAYER'],
						Click = function(self, button) 
							Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone = "player"
							Quafe_SSN_Toggle("ON")
						end,
					},
					[3] = {
						Text = INSTANCE,
						Click = function(self, button) 
							Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SoulStone = "instance"
							Quafe_SSN_Toggle("ON")
						end,
					},
				},
			},
			[3] = {
				Name = L['SKIN_ORDERHALL'],
				Type = "Switch",
				Click = function(self, button)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SkinOrderHall then
						Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SkinOrderHall = false
						self.Text:SetText(L["OFF"])
						Quafe_SOH_Toggle("OFF")
					else
						Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SkinOrderHall = true
						self.Text:SetText(L["ON"])
						Quafe_SOH_Toggle("ON")
					end
				end,
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Assistant.SkinOrderHall then
						self.Text:SetText(L["ON"])
					else
						self.Text:SetText(L["OFF"])
					end
				end,
			},
		},
	},
}

Quafe_Assistant.Load = Quafe_Assistant_Load
Quafe_Assistant.Config = Quafe_Assistant_Config
tinsert(E.Module, Quafe_Assistant)