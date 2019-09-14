local name,ZGV=...

local NPCcached={}
local function parseNPC(s)
	wipe(NPCcached)
	local grab=function(k,v)
		NPCcached[k]=v
	end
	s:gsub("(%w)([^|]+)",grab)
	NPCcached.x=tonumber(NPCcached.x)
	NPCcached.y=tonumber(NPCcached.y)
	NPCcached.m=tonumber(NPCcached.m)
	NPCcached.f=tonumber(NPCcached.f)
	return NPCcached
end

-- de-hostilize

local badfact
if UnitFactionGroup("player")=="Alliance" then badfact="H"
elseif UnitFactionGroup("player")=="Horde" then badfact="A"
end

-- Clean up
for t,d in pairs(ZGV._NPCData) do ZGV._NPCData[t]=d:gsub("\t","") end

-- Remove hostiles
if badfact then for t,d in pairs(ZGV._NPCData) do ZGV._NPCData[t]=d:gsub("%d+=s"..badfact..".-\n","") end end
if badfact then ZGV._MailboxData=ZGV._MailboxData:gsub("s"..badfact..".-\n","") end

-- localize

local data=ZGV._NPCData
assert(data,"NPCData missing")
ZGV.NPCData={}  setmetatable(ZGV.NPCData,{__index=function(t,k) if type(k)~='number' then return end local d=data:match('\n'..k..'=(.+)') if not d then return end  return parseNPC(d)  end})
ZGV.NPCData.parseNPC=parseNPC  -- store it, in case someone wants it
ZGV.NPCData.raw=data
function ZGV.NPCData:iterate(typ)
	return data[typ]:gmatch("\n(%d+)=([^\n]+)")
end
ZGV._NPCData=nil


-- Mailboxes --

local MailboxCached={}
local function parseMailbox(s)
	wipe(MailboxCached)
	local grab=function(k,v)
		MailboxCached[k]=v
	end
	s:gsub("(%w)([^|]+)",grab)
	MailboxCached.x=tonumber(MailboxCached.x)
	MailboxCached.y=tonumber(MailboxCached.y)
	MailboxCached.m=tonumber(MailboxCached.m)
	MailboxCached.f=tonumber(MailboxCached.f)
	return MailboxCached
end

-- iterator

local mailboxData=ZGV._MailboxData
assert(mailboxData,"MailboxData missing")
ZGV.MailboxData={}
setmetatable(ZGV.MailboxData,{__index=function(t,k)
	local d=mailboxData:match('\ns(.+)')
	if not d then return end
	return parseMailbox(d)
end})
ZGV.MailboxData.parseMailbox=parseMailbox  -- store it, in case someone wants it

local matcher = nil
local matcherIndex = 1
function ZGV.MailboxData:iterate()
	if not matcher then
		matcher = mailboxData:gmatch("\n([^\n]-|tM)")
		matcherIndex = 1
	end
	matcherIndex = matcherIndex + 1
	
	return function()
		local match = matcher()
		if match then
			return tostring(matcherIndex), match
		else
			matcher = nil
			matcherIndex = 1
		end
	end
end
ZGV._MailboxData=nil


