-- RegisterNetEvent('sunny:FreezePlayer', function(target)
--     if IsEntityPositionFrozen(NetworkGetEntityFromNetworkId(target)) then
--         TriggerClientEvent('sunny:freeze', target, false)
--     else
--         TriggerClientEvent('sunny:freeze', target, true)
--     end
-- end)

ESX.RegisterServerCallback('sunny:getTargetId', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    if xPlayer then
        local targetId = xPlayer.UniqueID
        cb(targetId)
    else
        cb(nil)
    end
end)

-- Event pour demander l'animation d'un joueur (relais vers le joueur cible)
RegisterNetEvent('Wezor:requestAnim', function(targetServerId)
    local source = source
    -- Demande au joueur cible son animation actuelle
    TriggerClientEvent('Wezor:requestAnim', targetServerId, source)
end)

-- Event pour recevoir l'animation et la renvoyer au demandeur
RegisterNetEvent('Wezor:sendAnimation', function(requesterServerId, animName, variation)
    -- Renvoie l'animation au joueur qui l'a demandée
    TriggerClientEvent('Wezor:receiveAnimation', requesterServerId, animName, variation)
end)