local addonName, addonTable = ... ;

addonTable.CLASS_COLORS = true;
addonTable.COMMAND_CLEAR = true;  -- type /c or /clear to clear all chat text
addonTable.COMMAND_RL = true;  -- type /rl to perform a /reload ui
addonTable.DYNAMIC_SCROLL = true;  -- Hold CONTROL to scroll fast, ALT to scroll to top/bottom
addonTable.EDITBOX_HIDE_BACKGROUND = false;
addonTable.EDITBOX_HIDE_FOCUS_LINE = false;
addonTable.EDITBOX_ON_TOP = true;
addonTable.MAXLINES = 500;
addonTable.MESSAGE_FADING = true;  -- Fades text per line based on age. Text will show for a total of 20sec
addonTable.NO_ALT = true;  -- Disables the requirement to hold ALT to move around in edit box.
addonTable.OLD_LOOT_MESSAGE = true;  -- Disables notifying you of guild gold deposits every time you pick up gold.
addonTable.SCREEN_CLAMP_FIX = true;  -- Allow chat frame to go slightly off screen. Helpful to manually hide the side buttons.
addonTable.STICKY_CHANNELS = true;
	addonTable.StickyTypeChannels = {
	  SAY = 1,
	  YELL = 0,
	  EMOTE = 0,
	  PARTY = 1, 
	  RAID = 1,
	  GUILD = 1,
	  OFFICER = 1,
	  WHISPER = 1,
	  CHANNEL = 1,
	};
addonTable.STRATA_ABOVE_MAINBAR = true; -- Sets the text to be ABOVE the mainbar, mostly for that pesky left gryphon.
addonTable.URLCOPY = true;