Config.DefaultAmmo = 50

-- Configuration des munitions pour les armes de base GTA V
Config.WeaponAmmo = {
    pistol = 'pistol_ammo',
    combatpistol = 'pistol_ammo',
    appistol = 'pistol_ammo',
    pistol50 = 'pistol_ammo',
    snspistol = 'pistol_ammo',
    -- SMG
    microsmg = 'smg_ammo',
    smg = 'smg_ammo',
    assaultsmg = 'smg_ammo',
    combatpdw = 'smg_ammo',
    machinepistol = 'smg_ammo',
    -- Fusils d'assaut
    assaultrifle = 'rifle_ammo',
    carbinerifle = 'rifle_ammo',
    advancedrifle = 'rifle_ammo',
    specialcarbine = 'rifle_ammo',
    bullpuprifle = 'rifle_ammo',
    -- Fusils à pompe
    pumpshotgun = 'shotgun_ammo',
    sawnoffshotgun = 'shotgun_ammo',
    assaultshotgun = 'shotgun_ammo',
    bullpupshotgun = 'shotgun_ammo',
    musket = 'shotgun_ammo',
    dbshotgun = 'shotgun_ammo',
    heavyshotgun = 'shotgun_ammo',
    -- Sniper
    sniperrifle = 'sniper_ammo',
    heavysniper = 'sniper_ammo',
    marksmanrifle = 'sniper_ammo',
}

Config.Weapons = {
    melee = {
        {name = 'Sucre d\'orge', price = 1500, model = 'WEAPON_CANDYCANE', img = 'https://docs.fivem.net/weapons/WEAPON_CANDYCANE.png'},
        {name = 'Pied-de-biche', price = 1500, model = 'WEAPON_CROWBAR', img = 'https://docs.fivem.net/weapons/WEAPON_CROWBAR.png'},
        {name = 'Club de golf', price = 1500, model = 'WEAPON_GOLFCLUB', img = 'https://docs.fivem.net/weapons/WEAPON_GOLFCLUB.png'},
        {name = 'Hache', price = 1500, model = 'WEAPON_STONE_HATCHET', img = 'https://docs.fivem.net/weapons/WEAPON_STONE_HATCHET.png'},
    },
    pistol = {
        {name = 'Berreta', price = 2500, model = 'WEAPON_PISTOL', img = 'https://docs.fivem.net/weapons/WEAPON_PISTOL.png'},
        {name = 'Desert Eagle', price = 5000, model = 'WEAPON_PISTOL50', img = 'https://docs.fivem.net/weapons/WEAPON_PISTOL50.png'},
        {name = 'Pistolet SNS', price = 1500, model = 'WEAPON_SNSPISTOL', img = 'https://docs.fivem.net/weapons/WEAPON_SNSPISTOL.png'},
    },
    smg = {
        {name = 'Micro SMG', price = 6000, model = 'WEAPON_MICROSMG', img = 'https://docs.fivem.net/weapons/WEAPON_MICROSMG.png'},
        {name = 'Machine Pistol', price = 6000, model = 'WEAPON_MACHINEPISTOL', img = 'https://docs.fivem.net/weapons/WEAPON_MACHINEPISTOL.png'},
    },
    shotgun = {
        {name = 'Canon scié', price = 8000, model = 'WEAPON_SAWNOFFSHOTGUN', img = 'https://docs.fivem.net/weapons/WEAPON_SAWNOFFSHOTGUN.png'},
    },
}