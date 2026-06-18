Config = Config or {}

-- ═══════════════════════════════════════════════════════════════
--   CONFIGURATION GÉNÉRALE
-- ═══════════════════════════════════════════════════════════════

Config.Locale = 'fr'                                        -- Langue du script
Config.Inventory = 'ox'                                     -- Type d'inventaire: 'ox', 'tgiann', 'qs', 'codem'
Config.ESXMode = 'new'                                      -- 'old' ou 'new' (compatibilité ESX)

-- ═══════════════════════════════════════════════════════════════
--   PHONE & BLACK MARKET (Vente & Missions)
-- ═══════════════════════════════════════════════════════════════

Config.Phone = {
    Command = "open_drugphone",
    ItemName = "black_phone",
    RespectLimit = 10000,
    SkillLimit = 250,
}

Config.Wholesale = {
    MinQuantity = 15,
    MaxQuantity = 20,
    RewardItem = "black_money", 
    InterestChance = 100,
    Duration = 900, -- 15 minutes pour y aller
    Peds = {
        "g_m_y_ballasout_01", "g_m_y_famca_01", "g_m_y_lost_01", "g_m_y_mexgoon_01", "g_m_y_salvagoon_01",
        "ig_claypain", "ig_ramp_gang", "g_m_y_azteca_01", "g_m_y_strpunk_01", "g_m_y_strpunk_02",
        "a_m_m_og_boss_01", "g_m_m_chicold_01", "g_m_y_korean_01"
    },
    Locations = {
        -- Difficulté Facile (coords by mathbdx)
        vector4(265.5045, 69.6268, 94.3720, 0.0),
        vector4(475.9045, -1528.1135, 29.3063, 0.0),
        vector4(116.2267, -2578.1404, 6.0046, 0.0),
        -- Difficulté Moyenne (coords by mathbdx)
        vector4(-127.6670, 1923.5858, 197.3304, 0.0),
        vector4(1037.9673, 2650.3843, 39.5511, 0.0),
        vector4(2466.1050, 1588.7687, 32.7203, 0.0),
        -- Difficulté Difficile (coords by mathbdx)
        vector4(-213.9523, 6567.0635, 10.9099, 0.0),
        vector4(3333.7058, 5160.3223, 18.3020, 0.0),
        vector4(734.3467, 4173.6401, 40.6583, 0.0),
    }
}

-- CONFIGURATION DES DROGUES (PRIX & ANIMS)
-- C'est ici que tu gères les prix, les props et les animations.
Config.DrugsSetup = {
    {item = "weed_pooch", label = "Weed", props = "prop_weed_block_01",     anim = {"mp_common", "givetake2_a"}, minmoney = 35, maxmoney = 60,  img = "img/inventory/marijuana.png"},
    {item = "coke_pooch", label = "Coke", props = "prop_coke_block_half_b", anim = {"mp_common", "givetake2_a"}, minmoney = 100, maxmoney = 150, img = "img/inventory/coke.png"},
    {item = "meth_pooch", label = "Meth", props = "p_meth_bag_01_s",        anim = {"mp_common", "givetake2_a"}, minmoney = 70, maxmoney = 110, img = "img/inventory/meth.png"},
}

Config.Retail = {
    ClientCooldown = 300000,
    PoliceAlertChance = 60,
    InterestInDrugs = 100,
    MaxQuantity = 5,
    Increase = { Respect = 1, Skill = 1 },
    Decrease = { Respect = 1, Skill = 1 },
    Animations = {
        Dialog = {
            Male = {
                {dict = "anim@heists@heist_corona@team_idles@male_a", anim = "idle"},
                {dict = "anim@mp_corona_idles@male_c@idle_a", anim = "idle_a"},
                {dict = "amb@world_human_drug_dealer_hard@male@base", anim = "base"},
            },
            Female = {
                {dict = "anim@mp_corona_idles@female_b@idle_a", anim = "idle_a"},
                {dict = "mp_move@prostitute@m@french", anim = "idle"},
                {dict = "amb@world_human_drug_dealer_hard@female@base", anim = "base"},
            }
        },
        Trade = {
            {dict = "mp_common", anim = "givetake1_a", duration = 2000, swap = 1000},
            {dict = "mp_ped_interaction", anim = "handshake_guy_a", duration = 3000, swap = 1500}
        }
    }
}

Config.Translations = {
    ["phone_messages_title"] = "Messages",
    ["phone_call_stranger_title"] = "Client #%s",
    ["phone_call_message_end"] = "Appel terminé (%s sec)",
    ["phone_message_input_drug_amount"] = "Quantité (15-20)...",
    ["phone_message_input_price"] = "Prix global...",
    ["notify_input_wrong"] = "Erreur: Entrée invalide",
    ["notify_settings_error"] = "Erreur: Paramètres",
    ["notify_inventory_select"] = "Sélectionnez un item",
    ["dialog_stranger_title"] = "Grossiste",
    ["dialog_respect_tooltip"] = "Respect: %s / %s",
    ["dialog_sales_skill_tooltip"] = "Compétence: %s / %s",
    ["dialog_inventory_title"] = "Stock",
    ["phone_ogApp_title"] = "Stats & Respect",
    ["phone_settings_title"] = "Préférences",
    ["phone_ogApp_respect_title"] = "Réputation (Street)",
    ["phone_ogApp_selling_skill_title"] = "Technique de Vente",
    ["phone_ogApp_active_subscriptions_title"] = "Bonus Actifs",
    ["phone_setting_alerts"] = "Notifications",
    ["phone_setting_alerts_sound"] = "Sons",
    ["phone_setting_selling"] = "Mode Vente (Go Fast)",
    ["phone_no_messages"] = "Aucun message récent",
    ["modal_delete_title"] = "Effacer",
    ["modal_delete_confirm"] = "Supprimer cette discussion ?",
    ["modal_accept"] = "Oui",
    ["modal_cancel"] = "Non",

    ["randomTexts"] = {
        ["phone_message_accept_offer"] = {
            "Ok, ça me va. %s unités, prépare ça.", 
            "Deal. %s paquets. Je t'envoie le point de RDV, sois discret.", 
            "Ça marche pour %s. Fais pas attendre mes gars.", 
            "Allez, je te prends les %s. Ramène-toi.", 
            "C'est bon pour %s. Viens me voir, et vite.", 
            "Vas-y, prépare les %s pochons. GPS envoyé.", 
            "J'accepte pour %s. Fais gaffe à toi sur la route."
        },
        ["phone_message_gps"] = {
            "Point GPS reçu ? Bouge toi.", 
            "Rendez-vous sur le GPS. Pas de flics.", 
            "Check ta carte, je t'attends là-bas.", 
            "Rejoins mon contact à cette position.", 
            "Lieu de l'échange envoyé. Sois à l'heure.", 
            "C'est calé sur ton GPS. Viens seul.", 
            "Position transmise. Fais pas de dinguerie."
        },
        ["phone_message_no_places"] = {
            "C'est trop chaud là, y'a les condés partout. Rappelle plus tard.", 
            "Pas de spot dispo pour l'instant, c'est la hess.", 
            "Je peux pas maintenant, mes gars sont occupés. Réessaie."
        },
        ["phone_message_drug_amount"] = {
            "Je peux te livrer %s.", 
            "J'ai %s dispos, ça t'intéresse ?", 
            "J'ai un stock de %s, tu prends ?", 
            "J'ai préparé %s paquets pour toi.", 
            "J'arrive avec %s unités."
        },
        ["phone_message_drug_amount_fail"] = {
            "Ah merde, j'ai pas assez sur moi en fait.", 
            "Attends, j'ai un souci de stock.", 
            "J'suis à sec, laisse tomber pour l'instant.", 
            "Mince, j'ai plus rien."
        },
        ["phone_message_price_question"] = {
            "Tu me fais ça à combien le tout ?", 
            "Annonce la couleur, combien pour le lot ?", 
            "C'est quoi ton prix ?", 
            "Combien tu veux pour la livraison ?", 
            "Fais-moi un prix réglo."
        },
        ["phone_message_price_answer"] = {
            "Je te fais ça à %s $.", 
            "Je veux %s $ pour le tout.", 
            "Le prix est fixe : %s $.", 
            "Ça fera %s $, à prendre ou à laisser.", 
            "Pour toi, %s $."
        },
        ["phone_message_call"] = {
            "J'appelle...", 
            "Je tente de joindre le boss...", 
            "Attends, je passe un coup de fil."
        },
        ["phone_message_price_negotiation"] = {
            "T'es ouf ? C'est trop cher, baisse ça.", 
            "Tu te touches sur le prix ? Fais un effort.", 
            "C'est de la grosse en gros, fais-moi un prix de gros !", 
            "T'abuses cousin, baisse le tarif.", 
            "Naaaan, trop cher. Revois ton prix."
        },
        ["phone_message_price_fail"] = {
            "Laisse tomber, t'es trop gourmand.", 
            "C'est mort, j'trouverai moins cher ailleurs.", 
            "Oublie, t'es pas sérieux avec tes prix.", 
            "Arrête de m'appeler si c'est pour m'arnaquer.", 
            "Ciao, gardes ta came à ce prix-là."
        },
        ["phone_message_price_no_req"] = {
            "T'es qui toi ? Fais tes preuves d'abord.", 
            "J'parle pas aux inconnus, monte ton respect.", 
            "Reviens quand t'auras un nom dans la rue."
        },
        ["phone_message_price_lower_before"] = {
            "Tu joues à quoi ? C'était moins cher avant !", 
            "Arrête tes conneries, tu viens d'augmenter le prix.", 
            "Me prends pas pour un jambon, remets l'ancien prix."
        },
        ["phone_npc_ask_for_drug"] = {
            "T'aurais pas de la %s à vendre ?",
            "Je cherche de la %s, t'en as ?",
            "Yo, on m'a dit que tu vendais de la %s ?",
            "Il me faut de la %s, dis-moi que t'as ça."
        },
        ["dialog_npc_first_message"] = {"Yo ?", "Quoi ?", "Tu veux quoi ?", "T'as un truc à dire ?", "C'est pourquoi ?"},
        ["dialog_answer_start_normal"] = {"Je cherche à vendre.", "T'as besoin de matos ?", "J'ai du lourd pour toi."},
        ["dialog_answer_start_exit"] = {"Erreur, désolé.", "Rien, je me casse."},
        ["dialog_npc_whatYouHave"] = {"T'as quoi ?", "Fais voir.", "Montre ta marchandise.", "Qu'est-ce que tu proposes ?"},
        ["dialog_answer_sale_offer"] = {"J'ai du %s.", "Tiens, c'est du %s.", "De la %s pure."},
        ["dialog_answer_whatYouHave_exit"] = {"Rien en fait.", "J'ai rien pour toi."},
        ["dialog_npc_take"] = {"Ok, ça m'a l'air correct.", "Je prends.", "Combien tu veux ?", "Vas-y, annonce le prix."},
        ["dialog_answer_iWillTake_write"] = {"Proposer un prix...", "Faire une offre..."},
        ["dialog_answer_iWillTake_normal"] = {"C'est le bon prix.", "Marché conclu ?", "On fait affaire ?"},
        ["dialog_answer_iWillTake_exit"] = {"Non laisse tomber.", "J'annule la vente."},
        ["dialog_npc_giveMeBetterOption"] = {"Hé oh, doucement sur le prix.", "Trop cher mec.", "Tu rêves, baisse ça.", "Fais un effort."},
        ["dialog_npc_noThanks"] = {"Non, pas intéressé.", "C'est de la merde ton truc.", "J'ai déjà mon fournisseur.", "Dégage avec ça."},
        ["dialog_answer_noThanks_exit"] = {"Ok tant pis.", "Salut.", "Je repasserai."},
        ["dialog_npc_sellSuccess"] = {"Propre. Tiens ton oseille.", "Cimer, fais gaffe en partant.", "Bonne came. À la prochaine.", "C'est carré."},
        ["dialog_answer_sellSuccess_normal"] = {"Merci.", "À plus.", "Fais-en bon usage."},
        ["dialog_npc_sellFail"] = {"Dégage de là.", "Casse-toi.", "Tu me fais perdre mon temps."},
        ["dialog_answer_exit"] = {"Bye.", "Salut."}
    }
}

-- ═══════════════════════════════════════════════════════════════
--   CRÉATION DE CREW (Existantes)
-- ═══════════════════════════════════════════════════════════════
Config.CrewCreation = {
    Mode = 'grade',  
    GradeMode = 'everyone',
}

-- ═══════════════════════════════════════════════════════════════
--   CARTE & TERRITOIRES
-- ═══════════════════════════════════════════════════════════════

Config.Showmap = true
Config.Showlogo = true
Config.WhoCanSee = 'crews'

Config.Map = {
    FreeColor = { r = 100, g = 150, b = 215 },
    FreeOpacity = 0.40,
    ControlledOpacity = 0.40,
    ShowTooltip = true,
    ShowOnMinimap = true,
    LogoOpacity = 0.45,
    LogoSize = 0.5,
    Competition = { LowMax = 1, NormalMax = 4 }
}

-- ═══════════════════════════════════════════════════════════════
--   SYSTÈMES & LOGIQUE
-- ═══════════════════════════════════════════════════════════════

Config.DrugCommand = 'drogue' 
Config.EnableDrugSound = true
Config.MoneyReceive = "black_money"
Config.SellInTerritory = false

Config.DrugInteraction = { Type = 'nv_interact' }

Config.MinimumPoliceForFullPrice = 0
Config.FailureChance = 40
Config.PedDespawnTime = 60000

Config.SellDrugKey = 51
Config.TerritoryMenuKey = 56
Config.CrewMenuKey = nil

Config.MenuBannerColor = { r = 55, g = 55, b = 255, a = 180 }
Config.TerritoryMenuColor = { r = 204, g = 0, b = 102, a = 180 }
Config.BannerCrew = "banner_crew"
Config.BannerTerritories = "banner_territories"

Config.CrewXP = {
    EnableSaleXP = true,
    EnableClaimXP = true,
    SaleXP = { weed = 60, meth = 150, coke = 250 },
    ClaimXP = 150,
}

Config.CrewLevels = {
    [1] = 0, [2] = 500, [3] = 2000, [4] = 4500, [5] = 8000,
    [6] = 13000, [7] = 18500, [8] = 25000, [9] = 40000, [10] = 75000,
    -- ... Suite des niveaux standards si besoin (gardé simple pour l'exemple)
    [30] = 566666,
}

Config.ResetIntervalDays = 14
Config.CrewClaim = 80
Config.AlertChance = 12

Config.ClaimRequirements = {
    MinOnlineToClaim = 0,
    MinLeaderOnline = 0,
}

Config.DrugPoints = {
    weed_pooch = 2,
    meth_pooch = 4,
    coke_pooch = 6
}

Config.PriceMultipliers = {
    [1] = 1.4,
    [2] = 1.3,
    [3] = 1.1,
    [4] = 1.0,
    [5] = 1.0,
}

Config.PoliceJobName = "police"
Config.AlertMessage = "Vente de drogue en cours à"
Config.BlipName = "Drogue"

Config.BlipSettings = {
    id = 51,
    scale = 0.6,
    color = 1,
    time = 120000,
}

Config.AdminGroups = { 'fondateur' }

Config.nvProperty = false
Config.nvvehKeys = false


-- ═══════════════════════════════════════════════════════════════
--   AUTO-CONVERSION (NE PAS TOUCHER)
-- ═══════════════════════════════════════════════════════════════
Config.Retail.Drugs = {}
for i=1, #Config.DrugsSetup do
    local drug = Config.DrugsSetup[i]
    Config.Retail.Drugs[drug.item] = {
        label = drug.label,
        price = {
            retail = drug.maxmoney,
            wholesale = drug.minmoney
        },
        maxPriceMultiplier = {
            retail = 1.5,
            wholesale = 1.5
        },
        img = drug.img or ("img/inventory/"..drug.item..".png"),
        anim = drug.anim,
        props = drug.props
    }
end