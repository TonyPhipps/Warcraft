local addonName, addonTable = ... 

if addonTable.CLASS_HEALTH then

	local function colorHealthBar(statusbar, unit)
		local _, class, color
		if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
			_, class = UnitClass(unit)
			color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
			statusbar:SetStatusBarColor(color.r, color.g, color.b)	
		end
	end
	
	hooksecurefunc("UnitFrameHealthBar_Update", colorHealthBar)
	hooksecurefunc("HealthBar_OnValueChanged", function(self)
	
		colorHealthBar(self, self.unit)
	end)
end