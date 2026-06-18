Config = Config or {}

Config.Phone = {
    Command = "open_drugphone",
    ItemName = "black_phone",
    RespectLimit = 10000,
    SkillLimit = 250,
    MessageInterval = 120,
}

Config.Wholesale = {
    MinQuantity = 15,
    MaxQuantity = 20,
    RewardItem = "black_money",
    InterestChance = 100,
    Duration = 600,
    Peds = {
        "g_m_y_ballasout_01",
        "g_m_y_famca_01",
        "g_m_y_lost_01",
        "g_m_y_mexgoon_01",
        "g_m_y_salvagoon_01"
    },
    Locations = {
        vector4(124.78, -1972.68, 21.03, 226.37),
        vector4(-154.67, -1645.03, 36.92, 45.42),
        vector4(218.66, -1828.98, 27.28, 318.99),
        vector4(356.57, -2065.17, 21.65, 321.0),
        vector4(859.39, -2346.72, 30.56, 345.0),
        vector4(966.82, -1859.94, 31.20, 269.0),
        vector4(166.75, -2223.11, 7.32, 126.0),
    }
}

Config.Translations = {

    ["phone_messages_title"] = "Messages",
    ["phone_call_stranger_title"] = "Inconnu #%s",
    ["phone_call_message_end"] = "Appel terminé (%s sec)",
    ["phone_message_input_drug_amount"] = "Quantité (15-20)...",
    ["phone_message_input_price"] = "Prix unitaire...",
    ["notify_input_wrong"] = "Erreur: Entrée invalide",
    ["notify_settings_error"] = "Erreur: Paramètres",
    ["notify_inventory_select"] = "Sélectionnez un item",
    ["dialog_stranger_title"] = "Inconnu",
    ["dialog_respect_tooltip"] = "Respect: %s / %s",
    ["dialog_sales_skill_tooltip"] = "Compétence: %s / %s",
    ["dialog_inventory_title"] = "Inventaire",
    ["phone_ogApp_title"] = "Mon Profil",
    ["phone_settings_title"] = "Paramètres",
    ["phone_ogApp_respect_title"] = "Respect",
    ["phone_ogApp_selling_skill_title"] = "Compétence de Vente",
    ["phone_ogApp_active_subscriptions_title"] = "Abonnements Actifs",
    ["phone_setting_alerts"] = "Alertes",
    ["phone_setting_alerts"] = "Alertes",
    ["phone_setting_alerts_sound"] = "Son des Alertes",
    ["phone_setting_selling"] = "Mode Vente",
    ["phone_no_messages"] = "Aucun message",
    ["modal_delete_title"] = "Supprimer",
    ["modal_delete_confirm"] = "Voulez-vous vraiment supprimer cette conversation ?",
    ["modal_accept"] = "Accepter",
    ["modal_cancel"] = "Annuler",
    ["phone_message_initial_offer"] = "Salut, j'ai besoin de %s pochons de %s. Tu me fais ça à combien ?",


    ["randomTexts"] = {
        ["phone_message_accept_offer"] = {
            "Je prends les %s pochons, amène ça vite.",
            "Ok pour %s pochons, bouge pas.",
            "Ça marche pour %s pochons, je t'envoie les coord.",
            "Vas-y pour %s unités, rejoins-moi.",
            "C'est bon pour %s paquets, viens me voir.",
            "Allez, je te prends les %s pochons.",
            "Deal. %s paquets. Viens."
        },
        ["phone_message_gps"] = {
            "Je t'envoie la position GPS.",
            "Rendez-vous ici (GPS).",
            "Check ton GPS, je suis là.",
            "Viens discrètement à ce point.",
            "Point GPS envoyé. Fais gaffe aux flics.",
            "Rejoins-moi là-bas.",
            "C'est l'endroit sur ton GPS."
        },
        ["phone_message_no_places"] = {
            "Pas de lieu dispo, rappelle plus tard.",
            "C'est trop chaud en ce moment, je peux pas.",
            "Je t'appelle dès que la voie est libre.",
            "Trop de patrouilles, oublie pour l'instant."
        },
        ["phone_message_drug_amount"] = {
            "J'en ai %s pochons pour toi.",
            "Je peux te fournir %s pochons.",
            "J'ai un stock de %s paquets.",
            "Voici %s unités, t'es chaud ?",
            "J'ai préparé %s pochons."
        },
        ["phone_message_drug_amount_fail"] = {
            "J'ai pas assez sur moi.",
            "Oups, rupture de stock.",
            "Merde, j'ai tout vendu, désolé.",
            "Reviens vers moi plus tard, j'suis à sec."
        },
        ["phone_message_price_question"] = {
            "C'est combien ?",
            "Ton prix pour le lot ?",
            "Tu vends ça combien ?",
            "Quel est ton tarif ?",
            "Fais-moi un prix.",
            "Tu demandes combien ?"
        },
        ["phone_message_price_answer"] = {
            "%s $",
            "Je veux %s $",
            "Le prix est %s $",
            "Ça fera %s $",
            "Pour toi, %s $."
        },
        ["phone_message_call"] = {
            "J'appelle...",
            "J'passe un coup de fil.",
            "Attends, je t'appelle."
        },
        ["phone_message_price_negotiation"] = {
            "Trop cher, baisse un peu.",
            "Fais un effort, c'est de la grosse qté.",
            "Baisse le prix et on discute.",
            "T'es fou ? Moins cher.",
            "C'est de l'arnaque à ce prix là."
        },
        ["phone_message_price_fail"] = {
            "Laisse tomber.",
            "C'est mort.",
            "Oublie, t'es trop gourmand.",
            "J'trouverai moins cher ailleurs.",
            "Pas intéressé à ce tarif."
        },
        ["phone_message_price_no_req"] = {
            "Tu te fous de moi ?",
            "T'es pas sérieux (Respect insuffisant).",
            "Fais tes preuves d'abord."
        },
        ["phone_message_price_lower_before"] = {
            "Tu as augmenté le prix !",
            "C'était moins cher avant, sérieux ?",
            "Me prends pas pour un con."
        },


        ["dialog_npc_first_message"] = {
            "Yo ?",
            "Quoi ?",
            "Tu veux quoi ?",
            "T'as un truc à dire ?",
            "On se connait ?"
        },
        ["dialog_answer_start_normal"] = {
            "Tu cherches quelque chose ?",
            "J'ai du matos de qualité.",
            "Besoin de sensations ?",
            "J'ai ce qu'il te faut."
        },
        ["dialog_answer_start_exit"] = {
            "Rien, laisse tomber.",
            "Au revoir.",
            "Erreur, désolé."
        },
        ["dialog_npc_whatYouHave"] = {
            "Qu'est-ce que t'as ?",
            "Montre voir ce que tu vends.",
            "Vas-y, propose.",
            "J'écoute."
        },
        ["dialog_answer_sale_offer"] = {
            "Je vends du %s.",
            "Tiens, du %s pur.",
            "De la bonne %s."
        },
        ["dialog_answer_whatYouHave_exit"] = {
            "Rien d'intéressant.",
            "J'ai changé d'avis.",
            "Pas pour toi."
        },
        ["dialog_npc_take"] = {
            "Ok, je prends.",
            "Ça m'intéresse, combien ?",
            "Ça a l'air bon, je prends."
        },
        ["dialog_answer_iWillTake_write"] = {
            "Proposer un prix...",
            "Combien tu donnes ?",
            "Fais une offre."
        },
        ["dialog_answer_iWillTake_normal"] = {
            "D'accord.",
            "Marché conclu.",
            "C'est parti."
        },
        ["dialog_answer_iWillTake_exit"] = {
            "Non merci.",
            "J'annule.",
            "Ciao."
        },
        ["dialog_npc_giveMeBetterOption"] = {
            "Trop cher.",
            "Fais mieux.",
            "Baisse le prix."
        },
        ["dialog_npc_noThanks"] = {
            "Non merci.",
            "Pas intéressé.",
            "J'ai déjà ce qu'il faut."
        },
        ["dialog_answer_noThanks_exit"] = {
            "Tant pis.",
            "Salut.",
            "À plus."
        },
        ["dialog_npc_sellSuccess"] = {
            "Merci mec.",
            "À la prochaine.",
            "Cimer.",
            "Tu gères."
        },
        ["dialog_answer_sellSuccess_normal"] = {
            "De rien.",
            "Ciao.",
            "Bonne journée."
        },
        ["dialog_npc_sellFail"] = {
            "Dégage.",
            "Va voir ailleurs.",
            "Fous le camp."
        },
        ["dialog_answer_exit"] = {
            "Bye.",
            "Salut.",
            "Adios."
        }
    }
}
