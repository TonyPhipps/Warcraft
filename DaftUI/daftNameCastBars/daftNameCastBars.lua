local addonName, addonTable = ... ;
local addonName = CreateFrame("Frame");

addonName:RegisterEvent("PLAYER_LOGIN");
addonName:RegisterEvent("PLAYER_TARGET_CHANGED");
addonName:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
addonName:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
addonName:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
addonName:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
addonName:RegisterEvent("UNIT_SPELLCAST_START");
addonName:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");


---- FUNCTIONS ----

local function SetupFrames()
	if addonTable.PLAYER_ENABLED then
		CastingBarFrame:SetFrameStrata("BACKGROUND");
		CastingBarFrame.Border:Hide();

		CastingBarFrame:SetWidth(PlayerFrameHealthBar:GetWidth());
		CastingBarFrame:SetHeight(PlayerName:GetHeight()*1.8);
		CastingBarFrame:ClearAllPoints();
		CastingBarFrame:SetPoint("CENTER", PlayerName, "CENTER", 0, -1);
		CastingBarFrame.SetPoint = function() end;

		CastingBarFrame.Text:ClearAllPoints();
		CastingBarFrame.Text:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0);
		CastingBarFrame.Text.SetPoint = function() end;

		CastingBarFrame.Border:SetWidth(CastingBarFrame:GetWidth()*1.38);
		CastingBarFrame.Border:SetHeight(CastingBarFrame:GetHeight()*3.6);
		CastingBarFrame.Border:ClearAllPoints();
		CastingBarFrame.Border:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0);
		CastingBarFrame.Border.SetPoint = function() end;
		CastingBarFrame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small");

		CastingBarFrame.Flash:SetWidth(CastingBarFrame.Border:GetWidth());
		CastingBarFrame.Flash:SetHeight(CastingBarFrame.Border:GetHeight());
		CastingBarFrame.Flash:ClearAllPoints();
		CastingBarFrame.Flash:SetPoint("CENTER", CastingBarFrame.Border, "CENTER", 0, 0);
		CastingBarFrame.Flash.SetPoint = function() end;
		CastingBarFrame.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small");

		CastingBarFrame.Text:SetFontObject(GameFontNormalSmall);
		CastingBarFrame.Text:SetVertexColor(1, 1, 1);
		
		if addonTable.PLAYER_BIG_SPELL_ICON and not addonTable.PLAYER_HIDE_SPELL_ICON then
			CastingBarFrame.Icon:Show();
			CastingBarFrame.Icon:ClearAllPoints();
			CastingBarFrame.Icon:SetPoint("CENTER", PlayerPortrait, "CENTER", 0, 0);
			CastingBarFrame.Icon:SetWidth(PlayerPortrait:GetWidth()*.83);
			CastingBarFrame.Icon:SetHeight(PlayerPortrait:GetHeight()*.83);
			CastingBarFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9);
		end;
		
		if not addonTable.PLAYER_BIG_SPELL_ICON and not addonTable.PLAYER_HIDE_SPELL_ICON then
			CastingBarFrame.Icon:ClearAllPoints();
			CastingBarFrame.Icon:SetPoint("LEFT", CastingBarFrame, "RIGHT", 5, 0);
			CastingBarFrame.Icon.SetPoint = function() end;
		end;
	end;


	if addonTable.TARGET_ENABLED then
		TargetFrameSpellBar:SetFrameStrata("BACKGROUND");

		TargetFrameSpellBar:ClearAllPoints();
		TargetFrameSpellBar:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",7,-22);
		TargetFrameSpellBar:SetPoint("BOTTOMRIGHT",TargetFrame,"BOTTOMRIGHT",-109.5, 60);
		TargetFrameSpellBar.SetPoint = function() end;
		
		TargetFrameSpellBar.Flash:ClearAllPoints()
		TargetFrameSpellBar.Flash:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, -2);
		TargetFrameSpellBar.Flash:SetWidth(TargetFrameSpellBar:GetWidth()*1.38);
		TargetFrameSpellBar.Flash:SetHeight(TargetFrameSpellBar:GetHeight()*3.6);
		TargetFrameSpellBar.Flash.SetPoint = function() end;

		TargetFrameSpellBar.BorderShield:SetAlpha(0);
		TargetFrameSpellBar.Border:SetAlpha(0);

		TargetFrameSpellBar.Text:ClearAllPoints();
		TargetFrameSpellBar.Text:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, -1);
		
		if addonTable.TARGET_BIG_SPELL_ICON then
			TargetFrameSpellBar.Icon:ClearAllPoints();
			TargetFrameSpellBar.Icon:SetPoint("CENTER", TargetFramePortrait, "CENTER", 0, 0);
			TargetFrameSpellBar.Icon:SetWidth(TargetFramePortrait:GetWidth());
			TargetFrameSpellBar.Icon:SetHeight(TargetFramePortrait:GetHeight());
			TargetFrameSpellBar.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
		end;
	end;
end;


---- REGISTERED EVENTS ----
addonName:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		SetupFrames();
	end;


	if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" or event == "UNIT_SPELLCAST_CHANNEL_UPDATE" then
		local unitID = ...;
		
		if addonTable.PLAYER_ENABLED and unitID == "player" then
			PlayerName:Hide();
			PlayerStatusTexture:Hide();
			PlayerFrameBackground:Hide();
			
			if addonTable.PLAYER_BIG_SPELL_ICON and not addonTable.PLAYER_HIDE_SPELL_ICON then
				PlayerPortrait:Hide();

				if (CastingBarFrame.Icon:GetTexture() == "INTERFACE\\ICONS\\thumbsdown") or (CastingBarFrame.Icon:GetTexture() == "Portrait2") then
					return;
				else
					SetPortraitToTexture(CastingBarFrame.Icon, CastingBarFrame.Icon:GetTexture());
				end;
			end;

			if not addonTable.PLAYER_BIG_SPELL_ICON and not addonTable.PLAYER_HIDE_SPELL_ICON then
				CastingBarFrame.Icon:Show();
			end;
		end;
		
		if addonTable.TARGET_ENABLED and unitID == "target" then
			TargetFrameTextureFrameName:Hide();
			TargetFrameNameBackground:Hide();
			
			if addonTable.TARGET_BIG_SPELL_ICON then
				TargetFramePortrait:Hide();
			end;

			if addonTable.TARGET_HIDE_SPELL_ICON then
				TargetFrameSpellBar.Icon:Hide();
			end;
		end;
		
	end;
	
	if event == "UNIT_SPELLCAST_INTERRUPTED" then
		local unitID = ...;

		if addonTable.PLAYER_ENABLED and unitID == "player" then
			local castName = UnitCastingInfo("player") or UnitChannelInfo("player");
				
			C_Timer.After(1, function()
					if castName then return; end;
					UIFrameFadeIn(PlayerName, 0.2, 0, 1);
					UIFrameFadeIn(PlayerStatusTexture, 0.2, 0, 1);
					UIFrameFadeIn(PlayerFrameBackground, 0.2, 0, 0.6);
					UIFrameFadeIn(PlayerPortrait, 0.2, 0, 1);
			end);
		end;
		
		if addonTable.TARGET_ENABLED and unitID == "target" then
			local castName = UnitCastingInfo("target") or UnitChannelInfo("target");

			C_Timer.After(1, function()
				if castName then return; end;
				UIFrameFadeIn(TargetFrameTextureFrameName, 0.2, 0, 1);
				UIFrameFadeIn(TargetFrameNameBackground, 0.2, 0, 0.6);
				UIFrameFadeIn(TargetFramePortrait, 0.2, 0, 1);
			end);

		end;
	end;
	
	
	if event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_CHANNEL_STOP" then
		local unitID = ...;

		if addonTable.PLAYER_ENABLED and unitID == "player" then
			PlayerName:Show();
			PlayerStatusTexture:Show();
			PlayerFrameBackground:Show();
			PlayerPortrait:Show();
		end;
		
		if addonTable.TARGET_ENABLED and unitID == "target" then
			UIFrameFadeIn(TargetFrameTextureFrameName, 0.2, 0, 1);
			UIFrameFadeIn(TargetFrameNameBackground, 0.2, 0, 0.6);
			UIFrameFadeIn(TargetFramePortrait, 0.2, 0, 1);
		end;
	end;
	
	
	if event == "PLAYER_TARGET_CHANGED" then
		
		if addonTable.TARGET_ENABLED then
			local name = UnitCastingInfo("target");
			
			if not name then
				TargetFrameTextureFrameName:Show();
				TargetFrameNameBackground:Show();
				TargetFramePortrait:Show();
			else
				TargetFrameTextureFrameName:Hide();
				TargetFrameNameBackground:Hide();
				
				if addonTable.TARGET_BIG_SPELL_ICON then
					TargetFramePortrait:Hide();
				end;
				
				if addonTable.TARGET_HIDE_SPELL_ICON then
					TargetFrameSpellBar.Icon:Hide();
				end;
			end;
		end;
	end;
end);




