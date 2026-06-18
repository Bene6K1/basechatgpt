Config = {
    Open = {
        command = {
            enable = true,
            name = "mdt",
        },
        item = {
            enable = false,
            name = "mdt",
        }
    },
    MoneySymbol = "$", -- this is for the money symbol
    Framework = "oldesx", --esx, oldesx, qb, newqb
    SQLScript = "oxmysql", --ghmattimysql, mysql-async, oxmysql
    discordWebhook = "WEBHOOK_HERE", -- this is for uploading photos to discord
    DefaultAvatar = "https://i.ibb.co/wNK1kd19/grey-avatar-icon-user-avatar-photo-icon-social-media-user-icon-vector-removebg-preview.png",
    DefaultVehicleAvatar = "https://www.shutterstock.com/image-vector/white-cute-car-icon-heading-600w-568159381.jpg",
    Prefix = "!", -- this is for the prefix of blips you can set it as "" if you dont want one
    CrimeTags = {
        [1] = {label = "Aucun"},
        [2] = {label = "Suspect"},
        [3] = {label = "Meurtrier"},
        [4] = {label = "Contrebandier"},
        [5] = {label = "Voleur"},
    },
    Permissions = {
        addMessage = {'15', 'achief', 'officer', 'sergent', 'capitaine'},
        addFines = {'15', 'achief', 'officer', 'sergent', 'capitaine'},
        editFines = {'15', 'achief', 'officer', 'sergent', 'capitaine'},
    },
    Department = {
        image = 'https://i.ibb.co/qL40YxD2/image-1.jpg',
        name = 'LSPD',
        totalBans = 0,
        totalPersonal = ('%s/750'),
        location = 'Vespucci Boulevard',
        description = 'LSPD is the police department of Los Santos.',
    },
    Jobs = {
        ["police"] = {
            ableToUse = true,
            mapColor = "blue" -- only blue, orange, red, purple
        },
        ["saspn"] = {
            ableToUse = true,
            mapColor = "orange"
        },
        ["ambulance"] = {
            ableToUse = false,
            mapColor = "red"
        },
    },
    PanicTypes = {
        ["safe"] = {
            blipData = {
                sprite = 1,
                color = 18,
                scale = 1.5,
                blipDuration = 30, -- seconds
            }
        },
        ["normal"] = {
            blipData = {
                sprite = 1,
                color = 5,
                scale = 1.7,
                blipDuration = 45, -- seconds
            }
            
        },
        ["emergency"] = {
            blipData = {
                sprite = 1,
                color = 1,
                scale = 1.9,
                blipDuration = 60, -- seconds
            }
        }
    },
    LicenseTypes = {
        ["dmv"] = true
    },
    Cameras = {
        {
            id = 1,
            title = "Poste de police",
            image = "https://i.ibb.co/qL40YxD2/image-1.jpg",
            coords = vector3(-1113.258179, -830.368835, 21.323374),
            rotation = vector3(0.0, 0.0, 261.0),
            fov = 60.0,
            canRotate = true,
            canMove = true,
            canZoom = true,
        },
        {
            id = 2,
            title = "Poste de police (exterieur)",
            image = "https://i.ibb.co/ycMQvR9m/image-3.jpg",
            coords = vector3(-1116.3725585938, -827.23156738281, 25.858589172363),
            rotation = vector3(0.0, 0.0, 352.68981933594),
            fov = 60.0,
            canRotate = true,
            canMove = true,
            canZoom = true,
        },
        {
            id = 3,
            title = "Base militaire",
            image = "https://i.ibb.co/Pv8BnwpW/image-2.jpg",
            coords = vector3(-2352.9704589844, 3239.7922363281, 84.139167785645),
            rotation = vector3(0.0, 0.0, 217.35050964355),
            fov = 60.0,
            canRotate = true,
            canMove = true,
            canZoom = true,
        },
        {
            id = 4,
            title = "BCSO & EMS (Sandy)",
            image = "https://i.ibb.co/SwHBh1GS/image-4.jpg",
            coords = vector3(1808.1589355469, 3596.7060546875, 41.108406066895),
            rotation = vector3(0.0, 0.0, 13.43615436554),
            fov = 60.0,
            canRotate = true,
            canMove = true,
            canZoom = true,
        },
        {
            id = 5,
            title = "BCSO (Paleto)",
            image = "https://i.ibb.co/TXp41P8/image-5.jpg",
            coords = vector3(-393.24395751953, 6014.6469726562, 39.47518157959),
            rotation = vector3(0.0, 0.0, 97.846702575684),
            fov = 60.0,
            canRotate = true,
            canMove = true,
            canZoom = true,
        },
    },
    JobGrades = {
        [1] = "Recrue",
        [2] = "Cadet", 
        [3] = "Officer I",
        [4] = "Officer II",
        [5] = "Officer III",
        [6] = "Detective I",
        [7] = "Detective II",
        [8] = "Sergent I",
        [9] = "Sergent II",
        [10] = "Lieutenant",
        [11] = "Capitaine",
        [12] = "Commandant",
        [13] = "Deputy Chief",
        [14] = "Assistant Chief",
        [15] = "Chief of Police"
    },
    Dispatches = {
        StealVehicle = true,
        GunShot = true,
    }
}

Config.UsersTable = (Config.Framework == "esx" or Config.Framework == "oldesx") and "users" or "players"
Config.VehiclesTable = (Config.Framework == "esx" or Config.Framework == "oldesx") and "owned_vehicles" or "player_vehicles"

for i = 1, #Config.CrimeTags do
    Config.CrimeTags[i].value = tostring(i)
end

Config.Locales = Locales