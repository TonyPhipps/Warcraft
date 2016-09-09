local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");

addon:RegisterEvent("PLAYER_ENTERING_WORLD");

local menuButtons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"CollectionsMicroButton",
	"EJMicroButton",
	"StoreMicroButton",
	"MainMenuMicroButton",
};
		
local bagButtons = {
	"MainMenuBarBackpackButton",
	"CharacterBag0Slot",
	"CharacterBag1Slot",
	"CharacterBag2Slot",
	"CharacterBag3Slot",
};

---- HELPER FUNCTIONS ----

function addon:SetAllScriptsToHide(frame)
	local scripts = {
		"OnShow",
		"OnHide",
		"OnEvent",
		"OnEnter",
		"OnLeave",
		"OnUpdate",
		"OnValueChanged",
		"OnClick",
		"OnMouseDown",
		"OnMouseUp"
	};
	
	for i, script in next, scripts do
		frame:Hide();
		
		if frame:HasScript(script) then
			frame:SetScript(script, function()
				frame:Hide();
			end);
		end;
	end;
end;


function addon:FadeFramesIn(frames)
	for i, frame in next, frames do
		local thisFrame = _G[frame];
		
		if thisFrame:IsShown() then
			UIFrameFadeIn(thisFrame, .5, thisFrame:GetAlpha(), 1);
		end;
	end;
end;


function addon:FadeFramesOut(frames)
	for i, frame in next, frames do
		local thisFrame = _G[frame];
		
		if thisFrame:IsShown() then
			UIFrameFadeOut(thisFrame, .5, thisFrame:GetAlpha(), 0);
		end;
	end;
end;


function addon:ScaleFrames(frames, scale)
		
	for i, frame in next, frames do
		local thisFrame = _G[frame];
		thisFrame:SetScale(scale);
	end;
end;


function addon:FadeFrames(frames)
	
	for i, frame in next, frames do
		local thisFrame = _G[frame];
		
		thisFrame:HookScript("OnEnter", function()
			addon:FadeFramesIn(frames);
		end);

		WorldFrame:HookScript("OnEnter", function()
			addon:FadeFramesOut(frames);
		end);
	end;
end;

---- MAIN ----

addon:SetScript("OnEvent", function(self, event, ...) 

	if event == "PLAYER_ENTERING_WORLD" then
		
		if addonTable.HIDE_GRYPHONS then
			MainMenuBarLeftEndCap:Hide();
			MainMenuBarRightEndCap:Hide();
		end;
		
		if addonTable.HIDE_ICON_BGS then
			MainMenuBarTexture0:Hide();
			MainMenuBarTexture1:Hide();
			MainMenuBarTexture2:Hide();
			MainMenuBarTexture3:Hide();
		end;
	end;
end);

---- Prepare menu/bar area for action bar
MainMenuBarTexture2:SetTexture(MainMenuBarTexture0:GetTexture());
MainMenuBarTexture2:SetTexCoord(MainMenuBarTexture0:GetTexCoord());
MainMenuBarTexture3:SetTexture(MainMenuBarTexture1:GetTexture());
MainMenuBarTexture3:SetTexCoord(MainMenuBarTexture1:GetTexCoord());


-- Hide pager
addon:SetAllScriptsToHide(ActionBarUpButton);
addon:SetAllScriptsToHide(ActionBarDownButton);
MainMenuBarPageNumber:Hide();


-- Main Menu
CharacterMicroButton:ClearAllPoints();
CharacterMicroButton:SetPoint("TOPLEFT", ReputationWatchBar, "TOPLEFT", 50, 30);
addon:ScaleFrames(menuButtons, .7);
addon:FadeFrames(menuButtons);


-- Bags
MainMenuBarBackpackButton:ClearAllPoints();
MainMenuBarBackpackButton:SetPoint("TOPRIGHT", ReputationWatchBar, "TOPRIGHT", -50, 0);
addon:ScaleFrames(bagButtons, .7);
addon:FadeFrames(bagButtons);


-- Move MultiBarBottomRight
MultiBarBottomRight:ClearAllPoints();
MultiBarBottomRight:SetPoint("BOTTOMLEFT", MainMenuBar, "BOTTOM", 6, 4);


-- Move PetActionBarFrame to the old MultiBarBottomRight spot
PetActionBarFrame:ClearAllPoints();
PetActionBarFrame:SetPoint("BOTTOMLEFT", MainMenuBar, "BOTTOM", 30, 65);
PetActionBarFrame.SetPoint = function() end;






