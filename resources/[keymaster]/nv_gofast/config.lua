Config = {}

-- Configuration du Framework
Config.Framework = {
    Type = "esx",
    ResourceName = "es_extended",
    
    Inventory = {
        AddItem = function(playerId, itemName, quantity, metadata)
            if Config.Framework.Type == "standalone" then
                return true
            elseif Config.Framework.Type == "esx" then
                local ESX = exports[Config.Framework.ResourceName]:getSharedObject()
                local xPlayer = ESX.GetPlayerFromId(playerId)
                return xPlayer.addInventoryItem(itemName, quantity, metadata or {})
            elseif Config.Framework.Type == "qbcore" then
                local QBCore = exports[Config.Framework.ResourceName]:GetPlayer(playerId)
                return QBCore.Functions.AddItem(itemName, quantity, nil, metadata or {})
            end
        end,
        
        RemoveItem = function(playerId, itemName, quantity, metadata)
            if Config.Framework.Type == "standalone" then
                return true
            elseif Config.Framework.Type == "esx" then
                local ESX = exports[Config.Framework.ResourceName]:getSharedObject()
                local xPlayer = ESX.GetPlayerFromId(playerId)
                return xPlayer.removeInventoryItem(itemName, quantity, metadata or {})
            elseif Config.Framework.Type == "qbcore" then
                local QBCore = exports[Config.Framework.ResourceName]:GetPlayer(playerId)
                return QBCore.Functions.RemoveItem(itemName, quantity, nil, metadata or {})
            end
        end,
        
        GetItem = function(playerId, itemName)
            if Config.Framework.Type == "standalone" then
                return {count = 1}
            elseif Config.Framework.Type == "esx" then
                local ESX = exports[Config.Framework.ResourceName]:getSharedObject()
                local xPlayer = ESX.GetPlayerFromId(playerId)
                return xPlayer.getInventoryItem(itemName)
            elseif Config.Framework.Type == "qbcore" then
                local QBCore = exports[Config.Framework.ResourceName]:GetPlayer(playerId)
                local item = QBCore.Functions.GetItemByName(itemName)
                return item or {count = 0}
            end
        end
    },
    
    Money = {
        Add = function(playerId, amount, moneyType)
            if Config.Framework.Type == "standalone" then
                return true
            elseif Config.Framework.Type == "esx" then
                local ESX = exports[Config.Framework.ResourceName]:getSharedObject()
                local xPlayer = ESX.GetPlayerFromId(playerId)
                moneyType = moneyType or "money"
                xPlayer.addAccountMoney(moneyType, amount)
                return true
            elseif Config.Framework.Type == "qbcore" then
                local QBCore = exports[Config.Framework.ResourceName]:GetPlayer(playerId)
                moneyType = moneyType or "cash"
                QBCore.Functions.AddMoney(moneyType, amount)
                return true
            end
        end,
        
        Remove = function(playerId, amount, moneyType)
            if Config.Framework.Type == "standalone" then
                return true
            elseif Config.Framework.Type == "esx" then
                local ESX = exports[Config.Framework.ResourceName]:getSharedObject()
                local xPlayer = ESX.GetPlayerFromId(playerId)
                moneyType = moneyType or "money"
                local account = xPlayer.getAccount(moneyType)
                if amount <= account.money then
                    xPlayer.removeAccountMoney(moneyType, amount)
                    return true
                end
                return false
            elseif Config.Framework.Type == "qbcore" then
                local QBCore = exports[Config.Framework.ResourceName]:GetPlayer(playerId)
                moneyType = moneyType or "cash"
                local playerMoney = QBCore.PlayerData.money[moneyType]
                if amount <= playerMoney then
                    QBCore.Functions.RemoveMoney(moneyType, amount)
                    return true
                end
                return false
            end
        end
    },
    
    Notification = {
        Show = function(playerId, message, notificationType, duration)
            if Config.Framework.Type == "esx" then
                TriggerClientEvent("esx:showNotification", playerId, message)
            elseif Config.Framework.Type == "qbcore" then
                local typeMap = {
                    success = "success",
                    error = "error",
                    info = "primary"
                }
                TriggerClientEvent("QBCore:Notify", playerId, message, 
                    typeMap[notificationType] or "primary", duration or 5000)
            else
                TriggerClientEvent("nevaaagofast:showNotification", playerId, message, notificationType, duration)
            end
        end
    },
    
    JobCount = function(jobName)
        if Config.Framework.Type == "standalone" then
            return 1
        elseif Config.Framework.Type == "esx" then
            local ESX = exports[Config.Framework.ResourceName]:getSharedObject()
            local players = ESX.GetPlayers()
            local count = 0
            for _, playerId in pairs(players) do
                local xPlayer = ESX.GetPlayerFromId(playerId)
                if xPlayer and xPlayer.job.name == jobName then
                    count = count + 1
                end
            end
            return count
        elseif Config.Framework.Type == "qbcore" then
            local QBCore = exports[Config.Framework.ResourceName]:GetCoreObject()
            local players = QBCore.Functions.GetQBPlayers()
            local count = 0
            for _, player in pairs(players) do
                if player.PlayerData.job.name == jobName then
                    count = count + 1
                end
            end
            return count
        end
    end
}

-- Configuration de l'interface utilisateur
Config.UI = {}

-- Configuration du Go Fast
Config.GoFast = {
    -- Position et configuration du PNJ
    Pos = vector4(1553.1329, -2179.0022, 76.3028, 257.9766),
    
    NPC = {
        Model = "g_m_y_mexgoon_02",
        Scenario = "WORLD_HUMAN_SMOKING",
        Invincible = true,
        Weapon = "WEAPON_PISTOL",
        InitiallyBlocked = true,
        HostileOnRefuse = true
    },
    
    -- Configuration des interactions
    Interaction = {
        Distance = 4.0,
        NotificationDistance = 4.0,
        DetectionInterval = 250,
        InteractionKey = 51,
        NPCResetDistance = 40.0,
        RespawnDelay = 10000
    },
    
    -- Points de vente
    SellPoints = {
        -- Points proches (pour difficulté facile)
        vector3(1200.0, -1800.0, 40.0),  -- Proche du spawn (~400m)
        vector3(1700.0, -1500.0, 50.0),  -- Proche du spawn (~800m)
        vector3(1100.0, -2700.0, 50.0),  -- Proche du spawn (~600m)
        
        -- Points moyens (pour difficulté moyenne)
        vector3(1552.291748, 2194.185547, 78.877167),  -- ~4400m
        vector3(-93.68795, 2809.79248, 53.338741),     -- ~5000m
        vector3(2333.597412, 2579.971436, 46.667709),  -- ~4800m
        
        -- Points lointains (pour difficulté difficile)
        vector3(-2175.934326, 4271.188477, 49.009758), -- ~7000m
        vector3(287.13028, 6789.950195, 15.696222),    -- ~9000m
        vector3(1978.374512, 5171.522461, 47.639053)   -- ~7400m
    },
    
    -- Points d'apparition des véhicules
    SpawnPoints = {
        vector4(1560.2401, -2175.1426, 77.4333, 349.5103),
        vector4(1564.2998, -2175.9375, 77.4596, 350.1038),
        vector4(1559.8284, -2184.2090, 77.3212, 342.3871)
    },
    
    -- Configuration des difficultés
    Difficulty = {
        easy = {
            label = "Facile",
            money = {
                min = 1500,
                max = 2500
            },
            distance = {
                min = 200,   -- Très proche
                max = 1200   -- Court trajet
            },
            vehicles = {"asbo", "blista", "dilettante"},
            policeNotificationChance = 30,
            items = {
                chance = 5,
                min = 1,
                max = 2
            }
        },
        medium = {
            label = "Moyen",
            money = {
                min = 2500,
                max = 4000
            },
            distance = {
                min = 1200,  -- Trajet moyen
                max = 3500   -- Distance moyenne
            },
            vehicles = {"sultan2", "kuruma", "fugitive"},
            policeNotificationChance = 50,
            items = {
                chance = 10,
                min = 2,
                max = 4
            }
        },
        hard = {
            label = "Difficile",
            money = {
                min = 4000,
                max = 7000
            },
            distance = {
                min = 3500,  -- Long trajet
                max = 6000   -- Très longue distance
            },
            vehicles = {"sultan2r", "italigtb", "banshee2"},
            policeNotificationChance = 75,
            items = {
                chance = 15,
                min = 4,
                max = 7
            }
        }
    },
    
    -- Configuration des récompenses (utilisé si pas de difficulté sélectionnée)
    Reward = {
        Money = {
            Type = "cash",
            Min = 2350,
            Max = 4560
        },
        
        Items = {
            Enabled = true,
            Possibilities = {
                {
                    name = "weed_bag_og",
                    label = "Pochon de weed",
                    chance = 10,
                    min = 3,
                    max = 7
                },
                {
                    name = "coke_pooch",
                    label = "Pochon de coke",
                    chance = 5,
                    min = 3,
                    max = 5
                }
            }
        },
        
        Experience = {
            Enabled = false,
            Min = 10,
            Max = 30
        }
    },
    
    Vehicles = {
        Models = {"sultan2r", "oracle", "oracle2"},
        
        Customization = {
            RandomColor = true,
            RandomUpgrades = false,
            RandomPlate = true,
            PlatePrefix = "GOFAST"
        },
        
        SpawnEffects = {
            ParticleEffect = true,
            ParticleAsset = "core",
            ParticleName = "ent_ray_heli_aprtmnt_l_fire",
            SoundEffect = "FLIGHT_SCHOOL_LESSON_PASSED",
            SoundBank = "HUD_AWARDS"
        }
    },
    
    Items = {
        Required = false, -- Désactivé pour que ça marche sans items
        CheckInterval = 10,
        MaxTimeWithout = 120,
        Possibilities = {
            {
                name = "pochon_weed",
                label = "Pochon de Weed",
                minAmount = 1,
                maxAmount = 5
            },
            {
                name = "weed",
                label = "Weed",
                minAmount = 1,
                maxAmount = 5
            },
            {
                name = "weed_pooch",
                label = "Pochon de Weed",
                minAmount = 1,
                maxAmount = 5
            }
        }
    },
    
    -- Configuration de la mission
    Mission = {
        Duration = 900000, -- 15 minutes
        Cooldown = 86400,  -- 24 heures
        
        DeliveryEffects = {
            ParticleEffect = true,
            ParticleAsset = "scr_jewelheist",
            ParticleName = "scr_jewel_cab_smash",
            SoundEffect = "Mission_Pass_Notify",
            SoundBank = "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS",
            WaitTime = 2000
        }
    },
    
    -- Configuration de l'application de la loi
    LawEnforcement = {
        Notify = true,
        MinPlayers = 0,
        NotifiedJobs = {"police", "sheriff"},
        NotificationDelay = {
            Min = 30000,
            Max = 90000
        },
        NotificationChance = 75,
        BlipDuration = 60000,
        
        BlipSettings = {
            Sprite = 161,
            Color = 1,
            Scale = 1.0,
            Label = "Véhicule suspect signalé"
        }
    },
    
    -- Configuration des blips
    BlipSettings = {
        Sprite = 1,
        Scale = 1.0,
        Color = 5,
        Label = "Point de livraison",
        Route = true,
        RouteColor = 5
    },
    
    -- Configuration du debug
    Debug = {
        Enabled = false,
        ShowCoords = false,
        TestItem = false,
        LogLevel = 1
    }
}