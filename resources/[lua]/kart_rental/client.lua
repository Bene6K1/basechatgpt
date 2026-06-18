ESX = nil
local npcPed = nil
local isNearNPC = false
local currentRental = nil
local rentalTimer = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    CreateNPC()
end)

function CreateNPC()
    local hash = GetHashKey(Config.NPCModel)
    
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(1)
    end
    
    npcPed = CreatePed(4, hash, Config.NPCPosition.x, Config.NPCPosition.y, Config.NPCPosition.z - 1.0, Config.NPCHeding, false, true)
    SetEntityHeading(npcPed, Config.NPCHeding)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    
    SetModelAsNoLongerNeeded(hash)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - Config.NPCPosition)
        
        if distance < 10.0 then
            DrawMarker(1, Config.NPCPosition.x, Config.NPCPosition.y, Config.NPCPosition.z - 1.0, 
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
                1.5, 1.5, 1.0, 0, 255, 0, 100, 
                false, true, 2, false, nil, nil, false)
            
            if distance < 2.0 then
                ESX.ShowHelpNotification(string.format(Config.Messages['press_to_rent'], Config.KartPrice))
                
                if IsControlJustReleased(0, 38) then
                    OpenRentalMenu()
                end
            end
        end
    end
end)

function OpenRentalMenu()
    if currentRental then
        ESX.ShowNotification('Vous avez déjà une location en cours!')
        return
    end
    
    ESX.ShowNotification('Vérification de votre solde...')
    
    ESX.TriggerServerCallback('kart_rental:checkMoney', function(hasMoney)
        if hasMoney then
            ESX.ShowNotification('Recherche d\'un point de spawn libre...')
            SpawnKart()
        else
            ESX.ShowNotification(string.format(Config.Messages['insufficient_money'], Config.KartPrice))
        end
    end)
end

function SpawnKart()
    local spawnPoint = FindFreeSpawnPoint()
    
    if spawnPoint then
        local hash = GetHashKey(Config.KartModel)
        
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end
        
        local vehicle = CreateVehicle(hash, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.w, true, false)
        
        if DoesEntityExist(vehicle) then
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleEngineOn(vehicle, false, true, true)
            SetVehicleNumberPlateText(vehicle, "KART" .. math.random(100, 999))
            
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            
            StartRental(vehicle, spawnPoint)
            
            SetModelAsNoLongerNeeded(hash)
        else
            ESX.ShowNotification('Erreur lors de la création du kart')
        end
    else
        ESX.ShowNotification('Aucun point de spawn libre trouvé')
    end
end

function FindFreeSpawnPoint()
    for _, spawnPoint in pairs(Config.KartSpawnPoints) do
        local clearArea = true
        
        for _, vehicle in pairs(GetGamePool('CVehicle')) do
            local distance = #(GetEntityCoords(vehicle) - vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z))
            if distance < 3.0 then
                clearArea = false
                break
            end
        end
        
        if clearArea then
            return spawnPoint
        end
    end
    
    return nil
end

function StartRental(vehicle, spawnPoint)
    if not vehicle or not spawnPoint then return end
    
    currentRental = {
        vehicle = vehicle,
        spawnPoint = spawnPoint,
        startTime = GetGameTimer(),
        endTime = GetGameTimer() + (Config.RentalDuration * 60 * 1000),
        lastDistanceCheck = GetGameTimer()
    }
    
    TriggerServerEvent('kart_rental:startRental', Config.KartPrice, NetworkGetNetworkIdFromEntity(vehicle))
    
    StartRentalTimer()
    
    ESX.ShowNotification(string.format(Config.Messages['rental_started'], Config.KartPrice, Config.RentalDuration))
end

function StartRentalTimer()
    if rentalTimer then
        Citizen.Wait(0)
        rentalTimer = nil
    end
    
    currentRental.notificationsShown = {
        ten = false,
        five = false,
        three = false,
        one = false
    }
    
    rentalTimer = Citizen.CreateThread(function()
        while currentRental and currentRental.vehicle and DoesEntityExist(currentRental.vehicle) do
            Citizen.Wait(5000)
            
            if not currentRental or not currentRental.vehicle then break end
            
            local currentTime = GetGameTimer()
            local remainingTime = currentRental.endTime - currentTime
            local remainingMinutes = math.floor(remainingTime / (60 * 1000))
            
            if remainingMinutes <= 10 and not currentRental.notificationsShown.ten then
                ESX.ShowNotification(Config.Messages['time_warning_10'])
                currentRental.notificationsShown.ten = true
            elseif remainingMinutes <= 5 and not currentRental.notificationsShown.five then
                ESX.ShowNotification(Config.Messages['time_warning_5'])
                currentRental.notificationsShown.five = true
            elseif remainingMinutes <= 3 and not currentRental.notificationsShown.three then
                ESX.ShowNotification(Config.Messages['time_warning_3'])
                currentRental.notificationsShown.three = true
            elseif remainingMinutes <= 1 and not currentRental.notificationsShown.one then
                ESX.ShowNotification(Config.Messages['time_warning_1'])
                currentRental.notificationsShown.one = true
            elseif remainingMinutes <= 0 then
                EndRental()
                break
            end
        end
    end)
end

function EndRental()
    if currentRental and currentRental.vehicle and DoesEntityExist(currentRental.vehicle) then
        ESX.ShowNotification(Config.Messages['rental_ended'])
        
        DeleteVehicle(currentRental.vehicle)
        
        TriggerServerEvent('kart_rental:endRental')
        
        currentRental = nil
        
        if rentalTimer then
            Citizen.Wait(0)
            rentalTimer = nil
        end
    elseif currentRental then
        currentRental = nil
        if rentalTimer then
            Citizen.Wait(0)
            rentalTimer = nil
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        
        if currentRental and currentRental.vehicle and DoesEntityExist(currentRental.vehicle) then
            local playerPed = PlayerPedId()
            local vehicle = currentRental.vehicle
            
            if not IsPedInVehicle(playerPed, vehicle, false) then
                local playerCoords = GetEntityCoords(playerPed)
                local vehicleCoords = GetEntityCoords(vehicle)
                local distance = #(playerCoords - vehicleCoords)
                
                if distance > 50.0 then
                    local lastCheck = currentRental.lastDistanceCheck or GetGameTimer()
                    local timeSinceLastCheck = GetGameTimer() - lastCheck
                    if timeSinceLastCheck > 45000 then
                        EndRental()
                    end
                else
                    if currentRental then
                        currentRental.lastDistanceCheck = GetGameTimer()
                    end
                end
            else
                if currentRental then
                    currentRental.lastDistanceCheck = GetGameTimer()
                end
            end
        end
    end
end)

RegisterNetEvent('kart_rental:forceEndRental')
AddEventHandler('kart_rental:forceEndRental', function()
    if currentRental then
        EndRental()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if currentRental and currentRental.vehicle and DoesEntityExist(currentRental.vehicle) then
            DeleteVehicle(currentRental.vehicle)
        end
    end
end) 