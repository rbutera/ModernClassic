local _, addon = ...
local TCL = addon.TomCatsLibs

TomCatsWorldMapMixin = { }

function TomCatsWorldMapMixin:Minimize() -- :24
    self.isMaximized = false;

    self:SetSize(self.minimizedWidth, self.minimizedHeight);

    SetUIPanelAttribute(self, "bottomClampOverride", nil);
    UpdateUIPanelPositions(self);

    self.BorderFrame:SetBorder("PortraitFrameTemplateMinimizable");
    self.BorderFrame:SetPortraitShown(true);

    --self.BorderFrame.Tutorial:Show();
    self.NavBar:SetPoint("TOPLEFT", self.TitleCanvasSpacerFrame, "TOPLEFT", 64, -25);

    self:SynchronizeDisplayState();

    self:OnFrameSizeChanged();
end

function TomCatsWorldMapMixin:SetupTitle()
--    self.BorderFrame:SetTitle(MAP_AND_QUEST_LOG);
    self.BorderFrame:SetTitle(WORLD_MAP);
    self.BorderFrame.Bg:SetParent(self);
    self.BorderFrame.TopTileStreaks:Hide();
    self.BorderFrame:SetPortraitToAsset([[Interface\QuestFrame\UI-QuestLog-BookIcon]]);
end

function TomCatsWorldMapMixin:SynchronizeDisplayState()
    if self:IsMaximized() then
        self.BorderFrame.TitleText:SetText(WORLD_MAP);
        GameTooltip:Hide();
        self.BlackoutFrame:Show();
        MaximizeUIPanel(self);
    else
--        self.BorderFrame.TitleText:SetText(MAP_AND_QUEST_LOG);
        self.BorderFrame.TitleText:SetText(WORLD_MAP);
        self.BlackoutFrame:Hide();
        RestoreUIPanelArea(self);
    end
end

function TomCatsWorldMapMixin:Maximize()
    self.isMaximized = true;

    self.BorderFrame:SetBorder("ButtonFrameTemplateNoPortraitMinimizable");
    self.BorderFrame:SetPortraitShown(false);

    --self.BorderFrame.Tutorial:Hide();
    self.NavBar:SetPoint("TOPLEFT", self.TitleCanvasSpacerFrame, "TOPLEFT", 8, -25);

    self:UpdateMaximizedSize();
    self:SynchronizeDisplayState();

    self:OnFrameSizeChanged();
end

function TomCatsWorldMapMixin:OnMapChanged() -- :216
    MapCanvasMixin.OnMapChanged(self);
    self:RefreshOverlayFrames();
--    self:RefreshQuestLog();

    if C_MapInternal then
        C_MapInternal.SetDebugMap(self:GetMapID());
    end
end

function TomCatsWorldMapMixin:RefreshOverlayFrames() -- :261
    if self.overlayFrames then
        for i, frame in ipairs(self.overlayFrames) do
            frame:Refresh();
        end
    end
end

function TomCatsWorldMapMixin:SetupMinimizeMaximizeButton()
    if self:ShouldBeMinimized() then
        self.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:Hide()
        self.BorderFrame.MaximizeMinimizeFrame.MaximizeButton:Show()
    end
    self.minimizedWidth = 702;
    self.minimizedHeight = 534;
    self.questLogWidth = 290;

    local function OnMaximize()
        self:HandleUserActionMaximizeSelf();
    end

    self.BorderFrame.MaximizeMinimizeFrame:SetOnMaximizedCallback(OnMaximize);

    local function OnMinimize()
        self:HandleUserActionMinimizeSelf();
    end

    self.BorderFrame.MaximizeMinimizeFrame:SetOnMinimizedCallback(OnMinimize);
end

function TomCatsWorldMapMixin:IsMaximized()
    return self.isMaximized;
end

function TomCatsWorldMapMixin:UpdateMaximizedSize() -- :296
    assert(self:IsMaximized());

    local parentWidth, parentHeight = self:GetParent():GetSize();
    local SCREEN_BORDER_PIXELS = 30;
    parentWidth = parentWidth - SCREEN_BORDER_PIXELS;

    local spacerFrameHeight = self.TitleCanvasSpacerFrame:GetHeight();
    local unclampedWidth = ((parentHeight - spacerFrameHeight) * self.minimizedWidth) / (self.minimizedHeight - spacerFrameHeight);
    local clampedWidth = math.min(parentWidth, unclampedWidth);

    local unclampedHeight = parentHeight;
    local clampHeight = ((parentHeight - spacerFrameHeight) * (clampedWidth / unclampedWidth)) + spacerFrameHeight;
    self:SetSize(math.floor(clampedWidth), math.floor(clampHeight));
    SetUIPanelAttribute(self, "bottomClampOverride", (unclampedHeight - clampHeight) / 2);

    UpdateUIPanelPositions(self);

    self:OnFrameSizeChanged();
end

function TomCatsWorldMapMixin:UpdateSpacerFrameAnchoring() -- :318
    if self.QuestLog and self.QuestLog:IsShown() then
        self.TitleCanvasSpacerFrame:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -3 - self.questLogWidth, -67);
    else
        self.TitleCanvasSpacerFrame:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -3, -67);
    end
    self:OnFrameSizeChanged();
end

function TomCatsWorldMapMixin:AddOverlayFrames()
    --    self:AddOverlayFrame("WorldMapFloorNavigationFrameTemplate", "FRAME", "TOPLEFT", self:GetCanvasContainer(), "TOPLEFT", -15, 2);
    --    self:AddOverlayFrame("WorldMapTrackingOptionsButtonTemplate", "BUTTON", "TOPRIGHT", self:GetCanvasContainer(), "TOPRIGHT", -4, -2);
    --    self:AddOverlayFrame("WorldMapBountyBoardTemplate", "FRAME", nil, self:GetCanvasContainer());
    --    self:AddOverlayFrame("WorldMapActionButtonTemplate", "FRAME", nil, self:GetCanvasContainer());
    --    self:AddOverlayFrame("WorldMapZoneTimerTemplate", "FRAME", "BOTTOM", self:GetCanvasContainer(), "BOTTOM", 0, 20);

    self.NavBar = self:AddOverlayFrame("WorldMapNavBarTemplate", "FRAME");
    self.NavBar:SetPoint("TOPLEFT", self.TitleCanvasSpacerFrame, "TOPLEFT", 64, -25);
    self.NavBar:SetPoint("BOTTOMRIGHT", self.TitleCanvasSpacerFrame, "BOTTOMRIGHT", -4, 9);

    --    self.SidePanelToggle = self:AddOverlayFrame("WorldMapSidePanelToggleTemplate", "BUTTON", "BOTTOMRIGHT", self:GetCanvasContainer(), "BOTTOMRIGHT", -2, 1);
end

function TomCatsWorldMapMixin:AddOverlayFrame(templateName, templateType, anchorPoint, relativeFrame, relativePoint, offsetX, offsetY)
    local frame = CreateFrame(templateType, nil, self, templateName);
    if anchorPoint then
        frame:SetPoint(anchorPoint, relativeFrame, relativePoint, offsetX, offsetY);
    end
    frame.relativeFrame = relativeFrame or self;
    if not self.overlayFrames then
        self.overlayFrames = { };
    end
    tinsert(self.overlayFrames, frame);

    return frame;
end

local function ADDON_LOADED(_, event, arg1)
    if (arg1 == addon.name) then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
        --todo: Create cvars lib which initializes before any quasi-blizzard UI
        addon.savedVariables.character.cvars = addon.savedVariables.character.cvars or { }
        addon.savedVariables.character.cvars.miniWorldMap = addon.savedVariables.character.cvars.miniWorldMap or addon.defaultCVars.miniWorldMap

        -- Override BorderFrame
        WorldMapFrame:SetFrameStrata("MEDIUM")
        WorldMapFrame:SetIgnoreParentScale(false)
        WorldMapFrame.BlackoutFrame:SetFrameStrata("LOW")
        WorldMapFrame.BorderFrame:Hide()
        WorldMapFrame.BorderFrame:SetParent(nil)
        WorldMapFrame.BorderFrame = CreateFrame("FRAME", nil, WorldMapFrame, "TomCatsWorldMapFrameBorderFrame")

        -- Append TitleCanvasSpacerFrame
        WorldMapFrame.TitleCanvasSpacerFrame = CreateFrame("FRAME", nil, WorldMapFrame, "TomCatsWorldMapFrameTitleCanvasSpacerFrame")

        WorldMapFrame.ScrollContainer:ClearAllPoints()
        WorldMapFrame.ScrollContainer:SetPoint("TOPLEFT", WorldMapFrame.TitleCanvasSpacerFrame, "BOTTOMLEFT", 0, 0)
        WorldMapFrame.ScrollContainer:SetPoint("BOTTOMLEFT", 0, 2)
        WorldMapFrame.ScrollContainer:SetPoint("RIGHT", WorldMapFrame.TitleCanvasSpacerFrame)
        WorldMapFrame.ScrollContainer:SetIgnoreParentScale(true)

        -- Hide unnecessary overlayFrames
        WorldMapFrame.ContinentDropDown:Hide()
        WorldMapFrame.ZoneDropDown:Hide()
        WorldMapZoomOutButton:Hide()
        WorldMapMagnifyingGlassButton:Hide()
        WorldMapFrameCloseButton:Hide()

        Mixin(WorldMapFrame, TomCatsWorldMapMixin, TomCatsQuestLogOwnerMixin)

        -- from: WorldMapMixin:OnLoad()
        UIPanelWindows["WorldMapFrame"].maximizePoint = "TOP"
        WorldMapFrame:SetupTitle();
        WorldMapFrame:SetupMinimizeMaximizeButton();
        WorldMapFrame:AddOverlayFrames();
        --WorldMapFrame:RegisterEvent("VARIABLES_LOADED");
        --WorldMapFrame:RegisterEvent("DISPLAY_SIZE_CHANGED");
        --WorldMapFrame:RegisterEvent("UI_SCALE_CHANGED");
        --WorldMapFrame:AttachQuestLog();
        if WorldMapFrame:ShouldBeMinimized() then
            WorldMapFrame:Minimize();
        else
            WorldMapFrame:Maximize();
        end
    end
end

local function RescaleWorldMapFrame(_, event)
    if WorldMapFrame:IsMaximized() then
        WorldMapFrame:UpdateMaximizedSize();
    end
end

TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)
TCL.Events.RegisterEvent("DISPLAY_SIZE_CHANGED", RescaleWorldMapFrame)
TCL.Events.RegisterEvent("UI_SCALE_CHANGED", RescaleWorldMapFrame)
