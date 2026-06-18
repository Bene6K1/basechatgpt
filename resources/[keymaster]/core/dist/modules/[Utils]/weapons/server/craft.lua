RegisterNetEvent('sunny:craft:fond', function(count)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if not xPlayer.canCarryItem('melted_steel', count) then
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire")
            return
        end
        xPlayer.removeInventoryItem('treatedsteel', count)
        xPlayer.addInventoryItem('melted_steel', count)

        TriggerClientEvent('esx:showNotification', source, ('💴 Vous avez fondu ~y~%s~s~ acier traité'):format(count))
    end
end)

RegisterNetEvent('sunny:weapons:paid', function(price, acierFondue, filFer)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        xPlayer.removeAccountMoney('black_money', price)
        xPlayer.removeInventoryItem('melted_steel', acierFondue)
        xPlayer.removeInventoryItem('wire', filFer)
    end
end)

RegisterNetEvent('sunny:weapons:give', function(weapon, label)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        xPlayer.addInventoryItem(string.lower(weapon), 1)
        TriggerClientEvent('esx:showNotification', source, ('🔫 Vous avez créé ~y~%s~s~'):format(label))
    end
end)

ESX.RegisterServerCallback('sunny:getIem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('treatedsteel').count > 0 and xPlayer.getInventoryItem('soudeuse').count > 0 then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('sunny:getItem2', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('melted_steel').count > 0 then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('sunny:getItem3', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('wire').count > 0 then
        cb(true)
    else
        cb(false)
    end
end)
