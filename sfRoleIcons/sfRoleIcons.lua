local sfTRI = CreateFrame("Frame")
sfTRI:RegisterEvent("PLAYER_TARGET_CHANGED")

sfTRI:SetScript("OnEvent", function(this, event, arg1, arg2, arg3, arg4, ...)

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
	elseif role == nil then
		TargetRoleIcon:Hide()
	end
	
	TargetRoleIconTexture:SetAllPoints()
		
end)

CreateFrame("Frame","TargetRoleIcon",TargetFrame)
	TargetRoleIcon:SetWidth(19)
	TargetRoleIcon:SetHeight(19)
	TargetRoleIcon:SetPoint("CENTER",60,30)
	TargetRoleIcon:CreateTexture("TargetRoleIconTexture")
	TargetRoleIconTexture:SetAllPoints()
	TargetRoleIconTexture:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
	TargetRoleIcon:Hide()


