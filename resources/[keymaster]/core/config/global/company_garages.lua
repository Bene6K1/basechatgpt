CompanyGarages = {}

CompanyGarages.Companies = {

    ['police'] = {
        label = "Garage Police LSPD",
        enabled = true,
        garageType = 'car',

        accessPoint = vector4(-1061.8634, -871.6503, 5.2695, 216.6396),
        deletePoint = vector4(-1050.0934, -854.7744, 4.8705, 314.2385),
        spawnPoints = {
            vector4(-1061.6525, -853.7734, 4.8688, 218.5643),
            vector4(-1055.6633, -848.8885, 4.8676, 215.1122),
        },

        vehicles = {
            {
                model = "polsilverado19",
                label = "polsilverado19",
                livery = 0,
                type = "car",
            },
            {
                model = "polrs6",
                label = "polrs6",
                livery = 0,
                type = "car",
            },
            {
                model = "polmustang",
                label = "polmustang",
                livery = 0,
                type = "car",
            },
            {
                model = "polgt63",
                label = "polgt63",
                livery = 0,
                type = "car",
            },
            {
                model = "poldurango",
                label = "poldurango",
                livery = 0,
                type = "car",
            },
            {
                model = "polcoach",
                label = "polcoach",
                livery = 0,
                type = "car",
            },
            {
                model = "polbmwm3",
                label = "polbmwm3",
                livery = 0,
                type = "car",
            },
            {
                model = "polbmwm5",
                label = "polbmwm5",
                livery = 0,
                type = "car",
            },
            {
                model = "polbmwm7",
                label = "polbmwm7",
                livery = 0,
                type = "car",
            },
        },

        blip = {
            enabled = false,
            sprite = 357,
            color = 3,
            scale = 0.7
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 3
        }
    },

    ['police_aircraft'] = {
        label = "Héliport Police LSPD",
        enabled = true,
        garageType = 'aircraft',

        accessPoint = vector4(-1102.4553, -844.6912, 37.6801, 137.4521),
        deletePoint = vector4(-1108.2341, -842.1234, 37.6801, 220.1234),
        spawnPoints = {
            vector4(-1096.5432, -835.1234, 37.6801, 137.4521),
        },

        vehicles = {
            {
                model = "polheli",
                label = "Hélicoptère Police",
                livery = 0,
                type = "aircraft",
            },
        },

        blip = {
            enabled = false,
            sprite = 557,
            color = 3,
            scale = 0.7
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 3
        }
    },

    ['ambulance'] = {
        label = "Garage EMS",
        enabled = true,
        garageType = 'car',

        accessPoint = vector4(-466.6842, -1021.4008, 24.2888, 208.6382),
        deletePoint = vector4(-459.4562, -1002.8535, 24.2888, 3.7910),

        spawnPoints = {
            vector4(-457.3567, -1016.2652, 24.2888, 2.0044),
            vector4(-464.7488, -988.1301, 24.2888, 180.1656),
            vector4(-456.3881, -988.3658, 24.2888, 185.7303),
        },

        vehicles = {
            {
                model = "DLAmbulance",
                label = "DLAmbulance",
                livery = 0,
                type = "car",
            },
            {
                model = "DLAmbulance2",
                label = "DLAmbulance2",
                livery = 0,
                type = "car",
            },
            {
                model = "DLAmbulance3",
                label = "DLAmbulance3",
                livery = 0,
                type = "car",
            },
            {
                model = "DLM5EMS",
                label = "DLM5EMS",
                livery = 0,
                type = "car",
            },
            {
                model = "DLM7EMS",
                label = "DLM7EMS",
                livery = 0,
                type = "car",
            },
            {
                model = "DLRAMEMS",
                label = "DLRAMEMS",
                livery = 0,
                type = "car",
            },
            {
                model = "DLRS6EMS",
                label = "DLRS6EMS",
                livery = 0,
                type = "car",
            },
            {
                model = "DLRS7EMS",
                label = "DLRS7EMS",
                livery = 0,
                type = "car",
            },
            {
                model = "DLRSQ8EMS",
                label = "DLRSQ8EMS",
                livery = 0,
                type = "car",
            },
            {
                model = "DLX5EMS",
                label = "DLX5EMS",
                livery = 0,
                type = "car",
            },
            {
                model = "DLYAMAHAEMS",
                label = "DLYAMAHAEMS",
                livery = 0,
                type = "car",
            },
        },

        blip = {
            enabled = false,
            sprite = 357,
            color = 1,
            scale = 0.7
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 2
        }
    },

    ['mecano'] = {
        label = "Garage Mécano",
        enabled = true,
        garageType = 'car',

        accessPoint = vector4(-197.5549, -1390.5389, 31.2437, 336.3204),
        deletePoint = vector4(-192.9253, -1380.5936, 31.2642, 12.9608),
        spawnPoints = {
            vector4(-214.7775, -1395.4924, 31.2655, 300.1782),
            vector4(-204.2690, -1389.1039, 31.2543, 301.5570),
        },

        vehicles = {
            {
                model = "flatbed",
                label = "Dépanneuse Flatbed",
                livery = 0,
                type = "car",
            },
            {
                model = "towtruck",
                label = "Dépanneuse Standard",
                livery = 0,
                type = "car",
            },
            {
                model = "utillitruck3",
                label = "Utilitaire Mécano",
                livery = 0,
                type = "car",
            },
        },

        blip = {
            enabled = false,
            sprite = 357,
            color = 5,
            scale = 0.7
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 2
        }
    },
    ['avocat'] = {
        label = "Garage Avocat",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['boatseller'] = {
        label = "Garage Concessionnaire Bteau",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['burgershot'] = {
        label = "Garage BurgerShot",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['cardealer'] = {
        label = "Garage Concessionnaire",
        enabled = false,
        accessPoint = vector4(-1417.4956, -952.5395, 5.0842, 318.4226),
        deletePoint = vector4(-1426.0269, -956.5660, 5.0522, 137.6060),
        spawnPoints = {
            vector4(-1434.0645, -965.8674, 5.0507, 138.2732),
            vector4(-1426.4504, -957.0253, 5.0524, 136.8335),
        },
        vehicles = {
            {
                model = "amggtbs",
                label = "amggtbs",
                livery = 0,
            },
            {
                model = "16topcargle",
                label = "16topcargle",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['chickenbell'] = {
        label = "Garage ChickenBell",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['churchtown'] = {
        label = "Garage ChurchTown",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['delivery'] = {
        label = "Garage Delivery",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['fib'] = {
        label = "Garage FIB",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['fisherman'] = {
        label = "Garage Pêcheur",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['fueler'] = {
        label = "Garage Raffineur",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['gouv'] = {
        label = "Garage Gouvernement",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['jardinier'] = {
        label = "Garage Jardinier",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['journalist'] = {
        label = "Garage Journaliste",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['label'] = {
        label = "Garage RA Records",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['lumberjack'] = {
        label = "Garage Bûcheron",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['mecano2'] = {
        label = "Garage Ls Custom",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['miner'] = {
        label = "Garage Mineur",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['night77'] = {
        label = "Garage Night 77",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['planeseller'] = {
        label = "Garage Concessionnaire Aéronotique",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['realestateagent'] = {
        label = "Garage Agent immobilier",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['slaughterer'] = {
        label = "Garage Abateur",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['tacos'] = {
        label = "Garage Tacos",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['tailor'] = {
        label = "Garage Couturier",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['taxi'] = {
        label = "Garage Taxi",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['tequilala'] = {
        label = "Garage Tequilala",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['unicorn'] = {
        label = "Garage Unicorn",
        enabled = false,
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(-244.1402, -564.7594, 34.4108, 91.1796),
            vector4(-241.4286, -560.2973, 34.4483, 241.7480),
        },
        vehicles = {
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
            {
                model = "sultan",
                label = "Sultan",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
    ['vigneron'] = {
        label = "Garage Vigneron",
        enabled = false,
        accessPoint = vector4(-1925.3003, 2046.9510, 140.8315, 300.4884),
        deletePoint = vector4(-1920.7344, 2048.6152, 140.7349, 258.5237),
        spawnPoints = {
            vector4(-1920.7344, 2048.6152, 140.7349, 258.5237),
            vector4(-1921.5405, 2044.3895, 140.7349, 256.3877),
        },
        vehicles = {
            {
                model = "yosemite3",
                label = "yosemite3",
                livery = 0,
            },
            {
                model = "speedo",
                label = "speedo",
                livery = 0,
            },
        },
        blip = {
            enabled = false,
            sprite = 357,
            color = 0,
            scale = 0.7
        },
        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 0
        }
    },
}

CompanyGarages.PublicGarages = {
    useExistingSystem = true,
    impoundPrice = 500,
    impoundPriceVIP = 0,
    maxVehiclesPerPlayer = 50,
}

CompanyGarages.Settings = {
    markerDistance = 30.0,
    interactionDistance = 1.5,
    spawnCooldown = 2000,
    checkSpawnClear = true,
    maxSpawnAttempts = 10,
    spawnAttemptDelay = 100,
    deleteIfNoSpace = false,

    notifications = {
        vehicleSpawned = "✅ Véhicule sorti avec succès",
        vehicleStored = "✅ Véhicule rangé avec succès",
        vehicleDeleted = "🗑️ Véhicule supprimé",
        noSpace = "❌ Aucun emplacement disponible",
        alreadyOut = "❌ Ce véhicule est déjà dehors",
        maxReached = "❌ Limite de véhicules atteinte",
        noPermission = "❌ Vous n'avez pas la permission",
        notYourVehicle = "❌ Ce véhicule ne vous appartient pas",
        wrongGarage = "❌ Ce type de véhicule n'est pas accepté ici"
    }
}

--[[
================================================================================
                            EXEMPLE DE CONFIGURATION
================================================================================

Pour ajouter un nouveau garage d'entreprise, copiez ce template dans
CompanyGarages.Companies et adaptez les valeurs.

TYPES DE GARAGE:
- 'car'      : Véhicules terrestres (voitures, motos, camions)
- 'boat'     : Véhicules nautiques (bateaux, jet-ski)
- 'aircraft' : Véhicules aériens (hélicoptères, avions)

GARAGES VARIANTES:
Pour séparer les véhicules par type (ex: garage voiture + héliport),
utilisez le format: 'jobname_type' (ex: 'police_aircraft')
Les employés du job parent auront automatiquement accès aux variantes.

================================================================================

    ['exemple'] = {
        -- Nom affiché dans le menu
        label = "Garage Exemple",

        -- Activer/désactiver le garage
        enabled = true,

        -- Type de garage: 'car', 'boat', 'aircraft'
        garageType = 'car',

        -- Point d'accès au menu (x, y, z, heading)
        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),

        -- Point pour ranger les véhicules
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),

        -- Points de spawn des véhicules (plusieurs = rotation aléatoire)
        spawnPoints = {
            vector4(0.0, 0.0, 0.0, 0.0),
            vector4(0.0, 0.0, 0.0, 0.0),
        },

        -- Liste des véhicules disponibles
        vehicles = {
            {
                model = "sultan",           -- Nom du spawn
                label = "Sultan RS",        -- Nom affiché
                livery = 0,                 -- Livrée par défaut
                type = "car",               -- Type: 'car', 'boat', 'aircraft'
            },
            {
                model = "polheli",
                label = "Hélicoptère",
                livery = 0,
                type = "aircraft",
            },
        },

        -- Configuration du blip sur la map
        blip = {
            enabled = false,                -- Afficher le blip
            sprite = 357,                   -- Icône (357=garage, 427=bateau, 557=avion)
            color = 3,                      -- Couleur
            scale = 0.7                     -- Taille
        },

        -- Permissions par grade (0 = tous les grades)
        permissions = {
            spawnVehicle = 0,               -- Grade min pour sortir
            storeVehicle = 0,               -- Grade min pour ranger
            deleteVehicle = 3               -- Grade min pour supprimer
        }
    },

    -- Exemple: Héliport séparé pour le même job
    ['exemple_aircraft'] = {
        label = "Héliport Exemple",
        enabled = true,
        garageType = 'aircraft',

        accessPoint = vector4(0.0, 0.0, 0.0, 0.0),
        deletePoint = vector4(0.0, 0.0, 0.0, 0.0),
        spawnPoints = {
            vector4(0.0, 0.0, 0.0, 0.0),
        },

        vehicles = {
            {
                model = "polheli",
                label = "Hélicoptère",
                livery = 0,
                type = "aircraft",
            },
        },

        blip = {
            enabled = false,
            sprite = 557,
            color = 3,
            scale = 0.7
        },

        permissions = {
            spawnVehicle = 0,
            storeVehicle = 0,
            deleteVehicle = 3
        }
    },

================================================================================
]]

return CompanyGarages
