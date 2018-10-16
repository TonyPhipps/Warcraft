local addonName, addonTable = ...
local frame = CreateFrame("Frame")

-- EVENTS
frame:RegisterEvent("ADDON_LOADED")

-- FUNCTIONS
local function MoveRaidFrame()

    CompactRaidFrameManager:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', -182, 0)
    
    CompactRaidFrameManager.displayFrame:HookScript("OnShow", function() 
        CompactRaidFrameManager:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', -7, 0) 
    end)

    CompactRaidFrameManager.displayFrame:HookScript("OnHide", function() 
        CompactRaidFrameManager:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', -182, 0) 
    end)

    CompactRaidFrameContainer:SetPoint('TOPLEFT', CompactRaidFrameManager, 'TOPRIGHT', 7, 0)

end

local function ScaleRaidFrame()

    CompactRaidFrameContainer:SetScale(addonTable.db.RAID_SCALE)
end

-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then      

        addonTable.db = _G.daftUITweaksDB

        if addonTable.db.RAID_ANCHOR then
            MoveRaidFrame()
        end

        ScaleRaidFrame()
		
        frame:UnregisterEvent("ADDON_LOADED")        
    end
end)

