local ZGV = ZygorGuidesViewer
if not ZGV then return end
local CreatureDetector = {}
ZGV.CreatureDetector = CreatureDetector

local L = ZGV.L
local LM = ZGV.LM
local CHAIN = ZGV.ChainCall

local table,string,tonumber,ipairs,pairs,setmetatable,min,max,tinsert = table,string,tonumber,ipairs,pairs,setmetatable,min,max,tinsert

CreatureDetector.mountSpellDatabase={}
CreatureDetector.petIDDatabase={}
CreatureDetector.modelDatabase={}

CreatureDetector.DetectedGuides = {}
CreatureDetector.DetectedGuidesCounter = 0
CreatureDetector.RecentlyDetectedGuide = nil

CreatureDetector.MAX_DETECTED_GUIDES = 5

local detectedGuideOrder = {}
CreatureDetector.dGO = detectedGuideOrder

tinsert(ZGV.startups,{"CreatureDetector startup",function(self)
	CreatureDetector:StartUp()
end})

local _petguidetexture = ZGV.DIR.."\\Skins\\guideicons-big"
local _petguidetexturecoords = {2/4,3/4,1/4,2/4}

function CreatureDetector:AddGuideToDetectedGuides(guide)
	local self = CreatureDetector
	
	if not (type(guide)=="table" and type(guide[1])~="table") then return nil end --,"Attempting to add a none guide, or a guide in an extra table.")

	if not self.DetectedGuides then
		self.DetectedGuides = {}
	end

	if not self.DetectedGuides[guide.title] then
		if CreatureDetector.DetectedGuidesCounter >= CreatureDetector.MAX_DETECTED_GUIDES then
			if ZGV.NotificationCenter then ZGV.NotificationCenter.RemoveButton(detectedGuideOrder[1].title) end
			self.DetectedGuides[detectedGuideOrder[1].title]=nil
			self.DetectedGuidesCounter = self.DetectedGuidesCounter - 1
			tremove(detectedGuideOrder,1)
		end

		tinsert(detectedGuideOrder,guide)
		self.DetectedGuides[guide.title] = guide
		self.DetectedGuidesCounter = self.DetectedGuidesCounter + 1
	end
end

function CreatureDetector:Detect(force)
	self.RecentlyDetectedGuide=nil

	if not UnitExists("target") or InCombatLockdown() then return  end

	-- WARNING: Unit GUID completely changes in Warlord of Draenor, it's a
	-- string similar to an item link, not a hexidecimal value.
	local guid=UnitGUID("target")
	--local first3 = tonumber(strsub(guid, 3,5),16)
	--local unitType = bit.band(first3,0x00f)
	if UnitIsPlayer("target") then -- Screw the IDs this one is safer
		return self:DetectMount(not force)
	elseif (UnitCreatureType("target") == "Non-combat Pet") then -- TODO: Localize
		return self:DetectMinipet(not force)
	elseif (string.find(UnitGUID("target"),"Pet-")) then
		return self:DetectPet(not force)
	else
		return nil
	end
end

-- Tries to detect a combat pet selected by player
function CreatureDetector:DetectPet(silent_mode)
	if select(2,UnitClass("player"))~="HUNTER" then
		return nil  -- no business viewing it, either.
	end

	-- Check if our target is sane
	local guid=UnitGUID("target")

	if guid==UnitGUID("pet") then return  end  -- own pet.

	--if not guid or not UnitExists("target") or not (bit.band(tonumber(strsub(guid, 3,5),16),0x00f)==0x004) then -- "If that's not a pet"
	if not guid or not UnitExists("target") then
		if not silent_mode then  ZGV:Print("Incorrect target.")  end
		return  -- not a pet, whatever, bail out
	end

	-- Check the existence of the pet database
	if not self.modelDatabase then
		if not silent_mode then  ZGV:Print("No model guides are registered, sorry.")  end
		return
	end

	-- Creating a PlayerModel to display the model of a said pet
	self.PetMirror = self.PetMirror or CreateFrame("PlayerModel")
	self.PetMirror:Show() -- briefly
	self.PetMirror:SetUnit("target")

	-- Perfect, so what's the deal?
	local modelid = self.PetMirror:GetDisplayInfo()
	local fileid = self.PetMirror:GetModelFileID()
	local guide

	if self.modelDatabase[fileid] then
		guide = self.modelDatabase[fileid][1] --Only one guide per pet is possible. Or if there are more then we only need one.
	end

	self.PetMirror:Hide() -- and stay low

	if guide then
		self:AddGuideToDetectedGuides(guide) -- TODO insert the actual guide and make sure it is not a duplicate.
		ZGV:Debug("Hunter Pet Detected")
		--if not silent_mode and ZGV.GuidePicker then ZGV.GuidePicker:NavigateTo("DETECTOR") end
		guide.is_hunter_pet=true
		return guide
	else
		ZGV:Debug("Hunter Pet Guide not found")
		return
	end
end

-- Tries to detect the non-combat pet selected by player
function CreatureDetector:DetectMinipet(silent_mode)
	-- Check if our target is sane
	local guid=UnitGUID("target")
	local npcid=ZGV.GetTargetId()

	--if not guid or not UnitExists("target") or not (bit.band(tonumber(strsub(guid, 3,5),16),0x00f)==0x003) then -- "If that's not a NPC
	if not guid or not UnitExists("target") then -- "If that's not a NPC
		if not silent_mode then  ZGV:Print("Incorrect target.")  end
		return
	end

	-- Make sure all the pet guides are loaded at this point
	-- 	self:LoadGuidesByType("pet")

	-- Check the existence of the pet database
	if not self.petIDDatabase then
		if not silent_mode then  ZGV:Print("No minipet guides are registered, sorry.")  end
		return
	end

	local found

	if self.petIDDatabase[npcid] then
		found=self.petIDDatabase[npcid][1] --Only one guide per pet is possible. Or if there are more then we only need one.
	end

	ZGV:Debug("pet %d %s",npcid,found and "found" or "not found")

	-- If found, point at it
	if found then
		ZGV:Debug("Mini Pet Detected")
		self:AddGuideToDetectedGuides(found)
		found.is_battle_pet=true
		return found
	-- If not, compose a report
	elseif not silent_mode then
		local text="Undetected Pet on Player"
		local nm,rl=UnitName("target")
		text=text.."\nName: "..UnitName("target")
		text=text.."\nNPCID: "..npcid
		text=text.."\nRealm: "..(rl or GetRealmName())
		text=text.."\nSeen by"
		text=text.."\nClass: "..UnitClass("player")
		text=text.."\nRace: "..UnitRace("player")

		StaticPopupDialogs["ZYGOR_REPORT_PET"] = {
			text = L["report_nopet_dialog"],
			button1 = YES,
			button2 = NO,
			OnAccept = function()
				ZGV:ShowDump(text,"Report",true)
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		StaticPopup_Show ("ZYGOR_REPORT_PET")
		return
	else
		ZGV:Debug("Mini Pet Guide not found")
	end
end

-- Tries to detect the mount of the target and focus the guide picker on this guide
-- TODO test and make sure if we need to force the loading of all guides in question
function CreatureDetector:DetectMount(silent_mode)
	-- Check if our target is sane
	if not UnitExists("target") or not UnitIsPlayer("target") then
		ZGV:Print("Incorrect target.")
		return
	end

	-- Make sure all the mount guides are loaded at this point
	-- 	self:LoadGuidesByType("mount")

	-- Check the existence of the mount database
	if not self.mountSpellDatabase then
		if not silent_mode then  ZGV:Print("No mount guides are registered, sorry.")  end
		return
	end

	-- Browsing through the buffs on the target and finding the one we have a guide for
	-- TODO is there a way to tell the whole amount of buffs on a unit?
	local spellID
	local found
	for i=1,1024 do -- meh
		spellID=select(10,UnitBuff("target",i))
		if not spellID then break end
		if self.mountSpellDatabase[spellID] then
			found=self.mountSpellDatabase[spellID][1] --Only one guide per mount is needed. If there are more just ignore them.
			break
		end
	end

	-- If found, point at it
	if found then
		ZGV:Debug("Mount Detected")
		found.is_mount=true
		self:AddGuideToDetectedGuides(found)
		--if not silent_mode and ZGV.GuidePicker then ZGV.GuidePicker:NavigateTo("DETECTOR") end
		return found
	-- If not, compose a report
	elseif not silent_mode then
		local text="Undetected Mount on Player"
		local nm,rl=UnitName("target")
		text=text.."\nName: "..UnitName("target")
		text=text.."\nClass: "..UnitClass("target")
		text=text.."\nRace: "..UnitRace("target")
		text=text.."\nRealm: "..(rl or GetRealmName())
		text=text.."\nBuffs: "
		for i=1,1024 do
			local name,_,_,_,_,_,_,_,_,_,spellID=UnitBuff("target",i)
			if not name then break end
			text=text.."\n  "..name.."##"..spellID
		end
		text=text.."\nSeen by"
		text=text.."\nClass: "..UnitClass("player")
		text=text.."\nRace: "..UnitRace("player")

		StaticPopupDialogs["ZYGOR_REPORT_MOUNT"] = {
			text = L["report_nomount_dialog"],
			button1 = YES,
			button2 = NO,
			OnAccept = function()
				ZGV:ShowDump(text,"Report",true)
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		StaticPopup_Show ("ZYGOR_REPORT_MOUNT")
		return
	else
		ZGV:Debug("Mount Guide not found")
	end
end



local function registerIn(tab,id,guide)
	if not (id and guide) then return end
	if not tab[id] then
		tab[id]={}
	else
		for k,v in ipairs(tab[id]) do
			if v==guide then -- No duplicates please
				return
			end
		end
	end
	table.insert(tab[id],guide)
end

-- Registers a correspondence between mount spell id and a guide to obtain it
function CreatureDetector:RegisterMountSpell(spellid,guide)
	registerIn(self.mountSpellDatabase,spellid,guide)
end

-- Registers a correspondence between pet spell id and a guide to obtain it
function CreatureDetector:RegisterPetID(petid,guide)
	registerIn(self.petIDDatabase,petid,guide)
end

-- Registers a correspondence between a model and a guide to obtain it
function CreatureDetector:RegisterGuideModel(displayid,guide,fileid)
	registerIn(self.modelDatabase,fileid,guide)
end


function CreatureDetector:ShowTooltip(guide,parent,position,x,y)
	if parent then
		GameTooltip:SetOwner(parent, position or "ANCHOR_CURSOR",x or 0, y or 0)
	end

	if guide then
		-- single guide
		local status,txt = guide:GetStatus()
		local parent,path = guide:GetParentFolder()
		GameTooltip:SetText(parent,1,0.9,0.4,1)

		if status=="COMPLETE" then
			if guide.is_mount then 
				GameTooltip:AddLine(L['You already have this mount.'],0.5,1,0.3,1)
			else
				GameTooltip:AddLine(L['You already have this pet.'],0.5,1,0.3,1)
			end
		elseif status=="INVALID" then
			if guide.is_mount then 
				GameTooltip:AddLine(L['This mount is not available.'].." "..txt,1,0,0,1)
			else
				GameTooltip:AddLine(L['This pet is not available.'].." "..txt,1,0,0,1)
			end
		else
			if guide.is_hunter_pet then
				GameTooltip:AddLine(L['detector_pet_tooltip'],1,0.7,0)
			elseif guide.is_mount then 
				GameTooltip:AddLine(L['detector_mount_tooltip'],1,0.7,0)
			else
				GameTooltip:AddLine(L['detector_battlepet_tooltip'],1,0.7,0)
			end
		end
	else
		-- multiple
		--GameTooltip:SetText(L[UnitIsPlayer("target") and 'detector_mount_tooltip' or 'detector_pet_tooltip'])
	end
	if guide and guide.is_hunter_pet then
		GameTooltip:AddLine(L['detector_tooltip_hunter_click'],0,1,0,1)
	else
		GameTooltip:AddLine(L['detector_tooltip_click'],0,1,0,1)
	end
	GameTooltip:SetToplevel(true)
	GameTooltip:Show()
end

--Button Actions

function CreatureDetector:StartUp() -- Create the button
	CreatureDetector.MAX_DETECTED_GUIDES = ZGV.db.profile.n_nc_numpetguides or 5

	self.button= CHAIN(CreateFrame("Button", "ZygorDetectorButton" , TargetFrame))
		:SetMovable(true)
		:RegisterEvent("PLAYER_TARGET_CHANGED")

		:SetSize(29,29)
		:SetPoint("CENTER", TargetFrame, "BOTTOMRIGHT", -105, 35)
		:SetBackdrop({bgFile=ZGV.DIR.."\\Skins\\zglogo-back"})
		:RegisterForClicks("LeftButtonUp","RightButtonUp")
		:RegisterForDrag("LeftButton")

		:SetNormalTexture(_petguidetexture)
		--:SetPushedTexture(ZGV.DIR.."\\Skins\\guideicons-big")
		:SetHighlightTexture(_petguidetexture,"ADD")
		
		:SetScript("OnEnter",function(self) CreatureDetector:ShowTooltip(CreatureDetector.RecentlyDetectedGuide,self) end)
		:SetScript("OnLeave",function(self) GameTooltip:Hide() end)
		:SetScript("OnClick",CreatureDetector.OnClick)
		:SetScript("OnEvent",CreatureDetector.OnEvent)
		:SetScript("OnHide",CreatureDetector.OnHide)

		:SetScript("OnDragStart",function(self) self:StartMoving() end)
		:SetScript("OnDragStop",function(self) self:StopMovingOrSizing() end)

		:Hide()
	.__END
	self.button:GetHighlightTexture():SetTexCoord(unpack(_petguidetexturecoords))
	self.button:GetNormalTexture():SetTexCoord   (unpack(_petguidetexturecoords))
	--self.button:GetPushedTexture():SetTexCoord(2/4,3/4,1/4,2/4)
end

function CreatureDetector:OnClick()
	self = CreatureDetector

	if self.RecentlyDetectedGuide then
		ZGV:SetGuide(self.RecentlyDetectedGuide.title)
	end
end

function CreatureDetector:OnHide()
	CreatureDetector.RecentlyDetectedGuide=nil
end

function CreatureDetector:OnEvent(event)
	self = CreatureDetector
	local button = self.button

	if event=="PLAYER_TARGET_CHANGED" then --Can it be something else?
		button:Hide() --Hide until shown otherwise

		if ZGV.db.profile.n_popup_pet and (ZGV.guidesets['PetsMountsA'] or ZGV.guidesets['PetsMountsH']) then
			self.RecentlyDetectedGuide = self:Detect()
		else
		end

		if self.RecentlyDetectedGuide and ZGV.db.profile.n_popup_pet then
			if ZGV.db.profile.n_nc_enabled and ZGV.NotificationCenter then
				local is_hunter_pet=self.RecentlyDetectedGuide.is_hunter_pet

				local onClick = function(self)
					if is_hunter_pet then
						local _,path = CreatureDetector.DetectedGuides[self.id]:GetParentFolder()
						ZGV.GuideMenu:Show(path)
					else
						ZGV:SetGuide(CreatureDetector.DetectedGuides[self.id])
					end
				end
				local onEnter = function(self)
					local position,x,y = ZGV.NotificationCenter:GetTooltipPosition()
					CreatureDetector:ShowTooltip(CreatureDetector.DetectedGuides[self.id],self,position,x,y)
				end

				local display_title=self.RecentlyDetectedGuide.title_short
				if is_hunter_pet then
					local path,_ = self.RecentlyDetectedGuide.title:match("^(.+)\\(.-)$")
					_,display_title = path:match("^(.+)\\(.-)$")
				end
	
				--(id, text, texture, texcoords, onClick, tooltip, priority, poptime, removetime, quiet, OnOpen, popupType )

				ZGV.NotificationCenter.AddButton(
					self.RecentlyDetectedGuide.title,
					ZGV.L['notifcenter_pet_title'],
					--ZGV.L['notifcenter_pet_text']:format(ZGV.Menu:GetStatusColor(self.RecentlyDetectedGuide:GetStatus()).hex,self.RecentlyDetectedGuide.title_short),
					ZGV.L['notifcenter_pet_text']:format("ff00e9ff",display_title),
					_petguidetexture,
					_petguidetexturecoords,
					onClick,
					onEnter,
					1,
					poptime,		-- nil atm
					removetime,		-- nil atm
					quiet,			-- nil atm
					OnOpen,			-- nil atm
					"pet")

			elseif TargetFrame:IsVisible() then
				button:Show()
			end
		else
			if TargetFrame:IsVisible() then
				button:Hide()
			end
		end
	end
end