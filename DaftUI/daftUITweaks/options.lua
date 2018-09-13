local addonName, addonTable = ... 


-- Full UI Fading
addonTable.ENABLE_UIFADE = true
    addonTable.TIMETOFADEIN = 0.1
    addonTable.TIMETOFADEOUT = 5.0 -- apparently 5.0 is the longest supported
    addonTable.FADEIN = 1.0
    addonTable.FADEOUT = 0.0


-- Mainbar
addonTable.ENABLE_MAINBAR = true
    addonTable.MAINBAR_ALPHA = 0.9
    addonTable.EXPBAR_ALPHA = 0.9
    addonTable.LEFTBAR_ALPHA = 0.6
    addonTable.RIGHTBAR_ALPHA = 0.6
    addonTable.BAGBAR_ALPHA = 1.0
    addonTable.MENUBAR_ALPHA = 1.0

    addonTable.EXPBAR_SCALE = 1.0 -- 0.8 allows right click mouselook under bar!
    addonTable.MENUBAR_SCALE = 1.0
    addonTable.BAGBAR_SCALE = 1.0

    addonTable.CENTER_RIGHT_BARS = true

    addonTable.SKIN_BUTTONERRORS = true
    addonTable.SKIN_FONTS = true

    addonTable.HIDE_HOTKEYS = false
    addonTable.HIDE_MACRONAMES = true
    addonTable.HIDE_ACTIONBAR_BG = false
    addonTable.HIDE_GRYPHONS = false
    addonTable.HIDE_BAGS = true
    addonTable.HIDE_MENU = true
    addonTable.HIDE_MENU_BG = true


-- UI Colors (class colors by default)
addonTable.ENABLE_UICOLORS = true
    addonTable.CUSTOM = false
    addonTable.R = 0
    addonTable.G = 0
    addonTable.B = 0
    addonTable.A = 1
    
-- Change frame fonts to white Arial
addonTable.ENABLE_FONTS = true

-- Cast Bars
addonTable.ENABLE_CASTBARS = true
    addonTable.PLAYER_ENABLED = true
        addonTable.PLAYER_BIG_SPELL_ICON = true
        addonTable.PLAYER_HIDE_SPELL_ICON = false
        addonTable.PLAYER_TIMER = true
        addonTable.PLAYER_HIDE_PVP_ICON = true

    addonTable.TARGET_ENABLED = true
        addonTable.TARGET_BIG_SPELL_ICON = true
        addonTable.TARGET_HIDE_SPELL_ICON = false
        addonTable.TARGET_TIMER = true
        addonTable.TARGET_HIDE_PVP_ICON = true


-- Minimap
addonTable.ENABLE_MINIMAP = true
    addonTable.MINIMAP_SCALE = 1.3
    addonTable.FADE_BUTTONS = true
    addonTable.FADE_CLOCK = true
    addonTable.FADE_MAIL = true
    addonTable.FADE_NOTICES = true
    addonTable.FADE_ZONETEXT = true
    addonTable.HIDE_ZOOM = true
    addonTable.HIDE_NORTH = true
    addonTable.MICROMENU = true
    addonTable.SCROLL_ZOOM = true
    addonTable.SKIN_BUTTONS = true
    addonTable.SKIN_ZONETEXT = true


-- Dress Up Frame
addonTable.ENABLE_DRESSUP = true
    addonTable.DRESSUP_SCALE = 1.95
    addonTable.DRESSUP_MOUSEOVER = true
    addonTable.DRESSUP_CENTER = true


-- Gossip
addonTable.ENABLE_GOSSIP = true
    addonTable.GOSSIP_SCALE = 1.75
    addonTable.GOSSIP_MERCHANT = true
    addonTable.GOSSIP_QUEST = true
    addonTable.GOSSIP_BOOKS = true
    addonTable.GOSSIP_TOCHAT = true


-- Class Icon Portraits
addonTable.CLASS_PORTRAIT = true


-- Class Colored Health Bars
addonTable.CLASS_HEALTH = true


-- Target Role Icons
addonTable.TARGET_ROLE = true



