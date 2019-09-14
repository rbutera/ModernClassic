
Quafe_DB = {
	["Profile"] = {
		["Default"] = {
			["Quafe_Assistant"] = {
				["SkinOrderHall"] = true,
				["SoulStone"] = "player",
			},
			["Blizzard"] = {
				["BossFrame"] = false,
				["PartyFrame"] = false,
				["FocusFrame"] = false,
				["TargetFrame"] = false,
				["PlayerFrame"] = false,
			},
			["Quafe_ActionBar"] = {
				["Enable"] = false,
				["Style"] = "Ring",
			},
			["Quafe_PartyRaid"] = {
				["Party"] = true,
				["Enable"] = true,
				["Raid5"] = false,
				["Raid5_PosX"] = 0,
				["Raid5_PosY"] = -360,
			},
			["MEKA_PlayerFrame"] = {
				["Enable"] = true,
				["Scale"] = 1,
				["PosY"] = 394.220410461425,
				["PosX"] = 561.066452102663,
			},
			["Quafe_Color"] = {
				["State"] = "Overwatch2",
				["Warn1"] = {
					["b"] = 0.415686274509804,
					["g"] = 0.227450980392157,
					["r"] = 0.972549019607843,
				},
				["Main2"] = {
					["b"] = 0.329411764705882,
					["g"] = 0.752941176470588,
					["r"] = 0.972549019607843,
				},
				["Main3"] = {
					["b"] = 0.941176470588235,
					["g"] = 0.996078431372549,
					["r"] = 0.588235294117647,
				},
				["Main1"] = {
					["b"] = 0.941176470588235,
					["g"] = 0.996078431372549,
					["r"] = 0.588235294117647,
				},
			},
			["MEKA_Focus"] = {
				["PosY"] = 160,
				["PosX"] = -500,
			},
			["MEKA_FCS"] = {
				["Enable"] = true,
			},
			["Quafe_Container"] = {
				["Enable"] = false,
				["RefreshRate"] = "Always",
				["Gold"] = {
					["Player-4755-019BE4A6"] = {
						["Gold"] = 0,
						["Class"] = "HUNTER",
						["Name"] = "Adhd",
						["Realm"] = "Dreadmist",
					},
					["Player-4755-016E49E3"] = {
						["Gold"] = 0,
						["Class"] = "MAGE",
						["Name"] = "Bankk",
						["Realm"] = "Dreadmist",
					},
				},
			},
			["MEKA_CastBar"] = {
				["Enable"] = true,
				["PlayerCastBar"] = true,
			},
			["Quafe_InfoBar"] = {
				["Enable"] = true,
				["MBC"] = true,
			},
			["Quafe_ChatFrame"] = {
				["Enable"] = true,
			},
			["MEKA_IFF"] = {
				["Enable"] = true,
				["BuffLimit"] = 12,
				["DebuffLimit"] = 12,
				["Scale"] = 1,
			},
			["Quafe_BuffFrame"] = {
				["Enable"] = true,
				["PosY"] = -97.5315868377694,
				["PosX"] = -596.208196411134,
			},
			["MEKA_HUD"] = {
				["State"] = "LOOP",
				["RingTopLeftTrack"] = "ABSORB",
				["Scale"] = 0.6,
				["CombatShow"] = true,
				["LoopPowerNum"] = true,
			},
			["Quafe_ExpBar"] = {
				["Enable"] = true,
				["Azerite"] = true,
			},
			["MEKA_BossFrame"] = {
				["Enable"] = true,
				["PosY"] = -100,
				["PosX"] = -340,
			},
			["MEKA_Class"] = {
				["Enable"] = true,
				["AutoShot"] = true,
				["Rune"] = true,
				["ClassPoint"] = true,
			},
		},
	},
	["Global"] = {
		["AuraWatch"] = {
			["HUNTER"] = {
				{
					{
						["Show"] = true,
						["Style"] = "MEKA_BR",
						["Caster"] = "player",
						["Aura"] = "1978",
						["AuraColor"] = {
							["r"] = 0.611764705882353,
							["g"] = 0.8,
							["b"] = 0.396078431372549,
						},
						["Unit"] = "target",
					}, -- [1]
				}, -- [1]
			},
			["WARLOCK"] = {
				{
					{
						["Show"] = true,
						["Caster"] = "player",
						["Style"] = "MEKA_BR",
						["Aura"] = "980",
						["Color"] = {
							["r"] = 245,
							["g"] = 81,
							["b"] = 44,
						},
						["Filter"] = "Debuff",
						["AuraColor"] = {
							["b"] = 0.36078431372549,
							["g"] = 0.36078431372549,
							["r"] = 0.988235294117647,
						},
						["Unit"] = "target",
					}, -- [1]
					{
						["Show"] = true,
						["Style"] = "MEKA_BR",
						["Caster"] = "player",
						["Aura"] = "172",
						["AuraColor"] = {
							["b"] = 0.47843137254902,
							["g"] = 0.250980392156863,
							["r"] = 0.925490196078432,
						},
						["Unit"] = "target",
					}, -- [2]
					{
						["Show"] = true,
						["Style"] = "MEKA_BR",
						["Caster"] = "player",
						["Aura"] = "707",
						["AuraColor"] = {
							["b"] = 0.243137254901961,
							["g"] = 0.835294117647059,
							["r"] = 0.980392156862745,
						},
						["Unit"] = "target",
					}, -- [3]
				}, -- [1]
			},
		},
	},
	["Reset"] = false,
}
