local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");


addon:RegisterEvent("PLAYER_LOGIN");
addon:RegisterEvent("UNIT_SPELLCAST_START");
addon:RegisterEvent("UNIT_SPELLCAST_SENT");


---- FUNCTIONS ----

function addon:SetupFrames()

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
		
		if addonTable.PLAYER_HIDE_PVP_ICON then
			PlayerPVPIcon:SetAlpha(0);
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
		
		if addonTable.TARGET_HIDE_PVP_ICON then
			TargetFrameTextureFramePVPIcon:SetAlpha(0);
		end;
	end;
end;


function addon:SetupOnShowHide()
	CastingBarFrame:HookScript("OnShow", function(self, event, ...)
		
		if addonTable.PLAYER_ENABLED then
			PlayerName:Hide();
			PlayerStatusTexture:Hide();
			PlayerFrameBackground:Hide();
			
			if addonTable.PLAYER_BIG_SPELL_ICON and not addonTable.PLAYER_HIDE_SPELL_ICON then
				PlayerPortrait:Hide();

				if (CastingBarFrame.Icon:GetTexture() == "INTERFACE\\ICONS\\thumbsdown") 
				or (CastingBarFrame.Icon:GetTexture() == "Portrait2") then
					return;
				else
					SetPortraitToTexture(CastingBarFrame.Icon, CastingBarFrame.Icon:GetTexture());
				end;
			end;

			if not addonTable.PLAYER_BIG_SPELL_ICON 
			and not addonTable.PLAYER_HIDE_SPELL_ICON then
				CastingBarFrame.Icon:Show();
			end;
		end;
	end);

	
	CastingBarFrame:HookScript("OnHide", function(self, event, ...)
		if addonTable.PLAYER_ENABLED then
			PlayerName:Show();
			PlayerStatusTexture:Show();
			PlayerFrameBackground:Show();
			PlayerPortrait:Show();
		end;
	end);
	

	TargetFrameSpellBar:HookScript("OnShow", function(self, event, ...)
		if addonTable.TARGET_ENABLED then
			_, _, _, _, _, _, _, _, notInterruptible = UnitCastingInfo("target");

			TargetFrameTextureFrameName:Hide();
			TargetFrameNameBackground:Hide();
			TargetFramePortrait:Hide();
				
			if addonTable.TARGET_BIG_SPELL_ICON then
				TargetFramePortrait:Hide();
			end;

			if addonTable.TARGET_HIDE_SPELL_ICON then
				TargetFrameSpellBar.Icon:Hide();
			end;
			
			if notInterruptible then
				TargetFrameTextureFrameQuestIcon:Show();
				TargetFrameTextureFrameQuestIcon:SetVertexColor(1, 0, 0, 1);
			else
				TargetFrameTextureFrameQuestIcon:SetVertexColor(1, 1, 1, 1);
			end;
			
		end;
	end);

	
	TargetFrameSpellBar:HookScript("OnHide", function(self, event, ...)
		if addonTable.TARGET_ENABLED then
			TargetFrameTextureFrameName:Show();
			TargetFrameNameBackground:Show();
			TargetFramePortrait:Show();
			TargetFrameTextureFrameQuestIcon:Hide();
		end;
	end);
end;


function addon:SetupTimers()
	if addonTable.PLAYER_TIMER then
		CastingBarFrame.update = .1;
		
		CastingBarFrame:HookScript('OnUpdate', function(self, elapsed)

			if self.update and self.update < elapsed then
				
				if self.casting then
					PlayerLevelText:Show();
					PlayerAttackIcon:SetAlpha(.2);
					PlayerLevelText:SetText(format("%.1f", max(self.maxValue - self.value, 0)));
				
				elseif self.channeling then
					PlayerLevelText:SetText(format("%.1f", max(self.value, 0)));
				
				else
					PlayerLevelText:SetText(UnitLevel("player"));
					PlayerAttackIcon:SetAlpha(1);
				end;
				
				self.update = .1;
			
			else
				self.update = self.update - elapsed;
			end;
		end);
	end;
	
	if addonTable.TARGET_TIMER then
		TargetFrameSpellBar.update = .1;
		
		TargetFrameSpellBar:HookScript('OnUpdate', function(self, elapsed)

			if self.update and self.update < elapsed then
				
				if self.casting then
					TargetFrameTextureFrameLevelText:SetText(format("%.1f", max(self.maxValue - self.value, 0)));
				
				elseif self.channeling then
					TargetFrameTextureFrameLevelText:SetText(format("%.1f", max(self.value, 0)));
				
				else
					TargetFrameTextureFrameLevelText:SetText(UnitLevel("player"));
				end;
				
				self.update = .1;
			
			else
				self.update = self.update - elapsed;
			end;
		end);
	end;
end;


---- REGISTERED EVENTS ----

addon:SetScript("OnEvent", function(self, event, ...)

	if event == "PLAYER_LOGIN" then
		addon:SetupFrames();
		addon:SetupOnShowHide();
		addon:SetupTimers();
	end;
	
	if event == "UNIT_SPELLCAST_START" 
	or event == "UNIT_SPELLCAST_SENT" then
		local arg1 = ...;
		
		
		if arg1 == "player" then
			if addonTable.PLAYER_BIG_SPELL_ICON and not addonTable.PLAYER_HIDE_SPELL_ICON then
				SetPortraitToTexture(CastingBarFrame.Icon, CastingBarFrame.Icon:GetTexture());
			end;
		end;
		
		if arg1 == "target" then
			if addonTable.TARGET_BIG_SPELL_ICON then
				TargetFrameSpellBar.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
			end;
		end;
	end;

end);


