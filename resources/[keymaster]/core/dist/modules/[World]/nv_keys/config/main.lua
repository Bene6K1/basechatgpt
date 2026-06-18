return {
    Debug = false,
    AutoRunSQL = true,

    Locale = 'fr',

    Target = 'nv_interact',
    Notify = 'notif',
    UIType = 'rageui',

    LockDistance = 8.0,
    GetKeysWhenEngineIsRunning = false,

    Metadata = true,
    VehicleKeys = {
        itemName = 'vehiclekeys',
    },

    Animations = {
        ["toggle_lock"] = {
            dict = 'anim@mp_player_intmenu@key_fob@',
            anim = 'fob_click',
            time = 500,
            bone = 57005,
            coords = vector3(0.0, 0.0, 0.0),
            rotation = vector3(0.0, 0.0, 0.0),
        },
        ["hold_in_hand"] = {
            dict = 'cellphone@',
            anim = 'cellphone_text_read_base_cover_low',
            time = 500,
            bone = 57005,
            coords = vector3(0.092864345294629, -0.005128122551559, -0.026256413727468),
            rotation = vector3(15.46036809602, -6.3832143950323, 9.3262711409414),
        },
        ["search_keys"] = {
            dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            anim = 'machinic_loop_mechandplayer',
        },
        ["holdup"] = {
            dict = 'mp_am_hold_up',
            anim = 'holdup_victim_20s',
        },
        ["hotwire_invehicle"] = {
            dict = 'anim@veh@plane@seabreeze@front@ds@base',
            anim = 'hotwire'
        },
        ["hotwire_outsidevehicle"] = {
            dict = 'anim@veh@boat@marquis@ds@base',
            anim = 'hotwire'
        },
    },

    Sounds = {
        ["toggle_lock"] = {
            status = true,
            soundfile = 'lock',
        },
        ["hold_in_hand"] = {
            status = true,
            soundfile = 'keys',
        },
    },

    Commands = {
        ['togglelocks'] = {
            name = 'togglelocks',
            description = 'Toggle Locks',
        },
        ['engine'] = {
            name = 'engine',
            description = 'Toggle Engine',
        },
    },

    Keys = {
        ['togglelocks'] = 'L',
        ['engine'] = 'G',
        ['locksmith'] = {
            index = 38,
            name = 'E'
        },
    },

    LockNPCDrivingCars = false,
    LockNPCParkedCars = false,

    Locksmiths = {
        {
            model = `s_m_m_cntrybar_01`,
            coords = vector4(88.97, -222.37, 53.64, 341.91)
        },
        {
            model = `s_m_m_cntrybar_01`,
            coords = vector4(245.83, 371.85, 105.74, 163.7)
        }
    },

    LocksmithBlip = {
        enabled = true,
        sprite = 134,
        colour = 3,
        scale = 0.8,
        label = 'Serrurier Véhicules'
    },

    LocksmithPrices = {
        firstKey = 0,
        duplicateKey = 1500,
    },
    NewKeyPrice = 1500,
    NewLockPrice = 1000,

    Carjack = {
        status = false,
        time = 7000,
        delay = 10000,
        alarm = {
            enabled = true,
            duration = 10000,
            checkInterval = 2000,
        },
        chance = {
            [2685387236] = 0.99,
            [416676503] = 0.99,
            [-957766203] = 0.99,
            [860033945] = 0.99,
            [970310034] = 0.90,
            [1159398588] = 0.99,
            [3082541095] = 0.99,
            [2725924767] = 0.99,
            [1548507267] = 0.99,
            [4257178988] = 0.99,
        }
    },

    Lockpick = {
        normal = {
            itemName = 'lockpick',
            removeChance = 0,
        },
        advanced = {
            itemName = 'advancedlockpick',
            removeChance = 0,
        },
    },

    Hotwire = {
        status = false,
        timeBetween = 3000,
        minTime = 6000,
        maxTime = 12000,
        chance = 0.50,
        keysChance = 0.10,
    },

    SharedKeys = {
        status = false,
        jobs = {}
    },

    CompanyVehicles = {
        ignoreKeys = true,
        ownerPrefixes = { 'society_' },
    },

    ImmuneVehicles = {
        'stockade'
    },

    IgnoreBicycles = true,

    NoLockVehicles = {},

    NoCarjackWeapons = {
        "WEAPON_UNARMED",
        "WEAPON_Knife",
        "WEAPON_Nightstick",
        "WEAPON_HAMMER",
        "WEAPON_Bat",
        "WEAPON_Crowbar",
        "WEAPON_Golfclub",
        "WEAPON_Bottle",
        "WEAPON_Dagger",
        "WEAPON_Hatchet",
        "WEAPON_KnuckleDuster",
        "WEAPON_Machete",
        "WEAPON_Flashlight",
        "WEAPON_SwitchBlade",
        "WEAPON_Poolcue",
        "WEAPON_Wrench",
        "WEAPON_Battleaxe",
        "WEAPON_Grenade",
        "WEAPON_StickyBomb",
        "WEAPON_ProximityMine",
        "WEAPON_BZGas",
        "WEAPON_Molotov",
        "WEAPON_FireExtinguisher",
        "WEAPON_PetrolCan",
        "WEAPON_Flare",
        "WEAPON_Ball",
        "WEAPON_Snowball",
        "WEAPON_SmokeGrenade",
    }
}
