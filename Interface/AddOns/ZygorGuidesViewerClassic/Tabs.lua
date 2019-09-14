ZGV.Tabs = {}

local Tabs = ZGV.Tabs
local CHAIN = ZGV.ChainCall
local ui = ZGV.UI
local SkinData = ui.SkinData
local L = ZGV.L

Tabs.Pool = {}

-- update tabs layout when main zygor frame is resized
function Tabs:StartSizing()
	Tabs.ResizeTimer = ZGV:ScheduleRepeatingTimer(function() Tabs:ReanchorTabs() end, 0.01)
end

-- update tabs layout when main zygor frame is resized
function Tabs:StopMovingOrSizing()
	if Tabs.ResizeTimer then ZGV:CancelTimer(Tabs.ResizeTimer) end
end

local function tabs_update_handler(frame, elapsed)
	if not Tabs.ActiveTab then return end

	local now = debugprofilestop()
	if now-Tabs.lastUpdated<100 then return end

	Tabs.lastUpdated = now

	if ZGV.skipping then
		Tabs.ActiveTab:SetBusy(true)
	else
		Tabs.ActiveTab:SetBusy(false)
	end
end

-- startup - create buttons, hook into zygor sizing functions, load saved tabs
function Tabs:Initialize()
	Tabs.AddButton = CHAIN(CreateFrame("Button", nil, ZGV.Frame, nil))
		:SetBackdrop(SkinData("GuideBackdrop"))
		:SetBackdropColor(0,0,0,1)
		:SetBackdropBorderColor(unpack(SkinData("GuideBackdropBorderColor")))
		:SetSize(SkinData("TabsHeight"),SkinData("TabsHeight"))
		:SetScript("OnUpdate",tabs_update_handler) 
		:SetScript("OnClick",function(self,button) 
			if button=="RightButton" then
				ZGV.GuideMenu:Show("Suggested")
			else
				ZGV.GuideMenu:Show()
			end
			ZGV.GuideMenu.UseTab = nil
		end)
		:SetScript("OnEnter",function() 
			GameTooltip:SetOwner(Tabs.AddButton, "ANCHOR_TOP")
			GameTooltip:SetText(ZGV.L['frame_selectguide'])
			GameTooltip:AddLine(ZGV.L['frame_selectguide_left'],0,1,0)
			GameTooltip:Show()
		end)
		:SetScript("OnLeave",function() 
			GameTooltip:Hide()
		end)
		:SetPoint("BOTTOMLEFT",ZGV.Frame.Border.Guides,"TOPLEFT",0,-1)
		:Show()
	.__END

	ZGV.F.AssignButtonTexture(Tabs.AddButton,SkinData("TitleButtons"),23,32)
--[[
	CHAIN(Tabs.AddButton:GetNormalTexture()):ClearAllPoints():SetPoint("TOPLEFT",3,-3):SetPoint("BOTTOMRIGHT",-3,3):SetVertexColor(1,0.3,0.3,1)
	CHAIN(Tabs.AddButton:GetPushedTexture()):ClearAllPoints():SetPoint("TOPLEFT",3,-3):SetPoint("BOTTOMRIGHT",-3,3):SetVertexColor(1,0.3,0.3,1)
	CHAIN(Tabs.AddButton:GetHighlightTexture()):ClearAllPoints():SetPoint("TOPLEFT",3,-3):SetPoint("BOTTOMRIGHT",-3,3):SetVertexColor(1,0,0,1)
	CHAIN(Tabs.AddButton:GetDisabledTexture()):ClearAllPoints():SetPoint("TOPLEFT",3,-3):SetPoint("BOTTOMRIGHT",-3,3):SetVertexColor(1,0.3,0.3,1)
--]]
	Tabs.MoreButton = CHAIN(CreateFrame("Button", nil, ZGV.Frame, nil))
		:SetBackdrop(SkinData("GuideBackdrop"))
		:SetBackdropColor(unpack(SkinData("GuideBackdropColor")))
		:SetBackdropBorderColor(unpack(SkinData("GuideBackdropBorderColor")))
		:SetSize(SkinData("TabsHeight"),SkinData("TabsHeight"))
		:SetPoint("BOTTOMRIGHT",ZGV.Frame.Border.Guides,"TOPRIGHT",-SkinData("TabsHeight")-1,0)
		:SetScript("OnClick",function(self,button) 
			Tabs:ToggleRemainingMenu()
		end)
		:SetScript("OnEnter",function() 
		end)
		:SetScript("OnLeave",function() 
			GameTooltip:Hide()
		end)
		:Hide()
	.__END
	ZGV.F.AssignButtonTexture(Tabs.MoreButton,SkinData("TitleButtons"),16,32)

	Tabs.RemainingMenu = CHAIN(CreateFrame("Frame",nil,Tabs.MoreButton))
		:SetPoint("TOPRIGHT",Tabs.MoreButton,"BOTTOMRIGHT")
		:SetFrameStrata("MEDIUM")
		:SetSize(1,1)
		:Hide()
	.__END

	hooksecurefunc(ZygorGuidesViewerFrame,"StartSizing", function() Tabs:StartSizing() end)
	hooksecurefunc(ZygorGuidesViewerFrame,"StopMovingOrSizing", function() Tabs:StopMovingOrSizing() end)

	local last = nil
	for tabnum,guidedata in pairs(ZGV.db.char.tabguides) do
		local tab = Tabs:GetTabFromPool()
		tab:AssignGuide(guidedata.title,guidedata.step)
		if guidedata.title==ZGV.db.char.guidename then -- this was the last guide used, make the tab active
			tab:SetAsCurrent()
		end
		last = tab
	end

	Tabs.lastUpdated = debugprofilestop()
	Tabs:ReanchorTabs()
end

function Tabs:LoadGuideToTab(guide,step,special,shared)
	if Tabs:TryToActivateGuide(guide) then 
		Tabs:AssignGuide(guidetitle,step,shared)
		return
	else
		local tab
		if special then
			tab = Tabs:GetSpecialTabFromPool(special)
		else
			tab = Tabs:GetTabFromPool()
		end
		tab:SetAsCurrent()
		tab:AssignGuide(guide,step,shared)
		tab:ActivateGuide()
	end
end

-- get one of unused tabs, or create new one
function Tabs:GetTabFromPool()
	for i,tab in pairs(Tabs.Pool) do
		if not tab.guide then 
			return tab
		end
	end

	return Tabs:CreateTab() 
end

function Tabs:TryToActivateGuide(guide)
	if not guide then return false end

	for i,tab in pairs(Tabs.Pool) do
		if tab.guide==guide then
			tab:ActivateGuide() 
			return tab
		end
	end
	return false
end

-- get one of unused tabs for given header variable, or create new one
-- returns tab and if the tab already existed
function Tabs:GetSpecialTabFromPool(mode)
	for i,tab in pairs(Tabs.Pool) do
		if tab.guide and tab.guide.headerdata and tab.guide.headerdata[mode]  then 
			return tab, true
		end
	end

	return Tabs:GetTabFromPool(), false
end

-- update visual data based on current skin
function Tabs:ApplySkin()
	if not Tabs.lastUpdated then return end -- nope, not ready yet
	local show_icons = ZGV.db.profile.tabs_icon
	for i,tab in pairs(Tabs.Pool) do
		if show_icons then
			tab.Icon:Show()
			tab.Text:SetPoint("LEFT",20,0)
		else
			tab.Icon:Hide()
			tab.Text:SetPoint("LEFT",5,0)
		end
		tab.Button:SetBackdropColor(unpack(SkinData("TabsBackdropInactive")))
		tab.Button:SetBackdropBorderColor(unpack(SkinData("TabsBorderColor")))
		tab.Button:SetNormalBackdropColor(unpack(SkinData("TabsBackdropInactive")))
		tab.Button:SetHighlightBackdropColor(unpack(SkinData("TabsBackdropActive")))
		tab.Text:SetTextColor(unpack(SkinData("TabsTextColor")))
		tab.Icon:SetTexture(SkinData("TabsIcons"))
		if tab.isActive then
			tab.Button:SetNormalBackdropColor(unpack(SkinData("TabsBackdropActive")))
		end
	end

	ZGV.F.AssignButtonTexture(Tabs.AddButton,SkinData("TitleButtons"),23,32)

	Tabs:ReanchorTabs()	
end

-- resize tabs, maybe hide tabs that are outside of visible area and show dropdown
function Tabs:ReanchorTabs()
	if not Tabs.lastUpdated then return end
	if not (ZGV.Frame and ZGV.Frame:IsVisible()) then return end
	local prev = nil
	local count = 0

	-- Count active tabs
	for i,tab in pairs(Tabs.Pool) do
		if tab.guide then 
			count = count + 1
		end
	end

	-- Resize
	local add_button_width = Tabs.AddButton:GetWidth()
	local more_button_width = Tabs.MoreButton:GetWidth()
	local frame_width = ZGV.Frame:GetWidth()-2*SkinData("TabsMargin")
	local tab_width = ((frame_width-add_button_width) / 3) - 1

	if count>3 then
		tab_width = ((frame_width-add_button_width-more_button_width) / 3) - 1
		Tabs.MoreButton:Show()
	else
		Tabs.MoreButton:Hide()
	end

	-- Reposition
	local visible_prev, hidden_prev = nil, nil
	for i,tab in pairs(Tabs.Pool) do
		if tab.guide then 
			tab.Button:ClearAllPoints()
			-- Show guide remove button. We may hide it later, if only one tab is visible.
			tab.Close.DoShow=true
			tab.Change:SetPoint("TOPRIGHT",tab.Close,"TOPLEFT")

			tab.Button:SetWidth(tab_width)
			tab.Button:Show()

			if count == 1 then
				tab.Close.DoShow = false
			else
				tab.Close.DoShow = true
			end


			if i<=3 then
				tab:HideInteraction()
				tab.Button:SetParent(ZGV.Frame)
				tab.Hidden = false

				if visible_prev then
					tab.Button:SetPoint("TOPLEFT",visible_prev,"TOPRIGHT",1,0)
				else
					tab.Button:SetPoint("BOTTOMLEFT",ZGV.Frame.Border.Guides,"TOPLEFT",0,-1)
				end
				visible_prev = tab.Button

				Tabs.AddButton:SetPoint("LEFT",visible_prev,"RIGHT",1,0)
			else
				tab.Button:SetParent(Tabs.RemainingMenu)
				tab.Hidden = true
				if hidden_prev then
					tab.Button:SetPoint("TOPLEFT",hidden_prev.Button,"BOTTOMLEFT")
				else
					tab.Button:SetPoint("TOPRIGHT",Tabs.RemainingMenu,"TOPRIGHT")
				end
				hidden_prev = tab
				Tabs.AddButton:SetPoint("LEFT",Tabs.MoreButton,"RIGHT",1,0)
			end
		else
			tab.Button:Hide()
		end
	end
end

-- show/hide dropdown for additional tabs
function Tabs:ToggleRemainingMenu()
	if Tabs.RemainingMenu:IsVisible() then
		Tabs.RemainingMenu:Hide()
		return
	end

	Tabs.RemainingMenu:Show()
end

-- update guide for current tab, select tab if none was activated before
function Tabs:UpdateCurrentTab()
	local tab

	-- tab already activated during this session
	if Tabs.ActiveTab then 
		tab = Tabs.ActiveTab 
	-- no tab activated, found one that has current guide
	else
		for _,tabobj in pairs(Tabs.Pool) do
			if tabobj.title==ZGV.CurrentGuide.title then
				tab=tabobj
				break
			end
		end
	end

	if not tab then 
	-- legacy support, guide loaded when tab support did not exist
		tab = Tabs:GetTabFromPool()
	end

	tab:SetAsCurrent()
	tab:AssignGuide(ZGV.CurrentGuide.title,ZGV.CurrentGuide.CurrentStepNum,ZGV.CurrentGuide.type=="SHARED")
end

function Tabs:DoesTabExist(title)
	for _,tabobj in pairs(Tabs.Pool) do
		if tabobj.title==title then
			return tabobj
		end
	end

	return false
end

function Tabs:DoesSpecialTabExist(mode)
	for i,tab in pairs(Tabs.Pool) do
		if tab.guide and tab.guide.headerdata and tab.guide.headerdata[mode]  then 
			return true
		end
	end

	return false
end

-- tab over/out are not as simple as they could be, since for nested buttons mouse out event sometimes does not trigger, so we need to keep track of over/out states by ourselves.
function Tabs:HideInteraction()
	if self.Button:IsMouseOver() then ZGV:ScheduleTimer(function() self:HideInteraction() end, 0.1) return end

	self.Close:Hide()
	self.Change:Hide()
	self.Text:SetTextColor(unpack(SkinData("TabsTextColor")))
	if not self.Active then
		self.Button:SetBackdropColor(unpack(self.Button.bdcolor))
		self.ButtonsContainer:Hide()
	end

	GameTooltip:Hide()
end

function Tabs:ShowInteraction(text)
	if self.Close.DoShow then self.Close:Show() end
	self.Change:Show()
	self.Text:SetTextColor(unpack(SkinData("TabsTextColorOver")))
	self.Button:SetBackdropColor(unpack(self.Button.bdhcolor))
	self.ButtonsContainer:Show()
	
	text = text or self.title_short
	if text then
		GameTooltip:SetOwner(self.Button,"ANCHOR_BOTTOM")
		GameTooltip:ClearAllPoints()
		GameTooltip:ClearLines()
		GameTooltip:SetText(text)
		GameTooltip:SetWidth(300)
		GameTooltip:Show()
	end

	ZGV:ScheduleTimer(function() self:HideInteraction() end, 0.1)
end

function Tabs:CreateTab()
	local tab_height = SkinData("TabsHeight")
	local icon_size = SkinData("TabsIconSize")
	
	local tab = {}
	tab.Button = CHAIN(ui:Create("Button",ZGV.Frame))
		:SetSize(100,tab_height)
		:SetFont(FONT,12)
		:SetText("Guide Title")
		:SetTexture("") -- initialize texture, will tweak it later
		:SetScript("OnClick",function() tab:ActivateGuide() end)
		:SetScript("OnEnter",function() tab:ShowInteraction() end)
		:SetScript("OnLeave",function() tab:HideInteraction() end)
		:SetBackdropColor(unpack(SkinData("TabsBackdropInactive")))
		:SetBackdropBorderColor(unpack(SkinData("TabsBorderColor")))
		:SetNormalBackdropColor(unpack(SkinData("TabsBackdropInactive")))
		:SetHighlightBackdropColor(unpack(SkinData("TabsBackdropActive")))
		:Hide()
	.__END

	tab.Button.ZygorTab=true



	-- move text to left with space for icon
	tab.Text = CHAIN(tab.Button:GetFontString())
		:ClearAllPoints()
		:SetPoint("LEFT",icon_size+6,0)
		:SetPoint("RIGHT",0,0)
		:SetJustifyH("LEFT")
		:SetWordWrap(false)
		:SetTextColor(unpack(SkinData("TabsTextColor")))

	-- place texture to be used for guide icon on the very left
	tab.Icon = CHAIN(tab.Button.tex)
		:ClearAllPoints()
		:SetPoint("LEFT",4,0)
		:SetSize(icon_size,icon_size)
		:SetTexture(SkinData("TabsIcons"))

	-- place texture to be used for guide icon on the very left
	tab.IconBusy = CHAIN(tab.Button:CreateTexture())
		:ClearAllPoints()
		:SetPoint("LEFT",4,0)
		:SetSize(icon_size,icon_size)
		:SetTexture(SkinData("TabsBusyIcon"))
		:Hide()
	.__END

	tab.AnimBusy = CHAIN(tab.IconBusy:CreateAnimationGroup())
		:SetLooping("REPEAT")
		:SetScript("OnPlay", function() 
			tab.Icon:Hide()
			tab.IconBusy:Show() 
		end)
		:SetScript("OnStop", function() 
			tab.IconBusy:Hide() 
			tab.Icon:Show() 
		end)
	.__END
		tab.AnimBusyRotate = CHAIN(tab.AnimBusy:CreateAnimation("Rotation")) 
			:SetDegrees(-360) 
			:SetDuration(2)
		.__END

	tab.Separator = CHAIN(tab.Button:CreateTexture())
		:SetPoint("TOPLEFT",tab.Button,"TOPRIGHT")
		:SetTexture(SkinData("TabsSeparatorTexture"))
		:SetSize(1,tab_height)
		:SetVertexColor(unpack(SkinData("TabsSeparatorColor")))
	.__END

	tab.ButtonsContainer = CHAIN(ui:Create("Frame",tab.Button))
		:SetSize(icon_size*2+2,tab_height-1)
		:SetBackdropColor(unpack(SkinData("TabsBackdropActive")))
		:SetBackdropBorderColor(0,0,0,0)
		:SetPoint("RIGHT",0,-1)
	.__END

	tab.Close = CHAIN(CreateFrame("Button", nil, tab.ButtonsContainer, nil))
		:SetSize(icon_size,icon_size)
		:SetPoint("RIGHT",tab.ButtonsContainer,"RIGHT")
		:SetScript("OnClick",function(self) tab:RemoveTab() end)
		:SetScript("OnEnter",function(self)
			tab:ShowInteraction("Close current tab")
		end)
		:SetScript("OnLeave",function(self)
			tab:HideInteraction()
		end)
		:Hide()
	.__END
	ZGV.F.AssignButtonTexture(tab.Close,ZGV.SkinDir.."titlebuttons",6,32)

	tab.Change = CHAIN(CreateFrame("Button", nil, tab.ButtonsContainer, nil))
		:SetSize(icon_size,icon_size)
		:SetPoint("RIGHT",tab.Close,"LEFT")
		:SetScript("OnClick",function(self) 
			ZGV.GuideMenu:Show() 
			ZGV.GuideMenu.UseTab = tab
		end)
		:SetScript("OnEnter",function() 
			tab:ShowInteraction("Change current guide")
		end)
		:SetScript("OnLeave",function(self)
			tab:HideInteraction()
		end)
		:Hide()
	.__END
	ZGV.F.AssignButtonTexture(tab.Change,ZGV.SkinDir.."titlebuttons",26,32)

	tab.Num = #Tabs.Pool+1

	if not ZGV.db.profile.tabs_icon then
		tab.Icon:Hide()
		tab.Text:SetPoint("LEFT",5,0)
	end


	table.insert(Tabs.Pool,tab)
	setmetatable(tab,{ __index=Tabs })

	return tab
end

function Tabs:SetBusy(state)
	if state and not self.Busy then
		self.Busy = true
		self.AnimBusy:Play()
	elseif not state then
		self.Busy = false
		self.AnimBusy:Stop()
	end
end


function Tabs:SetAsCurrent()
	if Tabs.ActiveTab then 
		Tabs.ActiveTab.isActive = false 
		Tabs.ActiveTab.Button:SetNormalBackdropColor(unpack(SkinData("TabsBackdropInactive")))
	end
	
	Tabs.ActiveTab = self
	self.isActive = true
	self.Button:SetNormalBackdropColor(unpack(SkinData("TabsBackdropActive")))
end

function Tabs:ActivateGuide()
	self:SetAsCurrent()
	ZGV.ProgressBar:SetAnim("noinit") -- don't animate progress bar on switching tabs

	ZGV:SetGuide(self.guide,self.step,false,"silent")

	-- tab was in dropdown menu, move to first slot, hide menu
	if self.Hidden then 
		-- Shift tab to start of array
		local temp = table.remove(Tabs.Pool,self.Num)
		table.insert(Tabs.Pool,1,temp)

		-- Refresh tab numbers
		for i,tab in pairs(Tabs.Pool) do tab.Num=i end

		self.Hidden = false

		Tabs.RemainingMenu:Hide()

		Tabs:ReanchorTabs()
	end
end

local MAX_GUIDES_HISTORY = 30
function Tabs:AssignGuide(guidetitle,step,shared)
	local guide
	if shared then
		guide = ZGV.Sync.SharedGuide
	else
		if type(guidetitle)=="string" then 
			guide = ZGV:GetGuideByTitle(guidetitle)
		else
			guide = guidetitle
			guidetitle = guide.title
		end
	end

	if not guide then
		for tabnum,guidedata in pairs(ZGV.db.char.tabguides) do
			if guidedata.title==guidetitle then
				ZGV.db.char.tabguides[tabnum]=nil
				return
			end
		end
	end

	self.guide = guide
	self.title = guide.title
	self.title_short = guide.title_short
	self.step = step
	self.Button:SetText(guide.title_short)
	
	local x,y,label = unpack(ZGV.GuideMenu.GUIDE_DISPLAY[self.guide.type])
	self.icon_x = x
	self.icon_y = y
	self.Icon:SetTexCoord((x-1)/4,x/4,(y-1)/4,y/4)


	if not shared then
		ZGV.db.char.tabguides[self.Num] = {title=guidetitle, step=step}
	end

	Tabs:ReanchorTabs()

	local headerdata = guide.headerdata
	if headerdata and headerdata.shared then return end -- don't store shared guides in history

	local history = ZGV.db.char.guides_history
	if headerdata and headerdata.worldquestzone then -- find any world quest guide, remove it
		for gi,gd in ipairs(history) do
			if gd[3]=="worldquest" then tremove(history,gi) break end
		end
	else -- normal guide
		for gi,gd in ipairs(history) do
			if gd[1]==guidetitle then tremove(history,gi) break end
		end
	end

	while #history>=MAX_GUIDES_HISTORY do tremove(history) end
	tinsert(history,1,{guidetitle,step,guide.headerdata.worldquestzone and "worldquest"})
end

function Tabs:RemoveTab()
	-- close current tab
	self.Button:Hide()
	self.guide = nil
	self.step = nil
	self.title = nil
	self.title_short = nil

	if self.guide and self.guide.headerdata and self.guide.headerdata.shared then -- if shared tab is removed, stop share slaving
		self.db.profile.share_masterslave = 0
	end

	if self.isActive then
	-- this was the active guide. find something else to show
		local found
		for i=self.Num+1,#Tabs.Pool do -- try to activate next tab
			if Tabs.Pool[i].guide then
				Tabs.Pool[i]:ActivateGuide()
				break
			end
		end
		if not found then -- nothing? try to activate previous tab
			for i=1,self.Num do
				if Tabs.Pool[i].guide then
					Tabs.Pool[i]:ActivateGuide()
					break
				end
			end
		end
	end

	-- Remmove guide from saved tab list
	table.remove(ZGV.db.char.tabguides,self.Num)

	-- Shift tab to end of array
	local temp = table.remove(Tabs.Pool,self.Num)
	table.insert(Tabs.Pool,temp)

	-- Refresh tab numbers
	for i,tab in pairs(Tabs.Pool) do tab.Num=i end

	self.isActive = false
	Tabs:ReanchorTabs()
end

function ZGV.Tabs:OptionalTab(params)
	local step,guide = ZGV.CurrentStep:GetJumpDestination(params)
	if not guide then 
		-- we are jumping within same guide, don't ask about anything
		ZGV:FocusStep(step)
		return
	end

	-- not same as current guide.
	-- get guide object
	local guide = ZGV:GetGuideByTitle(params)
	if not guide then print("Failed to locate guide:",params) end

	-- check if have new guide already tabbed somewhere, then ask about either opening new tab or switching to existing one
	local tab = Tabs:DoesTabExist(guide.title)

	ZGV:Debug("&_SUB &tabs optiona tab popup for "..guide.title)
	ZGV.NotificationCenter.AddButton(
	"tabguide",
	guide.title_short,
	tab and L["tabs_guide_switch"] or L["tabs_guide_new"],
	ZGV.DIR.."\\Skins\\guideicons-big",
	{0, 0.25, 0, 0.25},
	function() 
		if not tab then tab = Tabs:GetTabFromPool() end

		tab:SetAsCurrent()
		ZGV:SetGuide(guide.title,step) end,
	nil,
	1,
	10, --poptime
	30, --removetime
	false, --quiet
	nil,--onopen
	"tabguide")
end

tinsert(ZGV.startups,{"Guide tabs",function(self)
	ZGV.db.char.tabguides = ZGV.db.char.tabguides or {}
	Tabs:Initialize()
end})