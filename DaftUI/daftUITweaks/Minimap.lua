local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

addon:SetScript("OnEvent", HandleEvents)

addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("PLAYER_LEVEL_UP")

-- Helper Functions

function addon:FadeFramesIn(frame)
		
		if frame:IsShown() then
			
			UIFrameFadeIn(frame, .5, frame:GetAlpha(), 1)
		end
end


function addon:FadeFramesOut(frame)
		
	if frame:IsShown() then
	
		UIFrameFadeOut(frame, .5, frame:GetAlpha(), 0)
		end
end


function addon:FadeFrames(frames)
	
	for i, frame in next, frames do
	
		local thisFrame = _G[frame]
		
		if thisFrame:GetAlpha() ~= -1 then -- Fixes bug that sometimes occurs after zoning
	
			Minimap:HookScript("OnEnter", function()
				addon:FadeFramesIn(thisFrame)
			end)
	
			WorldFrame:HookScript("OnEnter", function()
				addon:FadeFramesOut(thisFrame)
			end)
		end
	end
end


-- Features
local function UpdateMicroMenuList(newLevel) -- Minimap menu original code was from kaytotes's ImpBlizzardUI
	
	addon.microMenuList = {} 

    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Character", func = function() ToggleCharacter( "PaperDollFrame" ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle' })
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Spellbook", func = function() ToggleFrame(SpellBookFrame) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Class' })
    
	if(newLevel >= 10) then
	
		table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Spec & Talents", func = function() ToggleTalentFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Profession' })
    end
	
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Achievements", func = function() ToggleAchievementFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\Minimap_shield_elite', })
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Quest Log", func = function() ToggleFrame( WorldMapFrame )end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\ActiveQuestIcon' })
    table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Guild", func = function() ToggleGuildFrame( 1 ) end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\GossipFrame\\TabardGossipIcon' })
    
	if(newLevel >= 15) then
	
		table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Group Finder", func = function() PVEFrame_ToggleFrame() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\LFGFRAME\\BattlenetWorking0' })
    end
	
	table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Collections", func = function() ToggleCollectionsJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster' })
	
	if(newLevel >= 15) then
	
		table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Adventure Guide".."     ", func = function() ToggleEncounterJournal() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster' })
    end
	
	table.insert(addon.microMenuList, {text = "|cffFFFFFF".."Shop", func = function() ToggleStoreUI() end, notCheckable = true, fontObject = GameTooltipTextSmall, icon = 'Interface\\MINIMAP\\TRACKING\\Auctioneer' })
end


local function EnableScrollZoom()
	
	Minimap:EnableMouseWheel()
	local function Zoom(self, direction)
	
		if(direction > 0) then 
	
			Minimap_ZoomIn()
	
		else
	
			Minimap_ZoomOut()
		end
	end
	
	Minimap:SetScript("OnMouseWheel", Zoom)
end


local function SkinButtons()
	
	MiniMapTracking:SetScale(0.7)
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:SetPoint("TOP", Minimap, "TOP", -88, -20)
	MiniMapTrackingButton:SetPushedTexture(nil)
	
	MiniMapMailFrame:SetScale(0.7)
	MiniMapMailFrame:ClearAllPoints()
	MiniMapMailFrame:SetPoint("BOTTOM", Minimap, "BOTTOM", 52, -24)
	
	GarrisonLandingPageMinimapButton:SetScale(.5)
	GarrisonLandingPageMinimapButton:ClearAllPoints()
	GarrisonLandingPageMinimapButton:SetPoint("TOP", Minimap, "TOP", -95, 3)
	
	QueueStatusMinimapButton:SetScale(0.7)
	QueueStatusMinimapButton:ClearAllPoints()
	QueueStatusMinimapButton:SetPoint("BOTTOM", Minimap, "BOTTOM", -45, -23)
	
	GameTimeFrame:SetScale(0.55)
	GameTimeFrame:ClearAllPoints()
	GameTimeFrame:SetPoint("TOP", Minimap, "TOP", 83, -2)
end


local function FadeMinimapZone()

	local frames = {"MinimapBorderTop", "MinimapZoneText"}
	addon:FadeFrames(frames)
end


local function SkinMinimapZone()

	MinimapZoneText:ClearAllPoints()
	MinimapZoneText:SetPoint("TOP", Minimap, "TOP", 0, 15)
	MiniMapWorldMapButton:Hide()
end


local function FadeButtons()
	
	local frames = {"GarrisonLandingPageMinimapButton", "MiniMapTracking"}
	addon:FadeFrames(frames)
end

local function FadeClock()

	local frames = {"TimeManagerClockButton", "GameTimeFrame"}
	addon:FadeFrames(frames)
end

local function FadeMail()
	
	local frames = {"MiniMapMailFrame"}
	addon:FadeFrames(frames)
end

local function FadeNotices()
	
	local frames = {"QueueStatusMinimapButton", "GameTimeFrame", "MiniMapChallengeMode", "MiniMapInstanceDifficulty", "GuildInstanceDifficulty"}
	addon:FadeFrames(frames)
end



local function HandleEvents(self, event, ...)
    
	if(event == "PLAYER_ENTERING_WORLD") then
		
		MinimapCluster:SetScale(addonTable.MINIMAP_SCALE)
		
		if addonTable.FADE_ZONETEXT then
		
			FadeMinimapZone()
		end
		
		if addonTable.SKIN_ZONETEXT then
		
			SkinMinimapZone()
		end
		
		if addonTable.MICROMENU then
		
			UpdateMicroMenuList(UnitLevel("player"))
		end
		
		if addonTable.SCROLL_ZOOM then
		
			EnableScrollZoom()
		end
		
		if addonTable.HIDE_ZOOM then
		
			MinimapZoomIn:Hide()
			MinimapZoomOut:Hide()
		end
		
		if addonTable.SKIN_BUTTONS then
		
			SkinButtons()
		end
		
		if addonTable.FADE_BUTTONS then
		
			FadeButtons()
		end
		
		if addonTable.FADE_CLOCK then
		
			FadeClock()
		end

		if addonTable.FADE_MAIL then
		
			FadeMail()
		end
	end


    if(event == "PLAYER_LEVEL_UP") then
	   
		if addonTable.MICROMENU then
		
			local newLevel, _, _, _, _, _, _, _, _ = ...
			UpdateMicroMenuList(newLevel)
		end
    end
end



addon.microMenu = CreateFrame("Frame", "RightClickMenu", UIParent, "UIDropDownMenuTemplate")



-- Scripts
MinimapZoneTextButton:SetScript("OnMouseUp", function(self, btn)
	
	if (addonTable.MICROMENU and btn == "RightButton") then
		EasyMenu(addon.microMenuList, addon.microMenu, "cursor", 0, 0, "MENU", 3)
	else
		--Minimap_OnClick(self)
	end
end)
