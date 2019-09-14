
SpartanUIDB = {
	["namespaces"] = {
		["FilmEffects"] = {
			["profiles"] = {
				["Jelq - Dreadmist"] = {
					["animationInterval"] = 0.0100000007078052,
				},
			},
		},
	},
	["profileKeys"] = {
		["Adhd - Dreadmist"] = "Adhd - Dreadmist",
		["Bankk - Dreadmist"] = "Bankk - Dreadmist",
		["Jelq - Dreadmist"] = "Jelq - Dreadmist",
	},
	["global"] = {
		["textures"] = {
			["i"] = 0,
		},
		["BartenderChangesActive"] = false,
		["Version"] = "5.2.6",
		["Bartender4"] = {
			["SpartanUI - Classic"] = {
				["Style"] = "Classic",
			},
		},
	},
	["profiles"] = {
		["Adhd - Dreadmist"] = {
			["Modules"] = {
				["StatusBars"] = {
					nil, -- [1]
					{
						["display"] = "rep",
					}, -- [2]
				},
				["PlayerFrames"] = {
					["Style"] = "War",
					["player"] = {
						["Anchors"] = {
							["relativeTo"] = "UIParent",
							["point"] = "BOTTOMRIGHT",
							["relativePoint"] = "BOTTOM",
							["yOfs"] = 250.000015258789,
							["xOfs"] = -60,
						},
					},
				},
				["NamePlates"] = {
					["elements"] = {
						["Health"] = {
						},
						["Castbar"] = {
						},
						["Name"] = {
						},
						["Power"] = {
						},
						["SUI_ClassIcon"] = {
						},
					},
				},
				["PartyFrames"] = {
					["Style"] = "War",
				},
				["RaidFrames"] = {
					["Style"] = "War",
				},
				["Objectives"] = {
					["AlwaysShowScenario"] = true,
					["SetupDone"] = true,
					["Rule2"] = {
						["Status"] = "Disabled",
						["Combat"] = false,
					},
					["Rule3"] = {
						["Status"] = "Disabled",
						["Combat"] = false,
					},
					["Rule1"] = {
						["Status"] = "Raid",
						["Combat"] = false,
					},
				},
				["Artwork"] = {
					["FirstLoad"] = false,
					["SetupDone"] = true,
					["Style"] = "War",
				},
				["TauntWatcher"] = {
					["inArena"] = true,
					["inRaid"] = true,
					["inParty"] = true,
					["FirstLaunch"] = false,
					["outdoors"] = false,
					["inBG"] = false,
				},
			},
			["SUIProper"] = {
				["AutoSell"] = {
					["FirstLaunch"] = false,
					["MaxILVL"] = 40,
				},
				["EnabledComponents"] = {
					["MailOpenAll"] = true,
					["AutoSell"] = true,
					["Tooltips"] = true,
					["Minimap"] = true,
					["CombatLog"] = true,
					["TauntWatcher"] = true,
					["AutoTurnIn"] = true,
					["Nameplates"] = true,
					["Buffs"] = true,
					["InterruptAnnouncer"] = true,
					["Objectives"] = true,
				},
				["Tooltips"] = {
					["Override"] = {
					},
					["Color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.4, -- [4]
					},
					["Rule1"] = {
						["Status"] = "All",
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["onMouse"] = false,
							["Moved"] = false,
						},
						["OverrideLoc"] = false,
						["Combat"] = false,
					},
					["Rule3"] = {
						["Status"] = "Disabled",
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["onMouse"] = false,
							["Moved"] = false,
						},
						["OverrideLoc"] = false,
						["Combat"] = false,
					},
					["SuppressNoMatch"] = true,
					["ColorOverlay"] = true,
					["VendorPrices"] = true,
					["Rule2"] = {
						["Status"] = "Disabled",
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["onMouse"] = false,
							["Moved"] = false,
						},
						["OverrideLoc"] = false,
						["Combat"] = false,
					},
					["Styles"] = {
						["none"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\blank.tga",
						},
						["smoke"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\smoke.tga",
						},
						["smooth"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\Smoothv2.tga",
						},
						["metal"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\metal.tga",
						},
					},
					["ActiveStyle"] = "smoke",
				},
				["BT4Profile"] = "SpartanUI - War",
				["font"] = {
					["SetupDone"] = true,
				},
				["Bartender4Version"] = "4.8.5",
				["SetupWizard"] = {
					["FirstLaunch"] = false,
				},
				["MailOpenAll"] = {
					["Silent"] = false,
					["FreeSpace"] = 0,
					["FirstLaunch"] = true,
				},
				["SetupDone"] = true,
				["Styles"] = {
					["Transparent"] = {
					},
					["Classic"] = {
						["Color"] = {
							["PlayerFrames"] = false,
							["Art"] = false,
							["PartyFrames"] = false,
							["RaidFrames"] = false,
						},
						["TalkingHeadUI"] = {
							["y"] = -30,
							["relPoint"] = "TOP",
							["point"] = "BOTTOM",
							["scale"] = 0.8,
							["x"] = 0,
						},
					},
					["War"] = {
						["MovedBars"] = {
							["BT4Bar4"] = false,
							["BT4Bar2"] = true,
							["BT4Bar5"] = false,
							["BT4BarBagBar"] = false,
							["BT4Bar3"] = false,
							["BT4BarPetBar"] = true,
							["BT4Bar1"] = true,
							["BT4Bar6"] = false,
						},
					},
				},
				["CombatLog"] = {
					["heroicdungeon"] = false,
					["loggingActive"] = false,
					["debug"] = false,
					["raidheroic"] = false,
					["raidlfr"] = false,
					["raidmythic"] = false,
					["raidlegacy"] = false,
					["raidnormal"] = true,
					["FirstLaunch"] = false,
					["mythicplus"] = false,
					["normaldungeon"] = false,
					["logging"] = false,
					["mythicdungeon"] = false,
					["announce"] = true,
					["alwayson"] = false,
				},
				["Version"] = "5.2.6",
				["AutoTurnIn"] = {
					["autoequip"] = true,
					["FirstLaunch"] = false,
				},
				["Buffs"] = {
					["Rule3"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["Moved"] = false,
						},
					},
					["Override"] = {
					},
					["Rule2"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["Moved"] = false,
						},
					},
					["Rule1"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["Moved"] = false,
						},
					},
				},
				["InterruptAnnouncer"] = {
					["inArena"] = true,
					["inRaid"] = true,
					["always"] = false,
					["inParty"] = true,
					["inBG"] = false,
					["outdoors"] = false,
					["includePets"] = true,
					["text"] = "Interrupted %t %spell",
					["announceLocation"] = "SMART",
					["FirstLaunch"] = false,
				},
			},
		},
		["Bankk - Dreadmist"] = {
			["Modules"] = {
				["Objectives"] = {
					["AlwaysShowScenario"] = true,
					["SetupDone"] = true,
					["Rule2"] = {
						["Status"] = "Disabled",
						["Combat"] = false,
					},
					["Rule3"] = {
						["Status"] = "Disabled",
						["Combat"] = false,
					},
					["Rule1"] = {
						["Status"] = "Raid",
						["Combat"] = false,
					},
				},
				["StatusBars"] = {
					nil, -- [1]
					{
						["display"] = "rep",
					}, -- [2]
				},
				["Artwork"] = {
					["SetupDone"] = true,
					["FirstLoad"] = false,
					["Style"] = "Classic",
					["Viewport"] = {
						["offset"] = {
							["bottom"] = 2.8,
						},
					},
				},
				["PlayerFrames"] = {
					["target"] = {
						["Anchors"] = {
							["relativeTo"] = "UIParent",
							["point"] = "BOTTOMLEFT",
							["relativePoint"] = "TOP",
							["yOfs"] = -3,
							["xOfs"] = 54,
						},
					},
				},
				["NamePlates"] = {
					["elements"] = {
						["Name"] = {
						},
						["Power"] = {
						},
						["Health"] = {
						},
						["Castbar"] = {
						},
						["SUI_ClassIcon"] = {
						},
					},
				},
				["TauntWatcher"] = {
					["inArena"] = true,
					["inRaid"] = true,
					["inBG"] = false,
					["inParty"] = true,
					["outdoors"] = false,
					["FirstLaunch"] = false,
				},
			},
			["SUIProper"] = {
				["MailOpenAll"] = {
					["Silent"] = false,
					["FreeSpace"] = 0,
					["FirstLaunch"] = true,
				},
				["Styles"] = {
					["War"] = {
					},
					["Classic"] = {
						["Color"] = {
							["PlayerFrames"] = false,
							["Art"] = false,
							["PartyFrames"] = false,
							["RaidFrames"] = false,
						},
						["TalkingHeadUI"] = {
							["y"] = -30,
							["relPoint"] = "TOP",
							["point"] = "BOTTOM",
							["scale"] = 0.8,
							["x"] = 0,
						},
					},
					["Transparent"] = {
					},
				},
				["InterruptAnnouncer"] = {
					["inArena"] = true,
					["inRaid"] = true,
					["always"] = false,
					["inParty"] = true,
					["inBG"] = false,
					["outdoors"] = false,
					["includePets"] = true,
					["text"] = "Interrupted %t %spell",
					["announceLocation"] = "SMART",
					["FirstLaunch"] = false,
				},
				["EnabledComponents"] = {
					["MailOpenAll"] = true,
					["AutoSell"] = true,
					["Tooltips"] = true,
					["Minimap"] = true,
					["CombatLog"] = true,
					["TauntWatcher"] = true,
					["Buffs"] = true,
					["Nameplates"] = true,
					["AutoTurnIn"] = true,
					["InterruptAnnouncer"] = true,
					["Objectives"] = true,
				},
				["SetupDone"] = true,
				["Bartender4Version"] = "4.8.5",
				["Tooltips"] = {
					["Override"] = {
					},
					["Color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.4, -- [4]
					},
					["Rule1"] = {
						["Status"] = "All",
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["onMouse"] = false,
							["Moved"] = false,
						},
						["Combat"] = false,
						["OverrideLoc"] = false,
					},
					["Rule3"] = {
						["Status"] = "Disabled",
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["onMouse"] = false,
							["Moved"] = false,
						},
						["Combat"] = false,
						["OverrideLoc"] = false,
					},
					["SuppressNoMatch"] = true,
					["ColorOverlay"] = true,
					["VendorPrices"] = true,
					["Rule2"] = {
						["Status"] = "Disabled",
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["onMouse"] = false,
							["Moved"] = false,
						},
						["Combat"] = false,
						["OverrideLoc"] = false,
					},
					["Styles"] = {
						["none"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\blank.tga",
						},
						["smoke"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\smoke.tga",
						},
						["smooth"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\Smoothv2.tga",
						},
						["metal"] = {
							["tile"] = false,
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\metal.tga",
						},
					},
					["ActiveStyle"] = "smoke",
				},
				["Buffs"] = {
					["Rule3"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["Moved"] = false,
						},
					},
					["Override"] = {
					},
					["Rule2"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["Moved"] = false,
						},
					},
					["Rule1"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["AnchorPos"] = {
							},
							["Moved"] = false,
						},
					},
				},
				["Version"] = "5.2.6",
				["font"] = {
					["SetupDone"] = true,
				},
				["BT4Profile"] = "Bankk - Dreadmist",
				["AutoSell"] = {
					["MaxILVL"] = 40,
					["FirstLaunch"] = false,
				},
				["CombatLog"] = {
					["heroicdungeon"] = false,
					["loggingActive"] = false,
					["debug"] = false,
					["raidheroic"] = true,
					["raidlfr"] = false,
					["raidmythic"] = true,
					["raidlegacy"] = false,
					["raidnormal"] = true,
					["FirstLaunch"] = false,
					["mythicplus"] = true,
					["normaldungeon"] = false,
					["logging"] = false,
					["mythicdungeon"] = false,
					["announce"] = true,
					["alwayson"] = false,
				},
				["AutoTurnIn"] = {
					["FirstLaunch"] = false,
				},
				["SetupWizard"] = {
					["FirstLaunch"] = false,
				},
				["yoffset"] = 1,
			},
		},
		["Jelq - Dreadmist"] = {
			["Modules"] = {
				["TauntWatcher"] = {
					["inArena"] = true,
					["inRaid"] = true,
					["inBG"] = false,
					["inParty"] = true,
					["outdoors"] = false,
					["FirstLaunch"] = false,
				},
				["PartyFrames"] = {
					["Style"] = "War",
				},
				["RaidFrames"] = {
					["Style"] = "War",
				},
				["StatusBars"] = {
					nil, -- [1]
					{
						["display"] = "rep",
					}, -- [2]
				},
				["Artwork"] = {
					["SetupDone"] = true,
					["FirstLoad"] = false,
					["Style"] = "War",
				},
				["PlayerFrames"] = {
					["Style"] = "War",
				},
				["NamePlates"] = {
					["elements"] = {
						["Health"] = {
						},
						["Castbar"] = {
						},
						["Name"] = {
						},
						["Power"] = {
						},
						["SUI_ClassIcon"] = {
						},
					},
				},
				["Objectives"] = {
					["AlwaysShowScenario"] = true,
					["SetupDone"] = true,
					["Rule2"] = {
						["Status"] = "Disabled",
						["Combat"] = false,
					},
					["Rule1"] = {
						["Status"] = "Raid",
						["Combat"] = false,
					},
					["Rule3"] = {
						["Status"] = "Disabled",
						["Combat"] = false,
					},
				},
			},
			["SUIProper"] = {
				["MailOpenAll"] = {
					["Silent"] = false,
					["FreeSpace"] = 0,
					["FirstLaunch"] = true,
				},
				["AutoSell"] = {
					["MaxILVL"] = 40,
					["AutoRepair"] = true,
					["FirstLaunch"] = false,
				},
				["Styles"] = {
					["Classic"] = {
						["Color"] = {
							["Art"] = false,
							["PlayerFrames"] = false,
							["PartyFrames"] = false,
							["RaidFrames"] = false,
						},
						["TalkingHeadUI"] = {
							["y"] = -30,
							["relPoint"] = "TOP",
							["point"] = "BOTTOM",
							["scale"] = 0.8,
							["x"] = 0,
						},
					},
					["Fel"] = {
						["SubTheme"] = "Digital",
					},
					["War"] = {
					},
					["Transparent"] = {
						["MovedBars"] = {
							["BT4Bar4"] = false,
							["BT4Bar2"] = false,
							["BT4Bar5"] = false,
							["BT4BarBagBar"] = false,
							["BT4Bar3"] = false,
							["BT4Bar1"] = false,
							["BT4Bar6"] = false,
						},
					},
				},
				["MiniMap"] = {
					["ManualAllowUse"] = true,
					["AutoDetectAllowUse"] = false,
					["ManualAllowPrompt"] = "0",
				},
				["SetupDone"] = true,
				["EnabledComponents"] = {
					["MailOpenAll"] = true,
					["AutoSell"] = true,
					["Tooltips"] = true,
					["Minimap"] = true,
					["CombatLog"] = true,
					["Objectives"] = true,
					["InterruptAnnouncer"] = true,
					["Nameplates"] = true,
					["Buffs"] = true,
					["AutoTurnIn"] = true,
					["TauntWatcher"] = true,
				},
				["Tooltips"] = {
					["Override"] = {
					},
					["Color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.4, -- [4]
					},
					["Rule1"] = {
						["Status"] = "All",
						["OverrideLoc"] = false,
						["Combat"] = false,
						["Anchor"] = {
							["Moved"] = false,
							["onMouse"] = false,
							["AnchorPos"] = {
							},
						},
					},
					["ActiveStyle"] = "smoke",
					["Styles"] = {
						["metal"] = {
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\metal.tga",
							["tile"] = false,
						},
						["smoke"] = {
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\smoke.tga",
							["tile"] = false,
						},
						["smooth"] = {
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\Smoothv2.tga",
							["tile"] = false,
						},
						["none"] = {
							["bgFile"] = "Interface\\AddOns\\SpartanUI\\media\\blank.tga",
							["tile"] = false,
						},
					},
					["VendorPrices"] = true,
					["ColorOverlay"] = true,
					["Rule2"] = {
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Combat"] = false,
						["Anchor"] = {
							["Moved"] = false,
							["onMouse"] = false,
							["AnchorPos"] = {
							},
						},
					},
					["SuppressNoMatch"] = true,
					["Rule3"] = {
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Combat"] = false,
						["Anchor"] = {
							["Moved"] = false,
							["onMouse"] = false,
							["AnchorPos"] = {
							},
						},
					},
				},
				["AutoTurnIn"] = {
					["autoequip"] = true,
					["FirstLaunch"] = false,
				},
				["Version"] = "5.2.6",
				["CombatLog"] = {
					["heroicdungeon"] = false,
					["loggingActive"] = false,
					["debug"] = false,
					["raidheroic"] = false,
					["raidlfr"] = false,
					["alwayson"] = false,
					["raidlegacy"] = false,
					["raidnormal"] = false,
					["FirstLaunch"] = false,
					["mythicplus"] = false,
					["mythicdungeon"] = false,
					["logging"] = false,
					["normaldungeon"] = false,
					["announce"] = true,
					["raidmythic"] = false,
				},
				["BT4Profile"] = "SpartanUI - War",
				["Buffs"] = {
					["Rule1"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["Moved"] = false,
							["AnchorPos"] = {
							},
						},
					},
					["Override"] = {
					},
					["Rule2"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["Moved"] = false,
							["AnchorPos"] = {
							},
						},
					},
					["Rule3"] = {
						["offset"] = 0,
						["Combat"] = false,
						["Status"] = "Disabled",
						["OverrideLoc"] = false,
						["Anchor"] = {
							["Moved"] = false,
							["AnchorPos"] = {
							},
						},
					},
				},
				["font"] = {
					["SetupDone"] = true,
				},
				["Bartender4Version"] = "4.8.5",
				["SetupWizard"] = {
					["FirstLaunch"] = false,
				},
				["InterruptAnnouncer"] = {
					["inArena"] = true,
					["inRaid"] = true,
					["always"] = false,
					["inParty"] = true,
					["inBG"] = false,
					["outdoors"] = false,
					["text"] = "Interrupted %t %spell",
					["includePets"] = true,
					["FirstLaunch"] = false,
					["announceLocation"] = "SMART",
				},
			},
		},
	},
}
