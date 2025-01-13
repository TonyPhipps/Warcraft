Automatically performs many functions, which can be enabled/disabled via the Options.lua file (NOT the in-game Options):

-- Quality of Life Improvements
addonTable.REPAIR = true
addonTable.REPAIR_GUILD = true
addonTable.SELL_GREYS = true

-- Auto Questing
addonTable.ACCEPT_GROUP = true			-- Accept group invites (only from friends / guildies)
addonTable.ACCEPT_QUESTS = false	    -- Accept shared quests
addonTable.ACCEPT_SUMMON = false		-- Accept summons (only when not in combat)
addonTable.SHARE_QUESTS = true			-- Automatically share new quests

-- Auto Grouping
addonTable.INVITE = false				-- Enable auto-inviting others to group who say trigger phrase
addonTable.INVITE_TRIGGER = "invite"	-- Specify a trigger word to initiate auto invite
addonTable.INVITE_VERBOSE = true		-- Trigger can exist anywhere in message When false, the message must be the trigger only
addonTable.INVITE_AUTORAID = false		-- Convert to raid when group is large
addonTable.PROMOTE_ASSISTANT = true		-- Allow command !assistant to promote requester to Raid Assistant (only from friends / guildies)
addonTable.PROMOTE_LEADER = false		-- Allow command !leader to promote requester to group Leader (only from friends / guildies)

-- Auto Release Spirit
addonTable.ACCEPT_RESURRECT = true		-- Accept all resurrections (when not in combat)
addonTable.RELEASE_PVP = true			-- Release spirit instantly (when in PvP instances)
addonTable.RELEASE_WORLD = true			-- Release spirit instantly (when in world zones)

-- Auto Mounting
addonTable.MOUNT_WHEN_TOLD = true          -- Mount up when told "mount"
addonTable.MOUNT_COMBAT = false   		   -- Mount up when exiting combat
addonTable.MOUNT_ROGUE = false             -- Auto mount sub-check for rogue
addonTable.MOUNT_DRUID = false             -- Auto mount sub-check for doodad
addonTable.MOUNT_LOOT = true   		       -- Mount up when closing loot window
addonTable.MOUNT_QUEST = true   		   -- Mount up when done interacting with a quest object/character

-- Miscellaneous
addonTable.SCREENSHOT_ACHIEVEMENTS = true -- Take a screenshot every time an achievement is earned
addonTable.TOGGLE_CINEMATIC_SOUND = false -- Enable sound for cinematics reverts settings afterward
addonTable.FASTLOOT = true                -- Makes auto looting super fast


- One slash command to mention:
```
/autoinv or autoinvite
```

  - This will allow you to toggle auto invite and set the trigger, if one is provided.
  - e.g. /autoinv will toggle auto invite and display the trigger to you.
  - e.g. /autoinv !invite will enable and set trigger to "!invite"