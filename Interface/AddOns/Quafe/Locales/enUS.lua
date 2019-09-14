local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

local LOCALE = {}

--- ------------------------------------------------------------
--> General
--- ------------------------------------------------------------

LOCALE['ON'] = "ON"
LOCALE['OFF'] = "OFF"
LOCALE['INVALID'] = "INVALID"
LOCALE['START'] = "Start"
LOCALE['OK'] = "OK"
LOCALE['CONFIRM'] = "Confirm"
LOCALE['LATER'] = "Later"
LOCALE['YES'] = "Yes"
LOCALE['NO'] = "No"
LOCALE['BACK'] = "Back"
LOCALE['EXIT'] = "Exit"
LOCALE['CANCEL'] = "Cancel"
LOCALE['DELETE'] = 'Delete'

LOCALE['NEW'] = 'New'
LOCALE['COPY'] = 'Copy'
LOCALE['RENAME'] = 'Rename'
LOCALE['EDIT'] = 'Edit'

LOCALE['SHOW'] = 'Show'
LOCALE['HIDE'] = 'Hide'

--- ------------------------------------------------------------
--> Unit
--- ------------------------------------------------------------

LOCALE['PLAYER'] = 'Player'
LOCALE['TARGET'] = 'Target'
LOCALE['PET'] = 'Pet'
LOCALE['FOCUS'] = 'Focus'
LOCALE['ALL_UNIT'] = 'All Unit'

--- ------------------------------------------------------------
--> Communication Menu
--- ------------------------------------------------------------

LOCALE['BINDING_COMMUNICATIONMENU'] = 'Binding Communication Menu'
LOCALE['THANK'] = "Thanks"
LOCALE['HELLO'] = "Hello"
LOCALE['DANCE'] = "Dance"
LOCALE['HEALME'] = "Heal me"
LOCALE['RUDE'] = "Rude"
LOCALE['AUTOLOOT'] = "Auto loot"
LOCALE['SHEATHE'] = "Sheathe" 
LOCALE['UNSHEATHE'] = "Unsheathe"

LOCALE.FactionStandingID = {
	[0] = FACTION_STANDING_LABEL0,
	[1] = FACTION_STANDING_LABEL1,
	[2] = FACTION_STANDING_LABEL2,
	[3] = FACTION_STANDING_LABEL3,
	[4] = FACTION_STANDING_LABEL4,
	[5] = FACTION_STANDING_LABEL5,
	[6] = FACTION_STANDING_LABEL6,
	[7] = FACTION_STANDING_LABEL7,
    [8] = FACTION_STANDING_LABEL8,
    [9] = "Paragón",
}

--- -----------------------------------------------------------
--> 信息栏
--- -----------------------------------------------------------

LOCALE['MBC'] = "Minimap Buttons Collect"
LOCALE['FRIEND'] = "Friends"
LOCALE['WEEKDAY_LIST'] = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}
LOCALE['MOUTH_LIST'] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
LOCALE['DAY'] = "Day"

--- -----------------------------------------------------------
--> LRD
--- -----------------------------------------------------------

LOCALE['MEETINGSTONE'] = "Meeting Stone"
LOCALE['申请人数'] = "Applications"
LOCALE['申请中活动'] = "Activities in application"
LOCALE['“%s”总数'] = "“%s”sum total"
LOCALE['活动总数'] = "Total"
LOCALE['关注请求'] = "Request attention"

--- -----------------------------------------------------------
--> 小地图
--- -----------------------------------------------------------

LOCALE['NO_MAIL'] = "No mail"

--- -----------------------------------------------------------
--> 设置界面
--- -----------------------------------------------------------

LOCALE['CONFIG_CONFIG'] = 'CONFIG'
LOCALE['CONFIG_AURAWATCH'] = 'AURAWATCH'
LOCALE['CONFIG_CONTROLS'] = 'CONTROLS'
LOCALE['CONFIG_PROFILE'] = 'PROFILE'

LOCALE['INVALID'] = "Invalid"
LOCALE['SCALE'] = "Scale"
LOCALE['STYLE'] = 'Style'
LOCALE['DEFAULT'] = 'Default'
LOCALE['PROFILE_NAME'] = 'Profile Name'
LOCALE['NEW_PROFILE'] = 'New Profile'

LOCALE['RELOAD_TO_APPLY'] = "The config has be changed, please reload UI to apply"
LOCALE['APPLY_RELOAD'] = "Click the confirm button to reload UI"
LOCALE['RESET_TEXT1'] = ""
LOCALE['RESET_TEXT2'] = ""

LOCALE['OBJECTIVE_TRACKER'] = "Object Tracker"
LOCALE['COMMUNICATION_MENU'] = 'Communication Menu'
LOCALE['BUFF_FRAME'] = 'Buff and Debuff'
LOCALE['CHAT_FRAME'] = 'Chat Frame'
LOCALE['CAST_BAR'] = 'Cast Bar'
LOCALE['MINI_MAP'] = 'Minimap'

--> 移动框体
LOCALE['MOVE_FRAME'] = "Moving Frame"
LOCALE['RESET_POSITION'] = 'Reset Position'

--> Scale
LOCALE['AUTO_SCALE'] = "Auto Scale"
LOCALE['FIX_SCALE'] = "Fix Scale"

--> Color
LOCALE['COLOR'] = "Color"
LOCALE['User-Defined'] = "User-Defined"

--> Mouse
LOCALE['MOUSE'] = "Mouse"
LOCALE['RAW_MOUSE'] = "Raw Mouse"
LOCALE['MOUSE_POLLING'] = "Mouse Polling（Hz）"
LOCALE['MOUSE_RESOLUTION'] = "Mouse Resolution（DPI）"

--> Blizzard Frames
LOCALE["BLIZZARD_FRAMES"] = "WoW Default Frames"
LOCALE['PLAYER_FRAME'] = "Player Frame"
LOCALE['TARGET_FRAME'] = "Target Frame"
LOCALE['FOCUS_FRAME'] = "Focus Frame"
LOCALE['PARTY_FRAME'] = "Party Frame"
LOCALE['BOSS_FRAME'] = "Boss Frame"

--> Action Bar
LOCALE['ACTION_BAR'] = 'Action Bar'
LOCALE['ACTION_STYLE_RING'] = "Ring"

--> Watcher
LOCALE['FCS'] = 'FCS'
LOCALE['ICON'] = 'Icon'
LOCALE['AURA'] = 'Aura'
LOCALE['SPELL'] = 'Spell'
LOCALE['COLOR'] = 'Color'
LOCALE['UNIT'] = 'Unit'
LOCALE['CASTER'] = 'Caster'
LOCALE['ADD'] = 'Add'
LOCALE['ADD_FCS'] = 'Add watcher'
LOCALE['LOAD_DEFAULT'] = 'Load the default profile'
LOCALE["MEKA_BL"] = 'MEKA Bar Left'
LOCALE["MEKA_BR"] = 'MEKA Bar Right'
LOCALE["MEKA_IL"] = 'MEKA Icon Left'
LOCALE["MEKA_IR"] = 'MEKA Icon Right'

--> Bag
LOCALE['SELL_JUNK'] = 'Sell junk'
LOCALE['BAG'] = 'Bag'
LOCALE['GROUP_REFRESH_RATE'] = 'Refresh rate'
LOCALE['BAG_GROUP_REFRESH'] = 'Refresh bag group'
LOCALE['手动刷新'] = 'Manual'
LOCALE['关闭时刷新'] = 'Refresh on closed'
LOCALE['实时刷新'] = 'Real-time refresh'
LOCALE['重置金币数据'] = 'Refresh coin data'
LOCALE['背包金币数据已重置'] = 'Coin data has be refreshed'

--> Assistant
LOCALE['ASSISTANT'] = 'Assistant'
LOCALE['RESURRECTION_NOTIFICATION'] = 'Resurrection Notification'
LOCALE['SKIN_ORDERHALL'] = 'Skin infobar of order hall'

--> CastingBar
LOCALE['施法条'] = 'Castbar'

--> ClassPowerBar
LOCALE['CLASS'] = 'Class'
LOCALE['CLASS_POINT'] = 'ClassPower Point'

--> InfoBar
LOCALE['INFO_BAR'] = 'Information bar'
LOCALE['经验条'] = 'Experience bar'
LOCALE['艾泽里特'] = 'Azerite'

--> HUD
LOCALE['POWER_NUM'] = 'Power Value'
LOCALE['MEKAHUD'] = {
	["OFF"] = 'OFF',
	['LOOP'] = 'LOOP',
	['RING'] = 'RING',
}
LOCALE['RING_TOPLEFT'] = 'TopLeft Bar Tracking'
LOCALE['RING_TL'] = {
	["COMBO"] = 'Combo',
	["ABSORB"] = 'Absorb',
}
LOCALE['COMBAT_SHOW'] = 'Showed in entering combat'

--> IFF
LOCALE['IFF'] = 'Target and Focus'
LOCALE['BUFF_LIMIT_NUM'] = 'Num limit of buff'
LOCALE['DEBUFF_LIMIT_NUM'] = 'Num limit of debuff'

--> PartyRaid
LOCALE['PARTY_RAID'] = 'Party and Raid'
LOCALE['RAID5'] = 'PartyFrame for Healer'

--> MinimapIcon
LOCALE['MINIMAPICON_LEFT_CLICK'] = 'Left click: Open settings'

---------------------------------------------------------------
--> 经典怀旧服
---------------------------------------------------------------

LOCALE['AUTOSHOT_BAR'] = 'Auto Shot Bar'

---------------------------------------------------------------
--> 
---------------------------------------------------------------

C.Locale["enUS"] = LOCALE