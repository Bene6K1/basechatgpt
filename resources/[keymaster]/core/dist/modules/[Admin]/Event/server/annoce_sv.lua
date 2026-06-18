RegisterServerEvent("sv_slide:event:annonce")
AddEventHandler("sv_slide:event:annonce", function(input)
    local xPlayers = ESX.GetPlayers()
    local VVxPlayer = ESX.GetPlayerFromId(source)
    if VVxPlayer.getGroup() == 'user' then return end
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("sunny:event:annonce", -1, input)
    end
end)