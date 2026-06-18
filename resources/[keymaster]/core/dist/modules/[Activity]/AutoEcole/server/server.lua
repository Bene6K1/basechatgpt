local playersInExam = {}
local lastTransactionTime = {}

ESX.RegisterServerCallback('rx:tryBuyLicense', function(source, cb, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local currentTime = os.time()

    -- 0. Protection Cooldown (3 secondes)
    -- On utilise un tableau local pour stocker le dernier temps de transaction par joueur
    if lastTransactionTime[_source] and (currentTime - lastTransactionTime[_source] < 3) then
        print(("[AutoEcole] Transaction bloquée pour cooldown (Source: %s)"):format(_source))
        cb(false, "cooldown")
        return
    end

    -- 1. Protection État Joueur
    if playersInExam[_source] then
        cb(false, "already_in_exam")
        return
    end

    -- 2. Paiement
    if xPlayer.getMoney() >= price then
        -- Verrouillage de l'état
        playersInExam[_source] = true
        lastTransactionTime[_source] = currentTime
        
        xPlayer.removeAccountMoney('cash', price)
        TriggerClientEvent('esx:showNotification', _source, ("[~g~Succès~s~] Vous avez payé ~g~%s$~s~."):format(price))
        
        -- Succès
        cb(true, "success")
        
        -- Libération automatique de l'état après 10s (sécurité)
        SetTimeout(10000, function()
            playersInExam[_source] = false
        end)
    else
        cb(false, "no_money")
    end
end)

RegisterNetEvent("rx:addLicense")
AddEventHandler("rx:addLicense", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {
        ['@type'] = type,
        ['@owner'] = xPlayer.identifier
    })
    
    playersInExam[source] = false
end)

ESX.RegisterServerCallback('rx:checkLicense', function(source, cb, target, type)
    CheckLicense(target, type, cb)
end)

function CheckLicense(target, type, cb)
    local identifier = ESX.GetPlayerFromId(target).identifier
    
    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type']  = type,
        ['@owner'] = identifier
    }, function(result)
        if tonumber(result[1].count) > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end

AddEventHandler('playerDropped', function()
    local _source = source
    playersInExam[_source] = nil
    lastTransactionTime[_source] = nil
end)