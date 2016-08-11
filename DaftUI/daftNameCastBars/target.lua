local ENABLED = true
local BIG_SPELL_ICON = true
local HIDE_SPELL_ICON = false

if ENABLED then
	TargetFrameSpellBar:SetFrameStrata("BACKGROUND")

	TargetFrameSpellBar:ClearAllPoints()
	TargetFrameSpellBar:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",7,-22)
	TargetFrameSpellBar:SetPoint("BOTTOMRIGHT",TargetFrame,"BOTTOMRIGHT",-109.5,60)
	TargetFrameSpellBar.SetPoint = function() end
	
	TargetFrameSpellBar.Flash:ClearAllPoints()
	TargetFrameSpellBar.Flash:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, -2)
	TargetFrameSpellBar.Flash:SetWidth(TargetFrameSpellBar:GetWidth()*1.38)
	TargetFrameSpellBar.Flash:SetHeight(TargetFrameSpellBar:GetHeight()*3.6)
	TargetFrameSpellBar.Flash.SetPoint = function() end

	TargetFrameSpellBar.BorderShield:SetAlpha(0)
	TargetFrameSpellBar.Border:SetAlpha(0)

	TargetFrameSpellBar.Text:ClearAllPoints()
	TargetFrameSpellBar.Text:SetPoint("CENTER", TargetFrameSpellBar, "CENTER", 0, 0)

	TargetFrameSpellBar:HookScript("OnShow", function() 
		TargetFrameTextureFrameName:Hide()
		TargetFrameNameBackground:Hide()
		if BIG_SPELL_ICON then
			TargetFramePortrait:Hide()
			TargetFrameSpellBar.Icon:ClearAllPoints()
			TargetFrameSpellBar.Icon:SetPoint("CENTER", TargetFramePortrait, "CENTER", 0, 0)
			TargetFrameSpellBar.Icon:SetWidth(TargetFramePortrait:GetWidth())
			TargetFrameSpellBar.Icon:SetHeight(TargetFramePortrait:GetHeight())
			TargetFrameSpellBar.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
		end
	end)

	TargetFrameSpellBar:HookScript("OnHide", function() 
		UIFrameFadeIn(TargetFrameTextureFrameName, .2, 0, 1)
		UIFrameFadeIn(TargetFrameNameBackground, .2, 0, 1)
		TargetFramePortrait:Show()
	end)

	if HIDE_SPELL_ICON then
		TargetFrameSpellBar.Icon:Hide()
	end
end