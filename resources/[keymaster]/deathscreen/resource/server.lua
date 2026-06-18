

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('neva-deathscreen:checkPermission', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then
        cb(false)
        return
    end
    
    local group = xPlayer.getGroup()
    
    -- Vérifier si le groupe est dans la liste des permissions pour la commande /kill
    for _, allowedGroup in ipairs(Config.KillCommandPermissions) do
        if group == allowedGroup then
            cb(true)
            return
        end
    end
    
    cb(false)
end)

ESX.RegisterServerCallback('neva-deathscreen:isStaff', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then
        cb(false)
        return
    end
    
    local group = xPlayer.getGroup()
    
    for _, allowedGroup in ipairs(Config.StaffRevive.AllowedGroups) do
        if group == allowedGroup then
            cb(true)
            return
        end
    end
    
    cb(false)
end)

RegisterNetEvent('neva-deathscreen:staffRevive')
AddEventHandler('neva-deathscreen:staffRevive', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return end
    
    local group = xPlayer.getGroup()
    local isStaff = false
    
    for _, allowedGroup in ipairs(Config.StaffRevive.AllowedGroups) do
        if group == allowedGroup then
            isStaff = true
            break
        end
    end
    
    if isStaff then
        TriggerClientEvent('sunny:admin:revive', source)
    end
end)

RegisterNetEvent('neva-deathscreen:killPlayer')
AddEventHandler('neva-deathscreen:killPlayer', function(targetUniqueID)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return end
    
    local group = xPlayer.getGroup()
    local hasPermission = false
    
    for _, allowedGroup in ipairs(Config.KillCommandPermissions) do
        if group == allowedGroup then
            hasPermission = true
            break
        end
    end
    
    if not hasPermission then return end
    
    local targetPlayer = nil
    local players = ESX.GetPlayers()
    
    for _, playerId in ipairs(players) do
        local target = ESX.GetPlayerFromId(playerId)
        if target and target.UniqueID == targetUniqueID then
            targetPlayer = playerId
            break
        end
    end
    
    if targetPlayer then
        TriggerClientEvent('neva-deathscreen:killTarget', targetPlayer)
        TriggerClientEvent('esx:showNotification', source, '~g~Joueur avec l\'ID unique ' .. targetUniqueID .. ' a été tué.')
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Aucun joueur trouvé avec l\'ID unique ' .. targetUniqueID)
    end
end)