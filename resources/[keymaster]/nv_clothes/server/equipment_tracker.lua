ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local clothingConfig = require '@ox_inventory/config/clothing_slots'
local playerEquipment = {}

local function updateItemEquippedState(playerId, slot, equipped)
	local item = exports.ox_inventory:GetSlot(playerId, slot)
	if item then
		local currentMetadata = item.metadata or {}
		currentMetadata.equipped = equipped
		exports.ox_inventory:SetMetadata(playerId, slot, currentMetadata)
	end
end

local function markRemovedItemAsUnequipped(playerId, itemName)
	local inventory = exports.ox_inventory:Inventory(playerId)
	if not inventory or not inventory.items then return end
	
	for slot, item in pairs(inventory.items) do
		if item and item.name == itemName then
			local isInEquipmentSlot = false
			for _, equipSlot in ipairs(clothingConfig.clothingSlots) do
				if slot == equipSlot then
					isInEquipmentSlot = true
					break
				end
			end
			
			if not isInEquipmentSlot then
				local currentMetadata = item.metadata or {}
				if currentMetadata.equipped ~= false then
					currentMetadata.equipped = false
					exports.ox_inventory:SetMetadata(playerId, slot, currentMetadata)
				end
			end
		end
	end
end

local function trackPlayerEquipment(playerId)
	if not playerId then return end
	
	local inventory = exports.ox_inventory:Inventory(playerId)
	if not inventory or not inventory.items then return end
	
	if not playerEquipment[playerId] then
		playerEquipment[playerId] = {}
	end
	
	for _, slot in ipairs(clothingConfig.clothingSlots) do
        local currentItem = inventory.items[slot]
        local previousItem = playerEquipment[playerId][slot]
        
        if currentItem and not previousItem then
            TriggerClientEvent('nv_clothes:equipFromSlot', playerId, currentItem, slot)
            
            updateItemEquippedState(playerId, slot, true)
            
            playerEquipment[playerId][slot] = {
                name = currentItem.name,
                metadata = currentItem.metadata
            }
        
        elseif not currentItem and previousItem then
            TriggerClientEvent('nv_clothes:unequipFromSlot', playerId, slot)
            
            SetTimeout(100, function()
                markRemovedItemAsUnequipped(playerId, previousItem.name)
            end)
            
            playerEquipment[playerId][slot] = nil
        
        elseif currentItem and previousItem and currentItem.name ~= previousItem.name then
            TriggerClientEvent('nv_clothes:unequipFromSlot', playerId, slot)
            Wait(100)
            TriggerClientEvent('nv_clothes:equipFromSlot', playerId, currentItem, slot)
            
            updateItemEquippedState(playerId, slot, true)
            
            playerEquipment[playerId][slot] = {
                name = currentItem.name,
                metadata = currentItem.metadata
            }
        end
    end
end

CreateThread(function()
    while true do
        Wait(1000)
        
        local xPlayers = ESX.GetExtendedPlayers()
        
        for _, xPlayer in pairs(xPlayers) do
            if xPlayer and xPlayer.source then
                trackPlayerEquipment(xPlayer.source)
            end
        end
    end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    SetTimeout(2000, function()
        playerEquipment[playerId] = {}
        
        local inventory = exports.ox_inventory:Inventory(playerId)
        if inventory and inventory.items then
            for _, slot in ipairs(clothingConfig.clothingSlots) do
                local item = inventory.items[slot]
                if item then
                    local shouldEquip = true
                    
                    if item.metadata and item.metadata.equipped == false then
                        shouldEquip = false
                    end
                    
                    if shouldEquip then
                        TriggerClientEvent('nv_clothes:equipFromSlot', playerId, item, slot)
                        
                        if not item.metadata or item.metadata.equipped == nil then
                            updateItemEquippedState(playerId, slot, true)
                        end
                        
                        playerEquipment[playerId][slot] = {
                            name = item.name,
                            metadata = item.metadata
                        }
                    end
                end
            end
        end
    end)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if playerEquipment[playerId] then
        playerEquipment[playerId] = nil
    end
end)

function ForceScanEquipment(playerId)
    trackPlayerEquipment(playerId)
end

exports('ForceScanEquipment', ForceScanEquipment)

