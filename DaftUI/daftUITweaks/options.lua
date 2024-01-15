local addonName, addonTable = ... 

addonTable.db = {
    -- Full UI Fading
    ENABLE_UIFADE = false,
        UIFADE_IN = 1.0,
        UIFADE_OUT = 0.1,
        UIFADE_NAMES = false,


    -- Mainbar
    ENABLE_MAINBAR = false,
        MAINBAR_SKIN_BUTTONERRORS = false,
        MAINBAR_HIDE_HOTKEYS = false,
        MAINBAR_HIDE_MACRONAMES = false,
        MAINBAR_HIDE_BAGS = false,
        MAINBAR_HIDE_MENU = false,


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
        MICROMENU = false,


    -- Dress Up Frame
    ENABLE_DRESSUP = false,
        DRESSUP_SCALE = 1.5,
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

}