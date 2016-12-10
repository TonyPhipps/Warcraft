local addonName, addonTable = ... ;


-- Quality of Life Improvements
addonTable.REPAIR = true;
addonTable.REPAIR_GUILD = true;
addonTable.SELL_GREYS = true;


-- Friend play / multiboxing
addonTable.ACCEPT_GROUP = true; -- Accept group invites (only from friends / guildies)
addonTable.ACCEPT_QUESTS = false; -- Accept shared quests (only when in a group)
addonTable.ACCEPT_SUMMON = false; -- Accept summons (only when not in combat)
addonTable.FOLLOW = true; -- Allow command !follow to follow requester (from friends / guildies)
addonTable.INVITE = false; -- Enable auto-inviting others to group who say trigger phrase
addonTable.INVITE_AUTORAID = false; -- Convert to raid when group is large (only when INVITE is enabled)
addonTable.INVITE_TRIGGER = "invite"; -- Specify auto invite trigger when INVITE is enabled
addonTable.INVITE_VERBOSE = true; -- trigger can exist anywhere in message
addonTable.PROMOTE_ASSISTANT = true; -- Allow command !assistant to promote requester to Raid Assistant (only from friends / guildies)
addonTable.PROMOTE_LEADER = true; -- Allow command !leader to promote requester to group Leader (only from friends / guildies)
addonTable.SHARE_QUESTS = true; -- Share accepted quests with group members


-- PVP
addonTable.ACCEPT_RESURRECT = true; -- Accept all resurrections (when not in combat)
addonTable.RELEASE_PVP = true; -- Release spirit instantly (when in PvP instances)
addonTable.RELEASE_WORLD = true; -- Release spirit instantly (when in world zones)


-- Miscellaneous
addonTable.SCREENSHOT_ACHIEVEMENTS = true; -- Take screenshot of all achievements
addonTable.TOGGLE_CINEMATIC_SOUND = true; -- Enable sound for cinematics; reverts settings afterward



--TODO:


