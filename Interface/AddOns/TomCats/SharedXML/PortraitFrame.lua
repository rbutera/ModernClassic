TomCatsPortraitFrameMixin = {};

function TomCatsPortraitFrameMixin:SetBorder(layoutName)
    local layout = TomCatsNineSliceUtil.GetLayout(layoutName);
    TomCatsNineSliceUtil.ApplyLayout(self.NineSlice, layout);
end

function TomCatsPortraitFrameMixin:SetPortraitToAsset(texture)
    SetPortraitToTexture(self.portrait, texture);
end

function TomCatsPortraitFrameMixin:SetPortraitToUnit(unit)
    SetPortraitTexture(self.portrait, unit);
end

function TomCatsPortraitFrameMixin:SetPortraitTextureRaw(texture)
    self.portrait:SetTexture(texture);
end

function TomCatsPortraitFrameMixin:SetPortraitAtlasRaw(atlas, ...)
    self.portrait:SetAtlas(atlas, ...);
end

function TomCatsPortraitFrameMixin:SetPortraitTexCoord(...)
    self.portrait:SetTexCoord(...);
end

function TomCatsPortraitFrameMixin:SetPortraitShown(shown)
    self.portrait:SetShown(shown);
end

function TomCatsPortraitFrameMixin:SetTitleColor(color)
    self.TitleText:SetTextColor(color:GetRGBA());
end

function TomCatsPortraitFrameMixin:SetTitle(title)
    self.TitleText:SetText(title);
end

function TomCatsPortraitFrameMixin:SetTitleFormatted(fmt, ...)
    self.TitleText:SetFormattedText(fmt, ...);
end

function TomCatsPortraitFrameMixin:SetTitleMaxLinesAndHeight(maxLines, height)
    self.TitleText:SetMaxLines(maxLines);
    self.TitleText:SetHeight(height);
end
