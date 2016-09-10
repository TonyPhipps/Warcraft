local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");

local point1, relativeTo1, relativePoint1, xOffset1, yOffset1 = "CENTER", MainMenuBar, "CENTER", -254, 58;
local point2, relativeTo2, relativePoint2, xOffset2, yOffset2 = "CENTER", MainMenuBar, "CENTER", 258, 58;
local point3, relativeTo3, relativePoint3, xOffset3, yOffset3 = "CENTER", MainMenuBar, "CENTER", 258, -4;


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


---- FUNCTIONS ----


function addon:MoveMultiBarBottomRight()
	MultiBarBottomRight:ClearAllPoints();	
	
	if addonTable.BOTTOM_RIGHT_BAR == 1 then
		MultiBarBottomRight:SetPoint(point1, relativeTo1, relativePoint1, xOffset1, yOffset1);
	elseif addonTable.BOTTOM_RIGHT_BAR == 2 then
		MultiBarBottomRight:SetPoint(point2, relativeTo2, relativePoint2, xOffset2, yOffset2);
	elseif addonTable.BOTTOM_RIGHT_BAR == 3 then
		MultiBarBottomRight:SetPoint(point3, relativeTo3, relativePoint3, xOffset3, yOffset3);
	else end;
end;


function addon:MoveMultiBarBottomLeft()
	MultiBarBottomLeft:ClearAllPoints();
	
	if addonTable.BOTTOM_LEFT_BAR == 1 then
		MultiBarBottomLeft:SetPoint(point1, relativeTo1, relativePoint1, xOffset1, yOffset1);
	elseif addonTable.BOTTOM_LEFT_BAR == 2 then
		MultiBarBottomLeft:SetPoint(point2, relativeTo2, relativePoint2, xOffset2, yOffset2);
	elseif addonTable.BOTTOM_LEFT_BAR == 3 then
		MultiBarBottomLeft:SetPoint(point3, relativeTo3, relativePoint3, xOffset3, yOffset3);
	else end;
	MultiBarBottomLeft.SetPoint = function() end;
end;


function addon:MovePetActionBarFrame()
	PetActionBarFrame:ClearAllPoints();
	
	if addonTable.PET_BAR == 1 then
		PetActionBarFrame:SetPoint(point1, relativeTo1, relativePoint1, xOffset1 + 30, yOffset1);
	elseif addonTable.PET_BAR == 2 then
		PetActionBarFrame:SetPoint(point2, relativeTo2, relativePoint2, xOffset2 + 30, yOffset2);
	elseif addonTable.PET_BAR == 3 then
		PetActionBarFrame:SetScale(1.2);
		PetActionBarFrame:SetPoint(point3, relativeTo3, relativePoint3, xOffset3 - 15, yOffset3 + 5);
		MainMenuBarTexture2:SetTexture(CharacterFrameInsetRightBg:GetTexture());
		MainMenuBarTexture2:SetTexCoord(CharacterFrameInsetRightBg:GetTexCoord());
		MainMenuBarTexture3:SetTexture(CharacterFrameInsetRightBg:GetTexture());
		MainMenuBarTexture3:SetTexCoord(CharacterFrameInsetRightBg:GetTexCoord());
	else end;
	PetActionBarFrame.SetPoint = function() end;
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
		
		addon.MoveMultiBarBottomRight();
		addon.MoveMultiBarBottomLeft();
		addon.MovePetActionBarFrame();
		
		
		-- Scale MainMenuBar
		MainMenuBar:SetScale(addonTable.MAIN_BAR_SCALE);
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

