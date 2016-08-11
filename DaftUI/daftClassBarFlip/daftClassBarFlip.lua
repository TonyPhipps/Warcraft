local function yOffset(Frame, y)
	local P = { Frame:GetPoint() }
	Frame:SetPoint(P[1], P[2], P[3], P[4], y)
end

local function yInvertTexture(Texture)
	local Left, Top, _, Bottom, Right = Texture:GetTexCoord()
	Texture:SetTexCoord(Left, Right, Bottom, Top) -- Swapping parameters 3 & 4 (top & bottom)
end

local function yInvertAllTextures(Frame)
	for _, Region in pairs({ Frame:GetRegions() }) do
		if Region:IsObjectType("Texture") then yInvertTexture(Region) end
	end
end

_, _, playerClass = UnitClass("player")


if playerClass == 2 then --PALADIN
	yOffset(PaladinPowerBarFrame, 111)
	yOffset(PaladinPowerBarFrameRune1, -5)
	yOffset(PaladinPowerBarFrameRune4, 3)
	yOffset(PaladinPowerBarFrameRune5, 3)
	yOffset(PaladinPowerBarFrameBankBG, 7)
	yInvertAllTextures(PaladinPowerBarFrame)
	yInvertTexture(PaladinPowerBarFrameGlowBGTexture)
	for i = 1, 5 do yInvertTexture(_G["PaladinPowerBarFrameRune"..i.."Texture"]) end
end
	
if playerClass == 5 then --PRIEST
	yInvertAllTextures(PriestBarFrame)
	yOffset(PriestBarFrame, 131)
	yOffset(PriestBarFrame.LargeOrbs[1], -16)
	-- for i = 1, 3 do
	  -- yInvertAllTextures(PriestBarFrame.LargeOrbs[i])
	  -- yOffset(PriestBarFrame.LargeOrbs[i].Highlight, 8)
	-- end
end

if playerClass == 9 then --WARLOCK
	yOffset(ShardBarFrame, 69)
	for i = 1, 4 do
		yInvertAllTextures(_G["ShardBarFrameShard"..i])
		yOffset(_G["ShardBarFrameShard"..i].shardFill, -5)
	end
	yOffset(BurningEmbersBarFrame, 63)
	yOffset(BurningEmbersBarFrameEmber1, 14)
	yInvertTexture(BurningEmbersBarFrame.background)
	for i = 1, 4 do 
		yInvertAllTextures(_G["BurningEmbersBarFrameEmber"..i]) 
	end
	yOffset(DemonicFuryBarFrame, 82)
end

if playerClass == 6 then --DEATHKNIGHT
	yOffset(RuneFrame, 99)
end

if playerClass == 11 then --DRUID
	yOffset(EclipseBarFrame, 108)
	yInvertAllTextures(PlayerFrameAlternateManaBar)
	yOffset(PlayerFrameAlternateManaBar, 79)
	yOffset(PlayerFrameAlternateManaBar.DefaultBorder, 4)
	yOffset(PlayerFrameAlternateManaBar.MonkBorder, 4)
	yOffset(PlayerFrameAlternateManaBar.MonkBackground, 4)
	local Offset = 79
	if MonkHarmonyBar:IsShown() then Offset = 100 end
	hooksecurefunc(PlayerFrameAlternateManaBar, "SetPoint", function(PlayerFrameAlternateManaBar) yOffset(PlayerFrameAlternateManaBar, Offset) end)
end

if playerClass == 10 then --MONK
	yOffset(MonkHarmonyBar, 20)
	yInvertAllTextures(MonkHarmonyBar)
	yOffset(MonkStaggerBarText, -4)
	yInvertAllTextures(MonkStaggerBar)
	hooksecurefunc(MonkStaggerBar, "SetPoint", function(MonkStaggerBar) yOffset(MonkStaggerBar, 104) end)
end

if playerClass == 7 or playerClass == 8 or playerClass == 11 then --SHAMAN, MAGE, DRUID
	TotemFrame:SetPoint("TOPLEFT", PlayerFrame, "BOTTOMLEFT", 99, 112)
	TotemFrame.SetPoint = function() end
	for i = 1, 4 do
	  yOffset(_G["TotemFrameTotem"..i.."Duration"], 44)
	  yInvertTexture(select(2, _G["TotemFrameTotem"..i]:GetChildren()):GetRegions())
	end
end