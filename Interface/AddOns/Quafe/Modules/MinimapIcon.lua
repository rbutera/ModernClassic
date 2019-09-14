local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

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

--- ------------------------------------------------------------
--> API and Variable
--- ------------------------------------------------------------

local minimapShapes = {
    ["ROUND"] = {true, true, true, true},
    ["SQUARE"] = {false, false, false, false},
    ["CORNER-TOPLEFT"] = {false, false, false, true},
    ["CORNER-TOPRIGHT"] = {false, false, true, false},
    ["CORNER-BOTTOMLEFT"] = {false, true, false, false},
    ["CORNER-BOTTOMRIGHT"] = {true, false, false, false},
    ["SIDE-LEFT"] = {false, true, false, true},
    ["SIDE-RIGHT"] = {true, false, true, false},
    ["SIDE-TOP"] = {false, false, true, true},
    ["SIDE-BOTTOM"] = {true, true, false, false},
    ["TRICORNER-TOPLEFT"] = {false, true, true, true},
    ["TRICORNER-TOPRIGHT"] = {true, false, true, true},
    ["TRICORNER-BOTTOMLEFT"] = {true, true, false, true},
    ["TRICORNER-BOTTOMRIGHT"] = {true, true, true, false},
}

local function MinimapIcon_UpdatePosition(button)
    local angle = rad(button.minimapPos or 225)
    local x, y, q = cos(angle), sin(angle), 1
    local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
	if x < 0 then q = q + 1 end
    if y > 0 then q = q + 2 end
    local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
    local quadTable = minimapShapes[minimapShape]
    if quadTable[q] then
        x, y = x*80, y*80
    else
        local diagRadius = 103.13708498985 --math.sqrt(2*(80)^2)-10
        x = math.max(-80, math.min(x*diagRadius, 80))
        y = math.max(-80, math.min(y*diagRadius, 80))
    end
    button:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

local defaultCoords = {0, 1, 0, 1}
local function MinimapIcon_UpdateCoord(texture)
    local coords = texture:GetParent().dataObject.iconCoords or defaultCoords
    local deltaX, deltaY = 0, 0
	if not texture:GetParent().isMouseDown then
		deltaX = (coords[2] - coords[1]) * 0.05
		deltaY = (coords[4] - coords[3]) * 0.05
	end
	texture:SetTexCoord(coords[1] + deltaX, coords[2] - deltaX, coords[3] + deltaY, coords[4] - deltaY)
end

local function MinimapIcon_Update(self)
    local mx, my = Minimap:GetCenter()
    local px, py = GetCursorPosition()
    local scale = Minimap:GetEffectiveScale()
    px, py = px / scale, py / scale
    self.minimapPos = math.deg(math.atan2(py - my, px - mx)) % 360
    if Quafe_DB.Profile[Quafe_DBP.Profile] then
        Quafe_DB.Profile[Quafe_DBP.Profile].MinimapIconPos = self.minimapPos
    end
    MinimapIcon_UpdatePosition(self)
end

-- Tooltip code ripped from StatBlockCore by Funkydude
local function getAnchors(frame)
	local x, y = frame:GetCenter()
	if not x or not y then return "CENTER" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end

local function Create_MinimapButton(button)
    button: SetFrameStrata("MEDIUM")
	button: SetSize(24,24)
	button: SetFrameLevel(8)
	button: RegisterForClicks("anyUp")
    button: RegisterForDrag("LeftButton")
    button: SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local overlay = button:CreateTexture(nil, "OVERLAY")
    overlay: SetTexture(136430) --"Interface\\Minimap\\MiniMap-TrackingBorder"
    overlay: SetSize(30, 30)
    overlay: SetTexCoord(1/64,37/64, 0/64,36/64)
	overlay: SetPoint("CENTER")

    local background = button:CreateTexture(nil, "BACKGROUND")
    background: SetTexture(F.Path("Minimap\\MinimapButton_Bg"))
    background: SetSize(24,24)
    background: SetPoint("CENTER")
    background: SetVertexColor(0.02,0.02,0.02)
    
    local icon = button:CreateTexture(nil, "ARTWORK")
    icon: SetTexture(F.Path("Minimap\\MinimapButton_Icon"))
    icon: SetSize(16,16)
    icon: SetPoint("CENTER")
    icon: SetVertexColor(F.Color(C.Color.R1))
   
	button.Icon = icon
    button.isMouseDown = false

    icon.UpdateCoord = MinimapIcon_UpdateCoord
    icon: UpdateCoord()

    MinimapIcon_UpdatePosition(button)
    
    button: SetScript("OnEnter", function(self)
        if self.isMoving then return end
	    local obj = self.dataObject
        GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint(getAnchors(self))
		obj.OnTooltipShow(GameTooltip)
		GameTooltip:Show()
    end)
    button: SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    button: SetScript("OnClick", function(self, btn)
        Quafe_Config.Toogle()
    end)
    button: SetScript("OnMouseDown", function(self)
        self.isMouseDown = true
        icon: UpdateCoord()
    end)
    button: SetScript("OnMouseUp", function(self)
        self.isMouseDown = false
        icon: UpdateCoord()
    end)
    button: SetScript("OnDragStart", function(self)
        self:LockHighlight()
		self.isMouseDown = true
        icon:UpdateCoord()
        self:SetScript("OnUpdate", MinimapIcon_Update)
		self.isMoving = true
        GameTooltip:Hide()
    end)
    button: SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
        self.isMouseDown = false
        icon:UpdateCoord()
        self:UnlockHighlight()
        self.isMoving = nil
    end)
end

local function OnTooltipShow(tooltip)
    tooltip: SetText("|cff00E8C6Q|r|cff00E8C6uafe|r |cffE0F2F1UI|r")
    tooltip: AddLine("|cffE0F2F1"..L['MINIMAPICON_LEFT_CLICK'].."|r")
end

local Quafe_MinimapIcon = CreateFrame("Button", "Quafe_MinimapIcon", Minimap)
Quafe_MinimapIcon.dataObject = {}
local function Load()
    Quafe_MinimapIcon.dataObject.iconCoords = {0, 1, 0, 1}
    Quafe_MinimapIcon.dataObject.OnTooltipShow = OnTooltipShow

    Create_MinimapButton(Quafe_MinimapIcon)

    if Quafe_DB.Profile[Quafe_DBP.Profile] and Quafe_DB.Profile[Quafe_DBP.Profile].MinimapIconPos then
        Quafe_MinimapIcon.minimapPos = Quafe_DB.Profile[Quafe_DBP.Profile].MinimapIconPos
    end
    MinimapIcon_UpdatePosition(Quafe_MinimapIcon)
end
Quafe_MinimapIcon.Load = Load
insert(E.Module, Quafe_MinimapIcon)