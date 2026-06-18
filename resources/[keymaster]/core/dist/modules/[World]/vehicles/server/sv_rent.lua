local rentedVehicles = {}

local vehicleRentData = {
    ["location_bateaux_marina"] = {
        {name = 'seashark', label = 'Jetski', price = 17500},
        {name = 'squalo', label = 'Squalo', price = 35000},
        {name = 'dinghy4', label = 'Dinghy', price = 50000},
    },
    ["location_bateaux_roxwood"] = {
        {name = 'seashark', label = 'Jetski', price = 17500},
        {name = 'squalo', label = 'Squalo', price = 35000},
        {name = 'dinghy4', label = 'Dinghy', price = 50000},
    },
    ["location_bateaux_cayo"] = {
        {name = 'seashark', label = 'Jetski', price = 17500},
        {name = 'squalo', label = 'Squalo', price = 35000},
        {name = 'dinghy4', label = 'Dinghy', price = 50000},
    },
    ["location_start"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
        {name = 'faggio', label = 'Scooter', price = 3500},
        {name = 'panto', label = 'Panto', price = 10000},
    },
    ["location_start2"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
        {name = 'faggio', label = 'Scooter', price = 3500},
        {name = 'panto', label = 'Panto', price = 10000},
    },
    ["location_start3"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
        {name = 'faggio', label = 'Scooter', price = 3500},
        {name = 'panto', label = 'Panto', price = 10000},
    },
    ["location_start4"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
        {name = 'faggio', label = 'Scooter', price = 3500},
        {name = 'panto', label = 'Panto', price = 10000},
    },
    ["location_start5"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
        {name = 'faggio', label = 'Scooter', price = 3500},
        {name = 'panto', label = 'Panto', price = 10000},
    },
    ["location_sandy1"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
        {name = 'faggio', label = 'Scooter', price = 3500},
        {name = 'panto', label = 'Panto', price = 10000},
    },
    ["location_cayo"] = {
        {name = 'vetir', label = 'Vetir', price = 1250},
        {name = 'winky', label = 'Winky', price = 1000},
        {name = 'sanchez2', label = 'Sanchez Cayo', price = 1000},
    },
    ["location_cayo2"] = {
        {name = 'vetir', label = 'Vetir', price = 1250},
        {name = 'winky', label = 'Winky', price = 1000},
        {name = 'sanchez2', label = 'Sanchez Cayo', price = 1000},
    },
    ["location_hopital_eclipse"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
    },
    ["location_nord"] = {
        {name = 'bmx', label = 'BMX', price = 1250},
    },
    ["location_hawai_1"] = {
        {name = 'blazer', label = 'Blazer', price = 1000},
        {name = 'verus', label = 'Verus', price = 1250},
    },
    ["location_hawai_2"] = {
        {name = 'blazer', label = 'Blazer', price = 1000},
        {name = 'verus', label = 'Verus', price = 1250},
    },
}

local function getTimeInSeconds(timeIndex)
    if timeIndex == 1 then
        return 15 * 60
    elseif timeIndex == 2 then
        return 30 * 60
    elseif timeIndex == 3 then
        return 60 * 60
    else
        return 0
    end
end

local function getVehiclePrice(rentIndex, vehicleName)
    if vehicleRentData[rentIndex] then
        for _, v in pairs(vehicleRentData[rentIndex]) do
            if v.name == vehicleName then
                return v.price
            end
        end
    end
    return 0
end

RegisterServerEvent("Sunny:vehicle:rentVehicle")
AddEventHandler("Sunny:vehicle:rentVehicle", function(rentIndex, vehicleName, timeIndex)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if not xPlayer then return end
    
    local rentTime = getTimeInSeconds(timeIndex)
    local vehiclePrice = getVehiclePrice(rentIndex, vehicleName)
    
    if vehiclePrice == 0 then
        TriggerClientEvent("esx:showNotification", _source, "~r~Erreur: Véhicule invalide.")
        return
    end
    
    if xPlayer.getMoney() >= vehiclePrice then
        xPlayer.removeAccountMoney('money', vehiclePrice)
        rentedVehicles[_source] = { vehicle = vehicleName, endTime = os.time() + rentTime }
        TriggerClientEvent("Sunny:vehicle:spawnVehicle", _source, vehicleName, rentTime)
        TriggerClientEvent("esx:showNotification", _source, ("~g~Véhicule loué pour %s$"):format(vehiclePrice))
        
        Citizen.CreateThread(function()
            Citizen.Wait(rentTime * 1000)
            if rentedVehicles[_source] and rentedVehicles[_source].vehicle == vehicleName then
                TriggerClientEvent("Sunny:vehicle:removeVehicle", _source)
                TriggerClientEvent("esx:showNotification", _source, "~o~Votre location est terminée.")
                rentedVehicles[_source] = nil
            end
        end)
    else
        TriggerClientEvent("esx:showNotification", _source, "~r~Vous n'avez pas assez d'argent.")
    end
end)
