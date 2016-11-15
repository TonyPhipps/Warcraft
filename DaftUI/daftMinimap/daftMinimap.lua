local addonName, addonTable = ... ;
local addon = CreateFrame("Frame", nil, UIParent);
-- Minimap original code was from kaytotes's ImpBlizzardUI


local function UpdateMicroMenuList(newLevel)
    addon.microMenuList = {}; 

    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Character", func = function() ToggleCharacter( "PaperDollFrame" ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle' });
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Spellbook", func = function() ToggleFrame(SpellBookFrame) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Class' });
    
	if(newLevel >= 10) then
        table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Spec & Talents", func = function() ToggleTalentFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Profession' });
    end;
	
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Achievements", func = function() ToggleAchievementFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\Minimap_shield_elite', });
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Quest Log", func = function() ToggleFrame( WorldMapFrame )end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\ActiveQuestIcon' });
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Guild", func = function() ToggleGuildFrame( 1 ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\TabardGossipIcon' });
    
	if(newLevel >= 15) then
        table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Group Finder", func = function() PVEFrame_ToggleFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\LFGFRAME\\BattlenetWorking0' });
    end;
	
	table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Collections", func = function() ToggleCollectionsJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster' });
	
	if(newLevel >= 15) then
        table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Adventure Guide".."     ", func = function() ToggleEncounterJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster' });
    end;
	
	table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Shop", func = function() ToggleStoreUI() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Auctioneer' });
end;


local function HandleEvents(self, event, ...)
    
	if(event == "PLAYER_ENTERING_WORLD") then
        UpdateMicroMenuList(UnitLevel("player"));
    end;


    if(event == "PLAYER_LEVEL_UP") then
        local newLevel, _, _, _, _, _, _, _, _ = ...;
        UpdateMicroMenuList(newLevel);
    end;
end;


local function Init()
    addon:SetScript("OnEvent", HandleEvents);
	
    addon:RegisterEvent("PLAYER_ENTERING_WORLD");
    addon:RegisterEvent("PLAYER_LEVEL_UP");

    addon.microMenu = CreateFrame("Frame", "RightClickMenu", UIParent, "UIDropDownMenuTemplate");
	
	-- Scripts
	Minimap:SetScript("OnMouseUp", function(self, btn)
		
		if btn == "RightButton" then
			EasyMenu(addon.microMenuList, addon.microMenu, "cursor", 0, 0, "MENU", 3);
		else
			Minimap_OnClick(self);
		end;
	end);
end;


Init();