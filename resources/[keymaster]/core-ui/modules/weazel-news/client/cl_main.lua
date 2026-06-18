function ShowWeazelNotification(title, description, ticker)
    SendNUIMessage({
        type = "showNotification",
        title = title or "BREAKING NEWS",
        description = description or "",
        ticker = ticker or "WEAZEL NEWS - Breaking News"
    })
end

function OpenWeazelNewsMenu()
    local input = lib.inputDialog('Weazel News', {
        {
            type = 'input',
            label = 'Titre',
            placeholder = 'Entrez le titre...',
            required = true
        },
        {
            type = 'input',
            label = 'Description',
            placeholder = 'Entrez la description...',
            required = true
        }
    })

    if not input then return false end

    local title = input[1]
    local description = input[2]
    
    if title and description then
        TriggerServerEvent('weazel:broadcastNotification', title, description)
        return true
    end

    return false
end

exports('ShowWeazelNotification', ShowWeazelNotification)
exports('OpenWeazelNewsMenu', OpenWeazelNewsMenu)

RegisterNetEvent('weazel:showNotification')
AddEventHandler('weazel:showNotification', function(title, description, ticker)
    ShowWeazelNotification(title, description, ticker)
end)
