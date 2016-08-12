---- CONFIG ----
if GetUnitName("player") == "Goose" then
	SPEC1 = true
	SPEC1_NOCOMBAT = "set_name"
	SPEC1_COMBAT = "set_name"

	SPEC2 = true
	SPEC2_NOCOMBAT = "Warglaives"
	SPEC2_COMBAT = "Spec2"

	SPEC3 = true
	SPEC3_NOCOMBAT = "set_name"
	SPEC3_COMBAT = "set_name"

	SPEC4 = false
	SPEC4_NOCOMBAT = "set_name"
	SPEC4_COMBAT = "set_name"
end


local daftSetSwap = CreateFrame("Frame")


daftSetSwap:RegisterEvent("PLAYER_ENTER_COMBAT")
daftSetSwap:RegisterEvent("PLAYER_REGEN_DISABLED")	
	
daftSetSwap:RegisterEvent("PLAYER_REGEN_ENABLED")	
daftSetSwap:RegisterEvent("PLAYER_LEAVE_COMBAT")



daftSetSwap:SetScript("OnEvent", function(self, event, ...)
	local currentSpec = GetSpecialization()

	if event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED" then
		
		if (currentSpec == 1 and SPEC1) then
			UseEquipmentSet(SPEC1_COMBAT)
		elseif (currentSpec == 2 and SPEC2) then
			UseEquipmentSet(SPEC2_COMBAT)
		elseif (currentSpec == 3 and SPEC3) then
			UseEquipmentSet(SPEC3_COMBAT)
		elseif (currentSpec == 4 and SPEC4) then
			UseEquipmentSet(SPEC4_COMBAT)
		else
			return
		end
	end
	
	if event == "PLAYER_LEAVE_COMBAT" or event == "PLAYER_REGEN_ENABLED" then
		
		if (currentSpec == 1 and not SPEC1) then
			UseEquipmentSet(SPEC1_NOCOMBAT)
		elseif (currentSpec == 2 and SPEC2) then
			UseEquipmentSet(SPEC2_NOCOMBAT)
		elseif (currentSpec == 3 and SPEC3) then
			UseEquipmentSet(SPEC3_NOCOMBAT)
		elseif (currentSpec == 4 and SPEC4) then
			UseEquipmentSet(SPEC4_NOCOMBAT)
		else
			return
		end
	end
	
	if event == "PLAYER_SPECIALIZATION_CHANGED" then
		
		if (currentSpec == 1 and not SPEC1) then
			UseEquipmentSet(SPEC1_NOCOMBAT)
		elseif (currentSpec == 2 and SPEC2) then
			UseEquipmentSet(SPEC2_NOCOMBAT)
		elseif (currentSpec == 3 and SPEC3) then
			UseEquipmentSet(SPEC3_NOCOMBAT)
		elseif (currentSpec == 4 and SPEC4) then
			UseEquipmentSet(SPEC4_NOCOMBAT)
		else
			return
		end
	end
end)