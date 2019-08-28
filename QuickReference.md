Wow UI Source

https://github.com/tomrus88/BlizzardInterfaceCode

Print Name of Frame Under Mouse
```
/run print( GetMouseFocus():GetName() );
```

Print Children Names of Frame Under Mouse
```
/run function kiddos () local kiddos = { GetMouseFocus():GetChildren() }; for _, child in ipairs(kiddos) do print(child:GetName()); end end kiddos();
```


