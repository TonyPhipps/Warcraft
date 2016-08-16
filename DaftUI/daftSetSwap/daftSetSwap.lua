local daftSetSwap = CreateFrame("Frame")


daftSetSwap:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
daftSetSwap:RegisterEvent("PLAYER_ENTER_COMBAT")
daftSetSwap:RegisterEvent("PLAYER_REGEN_DISABLED")
daftSetSwap:RegisterEvent("PLAYER_LEAVE_COMBAT")	
daftSetSwap:RegisterEvent("PLAYER_REGEN_ENABLED")
daftSetSwap:RegisterEvent("PLAYER_TARGET_CHANGED")


function Swap(event)
	local currentSpec = GetSpecialization()
	local inCombat = UnitAffectingCombat("player")
	
	if inCombat or event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED" then
		
		if (currentSpec == 1 and SPEC1) then
			UseEquipmentSet(SPEC1_COMBAT)
		elseif (currentSpec == 2 and SPEC2) then
			UseEquipmentSet(SPEC2_COMBAT)
		elseif (currentSpec == 3 and SPEC3) then
			UseEquipmentSet(SPEC3_COMBAT)
		elseif (currentSpec == 4 and SPEC4) then
			UseEquipmentSet(SPEC4_COMBAT)
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
		end
	end
	
	if event == "PLAYER_TARGET_CHANGED" then  -- If swap failed, try again on target change
		Swap()
	end
end


daftSetSwap:SetScript("OnEvent", function(self, event, ...)
	
	if event == "ADDON_LOADED" then
		
		local addon = ...;
		
		if addon == "daftSetSwap" then -- Set Stored Options
		
			if ENABLED == true then
				EnableBtn:SetChecked(true);
			else
				EnableBtn:SetChecked(false);
			end;
			
			if SPEC1 == true then
				EnableSpec1Btn:SetChecked(true);
			else
				EnableSpec1Btn:SetChecked(false);
			end;
			
			if SPEC1_NOCOMBAT then
				UIDropDownMenu_SetText(Spec1NoCombatDropdown, SPEC1_NOCOMBAT);
			else
				UIDropDownMenu_SetText(Spec1NoCombatDropdown, "None");
			end;
			if SPEC1_COMBAT then
				UIDropDownMenu_SetText(Spec1CombatDropdown, SPEC1_COMBAT);
			else
				UIDropDownMenu_SetText(Spec1NoCombatDropdown, "None");
			end;
			
		else

			if ENABLED then
			
				Swap(event);
			end;
		end;
	end;
end)