local ZGV = ZygorGuidesViewer
if not ZGV then return end

local ActionBar = {
	Buttons = {},
	Timers = {},
}

ZGV.ActionBar = ActionBar

local CHAIN = ZGV.ChainCall
local L = ZGV.L
local ui = ZGV.UI
local SkinData = ui.SkinData

local BUTTON_SIZE = 30
local BAR_HEIGHT = BUTTON_SIZE+10

function ActionBar:ShowTooltip()
	if ActionBar.Active then return end

	GameTooltip:SetOwner(ActionBar.Frame,"ANCHOR_BOTTOMLEFT")
	GameTooltip:SetText("Zygor Action Bar")
	GameTooltip:Show()

end

function ActionBar:CreateFrame() 
	if not ActionBar.Frame then
		ActionBar.Frame = CHAIN(ui:Create("Frame", UIParent, "ZygorGuidesViewer_ActionBar"))
			:SetSize(BAR_HEIGHT,BAR_HEIGHT)
			:SetPoint("BOTTOMLEFT",ZGV.Frame,"TOPLEFT",0,10)
			:SetFrameStrata("LOW")
			:SetFrameLevel(10)
			:CanDrag(true)
			:SetScript("OnEnter", function()
				ActionBar:ShowTooltip()
				end
			)
			:SetScript("OnLeave", function()
				GameTooltip:Hide()
				end
			)
			:SetScript("OnDragStop", function()
				ActionBar.Frame:StopMovingOrSizing()
				ZGV.db.profile.actionbar_anchor = {ActionBar.Frame:GetPoint()}
			end)
			:Hide()
		.__END
		ActionBar.Frame.Overlay = CHAIN(ui:Create("Frame", ActionBar.Frame))
			:SetAllPoints()
			:SetAlpha(0.7)
			:SetFrameLevel(15)
			:Hide()
		.__END
		ActionBar.Frame.close = CHAIN(CreateFrame("Button",nil,ActionBar.Frame))
			:SetPoint("TOPRIGHT",ActionBar.Frame,"TOPRIGHT", -5, -4)
			:SetSize(17,17)
			:SetScript("OnClick", function() 
				ZGV.db.profile.enable_actionbar = false
				ActionBar:ToggleFrame()
			 end)
			.__END
		ZGV.F.AssignButtonTexture(ActionBar.Frame.close,(SkinData("TitleButtons")),6,32)
		
		if ZGV.db.profile.actionbar_anchor then
			ZGV.db.profile.actionbar_anchor[2]=UIParent
			ActionBar.Frame:ClearAllPoints()
			ActionBar.Frame:SetPoint(unpack(ZGV.db.profile.actionbar_anchor))
		end
	end
	
	ActionBar:ApplySkin()
end

function ActionBar:ApplySkin()
	local MF = ActionBar.Frame
	if not MF then return end

	ZGV.F.AssignButtonTexture(MF.close,(SkinData("TitleButtons")),6,32)

	MF:SetBackdropColor(unpack(SkinData("MainBackdropColor")))
	MF:SetBackdropBorderColor(unpack(SkinData("MainBackdropBorderColor")))

	ActionBar:SetAlpha()
	ActionBar:SetScale() 
end

function ActionBar:ToggleFrame()
	if not ActionBar.Frame then
		ActionBar:CreateFrame()
	end

	if ActionBar.ToggleTimer then ZGV:CancelTimer(ActionBar.ToggleTimer) end
	if InCombatLockdown() then 
		ActionBar.ToggleTimer = ZGV:ScheduleTimer(function() 
			ActionBar:ToggleFrame()
		end, 1)
		return
	end
	
	if ZGV.db.profile.enable_actionbar and ZGV.db.profile.enable_actionbuttons then
		ZGV:SetActionButtons()
		ActionBar.Frame:Show()
	else
		ActionBar.Frame:Hide()
	end
		
end

function ActionBar:SetButton(btype,object) 
	if not ZGV.db.profile.enable_actionbuttons then return end

	if ActionBar.Timers[timer_id] then ZGV:CancelTimer(ActionBar.Timers[timer_id]) end

	local function retry()
		local timer_id = btype.." "..object
		ActionBar.Timers[timer_id] = ZGV:ScheduleTimer(function() 
			ActionBar:SetButton(btype,object)
		end, 1)
	end

	if InCombatLockdown() then 
		return retry()
	end

	
	if btype and not object then ZGV:Debug("ActionButton must have data defined if type is set") return end

	local button,action_index = false,false
	-- look for any unused button, and use it if found
	for i,v in pairs(ActionBar.Buttons) do
		if btype==v:GetAttribute("rawtype") and object==v:GetAttribute("rawobject") then -- button for that item/spell already exists, show it, and don't create clones
			return v
		elseif not v:GetAttribute("type") then
			button = v
			action_index = i
			break
		end
	end

	-- if no unused was found, create new one
	if not button then
		local num = #ActionBar.Buttons+1
		button = ZGV.UI:Create("ActionButton",ActionBar.Frame,"ZygorAB"..num)
		button:SetSize(BUTTON_SIZE,BUTTON_SIZE)
		button:SetID(num)
		button:EnableDrag()
		table.insert(ActionBar.Buttons,button)
		action_index = num
	end

	local macro_index = GetMacroIndexByName("ZygorAction"..action_index)
	if macro_index==0 then
	    macro_index = CreateMacro("ZygorAction"..action_index, 134400, "") -- create empty macro
	end

	local macro_text, macro_texture, macro_name,macro_tooltip = "", 134400
	-- set data based on type
	if btype=="item" then 
		macro_name,_,_,_,_,_,_,_,_,macro_texture = ZGV:GetItemInfo(object)
		if not macro_name then return retry() end
		macro_text = "#showtooltip "..macro_name.."\n/use item:"..object
		button:SetAttribute("itemid",object)
	elseif btype=="spell" then
		macro_name,_,macro_texture = GetSpellInfo(object)
		if not macro_name then return retry() end
		macro_text = "#showtooltip "..macro_name.."\n/cast "..macro_name
		button:SetAttribute("spellid",object)
	elseif btype=="petaction" then
		local num,needsglobal
		num,macro_name = ZGV.FindPetActionInfo(object)
		if not macro_name then return retry() end
		_,macro_texture = GetPetActionInfo(num)
		
		if not tonumber(macro_texture) then 
			macro_texture = 132319 
		elseif needsglobal then 
			macro_texture = _G[macro_texture] 
		end
		macro_text = "#showtooltip "..macro_name.."\n/cast "..macro_name
		button:SetAttribute("petaction",object)
	elseif btype=="emote" then
		if type(object)=="number" then 
			macro_text = GetMacroBody(object)
			_,macro_texture = GetMacroInfo(object)
		else
			macro_text = "/run "..object
			macro_texture = 132319
		end
		--_,macro_texture = GetMacroInfo(object)
		macro_tooltip = macro_text:sub(15,-3) -- /run DoEmote("blah") -> blah
	elseif btype=="zygor" then
		button:SetAttribute("zygor","zygor")
	end

	EditMacro(macro_index,nil,macro_texture,macro_text)

	if btype=="item" then 
		SetMacroItem(macro_index,macro_name)
	elseif btype=="spell" or btype=="petaction" then
		SetMacroSpell(macro_index,macro_name)
	end

	button:SetMacro(macro_index)

	if btype=="item" then 
		button:SetAttribute("itemid",object)
	elseif btype=="spell" then
		button:SetAttribute("spellid",object)
	elseif btype=="petaction" then
		local num,needsglobal
		num,macro_name = ZGV.FindPetActionInfo(object)
		button:SetAttribute("petid",num)
	end

	if macro_tooltip then
		button.tooltip = macro_tooltip
	end

	-- store object in zygor defined field for easier search of existing buttons later
	button:SetAttribute("rawobject",object)
	button:SetAttribute("rawtype",btype)

	-- object added may have been already on cooldown, so update cd timer
	button:UpdateCooldown()

	ActionBar:ReanchorButtons()

	return button
end


function ActionBar:ClearBar() 
	if not ActionBar.Frame then return end
	ActionBar.Frame.Overlay:Show()
	for _,timer in pairs(ActionBar.Timers) do
		ZGV:CancelTimer(timer)
	end
	for i,v in pairs(ActionBar.Buttons) do
		v:ClearData()
	end

	for i=1,10 do
		local j = GetMacroIndexByName("ZygorAction"..i)
		if j>0 then
			EditMacro(j,nil,134400,"")
			SetMacroItem(j,"")
			SetMacroSpell(j,"")
		else
			break
		end
	end

	ActionBar:ReanchorButtons()
end

function ActionBar:ReanchorButtons(force) 
	if not ActionBar.Frame then return end
	if not ZGV.db.profile.enable_actionbuttons and not force then return end -- everything is disabled, abort
	if not ZGV.db.profile.enable_actionbar and not force then return end -- we are not showin buttons, only updating macros. bail out

	local previous = false
	local space = 5
	local width = space
	local active = false
	for i,v in pairs(ActionBar.Buttons) do
		if v:GetAttribute("type") then
			if not previous then
				v:SetPoint("TOPLEFT",ActionBar.Frame,"TOPLEFT",space,-space)
			else
				v:SetPoint("TOPLEFT",previous,"TOPRIGHT",space,0)
			end
			width = width + v:GetWidth() + space
			previous = v
			active = true
		end
	end

	ActionBar.Active = active

	ActionBar.Frame:SetWidth(width+25)
	ActionBar.Frame.Overlay:Hide()

	if force=="off" then 
		ActionBar.Frame:Hide()
		return 
	elseif active or force=="on" then 
		ActionBar.Frame:Show()
	-- -- actionbar_hide_useless variant
	--elseif ZGV.db.profile.actionbar_hide_useless then
	--	ActionBar.Frame:Hide()
	--else 
	--	ActionBar.Frame:Show()
	else 
		ActionBar.Frame:Hide()
	end
end

function ActionBar:SetScale() 
	if ActionBar.ScaleTimer then ZGV:CancelTimer(ActionBar.ScaleTimer) end
	if InCombatLockdown() then 
		ActionBar.ScaleTimer = ZGV:ScheduleTimer(function() 
			ActionBar:SetScale()
		end, 1)
		return
	end
	ActionBar.Frame:SetScale(ZGV.db.profile.actionbar_scale)
end

function ActionBar:SetAlpha(value) 
	if ActionBar.OpacityTimer then ZGV:CancelTimer(ActionBar.OpacityTimer) end
	if InCombatLockdown() then 
		ActionBar.OpacityTimer = ZGV:ScheduleTimer(function() 
			ActionBar:SetAlpha()
		end, 1)
		return
	end
	ActionBar.Frame:SetAlpha(value or ZGV.db.profile.opacitymain)
end

function ActionBar:TutorialPreview(mode) 
	local button = ActionBar.Buttons[1]

	if ActionBar.Frame:IsVisible() and (button and not button:GetAttribute("zygor")) then return end -- there is a non-faked button visible, do not hide/show anything


	if mode=="on" then
		if not (button and button:GetAttribute("type")) then -- there is no button visible, make a fake one
			button = ActionBar:SetButton("macro","")
			button:SetAttribute("zygor","zygor")
		end
		ActionBar:ReanchorButtons("on")
	else
		if button then button:SetAttribute("type",nil) end -- clear whatever is visible
		ActionBar:ReanchorButtons(not ZGV.db.profile.enable_actionbar and "off")
	end
end

tinsert(ZGV.startups,{"ActionBar startup",function(self)
	-- create globals for blizzard keybind menu
	for i=1,5 do
		_G[("BINDING_NAME_CLICK ZygorAB%d:LeftButton"):format(i)] = ("Zygor ActionBar Button %d"):format(i)
	end
	BINDING_HEADER_ZYGORGUIDESATIONBAR = "Zygor Guides Viewer Action Bar"
	ActionBar:CreateFrame()
end})
