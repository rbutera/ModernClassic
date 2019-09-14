local AS = unpack(AddOnSkins)

function AS:Blizzard_AdventureMap(event, addon)
	if addon ~= 'Blizzard_AdventureMap' then return end

	AS:SkinBackdropFrame(AdventureMapQuestChoiceDialog)

	local function SkinRewards()
		for reward in pairs(AdventureMapQuestChoiceDialog.rewardPool.activeObjects) do
			if not reward.isSkinned then
				AS:SkinIconButton(reward)
				reward.Icon:SetDrawLayer("OVERLAY")
				reward.isSkinned = true
			end
		end
	end

	hooksecurefunc(AdventureMapQuestChoiceDialog, "RefreshRewards", SkinRewards)

	AdventureMapQuestChoiceDialog.Details.Child.TitleHeader:SetTextColor(1, 1, 0)
	AdventureMapQuestChoiceDialog.Details.Child.DescriptionText:SetTextColor(1, 1, 1)
	AdventureMapQuestChoiceDialog.Details.Child.ObjectivesHeader:SetTextColor(1, 1, 0)
	AdventureMapQuestChoiceDialog.Details.Child.ObjectivesText:SetTextColor(1, 1, 1)

	AS:SkinCloseButton(AdventureMapQuestChoiceDialog.CloseButton)
	AS:SkinScrollBar(AdventureMapQuestChoiceDialog.Details.ScrollBar)
	AS:SkinButton(AdventureMapQuestChoiceDialog.AcceptButton)
	AS:SkinButton(AdventureMapQuestChoiceDialog.DeclineButton)

	AS:UnregisterSkinEvent(addon, event)
end

function AS:Blizzard_ChallengesUI(event, addon)
	if addon ~= 'Blizzard_ChallengesUI' then return end

	AS:StripTextures(ChallengesFrameInset, true)

	AS:UnregisterSkinEvent(addon, event)
end

function AS:Blizzard_RaidUI(event, addon)
	if event == 'PLAYER_ENTERING_WORLD' then
		AS:SkinFrame(RaidInfoFrame)
		AS:SkinScrollBar(RaidInfoScrollFrameScrollBar)
		AS:SkinCloseButton(RaidInfoCloseButton)

		AS:StripTextures(RaidInfoInstanceLabel)
		AS:StripTextures(RaidInfoIDLabel)
		AS:SkinButton(RaidFrameConvertToRaidButton)
		AS:SkinButton(RaidFrameRaidInfoButton)
		AS:SkinCheckBox(RaidFrameAllAssistCheckButton)
	end

	if addon ~= 'Blizzard_RaidUI' then return end

	for i = 1, 8 do
		AS:SkinFrame(_G["RaidGroup"..i])
		for j = 1, 5 do
			AS:StripTextures(_G["RaidGroup"..i.."Slot"..j])
		end
	end

	for i = 1, 40 do
		AS:SkinFrame(_G["RaidGroupButton"..i], 'Default')
	end

	AS:UnregisterSkinEvent(addon, event)
end

AS:RegisterSkin('Blizzard_AdventureMap', AS.Blizzard_AdventureMap, 'ADDON_LOADED')
AS:RegisterSkin("Blizzard_ChallengesUI", AS.Blizzard_ChallengesUI, 'ADDON_LOADED')
AS:RegisterSkin("Blizzard_RaidUI", AS.Blizzard_RaidUI, 'ADDON_LOADED')
