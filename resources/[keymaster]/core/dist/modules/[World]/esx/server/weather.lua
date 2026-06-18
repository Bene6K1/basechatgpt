admins = {
    'license:968abcbb2dced60f0e6caeea28c431b744430742',
    --'license:1234975143578921327',
}

DynamicWeather = false
FreezeTime = false
debugprint = false 

-------------------- NE PAS CHANGER CELA --------------------
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = FreezeTime or false
local blackout = false
local newWeatherTimer = 10

RegisterServerEvent('vSync:requestSync')
AddEventHandler('vSync:requestSync', function()
    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('freezetime', function(source, args)
    if source ~= 0 then
        local myPlayer = ESX.GetPlayerFromId(source)
        if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('esx:showNotification', source, 'Le temps est maintenant ~b~gelé~s~. ❄️')
            else
                TriggerClientEvent('esx:showNotification', source, 'Le temps n\'est plus ~y~gelé~s~. ☀️')
            end
        else
            TriggerClientEvent('esx:showNotification', source, '^8Erreur: ^1Vous n\'êtes pas autorisé à utiliser cette commande. ❌')
        end
    else
        freezeTime = not freezeTime
        if freezeTime then
            print("Le temps est maintenant gelé.")
        else
            print("Le temps n'est plus gelé.")
        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        local myPlayer = ESX.GetPlayerFromId(source)
        if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                TriggerClientEvent('esx:showNotification', source, 'Les changements dynamiques de météo sont maintenant ~r~désactivés~s~. ⛔')
            else
                TriggerClientEvent('esx:showNotification', source, 'Les changements dynamiques de météo sont maintenant ~b~activés~s~. ☁️')
            end
        else
            TriggerClientEvent('esx:showNotification', source, '^8Erreur: ^1Vous n\'êtes pas autorisé à utiliser cette commande. ❌')
        end
    else
        DynamicWeather = not DynamicWeather
        if not DynamicWeather then
            print("La météo est maintenant figée.")
        else
            print("La météo n'est plus figée.")
        end
    end
end)

RegisterCommand('weather', function(source, args)
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print("Syntaxe invalide, syntaxe correcte : /weather <typeMétéo> ")
            return
        else
            for i,wtype in ipairs(AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print("La météo a été mise à jour.")
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 10
                TriggerEvent('vSync:requestSync')
            else
                print("Type de météo invalide, types de météo valides : \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ")
            end
        end
    else
        local myPlayer = ESX.GetPlayerFromId(source)
        if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

            local validWeatherType = false
            if args[1] == nil then
                TriggerClientEvent('esx:showNotification', source, '^8Erreur: ^1Syntaxe invalide, utilisez ^0/weather <typeMétéo> ^1à la place!')
            else
                for i,wtype in ipairs(AvailableWeatherTypes) do
                    if wtype == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    TriggerClientEvent('esx:showNotification', source, 'La météo va changer pour : ~y~' .. string.lower(args[1]) .. "~s~. 🌦️")
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 10
                    TriggerEvent('vSync:requestSync')
                else
                    TriggerClientEvent('esx:showNotification', source, '^8Erreur: ^1Type de météo invalide, types de météo valides : ^0\nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ')
                end
            end
        else
            TriggerClientEvent('esx:showNotification', source, '^8Erreur: ^1Vous n\'avez pas accès à cette commande. ❌')
            print('Accès refusé pour la commande /weather.')
        end
    end
end, false)

RegisterCommand('blackout', function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print("Le blackout est maintenant activé.")
        else
            print("Le blackout est maintenant désactivé.")
        end
    else
        local myPlayer = ESX.GetPlayerFromId(source)
        if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

            blackout = not blackout
            if blackout then
                TriggerClientEvent('esx:showNotification', source, 'Le blackout est maintenant ~b~activé~s~. ⚫')
            else
                TriggerClientEvent('esx:showNotification', source, 'Le blackout est maintenant ~r~désactivé~s~. ⚪')
            end
            TriggerEvent('vSync:requestSync')
        end
    end
end)

RegisterCommand('morning', function(source)
    if source == 0 then
        print("Pour la console, utilisez la commande \"/time <hh> <mm>\" à la place!")
        return
    end
    local myPlayer = ESX.GetPlayerFromId(source)
    if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerClientEvent('esx:showNotification', source, 'L\'heure est réglée sur ~y~matin~s~. 🌅')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('noon', function(source)
    if source == 0 then
        print("Pour la console, utilisez la commande \"/time <hh> <mm>\" à la place!")
        return
    end
    local myPlayer = ESX.GetPlayerFromId(source)
    if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

        ShiftToMinute(0)
        ShiftToHour(12)
        TriggerClientEvent('esx:showNotification', source, 'L\'heure est réglée sur ~y~midi~s~. ☀️')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('evening', function(source)
    if source == 0 then
        print("Pour la console, utilisez la commande \"/time <hh> <mm>\" à la place!")
        return
    end
    local myPlayer = ESX.GetPlayerFromId(source)
    if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

        ShiftToMinute(0)
        ShiftToHour(18)
        TriggerClientEvent('esx:showNotification', source, 'L\'heure est réglée sur ~y~soir~s~. 🌆')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('night', function(source)
    if source == 0 then
        print("Pour la console, utilisez la commande \"/time <hh> <mm>\" à la place!")
        return
    end
    local myPlayer = ESX.GetPlayerFromId(source)
    if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then

        ShiftToMinute(0)
        ShiftToHour(23)
        TriggerClientEvent('esx:showNotification', source, 'L\'heure est réglée sur ~y~nuit~s~. 🌙')
        TriggerEvent('vSync:requestSync')
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterCommand('time', function(source, args, rawCommand)
    if source == 0 then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            print("L'heure a changé à " .. argh .. ":" .. argm .. ".")
            TriggerEvent('vSync:requestSync')
        else
            print("Syntaxe invalide, syntaxe correcte : time <heure> <minute> !")
        end
    elseif source ~= 0 then
        local myPlayer = ESX.GetPlayerFromId(source)
        if Config.Staff.HavePermission('Modules', 'weather', myPlayer) then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
				local minute = math.floor((baseTime+timeOffset)%60)
                if minute < 10 then
                    newtime = newtime .. "0" .. minute
                else
                    newtime = newtime .. minute
                end
                TriggerClientEvent('esx:showNotification', source, 'L\'heure a été changée en : ~y~' .. newtime .. "~s~! ⏰")

                -- https://docs.esx-framework.org/legacy/Client/functions/shownotification
                TriggerEvent('vSync:requestSync')
            else
                TriggerClientEvent('esx:showNotification', source, 'Erreur: ^1Syntaxe invalide. Utilisez ^0/time <heure> <minute> ^1à la place!')
            end
        else
            TriggerClientEvent('esx:showNotification', source, '^8Erreur: ^1Vous n\'avez pas accès à cette commande. ❌')
            print('Accès refusé pour la commande /time.')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY" then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("vSync:requestSync")
end
