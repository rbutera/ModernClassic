local ZGV = ZygorGuidesViewer
if not ZGV then return end

local Skin = ZGV:AddSkin("default","Default")
local midnight=Skin:AddStyle("midnight","Midnight")
local stealth=Skin:AddStyle("stealth","Stealth")
local glass=Skin:AddStyle("glass","Glass")
-- The default (as of now) midnight skin
Skin.defaultstyle=midnight
-- NOTE: this is not just the default - it's also the fallback for SkinData calls. So, "stealth inherits midnight". Do not change.
Skin.preferredstyle=stealth

local CHAIN=ZGV.ChainCall

-- Skin-specific functions now
function Skin:CreateFrame()
	if not self.frame then
		self.frame = CreateFrame("FRAME","ZygorGuidesViewerFrame",ZygorGuidesViewerFrameMaster,"ZygorGuidesViewerFrame_template_default")
		self.frame.skin = self
		self.frame.style = self.id

		self.frame.UpdateSkin = self.UpdateSkin
		self.frame.UpdateLocking = self.UpdateLocking
		self.frame.AlignFrame = self.AlignFrame
	end

	assert(self.frame,"Skin "..self.name.." cannot create its frame!")

	ZGV.Frame = self.frame
	ZGV.Frame.stepframes = ZGV.stepframes  -- convenience

	--ZGV.Frame:Hide()

	self.frame:UpdateSkin()

	self.frame:EnableKeyboard(true)

	return self.frame
end

local FONT = ZGV.Font

local function set_alpha(new_a,r,g,b,a)
	return r,g,b,new_a*a
end

function Skin:UpdateSkin()
	local SKINDIR = ZGV.SkinDir
	local function SkinData(property)
		return ZGV.CurrentSkinStyle:SkinData(property)
	end

	local TransparencyPrimary = ZGV.db.profile.opacitytoggle and SkinData("TransparencyPrimary") or 1
	local TransparencySecondary = ZGV.db.profile.opacitytoggle and SkinData("TransparencySecondary") or 1

	local Frame = self

	-- Setting up border
	self.Border:SetBackdrop(SkinData("Backdrop"))
	self.Border:SetBackdropColor(set_alpha(TransparencyPrimary,unpack(SkinData("BackdropColor"))))
	self.Border:SetBackdropBorderColor(set_alpha(TransparencyPrimary,unpack(SkinData("BackdropBorderColor"))))

	self.Border.Guides:SetBackdrop(SkinData("Backdrop"))
	self.Border.Guides:SetBackdropColor(unpack(SkinData("SecBackdropColor")))
	self.Border.Guides:SetBackdropBorderColor(0,0,0,1)

	self.Border.TitleBar.Logo:SetTexture(SkinData("TitleLogo"))

	-- Applying button textures
	local count=32
	local BUTTONTEXTURE = SkinData("TitleButtons")
	local AssignButtonTexture = ZGV.F.AssignButtonTexture
	AssignButtonTexture(ZygorGuidesViewerFrame_CloseButton,BUTTONTEXTURE,6,count)
	AssignButtonTexture(ZygorGuidesViewerFrame_LockButton,BUTTONTEXTURE,4,count)
	--AssignButtonTexture(ZygorGuidesViewerFrame_HelpButton,BUTTONTEXTURE,1,count)
	AssignButtonTexture(ZygorGuidesViewerFrame_ReportButton,BUTTONTEXTURE,15,count)
	ZygorGuidesViewerFrame_ReportButton:GetNormalTexture():SetVertexColor(1,0,0)
	AssignButtonTexture(ZygorGuidesViewerFrame_SettingsButton,BUTTONTEXTURE,5,count)
	AssignButtonTexture(ZygorGuidesViewerFrame_Border_Guides_PrevButton,BUTTONTEXTURE,9,count)
	AssignButtonTexture(ZygorGuidesViewerFrame_Border_Guides_NextButton,BUTTONTEXTURE,10,count)
	AssignButtonTexture(ZygorGuidesViewerFrame_Border_Guides_MiniButton,BUTTONTEXTURE,21,count)

	AssignButtonTexture(ZygorGuidesViewerFrame_Border_Guides_QuestCleanupButton,BUTTONTEXTURE,12,count)
	AssignButtonTexture(ZygorGuidesViewerFrame_ScrollScrollBarScrollUpButton,BUTTONTEXTURE,7,count)
	AssignButtonTexture(ZygorGuidesViewerFrame_ScrollScrollBarScrollDownButton,BUTTONTEXTURE,8,count)
	local size = SkinData("TitleButtonSize")
	ZygorGuidesViewerFrame_SettingsButton:SetSize(size,size)
	--ZygorGuidesViewerFrame_HelpButton:SetSize(size,size)
	ZygorGuidesViewerFrame_ReportButton:SetSize(size,size)
	ZygorGuidesViewerFrame_LockButton:SetSize(size,size)
	ZygorGuidesViewerFrame_CloseButton:SetSize(size,size)
	ZygorGuidesViewerFrame_Border_Guides_MiniButton:SetSize(size,size)
	ZygorGuidesViewerFrame_Border_Guides_QuestCleanupButton:SetSize(size,size)
	ZygorGuidesViewerFrame_Border_Guides_PrevButton:SetSize(SkinData("TitleButtonStepPrevNextSize") or size,SkinData("TitleButtonStepPrevNextSize") or size)
	ZygorGuidesViewerFrame_Border_Guides_NextButton:SetSize(SkinData("TitleButtonStepPrevNextSize") or size,SkinData("TitleButtonStepPrevNextSize") or size)
	ZygorGuidesViewerFrame_Border_Guides_StepNum_Step:SetFont(FONT,SkinData("StepNumFontSize"))
	ZygorGuidesViewerFrame_Border_Guides_StepNum:SetWidth(SkinData("StepNumWidth"))

	AssignButtonTexture(ZygorGuidesViewerFrame_Border_Guides_GuideShareButton,BUTTONTEXTURE,24,count)
	ZygorGuidesViewerFrame_Border_Guides_GuideShareButton:SetSize(size,size)
	ZGV.Sync:UpdateButtonColor()

	AssignButtonTexture(ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial,BUTTONTEXTURE,27,count)
	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:SetSize(SkinData("TitleButtonStepPrevNextSize") or size,SkinData("TitleButtonStepPrevNextSize") or size)
	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:GetNormalTexture():SetVertexColor(1,1,1,1)
	ZygorGuidesViewerFrame_Border_Guides_NextButtonSpecial:Hide()

	if not ZygorGuidesViewerFrame_Border.TabBack then
		ZygorGuidesViewerFrame_Border.TabBack = CreateFrame("FRAME","ZygorGuidesViewerFrame_Border_TabBack",ZygorGuidesViewerFrame_Border)
	end
	CHAIN(ZygorGuidesViewerFrame_Border.TabBack)
		:SetBackdrop(SkinData("TabBackdrop"))
		.__END :GetRegions():SetColorTexture(unpack(SkinData("TabBackdropColor")))

	ZygorGuidesViewerFrame_ScrollScrollBarScrollUpButton:SetSize(unpack(SkinData("ScrollBarButtonSize"))) -- they're 18x16 by default now, the silly things.
	ZygorGuidesViewerFrame_ScrollScrollBarScrollDownButton:SetSize(unpack(SkinData("ScrollBarButtonSize")))


	ZGV.F.SetNPHtx(ZygorGuidesViewerMapIcon,ZGV.DIR.."\\Skins\\zglogo")
	ZygorGuidesViewerMapIcon.back:SetTexture(ZGV.DIR.."\\Skins\\zglogo-back")


	ZygorGuidesViewerFrame_ScrollScrollBarThumbTexture:SetTexture(SKINDIR.."scrollbutton")

	-- Setting the backdrops for guide steps, copied over from ViewerFrame.lua so may look weird. TODO prettyify it
	for i=1,20 do
		local function obj(name) return _G['ZygorGuidesViewerFrame_Step'..i..(name and '_'..name or '')] end
		local step=_G['ZygorGuidesViewerFrame_Step'..i]

		-- The step itself
		step:SetBackdrop(SkinData("StepBackdrop"))
		step:SetBackdropColor(set_alpha(TransparencySecondary,unpack(SkinData("StepBackdropColor"))))
		step:SetBackdropBorderColor(set_alpha(TransparencySecondary,unpack(SkinData("StepBackdropBorderColor"))))
		step.border:SetBackdrop(SkinData("StepBorderBackdrop"))

		-- Lines/goals
		for i=1,30,1 do
			local line = obj("Line"..i)
			local back = line.back
			local clicker = line.clicker
			clicker:SetBackdrop(SkinData("StepLineClickerBackdrop"))
			back:SetBackdrop(SkinData("StepLineBackBackdrop"))
			back:SetBackdropColor(set_alpha(TransparencySecondary,unpack(SkinData("StepLineBackBackdropColor"))))
			back:SetBackdropBorderColor(set_alpha(TransparencySecondary,unpack(SkinData("StepLineBackBackdropBorderColor"))))
			line.icon:SetTexture(SkinData("StepLineIcons"))
			line.icon:SetSize(SkinData("StepLineIconSize"),SkinData("StepLineIconSize"))
		end
	end

	ZGV.ProgressBar:SetDecor(SkinData("ProgressBarDecorUse"))
	ZGV.ProgressBar:SetTexture(SkinData("ProgressBarTextureFile"))

	ZygorGuidesViewerFrame_Border_TitleBar_Logo:SetSize(unpack(SkinData("TitleLogoSize")))
	ZygorGuidesViewerFrame_Border_TitleBar_Logo:SetPoint("CENTER",ZygorGuidesViewerFrame_Border_TitleBar,"CENTER",0,-2)

	ZGV.NotificationCenter:UpdateSkin()

	self:UpdateLocking()
	self:AlignFrame()

	ZGV:UpdateFrame()

	ZGV.GuideMenu:ApplySkin()
	--ZGV.Gold.Appraiser:ApplySkin()
	--ZGV.Goldguide:ApplySkin()
	ZGV.Tabs:ApplySkin()
	ZGV.ActionBar:ApplySkin()
end

function Skin:UpdateLocking()
	-- remove mouse activity in lock mode
	local locked = ZGV.db.profile["windowlocked"]
	--self:Debug("lock mode: "..tostring(locked))

	--ZygorGuidesViewerFrame_Border_TitleBar:EnableMouse(not locked)
	ZygorGuidesViewerFrame_ResizerLeft:EnableMouse(not locked)
	ZygorGuidesViewerFrame_ResizerRight:EnableMouse(not locked)
	ZygorGuidesViewerFrame_ResizerBottomLeft:EnableMouse(not locked)
	ZygorGuidesViewerFrame_ResizerBottomRight:EnableMouse(not locked)
	ZygorGuidesViewerFrame_ResizerBottom:EnableMouse(not locked)

	ZygorGuidesViewerFrame_Scroll:EnableMouseWheel(not locked)

	local BUTTONTEXTURE = ZGV.CurrentSkinStyle:SkinData("TitleButtons")
	-- lock button
	local lockbut = ZygorGuidesViewerFrame_LockButton
	if ZGV.db.profile["windowlocked"] then
		ZGV.F.AssignButtonTexture(ZygorGuidesViewerFrame_LockButton,BUTTONTEXTURE,4,32)
	else
		ZGV.F.AssignButtonTexture(ZygorGuidesViewerFrame_LockButton,BUTTONTEXTURE,3,32)
	end
	if ZGV.db.profile.debug_newicons then
		ZygorGuidesViewerFrame_LockButton:GetNormalTexture():SetTexture(ZGV.DIR.."/skins/thinicon-test-lock-double",nil,nil,"BILINEAR")
		ZygorGuidesViewerFrame_LockButton:GetNormalTexture():SetTexCoord(0,0.25,0,0.5)
	end
end

function Skin:AlignFrame()
	local frame=self
	local framemaster = self:GetParent()
	local scale = ZGV.db.profile.framescale
	local width = frame:GetWidth()
	local height = frame:GetHeight()

	local upsideup = not ZGV.db.profile.resizeup

	local UP_TOPLEFT = upsideup and "TOPLEFT" or "BOTTOMLEFT"
	local UP_BOTTOMLEFT = upsideup and "BOTTOMLEFT" or "TOPLEFT"
	local UP_BOTTOM = upsideup and "BOTTOM" or "TOP"
	local UP_TOPRIGHT = upsideup and "TOPRIGHT" or "BOTTOMRIGHT"
	local UP_BOTTOMRIGHT = upsideup and "BOTTOMRIGHT" or "TOPRIGHT"
	local UP = upsideup and 1 or -1

	CHAIN(frame.Border.TitleBar)
		:ClearAllPoints()
		:SetPoint(UP_TOPLEFT,frame.Border,UP_TOPLEFT,0,0)
		:SetPoint(UP_TOPRIGHT,frame.Border,UP_TOPRIGHT,0,0)

	local tabadj =  ZGV.CurrentSkinStyle:SkinData("TabsHeight")

	frame.Border.Guides:ClearAllPoints()
	ZygorGuidesViewerFrame_Scroll:ClearAllPoints()

	if upsideup then
		CHAIN(ZygorGuidesViewerFrame_Scroll)
			:ClearAllPoints()
			:SetPoint("TOPLEFT",ZGV.Frame.Border,"TOPLEFT",10,-57-tabadj)
			:SetPoint("BOTTOMRIGHT",ZGV.Frame.Border,"BOTTOMRIGHT",-10,8-tabadj)
		CHAIN(frame.Border.Guides)
			:ClearAllPoints()
			:SetPoint("BOTTOMLEFT",ZygorGuidesViewerFrame_ScrollChild,"TOPLEFT",0,-1)
			:SetPoint("BOTTOMRIGHT",ZygorGuidesViewerFrame_ScrollChild,"TOPRIGHT",0,-1)
		CHAIN(ZGV.ProgressBar)
			:SetPoint("TOPLEFT", ZygorGuidesViewerFrame_Scroll,"BOTTOMLEFT",0,25)
			:SetPoint("TOPRIGHT", ZygorGuidesViewerFrame_ScrollChild , "BOTTOMRIGHT",0,25)
		framemaster:SetClampRectInsets(0,(width-40)*scale,(-43)*scale,(-height+55)*scale)
	else
		CHAIN(ZygorGuidesViewerFrame_Scroll)
			:ClearAllPoints()
			:SetPoint("TOPLEFT",ZGV.Frame.Border,"TOPLEFT",10,-10)
			ZygorGuidesViewerFrame_Scroll:SetPoint("BOTTOMRIGHT",ZGV.Frame.Border.Guides,"TOPRIGHT",0,8)
		CHAIN(frame.Border.Guides)
			:ClearAllPoints()
			:SetPoint("BOTTOMLEFT",ZGV.Frame.Border.TitleBar,"TOPLEFT",10,0)
			:SetPoint("BOTTOMRIGHT",ZGV.Frame.Border.TitleBar,"TOPRIGHT",-10,0)
		CHAIN(ZGV.ProgressBar)
			:SetPoint("TOPLEFT", ZygorGuidesViewerFrame_Scroll,"BOTTOMLEFT",0,35)
			:SetPoint("TOPRIGHT", ZygorGuidesViewerFrame_ScrollChild , "BOTTOMRIGHT",0,35)
		framemaster:SetClampRectInsets(0,(width-40)*scale,-height*scale,(42)*scale)
	end

	
	ZygorGuidesViewerFrame_Border_Guides:Show()
	ZygorGuidesViewerFrame_Border:Show()

	ZygorGuidesViewerFrame_Border.TabBack:ClearAllPoints()
	ZygorGuidesViewerFrame_Border.TabBack:SetPoint(UP_TOPLEFT,ZygorGuidesViewerFrame_Border,UP_TOPLEFT,2,-27*UP)
	ZygorGuidesViewerFrame_Border.TabBack:SetPoint(UP_BOTTOMRIGHT,ZygorGuidesViewerFrame_Border,UP_TOPRIGHT,-2,(-29)*UP)


	-- first line according to up/down orientation, the rest follows

	-- resizers
	CHAIN(ZygorGuidesViewerFrame_ResizerBottom) :ClearAllPoints() :SetPoint(UP_BOTTOMLEFT,10,0) :SetPoint(UP_TOPRIGHT,frame,UP_BOTTOMRIGHT,-10,10*UP)
	CHAIN(ZygorGuidesViewerFrame_ResizerBottomLeft) :ClearAllPoints() :SetPoint(UP_BOTTOMLEFT,0,0)
	CHAIN(ZygorGuidesViewerFrame_ResizerBottomRight) :ClearAllPoints() :SetPoint(UP_BOTTOMRIGHT,0,0)

	ZGV:ResizeFrame()
end