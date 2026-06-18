local isRolling = false
local COOLDOWN_SECONDS = 86400 -- 24 heures

local rewards = {
    [1]  = { type = "food" },
    [2]  = { type = "food" },
    [3]  = { type = "money", amount = 20000 },
    [4]  = { type = "black_money", amount = 10000 },
    [5]  = { type = "money", amount = 300000 },
    [6]  = { type = "food" },
    [7]  = { type = "money", amount = 30000 },
    [8]  = { type = "black_money", amount = 15000 },
    [9]  = { type = "food" },
    [10] = { type = "food" },
    [11] = { type = "black_money", amount = 20000 },
    [12] = { type = "weapon", weapon = "weapon_knife" },
    [13] = { type = "food" },
    [14] = { type = "food" },
    [15] = { type = "money", amount = 40000 },
    [16] = { type = "black_money", amount = 25000 },
    [17] = { type = "food" },
    [18] = { type = "food" },
    [19] = { type = "car" },
    [20] = { type = "money", amount = 50000 }
}

local function getRandomPrizeIndex()
    local roll = math.random(1, 100)

    if roll == 1 then
        -- 1% chance voiture (avec sous-chance 0.1%)
        if math.random(1, 1000) == 1 then
            return 19
        end
        return 3
    elseif roll <= 6 then
        -- 5% chance arme
        if math.random(1, 20) <= 2 then
            return 12
        end
        return 7
    elseif roll <= 15 then
        -- 9% black money
        local options = { 4, 8, 11, 16 }
        return options[math.random(1, 4)]
    elseif roll <= 25 then
        -- 10% gros gain ou petit gain
        if math.random(1, 20) <= 2 then
            return 5
        end
        return 20
    elseif roll <= 40 then
        -- 15% food
        local options = { 1, 9, 13, 17 }
        return options[math.random(1, 4)]
    elseif roll <= 60 then
        -- 20% food
        local options = { 2, 6, 10, 14, 18 }
        return options[math.random(1, 5)]
    else
        -- 40% petits gains money
        local options = { 3, 7, 15, 20 }
        return options[math.random(1, 4)]
    end
end

local function giveReward(xPlayer, prizeIndex)
    local reward = rewards[prizeIndex]
    if not reward then return end

    if reward.type == "food" then
        xPlayer.addInventoryItem("bread", 10)
        xPlayer.addInventoryItem("water", 24)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez gagné du pain et de l'eau")

    elseif reward.type == "money" then
        xPlayer.addAccountMoney('cash', reward.amount)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez gagné " .. reward.amount .. "$")

    elseif reward.type == "black_money" then
        xPlayer.addAccountMoney('black_money', reward.amount * 10)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez gagné de l'argent sale")

    elseif reward.type == "weapon" then
        xPlayer.addWeapon(reward.weapon, 255)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez gagné un couteau")

    elseif reward.type == "car" then
        TriggerClientEvent("casino:wheel:winCar", xPlayer.source)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez gagné la voiture!")
    end
end

local function formatTimeRemaining(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    return string.format("%dh %dmin", hours, minutes)
end

RegisterServerEvent('casino:wheel:spin')
AddEventHandler('casino:wheel:spin', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if isRolling then
        TriggerClientEvent('esx:showNotification', source, "Quelqu'un est déjà en train de tourner la roue")
        return
    end

    local UniqueID = xPlayer.UniqueID

    -- Vérifier le cooldown en DB
    MySQL.Async.fetchScalar('SELECT last_wheel_spin FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = UniqueID
    }, function(lastSpin)
        local currentTime = os.time()
        lastSpin = lastSpin or 0

        local timeSinceLastSpin = currentTime - lastSpin

        if timeSinceLastSpin < COOLDOWN_SECONDS then
            local remaining = COOLDOWN_SECONDS - timeSinceLastSpin
            TriggerClientEvent('esx:showNotification', source, "Vous devez attendre " .. formatTimeRemaining(remaining) .. " avant de rejouer")
            TriggerClientEvent('casino:wheel:denied', source)
            return
        end

        -- Marquer comme en cours
        isRolling = true

        -- Déterminer le prix
        local prizeIndex = getRandomPrizeIndex()

        -- Mettre à jour le timestamp en DB
        MySQL.Async.execute('UPDATE users SET last_wheel_spin = @time WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = UniqueID,
            ['@time'] = currentTime
        })

        -- Lancer l'animation pour tous les clients
        TriggerClientEvent('casino:wheel:doRoll', -1, prizeIndex)

        -- Donner la récompense après l'animation (12 secondes)
        SetTimeout(12000, function()
            isRolling = false
            giveReward(xPlayer, prizeIndex)
            TriggerClientEvent('casino:wheel:finished', -1)
        end)
    end)
end)

-- Vérifier le cooldown (pour afficher le temps restant côté client)
RegisterServerEvent('casino:wheel:checkCooldown')
AddEventHandler('casino:wheel:checkCooldown', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    MySQL.Async.fetchScalar('SELECT last_wheel_spin FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = xPlayer.UniqueID
    }, function(lastSpin)
        local currentTime = os.time()
        lastSpin = lastSpin or 0
        local remaining = COOLDOWN_SECONDS - (currentTime - lastSpin)

        if remaining > 0 then
            TriggerClientEvent('casino:wheel:cooldownInfo', source, remaining)
        else
            TriggerClientEvent('casino:wheel:cooldownInfo', source, 0)
        end
    end)
end)
