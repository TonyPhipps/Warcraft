Fades out entire UI when not in use.

Features:
[LIST]
[*]Since this fades UIParent, it will affect all addons.
[*]Fades in UI when in combat or when casting outside combat.
[*]Fades in UI when targeting anything or mousing over anything.
[*]Fades in UI when world map, mailbox, or gossip frames are shown.
[/LIST]

Settings can be edited completely in the [B]Options.lua[/B] file, as previewed below.

[CODE]
addonTable.TIMETOFADEIN = 1.0;
addonTable.FADEIN = 0.95;

addonTable.TIMETOFADEOUT = 3.0;
addonTable.FADEOUT = 0.05;
[/CODE]

[SIZE="1"]+Lightweight on code to stand the test of time (and patches).[/SIZE]