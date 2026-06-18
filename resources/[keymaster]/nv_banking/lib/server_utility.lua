local Core = nil

CreateThread(function()
    Core = GetCore()
end)

function RegisterCallback(callbackName, callbackHandler)
    while not Core do
        Wait(0)
    end
    
    if Config.Framework == "esx" or Config.Framework == "oldesx" then
        Core.RegisterServerCallback(callbackName, function(source, cb, ...)
            callbackHandler(source, cb, ...)
        end)
    else
        Core.Functions.CreateCallback(callbackName, function(source, cb, ...)
            callbackHandler(source, cb, ...)
        end)
    end
end

function GetPlayer(source)
    local player = false
    
    while Core == nil do
        Citizen.Wait(0)
    end
    
    if Config.Framework == "esx" or Config.Framework == "oldesx" then
        player = Core.GetPlayerFromId(source)
    else
        player = Core.Functions.GetPlayer(source)
    end
    
    return player
end

function GetIdentifier(source)
    local player = GetPlayer(source)
    
    if player then
        if Config.Framework == "esx" or Config.Framework == "oldesx" then
            return player.getIdentifier()
        else
            return player.PlayerData.citizenid
        end
    end
end

function ExecuteSql(query, parameters)
    local isWaiting = true
    local result = nil
    
    if Config.MySQL == "oxmysql" then
        if parameters then
            exports.oxmysql:execute(query, parameters, function(data)
                result = data
                isWaiting = false
            end)
        else
            exports.oxmysql:execute(query, function(data)
                result = data
                isWaiting = false
            end)
        end
    elseif Config.MySQL == "ghmattimysql" then
        if parameters then
            exports.ghmattimysql:execute(query, parameters, function(data)
                result = data
                isWaiting = false
            end)
        else
            exports.ghmattimysql:execute(query, {}, function(data)
                result = data
                isWaiting = false
            end)
        end
    elseif Config.MySQL == "mysql-async" then
        if parameters then
            MySQL.Async.fetchAll(query, parameters, function(data)
                result = data
                isWaiting = false
            end)
        else
            MySQL.Async.fetchAll(query, {}, function(data)
                result = data
                isWaiting = false
            end)
        end
    end
    
    while isWaiting do
        Citizen.Wait(0)
    end
    
    return result
end

function GetName(source)
    if Config.Framework == "oldesx" or Config.Framework == "esx" then
        local player = Core.GetPlayerFromId(tonumber(source))
        
        if player then
            return player.getName()
        else
            return "0"
        end
    else
        local player = GetPlayer(tonumber(source))
        
        if player then
            return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    end
end

function GetNameSeparately(nameType, source)
    if Config.Framework == "oldesx" or Config.Framework == "esx" then
        local player = GetPlayer(tonumber(source))
        
        if player then
            if nameType == "firstname" then
                return player.get("firstName") or player.get("firstname")
            else
                return player.get("lastName") or player.get("lastname")
            end
        else
            return "0"
        end
    else
        local player = GetPlayer(tonumber(source))
        
        if player then
            if nameType == "firstname" then
                return player.PlayerData.charinfo.firstname
            else
                return player.PlayerData.charinfo.lastname
            end
        else
            return "0"
        end
    end
end

function GetPlayerMoney(source, accountType)
    if GetResourceState('ox_inventory') ~= 'started' then
        return 0
    end
    
    if accountType == "bank" then
        local player = GetPlayer(source)
        if player and Config.Framework == "esx" or Config.Framework == "oldesx" then
            return player.getAccount("bank").money or 0
        end
        return 0
    end
    
    if accountType == "cash" then
        return exports.ox_inventory:Search(source, 'count', 'money') or 0
    end
    
    return 0
end

function AddMoney(source, accountType, amount)
    if GetResourceState('ox_inventory') ~= 'started' then
        return
    end
    
    if accountType == "bank" then
        local player = GetPlayer(source)
        if player and (Config.Framework == "esx" or Config.Framework == "oldesx") then
            player.addAccountMoney("bank", tonumber(amount))
        end
        return
    end
    
    if accountType == "cash" then
        exports.ox_inventory:AddItem(source, 'money', tonumber(amount))
    end
end

function RemoveMoney(source, accountType, amount)
    if GetResourceState('ox_inventory') ~= 'started' then
        return false
    end
    
    if accountType == "bank" then
        local player = GetPlayer(source)
        if player and (Config.Framework == "esx" or Config.Framework == "oldesx") then
            player.removeAccountMoney("bank", amount)
            return true
        end
        return false
    end
    
    if accountType == "cash" then
        local moneyCount = exports.ox_inventory:Search(source, 'count', 'money') or 0
        if moneyCount >= amount then
            return exports.ox_inventory:RemoveItem(source, 'money', amount)
        end
        return false
    end
    
    return false
end

function GetPlayerSourceByIdentifier(identifier)
    if Config.Framework == "esx" or Config.Framework == "oldesx" then
        return Core.GetPlayerFromIdentifier(identifier)
    else
        local player = Core.Functions.GetPlayerByCitizenId(identifier)
        
        if player then
            return player.PlayerData.source
        else
            return 0
        end
    end
end

function AddBankMoneyOffline(identifier, amount)
    if Config.Framework == "qb" or Config.Framework == "oldqb" or Config.Framework == "qbox" then
        local result = ExecuteSql("SELECT money FROM players WHERE citizenid = '" .. identifier .. "'")
        local money = json.decode(result[1].money)
        money.bank = money.bank + amount
        ExecuteSql("UPDATE players SET money = '" .. json.encode(money) .. "' WHERE citizenid = '" .. identifier .. "'")
    else
        local result = ExecuteSql("SELECT accounts FROM users WHERE identifier = '" .. identifier .. "'")
        local accounts = json.decode(result[1].accounts)
        accounts.bank = accounts.bank + amount
        ExecuteSql("UPDATE users SET accounts = '" .. json.encode(accounts) .. "' WHERE identifier = '" .. identifier .. "'")
    end
end

function GetPlayerMoneyOffline(identifier)
    if Config.Framework == "qb" or Config.Framework == "oldqb" or Config.Framework == "qbox" then
        local result = ExecuteSql("SELECT money FROM players WHERE citizenid = '" .. identifier .. "'")
        local money = json.decode(result[1].money)
        return money.bank
    else
        local result = ExecuteSql("SELECT accounts FROM users WHERE identifier = '" .. identifier .. "'")
        local accounts = json.decode(result[1].accounts)
        return accounts.bank
    end
end

function RemoveBankMoneyOffline(identifier, amount)
    if Config.Framework == "qb" or Config.Framework == "oldqb" or Config.Framework == "qbox" then
        local result = ExecuteSql("SELECT money FROM players WHERE citizenid = '" .. identifier .. "'")
        local money = json.decode(result[1].money)
        money.bank = money.bank - amount
        ExecuteSql("UPDATE players SET money = '" .. json.encode(money) .. "' WHERE citizenid = '" .. identifier .. "'")
    else
        local result = ExecuteSql("SELECT accounts FROM users WHERE identifier = '" .. identifier .. "'")
        local accounts = json.decode(result[1].accounts)
        accounts.bank = accounts.bank - amount
        ExecuteSql("UPDATE users SET accounts = '" .. json.encode(accounts) .. "' WHERE identifier = '" .. identifier .. "'")
    end
end

exports("RegisterCallback", RegisterCallback)
exports("GetPlayer", GetPlayer)
exports("GetIdentifier", GetIdentifier)
exports("ExecuteSql", ExecuteSql)
exports("GetName", GetName)
exports("GetNameSeparately", GetNameSeparately)
exports("GetPlayerMoney", GetPlayerMoney)
exports("AddMoney", AddMoney)
exports("RemoveMoney", RemoveMoney)
exports("GetPlayerSourceByIdentifier", GetPlayerSourceByIdentifier)
exports("AddBankMoneyOffline", AddBankMoneyOffline)
exports("GetPlayerMoneyOffline", GetPlayerMoneyOffline)
exports("RemoveBankMoneyOffline", RemoveBankMoneyOffline)

