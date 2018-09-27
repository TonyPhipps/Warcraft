local addonName, addonTable = ... 
local frame = CreateFrame("Frame")

local HiddenFrame = CreateFrame("Frame", nil)
HiddenFrame:Hide()

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


-- EVENTS

frame:RegisterEvent("ADDON_LOADED")


---- FUNCTIONS ----

local function SetFramesAlpha()

	MainMenuBar:SetAlpha(addonTable.db.MAINBAR_ALPHA)
	StatusTrackingBarManager:SetAlpha(addonTable.db.MAINBAR_EXPBAR_ALPHA)
	MicroButtonAndBagsBar:SetAlpha(addonTable.db.MAINBAR_BAGBAR_ALPHA)
	MultiBarLeft:SetAlpha(addonTable.db.MAINBAR_LEFTBAR_ALPHA)
	MultiBarRight:SetAlpha(addonTable.db.MAINBAR_RIGHTBAR_ALPHA)

	for _, MicroButton in pairs(MicroButtonArray) do

		_G[MicroButton]:SetAlpha(addonTable.db.MAINBAR_MENUBAR_ALPHA)
	end
end

local function SetFramesScale()

	StatusTrackingBarManager:SetScale(addonTable.db.MAINBAR_EXPBAR_SCALE)
	MicroButtonAndBagsBar:SetScale(addonTable.db.MAINBAR_BAGBAR_SCALE)
	
	for _, MicroButton in pairs(MicroButtonArray) do

		_G[MicroButton]:SetScale(addonTable.db.MAINBAR_MENUBAR_SCALE)
	end
end

local function CenterRightBars()

	MultiBarRight:ClearAllPoints()
	MultiBarRight:SetPoint("RIGHT", WorldFrame, "RIGHT", 0, 0)
	MultiBarRight.SetPoint = function() end
end

local function HideActionBarBG()

	MainMenuBarArtFrameBackground:Hide()
	ActionBarUpButton:Hide()
	ActionBarDownButton:Hide()
	MainMenuBarArtFrame.PageNumber:Hide()
end

local function HideMenuBG()

	MicroButtonAndBagsBar.MicroBagBar:Hide()
end

local function HideBags()

	MicroButtonAndBagsBar:Hide()
end

local function HideMenu()
	
	for _, MicroButton in pairs(MicroButtonArray) do

		_G[MicroButton]:ClearAllPoints()
		_G[MicroButton]:SetPoint("LEFT", WorldFrame, "RIGHT", 0, 0)
		
		if MicroButton ~= "AchievementMicroButton" then -- Avoids errors with AchievementMicroButton_Update
			_G[MicroButton]:HookScript("OnShow", function() 
				_G[MicroButton]:Hide()
			end)
		end
	end

	TalentMicroButtonAlert:HookScript("OnShow", function() 
		TalentMicroButtonAlert:Hide()
	end)

	CharacterMicroButtonAlert:HookScript("OnShow", function() 
		CharacterMicroButtonAlert:Hide()
	end)
end

local function HideButtonText()
	
	local bars = {
		"Action",
		"MultiBarBottomLeft", 
		"MultiBarBottomRight",
		"MultiBarLeft", 
		"MultiBarRight"
	}
	
	for _, bar in pairs(bars) do
		
		for i = 1, 12 do
							
			if addonTable.db.MAINBAR_HIDE_HOTKEYS then
				
				_G[bar.."Button"..i.."HotKey"].Show = function() end
				_G[bar.."Button"..i.."HotKey"]:Hide()

			end
			
			if addonTable.db.MAINBAR_HIDE_MACRONAMES then
				
				_G[bar.."Button"..i.."Name"]:Hide()

			end
		end
	end
end

local function SetButtonStatusColors()
		
	hooksecurefunc("ActionButton_OnUpdate", function(self)
		
		self.HotKey:SetVertexColor(1, 1, 1)
		local inrange = IsActionInRange(self.action)
		local isUsable, notEnoughMana = IsUsableAction(self.action)
		
		if inrange == false then 
			self.icon:SetVertexColor(1.0, 0.1, 0.1)
		elseif notEnoughMana then 
			self.icon:SetVertexColor(0.1, 0.1, 1.0)
		else 
			self.icon:SetVertexColor(1, 1, 1)
		end
	end)
end


---- SCRIPTS ----

frame:SetScript("OnEvent", function(self, event, arg1)

	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then

		addonTable.db = _G.daftUITweaksDB
		
		if addonTable.db.ENABLE_MAINBAR then

			SetFramesAlpha()
			SetFramesScale()
		
			if addonTable.db.MAINBAR_HIDE_GRYPHONS then
				MainMenuBarArtFrame.LeftEndCap:Hide()
				MainMenuBarArtFrame.RightEndCap:Hide()
			end

			if addonTable.db.MAINBAR_HIDE_BAGS then
				HideBags()
			end

			if addonTable.db.MAINBAR_HIDE_MENU then
				HideMenu()
			end

			if addonTable.db.MAINBAR_HIDE_ACTIONBAR_BG then
				HideActionBarBG()
			end

			if addonTable.db.MAINBAR_HIDE_MENU_BG then
				HideMenuBG()
			end

			if (addonTable.db.MAINBAR_HIDE_HOTKEYS 
			or addonTable.db.MAINBAR_HIDE_MACRONAMES) then
				HideButtonText()
			end

			if addonTable.db.MAINBAR_SKIN_BUTTONERRORS then
				SetButtonStatusColors()
			end

			if addonTable.db.MAINBAR_CENTER_RIGHT_BARS then
				CenterRightBars()
			end
		end
	end
end)