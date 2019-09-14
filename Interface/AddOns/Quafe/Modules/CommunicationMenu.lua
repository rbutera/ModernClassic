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
--> API and Variable
--- ------------------------------------------------------------

local function Create_Backdrop(f, e, d, c1,a1, c2,a2)
	local backdrop = {
		bgFile = F.Path("StatusBar\\Flat"), 
		edgeFile = F.Path("White"), 
		tile = false, tileSize = 1, edgeSize = e, 
		insets = { left = d, right = d, top = d, bottom = d }
	}
	f: SetBackdrop(backdrop)
	f: SetBackdropColor(F.Color(c1, a1))
	f: SetBackdropBorderColor(F.Color(c2, a2))
end

--- ------------------------------------------------------------
--> Xp
--- ------------------------------------------------------------

local FactionStandingID = {
	[0] = "Unknown",
	[1] = "Hated",
	[2] = "Hostile",
	[3] = "Unfriendly",
	[4] = "Neutral",
	[5] = "Friendly",
	[6] = "Honored",
	[7] = "Revered",
	[8] = "Exalted",
}

local XPBAR_LIST = {ExpBar, HonorBar, FactionBar, ArtifactBar}

local function XpBar_Update(self)
	local barNum = 0
	if self.ShowExp then
		barNum = barNum + 1
		self.ExpBar: SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0,50*(barNum-1))
		self.ExpBar: Show()
	else
		self.ExpBar: Hide()
	end
	if self.ShowHonor then
		barNum = barNum + 1
		self.HonorBar: SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0,50*(barNum-1))
		self.HonorBar: Show()
	else
		self.HonorBar: Hide()
	end
	if self.ShowFaction then
		barNum = barNum + 1
		self.FactionBar: SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0,50*(barNum-1))
		self.FactionBar: Show()
	else
		self.FactionBar: Hide()
	end
	if self.ShowArtifact then
		barNum = barNum + 1
		self.ArtifactBar: SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0,50*(barNum-1))
		self.ArtifactBar: Show()
	else
		self.ArtifactBar: Hide()
	end
end

local function XpBar_Templet(f)
	f.BarBg = f:CreateTexture(nil, "BORDER")
	f.BarBg: SetTexture(F.Path("CommunicationMenu\\XpBar1"))
	f.BarBg: SetVertexColor(F.Color(C.Color.W2))
	f.BarBg: SetAlpha(1)
	f.BarBg: SetSize(319,7)
	f.BarBg: SetTexCoord(0/512,319/512, 0/8,7/8)
	f.BarBg: SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0,20)
	
	f.Bar = f:CreateTexture(nil, "OVERLAY")
	f.Bar: SetTexture(F.Path("CommunicationMenu\\XpBar1"))
	f.Bar: SetVertexColor(F.Color(C.Color.Y2))
	f.Bar: SetAlpha(1)
	f.Bar: SetSize(219,7)
	f.Bar: SetTexCoord(0/512,219/512, 0/8,7/8)
	f.Bar: SetPoint("LEFT", f.BarBg, "LEFT", 0,0)

	f.ExBar = f:CreateTexture(nil, "ARTWORK")
	f.ExBar: SetTexture(F.Path("CommunicationMenu\\XpBar1"))
	f.ExBar: SetVertexColor(F.Color(C.Color.B1))
	f.ExBar: SetAlpha(0)
	f.ExBar: SetSize(219,7)
	f.ExBar: SetTexCoord(0/512,219/512, 0/8,7/8)
	f.ExBar: SetPoint("LEFT", f.BarBg, "LEFT", 0,0)
	
	f.Num = F.create_Font(f, C.Font.NumSmall, 13, nil, 0)
	f.Num: SetAlpha(1)
	f.Num: SetPoint("TOPLEFT", f.BarBg, "BOTTOMLEFT", 2,-2)
	f.Num: SetText(F.Hex(C.Color.W3).."10000".."|r"..F.Hex(C.Color.B1).." / 10000".."|r")
	
	f.Lv = F.create_Font(f, C.Font.NumSmall, 13, nil, 0)
	f.Lv: SetAlpha(1)
	f.Lv: SetPoint("TOPRIGHT", f.BarBg, "BOTTOMRIGHT", -2,-2)
	f.Lv: SetText("")

	f.Txt = F.create_Font(f, C.Font.Txt, 12, nil, 0)
	f.Txt: SetAlpha(1)
	f.Txt: SetPoint("TOPRIGHT", f.BarBg, "BOTTOMRIGHT", -2,-2)
	f.Txt: SetText("")
end

local function Exp_Bar(frame)
	local ExpBar = CreateFrame("Button", nil, frame)
	ExpBar:SetSize(319, frame.NormalHeight)
	XpBar_Templet(ExpBar)
	ExpBar: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,0)
	ExpBar.ExBar: SetAlpha(1)
	
	ExpBar: RegisterEvent("PLAYER_ENTERING_WORLD")
	ExpBar: RegisterEvent("PLAYER_XP_UPDATE")
	ExpBar: RegisterEvent("UPDATE_EXHAUSTION");
	--ExpBar: RegisterEvent("PLAYER_LEVEL_UP");
	ExpBar: RegisterUnitEvent("UNIT_LEVEL", "player")
	ExpBar: RegisterEvent("PLAYER_UPDATE_RESTING");
	ExpBar: SetScript("OnEvent", function(self, event, ...)
		local newLevel = UnitLevel("player")
		frame.ShowExp = (newLevel < MAX_PLAYER_LEVEL) and (F.IsClassic or (not IsXPUserDisabled()));
		if frame.ShowExp then
			local d, dMax, dPer, dLv, dEx, dExPer = 0,0,0,0,0,0
			d = UnitXP("player")
			dMax = UnitXPMax("player")
			dPer = min(d/dMax, 1)
			dLv = newLevel
			dEx = GetXPExhaustion() or 0
			dExPer = min((d+dEx)/dMax, 1)
			self.Bar: SetSize(319*dPer+F.Debug,7)
			self.Bar: SetTexCoord(0/512,319*dPer/512, 0/8,7/8)
			self.ExBar: SetSize(319*dExPer+F.Debug,7)
			self.ExBar: SetTexCoord(0/512,319*dExPer/512, 0/8,7/8)
			self.Num: SetText(F.Hex(C.Color.W3)..F.FormatNum(d, 1).."|r"..F.Hex(C.Color.B1).." / "..F.FormatNum(dMax, 1)..format(" / %.2f", dPer*100).."%".."|r")
			self.Lv: SetText(F.Hex(C.Color.W3).."Lv "..dLv.."|r")
		end
		if event == "PLAYER_ENTERING_WORLD" or event == "UNIT_LEVEL" or event == "PLAYER_XP_UPDATE" then
			local AlreadyShown = ExpBar:IsShown()
			if frame.ShowExp and (not AlreadyShown) then
				self:SetHeight(frame.NormalHeight)
				self:Show()
			elseif (not frame.ShowExp) and AlreadyShown then
				self:SetHeight(F.Debug)
				self:Hide()
			end
		end
	end)
	ExpBar: SetScript("OnEnter", function(self)
		if F.IsClassic then return end
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("LEFT", self, "RIGHT", 8,2)
		local label
		label = XPBAR_LABEL
		if (GameLimitedMode_IsActive()) then
			local rLevel = GetRestrictedAccountData()
			if UnitLevel("player") >= rLevel then
				local trialXP = UnitTrialXP("player")
				local bankedLevels = UnitTrialBankedLevels("player")
				if (trialXP > 0) then
					local text = TRIAL_CAP_BANKED_XP_TOOLTIP;
					if (bankedLevels > 0) then
						text = TRIAL_CAP_BANKED_LEVELS_TOOLTIP:format(bankedLevels);
					end
					GameTooltip:SetText(text, nil, nil, nil, nil, true);
					GameTooltip:Show();
					if (IsTrialAccount()) then
						MicroButtonPulse(StoreMicroButton);
					end
					return
				else
					label = label.." "..RED_FONT_COLOR_CODE..CAP_REACHED_TRIAL.."|r";
				end
			end
		end
		GameTooltip_AddNewbieTip(self, label, 1.0, 1.0, 1.0, NEWBIE_TOOLTIP_XPBAR, 1)

		local level,maxlevel = UnitLevel("Player"),GetMaxPlayerLevel()
		local XP, maxXP = UnitXP("player"), UnitXPMax("player")
		local XPe = GetXPExhaustion() or 0
		local percent = (XP/maxXP) * 100
		local exhaustionStateID, exhaustionStateName, exhaustionStateMultiplier = GetRestState()
		exhaustionStateMultiplier = exhaustionStateMultiplier * 100
		
		local t1 = select(2, string.find(EXHAUST_TOOLTIP1, "\n"))
		local t2 = select(2, string.find(EXHAUST_TOOLTIP1, "\n", t1+1))
		local NEW_EXHAUST_TOOLTIP1 = string.sub(EXHAUST_TOOLTIP1, t1+1, t2-1)..string.sub(EXHAUST_TOOLTIP1, t2+1)
		local tooltipText = format(NEW_EXHAUST_TOOLTIP1, exhaustionStateMultiplier)
		local append = nil;
		local exhaustionCountdown
		if ( GetTimeToWellRested() ) then
			exhaustionCountdown = GetTimeToWellRested() / 60;
		end
		if ( IsResting() ) then
			if ( XPe and exhaustionCountdown ) then
				append = format(EXHAUST_TOOLTIP4, exhaustionCountdown);
			end
		elseif ( (exhaustionStateID == 4) or (exhaustionStateID == 5) ) then
			append = EXHAUST_TOOLTIP2;
		end
		if ( append ) then
			tooltipText = tooltipText..append;
		end

		GameTooltip:SetText(XP_STATUS_BAR_TEXT:format(XP, maxXP))
		GameTooltip:AddLine(format("%.2f", percent).."%", 1, 1, 1)
		--GameTooltip:SetText(XPBAR_LABEL.." "..format("%.2f", percent).."%", 1, 1, 1)
		if XPe > 0 then
			GameTooltip:AddLine("\n"..exhaustionStateName.." "..BreakUpLargeNumbers(XPe), 1,1,1, true)
		else
			GameTooltip:AddLine("\n"..exhaustionStateName, 1,1,1, true)
		end
		GameTooltip:AddLine(tooltipText)
		GameTooltip:Show()
	end)
	ExpBar: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	frame.ExpBar = ExpBar
end

local function Faction_Bar(frame)
	local FactionBar =  CreateFrame("Button", nil, frame)
	FactionBar:SetSize(319, frame.NormalHeight)
	XpBar_Templet(FactionBar)
	FactionBar: SetPoint("BOTTOMLEFT", frame.ExpBar, "TOPLEFT", 0,0)

	FactionBar: RegisterEvent("PLAYER_ENTERING_WORLD")
	FactionBar: RegisterEvent("UPDATE_FACTION")
	--FactionBar: RegisterEvent("CVAR_UPDATE")
	FactionBar: SetScript("OnEvent", function(self, event, ...)
		local FactionName, FactionStanding, FactionLvMin, FactionLvMax, FactionValue, FactionID = GetWatchedFactionInfo()
		frame.ShowFaction = FactionName
		self.FactionName = FactionName
		if frame.ShowFaction then
			local d, dMax, dPer, dLv, dEx, dExPer = 0,0,0,0,0,0
			if F.IsClassic then
				d = FactionValue - FactionLvMin
				dMax = FactionLvMax - FactionLvMin
				if FactionStanding == MAX_REPUTATION_REACTION then
					dPer = 1
				else
					dPer = min(d/dMax, 1)
				end
				dLv = L.FactionStandingID[FactionStanding]
			else
				local friendID = GetFriendshipReputation(FactionID) 
				if friendID then
					local _, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(FactionID)
					if ( nextFriendThreshold ) then
						d = friendRep - friendThreshold
						dMax = nextFriendThreshold - friendThreshold
						dPer = min(d/dMax, 1)
						dLv = friendTextLevel
						dEx = 0
						dExPer = 0
					else
						d = 0
						dMax = 0
						dPer = 1
						dLv = friendTextLevel
						dEx = 0
						dExPer = 0
					end
				elseif (C_Reputation.IsFactionParagon(FactionID)) then
					local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(FactionID)
					d = currentValue % threshold
					dMax = threshold - 0
					dPer = min(d/dMax, 1)
					dLv = L.FactionStandingID[9]
					dEx = 0
					dExPer = 0
				else
					d = FactionValue - FactionLvMin
					dMax = FactionLvMax - FactionLvMin
					if FactionStanding == MAX_REPUTATION_REACTION then
						dPer = 1
					else
						dPer = min(d/dMax, 1)
					end
					dLv = L.FactionStandingID[FactionStanding]
				end
			end
			self.Bar: SetSize(319*dPer+F.Debug,7)
			self.Bar: SetTexCoord(0/512,319*dPer/512, 0/8,7/8)
			self.Num: SetText(F.Hex(C.Color.W3)..BreakUpLargeNumbers(d).."|r"..F.Hex(C.Color.B1).." / "..BreakUpLargeNumbers(dMax)..format(" / %.2f", dPer*100).."%".."|r")
			self.Txt: SetText(F.Hex(C.Color.W3)..dLv.."|r")
		end
		if event == "PLAYER_ENTERING_WORLD" or event == "UPDATE_FACTION" then
			--XpBar_Update(frame)
			local AlreadyShown = self:IsShown()
			if frame.ShowFaction and (not AlreadyShown) then
				self:SetHeight(frame.NormalHeight)
				self:Show()
			elseif (not frame.ShowFaction) and AlreadyShown then
				self:SetHeight(F.Debug)
				self:Hide()
			end
		end
	end)
	FactionBar: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("LEFT", self, "RIGHT", 8,2)
		GameTooltip: SetText(self.FactionName)
		GameTooltip:Show();
	end)
	FactionBar: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	frame.FactionBar = FactionBar
end

local function Honor_Bar(frame)
	local HonorBar =  CreateFrame("Button", nil, frame)
	HonorBar:SetSize(319, frame.NormalHeight)
	XpBar_Templet(HonorBar)
	HonorBar: SetPoint("BOTTOMLEFT", frame.FactionBar, "TOPLEFT", 0,0)
	HonorBar.ExBar: SetAlpha(1)

	HonorBar: RegisterEvent("PLAYER_ENTERING_WORLD")
	if not F.IsClassic then
		HonorBar: RegisterEvent("HONOR_XP_UPDATE")
		HonorBar: RegisterEvent("HONOR_LEVEL_UPDATE")
	end
	----HonorBar: RegisterEvent("HONOR_PRESTIGE_UPDATE")
	HonorBar: RegisterEvent("CVAR_UPDATE")
	HonorBar: SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" or event == "CVAR_UPDATE" then
			--frame.ShowHonor = IsWatchingHonorAsXP() or InActiveBattlefield() or IsInActiveWorldPVP()
			frame.ShowHonor = true
			local AlreadyShown = self:IsShown()
			if frame.ShowHonor and (not AlreadyShown) then
				self:SetHeight(frame.NormalHeight)
				self:Show()
			elseif (not frame.ShowHonor) and AlreadyShown then
				self:SetHeight(F.Debug)
				self:Hide()
			end
		end
		if frame.ShowHonor then
			local d, dMax, dPer, dLv = 0,0,0,0
			d = UnitHonor("player");
			dMax = max(UnitHonorMax("player"), 1)
			dPer = min(d/dMax, 1)
			dLv = UnitHonorLevel("player");
			self.Bar: SetSize(319*dPer+F.Debug,7)
			self.Bar: SetTexCoord(0/512,319*dPer/512, 0/8,7/8)
			self.Num: SetText(F.Hex(C.Color.W3)..F.FormatNum(d, 1).."|r"..F.Hex(C.Color.B1).." / "..F.FormatNum(dMax, 1)..format(" / %.2f", dPer*100).."%".."|r")
			self.Lv: SetText(F.Hex(C.Color.W3).."Lv "..dLv.."|r")
		end
	end)
	HonorBar: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("LEFT", self, "RIGHT", 8,2)
		local current = UnitHonor("player");
		local max = UnitHonorMax("player");
		GameTooltip: SetText(HONOR_BAR:format(current, max))
		GameTooltip:Show();
	end)
	HonorBar: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	frame.HonorBar = HonorBar
end



local function Artifact_Bar(frame)
	local ArtifactBar =  CreateFrame("Button", nil, frame)
	ArtifactBar:SetSize(319, frame.NormalHeight)
	XpBar_Templet(ArtifactBar)
	ArtifactBar: SetPoint("BOTTOMLEFT", frame.HonorBar, "TOPLEFT", 0,0)

	ArtifactBar: RegisterEvent("PLAYER_ENTERING_WORLD")
	ArtifactBar: RegisterEvent("ARTIFACT_UPDATE")
	ArtifactBar: RegisterEvent("ARTIFACT_XP_UPDATE")
	ArtifactBar: RegisterEvent("UNIT_INVENTORY_CHANGED")
	ArtifactBar: RegisterEvent("CVAR_UPDATE")
	ArtifactBar: RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	ArtifactBar: SetScript("OnEvent", function(self, event, ...)
		frame.ShowArtifact = HasArtifactEquipped()
		if frame.ShowArtifact then
			local d, dMax, dPer, dLv, dEx, dExPer = 0,0,0,0,0,0
			local artifactTotalXP, artifactPointsSpent, _, _, _, _, _, _, artifactTier = select(5, C_ArtifactUI.GetEquippedArtifactInfo())
			local numPointsAvailableToSpend, ArtifactValue, ArtifactForNextPoint = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(artifactPointsSpent, artifactTotalXP, artifactTier)
			dPer = min(ArtifactValue/ArtifactForNextPoint, 1)
			d = ArtifactValue
			dMax = ArtifactForNextPoint
			dLv = artifactPointsSpent
			self.Bar: SetSize(319*dPer+F.Debug,7)
			self.Bar: SetTexCoord(0/512,319*dPer/512, 0/8,7/8)
			self.Num: SetText(F.Hex(C.Color.W3)..F.FormatNum(d, 1).."|r"..F.Hex(C.Color.B1).." / "..F.FormatNum(dMax, 1).."|r")
			self.Lv: SetText(F.Hex(C.Color.W3)..dLv.." ("..numPointsAvailableToSpend..")".."|r")
		end
		if event == "PLAYER_ENTERING_WORLD" or event == "CVAR_UPDATE" then
			--XpBar_Update(frame)
			local AlreadyShown = self:IsShown()
			if frame.ShowArtifact and (not AlreadyShown) then
				self:SetHeight(frame.NormalHeight)
				self:Show()
			elseif (not frame.ShowArtifact) and AlreadyShown then
				self:SetHeight(F.Debug)
				self:Hide()
			end
		elseif event == "UNIT_INVENTORY_CHANGED" then
			local unitTag = ...;
			if ( unitTag == "player" ) then
				--XpBar_Update(frame)
				local AlreadyShown = self:IsShown()
				if frame.ShowArtifact and (not AlreadyShown) then
					self:SetHeight(frame.NormalHeight)
					self:Show()
				elseif (not frame.ShowArtifact) and AlreadyShown then
					self:SetHeight(F.Debug)
					self:Hide()
				end
			end
		end
	end)
	ArtifactBar: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("LEFT", self, "RIGHT", 8,2)
		if ArtifactBarMixin.totalXP then
			GameTooltip:SetText(ARTIFACT_POWER_TOOLTIP_TITLE:format(BreakUpLargeNumbers(ArtifactBarMixin.totalXP, true), BreakUpLargeNumbers(ArtifactBarMixin.xp, true), BreakUpLargeNumbers(ArtifactBarMixin.xpForNextPoint, true)), HIGHLIGHT_FONT_COLOR:GetRGB());
			GameTooltip:AddLine(ARTIFACT_POWER_TOOLTIP_BODY:format(ArtifactBarMixin.numPointsAvailableToSpend), nil, nil, nil, true);
			GameTooltip:Show();
		end
	end)
	ArtifactBar: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	frame.ArtifactBar = ArtifactBar
end

local function Azerite_Bar(frame)
	local AzeriteBar =  CreateFrame("Button", nil, frame)
	AzeriteBar:SetSize(319, frame.NormalHeight)
	XpBar_Templet(AzeriteBar)
	AzeriteBar: SetPoint("BOTTOMLEFT", frame.ArtifactBar, "TOPLEFT", 0,0)

	AzeriteBar: RegisterEvent("PLAYER_ENTERING_WORLD")
	AzeriteBar: RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
	--AzeriteBar: RegisterEvent(AZERITE_ITEM_POWER_LEVEL_CHANGED)
	--AzeriteBar: RegisterEvent("CVAR_UPDATE")
	AzeriteBar: RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	AzeriteBar: SetScript("OnEvent", function(self, event, ...)
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem();
		if azeriteItemLocation then
			self.xp, self.totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation);
			self.currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation); 
			self.xpToNextLevel = self.totalLevelXP - self.xp;
			dPer = min(self.xp/self.totalLevelXP, 1)
			self.Bar: SetSize(319*dPer+F.Debug,7)
			self.Bar: SetTexCoord(0/512,319*dPer/512, 0/8,7/8)
			self.Num: SetText(F.Hex(C.Color.W3)..F.FormatNum(self.xp, 1).."|r"..F.Hex(C.Color.B1).." / "..F.FormatNum(self.totalLevelXP, 1)..format(" / %.2f", dPer*100).."%".."|r")
			self.Lv: SetText(F.Hex(C.Color.W3)..self.currentLevel.."|r")
		end
		frame.ShowAzerite = azeriteItemLocation
		local AlreadyShown = self:IsShown()
		if frame.ShowAzerite and (not AlreadyShown) then
			self:SetHeight(frame.NormalHeight)
			self:Show()
		elseif (not frame.ShowAzerite) and AlreadyShown then
			self:SetHeight(F.Debug)
			self:Hide()
		end
	end)
	AzeriteBar: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("LEFT", self, "RIGHT", 8,2)

		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem();
		if azeriteItemLocation then
			local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation); 
			local azeriteItemName = azeriteItem:GetItemName(); 
			GameTooltip:SetText(azeriteItemName)
			GameTooltip:AddLine(AZERITE_POWER_TOOLTIP_TITLE:format(self.currentLevel, self.xpToNextLevel), HIGHLIGHT_FONT_COLOR:GetRGB());
			GameTooltip:AddLine(AZERITE_POWER_TOOLTIP_BODY:format(azeriteItemName), HIGHLIGHT_FONT_COLOR:GetRGB());
			GameTooltip:Show();
		end
	end)
	AzeriteBar: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
end

local function XP_Frame(f)
	local XP = CreateFrame("Frame", nil, f)
	XP: SetSize(10,10)
	XP: SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 100,140)
	XP.NormalHeight = 50

	Exp_Bar(XP)
	Faction_Bar(XP)
	if not F.IsClassic then
		Honor_Bar(XP)
		Artifact_Bar(XP)
		Azerite_Bar(XP)
	end

	f.XP = XP
end

--- ------------------------------------------------------------
--> Currency
--- ------------------------------------------------------------

-- listSize = GetCurrencyListSize()
-- name, isHeader, isExpanded, isUnused, isWatched, count, icon, maximum, hasWeeklyLimit, currentWeeklyAmount, unknown = GetCurrencyListInfo(index)

local backdrop = {
	bgFile = F.Path("White"),
	edgeFile = "",
	tile = true, tileSize = 16, edgeSize = 0,
	insets = {left = 20, right = 0, top = 0, bottom = 0}
}

local function Currency_BarArtwork(f)
	--f: SetBackdrop(backdrop)
	--f: SetBackdropColor(F.Color(C.Color.B1, 0.2))
	
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon: SetAlpha(1)
	f.Icon: SetSize(18,18)
	f.Icon: SetTexCoord(0.08,0.92, 0.08,0.92)
	f.Icon: SetPoint("LEFT", f, "LEFT", 0,0)
	
	f.IconGlow = f:CreateTexture(nil, "OVERLAY")
	f.IconGlow: SetTexture(F.Path("White"))
	f.IconGlow: SetVertexColor(F.Color(C.Color.B1))
	f.IconGlow: SetAlpha(0.3)
	f.IconGlow: SetAllPoints(f.Icon)
	
	f.Name = F.create_Font(f, C.Font.Txt, 13, nil, 0)
	f.Name: SetAlpha(1)
	f.Name: SetTextColor(F.Color(C.Color.W3))
	f.Name: SetPoint("LEFT", f.Icon, "RIGHT", 8,0)
	
	f.Num = F.create_Font(f, C.Font.NumSmall, 13, nil, 0)
	f.Num: SetAlpha(1)
	f.Num: SetTextColor(F.Color(C.Color.W3))
	f.Num: SetPoint("RIGHT", f, "RIGHT", -4,0)
	
	f.Bg = f:CreateTexture(nil, "BACKGROUND")
	f.Bg: SetTexture(F.Path("White"))
	f.Bg: SetVertexColor(F.Color(C.Color.B1))
	f.Bg: SetAlpha(0.2)
	f.Bg: SetPoint("TOPLEFT", f.Icon, "TOPRIGHT", 4, 0)
	f.Bg: SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
end

local TokenList = {}
local function Currency_Update(f)
	local listSize = GetCurrencyListSize()
	local listing = 0
	wipe(TokenList)
	for i = 1, listSize do
		local name, isHeader, isExpanded, isUnused, isWatched, count, icon, maximum, hasWeeklyLimit, currentWeeklyAmount, unknown = GetCurrencyListInfo(i)
		if isHeader then
			listing = listing + 1
		end
		if (not isHeader) and (not isUnused) then
			if (listing == 1) then
				insert(TokenList, {name, i, isExpanded, isUnused, isWatched, count, icon, maximum, hasWeeklyLimit, currentWeeklyAmount})
			elseif isWatched then
				insert(TokenList, {name, i, isExpanded, isUnused, isWatched, count, icon, maximum, hasWeeklyLimit, currentWeeklyAmount})
			end
		end
	end
	local ListNum = #TokenList
	local TokenNum = #f.Token
	for i = 1, ListNum do
		if not f.Token[i] then
			f.Token[i] = CreateFrame("Button", nil, f)
			f.Token[i]: SetSize(280, 18)
			if i == 1 then
				f.Token[i]: SetPoint("TOPLEFT", f, "TOPLEFT", 0,0)
			else
				f.Token[i]: SetPoint("TOPLEFT", f.Token[i-1], "BOTTOMLEFT", 0,-4)
			end
			Currency_BarArtwork(f.Token[i])
			
			f.Token[i]:SetScript("OnEnter", function(self)
				GameTooltip: SetOwner(self, "ANCHOR_BOTTOMRIGHT")
				GameTooltip: SetCurrencyToken(self.ID)
			end)
			f.Token[i]:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)
		end
		f.Token[i]:Show()
		f.Token[i].ID = TokenList[i][2]
		f.Token[i].Icon: SetTexture(TokenList[i][7])
		f.Token[i].Name: SetText(TokenList[i][1])
		if TokenList[i][8] and (TokenList[i][8] > 0) then
			f.Token[i].Num: SetText(format("%s%s/%s|r", TokenList[i][6],F.Hex(C.Color.B1),TokenList[i][8]))
		else
			f.Token[i].Num: SetText(TokenList[i][6])
		end
		if (floor(i/2) == i/2) then
			f.Token[i].Bg: SetVertexColor(F.Color(C.Color.W4))
			--f.Token[i]: SetBackdropColor(F.Color(C.Color.W3, 0.2))
		end
	end
	if TokenNum > ListNum then
		for i = ListNum+1, TokenNum do
			f.Token[i]:Hide()
		end
	end
end

local function Currency_Frame(f)
	local Currency = CreateFrame("Frame", nil, f)
	Currency: SetSize(10,10)
	Currency: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100,-140)
	Currency.Token = {}
	
	--Currency: RegisterEvent("PLAYER_ENTERING_WORLD")
	Currency: RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	--Currency: RegisterEvent("CHAT_MSG_CURRENCY")
	Currency: SetScript("OnEvent", function(self, event)
		Currency_Update(self)
	end)
	f: HookScript("OnShow", function(self)
		Currency_Update(Currency)
	end)
end

local function Money_Frame(f)
	-- "PLAYER_MONEY"
	-- money = GetMoney()
	
	f.Money = CreateFrame("Frame", nil, f)
	f.Money: SetSize(280, 40)
	f.Money: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100,-140)
end

--- ------------------------------------------------------------
--> Equipment Sets
--- ------------------------------------------------------------

local function EquipSet_Template(f)
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f: SetScript("OnClick", function(self)
		if not UnitAffectingCombat("player") then
			if self.Name then
				--UseEquipmentSet(self.Name)
				EquipmentManager_EquipSet(self.SetID)
			end
		end
	end)
	f: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -10,0)
		if self.Name then
			--GameTooltip:AddDoubleLine(self.Name, self.TotalItem, HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b, NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b)
			GameTooltip:SetEquipmentSet(self.Name)
		end
		GameTooltip:Show()
	end)
	f: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	f.Icon = F.create_Texture(f, "BORDER", nil, nil, 1)
	f.Icon: SetSize(32,32)
	f.Icon: SetTexCoord(0.08,0.92, 0.08,0.92)
	f.Icon: SetPoint("LEFT", f, "LEFT", 0,0)
	
	f.IconGlow = F.create_Texture(f, "ARTWORK", "White", C.Color.B1, 0.3)
	f.IconGlow: SetAllPoints(f.Icon)
	
	f.Text1 = F.create_Font(f, C.Font.Txt, 14, nil, 0)
	f.Text1: SetAlpha(1)
	f.Text1: SetTextColor(F.Color(C.Color.W3))
	f.Text1: SetPoint("LEFT", f.Icon, "RIGHT", 6,0)
	
	f.Border = F.create_Texture(f, "OVERLAY", "Button\\border32", C.Color.B1, 1)
	f.Border: SetSize(64,64)
	f.Border: SetPoint("CENTER", f.Icon, "CENTER", 0,0)
end

local function EquipSet_ColorUpdate(f)
	if f.Equiped then
		f.Border: SetVertexColor(F.Color(C.Color.Y2))
	elseif f.MissingItem > 0 then
		f.Border: SetVertexColor(F.Color(C.Color.W2))
	else
		f.Border: SetVertexColor(F.Color(C.Color.B1))
	end
end

local function EquipSet_GetItemInfo(f)
	f.Available = 0
	f.Unavailable = 0
	f.Emptied = 0
	f.Ignored = 0
	for i = 1,19 do
		if f.InfoArray[i] then
			if f.InfoArray[i] == -1 then  --The item for this slot is unavailable.
				f.Unavailable = f.Unavailable + 1
			elseif f.InfoArray[i] == 0 then  --The slot should be emptied.
				f.Emptied = f.Emptied + 1
			elseif f.InfoArray[i] == 1 then  --This slot is ignored by the equipment set, no change will be made.
				f.Ignored = f.Ignored + 1
			else
				f.Available = f.Available + 1
				--id, name, textureName, count, durability, maxDurability, invType, locked, start, duration, enable, setTooltip, quality, isUpgrade
				local name = select(2, EquipmentManager_GetItemInfoByLocation(f.InfoArray[i]))
				
			end
		end
		--if f.ItemArray[i] then
		--	print(i, f.ItemArray[i])
		--end
	end
end

local function EquipSet_Update(f)
	local count = C_EquipmentSet.GetNumEquipmentSets()
	local EquipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
	for i,v in ipairs(EquipmentSetIDs) do
		if not f.Set[i] then
			f.Set[i] = CreateFrame("Button", nil, f)
			f.Set[i]: SetSize(160,32)
			
			EquipSet_Template(f.Set[i])
			if (floor(i/2) == i/2) then
				Create_Backdrop(f.Set[i], 1, 0, C.Color.W4, 0.2, C.Color.B1, 0)
			else
				Create_Backdrop(f.Set[i], 1, 0, C.Color.B1, 0.2, C.Color.B1, 0)
			end
			--[[
			if i == 1 then
				f.Set[i]: SetPoint("TOPRIGHT", f, "TOPRIGHT", 0,0)
			elseif (floor(i/2) == i/2) then
				f.Set[i]: SetPoint("CENTER", f.Set[i-1], "CENTER", -28,-49)
			else
				f.Set[i]: SetPoint("CENTER", f.Set[i-2], "CENTER", 0,-98)
			end
			--]]
			if i == 1 then
				f.Set[i]: SetPoint("TOPRIGHT", f, "TOPRIGHT", 0,0)
			else
				f.Set[i]: SetPoint("TOPRIGHT", f.Set[i-1], "BOTTOMRIGHT", 0,-6)
			end
		end
		if not f.Set[i]:IsShown() then
			f.Set[i]: Show()
		end
		local name,iconFileID,setID,isEquipped,numItems,numEquipped,numInInventory,numLost,numIgnored = C_EquipmentSet.GetEquipmentSetInfo(v)
		f.Set[i].Name = name
		f.Set[i].Icon: SetTexture(iconFileID)
		f.Set[i].SetID = setID
		f.Set[i].Equiped = isEquipped
		f.Set[i].TotalItem = numItems
		f.Set[i].EquipedItem = numEquipped
		f.Set[i].InventoryItem = numInInventory
		f.Set[i].MissingItem = numLost
		f.Set[i].IgnoredSlot = numIgnored
		--f.Set[i].InfoArray = GetEquipmentSetLocations(f.Set[i].Name, f.Set[i].InfoArray)
		f.Set[i].InfoArray = C_EquipmentSet.GetItemLocations(setID)
		--f.Set[i].ItemArray = GetEquipmentSetItemIDs(f.Set[i].Name, f.Set[i].ItemArray)
		f.Set[i].ItemArray = C_EquipmentSet.GetItemIDs(setID)
		--EquipSet_GetItemInfo(f.Set[i])
		f.Set[i].Text1: SetText(f.Set[i].Name)
		EquipSet_ColorUpdate(f.Set[i])
	end
	local num = #f.Set
	if num > count then
		for i = (count+1), num do
			f.Set[i]: Hide()
		end
	end
end

local function EquipSet_Frame(f)
	f.Equip = CreateFrame("Frame", nil, f)
	f.Equip: SetSize(10,10)
	f.Equip: SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -100, -140)
	f.Equip.Set = {}
	
	f.Equip: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Equip: RegisterEvent("EQUIPMENT_SETS_CHANGED")
	f.Equip: RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	f.Equip: SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" or event == "EQUIPMENT_SETS_CHANGED" or event == "PLAYER_EQUIPMENT_CHANGED" then
			EquipSet_Update(self)
		end
	end)
	f:HookScript("OnShow", function(self)
		EquipSet_Update(f.Equip)
	end)
end

--- ------------------------------------------------------------
--> Specialization
--- ------------------------------------------------------------
--SetSpecialization(specIndex [, isPet] )
--[[
local function Spec_ButtonTemplate(f, p)
	f: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f: SetScript("OnClick", function(self)
		if not UnitAffectingCombat("player") then
			if self.SpecID and p.CurrentSpec~= self.SpecID then
				SetSpecialization(self.SpecID)
			end
		end
	end)
	f: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -10,0)
		if self.Name then
			GameTooltip:AddLine(self.Name, HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b)
			GameTooltip:AddLine(_G[self.Role], HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b)
			GameTooltip:AddLine(self.Tooltip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
			--GameTooltip:SetMinimumWidth(80, true)
		end
		GameTooltip:Show()
	end)
	f: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	f.Icon = f:CreateTexture(nil, "BACKGROUND")
	f.Icon: SetMask("Interface\\ARCHEOLOGY\\Arch-Keystone-Mask")
	f.Icon: SetSize(60,60)
	f.Icon: SetPoint("CENTER", f, "CENTER", 0,0)
	
	f.Border = f:CreateTexture(nil, "ARTWORK")
	f.Border: SetTexture(F.Path("CommunicationMenu_Equip_Hex1"))
	f.Border: SetVertexColor(F.Color(C.Color.B1))
	f.Border: SetSize(64,64)
	f.Border: SetPoint("CENTER", f, "CENTER", 0,0)
	
	f.Glow = f:CreateTexture(nil, "BORDER")
	f.Glow: SetTexture(F.Path("CommunicationMenu_Equip_Hex2"))
	f.Glow: SetVertexColor(0,0,0)
	f.Glow: SetAlpha(0.75)
	f.Glow: SetSize(64,64)
	f.Glow: SetPoint("CENTER", f, "CENTER", 0,0)
end
--]]

local function Spec_ButtonTemplate(f, p)
	f: RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f: SetScript("OnClick", function(self)
		if not UnitAffectingCombat("player") then
			if self.SpecID and p.CurrentSpec~= self.SpecID then
				SetSpecialization(self.SpecID)
			end
		end
	end)
	f: SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip:SetPoint("TOPRIGHT", self, "TOPLEFT", -10,0)
		if self.Name then
			GameTooltip:AddLine(self.Name, HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b)
			GameTooltip:AddLine(self.Role, HIGHLIGHT_FONT_COLOR.r,HIGHLIGHT_FONT_COLOR.g,HIGHLIGHT_FONT_COLOR.b)
			GameTooltip:AddLine(self.Tooltip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
			--GameTooltip:SetMinimumWidth(80, true)
		end
		GameTooltip:Show()
	end)
	f: SetScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	f.Icon = F.create_Texture(f, "BORDER", nil, nil, 1)
	f.Icon: SetSize(42,42)
	f.Icon: SetTexCoord(0.08,0.92, 0.08,0.92)
	f.Icon: SetPoint("LEFT", f, "LEFT", 0,0)
	
	f.IconGlow = F.create_Texture(f, "ARTWORK", "White", C.Color.B1, 0.3)
	f.IconGlow: SetAllPoints(f.Icon)
	
	f.Text1 = F.create_Font(f, C.Font.Txt, 16, nil, 0)
	f.Text1: SetAlpha(1)
	f.Text1: SetTextColor(F.Color(C.Color.W3))
	f.Text1: SetPoint("LEFT", f.Icon, "RIGHT", 6,6)
	
	f.Text2 = F.create_Font(f, C.Font.Txt, 11, nil, 0)
	f.Text2: SetAlpha(1)
	f.Text2: SetTextColor(F.Color(C.Color.B1))
	f.Text2: SetPoint("TOPLEFT", f.Text1, "BOTTOMLEFT", 0,-2)
	
	f.Border = F.create_Texture(f, "OVERLAY", "Button\\border42", C.Color.B1, 1)
	f.Border: SetSize(64,64)
	f.Border: SetPoint("CENTER", f.Icon, "CENTER", 0,0)
end

local function Spec_ButtonUpdate(f)
	for i = 1, f.SpecNum do
		if not f.Button[i] then
			f.Button[i] = CreateFrame("Button", nil, f)
			f.Button[i]: SetSize(160,44)
			
			local id, name, description, icon, background = GetSpecializationInfo(i)
			local role = GetSpecializationRole(i)
			f.Button[i].SpecID = i
			f.Button[i].Name = name
			f.Button[i].Role = _G[role]
			f.Button[i].Tooltip = description
			Spec_ButtonTemplate(f.Button[i], f)
			if (floor(i/2) == i/2) then
				Create_Backdrop(f.Button[i], 1, 0, C.Color.W4, 0.2, C.Color.B1, 0)
			else
				Create_Backdrop(f.Button[i], 1, 0, C.Color.B1, 0.2, C.Color.B1, 0)
			end
			
			f.Button[i].Icon: SetTexture(icon)
			f.Button[i].Text1: SetText(f.Button[i].Name)
			f.Button[i].Text2: SetText(f.Button[i].Role)
			
			if i == 1 then
				f.Button[i]: SetPoint("TOPRIGHT", f, "TOPRIGHT", 0,0)
			else
				f.Button[i]: SetPoint("TOPRIGHT", f.Button[i-1], "BOTTOMRIGHT", 0,-8)
			end
		end
	end
end

local function Spec_ColorUpdate(f)
	if f.SpecNum then
		for i = 1, f.SpecNum do
			if f.Button[i].SpecID == f.CurrentSpec then
				f.Button[i].Border: SetVertexColor(F.Color(C.Color.Y2))
			else
				f.Button[i].Border: SetVertexColor(F.Color(C.Color.B1))
			end
		end
	end
end

local function Spec_Event(f, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		f.SpecNum = GetNumSpecializations()
		Spec_ButtonUpdate(f)
	end
	f.CurrentSpec = GetSpecialization()
	Spec_ColorUpdate(f)
end

local function Spec_OnEvent(f)
	f: RegisterEvent("PLAYER_ENTERING_WORLD")
	f: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	--f: RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	f: SetScript("OnEvent", function(self, event, ...)
		Spec_Event(self, event, ...)
	end)
end

local function Spec_Frame(f)
	f.Spec = CreateFrame("Frame", nil, f)
	f.Spec: SetSize(10,10)
	--f.Spec: SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -140,140)
	f.Spec: SetPoint("TOPRIGHT", f.Equip, "TOPRIGHT", -200,0)
	f.Spec.Button = {}
	
	Spec_OnEvent(f.Spec)
end

--- ------------------------------------------------------------
--> Location
--- ------------------------------------------------------------

local function Location_Artwork(frame)
	local Border = frame:CreateTexture(nil, "ARTWORK")
	Border: SetTexture(F.Path("StatusBar\\Raid"))
	Border: SetSize(6,36)
	Border: SetPoint("LEFT")

	local Text1 =  F.create_Font(frame, C.Font.Txt, 16, nil, 0, "LEFT", "CENTER")
	Text1: SetTextColor(F.Color(C.Color.W3))
	Text1: SetAlpha(1)
	Text1: SetPoint("BOTTOMLEFT", Border, "RIGHT", 10,-1)

	local Text2 =  F.create_Font(frame, C.Font.Txt, 16, nil, 0, "LEFT", "CENTER")
	Text2: SetTextColor(F.Color(C.Color.W3))
	Text2: SetAlpha(1)
	Text2: SetPoint("LEFT", Text1, "RIGHT", 0,0)

	local Text3 =  F.create_Font(frame, C.Font.Txt, 12, nil, 0, "LEFT", "CENTER")
	Text3: SetTextColor(F.Color(C.Color.W3))
	Text3: SetAlpha(1)
	Text3: SetPoint("TOPLEFT", Border, "RIGHT", 10,-3)
	Text3: SetText("坐标: ")

	local Text4 =  F.create_Font(frame, C.Font.Txt, 12, nil, 0, "LEFT", "CENTER")
	Text4: SetTextColor(F.Color(C.Color.W3))
	Text4: SetAlpha(1)
	Text4: SetPoint("LEFT", Text3, "RIGHT", 0,0)

	frame.Text1 = Text1
	frame.Text2 = Text2
	frame.Text3 = Text3
	frame.Text4 = Text4
end

local function Location_Update(frame)
	local zone = GetZoneText()
	--local realzone = GetRealZoneText()
	--local subzone = GetSubZoneText()
	local minimapzone = GetMinimapZoneText()
	
	frame.Text1: SetText(minimapzone.." | ")
	frame.Text2: SetText(zone)

	local pvpType, isSubZonePvP, factionName = GetZonePVPInfo();
	if ( pvpType == "sanctuary" ) then
		frame.Text2:SetTextColor(0.41, 0.8, 0.94);
	elseif ( pvpType == "arena" ) then
		frame.Text2:SetTextColor(1.0, 0.1, 0.1);
	elseif ( pvpType == "friendly" ) then
		frame.Text2:SetTextColor(0.1, 1.0, 0.1);
	elseif ( pvpType == "hostile" ) then
		frame.Text2:SetTextColor(1.0, 0.1, 0.1);
	elseif ( pvpType == "contested" ) then
		frame.Text2:SetTextColor(1.0, 0.7, 0.0);
	else
		frame.Text2:SetTextColor(F.Color(C.Color.W3));
	end
end

local function GetPlayerMapPos(mapID)
	--local px, py = C_Map.GetPlayerMapPosition(mapID, "player"):GetXY()
	if mapID then
		local position = C_Map.GetPlayerMapPosition(mapID, "player")
		if position then
			return position.x*100, position.y*100
		else
			return 0, 0
		end
	else
		return 0, 0
	end
end

local function Location_Frame(frame)
	local Location = CreateFrame("Frame", nil, frame)
	Location: SetSize(6,36)
	Location: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 40, -20)

	Location_Artwork(Location)

	Location:RegisterEvent("PLAYER_ENTERING_WORLD")
	--Location:RegisterEvent("MINIMAP_UPDATE_ZOOM"）--"MINIMAP_ZONE_CHANGED"
	Location:RegisterEvent("ZONE_CHANGED")
	Location:RegisterEvent("ZONE_CHANGED_INDOORS")
	Location:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	Location:SetScript("OnEvent", function(self,event, ...)
		Location_Update(self)
	end)

	frame: HookScript("OnShow", function(self)
		Location_Update(Location)
		Location:SetScript("OnUpdate", function()
			if F.Last5 == 0 then
				----local px,py = GetPlayerMapPosition("player")
				local PlayerUiMapID = C_Map.GetBestMapForUnit("player")
				Location.Text4:SetText(format("%.1f %.1f", GetPlayerMapPos(PlayerUiMapID)))
			end
		end)
	end)
	frame: HookScript("OnHide", function(self)
		Location:SetScript("OnUpdate", nil)
	end)
end

--- ------------------------------------------------------------
--> Emote
--- ------------------------------------------------------------

local function Emote_Templet(f, p, angle, color, texture, text, alpha)
	if not alpha then alpha = 1 end
	f.Txt = F.create_Font(f, C.Font.Txt, 16, nil, 0)
	f.Txt: SetTextColor(F.Color(color))
	f.Txt: SetAlpha(alpha)
	f.Txt: SetText(text)
	f.Txt: SetPoint("CENTER", p, "CENTER", 260*cos(rad(angle)), 260*sin(rad(angle)))
	
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon: SetTexture(F.Path(texture))
	f.Icon: SetAlpha(alpha)
	f.Icon: SetVertexColor(F.Color(color))
	f.Icon: SetSize(52,52)
	f.Icon: SetPoint("CENTER", p, "CENTER", 180*cos(rad(angle)), 180*sin(rad(angle)))
end

local function Thanks_Create(f, angle)
	f.Thanks = CreateFrame("Frame", nil, f)
	Emote_Templet(f.Thanks, f, angle, C.Color.Y2, "CommunicationMenu\\Icon_Thanks", L['THANK'])
end

local function Thanks_Click(f)
	DoEmote("THANK")
end

--> Hello
local function Hello_Create(f, angle)
	f.Hello = CreateFrame("Frame", nil, f)
	Emote_Templet(f.Hello, f, angle, C.Color.Y2, "CommunicationMenu\\Icon_Hello", L['HELLO'])
end

local function Hello_Click(f)
	DoEmote("HELLO")
end

--> Dance
local function Dance_Create(f, angle)
	f.Dance = CreateFrame("Frame", nil, f)
	Emote_Templet(f.Dance, f, angle, C.Color.Y2, "CommunicationMenu\\Icon_Dance", L['DANCE'])
end

local function Dance_Click(f)
	DoEmote("DANCE")
end

--> Healme
local function Healme_Create(f, angle)
	f.Healme = CreateFrame("Frame", nil, f)
	Emote_Templet(f.Healme, f, angle, C.Color.Y2, "CommunicationMenu\\Icon_HealMe", L['HEALME'])
end

local function Healme_Click(f)
	DoEmote("HEALME")
end

--> Rude
local function Rude_Create(f, angle)
	f.Rude = CreateFrame("Frame", nil, f)
	Emote_Templet(f.Rude, f, angle, C.Color.Y2, "CommunicationMenu\\Icon_Rude", L['RUDE'])
end

local function Rude_Click(f)
	DoEmote("RUDE")
end

--DoEmote("THANK")
--DoEmote("DANCE")
--DoEmote("HELLO")
--DoEmote("HEALME")
--DoEmote("Rude")
--DoEmote("BYE")

--> Auto Loot

local function AutoLoot_Update(frame)
	local autoloot = GetCVar("autoLootDefault")
	if autoloot == "0" then
		frame.AutoLoot.Txt:SetText(L['AUTOLOOT'].." "..F.Hex(C.Color.Y2)..L['OFF'].."|r")
	else
		frame.AutoLoot.Txt:SetText(L['AUTOLOOT'].." "..F.Hex(C.Color.Y2)..L['ON'].."|r")
	end
end

local function AutoLoot_Click(frame)
	local autoloot = GetCVar("autoLootDefault")
	if autoloot == "0" then
		SetCVar("autoLootDefault", 1)
		--DEFAULT_CHAT_FRAME:AddMessage(L['AUTOLOOT'].." "..L['ON'])
	else
		SetCVar("autoLootDefault", 0)
		--DEFAULT_CHAT_FRAME:AddMessage(L['AUTOLOOT'].." "..L['OFF'])
	end
	AutoLoot_Update(frame)
end

local function AutoLoot_Create(frame, angle)
	frame.AutoLoot = CreateFrame("Frame", nil, frame)
	Emote_Templet(frame.AutoLoot, frame, angle, C.Color.W4, "CommunicationMenu\\Icon_Loot", L['AUTOLOOT'])

	frame:HookScript("OnShow", function(self)
		AutoLoot_Update(frame)
	end)
end

--> Sheath
local function Sheath_Txt(f)
	local sheathState = GetSheathState()
	if sheathState == 1 then
		f.Txt: SetText(L['UNSHEATHE'])
	else
		f.Txt: SetText(L['SHEATHE'])
	end
end

local function Sheath_Create(f, angle)
	f.Sheath = CreateFrame("Frame", nil, f)
	Emote_Templet(f.Sheath, f, angle, C.Color.W4, "CommunicationMenu\\Icon_Sheath", "收起武器")
	
	f.Sheath: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.Sheath: RegisterEvent("UNIT_MODEL_CHANGED")
	f.Sheath: SetScript("OnEvent", function(self, event)
		Sheath_Txt(self)
	end)
end

local function Sheath_Click(f)
	ToggleSheath()
	Sheath_Txt(f.Sheath)
end

--- ------------------------------------------------------------
--> CommunicationMenu Frame
--- ------------------------------------------------------------

local function CommunicationMenu_Artwork(frame)
	local Bg = frame:CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("StatusBar\\Raid"))
	Bg: SetVertexColor(0.01,0.01,0.02)
	Bg: SetAlpha(0.75)
	Bg: SetAllPoints(UIParent)

	local TopBg = frame:CreateTexture(nil, "BORDER")
	TopBg: SetTexture(F.Path("StatusBar\\Raid"))
	TopBg: SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0,0)
	TopBg: SetPoint("BOTTOMRIGHT", UIParent, "TOPRIGHT", 0,-76)
	TopBg: SetVertexColor(F.Color(C.Color.Black))
	TopBg: SetAlpha(0.8)

	local BottomBg = frame:CreateTexture(nil, "BORDER")
	BottomBg: SetTexture(F.Path("StatusBar\\Raid"))
	BottomBg: SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", 0,76)
	BottomBg: SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0,0)
	BottomBg: SetVertexColor(F.Color(C.Color.Black))
	BottomBg: SetAlpha(0.8)
	
	local Bd1 = frame:CreateTexture(nil, "BORDER")
	Bd1: SetTexture(F.Path("CommunicationMenu\\Bd1"))
	Bd1: SetVertexColor(F.Color(C.Color.W3))
	Bd1: SetAlpha(0.4)
	--f.Bd1: SetSize(384,384)
	Bd1: SetSize(256,256)
	Bd1: SetPoint("CENTER", frame, "CENTER", 0,0)
	
	local Bd2 = frame:CreateTexture(nil, "ARTWORK")
	Bd2: SetTexture(F.Path("CommunicationMenu\\Bd2"))
	Bd2: SetVertexColor(F.Color(C.Color.W3))
	Bd2: SetAlpha(0.8)
	--Bd2: SetSize(384,384)
	Bd2: SetSize(256,256)
	Bd2: SetPoint("CENTER", frame, "CENTER", 0,0)
	
	local DVa = frame:CreateTexture(nil, "ARTWORK")
	DVa: SetTexture(F.Path("CommunicationMenu\\DVa"))
	DVa: SetVertexColor(F.Color(C.Color.W4))
	DVa: SetAlpha(0.4)
	DVa: SetSize(64,64)
	DVa: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd3 = F.Create.Texture(frame, "BORDER", 1, F.Path("CommunicationMenu\\Bd4"), C.Color.W3, 0.02, {1024,1024}, nil)
	Bd3: SetPoint("CENTER", frame, "CENTER", 0,0)

	local Bd4 = F.Create.Texture(frame, "ARTWORK", 1, F.Path("CommunicationMenu\\Bd5"), C.Color.B1, 1, {1024,1024}, nil)
	Bd4: SetPoint("CENTER", frame, "CENTER", 0,0)
	Bd4: Hide()

	frame.DVa = DVa
	frame.Bd = Bd4
end

local function Line_Update(f, angle)
	local n1 = #f
	local n2 = #angle
	for i = 1,n2 do
		if not f[i] then
			f[i] = f:CreateTexture(nil, "BORDER")
			f[i]: SetTexture(F.Path("CommunicationMenu\\Bd3"))
			f[i]: SetSize(512,512)
			f[i]: SetVertexColor(F.Color(C.Color.W3))
			f[i]: SetAlpha(0.4)
		end
		F.RotateTexture(f[i], angle[i])
		--f[i]: SetPoint("CENTER", f, "CENTER", 262.5*cos(rad(angle[i])), 262.5*sin(rad(angle[i])))
		f[i]: SetPoint("CENTER", f, "CENTER", 225*cos(rad(angle[i])), 225*sin(rad(angle[i])))
		f[i]: Show()
	end
	if n1 > n2 then
		for i = n2+1, n1 do
			f[i]: Hide()
		end
	end
end

local function Line_Create(f)
	f.Line = CreateFrame("Frame", nil, f)
	f.Line: SetSize(12,12)
	f.Line: SetPoint("CENTER", f, "CENTER", 0,0)
	f.Line: SetFrameLevel(f:GetFrameLevel())
	
	Line_Update(f.Line, {22.5, 67.5, 112.5, 157.5, 202.5, 247.5, 292.5, 337.5})
end

local function CommunicationMenu_GetAngle(frame)
	local uiScale = UIParent:GetEffectiveScale()
	local x0, y0 = frame:GetCenter()
	local x1, y1 = GetCursorPosition()
	local x, y = (x1/uiScale - x0), (y1/uiScale - y0)
	local a = deg(atan(y/x))
	if x < 0 then
		a = a + 180
	elseif y < 0 then
		a = a + 360
	end
	return a, x, y
end

local CommunicationMenu = CreateFrame("Button", "Quafe_CommunicationMenu", E)
local function Load()
	CommunicationMenu: SetFrameStrata("FULLSCREEN_DIALOG")
	CommunicationMenu: SetFrameLevel(10)
	CommunicationMenu: SetSize(660,660)
	CommunicationMenu: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	--CommunicationMenu: RegisterForClicks("LeftButtonDown", "RightButtonDown")
	CommunicationMenu: RegisterForClicks("LeftButtonDown")
	CommunicationMenu: Hide()
	
	Location_Frame(CommunicationMenu)
	XP_Frame(CommunicationMenu)
	if not F.IsClassic then
		Currency_Frame(CommunicationMenu)
		EquipSet_Frame(CommunicationMenu)
		Spec_Frame(CommunicationMenu)
	end
	
	CommunicationMenu_Artwork(CommunicationMenu)
	Line_Create(CommunicationMenu)
	
	Healme_Create(CommunicationMenu, 0)
	Hello_Create(CommunicationMenu, 45)
	Dance_Create(CommunicationMenu, 90)
	Thanks_Create(CommunicationMenu, 135)
	Rude_Create(CommunicationMenu, 180)
	AutoLoot_Create(CommunicationMenu, 225)
	Sheath_Create(CommunicationMenu, 270)
	--Bye_Create(CommunicationMenu, 315)

	CommunicationMenu: HookScript("OnShow", function(self)
		PlaySoundFile(F.Path("Sound\\Show.ogg"), "Master")
	end)
	
	CommunicationMenu: RegisterEvent("PLAYER_ENTERING_WORLD")
	CommunicationMenu: RegisterEvent("UPDATE_BONUS_ACTIONBAR")

	if not F.IsClassic then
		CommunicationMenu: RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")
		CommunicationMenu: RegisterEvent("UNIT_ENTERED_VEHICLE")
		CommunicationMenu: RegisterEvent("UNIT_EXITED_VEHICLE")
		CommunicationMenu: RegisterEvent("VEHICLE_UPDATE")
	
		CommunicationMenu: SetScript("OnEvent", function(self, event)
			if ( CanExitVehicle() ) then
				self.DVa: SetVertexColor(F.Color(C.Color.R1))
				self.DVa: SetAlpha(0.8)
			else
				self.DVa: SetVertexColor(F.Color(C.Color.W4))
				self.DVa: SetAlpha(0.4)
			end
		end)
	end
	
	CommunicationMenu: SetScript("OnEnter", function(self)
		CommunicationMenu: SetScript("OnUpdate", function(self)
			local a, x, y = CommunicationMenu_GetAngle(self)
			if ((x*x+y*y) > 8000) and ((x*x+y*y) < 420000) then
				self.Bd: Show()
				if a < 22.5 or a > 337.5 then
					self.Bd: SetRotation(rad(0))
				elseif a < 67.5 then
					self.Bd: SetRotation(rad(45))
				elseif a < 112.5 then
					self.Bd: SetRotation(rad(90))
				elseif a < 157.5 then
					self.Bd: SetRotation(rad(135))
				elseif a < 202.5 then
					self.Bd: SetRotation(rad(180))
				elseif a < 247.5 then
					self.Bd: SetRotation(rad(225))
				elseif a < 292.5 then
					self.Bd: SetRotation(rad(270))
				elseif a < 337.5 then
					self.Bd: SetRotation(rad(315))
				end
			else
				self.Bd: Hide()
			end
		end)
	end)

	CommunicationMenu: SetScript("OnLeave", function(self)
		CommunicationMenu: SetScript("OnUpdate", nil)
		self.Bd: Hide()
	end)

	CommunicationMenu: SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			local uiScale = UIParent:GetEffectiveScale()
			local x0, y0 = self:GetCenter()
			local x1, y1 = GetCursorPosition()
			local x, y = (x1/uiScale - x0), (y1/uiScale - y0)
			if ((x*x+y*y) < 8000) or ((x*x+y*y) > 420000) then
				if (x*x+y*y) < 6400 then
					if ( UnitOnTaxi("player") ) then
						TaxiRequestEarlyLanding()
						--> Show that the request for landing has been received.
						self.DVa: SetVertexColor(F.Color(C.Color.W2))
					elseif CanExitVehicle() then
						VehicleExit()
					end
				end
				return
			end
			local a = deg(atan(y/x))
			if x < 0 then
				a = a + 180
			elseif y < 0 then
				a = a + 360
			end
			
			if a < 22.5 or a > 337.5 then
				Healme_Click()
			elseif a < 67.5 then
				Hello_Click()
			elseif a < 112.5 then
				Dance_Click()
			elseif a < 157.5 then
				Thanks_Click()
			elseif a < 202.5 then
				Rude_Click()
			elseif a < 247.5 then
				AutoLoot_Click(CommunicationMenu)
			elseif a < 292.5 then
				Sheath_Click(CommunicationMenu)
			elseif a < 337.5 then
				
			end
		end
	end)
end
CommunicationMenu.Load = Load
insert(E.Module, CommunicationMenu)

--- ------------------------------------------------------------
--> Hotkey
--- ------------------------------------------------------------
--SetBinding("T", "QUAFE_COMMUNICATIONMENU", 1)
--SaveBindings(GetCurrentBindingSet())

function Quafe_Binding_CommunicationMenu(keystate)
	if keystate == "down" then
		if E and CommunicationMenu then
			CommunicationMenu: Show()
		end
	else
		if E and CommunicationMenu then
			CommunicationMenu: Hide()
		end
	end
end

