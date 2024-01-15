Fades default frames based on combat status, target, casting, etc.

Features:
- Hides or shows the whole UI
  - Set speed of fading in, fading out (and in combat vs not)
  - Set degree to which fading will occur (for example, you many want to see the UI just a bit)
  - Set whether unit names should disappear/reappear with UI fading.

- The UI will fade IN when...
  - Player is in combat
  - Player has less than 100% mana or health
  - A target exists
  - (togglable) Player is casting
  - (togglable) Tooltip appears
  - (togglable) Mouse is on top edge of screen, fades in UI.
  - (togglable) Player uses chat edit box.

- Otherwise, the UI will fade out

Settings can be edited completely in the [B]Options.lua[/B] file, as previewed below.

[CODE]
local addonName, addonTable = ... ;

addonTable.NOCOMBAT_TIMETOFADEIN = 1.0;
addonTable.NOCOMBAT_FADEIN = 0.8;
addonTable.NOCOMBAT_TIMETOFADEOUT = 1.0;
addonTable.NOCOMBAT_FADEOUT = 0.1;

addonTable.COMBAT_TIMETOFADEIN = 0.5;
addonTable.COMBAT_FADEIN = 1.0;
addonTable.COMBAT_TIMETOFADEOUT = 0.5;
addonTable.COMBAT_FADEOUT = 0.8;

addonTable.TOP_EDGE_HOVER = 1;
[/CODE]

[SIZE="1"]+Lightweight on code to stand the test of time (and patches).[/SIZE]