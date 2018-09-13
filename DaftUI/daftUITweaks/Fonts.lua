local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

if addonTable.ENABLE_FONTS then

    
    -- EVENTS
    
    addon:RegisterEvent("PLAYER_ENTERING_WORLD")
    addon:RegisterEvent("UNIT_ENTERED_VEHICLE")
    addon:RegisterEvent("UNIT_EXITED_VEHICLE")


    -- FUNCTIONS
    
    function StyleFonts(Frame)

        local FrameArray = {
            "PlayerName",
            "PlayerLevelText",
            "FocusFrameTextureFrameName",
            "FocusFrameTextureFrameLevelText",
            "TargetFrameTextureFrameName",
            "TargetFrameTextureFrameLevelText",
            "TargetFrameToTTextureFrameName"
        }   
        
        local TextArray = {
            "CastingBarFrame",
            "TargetFrameSpellBar"
        }

        for _, Frame in pairs(FrameArray) do
        
            _G[Frame]:SetTextColor(1, 1, 1, 1)
            _G[Frame]:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
        end

        for _, Frame in pairs(TextArray) do
        
            _G[Frame].Text:SetTextColor(1, 1, 1, 1)
            _G[Frame].Text:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
        end
    end

    function StyleButtonFonts()
        
        for i = 1, 12 do
				
                
            _G[bar.."Button"..i.."HotKey"]:ClearAllPoints()
            _G[bar.."Button"..i.."HotKey"]:SetPoint("TOPRIGHT", 0, -3)
            StyleFonts(bar.."Button"..i.."HotKey")
            --_G[bar.."Button"..i.."HotKey"]:SetTextColor(1, 1, 1, 1)
            --_G[bar.."Button"..i.."HotKey"]:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
            
            _G[bar.."Button"..i.."Name"]:ClearAllPoints()
            _G[bar.."Button"..i.."Name"]:SetPoint("BOTTOM", 0, 0)
            StyleFonts(bar.."Button"..i.."Name")
            --_G[bar.."Button"..i.."Name"]:SetTextColor(1, 1, 1, 1)
            --_G[bar.."Button"..i.."Name"]:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
        end

        for i = 1, 10 do

            _G["PetActionButton"..i.."HotKey"]:ClearAllPoints()
            _G["PetActionButton"..i.."HotKey"]:SetPoint("TOPRIGHT", 0, -3)
            StyleFonts("PetActionButton"..i.."HotKey")
            --_G["PetActionButton"..i.."HotKey"]:SetTextColor(1, 1, 1, 1)
            --_G["PetActionButton"..i.."HotKey"]:SetFont("Fonts\\ARIALN.ttf", 13, "THINOUTLINE", "")
		end	
    end


    -- SCRIPTS

    addon:SetScript("OnEvent", function(self, event, ...) 
		
		if event == "PLAYER_ENTERING_WORLD" then
			
			StyleFonts()
        end
        
        if (event == "UNIT_EXITED_VEHICLE" and ... == "player" ) then
        
            StyleFonts()
        end
    
        if (event == "UNIT_ENTERED_VEHICLE" and ... == "player" ) then
        
            StyleFonts()
        end
    end)


    -- HOOKS

    hooksecurefunc("TargetFrame_CheckDead", StyleFonts)
    hooksecurefunc("TargetFrame_Update", StyleFonts)
    hooksecurefunc("TargetFrame_CheckFaction", StyleFonts)
    hooksecurefunc("TargetFrame_CheckClassification", StyleFonts)
    hooksecurefunc("TargetofTarget_Update", StyleFonts)
    hooksecurefunc("PetActionButton_OnUpdate", StyleButtonFonts)

end