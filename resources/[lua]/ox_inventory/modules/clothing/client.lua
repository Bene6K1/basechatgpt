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

function ValidateClothingDrop(itemName, targetSlot)
    local isClothingTargetSlot = isClothingSlot(targetSlot)
    local isClothing = isClothingItem(itemName)
    
    if isClothingTargetSlot and not isClothing then
        return false, clothingConfig.messages.notClothingItem
    end
    
    if clothingConfig.forceClothingSlotsOnly and isClothing and not isClothingTargetSlot then
        return false, clothingConfig.messages.notClothingSlot
    end
    
    return true, nil
end

exports('ValidateClothingDrop', ValidateClothingDrop)

RegisterNetEvent('neva_clothes:autoEquip', function(item, slot)
    if not item or not item.name then return end
    
    Wait(200)
    
    if GetResourceState('neva_clothes') == 'started' then
        local data = {
            name = item.name,
            label = item.label,
            count = item.count or 1,
            slot = slot,
            metadata = item.metadata or {}
        }
        
        exports.neva_clothes:useClothingItem(data, slot)
    end
end)

function StylizeClothingSlots()
    SendNUIMessage({
        action = 'stylizeClothingSlots',
        slots = clothingConfig.clothingSlots
    })
end

AddEventHandler('ox_inventory:open', function()
    Wait(100)
    StylizeClothingSlots()
end)

