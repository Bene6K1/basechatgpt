DELETE FROM `items` WHERE `name` IN (
    'knife', 'nightstick', 'hammer', 'bat', 'golfclub', 'crowbar', 'pistol', 
    'combatpistol', 'appistol', 'pistol50', 'microsmg', 'smg', 'assaultsmg', 
    'assaultrifle', 'carbinerifle', 'advancedrifle', 'mg', 'combatmg', 
    'pumpshotgun', 'sawnoffshotgun', 'assaultshotgun', 'bullpupshotgun', 
    'stungun', 'sniperrifle', 'heavysniper', 'remotesniper', 'grenadelauncher', 
    'rpg', 'stinger', 'minigun', 'grenade', 'stickybomb', 'smokegrenade', 
    'bzgas', 'molotov', 'fireextinguisher', 'petrolcan', 'snspistol', 
    'gusenberg', 'specialcarbine', 'heavypistol', 'bullpuprifle', 'dagger', 
    'vintagepistol', 'firework', 'musket', 'marksmanrifle', 'hominglauncher', 
    'proxmine', 'snowball', 'flaregun', 'handcuffs', 'railgun', 'switchblade', 
    'revolver', 'autoshotgun', 'battleaxe', 'compactlauncher', 'minismg', 
    'pipebomb', 'poolcue', 'wrench', 'flashlight', 'nightvision', 'parachute', 
    'flare', 'snspistol_mk2', 'revolver_mk2', 'doubleaction', 
    'specialcarbine_mk2', 'bullpuprifle_mk2', 'pumpshotgun_mk2', 
    'marksmanrifle_mk2', 'assaultrifle_mk2', 'carbinerifle_mk2', 
    'combatmg_mk2', 'heavysniper_mk2', 'pistol_mk2', 'smg_mk2', 'pistol_ammo', 
    'smg_ammo', 'rifle_ammo', 'mg_ammo', 'shotgun_ammo', 'stungun_ammo', 
    'sniper_ammo', 'sniper_remote_ammo', 'fireextinguisher_ammo', 
    'minigun_ammo', 'grenadelauncher_ammo', 'grenadelauncher_smoke_ammo', 
    'rpg_ammo', 'stinger_ammo', 'ball_ammo', 'stickybomb_ammo', 
    'smokegrenade_ammo', 'gzgas_ammo', 'flare_ammo', 'molotov_ammo', 
    'tank_ammo', 'space_rocket_ammo', 'plane_rocket_ammo', 'player_laser_ammo', 
    'enemy_laser_ammo', 'bird_crap_ammo', 'm9bayonnetlore', 'combatpistolpol', 
    'g17gen5', 'g17neonoir', 'aks74u', 'hk416', 'doublebarrel', 'karambitknife', 
    'katana', 'm9a3', 'sledgehammer', 'vp9', 'bren', 'fireaxe', 'hkump', 'scar17fm', 
    'glitchpopvandal', 'mcxspear', 'honeybadgercod', 'mp5sdfm', 'fn509', 'ar15', 'm6ic', 
    'victusxmr', 'pistolxm3'
);

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('knife', 'Couteau', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('nightstick', 'Matraque', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('hammer', 'Marteau', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('bat', 'Batte de baseball', 2.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('golfclub', 'Club de golf', 2.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('crowbar', 'Pied-de-biche', 2.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pistol', 'Beretta', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('combatpistol', 'Glock 17', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('appistol', 'FN Five-Seven', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pistol50', 'Desert Eagle', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('microsmg', 'Micro Uzi', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('smg', 'Mitraillette MP5', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('assaultsmg', 'P90', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('assaultrifle', 'Fusil d\'assaut AK-47', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('carbinerifle', 'Carabine M4', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('advancedrifle', 'Fusil Bullpup avancé', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('mg', 'Mitrailleuse MG', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('combatmg', 'Combat MG', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pumpshotgun', 'Fusil à pompe', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('sawnoffshotgun', 'Fusil à canon scié', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('assaultshotgun', 'Fusil d\'assaut à pompe', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('bullpupshotgun', 'Fusil Bullpup', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('stungun', 'Taser', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('sniperrifle', 'Fusil de sniper', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('heavysniper', 'Sniper lourd', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('remotesniper', 'Sniper télécommandé', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('grenadelauncher', 'Lance-grenades', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('rpg', 'RPG', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('stinger', 'Lance-missiles Stinger', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('minigun', 'Minigun', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('grenade', 'Grenade', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('stickybomb', 'Bombe collante', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('smokegrenade', 'Grenade fumigène', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('bzgas', 'Gaz lacrymogène', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('molotov', 'Cocktail Molotov', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('fireextinguisher', 'Extincteur', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('petrolcan', 'Jerrycan', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('snspistol', 'Pistolet SNS', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('gusenberg', 'Balayeuse Gusenberg', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('specialcarbine', 'Carabine spéciale', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('heavypistol', 'Pistolet lourd', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('bullpuprifle', 'Fusil Bullpup', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('dagger', 'Dague', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('vintagepistol', 'Pistolet vintage', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('firework', 'Feu d\'artifice', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('musket', 'Mousquet', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('marksmanrifle', 'Fusil Marksman', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('hominglauncher', 'Lance-missiles guidé', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('proxmine', 'Mine de proximité', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('snowball', 'Boule de neige', 0.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('flaregun', 'Pistolet de détresse', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('handcuffs', 'Menottes', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('railgun', 'Canon à rail', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('switchblade', 'Couteau pliant', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('revolver', 'Revolver lourd', 2.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('autoshotgun', 'Fusil automatique', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('battleaxe', 'Hache de combat', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('compactlauncher', 'Lanceur compact M79', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('minismg', 'Mini Uzi', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pipebomb', 'Bombe artisanale', 2.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('poolcue', 'Queue de billard', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('wrench', 'Clé à molette', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('flashlight', 'Lampe torche', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('nightvision', 'Vision nocturne', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('parachute', 'Parachute', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('flare', 'Fusée éclairante', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('snspistol_mk2', 'Pistolet SNS MK2', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('revolver_mk2', 'Revolver MK2', 2.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('doubleaction', 'Double Action', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('specialcarbine_mk2', 'Carabine spéciale MK2', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('bullpuprifle_mk2', 'Fusil Bullpup MK2', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pumpshotgun_mk2', 'Fusil à pompe MK2', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('marksmanrifle_mk2', 'Marksman Rifle MK2', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('assaultrifle_mk2', 'Fusil d\'assaut MK2', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('carbinerifle_mk2', 'Carabine M4 MK2', 3.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('combatmg_mk2', 'Combat MG MK2', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('heavysniper_mk2', 'Sniper lourd MK2', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pistol_mk2', 'Pistolet Sig Sauer P226 MK2', 1.5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('smg_mk2', 'SMG MK2', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pistol_ammo', 'Munitions pour pistolet', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('smg_ammo', 'Munitions pour mitraillette', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('rifle_ammo', 'Munitions pour fusil', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('mg_ammo', 'Munitions pour mitrailleuse', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('shotgun_ammo', 'Munitions pour fusil à pompe', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('stungun_ammo', 'Munitions pour taser', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('sniper_ammo', 'Munitions pour sniper', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('sniper_remote_ammo', 'Munitions pour sniper télécommandé', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('fireextinguisher_ammo', 'Agent extincteur', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('minigun_ammo', 'Munitions pour Minigun', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('grenadelauncher_ammo', 'Munitions pour lance-grenades', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('grenadelauncher_smoke_ammo', 'Grenades fumigènes pour lance-grenades', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('rpg_ammo', 'Munitions pour RPG', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('stinger_ammo', 'Munitions pour lance-missiles Stinger', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('ball_ammo', 'Munitions pour balles', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('stickybomb_ammo', 'Munitions pour bombes collantes', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('smokegrenade_ammo', 'Munitions pour grenades fumigènes', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('gzgas_ammo', 'Munitions pour gaz lacrymogène', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('flare_ammo', 'Fusées éclairantes', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('molotov_ammo', 'Munitions pour cocktails Molotov', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('tank_ammo', 'Obus pour tank', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('space_rocket_ammo', 'Munitions pour fusées spatiales', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('plane_rocket_ammo', 'Munitions pour roquettes aériennes', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('player_laser_ammo', 'Munitions pour laser joueur', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('enemy_laser_ammo', 'Munitions pour laser ennemi', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('bird_crap_ammo', 'Excréments d\'oiseaux', 0.1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('m9bayonnetlore', 'M9 Bayonet Lore', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('combatpistolpol', 'Combat Pistol Police', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('g17gen5', 'Glock 17 Gen 5', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('g17neonoir', 'Glock 17 Neon Noir', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('aks74u', 'AKS-74U', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('hk416', 'HK 416', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('doublebarrel', 'Double Barrel Shotgun', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('karambitknife', 'Karambit Knife', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('katana', 'Katana', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('m9a3', 'M9A3 Pistol', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('sledgehammer', 'Sledgehammer', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('vp9', 'VP9', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('bren', 'Bren Gun', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('fireaxe', 'Fire Axe', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('hkump', 'HK UMP', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('scar17fm', 'SCAR 17 Full Metal', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('glitchpopvandal', 'Glitchpop Vandal', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('mcxspear', 'MCX Spear', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('honeybadgercod', 'Honey Badger (COD)', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('mp5sdfm', 'MP5 SD Full Metal', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('fn509', 'FN 509', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('ar15', 'AR-15', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('m6ic', 'M6 IC', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('victusxmr', 'Victus XMR', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pistolxm3', 'Pistol XM3', 2, 0, 1);


-- pistol_ammo', 'Munitions pour pistolet',
-- rifle_ammo', 'Munitions pour fusil',
-- shotgun_ammo', 'Munitions pour fusil à pompe',
-- sniper_ammo', 'Munitions pour sniper',
-- smg_ammo', 'Munitions pour mitraillette',
-- mg_ammo', 'Munitions pour mitrailleuse',


-- stungun_ammo', 'Munitions pour taser',
-- sniper_remote_ammo', 'Munitions pour sniper télécommandé',
-- fireextinguisher_ammo', 'Agent extincteur',
-- minigun_ammo', 'Munitions pour Minigun',
-- grenadelauncher_ammo', 'Munitions pour lance-grenades',
-- grenadelauncher_smoke_ammo', 'Grenades fumigènes pour lance-grenades',
-- rpg_ammo', 'Munitions pour RPG',
-- stinger_ammo', 'Munitions pour lance-missiles Stinger',
-- ball_ammo', 'Munitions pour balles',
-- stickybomb_ammo', 'Munitions pour bombes collantes',
-- smokegrenade_ammo', 'Munitions pour grenades fumigènes',
-- gzgas_ammo', 'Munitions pour gaz lacrymogène',
-- flare_ammo', 'Fusées éclairantes',
-- molotov_ammo', 'Munitions pour cocktails Molotov',
-- tank_ammo', 'Obus pour tank',
-- space_rocket_ammo', 'Munitions pour fusées spatiales',
-- plane_rocket_ammo', 'Munitions pour roquettes aériennes',
-- player_laser_ammo', 'Munitions pour laser joueur',
-- enemy_laser_ammo', 'Munitions pour laser ennemi',