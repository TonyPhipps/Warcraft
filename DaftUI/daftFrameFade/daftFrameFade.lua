local addonName, addonTable = ... ;

local addonName = CreateFrame("Frame");

addonName:RegisterEvent("PLAYER_LOGIN");
addonName:RegisterEvent("PLAYER_REGEN_DISABLED");
addonName:RegisterEvent("PLAYER_REGEN_ENABLED");
addonName:RegisterEvent("PLAYER_FOCUS_CHANGED");
addonName:RegisterEvent("PLAYER_TARGET_CHANGED");
addonName:RegisterUnitEvent("UNIT_HEALTH_FREQUENT");
addonName:RegisterUnitEvent("UNIT_POWER_FREQUENT");


---- HELPER FUNCTIONS ----


function addonName:FadeFrameIn(frameName)

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


function addonName:FadeFrameOut(frameName)

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


function addonName:SetupBasicFading(setting, frameName)
	if setting then
		frameName:SetScript("OnEnter", function(self)
			addonName:FadeFrameIn(self);
		end);
		
		WorldFrame:HookScript("OnEnter", function()
			addonName:FadeFrameOut(frameName);
		end);
	end;
end;


function addonName:FadeOutAll()
	if addonTable.BUFFS then 
		addonName:FadeFrameOut(BuffFrame);
	end;
	
	if addonTable.CHATTABS then 
		for i = 1, NUM_CHAT_WINDOWS do
			local chatFrameNumber = ("ChatFrame%d"):format(i);
			local ChatFrameNumberTab = _G[chatFrameNumber.."Tab"];
			
			addonName:FadeFrameOut(ChatFrameNumberTab);
		end;
	end;
	
	if addonTable.MAINMENUBAR then
		addonName:FadeFrameOut(MainMenuBar);
	end;
	
	if addonTable.MINIMAP then	
		addonName:FadeFrameOut(Minimap);
		addonName:FadeFrameOut(MinimapCluster);
	end;
	
	if addonTable.OBJECTIVETRACKER then
		addonName:FadeFrameOut(ObjectiveTrackerFrame);
	end;

	if addonTable.PARTY then
		for i = 1, GetNumGroupMembers()-1 do
			local partyMemberFrameNumber = ("PartyMemberFrame%d"):format(i);
			local PartyMemberFrameNumber = _G[partyMemberFrameNumber];
			addonName:FadeFrameOut(PartyMemberFrameNumber);
			
		end;
	end;
	
	if addonTable.PLAYER then 
		addonName:FadeFrameOut(PlayerFrame);
	end;

	if addonTable.RAIDMANAGER then
		if not CompactRaidFrameContainer:IsShown() then
			addonName:FadeFrameOut(CompactRaidFrameManager);
		end;
	end;
	
	if addonName.VEHICLESEATINDICATOR then
		addonName.FadeFrameOut(VehicleSeatIndicator);
	end;
	
	if addonName.WORLDSTATEFRAME then
		addonName.FadeFrameOut(WorldStateAlwaysUpFrame);
	end;

end;


---- FUNCTIONS ----

function addonName:HookFrames()


	WorldFrame:HookScript("OnEnter", function()
		
		if addonTable.BUFFS then
				
				if UnitName("target") == UnitName("player") then
					
				else
					addonName:FadeFrameOut(BuffFrame);
				end;
				
			end;
		
		
		if addonTable.MINIMAP then
			addonName:FadeFrameOut(Minimap);
			addonName:FadeFrameOut(MinimapCluster);
		end;
		
		if addonTable.RAIDMANAGER then
			if not CompactRaidFrameContainer:IsShown() then
				addonName:FadeFrameOut(CompactRaidFrameManager);
			end;
		end;
		
	end);


	if addonTable.BUFFS then
		PlayerFrame:HookScript("OnEnter", function()
			addonName:FadeFrameIn(BuffFrame);
		end);
	end;


	if addonTable.CHATTABS then
		for i = 1, NUM_CHAT_WINDOWS do
			local chatFrameNumber = ("ChatFrame%d"):format(i);
			local ChatFrameNumberTab = _G[chatFrameNumber.."Tab"];
			
			addonName:SetupBasicFading(addonTable.CHATTABS, ChatFrameNumberTab);
			
			ChatFrameNumberTab:HookScript("OnEnter", function()
				if self:IsShown() then
					addonName:FadeFrameIn(GeneralDockManager);
				end;
			end);
		end;
	end;
	
	
	if addonTable.MAINMENUBAR then
		
		local setScriptActionBars = { 
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
				addonName:FadeFrameIn(MainMenuBar);
			end);
		end;
	end;


	if addonTable.MINIMAP then
		Minimap:HookScript("OnEnter", function(self)
			addonName:FadeFrameIn(self);
			addonName:FadeFrameIn(MinimapCluster);
		end);
		
		MinimapCluster:HookScript("OnEnter", function(self)
			addonName:FadeFrameIn(self);
			addonName:FadeFrameIn(Minimap);
		end);
	end;


	if addonTable.RAIDMANAGER then
		if not CompactRaidFrameContainer:IsShown() then
			CompactRaidFrameManager:HookScript("OnEnter", function(self)
				addonName:FadeFrameIn(self);
			end);
		end;
	end;


	if addonTable.PARTY then
		for i = 1, GetNumGroupMembers()-1 do
			local partyMemberFrameNumber = ("PartyMemberFrame%d"):format(i);
			local PartyMemberFrameNumber = _G[partyMemberFrameNumber];

			addonName:SetupBasicFading(addonTable.PARTY, PartyMemberFrameNumber);
		end;
	end;
	
	
	if addonTable.PLAYER then
		PlayerFrame:HookScript("OnEnter", function(self)
			addonName:FadeFrameIn(self);
		end);
		
		PlayerFrame:HookScript("OnLeave", function(self)
			php = UnitHealth("player") / UnitHealthMax("player");
			pmp = UnitPower("player") / UnitPowerMax("player");
			
			if UnitExists("target") then
				return;
			else
				if php == 1 and (pmp == 1 or pmp == 0) then
					addonName:FadeFrameOut(self);
				end;
			end;
		end);
	end;


	addonName:SetupBasicFading(addonTable.VEHICLESEATINDICATOR, VehicleSeatIndicator);
	addonName:SetupBasicFading(addonTable.OBJECTIVETRACKER, ObjectiveTrackerFrame);
	addonName:SetupBasicFading(addonTable.MAINMENUBAR, MainMenuBar);
	addonName:SetupBasicFading(addonTable.WORLDSTATEFRAME, WorldStateAlwaysUpFrame);

end;


---- MAIN ----


addonName:SetScript("OnEvent", function(self, event, ...)
	local thp = UnitHealth("target") / UnitHealthMax("target");
	local tmp = UnitPower("target") / UnitPowerMax("target");

	if event == "PLAYER_LOGIN" then
		addonName:HookFrames();
	end;
	
	if event == "PLAYER_LOGIN" or
	event == "PLAYER_REGEN_DISABLED" or
	event == "PLAYER_REGEN_ENABLED" 
	then
		addonName:FadeOutAll();
	end;
	
	if event == "PLAYER_TARGET_CHANGED" then
		if UnitExists("target") or UnitIsDead("target") then
			
			if addonTable.PLAYER then
				addonName:FadeFrameIn(PlayerFrame);
			end;
			
			if addonTable.BUFFS then
				if UnitName("target") == UnitName("player") then
					addonName:FadeFrameIn(BuffFrame);
				end;
			end;
			
			if addonTable.TARGET then
				addonName:FadeFrameIn(TargetFrame);
			end;
		else
			
			if addonTable.PLAYER then
				addonName:FadeFrameOut(PlayerFrame);
			end;
			
			if addonTable.BUFFS then
				addonName:FadeFrameOut(BuffFrame);
			end;
			
			if addonTable.TARGET then
				TargetFrame:Hide();
			end;
		end;
	end;
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_POWER_FREQUENT" then
		
		if addonTable.PLAYER then
			local php = UnitHealth("player") / UnitHealthMax("player");
			local pmp = UnitPower("player") / UnitPowerMax("player");
		
			if php == 1 and (pmp == 1 or pmp == 0) then 
				if UnitExists("target") or UnitIsDead("target") then
					return;
				else 
					addonName:FadeFrameOut(PlayerFrame);
				end;
			end;
		
			if php < 1 or (pmp < 1 and pmp > 0) then
				addonName:FadeFrameIn(PlayerFrame);
			end;
		end;
	end;
end);


