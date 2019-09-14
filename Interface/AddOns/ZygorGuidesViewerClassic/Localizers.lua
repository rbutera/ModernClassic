local ZGV = ZygorGuidesViewer
if not ZGV then return end

local Gratuity = LibStub("LibGratuity-3.0")

local Localizers = {}
ZGV.Localizers = Localizers
do
	-- borrowed from _NPCScan.
	local Tooltip = CreateFrame( "GameTooltip", "ZGV_NPCName_Tooltip" )
	Tooltip.Text = Tooltip:CreateFontString()
	Tooltip:AddFontStrings( Tooltip.Text, Tooltip:CreateFontString() )
	--- Checks the cache for a given NpcID.
	-- @return Localized name of the NPC if cached, or nil if not.

	local NPCCache = {}

	local function GetNPCNameFromCache_trim(s)
		return s:find'^%s*$' and '' or s:match'^(.*%S)'
	end

	local function GetNPCNameFromCache(NPCid)

		if NPCCache[NPCid] then return NPCCache[NPCid] end
		Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
		Tooltip:SetHyperlink(("unit:Creature-%d-%d-%d-%d-%d-%x"):format(0,0,0,0,NPCid,0))
		if (Tooltip:IsShown()) then
			local t=GetNPCNameFromCache_trim(Tooltip.Text:GetText())
			NPCCache[NPCid]=t
			return t
		end
	end

	local npcs=ZygorGuidesViewer_L("NPCs")   assert(npcs,"No NPC data loaded")
	function Localizers:GetTranslatedNPC(id,fallbackname)
		if not id then return fallbackname end
		local name_from_cache=GetNPCNameFromCache(id)
		local npc_from_data=npcs[id]
		local name_from_data,desc
		if npc_from_data then  name_from_data,desc = npc_from_data:match("(.-)|(.*)")  end
		
		local name = name_from_cache or name_from_data or fallbackname or "(npc "..id..")"
		if desc=="" then desc=nil end
		return name,desc
	end

	function Localizers:FindNPCIdByName(testname)
		for id,name in pairs(npcs) do
			local n=name:match("(.-)|")  if n then name=n end
			if name==testname then
				return id
			end
		end
	end

	-- DO NOT USE for now.
	function Localizers:PruneNPCs()
		error("DON'T prune NPCs.")
		if not npcs then return end
		local faction,_ = UnitFactionGroup("player")
		if not faction then return end
		local badf = (faction=="Alliance") and "H" or "A"
		for i,d in pairs(npcs) do
			if d:sub(1,1)==badf then npcs[i]=nil end
		end
	end

end

do
	function Localizers:GetQuestDataFromTooltip(qid)
		if not qid then return end
		if not ZGV.db.char.maint_fetchquestdata then return nil end

		Gratuity:SetHyperlink("|Hquest:"..qid..":1|h[q]|h")

		local n = Gratuity:NumLines()
		if n <= 0 then return end

		local color = Gratuity:GetLine(1):match("|c%x%x%x%x%x%x%x%x")

		local title, objs

		for i = 1,n do
			local line = Gratuity:GetLine(i):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("[\n\t]", " ")
			if i == 1 then
				title = line
			else
				local line=line:match("^%s+%- (.+)$")
				if line then
					local o, n = line:match("^(.-) x.?.?(%d+)$")
					if not o then o = line end
					if not objs then
						objs = {}
					end
					table.insert(objs,{item=o,needed=tonumber(n)})
				end
			end
		end

		return title, objs, color
	end

	local function PruneCachedQuestData()
		local t=time()
		for id,q in pairs(ZGV.questsbyid) do  if not q.time then q.time=t elseif t-q.time>1800 and not q.inlog then ZGV.questsbyid[id]=nil end end
	end

	function Localizers:GetQuestData(qid)
		if not qid then return end
		local t=time()
		local q = ZGV.questsbyid[qid]
		if q then  q.time=t  return q,q.inlog  end

		-- unknown?
		local title = C_QuestLog.GetQuestInfo(qid)

		if title and title~="" then
			if math.random()<0.01 then PruneCachedQuestData() end
			local quest = { title=title, id=qid, complete=ZGV.completedQuests[qid], goals=objs, time=t }

			-- if some objectives are known as incomplete, return the data, but don't save it.
			if not still_incomplete then  ZGV.questsbyid[qid]=quest  end

			return quest,false
		end
	end
end
