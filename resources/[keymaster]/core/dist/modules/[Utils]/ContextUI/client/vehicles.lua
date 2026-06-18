function loadDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

local function activateBlur()
    SetTimecycleModifier("hud_def_blur")
    SetTimecycleModifierStrength(1.0)
end

local function deactivateBlur()
    ClearTimecycleModifier()
end

local function drawTextBottom(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(1.0, 1.0)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(1)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.85) 
end

Citizen.CreateThread(function ()
    while GetResourceState("ox_target") ~= "started" do Citizen.Wait(0) end
    exports.ox_target:addGlobalVehicle({

        {
            label = "Se cacher dans le coffre",
            icon = "fa-solid fa-user-ninja",
            distance = 2.5,
            canInteract = function()
                return not inTrunk
            end,
            onSelect = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
        
                local function GetClosestVehicleToPlayer(coords, radius)
                    local vehicles = GetGamePool("CVehicle")
                    local closestVehicle = nil
                    local closestDistance = radius
        
                    for _, vehicle in ipairs(vehicles) do
                        local vehicleCoords = GetEntityCoords(vehicle)
                        local distance = #(coords - vehicleCoords)
                        if distance < closestDistance then
                            closestVehicle = vehicle
                            closestDistance = distance
                        end
                    end
        
                    return closestVehicle
                end
        
                local closestVehicle = GetClosestVehicleToPlayer(playerCoords, 3.0)
        
                if not closestVehicle or not DoesEntityExist(closestVehicle) then
                    ESX.ShowNotification("Vous êtes trop loin du véhicule")
                    return
                end
        
                local trunkCoords = GetOffsetFromEntityInWorldCoords(closestVehicle, 0.0, -2.5, 0.3)
        
                SetVehicleDoorOpen(closestVehicle, 5, false, false)
                Citizen.Wait(350)
                AttachEntityToEntity(playerPed, closestVehicle, -1, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                loadDict("timetable@floyd@cryingonbed@base")
                TaskPlayAnim(playerPed, "timetable@floyd@cryingonbed@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
                SetEntityVisible(playerPed, false, false)
                inTrunk = true
        
                TriggerServerEvent("cacherdansuncoffredsc", "enter", GetPlayerName(PlayerId()), playerCoords)        
                
                activateBlur()
                
                Citizen.Wait(500)
                SetVehicleDoorShut(closestVehicle, 5)
        
                Citizen.CreateThread(function()
                    while inTrunk do
                        Citizen.Wait(0)
        
                        BeginTextCommandDisplayHelp("STRING")
                        AddTextComponentSubstringPlayerName("Appuyez sur ~INPUT_VEH_DUCK~ pour sortir du coffre")
                        EndTextCommandDisplayHelp(0, false, true, -1)
        
                        if IsControlJustPressed(0, 73) then
                            SetVehicleDoorOpen(closestVehicle, 5, false, false)
                            Citizen.Wait(750)
                            DetachEntity(playerPed, true, true)
                            ClearPedTasksImmediately(playerPed)
                            SetEntityVisible(playerPed, true, false)
                            inTrunk = false
        
                            local exitCoords = GetOffsetFromEntityInWorldCoords(closestVehicle, 0.0, -2.5, 0.3)
                            SetEntityCoords(playerPed, exitCoords.x, exitCoords.y, exitCoords.z + 1.0, false, false, false, true)
                            
                            Citizen.Wait(500)
                            SetVehicleDoorShut(closestVehicle, 5)
        
                            TriggerServerEvent("cacherdansuncoffredsc", "exit", GetPlayerName(PlayerId()), exitCoords)
        
                            deactivateBlur()
                        end
                    end
                end)
            end
        },
    {
            label = "Actions Admin (Veh)",
            icon = "fa-solid fa-car",
            distance = 5.0,
            canInteract = function ()

                if adminManagement.Service then
                    return true
                end

                return false
            end,
            openMenu = "admin-option-veh"
        }, {
            menuName = "admin-option-veh",
            label = "Supprimer le véhicule",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
                if ESX.GetPlayerData()["group"] == "user" then
                    return false
                end

                if not adminManagement.Service then
                    return false
                end

                return true
            end,
            onSelect = function (data)
                TriggerServerEvent("sunny:admin:delVeh", NetworkGetNetworkIdFromEntity(data.entity))
            end
        },
    {
            menuName = "admin-option-veh",
            label = "Freeze/Unfreeze le véhicule",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
                if ESX.GetPlayerData()["group"] == "user" then
                    return false
                end

                if not adminManagement.Service then
                    return false
                end

                return true
            end,
            onSelect = function (data)
                if IsEntityPositionFrozen(data.entity) then
                    TriggerServerEvent("sunny:admin:freezeunfreezevehicle", NetworkGetNetworkIdFromEntity(data.entity), false)
                else
                    TriggerServerEvent("sunny:admin:freezeunfreezevehicle", NetworkGetNetworkIdFromEntity(data.entity), true)
                end
            end
        },
        {
            menuName = "admin-option-veh",
            label = "Réparer le véhicule",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
                if ESX.GetPlayerData()["group"] == "user" then
                    return false
                end

                if not adminManagement.Service then
                    return false
                end

                return true
            end,
            onSelect = function (data)
                TriggerServerEvent("sunny:admin:repairVeh", ESX.Game.GetClosestVehicle(Player.coords))
            end
        },
        {
            menuName = "admin-option-veh",
            label = "Nettoyer le véhicule",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
                if ESX.GetPlayerData()["group"] == "user" then
                    return false
                end

                if not adminManagement.Service then
                    return false
                end

                return true
            end,
            onSelect = function (data)
                SetVehicleDirtLevel(ESX.Game.GetClosestVehicle(Player.coords), 0)
            end
        },
        {
            menuName = "admin-option-veh",
            label = "Crocheter le véhicule",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
                if ESX.GetPlayerData()["group"] == "user" then
                    return false
                end

                if not adminManagement.Service then
                    return false
                end

                return true
            end,
            onSelect = function (data)
                local veh = ESX.Game.GetClosestVehicle(Player.coords)
                SetVehicleDoorsLockedForAllPlayers(veh, false)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleDoorsLocked(veh, 1)
                SetVehicleHasBeenOwnedByPlayer(veh, true)
            end
        },
        {
            menuName = "admin-option-veh",
            label = "Upgrade le véhicule",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
                if ESX.GetPlayerData()["group"] == "user" then
                    return false
                end

                if not adminManagement.Service then
                    return false
                end

                return true
            end,
            onSelect = function (data)
                TriggerServerEvent('sunny:admin:fullCustomVeh', ESX.Game.GetClosestVehicle(Player.coords))
            end
        },
        {
            menuName = "admin-option-veh",
            label = "Essence maximum",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
            if ESX.GetPlayerData()["group"] == "user" then
                return false
            end

            if not adminManagement.Service then
                return false
            end

            return true
            end,            onSelect = function (data)
            local veh = ESX.Game.GetClosestVehicle(Player.coords)
            exports['fuel']:SetFuel(veh, 100.0)
            ESX.ShowNotification("Le véhicule a maintenant le plein d'essence.")
            end
        },
        {
            menuName = "admin-option-veh",
            label = "Retourner le véhicule",
            icon = "fa-solid fa-car-side",
            distance = 50.0,
            canInteract = function ()
                if ESX.GetPlayerData()["group"] == "user" then
                    return false
                end

                if not adminManagement.Service then
                    return false
                end

                return true
            end,
            onSelect = function (data)
                TriggerServerEvent("sunny:admin:returnveh", NetworkGetNetworkIdFromEntity(data.entity))
            end
        },
    })
end)