local function MoveBossFrame()
    
    if UnitAffectingCombat("Player")
    or InCombatLockdown() then
        return
    else

        for i = 1, 5 do
            _G["Boss"..i.."TargetFrame"]:SetScale(1.5)
            _G["Boss"..i.."TargetFrame"]:ClearAllPoints()

            _G["Boss"..i.."TargetFrameSpellBar"]:ClearAllPoints()
            _G["Boss"..i.."TargetFrameSpellBar"]:SetPoint("TOP", _G["Boss"..i.."TargetFrame"], "BOTTOMLEFT", 40, 28)        
        end
        
        Boss1TargetFrame:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOM", 100, 0)    
        Boss2TargetFrame:SetPoint("TOPLEFT", Boss1TargetFrame, "BOTTOMLEFT", 0, 20)
        Boss3TargetFrame:SetPoint("TOPLEFT", Boss2TargetFrame, "BOTTOMLEFT", 0, 20)
        Boss4TargetFrame:SetPoint("TOPLEFT", Boss3TargetFrame, "BOTTOMLEFT", 0, 20)
        Boss5TargetFrame:SetPoint("TOPLEFT", Boss4TargetFrame, "BOTTOMLEFT", 0, 20)
    end
end

for i = 1, 5 do
    _G["Boss"..i.."TargetFrame"]:HookScript("OnShow", MoveBossFrame)
end

