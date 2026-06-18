--[[
================================================================================
                        GARAGES GROUPES ILLEGAUX
================================================================================
Configuration des garages pour les groupes illégaux (gangs, mafias, cartels, etc.)
Fonctionne avec job2 (emploi secondaire) contrairement aux garages d'entreprise.
================================================================================
]]

GangGarages = {}

--[[
CONFIGURATION DES GARAGES PAR GROUPE ILLEGAL
Clé = nom du job2 (gang)
]]
GangGarages.Gangs = {

    -- EXEMPLE: Ballas
    ['ballas'] = {
        label = "Garage Ballas",
        enabled = true,
        garageType = 'car',

        accessPoint = vector4(89.7018, -1958.7628, 20.7378, 320.0),
        deletePoint = vector4(95.2341, -1963.1234, 20.7378, 140.0),
        spawnPoints = {
            vector4(101.5432, -1970.1234, 20.7378, 320.0),
            vector4(107.1234, -1975.5432, 20.7378, 320.0),
        },

        vehicles = {
            {
                model = "buccaneer",
                label = "Buccaneer",
                livery = 0,
                type = "car",
            },
            {
                model = "tornado",
                label = "Tornado",
                livery = 0,
                type = "car",
            },
        },

        blip = {
            enabled = false,
            sprite = 357,
            color = 27,
            scale = 0.6
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 1
        }
    },

    -- EXEMPLE: Grove Street
    ['grove'] = {
        label = "Garage Grove Street",
        enabled = true,
        garageType = 'car',

        accessPoint = vector4(-25.1234, -1433.5678, 30.6525, 0.0),
        deletePoint = vector4(-30.5678, -1438.1234, 30.6525, 180.0),
        spawnPoints = {
            vector4(-35.1234, -1443.5678, 30.6525, 0.0),
            vector4(-40.5678, -1448.1234, 30.6525, 0.0),
        },

        vehicles = {
            {
                model = "greenwood",
                label = "Greenwood",
                livery = 0,
                type = "car",
            },
            {
                model = "buccaneer2",
                label = "Buccaneer Custom",
                livery = 0,
                type = "car",
            },
        },

        blip = {
            enabled = false,
            sprite = 357,
            color = 2,
            scale = 0.6
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 1
        }
    },

    -- EXEMPLE: Vagos
    ['vagos'] = {
        label = "Garage Vagos",
        enabled = true,
        garageType = 'car',

        accessPoint = vector4(325.6789, -2035.1234, 20.9203, 50.0),
        deletePoint = vector4(330.1234, -2040.5678, 20.9203, 230.0),
        spawnPoints = {
            vector4(335.5678, -2045.1234, 20.9203, 50.0),
            vector4(340.1234, -2050.5678, 20.9203, 50.0),
        },

        vehicles = {
            {
                model = "chino",
                label = "Chino",
                livery = 0,
                type = "car",
            },
            {
                model = "faction",
                label = "Faction",
                livery = 0,
                type = "car",
            },
        },

        blip = {
            enabled = false,
            sprite = 357,
            color = 5,
            scale = 0.6
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 1
        }
    },

}

--[[
PARAMETRES GLOBAUX DES GARAGES DE GANGS
]]
GangGarages.Settings = {
    markerDistance = 25.0,
    interactionDistance = 1.5,
    spawnCooldown = 3000,
    checkSpawnClear = true,
    maxSpawnAttempts = 10,
    spawnAttemptDelay = 100,
    deleteIfNoSpace = false,

    notifications = {
        vehicleSpawned = "Vehicule de gang sorti avec succes",
        vehicleStored = "Vehicule de gang range avec succes",
        vehicleDeleted = "Vehicule de gang supprime",
        noSpace = "Aucun emplacement disponible",
        alreadyOut = "Ce vehicule est deja dehors",
        maxReached = "Limite de vehicules atteinte",
        noPermission = "Vous n'avez pas la permission",
        notYourVehicle = "Ce vehicule n'appartient pas a votre groupe",
        wrongGarage = "Ce type de vehicule n'est pas accepte ici",
        notInGang = "Vous n'etes pas dans un groupe illegal"
    }
}

--[[
================================================================================
                            DOCUMENTATION
================================================================================

Pour ajouter un garage a un groupe illegal, copiez ce template dans
GangGarages.Gangs et adaptez les valeurs.

IMPORTANT: La cle doit correspondre exactement au nom du job2 du gang
(celui stocke dans la table gangs_new).

TYPES DE GARAGE:
- 'car'      : Vehicules terrestres (voitures, motos, camions)
- 'boat'     : Vehicules nautiques (bateaux, jet-ski)
- 'aircraft' : Vehicules aeriens (helicopteres, avions)

PERMISSIONS PAR GRADE:
Les grades de gang commencent generalement a 0 ou 1.
Le boss a toutes les permissions automatiquement.

================================================================================

    ['nom_du_gang'] = {
        -- Nom affiche dans le menu
        label = "Garage du Gang",

        -- Activer/desactiver le garage
        enabled = true,

        -- Type de garage: 'car', 'boat', 'aircraft'
        garageType = 'car',

        -- Point d'acces au menu (x, y, z, heading)
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),

        -- Point pour ranger les vehicules
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),

        -- Points de spawn des vehicules
        spawnPoints = {
            vector4(0.0, 0.0, 0.0, 0.0),
            vector4(0.0, 0.0, 0.0, 0.0),
        },

        -- Liste des vehicules disponibles
        vehicles = {
            {
                model = "sultan",
                label = "Sultan RS",
                livery = 0,
                type = "car",
            },
        },

        -- Configuration du blip sur la map
        blip = {
            enabled = false,
            sprite = 357,
            color = 1,
            scale = 0.6
        },

        -- Permissions par grade (0 = tous les grades)
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 1
        }
    },

================================================================================
]]

return GangGarages
