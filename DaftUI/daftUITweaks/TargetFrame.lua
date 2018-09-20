local addonName, addonTable = ... 
local frame = CreateFrame("Frame")


-- EVENTS

frame:RegisterEvent("ADDON_LOADED")

-- FUNCTIONS

local function SetupTargetRoleIcon()

        frame:RegisterEvent("PLAYER_TARGET_CHANGED")
    
        frame:SetScript("OnEvent", function(self, event, ...)
    
            if not UnitInParty("target") and not UnitInRaid("target") then 
                TargetRoleIcon:Hide()
                return
            end
            
            local role = UnitGroupRolesAssigned("target")
    
            TargetRoleIconTexture:ClearAllPoints()
            
            if role == "DAMAGER" then
                TargetRoleIconTexture:SetTexCoord(0.3125, 0.34375, 0.3125, 0.640625, 0.609375, 0.343375, 0.609375, 0.64025)
                TargetRoleIcon:Show()
            
            elseif role == "HEALER" then
                TargetRoleIconTexture:SetTexCoord(0.3125, 0.015625, 0.3125, 0.3125, 0.609375, 0.015625, 0.609375, 0.3125)
                TargetRoleIcon:Show()
            
            elseif role == "TANK" then
                TargetRoleIconTexture:SetTexCoord(0, 0.34375, 0, 0.640625, 0.296875, 0.34375, 0.29675, 0.640625)
                TargetRoleIcon:Show()
            
            else
                TargetRoleIcon:Hide()
            end
            
            TargetRoleIconTexture:SetAllPoints()
                
        end)
    
        CreateFrame("Frame","TargetRoleIcon",TargetFrame)
            TargetRoleIcon:SetWidth(19)
            TargetRoleIcon:SetHeight(19)
            TargetRoleIcon:SetPoint("CENTER",17,31)
            TargetRoleIcon:CreateTexture("TargetRoleIconTexture")
            TargetRoleIconTexture:SetAllPoints()
            TargetRoleIconTexture:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
            TargetRoleIcon:Hide()

end

-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then
		
		addonTable.db = daftUITweaksDB
		
        if addonTable.db.TARGET_ROLE then
            
            SetupTargetRoleIcon()
        end
	
		frame:UnregisterEvent("ADDON_LOADED")
	end
end)



