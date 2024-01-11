# wow.exe launches, but no screen is ever shown.
Disable all overlay service (there are many these days. Windows Game Bar, graphics card software, gaming software, addon managers, discord, etc.)

# Addons

My Addons
- https://www.wowinterface.com/downloads/author-25227.html
- https://www.curseforge.com/members/tonyoynot/projects


References
- https://wowpedia.fandom.com/wiki/Events
- https://wowpedia.fandom.com/wiki/World_of_Warcraft_API

Resources
- http://us.media.blizzard.com/wow/interface/WoW_Interface_enUS.zip

## Addon Authoring Tips and Tricks
Print something to chat
```
print("Printed this to chat.")
```

Show frame under mouse
```
/script ChatFrame1:AddMessage("frame name: " .. GetMouseFocus():GetName())
```

Framestack Tool
- While hovering over a frame, press and release CTRL to get a popup with details/options.
```
/framestack
```

Event Trace Tool
```
/etrace
```

Enable Blizzards Eror System
```
/console scriptErrors 1
```

Print Name of Frame Under Mouse
```
/run print( GetMouseFocus():GetName() );
```

Print Children Names of Frame Under Mouse
```
/run function kiddos () local kiddos = { GetMouseFocus():GetChildren() }; for _, child in ipairs(kiddos) do print(child:GetName()); end end kiddos();
```
