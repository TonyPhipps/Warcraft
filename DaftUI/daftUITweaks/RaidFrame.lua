local addonName, addonTable = ...
local frame = CreateFrame("Frame")

-- EVENTS
frame:RegisterEvent("ADDON_LOADED")

-- FUNCTIONS
local function ScaleRaidFrame()

    CompactRaidFrameContainer:SetScale(addonTable.db.RAID_SCALE)
end

-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then      

        addonTable.db = _G.daftUITweaksDB

        ScaleRaidFrame()
		
        frame:UnregisterEvent("ADDON_LOADED") 
    end
end)

