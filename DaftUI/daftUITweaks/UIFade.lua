local addonName, addonTable = ...
local frame = CreateFrame("Frame")

-- EVENTS

frame:RegisterEvent("ADDON_LOADED")

-- FUNCTIONS

local function FadeUI()

	if not CinematicFrame:IsShown() 
	and not MovieFrame:IsShown() then

		if UnitAffectingCombat("Player")
		or InCombatLockdown() then
			UIParent:SetAlpha(addonTable.db.UIFADE_IN)
			return
		else
		
			local MouseFrame = false
			
			if GetMouseFocus() then
				
				MouseFrame = GetMouseFocus():GetName()
			end
			
			if ChatFrame1EditBox:IsShown()
			or WorldMapFrame:IsShown()
			or MailFrame:IsShown()
			or GossipFrame:IsShown()
			or GameMenuFrame:IsShown()
			or StaticPopup1:IsShown()
			or MirrorTimer1:IsShown()
			or LFGDungeonReadyPopup:IsShown()
			or LFDRoleCheckPopup:IsShown()
			or LevelUpDisplay:IsShown()
			or RolePollPopup:IsShown()
			or ReadyCheckFrame:IsShown()
			or BonusRollFrame:IsShown()
			or QuestFrame:IsShown()
			or TalkingHeadFrame:IsShown()
			or InterfaceOptionsFrame:IsShown()
			or GameTooltip:IsShown()
			or RaidWarningFrame:IsShown()
			or SubZoneTextFrame:IsShown()
			or UnitCastingInfo("Player")
			or UnitCastingInfo("Vehicle")
			or UnitChannelInfo("Player")
			or UnitChannelInfo("Vehicle")
			or UnitExists("Target")
			or MouseIsOver(ChatFrame1)
			or MouseIsOver(ChatFrame2)
			or MouseIsOver(ChatFrame3)
			or MouseIsOver(ChatFrame4) 
			or MouseFrame ~= "WorldFrame" then
				
				local fadeInfo = {}
				fadeInfo.mode = "IN"
				fadeInfo.startAlpha = UIParent:GetAlpha()
				fadeInfo.timeToFade = 0.5
				fadeInfo.endAlpha = addonTable.db.UIFADE_IN
				UIFrameFade(UIParent, fadeInfo)
			else

				local fadeInfo = {}
				fadeInfo.mode = "OUT"
				fadeInfo.startAlpha = UIParent:GetAlpha()
				fadeInfo.timeToFade = 3.0
				fadeInfo.endAlpha = addonTable.db.UIFADE_OUT
				UIFrameFade(UIParent, fadeInfo)
			end
		end
	end
	
end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then

		addonTable.db = _G.daftUITweaksDB
		
		frame:RegisterEvent("PLAYER_ENTER_COMBAT")
	
		frame:SetScript("OnEvent", function(self, event)
	
			if event == "PLAYER_ENTER_COMBAT" then
				
				FadeUI()
			end
		end)
	
		frame:SetScript("OnUpdate", function()
			
			if addonTable.db.ENABLE_UIFADE then
				
				FadeUI()
			end
		end)

		frame:UnregisterEvent("ADDON_LOADED")
	end
end)

