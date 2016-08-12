---- CONFIG ----


-- FadeIn, TimetoFadeIn, FadeOut, TimetoFadeOut
------------------------{ TTF,  IN, TTF, OUT }
local NOCOMBAT_FADE = 	{ 1.0, 0.8, 1.0, 0.1 }
local COMBAT_FADE = 	{ 0.5, 1.0, 0.5, 0.8 }

-- true for enable, false for disable.
local MINIMAP = true
local PLAYER = true
local TARGET = true
local MAINMENUBAR = true
local PARTY = true
local OBJECTIVETRACKER = true
local RAIDMANAGER = true
local BUFFS = true


---- SETUP ----


local daftFrameFade = CreateFrame("Frame")


---- EVENTS ----


daftFrameFade:RegisterEvent("PLAYER_LOGIN")
daftFrameFade:RegisterEvent("PLAYER_ENTER_COMBAT")
daftFrameFade:RegisterEvent("PLAYER_LEAVE_COMBAT")
daftFrameFade:RegisterEvent("PLAYER_FOCUS_CHANGED")
daftFrameFade:RegisterEvent("PLAYER_TARGET_CHANGED")
daftFrameFade:RegisterUnitEvent("UNIT_HEALTH_FREQUENT")
daftFrameFade:RegisterUnitEvent("UNIT_POWER_FREQUENT")


---- FUNCTIONS ----


function daftFrameFade:FadeFrameIn(frame)
	if UnitAffectingCombat("player") then
		UIFrameFadeIn(frame, COMBAT_FADE[1], frame:GetAlpha(), COMBAT_FADE[2])
	else
		UIFrameFadeIn(frame, NOCOMBAT_FADE[1], frame:GetAlpha(), NOCOMBAT_FADE[2])
	end
end


function daftFrameFade:FadeFrameOut(frame)
	if UnitAffectingCombat("player") then
		UIFrameFadeOut(frame, COMBAT_FADE[3], frame:GetAlpha(), COMBAT_FADE[4])
	else
		UIFrameFadeOut(frame, NOCOMBAT_FADE[3], frame:GetAlpha(), NOCOMBAT_FADE[4])
	end
end


function daftFrameFade:FadeOutAll()
	if PLAYER then 
		daftFrameFade:FadeFrameOut(PlayerFrame)
	end
	
	if BUFFS then 
		daftFrameFade:FadeFrameOut(BuffFrame)
	end
	

	if MINIMAP then	
		daftFrameFade:FadeFrameOut(Minimap)
		daftFrameFade:FadeFrameOut(MinimapCluster)
	end
	
	if OBJECTIVETRACKER then
		daftFrameFade:FadeFrameOut(ObjectiveTrackerFrame)
	end
	
	if MAINMENUBAR then
		daftFrameFade:FadeFrameOut(MainMenuBar)
	end
	
	if RAIDMANAGER then
		if UnitInRaid("player") then
			if not CompactRaidFrameContainer:IsShown() then
				daftFrameFade:FadeFrameOut(CompactRaidFrameManager)
			end
		else
			if PARTY then
				if UnitExists("party1") then
					daftFrameFade:FadeFrameOut(PartyMemberFrame1)
				end
				
				if UnitExists("party2") then
					daftFrameFade:FadeFrameOut(PartyMemberFrame2)
				end
				
				if UnitExists("party3") then
					daftFrameFade:FadeFrameOut(PartyMemberFrame3)
				end
				
				if UnitExists("party4") then
					daftFrameFade:FadeFrameOut(PartyMemberFrame4)
				end
			end
		end
	end
end


daftFrameFade:SetScript("OnEvent", function(self, event, ...)
	local thp = UnitHealth("target") / UnitHealthMax("target")
	local tmp = UnitPower("target") / UnitPowerMax("target")

	if event == "PLAYER_LOGIN" or
	event == "PLAYER_ENTER_COMBAT" or
	event == "PLAYER_LEAVE_COMBAT" 	then
		daftFrameFade:FadeOutAll()
	end
	
	if event == "PLAYER_TARGET_CHANGED" then
		
		if UnitExists("target") or UnitIsDead("target") then
			
			if PLAYER then
				daftFrameFade:FadeFrameIn(PlayerFrame)
			end
			
			if BUFFS then
				if UnitName("target") == UnitName("player") then
					daftFrameFade:FadeFrameIn(BuffFrame)
				end
			end
			
			if TARGET then
				daftFrameFade:FadeFrameIn(TargetFrame)
			end
		else
			
			if PLAYER then
				daftFrameFade:FadeFrameOut(PlayerFrame)
			end
			
			if BUFFS then
				daftFrameFade:FadeFrameOut(BuffFrame)
			end
			
			if TARGET then
				TargetFrame:Hide()
			end
		end	
	end
	
	if event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_POWER_FREQUENT" then
		
		if PLAYER then
			local php = UnitHealth("player") / UnitHealthMax("player")
			local pmp = UnitPower("player") / UnitPowerMax("player")
		
			if php == 1 and (pmp == 1 or pmp == 0) then 
				if UnitExists("target") or UnitIsDead("target") then
					return
				else 
					daftFrameFade:FadeFrameOut(PlayerFrame)
				end
			end
		
			if php < 1 or (pmp < 1 and pmp > 0) then
				daftFrameFade:FadeFrameIn(PlayerFrame)
			end
		end
	end
end)


------- MAIN -------


WorldFrame:HookScript("OnEnter", function()
	
	if MAINMENUBAR then
		daftFrameFade:FadeFrameOut(MainMenuBar)
	end
	
	if BUFFS then
		
		if UnitName("target") == UnitName("player") then
			return
		else
			daftFrameFade:FadeFrameOut(BuffFrame)
		end
		
	end
	
	if OBJECTIVETRACKER then
		daftFrameFade:FadeFrameOut(ObjectiveTrackerFrame)
	end
	
	if MINIMAP then
		daftFrameFade:FadeFrameOut(Minimap)
		daftFrameFade:FadeFrameOut(MinimapCluster)
	end
	
	if RAIDMANAGER then
		if UnitInRaid("player") then
			if not CompactRaidFrameContainer:IsShown() then
				daftFrameFade:FadeFrameOut(CompactRaidFrameManager)
			end
		else
		
			if UnitExists("party1") then
				daftFrameFade:FadeFrameOut(PartyMemberFrame1)
			else
				return
			end
			
			if UnitExists("party2") then
				daftFrameFade:FadeFrameOut(PartyMemberFrame2)
			else
				return
			end
			
			if UnitExists("party3") then
				daftFrameFade:FadeFrameOut(PartyMemberFrame3)
			else
				return
			end
			
			if UnitExists("party4") then
				daftFrameFade:FadeFrameOut(PartyMemberFrame4)
			else
				return
			end
		end
	end
end)


if PLAYER then
	PlayerFrame:HookScript("OnEnter", function(self)
		daftFrameFade:FadeFrameIn(self)
	end)
	
	PlayerFrame:HookScript("OnLeave", function(self)
		php = UnitHealth("player") / UnitHealthMax("player")
		pmp = UnitPower("player") / UnitPowerMax("player")
		
		if UnitExists("target") then
			return
		else
			if php == 1 and (pmp == 1 or pmp == 0) then
				daftFrameFade:FadeFrameOut(self)
			end
		end
	end)
end


if BUFFS then
	PlayerFrame:HookScript("OnEnter", function()
		daftFrameFade:FadeFrameIn(BuffFrame)
	end)
end
	

if MINIMAP then
	Minimap:HookScript("OnEnter", function(self)
		daftFrameFade:FadeFrameIn(self)
		daftFrameFade:FadeFrameIn(MinimapCluster)
	end)
	
	MinimapCluster:HookScript("OnEnter", function(self)
		daftFrameFade:FadeFrameIn(self)
		daftFrameFade:FadeFrameIn(Minimap)
	end)
end


if MAINMENUBAR then
	MainMenuBar:HookScript("OnEnter", function(self)
		daftFrameFade:FadeFrameIn(self)
	end)
	
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
			daftFrameFade:FadeFrameIn(MainMenuBar)
		end)
	end
end


if OBJECTIVETRACKER then
	ObjectiveTrackerFrame:SetScript("OnEnter", function(self)
		daftFrameFade:FadeFrameIn(self)
	end)
end


if RAIDMANAGER then
	CompactRaidFrameManager:HookScript("OnEnter", function(self)

		if UnitInRaid("player") then
			daftFrameFade:FadeFrameIn(self)
		end
	end)
end


if PARTY then
	PartyMemberFrame1:SetScript("OnEnter", function(self)

		if not UnitInRaid("player") then
		
			if UnitExists("party1") then
				daftFrameFade:FadeFrameIn(self)
			end
		end
	end)


	PartyMemberFrame2:SetScript("OnEnter", function(self)

		if not UnitInRaid("player") then
		
			if UnitExists("party2") then
				daftFrameFade:FadeFrameIn(self)
			end
		end
	end)


	PartyMemberFrame3:SetScript("OnEnter", function(self)

		if not UnitInRaid("player") then
		
			if UnitExists("party3") then
				daftFrameFade:FadeFrameIn(self)
			end
		end
	end)


	PartyMemberFrame4:SetScript("OnEnter", function(self)

		if not UnitInRaid("player") then
		
			if UnitExists("party4") then
				daftFrameFade:FadeFrameIn(self)
			end
		end
	end)
end


---- TODO ----
-- Per-frame enable/disable
-- ChatFrame
-- VehicleSeatIndicator
-- Boss1TargetFrame
-- WorldStateAlwaysUpFrame