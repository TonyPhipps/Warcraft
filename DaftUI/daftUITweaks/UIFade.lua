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

local function HideFunction(fadeInfo)

	local frame = CreateFrame("Frame")

	frame:SetScript("OnUpdate", function(self)
		
		if not InCombatLockdown() and UIParent:GetAlpha() == addonTable.db.UIFADE_OUT then
			
			if addonTable.db.UIFADE_NAMES then
				for _, CVar in pairs(NameCVarArray) do
			
					SetCVar(CVar, 0)
				end
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

			self:SetScript("OnUpdate", nil)
	end)
end

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
			ShowFunction()
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
				
				local fadeInfo = {}
				fadeInfo.mode = "IN"
				fadeInfo.startAlpha = UIParent:GetAlpha()
				fadeInfo.timeToFade = 0.5
				fadeInfo.endAlpha = addonTable.db.UIFADE_IN
				fadeInfo.finishedFunc = ShowFunction()
				UIFrameFade(UIParent, fadeInfo)

				if IsInGroup(Party) and not IsInGroup(Raid) then
					for i = 1, 5 do
						_G["CompactPartyFrameMember"..i.."Background"]:SetAlpha(addonTable.db.UIFADE_IN)
					end
	
				elseif IsInGroup(Raid) and GetNumGroupMembers()>5 then
					for i = 1, floor(GetNumGroupMembers()/5 + 0.9) do	
						for j = 1, 5 do
							_G["CompactRaidGroup"..i.."Member"..j.."Background"]:SetAlpha(addonTable.db.UIFADE_IN)
						end
					end
				end
			else

				local fadeInfo = {}
				fadeInfo.mode = "OUT"
				fadeInfo.startAlpha = UIParent:GetAlpha()
				fadeInfo.timeToFade = 3.0
				fadeInfo.endAlpha = addonTable.db.UIFADE_OUT
				fadeInfo.finishedFunc = HideFunction(fadeInfo)
				UIFrameFade(UIParent, fadeInfo)
				
				if IsInGroup(Party) then
					for i = 1, 5 do
						UIFrameFade(_G["CompactPartyFrameMember"..i.."Background"], fadeInfo)
					end
				end
	
				if IsInGroup(Raid) then
					for i = 1, floor(GetNumGroupMembers()/5 + 0.9) do
						for j = 1, 5 do
							UIFrameFade(_G["CompactRaidGroup"..i.."Member"..j.."Background"], fadeInfo)
						end
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

