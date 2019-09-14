local ZGV = ZygorGuidesViewer
if not ZGV then return end

local L = ZGV.L
local BZL,BZR = ZGV.BZL,ZGV.BZR

local tinsert=tinsert

ZGV.Waypoints = {}
local Waypoints = ZGV.Waypoints

--============================================= internal =============================================

local function onChangeZone()
	if not UnitIsDeadOrGhost("player") and (waypath and waypath.coords) or (waypath_poi and waypath_poi.coords) then
		ZGV:Debug("&waypoints Zone changed, setting to waypath")
		ZGV:ShowWaypoints()
	else
		ZGV:Debug("&waypoints Zone changed, no farm path here")
	end
end

local farmPathEvent=CreateFrame("Frame")
farmPathEvent:RegisterEvent("ZONE_CHANGED_NEW_AREA")
farmPathEvent:RegisterEvent("PLAYER_CONTROL_GAINED")
farmPathEvent:SetScript("OnEvent", onChangeZone)

function ZGV:ShowWaypoints(command)  
	local t1=debugprofilestop()  repeat
	
	if ZGV.Pointer.corpsearrow_shown then
		self:Debug("&waypoints Corpse arrow shown; bailing out of ShowWaypoints.")
		return
	end

	self:Debug("&waypoints &_PUSH ShowWaypoints called as '%s' by %s",tostring(command or "nil"),debugstack(3):match("(\\.- in function .-)\n"))

	self.Pointer:ClearWaypoints("way")
	self.Pointer:ClearSet("route")
	self.Pointer:ClearSet("farm")
	self.Pointer:ClearSet("path")

	-- clear: JUST CLEAR.
	if command=="clear" then
		ZGV:Debug("&waypoints ShowWaypoints: just clearing.")
		break
	end

	local step = ZGV.GetFocusedStep and ZGV:GetFocusedStep() or ZGV.CurrentStep
	if not step then ZGV:Debug("&waypoints No step.") break end


	---------------- NORMAL FUNCTION -------------

	--if goal then  ZGV:Debug("&waypoints Pointing to goal %d",goal.num)  end

	ZGV:Debug("&waypoints Pointing to step %d (%s), %d goals, waypath %s.",step.num,step.is_poi and "poi" or "guide",#step.goals,step.waypath and "present" or "absent")


	local arrowpoint,pathpoint,farmpoint


	-- SHOW FARM PATH.

	local waypath = step and step.waypath
	
	--[[  -- DISABLED temporarily. TODO!!!  Or not; one can now "use goto" in paths to import gotos.
		... or not. Needed to have gotos automatically converted after all.
		--]]
	
	if not waypath then  -- improvise waypath from gotos. If this succeeds, DON'T show goto waypoints separately.
		waypath = {coords={},loop=false,ants="straight",follow="none",markers="none",made_from_gotos=true }  --,markers="none",follow="none",inline_travel=true
		for gi,goal in ipairs(step.goals) do goal.waypoint_moved_to_waypath=nil end
		for gi,goal in ipairs(step.goals) do if goal.x then
			if goal:IsInlineTravel() and goal:IsVisible() then
				if gi>=(step.current_waypoint_goal_num or 0) then
					ZGV:Debug("&waypoints Waypath improv: Goal %d goto converted to waypath (inline travel)",gi)
					tinsert(waypath.coords,goal) -- all travel points leading up to destination
				end
				goal.waypoint_moved_to_waypath=true
			else
				ZGV:Debug("&waypoints Waypath improv: Goal %d goto converted to waypath (coords)",gi)
				tinsert(waypath.coords,goal) -- destination itself
				break
			end
		end end
		
		--[[
		if #waypath.coords<2 then
			ZGV:Debug("&waypoints Waypath improv: Only %d gotos, aborting.",#waypath.coords)
			waypath=nil 
			for gi,goal in ipairs(step.goals) do goal.waypoint_moved_to_waypath=nil end
		end
		--]]

		--step.waypath=waypath
	end

	if waypath then
		local pathtype = waypath.loop and "farm" or "path"
		ZGV:Debug("&waypoints Waypath present in step, showing %d points as '%s':",#waypath.coords,pathtype)
		local pointset = ZGV.Pointer:ShowSet(waypath,waypath.loop and "farm" or "path")
		--if not waypath.loop then  arrowpoint = pointset.points[1]  end  -- Pointer defaults to points[1] in GetNextInPath anyway.  Miiight not play nice with Travel, but this is a band-aid...
	end

	-- SHOW STEP WAYPOINTS.

	local pointed = false

	local points = {}  -- fill this with correct source material.

	if step.goals then
		if goal --[[ never true! --]] then
			--[[
				if not goal.force_noway then
					points={goal}
					ZGV.CurrentStep.current_waypoint_goal_num = goal.num
				end
			--]]
			--print("goal: "..goal:GetText())
		else
			local canhidetravel=false
			--if not self.db.profile.showinlinetravel then for i,goal in ipairs(step.goals) do if not goal:IsInlineTravel() then canhidetravel=true break end end end
			for i,goal in ipairs(step.goals) do
				if goal.x and goal:IsVisible() and not goal.force_noway and not (canhidetravel and goal:IsInlineTravel()) and not goal.waypoint_moved_to_waypath then
					if goal.parentStep.is_poi then
						goal.waypoint_icon = ZGV.Pointer.Icons.graydot
					end
					tinsert(points,goal)
				end
				if goal.ways then
					for j,way in ipairs(goal.ways) do
						tinsert(points,way)
					end
				end
			end
		end
	end

	-- if any points are present (that is: haven't been removed to waypath), show them as regular markers.
	if points and #points>0 then
		ZGV:Debug("&waypoints Showing %s: (#points=%d, waypath %s, Pointer.DestinationWaypoint=%s)", goal and "goal" or "step goals",  #points, waypath and "PRESENT" or "absent", tostring(ZGV.Pointer.DestinationWaypoint))
		arrowpoint,farmpoint = ZGV.Pointer.set_waypoints(points,35,30,"way")
	else
		ZGV:Debug("&waypoints No step points (left) to show.")
	end
	-- regardless of points and waypaths, try to point towards "current" goal.
	if (waypath or (points and #points>0)) and step.current_waypoint_goal_num then
		arrowpoint=ZGV.Pointer:GetWaypointByGoal(step.goals[step.current_waypoint_goal_num])
		ZGV:Debug("&waypoints Arrowpoint set to c_w_g_n, %d",step.current_waypoint_goal_num)
	end

	-- Waypoints are set.

	-- NOW, POINT THE ARROW / PLOT THE PATH.

	-- Wait. If player is dead, point there instead.
	if self.Pointer.corpsearrow or self.Pointer:IsCorpseArrowNeeded() then
		self:Debug("&waypoints ShowWaypoints: we have a corpse!.")
		ZGV.Pointer:FindCorpseArrow(true)
		break --------------------------------------------------------------------------------
	end

		
	ZGV:Debug("&waypoints Point the arrow! arrowpoint %s, farmpoint %s, waypath %s",ZGV.Pointer.waypoint_tostring(arrowpoint),ZGV.Pointer.waypoint_tostring(farmpoint),waypath and (#waypath.coords>0) and (#waypath.coords.." points") or "empty")

	if arrowpoint and WorldMapFrame:IsShown() then 
		WorldMapFrame:SetMapID(arrowpoint.m) 
	end

	if ZGV.db.profile.pathfinding then
		if ZGV.Pointer.nummanual>0 then
			-- leave it the hell alone.
			ZGV:Debug("&waypoints Finding path to: Pointer.DestinationWaypoint (there are manual points)")
			ZGV.Pointer:FindTravelPath(ZGV.Pointer.DestinationWaypoint)
		elseif arrowpoint then
			ZGV:Debug("&waypoints Finding path to: arrowpoint")
			ZGV.Pointer:FindTravelPath(arrowpoint)
		elseif (waypath or waypath_poi) and not pointed and ZGV.Pointer.nummanual==0 then
			ZGV:Debug("&waypoints Finding path to: farmpath")
			-- TRY TO POINT TO A FARM PATH.
			-- find center of farm path and point there
			-- BAD.
			if waypath then
				if waypath.loop then
					-- EXPERIMENTAL: travel to path's general area.
					local _,_,currentmapid = LibRover:GetPlayerPosition()
					local currentmapfloor = LibRover:GetFloorByMapID(currentmapid)
					if currentmapid ~= waypath.coords[1].map or currentmapfloor ~= waypath.coords[1].floor then
						self:Debug("&waypoints Pointing to a looped path! We're not in the farm path's zone, let's travel.")
						ZGV.Pointer:FindTravelPath("farm")
					else
						self:Debug("&waypoints Pointing to a looped path! We're in the farm path's zone. Clearing travel, just follow the route.")
						LibRover:Abort("waypoints loop")
						ZGV.Pointer:ClearSet("route")
						ZGV.Pointer:PointToNextInPath("farm")  -- it's looped, so it's a farm, OK
					end
					break -------------------------------------------------------------------------------
				end

				local firstcoord = waypath.coords[1]
				local _,_,currentmapid=LibRover:GetPlayerPosition()
				if firstcoord and currentmapid~=firstcoord.map then
					self:Debug("&waypoints Pointing to a path! We're not in the path's zone, let's travel to the first point.")
					local x,y=0,0
					for i,coord in ipairs(waypath.coords) do x=x+coord.x y=y+coord.y end
					x=x/#waypath.coords
					y=y/#waypath.coords

					local way = ZGV.Pointer:SetWaypoint(firstcoord.map,x,y,{icon=ZGV.Pointer.Icons.none})
					
					if way then ZGV.Pointer:FindTravelPath(way) end
				else
					self:Debug("&waypoints Pointing to a path! We're in the path's zone. Clearing travel, just follow the route.")
					LibRover:Abort("waypoints noloop")
					ZGV.Pointer:ClearSet("route")
					ZGV.Pointer:PointToNextInPath("path")  -- it's not looped, handle it somehow.
				end
			end
		elseif not step:IsDynamic() then 
			ZGV:Debug("&waypoints Aborting, because no manuals and no arrowpoint and no waypath conditions: waypath %s, waypath_poi %s, pointed %s",waypath,waypath_poi,pointed)
			LibRover:Abort("waypoints")
			ZGV.Pointer.PathFoundHandler("failure")
		end
	else
		self.Pointer:FindTravelPath (arrowpoint)
	end

	if step.WorldQuestQueueRouter then
		ZGV.WorldQuests:QueueProcess()
	end

	if arrowpoint and not UnitIsDeadOrGhost("player")
	and not self.Pointer.ArrowFrame.waypoint
	then
		-- don't overwrite the stinking arrow
		self:Debug("&waypoints Pointing to arrowpoint... again?")
		self.Pointer:ShowArrow (arrowpoint)
	end

	until true
	self:Debug("&waypoints &_POP ShowWaypoints ends [%.2f ms]",debugprofilestop()-t1)
end