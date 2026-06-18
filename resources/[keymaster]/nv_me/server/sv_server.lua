local isMessageActive = false

RegisterCommand("me", function(source, args)
    if isMessageActive then
        return
    end

    isMessageActive = true

    local message = table.concat(args, " ")

    if message and message ~= "" then
        if Config.Debug then
            print(string.format("Player %d used /me: %s", source, message))
        end

        TriggerClientEvent("displayMe", -1, source, message)
    end

    Citizen.CreateThread(function()
        Wait(Config.MessageTime or 5000)
        isMessageActive = false
    end)
end)

-- Event pour permettre aux autres scripts de déclencher un /me programmatiquement
RegisterNetEvent('nv_me:triggerMe', function(message)
    local source = source
    if not message or message == "" then return end

    if Config.Debug then
        print(string.format("Player %d triggered /me via event: %s", source, message))
    end

    TriggerClientEvent("displayMe", -1, source, message)
end)

-- Export pour permettre aux scripts serveur de déclencher un /me
exports('TriggerMe', function(source, message)
    if not source or not message or message == "" then return end

    if Config.Debug then
        print(string.format("Player %d triggered /me via export: %s", source, message))
    end

    TriggerClientEvent("displayMe", -1, source, message)
end)

