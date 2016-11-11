local addonName, addonTable = ... ;

local addon = CreateFrame("Frame");

addon:RegisterEvent("PLAYER_LOGIN");
addon:RegisterEvent("PLAYER_REGEN_DISABLED");
addon:RegisterEvent("PLAYER_REGEN_ENABLED");
addon:RegisterEvent("PLAYER_FOCUS_CHANGED");
addon:RegisterEvent("PLAYER_TARGET_CHANGED");
addon:RegisterUnitEvent("UNIT_HEALTH_FREQUENT");
addon:RegisterUnitEvent("UNIT_POWER_FREQUENT");
addon:RegisterUnitEvent("QUEST_WATCH_LIST_CHANGED");
addon:RegisterUnitEvent("QUEST_WATCH_UPDATE");
addon:RegisterUnitEvent("UNIT_QUEST_LOG_CHANGED");


local TopEdgeHover = CreateFrame("Frame");
TopEdgeHover:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0);
TopEdgeHover:SetSize(UIParent:GetWidth(), 50);
TopEdgeHover:SetFrameStrata("BACKGROUND");
TopEdgeHover:SetScript("OnEnter", function() end);	


---- HELPER FUNCTIONS ----

function addon:FadeFrameIn(Frame)

	if UnitAffectingCombat("player") then
		if Frame:IsShown() then
			UIFrameFadeIn(Frame, addonTable.COMBAT_TIMETOFADEIN, Frame:GetAlpha(), addonTable.COMBAT_FADEIN);
		end;
	else
		if Frame:IsShown() then
			UIFrameFadeIn(Frame, addonTable.NOCOMBAT_TIMETOFADEIN, Frame:GetAlpha(), addonTable.NOCOMBAT_FADEIN);
		end;
	end;
end;


function addon:FadeFrameOut(Frame)

	if UnitAffectingCombat("player") or InCombatLockdown() then
		if Frame:IsShown() then
			UIFrameFadeOut(Frame, addonTable.COMBAT_TIMETOFADEOUT, Frame:GetAlpha(), addonTable.COMBAT_FADEOUT);
		end;
	else
		if Frame:IsShown() then
			UIFrameFadeOut(Frame, addonTable.NOCOMBAT_TIMETOFADEOUT, Frame:GetAlpha(), addonTable.NOCOMBAT_FADEOUT);
		end;
	end;
end;


function addon:SetupBasicFading(setting, Frame)
	if setting then
		Frame:SetScript("OnEnter", function(Frame)
			addon:FadeFrameIn(Frame);
		end);
		
		WorldFrame:HookScript("OnEnter", function()
			addon:FadeFrameOut(Frame);
		end);
	end;
end;


function addon:FadeOutAll()
	if addonTable.BUFFS then 
		addon:FadeFrameOut(BuffFrame);
	end;
	
	if addonTable.CHATTABS then 
		for i = 1, NUM_CHAT_WINDOWS do
			local chatFrameNumber = ("ChatFrame%d"):format(i);
			local ChatFrameNumberTab = _G[chatFrameNumber.."Tab"];
			
			addon:FadeFrameOut(ChatFrameNumberTab);
		end;
	end;
	
	if addonTable.MAINMENUBAR then
		addon:FadeFrameOut(MainMenuBar);
	end;
	
	if addonTable.MINIMAP then	
		addon:FadeFrameOut(Minimap);
		addon:FadeFrameOut(MinimapCluster);
	end;
	
	if addonTable.OBJECTIVETRACKER then
		addon:FadeFrameOut(ObjectiveTrackerFrame);
	end;

	if addonTable.PARTY then
		if not IsInRaid() then
			for i = 1, GetNumGroupMembers()-1 do
				local partyMemberFrameNumber = ("PartyMemberFrame%d"):format(i);
				local PartyMemberFrameNumber = _G[partyMemberFrameNumber];
				
				addon:FadeFrameOut(PartyMemberFrameNumber);				
			end;
		end;
	end;
	
	if addonTable.PLAYER then 
		addon:FadeFrameOut(PlayerFrame);
	end;

	if addonTable.RAIDMANAGER then
		if not CompactRaidFrameContainer:IsShown() then
			addon:FadeFrameOut(CompactRaidFrameManager);
		end;
	end;
	
	if addonTable.VEHICLESEATINDICATOR then
		addon:FadeFrameOut(VehicleSeatIndicator);
	end;
	
	if addonTable.WORLDSTATEFRAME then
		addon:FadeFrameOut(WorldStateAlwaysUpFrame);
	end;
	
end;


---- FUNCTIONS ----

function addon:HookFrames()


	WorldFrame:HookScript("OnEnter", function()
		
		if addonTable.BUFFS then
				
			if UnitName("target") == UnitName("player") then
				
			else
				addon:FadeFrameOut(BuffFrame);
			end;
			
		end;
		
		if addonTable.PLAYER then
		
			php = UnitHealth("player") / UnitHealthMax("player");
			pmp = UnitPower("player") / UnitPowerMax("player");
			
			if UnitExists("target") then
				
			else
			
				if php == 1 and (pmp == 1 or pmp == 0) then
					addon:FadeFrameOut(PlayerFrame);
				end;
			end;
		end;
	
		if addonTable.MINIMAP then
			addon:FadeFrameOut(Minimap);
			addon:FadeFrameOut(MinimapCluster);
		end;
		
		if addonTable.RAIDMANAGER then
			if not CompactRaidFrameContainer:IsShown() then
				addon:FadeFrameOut(CompactRaidFrameManager);
			end;
		end;
		
		if addonTable.OBJECTIVETRACKER then
			addon:FadeFrameOut(ObjectiveTrackerFrame);
		end;
		
		if addonTable.MAINMENUBAR then
			addon:FadeFrameOut(MainMenuBar);
		end;
		
	end);


	if addonTable.BUFFS then
		PlayerFrame:HookScript("OnEnter", function()
			addon:FadeFrameIn(BuffFrame);
		end);
		
		TopEdgeHover:HookScript("OnEnter", function()
			addon:FadeFrameIn(BuffFrame);
		end);
	end;


	if addonTable.CHATTABS then
		for i = 1, NUM_CHAT_WINDOWS do
			local chatFrameNumber = ("ChatFrame%d"):format(i);
			local ChatFrameNumberTab = _G[chatFrameNumber.."Tab"];
			
			addon:SetupBasicFading(addonTable.CHATTABS, ChatFrameNumberTab);
			
			ChatFrameNumberTab:HookScript("OnEnter", function()
				if self:IsShown() then
					addon:FadeFrameIn(GeneralDockManager);
				end;
			end);
		end;
	end;
	
	
	if addonTable.MAINMENUBAR then
	
	
		MainMenuBar:HookScript("OnEnter", function(self)
			addon:FadeFrameIn(self);
		end);
		
		
		ParentFrames = { 
		MainMenuBar, MultiBarBottomLeft, MultiBarBottomRight, 
		MultiBarLeft, MultiBarRight, StanceBarFrame, PetBarFrame,
		};
		
		
		for _, ParentFrame in ipairs(ParentFrames) do 
			ChildFrames = { ParentFrame:GetChildren() };
			
			for _, ChildFrame in ipairs(ChildFrames) do 
				ChildFrame:HookScript("OnEnter", function()
					addon:FadeFrameIn(MainMenuBar);
				end);
			end;
		end;

		
		local setScriptActionBars = {
			CharacterMicroButton,
			SpellbookMicroButton,
			TalentMicroButton,
			AchievementMicroButton,
			QuestLogMicroButton,
			GuildMicroButton,
			LFDMicroButton,
			CollectionsMicroButton,
			EJMicroButton,
			StoreMicroButton,
			MainMenuMicroButton,
			MainMenuBarBackpackButton,
			CharacterBag0Slot,
			CharacterBag1Slot,
			CharacterBag2Slot,
			CharacterBag3Slot,
		}
		

		for _, region in pairs(setScriptActionBars) do
			region:HookScript("OnEnter", function()
				addon:FadeFrameIn(MainMenuBar);
			end);
		end;
	end;


	if addonTable.MINIMAP then
		
		MinimapChildren = { Minimap:GetChildren() };
		for _, MinimapChild in ipairs(MinimapChildren) do 
			MinimapChild:HookScript("OnEnter", function()
				addon:FadeFrameIn(Minimap);
				addon:FadeFrameIn(MinimapCluster);
			end);
		end;
		
		MinimapClusterChildren = { MinimapCluster:GetChildren() };
		for _, MinimapClusterChild in ipairs(MinimapClusterChildren) do 
			MinimapClusterChild:HookScript("OnEnter", function()
				addon:FadeFrameIn(Minimap);
				addon:FadeFrameIn(MinimapCluster);
			end);
		end;
	end;


	if addonTable.RAIDMANAGER then
		if not CompactRaidFrameContainer:IsShown() then
			CompactRaidFrameManager:HookScript("OnEnter", function(self)
				addon:FadeFrameIn(self);
			end);
		end;
	end;


	if addonTable.PARTY then
		if PartyMemberFrame1:IsShown() then
			for i = 1, GetNumGroupMembers()-1 do
				local partyMemberFrameNumber = ("PartyMemberFrame%d"):format(i);
				local PartyMemberFrameNumberFrame = _G[partyMemberFrameNumber];

				addon:SetupBasicFading(addonTable.PARTY, PartyMemberFrameNumberFrame);
			end;
		end;
	end;
	
	
	if addonTable.PLAYER then
		PlayerFrame:HookScript("OnEnter", function(self)
			addon:FadeFrameIn(self);
		end);
		
		PlayerFrameChildren = { PlayerFrame:GetChildren() };
		for _, PlayerFrameChild in ipairs(PlayerFrameChildren) do 
			PlayerFrameChild:HookScript("OnEnter", function()
				addon:FadeFrameIn(PlayerFrame);
			end);
		end;
		
		PetFrameChildren = { PetFrame:GetChildren() };
		for _, PetFrameChild in ipairs(PetFrameChildren) do 
			PetFrameChild:HookScript("OnEnter", function()
				addon:FadeFrameIn(PetFrame);
			end);
		end;
	end;

	
	if addonTable.TARGET then
		TargetFrame:HookScript("OnShow", function(self)
			addon:FadeFrameIn(self);
		end);
	end;

	
	if addonTable.OBJECTIVETRACKER then
		ObjectiveTrackerFrame:SetScript("OnEnter", function(self)
			addon:FadeFrameIn(self);
		end);
		
		ObjectiveTrackerBlocksFrame:SetScript("OnEnter", function()
			addon:FadeFrameIn(ObjectiveTrackerFrame);
		end);
		
		ObjectiveTrackerFrameChildren = { ObjectiveTrackerFrame:GetChildren() };
		for _, ObjectiveTrackerFrameChild in ipairs(ObjectiveTrackerFrameChildren) do 
			ObjectiveTrackerFrameChild:SetScript("OnEnter", function()
				addon:FadeFrameIn(ObjectiveTrackerFrame);
			end);
		end;
		
		ObjectiveTrackerBlocksFrameChildren = { ObjectiveTrackerBlocksFrame:GetChildren() };
		for _, ObjectiveTrackerBlocksFrameChild in ipairs(ObjectiveTrackerBlocksFrameChildren) do 
			ObjectiveTrackerBlocksFrameChild:SetScript("OnEnter", function()
				addon:FadeFrameIn(ObjectiveTrackerFrame);
			end);
		end;
	end;
	
	
	if addonTable.WORLDSTATEFRAME then
		addon:SetupBasicFading(addonTable.WORLDSTATEFRAME, WorldStateAlwaysUpFrame);
		
		TopEdgeHover:HookScript("OnEnter", function()
			addon:FadeFrameIn(WorldStateAlwaysUpFrame);
		end);	
	end;
	
	addon:SetupBasicFading(addonTable.VEHICLESEATINDICATOR, VehicleSeatIndicator);
end;


---- MAIN ----


addon:SetScript("OnEvent", function(self, event, ...)

	if event == "PLAYER_LOGIN" then
		addon:HookFrames();
	end;
	
	if event == "PLAYER_LOGIN" 
	or event == "PLAYER_REGEN_DISABLED"
	or event == "PLAYER_REGEN_ENABLED" then
		addon:FadeOutAll();
	end;
	
	if event == "PLAYER_TARGET_CHANGED" then
		if UnitExists("target") 
		or UnitIsDead("target") then
			
			if addonTable.PLAYER then
				addon:FadeFrameIn(PlayerFrame);
			end;
			
			if addonTable.BUFFS then
				if UnitName("target") == UnitName("player") then
					addon:FadeFrameIn(BuffFrame);
				end;
			end;
			
		else
			
			if addonTable.PLAYER then
				addon:FadeFrameOut(PlayerFrame);
			end;
			
			if addonTable.BUFFS then
				addon:FadeFrameOut(BuffFrame);
			end;
		end;
	end;
	
	
	if addonTable.PLAYER then
		
		if event == "UNIT_HEALTH_FREQUENT" 
		or event == "UNIT_POWER_FREQUENT" then
		
			if  not UnitAffectingCombat("player") then
				local php = UnitHealth("player") / UnitHealthMax("player");
				local pmp = UnitPower("player") / UnitPowerMax("player");
			
				if php == 1 and (pmp == 1 or pmp == 0) then 
					if UnitExists("target") or UnitIsDead("target") then
						return;
					else 
						addon:FadeFrameOut(PlayerFrame);
					end;
				end;
			
				if php < 1 or (pmp < 1 and pmp > 0) then
					addon:FadeFrameIn(PlayerFrame);
				end;
			end;
		end;
	end;
	
	if addonTable.OBJECTIVETRACKER_PULSE then
		
		if event == "QUEST_WATCH_LIST_CHANGED" 
		or event == "UNIT_QUEST_LOG_CHANGED"
		or event == "QUEST_WATCH_UPDATE" then
			addon:FadeFrameIn(ObjectiveTrackerFrame);
			C_Timer.After(2, function() 
				addon:FadeFrameOut(ObjectiveTrackerFrame);
			end);
		end;
	end;
end);


