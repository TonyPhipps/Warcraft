local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

if addonTable.ENABLE_GOSSIP then
	

	-- EVENTS

	addon:RegisterEvent("GOSSIP_SHOW")
	addon:RegisterEvent("QUEST_DETAIL")
	addon:RegisterEvent("QUEST_GREETING")
	addon:RegisterEvent("QUEST_COMPLETE")
	addon:RegisterEvent("QUEST_FINISHED")
	addon:RegisterEvent("QUEST_PROGRESS")


	-- FUNCTIONS

	function addon:ResizeFrame(thisFrame)
			thisFrame:SetScale(addonTable.GOSSIP_SCALE)
			thisFrame:SetPoint("TOPLEFT", 13, -13)
	end

	function PrintGossip()

		if QuestFrame:IsShown() then
			
			if QuestFrameDetailPanel:IsShown() then
				DEFAULT_CHAT_FRAME:AddMessage(QuestFrameNpcNameText:GetText() .. ' says, "' .. QuestInfoDescriptionText:GetText() .. '"' .. " (for " .. QuestInfoTitleHeader:GetText() .. ")", "MONSTER_SAY")
			elseif QuestFrameProgressPanel:IsShown() then
				DEFAULT_CHAT_FRAME:AddMessage(QuestFrameNpcNameText:GetText() .. ' says, "' .. QuestProgressText:GetText() .. '"' .. " (for " .. QuestProgressTitleText:GetText() .. ")", "MONSTER_SAY")
			elseif QuestFrameRewardPanel:IsShown() then
				DEFAULT_CHAT_FRAME:AddMessage(QuestFrameNpcNameText:GetText() .. ' says, "' .. QuestInfoRewardText:GetText() .. '"' .. " (for " .. QuestInfoTitleHeader:GetText() .. ")", "MONSTER_SAY")
			elseif QuestFrameGreetingPanel:IsShown() then
				DEFAULT_CHAT_FRAME:AddMessage(QuestFrameNpcNameText:GetText() .. ' says, "' .. GreetingText:GetText() .. '"', "MONSTER_SAY")
			end
		end

		if GossipFrame:IsShown() then
			DEFAULT_CHAT_FRAME:AddMessage(GossipFrameNpcNameText:GetText() .. ' says, "' .. GossipGreetingText:GetText() .. '"', "MONSTER_SAY")
		end
	end


	-- SCRIPTS

	if addonTable.GOSSIP_TOCHAT then
		
		addon:SetScript("OnEvent", function(self, event, ...)

			if event == "GOSSIP_SHOW"
			or event == "QUEST_DETAIL"
			or event == "GOSSIP_CLOSED"
			or event == "QUEST_COMPLETE"
			or event == "QUEST_FINISHED"
			or event == "QUEST_GREETING"
			or event == "QUEST_PROGRESS" then

				PrintGossip()
			end
		end)
	end

	-- HOOKS

	GossipFrame:HookScript("OnShow", function(self, event)
		addon:ResizeFrame(self)
	end)

	if addonTable.GOSSIP_QUEST then
		
		QuestFrame:HookScript("OnShow", function(self, event)
			addon:ResizeFrame(self)
		end)

		QuestLogPopupDetailFrame:HookScript("OnShow", function(self, event)
			addon:ResizeFrame(self)
		end)
	end

	if addonTable.GOSSIP_BOOKS then
		ItemTextFrame:HookScript("OnShow", function(self)
			addon:ResizeFrame(self)
		end)
	end

	if addonTable.GOSSIP_MERCHANT then
			
		MerchantFrame:HookScript("OnShow", function(self)
			addon:ResizeFrame(self)
		end)
	end
end

