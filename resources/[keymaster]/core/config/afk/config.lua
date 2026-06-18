--[[
    =============================================
    NEVA - SYSTEME AFK
    Configuration Complete
    =============================================
]]--

Config = Config or {}
Config.AFK = {}

-- =============================================
-- ACTIVATION DU SYSTEME
-- =============================================
Config.AFK.Enabled = true                       -- Activer/Desactiver le systeme AFK

-- =============================================
-- COMMANDES ET CONTROLES
-- =============================================
Config.AFK.Commands = {
    Enter = 'afk',                              -- Commande pour entrer en mode AFK
    Leave = 'quitterafk',                       -- Commande pour quitter le mode AFK
    Leaderboard = 'afktop',                     -- Commande pour voir le leaderboard
}

Config.AFK.Controls = {
    ExitKey = 'E',                              -- Touche pour quitter (affichee dans l'overlay)
    ExitKeyCode = 38,                           -- Code de la touche E (INPUT_CONTEXT)
    ExitOnKeyPress = true,                      -- Quitter en appuyant sur la touche
    ExitOnCommand = true,                       -- Quitter via commande
    ExitOnPoint = true,                         -- Quitter via point de sortie
}

-- =============================================
-- ZONE AFK (Shell/Instance)
-- =============================================
Config.AFK.Zone = {
    -- Coordonnees ou le joueur sera teleporte en mode AFK
    -- Utilise une position dans le ciel pour eviter les collisions
    Coords = vector4(0.0, 0.0, 500.0, 0.0),

    -- Point de sortie (si ExitOnPoint = true)
    ExitPoint = {
        Coords = vector3(0.0, 0.0, 500.0),
        Radius = 2.0,
        Marker = {
            Type = 1,                           -- Type de marker (cylindre)
            Color = {r = 255, g = 100, b = 100, a = 150},
            Size = vector3(2.0, 2.0, 1.0),
            BobUpAndDown = true,
        }
    },

    -- Position de retour apres le mode AFK
    ReturnToLastPosition = true,                -- Retourner a la derniere position
    DefaultReturnCoords = vector4(-269.4, -955.3, 31.2, 205.0), -- Position par defaut si erreur

    -- Bucket/Instance pour isoler les joueurs AFK
    UseBucket = true,                           -- Utiliser un routing bucket separe
    BucketId = 9999,                            -- ID du bucket AFK (tous les AFK ensemble)
    UseUniqueBucket = false,                    -- Si true, chaque joueur a son propre bucket
}

-- =============================================
-- RECOMPENSES AFK
-- =============================================
Config.AFK.Rewards = {
    Enabled = true,                             -- Activer les recompenses

    -- Intervalle de paiement
    Interval = 60,                              -- Intervalle en secondes (60 = 1 minute)

    -- Montant de base par intervalle
    BaseAmount = 100,                           -- $ par intervalle pour les joueurs normaux

    -- Type de compte pour les recompenses
    AccountType = 'bank',                       -- 'cash' ou 'bank'

    -- Limite de temps AFK par session
    MaxSessionTime = 480,                       -- Maximum 8 heures (480 minutes) par session
    MaxDailyTime = 720,                         -- Maximum 12 heures (720 minutes) par jour

    -- Bonus progressif (plus tu restes, plus tu gagnes)
    ProgressiveBonus = {
        Enabled = true,
        Intervals = {
            {minutes = 30, multiplier = 1.1},   -- +10% apres 30 min
            {minutes = 60, multiplier = 1.25},  -- +25% apres 1h
            {minutes = 120, multiplier = 1.5},  -- +50% apres 2h
            {minutes = 240, multiplier = 1.75}, -- +75% apres 4h
        }
    }
}

-- =============================================
-- BOOST VIP
-- =============================================
Config.AFK.VIP = {
    Enabled = true,                             -- Activer le boost VIP

    -- Multiplicateur VIP
    Multiplier = 2.0,                           -- x2 pour les VIP

    -- Message special pour les VIP
    VIPMessage = "~g~VIP~w~ | Vous recevez x2 des recompenses AFK!",

    -- Bonus exclusifs VIP
    ExclusiveBonuses = {
        -- Pas de limite de temps pour les VIP
        NoTimeLimit = true,

        -- Bonus de connexion AFK
        ConnectionBonus = 500,                  -- Bonus a l'entree en mode AFK

        -- Acces au leaderboard VIP
        VIPLeaderboard = true,
    }
}

-- =============================================
-- LEADERBOARD
-- =============================================
Config.AFK.Leaderboard = {
    Enabled = true,                             -- Activer le leaderboard

    -- Nombre de joueurs affiches
    TopPlayers = 10,

    -- Afficher dans la zone AFK
    ShowInZone = true,

    -- Rafraichissement automatique (secondes)
    RefreshInterval = 30,

    -- Recompenses pour le top
    TopRewards = {
        Enabled = false,                        -- Desactive par defaut
        Rewards = {
            {rank = 1, coins = 100},            -- Top 1 = 100 coins
            {rank = 2, coins = 50},             -- Top 2 = 50 coins
            {rank = 3, coins = 25},             -- Top 3 = 25 coins
        }
    }
}

-- =============================================
-- OVERLAY / INTERFACE
-- =============================================
Config.AFK.Overlay = {
    Enabled = true,                             -- Afficher l'overlay

    -- Position de l'overlay
    Position = 'bottom-right',                  -- 'top-left', 'top-right', 'bottom-left', 'bottom-right', 'center'

    -- Elements affiches
    ShowTimer = true,                           -- Temps AFK
    ShowEarnings = true,                        -- Argent gagne cette session
    ShowNextReward = true,                      -- Temps avant prochaine recompense
    ShowVIPStatus = true,                       -- Statut VIP
    ShowLeaderboard = true,                     -- Mini leaderboard
    ShowExitInfo = true,                        -- Info pour quitter

    -- Style
    Theme = 'dark',                             -- 'dark' ou 'light'
    Opacity = 0.9,
}

-- =============================================
-- ANTI-AFK (Securite)
-- =============================================
Config.AFK.Security = {
    -- Verification anti-macro/bot
    AntiMacro = {
        Enabled = true,
        -- Demander une action aleatoire toutes les X minutes
        CheckInterval = 30,                     -- Verification toutes les 30 min
        TimeToRespond = 60,                     -- 60 secondes pour repondre
        FailAction = 'kick',                    -- 'kick', 'warn', 'remove_earnings'
    },

    -- Logs
    Logging = {
        Enabled = true,
        LogEnter = true,
        LogLeave = true,
        LogEarnings = true,
        WebhookURL = '',                        -- Webhook Discord (optionnel)
    }
}

-- =============================================
-- MESSAGES
-- =============================================
Config.AFK.Messages = {
    -- Entree/Sortie
    EnterAFK = "~g~Mode AFK active!~w~ Vous gagnez de l'argent passivement.",
    LeaveAFK = "~r~Mode AFK desactive!~w~ Vous avez gagne ~g~$%s~w~ pendant votre session.",

    -- Recompenses
    RewardReceived = "~g~+$%s~w~ (AFK)",
    VIPRewardReceived = "~p~VIP~w~ | ~g~+$%s~w~ (AFK x2)",

    -- Limites
    MaxSessionReached = "~r~Limite de session atteinte!~w~ Vous avez atteint %s heures.",
    MaxDailyReached = "~r~Limite journaliere atteinte!~w~ Revenez demain.",

    -- Erreurs
    AlreadyAFK = "~r~Vous etes deja en mode AFK!",
    NotAFK = "~r~Vous n'etes pas en mode AFK!",
    SystemDisabled = "~r~Le systeme AFK est desactive.",

    -- Leaderboard
    LeaderboardTitle = "~y~=== TOP AFK ===~w~",
    LeaderboardEntry = "#%s - %s : %s heures",

    -- Anti-AFK
    AntiAFKCheck = "~y~Verification anti-AFK!~w~ Appuyez sur ~g~ESPACE~w~ pour confirmer.",
    AntiAFKFailed = "~r~Verification echouee!~w~ Vous avez ete retire du mode AFK.",
}

-- =============================================
-- EFFETS VISUELS EN ZONE AFK
-- =============================================
Config.AFK.Effects = {
    -- Effet visuel
    ScreenEffect = {
        Enabled = true,
        Effect = 'MP_job_load',                 -- Effet de chargement
    },

    -- Ped AFK (le joueur devient invisible et un ped est spawn)
    UseAFKPed = false,                          -- Utiliser un ped AFK
    AFKPed = 'a_m_m_business_01',

    -- Animation du joueur
    Animation = {
        Enabled = true,
        Dict = 'anim@mp_player_intcelebrationmale@freakout',
        Name = 'freakout',
        Loop = true,
    },

    -- Props (objets)
    Props = {
        Enabled = false,
        Items = {
            -- {model = 'prop_chair_01a', bone = -1, offset = vector3(0, 0, 0)},
        }
    }
}
