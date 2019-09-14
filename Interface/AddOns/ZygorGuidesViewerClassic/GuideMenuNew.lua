-- look for this stuff
-- RETIRE AFTER NEW MENU


local ZGV = ZygorGuidesViewer
if not ZGV then return end

local GuideMenu = {}
ZGV.GuideMenu = GuideMenu

local L = ZGV.L
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local CHAIN = ZGV.ChainCall
local ui = ZGV.UI
local SkinData = ui.SkinData

local ICON_GUIDE={1/2,1,0,1/2}
local ICON_FOLDER={0,1/2,0,1/2}
local ICONS_TYPE=ZGV.DIR.."\\Skins\\guideicons-big"

GuideMenu.GUIDE_DISPLAY = { -- also used by guide tabs
	-- name = {row,column,"display name"}
	LEVELING =	{1,1,"Leveling"},
	EVENTS =	{2,1,"Events"},
	DAILIES =	{3,1,"Dailies"},
	LOREMASTER =	{4,1,"Loremaster"},
	GOLD =		{1,2,"Gold"},
	PROFESSIONS =	{2,2,"Professions"},
	PETSMOUNTS =	{3,2,"Pets & Mounts"},
	ACHIEVEMENTS =	{4,2,"Achievements"},
	TITLES =	{1,3,"Titles"},
	REPUTATIONS =	{2,3,"Reputations"},
	MACROS =	{3,3,"Macros"},
	DUNGEONS =	{4,3,"Dungeons"},
	GEAR =		{1,4,"Gear"},
}
setmetatable(GuideMenu.GUIDE_DISPLAY,{__index=function(self,name) return {4,4,name} end})

local STATUS_COLORS = { -- rrggbbaa
	SUGGESTED =	{hex="#ffffffff"},
	VALID =		{hex="#ffffffff"},
	COMPLETE =	{hex="#808080ff"},
	OUTLEVELED =	{hex="#aaaaaaff"},
	INVALID =	{hex="#e60000ff"},
} 
for stat,data in pairs(STATUS_COLORS) do -- convert hex to inline color and vertex array
	data.r,data.g,data.b,data.a = ZGV.F.HTMLColor(data.hex)
	data.code = "|c"..data.hex:sub(8,9)..data.hex:sub(2,3)..data.hex:sub(4,5)..data.hex:sub(6,7)
end

GuideMenu.STATUS_COLORS=STATUS_COLORS -- used in popups, so let us make it public

function GuideMenu:ShowHome()
	if not GuideMenu.HomeReady then
		GuideMenu:CreateHome()
	end
	
	GuideMenu:SetWideSectionHeader("What's new")

	GuideMenu.GuideCategory=nil
end

local temp_structure={},{}
function GuideMenu:Search()
	table.wipe(temp_structure)
	table.wipe(GuideMenu.Guides)
	local searchtext=GuideMenu.MainFrame.MenuGuides.SearchEdit:GetText()
	local category

	--[[
	if #searchtext<2 then
		GuideMenu:SetSectionHeader("Search",false)
		GuideMenu.GuideCategory=nil
		return
	end
	--]]

	local questID = searchtext:match("^quest:(%d+)$")
	if questID then -- redirect to search for quest by id
		GuideMenu.CurrentPath = "QuestSearch"
		GuideMenu:SearchQuest(tonumber(questID))
		return
	end

	-- Get list of search results, and separate them to category folders
	local nresults=0
	for _,object in pairs(ZGV:FindGuides(searchtext)) do
		if (not object.condition_visible or object.condition_visible()==true) -- don't show guides with invalid condition_visible
		   and object.GetStatus and not (ZGV.db.profile.gmhidecompleted and (object:GetStatus()=="OUTLEVELED" or object:GetStatus()=="COMPLETE")) then -- don't show outleveled/completed if option is set
			category,_ = (object.fullpath or object.title):match("^([^\\]+)\\(.*)$")
			temp_structure[category]=temp_structure[category] or {}
			table.insert(temp_structure[category],object)
			nresults=nresults+1
		end
	end

	-- Build array of results with added headers and spacers
	local first_folder=true
	for i,group in pairs(ZGV.registered_groups.groups) do
		if temp_structure[group.name] then
			if first_folder then
				first_folder=false
			else
				tinsert(GuideMenu.Guides,{header=true})
			end
			tinsert(GuideMenu.Guides,{header=true,header_name=group.name})

			-- Sort guides in category folders by name
			table.sort(temp_structure[group.name],function(a,b)
				if a.title_short and b.title_short then
					-- both are guides
					return a.title_short<b.title_short
				elseif a.name and b.name then
					-- both are folders
					return a.name<b.name
				else
					-- mix, folders first
					return (a.name and 1 or 0)>(b.name and 1 or 0)
				end
			end)

			for j,object in pairs(temp_structure[group.name]) do
				table.insert(GuideMenu.Guides,object)
			end
		end
	end

	if #searchtext>0 then
		GuideMenu:SetSectionHeader(("Search: %d results"):format(nresults),false)
	else
		GuideMenu:SetSectionHeader("Search",false)
	end

	GuideMenu.GuideCategory=nil
end

function GuideMenu:SearchQuest(questID)
	table.wipe(temp_structure)
	table.wipe(GuideMenu.Guides)

	local category

	local questtitle = C_QuestLog.GetQuestInfo(questID)
	local status,results = ZGV.QuestDB:GetGuidesForQuest(questID)

	-- Get list of search results, and separate them to category folders
	local nresults=0
	for guideTitle,stepNum in pairs(results) do
		local object = ZGV:GetGuideByTitle(guideTitle)
		object.QuestSearchStepNum = stepNum
		object.QuestSearchID = questID

		if object.GetStatus then
			category,_ = (object.fullpath or object.title):match("^([^\\]+)\\(.*)$")
			temp_structure[category]=temp_structure[category] or {}
			table.insert(temp_structure[category],object)
			nresults=nresults+1
		end
	end

	-- Build array of results with added headers and spacers
	local first_folder=true
	for i,group in pairs(ZGV.registered_groups.groups) do
		if temp_structure[group.name] then
			if first_folder then
				first_folder=false
			else
				tinsert(GuideMenu.Guides,{header=true})
			end
			tinsert(GuideMenu.Guides,{header=true,header_name=group.name})

			-- Sort guides in category folders by name
			table.sort(temp_structure[group.name],function(a,b)
				if a.title_short and b.title_short then
					-- both are guides
					return a.title_short<b.title_short
				elseif a.name and b.name then
					-- both are folders
					return a.name<b.name
				else
					-- mix, folders first
					return (a.name and 1 or 0)>(b.name and 1 or 0)
				end
			end)

			for j,object in pairs(temp_structure[group.name]) do
				table.insert(GuideMenu.Guides,object)
			end
		end
	end

	GuideMenu:SetSectionHeader(("Search '"..(questtitle or questID).."': %d result%s"):format(nresults,nresults>1 and "s" or ""),false)

	GuideMenu.GuideCategory=nil
end


GuideMenu.Guides = {}
function GuideMenu:ShowGuides(path,iscurrent) 
	GuideMenu:SetFocusedRow()
	if iscurrent then 
		GuideMenu.FocusedGuide=ZGV.CurrentGuide 
		GuideMenu:ShowGuideDetails()
	else
		GuideMenu:HideGuideMouseOver()
	end
 
	GuideMenu.CurrentPath=path

	-- Prepare array with groups and guides to display
	table.wipe(GuideMenu.Guides)
	if path then
		self.group = ZGV:FindOrCreateGroup(ZGV.registered_groups,path)
	else
		self.group = ZGV.registered_groups
	end

	for gi,g in ipairs(self.group.groups) do
		tinsert(GuideMenu.Guides,g)
	end
	for gi,g in ipairs(self.group.guides) do
		--Dont Put guides that are hidden into the flatgroup. Guides hidden with simple switch can still be searched for. They should not be suggested though.	
		if (not g.hidden) and (not g.condition_visible or g.condition_visible()==true) then 
			if g.GetStatus and not (ZGV.db.profile.gmhidecompleted and (g:GetStatus()=="OUTLEVELED" or g:GetStatus()=="COMPLETE")) then
				tinsert(GuideMenu.Guides,g)
				g:GetCompletion()
			end
		end
	end

	-- Update header to show or hide the parent folder button
	local parent,name = path:match("^(.+)\\(.-)$")
	local center = GuideMenu.MainFrame.CenterColumn
	local section = center.SectionInfo
	local highlight
	
	if parent then
		GuideMenu:SetSectionHeader(name,true)
	        highlight,_ = path:match("^([^\\]+)\\(.*)$")
		section:SetScript("OnClick",function() GuideMenu:Open(parent) end)
		center:SetScript("OnMouseUp",function(this,but) if but=="RightButton" then GuideMenu:Open(parent) end end)
	else
		GuideMenu:SetSectionHeader(GuideMenu.GUIDE_DISPLAY[path][3],false)
		highlight=path
		center:SetScript("OnMouseUp",nil)
	end

	-- Which guide section is to be highlighted
	GuideMenu.GuideCategory = highlight
end

function GuideMenu:ShowParent()
	local center = GuideMenu.MainFrame.CenterColumn
	if center:GetScript("OnMouseUp") then
		center:GetScript("OnMouseUp")(this,"RightButton")
	end
end

function GuideMenu:OpenGuide(guide)
	local path,guide = guide.title:match("^(.+)\\(.-)$")
	GuideMenu:Open(path) 
end

function GuideMenu:ShowCurrent()
	if not ZGV.CurrentGuideName then GuideMenu:Open("Home") return end

	local path,guide = ZGV.CurrentGuideName:match("^(.+)\\(.-)$")
	GuideMenu:Open(path,true)
	GuideMenu:ShowGuideDetails(GuideMenu.FocusedGuide)
end

local recent_groups={}
function GuideMenu:ShowRecent() 
	table.wipe(GuideMenu.Guides)
	table.wipe(recent_groups)

	local limit = ZGV.db.profile.gmnumrecent

	-- get foldered limit last guides
	local added = 0
	for i,object in pairs(ZGV.db.char.guides_history) do
	        local category,_ = object[1]:match("^([^\\]+)\\(.*)$")
		recent_groups[category] = recent_groups[category] or {}
		local guide = ZGV:GetGuideByTitle(object[1])
		if guide and guide.GetStatus and not (ZGV.db.profile.gmhidecompleted and (guide:GetStatus()=="OUTLEVELED" or guide:GetStatus()=="COMPLETE")) then
			guide:GetCompletion()
			guide.CurrentStepNum = object[2]
			table.insert(recent_groups[category],guide)
			added=added+1
		end
		if added==limit then break end
	end

	local first_folder=true
	for i,group in pairs(ZGV.registered_groups.groups) do
		local hist = recent_groups[group.name]
		if hist and #hist > 0 then 
			if first_folder then
				first_folder=false
			else
				tinsert(GuideMenu.Guides,{header=true})
			end
			tinsert(GuideMenu.Guides,{header=true,header_name=group.name})

			for k, guide in pairs(hist) do
				tinsert(GuideMenu.Guides,guide)
			end
		end
	end

	GuideMenu:SetSectionHeader("Recent",false)

	-- Which guide section is to be highlighted
	GuideMenu.GuideCategory = nil
end

local suggested={}
function GuideMenu:FindSuggestedGuides()
	table.wipe(suggested)
	for i,guide in ipairs(ZGV.registeredguides) do
		if guide.condition_suggested_raw or guide.type=="LEVELING" then
			pass,msg = guide:DoCond("suggested")
			if pass then 
				-- ok, it is suggested, but let's check if it is valid and not completed
				local status=guide:GetStatus()
				if status=="SUGGESTED" then
					if not suggested[guide.type] then suggested[guide.type]={} end
					tinsert(suggested[guide.type],guide)
				end
			end
		end
	end
	local sgroups = ZGV:FindOrCreateGroup(ZGV.registered_groups,"SUGGESTED")

	for i,group in pairs(sgroups.groups) do
		if not suggested[group.category] then suggested[group.category]={} end
		tinsert(suggested[group.category],group)
	end

	return suggested
end

function GuideMenu:ShowSuggested() 
	table.wipe(GuideMenu.Guides)

	local sguides = GuideMenu:FindSuggestedGuides()

	local first_folder=true
	for i,group in pairs(ZGV.registered_groups.groups) do
		local hist = sguides[group.name]
		if hist and #hist > 0 then 
			if ZGV.db.profile["gmsuggest"..(group.name):lower()] then
				if first_folder then
					first_folder=false
				else
					tinsert(GuideMenu.Guides,{header=true})
				end
				tinsert(GuideMenu.Guides,{header=true,header_name=group.name})

				for k, guide in pairs(hist) do
					if guide.GetCompletion then guide:GetCompletion() end
					tinsert(GuideMenu.Guides,guide)
				end
			end
		end
	end

	GuideMenu:SetSectionHeader("Suggested",false)

	-- Which guide section is to be highlighted
	GuideMenu.GuideCategory = nil
end

function GuideMenu:Refresh()	
	GuideMenu:Open(GuideMenu.CurrentPath)
end

function GuideMenu:Update()
	-- Highlight guide category in left side menu
	for i,v in pairs(GuideMenu.MainFrame.MenuColumn.GuideButtons) do
		v:SetLockHighlight(i==GuideMenu.GuideCategory)
	end

	if GuideMenu.CurrentSection=="Home" then
		-- We handle home page in GuideMenu:ShowHome()
	elseif GuideMenu.CurrentSection=="Options" then
		-- Options are in options
	else
		local rownum=0
		local ROW_COUNT = GuideMenu.MainFrame.GuideListScrollFrame:CountRows()
		local results=#GuideMenu.Guides

		GuideMenu.GuideListOffset = max(0,min(GuideMenu.GuideListOffset,results-ROW_COUNT))
		local rowoff=GuideMenu.GuideListOffset

		local itemindex = 1
		for ii,object in ipairs(GuideMenu.Guides) do
			rownum = itemindex-rowoff
			if rownum>0 and rownum<ROW_COUNT+1 then 
				local row = GuideMenu.MainFrame.GuideListScrollFrame.rows[rownum]
				local isGuide = object.title_short
				local isHeader = object.header
				local suggested=false
				local complete=false
				local status
				row.guide=nil
				row.group=nil

				-- Reset row to defaults
				row.icon:SetTexture(SkinData("GuideMenuSmallIcons"))
				row.icon:SetVertexColor(1,1,1,1)
				row:SetNormalBackdropColor(0,0,0,0) 
				row.title:SetFont(FONT,12)
				row.loadbutton:Hide()

				if isGuide then
					row.guide=object
					status=object.GetStatus and object:GetStatus("detailed")
					suggested=(status=="SUGGESTED")
					complete=(status=="COMPLETE")

					if complete and ZGV.db.profile.gmusecheck then
						row.icon:SetTexture(ZGV.DIR.."\\Skins\\Default\\Stealth\\stepicons")
						row.icon:SetTexCoord(2/16,3/16,0,1)
					else
						row.icon:SetTexCoord(unpack(ICON_GUIDE))
					end
					if ZGV.db.profile.gmcolorcode then
						local col=STATUS_COLORS[status]
						row.icon:SetVertexColor(col.r,col.g,col.b,col.a)
					end				

					row:SetScript("OnClick",function(this,button) 
						if button=="RightButton" then GuideMenu:ShowParent() return end
						GuideMenu:SetFocusedRow(row) 
					end)
					row:SetScript("OnDoubleClick",function(this,button) GuideMenu:ActivateGuide(row.guide) end)

					if object==GuideMenu.FocusedGuide then 
						row:SetNormalBackdropColor(unpack(SkinData("TriBackdropColor"))) 
					end

					row.loadbutton:Show()


				elseif isHeader then
					row:SetScript("OnClick",nil)
					row:SetScript("OnDoubleClick",nil)
					if object.header_name then
						local x,y,label = unpack(GuideMenu.GUIDE_DISPLAY[object.header_name])
						row.icon:SetTexture(ICONS_TYPE)
						row.icon:SetTexCoord((x-1)/4,x/4,(y-1)/4,y/4)
						row.title:SetFont(FONTBOLD,12)
					else
						row.icon:SetTexCoord(0,0,0,0)
					end
				else
					-- normal guide list, folder clickable and starable
					row.group=object
					row.icon:SetTexCoord(unpack(ICON_FOLDER))
					row:SetScript("OnDoubleClick",nil)
					row:SetScript("OnClick",function(this,button) 
						if button=="RightButton" then GuideMenu:ShowParent() return end
						GuideMenu:SetFocusedRow() 
						GuideMenu:Open(object.fullpath) 
					end)
					if not object.fullpath:find("PETSMOUNTS") then
						suggested=ZGV:GetGuideFolderInfo(object)
					end
				end

				row.title:SetText((object.name or object.title_short or object.header_name or "") .. (object.beta and ZGV.L['guidebeta'] or ""))
				if suggested and ZGV.db.profile.gmstarsuggested then
					row.iconover:Show()
					row.iconover.anim:Play()
				else
					row.iconover:Hide()
				end


				
				row:Show()
			end
			itemindex=itemindex+1 
		end

		GuideMenu.MainFrame.GuideListScrollFrame:TotalValue(results)
		GuideMenu.MainFrame.GuideListScrollFrame:SetValue(rowoff)
		for r=rownum+1,ROW_COUNT do 
			GuideMenu.MainFrame.GuideListScrollFrame.rows[r]:Hide() 
			GuideMenu.MainFrame.GuideListScrollFrame.rows[r].guide=nil 
		end

		if GuideMenu.CurrentRow then GuideMenu.CurrentRow:GetScript("OnEnter")(GuideMenu.CurrentRow) end
	end

	-- if guides need loading, make a guide-load cycle.
	GuideMenu.guideparsetimer = GuideMenu.guideparsetimer or ZGV:ScheduleRepeatingTimer(function()
		local all_loaded = ZGV:LoadNeededGuides()
		ZGV:Debug("Menu: guide full parse cycle: "..(all_loaded and "" or "not").." all loaded")
		if all_loaded then
			ZGV:CancelTimer(GuideMenu.guideparsetimer)
			GuideMenu.guideparsetimer = nil
		else
			GuideMenu:Update()
		end
	end, 0.1)
end

function GuideMenu:SetFocusedRow(row)
	if row then 
		if row.guide and row.guide==GuideMenu.FocusedGuide then
		-- unfocus current
			GuideMenu.FocusedGuide=nil
		elseif row.guide then
		-- unfocus selected
			GuideMenu.FocusedGuide=row.guide
		end
	else
		-- clear focus
		GuideMenu.FocusedGuide=nil
	end

	GuideMenu:Update()
end

function GuideMenu:ActivateGuide(guide)
	if not guide then return end
	
	-- see if guide already exists, if so activate it and close menu
	if ZGV.Tabs:TryToActivateGuide(guide) then 
		GuideMenu:SetFocusedRow()
		GuideMenu:Hide()

		if GuideMenu.CurrentPath == "QuestSearch" then
			ZGV:SetGuide(guide.title,guide.QuestSearchStepNum or 1)
		end

		return 
	end
	
	-- depending on mode, either add new tab or replace active one
	if not GuideMenu.UseTab then 
		local tab = ZGV.Tabs:GetTabFromPool()
		tab:SetAsCurrent()
		GuideMenu.UseTab = tab
	end

	if GuideMenu.CurrentPath == "QuestSearch" then
		if GuideMenu.UseTab.isActive then
			ZGV:SetGuide(guide.title,guide.QuestSearchStepNum or 1)
		else
			GuideMenu.UseTab:AssignGuide(guide.title,guide.QuestSearchStepNum or 1)
		end
	else
		if GuideMenu.UseTab.isActive then
			ZGV:SetGuide(guide.title,guide.CurrentStepNum or 1)
		else
			GuideMenu.UseTab:AssignGuide(guide.title,guide.CurrentStepNum or 1)
		end
	end

	GuideMenu:SetFocusedRow()
	GuideMenu:Hide()
end

function GuideMenu:ShowGuideMouseOver(row)
	if row.guide or row.group then row:SetBackdropColor(unpack(row.bdhcolor)) end
	
	if not row.guide then return end
	if not row.guide.headerdata then return end

	GuideMenu:ShowGuideDetails(row.guide)
end

function GuideMenu:ShowGuideDetails(guide)
	local right = GuideMenu.MainFrame.RightColumn
	if not guide then return end

	--if GuideMenu.FocusedGuide then guide=GuideMenu.FocusedGuide end -- always show focused

	right.GuideTitle:SetText(guide.title_short .. (guide.beta and ZGV.L['guidebeta'] or ""))

	local desc=""
	if guide.startlevel and guide.startlevel>0 then
		local color="|cffffffff"
		if guide.endlevel and guide.endlevel<ZGV:GetPlayerPreciseLevel() then
			color=STATUS_COLORS.OUTLEVELED.code
		elseif guide.startlevel>ZGV:GetPlayerPreciseLevel() then
			color=STATUS_COLORS.INVALID.code
		end

		desc = desc..color.."Required level: ".. ZGV.FormatLevel(guide.startlevel,"mono").."|r\n"
	end
	local guide_desc = (guide.headerdata.description or ""):gsub("_(.-)_","|cffffee88%1|r")
	right.GuideDesc:SetText(desc..guide_desc)
	
	if guide.image then
		right.GuideImage:SetTexture(guide.image)
		right.GuideImage:SetTexCoord(0,1,0,1)
		right.GuideModel:Hide()
	elseif guide.headerdata.model then
		right.GuideModel:SetModels(guide.headerdata.model)
		right.GuideImage:SetTexture(nil)
		right.GuideModel:Show()
	else
		right.GuideImage:SetTexture(ZGV.DIR.."\\Skins\\menu_noimage")
		right.GuideImage:SetTexCoord(0,220/256,0,139/256)
		right.GuideModel:Hide()
	end

	local complete,current,total = guide:GetCompletion()

	if type(complete)~="string" then
		complete = complete or 0
		complete=math.round(complete*100)/100
		
		right.GuideProgress:SetPercent(complete*100)
		right.GuideProgress:SetText((complete*100).."%")
		right.GuideProgressLabel:Show()
		right.GuideProgress:Show()
	end

	right.GuideTitle:Show()
	right.GuideDesc:Show()
end

function GuideMenu:HideGuideMouseOver(row) 
	if row then row:SetBackdropColor(unpack(row.bdcolor)) end

	if GuideMenu.FocusedGuide then GuideMenu:ShowGuideDetails(GuideMenu.FocusedGuide) return end
	--if GuideMenu.FocusedGuide then GuideMenu:ShowGuideDetails() return end -- always show focused


	local right = GuideMenu.MainFrame.RightColumn

	right.GuideImage:SetTexture(ZGV.DIR.."\\Skins\\menu_noguide")
	right.GuideImage:SetTexCoord(0,220/256,0,139/256)

	right.GuideTitle:Hide()
	right.GuideDesc:Hide()
	right.GuideProgressLabel:Hide()
	right.GuideProgress:Hide()
	right.GuideModel:Hide()
end