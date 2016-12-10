local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");

addon:RegisterEvent("PLAYER_ENTERING_WORLD");


--Helper Functions

function addon:HideFrameTextures(Frame)
	
	for _, Region in pairs({ Frame:GetRegions() }) do
	
		if Region:IsObjectType("Texture") then 
			Region:Hide();
		end;
	end;
end;

function addon:ShowFrameTextures(Frame)
	
	for _, Region in pairs({ Frame:GetRegions() }) do
	
		if Region:IsObjectType("Texture") then 
			Region:Show();
		end;
	end;
end;


--Feature functions

function addon:setPosition()
	if addonTable.MOVE_TO_CENTER then
		DressUpFrame:ClearAllPoints();
		DressUpFrame:SetPoint("TOP", WorldFrame, "TOP", 12, 0);
			
		-- Fix Character frame pushing
		UIPanelWindows["CharacterFrame"] =	{ area = "left", pushable = 0, whileDead = 1};
	end;
end;

function addon:setHidden()
	
	
	DressUpFrame:HookScript("OnShow", function()
		addon:HideFrameTextures(DressUpFrame);
		
		DressUpFrameCloseButton:Hide();
		DressUpFrameTitleText:Hide();
		DressUpFrameCancelButton:Hide();
		DressUpFrameResetButton:Hide();
		DressUpFrameOutfitDropDown:Hide()
	end);
	
	
	DressUpModel:HookScript("OnEnter", function()
		addon:ShowFrameTextures(DressUpFrame);
		
		DressUpFrameCloseButton:Show();
		DressUpFrameCancelButton:Show();
		DressUpFrameResetButton:Show();
		DressUpFrameOutfitDropDown:Show()
	end);

	WorldFrame:HookScript("OnEnter", function()
		addon:HideFrameTextures(DressUpFrame);
		
		DressUpFrameCloseButton:Hide();
		DressUpFrameTitleText:Hide();
		DressUpFrameCancelButton:Hide();
		DressUpFrameResetButton:Hide();
		DressUpFrameOutfitDropDown:Hide()
	end);
end;


--Events

addon:SetScript("OnEvent", function(self, event, ...) 
	
	if event == "PLAYER_ENTERING_WORLD" then
		
		if addonTable.HIDE then
			addon:setHidden();
		end;
		
		DressUpFrame:SetScale(addonTable.SCALE);
	end;
end);


--Hooks

CharacterFrame:HookScript("OnShow", function()
	addon:setPosition();
end);

DressUpFrame:HookScript("OnShow", function()
	addon:setPosition();
end);

hooksecurefunc("UpdateUIPanelPositions", function()
	addon:setPosition();
end);