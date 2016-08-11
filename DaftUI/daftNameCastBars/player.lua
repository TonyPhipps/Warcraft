local ENABLED = true
local BIG_SPELL_ICON = true
local HIDE_SPELL_ICON = false

if ENABLED then
	CastingBarFrame:SetFrameStrata("BACKGROUND")
	CastingBarFrame.Border:Hide()

	CastingBarFrame:SetWidth(PlayerFrameHealthBar:GetWidth())
	CastingBarFrame:SetHeight(PlayerName:GetHeight()*1.8)
	CastingBarFrame:ClearAllPoints()
	CastingBarFrame:SetPoint("CENTER", PlayerName, "CENTER", 0, 0)
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


	CastingBarFrame:HookScript("OnShow", function() 
		PlayerName:Hide()
		PlayerStatusTexture:Hide()
		PlayerFrameBackground:Hide()
		CastingBarFrame.Text:SetFontObject(GameFontNormalSmall);
		CastingBarFrame.Text:SetVertexColor(1, 1, 1);
		if BIG_SPELL_ICON and not HIDE_SPELL_ICON then
			PlayerPortrait:Hide()
			CastingBarFrame.Icon:Show()
			CastingBarFrame.Icon:ClearAllPoints()
			CastingBarFrame.Icon:SetPoint("CENTER", PlayerPortrait, "CENTER", 0, 0)
			CastingBarFrame.Icon:SetWidth(PlayerPortrait:GetWidth()*.83)
			CastingBarFrame.Icon:SetHeight(PlayerPortrait:GetHeight()*.83)
			--CastingBarFrame.Icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask");
			if (CastingBarFrame.Icon:GetTexture() == "INTERFACE\\ICONS\\thumbsdown") or (CastingBarFrame.Icon:GetTexture() == "Portrait2") then
				return
			else
				SetPortraitToTexture(CastingBarFrame.Icon, CastingBarFrame.Icon:GetTexture())
			end
			CastingBarFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end)

	CastingBarFrame:HookScript("OnHide", function() 
		PlayerName:Show()
		PlayerStatusTexture:Show()
		PlayerFrameBackground:Show()
		PlayerPortrait:Show()
	end)

	if not BIG_SPELL_ICON and not HIDE_SPELL_ICON then
		CastingBarFrame.Icon:Show()
		CastingBarFrame.Icon:ClearAllPoints()
		CastingBarFrame.Icon:SetPoint("LEFT", CastingBarFrame, "RIGHT", 5, 0)
		CastingBarFrame.Icon.SetPoint = function() end
	end
end
