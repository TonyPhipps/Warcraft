daftSetSwapOptionsPanel = CreateFrame( "Frame", "daftSetSwapOptionsPanel", UIParent );
daftSetSwapOptionsPanel.name = "daftSetSwap";
InterfaceOptions_AddCategory(daftSetSwapOptionsPanel);
 
-- TITLE 

local titleLabel = daftSetSwapOptionsPanel:CreateFontString("titleLabel", "ARTWORK", "GameFontNormalLarge");
titleLabel:SetPoint("TOPLEFT", daftSetSwapOptionsPanel, "TOPLEFT", 10, -10);
titleLabel:SetText("daftSetSwap");


-- ENABLE BUTTON


local EnableBtn = CreateFrame("CheckButton", "EnableBtn", daftSetSwapOptionsPanel, "ChatConfigCheckButtonTemplate");
EnableBtn:SetPoint("TOPLEFT", titleLabel, "BOTTOMLEFT", 0, -5);
EnableBtn.tooltip = "Enable or Disable the entire addon.";
EnableBtn:SetChecked(true);
 
EnableBtn:SetScript("OnClick", function(self)
	if self:GetChecked() then
		ENABLED = true;
	else
		ENABLED = false;
	end;
end);


local enableLbl = daftSetSwapOptionsPanel:CreateFontString("enableLbl", "ARTWORK", "GameFontHighlight");
enableLbl:SetPoint("LEFT", EnableBtn, "RIGHT", 5, 0);
enableLbl:SetText("Enabled");


-- SPEC 1


local spec1Lbl = daftSetSwapOptionsPanel:CreateFontString("spec1Lbl", "ARTWORK", "GameFontNormalLarge");
spec1Lbl:SetPoint("TOPLEFT", EnableBtn, "BOTTOMLEFT", 0, -10);
spec1Lbl:SetText("Specialization 1");


local EnableSpec1Btn = CreateFrame("CheckButton", "EnableSpec1Btn", daftSetSwapOptionsPanel, "ChatConfigCheckButtonTemplate");
EnableSpec1Btn:SetPoint("TOPLEFT", spec1Lbl, "BOTTOMLEFT", 0, -5);
EnableSpec1Btn:SetChecked(false);
 
EnableSpec1Btn:SetScript("OnClick", function(self)
	if self:GetChecked() then
		SPEC1 = true;
	else
		SPEC1 = false;
	end;
end);
  
  
local enableSpec1Lbl = daftSetSwapOptionsPanel:CreateFontString("enableSpec1Lbl", "ARTWORK", "GameFontHighlight");
enableSpec1Lbl:SetPoint("LEFT", EnableSpec1Btn, "RIGHT", 5, 0);
enableSpec1Lbl:SetText("Enabled");


local Spec1NoCombatLbl = daftSetSwapOptionsPanel:CreateFontString("Spec1NoCombatLbl", "ARTWORK", "GameFontHighlight");
Spec1NoCombatLbl:SetPoint("TOPLEFT", EnableSpec1Btn, "BOTTOMLEFT", 0, -5);
Spec1NoCombatLbl:SetText("Out of Combat");


local Spec1NoCombatDropdown = CreateFrame("Frame", "Spec1NoCombatDropdown", daftSetSwapOptionsPanel, "UIDropDownMenuTemplate");
Spec1NoCombatDropdown:SetPoint("LEFT", Spec1NoCombatLbl, "RIGHT", -5, -5);
Spec1NoCombatDropdown.initialize = function(dropdown)
	
	local items = {};
	for i = 1, GetNumEquipmentSets() do
		local name, icon, setID, isEquipped, totalItems, equippedItems, inventoryItems, missingItems, ignoredSlots = GetEquipmentSetInfo(i);
		items[i] = name;
	end;
	
	for i, v in pairs(items) do
		local info = UIDropDownMenu_CreateInfo();
		info.text = items[i];
		info.value = items[i];
		info.func = function(self)
			SPEC1_NOCOMBAT = self.value;
			UIDropDownMenu_SetText(dropdown, self.value);
		end;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end;
end;



local Spec1CombatLbl = daftSetSwapOptionsPanel:CreateFontString("Spec1CombatLbl", "ARTWORK", "GameFontHighlight");
Spec1CombatLbl:SetPoint("LEFT", Spec1NoCombatDropdown, "RIGHT", 130, 0);
Spec1CombatLbl:SetText("In Combat");


local Spec1CombatDropdown = CreateFrame("Frame", "Spec1CombatDropdown", daftSetSwapOptionsPanel, "UIDropDownMenuTemplate");
Spec1CombatDropdown:SetPoint("LEFT", Spec1CombatLbl, "RIGHT", -5, -5);
Spec1CombatDropdown.initialize = function(dropdown)
	
	local items = {};
	for i = 1, GetNumEquipmentSets() do
		local name, icon, setID, isEquipped, totalItems, equippedItems, inventoryItems, missingItems, ignoredSlots = GetEquipmentSetInfo(i);
		items[i] = name;
	end;
	
	for i, v in pairs(items) do
		local info = UIDropDownMenu_CreateInfo();
		info.text = items[i];
		info.value = items[i];
		info.func = function(self)
			SPEC1_COMBAT = self.value;
			UIDropDownMenu_SetText(dropdown, self.value);
		end;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end;
end;














-- --Second Dropdown
-- local function SecondarySelection(button, setID, name)
	-- UIDropDownMenu_SetText(Secondary, name)
	-- ssname2 = name
-- end 

-- local Secondary = CreateFrame("Frame", "Secondary", daftSetSwapOptionsPanel, "UIDropDownMenuTemplate")
-- Secondary.initialize = function(self, selection) end
-- Secondary:SetPoint("TOPRIGHT", -275, -80);

-- Secondary.initialize = function(self, selection)
  
	
	-- if not selection then return end
    -- wipe(equipmentSet)
    -- if selection == 1 then
		-- equipmentSet.text = "None"
		-- --equipmentSet.icon = icon
		-- equipmentSet.func = SecondarySelection 
		-- --equipmentSet.setID = i
		-- equipmentSet.name = nil
		-- equipmentSet.notCheckable = 1
		-- UIDropDownMenu_AddButton(equipmentSet, selection)
		-- for i = 1, GetNumEquipmentSets() do
		-- local name, icon, setID, isEquipped, totalItems, equippedItems, inventoryItems, missingItems, ignoredSlots = GetEquipmentSetsetInfo(i)
		-- equipmentSet.text = name
		-- equipmentSet.icon = icon
		-- equipmentSet.func = SecondarySelection 
		-- equipmentSet.setID = i
		-- equipmentSet.name = name
		-- equipmentSet.notCheckable = 1
		-- UIDropDownMenu_AddButton(equipmentSet, selection)
		-- end
    -- end
-- end
