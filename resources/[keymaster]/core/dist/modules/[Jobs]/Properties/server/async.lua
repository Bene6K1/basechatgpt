Properties = Properties or {}
Properties.PropertiesList = Properties.PropertiesList or {}
Properties.Loaded = Properties.Loaded or false
Properties.VehicleProperties = Properties.VehicleProperties or {}

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
    ESX.GetPlayerFromUniqueId = function(uniqueId)
        local uidStr = tostring(uniqueId)
        for _, playerId in ipairs(ESX.GetPlayers()) do
            local xP = ESX.GetPlayerFromId(playerId)
            if xP and tostring(xP.UniqueID) == uidStr then
                return xP
            end
        end
        return nil
    end
end)