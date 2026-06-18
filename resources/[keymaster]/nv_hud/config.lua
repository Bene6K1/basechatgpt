Config = {}

--[[
    ╔════════════════════════════════════════════════════════════╗
    ║              Configuration HUD NEVA                         ║
    ║         Server Info + Status (Health, Hunger, Voice)        ║
    ╚════════════════════════════════════════════════════════════╝
]]

-- ============================================
-- SERVER INFO SETTINGS
-- ============================================
Config.ServerName = "NEVA Ultimate"
Config.DiscordText = ".GG/NEVA-FIVEM"
Config.UpdateInterval = 10000          -- Player ID update interval in ms
Config.TextRotationInterval = 5000     -- Text rotation interval in ms

-- ============================================
-- FRAMEWORK SETTINGS
-- ============================================
Config.framework = {
    -- Choose which framework to use: 'esx', 'qbcore', 'standalone'
    name = 'esx',

    -- Framework resource names (change these if you use custom names)
    resourceNames = {
        esx = 'es_extended',      -- Default is 'es_extended'
        qbcore = 'qb-core',       -- Default is 'qb-core'
    },

    -- Status events and keys by framework
    events = {
        -- ESX status events
        esx = {
            status = 'esx_status:getStatus'
        },

        -- QBCore status events/exports
        qbcore = {
            hunger = 'food',      -- QBCore hunger key
            thirst = 'water',     -- QBCore thirst key
            drunk = 'alcohol'     -- QBCore alcohol key
        }
    }
}

-- ============================================
-- GENERAL SETTINGS
-- ============================================
Config.panelKey = 121           -- F10 key for settings panel
Config.refreshInterval = 1500   -- Status update interval in ms
Config.pttKey = 249             -- Default push-to-talk key (N)

-- ============================================
-- POSITION SETTINGS
-- ============================================
Config.position = {
    bottom = "1.25%",   -- Distance from bottom of screen
    left = "16%"        -- Distance from left of screen
}

-- ============================================
-- ANIMATION SETTINGS
-- ============================================
Config.animations = {
    fadeInTime = 80,    -- Fade in animation duration in ms
    fadeOutTime = 80    -- Fade out animation duration in ms
}

-- ============================================
-- VOICE SETTINGS
-- ============================================
-- Voice mode icons (Font Awesome 6)
Config.voiceTypes = {
    regular = "microphone",       -- Regular voice
    radio = "tower-broadcast",    -- Radio icon
    phone = "phone"               -- Phone icon
}

-- Voice settings for PMA-Voice
Config.voice = {
    modes = {
        [1] = 'whisper',    -- Whisper mode
        [2] = 'normal',     -- Normal mode
        [3] = 'shout'       -- Shout mode
    },
    ranges = {
        [1] = 33,           -- Whisper (33% of progress bar)
        [2] = 66,           -- Normal (66% of progress bar)
        [3] = 100           -- Shout (100% of progress bar)
    }
}

-- ============================================
-- COLOR SETTINGS (RGBA format)
-- ============================================
Config.colors = {
    -- Status circle colors
    thirst = "rgba(91, 173, 220, 0.85)",    -- Pale blue for thirst
    hunger = "rgba(242, 162, 101, 0.85)",   -- Pale orange for hunger

    -- Voice colors
    voice = {
        default = "rgba(255, 255, 255, 0.95)",     -- Default voice color (white)
        whisper = "rgba(91, 173, 220, 0.95)",      -- Whisper mode color (pale blue)
        normal = "rgba(255, 255, 255, 0.95)",      -- Normal mode color (white)
        shout = "rgba(255, 99, 71, 0.95)",         -- Shout mode color (red)

        -- Radio colors - Paler green shades for different ranges
        radio = "rgba(144, 238, 144, 0.95)",           -- Default radio color (light green)
        radioWhisper = "rgba(152, 251, 152, 0.95)",    -- Radio whisper (pale green)
        radioNormal = "rgba(144, 238, 144, 0.95)",     -- Normal radio (light green)
        radioShout = "rgba(127, 255, 170, 0.95)",      -- Radio shout (aquamarine)

        phone = "rgba(255, 204, 0, 0.95)"          -- Phone color (gold)
    },

    -- Icon colors
    icons = {
        thirst = "rgba(150, 210, 255, 0.95)",      -- Thirst icon color (blue)
        hunger = "rgba(255, 200, 150, 0.95)",      -- Hunger icon color (orange)
        voice = "rgba(255, 255, 255, 0.95)",       -- Voice icon color (white)

        -- Radio icon colors - matching circle colors
        radio = "rgba(144, 238, 144, 0.95)",          -- Default radio icon (light green)
        radioWhisper = "rgba(152, 251, 152, 0.95)",   -- Radio whisper icon
        radioNormal = "rgba(144, 238, 144, 0.95)",    -- Normal radio icon
        radioShout = "rgba(127, 255, 170, 0.95)",     -- Radio shout icon

        phone = "rgba(255, 215, 80, 0.95)"         -- Phone icon color (gold)
    },

    -- Background colors
    background = "rgba(10, 10, 10, 0.35)"          -- Circle background color
}

-- ============================================
-- STATUS CIRCLE APPEARANCE
-- ============================================
Config.circle = {
    strokeWidth = "0.32vw",     -- Width of circle stroke
    radius = "42"               -- Circle radius (percentage of SVG)
}
