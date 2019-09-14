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

----------------------------------------------------------------
--> Locale
----------------------------------------------------------------

C.Locale = {}

--- ------------------------------------------------------------
--> Colors
--- ------------------------------------------------------------

C.Color = {}

C.Color.Class = {
	["DEATHKNIGHT"]		= {r = 255/255, g =  49/255, b =  88/255},  --{247/255,  56/255,  84/255}
	["DRUID"]			= {r = 255/255, g = 139/255, b =  36/255},  --{255/255, 125/255,  10/255}
	["HUNTER"]			= {r = 206/255, g = 248/255, b =  74/255},  --{148/255, 219/255, 125/255}
	["MAGE"]			= {r =  46/255, g = 208/255, b = 255/255},  --{  0/255, 194/255, 255/255}
	["PALADIN"]			= {r = 255/255, g =  82/255, b = 204/255},  --{255/255,  56/255, 133/255}
	["PRIEST"]			= {r = 218/255, g = 234/255, b = 234/255},  --{204/255, 252/255, 252/255}
	["ROGUE"]			= {r = 255/255, g = 246/255, b =  14/255},  --{255/255, 232/255,  51/255}
	["SHAMAN"]			= {r =  68/255, g = 148/255, b = 255/255},  --{  0/255, 153/255, 153/255}
	["WARLOCK"]			= {r = 162/255, g = 144/255, b = 255/255},  --{153/255, 120/255, 217/255}
	["WARRIOR"]			= {r = 242/255, g = 194/255, b = 160/255},  --{230/255, 166/255, 115/255}
	["MONK"]			= {r =  96/255, g = 255/255, b = 194/255},  --{ 96/255, 255/255, 194/255}
	["DEMONHUNTER"]		= {r =    0.64, g =    0.19, b =    0.79},  --{r =    0.64, g =    0.19, b =    0.79}
}

C.Color.Matrix = {
	[1] =	{r = 239, g =  83, b =  80}, -- Red
	[2] =	{r = 236, g =  64, b = 122}, -- Pink
	[3] =	{r = 171, g =  71, b = 188},
	[4] =	{r = 126, g =  87, b = 194},
	[5] =	{r =  92, g = 107, b = 192},
	[6] =	{r =  66, g = 165, b = 245},
	[7] =	{r =  41, g = 182, b = 246},
	[8] =	{r =  38, g = 198, b = 218},
	[9] =	{r =  38, g = 166, b = 154},
	[10] =	{r = 102, g = 187, b = 106},
	[11] =	{r = 156, g = 204, b = 101},
	[12] =	{r = 212, g = 225, b =  87},
	[13] =	{r = 255, g = 238, b =  88},
	[14] =	{r = 250, g = 213, b =  62},
	[15] =	{r = 255, g = 167, b =  38},
	[16] =	{r = 255, g = 112, b =  67},
}

C.Color.DebuffType = {
	["none"]	= { r = 0.80, g =    0, b =    0 },
	[""]		= { r = 0.80, g =    0, b =    0 },
	["Magic"]	= { r = 0.20, g = 0.60, b = 1.00 },
	["Curse"]	= { r = 0.60, g = 0.00, b = 1.00 },
	["Disease"]	= { r = 0.60, g = 0.40, b =    0 },
	["Poison"]	= { r = 0.00, g = 0.60, b =    0 },
	["Enchant"] = { r = 0.85, g = 0.35, b = 0.98 },
}

C.Color.Config = {
	Bar1 = {r = 170/255, g = 180/255, b = 190/255},
	Bar2 = {r =  98/255, g = 162/255, b = 238/255},
	--Exit = {r = 114/255, g = 166/255, b = 222/255},
	Exit = {r = 248/255, g = 158/255, b =  53/255},
	--Back = {r =  24/255, g =  24/255, b =  24/255},
	Back = {r =  27, g =  29, b =  31},
}

C.Color.Bar = {
	["CE3176"] = { r = 206, g =  49, b = 118},  -- Pink Yarrow
	["F5512C"] = { r = 245, g =  81, b =  44},  -- Flame
	["F3CF55"] = { r = 209, g =  75, b =   4},  -- Primrose Yellow
	["88B14B"] = { r = 136, g = 177, b =  75},  -- Greenery
	["95DEE4"] = { r = 149, g = 222, b = 228},  -- Island Paradise
	["024B8F"] = { r =   2, g =  75, b = 143},  -- Lapis Blue
	["6131FF"] = { r =  97, g =  49, b = 255},

	["E31D4E"] = { r = 227, g =  29, b =  78},
	["03184D"] = { r =   3, g =  24, b =  77},
	
	["4C46FE"] = { r =  76, g =  70, b = 254},
}

C.Color["White"]	= {r = 243/255, g = 244/255, b = 246/255}
C.Color["White2"]	= {r = 154/255, g = 156/255, b = 162/255}
C.Color["Black"]	= {r =   8/255, g =   8/255, b =   8/255}
C.Color["Red"]		= {r = 252/255, g =  92/255, b =  92/255}
C.Color["Pink"]		= {r = 220/255, g =  98/255, b =  60/255}
C.Color["Yellow"]	= {r = 248/255, g = 158/255, b =  53/255}
C.Color["Yellow1"]	= {r = 253/255, g = 218/255, b =   4/255}

C.Color["Blue"]		= {r =  18/255, g = 234/255, b = 252/255}
C.Color["Blue1"]	= {r =  98/255, g = 162/255, b = 238/255}
C.Color["Blue2"]	= {r =   0/255, g = 126/255, b = 240/255}

--
--C.Color["Blue1"]	= {r =  51/255, g = 214/255, b = 255/255}
C.Color["Aqua"]		= {r = 111/255, g = 191/255, b = 218/255}
C.Color["Green"]	= {r =  96/255, g = 255/255, b = 194/255}
C.Color["Green1"]	= {r = 192/255, g = 252/255, b = 226/255}

C.Color["Denied"]	= {r =  87/255, g =  96/255, b = 105/255}



C.Color.Color0  = {r = 243/255, g = 244/255, b = 255/255}    -- 黑
C.Color.Color1  = {r =  26/255, g =  26/255, b =  26/255}    -- 黑
C.Color.Color2  = {r =  90/255, g =  90/255, b =  90/255}    -- 黑
C.Color.Color3  = {r = 249/255, g = 154/255, b = 164/255}    -- 红
C.Color.Color4  = {r = 247/255, g = 178/255, b =  99/255}    -- 红
C.Color.Color5  = {r = 104/255, g = 196/255, b = 184/255}    -- 绿
C.Color.Color7  = {r = 108/255, g = 168/255, b = 218/255}    -- 蓝
C.Color.Color8  = {r = 194/255, g = 214/255, b = 255/255}    -- 蓝
C.Color.Color9  = {r = 248/255, g = 158/255, b =  53/255}    -- 黄
C.Color.Color10 = {r = 202/255, g = 172/255, b =  48/255}    -- 黄

C.Color.W1 = C.Color.Color1
C.Color.W2 = C.Color.Color2
C.Color.W3 = C.Color.Color0
C.Color.W4 = {r = 200/255, g = 200/255, b = 200/255}
C.Color.R1 = C.Color.Color3
C.Color.R2 = C.Color.Color4
C.Color.R3 = C.Color["Red"]
C.Color.R4 = C.Color["Pink"]
--C.Color.B1 = C.Color.Color7
C.Color.B1 = {r =  56/255, g = 154/255, b = 254/255} 
--C.Color.B2 = C.Color.Color8
C.Color.B2 = {r =  36/255, g = 186/255, b = 254/255} 
C.Color.B3 = C.Color["Blue"]
C.Color.Y1 = {r = 210/255, g = 142/255, b =  64/255}
C.Color.Y2 = C.Color.Color10
C.Color.Y3 = C.Color.Color9
C.Color.G1 = C.Color.Color5
C.Color.G2 = {r = 113, g = 214, b =  39}

--> Class Special
C.Color.Rune = {
	[1] = {r = 255, g =  72, b =  72},
	[2] = {r =  49, g = 220, b = 255},
	--[3] = {r = 136, g = 177, b =  75},
	[3] = {r = 113, g = 214, b =  39},
}

--- ------------------------------------------------------------
--> Fonts
--- ------------------------------------------------------------

C.Font = {}
C.Font["Txt"] = UNIT_NAME_FONT
C.Font["Num"] = F.Path("Fonts\\Num.ttf")
C.Font["NumSmall"] = F.Path("Fonts\\Futura.ttf")
C.Font["NumOW"] = F.Path("Fonts\\BigNoodleToo.ttf")
C.Font["NumOWI"] = F.Path("Fonts\\BigNoodleTooOblique.ttf")
--[[
local locale = GetLocale()
if locale == "zhCN" or locale == "zhTW" then
	print(locale)
	C.Font["Txt"] = F.Path("Fonts\\SourceHanSans.ttf")
end
--]]
-- STANDARD_TEXT_FONT
-- UNIT_NAME_FONT
-- DAMAGE_TEXT_FONT

--- ------------------------------------------------------------
--> Textures
--- ------------------------------------------------------------

C.Tex = {}

C.Tex.Alliance = "Interface\\Timer\\Alliance-Logo"
C.Tex.Horde = "Interface\\Timer\\Horde-Logo"

----------------------------------------------------------------

--- ------------------------------------------------------------
--> Watcher Icons
--- ------------------------------------------------------------

C.WatcherIcon = {
	"Default",

	--> Quafe
	--XXX

	--> OverWatch
	"AdaptiveShield", "AmpItUp", "AmplificationMatrix", "AngelicDescent", "ArmorPack",
	"Barrage", "BarrierShield", "BioticField", "BioticGrenade", "BioticOrb",
	"Blink", "Blizzard", "Bob", "Boosters", "BuildTurret", 
	"CallMech", "ChainHook", "Charge", "CoachGun", "Coalescence",
	"CombatRoll", "ConcussionMine", "ConcussiveBlast", "Crossfade", "CryoFreeze",
	"Deadeye", "DeathBlossom", "DefenseMatrix", "Deflect", "DeployTurret",
	"Dragonblade", "Dragonstrike", "Dynamite", "EarthShatter", "Emp",
	"ExoBoots", "Fade", "FireStrike", "Flashbang", "Fortify",
	"GrapplingClaw", "GrapplingHook", "GravitonSurge", "GuardianAngel", "Hack",
	"Halt", "HelixRockets", "IceWall", "ImmortalityField", "InfraSight",
	"JumpJet", "JumpPack", "LightGun", "Lunge", "MeteorStrike",
	"MicroMissiles", "Minefield", "MoltenCore", "MoltenCore2", "OrbOfDiscord",
	"OrbOfHarmony", "Overload", "ParticleBarrier", "PhotonBarrier", "PhotonShield",
	"Piledriver", "PrimalRage", "ProjectedBarrier", "ProtectiveBarrier", "PulseBomb",
	"Rally", "Recall", "Reconfigure", "RegenerativeBurst", "RemoteMine",
	"RepairPack", "Resurrect", "Resurrect2", "RipTire", "RisingUppercut",
	"RocketPunch", "Roll", "ScatterArrow", "SeismicSlam", "SelfDestruct",
	"SelfRepair", "SentryTurret", "ShadowStep", "Shield", "ShieldBash",
	"ShieldProjector", "SleepDart", "SonicArrow", "SoundBarrier", "Sprint",
	"SteelTrap", "StimBoost", "StormArrows", "Supercharger", "SwiftStrike",
	"TacticalVisor", "TakeABreather", "Teleporter", "TheBestDefense", "ThermopticCamo",
	"TotalMayhem", "Transcendence", "Translocator", "Valkyrie", "VenomMine",
	"WhipShot", "WholeHog", "WraithForm",
}

--[[
local frame = CreateFrame("Frame", nil, UIParent)
frame:SetPoint("Center", UIParent, "Center", 0, 0)
frame:SetSize(100, 100)

local icon = frame:CreateTexture("Texture", "Background")
icon:SetTexCoord(0.5,1, 0,1)
icon:SetTexture("Interface\\Icons\\Ability_Ambush")
icon:SetMask("Interface\\ChatFrame\\UI-ChatIcon-HotS") --六边形
icon:SetMask("Interface\\DialogFrame\\DialogAlertIcon")	--三角形
icon:SetMask("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew") --圆边三角形
icon:SetMask("Interface\\GuildFrame\\GuildLogoMask_R") --右半圆
icon:SetMask("Interface\\ARCHEOLOGY\\Arch-Keystone-Mask") --六边形
icon:SetMask("Interface\\GLUES\\Models\\UI_Dwarf\\UI_Goblin_GodRaysMask") --四周渐隐多
icon:SetMask("Interface\\GLUES\\Models\\UI_DeathKnight\\IceCrown_CloudsA02_MASK01") --四周渐隐少
icon:SetMask("Interface\\FriendsFrame\\PlusManz-Horde")
icon:SetAllPoints(frame)
"Interface\\CharacterFrame\\TempPortraitAlphaMask" --圆形
"Interface\\Minimap\\UI-Minimap-Background" --圆形
--]]

--[[
f.Bg2: SetBlendMode("ADD")
f.Bg2: SetHorizTile(true)
f.Bg2: SetVertTile(true)
--]]

--[[
local function addLine(tooltip, id, type)
		local found = false

		-- Check if we already added to this tooltip. Happens on the talent frame
		for i = 1,15 do
			local frame = _G[tooltip:GetName() .. "TextLeft" .. i]
			local text
			if frame then text = frame:GetText() end
			if text and text == type then found = true break end
		end

		if not found then
			--tooltip:AddLine(id and ' ')
			tooltip:AddDoubleLine(id, type)
			tooltip:Show()
		end
	end
	
	hooksecurefunc("SetItemRef", function(link, ...)
		local id = tonumber(link:match("spell:(%d+)"))
		if id then addLine(ItemRefTooltip, id) end
	end)
	
	GameTooltip:HookScript("OnTooltipSetSpell", function(self)
		local id = select(3, self:GetSpell())
		if id then addLine(self, id) end
	end)
	--]]