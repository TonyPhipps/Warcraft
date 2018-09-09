local addonName, addonTable = ...
local addon = CreateFrame("Frame")

if addonTable.FASTLOOT then

    addon:RegisterEvent("LOOT_READY")


    local tDelay = 0

    local function FastLoot()

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

    addon:SetScript("OnEvent", FastLoot)

end