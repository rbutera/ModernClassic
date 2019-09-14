local MSQ = LibStub and LibStub("Masque", true)
if (not MSQ) then 
	return 
end
local ADDON = ...

-- Masque believes all buttons should be 36x36 points large. 
-- This is a convenience function to figure out the "right" sizes
-- based on the size of the source textures and the size 
-- of the actual content within that texture file. 
local mod = 1.5
local scale = function(contentSize, sourceTextureSize)
	return (sourceTextureSize or contentSize)/contentSize * 36 * mod
end

-- Simple method to retrieve our media paths
local path = function(name)
	return [[Interface\AddOns\]] .. ADDON .. [[\media\]] .. name .. ".tga"
end

-- Our sizing and colors
local borderSize, iconSize, flashSize = scale(480,512), scale(64,42), scale(64,54)
local borderOffsetX, borderOffsetY = 0, 0
local borderColor = { 255/255, 255/255, 255/255, 1 }
local backdropColor = { 255/255, 255/255, 255/255, 1 }
local backdropTexture = path("masque-backdrop-seal1")
local borderTexture = path("masque-border-brasscogs1")

MSQ:AddSkin("Brass Cogs", {
	Shape = "Circle",
	Masque_Version = 80100,

	Description = "A brass cog themed texture.",
	Version = GetAddOnMetadata(ADDON, "Version"),
	Authors = { "Daniel Troko", "|cff999999Lars Norberg|r" },
	Websites = {
		"https://github.com/AzeriteTeam/Masque_BrassCogs",
		"https://www.curseforge.com/wow/addons/masque-brasscogs"
	},

	Normal = {
		Width = borderSize,
		Height = borderSize,
		OffsetX = borderOffsetX, 
		OffsetY = borderOffsetY,
		Texture = borderTexture, 
		EmptyTexture = borderTexture,
		TexCoords = { 0, 1, 0, 1 },
		Color = borderColor,
		EmptyColor = borderColor
	},
	Border = {
		Width = borderSize,
		Height = borderSize,
		OffsetX = borderOffsetX, 
		OffsetY = borderOffsetY,
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Color = borderColor,
		Texture = borderTexture
	},
	Highlight = {
		Width = borderSize,
		Height = borderSize,
		OffsetX = borderOffsetX, 
		OffsetY = borderOffsetY,
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "ADD",
		Color = { 1, 1, 1, .25 },
		Texture = borderTexture
	},	
	Backdrop = {
		Width = borderSize,
		Height = borderSize,
		TexCoords = { 0, 1, 0, 1 },
		Color = backdropColor,
		Texture = backdropTexture
	},
	Checked = {
		Width = borderSize,
		Height = borderSize,
		OffsetX = borderOffsetX, 
		OffsetY = borderOffsetY,
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Color = borderColor,
		Texture = borderTexture
	},
	Icon = {
		Width = iconSize,
		Height = iconSize,
		TexCoords = { 0, 1, 0, 1 },
		Mask = path("actionbutton_circular_mask"),
	},
	Flash = {
		Width = iconSize,
		Height = iconSize,
		Color = { .7, 0, 0, .3 },
		Texture = path("actionbutton_circular_mask")
	},
	Pushed = {
		Width = iconSize,
		Height = iconSize,
		Color = { 1, 1, 1, .15 },
		Texture = path("actionbutton_circular_mask")
	},
	Gloss = {
		Hide = true,
		Width = borderSize,
		Height = borderSize,
		OffsetX = borderOffsetX, 
		OffsetY = borderOffsetY,
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "ADD",
		Color = { 1, 1, 1, 1 },
		Texture = path("masque-gloss-circular1")
	},
	Cooldown = {
		Width = 34,
		Height = 34,
		Color = { 0, 0, 0, .7 },
	},
	ChargeCooldown = {
		Width = 34,
		Height = 34,
	},
	AutoCast = {
		Width = 32,
		Height = 32,
		OffsetX = 1,
		OffsetY = -1
	},
	AutoCastable = {
		Width = 62,
		Height = 62,
		OffsetX = 1,
		OffsetY = 0,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]]
	},
	Disabled = {
		Hide = true,
	},
	Name = {
		Hide = true
	},
	Count = {
		Width = 36,
		Height = 12,
		OffsetX = 2,
		OffsetY = -2
	},
	HotKey = {
		Width = 36,
		Height = 12,
		OffsetX = -24,
		OffsetY = 2
	},
	Duration = {
		Width = 36,
		Height = 12,
		OffsetX = 0,
		OffsetY = 0,
	},
}, true)
