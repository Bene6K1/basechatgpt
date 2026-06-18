RegisterNetEvent('garage:setPreviewInstance')
AddEventHandler('garage:setPreviewInstance', function(enablePreview)
    local playerId = source
    
    if enablePreview then
        SetPlayerRoutingBucket(playerId, playerId)
    else
        SetPlayerRoutingBucket(playerId, 0)
    end
end)

ESX.RegisterServerCallback('sunny:garage:myvehicle_nui', function(source, cb, isPound)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then 
        cb({})
        return 
    end
    
    MySQL.Async.fetchAll('SELECT *, CAST(state AS SIGNED) as state FROM owned_vehicles WHERE owner = @owner', {
        ['@owner'] = xPlayer.getUniqueID()
    }, function(result)
        if not result or #result == 0 then
            cb({})
            return
        end
        
        local filteredVehicles = {}
        
        for k, v in pairs(result) do
            local state = tonumber(v.state)
            
            if isPound then
                if state == 2 then
                    table.insert(filteredVehicles, v)
                end
            else
                if not state or state == 0 or state == 1 then
                    table.insert(filteredVehicles, v)
                end
            end
        end
        
        cb(filteredVehicles)
    end)
end)

ESX.RegisterServerCallback('sunny:garage:canAffordImpound', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then 
        cb(false)
        return 
    end
    
    cb(xPlayer.getAccount('bank').money >= price)
end)

RegisterNetEvent('sunny:garage:payImpound')
AddEventHandler('sunny:garage:payImpound', function(price)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return end
    
    if xPlayer.getAccount('bank').money >= price then
        xPlayer.removeAccountMoney('bank', price)
        TriggerClientEvent('esx:showNotification', source, ('~g~Vous avez payé $%s pour récupérer votre véhicule'):format(price))
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas assez d\'argent')
    end
end)

ESX.RegisterServerCallback('sunny:garage:getVehicleByPlate', function(source, cb, plate)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        if result[1] then
            cb(result[1])
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('sunny:garage:setVehicleOut', function(source, cb, plate, garageType, garageId, isPound)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then 
        cb(false)
        return 
    end
    
    MySQL.Async.execute('UPDATE owned_vehicles SET state = @state WHERE plate = @plate AND owner = @owner', {
        ['@state'] = 0,
        ['@plate'] = plate,
        ['@owner'] = xPlayer.getUniqueID()
    }, function(affectedRows)
        if affectedRows > 0 then
            for k,v in pairs(Garages.vehicles) do
                if tostring(v.plate) == tostring(plate) then
                    if Garages.vehicles[k] then
                        Garages.vehicles[k].state = 0
                    end
                end
            end
        end
        
        cb(affectedRows > 0)
    end)
end)

ESX.RegisterServerCallback('sunny:garage:setVehicleImpound', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then 
        cb(false)
        return 
    end
    
    MySQL.Async.execute('UPDATE owned_vehicles SET state = @state WHERE plate = @plate AND owner = @owner', {
        ['@state'] = 2,
        ['@plate'] = plate,
        ['@owner'] = xPlayer.getUniqueID()
    }, function(affectedRows)
        if affectedRows > 0 then
            for k,v in pairs(Garages.vehicles) do
                if tostring(v.plate) == tostring(plate) then
                    if Garages.vehicles[k] then
                        Garages.vehicles[k].state = 2
                    end
                end
            end
        end
        
        cb(affectedRows > 0)
    end)
end)

ESX.RegisterServerCallback('sunny:garage:locateVehicle', function(source, cb, plate)
    local vehicles = GetAllVehicles()
    
    for _, vehicle in ipairs(vehicles) do
        if DoesEntityExist(vehicle) then
            local vehPlate = GetVehicleNumberPlateText(vehicle)
            if vehPlate and string.gsub(vehPlate, "^%s*(.-)%s*$", "%1") == string.gsub(plate, "^%s*(.-)%s*$", "%1") then
                local coords = GetEntityCoords(vehicle)
                cb({ x = coords.x, y = coords.y, z = coords.z })
                return
            end
        end
    end
    
    cb(nil)
end)

