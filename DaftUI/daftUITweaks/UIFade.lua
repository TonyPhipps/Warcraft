local addonName, addonTable = ...
local addon = CreateFrame("Frame")

addon:SetScript("OnUpdate", function()

	if UnitAffectingCombat("Player") -- UIFrameFadeIn causes access violation in combat
	or InCombatLockdown() then
		UIParent:SetAlpha(addonTable.FADEIN)
		return
	end
	
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
		if not CinematicFrame:IsShown() then
			UIFrameFadeIn(UIParent, addonTable.TIMETOFADEIN, UIParent:GetAlpha(), addonTable.FADEIN)
		end
	else
		if not CinematicFrame:IsShown() then
			UIFrameFadeOut(UIParent, addonTable.TIMETOFADEOUT, UIParent:GetAlpha(), addonTable.FADEOUT)
		end
	end
end)