local addonName, addonTable = ... 

addonTable.db = {
    -- Full UI Fading
    ENABLE_UIFADE = false,
        UIFADE_IN = 1.0,
        UIFADE_OUT = 0.0,
        UIFADE_NAMES = false,


    -- Mainbar
    ENABLE_MAINBAR = false,
        MAINBAR_ALPHA = 0.9,
        MENUBAR_SCALE = 1.0,

        MAINBAR_EXPBAR_ALPHA = 0.9,
        MAINBAR_EXPBAR_SCALE = 1.0, -- 0.8 allows right click mouselook under bar!

        MAINBAR_LEFTBAR_ALPHA = 1.0,
        MAINBAR_RIGHTBAR_ALPHA = 1.0,
        
        MAINBAR_BAGBAR_ALPHA = 1.0,
        MAINBAR_BAGBAR_SCALE = 1.0,
        
        MAINBAR_MENUBAR_ALPHA = 1.0,
        MAINBAR_MENUBAR_SCALE = 1.0,

        MAINBAR_CENTER_RIGHT_BARS = false,

        MAINBAR_SKIN_BUTTONERRORS = false,

        MAINBAR_HIDE_HOTKEYS = false,
        MAINBAR_HIDE_MACRONAMES = false,
        MAINBAR_HIDE_ACTIONBAR_BG = false,
        MAINBAR_HIDE_GRYPHONS = false,
        MAINBAR_HIDE_BAGS = false,
        MAINBAR_HIDE_MENU = false,
        MAINBAR_HIDE_MENU_BG = false,


    -- UI Colors (class colors by default)
    ENABLE_UICOLORS = false,
        UICOLORS_CUSTOM = false,
        UICOLORS_CUSTOM_R = 0,
        UICOLORS_CUSTOM_G = 0,
        UICOLORS_CUSTOM_B = 0,
        UICOLORS_CUSTOM_A = 1,
        
    -- Change frame fonts to white Arial
    ENABLE_FONTS = false,

    -- Cast Bars
    ENABLE_CASTBARS = false,
        CASTBARS_PLAYER = false,
            PLAYER_BIG_SPELL_ICON = false,
            PLAYER_HIDE_SPELL_ICON = false,
            PLAYER_TIMER = false,
            PLAYER_HIDE_PVP_ICON = false,

        CASTBARS_TARGET = false,
            TARGET_BIG_SPELL_ICON = false,
            TARGET_HIDE_SPELL_ICON = false,
            TARGET_TIMER = false,
            TARGET_HIDE_PVP_ICON = false,


    -- Minimap
    ENABLE_MINIMAP = false,
        MINIMAP_SCALE = 1.0,
        FADE_BUTTONS = false,
        FADE_CLOCK = false,
        FADE_MAIL = false,
        FADE_NOTICES = false,
        FADE_ZONETEXT = false,
        HIDE_ZOOM = false,
        HIDE_NORTH = false,
        MICROMENU = false,
        SCROLL_ZOOM = false,
        SKIN_BUTTONS = false,
        HIDE_MAPICON = false,


    -- Dress Up Frame
    ENABLE_DRESSUP = false,
        DRESSUP_SCALE = 1.95,
        DRESSUP_MOUSEOVER = false,
        DRESSUP_CENTER = false,


    -- Gossip
    ENABLE_GOSSIP = false,
        GOSSIP_SCALE = 1.75,
        GOSSIP_MERCHANT = false,
        GOSSIP_QUEST = false,
        GOSSIP_BOOKS = false,
        GOSSIP_GARRISON = false,
        GOSSIP_TOCHAT = false,


    -- Player Frame
    CLASS_PORTRAIT = false,


    -- Class Colored Health Bars
    CLASS_HEALTH = false,


    -- Target Frame
    TARGET_ROLE = false,

    -- Raid Frame
    RAID_SCALE = 1.0
}