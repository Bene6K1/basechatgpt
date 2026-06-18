Config = {}

Config.DefaultCoins = 1000
Config.EnableWeapons = true

Config.Commands = {
    givecoins = 'givecoins',
    resetoffer = 'resetoffer',
    shop = 'shop'
}

Config.SpecialOffer = {
    enabled = false,
    type = 'case',
    caseId = 'bronze',
    discount = 50,
    label = 'Caisse Bronze -50%',
    description = 'Profitez de 50% de réduction sur la Caisse Bronze !',
    icon = './img/cases/bronze_case.png',
    durationDays = 7
}