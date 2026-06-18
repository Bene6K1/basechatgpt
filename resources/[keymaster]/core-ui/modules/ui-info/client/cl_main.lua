local isVisible = false

RegisterNetEvent('ui:drawInfo')
AddEventHandler('ui:drawInfo', function(title, info)
    SendNUIMessage({
        action = 'show',
        title = title,
        info = info
    })
    isVisible = true
end)

RegisterNetEvent('ui:hideInfo')
AddEventHandler('ui:hideInfo', function()
    SendNUIMessage({
        action = 'hide'
    })
    isVisible = false
end)

CreateThread(function()
    Wait(500)
    SendNUIMessage({
        action = 'hide'
    })
end)

exports('drawInfo', function(title, info)
    TriggerEvent('ui:drawInfo', title, info)
end)

exports('hideInfo', function()
    TriggerEvent('ui:hideInfo')
end)
