ESX.RegisterServerCallback('armurerie:checkJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob().name
    if job == 'police' or job == 'saspn' or job == 'saspnn' then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('armurerie:getMunitions')
AddEventHandler('armurerie:getMunitions', function(ammoType, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob().name
    
    if job == 'police' or job == 'saspn' or job == 'saspnn' then
        local currentAmount = xPlayer.getInventoryItem(ammoType).count
        
        if amount > 0 and amount <= 200 then
            if currentAmount + amount <= 200 then
                xPlayer.addInventoryItem(ammoType, amount)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez reçu ' .. amount .. ' munitions')
            else
                local possibleAmount = 200 - currentAmount
                if possibleAmount > 0 then
                    TriggerClientEvent('esx:showNotification', source, 'Vous ne pouvez prendre que ' .. possibleAmount .. ' munitions supplémentaires')
                else
                    TriggerClientEvent('esx:showNotification', source, 'Vous avez déjà le maximum de munitions')
                end
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Montant invalide')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas accès à l\'armurerie')
    end
end)

RegisterNetEvent('sunny:showNotification')
AddEventHandler('sunny:showNotification', function(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, true)
end)
