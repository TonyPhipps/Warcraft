local addonName, addonTable = ... 
local frame = CreateFrame("Frame")


-- EVENTS

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")


-- FUNCTIONS


-- Features

local function UpdateMicroMenuList(newLevel) -- Minimap menu original code was from kaytotes's ImpBlizzardUI

	frame.microMenuList = {} 

	table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Character", func = function() ToggleCharacter( "PaperDollFrame" ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle' })
	table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Spellbook", func = function() ToggleFrame(SpellBookFrame) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Class' })
	
	if(newLevel >= 10) then
	
		table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Spec & Talents", func = function() ToggleTalentFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Profession' })
	end
	
	table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Achievements", func = function() ToggleAchievementFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\Minimap_shield_elite', })
	table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Quest Log", func = function() ToggleFrame( WorldMapFrame )end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\ActiveQuestIcon' })
	table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Guild", func = function() ToggleGuildFrame( 1 ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\TabardGossipIcon' })
	
	if(newLevel >= 15) then
	
		table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Group Finder", func = function() PVEFrame_ToggleFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\LFGFRAME\\BattlenetWorking0' })
	end
	
	table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Collections", func = function() ToggleCollectionsJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster' })
	
	if(newLevel >= 15) then
	
		table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Adventure Guide".."     ", func = function() ToggleEncounterJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster' })
	end
	
	table.insert(frame.microMenuList, {text = "|cffFFFFFF".."Shop", func = function() ToggleStoreUI() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Auctioneer' })
end


local function Setup()

	frame:RegisterEvent("PLAYER_LEVEL_UP")

	MinimapCluster:SetScale(addonTable.db.MINIMAP_SCALE)
	
	if addonTable.db.MICROMENU then

		frame.microMenu = CreateFrame("Frame", "RightClickMenu", UIParent, "UIDropDownMenuTemplate")

	end
end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then
		
		addonTable.db = daftUITweaksDB
	
		frame:UnregisterEvent("ADDON_LOADED")
	end

	if event == "PLAYER_ENTERING_WORLD" then

		if addonTable.db.ENABLE_MINIMAP then
            
            Setup()
        end
	end

	if(event == "PLAYER_LEVEL_UP") then
		
		if addonTable.db.MICROMENU then
		
			local newLevel = arg1
			UpdateMicroMenuList(newLevel)
		end
	end
end)
