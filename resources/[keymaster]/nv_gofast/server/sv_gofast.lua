local Framework = nil
local playerCooldowns = {}
local notifiedJobs = {}
local activeMissions = {}

function InitializeFramework()
    if Config.Framework.Type == "esx" then
        Framework = exports[Config.Framework.ResourceName]:getSharedObject()
    elseif Config.Framework.Type == "qbcore" then
        Framework = exports[Config.Framework.ResourceName]:GetCoreObject()
    else
        Framework = {}
    end
end

CreateThread(function()
    Wait(1000)
    InitializeFramework()
    
    if Config.GoFast.LawEnforcement then
        if Config.GoFast.LawEnforcement.NotifiedJobs then
            for i = 1, #Config.GoFast.LawEnforcement.NotifiedJobs do
                local jobName = Config.GoFast.LawEnforcement.NotifiedJobs[i]
                notifiedJobs[jobName] = true
            end
        end
    end
end)

local missionManager = {
    players = {},
    vehicles = {}
}

function GenerateUniqueId()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, 8 do
        local randomIndex = math.random(1, #chars)
        result = result .. chars:sub(randomIndex, randomIndex)
    end
    return result
end

function GetLocaleString(key, ...)
    local locale = Locales[Config.Locale]
    if not locale then
        print("^1[ERROR] Locale '" .. Config.Locale .. "' does not exist, defaulting to 'en'^0")
        Config.Locale = "en"
    end
    
    local localeString = Locales[Config.Locale][key]
    if not localeString then
        print("^3[WARNING] String '" .. key .. "' not found in " .. Config.Locale .. " locale^0")
        return key
    end
    
    local argCount = select("#", ...)
    if argCount == 0 then
        return localeString
    else
        return string.format(localeString, ...)
    end
end

function CheckPlayerCooldown(playerId)
    local player = Framework.GetPlayerFromId(playerId)
    if not player then
        return false
    end
    
    local lastMission = missionManager.players[player.identifier]
    if lastMission then
        local timeSinceLastMission = os.time() - lastMission
        if timeSinceLastMission < Config.GoFast.Cooldown then
            TriggerClientEvent("esx:showNotification", playerId, GetLocaleString("notification_cooldown"))
            return false
        end
    end
    
    return true
end

function GetPlayerItemCount(player, itemName)
    local item = player.getInventoryItem(itemName)
    if item and item.count then
        return item.count
    end
    return 0
end

function FindPlayerVehicle(playerId)
    for vehicleId, vehicleData in pairs(missionManager.vehicles) do
        if vehicleData.player == playerId then
            return vehicleData, vehicleId
        end
    end
    return nil, nil
end

function NotifyLawEnforcement(vehicleInfo, location)
    local players = Framework.GetPlayers()
    for i = 1, #players do
        local playerId = players[i]
        local player = Framework.GetPlayerFromId(playerId)
        if player then
            local jobName = player.job.name
            if notifiedJobs[jobName] then
                TriggerClientEvent("nevaaagofast:notifyPolice", playerId, {
                    model = vehicleInfo.model,
                    plate = vehicleInfo.plate,
                    location = location
                })
                break
            end
        end
    end
end

RegisterNetEvent("nevaaagofast:checkItemServer")
AddEventHandler("nevaaagofast:checkItemServer", function(itemName)
    local source = source
    
    if not Config.GoFast.Items.Required then
        TriggerClientEvent("nevaaagofast:itemCheckResult", source, true)
        return
    end
    
    local hasItem = Config.Framework.Inventory.GetItem(source, itemName)
    local hasValidAmount = false
    
    if hasItem and hasItem.count and hasItem.count > 0 then
        hasValidAmount = true
    end
    
    TriggerClientEvent("nevaaagofast:itemCheckResult", source, hasValidAmount)
end)


local function FindDeliveryPointByDistance(spawnPoint, minDistance, maxDistance)
    local validPoints = {}
    
    for _, sellPoint in ipairs(Config.GoFast.SellPoints) do
        local distance = #(vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z) - sellPoint)
        if distance >= minDistance and distance <= maxDistance then
            table.insert(validPoints, {point = sellPoint, distance = distance})
        end
    end
    
    if #validPoints == 0 then
        local fallbackPoints = {}
        
        for _, sellPoint in ipairs(Config.GoFast.SellPoints) do
            local distance = #(vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z) - sellPoint)
            if distance >= minDistance then
                table.insert(fallbackPoints, {point = sellPoint, distance = distance})
            end
        end
        
        if #fallbackPoints > 0 then
            table.sort(fallbackPoints, function(a, b) return a.distance < b.distance end)
            return fallbackPoints[1].point
        end
        
        return Config.GoFast.SellPoints[math.random(#Config.GoFast.SellPoints)]
    end
    
    return validPoints[math.random(#validPoints)].point
end

RegisterServerEvent("nevaaagofast:requestStart")
AddEventHandler("nevaaagofast:requestStart", function(difficulty)
    local source = source
    local playerIdentifier = GetPlayerIdentifier(source, 0)
    local currentTime = os.time()
    
    difficulty = difficulty or "medium"
    local difficultyConfig = Config.GoFast.Difficulty[difficulty]
    
    if not difficultyConfig then
        difficulty = "medium"
        difficultyConfig = Config.GoFast.Difficulty[difficulty]
    end
    
    if playerCooldowns[playerIdentifier] then
        if currentTime < playerCooldowns[playerIdentifier] then
            local remainingTime = playerCooldowns[playerIdentifier] - currentTime
            local hours = math.floor(remainingTime / 3600)
            local minutes = math.floor((remainingTime % 3600) / 60)
            
            Config.Framework.Notification.Show(source, 
                "Vous avez déjà fait un GoFast récemment. Attendez encore " .. hours .. "h " .. minutes .. "m.", 
                "error")
            return
        end
    end
    
    local spawnPoint = Config.GoFast.SpawnPoints[math.random(#Config.GoFast.SpawnPoints)]
    
    local deliveryPoint = FindDeliveryPointByDistance(
        spawnPoint, 
        difficultyConfig.distance.min, 
        difficultyConfig.distance.max
    )
    
    local vehicleModel = difficultyConfig.vehicles[math.random(#difficultyConfig.vehicles)]
    
    local shouldNotifyPolice = false
    if Config.GoFast.LawEnforcement.Notify then
        shouldNotifyPolice = math.random(100) <= difficultyConfig.policeNotificationChance
    end
    
    local lawEnforcementCount = 0
    for jobName, _ in pairs(Config.GoFast.LawEnforcement.NotifiedJobs) do
        lawEnforcementCount = lawEnforcementCount + Config.Framework.JobCount(jobName)
    end
    
    if lawEnforcementCount < Config.GoFast.LawEnforcement.MinPlayers then
        shouldNotifyPolice = false
    end
    
    local selectedItem = Config.GoFast.Items.Possibilities[math.random(#Config.GoFast.Items.Possibilities)]
    local itemAmount = math.random(selectedItem.minAmount, selectedItem.maxAmount)
    
    activeMissions[source] = difficulty
    
    playerCooldowns[playerIdentifier] = currentTime + Config.GoFast.Mission.Cooldown
    
    TriggerClientEvent("nevaaagofast:startMission", source, {
        vehicle = vehicleModel,
        spawnPoint = spawnPoint,
        deliveryPoint = deliveryPoint,
        notifyPolice = shouldNotifyPolice,
        notificationDelay = math.random(
            Config.GoFast.LawEnforcement.NotificationDelay.Min,
            Config.GoFast.LawEnforcement.NotificationDelay.Max
        ),
        difficulty = difficulty,
        item = {
            name = selectedItem.name,
            label = selectedItem.label,
            amount = itemAmount
        }
    })
end)

RegisterServerEvent("nevaaagofast:notifyLawEnforcement")
AddEventHandler("nevaaagofast:notifyLawEnforcement", function(vehicleInfo)
    local notificationMessage = string.format(
        "~r~[ALERTE GO FAST]~s~\n~b~Véhicule:~s~ %s\n~b~Plaque:~s~ %s\n~w~Un véhicule suspect effectue un Go Fast !",
        vehicleInfo.model or "Inconnu",
        vehicleInfo.plate or "Inconnue"
    )
    
    for _, jobName in pairs(Config.GoFast.LawEnforcement.NotifiedJobs) do
        if Config.Framework.Type == "esx" then
            local players = Framework.GetExtendedPlayers("job", jobName)
            for _, player in pairs(players) do
                TriggerClientEvent("nevaaagofast:createBlip", player.source, vehicleInfo)
                TriggerClientEvent("esx:showNotification", player.source, notificationMessage)
            end
        elseif Config.Framework.Type == "qbcore" then
            local players = Framework.Functions.GetQBPlayers()
            for _, player in pairs(players) do
                if player.PlayerData.job.name == jobName then
                    TriggerClientEvent("nevaaagofast:createBlip", player.PlayerData.source, vehicleInfo)
                    Config.Framework.Notification.Show(player.PlayerData.source, 
                        string.format("[ALERTE GO FAST] Véhicule: %s | Plaque: %s", 
                        vehicleInfo.model or "Inconnu", 
                        vehicleInfo.plate or "Inconnue"), 
                        "error", 10000)
                end
            end
        end
    end
end)


RegisterServerEvent("nevaaagofast:checkItem")
AddEventHandler("nevaaagofast:checkItem", function(itemName)
    local source = source
    
    if not Config.GoFast.Items.Required then
        TriggerClientEvent("nevaaagofast:itemCheckResult", source, true)
        return
    end
    
    local hasItem = Config.Framework.Inventory.GetItem(source, itemName)
    local hasValidAmount = false
    
    if hasItem and hasItem.count and hasItem.count > 0 then
        hasValidAmount = true
    end
    
    TriggerClientEvent("nevaaagofast:itemCheckResult", source, hasValidAmount)
end)

RegisterServerEvent("nevaaagofast:setMissionDifficulty")
AddEventHandler("nevaaagofast:setMissionDifficulty", function(difficulty)
    local source = source
    activeMissions[source] = difficulty
end)

RegisterServerEvent("nevaaagofast:completeDelivery")
AddEventHandler("nevaaagofast:completeDelivery", function()
    local source = source
    local difficulty = activeMissions[source] or "medium"
    local difficultyConfig = Config.GoFast.Difficulty[difficulty]
    
    if Config.GoFast.Items.Required then
        local hasRequiredItems = false
        
        for _, requiredItem in pairs(Config.GoFast.Items.Possibilities) do
            local item = Config.Framework.Inventory.GetItem(source, requiredItem.name)
            if item and item.count and item.count >= requiredItem.minAmount then
                hasRequiredItems = true
                Config.Framework.Inventory.RemoveItem(source, requiredItem.name, item.count)
                break
            end
        end
        
        if not hasRequiredItems then
            Config.Framework.Notification.Show(source, 
                "Vous n'avez pas les marchandises requises pour cette livraison.", "error")
            return
        end
    end
    
    local moneyReward = math.random(difficultyConfig.money.min, difficultyConfig.money.max)
    Config.Framework.Money.Add(source, moneyReward, Config.GoFast.Reward.Money.Type)
    
    if Config.GoFast.Reward.Items.Enabled and difficultyConfig.items then
        for _, item in pairs(Config.GoFast.Reward.Items.Possibilities) do
            if math.random(100) <= difficultyConfig.items.chance then
                local amount = math.random(difficultyConfig.items.min, difficultyConfig.items.max)
                Config.Framework.Inventory.AddItem(source, item.name, amount)
                Config.Framework.Notification.Show(source, 
                    "Bonus reçu : " .. amount .. "x " .. item.label, "info")
            end
        end
    end
    
    Config.Framework.Notification.Show(source, 
        "Paiement reçu : " .. moneyReward .. "$ (Difficulté: " .. difficultyConfig.label .. ")", "success")
    
    activeMissions[source] = nil
end)

AddEventHandler("playerDropped", function()
    local source = source
    local playerIdentifier = GetPlayerIdentifier(source, 0)
    
    if activeMissions[source] then
        activeMissions[source] = nil
    end
end)

RegisterCommand("resetgofastcooldown", function(source, args)
    local isAdmin = false
    
    if Config.Framework.Type == "esx" then
        local player = Framework.GetPlayerFromId(source)
        local group = player.getGroup()
        isAdmin = (group == "admin" or group == "superadmin")
    elseif Config.Framework.Type == "qbcore" then
        local player = Framework.Functions.GetPlayer(source)
        local permission = player.PlayerData.permission
        isAdmin = (permission == "admin" or permission == "god")
    elseif source == 0 then
        isAdmin = true
    end
    
    if not isAdmin then
        Config.Framework.Notification.Show(source, 
            "Vous n'avez pas la permission d'utiliser cette commande.", "error")
        return
    end
    
    local targetId = tonumber(args[1]) or source
    local targetIdentifier = GetPlayerIdentifier(targetId, 0)
    
    if not targetIdentifier then
        Config.Framework.Notification.Show(source, "Joueur introuvable.", "error")
        return
    end
    
    playerCooldowns[targetIdentifier] = nil
    Config.Framework.Notification.Show(source, "Cooldown GoFast réinitialisé pour ID " .. targetId, "success")
    
    if source ~= targetId then
        Config.Framework.Notification.Show(targetId, 
            "Votre cooldown GoFast a été réinitialisé par un admin.", "info")
    end
end, false)