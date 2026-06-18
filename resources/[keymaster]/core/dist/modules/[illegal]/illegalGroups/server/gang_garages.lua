--[[
================================================================================
                    GANG GARAGES - SERVER SIDE
================================================================================
Systeme de garage pour les groupes illegaux (basé sur job2)
================================================================================
]]

GangGarageSystem = {}
GangGarageSystem.SpawnedVehicles = {}

CreateThread(function()
    Wait(2000)

    for gangName, garage in pairs(GangGarages.Gangs) do
        if garage.enabled then
            GangGarageSystem.SpawnedVehicles[gangName] = {}
        end
    end
end)

---Vérifie si le joueur a accès au garage du gang (via job2)
---@param source number
---@param gangName string
---@return boolean
function GangGarageSystem:HasAccess(source, gangName)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    local job2 = xPlayer.job2
    if not job2 then return false end

    return job2.name == gangName
end

---Vérifie si le joueur a la permission pour l'action
---@param source number
---@param gangName string
---@param action string
---@return boolean
function GangGarageSystem:HasPermission(source, gangName, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    local job2 = xPlayer.job2
    if not job2 then return false end

    -- Le boss a toutes les permissions
    if job2.grade_name == "boss" then return true end

    local garage = GangGarages.Gangs[gangName]
    if not garage or not garage.permissions then return true end

    local requiredGrade = garage.permissions[action] or 0
    return job2.grade >= requiredGrade
end

---Callback: Récupérer la configuration du garage
ESX.RegisterServerCallback('ganggarage:getConfig', function(source, cb, gangName)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(nil)
        return
    end

    if not GangGarageSystem:HasAccess(source, gangName) then
        cb(nil)
        return
    end

    local garage = GangGarages.Gangs[gangName]
    if not garage or not garage.enabled then
        cb(nil)
        return
    end

    local configCopy = json.decode(json.encode(garage))

    cb(configCopy)
end)

---Callback: Vérifier si le spawn est autorisé
ESX.RegisterServerCallback('ganggarage:canSpawn', function(source, cb, gangName, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false, "Erreur joueur")
        return
    end

    if not GangGarageSystem:HasAccess(source, gangName) then
        cb(false, GangGarages.Settings.notifications.noPermission)
        return
    end

    if not GangGarageSystem:HasPermission(source, gangName, 'spawnVehicle') then
        cb(false, GangGarages.Settings.notifications.noPermission)
        return
    end

    cb(true, "OK")
end)

---Event: Spawn d'un véhicule de gang
RegisterNetEvent('ganggarage:spawnVehicle')
AddEventHandler('ganggarage:spawnVehicle', function(gangName, model, spawnPoint, vehicleConfig)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if not GangGarageSystem:HasAccess(source, gangName) then
        TriggerClientEvent('esx:showNotification', source, GangGarages.Settings.notifications.noPermission)
        return
    end

    -- Génère une plaque unique pour le gang
    local gangPrefix = string.sub(gangName:upper(), 1, 3)
    local plate = string.format("G%s%04d", gangPrefix, math.random(1000, 9999))

    local vehicleData = {
        model = model,
        plate = plate,
        position = vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z),
        heading = spawnPoint.w or 0.0,
        props = {
            plate = plate,
            color1 = vehicleConfig.color or {r = 30, g = 30, b = 30},
            livery = vehicleConfig.livery or -1,
        }
    }

    TriggerClientEvent('ganggarage:createVehicle', source, vehicleData)
end)

---Event: Véhicule créé avec succès
RegisterNetEvent('ganggarage:vehicleCreated')
AddEventHandler('ganggarage:vehicleCreated', function(gangName, model, netId, plate)
    local source = source

    if not GangGarageSystem.SpawnedVehicles[gangName] then
        GangGarageSystem.SpawnedVehicles[gangName] = {}
    end

    GangGarageSystem.SpawnedVehicles[gangName][netId] = {
        model = model,
        plate = plate,
        netId = netId,
        spawnTime = os.time(),
        spawnedBy = source
    }

    TriggerClientEvent('esx:showNotification', source, GangGarages.Settings.notifications.vehicleSpawned)
end)

---Event: Ranger un véhicule de gang
RegisterNetEvent('ganggarage:storeVehicle')
AddEventHandler('ganggarage:storeVehicle', function(gangName, netId, plate, model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if not GangGarageSystem:HasPermission(source, gangName, 'storeVehicle') then
        TriggerClientEvent('esx:showNotification', source, GangGarages.Settings.notifications.noPermission)
        return
    end

    if GangGarageSystem.SpawnedVehicles[gangName] and GangGarageSystem.SpawnedVehicles[gangName][netId] then
        GangGarageSystem.SpawnedVehicles[gangName][netId] = nil
    end

    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end

    TriggerClientEvent('esx:showNotification', source, GangGarages.Settings.notifications.vehicleStored)
end)

---Event: Supprimer un véhicule de gang
RegisterNetEvent('ganggarage:deleteVehicle')
AddEventHandler('ganggarage:deleteVehicle', function(gangName, netId, plate, model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if not GangGarageSystem:HasPermission(source, gangName, 'deleteVehicle') then
        TriggerClientEvent('esx:showNotification', source, GangGarages.Settings.notifications.noPermission)
        return
    end

    if GangGarageSystem.SpawnedVehicles[gangName] and GangGarageSystem.SpawnedVehicles[gangName][netId] then
        GangGarageSystem.SpawnedVehicles[gangName][netId] = nil
    end

    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end

    TriggerClientEvent('esx:showNotification', source, GangGarages.Settings.notifications.vehicleDeleted)
end)

---Thread: Nettoyage périodique des véhicules supprimés
CreateThread(function()
    while true do
        Wait(60000)

        for gangName, vehicles in pairs(GangGarageSystem.SpawnedVehicles) do
            for netId, vehData in pairs(vehicles) do
                local vehicle = NetworkGetEntityFromNetworkId(netId)

                if not DoesEntityExist(vehicle) then
                    GangGarageSystem.SpawnedVehicles[gangName][netId] = nil
                end
            end
        end
    end
end)

---Callback: Obtenir la liste des véhicules sortis par le gang
ESX.RegisterServerCallback('ganggarage:getSpawnedVehicles', function(source, cb, gangName)
    if not GangGarageSystem:HasAccess(source, gangName) then
        cb({})
        return
    end

    local vehicles = {}
    if GangGarageSystem.SpawnedVehicles[gangName] then
        for netId, vehData in pairs(GangGarageSystem.SpawnedVehicles[gangName]) do
            table.insert(vehicles, vehData)
        end
    end

    cb(vehicles)
end)
