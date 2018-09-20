local addonName, addonTable = ... 

addonTable.db = {
    -- Full UI Fading
    ENABLE_UIFADE = true,
        UIFADE_IN = 1.0,
        UIFADE_OUT = 0.0,


    -- Mainbar
    ENABLE_MAINBAR = true,
        MAINBAR_ALPHA = 0.9,
        MENUBAR_SCALE = 1.0,

        MAINBAR_EXPBAR_ALPHA = 0.9,
        MAINBAR_EXPBAR_SCALE = 1.0, -- 0.8 allows right click mouselook under bar!

        MAINBAR_LEFTBAR_ALPHA = 0.6,
        MAINBAR_RIGHTBAR_ALPHA = 0.6,
        
        MAINBAR_BAGBAR_ALPHA = 1.0,
        MAINBAR_BAGBAR_SCALE = 1.0,
        
        MAINBAR_MENUBAR_ALPHA = 1.0,
        MAINBAR_MENUBAR_SCALE = 1.0,

        MAINBAR_CENTER_RIGHT_BARS = true,

        MAINBAR_SKIN_BUTTONERRORS = true,

        MAINBAR_HIDE_HOTKEYS = false,
        MAINBAR_HIDE_MACRONAMES = true,
        MAINBAR_HIDE_ACTIONBAR_BG = false,
        MAINBAR_HIDE_GRYPHONS = false,
        MAINBAR_HIDE_BAGS = true,
        MAINBAR_HIDE_MENU = true,
        MAINBAR_HIDE_MENU_BG = true,


    -- UI Colors (class colors by default)
    ENABLE_UICOLORS = true,
        UICOLORS_CUSTOM = false,
        UICOLORS_CUSTOM_R = 0,
        UICOLORS_CUSTOM_G = 0,
        UICOLORS_CUSTOM_B = 0,
        UICOLORS_CUSTOM_A = 1,
        
    -- Change frame fonts to white Arial
    ENABLE_FONTS = true,

    -- Cast Bars
    ENABLE_CASTBARS = true,
        CASTBARS_PLAYER = true,
            PLAYER_BIG_SPELL_ICON = true,
            PLAYER_HIDE_SPELL_ICON = false,
            PLAYER_TIMER = true,
            PLAYER_HIDE_PVP_ICON = true,

        CASTBARS_TARGET = true,
            TARGET_BIG_SPELL_ICON = true,
            TARGET_HIDE_SPELL_ICON = false,
            TARGET_TIMER = true,
            TARGET_HIDE_PVP_ICON = true,


    -- Minimap
    ENABLE_MINIMAP = true,
        MINIMAP_SCALE = 1.3,
        FADE_BUTTONS = true,
        FADE_CLOCK = true,
        FADE_MAIL = true,
        FADE_NOTICES = true,
        FADE_ZONETEXT = true,
        HIDE_ZOOM = true,
        HIDE_NORTH = true,
        MICROMENU = true,
        SCROLL_ZOOM = true,
        SKIN_BUTTONS = true,
        HIDE_MAPICON = true,


    -- Dress Up Frame
    ENABLE_DRESSUP = true,
        DRESSUP_SCALE = 1.95,
        DRESSUP_MOUSEOVER = true,
        DRESSUP_CENTER = true,


    -- Gossip
    ENABLE_GOSSIP = true,
        GOSSIP_SCALE = 1.75,
        GOSSIP_MERCHANT = true,
        GOSSIP_QUEST = true,
        GOSSIP_BOOKS = true,
        GOSSIP_GARRISON = true,
        GOSSIP_TOCHAT = true,


    -- Player Frame
    CLASS_PORTRAIT = true,


    -- Class Colored Health Bars
    CLASS_HEALTH = true,


    -- Target Frame
    TARGET_ROLE = true
}