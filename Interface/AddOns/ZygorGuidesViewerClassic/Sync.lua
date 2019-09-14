local ZGV=ZygorGuidesViewer

local Sync={}
ZGV.Sync = Sync

local PREFIX="zygor7sync"

local PACKETTYPE_GUIDESTATUS = "GS"
local PACKETTYPE_STATUSREQUEST = "SR"
local PACKETTYPE_STEPREQUEST = "SQ"
local PACKETTYPE_STEPDATA = "SD"
local PACKETTYPE_STEPSTICKY = "SS"
local PACKETTYPE_STEPLINE = "SL"
local PACKETTYPE_STEPEND = "SE"
local PACKETTYPE_SLAVEREQUEST = "MS"

--[[

"MAGNETIC" SYNC:

Everyone synced progresses only when:
 - they're on the same step, and
 - the steps are all completed.

Each step change is announced to other party members.

Packet GS (GuideState):
  "GS""
  "##GU=" <guide title>
  "##ST=" <step number> "," <status> (0=incomplete/1=complete)
  "##GO=" <goal status> "," <goal status...> (0=incomplete/1=complete/2=impossible)

	Receiving of GS packet stores party member's guide state indefinitely, until further GS data,
	disconnection or leaving the party.

	Step progress is halted as long as there are party members' statuses stored, indicating
	current step being current and incomplete.
--]]

local empty_table={}
function Sync:CreatePacket_GuideStatus()
	local guide_title=ZGV.CurrentGuide and ZGV.CurrentGuide.title or ""

	local function GetStepStatus(step)
		local goals={}
		for gi,goal in ipairs(step.goals) do
			local completable=goal:IsCompleteable()
			local complete,possible,numdone,numneeded = goal:IsComplete()
			goals[gi]=(not completable and "-") or (complete and "c") or (possible and ("%d/%d"):format(numdone,numneeded)) or "i"
		end
		return ("%d,%d;%s"):format(step.shared_origin or step.num,step:IsComplete() and 1 or 0, table.concat(goals,","))
	end

	local ST="##ST=0,0;0"
	local SS = ""
	if ZGV.CurrentStep then
		ST="##ST="..GetStepStatus(ZGV.CurrentStep)

		local stickies = ZGV:GetStickiesAt(ZGV.CurrentStep.num)
		for i,sticky in ipairs(stickies or empty_table) do
			if #SS==0 then SS="##SS=" else SS=SS.."/" end
			SS=SS..GetStepStatus(sticky)
		end
	end

	return ("%s##GU=%s##MS=%d"):format(PACKETTYPE_GUIDESTATUS, guide_title, ZGV.db.profile.share_masterslave) .. ST .. SS
end

function Sync:CreatePackets_StepData()
	if not ZGV.CurrentGuide or ZGV.CurrentGuide.headerdata.shared then return end

	local ret={}

	local guide_title=ZGV.CurrentGuide.title_short
	local step_num=ZGV.CurrentStepNum

	local steplines = self:GetStepSource(ZGV.CurrentStepNum)
	if not steplines or #steplines==0 then ZGV:Print("Unable to share current step!") return end

	table.insert(ret,("%s##GU=%s##ST=%d##LA=%s##SL=%d"):format(PACKETTYPE_STEPDATA, guide_title, step_num, ZGV.CurrentStep.label or "", #steplines))
	for li,line in ipairs(steplines) do
		if #line>230 then line="ERROR: LINE TOO LONG |"..line:sub(1,200) end
		table.insert(ret,("%s##%d:%d:%s"):format(PACKETTYPE_STEPLINE,step_num,li,line))
	end

	local stickies = ZGV:GetStickiesAt(step_num)
	for i,sticky in ipairs(stickies) do
		local steplines = self:GetStepSource(sticky.num)
		if not steplines or #steplines==0 then ZGV:Print("Unable to share sticky step!") return end
		table.insert(ret,("%s##ST=%d##LA=%s##SL=%d"):format(PACKETTYPE_STEPSTICKY, sticky.num, sticky.label or "", #steplines))
		for li,line in ipairs(steplines) do
			if #line>230 then line="ERROR: LINE TOO LONG |"..line:sub(1,200) end
			table.insert(ret,("%s##%d:%d:%s"):format(PACKETTYPE_STEPLINE,sticky.num,li,line))
		end
	end

	table.insert(ret,("%s##"):format(PACKETTYPE_STEPEND))

	return unpack(ret)
end

function Sync:CreatePacket_StatusRequest()
	return ("%s##"):format(PACKETTYPE_STATUSREQUEST)
end

function Sync:CreatePacket_StepRequest()
	return ("%s##"):format(PACKETTYPE_STEPREQUEST)
end

function Sync:CreatePacket_SlaveRequest()
	return ("%s##GU=%s"):format(PACKETTYPE_SLAVEREQUEST,ZGV.CurrentGuide.title_short)
end


-- /run SDs={ZGV.Sync:CreatePackets_StepData()} for i,pck in ipairs(SDs) do ZGV.Sync:OnChatReceived("zygor7sync",pck,"party","Alice") end

function Sync:SplitXXIntoPacket(packet,data)
	local databits={("##"):split(data)}
	for i,bit in ipairs(databits) do
		local k,v = bit:match("(..)=(.+)")
		if k then packet[k]=v elseif #bit==2 then packet[k]=true end
	end
end

function Sync:OnChatReceived(prefix,msg,channel,sender,target,zoneChannelID,localID,name,instanceID)
	local sname,srealm = sender:match("(.*)%-(.*)")
	if sname then sender=sname end
	if sender==UnitName("player") then return end
	self:Debug("|cffaaff00RCV|r: %s",msg)

	if prefix~=PREFIX then return end
	local packettype,data = msg:match("(..)##(.*)")
	if not packettype then self:Debug("Bad packet received: ",msg) return end
	local packet={['type']=packettype,['sender']=sender,['recv_time']=GetTime()}
	self:Unpack(packet,data)
	self:HandleReceivedPacket(packet)
end

local dummy_notcompletable={completable=false}
local dummy_complete={completable=true,complete=true}
local function grab_goals(goalstring,target)
	local goals = {(","):split(goalstring)}
	target.goals={}
	for i,g in ipairs(goals) do
		if g=="-" then
			target.goals[i]=dummy_notcompletable
		elseif g=="c" then
			target.goals[i]=dummy_complete
		else
			local done,needed = g:match("(%d+)/(%d+)")
			done=tonumber(done)
			needed=tonumber(needed)
			target.goals[i]={completable=true,complete=false,done=done,needed=needed}
		end
	end
end

function Sync:Unpack(packet,data)
	if packet.type==PACKETTYPE_GUIDESTATUS then
		self:SplitXXIntoPacket(packet,data)
		packet.guide = packet.GU
		local stepnum,complete,goals = packet.ST:match("(.*),(.*);(.*)")
		packet.stepnum = tonumber(stepnum)
		packet.is_complete = complete=="1"
		if goals then grab_goals(goals,packet) end
		
		if packet.SS then -- sticky statuses, all of them
			local stickies = {("/"):split(packet.SS)}
			packet.stickies = {}
			for i,stickystatus in ipairs(stickies) do
				local stepnum,complete,goals = stickystatus:match("(.*),(.*);(.*)")
				local stickydata={}
				stickydata.stepnum = tonumber(stepnum)
				stickydata.is_complete = complete=="1"
				if goals then grab_goals(goals,stickydata) end
				table.insert(packet.stickies,stickydata)
			end
		end

		if packet.MS then packet.sharemode = tonumber(packet.MS) end

	elseif packet.type==PACKETTYPE_STEPDATA then
		self:SplitXXIntoPacket(packet,data)
		packet.guide = packet.GU
		packet.stepnum = tonumber(packet.ST)
		packet.label = packet.LA
		packet.lines = {}
		packet.linecount = tonumber(packet.SL)

	elseif packet.type==PACKETTYPE_STEPSTICKY then
		self:SplitXXIntoPacket(packet,data)
		packet.stepnum = tonumber(packet.ST)
		packet.label = packet.LA
		packet.lines = {}
		packet.linecount = tonumber(packet.SL)

	elseif packet.type==PACKETTYPE_STEPLINE then
		-- compact packet, no split
		local stepnum,linenum,linestring = data:match("(.-):(.-):(.*)")
		packet.stepnum=tonumber(stepnum)
		packet.linenum=tonumber(linenum)
		packet.linestring=linestring

	elseif packet.type==PACKETTYPE_SLAVEREQUEST then
		self:SplitXXIntoPacket(packet,data)
		packet.guide = packet.GU

	end
	--print("Packet unpacked:")
	--DevTools_Dump(packet)
end

function Sync:HandleReceivedPacket(packet)
	if packet.type~="nonexistent_future_packet"	and not self:IsEnabled() then return end -- ignore everything else when not in Sync mood
	if packet.type==PACKETTYPE_GUIDESTATUS then
		self:Debug("Player %s is on guide %s step %d which is %s",
			packet.sender,packet.guide,packet.stepnum,packet.is_complete and "complete" or "incomplete")
		self.PartyStatus[packet.sender]=packet
		self:OnPartyStatusChanged()

	elseif packet.type==PACKETTYPE_STEPDATA then
		self:Debug("Player %s sends step %d data (%d goals needed)", packet.sender,packet.stepnum,packet.linecount)
		packet.lines={}
		self.StepDataBuffer = {}
		self.StepDataBuffer.steps = self.StepDataBuffer.steps or {}
		self.StepDataBuffer.steps[packet.stepnum] = packet
	
	elseif packet.type==PACKETTYPE_STEPSTICKY then
		self:Debug("Player %s sends sticky step %d data (%d goals needed)", packet.sender,packet.stepnum,packet.linecount)
		packet.lines={}
		packet.sticky=true
		self.StepDataBuffer.steps[packet.stepnum] = packet
	
	elseif packet.type==PACKETTYPE_STEPLINE then
		self:Debug("Player %s sends step %d line %d", packet.sender,packet.stepnum,packet.linenum)
		local SDB = self.StepDataBuffer
		if not SDB or not SDB.steps then self:Debug("WHAT!? No step data sent so far?") return end
		local stepbuffer = SDB.steps[packet.stepnum]
		if not stepbuffer then self:Debug("WHAT!? Line for step %d unexpected!",self.stepnum) return end
		if stepbuffer.lines[packet.linenum] then self:Debug("Step %d line %d sent twice!?",packet.stepnum,packet.linenum) return end
		stepbuffer.lines[packet.linenum]=packet.linestring

	elseif packet.type==PACKETTYPE_STEPEND then
		-- reassemble guide

		if not self:IsSlave() then
			self.StepDataBuffer = nil
			self:Debug("I'm not a slave, I don't care about step data.")
			return
		end

		local SDB = self.StepDataBuffer
		if not SDB or not SDB.steps then self:Debug("WHAT!? No step data sent before END?") return end

		-- verify if all lines are present
		local allOK=true
		for i,step in pairs(SDB.steps) do
			for li=1,step.linecount do
				if not step.lines[li] then allOK=false break end
			end
			if not allOK then break end
		end
		if not allOK then ZGV:Print("Incomplete data received!") end

		self:Debug("COMPLETE STEP DATA RECEIVED!")

		local stepnums_in_order = {}
		for i,step in pairs(SDB.steps) do table.insert(stepnums_in_order,i) end
		table.sort(stepnums_in_order)
		local mainstep = SDB.steps[stepnums_in_order[1]]

		local guidesource=""

		for i=1,mainstep.stepnum-1 do guidesource = guidesource .. "step\n'\n" end  -- this is so lame

		-- stickystart lines
		for _,step in pairs(SDB.steps) do
			if step.sticky then guidesource = guidesource .. "stickystart "..step.label.."\n" end
		end

		-- steps proper
		for _,stepnum in ipairs(stepnums_in_order) do
			local step = SDB.steps[stepnum]
			guidesource = guidesource .. table.concat(SDB.steps[stepnum].lines,"\n") .. "\nshared_origin "..stepnum.."\n"
		end

		self.SharedGuideSource = guidesource
		--if Spoo then Spoo(self.StepDataBuffer) end

		self.SharedGuide = ZGV.GuideProto:New("SHARED\\"..mainstep.guide,{shared=true,singlestep=mainstep.stepnum},guidesource)
		self.SharedGuide:Parse(true)

		local tab, existed = ZGV.Tabs:GetSpecialTabFromPool("shared")
		if not existed then tab:SetAsCurrent() end --force switch to shared tab if it was created
		if tab.isActive then ZGV:SetGuide(self.SharedGuide) end -- send shared guide content if shared tab is active
		ZGV:UpdateFrame()

		self.StepDataBuffer=nil
		self:Debug("... and consumed.")

	elseif packet.type==PACKETTYPE_STATUSREQUEST then
		self:Debug("Status requested, announcing.")
		self:AnnounceStatus()

	elseif packet.type==PACKETTYPE_STEPREQUEST then
		if self:IsMaster() then
			self:Debug("Step requested, I'm the master, announcing.")
			self:BroadcastStepContents()
		else
			self:Debug("Step requested, but I'm not the master.")
		end

	elseif packet.type==PACKETTYPE_SHAREMODE then
		self.PartyStatus[packet.sender] = self.PartyStatus[packet.sender] or {}
		self.PartyStatus.sharemode = packet.sharemode

	elseif packet.type==PACKETTYPE_SLAVEREQUEST then
		if not ZGV.db.profile.share_enabled then return end
		if ZGV.db.profile.share_masterslave==2 then return end  -- already a slave
		self:ShowSlaveConfirmation(packet.sender,packet.guide)
	end
end

function Sync:FakePartyStatus(name,step_num,step_complete,goalstring)
	if name=="off" then self.fake_party=nil self.PartyStatus=nil self:ResetPartyStatus() return end
	local status = {guide=ZGV.CurrentGuide.title,stepnum=step_num,is_complete=(step_complete==1 or step_complete==true)}
	grab_goals(goalstring,status)
	self.PartyStatus[name]=status
	self.fake_party=true
	self:OnPartyStatusChanged()
end

function Sync:FakePartyGenerator()
	local mode=ZGV.db.profile.share_fakeparty
	if mode==0 then
		self:FakePartyStatus("off")
	elseif mode==1 then
		self:FakePartyStatus("off")
		self:FakePartyStatus("Alice",ZGV.CurrentStepNum,1, "c,c,c,c,c")
		self:FakePartyStatus("Bob",ZGV.CurrentStepNum,0, "1/2,0/1,1/2,0/1,1/3")
	elseif mode==2 then
		self:FakePartyStatus("off")
		self:FakePartyStatus("Alice",ZGV.CurrentStepNum,1, "c,c,c,c,c")
		self:FakePartyStatus("Bob",ZGV.CurrentStepNum,1, "c,c,c,c,c")
	elseif mode==3 then
		local packet = ZGV.Sync:CreatePacket_GuideStatus()
		local step=packet:match("##ST=([^#]+)")
		if not step then self:Debug("Bad step data packet!") return end
		local num,done,goalstring=step:match("(.*),(.*);(.*)")

		self:FakePartyStatus("off")
		self:FakePartyStatus("Badmotherfuk",tonumber(num),tonumber(done), goalstring)
		self:FakePartyStatus("Ipwnjoonubzz",tonumber(num),tonumber(done), goalstring)
		self:FakePartyStatus("Omegazordlol",tonumber(num),tonumber(done), goalstring)
		self:FakePartyStatus("Wwerywwydenm",tonumber(num),tonumber(done), goalstring)
	elseif mode==4 then
		local function randomstep()
			local g={}
			local alldone=true
			for i,goal in ipairs(ZGV.CurrentStep.goals) do
				if not goal:IsCompleteable() then
					tinsert(g,"-")
				elseif random(0,3)==0 then
					tinsert(g,"i")
				else
					local count = goal.count or 1
					local done=random(0,count)
					if done==count then tinsert(g,"c") else tinsert(g,done.."/"..count) alldone=false end
				end
			end
			return alldone and 1 or 0,table.concat(g,",")
		end
		self:FakePartyStatus("Alice",ZGV.CurrentStepNum,randomstep())
		self:FakePartyStatus("Bob",ZGV.CurrentStepNum,randomstep())
		self:FakePartyStatus("Charlie",ZGV.CurrentStepNum,randomstep())
	elseif mode==5 then
		local function currentstep()
			local g={}
			for i,goal in ipairs(ZGV.CurrentStep.goals) do
				local complete,possible,done,needed = goal:IsComplete()
				if not goal:IsCompleteable() then tinsert(g,"-")
				elseif complete then tinsert(g,"c")
				elseif possible then tinsert(g,done.."/"..needed)
				else tinsert(g,"i") end
			end
			return ZGV.CurrentStep:IsComplete() and 1 or 0,table.concat(g,",")
		end
		self:FakePartyStatus("Myself",ZGV.CurrentStepNum,currentstep())
	end
end

local dummytable={}
function Sync:OnPartyStatusChanged()
	local s="Party status:\n"
	for name,status in pairs(self.PartyStatus) do
		local goals=""
		for gi,gs in ipairs(status.goals or dummytable) do
			if #goals>0 then goals=goals.."," end
			goals=goals..(gs.complete and "c" or gs.done and ("%d/%d"):format(gs.done,gs.needed) or gs.completable and "undone?" or "-")
		end
		s=s..("- %s: step %d, %s, goals:%s\n"):format(name,status.stepnum,status.is_complete and "COMPLETE" or "incomplete",goals)
	end
	self:Debug(s)
	ZGV:UpdateFrame()
	ZGV:TryToCompleteStep()
end

function Sync:IsClearToProceed(stepnum)
	if not stepnum then stepnum=ZGV.CurrentStepNum end
	if not self:IsEnabled() then return true end
	if not self.PartyStatus or not next(self.PartyStatus) then return true end
	for name,status in pairs(self.PartyStatus) do
		if (status.stepnum < stepnum) or (status.stepnum==stepnum and not status.is_complete) then
			return false
		end
	end
	return true
end

local statuscolors = { [0]="ffff0000", [1]="ff00ff00", [2]="ff888888" }
local statuscolors2 = { [0]="ffff8888", [1]="ff00ff00", [2]="ff888888" }
local statustext = { [0]="incomplete", [1]="complete", [2]="impossible" }
local statustext2 = { [0]="[ ]", [1]="[X]", [2]="[?]" }
--[[
	unicode chars available in font:
	℅ℓ№™Ω℮⅛⅜⅝⅞∂∆∏∑−√∞∫≈≠≤≥
]]
function Sync:GetStepGoalPartyStatusText(stepnum,goalnum)
	if not (self:IsMaster() or self:IsSlave()) or not self.PartyStatus then
		return
	end
	local s=""
	local on_step=0
	local any_incomplete=false
	local partysort={}
	if IsInGroup(LE_PARTY_CATEGORY_HOME) --[[really]] then
		for i=1,GetNumGroupMembers()-1 do table.insert(partysort,(UnitName("party"..i))) end
	else --[[fake]]
		for k,v in ZGV.OrderedPairs(self.PartyStatus) do table.insert(partysort,k) end
	end
	for i,name in ipairs(partysort) do repeat
		local status = self.PartyStatus[name]
		if not status then break end --continue
		if not (status.guide==ZGV.CurrentGuide.title or status.guide:find("SHARED\\",1,true)) then break end

		local step
		if status.stepnum==stepnum then
			step=status
		elseif status.stickies then
			for i,st in ipairs(status.stickies) do
				if st.stepnum==stepnum then
					step=st
					break
				end
			end
		end
		if not step then break end -- continue

		if on_step>0 then s=s..", " end
		on_step=on_step+1
		local color,display
		local goal=status.goals[goalnum]
		if ZGV.db.profile.share_partydisplaystyle==1 then
			if not goal then color=2
			elseif goal.complete then color=1
			elseif goal.needed then
				if goal.done==0 and goal.needed==1 then color=0 -- incomplete 0/1
				elseif goal.done==0 and goal.needed==0 then color=2 -- incomplete 0/0 (impossible?)
				else color=0  -- incomplete 1/3
				end
			else color=2
			end
			s=s..("|c%s%s|r"):format(statuscolors2[color] or "ffff00ff",name)
		elseif ZGV.db.profile.share_partydisplaystyle==2 then
			if not goal then color=2
			elseif goal.complete then color=1
			elseif goal.needed then
				if goal.done==0 and goal.needed==1 then color=0 -- incomplete 0/1
				elseif goal.done==0 and goal.needed==0 then color=2 -- incomplete 0/0 (impossible?)
				else color=0  -- incomplete 1/3
				end
			else color=2
			end
			s=s..("%s (%s)"):format(name,statustext[color] or "unknown")
		elseif ZGV.db.profile.share_partydisplaystyle==3 then
			if not goal then color="888888" display="[-]"
			elseif goal.complete then color="88ff88" display="[√]"
			elseif goal.done then
				if goal.done==0 and goal.needed==1 then color="ff8888" display="[ ]" -- figure space: U+2007
				elseif goal.done==0 and goal.needed==0 then color="ff8888" display="[ ]" -- figure space: U+2007
				else color="ff8888" display=("[%d/%d]"):format(goal.done,goal.needed)
				end
			else
				color="888888" display="[?]"
			end
			s=s..("%s |cff%s%s|r"):format(name,color,display)
		elseif ZGV.db.profile.share_partydisplaystyle==4 then
			if not goal then color="888888" display=" [?]"
			elseif goal.complete then color="88ff88" display=""
			elseif goal.needed then
				if goal.done==0 and goal.needed==1 then color="ff8888" display="" -- incomplete 0/1
				elseif goal.done==0 and goal.needed==0 then color="ff8888" display="" -- incomplete 0/0 (impossible?)
				else color="ff8888" display=(" [%d/%d]"):format(goal.done,goal.needed) -- incomplete 1/3
				end
			else
				color="888888" display=" [-]"
			end
			s=s..("|cff%s%s%s|r"):format(color,name,display)
		end
		if status.goals[goalnum]~=1 then any_incomplete=true end
	until true end

	if on_step>0 then
		if ZGV.db.profile.share_partydisplaystyle==1 then return "Party: "..s,nil
		elseif ZGV.db.profile.share_partydisplaystyle>=2 then return s,statuscolors[any_incomplete and 0 or 1]
		end
	end
end

local ahead,behind = {},{}
function Sync:GetAheadBehind()
	if not ZGV.CurrentStepNum then return end
	if self.PartyStatus and next(self.PartyStatus) then
		table.wipe(ahead)
		table.wipe(behind)
		for name,status in pairs(self.PartyStatus) do
			if status.guide and (status.guide==ZGV.CurrentGuide.title or status.guide:find("SHARED\\",1,true)) then
				if not status.stepnum or status.stepnum==0 then
					-- ignore
				elseif status.stepnum<ZGV.CurrentStepNum then
					--table.insert(behind,"|cffff0000"..name.."|r (-"..(ZGV.CurrentStepNum-status.stepnum)..")")
					if ZGV.db.profile.share_partydisplaystyle<=3 then
						table.insert(behind,name.." |cffff8888(-"..(ZGV.CurrentStepNum-status.stepnum)..")|r")
					elseif ZGV.db.profile.share_partydisplaystyle==4 then
						table.insert(behind,"|cffff8888"..name..": Behind ("..(ZGV.CurrentStepNum-status.stepnum)..")|r")
					end
				elseif status.stepnum>ZGV.CurrentStepNum then
					--table.insert(ahead, "|cff00ff00"..name.."|r (+"..(status.stepnum-ZGV.CurrentStepNum)..")")
					if ZGV.db.profile.share_partydisplaystyle<=3 then
						table.insert(ahead, name.." |cff88ff88(+"..(status.stepnum-ZGV.CurrentStepNum)..")|r")
					elseif ZGV.db.profile.share_partydisplaystyle==4 then
						table.insert(behind,"|cff88ff88"..name..": Ahead ("..(status.stepnum-ZGV.CurrentStepNum)..")|r")
					end
				end
			end
		end
		if #ahead>0 or #behind>0 then
			local s=""
			if ZGV.db.profile.share_partydisplaystyle<=3 then
				if #ahead>0 then s="Ahead: "..table.concat(ahead,", ") end
				if #behind>0 then s=s..(#s>0 and "; " or "").."Behind: "..table.concat(behind,", ") end
			elseif ZGV.db.profile.share_partydisplaystyle==4 then
				if #ahead>0 then s=table.concat(ahead,", ") end
				if #behind>0 then s=s..(#s>0 and "; " or "")..table.concat(behind,", ") end
			end
			return s
		end
	end
end

function Sync:IsInGroup()
	return IsInGroup(LE_PARTY_CATEGORY_HOME) or self.fake_party
end

function Sync:AnnounceStatus()
	if self:IsInGroup() then
		self:Send(self:CreatePacket_GuideStatus())
		self:Debug("Announcing status.")
	end
	if self.fake_party then ZGV:ScheduleTimer(function() self:FakePartyGenerator() end,1.0) end
end

function Sync:BroadcastStepContents()
	self:Send(self:CreatePackets_StepData())
	self:Debug("Announcing step data.")
end

function Sync:Init()
	if not C_ChatInfo.IsAddonMessagePrefixRegistered(PREFIX) then
		C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)
		self.rcvframe = ZGV.ChainCall(CreateFrame("Frame"))
			:RegisterEvent("CHAT_MSG_ADDON")
			:RegisterEvent("GROUP_ROSTER_UPDATE")
			:SetScript("OnEvent", function(frame,event,...)
				if event=="CHAT_MSG_ADDON" then
					self:OnChatReceived(...)
				elseif event=="GROUP_ROSTER_UPDATE" then
					self:ResetPartyStatus()
					if self:IsInGroup() then
						if (self:IsMaster() or self:IsSlave()) then
							self:AnnounceStatus()
							self:RequestPartyStatus()
						end
						if self:IsMaster() then
							self:BroadcastStepContents()
							self:RequestSlaveMode() -- For new members. Existing slaves should ignore this.
						end
					end
				end
			end)
			.__END
	end
	ZGV:AddMessageHandler("ZGV_GOAL_COMPLETED",function(_,_,step,goal)
		if self:IsMaster() or self:IsSlave() then
			self:Debug("GOAL_COMPLETED: %d %d",step,goal)
			self:AnnounceStatus()
		end
	end)
	ZGV:AddMessageHandler("ZGV_GOAL_UNCOMPLETED",function(_,_,step,goal)
		if self:IsMaster() or self:IsSlave() then
			self:Debug("GOAL_UNCOMPLETED: %d %d",step,goal)
			self:AnnounceStatus()
		end
	end)
	ZGV:AddMessageHandler("ZGV_STEP_CHANGED",function(_,_,step)
		if self:IsMaster() or self:IsSlave() then
			if ZGV.db.profile.share_fakeparty>0 then
				ZGV:ScheduleTimer(function() self:FakePartyGenerator() end,1.0)
			end
			self:AnnounceStatus()
			if self:IsMaster() and self:IsInGroup() then
				self:BroadcastStepContents()
			end
		end
	end)
	ZGV:AddMessageHandler("ZGV_GOAL_PROGRESS",function(_,_,step,goal)
		if self:IsMaster() or self:IsSlave() then
			self:Debug("GOAL_PROGRESS: %d %d",step,goal)
			self:AnnounceStatus()
		end
	end)
	self:UpdateButtonColor()
	self:Activate()
end

function Sync:Activate()
	self:AnnounceStatus()
	self:ResetPartyStatus()
	self:RequestPartyStatus()
	if self:IsSlave() then self:RequestStepContents() end
	ZGV.Sync:UpdateButtonColor()
end

function Sync:UpdateButtonColor()
	if not ZygorGuidesViewerFrame_Border_Guides_GuideShareButton then return end
	local r,g,b,a
	if self:IsInGroup() then
		if self:IsSlave() then
			r,g,b,a = 0,1,0,1
		elseif self:IsMaster() then
			r,g,b,a = 0,1,0,1
		else
			r,g,b,a = 1,1,1,1
		end
	--[[
	elseif not self:IsInGroup() then
		r,g,b,a = 0.3,0.3,0.3,1
	elseif self:IsEnabled() then
		r,g,b,a = 1,1,1,1
	else
		r,g,b,a = 0.6,0.6,0.6,1
	end
	--]]
	else
		r,g,b,a = 1,1,1,1
	end
	ZygorGuidesViewerFrame_Border_Guides_GuideShareButton:GetNormalTexture():SetVertexColor(r,g,b,a)
	ZygorGuidesViewerFrame_Border_Guides_GuideShareButton:GetHighlightTexture():SetVertexColor(r,g,b,a)
	ZygorGuidesViewerFrame_Border_Guides_GuideShareButton:GetPushedTexture():SetVertexColor(r,g,b,a)
end


function Sync:ActivateAsMaster()
	ZGV:SetOption("Share","share_enabled on")
	ZGV:SetOption("Share","share_masterslave 1")
	self:RequestSlaveMode()
	ZGV:RefreshOptions()
end

function Sync:ActivateAsMasterWithConfirmation()
	if ZGV.PopupHandler:IsInNC("ZygorSyncInitiate") then return end

	if not self:IsInGroup() then
		local popup = ZGV.PopupHandler.popups['GenericPopup']
		popup.acceptbutton:SetText(OKAY)
		popup.acceptbutton:Show()
		popup.acceptbutton:ClearAllPoints()
		popup.acceptbutton:SetPoint("BOTTOM",0,10)
		popup.declinebutton:Hide()
		popup.OnAccept=function() end
		popup:SetText("You're not in a party.")
		popup:Show()
		return
	end

	if ZGV.db.profile.sync_dontconfirm then return self:ActivateAsMaster() end
	
	if not self.InitiateConfirmPopup then
		self.InitiateConfirmPopup = ZGV.PopupHandler:NewPopup("ZygorSyncInitiate","default")

		self.InitiateConfirmPopup.text3checkbox:SetText("Don't warn me again.")
		self.InitiateConfirmPopup.text3checkbox:Toggle(false)
		self.InitiateConfirmPopup.text3checkbox:SetPoint("BOTTOMLEFT",20,40)
		self.InitiateConfirmPopup.text3checkbox:Show()
		self.InitiateConfirmPopup.beta:Show()

		self.InitiateConfirmPopup.acceptbutton:SetText(ACCEPT)
		self.InitiateConfirmPopup.declinebutton:SetText(CANCEL)

		-- text,title,tooltipText,priority,poptime,removetime,quiet = returnMinimizeSettings()

		self.InitiateConfirmPopup.OnAccept = function(dialog)
			if dialog.text3checkbox:IsChecked() then
				ZGV.db.profile.sync_dontconfirm = true
			end
			ZygorGuidesViewerFrame_Border_Guides_GuideShareButton:GetNormalTexture():SetVertexColor(0,1,0,1)
			ZygorGuidesViewerFrame_Border_Guides_GuideShareButton:GetHighlightTexture():SetVertexColor(0,1,0,1)
			ZygorGuidesViewerFrame_Border_Guides_GuideShareButton:GetPushedTexture():SetVertexColor(0,1,0,1)
			Sync:ActivateAsMaster()
		end

		self.InitiateConfirmPopup.AdjustSize = function(dialog)
			dialog:SetHeight(180)
		end

	end

	self.InitiateConfirmPopup:SetText("Do you want to start sharing the guide:|n|n|cffffee88"..ZGV.CurrentGuide.title_short.."|r|n|nwith your party?|n|nNote: they have to be running the Zygor Guides Viewer addon.")

	self.InitiateConfirmPopup:Show()
end

function Sync:ShowSlaveConfirmation(sender,guide)
	if not self.SlaveConfirmPopup then
		self.SlaveConfirmPopup = ZGV.PopupHandler:NewPopup("ZygorSyncSlave","default")

		self.SlaveConfirmPopup.acceptbutton:SetText(ACCEPT)
		self.SlaveConfirmPopup.declinebutton:SetText(DECLINE)
		self.SlaveConfirmPopup.beta:Show()

		-- text,title,tooltipText,priority,poptime,removetime,quiet = returnMinimizeSettings()

		self.SlaveConfirmPopup.OnAccept = function(self)
			ZGV:SetOption("Share","share_masterslave 2")
			ZGV:RefreshOptions()
		end
	end

	self.SlaveConfirmPopup:SetText(ZGV.L["share_invite_received"]:format(sender,guide))

	self.SlaveConfirmPopup:Show()
end

function Sync:RequestStepContents()
	self:Send(self:CreatePacket_StepRequest())
end

function Sync:RequestPartyStatus()
	self:Send(self:CreatePacket_StatusRequest())
end

function Sync:RequestSlaveMode()
	self:Send(self:CreatePacket_SlaveRequest())
end

-- clear non-party members from PartyStatus
function Sync:ResetPartyStatus()
	if not IsInGroup(LE_PARTY_CATEGORY_HOME) then  self.PartyStatus = {}  return  end
	self.PartyStatus = self.PartyStatus or {}
	local newps={}
	if IsInGroup(LE_PARTY_CATEGORY_HOME) then
		local n = GetNumGroupMembers()
		for i=1,n-1 do
			local unit = "party"..i
			local name=UnitName(unit)
			if UnitExists(unit) then
				newps[name]=self.PartyStatus[name]
			end
		end
	end
	self.PartyStatus=newps
end

function Sync:GetStepSource(stepnum)
	local t1=debugprofilestop()
	local sn=0
	local li=0
	local rawstep={}
	local in_step
	local linematch
	for line in ZGV.CurrentGuide.rawdata:gmatch("(.-)\n") do
		li=li+1
		linematch=nil
		if line:find("^%s*step") then
			sn=sn+1
			in_step = sn==stepnum
			if #rawstep>0 and not in_step --[[anymore]] then  break  end
			linematch="step"
		elseif line:find("^%s*stickyst[artop]*")
		    or line:find("#include",1,true)
		    or line:find("leechstep",1,true) then
			in_step=false
		end
		if in_step then
			table.insert(rawstep,line)
			if linematch=="step" and ZGV.CurrentGuide.steps[stepnum].map then table.insert(rawstep,"map "..ZGV.CurrentGuide.steps[stepnum].map) end
		end
	end
	local t2=debugprofilestop()
	self:Debug("Extracting current step source took %.2fms",t2-t1)
	return rawstep
end

function Sync:IsSlave()
	return self:IsEnabled() and ZGV.db.profile.share_masterslave==2
end

function Sync:IsMaster()
	return self:IsEnabled() and ZGV.db.profile.share_masterslave==1
end

function Sync:IsEnabled()
	return ZGV.db.profile.share_enabled and self:IsInGroup()
end

function Sync:Send(message,...)
	if not message then return end
	self:Debug("|cffffaa00SND|r: %s",message)
	local result = C_ChatInfo.SendAddonMessage(PREFIX,message,"PARTY")
	if ... then return self:Send(...) end
end

function Sync:SendSelf(message,...)
	if not message then return end
	self:Debug("|cffffaa00SND (self)|r: %s",message)
	local result = C_ChatInfo.SendAddonMessage(PREFIX,message,"WHISPER",UnitName("player"))
	if ... then return self:SendSelf(...) end
end

function Sync:Debug(...)
	ZGV:Debug("&sync "..(...),select(2,...))
end

tinsert(ZGV.startups,{"Sync startup",function(self)
	Sync:Init()
end})
