RegisterNetEvent('sunny:farm:farm', function(item, type)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end

    local count = 0

    if type == 'recolte' then
        if (xPlayer) then
            count = math.random(1, 3)
            local itemName = Config_Farm.Items[item][type].name
            
            if not exports.ox_inventory:CanCarryItem(source, itemName, count) then 
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") 
                return 
            end
            
            exports.ox_inventory:AddItem(source, itemName, count)
    
            TriggerClientEvent('esx:showNotification', source, ('🌿 Vous avez récolté ~y~+%s~s~ %s'):format(count, Config_Farm.Items[item][type].label))
        end
    elseif type == 'traitement' then
        if (xPlayer) then
            local requiredItem = Config_Farm.Items[item]['recolte'].name
            local rewardItem = Config_Farm.Items[item][type].name
            
            if exports.ox_inventory:GetItemCount(source, requiredItem) < 3 then 
                return TriggerClientEvent('esx:showNotification', source, ('⚠️ Vous ne possédez pas assez de ~y~%s~s~ pour traiter'):format(item)) 
            end
            
            if not exports.ox_inventory:CanCarryItem(source, rewardItem, 1) then 
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") 
                return 
            end
            
            exports.ox_inventory:RemoveItem(source, requiredItem, 3)
            exports.ox_inventory:AddItem(source, rewardItem, 1)

            TriggerClientEvent('esx:showNotification', source, ('🌿 ~y~x%s~s~ %s'):format(1, Config_Farm.Items[item][type].label))
        end
    end
end)

RegisterNetEvent('sunny:farm:sell', function(count, itemName, price, itemLabel)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if exports.ox_inventory:GetItemCount(source, itemName) < count then
        return
    end

    local society = Society:getSociety(xPlayer.job.name)

    if not society then return end

    exports.ox_inventory:RemoveItem(source, itemName, count)

    local pricePlayer =  math.random(100, 110)
    local totalPlayer = pricePlayer*count

    local priceSociety = math.random(250, 350)
    local totalSociety = priceSociety*count

    xPlayer.addAccountMoney('bank', totalPlayer)
    society.addSocietyMoney(totalSociety)

    TriggerClientEvent('esx:showNotification', source, ('Vous avez vendu ~y~x%s~s~ %s\nVotre société a gagné ~p~%s$~s~\nVous avez gagné ~g~%s$~s~'):format(count, itemLabel, totalSociety, totalPlayer))
    
    if sendLog then
        sendLog(('Le Player (%s - %s) a vendu (%s- %s)'):format(xPlayer.name, xPlayer.UniqueID, itemName, count), {
            author = 'Vente Farm',
            fields = {
                {title = 'Player', subtitle = xPlayer.name},
                {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                {title = 'Identifier', subtitle = xPlayer.identifier},
                {title = "Gain", subtitle = totalSociety},
            },
            channel = 'VenteFarm'
        })
    end
end)