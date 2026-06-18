ESX.RegisterServerCallback('sunny:gouvernement:search', function(source, cb, player)
    local targetPlayer = ESX.GetPlayerFromId(player)

    if targetPlayer then
        local data = {
            inventory = targetPlayer.inventory,
            loadout = targetPlayer.loadout,
            cash = targetPlayer.getAccount('cash').money,
            black_money = targetPlayer.getAccount('black_money').money,
            id = targetPlayer.source
        }
        cb(data)

        TriggerClientEvent('esx:showNotification', targetPlayer.source, '👨‍💼 Un agent du gouvernement vous fouille')
    else
        cb(false)
    end
end)

RegisterNetEvent('sunny:gouvernement:removeItem', function(count, name, player, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerTarget = ESX.GetPlayerFromId(player)
    
    if xPlayer.job.name ~= "gouvernement" then return end
    
    if not xPlayer.canCarryItem(name, 1) then 
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") 
        return 
    end

    xPlayerTarget.removeInventoryItem(name, count)
    xPlayer.addInventoryItem(name, count)

    TriggerClientEvent('esx:showNotification', player, ('Le gouvernement vous a saisi ~r~x%s~s~ %s'):format(count, label))
end)

RegisterNetEvent('sunny:gouvernement:menotter', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "gouvernement" then return end

    local targetPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent('sunny:gouvernement:menotter', targetPlayer.source)
end)

RegisterNetEvent('sunny:gouvernement:escorter', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "gouvernement" then return end
    TriggerClientEvent('sunny:gouvernement:escorter', target, source)
end)

RegisterNetEvent('sunny:gouvernement:putinvehicule', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "gouvernement" then return end

    local targetPlayer = ESX.GetPlayerFromId(target)
    if not targetPlayer then return end

    TriggerClientEvent('sunny:gouvernement:putinvehicule', targetPlayer.source)
end)

RegisterNetEvent('sunny:gouvernement:renforts', function(coords, value)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "gouvernement" then return end
    local players = ESX.GetExtendedPlayers('job', 'gouvernement')
    for k,v in pairs(players) do
        TriggerClientEvent('sunny:gouvernement:renforts', v.source, coords, value)
    end
end)

RegisterNetEvent('sunny:gouvernement:service')
AddEventHandler('sunny:gouvernement:service', function(status)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    
    if xPlayer.job.name ~= "gouvernement" then return end
    
    local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
    local players = ESX.GetPlayers()
    for i=1, #players do
        local xTarget = ESX.GetPlayerFromId(players[i])
        if xTarget.job.name == "gouvernement" then
            if status then
                TriggerClientEvent('esx:showNotification', xTarget.source, ('~b~Gouvernement\n~w~%s a pris son service'):format(rpName))
            else
                TriggerClientEvent('esx:showNotification', xTarget.source, ('~b~Gouvernement\n~w~%s a quitté son service'):format(rpName))
            end
        end
    end
end)
