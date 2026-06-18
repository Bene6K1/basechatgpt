adminManagement = {
    Service = {},
    Players = {},
    staffList = {},
    Reports = {},
    UniqueIDSearch = {},
    UniqueIDSearchBoutiqueHistory = {},
    ItemsList = {},
    WarnList = {},
    sanctionsList = {},

    jails = {},
}

CreateThread(function()
    while true do
        Wait(10)
    end
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local source = source

    adminManagement.Players[source] = {
        name = GetPlayerName(source),
        id = source,
        UniqueID = xPlayer.UniqueID,
        group = xPlayer.getGroup(),
        job = xPlayer.getJob(),
        job2 = xPlayer.getJob2(),
        identifier = xPlayer.identifier
    }

    if xPlayer.getGroup() ~= 'user' then
        adminManagement.staffList[source] = {
            name = GetPlayerName(source),
            id = source,
            UniqueID = xPlayer.UniqueID,
            group = xPlayer.getGroup(),
            job = xPlayer.getJob(),
            job2 = xPlayer.getJob2(),
            service = false
        }

        TriggerClientEvent("sunny:admin:addReport", source, nil, adminManagement.Reports)

        TriggerClientEvent('sunny:reports:refreh:service', source, adminManagement.Reports)
    end

    adminManagement:AddPlayer()
    adminManagement:UpdateStaffs()
end)

ESX.RegisterServerCallback("sunny:admin:getJobsList", function(source, callback)
    MySQL.Async.fetchAll("SELECT * FROM jobs", {}, function(result)
      callback(result)
    end)
  end)

AddEventHandler('playerDropped', function(reason)
    local source = source

    if not adminManagement.Players[source] then return end

    local playerId = ReturnPlayerId(adminManagement.Players[source].UniqueID)
    
    if not playerId then return end

    adminManagement.Reports[playerId.id] = nil
    adminManagement:RemoveReport(SunnyConfigServ.GTACOLOR.."Intéligence Artificiele~s~", playerId.UniqueID)

   

    adminManagement.Players[source] = nil
    adminManagement.staffList[source] = nil

    Wait(100)

    adminManagement:AddPlayer()
    adminManagement:UpdateStaffs()
end)

ESX.RegisterServerCallback("sunny:getPhoneData", function(source, callback)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM phone_phones WHERE id = @identifier", {
      ["@identifier"] = player.identifier
    }, function(result)
      if result[1] then
        local phoneData = {}
        phoneData.phoneNumber = result[1].phone_number
        phoneData.name = result[1].name
        phoneData.settings = result[1].settings and json.decode(result[1].settings) or { locale = "fr" }
        phoneData.isSetup = result[1].is_setup
        phoneData.battery = result[1].battery
        callback(phoneData)
      else
        callback(false)
      end
    end)
  end)

  RegisterServerEvent('sunny:jobs:RemoveallJobs')
  AddEventHandler('sunny:jobs:RemoveallJobs', function(jobName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getGroup() ~= 'user' then
        MySQL.Async.execute('UPDATE users SET job = @job WHERE job = @jobName', {
            ['@job'] = 'unemployed',
            ['@jobName'] = jobName
        }, function(rowsChanged) 
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', src, ('%d employés ont été retirés du job %s'):format(rowsChanged, jobName))
            else
                TriggerClientEvent('esx:showNotification', src, 'Aucun employé trouvé pour ce job')
            end
        end)
    else
        DropPlayer(src, "Tu trigger Bref...")
    end
end)


ESX.RegisterServerCallback("Sunny:staff:openList", function(source, callback)
    local player = ESX.GetPlayerFromId(source)
    local group = player.getGroup()

    if group ~= "user" then
        MySQL.Async.fetchAll("SELECT identifier, playerName, permission_group AS 'group' FROM `users` WHERE `permission_group` <> 'user'", {}, function(result)
            if result then
                for i, user in ipairs(result) do
                end
                callback(result)
            else
                callback({})
            end
        end)
    else
        callback({})
    end
end)

ESX.RegisterServerCallback("Sunny:staff:openReportList", function(source, callback)
    local player = ESX.GetPlayerFromId(source)
    local group = player.getGroup()
  
    if group ~= "user" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `permission_group` <> 'user'", {}, function(result)
            local mostWeeklyReports = 0
            local mostReportsPlayerName = nil
            local userTotalReports = 0
  
            for _, playerData in ipairs(result) do
                if playerData.report and playerData.report ~= "" and playerData.report ~= nil and playerData.report ~= "{}" and playerData.report ~= "[]" then
                    local reports = json.decode(playerData.report)
                    local weeklyCloseReports = 0
                    local takeReports = 0
  
                    for _, report in ipairs(reports.take) do
                        if not IsReportInCurrentWeek(report.timestamp) then
                            if report.isCountableInWeek then
                                takeReports = takeReports + 1
                            end
                        end
                    end
  
                    for _, report in ipairs(reports.close) do
                        if not IsReportInCurrentWeek(report.timestamp) then
                            if report.isCountableInWeek then
                                weeklyCloseReports = weeklyCloseReports + 1
                                userTotalReports = userTotalReports + 1
                            end
                        end
                    end
  
                    if mostWeeklyReports < weeklyCloseReports and weeklyCloseReports >= 1 then
                        mostWeeklyReports = weeklyCloseReports
                    end
  
                    if mostReportsPlayerName == nil or mostWeeklyReports < weeklyCloseReports and weeklyCloseReports >= 1 then
                        mostWeeklyReports = weeklyCloseReports
                        mostReportsPlayerName = playerData.playerName
                    end
                end
            end
  
            callback(result, {
                name = mostReportsPlayerName,
                reports = {
                    weekly = {
                        close = mostWeeklyReports,
                        take = takeReports
                    },
                    all = {
                        close = userTotalReports
                    }
                },
                timestamp = os.time()
            })
        end)
    end
end)

function IsReportInCurrentWeek(timestamp)
    local currentWeekNumber = GetCurrentWeekNumber()
    local year, month, day = GetDateFromTimestamp(timestamp)
    local weekNumber = GetWeekNumber(year, month, day)
    return currentWeekNumber == weekNumber
end

function GetCurrentWeekNumber()
    local currentDate = os.date("*t")
    return GetWeekNumber(currentDate.year, currentDate.month, currentDate.day)
end

function GetWeekNumber(year, month, day)
    local januaryFirst = os.time({year = year, month = 1, day = 1})
    local dayOfWeek = os.date("%w", januaryFirst)
    local daysInFirstWeek = 7 - dayOfWeek
    local totalDays = (os.time({year = year, month = month, day = day}) - januaryFirst) / (60 * 60 * 24) + 1
    local weeks = math.ceil((totalDays - daysInFirstWeek) / 7) + 1

    if daysInFirstWeek >= 4 then
        return weeks + 1
    else
        return weeks
    end
end

function GetDateFromTimestamp(timestamp)
    local dateTable = os.date("*t", timestamp)
    return dateTable.year, dateTable.month, dateTable.day
end

  

RegisterNetEvent('sunny:admin:sortBucket')
AddEventHandler('sunny:admin:sortBucket', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'user' then return end
    if playerId then
        SetPlayerRoutingBucket(playerId, 0)
        TriggerClientEvent('esx:showNotification', playerId, 'Vous avez été sorti du bucket par un administrateur.')
    end
end)


RegisterNetEvent('sunny:admin:restart', function()
    local source = source

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    adminManagement.Players[source] = {
        name = GetPlayerName(source),
        id = source,
        UniqueID = xPlayer.UniqueID or 'none',
        group = xPlayer.getGroup(),
        job = xPlayer.getJob(),
        job2 = xPlayer.getJob2(),
        identifier = xPlayer.identifier
    }

    if xPlayer.getGroup() ~= 'user' then
        adminManagement.staffList[source] = {
            name = GetPlayerName(source),
            id = source,
            UniqueID = xPlayer.UniqueID,
            group = xPlayer.getGroup(),
            job = xPlayer.getJob(),
            job2 = xPlayer.getJob2(),
            service = false
        }
    end

    adminManagement:AddPlayer()
    adminManagement:UpdateStaffs()
end)

RegisterNetEvent('sunny:admin:service', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    adminManagement.Service[xPlayer.UniqueID] = not adminManagement.Service[xPlayer.UniqueID]

    TriggerClientEvent('sunny:admin:service', source, adminManagement.Service[xPlayer.UniqueID])

    if not adminManagement.staffList[source] then
        adminManagement.staffList[source] = {
            name = GetPlayerName(source),
            id = source,
            UniqueID = xPlayer.UniqueID,
            group = xPlayer.getGroup(),
            job = xPlayer.getJob(),
            job2 = xPlayer.getJob2(),
            service = false
        }
    end
    adminManagement.staffList[source].service = adminManagement.Service[xPlayer.UniqueID]

    if adminManagement.Service[xPlayer.UniqueID] == false then

        adminManagement:NotifyActiveStaff(('Le staff ~y~%s~s~ a finit son service'):format(GetPlayerName(source)))

        sendLog(('Un staff a quitter son service (%s - %s)'):format(xPlayer.name, xPlayer.UniqueID), {
            author = xPlayer.name,
            fields = {
                {title = 'Joueur', subtitle = xPlayer.name},
                {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                {title = 'Identifier', subtitle = xPlayer.identifier},
                {title = 'Plaque', subtitle = plate},
                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
            },
            channel = 'staff_fin'
        })
    
    
    elseif adminManagement.Service[xPlayer.UniqueID] == true then
        local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
        adminManagement:NotifyActiveStaff(('Le staff ~y~%s~s~ a prit son service'):format(rpName))
        sendLog(('Un staff a pris son service (%s - %s)'):format(rpName, xPlayer.UniqueID, plate), {
            author = rpName,
            fields = {
                {title = 'Joueur', subtitle = rpName},
                {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                {title = 'Identifier', subtitle = xPlayer.identifier},
                {title = 'Plaque', subtitle = plate},
                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
            },
            channel = 'staff_prise'
        })
    
    end

    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end

        TriggerClientEvent('sunny:admin:addStaff:service', k, source, adminManagement.Service[xPlayer.UniqueID])

        ::continue::
    end
end)

RegisterCommand('report', function(source, args)
    local source = source
        if #args == 0 then 
            TriggerClientEvent('esx:showNotification', source, '⛔ Raison invalide')
            return
        end
        local xPlayer = ESX.GetPlayerFromId(source)

        if adminManagement.Reports[xPlayer.UniqueID] ~= nil then 
            TriggerClientEvent('esx:showNotification', source, '⛔ Vous avez déjà un report en cours')
            return
        end 

        adminManagement.Reports[xPlayer.UniqueID] = {
            author = GetPlayerName(source),
            source = source,
            UniqueID = xPlayer.UniqueID,
            reason = table.concat( args, " " ),
            take = false,
            takeBY = 'Personne',
            job = xPlayer.getJob(),
            job2 = xPlayer.getJob2()
        }

        adminManagement:AddReport(source)
end)


RegisterNetEvent('sunny:admin:mort:report', function(message)
    local source = source
    if source == 0 then goto continue end

    local xPlayer = ESX.GetPlayerFromId(source)

    if adminManagement.Reports[xPlayer.UniqueID] ~= nil then TriggerClientEvent('esx:showNotification', source, '⛔ Vous avez déjà un report en cours') goto continue end 

    adminManagement.Reports[xPlayer.UniqueID] = {
        author = GetPlayerName(source),
        source = source,
        UniqueID = xPlayer.UniqueID,
        reason = message,
        take = false,
        takeBY = 'Personne',
        job = xPlayer.getJob(),
        job2 = xPlayer.getJob2()
    }

    adminManagement:AddReport(source)

    ::continue::
end)

RegisterCommand('closeReport', function(source)
    local source = source
    if source == 0 then goto continue end

    adminManagement:RemoveMyReport(source)

    ::continue::
end)

RegisterServerEvent("Sunny:staff:resetReports")
AddEventHandler("Sunny:staff:resetReports", function(playerName)
    MySQL.Async.execute("UPDATE users SET reports_taken = 0 WHERE playerName = @playerName", {
        ['@playerName'] = playerName
    }, function(rowsChanged)
    end)
end)


RegisterNetEvent('sunny:admin:takeReport', function(reportID, src)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'user' then return end
    if not reportID then return end
    if not adminManagement.Reports[reportID] then return end

    adminManagement.Reports[reportID].take = true
    adminManagement.Reports[reportID].takeBY = GetPlayerName(source)
    adminManagement.Reports[reportID].takeUID = xPlayer.identifier

    adminManagement:takeReport(src, reportID, GetPlayerName(source))

    MySQL.Async.execute('UPDATE users SET reports_taken = reports_taken + 1 WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })

    TriggerClientEvent('sunny:admin:teleport', source, GetEntityCoords(GetPlayerPed(src)))
    TriggerClientEvent('esx:showNotification', src, '😀 Votre report a été pris en charge')

    sendLog(('Report pris en charge par (%s - %s) (reportID: %s)'):format(xPlayer.name, xPlayer.UniqueID, reportID), {
        author = xPlayer.name,
        fields = {
            {title = 'Admin', subtitle = xPlayer.name},
            {title = 'Admin ID Unique', subtitle = xPlayer.identifier},
            {title = 'Report ID', subtitle = reportID},
            {title = 'Player Source', subtitle = src},
            {title = 'Discord', subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_take_report'
    })
end)


RegisterNetEvent('sunny:admin:closeReport', function(reportID, src, avis, resolution)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local cfg = Config.Staff.Reports

    if not xPlayer then return end

    -- Validation des données
    avis = avis or "Aucun avis fourni"
    resolution = resolution or Config.Staff.GetDefaultResolution()
    local resolutionLabel = Config.Staff.GetResolutionLabel(resolution)

    adminManagement:RemoveReport(GetPlayerName(source), reportID)
    TriggerClientEvent('esx:showNotification', src, cfg.Notifications.PlayerClosed)

    -- Construction dynamique des fields selon la config
    if cfg.Discord.Enabled then
        local fields = {}

        if cfg.Discord.Fields.ShowAdmin then
            table.insert(fields, {title = 'Admin', subtitle = xPlayer.name})
        end
        if cfg.Discord.Fields.ShowAdminIdentifier then
            table.insert(fields, {title = 'Admin ID Unique', subtitle = xPlayer.identifier})
        end
        if cfg.Discord.Fields.ShowReportID then
            table.insert(fields, {title = 'Report ID', subtitle = reportID})
        end
        if cfg.Discord.Fields.ShowPlayerSource then
            table.insert(fields, {title = 'Player Source', subtitle = src})
        end
        if cfg.Discord.Fields.ShowDiscord then
            table.insert(fields, {title = 'Discord', subtitle = ESX.GetIdentifierFromId(source, "discord:")})
        end
        if cfg.Discord.Fields.ShowResolution then
            table.insert(fields, {title = 'Résolution', subtitle = resolutionLabel})
        end
        if cfg.Discord.Fields.ShowReview then
            table.insert(fields, {title = 'Avis du Staff', subtitle = avis})
        end
        if cfg.Discord.Fields.ShowTimestamp then
            table.insert(fields, {title = 'Clôturé le', subtitle = os.date("%d/%m/%Y à %H:%M")})
        end

        sendLog(('Report clôturé (%s - %s) (reportID: %s)'):format(xPlayer.name, xPlayer.UniqueID, reportID), {
            author = xPlayer.name,
            fields = fields,
            channel = cfg.Discord.Channel,
            color = Config.Staff.GetResolutionColor(resolution)
        })
    end
end)


function adminManagement:AddReport(src)
    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end

        TriggerClientEvent("sunny:admin:addReport", k, src, adminManagement.Reports, 'new')

        ::continue::
    end

    for k, v in pairs(adminManagement.Players) do
        if v.group ~= 'user' then
            TriggerClientEvent('esx:showAdvancedNotification', k, "NOUVEAU REPORT !", nil, ('Un nouveau report a été reçu du joueur ~b~#%s~s~'):format(src), 'CHAR_CALL911', 7)
        end
    end
end

function adminManagement:takeReport(src, reportID, takeBY)
    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end

        TriggerClientEvent("sunny:admin:addReport", k, src, adminManagement.Reports)

        ::continue::
    end

    adminManagement:NotifyActiveStaff(('⭐ Le staff %s a pris en charge le report #%s'):format(takeBY, reportID))
end

function adminManagement:RemoveReport(takeBY, reportID)

    if adminManagement.Reports[reportID] == nil then return end

    adminManagement.Reports[reportID] = nil

    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end

        TriggerClientEvent("sunny:admin:removeReport", k, nil, reportID, adminManagement.Reports)

        ::continue::
    end

    adminManagement:NotifyActiveStaff(('⭐ Le staff %s a clôturé le report #%s'):format(takeBY, reportID))
end

function adminManagement:RemoveMyReport(src)
    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end

        adminManagement.Reports[k] = nil

        TriggerClientEvent("sunny:admin:removeReport", k, nil, src, adminManagement.Reports)

        ::continue::
    end
end

function adminManagement:NotifyActiveStaff(msg)
    for k,v in pairs(adminManagement.Players) do

        if v.group == 'user' then goto continue end 

        if not adminManagement.Service[v.UniqueID] then goto continue end

        TriggerClientEvent('esx:showNotification', k, msg)

        ::continue::
    end
end

function adminManagement:AddPlayer(id)
    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end 

        TriggerClientEvent("sunny:admin:addPlayer", k, adminManagement.Players)
        
        ::continue::
    end
end

local lastStaffListHash = nil
local lastStaffUpdate = 0

function tableHash(tbl)
    return json.encode(tbl)
end

function adminManagement:UpdateStaffs()
    for k,v in pairs(self.staffList) do
        if not GetPlayerName(k) then
            self.staffList[k] = nil
        end
    end

    local currentHash = tableHash(self.staffList)
    local now = os.time()

    if lastStaffListHash == currentHash and (now - lastStaffUpdate) < 2 then
        return
    end

    lastStaffListHash = currentHash
    lastStaffUpdate = now

    local staffCount = 0
    for k,v in pairs(self.staffList) do
        staffCount = staffCount + 1
    end

    for k,v in pairs(self.Players) do
        if v.group ~= 'user' then
            TriggerClientEvent("sunny:admin:addStaff", k, {
                list = self.staffList,
                count = staffCount
            })
        end
    end
end

RegisterNetEvent('sunny:admin:goto', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerB = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() == 'user' then return end

    TriggerClientEvent('sunny:admin:teleport', source, GetEntityCoords(GetPlayerPed(target)))

    sendLog(('Admin téléporté à un joueur (%s - %s) (target: %s)'):format(xPlayer.name, xPlayer.UniqueID, xPlayerB.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Admin', subtitle = xPlayer.name},
            {title = 'Admin ID Unique', subtitle = xPlayer.identifier},
            {title = 'Target Player', subtitle = xPlayerB.UniqueID},
            {title = 'Discord', subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_goto'
    })
end)

RegisterNetEvent('sunny:admin:bring', function(target, coords)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerB = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() == 'user' then return end

    TriggerClientEvent('sunny:admin:teleport', target, coords)

    sendLog(('Admin a téléporté un joueur (%s - %s) (target: %s)'):format(xPlayer.name, xPlayer.UniqueID, xPlayerB.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Admin', subtitle = xPlayer.name},
            {title = 'Admin ID Unique', subtitle = xPlayer.identifier},
            {title = 'Target Player', subtitle = xPlayerB.UniqueID},
            {title = 'Coordinates', subtitle = json.encode(coords)},
            {title = 'Discord', subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_bring'
    })
end)


RegisterNetEvent('sunny:admin:teleport', function(target, coords)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerB = ESX.GetPlayerFromId(target)

    if xPlayer.getGroup() == 'user' then return end

    TriggerClientEvent('sunny:admin:teleport', target, coords)

    sendLog(('Admin a téléporté un joueur (%s - %s) (target: %s)'):format(xPlayer.name, xPlayer.UniqueID, xPlayerB.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Admin', subtitle = xPlayer.name},
            {title = 'Admin ID Unique', subtitle = xPlayer.identifier},
            {title = 'Target Player', subtitle = xPlayerB.UniqueID},
            {title = 'Coordinates', subtitle = json.encode(coords)},
            {title = 'Discord', subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_teleport'
    })
end)


RegisterNetEvent('sunny:admin:screen', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerB = ESX.GetPlayerFromId(target)

    TriggerClientEvent('sunny:admin:requestScreen', target, target, nil, GetPlayerName(source))

    sendLog(('Admin a demandé une capture d\'écran (%s - %s) (target: %s)'):format(xPlayer.name, xPlayer.UniqueID, xPlayerB.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Admin', subtitle = xPlayer.name},
            {title = 'Admin ID Unique', subtitle = xPlayer.identifier},
            {title = 'Target Player', subtitle = xPlayerB.UniqueID},
            {title = 'Discord', subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_screen'
    })
end)


RegisterNetEvent('sunny:admin:spawnVehicle', function(target, model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerB = ESX.GetPlayerFromId(target)
    if xPlayer.getGroup() == 'user' then return end

    TriggerClientEvent('esx:spawnVehicle', target, model)

    sendLog(('Admin a fait apparaître un véhicule (%s - %s) (target: %s, model: %s)'):format(xPlayer.name, xPlayer.UniqueID, xPlayerB.UniqueID, model), {
        author = xPlayer.name,
        fields = {
            {title = 'Admin', subtitle = xPlayer.name},
            {title = 'Admin ID Unique', subtitle = xPlayer.identifier},
            {title = 'Target Player', subtitle = xPlayerB.UniqueID},
            {title = 'Vehicle Model', subtitle = model},
            {title = 'Discord', subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_spawn_vehicle'
    })
end)


ESX.RegisterServerCallback('sunny:admin.getAccounts', function(source, cb, UniqueID)
    local source = source
    local accounts = {}
    local cash, bank, black_money = 0
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {['@UniqueID'] = UniqueID}, function(result)
        if json.encode(result) == '[]' then return end
        for k,v in pairs(json.decode(result[1].accounts)) do
            if v.name == 'cash' then
                cash = v.money
            end
            if v.name == 'bank' then
                bank = v.money
            end
            if v.name == 'black_money' then
                black_money = v.money
            end
            accounts = {
                {cash = cash},  
                {bank = bank},
                {black_money = black_money}
            }
        end

        cb(accounts)
    end)
end)

ESX.RegisterServerCallback('sunny:admin:getAllJobs', function(source, cb)
    local source = source
    adminManagement.JobList = {}
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
        for k,v in pairs(result) do
            table.insert(adminManagement.JobList, v)
        end

        cb(adminManagement.JobList)
    end)
end)

ESX.RegisterServerCallback('sunny:admin:getGradeWithJob', function(source, cb, job)
    local source = source
    adminManagement.getGradeWithJob = {}
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name', {['@job_name'] = job}, function(result)
        for k,v in pairs(result) do
            table.insert(adminManagement.getGradeWithJob, v)
        end

        cb(adminManagement.getGradeWithJob)
    end)
end)

ESX.RegisterServerCallback('sunny:admin:getAllJobs', function(source, cb)
    local source = source
    adminManagement.JobList = {}
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
        for k,v in pairs(result) do
            table.insert(adminManagement.JobList, v)
        end

        cb(adminManagement.JobList)
    end)
end)

ESX.RegisterServerCallback('sunny:admin:getGradeWithJob', function(source, cb, job)
    local source = source
    adminManagement.getGradeWithJob = {}
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name', {['@job_name'] = job}, function(result)
        for k,v in pairs(result) do
            table.insert(adminManagement.getGradeWithJob, v)
        end

        cb(adminManagement.getGradeWithJob)
    end)
end)

RegisterNetEvent('sunny:admin:setPlayerJob', function(target, job, grade, value)
    local source = source
    local targetPlayer = ESX.GetPlayerFromId(target)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    -- print(target, job, grade, value)

    if value == 'job' then
        targetPlayer.setJob(job, tonumber(grade))
    elseif value == 'job2' then
        targetPlayer.setJob2(job, tonumber(grade))
    end
end)

RegisterNetEvent('sunny:admin:setGroup', function(target, group)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'user' then 
        return 
    end

    local targetPlayer = ESX.GetPlayerFromId(target)
    if not targetPlayer then
        return
    end

    targetPlayer.setGroup(group)


    adminManagement.staffList[targetPlayer.source] = {
        name = GetPlayerName(targetPlayer.source),
        id = targetPlayer.source,
        UniqueID = targetPlayer.UniqueID,
        group = targetPlayer.getGroup(),
        job = targetPlayer.getJob(),
        job2 = targetPlayer.getJob2(),
        service = false
    }

    Wait(1000)
    
    TriggerClientEvent('sunny:admin:restart', targetPlayer.source)

    TriggerClientEvent('sunny:admin:checkGroupOnChangePlayerGroup', targetPlayer.source, group)

    adminManagement:UpdateStaffs()

    sendLog(('Le Staff (%s - %s) a changé le groupe de (%s - %s) en %s (staff)'):format(xPlayer.name, xPlayer.UniqueID ,targetPlayer.name, targetPlayer.UniqueID, group), {
        author = xPlayer.name,
        fields = {
            {title = 'Joueur', subtitle = targetPlayer.name},
            {title = 'Nouveau Groupe', subtitle = group},
            {title = 'Author', subtitle = GetPlayerName(source)},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_change_player_group'
    })
end)


RegisterNetEvent('sunny:admin:setGroupWithUniqueID', function(target, group)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'user' then 
        return 
    end

    local targetPlayer = ReturnPlayerIdUseESXfunctions(target)
    if targetPlayer then
        local targetPlayerESX = ESX.GetPlayerFromId(targetPlayer.source)

        targetPlayerESX.setGroup(group)

        if group == 'user' then
            adminManagement.staffList[targetPlayerESX.source] = nil
        else
            adminManagement.staffList[targetPlayerESX.source] = {
                name = GetPlayerName(targetPlayerESX.source),
                id = targetPlayerESX.source,
                UniqueID = targetPlayer.UniqueID,
                group = group,
                job = targetPlayerESX.getJob(),
                job2 = targetPlayerESX.getJob2(),
                service = false
            }
        end

        Wait(1000)
        
        TriggerClientEvent('sunny:admin:restart', targetPlayerESX.source)

        TriggerClientEvent('sunny:admin:checkGroupOnChangePlayerGroup', targetPlayerESX.source, group)

        adminManagement:UpdateStaffs()

        sendLog(('Le Staff (%s - %s) a changé le groupe de (%s - %s) en %s (staff)'):format(xPlayer.name, xPlayer.UniqueID ,targetPlayer.name, targetPlayer.UniqueID, group), {
            author = xPlayer.name,
            fields = {
                {title = 'Joueur', subtitle = targetPlayerESX.name},
                {title = 'Nouveau Groupe', subtitle = group},
                {title = 'Author', subtitle = GetPlayerName(source)},
                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
            },
            channel = 'staff_change_player_group'
        })
    else
        MySQL.Async.execute('UPDATE users SET permission_group = @p WHERE UniqueID = @U', {
            ['@p'] = group,
            ['@U'] = target
        }, function()
            
        end)
    end
end)


RegisterNetEvent('sunny:admin:delVeh', function(veh)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    DeleteEntity(NetworkGetEntityFromNetworkId(veh))
end)

RegisterNetEvent('sunny:admin:repairVeh', function(veh)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    TriggerClientEvent('sunny:admin:repairVeh', -1, veh)
end)

RegisterNetEvent('sunny:admin:freezeunfreezeplayer', function(target, value)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(target)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    TriggerClientEvent('sunny:admin:freezeUnfreezePlayer', xPlayer.source, value)
end)

RegisterNetEvent('sunny:admin:fullCustomVeh', function(veh)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    TriggerClientEvent('sunny:admin:fullCustomVeh', -1, veh)
end)

RegisterNetEvent('sunny:admin:freezeunfreezevehicle', function(veh, value)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    FreezeEntityPosition(NetworkGetEntityFromNetworkId(veh), value)
end)

RegisterNetEvent('sunny:admin:clearInventory', function(target)
    local source = source
    local xTarget = ESX.GetPlayerFromId(target)
    local xAdmin = ESX.GetPlayerFromId(source)
	if not xTarget or not xAdmin or xAdmin.getGroup() == 'user' then return end

    exports.ox_inventory:ClearInventory(xTarget.source)

    TriggerClientEvent('esx:showNotification', source, ('✅ inventaire du joueur ~r~%s~s~ clear avec succès'):format(xTarget.getName()))
end)

RegisterNetEvent('sunny:admin:clearWeapon', function(target)
    local source = source
    local xTarget = ESX.GetPlayerFromId(target)
    local xAdmin = ESX.GetPlayerFromId(source)
    if not xTarget or not xAdmin or xAdmin.getGroup() == 'user' then return end
    
    local items = exports.ox_inventory:GetInventoryItems(xTarget.source) or {}
    for slot, item in pairs(items) do
        if item and (item.type == 'weapon' or (item.name and string.sub(item.name, 1, 7) == 'weapon_')) then
            local weaponKey = string.upper(item.name or '')
            if not SunnyConfigServ.PermanantWeapon[weaponKey] then
                exports.ox_inventory:RemoveItem(xTarget.source, item.name, 1, item.metadata, item.slot)
            end
        end
    end

    TriggerClientEvent('esx:showNotification', source, ('✅ Arme(s) du joueur ~r~%s~s~ ont été supprimées avec succès, à l\'exception des armes permanentes'):format(xTarget.getName()))
end)


function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

RegisterNetEvent('sunny:admin:clearInventoryUniqueID', function(UniqueID)
    local source = source
    local xAdmin = ESX.GetPlayerFromId(source)
	if not xAdmin or xAdmin.getGroup() == 'user' then return end

    adminManagement.UniqueIDSearch[UniqueID] = adminManagement.UniqueIDSearch[UniqueID] or {}
    adminManagement.UniqueIDSearch[UniqueID].inventory = {}

    local targetPlayer = ReturnPlayerId(UniqueID)

    if targetPlayer then
        exports.ox_inventory:ClearInventory(targetPlayer.id)
        TriggerClientEvent('ox_inventory:disarm', targetPlayer.id, true)
        TriggerClientEvent('esx:showNotification', source, ('Inventaire de %s vidé.'):format(GetPlayerName(targetPlayer.id)))
    else
        MySQL.Async.execute('UPDATE users SET inventory = @inventory WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = UniqueID,
            ['@inventory'] = '[]'
        })
        TriggerClientEvent('esx:showNotification', source, 'Inventaire vidé (joueur hors ligne).')
    end

    for k,v in pairs(adminManagement.Players) do
        if v.group ~= 'user' then
            TriggerClientEvent('sunny:admin:uniqueid:updateInventory', k, json.encode(adminManagement.UniqueIDSearch[UniqueID].inventory))
        end
    end
end)

RegisterNetEvent('sunny:admin:clearWeaponUniqueID', function(UniqueID)
    local source = source
    local xAdmin = ESX.GetPlayerFromId(source)
	if not xAdmin or xAdmin.getGroup() == 'user' then return end

    adminManagement.UniqueIDSearch[UniqueID] = adminManagement.UniqueIDSearch[UniqueID] or {}
    local permanentWeapons = SunnyConfigServ.PermanantWeapon or {}

    local function filterLoadout(loadoutData)
        local decoded = loadoutData
        if type(decoded) == 'string' then
            decoded = json.decode(decoded) or {}
        end
        local kept = {}
        for _, weaponData in pairs(decoded or {}) do
            if weaponData.name and permanentWeapons[string.upper(weaponData.name)] then
                table.insert(kept, weaponData)
            end
        end
        return kept
    end

    local targetPlayer = ReturnPlayerId(UniqueID)

    if targetPlayer then
        local inventoryItems = exports.ox_inventory:GetInventoryItems(targetPlayer.id) or {}
        for slot, item in pairs(inventoryItems) do
            if item and (item.type == 'weapon' or (item.name and item.name:sub(1, 7) == 'weapon_')) then
                local weaponKey = string.upper(item.name or '')
                if not permanentWeapons[weaponKey] then
                    exports.ox_inventory:RemoveItem(targetPlayer.id, item.name, 1, item.metadata, item.slot)
                end
            end
        end
        TriggerClientEvent('ox_inventory:disarm', targetPlayer.id, true)
        adminManagement.UniqueIDSearch[UniqueID].loadout = filterLoadout(adminManagement.UniqueIDSearch[UniqueID].loadout)
        TriggerClientEvent('esx:showNotification', source, ('Armes de %s retirées.'):format(GetPlayerName(targetPlayer.id)))

        for k,v in pairs(adminManagement.Players) do
            if v.group ~= 'user' then
                TriggerClientEvent('sunny:admin:uniqueid:updateLoadout', k, json.encode(adminManagement.UniqueIDSearch[UniqueID].loadout))
            end
        end
    else
        MySQL.Async.fetchScalar('SELECT loadout FROM users WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = UniqueID
        }, function(loadoutJson)
            local filtered = filterLoadout(loadoutJson or '[]')
            MySQL.Async.execute('UPDATE users SET loadout = @loadout WHERE UniqueID = @UniqueID', {
                ['@UniqueID'] = UniqueID,
                ['@loadout'] = json.encode(filtered)
            })
            adminManagement.UniqueIDSearch[UniqueID].loadout = filtered

            for k,v in pairs(adminManagement.Players) do
                if v.group ~= 'user' then
                    TriggerClientEvent('sunny:admin:uniqueid:updateLoadout', k, json.encode(filtered))
                end
            end

            TriggerClientEvent('esx:showNotification', source, 'Armes retirées (joueur hors ligne).')
        end)
    end
end)

RegisterNetEvent('sunny:admin:returnveh', function(veh)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    TriggerClientEvent('sunny:admin:returnveh', -1, veh)
end)

RegisterNetEvent('sunny:admin:getPosForRreturnPlayer', function(target)
    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end 
        local xPlayerB = ESX.GetPlayerFromId(source)
        if xPlayerB.getGroup() == 'user' then return end
        TriggerClientEvent('sunny:admin:returnlasposplayer', k, target, GetEntityCoords(GetPlayerPed(target)))
        
        ::continue::
    end
end)

RegisterNetEvent('sunny:admin:xPlayer.return', function(target, pos)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    TriggerClientEvent('sunny:admin:teleport', target, vector3(pos))
end)

ESX.RegisterServerCallback('sunny:admin:getUniqueIDUnique', function(source, cb, UniqueID)
    local source = source
    adminManagement.UniqueIDSearch[UniqueID] = {}
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {['@UniqueID'] = UniqueID}, function(result)
        if result[1] == nil then return TriggerClientEvent('esx:showNotification', source, '⛔ Impossible de trouver l\'ID Unique') end

        for k,v in pairs(result) do
            local target = ESX.GetPlayerFromIdentifier(v.identifier)

            if target then v.id = target.source v.inventory = json.encode(target.inventory) v.loadout = json.encode(target.loadout) else v.id = nil v.inventory = v.inventory v.loadout = v.loadout end

            if target then v.group = target.group else v.group = v.permission_group end

            if not target then
                if v.accounts == '[]' then v.accounts = { {name = 'cash', money = 0 },  {name = 'bank', money = 0}, {name = 'black_money', money = 0} } else for p,i in pairs(json.decode(v.accounts)) do if i.name == 'cash' then cash = i.money end if i.name == 'bank' then bank = i.money end if i.name == 'black_money' then black_money = i.money end v.accounts = { {name = 'cash', money = cash },   {name = 'bank', money = bank}, {name = 'black_money', money = black_money} } end end
            else
                v.accounts = { {name = 'cash', money = target.getAccount('cash').money}, {name = 'bank', money = target.getAccount('bank').money}, {name = 'black_money', money = target.getAccount('black_money').money} }
            end
            v.isBaned = false
            if banList[v.identifier] == nil then
                v.isBaned = false
            else
                v.isBaned = true
            end
            table.insert(adminManagement.UniqueIDSearch[UniqueID], v)
        end

        cb(adminManagement.UniqueIDSearch[UniqueID])
    end)
end)

RegisterNetEvent('sunny:admin:announce', function(message)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    TriggerClientEvent('txcl:showAnnouncement', -1, message, GetPlayerName(source))
end)

RegisterNetEvent('sunny::admin:restartServer', function(time, auth, message)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    TriggerClientEvent('txAdmin:events:serverShuttingDown', -1, time, auth, message)
end)

RegisterNetEvent('sunny:admin:uniqueid:removeMoney', function(target, targetUID, number, type)
    local source = source    
    local targetPlayer = ESX.GetPlayerFromId(target)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    for k,v in pairs(adminManagement.UniqueIDSearch[targetUID][1].accounts) do

        if v.name == type then
            v.money = v.money - number
        end

        adminManagement.UniqueIDSearch[targetUID][1].accounts[k] = v
    end

    if targetPlayer then
        targetPlayer.removeAccountMoney(type, number)
    else
        MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = targetUID,
            ['@accounts'] = json.encode(adminManagement.UniqueIDSearch[targetUID][1].accounts)
            }, function()
            
        end)
    end

    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end 

        TriggerClientEvent('sunny:admin:uniqueid:updateAccounts', k,  json.encode(adminManagement.UniqueIDSearch[targetUID][1].accounts))

        ::continue::
    end

    TriggerClientEvent('esx:showNotification', source, ('%s on était enlever au joueur avec succès (%s)'):format(number, type))
end)

RegisterNetEvent('sunny:admin:uniqueid:removeItem', function(target, targetUID, number, itemName, inv)
    local source = source    
    local targetPlayer = ESX.GetPlayerFromId(target)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    adminManagement.UniqueIDSearch[targetUID] = adminManagement.UniqueIDSearch[targetUID] or {}

    inv = inv or {}
    local found = false

    for k,v in pairs(inv) do
        if v.name == itemName then
            v.count = (tonumber(v.count) or 0) - number
            if v.count <= 0 then
                table.remove(inv, k)
            end
            found = true
            break
        end
    end

    if not found then
        return TriggerClientEvent('esx:showNotification', source, 'Item introuvable dans le cache.')
    end

    if targetPlayer then
        local removed = exports.ox_inventory:RemoveItem(targetPlayer.source, itemName, number)
        if not removed or removed == 0 then
            return TriggerClientEvent('esx:showNotification', source, "Impossible de retirer l'objet dans l'inventaire du joueur.")
        end
    else
        MySQL.Async.execute('UPDATE users SET inventory = @inventory WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = targetUID,
            ['@inventory'] = json.encode(inv)
        })
    end

    adminManagement.UniqueIDSearch[targetUID].inventory = inv

    for k,v in pairs(adminManagement.Players) do
        if v.group ~= 'user' then
            TriggerClientEvent('sunny:admin:uniqueid:updateInventory', k, json.encode(adminManagement.UniqueIDSearch[targetUID].inventory))
        end
    end

    TriggerClientEvent('esx:showNotification', source, ('%s retiré avec succès (%s)'):format(number, itemName))
end)

RegisterNetEvent('sunny:admin:uniqueid.removeWeapon', function(target, targetUID, weapon, loadout, data)
    local source = source
    local targetPlayer = ESX.GetPlayerFromId(target)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    adminManagement.UniqueIDSearch[targetUID].loadout = loadout

    for k,v in pairs(adminManagement.UniqueIDSearch[targetUID].loadout) do
        if v.name == weapon then
            table.remove(adminManagement.UniqueIDSearch[targetUID].loadout, k)
        end
    end

    if targetPlayer then
        local weaponItemName = string.lower(weapon)
        local inventoryItems = exports.ox_inventory:GetInventoryItems(targetPlayer.source) or {}
        local removedWeapon = false

        for slot, item in pairs(inventoryItems) do
            if item and item.name == weaponItemName then
                local removed = exports.ox_inventory:RemoveItem(targetPlayer.source, item.name, 1, item.metadata, item.slot)
                if removed and removed > 0 then
                    removedWeapon = true
                end
                break
            end
        end

        if not removedWeapon then
            return TriggerClientEvent('esx:showNotification', source, "Impossible de retirer l'arme, introuvable dans l'inventaire.")
        end

        TriggerClientEvent('ox_inventory:disarm', targetPlayer.source, true)
    else
        MySQL.Async.execute('UPDATE users SET loadout = @loadout WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = targetUID,
            ['@loadout'] = json.encode(adminManagement.UniqueIDSearch[targetUID].loadout)
            }, function()
            
        end)
    end

    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end 

        TriggerClientEvent('sunny:admin:uniqueid:updateLoadout', k,  json.encode(adminManagement.UniqueIDSearch[targetUID].loadout))

        ::continue::
    end

    TriggerClientEvent('esx:showNotification', source, ('Arme enlevée avec succès\nLabel de l\'arme: %s\nNom de l\'arme: %s\nMunition: %s'):format(data.label, data.name, data.ammo))
end)

RegisterNetEvent('sunny:admin:events:fireworks:launchDefinedEvent', function(type, pos, pos2, time, tnodef)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    if type == 'Fontaine de feux' then
        TriggerClientEvent('sunny:admin:events:fireworks:startFireworks', -1, 'scr_indep_firework_trail_spawn', pos, pos2, time)
    elseif type == 'Explosion de feux' then
        TriggerClientEvent('sunny:admin:events:fireworks:startFireworks', -1, 'scr_indep_firework_shotburst', pos, pos2, time)
    elseif type == 'Explosion étoile blanche' then
        TriggerClientEvent('sunny:admin:events:fireworks:startFireworks', -1, 'scr_indep_firework_burst_spawn', pos, pos2, time)
    elseif type == 'nodef' then
        TriggerClientEvent('sunny:admin:events:fireworks:startFireworks', -1, tnodef, pos, pos2, time)
    end
end)

RegisterNetEvent('sunny:admin:players:wipe', function(target, targetUID)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    if xPlayerB.getGroup() == 'user' then return end
    if targetUID == 1 then return end

    DropPlayer(target, 'Vous avez été wipe ! Relancez votre client avant de vous reconnecter !')

    Wait(100)

    MySQL.Async.fetchScalar('SELECT identifier FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = targetUID
    }, function(license)
        if license then

            MySQL.Async.fetchScalar('SELECT loadout FROM users WHERE UniqueID = @UniqueID', {
                ['@UniqueID'] = targetUID
            }, function(loadoutJson)
                local loadout = json.decode(loadoutJson or '[]')
                local permanentWeapons = SunnyConfigServ.PermanantWeapon

                local filteredLoadout = {}
                for i = 1, #loadout do
                    local weapon = loadout[i]
                    if permanentWeapons[weapon.name] then
                        table.insert(filteredLoadout, weapon)
                    end
                end

                local filteredLoadoutJson = json.encode(filteredLoadout)

                MySQL.Async.execute('UPDATE users SET permission_group = @permission_group, position = @position, skin = @skin, accounts = @accounts, inventory = @inventory, loadout = @loadout, job = @job, job_grade = @job_grade, job2 = @job2, job2_grade = @job2_grade, firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height, clothes = @clothes WHERE UniqueID = @UniqueID', {
                    ['@UniqueID'] = targetUID,
                    ['@permission_group'] = 'user',
                    ['@position'] = json.encode(vector3(-1044.7137451172, -2749.8737792969, 21.363418579102)),
                    ['@skin'] = nil,
                    ['@accounts'] = '[]',
                    ['@inventory'] = '[]',
                    ['@loadout'] = filteredLoadoutJson, 
                    ['@job'] = 'unemployed',
                    ['@job_grade'] = 0,
                    ['@job2'] = 'unemployed2',
                    ['@job2_grade'] = 0,
                    ['@firstname'] = 'nil',
                    ['@lastname'] = 'nil',
                    ['@dateofbirth'] = 'nil',
                    ['@sex'] = 'nil',
                    ['@height'] = 0,
                    ['@clothes'] = '[]'
                }, function()
                    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
                        ['@owner'] = targetUID
                    }, function(result)
                        for k,v in pairs(result) do
                            if v.boutique == true or v.boutique == 1 then goto continue end

                            MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {['@plate'] = v.plate}, function()
                            end)

                            ::continue::
                        end

                        MySQL.Async.execute('DELETE FROM phone_phones WHERE owner_id = @owner_id', {
                            ['@owner_id'] = license 
                        }, function(affectedRows)
                            MySQL.Async.execute('DELETE FROM playerstattoos WHERE identifier = @identifier', {
                                ['@identifier'] = license
                            }, function(affectedRows)
                                MySQL.Async.execute('DELETE FROM players_props WHERE UniqueID = @UniqueID', {
                                    ['@UniqueID'] = targetUID
                                }, function(affectedRows)
                                    MySQL.Async.execute('DELETE FROM sunny_clothes WHERE identifier = @identifier', {
                                        ['@identifier'] = license
                                    }, function(affectedRows)
                                        MySQL.Async.execute('UPDATE vips SET money = @money WHERE UniqueID = @UniqueID', {
                                            ['@UniqueID'] = targetUID,
                                            ['@money'] = false
                                        }, function()
                                        end)
                                    end)
                                end)
                            end)
                        end)

                        Garages:load()
                    end)
                end)
            end)
        else
            print('License FiveM non trouvée pour l\'utilisateur: ' .. targetUID)
        end
    end)
end)




RegisterNetEvent('sunny:admin:players:wipeUniqueID', function(targetUID)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    local player = ReturnPlayerId(targetUID)

    local newItems, newInventory = {}, {}
    local itemPerm = exports.ArmePerm.GetItemPermFromConfig()

    if player then
        DropPlayer(player.id, 'Vous avez été wipe ! Relancez votre client avant de vous reconnecter !')
    end

    Wait(1000)

    MySQL.Async.fetchAll('SELECT inventory FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = targetUID
    }, function(result)

        local inventaire = result[1].inventory
        local decodedInventory = json.decode(inventaire)

        for i=1, #decodedInventory, 1 do 
            --print(decodedInventory[i].name)
            for k, v in pairs(itemPerm) do 
                if string.upper(decodedInventory[i].name) == string.upper(v) then 
                    table.insert(newItems, {name = decodedInventory[i].name, count = decodedInventory[i].count})
                end
            end
        end

        --print(json.encode(newItems))

    end)

    Wait(5000)

    newInventory = json.encode(newItems)

    print("newInventory", newInventory)


    MySQL.Async.execute('UPDATE users SET permission_group = @permission_group, position = @position, skin = @skin, accounts = @accounts, inventory = @inventory, loadout = @loadout, job = @job, job_grade = @job_grade, job2 = @job2, job2_grade = @job2_grade, firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height, clothes = @clothes WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = targetUID,
        ['@permission_group'] = 'user',
        ['@position'] = json.encode(vector3(-1044.7137451172, -2749.8737792969, 21.363418579102)),
        ['@skin'] = nil,
        ['@accounts'] = '[]',
        ['@inventory'] = newInventory,
        ['@loadout'] = '[]',
        ['@job'] = 'unemployed',
        ['@job_grade'] = 0,
        ['@job2'] = 'unemployed2',
        ['@job2_grade'] = 0,
        ['@firstname'] = 'nil',
        ['@lastname'] = 'nil',
        ['@dateofbirth'] = 'nil',
        ['@sex'] = 'nil',
        ['@height'] = 0,
        ['@clothes'] = '[]'
    }, function()
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
            ['@owner'] = targetUID
        }, function(result)
            for k,v in pairs(result) do
                if v.boutique == true or v.boutique == 1 then goto continue end

                MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {['@plate'] = v.plate}, function()
                    
                end)

                ::continue::
            end


            MySQL.Async.execute('DELETE FROM phone_phones WHERE owner_id = @owner_id', {
                ['@owner_id'] = license 
            }, function(affectedRows)
                MySQL.Async.execute('DELETE FROM playerstattoos WHERE identifier = @identifier', {
                    ['@identifier'] = license
                }, function(affectedRows)
                    MySQL.Async.execute('DELETE FROM players_props WHERE UniqueID = @UniqueID', {
                        ['@UniqueID'] = targetUID
                    }, function(affectedRows)
                        MySQL.Async.execute('DELETE FROM sunny_clothes WHERE identifier = @identifier', {
                            ['@identifier'] = license
                        }, function(affectedRows)
                            MySQL.Async.execute('UPDATE vips SET money = @money WHERE UniqueID = @UniqueID', {
                                ['@UniqueID'] = targetUID,
                                ['@money'] = false
                            }, function()
                            end)
                        end)
                    end)
                end)
            end)

            Garages:load()
        end)
    end)
    Wait(1000)
    print("Wipe Fini")
end)

RegisterNetEvent('sunny:admin:command:heal', function(target)
    local source = source
    local targetPlayer = ESX.GetPlayerFromId(target)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    if targetPlayer then
        TriggerClientEvent('sunny:admin:command:heal', targetPlayer.source)
    else
        TriggerClientEvent('sunny:admin:command:heal', source)
    end
end)

RegisterNetEvent('sunny:staff:players:takeMessage', function(target, message)
    local source = source


    TriggerClientEvent('esx:showNotification', target, ('💬 Message du staff (~y~%s~s~) : %s'):format(GetPlayerName(source), message))
end)

function GetService(src)
    local xPlayer = ESX.GetPlayerFromId(src)

    return adminManagement.Service[xPlayer.UniqueID] or false
end

exports('getService', function(src)
    return GetService(src)
end)

exports('getPlayerWithUniqueID', function(UniqueID)
    return ReturnPlayerId(UniqueID)
end)

ESX.RegisterServerCallback('sunny:admin:uniqueid:boutiquehistory', function(source, cb, UniqueID)
    local source = source
    adminManagement.UniqueIDSearchBoutiqueHistory[UniqueID] = {}
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM boutique_history WHERE uniqueid = @uniqueid', {
        ['@uniqueid'] = UniqueID,
    }, function(result)
        for k,v in pairs(result) do
            table.insert(adminManagement.UniqueIDSearchBoutiqueHistory[UniqueID], v)
        end

        cb(adminManagement.UniqueIDSearchBoutiqueHistory[UniqueID])
    end)
end)

RegisterNetEvent('sunny:admin:spectatePlayer', function(target)
    local source = source
    local player = ReturnPlayerId(target)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    if player then
        TriggerClientEvent('sunny:admin:specPlayerResp', source, player.id, GetEntityCoords(GetPlayerPed(player.id)))
    end
end)

RegisterNetEvent('sunny:admin:UniqueID:giveitem', function(UniqueID, data, itemData, quantity, inventory)
    local source = source
    local staff = ESX.GetPlayerFromId(source)
	if not staff or staff.getGroup() == 'user' then return end
    local targetPlayer = ReturnPlayerId(UniqueID)

    adminManagement.UniqueIDSearch[UniqueID] = adminManagement.UniqueIDSearch[UniqueID] or {}
    local cachedInventory = adminManagement.UniqueIDSearch[UniqueID].inventory
    if type(cachedInventory) == 'string' then
        cachedInventory = json.decode(cachedInventory) or {}
    elseif cachedInventory == nil then
        cachedInventory = {}
    end

    if not targetPlayer then
        data.inventory = json.decode(data.inventory) or {}
        local updated = false

        for k,v in pairs(data.inventory) do
            if v.name == itemData.name then
                data.inventory[k].count = (tonumber(data.inventory[k].count) or 0) + quantity
                updated = true
                break
            end
        end

        if not updated then
                table.insert(data.inventory, {
                    name = itemData.name,
                    label = itemData.label,
                    count = quantity
                })
        end

        MySQL.Async.execute('UPDATE users SET inventory = @inventory WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = UniqueID,
            ['@inventory'] = json.encode(data.inventory)
        })

        cachedInventory = data.inventory
    else
        local player = ESX.GetPlayerFromId(targetPlayer.id)

        if not exports.ox_inventory:CanCarryItem(player.source, itemData.name, quantity) then
            return TriggerClientEvent('esx:showNotification', source, "Le joueur n'a pas assez de place.")
        end

        local added = exports.ox_inventory:AddItem(player.source, itemData.name, quantity)
        if not added then
            return TriggerClientEvent('esx:showNotification', source, "Impossible d'ajouter l'objet.")
        end
    end

    local cacheUpdated = false
    for k,v in pairs(cachedInventory) do
        if v.name == itemData.name then
            cachedInventory[k].count = (tonumber(cachedInventory[k].count) or 0) + quantity
            cacheUpdated = true
            break
        end
    end

    if not cacheUpdated then
        table.insert(cachedInventory, {
            name = itemData.name,
            label = itemData.label,
            count = quantity
        })
    end

    adminManagement.UniqueIDSearch[UniqueID].inventory = cachedInventory

    for k,v in pairs(adminManagement.Players) do
        if v.group ~= 'user' then
            TriggerClientEvent('sunny:admin:uniqueid:updateInventory', k, json.encode(cachedInventory))
        end
    end

    sendLog(('Staff give item (%s - %s) (staff)'):format(staff.name, staff.UniqueID), {
        author = staff.name,
        fields = {
            {title = 'Staff', subtitle = staff.name},
            {title = 'ID Unique', subtitle = staff.UniqueID},
            {title = 'Identifier', subtitle = staff.identifier},
            {title = 'item', subtitle = ('%s'):format(itemData.label)},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_item'
    })
end)

RegisterNetEvent('sunny:admin:uniqueid:giveweapon', function(weapon, UniqueID, label, loadout)
    local source = source
    local staff = ESX.GetPlayerFromId(source)
    local player = ReturnPlayerId(UniqueID)
	if not staff or staff.getGroup() == 'user' then return end
    adminManagement.UniqueIDSearch[UniqueID].loadout = loadout
    table.insert(adminManagement.UniqueIDSearch[UniqueID].loadout, {
        components = {},
        name = weapon,
        label = label,
        ammo = 255
    })
    if not player then
        MySQL.Async.execute('UPDATE users SET loadout = @loadout WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = UniqueID,
            ['@loadout'] = json.encode(adminManagement.UniqueIDSearch[UniqueID].loadout)
        }, function()

        end)
    else
        local targetPlayer = ESX.GetPlayerFromId(player.id)
        local weaponItemName = string.lower(weapon)

        if not exports.ox_inventory:CanCarryItem(targetPlayer.source, weaponItemName, 1) then
            return TriggerClientEvent('esx:showNotification', source, "Le joueur n'a pas assez de place pour l'arme.")
        end

        local added = exports.ox_inventory:AddItem(targetPlayer.source, weaponItemName, 1, {
            ammo = 255,
            durability = 100
        })

        if not added then
            return TriggerClientEvent('esx:showNotification', source, "Impossible d'ajouter l'arme.")
        end

    end

    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end 

        TriggerClientEvent('sunny:admin:uniqueid:updateLoadout', k,  json.encode(adminManagement.UniqueIDSearch[UniqueID].loadout))

        ::continue::
    end
    sendLog(('Staff give arme (%s - %s)  (staff)'):format(staff.name, staff.UniqueID), {
        author = staff.name,
        fields = {
            {title = 'Joueur', subtitle = staff.name},
            {title = 'ID Unique', subtitle = staff.UniqueID},
            {title = 'Identifier', subtitle = staff.identifier},
            {title = 'Arme', subtitle = ('%s'):format(label)},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_weapon'
    })


end)

RegisterNetEvent('sunny:admin:uniqueid:addmoney', function(UniqueID, type, amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = ReturnPlayerId(UniqueID)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    for k,v in pairs(adminManagement.UniqueIDSearch[UniqueID][1].accounts) do
        if adminManagement.UniqueIDSearch[UniqueID][1].accounts[k].name == type then
            adminManagement.UniqueIDSearch[UniqueID][1].accounts[k].money = adminManagement.UniqueIDSearch[UniqueID][1].accounts[k].money + amount
        end
    end

    if not player then
        MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = UniqueID,
            ['@accounts'] = json.encode(adminManagement.UniqueIDSearch[UniqueID][1].accounts)
        }, function()

        end)
    else
        local targetPlayer = ESX.GetPlayerFromId(player.id)
        targetPlayer.addAccountMoney(type, amount)
    end

    for k,v in pairs(adminManagement.Players) do
        if v.group == 'user' then goto continue end 

        TriggerClientEvent('sunny:admin:uniqueid:updateAccounts', k,  json.encode(adminManagement.UniqueIDSearch[UniqueID][1].accounts))

        ::continue::
    end

    sendLog(('Staff give argent (%s - %s)  (staff)'):format(xPlayer.name, xPlayer.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Joueur', subtitle = xPlayer.name},
            {title = 'ID Unique', subtitle = xPlayer.UniqueID},
            {title = 'Identifier', subtitle = xPlayer.identifier},
            {title = 'Argent', subtitle = ('%s'):format(amount)},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_money'
    })
end)

RegisterNetEvent('sunny:admin:warn', function(UniqueID, reason)
    local source = source
    local player = ReturnPlayerId(UniqueID)
    adminManagement.WarnList[UniqueID] = {}
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end
    
    if player then
        TriggerClientEvent('sunny:admin:drawwarn', player.id, reason)
    end

    MySQL.Async.fetchAll('SELECT warns FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = UniqueID
    }, function(result)
        for k, v in pairs(json.decode(result[1].warns)) do
            table.insert(adminManagement.WarnList[UniqueID], v)
        end
        
        table.insert(adminManagement.WarnList[UniqueID], {
            reason = reason,
            author = GetPlayerName(source)
        })

        MySQL.Async.execute('UPDATE users SET warns = @warns WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = UniqueID,
            ['@warns'] = json.encode(adminManagement.WarnList[UniqueID])
        }, function()
            sendLog(('Staff a donné un avertissement (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
                author = xPlayerB.name,
                fields = {
                    {title = 'Joueur', subtitle = player.name},
                    {title = 'ID Unique', subtitle = UniqueID},
                    {title = 'Author', subtitle = GetPlayerName(source)},
                    {title = 'Raison', subtitle = reason},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'staff_warn'
            })
        end)
    end)
end)

ESX.RegisterServerCallback('sunny:admin:getWarnList', function(source, cb, UniqueID)
    local source = source
    adminManagement.WarnList[UniqueID] = {}
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT warns FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = UniqueID
    }, function(result)
        for k,v in pairs(json.decode(result[1].warns)) do
            table.insert(adminManagement.WarnList[UniqueID], v)
        end

        cb(adminManagement.WarnList[UniqueID])
    end)
end)

RegisterNetEvent('sunny:admin:removeWarn', function(UniqueID, k)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end
    
    local player = ReturnPlayerId(UniqueID)
    
    MySQL.Async.fetchAll('SELECT warns FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = UniqueID
    }, function(result)
        local warns = json.decode(result[1].warns)
        
        if warns[k] then
            table.remove(warns, k)
            
            MySQL.Async.execute('UPDATE users SET warns = @warns WHERE UniqueID = @UniqueID', {
                ['@UniqueID'] = UniqueID,
                ['@warns'] = json.encode(warns)
            }, function()
                sendLog(('Staff a supprimé un avertissement (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
                    author = xPlayerB.name,
                    fields = {
                        {title = 'Joueur', subtitle = player.name},
                        {title = 'ID Unique', subtitle = UniqueID},
                        {title = 'Author', subtitle = GetPlayerName(source)},
                        {title = 'Raison', subtitle = warns[k] and warns[k].reason or 'Inconnu'},
                        {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                    },
                    channel = 'staff_remove_warn'
                })
            end)
        end
    end)
    
    adminManagement.WarnList[UniqueID] = {}
end)

function sendLog(message, details)
    for _, field in ipairs(details.fields) do
        print(field.title .. ': ' .. field.subtitle)
    end
end

RegisterNetEvent('sunny:admin:revive', function(UniqueID)
    local source = source
    local player = ReturnPlayerId(UniqueID)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if source ~= 0 then
        if not Config.Staff.HavePermission('ManagePlayers', 'revive', xPlayer) then return end
        if not adminManagement.Service[xPlayer.UniqueID] then return end
    end

    if player then
        TriggerClientEvent('sunny:ambulance:revive', player.id)

        sendLog(('Staff a réanimé un joueur (%s - %s) (staff)'):format(xPlayer.name, xPlayer.UniqueID), {
            author = xPlayer.name,
            fields = {
                {title = 'Joueur', subtitle = player.name},
                {title = 'ID Unique', subtitle = UniqueID},
                {title = 'Author', subtitle = GetPlayerName(source)},
                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
            },
            channel = 'staff_revive'
        })
    else
        sendLog(('Staff a tenté de réanimer un joueur inexistant (%s - %s) (staff)'):format(xPlayer.name, xPlayer.UniqueID), {
            author = xPlayer.name,
            fields = {
                {title = 'Joueur', subtitle = 'Inconnu'},
                {title = 'ID Unique', subtitle = UniqueID},
                {title = 'Author', subtitle = GetPlayerName(source)},
                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
            },
            channel = 'staff_revive'
        })
    end
end)


RegisterNetEvent('sunny:admin:give_vehicle', function(UniqueID, data)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end
    

    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, label, vehicle, plate, type, boutique, garageid) VALUES (@owner, @label, @vehicle, @plate, @type, @boutique, @garageid)', {
        ['@owner'] = UniqueID,
        ['@label'] = data.label,
        ['@vehicle'] = data.vehicle,
        ['@plate'] = data.plate,
        ['@type'] = data.type,
        ['@boutique'] = data.boutique,
        ['@garageid'] = data.garageid
    }, function()
        sendLog(('Staff a donné un véhicule (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
            author = xPlayerB.name,
            fields = {
                {title = 'IdUnique du Joueur', subtitle = UniqueID},
                {title = 'Label', subtitle = data.label},
                {title = 'Véhicule', subtitle = data.vehicle},
                {title = 'Plaque', subtitle = data.plate},
                {title = 'Type', subtitle = data.type},
                {title = 'Boutique', subtitle = data.boutique},
                {title = 'Garage ID', subtitle = data.garageid},
                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
            },
            channel = 'staff_give_vehicle'
        })
        
        Garages:load()
        
        local targetPlayer = ReturnPlayerId(UniqueID)
        if targetPlayer and targetPlayer.id then
            if GetResourceState('nv_keys') == 'started' then
                exports['nv_keys']:GiveKeys(targetPlayer.id, data.plate)
            elseif GetResourceState('ox_inventory') == 'started' then
                exports.ox_inventory:AddItem(targetPlayer.id, 'vehiclekeys', 1, {
                    plate = data.plate,
                    description = ('Clés du véhicule avec la plaque %s'):format(data.plate)
                })
            else
                TriggerClientEvent('sunny:vehicle_dealer:giveKeys', targetPlayer.id, data.plate)
            end
        end
    end)
end)

RegisterNetEvent('sunny:admin:editSociety', function(societyName, newSocietyData)
    local society = Society:getSociety(societyName)
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end
    if not society then return end

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    society.name = newSocietyData.name
    society.label = newSocietyData.label
    society.permissions = newSocietyData.permissions
    society.coffre = newSocietyData.coffre
    society.posCoffre = newSocietyData.posCoffre
    society.posBoss = newSocietyData.posBoss
    society.grades = newSocietyData.grades
    society.employeds = newSocietyData.employeds
    society.state = newSocietyData.state
    society.blips = newSocietyData.blips
    society.cloakroom = newSocietyData.cloakroom
    society.cloakpos = newSocietyData.cloakpos
    society.tax = newSocietyData.tax

    for k,v in pairs(society.grades) do 
    end

    MySQL.Sync.execute('UPDATE society_data SET name = @name, label = @label, permissions = @permissions, coffre = @coffre, blips = @blips, posCoffre = @posCoffre, posBoss = @posBoss, tax = @tax, cloakroom = @cloakroom, cloakpos = @cloakpos WHERE name = @name', {
        ['@name'] = society.name,
        ['@label'] = society.label,
        ['@permissions'] = json.encode(society.permissions),
        ['@coffre'] = json.encode(society.coffre),
        ['@blips'] = json.encode(society.blips),
        ['@posCoffre'] = json.encode(society.posCoffre),
        ['@posBoss'] = json.encode(society.posBoss),
        ['@tax'] = society.tax,
        ['@cloakroom'] = society.cloakroom,
        ['@cloakpos'] = json.encode(society.cloakpos)
    }) 

    for _, grade in ipairs(society.grades) do
        MySQL.Sync.execute('UPDATE job_grades SET label = @label WHERE job_name = @society AND name = @name', {
            ['@name'] = grade.name,
            ['@label'] = grade.label,
            ['@society'] = society.name
        })
    end

    sendLog(('Staff a modifié une société (%s - %s) (staff)'):format(xPlayer.name, xPlayer.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Société', subtitle = societyName},
            {title = 'Nouveau Nom', subtitle = newSocietyData.name},
            {title = 'Nouveau Label', subtitle = newSocietyData.label},
            {title = 'Nouvelles Permissions', subtitle = json.encode(newSocietyData.permissions)},
            {title = 'Nouveau Coffre', subtitle = json.encode(newSocietyData.coffre)},
            {title = 'Nouveaux Blips', subtitle = json.encode(newSocietyData.blips)},
            {title = 'Nouvelle Position Coffre', subtitle = json.encode(newSocietyData.posCoffre)},
            {title = 'Nouvelle Position Boss', subtitle = json.encode(newSocietyData.posBoss)},
            {title = 'Nouvelle Taxe', subtitle = tostring(newSocietyData.tax)},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_edit_society'
    })

    TriggerClientEvent('sunny:society:updateWithSocietyName', societyName, newSocietyData)
    TriggerClientEvent('esx:showNotification', source, 'Société modifiée avec succès')
end)

RegisterNetEvent('sunny:admin:deleteSociety', function(societyName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= 'superadmin' then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas les permissions pour supprimer une société')
        return
    end

    local society = Society:getSociety(societyName)
    if not society then
        TriggerClientEvent('esx:showNotification', source, '~r~Cette société n\'existe pas')
        return
    end

    local societyLabel = society.label

    -- Mettre tous les employés au chômage
    local players = ESX.GetExtendedPlayers('job', societyName)
    for _, player in pairs(players) do
        player.setJob('unemployed', 0)
        TriggerClientEvent('esx:showNotification', player.source, ('~r~La société %s a été supprimée. Vous êtes maintenant au chômage.'):format(societyLabel))
    end

    -- Supprimer de la base de données
    MySQL.Async.execute('DELETE FROM society_data WHERE name = @name', {['@name'] = societyName})
    MySQL.Async.execute('DELETE FROM jobs WHERE name = @name', {['@name'] = societyName})
    MySQL.Async.execute('DELETE FROM job_grades WHERE job_name = @name', {['@name'] = societyName})

    -- Supprimer de la liste en mémoire
    Society.List[societyName] = nil

    -- Notifier tous les clients
    TriggerClientEvent('sunny:society:delete', -1, societyName)

    sendLog(('Staff a supprimé une société (%s - %s) (staff)'):format(xPlayer.name, xPlayer.UniqueID), {
        author = xPlayer.name,
        fields = {
            {title = 'Société supprimée', subtitle = societyName},
            {title = 'Label', subtitle = societyLabel},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'staff_edit_society'
    })
end)

RegisterNetEvent('sunny:admin:updateGrade', function(society, grade, newName, newLabel)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    if not xPlayer then return end
        MySQL.Sync.execute('UPDATE job_grades SET name = @a, SET label = @b WHERE job_name = @society AND WHERE name =', {
            ['@a'] = society.grades[1].name,
            ['@b'] = society.grades[1].label,
            ['@society'] = society.name
        
        })
    TriggerClientEvent('esx:showNotification', source, 'Société supprimé avec succès')
end)

ESX.RegisterServerCallback('sunny:admin:itemsList', function(source, cb, searchTerm)
    local itemsList = {}
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    
    -- Récupérer uniquement les items d'ox_inventory (plus fiable)
    local oxItems = exports.ox_inventory:Items()
    
    if not oxItems or type(oxItems) ~= 'table' then
        return cb({ stashId = nil, itemsList = {}, error = 'Impossible de récupérer les items d\'ox_inventory' })
    end
    
    -- Construire la liste des items depuis ox_inventory uniquement
    -- Les items retournés par ox_inventory:Items() sont déjà valides
    for name, data in pairs(oxItems) do
        if name and data and type(data) == 'table' then
            table.insert(itemsList, {
                name = name,
                label = data.label or name,
                weight = data.weight or 0,
                rare = 0,
                can_remove = 1
            })
        end
    end

    -- Filtrer les items si un terme de recherche est fourni
    if searchTerm and searchTerm ~= '' then
        local filteredItems = {}
        local searchLower = string.lower(searchTerm)
        for _, item in ipairs(itemsList) do
            if item.name then
                local itemNameLower = string.lower(item.name)
                
                -- Ignorer les items qui commencent par des caractères spéciaux (., _, etc.)
                local nameFirstChar = string.sub(itemNameLower, 1, 1)
                
                -- Ignorer si le nom commence par un caractère spécial
                if nameFirstChar ~= '.' and nameFirstChar ~= '_' then
                    -- Chercher uniquement si le NOM COMMENCE par le terme de recherche
                    if string.sub(itemNameLower, 1, #searchLower) == searchLower then
                        table.insert(filteredItems, item)
                    end
                end
            end
        end
        itemsList = filteredItems
    end

    local stashItems = {}
    
    for _, item in ipairs(itemsList) do
        if item.name and oxItems[item.name] then
            table.insert(stashItems, {
                item.name,  -- v[1] = name
                1000,       -- v[2] = count
                {}          -- v[3] = metadata (vide)
            })
        end
    end
    
    if #stashItems == 0 then
        return cb({ stashId = nil, itemsList = {}, error = 'Aucun item valide trouvé' })
    end

    local maxItems = 200
    if #stashItems > maxItems then
        local limitedItems = {}
        for i = 1, maxItems do
            table.insert(limitedItems, stashItems[i])
        end
        stashItems = limitedItems
    end

    local success, result = pcall(function()
        return exports.ox_inventory:CreateTemporaryStash({
            label = searchTerm and ('Items Admin - ' .. searchTerm) or 'Items Admin',
            slots = math.max(#stashItems, 50),
            maxWeight = 1000000,
            items = stashItems
        })
    end)
    
    if not success then
        return cb({ stashId = nil, itemsList = itemsList, error = 'Erreur lors de la création du stash: ' .. tostring(result) })
    end
    
    if not result then
        return cb({ stashId = nil, itemsList = itemsList, error = 'Erreur: le stash n\'a pas pu être créé' })
    end

    cb({ stashId = result, itemsList = itemsList })
end)

local adminStashes = {} -- { stashId = { source = adminId, targetUniqueID = uniqueID, targetData = data } }

RegisterNetEvent('sunny:admin:setStashTarget', function(stashId, targetUniqueID, targetData)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end
    
    adminStashes[stashId] = {
        source = source,
        targetUniqueID = targetUniqueID,
        targetData = targetData
    }
end)

-- Hook ox_inventory pour intercepter les mouvements depuis le stash admin
exports('registerHook', 'moveItem', function(payload)
    local stashId = payload.fromInventory and tostring(payload.fromInventory)
    
    if stashId and adminStashes[stashId] then
        local stashInfo = adminStashes[stashId]
        local item = payload.fromSlot
        
        if item and item.name then
            -- Trouver le joueur cible par UniqueID
            local targetPlayer = nil
            for _, playerId in ipairs(GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
                if xPlayer and xPlayer.UniqueID == stashInfo.targetUniqueID then
                    targetPlayer = xPlayer
                    break
                end
            end
            
            if targetPlayer then
                local quantity = payload.count or 1
                
                if exports.ox_inventory:CanCarryItem(targetPlayer.source, item.name, quantity) then
                    exports.ox_inventory:AddItem(targetPlayer.source, item.name, quantity, item.metadata)
                    
                    TriggerClientEvent('esx:showNotification', stashInfo.source, 
                        ('~g~Item donné: %sx %s à %s'):format(quantity, item.label or item.name, stashInfo.targetData.name or 'Joueur'))
                    
                    TriggerClientEvent('esx:showNotification', targetPlayer.source, 
                        ('~g~Vous avez reçu: %sx %s'):format(quantity, item.label or item.name))
                    
                    local staff = ESX.GetPlayerFromId(stashInfo.source)
                    sendLog(('Staff give item (%s - %s) (staff)'):format(staff.name, staff.UniqueID), {
                        author = staff.name,
                        fields = {
                            {title = 'Staff', subtitle = staff.name},
                            {title = 'ID Unique', subtitle = staff.UniqueID},
                            {title = 'Identifier', subtitle = staff.identifier},
                            {title = 'item', subtitle = ('%sx %s'):format(quantity, item.label or item.name)},
                            {title = "Discord", subtitle = ESX.GetIdentifierFromId(stashInfo.source, "discord:")},
                        },
                        channel = 'staff_item'
                    })
                else
                    TriggerClientEvent('esx:showNotification', stashInfo.source, 
                        '~r~Le joueur n\'a pas assez de place.')
                end
                
                return false
            end
        end
    end
    
    return true
end, {
    inventoryFilter = { 'temp' }
})

ESX.RegisterServerCallback('sunny:admin:getSanctions', function(source, cb)
    local source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    if not xPlayer then return end

    adminManagement.sanctionsList[xPlayer.UniqueID] = {}

    --@todo GET SANCTIONS LIST
end)

ESX.RegisterServerCallback('sunny:admin:uniqueid.addWeaponCompenent:playerConnected', function(source, player, playerrr, weaponName, hash)
    local xPlayer = ESX.GetPlayerFromId(playerrr)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end

    if not xPlayer then return end

    xPlayer.addWeaponComponent(weaponName, hash)

    for k,v in pairs(xPlayer.loadout) do
        if v.name == weaponName then
            cb(v.component)
        end
    end
end)

ESX.RegisterServerCallback('sunny:admin:dealership:refreshvehicleslist', function(source, cb)
    local dealership_vehicles = {}
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    local re = false

    MySQL.Async.fetchAll('SELECT * FROM vehicules', {}, function(result)
        for k,v in pairs(result) do
            dealership_vehicles[v.id] = v
        end

        re = true
    end)

    while re == false do Wait(1) end

    cb(dealership_vehicles)
end)

ESX.RegisterServerCallback('sunny:staff:vehicles:concess:catégories:fetch', function(source, cb)
    local vehicle_categorie = {}
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    MySQL.Async.fetchAll('SELECT * FROM moto_categories', {}, function(result)
        for k,v in pairs(result) do
            v.enable = false
            table.insert(vehicle_categorie, v)
        end
    end)
    MySQL.Async.fetchAll('SELECT * FROM boat_categories', {}, function(result)
        for k,v in pairs(result) do
            v.enable = false
            table.insert(vehicle_categorie, v)
        end

    end)
    MySQL.Async.fetchAll('SELECT * FROM aircraft_categorie', {}, function(result)
        for k,v in pairs(result) do
            v.enable = false
            table.insert(vehicle_categorie, v)
        end


    end)
    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
        for k,v in pairs(result) do
            v.enable = false
            table.insert(vehicle_categorie, v)
        end

    end)

    while json.encode(vehicle_categorie) == "[]" do Wait(1) end

    cb(vehicle_categorie)
end)

RegisterNetEvent('sunny:staff:vehicles:concess:addVehicle', function(data, categorie)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)

    if xPlayerB.getGroup() == 'user' then return end

    local jobs = {
        ['motorcycles'] = "motodealer",
        ['boat'] = 'boatdealer',
        ['aircraft'] = "airdealer"
    }
    
    MySQL.Async.execute('INSERT INTO vehicules (job, name, model, price, category) VALUES (@job, @name, @model, @price, @category)', {
        ['@job'] = jobs[categorie] or "cardealer",
        ['@name'] = data.label,
        ['@model'] = data.spawnName,
        ['@price'] = data.price,
        ['@category'] = categorie
    }, function()
        TriggerClientEvent('esx:showNotification', source, 'Véhicule ajouté avec succès')

        sendLog(('Staff a ajouté un véhicule au concess (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
            author = xPlayerB.name,
            fields = {
                {title = 'Nom du Véhicule', subtitle = data.label},
                {title = 'Modèle', subtitle = data.spawnName},
                {title = 'Prix', subtitle = tostring(data.price)},
                {title = 'Catégorie', subtitle = categorie},
                {title = 'Job', subtitle = jobs[categorie] or "cardealer"},
                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
            },
            channel = 'staff_add_vehicle_concess'
        })
    end)
end)

RegisterNetEvent('sunny:staff:vehicles:concess:deleteVehicle', function(id)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end

    MySQL.Async.execute('DELETE FROM vehicules WHERE id = @id', {
        ['@id'] = id
    }, function()
            TriggerClientEvent('esx:showNotification', source, 'Véhicule supprimé avec succès')
            
            sendLog(('Staff a supprimé un véhicule (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
                author = xPlayerB.name,
                fields = {
                    {title = 'ID du Véhicule', subtitle = tostring(id)},
                    {title = 'Author', subtitle = GetPlayerName(source)},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'staff_delete_vehicle'
            })

    end)
end)

RegisterNetEvent('sunny:staff:vehicles:concess:changeCategory', function(id, name)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end

    MySQL.Async.execute('UPDATE vehicules SET category = @category WHERE id = @id', {
        ['@id'] = id,
        ['@category'] = name,
    }, function()
            TriggerClientEvent('esx:showNotification', source, 'Catégorie du véhicule mise à jour avec succès')

            sendLog(('Staff a changé la catégorie d\'un véhicule (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
                author = xPlayerB.name,
                fields = {
                    {title = 'ID du Véhicule', subtitle = tostring(id)},
                    {title = 'Nouvelle Catégorie', subtitle = name},
                    {title = 'Author', subtitle = GetPlayerName(source)},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'staff_change_vehicle_category'
            })

    end)
end)

RegisterNetEvent('sunny:staff:vehicles:concess:changePrice', function(id, price)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end

    MySQL.Async.execute('UPDATE vehicules SET price = @price WHERE id = @id', {
        ['@id'] = id,
        ['@price'] = price,
    }, function()
            TriggerClientEvent('esx:showNotification', source, 'Prix du véhicule mis à jour avec succès')

            sendLog(('Staff a changé le prix d\'un véhicule (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.identifier), {
                author = xPlayerB.name,
                fields = {
                    {title = 'ID du Véhicule', subtitle = tostring(id)},
                    {title = 'Nouveau Prix', subtitle = tostring(price)},
                    {title = 'Author', subtitle = GetPlayerName(source)},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'staff_change_vehicle_price'
            })
    end)
end)

RegisterNetEvent('sunny:admin:giveBoutiqueCoins')
AddEventHandler('sunny:admin:giveBoutiqueCoins', function(uniqueID, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() == 'fondateur' then
        local success, newAmount = exports['nv_boutique']:giveBoutiqueCoins(uniqueID, count)
    end
end)

ESX.RegisterServerCallback('sunny:staff:vehicles:concess:searchCategory', function(source, cb, type)
    local xPlayerB = ESX.GetPlayerFromId(source)
	if xPlayerB.getGroup() == 'user' then return end
    local return_result = {}
    local c = false
    MySQL.Async.fetchAll(('SELECT * FROM %s'):format(type), {}, function(result)
        for k,v in pairs(result) do
            table.insert(return_result, v)
        end

        c = true
    end)

    while not c do Wait(1) end

    cb(return_result)
end)

RegisterNetEvent('sunny:staff:vehicles:concess:categories:add', function(category, data)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end

    MySQL.Async.execute(('INSERT INTO %s (name, label) VALUES (@name, @label)'):format(category), {
        ['@name'] = data.name,
        ['@label'] = data.label,
    }, function()
            TriggerClientEvent('esx:showNotification', source, 'Catégorie ajoutée avec succès')

            sendLog(('Staff a ajouté une nouvelle catégorie de véhicules (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
                author = xPlayerB.name,
                fields = {
                    {title = 'Nom', subtitle = data.name},
                    {title = 'Label', subtitle = data.label},
                    {title = 'Catégorie', subtitle = category},
                    {title = 'Author', subtitle = GetPlayerName(source)},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'staff_add_vehicle_category'
            })

    end)
end)


RegisterNetEvent('sunny:staff:vehicles:concess:categories:delete', function(type, name)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end

    MySQL.Async.execute(('DELETE FROM %s WHERE name = @name'):format(type), {
        ['@name'] = name,
    }, function()
            TriggerClientEvent('esx:showNotification', source, 'Catégorie supprimée avec succès')

            sendLog(('Staff a supprimé une catégorie de véhicules (%s - %s) (staff)'):format(xPlayerB.name, xPlayerB.UniqueID), {
                author = xPlayerB.name,
                fields = {
                    {title = 'Nom', subtitle = name},
                    {title = 'Type', subtitle = type},
                    {title = 'Author', subtitle = GetPlayerName(source)},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'staff_delete_vehicle_category'
            })

    end)
end)


CreateThread(function()
    Wait(10000)

end)


RegisterServerEvent("Sunny:staff:changeGrade")
AddEventHandler("Sunny:staff:changeGrade", function(playerName, newGrade)
    local source = source
    local xPlayerB = ESX.GetPlayerFromId(source)
    
    if xPlayerB.getGroup() == 'user' then return end

    local isValidGrade = false
    for _, grade in ipairs(grades) do
        if grade.name == newGrade then
            isValidGrade = true
            break
        end
    end

    if not isValidGrade then
        return
    end

    MySQL.Async.execute("UPDATE users SET permission_group = @newGrade WHERE playerName = @playerName", {
        ['@newGrade'] = newGrade,
        ['@playerName'] = playerName
    }, function()

            sendLog(('Staff a changé le grade de %s en %s (staff)'):format(playerName, newGrade), {
                author = xPlayerB.name,
                fields = {
                    {title = 'Joueur', subtitle = playerName},
                    {title = 'Nouveau Grade', subtitle = newGrade},
                    {title = 'Author', subtitle = GetPlayerName(source)},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'staff_change_player_grade'
            })

    end)
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- GESTION ARMURERIES
-- ═══════════════════════════════════════════════════════════════════════════

ESX.RegisterServerCallback('sunny:admin:armureries:getAll', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return callback({}) end

    MySQL.Async.fetchAll("SELECT * FROM admin_armureries ORDER BY id ASC", {}, function(result)
        callback(result or {})
    end)
end)

ESX.RegisterServerCallback('sunny:admin:armureries:getItems', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return callback({}) end

    MySQL.Async.fetchAll("SELECT * FROM admin_armureries_items ORDER BY id ASC", {}, function(result)
        callback(result or {})
    end)
end)

RegisterNetEvent('sunny:admin:armureries:create')
AddEventHandler('sunny:admin:armureries:create', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.insert("INSERT INTO admin_armureries (label, x, y, z, blip_id, blip_color, blip_scale) VALUES (@label, @x, @y, @z, @blip_id, @blip_color, @blip_scale)", {
        ['@label'] = data.label,
        ['@x'] = data.x,
        ['@y'] = data.y,
        ['@z'] = data.z,
        ['@blip_id'] = data.blip_id or 110,
        ['@blip_color'] = data.blip_color or 1,
        ['@blip_scale'] = data.blip_scale or 0.7,
    })

    sendLog(('Armurerie créée: %s'):format(data.label), {
        author = xPlayer.name,
        fields = {
            {title = 'Label', subtitle = data.label},
            {title = 'Position', subtitle = ('%s, %s, %s'):format(data.x, data.y, data.z)},
            {title = 'Author', subtitle = GetPlayerName(source)},
        },
        channel = 'staff_armurerie'
    })
end)

RegisterNetEvent('sunny:admin:armureries:updateLabel')
AddEventHandler('sunny:admin:armureries:updateLabel', function(id, label)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("UPDATE admin_armureries SET label = @label WHERE id = @id", {
        ['@id'] = id,
        ['@label'] = label,
    })
end)

RegisterNetEvent('sunny:admin:armureries:updatePosition')
AddEventHandler('sunny:admin:armureries:updatePosition', function(id, x, y, z)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("UPDATE admin_armureries SET x = @x, y = @y, z = @z WHERE id = @id", {
        ['@id'] = id,
        ['@x'] = x,
        ['@y'] = y,
        ['@z'] = z,
    })
end)

RegisterNetEvent('sunny:admin:armureries:updateBlip')
AddEventHandler('sunny:admin:armureries:updateBlip', function(id, field, value)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    if field ~= 'blip_id' and field ~= 'blip_color' and field ~= 'blip_scale' then return end

    MySQL.Async.execute("UPDATE admin_armureries SET " .. field .. " = @value WHERE id = @id", {
        ['@id'] = id,
        ['@value'] = value,
    })
end)

RegisterNetEvent('sunny:admin:armureries:delete')
AddEventHandler('sunny:admin:armureries:delete', function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("DELETE FROM admin_armureries WHERE id = @id", {
        ['@id'] = id,
    })

    sendLog(('Armurerie supprimée: ID %s'):format(id), {
        author = xPlayer.name,
        fields = {
            {title = 'ID', subtitle = tostring(id)},
            {title = 'Author', subtitle = GetPlayerName(source)},
        },
        channel = 'staff_armurerie'
    })
end)

RegisterNetEvent('sunny:admin:armureries:addItem')
AddEventHandler('sunny:admin:armureries:addItem', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.insert("INSERT INTO admin_armureries_items (label, name, price, category) VALUES (@label, @name, @price, @category)", {
        ['@label'] = data.label,
        ['@name'] = data.name,
        ['@price'] = data.price,
        ['@category'] = data.category or 'armes',
    })
end)

RegisterNetEvent('sunny:admin:armureries:updateItem')
AddEventHandler('sunny:admin:armureries:updateItem', function(id, field, value)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    if field ~= 'label' and field ~= 'name' and field ~= 'price' and field ~= 'category' then return end

    MySQL.Async.execute("UPDATE admin_armureries_items SET " .. field .. " = @value WHERE id = @id", {
        ['@id'] = id,
        ['@value'] = value,
    })
end)

RegisterNetEvent('sunny:admin:armureries:deleteItem')
AddEventHandler('sunny:admin:armureries:deleteItem', function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("DELETE FROM admin_armureries_items WHERE id = @id", {
        ['@id'] = id,
    })
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- GESTION SUPERETTES
-- ═══════════════════════════════════════════════════════════════════════════

ESX.RegisterServerCallback('sunny:admin:superettes:getAll', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return callback({}) end

    MySQL.Async.fetchAll("SELECT * FROM admin_superettes ORDER BY id ASC", {}, function(result)
        callback(result or {})
    end)
end)

ESX.RegisterServerCallback('sunny:admin:superettes:getItems', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return callback({}) end

    MySQL.Async.fetchAll("SELECT * FROM admin_superettes_items ORDER BY id ASC", {}, function(result)
        callback(result or {})
    end)
end)

RegisterNetEvent('sunny:admin:superettes:create')
AddEventHandler('sunny:admin:superettes:create', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.insert("INSERT INTO admin_superettes (label, x, y, z, blip_id, blip_color, blip_scale) VALUES (@label, @x, @y, @z, @blip_id, @blip_color, @blip_scale)", {
        ['@label'] = data.label,
        ['@x'] = data.x,
        ['@y'] = data.y,
        ['@z'] = data.z,
        ['@blip_id'] = data.blip_id or 52,
        ['@blip_color'] = data.blip_color or 2,
        ['@blip_scale'] = data.blip_scale or 0.7,
    })

    sendLog(('Supérette créée: %s'):format(data.label), {
        author = xPlayer.name,
        fields = {
            {title = 'Label', subtitle = data.label},
            {title = 'Position', subtitle = ('%s, %s, %s'):format(data.x, data.y, data.z)},
            {title = 'Author', subtitle = GetPlayerName(source)},
        },
        channel = 'staff_superette'
    })
end)

RegisterNetEvent('sunny:admin:superettes:updateLabel')
AddEventHandler('sunny:admin:superettes:updateLabel', function(id, label)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("UPDATE admin_superettes SET label = @label WHERE id = @id", {
        ['@id'] = id,
        ['@label'] = label,
    })
end)

RegisterNetEvent('sunny:admin:superettes:updatePosition')
AddEventHandler('sunny:admin:superettes:updatePosition', function(id, x, y, z)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("UPDATE admin_superettes SET x = @x, y = @y, z = @z WHERE id = @id", {
        ['@id'] = id,
        ['@x'] = x,
        ['@y'] = y,
        ['@z'] = z,
    })
end)

RegisterNetEvent('sunny:admin:superettes:updateBlip')
AddEventHandler('sunny:admin:superettes:updateBlip', function(id, field, value)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    if field ~= 'blip_id' and field ~= 'blip_color' and field ~= 'blip_scale' then return end

    MySQL.Async.execute("UPDATE admin_superettes SET " .. field .. " = @value WHERE id = @id", {
        ['@id'] = id,
        ['@value'] = value,
    })
end)

RegisterNetEvent('sunny:admin:superettes:delete')
AddEventHandler('sunny:admin:superettes:delete', function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("DELETE FROM admin_superettes WHERE id = @id", {
        ['@id'] = id,
    })

    sendLog(('Supérette supprimée: ID %s'):format(id), {
        author = xPlayer.name,
        fields = {
            {title = 'ID', subtitle = tostring(id)},
            {title = 'Author', subtitle = GetPlayerName(source)},
        },
        channel = 'staff_superette'
    })
end)

RegisterNetEvent('sunny:admin:superettes:addItem')
AddEventHandler('sunny:admin:superettes:addItem', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.insert("INSERT INTO admin_superettes_items (label, name, price, category) VALUES (@label, @name, @price, @category)", {
        ['@label'] = data.label,
        ['@name'] = data.name,
        ['@price'] = data.price,
        ['@category'] = data.category or 'food',
    })
end)

RegisterNetEvent('sunny:admin:superettes:updateItem')
AddEventHandler('sunny:admin:superettes:updateItem', function(id, field, value)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    if field ~= 'label' and field ~= 'name' and field ~= 'price' and field ~= 'category' then return end

    MySQL.Async.execute("UPDATE admin_superettes_items SET " .. field .. " = @value WHERE id = @id", {
        ['@id'] = id,
        ['@value'] = value,
    })
end)

RegisterNetEvent('sunny:admin:superettes:deleteItem')
AddEventHandler('sunny:admin:superettes:deleteItem', function(id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("DELETE FROM admin_superettes_items WHERE id = @id", {
        ['@id'] = id,
    })
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- GESTION TELEPHONES AVANCEE
-- ═══════════════════════════════════════════════════════════════════════════

ESX.RegisterServerCallback('sunny:admin:phones:getAll', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return callback({}) end

    MySQL.Async.fetchAll("SELECT pp.*, u.playerName, u.UniqueID FROM phone_phones pp LEFT JOIN users u ON pp.id = u.identifier ORDER BY pp.phone_number ASC", {}, function(result)
        callback(result or {})
    end)
end)

RegisterNetEvent('sunny:admin:phones:updateNumber')
AddEventHandler('sunny:admin:phones:updateNumber', function(oldNumber, newNumber)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.execute("UPDATE phone_phones SET phone_number = @newNumber WHERE phone_number = @oldNumber", {
        ['@oldNumber'] = oldNumber,
        ['@newNumber'] = newNumber,
    })

    sendLog(('Numéro modifié: %s -> %s'):format(oldNumber, newNumber), {
        author = xPlayer.name,
        fields = {
            {title = 'Ancien numéro', subtitle = oldNumber},
            {title = 'Nouveau numéro', subtitle = newNumber},
            {title = 'Author', subtitle = GetPlayerName(source)},
        },
        channel = 'staff_phone'
    })
end)

RegisterNetEvent('sunny:admin:phones:changeOwner')
AddEventHandler('sunny:admin:phones:changeOwner', function(phoneNumber, newUniqueId)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return end

    MySQL.Async.fetchScalar("SELECT identifier FROM users WHERE UniqueID = @uniqueId", {
        ['@uniqueId'] = newUniqueId,
    }, function(identifier)
        if not identifier then
            TriggerClientEvent('esx:showNotification', source, '~r~ID Unique non trouvé')
            return
        end

        MySQL.Async.execute("UPDATE phone_phones SET id = @identifier WHERE phone_number = @phoneNumber", {
            ['@identifier'] = identifier,
            ['@phoneNumber'] = phoneNumber,
        })

        sendLog(('Propriétaire téléphone changé: %s -> UniqueID %s'):format(phoneNumber, newUniqueId), {
            author = xPlayer.name,
            fields = {
                {title = 'Numéro', subtitle = phoneNumber},
                {title = 'Nouveau propriétaire (UniqueID)', subtitle = tostring(newUniqueId)},
                {title = 'Author', subtitle = GetPlayerName(source)},
            },
            channel = 'staff_phone'
        })

        TriggerClientEvent('esx:showNotification', source, '~g~Propriétaire modifié')
    end)
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- GESTION STAFF - GRADES ET PERMISSIONS
-- ═══════════════════════════════════════════════════════════════════════════

ESX.RegisterServerCallback('sunny:admin:staff:getGrades', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return callback({}) end

    MySQL.Async.fetchAll("SELECT * FROM admin_staff_grades ORDER BY priority DESC", {}, function(result)
        callback(result or {})
    end)
end)

ESX.RegisterServerCallback('sunny:admin:staff:getPermissions', function(source, callback, gradeName)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() == 'user' then return callback({}) end

    MySQL.Async.fetchAll("SELECT * FROM admin_staff_permissions WHERE grade_name = @grade", {
        ['@grade'] = gradeName
    }, function(result)
        callback(result or {})
    end)
end)

RegisterNetEvent('sunny:admin:staff:createGrade')
AddEventHandler('sunny:admin:staff:createGrade', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() ~= 'fondateur' then return end

    MySQL.Async.insert("INSERT INTO admin_staff_grades (name, label, color, priority) VALUES (@name, @label, @color, @priority)", {
        ['@name'] = data.name,
        ['@label'] = data.label,
        ['@color'] = data.color or '#ffffff',
        ['@priority'] = data.priority or 1,
    })

    sendLog(('Grade staff créé: %s'):format(data.name), {
        author = xPlayer.name,
        fields = {
            {title = 'Nom', subtitle = data.name},
            {title = 'Label', subtitle = data.label},
            {title = 'Couleur', subtitle = data.color or '#ffffff'},
            {title = 'Author', subtitle = GetPlayerName(source)},
        },
        channel = 'staff_grades'
    })
end)

RegisterNetEvent('sunny:admin:staff:updateGrade')
AddEventHandler('sunny:admin:staff:updateGrade', function(gradeName, field, value)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() ~= 'fondateur' then return end

    if field ~= 'label' and field ~= 'color' and field ~= 'priority' then return end

    MySQL.Async.execute("UPDATE admin_staff_grades SET " .. field .. " = @value WHERE name = @name", {
        ['@name'] = gradeName,
        ['@value'] = value,
    })
end)

RegisterNetEvent('sunny:admin:staff:deleteGrade')
AddEventHandler('sunny:admin:staff:deleteGrade', function(gradeName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() ~= 'fondateur' then return end

    if gradeName == 'fondateur' or gradeName == 'user' then return end

    MySQL.Async.execute("DELETE FROM admin_staff_grades WHERE name = @name", {
        ['@name'] = gradeName,
    })

    MySQL.Async.execute("DELETE FROM admin_staff_permissions WHERE grade_name = @name", {
        ['@name'] = gradeName,
    })

    sendLog(('Grade staff supprimé: %s'):format(gradeName), {
        author = xPlayer.name,
        fields = {
            {title = 'Grade', subtitle = gradeName},
            {title = 'Author', subtitle = GetPlayerName(source)},
        },
        channel = 'staff_grades'
    })
end)

RegisterNetEvent('sunny:admin:staff:setPermission')
AddEventHandler('sunny:admin:staff:setPermission', function(gradeName, permissionName, enabled)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() ~= 'fondateur' then return end

    MySQL.Async.fetchScalar("SELECT id FROM admin_staff_permissions WHERE grade_name = @grade AND permission = @perm", {
        ['@grade'] = gradeName,
        ['@perm'] = permissionName,
    }, function(existingId)
        if existingId then
            MySQL.Async.execute("UPDATE admin_staff_permissions SET enabled = @enabled WHERE id = @id", {
                ['@id'] = existingId,
                ['@enabled'] = enabled and 1 or 0,
            })
        else
            MySQL.Async.insert("INSERT INTO admin_staff_permissions (grade_name, permission, enabled) VALUES (@grade, @perm, @enabled)", {
                ['@grade'] = gradeName,
                ['@perm'] = permissionName,
                ['@enabled'] = enabled and 1 or 0,
            })
        end
    end)
end)
