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

MSQ:AddSkin("Azerite", {
	Shape = "Circle",
	Masque_Version = 80100,

	Description = "Designed to match the buttons in AzeriteUI.",
	Version = GetAddOnMetadata(ADDON, "Version"),
	Authors = { "Daniel Troko", "|cff999999Lars Norberg|r" },
	Websites = {
		"https://github.com/AzeriteTeam/Masque_Azerite",
		"https://www.curseforge.com/wow/addons/masque-azerite"
	}, 

	Normal = {
		Width = scale(128,256),
		Height = scale(128,256),
		Texture = path("actionbutton-border"), 
		EmptyTexture = path("actionbutton-border"),
		TexCoords = { 0, 1, 0, 1 },
		Color = { 192/255, 192/255, 192/255, 1 },
		EmptyColor = { 192/255, 192/255, 192/255, 1 }
	},
	Border = {
		Width = scale(128,256),
		Height = scale(128,256),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Color = { 192/255, 192/255, 192/255, 1 },
		Texture = path("actionbutton-border")
	},
	Highlight = {
		Width = scale(128,256),
		Height = scale(128,256),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "ADD",
		Color = { 1, 1, 1, .25 },
		Texture = path("actionbutton-border")
	},	
	Backdrop = {
		Width = scale(128,256),
		Height = scale(128,256),
		TexCoords = { 0, 1, 0, 1 },
		Color = { 1, 1, 1, 1 },
		Texture = path("actionbutton-backdrop")
	},
	Checked = {
		Width = scale(128,256),
		Height = scale(128,256),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Color = { 1, 1, 1, 1 },
		Texture = path("actionbutton-border")
	},
	Icon = {
		-- The scale() usage here shrinks the icon to fit
		Width = scale(64,42),
		Height = scale(64,42),
		Mask = path("actionbutton_circular_mask"),
		TexCoords = { 0, 1, 0, 1 }
	},
	Flash = {
		Width = scale(64,42),
		Height = scale(64,42),
		Color = { .7, 0, 0, .3 },
		Texture = path("actionbutton_circular_mask")
	},
	Pushed = {
		Width = scale(64,54),
		Height = scale(64,54),
		Color = { 1, 1, 1, .15 },
		Texture = path("actionbutton_circular_mask")
	},
	Gloss = {
		--Hide = true
		Width = scale(196,256),
		Height = scale(196,256),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Color = { 1, 1, 1, 1 },
		Texture = path("actionbutton-glow-white")
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
