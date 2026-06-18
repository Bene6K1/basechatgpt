Config = Config or {}
Config.Detention = Config.Detention or {
    AuthorizedJobs = {
        ['police'] = true,
        ['bcso'] = true,
        ['fbi'] = true
    }
}

MySQL.ready(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS detention_records (
            id INT PRIMARY KEY AUTO_INCREMENT,
            target_id VARCHAR(50),
            officer_name VARCHAR(100),
            reason TEXT,
            prison_name VARCHAR(50),
            time INT,
            release_time TIMESTAMP,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]])
end)

local ActiveDetentions = {}

local CurrentPrisoners = {}

local updateInterval = 60000

local function UpdatePrisonerTime()
    local currentTime = os.time()
    for id, data in pairs(CurrentPrisoners) do
        local timeLeft = data.time - math.floor((currentTime - data.startTime) / 60)
        if timeLeft <= 0 then
            CurrentPrisoners[id] = nil
            TriggerClientEvent('detention:releasePlayer', id)
        end
    end
end

CreateThread(function()
    while true do
        UpdatePrisonerTime()
        Wait(updateInterval)
    end
end)

RegisterNetEvent('detention:putInJail')
AddEventHandler('detention:putInJail', function(targetId, time, reason, prisonName, tsource)
    local _source = tsource or source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(targetId)
    
    if not Config.Detention.AuthorizedJobs[xPlayer.job.name] then return end
    
    time = tonumber(time)
    if not time then return end
    
    local playerName = GetPlayerName(targetId)
    
    CurrentPrisoners[targetId] = {
        name = playerName,
        time = time,
        reason = reason,
        prison = prisonName,
        startTime = os.time()
    }

    TriggerClientEvent('detention:jailPlayer', targetId, time, prisonName, reason)
    
    local releaseTime = os.time() + (tonumber(time) * 60)
    
    MySQL.Async.execute('INSERT INTO detention_records (target_id, officer_name, reason, prison_name, time, release_time) VALUES (?, ?, ?, ?, ?, FROM_UNIXTIME(?))',
    {xTarget.identifier, xPlayer.getName(), reason, prisonName, time, releaseTime})
    
    ActiveDetentions[xTarget.identifier] = {
        time = tonumber(time),
        releaseTime = releaseTime,
        prisonName = prisonName,
        reason = reason
    }
    
    TriggerClientEvent('esx:showNotification', targetId, ('Vous avez été placé en détention pour %s minutes.\nRaison: %s'):format(time, reason))
    
    TriggerClientEvent('detention:jailPlayer', targetId, prisonName, time)
end)

function GetPlayerRPName(xPlayer)
    if not xPlayer then return "Inconnu" end
    local firstName = xPlayer.firstname or ''
    local lastName = xPlayer.lastname or ''
    return firstName, lastName
end

RegisterNetEvent('detention:checkDetention')
AddEventHandler('detention:checkDetention', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    MySQL.Async.fetchAll('SELECT * FROM detention_records WHERE target_id = ? AND release_time > NOW() ORDER BY id DESC LIMIT 1',
    {xPlayer.identifier}, function(result)
        if result[1] then
            local timeLeft = os.difftime(result[1].release_time, os.time())
            if timeLeft > 0 then
                TriggerClientEvent('detention:jailPlayer', _source, result[1].prison_name, math.floor(timeLeft / 60))
            end
        end
    end)
end)

ESX.RegisterServerCallback('detention:getPrisoners', function(source, cb)
    local prisoners = {}
    local currentTime = os.time()
    
    for id, data in pairs(CurrentPrisoners) do
        local timeLeft = data.time - math.floor((currentTime - data.startTime) / 60)
        if timeLeft > 0 then
            prisoners[tostring(id)] = {
                name = data.name,
                timeLeft = timeLeft,
                reason = data.reason,
                prison = data.prison
            }
        else
            CurrentPrisoners[id] = nil
        end
    end

    cb(prisoners)
end)

RegisterNetEvent('detention:releasePlayer')
AddEventHandler('detention:releasePlayer', function(targetId, tsource)
    local _source = tsource or source
    local xPlayer = ESX.GetPlayerFromId(_source)
    print(targetId)
    if not xPlayer then return end
    
    if _source == targetId or Config.Detention.AuthorizedJobs[xPlayer.job.name] then
        local xTarget = ESX.GetPlayerFromId(targetId)
        if xTarget then
            CurrentPrisoners[targetId] = nil
            ActiveDetentions[xTarget.identifier] = nil
            
            MySQL.Async.execute('DELETE FROM detention_records WHERE target_id = ?',
            {xTarget.identifier}, function()
                DebugPrint(string.format("Enregistrement supprimé de la BDD pour %s", GetPlayerName(targetId)))
            end)
            
            TriggerClientEvent('detention:releasePlayer', targetId)
            TriggerClientEvent('esx:showNotification', targetId, 'Vous avez été libéré')
            DebugPrint(string.format("Joueur libéré: %s", GetPlayerName(targetId)))
        end
    end
end)

function DebugPrint(msg)
    if Config.Detention and Config.Detention.Debug then
        print("^3[Detention Debug]^7 " .. msg)
    end
end

RegisterNetEvent('detention:addToJail')
AddEventHandler('detention:addToJail', function(targetId, time, reason, prisonName)
    if not targetId then return end
    
    local playerName = GetPlayerName(targetId)
    
    CurrentPrisoners[targetId] = {
        name = playerName,
        time = time,
        reason = reason,
        prison = prisonName,
        startTime = os.time()
    }
end)
