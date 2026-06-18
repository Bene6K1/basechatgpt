outfitToBuy = nil
local skinchangerKeys = {
    tshirt = { d = 'tshirt_1', t = 'tshirt_2' },
    torso = { d = 'torso_1', t = 'torso_2' },
    pants = { d = 'pants_1', t = 'pants_2' },
    shoes = { d = 'shoes_1', t = 'shoes_2' },
    arms = { d = 'arms' },
    chains = { d = 'chain_1', t = 'chain_2' },
    mask = { d = 'mask_1', t = 'mask_2' },
    bags = { d = 'bags_1', t = 'bags_2' },
    hat = { d = 'helmet_1', t = 'helmet_2' },
    glasses = { d = 'glasses_1', t = 'glasses_2' },
    earrings = { d = 'ears_1', t = 'ears_2' },
    watches = { d = 'watches_1', t = 'watches_2' },
    bproof = { d = 'bproof_1', t = 'bproof_2' }
}
local function applySkChange(categoryName, drawable, texture)
    if Config.AppearanceRessource ~= 'skinchanger' then return false end
    local k = skinchangerKeys[categoryName]
    if not k then return false end
    if k.d then TriggerEvent('skinchanger:change', k.d, drawable) end
    if k.t then TriggerEvent('skinchanger:change', k.t, texture or 0) end
    return true
end

RegisterNUICallback("sendSelectedArticle", function(data, callback)
    local playerPed = PlayerPedId()
    local category = categories[data.category]
    local drawable = data.drawable
    local texture = data.texture
    
    if not category then
        showNotification(Config.Translations[Config.Lang]["invalid-category"]) 
        callback({success = false})
        return
    end
    
    if type(drawable) ~= "number" or type(texture) ~= "number" then
        showNotification("Valeurs de vêtement invalides.") 
        callback({success = false})
        return
    end
    
    if category.type == "component" then
        if Config.AppearanceRessource == 'skinchanger' then
            applySkChange(data.category, drawable, texture)
            callback({count = GetNumberOfPedTextureVariations(playerPed, category.index, drawable)})
        else
            SetPedComponentVariation(playerPed, category.index, drawable, texture, 0)
            callback({count = GetNumberOfPedTextureVariations(playerPed, category.index, drawable)})
        end
    elseif category.type == "prop" then
        if drawable ~= -1 then
            if Config.AppearanceRessource == 'skinchanger' then
                applySkChange(data.category, drawable, texture)
                callback({count = GetNumberOfPedPropTextureVariations(playerPed, category.index, drawable)})
            else
                SetPedPropIndex(playerPed, category.index, drawable, texture, true)
                callback({count = GetNumberOfPedPropTextureVariations(playerPed, category.index, drawable)})
            end
        else
            if Config.AppearanceRessource == 'skinchanger' then
                applySkChange(data.category, -1, 0)
                callback({success = true})
            else
                ClearPedProp(playerPed, category.index)
                callback({success = true})
            end
        end
    end
end)

RegisterNUICallback("resetCloth", function(data, callback)
    local categoryName = data.category
    local playerPed = PlayerPedId()
    local category = categories[categoryName]
    
    if not category then
        showNotification(Config.Translations[Config.Lang]["invalid-category"]) 
        callback({success = false})
        return
    end
    
    if saveClothes then
        if category.type == "prop" then
            if not saveClothes[categoryName] then
                showNotification(Config.Translations[Config.Lang]["no-saved-outfit"]) 
                callback({success = false})
                return
            end
            
            if saveClothes[categoryName].drawable ~= -1 then
                if Config.AppearanceRessource == 'skinchanger' then
                    applySkChange(categoryName, saveClothes[categoryName].drawable, saveClothes[categoryName].texture)
                else
                    SetPedPropIndex(
                        playerPed,
                        category.index,
                        saveClothes[categoryName].drawable,
                        saveClothes[categoryName].texture,
                        true
                    )
                end
            else
                if Config.AppearanceRessource == 'skinchanger' then
                    applySkChange(categoryName, -1, 0)
                else
                    ClearPedProp(playerPed, category.index)
                end
            end
        else
            if Config.AppearanceRessource == 'skinchanger' then
                applySkChange(categoryName, saveClothes[categoryName].drawable, saveClothes[categoryName].texture)
            else
                SetPedComponentVariation(
                    playerPed,
                    category.index,
                    saveClothes[categoryName].drawable,
                    saveClothes[categoryName].texture,
                    0
                )
            end
        end
    end
    
    callback({success = true})
end)

RegisterNUICallback("changeTexture", function(data, callback)
    local playerPed = PlayerPedId()
    local category = categories[data.category]
    local texture = data.texture
    
    if not category then
        showNotification(Config.Translations[Config.Lang]["invalid-category"]) 
        callback({success = false})
        return
    end
    
    local currentDrawable
    
    if category.type == "prop" then
        currentDrawable = GetPedPropIndex(playerPed, category.index)
        if currentDrawable ~= -1 then
            if Config.AppearanceRessource == 'skinchanger' then
                applySkChange(data.category, currentDrawable, texture)
            else
                SetPedPropIndex(playerPed, category.index, currentDrawable, texture, true)
            end
        else
            if Config.AppearanceRessource == 'skinchanger' then
                applySkChange(data.category, -1, 0)
            else
                ClearPedProp(playerPed, category.index)
            end
        end
    else
        currentDrawable = GetPedDrawableVariation(playerPed, category.index)
        if Config.AppearanceRessource == 'skinchanger' then
            applySkChange(data.category, currentDrawable, texture)
        else
            SetPedComponentVariation(playerPed, category.index, currentDrawable, texture, 0)
        end
    end
    
    callback({success = true})
end)

function setOutfit(outfit)
    local playerPed = PlayerPedId()
    
    for categoryName, category in pairs(categories) do
        if not outfit[categoryName] then
            
        else
            if category.type == "component" then
                if Config.AppearanceRessource == 'skinchanger' then
                    applySkChange(categoryName, outfit[categoryName].drawable, outfit[categoryName].texture)
                else
                    SetPedComponentVariation(
                        playerPed,
                        category.index,
                        outfit[categoryName].drawable,
                        outfit[categoryName].texture,
                        0
                    )
                end
            elseif category.type == "prop" then
                if outfit[categoryName].drawable ~= -1 then
                    if Config.AppearanceRessource == 'skinchanger' then
                        applySkChange(categoryName, outfit[categoryName].drawable, outfit[categoryName].texture)
                    else
                        SetPedPropIndex(
                            playerPed,
                            category.index,
                            outfit[categoryName].drawable,
                            outfit[categoryName].texture,
                            true
                        )
                    end
                else
                    if Config.AppearanceRessource == 'skinchanger' then
                        applySkChange(categoryName, -1, 0)
                    else
                        ClearPedProp(playerPed, category.index)
                    end
                end
            end
        end
    end
end

RegisterNUICallback("setOutfit", function(data, callback)
    local playerPed = PlayerPedId()
    local outfit = data.outfit
    setOutfit(outfit)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    if not data.preview then
        showNotification(Config.Translations[Config.Lang]["outfit-applied"]) 
    end

    callback({success = true})
end)

RegisterNUICallback("resetAllClothes", function(data, callback)
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    callback({success = true})
end)

RegisterNUICallback("resetCart", function(data, callback)
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    callback({success = true})
end)

RegisterNUICallback("clearCart", function(data, callback)
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    callback({success = true})
end)

RegisterNUICallback("reset", function(data, callback)
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    callback("ok")
end)

RegisterNUICallback("clear", function(data, callback)
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    callback("ok")
end)

RegisterNUICallback("resetCartItems", function(data, callback)
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    callback("ok")
end)

RegisterNUICallback("clearCartItems", function(data, callback)
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
    callback("ok")
end)

RegisterNUICallback("buyClothes", function(data, callback)
    local playerPed = PlayerPedId()
    local items = data.items or data.cart or data.selectedItems or data.selected or (data.outfit and data.outfit.items) or {}
    local name = data.name or (data.outfit and data.outfit.name) or "Tenue"
    
    -- Demander le mode d'achat via prompt
    local purchaseMode = data.purchaseMode or 'items'
    if not data.purchaseMode then
        if exports.ox_lib then
            local input = exports.ox_lib:inputDialog('Mode d\'achat', {
                {type = 'select', label = 'Choisissez le mode d\'achat', options = {
                    {value = 'items', label = 'Vêtement par vêtement'},
                    {value = 'outfit', label = 'Tenue complète'}
                }, default = 1}
            })
            if input then
                purchaseMode = input[1] or 'items'
            else
                callback("cancel")
                return
            end
        else
            purchaseMode = 'items'
        end
    end
    
    -- Si mode tenue complète, demander un nom
    if purchaseMode == 'outfit' then
        if exports.ox_lib then
            local nameInput = exports.ox_lib:inputDialog('Nom de la tenue', {
                {type = 'input', label = 'Nom de la tenue', placeholder = 'Ma tenue', default = name or ''}
            })
            if nameInput and nameInput[1] and nameInput[1] ~= '' then
                name = nameInput[1]
            else
                callback("cancel")
                return
            end
        end
    end
    
    outfitToBuy = {
        items = items,
        name = name
    }
    local method = data.paymentMethod
    if method == 'card' then method = 'bank' end
    TriggerServerEvent("nvCloth:buyClothes", method, outfitToBuy, purchaseMode)
    callback("ok")
end)

RegisterNUICallback("buy", function(data, callback)
    local playerPed = PlayerPedId()
    local items = data.items or data.cart or data.selectedItems or data.selected or (data.outfit and data.outfit.items) or {}
    local name = data.name or (data.outfit and data.outfit.name) or "Tenue"
    
    -- Demander le mode d'achat via prompt
    local purchaseMode = data.purchaseMode or 'items'
    if not data.purchaseMode then
        if exports.ox_lib then
            local input = exports.ox_lib:inputDialog('Mode d\'achat', {
                {type = 'select', label = 'Choisissez le mode d\'achat', options = {
                    {value = 'items', label = 'Vêtement par vêtement'},
                    {value = 'outfit', label = 'Tenue complète'}
                }, default = 1}
            })
            if input then
                purchaseMode = input[1] or 'items'
            else
                callback("cancel")
                return
            end
        else
            purchaseMode = 'items'
        end
    end
    
    -- Si mode tenue complète, demander un nom
    if purchaseMode == 'outfit' then
        if exports.ox_lib then
            local nameInput = exports.ox_lib:inputDialog('Nom de la tenue', {
                {type = 'input', label = 'Nom de la tenue', placeholder = 'Ma tenue', default = name or ''}
            })
            if nameInput and nameInput[1] and nameInput[1] ~= '' then
                name = nameInput[1]
            else
                callback("cancel")
                return
            end
        end
    end
    
    outfitToBuy = {
        items = items,
        name = name
    }
    local method = data.paymentMethod
    if method == 'card' then method = 'bank' end
    TriggerServerEvent("nvCloth:buyClothes", method, outfitToBuy, purchaseMode)
    callback("ok")
end)

RegisterNUICallback("buyCash", function(data, callback)
    local playerPed = PlayerPedId()
    local items = data.items or data.cart or data.selectedItems or data.selected or (data.outfit and data.outfit.items) or {}
    local name = data.name or (data.outfit and data.outfit.name) or "Tenue"
    
    -- Demander le mode d'achat via prompt
    local purchaseMode = data.purchaseMode or 'items'
    if not data.purchaseMode then
        if exports.ox_lib then
            local input = exports.ox_lib:inputDialog('Mode d\'achat', {
                {type = 'select', label = 'Choisissez le mode d\'achat', options = {
                    {value = 'items', label = 'Vêtement par vêtement'},
                    {value = 'outfit', label = 'Tenue complète'}
                }, default = 1}
            })
            if input then
                purchaseMode = input[1] or 'items'
            else
                callback("cancel")
                return
            end
        else
            -- Fallback si ox_lib n'est pas disponible
            purchaseMode = 'items'
        end
    end
    
    -- Si mode tenue complète, demander un nom
    if purchaseMode == 'outfit' then
        if exports.ox_lib then
            local nameInput = exports.ox_lib:inputDialog('Nom de la tenue', {
                {type = 'input', label = 'Nom de la tenue', placeholder = 'Ma tenue', default = name or ''}
            })
            if nameInput and nameInput[1] and nameInput[1] ~= '' then
                name = nameInput[1]
            else
                callback("cancel")
                return
            end
        end
    end
    
    outfitToBuy = {
        items = items,
        name = name
    }
    TriggerServerEvent("nvCloth:buyClothes", "cash", outfitToBuy, purchaseMode)
    callback("ok")
end)

RegisterNUICallback("buyBank", function(data, callback)
    local playerPed = PlayerPedId()
    local items = data.items or data.cart or data.selectedItems or data.selected or (data.outfit and data.outfit.items) or {}
    local name = data.name or (data.outfit and data.outfit.name) or "Tenue"
    
    -- Demander le mode d'achat via prompt
    local purchaseMode = data.purchaseMode or 'items'
    if not data.purchaseMode then
        if exports.ox_lib then
            local input = exports.ox_lib:inputDialog('Mode d\'achat', {
                {type = 'select', label = 'Choisissez le mode d\'achat', options = {
                    {value = 'items', label = 'Vêtement par vêtement'},
                    {value = 'outfit', label = 'Tenue complète'}
                }, default = 1}
            })
            if input then
                purchaseMode = input[1] or 'items'
            else
                callback("cancel")
                return
            end
        else
            purchaseMode = 'items'
        end
    end
    
    -- Si mode tenue complète, demander un nom
    if purchaseMode == 'outfit' then
        if exports.ox_lib then
            local nameInput = exports.ox_lib:inputDialog('Nom de la tenue', {
                {type = 'input', label = 'Nom de la tenue', placeholder = 'Ma tenue', default = name or ''}
            })
            if nameInput and nameInput[1] and nameInput[1] ~= '' then
                name = nameInput[1]
            else
                callback("cancel")
                return
            end
        end
    end
    
    outfitToBuy = {
        items = items,
        name = name
    }
    TriggerServerEvent("nvCloth:buyClothes", "bank", outfitToBuy, purchaseMode)
    callback("ok")
end)

RegisterNUICallback("buyCard", function(data, callback)
    local playerPed = PlayerPedId()
    local items = data.items or data.cart or data.selectedItems or data.selected or (data.outfit and data.outfit.items) or {}
    local name = data.name or (data.outfit and data.outfit.name) or "Tenue"
    
    -- Demander le mode d'achat via prompt
    local purchaseMode = data.purchaseMode or 'items'
    if not data.purchaseMode then
        if exports.ox_lib then
            local input = exports.ox_lib:inputDialog('Mode d\'achat', {
                {type = 'select', label = 'Choisissez le mode d\'achat', options = {
                    {value = 'items', label = 'Vêtement par vêtement'},
                    {value = 'outfit', label = 'Tenue complète'}
                }, default = 1}
            })
            if input then
                purchaseMode = input[1] or 'items'
            else
                callback("cancel")
                return
            end
        else
            purchaseMode = 'items'
        end
    end
    
    -- Si mode tenue complète, demander un nom
    if purchaseMode == 'outfit' then
        if exports.ox_lib then
            local nameInput = exports.ox_lib:inputDialog('Nom de la tenue', {
                {type = 'input', label = 'Nom de la tenue', placeholder = 'Ma tenue', default = name or ''}
            })
            if nameInput and nameInput[1] and nameInput[1] ~= '' then
                name = nameInput[1]
            else
                callback("cancel")
                return
            end
        end
    end
    
    outfitToBuy = {
        items = items,
        name = name
    }
    TriggerServerEvent("nvCloth:buyClothes", "card", outfitToBuy, purchaseMode)
    callback("ok")
end)
RegisterNetEvent("nvCloth:getClothes")
AddEventHandler("nvCloth:getClothes", function(outfitData)
    -- Ne plus appliquer directement les vêtements ici
    -- Laisser nv_clothes gérer l'équipement automatique via equipment_tracker
    -- Les items sont ajoutés à l'inventaire et nv_clothes les équipera automatiquement
    -- Le scan est fait côté serveur dans sv_cloth.lua
    
    -- Mettre à jour saveClothes après un court délai pour refléter les vêtements équipés
    Citizen.SetTimeout(1000, function()
        local playerPed = PlayerPedId()
        for categoryName, category in pairs(categories) do
            if category.type == "component" then
                saveClothes[categoryName] = {
                    drawable = GetPedDrawableVariation(playerPed, category.index),
                    texture = GetPedTextureVariation(playerPed, category.index)
                }
            elseif category.type == "prop" then
                saveClothes[categoryName] = {
                    drawable = GetPedPropIndex(playerPed, category.index),
                    texture = GetPedPropTextureIndex(playerPed, category.index)
                }
            end
        end
    end)
end)
RegisterNetEvent("nvCloth:resetClothes")
AddEventHandler("nvCloth:resetClothes", function()
    local playerPed = PlayerPedId()
    setOutfit(saveClothes)
    if Config.AppearanceRessource == 'skinchanger' then
        
    end
end)

function WaitForFreemodeModel()
    local attempts = 0
    local maxAttempts = 1000
    
    while true do
        local playerPed = PlayerPedId()
        local model = GetEntityModel(playerPed)
        
        
        
        if model == 1885233650 or model == -1667301416 then
            break
        end
        
        attempts = attempts + 1
        
        if attempts >= maxAttempts then
            
            break
        end
        
        Wait(200)
    end
end

CreateThread(function()
    while true do
        if NetworkIsSessionStarted() and DoesEntityExist(PlayerPedId()) then
            break
        end
        Wait(100)
    end

    WaitForFreemodeModel()

    local playerPed = PlayerPedId()
    local clothingCounts = {}

    for categoryName, category in pairs(categories) do
        if category.type == "component" then
            clothingCounts[categoryName] = GetNumberOfPedDrawableVariations(playerPed, category.index)
        elseif category.type == "prop" then
            clothingCounts[categoryName] = GetNumberOfPedPropDrawableVariations(playerPed, category.index)
        end
    end

    SendNUIMessage({
        type = "clothingCounts",
        counts = clothingCounts
    })
end)