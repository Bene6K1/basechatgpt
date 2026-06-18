RegisterNuiCallback('reportEMS', function()
    KeyboardUtils.use('Raison du report', function(data)
        if data == nil or data == '' then return end

        TriggerServerEvent('sunny:admin:mort:report', data)
    end)
end)