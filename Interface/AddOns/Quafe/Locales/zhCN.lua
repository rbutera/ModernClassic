local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale

local LOCALE = {}

--- ------------------------------------------------------------
--> General
--- ------------------------------------------------------------

LOCALE['ON'] = "开启"
LOCALE['OFF'] = "关闭"
LOCALE['INVALID'] = "无效"
LOCALE['START'] = "开始"
LOCALE['OK'] = "确认"
LOCALE['CONFIRM'] = "确认"
LOCALE['LATER'] = "稍后"
LOCALE['YES'] = "是的"
LOCALE['NO'] = "不"
LOCALE['BACK'] = "返回"
LOCALE['EXIT'] = "退出"
LOCALE['CANCEL'] = "取消"
LOCALE['DELETE'] = '删除'

LOCALE['NEW'] = '新建'
LOCALE['COPY'] = '复制'
LOCALE['RENAME'] = '重命名'
LOCALE['EDIT'] = '编辑'

LOCALE['SHOW'] = '显示'
LOCALE['HIDE'] = '隐藏'

--- ------------------------------------------------------------
--> Unit
--- ------------------------------------------------------------

LOCALE['PLAYER'] = '玩家'
LOCALE['TARGET'] = '目标'
LOCALE['PET'] = '宠物'
LOCALE['FOCUS'] = '焦点'
LOCALE['ALL_UNIT'] = '所有人'

--- ------------------------------------------------------------
--> Communication Menu
--- ------------------------------------------------------------

LOCALE['BINDING_COMMUNICATIONMENU'] = '交流菜单'
LOCALE['THANK'] = "感谢"
LOCALE['HELLO'] = "你好"
LOCALE['DANCE'] = "跳舞"
LOCALE['HEALME'] = "需要治疗"
LOCALE['RUDE'] = "粗鲁"
LOCALE['AUTOLOOT'] = "自动拾取"
LOCALE['SHEATHE'] = "收起武器" 
LOCALE['UNSHEATHE'] = "取出武器"

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
    [9] = "巅峰",
}

--- -----------------------------------------------------------
--> 信息栏
--- -----------------------------------------------------------

LOCALE['MBC'] = "小地图按钮收集"
LOCALE['FRIEND'] = "好友"
LOCALE['WEEKDAY_LIST'] = {"星期日","星期一","星期二","星期三","星期四","星期五","星期六"}
LOCALE['MOUTH_LIST'] = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"}
LOCALE['DAY'] = "日"

--- -----------------------------------------------------------
--> LRD
--- -----------------------------------------------------------

LOCALE['MEETINGSTONE'] = "集合石"
LOCALE['申请人数'] = "申请人数"
LOCALE['申请中活动'] = "申请中活动"
LOCALE['“%s”总数'] = "“%s”总数"
LOCALE['活动总数'] = "活动总数"
LOCALE['关注请求'] = "关注请求"

--- -----------------------------------------------------------
--> 小地图
--- -----------------------------------------------------------

LOCALE['NO_MAIL'] = "没有邮件"

--- -----------------------------------------------------------
--> 设置界面
--- -----------------------------------------------------------

LOCALE['CONFIG_CONFIG'] = 'CONFIG'
LOCALE['CONFIG_AURAWATCH'] = 'AURAWATCH'
LOCALE['CONFIG_CONTROLS'] = 'CONTROLS'
LOCALE['CONFIG_PROFILE'] = 'PROFILE'

LOCALE['INVALID'] = "无效"
LOCALE['SCALE'] = "缩放比例"
LOCALE['STYLE'] = '样式'
LOCALE['DEFAULT'] = '默认'
LOCALE['PROFILE_NAME'] = '配置文件名称'
LOCALE['NEW_PROFILE'] = '新建配置文件'

LOCALE['RELOAD_TO_APPLY'] = "设置已保存  重载界面后生效"
LOCALE['APPLY_RELOAD'] = "点击确认将立即重载界面"
LOCALE['RESET_TEXT1'] = ""
LOCALE['RESET_TEXT2'] = ""

LOCALE['OBJECTIVE_TRACKER'] = "任务追踪"
LOCALE['COMMUNICATION_MENU'] = '交流菜单'
LOCALE['BUFF_FRAME'] = '增益减益栏'
LOCALE['CHAT_FRAME'] = '聊天栏'
LOCALE['CAST_BAR'] = '施法条'
LOCALE['MINI_MAP'] = '小地图'

--> 移动框体
LOCALE['MOVE_FRAME'] = "移动框体"
LOCALE['RESET_POSITION'] = '恢复默认位置'

--> Scale
LOCALE['AUTO_SCALE'] = "自动缩放"
LOCALE['FIX_SCALE'] = "修复缩放"

--> Color
LOCALE['COLOR'] = "颜色"
LOCALE['User-Defined'] = "自定义"

--> Mouse
LOCALE['MOUSE'] = "鼠标"
LOCALE['RAW_MOUSE'] = "原生鼠标（Raw Mouse）"
LOCALE['MOUSE_POLLING'] = "鼠标数据更新频率（Hz）"
LOCALE['MOUSE_RESOLUTION'] = "鼠标移动的每英寸点数（DPI）"

--> Blizzard Frames
LOCALE["BLIZZARD_FRAMES"] = "暴雪默认框体"
LOCALE['PLAYER_FRAME'] = "玩家框体"
LOCALE['TARGET_FRAME'] = "目标框体"
LOCALE['FOCUS_FRAME'] = "焦点框体"
LOCALE['PARTY_FRAME'] = "小队框体"
LOCALE['BOSS_FRAME'] = "首领框体"

--> Action Bar
LOCALE['ACTION_BAR'] = '动作条'
LOCALE['ACTION_STYLE_RING'] = "圆形"

--> Watcher
LOCALE['FCS'] = '技能监控'
LOCALE['ICON'] = '图标'
LOCALE['AURA'] = '增益减益'
LOCALE['SPELL'] = '技能'
LOCALE['COLOR'] = '颜色'
LOCALE['UNIT'] = '单位'
LOCALE['CASTER'] = '施法者'
LOCALE['ADD'] = '添加'
LOCALE['ADD_FCS'] = '添加技能监控'
LOCALE['LOAD_DEFAULT'] = '载入默认设置'
LOCALE["MEKA_BL"] = 'MEKA 计时条 左'
LOCALE["MEKA_BR"] = 'MEKA 计时条 右'
LOCALE["MEKA_IL"] = 'MEKA 图标 左'
LOCALE["MEKA_IR"] = 'MEKA 图标 右'

--> Bag
LOCALE['SELL_JUNK'] = '卖出垃圾物品'
LOCALE['BAG'] = '背包'
LOCALE['GROUP_REFRESH_RATE'] = '分组刷新频率'
LOCALE['BAG_GROUP_REFRESH'] = '刷新背包分组'
LOCALE['手动刷新'] = '手动刷新'
LOCALE['关闭时刷新'] = '关闭时刷新'
LOCALE['实时刷新'] = '实时刷新'
LOCALE['重置金币数据'] = '重置金币数据'
LOCALE['背包金币数据已重置'] = '背包金币数据已重置'

--> Assistant
LOCALE['ASSISTANT'] = '附件'
LOCALE['RESURRECTION_NOTIFICATION'] = '战斗中复生通知'
LOCALE['SKIN_ORDERHALL'] = '美化职业大厅信息栏'

--> CastingBar
LOCALE['施法条'] = '施法条'

--> ClassPowerBar
LOCALE['CLASS'] = '职业'
LOCALE['CLASS_POINT'] = '职业能量条和连击点'

--> InfoBar
LOCALE['INFO_BAR'] = '信息栏'
LOCALE['经验条'] = '经验条'
LOCALE['艾泽里特'] = '艾泽里特'

--> HUD
LOCALE['POWER_NUM'] = '能量数字'
LOCALE['MEKAHUD'] = {
	["OFF"] = '关闭',
	['LOOP'] = 'LOOP',
	['RING'] = 'RING',
}
LOCALE['RING_TOPLEFT'] = '左上角显示'
LOCALE['RING_TL'] = {
	["COMBO"] = '连击点',
	["ABSORB"] = '吸收量',
}
LOCALE['COMBAT_SHOW'] = '进入战斗时显示'

--> IFF
LOCALE['IFF'] = '目标和焦点'
LOCALE['BUFF_LIMIT_NUM'] = '增益最大数量'
LOCALE['DEBUFF_LIMIT_NUM'] = '减益最大数量'

--> PartyRaid
LOCALE['PARTY_RAID'] = '小队和团队'
LOCALE['RAID5'] = '治疗用小队框体'

--> MinimapIcon
LOCALE['MINIMAPICON_LEFT_CLICK'] = '左键点击: 打开设置界面'

---------------------------------------------------------------
--> 经典怀旧服
---------------------------------------------------------------

LOCALE['AUTOSHOT_BAR'] = '自动射击条'

---------------------------------------------------------------
--> 
---------------------------------------------------------------

C.Locale["zhCN"] = LOCALE