ESX = nil
Society = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

CreateThread(function()
    while Society == nil do
        Wait(100)
        if _G.Society then
            Society = _G.Society
        end
    end
end)
local function GetItemImage(itemName)
    return 'nui://ox_inventory/web/images/' .. itemName .. '.png'
end

function OpenShopForPlayer(source, shopType)
    local filteredItems = {}
    for _, item in pairs(Config.Items) do
        if item.shop == shopType then
            local itemData = {
                label = item.label,
                name = item.name,
                price = item.price,
                categorie = item.categorie,
                shop = item.shop,
                type = item.type,
                image = item.image or GetItemImage(item.name),
                defaultQuantity = item.defaultQuantity or 1
            }
            table.insert(filteredItems, itemData)
        end
    end

    TriggerClientEvent('shop:openMenu', source, filteredItems, shopType)
end

RegisterServerEvent('shop:requestItems')
AddEventHandler('shop:requestItems', function(shopType)
    local _source = source
    OpenShopForPlayer(_source, shopType)
end)

RegisterServerEvent('shop:checkMoney')
AddEventHandler('shop:checkMoney', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local total = tonumber(data.total)
    local items = data.items
    local shopType = data.shopType or "shop"
    local requestedPaymentMethod = data.paymentMethod -- 'cash' ou 'bank'

    local isLTDShop = shopType == "ltd"
    local paymentAccount = nil
    local playerCash = xPlayer.getMoney()
    local playerBank = xPlayer.getAccount('bank').money

    -- Utilise le mode de paiement choisi par le joueur
    if requestedPaymentMethod == 'cash' then
        if playerCash >= total then
            paymentAccount = 'cash'
        else
            TriggerClientEvent('shop:checkoutResult', src, false)
            TriggerClientEvent('esx:showNotification', src, 'Vous n\'avez pas assez d\'argent en espèces.')
            return
        end
    elseif requestedPaymentMethod == 'bank' then
        if playerBank >= total then
            paymentAccount = 'bank'
        else
            TriggerClientEvent('shop:checkoutResult', src, false)
            TriggerClientEvent('esx:showNotification', src, 'Vous n\'avez pas assez d\'argent en banque.')
            return
        end
    else
        -- Fallback: ancien comportement si pas de méthode spécifiée
        if isLTDShop then
            paymentAccount = 'bank'
        elseif playerCash >= total then
            paymentAccount = 'cash'
        elseif playerBank >= total then
            paymentAccount = 'bank'
        end
    end

    if paymentAccount then
        for _, item in pairs(items) do
            local itemType = item.type or "item"
            if itemType == "item" then
                local isAmmo = string.match(item.itemName, "^ammo%-")
                if isAmmo then
                    for _, configItem in pairs(Config.Items) do
                        if configItem.name == item.itemName then
                            local finalQuantity = (configItem.defaultQuantity or 1) * item.quantity
                            xPlayer.addInventoryItem(item.itemName, finalQuantity)
                            goto continue
                        end
                    end
                else
                    if item.itemName == "snspistol" then
                        if exports['core']:haveVip(xPlayer.UniqueID) then
                            xPlayer.addInventoryItem(item.itemName, item.quantity)
                        else
                            TriggerClientEvent('esx:showNotification', src, "~r~Vous n'êtes pas VIP")
                            return
                        end
                    else
                        xPlayer.addInventoryItem(item.itemName, item.quantity)
                    end
                end
            elseif itemType == "weapon" then
                xPlayer.addInventoryItem(string.lower(item.itemName), 1)
            elseif itemType == "props" then
                print('Adding Props:', item.label, 'Quantity:', item.quantity)
                MySQL.Async.execute('INSERT INTO players_props (UniqueID, data, name) VALUES (@UniqueID, @data, @name)', {
                    ['@UniqueID'] = xPlayer.UniqueID,
                    ['@data'] = json.encode({label = item.label, name = item.itemName, owner = xPlayer.UniqueID, count = item.quantity}),
                    ['@name'] = item.itemName
                })
                TriggerClientEvent('esx:showNotification', src, "L'objet est maintenant disponible dans votre menu F5 -> Objets")
            else
                print('Unknown item type:', itemType)
            end
            ::continue::
        end
        
        xPlayer.removeAccountMoney(paymentAccount, total)
        
        if isLTDShop and xPlayer.job and xPlayer.job.name then
            local jobName = xPlayer.job.name
            if string.match(jobName, "^ltd_") then
                if Society then
                    local society = Society:getSociety(jobName)
                    if society then
                        society.addSocietyMoney(total)
                    end
                else
                    print('[Shop] ERREUR: Society n\'est pas chargé')
                end
            end
        end
        
        TriggerClientEvent('shop:checkoutResult', src, true)
        TriggerClientEvent('esx:showNotification', src, 'Vous avez acheté des articles pour ~g~'..total..'$')
    else
        TriggerClientEvent('shop:checkoutResult', src, false)
        TriggerClientEvent('esx:showNotification', src, 'Vous n\'avez pas assez d\'argent.')
    end
end)

RegisterServerEvent('shop:billClient')
AddEventHandler('shop:billClient', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local targetId = data.targetId
    local targetPlayer = ESX.GetPlayerFromId(targetId)
    
    if not xPlayer or not targetPlayer then 
        TriggerClientEvent('esx:showNotification', src, 'Joueur non trouvé')
        return 
    end
    
    local total = tonumber(data.total)
    local items = data.items
    
    TriggerClientEvent('ltd:client:sendBasketRequest', targetId, total, true, total, items, targetId, src)
end)

RegisterNetEvent("ltd:server:sendBasketResponse")
AddEventHandler("ltd:server:sendBasketResponse", function(accepted, totalPrice, paymentMethod, target, items, employe)
    if not accepted then
        TriggerClientEvent("esx:showNotification", employe, "Le joueur a refusé la facture")
        TriggerClientEvent("esx:showNotification", source, "Vous avez refusé la facture")
        return
    else
        TriggerClientEvent("esx:showNotification", employe, "Le joueur a accepté la facture")
    end

    local payer = ESX.GetPlayerFromId(source)
    local receiver = ESX.GetPlayerFromId(employe)
    
    if not payer or not receiver then return end
    
    if payer and receiver then
        local account = payer.getAccount(paymentMethod)
        if account.money >= totalPrice then
            payer.removeAccountMoney(paymentMethod, totalPrice)
            for _, item in pairs(items) do
                if item.itemName ~= "totalPrice" then
                    payer.addInventoryItem(item.itemName, item.quantity)
                end
            end
            
            if Society then
                local society = Society:getSociety(receiver.job.name)
                if society then
                    society.addSocietyMoney(totalPrice)
                end
            else
                print('[Shop] ERREUR: Society n\'est pas chargé pour la facturation')
            end
            
            local function estJour()
                local currentHour = tonumber(os.date("%H"))
                return currentHour >= 6 and currentHour < 20
            end
            
            MySQL.Async.fetchAll("SELECT * FROM player_ltdsales WHERE uid = @u AND job = @j", {
                ['@u'] = receiver.UniqueID,
                ['@j'] = receiver.job.name
            }, function(sales)
                if #sales == 0 then
                    if estJour() then
                        MySQL.Async.execute("INSERT INTO player_ltdsales (uid, job, day, night) VALUES (@u, @j, @d, @n)", {
                            ['@u'] = receiver.UniqueID,
                            ['@j'] = receiver.job.name,
                            ['@d'] = json.encode({sales = 1, amount = totalPrice}),
                            ['@n'] = json.encode({sales = 0, amount = 0})
                        })
                    else
                        MySQL.Async.execute("INSERT INTO player_ltdsales (uid, job, day, night) VALUES (@u, @j, @d, @n)", {
                            ['@u'] = receiver.UniqueID,
                            ['@j'] = receiver.job.name,
                            ['@d'] = json.encode({sales = 0, amount = 0}),
                            ['@n'] = json.encode({sales = 1, amount = totalPrice})
                        })
                    end
                    return
                end

                if estJour() then
                    local daySales = json.decode(sales[1].day)
                    daySales.sales = daySales.sales + 1
                    daySales.amount = daySales.amount + totalPrice
                    MySQL.Async.execute("UPDATE player_ltdsales SET day = @d WHERE uid = @u AND job = @j", {
                        ['@u'] = receiver.UniqueID,
                        ['@d'] = json.encode(daySales),
                        ['@j'] = receiver.job.name
                    })
                else
                    local nightSales = json.decode(sales[1].night)
                    nightSales.sales = nightSales.sales + 1
                    nightSales.amount = nightSales.amount + totalPrice
                    MySQL.Async.execute("UPDATE player_ltdsales SET night = @n WHERE uid = @u AND job = @j", {
                        ['@u'] = receiver.UniqueID,
                        ['@n'] = json.encode(nightSales),
                        ['@j'] = receiver.job.name
                    })
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent')
        end
    end
end)