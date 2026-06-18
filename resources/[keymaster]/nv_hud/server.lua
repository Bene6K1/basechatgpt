

ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('nv_hud:getUniqueId', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(nil)
        return
    end

    local uniqueId
    if xPlayer.getUniqueID then
        uniqueId = xPlayer.getUniqueID()
    end

    if not uniqueId or uniqueId == '' then
        if xPlayer.getIdentifier then
            uniqueId = xPlayer.getIdentifier()
        else
            uniqueId = xPlayer.identifier
        end
    end

    cb(uniqueId)
end)