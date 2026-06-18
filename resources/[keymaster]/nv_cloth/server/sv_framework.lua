if Config.Framework == 'esx' then
    ESX = exports.es_extended:getSharedObject()
elseif Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

function getAccountMoney(source, account)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return end
        if account == 'money' then
            return xPlayer.getMoney()
        else
            local acc = xPlayer.getAccount(account)
            return acc and acc.money or 0
        end
    elseif Config.Framework == 'qbcore' then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        return Player.PlayerData.money[account] or 0
    else
    end    
end

function removeAccountMoney(source, account, amount)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return end
        if account == 'money' then
            xPlayer.removeAccountMoney('cash', amount)
        else
            xPlayer.removeAccountMoney(account, amount)
        end
    elseif Config.Framework == 'qbcore' then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        local acc = account == 'money' and 'cash' or account
        Player.Functions.RemoveMoney(acc, amount)
    else
    end    
end

function sendNotification(source, message)
    if Config.Framework == 'esx' then
        TriggerClientEvent('esx:showNotification', source, message)
    elseif Config.Framework == 'qbcore' then
        TriggerClientEvent('QBCore:Notify', source, message)
    else
    end    
end

function getPlayerIdentifier(source)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return end
        return xPlayer.identifier
    elseif Config.Framework == 'qbcore' then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        return Player.PlayerData.citizenid
    end    
end 

RegisterServerEvent('nvCloth:save')
AddEventHandler('nvCloth:save', function(appearance)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.update('UPDATE users SET skin = ? WHERE identifier = ?', {json.encode(appearance), xPlayer.identifier})
end)