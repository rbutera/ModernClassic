local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Local

local SharedMedia = LibStub("LibSharedMedia-3.0")

local TypeBackground = SharedMedia.MediaType.BACKGROUND
local TypeBorder = SharedMedia.MediaType.BORDER
local TypeFont = SharedMedia.MediaType.FONT
local TypeStatusbar = SharedMedia.MediaType.STATUSBAR
local TypeSound = SharedMedia.MediaType.SOUND

--- ------------------------------------------------------------
--> Border
--- ------------------------------------------------------------

SharedMedia:Register(TypeBorder, "SlimWhite", [[Interface\Addons\Quafe\Media\EdgeFile\EdgeFile_Backdrop]])
SharedMedia:Register(TypeBorder, "SlimBlack", [[Interface\Addons\Quafe\Media\EdgeFile\EdgeFile_Layer]])

--- ------------------------------------------------------------
--> Font
--- ------------------------------------------------------------

SharedMedia:Register(TypeFont, "TTTGB", [[Interface\Addons\Quafe\Media\Fonts\TTTGB-Medium]])

--- ------------------------------------------------------------
--> Statusbar
--- ------------------------------------------------------------

SharedMedia:Register(TypeStatusbar, "BottomLine", [[Interface\Addons\Quafe\Media\StatusBar\BottomLine]])
SharedMedia:Register(TypeStatusbar, "Wildstar", [[Interface\Addons\Quafe\Media\StatusBar\WildstarTexture]])