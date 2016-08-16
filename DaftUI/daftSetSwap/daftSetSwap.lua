local daftSetSwap = CreateFrame("Frame");


daftSetSwap:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
daftSetSwap:RegisterEvent("PLAYER_ENTER_COMBAT");
daftSetSwap:RegisterEvent("PLAYER_REGEN_DISABLED");
daftSetSwap:RegisterEvent("PLAYER_LEAVE_COMBAT");
daftSetSwap:RegisterEvent("PLAYER_REGEN_ENABLED");
daftSetSwap:RegisterEvent("PLAYER_TARGET_CHANGED");


function Swap(event)
	local currentSpec = GetSpecialization();
	local inCombat = UnitAffectingCombat("player");
	
	if inCombat == true or event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED" then
		
		if (currentSpec == 1 and SPEC1) then
			UseEquipmentSet(SPEC1_COMBAT);
		elseif (currentSpec == 2 and SPEC2) then
			UseEquipmentSet(SPEC2_COMBAT);
		elseif (currentSpec == 3 and SPEC3) then
			UseEquipmentSet(SPEC3_COMBAT);
		elseif (currentSpec == 4 and SPEC4) then
			UseEquipmentSet(SPEC4_COMBAT);
		end;
	end;
	
	if inCombat == false or event == "PLAYER_LEAVE_COMBAT" or event == "PLAYER_REGEN_ENABLED" then
		
		if (currentSpec == 1 and SPEC1) then
			UseEquipmentSet(SPEC1_NOCOMBAT);
		elseif (currentSpec == 2 and SPEC2) then
			UseEquipmentSet(SPEC2_NOCOMBAT);
		elseif (currentSpec == 3 and SPEC3) then
			UseEquipmentSet(SPEC3_NOCOMBAT);
		elseif (currentSpec == 4 and SPEC4) then
			UseEquipmentSet(SPEC4_NOCOMBAT);
		end;
	end;
end;


daftSetSwap:SetScript("OnEvent", function(self, event, ...)
	if ENABLED then
		Swap(event);
	end;
end);