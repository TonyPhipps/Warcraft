local addonName, addonTable = ...
local frame = CreateFrame("Frame")

-- EVENTS

frame:RegisterEvent("ADDON_LOADED")

-- FUNCTIONS

local NameCVarArray = {
	"UnitNameFriendlySpecialNPCName",
	"UnitNameInteractiveNPC",
	"UnitNameFriendlyGuardianName",
	"UnitNameFriendlyPetName",
	"UnitNameFriendlyPlayerName",
	"UnitNameFriendlyTotemName",
	"UnitNameNonCombatCreatureName",
	"UnitNameHostleNPC",
	"UnitNameEnemyPlayerName",
	"UnitNameEnemyPetName",
	"UnitNameEnemyGuardianName",
	"UnitNameEnemyTotemName"
}  

local function HideFunction()

	local frame = CreateFrame("Frame")

	frame:SetScript("OnUpdate", function(self)
		
		if not InCombatLockdown() and UIParent:GetAlpha() == addonTable.db.UIFADE_OUT then
			
			if addonTable.db.UIFADE_NAMES then
				for _, CVar in pairs(NameCVarArray) do
			
					SetCVar(CVar, 0)
				end
			end

			if addonTable.db.UIFADE_MINIMAP then
				MinimapCluster:Hide()
			end
		end

		self:SetScript("OnUpdate", nil)
	end)
end

local function ShowFunction()
	
	local frame = CreateFrame("Frame")

	frame:SetScript("OnUpdate", function(self)

			if addonTable.db.UIFADE_NAMES then
				for _, CVar in pairs(NameCVarArray) do
					
					if GetCVar(CVar) == "0" and not InCombatLockdown() then
						SetCVar(CVar, 1)
					end
				end
			end

			for i = 1, 4 do
				_G["CompactPartyFrameMember"..i.."Background"]:SetAlpha(addonTable.db.UIFADE_IN)
			end

			if addonTable.db.UIFADE_MINIMAP then
				MinimapCluster:Show()
			end

			self:SetScript("OnUpdate", nil)
	end)
end

local function FadeUI()

	if not CinematicFrame:IsShown() 
	and not MovieFrame:IsShown() then

		if UnitAffectingCombat("Player")
		or InCombatLockdown() then
			UIParent:SetAlpha(addonTable.db.UIFADE_IN)
			ShowFunction()
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
			or ItemTextFrame:IsShown()
			or TalkingHeadFrame:IsShown()
			or InterfaceOptionsFrame:IsShown()
			or GameTooltip:IsShown()
			or RaidWarningFrame:IsShown()
			or SpellBookFrame:IsShown()
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
				fadeInfo.finishedFunc = ShowFunction()
				UIFrameFade(UIParent, fadeInfo)
			else

				local fadeInfo = {}
				fadeInfo.mode = "OUT"
				fadeInfo.startAlpha = UIParent:GetAlpha()
				fadeInfo.timeToFade = 3.0
				fadeInfo.endAlpha = addonTable.db.UIFADE_OUT
				fadeInfo.finishedFunc = HideFunction()
				UIFrameFade(UIParent, fadeInfo)
				for i = 1, 4 do
					UIFrameFade(_G["CompactPartyFrameMember"..i.."Background"], fadeInfo)
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
			
			if addonTable.db.ENABLE_UIFADE then
				
				FadeUI()
			end
		end)

		frame:UnregisterEvent("ADDON_LOADED")
	end
end)

