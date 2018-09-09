local addonName, addonTable = ...


-- Quality of Life Improvements
addonTable.REPAIR = true
addonTable.REPAIR_GUILD = true
addonTable.SELL_GREYS = true


-- Friend play / multiboxing
addonTable.ACCEPT_GROUP = true			-- Accept group invites (only from friends / guildies)
addonTable.ACCEPT_QUESTS = true			-- Accept shared quests
addonTable.ACCEPT_SUMMON = false		-- Accept summons (only when not in combat)
addonTable.FOLLOW = true				-- Allow friends/guildies to use !follow to make you follow them
addonTable.INVITE = false				-- Enable auto-inviting others to group who say trigger phrase
addonTable.INVITE_TRIGGER = "invite"	-- Specify a trigger word to initiate auto invite
addonTable.INVITE_VERBOSE = true		-- Trigger can exist anywhere in message When false, the message must be the trigger only
addonTable.INVITE_AUTORAID = false		-- Convert to raid when group is large
addonTable.PROMOTE_ASSISTANT = true		-- Allow command !assistant to promote requester to Raid Assistant (only from friends / guildies)
addonTable.PROMOTE_LEADER = false		-- Allow command !leader to promote requester to group Leader (only from friends / guildies)
addonTable.SHARE_QUESTS = true			-- Automatically share new quests


-- PVP
addonTable.ACCEPT_RESURRECT = true		-- Accept all resurrections (when not in combat)
addonTable.RELEASE_PVP = true			-- Release spirit instantly (when in PvP instances)
addonTable.RELEASE_WORLD = true			-- Release spirit instantly (when in world zones)


-- Auction
addonTable.UNDERCUT = .97 -- .97 is a 3% undercut

addonTable.POOR_MULTIPLIER = 20 -- Multipliers used when no matching auctions are found
addonTable.COMMON_MULTIPLIER = 30
addonTable.UNCOMMMON_MULTIPLIER = 40
addonTable.RARE_MULTIPLIER = 50
addonTable.EPIC_MULTIPLIER = 60


-- Miscellaneous
addonTable.SCREENSHOT_ACHIEVEMENTS = true -- Take a screenshot every time an achievement is earned
addonTable.TOGGLE_CINEMATIC_SOUND = false -- Enable sound for cinematics reverts settings afterward
addonTable.FASTLOOT = true -- Makes auto looting even faster!
addonTable.COMBAT_NAMEPLATES = true