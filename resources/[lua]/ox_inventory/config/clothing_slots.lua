return {
    
    equipmentSlots = {
        [51] = {type = 'hat', label = 'Chapeau'},
        [59] = {type = 'glasses', label = 'Lunettes'},
        [52] = {type = 'ears', label = 'Boucles d\'oreilles'},
        [58] = {type = 'mask', label = 'Masque'},
        [63] = {type = 'chain', label = 'Collier'},
        [53] = {type = 'tshirt', label = 'T-Shirt'},
        [54] = {type = 'torso', label = 'Torse'},
        [55] = {type = 'arms', label = 'Bras'},
        [60] = {type = 'vest', label = 'Gilet'},
        [61] = {type = 'bag', label = 'Sac'},
        [56] = {type = 'pants', label = 'Pantalon'},
        [57] = {type = 'shoes', label = 'Chaussures'},
        [62] = {type = 'watch', label = 'Montre'},
        [64] = {type = 'bracelet', label = 'Bracelet'},
    },
    
    clothingSlots = {
        51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64
    },
    
    clothingItems = {
        'clothes_hat',
        'clothes_ears',
        'clothes_glasses',
        'clothes_tshirt',
        'clothes_torso',
        'clothes_arms',
        'clothes_pants',
        'clothes_shoes',
        'clothes_mask',
        'clothes_vest',
        'clothes_bag',
        'clothes_watch',
        'clothes_chain',
        'clothes_bracelet',
        
        'outfit_saved',
    },

    clothingPatterns = {
        '^tshirt_%d+',      -- tshirt_15, tshirt_20, etc.
        '^torso_%d+',       -- torso_19, torso_31, etc.
        '^pants_%d+',       -- pants_24, pants_10, etc.
        '^shoes_%d+',       -- shoes_5, shoes_34, etc.
        '^arms_%d+',        -- arms_15, arms_0, etc.
        '^chains_%d+',      -- chains_0, chains_1, etc.
        '^mask_%d+',        -- mask_0, mask_121, etc.
        '^bags_%d+',        -- bags_0, bags_45, etc.
        '^hat_%d+',         -- hat_0, hat_58, etc.
        '^glasses_%d+',     -- glasses_0, glasses_5, etc.
        '^earrings_%d+',    -- earrings_0, earrings_2, etc.
        '^watches_%d+',     -- watches_0, watches_1, etc.
    },
    
    messages = {
        notClothingItem = 'Ce slot est réservé aux vêtements',
        notClothingSlot = 'Les vêtements doivent être placés dans les slots dédiés (51-64)',
        slotOccupied = 'Ce slot est déjà occupé',
    },
    
    forceClothingSlotsOnly = false,
    
    autoEquipOnPlace = true,
}

