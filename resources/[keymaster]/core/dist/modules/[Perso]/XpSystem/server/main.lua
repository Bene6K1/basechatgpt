AddEventHandler('esx:playerLoaded', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        TriggerClientEvent('XNL_NET:XNL_SetInitialXPLevels', source, result[1].xp, true, true)
    end)
end)

RegisterNetEvent("XNL_NET:AddPlayerXP", function(xp, token)
    xp = tonumber(xp) or 0
    if xp <= 0 then
        return
    end

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return end

    if xp > 1050 and xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= 'responsable' then
        DropPlayer(source, SunnyConfigServ.XpSystems.KickMessage)
        return 
    end

    TriggerClientEvent("XNL_NET:AddPlayerXP", src, xp)
    MySQL.Async.execute("UPDATE users SET xp = xp + @xp WHERE identifier = @identifier", {["@xp"] = xp, ["@identifier"] = xPlayer.identifier}, function() end)
end)