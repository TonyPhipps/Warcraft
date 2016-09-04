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


---- HELPER FUNCTIONS ----


function addon:FadeFrameIn(frameName)

	if UnitAffectingCombat("player") then
		if frameName:IsShown() then
			UIFrameFadeIn(frameName, addonTable.COMBAT_TIMETOFADEIN, frameName:GetAlpha(), addonTable.COMBAT_FADEIN);
		end;
	else
		if frameName:IsShown() then
			UIFrameFadeIn(frameName, addonTable.NOCOMBAT_TIMETOFADEIN, frameName:GetAlpha(), addonTable.NOCOMBAT_FADEIN);
		end;
	end;
end;


function addon:FadeFrameOut(frameName)

	if UnitAffectingCombat("player") or InCombatLockdown() then
		if frameName:IsShown() then
			UIFrameFadeOut(frameName, addonTable.COMBAT_TIMETOFADEOUT, frameName:GetAlpha(), addonTable.COMBAT_FADEOUT);
		end;
	else
		if frameName:IsShown() then
			UIFrameFadeOut(frameName, addonTable.NOCOMBAT_TIMETOFADEOUT, frameName:GetAlpha(), addonTable.NOCOMBAT_FADEOUT);
		end;
	end;
end;


function addon:SetupBasicFading(setting, frameName)
	if setting then
		frameName:SetScript("OnEnter", function(frameName)
			addon:FadeFrameIn(frameName);
		end);
		
		WorldFrame:HookScript("OnEnter", function()
			addon:FadeFrameOut(frameName);
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
		
		
		if addonTable.MINIMAP then
			addon:FadeFrameOut(Minimap);
			addon:FadeFrameOut(MinimapCluster);
		end;
		
		if addonTable.RAIDMANAGER then
			if not CompactRaidFrameContainer:IsShown() then
				addon:FadeFrameOut(CompactRaidFrameManager);
			end;
		end;
		
	end);


	if addonTable.BUFFS then
		PlayerFrame:HookScript("OnEnter", function()
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
		
		local setScriptActionBars = {
			ExtraActionBarFrame,
			MultiBarBottomLeft, 
			MultiBarBottomLeftButton1,
			MultiBarBottomLeftButton2,
			MultiBarBottomLeftButton3,
			MultiBarBottomLeftButton4,
			MultiBarBottomLeftButton5,
			MultiBarBottomLeftButton6,
			MultiBarBottomLeftButton7,
			MultiBarBottomLeftButton8,
			MultiBarBottomLeftButton9,
			MultiBarBottomLeftButton10,
			MultiBarBottomLeftButton11,
			MultiBarBottomLeftButton12,
			MultiBarBottomRight, 
			MultiBarBottomRightButton1,
			MultiBarBottomRightButton2,
			MultiBarBottomRightButton3,
			MultiBarBottomRightButton4,
			MultiBarBottomRightButton5,
			MultiBarBottomRightButton6,
			MultiBarBottomRightButton7,
			MultiBarBottomRightButton8,
			MultiBarBottomRightButton9,
			MultiBarBottomRightButton10,
			MultiBarBottomRightButton11,
			MultiBarBottomRightButton12,
			MultiBarLeft,
			MultiBarLeftButton1,
			MultiBarLeftButton2,
			MultiBarLeftButton3,
			MultiBarLeftButton4,
			MultiBarLeftButton5,
			MultiBarLeftButton6,
			MultiBarLeftButton7,
			MultiBarLeftButton8,
			MultiBarLeftButton9,
			MultiBarLeftButton10,
			MultiBarLeftButton11,
			MultiBarLeftButton12,
			MultiBarRight,
			MultiBarRightButton1,
			MultiBarRightButton2,
			MultiBarRightButton3,
			MultiBarRightButton4,
			MultiBarRightButton5,
			MultiBarRightButton6,
			MultiBarRightButton7,
			MultiBarRightButton8,
			MultiBarRightButton9,
			MultiBarRightButton10,
			MultiBarRightButton11,
			MultiBarRightButton12,
			StanceButton1,
			StanceButton2,
			StanceButton3,
			StanceButton4,
			StanceButton5,
		}

		for _, region in pairs(setScriptActionBars) do
			region:HookScript("OnEnter", function()
				addon:FadeFrameIn(MainMenuBar);
			end);
		end;
	end;


	if addonTable.MINIMAP then
		Minimap:HookScript("OnEnter", function(self)
			addon:FadeFrameIn(self);
			addon:FadeFrameIn(MinimapCluster);
		end);
		
		MinimapCluster:HookScript("OnEnter", function(self)
			addon:FadeFrameIn(self);
			addon:FadeFrameIn(Minimap);
		end);
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
		
		PlayerFrame:HookScript("OnLeave", function(self)
			php = UnitHealth("player") / UnitHealthMax("player");
			pmp = UnitPower("player") / UnitPowerMax("player");
			
			if UnitExists("target") then
				return;
			else
				if php == 1 and (pmp == 1 or pmp == 0) then
					addon:FadeFrameOut(self);
				end;
			end;
		end);
	end;

	if addonTable.TARGET then
		TargetFrame:HookScript("OnShow", function(self)
			addon:FadeFrameIn(self);
		end);
	end;

	addon:SetupBasicFading(addonTable.VEHICLESEATINDICATOR, VehicleSeatIndicator);
	addon:SetupBasicFading(addonTable.OBJECTIVETRACKER, ObjectiveTrackerFrame);
	addon:SetupBasicFading(addonTable.MAINMENUBAR, MainMenuBar);
	addon:SetupBasicFading(addonTable.WORLDSTATEFRAME, WorldStateAlwaysUpFrame);

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
		or event == "QUEST_WATCH_UPDATE" then
			addon:FadeFrameIn(ObjectiveTrackerFrame);
			C_Timer.After(2, function() 
				addon:FadeFrameOut(ObjectiveTrackerFrame);
			end);
		end;
	end;
end);


