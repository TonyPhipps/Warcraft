local addonName, addonTable = ... 
local frame = CreateFrame("Frame")

-- EVENTS

frame:RegisterEvent("ADDON_LOADED")

local function Setup()
	
	frame:RegisterEvent("GOSSIP_SHOW")
	frame:RegisterEvent("QUEST_DETAIL")
	frame:RegisterEvent("QUEST_GREETING")
	frame:RegisterEvent("QUEST_COMPLETE")
	frame:RegisterEvent("QUEST_FINISHED")
	frame:RegisterEvent("QUEST_PROGRESS")
	frame:RegisterEvent("ITEM_TEXT_READY")

end

-- FUNCTIONS

local function ResizeFrame(thisFrame)
	
	thisFrame:ClearAllPoints()
	thisFrame:SetPoint("TOPLEFT", 13, -13)
	thisFrame:SetScale(addonTable.db.GOSSIP_SCALE)

end

local function PrintGossip()

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

	if ItemTextFrame:IsShown() then
		DEFAULT_CHAT_FRAME:AddMessage(ItemTextFrame.TitleText:GetText() .. ' says, "' .. ItemTextGetText() .. '"', "MONSTER_SAY")
	end
end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then
		
		addonTable.db = daftUITweaksDB
		
        if addonTable.db.ENABLE_GOSSIP then
            
			Setup()
			
			if addonTable.db.GOSSIP_TOCHAT then
		
				frame:SetScript("OnEvent", function(self, event, ...)
		
					if event == "GOSSIP_SHOW"
					or event == "QUEST_DETAIL"
					or event == "QUEST_COMPLETE"
					or event == "QUEST_FINISHED"
					or event == "QUEST_GREETING"
					or event == "QUEST_PROGRESS"
					or event == "ITEM_TEXT_READY" then
		
						PrintGossip()
					end
				end)
			end

			GossipFrame:HookScript("OnShow", function(self, event)
				ResizeFrame(self)
			end)
		
			if addonTable.db.GOSSIP_QUEST then
				
				QuestFrame:HookScript("OnShow", function(self, event)
					ResizeFrame(self)
				end)
		
				QuestLogPopupDetailFrame:HookScript("OnShow", function(self, event)
					ResizeFrame(self)
				end)
			end
		
			if addonTable.db.GOSSIP_BOOKS then
				ItemTextFrame:HookScript("OnShow", function(self)
					ResizeFrame(self)
				end)
			end
		
			if addonTable.db.GOSSIP_MERCHANT then
					
				MerchantFrame:HookScript("OnShow", function(self)
					ResizeFrame(self)
				end)
			end
		end
		
		frame:UnregisterEvent("ADDON_LOADED")
	end
end)
