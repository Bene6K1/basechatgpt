local event = {}
local props = {}
local on = false

RegisterNetEvent('sunny:autoEvent:start', function(data)
    if not data or not data.position then
        print("Error: Invalid data received in sunny:autoEvent:start")
        return
    end

    ESX.addBlips({
        name = ('event_van_%s'):format(data.position),
        label = 'Fourgon Blindé',
        position = data.position,
        sprite = 67,
        display = 4,
        scale = 1.0,
        color = 75,
        type = "blip_events",
        disableShortRange = true
    })

    ESX.Game.SpawnLocalVehicle(GetHashKey('stockade'), data.position, 90.0, function(vehicle)
        if not vehicle then
            print("Error: Failed to spawn vehicle")
            return
        end

        event[data.position] = {
            entity = vehicle,
            on = true,
            interval = 2000,
            time = 300,
            drawNotification = function(msg, coords)
                ESX.ShowFloatingHelpNotification(msg, coords)
            end
        }
        
        Wait(2000)
        FreezeEntityPosition(vehicle, true)
        SetVehicleEngineOn(vehicle, false, false, false)
        SetVehicleDoorsLocked(vehicle, true)

        CreateThread(function()
            while event[data.position] and event[data.position].on do
                Wait(event[data.position].interval)
                event[data.position].interval = 1000

                local playerCoords = GetEntityCoords(PlayerPedId())
                local dist = #(playerCoords - data.position)

                event[data.position].time = event[data.position].time - 1

                if dist > 25 then
                    exports['core-ui']:hideInfo()
                else
                    if DoesEntityExist(vehicle) then
                        local vehicleHealth = GetEntityHealth(vehicle)
                        local finalHealth = vehicleHealth * 1000

                        exports['core-ui']:drawInfo('Informations Van', {
                            {title = 'Temps', subtitle = tostring(event[data.position].time)},
                            {title = 'Dégats', subtitle = tostring(finalHealth)},
                        })

                        if finalHealth <= 0 then
                            TriggerServerEvent('sunny:autoEvent:broke', data)
                            event[data.position].on = false
                            exports['core-ui']:hideInfo()
                        elseif event[data.position].time <= 0 then
                            TriggerServerEvent('sunny:autoEvent:stop', data.position)
                        end
                    else
                        event[data.position].on = false
                        exports['core-ui']:hideInfo()
                        break
                    end
                end

                if not event[data.position] or not event[data.position].on then
                    break
                end
            end
        end)

        CreateThread(function()
            while event[data.position] and event[data.position].on do
                Wait(event[data.position].interval)
                event[data.position].interval = 2000

                local playerCoords = GetEntityCoords(PlayerPedId())
                local dist = #(playerCoords - data.position)

                if dist <= 15 then
                    event[data.position].interval = 1
                    event[data.position].drawNotification('Casser le véhicule !', data.position)
                end

                if not event[data.position] or not event[data.position].on then
                    break
                end
            end
        end)
    end)
end)

RegisterNetEvent('sunny:autoEvent:broke', function(data)
    if not data then
        print("Error: Invalid data received in sunny:autoEvent:broke")
        return
    end
    TriggerServerEvent('sunny:autoEvent:secondBroke', data)
end)

RegisterNetEvent('sunny:autoEvent:secondBroke', function(data)
    if not data or not data.reward or not data.position then
        print("Error: Invalid data received in sunny:autoEvent:secondBroke")
        return
    end

    for k, v in pairs(data.reward) do
        if v and v.pos then
            ESX.Game.SpawnLocalObject('prop_large_gold_alt_c', vector3(v.pos.x, v.pos.y, v.pos.z - 0.98), function(obj)
                if obj then
                    FreezeEntityPosition(obj, true)
                    table.insert(props, {
                        obj = obj,
                        coords = GetEntityCoords(obj),
                        money = v.money or 0
                    })
                end
            end)
        end
    end

    on = true

    CreateThread(function()
        local interval = 2000
        while on do
            Wait(interval)
            interval = 2000

            for k, v in pairs(props) do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local objCoords = v.coords
                local dist = #(playerCoords - vector3(objCoords.x, objCoords.y, objCoords.z))

                if dist <= 2 then
                    interval = 1
                    DrawInstructionBarNotification(objCoords.x, objCoords.y, objCoords.z, '[E] pour ramasser les lingôts')

                    if IsControlJustPressed(0, 54) then
                        ExecuteCommand("e pickup")
                        TriggerServerEvent('sunny:autoEvent:take', v.obj, k, v.money)
                    end
                end
            end

            if not on then
                break
            end
        end
    end)

    CreateThread(function()
        local interval2 = 2000
        while on do
            Wait(interval2)
            interval2 = 2000

            local playerCoords = GetEntityCoords(PlayerPedId())
            local dst = #(playerCoords - data.position)

            if dst > 25 then
                exports['core-ui']:hideInfo()
            else
                interval2 = 1

                exports['core-ui']:drawInfo('Informations Van', {
                    {title = 'Objets restants', subtitle = tostring(#props)},
                })

                if #props <= 0 then
                    ExecuteCommand("e pickup")
                    TriggerServerEvent('sunny:autoEvent:stop', data.position)
                end
            end

            if not on then
                break
            end
        end
    end)
end)

RegisterNetEvent('sunny:autoEvent:take', function(obj, k)
    for i, v in pairs(props) do
        if i == k then
            DeleteObject(v.obj)
            table.remove(props, i)
            break
        end
    end

    DeleteObject(obj)

    if #props <= 0 then
        on = false
    end
end)

RegisterNetEvent('sunny:autoEvent:stop', function(position)
    exports['core-ui']:hideInfo()
    DeleteEntity(event[position].entity)
    ESX.removeBlip(("event_van_%s"):format(position))
    event[position] = nil
end)

