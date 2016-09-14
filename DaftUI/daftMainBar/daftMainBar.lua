local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");
local HiddenFrame = CreateFrame("Frame", nil);

addon:RegisterEvent("PLAYER_ENTERING_WORLD");
addon:RegisterEvent("PET_UI_UPDATE");


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
		texture:SetParent(HiddenFrame);
		HiddenFrame:Hide();
	end;
	
	for _, bar in next, {
	MainMenuBar, MainMenuBarArtFrame,  --512
	MainMenuExpBar, MainMenuBarMaxLevelBar,
	ReputationWatchBar, ReputationWatchBar.StatusBar,
	HonorWatchBar, HonorWatchBar.StatusBar,
	ArtifactWatchBar, ArtifactWatchBar.StatusBar,}  do
		bar:SetWidth(512);
	end;
	
	for i = 0, 1  do 
		_G["SlidingActionBarTexture"..i]:SetParent(HiddenFrame);
	end;	
	
	for i = 10, 19 do
		_G["MainMenuXPBarDiv"..i]:SetParent(HiddenFrame);
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
	MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, -1);
	MainMenuBar.SetPoint = function() end;
	
	MainMenuBarVehicleLeaveButton:ClearAllPoints();
	MainMenuBar:SetPoint("RIGHT", ActionButton1, "LEFT", -3, 0);
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
	MultiBarBottomLeft:SetPoint("BOTTOMLEFT", MainMenuBar, "TOPLEFT", 0, 15);
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
			StanceBarFrame:SetPoint("BOTTOMLEFT", MainMenuBar, "TOPLEFT", -10, 15);
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
			PetActionBarFrame:SetPoint("BOTTOMRIGHT", MainMenuBar, "TOPRIGHT", 100, 11);
		end;
		
		PetActionBarFrame.SetPoint = function() end;
		PetActionBarFrame:SetScale(.8);
	end;
end;


function addon:MoveMenuBags()
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

	-- Micro Menu
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("BOTTOMLEFT", MainMenuBar, "TOPLEFT", 0, -13);
	addon:ScaleFrames(menuButtons, .7);
	addon:FadeFrames(menuButtons);

	-- Bags
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", MainMenuBar, "TOPRIGHT", 0, -12);
	addon:ScaleFrames(bagButtons, .7);
	addon:FadeFrames(bagButtons);
end;


function addon:HideBlizzardArt()
	HiddenFrame:Hide();
	
	MainMenuBarLeftEndCap:SetParent(HiddenFrame);
	MainMenuBarRightEndCap:SetParent(HiddenFrame);
	
	for i = 0,3  do
		_G["MainMenuBarTexture"..i]:SetParent(HiddenFrame);
		_G["MainMenuMaxLevelBar"..i]:SetParent(HiddenFrame);
		ReputationWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(HiddenFrame);
		ArtifactWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(HiddenFrame);
		HonorWatchBar.StatusBar["WatchBarTexture"..i]:SetParent(HiddenFrame);
		ReputationWatchBar.StatusBar["XPBarTexture"..i]:SetParent(HiddenFrame);
		ArtifactWatchBar.StatusBar["XPBarTexture"..i]:SetParent(HiddenFrame);
		HonorWatchBar.StatusBar["XPBarTexture"..i]:SetParent(HiddenFrame);
	end;
	
	for i = 1,2  do
		_G["PossessBackground"..i]:SetParent(HiddenFrame);
	end;
	
	for i = 0,1  do
		_G["SlidingActionBarTexture"..i]:SetParent(HiddenFrame);
	end;
	
	for i = 1,19 do
		_G["MainMenuXPBarDiv"..i]:SetParent(HiddenFrame);
	end;
	
	for _, texture in next, {
	MainMenuBarPageNumber, ActionBarUpButton, ActionBarDownButton, 						--button of Bar Number, up, down
	MainMenuXPBarTextureLeftCap, MainMenuXPBarTextureRightCap, MainMenuXPBarTextureMid, --Art between xp and bar1	
	StanceBarLeft, StanceBarMiddle, StanceBarRight, } do								--BG of Stance
		texture:SetParent(HiddenFrame);
	end;
end;


function addon:SetFonts()
	ArtifactWatchBar.OverlayFrame.Text:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE', "");
	ArtifactWatchBar.OverlayFrame.Text:SetShadowOffset(0, 0);
	
	if MainMenuExpBar:IsShown() then
		MainMenuBarExpText.OverlayFrame.Text:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE', "");
		MainMenuBarExpText.OverlayFrame.Text:SetShadowOffset(0, 0);
	end;
	
	HonorWatchBar.OverlayFrame.Text:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE', "");
	HonorWatchBar.OverlayFrame.Text:SetShadowOffset(0, 0);
		
	ReputationWatchBar.OverlayFrame.Text:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE', "");
	ReputationWatchBar.OverlayFrame.Text:SetShadowOffset(0, 0);
	
	for i = 1, 12 do
		_G["ActionButton"..i.."HotKey"]:ClearAllPoints();
		_G["ActionButton"..i.."HotKey"]:SetPoint('TOPRIGHT', 0, -3);
		_G["ActionButton"..i.."HotKey"]:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE', "");
		_G["ActionButton"..i.."HotKey"]:SetVertexColor(1, 1, 1);
	end;
	
	for i = 1, 10 do
		_G["PetActionButton"..i.."HotKey"]:ClearAllPoints();
		_G["PetActionButton"..i.."HotKey"]:SetPoint('TOPRIGHT', 0, -3);
		_G["PetActionButton"..i.."HotKey"]:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE', "");
		_G["PetActionButton"..i.."HotKey"]:SetVertexColor(1, 1, 1);
	end;
	
	for _, bar in next, {
	"MultiBarBottomLeft",
	"MultiBarBottomRight",
	"MultiBarLeft",
	"MultiBarRight",} do
		for i = 1, 12 do
		_G[bar.."Button"..i.."HotKey"]:ClearAllPoints();
		_G[bar.."Button"..i.."HotKey"]:SetPoint('TOPRIGHT', 0, -3);
		_G[bar.."Button"..i.."HotKey"]:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE', "");
		_G[bar.."Button"..i.."HotKey"]:SetVertexColor(1, 1, 1);
	end;
	end;
end;


---- MAIN ----

function addon.Main()

	if addonTable.HIDE_GRYPHONS then
		MainMenuBarLeftEndCap:SetParent(HiddenFrame);
		MainMenuBarRightEndCap:SetParent(HiddenFrame);
		HiddenFrame:Hide();
	end;
	
	if addonTable.HIDE_ART then
		addon.HideBlizzardArt();
	end;
	
	addon:MoveBarFrames();
	addon:ResizeMainBar();
	addon:MoveMenuBags();
	
	if addonTable.SKIN_FONTS then
		addon:SetFonts();
	end;
	
	MainMenuBar:SetScale(addonTable.MAIN_BAR_SCALE);
end;


---- SCRIPTS ----

addon:SetScript("OnEvent", function(self, event, ...) 
	addon.Main();
end);


---- HOOKS ----
hooksecurefunc('ActionButton_OnUpdate', function()
	addon:SetFonts();
end);

hooksecurefunc('ActionButton_UpdateHotkeys', function()
	addon:SetFonts();
end);

hooksecurefunc('ActionButton_Update', function()
	addon:SetFonts();
end);

hooksecurefunc('PetActionBar_Update', function()
	addon:SetFonts();
end);