--[[
    =============================================
    NEVA - SYSTEME AFK
    Script Serveur Principal
    =============================================
]]--

local ESX = exports['es_extended']:getSharedObject()

-- =============================================
-- OBJET AFK
-- =============================================
AFK = {
    players = {},       -- Joueurs actuellement AFK: {source -> data}
    leaderboard = {},   -- Cache du leaderboard
    dailyStats = {},    -- Stats journalieres: {UniqueID -> minutes}
}

-- =============================================
-- INITIALISATION DATABASE
-- =============================================
CreateThread(function()
    -- Creer la table si elle n'existe pas
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `afk_stats` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `uniqueid` VARCHAR(50) NOT NULL,
            `identifier` VARCHAR(60) NOT NULL,
            `firstname` VARCHAR(50) DEFAULT '',
            `lastname` VARCHAR(50) DEFAULT '',
            `total_minutes` INT DEFAULT 0,
            `total_earnings` BIGINT DEFAULT 0,
            `sessions_count` INT DEFAULT 0,
            `last_session` DATETIME DEFAULT NULL,
            `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
            `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            UNIQUE KEY `unique_player` (`uniqueid`),
            INDEX `idx_total_minutes` (`total_minutes` DESC)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

    -- Creer la table pour les sessions journalieres
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `afk_daily` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `uniqueid` VARCHAR(50) NOT NULL,
            `date` DATE NOT NULL,
            `minutes` INT DEFAULT 0,
            `earnings` BIGINT DEFAULT 0,
            UNIQUE KEY `unique_daily` (`uniqueid`, `date`),
            INDEX `idx_date` (`date`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

    Wait(1000)
    AFK.LoadLeaderboard()
end)

-- =============================================
-- FONCTIONS UTILITAIRES
-- =============================================

-- Verifier si un joueur est VIP
function AFK.IsVIP(xPlayer)
    if not xPlayer then return false end
    if not Config.AFK.VIP.Enabled then return false end

    -- Utiliser l'export VIP existant
    local hasVip = exports['core']:haveVip(xPlayer.UniqueID)
    return hasVip == true
end

-- Calculer le multiplicateur de recompense
function AFK.GetMultiplier(source)
    local data = AFK.players[source]
    if not data then return 1.0 end

    local multiplier = 1.0
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Multiplicateur VIP
    if AFK.IsVIP(xPlayer) then
        multiplier = multiplier * Config.AFK.VIP.Multiplier
    end

    -- Multiplicateur progressif
    if Config.AFK.Rewards.ProgressiveBonus.Enabled then
        local minutesAFK = math.floor(data.duration / 60)
        for _, bonus in ipairs(Config.AFK.Rewards.ProgressiveBonus.Intervals) do
            if minutesAFK >= bonus.minutes then
                multiplier = multiplier * bonus.multiplier
            end
        end
    end

    return multiplier
end

-- Formater le temps
function AFK.FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60

    if hours > 0 then
        return string.format("%dh %02dm %02ds", hours, minutes, secs)
    elseif minutes > 0 then
        return string.format("%dm %02ds", minutes, secs)
    else
        return string.format("%ds", secs)
    end
end

-- =============================================
-- GESTION DES JOUEURS AFK
-- =============================================

-- Entrer en mode AFK
function AFK.EnterAFK(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false, "Joueur introuvable" end

    -- Verifier si le systeme est active
    if not Config.AFK.Enabled then
        return false, Config.AFK.Messages.SystemDisabled
    end

    -- Verifier si deja AFK
    if AFK.players[source] then
        return false, Config.AFK.Messages.AlreadyAFK
    end

    -- Verifier la limite journaliere
    local dailyMinutes = AFK.GetDailyMinutes(xPlayer.UniqueID)
    local isVIP = AFK.IsVIP(xPlayer)

    if not isVIP and dailyMinutes >= Config.AFK.Rewards.MaxDailyTime then
        return false, Config.AFK.Messages.MaxDailyReached
    end

    -- Sauvegarder les donnees du joueur
    local playerPed = GetPlayerPed(source)
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    AFK.players[source] = {
        uniqueid = xPlayer.UniqueID,
        identifier = xPlayer.identifier,
        firstname = xPlayer.get('firstName') or '',
        lastname = xPlayer.get('lastName') or '',
        startTime = os.time(),
        duration = 0,
        earnings = 0,
        isVIP = isVIP,
        lastReward = os.time(),
        lastPosition = {
            x = coords.x,
            y = coords.y,
            z = coords.z,
            h = heading
        },
        originalBucket = GetPlayerRoutingBucket(source)
    }

    -- Teleporter dans le bucket AFK
    if Config.AFK.Zone.UseBucket then
        local bucketId = Config.AFK.Zone.UseUniqueBucket and (10000 + source) or Config.AFK.Zone.BucketId
        SetPlayerRoutingBucket(source, bucketId)
    end

    -- Donner le bonus de connexion VIP
    if isVIP and Config.AFK.VIP.ExclusiveBonuses.ConnectionBonus > 0 then
        local bonus = Config.AFK.VIP.ExclusiveBonuses.ConnectionBonus
        xPlayer.addAccountMoney(Config.AFK.Rewards.AccountType, bonus)
        AFK.players[source].earnings = bonus
        TriggerClientEvent('esx:showNotification', source, string.format("~p~VIP~w~ | Bonus de connexion: ~g~+$%s", bonus))
    end

    -- Log
    AFK.Log(source, 'enter', {
        isVIP = isVIP,
        position = AFK.players[source].lastPosition
    })

    return true, Config.AFK.Messages.EnterAFK
end

-- Quitter le mode AFK
function AFK.LeaveAFK(source, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = AFK.players[source]

    if not data then
        return false, Config.AFK.Messages.NotAFK
    end

    -- Calculer la duree finale
    data.duration = os.time() - data.startTime

    -- Sauvegarder les stats
    AFK.SaveStats(source)

    -- Retour au bucket original
    if Config.AFK.Zone.UseBucket then
        SetPlayerRoutingBucket(source, data.originalBucket or 0)
    end

    -- Message de fin
    local message = string.format(Config.AFK.Messages.LeaveAFK, AFK.FormatMoney(data.earnings))

    -- Log
    AFK.Log(source, 'leave', {
        duration = data.duration,
        earnings = data.earnings,
        reason = reason or 'manual'
    })

    -- Nettoyer
    AFK.players[source] = nil

    -- Rafraichir le leaderboard (seulement si nécessaire)
    CreateThread(function()
        Wait(2000) -- Attendre un peu avant de rafraîchir
        AFK.LoadLeaderboard()
    end)

    return true, message
end

-- =============================================
-- SYSTEME DE RECOMPENSES
-- =============================================

-- Thread principal de recompenses
CreateThread(function()
    while true do
        Wait(Config.AFK.Rewards.Interval * 1000)

        if Config.AFK.Rewards.Enabled then
            for source, data in pairs(AFK.players) do
                local xPlayer = ESX.GetPlayerFromId(source)
                if xPlayer then
                    -- Mettre a jour la duree
                    data.duration = os.time() - data.startTime
                    local minutesAFK = math.floor(data.duration / 60)

                    -- Verifier la limite de session (sauf VIP si NoTimeLimit)
                    local isVIP = AFK.IsVIP(xPlayer)
                    if not isVIP or not Config.AFK.VIP.ExclusiveBonuses.NoTimeLimit then
                        if minutesAFK >= Config.AFK.Rewards.MaxSessionTime then
                            AFK.LeaveAFK(source, 'session_limit')
                            TriggerClientEvent('neva:afk:forceLeave', source, Config.AFK.Messages.MaxSessionReached:format(Config.AFK.Rewards.MaxSessionTime / 60))
                            goto continue
                        end
                    end

                    -- Verifier la limite journaliere (sauf VIP)
                    if not isVIP then
                        local dailyMinutes = AFK.GetDailyMinutes(data.uniqueid)
                        if dailyMinutes >= Config.AFK.Rewards.MaxDailyTime then
                            AFK.LeaveAFK(source, 'daily_limit')
                            TriggerClientEvent('neva:afk:forceLeave', source, Config.AFK.Messages.MaxDailyReached)
                            goto continue
                        end
                    end

                    -- Calculer la recompense
                    local multiplier = AFK.GetMultiplier(source)
                    local reward = math.floor(Config.AFK.Rewards.BaseAmount * multiplier)

                    -- Donner la recompense
                    xPlayer.addAccountMoney(Config.AFK.Rewards.AccountType, reward)
                    data.earnings = data.earnings + reward
                    data.lastReward = os.time()

                    -- Notification
                    local notifMessage = isVIP
                        and string.format(Config.AFK.Messages.VIPRewardReceived, reward)
                        or string.format(Config.AFK.Messages.RewardReceived, reward)

                    TriggerClientEvent('esx:showNotification', source, notifMessage)

                    -- Envoyer les stats au client pour l'overlay
                    TriggerClientEvent('neva:afk:updateStats', source, {
                        duration = data.duration,
                        earnings = data.earnings,
                        multiplier = multiplier,
                        isVIP = isVIP,
                        nextReward = Config.AFK.Rewards.Interval
                    })
                end
                ::continue::
            end
        end
    end
end)

-- =============================================
-- SAUVEGARDE DES STATS
-- =============================================

function AFK.SaveStats(source)
    local data = AFK.players[source]
    if not data then return end

    local minutesAFK = math.floor(data.duration / 60)
    local today = os.date('%Y-%m-%d')

    -- Mettre a jour les stats globales
    MySQL.update([[
        INSERT INTO afk_stats (uniqueid, identifier, firstname, lastname, total_minutes, total_earnings, sessions_count, last_session)
        VALUES (?, ?, ?, ?, ?, ?, 1, NOW())
        ON DUPLICATE KEY UPDATE
            firstname = VALUES(firstname),
            lastname = VALUES(lastname),
            total_minutes = total_minutes + VALUES(total_minutes),
            total_earnings = total_earnings + VALUES(total_earnings),
            sessions_count = sessions_count + 1,
            last_session = NOW()
    ]], {data.uniqueid, data.identifier, data.firstname, data.lastname, minutesAFK, data.earnings})

    -- Mettre a jour les stats journalieres
    MySQL.update([[
        INSERT INTO afk_daily (uniqueid, date, minutes, earnings)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
            minutes = minutes + VALUES(minutes),
            earnings = earnings + VALUES(earnings)
    ]], {data.uniqueid, today, minutesAFK, data.earnings})
end

-- Recuperer les minutes AFK du jour
function AFK.GetDailyMinutes(uniqueid)
    local today = os.date('%Y-%m-%d')
    local result = MySQL.scalar.await([[
        SELECT minutes FROM afk_daily WHERE uniqueid = ? AND date = ?
    ]], {uniqueid, today})

    return result or 0
end

-- =============================================
-- LEADERBOARD
-- =============================================

function AFK.LoadLeaderboard()
    local limit = 10
    if Config.AFK and Config.AFK.Leaderboard and Config.AFK.Leaderboard.TopPlayers then
        limit = Config.AFK.Leaderboard.TopPlayers
    end
    
    local result = MySQL.query.await([[
        SELECT uniqueid, firstname, lastname, total_minutes, total_earnings
        FROM afk_stats
        WHERE total_minutes > 0
        ORDER BY total_minutes DESC
        LIMIT ?
    ]], {limit})

    AFK.leaderboard = result or {}
end

function AFK.GetLeaderboard()
    local leaderboard = {}
    
    if not AFK.leaderboard or #AFK.leaderboard == 0 then
        AFK.LoadLeaderboard()
    end
    
    for i, player in ipairs(AFK.leaderboard) do
        leaderboard[i] = {
            uniqueid = player.uniqueid or '',
            firstname = player.firstname or '',
            lastname = player.lastname or '',
            total_minutes = tonumber(player.total_minutes) or 0,
            total_earnings = tonumber(player.total_earnings) or 0
        }
    end
    
    return leaderboard
end

-- Rafraichir le leaderboard periodiquement
CreateThread(function()
    while true do
        local refreshInterval = 300 -- 5 minutes par défaut
        if Config.AFK and Config.AFK.Leaderboard and Config.AFK.Leaderboard.RefreshInterval then
            refreshInterval = Config.AFK.Leaderboard.RefreshInterval
        end
        Wait(refreshInterval * 1000)
        AFK.LoadLeaderboard()
    end
end)

-- =============================================
-- LOGGING
-- =============================================

function AFK.Log(source, action, data)
    if not Config.AFK.Security.Logging.Enabled then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local logMessage = string.format("[AFK] %s (%s) - Action: %s",
        xPlayer.getName(),
        xPlayer.identifier,
        action
    )

    if data then
        for k, v in pairs(data) do
            logMessage = logMessage .. string.format(" | %s: %s", k, tostring(v))
        end
    end

    if Config.AFK.Security.Logging.WebhookURL and Config.AFK.Security.Logging.WebhookURL ~= '' then
    end
end

-- =============================================
-- FORMATTAGE
-- =============================================

function AFK.FormatMoney(amount)
    local formatted = tostring(amount)
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

-- =============================================
-- EVENTS
-- =============================================

-- Entrer en mode AFK
RegisterNetEvent('neva:afk:enter', function()
    local source = source
    local success, message = AFK.EnterAFK(source)

    if success then
        TriggerClientEvent('neva:afk:enterSuccess', source, AFK.players[source])
    end

    TriggerClientEvent('esx:showNotification', source, message)
end)

-- Quitter le mode AFK
RegisterNetEvent('neva:afk:leave', function()
    local source = source
    local success, message = AFK.LeaveAFK(source, 'manual')

    if success then
        TriggerClientEvent('neva:afk:leaveSuccess', source)
    end

    TriggerClientEvent('esx:showNotification', source, message)
end)

-- Demander les stats pour l'overlay
RegisterNetEvent('neva:afk:requestStats', function()
    local source = source
    local data = AFK.players[source]

    if data then
        data.duration = os.time() - data.startTime
        TriggerClientEvent('neva:afk:updateStats', source, {
            duration = data.duration,
            earnings = data.earnings,
            multiplier = AFK.GetMultiplier(source),
            isVIP = data.isVIP,
            nextReward = Config.AFK.Rewards.Interval - ((os.time() - data.lastReward) % Config.AFK.Rewards.Interval)
        })
    end
end)

RegisterNetEvent('neva:afk:requestLeaderboard', function()
    local source = source
    local leaderboard = AFK.GetLeaderboard()
    TriggerClientEvent('neva:afk:receiveLeaderboard', source, leaderboard)
end)

-- Callback pour les stats personnelles
ESX.RegisterServerCallback('neva:afk:getPersonalStats', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(nil) end

    local stats = MySQL.query.await([[
        SELECT total_minutes, total_earnings, sessions_count, last_session
        FROM afk_stats
        WHERE uniqueid = ?
    ]], {xPlayer.UniqueID})

    cb(stats and stats[1] or nil)
end)

-- Callback pour verifier si AFK
ESX.RegisterServerCallback('neva:afk:isAFK', function(source, cb)
    cb(AFK.players[source] ~= nil)
end)

-- =============================================
-- NETTOYAGE A LA DECONNEXION
-- =============================================

AddEventHandler('playerDropped', function()
    local source = source
    if AFK.players[source] then
        AFK.LeaveAFK(source, 'disconnect')
    end
end)

-- =============================================
-- COMMANDES
-- =============================================

-- Commande pour entrer en AFK
RegisterCommand(Config.AFK.Commands.Enter, function(source)
    TriggerEvent('neva:afk:enter')
end, false)

-- Commande pour quitter l'AFK
RegisterCommand(Config.AFK.Commands.Leave, function(source)
    TriggerEvent('neva:afk:leave')
end, false)

-- Commande leaderboard
RegisterCommand(Config.AFK.Commands.Leaderboard, function(source)
    TriggerClientEvent('neva:afk:showLeaderboard', source, AFK.GetLeaderboard())
end, false)

-- =============================================
-- EXPORTS
-- =============================================

exports('isPlayerAFK', function(source)
    return AFK.players[source] ~= nil
end)

exports('getAFKData', function(source)
    return AFK.players[source]
end)

exports('getAFKLeaderboard', function()
    return AFK.GetLeaderboard()
end)

exports('forceEnterAFK', function(source)
    return AFK.EnterAFK(source)
end)

exports('forceLeaveAFK', function(source, reason)
    return AFK.LeaveAFK(source, reason)
end)
