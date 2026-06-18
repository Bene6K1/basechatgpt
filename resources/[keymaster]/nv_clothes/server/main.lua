ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('neva:clothes:createItem', function(clothesData, itemType, outfitName)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if not xPlayer then return end
	
	local itemName = 'clothes_' .. itemType
	
	local metadata = {
		skin = clothesData,
		label = outfitName or ('Vêtement ' .. itemType),
		description = 'Acheté dans un magasin NEVA'
	}
	
	local success = exports.ox_inventory:AddItem(source, itemName, 1, metadata)
	
	if success then
		TriggerClientEvent('esx:showNotification', source, '~g~Vêtement ajouté à votre inventaire')
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Inventaire plein')
	end
end)

AddEventHandler('sunny:clotheshop:saveTenue', function(clothesArray, outfitName)
end)

AddEventHandler('nvCloth:addClothToInventory', function(playerId, itemType, itemName, clotheData)
	local clothingConfig = require '@ox_inventory/config/clothing_slots'

	local itemMapping = {
		tshirt = 'clothes_tshirt',
		torso = 'clothes_torso',
		pants = 'clothes_pants',
		shoes = 'clothes_shoes',
		arms = 'clothes_arms',
		chains = 'clothes_chain',
		mask = 'clothes_mask',
		bags = 'clothes_bag',
		hat = 'clothes_hat',
		glasses = 'clothes_glasses',
		earrings = 'clothes_ears',
		watches = 'clothes_watch',
		bproof = 'clothes_vest',
		vest = 'clothes_vest'
	}

	local slotTypeMapping = {
		bags = 'bag',
		chains = 'chain',
		earrings = 'ears',
		watches = 'watch',
		bproof = 'vest',
		vest = 'vest'
	}

	local oxItemName = itemMapping[itemType]
	if not oxItemName then
		return
	end

	local slotType = slotTypeMapping[itemType] or itemType
	local targetSlot, slotLabel

	for slot, slotConfig in pairs(clothingConfig.equipmentSlots) do
		if slotConfig.type == slotType then
			targetSlot = slot
			slotLabel = slotConfig.label
			break
		end
	end

	local metadata = {
		skin = clotheData,
		label = itemName or ('Vêtement ' .. (slotLabel or slotType)),
		description = 'Acheté dans nv_cloth'
	}

	local success = false

	if targetSlot then
		metadata.equipped = true
		-- Ajouter UNIQUEMENT dans le slot d'équipement, jamais dans l'inventaire normal
		success = exports.ox_inventory:AddItem(playerId, oxItemName, 1, metadata, targetSlot)

		if success then
			TriggerClientEvent('esx:showNotification', playerId, '~g~Vêtement ajouté et équipé automatiquement !')
		else
			-- Si le slot est occupé, ne pas ajouter dans l'inventaire normal si forceClothingSlotsOnly est true
			local clothingConfig = require '@ox_inventory/config/clothing_slots'
			if not clothingConfig.forceClothingSlotsOnly then
			metadata.equipped = false
			success = exports.ox_inventory:AddItem(playerId, oxItemName, 1, metadata)
			if success then
					TriggerClientEvent('esx:showNotification', playerId, ('Vêtement ajouté. Placez-le dans le slot %s (%s) pour l\'équiper'):format(targetSlot, slotLabel or slotType))
				end
			else
				TriggerClientEvent('esx:showNotification', playerId, ('~r~Slot %s (%s) déjà occupé. Retirez l\'item actuel pour équiper ce vêtement.'):format(targetSlot, slotLabel or slotType))
			end
		end
	else
		success = exports.ox_inventory:AddItem(playerId, oxItemName, 1, metadata)

		if success then
			TriggerClientEvent('esx:showNotification', playerId, '~g~Vêtement ajouté à votre inventaire')
		else
			print(('[nv_clothes] ERREUR: Impossible d\'ajouter l\'item %s au joueur %s (inventaire plein ou erreur)'):format(oxItemName, playerId))
			TriggerClientEvent('esx:showNotification', playerId, '~r~Erreur lors de l\'ajout du vêtement (inventaire plein ?)')
		end
	end

	-- Debug log pour vérifier le traitement des gilets
	if itemType == 'bproof' or itemType == 'vest' then
		print(('[nv_clothes] Gilet acheté - itemType: %s, oxItemName: %s, targetSlot: %s, success: %s'):format(itemType, oxItemName, targetSlot or 'nil', tostring(success)))
	end

	if not success then
		print(('[nv_clothes] ERREUR FINALE: Impossible d\'ajouter le vêtement %s au joueur %s'):format(oxItemName or 'unknown', playerId))
		TriggerClientEvent('esx:showNotification', playerId, '~r~Inventaire plein ! Vêtement non ajouté')
	end
end)

RegisterNetEvent('neva:clothes:createOutfitItem', function(clothesArray, outfitName)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if not xPlayer then return end
	
	local clothingConfig = require '@ox_inventory/config/clothing_slots'
	local targetSlot = 65 -- Slot pour les tenues complètes
	local slotLabel = 'Tenue complète'
	
	local metadata = {
		name = outfitName or 'Ma Tenue',
		label = outfitName or 'Ma Tenue', -- Label personnalisé pour l'affichage dans l'inventaire
		clothes = clothesArray,
		description = 'Tenue sauvegardée : ' .. (outfitName or 'Sans nom')
	}
	
	-- Essayer d'ajouter dans le slot 65 (tenue complète)
	local success = exports.ox_inventory:AddItem(source, 'outfit_saved', 1, metadata, targetSlot)
	
	if success then
		TriggerClientEvent('esx:showNotification', source, '~g~Tenue ajoutée et équipée automatiquement : ' .. (outfitName or 'Sans nom'))
	else
		-- Si le slot est occupé, ajouter dans l'inventaire normal
		metadata.equipped = false
		success = exports.ox_inventory:AddItem(source, 'outfit_saved', 1, metadata)
		
		if success then
			TriggerClientEvent('esx:showNotification', source, ('~y~Tenue ajoutée. Placez-la dans le slot %s (%s) pour l\'équiper'):format(targetSlot, slotLabel))
		else
			TriggerClientEvent('esx:showNotification', source, '~r~Inventaire plein')
		end
	end
end)

-- Handler pour créer une tenue complète depuis nv_cloth
AddEventHandler('neva:clothes:createOutfitItemFromCloth', function(playerId, clothesArray, outfitName)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	
	if not xPlayer then return end
	
	local clothingConfig = require '@ox_inventory/config/clothing_slots'
	local targetSlot = 65 -- Slot pour les tenues complètes
	local slotLabel = 'Tenue complète'
	
	local metadata = {
		name = outfitName or 'Tenue achetée',
		label = outfitName or 'Tenue achetée', -- Label personnalisé pour l'affichage dans l'inventaire
		clothes = clothesArray,
		description = 'Tenue achetée au magasin : ' .. (outfitName or 'Sans nom')
	}
	
	-- Essayer d'ajouter dans le slot 65 (tenue complète)
	local success = exports.ox_inventory:AddItem(playerId, 'outfit_saved', 1, metadata, targetSlot)
	
	if success then
		TriggerClientEvent('esx:showNotification', playerId, '~g~Tenue complète ajoutée et équipée automatiquement : ' .. (outfitName or 'Sans nom'))
	else
		-- Si le slot est occupé, ajouter dans l'inventaire normal
		metadata.equipped = false
		success = exports.ox_inventory:AddItem(playerId, 'outfit_saved', 1, metadata)
		
		if success then
			TriggerClientEvent('esx:showNotification', playerId, ('~y~Tenue ajoutée. Placez-la dans le slot %s (%s) pour l\'équiper'):format(targetSlot, slotLabel))
		else
			TriggerClientEvent('esx:showNotification', playerId, '~r~Inventaire plein ! Tenue non ajoutée')
		end
	end
end)

local function identifyClothingType(skinData)
	for componentName, _ in pairs(skinData) do
		if componentName == 'helmet_1' or componentName == 'helmet_2' then
			return 'hat'
		elseif componentName == 'glasses_1' or componentName == 'glasses_2' then
			return 'glasses'
		elseif componentName == 'ears_1' or componentName == 'ears_2' then
			return 'ears'
		elseif componentName == 'mask_1' or componentName == 'mask_2' then
			return 'mask'
		elseif componentName == 'tshirt_1' or componentName == 'tshirt_2' then
			return 'tshirt'
		elseif componentName == 'torso_1' or componentName == 'torso_2' then
			return 'torso'
		elseif componentName == 'arms' or componentName == 'arms_2' then
			return 'arms'
		elseif componentName == 'pants_1' or componentName == 'pants_2' then
			return 'pants'
		elseif componentName == 'shoes_1' or componentName == 'shoes_2' then
			return 'shoes'
		elseif componentName == 'bags_1' or componentName == 'bags_2' then
			return 'bag'
		elseif componentName == 'chain_1' or componentName == 'chain_2' then
			return 'chain'
		elseif componentName == 'watches_1' or componentName == 'watches_2' then
			return 'watch'
		elseif componentName == 'bracelets_1' or componentName == 'bracelets_2' then
			return 'bracelet'
		elseif componentName == 'bproof_1' or componentName == 'bproof_2' then
			return 'vest'
		end
	end
	
	return 'unknown'
end

function GiveClothingItem(playerId, skinData, itemType)
	if not itemType or itemType == '' then
		itemType = identifyClothingType(skinData)
	end
	
	local itemName = 'clothes_' .. itemType
	
	local itemExists = exports.ox_inventory:Items(itemName)
	if not itemExists then
		return false
	end
	
	local metadata = {
		skin = skinData,
		label = 'Vêtement ' .. itemType,
		description = 'Acheté dans un magasin'
	}
	
	local success = exports.ox_inventory:AddItem(playerId, itemName, 1, metadata)
	
	return success
end

exports('GiveClothingItem', GiveClothingItem)

function GiveOutfitItem(playerId, clothesArray, outfitName)
	local metadata = {
		name = outfitName or 'Ma Tenue',
		label = outfitName or 'Ma Tenue', -- Label personnalisé pour l'affichage dans l'inventaire
		clothes = clothesArray,
		description = 'Tenue sauvegardée'
	}
	
	local success = exports.ox_inventory:AddItem(playerId, 'outfit_saved', 1, metadata)
	
	return success
end

exports('GiveOutfitItem', GiveOutfitItem)

AddEventHandler('nv_clothes:createItemsFromSkin', function(playerId, skinData)
    -- Créer une tenue complète au lieu de donner les items individuellement
    local clothesArray = {}
    
    -- Collecter tous les composants de vêtements du skin
    local componentMapping = {
        {components = {'helmet_1', 'helmet_2'}, type = 'hat'},
        {components = {'glasses_1', 'glasses_2'}, type = 'glasses'},
        {components = {'ears_1', 'ears_2'}, type = 'ears'},
        {components = {'watches_1', 'watches_2'}, type = 'watch'},
        {components = {'bracelets_1', 'bracelets_2'}, type = 'bracelet'},
        {components = {'tshirt_1', 'tshirt_2'}, type = 'tshirt'},
        {components = {'torso_1', 'torso_2'}, type = 'torso'},
        {components = {'arms', 'arms_2'}, type = 'arms'},
        {components = {'pants_1', 'pants_2'}, type = 'pants'},
        {components = {'shoes_1', 'shoes_2'}, type = 'shoes'},
        {components = {'mask_1', 'mask_2'}, type = 'mask'},
        {components = {'bproof_1', 'bproof_2'}, type = 'vest'},
        {components = {'bags_1', 'bags_2'}, type = 'bag'},
        {components = {'chain_1', 'chain_2'}, type = 'chain'},
    }
    
    for _, mapping in ipairs(componentMapping) do
        local componentData = {}
        local hasComponent = false
        
        for _, compName in ipairs(mapping.components) do
            if skinData[compName] ~= nil then
                componentData[compName] = skinData[compName]
                hasComponent = true
            end
        end
        
        if hasComponent and next(componentData) then
            table.insert(clothesArray, {
                type = mapping.type,
                skin = componentData
            })
        end
    end
    
    -- Créer la tenue complète dans le slot 65
    if #clothesArray > 0 then
        local metadata = {
            name = 'Tenue départ',
            label = 'Tenue départ',
            clothes = clothesArray,
            description = 'Tenue de départ'
        }
        
        local targetSlot = 65 -- Slot pour les tenues complètes
        local success = exports.ox_inventory:AddItem(playerId, 'outfit_saved', 1, metadata, targetSlot)
        
        if success then
            TriggerClientEvent('esx:showNotification', playerId, '~g~Tenue de départ ajoutée à votre équipement')
        else
            TriggerClientEvent('esx:showNotification', playerId, '~r~Erreur lors de l\'ajout de la tenue de départ')
        end
    end
end)

