SunnyDrugs = {
    Wait = 2000,
    Settings = {
        maxActiveSpawns = 5
    },
    Drugs = {
        ["weed"] = {
            ["recolte"] = {
                vector3(1919.312744, 5094.442871, 43.461361),
                vector3(1914.445190, 5087.546875, 44.673885),
                vector3(1913.323486, 5091.880859, 44.556637),
                vector3(1910.880371, 5087.284668, 45.233173),
                vector3(1903.853271, 5084.025391, 46.523808),
                vector3(1905.220215, 5079.729004, 46.531624),
                vector3(1900.948853, 5078.585938, 47.285782),
                vector3(1897.983765, 5073.399414, 48.081326),
                vector3(1893.063843, 5074.910156, 48.803791)
            },
            ["recolte1"] = {
                vec3(-622.713745, 2918.835449, 14.733567),
                vec3(-631.917419, 2918.109131, 14.731487),
                vec3(-633.262024, 2911.316650, 15.138457),
                vec3(-613.661377, 2923.028320, 14.556289),
                vec3(-615.768738, 2909.480225, 15.426668)
            },
            ["traitement"] = {
                vector3(576.96862792969, 2752.2248535156, 39.649398803711),
                vector3(572.43603515625, 2751.3930664062, 39.639366149902),
                vector3(571.39904785156, 2753.7102050781, 39.636768341064)
            }
        },

        ["meth_pills"] = {
            ["recolte"] = {
                vector3(5000, 5000, 5000)
            },
            ["traitement"] = {
                vec3(1389.103516, 3605.235352, 38.941891),
                vec3(1389.680908, 3603.434082, 38.941391),
                vec3(1394.410156, 3601.806396, 38.941933),
                vec3(1391.982910, 3605.867920, 38.941925),
                vec3(1389.801636, 3608.683838, 38.941925)
            }
        },

        ["coke"] = {
            ["recolte"] = {
                vector3(-746.621338, 4324.529297, 141.125916),
                vector3(-745.970642, 4319.456543, 140.938095),
                vector3(-750.725220, 4318.713867, 141.597076),
                vector3(-752.505249, 4314.186523, 142.247742),
                vector3(-747.882751, 4314.329590, 140.922272),
                vector3(-746.806885, 4324.418457, 141.149902)
            },
            ["recolte1"] = {
                vector3(5000, 5000, 5000)
            },
            ["traitement"] = {
                vector3(-36.339202880859, -2686.740234375, 6.0002341270447),
                vector3(-42.786464691162, -2695.9187011719, 6.0003929138184),
                vector3(-40.154571533203, -2692.8894042969, 6.04363489151),
                vector3(-41.9358253479, -2686.701171875, 6.0002379417419),
                vector3(-41.141212463379, -2700.4001464844, 6.1839456558228)
            }
        },

        ["meth_pure"] = {
            ["recolte"] = {
                vector3(110.962494, -3212.895752, 7.541922),
                vector3(111.214401, -3215.941895, 7.541922),
                vector3(115.145325, -3217.537354, 6.006779),
                vector3(115.030968, -3213.720703, 6.010869),
                vector3(114.947060, -3209.265137, 6.010605)
            },
            ["recolte1"] = {
                vector3(5000, 5000, 5000)
            },
            ["recolte2"] = {
                vector3(5000, 5000, 5000)
            },
            ["recolte3"] = {
                vector3(5000, 5000, 5000)
            },
            ["recolte4"] = {
                vector3(5000, 5000, 5000)
            },
            ["traitement"] = {
                vector3(2537.6765136719, 2626.2788085938, 30.520446777344),
                vector3(2543.1049804688, 2626.1643066406, 30.521722793579),
                vector3(2539.1083984375, 2621.4655761719, 30.513736724854),
                vector3(2552.1555175781, 2621.5026855469, 30.513998031616),
                vector3(2551.6044921875, 2626.2800292969, 30.520637512207),
                vector3(2534.7741699219, 2621.9367675781, 30.522352218628)
            }
        }
    },
    Items = {
        ["weed"] = {
            ["recolte"] = {
                name = "weed",
                label = "Weed",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = false,
                props = "prop_weed_01"
            },
            ["recolte1"] = {
                name = "terre",
                label = "Terre",
                animtype = "anim",
                animdict = "random@burial",
                anim = "a_burial",
                animtime = 2000,
                marker = false,
                props = "prop_pile_dirt_01"
            },
            ["traitement"] = {
                name = "weed_pooch",
                label = "Pochon de weed",
                animtype = "scenario",
                animdict = "PROP_HUMAN_BUM_BIN",
                anim = nil,
                animtime = 5000,
                marker = true,
                props = nil
            }
        },
        ["coke"] = {
            ["recolte"] = {
                name = "feuillecoca",
                label = "Feuille de Coca",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = false,
                props = "prop_plant_fern_02a"
            },
            ["recolte1"] = {
                name = "hydrochloric_acid",
                label = "Acide Chlorhydrique",
                animtype = "anim",
                animdict = "random@burial",
                anim = "a_burial",
                animtime = 2000,
                marker = false,
                props = "proc_stones_01"
            },
            ["traitement"] = {
                name = "coke_pooch",
                label = "Pochon de coke",
                animtype = "scenario",
                animdict = "PROP_HUMAN_BUM_BIN",
                anim = nil,
                animtime = 5000,
                marker = true,
                props = nil
            }
        },
        ["meth_pure"] = {
            ["recolte"] = {
                name = "phosphorerouge",
                label = "Phosphore rouge",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = true,
                props = "hei_prop_drug_statue_box_big"
            },
            ["recolte1"] = {
                name = "kq_lithium",
                label = "Pack de lithium",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = true,
                props = nil
            },
            ["recolte2"] = {
                name = "kq_ethanol",
                label = "Éthanol",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = true,
                props = nil
            },
            ["recolte3"] = {
                name = "hydrochloric_acid",
                label = "Acide Chlorhydrique",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = true,
                props = nil
            },
            ["recolte4"] = {
                name = "pure_meth_pills",
                label = "Pseudoéphédrine Pure",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = true,
                props = nil
            },
            ["traitement"] = {
                name = "methpure",
                label = "Méthamphétamine Pure",
                animtype = "scenario",
                animdict = "PROP_HUMAN_BUM_BIN",
                anim = nil,
                animtime = 5000,
                marker = true,
                props = nil
            }
        },
        ["meth_pills"] = {
            ["recolte"] = {
                name = "kq_meth_pills",
                label = "Pseudoéphédrine",
                animtype = "anim",
                animdict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                animtime = 2000,
                marker = true,
                props = nil
            },
            ["traitement"] = {
                name = "pure_meth_pills",
                label = "Pseudoéphédrine Pure",
                animtype = "scenario",
                animdict = "PROP_HUMAN_BUM_BIN",
                anim = nil,
                animtime = 5000,
                marker = true,
                props = nil
            }
        }
    },
    RandomZone = {},
    x = {},
    y = {},
    z = {},
    objSpawn = {},
    
    Ped = {
        Model = "s_m_y_dealer_01", 
        SpawnDistance = {min = 5, max = 10}, 
        Blip = {
            Sprite = 1,
            Colour = 1, 
            Scale = 0.4,
            Name = "Client"
        }
    },

    SaleItems = {
        -- Simple
        {item = "weed_pooch", label = "Weed", props = "prop_weed_block_01", anim = {"mp_common", "givetake2_a"}, minmoney = 105, maxmoney = 125},
        {item = "coke_pooch", label = "Cocaïne", props = "prop_coke_block_half_b", anim = {"mp_common", "givetake2_a"}, minmoney = 110, maxmoney = 135},
        {item = "hashish_pooch", label = "Hashish", props = "prop_weed_block_01", anim = {"mp_common", "givetake2_a"}, minmoney = 105, maxmoney = 125},
        {item = "kq_meth_pills", label = "Pseudoéphédrine", props = "p_meth_bag_01_s", anim = {"mp_common", "givetake2_a"}, minmoney = 50, maxmoney = 70},
        -- Avancé -- METH 27/01/2025
        {item = "methpure", label = "Méthamphétamine pure", props = "p_meth_bag_01_s", anim = {"mp_common", "givetake2_a"}, minmoney = 320, maxmoney = 350},
        {item = "cokepure", label = "Cocaïne pure", props = "p_meth_bag_01_s", anim = {"mp_common", "givetake2_a"}, minmoney = 230, maxmoney = 250},
        -- Camion
        {item = "kq_meth_low", label = "Méthamphétamine (Qualité basse)", props = "p_meth_bag_01_s", anim = {"mp_common", "givetake2_a"}, minmoney = 60, maxmoney = 75},
        {item = "kq_meth_mid", label = "Méthamphétamine (Qualité moyenne)", props = "p_meth_bag_01_s", anim = {"mp_common", "givetake2_a"}, minmoney = 75, maxmoney = 95},
        {item = "kq_meth_high", label = "Méthamphétamine (Haute qualité)", props = "p_meth_bag_01_s", anim = {"mp_common", "givetake2_a"}, minmoney = 95, maxmoney = 115}
    },

    BlackListedJobs = {
        ['police'] = true,
        ['sheriff'] = true,
        ['bcso'] = true,
        ['saspn'] = true,
        ['ambulance'] = true,
        ['gouvernement'] = true,
        ['gouv'] = true
    },

    AuthorizedPositions = {
        {x = -1345.102051, y = -1270.704224, z = 4.894472}, -- Position 1
        {x = 274.033691, y = 150.604980, z = 104.416214}, -- Position 2
        {x = 897.672424, y = -2350.440918, z = 30.481197}, -- Position 3
        {x = -955.104431, y = -2593.844727, z = 13.847948}, -- Position 4
        {x = 1692.284180, y = 4772.341797, z = 41.921246}, -- Position 5
        {x = -221.599167, y = 6347.479004, z = 32.094200},  -- Position 6
        {x = 1013.566956, y = -687.470703, z = 56.743320},  -- Position 7
        {x = -1617.190796, y = 195.583511, z = 60.292656},  -- Position 8
        -- {x = -440.917267, y = 7681.178223, z = 6.410784},    -- Position 9
        -- {x = 7020.097168, y = 484.150940, z = 57.881351},     -- Position 10
        -- {x = 1548.0007324219, y = 3696.7368164062, z = 34.47497177124}, -- Position 11
    },

    Blip = {
        sprite = 304,
        display = 4,
        scale = 0.5,
        color = 5,
        name = "Zone Fréquentée"
    },

    DistanceToSell = 3.0,

    sell = {
        Position = {}
    }
}
