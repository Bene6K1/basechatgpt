--[[
================================================================================
                    GANG GARAGES - CLIENT SIDE
================================================================================
Systeme de garage pour les groupes illegaux (basé sur job2)
================================================================================
]]

GangGarageClient = {}
GangGarageClient.MenuOpened = false
GangGarageClient.CurrentGarage = nil
GangGarageClient.CurrentGang = nil
GangGarageClient.LastSpawn = 0
GangGarageClient.InteractionPoints = {}

---Thread: Création des blips pour les garages de gang
CreateThread(function()
    while not ESXLoaded do Wait(100) end

    Wait(2000)

    for gangName, garage in pairs(GangGarages.Gangs) do
        if garage.enabled and garage.blip and garage.blip.enabled then
            local blip = AddBlipForCoord(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z)
            SetBlipSprite(blip, garage.blip.sprite or 357)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, garage.blip.scale or 0.6)
            SetBlipColour(blip, garage.blip.color or 1)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(garage.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

---Vérifie si le joueur a accès au garage (via job2)
---@param playerJob2Name string
---@param garageName string
---@return boolean
local function hasGangGarageAccess(playerJob2Name, garageName)
    if not playerJob2Name then return false end

    -- Correspondance exacte
    if playerJob2Name == garageName then
        return true
    end

    -- Vérifier si le garage est une variante du gang (ex: ballas_aircraft pour ballas)
    if string.find(garageName, playerJob2Name .. "_") == 1 then
        return true
    end

    return false
end

---Thread: Affichage des markers et gestion des interactions
CreateThread(function()
    while not ESXLoaded do Wait(100) end

    local wait = 1000

    while true do
        Wait(wait)

        wait = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local playerData = ESX.GetPlayerData()
        local playerJob2 = playerData.job2

        if not playerJob2 or not playerJob2.name then goto continue end

        for gangName, garage in pairs(GangGarages.Gangs) do
            if not garage.enabled then goto nextGarage end

            if not hasGangGarageAccess(playerJob2.name, gangName) then goto nextGarage end

            local accessDist = #(playerCoords - vector3(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z))
            local deleteDist = #(playerCoords - vector3(garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z))

            if accessDist > GangGarages.Settings.markerDistance and deleteDist > GangGarages.Settings.markerDistance then
                goto nextGarage
            end

            wait = 0

            -- Marker pour l'accès au garage
            if accessDist <= GangGarages.Settings.markerDistance then
                DrawMarker(
                    25,
                    garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z - 0.98,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    0.55, 0.55, 0.55,
                    200, 50, 50, 200,
                    false, false, 2, false, false, false, false
                )

                if accessDist <= GangGarages.Settings.interactionDistance then
                    if not GangGarageClient.InteractionPoints[gangName..'_access'] then
                        GangGarageClient.InteractionPoints[gangName..'_access'] = CreateInteractionPoint(
                            vector3(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z),
                            "GARAGE GROUPE",
                            function() GangGarageClient:OpenMenu(gangName) end,
                            { icon = 'fa-warehouse', dist = GangGarages.Settings.interactionDistance }
                        )
                    end
                else
                    if GangGarageClient.InteractionPoints[gangName..'_access'] then
                        RemoveInteractionPoint(GangGarageClient.InteractionPoints[gangName..'_access'])
                        GangGarageClient.InteractionPoints[gangName..'_access'] = nil
                    end
                end
            end

            -- Marker pour ranger le véhicule
            if deleteDist <= GangGarages.Settings.markerDistance then
                DrawMarker(
                    36,
                    garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z - 0.30,
                    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    0.55, 0.55, 0.55,
                    200, 50, 50, 200,
                    false, false, 2, true, false, false, false
                )

                if deleteDist <= GangGarages.Settings.interactionDistance then
                    if not GangGarageClient.InteractionPoints[gangName..'_delete'] then
                        GangGarageClient.InteractionPoints[gangName..'_delete'] = CreateInteractionPoint(
                            vector3(garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z),
                            "RANGER VEHICULE",
                            function() GangGarageClient:StoreVehicle(gangName) end,
                            { icon = 'fa-parking', dist = GangGarages.Settings.interactionDistance }
                        )
                    end
                else
                    if GangGarageClient.InteractionPoints[gangName..'_delete'] then
                        RemoveInteractionPoint(GangGarageClient.InteractionPoints[gangName..'_delete'])
                        GangGarageClient.InteractionPoints[gangName..'_delete'] = nil
                    end
                end
            end

            ::nextGarage::
        end

        ::continue::
    end
end)

---Ouvre le menu du garage de gang
---@param gangName string
function GangGarageClient:OpenMenu(gangName)
    if GetGameTimer() - GangGarageClient.LastSpawn < GangGarages.Settings.spawnCooldown then
        ESX.ShowNotification('~r~Veuillez patienter avant de reutiliser le garage')
        return
    end

    ESX.TriggerServerCallback('ganggarage:getConfig', function(garageConfig)
        if not garageConfig then
            ESX.ShowNotification(GangGarages.Settings.notifications.noPermission)
            return
        end

        GangGarageClient.CurrentGarage = garageConfig
        GangGarageClient.CurrentGang = gangName

        local main = RageUI.CreateMenu('', garageConfig.label)
        local vehicleList = RageUI.CreateSubMenu(main, '', 'Vehicules du Groupe')

        GangGarageClient.MenuOpened = true
        RageUI.Visible(main, true)

        FreezeEntityPosition(PlayerPedId(), true)

        while GangGarageClient.MenuOpened do
            Wait(0)

            RageUI.IsVisible(main, function()
                RageUI.Separator('~r~' .. garageConfig.label .. '~s~')
                RageUI.Line(200, 50, 50, 255)

                RageUI.Button('Sortir un vehicule', nil, {RightLabel = '->'}, true, {}, vehicleList)

                RageUI.Line(200, 50, 50, 255)

                RageUI.Separator(string.format('Vehicules disponibles: %d', #garageConfig.vehicles))
            end)

            RageUI.IsVisible(vehicleList, function()
                for index, vehicle in ipairs(garageConfig.vehicles) do
                    RageUI.Button(
                        vehicle.label,
                        string.format('Modele: %s', vehicle.model),
                        {},
                        true,
                        {
                            onSelected = function()
                                GangGarageClient:SpawnVehicle(gangName, vehicle)
                            end
                        }
                    )
                end
            end)

            if not RageUI.Visible(main) and not RageUI.Visible(vehicleList) then
                GangGarageClient.MenuOpened = false
                FreezeEntityPosition(PlayerPedId(), false)
                main = RMenu:DeleteType('main')
            end
        end
    end, gangName)
end

---Spawn un véhicule de gang
---@param gangName string
---@param vehicleConfig table
function GangGarageClient:SpawnVehicle(gangName, vehicleConfig)
    if GetGameTimer() - GangGarageClient.LastSpawn < GangGarages.Settings.spawnCooldown then
        ESX.ShowNotification('~r~Veuillez patienter...')
        return
    end

    ESX.TriggerServerCallback('ganggarage:canSpawn', function(canSpawn, message)
        if not canSpawn then
            ESX.ShowNotification(message or GangGarages.Settings.notifications.noPermission)
            return
        end

        local garage = GangGarages.Gangs[gangName]
        if not garage then return end

        local spawnPoint = GangGarageClient:FindFreeSpawnPoint(garage.spawnPoints)

        if not spawnPoint then
            ESX.ShowNotification(GangGarages.Settings.notifications.noSpace)
            return
        end

        RageUI.CloseAll()
        GangGarageClient.MenuOpened = false
        FreezeEntityPosition(PlayerPedId(), false)

        TriggerServerEvent('ganggarage:spawnVehicle', gangName, vehicleConfig.model, spawnPoint, vehicleConfig)

        GangGarageClient.LastSpawn = GetGameTimer()

    end, gangName, vehicleConfig.model)
end

---Trouve un point de spawn libre
---@param spawnPoints table
---@return vector4|nil
function GangGarageClient:FindFreeSpawnPoint(spawnPoints)
    for _, point in ipairs(spawnPoints) do
        if ESX.Game.IsSpawnPointClear(vector3(point.x, point.y, point.z), 2.5) then
            return point
        end
    end

    if GangGarages.Settings.checkSpawnClear then
        for attempt = 1, GangGarages.Settings.maxSpawnAttempts do
            Wait(GangGarages.Settings.spawnAttemptDelay)

            for _, point in ipairs(spawnPoints) do
                if ESX.Game.IsSpawnPointClear(vector3(point.x, point.y, point.z), 2.5) then
                    return point
                end
            end
        end
    end

    return nil
end

---Range un véhicule de gang
---@param gangName string
function GangGarageClient:StoreVehicle(gangName)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        ESX.ShowNotification('~r~Vous devez etre dans un vehicule')
        return
    end

    local vehicleProps = lib.getVehicleProperties(vehicle)
    if not vehicleProps then
        ESX.ShowNotification('~r~Erreur lors de la recuperation des proprietes')
        return
    end

    local plate = vehicleProps.plate
    local vehicleHash = GetEntityModel(vehicle)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)

    local garage = GangGarages.Gangs[gangName]
    if not garage then return end

    local isGangVehicle = false
    local vehicleModel = nil

    for _, veh in ipairs(garage.vehicles) do
        local configHash = GetHashKey(veh.model)
        if configHash == vehicleHash then
            isGangVehicle = true
            vehicleModel = veh.model
            break
        end
    end

    if not isGangVehicle then
        ESX.ShowNotification(GangGarages.Settings.notifications.wrongGarage)
        return
    end

    ESX.Game.DeleteVehicle(vehicle)
    TriggerServerEvent('ganggarage:storeVehicle', gangName, netId, plate, vehicleModel)
end

---Event: Création du véhicule côté client
RegisterNetEvent('ganggarage:createVehicle')
AddEventHandler('ganggarage:createVehicle', function(vehicleData)
    local playerPed = PlayerPedId()

    local modelHash = GetHashKey(vehicleData.model)

    if not IsModelInCdimage(modelHash) or not IsModelAVehicle(modelHash) then
        ESX.ShowNotification('~r~Erreur: Modele de vehicule invalide')
        return
    end

    RequestModel(modelHash)
    local attempts = 0
    while not HasModelLoaded(modelHash) do
        Wait(10)
        attempts = attempts + 1
        if attempts > 100 then
            ESX.ShowNotification('~r~Erreur de chargement du vehicule')
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
            ESX.ShowNotification('~r~Erreur de creation du vehicule')
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

    -- Flash des phares pour confirmer le spawn
    SetVehicleLights(vehicle, 2)
    Wait(200)
    SetVehicleLights(vehicle, 0)

    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerServerEvent('ganggarage:vehicleCreated', GangGarageClient.CurrentGang, vehicleData.model, netId, vehicleData.plate)

    SetModelAsNoLongerNeeded(modelHash)
end)
