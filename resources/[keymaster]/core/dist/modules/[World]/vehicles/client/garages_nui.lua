GaragesNUI = {}
GaragesNUI.isOpen = false
GaragesNUI.currentGarageData = {}
GaragesNUI.previewVehicle = nil
GaragesNUI.previewCam = nil
GaragesNUI.originalCoords = nil
GaragesNUI.originalHeading = nil
GaragesNUI.inPreviewMode = false
GaragesNUI.isSpawning = false
GaragesNUI.currentPreviewCoords = nil

local locales = {
    ['fr'] = {
        ['garage'] = 'GARAGE',
        ['vehicle-gestion'] = 'GESTION DE VÉHICULE',
        ['vehicle-list'] = 'LISTE DE VÉHICULES',
        ['speed'] = 'VITESSE',
        ['acceleration'] = 'ACCÉLÉRATION',
        ['brake'] = 'FREIN',
        ['traction'] = 'TRACTION',
        ['get'] = 'PRENDRE',
        ['impound'] = 'FOURRIÈRE',
        ['statistic'] = 'STATS',
        ['locate'] = 'LOCALISER'
    }
}

function GaragesNUI:OpenGarageMenu(garageType, garageId, isPound, garageName)
    if self.isOpen then return end
    
    local locale = locales['fr']
    local impoundPrice = 0
    
    if isPound then
        impoundPrice = 500
    end
    
    local ped = PlayerPedId()
    self.originalCoords = GetEntityCoords(ped)
    self.originalHeading = GetEntityHeading(ped)
    
    local previewCoords = GaragePreviewCoords:GetPreviewCoords(garageName or 'pc', isPound)
    self.currentPreviewCoords = previewCoords
    
    ESX.TriggerServerCallback('sunny:garage:myvehicle_nui', function(vehicles)
        local formattedVehicles = {}
        
        if vehicles then
            for k, v in pairs(vehicles) do
                local vehicleProps = json.decode(v.vehicle)
                local state = tonumber(v.state) or 0
                
                table.insert(formattedVehicles, {
                    name = v.label or GetDisplayNameFromVehicleModel(vehicleProps.model) or 'Vehicle',
                    plate = v.plate,
                    model = vehicleProps.model,
                    id = k,
                    status = state,
                    data = v,
                    properties = vehicleProps 
                })
            end
        end
        
        local spawnData = nil
        
        if isPound then
            local poundData = Garages.garage_data.data.Pounds[garageType]
            if poundData and poundData[garageId] then
                spawnData = poundData[garageId]
            end
        else
            spawnData = Garages.garage_data.garages[garageId]
        end
        
        self.currentGarageData = {
            garageType = garageType,
            garageId = garageId,
            isPound = isPound,
            spawnData = spawnData,
            vehicles = formattedVehicles
        }
        
        SendNUIMessage({
            type = 'open',
            vehicles = formattedVehicles,
            locales = locale,
            price = impoundPrice,
            information = 0
        })
        
        self.isOpen = true
        SetNuiFocus(true, true)
    end, isPound)
end

function GaragesNUI:Close()
    if not self.isOpen then return end
    
    self.isOpen = false
    
    SendNUIMessage({ type = 'close' })
    SetNuiFocus(false, false)
    
    if self.previewVehicle and DoesEntityExist(self.previewVehicle) then
        DeleteEntity(self.previewVehicle)
        self.previewVehicle = nil
    end
    
    if self.previewCam then
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(self.previewCam, false)
        self.previewCam = nil
    end
    
    if self.inPreviewMode then
        local ped = PlayerPedId()
        
        TriggerServerEvent('garage:setPreviewInstance', false)
        Citizen.Wait(100)
        
        if self.originalCoords then
            SetEntityCoords(ped, self.originalCoords.x, self.originalCoords.y, self.originalCoords.z, false, false, false, false)
            SetEntityHeading(ped, self.originalHeading)
        end
        
        FreezeEntityPosition(ped, false)
        
        self.inPreviewMode = false
        self.originalCoords = nil
        self.originalHeading = nil
    end
    
    SendNUIMessage({ type = 'hideStats' })
end

function GaragesNUI:CalculateVehicleStats(modelHash)
    local maxSpeed = GetVehicleModelMaxSpeed(modelHash) * 3.6 / 250 * 100
    local acceleration = GetVehicleModelAcceleration(modelHash) / 0.45 * 100
    local brake = GetVehicleModelMaxBraking(modelHash) / 1.25 * 100
    local traction = GetVehicleModelMaxTraction(modelHash) / 3.5 * 100
    
    maxSpeed = math.min(math.max(maxSpeed, 0), 100)
    acceleration = math.min(math.max(acceleration, 0), 100)
    brake = math.min(math.max(brake, 0), 100)
    traction = math.min(math.max(traction, 0), 100)
    
    return {
        maxSpeed = math.floor(maxSpeed),
        acceleration = math.floor(acceleration),
        brake = math.floor(brake),
        traction = math.floor(traction)
    }
end

RegisterNUICallback('hoverVehicle', function(data, cb)
    local modelHash = GetHashKey(data.vehicle)
    local plate = data.plate
    
    if IsModelInCdimage(modelHash) and IsModelAVehicle(modelHash) then
        if not GaragesNUI.inPreviewMode then
            local coords = GaragesNUI.currentPreviewCoords
            if not coords then
                if cb then cb('ok') end
                return
            end
            
            TriggerServerEvent('garage:setPreviewInstance', true)
            Citizen.Wait(100)
            
            local ped = PlayerPedId()
            FreezeEntityPosition(ped, true)
            SetEntityCoords(ped, coords.ped.x, coords.ped.y, coords.ped.z, false, false, false, false)
            SetEntityHeading(ped, coords.ped.w)
            
            GaragesNUI.previewCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            SetCamCoord(GaragesNUI.previewCam, coords.cam.x, coords.cam.y, coords.cam.z)
            PointCamAtCoord(GaragesNUI.previewCam, coords.vehicle.x, coords.vehicle.y, coords.vehicle.z)
            SetCamActive(GaragesNUI.previewCam, true)
            RenderScriptCams(true, true, 500, true, true)
            
            GaragesNUI.inPreviewMode = true
        end
        
        RequestModel(modelHash)
        local timeout = 0
        while not HasModelLoaded(modelHash) and timeout < 100 do
            Wait(10)
            timeout = timeout + 1
        end
        
        if not HasModelLoaded(modelHash) then
            if cb then cb('ok') end
            return
        end
        
        if GaragesNUI.previewVehicle and DoesEntityExist(GaragesNUI.previewVehicle) then
            DeleteEntity(GaragesNUI.previewVehicle)
        end
        
        local coords = GaragesNUI.currentPreviewCoords
        if not coords then
            if cb then cb('ok') end
            return
        end
        
        GaragesNUI.previewVehicle = CreateVehicle(
            modelHash, 
            coords.vehicle.x, 
            coords.vehicle.y, 
            coords.vehicle.z, 
            coords.vehicle.w, 
            false, 
            false
        )
        
        SetVehicleOnGroundProperly(GaragesNUI.previewVehicle)
        SetEntityAsMissionEntity(GaragesNUI.previewVehicle, true, true)
        FreezeEntityPosition(GaragesNUI.previewVehicle, true)
        SetVehicleDoorsLocked(GaragesNUI.previewVehicle, 2)
        SetVehicleUndriveable(GaragesNUI.previewVehicle, true)
        
        if plate then
            local vehicleProps = nil
            
            if GaragesNUI.currentGarageData and GaragesNUI.currentGarageData.vehicles then
                for _, veh in pairs(GaragesNUI.currentGarageData.vehicles) do
                    if veh.plate == plate then
                        vehicleProps = veh.properties
                        break
                    end
                end
            end
            
            if vehicleProps then
                Citizen.Wait(100)
                
                if GaragesNUI.previewVehicle and DoesEntityExist(GaragesNUI.previewVehicle) then
                    ESX.Game.SetVehicleProperties(GaragesNUI.previewVehicle, vehicleProps)
                end
            else
                ESX.TriggerServerCallback('sunny:vehicles:getCustom', function(props)
                    if props and GaragesNUI.previewVehicle and DoesEntityExist(GaragesNUI.previewVehicle) then
                        Citizen.Wait(100)
                        ESX.Game.SetVehicleProperties(GaragesNUI.previewVehicle, props)
                    end
                end, plate)
            end
        end
        
        SetModelAsNoLongerNeeded(modelHash)
    end
    
    if cb then cb('ok') end
end)

RegisterNUICallback('hoverVehicleEnd', function(data, cb)
    if GaragesNUI.previewVehicle and DoesEntityExist(GaragesNUI.previewVehicle) then
        DeleteEntity(GaragesNUI.previewVehicle)
        GaragesNUI.previewVehicle = nil
    end
    
    if cb then cb('ok') end
end)

RegisterNUICallback('getVehicle', function(data, cb)
    if GaragesNUI.isSpawning then
        if cb then cb('ok') end
        return
    end
    
    GaragesNUI.isSpawning = true
    
    local plate = data.plate
    local garageData = GaragesNUI.currentGarageData
    
    if garageData.isPound and data.price > 0 then
        ESX.TriggerServerCallback('sunny:garage:canAffordImpound', function(canAfford)
            if canAfford then
                TriggerServerEvent('sunny:garage:payImpound', data.price)
                GaragesNUI:SpawnVehicle(plate, garageData.garageId)
            else
                ESX.ShowNotification('~r~Vous n\'avez pas assez d\'argent')
                GaragesNUI.isSpawning = false
            end
        end, data.price)
    else
        GaragesNUI:SpawnVehicle(plate, garageData.garageId)
    end
    
    if cb then cb('ok') end
end)

function GaragesNUI:SpawnVehicle(plate, garageId)
    ESX.TriggerServerCallback('sunny:garage:getVehicleByPlate', function(vehicle)
        if not vehicle then
            ESX.ShowNotification('~r~Véhicule introuvable')
            GaragesNUI.isSpawning = false
            return
        end
        
        local vehicleProps = json.decode(vehicle.vehicle)
        local garageData = GaragesNUI.currentGarageData
        local spawnInfo = garageData.spawnData
        
        if not spawnInfo then
            ESX.ShowNotification('~r~Erreur de garage')
            GaragesNUI.isSpawning = false
            return
        end
        
        local spawnPoint, heading
        
        if garageData.isPound then
            if not spawnInfo.pos or #spawnInfo.pos == 0 then
                ESX.ShowNotification('~r~Erreur position fourrière')
                GaragesNUI.isSpawning = false
                return
            end
            local randomPos = spawnInfo.pos[math.random(1, #spawnInfo.pos)]
            spawnPoint = randomPos.spawnPoint
            heading = randomPos.heading or 0
        else
            if not spawnInfo.spawnpos or #spawnInfo.spawnpos == 0 then
                ESX.ShowNotification('~r~Erreur position garage')
                GaragesNUI.isSpawning = false
                return
            end
            local spawnPoints = spawnInfo.spawnpos
            spawnPoint = spawnPoints[math.random(1, #spawnPoints)]
            heading = spawnPoint.h or spawnPoint.heading
            if not heading then
                heading = GetEntityHeading(PlayerPedId())
            end
        end
        
        ESX.TriggerServerCallback('sunny:garage:setVehicleOut', function(success)
            if not success then
                ESX.ShowNotification('~r~Erreur lors de la sortie du véhicule')
                GaragesNUI.isSpawning = false
                return
            end
            
            Citizen.CreateThread(function()
                GaragesNUI:Close()
                
                Citizen.Wait(200)
                
                ESX.Game.SpawnVehicle(vehicleProps.model, vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z), heading, function(spawnedVehicle)
                    Citizen.Wait(100)
                    
                    ESX.Game.SetVehicleProperties(spawnedVehicle, vehicleProps)
                    SetVehicleNumberPlateText(spawnedVehicle, plate)
                    
                    SetVehicleHasBeenOwnedByPlayer(spawnedVehicle, true)
                    SetEntityAsMissionEntity(spawnedVehicle, true, true)
                    SetVehicleNeedsToBeHotwired(spawnedVehicle, false)
                    SetVehRadioStation(spawnedVehicle, 'OFF')
                    SetVehicleEngineOn(spawnedVehicle, false, false, false)
                    
                    SetPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
                    
                    ESX.ShowNotification('~g~Véhicule sorti avec succès')
                    
                    GaragesNUI.isSpawning = false
                end)
            end)
        end, plate, garageData.garageType, garageId, garageData.isPound)
    end, plate)
end

RegisterNUICallback('impoundVehicle', function(data, cb)
    local plate = data.plate
    
    local vehicleFound = false
    local vehicles = ESX.Game.GetVehicles()
    
    for i=1, #vehicles do
        local veh = vehicles[i]
        if DoesEntityExist(veh) then
            local vehPlate = GetVehicleNumberPlateText(veh)
            if vehPlate then
                vehPlate = string.gsub(vehPlate, "^%s*(.-)%s*$", "%1")
                local targetPlate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
                
                if vehPlate == targetPlate then
                    vehicleFound = true
                    ESX.Game.DeleteVehicle(veh)
                    break
                end
            end
        end
    end
    
    ESX.TriggerServerCallback('sunny:garage:setVehicleImpound', function(success)
        if success then
            if vehicleFound then
                ESX.ShowNotification('~y~Véhicule mis en fourrière et supprimé de la carte')
            else
                ESX.ShowNotification('~y~Véhicule mis en fourrière')
            end
        else
            ESX.ShowNotification('~r~Erreur lors de la mise en fourrière')
        end
    end, plate)
    
    if cb then cb('ok') end
end)

RegisterNUICallback('locateVehicle', function(data, cb)
    local plate = data.plate
    
    ESX.TriggerServerCallback('sunny:garage:locateVehicle', function(location)
        if location then
            SetNewWaypoint(location.x, location.y)
            ESX.ShowNotification('~g~Véhicule localisé sur votre GPS')
        else
            ESX.ShowNotification('~r~Impossible de localiser le véhicule')
        end
    end, plate)
    
    if cb then cb('ok') end
end)


RegisterNUICallback('showStatistic', function(data, cb)
    local modelHash = GetHashKey(data.vehicle)
    
    if IsModelInCdimage(modelHash) and IsModelAVehicle(modelHash) then
        local stats = GaragesNUI:CalculateVehicleStats(modelHash)
        SendNUIMessage({
            type = 'showStats',
            specs = stats
        })
    end
    
    if cb then cb('ok') end
end)

RegisterNUICallback('hideStats', function(data, cb)
    SendNUIMessage({ type = 'hideStats' })
    if cb then cb('ok') end
end)

RegisterNUICallback('closeMenu', function(data, cb)
    GaragesNUI:Close()
    if cb then cb('ok') end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if GaragesNUI.isOpen then
            GaragesNUI:Close()
        end
    end
end)

RegisterCommand('opengarage', function()
    GaragesNUI:OpenGarageMenu('car', 1, false, 'pc')
end)
