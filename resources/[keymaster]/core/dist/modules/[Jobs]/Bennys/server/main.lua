Bennys = {
    inService = {}
}

RegisterNetEvent('sunny:bennys:service', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if xPlayer.job.name == 'garage_octacyp'
        or xPlayer.job.name == 'garage_lscustom'
        or xPlayer.job.name == 'garage_speedhunters'
        or xPlayer.job.name == 'garage_paletocustoms'
        or xPlayer.job.name == 'garage_eastcustoms'
        or xPlayer.job.name == 'garage_driveline' then return end

    if not Bennys.inService[xPlayer.identifier] then
        local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
        Bennys.inService[xPlayer.identifier] = true
        for id, _ in pairs(Bennys.inService) do
            local targetPlayer = ESX.GetPlayerFromIdentifier(id)
            if targetPlayer and targetPlayer.job.name == xPlayer.job.name then
                local targetRpName = ('%s %s'):format(targetPlayer.firstname or 'Inconnu', targetPlayer.lastname or '')
                TriggerClientEvent('esx:showNotification', targetPlayer.source, ('L\'employé ~y~%s~s~ a pris son service'):format(rpName))
            end
        end
    else
        local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
        Bennys.inService[xPlayer.identifier] = nil
        for id, _ in pairs(Bennys.inService) do
            local targetPlayer = ESX.GetPlayerFromIdentifier(id)
            if targetPlayer and targetPlayer.job.name == xPlayer.job.name then
                TriggerClientEvent('esx:showNotification', targetPlayer.source, ('L\'employé ~y~%s~s~ a fini son service'):format(rpName))
            end
        end
    end
end)

RegisterNetEvent('sunny:checkVehiclePlate', function(plate)
    local source = source

    MySQL.Async.fetchScalar('SELECT 1 FROM appel_jobs WHERE plate = @plate LIMIT 1', {
        ['@plate'] = plate
    }, function(result)
        local exists = result ~= nil
        TriggerClientEvent('sunny:checkVehiclePlateResult', source, plate, exists)
    end)
end)

RegisterNetEvent('sunny:sendappel:job', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    MySQL.Async.execute('INSERT INTO appel_jobs (job, raison, pos, plate) VALUES (@a, @b, @c, @d)', {
        ['@a'] = data.job,
        ['@b'] = data.raison,
        ['@c'] = json.encode(data.pos),
        ['@d'] = data.plate
    }, function() end)

    local message = ('Un nouvel appel a été fait : %s '):format(data.raison, data.plate)

    for id, _ in pairs(Bennys.inService) do
        local targetPlayer = ESX.GetPlayerFromIdentifier(id)
        if targetPlayer and Bennys.inService[id] and (
            targetPlayer.job.name == "garage_octacyp"
            or targetPlayer.job.name == "garage_lscustom"
            or targetPlayer.job.name == "garage_speedhunters"
            or targetPlayer.job.name == "garage_paletocustoms"
            or targetPlayer.job.name == "garage_eastcustoms"
            or targetPlayer.job.name == "garage_driveline"
        ) then
            TriggerClientEvent('esx:showNotification', targetPlayer.source, message)
            TriggerClientEvent('soundmecano:playSound', source)
        end
    end
end)

-- ESX.RegisterServerCallback('sunny:custom:getVehiclesPrices', function(source, cb)
--     local vehicle = {}

--     MySQL.Async.fetchAll('SELECT * FROM vehicules', {}, function(result)
--         for k,v in pairs(result) do
--             table.insert(vehicle, v)
--         end

--         cb(vehicle)
--     end)
-- end)

RegisterNetEvent('sunny:bennys:repairVehicle', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if not (xPlayer.job.name == 'garage_octacyp'
        or xPlayer.job.name == 'garage_lscustom'
        or xPlayer.job.name == 'garage_speedhunters'
        or xPlayer.job.name == 'garage_paletocustoms'
        or xPlayer.job.name == 'garage_eastcustoms'
        or xPlayer.job.name == 'garage_driveline') then
            DropPlayer(source, 'Tu cheat pour repair ??')
        return 
    end

    sendLog(('Réparation de véhicule bennys (%s - %s)'):format(xPlayer.name, xPlayer.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Joueur', subtitle = xPlayer.name},
            {title = 'ID Unique', subtitle = xPlayer.UniqueID},
            {title = 'Identifier', subtitle = xPlayer.identifier},
            {title = 'Plaque du véhicule', subtitle = plate},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'bennys_repair_vehicle'
    })
end)




ESX.RegisterServerCallback('sunny:appelRetreive:job', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        -- print("Erreur: xPlayer est nul")
        cb({})
        return
    end

    local job = xPlayer.job.name
    local query = 'SELECT * FROM appel_jobs WHERE job = @job'
    local params = {['@job'] = job}

    if job == 'police' or job == 'bcso' or job == 'sheriff' or job == 'saspn' then
        query = "SELECT * FROM appel_jobs WHERE job IN ('police', 'bcso', 'sheriff', 'saspn')"
        params = {}
    end

    MySQL.Async.fetchAll(query, params, function(result)
        local calls = {}
        for k, v in pairs(result) do
            table.insert(calls, {
                job = v.job,
                raison = v.raison,
                pos = json.decode(v.pos),
                id = v.id,
            })
        end
        cb(calls)
    end)
end)




RegisterNetEvent('sunny:bande:clearlatable')
AddEventHandler('sunny:bande:clearlatable', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then 
        -- print('Erreur : Joueur non trouvé.')
        return 
    end

    local job = xPlayer.job.name
    local query = ''
    local params = {['@job'] = job}

    if job == 'police' or job == 'bcso' or job == 'sheriff' or job == 'saspn' then
        query = "DELETE FROM appel_jobs WHERE job IN ('police', 'bcso', 'sheriff', 'saspn')"
        params = {}
    elseif job == 'garage_octacyp'
        or job == 'garage_lscustom'
        or job == 'garage_speedhunters'
        or job == 'garage_paletocustoms'
        or job == 'garage_eastcustoms'
        or job == 'garage_driveline' then
        query = 'DELETE FROM appel_jobs WHERE job = @job'
    else
        DropPlayer(source, "Accès refusé : Vous n'avez pas les autorisations nécessaires.")
        return
    end

    MySQL.Async.execute(query, params, function(rowsChanged)
        if rowsChanged then
            TriggerClientEvent('esx:showNotification', source, 'Les lignes de la table appel_jobs correspondant à votre job ont été supprimées avec succès.')
        else
            -- print('Erreur lors de la suppression des lignes dans la table appel_jobs')
        end
    end)
end)


RegisterNetEvent('sunny:appelDelete:job')
AddEventHandler('sunny:appelDelete:job', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return
    end

    local job = xPlayer.job.name
    local query = ''
    local params = {['@id'] = id, ['@job'] = job}

    if job == 'police' or job == 'bcso' or job == 'sheriff' or job == 'saspn' then
        query = "DELETE FROM appel_jobs WHERE id = @id AND job IN ('police', 'bcso', 'sheriff', 'saspn')"
        params = {['@id'] = id}
    elseif job == 'garage_octacyp'
        or job == 'garage_lscustom'
        or job == 'garage_speedhunters'
        or job == 'garage_paletocustoms'
        or job == 'garage_eastcustoms'
        or job == 'garage_driveline' then
            query = 'DELETE FROM appel_jobs WHERE id = @id AND job = @job'
    else
        return
    end

    MySQL.Async.execute(query, params, function(rowsChanged)
        if rowsChanged > 0 then
        else
        end
    end)

    sendLog(('Delete Appel (%s - %s)'):format(xPlayer.name, xPlayer.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Joueur', subtitle = xPlayer.name},
            {title = 'ID Unique', subtitle = xPlayer.UniqueID},
            {title = 'Identifier', subtitle = xPlayer.identifier},
            {title = "ID de l'appel", subtitle = id},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'bennys_delete_appel'
    })
end)
