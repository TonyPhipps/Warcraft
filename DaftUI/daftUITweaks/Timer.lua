local addonName, addonTable = ... 
local frame = CreateFrame("Frame")



function frame:LFG_PROPOSAL_SHOW()
    --if addonTable.db.ENABLE_TIMERS then
        if not prev then
            local timerBar = CreateFrame("StatusBar", nil, LFGDungeonReadyPopup)
            timerBar:SetPoint("TOP", LFGDungeonReadyPopup, "BOTTOM", 0, -5)
            local tex = timerBar:CreateTexture()
            tex:SetTexture(137012) -- Interface\\TargetingFrame\\UI-StatusBar
            timerBar:SetStatusBarTexture(tex)
            timerBar:SetSize(190, 9)
            timerBar:SetStatusBarColor(1, 0.1, 0)
            timerBar:SetMinMaxValues(0, 40)
            timerBar:Show()

            local bg = timerBar:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints(timerBar)
            bg:SetColorTexture(0, 0, 0, 0.7)

            local spark = timerBar:CreateTexture(nil, "OVERLAY")
            spark:SetTexture(130877) -- Interface\\CastingBar\\UI-CastingBar-Spark
            spark:SetSize(32, 32)
            spark:SetBlendMode("ADD")
            spark:SetPoint("LEFT", tex, "RIGHT", -15, 0)

            local border = timerBar:CreateTexture(nil, "OVERLAY")
            border:SetTexture(130874) -- Interface\\CastingBar\\UI-CastingBar-Border
            border:SetSize(256, 64)
            border:SetPoint("TOP", timerBar, 0, 28)

            timerBar.text = timerBar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            timerBar.text:SetPoint("CENTER", timerBar, "CENTER")

            self.LFG_PROPOSAL_SHOW = function()
                prev = GetTime() + 40
            end
            self:LFG_PROPOSAL_SHOW()

            timerBar:SetScript("OnUpdate", function(f)
                local timeLeft = prev - GetTime()
                if timeLeft > 0 then
                    f:SetValue(timeLeft)
                    f.text:SetFormattedText("Timer: %.1f", timeLeft)
                end
            end)
        end
    --end
end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then
		
		addonTable.db = daftUITweaksDB
		 
        frame:RegisterEvent("LFG_PROPOSAL_SHOW")
	
        frame:UnregisterEvent("ADDON_LOADED")

    elseif event == "LFG_PROPOSAL_SHOW" then		
                
        local prev
		frame:LFG_PROPOSAL_SHOW()
	end
end)
