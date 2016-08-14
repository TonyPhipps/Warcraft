SCALE = 1.75
MERCHANT = true
QUEST = true

local daftBigGossiper = CreateFrame("Frame")

daftBigGossiper:RegisterEvent("GOSSIP_SHOW")
daftBigGossiper:RegisterEvent("GOSSIP_CLOSED")
daftBigGossiper:RegisterEvent("QUEST_DETAIL")
daftBigGossiper:RegisterEvent("QUEST_COMPLETE")
daftBigGossiper:RegisterEvent("QUEST_FINISHED")
daftBigGossiper:RegisterEvent("QUEST_PROGRESS")
daftBigGossiper:RegisterEvent("MERCHANT_SHOW")


daftBigGossiper:SetScript("OnEvent", function()

	if QUEST then
		QuestFrame:SetScale(SCALE)
		QuestFrame:SetPoint("TOPLEFT",13,-13)

		GossipFrame:SetScale(SCALE)
		GossipFrame:SetPoint("TOPLEFT",13,-13)
	end
	
	if MERCHANT then
		MerchantFrame:SetScale(SCALE)
		MerchantFrame:SetPoint("TOPLEFT",13,-13)
	end
end)



