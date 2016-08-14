SCALE = 2.0

local daftBigGossiper = CreateFrame("Frame")

daftBigGossiper:RegisterEvent("GOSSIP_SHOW")
daftBigGossiper:RegisterEvent("GOSSIP_CLOSED")
daftBigGossiper:RegisterEvent("QUEST_DETAIL")
daftBigGossiper:RegisterEvent("QUEST_COMPLETE")
daftBigGossiper:RegisterEvent("QUEST_FINISHED")
daftBigGossiper:RegisterEvent("QUEST_PROGRESS")

daftBigGossiper:SetScript("OnEvent", function()

	QuestFrame:SetScale(2)
	QuestFrame:SetPoint("TOPLEFT",13,-13)

	GossipFrame:SetScale(2)
	GossipFrame:SetPoint("TOPLEFT",13,-13)
		
end)



