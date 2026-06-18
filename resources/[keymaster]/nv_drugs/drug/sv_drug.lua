
local ESX = nil

if Config and Config.ESXMode == "old" then
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
else
    ESX = exports.es_extended:getSharedObject()
end


local CachedPoliceCount = 0
local PoliceCountUpdateInterval = 60000


function GetPoliceCount()
    local count = 0
    local players = ESX.GetPlayers()

    for i = 1, #players do
        local xPlayer = ESX.GetPlayerFromId(players[i])

        if xPlayer and xPlayer.job.name == "police" then
            count = count + 1
        end
    end

    return count
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(PoliceCountUpdateInterval)
        CachedPoliceCount = GetPoliceCount()
    end
end)

function GetCachedPoliceCount()
    return CachedPoliceCount
end


ESX.RegisterServerCallback("cDrugs:getPlayerCrew", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        MySQL.Async.fetchScalar("SELECT id_crew FROM crew_membres WHERE identifier = ?",
            {xPlayer.identifier},
            function(crewId)
                if crewId then
                    cb(tonumber(crewId))
                else
                    cb(nil)
                end
            end
        )
    else
        cb(nil)
    end
end)


function GetOnlineCrewMembers(crewId, callback)
    local players = ESX.GetPlayers()
    local crewMembers = {}
    local totalPlayers = #players
    local processedCount = 0

    if totalPlayers == 0 then
        callback(crewMembers)
        return
    end

    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)

        if xPlayer then
            MySQL.Async.fetchScalar("SELECT id_crew FROM crew_membres WHERE identifier = ?",
                {xPlayer.identifier},
                function(playerCrewId)
                    if playerCrewId and tonumber(playerCrewId) == tonumber(crewId) then
                        table.insert(crewMembers, xPlayer.source)
                    end

                    processedCount = processedCount + 1

                    if processedCount == totalPlayers then
                        callback(crewMembers)
                    end
                end
            )
        else
            processedCount = processedCount + 1

            if processedCount == totalPlayers then
                callback(crewMembers)
            end
        end
    end
end


function CheckAndSendAlert(crewId, territoryName)
    MySQL.Async.fetchAll(
        "SELECT id_crew FROM territoires WHERE territory_name = ? ORDER BY score_total DESC LIMIT 1",
        {territoryName},
        function(results)
            if results and #results > 0 then
                local leadingCrewId = tonumber(results[1].id_crew)
                local sellingCrewId = crewId and tonumber(crewId) or nil

                if not sellingCrewId or leadingCrewId ~= sellingCrewId then
                    local alertChance = math.random(1, 100)
                    local maxAlertChance = Config.AlertChance or 20

                    if alertChance <= maxAlertChance then
                        GetOnlineCrewMembers(leadingCrewId, function(members)
                            local alertType = sellingCrewId and "deal" or "independent_deal"

                            for _, memberSource in ipairs(members) do
                                TriggerClientEvent("cDrugs:SendAlertNotification", memberSource, territoryName, alertType)
                            end
                        end)
                    end
                end
            end
        end
    )
end


RegisterServerEvent("cDrugs:SellDrugs")
AddEventHandler("cDrugs:SellDrugs", function(itemName, itemLabel, money, quantity, territoryName, crewName)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer or not itemName then
        print(_U("error_xplayer_item_nil"))
        return
    end

    local policeCount = GetCachedPoliceCount()

    if not money then
        print(_U("error_money_nil"))
        return
    end

    if crewName and territoryName then
        GetCrewRankingOnTerritory(crewName, territoryName, function(ranking)
            local multiplier = Config.PriceMultipliers[ranking] or 1
            money = money * multiplier

            ProcessDrugSale(xPlayer, itemName, itemLabel, money, quantity, territoryName, crewName)
        end)
    else
        ProcessDrugSale(xPlayer, itemName, itemLabel, money, quantity, territoryName, crewName)
    end
end)


ESX.RegisterServerCallback("cDrugs:getTerritoryRanking", function(source, cb, territoryName)
    MySQL.Async.fetchAll(
        "SELECT t.id_crew, t.score_total, c.name AS crew_name FROM territoires t INNER JOIN crew_liste c ON t.id_crew = c.id_crew WHERE t.territory_name = ? ORDER BY t.score_total DESC LIMIT 5",
        {territoryName},
        function(results)
            if results and #results > 0 then
                cb(results)
            else
                cb({})
            end
        end
    )
end)


ESX.RegisterServerCallback("cDrugs:getPlayerInventory", function(source, cb, playerId)
    if Config.Inventory == "tgiann" then
        local inventory = exports["tgiann-inventory"]:GetPlayerItems(playerId)

        if inventory then
            cb({inventory = inventory})
        else
            cb(nil)
        end
    else
        local xPlayer = ESX.GetPlayerFromId(playerId)

        if xPlayer then
            cb({inventory = xPlayer.inventory})
        else
            cb(nil)
        end
    end
end)


function HasCrewClaimedTodayDB(crewId, callback)
    local today = os.date("%Y-%m-%d")

    MySQL.Async.fetchScalar(
        "SELECT COUNT(*) FROM crew_claims WHERE id_crew = ? AND claim_date = ?",
        {crewId, today},
        function(count)
            if count and tonumber(count) > 0 then
                callback(true)
            else
                callback(false)
            end
        end
    )
end


function RegisterCrewClaimDB(crewId)
    local today = os.date("%Y-%m-%d")

    MySQL.Async.execute(
        "INSERT INTO crew_claims (id_crew, claim_date) VALUES (?, ?)",
        {crewId, today}
    )
end


RegisterServerEvent("cDrugs:ClaimTerritory")
AddEventHandler("cDrugs:ClaimTerritory", function(territoryName)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if not xPlayer then
        return
    end

    local identifier = xPlayer.identifier

    MySQL.Async.fetchScalar(
        "SELECT id_crew FROM crew_membres WHERE identifier = ?",
        {identifier},
        function(crewId)
            if not crewId then
                TriggerClientEvent("esx:showNotification", playerId, _U("not_in_crew"))
                return
            end

            crewId = tonumber(crewId)

            HasCrewClaimedTodayDB(crewId, function(hasClaimed)
                if hasClaimed then
                    TriggerClientEvent("esx:showNotification", playerId, _U("you_already_claimed_today"))
                    return
                end

                local minOnline = Config.ClaimRequirements and Config.ClaimRequirements.MinOnlineToClaim or 4
                local minLeaders = Config.ClaimRequirements and Config.ClaimRequirements.MinLeaderOnline or 4

                MySQL.Async.fetchScalar(
                    "SELECT id_crew FROM territoires WHERE territory_name = ? ORDER BY score_total DESC LIMIT 1",
                    {territoryName},
                    function(leadingCrewId)
                        local function countCrewMembers(targetCrewId, callback)
                            GetOnlineCrewMembers(targetCrewId, function(members)
                                callback(#members)
                            end)
                        end

                        countCrewMembers(crewId, function(onlineCount)
                            if onlineCount < minOnline then
                                TriggerClientEvent("esx:showNotification", playerId, _U("not_enough_members_to_claim", minOnline))
                                return
                            end

                            local function executeClaim()
                                local claimPoints = Config.CrewClaim or 30

                                MySQL.Async.execute(
                                    "UPDATE territoires SET score_total = score_total + ? WHERE territory_name = ? AND id_crew = ?",
                                    {claimPoints, territoryName, crewId},
                                    function(affectedRows)
                                        if affectedRows == 0 then
                                            MySQL.Async.execute(
                                                "INSERT INTO territoires (id_crew, territory_name, score_total) VALUES (?, ?, ?)",
                                                {crewId, territoryName, claimPoints},
                                                function()
                                                    RegisterCrewClaimDB(crewId)
                                                    TriggerClientEvent("esx:showNotification", playerId, _U("crew_claimed_territory", territoryName, claimPoints))

                                                    if Config.CrewXP and Config.CrewXP.EnableClaimXP then
                                                        local xp = tonumber(Config.CrewXP.ClaimXP or 0) or 0

                                                        if xp > 0 then
                                                            TriggerEvent("crew:addXP", xp, playerId)
                                                        end
                                                    end

                                                    NotifyTerritoryLeader(crewId, territoryName)
                                                end
                                            )
                                        else
                                            RegisterCrewClaimDB(crewId)
                                            TriggerClientEvent("esx:showNotification", playerId, _U("crew_claimed_territory", territoryName, claimPoints))

                                            if Config.CrewXP and Config.CrewXP.EnableClaimXP then
                                                local xp = tonumber(Config.CrewXP.ClaimXP or 0) or 0

                                                if xp > 0 then
                                                    TriggerEvent("crew:addXP", xp, playerId)
                                                end
                                            end

                                            NotifyTerritoryLeader(crewId, territoryName)
                                        end
                                    end
                                )
                            end

                            if leadingCrewId and tonumber(leadingCrewId) and tonumber(leadingCrewId) ~= crewId then
                                TriggerClientEvent("esx:showNotification", playerId, "Ce territoire est déjà contrôlé ! Vendez de la drogue pour réduire leur influence.")
                                return
                            else
                                executeClaim()
                            end
                        end)
                    end
                )
            end)
        end
    )
end)


function NotifyTerritoryLeader(claimingCrewId, territoryName)
    MySQL.Async.fetchAll(
        "SELECT id_crew FROM territoires WHERE territory_name = ? ORDER BY score_total DESC LIMIT 1",
        {territoryName},
        function(results)
            if results and #results > 0 then
                local leadingCrewId = tonumber(results[1].id_crew)

                if leadingCrewId ~= claimingCrewId then
                    GetOnlineCrewMembers(leadingCrewId, function(members)
                        for _, memberSource in ipairs(members) do
                            TriggerClientEvent("cDrugs:SendAlertNotification", memberSource, territoryName, "claim")
                        end
                    end)
                end
            end
        end
    )
end


local IsResetting = false

function CleanupOldResetLogs()
    MySQL.Async.fetchAll('SELECT last_reset FROM reset_logs ORDER BY last_reset DESC LIMIT 1', {}, function(result)
        if result and result[1] then
            local keepDate = result[1].last_reset
            MySQL.Async.execute('DELETE FROM reset_logs WHERE last_reset < ?', {keepDate}, function(deletedRows)
                if deletedRows > 0 then
                    print(string.format("[nvTerritory] Nettoyage: %d anciennes entrées supprimées de reset_logs", deletedRows))
                end
            end)
        end
    end)
end

function ShouldResetTerritories(callback)
    MySQL.Async.fetchScalar(
        "SELECT UNIX_TIMESTAMP(last_reset) FROM reset_logs ORDER BY last_reset DESC LIMIT 1",
        {},
        function(lastResetTimestamp)
            if lastResetTimestamp then
                local currentTime = os.time()
                local timeSinceReset = os.difftime(currentTime, lastResetTimestamp)
                local resetInterval = (Config.ResetIntervalDays or 14) * 86400

                if timeSinceReset >= resetInterval then
                    callback(true)
                else
                    callback(false)
                end
            else
                callback(true)
            end
        end
    )
end

function UpdateLastResetDate()
    MySQL.Async.fetchScalar("SELECT COUNT(*) FROM reset_logs", {}, function(count)
        if count > 0 then
            MySQL.Async.execute(
                "UPDATE reset_logs SET last_reset = CURRENT_TIMESTAMP ORDER BY last_reset DESC LIMIT 1",
                {},
                function()
                    CleanupOldResetLogs()
                end
            )
        else
            MySQL.Async.execute(
                "INSERT INTO reset_logs (last_reset) VALUES (CURRENT_TIMESTAMP)",
                {}
            )
        end
    end)
end

function ResetTerritoryScores()
    if IsResetting then
        return
    end

    IsResetting = true
    print("[nvTerritory] Réinitialisation des territoires en cours...")

    MySQL.Async.execute("DELETE FROM territoires", {}, function(deletedRows)
        print(string.format("[nvTerritory] Territoires réinitialisés: %d entrées supprimées", deletedRows))
        UpdateLastResetDate()
        IsResetting = false
    end)
end


Citizen.CreateThread(function()
    Citizen.Wait(5000)
    CleanupOldResetLogs()

    while true do
        ShouldResetTerritories(function(shouldReset)
            if shouldReset then
                ResetTerritoryScores()
            end
        end)

        Citizen.Wait(3600000)
    end
end)


function GetCrewRankingOnTerritory(crewId, territoryName, callback)
    MySQL.Async.fetchAll(
        "SELECT t.id_crew, t.score_total, (@rownum := @rownum + 1) AS rank FROM (SELECT id_crew, score_total FROM territoires WHERE territory_name = ? ORDER BY score_total DESC) t, (SELECT @rownum := 0) r",
        {territoryName},
        function(results)
            if results and #results > 0 then
                local ranking = nil

                for _, row in ipairs(results) do
                    if tonumber(row.id_crew) == tonumber(crewId) then
                        ranking = tonumber(row.rank)
                        break
                    end
                end

                callback(ranking)
            else
                callback(nil)
            end
        end
    )
end


function ProcessDrugSale(xPlayer, itemName, itemLabel, money, quantity, territoryName, crewId)
    local policeCount = GetCachedPoliceCount()
    local minPoliceForFullPrice = Config.MinimumPoliceForFullPrice or 0


    if policeCount < minPoliceForFullPrice then
        money = money / 2
    end

    money = math.floor(money)


    if Config.Inventory == "tgiann" then
        if not exports["tgiann-inventory"]:HasItem(xPlayer.source, itemName, quantity) then
            TriggerClientEvent("esx:showNotification", xPlayer.source, _U("not_enough_drugs"))
            return
        end

        if not exports["tgiann-inventory"]:RemoveItem(xPlayer.source, itemName, quantity) then
            TriggerClientEvent("esx:showNotification", xPlayer.source, _U("error_removing_item"))
            return
        end
    elseif Config.Inventory == "qs" then
        if not exports["qs-inventory"]:RemoveItem(xPlayer.source, itemName, quantity) then
            TriggerClientEvent("esx:showNotification", xPlayer.source, _U("error_removing_item"))
            return
        end
    elseif Config.Inventory == "codem" then
        if not exports["codem-inventory"]:RemoveItem(xPlayer.source, itemName, quantity) then
            TriggerClientEvent("esx:showNotification", xPlayer.source, _U("error_removing_item"))
            return
        end
    else
        xPlayer.removeInventoryItem(itemName, quantity)
    end


    if Config.Inventory == "tgiann" then
        if Config.MoneyReceive == "black_money" then
            if not exports["tgiann-inventory"]:AddItem(xPlayer.source, "black_money", money) then
                TriggerClientEvent("esx:showNotification", xPlayer.source, _U("error_adding_money"))
                return
            end
        else
            if not exports["tgiann-inventory"]:AddItem(xPlayer.source, "money_item", money) then
                TriggerClientEvent("esx:showNotification", xPlayer.source, _U("error_adding_money"))
                return
            end
        end
    elseif Config.Inventory == "qs" or Config.Inventory == "codem" then
        if Config.MoneyReceive == "black_money" then
            xPlayer.addAccountMoney("black_money", money)
        else
            xPlayer.addMoney(money)
        end
    else
        if Config.MoneyReceive == "black_money" then
            xPlayer.addAccountMoney("black_money", money)
        else
            xPlayer.addMoney(money)
        end
    end

    TriggerClientEvent("esx:showNotification", xPlayer.source, _U("sell_drugs_notification", quantity, itemLabel, money))


    if territoryName then
        if Config.CrewXP and Config.CrewXP.EnableSaleXP then
            local xp = 0

            if Config.CrewXP.SaleXP then
                xp = tonumber(Config.CrewXP.SaleXP[itemName] or 0) or 0
            end

            local itemQuantity = tonumber(quantity) or 1
            xp = xp * itemQuantity

            if xp > 0 then
                TriggerEvent("crew:addXP", xp, xPlayer.source)
            end
        end
    end


    if territoryName and crewId then
        local points = Config.DrugPoints[itemName] or 0


        MySQL.Async.fetchAll("SELECT id_crew, score_total FROM territoires WHERE territory_name = ? ORDER BY score_total DESC LIMIT 1", {territoryName}, function(results)
            local leadingCrewId = nil
            local currentScore = 0

            if results and #results > 0 then
                leadingCrewId = tonumber(results[1].id_crew)
                currentScore = tonumber(results[1].score_total)
            end


            if leadingCrewId and leadingCrewId ~= tonumber(crewId) then
                MySQL.Async.execute(
                    "UPDATE territoires SET score_total = score_total - ? WHERE territory_name = ? AND id_crew = ?",
                    {points, territoryName, leadingCrewId},
                    function()

                        local newScore = currentScore - points
                        if newScore <= 0 then
                            MySQL.Async.execute("DELETE FROM territoires WHERE territory_name = ? AND id_crew = ?", {territoryName, leadingCrewId}, function()
                                TriggerClientEvent("esx:showNotification", xPlayer.source, "Territoire ~g~NEUTRALISÉ~s~ ! La zone est libre.")
                                CheckAndSendAlert(leadingCrewId, territoryName)
                            end)
                        else
                            TriggerClientEvent("esx:showNotification", xPlayer.source, "Influence ennemie réduite : ~r~-" .. points)
                            CheckAndSendAlert(leadingCrewId, territoryName)
                        end
                    end
                )


            else
                MySQL.Async.execute(
                    "UPDATE territoires SET score_total = score_total + ? WHERE territory_name = ? AND id_crew = ?",
                    {points, territoryName, crewId},
                    function(affectedRows)
                        if affectedRows == 0 then

                            HasCrewClaimedTodayDB(crewId, function(hasClaimed)
                                if hasClaimed then
                                    TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Limite atteinte :~s~ Votre crew a déjà revendiqué un territoire aujourd'hui.")


                                else
                                    MySQL.Async.execute(
                                        "INSERT INTO territoires (id_crew, territory_name, score_total) VALUES (?, ?, ?)",
                                        {crewId, territoryName, points},
                                        function()
                                            RegisterCrewClaimDB(crewId)
                                            TriggerClientEvent("esx:showNotification", xPlayer.source, _U("territory_influence_gained", points, territoryName))
                                            CheckAndSendAlert(crewId, territoryName)
                                        end
                                    )
                                end
                            end)
                        else
                            TriggerClientEvent("esx:showNotification", xPlayer.source, _U("territory_influence_gained", points, territoryName))
                            CheckAndSendAlert(crewId, territoryName)
                        end
                    end
                )
            end
        end)
    elseif territoryName then
        CheckAndSendAlert(nil, territoryName)
    end
end


RegisterNetEvent("cDrugs:NotifyPolice")
AddEventHandler("cDrugs:NotifyPolice", function(coords)
    NotifyPolice(coords)
end)


function NotifyPolice(coords)
    local players = ESX.GetPlayers()

    for i = 1, #players do
        local xPlayer = ESX.GetPlayerFromId(players[i])

        if xPlayer and (xPlayer.job.name == "police" or xPlayer.job.name == "bcso" or xPlayer.job.name == "sheriff" or xPlayer.job.name == "saspn") then
            TriggerClientEvent("nvDrugs:GetStreetName", xPlayer.source)
        end
    end
end


ESX.RegisterServerCallback('cDrugs:getDashboardData', function(source, cb)
    local data = {
        resetDate = nil,
        territories = {}
    }


    MySQL.Async.fetchScalar("SELECT last_reset FROM reset_logs ORDER BY last_reset DESC LIMIT 1", {}, function(lastReset)
        local timestamp = os.time()
        if lastReset then
            timestamp = tonumber(lastReset) or os.time()

            if timestamp > 100000000000 then
                timestamp = math.floor(timestamp / 1000)
            end
        end

        data.resetDate = os.date("%d/%m/%Y %H:%M", timestamp)


        MySQL.Async.fetchAll(
            "SELECT t.territory_name, t.score_total, c.name as crew_name FROM territoires t INNER JOIN crew_liste c ON t.id_crew = c.id_crew ORDER BY t.score_total DESC",
            {},
            function(results)
                local territoryMap = {}

                for _, row in ipairs(results) do
                    if not territoryMap[row.territory_name] then
                        territoryMap[row.territory_name] = {
                            name = row.crew_name,
                            score = row.score_total
                        }
                    end
                end


                local allTerritories = LoadTerritoriesFromFile()


                for _, t in ipairs(allTerritories) do
                    local info = territoryMap[t.name]
                    if info then
                         data.territories[t.name] = info
                    else
                         data.territories[t.name] = {
                            name = "Aucune (Libre)",
                            score = 0
                         }
                    end
                end


                local xPlayer = ESX.GetPlayerFromId(source)
                if xPlayer then
                    MySQL.Async.fetchScalar("SELECT id_crew FROM crew_membres WHERE identifier = ?", {xPlayer.identifier}, function(crewId)
                        if crewId then
                            HasCrewClaimedTodayDB(crewId, function(hasClaimed)
                                if hasClaimed then

                                    local tomorrow = os.time() + 86400
                                    local dateTable = os.date("*t", tomorrow)
                                    data.nextClaimTime = string.format("%02d/%02d/%04d 00:00", dateTable.day, dateTable.month, dateTable.year)
                                else
                                    data.nextClaimTime = "Maintenant"
                                end
                                cb(data)
                            end)
                        else
                            data.nextClaimTime = "Non éligible (Pas de crew)"
                            cb(data)
                        end
                    end)
                else
                    cb(data)
                end
            end
        )
    end)
end)


RegisterNetEvent("nvDrugs:SendStreetNameToServer")
AddEventHandler("nvDrugs:SendStreetNameToServer", function(streetName, coords)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if xPlayer and (xPlayer.job.name == "police" or xPlayer.job.name == "bcso" or xPlayer.job.name == "sheriff" or xPlayer.job.name == "saspn") then
        local label = _U("drug_sale_in_progress")
        TriggerClientEvent("nvDrugs:AddBlipForPolice", playerId, coords, label)
    end
end)