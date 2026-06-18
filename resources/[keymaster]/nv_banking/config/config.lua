Config = {}
Locales = Locales or {}
Config.Framework = "esx"
Config.MySQL = 'oxmysql'
Config.Language = 'fr'
Config.Drawtext = 'drawtext'
Config.BillingScript = 'esxdefault'
Config.newManagementSystem = false
Config.CreateJobAccount = false
Config.HideHUD = false

Config.ProfilePictureType = 'none'
Config.DefaultPP = ''
Config.Debug = false

Config.StartCreditPoint = 1000
Config.AvailableCredits = {
    {
        name = 'house',
        label = 'Crédit Immobilier',
        description = 'Ce crédit est parfait pour vous si vous cherchez une maison.',
        requiredCreditPoint = 2000,
        price = 300000,
        paybackPercent = 1.2,
        paybackTime = 1,
        color = '#FF3868',
        logo = './bank/dashboard/statistics/icons/transfer-given.png'
    },
    {
        name = 'vehicle',
        label = 'Crédit Automobile',
        description = 'Possédez votre première voiture grâce à la banque de Los Santos !',
        requiredCreditPoint = 300,
        price = 50000,
        paybackPercent = 1.2,
        paybackTime = 1,
        color = '#FF3868',
        logo = './bank/dashboard/statistics/icons/transfer-given.png'
    },
    {
        name = 'business',
        label = 'Crédit Professionnel',
        description = 'Lancez votre entreprise en créant votre société avec ce prêt',
        requiredCreditPoint = 1000,
        price = 100000,
        paybackPercent = 1.2,
        paybackTime = 1,
        color = '#FF3868',
        logo = './bank/dashboard/statistics/icons/transfer-given.png'
    }
}

Config.HackSettings = {
    LoginLimit = 3,
    WithdrawLimit = 1000
}

Config.FastActions = {
    { amount = 1000 },
    { amount = 2500 },
    { amount = 5000 },
    { amount = 10000 }
}

Config.SavingAccounts = {
    {
        name = 'account_1',
        label = 'Épargne Court Terme',
        description = '10% de Gains',
        cost = 100000,
        time = 48,
        percent = 10,
        color = '#F25975'
    },
    {
        name = 'account_2',
        label = 'Épargne Long Terme',
        description = '30% de Gains',
        cost = 100000,
        time = 124,
        percent = 30,
        color = '#F25975'
    },
    {
        name = 'account_3',
        label = 'Plan Débutant',
        description = '5% de Gains',
        cost = 50000,
        time = 24,
        percent = 5,
        color = '#4CAF50'
    },
    {
        name = 'account_4',
        label = 'Investissement Moyen Terme',
        description = '20% de Gains',
        cost = 150000,
        time = 72,
        percent = 20,
        color = '#2196F3'
    },
    {
        name = 'account_5',
        label = 'Plan Investissement VIP',
        description = '50% de Gains',
        cost = 500000,
        time = 240,
        percent = 50,
        color = '#FFD700'
    }
}

Config.GiveCreditPoint = {
    debtPaid = 1000
}

Config.BankLocations = {
    [1] = {
        Coords = vector3(149.9, -1040.46, 29.37),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
    [2] = {
        Coords = vector3(314.23, -278.83, 54.17),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
    [3] = {
        Coords = vector3(-350.8, -49.57, 49.04),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
    [4] = {
        Coords = vector3(-1213.0, -330.39, 37.79),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
    [5] = {
        Coords = vector3(-2962.71, 483.0, 15.7),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
    [6] = {
        Coords = vector3(1175.07, 2706.41, 38.09),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
    [7] = {
        Coords = vector3(242.23, 225.06, 106.29),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
    [8] = {
        Coords = vector3(-113.22, 6470.03, 31.63),
        Blipname = 'Banque',
        BlipType = 108,
        BlipColor = 2,
        BlipScale = 0.55
    },
}

Config.ATMs = {
    "prop_atm_01",
    "prop_atm_02",
    "prop_atm_03",
    "prop_fleeca_atm"
}

Config.Notification = function(msg, type, server, src)
    return
end
