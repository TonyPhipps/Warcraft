local addonName, addonTable = ... ;

-- FadeIn, TimetoFadeIn, FadeOut, TimetoFadeOut
------------------------{ TTF, IN, TTF, OUT }
addonTable.NOCOMBAT_FADE = 	{ 1.0, 0.8, 1.0, 0.1 };
addonTable.COMBAT_FADE = 	{ 0.5, 1.0, 0.5, 0.8 };

-- true for enable, false for disable.
addonTable.MINIMAP = true;
addonTable.PLAYER = true;
addonTable.TARGET = true;
addonTable.MAINMENUBAR = true;
addonTable.PARTY = true;
addonTable.OBJECTIVETRACKER = true;
addonTable.RAIDMANAGER = true;
addonTable.BUFFS = true;