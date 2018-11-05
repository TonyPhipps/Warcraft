# Scale, Move, Hide Frames

```
/run FRAMENAME:SetScale(1)
/run FRAMENAME:Hide() or FRAMENAME:SetAlpha(0)
```

Scale Multiple Frames Simultanously:

```
/run fa={"PlayerFrame","TargetFrame"}
/run for _, f in pairs(fa) do _G[f]:SetScale(1.3) end
```

## Common Frames

* ArenaEnemyFrame1
* ArenaEnemyFrame2
* ArenaEnemyFrame3
* ArenaEnemyFrame4
* ArenaEnemyFrame5
* CastingBarFrame
* TargetFrameSpellBar


# Common Textures to Hide

```
/run FRAMENAME:Hide(1)
/run FRAMENAME.TEXTURENAME:Hide(1)
/run FRAMENAME:SetAlpha(0)
```

* MicroButtonAndBagsBar
* MicroButtonAndBagsBar.MicroBagBar
* MainMenuBarArtFrame.LeftEndCap
* MainMenuBarArtFrame.RightEndCap

 
# Unlock Most UI Frames
```
/run local f=FRAMENAME; f:SetMovable(true); f:EnableMouse(true); f:SetUserPlaced(true); f:SetScript("OnMouseDown", f.StartMoving); f:SetScript("OnMouseUp", f.StopMovingOrSizing);
```

