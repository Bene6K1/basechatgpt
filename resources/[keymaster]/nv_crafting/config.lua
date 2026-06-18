Config = {}

Config.Framework = 'esx'
Config.Inventory = 'ox_inventory'
Config.CustomInventory = nil
Config.Target = 'nv_interact'
Config.MugshotResource = 'MugShotBase64'

Config.DeveloperMode = false
Config.CustomImageURL = false

Config.Celebration = {
    animDict = "anim@mp_player_intcelebrationmale@air_guitar",
    animName = "air_guitar"
}

Config.BenchAnimations = {
    putting_down_bench = {
        duration = 5000,
        animDict = 'amb@world_human_hammering@male@base',
        anim = 'base',
        flag = 1
    },
    moving_bench = {
        duration = 1000,
        animDict = 'amb@world_human_hammering@male@base',
        anim = 'base',
        flag = 1
    }
}

Config.LevelValues = {
    xpGainMultiplier = 10,
    levelUpXPMultiplier = 100,
    loseMultiplier = 0.5
}

Config.MainRoutingBucket = 0

Config.Benches = {
    onlyOwnerCanMove = true,
    enableBenches = true,
    enablePersistentBenches = true,
    HideBenchDistance = 50,
    benchTypes = {
        ['weapon-crafting_bench'] = {
            benchProp = 'prop_tool_bench02',
            benchLabel = "Banc d'armes",
            title = "Atelier d'armes",
            secondaryTitle = "Neva",
            nonBlueprintItems = {
                ["weapon_knife"] = {
                    type = 'weapon',
                    itemLevel = 1,
                    baseOdds = 50,
                    maxOdds = 90,
                    amountToCraft = 1,
                    requirements = {
                        { item = "metalscrap", amount = 10 },
                        { item = "steel", amount = 5 },
                        { item = "rubber", amount = 2 },
                        { item = "iron", amount = 3 },
                        { item = "aluminium", amount = 2 }
                    }
                }
            }
        }
    },
    benchPlacement = {
        enabled = true,
        mode = 'blacklist',
        zones = {
            {
                vectors = {
                    vector3(494.22534179688, -1328.0008544922, 29),
                    vector3(494.7057800293, -1333.9619140625, 29),
                    vector3(500.11663818359, -1335.0971679688, 29),
                    vector3(498.75512695312, -1328.3658447266, 29),
                    vector3(499.08578491211, -1326.0651855469, 29)
                },
                height = 10
            },
            {
                vectors = {
                    vector3(493.93173217773, -1335.25, 29)
                },
                radius = 5.0
            }
        }
    }
}

Config.Blueprints = {
    store = 'player',
    items = {
        ["weapon_pistol"] = {
            bench = 'weapon-crafting_bench',
            type = 'weapon',
            itemLevel = 1,
            baseOdds = 60,
            maxOdds = 90,
            amountToCraft = 1,
            requirements = {
                { item = "metalscrap", amount = 10 },
                { item = "steel", amount = 5 }
            }
        }
    }
}

Config.CustomBlueprints = {
    ['weapon_pistol'] = {
        customBlueprintName = 'blueprint_weapon_pistol'
    }
}

Config.Stations = {
    HideStationDistance = 50,
    ["weapon_station"] = {
        title = "Atelier d'armes",
        secondaryTitle = "NEVA",
        blip = {
            haveBlip = true,
            sprite = 110,
            color = 1,
            scale = 0.8,
            coords = vector3(1444.1385, 6332.3174, 23.9599)
        },
        target = {
            type = "npc",
            model = "s_m_m_ammucountry",
            coords = vector3(1444.1385, 6332.3174, 23.9599),
            heading = 37.18
        },
        groups = {
            jobs = {},
            gangs = {}
        },
        access = {
            gangCategories = { 'gangs', 'mc', 'orga', 'mafia', 'cartel' }
        },
        items = {
            ["weapon_assaultrifle_mk2"] = {
                type = 'weapon',
                itemLevel = 3,
                baseOdds = 20,
                maxOdds = 70,
                amountToCraft = 1,
                requirements = {
                    { item = "metalscrap", amount = 20 },
                    { item = "steel", amount = 10 },
                    { item = "iron", amount = 10 },
                    { item = "plastic", amount = 8 },
                    { item = "copper", amount = 5 }
                }
            },
            ["weapon_pistol"] = {
                type = 'weapon',
                itemLevel = 1,
                baseOdds = 70,
                maxOdds = 90,
                requirements = {
                    { item = "copper", amount = 5 }
                }
            }
        }
    }
}

Config.ResourcePoints = {
    enabled = true,
    renderDistance = 40.0,
    interactionDist = 1.5,
    interactionOffset = 0.4,
    interactionLabel = "Récolter",
    progressLabel = "Récolte en cours...",
    disableControls = true,
    defaultDuration = 6500,
    defaultReward = { min = 1, max = 3 },
    exclusive = true,
    exclusiveCooldown = 5,
    markerDistance = 20.0,
    marker = {
        type = 1,
        scale = { x = 1.8, y = 1.8, z = 0.35 },
        color = { r = 255, g = 255, b = 255, a = 170 },
        bob = false,
        face = true,
        rotate = false,
        offset = { x = 0.0, y = 0.0, z = -0.8 }
    },
    defaultAnimation = {
        dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        clip = "machinic_loop_mechandplayer",
        flag = 1
    },
    points = {
        iron = {
            label = "Filon de fer",
            item = "iron",
            coords = vector3(-572.6667, -1611.2550, 27.0108),
            reward = { min = 1, max = 3 }
        },
        metalscrap = {
            label = "Tas de ferraille",
            item = "metalscrap",
            coords = vector3(1186.1985, -1230.2313, 35.1488),
            reward = { min = 2, max = 4 }
        },
        plastic = {
            label = "Déchets plastiques",
            item = "plastic",
            coords = vector3(1739.1211, 3325.2000, 41.2235),
            reward = { min = 1, max = 2 }
        },
        steel = {
            label = "Plaques d'acier",
            item = "steel",
            coords = vector3(175.9837, 306.0649, 105.3713),
            reward = { min = 1, max = 2 }
        },
        copper = {
            label = "Minerai de cuivre",
            item = "copper",
            coords = vector3(115.9815, -3224.3667, 5.80),
            reward = { min = 1, max = 3 }
        }
    }
}