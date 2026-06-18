CreateThread(function()
    while not ESXLoaded do Wait(1) end

    TriggerServerEvent('sunny:weapons:load')
end)