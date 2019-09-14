--[[
	Slidebar AddOn for World of Warcraft (tm)
	Version: 5.15.5383 (LikeableLyrebird)
	Revision: $Id: SlideMain.lua 312 2011-06-14 07:33:25Z brykrys $
	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]

--[[
	This Library has been modified(butchered) for the use in conjection with Zygor Guides.
	It is no longer in it's previous state. It's functionality were just used as a framework.

]]

local ZGV = ZygorGuidesViewer
if not ZGV then return end

local tinsert,tremove,print,ipairs,pairs,wipe,floor,ceil=tinsert,tremove,print,ipairs,pairs,wipe,floor,ceil

local Notification = {["private"]={['lastUpdate']=0}}
local L = ZGV.L
local CHAIN = ZGV.ChainCall
local FONT=ZGV.Font
local FONTBOLD=ZGV.FontBold

local ui = ZGV.UI
local SkinData = ui.SkinData

ZGV.NotificationCenter=Notification

local private = Notification.private

local frame --assigned in DoStartup

local ICONSIZE = 30
local BUTTONHEIGHT = 50
local TEXTHEIGHT = 46	-- Assumed height of the text, used for centering the text vertically.
			-- TODO: Calculate this instead of using a static number.
local MAXTEXTWIDTH = 300
local TOPSPACING = -6

Notification.buttonLayout = {}

--[[  API FUNCTIONS ]]--

-- Capture the bar and stop it from closing (must release!)
function Notification.Capture()
	frame.PopTimer = 0.01
	frame.PopDirection = 1
	frame.captured = true
end

-- Release the bar if you have captured it
function Notification.Release()
	if not frame.captured then return end
	frame.PopTimer = 0.75
	frame.PopDirection = -1
	frame.captured = nil
end

local function SetButtonForRemove(buttonName,guide)
	local function removeButton(addon,event,guidetitle)
		if guide.title == guidetitle then
			ZGV.NotificationCenter.RemoveButton(buttonName)
			ZGV:RemoveHandler(event,removeButton)
		end
	end

	local function OnOpen()
		if not ZGV.guidesloaded then return end
		if (guide.type == "LEVELING" and guide:GetStatus()~="SUGGESTED") or
		(guide.mapid and guide.mapid==ZGV.CurrentMapID)  or
		(guide.condition_end and guide:condition_end())
		then
			if ZGV.Testing and ZGV.Testing.DontHidePopups then return end
			ZGV.NotificationCenter.RemoveButton(buttonName)
			ZGV:RemoveHandler("ZYGORGV_GUIDE_LOADED",removeButton)
		end
	end

	ZGV:AddMessageHandler("ZGV_GUIDE_LOADED",removeButton)

	return OnOpen
end

-- Add a button to the bar, where:
--   id = the id for this button (you will use this to reference the button). --REQUIRED
--   text = text that goes next to the button. Can be a text string or a table where [1] = main text, [2] = Flash text --REQUIRED
--   texture = the path to your button's texture. --REQUIRED
--   texcoords = extra information to cut a texture if there are multiple textures in a single file.
--   onClick = has the onClick function.
--   tooltip = This is a string OR a function. If a string then that string will be the text of the button. If function that will be the onEnter handler.
--   priority = determines your button's position in the list (lower numbers = earlier). TODO this is currently addtime always. overwrites anything passed.
--   poptime = time to have the slide bar slide out. Defaults to 1.5
--   removetime = sets how long the icon will remain on the bar. After this time it will be removed. In seconds
--   quiet = stops sidebar from popping open to let the user know there's a new button.
--   OnOpen = FUNCTION is ran when the NC is opened for the first time after being hidden. Usually used to remove buttons from the NC on special conditions.
--   butType = Can pass the type of popup so that we can handle some special texture stuff
--	 data = Table with some specific information in it. addtime goes in .time, guide goes in .guide
function Notification.AddButton(id, title, text, texture, texcoords, onClick, tooltip, priority, poptime, removetime, quiet, OnOpen, butType, data )
	local flashText = text
	data = data or {}
	onClick = onClick or function() end
	assert(type(id)=="string", "ButtonId must be a string")
	assert(type(texture)=="string", "Texture must be a string")
	if type(text)=="table" then flashText = text[2] text = text[1] end
	assert(type(title)=="string", "Text must be a string")
	assert(type(text)=="string", "Text must be a string")
	assert(type(onClick)=="function", "OnClick must be a function")
	assert(type(data)=="table", "Data must be a table if it is there.")
	if data.guide and not data.dontdelete then
		OnOpen = SetButtonForRemove(id,data.guide)
	end

	local button

	if not frame then return end

	if not frame.buttons[id] then
		button = CHAIN(CreateFrame("Button", "", frame))
			:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
			:RegisterForClicks("LeftButtonUp","RightButtonUp")
			:SetSize(ICONSIZE+MAXTEXTWIDTH,BUTTONHEIGHT)
			:SetScript("OnMouseDown", function (self, ...) private.MouseDown(self.frame, self, ...) end)
			:SetScript("OnMouseUp", function (self, ...) private.MouseUp(self.frame, self, ...) end)
			:SetScript("OnLeave", function (self, ...)
				private.PopBack(self.frame, self, ...)
				GameTooltip:Hide()
			end)
		.__END

		button.icon = CHAIN(button:CreateTexture("", "BACKGROUND"))
			:SetPoint("LEFT", button, "LEFT", 0, TOPSPACING)
			:SetSize(ICONSIZE,ICONSIZE)
		.__END

		button.title = CHAIN(button:CreateFontString())
			:SetJustifyH("LEFT") :SetJustifyV("CENTER")
			:SetFont(FONT,14)
			:SetTextColor(1.0,1.0,1.0)
			:SetPoint("LEFT",button.icon,"RIGHT",15,5)
			:SetPoint("TOP",button,"TOP",0,(TEXTHEIGHT-BUTTONHEIGHT)/2+TOPSPACING)
			:SetSize(button:GetWidth() - ICONSIZE,15)
		.__END
		
		button.text = CHAIN(button:CreateFontString())
			:SetJustifyH("LEFT") :SetJustifyV("CENTER")
			:SetFont(FONT,11) --TODO Make this size adjustable along with button size
			:SetTextColor(1.0,1.0,1.0)
			:SetPoint("LEFT",button.icon,"RIGHT",15,-8)
			:SetPoint("TOP",button.title,"BOTTOM",0,0)
			:SetSize(button:GetWidth() - ICONSIZE,12) --Height = size * 2 to allow for wrapping
		.__END
		button:SetFontString(button.text)

		button.timestamp = CHAIN(button:CreateFontString())
			:SetJustifyH("LEFT") :SetJustifyV("BOTTOM")
			:SetFont(FONT,11) --TODO Make this size adjustable along with button size
			:SetTextColor(0.5,0.5,0.5)
			:SetPoint("TOPLEFT",button.text,"BOTTOMLEFT",0,-3)
			:SetSize(button:GetWidth()-ICONSIZE,9) -- using SetPoint for positioning vertically, not SetSize . . . ~~ Jeremiah
		.__END

		-- That down arrow, a requested thing by Andrew.
		-- Doesn't actually do anything, the mouse click just goes
		-- through to the clickable area underneath.
		-- ~~ Jeremiah
		button.arrowButton = CHAIN(CreateFrame("Button", "arrowButton"..id, button))
			:SetPoint("RIGHT", button, "RIGHT", -20,0)
			:SetSize(16,16)
			:EnableMouse(false)
		.__END
		
		local count=32
		local BUTTONTEXTURE = SkinData("TitleButtons")
		ZGV.F.AssignButtonTexture(button.arrowButton,BUTTONTEXTURE,11,count)

		button.frame = frame
		button.texcoords = texcoords
		button.id = id

		frame.buttons[id] = button
	else
		button = frame.buttons[id]
	end

	--Do the following outside because we might be able to reuse a old button and these are the things that could change.
	button.OnOpen = OnOpen

	button.titleString = title
	
	button.textString, button.flashTextString = text, flashText

	button.title:SetText(title)
	
	button.text:SetText(text)

	button.timestamp:SetPoint("TOP",button.text,"BOTTOM",5,4) --This assumes no text wrapping. Will fix OnUpdate if needed.

	button.addtime = data.time or time()

	button.removeTime = removetime

	button.butType = butType

	button.data = data

	button.icon:SetTexture(texture)
	if texcoords then
		button.icon:SetTexCoord(unpack(texcoords))
	end

	button:SetScript("OnClick", function(self)
		ZGV.NotificationCenter.RemoveButton(self.id) -- ******* All buttons are removed when you click them. Change this if there is a case where we don't want the button removed. ***********
		private:PerformClose() --Close automatically when something is clicked

		onClick(self)
	end)
	button:SetScript("OnEnter", function (self, ...)
		private.PopOut(self.frame, self, ...)
		if tooltip and type(tooltip)=="function" then
			tooltip(self)
		else
			local position,x,y = ZGV.NotificationCenter:GetTooltipPosition()
			GameTooltip:SetOwner(self, position or "ANCHOR_CURSOR",x or 0, y or 0)

			GameTooltip:SetText(tooltip or text) -- Either use tooltip string or just use the text next to the button
			GameTooltip:SetToplevel(true)
			GameTooltip:Show()
		end
	end)

	button.priority = button.addtime

	--if priority or not button.priority then
	--	button.priority = priority or button.addtime
	--end

	button.removed = nil
	button:Show()

	if quiet then
		Notification.ApplyLayout()
	else
		local side = Notification.config.anchor or "top"; side = side:lower()

		button.defaultpriority = button.priority
		if not frame.captured then
			if side == "top" or side =="left" then --We want this button to be the closest to the center so we can flash only it.
				button.priority = -math.huge	-- infinity
			else
				button.priority = math.huge	-- negative infinity
			end
		end

		-- Show people that the button has popped in and only flash that one button, not all of the frame
		Notification.FlashOpen(poptime,true)
	end

	Notification.UpdateTimeStamp(id)

	return button
end

-- Gets the button with the associated id (if it exists)
function Notification.GetButton(id)
	return frame.buttons[id]
end

-- Gets the button with the associated id (if it exists)
function Notification.ButtonIsShown(id)
	local button = frame.buttons[id]
	if not button then return end
	return not (button.removed or button.hidden)
end

-- Removes the button with the associated id from the bar
function Notification.RemoveButton(id)
	local button = frame.buttons[id]
	if not button then return end
	Notification:Debug(id.." Removed.")

	button:Hide()
	button.removed = true
	Notification.ApplyLayout()
end

-- Causes the button to be displayed (persists across sessions)
function Notification.ShowButton(id)
	local button = frame.buttons[id]
	assert(button, "ButtonId "..id.." does not exist")
	button.hidden = nil
	button.removed = nil
	Notification.ApplyLayout()
end

-- Causes the button to be hidden (persists across sessions)
function Notification.HideButton(id)
	local button = frame.buttons[id]
	assert(button, "ButtonId "..id.." does not exist")
	button.hidden = true
	Notification.ApplyLayout()
end

-- Causes the bar to flash open for a given number of seconds
function Notification.FlashOpen(delay,flashOneButton)
	private:PerformOpen(flashOneButton)
	-- Schedule a close in 1.5 seconds
	frame.PopTimer = delay or 3.5
	frame.PopDirection = -1
end

--Current time - saved time = total time added.
-- time / 3600 = # hour
-- time / 60 = # min
-- time = seconds
function Notification.UpdateTimeStamp(id)
	local button = frame.buttons[id]

	button.timestamp:SetText(ui.GetTimeStamp(button.addtime))

	if button.text:GetStringWidth() > button:GetWidth() - ICONSIZE then -- We are wrapped so move the time stamp down a little
		button.timestamp:SetPoint("TOP",button.text,"BOTTOM",5,-1)
	end
end

function Notification.TestForRemoval(id)
	local button = frame.buttons[id]
	if not button.removeTime then return end

	local time = time() - button.addtime

	if button.removeTime < time then
		Notification.RemoveButton(id)
	end
end

-- Updates the bar's buttons and position
function Notification.ApplyLayout(collapsing,flashOneButton)
	if type(collapsing)=="table" then collapsing=nil end --Notification:ApplyLayout() -> bad call... meh
	frame.active =  ZGV.db.profile.n_nc_enabled
	frame.hideText = ZGV.db.profile.n_nc_hide_text
	frame.alwaysShow = ZGV.db.profile.n_nc_alwaysshow

	collapsing = collapsing or not frame.isOpen --obviously if we are collapsing, but if we are closed then keep it small
	local side = Notification.config.anchor or "top"; side = side:lower()
	local position = tonumber(Notification.config.position) or UIParent:GetWidth()/2 or 180
	local active =  frame.active
	local hideText = frame.hideText
	local captured = frame.captured
	local show = frame.alwaysShow

	--Only want to flash one button if in Icon mode, or if NC is on top or bottom.
	--Seems pointless to show only of button if popping from left or right with text because it will already take up that horizontal space so the
	--vertical addition should not be an issue.
	flashOneButton = flashOneButton and (hideText or side == "top" or side == "bottom")
	if captured then flashOneButton = nil end

	Notification:Debug("Applying Layout")

	if not active then
		Notification:Debug("Not Active. Hiding")
		frame:Hide()
		return
	end

	wipe(Notification.buttonLayout)

	local layout = Notification.buttonLayout

	for id, button in pairs(frame.buttons) do
		if not (button.removed or button.hidden) then
			Notification:Debug(button.id.." Inserted.")
			table.insert(layout, button)
		elseif button:IsShown() then
			Notification:Debug(button.id.." Hidden.")
			button:Hide()
		end
	end

	local numlayout = #layout

	if numlayout == 0 and not (captured or show)then --No buttons to show so we can stop here.
		Notification:Debug("No buttons. Hiding")
		frame:Hide()
		return
	end

	table.sort(layout, private.buttonSort) --Sort the buttons by importance.

	--Now we have a table of buttons in the order we want to display them.

	local width,height
	--local ICONSPACE = ICONSIZE + 10
	local ICONSPACE = BUTTONHEIGHT

	frame.noButtons:Hide()

	if hideText or collapsing then
		width = ICONSPACE + 5 --TODO could use #layout to create two rows of icons. Double width, half height etc..if (#layout < width) then width = #layout end
		height = numlayout * ICONSPACE + (numlayout > 0 and 5 or 10)-- (#buttons / width) * height for each.. max(floor((#layout - 1) / (width/ICONSPACE)),1) * ICONSPACE + 18 -
		frame.Title:Hide()
		frame.blackBar:Hide()
	elseif flashOneButton then
		height = numlayout * ICONSPACE + 10
		width = ICONSPACE + MAXTEXTWIDTH + 5
		frame.Title:Hide()
		frame.blackBar:Hide()
	else
		height =  numlayout* ICONSPACE + 30 --Extra height for title
		width = ICONSPACE + MAXTEXTWIDTH + 5
		if #layout == 0 and ( captured or show) then
			frame.noButtons:Show()
			height = height + 20 --room for the extra text
		end
		frame.Title:Show()
		frame.blackBar:Show()
	end

	local distance = 9 -- When the notification center is closed
	if frame.isOpen then
		distance = height
	end

	if flashOneButton then
		distance = ICONSPACE + 10
	end

	frame:ClearAllPoints()
	frame.Tab:ClearAllPoints()
	frame.Title:ClearAllPoints()
	frame.blackBar:ClearAllPoints()
	if (side == "top" or side == "bottom") then
		frame:SetWidth(width)
		frame:SetHeight(height)
		if (side == "top") then
			frame:SetPoint("BOTTOM", UIParent, "TOPLEFT", position, -distance)

			frame.Title:SetPoint("TOP",frame,"TOP",0,-5)
			
			frame.blackBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
			frame.blackBar:SetPoint("BOTTOM", frame.Title, "BOTTOM", 0,-6)
			frame.blackBar:SetPoint("RIGHT", frame, "RIGHT", 0,0)

			frame.Tab:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT",0,0)
			frame.Tab:SetPoint("RIGHT", frame, "RIGHT")
		else
			frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", position, distance)

			frame.Title:SetPoint("TOP",frame.Tab,"BOTTOM",0,-5)

			frame.blackBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
			frame.blackBar:SetPoint("BOTTOM", frame.Title, "BOTTOM", 0,-6)
			frame.blackBar:SetPoint("RIGHT", frame, "RIGHT", 0,0)
			
			frame.Tab:SetPoint("TOPLEFT", frame, "TOPLEFT",0,0)
			frame.Tab:SetPoint("RIGHT", frame, "RIGHT")
		end

		frame.Tab:SetHeight(1)
	else --side = left/right
		local realWidth = (hideText or collapsing) and height or width --need these because on Left/Right height and width swap but only in the small mode.
		local realHeight = (hideText or collapsing) and width or height
		frame:SetWidth(realWidth)
		frame:SetHeight(realHeight)

		if frame.isOpen and not flashOneButton then
			distance = realWidth
		end

		frame.Title:SetPoint("TOP",frame,"TOP",0,-5)

		if (side == "right") then
			frame:SetPoint("TOPLEFT", UIParent, "TOPRIGHT", -distance, -position)

			frame.blackBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
			frame.blackBar:SetPoint("BOTTOM", frame.Title, "BOTTOM", 0,-6)
			frame.blackBar:SetPoint("RIGHT", frame, "RIGHT", 0,0)

			frame.Tab:SetPoint("TOPLEFT", frame, "TOPLEFT",1,-1)
			frame.Tab:SetPoint("BOTTOM", frame, "BOTTOM")
		else
			frame:SetPoint("TOPRIGHT", UIParent, "TOPLEFT", distance, -position)

			frame.blackBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
			frame.blackBar:SetPoint("BOTTOM", frame.Title, "BOTTOM", 0,-6)
			frame.blackBar:SetPoint("RIGHT", frame, "RIGHT", 0,0)

			frame.Tab:SetPoint("TOPRIGHT", frame, "TOPRIGHT",-1,-1)
			frame.Tab:SetPoint("BOTTOM", frame, "BOTTOM")
		end

		frame.Tab:SetWidth(1)
	end
	frame:Show()

	local maxWidth = 0
	
	for pos = 1, #layout do while(1) do
		local button = layout[pos]
		local position = pos - 1

		if collapsing then --collapsing so just hide the buttons instead of moving them around.
			button:Hide()
			break
		end
		
		if (hideText and 0 or button:GetTextWidth())/1.5 > maxWidth then
			maxWidth = (hideText and 0 or button:GetTextWidth())/1.5
		end
		
		if ICONSIZE + ICONSPACE + 10 + (hideText and 0 or button.text:GetStringWidth()) > maxWidth then
			maxWidth = ICONSIZE + ICONSPACE + 10 + (hideText and 0 or button.text:GetStringWidth())
		end
		
		if maxWidth < MAXTEXTWIDTH-ICONSIZE then maxWidth = MAXTEXTWIDTH-ICONSIZE end -- Have a minimum size for notifications. 

		frame:SetWidth( maxWidth )
		
		button:SetWidth( maxWidth )
		
		--button.arrowButton:SetPoint("RIGHT", frame, "RIGHT", -20,0)
		
		button.title:SetShown(not hideText)
		button.text:SetShown(not hideText)
		button.timestamp:SetShown(not hideText)

		if not hideText then
			local titleSpace = flashOneButton and 5 or 25 --Space under title
			--if side=="bottom" then titleSpace = titleSpace + 7 end --on the bottom so the title got moved down
			button:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -(position*ICONSPACE+titleSpace))
		else
			local col = math.floor(position / floor((width/ICONSPACE)))
			local row = position % floor((width/ICONSPACE))

			local colSpace =  col*ICONSPACE
			local rowSpace =  row*ICONSPACE+7

			--print(("Side: %s, Pos: %d, Row: %d, RowSpace: %d, Col: %d, ColSpace: %d"):format(side,pos,row,rowSpace,col,colSpace))

			button:ClearAllPoints()
			if (side == "right") then
				button:SetPoint("TOPLEFT", frame, "TOPLEFT", colSpace, -rowSpace)
			elseif (side == "left") then
				button:SetPoint("TOPLEFT", frame, "TOPLEFT", colSpace, -rowSpace)
			elseif (side == "bottom") then
				button:SetPoint("TOPLEFT", frame, "TOPLEFT", rowSpace, -colSpace)
			elseif (side == "top") then
				button:SetPoint("TOPLEFT", frame, "TOPLEFT", rowSpace, -colSpace)
			end
		end

		if flashOneButton then
			if not button.defaultpriority then
				Notification:Debug(button.id.." Hiding because flashOneButton or not default priority.")
				button:Hide()
				break
			else
				button:SetText(button.flashTextString)
			end
		else
			button:SetText(button.textString)
		end

		Notification:Debug(button.id.." Showing.")
		button.priority = button.defaultpriority or button.priority --if defaultpriority is available then get rid of it.
		button.defaultpriority = nil
		button:Show()
	break end end

	for pos = 1, #layout do while(1) do
		local button = layout[pos]
		local position = pos - 1
		if maxWidth > 0 then
			frame:SetWidth( maxWidth )
		
			button:SetWidth( maxWidth )
		end
	break end end

end

--[[  END OF API FUNCTIONS ]]--

-- Private functions and variables follow, you shouldn't need to fiddle with these.

function Notification:GetTooltipPosition()
	local position,x,y = self.config.anchor or "top",0,0
	if position=="top" then position="ANCHOR_BOTTOM" y=-5 elseif position=="bottom" then position="ANCHOR_TOP" y=5 end
	if position=="left" then position="ANCHOR_RIGHT" elseif position=="right" then position="ANCHOR_LEFT" end
	return position,x,y
end

function Notification:UpdateSkin()
	if not self.frame then return end

	self.frame:SetBackdrop(SkinData("NotificationBackdrop"))
	self.frame:SetBackdropColor(unpack(SkinData("NotificationBackdropColor")))
	self.frame:SetBackdropBorderColor(unpack(SkinData("NotificationBackdropBorderColor")))
end

-- Saves all notfications into saved variables so that we can bring them back later.
function Notification:SaveNotifications()
	if not ZGV.db.char.notifications then ZGV.db.char.notifications = {} else wipe(ZGV.db.char.notifications) end
	-- Wipe the old in with the new
	local saved = ZGV.db.char.notifications
	
	for i,notif in ipairs(self.buttonLayout) do
		-- Loop through all current notifcations
		if notif.butType == "pet" then
			saved[notif.id] = {
				notif.butType,
				notif.titleString,
				notif.textString,
				notif.addtime,
				notif.icon:GetTexture(),
				notif.texcoords,
			}
		elseif notif.butType == "sis" or notif.butType == "mount" or notif.butType == "monk" or notif.butType == "legion" then
			local guideTitle = notif.data.guide.title 
			saved[guideTitle] = {
				notif.butType,
				notif.titleString,
				notif.textString,
				notif.addtime,
				notif.icon:GetTexture(),
				notif.texcoords,
				notif.data,
			}
		end
	end
end

function Notification:AddedSavedNotifications()
	if not ZGV.db.char.notifications then return end

	for id,info in pairs(ZGV.db.char.notifications) do
	
		-- Probably from adding the "title" field, which wasn't there before.
		-- Wipe notifications and start anew. ~~ Jermeiah
		if type(info[3]) ~= "string" then
			wipe(ZGV.db.char.notifications)
			return
		end

		local myId,title,text,texture,texCoord,OnClick,OnEnter,priority,poptime,removetime,quiet,OnOpen,myType,addtime,guideData

		local guide = ZGV:GetGuideByTitle(id)

		myId = id
		myType = info[1]
		title = info[2]
		text = info[3]
		addtime = info[4]
		texture = info[5] or ""
		texCoord = info[6]
		data = info[7]

		if info[1] == "pet" then
			ZGV.CreatureDetector:AddGuideToDetectedGuides(guide)

			OnClick = function(self) ZGV:SetGuide(ZGV.CreatureDetector.DetectedGuides[self.id]) end
			OnEnter = function(self) local position,x,y = Notification:GetTooltipPosition() ZGV.CreatureDetector:ShowTooltip(ZGV.CreatureDetector.DetectedGuides[self.id],self,position,x,y) end
		elseif info[1] == "sis" or info[1] == "mount" or info[1] == "monk" then
			guideData = guide
			OnClick = function(self) ZGV:SetGuide(guide) end
		elseif info[1] == "legion" then
			guideData = guide
			OnClick = function(self) ZGV:PLAYER_LEVEL_UP(nil,data.level) end
		end

		ZGV.NotificationCenter.AddButton(
			myId,
			title,
			text,
			texture,
			texCoord,
			OnClick,
			OnEnter,
			priority,
			poptime,
			removetime,
			quiet,
			OnOpen,
			myType,
			{time=addtime,guide=guideData,level=(data and data.level or nil),dontdelete=(data and data.dontdelete or nil)})
	end
end

function Notification.Frame_OnEvent(frame,event,arg1,...)
	if event=="PLAYER_LOGOUT" then
		-- Called on logout, /reloadui, exit through the ingame button, hit the X or hit alt+f4
		-- Not called if you end the process for WoW but who does that?.. So safe enough
		Notification:SaveNotifications()
	end

end

function Notification:CreateNotificationFrame()
	frame = CHAIN(CreateFrame("Frame", "Zygor_Notification_Center", UIParent))
		:SetToplevel(true)
		:SetFrameStrata("TOOLTIP")
		:SetHitRectInsets(-3, -3, -3, -3)
		:EnableMouse(true)
		:RegisterEvent("PLAYER_LOGOUT")
		:SetScript("OnEvent",Notification.Frame_OnEvent)
		:SetScript("OnEnter", private.PopOut)
		:SetScript("OnLeave", private.PopBack)
		:SetScript("OnMouseDown", private.BeginMove)
		:SetScript("OnMouseUp", private.EndMove)
		:SetScript("OnUpdate", private.OnUpdate)
	.__END

	frame.Title = CHAIN(frame:CreateFontString())
		:SetFont(FONT,15) --TODO Make this size adjustable along with button size
		--:SetTextColor(0.9,0.4,0.1)
		:SetPoint("TOP",frame,"TOP",0,-5)
		:SetText(L['notifcenter_title'])
	.__END

	frame.noButtons = CHAIN(frame:CreateFontString())
		:SetFont(FONT,13) --TODO Make this size adjustable along with button size
		--:SetTextColor(0.9,0.4,0.1)
		:SetPoint("TOP",frame.Title,"BOTTOM",0,-10)
		:SetText(L['notifcenter_no_buttons'])
		:Hide()
	.__END

	-- Black bar at the top ~~ Jeremiah 
	frame.blackBar = CHAIN(frame:CreateTexture("blackBar", "BACKGROUND"))
		:SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0)
		:SetPoint("BOTTOM", frame.Title, "BOTTOM", 0,-6)
		:SetPoint("RIGHT", frame, "RIGHT", 0,0)
		:SetColorTexture(0.01, 0.01, 0.01, 1.0)
		:SetDrawLayer("BACKGROUND", 1)
		:Show()
	.__END
	
	frame.Tab = frame:CreateTexture() --This is the grey bar at the bottom.
	frame.Tab:SetColorTexture(unpack(SkinData("MainBackdropBorderColor")))
	frame.buttons = {}

	self.frame = frame
	self:UpdateSkin()
end

function Notification:DoStartup()
	self:CreateNotificationFrame()

	if not ZGV.db.profile.slidebarconfig then
		ZGV.db.profile.slidebarconfig = {}
	end

	self.config = ZGV.db.profile.slidebarconfig

	Notification.ApplyLayout()
end

-- Functions to start and stop the sidebar drag
function private:BeginMove(...)
	if Notification.config.locked == "1" or ZGV.db.profile.n_nc_locked then return end
	local button = ...
	if button == "LeftButton" then
		frame:SetClampedToScreen(true)
		private.moving = true
	end
end

function private:EndMove(...)
	if private.moving then
		frame:SetClampedToScreen(false)
		private.moving = nil
	end
end

-- Checks to see if the argument is a button
function private.IsButton(button)
	if not button then return end
	if type(button) ~= "table" then return end
	if button.id and button.icon then return true end
end

-- Functions to control the popping in and out of the bar
function private:PopOut(...)
	local button = ...
	self.PopTimer = 0.15
	self.PopDirection = 1
	if private.IsButton(button) then -- this is a button
		if button.texcoords then
			local mul = .992
			local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = button.icon:GetTexCoord()
			if button.butType=="sis" then mul = .975 end
			if button.butType=="default" then mul = .995 end
			button.icon:SetTexCoord(ULx*mul, ULy*mul, LLx*mul, LLy*mul, URx*mul, URy*mul, LRx*mul, LRy*mul)
		else
			button.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		end
		if button.OnEnter then button:OnEnter(select(2, ...)) end
	end
end

function private:PopBack(...)
	local button = ...
	self.PopTimer = 0.75
	self.PopDirection = -1
	if private.IsButton(button) then -- this is a button
		if button.texcoords then
			button.icon:SetTexCoord(unpack(button.texcoords))
		else
			button.icon:SetTexCoord(0.025, 0.975, 0.025, 0.975)
		end

		if button.OnLeave then button:OnLeave(select(2, ...)) end
	end
end

function private:PerformOpen(flashOneButton)
	-- Pop Out
	frame.PopDirection = nil
	frame:ClearAllPoints()

	if not frame.isOpen then -- if not isOpen then we are opening for the first time so update all the buttons for this open!
		for id,but in pairs(frame.buttons) do
			if but.OnOpen then but:OnOpen() end

			if but.removeTime then
				Notification.TestForRemoval(id)
			end

			if not ZGV.db.profile.n_nc_hide_text then
				Notification.UpdateTimeStamp(id)
			end
		end
	end

	frame.isOpen = true

	Notification.ApplyLayout(nil,flashOneButton)
end

function private:PerformClose()
	-- Pop Back
	if frame.captured then return end
	frame.PopDirection = nil
	frame:ClearAllPoints()
	frame.isOpen = false
	Notification.ApplyLayout(true)
	for _,button in pairs(frame.buttons) do
		if button.OnClose then button:OnClose() end
	end
end

function private:OnUpdate(...)
	local duration = ...
	local curTime = time()
	if curTime - private.lastUpdate > 10 then
		private.lastUpdate = time()
		for id,but in pairs(frame.buttons) do
			if but.removeTime then
				Notification.TestForRemoval(id)
			end
			if not ZGV.db.profile.n_nc_hide_text then
				Notification.UpdateTimeStamp(id)
			end
		end
	end

	if private.moving then
		local side, pos = private.boxMover()
		Notification.config.anchor = side
		Notification.config.position = pos
		frame.isOpen=true --We are moving the frame so it is going to be open.
		Notification.ApplyLayout()
		frame.isOpen=nil
		return
	end
	if self.PopDirection then
		self.PopTimer = self.PopTimer - duration
		if self.PopTimer < 0 then
			if self.PopDirection > 0 then
				private:PerformOpen()
			else
				private:PerformClose()
			end
		end
	end
end

-- Functions to make the icon enlarge/shrink when the mouse moves over it
function private:MouseDown(...)
	local button = ...
	if button then
		if button.texcoords then
			local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = button.icon:GetTexCoord()
			local mul = .987
			if button.butType=="default" then mul=.996 end
			button.icon:SetTexCoord(ULx*mul, ULy*mul, LLx*mul, LLy*mul, URx*mul, URy*mul, LRx*mul, LRy*mul)
		else
			button.icon:SetTexCoord(0, 1, 0, 1)
		end
	end
	if self.MouseDown then self:MouseDown(...) end
end

function private:MouseUp(...)
	local button = ...
	if button then
		if button.texcoords then
			button.icon:SetTexCoord(unpack(button.texcoords))
		else
			button.icon:SetTexCoord(0.025, 0.975, 0.025, 0.975)
		end
	end
	if self.MouseUp then self:MouseUp(...) end
end

-- Function to sort the buttons by priority during the layout phase
function private.buttonSort(a, b)
	if (a.priority ~= b.priority) then
		return a.priority > b.priority
	end
	return a.id < b.id
end

-- Function to work out where along the edge of the screen to position the bar
local SWITCH_TEXELS = 100 -- number of texels to do edge switches at
function private.boxMover()
	local curX, curY = GetCursorPosition()
	local uiScale = UIParent:GetEffectiveScale()
	local uiWidth, uiHeight = UIParent:GetWidth(), UIParent:GetHeight()
	curX, curY = curX / uiScale, curY / uiScale

	local anchor = Notification.config.anchor or "right"

	if anchor == "top" and curY < uiHeight - SWITCH_TEXELS
	or anchor == "bottom" and curY > SWITCH_TEXELS then
		if curX < SWITCH_TEXELS then
			anchor = "left"
		elseif curX > uiWidth - SWITCH_TEXELS  then
			anchor = "right"
		end
	elseif anchor == "left" and curX > SWITCH_TEXELS
	or anchor == "right" and curX < uiWidth - SWITCH_TEXELS then
		if curY < SWITCH_TEXELS then
			anchor = "bottom"
		elseif curY > uiHeight - SWITCH_TEXELS  then
			anchor = "top"
		end
	end

	local pos
	if anchor == "top" or anchor == "bottom" then
		pos = curX
	else
		pos = uiHeight - curY
	end

	return anchor, pos - 16
end

-- Setup our main frame (or reuse the old one)

tinsert(ZGV.startups,{"NC startup",function(self)
	Notification:DoStartup()
	Notification:AddedSavedNotifications()
end})

function Notification:Debug(...)
	local str = ...
	ZGV:Debug("&notifications "..str)
end