local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local cos = math.cos
local rad = math.rad

if F.IsClassic then
	local LibClassicDurations = LibStub("LibClassicDurations")
    LibClassicDurations:Register("Quafe")

	F.UnitAura = function(unit, index, filter)
		if unit ~= "player" and (filter and filter == "HARMFUL") then
			return LibClassicDurations:UnitAura(unit, index, filter)
		else
			return UnitAura(unit, index, filter)
		end
	end
else
	F.UnitAura = UnitAura
end

--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------

local create_Backdrop = function(f)
	local d1 = 2
	local d2 = 8
	if f.Shadow then return end
	f.Shadow = CreateFrame("Frame", nil, f)
	f.Shadow: SetFrameLevel(f:GetFrameLevel()-1)
	f.Shadow: SetFrameStrata(f:GetFrameStrata())
	f.Shadow:SetPoint("TOPLEFT", -d1, d1)
	f.Shadow:SetPoint("BOTTOMLEFT", -d1, -d1)
	f.Shadow:SetPoint("TOPRIGHT", d1, d1)
	f.Shadow:SetPoint("BOTTOMRIGHT", d1, -d1)
	--f.Shadow: SetAllPoints(f)
	f.Shadow: SetBackdrop({
		edgeFile = F.Path("EdgeFile\\EdgeFile_Backdrop"), 
		edgeSize = d2,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	
	f.Shadow: SetBackdropColor( .05,.05,.05, 0)
	f.Shadow: SetBackdropBorderColor(C.Color.Black[1],C.Color.Black[2],C.Color.Black[3],0.9)
end

local function create_Border(f)
	local d1 = -2
	local d2 = 2
	if f.Beyond then return end
	f.Beyond = CreateFrame("Frame", nil, f)
	f.Beyond: SetFrameLevel(f:GetFrameLevel()+1)
	f.Beyond: SetFrameStrata(f:GetFrameStrata())
	f.Beyond: SetPoint("TOPLEFT", -d1, d1)
	f.Beyond: SetPoint("BOTTOMLEFT", -d1, -d1)
	f.Beyond: SetPoint("TOPRIGHT", d1, d1)
	f.Beyond: SetPoint("BOTTOMRIGHT", d1, -d1)
	--f.Beyond = border
	f.Beyond: SetBackdrop({
		edgeFile = F.Path("White"),
		edgeSize = d2,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	f.Beyond: SetBackdropColor(F.Color(C.Color.W1, 0))
	f.Beyond: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
end

local formatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s/day + 0.5)), s % day
	elseif s >= hour then
		return format("%dh", floor(s/hour + 0.5)), s % hour
	elseif s >= minute then
		return format("%dm", floor(s/minute + 0.5)), s % minute
	elseif s >= minute / 12 then
		return floor(s + 0.5), (s * 100 - floor(s * 100))/100
	end
	return format("%.1f", s), (s * 100 - floor(s * 100))/100
end

local UpdateTooltip = function(self)
	GameTooltip:SetUnitAura(self:GetParent().unit, self:GetID(), self.filter)
end

local OnEnter = function(self)
	if(not self:IsVisible()) then return end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	self:UpdateTooltip()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local event_Aura = function(f, unit, index, filter)
	if not unit then return end
	local name, icon, count, dispelType, duration, expires, caster, isStealable,  nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3  = F.UnitAura(unit, index , filter)
	if name then
		f:SetID(index)
		f.name = name
		f.tex = icon
		f.count = count
		f.debuffType = dispelType
		f.duration = duration
		--f.expires = expires
		f.remain = max(expires - GetTime(), 0)
		f.caster = caster
		f.steal = isStealable
		f.spellID = spellID
		f.isBoss = isBossDebuff
		f.isNameplate = nameplateShowAll
		f.filter = filter
	else
		f.name = nil
		f.tex = nil
		f.count = nil
		f.debuffType = nil
		f.duration = nil
		f.remain = 0
		f.caster = nil
		f.steal = nil
		f.spellID = nil
		f.isBoss = nil
		f.isNameplate = nil
		f.filter = nil
	end
end

local Aura_Pos = function(f, i)
	local button = f.Aura[i]
	local GAP = f.gap or 2

	if i == 1 then
		if f.growthH == "RIGHT" then
			f.Aura[i]: SetPoint("BOTTOMLEFT",f,"BOTTOMLEFT",0,0)
		elseif f.growthH == "LEFT" then
			f.Aura[i]: SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",0,0)
		end
	elseif (i > f.perline) and (((i-1)/f.perline) == floor((i-1)/f.perline)) then
		if f.growthV == "TOP" then
			f.Aura[i]: SetPoint("BOTTOMLEFT", f.Aura[i-f.perline], "TOPLEFT", 0,GAP+2)
		elseif f.growthV == "BOTTOM" then
			f.Aura[i]: SetPoint("TOPLEFT", f.Aura[i-f.perline], "BOTTOMLEFT", 0,-(GAP+2))
		end
		--f: SetHeight((f.size+2)*floor((i-1)/f.perline))
	else
		if f.growthH == "RIGHT" then
			f.Aura[i]: SetPoint("LEFT", f.Aura[i-1], "RIGHT", GAP,0)
		elseif f.growthH == "LEFT" then
			f.Aura[i]: SetPoint("RIGHT", f.Aura[i-1], "LEFT", -GAP,0)
		end
	end

	if f.Aura[i].name then
		f.Aura[i].Icon: SetTexture(f.Aura[i].tex)
		
		if (f.Aura[i].isBoss) or (f.Aura[i].caster == "player") or (f.Aura[i].caster == "vehicle") or (f.steal == true) then
			f.Aura[i].Icon: SetDesaturated(false)  
		else
			f.Aura[i].Icon: SetDesaturated(true)  
		end

		if button.filter == "HARMFUL" then
			local color = C.Color.DebuffType[button.debuffType] or C.Color.DebuffType.none
			button.Shadow: SetBackdropBorderColor(F.Color(color))
		else
			button.Shadow: SetBackdropBorderColor(F.Color(C.Color.W1, 0.9))
		end

		if (button.steal) then
			button.Beyond: SetBackdropBorderColor(F.Color(C.Color.B1, 1))
		elseif (button.isBoss) then
			button.Beyond: SetBackdropBorderColor(F.Color(C.Color.Y1, 1))
		else
			button.Beyond: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
		end

		f.Aura[i]: Show()
	else
		f.Aura[i]: Hide()
	end
end

local Aura_Event = function(f)
	if not f.Aura then
		f.Aura = {}
	end
	if f.debufflimit and f.bufflimit then
		f.limit = f.debufflimit + f.bufflimit
	end
	local i,index, turn = 1, 1, 1
	while (i < f.limit) do
		if not f.Aura[i] then
			f.Aura[i] = CreateFrame("Button", nil, f)
			f.Aura[i]: SetSize(f.size, f.size)
			f.Aura[i]: EnableMouse(true)
			f.Aura[i]: RegisterForClicks("RightButtonUp")
			
			create_Border(f.Aura[i])
			create_Backdrop(f.Aura[i])
			f.Aura[i].Beyond: SetBackdropBorderColor(C.Color.Black[1],C.Color.Black[2],C.Color.Black[3],0.9)
			f.Aura[i].Shadow: SetBackdropBorderColor(C.Color.Black[1],C.Color.Black[2],C.Color.Black[3],0.9)
			
			f.Aura[i].UpdateTooltip = UpdateTooltip
			f.Aura[i]: SetScript("OnEnter", function(self)
				OnEnter(self)
			end)
			f.Aura[i]: SetScript("OnLeave", function(self)
				OnLeave(self)
			end)
			
			f.Aura[i].Icon = f.Aura[i]:CreateTexture(nil, "BORDER")
			f.Aura[i].Icon: SetSize(f.size-4, f.size-4)
			f.Aura[i].Icon: SetTexCoord(0.08, 0.92, 0.08, 0.92)
			f.Aura[i].Icon: SetPoint("CENTER", f.Aura[i], "CENTER", 0,0)
			
			f.Aura[i].CD = f.Aura[i]:CreateFontString(nil, "OVERLAY")
			f.Aura[i].CD: SetFont(C.Font.NumSmall, f.fontsize, "THINOUTLINE")--"THINOUTLINE,MONOCHROME"
			f.Aura[i].CD: SetShadowColor(0,0,0,0.9)
			f.Aura[i].CD: SetShadowOffset(0,0)
			f.Aura[i].CD: SetJustifyH("CENTER")
			f.Aura[i].CD: SetPoint("BOTTOM", f.Aura[i], "BOTTOM", 1,0)
			f.Aura[i].CD: SetText(formatTime(54))
			
			f.Aura[i].Ct = f.Aura[i]:CreateFontString(nil, "OVERLAY")
			f.Aura[i].Ct: SetFont(C.Font.Num, f.fontsize, "THINOUTLINE")
			f.Aura[i].Ct: SetShadowColor(0,0,0,0.9)
			f.Aura[i].Ct: SetShadowOffset(0,0)
			f.Aura[i].Ct: SetJustifyH("CENTER")
			f.Aura[i].Ct: SetPoint("TOPRIGHT", f.Aura[i], "TOPRIGHT", 1,0)
			
			f.Aura[i].Overlay = f.Aura[i]:CreateTexture(nil, "ARTWORK")
			
			f.Aura[i].Border = f.Aura[i]:CreateTexture(nil, "OVERLAY")
			
		end
		
		if f.type == "Aura" then
			if index then
				if turn == 1 then
					event_Aura(f.Aura[i], f.unit, index, "HARMFUL")
					if f.Aura[i].name and (i <= f.debufflimit) then
						index = index + 1
						Aura_Pos(f, i)
						i = i + 1
					else
						if index ~= 1 then
							Aura_Pos(f, i)
							i = i + 1
						end
						turn = 2
						index = 1
					end
				else
					event_Aura(f.Aura[i], f.unit, index, "HELPFUL")
					if f.Aura[i].name and (i <= f.bufflimit) then
						index = index + 1
						Aura_Pos(f, i)
						i = i + 1
					else
						index = nil
					end
				end
			else
				f.Aura[i].name = nil
				Aura_Pos(f, i)
				i = i + 1
			end
		elseif f.type == "Steal" then
			if index then
				event_Aura(f.Aura[i], f.unit, index, "HELPFUL")
				if f.Aura[i].name then
					index = index + 1
					if f.Aura[i].steal then
						Aura_Pos(f, i)
						i = i + 1
					end
				else
					index = nil
				end
			else
				f.Aura[i].name = nil
				Aura_Pos(f, i)
				i = i + 1
			end
		elseif f.type == "Boss" then
			if index then
				event_Aura(f.Aura[i], f.unit, index, f.filter)
				if f.Aura[i].name then
					index = index + 1
					if f.Aura[i].isBoss or f.Aura[i].isNameplate or (f.Aura[i].caster and (f.Aura[i].caster == "player" or f.Aura[i].caster:match'(boss)%d?$' == 'boss')) then
						Aura_Pos(f, i)
						i = i + 1
					end
				else
					index = nil
				end
			else
				f.Aura[i].name = nil
				Aura_Pos(f, i)
				i = i + 1
			end
		else
			if index then
				event_Aura(f.Aura[i], f.unit, index, f.filter)
				if f.Aura[i].name then
					index = index + 1
				else
					index = nil
				end
			else
				f.Aura[i].name = nil
			end
			Aura_Pos(f, i)
			i = i + 1
		end
	end
end

local Aura_Update = function(f, elapsed)
	if f:IsVisible() then
		for i = 1, f.limit do
			if f.Aura and f.Aura[i] and f.Aura[i].name then
				f.Aura[i].remain = max(f.Aura[i].remain - elapsed, 0)
				if f.Aura[i].remain > 0 then
					f.Aura[i].CD: SetText(formatTime(f.Aura[i].remain))
				else
					f.Aura[i].CD: SetText()
				end
				if f.Aura[i].count and f.Aura[i].count > 0 then
					f.Aura[i].Ct: SetText(f.Aura[i].count)
				else
					f.Aura[i].Ct: SetText()
				end
			end
		end
	end
end

----------------------------------------------------------------
--> Aura Create
----------------------------------------------------------------

function F.Aura_Create(frame)
	--[[
		f.size
		f.fontsize
		f.gap
		f.limit
		f.bufflimit
		f.debufflimit
		f.perline
		f.unit
		f.type "Boss,Aura,Steal"
		f.filter "HARMFUL|HELPFUL|PLAYER|RAID"
		f.special
		f.growthH --横
		f.growthV --竖
	]]--
	local displayedUnit
	if frame.unit == "player" then
		displayedUnit = "vehicle"
	elseif frame.unit == "target" then
		frame: RegisterEvent("PLAYER_TARGET_CHANGED")
	elseif frame.unit == "focus" then
		frame: RegisterEvent("PLAYER_FOCUS_CHANGED")
	end
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterUnitEvent("UNIT_AURA", frame.unit, displayedUnit)
	frame: SetScript("OnEvent", function(self,event)
		Aura_Event(frame)
	end)
	
	frame: SetScript("OnUpdate", function(self, elapsed)
		Aura_Update(frame, elapsed)
	end)
end

function F.Aura_Template(frame)
	frame.AuraOnEvent = Aura_Event
	frame: SetScript("OnUpdate", function(self, elapsed)
		Aura_Update(frame, elapsed)
	end)
end

----------------------------------------------------------------

----------------------------------------------------------------
--> Aura List Update
----------------------------------------------------------------

local function AL_List_Refresh(auralist)
	for k, v in pairs(auralist) do
		if v.Aura then
			v.Exist = false
			v.Icon = ""
			v.Count = 0
			v.Duration = 0
			v.Remain = 0
			v.Total = 0
		end
	end
end

local function AL_AuraUpdate(auralist, unit, name, icon, count, duration, expires, caster, spellID)
	for k, v in pairs(E.AuraUpdate.AuraList) do
		if v.Aura and v.Unit == unit and (v.Aura == tostring(spellID) or v.Aura == name) then
			if (v.Caster and v.Caster == caster) or (not v.Caster) then
				v.Exist = true
				v.Icon = icon
				v.Count = count
				E.AuraUpdate.AuraList[k].Count = count
				v.Duration = duration
				v.Remain = max(expires - GetTime(), 0)
				v.Total = (v.Total or 0) + 1
			end
		end
	end
end

local function AL_Event(frame, event)
	AL_List_Refresh(E.AuraUpdate.AuraList)
	local name, icon, count, dispelType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID
	for k, unit in ipairs(E.AuraUpdate.UnitList) do
		local NumBuff,NumDebuff = 1, 1
		while NumBuff do
			name, icon, count, dispelType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID = UnitBuff(unit, NumBuff)
			if name then
				AL_AuraUpdate(E.AuraUpdate.AuraList, unit, name, icon, count, duration, expirationTime, unitCaster, spellID)
				NumBuff = NumBuff + 1
			else
				NumBuff = nil
			end
		end	
		while NumDebuff do
			name, icon, count, dispelType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, spellID = UnitDebuff(unit, NumDebuff)
			if name then
				AL_AuraUpdate(E.AuraUpdate.AuraList, unit, name, icon, count, duration, expirationTime, unitCaster, spellID)
				NumDebuff = NumDebuff + 1
			else
				NumDebuff = nil
			end
		end	
	end
end

local function AL_OnEvent(frame)
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	frame: RegisterEvent("PLAYER_TARGET_CHANGED")
	if F.IsClassic then
		
	else
		frame: RegisterEvent("PLAYER_FOCUS_CHANGED")
	end
	frame: RegisterUnitEvent("UNIT_PET", "player")
	frame: RegisterEvent("UNIT_AURA")
	frame: SetScript("OnEvent", function(self,event)
		AL_Event(self, event, E.AuraUpdate.UnitList)
	end)
end

----------------------------------------------------------------
--> AuraListUpdate Load
----------------------------------------------------------------

local AuraListUpdate = CreateFrame("Frame", nil, E)
local function AuraListUpdate_Load()
	AL_OnEvent(AuraListUpdate)
end
AuraListUpdate.Load = AuraListUpdate_Load()
tinsert(E.Module, AuraListUpdate)