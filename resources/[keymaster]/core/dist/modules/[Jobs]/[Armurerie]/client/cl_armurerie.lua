local armureriePoints = {
    vector3(1740.520386, 3894.871582, 31.451962),
    vector3(79.314377, -362.679260, 41.331646)
}

local munitions = {
    { label = "Munitions pour fusil à pompe", name = "shotgun_ammo" },
    { label = "Munitions pour fusil", name = "rifle_ammo" },
    { label = "Munitions pour mitrailleuse", name = "mg_ammo" },
    { label = "Munitions pour mitraillette", name = "smg_ammo" },
    { label = "Munitions pour sniper", name = "sniper_ammo" },
    { label = "Munitions pour pistolet", name = "pistol_ammo" }
}

local mainMenu = RageUI.CreateMenu("", "Munitions disponibles")
mainMenu.Closed = function() open = false end

CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, point in pairs(armureriePoints) do
            local distance = #(playerCoords - point)
            
            if distance < 10.0 then
              sleep = 0
              DrawMarker(25, point.x, point.y, point.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, tonumber(UTILS.ServerColor.r), tonumber(UTILS.ServerColor.g), tonumber(UTILS.ServerColor.b), 255, false, false, 2, false, false, false, false)
              
              if distance <= 1.5 then
                DrawInstructionBarNotification(point.x, point.y, point.z, "Appuyez sur [E] pour intéragir")
                if IsControlJustPressed(1, 51) then
                  OpenArmurerieMenu()
                end
              end
            end
        end
        Wait(sleep)
    end
end)

function OpenArmurerieMenu()
    if open then return end
    open = true

    CreateThread(function()
        while open do
            RageUI.IsVisible(mainMenu, function()
                for _, ammo in pairs(munitions) do
                    RageUI.Button(ammo.label, nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local input = lib.inputDialog('Quantité de munitions', {
                                { type = 'number', label = 'Quantité (max 200)', default = 1, min = 1, max = 200 }
                            })
                            
                            if input then
                                local amount = input[1]
                                if amount and tonumber(amount) then
                                    TriggerServerEvent('armurerie:getMunitions', ammo.name, tonumber(amount))
                                end
                            end
                        end
                    })
                end
            end)
            Wait(0)
        end
    end)

    RageUI.Visible(mainMenu, true)
end
