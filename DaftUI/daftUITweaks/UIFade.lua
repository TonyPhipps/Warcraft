local addonName, addonTable = ...
local frame = CreateFrame("Frame")

-- EVENTS

frame:RegisterEvent("ADDON_LOADED")

-- FUNCTIONS

local function FadeUI()

	if addonTable.db.ENABLE_UIFADE then

		if UnitAffectingCombat("Player") -- UIFrameFadeIn causes access violation in combat
		or InCombatLockdown() then
			UIParent:SetAlpha(addonTable.db.UIFADE_IN)
			return
		else
		
			MouseFrame = false
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
			or QuestLogPopupDetailFrame:IsShown()
			or GameTooltipTextLeft1:GetText()
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
				if not CinematicFrame:IsShown() and not MovieFrame:IsShown() then
					UIFrameFadeIn(UIParent, 0.5, UIParent:GetAlpha(), addonTable.db.UIFADE_IN)
				end
			else
				if not CinematicFrame:IsShown() and not MovieFrame:IsShown() then
					UIFrameFadeOut(UIParent, 5, UIParent:GetAlpha(), addonTable.db.UIFADE_OUT)
				end
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
	
			FadeUI()
		end)

		frame:UnregisterEvent("ADDON_LOADED")
	end
end)

