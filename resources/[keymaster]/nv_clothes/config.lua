Config = {}

Config.ShowPedPreview = true

Config.ClothingSlots = {
	-- Format: ['itemName'] = {component = 'nom_component', prop = true/false}
	
	-- Props (accessoires)
	['clothes_hat'] = {
		components = {
			{name = 'helmet_1', prop = true, propId = 0},
			{name = 'helmet_2', prop = true, propId = 0}
		},
		defaultSkin = {
			male = {helmet_1 = -1, helmet_2 = -1},
			female = {helmet_1 = -1, helmet_2 = -1}
		}
	},
	
	['clothes_ears'] = {
		components = {
			{name = 'ears_1', prop = true, propId = 2},
			{name = 'ears_2', prop = true, propId = 2}
		},
		defaultSkin = {
			male = {ears_1 = -1, ears_2 = 0},
			female = {ears_1 = -1, ears_2 = 0}
		}
	},
	
	['clothes_glasses'] = {
		components = {
			{name = 'glasses_1', prop = true, propId = 1},
			{name = 'glasses_2', prop = true, propId = 1}
		},
		defaultSkin = {
			male = {glasses_1 = 0, glasses_2 = 0},
			female = {glasses_1 = 0, glasses_2 = 0}
		}
	},
	
	['clothes_watch'] = {
		components = {
			{name = 'watches_1', prop = true, propId = 6},
			{name = 'watches_2', prop = true, propId = 6}
		},
		defaultSkin = {
			male = {watches_1 = -1, watches_2 = 0},
			female = {watches_1 = -1, watches_2 = 0}
		}
	},
	
	['clothes_bracelet'] = {
		components = {
			{name = 'bracelets_1', prop = true, propId = 7},
			{name = 'bracelets_2', prop = true, propId = 7}
		},
		defaultSkin = {
			male = {bracelets_1 = -1, bracelets_2 = 0},
			female = {bracelets_1 = -1, bracelets_2 = 0}
		}
	},
	
	-- Components (vêtements)
	['clothes_tshirt'] = {
		components = {
			{name = 'tshirt_1', componentId = 8},
			{name = 'tshirt_2', componentId = 8}
		},
		defaultSkin = {
			male = {tshirt_1 = 15, tshirt_2 = 0},
			female = {tshirt_1 = 15, tshirt_2 = 0}
		}
	},
	
	['clothes_torso'] = {
		components = {
			{name = 'torso_1', componentId = 11},
			{name = 'torso_2', componentId = 11}
		},
		defaultSkin = {
			male = {torso_1 = 15, torso_2 = 0},
			female = {torso_1 = 15, torso_2 = 0}
		}
	},
	
	['clothes_arms'] = {
		components = {
			{name = 'arms', componentId = 3},
			{name = 'arms_2', componentId = 3}
		},
		defaultSkin = {
			male = {arms = 15, arms_2 = 0},
			female = {arms = 15, arms_2 = 0}
		}
	},
	
	['clothes_pants'] = {
		components = {
			{name = 'pants_1', componentId = 4},
			{name = 'pants_2', componentId = 4}
		},
		defaultSkin = {
			male = {pants_1 = 14, pants_2 = 0},
			female = {pants_1 = 14, pants_2 = 0}
		}
	},
	
	['clothes_shoes'] = {
		components = {
			{name = 'shoes_1', componentId = 6},
			{name = 'shoes_2', componentId = 6}
		},
		defaultSkin = {
			male = {shoes_1 = 34, shoes_2 = 0},
			female = {shoes_1 = 34, shoes_2 = 0}
		}
	},
	
	['clothes_mask'] = {
		components = {
			{name = 'mask_1', componentId = 1},
			{name = 'mask_2', componentId = 1}
		},
		defaultSkin = {
			male = {mask_1 = 0, mask_2 = 0},
			female = {mask_1 = 0, mask_2 = 0}
		}
	},
	
	['clothes_vest'] = {
		components = {
			{name = 'bproof_1', componentId = 9},
			{name = 'bproof_2', componentId = 9}
		},
		defaultSkin = {
			male = {bproof_1 = 0, bproof_2 = 0},
			female = {bproof_1 = 0, bproof_2 = 0}
		}
	},
	
	['clothes_bag'] = {
		components = {
			{name = 'bags_1', componentId = 5},
			{name = 'bags_2', componentId = 5}
		},
		defaultSkin = {
			male = {bags_1 = 0, bags_2 = 0},
			female = {bags_1 = 0, bags_2 = 0}
		}
	},
	
	['clothes_chain'] = {
		components = {
			{name = 'chain_1', componentId = 7},
			{name = 'chain_2', componentId = 7}
		},
		defaultSkin = {
			male = {chain_1 = 0, chain_2 = 0},
			female = {chain_1 = 0, chain_2 = 0}
		}
	},
}

-- ========================================
-- TOGGLE HAIR CONFIG
-- ========================================

Config.ToggleHair = {
	male = {37, 0},    -- hair et texture
	female = {0, 0}    -- hair et texture
}

