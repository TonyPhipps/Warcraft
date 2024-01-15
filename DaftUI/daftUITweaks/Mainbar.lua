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

local function HideBags()

	BagsBar:Hide()
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
		
	-- hooksecurefunc("ActionButton_OnUpdate", function(self)
		
	-- 	self.HotKey:SetVertexColor(1, 1, 1)
	-- 	local inrange = IsActionInRange(self.action)
	-- 	local isUsable, notEnoughMana = IsUsableAction(self.action)
		
	-- 	if inrange == false then 
	-- 		self.icon:SetVertexColor(1.0, 0.1, 0.1)
	-- 	elseif notEnoughMana then 
	-- 		self.icon:SetVertexColor(0.1, 0.1, 1.0)
	-- 	else 
	-- 		self.icon:SetVertexColor(1, 1, 1)
	-- 	end
	-- end)
end


---- SCRIPTS ----

frame:SetScript("OnEvent", function(self, event, arg1)

	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then

		addonTable.db = _G.daftUITweaksDB
		
		if addonTable.db.ENABLE_MAINBAR then

			if addonTable.db.MAINBAR_HIDE_BAGS then
				HideBags()
			end

			if addonTable.db.MAINBAR_HIDE_MENU then
				HideMenu()
			end

			if (addonTable.db.MAINBAR_HIDE_HOTKEYS 
			or addonTable.db.MAINBAR_HIDE_MACRONAMES) then
				HideButtonText()
			end

			if addonTable.db.MAINBAR_SKIN_BUTTONERRORS then
				SetButtonStatusColors()
			end
		end
	end
end)