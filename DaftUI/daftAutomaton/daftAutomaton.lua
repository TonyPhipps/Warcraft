local addonName, addonTable = ... ;
local addon = CreateFrame("Frame");

addon:RegisterEvent("PLAYER_ENTERING_WORLD");

local function RegisterEvents()
	
	if addonTable.INVITE then
		addon:RegisterEvent("CHAT_MSG_CHANNEL");
		addon:RegisterEvent("CHAT_MSG_GUILD");
		addon:RegisterEvent("CHAT_MSG_SAY");
		addon:RegisterEvent("CHAT_MSG_WHISPER");
		addon:RegisterEvent("CHAT_MSG_YELL");
		addon:RegisterEvent("GROUP_ROSTER_UPDATE");
	end;
	
	if addonTable.FOLLOW
	or addonTable.PROMOTE_LEADER
	or addon.PROMOTE_ASSISTANT then
		addon:RegisterEvent("CHAT_MSG_GUILD");
		addon:RegisterEvent("CHAT_MSG_PARTY");
		addon:RegisterEvent("CHAT_MSG_PARTY_LEADER");
		addon:RegisterEvent("CHAT_MSG_RAID");
		addon:RegisterEvent("CHAT_MSG_SAY");
		addon:RegisterEvent("CHAT_MSG_WHISPER");
	end;
	
	if addonTable.SELL_GREYS
	or addonTable.REPAIR then
		addon:RegisterEvent("MERCHANT_SHOW");
	end;

	if addonTable.ACCEPT_GROUP then
		addon:RegisterEvent("PARTY_INVITE_REQUEST");
	end;
	
	if addonTable.ACCEPT_SUMMON then
		addon:RegisterEvent("CONFIRM_SUMMON");
	end;
	
	if addonTable.RELEASE_PVP
	or addonTable.RELEASE_WORLD then
		addon:RegisterEvent("PLAYER_DEAD");
	end;
	
	if addonTable.ACCEPT_RESURRECT then
		addon:RegisterEvent("RESURRECT_REQUEST");
	end;
	
	if addonTable.TOGGLE_CINEMATIC_SOUND then
		addon:RegisterEvent("CINEMATIC_START");
		addon:RegisterEvent("CINEMATIC_STOP");
	end;
	
	if addonTable.SCREENSHOT_ACHIEVEMENTS then
		addon:RegisterEvent("ACHIEVEMENT_EARNED");
	end;
	
	if addonTable.ACCEPT_QUESTS then
		addon:RegisterEvent("QUEST_DETAIL");
	end;
	
	
	if addonTable.SHARE_QUESTS then
		addon:RegisterEvent("QUEST_ACCEPTED");
	end;
end;


---- HELPER FUNCTIONS ----
local function UnitIsInFriendList(name)
	ShowFriends();

	for i = 1, GetNumFriends() do
		local friend = GetFriendInfo(i);
		if (friend == name) then
			return true;
		end;
	end;

	for i = 1, BNGetNumFriends() do
		local _, _, _, _, friend, _, client = BNGetFriendInfo(i);
		if (friend == name) and (client == 'WoW') then
			return true;
		end;
	end;

	return false;
end;


---- SLASH COMMANDS ----
function SlashCmdList.AUTOINVITE(trigger)
	
	if trigger == "on" or trigger == "enable" then
		addonTable.INVITE = true;
	
	elseif trigger == "off" or trigger == "disable" then
		addonTable.INVITE = false;
	
	elseif trigger ~= "" then
		addonTable.INVITE_TRIGGER = trigger;
		addonTable.INVITE = true;
	
	elseif addonTable.INVITE then
		addonTable.INVITE = false;
	
	elseif not addonTable.INVITE then
		addonTable.INVITE = true;
	end;
	
	if addonTable.INVITE then
		print("Autoinvite is enabled; trigger is: " .. addonTable.INVITE_TRIGGER);
	else
		print("Autoinvite disabled.");
	end;
end;

SLASH_AUTOINVITE1, SLASH_AUTOINVITE2  = "/autoinv", "/autoinvite";


---- EVENTS ----
addon:SetScript("OnEvent", function(self, event, ...) 

	if event == "PLAYER_ENTERING_WORLD" then
		RegisterEvents();
		
		soundSettings = {
		["Sound_AmbienceVolume"] = 0,
		["Sound_DialogVolume"] = 0,
		["Sound_EnableAllSound"] = 0,
		["Sound_EnableAmbience"] = 0,
		["Sound_EnableDialog"] = 0,
		["Sound_EnableEmoteSounds"] = 0,
		["Sound_EnableMusic"] = 0,
		["Sound_EnableSFX"] = 0,
		["Sound_EnableReverb"] = 0,
		["Sound_MasterVolume"] = 0,
		["Sound_MusicVolume"] = 0,
		["Sound_SFXVolume"] = 0};
		
		for i in pairs (soundSettings) do
			soundSettings[i] = GetCVar(i);
		end;
	end;

	
	if addonTable.SELL_GREYS then
		
		if event == "MERCHANT_SHOW" then
			for bag = 0, 4 do
				for slot = 1, GetContainerNumSlots(bag) do
					local _, _, locked, _, _, _, link = GetContainerItemInfo(bag, slot);
					
					if link ~= nil then
						local _, _, quality = GetItemInfo(link);
						
						if quality == 0 and not locked then
							UseContainerItem(bag, slot);
						end;
					end;
				end;
			end;
		end;
	end;
			
			
	if addonTable.REPAIR then
		
		if event == "MERCHANT_SHOW" then
			
			if (CanMerchantRepair()) then	
				repairAllCost, canRepair = GetRepairAllCost();
				
				if (canRepair and repairAllCost > 0) then
					guildRepairedItems = false;
					
					if (addonTable.REPAIR_GUILD and IsInGuild() and CanGuildBankRepair()) then -- Use Guild Bank
						local amount = GetGuildBankWithdrawMoney();
						local guildBankMoney = GetGuildBankMoney();
						amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney);

						if (amount >= repairAllCost) then -- Checks if guild has enough money
							RepairAllItems(true);
							guildRepairedItems = true;
						end;
					end;
					
					if (repairAllCost <= GetMoney() and not guildRepairedItems) then -- Use own funds
						RepairAllItems(false);
					end;
				end;
			end;		
		end;
	end;
	
	
	if addonTable.INVITE then
		
		if event == "CHAT_MSG_CHANNEL"
		or event == "CHAT_MSG_GUILD"
		or event == "CHAT_MSG_SAY"
		or event == "CHAT_MSG_WHISPER"
		or event == "CHAT_MSG_YELL" then
			local message, sender = ...;
			
			if addonTable.INVITE_AUTORAID then
				if(UnitIsGroupLeader("player")) and (GetNumGroupMembers() == 5) then
					ConvertToRaid();
				end;
			end;
			
			if GetNumGroupMembers() < 5 or IsInRaid() then
				
				if addonTable.INVITE_VERBOSE then
					
					if message:lower():find(addonTable.INVITE_TRIGGER) then -- verbose
							InviteUnit(sender);
							print("Auto-inviting " .. sender);
					end;

				else
				
					if message == addonTable.INVITE_TRIGGER then -- verbatim
							InviteUnit(sender);
							print("Auto-inviting " .. sender);
					end;
				end;
			end;
		end;
		
		if event == "GROUP_ROSTER_UPDATE" then
		
			if addonTable.INVITE and GetNumGroupMembers() == 0 then
				addonTable.INVITE = false;
				print("Autoinvite disabled.");
			end;
		end;
	end;
	
	
	if addonTable.ACCEPT_GROUP then
		
		if event == "PARTY_INVITE_REQUEST" then
			local sender = ...;
			
			if UnitIsInMyGuild(sender) or UnitIsInFriendList(sender) then
				AcceptGroup();
				
				for i = 1, STATICPOPUP_NUMDIALOGS do
					local dialog = _G['StaticPopup' .. i];
					
					if (dialog.which == 'PARTY_INVITE') then
						dialog.inviteAccepted = 1;
						StaticPopup_Hide('PARTY_INVITE');
						break;
						
					elseif (dialog.which == 'PARTY_INVITE_XREALM') then
						dialog.inviteAccepted = 1;
						StaticPopup_Hide('PARTY_INVITE_XREALM');
						break;
					end;
				end;
			end;
		end;
	end;
	
	
	if addonTable.ACCEPT_SUMMON then
		
		if event == "CONFIRM_SUMMON" then
			
			if (not UnitAffectingCombat("player")) then
				ConfirmSummon();
				StaticPopup_Hide("CONFIRM_SUMMON");
			end;
		end;
	end;
	
	
	if addonTable.RELEASE_PVP then
		
		if event == 'PLAYER_DEAD' then
		local isInstance, instanceType = IsInInstance();
		
			if HasSoulstone() then
				return;
			end;

			if isInstance and (instanceType == 'pvp') then
				RepopMe();
			end;
		end;
	end;
	
	
	if addonTable.RELEASE_WORLD then
		
		if event == 'PLAYER_DEAD' then
		local isInstance, instanceType = IsInInstance();
		
			if HasSoulstone() then
				return;
			end;

			if (not isInstance) or (instanceType == 'none') then
				RepopMe();
			end;
		end;
	end;
	
	
	if addonTable.ACCEPT_RESURRECT then
		
		if event == 'RESURRECT_REQUEST' then
			
			if (GetCorpseRecoveryDelay() > 0) then
				return;
			end

			if (not UnitAffectingCombat("player")) then
				AcceptResurrect();
				StaticPopup_Hide('RESURRECT_NO_TIMER');
			end;
		end;
	end;
	
	
	if addonTable.FOLLOW then
		
		if event == "CHAT_MSG_GUILD" 
		or event == "CHAT_MSG_PARTY" 
		or event == "CHAT_MSG_PARTY_LEADER" 
		or event == "CHAT_MSG_RAID" 
		or event == "CHAT_MSG_SAY" 
		or event == "CHAT_MSG_WHISPER" then
			local message, sender = ...;
			local senderName = Ambiguate(sender, "short");
			local inRange = CheckInteractDistance(senderName, 4);
			
			if UnitIsInMyGuild(senderName) or UnitIsInFriendList(senderName) then

				if message == "!follow" then
				
					if inRange then
						FollowUnit(senderName);
						
						if not IsMounted() then
							C_MountJournal.SummonByID(0);
						end;
						SendChatMessage("Following you.", "WHISPER", nil, sender);
					
					else
						SendChatMessage("Too far to follow.", "WHISPER", nil, sender);
					end;
				end;
			end;
		end;
	end;
	
	
	if addonTable.TOGGLE_CINEMATIC_SOUND then
			
		if event == "CINEMATIC_START" then
		
			for i, v in pairs (soundSettings) do
				SetCVar(i, 1);
			end;
		
		elseif event == "CINEMATIC_STOP" then
			
			for i, v in pairs (soundSettings) do
				SetCVar(i, v);
			end;
		end;
	end;
	
	
	if addonTable.SCREENSHOT_ACHIEVEMENTS then
		
		if event == "ACHIEVEMENT_EARNED" then
			C_Timer.After(1, Screenshot);
		end;
	end;
	
	
	if addonTable.SHARE_QUESTS then
	
		if event == "QUEST_ACCEPTED" then
			local questIndex = ...;
			QuestLogPushQuest(questIndex);
		end;
	end;
	
	
	if addonTable.ACCEPT_QUESTS then
	
		if IsInGroup() then
		
			if event == "QUEST_DETAIL" then
				AcceptQuest();
			end;
		end;
	end;
	
	
	if addonTable.PROMOTE_LEADER or addonTable.PROMOTE_ASSISTANT then
	
		if event == "CHAT_MSG_GUILD"
		or event == "CHAT_MSG_PARTY" 
		or event == "CHAT_MSG_RAID"
		or event == "CHAT_MSG_SAY" 
		or event == "CHAT_MSG_WHISPER" then
			local message, sender = ...;
			local senderName = Ambiguate(sender, "short");
			
			if UnitIsInMyGuild(senderName) or UnitIsInFriendList(senderName) then
			
				if message == "!leader" and addonTable.PROMOTE_LEADER then
					PromoteToLeader(senderName);
				end;
				
				if message == "!assistant" and addonTable.PROMOTE_ASSISTANT then
					PromoteToAssistant(senderName);
				end;
			end;
		end;
	end;
	
end);