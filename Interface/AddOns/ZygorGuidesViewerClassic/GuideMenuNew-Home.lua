local ZGV = ZygorGuidesViewer
if not ZGV then return end

local GuideMenu = ZGV.GuideMenu

GuideMenu.HomeVersion = 1
GuideMenu.Home={
	{"banner", image=ZGV.DIR.."\\Skins\\banner"},

	{"title", text=[[Welcome to Zygor's Guides for World of Warcraft Classic]]},

}


-- faction="Alliance" {"separator"},