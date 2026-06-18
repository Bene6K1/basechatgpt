

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local playerUsingItem = {}

local function canPlayerUseItem(source)
    return not playerUsingItem[source]
end

RegisterServerEvent('wItem:updateItemUsageState')
AddEventHandler('wItem:updateItemUsageState', function(state)
    local source = source
    playerUsingItem[source] = state
end)

AddEventHandler('playerDropped', function()
    playerUsingItem[source] = nil
end)

RegisterServerEvent('wItem:itemUsageStatus')
AddEventHandler('wItem:itemUsageStatus', function(canUse, itemName)
    local source = source
    playerUsingItem[source] = not canUse
end)

ESX.RegisterUsableItem('repairkit', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if playerUsingItem[source] then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous êtes déjà en train d\'utiliser un objet!')
        return
    end
    
    TriggerClientEvent('wItem:repairNearestVehicle', source)
end)

RegisterServerEvent("wItem:RepareOK")
AddEventHandler("wItem:RepareOK", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('repairkit', 1)
end)

ESX.RegisterUsableItem('kitcarro', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if playerUsingItem[source] then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous êtes déjà en train d\'utiliser un objet!')
        return
    end
    
    TriggerClientEvent('wItem:cleanNearestVehicle', source)
end)

RegisterServerEvent("wItem:CleanOK")
AddEventHandler("wItem:CleanOK", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('kitcarro', 1)
end)

ESX.RegisterUsableItem('bandage', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if playerUsingItem[source] then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous êtes déjà en train d\'utiliser un objet!')
        return
    end
    
    if xPlayer.getInventoryItem('bandage').count > 0 then
        TriggerClientEvent('wItem:startHealAnimation', source, false)
        xPlayer.removeInventoryItem('bandage', 1)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé un bandage.')
    else
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de bandage.')
    end
end)

ESX.RegisterUsableItem('medikit', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if playerUsingItem[source] then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous êtes déjà en train d\'utiliser un objet!')
        return
    end
    
    if xPlayer.getInventoryItem('medikit').count > 0 then
        TriggerClientEvent('wItem:startHealAnimation', source, true)
        xPlayer.removeInventoryItem('medikit', 1)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé un medikit.')
    else
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de medikit.')
    end
end)