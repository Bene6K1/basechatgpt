StateEngine = true
DisplayStateEngine = "~g~Allumé"

RegisterNetEvent("contextmenu:NetworkOverrideClockTime_response")
AddEventHandler("contextmenu:NetworkOverrideClockTime_response", function(time)
    NetworkOverrideClockTime(time, 0, 0)
end)

RegisterNetEvent("contextmenu:SetWeatherType_response")
AddEventHandler("contextmenu:SetWeatherType_response", function(type)
    SetWeatherTypePersist(type)
    SetWeatherTypeNow(type)
    SetWeatherTypeNowPersist(type)
end)


RegisterNetEvent('deadtrixcontext:envoyeremployer2')
AddEventHandler('deadtrixcontext:envoyeremployer2', function(service, nom, message)
    if service == 'patron' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('INFO '..ESX.PlayerData.job.label, '~b~A lire', 'Patron: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_MINOTAUR', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1) 
    end
end)