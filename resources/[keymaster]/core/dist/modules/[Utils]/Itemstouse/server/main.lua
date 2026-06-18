ESX.RegisterUsableItem('ciseaux', function(source)
	TriggerClientEvent('sunny:useciseaux', source)
end)

RegisterNetEvent('sunny:haircut', function(target)
	TriggerClientEvent('sunny:haircut', target, source)
end)

RegisterServerEvent('sunny:useNitro')
AddEventHandler('sunny:useNitro', function(vehicleNetworkId)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('nitrovehicle').count > 0 then
        xPlayer.removeInventoryItem('nitrovehicle', 1)
        TriggerClientEvent('nitroEffect', -1, vehicleNetworkId)
        TriggerClientEvent('useNitro', -1, vehicleNetworkId)
    else
       -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de nitro.')
    end
end)
