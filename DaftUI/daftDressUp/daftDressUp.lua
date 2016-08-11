local horizontalScale = 0.5;
local verticalScale = 1.0;

local function HideRegions(Frame)
	for _, Region in pairs({ Frame:GetRegions() }) do
		if Region:IsObjectType("Texture") then 
			Region:Hide();
		end
	end
end

HideRegions(DressUpFrame)

DressUpFrameCloseButton:Hide();
DressUpFrameTitleText:Hide();

DressUpModelControlFrame:ClearAllPoints()
DressUpModelControlFrame:SetPoint("BOTTOM", DressUpModel, "TOP", 0, 0)

DressUpFrameResetButton:ClearAllPoints()
DressUpFrameResetButton:SetPoint("BOTTOMRIGHT", DressUpModelControlFrame, "BOTTOMLEFT", 0, 0)
DressUpFrameCancelButton:SetPoint("BOTTOMLEFT", DressUpModelControlFrame, "BOTTOMRIGHT", 0, 0)

DressUpFrameOutfitDropDown:ClearAllPoints()
DressUpFrameOutfitDropDown:SetPoint("BOTTOMLEFT", DressUpFrameResetButton, "TOPLEFT", -15, 5)

DressUpModel:ClearAllPoints()
DressUpModel:SetPoint("TOP", WorldFrame, "TOP", 0, -50)
DressUpModel:SetSize(GetScreenWidth()*horizontalScale, GetScreenHeight()*verticalScale);

-- WardrobeCollectionFrame:HookScript("OnShow", function()
	-- DressUpModel:ClearAllPoints()
	-- DressUpModel:SetPoint("LEFT", WardrobeCollectionFrame, "RIGHT", 0, -50)
-- end)

-- WardrobeCollectionFrame:HookScript("OnHide", function()
	-- DressUpModel:ClearAllPoints()
	-- DressUpModel:SetSize(GetScreenWidth()*horizontalScale, GetScreenHeight()*verticalScale);
-- end)