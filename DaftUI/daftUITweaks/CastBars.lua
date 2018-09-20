local addonName, addonTable = ... 
local frame = CreateFrame("Frame")


-- EVENTS

frame:RegisterEvent("ADDON_LOADED")


-- FUNCTIONS

	local function ShowPlayerCastBar()
		
		PlayerName:Hide()
		PlayerStatusTexture:Hide()
		PlayerFrameBackground:Hide()
		
		if addonTable.db.PLAYER_TIMER then
			
			PlayerAttackIcon:SetAlpha(.2)
			PlayerRestIcon:SetAlpha(.2)
		end
		
		if addonTable.db.PLAYER_BIG_SPELL_ICON and not addonTable.db.PLAYER_HIDE_SPELL_ICON then

			PlayerPortrait:Hide()

			if (CastingBarFrame.Icon:GetTexture() == "INTERFACE\\ICONS\\thumbsdown") -- fixes "not found" error
			or (CastingBarFrame.Icon:GetTexture() == "Portrait2")
			or (CastingBarFrame.Icon:GetTexture() == "Interface\Icons\pet_type_undead") then
				return
			else
				SetPortraitToTexture(CastingBarFrame.Icon, CastingBarFrame.Icon:GetTexture())
			end
		end

		if not addonTable.db.PLAYER_BIG_SPELL_ICON 
		and not addonTable.db.PLAYER_HIDE_SPELL_ICON then
		
			CastingBarFrame.Icon:Show()
		end
	end

	local function ShowTargetCastBar()
		
		_, _, _, _, _, _, _, notInterruptible = UnitCastingInfo("target")

		TargetFrameTextureFrameName:Hide()
		TargetFrameNameBackground:Hide()
		TargetFramePortrait:Hide()
			
		if addonTable.db.TARGET_BIG_SPELL_ICON then
		
			TargetFramePortrait:Hide()
		end

		if addonTable.db.TARGET_HIDE_SPELL_ICON then
		
			TargetFrameSpellBar.Icon:Hide()
		end
		
		if notInterruptible then
		
			TargetFrameTextureFrameQuestIcon:Show()
			TargetFrameTextureFrameQuestIcon:SetVertexColor(1, 0, 0, 1)
		else
			
			TargetFrameTextureFrameQuestIcon:SetVertexColor(1, 1, 1, 1)
		end
	end

	local function SetupPlayerFrame()

		CastingBarFrame:SetFrameStrata("BACKGROUND")
		CastingBarFrame.Border:Hide()

		CastingBarFrame:SetWidth(PlayerFrameHealthBar:GetWidth())
		CastingBarFrame:SetHeight(PlayerName:GetHeight()*1.8)
		CastingBarFrame:ClearAllPoints()
		CastingBarFrame:SetPoint("CENTER", PlayerName, "CENTER", 0, -1)
		CastingBarFrame.SetPoint = function() end

		CastingBarFrame.Text:ClearAllPoints()
		CastingBarFrame.Text:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0)
		CastingBarFrame.Text.SetPoint = function() end

		CastingBarFrame.Border:SetWidth(CastingBarFrame:GetWidth()*1.38)
		CastingBarFrame.Border:SetHeight(CastingBarFrame:GetHeight()*3.6)
		CastingBarFrame.Border:ClearAllPoints()
		CastingBarFrame.Border:SetPoint("CENTER", CastingBarFrame, "CENTER", 0, 0)
		CastingBarFrame.Border.SetPoint = function() end
		CastingBarFrame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")

		CastingBarFrame.Flash:SetWidth(CastingBarFrame.Border:GetWidth())
		CastingBarFrame.Flash:SetHeight(CastingBarFrame.Border:GetHeight())
		CastingBarFrame.Flash:ClearAllPoints()
		CastingBarFrame.Flash:SetPoint("CENTER", CastingBarFrame.Border, "CENTER", 0, 0)
		CastingBarFrame.Flash.SetPoint = function() end
		CastingBarFrame.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")
		
		if addonTable.db.PLAYER_BIG_SPELL_ICON and not addonTable.db.PLAYER_HIDE_SPELL_ICON then
			
			CastingBarFrame.Icon:Show()
			CastingBarFrame.Icon:ClearAllPoints()
			CastingBarFrame.Icon:SetPoint("CENTER", PlayerPortrait, "CENTER", 0, 0)
			CastingBarFrame.Icon:SetWidth(PlayerPortrait:GetWidth()*.83)
			CastingBarFrame.Icon:SetHeight(PlayerPortrait:GetHeight()*.83)
			CastingBarFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
		
		if not addonTable.db.PLAYER_BIG_SPELL_ICON and not addonTable.db.PLAYER_HIDE_SPELL_ICON then
			
			CastingBarFrame.Icon:ClearAllPoints()
			CastingBarFrame.Icon:SetPoint("LEFT", CastingBarFrame, "RIGHT", 5, 0)
			CastingBarFrame.Icon.SetPoint = function() end
		end
		
		if addonTable.db.PLAYER_HIDE_PVP_ICON then
			
			PlayerPVPIcon:SetAlpha(0)
		end


		-- HOOKS

		CastingBarFrame.update = 0
		CastingBarFrame:HookScript('OnUpdate', function(self, elapsed)
		
			if self.update and self.update < elapsed then
			
				if self.casting then		
					
					ShowPlayerCastBar()
					
					if addonTable.db.PLAYER_TIMER then
					
						PlayerLevelText:SetText(format("%.1f", max(self.maxValue - self.value, 0)))
					end
				elseif self.channeling then
					
					ShowPlayerCastBar()
					
					if addonTable.db.PLAYER_TIMER then
					
						PlayerLevelText:SetText(format("%.1f", max(self.value, 0)))
					end
				end
				
				self.update = 0
				
			else
				self.update = self.update - elapsed
			end
		end)

		CastingBarFrame:HookScript("OnHide", function(self, event, ...)
			PlayerName:Show()
			PlayerStatusTexture:Show()
			PlayerFrameBackground:Show()
			PlayerPortrait:Show()
			PlayerLevelText:SetText(UnitLevel("player"))
			PlayerAttackIcon:SetAlpha(1)
			PlayerRestIcon:SetAlpha(1)
		end)
	end

	local function SetupTargetFrame()

		TargetFrameSpellBar:SetFrameStrata("BACKGROUND")

		TargetFrameSpellBar:ClearAllPoints()
		TargetFrameSpellBar:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",7,-22)
		TargetFrameSpellBar:SetPoint("BOTTOMRIGHT",TargetFrame,"BOTTOMRIGHT",-109.5, 60)
		TargetFrameSpellBar.SetPoint = function() end
		
		TargetFrameSpellBar.Flash:ClearAllPoints()
		TargetFrameSpellBar.Flash:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, -2)
		TargetFrameSpellBar.Flash:SetWidth(TargetFrameSpellBar:GetWidth()*1.38)
		TargetFrameSpellBar.Flash:SetHeight(TargetFrameSpellBar:GetHeight()*3.6)
		TargetFrameSpellBar.Flash.SetPoint = function() end

		TargetFrameSpellBar.BorderShield:SetAlpha(0)
		TargetFrameSpellBar.Border:SetAlpha(0)

		TargetFrameSpellBar.Text:ClearAllPoints()
		TargetFrameSpellBar.Text:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, -1)
		
		if addonTable.db.TARGET_BIG_SPELL_ICON then
			
			TargetFrameSpellBar.Icon:ClearAllPoints()
			TargetFrameSpellBar.Icon:SetPoint("CENTER", TargetFramePortrait, "CENTER", 0, 0)
			TargetFrameSpellBar.Icon:SetWidth(TargetFramePortrait:GetWidth())
			TargetFrameSpellBar.Icon:SetHeight(TargetFramePortrait:GetHeight())
			TargetFrameSpellBar.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
		end
		
		if addonTable.db.TARGET_HIDE_PVP_ICON then
			
			TargetFrameTextureFramePVPIcon:SetAlpha(0)
		end

		
		-- HOOKS

		TargetFrameSpellBar.update = 0
		TargetFrameSpellBar:HookScript("OnUpdate", function(self, elapsed)

			if self.update and self.update < elapsed then
					
				if self.casting then
					
					ShowTargetCastBar()
					
					if addonTable.db.TARGET_TIMER then
					
						TargetFrameTextureFrameLevelText:SetText(format("%.1f", max(self.maxValue - self.value, 0)))
					end
				
				elseif self.channeling then
					
					ShowTargetCastBar()
					
					if addonTable.db.TARGET_TIMER then
					
						TargetFrameTextureFrameLevelText:SetText(format("%.1f", max(self.value, 0)))
					end
				end
				
				self.update = 0
			
			else
				self.update = self.update - elapsed
			end
		end)
		
		TargetFrameSpellBar:HookScript("OnHide", function(self, event, ...)
			TargetFrameTextureFrameName:Show()
			TargetFrameNameBackground:Show()
			TargetFramePortrait:Show()
			TargetFrameTextureFrameQuestIcon:Hide()
			TargetFrameTextureFrameLevelText:SetText(UnitLevel("player"))
			TargetFrameTextureFrameQuestIcon:SetVertexColor(1, 1, 1, 1)
		end)
	end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then
		
		addonTable.db = daftUITweaksDB
		
		if addonTable.db.ENABLE_CASTBARS then

			if addonTable.db.CASTBARS_PLAYER then
				SetupPlayerFrame()
			end

			if addonTable.db.CASTBARS_TARGET then
				SetupTargetFrame()
			end
	end

		frame:UnregisterEvent("ADDON_LOADED")
	end
end)
