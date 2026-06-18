local CurrentTest = nil
isintestdrive = false
local CurrentTestType = nil
local CurrentCheckPoint = 0
local LastCheckPoint = -1
local CurrentZoneType = nil
local DriveErrors = 0
local IsAboveSpeedLimit = false
local CurrentVehicle = nil
local LastVehicleHealth = nil
local pedddd = nil
local isSpawning = false  

function StartDriveTest(type)
    if isSpawning or CurrentTest == 'drive' then
        return 
    end
    
    isSpawning = true
    CurrentTest = 'drive'
    
    if CurrentVehicle and DoesEntityExist(CurrentVehicle) then
        DeleteEntity(CurrentVehicle)
        CurrentVehicle = nil
    end
    if pedddd and DoesEntityExist(pedddd) then
        DeleteEntity(pedddd)
        pedddd = nil
    end
    
    Wait(500)
    
    isintestdrive = true
    
    ESX.Game.SpawnVehicle(SunnyConfigServ.ConfigAutoEcole.VehicleModels[type], SunnyConfigServ.ConfigAutoEcole.Zones.VehicleSpawnPoint.Pos, SunnyConfigServ.ConfigAutoEcole.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
        if not vehicle then
            isSpawning = false
            CurrentTest = nil
            return
        end
        
        ESX.Game.SpawnLocalPed(1, 'a_f_o_ktown_01', vector3(0.0, 0.0, 0.0), 90.0, function(ped)
            if not ped then
                DeleteEntity(vehicle)
                isSpawning = false
                CurrentTest = nil
                return
            end
            
            
            pedddd = ped
            CurrentTestType = type
            CurrentCheckPoint = 0
            LastCheckPoint = -1
            CurrentZoneType = 'residence'
            DriveErrors = 0
            IsAboveSpeedLimit = false
            CurrentVehicle = vehicle
            LastVehicleHealth = GetEntityHealth(vehicle)
    
            local playerPed = PlayerPedId()
            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            SetPedIntoVehicle(ped, vehicle, 0)
            
            Wait(1000)
            isSpawning = false
        end)
    end)
end

function StopDriveTest(success)
    if not CurrentTest then
        return
    end
    
    if success then
        TriggerServerEvent('rx:addLicense', CurrentTestType)
        Notification('[~g~Réussi~s~] Félicitation, vous avez réussi votre permis.')
    else
        Notification('[~r~Échoué~s~] vous avez échouez votre permis.')
    end
    
    if CurrentVehicle and DoesEntityExist(CurrentVehicle) then
        DeleteEntity(CurrentVehicle)
    end
    if pedddd and DoesEntityExist(pedddd) then
        DeleteEntity(pedddd)
    end
    
    if CurrentBlip and DoesBlipExist(CurrentBlip) then
        RemoveBlip(CurrentBlip)
    end
    
    isintestdrive = false
    CurrentTest = nil
    CurrentTestType = nil
    CurrentVehicle = nil
    pedddd = nil
    isSpawning = false
    CurrentCheckPoint = 0
    LastCheckPoint = -1
    DriveErrors = 0
    IsAboveSpeedLimit = false
end

function SetCurrentZoneType(type)
    CurrentZoneType = type
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentTest == 'drive' then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local nextCheckPoint = CurrentCheckPoint + 1

            if not isSpawning and CurrentTest == 'drive' then
                if SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint] ~= nil then
                    if not CurrentVehicle or not DoesEntityExist(CurrentVehicle) then
                        Notification('[~r~Échoué~s~] Le véhicule d\'examen a disparu.')
                        StopDriveTest(false)
                    end
                end

                if CurrentTest == 'drive' and CurrentVehicle and DoesEntityExist(CurrentVehicle) and not IsPedInVehicle(playerPed, CurrentVehicle, false) then
                    Notification('[~r~Échoué~s~] Vous êtes sorti du véhicule d\'examen.')
                    StopDriveTest(false)
                end
            end

            if SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint] == nil then
                if DoesBlipExist(CurrentBlip) then
                    RemoveBlip(CurrentBlip)
                end

                Notification('Test de conduite terminé')

                if CurrentTest == 'drive' then
                    if DriveErrors < SunnyConfigServ.ConfigAutoEcole.MaxErrors then
                        StopDriveTest(true)
                    else
                        StopDriveTest(false)
                    end
                end
                
            else
                if CurrentCheckPoint ~= LastCheckPoint then
                    if DoesBlipExist(CurrentBlip) then
                        RemoveBlip(CurrentBlip)
                    end

                    CurrentBlip = AddBlipForCoord(SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.x, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.y, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.z)
                    SetBlipRoute(CurrentBlip, 1)

                    LastCheckPoint = CurrentCheckPoint
                end

                local distance = GetDistanceBetweenCoords(coords, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.x, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.y, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.z, true)

                if distance <= 100.0 then
                    DrawMarker(1, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.x, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.y, SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, SunnyConfigServ.R, SunnyConfigServ.G, SunnyConfigServ.B, SunnyConfigServ.A, false, true, 2, false, false, false, false)
                end

                if distance <= 3.0 then
                    SunnyConfigServ.ConfigAutoEcole.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
                    CurrentCheckPoint = CurrentCheckPoint + 1
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)

        if CurrentTest == 'drive' then
            local playerPed = PlayerPedId()

            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                
                if vehicle ~= CurrentVehicle then
                    Notification('[~r~Échoué~s~] Vous n\'êtes pas dans le bon véhicule.')
                    StopDriveTest(false)
                else
                    local speed = GetEntitySpeed(vehicle) * SunnyConfigServ.ConfigAutoEcole.SpeedMultiplier
                    local tooMuchSpeed = false

                    for k, v in pairs(SunnyConfigServ.ConfigAutoEcole.SpeedLimits) do
                        if CurrentZoneType == k and speed > v then
                            tooMuchSpeed = true

                            if not IsAboveSpeedLimit then
                                DriveErrors = DriveErrors + 1
                                IsAboveSpeedLimit = true

                                Notification((('Vous roulez trop vite, vitesse limite: ~y~%s~s~ km/h!'):format(v)))
                                Notification(('Erreurs: ~r~%s~s~/%s'):format(DriveErrors, SunnyConfigServ.ConfigAutoEcole.MaxErrors))
                                
                                if DriveErrors >= SunnyConfigServ.ConfigAutoEcole.MaxErrors then
                                    Notification('[~r~Échoué~s~] Trop d\'erreurs commises.')
                                    StopDriveTest(false)
                                    return
                                end
                            end
                        end
                    end

                    if not tooMuchSpeed then
                        IsAboveSpeedLimit = false
                    end

                    local health = GetEntityHealth(vehicle)
                    if health < LastVehicleHealth then
                        DriveErrors = DriveErrors + 1

                        Notification('~r~Vous avez endommagé votre véhicule.')
                        Notification(('Erreurs: ~r~%s~s~/%s'):format(DriveErrors, SunnyConfigServ.ConfigAutoEcole.MaxErrors))

                        if DriveErrors >= SunnyConfigServ.ConfigAutoEcole.MaxErrors then
                            Notification('[~r~Échoué~s~] Trop d\'erreurs commises.')
                            StopDriveTest(false)
                            return
                        end


                        LastVehicleHealth = health
                        Citizen.Wait(1500)
                    end
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)