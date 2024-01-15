local addonName, addonTable = ... 

local Options = CreateFrame("Frame", "daftUITweaksOptions", InterfaceOptionsPanelContainer)
Options.name = GetAddOnMetadata(addonName, "Title") or addonName
InterfaceOptions_AddCategory(Options)
Options:Hide()

Options:RegisterEvent("PLAYER_LOGOUT")

-- FUNCTIONS

function CreateCheckbox(label, description, x, y, pointParent, parent)
	local checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    checkbox:SetPoint("TOPLEFT", pointParent, "BOTTOMLEFT", x, y)

	checkbox.label = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    checkbox.label:SetPoint("LEFT", checkbox, "RIGHT", 0, 0)
	checkbox.label:SetText(label)
	
	checkbox.tooltipText = label
	checkbox.tooltipRequirement = description

    return checkbox
end

local function CreateSlider(name, parent, low, high, label, description)
	local Slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
	Slider:SetWidth(180)
	Slider:SetObeyStepOnDrag(true)

	Slider.label = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    Slider.label:SetPoint("TOP", Slider, "BOTTOM", 0, 0)
	Slider.label:SetText(label)

	Slider.low = _G[Slider:GetName().."Low"]
	Slider.low:SetPoint("TOPLEFT", Slider, "BOTTOMLEFT", 0, 0)
	Slider.low:SetFontObject(GameFontNormalSmall)
	Slider.low:SetText(low)

	Slider.high = _G[Slider:GetName().."High"]
	Slider.high:SetPoint("TOPRIGHT", Slider, "BOTTOMRIGHT", 0, 0)
	Slider.high:SetFontObject(GameFontNormalSmall)
	Slider.high:SetText(high)
	
	Slider.value = Slider:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	Slider.value:SetPoint("BOTTOM", Slider, "TOP")

	Slider.tooltipText = label
	Slider.tooltipRequirement = description

	return Slider
end

local function initDB(a, b) -- Initialize for when no savedvariables are found
    if type(a) ~= "table" then return {} end
    if type(b) ~= "table" then b = {} end
    for k, v in pairs(a) do
        if type(v) == "table" then
            b[k] = initDB(v, b[k])
        elseif type(b[k]) ~= type(v) then
            b[k] = v
        end
    end
    return b
end

daftUITweaksDB = initDB(addonTable.db, daftUITweaksDB)

addonTable.db = daftUITweaksDB


-- Default section
Options:SetScript("OnShow", function(self)

    local title = Options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText(addonName)
    
    local SubText = Options:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
		SubText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
		SubText:SetText(GetAddOnMetadata(addonName, "Notes"))
    
	local ENABLE_UIFADE = CreateCheckbox("Full UI Fading", "Fade the entire UI when not in use.", 0, -16, SubText, Options)
		ENABLE_UIFADE:SetChecked(addonTable.db.ENABLE_UIFADE)
		ENABLE_UIFADE:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_UIFADE = self:GetChecked()
		end)

	local UIFADE_NAMES = CreateCheckbox("Fade Names", "Hide names when UI is faded out", 16, -4, ENABLE_UIFADE, Options)
		UIFADE_NAMES:SetChecked(addonTable.db.UIFADE_NAMES)
		UIFADE_NAMES:SetScript("OnClick", function(self)
			addonTable.db.UIFADE_NAMES = self:GetChecked()
		end)

    local UIFADE_IN = CreateSlider("$parentFADEIN", Options, "0.1", "1.0", "Fade In Alpha", "Adjusts the alpha when UI is faded in.")
		UIFADE_IN:SetPoint("LEFT", ENABLE_UIFADE.label, "RIGHT", 80, 0)
		UIFADE_IN:SetMinMaxValues(0.1, 1.0)
        UIFADE_IN:SetValueStep(0.1)
        UIFADE_IN:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.UIFADE_IN = value
		end)

	local UIFADE_OUT = CreateSlider("$parentFADEOUT", Options, "0.0", "1.0", "Fade Out Alpha", "Adjusts the alpha when UI is faded out.")
		UIFADE_OUT:SetPoint("LEFT", UIFADE_IN, "RIGHT", 16, 0)
		UIFADE_OUT:SetMinMaxValues(0.0, 1.0)
        UIFADE_OUT:SetValueStep(0.1)
		UIFADE_OUT:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.UIFADE_OUT = value
		end)

	local ENABLE_UICOLORS = CreateCheckbox("Colorize UI", "Set a hue on multiple UI elements based on character class OR a custom color.", -16, -40, UIFADE_NAMES, Options)
		ENABLE_UICOLORS:SetChecked(addonTable.db.ENABLE_UICOLORS)
		ENABLE_UICOLORS:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_UICOLORS = self:GetChecked()
		end)

	local UICOLORS_CUSTOM = CreateCheckbox("Use Custom Colors", "Use a custom color, rather than class colors.", 16, -4, ENABLE_UICOLORS, Options)
		UICOLORS_CUSTOM:SetChecked(addonTable.db.UICOLORS_CUSTOM)
		UICOLORS_CUSTOM:SetScript("OnClick", function(self)
			addonTable.db.UICOLORS_CUSTOM = self:GetChecked()
		end)

    local UICOLORS_CUSTOM_R = CreateSlider("$parentUICOLORS_CUSTOM_R", Options, "0", "255", "Red", "Set the amount of Red in custom color.")
		UICOLORS_CUSTOM_R:SetWidth(500)	
		UICOLORS_CUSTOM_R:SetPoint("TOPLEFT", UICOLORS_CUSTOM, "BOTTOMLEFT", 0, -32)
		UICOLORS_CUSTOM_R:SetMinMaxValues(0, 255)
		UICOLORS_CUSTOM_R:SetValueStep(1)
		UICOLORS_CUSTOM_R:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.UICOLORS_CUSTOM_R = value
		end)

    local UICOLORS_CUSTOM_G = CreateSlider("$parentUICOLORS_CUSTOM_G", Options, "0", "255", "Green", "Set the amount of Green in custom color.")
		UICOLORS_CUSTOM_G:SetWidth(500)
		UICOLORS_CUSTOM_G:SetPoint("TOPLEFT", UICOLORS_CUSTOM_R, "BOTTOMLEFT", 0, -40)
		UICOLORS_CUSTOM_G:SetMinMaxValues(0, 255)
		UICOLORS_CUSTOM_G:SetValueStep(1)
		UICOLORS_CUSTOM_G:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.UICOLORS_CUSTOM_G = value
		end)

    local UICOLORS_CUSTOM_B = CreateSlider("$parentUICOLORS_CUSTOM_B", Options, "0", "255", "Blue", "Set the amount of Blue in custom color.")
		UICOLORS_CUSTOM_B:SetWidth(500)	
		UICOLORS_CUSTOM_B:SetPoint("TOPLEFT", UICOLORS_CUSTOM_G, "BOTTOMLEFT", 0, -40)
		UICOLORS_CUSTOM_B:SetMinMaxValues(0, 255)
		UICOLORS_CUSTOM_B:SetValueStep(1)
		UICOLORS_CUSTOM_B:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.UICOLORS_CUSTOM_B = value
		end)

    local UICOLORS_CUSTOM_A = CreateSlider("$parentUICOLORS_CUSTOM_A", Options, "0.0", "1.0", "Alpha", "Set the Alpha in custom color. Think of this as strength/depth of the color.")
		UICOLORS_CUSTOM_A:SetWidth(500)	
		UICOLORS_CUSTOM_A:SetPoint("TOPLEFT", UICOLORS_CUSTOM_B, "BOTTOMLEFT", 0, -40)
		UICOLORS_CUSTOM_A:SetMinMaxValues(0, 1)
		UICOLORS_CUSTOM_A:SetValueStep(0.1)
		UICOLORS_CUSTOM_A:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.UICOLORS_CUSTOM_A = value
		end)
    
    function self:refresh()
		UIFADE_IN:SetValue(daftUITweaksDB.UIFADE_IN)
		UIFADE_OUT:SetValue(daftUITweaksDB.UIFADE_OUT)
		UICOLORS_CUSTOM_R:SetValue(daftUITweaksDB.UICOLORS_CUSTOM_R)
		UICOLORS_CUSTOM_G:SetValue(daftUITweaksDB.UICOLORS_CUSTOM_G)
		UICOLORS_CUSTOM_B:SetValue(daftUITweaksDB.UICOLORS_CUSTOM_B)
		UICOLORS_CUSTOM_A:SetValue(daftUITweaksDB.UICOLORS_CUSTOM_A)
    end

	self:refresh()
	self:SetScript("OnShow", nil)
end)


-- Castbars Panel
local OptionsCastBars = CreateFrame('Frame', nil, InterfaceOptionsFramePanelContainer)
	OptionsCastBars.name = "Cast Bars"
	OptionsCastBars.parent = addonName
	InterfaceOptions_AddCategory(OptionsCastBars, addonName)
	OptionsCastBars:Hide()

OptionsCastBars:SetScript("OnShow", function(self)

	local title = OptionsCastBars:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText(addonName .. " - Cast Bars - WORK IN PROGRESS")
    
    local SubText = OptionsCastBars:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
		SubText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
		SubText:SetText(GetAddOnMetadata(addonName, "Notes"))
	
	local ENABLE_CASTBARS = CreateCheckbox("Cast Bar Tweaks", "", 0, -16, SubText, OptionsCastBars)
		ENABLE_CASTBARS:SetChecked(addonTable.db.ENABLE_CASTBARS)
		ENABLE_CASTBARS:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_CASTBARS = self:GetChecked()
		end)

	local CASTBARS_PLAYER = CreateCheckbox("Player Castbar", "", 16, -4, ENABLE_CASTBARS, OptionsCastBars)
		CASTBARS_PLAYER:SetChecked(addonTable.db.CASTBARS_PLAYER)
		CASTBARS_PLAYER:SetScript("OnClick", function(self)
			addonTable.db.CASTBARS_PLAYER = self:GetChecked()
		end)

	local PLAYER_BIG_SPELL_ICON = CreateCheckbox("Show Spell Icon in Portrait", "", 16, -4, CASTBARS_PLAYER, OptionsCastBars)
		PLAYER_BIG_SPELL_ICON:SetChecked(addonTable.db.PLAYER_BIG_SPELL_ICON)
		PLAYER_BIG_SPELL_ICON:SetScript("OnClick", function(self)
			addonTable.db.PLAYER_BIG_SPELL_ICON = self:GetChecked()
		end)

	local PLAYER_HIDE_SPELL_ICON = CreateCheckbox("Hide Spell Icon", "", 0, -4, PLAYER_BIG_SPELL_ICON, OptionsCastBars)
		PLAYER_HIDE_SPELL_ICON:SetChecked(addonTable.db.PLAYER_HIDE_SPELL_ICON)
		PLAYER_HIDE_SPELL_ICON:SetScript("OnClick", function(self)
			addonTable.db.PLAYER_HIDE_SPELL_ICON = self:GetChecked()
		end)

	local PLAYER_TIMER = CreateCheckbox("Show Cast Timer", "", 0, -4, PLAYER_HIDE_SPELL_ICON, OptionsCastBars)
		PLAYER_TIMER:SetChecked(addonTable.db.PLAYER_TIMER)
		PLAYER_TIMER:SetScript("OnClick", function(self)
			addonTable.db.PLAYER_TIMER = self:GetChecked()
		end)
	
	-- PLAYER_HIDE_PVP_ICON

	local CASTBARS_TARGET = CreateCheckbox("Target Castbar", "", -16, -4, PLAYER_TIMER, OptionsCastBars)
		CASTBARS_TARGET:SetChecked(addonTable.db.CASTBARS_TARGET)
		CASTBARS_TARGET:SetScript("OnClick", function(self)
			addonTable.db.CASTBARS_TARGET = self:GetChecked()
		end)

	local TARGET_BIG_SPELL_ICON = CreateCheckbox("Show Spell Icon in Portrait", "", 16, -4, CASTBARS_TARGET, OptionsCastBars)
		TARGET_BIG_SPELL_ICON:SetChecked(addonTable.db.TARGET_BIG_SPELL_ICON)
		TARGET_BIG_SPELL_ICON:SetScript("OnClick", function(self)
			addonTable.db.TARGET_BIG_SPELL_ICON = self:GetChecked()
		end)

	local TARGET_HIDE_SPELL_ICON = CreateCheckbox("Hide Spell Icon", "", 0, -4, TARGET_BIG_SPELL_ICON, OptionsCastBars)
		TARGET_HIDE_SPELL_ICON:SetChecked(addonTable.db.TARGET_HIDE_SPELL_ICON)
		TARGET_HIDE_SPELL_ICON:SetScript("OnClick", function(self)
			addonTable.db.TARGET_HIDE_SPELL_ICON = self:GetChecked()
		end)

	local TARGET_TIMER = CreateCheckbox("Show Cast Timer", "", 0, -4, TARGET_HIDE_SPELL_ICON, OptionsCastBars)
		TARGET_TIMER:SetChecked(addonTable.db.TARGET_TIMER)
		TARGET_TIMER:SetScript("OnClick", function(self)
			addonTable.db.TARGET_TIMER = self:GetChecked()
		end)

	self:SetScript("OnShow", nil)
end)


-- Mainbar Panel
local OptionsMainbar = CreateFrame('Frame', nil, InterfaceOptionsFramePanelContainer)
	OptionsMainbar.name = "Main Bar"
	OptionsMainbar.parent = addonName
	InterfaceOptions_AddCategory(OptionsMainbar, addonName)
	OptionsMainbar:Hide()

OptionsMainbar:SetScript("OnShow", function(self)

	local title = OptionsMainbar:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText(addonName .. " - Main Bar")
    
    local SubText = OptionsMainbar:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
		SubText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
		SubText:SetText(GetAddOnMetadata(addonName, "Notes"))
	
	local ENABLE_MAINBAR = CreateCheckbox("Mainbar Bar Tweaks", "", 0, -16, SubText, OptionsMainbar)
		ENABLE_MAINBAR:SetChecked(addonTable.db.ENABLE_MAINBAR)
		ENABLE_MAINBAR:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_MAINBAR = self:GetChecked()
		end)

	local MAINBAR_HIDE_BAGS = CreateCheckbox("Hide Bagbar", "", 0, -16, ENABLE_MAINBAR, OptionsMainbar)
		MAINBAR_HIDE_BAGS:SetChecked(addonTable.db.MAINBAR_HIDE_BAGS)
		MAINBAR_HIDE_BAGS:SetScript("OnClick", function(self)
			addonTable.db.MAINBAR_HIDE_BAGS = self:GetChecked()
		end)

	local MAINBAR_HIDE_MENU = CreateCheckbox("Hide Menubar", "", 0, -4, MAINBAR_HIDE_BAGS, OptionsMainbar)
		MAINBAR_HIDE_MENU:SetChecked(addonTable.db.MAINBAR_HIDE_MENU)
		MAINBAR_HIDE_MENU:SetScript("OnClick", function(self)
			addonTable.db.MAINBAR_HIDE_MENU = self:GetChecked()
		end)

	local MAINBAR_HIDE_HOTKEYS = CreateCheckbox("Hide Hotkeys", "", 0, -4, MAINBAR_HIDE_MENU, OptionsMainbar)
		MAINBAR_HIDE_HOTKEYS:SetChecked(addonTable.db.MAINBAR_HIDE_HOTKEYS)
		MAINBAR_HIDE_HOTKEYS:SetScript("OnClick", function(self)
			addonTable.db.MAINBAR_HIDE_HOTKEYS = self:GetChecked()
		end)
	
	local MAINBAR_HIDE_MACRONAMES = CreateCheckbox("Hide Macro Names", "", 0, -4, MAINBAR_HIDE_HOTKEYS, OptionsMainbar)
		MAINBAR_HIDE_MACRONAMES:SetChecked(addonTable.db.MAINBAR_HIDE_MACRONAMES)
		MAINBAR_HIDE_MACRONAMES:SetScript("OnClick", function(self)
			addonTable.db.MAINBAR_HIDE_MACRONAMES = self:GetChecked()
		end)

	-- local MAINBAR_SKIN_BUTTONERRORS = CreateCheckbox("Actionbutton Highlighting", "Highlight action buttons RED when out of range; blue when out of resources.", 0, -4, MAINBAR_HIDE_MACRONAMES, OptionsMainbar)
	-- MAINBAR_SKIN_BUTTONERRORS:SetChecked(addonTable.db.MAINBAR_SKIN_BUTTONERRORS)
	-- MAINBAR_SKIN_BUTTONERRORS:SetScript("OnClick", function(self)
	-- 	addonTable.db.MAINBAR_SKIN_BUTTONERRORS = self:GetChecked()
	-- end)
	
	function self:refresh()

    end

	self:refresh()
	self:SetScript("OnShow", nil)
end)


-- Unit Frames Panel
local OptionsUnitFrames = CreateFrame('Frame', nil, InterfaceOptionsFramePanelContainer)
	OptionsUnitFrames.name = "Unit Frames"
	OptionsUnitFrames.parent = addonName
	InterfaceOptions_AddCategory(OptionsUnitFrames, addonName)
	OptionsUnitFrames:Hide()

OptionsUnitFrames:SetScript("OnShow", function(self)

	local title = OptionsUnitFrames:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText(addonName .. " - Unit Frames - WORK IN PROGRESS")
    
    local SubText = OptionsUnitFrames:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
		SubText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
		SubText:SetText(GetAddOnMetadata(addonName, "Notes"))
	
	local CLASS_PORTRAIT = CreateCheckbox("Change Portraits to Class Icons", "", 0, -16, SubText, OptionsUnitFrames)
		CLASS_PORTRAIT:SetChecked(addonTable.db.CLASS_PORTRAIT)
		CLASS_PORTRAIT:SetScript("OnClick", function(self)
			addonTable.db.CLASS_PORTRAIT = self:GetChecked()
		end)

	local CLASS_HEALTH = CreateCheckbox("Health Bars Match Class Colors", "", 0, -4, CLASS_PORTRAIT, OptionsUnitFrames)
		CLASS_HEALTH:SetChecked(addonTable.db.CLASS_HEALTH)
		CLASS_HEALTH:SetScript("OnClick", function(self)
			addonTable.db.CLASS_HEALTH = self:GetChecked()
		end)

	local ENABLE_FONTS = CreateCheckbox("Improve Unit Frame Fonts", "", 0, -4, CLASS_HEALTH, OptionsUnitFrames)
		ENABLE_FONTS:SetChecked(addonTable.db.ENABLE_FONTS)
		ENABLE_FONTS:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_FONTS = self:GetChecked()
		end)

	local TargetSection = OptionsUnitFrames:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		TargetSection:SetPoint("TOPLEFT", ENABLE_FONTS, "BOTTOMLEFT", 0, -16)
		TargetSection:SetText("Target Frame")
	
	local TARGET_ROLE = CreateCheckbox("Show Target Role Icons", "When target is in your group/raid.", 8, -4, TargetSection, OptionsUnitFrames)
		TARGET_ROLE:SetChecked(addonTable.db.TARGET_ROLE)
		TARGET_ROLE:SetScript("OnClick", function(self)
			addonTable.db.TARGET_ROLE = self:GetChecked()
		end)

	self:SetScript("OnShow", nil)
end)


-- Gossip and Dressup Panel
local OptionsGossipDressup = CreateFrame('Frame', nil, InterfaceOptionsFramePanelContainer)
	OptionsGossipDressup.name = "Gossip and Dressup"
	OptionsGossipDressup.parent = addonName
	InterfaceOptions_AddCategory(OptionsGossipDressup, addonName)
	OptionsGossipDressup:Hide()

OptionsGossipDressup:SetScript("OnShow", function(self)

    local title = OptionsGossipDressup:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText(addonName .. " - Gossip and Dressup")
    
    local SubText = OptionsGossipDressup:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
		SubText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
		SubText:SetText(GetAddOnMetadata(addonName, "Notes"))
    
	local ENABLE_GOSSIP = CreateCheckbox("Gossip Frame Tweaks", "", 0, -16, SubText, OptionsGossipDressup)
		ENABLE_GOSSIP:SetChecked(addonTable.db.ENABLE_GOSSIP)
		ENABLE_GOSSIP:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_GOSSIP = self:GetChecked()
		end)

	local GOSSIP_MERCHANT = CreateCheckbox("Include Merchant Windows", "", 16, -4, ENABLE_GOSSIP, OptionsGossipDressup)
		GOSSIP_MERCHANT:SetChecked(addonTable.db.GOSSIP_MERCHANT)
		GOSSIP_MERCHANT:SetScript("OnClick", function(self)
			addonTable.db.GOSSIP_MERCHANT = self:GetChecked()
		end)

		local GOSSIP_SCALE = CreateSlider("$parentGOSSIP_SCALE", GOSSIP_MERCHANT, "0.1", "2.0", "Gossip Scale", "Adjusts the scale of all gossip frames.")
		GOSSIP_SCALE:SetPoint("LEFT", ENABLE_GOSSIP, "RIGHT", 150, 0)
		GOSSIP_SCALE:SetMinMaxValues(0.1, 2.0)
		GOSSIP_SCALE:SetValueStep(0.1)
		GOSSIP_SCALE:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.GOSSIP_SCALE = value
		end)

	local GOSSIP_QUEST = CreateCheckbox("Include Quest Windows", "", 0, -4, GOSSIP_MERCHANT, OptionsGossipDressup)
		GOSSIP_QUEST:SetChecked(addonTable.db.GOSSIP_QUEST)
		GOSSIP_QUEST:SetScript("OnClick", function(self)
			addonTable.db.GOSSIP_QUEST = self:GetChecked()
		end)
		
	local GOSSIP_BOOKS = CreateCheckbox("Include Book Windows", "", 0, -4, GOSSIP_QUEST, OptionsGossipDressup)
		GOSSIP_BOOKS:SetChecked(addonTable.db.GOSSIP_BOOKS)
		GOSSIP_BOOKS:SetScript("OnClick", function(self)
			addonTable.db.GOSSIP_BOOKS = self:GetChecked()
		end)
		
	local GOSSIP_TOCHAT = CreateCheckbox("Send Gossip Text to Chat", "When you simply can't stay, but still want to read what they said!", 0, -4, GOSSIP_BOOKS, OptionsGossipDressup)
		GOSSIP_TOCHAT:SetChecked(addonTable.db.GOSSIP_TOCHAT)
		GOSSIP_TOCHAT:SetScript("OnClick", function(self)
			addonTable.db.GOSSIP_TOCHAT = self:GetChecked()
		end)

		local ENABLE_DRESSUP = CreateCheckbox("Dressup Frame Tweaks", "", -16, -4, GOSSIP_TOCHAT, OptionsGossipDressup)
		ENABLE_DRESSUP:SetChecked(addonTable.db.ENABLE_DRESSUP)
		ENABLE_DRESSUP:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_DRESSUP = self:GetChecked()
		end)

	local DRESSUP_MOUSEOVER = CreateCheckbox("Hide Frame Until Mouseover", "", 16, -4, ENABLE_DRESSUP, OptionsGossipDressup)
		DRESSUP_MOUSEOVER:SetChecked(addonTable.db.DRESSUP_MOUSEOVER)
		DRESSUP_MOUSEOVER:SetScript("OnClick", function(self)
			addonTable.db.DRESSUP_MOUSEOVER = self:GetChecked()
		end)

		local DRESSUP_SCALE = CreateSlider("$parentDRESSUP_SCALE", OptionsGossipDressup, "0.1", "2.0", "Dressup Scale", "Adjusts the scale of the Dressup frames.")
		DRESSUP_SCALE:SetPoint("LEFT", ENABLE_DRESSUP, "RIGHT", 150, 0)
		DRESSUP_SCALE:SetMinMaxValues(0.1, 2.0)
		DRESSUP_SCALE:SetValueStep(0.1)
		DRESSUP_SCALE:SetScript("OnValueChanged", function(self, value)
			value = floor(value * 10) / 10
			self.value:SetText(value)
            addonTable.db.DRESSUP_SCALE = value
		end)

	local DRESSUP_CENTER = CreateCheckbox("Center Dressup Frame", "", 0, -4, DRESSUP_MOUSEOVER, OptionsGossipDressup)
		DRESSUP_CENTER:SetChecked(addonTable.db.DRESSUP_CENTER)
		DRESSUP_CENTER:SetScript("OnClick", function(self)
			addonTable.db.DRESSUP_CENTER = self:GetChecked()
		end)

    function self:refresh()
		GOSSIP_SCALE:SetValue(daftUITweaksDB.GOSSIP_SCALE)
		DRESSUP_SCALE:SetValue(daftUITweaksDB.DRESSUP_SCALE)
    end

	self:refresh()
	self:SetScript("OnShow", nil)
end)


-- Minimap Panel
local OptionsMinimap = CreateFrame('Frame', nil, InterfaceOptionsFramePanelContainer)
	OptionsMinimap.name = "Minimap"
	OptionsMinimap.parent = addonName
	InterfaceOptions_AddCategory(OptionsMinimap, addonName)
	OptionsMinimap:Hide()

OptionsMinimap:SetScript("OnShow", function(self)

    local title = OptionsMinimap:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		title:SetPoint("TOPLEFT", 16, -16)
		title:SetText(addonName .. " - Minimap  - WORK IN PROGRESS")
    
    local SubText = OptionsMinimap:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
		SubText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)
		SubText:SetText(GetAddOnMetadata(addonName, "Notes"))
    
	local ENABLE_MINIMAP = CreateCheckbox("Minimap Tweaks", "", 0, -16, SubText, OptionsMinimap)
		ENABLE_MINIMAP:SetChecked(addonTable.db.ENABLE_MINIMAP)
		ENABLE_MINIMAP:SetScript("OnClick", function(self)
			addonTable.db.ENABLE_MINIMAP = self:GetChecked()
		end)

	local MICROMENU = CreateCheckbox("Enable Right-Click Micro Menu", "Right-click the Zone Text to show the Micro Menu", 0, -4, ENABLE_MINIMAP, OptionsMinimap)
		MICROMENU:SetChecked(addonTable.db.MICROMENU)
		MICROMENU:SetScript("OnClick", function(self)
			addonTable.db.MICROMENU = self:GetChecked()
		end)
    
	function self:refresh()

	end

	self:refresh()
	self:SetScript("OnShow", nil)
end)

function Options:PLAYER_LOGOUT()

    daftUITweaksDB = addonTable.db
end