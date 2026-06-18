return {
    ['caisse_gold'] = {
        label = 'Caisse Gold',
        weight = 100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'Caisse mystérieuse de la boutique (Gold)',
        client = {
            image = 'caisse_gold.png',
        },
        buttons = {
            {
                label = 'Ouvrir la caisse',
                action = function(slot)
                    TriggerServerEvent('boutique:openCase', 'gold')
                end
            }
        }
    },

    ['caisse_diamond'] = {
        label = 'Caisse Diamond',
        weight = 100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'Caisse mystérieuse de la boutique (Diamond)',
        client = {
            image = 'caisse_diamond.png',
        },
        buttons = {
            {
                label = 'Ouvrir la caisse',
                action = function(slot)
                    TriggerServerEvent('boutique:openCase', 'diamond')
                end
            }
        }
    },

    ['caisse_ruby'] = {
        label = 'Caisse Ruby',
        weight = 100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'Caisse mystérieuse de la boutique (Ruby)',
        client = {
            image = 'caisse_ruby.png',
        },
        buttons = {
            {
                label = 'Ouvrir la caisse',
                action = function(slot)
                    TriggerServerEvent('boutique:openCase', 'ruby')
                end
            }
        }
    },

    ['caisse_fidelite'] = {
        label = 'Caisse Fidélité',
        weight = 100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'Caisse de fidélité',
        client = {
            image = 'caisse_fidelite.png',
        }
    },

    ['caisse_noel'] = {
        label = 'Caisse Noël',
        weight = 100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'Caisse de Noël',
        client = {
            image = 'caisse_noel.png',
        }
    },

    ['caisse_vehicule'] = {
        label = 'Caisse Véhicule',
        weight = 100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'Caisse contenant un véhicule',
        client = {
            image = 'caisse_vehicule.png',
        }
    },

    ['jetoncustom'] = {
        label = 'Jeton Custom',
        weight = 10,
        stack = true,
        close = false,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'Jeton spécial boutique',
        client = {
            image = 'jetoncustom.png',
        }
    },

    ['awpredline'] = {
        label = 'AWP Redline',
        weight = 4500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        description = 'AWP Redline (VIP)',
        client = {
            image = 'awpredline.png',
        }
    },

    ['ak47neonride'] = {
        label = 'AK-47 Neon Ride',
        weight = 4500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'ak47neonride.png',
        }
    },

    ['victusxmr'] = {
        label = 'Victus XMR',
        weight = 5000,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'victusxmr.png',
        }
    },

    ['m6ic'] = {
        label = 'M6 IC',
        weight = 4000,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'm6ic.png',
        }
    },

    ['ar15'] = {
        label = 'AR-15',
        weight = 4200,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'ar15.png',
        }
    },

    ['fn509'] = {
        label = 'FN 509',
        weight = 1500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'fn509.png',
        }
    },

    ['mp5sdfm'] = {
        label = 'MP5 SDFM',
        weight = 3500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'mp5sdfm.png',
        }
    },

    ['honeybadgercod'] = {
        label = 'Honey Badger COD',
        weight = 3800,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'honeybadgercod.png',
        }
    },

    ['mcxspear'] = {
        label = 'MCX Spear',
        weight = 4100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'mcxspear.png',
        }
    },

    ['glitchpopvandal'] = {
        label = 'Glitchpop Vandal',
        weight = 3900,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'glitchpopvandal.png',
        }
    },

    ['scar17fm'] = {
        label = 'SCAR-17 FM',
        weight = 4300,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'scar17fm.png',
        }
    },

    ['hkump'] = {
        label = 'HK UMP',
        weight = 3200,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'hkump.png',
        }
    },

    ['fireaxe'] = {
        label = 'Hache de Pompier',
        weight = 2500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'fireaxe.png',
        }
    },

    ['bren'] = {
        label = 'Bren',
        weight = 5500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'bren.png',
        }
    },

    ['vp9'] = {
        label = 'VP9',
        weight = 1400,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'vp9.png',
        }
    },

    ['sledgehammer'] = {
        label = 'Masse',
        weight = 3000,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'sledgehammer.png',
        }
    },

    ['m9a3'] = {
        label = 'M9A3',
        weight = 1500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'm9a3.png',
        }
    },

    ['katana'] = {
        label = 'Katana',
        weight = 2000,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'katana.png',
        }
    },

    ['karambitknife'] = {
        label = 'Karambit',
        weight = 500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'karambitknife.png',
        }
    },

    ['hk416'] = {
        label = 'HK416',
        weight = 4400,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'hk416.png',
        }
    },

    ['aks74u'] = {
        label = 'AKS-74U',
        weight = 3700,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'aks74u.png',
        }
    },

    ['g17neonoir'] = {
        label = 'Glock-17 Neo Noir',
        weight = 1300,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'g17neonoir.png',
        }
    },

    ['g17gen5'] = {
        label = 'Glock-17 Gen5',
        weight = 1300,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'g17gen5.png',
        }
    },

    ['m9bayonnetlore'] = {
        label = 'M9 Bayonet Lore',
        weight = 1400,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,
        client = {
            image = 'm9bayonnetlore.png',
        }
    },

    ['assaultrifle'] = {
        label = 'Assault Rifle',
        weight = 4100,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'assaultrifle.png',
        }
    },

    ['combatpdw'] = {
        label = 'Combat PDW',
        weight = 3300,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'combatpdw.png',
        }
    },

    ['howa_2'] = {
        label = 'HOWA Type 2',
        weight = 4300,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'howa_2.png',
        }
    },

    ['benellim4'] = {
        label = 'Benelli M4',
        weight = 3800,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'benellim4.png',
        }
    },

    ['uzi'] = {
        label = 'UZI',
        weight = 3000,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'uzi.png',
        }
    },

    ['doublebarrel'] = {
        label = 'Double Barrel',
        weight = 3500,
        stack = false,
        close = true,
        allowedToDrop = false,
        allowedToTrade = false,  -- PERMANENT
        client = {
            image = 'doublebarrel.png',
        }
    },

    ['boombox'] = {
        label = 'Boombox',
        weight = 5000,
        stack = false,
        close = true,
        allowedToTrade = false,  -- Impossible d'échanger
        client = {
            image = 'boombox.png',
        }
    },

    ['phone'] = {
        label = 'Téléphone',
        weight = 190,
        stack = false,
        close = true,
        allowedToTrade = true,  -- Peut être échangé
        client = {
            image = 'phone.png',
        }
    },

    ['radio'] = {
        label = 'Radio',
        weight = 200,
        stack = false,
        close = true,
        allowedToTrade = true,
        client = {
            image = 'radio.png',
        }
    },

    ['kevlar'] = {
        label = 'Gilet Pare-Balles',
        weight = 3000,
        stack = false,
        close = true,
        client = {
            image = 'kevlar.png',
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 2500,
        },
        server = {
            export = 'core.useKevlar'
        }
    },

    ['kevlarmid'] = {
        label = 'Gilet Pare-Balles (Moyen)',
        weight = 2500,
        stack = false,
        close = true,
        client = {
            image = 'kevlarmid.png',
        }
    },

    ['kevlarlow'] = {
        label = 'Gilet Pare-Balles (Léger)',
        weight = 2000,
        stack = false,
        close = true,
        client = {
            image = 'kevlarlow.png',
        }
    },

    ['ciseaux'] = {
        label = 'Ciseaux',
        weight = 200,
        stack = false,
        close = true,
        client = {
            image = 'ciseaux.png',
        },
        server = {
            export = 'core.useCiseaux'
        }
    },

    ['nitrovehicle'] = {
        label = 'Nitro Véhicule',
        weight = 5000,
        stack = true,
        close = true,
        client = {
            image = 'nitrovehicle.png',
        }
    },

    ['jumelles'] = {
        label = 'Jumelles',
        weight = 800,
        stack = false,
        close = true,
        client = {
            image = 'jumelles.png',
        }
    },

    ['bmx'] = {
        label = 'BMX',
        weight = 8000,
        stack = false,
        close = true,
        client = {
            image = 'bmx.png',
        }
    },

    ['bodycam'] = {
        label = 'Bodycam',
        weight = 500,
        stack = false,
        close = true,
        client = {
            image = 'bodycam.png',
        }
    },

    ['oblivionPill'] = {
        label = 'Pilule Oblivion',
        weight = 50,
        stack = true,
        close = true,
        client = {
            image = 'oblivionPill.png',
        }
    },

    ['canneapeche'] = {
        label = 'Canne à Pêche',
        weight = 2000,
        stack = false,
        close = true,
        client = {
            image = 'canneapeche.png',
        }
    },

    ['canneapechecarbonne'] = {
        label = 'Canne à Pêche en Carbone',
        weight = 1800,
        stack = false,
        close = true,
        client = {
            image = 'canneapechecarbonne.png',
        }
    },

    ['canneapecheoretcarbonne'] = {
        label = 'Canne à Pêche Alliage Or et Carbone',
        weight = 1500,
        stack = false,
        close = true,
        client = {
            image = 'canneapecheoretcarbonne.png',
        }
    },

    -- Appâts
    ['douce_lures'] = {
        label = 'Appât Eau Douce',
        weight = 50,
        stack = true,
        close = false,
        client = {
            image = 'douce_lures.png',
        }
    },

    ['mer_lures'] = {
        label = 'Appât Eau de Mer',
        weight = 50,
        stack = true,
        close = false,
        client = {
            image = 'mer_lures.png',
        }
    },

    ['ocean_lures'] = {
        label = 'Appât Eau Profonde',
        weight = 50,
        stack = true,
        close = false,
        client = {
            image = 'ocean_lures.png',
        }
    },

    -- Poissons
    ['poissonchat'] = {
        label = 'Poisson Chat',
        weight = 400,
        stack = true,
        client = {
            image = 'poissonchat.png',
        }
    },

    ['silure'] = {
        label = 'Silure',
        weight = 3000,
        stack = true,
        client = {
            image = 'silure.png',
        }
    },

    ['anchois'] = {
        label = 'Anchois',
        weight = 100,
        stack = true,
        client = {
            image = 'anchois.png',
        }
    },

    ['bar'] = {
        label = 'Bar',
        weight = 800,
        stack = true,
        client = {
            image = 'bar.png',
        }
    },

    ['cerf'] = {
        label = 'Viande de Cerf',
        weight = 1500,
        stack = true,
        client = {
            image = 'cerf.png',
        }
    },

    ['lapin'] = {
        label = 'Viande de Lapin',
        weight = 300,
        stack = true,
        client = {
            image = 'lapin.png',
        }
    },

    ['jaguar'] = {
        label = 'Viande de Jaguar',
        weight = 1200,
        stack = true,
        client = {
            image = 'jaguar.png',
        }
    },

    ['loup'] = {
        label = 'Viande de Loup',
        weight = 1000,
        stack = true,
        client = {
            image = 'loup.png',
        }
    },

    ['sanglier'] = {
        label = 'Viande de Sanglier',
        weight = 1800,
        stack = true,
        client = {
            image = 'sanglier.png',
        }
    },

    ['steellingo'] = {
        label = 'Lingot d\'Acier',
        weight = 5000,
        stack = true,
        client = {
            image = 'steellingo.png',
        }
    },

    ['treatedsteel'] = {
        label = 'Lingot d\'Acier Traité',
        weight = 4500,
        stack = true,
        client = {
            image = 'treatedsteel.png',
        }
    },

    ['burgershot_burger'] = {
        label = 'Burger',
        weight = 300,
        stack = true,
        close = true,
        client = {
            image = 'burgershot_burger.png',
            status = { hunger = 200000 },
            anim = 'eating',
            usetime = 2500,
        }
    },

    ['burgershot_frite'] = {
        label = 'Frites',
        weight = 200,
        stack = true,
        close = true,
        client = {
            image = 'burgershot_frite.png',
            status = { hunger = 100000 },
            anim = 'eating',
            usetime = 2000,
        }
    },

    ['burgershot_coca'] = {
        label = 'Coca-Cola',
        weight = 350,
        stack = true,
        close = true,
        client = {
            image = 'burgershot_coca.png',
            status = { thirst = 150000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            usetime = 2500,
        }
    },

    ['bread'] = {
        label = 'Pain',
        weight = 125,
        stack = true,
        close = true,
        client = {
            image = 'bread.png',
            status = { hunger = 150000 },
            anim = 'eating',
            usetime = 2000,
        }
    },

    ['water'] = {
		label = 'Water',
		weight = 500,
		prop = 'prop_ld_flow_bottle',
		rarity = 'common',
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},
}

