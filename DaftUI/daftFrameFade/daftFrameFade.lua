local addonName, addonTable = ... ;

local addon = CreateFrame("Frame");

addon:RegisterEvent("PLAYER_LOGIN");
addon:RegisterEvent("PLAYER_REGEN_DISABLED");
addon:RegisterEvent("PLAYER_REGEN_ENABLED");
addon:RegisterEvent("PLAYER_FOCUS_CHANGED");
addon:RegisterEvent("PLAYER_TARGET_CHANGED");
addon:RegisterUnitEvent("UNIT_HEALTH");
addon:RegisterUnitEvent("UNIT_POWER_FREQUENT");
addon:RegisterUnitEvent("QUEST_WATCH_LIST_CHANGED");
addon:RegisterUnitEvent("QUEST_WATCH_UPDATE");
addon:RegisterUnitEvent("UNIT_QUEST_LOG_CHANGED");


local TopEdgeHover = CreateFrame("Frame");
TopEdgeHover:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0);
TopEdgeHover:SetSize(UIParent:GetWidth(), 50);
TopEdgeHover:SetFrameStrata("BACKGROUND");
TopEdgeHover:SetScript("OnEnter", function()
	if addonTable.TOP_EDGE_HOVER then
		addon:FadeInAll();
	end;
 end);	

 local CVARS = {
	"UnitNameEnemyGuardianName",
	"UnitNameEnemyMinionName",
	"UnitNameEnemyPetName",
	"UnitNameEnemyPlayerName",
	"UnitNameEnemyTotemName",
	"UnitNameFriendlyGuardianName",
	"UnitNameFriendlyMinionName",	
	"UnitNameFriendlyPetName",
	"UnitNameFriendlyPlayerName",
	"UnitNameFriendlySpecialNPCName",
	"UnitNameFriendlyTotemName",
	"UnitNameHostileNPC",
	"UnitNameInteractiveNPC",
	"UnitNameNPC",
	"UnitNameNonCombatCreatureName"
}

local ParentFrames = { 
	UIParent
};

---- HELPER FUNCTIONS ----

function addon:FadeFrameIn(Frame)

	if UnitAffectingCombat("player") then
		if Frame:IsShown() then
			UIFrameFadeIn(Frame, addonTable.COMBAT_TIMETOFADEIN, Frame:GetAlpha(), addonTable.COMBAT_FADEIN);
		end;
	else
		if Frame:IsShown() then
			UIFrameFadeIn(Frame, addonTable.NOCOMBAT_TIMETOFADEIN, Frame:GetAlpha(), addonTable.NOCOMBAT_FADEIN);
		end;
	end;
end;


function addon:FadeFrameOut(Frame)

	if UnitAffectingCombat("player") or InCombatLockdown() then
		if Frame:IsShown() then
			UIFrameFadeOut(Frame, addonTable.COMBAT_TIMETOFADEOUT, Frame:GetAlpha(), addonTable.COMBAT_FADEOUT);
		end;
	else
		if Frame:IsShown() then
			UIFrameFadeOut(Frame, addonTable.NOCOMBAT_TIMETOFADEOUT, Frame:GetAlpha(), addonTable.NOCOMBAT_FADEOUT);
		end;
	end;
end;


function addon:FadeOutAll()
	php = UnitHealth("player") / UnitHealthMax("player");
	pmp = UnitPower("player") / UnitPowerMax("player");
	
	if UnitExists("target") 
	or UnitIsDead("target")
	or UnitName("target") == UnitName("player") 
	or php < 1 
	or pmp < 1 then
			
	else		
		for _, ParentFrame in ipairs(ParentFrames) do 
			addon:FadeFrameOut(ParentFrame);
		end;

		if addonTable.NAMES then
			for k,v in pairs(CVARS) do
				SetCVar( v, "0" )
			end;
		end;
	end;
end;


function addon:FadeInAll()
	for _, ParentFrame in ipairs(ParentFrames) do 
		addon:FadeFrameIn(ParentFrame);
	end;

	if addonTable.NAMES then
		for k,v in pairs(CVARS) do
			SetCVar( v, "1" )
		end;
	end;
end;


---- FUNCTIONS ----

function addon:HookFrames()
	
	WorldFrame:HookScript("OnEnter", function()
		addon:FadeOutAll();
	end);

	if addonTable.CHATBOX then
		ChatFrame1EditBox:HookScript("OnShow", function()
			addon:FadeInAll();
		end);
	
		ChatFrame1EditBox:HookScript("OnHide", function()
			addon:FadeOutAll();
		end);
	end;

	if addonTable.TOOLTIP then
		GameTooltip:HookScript("OnShow", function()
			addon:FadeInAll();
		end);

		GameTooltip:HookScript("OnHide", function()
			addon:FadeOutAll();
		end);
	end;

	if addonTable.CAST then
		PlayerCastingBarFrame:HookScript("OnShow", function()
			addon:FadeInAll();
		end);

		PlayerCastingBarFrame:HookScript("OnHide", function()
			addon:FadeOutAll();
		end);
	end;
end;


---- MAIN ----

addon:SetScript("OnEvent", function(self, event, ...)

	if event == "PLAYER_LOGIN" then
		addon:HookFrames();
	end;
	
	if event == "PLAYER_LOGIN" 
	or event == "PLAYER_REGEN_DISABLED"
	or event == "PLAYER_REGEN_ENABLED" then
		addon:FadeOutAll();
	end;
	
	if event == "PLAYER_TARGET_CHANGED" then
		if UnitExists("target") 
		or UnitIsDead("target")
		or UnitName("target") == UnitName("player") then
			addon:FadeInAll();
		else
			addon:FadeOutAll();
		end;
	end;
end);


