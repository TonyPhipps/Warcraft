local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");
local NoTexture = CreateFrame("Frame", nil);

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

function addon:ScaleFrames(frames, scale)
		
	for i, frame in next, frames do
		local thisFrame = _G[frame];
		thisFrame:SetScale(scale);
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

function addon:ResizeMainBar()
	for _, texture in next, {
	MainMenuBarTexture2, MainMenuBarTexture3,
	MainMenuBarPageNumber, ActionBarUpButton, ActionBarDownButton, 						--button of Bar Number, up, down
	StanceBarLeft, StanceBarMiddle, StanceBarRight, } do								--BG of Stance
		texture:SetParent(NoTexture);
		NoTexture:Hide();
	end;
	
	for _, bar in next, {
	MainMenuBar, MainMenuBarArtFrame, 
	MainMenuExpBar, MainMenuBarMaxLevelBar,
	ReputationWatchBar, ReputationWatchBar.StatusBar,
	HonorWatchBar, HonorWatchBar.StatusBar,
	ArtifactWatchBar, ArtifactWatchBar.StatusBar,}  do
		bar:SetWidth(bar:GetWidth()/2);
	end;
	
	for i = 10,19 do
		_G["MainMenuXPBarDiv"..i]:SetParent(NoTexture);
	end;
	
	ReputationWatchBar.StatusBar.WatchBarTexture0:SetWidth(128);
	ReputationWatchBar.StatusBar.WatchBarTexture1:SetWidth(128);
	ReputationWatchBar.StatusBar.WatchBarTexture2:SetWidth(128);
	ReputationWatchBar.StatusBar.WatchBarTexture3:SetWidth(128);

	ArtifactWatchBar.StatusBar.WatchBarTexture0:SetWidth(128);
	ArtifactWatchBar.StatusBar.WatchBarTexture1:SetWidth(128);
	ArtifactWatchBar.StatusBar.WatchBarTexture2:SetWidth(128);
	ArtifactWatchBar.StatusBar.WatchBarTexture3:SetWidth(128);

	HonorWatchBar.StatusBar.WatchBarTexture0:SetWidth(128);
	HonorWatchBar.StatusBar.WatchBarTexture1:SetWidth(128);
	HonorWatchBar.StatusBar.WatchBarTexture2:SetWidth(128);
	HonorWatchBar.StatusBar.WatchBarTexture3:SetWidth(128);

	ReputationWatchBar.StatusBar.XPBarTexture0:SetWidth(128);
	ReputationWatchBar.StatusBar.XPBarTexture1:SetWidth(128);
	ReputationWatchBar.StatusBar.XPBarTexture2:SetWidth(128);
	ReputationWatchBar.StatusBar.XPBarTexture3:SetWidth(128);

	ArtifactWatchBar.StatusBar.XPBarTexture0:SetWidth(128);
	ArtifactWatchBar.StatusBar.XPBarTexture1:SetWidth(128);
	ArtifactWatchBar.StatusBar.XPBarTexture2:SetWidth(128);
	ArtifactWatchBar.StatusBar.XPBarTexture3:SetWidth(128);

	HonorWatchBar.StatusBar.XPBarTexture0:SetWidth(128);
	HonorWatchBar.StatusBar.XPBarTexture1:SetWidth(128);
	HonorWatchBar.StatusBar.XPBarTexture2:SetWidth(128);
	HonorWatchBar.StatusBar.XPBarTexture3:SetWidth(128);

	MainMenuBar:ClearAllPoints();
	MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 0);
	MainMenuBar.SetPoint = function() end;
	
	MainMenuBarTexture0:ClearAllPoints();
	MainMenuBarTexture0:SetPoint("RIGHT", MainMenuBar, "CENTER", 0, -4);
	MainMenuBarTexture0.SetPoint = function() end;
	
	MainMenuBarTexture1:ClearAllPoints();
	MainMenuBarTexture1:SetPoint("LEFT", MainMenuBar, "CENTER", 0, -4);
	MainMenuBarTexture1.SetPoint = function() end;
	
	MainMenuBarLeftEndCap:ClearAllPoints();
	MainMenuBarLeftEndCap:SetPoint("BOTTOMRIGHT", MainMenuBar, "BOTTOMLEFT", 40, 0);
	MainMenuBarLeftEndCap.SetPoint = function() end;
	
	MainMenuBarRightEndCap:ClearAllPoints();
	MainMenuBarRightEndCap:SetPoint("BOTTOMLEFT", MainMenuBar, "BOTTOMRIGHT", -40, 0);
	MainMenuBarRightEndCap.SetPoint = function() end;
end;


function addon:MoveBarFrames()
	
	MultiBarBottomLeft:ClearAllPoints();
	MultiBarBottomLeft:SetPoint("BOTTOM", ReputationWatchBar, "TOP", 0, 5);
	MultiBarBottomLeft.SetPoint = function() end;
	
	MultiBarBottomRight:ClearAllPoints();
	MultiBarBottomRight:SetPoint("BOTTOM", MultiBarBottomLeft, "TOP", 0, 5);
	MultiBarBottomRight.SetPoint = function() end;
	
	
	MultiBarRight:ClearAllPoints();
	MultiBarRight:SetPoint("RIGHT", WorldFrame, "RIGHT", 0, 0);
	MultiBarRight.SetPoint = function() end;

	
	if StanceBarFrame:IsShown() then
		StanceBarFrame:ClearAllPoints();
		
		if MultiBarBottomRight:IsShown() then	
			StanceBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomRight, "TOPLEFT", -10, 5);
		
		elseif MultiBarBottomLeft:IsShown() then
			StanceBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "TOPLEFT", -10, 5);
		
		else
			StanceBarFrame:SetPoint("BOTTOMLEFT", ReputationWatchBar, "TOPLEFT", -10, 5);
		end;
		
		
		StanceBarFrame.SetPoint = function() end;
	end;
	
	if PetActionBarFrame:IsShown() then	
		PetActionBarFrame:ClearAllPoints();
		
		if MultiBarBottomRight:IsShown() then	
			PetActionBarFrame:SetPoint("BOTTOMRIGHT", MultiBarBottomRight, "TOPRIGHT", 100, 5);
		
		elseif MultiBarBottomLeft:IsShown() then
			PetActionBarFrame:SetPoint("BOTTOMRIGHT", MultiBarBottomLeft, "TOPRIGHT", 100, 5);
		
		else
			PetActionBarFrame:SetPoint("BOTTOMRIGHT", ReputationWatchBar, "TOPRIGHT", 0, 5);
		end;
		
		PetActionBarFrame.SetPoint = function() end;
		PetActionBarFrame:SetScale(.8);
	end;
end;


function addon.HideBlizzardArt()
	NoTexture:Hide();
	
	MainMenuBarLeftEndCap:SetParent(NoTexture);
	MainMenuBarRightEndCap:SetParent(NoTexture);
	
	for i = 0,3  do
		_G["MainMenuBarTexture"..i]:SetParent(NoTexture);
		_G["MainMenuMaxLevelBar"..i]:SetParent(NoTexture);
		ReputationWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(NoTexture);
		ArtifactWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(NoTexture);
		HonorWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(NoTexture);
		ReputationWatchBar.StatusBar["XPBarTexture"..i]:SetParent(NoTexture);
		ArtifactWatchBar.StatusBar["XPBarTexture"..i]:SetParent(NoTexture);
		HonorWatchBar.StatusBar["XPBarTexture"..i]:SetParent(NoTexture);
	end;
	
	for i = 1,2  do
		_G["PossessBackground"..i]:SetParent(NoTexture);
	end;
	
	for i = 0,1  do
		_G["SlidingActionBarTexture"..i]:SetParent(NoTexture);
	end;
	
	for i = 1,19 do
		_G["MainMenuXPBarDiv"..i]:SetParent(NoTexture);
	end;
	
	for _, texture in next, {
	MainMenuBarPageNumber, ActionBarUpButton, ActionBarDownButton, 						--button of Bar Number, up, down
	MainMenuXPBarTextureLeftCap, MainMenuXPBarTextureRightCap, MainMenuXPBarTextureMid, --Art between xp and bar1	
	StanceBarLeft, StanceBarMiddle, StanceBarRight, } do								--BG of Stance
		texture:SetParent(NoTexture);
	end;
end;


---- MAIN ----

function addon.Main()

	if addonTable.HIDE_GRYPHONS then
		MainMenuBarLeftEndCap:SetParent(NoTexture);
		MainMenuBarRightEndCap:SetParent(NoTexture);
		NoTexture:Hide();
	end;
	
	if addonTable.HIDE_ART then
		addon.HideBlizzardArt();
	end;
	
	addon:MoveBarFrames();
	addon:ResizeMainBar();
	
	-- Scale MainMenuBar
	MainMenuBar:SetScale(addonTable.MAIN_BAR_SCALE);

	-- Main Menu
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("TOPLEFT", ReputationWatchBar, "TOPLEFT", 0, 30);
	addon:ScaleFrames(menuButtons, .7);
	addon:FadeFrames(menuButtons);

	-- Bags
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("TOPRIGHT", ReputationWatchBar, "TOPRIGHT", 0, 0);
	addon:ScaleFrames(bagButtons, .7);
	addon:FadeFrames(bagButtons);
end;


---- SCRIPTS ----

addon:SetScript("OnEvent", function(self, event, ...) 

	if event == "PLAYER_ENTERING_WORLD" then
		addon.Main();
	end;
end);
