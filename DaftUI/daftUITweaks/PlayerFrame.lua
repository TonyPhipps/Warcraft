local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

if addonTable.ENABLE_PLAYERFRAME then

    addon:RegisterEvent('PLAYER_ENTERING_WORLD')
    addon:RegisterEvent('UNIT_ENTERED_VEHICLE')
    addon:RegisterEvent('UNIT_EXITED_VEHICLE')

    -- FUNCTIONS
    
    function StylePlayerFrame()

        PlayerName:SetTextColor(1, 1, 1, 1)
        PlayerName:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")

        PlayerLevelText:SetTextColor(1, 1, 1, 1)
        PlayerLevelText:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
    end

    -- EVENTS

    addon:SetScript("OnEvent", function(self, event, ...) 
		
		if event == "PLAYER_ENTERING_WORLD" then
			
			StylePlayerFrame()
        end
        
        if (event == 'UNIT_EXITED_VEHICLE' and ... == 'player' ) then
        
            StylePlayerFrame()
        end
    
        if (event == 'UNIT_ENTERED_VEHICLE' and ... == 'player' ) then
        
            StylePlayerFrame()
        end
    end)
end