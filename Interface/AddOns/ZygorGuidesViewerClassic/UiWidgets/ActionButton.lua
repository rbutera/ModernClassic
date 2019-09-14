local ZGV = ZygorGuidesViewer
if not (ZGV and ZGV.UI) then return end

local tinsert,tremove,ipairs,pairs,wipe=tinsert,tremove,ipairs,pairs,wipe

local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local L = ZGV.L
local CHAIN = ZGV.ChainCall

local ActionButton = {}
ZGV.UI:RegisterWidget("ActionButton",ActionButton)

local SkinData = ZGV.UI.SkinData

local DEFAULTWIDTH = 30
local DEFAULTHEIGHT = 30

local function ShowTooltip(self)
	if self.tooltipDisabled then return end
	if self:GetAttribute("itemid") then
		local itemid = self:GetAttribute("itemid")
		local link = "item:"..itemid
		if not link then return end
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	elseif self:GetAttribute("spellid") then
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
		GameTooltip:SetSpellByID(self:GetAttribute("spellid"))
		GameTooltip:Show()
	elseif self:GetAttribute("petid") then
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
		GameTooltip:SetPetAction(self:GetAttribute("petid"))
		GameTooltip:Show()
	elseif self.tooltip then
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
		GameTooltip:SetText(self.tooltip)
		GameTooltip:Show()
	end
end

local function ShowPetTooltip(self)
	if self.tooltipDisabled then return end
	if self:GetID() then
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT")
		GameTooltip:SetPetAction(self:GetID())
		GameTooltip:Show()
	end
end

local function HideTooltip(self)
	if (GameTooltip:GetOwner()==self) then
		GameTooltip:Hide()
	end
end

local function DragStart(self)
	if not self.draggable then return false end
	if InCombatLockdown() then return false end

	local objtype = self:GetAttribute("type")
	local object = self:GetAttribute(objtype)
	if objtype == 'item' then
		PickupItem(object)
	elseif objtype == 'macro' then
		PickupMacro(object)
	elseif objtype == 'petaction' then
		PickupPetAction(object)
	elseif objtype == 'spell' then
		PickupSpell(object)
	end
end

function ActionButton:New(parent,name)
	if InCombatLockdown() then return end
	if not name then error("Actionbutton requires name") return end

	local action = CreateFrame("CheckButton", name, parent, "SecureActionButtonTemplate")
	
	action:RegisterForClicks("AnyUp")
	action:SetSize(DEFAULTWIDTH,DEFAULTHEIGHT)
	action:SetScript("OnEnter", ShowTooltip)
	action:SetScript("OnLeave", HideTooltip)
	action:SetScript("OnEvent", ActionButton.EventHandler)
	action:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	action:RegisterForDrag("LeftButton", "RightButton")
	action:SetScript("OnDragStart", DragStart)

	action:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")

	action.tex = action:CreateTexture(name.."_texture","OVERLAY")
	action.tex:SetAllPoints(action)
	action.tex:SetSize(DEFAULTWIDTH,DEFAULTHEIGHT)

	action.PetAction = CreateFrame("CheckButton", name.."_pet", parent, "PetActionButtonTemplate")
	action.PetAction:SetSize(DEFAULTWIDTH,DEFAULTHEIGHT)
	action.PetAction:SetAllPoints(action)
	action.PetAction:SetFrameStrata(action:GetFrameStrata())
	action.PetAction:SetFrameLevel(action:GetFrameLevel()+1)
	action.PetAction:SetScript("OnEnter", ShowPetTooltip)
	action.PetAction:SetScript("OnLeave", HideTooltip)
	action.PetAction:Hide()

	local cd = CreateFrame("Cooldown", name.."_cooldown", action, "CooldownFrameTemplate")
	cd:SetPoint("CENTER", 0, -1)
	cd:SetAllPoints()
	cd:Hide()
	action.cd = cd

	for f,fun in pairs(self) do
		action[f]=fun
	end

	return action
end

function ActionButton:SetAllSizes(width,height)
	self:SetSize(width,height)
	self.tex:SetSize(width,height)
	self.PetAction:SetSize(width,height)
end


function ActionButton.EventHandler(self, event)
	-- we only have one event registered
	if not self:IsVisible() then return end
	if self.cooldownDisabled then return end

	self:UpdateCooldown()
end

function ActionButton:UpdateCooldown()
	local starts,dur,ends = 0,0,0
	if self:GetAttribute("type")=="spell" then
		starts,dur,ends = GetSpellCooldown(self:GetAttribute("spell"))
	elseif self:GetAttribute("type")=="item" then
		starts,dur,ends = GetItemCooldown(self:GetAttribute("itemid"))
	elseif self:GetAttribute("type")=="petaction" then
		starts,dur,ends = GetPetActionCooldown(self:GetAttribute("petaction"))
	elseif self:GetAttribute("type")=="macro" then
		local macro_index = self:GetAttribute("macro")
		if self:GetAttribute("itemid") then
			starts,dur,ends = GetItemCooldown(self:GetAttribute("itemid"))
		elseif self:GetAttribute("spellid") then
			starts,dur,ends = GetSpellCooldown(self:GetAttribute("spellid"))
		elseif self:GetAttribute("petid") then
			starts,dur,ends = GetPetActionCooldown(self:GetAttribute("petid"))
		end
	end

	CooldownFrame_Set(self.cd, starts,dur,ends)
	if starts>0 then self.cd:Show() else self.cd:Hide() end
end


function ActionButton:UpdateTexture()
	if InCombatLockdown() then return end

	local tex, found = nil, true
	if self:GetAttribute("type")=="spell" then
		tex = select(3, GetSpellInfo(self:GetAttribute("spell")))
		if not tex then 
			tex = 1121022
			found = false
		end
	elseif self:GetAttribute("type")=="item" then
		tex = select(10, ZGV:GetItemInfo(self:GetAttribute("item")))
		if not tex then 
			tex = 1121021
			found = false
		end
	elseif self:GetAttribute("type")=="macro" then
		tex = select(2,GetMacroInfo(self:GetAttribute("macro")))
		if not tex then 
			tex = 1121020
			found = false
		end
	elseif self:GetAttribute("type")=="petaction" then
		_,_,tex,needsglobal = GetPetActionInfo(self:GetAttribute("petaction"))
		if not tex then 
			tex = 1121022
			found = false
		end
		if needsglobal then
			self.PetAction.icon:SetTexture(_G[tex])
		else
			self.PetAction.icon:SetTexture(tex)
		end
		return
	end
	self.tex:SetTexture(tex)
	if not found then
		if self.timer then ZGV:CancelTimer(self.timer) end
		self.timer = ZGV:ScheduleTimer(function() 
			self:UpdateTexture()
		end, 0.5)
	end		
end

function ActionButton:SetSpell(spellid)
	if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
	if InCombatLockdown() then 
		if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
		self.actionTimer = ZGV:ScheduleTimer(function() 
			self:SetSpell(spellid)
		end, 0.5)
		return 
	end
	self:ClearData()

	self:SetAttribute("type","spell")
	self:SetAttribute("spell",spellid)
	self:Show()
	self:UpdateTexture()
end

function ActionButton:SetItem(itemid)
	if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
	if InCombatLockdown() then 
		if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
		self.actionTimer = ZGV:ScheduleTimer(function() 
			self:SetItem(itemid)
		end, 0.5)
		return 
	end
	self:ClearData()

	self:SetAttribute("type","item")
	self:SetAttribute("item","item:"..itemid)
	self:SetAttribute("itemid",tonumber(itemid))
	self:Show()
	self:UpdateTexture()
end

function ActionButton:SetMacro(macro)
	if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
	if InCombatLockdown() then 
		if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
		self.actionTimer = ZGV:ScheduleTimer(function() 
			self:SetMacro(macro)
		end, 0.5)
		return 
	end
	self:ClearData()

	self:SetAttribute("type","macro")
	self:SetAttribute("macro",macro)
	self:Show()
	self:UpdateTexture()
end

function ActionButton:SetPetAction(petaction)
	if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
	if InCombatLockdown() then 
		if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
		self.actionTimer = ZGV:ScheduleTimer(function() 
			self:SetPetAction(petaction)
		end, 0.5)
		return 
	end
	self:ClearData()

	local num,name,subtext,tex = ZGV.FindPetActionInfo(petaction)

	if name then
		self:SetAttribute("type","petaction")
		self:SetAttribute("petaction",num)
			
		self.PetAction:SetID(num)
		self.PetAction:Show()
		self:Show()
		self.PetAction:SetFrameLevel(self:GetFrameLevel()+2)
		self:UpdateTexture()

	else
		self:Hide()
		self.PetAction:Hide()
	end
end

function ActionButton:ClearData()
	if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
	if InCombatLockdown() then 
		if self.actionTimer then ZGV:CancelTimer(self.actionTimer) end
		self.actionTimer = ZGV:ScheduleTimer(function() 
			self:ClearData()
		end, 0.5)
		return 
	end

	self:SetAttribute("type",nil)
	self:SetAttribute("macro",nil)
	self:SetAttribute("item",nil)
	self:SetAttribute("itemid",nil)
	self:SetAttribute("spell",nil)
	self:SetAttribute("spellid",nil)
	self:SetAttribute("petaction",nil)
	self:SetAttribute("petid",nil)
	self:SetAttribute("zygor",nil)
	self:SetAttribute("rawobject",nil)
	self:SetAttribute("rawtype",nil)
	
	self.tex:SetTexture(nil)
	self:Hide()

	self.tooltip=nil

	self.PetAction.icon:SetTexture(nil)
	self.PetAction:Hide()
end

function ActionButton:EnableCooldown()
	self.cooldownDisabled = false
	self:UpdateCooldown()
end

function ActionButton:DisableCooldown()
	self.cooldownDisabled = true
	self.cd:Hide()
end

function ActionButton:EnableHighlight()
	self:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
end

function ActionButton:DisableHighlight()
	self:SetHighlightTexture(nil)
end

function ActionButton:EnableTooltip()
	self.tooltipDisabled = false
end

function ActionButton:DisableTooltip()
	self.tooltipDisabled = true
end

function ActionButton:EnableDrag()
	self.draggable = true
end

function ActionButton:DisableDrag()
	self.draggable = false
end