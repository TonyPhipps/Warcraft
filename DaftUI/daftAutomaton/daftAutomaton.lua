local addonName, addonTable = ... ;
local addonName = CreateFrame("Frame");

addonName:RegisterEvent("PLAYER_ENTERING_WORLD")

local function RegisterEvents()
	if addonTable.SELLGREYS then
		addonName:RegisterEvent("MERCHANT_SHOW");
	end;

	addonName:RegisterEvent("CHAT_MSG_WHISPER");
	addonName:RegisterEvent("CHAT_MSG_CHANNEL");
	addonName:RegisterEvent("CHAT_MSG_SAY");
	addonName:RegisterEvent("CHAT_MSG_GUILD");
	addonName:RegisterEvent("PARTY_INVITE_REQUEST");
	addonName:RegisterEvent("CONFIRM_SUMMON");
	addonName:RegisterEvent("PLAYER_DEAD");
	
end;


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

addonName:SetScript("OnEvent", function(self, event, ...) 

	if (event == "PLAYER_ENTERING_WORLD") then
		RegisterEvents();
	end;

	if addonTable.SELLGREYS then
		if event == "MERCHANT_SHOW" and addonTable.SELLGREYS then
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
	
	if addonTable.INVITE then
		if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_SAY" or event == "CHAT_MSG_GUILD" then
			local message, sender = ...;
			
			if addonTable.INVITE_AUTORAID then
				if(UnitIsGroupLeader("player")) and (GetNumGroupMembers() == 5) then
					ConvertToRaid();
				end;
			end;
			
			if message:lower():find(addonTable.INVITE_TRIGGER) then
				if GetNumGroupMembers() < 5 or IsInRaid() then
					InviteUnit(sender);
					print("Inviting " .. sender);
				end;
			end;
		end;
	end;
	
	if addonTable.ACCEPTGROUP then
		if (event == "PARTY_INVITE_REQUEST") then
			local sender = ...;
			if UnitIsInMyGuild(sender) or UnitIsInFriendList(sender) then
			
				for i = 1, STATICPOPUP_NUMDIALOGS do
					local dialog = _G["StaticPopup" .. i];
					
					if (dialog.which == "PARTY_INVITE") then
						dialog.inviteAccepted = 1;
						StaticPopup_Hide("PARTY_INVITE");
						break;
					elseif (dialog.which == "PARTY_INVITE_XREALM") then
						dialog.inviteAccepted = 1;
						StaticPopup_Hide("PARTY_INVITE_XREALM");
						break;
					end;
				end;
			end;
		end;
	end;
	
	if addonTable.ACCEPTSUMMON then
		if (event == "CONFIRM_SUMMON") then
			if (not UnitAffectingCombat("player")) then
				ConfirmSummon();
				StaticPopup_Hide("CONFIRM_SUMMON");
			end;
		end;
	end;
	
	if addonTable.RELEASE_PVP then
		if (event == 'PLAYER_DEAD') then
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
		if (event == 'PLAYER_DEAD') then
		local isInstance, instanceType = IsInInstance();
		
			if HasSoulstone() then
				return;
			end;

			if (not isInstance) or (instanceType == 'none') then
				RepopMe();
			end;
		end;
	end;
end);