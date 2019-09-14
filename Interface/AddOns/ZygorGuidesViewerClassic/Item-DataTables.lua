local ZGV = ZygorGuidesViewer

local ItemScore = {}
ZGV.ItemScore = ItemScore

-- Stat keywords:
-- Only stats defined in this table are valid. Use entry in blizz when filling rule sets

ItemScore.Keywords = {
	[1] = {blizz="AGILITY", zgvdisplay="Agility",regex=ITEM_MOD_AGILITY},
	[2] = {blizz="INTELLECT", zgvdisplay="Intellect",regex=ITEM_MOD_INTELLECT},
	[3] = {blizz="SPIRIT", zgvdisplay="Spirit",regex=ITEM_MOD_SPIRIT},
	[4] = {blizz="STAMINA", zgvdisplay="Stamina",regex=ITEM_MOD_STAMINA},
	[5] = {blizz="STRENGTH", zgvdisplay="Strength",regex=ITEM_MOD_STRENGTH},
	[6] = {blizz="ARMOR", zgvdisplay="Armor",regex=ARMOR_TEMPLATE}, -- base armor on gear
	[7] = {blizz="ARMOR_PENETRATION", zgvdisplay="Armor Penetration",regex=ITEM_MOD_ARMOR_PENETRATION_RATING},
	[8] = {blizz="ATTACK_POWER", zgvdisplay="Attack Power",regex=ITEM_MOD_ATTACK_POWER},
	[9] = {blizz="BLOCK", zgvdisplay="Block",regex=ITEM_MOD_BLOCK_RATING},
	[10] = {blizz="BLOCK_VALUE", zgvdisplay="Block Value",regex=ITEM_MOD_BLOCK_VALUE},
	[11] = {blizz="CRIT", zgvdisplay="Critical Strike %",regex=ITEM_MOD_CRIT_RATING},
	[12] = {blizz="CRIT_MELEE", zgvdisplay="Critical Strike Melee %",regex=ITEM_MOD_CRIT_MELEE_RATING},
	[13] = {blizz="CRIT_RANGED", zgvdisplay="Critical Strike Ranged %",regex=ITEM_MOD_CRIT_RANGED_RATING},
	[14] = {blizz="CRIT_SPELL", zgvdisplay="Critical Strike Spell% ",regex=ITEM_MOD_CRIT_SPELL_RATING},
	[15] = {blizz="DAMAGE_PER_SECOND", zgvdisplay="Damage Per Second",regex=DPS_TEMPLATE},
	[16] = {blizz="DEFENSE_SKILL", zgvdisplay="Defense",regex=ITEM_MOD_DEFENSE_SKILL_RATING},
	[17] = {blizz="DODGE", zgvdisplay="Dodge",regex=ITEM_MOD_DODGE_RATING},
	[18] = {blizz="EXTRA_ARMOR", zgvdisplay="Extra Armor",regex=ITEM_MOD_EXTRA_ARMOR},
	[19] = {blizz="FERAL_ATTACK_POWER", zgvdisplay="Feral Attack Power",regex=ITEM_MOD_FERAL_ATTACK_POWER},
	[20] = {blizz="HEALTH_REGEN", zgvdisplay="Health Per 5 Sec.",regex=ITEM_MOD_HEALTH_REGEN},
	[21] = {blizz="HEALTH_REGENERATION", zgvdisplay="Health Regeneration",regex=ITEM_MOD_HEALTH_REGEN},
	[22] = {blizz="HEALTH", zgvdisplay="Health",regex=ITEM_MOD_HEALTH},
	[23] = {blizz="HIT", zgvdisplay="Hit",regex=ITEM_MOD_HIT_RATING},
	[24] = {blizz="HIT_MELEE", zgvdisplay="Hit Melee %",regex=ITEM_MOD_HIT_MELEE_RATING},
	[25] = {blizz="HIT_RANGED", zgvdisplay="Hit Ranged %",regex=ITEM_MOD_HIT_RANGED_RATING},
	[26] = {blizz="HIT_SPELL", zgvdisplay="Hit Spell %",regex=ITEM_MOD_HIT_SPELL_RATING},
	[27] = {blizz="MANA", zgvdisplay="Mana",regex=ITEM_MOD_MANA},
	[28] = {blizz="MANA_REGENERATION", zgvdisplay="Mana Regeneration",regex=ITEM_MOD_MANA_REGENERATION},
	[29] = {blizz="PARRY", zgvdisplay="Parry",regex=ITEM_MOD_PARRY_RATING},
	[30] = {blizz="RANGED_ATTACK_POWER", zgvdisplay="Ranged Attack Power",regex=ITEM_MOD_RANGED_ATTACK_POWER},
	[31] = {blizz="SPELL_DAMAGE_DONE", zgvdisplay="Spell Bonus Damage",regex=ITEM_MOD_SPELL_DAMAGE_DONE},
	[32] = {blizz="SPELL_HEALING_DONE", zgvdisplay="Spell Bonus Healing",regex=ITEM_MOD_SPELL_HEALING_DONE},
	[33] = {blizz="SPELL_PENETRATION", zgvdisplay="Spell Penetration",regex=ITEM_MOD_SPELL_PENETRATION},
	[34] = {blizz="SPELL_POWER", zgvdisplay="Spell Power",regex=ITEM_MOD_SPELL_POWER},
	--[35] = {blizz="WEAPONSPEED", zgvdisplay="Weapon Speed",regex=""},
}
for i,v in pairs(ItemScore.Keywords) do -- convert blizzard templates to lua regex match
	ItemScore.Keywords[i].regex = (ItemScore.Keywords[i].regex):gsub("%%d","([0-9]+)"):gsub("%%c","([+-]+)"):gsub("%%s","([0-9.]+)"):gsub("%%([0-9]+)%$","%%")
end

ItemScore.KnownKeyWords = {}
for i,v in pairs(ItemScore.Keywords) do -- create lookup table for use in popups, since GetItemStats/Delta fails on suffix items, and we need to use our cached data instead
	ItemScore.KnownKeyWords[v.blizz] = v.zgvdisplay
end


ItemScore.rules = {
	["DRUID"] = {
		[1] = {
			name="Balance",
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 6.82, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 8.47, INTELLECT = 0.38, MANA = 0.032, MANA_REGENERATION = 0.58, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.21, SPIRIT = 0.34, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[2] = {
			name="Feral DPS", 
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = { AGILITY = 1, ARMOR = 0.02, ARMOR_PENETRATION = 0.4, ATTACK_POWER = 0.59, CRIT = 6.49, CRIT_MELEE = 6.49, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.02, FERAL_ATTACK_POWER = 0.59, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 5.49, HIT_MELEE = 5.49, INTELLECT = 0.1, MANA = 0.009, MANA_REGENERATION = 0.3, PARRY = 0.6, SPELL_HEALING_DONE = 0.025, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 1.48,},
			caps = { HIT=5, },
		},
		[3] = {
			name="Feral TANK", 
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = { AGILITY = 0.48, ARMOR = 0.1, ARMOR_PENETRATION = 0.2, ATTACK_POWER = 0.34, CRIT = 1.65, CRIT_MELEE = 1.65, DEFENSE_SKILL = 0.39, DODGE = 3.8, EXTRA_ARMOR = 0.1, FERAL_ATTACK_POWER = 0.34, HEALTH = 0.08, HEALTH_REGENERATION = 2, HIT = 1.44, HIT_MELEE = 1.44, INTELLECT = 0.1, MANA = 0.009, MANA_REGENERATION = 0.3, SPELL_HEALING_DONE = 0.025, SPIRIT = 0.05, STAMINA = 1, STRENGTH = 0.2,},
			caps = { HIT=5, },
		},
		[4] = {
			name="Restoration", 
			itemtypes = { CLOTH=1, LEATHER=1, TH_STAFF=1, MACE=1, TH_MACE=1, DAGGER=1, FIST=1 },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 3.85, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, INTELLECT = 1, MANA = 0.09, MANA_REGENERATION = 1.7, PARRY = 0.6, SPELL_HEALING_DONE = 1.21, SPIRIT = 0.87, STAMINA = 0.5,},
			caps = { HIT=4, },
		}
	},
	["HUNTER"] = { -- cloth/leather only till 40, mail from 40
		[1] = {
			name="Beast Mastery", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, BOW=1, CROSSBOW=1, GUN=1, TH_SWORD=1, TH_AXE=1, SWORD=1, AXE=1, FIST=1, TH_POLE=1, DAGGER=1, TH_STAFF=1, THROWN=1 },
			stats = { AGILITY = 1, ARMOR = 0.005, ARMOR_PENETRATION = 0.17, ATTACK_POWER = 0.43, CRIT = 8.8, CRIT_RANGED = 8.8, DAMAGE_PER_SECOND = 2.4, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 9, HIT_RANGED = 9, INTELLECT = 0.8, MANA = 0.075, MANA_REGENERATION = 2.4, PARRY = 0.6, RANGED_ATTACK_POWER = 0.43, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 0.05,},
			caps = { HIT=5, },
		},
		[2] = {
			name="Marksmanship", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, BOW=1, CROSSBOW=1, GUN=1, TH_SWORD=1, TH_AXE=1, SWORD=1, AXE=1, FIST=1, TH_POLE=1, DAGGER=1, TH_STAFF=1, THROWN=1 },
			stats = { AGILITY = 1, ARMOR = 0.005, ARMOR_PENETRATION = 0.37, ATTACK_POWER = 0.55, CRIT = 6.6, CRIT_RANGED = 6.6, DAMAGE_PER_SECOND = 2.6, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 9, HIT_RANGED = 9, INTELLECT = 0.9, MANA = 0.085, MANA_REGENERATION = 2.4, PARRY = 0.6, RANGED_ATTACK_POWER = 0.55, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 0.05,},
			caps = { HIT=5, },
		},
		[3] = {
			name="Survival", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, BOW=1, CROSSBOW=1, GUN=1, TH_SWORD=1, TH_AXE=1, SWORD=1, AXE=1, FIST=1, TH_POLE=1, DAGGER=1, TH_STAFF=1, THROWN=1 },
			stats = { AGILITY = 1, ARMOR = 0.005, ARMOR_PENETRATION = 0.28, ATTACK_POWER = 0.55, CRIT = 7.15, CRIT_RANGED = 7.15, DAMAGE_PER_SECOND = 2.4, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 9, HIT_RANGED = 9, INTELLECT = 0.8, MANA = 0.075, MANA_REGENERATION = 2.4, PARRY = 0.6, RANGED_ATTACK_POWER = 0.55, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 0.05,},
			caps = { HIT=5, },
		},
	},
	["MAGE"] = {
		[1] = {
			name="Arcane", 
			itemtypes = {CLOTH=1, TH_STAFF=1, DAGGER=1, SWORD=1 },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 6.6, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 6.09, INTELLECT = 0.46, MANA = 0.038, MANA_REGENERATION = 1.13, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.09, SPIRIT = 0.59, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[2] = {
			name="Fire", 
			itemtypes = {CLOTH=1, TH_STAFF=1, DAGGER=1, SWORD=1 },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 8.47, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 6.51, INTELLECT = 0.44, MANA = 0.036, MANA_REGENERATION = 0.9, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.09, SPIRIT = 0.066, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[3] = {
			name="Frost", 
			itemtypes = {CLOTH=1, TH_STAFF=1, DAGGER=1, SWORD=1 },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 6.38, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 8.54, INTELLECT = 0.37, MANA = 0.032, MANA_REGENERATION = 0.8, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.07, SPIRIT = 0.06, STAMINA = 0.5,},
			caps = { HIT=4, },
		}
	},
	["PALADIN"] = { -- cloth/leather/mail only till 40, plate from 40
		[1] = {
			name="Holy", 
			itemtypes = {CLOTH=1, LEATHER=1, MAIL=1, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, MACE=1, TH_MACE=1, TH_POLE=1, SWORD=1, TH_SWORD=1},
			stats = { AGILITY = 0.05, ARMOR = 0.005, BLOCK = 0.05, CRIT_SPELL = 5.06, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, INTELLECT = 1, MANA = 0.009, MANA_REGENERATION = 1.24, PARRY = 0.6, SPELL_HEALING_DONE = 0.54, SPIRIT = 0.28, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[2] = {
			name="Protection", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, MACE=1, TH_MACE=1, TH_POLE=1, SWORD=1, TH_SWORD=1},
			stats = { AGILITY = 0.6, ARMOR = 0.02, ARMOR_PENETRATION = 0.09, ATTACK_POWER = 0.06, BLOCK = 3, BLOCK_VALUE = 0.15, CRIT = 1.65, CRIT_MELEE = 1.65, CRIT_SPELL = 6.6, DAMAGE_PER_SECOND = 1.77, DEFENSE_SKILL = 1.05, DODGE = 7, EXTRA_ARMOR = 0.02, HEALTH = 0.09, HEALTH_REGENERATION = 2, HIT = 1.44, HIT_MELEE = 1.44, HIT_SPELL = 5.46, INTELLECT = 0.5, MANA = 0.045, MANA_REGENERATION = 1, PARRY = 7.2, SPELL_DAMAGE_DONE = 0.44, SPELL_PENETRATION = 0.03, SPIRIT = 0.05, STAMINA = 1, STRENGTH = 0.2,},
			caps = { HIT=5, },
		},
		[3] = {
			name="Retribution", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, MACE=1, TH_MACE=1, TH_POLE=1, SWORD=1, TH_SWORD=1},
			stats = { AGILITY = 0.64, ARMOR = 0.005, ARMOR_PENETRATION = 0.09, ATTACK_POWER = 0.41, CRIT = 7.26, CRIT_MELEE = 7.26, CRIT_SPELL = 1.32, DAMAGE_PER_SECOND = 5.4, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 7.56, HIT_MELEE = 7.56, HIT_SPELL = 1.47, INTELLECT = 0.34, MANA = 0.032, MANA_REGENERATION = 1, PARRY = 0.6, SPELL_DAMAGE_DONE = 0.33, SPELL_PENETRATION = 0.015, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 1,},
			caps = { HIT=5, },
		}
	},
	["PRIEST"] = {
		[1] = {
			name="Discipline", 
			itemtypes = { CLOTH=1, MACE=1, DAGGER=1, TH_STAFF=1, WAND=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 3.52, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, INTELLECT = 1, MANA = 0.09, MANA_REGENERATION = 1.19, PARRY = 0.6, SPELL_HEALING_DONE = 0.72, SPIRIT = 0.48, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[2] = {
			name="Holy", 
			itemtypes = { CLOTH=1, MACE=1, DAGGER=1, TH_STAFF=1, WAND=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 2.64, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, INTELLECT = 1, MANA = 0.09, MANA_REGENERATION = 1.35, PARRY = 0.6, SPELL_HEALING_DONE = 0.81, SPIRIT = 0.73, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[3] = {
			name="Shadow", 
			itemtypes = { CLOTH=1, MACE=1, DAGGER=1, TH_STAFF=1, WAND=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 8.36, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 7.84, INTELLECT = 0.19, MANA = 0.017, MANA_REGENERATION = 1, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.08, SPIRIT = 0.21, STAMINA = 0.5,},
			caps = { HIT=4, },
		}
	},
	["ROGUE"] = {
		[1] = {
			name="Assassination", 
			itemtypes = { CLOTH=1, LEATHER=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, SWORD=1, THROWN=1, },
			stats = { AGILITY = 1, ARMOR = 0.005, ARMOR_PENETRATION = 0.24, ATTACK_POWER = 0.45, CRIT = 8.91, CRIT_MELEE = 8.91, DAMAGE_PER_SECOND = 3, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 9, HIT_MELEE = 9, PARRY = 1.44, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 0.5,},
			caps = { HIT=24, },
		},
		[2] = {
			name="Combat", 
			itemtypes = { CLOTH=1, LEATHER=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, SWORD=1, THROWN=1, },
			stats = { AGILITY = 1, ARMOR = 0.005, ARMOR_PENETRATION = 0.24, ATTACK_POWER = 0.45, CRIT = 8.91, CRIT_MELEE = 8.91, DAMAGE_PER_SECOND = 3, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 9, HIT_MELEE = 9, PARRY = 1.44, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 0.5,},
			caps = { HIT=24, },
		},
		[3] = {
			name="Subtlety", 
			itemtypes = { CLOTH=1, LEATHER=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, SWORD=1, THROWN=1, },
			stats = { AGILITY = 1, ARMOR = 0.005, ARMOR_PENETRATION = 0.24, ATTACK_POWER = 0.45, CRIT = 8.91, CRIT_MELEE = 8.91, DAMAGE_PER_SECOND = 3, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 9, HIT_MELEE = 9, PARRY = 1.44, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 0.5,},
			caps = { HIT=24, },
		}
	},
	["SHAMAN"] = { -- cloth/leather only till 40, mail from 40
		[1] = { 
			name="Elemental", 
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, SHIELD=1, AXE=1, TH_AXE=1, DAGGER=1, FIST=1, MACE=1, TH_MACE=1, TH_STAFF=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, BLOCK = 0.05, CRIT_SPELL = 11.55, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 6.3, INTELLECT = 0.31, MANA = 0.024, MANA_REGENERATION = 1.14, PARRY = 1.44, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.38, SPIRIT = 0.09, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[2] = {
			name="Enhancement",
			itemtypes = { CLOTH=-40, LEATHER=-40, MAIL=40, SHIELD=1, AXE=1, TH_AXE=1, DAGGER=1, FIST=1, MACE=1, TH_MACE=1, TH_STAFF=1, },
			stats = { AGILITY = 0.87, ARMOR = 0.005, ARMOR_PENETRATION = 0.12, ATTACK_POWER = 0.5, CRIT = 10.78, CRIT_MELEE = 10.78, CRIT_SPELL = 3.586, DAMAGE_PER_SECOND = 3, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 6.03, HIT_MELEE = 6.03, HIT_SPELL = 1.561, INTELLECT = 0.34, MANA = 0.032, MANA_REGENERATION = 1, PARRY = 0.6, SPELL_DAMAGE_DONE = 0.3, SPELL_PENETRATION = 0.11, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 1,},
			caps = { HIT=24, },
		},
		[3] = {
			name="Restoration", 
			itemtypes = { CLOTH=1, LEATHER=1, MAIL=40, SHIELD=1, AXE=1, TH_AXE=1, DAGGER=1, FIST=1, MACE=1, TH_MACE=1, TH_STAFF=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, BLOCK = 0.05, CRIT_SPELL = 5.28, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, INTELLECT = 1, MANA = 0.009, MANA_REGENERATION = 1.33, PARRY = 0.6, SPELL_HEALING_DONE = 0.9, SPIRIT = 0.61, STAMINA = 0.5,},
			caps = { HIT=4, },
		}
	},
	["WARLOCK"] = {
		[1] = {
			name="Affliction", 
			itemtypes = { CLOTH=1, DAGGER=1, WAND=1, TH_STAFF=1, SWORD=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 4.29, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 8.4, INTELLECT = 0.4, MANA = 0.03, MANA_REGENERATION = 1, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.08, SPIRIT = 0.1, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[2] = {
			name="Demonology", 
			itemtypes = { CLOTH=1, DAGGER=1, WAND=1, TH_STAFF=1, SWORD=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 7.26, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 8.4, INTELLECT = 0.4, MANA = 0.03, MANA_REGENERATION = 1, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.08, SPIRIT = 0.5, STAMINA = 0.5,},
			caps = { HIT=4, },
		},
		[3] = {
			name="Destruction", 
			itemtypes = { CLOTH=1, DAGGER=1, WAND=1, TH_STAFF=1, SWORD=1, },
			stats = { AGILITY = 0.05, ARMOR = 0.005, CRIT_SPELL = 9.57, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT_SPELL = 11.2, INTELLECT = 0.34, MANA = 0.028, MANA_REGENERATION = 0.65, PARRY = 0.6, SPELL_DAMAGE_DONE = 1, SPELL_PENETRATION = 0.08, SPIRIT = 0.25, STAMINA = 0.5,},
			caps = { HIT=4, },
		}
	},
	["WARRIOR"] = { -- cloth/leather,mail only till 40, plate from 40
		[1] = {
			name="Arms", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, TH_MACE=1, TH_POLE=1, TH_STAFF=1, SWORD=1, TH_SWORD=1, OFFHAND=1, MISCARM=1, THROWN=1,  },
			stats = { AGILITY = 0.69, ARMOR = 0.005, ARMOR_PENETRATION = 1.1, ATTACK_POWER = 0.45, CRIT = 9.35, CRIT_MELEE = 9.35, DAMAGE_PER_SECOND = 5.31, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 9, HIT_MELEE = 9, PARRY = 0.6, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 1,},
			caps = { HIT=5, },
		},
		[2] = {
			name="Fury", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, TH_MACE=1, TH_POLE=1, TH_STAFF=1, SWORD=1, TH_SWORD=1, OFFHAND=1, MISCARM=1, THROWN=1,  },
			stats = { AGILITY = 0.57, ARMOR = 0.005, ARMOR_PENETRATION = 0.47, ATTACK_POWER = 0.54, CRIT = 7.7, CRIT_MELEE = 7.7, DAMAGE_PER_SECOND = 5.22, DEFENSE_SKILL = 0.075, DODGE = 0.5, EXTRA_ARMOR = 0.005, HEALTH = 0.05, HEALTH_REGENERATION = 1, HIT = 5.13, HIT_MELEE = 5.13, PARRY = 1.44, SPIRIT = 0.05, STAMINA = 0.5, STRENGTH = 1,},
			caps = { HIT=5, },
		},
		[3] = {
			name="Prot", 
			itemtypes = {CLOTH=-40, LEATHER=-40, MAIL=-40, PLATE=40, SHIELD=1, AXE=1, TH_AXE=1, BOW=1, CROSSBOW=1, DAGGER=1, FIST=1, GUN=1, MACE=1, TH_MACE=1, TH_POLE=1, TH_STAFF=1, SWORD=1, TH_SWORD=1, OFFHAND=1, MISCARM=1, THROWN=1,  },
			stats = { AGILITY = 0.59, ARMOR = 0.02, ARMOR_PENETRATION = 0.19, ATTACK_POWER = 0.06, BLOCK = 2.95, BLOCK_VALUE = 0.35, CRIT = 3.08, CRIT_MELEE = 3.08, DAMAGE_PER_SECOND = 3.13, DEFENSE_SKILL = 1.215, DODGE = 7, EXTRA_ARMOR = 0.02, HEALTH = 0.09, HEALTH_REGENERATION = 2, HIT = 6.03, HIT_MELEE = 6.03, PARRY = 6.96, SPIRIT = 0.05, STAMINA = 1, STRENGTH = 0.33,},
			caps = { HIT=5, },
		}
	},
}
ItemScore.Builds={}
for class,classData in pairs(ItemScore.rules) do
	ItemScore.Builds[ZGV.ClassToNumber[class]] = {}
	for buildid,builddata in pairs(classData) do
		ItemScore.Builds[ZGV.ClassToNumber[class]][buildid] = builddata.name
	end
end



ItemScore.Unique_Equipped_Families = { }-- those items are unique equipped, but do not return GetItemUniqueness values


ItemScore.Item_Weapon_Types = {
	[0] = "AXE",
	[1] = "TH_AXE",
	[2] = "BOW",
	[3] = "GUN",
	[4] = "MACE",
	[5] = "TH_MACE",
	[6] = "TH_POLE",
	[7] = "SWORD",
	[8] = "TH_SWORD",
	[9] = "WARGLAIVE",
	[10] = "TH_STAFF",
	[11] = "DRUID_BEAR",
	[12] = "DRUID_CAT",
	[13] = "FIST",
	[14] = "MISCWEAP",
	[15] = "DAGGER",
	[16] = "THROWN",
	[17] = "SPEAR",
	[18] = "CROSSBOW",
	[19] = "WAND",
	[20] = "FISHPOLE",
	}

ItemScore.Item_Armor_Types = {
	[0] = "JEWELERY", -- necklace, rings and trinkets, also some cosmetic armor
	[1] = "CLOTH",
	[2] = "LEATHER",
	[3] = "MAIL",
	[4] = "PLATE",
	[5] = "COSMETIC",
	[6] = "SHIELD",
	}

ItemScore.TypeToSlot = {
	INVTYPE_WEAPON = INVSLOT_MAINHAND, -- dual wield handled in GetValidSlots
	INVTYPE_WEAPONMAINHAND = INVSLOT_MAINHAND,
	INVTYPE_2HWEAPON = INVSLOT_MAINHAND, -- titan fury hanndled in GetValidSlots
	INVTYPE_WEAPONOFFHAND = INVSLOT_OFFHAND,
	INVTYPE_SHIELD = INVSLOT_OFFHAND,
	INVTYPE_THROWN = INVSLOT_RANGED,
	INVTYPE_RANGED = INVSLOT_RANGED,
	INVTYPE_RANGEDRIGHT = INVSLOT_RANGED,
	INVTYPE_HOLDABLE = INVSLOT_OFFHAND,
	INVTYPE_HEAD = INVSLOT_HEAD,
	INVTYPE_NECK = INVSLOT_NECK,
	INVTYPE_SHOULDER = INVSLOT_SHOULDER,
	INVTYPE_CLOAK = INVSLOT_BACK,
	INVTYPE_CHEST = INVSLOT_CHEST,
	INVTYPE_ROBE = INVSLOT_CHEST,
	INVTYPE_WRIST = INVSLOT_WRIST,
	INVTYPE_HAND = INVSLOT_HAND,
	INVTYPE_WAIST = INVSLOT_WAIST,
	INVTYPE_LEGS = INVSLOT_LEGS,
	INVTYPE_FEET = INVSLOT_FEET,
	INVTYPE_FINGER = INVSLOT_FINGER1, -- second slot handled in GetValidSlots
	INVTYPE_TRINKET = INVSLOT_TRINKET1, -- second slot handled in GetValidSlots
}

ItemScore.SkillNames = { -- gets trimmed in a moment										-- needs checking
	-- Thanks go to simonstone for zhTW translation
	--{id=95,		enUS="Defense",			deDE="Verteidigung",		esES="Defensa",			esMX="Defensa",			frFR="Défense",			itIT="Defense",			ptBR="Defesa",			ruRU="Защита",				koKR="방어",		zhCN="防御",	zhTW="防禦",	},	  
	DUALWIELD = {id=118,	enUS="Dual Wield",		deDE="Beidhändigkeit",		esES="Empuñadura dual",		esMX="Doble empuñadura",	frFR="Ambidextrie",		itIT="Dual Wield",		ptBR="Empunhar Duas Armas",	ruRU="Бой двумя руками",		koKR="쌍수 무기",		zhCN="双武器",	zhTW="雙持",	},		      
	SWORD = {id=43,		enUS="Swords",			deDE="Schwerter",		esES="Espadas",			esMX="Espadas",			frFR="Epées",			itIT="Swords",			ptBR="Espadas",			ruRU="Мечи",				koKR="도검류",		zhCN="单手剑",	zhTW="單手劍",	},	      
	WAND = {id=228,		enUS="Wands",			deDE="Zauberstäbe",		esES="Varitas",			esMX="Varitas",			frFR="Baguettes",		itIT="Wands",			ptBR="Varinhas",		ruRU="Жезлы",				koKR="마법봉류",		zhCN="魔杖",	zhTW="魔杖",	},	      
	TH_SWORD = {id=55,	enUS="Two-Handed Swords",	deDE="Zweihandschwerter",	esES="Espadas de dos manos",	esMX="Espadas de dos manos",	frFR="Epées à deux mains",	itIT="Two-Handed Swords",	ptBR="Espadas de Duas Mãos",	ruRU="Двуручные мечи",			koKR="양손 도검류",	zhCN="双手剑",	zhTW="雙手劍",	},		      
	THROWN = {id=176,	enUS="Thrown",			deDE="Wurfwaffen",		esES="Armas arrojadizas",	esMX="Armas arrojadizas",	frFR="Armes de jet",		itIT="Thrown",			ptBR="Arremesso",		ruRU="Метательное оружие",		koKR="투척 무기류",	zhCN="投掷武器",	zhTW="投擲武器",	},	      
	FIST = {id=473,		enUS="Fist Weapons",		deDE="Faustwaffen",		esES="Armas de puño",		esMX="Armas de puño",		frFR="Armes de pugilat",	itIT="Fist Weapons",		ptBR="Armas de punho",		ruRU="Кистевое оружие",			koKR="장착 무기류",	zhCN="拳套",	zhTW="拳套",	},	      
	TH_MACE = {id=160,	enUS="Two-Handed Maces",	deDE="Zweihandstreitkolben",	esES="Mazas de dos manos",	esMX="Mazas de dos manos",	frFR="Masses à deux mains",	itIT="Two-Handed Maces",	ptBR="Maças de Duas Mãos",	ruRU="Двуручное дробящее оружие",	koKR="양손 둔기류",	zhCN="双手锤",	zhTW="雙手錘",	},		      
	TH_AXE = {id=172,	enUS="Two-Handed Axes",		deDE="Zweihandäxte",		esES="Hachas de dos manos",	esMX="Hachas de dos manos",	frFR="Haches à deux mains",	itIT="Two-Handed Axes",		ptBR="Machados de Duas Mãos",	ruRU="Двуручные топоры",		koKR="양손 도끼류",	zhCN="双手斧",	zhTW="雙手斧",	},		      
	AXE = {id=44,		enUS="Axes",			deDE="Äxte",			esES="Hachas",			esMX="Hachas",			frFR="Haches",			itIT="Axes",			ptBR="Machados",		ruRU="Топоры",				koKR="도끼류",		zhCN="单手斧",	zhTW="單手斧",	},		      
	GUN = {id=46,		enUS="Guns",			deDE="Schusswaffen",		esES="Armas de fuego",		esMX="Armas de fuego",		frFR="Armes à feu",		itIT="Guns",			ptBR="Armas de Fogo",		ruRU="Огнестрельное оружие",		koKR="총기류",		zhCN="枪械",	zhTW="槍械",	},		      
	TH_POLE = {id=229,	enUS="Polearms",		deDE="Stangenwaffen",		esES="Armas de asta",		esMX="Armas de asta",		frFR="Armes d'hast",		itIT="Polearms",		ptBR="Armas de Haste",		ruRU="Древковое оружие",		koKR="장창류",		zhCN="长柄武器",	zhTW="長柄武器",	},	      
	BOW = {id=45,		enUS="Bows",			deDE="Bogen",			esES="Arcos",			esMX="Arcos",			frFR="Arcs",			itIT="Bows",			ptBR="Arcos",			ruRU="Луки",				koKR="활류",		zhCN="弓",	zhTW="弓",	},		      
	CROSSBOW = {id=226,	enUS="Crossbows",		deDE="Armbrüste",		esES="Ballestas",		esMX="Ballestas",		frFR="Arbalètes",		itIT="Crossbows",		ptBR="Bestas",			ruRU="Арбалеты",			koKR="석궁류",		zhCN="弩",	zhTW="弩",	},		      
	TH_STAFF = {id=136,	enUS="Staves",			deDE="Stäbe",			esES="Bastones",		esMX="Bastones",		frFR="Bâtons",			itIT="Staves",			ptBR="Báculos",			ruRU="Посохи",				koKR="지팡이류",		zhCN="法杖",	zhTW="法杖",	},		      
	-- {id=162,		enUS="Unarmed",			deDE="Unbewaffnet",		esES="Sin armas",		esMX="Sin armas",		frFR="Mains nues",		itIT="Unarmed",			ptBR="Combate desarmado",	ruRU="Рукопашный бой",			koKR="맨손 전투",		zhCN="徒手战斗",	zhTW="未裝備",	},		      
	MACE = {id=54,		enUS="Maces",			deDE="Streitkolben",		esES="Mazas",			esMX="Mazas",			frFR="Masse",			itIT="Maces",			ptBR="Maças",			ruRU="Дробящее оружие",			koKR="둔기류",		zhCN="单手锤",	zhTW="單手錘",	},	      
	DAGGER = {id=173,	enUS="Daggers",			deDE="Dolche",			esES="Dagas",			esMX="Dagas",			frFR="Dagues",			itIT="Daggers",			ptBR="Adagas",			ruRU="Кинжалы",				koKR="단검류",		zhCN="匕首",	zhTW="匕首",	},		      
	PLATE = {id=293,	enUS="Plate Mail",		deDE="Plattenpanzer",		esES="Armadura de placas",	esMX="Armadura de placas",	frFR="Armure en plaques",	itIT="Plate Mail",		ptBR="Armadura de Placa",	ruRU="Латы",				koKR="판금 갑옷",		zhCN="板甲",	zhTW="鎧甲",	},		      
	MAIL = {id=413,		enUS="Mail",			deDE="Schwere Rüstung",		esES="Mallas",			esMX="Mallas",			frFR="Mailles",			itIT="Mail",			ptBR="Malha",			ruRU="Кольчужные доспехи",		koKR="사슬",		zhCN="锁甲",	zhTW="鎖甲",	},	      
	CLOTH = {id=415,	enUS="Cloth",			deDE="Stoff",			esES="Tela",			esMX="Tela",			frFR="Tissu",			itIT="Cloth",			ptBR="Tecido",			ruRU="Тканевые доспехи",		koKR="천",		zhCN="布甲",	zhTW="布甲",	},		      
	SHIELD = {id=433,	enUS="Shield",			deDE="Schild",			esES="Escudo",			esMX="Escudo",			frFR="Bouclier",		itIT="Shield",			ptBR="Escudo",			ruRU="Щит",				koKR="방패",		zhCN="盾牌",	zhTW="盾牌",	},		      
	LEATHER = {id=414,	enUS="Leather",			deDE="Leder",			esES="Cuero",			esMX="Cuero",			frFR="Cuir",			itIT="Leather",			ptBR="Couro",			ruRU="Кожаные доспехи",			koKR="가죽",		zhCN="皮甲",	zhTW="皮甲",	},		      
}
ItemScore.SkillNamesRev={}

local locale=GetLocale()
if locale=="enGB" then locale="enUS" end  -- just in case.
for i,skillset in pairs(ItemScore.SkillNames) do -- drop other languages
	local name = skillset[locale] or skillset.enUS
	ItemScore.SkillNames[i] = name
	ItemScore.SkillNamesRev[name] = i
end

-- Build simpler defaults table for use in options
ItemScore.Defaults = {}
for class,specs in pairs(ItemScore.rules) do
 ZGV.ItemScore.Defaults[class] = {}
 for spec,data in pairs(specs) do
	ZGV.ItemScore.Defaults[class][spec] = {}

	for name,v in pairs(data.stats) do
		table.insert(ZGV.ItemScore.Defaults[class][spec],{name=name,weight=v})
	end
	sort(ZGV.ItemScore.Defaults[class][spec],function(a,b) return a.name<b.name end)
 end
end 