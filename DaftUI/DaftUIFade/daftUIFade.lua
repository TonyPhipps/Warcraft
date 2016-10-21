local addonName, addonTable = ... ;
 
local addon = CreateFrame("Frame");
 
 
function addon:FadeIn()
	UIFrameFadeIn(UIParent, addonTable.TIMETOFADEIN, UIParent:GetAlpha(), addonTable.FADEIN);
end;

function addon:FadeOut()
	UIFrameFadeOut(UIParent, addonTable.TIMETOFADEOUT, UIParent:GetAlpha(), addonTable.FADEOUT);
end;


addon:SetScript("OnUpdate", function()
 
	if GetMouseFocus() then
		if GetMouseFocus():GetName() ~= "WorldFrame" then
			addon:FadeIn();
		else
			addon:FadeOut();
		end;
	end;

	if UnitAffectingCombat("Player")
	or InCombatLockdown()
	or ChatFrame1EditBox:IsShown()
	or WorldMapFrame:IsShown()
	or MailFrame:IsShown()
	or GossipFrame:IsShown()
	or GameTooltipTextLeft1:GetText()
	or UnitCastingInfo("Player")
	or UnitChannelInfo("Player")
	or UnitExists("Target") then
		addon:FadeIn();
	end;
end);