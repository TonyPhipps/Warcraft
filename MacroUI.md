# Scale, Move, Hide Frames

```
/run FRAMENAME:SetScale(1)
/run FRAMENAME:Hide()
/run FRAMENAME:SetAlpha(0)
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
* Boss1TargetFrame
* Boss2TargetFrame
* Boss3TargetFrame
* Boss4TargetFrame
* Boss5TargetFrame
* CastingBarFrame
* DressUpFrame
* TargetFrameSpellBar
* ChatFrame1EditBox
* WorldMapFrame
* MailFrame
* GossipFrame
* GameMenuFrame
* StaticPopup1
* MirrorTimer1
* LFGDungeonReadyPopup
* LFDRoleCheckPopup
* LevelUpDisplay
* RolePollPopup
* ReadyCheckFrame
* BonusRollFrame
* QuestFrame
* PlayerFrame
* TargetFrame
* ItemTextFrame
* TalkingHeadFrame
* InterfaceOptionsFrame
* GameTooltip
* RaidWarningFrame
* SpellBookFrame
* Minimap
* MinimapBorderTop
* MinimapZoneText
* MiniMapWorldMapButton

Some might be textures or sub-frames you want to hide...

```
/run FRAMENAME.TEXTURENAME:Hide()
```

* MicroButtonAndBagsBar
* MicroButtonAndBagsBar.MicroBagBar
* MainMenuBarArtFrame.LeftEndCap
* MainMenuBarArtFrame.RightEndCap
 
# Unlock Most UI Frames

```
/run local f=FRAMENAME; f:SetMovable(true); f:EnableMouse(true); f:SetUserPlaced(true); f:SetScript("OnMouseDown", f.StartMoving); f:SetScript("OnMouseUp", f.StopMovingOrSizing);
```

# Colorize Action Buttons

```
/run function c(s) local r=IsActionInRange(s.action); local u,m=IsUsableAction(s.action); if r==false  hen s.icon:SetVertexColor(1,.1,.1) elseif m then s.icon:SetVertexColor(.1,.1,1) else  .icon:SetVertexColor(1,1,1)end; end

/run hooksecurefunc("ActionButton_OnUpdate", c)
```