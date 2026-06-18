

RegisterNetEvent("nv_drugs:requestPhoneData", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT * FROM selldrugs_players WHERE player = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        local data = {}
        if result[1] then
            data = result[1]
        else

            MySQL.Async.execute('INSERT INTO selldrugs_players (player, respect, sale_skill) VALUES (@identifier, 0, 0)', {
                ['@identifier'] = xPlayer.identifier
            })
            data = {respect = 0, sale_skill = 0}
        end

        TriggerClientEvent("nv_drugs:openPhone", src, data)
    end)
end)


ESX.RegisterUsableItem('black_phone', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    MySQL.Async.fetchAll('SELECT * FROM selldrugs_players WHERE player = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        local data = {}
        if result[1] then
            data = result[1]
        else
            MySQL.Async.execute('INSERT INTO selldrugs_players (player, respect, sale_skill) VALUES (@identifier, 0, 0)', {
                ['@identifier'] = xPlayer.identifier
            })
            data = {respect = 0, sale_skill = 0}
        end
        TriggerClientEvent("nv_drugs:openPhone", source, data)
    end)
end)

RegisterNetEvent("nv_drugs:sellToNPC", function(item, count, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    count = tonumber(count)
    price = tonumber(price)

    if xPlayer.getInventoryItem(item).count >= count then
        xPlayer.removeInventoryItem(item, count)
        local totalMoney = price * count
        xPlayer.addAccountMoney('money', totalMoney)

        TriggerClientEvent('esx:showNotification', src, "Vous avez vendu "..count.."x pour ~g~$"..totalMoney)


        MySQL.Async.execute('UPDATE selldrugs_players SET respect = respect + 1, sale_skill = sale_skill + 1 WHERE player = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    else
        TriggerClientEvent('esx:showNotification', src, "~r~Vous n'avez pas assez de drogue.")
    end
end)


ESX.RegisterUsableItem('black_phone', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    MySQL.Async.fetchAll('SELECT * FROM selldrugs_players WHERE player = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        local data = {}
        if result[1] then
            data = result[1]
        else
            MySQL.Async.execute('INSERT INTO selldrugs_players (player, respect, sale_skill) VALUES (@identifier, 0, 0)', {
                ['@identifier'] = xPlayer.identifier
            })
            data = {respect = 0, sale_skill = 0}
        end
        TriggerClientEvent("nv_drugs:openPhone", source, data)
    end)
end)

RegisterNetEvent("nv_drugs:wholesaleSell", function(item, count, priceInput)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    count = tonumber(count)
    local price = tonumber(priceInput) or 0


    local drugLabel = item
    local found = false
    for _, d in pairs(Config.DrugsSetup) do
        if d.item == item then
            drugLabel = d.label
            found = true
            break
        end
    end

    if not found then

         print("[nv_drugs] Warning: Item " .. tostring(item) .. " not found in Config.DrugsSetup")
    end


    local currentCount = 0
    if GetResourceState('ox_inventory') == 'started' then
         currentCount = exports.ox_inventory:GetItemCount(src, item)
    else
         local playerItem = xPlayer.getInventoryItem(item)
         if playerItem then currentCount = playerItem.count end
    end

    if currentCount >= count then
        if GetResourceState('ox_inventory') == 'started' then
            exports.ox_inventory:RemoveItem(src, item, count)
        else
            xPlayer.removeInventoryItem(item, count)
        end


        if price > 0 then
             if Config.Wholesale.RewardItem == "black_money" then
                 xPlayer.addAccountMoney('black_money', price)
             else
                 xPlayer.addMoney(price)
             end
             TriggerClientEvent('esx:showNotification', src, "Livraison réussie: "..count.."x "..drugLabel.." pour ~r~$"..price)
        else
             TriggerClientEvent('esx:showNotification', src, "~r~Erreur: Prix invalide.")
        end


        MySQL.Async.execute('UPDATE selldrugs_players SET respect = respect + 5, sale_skill = sale_skill + 5 WHERE player = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    else
        TriggerClientEvent('esx:showNotification', src, "~r~Vous n'avez pas assez de marchandise sur vous ! (Requis: "..count..", Avoir: "..currentCount..")")
    end
end)
