local addonName, addonTable = ...
local frame = CreateFrame("Frame")

-- EVENTS

frame:RegisterEvent("ADDON_LOADED")

-- FUNCTIONS

local NameCVarArray = {
	"UnitNameEnemyGuardianName",
	"UnitNameEnemyPetName",
	"UnitNameEnemyPlayerName",
	"UnitNameEnemyTotemName",
	"UnitNameFriendlyGuardianName",
	"UnitNameFriendlyPetName",
	"UnitNameFriendlyPlayerName",
	"UnitNameFriendlySpecialNPCName",
	"UnitNameFriendlyTotemName",
	"UnitNameHostleNPC",
	"UnitNameInteractiveNPC",
	"UnitNameNPC",
	"UnitNameNonCombatCreatureName"
}

local FrameArray = {
	"ChatFrame1EditBox",
	"WorldMapFrame",
	"MailFrame",
	"GossipFrame",
	"GameMenuFrame",
	"StaticPopup1",
	"LFGDungeonReadyPopup",
	"LFDRoleCheckPopup",
	"RolePollPopup",
	"ReadyCheckFrame",
	"BonusRollFrame",
	"QuestFrame",
	"ItemTextFrame",
	"GameTooltip",
	"RaidWarningFrame",
	"SpellBookFrame",
	"SettingsPanel",
	"TargetFrame"
}

local function FadeUI()

	ProtectedFrameShown = false
	
	if IsAddOnLoaded("Blizzard_Communities")
	and not ProtectedFrameShown then
		ProtectedFrameShown = AddCommunitiesFlow_IsShown()
	end
	
	if not CinematicFrame:IsShown() 
	and not MovieFrame:IsShown()
	and addonTable.db.ENABLE_UIFADE then

		if UnitAffectingCombat("Player")
		or InCombatLockdown() then
			
			UIParent:SetAlpha(addonTable.db.UIFADE_IN)
			return
		else
		
			local MouseFrame = false
			
			if GetMouseFocus() 
			and not ProtectedFrameShown
			and not StoreFrame_IsShown()
			then
				MouseFrame = GetMouseFocus():GetName()
			end

			local WatchedFrameShowing = false
			
			for _, Frame in pairs(FrameArray) do
				if _G[Frame]:IsShown() then
					WatchedFrameShowing = true
				end
			end
			
			if WatchedFrameShowing == true
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
				
				UIFrameFadeIn(UIParent, UIParent:GetAlpha(), UIParent:GetAlpha(), addonTable.db.UIFADE_IN);
				
				if addonTable.db.UIFADE_NAMES then
					for _, CVar in pairs(NameCVarArray) do
				
						SetCVar(CVar, 1)
					end
				end
				
			else

				UIFrameFadeOut(UIParent, UIParent:GetAlpha(), UIParent:GetAlpha(), addonTable.db.UIFADE_OUT);
				
				if addonTable.db.UIFADE_NAMES then
					for _, CVar in pairs(NameCVarArray) do
						SetCVar(CVar, 0)
					end
				end
			end
		end
	end
end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then

		addonTable.db = _G.daftUITweaksDB
		
		frame:RegisterEvent("PLAYER_REGEN_DISABLED")
		frame:SetScript("OnUpdate", FadeUI)

		frame:UnregisterEvent("ADDON_LOADED")
	
	elseif event == "PLAYER_REGEN_DISABLED" then
					
		FadeUI()
	end
end)

