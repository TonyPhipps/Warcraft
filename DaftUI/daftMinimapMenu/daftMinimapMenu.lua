-- Much of the original code came from ImpBlizzardUI

local daftMM = CreateFrame("Frame", nil, UIParent);


-- Helper function for moving a Blizzard frame that has a SetMoveable flag
local function ModifyFrame(frame, anchor, parent, posX, posY, scale)
    frame:SetMovable(true);
    frame:ClearAllPoints();
    if(parent == nil) then frame:SetPoint(anchor, posX, posY) else frame:SetPoint(anchor, parent, posX, posY) end
    if(scale ~= nil) then frame:SetScale(scale) end
    frame:SetUserPlaced(true);
    frame:SetMovable(false);
end


-- Builds the Micro Menu List that displays on Right Click
local function UpdateMicroMenuList(newLevel)
    daftMM.microMenuList = {}; -- Create the array

    -- Add Stuff to it
    table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Character", func = function() ToggleCharacter( "PaperDollFrame" ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle' });
    table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Spellbook", func = function() ToggleFrame(SpellBookFrame) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Class' });
    
	if(newLevel >= 10) then
        table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Talents", func = function() ToggleTalentFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Profession' });
    end
    table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Achievements", func = function() ToggleAchievementFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\Minimap_shield_elite', });
    table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Quest Log", func = function() ToggleFrame( WorldMapFrame )end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\ActiveQuestIcon' });
    table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Guild", func = function() ToggleGuildFrame( 1 ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\TabardGossipIcon' });
    
	if(newLevel >= 15) then
        table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Group Finder", func = function() PVEFrame_ToggleFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\LFGFRAME\\BattlenetWorking0' });
    end
    table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Collections", func = function() ToggleCollectionsJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster' });
    
	if(newLevel >= 15) then
        table.insert(daftMM.microMenuList, {text = "|cffFFFFFF".."Adventure Guide".."     ", func = function() ToggleEncounterJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster' });
    end
end


local function HandleEvents(self, event, ...)
    
	if(event == "PLAYER_ENTERING_WORLD") then
        UpdateMicroMenuList(UnitLevel("player"));
    end


    if(event == "PLAYER_LEVEL_UP") then
        local newLevel, _, _, _, _, _, _, _, _ = ...;
        UpdateMicroMenuList(newLevel);
    end
end


-- Sets up Event Handlers etc
local function Init()
    daftMM:SetScript("OnEvent", HandleEvents);

    -- Register all Events
    daftMM:RegisterEvent("PLAYER_ENTERING_WORLD");
    daftMM:RegisterEvent("PLAYER_LEVEL_UP");

    -- Micro Menu that replaces the removed action bar based one. Spawns on right click of minimamp
    daftMM.microMenu = CreateFrame("Frame", "RightClickMenu", UIParent, "UIDropDownMenuTemplate");
	
	-- Enable the Micro Menu
	Minimap:SetScript("OnMouseUp", function(self, btn)
		
		if btn == "RightButton" then
			EasyMenu(daftMM.microMenuList, daftMM.microMenu, "cursor", 0, 0, "MENU", 3);
		else
			Minimap_OnClick(self)
		end
	end)
end


Init();