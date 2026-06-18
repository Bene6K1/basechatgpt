Config = {}
Config.Locale = 'fr'

Config.IpLock = "sunnyhill"

-- Configuration pour ox_inventory
Config.CustomInventory = "ox"  -- Active ox_inventory au lieu de l'inventaire ESX par défaut

Config.DefaultGroup = 'user'
Config.DefaultLevel = '0'
Config.CommandPrefix = '/'
Config.DefaultPosition = vector3(437.053802, -624.312073, 28.708279)
Config.serverName = GetConvar('ServerName', ' ')

SunnyConfig = {
LogoUrl = "https://r2.fivemanage.com/Xn3liC3UXPMlRlgbzX17D/image.png",

------ COLOR ------
R = 11,
G = 118,
B = 254,
A = 255, 

}
Config.Accounts = {
	['cash'] = {
		label = "Argent (Propre)",
		starting = 3000,
		priority = 1
	},
	['black_money'] = {
		label = "Argent (Sale)",
		starting = 0,
		priority = 2
	},
	['bank'] = {
		label = "Argent (Banque)",
		starting = 5000,
		priority = 3
	},
	['chip'] = {
		label = 'Jetons Casino',
		starting = 0,
		priority = 4
	},
    ['pesos'] = {
		label = 'Peso',
		starting = 500,
		priority = 5
	}
}


Config.EnableSocietyPayouts = false
Config.PaycheckInterval = 30 * 60 * 1000 
Config.MaxWeight = 50 

Config.ArmesPerms = {
    ['WEAPON_AWPREDLINE'] = true,
    ['WEAPON_AK47NEONRIDE'] = true,
    ['WEAPON_VICTUSXMR'] = true,
    ['WEAPON_M6IC'] = true,
    ['WEAPON_AR15'] = true,
    ['WEAPON_FN509'] = true,
    ['WEAPON_MP5SDFM'] = true,
    ['WEAPON_HONEYBADGERCOD'] = true,
    ['WEAPON_MCXSPEAR'] = true,
    ['WEAPON_GLITCHPOPVANDAL'] = true,
    ['WEAPON_SCAR17FM'] = true,
    ['WEAPON_HKUMP'] = true,
    ['WEAPON_FIREAXE'] = true,
    ['WEAPON_BREN'] = true,
    ['WEAPON_VP9'] = true,
    ['WEAPON_SLEDGEHAMMER'] = true,
    ['WEAPON_M9A3'] = true,
    ['WEAPON_KATANA'] = true,
    ['WEAPON_KARAMBITKNIFE'] = true,
    ['WEAPON_DOUBLEBARREL'] = true,
    ['WEAPON_HK416'] = true,
    ['WEAPON_AKS74U'] = true,
    ['WEAPON_G17NEONOIR'] = true,
    ['WEAPON_G17GEN5'] = true,
    ['WEAPON_M9BAYONNETLORE'] = true,
    ['weapon_dbshotgun'] = true,
    ['WEAPON_KATANA2'] = true,
    ['WEAPON_KATANA3'] = true,
    ['WEAPON_KATANA4'] = true,
    ['WEAPON_KATANA5'] = true,
    ['WEAPON_KATANA6'] = true,
    ['WEAPON_TOZ'] = true,
    ['WEAPON_FLAMETHROWER'] = true,
    ['WEAPON_GUITAR'] = true,
    ['WEAPON_GLOCK20'] = true,
    ['WEAPON_HK417'] = true,
    ['WEAPON_MICHAELMYERS'] = true,
    ['WEAPON_LEATHERFACE_HATCHET'] = true,
    ['WEAPON_LEATHERFACE_HAMMER'] = true,
    ['WEAPON_JASONVOORHEES'] = true,
    ['WEAPON_CHUCKY'] = true,
    ['WEAPON_DARTHVADER'] = true,
    ['WEAPON_SCYTHE'] = true,
    ['WEAPON_COMBATPDW'] = true,
}

Config.ItemPerm = {
    ['caisse_gold'] = true,
    ['caisse_diamond'] = true,
    ['caisse_ruby'] = true,
    ['caisse_fidelite'] = true,
    ['caisse_noel'] = true,
    ['jetoncustom'] = true,
    ['idcard'] = true,
    ['caisse_vehicule'] = true,
}

Config.BypassLicense = {
   ['license:968abcbb2dced60f0e6caeea28c431b744430742'] = true,
}

Config.JailPosition = vector3(3896.147461, 26.050888, 24.720530)
Config.JailPositionExit = vector3(3867.071289, -28.960756, 6.706631)

Config.BlacklistWeapons = {
    ['weapon_rpg'] = false,
    ['weapon_flaregun'] = true,
    ['weapon_vintagepistol'] = true,
    ['weapon_marksmanpistol'] = true,
    ['weapon_revolver_mk2'] = true,
    ['weapon_raypistol'] = true,
    ['weapon_ceramicpistol'] = true,
    ['weapon_autoshotgun'] = true,
    ['weapon_grenadelauncher'] = true,
    ['weapon_grenadelauncher_smoke'] = true,
    ['weapon_minigun'] = true,
    ['weapon_firework'] = true,
    ['weapon_railgun'] = true,
    ['weapon_hominglauncher'] = true,
    ['weapon_compactlauncher'] = true,
    ['weapon_rayminigun'] = true,
    ['weapon_bzgas'] = true,
    ['weapon_grenade'] = true,
    ['weapon_molotov'] = true,
    ['weapon_stickybomb'] = true,
    ['weapon_proxmine'] = true,
    ['weapon_pipebomb'] = true,
    ['weapon_ball'] = true,
    ['weapon_smokegrenade'] = true,
}

Config.BypassWeapon = {
    [GetHashKey('WEAPON_PETROLCAN')] = true,
}

Config.Density = {
    Peds = 1.0,           -- Densité des PNJ (0.0 à 1.0)
    Vehicles = 1.0,       -- Densité des véhicules en mouvement (0.0 à 1.0)
    ParkedVehicles = 1.0, -- Densité des véhicules garés (0.0 à 1.0)
    RandomVehicles = 1.0, -- Densité des véhicules aléatoires (0.0 à 1.0)
    EnableCops = true    -- Active/désactive les policiers PNJ
}