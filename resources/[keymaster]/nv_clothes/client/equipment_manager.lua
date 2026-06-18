ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

local clothingConfig = require '@ox_inventory/config/clothing_slots'
local currentlyEquipped = {}

RegisterNetEvent('nv_clothes:equipFromSlot', function(item, slot)
    if not item or not slot then return end
    
    local slotConfig = clothingConfig.equipmentSlots[slot]
    
    if not slotConfig then
        return
    end
    
    -- Gestion spéciale pour les tenues complètes (outfit_saved) dans le slot 65
    if item.name == 'outfit_saved' and slot == 65 then
        if item.metadata and item.metadata.clothes then
            local outfitName = item.metadata.name or 'Tenue'
            local clothesData = item.metadata.clothes
            
            -- Préserver les cheveux avant d'appliquer la tenue
            TriggerEvent('skinchanger:getSkin', function(currentSkin)
                local savedHair = {
                    hair_1 = currentSkin.hair_1,
                    hair_2 = currentSkin.hair_2,
                    hair_color_1 = currentSkin.hair_color_1,
                    hair_color_2 = currentSkin.hair_color_2
                }
                
                -- Appliquer les composants de la tenue
                for _, piece in ipairs(clothesData) do
                    -- Format ancien : piece.name et piece.number
                    if piece.name and piece.number then
                        TriggerEvent('skinchanger:change', piece.name, piece.number)
                    -- Format nouveau : piece.type et piece.skin
                    elseif piece.type and piece.skin then
                        for componentName, value in pairs(piece.skin) do
                            TriggerEvent('skinchanger:change', componentName, value)
                        end
                    end
                end
                
                -- Restaurer les cheveux après l'application de la tenue
                TriggerEvent('skinchanger:getSkin', function(skin)
                    -- Restaurer les cheveux préservés
                    TriggerEvent('skinchanger:change', 'hair_1', savedHair.hair_1)
                    TriggerEvent('skinchanger:change', 'hair_2', savedHair.hair_2)
                    TriggerEvent('skinchanger:change', 'hair_color_1', savedHair.hair_color_1)
                    TriggerEvent('skinchanger:change', 'hair_color_2', savedHair.hair_color_2)
                    
                    TriggerServerEvent('esx_skin:save', skin)
                end)
            end)
            
            TriggerEvent('nv_clothes:updatePedPreview')
            currentlyEquipped[slot] = true
        end
        return
    end
    
    local skinData = item.metadata and item.metadata.skin
    
    if not skinData or not next(skinData) then
        local itemType = detectItemType(item.name, slotConfig.type)
        local clothingItemConfig = Config.ClothingSlots['clothes_' .. itemType]
        
        if clothingItemConfig then
            TriggerEvent('skinchanger:getSkin', function(currentSkin)
                local sex = (currentSkin and currentSkin.sex == 0) and 'male' or 'female'
                skinData = clothingItemConfig.defaultSkin[sex] or {}
                
                for componentName, value in pairs(skinData) do
                    TriggerEvent('skinchanger:change', componentName, value)
                end
                
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('esx_skin:save', skin)
                end)
            end)
        end
    else
        for componentName, value in pairs(skinData) do
            TriggerEvent('skinchanger:change', componentName, value)
        end
        
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('esx_skin:save', skin)
        end)
    end
    
    currentlyEquipped[slot] = true
    
    TriggerEvent('nv_clothes:updatePedPreview')
end)

RegisterNetEvent('nv_clothes:unequipFromSlot', function(slot)
    if not slot then return end
    
    local slotConfig = clothingConfig.equipmentSlots[slot]
    
    if not slotConfig then return end
    
    -- Gestion spéciale pour les tenues complètes (slot 65)
    if slot == 65 then
        -- Quand on retire une tenue complète, réinitialiser tous les composants comme pour les autres vêtements
        TriggerEvent('skinchanger:getSkin', function(currentSkin)
            if not currentSkin then return end
            
            -- Préserver les cheveux avant la réinitialisation
            local savedHair = {
                hair_1 = currentSkin.hair_1,
                hair_2 = currentSkin.hair_2,
                hair_color_1 = currentSkin.hair_color_1,
                hair_color_2 = currentSkin.hair_color_2
            }
            
            local sex = (currentSkin.sex == 0) and 'male' or 'female'
            
            -- Parcourir tous les types de vêtements dans Config.ClothingSlots et réinitialiser chacun
            for itemName, clothingItemConfig in pairs(Config.ClothingSlots) do
                if clothingItemConfig.defaultSkin and clothingItemConfig.defaultSkin[sex] then
                    local defaultSkin = clothingItemConfig.defaultSkin[sex]
                    
                    for componentName, value in pairs(defaultSkin) do
                        TriggerEvent('skinchanger:change', componentName, value)
                    end
                end
            end
            
            -- Restaurer les cheveux après la réinitialisation
            TriggerEvent('skinchanger:getSkin', function(skin)
                -- Restaurer les cheveux préservés
                TriggerEvent('skinchanger:change', 'hair_1', savedHair.hair_1)
                TriggerEvent('skinchanger:change', 'hair_2', savedHair.hair_2)
                TriggerEvent('skinchanger:change', 'hair_color_1', savedHair.hair_color_1)
                TriggerEvent('skinchanger:change', 'hair_color_2', savedHair.hair_color_2)
                
                TriggerServerEvent('esx_skin:save', skin)
            end)
        end)
        
        currentlyEquipped[slot] = false
        TriggerEvent('nv_clothes:updatePedPreview')
        return
    end
    
    local itemType = slotConfig.type
    local clothingItemConfig = Config.ClothingSlots['clothes_' .. itemType]
    
    if clothingItemConfig then
        TriggerEvent('skinchanger:getSkin', function(currentSkin)
            local sex = (currentSkin and currentSkin.sex == 0) and 'male' or 'female'
            local defaultSkin = clothingItemConfig.defaultSkin[sex] or {}
            
            for componentName, value in pairs(defaultSkin) do
                TriggerEvent('skinchanger:change', componentName, value)
            end
            
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
            end)
        end)
    end
    
    currentlyEquipped[slot] = false
    
    TriggerEvent('nv_clothes:updatePedPreview')
end)

function detectItemType(itemName, slotType)
    if string.match(itemName, '^clothes_') then
        return string.gsub(itemName, 'clothes_', '')
    end
    
    if string.match(itemName, '^%a+_%d+') then
        return string.match(itemName, '^(%a+)_%d+')
    end
    
    return slotType
end

