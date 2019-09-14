local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

local LOCALE = {}

--- ------------------------------------------------------------
--> General
--- ------------------------------------------------------------

LOCALE['ON'] = "開啓"
LOCALE['OFF'] = "關閉"
LOCALE['INVALID'] = "無效"
LOCALE['START'] = "開始"
LOCALE['OK'] = "確認"
LOCALE['CONFIRM'] = "確認"
LOCALE['LATER'] = "稍後"
LOCALE['YES'] = "是的"
LOCALE['NO'] = "不"
LOCALE['BACK'] = "返回"
LOCALE['EXIT'] = "退出"
LOCALE['CANCEL'] = "取消"
LOCALE['DELETE'] = '刪除'

LOCALE['NEW'] = '新建'
LOCALE['COPY'] = '複製'
LOCALE['RENAME'] = '重命名'
LOCALE['EDIT'] = '編輯'

LOCALE['SHOW'] = '顯示'
LOCALE['HIDE'] = '隱藏'

--- ------------------------------------------------------------
--> Unit
--- ------------------------------------------------------------

LOCALE['PLAYER'] = '玩家'
LOCALE['TARGET'] = '目標'
LOCALE['PET'] = '寵物'
LOCALE['FOCUS'] = '焦點'
LOCALE['ALL_UNIT'] = '所有單位'

--- ------------------------------------------------------------
--> Communication Menu
--- ------------------------------------------------------------

LOCALE['BINDING_COMMUNICATIONMENU'] = '交流菜單'
LOCALE['THANK'] = "感謝"
LOCALE['HELLO'] = "你好"
LOCALE['DANCE'] = "跳舞"
LOCALE['HEALME'] = "需要治療"
LOCALE['RUDE'] = "粗魯"
LOCALE['AUTOLOOT'] = "自動拾取"
LOCALE['SHEATHE'] = "收起武器" 
LOCALE['UNSHEATHE'] = "拿出武器"

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
    [9] = "巔峰",
}

--- -----------------------------------------------------------
--> 信息栏
--- -----------------------------------------------------------

LOCALE['MBC'] = "小地圖按鈕收集"
LOCALE['FRIEND'] = "好友"
LOCALE['WEEKDAY_LIST'] = {"星期日","星期一","星期二","星期三","星期四","星期五","星期六"}
LOCALE['MOUTH_LIST'] = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"}
LOCALE['DAY'] = "日"

--- -----------------------------------------------------------
--> LRD
--- -----------------------------------------------------------

LOCALE['MEETINGSTONE'] = "集合石"
LOCALE['申请人数'] = "申請人數"
LOCALE['申请中活动'] = "申請中的活動"
LOCALE['“%s”总数'] = "“%s”總數"
LOCALE['活动总数'] = "活動總數"
LOCALE['关注请求'] = "關注請求"

--- -----------------------------------------------------------
--> 小地图
--- -----------------------------------------------------------

LOCALE['NO_MAIL'] = "沒有郵件"

--- -----------------------------------------------------------
--> 设置界面
--- -----------------------------------------------------------

LOCALE['CONFIG_CONFIG'] = 'CONFIG'
LOCALE['CONFIG_AURAWATCH'] = 'AURAWATCH'
LOCALE['CONFIG_CONTROLS'] = 'CONTROLS'
LOCALE['CONFIG_PROFILE'] = 'PROFILE'

LOCALE['INVALID'] = "無效"
LOCALE['SCALE'] = "縮放比例"
LOCALE['STYLE'] = '樣式'
LOCALE['DEFAULT'] = '默認'
LOCALE['PROFILE_NAME'] = '配置文件名稱'
LOCALE['NEW_PROFILE'] = '新建配置文件'

LOCALE['RELOAD_TO_APPLY'] = "設置已儲存  重載界面后生效"
LOCALE['APPLY_RELOAD'] = "點擊確認按鈕將立即重載界面"
LOCALE['RESET_TEXT1'] = ""
LOCALE['RESET_TEXT2'] = ""

LOCALE['OBJECTIVE_TRACKER'] = "任務追蹤"
LOCALE['COMMUNICATION_MENU'] = '交流菜單'
LOCALE['BUFF_FRAME'] = 'Aura框體'
LOCALE['CHAT_FRAME'] = '聊天框體'
LOCALE['CAST_BAR'] = '施法條'
LOCALE['MINI_MAP'] = '小地圖'

--> 移动框体
LOCALE['MOVE_FRAME'] = "移動框體"
LOCALE['RESET_POSITION'] = '恢復默認位置'

--> Scale
LOCALE['AUTO_SCALE'] = "自動縮放"
LOCALE['FIX_SCALE'] = "修復縮放"

--> Color
LOCALE['COLOR'] = "顔色"
LOCALE['User-Defined'] = "自定義"

--> Mouse
LOCALE['MOUSE'] = "滑鼠"
LOCALE['RAW_MOUSE'] = "原生滑鼠（Raw Mouse）"
LOCALE['MOUSE_POLLING'] = "滑鼠數據更新頻率（Hz）"
LOCALE['MOUSE_RESOLUTION'] = "滑鼠移動的每英寸點數（DPI）"

--> Blizzard Frames
LOCALE["BLIZZARD_FRAMES"] = "魔獸默認框體"
LOCALE['PLAYER_FRAME'] = "玩家框體"
LOCALE['TARGET_FRAME'] = "目標框體"
LOCALE['FOCUS_FRAME'] = "焦點框體"
LOCALE['PARTY_FRAME'] = "小隊框體"
LOCALE['BOSS_FRAME'] = "首領框體"

--> Action Bar
LOCALE['ACTION_BAR'] = '動作條'
LOCALE['ACTION_STYLE_RING'] = "圓形"

--> Watcher
LOCALE['FCS'] = '技能監控'
LOCALE['ICON'] = '圖標'
LOCALE['AURA'] = 'Aura'
LOCALE['SPELL'] = '技能'
LOCALE['COLOR'] = '顔色'
LOCALE['UNIT'] = '單位'
LOCALE['CASTER'] = '施法者'
LOCALE['ADD'] = '增添'
LOCALE['ADD_FCS'] = '增添技能監控'
LOCALE['LOAD_DEFAULT'] = '載入默認設置'
LOCALE["MEKA_BL"] = 'MEKA 計時條 左'
LOCALE["MEKA_BR"] = 'MEKA 計時條 右'
LOCALE["MEKA_IL"] = 'MEKA 圖標 左'
LOCALE["MEKA_IR"] = 'MEKA 圖標 右'

--> Bag
LOCALE['SELL_JUNK'] = '賣出垃圾物品'
LOCALE['BAG'] = '背包'
LOCALE['GROUP_REFRESH_RATE'] = '分組刷新頻率'
LOCALE['BAG_GROUP_REFRESH'] = '刷新背包分組'
LOCALE['手动刷新'] = '手動刷新'
LOCALE['关闭时刷新'] = '關閉時刷新'
LOCALE['实时刷新'] = '實時刷新'
LOCALE['重置金币数据'] = '重置金幣數據'
LOCALE['背包金币数据已重置'] = '背包金幣數據已重置'

--> Assistant
LOCALE['ASSISTANT'] = '附件'
LOCALE['RESURRECTION_NOTIFICATION'] = '戰鬥中復生通知'
LOCALE['SKIN_ORDERHALL'] = '美化職業大廳信息欄'

--> CastingBar
LOCALE['施法条'] = '施法條'

--> ClassPowerBar
LOCALE['CLASS'] = '職業'
LOCALE['CLASS_POINT'] = '職業能量條和連擊點'

--> InfoBar
LOCALE['INFO_BAR'] = '信息欄'
LOCALE['经验条'] = '經驗條'
LOCALE['艾泽里特'] = '艾澤里特'

--> HUD
LOCALE['POWER_NUM'] = '能量數字'
LOCALE['MEKAHUD'] = {
	["OFF"] = '關閉',
	['LOOP'] = 'LOOP',
	['RING'] = 'RING',
}
LOCALE['RING_TOPLEFT'] = '左上角顯示'
LOCALE['RING_TL'] = {
	["COMBO"] = '連擊點',
	["ABSORB"] = '吸收量',
}
LOCALE['COMBAT_SHOW'] = '進入戰鬥時顯示'

--> IFF
LOCALE['IFF'] = '目標和焦點'
LOCALE['BUFF_LIMIT_NUM'] = '增益處最大數量'
LOCALE['DEBUFF_LIMIT_NUM'] = '減益處最大數量'

--> PartyRaid
LOCALE['PARTY_RAID'] = '小隊和團隊'
LOCALE['RAID5'] = '治療用小隊框體'

--> MinimapIcon
LOCALE['MINIMAPICON_LEFT_CLICK'] = '左鍵點擊: 打開設置界面'

---------------------------------------------------------------
--> 经典怀旧服
---------------------------------------------------------------

LOCALE['AUTOSHOT_BAR'] = '自動射擊條'

---------------------------------------------------------------
--> 
---------------------------------------------------------------

C.Locale["zhTW"] = LOCALE