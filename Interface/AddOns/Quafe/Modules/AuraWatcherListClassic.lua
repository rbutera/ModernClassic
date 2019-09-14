local E, C, F, L = unpack(select(2, ...))  -->Engine, Config, Function, Locale
if not F.IsClassic then return end
local WatcherList = {}

WatcherList["HUNTER"] = {
    {
        {
            ["Show"] = true,
            ["Style"] = "MEKA_BR",
            ["Caster"] = "player",
            ["Aura"] = "1130",
            ["AuraColor"] = {
                ["r"] = 0.937254901960784,
                ["g"] = 0.325490196078431,
                ["b"] = 0.313725490196078,
            },
            ["Unit"] = "target",
        }, -- [1]
        {
            ["Show"] = true,
            ["Style"] = "MEKA_BR",
            ["Aura"] = {
                "1978", -- [1]
                "13549", -- [2]
            },
            ["Caster"] = "player",
            ["AuraColor"] = {
                ["r"] = 0.611764705882353,
                ["g"] = 0.8,
                ["b"] = 0.396078431372549,
            },
            ["Unit"] = "target",
        }, -- [2]
        {
            ["Show"] = true,
            ["Style"] = "MEKA_BR",
            ["Caster"] = "player",
            ["Aura"] = "5116",
            ["AuraColor"] = {
                ["b"] = 0.854901960784314,
                ["g"] = 0.776470588235294,
                ["r"] = 0.149019607843137,
            },
            ["Unit"] = "target",
        }, -- [3]
        {
            ["Show"] = true,
            ["Spell"] = "3044",
            ["Style"] = "MEKA_IL",
            ["Icon"] = "MicroMissiles",
            ["SpellColor"] = {
                ["r"] = 0.980392156862745,
                ["g"] = 0.835294117647059,
                ["b"] = 0.243137254901961,
            },
        }, -- [4]
    }, -- [1]
}

WatcherList["WARLOCK"] = {
    {
        {
            ["Show"] = true,
            ["Aura"] = "980",
            ["Style"] = "MEKA_BR",
            ["Caster"] = "player",
            ["Color"] = {
                ["b"] = 44,
                ["g"] = 81,
                ["r"] = 245,
            },
            ["Filter"] = "Debuff",
            ["AuraColor"] = {
                ["r"] = 0.988235294117647,
                ["g"] = 0.36078431372549,
                ["b"] = 0.36078431372549,
            },
            ["Unit"] = "target",
        }, -- [1]
        {
            ["Show"] = true,
            ["Style"] = "MEKA_BR",
            ["Caster"] = "player",
            ["Aura"] = "172",
            ["AuraColor"] = {
                ["r"] = 0.925490196078432,
                ["g"] = 0.250980392156863,
                ["b"] = 0.47843137254902,
            },
            ["Unit"] = "target",
        }, -- [2]
        {
            ["Show"] = true,
            ["Style"] = "MEKA_BR",
            ["Caster"] = "player",
            ["Aura"] = "707",
            ["AuraColor"] = {
                ["r"] = 0.980392156862745,
                ["g"] = 0.835294117647059,
                ["b"] = 0.243137254901961,
            },
            ["Unit"] = "target",
        }, -- [3]
    }, -- [1]
}

----------------------------------------------------------------
--> Load
----------------------------------------------------------------

E.Aurawatch = WatcherList
