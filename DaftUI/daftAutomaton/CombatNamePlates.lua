local addonName, addonTable = ...
local addon = CreateFrame("Frame")

if addonTable.COMBAT_NAMEPLATES then

    addon:RegisterEvent("PLAYER_REGEN_DISABLED")
    addon:RegisterEvent("PLAYER_REGEN_ENABLED")
    addon:SetScript("OnEvent", function(self, event)
        SetCVar("nameplateShowEnemies", event == "PLAYER_REGEN_DISABLED" and 1 or 0)
    end)

    SetCVar("nameplateShowEnemies", UnitAffectingCombat("player") and 1 or 0)
end