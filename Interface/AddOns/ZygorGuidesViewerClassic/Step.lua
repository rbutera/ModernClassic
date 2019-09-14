local Step = {}
local ZGV = ZygorGuidesViewer
if not ZGV then return end
local L = ZGV.L
local LM = ZGV.LM

local table,string,tonumber,ipairs,pairs,setmetatable,min,max = table,string,tonumber,ipairs,pairs,setmetatable,min,max

ZGV.StepProto = Step
ZGV.StepProto_mt = { __index=Step }

function Step:New(data)
	setmetatable(data,ZGV.StepProto_mt)
	return data
end

---
-- @return complete, possible
function Step:IsComplete()
	--self:Debug("Step complete check")
	--if not self.CurrentStep then return false end
	--if not self.CurrentStep.goals then return false end
	if not self:AreRequirementsMet() then return true end

	local completeable = false
	local complete = true
	local steppossible = false

	local allhidden = true

	local alloptional = true

	-- 'or' logic: one or-positive goal marks all or-positive goals as done. Will collect completed or's in here.
	--local orlist = {}
	local orneeded = 0
	local orcount = 0
	local orcomplete = false

	-- prepare statuseses
	for i,goal in ipairs(self.goals) do goal:UpdateStatus() end


	-- do LOGIC! omg.
	if self.logic_fun then
		self.logic_env:_Update()
		return self.logic_fun()
	end


	-- one click to complete them all
	for i,goal in ipairs(self.goals) do
		if goal.action=="confirm" and goal.status=="complete" then return true,true end
	end


	-- check for ORs!
	local status
	for i,goal in ipairs(self.goals) do
		status = goal.status
		if status~="hidden" then
			if goal.override and status=="complete" then return true,true end
			if goal.orlogic then
				--orlist[goal]=true
				orneeded = goal.orlogic
				if status=="complete" then
					-- count all completed or's
					orcount = orcount + 1
				end
			end
		end
	end
	orcomplete = (orneeded>0 and orcount>=orneeded)

	-- all hidden? die.
	for i,goal in ipairs(self.goals) do
		if (goal.status~="hidden" and goal.action) and not goal.temporary then allhidden=false end
	end
	if allhidden then return true,true end


	for i,goal in ipairs(self.goals) do
		status = goal.status
		if status=="complete" or status=="incomplete" or status=="warning" then
			completeable = true
			local done,possible
			if goal.orlogic --[[and orlist[goal] --]] and orcomplete then
				status="complete" -- don't bother to check, force
			end
			if status~="complete" and not goal.optional  then  complete = false  end
			if not goal.optional then alloptional = false end
			if status=="incomplete" or status=="warning" --[[possible and not done--]] then  steppossible = true  end
		end
	end
	return completeable and complete and not alloptional, steppossible
end

--[[
function Step:NeedsUpdating()
	if not self.goalsneedupdating then self.goalsneedupdating={} end
	local needs=false
	for i,goal in ipairs(self.goals) do
		local needup = self.goalsneedupdating[goal]
		if not needup then self.goalsneedupdating[goal]={} needup = self.goalsneedupdating[goal] end
		if goal:IsCompleteable() then
			local done,possible = goal:IsComplete()
			local text = goal:GetText(possible)
			if needup.done~=done or needup.possible~=possible or needup.text~=text then
				needs=true
				print(goal.num.." needs updating")
			end
			needup.done=done
			needup.possible=possible
			needup.text=text
		end
	end
	return needs
end
--]]

-- Check race/class requirement and condition_visible
function Step:AreRequirementsMet(case)
	if self.beta and not ZGV.BETA then return false,"beta disabled" end
	if self.requirement then
		local raceclass=false
		for i,v in pairs(self.requirement) do if ZGV:RaceClassMatch(v) then raceclass=true break end end
		if not raceclass then return false,"raceclass mismatch" end
	end

	if self.condition_visible then
		ZGV.Parser.ConditionEnv:_SetLocal(self.parentGuide,self,self.goals[1])
		if not self.condition_visible() then return false,"condition fail" end
	end

	if case=="focus" and self.is_sticky_only then return false,"sticky only" end

	return true
end

--- Run before the step is displayed. May be called periodically to update.
function Step:PrepareCompletion(full)
	if full then self.prepared=nil end
	if self.prepared then return end

	-- repurposed: autoadjustment of get/kill/goal
	ZGV:Debug("&step_setup Preparing goals...")
	for i,goal in ipairs(self.goals) do
		goal:Prepare(true)
	end
	ZGV:Debug("&step_setup Goals prepared.")


	-- REMOVE non-matching goals
	--[[
	local i=1
	while i<#self.goals do
		print(i)
		if not self.goals[i]:IsFitting() then tremove(self.goals,i) else i=i+1 end
	end
	--]]

	if self.logic then
		self.logic_env = {
			_G = _G,
			step = self,
			goalcomplete = {},

			_Update = function(env)
				env.goalcomplete={}
				for i,goal in ipairs(env.step.goals) do
					env.goalcomplete[i]=goal:IsComplete()
				end
			end,
		}
		
		local code = step.logic:gsub("([0-9]+)","goalcomplete[%1]")
		local fun,err = loadstring("return not not "..code)

		if fun then
			setfenv(fun,self.logic_env)
			self.logic_fun = fun
		else
			ZGV:Print("Error in step logic: " .. self.logic .. "  error: " .. err)
		end
	end

	self.prepared=true

	ZGV:Debug("&step_setup Step "..self.num.." prepared.")
end

---  This is called with every step frame update, so around 1/sec or more often, depending on (also) its own returns.
-- @return changed,stilldirty
-- When this returns stilldirty, the next update is IMMEDIATE.
function Step:Translate()
	local changed=false
	local stilldirty=false
	local failure=false

	for i,goal in ipairs(self.goals) do
		if goal:NeedsTranslation() then
			if goal:AutoTranslate() then changed=true else stilldirty=true end
		end
		if goal.Lfail then  goal.L=nil  failure=true  end
	end

	if failure then return changed,false end  -- "we're as clean as we can get for now"

	if not self.L then
		if self.title then
			local name,id = nil --ZGV.Parser:ParseID(self.title)
			if id then
				local qt = ZGV.Localizers:GetQuestData(id)
				if qt then
					self.title=qt
					self.L = true
					changed=true
					--if ZGV.CurrentStep==self then ZGV:ShowWaypoints() end  -- refresh waypoint title, kinda overkill... ZGV.lua handles this.
				else
					stilldirty=true
				end
			else
				self.L = true
			end
		else
			self.L = true
		end
	end
			
	return changed,stilldirty
end


function Step:IsDynamic()
	for i,goal in ipairs(self.goals) do
		if goal:IsDynamic() then
			return true
		end
	end
	return false
end

--- Auxiliary steps are only used to lead to quest-related steps.
-- A step is auxiliary if it contains only non-quest-related goals.
function Step:IsAuxiliary()
	--if self.isauxiliary~=nil then return self.isauxiliary end
	for i,goal in ipairs(self.goals) do
		if not goal:IsAuxiliary() then
			self.isauxiliary=false
			return false
		end
	end
	--else...
	--self.isauxiliary=true
	return true
end

function Step:IsObsolete()
	do return false end
	--if self.isobsolete then return self.isobsolete end
	local oneobsolete=false
	for i,goal in ipairs(self.goals) do
		if goal.action == "confirm" and goal.always == true then return false end
		local obsolete = goal:IsObsolete()
		local complete,possible = goal:IsComplete()
		if obsolete then oneobsolete=true end
		if not (obsolete or goal:IsAuxiliary() or complete or (not possible and ZGV.db.profile.skipimpossible)) then return false end
	end
	if not oneobsolete then return false end
	--else...
	--self.isobsolete=true  -- once obsolete, forever obsolete
	return true
end

--- Checks if the step has any use - if not, it can be safely skipped as long as it's followed by other skippable steps up to a completed step.
-- @return true if the step is useful, false if not.
function Step:IsAuxiliarySkippable()
	local i=self.num
	local guide = self.parentGuide
	local travelfor=self.travelfor
	local count=0
	local step=self
	--ZGV:Debug("Testing auxiliary "..i)

	if guide.title:match("^Dungeon") then return false end  -- Dungeon guides are NOT aux-skippable. Ugly, I know, but easier.

	while step do
		--ZGV:Debug("auxiliary "..i.."?")
		if step:IsAuxiliary() or not step:AreRequirementsMet() then
			--ZGV:Debug("skipping")
			-- keep skipping
		else
			if step==self then
				--ZGV:Debug("ret false")
				return false
			else
				local complete,possible = step:IsComplete()
				local wouldskip = (ZGV.db.profile.skipobsolete and step:IsObsolete())
					or complete
					or (ZGV.db.profile.skipimpossible and not possible)
				--ZGV:Debug("wouldskip "..tostring(wouldskip))
				--ZGV:Debug("travelfor "..tostring(travelfor))
				if wouldskip and travelfor then
					-- wait for more skippage
				else
					return wouldskip
				end
			end
		end

		i=i+1  -- jump over fellow auxiliaries
		step=guide.steps[i]
		if not step then
			-- next is not loaded! stop looking there, temporarily.
			--[[
			guide = ZGV:GetGuideByTitle(guide.next)
			if guide then  i=1  step=guide.steps[i]  end
			--]]
		end

		-- Check for multiple-step-ranging travel steps.
		if travelfor then
			count=count+1
			-- If we passed <travelfor> steps already and still found nothing to do, we can be skipped.
			if count>travelfor then return true end
		end
	end
	return travelfor and count<=travelfor -- if we ran out of steps, then we can be skipped. Safety.
end


function Step:GetTitle()
	if self.title then return self.title end
	for i,goal in ipairs(self.goals) do
		if goal.title then return goal.title end
		if goal.quest then return goal.quest.title end
	end
end

function Step:GetWayTitle()
	--[[
	for i,goal in ipairs(self.goals) do
		if goal.title then return goal.title end
		if goal.npcid then return ZGV.Localizers:GetTranslatedNPC(goal.npcid) end
		if goal.quest then return goal.quest.title end
	end
	--]]
	if self.title then return self.title end
end

function Step:OnEnter()
	ZGV:Debug("&step_setup Step ".. self.num .." OnEnter")

	-- last call to tamper with the goals!
	-- remove temporaries
	local i=1
	while i<=#self.goals do
		local goal=self.goals[i]
		goal.sub_goto=nil
		goal.sub_talk=nil
		if goal.temporary then
			tremove(self.goals,i)
			i=i-1
		end
		i=i+1
	end
	self.needsreload = false

	if ZGV.autopause or ZGV.LastSkip<0 then
		local autoscripts
		for i,goal in ipairs(self.goals) do if goal.autoscript then autoscripts=true end end
		if autoscripts then
			local goal = 
				ZGV.GoalProto:New {
					num=#self.goals+1,
					action="text",
					--clickfun=function() ZGV:ReloadStep() end,
					text="(this step is automated)",
					parentStep=self,
					temporary=1
				}
			tinsert(self.goals,goal)
			self.needsreload = true
		end
	end

	for i,goal in ipairs(self.goals) do if goal.action=="fly" then
		if not goal.sub_goto then -- TODO how about when continents differ?
			local g

			g = ZGV.GoalProto:New {
				action="goto",
				parentStep=self,
				temporary=1
			}
			goal.sub_goto=g
			tinsert(self.goals,i,g)

			g = ZGV.GoalProto:New {
				action="talk",
				parentStep=self,
				temporary=1
			}
			goal.sub_talk=g
			tinsert(self.goals,i+1,g)

			ZGV:Debug("fly expanded")
		end
	end end
	-- end tampering

	-- renumber after any additional goals being added... this is fugly anyway and should die
	for i=1,#self.goals do self.goals[i].num=i end


	-- all-passives get a "click" action.
	--[[
	local allpassive = true
	if self.needsreload then allpassive=false end -- these
	for i,goal in ipairs(self.goals) do
		if not goal.temporary and goal:GetStatus()~="passive" and goal:GetStatus()~="hidden" then allpassive=nil end
	end
	if allpassive and not (self==self.parentGuide.steps[#self.parentGuide.steps]) then
		local goal = 
			ZGV.GoalProto:New {
				num=#self.goals+1,
				action="click",
				parentStep=self,
				temporary=1
			}
		tinsert(self.goals,goal)
	end
	--]]

	-- clear our macros
	if not InCombatLockdown() then
		ZGV:Debug("&step_setup Clearing macros")
		for i=1,99 do DeleteMacro("ZGVMacro"..i) end
	end

	ZGV:Debug("&step_setup Running goals' OnEnter")
	-- run autoscripts, set up macros, and whatnot
	for i,goal in ipairs(self.goals) do
		goal:OnEnter()
	end

	ZGV:Debug("&step_setup Step ".. self.num .." OnEnter ended")
end

function Step:GetNext()
	if self:AreRequirementsMet() or ZGV.db.profile.showwrongsteps then  -- do NOT use jumps in steps that are wrong for some reason.
		for i,goal in ipairs(self.goals) do
			if goal.next and goal:IsVisible() and (not goal:IsCompleteable() or goal:IsComplete()) then
				ZGV:Debug("Step:GetNext: step %d goal %d \"%s\" says \"%s\"",self.num,i,goal:GetText(),tostring(goal.next))
				return goal.next
			end
		end
	end
	ZGV:Debug("Step:GetNext: step %d says %s so going with %s",self.num,tostring(self.next),self.next or "+1")
	return self.next or "+1"
end

-- Get a jump's destination step number.
-- @param jump Optional: provide an alternative jump label to test, instead of the internal.
-- @returns stepnum,guidetitle
function Step:GetJumpDestination(jump)
	if not jump then jump=self:GetNext() end
	assert(jump,"no jump!")
	if type(jump)=="number" or jump:match("^%d+$") then
		return tonumber(jump) -- 123
	else
		local sign=jump:sub(1,1)  if sign=="+" or sign=="-" then jump=jump:sub(2) end  -- we'll get back to the sign
		if jump:match("^%d+$") then
			-- NOW it's numeric! step number delta
			jump=tonumber(jump) or 0
			return self.num + jump * (sign=="-" and -1 or 1) -- "-7","+7"
		elseif jump:find("\\") then
			-- "folder\\guide::5"
			local guide,tag = jump:match("(.*)::(.*)")
			if not tag then guide=jump end
			
			guide = ZGV:SanitizeGuideTitle(guide)
			tag = tonumber(tag) or tag or 1

			return tag,guide
		else
			-- "label","+label","-label"

			local labs = self.parentGuide.steplabels and self.parentGuide.steplabels[jump]

			if not labs then return end

			local closest_back,closest_fore
			for i,num in ipairs(labs) do
				if num<self.num then closest_back=num end
				if num>self.num then closest_fore=num break end
			end
			if sign=="+" then
				ZGV:Debug("Step:GetJumpD: step %d jumping to \"%s\", fore = %d",self.num,jump,tostring(closest_fore))
				return closest_fore  -- may be nil, so what.
			elseif sign=="-" then
				ZGV:Debug("Step:GetJumpD: step %d jumping to \"%s\", back = %d",self.num,jump,tostring(closest_back))
				return closest_back  -- likewise.
			elseif not closest_fore or (closest_back and closest_fore and self.num-closest_back < closest_fore-self.num) then
				ZGV:Debug("Step:GetJumpD: step %d jumping to \"%s\", closest (back) = %d",self.num,jump,tostring(closest_back))
				return closest_back
			else
				ZGV:Debug("Step:GetJumpD: step %d jumping to \"%s\", closest (fore) = %d",self.num,jump,tostring(closest_fore))
				return closest_fore
			end
		end
	end
end

do	-- test GetJumpDestination
	-- steps: a,b,a,c,d,a
	local guide = { steplabels={a={1,3,6},b={2},c={4},d={5}}, steps={ {},{},{},{},{},{} } }
	for n,step in ipairs(guide.steps) do step.num=n step.parentGuide=guide setmetatable(step,ZGV.StepProto_mt) end
	assert(guide.steps[1]:GetJumpDestination("+2")==3)	--delta fore
	assert(guide.steps[3]:GetJumpDestination("-1")==2)	--delta back
	assert(guide.steps[3]:GetJumpDestination("5")==5)	--absolute
	assert(guide.steps[3]:GetJumpDestination("c")==4)	--unique
	assert(guide.steps[3]:GetJumpDestination("z")==nil)	--label fail
	assert(guide.steps[4]:GetJumpDestination("+a")==6)	--fore
	assert(guide.steps[4]:GetJumpDestination("+b")==nil)	--fore fail
	assert(guide.steps[4]:GetJumpDestination("-a")==3)	--back
	assert(guide.steps[3]:GetJumpDestination("-c")==nil)	--back fail
	assert(guide.steps[4]:GetJumpDestination("a")==3)	--closest, find back
	assert(guide.steps[5]:GetJumpDestination("a")==6)	--closest, find fore
end

-- Return next step, including 'next' tags.
-- returns a step and nothing more.
-- Only returns nil when there is NO next step.
function Step:GetNextStep(nextlabel)
	nextlabel = nextlabel or self:GetNext()  -- always something.

	-- special next tag
	local step,guide = self:GetJumpDestination(nextlabel)
	if not guide then
		-- normal next
		local stepobj = self.parentGuide:GetStep(step)
	-- step is not validated, validate now
		if not stepobj and nextlabel~="+1" then
			ZGV:Print("|cffff4400ERROR!|r Cannot jump from step |cffffff88"..self.num.."|r to label '|cffffff88"..tostring(nextlabel).."|r'. This is guide |cffffff88"..self.parentGuide.title_short.."|r. Please report this, providing a generated Bug Report.")
			ZGV:Print("Meanwhile, try to navigate to the next step manually, by holding |cff55ff00CTRL+ALT|r and skipping the step.")
			return self
		end
		return stepobj
	else
		local gu = ZGV:GetGuideByTitle(guide)
		if not gu then
			ZGV:Print("|cffff4400ERROR!|r Cannot jump from step |cffffff88"..self.num.."|r to guide '|cffffff88"..tostring(guide).."|r'. This is guide |cffffff88"..self.parentGuide.title_short.."|r. Please report this, providing a generated Bug Report.")
			ZGV:Print("Meanwhile, try to navigate to the next step manually, by holding |cff55ff00CTRL+ALT|r and skipping the step.")
			return self
		end

		--ZGV:Debug("&step GetNextStep: jumping to step |cffffaa00%s|r in |cffff00ee%s",step,guide)

		return nil,step,guide
		--gu:Parse(true)
		--return gu:GetStep(step), true,guide  -- "changed guides!"
	end

	--local prevnum=num
	-- whatever we have, it has to be inside the guide. Valid or not.
	--if prevnum~=num then ZGV:Print("Step adjusted! Tried "..prevnum..", settled for "..num) end

	-- ZGV:Debug("step:GetNextStep, current ".. self.num .." next ".. tostring(step.num))

end
Step.Find = Step.GetNextStep  -- alias

local visited_steps={}
local visited_path={}
ZGV.debug_VSTEPS=visited_steps
ZGV.debug_VPATH=visited_path

-- Only returns nil when there is NO next valid step.
-- Called from 
function Step:GetNextValidStep()
	local step=self
	local numskips=1
	local stepnum,guide
	repeat
		step, stepnum,guide = step:GetNextStep()
		numskips=numskips+1  assert(numskips<5000,"5000 skips and no valid next step found!")
	until not step or step:AreRequirementsMet() or ZGV.db.profile.showwrongsteps
	return step,stepnum,guide -- or nil if none.
end

function Step:GetNextCompletableStep()
	local step=self
	local numskips=1
	local stepcomplete,steppossible
	local stepnum,guide
	wipe(visited_steps)
	wipe(visited_path)
	visited_steps[step]=1
	repeat
		step, stepnum,guide = step:GetNextStep()
		--numskips=numskips+1  assert(numskips<2000,"2000 skips and no completable step found!")
		if step then
			assert(not visited_steps[step],"LOOPING! started in step ".. self.num..", detected in ".. step.num .." , see ZGV.debug_VPATH")
			stepcomplete,steppossible = step:IsComplete()

			visited_steps[step]=1
			tinsert(visited_path,step.num)
		end
	until not step or ((step:AreRequirementsMet() or ZGV.db.profile.showwrongsteps) and not stepcomplete and steppossible)
	return step,stepnum,guide
end

function Step:CheckVisitedGotos()
	for gi,goal in ipairs(self.goals) do
		if goal:IsVisible() then goal:CheckVisited() end
	end
end

--- Checks if the step is currently acting as a sticky, with another step focused.
function Step:IsCurrentlySticky()
	if not self.is_sticky then return false end  -- obviously.
	if not ZGV.CurrentStickies then return false end
	for k,v in ipairs(ZGV.CurrentStickies) do if v==self then return true end end
	return false
end

function Step:ShareToChat(target,sharesource,brand)
	if target=="PARTY" and not IsInGroup() then ZGV:Error(ERR_NOT_IN_GROUP) return end
	if target=="RAID" and not IsInRaid() then ZGV:Error(ERR_NOT_IN_RAID) return end
	local goals
	if sharesource=="rolegoals" then
		for i,g in ipairs(self.goals) do  if g.grouprole and g:IsVisible() then   goals=goals or {}  tinsert(goals,g)  end end
	end
	if not goals then return end
	if brand and not ZGV.step_share_onceflag then  ZGV.step_share_onceflag=true  SendChatMessage(L['goalshare_brand']:format(self.parentGuide.title_short,self.num),target) end
	for i,g in ipairs(goals) do
		SendChatMessage(g:GetTextForSharing("withtip"),target)
	end
end

function Step:ResetCurrentWaypoint()
	ZGV:Debug("|cffddaa88Step|r:|cffccff88ResetCurrentWaypoint|r")
	self.current_waypoint_goal_num = nil
	self:CycleWaypoint(1,true)
end

function Step:CycleWaypoint(delta,nocycle)
	delta=delta or 1
	
	-- -- "numberMappedGoals" removed from here. Not needed. There's a cycles check later anyway.
	local goal_num = self.current_waypoint_goal_num or (delta>0 and 0 or #self.goals+1)
	ZGV:Debug("|cffddaa88Step|r:|cff88ffffCycleWaypoint|r(|cffffffff%s|r) in step %d having %d goals; cycling (%s) from %d actually %d",(delta>0 and "forward" or "back"),self.num,#self.goals, nocycle and "one-way" or "around", tostring(self.current_waypoint_goal_num),goal_num)
	local goal
	local cycles=0
	local do_cycle=not nocycle
	local starting_goal_num = goal_num
	repeat
		goal_num = goal_num + delta

		-- do cycle, or not
		if do_cycle then
			if goal_num>#self.goals then goal_num=1
			elseif goal_num<1 then goal_num=#self.goals end
		else
			goal_num = min(max(goal_num,1),#self.goals)
		end
		
		if goal_num==starting_goal_num then ZGV:Debug("- Went full cycle or nowhere, aborting.") return end --full cycle or no change at all, abort
		
		goal=self.goals[goal_num]
		if not goal then ZGV:Debug("- Went out of goals!!!") return end

		cycles=cycles+1
		if cycles>50 then ZGV:Debug("- Cycling forever, aborting.") return end

	until goal and goal.x and not goal.force_noway and goal:IsVisible()

	ZGV:Debug("- Successfully cycling to %d",goal_num)

	return self:CycleWaypointTo(goal_num)
end

function Step:CycleWaypointTo(goalnum)
	if type(goalnum)=="table" and goalnum.parentStep then  self=goalnum.parentStep  goalnum=goalnum.num end  -- UGLY hack! never change self!!!! :(
	local goal = self.goals[goalnum]
	self.current_waypoint_goal_num=goalnum
	if goal and goal.x and not goal.force_noway and goal:IsVisible() then
		ZGV:Debug("|cffddaa88Step|r:|cff88ffccCycleWaypointTo|r(|cffffffff%d|r) ['%s'], way at [%.1f %.1f]",goal.num,goal:GetText(),goal.x*100,goal.y*100)
		ZGV:SendMessage("ZGV_STEP_WAYPOINT_CHANGED",self,self.current_waypoint_goal_num)
		ZGV:UpdateFrame(true)
		return goalnum,goal
	else
		self:CycleWaypoint(1,"nocycle")
	end
end

function Step:CycleWaypointFrom(goalnum)
	self.current_waypoint_goal_num = goalnum
	ZGV:Debug("|cffddaa88Step|r:|cff88ff88CycleWaypointFrom|r(|cffffffff%d|r)",goalnum)
	self:CycleWaypoint(1,"nocycle")
end
