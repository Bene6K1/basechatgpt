local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

local function getStaffConfig()
    local globalConfig = rawget(_G, 'Config')
    if not globalConfig then return nil end
    return rawget(globalConfig, 'Staff')
end

local StaffConfig = getStaffConfig()

local function hasCarkeyPermission(xPlayer)
    if not StaffConfig or not StaffConfig.HavePermission then return false end
    return StaffConfig.HavePermission('VehicleKeys', 'carkey', xPlayer)
end

local function generateTempPlate()
    return ('STF%05d'):format(math.random(0, 99999))
end

local function spawnCarkeyVehicle(targetId, model)
    local ped = GetPlayerPed(targetId)
    if ped == 0 then return false, 'Ped invalide' end

    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    
    -- Spawn via client pour éviter les problèmes de sync
    TriggerClientEvent('nv_keys:client:spawnCarkeyVehicle', targetId, model, coords, heading)
    
    Wait(1500) -- Attendre que le véhicule soit créé côté client
    
    -- Récupérer le véhicule le plus proche du joueur
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle == 0 then
        return false, 'Véhicule non trouvé après spawn'
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)

    return true, {
        netId = netId,
        plate = plate,
        entity = vehicle
    }
end

CreateThread(function()
    lib.addCommand('carkey', {
        help = 'Spawn un véhicule temporaire avec clé',
            params = {
            {
                name = 'vehicle',
                type = 'string',
                help = 'Nom du véhicule',
                optional = false,
            },
                {
                    name = 'player_id',
                    type = 'playerId',
                help = 'ID cible (optionnel)',
                    optional = true,
                },
            },
            restricted = false
    }, function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return end

        if not hasCarkeyPermission(xPlayer) then
            Notify.SendNotify(source, 'Commande réservée au staff.', 'error', 3000)
            return
        end

        local model = args.vehicle
        if not model or model == '' then
            Notify.SendNotify(source, 'Modèle invalide.', 'error', 3000)
            return
        end

        local targetId = args.player_id or source
        if not GetPlayerPed(targetId) or GetPlayerPed(targetId) == 0 then
            Notify.SendNotify(source, 'ID cible invalide.', 'error', 3000)
            return
        end

        local ok, dataOrErr = spawnCarkeyVehicle(targetId, model)
        if not ok then
            Notify.SendNotify(source, ('Spawn impossible: %s'):format(dataOrErr), 'error', 4000)
            return
        end

        local tempData = dataOrErr
        GiveKeys(targetId, tempData.plate, { netId = tempData.netId })
        TriggerClientEvent(Scriptname .. ':client:addSessionVehicle', targetId, tempData.plate)

        Notify.SendNotify(source, ('Véhicule %s prêt, plaque %s.'):format(model, tempData.plate), 'success', 4000)
        if targetId ~= source then
            Notify.SendNotify(targetId, ('Un membre du staff vous a remis un %s.'):format(model), 'success', 4000)
        end
    end)
end)