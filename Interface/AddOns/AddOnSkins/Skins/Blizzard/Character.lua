local AS = unpack(AddOnSkins)

-- Cache global variables
--Lua functions
local _G = _G
local ipairs, pairs, select, type, unpack = ipairs, pairs, select, type, unpack
--WoW API / Variables
local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset
local GetFactionInfo = GetFactionInfo
local GetNumFactions = GetNumFactions
local GetNumSockets = GetNumSockets
local GetInspectSpecialization = GetInspectSpecialization
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetTradePlayerItemLink = GetTradePlayerItemLink
local GetTradeTargetItemLink = GetTradeTargetItemLink
local GetSocketTypes = GetSocketTypes
local GetSpecializationInfoByID = GetSpecializationInfoByID
local GetSpecializationRoleByID = GetSpecializationRoleByID
local GEM_TYPE_INFO = GEM_TYPE_INFO
local hooksecurefunc = hooksecurefunc
local PaperDollBgDesaturate = PaperDollBgDesaturate
local PAPERDOLL_SIDEBARS = PAPERDOLL_SIDEBARS
local UnitSex = UnitSex
-- GLOBALS:

function AS:Blizzard_Character()
	AS:StripTextures(_G.PaperDollFrame)
	AS:SkinBackdropFrame(_G.CharacterFrame)
	_G.CharacterFrame.Backdrop:SetPoint('TOPLEFT', 10, -12)
	_G.CharacterFrame.Backdrop:SetPoint('BOTTOMRIGHT', -32, 76)
	AS:SkinCloseButton(_G.CharacterFrameCloseButton)

	AS:SkinBackdropFrame(_G.CharacterModelFrame)
	_G.CharacterModelFrame.Backdrop:SetPoint('BOTTOMRIGHT', 2, -80)
	AS:CreateShadow(_G.CharacterModelFrame.Backdrop, true)

	AS:SkinArrowButton(CharacterModelFrameRotateLeftButton)
	AS:SkinArrowButton(CharacterModelFrameRotateRightButton)

	AS:Kill(_G.CharacterFramePortrait)

	for _, Slot in pairs({_G.PaperDollItemsFrame:GetChildren()}) do
		if Slot:IsObjectType("Button") then
			AS:SkinFrame(Slot)
			AS:StyleButton(Slot)
			AS:CreateShadow(Slot, true)

			if Slot.icon then
				AS:SkinTexture(Slot.icon)
				Slot.icon:SetInside()
			end
		end
	end

	for i = 1, 5 do
		AS:SkinTab(_G['CharacterFrameTab'..i])
	end

	AS:StripTextures(_G.CharacterAttributesFrame)

	for i = 1, 5 do
		--AS:SkinTexture(select(1, _G['MagicResFrame'..i]:GetRegions()))
	end
	-- --Titles
	-- hooksecurefunc('PaperDollTitlesPane_Update', function()
	-- 	for _, Title in pairs(_G.PaperDollTitlesPane.buttons) do
	-- 		if not Title.isStyled then
	-- 			AS:StripTextures(Title)
	-- 			Title:SetWidth(Title:GetWidth() + 30)
	-- 			Title.Stripe:SetTexture([[Interface\AddOns\AddOnSkins\Media\Textures\Highlight]])
	-- 			Title.Stripe.SetColorTexture = AS.Noop
	-- 			Title.Check:SetTexture([[Interface\Buttons\UI-CheckBox-Check]])
	-- 			Title.text:SetTextColor(1, 1, 1)
	-- 			Title:HookScript('OnEnter', function(self) self.text:SetTextColor(unpack(AS.Color)) end)
	-- 			Title:HookScript('OnLeave', function(self) self.text:SetTextColor(1, 1, 1) end)
	-- 			Title.isStyled = true
	-- 		end

	-- 		--Title.text:SetFont(AS.Font, 12)
	-- 	end
	-- end)

	-- Reputation
	AS:StripTextures(_G.ReputationFrame)
	AS:StripTextures(_G.ReputationListScrollFrame)
	AS:SkinScrollBar(_G.ReputationListScrollFrame.ScrollBar)
	AS:SkinFrame(_G.ReputationDetailFrame)
	_G.ReputationDetailFrame:SetPoint("TOPLEFT", _G.ReputationFrame, "TOPRIGHT", 4, -28)
	hooksecurefunc("ReputationFrame_Update", function()
		local factionOffset = FauxScrollFrame_GetOffset(_G.ReputationListScrollFrame)
		local numFactions = GetNumFactions()
		for i = 1, _G.NUM_FACTIONS_DISPLAYED do
			local FactionName = _G["ReputationBar"..i.."FactionName"]
			local Button = _G["ReputationBar"..i.."ExpandOrCollapseButton"]
			local factionIndex = factionOffset + i
			if ( factionIndex <= numFactions ) then
				local name, _, _, _, _, _, atWarWith, canToggleAtWar, isHeader, isCollapsed = GetFactionInfo(factionIndex)
				if isHeader then
					FactionName:SetTextColor(.9, .8, 0)
				else
					if atWarWith and canToggleAtWar then
						FactionName:SetTextColor(1, .1, .1)
					else
						FactionName:SetTextColor(1, 1, 1)
					end
				end
			end
		end
	end)

	AS:SkinCloseButton(_G.ReputationDetailCloseButton)
	AS:SkinCheckBox(_G.ReputationDetailAtWarCheckBox)
	_G.ReputationDetailAtWarCheckBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-SwordCheck")
	AS:SkinCheckBox(_G.ReputationDetailInactiveCheckBox)
	AS:SkinCheckBox(_G.ReputationDetailMainScreenCheckBox)

	for i = 1, 15 do
		AS:SkinStatusBar(_G["ReputationBar"..i])
		_G["ReputationBar"..i].Backdrop:SetPoint('TOPLEFT', -2, 2)
		_G["ReputationBar"..i].Backdrop:SetPoint('BOTTOMRIGHT', 2, -2)
	end

	AS:StripTextures(SkillFrame)
	AS:StripTextures(SkillFrameExpandButtonFrame)
	AS:SkinButton(SkillFrameCancelButton)

	AS:StripTextures(SkillListScrollFrame)
	AS:StripTextures(SkillDetailScrollFrame)

	AS:SkinScrollBar(SkillListScrollFrameScrollBar)
	AS:SkinScrollBar(SkillDetailScrollFrameScrollBar)

	for i = 1, 12 do
		AS:SkinStatusBar(_G['SkillRankFrame'..i])
		AS:SetOutside(_G['SkillRankFrame'..i].Backdrop)
		AS:StripTextures(_G['SkillRankFrame'..i..'Border'])
	end

	AS:SkinStatusBar(SkillDetailStatusBar)
	AS:SetOutside(SkillDetailStatusBar.Backdrop)

	AS:StripTextures(HonorFrame)
end

function AS:Blizzard_DressUpFrame()
	AS:SkinBackdropFrame(_G.SideDressUpFrame, nil, nil, true)
	_G.SideDressUpFrame.Backdrop:SetPoint('TOPLEFT', 10, -12)
	_G.SideDressUpFrame.Backdrop:SetPoint('BOTTOMRIGHT', -32, 76)
	AS:SkinButton(_G.SideDressUpModelResetButton)
	AS:SkinCloseButton(_G.SideDressUpModelCloseButton)

	hooksecurefunc("SetUpSideDressUpFrame", function(parentFrame, closedWidth, openWidth, point, relativePoint, offsetX, offsetY)
		if parentFrame == _G.AuctionFrame then
			_G.SideDressUpFrame:SetPoint(point, parentFrame, relativePoint, 2, offsetY)
		end
	end)

	AS:SkinBackdropFrame(_G.DressUpFrame)
	_G.DressUpFrame.Backdrop:SetPoint('TOPLEFT', 10, -12)
	_G.DressUpFrame.Backdrop:SetPoint('BOTTOMRIGHT', -32, 76)
	AS:SkinCloseButton(_G.DressUpFrameCloseButton)
	AS:SkinButton(_G.DressUpFrame.ResetButton)

	_G.DressUpFramePortrait:SetAlpha(0)

	AS:SkinButton(_G.DressUpFrameCancelButton)
	_G.DressUpFrame.ResetButton:SetPoint("RIGHT", _G.DressUpFrameCancelButton, "LEFT", -2, 0)
end

function AS:Blizzard_Inspect(event, addon)
	if addon ~= "Blizzard_InspectUI" then return end

	AS:SkinFrame(_G.InspectFrame)
	AS:SkinCloseButton(_G.InspectFrame.CloseButton)
	_G.InspectFrame.portrait:SetAlpha(0)

	for i = 1, 4 do
		AS:SkinTab(_G["InspectFrameTab"..i])
	end

	AS:SkinButton(_G.InspectPaperDollFrame.ViewButton)
	AS:SkinBackdropFrame(_G.InspectModelFrame)

	for _, Slot in pairs({_G.InspectPaperDollItemsFrame:GetChildren()}) do
		if Slot:IsObjectType("Button") or Slot:IsObjectType("ItemButton") then
			AS:SkinTexture(Slot.icon)
			AS:SkinFrame(Slot)
			AS:StyleButton(Slot)
			AS:CreateShadow(Slot, true)
			Slot.icon:SetInside()

			Slot.IconBorder:SetAlpha(0)
			hooksecurefunc(Slot.IconBorder, 'SetVertexColor', function(self, r, g, b) Slot:SetBackdropBorderColor(r, g, b) end)
			hooksecurefunc(Slot.IconBorder, 'Hide', function(self) Slot:SetBackdropBorderColor(unpack(AS.BorderColor)) end)
		end
	end

	AS:StripTextures(_G.InspectPVPFrame)

	for _, Button in pairs(_G.InspectPVPFrame.Slots) do
		AS:CreateBackdrop(Button.Texture)

		Button.Arrow:SetAlpha(0)
		Button.Border:Hide()

		hooksecurefunc(Button, "Update", function(self)
			if (not self.slotIndex) or (not _G.INSPECTED_UNIT) then
				return
			end

			local slotInfo = C_SpecializationInfo_GetInspectSelectedPvpTalent(_G.INSPECTED_UNIT, self.slotIndex)

			if (slotInfo) then
				AS:SkinTexture(self.Texture)
				self.Texture:SetDesaturated(false)
				self.Texture.Backdrop:SetBackdropBorderColor(unpack(AS.BorderColor))
			else
				self.Texture:SetTexture([[Interface\PetBattles\PetBattle-LockIcon]])
				self.Texture:SetTexCoord(0, 1, 0, 1)
				self.Texture:SetDesaturated(true)
				self.Texture:Show()
				self.Texture.Backdrop:SetBackdropBorderColor(1, 0, 0, 1)
			end
		end)
	end

	AS:StripTextures(_G.InspectTalentFrame)
	_G.InspectTalentFrame.InspectSpec.ring:SetTexture('')
	AS:SkinTexture(_G.InspectTalentFrame.InspectSpec.specIcon, true)

	_G.InspectTalentFrame.InspectSpec:HookScript('OnShow', function(self)
		local Spec, Sex
		if (_G.INSPECTED_UNIT ~= nil) then
			Spec = GetInspectSpecialization(_G.INSPECTED_UNIT)
			Sex = UnitSex(_G.INSPECTED_UNIT)
		end
		if(Spec ~= nil and Spec > 0 and Sex ~= nil) then
			local Role = GetSpecializationRoleByID(Spec)
			if (Role ~= nil) then
				self.specIcon:SetTexture(select(4, GetSpecializationInfoByID(Spec, Sex)))
			end
		end
	end)

	for i = 1, _G.MAX_TALENT_TIERS do
		for j = 1, _G.NUM_TALENT_COLUMNS do
			local Button = _G.InspectTalentFrame.InspectTalents['tier'..i]["talent"..j]
			AS:StripTextures(Button)
			AS:SkinTexture(Button.icon, true)
			hooksecurefunc(Button.border, 'SetShown', function(self, value)
				if value == true then
					Button.icon.Backdrop:SetBackdropBorderColor(unpack(AS.Color))
				else
					Button.icon.Backdrop:SetBackdropBorderColor(unpack(AS.BorderColor))
				end
			end)
		end
	end

	_G.InspectGuildFrameBG:SetTexture('')

	AS:UnregisterSkinEvent(addon, event)
end

function AS:Blizzard_TradeWindow()
	AS:SkinFrame(_G.TradeFrame, nil, nil, true)
	AS:StripTextures(_G.TradeRecipientMoneyBg)
	AS:SkinFrame(_G.TradeRecipientMoneyInset)
	AS:SkinButton(_G.TradeFrameTradeButton, true)
	AS:SkinButton(_G.TradeFrameCancelButton, true)
	AS:SkinCloseButton(_G.TradeFrameCloseButton)

	AS:SkinEditBox(_G.TradePlayerInputMoneyFrameGold)
	AS:SkinEditBox(_G.TradePlayerInputMoneyFrameSilver)
	AS:SkinEditBox(_G.TradePlayerInputMoneyFrameCopper)

	AS:StripTextures(_G.TradePlayerInputMoneyInset)
	_G.TradePlayerInputMoneyFrame:SetPoint('TOPLEFT', 8, -59)
	_G.TradePlayerItem1:SetPoint('TOPLEFT', 8, -89)

	for _, Inset in pairs({ _G.TradePlayerItemsInset, _G.TradeRecipientItemsInset, _G.TradePlayerEnchantInset, _G.TradeRecipientEnchantInset }) do
		AS:SkinFrame(Inset)
	end

	for _, Highlight in pairs({ _G.TradeHighlightPlayer, _G.TradeHighlightRecipient, _G.TradeHighlightPlayerEnchant, _G.TradeHighlightRecipientEnchant }) do
		Highlight:StripTextures()
	end

	for _, Frame in pairs({"TradePlayerItem", "TradeRecipientItem"}) do
		for i = 1, 7 do
			local ItemBackground = _G[Frame..i]
			local ItemButton = _G[Frame..i.."ItemButton"]

			AS:StripTextures(ItemBackground)
			AS:SkinFrame(ItemButton)
			AS:StyleButton(ItemButton)

			AS:SkinTexture(ItemButton.icon)
			ItemButton.icon:SetInside()
			AS:CreateBackdrop(ItemButton)
			ItemButton.Backdrop:SetBackdropColor(0, 0, 0, 0)
			ItemButton.Backdrop:SetPoint("TOPLEFT", ItemButton, "TOPRIGHT", 4, 0)
			ItemButton.Backdrop:SetPoint("BOTTOMRIGHT", _G[Frame..i.."NameFrame"], "BOTTOMRIGHT", -1, 14)
		end
	end

	hooksecurefunc('TradeFrame_SetAcceptState', function(playerState, targetState)
		if ( playerState == 1 ) then
			_G.TradePlayerItemsInset:SetBackdropBorderColor(0, 1, 0)
			_G.TradePlayerEnchantInset:SetBackdropBorderColor(0, 1, 0)
		else
			_G.TradePlayerItemsInset:SetBackdropBorderColor(unpack(AS.BorderColor))
			_G.TradePlayerEnchantInset:SetBackdropBorderColor(unpack(AS.BorderColor))
		end
		if ( targetState == 1 ) then
			_G.TradeRecipientItemsInset:SetBackdropBorderColor(0, 1, 0)
			_G.TradeRecipientEnchantInset:SetBackdropBorderColor(0, 1, 0)
			_G.TradeRecipientMoneyInset:SetBackdropBorderColor(0, 1, 0)
		else
			_G.TradeRecipientItemsInset:SetBackdropBorderColor(unpack(AS.BorderColor))
			_G.TradeRecipientEnchantInset:SetBackdropBorderColor(unpack(AS.BorderColor))
			_G.TradeRecipientMoneyInset:SetBackdropBorderColor(unpack(AS.BorderColor))
		end
	end)

	hooksecurefunc('TradeFrame_UpdatePlayerItem', function(id)
		local tradeItem = _G["TradePlayerItem"..id.."ItemButton"]
		tradeItem:SetBackdropBorderColor(unpack(AS.BorderColor))
		local Link = GetTradePlayerItemLink(id)
		if Link then
			local Quality = select(3, GetItemInfo(Link))
			if Quality and Quality > 1 then
				tradeItem:SetBackdropBorderColor(GetItemQualityColor(Quality))
			end
		end
	end)

	hooksecurefunc('TradeFrame_UpdateTargetItem', function(id)
		local tradeItem = _G["TradeRecipientItem"..id.."ItemButton"]
		tradeItem:SetBackdropBorderColor(unpack(AS.BorderColor))
		local Link = GetTradeTargetItemLink(id)
		if Link then
			local Quality = select(3, GetItemInfo(Link))
			if Quality and Quality > 1 then
				tradeItem:SetBackdropBorderColor(GetItemQualityColor(Quality))
			end
		end
	end)
end

AS:RegisterSkin('Blizzard_Character', AS.Blizzard_Character)
AS:RegisterSkin('Blizzard_DressUpFrame', AS.Blizzard_DressUpFrame)
AS:RegisterSkin("Blizzard_Inspect", AS.Blizzard_Inspect, 'ADDON_LOADED')
AS:RegisterSkin('Blizzard_TradeWindow', AS.Blizzard_TradeWindow)
