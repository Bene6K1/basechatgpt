local clothingConfig = require 'config.clothing_slots'

local function isClothingSlot(slot)
    if not slot then return false end
    for _, cSlot in ipairs(clothingConfig.clothingSlots) do
        if cSlot == slot then
            return true
        end
    end
    return false
end

local function isClothingItem(itemName)
    if not itemName then return false end
    
    for _, cItem in ipairs(clothingConfig.clothingItems) do
        if cItem == itemName then
            return true
        end
    end
    
    if clothingConfig.clothingPatterns then
        for _, pattern in ipairs(clothingConfig.clothingPatterns) do
            if string.match(itemName, pattern) then
                return true
            end
        end
    end
    
    return false
end

local function getClothingType(itemName)
    if not itemName then return nil end
    
    if string.match(itemName, '^clothes_') then
        return string.gsub(itemName, 'clothes_', '')
    end
    
    local patterns = {
        {pattern = '^tshirt_%d+', type = 'tshirt'},
        {pattern = '^torso_%d+', type = 'torso'},
        {pattern = '^pants_%d+', type = 'pants'},
        {pattern = '^shoes_%d+', type = 'shoes'},
        {pattern = '^arms_%d+', type = 'arms'},
        {pattern = '^chains_%d+', type = 'chain'},
        {pattern = '^mask_%d+', type = 'mask'},
        {pattern = '^bags_%d+', type = 'bag'},
        {pattern = '^hat_%d+', type = 'hat'},
        {pattern = '^glasses_%d+', type = 'glasses'},
        {pattern = '^earrings_%d+', type = 'ears'},
        {pattern = '^watches_%d+', type = 'watch'},
        {pattern = '^bracelets_%d+', type = 'bracelet'},
        {pattern = '^vest_%d+', type = 'vest'},
    }
    
    for _, p in ipairs(patterns) do
        if string.match(itemName, p.pattern) then
            return p.type
        end
    end
    
    return nil
end

function ValidateClothingSlot(itemName, targetSlot)
    local isClothingTargetSlot = isClothingSlot(targetSlot)
    local isClothing = isClothingItem(itemName)
    
    if isClothingTargetSlot then
        if not isClothing then
            return false, 'Ce slot est réservé aux vêtements'
        end
        
        local slotConfig = clothingConfig.equipmentSlots[targetSlot]
        if slotConfig then
            local itemType = getClothingType(itemName)
            
            if not itemType then
                return false, 'Type de vêtement non reconnu'
            end
            
            if itemType ~= slotConfig.type then
                local message = string.format('Ce slot est réservé aux %s (type: %s)', 
                    slotConfig.label, slotConfig.type)
                return false, message
            end
        end
    end
    
    if clothingConfig.forceClothingSlotsOnly and isClothing and not isClothingTargetSlot then
        return false, clothingConfig.messages.notClothingSlot
    end
    
    return true, nil
end

exports('ValidateClothingSlot', ValidateClothingSlot)

local Inventory = require 'modules.inventory.server'

function AutoEquipClothing(source, slot)
    if not clothingConfig.autoEquipOnPlace then
        return false
    end
    
    local inventory = Inventory(source)
    if not inventory then
        return false
    end
    
    local item = inventory.items[slot]
    if not item or not isClothingItem(item.name) then
        return false
    end
    
    TriggerClientEvent('neva_clothes:autoEquip', source, item, slot)
    
    return true
end

exports('AutoEquipClothing', AutoEquipClothing)

RegisterNetEvent('ox_inventory:clothingSlotPlaced', function(slot)
    local source = source
    
    if clothingConfig.autoEquipOnPlace and isClothingSlot(slot) then
        Wait(100)
        AutoEquipClothing(source, slot)
    end
end)

