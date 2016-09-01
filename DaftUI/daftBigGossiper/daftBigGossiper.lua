local addonName, addonTable = ... ;
local addonName = CreateFrame("Frame");

addonName:RegisterEvent("GOSSIP_SHOW");
addonName:RegisterEvent("GOSSIP_CLOSED");
addonName:RegisterEvent("QUEST_DETAIL");
addonName:RegisterEvent("QUEST_COMPLETE");
addonName:RegisterEvent("QUEST_FINISHED");
addonName:RegisterEvent("QUEST_PROGRESS");
addonName:RegisterEvent("MERCHANT_SHOW");
addonName:RegisterEvent("ITEM_TEXT_BEGIN");


local function ResizeFrame(thisFrame)
		thisFrame:ClearAllPoints();
		thisFrame:SetScale(addonTable.SCALE);
		thisFrame:SetPoint("TOPLEFT", 13, -13);
		thisFrame.SetPoint = function() end;
end;


addonName:SetScript("OnEvent", function()

	if addonTable.QUEST then
		ResizeFrame(QuestFrame);
		ResizeFrame(GossipFrame);
	end
	
	if addonTable.MERCHANT then
		ResizeFrame(MerchantFrame);
	end;
	
	if addonTable.BOOKS then
		ResizeFrame(ItemTextFrame);
	end;
end);



