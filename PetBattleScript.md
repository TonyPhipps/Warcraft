# Squirt
- Fjord Worg Pup (2,2,2), Ghostly Skull (1,1,1) and Any Leveling pet
```
quit [self(#3).dead]

if [enemy(#1).active]
    change(#2) [self(#1).dead]
    ability(Howl) [self.hp>1000]
    ability(Howl) [self.hp<325]
    ability(Dazzling Dance) [!self.aura(Dazzling Dance).exists]
    ability(Siphon Life) [self.hp<600]
    ability(Flurry)
    ability(Shadow Slash)
endif

if [enemy(#2).active]
    change(#2) [self(#1).dead]
    standby [self.aura(Stunned).exists]
    ability(Howl)
    ability(Dazzling Dance)
    ability(Flurry)
    ability(Siphon Life) [self.hp<600 & !enemy.aura(Siphon Life).exists]
    ability(Ghostly Bite)
    ability(Shadow Slash)
endif

if [enemy(#3).active]
    change(#3) [!self(#3).played]
    change(#2) [self(#3).active]
    standby [self.aura(Stunned).exists]
    use(Ghostly Bite:654)
    use(Shadow Slash:210)
endif
```




