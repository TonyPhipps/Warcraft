local addonName, addonTable = ... ;

local addonName = CreateFrame("Frame");

addonName:RegisterEvent("PLAYER_LOGIN");
addonName:RegisterEvent("ADDON_LOADED");


-- HELPER FUNCTIONS


local function ScrollChat(frame, delta)
	
	if IsControlKeyDown()  then--Faster Scroll

		if ( delta > 0 ) then --Faster scrolling by triggering a few scroll up in a loop
			for i = 1,5 do 
				frame:ScrollUp();
			end;
		
		elseif ( delta < 0 ) then
			for i = 1,5 do 
				frame:ScrollDown();
			end;
		end;
	
	elseif IsAltKeyDown() then
		
		if ( delta > 0 ) then --Scroll to the top or bottom
			frame:ScrollToTop();
		
		elseif ( delta < 0 ) then
			frame:ScrollToBottom();
		end	;
	else
	
		if delta > 0 then --Normal Scroll
			frame:ScrollUp();
		
		elseif delta < 0 then
			frame:ScrollDown()
		end;
	end;
end;


-- FEATURE FUNCTIONS


local function AdjustScreenClamp()
	for i = 1, NUM_CHAT_WINDOWS do
		local chatFrameNumber = ("ChatFrame%d"):format(i);
		local ChatFrameNumberFrame = _G[chatFrameNumber];
		
		ChatFrameNumberFrame:SetClampRectInsets(50,-50,-50,50);
	end;
end;


local function ChangeMaxLines()
	for i = 1, NUM_CHAT_WINDOWS do
		local chatFrameNumber = ("ChatFrame%d"):format(i);
		local ChatFrameNumberFrame = _G[chatFrameNumber];
		
		if ChatFrameNumberFrame then
			ChatFrameNumberFrame:SetMaxLines(addonTable.MAXLINES);
		end;
	end;
end;


local function EnableClearCommand()
	SLASH_CLEARCHAT1, SLASH_CLEARCHAT2 = '/c', '/clear';
	
	function SlashCmdList.CLEARCHAT()
		for i = 1, NUM_CHAT_WINDOWS do
			local chatFrameNumber = ("ChatFrame%d"):format(i);
			local ChatFrameNumberFrame = _G[chatFrameNumber];
			ChatFrameNumberFrame:Clear();
		end;
	end
end;


local function EnableShortReloadCommand()
	SLASH_RL1 = '/rl';
	
	function SlashCmdList.RL()
		ReloadUI();
	end
end;


local function EnableFading(i)
	local chatFrameNumber = ("ChatFrame%d"):format(i);
	local ChatFrameNumberFrame = _G[chatFrameNumber];
	
	ChatFrameNumberFrame:SetFading(true);
	ChatFrameNumberFrame:SetTimeVisible(10);
	ChatFrameNumberFrame:SetFadeDuration(10);
end;


local function DetectUrls()
	local newAddMsg = {}
	local function AddMessage(frame, message, ...)
		
		if (message) then
			message = gsub(message, '([wWhH][wWtT][wWtT][%.pP]%S+[^%p%s])', '|cffffffff|Hurl:%1|h[%1]|h|r');
			message = gsub(message, " ([_A-Za-z0-9-%.]+@[_A-Za-z0-9-]+%.+[_A-Za-z0-9-%.]+)%s?", "|cffffffff|Hurl:%1|h[%1]|h|r");
			message = gsub(message, " (%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)%s?", "|cffffffff|Hurl:%1|h[%1]|h|r");
			message = gsub(message, " (%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?)%s?", "|cffffffff|Hurl:%1|h[%1]|h|r");
			return newAddMsg[frame:GetName()](frame, message, ...);
		end
	end

	for i = 1, NUM_CHAT_WINDOWS do
		
		if i ~= 2 then
			local frame = _G[format("%s%d", "ChatFrame", i)];
			newAddMsg[format("%s%d", "ChatFrame", i)] = frame.AddMessage;
			frame.AddMessage = AddMessage;
		end;
	end;
	
	local orig = ChatFrame_OnHyperlinkShow;
	function ChatFrame_OnHyperlinkShow(frame, link, text, button)
		local type, value = link:match("(%a+):(.+)");
		
		if ( type == "url" ) then
			local editBox = _G[frame:GetName()..'EditBox'];
			if editBox then
				editBox:Show();
				editBox:SetText(value);
				editBox:SetFocus();
				editBox:HighlightText();
			end;
		else
			orig(self, link, text, button);
		end;
	end;
end;


local function DisableHoldAlt(i)
	local chatFrameNumber = ("ChatFrame%d"):format(i);
	local chatFrameNumberEditBox = _G[chatFrameNumber.."EditBox"];
	
	chatFrameNumberEditBox:SetAltArrowKeyMode(false);
end;


local function MoveEditBoxTop(i)
	local chatFrameNumber = ("ChatFrame%d"):format(i);
	local ChatFrameNumberEditBox = _G[chatFrameNumber.."EditBox"];
	local ChatFrameNumberTab = _G[chatFrameNumber.."Tab"];

	ChatFrameNumberEditBox:ClearAllPoints();
	ChatFrameNumberEditBox:SetPoint("BOTTOMLEFT",  chatFrameNumber, "TOPLEFT",  -5, 0);
	ChatFrameNumberEditBox:SetPoint("BOTTOMRIGHT", chatFrameNumber, "TOPRIGHT", 5, 0);

	-- Makes clicking a tab close EditBox
	ChatFrameNumberTab:HookScript("OnClick", function() ChatFrameNumberEditBox:Hide() end);
	
	--force the editbox to hide itself when it loses focus
	ChatFrameNumberEditBox:HookScript("OnEditFocusLost", function(self) self:Hide() end);
end;


local function HideEditBoxBorder(i)
	local chatFrameNumber = ("ChatFrame%d"):format(i);
	local chatFrameNumberEditBox = chatFrameNumber.."EditBox";
	
	_G[chatFrameNumberEditBox.."Left"]:SetAlpha(0);
	_G[chatFrameNumberEditBox.."Mid"]:SetAlpha(0);
	_G[chatFrameNumberEditBox.."Right"]:SetAlpha(0);
end;


local function HideEditBoxFocusLine(i)
	local chatFrameNumber = ("ChatFrame%d"):format(i);
	local ChatFrameNumberEditBox = _G[chatFrameNumber.."EditBox"];
	
	ChatFrameNumberEditBox.focusLeft:SetAlpha(0);
	ChatFrameNumberEditBox.focusRight:SetAlpha(0);
	ChatFrameNumberEditBox.focusMid:SetAlpha(0);
end;


local function EnableClassColors()
	for i, v in pairs(CHAT_CONFIG_CHAT_LEFT) do
		ToggleChatColorNamesByClassGroup(true, v.type);
	end;

	-- For global channels not listed under CHAT_CONFIG_CHAT_LEFT
	for i = 1, 15 do
		ToggleChatColorNamesByClassGroup(true, "CHANNEL"..i);
	end;
end;


local function MakeChannelsSticky()
	for i, v in pairs(addonTable.StickyTypeChannels) do
		ChatTypeInfo[i].sticky = v;
	end;
end


local function MakeScrollingDynamic(i)
	local chatFrameNumber = ("ChatFrame%d"):format(i);
	local ChatFrameNumberFrame = _G[chatFrameNumber];
	
	ChatFrameNumberFrame:EnableMouseWheel(true);
	ChatFrameNumberFrame:SetScript('OnMouseWheel', ScrollChat);
end;


local function RevertGoldMessage()
	YOU_LOOT_MONEY_GUILD = YOU_LOOT_MONEY;
	LOOT_MONEY_SPLIT_GUILD = LOOT_MONEY_SPLIT;
end;


local function SetStrataAboveMainBar(i)
	local chatFrameNumber = ("ChatFrame%d"):format(i);
	local ChatFrameNumberFrame = _G[chatFrameNumber];
	ChatFrameNumberFrame:SetFrameStrata("HIGH");
end;


-- EVENTS


addonName:SetScript("OnEvent", function(self, event, ...) 

		
	if event == "ADDON_LOADED" then
		
		if addonTable.SCREEN_CLAMP_FIX then
			AdjustScreenClamp();
		end;

		if addonTable.MAXLINES then
			ChangeMaxLines();
		end;

		if addonTable.COMMAND_CLEAR then
			EnableClearCommand();
		end;

		if addonTable.COMMAND_RL then
			EnableShortReloadCommand();
		end;
	end;

	
	if event == "PLAYER_LOGIN" then
		
		if addonTable.URLCOPY then
			DetectUrls();
		end;
		
		if addonTable.STICKY_CHANNELS then
			MakeChannelsSticky();
		end;
						
		if addonTable.CLASS_COLORS then
			EnableClassColors();
		end;
		
		if addonTable.OLD_LOOT_MESSAGE then
			RevertGoldMessage();
		end;

		for i = 1, NUM_CHAT_WINDOWS do
			local chatFrameNumber = ("ChatFrame%d"):format(i);
			local ChatFrameNumberFrame = _G[chatFrameNumber];
			
			if ChatFrameNumberFrame then
			
				if addonTable.DYNAMIC_SCROLL then
					MakeScrollingDynamic(i);
				end;
				
				if addonTable.EDITBOX_ON_TOP then
					MoveEditBoxTop(i);
				end;
				
				if addonTable.EDITBOX_HIDE_BACKGROUND then
					HideEditBoxBorder(i);
				end;
				
				if addonTable.EDITBOX_HIDE_FOCUS_LINE then
					HideEditBoxFocusLine(i);
				end;

				if addonTable.NO_ALT then
					DisableHoldAlt(i);
				end;
				
				if addonTable.MESSAGE_FADING then
					EnableFading(i);
				end;
				
				if addonTable.STRATA_ABOVE_MAINBAR then
					SetStrataAboveMainBar(i);
				end;
				
			end;
		end;
	end;
end);
