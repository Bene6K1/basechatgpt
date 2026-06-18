

RegisterNetEvent("nvCloth:buyClothes")
AddEventHandler("nvCloth:buyClothes", function(paymentMethod, outfit, purchaseMode)
    local source = source
    if paymentMethod == 'card' then paymentMethod = 'bank' end
    
    purchaseMode = purchaseMode or 'items'
    local accountBalance = getAccountMoney(source, Config.Accounts[paymentMethod])
    
    if not outfit or not outfit.items or #outfit.items == 0 then
        TriggerClientEvent(
            "nvCloth:showNotification",
            source,
            "fa-solid fa-circle-exclamation",
            "red",
            Config.Translations[Config.Lang]["no-cloth-selected"]
        )
        return
    end
    
    local totalPrice = 0
    
    for _, item in pairs(outfit.items) do
        local itemPrice = Config.Prices[item.category] or 0
        totalPrice = totalPrice + itemPrice
    end
    
    if not accountBalance then
        TriggerClientEvent(
            "nvCloth:showNotification",
            source,
            "fa-solid fa-circle-exclamation",
            "red",
            string.format(
                Config.Translations[Config.Lang]["account-error"],
                Config.Accounts[paymentMethod],
                paymentMethod
            )
        )
        return
    end
    
    if accountBalance >= totalPrice then
        removeAccountMoney(source, Config.Accounts[paymentMethod], totalPrice)
        
        
        if Config.Inventory ~= 'none' then
            local kmap = {
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
            
            if purchaseMode == 'outfit' then
                -- Mode tenue complète
                local clothesArray = {}
                local outfitName = outfit.name or ('Tenue du ' .. os.date('%d/%m/%Y'))
                
                -- Convertir chaque item en format {name = 'component_name', number = value}
                for _, item in pairs(outfit.items) do
                    local key = kmap[item.category]
                    if key then
                        -- Ajouter le drawable
                        table.insert(clothesArray, {name = key.d, number = item.drawable})
                        -- Ajouter le texture si disponible
                        if key.t and item.texture then
                            table.insert(clothesArray, {name = key.t, number = item.texture})
                        end
                    end
                end
                
                -- Créer la tenue complète dans ox_inventory
                if GetResourceState('nv_clothes') == 'started' then
                    TriggerEvent('neva:clothes:createOutfitItemFromCloth', source, clothesArray, outfitName)
                else
                    -- Fallback : ajout individuel si nv_clothes n'est pas disponible
                    for _, item in pairs(outfit.items) do
                        local name = item.label or (item.category .. '_' .. tostring(item.drawable))
                        local key = kmap[item.category]
                        if key then
                            local clothe = {}
                            clothe[key.d] = item.drawable
                            if key.t then clothe[key.t] = item.texture end
                            TriggerEvent("nvCloth:addClothToInventory", source, item.category, name, clothe)
                        end
                    end
                end
            else
                
                for _, item in pairs(outfit.items) do
                    local name = item.label or (item.category .. '_' .. tostring(item.drawable))
                    local key = kmap[item.category]
                    if key then
                        local clothe = {}
                        clothe[key.d] = item.drawable
                        if key.t then clothe[key.t] = item.texture end
                        TriggerEvent("nvCloth:addClothToInventory", source, item.category, name, clothe)
                    end
                end
            end
        end
        
        -- Forcer un scan de l'équipement après l'ajout des items pour équiper rapidement
        if GetResourceState('nv_clothes') == 'started' then
            -- Premier scan après 300ms
            Citizen.SetTimeout(300, function()
                exports.nv_clothes:ForceScanEquipment(source)
            end)
            -- Deuxième scan après 1000ms pour s'assurer que tout est détecté
            Citizen.SetTimeout(1000, function()
                exports.nv_clothes:ForceScanEquipment(source)
            end)
        end
        
        -- Appeler getClothes uniquement pour mettre à jour saveClothes (sans appliquer les vêtements)
        TriggerClientEvent("nvCloth:getClothes", source, outfit)
        
        TriggerClientEvent(
            "nvCloth:showNotification",
            source,
            "fa-solid fa-check",
            "green",
            Config.Translations[Config.Lang]["purchase-success"]
        )
    else
        local msg = paymentMethod == 'cash' and "Vous n'avez pas assez d'argent sur vous." or "Vous n'avez pas assez d'argent sur votre compte."
        TriggerClientEvent(
            "nvCloth:showNotification",
            source,
            "fa-solid fa-circle-exclamation",
            "red",
            msg
        )
        TriggerClientEvent("nvCloth:resetClothes", source)
        TriggerClientEvent("nvCloth:closeMenu", source)
    end
end)

RegisterNetEvent('nvCloth:addClothToInventory')
AddEventHandler('nvCloth:addClothToInventory', function(source, type, name, clothe)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    local identifier = xPlayer.identifier
    MySQL.Async.execute('INSERT INTO sunny_clothes (identifier, type, name, data) VALUES (@identifier, @type, @name, @data)', {
        ['@identifier'] = identifier,
        ['@type'] = type,
        ['@name'] = name,
        ['@data'] = json.encode(clothe)
    }, function(rowsChanged) 
    end)
end)