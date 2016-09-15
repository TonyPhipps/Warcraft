Fades default frames based on mouseover and combat status.

Features:
[LIST]
[*]Both "in" and "out" fade levels can be modified, as well as the speed of the fade.
[*]A different set of options for in combat versus out of combat.
[*]If Player has less than 100% mana or health, player frame fades in.
[*]If a target exists, fades in Player and Target frames.
[*]When out of combat, target self to show buffs.
[*]Briefly fade in Objective Tracker when it receives updates
[/LIST]

Settings can be edited completely in the [B]Options.lua[/B] file, as previewed below.

[CODE]
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
[/CODE]

[SIZE="1"]+Lightweight on code to stand the test of time (and patches).[/SIZE]