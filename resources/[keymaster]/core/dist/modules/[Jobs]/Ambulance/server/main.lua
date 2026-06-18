

Ambulance = {
    Service = {},
    Appelles = {},
    IsDead = {},

    Employeds = {}
}

RegisterServerEvent('ambulance:server:startRadiography')
AddEventHandler('ambulance:server:startRadiography', function(radioLimb)
    local _source = source
    TriggerClientEvent('ambulance:client:startRadiography', _source, radioLimb)
end)


RegisterNetEvent("sunny:reamoi")
AddEventHandler("sunny:reamoi", function(player)

    local xPlayer = ESX.GetPlayerFromId(source)

    local tPlayer = ESX.GetPlayerFromId(player)
    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(player))) < 10 then 
        --if PlayerDead[tPlayer.identifier] then 
            if xPlayer.getAccount('bank').money < 1200 then return TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas les 5000$ en banque") end
            TriggerClientEvent("sunny:ambulance:revive", tPlayer.source)
            TriggerClientEvent("esx:showNotification", tPlayer.source, "Vous avez été réanimé par un défibirlateur")
            TriggerClientEvent("esx:showNotification", source, "Vous avez réanimé le citoyen")
            xPlayer.removeAccountMoney('bank', 1200)
       -- else
        --    TriggerClientEvent("esx:showNotification", tPlayer.source, "Le citoyen n'est pas mort")
       -- end

    else
        DropPlayer(xPlayer, 'Mv Tu aime les defibrilateur ?')
    end


end)

RegisterServerEvent('ambulance:ata:server:setAta')
AddEventHandler('ambulance:ata:server:setAta', function(targetPlayerId, ataTime, ataType)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer.job.name == "ambulance" or not xPlayer.job.name == "ambulancesandy" then
        DropPlayer(source, "Tu trigger toi ???")
        return
    end

    local xTarget = ESX.GetPlayerFromId(targetPlayerId)
    if xTarget == nil then
        TriggerClientEvent('esx:showNotification', source, "~r~Aucune personne aux alentours.")
        return
    end
    local ataData = {
        time = ataTime,
        type = ataType
    }
    TriggerClientEvent('esx:showNotification', targetPlayerId, ("~g~Vous avez reçu un ATA de %d minutes"):format(ataTime))
    
    TriggerClientEvent('ata:client:update', targetPlayerId, {type = zoneType, time = ataTime})
    
    sendLog(('Le staff (%s - %s) a attribué un ATA de %d minutes à (%s - %s)'):format(
        xPlayer.name, xPlayer.UniqueID, ataTime, xTarget.name, xTarget.UniqueID
    ), {
        author = 'ATA Amulance',
        fields = {
            {title = 'Staff', subtitle = xPlayer.name},
            {title = 'ID Unique Staff', subtitle = xPlayer.UniqueID},
            {title = 'Target Player', subtitle = xTarget.name},
            {title = 'ID Unique Target', subtitle = xTarget.UniqueID},
            {title = 'ATA Time (minutes)', subtitle = ataTime},
        },
        channel = 'ataambulance'
    })
end)

RegisterNetEvent('sunny:ambulance:stungun', function()
    local _src = source
    
    if source > 0 then
        local xPlayer = ESX.GetPlayerFromId(_src)
       
    
        TriggerClientEvent('sunny:ambulance:stungun', xPlayer.source)
    end
end)

RegisterNetEvent('ambulance:ata:server:setAta', function (number)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer then
        TriggerClientEvent('ambulance:ata:client:setAta', xPlayer.source, number, 1)
    end
end)



ESX.RegisterServerCallback('sunny:ambulance:getKilerID', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- print('sdqfsdfsdfd get id ', target)

    if not xPlayer then return end

    xTartget = ESX.GetPlayerFromId(target)
    if xTartget then
        -- print(xTartget.UniqueID)
        cb(xTartget.UniqueID)
    end
    
end)

RegisterNetEvent('sunny:ambulance:service', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer.job.name == "ambulance" or not xPlayer.job.name == "ambulancesandy" then return end
    local source = source


    Ambulance.Service[xPlayer.UniqueID] = not Ambulance.Service[xPlayer.UniqueID]

    TriggerClientEvent('sunny:ambulance:service', source, Ambulance.Service[xPlayer.UniqueID])

    if Ambulance.Service[xPlayer.UniqueID] then
        Ambulance.Employeds[xPlayer.UniqueID] = {
            name = xPlayer.name
        }
        TriggerClientEvent('sunny:ambulance:addEmployed', -1, xPlayer.UniqueID, Ambulance.Employeds[xPlayer.UniqueID])

    else
        Ambulance.Service[xPlayer.UniqueID] = nil
        TriggerClientEvent('sunny:ambulance:removeEmployed', -1, xPlayer.UniqueID)

    end
end)

RegisterNetEvent('sunny:ambulance:death', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('INSERT INTO player_isdead (UniqueID) VALUES (@UniqueID)', {
        ['@UniqueID'] = xPlayer.UniqueID
    }, function()
    end)

    MySQL.Async.execute('UPDATE users SET is_dead = @i WHERE UniqueID = @u', {['@u'] = xPlayer.UniqueID, ['@i'] = true}, function()

    end)

    TriggerClientEvent('sunny:ambulance:death', source)
    
end)


RegisterNetEvent('sunny:ambulance:call', function(playerCoords)
    local xPlayer = ESX.GetPlayerFromId(source)

   -- if xPlayer.job.name ~= "ambulance" then return end

    if Ambulance.Appelles[xPlayer.UniqueID] then return end

    Ambulance.Appelles[xPlayer.UniqueID] = {
        name = xPlayer.name,
        UniqueID = xPlayer.UniqueID,
        position = playerCoords,
        take = false
    }

    local xxxxxxx = ESX.GetExtendedPlayers('job', 'ambulance')

    for k,v in pairs(xxxxxxx) do
        TriggerClientEvent('sunny:ambulance:addCall', v.source, xPlayer.UniqueID, Ambulance.Appelles[xPlayer.UniqueID])

        if Ambulance.Service[v.UniqueID] then
            TriggerClientEvent('esx:showNotification', v.source, '📞 Un nouvel appelle a été recus #'..xPlayer.UniqueID)
        end
    end


end)

RegisterNetEvent('sunny:ambulance:takeAppel', function(k)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "ambulance" then return end

    Ambulance.Appelles[k].take = true

    local xxxxxxx = ESX.GetExtendedPlayers('job', 'ambulance')

    for i,v in pairs(xxxxxxx) do

       TriggerClientEvent('sunny:ambulance:updateCall', i, k, Ambulance.Appelles[k])

        if Ambulance.Service[v.UniqueID] then
            TriggerClientEvent('esx:showNotification', k, ('📞 %s a pris en charge l\'appel '..i):format(GetPlayerName(source)))
        end
    end

    TriggerClientEvent('sunny:ambulance:takeMyCall', source, k)

    if not ReturnPlayerId(Ambulance.Appelles[k].UniqueID) then return end

    TriggerClientEvent('esx:showNotification', ReturnPlayerId(Ambulance.Appelles[k].UniqueID).id, '🚑 Un médecin est en route !')

end)

RegisterNetEvent('sunny:ambulance:closeAppel', function(k)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer.job.name == "ambulance" or not xPlayer.job.name == "ambulancesandy" then return end

    if Ambulance.Appelles[k] ~= nil then
        Ambulance.Appelles[k] = nil
    end

    TriggerClientEvent('sunny:ambulance:removeCall', -1, k)

    local players = ESX.GetExtendedPlayers('job', 'ambulance')

    for k,v in pairs(players) do
        if Ambulance.Service[v.UniqueID] then
            TriggerClientEvent('esx:showNotification', k, ('📞 %s a terminé l\'appel '..k):format(GetPlayerName(source)))
        end
    end
end)

RegisterNetEvent('sunny:ambulance:revive', function(target)
    
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    local society = Society:getSociety(xPlayer.job.name)

    if not society then return end
    if not xPlayer.job.name == "ambulance" or not xPlayer.job.name == "ambulancesandy" then
        TriggerClientEvent("esx:showNotification", source, 'Vous n\'êtes pas médecin')
        logsACJob.SendLogsACJob('revive', ('%s a tenté de revive (trigger ambulance)  ID: **%s** target ID:'..targetPlayer.UniqueID..''):format(xPlayer.name, xPlayer.UniqueID))
        return 
    end

    if (targetPlayer) then
        local medikitCount = exports.ox_inventory:Search(source, 'count', 'medikit') or 0
        if medikitCount <= 0 then
            TriggerClientEvent('esx:showNotification', source, 'Vous ne possezdez pas assez de Médikit')
            return
        end
        targetPlayer.removeAccountMoney('bank', 2000)
        TriggerClientEvent('esx:showNotification', target, '💲 Vous avez été débité de ~y~2000$~s~ sur votre compte banquaire')
        TriggerClientEvent('sunny:ambulance:revive', target)

        xPlayer.addAccountMoney('bank', 500)
        society.addSocietyMoney(1500)
        TriggerClientEvent("esx:showNotification", source, 'Le joueur a été débiter de ~y~2000$~s~\n~y~500$~s~ pour vous\n~y~1500$~s~ pour l\'entreprise')

        if Ambulance.Appelles[targetPlayer.UniqueID] ~= nil then
            Ambulance.Appelles[targetPlayer.UniqueID] = nil
        end

        TriggerClientEvent('sunny:ambulance:removeCall', -1, targetPlayer.UniqueID)


        exports.ox_inventory:RemoveItem(source, 'medikit', 1)
    else
    end
end)

RegisterNetEvent('sunny:ambulance:heal', function(target, type)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)

    if targetPlayer then
        local bandageCount = exports.ox_inventory:Search(source, 'count', 'bandage') or 0
        if bandageCount <= 0 then 
            TriggerClientEvent('esx:showNotification', source, 'Vous ne possédez pas assez de Bandage') 
            return 
        end
        
        exports.ox_inventory:RemoveItem(source, 'bandage', 1)
        
        TriggerClientEvent('sunny:ambulance:heal', target, type)
        
        TriggerClientEvent('esx:showNotification', source, 'Vous avez soigné le patient')
        TriggerClientEvent('esx:showNotification', target, 'Vous avez été soigné par un EMS')
    else
        TriggerClientEvent('esx:showNotification', source, 'Joueur introuvable')
    end
end)

RegisterNetEvent('sunny:ambulance:sql:removedead', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('DELETE FROM player_isdead WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = xPlayer.UniqueID
    }, function()
    end)

    -- MySQL.Sync.execute('UPDATE users SET is_dead = @i WHERE UniqueID = @u', {['@u'] = xPlayer.UniqueID, ['@i'] = false}, function()

    --     ESX.toConsole(('%s is revive'):format(xPlayer.name))

    -- end)
end)

ESX.RegisterServerCallback('sunny:ambulance:getPlayerDead', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    
    if (xPlayer) then
        MySQL.Async.fetchAll('SELECT * FROM player_isdead WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = xPlayer.UniqueID
        }, function(result)
            if json.encode(result) ~= "[]" then
                cb(true)

            else
                cb(false)
            end
        end)
        
        -- MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE UniqueID = @u', {['@u'] = xPlayer.UniqueID}, function(r)
        --     if r[1].is_dead == 1 or r[1].is_dead == true then cb(true) else cb(false) end

        --     ESX.toConsole(('%s is dead'):format(xPlayer.name))
        -- end)
    end
end)

RegisterNetEvent('sunny:ambulance:onPlayerDeath', function()
    local source = source

    TriggerClientEvent('sunny:ambulance:onPlayerDeathEvent', source)
end)

RegisterNetEvent('sunny:ambulance:buyitem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer.job.name == "ambulance" or not xPlayer.job.name == "ambulancesandy" then
        TriggerClientEvent('esx:showNotification', source, "Ce n'est pas votre travail ! (c'est con hein ?)")
        logsACJob.SendLogsACJob('give', ('%s a tenté d\'acheter un item pour se give (trigger ambulance)'):format(xPlayer.name, xPlayer.UniqueID))
        return 
    end

    if (xPlayer) then
        if xPlayer.getInventoryItem(item).count >= 50 then return TriggerClientEvent('esx:showNotification', source, 'Vous en possédez trop !') end
        if not xPlayer.canCarryItem(item, 1) then TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") return end
        xPlayer.addInventoryItem(item, 1)
    end
end)

RegisterNetEvent('sunny:ambulance:respawn', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local weapons = xPlayer.getLoadout()
    xPlayer.removeAccountMoney('bank', 750)
    TriggerClientEvent('esx:showNotification', source, '💲 Vous avez été débité de ~y~750$~s~ sur votre compte bancaire')

    MySQL.Async.execute('DELETE FROM player_isdead WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = xPlayer.UniqueID
    }, function()
    end)

    if SunnyConfigServ.RemoveWeaponOnRespawn then
        for _, weapon in pairs(weapons) do
            if not SunnyConfigServ.PermanantWeapon[weapon.name] then
                if math.random(1, 10) <= 3 then
                    xPlayer.removeWeapon(weapon.name)
                end
            end
        end
    end

    if SunnyConfigServ.RemoveIllegalItemsOnRespawn then
        for i = 1, #xPlayer.inventory, 1 do
            if xPlayer.inventory[i].count > 0 then
                if SunnyConfigServ.IllegalItem[xPlayer.inventory[i].name] then
                    if math.random(1, 10) <= 3 then
                        xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
                    end
                end
            end
        end
    end

    TriggerClientEvent('esx_status:set', source, 'hunger', 500000)
    TriggerClientEvent('esx_status:set', source, 'thirst', 500000)

    TriggerClientEvent('sunny:admin:teleport', source, vec3(-447.427734, -1027.274658, 33.689331))
    SetEntityHeading(source, 84.243743896484)
end)



RegisterNetEvent('sunny:ambulance:moneyBoss', function(society, amount, action)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer.job.name == "ambulance" or not xPlayer.job.name == "ambulancesandy" then return end

    local society = Society:getSociety(xPlayer.job.name)

    if not society then return end
    if not xPlayer.job.name == "ambulance" or not xPlayer.job.name == "ambulancesandy" then
        TriggerClientEvent('esx:showNotification', source, "Ce n'est pas votre travail ! (c'est con hein ?)")
        logsACJob.SendLogsACJob('money', ('%s a tenté de prendre de l\'argent dans la société ambulance (trigger detect)'):format(xPlayer.name, xPlayer.UniqueID))
        return 
    end

    if action == 'deposit' then
        if xPlayer.getAccount('bank').money < amount then return TriggerClientEvent('esx:showNotification', source, 'Votre solde bancaire n\'est pas assez élevé') end

        society.addMoney(amount)
        xPlayer.removeAccountMoney('bank', amount)

        TriggerClientEvent('esx:showNotification', source, ('Vous avez déposé ~y~%s$~s~'):format(amount))

        -- TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
        --     account.addMoney(amount)
        --     xPlayer.removeAccountMoney('bank', amount)
    
        --     TriggerClientEvent('esx:showNotification', source, ('Vous avez déposez ~y~%s$~s~'):format(amount))
        -- end)
    elseif action == 'remove' then
        society.removeSocietyMoney(amount)
        xPlayer.addAccountMoney('bank', amount)

        TriggerClientEvent('esx:showNotification', source, ('Vous avez pris ~y~%s$~s~'):format(amount))

        -- TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
        --     if account.money < amount then return TriggerClientEvent('esx:showNotification', source, 'Il n\'y a pas assez d\'argent dans le coffre') end
        --     account.removeMoney(amount)
        --     xPlayer.addAccountMoney('bank', amount)
    
        --     TriggerClientEvent('esx:showNotification', source, ('Vous avez pris ~y~%s$~s~'):format(amount))
        -- end)
    end
end)

CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `player_isdead` (
            UniqueID INT(11) DEFAULT NULL
        );
    ]])
end)