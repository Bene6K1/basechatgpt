
Config.VIP = {
    -- Activation/Désactivation des fonctionnalités
    Features = {
        RecupererArme = true,           -- Bouton pour récupérer l'arme VIP
        RecupererArgent = true,         -- Bouton pour récupérer l'argent VIP
        SortirScooter = true,           -- Possibilité de faire spawn un scooter
        ModeDrift = true,               -- Option pour activer le mode drift
        TeintesArmes = true,            -- Personnalisation des teintes d'armes
        CustomArmes = true,             -- Personnalisation des composants d'armes
        AnimauxTemporaires = true,      -- Possibilité d'avoir des animaux temporaires
        AnimauxPermanents = true,       -- Possibilité d'avoir des animaux permanents
        ChangementPed = true,           -- Possibilité de changer son ped
        PlaquesPerso = true            -- Personnalisation des plaques d'immatriculation
    },

    -- Valeurs et paramètres
    Values = {
        -- Récompenses
        Rewards = {
            Money = 25000,              -- Montant d'argent donné
            WeaponName = "PISTOL", -- Arme donnée
            WeaponAmmo = 100            -- Munitions données avec l'arme
        },

        -- Véhicules
        Vehicles = {
            ScooterModel = "faggio",    -- Modèle du scooter spawnable
            MaxScooters = 1             -- Nombre max de scooters par session
        },

        -- Animaux
        Animals = {
            MaxDistance = 10.0,         -- Distance max pour les interactions avec l'animal
            FollowDistance = 5.0,       -- Distance de suivi pour l'animal
            Types = {
                Temporary = {
                    {label = "Chien", model = "a_c_rottweiler"},
                    {label = "Chat", model = "a_c_cat_01"},
                    {label = "Lapin", model = "a_c_rabbit_01"}
                },
                Permanent = {
                    {label = "Chien", model = "a_c_rottweiler"},
                    {label = "Chat", model = "a_c_cat_01"}
                }
            }
        },

        -- Peds disponibles
        Peds = {
            {label = "Clown", model = "s_m_y_clown_01"},
            {label = "Alien", model = "s_m_m_movalien_01"},
            {label = "Astronaute", model = "s_m_m_movspace_01"}
            -- Ajoutez d'autres peds ici
        },

        -- Teintes d'armes disponibles
        WeaponTints = {
            {id = 0, label = "Normal"},
            {id = 1, label = "Vert"},
            {id = 2, label = "Or"},
            {id = 3, label = "Rose"},
            {id = 4, label = "Armée"},
            {id = 5, label = "LSPD"},
            {id = 6, label = "Orange"},
            {id = 7, label = "Platine"}
        },

        -- Configuration des plaques
        Plates = {
            MaxLength = 8,              -- Longueur maximale de la plaque
            MaxCustomPlates = 5,        -- Nombre maximum de plaques personnalisées
            AllowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        }
    },

    -- Permissions et restrictions
    Restrictions = {
        SafeZonesOnly = true,          -- Certaines actions uniquement en safe zone
        BlacklistedJobs = {            -- Jobs qui ne peuvent pas utiliser certaines fonctions
            "police",
            "ambulance"
        },
        CooldownMinutes = 60           -- Temps entre chaque utilisation de certaines fonctions
    }
}

-- Fonctions utilitaires pour la configuration
function Config.VIP.IsFeatureEnabled(feature)
    return Config.VIP.Features[feature] or false
end

function Config.VIP.GetValue(category, key)
    if Config.VIP.Values[category] and Config.VIP.Values[category][key] then
        return Config.VIP.Values[category][key]
    end
    return nil
end
