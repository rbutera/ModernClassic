local name,ZGV=...

local WW={}
ZGV.WhoWhere=WW

local HBD = ZGV.HBD

local hide_timer_main = 0
local hide_timer_proff = 0

local ui = ZGV.UI
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold
local L = ZGV.L

local find_nearest_types = {
	[1] = {name="Auctioneer",icon="Interface\\Minimap\\Tracking\\Auctioneer"},
	[2] = {name="Banker",icon="Interface\\Minimap\\Tracking\\Banker"},
	[3] = {name="Class Trainers",icon="Interface\\Minimap\\Tracking\\Profession", func = function() hide_timer_proff=0 ZGV.WhoWhere.ClassFrame:DoFadeIn() end},
	[4] = {name="Innkeeper",icon="Interface\\Minimap\\Tracking\\Innkeeper"},
	[5] = {name="Profession Trainers",icon="Interface\\Minimap\\Tracking\\Profession", func = function() hide_timer_proff=0 ZGV.WhoWhere.ProfessionFrame:DoFadeIn() end},
	[6] = {name="Repair",icon="Interface\\Minimap\\Tracking\\Repair"},
	[7] = {name="Stable Master",icon="Interface\\Minimap\\Tracking\\StableMaster"},
	[8] = {name="Vendors",icon="Interface\\Minimap\\Tracking\\Food", func = function() hide_timer_proff=0 ZGV.WhoWhere.VendorFrame:DoFadeIn() end},
	[9] = {name="Reset Waypoint",icon=nil, func = function() ZGV.Pointer:ClearWaypoints("manual") ZGV:ShowWaypoints() end},
}

local find_nearest_tradeskills = {
	[1] = "Alchemy",
	[2] = "Blacksmithing",
	[3] = "Cooking",
	[4] = "Enchanting",
	[5] = "Engineering",
	[6] = "First Aid",
	[7] = "Fishing",
	[8] = "Herbalism",
	[9] = "Leatherworking",
	[10] = "Mining",
	[11] = "Skinning",
	[12] = "Tailoring",
}

local find_nearest_classes = {
	[1] = "Druid",
	[2] = "Hunter",
	[3] = "Hunter pets",
	[4] = "Mage",
	[5] = "Palladin",
	[6] = "Priest",
	[7] = "Rogue",
	[8] = "Shaman",
	[9] = "Warlock",
	[10] = "Warrior"
}

local find_nearest_vendors = {
	[1] = "Any",
	[2] = "Food",
	[3] = "Poison",
	[4] = "Reagent",
	[5] = "Bullets",
	[6] = "Arrows",
}




function WW:UpdateVisibility()
	if not self.NPCFrame then return end
	if self.NPCFrame:IsMouseOver() then 
		hide_timer_main = 0
	else
		hide_timer_main = hide_timer_main + 1
	end

	if self.ProfessionFrame:IsMouseOver() then 
		hide_timer_proff = 0
		hide_timer_main = 0
	else
		hide_timer_proff = hide_timer_proff + 1
	end

	if hide_timer_main>300 then
		hide_timer_main = 0
		hide_timer_proff = 0
		self.NPCFrame:DoFadeOut() 
		self.ProfessionFrame:DoFadeOut() 
	end
	if hide_timer_proff>300 then
		hide_timer_proff = 0
		self.ProfessionFrame:DoFadeOut() 
	end
end
	

function WW:CreateMenuFrame()
	local iconTopAdjust = -1
	local iconLeftAdjust = 2
	local iconSize = 16
	local textSize = 12
	local textLeftAdjust = 20
	local rowHeight = 20
	local rowWidth = 160	
	local titleLeftAdjust = 2
	local titleTopAdjust = 4
	local titleTextSize = textSize
	local CHAIN = ZGV.ChainCall

	local function SkinData(property)
		return ZGV.CurrentSkinStyle:SkinData(property)
	end

	-- create main frame
	self.NPCFrame = CHAIN(ui:Create("Frame",ZygorGuidesViewerFrame))
		:SetScript("OnUpdate", function() WW:UpdateVisibility() end)
		:RegisterEvent("CURSOR_UPDATE")
		:SetWidth(rowWidth)
		:SetPoint("BOTTOMLEFT",ZygorGuidesViewerFrame,"TOPLEFT")
		:SetHeight(300)
		:SetScale(ZGV.CLASSIC_SCALE_ADJUST)
		:Hide()
	.__END
	local MF = self.NPCFrame

	MF.NPCFrameTitle = CHAIN(MF:CreateFontString())
		:SetPoint("TOPLEFT", MF, "TOPLEFT", titleLeftAdjust, -titleTopAdjust)
		:SetFont(FONTBOLD,titleTextSize) 
		:SetText("Find Nearest")
		:SetTextColor(1, 1, 1)
		:SetFont(ZGV.FontBold,titleTextSize)
	.__END

	-- create tradeskill frame
	self.ProfessionFrame  = CHAIN(ui:Create("Frame",MF))
		:SetWidth(rowWidth)
		:SetPoint("LEFT",MF,"RIGHT")
		:SetHeight(300)
		:Hide()
	.__END
	local PF = self.ProfessionFrame

	-- create class frame
	self.ClassFrame  = CHAIN(ui:Create("Frame",MF))
		:SetWidth(rowWidth)
		:SetPoint("LEFT",MF,"RIGHT")
		:SetHeight(300)
		:Hide()
	.__END
	local CF = self.ClassFrame

	-- create vendor frame
	self.VendorFrame  = CHAIN(ui:Create("Frame",MF))
		:SetWidth(rowWidth)
		:SetPoint("BOTTOMLEFT",MF,"BOTTOMRIGHT")
		:SetHeight(300)
		:Hide()
	.__END
	local VF = self.VendorFrame

	-- fill main frame
	local previous=nil
	local count = 0
	for id,data in ipairs(find_nearest_types) do
		local name=data.name
		local type=data.type or data.name
		local icon=data.icon

		local tempframe = CHAIN(ui:Create("Button",MF))
			:SetSize(rowWidth,rowHeight)
			:SetBackdropColor(0,0,0,0)
			:SetNormalBackdropColor(0,0,0,0)
			:SetHighlightBackdropColor(1,1,1,0.1)
			:SetBackdropBorderColor(0,0,0,0)
			:SetFont(FONT,12)
			:SetText(name)
			:SetScript("OnClick", function(self) 
				if data.func then return data.func() end
				MF:Hide()
				PF:Hide()
				CF:Hide()
				VF:Hide()
				ZGV.WhoWhere:FindNPC(type) 
			end)
		.__END
		local button_onenter = tempframe:GetScript("OnEnter")
		tempframe:SetScript("OnEnter", function(self) button_onenter(self) PF:DoFadeOut() CF:DoFadeOut() VF:DoFadeOut() end)

		tempframe:GetFontString():ClearAllPoints()
		tempframe:GetFontString():SetPoint("LEFT",25,0)

		self[name.."FrameIcon"] = CHAIN(tempframe:CreateTexture())
			:SetAllPoints()
			:SetPoint("TOPLEFT", tempframe, "TOPLEFT", iconLeftAdjust, iconTopAdjust)
			:SetPoint("BOTTOMRIGHT", tempframe, "TOPLEFT", iconSize+iconLeftAdjust, -iconSize+iconTopAdjust)
			:SetTexture(icon)
		.__END

		if not previous then 
			tempframe:SetPoint("TOPLEFT", MF.NPCFrameTitle, "BOTTOMLEFT", 0, -2)
		else
			tempframe:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
		end
		previous=tempframe
		count = count + 1
	end
	MF:SetHeight(count*rowHeight+titleTextSize+2*titleTopAdjust)

	-- fill tradeskill frame
	local previous=nil
	local count = 0
	for _,name in ipairs(find_nearest_tradeskills) do
		local tempframe = CHAIN(ui:Create("Button",PF))
			:SetSize(rowWidth,rowHeight)
			:SetBackdropColor(0,0,0,0)
			:SetNormalBackdropColor(0,0,0,0)
			:SetHighlightBackdropColor(1,1,1,0.1)
			:SetBackdropBorderColor(0,0,0,0)
			:SetFont(FONT,12)
			:SetText(name)
			:SetScript("OnClick", function(self) 
				MF:Hide()
				PF:Hide()
				CF:Hide()
				VF:Hide()
				ZGV.WhoWhere:FindNPC("Trainer"..name) 
			end)
		.__END
		local button_onenter = tempframe:GetScript("OnEnter")

		tempframe:GetFontString():ClearAllPoints()
		tempframe:GetFontString():SetPoint("LEFT",25,0)

		if not previous then 
			tempframe:SetPoint("TOPLEFT", PF, "TOPLEFT", 0, -2)
		else
			tempframe:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
		end
		previous=tempframe
		count = count + 1
	end
	PF:SetHeight(count*rowHeight)

	-- fill classes frame
	local previous=nil
	local count = 0
	for _,name in ipairs(find_nearest_classes) do
		local tempframe = CHAIN(ui:Create("Button",CF))
			:SetSize(rowWidth,rowHeight)
			:SetBackdropColor(0,0,0,0)
			:SetNormalBackdropColor(0,0,0,0)
			:SetHighlightBackdropColor(1,1,1,0.1)
			:SetBackdropBorderColor(0,0,0,0)
			:SetFont(FONT,12)
			:SetText(name)
			:SetScript("OnClick", function(self) 
				MF:Hide()
				PF:Hide()
				CF:Hide()
				VF:Hide()
				ZGV.WhoWhere:FindNPC("Class"..name) 
			end)
		.__END
		local button_onenter = tempframe:GetScript("OnEnter")

		tempframe:GetFontString():ClearAllPoints()
		tempframe:GetFontString():SetPoint("LEFT",25,0)

		if not previous then 
			tempframe:SetPoint("TOPLEFT", CF, "TOPLEFT", 0, -2)
		else
			tempframe:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
		end
		previous=tempframe
		count = count + 1
	end
	CF:SetHeight(count*rowHeight)

	-- fill vendors frame
	local previous=nil
	local count = 0
	for _,name in ipairs(find_nearest_vendors) do
		local tempframe = CHAIN(ui:Create("Button",VF))
			:SetSize(rowWidth,rowHeight)
			:SetBackdropColor(0,0,0,0)
			:SetNormalBackdropColor(0,0,0,0)
			:SetHighlightBackdropColor(1,1,1,0.1)
			:SetBackdropBorderColor(0,0,0,0)
			:SetFont(FONT,12)
			:SetText(name)
			:SetScript("OnClick", function(self) 
				MF:Hide()
				PF:Hide()
				CF:Hide()
				VF:Hide()
				if name=="Any" then name="" end
				ZGV.WhoWhere:FindNPC("Vendor"..name) 
			end)
		.__END
		local button_onenter = tempframe:GetScript("OnEnter")

		tempframe:GetFontString():ClearAllPoints()
		tempframe:GetFontString():SetPoint("LEFT",25,0)

		if not previous then 
			tempframe:SetPoint("TOPLEFT", VF, "TOPLEFT", 0, -2)
		else
			tempframe:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
		end
		previous=tempframe
		count = count + 1
	end
	VF:SetHeight(count*rowHeight)

	tinsert(UISpecialFrames, MF)
	tinsert(UISpecialFrames, PF) 
	tinsert(UISpecialFrames, CF) 
	tinsert(UISpecialFrames, VF) 

end

function WW:ShowFindNearest()
	local rowWidth = 160	
	local rowBorder = 4
	local totalHeight = 200*ZGV.CLASSIC_SCALE_ADJUST
		
	hide_timer_main = 0
	hide_timer_proff = 0

	if self.NPCFrame:IsShown() then
		self.NPCFrame:DoFadeOut() 
	else
		self.NPCFrame:DoFadeIn() 
	end

	-- Move npc finder above or below the guide viewer, depending on space above the viewer
	self.NPCFrame:ClearAllPoints()
	self.ProfessionFrame:ClearAllPoints()

		self.NPCFrame:SetPoint("BOTTOMLEFT", ZygorGuidesViewerFrame_Border, "TOPLEFT", 0, 10)
		self.ProfessionFrame:SetPoint("BOTTOMLEFT", self.NPCFrame, "BOTTOMRIGHT", 0, 00)
end

function WW:OnEnter()
	GameTooltip:SetOwner(ZGV.Frame, "ANCHOR_TOP")
	GameTooltip:SetText(L['frame_vendor_search'])
	GameTooltip:AddLine(L['frame_vendor_search1'],0,1,0)
	--GameTooltip:AddLine(L['frame_settings2'],0,1,0)
	GameTooltip:Show()
end


function WW:CreateWorkerFrame()
	if self.WorkerFrame then return end
	self.WorkerFrame=CreateFrame("FRAME")
	self.WorkerFrame:Show()
end

local function CalcStep()
	if WW.thread then
		coroutine.resume(WW.thread)
		if coroutine.status(WW.thread)=="dead" then
			WW.thread=nil
			WW.WorkerFrame:SetScript("OnUpdate",nil)
		end
	end
end


local function CalcThread()
	local typ,m,x,y=WW.typ,WW.m,WW.x,WW.y
	if not m then x,y,m=LibRover:GetPlayerPosition() end
	local parse=ZGV.NPCData.parseNPC
	local mindist,minid,minm,minf,minx,miny=999999
	local count=0
	for id,data in ZGV.NPCData:iterate(typ) do
		local npc=parse(data)
		if tonumber(npc.m) and npc.m>0 then
			npc.x=npc.x*0.01
			npc.y=npc.y*0.01
			local dist=HBD:GetZoneDistance(m,x,y,npc.m,npc.x,npc.y)

			if dist and dist<mindist then
				mindist=dist
				minid,minm,minx,miny=tonumber(id),npc.m,npc.x,npc.y
			end
		end
		count=count+1
		if count%100==0 then coroutine.yield() end
	end
	if minid then
		ZGV.Pointer:SetWaypoint(minm,minx,miny,{title=ZGV.Localizers:GetTranslatedNPC(minid),arrow=true,findpath=true,type="manual"},true)
	end

end

function WW:FindNPC(typ,m,f,x,y)
	if typ == "Innkeeper" or not ZGV.db.profile.pathfinding then
		WW:FindNPC_Direct(typ)
	elseif typ then
		WW:FindNPC_Smart(typ)
	end
end

function WW:FindNPC_Direct(typ,m,f,x,y)
	self.typ,self.m,self.f,self.x,self.y=typ,m,f,x,y

	self.WorkerFrame:SetScript("OnUpdate",CalcStep)
	self.thread = coroutine.create(CalcThread)
end

function WW:FindNPC_Smart(typ)
	local parse=ZGV.NPCData.parseNPC
	local foundnpcs = {}
	local npcid, npcdata, npcrawdata

	local npccounter = 1

	for id,data in ZGV.NPCData:iterate(typ) do
		temp = parse(data)
		foundnpcs[npccounter] = {m=temp.m, x=temp.x/100, y=temp.y/100, id=tonumber(id)}
		npccounter = npccounter + 1
	end

	b = foundnpcs[1]
	if not b then return false end

	local more_points = {}
	for i=1,#foundnpcs do
		local w=foundnpcs[i]
		more_points[#more_points+1]={m=w.m,f=w.f,x=w.x,y=w.y,title="Nearest "..typ.." #"..w.id, noskip=true}
	end

	LibRover:FindPath(0,0,0, b.m,b.x,b.y, ZGV.Pointer.PathFoundHandler, {foundnpcs=foundnpcs, direct=not ZGV.db.profile.pathfinding, multiple_ends=more_points })
	LibRover:UpdateNow()
end

function WW:Find_Taxi()
	local cn,cont = ZGV.GetCurrentMapContinent()
	ZGV.LibTaxi:ClearContinentKnowledge(cn,"taxi")
	local taxis={}
	for ni,node in pairs(LibRover.nodes.taxi) do
		if node.c==cont then tinsert(taxis,{m=node.m,f=node.f,x=node.x,y=node.y,title=node.name,name=node.name,id=node.npcid,learnfpath=true}) end
	end
	local b=taxis[1]
	LibRover:FindPath(0,0,0, b.m,b.x,b.y, ZGV.Pointer.PathFoundHandler, {foundnpcs=taxis, direct=not ZGV.db.profile.pathfinding, multiple_ends=taxis })
	LibRover:UpdateNow(true)
end

--------------------------------------------------------------------------------

local function CalcMailboxThread()
	local m, x, y =  WW.m, WW.x, WW.y

	local parse=ZGV.MailboxData.parseMailbox
	local mindist,minid,minm,minf,minx,miny=999999
	local count=0
	for id,data in ZGV.MailboxData:iterate() do
		local mailbox=parse(data)
		if mailbox.m>0 then
			mailbox.x=mailbox.x*0.01
			mailbox.y=mailbox.y*0.01
			local dist = HBD:GetZoneDistance(m,x,y,mailbox.m,mailbox.x,mailbox.y)

			if dist and dist<mindist then
				mindist=dist
				minid,minm,minx,miny=tonumber(id),mailbox.m,mailbox.x,mailbox.y
			end
		end
		count=count+1
		if count%100==0 then coroutine.yield() end
	end
	if minid then
		ZGV.Pointer:SetWaypoint(minm,minx,miny,{title="Mailbox",arrow=true,findpath=true,type="manual"},true)
	end

end



function WW:FindMailbox()
	self.x, self.y, self.m = LibRover:GetPlayerPosition() 
	self.WorkerFrame:SetScript("OnUpdate",CalcStep)
	self.thread = coroutine.create(CalcMailboxThread)
end


tinsert(ZGV.startups,{"WhoWhere",function(self)
	WW:CreateMenuFrame()
	WW:CreateWorkerFrame()
end})