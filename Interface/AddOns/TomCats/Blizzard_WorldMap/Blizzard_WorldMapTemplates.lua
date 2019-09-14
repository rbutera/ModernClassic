function WorldMapNavBarMixin:OnLoad()
    self.home:SetText("Azeroth")
    self.home:GetScript("OnLoad")(self.home)
    local homeData = {
        name = "Azeroth",
        OnClick = function(button)
            self:GoToMap(947)
        end,
    }
    NavBar_Initialize(self, "NavButtonTemplate", homeData, self.home, self.overflow);
end

local dropDownListExceptions = {
    [1459] = true, -- Alterac Valley
    [1460] = true, -- Warsong Gulch
    [1461] = true, -- Arathi Basin
}

local function IsMapValidForNavBarDropDown(mapInfo) -- :217
    return (mapInfo.mapType == Enum.UIMapType.World or mapInfo.mapType == Enum.UIMapType.Continent or mapInfo.mapType == Enum.UIMapType.Zone) and not dropDownListExceptions[mapInfo.mapID];
end

function WorldMapNavBarButtonMixin:GetDropDownList() -- :263
    local list = { };
    local mapInfo = C_Map.GetMapInfo(self.data.id);
    if ( mapInfo ) then
        local children = C_Map.GetMapChildrenInfo(mapInfo.parentMapID);
        if ( children ) then
            for i, childInfo in ipairs(children) do
                if ( IsMapValidForNavBarDropDown(childInfo)) then
                    local entry = { text = childInfo.name, id = childInfo.mapID, func = function(button, mapID) self:GetParent():GoToMap(mapID); end };
                    tinsert(list, entry);
                end
            end
            table.sort(list, function(entry1, entry2) return entry1.text < entry2.text; end);
        end
    end
    return list;
end