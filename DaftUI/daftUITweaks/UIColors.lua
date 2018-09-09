local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

if addonTable.ENABLE_UICOLORS then

	addon:RegisterEvent("PLAYER_ENTERING_WORLD")

	local function GetClassColor()
		local _, class
		_, class = UnitClass("player")
		addonTable.classcolor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	end
	
	local function ColorFrames()
		for i, texture in pairs({
			-- select(1, BurningEmbersBarFrame:GetRegions()),
			-- select(1, BurningEmbersBarFrameEmber1:GetRegions()),
			-- select(1, BurningEmbersBarFrameEmber2:GetRegions()),
			-- select(1, BurningEmbersBarFrameEmber3:GetRegions()),
			-- select(1, BurningEmbersBarFrameEmber4:GetRegions()),
			-- select(5, ShardBarFrameShard1:GetRegions()),
			-- select(5, ShardBarFrameShard2:GetRegions()),
			-- select(5, ShardBarFrameShard3:GetRegions()),
			-- select(5, ShardBarFrameShard4:GetRegions()),
			ArenaEnemyFrame1PetFrameTexture,
			ArenaEnemyFrame1SpecBorder,
			ArenaEnemyFrame1Texture,
			ArenaEnemyFrame2PetFrameTexture,
			ArenaEnemyFrame2SpecBorder,
			ArenaEnemyFrame2Texture,
			ArenaEnemyFrame3PetFrameTexture,
			ArenaEnemyFrame3SpecBorder,
			ArenaEnemyFrame3Texture, 
			ArenaEnemyFrame4PetFrameTexture, 
			ArenaEnemyFrame4SpecBorder,
			ArenaEnemyFrame4Texture,
			ArenaEnemyFrame5PetFrameTexture,
			ArenaEnemyFrame5SpecBorder,
			ArenaEnemyFrame5Texture,
			ArenaPrepFrame1SpecBorder,
			ArenaPrepFrame1Texture,
			ArenaPrepFrame2SpecBorder,
			ArenaPrepFrame2Texture,
			ArenaPrepFrame3SpecBorder,
			ArenaPrepFrame3Texture,
			ArenaPrepFrame4SpecBorder,
			ArenaPrepFrame4Texture,
			ArenaPrepFrame5SpecBorder,
			ArenaPrepFrame5Texture,
			Boss1TargetFrameSpellBarBorder,
			Boss1TargetFrameTextureFrameTexture,
			Boss2TargetFrameSpellBarBorder,
			Boss2TargetFrameTextureFrameTexture,
			Boss3TargetFrameSpellBarBorder,
			Boss3TargetFrameTextureFrameTexture,
			Boss4TargetFrameSpellBarBorder,
			Boss4TargetFrameTextureFrameTexture,
			Boss5TargetFrameSpellBarBorder,
			Boss5TargetFrameTextureFrameTexture,
			CastingBarFrameBorder,
			CharacterFrameBg,
			CharacterFrameTitleBg,
			CharacterFrameInsetBg,
			CompactRaidFrameManagerBg,
			FocusFrameSpellBarBorder,
			FocusFrameTextureFrameTexture,
			FocusFrameToTTextureFrameTexture,
			MainMenuBarArtFrame.LeftEndCap,
			MainMenuBarArtFrame.RightEndCap,
			MainMenuBarArtFrameBackground.BackgroundLarge,
			MainMenuBarArtFrameBackground.BackgroundSmall,
			MicroButtonAndBagsBar.MicroBagBar,
			MinimapBorder,
			MinimapBorderTop,
			PartyMemberFrame1PetFrameTexture,
			PartyMemberFrame1Texture,
			PartyMemberFrame2PetFrameTexture,
			PartyMemberFrame2Texture,
			PartyMemberFrame3PetFrameTexture,
			PartyMemberFrame3Texture,
			PartyMemberFrame4PetFrameTexture,
			PartyMemberFrame4Texture,
			PetFrameTexture,
			PlayerFrameTexture,
			PlayerFrameAlternateManaBarBorder,
			PlayerFrameAlternateManaBarLeftBorder,
			PlayerFrameAlternateManaBarRightBorder,
			RuneButtonIndividual1BorderTexture,
			RuneButtonIndividual2BorderTexture,
			RuneButtonIndividual3BorderTexture,
			RuneButtonIndividual4BorderTexture,
			RuneButtonIndividual5BorderTexture,
			RuneButtonIndividual6BorderTexture,
			SlidingActionBarTexture0,
			SlidingActionBarTexture1,
			StanceBarLeft,
			StanceBarMiddle,
			StanceBarRight,
			StatusTrackingBarManager.SingleBarLarge,
			StatusTrackingBarManager.SingleBarSmall,
			StatusTrackingBarManager.SingleBarLargeUpper,
			StatusTrackingBarManager.SingleBarSmallUpper,
			TargetFrameSpellBarBorder,
			TargetFrameTextureFrameTexture,
			TargetFrameToTTextureFrameTexture,
			WatchBarTexture0,
			WatchBarTexture1,
			WatchBarTexture2,
			WatchBarTexture3
			}) do
			
			if addonTable.CUSTOM then
				texture:SetVertexColor(addonTable.R, addonTable.G, addonTable.B, addonTable.A)
			else
				texture:SetVertexColor(addonTable.classcolor.r, addonTable.classcolor.g, addonTable.classcolor.b, addonTable.a)
			end
		end
	end

	addon:SetScript("OnEvent", function(self, event, ...)
			GetClassColor()
			ColorFrames()
	end)

end