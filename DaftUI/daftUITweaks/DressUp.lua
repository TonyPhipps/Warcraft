local addonName, addonTable = ... 
local frame = CreateFrame("Frame")

-- EVENTS

frame:RegisterEvent("ADDON_LOADED")


local function Setup()

	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
end

--Helper Functions

local function HideFrameTextures(Frame)
		
	for _, Region in pairs({ Frame:GetRegions() }) do
	
		if Region:IsObjectType("Texture") then 
			Region:SetAlpha(0)
		end
	end
end

local function ShowFrameTextures(Frame)
	
	for _, Region in pairs({ Frame:GetRegions() }) do
	
		if Region:IsObjectType("Texture") then 
			Region:SetAlpha(1)
		end
	end
end

--Feature functions

local function SetPosition()
	if addonTable.db.DRESSUP_CENTER then
		DressUpFrame:ClearAllPoints()
		DressUpFrame:SetPoint("TOP", WorldFrame, "TOP", 12, 0)
			
		-- Fix Character frame pushing
		UIPanelWindows["CharacterFrame"] =	{ area = "left", pushable = 0, whileDead = 1 }
	end
end

local function SetupMouseover()
	
	local function HideStuff()

		HideFrameTextures(DressUpFrame)
		DressUpFrameCloseButton:SetAlpha(0)
		DressUpFrameTitleText:SetAlpha(0)
		DressUpFrameCancelButton:SetAlpha(0)
		DressUpFrameResetButton:SetAlpha(0)
		DressUpFrameOutfitDropDown:SetAlpha(0)
		MaximizeMinimizeFrame:SetAlpha(0)
		DressUpFrameInset:SetAlpha(0)
		DressUpFrame.NineSlice:SetAlpha(0)
	end

	local function ShowStuff()

		ShowFrameTextures(DressUpFrame)
		DressUpFrameCloseButton:SetAlpha(1)
		DressUpFrameCancelButton:SetAlpha(1)
		DressUpFrameResetButton:SetAlpha(1)
		DressUpFrameOutfitDropDown:SetAlpha(1)
		MaximizeMinimizeFrame:SetAlpha(1)
		DressUpFrameInset:SetAlpha(1)
		DressUpFrame.NineSlice:SetAlpha(1)
	end

	DressUpFrame:HookScript("OnShow", HideStuff)
	
	DressUpFrame:HookScript("OnEnter", ShowStuff)
	DressUpModel:HookScript("OnEnter", ShowStuff)
	DressUpFrameResetButton:HookScript("OnEnter", ShowStuff)
	MaximizeMinimizeFrame.MinimizeButton:HookScript("OnEnter", ShowStuff)

	WorldFrame:HookScript("OnEnter", HideStuff)
end

-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then
		
		addonTable.db = daftUITweaksDB
		
        if addonTable.db.ENABLE_DRESSUP then
            
            Setup()
		end
		
		frame:SetScript("OnEvent", function(self, event, ...) 
		
			if event == "PLAYER_ENTERING_WORLD" then
				
				if addonTable.db.DRESSUP_MOUSEOVER then
					SetupMouseover()
				end
				
				DressUpFrame:SetScale(addonTable.db.DRESSUP_SCALE)
			end
		end)
	
	
		--Hooks
	
		CharacterFrame:HookScript("OnShow", SetPosition)
		DressUpFrame:HookScript("OnShow", SetPosition)
		hooksecurefunc("UpdateUIPanelPositions", SetPosition)
	
		frame:UnregisterEvent("ADDON_LOADED")
	end
end)
