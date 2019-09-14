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
local mod = mod
local modf = math.modf

local insert = table.insert
local remove = table.remove
local wipe = table.wipe

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

--> sourced from Blizzard_ArenaUI/Blizzard_ArenaUI.lua
local MAX_ARENA_ENEMIES = MAX_ARENA_ENEMIES or 5
--> sourced from FrameXML/TargetFrame.lua
local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES or 5
--> sourced from FrameXML/PartyMemberFrame.lua
local MAX_PARTY_MEMBERS = MAX_PARTY_MEMBERS or 4

local RELOAD_UI = false

local button_size = 30
local button_gap = 4
local backdrop = {
	bgFile = F.Path("White"),
	edgeFile = F.Path("White"),
	tile = true, tileSize = 16, edgeSize = 1,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
}

local function ButtonHighLight_Create(frame, color)
	local PlusHighlight = frame:CreateTexture(nil, "BORDER")
	PlusHighlight: SetTexture(F.Path("White"))
	PlusHighlight: SetVertexColor(F.Color(color))
	PlusHighlight: SetAllPoints(frame)
	PlusHighlight: SetAlpha(0)

	frame: HookScript("OnEnter", function(self)
		PlusHighlight: SetAlpha(0.9)
	end)
	frame: HookScript("OnLeave", function(self)
		PlusHighlight: SetAlpha(0)
	end)
end

----------------------------------------------------------------
--> Config Mover
----------------------------------------------------------------

local Quafe_ConfigMover = CreateFrame("Button", "Quafe_ConfigMover", E)
Quafe_ConfigMover: SetFrameStrata("HIGH")
Quafe_ConfigMover: Hide()
tinsert(UISpecialFrames, "Quafe_ConfigMover")

local function Mover_Artwork(frame)
	frame: SetSize(32,32)
	frame: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	frame: SetScript("OnClick", function(self, button)
		frame: Hide()
		Quafe_Config: Show()
	end)
	frame: SetScript("OnHide", function(self)
		Quafe_Config: Show()
	end)

	local LowFrame = CreateFrame("Frame", nil, frame)
	LowFrame: SetFrameStrata("LOW")

	local Gd = F.Create.Texture(LowFrame, "BACKGROUND", 1, F.Path("Grid"), C.Color.B2, 0.5, {4096,2048})
	Gd: SetPoint("CENTER", UIParent, "CENTER", 0,0)

	local Bg1 = frame: CreateTexture(nil, "BACKGROUND")
	Bg1: SetTexture(F.Path("Config_MoverBg1"))
	Bg1: SetVertexColor(F.Color(C.Color.W2))
	Bg1: SetSize(36, 36)
	Bg1: SetPoint("CENTER", frame, "CENTER", 0,0)
	Bg1: SetAlpha(0.9)
	
	local Bg2 = frame: CreateTexture(nil, "BORDER")
	Bg2: SetTexture(F.Path("Config_MoverBg2"))
	Bg2: SetVertexColor(F.Color(C.Color.W1))
	Bg2: SetSize(32, 32)
	Bg2: SetPoint("CENTER", frame, "CENTER", 0,0)
	Bg2: SetAlpha(0.9)
	
	local Border1= frame: CreateTexture(nil, "BORDER")
	Border1: SetTexture(F.Path("Config_MoverBorder1"))
	Border1: SetVertexColor(F.Color(C.Color.W2))
	Border1: SetAlpha(0.5)
	Border1: SetSize(32, 32)
	Border1: SetPoint("CENTER", frame, "CENTER", 0,0)
	
	local Exit = frame: CreateTexture(nil, "ARTWORK")
	Exit: SetTexture(F.Path("Config_MoverX"))
	Exit: SetVertexColor(F.Color(C.Color.W2))
	Exit: SetAlpha(0.9)
	Exit: SetSize(32,32)
	Exit: SetPoint("CENTER", f, "CENTER", 0,0)
	
	local Loop = CreateFrame("Frame", nil, frame)
	Loop: SetSize(32,32)
	Loop: SetPoint("CENTER", frame, "CENTER", 0,0)
	
	Loop.Tex = Loop:CreateTexture(nil, "ARTWORK")
	Loop.Tex: SetTexture(F.Path("Config_MoverBorder2"))
	Loop.Tex: SetVertexColor(F.Color(C.Color.R3))
	Loop.Tex: SetAlpha(0.9)
	Loop.Tex: SetSize(32,32)
	Loop.Tex: SetPoint("CENTER", frame, "CENTER", 0,0)
	
	Loop.animationRotation = Loop:CreateAnimationGroup()
	Loop.Roation = Loop.animationRotation:CreateAnimation("Rotation")
	Loop.Roation: SetDegrees(-180)
	Loop.Roation: SetDuration(2)
	
	Loop.animationRotation: Play()
	Loop.animationRotation: SetLooping("REPEAT")  --NONE, REPEAT, BOUNCE

	frame: SetScript("OnEnter", function(self)
		Exit: SetVertexColor(F.Color(C.Color.R3))
		GameTooltip: SetOwner(self, "ANCHOR_BOTTOMRIGHT", 10,-10)
		GameTooltip: AddLine(L['BACK'], 1.0,1.0,1.0)
		
		--GameTooltip: AddLine(L['BACK'], 1.0,1.0,1.0)
		--GameTooltip: AddTexture(F.Path("MouseLeftButton"))
		--GameTooltip: AddLine(L['EXIT'], 1.0,1.0,1.0)
		--GameTooltip: AddTexture(F.Path("MouseRightButton"))
		
		GameTooltip: Show()
	end)
	frame: SetScript("OnLeave", function(self)
		Exit: SetVertexColor(F.Color(C.Color.W2))
		GameTooltip: Hide()
	end)
end

local function ConfigMover_Load()
	Mover_Artwork(Quafe_ConfigMover)
end
Quafe_ConfigMover.Load = ConfigMover_Load()
tinsert(E.Module, Quafe_ConfigMover)

function F.CreateJoystick(frame, sizeX,sizeY, framename)
	local Mover = CreateFrame("Frame", nil, Quafe_ConfigMover)
	Mover: SetPoint("CENTER", frame, "CENTER", 0,0)
	Mover: SetSize(sizeX,sizeY)
	Mover: SetBackdrop({
		bgFile = F.Path("White"),
		edgeFile = F.Path("White"),
		tile = false, tileSize = 16, edgeSize = 2,
		insets = {left = 0, right = 0, top = 0, bottom = 0},
	})
	Mover: SetBackdropColor(F.Color(C.Color.B2, 0.5))
	Mover: SetBackdropBorderColor(0.09,0.09,0.09,0.9)
	Mover: SetScript("OnShow", function(self)
		if frame.MoverOnShow then
			frame:MoverOnShow()
		end
	end)
	Mover: SetScript("OnHide", function(self)
		if frame.MoverOnHide then
			frame:MoverOnHide()
		end
	end)

	--local Bg = Mover:CreateTexture(nil, "BACKGROUND")
	--Bg: SetTexture(F.Path("White"))
	--Bg: SetVertexColor(0.09,0.09,0.09,0.5)
	--Bg: SetAllPoints(Mover)

	local Name = F.create_Font(Mover, C.Font.Txt, 12, nil, 1, "CENTER", "CENTER")
	Name: SetPoint("TOP", Mover, "TOP", 0,-4)
	Name: SetAlpha(1)
	Name: SetText(framename)

	local Joystick = CreateFrame("Frame", nil, Mover)
	--Joystick: SetFrameStrata("HIGH")
	Joystick: SetSize(24,24)
	Joystick: SetPoint("CENTER", Mover, "CENTER", 0,0)

	Joystick.Tex = Joystick:CreateTexture(nil, "ARTWORK")
	Joystick.Tex: SetTexture(F.Path("Config_Joystick"))
	Joystick.Tex: SetSize(32,32)
	Joystick.Tex: SetPoint("CENTER")

	Joystick: SetClampedToScreen(true)
	Joystick: SetMovable(true)
	Joystick: EnableMouse(true)
	--Joystick: SetUserPlaced(false)
	Joystick: RegisterForDrag("LeftButton","RightButton")
	Joystick: SetScript("OnDragStart", function(self)
		self:StartMoving()
		self: SetScript("OnUpdate", self.postUpdate)
	end)
	Joystick: SetScript("OnDragStop", function(self)
		self: StopMovingOrSizing()
		self: SetScript("OnUpdate", nil)
		self: ClearAllPoints()
		self: SetPoint("CENTER", Mover, "CENTER", 0,0)
	end)

	frame.Mover = Mover
	frame.Joystick = Joystick
end

----------------------------------------------------------------
--> Bar
----------------------------------------------------------------

local function HoldHeight_Update(frame)
	local height = 2+button_size*10
	local num = #frame.Bar
	if num and num >= 1 then
		for i = 1, #frame.Bar do
			if frame.Bar[i]: IsShown() then
				height = height + frame.Bar[i]:GetHeight() + button_gap
			end
		end
	end
	frame.Hold: SetHeight(height)
	if height > 440 then
		frame.Slider: Show()
	else
		frame.Slider: Hide()
		frame: SetVerticalScroll(0)
	end
end

local function FramesVisible_Update(num, frames)
	for i = 1, #frames do
		if i == num then
			frames[i]: Show()
		else
			frames[i]: Hide()
		end
	end
end

local function Create_Arrow(f, style)
	if not style then style = "None" end
	if style == "Switch" then
		--> Left
		f.ArrowL = f:CreateTexture(nil, "ARTWORK", 1)
		f.ArrowL: SetTexture(F.Path("Config_Arrow"))
		f.ArrowL: SetVertexColor(F.Color(C.Color.W3))
		f.ArrowL: SetSize(32, 32)
		f.ArrowL: SetPoint("LEFT", f, "LEFT", 0,0)
		f.ArrowL: SetAlpha(1)
		--> Right
		f.ArrowR = f:CreateTexture(nil, "ARTWORK", 1)
		f.ArrowR: SetTexture(F.Path("Config_Arrow"))
		f.ArrowR: SetVertexColor(F.Color(C.Color.W3))
		f.ArrowR: SetSize(32, 32)
		f.ArrowR: SetTexCoord(1,0, 0,1)
		f.ArrowR: SetPoint("RIGHT", f, "RIGHT", 0,0)
		f.ArrowR: SetAlpha(1)
	elseif style == "Dropdown" then
		--> Down
		f.ArrowD = f:CreateTexture(nil, "ARTWORK", 1)
		f.ArrowD: SetTexture(F.Path("Config_ArrowDown"))
		f.ArrowD: SetVertexColor(F.Color(C.Color.W3))
		f.ArrowD: SetSize(32, 32)
		f.ArrowD: SetTexCoord(0,1, 0,1)
		f.ArrowD: SetPoint("RIGHT", f, "RIGHT", 0,0)
		f.ArrowD: SetAlpha(1)
	end
	
	if style ~= "Blank" then
		f.Text = f:CreateFontString(nil, "ARTWORK")
		f.Text: SetFont(C.Font.Txt, 14, nil)
		f.Text: SetShadowColor(0,0,0,0)
		f.Text: SetShadowOffset(1,-1)
		f.Text: SetTextColor(F.Color(C.Color.W3))
		f.Text: SetJustifyH("CENTER")
		f.Text: SetPoint("CENTER", f, "CENTER", 0, 0)
		f.Text: SetText(L['INVALID'])
		
		f.HighLight = f:CreateTexture(nil, "BORDER", 1)
		f.HighLight: SetTexture(F.Path("White"))
		f.HighLight: SetVertexColor(F.Color(C.Color.B2))
		f.HighLight: SetAllPoints(f)
		f.HighLight: SetAlpha(0)
	end
end

local function SubBar_Fold(frame, DB)
	frame.Case: Hide()
	frame: SetHeight(button_size)
	frame.Plus.Tex: SetTexture(F.Path("Config_Plus1"))
end

local function SubBar_Open(frame, DB)
	frame.Case: Show()
	frame.Plus.Tex: SetTexture(F.Path("Config_Plus2"))
	--frame: SetHeight(button_size+(button_size+button_gap)* #DB)
	frame: SetHeight(frame.Height)
	if frame.Dropdown and frame.Dropdown:IsShown() then
		frame.Dropdown:Hide()
	end
end

---------------------------------------------------------------
--> Dropdown
---------------------------------------------------------------

local function ConfigSubBar_Refresh(frame, scroll, configframe, DB)
	frame.Height = button_size
	local last = 0
	for k,v in ipairs(DB) do
		if (v.State == frame.Config.SubState) or (v.State == "ALL") then
			frame.SubBar[k]: Show()
			if last == 0 then
				frame.SubBar[k]: ClearAllPoints()
				frame.SubBar[k]: SetPoint("TOP", frame, "TOP", 0, -button_size-button_gap)
			else
				frame.SubBar[k]: ClearAllPoints()
				frame.SubBar[k]: SetPoint("TOP", frame.SubBar[last], "BOTTOM", 0, -button_gap)
			end
			last = k
			frame.Height = frame.Height + (button_size+button_gap)
		else
			frame.SubBar[k]: Hide()
		end
	end
end

local function Dropdown_Create(frame, scroll, configframe)
	local Dropdown = CreateFrame("Frame", nil, frame)
	Dropdown: SetPoint("TOPLEFT", frame.Button, "BOTTOMLEFT", 0,-4)
	Dropdown: SetPoint("TOPRIGHT", frame.Button, "BOTTOMRIGHT", 0,-4)
	Dropdown: SetFrameStrata("DIALOG")
	Dropdown: SetBackdrop(backdrop)
	Dropdown: SetBackdropColor(F.Color(C.Color.W2, 0.9))
	Dropdown: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	Dropdown: Hide()
	Dropdown.Menu = {}
	
	Dropdown: SetScript("OnLeave", function(self)
		if not MouseIsOver(self) then
			self: Hide()
		end
	end)
	frame.Dropdown = Dropdown
	frame: HookScript("OnHide", function(self)
		self.Dropdown: Hide()
	end)
end

local function Dropdown_Toggle(frame)
	if frame.Dropdown: IsShown() then
		frame.Dropdown: Hide()
	else
		frame.Dropdown: Show()
	end
end

local function Dropdown_Menu_Artwork(frame, fontsize)
	local Text = frame: CreateFontString(nil, "ARTWORK")
	if fontsize then
		Text: SetFont(C.Font.Txt, fontsize, nil)
	else
		Text: SetFont(C.Font.Txt, 14, nil)
	end
	Text: SetShadowColor(0,0,0,0)
	Text: SetShadowOffset(1,-1)
	Text: SetTextColor(F.Color(C.Color.W3))
	Text: SetJustifyH("CENTER")
	Text: SetPoint("CENTER", frame, "CENTER", 0, 0)
	Text: SetText(L['INVALID'])

	local HighLight = frame: CreateTexture(nil, "BORDER", 1)
	HighLight: SetTexture(F.Path("White"))
	HighLight: SetVertexColor(F.Color(C.Color.B1))
	HighLight: SetAllPoints(frame)
	HighLight: SetAlpha(0)

	frame: SetScript("OnEnter", function(self)
		HighLight: SetAlpha(0.7)
	end)
	frame: SetScript("OnLeave", function(self)
		HighLight: SetAlpha(0)
	end)
	frame: SetScript("OnShow", function(self)
		HighLight: SetAlpha(0)
	end)

	frame.Text = Text
end

local function Dropdown_Menu_Create(frame, bar, DB, scroll, configframe)
	local MenuNum = 0
	for k, v in ipairs(DB) do
		if v then
			frame.Menu[k] = CreateFrame("Button", nil, frame)
			frame.Menu[k]: SetHeight(button_size-4)
			frame.Menu[k]: SetFrameLevel(frame:GetFrameLevel()+1)
			frame.Menu[k]: SetBackdrop(backdrop)
			frame.Menu[k]: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
			frame.Menu[k]: SetBackdropColor(F.Color(C.Color.B1, 0))
			if k == 1 then
				frame.Menu[k]: SetPoint("TOPLEFT", frame, "TOPLEFT", 4,-4)
				frame.Menu[k]: SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4,-4)
			else
				frame.Menu[k]: SetPoint("TOPLEFT", frame.Menu[k-1], "BOTTOMLEFT", 0,-4)
				frame.Menu[k]: SetPoint("TOPRIGHT", frame.Menu[k-1], "BOTTOMRIGHT", 0,-4)
			end
			Dropdown_Menu_Artwork(frame.Menu[k])

			frame.Menu[k]: HookScript("OnLeave", function(self)
				if not MouseIsOver(frame) then
					frame: Hide()
				end
			end)
			if v.Text then
				frame.Menu[k].Text: SetText(v.Text)
			end
			if v.State then
				frame.Menu[k].State = v.State
			end
			if v.Click then
				frame.Menu[k]: SetScript("OnClick", function(self, button)
					v.Click(self, button)
					bar.Button.Text: SetText(v.Text)
					if bar.Config and bar.Config.SubRefresh then
						bar.Config.SubState = frame.Menu[k].State
						ConfigSubBar_Refresh(bar, scroll, configframe, bar.Config.SubRefresh)
						HoldHeight_Update(scroll)
						SubBar_Fold(bar)
					end
					frame: Hide()
				end)
			end
			MenuNum = MenuNum + 1
		end
	end
	frame: SetHeight(button_size*MenuNum+4)
end

---------------------------------------------------------------
--> Slider
---------------------------------------------------------------

local function Slider_Create(frame)
	local SliderHold = CreateFrame("Frame", nil, frame)
	SliderHold: SetSize(222, button_size)
	if frame.Plus then
		SliderHold: SetPoint("TOPRIGHT", frame.Plus, "TOPRIGHT", -4,0)
	else
		SliderHold: SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,0)
	end
	
	local Slider = CreateFrame("Slider", nil, SliderHold)
	Slider: SetOrientation("HORIZONTAL")
	Slider: SetThumbTexture(F.Path("Config_Slider_Pie"), "ARTWORK")
	Slider: SetHeight(button_size/2)
	Slider: SetPoint("LEFT", SliderHold, "LEFT", 10,0)
	Slider: SetPoint("RIGHT", SliderHold, "RIGHT", -10,0)
	Slider: SetMinMaxValues(1, 10)
	Slider: SetObeyStepOnDrag(true)
	Slider: SetValueStep(1)
	Slider: SetValue(1)

	Slider: SetScript("OnValueChanged", function(self, value)
		value = floor(value*100+0.5)/100
		self.Text:SetText(value)
	end)

	local Bg = SliderHold:CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.W1))
	Bg: SetHeight(6)
	Bg: SetPoint("LEFT", Slider, "LEFT", 0,0)
	Bg: SetPoint("RIGHT", Slider, "RIGHT", 0,0)
	Bg: SetAlpha(0.6)

	local Text = SliderHold:CreateFontString(nil, "ARTWORK")
	Text: SetFont(C.Font.NumSmall, 14, nil)
	Text: SetShadowColor(0,0,0,0)
	Text: SetShadowOffset(1,-1)
	Text: SetTextColor(F.Color(C.Color.W3))
	Text: SetJustifyH("RIGHT")
	Text: SetPoint("RIGHT", SliderHold, "LEFT", 0, 1)

	SliderHold: EnableMouseWheel(true)
	SliderHold: SetScript("OnMouseWheel", function(self, d)
		local min, max = Slider:GetMinMaxValues()
		local value = Slider:GetValue()
		local step = Slider:GetValueStep()
		if d > 0 then
			Slider: SetValue((value+step >= max and max) or value+step)
		elseif d < 0 then
			Slider: SetValue((value-step <= min and min) or value-step)
		end
	end)

	SliderHold: SetScript("OnShow", function(self)
		if not self.Init then
			local min, max = Slider:GetMinMaxValues()
			local value = Slider:GetValue()
			local step = (value-min)/5
			local cur = min
			Slider: SetValue(cur)
			self: SetScript("OnUpdate", function(self, elapsed)
				self.Init = true
				if cur < value then
					cur = cur + step
					Slider: SetValue(cur)
				else
					cur = value
					Slider: SetValue(cur)
					self: SetScript("OnUpdate", nil)
				end
			end)
		end
	end)

	frame.Slider = Slider
	frame.Slider.Text = Text
end


---------------------------------------------------------------
--> 
---------------------------------------------------------------

local Button_Artwork = function(frame, style, hasbutton)
	local Plus = CreateFrame("Button", nil, frame)
	Plus: SetSize(button_size,button_size)
	Plus: SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,0)
	Plus: SetBackdrop(backdrop)
	Plus: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Plus: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	
	local PlusTex = Plus:CreateTexture(nil, "ARTWORK")
	PlusTex: SetTexture(F.Path("Config_Plus0"))
	PlusTex: SetVertexColor(F.Color(C.Color.W3))
	PlusTex: SetSize(32, 32)
	PlusTex: SetPoint("CENTER", Plus, "CENTER", 0,0)
	PlusTex: SetAlpha(1)

	local PlusHighlight =  Plus:CreateTexture(nil, "BORDER", 1)
	PlusHighlight: SetTexture(F.Path("White"))
	PlusHighlight: SetVertexColor(F.Color(C.Color.B2))
	PlusHighlight: SetAllPoints(Plus)
	PlusHighlight: SetAlpha(0)

	frame.Plus = Plus
	frame.Plus.Tex = PlusTex

	frame.Plus: SetScript("OnEnter", function(self)
		PlusHighlight: SetAlpha(0.9)
	end)
	frame.Plus: SetScript("OnLeave", function(self)
		PlusHighlight: SetAlpha(0)
	end)

	local Bg = frame:CreateTexture(nil, "BACKGROUND", 1)
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.W2))
	Bg: SetHeight(button_size)
	Bg: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
	if hasbutton then
		Bg: SetPoint("RIGHT", frame.Plus, "LEFT", -226,0)
	else
		Bg: SetPoint("RIGHT", frame.Plus, "LEFT", -4,0)
	end
	Bg: SetAlpha(1)
	
	local Name = frame:CreateFontString(nil, "ARTWORK")
	Name: SetFont(C.Font.Txt, 14, nil)
	Name: SetShadowColor(0,0,0,0)
	Name: SetShadowOffset(1,-1)
	Name: SetTextColor(F.Color(C.Color.W3))
	--Name: SetJustifyH("LEFT")
	Name: SetPoint("LEFT", Bg, "LEFT", 20, 0)
	
	frame.Bg = Bg
	frame.Name = Name

	if hasbutton then
		local Button = CreateFrame("Button", nil, frame)
		Button: SetHeight(button_size)
		Button: SetPoint("LEFT", Bg, "RIGHT", 4,0)
		Button: SetPoint("RIGHT", frame.Plus, "LEFT", -4,0)
		Button: SetBackdrop(backdrop)
		Button: SetBackdropColor(F.Color(C.Color.B1, 0.7))
		Button: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
		Create_Arrow(Button, style)
		
		Button: SetScript("OnEnter", function(self)
			self.HighLight: SetAlpha(0.3)
		end)
		Button: SetScript("OnLeave", function(self)
			self.HighLight: SetAlpha(0)
		end)

		frame.Button = Button
	end
end

local SubBar_Artwork = function(frame, style, hasbutton)
	local Bg = frame:CreateTexture(nil, "BACKGROUND", 1)
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.W2))
	Bg: SetHeight(button_size)
	Bg: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
	if hasbutton then
		Bg: SetPoint("TOPRIGHT", frame, "TOPRIGHT", -226,0)
	else
		Bg: SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,0)
	end
	Bg: SetAlpha(1)
	
	local Name = frame:CreateFontString(nil, "ARTWORK")
	Name: SetFont(C.Font.Txt, 14, nil)
	Name: SetShadowColor(0,0,0,0)
	Name: SetShadowOffset(1,-1)
	Name: SetTextColor(F.Color(C.Color.W3))
	--Name: SetJustifyH("LEFT")
	Name: SetPoint("LEFT", Bg, "LEFT", 20, 0)
	
	frame.Bg = Bg
	frame.Name = Name

	if hasbutton then
		local Button = CreateFrame("Button", nil, frame)
		Button: SetHeight(button_size)
		Button: SetPoint("LEFT", Bg, "RIGHT", 4,0)
		Button: SetPoint("RIGHT", frame, "RIGHT", 0,0)
		Button: SetBackdrop(backdrop)
		Button: SetBackdropColor(F.Color(C.Color.B1, 0.7))
		Button: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
		Create_Arrow(Button, style)
		
		Button: SetScript("OnEnter", function(self)
			self.HighLight: SetAlpha(0.3)
		end)
		Button: SetScript("OnLeave", function(self)
			self.HighLight: SetAlpha(0)
		end)

		frame.Button = Button
	end
end

---------------------------------------------------------------
--> Bar
---------------------------------------------------------------

local function ConfigSubBar_Create(frame, scroll, configframe, DB)
	local SubBarNum = #DB
	frame.Height = button_size+(button_size+button_gap)* #DB
	for i = 1, SubBarNum do
		frame.SubBar[i] = CreateFrame("Frame", nil, frame.Case)
		frame.SubBar[i]: SetSize(620, button_size)
		
		if DB[i].Type == "Switch" then
			SubBar_Artwork(frame.SubBar[i], DB[i].Type, true)
		elseif DB[i].Type == "Trigger" then
			SubBar_Artwork(frame.SubBar[i], DB[i].Type, true)
		elseif DB[i].Type == "Dropdown" then
			SubBar_Artwork(frame.SubBar[i], DB[i].Type, true)
		elseif DB[i].Type == "Slider" then
			SubBar_Artwork(frame.SubBar[i], DB[i].Type, false)
			Slider_Create(frame.SubBar[i])
		elseif DB[i].Type == "Blank" then
			SubBar_Artwork(frame.SubBar[i], DB[i].Type, false)
		else
			SubBar_Artwork(frame.SubBar[i], DB[i].Type, false)
		end

		if DB[i].Name then
			frame.SubBar[i].Name: SetText(DB[i].Name)
		end
		if DB[i].Text then
			frame.SubBar[i].Button.Text: SetText(DB[i].Text)
		end
		if DB[i].Type == "Dropdown" then
			Dropdown_Create(frame.SubBar[i])
			frame.SubBar[i].Button: SetScript("OnClick", function(self)
				Dropdown_Toggle(frame.SubBar[i])
			end)
			Dropdown_Menu_Create(frame.SubBar[i].Dropdown, frame.SubBar[i], DB[i].DropMenu)
		elseif DB[i].Click then
			frame.SubBar[i].Button: SetScript("OnClick", DB[i].Click)
		end
		if DB[i].Load then
			DB[i].Load(frame.SubBar[i])
		end
		if DB[i].Show then
			configframe: HookScript("OnShow", function(self)
				DB[i].Show(frame.SubBar[i].Button)
			end)
		end

		if i == 1 then
			frame.SubBar[i]: SetPoint("TOP", frame, "TOP", 0, -button_size-button_gap)
		else
			frame.SubBar[i]: SetPoint("TOP", frame.SubBar[i-1], "BOTTOM", 0, -button_gap)
		end
	end

	frame.Plus.Tex: SetTexture(F.Path("Config_Plus1"))
	frame.Plus: SetScript("OnClick", function(self, button)
		if frame.Case:IsShown() then
			SubBar_Fold(frame, DB)
		else
			SubBar_Open(frame, DB)
		end
		HoldHeight_Update(scroll)
	end)
	configframe:HookScript("OnHide", function(self)
		if frame.Case:IsShown() then
			SubBar_Fold(frame, DB)
			HoldHeight_Update(scroll)
		end
	end)
end

local function ConfigSubBar_Load(frame, scroll, configframe, DB)
	frame.Case = CreateFrame("Frame", nil, frame)
	frame.Case: Hide()
	frame.SubBar = {}

	ConfigSubBar_Create(frame, scroll, configframe, DB)
end

-->
local function Bar1_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame.Hold)
	Bar: SetSize(720, button_size)
	if frame.Num == 1 then
		Bar: SetPoint("TOP", frame.Hold, "TOP", 0,-2)
	else
		Bar: SetPoint("TOP", frame.Bar[frame.Num-1], "BOTTOM", 0,-button_gap)
	end

	return Bar
end

local function ConfigBar_Create(frame, scroll, configframe)
	local Info = frame.Config
	if Info.Type == "Switch" then
		Button_Artwork(frame, Info.Type, true)
	elseif Info.Type == "Trigger" then
		Button_Artwork(frame, Info.Type, true)
	elseif Info.Type == "Dropdown" then
		Button_Artwork(frame, Info.Type, true)
		Dropdown_Create(frame)
	elseif Info.Type == "Slider" then
		Button_Artwork(frame, Info.Type, false)
		Slider_Create(frame)
	elseif Info.Type == "Blank" then
		Button_Artwork(frame, Info.Type, false)
	else
		Button_Artwork(frame, Info.Type, false)
	end
	if Info.Name then
		frame.Name: SetText(Info.Name)
	end
	if Info.Text then
		frame.Button.Text: SetText(Info.Text)
	end
	if Info.Type == "Dropdown" then
		frame.Button: SetScript("OnClick", function(self)
			Dropdown_Toggle(frame)
		end)
		Dropdown_Menu_Create(frame.Dropdown, frame, Info.DropMenu, scroll, configframe)
	elseif (frame.Button) and Info.Click then
		frame.Button: SetScript("OnClick", Info.Click)
	end
	if Info.Load then
		Info.Load(frame)
	end
	if Info.Show then
		configframe: HookScript("OnShow", function(self)
			Info.Show(frame.Button)
		end)
	end
	if Info.Sub then
		ConfigSubBar_Load(frame, scroll, configframe, Info.Sub)
	end
	if Info.SubRefresh then
		ConfigSubBar_Load(frame, scroll, configframe, Info.SubRefresh)
		ConfigSubBar_Refresh(frame, scroll, configframe, Info.SubRefresh)
	end
end

local function ConfigScrollBar_Load(frame, configframe)
	for k, v in ipairs(E.Module) do
		if v.Config and v.Config.Config then
			frame.Num = frame.Num + 1
			frame.Bar[frame.Num] = Bar1_Template(frame)
			frame.Bar[frame.Num].Config = {}
			frame.Bar[frame.Num].Config = v.Config.Config
			ConfigBar_Create(frame.Bar[frame.Num], frame, configframe)
		end
	end
end

----------------------------------------------------------------
--> Config Button
----------------------------------------------------------------
--	Config = {
--		Name = Left string,
--		Text = Right string,
--		Type = Switch, Trigger, Dropdown, Blank,
--		Click = function(self, button) end,
--		Show = function(self) end,
--		Sub = {
--			[1] = {
--				Name = Left string,
--				Text = Right string,
--				Type = Switch, Trigger, Dropdown,
--				Click = function(self, button) end,
--				Show = function(self) end,
--				DropMenu = {
--					[1] = {
--						Text = string
--						Click = function(self, button) end,
--					},
--				},
--			},
--		},
--	}

local function Button_Mover(frame, configframe)
	frame.Num = frame.Num + 1
	frame.Bar[frame.Num] = Bar1_Template(frame)
	frame.Bar[frame.Num].Config = {
		Name = L['MOVE_FRAME'],
		Text = L['START'],
		Type = "Trigger",
		Click = function(self, button)
			configframe: Hide()
			Quafe_ConfigMover: Show()
		end,
		Sub = {
			[1] = {
				Name = L['RESET_POSITION'],
				Text = L['CONFIRM'],
				Type = "Trigger",
				Click = function(self, button)
					Quafe_NoticeReload()
				end
			},
		},
	}
	ConfigBar_Create(frame.Bar[frame.Num], frame, configframe)
end

local function Button_Scale(frame, configframe)
	frame.Num = frame.Num + 1
	frame.Bar[frame.Num] = Bar1_Template(frame)
	frame.Bar[frame.Num].Config = {
		Name = L['SCALE'],
		Type = "Switch",
		Click = function(self, button)

		end,
		Show = function(self)

		end,
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
		},
	}
	ConfigBar_Create(frame.Bar[frame.Num], frame, configframe)
end

local function Button_Mouse(frame, configframe)
	frame.Num = frame.Num + 1
	frame.Bar[frame.Num] = Bar1_Template(frame)
	frame.Bar[frame.Num].Config = {
		Name = L['MOUSE'],
		Type = "Blank",
		Sub = {
			[1] = {
				Name = L['RAW_MOUSE'],
				Text = L["ON"],
				Type = "Switch",
				Click = function(self, button)
					if tostring(GetCVar("rawMouseEnable")) == "1" then
						SetCVar("rawMouseEnable", 0)
						self.Text:SetText(L["OFF"])
					else
						SetCVar("rawMouseEnable", 1)
						self.Text:SetText(L["ON"])
					end
				end,
				Load = function(self)
					self: RegisterEvent("PLAYER_ENTERING_WORLD")
					self: RegisterEvent("CVAR_UPDATE")
					self: SetScript("OnEvent", function(s, event, ...)
						if tostring(GetCVar("rawMouseEnable") or 0) == "1" then
							self.Button.Text:SetText(L["ON"])
						else
							self.Button.Text:SetText(L["OFF"])
						end
					end)
				end,
				Show = nil,
			},
			[2] = {
				Name = L['MOUSE_POLLING'],
				Type = "Slider",
				Click = nil,
				Load = function(self)
					self.Slider: SetMinMaxValues(125, 1000)
					self.Slider: SetValueStep(5)
					self.Slider: HookScript("OnValueChanged", function(s, value)
						SetCVar("rawMouseRate", value)
					end)
					self: RegisterEvent("PLAYER_ENTERING_WORLD")
					self: RegisterEvent("CVAR_UPDATE")
					self: SetScript("OnEvent", function(s, event, ...)
						self.Slider: SetValue(GetCVar("rawMouseRate") or 0)
					end)
				end,
				Show = nil,
			},
			[3] = {
				Name = L['MOUSE_RESOLUTION'],
				Type = "Slider",
				Load = function(self)
					self.Slider: SetMinMaxValues(400, 10000)
					self.Slider: SetValueStep(10)
					self.Slider: HookScript("OnValueChanged", function(s, value)
						SetCVar("rawMouseResolution", value)
					end)
					self: RegisterEvent("PLAYER_ENTERING_WORLD")
					self: RegisterEvent("CVAR_UPDATE")
					self: SetScript("OnEvent", function(s, event, ...)
						self.Slider: SetValue(GetCVar("rawMouseResolution") or 0)
					end)
				end,
				Show = nil,
			},
		},
	}
	ConfigBar_Create(frame.Bar[frame.Num], frame, configframe)
end

----------------------------------------------------------------
--> Aurawatch Button
----------------------------------------------------------------
-->

local function Displace(A,B)
	return B,A
end

local function SortList(frame, scroll, direction)
	local classFileName = select(2, UnitClass("player"))
	local specID = (F.IsClassic and 1) or GetSpecialization() or 0
	if direction == "Up" then
		if frame.ID > 1 then
			Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID], Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID-1] = 
			Displace(Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID], Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID-1])
		end
	elseif direction == "Down" then
		if Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID+1] then
			Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID], Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID+1] = 
			Displace(Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID], Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID+1])
		end
	end
	scroll.Update()
end

local function Aurawatch_Bar_Artwork(frame, scroll)
	local Sn = CreateFrame("Button", nil, frame)
	Sn: SetSize(button_size, button_size)
	Sn: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
	Sn: SetBackdrop(backdrop)
	Sn: SetBackdropColor(F.Color(C.Color.W2, 1))
	Sn: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(Sn, C.Color.B2)
	Sn: SetScript("OnClick", function(self)
		local classFileName = select(2, UnitClass("player"))
		local specID = (F.IsClassic and 1) or GetSpecialization() or 0
		if Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID].Show then
			Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID].Show = false
			self: SetBackdropColor(F.Color(C.Color.W2, 1))
		else
			Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID].Show = true
			self: SetBackdropColor(F.Color(C.Color.B1, 0.7))
		end
		scroll.Update()
	end)

	local SnText = Sn:CreateFontString(nil, "ARTWORK")
	SnText: SetFont(C.Font.NumSmall, 14, nil)
	SnText: SetShadowColor(0,0,0,0)
	SnText: SetShadowOffset(0,0)
	SnText: SetTextColor(F.Color(C.Color.W3))
	SnText: SetPoint("CENTER", Sn, "CENTER", 1, 1)
	SnText: SetText("-")

	local SnUp = CreateFrame("Button", nil, frame)
	SnUp: SetSize(button_size, button_size/2-1)
	SnUp: SetPoint("TOPLEFT", Sn, "TOPRIGHT", 4,0)
	SnUp: SetBackdrop(backdrop)
	SnUp: SetBackdropColor(F.Color(C.Color.W2, 1))
	SnUp: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(SnUp, C.Color.B2)
	SnUp: SetScript("OnClick", function(self)
		SortList(frame, scroll, "Up")
	end)

	local ArrowU = SnUp:CreateTexture(nil, "ARTWORK", 1)
	ArrowU: SetTexture(F.Path("Config_ArrowDown"))
	ArrowU: SetVertexColor(F.Color(C.Color.W3))
	ArrowU: SetSize(24, 24)
	ArrowU: SetTexCoord(0,1, 1,0)
	ArrowU: SetPoint("CENTER", SnUp, "CENTER", 0,0)
	ArrowU: SetAlpha(1)

	local SnDown = CreateFrame("Button", nil, frame)
	SnDown: SetSize(button_size, button_size/2-1)
	SnDown: SetPoint("BOTTOMLEFT", Sn, "BOTTOMRIGHT", 4,0)
	SnDown: SetBackdrop(backdrop)
	SnDown: SetBackdropColor(F.Color(C.Color.W2, 1))
	SnDown: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(SnDown, C.Color.B2)
	SnDown: SetScript("OnClick", function(self)
		SortList(frame, scroll, "Down")
	end)

	local ArrowD = SnDown:CreateTexture(nil, "ARTWORK", 1)
	ArrowD: SetTexture(F.Path("Config_ArrowDown"))
	ArrowD: SetVertexColor(F.Color(C.Color.W3))
	ArrowD: SetSize(24, 24)
	ArrowD: SetTexCoord(0,1, 0,1)
	ArrowD: SetPoint("CENTER", SnDown, "CENTER", 0,0)
	ArrowD: SetAlpha(1)

	local StyleButton = CreateFrame("Button", nil, frame)
	StyleButton: SetSize((720-button_size*4-24)/3, button_size)
	StyleButton: SetPoint("TOPLEFT", SnUp, "TOPRIGHT", 4,0)
	StyleButton: SetBackdrop(backdrop)
	StyleButton: SetBackdropColor(F.Color(C.Color.W2, 1))
	StyleButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))

	local StyleText = StyleButton:CreateFontString(nil, "ARTWORK")
	StyleText: SetFont(C.Font.Txt, 14, nil)
	StyleText: SetShadowColor(0,0,0,0)
	StyleText: SetShadowOffset(1,-1)
	StyleText: SetTextColor(F.Color(C.Color.W3))
	StyleText: SetPoint("CENTER", StyleButton, "CENTER", 0, 0)
	StyleText: SetText("Style")

	local IconButton = CreateFrame("Button", nil, frame)
	IconButton: SetSize(button_size, button_size)
	IconButton: SetPoint("TOPLEFT", StyleButton, "TOPRIGHT", 4,0)
	IconButton: SetBackdrop(backdrop)
	IconButton: SetBackdropColor(F.Color(C.Color.W2, 1))
	IconButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))

	local IconTexture = F.Create.Texture(IconButton, "ARTWORK", 1, nil, C.Color.W3, 1, {button_size, button_size}, nil)
	IconTexture: SetPoint("CENTER", IconButton, "CENTER")

	local AuraButton = CreateFrame("Button", nil, frame)
	AuraButton: SetSize((720-button_size*4-24)/3-12, button_size)
	AuraButton: SetPoint("TOPLEFT", IconButton, "TOPRIGHT", 4+12,0)
	AuraButton: SetBackdrop(backdrop)
	AuraButton: SetBackdropColor(F.Color(C.Color.W2, 1))
	AuraButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))

	local AuraText = AuraButton:CreateFontString(nil, "ARTWORK")
	AuraText: SetFont(C.Font.Txt, 14, nil)
	AuraText: SetShadowColor(0,0,0,0)
	AuraText: SetShadowOffset(1,-1)
	AuraText: SetTextColor(F.Color(C.Color.W3))
	AuraText: SetPoint("CENTER", AuraButton, "CENTER", 0, 0)
	AuraText: SetText("Aura")

	local AuraIndicator = CreateFrame("Frame", nil, AuraButton)
	AuraIndicator: SetSize(8, button_size)
	AuraIndicator: SetPoint("RIGHT", AuraButton, "LEFT", -4,0)
	AuraIndicator: SetBackdrop(backdrop)
	AuraIndicator: SetBackdropColor(F.Color(C.Color.W2, 1))
	AuraIndicator: SetBackdropBorderColor(F.Color(C.Color.W1, 0))

	local SpellButton = CreateFrame("Button", nil, frame)
	SpellButton: SetSize((720-button_size*4-24)/3-12, button_size)
	SpellButton: SetPoint("TOPLEFT", AuraButton, "TOPRIGHT", 4+12,0)
	SpellButton: SetBackdrop(backdrop)
	SpellButton: SetBackdropColor(F.Color(C.Color.W2, 1))
	SpellButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))

	local SpellText = SpellButton:CreateFontString(nil, "ARTWORK")
	SpellText: SetFont(C.Font.Txt, 14, nil)
	SpellText: SetShadowColor(0,0,0,0)
	SpellText: SetShadowOffset(1,-1)
	SpellText: SetTextColor(F.Color(C.Color.W3))
	SpellText: SetPoint("CENTER", SpellButton, "CENTER", 0, 0)
	SpellText: SetText("Spell")

	local SpellIndicator = CreateFrame("Frame", nil, SpellButton)
	SpellIndicator: SetSize(8, button_size)
	SpellIndicator: SetPoint("RIGHT", SpellButton, "LEFT", -4,0)
	SpellIndicator: SetBackdrop(backdrop)
	SpellIndicator: SetBackdropColor(F.Color(C.Color.W2, 1))
	SpellIndicator: SetBackdropBorderColor(F.Color(C.Color.W1, 0))

	local MenuButton = CreateFrame("Button", nil, frame)
	MenuButton: SetSize(button_size, button_size)
	MenuButton: SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,0)
	MenuButton: SetBackdrop(backdrop)
	MenuButton: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	MenuButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(MenuButton, C.Color.B2)

	MenuButton.Tex = MenuButton:CreateTexture(nil, "ARTWORK")
	MenuButton.Tex: SetTexture(F.Path("Config_Plus3"))
	MenuButton.Tex: SetVertexColor(F.Color(C.Color.W3))
	MenuButton.Tex: SetSize(32, 32)
	MenuButton.Tex: SetPoint("CENTER", MenuButton, "CENTER", 0,0)
	MenuButton.Tex: SetAlpha(1)

	Sn: HookScript("OnEnter", function(self)
		GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip: SetPoint("TOPRIGHT", self, "TOPLEFT", -4,0)
		GameTooltip: SetText(L['SHOW'].."/"..L['HIDE'], 1.0, 1.0, 1.0);
		GameTooltip: Show()
	end)
	Sn: HookScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
	
	MenuButton: HookScript("OnEnter", function(self)
		GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip: SetPoint("TOPLEFT", self, "TOPRIGHT", 4,0)
		GameTooltip: SetText(L['EDIT'], 1.0, 1.0, 1.0);
		GameTooltip: Show()
	end)
	MenuButton: HookScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	frame.Sn = Sn
	frame.SnText = SnText
	frame.AuraText = AuraText
	frame.AuraIndicator = AuraIndicator
	frame.SpellText = SpellText
	frame.SpellIndicator = SpellIndicator
	frame.StyleText = StyleText
	frame.IconTexture = IconTexture
	frame.MenuButton = MenuButton
end

local function Aurawatch_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame.Hold)
	Bar: SetSize(720, button_size)
	if frame.Num == 1 then
		Bar: SetPoint("TOP", frame.Hold, "TOP", 0,-2)
	else
		Bar: SetPoint("TOP", frame.Bar[frame.Num-1], "BOTTOM", 0,-button_gap)
	end
	Aurawatch_Bar_Artwork(Bar, frame)
	Bar.MenuButton: SetScript("OnClick", function(self, button)
		frame.NewWatcher.ID = Bar.ID
		frame.NewWatcher:Show()
	end)
	----
	return Bar
end

local function Aurawatch_Title_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame.Hold)
	Bar: SetSize(720, button_size)
	if frame.Num == 1 then
		Bar: SetPoint("TOP", frame.Hold, "TOP", 0,-2)
	else
		Bar: SetPoint("TOP", frame.Bar[frame.Num-1], "BOTTOM", 0,-button_gap)
	end

	local Bg = Bar: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.B1))
	Bg: SetSize(720-button_size-4, 4)
	Bg: SetPoint("TOPLEFT", Bar, "TOPLEFT", 0,4-button_size)
	Bg: SetAlpha(0.7)

	local StyleText = Bar:CreateFontString(nil, "ARTWORK")
	StyleText: SetFont(C.Font.Txt, 14, nil)
	StyleText: SetShadowColor(0,0,0,0)
	StyleText: SetShadowOffset(1,-1)
	StyleText: SetTextColor(F.Color(C.Color.W3))
	StyleText: SetPoint("CENTER", Bar, "LEFT", (720-button_size*4-24)/6+button_size*2+8, 0)
	StyleText: SetText(L["STYLE"])

	local AuraText = Bar:CreateFontString(nil, "ARTWORK")
	AuraText: SetFont(C.Font.Txt, 14, nil)
	AuraText: SetShadowColor(0,0,0,0)
	AuraText: SetShadowOffset(1,-1)
	AuraText: SetTextColor(F.Color(C.Color.W3))
	AuraText: SetPoint("CENTER", StyleText, "CENTER", (720-button_size*4-24)/3+8+button_size+4, 0)
	AuraText: SetText(L["AURA"])

	local SpellText = Bar:CreateFontString(nil, "ARTWORK")
	SpellText: SetFont(C.Font.Txt, 14, nil)
	SpellText: SetShadowColor(0,0,0,0)
	SpellText: SetShadowOffset(1,-1)
	SpellText: SetTextColor(F.Color(C.Color.W3))
	SpellText: SetPoint("CENTER", AuraText, "CENTER", (720-button_size*4-24)/3+8, 0)
	SpellText: SetText(L["SPELL"])

	Bar.Plus = CreateFrame("Button", nil, Bar)
	Bar.Plus: SetSize(button_size,button_size)
	Bar.Plus: SetPoint("TOPRIGHT", Bar, "TOPRIGHT", 0,0)
	Bar.Plus: SetBackdrop(backdrop)
	Bar.Plus: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Bar.Plus: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(Bar.Plus, C.Color.B2)
	
	Bar.Plus.Tex = Bar.Plus:CreateTexture(nil, "ARTWORK", 2)
	Bar.Plus.Tex: SetTexture(F.Path("Config_Plus0"))
	Bar.Plus.Tex: SetVertexColor(F.Color(C.Color.W3))
	Bar.Plus.Tex: SetSize(32, 32)
	Bar.Plus.Tex: SetPoint("CENTER", Bar.Plus, "CENTER", 0,0)
	Bar.Plus.Tex: SetAlpha(1)

	Bar.Plus: HookScript("OnEnter", function(self)
		GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip: SetPoint("TOPLEFT", self, "TOPRIGHT", 4,0)
		GameTooltip: SetText(L['NEW'], 1.0, 1.0, 1.0);
		GameTooltip: Show()
	end)
	Bar.Plus: HookScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
	
	return Bar
end

local function Aurawatch_Title(frame, configframe)
	frame.Num = frame.Num + 1
	frame.Bar[frame.Num] = Aurawatch_Title_Template(frame)
end

local function Aurawatch_Create(frame, scroll, sn)
	local Info = frame.Config
	if Info.Show then
		frame.Sn: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	else
		frame.Sn: SetBackdropColor(F.Color(C.Color.W2, 1))
	end
	frame.SnText: SetText(sn)

	if Info.Style then
		if L[Info.Style] then
			frame.StyleText: SetText(L[Info.Style])
		else
			frame.StyleText: SetText(Info.Style)
		end
	else
		frame.StyleText: SetText("")
	end

	if Info.Icon then
		frame.IconTexture: SetTexture(F.Path("Watcher\\"..Info.Icon))
	else
		frame.IconTexture: SetTexture("")
	end

	if Info.Aura then
		if type(Info.Aura) == "table" then
			frame.AuraText: SetText(GetSpellInfo(Info.Aura[1]) or Info.Aura[1])
		else
			frame.AuraText: SetText(GetSpellInfo(Info.Aura) or Info.Aura)
		end
	else
		frame.AuraText: SetText("")
	end
	if Info.AuraColor then
		frame.AuraIndicator: SetBackdropColor(F.Color(Info.AuraColor))
	else
		frame.AuraIndicator: SetBackdropColor(F.Color(C.Color.W2))
	end

	if Info.Spell then
		frame.SpellText: SetText(GetSpellInfo(Info.Spell))
	else
		frame.SpellText: SetText("")
	end
	if Info.SpellColor then
		frame.SpellIndicator: SetBackdropColor(F.Color(Info.SpellColor))
	else
		frame.SpellIndicator: SetBackdropColor(F.Color(C.Color.W2))
	end
end

local function AurawatchScrollBar_Load(frame)
	local classFileName = select(2, UnitClass("player"))
	local specID = (F.IsClassic and 1) or GetSpecialization() or 0
	local WatchNum,FrameNum = 0,0
	if Quafe_DB.Global.AuraWatch[classFileName] and Quafe_DB.Global.AuraWatch[classFileName][specID] then
		for k,v in ipairs(Quafe_DB.Global.AuraWatch[classFileName][specID]) do
			frame.Num = frame.Num + 1
			if not frame.Bar[frame.Num] then
				frame.Bar[frame.Num] = Aurawatch_Template(frame)
			end
			frame.Bar[frame.Num]:Show()
			frame.Bar[frame.Num].Config = v
			frame.Bar[frame.Num].ID = k
			Aurawatch_Create(frame.Bar[frame.Num], frame, k)
		end
		WatchNum = #Quafe_DB.Global.AuraWatch[classFileName][specID] + 1
	end
	FrameNum = #frame.Bar
	if FrameNum > WatchNum then
		for i = (WatchNum+1), FrameNum do
			if i ~= 1 then
				frame.Bar[i]:Hide()
			end
		end
	end
	HoldHeight_Update(frame)
	if #E.FCS_Refresh > 0 then
		for k, v in ipairs(E.FCS_Refresh) do
			v()
		end
	end
end

local function AurawatchList_Update(frame)
	frame.Num = 1
	AurawatchScrollBar_Load(frame)
end

local function Aurawatcher_OnEvent(frame, configframe)
	if F.IsClassic then
	else
		frame: RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
		frame: RegisterEvent("PLAYER_TALENT_UPDATE")
	end
	frame: SetScript("OnEvent", function(self, event)
		AurawatchList_Update(self, configframe)
	end)
	frame.Update = function()
		AurawatchList_Update(frame)
	end
end

----------------------------------------------------------------
--> Add New
local function Aurawatch_AddNew_Sub_Open(frame)
	frame.Case: Show()
	frame.Plus.Tex: SetTexture(F.Path("Config_Plus2"))
	frame: SetHeight(button_size+(button_size+button_gap)*2)
	if frame.Dropdown and frame.Dropdown:IsShown() then
		frame.Dropdown:Hide()
	end
end

local function Aurawatch_AddNew_EidtBox_Template(frame)
	local Box = CreateFrame("EditBox", nil, frame)
	Box: SetAutoFocus(false)
	Box: SetFont(C.Font.Txt, 14, nil)
	Box: SetJustifyH("LEFT")
	Box: SetTextInsets(4, 4, 0, 0)
	Box: SetBackdrop(backdrop)
	Box: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Box: SetBackdropBorderColor(F.Color(C.Color.B1, 0))

	Box: SetScript("OnEscapePressed", function(self)
		self: ClearFocus() 
	end)

	return Box
end

local function Aurawatch_AddNew_Label_Template(frame)
	local Label = frame:CreateFontString(nil, "ARTWORK")
	Label: SetFont(C.Font.Txt, 12, nil)
	Label: SetShadowColor(0,0,0,0.9)
	Label: SetShadowOffset(1,-1)
	Label: SetTextColor(F.Color(C.Color.W3, 0.4))
	Label: SetJustifyH("LEFT")
	Label: SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0,4)

	return Label
end

local function Aurawatch_AddNew_Dropdown_Create(frame)
	local ArrowD = frame:CreateTexture(nil, "ARTWORK", 1)
	ArrowD: SetTexture(F.Path("Config_ArrowDown"))
	ArrowD: SetVertexColor(F.Color(C.Color.W3))
	ArrowD: SetSize(28, 28)
	ArrowD: SetTexCoord(0,1, 0,1)
	ArrowD: SetPoint("RIGHT", frame, "RIGHT", 0,0)
	ArrowD: SetAlpha(1)

	local Dropdown = CreateFrame("Frame", nil, frame)
	Dropdown: SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0,-4)
	Dropdown: SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0,-4)
	Dropdown: SetBackdrop(backdrop)
	Dropdown: SetBackdropColor(F.Color(C.Color.W2, 1))
	Dropdown: SetBackdropBorderColor(F.Color(C.Color.W1, 1))
	Dropdown: Hide()
	Dropdown.Menu = {}

	Dropdown: SetScript("OnLeave", function(self)
		if not MouseIsOver(self) then
			self: Hide()
		end
	end)
	frame.Dropdown = Dropdown
	frame: HookScript("OnHide", function(self)
		self.Dropdown: Hide()
	end)
	frame: HookScript("OnClick", function(self)
		Dropdown_Toggle(frame)
	end)
end

local function AddNew_Dropdown_Menu_Create(frame, button, DB)
	local Text = button: CreateFontString(nil, "ARTWORK")
	Text: SetFont(C.Font.Txt, 14, nil)
	Text: SetShadowColor(0,0,0,0)
	Text: SetShadowOffset(1,-1)
	Text: SetTextColor(F.Color(C.Color.W3))
	Text: SetJustifyH("CENTER")
	Text: SetPoint("CENTER", button, "CENTER", 0, 0)
	button.Text = Text

	local MenuNum = 0
	for k, v in ipairs(DB) do
		if v then
			frame.Menu[k] = CreateFrame("Button", nil, frame)
			frame.Menu[k]: SetHeight(button_size-8)
			frame.Menu[k]: SetFrameLevel(frame:GetFrameLevel()+1)
			frame.Menu[k]: SetBackdrop(backdrop)
			frame.Menu[k]: SetBackdropColor(F.Color(C.Color.B1, 0))
			frame.Menu[k]: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
			if k == 1 then
				frame.Menu[k]: SetPoint("TOPLEFT", frame, "TOPLEFT", 4,-4)
				frame.Menu[k]: SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4,-4)
			else
				frame.Menu[k]: SetPoint("TOPLEFT", frame.Menu[k-1], "BOTTOMLEFT", 0,-2)
				frame.Menu[k]: SetPoint("TOPRIGHT", frame.Menu[k-1], "BOTTOMRIGHT", 0,-2)
			end
			Dropdown_Menu_Artwork(frame.Menu[k])

			frame.Menu[k]: HookScript("OnLeave", function(self)
				if not MouseIsOver(frame) then
					frame: Hide()
				end
			end)
			if v.Text then
				frame.Menu[k].Text: SetText(v.Text)
			end
			if v.Click then
				frame.Menu[k]: SetScript("OnClick", function(self)
					v.Click(self)
					button.Text: SetText(v.Text)
					frame: Hide()
				end)
			end
			MenuNum = MenuNum + 1
		end
	end
	frame: SetHeight((button_size-6)*MenuNum+6)
end

local function AddNew_Dropdown_Color_Create(frame, button, DB)
	local Icon = CreateFrame("Frame", nil, button)
	Icon: SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 40,4)
	Icon: SetPoint("TOPRIGHT", button, "TOPRIGHT", -40,-4)
	Icon: SetBackdrop(backdrop)
	Icon: SetBackdropColor(F.Color(C.Color.B1, 1))
	Icon: SetBackdropBorderColor(F.Color(C.Color.W1, 1))
	button.Icon = Icon

	local MenuNum = 0
	for k, v in ipairs(DB) do
		if v then
			frame.Menu[k] = CreateFrame("Button", nil, frame)
			frame.Menu[k]: SetHeight(button_size-8)
			frame.Menu[k]: SetFrameLevel(frame:GetFrameLevel()+1)
			frame.Menu[k]: SetBackdrop(backdrop)
			frame.Menu[k]: SetBackdropColor(F.Color(C.Color.B1, 0))
			frame.Menu[k]: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
			if k == 1 then
				frame.Menu[k]: SetPoint("TOPLEFT", frame, "TOPLEFT", 4,-4)
				frame.Menu[k]: SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4,-4)
			else
				frame.Menu[k]: SetPoint("TOPLEFT", frame.Menu[k-1], "BOTTOMLEFT", 0,-2)
				frame.Menu[k]: SetPoint("TOPRIGHT", frame.Menu[k-1], "BOTTOMRIGHT", 0,-2)
			end
			Dropdown_Menu_Artwork(frame.Menu[k])

			frame.Menu[k].Icon = CreateFrame("Frame", nil, frame.Menu[k])
			frame.Menu[k].Icon: SetPoint("BOTTOMLEFT", frame.Menu[k], "BOTTOMLEFT", 36,2)
			frame.Menu[k].Icon: SetPoint("TOPRIGHT", frame.Menu[k], "TOPRIGHT", -36,-2)
			frame.Menu[k].Icon: SetBackdrop(backdrop)
			frame.Menu[k].Icon: SetBackdropColor(F.Color(v, 1))
			frame.Menu[k].Icon: SetBackdropBorderColor(F.Color(C.Color.W1, 1))

			frame.Menu[k]: HookScript("OnLeave", function(self)
				if not MouseIsOver(frame) then
					frame: Hide()
				end
			end)
			frame.Menu[k]: SetScript("OnClick", function(self)
				button.ID = v
				button.Icon: SetBackdropColor(F.Color(v))
				frame: Hide()
			end)

			MenuNum = MenuNum + 1
		end
	end
	frame: SetHeight((button_size-6)*MenuNum+6)
end

local function IconButton_Frame(frame, pos)
	local TextIcon = frame: CreateTexture()
	TextIcon: SetSize(button_size,button_size)
	TextIcon: SetPoint("LEFT", frame, "LEFT", 4,0)

	local Text = frame: CreateFontString(nil, "ARTWORK")
	Text: SetFont(C.Font.NumSmall, 14, nil)
	Text: SetShadowColor(0,0,0,0)
	Text: SetShadowOffset(1,-1)
	Text: SetTextColor(F.Color(C.Color.W3))
	Text: SetJustifyH("CENTER")
	Text: SetJustifyV("CENTER")
	Text: SetPoint("TOPLEFT", frame, "TOPLEFT", button_size+4, -1)
	Text: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 0)

	local IconSelect = CreateFrame("Frame", nil, frame)
	IconSelect: SetFrameLevel(frame:GetFrameLevel())
	IconSelect: SetHeight(ceil(#C.WatcherIcon/20)*32+8)
	IconSelect: SetPoint("TOPLEFT", pos, "BOTTOMLEFT", -1, -button_gap*4)
	IconSelect: SetPoint("TOPRIGHT", pos, "BOTTOMRIGHT", 1, -button_gap*4)
	IconSelect: SetBackdrop({
		bgFile = F.Path("White"),
		edgeFile = F.Path("White"),
		tile = true, tileSize = 16, edgeSize = 2,
		insets = {left = -1, right = -1, top = -1, bottom = -1}
	})
	IconSelect: SetBackdropColor(F.Color(C.Color.W1, 0.95))
	IconSelect: SetBackdropBorderColor(F.Color(C.Color.B1, 0.75))

	local ICON_NUM = #C.WatcherIcon
	local IconHold = CreateFrame("Frame", nil, IconSelect)
	IconHold: SetFrameLevel(IconSelect:GetFrameLevel())
	IconHold: SetSize(640, ceil(ICON_NUM/20)*32)
	IconHold: SetPoint("TOP", IconSelect, "TOP", 0,-4)
	local IconMatrix = {}
	for k, v in ipairs(C.WatcherIcon) do
		IconMatrix[k] = CreateFrame("Button", nil, IconHold)
		IconMatrix[k]: SetFrameLevel(IconHold:GetFrameLevel())
		IconMatrix[k]: SetSize(28,28)
		IconMatrix[k]: SetBackdrop(backdrop)
		IconMatrix[k]: SetBackdropColor(F.Color(C.Color.B1, 0))
		IconMatrix[k]: SetBackdropBorderColor(F.Color(C.Color.W2, 0.75))
		ButtonHighLight_Create(IconMatrix[k], C.Color.B2)

		if k == 1 then
			IconMatrix[k]: SetPoint("TOPLEFT", IconHold, "TOPLEFT", 2,-2)
		elseif mod(k,20) == 1 then
			IconMatrix[k]: SetPoint("CENTER", IconMatrix[k-20], "CENTER", 0,-32)
		else
			IconMatrix[k]: SetPoint("CENTER", IconMatrix[k-1], "CENTER", 32,0)
		end

		IconMatrix[k].Tex = IconMatrix[k]: CreateTexture(nil, "ARTWORK")
		IconMatrix[k].Tex: SetSize(32,32)
		IconMatrix[k].Tex: SetPoint("CENTER", IconMatrix[k], "CENTER", 0,0)
		IconMatrix[k].Tex: SetTexture(F.Path("Watcher\\"..v))
		IconMatrix[k].ID = v

		IconMatrix[k]: SetScript("OnClick", function(self, button)
			frame.ID = self.ID
			TextIcon: SetTexture(F.Path("Watcher\\"..frame.ID))
			Text: SetText(frame.ID)
			IconSelect: Hide()
		end)
	end

	frame: SetScript("OnClick", function(self, button)
		if IconSelect:IsShown() then
			IconSelect: Hide()
		else
			IconSelect: Show()
		end
	end)
	frame: HookScript("OnHide", function(self)
		IconSelect: Hide()
	end)

	frame.IconSelect = IconSelect
	frame.TextIcon = TextIcon
	frame.Text = Text
	IconSelect: Hide()
end

local function Style_Dropdown_Menu_Create(frame)
	local DB = {}
	for k,v in ipairs(E.AurawatchStyle) do
		DB[k] = {
			Text = L[v],
			Click = function(self, button)
				frame.ID = v
			end,
		}
	end
	AddNew_Dropdown_Menu_Create(frame.Dropdown, frame, DB)
end

local function Unit_Dropdown_Menu_Create(frame)
	local DB = {
		[1] = {
			Text = L['PLAYER'],
			Click = function(self, button)
				frame.ID = "player"
			end,
		},
		[2] = {
			Text = L['TARGET'],
			Click = function(self, button)
				frame.ID = "target"
			end,
		},
		[3] = {
			Text = L['PET'],
			Click = function(self, button)
				frame.ID = "pet"
			end,
		},
		[4] = {
			Text = L['FOCUS'],
			Click = function(self, button)
				frame.ID = "focus"
			end,
		},
	}
	AddNew_Dropdown_Menu_Create(frame.Dropdown, frame, DB)
end

local function Caster_Dropdown_Menu_Create(frame)
	local DB = {
		[1] = {
			Text = L['ALL_UNIT'],
			Click = function(self, button)
				frame.ID = "ALL_UNIT"
			end,
		},
		[2] = {
			Text = L['PLAYER'],
			Click = function(self, button)
				frame.ID = "player"
			end,
		},
		[3] = {
			Text = L['TARGET'],
			Click = function(self, button)
				frame.ID = "target"
			end,
		},
		[4] = {
			Text = L['PET'],
			Click = function(self, button)
				frame.ID = "pet"
			end,
		},
		[5] = {
			Text = L['FOCUS'],
			Click = function(self, button)
				frame.ID = "focus"
			end,
		},
	}
	AddNew_Dropdown_Menu_Create(frame.Dropdown, frame, DB)
end

local function Color_Dropdown_Menu_Create(frame)
	local DB = {
		C.Color.Bar["E31D4E"],
		C.Color.Bar["CE3176"],
		C.Color.R3,
		C.Color.Bar["F5512C"],
		C.Color.Y1,
		{r = 224, g = 210, b = 134,},
		{r = 152, g = 181, b = 124,},
		C.Color.G2,
		C.Color.Bar["95DEE4"],
		C.Color.B1,
		{r =   8, g = 108, b = 128,},
		C.Color.Bar["6131FF"],
	}
	--AddNew_Dropdown_Color_Create(frame.Dropdown, frame, DB)
	AddNew_Dropdown_Color_Create(frame.Dropdown, frame, C.Color.Matrix)
end

local function Aurawatch_AddNew_Buttons_GapTemplate(frame)
	local Gap = frame:CreateTexture(nil, "BACKGROUND")
	Gap: SetTexture(F.Path("White"))
	Gap: SetVertexColor(F.Color(C.Color.W2))
	Gap: SetAlpha(0.7)
	Gap: SetSize(2, 180)

	local Text = frame:CreateFontString(nil, "ARTWORK")
	Text: SetFont(C.Font.NumSmall, 20, nil)
	Text: SetShadowColor(0,0,0,0)
	Text: SetShadowOffset(1,-1)
	Text: SetTextColor(F.Color(C.Color.W3, 0.4))
	Text: SetJustifyH("LEFT")
	Text: SetPoint("TOPLEFT", Gap, "TOPLEFT", 10, 0)

	Gap.Text = Text

	return Gap
end

local function Aurawatch_AddNew_Buttons(frame)
	local BUTTON_WIDTH = 160
	local ButtonHold = CreateFrame("Frame", nil, frame)
	ButtonHold: SetSize(80+BUTTON_WIDTH*4+40,180)
	ButtonHold: SetPoint("CENTER", frame, "CENTER", 0)

	local Gap1 = Aurawatch_AddNew_Buttons_GapTemplate(ButtonHold)
	Gap1: SetPoint("CENTER", ButtonHold, "LEFT", 0,0)
	Gap1.Text: SetText("Type")

	local Gap2 = Aurawatch_AddNew_Buttons_GapTemplate(ButtonHold)
	Gap2: SetPoint("CENTER", ButtonHold, "LEFT", BUTTON_WIDTH+20+40,0)
	Gap2.Text: SetText("Aura")

	local Gap3 = Aurawatch_AddNew_Buttons_GapTemplate(ButtonHold)
	Gap3: SetPoint("CENTER", ButtonHold, "LEFT", (BUTTON_WIDTH+20)*3+40,0)
	Gap3.Text: SetText("Spell")

	local Gap4 = Aurawatch_AddNew_Buttons_GapTemplate(ButtonHold)
	Gap4: SetPoint("CENTER", ButtonHold, "RIGHT", 0,0)

	local TypeButton = CreateFrame("Button", nil, frame)
	TypeButton: SetSize(BUTTON_WIDTH+40, button_size-4)
	TypeButton: SetPoint("LEFT", ButtonHold, "LEFT", 10,10)
	TypeButton: SetBackdrop(backdrop)
	TypeButton: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	TypeButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	TypeButton.ID = nil
	ButtonHighLight_Create(TypeButton, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(TypeButton)
	Style_Dropdown_Menu_Create(TypeButton)

	local IconButton = CreateFrame("Button", nil, frame)
	IconButton: SetSize(BUTTON_WIDTH+40, button_size-4)
	IconButton: SetPoint("CENTER", TypeButton, "CENTER", 0,-60)
	IconButton: SetBackdrop(backdrop)
	IconButton: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	IconButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	IconButton.ID = nil
	ButtonHighLight_Create(IconButton, C.Color.B2)
	IconButton_Frame(IconButton, ButtonHold)

	local AuraButton = Aurawatch_AddNew_EidtBox_Template(frame)
	AuraButton: SetSize(BUTTON_WIDTH, button_size-4)
	AuraButton: SetPoint("LEFT", ButtonHold, "LEFT", (BUTTON_WIDTH+20)+10+40,10)
	AuraButton.ID = nil
	ButtonHighLight_Create(AuraButton, C.Color.B2)

	local AuraColor = CreateFrame("Button", nil, frame)
	AuraColor: SetSize(BUTTON_WIDTH, button_size-4)
	AuraColor: SetPoint("CENTER", AuraButton, "CENTER", 0,-60)
	AuraColor: SetBackdrop(backdrop)
	AuraColor: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	AuraColor: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	AuraColor.ID = nil
	ButtonHighLight_Create(AuraColor, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(AuraColor)
	Color_Dropdown_Menu_Create(AuraColor)

	local AuraUnit = CreateFrame("Button", nil, frame)
	AuraUnit: SetSize(BUTTON_WIDTH, button_size-4)
	AuraUnit: SetPoint("LEFT", ButtonHold, "LEFT", (BUTTON_WIDTH+20)*2+10+40,10)
	AuraUnit: SetBackdrop(backdrop)
	AuraUnit: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	AuraUnit: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	AuraUnit.ID = nil
	ButtonHighLight_Create(AuraUnit, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(AuraUnit)
	Unit_Dropdown_Menu_Create(AuraUnit)

	local AuraCaster = CreateFrame("Button", nil, frame)
	AuraCaster: SetSize(BUTTON_WIDTH, button_size-4)
	AuraCaster: SetPoint("CENTER", AuraUnit, "CENTER", 0,-60)
	AuraCaster: SetBackdrop(backdrop)
	AuraCaster: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	AuraCaster: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	AuraCaster.ID = nil
	ButtonHighLight_Create(AuraCaster, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(AuraCaster)
	Caster_Dropdown_Menu_Create(AuraCaster)

	local SpellButton = Aurawatch_AddNew_EidtBox_Template(frame)
	SpellButton: SetSize(BUTTON_WIDTH, button_size-4)
	SpellButton: SetPoint("LEFT", ButtonHold, "LEFT",(BUTTON_WIDTH+20)*3+10+40,10)
	SpellButton.ID = nil
	ButtonHighLight_Create(SpellButton, C.Color.B2)

	local SpellColor = CreateFrame("Button", nil, frame)
	SpellColor: SetSize(BUTTON_WIDTH, button_size-4)
	SpellColor: SetPoint("CENTER", SpellButton, "CENTER", 0,-60)
	SpellColor: SetBackdrop(backdrop)
	SpellColor: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	SpellColor: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	SpellColor.ID = nil
	ButtonHighLight_Create(SpellColor, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(SpellColor)
	Color_Dropdown_Menu_Create(SpellColor)
	
	local TypeLabel = Aurawatch_AddNew_Label_Template(TypeButton)
	TypeLabel: SetText(L["STYLE"])
	local IconLabel = Aurawatch_AddNew_Label_Template(IconButton)
	IconLabel: SetText(L['ICON'])

	local AuraLabel = Aurawatch_AddNew_Label_Template(AuraButton)
	AuraLabel: SetText(L["AURA"])
	local AuraColorLabel = Aurawatch_AddNew_Label_Template(AuraColor)
	AuraColorLabel: SetText(L["COLOR"])
	local AuraUnitLabel = Aurawatch_AddNew_Label_Template(AuraUnit)
	AuraUnitLabel: SetText(L["UNIT"])
	local AuraCasterLabel = Aurawatch_AddNew_Label_Template(AuraCaster)
	AuraCasterLabel: SetText(L["CASTER"])

	local SpellLabel = Aurawatch_AddNew_Label_Template(SpellButton)
	SpellLabel: SetText(L["SPELL"])
	local SpellColorLabel = Aurawatch_AddNew_Label_Template(SpellColor)
	SpellColorLabel: SetText(L["COLOR"])

	frame.ButtonHold = ButtonHold
	frame.Style = TypeButton
	frame.Icon = IconButton
	frame.Aura = AuraButton
	frame.AuraColor = AuraColor
	frame.AuraUnit = AuraUnit
	frame.AuraCaster = AuraCaster
	frame.Spell = SpellButton
	frame.SpellColor = SpellColor 
end

local function StringFix(text)
	if text then
		text = string.gsub(text, "^%s*(.-)%s*$", "%1")
		if (text == "" or text == " " or text == "  ") then
			text = nil
		end
	end

	return text
end

local function Aurawatch_AddNew_OnClick(self, button, frame, NUM)
	frame.Aura.ID = StringFix(frame.Aura:GetText())
	frame.Spell.ID = StringFix(frame.Spell:GetText())

	local classFileName = select(2, UnitClass("player"))
	local specID = (F.IsClassic and 1) or GetSpecialization() or 0
	if not Quafe_DB.Global.AuraWatch[classFileName] then
		Quafe_DB.Global.AuraWatch[classFileName] = {}
	end
	if not Quafe_DB.Global.AuraWatch[classFileName][specID] then
		Quafe_DB.Global.AuraWatch[classFileName][specID] = {}
	end
	if not NUM then
		NUM = #Quafe_DB.Global.AuraWatch[classFileName][specID] + 1
	end

	if frame.Aura.ID then
		local AuraString = frame.Aura.ID
		local AuraNum = tonumber(frame.Aura.ID)
		if (not AuraNum) then
			AuraString = gsub(AuraString, "；", ";")
			if strfind(AuraString, ";") then
				AuraString = AuraString..";"
				local AuraTable = {}
				for t in gmatch(AuraString, "(.-);") do
					t = StringFix(t)
					tinsert(AuraTable, t)
				end
				frame.Aura.ID = AuraTable
			end
			AuraString = gsub(AuraString, "，", ",")
			if strfind(AuraString, ",") then
				AuraString = AuraString..","
				local AuraTable = {}
				for t in gmatch(AuraString, "(.-),") do
					t = StringFix(t)
					tinsert(AuraTable, t)
				end
				frame.Aura.ID = AuraTable[1]
				frame.Aura.ID2 = AuraTable[2]
			end
		end
		if not Quafe_DB.Global.AuraWatch[classFileName][specID][NUM] then
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM] = {}
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Show = true
		end
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Aura = frame.Aura.ID
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Aura2 = frame.Aura.ID2
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].AuraColor = frame.AuraColor.ID
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Unit = frame.AuraUnit.ID
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Caster = frame.AuraCaster.ID
	else
		if Quafe_DB.Global.AuraWatch[classFileName][specID][NUM] then
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Aura = nil
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Aura2 = nil
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].AuraColor = nil
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Unit = nil
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Caster = nil
		end
	end
	if frame.Spell.ID then
		if not Quafe_DB.Global.AuraWatch[classFileName][specID][NUM] then
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM] = {}
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Show = true
		end
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Spell = frame.Spell.ID
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].SpellColor = frame.SpellColor.ID
	else
		if Quafe_DB.Global.AuraWatch[classFileName][specID][NUM] then
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Spell = nil
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].SpellColor = nil
		end
	end
	if frame.Aura.ID or frame.Spell.ID then
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Style = frame.Style.ID
		Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Icon = frame.Icon.ID
	else
		if Quafe_DB.Global.AuraWatch[classFileName][specID][NUM] then
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Style = nil
			Quafe_DB.Global.AuraWatch[classFileName][specID][NUM].Icon = nil
		end
	end
end

local function Aurawatch_AddNew_Artwork(frame, scroll, configframe)
	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.W1))
	Bg: SetAlpha(0.95)
	Bg: SetAllPoints(frame)
	
	local TopBorder = frame: CreateTexture(nil, "BORDER")
	TopBorder: SetTexture(F.Path("White"))
	TopBorder: SetVertexColor(F.Color(C.Color.B1))
	TopBorder: SetAlpha(0.75)
	TopBorder: SetHeight(2)
	TopBorder: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,-1)
	TopBorder: SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,-1)

	local BottomBorder = frame: CreateTexture(nil, "BORDER")
	BottomBorder: SetTexture(F.Path("White"))
	BottomBorder: SetVertexColor(F.Color(C.Color.B1))
	BottomBorder: SetAlpha(0.75)
	BottomBorder: SetHeight(2)
	BottomBorder: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,1)
	BottomBorder: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,1)

	for i = 1,3 do
		local Button = CreateFrame("Button", nil, frame)
		Button: SetSize(120,60)

		local ButtonBg = Button:CreateTexture(nil, "BACKGROUND")
		ButtonBg: SetTexture(F.Path("White"))
		ButtonBg: SetVertexColor(F.Color(C.Color.B1))
		ButtonBg: SetAllPoints(Button)

		local ButtonTxt = Button: CreateFontString(nil, "ARTWORK")
		ButtonTxt: SetFont(C.Font.Txt, 18, nil)
		ButtonTxt: SetShadowColor(0,0,0,0.9)
		ButtonTxt: SetShadowOffset(1,-1)
		ButtonTxt: SetTextColor(F.Color(C.Color.W3))
		ButtonTxt: SetPoint("CENTER", Button, "CENTER", 0, 0)

		Button.Bg = ButtonBg
		Button.Txt = ButtonTxt
		frame["Button"..i] = Button
	end

	frame.Button1: SetPoint("TOPLEFT", frame.ButtonHold, "RIGHT", 40, -4)
	frame.Button1.Bg: SetVertexColor(F.Color(C.Color.B1, 0.7))
	frame.Button1.Txt: SetText(L['CANCEL'])
	ButtonHighLight_Create(frame.Button1, C.Color.B2)
	frame.Button1: SetScript("OnClick", function(self, button)
		frame:Hide()
	end)

	frame.Button2: SetPoint("BOTTOMLEFT", frame.ButtonHold, "RIGHT", 40, 4)
	frame.Button2.Bg: SetVertexColor(F.Color(C.Color.Y1, 0.8))
	frame.Button2.Txt: SetText(L['ADD'])
	ButtonHighLight_Create(frame.Button2, C.Color.Y1)
	frame.Button2: SetScript("OnClick", function(self, button)
		Aurawatch_AddNew_OnClick(self, button, frame, frame.ID)
		scroll.Update()
		frame: Hide()
	end)

	frame.Button3: SetPoint("BOTTOMRIGHT", frame, "RIGHT", -40, 4)
	frame.Button3.Bg: SetVertexColor(F.Color(C.Color.R3, 0.7))
	frame.Button3.Txt: SetText(L['DELETE'])
	ButtonHighLight_Create(frame.Button3, C.Color.R3)
	frame.Button3: SetScript("OnClick", function(self, button)
		local classFileName = select(2, UnitClass("player"))
		local specID = (F.IsClassic and 1) or GetSpecialization() or 0
		tremove(Quafe_DB.Global.AuraWatch[classFileName][specID], frame.ID)
		scroll.Update()
		frame: Hide()
	end)

	--frame.Title1 = Title1
	--frame.Title2 = Title2
end

local function Aurawatch_AddNew_OnShow(frame)
	local classFileName = select(2, UnitClass("player"))
	local specID = (F.IsClassic and 1) or GetSpecialization() or 0
	if frame.ID then
		local Info = Quafe_DB.Global.AuraWatch[classFileName][specID][frame.ID]
		frame.Style.ID = Info.Style
		frame.Icon.ID = Info.Icon
		frame.Aura.ID = Info.Aura
		frame.Aura.ID2 = Info.Aura2
		frame.AuraColor.ID = Info.AuraColor
		frame.AuraUnit.ID = Info.Unit
		frame.AuraCaster.ID = Info.Caster
		frame.Spell.ID = Info.Spell
		frame.SpellColor.ID = Info.SpellColor
		frame.Button2.Txt: SetText(L['CONFIRM'])
		frame.Button3:Show()
	else
		frame.Style.ID = nil
		frame.Icon.ID = nil
		frame.Aura.ID = nil
		frame.Aura.ID2 = nil
		frame.AuraColor.ID = nil
		frame.AuraUnit.ID = nil
		frame.AuraCaster.ID = nil
		frame.Spell.ID = nil
		frame.SpellColor.ID = nil
		frame.Button2.Txt: SetText(L['ADD'])
		frame.Button3:Hide()
	end
	if frame.Style.ID and L[frame.Style.ID] then
		frame.Style.Text: SetText(L[frame.Style.ID])
	else
		frame.Style.Text: SetText("")
	end
	if frame.Icon.ID then
		frame.Icon.Text: SetText(frame.Icon.ID)
		frame.Icon.TextIcon: SetTexture(F.Path("Watcher\\"..frame.Icon.ID))
	else
		frame.Icon.Text: SetText("")
		frame.Icon.TextIcon: SetTexture("")
	end
	if frame.Aura.ID then
		if type(frame.Aura.ID) == "table" then
			local LIST = {}
			table.foreach(frame.Aura.ID, function(k,v) tinsert(LIST, v..";") end)
			frame.Aura: SetText(table.concat(LIST))
		elseif frame.Aura.ID2 then
			frame.Aura: SetText(frame.Aura.ID..","..frame.Aura.ID2)
		else
			frame.Aura: SetText(frame.Aura.ID)
		end
	else
		frame.Aura: SetText("")
	end
	if frame.AuraColor.ID then
		frame.AuraColor.Icon: SetBackdropColor(F.Color(frame.AuraColor.ID))
	else
		frame.AuraColor.Icon: SetBackdropColor(F.Color(C.Color.W1))
	end
	if frame.AuraUnit.ID then
		frame.AuraUnit.Text: SetText(L[strupper(frame.AuraUnit.ID)])
	else
		frame.AuraUnit.Text: SetText("")
	end
	if frame.AuraCaster.ID then
		frame.AuraCaster.Text: SetText(L[strupper(frame.AuraCaster.ID)])
	else
		frame.AuraCaster.Text: SetText("")
	end
	if frame.Spell.ID then
		frame.Spell: SetText(frame.Spell.ID)
	else
		frame.Spell: SetText("")
	end
	if frame.SpellColor.ID then
		frame.SpellColor.Icon: SetBackdropColor(F.Color(frame.SpellColor.ID))
	else
		frame.SpellColor.Icon: SetBackdropColor(F.Color(C.Color.W1))
	end
end

local function Aurawatch_AddNew(frame, configframe)
	local NewWatcher = CreateFrame("Frame", "Quafe_AuraWatcher_NewWacher", frame)
	NewWatcher: SetFrameStrata("FULLSCREEN" )
	NewWatcher: SetHeight(200)
	NewWatcher: SetPoint("LEFT", UIParent, "LEFT", 0,0)
	NewWatcher: SetPoint("RIGHT", UIParent, "RIGHT", 0,0)
	NewWatcher: Hide()
	NewWatcher.ID = nil
	tinsert(UISpecialFrames, "Quafe_AuraWatcher_NewWacher")

	Aurawatch_AddNew_Buttons(NewWatcher)
	Aurawatch_AddNew_Artwork(NewWatcher, frame, configframe)

	NewWatcher: SetScript("OnShow", Aurawatch_AddNew_OnShow)
	
	frame.Bar[1].Plus.Tex: SetTexture(F.Path("Config_Plus1"))
	frame.Bar[1].Plus: SetScript("OnClick", function(self)
		NewWatcher.ID = nil
		NewWatcher:Show()
	end)
	frame.NewWatcher = NewWatcher
end

--- ------------------------------------------------------------
--> Color Pick Frame
--- ------------------------------------------------------------

local function UDF_ColorPick_Buttons(frame)
	local BUTTON_WIDTH = 160
	local ButtonHold = CreateFrame("Frame", nil, frame)
	ButtonHold: SetSize(80+BUTTON_WIDTH*4,180)
	ButtonHold: SetPoint("CENTER", frame, "CENTER", 0)

	local Color1 = CreateFrame("Button", nil, frame)
	Color1: SetSize(BUTTON_WIDTH, button_size-4)
	Color1: SetPoint("LEFT", ButtonHold, "LEFT", 10,10)
	Color1: SetBackdrop(backdrop)
	Color1: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Color1: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	Color1.ID = nil
	ButtonHighLight_Create(Color1, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(Color1)
	Color_Dropdown_Menu_Create(Color1)

	local Color2 = CreateFrame("Button", nil, frame)
	Color2: SetSize(BUTTON_WIDTH, button_size-4)
	Color2: SetPoint("LEFT", ButtonHold, "LEFT", (BUTTON_WIDTH+20)+10,10)
	Color2: SetBackdrop(backdrop)
	Color2: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Color2: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	Color2.ID = nil
	ButtonHighLight_Create(Color2, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(Color2)
	Color_Dropdown_Menu_Create(Color2)

	local Color3 = CreateFrame("Button", nil, frame)
	Color3: SetSize(BUTTON_WIDTH, button_size-4)
	Color3: SetPoint("LEFT", ButtonHold, "LEFT", (BUTTON_WIDTH+20)*2+10,10)
	Color3: SetBackdrop(backdrop)
	Color3: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Color3: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	Color3.ID = nil
	ButtonHighLight_Create(Color3, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(Color3)
	Color_Dropdown_Menu_Create(Color3)

	local Color4 = CreateFrame("Button", nil, frame)
	Color4: SetSize(BUTTON_WIDTH, button_size-4)
	Color4: SetPoint("LEFT", ButtonHold, "LEFT", (BUTTON_WIDTH+20)*3+10,10)
	Color4: SetBackdrop(backdrop)
	Color4: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Color4: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	Color4.ID = nil
	ButtonHighLight_Create(Color4, C.Color.B2)
	Aurawatch_AddNew_Dropdown_Create(Color4)
	Color_Dropdown_Menu_Create(Color4)

	for i = 1,2 do
		local Button = CreateFrame("Button", nil, frame)
		Button: SetSize(104,42)

		local ButtonBg = Button:CreateTexture(nil, "BACKGROUND")
		ButtonBg: SetTexture(F.Path("White"))
		ButtonBg: SetVertexColor(F.Color(C.Color.B1))
		ButtonBg: SetAllPoints(Button)

		local ButtonTxt = Button: CreateFontString(nil, "ARTWORK")
		ButtonTxt: SetFont(C.Font.Txt, 18, nil)
		ButtonTxt: SetShadowColor(0,0,0,0)
		ButtonTxt: SetShadowOffset(1,-1)
		ButtonTxt: SetTextColor(F.Color(C.Color.W3))
		ButtonTxt: SetPoint("CENTER", Button, "CENTER", 0, 0)

		Button.Bg = ButtonBg
		Button.Txt = ButtonTxt
		frame["Button"..i] = Button
	end

	frame.Button1: SetPoint("BOTTOMRIGHT", frame, "BOTTOM", -12, 12)
	frame.Button1.Bg: SetVertexColor(F.Color(C.Color.B1, 0.7))
	frame.Button1.Txt: SetText(L['CANCEL'])
	frame.Button1: SetScript("OnClick", function(self)
		frame: Hide()
		--Quafe_Config: Show()
	end)

	frame.Button2: SetPoint("BOTTOMLEFT", frame, "BOTTOM", -8, 12)
	frame.Button2: SetWidth(128)
	frame.Button2.Bg: SetVertexColor(F.Color(C.Color.Y1, 0.9))
	frame.Button2.Txt: SetText(L['CONFIRM'])
	frame.Button2: SetScript("OnClick", function(self)
		frame: Hide()
		--Quafe_Config: Show()
		Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main1 = Color1.ID
		Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main2 = Color2.ID
		Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main3 = Color3.ID
		Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Warn1 = Color4.ID
		Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.State = "UD"
		Quafe_NoticeReload()
	end)

	frame: SetScript("OnShow", function(self)
		Color1.ID = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main1
		Color2.ID = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main2
		Color3.ID = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main3
		Color4.ID = Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Warn1
		Color1.Icon: SetBackdropColor(F.Color(Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main1))
		Color2.Icon: SetBackdropColor(F.Color(Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main2))
		Color3.Icon: SetBackdropColor(F.Color(Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Main3))
		Color4.Icon: SetBackdropColor(F.Color(Quafe_DB.Profile[Quafe_DBP.Profile].Quafe_Color.Warn1))
	end)
end

local function UDF_ColorPick_Artwork(frame)
	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.W1))
	Bg: SetAlpha(0.95)
	Bg: SetAllPoints(frame)
	
	local TopBorder = frame: CreateTexture(nil, "BORDER")
	TopBorder: SetTexture(F.Path("White"))
	TopBorder: SetVertexColor(F.Color(C.Color.B1))
	TopBorder: SetAlpha(0.75)
	TopBorder: SetHeight(2)
	TopBorder: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,-1)
	TopBorder: SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,-1)

	local BottomBorder = frame: CreateTexture(nil, "BORDER")
	BottomBorder: SetTexture(F.Path("White"))
	BottomBorder: SetVertexColor(F.Color(C.Color.B1))
	BottomBorder: SetAlpha(0.75)
	BottomBorder: SetHeight(2)
	BottomBorder: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,1)
	BottomBorder: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,1)
end

local function UDF_ColorPick_Create(frame)
	local ColorPick = CreateFrame("Frame", "Quafe_UDF_ColorPick", frame)
	ColorPick: SetFrameStrata("FULLSCREEN" )
	ColorPick: SetHeight(200)
	ColorPick: SetPoint("LEFT", UIParent, "LEFT", 0,0)
	ColorPick: SetPoint("RIGHT", UIParent, "RIGHT", 0,0)
	ColorPick: Hide()
	ColorPick.ID = nil
	tinsert(UISpecialFrames, "Quafe_UDF_ColorPick")

	UDF_ColorPick_Artwork(ColorPick)
	UDF_ColorPick_Buttons(ColorPick)
end

----------------------------------------------------------------
--> Hotkey Button
----------------------------------------------------------------

local function Hotkey_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame.Hold)
	Bar: SetSize(720, button_size)
	if frame.Num == 1 then
		Bar: SetPoint("TOP", frame.Hold, "TOP", 0,-2)
	else
		Bar: SetPoint("TOP", frame.Bar[frame.Num-1], "BOTTOM", 0,-button_gap)
	end

	return Bar
end

local function HotKey_SaveBindings()
	if F.IsClassic then
		return AttemptToSaveBindings(GetCurrentBindingSet())
	else
		return SaveBindings(GetCurrentBindingSet())
	end
end

local function Hotkey_Button(frame)
	frame.Binding = false
	frame.Key = nil

	local Text = frame:CreateFontString(nil, "ARTWORK")
	Text: SetFont(C.Font.Num, 14, nil)
	Text: SetShadowColor(0,0,0,0)
	Text: SetShadowOffset(1,-1)
	Text: SetTextColor(F.Color(C.Color.W3))
	Text: SetPoint("CENTER", frame, "CENTER", 0, 0)

	frame.Text = Text

	local BUTTON_KEYS = {
		["MiddleButton"] = "BUTTON3",
		["Button4"] = "BUTTON4",
		["Button5"] = "BUTTON5",
	}

	frame: RegisterForClicks("AnyUp")
	frame: EnableMouse(true)
	frame: SetScript("OnClick", function(self, button)
		if button == "LeftButton" then
			if frame.Binding == false then
				frame.Binding = true
				--self: EnableMouse(true)
				self: EnableKeyboard(true)
				self: SetBackdropBorderColor(F.Color(C.Color.W3, 0.7))
			else
				self.Binding = false
				--self: EnableMouse(false)
				self: EnableKeyboard(false)
				self: SetBackdropBorderColor(F.Color(C.Color.W3, 0))
			end
		elseif button == "RightButton" then
			local key1, key2 = GetBindingKey("QUAFE_COMMUNICATIONMENU")
			if self.ID == 1 then
				SetBinding(key1)
				HotKey_SaveBindings()
			elseif self.ID == 2 then
				SetBinding(key2)
				HotKey_SaveBindings()
			end
		end
	end)
	frame: SetScript("OnKeyDown", function(self, key)
		if key ~= "SHIFT" and key ~= "CTRL" or key ~= "ALT" then
			if key ~= "ESCAPE" then
				local aShiftKeyIsDown = IsShiftKeyDown();
				local aAltKeyIsDown = IsAltKeyDown();
				local aCtrlKeyIsDown = IsControlKeyDown();
				if aShiftKeyIsDown then
					self.Key = "SHIFT-"..key
				elseif aCtrlKeyIsDown then
					self.Key = "CTRL-"..key
				elseif aAltKeyIsDown then
					self.Key = "ALT-"..key
				else
					self.Key = key
				end
				SetBinding(self.Key, "QUAFE_COMMUNICATIONMENU", self.ID)
				HotKey_SaveBindings()
			end
			self.Binding = false
			--self: EnableMouse(false)
			self: EnableKeyboard(false)
			self: SetBackdropBorderColor(F.Color(C.Color.W3, 0))
		end
	end)
	frame: SetScript("OnMouseDown", function(self, button)
		if button ~= "LeftButton" and button ~= "RightButton" then
			--"ALT-CTRL-SHIFT-Q", "BUTTON5"
			local aShiftKeyIsDown = IsShiftKeyDown();
			local aAltKeyIsDown = IsAltKeyDown();
			local aCtrlKeyIsDown = IsControlKeyDown();
			local key = BUTTON_KEYS[button]
			if not key then
				return
			end
			if aShiftKeyIsDown then
				self.Key = "SHIFT-"..BUTTON_KEYS[button]
			elseif aCtrlKeyIsDown then
				self.Key = "CTRL-"..BUTTON_KEYS[button]
			elseif aAltKeyIsDown then
				self.Key = "ALT-"..BUTTON_KEYS[button]
			else
				self.Key = BUTTON_KEYS[button]
			end
			self.Binding = false
			--self: EnableMouse(false)
			self: EnableKeyboard(false)
			self: SetBackdropBorderColor(F.Color(C.Color.W3, 0))
			SetBinding(self.Key, "QUAFE_COMMUNICATIONMENU", self.ID)
			HotKey_SaveBindings()
			--self.Text: SetText(self.Key)
		end
	end)
end

local function Hotkey_Create(frame, scroll, configframe)
	frame: RegisterEvent("UPDATE_BINDINGS")
	frame: RegisterEvent("PLAYER_ENTERING_WORLD")
	local Info = frame.Config

	local Bg = frame: CreateTexture(nil, "BACKGROUND", 1)
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.W2))
	Bg: SetSize(460, button_size)
	Bg: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
	Bg: SetAlpha(1)

	local Name = frame:CreateFontString(nil, "ARTWORK")
	Name: SetFont(C.Font.Txt, 14, nil)
	Name: SetShadowColor(0,0,0,0)
	Name: SetShadowOffset(1,-1)
	Name: SetTextColor(F.Color(C.Color.W3))
	Name: SetJustifyH("LEFT")
	Name: SetPoint("LEFT", Bg, "LEFT", 20, 0)
	Name: SetText(Info.Name)
	
	local Primary = CreateFrame("Button", nil, frame)
	Primary: SetSize(124, button_size)
	Primary: SetPoint("RIGHT", frame, "RIGHT", -130,0)
	Primary: SetBackdrop(backdrop)
	Primary: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Primary: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	Primary.ID = 1
	Hotkey_Button(Primary)
	ButtonHighLight_Create(Primary, C.Color.B2)
	frame.Primary = Primary

	local Alternate = CreateFrame("Button", nil, frame)
	Alternate: SetSize(124, button_size)
	Alternate: SetPoint("RIGHT", frame, "RIGHT", 0,0)
	Alternate: SetBackdrop(backdrop)
	Alternate: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Alternate: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	Alternate.ID = 2
	Hotkey_Button(Alternate)
	ButtonHighLight_Create(Alternate, C.Color.B2)
	frame.Alternate = Alternate

	if Info.Show then
		configframe: HookScript("OnShow", function(self)
			Info.Show(frame)
		end)
	end
end

local function Hotkey_CommunicationMenu(frame, configframe)
	frame.Num = frame.Num + 1
	frame.Bar[frame.Num] = Hotkey_Template(frame)
	frame.Bar[frame.Num].Config = {
		Name = L['COMMUNICATION_MENU'],
		--Show = function(self, button)
		--	local key1, key2 = GetBindingKey("QUAFE_COMMUNICATIONMENU")
		--	self.Primary.Text: SetText(key1)
		--	self.Alternate.Text: SetText(key2)
		--end,
	}
	Hotkey_Create(frame.Bar[frame.Num], frame, configframe)
	frame.Bar[frame.Num]: SetScript("OnEvent", function(self, event)
		local key1, key2 = GetBindingKey("QUAFE_COMMUNICATIONMENU")
		self.Primary.Text: SetText(key1)
		self.Alternate.Text: SetText(key2)
	end)
end

----------------------------------------------------------------
--> Profile
----------------------------------------------------------------

local function Profile_NameFix(text)
	if text then
		if (text == "") then
			text = nil
		end
	end
	return text
end

local function Profile_Copy(index)
	if not Quafe_DB.Profile[index] then return end
	local newprofile = {}
	for k,v in pairs(Quafe_DB.Profile[index]) do
		if k == "Name" then
			newprofile[k] = v.."-Copy"
		else
			newprofile[k] = v
		end
	end
	if not newprofile.Name then
		newprofile.Name = "Default-Copy"
	end
	if index == "Default" then
		index = 0
	end
	insert(Quafe_DB.Profile, index+1, newprofile)
end

local function Profile_Delete(index)
	if not Quafe_DB.Profile[index] then return end
	remove(Quafe_DB.Profile, index)
end

local function Profile_New()
	local index = #Quafe_DB.Profile or 0
	index = index + 1
	local newprofile = {}
	for k,v in pairs(E.Database.Profile.Default) do
		if k == "Name" then
			newprofile[k] = "New Profile"
		else
			newprofile[k] = v
		end
	end
	if not newprofile.Name then
		newprofile.Name = "New Profile"
	end
	insert(Quafe_DB.Profile, index, newprofile)
	return index + 2
end

local function Profile_Title_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame.Hold)
	Bar: SetSize(720, button_size)
	if frame.Num == 1 then
		Bar: SetPoint("TOP", frame.Hold, "TOP", 0,-2)
	else
		Bar: SetPoint("TOP", frame.Bar[frame.Num-1], "BOTTOM", 0,-button_gap)
	end

	local Bg = F.Create.Texture(Bar, "BACKGROUND", 1, F.Path("White"), C.Color.B1, 0.7, {720-button_size-4, 4})
	Bg: SetPoint("TOPLEFT", Bar, "TOPLEFT", 0,4-button_size)

	local Name = F.Create.Font(Bar, "ARTWORK", C.Font.Txt, 14, nil, C.Color.W3)
	Name: SetPoint("LEFT", Bar, "LEFT", button_size+20+4, 0)
	Name: SetText(L['PROFILE_NAME'])

	local Plus = CreateFrame("Button", nil, Bar)
	Plus: SetSize(button_size,button_size)
	Plus: SetPoint("TOPRIGHT", Bar, "TOPRIGHT", 0,0)
	Plus: SetBackdrop(backdrop)
	Plus: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	Plus: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(Plus, C.Color.B2)

	local PlusTex = F.Create.Texture(Plus, "ARTWORK", 2, F.Path("Config_Plus1"), C.Color.W3, 1, {32,32})
	PlusTex: SetPoint("CENTER", Plus, "CENTER")
	
	Plus: HookScript("OnEnter", function(self)
		GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip: SetPoint("TOPLEFT", self, "TOPRIGHT", 4,0)
		GameTooltip: SetText(L['NEW_PROFILE'], 1.0, 1.0, 1.0);
		GameTooltip: Show()
	end)
	Plus: HookScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)

	Bar.Plus = Plus
	Bar.Plus.Tex = PlusTex

	return Bar
end

local function ProfileBar_Template(frame)
	local Bar = CreateFrame("Frame", nil, frame.Hold)
	Bar: SetSize(720, button_size)
	if frame.Num == 1 then
		Bar: SetPoint("TOP", frame.Hold, "TOP", 0,-2)
	else
		Bar: SetPoint("TOP", frame.Bar[frame.Num-1], "BOTTOM", 0,-button_gap)
	end

	local TickButton = CreateFrame("Button", nil, Bar)
	TickButton: SetSize(button_size, button_size)
	TickButton: SetPoint("TOPLEFT", Bar, "TOPLEFT", 0,0)
	TickButton: SetBackdrop(backdrop)
	TickButton: SetBackdropColor(F.Color(C.Color.W2, 1))
	TickButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(TickButton, C.Color.B2)

	local MenuButton = CreateFrame("Button", nil, Bar)
	MenuButton: SetSize(button_size, button_size)
	MenuButton: SetPoint("TOPRIGHT", Bar, "TOPRIGHT", 0,0)
	MenuButton: SetBackdrop(backdrop)
	MenuButton: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	MenuButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(MenuButton, C.Color.B2)

	local NameHold = CreateFrame("Button", nil, Bar)
	NameHold: SetPoint("BOTTOMLEFT", TickButton, "BOTTOMRIGHT", 4,0)
	NameHold: SetPoint("TOPRIGHT", MenuButton, "TOPLEFT", -4,0)
	NameHold: SetBackdrop(backdrop)
	NameHold: SetBackdropColor(F.Color(C.Color.W2, 1))
	NameHold: SetBackdropBorderColor(F.Color(C.Color.W1, 0))

	local Check = F.Create.Texture(TickButton, "ARTWORK", 1, F.Path("Config_Tick"), C.Color.W3, 1, {20,20})
	Check: SetPoint("CENTER", TickButton, "CENTER")

	local Menu = F.Create.Texture(MenuButton, "ARTWORK", 1, F.Path("Config_Plus3"), C.Color.W3, 1, {32,32})
	Menu: SetPoint("CENTER", MenuButton, "CENTER")

	local Name = F.Create.Font(NameHold, "ARTWORK", C.Font.Txt, 14, nil, C.Color.W3)
	Name: SetPoint("LEFT", NameHold, "LEFT", 20,0)

	local EditHold = CreateFrame("Frame", nil, Bar)
	EditHold: SetPoint("BOTTOMLEFT", TickButton, "BOTTOMRIGHT", 4,0)
	EditHold: SetPoint("TOPRIGHT", MenuButton, "TOPLEFT", -4,0)
	EditHold: Hide()

	local DeleteButton = CreateFrame("Button", nil, EditHold)
	DeleteButton: SetSize(button_size*4, button_size)
	DeleteButton: SetPoint("TOPRIGHT", Bar, "TOPRIGHT", -button_size-4,0)
	DeleteButton: SetBackdrop(backdrop)
	DeleteButton: SetBackdropColor(F.Color(C.Color.R3, 0.7))
	DeleteButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(DeleteButton, C.Color.R3)
	
	local DeleteText = F.Create.Font(DeleteButton, "ARTWORK", C.Font.Txt, 14, nil, C.Color.W3)
	DeleteText: SetPoint("CENTER", DeleteButton, "CENTER", 0,0)
	DeleteText: SetText(L['DELETE'])

	local CopyButton = CreateFrame("Button", nil, EditHold)
	CopyButton: SetSize(button_size*4, button_size)
	CopyButton: SetPoint("TOPRIGHT", DeleteButton, "TOPLEFT", -4,0)
	CopyButton: SetBackdrop(backdrop)
	CopyButton: SetBackdropColor(F.Color(C.Color.Y1, 0.7))
	CopyButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(CopyButton, C.Color.Y1)

	local CopyText = F.Create.Font(CopyButton, "ARTWORK", C.Font.Txt, 14, nil, C.Color.W3)
	CopyText: SetPoint("CENTER", CopyButton, "CENTER", 0,0)
	CopyText: SetText(L['COPY'])

	local ReNameButton = CreateFrame("Button", nil, EditHold)
	ReNameButton: SetSize(button_size*4, button_size)
	ReNameButton: SetPoint("TOPRIGHT", CopyButton, "TOPLEFT", -4,0)
	ReNameButton: SetBackdrop(backdrop)
	ReNameButton: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	ReNameButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(ReNameButton, C.Color.B2)

	local ReNameText = F.Create.Font(ReNameButton, "ARTWORK", C.Font.Txt, 14, nil, C.Color.W3)
	ReNameText: SetPoint("CENTER", ReNameButton, "CENTER", 0,0)
	ReNameText: SetText(L['RENAME'])

	local ReNameHold = CreateFrame("Frame", nil, Bar)
	ReNameHold: SetPoint("BOTTOMLEFT", TickButton, "BOTTOMRIGHT", 4,0)
	ReNameHold: SetPoint("TOPRIGHT", MenuButton, "TOPLEFT", -4,0)
	ReNameHold: Hide()

	local CancelButton = CreateFrame("Button", nil, ReNameHold)
	CancelButton: SetSize(button_size*4, button_size)
	CancelButton: SetPoint("TOPRIGHT", ReNameHold, "TOPRIGHT", 0,0)
	CancelButton: SetBackdrop(backdrop)
	CancelButton: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	CancelButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(CancelButton, C.Color.B2)

	local CancelText = F.Create.Font(CancelButton, "ARTWORK", C.Font.Txt, 14, nil, C.Color.W3)
	CancelText: SetPoint("CENTER", CancelButton, "CENTER", 0,0)
	CancelText: SetText(L['CANCEL'])

	local ConfirmButton = CreateFrame("Button", nil, ReNameHold)
	ConfirmButton: SetSize(button_size*4, button_size)
	ConfirmButton: SetPoint("TOPRIGHT", CancelButton, "TOPLEFT", -4,0)
	ConfirmButton: SetBackdrop(backdrop)
	ConfirmButton: SetBackdropColor(F.Color(C.Color.Y1, 0.7))
	ConfirmButton: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	ButtonHighLight_Create(ConfirmButton, C.Color.Y1)

	local ConfirmText = F.Create.Font(ConfirmButton, "ARTWORK", C.Font.Txt, 14, nil, C.Color.W3)
	ConfirmText: SetPoint("CENTER", ConfirmButton, "CENTER", 0,0)
	ConfirmText: SetText(L['CONFIRM'])

	local ReNameBox = CreateFrame("EditBox", nil, ReNameHold)
	ReNameBox: SetAutoFocus(true)
	ReNameBox: SetFont(C.Font.Txt, 14, nil)
	ReNameBox: SetJustifyH("LEFT")
	ReNameBox: SetTextInsets(20, 20, 0, 0)
	ReNameBox: SetBackdrop(backdrop)
	ReNameBox: SetBackdropColor(F.Color(C.Color.B1, 0.7))
	ReNameBox: SetBackdropBorderColor(F.Color(C.Color.B1, 0))
	ReNameBox: SetPoint("BOTTOMLEFT", ReNameHold, "BOTTOMLEFT", 0,0)
	ReNameBox: SetPoint("TOPRIGHT", ConfirmButton, "TOPLEFT", -4,0)
	ReNameBox: SetScript("OnEscapePressed", function(self)
		self: ClearFocus() 
	end)
	ReNameBox: SetScript("OnShow", function(self)
		self: SetText(Quafe_DB.Profile[Bar.ID].Name or frame.ID)
	end)

	TickButton: SetScript("OnClick", function(self, mousebutton)
		if Bar.ID then
			Quafe_DBP.Profile = Bar.ID
			frame: Refresh()
			Quafe_NoticeReload()
		end
	end)

	MenuButton: HookScript("OnEnter", function(self)
		GameTooltip: SetOwner(self, "ANCHOR_NONE", 0,0)
		GameTooltip: SetPoint("TOPLEFT", self, "TOPRIGHT", 4,0)
		GameTooltip: SetText(L['EDIT'], 1.0, 1.0, 1.0);
		GameTooltip: Show()
	end)
	MenuButton: HookScript("OnLeave", function(self)
		GameTooltip: Hide()
	end)
	MenuButton: SetScript("OnClick", function(self, button)
		if NameHold: IsShown() then
			NameHold: Hide()
			EditHold: Show()
		else
			NameHold: Show()
			EditHold: Hide()
		end
	end)

	DeleteButton: SetScript("OnClick", function(self, mousebutton)
		if Bar.ID == "Default" then
		else
			if Quafe_DBP.Profile == Bar.ID then
				Quafe_DBP.Profile = "Default"
				Quafe_NoticeReload()
			end
			Profile_Delete(Bar.ID)
			NameHold: Show()
			EditHold: Hide()
			frame:Update()
		end
	end)

	CopyButton: SetScript("OnClick", function(self, mousebutton)
		Profile_Copy(Bar.ID)
		NameHold: Show()
		EditHold: Hide()
		frame:Update()
	end)

	ReNameButton: SetScript("OnClick", function(self, mousebutton)
		if Bar.ID == "Default" then
		else
			EditHold: Hide()
			ReNameHold: Show()
		end
	end)

	ConfirmButton: SetScript("OnClick", function(self, mousebutton)
		local newname = Profile_NameFix(ReNameBox:GetText())
		if newname then
			Quafe_DB.Profile[Bar.ID].Name = newname
			NameHold: Show()
			ReNameHold: Hide()
			frame:Update()
		end
	end)
	CancelButton: SetScript("OnClick", function(self, mousebutton)
		NameHold: Show()
		ReNameHold: Hide()
	end)

	Bar.Check = Check
	Bar.Name = Name
	Bar.TickButton = TickButton
	Bar.MenuButton = MenuButton
	Bar.ReNameButton = ReNameButton
	Bar.CopyButton = CopyButton
	Bar.DeleteButton = DeleteButton
	Bar.ReNameBox = ReNameBox
	Bar.NameHold = NameHold
	Bar.EditHold = EditHold
	Bar.ReNameHold = ReNameHold

	return Bar
end

local function ProfileBar_Refresh(frame)
	for i = 2, frame.Num do 
		if frame.Bar[i].ID == Quafe_DBP.Profile then
			frame.Bar[i].TickButton: SetBackdropColor(F.Color(C.Color.B1, 0.7))
			frame.Bar[i].Check: Show()
		else
			frame.Bar[i].TickButton: SetBackdropColor(F.Color(C.Color.W2, 1))
			frame.Bar[i].Check: Hide()
		end
	end
end

local function Profile_Title(frame, configframe)
	frame.Num = frame.Num + 1
	frame.Bar[frame.Num] = Profile_Title_Template(frame)
end

local function Profile_Create(frame, scroll, v)
	if frame.ID == "Default" then
		frame.Name: SetText(L['DEFAULT'] or frame.ID)
	else
		frame.Name: SetText(Quafe_DB.Profile[frame.ID].Name or frame.ID)
	end
end

local function ProfileScrollBar_Load(frame, configframe)
	local ProfileNum,FrameNum = 0,0
	if Quafe_DB.Profile then
		frame.Num = frame.Num + 1
		if not frame.Bar[frame.Num] then
			frame.Bar[frame.Num] = ProfileBar_Template(frame)
		end
		frame.Bar[frame.Num].ID = "Default"
		frame.Bar[frame.Num]:Show()
		Profile_Create(frame.Bar[frame.Num], frame, v)

		for k,v in ipairs(Quafe_DB.Profile) do
			frame.Num = frame.Num + 1
			if not frame.Bar[frame.Num] then
				frame.Bar[frame.Num] = ProfileBar_Template(frame)
			end
			frame.Bar[frame.Num].ID = k
			frame.Bar[frame.Num]:Show()
			Profile_Create(frame.Bar[frame.Num], frame, v)
		end
		ProfileNum = #Quafe_DB.Profile + 2
		FrameNum = #frame.Bar
		if FrameNum > ProfileNum then
			for i = (ProfileNum+1), FrameNum do
				if i ~= 1 then
					frame.Bar[i]:Hide()
				end
			end
		end
		ProfileBar_Refresh(frame)
		HoldHeight_Update(frame)
	end
end

local function ProfileList_Update(frame)
	frame.Num = 1
	ProfileScrollBar_Load(frame)
end

local function Profile_OnEvent(frame, configframe)
	function frame:Update()
		ProfileList_Update(self)
	end
	function frame:Refresh()
		ProfileBar_Refresh(self)
	end
	frame.Bar[1].Plus.Tex: SetTexture(F.Path("Config_Plus1"))
	frame.Bar[1].Plus: SetScript("OnClick", function(self)
		local index = Profile_New()
		frame:Update()
		frame.Bar[index].NameHold: Hide()
		frame.Bar[index].ReNameHold: Show()
		frame.Bar[index].ReNameBox: HighlightText()
	end)
end

----------------------------------------------------------------
--> Scrolls
----------------------------------------------------------------

local function Create_Bars(frame)
	frame.ConfigScroll.Num = 0
	frame.AurawatchScroll.Num = 0
	frame.ControlsScroll.Num = 0
	frame.ProfileScroll.Num = 0

	--> ConfigScroll
	Button_Mover(frame.ConfigScroll, frame)
	--Button_Scale(frame.ConfigScroll, frame)
	Button_Mouse(frame.ConfigScroll, frame)
	ConfigScrollBar_Load(frame.ConfigScroll, frame)
	UDF_ColorPick_Create(frame.ConfigScroll, frame)
	
	--> AurawatchScroll
	Aurawatch_Title(frame.AurawatchScroll, frame)
	AurawatchScrollBar_Load(frame.AurawatchScroll, frame)
	Aurawatch_AddNew(frame.AurawatchScroll, frame)
	Aurawatcher_OnEvent(frame.AurawatchScroll, frame)
	
	--> ControlsScroll
	Hotkey_CommunicationMenu(frame.ControlsScroll, frame)

	--> ProfileScroll
	Profile_Title(frame.ProfileScroll, frame)
	ProfileScrollBar_Load(frame.ProfileScroll, frame)
	Profile_OnEvent(frame.ProfileScroll, frame)

	--> Update Hold
	HoldHeight_Update(frame.ConfigScroll)
	HoldHeight_Update(frame.AurawatchScroll)
	HoldHeight_Update(frame.ControlsScroll)
	HoldHeight_Update(frame.ProfileScroll)
end

--- ------------------------------------------------------------
--> Tabs
--- ------------------------------------------------------------

local function Tab_OnClick(frame)
	local tabframe = frame:GetParent()
	local parent = tabframe:GetParent()
	if parent.Info.Tab ~= frame.ID then
		parent.Info.Tab = frame.ID
		FramesVisible_Update(parent.Info.Tab, {parent.ConfigScroll, parent.AurawatchScroll, parent.ControlsScroll, parent.ProfileScroll})
		FramesVisible_Update(parent.Info.Tab, {tabframe.Config.Bg, tabframe.Aurawatch.Bg, tabframe.Controls.Bg, tabframe.Profile.Bg})
	end
end

local function Tab_Template(frame, text, gap, gapleft)
	local Edge = frame: CreateTexture(nil, "OVERLAY")
	Edge: SetTexture(F.Path("White"))
	Edge: SetVertexColor(F.Color(C.Color.B2))
	Edge: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,0)
	Edge: SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0,4)
	Edge: Hide()

	frame: SetScript("OnEnter", function(self)
		Edge: Show()
	end)
	frame: SetScript("OnLeave", function(self)
		Edge: Hide()
	end)

	if text then
		local Bg = frame:CreateTexture(nil, "BACKGROUND")
		Bg: SetTexture(F.Path("White"))
		Bg: SetVertexColor(F.Color(C.Color.B1))
		Bg: SetAlpha(0.7)
		Bg: SetAllPoints(frame)
		Bg: Hide()

		local Txt = frame: CreateFontString(nil, "ARTWORK")
		Txt: SetFont(C.Font.NumSmall, 14, nil)
		Txt: SetShadowColor(0,0,0,0)
		Txt: SetShadowOffset(1,-1)
		Txt: SetTextColor(F.Color(C.Color.W3))
		Txt: SetPoint("CENTER", frame, "CENTER", 0, 0)
		Txt: SetText(text)
		
		frame: SetWidth(Txt:GetWidth()+28)

		frame: SetScript("OnClick", function(self, button)
			Tab_OnClick(frame)
		end)

		frame.Bg = Bg
		frame.Txt = Txt
	end

	if gap then
		local Gap = frame:CreateTexture(nil, "BORDER")
		Gap: SetTexture(F.Path("White"))
		Gap: SetAlpha(0.25)
		Gap: SetSize(2,38) --28
		Gap: SetVertexColor(F.Color(C.Color.W3))
		if gapleft then
			Gap: SetPoint("RIGHT", frame, "LEFT", 0,0)
		else
			Gap: SetPoint("LEFT", frame, "RIGHT", 0,0)
		end
	end
end

local Tab_Config = function(frame)
	local Config = CreateFrame("Button", nil, frame)
	Config: SetSize(104,38)
	Config: SetPoint("LEFT", frame, "LEFT", 0,0)
	Config.ID = 1
	Tab_Template(Config, L['CONFIG_CONFIG'], true)
	
	frame.Config = Config
end

local Tab_Aurawatch = function(frame)
	local Aurawatch = CreateFrame("Button", nil, frame)
	Aurawatch: SetSize(104,38)
	Aurawatch: SetPoint("LEFT", frame.Config, "RIGHT", 2,0)
	Aurawatch.ID = 2
	Tab_Template(Aurawatch, L['CONFIG_AURAWATCH'], true)

	frame.Aurawatch = Aurawatch
end

local function Tab_Controls(frame)
	local Controls = CreateFrame("Button", nil, frame)
	Controls: SetSize(104,38)
	Controls: SetPoint("LEFT", frame.Aurawatch, "RIGHT", 2,0)
	Controls.ID = 3
	Tab_Template(Controls, L['CONFIG_CONTROLS'], true)

	frame.Controls = Controls
end

local function Tab_Profile(frame)
	local Profile = CreateFrame("Button", nil, frame)
	Profile: SetSize(104,38)
	Profile: SetPoint("LEFT", frame.Controls, "RIGHT", 2,0)
	Profile.ID = 4
	Tab_Template(Profile, L['CONFIG_PROFILE'], true)

	frame.Profile = Profile
end

local function Tab_Exit(frame)
	local Exit = CreateFrame("Button", nil, frame)
	Exit: SetSize(52,38)
	Exit: SetPoint("RIGHT", frame, "RIGHT", 0,0)
	
	Tab_Template(Exit, false, true, true)
	
	local Bg = Exit: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.Config.Exit))
	--Bg: SetVertexColor(F.Color(C.Color.B1))
	Bg: SetAllPoints(Exit)
	Bg: Hide()
	
	local Txt = Exit: CreateFontString(nil, "ARTWORK")
	Txt: SetFont(C.Font.NumSmall, 18, nil)
	Txt: SetShadowColor(0,0,0,0)
	Txt: SetShadowOffset(1,-1)
	--Txt: SetTextColor(28/255, 28/255, 28/255)
	Txt: SetTextColor(F.Color(C.Color.W3))
	Txt: SetJustifyH("CENTER")
	Txt: SetPoint("CENTER", Exit, "CENTER", 0, 0)
	Txt: SetText("X")
	
	Exit: SetScript("OnClick", function(self, button)
		local parent = frame:GetParent()
		parent: Hide()
	end)
	
	frame.Exit = Exit
end

local function Tab_Help(frame)
	local Help = CreateFrame("Button", nil, frame)
	Help: SetSize(42,38)
	Help: SetPoint("RIGHT", frame.Exit, "LEFT", -2,0)
	
	Tab_Template(Help, false, true, true)
	
	local Txt = Help:CreateFontString(nil, "ARTWORK")
	Txt: SetFont(C.Font.NumSmall, 18, nil)
	Txt: SetShadowColor(0,0,0,0)
	Txt: SetShadowOffset(1,-1)
	--Txt: SetTextColor(28/255, 28/255, 28/255)
	Txt: SetTextColor(F.Color(C.Color.W3))
	Txt: SetJustifyH("CENTER")
	Txt: SetPoint("CENTER", Help, "CENTER", 0, 0)
	Txt: SetText("?")
end

local function Tab_Bar(frame)
	local TabBar = CreateFrame("Frame", nil, frame)
	TabBar: SetSize(720,38)
	TabBar: SetPoint("TOP", frame, "TOP", 0, -28)
	TabBar: SetBackdrop(backdrop)
	TabBar: SetBackdropColor(F.Color(C.Color.W2))
	TabBar: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	
	Tab_Exit(TabBar)
	Tab_Help(TabBar)

	Tab_Config(TabBar)
	Tab_Aurawatch(TabBar)
	Tab_Controls(TabBar)
	Tab_Profile(TabBar)

	frame:HookScript("OnShow", function(self)
		TabBar.Config:SetWidth(TabBar.Config.Txt:GetWidth()+28)
		TabBar.Aurawatch:SetWidth(TabBar.Aurawatch.Txt:GetWidth()+28)
		TabBar.Controls:SetWidth(TabBar.Controls.Txt:GetWidth()+28)
		TabBar.Profile:SetWidth(TabBar.Profile.Txt:GetWidth()+28)
	end)
	frame:HookScript("OnHIde", function(self)
		
	end)
	
	frame.TabBar = TabBar
end

--- ------------------------------------------------------------
--> Config Frame
--- ------------------------------------------------------------

local Mouse_Wheel = function(scroll, slider)
	scroll:EnableMouseWheel(true)
	scroll:SetScript("OnMouseWheel", function(self, d)
		local maxRange = scroll:GetVerticalScrollRange()
		local Range = scroll:GetVerticalScroll()
		Range = max(min(Range - d*30, maxRange), 0)
		scroll: SetVerticalScroll(Range)
		slider: SetValue(1000 * Range / maxRange)
	end)
end

local function Scroll_Template(frame)
	local Scroll = CreateFrame("ScrollFrame", nil, frame)
	Scroll: SetSize(720,440)
	Scroll: SetPoint("BOTTOM", frame, "BOTTOM", 0, 24)
	Scroll: Hide()
	
	local Slider = CreateFrame("Slider", nil, Scroll)
	Slider: SetOrientation("VERTICAL")
	Slider: SetThumbTexture(F.Path("Config_Slider"), "ARTWORK")
	Slider: SetSize(18,436)
	Slider: SetPoint("LEFT", Scroll, "RIGHT", 10, 0)
	Slider: SetMinMaxValues(0, 1000)
	Slider: SetValue(F.Debug)
	Slider: SetValueStep(3)
	Slider: Enable()
	Slider: Hide()
	
	local SliderBg = Slider:CreateTexture(nil, "BACKGROUND", 0)
	SliderBg: SetTexture(F.Path("White"))
	SliderBg: SetVertexColor(147/255,  156/255, 165/255)
	SliderBg: SetSize(6, 436)
	SliderBg: SetPoint("CENTER", Slider, "CENTER", 0,0)
	SliderBg: SetAlpha(0.4)
	
	Slider: SetScript("OnValueChanged", function(self)
		local maxRange = Scroll:GetVerticalScrollRange()
		Scroll: SetVerticalScroll(maxRange * self:GetValue()/1000)
	end)

	local Hold = CreateFrame("Frame", nil, Scroll)
	Hold: SetSize(720, 2)
	Scroll: SetScrollChild(Hold)
	Mouse_Wheel(Scroll, Slider)

	Scroll.Hold = Hold
	Scroll.Slider = Slider
	Scroll.Bar = {}

	return Scroll
end

local function Create_Config(frame)
	F.create_Backdrop(frame, 2, 8, 4, C.Color.Config.Back,0.9, C.Color.Config.Back,0.9)

	local ConfigScroll = Scroll_Template(frame)
	local AurawatchScroll = Scroll_Template(frame)
	local ControlsScroll = Scroll_Template(frame)
	local ProfileScroll = Scroll_Template(frame)
	
	frame.ConfigScroll = ConfigScroll
	frame.AurawatchScroll = AurawatchScroll
	frame.ControlsScroll = ControlsScroll
	frame.ProfileScroll = ProfileScroll
end

----------------------------------------------------------------
--> Reload Frame
----------------------------------------------------------------

local wReload_Arts = function(frame)
	local Bg = frame: CreateTexture(nil, "BACKGROUND")
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.W1))
	Bg: SetAlpha(0.9)
	Bg: SetAllPoints(frame)
	
	local TopBorder = frame: CreateTexture(nil, "BORDER")
	TopBorder: SetTexture(F.Path("White"))
	TopBorder: SetVertexColor(F.Color(C.Color.B1))
	TopBorder: SetAlpha(0.7)
	TopBorder: SetHeight(2)
	TopBorder: SetPoint("TOPLEFT", frame, "TOPLEFT", 0,-1)
	TopBorder: SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0,-1)

	local BottomBorder = frame: CreateTexture(nil, "BORDER")
	BottomBorder: SetTexture(F.Path("White"))
	BottomBorder: SetVertexColor(F.Color(C.Color.B1))
	BottomBorder: SetAlpha(0.7)
	BottomBorder: SetHeight(2)
	BottomBorder: SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,1)
	BottomBorder: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,1)
	
	local Title1 = frame:CreateFontString(nil, "OVERLAY")
	Title1: SetFont(C.Font.Txt, 26, nil)
	Title1: SetShadowColor(0,0,0,0.9)
	Title1: SetShadowOffset(0,0)
	Title1: SetPoint("BOTTOM", Board1, "CENTER", 0,10)
	Title1: SetText(L['RELOAD_TO_APPLY'])
	
	local Title2 = frame:CreateFontString(nil, "OVERLAY")
	Title2: SetAlpha(0.6)
	Title2: SetFont(C.Font.Txt, 18, nil)
	Title2: SetShadowColor(0,0,0,0.9)
	Title2: SetShadowOffset(0,0)
	Title2: SetPoint("TOP", Board1, "CENTER", 0,-2)
	Title2: SetText(L['APPLY_RELOAD'])

	for i = 1,2 do
		local Button = CreateFrame("Button", nil, frame)
		Button: SetSize(104,42)

		local ButtonBg = Button:CreateTexture(nil, "BACKGROUND")
		ButtonBg: SetTexture(F.Path("White"))
		ButtonBg: SetVertexColor(F.Color(C.Color.B1))
		ButtonBg: SetAllPoints(Button)

		local ButtonTxt = Button: CreateFontString(nil, "ARTWORK")
		ButtonTxt: SetFont(C.Font.Txt, 18, nil)
		ButtonTxt: SetShadowColor(0,0,0,0)
		ButtonTxt: SetShadowOffset(1,-1)
		ButtonTxt: SetTextColor(F.Color(C.Color.W3))
		ButtonTxt: SetPoint("CENTER", Button, "CENTER", 0, 0)

		Button.Bg = ButtonBg
		Button.Txt = ButtonTxt
		frame["Button"..i] = Button
	end

	frame.Button1: SetPoint("BOTTOMRIGHT", frame, "BOTTOM", -12, 12)
	frame.Button1.Bg: SetVertexColor(F.Color(C.Color.B1, 0.7))
	frame.Button1.Txt: SetText(L['LATER'])

	frame.Button2: SetPoint("BOTTOMLEFT", frame, "BOTTOM", -8, 12)
	frame.Button2: SetWidth(128)
	frame.Button2.Bg: SetVertexColor(F.Color(C.Color.Y1, 0.9))
	frame.Button2.Txt: SetText(L['OK'])

	frame.Title1 = Title1
	frame.Title2 = Title2
end

local function Warning_Reload(frame)
	local wReload = CreateFrame("Frame", nil, E)
	wReload: SetFrameStrata("FULLSCREEN" )
	wReload: SetHeight(200)
	wReload: SetPoint("LEFT", UIParent, "LEFT", 0,0)
	wReload: SetPoint("RIGHT", UIParent, "RIGHT", 0,0)
	wReload: Hide()
	
	wReload_Arts(wReload)
	
	wReload.Button1: SetScript("OnClick", function(self, button)
		wReload:Hide()
		RELOAD_UI = false
	end)
	wReload.Button2: SetScript("OnClick", function(self, button)
		ReloadUI()
	end)
	
	frame.wReload = wReload
end

local function Warning_Reset(frame)
	local wReset = CreateFrame("Frame", nil, E)
	wReset: SetFrameStrata("FULLSCREEN" )
	wReset: SetHeight(200)
	wReset: SetPoint("LEFT", UIParent, "LEFT", 0,0)
	wReset: SetPoint("RIGHT", UIParent, "RIGHT", 0,0)
	wReset: Hide()
	
	wReload_Arts(wReset)
	
	wReset.Title1: SetText(L['RESET_TEXT1'])
	wReset.Title2: SetText(L['RESET_TEXT2'])
	
	wReset.Button1.Txt: SetText(L['NO'])
	wReset.Button1: SetScript("OnClick", function(self, button)
		frame:Hide()
		QDB.Version = C.Version
	end)
	wReset.Button2.Txt: SetText(L['YES'])
	wReset.Button2: SetScript("OnClick", function(self, button)
		F.Reset()
		ReloadUI()
	end)
	
	function F.Warning_Reset_Show()
		wReset: Show()
	end

	frame.wReset = wReset
end

local function nReload_Artwork(frame)
	local Bg = frame:CreateTexture(nil, "BORDER")
	Bg: SetTexture(F.Path("White"))
	Bg: SetVertexColor(F.Color(C.Color.Y1))
	Bg: SetPoint("TOPLEFT", frame, "TOPLEFT", 2,-2)
	Bg: SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2,2)
	
	local Text = F.create_Font(frame, C.Font.Txt, 16, nil)
	Text: SetTextColor(F.Color(C.Color.W3))
	Text: SetShadowColor(0,0,0,0)
	Text: SetShadowOffset(0,0)
	Text: SetPoint("CENTER", frame, "CENTER", 0,0)
	Text: SetText(L['RELOAD_TO_APPLY'])

	frame.Text = Text
end

local function Notice_Reload(frame)
	local nReload = CreateFrame("Button", nil, frame)
	nReload: SetFrameStrata("HIGH")
	nReload: SetSize(720,36)
	nReload: SetPoint("TOP", frame, "BOTTOM", 0,-4)
	nReload: SetBackdrop(backdrop)
	nReload: SetBackdropColor(C.Color.Config.Back.r, C.Color.Config.Back.g, C.Color.Config.Back.b, 0.9)
	nReload: SetBackdropBorderColor(F.Color(C.Color.W1, 0))
	nReload: Hide()
	
	nReload_Artwork(nReload)
	
	nReload: SetScript("OnClick", function(self, button)
		Quafe_WarningReload()
		self:Hide()
	end)

	frame.nReload = nReload
end

--- ------------------------------------------------------------
--> Load
--- ------------------------------------------------------------

local Quafe_Config = CreateFrame("Frame", "Quafe_Config", E)
local function Quafe_Config_Load()
	Quafe_Config: SetFrameStrata("HIGH")
	Quafe_Config: SetSize(800, 560)
	Quafe_Config: SetPoint("CENTER", UIParent, "CENTER", 0,0)
	tinsert(UISpecialFrames, "Quafe_Config")

	Quafe_Config.Info = {}
	
	Create_Config(Quafe_Config)
	Tab_Bar(Quafe_Config)
	Create_Bars(Quafe_Config)

	Warning_Reload(Quafe_Config)
	Warning_Reset(Quafe_Config)
	Notice_Reload(Quafe_Config)
	Notice_Reload(Quafe_Config)

	Quafe_Config.Info.Tab = 1
	Quafe_Config.ConfigScroll: Show()
	Quafe_Config.TabBar.Config.Bg: Show()

	Quafe_Config: HookScript("OnShow", function(self)
		PlaySoundFile(F.Path("Sound\\Show.ogg"), "Master")
	end)
	Quafe_Config: HookScript("OnHide", function(self)
		if RELOAD_UI == true then
			Quafe_WarningReload()
		end
		self.nReload: Hide()
	end)

	function Quafe_Config.Toogle()
		if Quafe_Config:IsShown() then
			Quafe_Config: Hide()
		else
			Quafe_Config: Show()
		end
	end
	
	function Quafe_WarningReload(text1, text2)
		if Quafe_Config.wReload then
			if text1 then
				Quafe_Config.wReload.Title1: SetText(text1)
			else
				Quafe_Config.wReload.Title1: SetText(L['RELOAD_TO_APPLY'])
			end
			if text2 then
				Quafe_Config.wReload.Title2: SetText(text2)
			else
				Quafe_Config.wReload.Title2: SetText(L['APPLY_RELOAD'])
			end
			Quafe_Config.wReload: Show()
		end
	end
	
	function Quafe_NoticeReload(text)
		RELOAD_UI = true
		if Quafe_Config.nReload then
			if text then
				Quafe_Config.nReload.Text: SetText(text)
			else
				Quafe_Config.nReload.Text: SetText(L['RELOAD_TO_APPLY'])
			end
			Quafe_Config.nReload: Show()
		end
	end

	Quafe_Config: RegisterEvent("PLAYER_LOGIN")
	Quafe_Config: SetScript("OnEvent", function(self, event)
		self: Hide()
	end)
end
Quafe_Config.Load = Quafe_Config_Load
insert(E.Module, Quafe_Config)









--[[

local function SecBar_fold(f, p, DB)
	f.Case: Hide()
	f: SetHeight(button_size)
	f.Plus.Tex: SetTexture(F.Path("Config_Plus1"))
	
	--if DB then
	--	p.Hold: SetHeight(p.Hold:GetHeight() - (button_size+button_gap)* #f.sec[DB])
	--else
	--	p.Hold: SetHeight(p.Hold:GetHeight() - (button_size+button_gap)* #f.sec)
	--end
	
end

local function SecBar_Open(f, p, DB)
	f.Case: Show()
	f.Plus.Tex: SetTexture(F.Path("Config_Plus2"))
	if DB then
		f: SetHeight(button_size+(button_size+button_gap)* #f.sec[DB])
		--p.Hold: SetHeight(p.Hold:GetHeight() + (button_size+button_gap)* #f.sec[DB])
	else
		f: SetHeight(button_size+(button_size+button_gap)* #f.sec)
		--p.Hold: SetHeight(p.Hold:GetHeight() + (button_size+button_gap)* #f.sec)
	end
	if f.Dropdown and f.Dropdown:IsShown() then
		f.Dropdown:Hide()
	end
end


local function SecBar_Refresh(f, p, DB)
	if f.sec or (DB and f.sec[DB])then
		local n1,n2
		if DB then
			n1,n2 = #f.Bar, #f.sec[DB]
		else
			n1,n2 = #f.Bar, #f.sec
		end
		
		if n2 > 0 then
			f.Plus.Tex: SetTexture(F.Path("Config_Plus1"))
			f.Plus: SetScript("OnClick", function(self, button)
				if f.Case:IsShown() then
					SecBar_fold(f, p, DB)
				else
					SecBar_Open(f, p, DB)
				end
				HoldHeight_Update(p)
			end)
			local configframe = p:GetParent()
			configframe:HookScript("OnHide", function(self)
				if f.Case:IsShown() then
					SecBar_fold(f, p, DB)
					HoldHeight_Update(p)
				end
			end)
		else
			f.Plus.Tex: SetTexture(F.Path("Config_Plus0"))
			f.Plus: SetScript("OnClick", nil)
		end
		
		if n1 > n2 then
			for i = (n2 +1), n1 do
				f.Bar[i]: Hide()
			end
		end
		for i = 1, n2 do
			if not f.Bar[i] then
				f.Bar[i] = CreateFrame("Frame", nil, f.Case)
				f.Bar[i]: SetSize(580, button_size)
				
				if DB then
					SubBar_Artwork(f.Bar[i], f.sec[DB][i].style)
					f.Bar[i].Name: SetText(f.sec[DB][i].name)
					f.Bar[i].Button.Text: SetText(f.sec[DB][i].text)
					f.Bar[i].Button: SetScript("OnClick", function(self, button)
						if button == "LeftButton" then
							
						elseif button  == "RightButton" then
							
						else
							
						end
					end)
				else
					SubBar_Artwork(f.Bar[i], f.sec[i].style)
					f.Bar[i].Name: SetText(f.sec[i].name)
					f.Bar[i].Button.Text: SetText(f.sec[i].text)
					f.Bar[i].Button: SetScript("OnClick", function(self, button)
						if button == "LeftButton" then
							
						elseif button  == "RightButton" then
							
						else
							
						end
					end)
				end
				if i == 1 then
					f.Bar[i]: SetPoint("TOP", f, "TOP", 0, -button_size-button_gap)
				else
					f.Bar[i]: SetPoint("TOP", f.Bar[i-1], "BOTTOM", 0, -button_gap)
				end
			end
			if not f.Bar[i]:IsShown() then
				f.Bar[i]: Show()
			end
		end
	else
		f.Plus.Tex: SetTexture(F.Path("Config_Plus0"))
		f.Plus: SetScript("OnClick", nil)
	end
end

local function Create_SecBar(f, p, DB)
	f.Case = CreateFrame("Frame", nil, f)
	f.Case: Hide()
	f.Bar = {}
	SecBar_Refresh(f, p, DB)
end

]]--
