local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

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

addon:RegisterEvent("PLAYER_LOGIN")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")

---- SCRIPTS ----

addon:SetScript("OnEvent", function(self, event, ...) 
	
	if (event == "PLAYER_LOGIN"
	or event == "PLAYER_ENTERING_WORLD") then
		
		addon:SetFramesAlpha()
		addon:SetFramesScale()
	
		if addonTable.HIDE_GRYPHONS then
			MainMenuBarArtFrame.LeftEndCap:Hide()
			MainMenuBarArtFrame.RightEndCap:Hide()
		end

		if addonTable.HIDE_ACTIONBAR_BG then
			addon.HideActionBarBG()
		end

		if addonTable.HIDE_MENU_BG then
			addon.HideMenuBG()
		end

		if (addonTable.SKIN_FONTS
		or addonTable.SKIN_COLORSTATE
		or addonTable.HIDE_HOTKEYS 
		or addonTable.HIDE_MACRONAMES) then
			addon:SkinButtonText()
		end

		if addonTable.SKIN_COLORSTATE then
			addon:SetButtonStatusColors()
		end
    end
end)



---- HELPER FUNCTIONS ----

function addon:FadeFramesIn(frames)
	for i, addon in next, frames do
		local thisFrame = _G[addon]
		
		if thisFrame:IsShown() then
			UIFrameFadeIn(thisFrame, .5, thisFrame:GetAlpha(), 1)
		end
	end
end


function addon:FadeFramesOut(frames)
	for i, addon in next, frames do
		local thisFrame = _G[addon]
		
		if thisFrame:IsShown() then
			UIFrameFadeOut(thisFrame, .5, thisFrame:GetAlpha(), 0)
		end
	end
end


function addon:FadeFrames(frames)
	
	for i, addon in next, frames do
		local thisFrame = _G[addon]
		
		thisFrame:HookScript("OnEnter", function()
			addon:FadeFramesIn(frames)
		end)

		WorldFrame:HookScript("OnEnter", function()
			addon:FadeFramesOut(frames)
		end)
	end
end


---- FUNCTIONS ----

function addon:SetFramesAlpha()

	MainMenuBar:SetAlpha(addonTable.MAINBAR_ALPHA)
	StatusTrackingBarManager:SetAlpha(addonTable.EXPBAR_ALPHA)
	MicroButtonAndBagsBar:SetAlpha(addonTable.BAGBAR_ALPHA)
	MultiBarLeft:SetAlpha(addonTable.LEFTBAR_ALPHA)
	MultiBarRight:SetAlpha(addonTable.RIGHTBAR_ALPHA)

	for _, MicroButton in pairs(MicroButtonArray) do

		_G[MicroButton]:SetAlpha(addonTable.MENUBAR_ALPHA)
	end
end


function addon:SetFramesScale()

	StatusTrackingBarManager:SetScale(addonTable.EXPBAR_SCALE)
	MicroButtonAndBagsBar:SetScale(addonTable.BAGBAR_SCALE)
	
	for _, MicroButton in pairs(MicroButtonArray) do

		_G[MicroButton]:SetScale(addonTable.MENUBAR_SCALE)
	end
end


function addon:HideActionBarBG()

	MainMenuBarArtFrameBackground:Hide()
	ActionBarUpButton:Hide()
	ActionBarDownButton:Hide()
	MainMenuBarArtFrame.PageNumber:Hide()

end


function addon:HideMenuBG()

	MicroButtonAndBagsBar.MicroBagBar:Hide()
	
end

function addon:HideBags()

	MicroButtonAndBagsBar.MicroBagBar:Hide()
	
end

function addon:SkinButtonText()
	
	local bars = {
		"Action",
		"MultiBarBottomLeft", 
		"MultiBarBottomRight",
		"MultiBarLeft", 
		"MultiBarRight"
	}
	
	for _, bar in pairs(bars) do
		
		for i = 1, 12 do
			
			if addonTable.SKIN_FONTS then
				
				_G[bar.."Button"..i.."HotKey"]:ClearAllPoints()
				_G[bar.."Button"..i.."HotKey"]:SetPoint("TOPRIGHT", 0, -3)
				_G[bar.."Button"..i.."HotKey"]:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE", "")
				
				_G[bar.."Button"..i.."Name"]:ClearAllPoints()
				_G[bar.."Button"..i.."Name"]:SetPoint("BOTTOM", 0, 0)
				_G[bar.."Button"..i.."Name"]:SetFont("Fonts\\ARIALN.ttf", 10, "THINOUTLINE", "")

			end
			
			if addonTable.HIDE_HOTKEYS then
				
				_G[bar.."Button"..i.."HotKey"].Show = function() end
				_G[bar.."Button"..i.."HotKey"]:Hide()

			end
			
			if addonTable.HIDE_MACRONAMES then
				
				_G[bar.."Button"..i.."Name"]:Hide()

			end
		end
	end
	
	for i = 1, 10 do

		if addonTable.SKIN_FONTS then

			_G["PetActionButton"..i.."HotKey"]:ClearAllPoints()
			_G["PetActionButton"..i.."HotKey"]:SetPoint("TOPRIGHT", 0, -3)
			_G["PetActionButton"..i.."HotKey"]:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE", "")

		end
	end	
end

function addon:SetButtonStatusColors()
		
	hooksecurefunc("ActionButton_OnUpdate", function(self)
		
		self.HotKey:SetVertexColor(1, 1, 1)
		local inrange = IsActionInRange(self.action)
		local isUsable, notEnoughMana = IsUsableAction(self.action)
		
		if inrange == false then self.icon:SetVertexColor(1.0, 0.1, 0.1)
		elseif notEnoughMana then self.icon:SetVertexColor(0.1, 0.1, 1.0)
		else self.icon:SetVertexColor(1, 1, 1)
		end

	end)
	
	-- Code below causes flickering of hotkey text when font skinning is enabled.
	--hooksecurefunc("PetActionButton_OnUpdate", function(self)
	--	self.HotKey:SetVertexColor(1, 1, 1)
	--end)
end


---- SCRIPTS ----

MainMenuBarVehicleLeaveButton:HookScript("Onhide", function(self)
	addon.SetScalingAlpha()
end)