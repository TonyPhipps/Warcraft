local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");
local HiddenFrame = CreateFrame("Frame", nil);
HiddenFrame:Hide();

local MicroButtonArray = {
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
	"MainMenuMicroButton"
}

addon:RegisterEvent("PLAYER_LOGIN");
addon:RegisterEvent("PLAYER_ENTERING_WORLD");


---- HELPER FUNCTIONS ----

function addon:ScaleFrames(frames, scale)
		
	for i, frame in next, frames do
		local thisFrame = _G[frame];
		thisFrame:SetScale(scale);
	end;
end;


function addon:SetFramesStrata(frames, strata)
	for i, frame in next, frames do
		local thisFrame = _G[frame];
		
		if thisFrame:IsShown() then
			thisFrame:SetFrameStrata(strata);
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

function addon:SetScalingAlpha()

	MainMenuBar:SetAlpha(addonTable.MAINBAR_ALPHA)

	StatusTrackingBarManager:SetScale(addonTable.EXPBAR_SCALE)
	StatusTrackingBarManager:SetAlpha(addonTable.EXPBAR_ALPHA)

	MicroButtonAndBagsBar:SetScale(addonTable.BAGBAR_SCALE)
	MicroButtonAndBagsBar:SetAlpha(addonTable.EXPBAR_ALPHA)

	MultiBarLeft:SetAlpha(addonTable.LEFTBAR_ALPHA)
	MultiBarRight:SetAlpha(addonTable.RIGHTBAR_ALPHA)

	for _, MicroButton in pairs(MicroButtonArray) do

		_G[MicroButton]:SetScale(addonTable.MENUBAR_SCALE)
		_G[MicroButton]:SetAlpha(addonTable.MENUBAR_ALPHA)

	end
end


function addon:HideBarArt()

	MainMenuBarArtFrameBackground:Hide()
	MicroButtonAndBagsBar.MicroBagBar:Hide()
	ActionBarUpButton:Hide()
	ActionBarDownButton:Hide()
	MainMenuBarArtFrame.PageNumber:Hide()

end;


function addon:HideMenuArt()

	MicroButtonAndBagsBar.MicroBagBar:Hide()	
	
end;

-- function addon:SkinWatchbarText()
-- 	local watchbars = {"StatusTrackingBarManager", "StatusTrackingBarManager"}
	
-- 	for _, watchbar in pairs(watchbars) do
-- 		_G[watchbar].OverlayFrame.Text:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE", "");
-- 		_G[watchbar].OverlayFrame.Text:SetShadowOffset(0, 0);
-- 	end;
	
-- 	MainMenuBarExpText:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE", "");
-- 	MainMenuBarExpText:SetShadowOffset(0, 0);
-- end;


function addon:SkinButtonText()
	
	local bars = {
		"Action",
		"MultiBarBottomLeft", 
		"MultiBarBottomRight",
		"MultiBarLeft", 
		"MultiBarRight"
	};
	
	for _, bar in pairs(bars) do
		
		for i = 1, 12 do
			
			if addonTable.SKIN_FONTS then
				
				_G[bar.."Button"..i.."HotKey"]:ClearAllPoints();
				_G[bar.."Button"..i.."HotKey"]:SetPoint("TOPRIGHT", 0, -3);
				_G[bar.."Button"..i.."HotKey"]:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE", "");
				
				_G[bar.."Button"..i.."Name"]:ClearAllPoints();
				_G[bar.."Button"..i.."Name"]:SetPoint("BOTTOM", 0, 0);
				_G[bar.."Button"..i.."Name"]:SetFont("Fonts\\ARIALN.ttf", 10, "THINOUTLINE", "");

			end;
			
			if addonTable.HIDE_HOTKEYS then
				
				_G[bar.."Button"..i.."HotKey"].Show = function() end;
				_G[bar.."Button"..i.."HotKey"]:Hide();

			end;
			
			if addonTable.HIDE_MACRONAMES then
				
				_G[bar.."Button"..i.."Name"]:Hide();

			end;
		end;
	end;
	
	for i = 1, 10 do

		if addonTable.SKIN_FONTS then

			_G["PetActionButton"..i.."HotKey"]:ClearAllPoints();
			_G["PetActionButton"..i.."HotKey"]:SetPoint("TOPRIGHT", 0, -3);
			_G["PetActionButton"..i.."HotKey"]:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE", "");

		end;
	end;
	
	if addonTable.SKIN_COLORSTATE then
		
		hooksecurefunc("ActionButton_OnUpdate", function(self)
			
			self.HotKey:SetVertexColor(1, 1, 1);
			local inrange = IsActionInRange(self.action);
			local isUsable, notEnoughMana = IsUsableAction(self.action);
			
			if inrange == false then self.icon:SetVertexColor(1.0, 0.1, 0.1);
			elseif notEnoughMana then self.icon:SetVertexColor(0.1, 0.1, 1.0);
			else self.icon:SetVertexColor(1, 1, 1);
			end;

		end);
		
		-- Code below causes flickering of hotkey text when font skinning is enabled.
		--hooksecurefunc("PetActionButton_OnUpdate", function(self)
		--	self.HotKey:SetVertexColor(1, 1, 1);
		--end);
	end;
end;


---- SCRIPTS ----

addon:SetScript("OnEvent", function(self, event, ...) 
	
	if event == "PLAYER_LOGIN" then
		addon.SetScalingAlpha()
	end;
	
	if event == "PLAYER_ENTERING_WORLD" then 
		
		addon.SetScalingAlpha()

		if addonTable.HIDE_GRYPHONS then
			MainMenuBarArtFrame.LeftEndCap:Hide()
			MainMenuBarArtFrame.RightEndCap:Hide()
		end;

		if addonTable.HIDE_BAR_ART then
			addon.HideBarArt();
		end;

		if addonTable.HIDE_MENU_ART then
			addon.HideMenuArt();
		end;

		if (addonTable.SKIN_FONTS
		or addonTable.SKIN_COLORSTATE
		or addonTable.HIDE_HOTKEYS 
		or addonTable.HIDE_MACRONAMES) then
			addon:SkinButtonText();
			--addon:SkinWatchbarText();
		end;
	end;
end);


MainMenuBarVehicleLeaveButton:HookScript("Onhide", function(self)
	addon.SetScalingAlpha();
end);
