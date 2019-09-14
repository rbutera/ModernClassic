local _,ZGV=...
local ZTA=ZGV.ZTA
if not ZTA then return end

function ZTA:RegisterBuild (class,title,build,glyphs)
	local build = {title=title,build=build,glyphs=glyphs}
	local pettype = class:match("^PET (.+)")
	if pettype then build.pettype=pettype:upper() else build.class=class end
	self.registeredBuilds[class.." "..title] = build
end

-- remove class-specific builds or any pets for non-hunters
function ZTA:PruneRegisteredBuilds()
	--self:Print("Pruning!")
	if self.registeredBuildsPruned then return nil end

	local _,myclass = UnitClass("player")
	if not myclass then return end


	local pruned,total=0,0
	for bk,build in pairs(self.registeredBuilds) do
		if (build.class and build.class~=myclass)
		or (build.title:find("debug") and not self.db.profile.debug)
		then
			self.registeredBuilds[bk]=nil
			pruned=pruned+1
		end
		total=total+1
	end
	
	self:Debug("Pruned builds other than |cffffffff%s|r, %d/%d gone",myclass,pruned,total)

	for class,talents in pairs(self.TalentsToNumbers) do
		if class~=myclass then
			self.TalentsToNumbers[class]=nil
		end
	end

	self.registeredBuildsPruned = true
end

function ZTA:ParseBlizzardTalents(bliz,pet)
	self:Debug("Parsing Blizzard build")
	local build = {}

	for tab,talent in self.talentpairs(false,pet) do
		if #bliz==0 then break end
		local rank = tonumber(strsub(bliz,1,1))
		bliz = strsub(bliz,2)
		for i=1,rank do table.insert(build,{tab,talent}) end
	end

	return build
end

function ZTA:ParseTableTalents(text)
	TalentFrame_LoadUI()
	self:Debug("Parsing table build")

	local _,class = UnitClass("player")

	local build = {}

	-- Create a spell-to-talenttab lookup table, to be able to check if player/pet.
	-- Serves as a "DoesPlayerHaveTalent(id)".

	local lookup = {}
	local name,link,id
	local count=0
	for tab,talent in self.talentpairs(false) do
		--[[
		link = GetTalentLink(tab,talent,false,pet)
		if link then
			id = tonumber(link:match("talent:(%d+)"))
			lookup[id]={tab,talent}
			count=count+1
		end
		--]]
		local name,texture,_,_,_,_,_,_ = GetTalentInfo(tab,talent)
		if name then
			lookup[texture]={tab,talent}
			count=count+1
		end

		--[[
		name = GetTalentInfo(tab,talent,false,pet)
		if name then
			link = GetTalentLink(tab,talent,false,pet)
			id = tonumber(link:match("talent:(%d+)"))
			--lookup[name]={tab,talent}
			lookup[id]={tab,talent}
			count=count+1
		end
		]]
	end

	if count==0 then
		return nil,"Unable to access talent info, wtf"
	else
		self:Debug(count.." talents cached for lookup")
	end

	-- Verify if player/pet has all the named talents.
	-- To do that, look up spell IDs gathered above and check if they have them or not.

	for i=1,#text do
		--if TalentsToNumbers[text[i]]
		local a,b = string.match(text[i],"(.+)|(.+)")
		if not a then a=text[i] end
		a=self.TalentsToNumbers[class][a]
		if b then a=self.TalentsToNumbers[class][a] end
		a=a or b
		local tree,index = strsplit(",",a or "")  tree=tonumber(tree)  index=tonumber(index)

		if tree and index then
			table.insert(build,{tree,index})
		else
			return nil,("Unknown talent(s): '"..text[i].."' at line "..i..".")
		end
	end
	return build
end

function ZTA:ParseLines(text,multi)
	local table={}
	local index=1
	local st,en
	text = text .. "\n"
	local count
	local spec
	while (index<#text) do
		st,en,line=string.find(text,"(.-)\n",index)
		if not en then break end
		index = en + 1
		line = line:gsub("//.*$",""):gsub("%-%-.*$","")  -- comments away
		line = line:gsub("^[%s	]+",""):gsub("[%s	]+$","")  -- whitespace away
		line = line:gsub("||","|")
		line = line:gsub("/[0-9]+","")  -- /3 are just fluff, remove

		if line:find("spec=") then
			spec=line:match("Spec=(.+)")
		else
			if multi then
				local co,ln = line:match("([1-9]+)[%s%*x]+(.+)")
				if co then
					count=co
					line=ln
				else
					count=1
				end
			else
				count=1
			end
			if (#line>0) then
				for i=1,count do tinsert(table,line) end
			end
		end
	end
	return table,spec
end

function ZTA:ParseTextTalents(text,pet)
	local table,spec = self:ParseLines(text,true)
	return self:ParseTableTalents(table,pet,spec)
end

function ZTA:DumpBuild(num)
	local s = ""
	for i=1,#self.registeredBuilds[num].build do
		local tab,talent = unpack(self.registeredBuilds[num].build[i])
		s = s .. ((#s>0) and "," or "") .. "{"..tab..","..talent.."}"
	end
	self:Print("  ZygorTalentAdvisor:RegisterBuild(\""..(self.registeredBuilds[num].class or "PET "..self.registeredBuilds[num].pettype).."\",\""..self.registeredBuilds[num].title.."\",{"..s.."})")
end

ZTA.TalentsToNumbers = {
["DRUID"] = {
--Balance
	["Improved Wrath"] = "1,1", -- 1,1 136006
	["Nature's Grasp"] = "1,2", -- 1,2 136063
	["Improved Nature's Grasp"] = "1,3", -- 1,3 136063
	["Improved Entangling Roots"] = "1,4", -- 2,1 136100
	["Improved Moonfire"] = "1,5", -- 2,2 136096
	["Natural Weapons"] = "1,6", -- 2,3 135138
	["Natural Shapeshifter"] = "1,7", -- 2,4 136116
	["Improved Thorns"] = "1,8", -- 3,1 136104
	["Omen of Clarity"] = "1,9", -- 3,3 136017
	["Nature's Reach"] = "1,10", -- 3,4 136065
	["Vengeance"] = "1,11", -- 4,2 136075
	["Improved Starfire"] = "1,12", -- 4,3 135753
	["Nature's Grace"] = "1,13", -- 5,2 136062
	["Moonglow"] = "1,14", -- 5,3 136087
	["Moonfury"] = "1,15", -- 6,2 136057
	["Moonkin Form"] = "1,16", -- 7,2 136036
--Feral Combat
	["Ferocity"] = "2,1", -- 1,2 132190
	["Feral Aggression"] = "2,2", -- 1,3 132121
	["Feral Instinct"] = "2,3", -- 2,1 132089
	["Brutal Impact"] = "2,4", -- 2,2 132114
	["Thick Hide"] = "2,5", -- 2,3 134355
	["Feline Swiftness"] = "2,6", -- 3,1 136095
	["Feral Charge"] = "2,7", -- 3,2 132183
	["Sharpened Claws"] = "2,8", -- 3,3 134297
	["Improved Shred"] = "2,9", -- 4,1 136231
	["Predatory Strikes"] = "2,10", -- 4,2 132185
	["Blood Frenzy"] = "2,11", -- 4,3 132152
	["Primal Fury"] = "2,12", -- 4,4 132278
	["Savage Fury"] = "2,13", -- 5,1 132141
	["Faerie Fire (Feral)"] = "2,14", -- 5,3 136033
	["Heart of the Wild"] = "2,15", -- 6,2 135879
	["Leader of the Pack"] = "2,16", -- 7,2 136112
--Restoration
	["Improved Mark of the Wild"] = "3,1", -- 1,2 136078
	["Furor"] = "3,2", -- 1,3 135881
	["Improved Healing Touch"] = "3,3", -- 2,1 136041
	["Nature's Focus"] = "3,4", -- 2,2 136042
	["Improved Enrage"] = "3,5", -- 2,3 132126
	["Reflection"] = "3,6", -- 3,2 135863
	["Insect Swarm"] = "3,7", -- 3,3 136045
	["Subtlety"] = "3,8", -- 3,4 132150
	["Tranquil Spirit"] = "3,9", -- 4,2 135900
	["Improved Rejuvenation"] = "3,10", -- 4,4 136081
	["Nature's Swiftness"] = "3,11", -- 5,1 136076
	["Gift of Nature"] = "3,12", -- 5,3 136074
	["Improved Tranquility"] = "3,13", -- 5,4 136107
	["Improved Regrowth"] = "3,14", -- 6,3 136085
	["Swiftmend"] = "3,15", -- 7,2 134914
},

["HUNTER"] = {
--Beast Mastery
	["Improved Aspect of the Hawk"] = "1,1", -- 1,2 136076
	["Endurance Training"] = "1,2", -- 1,3 136080
	["Improved Eyes of the Beast"] = "1,3", -- 2,1 132150
	["Improved Aspect of the Monkey"] = "1,4", -- 2,2 132159
	["Thick Hide"] = "1,5", -- 2,3 134355
	["Improved Revive Pet"] = "1,6", -- 2,4 132163
	["Pathfinding"] = "1,7", -- 3,1 132242
	["Bestial Swiftness"] = "1,8", -- 3,2 132120
	["Unleashed Fury"] = "1,9", -- 3,3 132091
	["Improved Mend Pet"] = "1,10", -- 4,2 132179
	["Ferocity"] = "1,11", -- 4,3 134297
	["Spirit Bond"] = "1,12", -- 5,1 132121
	["Intimidation"] = "1,13", -- 5,2 132111
	["Bestial Discipline"] = "1,14", -- 5,4 136006
	["Frenzy"] = "1,15", -- 6,3 134296
	["Bestial Wrath"] = "1,16", -- 7,2 132127
--Marksmanship
	["Improved Concussive Shot"] = "2,1", -- 1,2 135860
	["Efficiency"] = "2,2", -- 1,3 135865
	["Improved Hunter's Mark"] = "2,3", -- 2,2 132212
	["Lethal Shots"] = "2,4", -- 2,3 132312
	["Aimed Shot"] = "2,5", -- 3,1 135130
	["Improved Arcane Shot"] = "2,6", -- 3,2 132218
	["Hawk Eye"] = "2,7", -- 3,4 132327
	["Improved Serpent Sting"] = "2,8", -- 4,2 132204
	["Mortal Shots"] = "2,9", -- 4,3 132271
	["Scatter Shot"] = "2,10", -- 5,1 132153
	["Barrage"] = "2,11", -- 5,2 132330
	["Improved Scorpid Sting"] = "2,12", -- 5,3 132169
	["Ranged Weapon Specialization"] = "2,13", -- 6,3 135615
	["Trueshot Aura"] = "2,14", -- 7,2 132329
--Survival
	["Monster Slaying"] = "3,1", -- 1,1 134154
	["Humanoid Slaying"] = "3,2", -- 1,2 135942
	["Deflection"] = "3,3", -- 1,3 132269
	["Entrapment"] = "3,4", -- 2,1 136100
	["Savage Strikes"] = "3,5", -- 2,2 132277
	["Improved Wing Clip"] = "3,6", -- 2,3 132309
	["Clever Traps"] = "3,7", -- 3,1 136106
	["Survivalist"] = "3,8", -- 3,2 136223
	["Deterrence"] = "3,9", -- 3,3 132369
	["Trap Mastery"] = "3,10", -- 4,1 132149
	["Surefooted"] = "3,11", -- 4,2 132219
	["Improved Feign Death"] = "3,12", -- 4,4 132293
	["Killer Instinct"] = "3,13", -- 5,2 135881
	["Counterattack"] = "3,14", -- 5,3 132336
	["Lightning Reflexes"] = "3,15", -- 6,3 136047
	["Wyvern Sting"] = "3,16", -- 7,2 135125
},

["MAGE"] = {
--Arcane
	["Arcane Subtlety"] = "1,1", -- 1,1 135894
	["Arcane Focus"] = "1,2", -- 1,2 135892
	["Improved Arcane Missiles"] = "1,3", -- 1,3 136096
	["Wand Specialization"] = "1,4", -- 2,1 135463
	["Magic Absorption"] = "1,5", -- 2,2 136011
	["Arcane Concentration"] = "1,6", -- 2,3 136170
	["Magic Attunement"] = "1,7", -- 3,1 136006
	["Improved Arcane Explosion"] = "1,8", -- 3,2 136116
	["Arcane Resilience"] = "1,9", -- 3,3 135733
	["Improved Mana Shield"] = "1,10", -- 4,1 136153
	["Improved Counterspell"] = "1,11", -- 4,2 135856
	["Arcane Meditation"] = "1,12", -- 4,4 136208
	["Presence of Mind"] = "1,13", -- 5,2 136031
	["Arcane Mind"] = "1,14", -- 5,3 136129
	["Arcane Instability"] = "1,15", -- 6,2 136222
	["Arcane Power"] = "1,16", -- 7,2 136048
--Fire
	["Improved Fireball"] = "2,1", -- 1,2 135812
	["Impact"] = "2,2", -- 1,3 135821
	["Ignite"] = "2,3", -- 2,1 135818
	["Flame Throwing"] = "2,4", -- 2,2 135815
	["Improved Fire Blast"] = "2,5", -- 2,3 135807
	["Incinerate"] = "2,6", -- 3,1 135813
	["Improved Flamestrike"] = "2,7", -- 3,2 135826
	["Pyroblast"] = "2,8", -- 3,3 135808
	["Burning Soul"] = "2,9", -- 3,4 135805
	["Improved Scorch"] = "2,10", -- 4,1 135827
	["Improved Fire Ward"] = "2,11", -- 4,2 135806
	["Master of Elements"] = "2,12", -- 4,4 135820
	["Critical Mass"] = "2,13", -- 5,2 136115
	["Blast Wave"] = "2,14", -- 5,3 135903
	["Fire Power"] = "2,15", -- 6,3 135817
	["Combustion"] = "2,16", -- 7,2 135824
--Frost
	["Frost Warding"] = "3,1", -- 1,1 135850
	["Improved Frostbolt"] = "3,2", -- 1,2 135846
	["Elemental Precision"] = "3,3", -- 1,3 135989
	["Ice Shards"] = "3,4", -- 2,1 135855
	["Frostbite"] = "3,5", -- 2,2 135842
	["Improved Frost Nova"] = "3,6", -- 2,3 135840
	["Permafrost"] = "3,7", -- 2,4 135864
	["Piercing Ice"] = "3,8", -- 3,1 135845
	["Cold Snap"] = "3,9", -- 3,2 135865
	["Improved Blizzard"] = "3,10", -- 3,4 135857
	["Arctic Reach"] = "3,11", -- 4,1 136141
	["Frost Channeling"] = "3,12", -- 4,2 135860
	["Shatter"] = "3,13", -- 4,3 135849
	["Ice Block"] = "3,14", -- 5,2 135841
	["Improved Cone of Cold"] = "3,15", -- 5,3 135852
	["Winter's Chill"] = "3,16", -- 6,3 135836
	["Ice Barrier"] = "3,17", -- 7,2 135988
},

["PALADIN"] = {
--Holy
	["Divine Strength"] = "1,1", -- 1,2 132154
	["Divine Intellect"] = "1,2", -- 1,3 136090
	["Spiritual Focus"] = "1,3", -- 2,2 135736
	["Improved Seal of Righteousness"] = "1,4", -- 2,3 132325
	["Healing Light"] = "1,5", -- 3,1 135920
	["Consecration"] = "1,6", -- 3,2 135926
	["Improved Lay on Hands"] = "1,7", -- 3,3 135928
	["Unyielding Faith"] = "1,8", -- 3,4 135984
	["Illumination"] = "1,9", -- 4,2 135913
	["Improved Blessing of Wisdom"] = "1,10", -- 4,3 135970
	["Divine Favor"] = "1,11", -- 5,2 135915
	["Lasting Judgement"] = "1,12", -- 5,3 135917
	["Holy Power"] = "1,13", -- 6,3 135938
	["Holy Shock"] = "1,14", -- 7,2 135972
--Protection
	["Improved Devotion Aura"] = "2,1", -- 1,2 135893
	["Redoubt"] = "2,2", -- 1,3 132110
	["Precision"] = "2,3", -- 2,1 132282
	["Guardian's Favor"] = "2,4", -- 2,2 135964
	["Toughness"] = "2,5", -- 2,4 135892
	["Blessing of Kings"] = "2,6", -- 3,1 135995
	["Improved Righteous Fury"] = "2,7", -- 3,2 135962
	["Shield Specialization"] = "2,8", -- 3,3 134952
	["Anticipation"] = "2,9", -- 3,4 135994
	["Improved Hammer of Justice"] = "2,10", -- 4,2 135963
	["Improved Concentration Aura"] = "2,11", -- 4,3 135933
	["Blessing of Sanctuary"] = "2,12", -- 5,2 136051
	["Reckoning"] = "2,13", -- 5,3 135882
	["One-Handed Weapon Specialization"] = "2,14", -- 6,3 135321
	["Holy Shield"] = "2,15", -- 7,2 135880
--Retribution
	["Improved Blessing of Might"] = "3,1", -- 1,2 135906
	["Benediction"] = "3,2", -- 1,3 135863
	["Improved Judgement"] = "3,3", -- 2,1 135959
	["Improved Seal of the Crusader"] = "3,4", -- 2,2 135924
	["Deflection"] = "3,5", -- 2,3 132269
	["Vindication"] = "3,6", -- 3,1 135985
	["Conviction"] = "3,7", -- 3,2 135957
	["Seal of Command"] = "3,8", -- 3,3 132347
	["Pursuit of Justice"] = "3,9", -- 3,4 135937
	["Eye for an Eye"] = "3,10", -- 4,1 135904
	["Improved Retribution Aura"] = "3,11", -- 4,3 135873
	["Two-Handed Weapon Specialization"] = "3,12", -- 5,1 133041
	["Sanctity Aura"] = "3,13", -- 5,3 135934
	["Vengeance"] = "3,14", -- 6,2 132275
	["Repentance"] = "3,15", -- 7,2 135942
},

["PRIEST"] = {
--Discipline
	["Unbreakable Will"] = "1,1", -- 1,2 135995
	["Wand Specialization"] = "1,2", -- 1,3 135463
	["Silent Resolve"] = "1,3", -- 2,1 136053
	["Improved Power Word: Fortitude"] = "1,4", -- 2,2 135987
	["Improved Power Word: Shield"] = "1,5", -- 2,3 135940
	["Martyrdom"] = "1,6", -- 2,4 136107
	["Inner Focus"] = "1,7", -- 3,2 135863
	["Meditation"] = "1,8", -- 3,3 136090
	["Improved Inner Fire"] = "1,9", -- 4,1 135926
	["Mental Agility"] = "1,10", -- 4,2 132156
	["Improved Mana Burn"] = "1,11", -- 4,4 136170
	["Mental Strength"] = "1,12", -- 5,2 136031
	["Divine Spirit"] = "1,13", -- 5,3 135898
	["Force of Will"] = "1,14", -- 6,3 136092
	["Power Infusion"] = "1,15", -- 7,2 135939
--Holy
	["Healing Focus"] = "2,1", -- 1,1 135918
	["Improved Renew"] = "2,2", -- 1,2 135953
	["Holy Specialization"] = "2,3", -- 1,3 135967
	["Spell Warding"] = "2,4", -- 2,2 135976
	["Divine Fury"] = "2,5", -- 2,3 135971
	["Holy Nova"] = "2,6", -- 3,1 135922
	["Blessed Recovery"] = "2,7", -- 3,2 135877
	["Inspiration"] = "2,8", -- 3,4 135928
	["Holy Reach"] = "2,9", -- 4,1 135949
	["Improved Healing"] = "2,10", -- 4,2 135916
	["Searing Light"] = "2,11", -- 4,3 135973
	["Improved Prayer of Healing"] = "2,12", -- 5,1 135943
	["Spirit of Redemption"] = "2,13", -- 5,2 132864
	["Spiritual Guidance"] = "2,14", -- 5,3 135977
	["Spiritual Healing"] = "2,15", -- 6,3 136057
	["Lightwell"] = "2,16", -- 7,2 135980
--Shadow
	["Spirit Tap"] = "3,1", -- 1,2 136188
	["Blackout"] = "3,2", -- 1,3 136160
	["Shadow Affinity"] = "3,3", -- 2,1 136205
	["Improved Shadow Word: Pain"] = "3,4", -- 2,2 136207
	["Shadow Focus"] = "3,5", -- 2,3 136126
	["Improved Psychic Scream"] = "3,6", -- 3,1 136184
	["Improved Mind Blast"] = "3,7", -- 3,2 136224
	["Mind Flay"] = "3,8", -- 3,3 136208
	["Improved Fade"] = "3,9", -- 4,2 135994
	["Shadow Reach"] = "3,10", -- 4,3 136130
	["Shadow Weaving"] = "3,11", -- 4,4 136123
	["Silence"] = "3,12", -- 5,1 136164
	["Vampiric Embrace"] = "3,13", -- 5,2 136230
	["Improved Vampiric Embrace"] = "3,14", -- 5,3 136165
	["Darkness"] = "3,15", -- 6,3 136223
	["Shadowform"] = "3,16", -- 7,2 136200
},

["ROGUE"] = {
--Assassination
	["Improved Eviscerate"] = "1,1", -- 1,1 132292
	["Remorseless Attacks"] = "1,2", -- 1,2 132151
	["Malice"] = "1,3", -- 1,3 132277
	["Ruthlessness"] = "1,4", -- 2,1 132122
	["Murder"] = "1,5", -- 2,2 136147
	["Improved Slice and Dice"] = "1,6", -- 2,4 132306
	["Relentless Strikes"] = "1,7", -- 3,1 132340
	["Improved Expose Armor"] = "1,8", -- 3,2 132354
	["Lethality"] = "1,9", -- 3,3 132109
	["Vile Poisons"] = "1,10", -- 4,2 132293
	["Improved Poisons"] = "1,11", -- 4,3 132273
	["Cold Blood"] = "1,12", -- 5,2 135988
	["Improved Kidney Shot"] = "1,13", -- 5,3 132298
	["Seal Fate"] = "1,14", -- 6,2 136130
	["Vigor"] = "1,15", -- 7,2 136023
--Combat
	["Improved Gouge"] = "2,1", -- 1,1 132155
	["Improved Sinister Strike"] = "2,2", -- 1,2 136189
	["Lightning Reflexes"] = "2,3", -- 1,3 136047
	["Improved Backstab"] = "2,4", -- 2,1 132090
	["Deflection"] = "2,5", -- 2,2 132269
	["Precision"] = "2,6", -- 2,3 132222
	["Endurance"] = "2,7", -- 3,1 136205
	["Riposte"] = "2,8", -- 3,2 132336
	["Improved Sprint"] = "2,9", -- 3,4 132307
	["Improved Kick"] = "2,10", -- 4,1 132219
	["Dagger Specialization"] = "2,11", -- 4,2 135641
	["Dual Wield Specialization"] = "2,12", -- 4,3 132147
	["Mace Specialization"] = "2,13", -- 5,1 133476
	["Blade Flurry"] = "2,14", -- 5,2 132350
	["Sword Specialization"] = "2,15", -- 5,3 135328
	["Fist Weapon Specialization"] = "2,16", -- 5,4 132938
	["Weapon Expertise"] = "2,17", -- 6,2 135882
	["Aggression"] = "2,18", -- 6,3 132275
	["Adrenaline Rush"] = "2,19", -- 7,2 136206
--Subtlety
	["Master of Deception"] = "3,1", -- 1,2 136129
	["Opportunity"] = "3,2", -- 1,3 132366
	["Sleight of Hand"] = "3,3", -- 2,1 132294
	["Elusiveness"] = "3,4", -- 2,2 135994
	["Camouflage"] = "3,5", -- 2,3 132320
	["Initiative"] = "3,6", -- 3,1 136159
	["Ghostly Strike"] = "3,7", -- 3,2 136136
	["Improved Ambush"] = "3,8", -- 3,3 132282
	["Setup"] = "3,9", -- 4,1 136056
	["Improved Sap"] = "3,10", -- 4,2 132310
	["Serrated Blades"] = "3,11", -- 4,3 135315
	["Heightened Senses"] = "3,12", -- 5,1 132089
	["Preparation"] = "3,13", -- 5,2 136121
	["Dirty Deeds"] = "3,14", -- 5,3 136220
	["Hemorrhage"] = "3,15", -- 5,4 136168
	["Deadliness"] = "3,16", -- 6,3 135540
	["Premeditation"] = "3,17", -- 7,2 136183
},

["SHAMAN"] = {
--Elemental
	["Convection"] = "1,1", -- 1,2 136116
	["Concussion"] = "1,2", -- 1,3 135807
	["Earth's Grasp"] = "1,3", -- 2,1 136097
	["Elemental Warding"] = "1,4", -- 2,2 136094
	["Call of Flame"] = "1,5", -- 2,3 135817
	["Elemental Focus"] = "1,6", -- 3,1 136170
	["Reverberation"] = "1,7", -- 3,2 135850
	["Call of Thunder"] = "1,8", -- 3,3 136014
	["Improved Fire Totems"] = "1,9", -- 4,1 135824
	["Eye of the Storm"] = "1,10", -- 4,2 136032
	["Elemental Devastation"] = "1,11", -- 4,4 135791
	["Storm Reach"] = "1,12", -- 5,1 136099
	["Elemental Fury"] = "1,13", -- 5,2 135830
	["Lightning Mastery"] = "1,14", -- 6,3 135990
	["Elemental Mastery"] = "1,15", -- 7,2 136115
--Enhancement
	["Ancestral Knowledge"] = "2,1", -- 1,2 136162
	["Shield Specialization"] = "2,2", -- 1,3 134952
	["Guardian Totems"] = "2,3", -- 2,1 136098
	["Thundering Strikes"] = "2,4", -- 2,2 132325
	["Improved Ghost Wolf"] = "2,5", -- 2,3 136095
	["Improved Lightning Shield"] = "2,6", -- 2,4 136051
	["Enhancing Totems"] = "2,7", -- 3,1 136023
	["Two-Handed Axes and Maces"] = "2,8", -- 3,3 132401
	["Anticipation"] = "2,9", -- 3,4 136056
	["Flurry"] = "2,10", -- 4,2 132152
	["Toughness"] = "2,11", -- 4,3 135892
	["Improved Weapon Totems"] = "2,12", -- 5,1 135792
	["Elemental Weapons"] = "2,13", -- 5,2 135814
	["Parry"] = "2,14", -- 5,3 132269
	["Weapon Mastery"] = "2,15", -- 6,3 132215
	["Stormstrike"] = "2,16", -- 7,2 135963
--Restoration
	["Improved Healing Wave"] = "3,1", -- 1,2 136052
	["Tidal Focus"] = "3,2", -- 1,3 135859
	["Improved Reincarnation"] = "3,3", -- 2,1 136080
	["Ancestral Healing"] = "3,4", -- 2,2 136109
	["Totemic Focus"] = "3,5", -- 2,3 136057
	["Nature's Guidance"] = "3,6", -- 3,1 135860
	["Healing Focus"] = "3,7", -- 3,2 136043
	["Totemic Mastery"] = "3,8", -- 3,3 136069
	["Healing Grace"] = "3,9", -- 3,4 136041
	["Restorative Totems"] = "3,10", -- 4,2 136053
	["Tidal Mastery"] = "3,11", -- 4,3 136107
	["Healing Way"] = "3,12", -- 5,1 136044
	["Nature's Swiftness"] = "3,13", -- 5,3 136076
	["Purification"] = "3,14", -- 6,3 135865
	["Mana Tide Totem"] = "3,15", -- 7,2 135861
},

["WARLOCK"] = {
--Affliction
	["Suppression"] = "1,1", -- 1,2 136230
	["Improved Corruption"] = "1,2", -- 1,3 136118
	["Improved Curse of Weakness"] = "1,3", -- 2,1 136138
	["Improved Drain Soul"] = "1,4", -- 2,2 136163
	["Improved Life Tap"] = "1,5", -- 2,3 136126
	["Improved Drain Life"] = "1,6", -- 2,4 136169
	["Improved Curse of Agony"] = "1,7", -- 3,1 136139
	["Fel Concentration"] = "1,8", -- 3,2 136157
	["Amplify Curse"] = "1,9", -- 3,3 136132
	["Grim Reach"] = "1,10", -- 4,1 136127
	["Nightfall"] = "1,11", -- 4,2 136223
	["Improved Drain Mana"] = "1,12", -- 4,4 136208
	["Siphon Life"] = "1,13", -- 5,2 136188
	["Curse of Exhaustion"] = "1,14", -- 5,3 136162
	["Improved Curse of Exhaustion"] = "1,15", -- 5,4 136162
	["Shadow Mastery"] = "1,16", -- 6,2 136195
	["Dark Pact"] = "1,17", -- 7,2 136141
--Demonology
	["Improved Healthstone"] = "2,1", -- 1,1 135230
	["Improved Imp"] = "2,2", -- 1,2 136218
	["Demonic Embrace"] = "2,3", -- 1,3 136172
	["Improved Health Funnel"] = "2,4", -- 2,1 136168
	["Improved Voidwalker"] = "2,5", -- 2,2 136221
	["Fel Intellect"] = "2,6", -- 2,3 135932
	["Improved Succubus"] = "2,7", -- 3,1 136220
	["Fel Domination"] = "2,8", -- 3,2 136082
	["Fel Stamina"] = "2,9", -- 3,3 136121
	["Master Summoner"] = "2,10", -- 4,2 136164
	["Unholy Power"] = "2,11", -- 4,3 136206
	["Improved Enslave Demon"] = "2,12", -- 5,1 136154
	["Demonic Sacrifice"] = "2,13", -- 5,2 136184
	["Improved Firestone"] = "2,14", -- 5,4 132386
	["Master Demonologist"] = "2,15", -- 6,3 136203
	["Soul Link"] = "2,16", -- 7,2 136160
	["Improved Spellstone"] = "2,17", -- 7,3 134131
--Destruction
	["Improved Shadow Bolt"] = "3,1", -- 1,2 136197
	["Cataclysm"] = "3,2", -- 1,3 135831
	["Bane"] = "3,3", -- 2,2 136146
	["Aftermath"] = "3,4", -- 2,3 135805
	["Improved Firebolt"] = "3,5", -- 3,1 135809
	["Improved Lash of Pain"] = "3,6", -- 3,2 136136
	["Devastation"] = "3,7", -- 3,3 135813
	["Shadowburn"] = "3,8", -- 3,4 136191
	["Intensity"] = "3,9", -- 4,1 135819
	["Destructive Reach"] = "3,10", -- 4,2 136133
	["Improved Searing Pain"] = "3,11", -- 4,4 135827
	["Pyroclasm"] = "3,12", -- 5,1 135830
	["Improved Immolate"] = "3,13", -- 5,2 135817
	["Ruin"] = "3,14", -- 5,3 136207
	["Emberstorm"] = "3,15", -- 6,3 135826
	["Conflagrate"] = "3,16", -- 7,2 135807
},

["WARRIOR"] = {
--Arms
	["Improved Heroic Strike"] = "1,1", -- 1,1 132282
	["Deflection"] = "1,2", -- 1,2 132269
	["Improved Rend"] = "1,3", -- 1,3 132155
	["Improved Charge"] = "1,4", -- 2,1 132337
	["Tactical Mastery"] = "1,5", -- 2,2 136031
	["Improved Thunder Clap"] = "1,6", -- 2,4 132326
	["Improved Overpower"] = "1,7", -- 3,1 135275
	["Anger Management"] = "1,8", -- 3,2 135881
	["Deep Wounds"] = "1,9", -- 3,3 132090
	["Two-Handed Weapon Specialization"] = "1,10", -- 4,2 132400
	["Impale"] = "1,11", -- 4,3 132312
	["Axe Specialization"] = "1,12", -- 5,1 132397
	["Sweeping Strikes"] = "1,13", -- 5,2 132306
	["Mace Specialization"] = "1,14", -- 5,3 133476
	["Sword Specialization"] = "1,15", -- 5,4 135328
	["Polearm Specialization"] = "1,16", -- 6,1 135562
	["Improved Hamstring"] = "1,17", -- 6,3 132316
	["Mortal Strike"] = "1,18", -- 7,2 132355
--Fury
	["Booming Voice"] = "2,1", -- 1,2 136075
	["Cruelty"] = "2,2", -- 1,3 132292
	["Improved Demoralizing Shout"] = "2,3", -- 2,2 132366
	["Unbridled Wrath"] = "2,4", -- 2,3 136097
	["Improved Cleave"] = "2,5", -- 3,1 132338
	["Piercing Howl"] = "2,6", -- 3,2 136147
	["Blood Craze"] = "2,7", -- 3,3 136218
	["Improved Battle Shout"] = "2,8", -- 3,4 132333
	["Dual Wield Specialization"] = "2,9", -- 4,1 132147
	["Improved Execute"] = "2,10", -- 4,2 135358
	["Enrage"] = "2,11", -- 4,3 136224
	["Improved Slam"] = "2,12", -- 5,1 132340
	["Death Wish"] = "2,13", -- 5,2 136146
	["Improved Intercept"] = "2,14", -- 5,4 132307
	["Improved Berserker Rage"] = "2,15", -- 6,1 136009
	["Flurry"] = "2,16", -- 6,3 132152
	["Bloodthirst"] = "2,17", -- 7,2 136012
--Protection
	["Shield Specialization"] = "3,1", -- 1,2 134952
	["Anticipation"] = "3,2", -- 1,3 136056
	["Improved Bloodrage"] = "3,3", -- 2,1 132277
	["Toughness"] = "3,4", -- 2,3 135892
	["Iron Will"] = "3,5", -- 2,4 135995
	["Last Stand"] = "3,6", -- 3,1 135871
	["Improved Shield Block"] = "3,7", -- 3,2 132110
	["Improved Revenge"] = "3,8", -- 3,3 132353
	["Defiance"] = "3,9", -- 3,4 132347
	["Improved Sunder Armor"] = "3,10", -- 4,1 132363
	["Improved Disarm"] = "3,11", -- 4,2 132343
	["Improved Taunt"] = "3,12", -- 4,3 136080
	["Improved Shield Wall"] = "3,13", -- 5,1 132362
	["Concussion Blow"] = "3,14", -- 5,2 132325
	["Improved Shield Bash"] = "3,15", -- 5,3 132357
	["One-Handed Weapon Specialization"] = "3,16", -- 6,3 135321
	["Shield Slam"] = "3,17", -- 7,2 134951
},
}

function ZTA:DumpTalentSpells(pet)  -- builds TalentsToNumbers as above.  
	--assert(ZGV,"ZGV required for display.")

	local s = ""
	local _,myclass
	if not pet then _,myclass = UnitClass("player") else _,myclass = GetTalentTabInfo(1,false,pet) end
	s = "	[\""..myclass.."\"]={\n"
	if pet then s = s .. "		[\"pet\"]=1,\n" end
	for tab=1,GetNumTalentTabs(false,pet) do
		local id,tabname = GetTalentTabInfo(tab,false,pet)
		--s = s .. "	[\""..tabname.."\"]={\n"
		for talent=1,GetNumTalents(tab,false,pet) do
			local name,texture = GetTalentInfo(tab,talent,false,pet)
			local link = GetTalentLink and GetTalentLink(tab,talent,false,pet)
			if link then
				local _,_,id = link:find("talent:([0-9]+)")
				s = s .. "		[\""..name.."\"]="..id..",\n"
			else
				-- shit, classic, use textures..?
				--s = s .. "		-- no link for "..tab..","..talent.."\n"
				s = s .. "		[\""..name.."\"]="..texture..",\n"
			end
		end
		if tab<GetNumTalentTabs(false,pet) then s = s .. "\n" end
	end
	s = s .. "	},\n"
	if ZGV and ZGV.ShowDump then
		ZGV:ShowDump(s,"Talent data:")
	else
		print(s)
	end
	
end