local addonName, addonTable = ... 
local frame = CreateFrame("Frame")


-- EVENTS

frame:RegisterEvent("ADDON_LOADED")


-- FRAMES

local function SetupClassHealth()

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

local function SetupClassPortrait()

	hooksecurefunc("UnitFramePortrait_Update",function(self)
		
		if self.portrait then
			
			if UnitIsPlayer(self.unit) then                         
				local coords = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
				
				if coords then
					self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
					self.portrait:SetTexCoord(unpack(coords))
				end
			else
				self.portrait:SetTexCoord(0,1,0,1)
			end
		end
	end)
end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftUITweaks" then
		
		addonTable.db = daftUITweaksDB
		
        if addonTable.db.CLASS_HEALTH then

			SetupClassHealth()
		end
		
		if addonTable.db.CLASS_PORTRAIT then
		
			SetupClassPortrait()
		end
	
		frame:UnregisterEvent("ADDON_LOADED")
	end
end)






