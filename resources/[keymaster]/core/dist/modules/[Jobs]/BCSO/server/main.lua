ESX.RegisterServerCallback('sunny:bcso:search', function(source, cb, player)
    local targetPlayer = ESX.GetPlayerFromId(player)

    if targetPlayer then
        local data = {}
        data[player] = {
            inventory = targetPlayer.inventory,
            loadout = targetPlayer.loadout,
            cash = targetPlayer.getAccount('cash').money,
            black_money = targetPlayer.getAccount('black_money').money,
            id = targetPlayer.source
        }
        cb(data[player])

        TriggerClientEvent('esx:showNotification', targetPlayer.source, '👮 La bcso vous fouille')
    else
        cb(false)
    end
end)

RegisterNetEvent('Bcso:ForcerId')
AddEventHandler('Bcso:ForcerId', function(id)
    local _src = source
    TriggerClientEvent('montrer:identity', id)
end)

RegisterNetEvent('Bcso:ForcerDrive')
AddEventHandler('Bcso:ForcerDrive', function(id)
    local _src = source
    TriggerClientEvent('montrer:drive', id)
end)

RegisterNetEvent('Bcso:ForcerPPA')
AddEventHandler('Bcso:ForcerPPA', function(id)
    local _src = source
    TriggerClientEvent('montrer:ppa', id)
end)

RegisterNetEvent('sunny:bcso:menotter', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end
    local targetPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent('sunny:bcso:menotter', targetPlayer.source)
end)

RegisterNetEvent('sunny:bcso:plainte:register', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end

    MySQL.Async.execute('INSERT INTO bcso_plainte (name, date, numberphone, reason, author) VALUES (@name, @date, @numberphone, @reason, @author)', {
        ['@name'] = data.name, 
        ['@date'] = data.date,
        ['@numberphone'] = data.numberphone, 
        ['@reason'] = data.reason,
        ['@author'] = ('%s %s'):format(xPlayer.firstname, xPlayer.lastname),
    }, function()
        TriggerClientEvent('esx:showNotification', source, '📝 Plainte enregistrée avec succès')
    end)
end)

ESX.RegisterServerCallback('sunny:bcso:plainte:get', function(source, cb)
    local plaintes = {}

    MySQL.Async.fetchAll('SELECT * FROM bcso_plainte', {}, function(result)
        for k,v in pairs(result) do
            table.insert(plaintes, v)
        end

        cb(plaintes)
    end)
end)

RegisterNetEvent('sunny:bcso:plainte:delete', function(id)
    local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end
    MySQL.Async.execute('DELETE FROM bcso_plainte WHERE id = @id', {
        ['@id'] = id
    }, function()
        TriggerClientEvent('esx:showNotification', source, 'Plainte supprimée avec succès')
    end)
end)

RegisterNetEvent('sunny:bcso:plainte:editReason', function(id, newReason)
    local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end
    MySQL.Async.execute('UPDATE bcso_plainte SET reason = @reason WHERE id = @id', {
        ['@id'] = id,
        ['@reason'] = newReason
    }, function()
        TriggerClientEvent('esx:showNotification', source, 'La raison de la plainte a bien était modifiée')
    end)
end)

RegisterNetEvent('sunny:bcso:escoter', function(target)
    local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer.job.name == "saspn" or not xPlayer.job.name == "bcsosandy" then return end
    TriggerClientEvent('sunny:bcso:escoter', target, source)
end)

RegisterNetEvent('sunny:bcso:playerVehicle', function(target, vehicle, value)
    TriggerClientEvent('sunny:bcso:playerVehicle', target, vehicle, value)
end)

ESX.RegisterServerCallback('sunny:bcso:vehicle:searchPlate', function(source, cb, plate)
    local vehicle = {}
    vehicle[plate] = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        if result[1] == nil then
            vehicle[plate] = {
                plate = plate,
                owner = 'Inconnu'
            }
            cb(vehicle[plate])
            return
        end
        for k,v in pairs(result) do
            MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {
                ['@UniqueID'] = v.owner
            }, function(reuslt2)
                vehicle[plate] = {
                    plate = plate,
                    owner = ('%s %s'):format(reuslt2[1].firstname, reuslt2[1].lastname)
                }
                cb(vehicle[plate])
            end)
        end
    end)
end)



RegisterNetEvent('sunny:bcso:service', function(value)
    local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

        if not xPlayer.job.name == "saspn" or not xPlayer.job.name == "bcsosandy" then return end
    local players = ESX.GetExtendedPlayers('job', 'bcso')

    for k,v in pairs(players) do
        if value == true then
            TriggerClientEvent('esx:showNotification', v.source, ('L\'agent ~y~%s~s~ vient de prendre son service ~p~bcso'):format(GetPlayerName(source)))
        else
            TriggerClientEvent('esx:showNotification', v.source, ('L\'agent ~y~%s~s~ vient de finir son service ~p~bcso'):format(GetPlayerName(source)))
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if not xPlayer then return end

    if not Sunnybcso.bcso.RemoveWeaponsOnDisconnect then return end

    local weaponList = {
        'stungun',
        'kevlar',
        'nightstick',
        'flashlight',
        'vintagepistol',
        'carbinerifle',
        'smg',
        'assaultsmg',
        'pumpshotgun',
        'bullpupshotgun'
    }

    for _, weapon in ipairs(weaponList) do
        local item = xPlayer.getInventoryItem(weapon)
        if item and item.count > 0 then
            xPlayer.removeInventoryItem(weapon, item.count)
        end
    end

    LogsJobFunc.SendLogsArmurie('LSPD_armu', ('**%s %s** a été déconnecté et ses armes ont été retirées'):format(xPlayer.firstname, xPlayer.lastname), 'disconnect')
end)

RegisterNetEvent('sunny:bcso.removeWeapon', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcso" and xPlayer.job.name ~= "bcsosandy" then return end
    local xPlayerName = ('%s %s'):format(xPlayer.firstname, xPlayer.lastname)

    local weaponList = {
        {required_grade = 0, name = 'stungun'},
        {required_grade = 0, name = 'kevlar'},
        {required_grade = 0, name = 'nightstick'},
        {required_grade = 0, name = 'flashlight'},
        {required_grade = 1, name = 'vintagepistol'},
        {required_grade = 4, name = 'carbinerifle'},
        {required_grade = 5, name = 'smg'},
        {required_grade = 6, name = 'assaultsmg'},
        {required_grade = 7, name = 'pumpshotgun'},
        {required_grade = 8, name = 'bullpupshotgun'}
    }

    for _, weapon in ipairs(weaponList) do
        if xPlayer.getInventoryItem(weapon.name).count > 0 then
            xPlayer.removeInventoryItem(weapon.name, xPlayer.getInventoryItem(weapon.name).count)
        end
    end

    TriggerClientEvent('esx:showNotification', source, 'Vous avez rendu vos armes de service')
    LogsJobFunc.SendLogsArmurie('LSPD_armu', ('**%s** vient de rendre ses armes de service'):format(xPlayerName), 'pose')
end)

RegisterNetEvent('sunny:bcso:giveweapon', function(name, label)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'êtes pas BCSO')
        logsACJob.SendLogsACJob('weapon', ('%s a tenté de se give une arme ID Unique: **%s** (trigger: policegiveweapon)'):format(xPlayer.name, xPlayer.UniqueID))
        return
    end

    local itemName = type(name) == "string" and name:upper() or name
    local currentCount = exports.ox_inventory:GetItem(xPlayer.source, itemName, nil, true) or 0
    if currentCount > 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous avez déjà pris cette arme de service')
        return
    end

    local success = exports.ox_inventory:AddItem(xPlayer.source, itemName, 1)
    if not success then return end
    TriggerClientEvent('esx:showNotification', source, 'Vous avez pris ' .. label)
    LogsJobFunc.SendLogsArmurie('LSPD_armu', ('**%s** vient de prendre une arme dans le casier x1 *%s*'):format(xPlayer.firstname .. " " .. xPlayer.lastname, label), 'take')
end)

RegisterNetEvent('sunny:bcso:giveammo', function(name, label, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" then
        LogsJobFunc.SendLogsArmurie('BCSO_AntiCheat', ('**%s %s** a tenté de récupérer des munitions sans être en service BCSO'):format(xPlayer.firstname, xPlayer.lastname), 'anticheat')
        return
    end

    xPlayer.addInventoryItem(string.lower(name), quantity)
    TriggerClientEvent('esx:showNotification', source, ('Vous avez pris x%s %s'):format(quantity, label))
    LogsJobFunc.SendLogsArmurie('BCSO_armu', ('**%s %s** vient de prendre des munitions x%s *%s*'):format(xPlayer.firstname, xPlayer.lastname, quantity, label), 'take')
end)


RegisterNetEvent('sunny:bcso:renforts', function(coords, value)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or not xPlayer.job or not xPlayer.job.name then return end
    if xPlayer.job.name ~= 'bcso' and xPlayer.job.name ~= 'bcsosandy' and xPlayer.job.name ~= 'saspn' then return end

    local recipients = {}
    local function addRecipientsByJob(j)
        local list = ESX.GetExtendedPlayers('job', j)
        for _, p in pairs(list) do recipients[p.source] = true end
    end
    addRecipientsByJob('bcso')
    addRecipientsByJob('bcsosandy')
    addRecipientsByJob('saspn')

    local function formatCoords(data)
        if type(data) == 'table' and data.x and data.y and data.z then
            return {x = data.x + 0.0, y = data.y + 0.0, z = data.z + 0.0}
        elseif type(data) == 'vector3' then
            return {x = data.x + 0.0, y = data.y + 0.0, z = data.z + 0.0}
        elseif type(data) == 'table' and data[1] and data[2] and data[3] then
            return {x = data[1] + 0.0, y = data[2] + 0.0, z = data[3] + 0.0}
        end
        return nil
    end

    local displayName
    if xPlayer.firstname and xPlayer.lastname then
        displayName = ('%s %s'):format(xPlayer.firstname, xPlayer.lastname)
    elseif xPlayer.getName then
        displayName = xPlayer.getName()
    else
        displayName = GetPlayerName(source) or ('Unité #%s'):format(source)
    end

    local payload = {
        type = value,
        coords = formatCoords(coords),
        sender = displayName
    }

    for src, _ in pairs(recipients) do
        TriggerClientEvent('sunny:bcso:renforts', src, payload)
    end
end)

RegisterNetEvent('sunny:bcso:removeItem', function(count, name, player, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerTarget = ESX.GetPlayerFromId(player)
    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end
    local m = ESX.GetPlayerFromId(source)
    if not SunnyConfigServ.PermanentItem[name] then
    if not m.canCarryItem(name, 1) then TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") return end
    xPlayerTarget.removeInventoryItem(name, count)
    m.addInventoryItem(name, count)

    TriggerClientEvent('esx:showNotification', player, ('La bcso vous a saisis ~r~x%s~s~ %s'):format(count, label))
    end
end)

RegisterNetEvent('sunny:bcso.removeWeapon', function(name, player, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerTarget = ESX.GetPlayerFromId(player)
    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end
    local m = ESX.GetPlayerFromId(source)
    if not SunnyConfigServ.PermanantWeapon[name] then
    xPlayerTarget.removeWeapon(name)
    m.addInventoryItem(string.lower(name), 1)


    TriggerClientEvent('esx:showNotification', player, ('La bcso vous a saisis ~r~x%s~s~ %s'):format(1, label))
    end
end)

RegisterNetEvent('sunny:bcso:removeMoney', function(count, player)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerTarget = ESX.GetPlayerFromId(player)
    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end
    local m = ESX.GetPlayerFromId(source)

    xPlayerTarget.removeAccountMoney('black_money', count)
    m.addAccountMoney('black_money', count)

    TriggerClientEvent('esx:showNotification', player, ('La bcso vous a saisis ~r~x%s~s~ %s'):format(count, 'd\'argent sale'))
end)

RegisterNetEvent('sunny:bcso:ppa', function(player)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "saspn" and xPlayer.job.name ~= "bcsosandy" and xPlayer.job.name ~= "bcso" then return end
    local targetPlayer = ESX.GetPlayerFromId(player)

    if not targetPlayer then
        TriggerClientEvent('esx:showNotification', source, 'Joueur introuvable')
        return
    end

    -- Vérifier si la personne a déjà le PPA
    MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type'] = 'weapon',
        ['@owner'] = targetPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('esx:showNotification', source, 'Cette personne possède déjà le PPA')
            return
        end

        if targetPlayer.getAccount('bank').money < 25000 then
            TriggerClientEvent('esx:showNotification', source, 'La personne n\'a pas les fonds nécessaires (25 000$)')
            return
        end

        targetPlayer.removeAccountMoney('bank', 25000)

        MySQL.Async.execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {
            ['@type'] = 'weapon',
            ['@owner'] = targetPlayer.identifier
        })

        local society = Society:getSociety(xPlayer.job.name)
        if society then
            society.addSocietyMoney(25000)
        end

        TriggerClientEvent('esx:showNotification', source, 'PPA délivré avec succès')
        TriggerClientEvent('esx:showNotification', targetPlayer.source, 'Vous avez reçu votre Permis de Port d\'Arme (PPA)')
    end)
end)

RegisterNetEvent('sunny:bcso:sendCode', function(codeId, message, coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if xPlayer.job.name ~= 'bcso' and xPlayer.job.name ~= 'bcsosandy' and xPlayer.job.name ~= 'saspn' then
        return
    end

    local jobsTargets = {'bcso', 'bcsosandy', 'saspn'}
    local alreadySent = {}
    local displayName = (xPlayer.firstname and xPlayer.lastname) and (('%s %s'):format(xPlayer.firstname, xPlayer.lastname))
    if not displayName then
        if xPlayer.getName then
            displayName = xPlayer.getName()
        else
            displayName = GetPlayerName(source) or ('Unité #%s'):format(source)
        end
    end

    local payload = {
        codeId = codeId,
        message = message,
        coords = (type(coords) == 'table' and coords.x and coords.y and coords.z) and coords or nil,
        sender = displayName
    }

    for _, jobName in ipairs(jobsTargets) do
        local players = ESX.GetExtendedPlayers('job', jobName) or {}

        for _, v in pairs(players) do
            if not alreadySent[v.source] then
                alreadySent[v.source] = true
                TriggerClientEvent('sunny:bcso:sendCode', v.source, payload)
            end
        end
    end
end)