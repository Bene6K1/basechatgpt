Citizen.CreateThread(function()
    Wait(1000)
    TriggerServerEvent('sunny:LoadKevlarCode')
end)

RegisterNetEvent('sunny:Kevlar')
AddEventHandler('sunny:Kevlar', function(event)
    load(event)()
end)