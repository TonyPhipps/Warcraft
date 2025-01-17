### Conditionals
https://wowpedia.fandom.com/wiki/Macro_conditionals

Mouse/Key
```
[btn:1]
[btn:2]
[flyable]
[noflyable]
[mounted]
[nomounted]
[mod:alt]
[mod:ctrl]
[mod:shift]
[nomod]
```

Player
```
[channeling]
[group:party]
[group:raid]
```

Target
```
[dead]
[exists]
[harm]
[party]
[raid]
[unithasvehicleui]
```

Other
```
[@focus]
```



# Sample Macros
**Mount**
```
/mountspecial [mounted]
/stopmacro [mounted]
/click [nogroup] MountJournalSummonRandomFavoriteButton
/cast [mod:ctrl] Grand Expedition Yak
/cast [mod:shift] The Hivemind
/cast [group] Obsidian Nightwing
```

**Cast Spells on Focus / Set Focus**
- Target desired focus, the click. Or Control+Click to change focus to current target.
```
#showtooltip
/clearfocus [modifier:ctrl][target=focus,dead][target=focus,help][target=focus,noexists]
/focus [target=focus,noexists]
/cast [target=focus] Kick
```

**Cast a Spell, but cancel its buff if you already have it**
```
#showtooltip
/cancelaura Divine Shield
/cast Divine Shield
```

**Heal Mouseover > Target > Enemy's Target (Alt Self)**
- Alt: Self Cast
- Mouseover Friend: Cast on Mouseover
- Target Friend: Cast on Target
- Target Enemy Targeting Friend: Cast on Enemy's Target
- Default casting behavior. This condition also serves to generate the correct tooltip.
```
#showtooltip
/cast [mod:alt,@player] [@mouseover,help,nodead] [help] [@targettarget,help,nodead] [] SPELL
```

**Damage Mouseover > Target > Friendly's Target > Focus' Target**
- This macro is for dps without switching to enemy targets (good for some healers and all DPS). Allows you to dps while having fiendly players targeted or moused over.
  - Mouseover Enemy: Cast on Mouseover
  - Target Enemy: Cast on Target
  - Mouseover Friend Targeting Enemy: Cast on Friend's Target
  - Target Friend Targeting Enemy: Cast on Friend's Target
  - Focus Targeting Enemy: Cast on Focus' Target
  - Default casting behavior. This condition also serves to generate the correct tooltip.
```
#showtooltip
/cast [@mouseover,harm,nodead] [harm] [@mouseovertarget,harm,nodead] [@targettarget,harm,nodead] [@focustarget,harm,nodead] [] SPELL
```



Resources
- https://us.forums.blizzard.com/en/wow/t/useful-macro-templates/42937