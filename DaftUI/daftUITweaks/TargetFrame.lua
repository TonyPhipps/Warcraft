local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

if addonTable.ENABLE_TARGETFRAME then

    -- FUNCTIONS
    
    function StyleTargetFrame()

        TargetFrameTextureFrameName:SetVertexColor(1, 1, 1)
        TargetFrameTextureFrameName:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")

        TargetFrameTextureFrameLevelText:SetVertexColor(1, 1, 1)
        TargetFrameTextureFrameLevelText:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
        
        TargetFrameToTTextureFrameName:SetVertexColor(1, 1, 1)
        TargetFrameToTTextureFrameName:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
    end

    
    -- HOOKS

    hooksecurefunc('TargetFrame_CheckDead', StyleTargetFrame)
    hooksecurefunc('TargetFrame_Update', StyleTargetFrame)
    hooksecurefunc('TargetFrame_CheckFaction', StyleTargetFrame)
    hooksecurefunc('TargetFrame_CheckClassification', StyleTargetFrame)
    hooksecurefunc('TargetofTarget_Update', StyleTargetFrame)
end