RegisterServerEvent('weazel:broadcastNotification')
AddEventHandler('weazel:broadcastNotification', function(title, description)
    TriggerClientEvent('weazel:showNotification', -1, title, description)
end)

function TriggerWeazelNotification(title, description, ticker)
    TriggerClientEvent('weazel:showNotification', -1, title, description, ticker)
end

exports('TriggerWeazelNotification', TriggerWeazelNotification)

