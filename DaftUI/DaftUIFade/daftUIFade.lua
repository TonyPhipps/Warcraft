local addonName, addonTable = ... ;
 
local addon = CreateFrame("Frame");
 
function addon:FadeIn()
	UIFrameFadeIn(UIParent, addonTable.TIMETOFADEIN, UIParent:GetAlpha(), addonTable.FADEIN);
end;

function addon:FadeOut()
	UIFrameFadeOut(UIParent, addonTable.TIMETOFADEOUT, UIParent:GetAlpha(), addonTable.FADEOUT);
end;


addon:SetScript("OnUpdate", function()
	
	if UnitAffectingCombat("Player")
	or InCombatLockdown() then
		UIParent:SetAlpha(addonTable.FADEIN); -- UIFrameFadeIn causes access violation in combat
		return;
	end;
	
	
	if ChatFrame1EditBox:IsShown()
	or WorldMapFrame:IsShown()
	or MailFrame:IsShown()
	or GossipFrame:IsShown()
	or GameTooltipTextLeft1:GetText()
	or UnitCastingInfo("Player")
	or UnitChannelInfo("Player")
	or UnitExists("Target")
	or MouseIsOver(ChatFrame1)
	or MouseIsOver(ChatFrame2)
	or MouseIsOver(ChatFrame3)
	or MouseIsOver(ChatFrame4) then
		addon:FadeIn();
		return;
	end;
 
 
	if GetMouseFocus() then
		if GetMouseFocus():GetName() ~= "WorldFrame" then
			addon:FadeIn();
		else
			addon:FadeOut();
		end;
	end;
end);