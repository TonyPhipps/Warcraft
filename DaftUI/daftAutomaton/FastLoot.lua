local addonName, addonTable = ...
local addon = CreateFrame("Frame")

if addonTable.FASTLOOT then

    ModifierHeld = 0
    LootAlpha = LootFrame:GetAlpha()
    local tDelay = 0

    
    -- EVENTS

    addon:RegisterEvent("LOOT_READY")
    addon:RegisterEvent("MODIFIER_STATE_CHANGED")


    -- FUNCTIONS

    local function HandleModifier(arg2)

        ModifierHeld = arg2

            if ModifierHeld == 0 and not LootFrame:IsShown() then
                
                LootFrame:SetAlpha(0)
            else
                
                LootFrame:SetAlpha(LootAlpha)
            end
    end

    local function FastLoot()

        if ModifierHeld == 0 then

            if GetTime() - tDelay >= 0.3 then
            
                tDelay = GetTime()
            
                if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
            
                    for i = GetNumLootItems(), 1, -1 do
                
                        LootSlot(i)
                    end
                
                    tDelay = GetTime()
                end
            end
        end
    end


    -- SCRIPTS

    addon:SetScript("OnEvent", function(self, event, arg1, arg2)
    
        if event == "MODIFIER_STATE_CHANGED" then
            
            HandleModifier(arg2)
        end

        if event == "LOOT_READY" then
            
            FastLoot()
        end
    end)
end