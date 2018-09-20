local addonName, addonTable = ... 
local frame = CreateFrame("Frame")


-- EVENTS

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD") -- Clock loads later than ADDON_LOADED


-- FUNCTIONs

local function FadeFramesIn(frame)
		
		if frame:IsShown() then
			
			UIFrameFadeIn(frame, .5, frame:GetAlpha(), 1)
		end
end

local function FadeFramesOut(frame)
		
	if frame:IsShown() then
	
		UIFrameFadeOut(frame, .5, frame:GetAlpha(), 0)
		end
end

local function FadeFrames(frames)
	
	for i, frame in next, frames do
	
		local thisFrame = _G[frame]
		
		if thisFrame:GetAlpha() ~= -1 then -- Fixes bug that sometimes occurs after zoning
	
			Minimap:HookScript("OnEnter", function()
				FadeFramesIn(thisFrame)
			end)
	
			WorldFrame:HookScript("OnEnter", function()
				FadeFramesOut(thisFrame)
			end)
		end
	end
end



-- Features

local function FadeMinimapZone()

	local frames = {"MinimapBorderTop", "MinimapZoneText", "MiniMapWorldMapButton"}
	FadeFrames(frames)
end

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

local function HideMapIcon()

	MinimapZoneText:ClearAllPoints()
	MinimapZoneText:SetPoint("TOP", Minimap, "TOP", 0, 15)
	MiniMapWorldMapButton:Hide()
end

local function FadeButtons()
	
	local frames = {"GarrisonLandingPageMinimapButton", "MiniMapTracking"}
	FadeFrames(frames)
end

local function FadeClock()

	local frames = {"TimeManagerClockButton", "GameTimeFrame"}
	FadeFrames(frames)
end

local function FadeMail()
	
	local frames = {"MiniMapMailFrame"}
	FadeFrames(frames)
end

local function FadeNotices()
	
	local frames = {"QueueStatusMinimapButton", "GameTimeFrame", "MiniMapChallengeMode", "MiniMapInstanceDifficulty", "GuildInstanceDifficulty"}
	FadeFrames(frames)
end

local function Setup()

	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("PLAYER_LEVEL_UP")

	MinimapCluster:SetScale(addonTable.db.MINIMAP_SCALE)
			
	if addonTable.db.FADE_ZONETEXT then
	
		FadeMinimapZone()
	end
	
	if addonTable.db.HIDE_MAPICON then
	
		HideMapIcon()
	end
	
	if addonTable.db.MICROMENU then

		frame.microMenu = CreateFrame("Frame", "RightClickMenu", UIParent, "UIDropDownMenuTemplate")

		MinimapZoneTextButton:SetScript("OnMouseUp", function(self, btn)
		
			if (btn == "RightButton") then

				UpdateMicroMenuList(UnitLevel("player"))
				EasyMenu(frame.microMenuList, frame.microMenu, "cursor", 0, 0, "MENU", 3)
			else
				Minimap_OnClick(self)
			end
		end)
	end
	
	if addonTable.db.SCROLL_ZOOM then
	
		EnableScrollZoom()
	end
	
	if addonTable.db.HIDE_ZOOM then
	
		MinimapZoomIn:Hide()
		MinimapZoomOut:Hide()
	end
	
	if addonTable.db.SKIN_BUTTONS then
	
		SkinButtons()
	end
	
	if addonTable.db.FADE_BUTTONS then
	
		FadeButtons()
	end
	
	if addonTable.db.FADE_CLOCK then
	
		FadeClock()
	end

	if addonTable.db.FADE_MAIL then
	
		FadeMail()
	end

	if addonTable.db.FADE_NOTICES then
	
		FadeNotices()
	end

	if addonTable.db.HIDE_NORTH then
	
		MinimapNorthTag:SetAlpha(0)
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
