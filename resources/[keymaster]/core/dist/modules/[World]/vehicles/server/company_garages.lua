CompanyGarageSystem = {}
CompanyGarageSystem.SpawnedVehicles = {}

CreateThread(function()
    Wait(2000)
    
    for jobName, garage in pairs(CompanyGarages.Companies) do
        if garage.enabled then
            CompanyGarageSystem.SpawnedVehicles[jobName] = {}
        end
    end
end)

function CompanyGarageSystem:HasAccess(source, jobName)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    return xPlayer.getJob().name == jobName
end

function CompanyGarageSystem:HasPermission(source, jobName, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    
    local garage = CompanyGarages.Companies[jobName]
    if not garage or not garage.permissions then return true end
    
    local requiredGrade = garage.permissions[action] or 0
    return xPlayer.getJob().grade >= requiredGrade
end

ESX.RegisterServerCallback('companygarage:getConfig', function(source, cb, jobName)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then 
        cb(nil)
        return 
    end
    
    if not CompanyGarageSystem:HasAccess(source, jobName) then
        cb(nil)
        return
    end
    
    local garage = CompanyGarages.Companies[jobName]
    if not garage or not garage.enabled then
        cb(nil)
        return
    end
    
    local configCopy = json.decode(json.encode(garage))
    
    cb(configCopy)
end)

ESX.RegisterServerCallback('companygarage:canSpawn', function(source, cb, jobName, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then 
        cb(false, "Erreur joueur")
        return 
    end
    
    if not CompanyGarageSystem:HasAccess(source, jobName) then
        cb(false, CompanyGarages.Settings.notifications.noPermission)
        return
    end
    
    if not CompanyGarageSystem:HasPermission(source, jobName, 'spawnVehicle') then
        cb(false, CompanyGarages.Settings.notifications.noPermission)
        return
    end
    
    cb(true, "OK")
end)

RegisterNetEvent('companygarage:spawnVehicle')
AddEventHandler('companygarage:spawnVehicle', function(jobName, model, spawnPoint, vehicleConfig)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return end
    
    if not CompanyGarageSystem:HasAccess(source, jobName) then
        TriggerClientEvent('esx:showNotification', source, CompanyGarages.Settings.notifications.noPermission)
        return
    end
    
    local plate = string.format("%s%04d", string.sub(jobName:upper(), 1, 4), math.random(1000, 9999))
    
    local vehicleData = {
        model = model,
        plate = plate,
        position = vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z),
        heading = spawnPoint.w or 0.0,
        props = {
            plate = plate,
            color1 = vehicleConfig.color or {r = 255, g = 255, b = 255},
            livery = vehicleConfig.livery or -1,
        }
    }
    
    TriggerClientEvent('companygarage:createVehicle', source, vehicleData)
end)

RegisterNetEvent('companygarage:vehicleCreated')
AddEventHandler('companygarage:vehicleCreated', function(jobName, model, netId, plate)
    local source = source
    
    if not CompanyGarageSystem.SpawnedVehicles[jobName] then
        CompanyGarageSystem.SpawnedVehicles[jobName] = {}
    end
    
    CompanyGarageSystem.SpawnedVehicles[jobName][netId] = {
        model = model,
        plate = plate,
        netId = netId,
        spawnTime = os.time()
    }
    
    if GiveKeys then
        GiveKeys(source, plate, { netId = netId })
    end
    
    TriggerClientEvent('esx:showNotification', source, CompanyGarages.Settings.notifications.vehicleSpawned)
end)

RegisterNetEvent('companygarage:storeVehicle')
AddEventHandler('companygarage:storeVehicle', function(jobName, netId, plate, model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return end
    
    if not CompanyGarageSystem:HasPermission(source, jobName, 'storeVehicle') then
        TriggerClientEvent('esx:showNotification', source, CompanyGarages.Settings.notifications.noPermission)
        return
    end
    
    if CompanyGarageSystem.SpawnedVehicles[jobName] and CompanyGarageSystem.SpawnedVehicles[jobName][netId] then
        CompanyGarageSystem.SpawnedVehicles[jobName][netId] = nil
    end
    
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end
    
    TriggerClientEvent('esx:showNotification', source, CompanyGarages.Settings.notifications.vehicleStored)
end)

RegisterNetEvent('companygarage:deleteVehicle')
AddEventHandler('companygarage:deleteVehicle', function(jobName, netId, plate, model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return end
    
    if not CompanyGarageSystem:HasPermission(source, jobName, 'deleteVehicle') then
        TriggerClientEvent('esx:showNotification', source, CompanyGarages.Settings.notifications.noPermission)
        return
    end
    
    if CompanyGarageSystem.SpawnedVehicles[jobName] and CompanyGarageSystem.SpawnedVehicles[jobName][netId] then
        CompanyGarageSystem.SpawnedVehicles[jobName][netId] = nil
    end
    
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end
    
    TriggerClientEvent('esx:showNotification', source, CompanyGarages.Settings.notifications.vehicleDeleted)
end)

CreateThread(function()
    while true do
        Wait(60000)
        
        for jobName, vehicles in pairs(CompanyGarageSystem.SpawnedVehicles) do
            for netId, vehData in pairs(vehicles) do
                local vehicle = NetworkGetEntityFromNetworkId(netId)
                
                if not DoesEntityExist(vehicle) then
                    CompanyGarageSystem.SpawnedVehicles[jobName][netId] = nil
                end
            end
        end
    end
end)
