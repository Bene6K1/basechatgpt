CreateThread(function()   
    local injail = false

    RegisterNetEvent('sunny:admin:jail:setPlayerInJail', function(UniqueID, data)
        injail = true
        adminManagement.jails[UniqueID] = data

        SetEntityCoords(Player.playerPed, vector3(1679.907104, 2513.060059, 45.564850))
        SetEntityInvincible(Player.playerPed, true)

        CreateThread(function()

            exports['core-ui']:drawInfo('Informations Jail', {
                {title = 'Temps restant', subtitle = ('%s %s'):format(adminManagement.jails[UniqueID].time, 'minute(s)')},
                {title = 'Raison', subtitle = ('%s'):format(adminManagement.jails[UniqueID].reason)},
            })
            while injail == true do

                Wait(60000)

                adminManagement.jails[UniqueID].time -= 1

                exports['core-ui']:drawInfo('Informations Jail', {
                    {title = 'Temps restant', subtitle = ('%s %s'):format(adminManagement.jails[UniqueID].time, 'minute(s)')},
                    {title = 'Raison', subtitle = ('%s'):format(adminManagement.jails[UniqueID].reason)},
                })

                if adminManagement.jails[UniqueID].time < 1 then
                    TriggerServerEvent('sunny:admin:jail:remove', UniqueID, adminManagement.jails[UniqueID])
                end

                if injail == false then
                    exports['core-ui']:hideInfo()
                    break
                end
            end
        end)

        CreateThread(function()
            while injail == true do
                Wait(5000)

                if not injail then return end
    
                local dist = #(GetEntityCoords(Player.playerPed)-vector3(1679.907104, 2513.060059, 45.564850))
    
                if dist > 15 then
                    SetEntityCoords(Player.playerPed, vector3(1679.907104, 2513.060059, 45.564850))
                end
    
                if injail == false then
                    break
                end
            end
        end)
    end)

    RegisterNetEvent('sunny:admin:jail:remove', function(UniqueID)
        injail = false
        adminManagement.jails[tonumber(UniqueID)] = nil
        SetEntityCoords(Player.playerPed, vector3(1846.043335, 2585.798584, 46.334686))
        SetEntityCoords(Player.playerPed, vector3(1846.043335, 2585.798584, 46.334686))
        SetEntityCoords(Player.playerPed, vector3(1846.043335, 2585.798584, 46.334686))
        SetEntityInvincible(Player.playerPed, false)

        exports['core-ui']:hideInfo()
    end)
end)