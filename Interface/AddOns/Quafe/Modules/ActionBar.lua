local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

----------------------------------------------------------------
--> API and Variable
----------------------------------------------------------------

local min = math.min
local max = math.max
local format = string.format
local floor = math.floor
local sqrt = math.sqrt
local sin = math.sin
local asin = math.asin
local cos = math.cos
local acos = math.acos
local atan = math.atan
local rad = math.rad
local modf = math.modf
local GetTime = GetTime

local MAX_ALT_SPELLBUTTONS = 6

----------------------------------------------------------------
--> Thanks for rActionBar, rButtonTemplate and Dominos.
----------------------------------------------------------------

----------------------------------------------------------------
--> Hide Bizzard
----------------------------------------------------------------

local hiddenFrame = CreateFrame("Frame")
hiddenFrame:Hide()

local scripts = {
	"OnShow", "OnHide", "OnEvent", "OnEnter", "OnLeave", "OnUpdate", "OnValueChanged", "OnClick", "OnMouseDown", "OnMouseUp",
}

local framesToDisable = {
	MainMenuBar,
	MicroButtonAndBagsBar, MainMenuBarArtFrame, StatusTrackingBarManager,
	ActionBarDownButton, ActionBarUpButton, MainMenuBarVehicleLeaveButton,
	OverrideActionBar,
	OverrideActionBarExpBar, OverrideActionBarHealthBar, OverrideActionBarPowerBar, OverrideActionBarPitchFrame,
}

local framesToHide = {
	MainMenuBar,
	OverrideActionBar,
}
	
local function DisableAllScripts(frame, ignore)
	for i, script in next, scripts do
		if frame:HasScript(script) then
			frame:SetScript(script,nil)
		end
	end
end

local HideMainMenuBar = function()
	if not F.IsClassic then
		hiddenFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
		hiddenFrame:SetScript("OnEvent", function(self, event)
			TokenFrame_LoadUI()
			TokenFrame_Update()
			BackpackTokenFrame_Update()
		end)
	end
	for i, frame in next, framesToDisable do
		frame:UnregisterAllEvents()
		DisableAllScripts(frame)
	end
	for i, frame in next, framesToHide do
		frame: SetParent(hiddenFrame)
	end

	--]]

	--F.HideFrame(MainMenuBar)
	--MainMenuBar: RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	--F.HideFrame(MainMenuBarArtFrame, true)
	--F.HideFrame(OverrideActionBar, true)
	--F.HideFrame(MultiBarBottomLeft)
	--F.HideFrame(MultiBarBottomRight)
	--F.HideFrame(MultiBarLeft)
	--F.HideFrame(MultiBarRight)

	--ActionBarController: UnregisterAllEvents()
	--ActionBarController: RegisterEvent("UPDATE_EXTRA_ACTIONBAR")

	--ZoneAbilityFrame.SpellButton.Style: SetAlpha(0.75)

	hook_ActionButton_ShowGrid = function(button)
		if ( button.NormalTexture ) then
			button.NormalTexture: SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
	end
	hooksecurefunc("ActionButton_ShowGrid", hook_ActionButton_ShowGrid)
end

----------------------------------------------------------------
--> Style Action Buttons
----------------------------------------------------------------
--> 
local backdrop = {
	bgFile = F.Path("White"),
	edgeFile = F.Path("glowTex"),
	tile = true,
	tileSize = 0,
	edgeSize = 1,
	insets = {
		left = 1,
		right = 1,
		top = 1,
		bottom = 1,
	},
}

local SetPointTemplate = function(f)
	f: ClearAllPoints()
	f: SetPoint("TOPLEFT", 0,0)
	f: SetPoint("BOTTOMRIGHT", 0,0)
end

local ButtonSetFont = function(f, font, size, outline)
	f: SetFont(font, size, outline)
	f: SetShadowColor(0,0,0,0)
	f: SetShadowOffset(1,-1)
end

local ResetTexture = function(f, file)
	if not f.tex then return end
	if file == f.tex then return end
	f: SetTexture(f.tex)
end

local ResetNormalTexture = function(f, file)
	if file == Tex.Normal then return end
	f: SetNormalTexture(Tex.Normal)
end

local function ButtonTemplate(f, font_size)
	f: SetNormalTexture(F.Path("Button\\normal"))
	f: SetPushedTexture(F.Path("Button\\pushed"))
	f: SetCheckedTexture(F.Path("Button\\checked"))
	f: SetHighlightTexture(F.Path("Button\\highlight"))

	local name = f:GetName()
	font_size = font_size or 12
	
	--_G[name.."Icon"]: SetTexCoord(0.08,0.92, 0.08,0.92)
	if _G[name.."FloatingBG"] then
		_G[name.."FloatingBG"]: Hide()
	end
	
	if _G[name.."Shine"] then
		_G[name.."Shine"]: ClearAllPoints()
		_G[name.."Shine"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."Shine"]: SetPoint("BOTTOMRIGHT", 0,0)
	end
	
	if _G[name.."AutoCastable"] then
		_G[name.."AutoCastable"]: ClearAllPoints()
		_G[name.."AutoCastable"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."AutoCastable"]: SetPoint("BOTTOMRIGHT", 0,0)
	end
	
	if _G[name.."NormalTexture2"] then
		_G[name.."NormalTexture2"]: SetAlpha(0)
	end
	
	if _G[name.."FlyoutBorder"] then
		_G[name.."FlyoutBorder"]: ClearAllPoints()
		_G[name.."FlyoutBorder"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."FlyoutBorder"]: SetPoint("BOTTOMRIGHT", 0,0)
		
		_G[name.."FlyoutBorderShadow"]: ClearAllPoints()
		_G[name.."FlyoutBorderShadow"]: SetPoint("TOPLEFT", -2,2)
		_G[name.."FlyoutBorderShadow"]: SetPoint("BOTTOMRIGHT", 2,-2)
	end
	
	ButtonSetFont(_G[name.."HotKey"], C.Font.NumSmall, font_size, "THINOUTLINE")
	_G[name.."HotKey"]: ClearAllPoints()
	_G[name.."HotKey"]: SetPoint("TOPLEFT", 2, -1)
	_G[name.."HotKey"]: SetTextColor(1,1,1,1)
	_G[name.."HotKey"]: SetVertexColor(1,1,1,1)
	_G[name.."HotKey"]: SetAlpha(1)
	_G[name.."HotKey"]: SetJustifyH("LEFT")
	_G[name.."HotKey"]: SetJustifyV("TOP")
	
	ButtonSetFont(_G[name.."Count"], C.Font.NumSmall, font_size, "THINOUTLINE")
	_G[name.."Count"]: ClearAllPoints()
	_G[name.."Count"]: SetPoint("BOTTOMRIGHT", 0, 0)
	_G[name.."Count"]: SetTextColor(F.Color(C.Color.Y1, 1))
	_G[name.."Count"]: SetAlpha(1)
	_G[name.."Count"]: SetJustifyH("RIGHT")
	_G[name.."Count"]: SetJustifyV("BOTTOM")
	
	ButtonSetFont(_G[name.."Name"], C.Font.Txt, font_size-2, "THINOUTLINE")
	_G[name.."Name"]: ClearAllPoints()
	_G[name.."Name"]: SetPoint("BOTTOM", 0, 0)
	_G[name.."Name"]: SetTextColor(F.Color(C.Color.W4, 1))
	_G[name.."Name"]: SetAlpha(1)
	_G[name.."Name"]: SetJustifyH("CENTER")
	
	if _G[name.."Cooldown"] then
		SetPointTemplate(_G[name.."Cooldown"])
	end
	
	_G[name.."Border"]: ClearAllPoints()
	--_G[name.."Border"]: SetPoint("TOPLEFT", 0,0)
	--_G[name.."Border"]: SetPoint("BOTTOMRIGHT", 0,0)
	_G[name.."Border"]: SetAlpha(0)
	
	if _G[name.."NormalTexture"] then
		_G[name.."NormalTexture"]:ClearAllPoints()
		_G[name.."NormalTexture"]:SetPoint("TOPLEFT", 0,0)
		_G[name.."NormalTexture"]:SetPoint("BOTTOMRIGHT", 0,0)
	end

	f.Bg = CreateFrame("Frame", nil, f)
	f.Bg: SetFrameLevel(f:GetFrameLevel()-1)
	SetPointTemplate(f.Bg)
	f.Bg: SetBackdrop(backdrop)
	f.Bg: SetBackdropColor(F.Color(C.Color.W1, 0.45))
	f.Bg: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	
	local overlay = F.create_Texture(f, "BORDER", "White", C.Color.Main1, 0.2)
	overlay: SetAllPoints(f)
	--overlay: SetBlendMode("MOD")
end

----------------------------------------------------------------
--> Style Action Buttons
----------------------------------------------------------------

local function Button_Refresh_Squar(frame, style)
	frame: SetNormalTexture(F.Path("Button\\normal"))
	frame: SetPushedTexture(F.Path("Button\\pushed"))
	frame: SetCheckedTexture(F.Path("Button\\checked"))
	frame: SetHighlightTexture(F.Path("Button\\highlight"))

	local name = frame:GetName()
	local font_size = 12
	
	if _G[name.."FloatingBG"] then
		_G[name.."FloatingBG"]: Hide()
	end
	
	if _G[name.."Shine"] then
		_G[name.."Shine"]: ClearAllPoints()
		_G[name.."Shine"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."Shine"]: SetPoint("BOTTOMRIGHT", 0,0)
	end
	
	if _G[name.."AutoCastable"] then
		_G[name.."AutoCastable"]: ClearAllPoints()
		_G[name.."AutoCastable"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."AutoCastable"]: SetPoint("BOTTOMRIGHT", 0,0)
	end
	
	if _G[name.."NormalTexture2"] then
		_G[name.."NormalTexture2"]: SetAlpha(0)
	end
	
	if _G[name.."FlyoutBorder"] then
		_G[name.."FlyoutBorder"]: ClearAllPoints()
		_G[name.."FlyoutBorder"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."FlyoutBorder"]: SetPoint("BOTTOMRIGHT", 0,0)
		
		_G[name.."FlyoutBorderShadow"]: ClearAllPoints()
		_G[name.."FlyoutBorderShadow"]: SetPoint("TOPLEFT", -2,2)
		_G[name.."FlyoutBorderShadow"]: SetPoint("BOTTOMRIGHT", 2,-2)
	end
	
	_G[name.."HotKey"]: ClearAllPoints()
	_G[name.."HotKey"]: SetTextColor(1,1,1,1)
	_G[name.."HotKey"]: SetVertexColor(1,1,1,1)
	_G[name.."HotKey"]: SetAlpha(1)
	
	_G[name.."Count"]: ClearAllPoints()
	_G[name.."Count"]: SetTextColor(F.Color(C.Color.Y1, 1))
	_G[name.."Count"]: SetAlpha(1)
	
	_G[name.."Name"]: ClearAllPoints()
	_G[name.."Name"]: SetTextColor(F.Color(C.Color.W4, 1))
	_G[name.."Name"]: SetAlpha(1)
	
	if _G[name.."Cooldown"] then
		SetPointTemplate(_G[name.."Cooldown"])
	end
	
	_G[name.."Border"]: ClearAllPoints()
	_G[name.."Border"]: SetPoint("TOPLEFT", 0,0)
	_G[name.."Border"]: SetPoint("BOTTOMRIGHT", 0,0)
	_G[name.."Border"]: SetAlpha(0)
	
	if _G[name.."NormalTexture"] then
		_G[name.."NormalTexture"]:ClearAllPoints()
		_G[name.."NormalTexture"]:SetPoint("TOPLEFT", 0,0)
		_G[name.."NormalTexture"]:SetPoint("BOTTOMRIGHT", 0,0)
	end

	if style == 1 then
		font_size = 12
		ButtonSetFont(_G[name.."HotKey"], C.Font.NumSmall, font_size, "THINOUTLINE")
		_G[name.."HotKey"]: SetPoint("TOPLEFT", 2, 0)
		_G[name.."HotKey"]: SetJustifyH("LEFT")
		_G[name.."HotKey"]: SetJustifyV("TOP")

		ButtonSetFont(_G[name.."Count"], C.Font.NumSmall, font_size, "THINOUTLINE")
		_G[name.."Count"]: SetPoint("BOTTOMRIGHT", 0, 0)
		_G[name.."Count"]: SetJustifyH("RIGHT")
		_G[name.."Count"]: SetJustifyV("BOTTOM")

		ButtonSetFont(_G[name.."Name"], C.Font.Txt, font_size-2, "THINOUTLINE")
		_G[name.."Name"]: SetPoint("BOTTOM", 0, 0)
		_G[name.."Name"]: SetJustifyH("CENTER")
	elseif style == 3 then
		font_size = 12
		ButtonSetFont(_G[name.."HotKey"], C.Font.NumSmall, font_size, "THINOUTLINE")
		_G[name.."HotKey"]: SetPoint("TOPLEFT", 2, -1)
		_G[name.."HotKey"]: SetJustifyH("LEFT")
		_G[name.."HotKey"]: SetJustifyV("TOP")

		ButtonSetFont(_G[name.."Count"], C.Font.NumSmall, font_size, "THINOUTLINE")
		_G[name.."Count"]: SetPoint("BOTTOMRIGHT", 0, 0)
		_G[name.."Count"]: SetJustifyH("RIGHT")
		_G[name.."Count"]: SetJustifyV("BOTTOM")

		ButtonSetFont(_G[name.."Name"], C.Font.Txt, font_size-2, "THINOUTLINE")
		_G[name.."Name"]: SetPoint("BOTTOM", 0, 0)
		_G[name.."Name"]: SetJustifyH("CENTER")
	end

	--_G[name.."Icon"]: SetTexCoord(0.08,0.92, 0.08,0.92)
	
	frame.Bg = CreateFrame("Frame", nil, frame)
	frame.Bg: SetFrameLevel(frame:GetFrameLevel()-1)
	SetPointTemplate(frame.Bg)
	frame.Bg: SetBackdrop(backdrop)
	frame.Bg: SetBackdropColor(F.Color(C.Color.W1, 0.45))
	frame.Bg: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	
	local overlay = F.create_Texture(frame, "BORDER", "White", C.Color.Main1, 0.2)
	overlay: SetAllPoints(frame)
	--overlay: SetBlendMode("MOD")
end

----------------------------------------------------------------
--> Style Action Buttons
----------------------------------------------------------------
--> Ring
local function color_Ring(f, color)
	f.LR.Ring: SetVertexColor(F.Color(color))
	f.RR.Ring: SetVertexColor(F.Color(color))
end

local function update_Ring(f, d)
	if f.LR then
		if not d then d = 1 end
		d = min(max(d, 0), 1)
		if d < 0.5 then
			f.LR.Ring:SetRotation(math.rad(f.LR.Base+0))
			f.RR.Ring:SetRotation(math.rad(f.RR.Base-180*d*2))
		else
			f.LR.Ring:SetRotation(math.rad(f.LR.Base-180*(d*2-1)))
			f.RR.Ring:SetRotation(math.rad(f.RR.Base+180))
		end
	end
end

local function Ring_Artwork(f, size, texture)
	local SC = CreateFrame("Frame", nil, f)
	SC: SetSize(size, size)
	f: SetScrollChild(SC)
	
	local Ring = SC:CreateTexture(nil, "ARTWORK")
	Ring: SetTexture(F.Path(texture))
	Ring: SetSize(size, size)
    Ring: SetPoint("CENTER")
    Ring: SetVertexColor(F.Color(C.Color.Main1))
	Ring: SetAlpha(0.75)
	Ring: SetRotation(math.rad(f.Base+180))

	local Back = SC:CreateTexture(nil, "BORDER")
	Back: SetTexture(F.Path(texture))
	Back: SetSize(size, size)
    Back: SetPoint("CENTER")
    Back: SetVertexColor(F.Color(C.Color.Main1))
	Back: SetAlpha(0.25)
	Back: SetRotation(math.rad(f.Base+180))

	f.Ring = Ring
	f.RingBack = Back
end

local function Create_Ring(frame, size, texture)
	frame.S = 0
	frame.D = 0
	frame.E = true

	frame.LR = CreateFrame("ScrollFrame", nil, frame)
	frame.LR: SetSize((size)/2, size)
	frame.LR: SetPoint("RIGHT", frame, "CENTER", 0,0)
	frame.LR.Base = -180
	Ring_Artwork(frame.LR, size, texture)
	
	frame.RR = CreateFrame("ScrollFrame", nil, frame)
	frame.RR: SetSize((size)/2, size)
	frame.RR: SetPoint("LEFT", frame, "CENTER", 0,0)
	frame.RR: SetHorizontalScroll((size)/2)
	frame.RR.Base = 0
	Ring_Artwork(frame.RR, size, texture)
end

local function Button_Refresh_Ring1(frame)
	font_size = font_size or 12
	frame: SetNormalTexture(F.Path("Button\\Ring\\Normal"))
	frame: SetPushedTexture(F.Path("Button\\Ring\\Pushed"))
	frame: SetCheckedTexture(F.Path("Button\\Ring\\Checked"))
	frame: SetHighlightTexture(F.Path("Button\\Ring\\HighLight"))

	local name = frame:GetName()
	_G[name.."Icon"]: SetTexture("Interface\\ICONS\\TEMP")
	_G[name.."Icon"]: SetMask(nil)
	_G[name.."Icon"]: SetTexCoord(0,1,0,1)
	--_G[name.."Icon"]: SetMask("Interface\\Minimap\\UI-Minimap-Background")
	--_G[name.."Icon"]: SetMask("Interface\\ARCHEOLOGY\\Arch-Keystone-Mask")
	_G[name.."Icon"]: SetMask("Interface\\GuildFrame\\GuildLogoMask_L")
		
	if _G[name.."FloatingBG"] then
		_G[name.."FloatingBG"]: Hide()
	end
	
	if _G[name.."Shine"] then
		_G[name.."Shine"]: ClearAllPoints()
		_G[name.."Shine"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."Shine"]: SetPoint("BOTTOMRIGHT", 0,0)
	end
	
	if _G[name.."AutoCastable"] then
		_G[name.."AutoCastable"]: ClearAllPoints()
		_G[name.."AutoCastable"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."AutoCastable"]: SetPoint("BOTTOMRIGHT", 0,0)
	end
	
	if _G[name.."NormalTexture2"] then
		_G[name.."NormalTexture2"]: SetAlpha(0)
	end
	
	if _G[name.."FlyoutBorder"] then
		_G[name.."FlyoutBorder"]: ClearAllPoints()
		_G[name.."FlyoutBorder"]: SetPoint("TOPLEFT", 0,0)
		_G[name.."FlyoutBorder"]: SetPoint("BOTTOMRIGHT", 0,0)
		
		_G[name.."FlyoutBorderShadow"]: ClearAllPoints()
		_G[name.."FlyoutBorderShadow"]: SetPoint("TOPLEFT", -2,2)
		_G[name.."FlyoutBorderShadow"]: SetPoint("BOTTOMRIGHT", 2,-2)
	end
	
	ButtonSetFont(_G[name.."HotKey"], C.Font.NumSmall, font_size, "THINOUTLINE")
	_G[name.."HotKey"]: ClearAllPoints()
	_G[name.."HotKey"]: SetPoint("TOP", 0,-2)
	_G[name.."HotKey"]: SetTextColor(1,1,1,1)
	_G[name.."HotKey"]: SetVertexColor(1,1,1,1)
	_G[name.."HotKey"]: SetAlpha(1)
	_G[name.."HotKey"]: SetJustifyH("CENTER")
	_G[name.."HotKey"]: SetJustifyV("TOP")
	
	ButtonSetFont(_G[name.."Count"], C.Font.NumSmall, font_size, "THINOUTLINE")
	_G[name.."Count"]: ClearAllPoints()
	_G[name.."Count"]: SetPoint("BOTTOM", 0, 2)
	_G[name.."Count"]: SetTextColor(F.Color(C.Color.Y1, 1))
	_G[name.."Count"]: SetAlpha(1)
	_G[name.."Count"]: SetJustifyH("CENTER")
	_G[name.."Count"]: SetJustifyV("BOTTOM")
	
	ButtonSetFont(_G[name.."Name"], C.Font.Txt, font_size-2, "THINOUTLINE")
	_G[name.."Name"]: ClearAllPoints()
	--_G[name.."Name"]: SetPoint("BOTTOM", 0, 2)
	_G[name.."Name"]: SetTextColor(F.Color(C.Color.W4, 1))
	_G[name.."Name"]: SetAlpha(1)
	_G[name.."Name"]: SetJustifyH("CENTER")
	
	if _G[name.."Cooldown"] then
		SetPointTemplate(_G[name.."Cooldown"])
	end
	
	_G[name.."Border"]: ClearAllPoints()
	_G[name.."Border"]: SetPoint("TOPLEFT", 0,0)
	_G[name.."Border"]: SetPoint("BOTTOMRIGHT", 0,0)
	_G[name.."Border"]: SetTexture(F.Path("Button\\Ring\\Border"))
	_G[name.."Border"]: SetAlpha(0)
	
	if _G[name.."NormalTexture"] then
		_G[name.."NormalTexture"]:ClearAllPoints()
		_G[name.."NormalTexture"]:SetPoint("TOPLEFT", 0,0)
		_G[name.."NormalTexture"]:SetPoint("BOTTOMRIGHT", 0,0)
	end

	Create_Ring(frame, 64, "FCS\\FCS2_Ring38_2")

	if not frame.Shadow then
		frame.Shadow = frame: CreateTexture(nil, "OVERLAY")
	end
	frame.Shadow: SetTexture(F.Path("FCS\\FCS2_Ring38_Sd"))
	frame.Shadow: SetVertexColor(F.Color(C.Color.W1))
	frame.Shadow: SetAlpha(0.9)
	frame.Shadow: SetSize(64,64)
	frame.Shadow: SetPoint("CENTER", frame, "CENTER", 0,0)
end

----------------------------------------------------------------
--> Action Bars
----------------------------------------------------------------

local Create_Bar1 = function(f)
	for i = 1, f.num do
		local button = _G[f.name..i]
		if not button then
			break
		end
		f["Button"..i] = button
		f: SetFrameRef(f.name..i, f["Button"..i])
	end
	
	if f.visibility then
		RegisterStateDriver(f, "visibility", f.visibility)
	end
	
	if f.page then
		RegisterStateDriver(f, "page", f.page)
	end
	
	-- creates new table in secure environment and fills it with action button frames retrieving them by frame reference
	f: Execute([[
		buttons = table.new()
		for i = 1, 12 do
			table.insert(buttons, self:GetFrameRef("ActionButton"..i))
		end  
	]])
	
	-- State driver updates "page" attribute based on macro conditionals.  "_onstate-page" is called and newstate contains new actionbar page number.
	f: SetAttribute("_onstate-page", [[ 
		for i, button in ipairs (buttons) do
			button:SetAttribute("actionpage", tonumber(newstate))
		end 
	]])
	
	--print("_onstate-page","index",newstate)
end

local Create_Bar = function(f)
	for i = 1, f.num do
		local button = _G[f.name..i]
		if not button then
			break
		end
		f["Button"..i] = button
	end
	
	if f.blizzardBar then
		f.blizzardBar:SetParent(f)
		f.blizzardBar:EnableMouse(false)
	else
		for i = 1, f.num do
			f["Button"..i]: SetParent(f)
		end
	end
	
	if f.visibility then
		RegisterStateDriver(f, "visibility", f.visibility)
	end
end

local MainBar_Frame = function(f)
	f.MainBar = CreateFrame("Frame", "Quafe_MainActionBar", f, "SecureHandlerStateTemplate")
	--f.MainBar.visibility = "[petbattle][overridebar][vehicleui]hide; show"
	f.MainBar.visibility = "[petbattle]hide; show"
	RegisterStateDriver(f.MainBar, "visibility", f.MainBar.visibility)
	
	f.Bar1 = CreateFrame("Frame", "Quafe_ActionBar1", f.MainBar, "SecureHandlerStateTemplate")
	f.Bar1.name = "ActionButton"
	f.Bar1.num = NUM_ACTIONBAR_BUTTONS
	--f.Bar1.visibility = "[petbattle][overridebar][vehicleui]hide; show"
	f.Bar1.visibility = "[petbattle]hide; show"
	f.Bar1.page = "[bar:6]6;[bar:5]5;[bar:4]4;[bar:3]3;[bar:2]2;[overridebar]14;[shapeshift]13;[vehicleui]12;[possessbar]12;[bonusbar:5]11;[bonusbar:4]10;[bonusbar:3]9;[bonusbar:2]8;[bonusbar:1]7;1"
	Create_Bar1(f.Bar1)
	
	f.Bar2 = CreateFrame("Frame", "Quafe_ActionBar2", f.MainBar, "SecureHandlerStateTemplate")
	f.Bar2.name = "MultiBarBottomLeftButton"
	f.Bar2.num = NUM_ACTIONBAR_BUTTONS
	f.Bar2.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; show"
	f.Bar2.blizzardBar = MultiBarBottomLeft
	Create_Bar(f.Bar2)
	
	f.Bar3 = CreateFrame("Frame", "Quafe_ActionBar3", f.MainBar, "SecureHandlerStateTemplate")
	f.Bar3.name = "MultiBarBottomRightButton"
	f.Bar3.num = NUM_ACTIONBAR_BUTTONS
	f.Bar3.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; show"
	f.Bar3.blizzardBar = MultiBarBottomRight
	Create_Bar(f.Bar3)
end

local function MainBar_Pos_Ring1(frame)
	local SIZE = 36
	local GAP = 6

	frame.MainBar: SetSize((SIZE+GAP)*12, SIZE+GAP)
	--frame.MainBar: SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 4)
	frame.MainBar: SetPoint("BOTTOM", UIParent, "BOTTOM", 0, (SIZE+GAP)*0.866*2+4)

	frame.Bar1: SetSize((SIZE+GAP)*12, SIZE+GAP)
	frame.Bar1: SetPoint("BOTTOM", frame.MainBar, "BOTTOM", 0,0)
	frame.Bar2: SetSize((SIZE+GAP)*12, SIZE+GAP)
	frame.Bar2: SetPoint("BOTTOM", frame.MainBar, "BOTTOM", -(SIZE+GAP)*0.5,-(SIZE+GAP)*0.866)
	frame.Bar3: SetSize((SIZE+GAP)*12, SIZE+GAP)
	frame.Bar3: SetPoint("BOTTOM", frame.MainBar, "BOTTOM", 0,-(SIZE+GAP)*0.866*2)

	--[[
	frame.Bar1: SetSize((SIZE+GAP)*12, SIZE+GAP)
	frame.Bar1: SetPoint("BOTTOMLEFT", frame.MainBar, "BOTTOMLEFT", (SIZE+GAP)*0.5, (SIZE+GAP)*0.866)
	frame.Bar2: SetSize((SIZE+GAP)*12, SIZE+GAP)
	frame.Bar2: SetPoint("BOTTOMLEFT", frame.MainBar, "BOTTOMLEFT", (SIZE+GAP),0)
	frame.Bar3: SetSize((SIZE+GAP)*6, SIZE+GAP)
	frame.Bar3: SetPoint("BOTTOMRIGHT", frame.MainBar, "BOTTOMRIGHT", 0,0)
	--]]
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		if frame.Bar1["Button"..i] then
			frame.Bar1["Button"..i]: SetParent(frame.Bar1)
			frame.Bar1["Button"..i]: SetSize(SIZE, SIZE)
			frame.Bar1["Button"..i]: ClearAllPoints()
			if i == 1 then
				frame.Bar1["Button"..i]: SetPoint("LEFT", frame.Bar1, "LEFT", GAP/2,0)
			else
				frame.Bar1["Button"..i]: SetPoint("LEFT", frame.Bar1["Button"..(i-1)], "RIGHT", GAP,0)
			end
			Button_Refresh_Ring1(frame.Bar1["Button"..i])
		end
		
		if frame.Bar2["Button"..i] then
			frame.Bar2["Button"..i]: SetSize(SIZE, SIZE)
			frame.Bar2["Button"..i]: ClearAllPoints()
			if i == 1 then
				frame.Bar2["Button"..i]: SetPoint("LEFT", frame.Bar2, "LEFT", GAP/2,0)
			else
				frame.Bar2["Button"..i]: SetPoint("LEFT", frame.Bar2["Button"..(i-1)], "RIGHT", GAP,0)
			end
			Button_Refresh_Ring1(frame.Bar2["Button"..i])
		end
		
		if frame.Bar3["Button"..i] then
			frame.Bar3["Button"..i]: SetSize(SIZE, SIZE)
			frame.Bar3["Button"..i]: ClearAllPoints()
			--[[
			if i == 1 then
				frame.Bar3["Button"..i]: SetPoint("LEFT", frame.Bar3, "LEFT", GAP/2-(SIZE+GAP)*0.5,(SIZE+GAP)*0.866)
			elseif i == 7 then
				frame.Bar3["Button"..i]: SetPoint("LEFT", frame.Bar3, "LEFT", GAP/2,0)
			else
				frame.Bar3["Button"..i]: SetPoint("LEFT", frame.Bar3["Button"..(i-1)], "RIGHT", GAP,0)
			end
			--]]
			if i == 1 then
				frame.Bar3["Button"..i]: SetPoint("LEFT", frame.Bar3, "LEFT", GAP/2,0)
			else
				frame.Bar3["Button"..i]: SetPoint("LEFT", frame.Bar3["Button"..(i-1)], "RIGHT", GAP,0)
			end
			Button_Refresh_Ring1(frame.Bar3["Button"..i])
		end
	end
end

local function MainBar_PosType1(f)
	local size_x = 36
	local size_y = 24
	local gap = 2
	
	f.MainBar: SetSize((size_x+gap)*12, size_y)
	f.MainBar: SetPoint("BOTTOM", UIParent, "BOTTOM", 0, (size_y+gap)*2+4)
	f.Bar1: SetSize((size_x+gap)*12, size_y)
	f.Bar1: SetPoint("BOTTOM", f.MainBar, "BOTTOM", 0, 0)
	f.Bar2: SetSize((size_x+gap)*12, size_y)
	f.Bar2: SetPoint("TOP", f.Bar1, "BOTTOM", 0, -gap)
	f.Bar3: SetSize((size_x+gap)*12, size_y)
	f.Bar3: SetPoint("TOP", f.Bar2, "BOTTOM", 0, -gap)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		if f.Bar1["Button"..i] then
			f.Bar1["Button"..i]: SetParent(f.Bar1)
			f.Bar1["Button"..i]: SetSize(size_x, size_y)
			f.Bar1["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar1["Button"..i]: SetPoint("LEFT", f.Bar1, "LEFT", gap/2,0)
			else
				f.Bar1["Button"..i]: SetPoint("LEFT", f.Bar1["Button"..(i-1)], "RIGHT", gap,0)
			end
			Button_Refresh_Squar(f.Bar1["Button"..i], 1)
			
			local name = f.Bar1["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(0,1, (size_x-size_y)*0.5/size_x,(size_x+size_y)*0.5/size_x)
		end
		
		if f.Bar2["Button"..i] then
			f.Bar2["Button"..i]: SetSize(size_x, size_y)
			f.Bar2["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar2["Button"..i]: SetPoint("LEFT", f.Bar2, "LEFT", gap/2,0)
			else
				f.Bar2["Button"..i]: SetPoint("LEFT", f.Bar2["Button"..(i-1)], "RIGHT", gap,0)
			end
			Button_Refresh_Squar(f.Bar2["Button"..i], 1)
			
			local name = f.Bar2["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(0,1, (size_x-size_y)*0.5/size_x,(size_x+size_y)*0.5/size_x)
		end
		
		if f.Bar3["Button"..i] then
			f.Bar3["Button"..i]: SetSize(size_x, size_y)
			f.Bar3["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar3["Button"..i]: SetPoint("LEFT", f.Bar3, "LEFT", gap/2,0)
			else
				f.Bar3["Button"..i]: SetPoint("LEFT", f.Bar3["Button"..(i-1)], "RIGHT", gap,0)
			end
			Button_Refresh_Squar(f.Bar3["Button"..i], 1)
			
			local name = f.Bar3["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(0,1, (size_x-size_y)*0.5/size_x,(size_x+size_y)*0.5/size_x)
		end
	end
end

local function MainBar_PosType2(f)
	local size_x = 30
	local size_y = 34
	local gap = 2
	f.MainBar: SetSize((size_x+gap)*12, size_y)
	f.MainBar: SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 4)
	f.Bar1: SetSize((size_x+gap)*12, size_y)
	f.Bar1: SetPoint("BOTTOM", f.MainBar, "BOTTOM", 0, 0)
	f.Bar2: SetSize((size_x+gap)*12, size_y)
	f.Bar2: SetPoint("RIGHT", f.Bar1, "LEFT", -8*gap, 0)
	f.Bar3: SetSize((size_x+gap)*12, size_y)
	f.Bar3: SetPoint("LEFT", f.Bar1, "RIGHT", 8*gap, 0)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		if f.Bar1["Button"..i] then
			f.Bar1["Button"..i]: SetParent(f.Bar1)
			f.Bar1["Button"..i]: SetSize(size_x, size_y)
			f.Bar1["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar1["Button"..i]: SetPoint("LEFT", f.Bar1, "LEFT", gap/2,0)
			else
				f.Bar1["Button"..i]: SetPoint("LEFT", f.Bar1["Button"..(i-1)], "RIGHT", gap,0)
			end
			ButtonTemplate(f.Bar1["Button"..i], 10)
			
			local name = f.Bar1["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(2/size_y,(size_y-2)/size_y, 0,1)
		end
		
		if f.Bar2["Button"..i] then
			f.Bar2["Button"..i]: SetSize(size_x, size_y)
			f.Bar2["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar2["Button"..i]: SetPoint("LEFT", f.Bar2, "LEFT", gap/2,0)
			else
				f.Bar2["Button"..i]: SetPoint("LEFT", f.Bar2["Button"..(i-1)], "RIGHT", gap,0)
			end
			ButtonTemplate(f.Bar2["Button"..i], 10)
			
			local name = f.Bar2["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(2/size_y,(size_y-2)/size_y, 0,1)
		end
		
		if f.Bar3["Button"..i] then
			f.Bar3["Button"..i]: SetSize(size_x, size_y)
			f.Bar3["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.Bar3["Button"..i]: SetPoint("LEFT", f.Bar3, "LEFT", gap/2,0)
			else
				f.Bar3["Button"..i]: SetPoint("LEFT", f.Bar3["Button"..(i-1)], "RIGHT", gap,0)
			end
			ButtonTemplate(f.Bar3["Button"..i], 10)
			
			local name = f.Bar3["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(2/size_y,(size_y-2)/size_y, 0,1)
		end
	end
end

local RightBar_Frame = function(f)
	f.Bar4 = CreateFrame("Frame", "Quafe_ActionBar4", UIParent, "SecureHandlerStateTemplate")
	f.Bar4.name = "MultiBarRightButton"
	f.Bar4.num = NUM_ACTIONBAR_BUTTONS
	f.Bar4.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; show"
	f.Bar4.blizzardBar = MultiBarRight
	f.Bar4.ButtonSize = 26
	f.Bar4: SetSize(f.Bar4.ButtonSize+4, f.Bar4.ButtonSize*f.Bar4.num+2*(f.Bar4.num))
	--f.Bar4: SetPoint("RIGHT", UIParent, "RIGHT", 0,-60)
	f.Bar4: SetPoint("BOTTOMRIGHT", UIParent, "RIGHT", -4,20)
	f.Bar4: SetAlpha(1)
	Create_Bar(f.Bar4)
	MultiBarRight: Hide()
	
	f.Bar5 = CreateFrame("Frame", "Quafe_ActionBar5", UIParent, "SecureHandlerStateTemplate")
	f.Bar5.name = "MultiBarLeftButton"
	f.Bar5.num = NUM_ACTIONBAR_BUTTONS
	f.Bar5.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; show"
	f.Bar5.blizzardBar = MultiBarLeft
	f.Bar5.ButtonSize = 26
	f.Bar5: SetSize(f.Bar5.ButtonSize+4, f.Bar5.ButtonSize*f.Bar5.num+2*(f.Bar5.num))
	--f.Bar5: SetPoint("RIGHT", f.Bar4, "LEFT", 0,0)
	f.Bar5: SetPoint("TOP", f.Bar4, "BOTTOM", 0,-40)
	f.Bar5: SetAlpha(1)
	Create_Bar(f.Bar5)
	MultiBarLeft: Hide()
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		if f.Bar4["Button"..i] then
			f.Bar4["Button"..i]: SetSize(f.Bar5.ButtonSize,f.Bar5.ButtonSize)
			f.Bar4["Button"..i]: ClearAllPoints()
			--f.Bar4["Button"..i]: SetPoint("BOTTOMRIGHT", UIParent, "RIGHT", -4,16+28*(NUM_ACTIONBAR_BUTTONS-i))
			--f.Bar4["Button"..i]: SetPoint("TOPRIGHT", UIParent, "RIGHT", -4,56-28*(i-1))
			if i == 1 then
				f.Bar4["Button"..i]: SetPoint("TOPRIGHT", f.Bar4, "TOPRIGHT", -2,-2)
			else
				f.Bar4["Button"..i]: SetPoint("TOPRIGHT", f.Bar4["Button"..(i-1)], "BOTTOMRIGHT", 0,-2)
			end
			Button_Refresh_Squar(f.Bar4["Button"..i], 1)
			
			local name = f.Bar4["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(0,1, 0,1)
			--_G[name.."HotKey"]: ClearAllPoints()
		end
		
		if f.Bar5["Button"..i] then
			f.Bar5["Button"..i]: SetSize(f.Bar5.ButtonSize,f.Bar5.ButtonSize)
			f.Bar5["Button"..i]: ClearAllPoints()
			--f.Bar5["Button"..i]: SetPoint("TOPRIGHT", UIParent, "RIGHT", -4,-16-28*(i-1))
			--f.Bar5["Button"..i]: SetPoint("RIGHT", f.Bar4["Button"..i], "LEFT", -4,0)
			if i == 1 then
				f.Bar5["Button"..i]: SetPoint("TOPRIGHT", f.Bar5, "TOPRIGHT", -2,-2)
			else
				f.Bar5["Button"..i]: SetPoint("TOPRIGHT", f.Bar5["Button"..(i-1)], "BOTTOMRIGHT", 0,-2)
			end
			Button_Refresh_Squar(f.Bar5["Button"..i], 1)
			
			local name = f.Bar5["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(0,1, 0,1)
			--_G[name.."HotKey"]: ClearAllPoints()
		end
	end
end

local PetBar_Frame = function(f)
	local size_x = 36
	local size_y = 24
	local gap = 2

	f.PetBar = CreateFrame("Frame", "Quafe_ActionPetBar", f, "SecureHandlerStateTemplate")
	f.PetBar.name = "PetActionButton"
	f.PetBar.num = NUM_PET_ACTION_SLOTS
	f.PetBar.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift]hide; [pet]show; hide"
	f.PetBar.blizzardBar = PetActionBarFrame
	f.PetBar.ButtonSize = 24

	f.PetBar: SetSize((size_x+gap)*f.PetBar.num, size_y)
	f.PetBar: SetPoint("BOTTOMRIGHT", f.MainBar, "TOPRIGHT", 0,4)
	
	Create_Bar(f.PetBar)
	for i = 1, f.PetBar.num do
		if f.PetBar["Button"..i] then
			f.PetBar["Button"..i]: SetSize(size_x,size_y)
			f.PetBar["Button"..i]: ClearAllPoints()
			--[[
			if i == 1 then
				f.PetBar["Button"..i]: SetPoint("TOPLEFT", f.PetBar, "TOPLEFT", gap, -gap)
			elseif i == 6 then
				f.PetBar["Button"..i]: SetPoint("BOTTOMLEFT", f.PetBar, "BOTTOMLEFT", gap, gap)
			else
				f.PetBar["Button"..i]: SetPoint("LEFT", f.PetBar["Button"..(i-1)], "RIGHT", gap, 0)
			end
			--]]
			if i == 1 then
				f.PetBar["Button"..i]: SetPoint("LEFT", f.PetBar, "LEFT", gap/2, 0)
			else
				f.PetBar["Button"..i]: SetPoint("LEFT", f.PetBar["Button"..(i-1)], "RIGHT", gap, 0)
			end
			Button_Refresh_Squar(f.PetBar["Button"..i], 1)
			
			local name = f.PetBar["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(0,1, (size_x-size_y)*0.5/size_x,(size_x+size_y)*0.5/size_x)
			_G[name.."HotKey"]: SetFont(C.Font.NumSmall, 10, "THINOUTLINE")
		end
	end
	SlidingActionBarTexture0:SetTexture(nil)
	SlidingActionBarTexture1:SetTexture(nil)
end

local StanceBar_Frame = function(f)
	local size_x = 36
	local size_y = 24
	local gap = 2

	f.StanceBar = CreateFrame("Frame", "Quafe_StanceBar", UIParent, "SecureHandlerStateTemplate")
	f.StanceBar.name = "StanceButton"
	f.StanceBar.num = NUM_STANCE_SLOTS
	f.StanceBar.visibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift] hide; show"
	f.StanceBar.blizzardBar = StanceBarFrame
	f.StanceBar.ButtonSize = 24

	f.StanceBar: SetSize((size_x+gap)*f.StanceBar.num, size_y)
	f.StanceBar: SetPoint("BOTTOMLEFT", f.MainBar, "TOPLEFT", 0,4)
	
	Create_Bar(f.StanceBar)
	for i = 1, f.StanceBar.num do
		if f.StanceBar["Button"..i] then
			--f.StanceBar["Button"..i]: SetParent(f.StanceBar)
			f.StanceBar["Button"..i]: SetSize(size_x,size_y)
			f.StanceBar["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.StanceBar["Button"..i]: SetPoint("LEFT", f.StanceBar, "LEFT", gap/2, 0)
			else
				f.StanceBar["Button"..i]: SetPoint("LEFT", f.StanceBar["Button"..(i-1)], "RIGHT", gap, 0)
			end
			
			ButtonTemplate(f.StanceBar["Button"..i])
			local name = f.StanceBar["Button"..i]:GetName()
			_G[name.."Icon"]: SetTexCoord(0,1, (size_x-size_y)*0.5/size_x,(size_x+size_y)*0.5/size_x)
			_G[name.."HotKey"]: SetFont(C.Font.NumSmall, 10, "THINOUTLINE")
		end
	end
	StanceBarLeft:SetTexture(nil)
	StanceBarMiddle:SetTexture(nil)
	StanceBarRight:SetTexture(nil)
end

local ExtraBar_Frame = function(f)
	f.ExtraBar = CreateFrame("Frame", "Quafe_ExtraBar", UIParent, "SecureHandlerStateTemplate")
	f.ExtraBar.name = "ExtraActionButton"
	f.ExtraBar.num = NUM_ACTIONBAR_BUTTONS
	f.ExtraBar.visibility = "[extrabar]show; hide"
	f.ExtraBar.blizzardBar = ExtraActionBarFrame
	f.ExtraBar:SetSize(36,36)
	f.ExtraBar:SetPoint("TOPLEFT", f.MainBar, "TOPRIGHT", 6, 0)
	
	Create_Bar(f.ExtraBar)
	for i  = 1, f.ExtraBar.num do
		if f.ExtraBar["Button"..i] then
			f.ExtraBar["Button"..i].style: SetAlpha(0)
			ExtraActionButton1NormalTexture: SetAlpha(0)
			f.ExtraBar["Button"..i]: SetSize(36,36)
			f.ExtraBar["Button"..i]: ClearAllPoints()
			if i == 1 then
				f.ExtraBar["Button"..i]: SetPoint("LEFT", f.ExtraBar, "LEFT", 0,0)
			else
				f.ExtraBar["Button"..i]: SetPoint("LEFT", f.ExtraBar["Button"..(i-1)], "RIGHT", 2,0)
			end
		end
	end
end

local function ZoneAbility_Frame(f)
	f.ZoneAbility = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
	f.ZoneAbility: SetSize(36,36)
	f.ZoneAbility: SetPoint("TOPLEFT", f.MainBar, "TOPRIGHT", 6, -40)
	
	ZoneAbilityFrame: SetParent(f.ZoneAbility)
	ZoneAbilityFrame: EnableMouse(false)
	ZoneAbilityFrameNormalTexture: SetAlpha(0)
	ZoneAbilityFrame.SpellButton.Style: SetAlpha(0)
	f.ZoneAbility.Button = ZoneAbilityFrame.SpellButton
	f.ZoneAbility.Button: SetSize(36,36)
	f.ZoneAbility.Button: ClearAllPoints()
	f.ZoneAbility.Button: SetPoint("CENTER", f.ZoneAbility, "CENTER", 0,0)
end

local VehicleExit_Frame = function(f)
	f.VehicleExit = CreateFrame("Frame", "Quafe_VehicleExit", UIParent, "SecureHandlerStateTemplate")
	f.VehicleExit.visibility = "[canexitvehicle]c;[mounted]m;n"
	f.VehicleExit: SetSize(28,28)
	f.VehicleExit: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	
	f.VehicleExit.Button = CreateFrame("Button", "Quafe_LeaveButton", f.VehicleExit)
	f.VehicleExit.Button: SetSize(28,28)
	f.VehicleExit.Button: SetPoint("CENTER", f.VehicleExit, "CENTER", 0,0)
	
	f.VehicleExit.Button.Icon = f.VehicleExit.Button: CreateTexture("Quafe_LeaveButtonIcon", "ARTWORK")
	f.VehicleExit.Button.Icon: SetSize(28,28)
	f.VehicleExit.Button.Icon: SetPoint("CENTER", f.VehicleExit.Button, "CENTER", 0,0)
	
	f.VehicleExit.Button.Icon: SetTexture("Interface\\Icons\\INV_Misc_EngGizmos_27")
	--f.VehicleExit.Button.Icon: SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
	f.VehicleExit.Button.Icon: SetMask("Interface\\Minimap\\UI-Minimap-Background")
	
	f.VehicleExit.Button: SetScript("OnEnter", function(self, event)
		if ( UnitOnTaxi("player") ) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(TAXI_CANCEL, 1, 1, 1)
			GameTooltip:AddLine(TAXI_CANCEL_DESCRIPTION, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
			GameTooltip:Show()
		else
			GameTooltip_AddNewbieTip(self, LEAVE_VEHICLE, 1.0, 1.0, 1.0, nil)
		end
	end)
	f.VehicleExit.Button: SetScript("OnLeave", function(self, event)
		GameTooltip:Hide()
	end)
	f.VehicleExit.Button: SetScript("OnClick", function(self, button)
		if ( UnitOnTaxi("player") ) then
			TaxiRequestEarlyLanding()
			--> Show that the request for landing has been received.
			f.VehicleExit.Button.Icon: SetDesaturated(true)
		else
			VehicleExit()
		end
	end)
	
	f.VehicleExit: RegisterEvent("PLAYER_ENTERING_WORLD")
	f.VehicleExit: RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	f.VehicleExit: RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")
	f.VehicleExit: RegisterEvent("UNIT_ENTERED_VEHICLE")
	f.VehicleExit: RegisterEvent("UNIT_EXITED_VEHICLE")
	f.VehicleExit: RegisterEvent("VEHICLE_UPDATE")
	f.VehicleExit: SetScript("OnEvent", function(self, event)
		if ( CanExitVehicle() ) then
			f.VehicleExit.Button: Show()
			f.VehicleExit.Button.Icon: SetDesaturated(false)
		else
			f.VehicleExit.Button: Hide()
		end
	end)
end

--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------

local Quafe_ActionBar = CreateFrame("Frame", nil, E)
Quafe_ActionBar.Init = false

local function Quafe_ActionBar_Load()
	if F.IsAddonEnabled("EuiScript") then return end
	if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ActionBar"].Enable then
		HideMainMenuBar()
		MainBar_Frame(Quafe_ActionBar)
		
		MainBar_PosType1(Quafe_ActionBar)
		--MainBar_PosType2(Quafe_ActionBar)
		--MainBar_Pos_Ring1(Quafe_ActionBar)
		
		RightBar_Frame(Quafe_ActionBar)
		if not F.IsClassic then
			ExtraBar_Frame(Quafe_ActionBar)
			ZoneAbility_Frame(Quafe_ActionBar)
			VehicleExit_Frame(Quafe_ActionBar)
		end
		PetBar_Frame(Quafe_ActionBar)
		StanceBar_Frame(Quafe_ActionBar)

		--MultiActionBar_Update()
		Quafe_ActionBar.Init = true
	end
end

local function Quafe_ActionBar_Toggle(arg)
	if arg == "ON" then
		if not Quafe_ActionBar.Init then
			Quafe_ActionBar_Load()
		end
		Quafe_ActionBar: Show()
	elseif arg == "OFF" then
		Quafe_ActionBar: Hide()
		Quafe_NoticeReload()
	end
end

local Quafe_ActionBar_Config = {
	Database = {
		["Quafe_ActionBar"] = {
			Enable = true,
			Style = L['ACTION_STYLE_RING'],
		},
	},

	Config = {
		Name = "Quafe "..L['ACTION_BAR'],
		Type = "Switch",
		Click = function(self, button)
			if InCombatLockdown() then return end
			if Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ActionBar.Enable then
				Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ActionBar.Enable = false
				self.Text:SetText(L["OFF"])
				Quafe_ActionBar_Toggle("OFF")
			else
				Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_ActionBar.Enable = true
				self.Text:SetText(L["ON"])
				Quafe_ActionBar_Toggle("ON")
			end
		end,
		Show = function(self)
			if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ActionBar"].Enable then
				self.Text:SetText(L["ON"])
			else
				self.Text:SetText(L["OFF"])
			end
		end,
		Sub = {
			[1] = {
				Name = L['STYLE'],
				Type = "Dropdown",
				Show = function(self)
					if Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ActionBar"].Style then
						self.Text:SetText(Quafe_DB.Profile[Quafe_DBP.Profile]["Quafe_ActionBar"].Style)
					end
				end,
				DropMenu = {
					[1] = {
						Text = L['ACTION_STYLE_RING'],
						Click = function(self, button)
							
						end,
					},
					[2] = {
						Text = L['ACTION_STYLE_RING'],
						Click = function(self, button)
							
						end,
					},
				},
			},
		},
	},
}

Quafe_ActionBar.Load = Quafe_ActionBar_Load
Quafe_ActionBar.Config = Quafe_ActionBar_Config
tinsert(E.Module, Quafe_ActionBar)


