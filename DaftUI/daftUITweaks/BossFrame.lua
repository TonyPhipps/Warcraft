local function MoveBossFrame()
    Boss1TargetFrame:ClearAllPoints()
    Boss1TargetFrame:SetPoint("TOP", UIParent, "TOP", 50, 0)
    Boss1TargetFrame:SetScale(2)

    Boss2TargetFrame:ClearAllPoints()
    Boss2TargetFrame:SetPoint("TOPLEFT", Boss1TargetFrame, "TOPRIGHT", -200, -10)
    Boss3TargetFrame:ClearAllPoints()
    Boss3TargetFrame:SetPoint("TOPLEFT", Boss2TargetFrame, "TOPRIGHT", -50, 0)
    Boss4TargetFrame:ClearAllPoints()
    Boss4TargetFrame:SetPoint("TOPLEFT", Boss2TargetFrame, "BOTTOMLEFT", 0, 0)
    Boss5TargetFrame:ClearAllPoints()
    Boss5TargetFrame:SetPoint("TOPLEFT", Boss3TargetFrame, "BOTTOMLEFT", 0, 0)
end

Boss1TargetFrame:HookScript("OnShow", MoveBossFrame)
Boss1TargetFrame:HookScript("OnUpdate", MoveBossFrame)