local addonName, addonTable = ... 

local frame = CreateFrame("Frame")


frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- HELPER FUNCTIONS


local function ScrollChat(frame, delta)
	
	if IsControlKeyDown()  then --Faster Scroll

		if ( delta > 0 ) then --Faster scrolling by triggering a few scroll up in a loop
		
			for i = 1, 5 do 
			
				frame:ScrollUp()
			end
		
		elseif ( delta < 0 ) then
		
			for i = 1, 5 do 
			
				frame:ScrollDown()
			end
		end
	
	elseif IsAltKeyDown() then
		
		if ( delta > 0 ) then --Scroll to the top or bottom
			
			frame:ScrollToTop()
		
		elseif ( delta < 0 ) then
		
			frame:ScrollToBottom()
		end
	else
	
		if delta > 0 then --Normal Scroll
			
			frame:ScrollUp()
		
		elseif delta < 0 then
			
			frame:ScrollDown()
		end
	end
end


-- FEATURE FUNCTIONS


local function ChangeChatFrames()

	for i = 1, NUM_CHAT_WINDOWS do

		local ChatFrame = _G["ChatFrame"..i]
		local EditBox = _G["ChatFrame"..i.."EditBox"]
		local Tab = _G["ChatFrame"..i.."Tab"]
		
		if ChatFrame then
			
			if addonTable.SCREEN_CLAMP_FIX then
			
				ChatFrame:SetClampRectInsets(50,-50,-50,50)
			end

			if addonTable.DYNAMIC_SCROLL then
				
				ChatFrame:EnableMouseWheel(true)
				ChatFrame:SetScript('OnMouseWheel', ScrollChat)
			end

			if addonTable.MAXLINES then
				
				ChatFrame:SetMaxLines(addonTable.MAXLINES)
			end
			
			if addonTable.EDITBOX_ON_TOP then
				
				EditBox:ClearAllPoints()
				EditBox:SetPoint("BOTTOMLEFT",  ChatFrame, "TOPLEFT",  -5, 0)
				EditBox:SetPoint("BOTTOMRIGHT", ChatFrame, "TOPRIGHT", 5, 0)
			
				-- Makes clicking a tab close EditBox
				Tab:HookScript("OnClick", function() EditBox:Hide() end)
				
				--force the editbox to hide itself when it loses focus
				EditBox:HookScript("OnEditFocusLost", function(self) self:Hide() end)
			end
			
			if addonTable.EDITBOX_HIDE_BACKGROUND then
				
				_G[EditBox.."Left"]:SetAlpha(0)
				_G[EditBox.."Mid"]:SetAlpha(0)
				_G[EditBox.."Right"]:SetAlpha(0)
			end
			
			if addonTable.EDITBOX_HIDE_FOCUS_LINE then
				
				EditBox.focusLeft:SetAlpha(0)
				EditBox.focusRight:SetAlpha(0)
				EditBox.focusMid:SetAlpha(0)
			end

			if addonTable.NO_ALT then
				
				EditBox:SetAltArrowKeyMode(false)
			end
			
			if addonTable.MESSAGE_FADING then
				
				ChatFrame:SetFading(true)
				ChatFrame:SetTimeVisible(20)
				ChatFrame:SetFadeDuration(20)
			end
			
			if addonTable.STRATA_ABOVE_MAINBAR then
				
				ChatFrame:SetFrameStrata("HIGH")
			end
		end
		
	end
end

local function EnableClearCommand()
	
	SLASH_CLEARCHAT1, SLASH_CLEARCHAT2 = '/c', '/clear'
	
	function SlashCmdList.CLEARCHAT()
		
		for i = 1, NUM_CHAT_WINDOWS do
			
			local ChatFrame = _G["ChatFrame"..i]
			ChatFrame:Clear()
		end
	end
end


local function EnableShortReloadCommand()
	
	SLASH_RL1 = '/rl'
	
	function SlashCmdList.RL()
		
		ReloadUI()
	end
end


local function DetectUrls()
	
	local newAddMsg = {}
	
	local function AddMessage(frame, message, ...)
		
		if (message) then
			
			 -- These semicolons are required, or it sends the link like 20 times
			message = gsub(message, '([wWhH][wWtT][wWtT][%.pP]%S+[^%p%s])', '|cffffffff|Hurl:%1|h[%1]|h|r');
			message = gsub(message, " ([_A-Za-z0-9-%.]+@[_A-Za-z0-9-]+%.+[_A-Za-z0-9-%.]+)%s?", "|cffffffff|Hurl:%1|h[%1]|h|r");
			message = gsub(message, " (%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)%s?", "|cffffffff|Hurl:%1|h[%1]|h|r");
			message = gsub(message, " (%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?)%s?", "|cffffffff|Hurl:%1|h[%1]|h|r");
			return newAddMsg[frame:GetName()](frame, message, ...)
		end
	end

	for i = 1, NUM_CHAT_WINDOWS do
		
		if i ~= 2 then
			
			local frame = _G[format("%s%d", "ChatFrame", i)]
			newAddMsg[format("%s%d", "ChatFrame", i)] = frame.AddMessage
			frame.AddMessage = AddMessage
		end
	end
	
	local orig = ChatFrame_OnHyperlinkShow
	
	function ChatFrame_OnHyperlinkShow(frame, link, text, button)
		
		local type, value = link:match("(%a+):(.+)")
		
		if ( type == "url" ) then
			
			local editBox = _G[frame:GetName()..'EditBox']
			
			if editBox then
				
				editBox:Show()
				editBox:SetText(value)
				editBox:SetFocus()
				editBox:HighlightText()
			end
		else
			
			orig(self, link, text, button)
		end
	end
end


local function EnableClassColors()
	
	for i, v in pairs(CHAT_CONFIG_CHAT_LEFT) do
		
		ToggleChatColorNamesByClassGroup(true, v.type)
	end

	-- For global channels not listed under CHAT_CONFIG_CHAT_LEFT
	for i = 1, 15 do
		
		ToggleChatColorNamesByClassGroup(true, "CHANNEL"..i)
	end
end


local function MakeChannelsSticky()
	
	for i, v in pairs(addonTable.StickyTypeChannels) do
		
		ChatTypeInfo[i].sticky = v
	end
end


local function RevertGoldMessage()
	
	YOU_LOOT_MONEY_GUILD = YOU_LOOT_MONEY
	LOOT_MONEY_SPLIT_GUILD = LOOT_MONEY_SPLIT
end


-- SCRIPTS

frame:SetScript("OnEvent", function(self, event, arg1)
	
	if event == "ADDON_LOADED" and arg1 == "daftChat" then

		if addonTable.COMMAND_CLEAR then
			
			EnableClearCommand()
		end

		if addonTable.COMMAND_RL then
			
			EnableShortReloadCommand()
		end

		ChangeChatFrames()
	end

	if event == "PLAYER_ENTERING_WORLD" then

		if addonTable.URLCOPY then
			
			DetectUrls()
		end
		
		if addonTable.STICKY_CHANNELS then
			
			MakeChannelsSticky()
		end
						
		if addonTable.CLASS_COLORS then
			
			EnableClassColors()
		end
		
		if addonTable.OLD_LOOT_MESSAGE then
			
			RevertGoldMessage()
		end		
	end
end)