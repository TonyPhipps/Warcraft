local addonName, addonTable = ... ;

addonTable.NOCOMBAT_TIMETOFADEIN = 1.0;
addonTable.NOCOMBAT_FADEIN = 0.8;
addonTable.NOCOMBAT_TIMETOFADEOUT = 1.0;
addonTable.NOCOMBAT_FADEOUT = 0.1;

addonTable.COMBAT_TIMETOFADEIN = 0.5;
addonTable.COMBAT_FADEIN = 1.0;
addonTable.COMBAT_TIMETOFADEOUT = 0.5;
addonTable.COMBAT_FADEOUT = 0.8;

-- true for enable, false for disable.
addonTable.BUFFS = true; -- will show when targeting self or when hovering over PlayerFrame
addonTable.CHATTABS = true;
addonTable.MAINMENUBAR = true;
addonTable.MINIMAP = true;
addonTable.OBJECTIVETRACKER = true;
addonTable.OBJECTIVETRACKER_PULSE = true; -- Briefly show the Object Tracker when updating achieve/quest progress
addonTable.PARTY = true;
addonTable.PLAYER = true;
addonTable.RAIDMANAGER = true;
addonTable.TARGET = true;
addonTable.VEHICLESEATINDICATOR = true;
addonTable.WORLDSTATEFRAME = true;  -- pvp and zone-wide progress frame