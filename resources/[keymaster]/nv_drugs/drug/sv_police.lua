if Config and Config.ESXMode == 'old' then
    ESX = ESX or nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
    ESX = exports["es_extended"]:getSharedObject()
end

local policeJobName = Config.PoliceJobName or "police"
local alertMessage = Config.AlertMessage or "Vente de drogue en cours"
local blipName = Config.BlipName or "Drogue"

function NotifyPolice(coords)
    TriggerClientEvent('nvDrugs:GetStreetName', source, coords)
end

RegisterNetEvent('nvDrugs:SendStreetNameToServer')
AddEventHandler('nvDrugs:SendStreetNameToServer', function(streetName, pedCoords)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    local locationMessage = string.format("%s à %s", Config.AlertMessage, streetName)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer and xPlayer.job.name == policeJobName then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Police', 'Information', locationMessage, 'CHAR_CALL911', 1)
            TriggerClientEvent('nvDrugs:AddBlipForPolice', xPlayer.source, pedCoords, blipName)
        end
    end
end)
