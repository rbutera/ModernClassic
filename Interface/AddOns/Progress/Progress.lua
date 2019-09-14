SLASH_PROGRESS1 = "/progress"

XPPerLevel = { 	400, 900, 1400, 2100, 2800, 3600, 4500, 5400, 6500, 7600, 8800, 10100, 11400, 12900, 14400, 16000, 17700, 19400, 21300, 23200, 25200, 27300, 29400, 31700, 34000, 36400, 38900, 41400, 44300, 47400, 50800, 54500, 58600, 62800, 67100, 71600, 76100, 80800, 85700, 90700, 95800, 101000, 106300, 111800, 117500, 123200, 129100, 135100, 141200, 147500, 153900, 160400, 167100, 173900, 180800, 187900, 195000, 202300, 209800 };

XPTo60 = 4084700;
lastPercent = 0;

Milestones = { 0.1, 0.5, 1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 96, 97, 98, 99, 100 };



local frame = CreateFrame("Frame");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
frame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" or event == "CHAT_MSG_COMBAT_XP_GAIN" then 
		calculateProgress(false);
	end 
end
)

SlashCmdList["PROGRESS"] = function(msg)
	calculateProgress(true);
end 


function calculateProgress(show) 
	totalXpSoFar = 0;
	if (UnitLevel("player") >= 60) then
		print("100% grats!");
	 else 
		for i=2, UnitLevel("player") do
			totalXpSoFar = totalXpSoFar + XPPerLevel[i-1];
		end
		totalXpSoFar = totalXpSoFar + UnitXP("player");
		Percent = 100 * totalXpSoFar / XPTo60;
		if show then print("Progress: " .. string.format("%0.3f", Percent) .. "% of the XP needed to reach level 60!"); end
		
		--for i=1, table.getn(Milestones) do
		for i=1, 100 do
			--if (lastPercent ~= 0 and lastPercent < Milestones[i] and Percent >= Milestones[i]) then
			if (lastPercent ~= 0 and lastPercent < i and Percent >= i) then
				print("Progress: Congratulations on reaching " .. string.format("%0.3f", i) .. "% of the XP needed to reach level 60!");
				PlaySoundFile("Sound/Spells/LevelUp.ogg");
			end 
		end
		
		lastPercent = Percent;
		
	end
end
	