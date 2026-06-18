ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)


-- removed esx_skin:save handled by [keymaster]/core Skin module

-- removed ui:charCreator:finish legacy handler

-- removed SetBucket legacy handler

ESX.RegisterServerCallback('ZgegFramework:gazstation:removeMoney', function(source, cb, price, method)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney

    if method == "bank" then
        playerMoney = xPlayer.getAccount('bank').money
    elseif method == "cash" then
        playerMoney = xPlayer.getMoney()
    end

    if playerMoney >= price then
        if method == "bank" then
            xPlayer.removeAccountMoney('bank', price)
        elseif method == "cash" then
            xPlayer.removeAccountMoney('cash', price)
        end
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('MakeUP:removeMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    -- Utilisation d'ox_inventory pour retirer du cash
    if exports.ox_inventory:RemoveItem(source, 'money', 50) then
        cb(true)
    else
        cb(false)
    end
end)

