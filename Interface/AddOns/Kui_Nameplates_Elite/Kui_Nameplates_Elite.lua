local addon = KuiNameplates
local mod = addon:NewPlugin('Elite')

function mod:Show(frame)
	local levelText = frame.LevelText:GetText() or ""

	if UnitIsPlayer(frame.unit) then
		frame.LevelText:SetText(levelText .. ' Player')
		return
	end

	if levelText:sub(-2) == "r+" then
		frame.LevelText:SetText(levelText:sub(1, -3) .. ' Rare Elite')
		return
	end

	if levelText:sub(-1) == "+" then
		frame.LevelText:SetText(levelText:sub(1, -2) .. ' Elite')
		return
	end

	if levelText:sub(-1) == "r" then
		frame.LevelText:SetText(levelText:sub(1, -2) .. ' Rare')
		return
	end
end

function mod:OnEnable()
    self:RegisterMessage('Show')
end
