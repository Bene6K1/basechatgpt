ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent('contextmenu:checkLicence')
AddEventHandler('contextmenu:checkLicence', function()
    src = source
    myLicence = GetPlayerIdentifiers(src)[1]
    TriggerClientEvent('contextmenu:checkLicence:send', src, myLicence)
end)


RegisterServerEvent('contextmenu:NetworkOverrideClockTime')
AddEventHandler('contextmenu:NetworkOverrideClockTime', function(time)
    local src = source
    if IsAllowed(src) then
        TriggerClientEvent('contextmenu:NetworkOverrideClockTime_response', -1, time)
    end
end)

RegisterServerEvent('contextmenu:SetWeatherType')
AddEventHandler('contextmenu:SetWeatherType', function(weather)
    local src = source
    if IsAllowed(src) then
        TriggerClientEvent('contextmenu:SetWeatherType_response', -1, weather)
    end
end) 

ESX.RegisterServerCallback('BahFaut:getUsergroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    cb(group)
end)

RegisterServerEvent("GiveCashBy:DeaDTriX")
AddEventHandler("GiveCashBy:DeaDTriX", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local name = GetPlayerName(source)
    
    xPlayer.addMoney((total))

    local item = '~g~€ en liquide.'
    local message = '~g~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
end)

RegisterServerEvent("GiveBankBy:DeaDTriX")
AddEventHandler("GiveBankBy:DeaDTriX", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local name = GetPlayerName(source)
    
    xPlayer.addAccountMoney('bank', total)

    local item = '~b~$ en banque.'
    local message = '~b~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
end)

RegisterServerEvent("GiveSaleBy:DeaDTriX")
AddEventHandler("GiveSaleBy:DeaDTriX", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local name = GetPlayerName(source)
    
    xPlayer.addAccountMoney('black_money', total)

    local item = '~r~$ d\'argent sale.'
    local message = '~r~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message..total..item)
end)

RegisterServerEvent('DeaDTrIX:kickjoueur')
AddEventHandler('DeaDTrIX:kickjoueur', function(player, raison)
    local steam
    local playerId = source
    local PcName = GetPlayerName(playerId)
    local joueur = GetPlayerName(player)
    for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
        if string.match(v, 'steam:') then
            steam = string.sub(v, 7)
            break
        end
    end

    DropPlayer(player, raison)
end)

RegisterServerEvent('DeaDTriX:GiveVehicule')
AddEventHandler('DeaDTriX:GiveVehicule', function (vehicleProps,giveplate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
    {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = giveplate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function (rowsChanged)
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez Réussie')
    end)
end)

RegisterNetEvent('Acheter')
AddEventHandler('Acheter', function(item,prix)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    local name = GetPlayerName(source)

    if playerMoney >= prix then
        xPlayer.addInventoryItem(item, 1)
        xPlayer.removeMoney(prix)
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~o~"..item.." ~s~!")
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien dépensez ~o~"..prix.."~s~!")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez !")
    end
end)


-- PROMOTE

RegisterServerEvent('deadtrix-context:server:recrut')
AddEventHandler('deadtrix-context:server:recrut', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob = sourceXPlayer.getJob()

    if sourceJob.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)

        targetXPlayer.setJob(sourceJob.name, 0)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~recruté %s~w~.'):format(targetXPlayer.name))
        TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~embauché par %s~w~.'):format(sourceXPlayer.name))
    end
end)) 

RegisterServerEvent('deadtrix-context:server:recrut2')
AddEventHandler('deadtrix-context:server:recrut2', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob2 = sourceXPlayer.getJob2()

    if sourceJob2.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)

        targetXPlayer.setJob2(sourceJob2.name, 0)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~recruté %s~w~.'):format(targetXPlayer.name))
        TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~embauché par %s~w~.'):format(sourceXPlayer.name))
    end
end))


RegisterServerEvent('deadtrix-context:server:virer')
AddEventHandler('deadtrix-context:server:virer', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob = sourceXPlayer.getJob()

    if sourceJob.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)
        local targetJob = targetXPlayer.getJob()

        if sourceJob.name == targetJob.name then
            targetXPlayer.setJob('unemployed', 0)
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~viré %s~w~.'):format(targetXPlayer.name))
            TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~viré par %s~w~.'):format(sourceXPlayer.name))
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre entreprise.')
        end
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end))

RegisterServerEvent('deadtrix-context:server:promote')
AddEventHandler('deadtrix-context:server:promote', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob = sourceXPlayer.getJob()

    if sourceJob.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)
        local targetJob = targetXPlayer.getJob()

        if sourceJob.name == targetJob.name then
            local newGrade = tonumber(targetJob.grade) + 1

            if newGrade ~= getMaximumGrade(targetJob.name) then
                targetXPlayer.setJob(targetJob.name, newGrade)

                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~promu %s~w~.'):format(targetXPlayer.name))
                TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~promu par %s~w~.'):format(sourceXPlayer.name))
            else
                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation ~r~Gouvernementale~w~.')
            end
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre entreprise.')
        end
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end))

RegisterServerEvent('deadtrix-context:server:destituer')
AddEventHandler('deadtrix-context:server:destituer', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob = sourceXPlayer.getJob()

    if sourceJob.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)
        local targetJob = targetXPlayer.getJob()

        if sourceJob.name == targetJob.name then
            local newGrade = tonumber(targetJob.grade) - 1

            if newGrade >= 0 then
                targetXPlayer.setJob(targetJob.name, newGrade)

                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~rétrogradé %s~w~.'):format(targetXPlayer.name))
                TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~r~rétrogradé par %s~w~.'):format(sourceXPlayer.name))
            else
                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas ~r~rétrograder~w~ d\'avantage.')
            end
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
        end
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end))


RegisterServerEvent('deadtrix-context:server:virer2')
AddEventHandler('deadtrix-context:server:virer2', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob2 = sourceXPlayer.getJob2()

    if sourceJob2.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)
        local targetJob2 = targetXPlayer.getJob2()

        if sourceJob2.name == targetJob2.name then
            targetXPlayer.setJob2('unemployed2', 0)
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~viré %s~w~.'):format(targetXPlayer.name))
            TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~viré par %s~w~.'):format(sourceXPlayer.name))
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
        end
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end))

RegisterServerEvent('deadtrix-context:server:promote2')
AddEventHandler('deadtrix-context:server:promote2', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob2 = sourceXPlayer.getJob2()

    if sourceJob2.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)
        local targetJob2 = targetXPlayer.getJob2()

        if sourceJob2.name == targetJob2.name then
            local newGrade = tonumber(targetJob2.grade) + 1

            if newGrade ~= getMaximumGrade(targetJob2.name) then
                targetXPlayer.setJob2(targetJob2.name, newGrade)

                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~promu %s~w~.'):format(targetXPlayer.name))
                TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~promu par %s~w~.'):format(sourceXPlayer.name))
            else
                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation ~r~Gouvernementale~w~.')
            end
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
        end
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end))


RegisterServerEvent('deadtrix-context:server:derank2')
AddEventHandler('deadtrix-context:server:derank2', (function(target)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local sourceJob2 = sourceXPlayer.getJob2()

    if sourceJob2.grade_name == 'boss' then
        local targetXPlayer = ESX.GetPlayerFromId(target)
        local targetJob2 = targetXPlayer.getJob2()

        if sourceJob2.name == targetJob2.name then
            local newGrade = tonumber(targetJob2.grade) - 1

            if newGrade >= 0 then
                targetXPlayer.setJob2(targetJob2.name, newGrade)

                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~rétrogradé %s~w~.'):format(targetXPlayer.name))
                TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~r~rétrogradé par %s~w~.'):format(sourceXPlayer.name))
            else
                TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas ~r~rétrograder~w~ d\'avantage.')
            end
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
        end
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end))

RegisterServerEvent('deadtrixcontext:envoyeremployer')
AddEventHandler('deadtrixcontext:envoyeremployer', function(info, message)
    print('test2')
    local _source = source
    local _raison = info
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)
    local job = xPlayer.getJob()


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == job.name then
            TriggerClientEvent('deadtrixcontext:envoyeremployer2', xPlayers[i], _raison, name, message)
            print('test')
        end
    end
end)
