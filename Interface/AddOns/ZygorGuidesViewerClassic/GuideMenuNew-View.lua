local ZGV = ZygorGuidesViewer
if not ZGV then return end

local GuideMenu = ZGV.GuideMenu

local L = ZGV.L
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local CHAIN = ZGV.ChainCall
local ui = ZGV.UI
local SkinData = ui.SkinData

local MAINFRAME_WIDTH=825
local MAINFRAME_HEIGHT=579
local MAINFRAME_HEADER_HEIGHT=40
local MAINFRAME_FOOTER_HEIGHT=24

local HEADER_FONT_SIZE = 16

GuideMenu.BUTTONS_NORMAL_COLOR = {0.7,0.7,0.7,1}
GuideMenu.BUTTONS_HIGHLIGHT_COLOR = {1,1,1,1}

local ICON_SIZE=15

local SCROLLTABLE_DATA = {
	ROW_COUNT = 20,
	LIST_WIDTH = 380,
	LIST_HEIGHT = 478,
	POSX = 1,
	POSY = -34,
	STRATA = "DIALOG",
	BORDER = {0,0,0,0},
	BACKGROUND = {0,0,0,0},
	ROWBACKGROUND = false,
	ROW_HEADER = 1,
	HIDESCROLLBAR = true
}
local SCROLLTABLE_COLUMNS = {
	{ title="", width=ICON_SIZE, headerwidth=15, titlej="LEFT", textj="LEFT", name="icon", type="icon",
		texture=function() return SkinData("GuideIcons") end,
		textureoffset=ICON_FOLDER,
		texturecolor={1,1,1,1},
	},
	{ title="", width=313, titlej="LEFT", textj="LEFT", name="title", padding=5 },
	{ title="", width=14, titlej="RIGHT", textj="RIGHT", name="loadbutton", type="button", iconheight=14, iconwidth=14,padding=0,
		texture=function() return SkinData("TitleButtons") end,
		textureoffset={10/32,0,11/32,0,10/32,1/4,11/32,1/4},
		--highlighttextureoffset={10/32,2/4,11/32,2/4,10/32,3/4,11/32,3/4},
		tooltip="Load guide",
	}
}

GuideMenu.Sections = {
	All={ MenuGuides=true,MenuOptions=true,CenterColumn=true,WideColumn=true,WideColumnHome=true,WideColumnOptions=true,RightColumn=true },
	Home={ MenuGuides=true, WideColumn=true, WideColumnHome=true },
	Recent={ MenuGuides=true,CenterColumn=true,RightColumn=true },
	Suggested={ MenuGuides=true,CenterColumn=true,RightColumn=true },
	Search={ MenuGuides=true,CenterColumn=true,RightColumn=true },
	Options={ MenuOptions=true, WideColumn=true, WideColumnOptions=true },
	Default={MenuGuides=true,CenterColumn=true,RightColumn=true },
}
setmetatable(GuideMenu.Sections,{__index=function(self,name) return GuideMenu.Sections.Default end})

function GuideMenu:Open(path,iscurrent,...)
	if path=="Search" and GuideMenu.MainFrame.MenuGuides.SearchEdit:GetText()=="" then
		path=GuideMenu.PreviousSection
	end

	local target=GuideMenu.Sections[path]
	local MainFrame=GuideMenu.MainFrame

	if path~="Search" then
		GuideMenu.PreviousSection=path
	end
	GuideMenu.CurrentSection=path

	if iscurrent then 
		ZGV.db.profile.gmlastsection="Current"
	elseif path~="Options" and path~="Search" and path~="QuestSearch" then 
		ZGV.db.profile.gmlastsection=path
	end

	-- Clear focus when switching tabs
	GuideMenu.FocusedGuide=nil
	GuideMenu:HideGuideMouseOver()

	-- Handle special cases, where we do something else than just showing the guides
	if path:sub(1,4)=="GOLD" then
		ZGV.Goldguide:Initialise()
		if not iscurrent then
			GuideMenu:Hide()
		end
		return
	end

	-- Show and hide proper frames
	for i,v in pairs(GuideMenu.Sections.All) do
		if target[i] then
			MainFrame[i]:Show()
		else
			MainFrame[i]:Hide()
		end
	end

	-- Highlight proper element in top menu
	for key,v in pairs(MainFrame.Header.Tabs) do
		if path==key or (iscurrent and key=="Current") then
			v:SetFont(FONTBOLD,HEADER_FONT_SIZE)
			v:SetTextColor(1,1,1,1)
		else
			v:SetFont(FONT,HEADER_FONT_SIZE)
			v:SetTextColor(0.7,0.7,0.7,1)
		end
	end

	GuideMenu.CurrentPath=path

	-- Prepare the data
	if path=="Recent" then
		GuideMenu:ShowRecent()
	elseif path=="Suggested" or path=="SUGGESTED" then
		GuideMenu:ShowSuggested()
	elseif path=="Current" then
		GuideMenu:ShowCurrent()
	elseif path=="Home" then
		GuideMenu:ShowHome()
	elseif path=="Options" then
		GuideMenu:ShowOptions(...)
	elseif path=="Search" then
		GuideMenu:Search()
	elseif path=="QuestSearch" then
		GuideMenu:SearchQuest(...)
	else
		GuideMenu:ShowGuides(path,iscurrent)
	end

	GuideMenu:Update()
end

function GuideMenu:SetSectionHeader(text,arrow)
	local section = GuideMenu.MainFrame.CenterColumn.SectionInfo
	section.Name:SetText(text)
	if arrow then
		section.Texture:SetWidth(12)
		section.Texture:SetTexture(ZGV.SkinDir.."titlebuttons")
		section.Name:SetPoint("TOPLEFT",section.Texture,"TOPRIGHT",5,0)
	else
		section.Texture:SetWidth(1)
		section.Texture:SetTexture(nil)
		section.Name:SetPoint("TOPLEFT",section.Texture,"TOPRIGHT",-1,0)
		section:SetScript("OnClick", nil)
	end
end

function GuideMenu:SetWideSectionHeader(text)
	GuideMenu.MainFrame.WideColumn.Name:SetText(text)
end

local function UpdateHandler(self, event)
	if not GuideMenu.MainFrame then return end
	if not GuideMenu.MainFrame:IsVisible() then return end
	if not GuideMenu.needToUpdate then return end
	GuideMenu.needToUpdate=false
	GuideMenu:Update()
end

function GuideMenu:ApplySkin()
	local MF = GuideMenu.MainFrame
	if not MF then return end

	MF:SetBackdropColor(unpack(SkinData("MainBackdropColor")))
	MF:SetBackdropBorderColor(unpack(SkinData("MainBackdropBorderColor")))

	MF:SetWidth(MAINFRAME_WIDTH+SkinData("GuideMenuMargin")*2)
	MF.Header:SetBackdropColor(unpack(SkinData("GuideMenuHeaderFooterBackground")))
	MF.Header:SetBackdropBorderColor(unpack(SkinData("GuideMenuHeaderFooterBorder")))


	for i,v in pairs(MF.Header.Tabs) do
		v:SetBackdropColor(0,0,0,0)
		v:SetBackdropBorderColor(0,0,0,0)
		v:SetNormalBackdropColor(0,0,0,0)
		v:SetHighlightBackdropColor(0,0,0,0)
	end

	MF.MenuColumn:SetPoint("TOPLEFT",MF.Header,"BOTTOMLEFT",SkinData("GuideMenuMargin"),0)
	MF.MenuColumn:SetBackdropColor(unpack(SkinData("GuideMenuMenuBackground")))

	MF.RightColumn:SetPoint("TOPRIGHT",MF.Header,"BOTTOMRIGHT",-SkinData("GuideMenuMargin"),0)
	MF.RightColumn:SetPoint("BOTTOMRIGHT",MF.Footer,"TOPRIGHT",-SkinData("GuideMenuMargin"),0)

 	MF.MenuGuides.SearchEdit:SetBackdropBorderColor(unpack(SkinData("GuideMenuSearchEdit")))

	MF.CenterColumn:SetBackdropColor(unpack(SkinData("GuideMenuContentBackground")))
	MF.WideColumn:SetBackdropColor(unpack(SkinData("GuideMenuContentBackground")))
	MF.RightColumn:SetBackdropColor(unpack(SkinData("GuideMenuDetailsBackground")))

	MF.MenuColumn:SetBackdropBorderColor(unpack(SkinData("GuideMenuSectionBorder")))
	MF.CenterColumn:SetBackdropBorderColor(unpack(SkinData("GuideMenuSectionBorder")))
	MF.WideColumn:SetBackdropBorderColor(unpack(SkinData("GuideMenuSectionBorder")))
	MF.RightColumn:SetBackdropBorderColor(unpack(SkinData("GuideMenuSectionBorder")))

	MF.Footer:SetBackdropColor(unpack(SkinData("GuideMenuHeaderFooterBackground")))
	MF.Footer:SetBackdropBorderColor(unpack(SkinData("GuideMenuHeaderFooterBorder")))

	MF.FooterVersion:SetPoint("BOTTOMLEFT",SkinData("GuideMenuFooterElementsOffset"),7)
	MF.FooterSettingsButton:SetPoint("BOTTOMRIGHT",-SkinData("GuideMenuFooterElementsOffset"),5)

	MF.RightColumn.GuideProgress:SetTexture(SkinData("ProgressBarTextureFile"))
	MF.RightColumn.GuideProgress:SetDecor(SkinData("ProgressBarDecorUse"))
end

function GuideMenu:CreateFrames()
	-- Main Container
	local MF = CHAIN(ui:Create("Frame", UIParent, "ZygorGuidesViewer_GuideMenuNew"))
		:SetSize(MAINFRAME_WIDTH,MAINFRAME_HEIGHT)
		:SetPoint("CENTER",UIParent)
		:SetFrameStrata("DIALOG")
		:CanDrag(true)
		:SetScript("OnUpdate",UpdateHandler)
		:SetScript("OnHide",function() GuideMenu.UseTab=nil end) -- reset tab behaviour to 'add new tab'
		:SetScale(ZGV.CLASSIC_SCALE_ADJUST)
		:Hide()
	.__END
	GuideMenu.MainFrame= MF
	tinsert(UISpecialFrames, "ZygorGuidesViewer_GuideMenuNew") -- allows the frame to be closable with ESC keypress

	-- Top menu
	MF.Header = CHAIN(ui:Create("Frame", MF))
		:SetPoint("TOPLEFT",1,-1)
		:SetPoint("TOPRIGHT",-1,1)
		:SetHeight(MAINFRAME_HEADER_HEIGHT)
		:SetBackdropBorderColor(0,0,0,0)
		.__END

		MF.Header.CloseButton = CHAIN(CreateFrame("Button", nil, MF.Header, nil))
			:SetPoint("TOPRIGHT",MF.Header,"TOPRIGHT",-5,-5) 
			:SetSize(15,15)
			:SetScript("OnClick",function() GuideMenu:Hide() end)
		.__END
		ZGV.F.AssignButtonTexture(MF.Header.CloseButton,ZGV.SkinDir.."titlebuttons",6,32)

		MF.Header.Tabs={}
		local Home = CHAIN(ui:Create("Button",MF.Header))
			:SetSize(70,24)
			:SetPoint("TOPLEFT",MF.Header,"TOPLEFT", 3, -8)
			:SetFont(FONT,HEADER_FONT_SIZE)
			:SetText("Home")
			:SetScript("OnClick", function() GuideMenu:Open("Home") end)
		.__END
		MF.Header.Tabs.Home=Home

		local Current = CHAIN(ui:Create("Button",MF.Header))
			:SetSize(80,24)
			:SetPoint("LEFT",Home,"RIGHT", 30, 0)
			:SetFont(FONT,HEADER_FONT_SIZE)
			:SetText("Current")
			:SetScript("OnClick", function() GuideMenu:Open("Current") end)
		.__END
		MF.Header.Tabs.Current=Current

		local Recent = CHAIN(ui:Create("Button",MF.Header))
			:SetSize(80,24)
			:SetPoint("LEFT",Current,"RIGHT", 30, 0)
			:SetFont(FONT,HEADER_FONT_SIZE)
			:SetText("Recent")
			:SetScript("OnClick", function() GuideMenu:Open("Recent") end)
		.__END
		MF.Header.Tabs.Recent=Recent

		local Suggested = CHAIN(ui:Create("Button",MF.Header))
			:SetSize(80,24)
			:SetPoint("LEFT",Recent,"RIGHT", 30, 0)
			:SetFont(FONT,HEADER_FONT_SIZE)
			:SetText("Suggested")
			:SetScript("OnClick", function() GuideMenu:Open("Suggested") end)
		.__END
		MF.Header.Tabs.Suggested=Suggested

		local Options = CHAIN(ui:Create("Button",MF.Header))
			:SetSize(80,24)
			:SetPoint("LEFT",Suggested,"RIGHT", 30, 0)
			:SetFont(FONT,HEADER_FONT_SIZE)
			:SetText("Options")
			:SetScript("OnClick", function() GuideMenu:Open("Options") end)
		.__END
 		MF.Header.Tabs.Options=Options

		if not ZGV.db.profile.gmshowoptions then Options:Hide() end


	MF.Footer = CHAIN(ui:Create("Frame",MF))
		:SetPoint("TOPLEFT",MF,"BOTTOMLEFT",1,MAINFRAME_FOOTER_HEIGHT+1)
		:SetPoint("TOPRIGHT",MF,"BOTTOMRIGHT",-1,MAINFRAME_FOOTER_HEIGHT+1)
		:SetHeight(MAINFRAME_FOOTER_HEIGHT)
		:SetFrameLevel(MF:GetFrameLevel()+1)
		:SetToplevel(enable)
		.__END
		MF.FooterVersion = CHAIN(MF.Footer:CreateFontString())
			:SetFont(FONTBOLD,12)
			:SetText("VER:")
		.__END

		MF.FooterVersionVal = CHAIN(MF.Footer:CreateFontString())
			:SetPoint("LEFT",MF.FooterVersion ,"RIGHT",5,0)
			:SetFont(FONT,12)
			:SetText(ZGV.version)
		.__END
		
		MF.FooterSettingsButton = CHAIN(CreateFrame("Button",nil,MF.Footer))
			:SetSize(15,15)
			:SetScript("OnClick",function() GuideMenu:Open("Options") end)
		.__END
		ZGV.F.AssignButtonTexture(MF.FooterSettingsButton,(SkinData("TitleButtons")),5,32)

	MF.MenuColumn = CHAIN(ui:Create("Frame", MF))
		:SetPoint("TOPLEFT",MF.Header,"BOTTOMLEFT")
		:SetPoint("BOTTOMLEFT",MF.Footer,"TOPLEFT")
		:SetWidth(222)
		:SetBackdropBorderColor(0,0,0,0)
		.__END

		MF.MenuGuides = CHAIN(CreateFrame("Frame", nil, MF.MenuColumn))
			:SetPoint("TOPLEFT")
			:SetPoint("BOTTOMRIGHT")
			.__END
			MF.MenuGuides.SearchEdit = CHAIN(ui:Create("EditBox",MF.MenuGuides))
				:SetPoint("TOPLEFT",MF.MenuGuides,"TOPLEFT",16,-10)
				:SetWidth(181)
				:SetScript("OnEnterPressed",function() MF.MenuGuides.SearchEdit:ClearFocus() GuideMenu:Open("Search") end)
				:HookScript("OnEscapePressed",function() MF.MenuGuides.SearchEdit:SetText("") GuideMenu:Open("Home") end)
				:SetScript("OnTextChanged",function(edit,user) if user then GuideMenu:Open("Search") end end)
			.__END

			MF.MenuGuides.SearchEdit.SearchGlass = CHAIN(MF.MenuGuides.SearchEdit:CreateTexture())
				:SetPoint("RIGHT",MF.MenuGuides.SearchEdit.back,-3,0):SetSize(12,12)
				:SetTexture(ZGV.DIR.."\\Skins\\search")
			.__END
			
			GuideMenu:PrepareGuidesMenuButtons()

			MF.MenuGuides.Options = GuideMenu:MakeMenuButton("ButtonOptions","Options",SkinData("TitleButtons"),5,32,1,4)
			MF.MenuGuides.Options:SetPoint("BOTTOMLEFT",MF.MenuGuides,"BOTTOMLEFT",12,10)
			MF.MenuGuides.Options:SetScript("OnClick", function() GuideMenu:Open("Options") end)

			MF.MenuGuides.OptionsDecor = CHAIN(MF.MenuGuides:CreateTexture())
				:SetTexture(ZGV.DIR.."\\Skins\\white")
				:SetPoint("BOTTOMLEFT",MF.MenuGuides.Options,"TOPLEFT",-10,10)
				:SetSize(216,1)
				:SetVertexColor(0.3,0.3,0.3,1)
			.__END
			if not ZGV.db.profile.gmshowoptionsleft then MF.MenuGuides.Options:Hide() MF.MenuGuides.OptionsDecor:Hide() end

		MF.MenuOptions = CHAIN(CreateFrame("Frame", "ZGV_Menu_OptionsList", MF.MenuColumn))
			:SetPoint("TOPLEFT")
			:SetPoint("BOTTOMRIGHT")
			:Hide()
			.__END


	MF.CenterColumn = CHAIN(ui:Create("Frame", MF))
		:SetPoint("TOPLEFT",MF.MenuColumn,"TOPRIGHT",-1,0)
		:SetPoint("BOTTOMLEFT",MF.MenuColumn,"BOTTOMRIGHT",-1,0)
		:SetWidth(382)
		:SetBackdropBorderColor(0,0,0,0)
		.__END

		MF.CenterColumn.SectionInfo = CHAIN(CreateFrame("Button",nil))
			:SetHeight(22)
			:SetParent(MF.CenterColumn)
			:SetPoint("TOP")
			:SetPoint("LEFT")
			:SetPoint("RIGHT")
			.__END
			local SectionInfo=MF.CenterColumn.SectionInfo
			SectionInfo.Texture = CHAIN(SectionInfo:CreateTexture(nil,"LOW")) 
				:SetSize(12,12) 
				:SetTexture(ZGV.SkinDir.."titlebuttons")
				:SetTexCoord(8/32,9/32,0,1/4)
				:SetPoint("TOPLEFT",SectionInfo,"TOPLEFT",10,-10)
				.__END

			SectionInfo.Name = CHAIN(SectionInfo:CreateFontString())
				:SetFont(FONT,13)
				:SetJustifyH("LEFT")
				:SetPoint("TOPLEFT",SectionInfo.Texture,"TOPRIGHT",5,2)
				:SetWidth(379)
				:SetWordWrap(false)
				:SetText("No section selected")
				.__END

			SectionInfo.Decor = CHAIN(ui:Create("Frame",SectionInfo,nil))
				:SetPoint("TOPLEFT",SectionInfo,"BOTTOMLEFT",0,-10)
				:SetSize(379,1)
				:SetFrameLevel(SectionInfo:GetFrameLevel()+3)
				:SetBackdropColor(0.3,0.3,0.3,1)
				:SetBackdropBorderColor(0,0,0,0)
			.__END

		MF.GuideListScrollFrame= ui:Create("ScrollTable",MF.CenterColumn,"ZGV_GuideScrollTable",SCROLLTABLE_COLUMNS,SCROLLTABLE_DATA)
		MF.GuideListScrollFrame:SetScript("OnMouseWheel", function(self,delta)
			GuideMenu.GuideListOffset=GuideMenu.GuideListOffset-delta
			GuideMenu.needToUpdate=true
		end)
		MF.GuideListScrollFrame.scrollbar:SetScript("OnVerticalScroll",function(me,offset)
			GuideMenu.GuideListOffset=math.round(offset)
			GuideMenu.needToUpdate=true
		end)

		for _,row in pairs(MF.GuideListScrollFrame.rows) do
			-- adjust elements positions
			row.icon:ClearAllPoints()
			row.icon:SetPoint("BOTTOMLEFT",row,"BOTTOMLEFT",9,4)
			row.title:SetPoint("BOTTOMLEFT",row.icon,"BOTTOMRIGHT",0,1) 
			row.loadbutton:ClearAllPoints()
			row.loadbutton:SetPoint("BOTTOMRIGHT",row,"BOTTOMRIGHT",-5,5)

			-- add mouseover scripts
			row:SetScript("OnEnter",function() GuideMenu:ShowGuideMouseOver(row) GuideMenu.CurrentRow=row end)
			row:SetScript("OnLeave",function() GuideMenu:HideGuideMouseOver(row) GuideMenu.CurrentRow=nil end)
			local button_onenter=row.loadbutton:GetScript("OnEnter")
			local button_onleave=row.loadbutton:GetScript("OnLeave")
			row.loadbutton:SetScript("OnEnter",function(but) row:GetScript("OnEnter")(row) button_onenter(but) end)
			row.loadbutton:SetScript("OnLeave",function(but) row:GetScript("OnLeave")(row) button_onleave(but) end)
			row.loadbutton:SetScript("OnClick",function(but) GuideMenu:ActivateGuide(row.guide) end)

			row:SetHighlightBackdropColor(unpack(SkinData("ButtonHighlightColor1")))

			-- add suggested icon overlay and animation
			row.iconover = CHAIN(row:CreateTexture()) 
				:SetPoint("CENTER",row.icon,"CENTER",3,-3) 
				:SetSize(17,17) 
				:SetDrawLayer("ARTWORK",1)
				:SetTexture(ZGV.DIR.."\\Skins\\Default\\Stealth\\guideicons-small")
				:SetTexCoord(0,1/2,1/2,1)
			 .__END
			row.iconover.anim = CHAIN(row.iconover:CreateAnimationGroup()) 
				:SetLooping("REPEAT") .__END
			CHAIN(row.iconover.anim:CreateAnimation("SCALE")) 
				:SetScale(1.4,1.4) 
				:SetDuration(0.5) 
				:SetSmoothing("OUT")
			CHAIN(row.iconover.anim:CreateAnimation("SCALE")) 
				:SetScale(0.7143,0.7143) 
				:SetDuration(0.5) 
				:SetSmoothing("IN")
		end

	MF.WideColumn = CHAIN(ui:Create("Frame", MF))
		:SetPoint("TOPLEFT",MF.MenuColumn,"TOPRIGHT",-1,0)
		:SetPoint("BOTTOMLEFT",MF.MenuColumn,"BOTTOMRIGHT",-1,0)
		:SetWidth(602)
		:SetBackdropBorderColor(0,0,0,0)
		:Hide()
		.__END

		MF.WideColumn.Name = CHAIN(MF.WideColumn:CreateFontString())
			:SetFont(FONT,13)
			:SetJustifyH("LEFT")
			:SetPoint("TOPLEFT",MF.WideColumn,"TOPLEFT",10,-9)
			:SetWidth(600)
			:SetWordWrap(false)
			:SetText("No section selected")
			.__END

		MF.WideColumn.Decor = CHAIN(ui:Create("Frame",MF.WideColumn,nil))
			:SetPoint("TOPLEFT",MF.WideColumn.Name,"BOTTOMLEFT",-10,-10)
			:SetSize(600,1)
			:SetFrameLevel(MF.WideColumn:GetFrameLevel()+3)
			:SetBackdropColor(0.3,0.3,0.3,1)
			:SetBackdropBorderColor(0,0,0,0)
		.__END

		MF.WideColumnHomeInner = CHAIN(CreateFrame("Frame", "Home_Content", MF.WideColumn))
			:SetPoint("TOPLEFT")
			:SetPoint("BOTTOMRIGHT")
			:SetWidth(600)
			:SetHeight(100)
		.__END

		MF.WideColumnHome = CHAIN(ui:Create("ScrollChild",MF.WideColumn,"Home_Scroller",MF.WideColumnHomeInner))
			:SetPoint("TOPLEFT",MF.WideColumn.Decor,"BOTTOMLEFT")
			:SetPoint("BOTTOMRIGHT",-16,1)
			:Hide()
			.__END
		MF.WideColumnHome:SetHideWhenUseless(true)

		MF.WideColumnOptions = CHAIN(CreateFrame("Frame", "ZGV_Menu_OptionsDetails", MF.WideColumn))
			:SetPoint("TOPLEFT",MF.WideColumn.Decor,"BOTTOMLEFT")
			:SetPoint("BOTTOMRIGHT")
			:Hide()
			.__END

		MF.WideColumnOptions.AceContainer = LibStub("AceGUI-3.0-Z"):Create("ScrollFrame-Z")
		MF.WideColumnOptions.AceContainer.type="SimpleGroup-Z"  -- I hate myself. AceConfigDialog would make a new ScrollFrame inside our perfectly good ScrollFrame, breaking it to hell, because it's not a *Group. So... this ScrollFrame has to masquerade as a SimpleGroup.
		MF.WideColumnOptions.AceContainer.frame:SetParent(MF.WideColumnOptions)
		MF.WideColumnOptions.AceContainer.frame:SetPoint("TOPLEFT",MF.WideColumnOptions,"TOPLEFT",10,0)
		MF.WideColumnOptions.AceContainer.frame:SetPoint("BOTTOMRIGHT")


	MF.RightColumn = CHAIN(ui:Create("Frame", MF))
		:SetPoint("TOPRIGHT",MF.Header,"BOTTOMRIGHT")
		:SetPoint("BOTTOMRIGHT",MF.Footer,"TOPRIGHT")
		:SetWidth(221)
		:SetBackdropBorderColor(0,0,0,0)
		.__END


		MF.RightColumn.GuideImage = CHAIN(MF.RightColumn:CreateTexture(nil,"LOW")) 
			:SetHeight(139) 
			:SetPoint("TOP",0,-1) 
			:SetPoint("LEFT",1,0) 
			:SetPoint("RIGHT",-1,0) 
			:SetTexture(ZGV.DIR.."\\Skins\\menu_noguide")
			:SetTexCoord(0,220/256,0,139/256)
		.__END

		MF.RightColumn.GuideMascot = CHAIN(MF.RightColumn:CreateTexture(nil,"LOW")) 
			:SetHeight(289) 
			:SetPoint("BOTTOM",0,1) 
			:SetPoint("LEFT",1,0) 
			:SetPoint("RIGHT",-1,0) 
			:SetTexture(ZGV.DIR.."\\Skins\\menu_mascot")
			:SetTexCoord(0,220/256,0,289/512)
		.__END

		MF.RightColumn.GuideModel = CHAIN(CreateFrame("PlayerModel",nil,MF.RightColumn,"ZygorGuidesViewerPlayerModel"))
			:SetHeight(139) 
			:SetPoint("TOP") 
			:SetPoint("LEFT",0,0) 
			:SetPoint("RIGHT",-1,0) 
			:SetAutoRotation(0.4)
		.__END

		MF.RightColumn.GuideTitle = CHAIN(MF.RightColumn:CreateFontString())
			:SetPoint("TOPLEFT",MF.RightColumn.GuideImage,"BOTTOMLEFT",5,-10)
			:SetFont(FONTBOLD,12)
			:SetText()
			:SetWidth(210)
			:SetJustifyH("left")
			:Hide()
		.__END

		MF.RightColumn.GuideDesc = CHAIN(MF.RightColumn:CreateFontString())
			:SetPoint("TOPLEFT",MF.RightColumn.GuideTitle,"BOTTOMLEFT",0,-10)
			:SetFont(FONT,12)
			:SetText()
			:SetWidth(210)
			:SetJustifyH("left")
			:Hide()
		.__END

		MF.RightColumn.GuideProgressLabel = CHAIN(MF.RightColumn:CreateFontString())
			:SetPoint("TOPLEFT",MF.RightColumn.GuideDesc,"BOTTOMLEFT",0,-10)
			:SetFont(FONT,12)
			:SetText("Progress:")
			:SetWidth(210)
			:SetJustifyH("left")
			:Hide()
		.__END
		MF.RightColumn.GuideProgress = CHAIN(ui:Create("ProgressBar",MF.RightColumn))
			:SetSize(210,7)
			:SetFrameLevel(MF.RightColumn:GetFrameLevel()+3)
			:SetPoint("TOPLEFT",MF.RightColumn.GuideProgressLabel,"BOTTOMLEFT",0,-12)
			:SetDecor(SkinData("ProgressBarDecorUse"))
			:SetAnim(false)
			:Hide()
		.__END
end

local function MenuButton_SetHighlight(button,tf,force)
	if not force and button.isHighlightLocked then return end
	button.caption:SetTextColor(unpack(tf and button.caption.HighlightTextColor or button.caption.NormalTextColor))
	ZGV.F.SetSpriteTexCoord(button.texture,unpack(tf and button.spritecoords_hilite or button.spritecoords))
end

local function MenuButton_SetHighlightSprite(button,x,w,y,h)
	button.spritecoords_hilite = {x,w,y,h}
end

local function MenuButton_SetLockHighlight(button,tf)
	button:SetHighlight(tf,true)
	button.isHighlightLocked = tf
end

local function MenuButton_SetNormalTextColor(button,r,g,b,a)
	button.caption.NormalTextColor={r,g,b,a}
	button.caption:SetTextColor(r,g,b,a)
end

local function MenuButton_SetHighlightTextColor(button,r,g,b,a)
	button.caption.HighlightTextColor={r,g,b,a}
end

function GuideMenu:MakeMenuButton(name,caption,texture,x,w,y,h)
	local parent = GuideMenu.MainFrame.MenuGuides
	local but = CHAIN(CreateFrame("Button"))
		:SetSize(200,18)
		:SetFrameLevel(4)
		:SetParent(parent)
	.__END
	
	if texture then
		but.texture = CHAIN(but:CreateTexture(nil,"LOW")) 
			:SetSize(16,16) 
			:SetPoint("TOPLEFT",but) 
			:SetTexture(texture)
		.__END

		but.spritecoords={x,w,y,h}
		ZGV.F.SetSpriteTexCoord(but.texture,x,w,y,h)
	end
	
	but.caption = CHAIN(but:CreateFontString(name.."_c","LOW")) 
		:SetPoint("LEFT",but.texture,"RIGHT",7,0) 
		:SetFont(FONT,14) 
		:SetText(caption)
	.__END

	but.SetHighlight = MenuButton_SetHighlight
	but.SetHighlightSprite = MenuButton_SetHighlightSprite
	but.SetLockHighlight = MenuButton_SetLockHighlight
	but.SetNormalTextColor = MenuButton_SetNormalTextColor
	but.SetHighlightTextColor = MenuButton_SetHighlightTextColor

	but:SetNormalTextColor(unpack(GuideMenu.BUTTONS_NORMAL_COLOR))
	but:SetHighlightTextColor(unpack(GuideMenu.BUTTONS_HIGHLIGHT_COLOR))
	
	but:SetScript("OnEnter",function(but) but:SetHighlight(true) end)
	but:SetScript("OnLeave",function(but) but:SetHighlight(false) end)

	return but
end

function GuideMenu:PrepareGuidesMenuButtons()
	GuideMenu.MainFrame.MenuColumn.GuideButtons = GuideMenu.MainFrame.MenuColumn.GuideButtons or {}
	local buttons = GuideMenu.MainFrame.MenuColumn.GuideButtons
	local previous = nil

	for i,group in pairs(ZGV.registered_groups.groups) do
		if group and not (group.name == "SUGGESTED" or (group.name=="TEST" and not ZGV.db.profile.debug_display)) then
			local x,y,label = unpack(GuideMenu.GUIDE_DISPLAY[group.name])
			buttons[group.name] = buttons[group.name] or GuideMenu:MakeMenuButton("Button"..group.name,label,ZGV.DIR.."\\Skins\\guideicons-big",x,4,y,4)
			if previous then
				buttons[group.name]:SetPoint("TOPLEFT",previous,"BOTTOMLEFT",0,-12)
			else
				buttons[group.name]:SetPoint("TOPLEFT",GuideMenu.MainFrame.MenuGuides.SearchEdit,"BOTTOMLEFT",-4,-10)
			end
			previous=buttons[group.name]

			buttons[group.name]:SetScript("OnClick",function() GuideMenu:Open(group.fullpath) end)
		end
	end
end

function ZGV:ZGV_LOADING_TOPLEVEL_GROUPS_UPDATED()
	if GuideMenu and GuideMenu.MainFrame then
		GuideMenu:PrepareGuidesMenuButtons()
	end
end

local firstpages = {['1_home']="Home",['2_current']="Current",['3_recent']="Recent",['4_suggested']="Suggested"}
function GuideMenu:Show(path,...)
	if not GuideMenu.MainFrame then
		GuideMenu:CreateFrames()
		GuideMenu:ApplySkin()
	end
	ZGV.LOADGUIDES_INTENSITY=100
	ZGV:AddMessageHandler("ZGV_GUIDES_PARSED",function() GuideMenu:Update() end)


	GuideMenu.GuideListOffset=0
	GuideMenu.MainFrame:DoFadeIn()

	if path~="Options" and path~="QuestSearch" then
		if ZGV.db.profile.gmlasthomeversion~=GuideMenu.HomeVersion then path="Home" end
		ZGV.db.profile.gmlasthomeversion = GuideMenu.HomeVersion
	end

	if not path then
		if ZGV.db.profile.gmfirstpage=="5_last" then
			path = ZGV.db.profile.gmlastsection
		else
			path = firstpages[ZGV.db.profile.gmfirstpage]
		end
	end

	GuideMenu:Open(path or "Home",nil,...)
end

function GuideMenu:Hide()
	GuideMenu.MainFrame:DoFadeOut()
	for i,v in pairs(ZGV.registeredguides) do
		if v~=ZGV.CurrentGuide and v.fully_parsed and not v.poi then
			v:Unload()
		end
	end
end

function GuideMenu:CreateHome()
	local parent=GuideMenu.MainFrame.WideColumnHomeInner

	local function make_banner(e)
		local object = CHAIN(parent:CreateTexture())
			:SetTexture(e.image)
			:SetSize(e.width or 552,e.height or 109)
			:SetVertexColor(1,1,1,1)
		.__END
		if e.top then object:SetTexCoord(e.top, e.bottom, e.left, e.right) end
		return object,height or 109
	end

	local function make_title(e)
		local object = CHAIN(parent:CreateFontString())
			:SetFont(FONT,14)
			:SetWidth(552)
			:SetJustifyH("LEFT")
			:SetText(e.text)
		.__END
		return object,object:GetStringHeight()
	end

	local function make_section(e)
		local object = CHAIN(parent:CreateFontString())
			:SetFont(FONTBOLD,12)
			:SetWidth(552)
			:SetJustifyH("LEFT")
			:SetText(e.text)
		.__END
		return object,object:GetStringHeight()
	end

	local function make_item(e)
		local object = CHAIN(ui:Create("Button",parent))
			:SetHeight(24)
			:SetWidth(552)
			:SetNormalBackdropColor(0,0,0,0)
			:SetBackdropBorderColor(0,0,0,0)
			:RegisterForClicks("AnyUp")
			:SetScript("OnEnter",nil)
			:SetScript("OnLeave",nil)
		.__END
		object.texture = CHAIN(object:CreateTexture())
			:SetTexture(ZGV.DIR.."\\Skins\\white")
			:SetSize(8,8)
			:SetVertexColor(ZGV.F.HTMLColor("#fe6100ff"))
			:SetPoint("TOPLEFT",0,-4)
		.__END
		object.text = CHAIN(object:CreateFontString())
			:SetFont(FONT,12)
			:SetWidth(552)
			:SetPoint("TOPLEFT",15,-4)
			:SetText(e.text)
			:SetJustifyH("LEFT")
		.__END
		if e.guide then
			if e.action=="select" then
				object:SetScript("OnClick", function() 
					local folder,_ = e.guide:match("^(.+)\\(.-)$")
					GuideMenu:Open(folder)
					GuideMenu.FocusedGuide = ZGV:GetGuideByTitle(e.guide)
					GuideMenu:ShowGuideDetails(GuideMenu.FocusedGuide)
					GuideMenu:Update()
				end)
			else
				object:SetScript("OnClick", function() 
					GuideMenu:ActivateGuide(ZGV:GetGuideByTitle(e.guide))
				end)
			end
		elseif e.folder then
			object:SetScript("OnClick", function() GuideMenu:Open(e.folder) end)
		end
		local text_height = object.text:GetStringHeight()+8
		object:SetHeight(text_height)
		return object,text_height
	end

	local function make_separator(e)
		object = CHAIN(parent:CreateTexture())
			:SetTexture(ZGV.DIR.."\\Skins\\white")
			:SetSize(552,1)
			:SetVertexColor(ZGV.F.HTMLColor("#363636ff"))
		.__END
		return object,1
	end

	local height=0
	local prev=nil
	local faction=UnitFactionGroup("player"):sub(1,1)

	GuideMenu.Elements={}
	for i,e in pairs(GuideMenu.Home) do
		if (not e.faction or (e.faction==faction)) and (not e.beta or ZGV.BETA) then
			local object, e_height, space
			if e[1]=="banner" then 
				object,e_height=make_banner(e)
				space=18
				GuideMenu.Elements[i]=object
			elseif e[1]=="title" then
				object,e_height=make_title(e)
				space=24
				GuideMenu.Elements[i]=object
			elseif e[1]=="section" then
				object,e_height=make_section(e)
				space=14
				GuideMenu.Elements[i]=object
			elseif e[1]=="item" then
				object,e_height=make_item(e)
				space=3
				GuideMenu.Elements[i]=object
			elseif e[1]=="separator" then
				object,e_height=make_separator(e)
				space=15
				GuideMenu.Elements[i]=object
			else
				print("Unknown element at",i)
				return false
			end

			if prev then
				object:SetPoint("TOPLEFT",prev,"BOTTOMLEFT",0,-space)
				height=height+e_height+space
			else
				object:SetPoint("TOPLEFT",parent,"TOPLEFT",12,-7)
				height=height+e_height+7
			end
			prev=object
		end
	end

	GuideMenu.MainFrame.WideColumnHomeInner:SetHeight(height)
	GuideMenu.MainFrame.WideColumnHome:TotalValue(height)
	GuideMenu.MainFrame.WideColumnHome:SetValue(0)
	GuideMenu.MainFrame.WideColumnHome:SetVerticalScroll(0)

	GuideMenu.HomeReady=true
end

local function OptionButton_OnClick(button)
	GuideMenu.current_option = button.optiongroupblizname
	GuideMenu.MainFrame.WideColumnOptions.AceContainer.optiontable = button.optiontable
	GuideMenu.MainFrame.WideColumnOptions.AceContainer.groupname = button.optiongroupblizname
	GuideMenu.MainFrame.WideColumn.Name:SetText(button.optiontable.name)
	LibStub("AceConfigDialog-3.0-Z"):Open(button.optiongroupblizname,GuideMenu.MainFrame.WideColumnOptions.AceContainer)
	GuideMenu:HighlightOptionButton(button.optiongroupblizname)
end

function GuideMenu:ShowOptions(opt)
	opt = opt or "ZygorGuidesViewer"
	self:ShowOptionButtons()
	for i,but in pairs(self.MainFrame.MenuOptions.buttons) do  if but.optiongroupblizname==opt or but.optiongroupname==opt then OptionButton_OnClick(but) return end end
end

local option_icons = { "main","menu","display","navi","poi","notification","gear","itemscore","gold","enhancements","profile","about","share","-","zta" }
local option_icons_rev = {}
for k,v in ipairs(option_icons) do option_icons_rev[v]=k end

function GuideMenu:ShowOptionButtons()
	GuideMenu.MainFrame.MenuOptions.buttons = GuideMenu.MainFrame.MenuOptions.buttons or {}
	local previous_button
	for i,opttableord in ipairs(ZGV.optiontables_ordered) do  repeat
		local opttable = ZGV.optiontables[opttableord.name]
		if opttable.guiHidden then break end --continue
		if not GuideMenu.MainFrame.MenuOptions.buttons[i] then
			local button = GuideMenu:MakeMenuButton("ButtonOptions_"..opttableord.name,opttable.name,ZGV.DIR.."\\Skins\\options-menu-icons",2,2,option_icons_rev[opttableord.name] or 16,16)
			--button:SetHighlightSprite(1,2,i,16)
			button:SetParent(GuideMenu.MainFrame.MenuOptions)
			if previous_button then
				button:SetPoint("TOPLEFT",previous_button,"BOTTOMLEFT",0,-12)
			else
				button:SetPoint("TOPLEFT",GuideMenu.MainFrame.MenuOptions,"TOPLEFT",12,-10)
			end
			button.optiongroupblizname = opttableord.blizname
			button.optiongroupname = opttableord.name
			button.optiontable = opttable
			button:SetScript("OnClick",OptionButton_OnClick)
			button:Show()
			previous_button = button
			GuideMenu.MainFrame.MenuOptions.buttons[i] = button
		end
	until true  end
	GuideMenu.MainFrame.MenuOptions:Show()
end

function GuideMenu:CreateOptions()
end

function GuideMenu:HighlightOptionButton(blizname)
	for i,button in ipairs(self.MainFrame.MenuOptions.buttons) do  button:SetLockHighlight(button.optiongroupblizname==blizname)  end
end

function GuideMenu:RefreshOptions(blizname)
	blizname = blizname or self.current_option
	if self.MainFrame and self.MainFrame.MenuOptions:IsVisible() and self.current_option == blizname then ZGV:OpenOptions(blizname) end
end