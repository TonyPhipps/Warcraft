local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");

addon:RegisterEvent("ADVENTURE_MAP_OPEN");
addon:RegisterEvent("GOSSIP_SHOW");
addon:RegisterEvent("GOSSIP_CLOSED");
addon:RegisterEvent("PLAYER_LOGIN");
addon:RegisterEvent("QUEST_DETAIL");
addon:RegisterEvent("QUEST_COMPLETE");
addon:RegisterEvent("QUEST_FINISHED");
addon:RegisterEvent("QUEST_PROGRESS");
addon:RegisterEvent("MERCHANT_SHOW");
addon:RegisterEvent("ITEM_TEXT_BEGIN");


---- HELPER FUNCTIONS ----

function addon:ResizeFrame(thisFrame)
		--thisFrame:ClearAllPoints();
		thisFrame:SetScale(addonTable.GOSSIP_SCALE);
		thisFrame:SetPoint("TOPLEFT", 13, -13);
		--thisFrame.SetPoint = function() end;
end;


function addon:HookAdventureMapQuest()
	AdventureMapQuestChoiceDialog:HookScript("OnShow", function(self)
		AdventureMapQuestChoiceDialog:SetScale(addonTable.GOSSIP_SCALE);
	end);
end;


---- EVENT HANDLER ----

addon:SetScript("OnEvent", function(self, event, ...)
	
	if addonTable.INCLUDE_QUEST then

	if event == "GOSSIP_SHOW"
		or event == "QUEST_DETAIL"
		or event == "GOSSIP_CLOSED"
		or event == "QUEST_COMPLETE"
		or event == "QUEST_FINISHED"
		or event == "QUEST_PROGRESS" then
			addon:ResizeFrame(QuestFrame);
			addon:ResizeFrame(GossipFrame);
			addon:ResizeFrame(QuestLogPopupDetailFrame);
		end;
		
		if event == "ADVENTURE_MAP_OPEN" then
			addon:HookAdventureMapQuest();
		end;
	end;
	
	
	if addonTable.INCLUDE_MERCHANT then
		if event == "MERCHANT_SHOW" then
			addon:ResizeFrame(MerchantFrame);
		end;
	end;
	
	
	if addonTable.INCLUDE_BOOKS then
		if event == "ITEM_TEXT_BEGIN" then
			addon:ResizeFrame(ItemTextFrame);
		end;
	end;
	
end);



