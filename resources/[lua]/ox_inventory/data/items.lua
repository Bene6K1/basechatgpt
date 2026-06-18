local items = {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		consume = 0,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Argent Sale',
		description = 'Argent non déclaré',
		stack = true,
		close = false,
		allowedToDrop = true,  -- Peut être jeté (RP)
		client = {
			image = 'black_money.png',
		}
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		rarity = 'rare',
		prop = 'prop_cs_burger_01',
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
		client = {
			image = 'card_id.png'
		}
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		rarity = 'epic'
	},

['vehiclekeys'] = {
    label = 'Clés de véhicule',
    weight = 100,
    stack = false,
    close = true,
    consume = 0,
    description = 'Paire de clés associée à un véhicule.',
    client = {
        image = 'car_key.png'
    }
},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			export = 'p_phone.openPhone'
		}
	},

	['simcard'] = {
		label = 'SIM Card',
		weight = 10,
		stack = false,
		consume = 0,
		server = {
			export = 'p_phone.useSimCard'
		}
	},

	['money'] = {
		label = 'Argent',
		rarity = 'uncommon',
		stack = true,
		close = false,
		allowedToDrop = false,  -- Impossible de jeter l'argent propre
		client = {
			image = 'money.png',
		}
	},

	['bank'] = {
		label = 'Carte Bancaire',
		description = 'Contient votre argent en banque',
		stack = true,
		close = false,
		allowedToDrop = false,  -- Impossible de jeter
		allowedToTrade = false, -- Impossible d'échanger directement (utiliser virement)
		client = {
			image = 'bank.png',
		}
	},

	['chip'] = {
		label = 'Jetons Casino',
		description = 'Jetons utilisables au casino',
		weight = 1,
		stack = true,
		close = false,
		client = {
			image = 'casino_chips.png',
		}
	},

	['pesos'] = {
		label = 'Peso',
		description = 'Monnaie mexicaine',
		weight = 1,
		stack = true,
		close = false,
		client = {
			image = 'pesos.png',
		}
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		prop = 'prop_food_mustard',
		rarity = 'uncommon',
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
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

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		stack = false,
		weight = 10,
		client = {
			image = 'card_bank.png'
		}
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	['metalscrap'] = {
		label = 'Débris métallique',
		description = 'Pièces recyclées utilisables en craft.',
		weight = 500,
		stack = true,
		close = true,
		client = {
			image = 'metalscrap.png'
		}
	},

	['steel'] = {
		label = 'Lingot d\'acier',
		description = 'Acier raffiné prêt pour la fabrication.',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			image = 'steel.png'
		}
	},

	['plastic'] = {
		label = 'Plaque de plastique',
		description = 'Plastique industriel pour divers assemblages.',
		weight = 300,
		stack = true,
		close = true,
		client = {
			image = 'plastic.png'
		}
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Medikit",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	['crutch'] = {
		label = 'Crutch',
		weight = 100,
		stack = false,
		close = true,
	},

	['wheelchair'] = {
		label = 'Wheelchair',
		weight = 100,
		stack = false,
		close = true,
	},

	['stretcher'] = {
		label = 'Stretcher',
		weight = 100,
		stack = false,
		close = true,
	},

	['medical_kit'] = {
		label = 'Medical Kit',
		weight = 200,
		stack = false,
		close = false,
		description = 'A basic medical kit containing essential supplies for treating minor injuries and illnesses.',
	},

	['advanced_medical_kit'] = {
		label = 'Advanced Medical Kit',
		weight = 200,
		stack = false,
		close = false,
		description = 'A more advanced medical kit containing additional supplies and equipment for treating injuries and illnesses.',
	},

	['blood_bag_250'] = {
		label = 'Blood Bag 250ml',
		weight = 250,
		stack = true,
		close = false,
		description = 'A 250ml bag of blood used for blood transfusions.',
	},

	['blood_bag_500'] = {
		label = 'Blood Bag 500ml',
		weight = 500,
		stack = true,
		close = false,
		description = 'A 500ml bag of blood used for blood transfusions.',
	},

	['painkillers'] = {
		label = 'Painkillers',
		weight = 50,
		stack = true,
		close = false,
		description = 'A medication used to relieve pain and reduce fever.',
	},

	['adrenaline'] = {
		label = 'Adrenaline',
		weight = 50,
		stack = true,
		close = false,
	},

	['morphine'] = {
		label = 'Morphine',
		weight = 50,
		stack = true,
		close = false,
		description = 'A medication used to relieve pain and reduce fever.',
	},

	['suture_kit'] = {
		label = 'Suture Kit',
		weight = 100,
		stack = true,
		close = false,
		description = 'A medical device used to close wounds or surgical incisions.',
	},

	['icepack'] = {
		label = 'Ice Pack',
		weight = 100,
		stack = true,
		close = false,
		description = 'A bag of ice used to reduce swelling and numb pain.',
	},

	['splint'] = {
		label = 'Splint',
		weight = 100,
		stack = true,
		close = false,
		description = 'A device that is used to apply pressure to a limb.',
	},

	['defibrilator'] = {
		label = 'Defibrillator',
		weight = 500,
		stack = false,
		close = true,
	},

	['bodybag'] = {
		label = 'Body Bag',
		weight = 500,
		stack = true,
		close = false,
	},

	['gauze'] = {
		label = 'Gauze',
		weight = 20,
		stack = true,
		close = true,
		description = 'A thin, transparent fabric with a loose open weave, used for dressings, bandages, and surgical sponges.',
	},

	['bandage'] = {
		label = 'Bandage',
		description = 'Very good for stopping bleeding and small injuries',
		weight = 115,
		stack = true,
		close = true
	},

	['ointment'] = {
		label = 'Ointment',
		weight = 50,
		stack = true,
		close = true,
		description = 'A medical cream used to promote healing and prevent infection in minor cuts, scrapes, and burns.',
	},

	['disinfectant'] = {
		label = 'Disinfectant',
		weight = 50,
		stack = true,
		close = true,
		description = 'A liquid that kills bacteria and other microorganisms on surfaces.',
	},

	['cyclonamine'] = {
		label = 'Cyclonamine',
		weight = 50,
		stack = true,
		close = true,
	},

	['tourniquet'] = {
		label = 'Tourniquet',
		weight = 100,
		stack = true,
		close = true,
		description = 'A device that is used to apply pressure to a limb.',
	},

	['medicbag'] = {
		label = 'Medic Bag',
		weight = 500,
		stack = false,
		close = true,
		description = 'A bag containing medical supplies and equipment.',
	},

	['antipyretics'] = {
		label = 'Antipyretics',
		weight = 50,
		stack = true,
		close = true,
		description = 'A medication that reduces fever.',
	},

	['ambulance_gps'] = {
		label = 'Ambulance GPS',
		weight = 100,
		stack = false,
		close = true,
	},

	['clothes_hat'] = {
		label = 'Hat',
		weight = 50,
		stack = false,
		close = false,
		buttons = {
			{
				label = 'Show/Hide Hair',
				action = function(slot)
					TriggerEvent('p_itemclothes/client/toggleHair')
				end
			}
		},
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_ears'] = {
		label = 'Ear Accessories',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_tshirt'] = {
		label = 'T-Shirt',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_torso'] = {
		label = 'Jacket',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_arms'] = {
		label = 'Gloves',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_pants'] = {
		label = 'Pants',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_shoes'] = {
		label = 'Shoes',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_mask'] = {
		label = 'Mask',
		weight = 50,
		stack = false,
		close = false,
		buttons = {
			{
				label = 'Show/Hide Face',
				action = function(slot)
					TriggerEvent('p_itemclothes/client/toggleFace')
				end
			}
		},
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_glasses'] = {
		label = 'Glasses',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_vest'] = {
		label = 'Vest',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_bag'] = {
		label = 'Bag',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_watch'] = {
		label = 'Watch',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_chain'] = {
		label = 'Chain',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['clothes_bracelet'] = {
		label = 'Bracelet',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		server = {
			export = 'p_itemclothes.useClothingItem'
		}
	},

	['casino_chips'] = {
		label = 'Casino Chips',
		weight = 5,
		stack = true,
		close = true,
	},

	['breathalyzer'] = {
		label = 'Breathalyzer',
		weight = 150,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'p_policejob.useBreathalyzer'
		}
	},

		['police_rappel'] = {
		label = 'Police Rappel',
		weight = 100,
		stack = false,
		close = true,
		consume = 0,
		client = {
			event = 'p_policejob/client/heli/usePoliceRappel'
		}
	},
	
	['fingerprint_scanner'] = {
		label = 'Fingerprint Scanner',
		weight = 500,
		stack = false,
		close = true,
		client = {
			export = 'p_policejob.useScanner'
		}
	},

    ['spike_strip'] = {
		label = 'Spike strip',
		weight = 50,
		stack = true,
		consume = 1,
		client = {
			export = 'p_policejob.spike_strip'
		}
	},

	['road_cone'] = {
		label = 'Road cone',
		weight = 50,
		stack = true,
	},

	['consign'] = {
		label = 'Road sign',
		weight = 50,
		stack = true,
	},

	['barrier'] = {
		label = 'Road barrier',
		weight = 50,
		stack = true,
	},

	['roadcone_light'] = {
		label = 'Road cone light',
		weight = 50,
		stack = true,
	},

	['headbag'] = {
		label = 'Head bag',
		weight = 50,
		stack = false,
		close = false
	},

	['police_diving_suit'] = {
		label = 'Police Diving Suit',
		weight = 2000,
		consume = 0,
		stack = false,
		server = {
			export = 'p_policejob.police_diving_suit'
		}
	},

	['player_clothes'] = {
		label = 'Your clothes',
		weight = 250,
		consume = 0,
		stack = false,
		server = {
			export = 'p_policejob.player_clothes'
		}
	},

	['fingerprint'] = {
		label = 'Fingerprint Sample',
		weight = 5,
		stack = false,
		consume = 0,
	},

	['bullet'] = {
		label = 'Bullet Sample',
		weight = 5,
		stack = false,
		consume = 0
	},

	['blood'] = {
		label = 'Blood Sample',
		weight = 5,
		stack = false,
		consume = 0
	},

	['tracking_band'] = {
		label = 'GPS Band',
		weight = 300,
		stack = false,
		close = false,
		consume = 0
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['vest_normal'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		consume = 1,
		client = {
			export = 'p_policejob.vest_normal'
		}
	},

	['vest_strong'] = {
		label = 'Strong Bulletproof Vest',
		weight = 3000,
		stack = false,
		consume = 1,
		client = {
			export = 'p_policejob.vest_strong'
		}
	},

	['body_cam'] = {
		label = 'Police Bodycam',
		weight = 200,
		consume = 0,
		stack = false,
		server = {
			export = 'p_policejob.body_cam'
		}
	},

	['gps'] = {
		label = 'GPS',
		weight = 100,
		stack = false,
		consume = 0,
		allowArmed = true,
		client = {
			export = 'p_policejob.gps',
			remove = function(total)
				if total < 1 then
					local activeGPS = exports['p_policejob']:isGpsActive()
					if activeGPS then
						exports['p_policejob']:gps()
					end
				end
			end
		}
	},

	['snakecam'] = {
		label = 'Snake Cam',
		weight = 50,
		stack = false,
		close = true,
		client = {
			event = 'p_policejob/client/snakecam/start'
		}
	},

	['vehicle_tracker'] = {
		label = 'Vehicle GPS Tracker',
		weight = 100,
		stack = false,
		close = true,
	},

	['camera'] = {
		label = 'Camera',
		stack = false,
		close = true,
		consume = 0,
		weight = 1000,
		client = {
			export = 'p_policejob.camera'
		}
	},

	['photo'] = {
		label = 'Photo',
		stack = false,
		close = true,
		weight = 10,
		consume = 0,
		server = {
			export = 'p_policejob.photo'
		},
		buttons = {
			{
				label = 'Copy URL',
				action = function(slot)
					TriggerServerEvent('p_policejob/server_camera/CopyPhoto', slot)
				end
			},
		},
	},

	['handcuffs'] = {
		label = 'Handcuffs',
		weight = 100,
		stack = false,
		close = false,
		consume = 0,
		client = {
			export = 'p_policejob.handcuffs'
		}
	},

	['cable_ties'] = {
		label = 'Cable ties',
		weight = 100,
		stack = false,
		close = false,
		consume = 0
	},

	['mouthtape'] = {
		label = 'Mouth Tape',
		weight = 100,
		stack = false,
		close = false,
		consume = 0
	},

	['police_shield'] = {
		label = 'Police Shield',
		weight = 250,
		stack = false,
		close = false,
		consume = 0,
		client = {
			event = 'p_policejob/client/objects/togglePoliceShield'
		}
	},

	['evidence_camera'] = {
		label = 'Evidence Camera',
		weight = 100,
		stack = false,
		close = true,
		client = {
			export = 'p_policejob.evidence_camera'
		}
	},

	['megaphone'] = {
		label = 'Megaphone',
		weight = 100,
		stack = false,
		close = false,
		consume = 0,
		client = {
			export = 'p_policejob.useMegaphone'
		}
	},

	['traffic_ticket'] = {
		label = 'Traffic Ticket',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
	},

	['breathalyzer'] = {
		label = 'Breathalyzer',
		weight = 150,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'p_policejob.useBreathalyzer'
		}
	},

	['cuffs_key'] = {
		label = 'Handcuffs key',
	  	weight = 50,
		stack = false,
	  	close = false,
		consume = 0
	},

	['wheel_clamp'] = {
		label = 'Wheel Clamp',
		weight = 250,
		stack = false,
	  	close = false,
		consume = 0
	},

	["357"] = {
		label = "WEAPON_357",
		weight = 1,
		stack = true,
		close = true,
	},

	["5fromages"] = {
		label = "Pizza au 5 fromages",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["accesscard"] = {
		label = "Access Card",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["advancedrifle"] = {
		label = "Fusil Bullpup avancé",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["ak-guard"] = {
		label = "WEAPON_GUARD",
		weight = 1,
		stack = true,
		close = true,
	},

	["ak-redl"] = {
		label = "WEAPON_REDL",
		weight = 1,
		stack = true,
		close = true,
	},

	["akorus"] = {
		label = "WEAPON_AKORUS",
		weight = 1,
		stack = true,
		close = true,
	},

	["aks74u"] = {
		label = "AKS-74U",
		weight = 3,
		stack = true,
		close = true,
	},

	["alien"] = {
		label = "WEAPON_ALIEN",
		weight = 1,
		stack = true,
		close = true,
	},

	["ananas"] = {
		label = "Ananas",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["anchois"] = {
		label = "Anchois",
		weight = 0,
		stack = true,
		close = true,
	},

	["anchor"] = {
		label = "Ancre pour bateau",
		weight = 10,
		stack = true,
		close = true,
	},

	["ancient"] = {
		label = "WEAPON_ANCIENT",
		weight = 1,
		stack = true,
		close = true,
	},

	["appistol"] = {
		label = "FN Five-Seven",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["ar15"] = {
		label = "AR-15",
		weight = 4,
		stack = true,
		close = true,
	},

	["arsakura"] = {
		label = "WEAPON_ARSAKURA",
		weight = 1,
		stack = true,
		close = true,
	},

	["assaultrifle"] = {
		label = "Fusil d'assaut AK-47",
		weight = 4,
		stack = true,
		close = true,
	},

	["assaultrifle_mk2"] = {
		label = "Fusil d'assaut MK2",
		weight = 4,
		stack = true,
		close = true,
	},

	["assaultshotgun"] = {
		label = "Fusil d'assaut à pompe",
		weight = 4,
		stack = true,
		close = true,
	},

	["assaultsmg"] = {
		label = "P90",
		weight = 3,
		stack = true,
		close = true,
	},

	["autoshotgun"] = {
		label = "Fusil automatique",
		weight = 4,
		stack = true,
		close = true,
	},

	["ball"] = {
		label = "ball",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["ball_ammo"] = {
		label = "Munitions pour balles",
		weight = 0,
		stack = true,
		close = true,
	},

	["bar"] = {
		label = "Bar",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["barbecue"] = {
		label = "pizza au barbecue",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bat"] = {
		label = "Batte de baseball",
		weight = 2.5,
		stack = true,
		close = true,
	},

	["battleaxe"] = {
		label = "Hache de combat",
		weight = 3,
		stack = true,
		close = true,
	},

	["belini"] = {
		label = "Belini",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bierepleine"] = {
		label = "Bière Pleine",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bierevide"] = {
		label = "Bière Vide",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bijoux"] = {
		label = "Bijoux",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bird_crap_ammo"] = {
		label = "Excréments d'oiseaux",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["blacksniper"] = {
		label = "WEAPON_BLACKSNIPER",
		weight = 1,
		stack = true,
		close = true,
	},

	["black_phone"] = {
		label = "Black Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["blastak"] = {
		label = "WEAPON_BLASTAK",
		weight = 1,
		stack = true,
		close = true,
	},

	["blastm4"] = {
		label = "WEAPON_BLASTM4",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowtorch"] = {
		label = "Chalumeau",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["blueriot"] = {
		label = "WEAPON_BLUERIOT",
		weight = 1,
		stack = true,
		close = true,
	},

	["blue_phone"] = {
		label = "Téléphone",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bmx"] = {
		label = "BMX",
		weight = 0.5,
		stack = true,
		close = true,
	},

	["bodycam"] = {
		label = "Bodycam",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bolcacahuetes"] = {
		label = "Bol de cacahuètes",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bolchips"] = {
		label = "Bol de chips",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bolnoixcajou"] = {
		label = "Bol de noix de cajou",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bolpistache"] = {
		label = "Bol de pistaches",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["boneper"] = {
		label = "WEAPON_BONEPER",
		weight = 1,
		stack = true,
		close = true,
	},

	["bottle"] = {
		label = "Bottle",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["boulon"] = {
		label = "Boulon",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["boulonneuse"] = {
		label = "Boulonneuse",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bouteilleremplie"] = {
		label = "Bouteille remplie",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["boutilletvide"] = {
		label = "Boutillet vide",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bren"] = {
		label = "Bren Gun",
		weight = 5,
		stack = true,
		close = true,
	},

	["brochette"] = {
		label = "Brochette en bois",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["bullpuprifle"] = {
		label = "Fusil Bullpup",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["bullpuprifle_mk2"] = {
		label = "Fusil Bullpup MK2",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["bullpupshotgun"] = {
		label = "Fusil Bullpup",
		weight = 4,
		stack = true,
		close = true,
	},

	["burgershot_bacon"] = {
		label = "Bacon",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_biere"] = {
		label = "Bière",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_burger"] = {
		label = "Burger",
		weight = 2,
		stack = true,
		close = true,
	},

	["burgershot_cheddar"] = {
		label = "Cheddar",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_chesseburger"] = {
		label = "Cheeseburger",
		weight = 2,
		stack = true,
		close = true,
	},

	["burgershot_coca"] = {
		label = "Coca Cola",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_cookie"] = {
		label = "Cookie",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_frite"] = {
		label = "Frite",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_milkshake"] = {
		label = "Milkshake",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_oignonrings"] = {
		label = "Onion Rings",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_pain"] = {
		label = "Pain Burger",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["burgershot_painburger"] = {
		label = "Pain Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_poulet"] = {
		label = "Nuggets de poulet",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_salade"] = {
		label = "Salade",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_sprite"] = {
		label = "Sprite",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_tomate"] = {
		label = "Tomate",
		weight = 1,
		stack = true,
		close = true,
	},

	["burgershot_viandeburger"] = {
		label = "Viande Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["bzgas"] = {
		label = "Gaz lacrymogène",
		weight = 1,
		stack = true,
		close = true,
	},

	["c4_bank"] = {
		label = "Pain de C4",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["cabillaud"] = {
		label = "Cabillaud",
		weight = 0,
		stack = true,
		close = true,
	},

	["cacahuete"] = {
		label = "Cacahuète",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["cagoule"] = {
		label = "Gagoule",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["caissepleine"] = {
		label = "Caisse Pleine",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["caissevide"] = {
		label = "Caisse Vide",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["calzone"] = {
		label = "Pizza calzone",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["canette"] = {
		label = "Canette",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["canettefondue"] = {
		label = "Canette Fondue",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["canettepropre"] = {
		label = "Canette Propre",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["canneapeche"] = {
		label = "Canne à Pêche",
		weight = 0,
		stack = true,
		close = true,
	},

	["canneapechecarbonne"] = {
		label = "Canne à Pêche en carbonne",
		weight = 0,
		stack = true,
		close = true,
	},

	["canneapecheoretcarbonne"] = {
		label = "Canne à Pêche aliage Or et Carbonne",
		weight = 0,
		stack = true,
		close = true,
	},

	["cappuccino"] = {
		label = "Cappuccino",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["caprisun"] = {
		label = "Caprisun",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["carassin"] = {
		label = "Carassin",
		weight = 0,
		stack = true,
		close = true,
	},

	["carbinerifle"] = {
		label = "Carabine M4",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["carbinerifle_mk2"] = {
		label = "Carabine M4 MK2",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["carpecommune"] = {
		label = "Carpe commune",
		weight = 0,
		stack = true,
		close = true,
	},

	["carpekoi"] = {
		label = "Carpe koï",
		weight = 0,
		stack = true,
		close = true,
	},

	["carpemiroir"] = {
		label = "Carpe miroir",
		weight = 0,
		stack = true,
		close = true,
	},

	["carrosserie"] = {
		label = "Carrosserie",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["cartesecu"] = {
		label = "Carte d'acces au pannel 11441188",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["casino_beer"] = {
		label = "Casino Beer",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_burger"] = {
		label = "Burger",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_coffee"] = {
		label = "Casino Coffee",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_coke"] = {
		label = "Casino Kofola",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_donut"] = {
		label = "Casino Donut",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_ego_chaser"] = {
		label = "Casino Ego Chaser",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_luckypotion"] = {
		label = "Casino Lucky Potion",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_psqs"] = {
		label = "Casino Ps & Qs",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_sandwitch"] = {
		label = "Casino Sandwitch",
		weight = -1,
		stack = true,
		close = true,
	},

	["casino_sprite"] = {
		label = "Casino Sprite",
		weight = -1,
		stack = true,
		close = true,
	},

	["caviar"] = {
		label = "Caviar",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["cement"] = {
		label = "Ciment",
		weight = 0.6,
		stack = true,
		close = true,
	},

	["ceramicpistol"] = {
		label = "WEAPON_CERAMICPISTOL",
		weight = 1,
		stack = true,
		close = true,
	},

	["cerf"] = {
		label = "Cerf",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["chaine"] = {
		label = "Chaine de Moto",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["chainsaw"] = {
		label = "WEAPON_CHAINSAW",
		weight = 1,
		stack = true,
		close = true,
	},

	["chevreuil"] = {
		label = "Chevreuil",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["chiffon"] = {
		label = "Chiffon",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["chou"] = {
		label = "Chou",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["ciseaux"] = {
		label = "Ciseaux",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["citron"] = {
		label = "Citron",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["classic_phone"] = {
		label = "Classic Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["cles"] = {
		label = "ClÃ©s vÃ©hicules",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["clip"] = {
		label = "Chargeur",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["coca"] = {
		label = "Coca-Cola",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["coca_blend"] = {
		label = "Mélange de coca",
		weight = 1,
		stack = true,
		close = true,
	},

	["coca_leaf"] = {
		label = "Feuille de coca exotique",
		weight = 1,
		stack = true,
		close = true,
	},

	["coca_paste"] = {
		label = "Pâte de coca",
		weight = 1,
		stack = true,
		close = true,
	},

	["cocktailmaison"] = {
		label = "Cocktail maison",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["coco"] = {
		label = "Coco",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["cokepure"] = {
		label = "Cocaïne pure",
		weight = 1,
		stack = true,
		close = true,
	},

	["coke_pooch"] = {
		label = "Pochon de Coke",
		weight = 1,
		stack = true,
		close = true,
	},

	["colis"] = {
		label = "Colis",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["combatmg"] = {
		label = "Combat MG",
		weight = 4,
		stack = true,
		close = true,
	},

	["combatmg_mk2"] = {
		label = "Combat MG MK2",
		weight = 4,
		stack = true,
		close = true,
	},

	["combatpdw"] = {
		label = "SIG Sauer MPX",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["combatpistol"] = {
		label = "Glock 17",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["combatpistolpol"] = {
		label = "Combat Pistol Police",
		weight = 2,
		stack = true,
		close = true,
	},

	["combatshotgun"] = {
		label = "WEAPON_COMBATSHOTGUN",
		weight = 1,
		stack = true,
		close = true,
	},

	["compactlauncher"] = {
		label = "Lanceur compact M79",
		weight = 4,
		stack = true,
		close = true,
	},

	["compactrifle"] = {
		label = "WEAPON_COMPACTRIFLE",
		weight = 1,
		stack = true,
		close = true,
	},

	["compo"] = {
		label = "Composants",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["contrat"] = {
		label = "Contrat",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["contratlocation"] = {
		label = "Contrat de Location",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["contratvente"] = {
		label = "Contrat de Vente",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["crepe"] = {
		label = "Crepe",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["crick"] = {
		label = "Crick",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["crochetage_kit"] = {
		label = "Kit de Crochetage",
		weight = 1,
		stack = true,
		close = true,
	},

	["crowbar"] = {
		label = "Pied-de-biche",
		weight = 2.5,
		stack = true,
		close = true,
	},

	["dagger"] = {
		label = "Dague",
		weight = 1,
		stack = true,
		close = true,
	},

	["dashcam"] = {
		label = "Dashcam",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["dbshotgun"] = {
		label = "WEAPON_DBSHOTGUN",
		weight = 1,
		stack = true,
		close = true,
	},

	["desert-nike"] = {
		label = "WEAPON_DESERTNIKE",
		weight = 1,
		stack = true,
		close = true,
	},

	["desertpurple"] = {
		label = "WEAPON_DESERTPURPLE",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamant"] = {
		label = "Diamant",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["digiscanner"] = {
		label = "digiscanner",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["dolu_prop_stroller1"] = {
		label = "Poussette 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["dolu_prop_stroller2"] = {
		label = "Poussette 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["dorade"] = {
		label = "Dorade",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["doubleaction"] = {
		label = "Double Action",
		weight = 2,
		stack = true,
		close = true,
	},

	["doublebarrel"] = {
		label = "Double Barrel Shotgun",
		weight = 4,
		stack = true,
		close = true,
	},

	["douce_lures"] = {
		label = "Appât d'Eau Douce",
		weight = 0,
		stack = true,
		close = true,
	},

	["drill"] = {
		label = "Drill",
		weight = 1,
		stack = true,
		close = true,
	},

	["drink_burgershot"] = {
		label = "Boisson Burgershot",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["driver_license"] = {
		label = "Permis de conduire",
		weight = 1,
		stack = true,
		close = true,
	},

	["drpepper"] = {
		label = "Dr. Pepper",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["elixir"] = {
		label = "Élixir",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["elixirblanco"] = {
		label = "Élixir blanco",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["enceinte"] = {
		label = "Enceinte",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["enemy_laser_ammo"] = {
		label = "Munitions pour laser ennemi",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["energy"] = {
		label = "Energy Drink",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["eperlant"] = {
		label = "Éperlant",
		weight = 0,
		stack = true,
		close = true,
	},

	["fakebankingcard"] = {
		label = "Fausse carte bancaire",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["fake_id_card"] = {
		label = "Fausse carte d'identité",
		weight = 1,
		stack = true,
		close = true,
	},

	["fake_job_card"] = {
		label = "Fausse carte professionnelle",
		weight = 1,
		stack = true,
		close = true,
	},

	["fanta"] = {
		label = "Fanta",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["ferraille"] = {
		label = "Ferraille",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["feuillechanvre"] = {
		label = "Feuille de chanvre",
		weight = 0.5,
		stack = true,
		close = true,
	},

	["feuillecoca"] = {
		label = "Feuille de coca",
		weight = 0.05,
		stack = true,
		close = true,
	},

	["fichelocation"] = {
		label = "Fiche de location",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["fichenotaire"] = {
		label = "Fiche Notariale",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["fireaxe"] = {
		label = "Fire Axe",
		weight = 2,
		stack = true,
		close = true,
	},

	["fireextinguisher"] = {
		label = "Extincteur",
		weight = 3,
		stack = true,
		close = true,
	},

	["fireextinguisher_ammo"] = {
		label = "Agent extincteur",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["firework"] = {
		label = "Feu d'artifice",
		weight = 1,
		stack = true,
		close = true,
	},

	["fishbait"] = {
		label = "Fish Bait",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["fishingrod"] = {
		label = "Canne à pêche",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["flare"] = {
		label = "Fusée éclairante",
		weight = 1,
		stack = true,
		close = true,
	},

	["flaregun"] = {
		label = "Pistolet de détresse",
		weight = 1,
		stack = true,
		close = true,
	},

	["flare_ammo"] = {
		label = "Fusées éclairantes",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["flashlight"] = {
		label = "Lampe torche",
		weight = 1,
		stack = true,
		close = true,
	},

	["fn509"] = {
		label = "FN 509",
		weight = 2,
		stack = true,
		close = true,
	},

	["frite"] = {
		label = "Frite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["fromage"] = {
		label = "Portion de Fromage",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["g17gen5"] = {
		label = "Glock 17 Gen 5",
		weight = 2,
		stack = true,
		close = true,
	},

	["g17neonoir"] = {
		label = "Glock 17 Neon Noir",
		weight = 2,
		stack = true,
		close = true,
	},

	["gadgetpistol"] = {
		label = "WEAPON_GADGETPISTOL",
		weight = 1,
		stack = true,
		close = true,
	},

	["gadget_nightvision"] = {
		label = "GADGET_NIGHTVISION",
		weight = 1,
		stack = true,
		close = true,
	},

	["gadget_parachute"] = {
		label = "GADGET_PARACHUTE",
		weight = 1,
		stack = true,
		close = true,
	},

	["galette"] = {
		label = "Galette",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["garbagebag"] = {
		label = "garbagebag",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["garniture"] = {
		label = "Garniture de tacos",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gasoline"] = {
		label = "Essence",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["gateauxchance"] = {
		label = "Gâteaux de la chance",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gazeuse"] = {
		label = "WEAPON_GAZEUSE",
		weight = 1,
		stack = true,
		close = true,
	},

	["gigatacos"] = {
		label = "Giga tacos",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gigatacosfroid"] = {
		label = "Giga Tacos Froid",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gitanes"] = {
		label = "Gitanes",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["glacealitalienne"] = {
		label = "Glace à l'italienne",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["glitchpopvandal"] = {
		label = "Glitchpop Vandal",
		weight = 4,
		stack = true,
		close = true,
	},

	["glock17"] = {
		label = "WEAPON_GLOCK17",
		weight = 1,
		stack = true,
		close = true,
	},

	["glockdm"] = {
		label = "WEAPON_GLOCKDM",
		weight = 1,
		stack = true,
		close = true,
	},

	["gobeletcoca"] = {
		label = "Gobelelet de coca",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletdecoca"] = {
		label = "Gobelelet de coca",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletdehawai"] = {
		label = "Gobelelet de hawai",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletdeicetea"] = {
		label = "Gobelelet de icetea",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletfanta"] = {
		label = "Gobelelet de fanta",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeleticetea"] = {
		label = "Gobelelet de icetea",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletlimonade"] = {
		label = "Gobelet de limonade",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletoasis"] = {
		label = "Gobelelet de Oasis",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletorange"] = {
		label = "Gobelet Orange",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletorangina"] = {
		label = "Gobelelet de Orangina",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletpied"] = {
		label = "Gobelet a Pied",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletsake"] = {
		label = "Gobelet de Sake",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletsheps"] = {
		label = "Gobelet de Sheps",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobelettropicana"] = {
		label = "Gobelelet de Tropicana",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletvide"] = {
		label = "Gobelet vide",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gobeletvolvic"] = {
		label = "Gobelet de Volvic",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["goldbar"] = {
		label = "Gold Bar",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["goldm"] = {
		label = "WEAPON_GOLDM",
		weight = 1,
		stack = true,
		close = true,
	},

	["goldnecklace"] = {
		label = "Gold Necklace",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["goldwatch"] = {
		label = "Gold Watch",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["gold_phone"] = {
		label = "Gold Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["golem"] = {
		label = "Golem",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["golfclub"] = {
		label = "Club de golf",
		weight = 2.5,
		stack = true,
		close = true,
	},

	["grandefrite"] = {
		label = "Grande Frite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["grandefroidfrite"] = {
		label = "Grande Frite Froid",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["grand_cru"] = {
		label = "Grand cru",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["grapperaisin"] = {
		label = "Grappe de raisin",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["grau"] = {
		label = "WEAPON_GRAU",
		weight = 1,
		stack = true,
		close = true,
	},

	["greenlight_phone"] = {
		label = "Green Light Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["green_phone"] = {
		label = "Téléphone Vert",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["grenade"] = {
		label = "Grenade",
		weight = 1,
		stack = true,
		close = true,
	},

	["grenadelauncher"] = {
		label = "Lance-grenades",
		weight = 4,
		stack = true,
		close = true,
	},

	["grenadelauncher_ammo"] = {
		label = "Munitions pour lance-grenades",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["grenadelauncher_smoke_ammo"] = {
		label = "Grenades fumigènes pour lance-grenades",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["gr_prop_gr_chair02_ped"] = {
		label = "Chaise bleu",
		weight = 5,
		stack = true,
		close = true,
	},

	["gr_prop_highendchair_gr_01a"] = {
		label = "Chaise gaming rouge",
		weight = 5,
		stack = true,
		close = true,
	},

	["gusenberg"] = {
		label = "Balayeuse Gusenberg",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["gzgas_ammo"] = {
		label = "Munitions pour gaz lacrymogène",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["hackerDevice"] = {
		label = "Hacker Device",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["hack_laptop"] = {
		label = "Ordinateur Portable",
		weight = 1,
		stack = true,
		close = true,
	},

	["hack_phone"] = {
		label = "Téléphone Jailbreak",
		weight = 1,
		stack = true,
		close = true,
	},

	["hammer"] = {
		label = "Marteau",
		weight = 2,
		stack = true,
		close = true,
	},

	["hammerwirecutter"] = {
		label = "Hammer And Wire Cutter",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["hareng"] = {
		label = "Hareng",
		weight = 0,
		stack = true,
		close = true,
	},

	["haschich"] = {
		label = "Haschich",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["haschich_pooch"] = {
		label = "Haschich",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["hashish"] = {
		label = "Hashish",
		weight = 0.7,
		stack = true,
		close = true,
	},

	["hashish_pooch"] = {
		label = "Pochon de Hashish",
		weight = 1,
		stack = true,
		close = true,
	},

	["hatchet"] = {
		label = "hatchet",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["heavypistol"] = {
		label = "Pistolet lourd",
		weight = 2,
		stack = true,
		close = true,
	},

	["heavyrifle"] = {
		label = "WEAPON_HEAVYRIFLE",
		weight = 1,
		stack = true,
		close = true,
	},

	["heavyshotgun"] = {
		label = "Saiga-12K",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["heavysniper"] = {
		label = "Sniper lourd",
		weight = 4,
		stack = true,
		close = true,
	},

	["heavysniper_mk2"] = {
		label = "Sniper lourd MK2",
		weight = 4,
		stack = true,
		close = true,
	},

	["heineken"] = {
		label = "Heineken",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["hell"] = {
		label = "WEAPON_HELL",
		weight = 1,
		stack = true,
		close = true,
	},

	["hellsniper"] = {
		label = "WEAPON_HELLSNIPER",
		weight = 1,
		stack = true,
		close = true,
	},

	["hk416"] = {
		label = "HK 416",
		weight = 3,
		stack = true,
		close = true,
	},

	["hkump"] = {
		label = "HK UMP",
		weight = 3,
		stack = true,
		close = true,
	},

	["hominglauncher"] = {
		label = "Lance-missiles guidé",
		weight = 4,
		stack = true,
		close = true,
	},

	["honeybadgercod"] = {
		label = "Honey Badger (COD)",
		weight = 4,
		stack = true,
		close = true,
	},

	["hornys_glace"] = {
		label = "Glace",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["hydrochloric_acid"] = {
		label = "Acide chlorhydrique",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["ice"] = {
		label = "Glaçon",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["icetea"] = {
		label = "Ice Tea",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["idcard"] = {
		label = "Carte d'Identité",
		weight = 0,
		stack = true,
		close = true,
	},

	["id_card"] = {
		label = "Carte d'identité",
		weight = 1,
		stack = true,
		close = true,
	},

	["id_card_f"] = {
		label = "Malicious Access Card",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["ing"] = {
		label = "ingredient a pizza",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["jager"] = {
		label = "Jägermeister",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["jagerbomb"] = {
		label = "Jägerbomb",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["jagercerbere"] = {
		label = "Jäger Cerbère",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["jaguar"] = {
		label = "Jaguar",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["jewels"] = {
		label = "Bijoux",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["job_card"] = {
		label = "Carte professionnelle",
		weight = 1,
		stack = true,
		close = true,
	},

	["jumelles"] = {
		label = "Jumelles",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["jusfruit"] = {
		label = "Jus de fruits",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["jus_raisin"] = {
		label = "Vin",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["karambitknife"] = {
		label = "Karambit Knife",
		weight = 1,
		stack = true,
		close = true,
	},

	["katana"] = {
		label = "Katana",
		weight = 1,
		stack = true,
		close = true,
	},

	["kevlar"] = {
		label = "Kevlar",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["kevlarlow"] = {
		label = "Kevlar en mauvais état",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["kevlarmid"] = {
		label = "Kevlar en bon état",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["kinetic"] = {
		label = "WEAPON_KINETIC",
		weight = 1,
		stack = true,
		close = true,
	},

	["kitcarro"] = {
		label = "Kit Carosserie",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["kitmoteur"] = {
		label = "Kit Moteur",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["knife"] = {
		label = "Couteau",
		weight = 1,
		stack = true,
		close = true,
	},

	["knuckle"] = {
		label = "Knuckledusters",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["kq_acetone"] = {
		label = "Acétone",
		weight = 2,
		stack = true,
		close = true,
	},

	["kq_ammonia"] = {
		label = "Ammoniaque",
		weight = 2,
		stack = true,
		close = true,
	},

	["kq_ethanol"] = {
		label = "Éthanol",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["kq_lithium"] = {
		label = "Pack de lithium",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["kq_meth_high"] = {
		label = "Méthamphétamine (Haute qualité)",
		weight = 1,
		stack = true,
		close = true,
	},

	["kq_meth_lab_kit"] = {
		label = "Kit de cuisson",
		weight = 5,
		stack = true,
		close = true,
	},

	["kq_meth_low"] = {
		label = "Méthamphétamine (Qualité basse)",
		weight = 1,
		stack = true,
		close = true,
	},

	["kq_meth_mid"] = {
		label = "Méthamphétamine (Qualité moyenne)",
		weight = 1,
		stack = true,
		close = true,
	},

	["kq_meth_pills"] = {
		label = "Pseudoéphédrine",
		weight = 0.4,
		stack = true,
		close = true,
	},

	["lapin"] = {
		label = "Lapin",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["lbd"] = {
		label = "WEAPON_lbd",
		weight = 1,
		stack = true,
		close = true,
	},

	["letter"] = {
		label = "Courrier",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["lgcougar"] = {
		label = "WEAPON_LGCOUGAR",
		weight = 1,
		stack = true,
		close = true,
	},

	["lieu"] = {
		label = "Lieu",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["limonade"] = {
		label = "Limonade",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["loup"] = {
		label = "Loup",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["m19"] = {
		label = "WEAPON_M19",
		weight = 1,
		stack = true,
		close = true,
	},

	["m4beast"] = {
		label = "WEAPON_M4BEAST",
		weight = 1,
		stack = true,
		close = true,
	},

	["m4goldbeast"] = {
		label = "WEAPON_M4GOLDBEAST",
		weight = 1,
		stack = true,
		close = true,
	},

	["m6ic"] = {
		label = "M6 IC",
		weight = 4,
		stack = true,
		close = true,
	},

	["m9a3"] = {
		label = "M9A3 Pistol",
		weight = 2,
		stack = true,
		close = true,
	},

	["m9bayonnetlore"] = {
		label = "M9 Bayonet Lore",
		weight = 1,
		stack = true,
		close = true,
	},

	["machete"] = {
		label = "machete",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["machinepistol"] = {
		label = "TEC-9",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["macro"] = {
		label = "Macro",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["maille"] = {
		label = "Maille de Chaine",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["malboro"] = {
		label = "Marlboro",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["mangoloco"] = {
		label = "Mangoloco",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["marksmanpistol"] = {
		label = "Thompson-Center Contender G2",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["marksmanrifle"] = {
		label = "Fusil Marksman",
		weight = 4,
		stack = true,
		close = true,
	},

	["marksmanrifle_mk2"] = {
		label = "Marksman Rifle MK2",
		weight = 4,
		stack = true,
		close = true,
	},

	["martini"] = {
		label = "Martini blanc",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["maze"] = {
		label = "WEAPON_MAZE",
		weight = 1,
		stack = true,
		close = true,
	},

	["mcxspear"] = {
		label = "MCX Spear",
		weight = 4,
		stack = true,
		close = true,
	},

	["mdma"] = {
		label = "MDMA",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["melted_steel"] = {
		label = "Acier Fondue",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["menthe"] = {
		label = "Feuille de menthe",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["mer_lures"] = {
		label = "Appât d'Eau de Mer",
		weight = 0,
		stack = true,
		close = true,
	},

	["meth"] = {
		label = "Meth",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["methpure"] = {
		label = "Méthamphétamine pure",
		weight = 1,
		stack = true,
		close = true,
	},

	["meth_pooch"] = {
		label = "Pochon de Meth",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["metreshooter"] = {
		label = "Mètre de shooter",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["mg"] = {
		label = "Mitrailleuse MG",
		weight = 4,
		stack = true,
		close = true,
	},

	["mg_ammo"] = {
		label = "Munitions pour mitrailleuse",
		weight = 0,
		stack = true,
		close = true,
	},

	["microsmg"] = {
		label = "Micro Uzi",
		weight = 2,
		stack = true,
		close = true,
	},

	["midasgun"] = {
		label = "WEAPON_MIDASGUN",
		weight = 1,
		stack = true,
		close = true,
	},

	["midgard"] = {
		label = "WEAPON_MIDGARD",
		weight = 1,
		stack = true,
		close = true,
	},

	["militarm4"] = {
		label = "WEAPON_MILITARM4",
		weight = 1,
		stack = true,
		close = true,
	},

	["militaryrifle"] = {
		label = "WEAPON_MILITARYRIFLE",
		weight = 1,
		stack = true,
		close = true,
	},

	["minigun"] = {
		label = "Minigun",
		weight = 4,
		stack = true,
		close = true,
	},

	["minigun_ammo"] = {
		label = "Munitions pour Minigun",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["minismg"] = {
		label = "Mini Uzi",
		weight = 2,
		stack = true,
		close = true,
	},

	["mixapero"] = {
		label = "Mix Apéritif",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["mochi"] = {
		label = "Mochi",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["mojito"] = {
		label = "Mojito",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["molotov"] = {
		label = "Cocktail Molotov",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["molotov_ammo"] = {
		label = "Munitions pour cocktails Molotov",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["morgane"] = {
		label = "Captaine Morgane",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["moteur"] = {
		label = "Moteur",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["moyennefrite"] = {
		label = "Moyenne Frite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["moyennefroidfrite"] = {
		label = "Moyenne Frite Froid",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["mp5sdfm"] = {
		label = "MP5 SD Full Metal",
		weight = 3,
		stack = true,
		close = true,
	},

	["musket"] = {
		label = "Mousquet",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["neonbox"] = {
		label = "Neon Box",
		weight = 1,
		stack = true,
		close = true,
	},

	["neoncontroller"] = {
		label = "Neon Controller",
		weight = 1,
		stack = true,
		close = true,
	},

	["nightstick"] = {
		label = "Matraque",
		weight = 2,
		stack = true,
		close = true,
	},

	["nightvision"] = {
		label = "Vision nocturne",
		weight = 2,
		stack = true,
		close = true,
	},

	["nioki"] = {
		label = "Nioki Lustukru",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["nitrovehicle"] = {
		label = "Nitro",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["nouille"] = {
		label = "Portion de nouille",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["oblivion"] = {
		label = "WEAPON_OBLIVION",
		weight = 1,
		stack = true,
		close = true,
	},

	["oblivionPill"] = {
		label = "Pilule de l'oubli",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["ocean_lures"] = {
		label = "Appât d'Eau Profonde",
		weight = 0,
		stack = true,
		close = true,
	},

	["okonomiyaki"] = {
		label = "Okonomiyaki",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["opium"] = {
		label = "Opium",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["opium_pooch"] = {
		label = "Pochon d'Opium",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["orange"] = {
		label = "Orange",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["orientale"] = {
		label = "Pizza orientale",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pacific_brochettes"] = {
		label = "Brochettes de fruits frais",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pacific_chips"] = {
		label = "Chips de banane plantain",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pacific_coco"] = {
		label = "Eau de coco",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pacific_margarita"] = {
		label = "Margarita ",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pacific_mojito"] = {
		label = "Mojito ",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pacific_pina"] = {
		label = "Piña Colada",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pacific_smoothie"] = {
		label = "Smoothie tropical",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["papierblanc"] = {
		label = "Papier Blanc",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["papiermache"] = {
		label = "Papier maché",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pastis"] = {
		label = "Pastis",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pate"] = {
		label = "Pate a pizza",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pattecuite"] = {
		label = "Patte à Pizza Cuite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pc"] = {
		label = "Pc",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pearls_crevette"] = {
		label = "Crevette",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pearls_fish"] = {
		label = "Poisson",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pearls_fishandchips"] = {
		label = "Fish And Chips",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pearls_frite"] = {
		label = "Frite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pearls_moule"] = {
		label = "Moule",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pearls_moulefrite"] = {
		label = "Moule Frite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["penis"] = {
		label = "WEAPON_PENIS",
		weight = 1,
		stack = true,
		close = true,
	},

	["pepsi"] = {
		label = "Pepsi",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["petitefrite"] = {
		label = "Petite Frite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["petitefroidfrite"] = {
		label = "Petite Frite Froid",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["petrolcan"] = {
		label = "Jerrycan",
		weight = 4,
		stack = true,
		close = true,
	},

	["phone_hack"] = {
		label = "Phone Hack",
		weight = 10,
		stack = true,
		close = true,
	},

	["phone_module"] = {
		label = "Phone Module",
		weight = 10,
		stack = true,
		close = true,
	},

	["phosphorerouge"] = {
		label = "Phosphore rouge",
		weight = 0.2,
		stack = true,
		close = true,
	},

	["pibwasser"] = {
		label = "Pibwasser",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pince"] = {
		label = "Pince",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pink_phone"] = {
		label = "Pink Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["pipebomb"] = {
		label = "Bombe artisanale",
		weight = 2.5,
		stack = true,
		close = true,
	},

	["pistol"] = {
		label = "Beretta",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["pistol50"] = {
		label = "Desert Eagle",
		weight = 2,
		stack = true,
		close = true,
	},

	["pistolxm3"] = {
		label = "Pistol XM3",
		weight = 2,
		stack = true,
		close = true,
	},

	["pistol_ammo"] = {
		label = "Munitions pour pistolet",
		weight = 0,
		stack = true,
		close = true,
	},

	["pistol_mk2"] = {
		label = "Pistolet Sig Sauer P226 MK2",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["pizza"] = {
		label = "Pizza",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pizzapate"] = {
		label = "Pate a Pizza",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pizzasavoyarde"] = {
		label = " Savoyarde",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["plane_rocket_ammo"] = {
		label = "Munitions pour roquettes aériennes",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["player_laser_ammo"] = {
		label = "Munitions pour laser joueur",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["pneu"] = {
		label = "Pneu",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pochon_meth"] = {
		label = "Pochon De Meth",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pochon_opium"] = {
		label = "Pochon D'Opium",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pochon_weed"] = {
		label = "Pochon De Weed",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["poisson"] = {
		label = "Portion de poisson",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["poissonchat"] = {
		label = "Poisson Chat",
		weight = 0,
		stack = true,
		close = true,
	},

	["poolcue"] = {
		label = "Queue de billard",
		weight = 2,
		stack = true,
		close = true,
	},

	["poolreceipt"] = {
		label = "Reçu de piscine",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pops_donut"] = {
		label = "Donut",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pops_granité"] = {
		label = "Granité",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pops_hotdog"] = {
		label = "Hot Dog",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pops_sauce"] = {
		label = "Sauce",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["pops_saucisse"] = {
		label = "Saucisse",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["porc"] = {
		label = "Portion de Porc",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["potatos"] = {
		label = "Potatos",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["poulet"] = {
		label = "Portion de Poulet",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["powerbank"] = {
		label = "Power Bank",
		weight = 10,
		stack = true,
		close = true,
	},

	["predator"] = {
		label = "WEAPON_PREDATOR",
		weight = 1,
		stack = true,
		close = true,
	},

	["produitchimique"] = {
		label = "Produit Chimique",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["prop_armchair_01"] = {
		label = "Fauteuil 4",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_arm_wrestle_01"] = {
		label = "Table Bras de Fer",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_a_base_bars_01"] = {
		label = "Bar de Traction",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_01"] = {
		label = "Muscu 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_02"] = {
		label = "Muscu 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_100kg"] = {
		label = "Muscu 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_10kg"] = {
		label = "Muscu 4",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_20kg"] = {
		label = "Muscu 5",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_40kg"] = {
		label = "Muscu 6",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_60kg"] = {
		label = "Muscu 7",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_80kg"] = {
		label = "Muscu 8",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_barbell_junk"] = {
		label = "Muscu 9",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_chair_01a"] = {
		label = "Chaise en métal 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_chair_01b"] = {
		label = "Chaise en métal 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_chair_03"] = {
		label = "Vielle chaise",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_chair_08"] = {
		label = "Chaise en plastique blanc",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_chateau_chair_01"] = {
		label = "Chaise tressé rouge",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_cs_office_chair"] = {
		label = "Chaise de bureau",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_cs_office_chair_01"] = {
		label = "Chaise bleu cassé",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_cs_office_chair_02"] = {
		label = "Chaise métallique",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_cs_office_chair_03"] = {
		label = "Chaise verte cassé",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_direct_chair_01"] = {
		label = "Chaise en bois 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_direct_chair_02"] = {
		label = "Chaise en bois 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_fib_3b_bench"] = {
		label = "Chaise 3 places",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_fleeca_atm"] = {
		label = "Cintre mural 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_ld_farm_chair01"] = {
		label = "Ancien canapé 1 place",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_ld_farm_couch01"] = {
		label = "Ancien canapé 3 places",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_ld_farm_couch02"] = {
		label = "Vieux canapé rayé",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_off_chair_01"] = {
		label = "Siège de bureau 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_off_chair_03"] = {
		label = "Siège de bureau 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_off_chair_04"] = {
		label = "Siège de bureau 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_punch_bag_l"] = {
		label = "Sac de Boxe",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_rub_couch02"] = {
		label = "Canapé 9",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_scrim_02"] = {
		label = "Tableau",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_skid_chair_01"] = {
		label = "Chaise de camping 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_skid_chair_02"] = {
		label = "Chaise de camping 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_skid_chair_03"] = {
		label = "Chaise de camping 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_sol_chair"] = {
		label = "Fauteuil en cuir",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_table_03b_chr"] = {
		label = "Chaise Plastique 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_table_03_chr"] = {
		label = "Chaise Plastique",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_table_08_chr"] = {
		label = "Banc en bois",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_torture_ch_01"] = {
		label = "Chaise de torture",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_t_sofa_02"] = {
		label = "Lit 9",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_weight_squat"] = {
		label = "Muscu 10",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_weight_squat_02"] = {
		label = "Muscu 11",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_yacht_lounger"] = {
		label = "Siège transat 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_yacht_seat_01"] = {
		label = "Siège transat 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_yacht_seat_02"] = {
		label = "Siège transat 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_yacht_seat_03"] = {
		label = "Siège transat 4",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_yoga_mat_01"] = {
		label = "Tapis de yoga 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_yoga_mat_02"] = {
		label = "Tapis de yoga 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["prop_yoga_mat_03"] = {
		label = "Tapis de yoga 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["proxmine"] = {
		label = "Mine de proximité",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["pumpkin-rifle"] = {
		label = "WEAPON_PUMPKIN",
		weight = 1,
		stack = true,
		close = true,
	},

	["pumpshotgun"] = {
		label = "Fusil à pompe",
		weight = 4,
		stack = true,
		close = true,
	},

	["pumpshotgun_mk2"] = {
		label = "Fusil à pompe MK2",
		weight = 4,
		stack = true,
		close = true,
	},

	["pure_meth_pills"] = {
		label = "Pseudoéphédrine pure",
		weight = 0.4,
		stack = true,
		close = true,
	},

	["p_armchair_01_s"] = {
		label = "Fauteuil 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["p_dinechair_01_s"] = {
		label = "Chaise en bois rare",
		weight = 5,
		stack = true,
		close = true,
	},

	["p_lestersbed_s"] = {
		label = "Lit 11",
		weight = 5,
		stack = true,
		close = true,
	},

	["p_mbbed_s"] = {
		label = "Lit 12",
		weight = 5,
		stack = true,
		close = true,
	},

	["p_v_res_tt_bed_s"] = {
		label = "Lit 13",
		weight = 5,
		stack = true,
		close = true,
	},

	["p_yacht_chair_01_s"] = {
		label = "Fauteuil en paille noir",
		weight = 5,
		stack = true,
		close = true,
	},

	["p_yacht_sofa_01_s"] = {
		label = "Canapé en paille noir",
		weight = 5,
		stack = true,
		close = true,
	},

	["raie"] = {
		label = "Raie",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["railgun"] = {
		label = "Canon à rail",
		weight = 4,
		stack = true,
		close = true,
	},

	["raisin"] = {
		label = "Raisin",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["ramen"] = {
		label = " Ramen",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["raspberry"] = {
		label = "Raspberry",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["reco_burgershot"] = {
		label = "Pain",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["reco_ferrailleur"] = {
		label = "Ferraille Rouillée",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["reco_petitpecheur"] = {
		label = "Poisson Frais",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["reco_tabac"] = {
		label = "Tabac",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["reco_vigneron"] = {
		label = "Raisin",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["red_phone"] = {
		label = "Red Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["reine"] = {
		label = "Pizza reine",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["remotesniper"] = {
		label = "Sniper télécommandé",
		weight = 4,
		stack = true,
		close = true,
	},

	["repairkit"] = {
		label = "Kit de réparation",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["requin"] = {
		label = "Requin",
		weight = 0,
		stack = true,
		close = true,
	},

	["revolver"] = {
		label = "Revolver lourd",
		weight = 2.5,
		stack = true,
		close = true,
	},

	["revolverultra"] = {
		label = "WEAPON_REVOLVERULTRA",
		weight = 1,
		stack = true,
		close = true,
	},

	["revolvervamp"] = {
		label = "WEAPON_REVOLVERVAMP",
		weight = 1,
		stack = true,
		close = true,
	},

	["revolver_mk2"] = {
		label = "Revolver MK2",
		weight = 2.5,
		stack = true,
		close = true,
	},

	["rhum"] = {
		label = "Rhum",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["rhumcoca"] = {
		label = "Rhum-coca",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["rhumfruit"] = {
		label = "Rhum-jus de fruits",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["ricard"] = {
		label = "Ricard",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["rifle_ammo"] = {
		label = "Munitions pour fusil",
		weight = 0,
		stack = true,
		close = true,
	},

	["riz"] = {
		label = "Portion de riz",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["rpg"] = {
		label = "RPG",
		weight = 4,
		stack = true,
		close = true,
	},

	["rpg_ammo"] = {
		label = "Munitions pour RPG",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["sac_poubelle"] = {
		label = "Sac Poubelle",
		weight = 0.2,
		stack = true,
		close = true,
	},

	["salami"] = {
		label = "Salami",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sanglier"] = {
		label = "Sanglier",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sardine"] = {
		label = "sardine",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sauce"] = {
		label = "Portion de sauce",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["saucisson"] = {
		label = "Saucisson",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["saumon"] = {
		label = "saumon",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["saumons"] = {
		label = "Pizza au saumon",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sawnoffshotgun"] = {
		label = "Fusil à canon scié",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["scar-17-lshop"] = {
		label = "WEAPON_SCAR17",
		weight = 1,
		stack = true,
		close = true,
	},

	["scar17fm"] = {
		label = "SCAR 17 Full Metal",
		weight = 4,
		stack = true,
		close = true,
	},

	["scarsc"] = {
		label = "WEAPON_SCARSC",
		weight = 1,
		stack = true,
		close = true,
	},

	["secure_card"] = {
		label = "Secure ID Card",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sfrites"] = {
		label = "Sachet de Frite surgele",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["shark"] = {
		label = "Shark",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["shisha"] = {
		label = "Shisha",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["shotgunk"] = {
		label = "WEAPON_SHOTGUNK",
		weight = 1,
		stack = true,
		close = true,
	},

	["shotgun_ammo"] = {
		label = "Munitions pour fusil à pompe",
		weight = 0,
		stack = true,
		close = true,
	},

	["sig550"] = {
		label = "WEAPON_SIG550",
		weight = 1,
		stack = true,
		close = true,
	},

	["silure"] = {
		label = "Silure",
		weight = 0,
		stack = true,
		close = true,
	},

	["sim"] = {
		label = "Carte-SIM",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["siredward"] = {
		label = "Sir Edward",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sledgehammer"] = {
		label = "Sledgehammer",
		weight = 4,
		stack = true,
		close = true,
	},

	["smg"] = {
		label = "Mitraillette MP5",
		weight = 3,
		stack = true,
		close = true,
	},

	["smg_ammo"] = {
		label = "Munitions pour mitraillette",
		weight = 0,
		stack = true,
		close = true,
	},

	["smg_mk2"] = {
		label = "SMG MK2",
		weight = 3,
		stack = true,
		close = true,
	},

	["smokegrenade"] = {
		label = "Grenade fumigène",
		weight = 1,
		stack = true,
		close = true,
	},

	["smokegrenade_ammo"] = {
		label = "Munitions pour grenades fumigènes",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["sm_prop_offchair_smug_01"] = {
		label = "Fauteuil de bureau noir",
		weight = 5,
		stack = true,
		close = true,
	},

	["sm_prop_offchair_smug_02"] = {
		label = "Fauteuil de bureau blanc",
		weight = 5,
		stack = true,
		close = true,
	},

	["snake"] = {
		label = "WEAPON_SNAKE",
		weight = 1,
		stack = true,
		close = true,
	},

	["sniperrifle"] = {
		label = "Fusil de sniper",
		weight = 4,
		stack = true,
		close = true,
	},

	["sniper_ammo"] = {
		label = "Munitions pour sniper",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["sniper_remote_ammo"] = {
		label = "Munitions pour sniper télécommandé",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["snowball"] = {
		label = "Boule de neige",
		weight = 0.5,
		stack = true,
		close = true,
	},

	["snspistol"] = {
		label = "Pistolet SNS",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["snspistol_mk2"] = {
		label = "Pistolet SNS MK2",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["soda"] = {
		label = "Soda",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sole"] = {
		label = "sole",
		weight = 0,
		stack = true,
		close = true,
	},

	["soudeuse"] = {
		label = "Poste à souder",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sovereign"] = {
		label = "WEAPON_SOVEREIGN",
		weight = 1,
		stack = true,
		close = true,
	},

	["space_rocket_ammo"] = {
		label = "Munitions pour fusées spatiales",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["specialcarbine"] = {
		label = "Carabine spéciale",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["specialcarbine_mk2"] = {
		label = "Carabine spéciale MK2",
		weight = 3.5,
		stack = true,
		close = true,
	},

	["specialhammer"] = {
		label = "WEAPON_SPECIALHAMMER",
		weight = 1,
		stack = true,
		close = true,
	},

	["spiderak"] = {
		label = "WEAPON_SPIDERAK",
		weight = 1,
		stack = true,
		close = true,
	},

	["spotatoss"] = {
		label = "Sachet de Potatos surgele",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["spray_remover"] = {
		label = "Eponge",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sprite"] = {
		label = "Sprite",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["steellingo"] = {
		label = "Lingot Acier",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["stickybomb"] = {
		label = "Bombe collante",
		weight = 2,
		stack = true,
		close = true,
	},

	["stickybomb_ammo"] = {
		label = "Munitions pour bombes collantes",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["stinger"] = {
		label = "Lance-missiles Stinger",
		weight = 4,
		stack = true,
		close = true,
	},

	["stinger_ammo"] = {
		label = "Munitions pour lance-missiles Stinger",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["stungun"] = {
		label = "Taser",
		weight = 1,
		stack = true,
		close = true,
	},

	["stungun_ammo"] = {
		label = "Munitions pour taser",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["sundayfraise"] = {
		label = "Sunday Fraise",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sundaynature"] = {
		label = "Sunday Nature",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sushi"] = {
		label = "Sushi",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["sw"] = {
		label = "Sandwich",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["switchblade"] = {
		label = "Couteau pliant",
		weight = 1,
		stack = true,
		close = true,
	},

	["tabacblond"] = {
		label = "Tabac Blond",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tabacblondsec"] = {
		label = "Tabac Blond Séché",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tabacbrun"] = {
		label = "Tabac Brun",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tabacbrunsec"] = {
		label = "Tabac Brun Séché",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tableau"] = {
		label = "Tableau",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tablet"] = {
		label = "Tablet",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacos2"] = {
		label = "Tacos 2 viandes",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacos3"] = {
		label = "Tacos 3 viandes",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacosfroid2"] = {
		label = "Tacos 2 viandes Froid",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacosfroid3"] = {
		label = "Tacos 3 viandes Froid",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacosfroidxll"] = {
		label = "Tacos XXL Froid",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacosl"] = {
		label = "Tacos L",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacosm"] = {
		label = "Tacos M",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacosxl"] = {
		label = "Tacos XL",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tacosxll"] = {
		label = "Tacos XXL",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tank_ammo"] = {
		label = "Obus pour tank",
		weight = 0.1,
		stack = true,
		close = true,
	},

	["tec9m"] = {
		label = "WEAPON_TEC9M",
		weight = 1,
		stack = true,
		close = true,
	},

	["tec9mb"] = {
		label = "WEAPON_TEC9MB",
		weight = 1,
		stack = true,
		close = true,
	},

	["tec9mf"] = {
		label = "WEAPON_TEC9MF",
		weight = 1,
		stack = true,
		close = true,
	},

	["tel"] = {
		label = "Téléphone",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tele"] = {
		label = "Télé",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["teqpaf"] = {
		label = "Teq'paf",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tequila"] = {
		label = "Tequila",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["terre"] = {
		label = "Terre",
		weight = 0.5,
		stack = true,
		close = true,
	},

	["thermite"] = {
		label = "Thermite",
		weight = 1,
		stack = true,
		close = true,
	},

	["thon"] = {
		label = "thon",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["tomate"] = {
		label = "Tomate",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["trait_burgershot"] = {
		label = "Colis",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["trait_ferrailleur"] = {
		label = "Ferraille Traitée",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["trait_petitpecheur"] = {
		label = "Poisson Frit",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["trait_tabac"] = {
		label = "Cigarette",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["trait_vigneron"] = {
		label = "Vin",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["treatedsteel"] = {
		label = "Lingot Acier Traité",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["turtle"] = {
		label = "Sea Turtle",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["turtlebait"] = {
		label = "Turtle Bait",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["unicorn_jusorange"] = {
		label = "Jus d'orange pressé",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["unicorn_miniburger"] = {
		label = "Mini-burgers sliders",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["unicorn_pepsi"] = {
		label = "Pepsi ",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["unicorn_poulet"] = {
		label = "Ailes de poulet épicées",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["unicorn_tequila"] = {
		label = "Tequila Sunrise",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["unicorn_vodka"] = {
		label = "Vodka Martini",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["unicorn_wisky"] = {
		label = "Whisky sour",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["usbhacked"] = {
		label = "Clé USB illégale",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["uzi"] = {
		label = "WEAPON_UZILS",
		weight = 1,
		stack = true,
		close = true,
	},

	["vase"] = {
		label = "Vase",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["vehicle_case"] = {
		label = "Caisse Véhicules",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["viande"] = {
		label = "Portion de viande",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["victusxmr"] = {
		label = "Victus XMR",
		weight = 5,
		stack = true,
		close = true,
	},

	["vinblanc"] = {
		label = "Vin Blanc",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["vinrose"] = {
		label = "Rose",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["vinrouge"] = {
		label = "Vin Rouge",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["vintagepistol"] = {
		label = "Pistolet vintage",
		weight = 1.5,
		stack = true,
		close = true,
	},

	["vodka"] = {
		label = "Vodka",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["vodkaenergy"] = {
		label = "Vodka-energy",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["vodkafruit"] = {
		label = "Vodka-jus de fruits",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["vp9"] = {
		label = "VP9",
		weight = 2,
		stack = true,
		close = true,
	},

	["vsco"] = {
		label = "WEAPON_VSCO",
		weight = 1,
		stack = true,
		close = true,
	},

	["v_16_high_pln_m_map"] = {
		label = "Carte de la ville",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_corp_cd_recseat"] = {
		label = "Canapé en cuir noir",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_corp_facebeanbag"] = {
		label = "Pouf rose",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_corp_facebeanbagc"] = {
		label = "Pouf violet",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_corp_facebeanbagd"] = {
		label = "Pouf bleu",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_corp_offchair"] = {
		label = "Chaise de bureau",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ilev_fh_kitchenstool"] = {
		label = "Chaise de cuisine",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ilev_p_easychair"] = {
		label = "Chaise confortable",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_med_fabricchair1"] = {
		label = "Fauteuil vert",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_med_p_deskchair"] = {
		label = "Chaise de bureau",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_med_p_easychair"] = {
		label = "Petit canapé",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_med_whickerchair1"] = {
		label = "Chaise Whicker",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_d_armchair"] = {
		label = "Ancien canapé jaune 1 place",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_d_bed"] = {
		label = "Lit 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_d_highchair"] = {
		label = "Chaise haute",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_d_sofa"] = {
		label = "Canapé 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fa_chair01"] = {
		label = "Chaise",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fa_chair02"] = {
		label = "Chaise",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_barcchair"] = {
		label = "Chaise haute",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_benchshort"] = {
		label = "Banc d'extérieur métalique",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_dineeamesa"] = {
		label = "Chaise de salle à manger 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_dineeamesb"] = {
		label = "Chaise de salle à manger 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_dineeamesc"] = {
		label = "Chaise de salle à manger 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_easychair"] = {
		label = "Chaise",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_kitnstool"] = {
		label = "Tabouret",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_pouf"] = {
		label = "Pouf cube",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_singleseat"] = {
		label = "Chaise haute",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_fh_sofa"] = {
		label = "Canapé d'angle",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_jarmchair"] = {
		label = "Fauteuil 1",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_j_dinechair"] = {
		label = "Chaise de salle à manger 4",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_j_sofa"] = {
		label = "Canapé ancien",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_j_stool"] = {
		label = "Tabouret",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_lestersbed"] = {
		label = "Lit 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_mbbed"] = {
		label = "Lit 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_mbbed_s"] = {
		label = "Muscu 12",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_mbchair"] = {
		label = "Chaise de bureau",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_mchalkbrd"] = {
		label = "Tableau de craie",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_mdbed"] = {
		label = "Lit 4",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_mp_sofa"] = {
		label = "Canapé d'angle 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_mp_stripchair"] = {
		label = "Canapé 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_msonbed"] = {
		label = "Lit 5",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_msonbed_s"] = {
		label = "Lit 10",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_m_armchair"] = {
		label = "Fauteuil 2",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_m_dinechair"] = {
		label = "Dine Chair",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_m_h_sofa_sml"] = {
		label = "Canapé ancien de luxe",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_r_sofa"] = {
		label = "Canapé 3",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_study_chair"] = {
		label = "Chaire d'étude",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_trev_framechair"] = {
		label = "Chaise",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_bed1"] = {
		label = "Lit 6",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_bed2"] = {
		label = "Lit 7",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_chair"] = {
		label = "Chaise",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_officechair"] = {
		label = "Chaise de bureau",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_sofa"] = {
		label = "Canapé 4",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_sofa_mess_a"] = {
		label = "Canapé 5",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_sofa_mess_b"] = {
		label = "Canapé 6",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_sofa_mess_c"] = {
		label = "Canapé 7",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_stool"] = {
		label = "Tabouret",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_stool_leather"] = {
		label = "Tabouret en cuir",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tre_stool_scuz"] = {
		label = "Tabouret en cuir détérioré",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tt_bed"] = {
		label = "Lit 8",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_res_tt_sofa"] = {
		label = "Canapé 8",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ret_chair"] = {
		label = "Chaise",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ret_chair_white"] = {
		label = "Chaise blanche",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ret_gc_chair01"] = {
		label = "Chaise 01",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ret_gc_chair02"] = {
		label = "Chaise 02",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ret_gc_chair03"] = {
		label = "Chaise en plastique cassé",
		weight = 5,
		stack = true,
		close = true,
	},

	["v_ret_ta_stool"] = {
		label = "Tabouret petit",
		weight = 5,
		stack = true,
		close = true,
	},

	["weapons_license"] = {
		label = "Permis de port d'arme",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed"] = {
		label = "Weed",
		weight = 0.7,
		stack = true,
		close = true,
	},

	["weed_pooch"] = {
		label = "Pochon de Weed",
		weight = 1,
		stack = true,
		close = true,
	},

	["wet_black_phone"] = {
		label = "Wet Black Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_blue_phone"] = {
		label = "Wet Blue Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_classic_phone"] = {
		label = "Wet Classic Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_gold_phone"] = {
		label = "Wet Gold Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_greenlight_phone"] = {
		label = "Wet Green Light Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_green_phone"] = {
		label = "Wet Green Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_phone"] = {
		label = "Wet Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_pink_phone"] = {
		label = "Wet Pink Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_red_phone"] = {
		label = "Wet Red Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_white_phone"] = {
		label = "Wet White Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["whisky"] = {
		label = "Whisky",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["whiskycoca"] = {
		label = "Whisky-coca",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["white_phone"] = {
		label = "White Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wire"] = {
		label = "Fil de fer",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wiwang_caviar"] = {
		label = "Caviar",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wiwang_cocktail"] = {
		label = "Cocktail Bora Bora",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wiwang_donperignon"] = {
		label = "Don Perignon",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wiwang_juspassion"] = {
		label = "Jus Passion Mangue",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wiwang_macarons"] = {
		label = "Macarons",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wiwang_ruinart"] = {
		label = "Ruinart",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wiwang_vin"] = {
		label = "Vin",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["wrench"] = {
		label = "Clé à molette",
		weight = 2,
		stack = true,
		close = true,
	},

	["xanax"] = {
		label = "Xanax",
		weight = 0.3,
		stack = true,
		close = true,
	},

	["yakitori"] = {
		label = "Yakitori",
		weight = 0.3,
		stack = true,
		close = true,
	},
}

local success, nevaItems = pcall(require, 'data.neva_items')
if success and nevaItems then
	for itemName, itemData in pairs(nevaItems) do
		items[itemName] = itemData
	end
end
local clothesSuccess, nevaClothes = pcall(require, 'data.neva_clothes_items')
if clothesSuccess and nevaClothes then
	for itemName, itemData in pairs(nevaClothes) do
		items[itemName] = itemData
	end
end

-- Ajouter les items TV avant le return
items["tvremote"] = {
	label = "TV Remote",
	weight = 1,
	stack = true,
	close = true,
}

items["vehicletv"] = {
	label = "Vehicle TV",
	weight = 1,
	stack = true,
	close = true,
}

return items
