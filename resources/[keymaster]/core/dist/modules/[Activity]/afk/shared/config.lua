--[[
    =============================================
    NEVA - SYSTEME AFK
    Configuration
    =============================================
]]--

Config = Config or {}

Config.AFK = {
    -- Activer/desactiver le systeme
    Enabled = true,

    -- =============================================
    -- ZONE AFK
    -- =============================================
    Zone = {
        -- Coordonnees de la zone AFK (ou le joueur sera teleporte)
        Coords = vector4(0.0, 0.0, 75.0, 0.0),

        -- Utiliser un routing bucket separe
        UseBucket = true,
        BucketId = 999,
        UseUniqueBucket = false, -- Si true, chaque joueur a son propre bucket

        -- Point de sortie (si ExitOnPoint est active)
        ExitPoint = {
            Coords = vector3(0.0, 5.0, 75.0),
            Marker = {
                Type = 1,
                Size = vector3(1.5, 1.5, 1.0),
                Color = {r = 255, g = 0, b = 0, a = 100},
                BobUpAndDown = true
            }
        },

        -- Retourner a la derniere position ou a une position par defaut
        ReturnToLastPosition = true,
        DefaultReturnCoords = vector4(-268.47, -957.01, 31.22, 205.53)
    },

    -- =============================================
    -- CONTROLES
    -- =============================================
    Controls = {
        -- Touche pour quitter le mode AFK
        ExitKey = "BACKSPACE",
        ExitKeyCode = 177, -- Backspace
        ExitOnKeyPress = true,
        ExitOnPoint = false -- Sortir en marchant sur un point
    },

    -- =============================================
    -- RECOMPENSES
    -- =============================================
    Rewards = {
        Enabled = true,

        -- Montant de base donne a chaque intervalle
        BaseAmount = 100,

        -- Intervalle de recompense en secondes
        Interval = 60, -- 1 minute

        -- Type de compte (money, bank, black_money)
        AccountType = 'bank',

        -- Limites
        MaxSessionTime = 7200, -- 2 heures max par session (en secondes)
        MaxDailyTime = 240, -- 4 heures max par jour (en minutes)

        -- Bonus progressif
        ProgressiveBonus = {
            Enabled = true,
            Intervals = {
                {minutes = 30, multiplier = 1.1},
                {minutes = 60, multiplier = 1.2},
                {minutes = 120, multiplier = 1.5}
            }
        }
    },

    -- =============================================
    -- VIP
    -- =============================================
    VIP = {
        Enabled = true,
        Multiplier = 2.0, -- Double les recompenses

        ExclusiveBonuses = {
            ConnectionBonus = 500, -- Bonus a l'entree en AFK
            NoTimeLimit = true -- Pas de limite de temps
        }
    },

    -- =============================================
    -- EFFETS VISUELS
    -- =============================================
    Effects = {
        Animation = {
            Enabled = true,
            Dict = "amb@world_human_bum_slumped@male@laying_on_right_side@idle_a",
            Name = "idle_a",
            Loop = true
        },

        ScreenEffect = {
            Enabled = false,
            Effect = "hud_def_blur" -- Effet de flou
        }
    },

    -- =============================================
    -- OVERLAY NUI
    -- =============================================
    Overlay = {
        Enabled = true,
        Position = "top-right", -- top-left, top-right, bottom-left, bottom-right
        Theme = "dark", -- dark, light
        Opacity = 0.9,

        -- Elements affiches
        ShowTimer = true,
        ShowEarnings = true,
        ShowNextReward = true,
        ShowVIPStatus = true,
        ShowLeaderboard = true,
        ShowExitInfo = true
    },

    -- =============================================
    -- LEADERBOARD
    -- =============================================
    Leaderboard = {
        Enabled = true,
        TopPlayers = 10,
        RefreshInterval = 60, -- Rafraichir toutes les 60 secondes
        ShowInZone = true
    },

    -- =============================================
    -- COMMANDES
    -- =============================================
    Commands = {
        Enter = "afk",
        Leave = "quitafk",
        Leaderboard = "afktop"
    },

    -- =============================================
    -- MESSAGES
    -- =============================================
    Messages = {
        SystemDisabled = "~r~Le systeme AFK est actuellement desactive.",
        AlreadyAFK = "~r~Vous etes deja en mode AFK.",
        NotAFK = "~r~Vous n'etes pas en mode AFK.",
        EnterAFK = "~g~Vous etes maintenant en mode AFK. Gagnez des recompenses!",
        LeaveAFK = "~y~Vous avez quitte le mode AFK. Gains totaux: ~g~$%s",
        RewardReceived = "~g~+$%s~w~ (Recompense AFK)",
        VIPRewardReceived = "~p~VIP~w~ | ~g~+$%s~w~ (Recompense AFK)",
        MaxSessionReached = "~r~Limite de session atteinte (%d heures). Vous avez ete ejecte du mode AFK.",
        MaxDailyReached = "~r~Vous avez atteint votre limite journaliere de temps AFK.",
        LeaderboardTitle = "~b~=== TOP AFK ===",
        LeaderboardEntry = "~y~#%d~w~ %s - %s"
    },

    -- =============================================
    -- SECURITE
    -- =============================================
    Security = {
        Logging = {
            Enabled = true,
            WebhookURL = "" -- URL Discord webhook pour les logs
        }
    }
}
