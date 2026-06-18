--[[
    Job Garage Creator
    Permet de créer des garages avec accès par job/gang + presets de véhicules
    Commande: /jobgarage
]]

JobGarageCreator = {
    garages = {},
    presets = {}
}

-- Charger les garages depuis la BDD
function JobGarageCreator:load()
    MySQL.Async.fetchAll('SELECT * FROM job_garages', {}, function(result)
        for _, v in pairs(result) do
            self.garages[v.id] = {
                id = v.id,
                name = v.name,
                label = v.label,
                accessType = v.access_type, -- 'public', 'job', 'gang'
                accessName = v.access_name, -- nom du job/gang si applicable
                garageType = v.garage_type, -- 'car', 'boat', 'aircraft'
                accessPoint = json.decode(v.access_point),
                deletePoint = json.decode(v.delete_point),
                spawnPoints = json.decode(v.spawn_points),
                vehicles = json.decode(v.vehicles) or {},
                permissions = json.decode(v.permissions) or { spawnVehicle = 0, storeVehicle = 0, deleteVehicle = 0 },
                blip = json.decode(v.blip) or { enabled = false, sprite = 357, color = 0, scale = 0.7 },
                enabled = v.enabled == 1
            }
        end
        ESX.toConsole('^2[JobGarageCreator]^0 Loaded ' .. #result .. ' job garages')
        TriggerClientEvent('jobgarage:sync', -1, self.garages)
    end)
end

-- Créer un nouveau garage
RegisterNetEvent('jobgarage:create', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not ESX.IsAdmin(source) then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas la permission')
    end

    MySQL.Async.execute([[
        INSERT INTO job_garages (name, label, access_type, access_name, garage_type, access_point, delete_point, spawn_points, vehicles, permissions, blip, enabled)
        VALUES (@name, @label, @accessType, @accessName, @garageType, @accessPoint, @deletePoint, @spawnPoints, @vehicles, @permissions, @blip, @enabled)
    ]], {
        ['@name'] = data.name,
        ['@label'] = data.label,
        ['@accessType'] = data.accessType,
        ['@accessName'] = data.accessName or '',
        ['@garageType'] = data.garageType,
        ['@accessPoint'] = json.encode(data.accessPoint),
        ['@deletePoint'] = json.encode(data.deletePoint),
        ['@spawnPoints'] = json.encode(data.spawnPoints),
        ['@vehicles'] = json.encode(data.vehicles or {}),
        ['@permissions'] = json.encode(data.permissions or { spawnVehicle = 0, storeVehicle = 0, deleteVehicle = 0 }),
        ['@blip'] = json.encode(data.blip or { enabled = false, sprite = 357, color = 0, scale = 0.7 }),
        ['@enabled'] = 1
    }, function(rowsChanged)
        if rowsChanged > 0 then
            JobGarageCreator:load()
            TriggerClientEvent('esx:showNotification', source, '~g~Garage créé avec succès')
        else
            TriggerClientEvent('esx:showNotification', source, '~r~Erreur lors de la création du garage')
        end
    end)
end)

-- Modifier un garage
RegisterNetEvent('jobgarage:edit', function(id, data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not ESX.IsAdmin(source) then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas la permission')
    end

    MySQL.Async.execute([[
        UPDATE job_garages SET
            name = @name,
            label = @label,
            access_type = @accessType,
            access_name = @accessName,
            garage_type = @garageType,
            access_point = @accessPoint,
            delete_point = @deletePoint,
            spawn_points = @spawnPoints,
            vehicles = @vehicles,
            permissions = @permissions,
            blip = @blip,
            enabled = @enabled
        WHERE id = @id
    ]], {
        ['@id'] = id,
        ['@name'] = data.name,
        ['@label'] = data.label,
        ['@accessType'] = data.accessType,
        ['@accessName'] = data.accessName or '',
        ['@garageType'] = data.garageType,
        ['@accessPoint'] = json.encode(data.accessPoint),
        ['@deletePoint'] = json.encode(data.deletePoint),
        ['@spawnPoints'] = json.encode(data.spawnPoints),
        ['@vehicles'] = json.encode(data.vehicles or {}),
        ['@permissions'] = json.encode(data.permissions or { spawnVehicle = 0, storeVehicle = 0, deleteVehicle = 0 }),
        ['@blip'] = json.encode(data.blip or { enabled = false, sprite = 357, color = 0, scale = 0.7 }),
        ['@enabled'] = data.enabled and 1 or 0
    }, function(rowsChanged)
        if rowsChanged > 0 then
            JobGarageCreator:load()
            TriggerClientEvent('esx:showNotification', source, '~g~Garage modifié avec succès')
        end
    end)
end)

-- Supprimer un garage
RegisterNetEvent('jobgarage:delete', function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not ESX.IsAdmin(source) then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas la permission')
    end

    MySQL.Async.execute('DELETE FROM job_garages WHERE id = @id', {
        ['@id'] = id
    }, function(rowsChanged)
        if rowsChanged > 0 then
            JobGarageCreator.garages[id] = nil
            TriggerClientEvent('jobgarage:sync', -1, JobGarageCreator.garages)
            TriggerClientEvent('esx:showNotification', source, '~g~Garage supprimé avec succès')
        end
    end)
end)

-- Ajouter un véhicule preset au garage
RegisterNetEvent('jobgarage:addVehicle', function(garageId, vehicleData)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not ESX.IsAdmin(source) then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas la permission')
    end

    if not JobGarageCreator.garages[garageId] then
        return TriggerClientEvent('esx:showNotification', source, '~r~Garage introuvable')
    end

    local garage = JobGarageCreator.garages[garageId]
    table.insert(garage.vehicles, vehicleData)

    MySQL.Async.execute('UPDATE job_garages SET vehicles = @vehicles WHERE id = @id', {
        ['@id'] = garageId,
        ['@vehicles'] = json.encode(garage.vehicles)
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('jobgarage:sync', -1, JobGarageCreator.garages)
            TriggerClientEvent('esx:showNotification', source, '~g~Véhicule ajouté au garage')
        end
    end)
end)

-- Retirer un véhicule preset du garage
RegisterNetEvent('jobgarage:removeVehicle', function(garageId, vehicleIndex)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not ESX.IsAdmin(source) then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas la permission')
    end

    if not JobGarageCreator.garages[garageId] then
        return TriggerClientEvent('esx:showNotification', source, '~r~Garage introuvable')
    end

    local garage = JobGarageCreator.garages[garageId]
    table.remove(garage.vehicles, vehicleIndex)

    MySQL.Async.execute('UPDATE job_garages SET vehicles = @vehicles WHERE id = @id', {
        ['@id'] = garageId,
        ['@vehicles'] = json.encode(garage.vehicles)
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('jobgarage:sync', -1, JobGarageCreator.garages)
            TriggerClientEvent('esx:showNotification', source, '~g~Véhicule retiré du garage')
        end
    end)
end)

-- Récupérer la liste des jobs disponibles
ESX.RegisterServerCallback('jobgarage:getJobs', function(source, cb)
    MySQL.Async.fetchAll('SELECT name, label FROM jobs', {}, function(result)
        cb(result)
    end)
end)

-- Vérifier si le joueur a accès au garage
ESX.RegisterServerCallback('jobgarage:hasAccess', function(source, cb, garageId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(false) end

    local garage = JobGarageCreator.garages[garageId]
    if not garage or not garage.enabled then return cb(false) end

    if garage.accessType == 'public' then
        return cb(true)
    elseif garage.accessType == 'job' then
        if xPlayer.getJob().name == garage.accessName then
            return cb(true, xPlayer.getJob().grade)
        end
    elseif garage.accessType == 'gang' then
        if xPlayer.getJob2() and xPlayer.getJob2().name == garage.accessName then
            return cb(true, xPlayer.getJob2().grade)
        end
    end

    cb(false)
end)

-- Spawn un véhicule preset
RegisterNetEvent('jobgarage:spawnVehicle', function(garageId, vehicleIndex)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    local garage = JobGarageCreator.garages[garageId]
    if not garage then return end

    local vehicle = garage.vehicles[vehicleIndex]
    if not vehicle then return end

    -- Vérifier les permissions
    local hasAccess = false
    local grade = 0

    if garage.accessType == 'public' then
        hasAccess = true
    elseif garage.accessType == 'job' then
        if xPlayer.getJob().name == garage.accessName then
            hasAccess = true
            grade = xPlayer.getJob().grade
        end
    elseif garage.accessType == 'gang' then
        if xPlayer.getJob2() and xPlayer.getJob2().name == garage.accessName then
            hasAccess = true
            grade = xPlayer.getJob2().grade
        end
    end

    if not hasAccess then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas accès à ce garage')
    end

    if grade < (garage.permissions.spawnVehicle or 0) then
        return TriggerClientEvent('esx:showNotification', source, '~r~Votre grade ne vous permet pas de sortir des véhicules')
    end

    -- Sélectionner un point de spawn aléatoire
    local spawnPoint = garage.spawnPoints[math.random(1, #garage.spawnPoints)]

    TriggerClientEvent('jobgarage:spawnVehicleClient', source, vehicle, spawnPoint, garage.garageType)
end)

-- Ranger un véhicule
RegisterNetEvent('jobgarage:storeVehicle', function(garageId, netId)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    local garage = JobGarageCreator.garages[garageId]
    if not garage then return end

    -- Vérifier les permissions
    local hasAccess = false
    local grade = 0

    if garage.accessType == 'public' then
        hasAccess = true
    elseif garage.accessType == 'job' then
        if xPlayer.getJob().name == garage.accessName then
            hasAccess = true
            grade = xPlayer.getJob().grade
        end
    elseif garage.accessType == 'gang' then
        if xPlayer.getJob2() and xPlayer.getJob2().name == garage.accessName then
            hasAccess = true
            grade = xPlayer.getJob2().grade
        end
    end

    if not hasAccess then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas accès à ce garage')
    end

    if grade < (garage.permissions.storeVehicle or 0) then
        return TriggerClientEvent('esx:showNotification', source, '~r~Votre grade ne vous permet pas de ranger des véhicules')
    end

    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
        TriggerClientEvent('esx:showNotification', source, '~g~Véhicule rangé avec succès')
    end
end)

-- Synchroniser les garages au client quand il se connecte
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    Wait(2000)
    TriggerClientEvent('jobgarage:sync', playerId, JobGarageCreator.garages)
end)

-- Charger au démarrage
CreateThread(function()
    Wait(3000)
    JobGarageCreator:load()
end)
