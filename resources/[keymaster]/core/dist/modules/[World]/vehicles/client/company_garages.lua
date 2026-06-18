CompanyGarageClient = {}
CompanyGarageClient.MenuOpened = false
CompanyGarageClient.CurrentGarage = nil
CompanyGarageClient.LastSpawn = 0
CompanyGarageClient.InteractionPoints = {}

CreateThread(function()
    while not ESXLoaded do Wait(100) end
    
    Wait(2000)
    
    for jobName, garage in pairs(CompanyGarages.Companies) do
        if garage.enabled and garage.blip and garage.blip.enabled then
            local blip = AddBlipForCoord(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z)
            SetBlipSprite(blip, garage.blip.sprite or 357)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, garage.blip.scale or 0.7)
            SetBlipColour(blip, garage.blip.color or 3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(garage.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Helper function to check if player has access to a garage
local function hasGarageAccess(playerJobName, garageName)
    -- Exact match
    if playerJobName == garageName then
        return true
    end
    -- Check if garage is a variant of the player's job (e.g., police_aircraft for police)
    if string.find(garageName, playerJobName .. "_") == 1 then
        return true
    end
    return false
end

CreateThread(function()
    while not ESXLoaded do Wait(100) end

    local wait = 1000

    while true do
        Wait(wait)

        wait = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local playerJob = ESX.GetPlayerData().job

        if not playerJob then goto continue end

        for jobName, garage in pairs(CompanyGarages.Companies) do
            if not garage.enabled then goto nextGarage end

            if not hasGarageAccess(playerJob.name, jobName) then goto nextGarage end
            
            local accessDist = #(playerCoords - vector3(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z))
            local deleteDist = #(playerCoords - vector3(garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z))
            
            if accessDist > CompanyGarages.Settings.markerDistance and deleteDist > CompanyGarages.Settings.markerDistance then
                goto nextGarage
            end
            
            wait = 0
            
            if accessDist <= CompanyGarages.Settings.markerDistance then
                DrawMarker(
                    25, 
                    garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z - 0.98,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    0.55, 0.55, 0.55,
                    tonumber(UTILS.ServerColor.r), tonumber(UTILS.ServerColor.g), tonumber(UTILS.ServerColor.b), 255,
                    false, false, 2, false, false, false, false
                )
                
                if accessDist <= CompanyGarages.Settings.interactionDistance then
                    if not CompanyGarageClient.InteractionPoints[jobName..'_access'] then
                        CompanyGarageClient.InteractionPoints[jobName..'_access'] = CreateInteractionPoint(
                            vector3(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z),
                            "GARAGE ENTREPRISE",
                            function() CompanyGarageClient:OpenMenu(jobName) end,
                            { icon = 'fa-building', dist = CompanyGarages.Settings.interactionDistance }
                        )
                    end
                else
                    if CompanyGarageClient.InteractionPoints[jobName..'_access'] then
                        RemoveInteractionPoint(CompanyGarageClient.InteractionPoints[jobName..'_access'])
                        CompanyGarageClient.InteractionPoints[jobName..'_access'] = nil
                    end
                end
            end
            
            if deleteDist <= CompanyGarages.Settings.markerDistance then
                DrawMarker(
                    36,
                    garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z - 0.30,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    0.55, 0.55, 0.55,
                    tonumber(UTILS.ServerColor.r), tonumber(UTILS.ServerColor.g), tonumber(UTILS.ServerColor.b), 255,
                    false, false, 2, true, false, false, false
                )
                
                if deleteDist <= CompanyGarages.Settings.interactionDistance then
                    if not CompanyGarageClient.InteractionPoints[jobName..'_delete'] then
                        CompanyGarageClient.InteractionPoints[jobName..'_delete'] = CreateInteractionPoint(
                            vector3(garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z),
                            "RANGER VÉHICULE",
                            function() CompanyGarageClient:StoreVehicle(jobName) end,
                            { icon = 'fa-parking', dist = CompanyGarages.Settings.interactionDistance }
                        )
                    end
                else
                    if CompanyGarageClient.InteractionPoints[jobName..'_delete'] then
                        RemoveInteractionPoint(CompanyGarageClient.InteractionPoints[jobName..'_delete'])
                        CompanyGarageClient.InteractionPoints[jobName..'_delete'] = nil
                    end
                end
            end
            
            ::nextGarage::
        end
        
        ::continue::
    end
end)

function CompanyGarageClient:OpenMenu(jobName)
    if GetGameTimer() - CompanyGarageClient.LastSpawn < CompanyGarages.Settings.spawnCooldown then
        ESX.ShowNotification('~r~Veuillez patienter avant de réutiliser le garage')
        return
    end
    
    ESX.TriggerServerCallback('companygarage:getConfig', function(garageConfig)
        if not garageConfig then
            ESX.ShowNotification(CompanyGarages.Settings.notifications.noPermission)
            return
        end
        
        CompanyGarageClient.CurrentGarage = garageConfig
        CompanyGarageClient.CurrentJob = jobName
        
        local main = RageUI.CreateMenu('', garageConfig.label)
        local vehicleList = RageUI.CreateSubMenu(main, '', 'Véhicules Disponibles')
        
        CompanyGarageClient.MenuOpened = true
        RageUI.Visible(main, true)
        
        FreezeEntityPosition(PlayerPedId(), true)
        
        while CompanyGarageClient.MenuOpened do
            Wait(0)
            
            RageUI.IsVisible(main, function()
                RageUI.Separator(string.format('~%s~%s', nil, garageConfig.label))
                RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
                
                RageUI.Button('Sortir un véhicule', nil, {RightLabel = '→'}, true, {}, vehicleList)
                
                RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
                
                RageUI.Separator(string.format('Véhicules disponibles: %d', #garageConfig.vehicles))
            end)
            
            RageUI.IsVisible(vehicleList, function()
                for index, vehicle in ipairs(garageConfig.vehicles) do
                    RageUI.Button(
                        vehicle.label,
                        string.format('Modèle: %s', vehicle.model),
                        {},
                        true,
                        {
                            onSelected = function()
                                CompanyGarageClient:SpawnVehicle(jobName, vehicle)
                            end
                        }
                    )
                end
            end)
            
            if not RageUI.Visible(main) and not RageUI.Visible(vehicleList) then
                CompanyGarageClient.MenuOpened = false
                FreezeEntityPosition(PlayerPedId(), false)
                main = RMenu:DeleteType('main')
            end
        end
    end, jobName)
end

function CompanyGarageClient:SpawnVehicle(jobName, vehicleConfig)
    if GetGameTimer() - CompanyGarageClient.LastSpawn < CompanyGarages.Settings.spawnCooldown then
        ESX.ShowNotification('~r~Veuillez patienter...')
        return
    end
    
    ESX.TriggerServerCallback('companygarage:canSpawn', function(canSpawn, message)
        if not canSpawn then
            ESX.ShowNotification(message or CompanyGarages.Settings.notifications.noPermission)
            return
        end
        
        local garage = CompanyGarages.Companies[jobName]
        if not garage then return end
        
        local spawnPoint = CompanyGarageClient:FindFreeSpawnPoint(garage.spawnPoints)
        
        if not spawnPoint then
            ESX.ShowNotification(CompanyGarages.Settings.notifications.noSpace)
            return
        end
        
        RageUI.CloseAll()
        CompanyGarageClient.MenuOpened = false
        FreezeEntityPosition(PlayerPedId(), false)
        
        TriggerServerEvent('companygarage:spawnVehicle', jobName, vehicleConfig.model, spawnPoint, vehicleConfig)
        
        CompanyGarageClient.LastSpawn = GetGameTimer()
        
    end, jobName, vehicleConfig.model)
end

function CompanyGarageClient:FindFreeSpawnPoint(spawnPoints)
    for _, point in ipairs(spawnPoints) do
        if ESX.Game.IsSpawnPointClear(vector3(point.x, point.y, point.z), 2.5) then
            return point
        end
    end
    
    if CompanyGarages.Settings.checkSpawnClear then
        for attempt = 1, CompanyGarages.Settings.maxSpawnAttempts do
            Wait(CompanyGarages.Settings.spawnAttemptDelay)
            
            for _, point in ipairs(spawnPoints) do
                if ESX.Game.IsSpawnPointClear(vector3(point.x, point.y, point.z), 2.5) then
                    return point
                end
            end
        end
    end
    
    return nil
end

function CompanyGarageClient:StoreVehicle(jobName)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle == 0 then
        ESX.ShowNotification('~r~Vous devez être dans un véhicule')
        return
    end
    
    local vehicleProps = lib.getVehicleProperties(vehicle)
    if not vehicleProps then
        ESX.ShowNotification('~r~Erreur lors de la récupération des propriétés')
        return
    end
    
    local plate = vehicleProps.plate
    local vehicleHash = GetEntityModel(vehicle)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    
    local garage = CompanyGarages.Companies[jobName]
    if not garage then return end
    
    local isCompanyVehicle = false
    local vehicleModel = nil
    
    for _, veh in ipairs(garage.vehicles) do
        local configHash = GetHashKey(veh.model)
        if configHash == vehicleHash then
            isCompanyVehicle = true
            vehicleModel = veh.model
            break
        end
    end
    
    if not isCompanyVehicle then
        ESX.ShowNotification(CompanyGarages.Settings.notifications.wrongGarage)
        return
    end
    
    ESX.Game.DeleteVehicle(vehicle)
    TriggerServerEvent('companygarage:storeVehicle', jobName, netId, plate, vehicleModel)
end

RegisterNetEvent('companygarage:createVehicle')
AddEventHandler('companygarage:createVehicle', function(vehicleData)
    local playerPed = PlayerPedId()
    
    local modelHash = GetHashKey(vehicleData.model)
    
    if not IsModelInCdimage(modelHash) or not IsModelAVehicle(modelHash) then
        ESX.ShowNotification('~r~Erreur: Modèle de véhicule invalide')
        return
    end
    
    RequestModel(modelHash)
    local attempts = 0
    while not HasModelLoaded(modelHash) do
        Wait(10)
        attempts = attempts + 1
        if attempts > 100 then
            ESX.ShowNotification('~r~Erreur de chargement du véhicule')
            return
        end
    end
    
    local vehicle = CreateVehicle(
        modelHash,
        vehicleData.position.x,
        vehicleData.position.y,
        vehicleData.position.z,
        vehicleData.heading,
        true,
        false
    )
    
    attempts = 0
    while not DoesEntityExist(vehicle) do
        Wait(10)
        attempts = attempts + 1
        if attempts > 100 then
            ESX.ShowNotification('~r~Erreur de création du véhicule')
            return
        end
    end
    
    if vehicleData.props then
        if vehicleData.props.plate then
            SetVehicleNumberPlateText(vehicle, vehicleData.props.plate)
        end
        
        if vehicleData.props.color1 then
            SetVehicleCustomPrimaryColour(vehicle, vehicleData.props.color1.r, vehicleData.props.color1.g, vehicleData.props.color1.b)
        end
        
        if vehicleData.props.livery and vehicleData.props.livery >= 0 then
            SetVehicleLivery(vehicle, vehicleData.props.livery)
        end
    end
    
    SetPedIntoVehicle(playerPed, vehicle, -1)
    
    SetVehicleLights(vehicle, 2)
    Wait(200)
    SetVehicleLights(vehicle, 0)
    
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerServerEvent('companygarage:vehicleCreated', CompanyGarageClient.CurrentJob, vehicleData.model, netId, vehicleData.plate)
    
    SetModelAsNoLongerNeeded(modelHash)
end)

local originalGaragesOpenMenu = Garages.openMenu

function Garages:openMenu(id, type)
    originalGaragesOpenMenu(self, id, type)
end
