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

			--if (CastingBarFrame.Icon:GetTexture() == 456031) then -- avoid some problem icons
			--	return
			--else
				-- print(CastingBarFrame.Icon:GetTexture()) -- DEBUG
				--SetPortraitToTexture(CastingBarFrame.Icon, CastingBarFrame.Icon:GetTexture())
			--end
		end

		if not addonTable.db.PLAYER_BIG_SPELL_ICON 
		and not addonTable.db.PLAYER_HIDE_SPELL_ICON then
		
			--CastingBarFrame.Icon:Show()
		end
	end

	local function ShowTargetCastBar()
		
		_, _, _, _, _, _, _, notInterruptible = UnitCastingInfo("target")


		if addonTable.db.TARGET_HIDE_SPELL_ICON then
		
			TargetFrameSpellBar.Icon:Hide()
		end
		
		if notInterruptible then
		
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar.RightText:SetText("Uninterruptable!")
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar.RightText:Show()
		else
			
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar.RightText:Hide()
		end
	end

	local function SetupPlayerFrame()
				
		if addonTable.db.PLAYER_HIDE_PVP_ICON then
			
			PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigeBadge:SetAlpha(0)
			PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait:SetAlpha(0)
			PlayerPVPTimerText:SetAlpha(0)
		end

	end

	local function SetupTargetFrame()

		TargetFrameSpellBar:SetFrameStrata("MEDIUM")

		TargetFrameSpellBar:ClearAllPoints()
		TargetFrameSpellBar:SetPoint("TOPLEFT",TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBar,"TOPLEFT",0,0)
		TargetFrameSpellBar:SetPoint("BOTTOMRIGHT",TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBar,"BOTTOMRIGHT",0,0)
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
			TargetFrameSpellBar.Icon:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, "CENTER", 0, 0)
			TargetFrameSpellBar.Icon:SetWidth(TargetFrame.TargetFrameContainer.Portrait:GetWidth())
			TargetFrameSpellBar.Icon:SetHeight(TargetFrame.TargetFrameContainer.Portrait:GetHeight())
			TargetFrameSpellBar.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
		end
		
		if addonTable.db.TARGET_HIDE_PVP_ICON then
			
			TargetFrame.TargetFrameContent.TargetFrameContentContextual.PvpIcon:SetAlpha(0)
		end

		
		-- HOOKS

		TargetFrameSpellBar.update = 0
		TargetFrameSpellBar:HookScript("OnUpdate", function(self, elapsed)

			if self.update and self.update < elapsed then
					
				if self.casting then
					
					ShowTargetCastBar()
					
					if addonTable.db.TARGET_TIMER then
					
						TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar.LeftText:SetText(format("%.1f", max(self.maxValue - self.value, 0)))
						TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar.LeftText:Show()
					end
				
				elseif self.channeling then
					
					ShowTargetCastBar()
					
					if addonTable.db.TARGET_TIMER then
					
						TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar.LeftText:SetText(format("%.1f", max(self.value, 0)))
						TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar.LeftText:Show()
					end
				end
				
				self.update = 0
			
			else
				self.update = self.update - elapsed
			end
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
