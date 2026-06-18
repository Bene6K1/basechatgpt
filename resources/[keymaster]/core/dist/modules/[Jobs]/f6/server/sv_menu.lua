local Jobs = {
    "boite_pacific", "boite_unicorn", "boite_wiwang",
    "bar_tequila", "bar_beachclub",
    "restau_burgershot", "restau_pearls", "restau_pops", "restau_catcafe"
}

local BusinessTypes = {
    clubs = {
        ["boite_pacific"] = "Pacific Bluffs",
        ["boite_unicorn"] = "Unicorn",
        ["boite_wiwang"] = "WiWang",
        ["bar_tequila"] = "WiWang",
        ["bar_beachclub"] = "WiWang",
        ["restau_catcafe"] = "Burgershot",
        ["restau_burgershot"] = "Burgershot",
        ["restau_pearls"] = "Pearls",
        ["restau_pops"] = "Pop's Diner"
    }
}

FARM = {
    inService = {},
    companyStatus = {}
}

for _, job in ipairs(Jobs) do
    FARM.inService[job] = {}
    FARM.companyStatus[job] = false
end

local function SendBusinessAnnouncement(jobName, message, icon)
    local xPlayers = ESX.GetExtendedPlayers()
    local businessName = BusinessTypes.clubs[jobName] or jobName:gsub("_", " "):gsub("^%l", string.upper)
    
    for _, xPlayer in pairs(xPlayers) do
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 
            businessName, 
            'Annonce', 
            message, 
            icon or 'CHAR_CHAT_CALL', 
            8
        )
    end
end

RegisterNetEvent('business:Announce', function(jobName, type, customMessage)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.job.name ~= jobName then return end
    if BusinessTypes.clubs[jobName] then
        if type == "open" then
            SendBusinessAnnouncement(xPlayer.job.label, "Le club est désormais ~g~Ouvert~s~ !", 'CHAR_TONY')
        elseif type == "close" then
            SendBusinessAnnouncement(xPlayer.job.label, "Le club est désormais ~r~Fermé~s~ !", 'CHAR_TONY')
        elseif type == "party" then
            SendBusinessAnnouncement(xPlayer.job.label, customMessage, 'CHAR_TONY')
        elseif type == "custom" then
            SendBusinessAnnouncement(xPlayer.job.label, customMessage)
        end
    else
        if type == "open" then
            SendBusinessAnnouncement(xPlayer.job.label, "L'entreprise est désormais ~g~Ouverte~s~ !")
        elseif type == "close" then
            SendBusinessAnnouncement(xPlayer.job.label, "L'entreprise est désormais ~r~Fermée~s~ !")
        elseif type == "custom" then
            SendBusinessAnnouncement(xPlayer.job.label, customMessage)
        end
    end
end)

RegisterNetEvent('sunny:jobs:updateSocietyStatus', function(status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then 
        return 
    end
    
    local jobName = xPlayer.job.name
    
    local isValidJob = false
    for _, job in ipairs(Jobs) do
        if job == jobName then
            isValidJob = true
            break
        end
    end
    
    if not isValidJob then
        return
    end
    
    FARM.companyStatus[jobName] = status
    
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
        TriggerClientEvent('sunny:society:setSocietyState', xPlayers[i].source, jobName, status)
    end
end)

RegisterNetEvent('sunny:FARM:service', function(jobName)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.job.name ~= jobName then return end

    -- Initialiser la table du job si elle n'existe pas
    if not FARM.inService[jobName] then
        FARM.inService[jobName] = {}
    end

    local isJoining = not FARM.inService[jobName][xPlayer.identifier]
    FARM.inService[jobName][xPlayer.identifier] = isJoining or nil
    
    local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
    local message = ('L\'employé ~y~%s~s~ a %s son service'):format(
        rpName, 
        isJoining and "pris" or "fini"
    )
    
    for id, _ in pairs(FARM.inService[jobName]) do
        local targetPlayer = ESX.GetPlayerFromIdentifier(id)
        if targetPlayer and targetPlayer.job.name == jobName then
            TriggerClientEvent('esx:showNotification', targetPlayer.source, message)
        end
    end
end)

AddEventHandler('playerDropped', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    
    for _, job in ipairs(Jobs) do
        if FARM.inService[job] and FARM.inService[job][xPlayer.identifier] then
            FARM.inService[job][xPlayer.identifier] = nil
            break
        end
    end
end)
