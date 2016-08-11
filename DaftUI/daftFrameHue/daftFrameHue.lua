local custom = false
local r = 0.3
local g = 0.3
local b = 0.3
local a = 1
 
local _, class, classcolor
_, class = UnitClass("player")
classcolor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
 
 
 -- COLORING FRAMES
for i,v in pairs({
	-- UNIT FRAMES
	PlayerFrameTexture,
	TargetFrameTextureFrameTexture,
	PetFrameTexture,
	PartyMemberFrame1Texture,
	PartyMemberFrame2Texture,
	PartyMemberFrame3Texture,
	PartyMemberFrame4Texture,
	PartyMemberFrame1PetFrameTexture,
	PartyMemberFrame2PetFrameTexture,
	PartyMemberFrame3PetFrameTexture,
	PartyMemberFrame4PetFrameTexture,
	FocusFrameTextureFrameTexture,
	TargetFrameToTTextureFrameTexture,
	FocusFrameToTTextureFrameTexture,
	Boss1TargetFrameTextureFrameTexture,
	Boss2TargetFrameTextureFrameTexture,
	Boss3TargetFrameTextureFrameTexture,
	Boss4TargetFrameTextureFrameTexture,
	Boss5TargetFrameTextureFrameTexture,
	Boss1TargetFrameSpellBarBorder,
	Boss2TargetFrameSpellBarBorder,
	Boss3TargetFrameSpellBarBorder,
	Boss4TargetFrameSpellBarBorder,
	Boss5TargetFrameSpellBarBorder,
	-- select(5, ShardBarFrameShard1:GetRegions()),
	-- select(5, ShardBarFrameShard2:GetRegions()),
	-- select(5, ShardBarFrameShard3:GetRegions()),
	-- select(5, ShardBarFrameShard4:GetRegions()),
	-- select(1, BurningEmbersBarFrame:GetRegions()),
	-- select(1, BurningEmbersBarFrameEmber1:GetRegions()),
	-- select(1, BurningEmbersBarFrameEmber2:GetRegions()),
	-- select(1, BurningEmbersBarFrameEmber3:GetRegions()),
	-- select(1, BurningEmbersBarFrameEmber4:GetRegions()),
	RuneButtonIndividual1BorderTexture,
	RuneButtonIndividual2BorderTexture,
	RuneButtonIndividual3BorderTexture,
	RuneButtonIndividual4BorderTexture,
	RuneButtonIndividual5BorderTexture,
	RuneButtonIndividual6BorderTexture,
	PaladinPowerBarBG,
	PaladinPowerBarBankBG,
	CastingBarFrameBorder,
	FocusFrameSpellBarBorder,
	TargetFrameSpellBarBorder,
	--MAIN MENU
	SlidingActionBarTexture0,
	SlidingActionBarTexture1,
	MainMenuBarTexture0,
	MainMenuBarTexture1,
	MainMenuBarTexture2,
	MainMenuBarTexture3,
	MainMenuMaxLevelBar0,
	MainMenuMaxLevelBar1,
	MainMenuMaxLevelBar2,
	MainMenuMaxLevelBar3,
	MainMenuXPBarTextureLeftCap,
	MainMenuXPBarTextureRightCap,
	MainMenuXPBarTextureMid,
	ReputationWatchBarTexture0,
	ReputationWatchBarTexture1,
	ReputationWatchBarTexture2,
	ReputationWatchBarTexture3,
	ReputationXPBarTexture0,
	ReputationXPBarTexture1,
	ReputationXPBarTexture2,
	ReputationXPBarTexture3,
	MainMenuBarLeftEndCap,
	MainMenuBarRightEndCap, 
	StanceBarLeft,
	StanceBarMiddle,
	StanceBarRight,
	--ARENA FRAMES
	ArenaEnemyFrame1Texture,
	ArenaEnemyFrame2Texture,
	ArenaEnemyFrame3Texture, 
	ArenaEnemyFrame4Texture,
	ArenaEnemyFrame5Texture,
	ArenaEnemyFrame1SpecBorder,
	ArenaEnemyFrame2SpecBorder,
	ArenaEnemyFrame3SpecBorder,
	ArenaEnemyFrame4SpecBorder,
	ArenaEnemyFrame5SpecBorder,
	ArenaEnemyFrame1PetFrameTexture,
	ArenaEnemyFrame2PetFrameTexture,
	ArenaEnemyFrame3PetFrameTexture,
	ArenaEnemyFrame4PetFrameTexture, 
	ArenaEnemyFrame5PetFrameTexture,
	ArenaPrepFrame1Texture,
	ArenaPrepFrame2Texture,
	ArenaPrepFrame3Texture,
	ArenaPrepFrame4Texture,
	ArenaPrepFrame5Texture,
	ArenaPrepFrame1SpecBorder,
	ArenaPrepFrame2SpecBorder,
	ArenaPrepFrame3SpecBorder,
	ArenaPrepFrame4SpecBorder,
	ArenaPrepFrame5SpecBorder,
	-- PANES
	CharacterFrameTitleBg,
	CharacterFrameBg,
	ObjectiveTrackerBlocksFrame.QuestHeader.Background,
	-- MINIMAP
	MinimapBorder,
	MinimapBorderTop,
	MiniMapTrackingButtonBorder
	
}) do
	if custom then
		v:SetVertexColor(r, g, b, a)
	else
		v:SetVertexColor(classcolor.r, classcolor.g, classcolor.b, a)
	end
end
