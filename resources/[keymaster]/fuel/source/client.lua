local FUEL_DECOR = config.fuel_decor
local nozzleDropped = false
local holdingNozzle = false
local nozzleInVehicle = false
local nozzle
local rope
local vehicleFueling
local usedPump
local pumpCoords
local wastingFuel = false
local usingCan = false
local nearTank = false
local ESX = nil

local interactionPoints = {}

function CreateInteractionPoint(coords, text, onPress, options)
    local defaultOptions = {
        dist = 2.0,
        key = 'E',
        icon = 'fa-hand-pointer',
        ped = nil,
        scenario = nil,
        heading = 0.0
    }
    
    local opts = options or {}
    for k, v in pairs(defaultOptions) do
        if opts[k] == nil then
            opts[k] = v
        end
    end
    
    local interactionData = {
        coords = coords,
        dist = opts.dist,
        key = opts.key,
        message = text,
        icon = opts.icon,
        onPress = onPress
    }
    
    if opts.ped then
        interactionData.ped = opts.ped
    end
    if opts.scenario then
        interactionData.scenario = opts.scenario
    end
    if opts.heading then
        interactionData.heading = opts.heading
    end
    
    local id = exports['nv_interact']:addInteractionPoint(interactionData)
    
    table.insert(interactionPoints, id)
    return id
end

function RemoveInteractionPoint(id)
    if id then
        exports['nv_interact']:removeInteractionPoint(id)
        for i, pointId in ipairs(interactionPoints) do
            if pointId == id then
                table.remove(interactionPoints, i)
                break
            end
        end
    end
end

function ClearAllInteractionPoints()
    for _, id in ipairs(interactionPoints) do
        exports['nv_interact']:removeInteractionPoint(id)
    end
    interactionPoints = {}
end

-- Nozzle Z position based on vehicle class.
local nozzleBasedOnClass = {
    0.65, -- Compacts
    0.65, -- Sedans
    0.85, -- SUVs
    0.6, -- Coupes
    0.55, -- Muscle
    0.6, -- Sports Classics
    0.6, -- Sports
    0.55, -- Super
    0.12, -- Motorcycles
    0.8, -- Off-road
    0.7, -- Industrial
    0.6, -- Utility
    0.7, -- Vans
    0.0, -- Cycles
    0.0, -- Boats
    0.0, -- Helicopters
    0.0, -- Planes
    0.6, -- Service
    0.65, -- Emergency
    0.65, -- Military
    0.75, -- Commercial
    0.0 -- Trains
}

-- Shared Core object.
local ESX = exports['es_extended']:getSharedObject()


-- Setting the electric vehicle config keys to hashes.
for _, vehHash in pairs(config.electricVehicles) do
    config.electricVehicles[vehHash] = vehHash
end

-- Get the fuel of a vehicle, which is set to an entity.
function GetFuel(vehicle)
    if not DecorExistOn(vehicle, FUEL_DECOR) then
        return GetVehicleFuelLevel(vehicle)
    end
	return DecorGetFloat(vehicle, FUEL_DECOR)
end

-- Setting the fuel to the vehicle entity using decor.
function SetFuel(vehicle, fuel)
	if type(fuel) == "number" and fuel >= 0 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel)
		DecorSetFloat(vehicle, FUEL_DECOR, GetVehicleFuelLevel(vehicle))
	end
end

-- returns pump position if a player is near it.
function nearPump(coords)
    local entity = nil
    for hash in pairs(config.pumpModels) do
        entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.8, hash, true, true, true)
        if entity ~= 0 then break end
    end
    if config.pumpModels[GetEntityModel(entity)] then
        return GetEntityCoords(entity), entity
    end
end

-- Draws 3D text on coords.
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_x, _y)
end

-- used to load the filling manually animation.
function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Wait(1)
		end
	end
end

-- Used to play the effect of pouring fuel from the nozzle.
function PlayEffect(pdict, pname)
    CreateThread(function()
        local position = GetOffsetFromEntityInWorldCoords(nozzle, 0.0, 0.28, 0.17)
        UseParticleFxAssetNextCall(pdict)
        local pfx = StartParticleFxLoopedAtCoord(pname, position.x, position.y, position.z, 0.0, 0.0, GetEntityHeading(nozzle), 1.0, false, false, false, false)
        Wait(100)
        StopParticleFxLooped(pfx, 0)
    end)
end

-- Getting the vehicle infront if the player.
function vehicleInFront()
    local entity = nil
    local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pedCoords.x, pedCoords.y, pedCoords.z - 1.3, offset.x, offset.y, offset.z, 10, ped, 0)
    local A, B, C, D, entity = GetRaycastResult(rayHandle)
    if IsEntityAVehicle(entity) then
        return entity
    end
end

-- Create nozzle, rope and attach them to the player.
function grabNozzleFromPump()
    -- Sauvegarder les coords de la pompe maintenant
    local currentPump = pump
    local currentPumpHandle = pumpHandle
    if not currentPump or not currentPumpHandle then return end

    LoadAnimDict("anim@am_hold_up@male")
    TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
    Wait(300)
    nozzle = CreateObject(GetHashKey("prop_cs_fuel_nozle"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(nozzle, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    RopeLoadTextures()
    while not RopeAreTexturesLoaded() do
        Wait(0)
    end
    RopeLoadTextures()
    rope = AddRope(currentPump.x, currentPump.y, currentPump.z, 0.0, 0.0, 0.0, 3.0, 1, 1000.0, 0.0, 1.0, false, false, false, 1.0, true)
    while not rope do
        Wait(0)
    end
    ActivatePhysics(rope)
    Wait(50)
    local nozzlePos = GetEntityCoords(nozzle)
    nozzlePos = GetOffsetFromEntityInWorldCoords(nozzle, 0.0, -0.033, -0.195)
    AttachEntitiesToRope(rope, currentPumpHandle, nozzle, currentPump.x, currentPump.y, currentPump.z + 1.45, nozzlePos.x, nozzlePos.y, nozzlePos.z, 5.0, false, false, nil, nil)
    nozzleDropped = false
    holdingNozzle = true
    nozzleInVehicle = false
    vehicleFueling = false
    usedPump = currentPumpHandle
end

-- attach the nozzle to the player.
function grabExistingNozzle()
    AttachEntityToEntity(nozzle, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    nozzleDropped = false
    holdingNozzle = true
    nozzleInVehicle = false
    vehicleFueling = false
end

-- attach nozzle to vehicle.
function putNozzleInVehicle(vehicle, ptankBone, isBike, dontClear, newTankPosition)
    if isBike then
        AttachEntityToEntity(nozzle, vehicle, ptankBone, 0.0 + newTankPosition.x, -0.2 + newTankPosition.y, 0.2 + newTankPosition.z, -80.0, 0.0, 0.0, true, true, false, false, 1, true)
    else
        AttachEntityToEntity(nozzle, vehicle, ptankBone, -0.18 + newTankPosition.x, 0.0 + newTankPosition.y, 0.75 + newTankPosition.z, -125.0, -90.0, -90.0, true, true, false, false, 1, true)
    end
    if not dontClear and IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
        ClearPedTasks(ped)
    end
    nozzleDropped = false
    holdingNozzle = false
    nozzleInVehicle = true
    wastingFuel = false
    vehicleFueling = vehicle
end

-- detach nozzle from everything and hide ui.
function dropNozzle()
    DetachEntity(nozzle, true, true)
    nozzleDropped = true
    holdingNozzle = false
    nozzleInVehicle = false
    vehicleFueling = false
end

-- delete nozzle and rope, and hide ui.
function returnNozzleToPump()
    if nozzle and DoesEntityExist(nozzle) then
        DetachEntity(nozzle, true, true)
        SetEntityAsMissionEntity(nozzle, true, true)
        DeleteEntity(nozzle)
        nozzle = nil
    end
    if rope then
        RopeUnloadTextures()
        DeleteRope(rope)
        rope = nil
    end
    nozzleDropped = false
    holdingNozzle = false
    nozzleInVehicle = false
    vehicleFueling = false
end

-- Get important information.
CreateThread(function()
    while true do
        ped = PlayerPedId()
        pedCoords = GetEntityCoords(ped)
        pump, pumpHandle = nearPump(pedCoords)
        veh = GetVehiclePedIsIn(ped, true)
        Wait(1000)
    end
end)

-- Refuel the vehicle.
CreateThread(function()
    while true do
        if vehicleFueling then
            Wait(600)
        else
            Wait(2000)
        end
        if vehicleFueling then
            local classMultiplier = config.vehicleClasses[GetVehicleClass(vehicleFueling)]
            if usingCan then
                while usingCan do
                    local fuel = GetFuel(vehicleFueling)
                    if fuel < 97 then
                        SetFuel(vehicleFueling, fuel + (2.5 / classMultiplier))
                    else
                        fuel = 100.0
                        SetFuel(vehicleFueling, fuel)
                        vehicleFueling = false
                        usingCan = false
                    end
                    Wait(500)
                end
            else
                local lastFuel = GetFuel(vehicleFueling)

                local cost = 0
                while vehicleFueling do
                    local fuel = GetFuel(vehicleFueling)
                    if not DoesEntityExist(vehicleFueling) then
                        dropNozzle()
                        break
                    end
                    fuel = GetFuel(vehicleFueling)
                    cost = cost + ((2.0 / classMultiplier) * config.fuelCostMultiplier) - math.random(0, 100) / 100

                    if fuel < 97 then
                        SetFuel(vehicleFueling, fuel + ((2.0 / classMultiplier) - math.random(0, 100) / 100))
                    else
                        fuel = 100.0
                        SetFuel(vehicleFueling, fuel)
                        vehicleFueling = false
                        if nozzleInVehicle then
                            grabExistingNozzle()
                        end
                    end
                    Wait(600)
                end

                if cost ~= 0 then
                    TriggerServerEvent("dsco_fuel:pay", cost)
                    cost = 0
                end
            end
        end
    end
end)

-- pumping fuel on the ground.
local wasteFuelPoint = nil
local wasteFuelCost = 0

CreateThread(function()
    while true do
        Wait(1000)
        if wastingFuel then
            if not wasteFuelPoint and nozzleLocation and type(nozzleLocation) == "vector3" then
                wasteFuelPoint = CreateInteractionPoint(
                    nozzleLocation,
                    "GASPILLAGE D'ESSENCE",
                    function() end,
                    { icon = 'fa-exclamation-triangle', dist = 2.0 }
                )
            end
            wasteFuelCost = wasteFuelCost + (2.0 * config.fuelCostMultiplier) - math.random(0, 100) / 100
            Wait(1000)
        else
            if wasteFuelPoint then
                RemoveInteractionPoint(wasteFuelPoint)
                wasteFuelPoint = nil
            end
            if wasteFuelCost ~= 0 then
                TriggerServerEvent("dsco_fuel:pay", wasteFuelCost)
                wasteFuelCost = 0
            end
        end
    end
end)

-- Grabbing and returning the nozzle from the pump.
local pumpInteractionPoint = nil
local returnInteractionPoint = nil
local vehicleFuelPoint = nil

CreateThread(function()
    local wait = 1000
    while true do
        Wait(wait)
        if pump then
            wait = 100
            -- État 1: Pas de nozzle, on peut en prendre un
            if not holdingNozzle and not nozzleInVehicle and not nozzleDropped then
                -- Supprimer l'ancien point si on vient de changer d'état
                if returnInteractionPoint then
                    RemoveInteractionPoint(returnInteractionPoint)
                    returnInteractionPoint = nil
                end
                if not pumpInteractionPoint then
                    pumpInteractionPoint = CreateInteractionPoint(
                        vector3(pump.x, pump.y, pump.z + 1.2),
                        "PRENDRE LE PISTOLET D'ESSENCE",
                        function()
                            grabNozzleFromPump()
                            Wait(1000)
                            ClearPedTasks(ped)
                        end,
                        { icon = 'fa-gas-pump', dist = 2.0 }
                    )
                end
                if IsControlJustPressed(0, 47) then
                    TriggerServerEvent("dsco_fuel:jerryCan", price)
                    if HasPedGotWeapon(ped, 883325847) then
                        SetPedAmmo(ped, 883325847, 4500)
                    else
                        GiveWeaponToPed(ped, 883325847, 4500, false, true)
                        SetPedAmmo(ped, 883325847, 4500)
                    end
                end
            -- État 2: Nozzle en main, on peut le déposer
            elseif holdingNozzle and not nearTank then
                -- Supprimer l'ancien point si on vient de changer d'état
                if pumpInteractionPoint then
                    RemoveInteractionPoint(pumpInteractionPoint)
                    pumpInteractionPoint = nil
                end
                if not returnInteractionPoint then
                    returnInteractionPoint = CreateInteractionPoint(
                        vector3(pump.x, pump.y, pump.z + 1.2),
                        "DÉPOSER LE PISTOLET D'ESSENCE",
                        function()
                            LoadAnimDict("anim@am_hold_up@male")
                            TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                            Wait(300)
                            returnNozzleToPump()
                            Wait(1000)
                            ClearPedTasks(ped)
                        end,
                        { icon = 'fa-undo', dist = 2.0 }
                    )
                end
            -- État 3: Nozzle dans le véhicule
            elseif nozzleInVehicle and vehicleFueling then
                -- Supprimer l'ancien point si on vient de changer d'état
                if pumpInteractionPoint then
                    RemoveInteractionPoint(pumpInteractionPoint)
                    pumpInteractionPoint = nil
                end
                if not returnInteractionPoint then
                    returnInteractionPoint = CreateInteractionPoint(
                        vector3(pedCoords.x, pedCoords.y, pedCoords.z + 1.0),
                        "ARRÊTER LE REMPLISSAGE",
                        function()
                            LoadAnimDict("timetable@gardener@filling_can")
                            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                            Wait(300)
                            grabExistingNozzle()
                            Wait(300)
                            ClearPedTasks(ped)
                        end,
                        { icon = 'fa-stop', dist = 2.0 }
                    )
                end
                if vehicleFueling then
                    fuel = GetFuel(vehicleFueling)
                    vehpos = GetEntityCoords(vehicleFueling)
                    if vehicleFuelPoint then
                        RemoveInteractionPoint(vehicleFuelPoint)
                        vehicleFuelPoint = nil
                    end
                end
            end
        else
            wait = 1000
            if pumpInteractionPoint then
                RemoveInteractionPoint(pumpInteractionPoint)
                pumpInteractionPoint = nil
            end
            if returnInteractionPoint then
                RemoveInteractionPoint(returnInteractionPoint)
                returnInteractionPoint = nil
            end
            if vehicleFuelPoint then
                RemoveInteractionPoint(vehicleFuelPoint)
                vehicleFuelPoint = nil
            end
        end
    end
end)

-- Attaching and taking the nozzle form the vehicle, and dropping the nozzle form the player or vehicle.
local droppedNozzlePoint = nil
local vehicleTankPoint = nil
local vehicleFuelingPoint = nil

CreateThread(function()
    local wait = 1000
    while true do
        Wait(wait)
        if holdingNozzle or nozzleInVehicle or nozzleDropped then
            wait = 100

            -- drop the nozzle and remove it if it's far away from the pump.
            if pump then
                pumpCoords = GetEntityCoords(usedPump)
            end
            if nozzle and pumpCoords then
                nozzleLocation = GetEntityCoords(nozzle)
                if #(nozzleLocation - pumpCoords) > 6.0 then
                    dropNozzle()
                elseif #(pumpCoords - pedCoords) > 100.0 then
                    returnNozzleToPump()
                end
                if nozzleDropped and nozzleLocation and type(nozzleLocation) == "vector3" and #(nozzleLocation - pedCoords) < 1.5 then
                    if not droppedNozzlePoint then
                        droppedNozzlePoint = CreateInteractionPoint(
                            nozzleLocation,
                            "PRENDRE LE TUYAU",
                            function()
                                LoadAnimDict("anim@mp_snowball")
                                TaskPlayAnim(ped, "anim@mp_snowball", "pickup_snowball", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                                Wait(700)
                                grabExistingNozzle()
                                ClearPedTasks(ped)
                            end,
                            { icon = 'fa-hand-paper', dist = 1.5 }
                        )
                    end
                else
                    if droppedNozzlePoint then
                        RemoveInteractionPoint(droppedNozzlePoint)
                        droppedNozzlePoint = nil
                    end
                end
            end

            local veh = vehicleInFront()

            if holdingNozzle and nozzle then
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 24, true)
                if IsDisabledControlPressed(0, 24) then
                    if veh and tankPosition and #(pedCoords - tankPosition) < 1.2 then
                        if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                            LoadAnimDict("timetable@gardener@filling_can")
                            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                        end
                        wastingFuel = false
                        vehicleFueling = veh
                    else
                        if IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                            vehicleFueling = false
                            ClearPedTasks(ped)
                        end
                        if nozzleLocation then
                            wastingFuel = true
                            PlayEffect("core", "veh_trailer_petrol_spray")
                        end
                    end
                else
                    if IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                        vehicleFueling = false
                        ClearPedTasks(ped)
                    end
                    wastingFuel = false
                end
            end

            if nozzleInVehicle and vehicleFueling then
                if IsControlJustPressed(0, 47) then
                    LoadAnimDict("timetable@gardener@filling_can")
                    TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                    Wait(300)
                    grabExistingNozzle()
                    Wait(300)
                    ClearPedTasks(ped)
                end
            end

            if veh then
                local vehClass = GetVehicleClass(veh)
                local zPos = nozzleBasedOnClass[vehClass + 1]
                local isBike = false
                local nozzleModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }
                local textModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }

                if vehClass == 8 and vehClass ~= 13 and not config.electricVehicles[GetHashKey(veh)] then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "engine")
                    end
                    isBike = true
                elseif vehClass ~= 13 and not config.electricVehicles[GetHashKey(veh)] then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank_l")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "hub_lr")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "handle_dside_r")
                        nozzleModifiedPosition.x = 0.1
                        nozzleModifiedPosition.y = -0.5
                        nozzleModifiedPosition.z = -0.6
                        textModifiedPosition.x = 0.55
                        textModifiedPosition.y = 0.1
                        textModifiedPosition.z = -0.2
                    end
                end
                tankPosition = GetWorldPositionOfEntityBone(veh, tankBone)
                if tankPosition and #(pedCoords - tankPosition) < 1.2 then
                    if not nozzleInVehicle and holdingNozzle then
                        nearTank = true

                        local fuel = GetFuel(veh)
                        local vehpos = GetEntityCoords(veh)

                        if vehicleTankPoint then
                            RemoveInteractionPoint(vehicleTankPoint)
                            vehicleTankPoint = nil
                        end
                        local fuel = GetFuel(veh)
                        local message = fuel >= 95 and ("%s%% - RÉSERVOIR PLEIN"):format(math.floor(fuel)) or ("%s%% - METTRE LE PISTOLET D'ESSENCE"):format(math.floor(fuel))
                        local icon = fuel >= 95 and 'fa-ban' or 'fa-gas-pump'
                        
                        vehicleTankPoint = CreateInteractionPoint(
                            vector3(tankPosition.x + textModifiedPosition.x, tankPosition.y + textModifiedPosition.y, tankPosition.z + zPos + textModifiedPosition.z),
                            message,
                            function()
                                if fuel < 95 then
                                    LoadAnimDict("timetable@gardener@filling_can")
                                    TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                                    Wait(300)
                                    putNozzleInVehicle(veh, tankBone, isBike, false, nozzleModifiedPosition)
                                    Wait(300)
                                    ClearPedTasks(ped)
                                end
                            end,
                            { icon = icon, dist = 1.2 }
                        )
                        if vehicleFuelingPoint then
                            RemoveInteractionPoint(vehicleFuelingPoint)
                            vehicleFuelingPoint = nil
                        end
                    elseif nozzleInVehicle then
                        local fuel = GetFuel(veh)
                        local vehpos = GetEntityCoords(veh)

                        if vehicleTankPoint then
                            RemoveInteractionPoint(vehicleTankPoint)
                            vehicleTankPoint = nil
                        end
                        vehicleTankPoint = CreateInteractionPoint(
                            vector3(tankPosition.x + textModifiedPosition.x, tankPosition.y + textModifiedPosition.y, tankPosition.z + zPos + textModifiedPosition.z),
                            ("%s%% - REPRENDRE LE PISTOLET D'ESSENCE"):format(math.floor(fuel)),
                            function()
                                LoadAnimDict("timetable@gardener@filling_can")
                                TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                                Wait(300)
                                grabExistingNozzle()
                                Wait(300)
                                ClearPedTasks(ped)
                            end,
                            { icon = 'fa-undo', dist = 1.2 }
                        )
                        if vehicleFuelingPoint then
                            RemoveInteractionPoint(vehicleFuelingPoint)
                            vehicleFuelingPoint = nil
                        end
                    end
                else
                    if vehicleTankPoint then
                        RemoveInteractionPoint(vehicleTankPoint)
                        vehicleTankPoint = nil
                    end
                    if vehicleFuelingPoint then
                        RemoveInteractionPoint(vehicleFuelingPoint)
                        vehicleFuelingPoint = nil
                    end
                    nearTank = false
                end
            else
                if vehicleTankPoint then
                    RemoveInteractionPoint(vehicleTankPoint)
                    vehicleTankPoint = nil
                end
                if vehicleFuelingPoint then
                    RemoveInteractionPoint(vehicleFuelingPoint)
                    vehicleFuelingPoint = nil
                end
                nearTank = false
            end
        else
            wait = 1000
        end
    end
end)

local jerryCanPoint = nil

CreateThread(function()
    local wait = 1000
    while true do
        Wait(wait)
        if GetSelectedPedWeapon(ped) == 883325847 and not holdingNozzle and not nozzleInVehicle then
            wait = 200
            local veh = vehicleInFront()
            if veh then
                local vehClass = GetVehicleClass(veh)
                local zPos = nozzleBasedOnClass[vehClass + 1]
                local can = GetAmmoInPedWeapon(ped, 883325847)
                local distance = 1.2

                if vehClass == 8 and vehClass ~= 13 and not config.electricVehicles[GetHashKey(veh)] then
                    tankBone = GetEntityBoneIndexByName(veh, "petroltank")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "engine")
                    end
                elseif vehClass == 14 and not config.electricVehicles[GetHashKey(veh)] then
                    tankBone = GetEntityBoneIndexByName(veh, "engine")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "bodyshell")
                    else
                        distance = 2.0
                    end
                elseif vehClass ~= 13 and not config.electricVehicles[GetHashKey(veh)] then
                    tankBone = GetEntityBoneIndexByName(veh, "petroltank_l")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "hub_lr")
                    end
                end
                tankPosition = GetWorldPositionOfEntityBone(veh, tankBone)
                if tankPosition and #(pedCoords - tankPosition) < distance then
                    local fuel = GetFuel(veh)
                    if jerryCanPoint then
                        RemoveInteractionPoint(jerryCanPoint)
                        jerryCanPoint = nil
                    end
                    
                    local message = fuel >= 95 and "RÉSERVOIR PLEIN" or ("%s%% - REMPLIR LE RÉSERVOIR"):format(math.floor(fuel))
                    local icon = fuel >= 95 and 'fa-ban' or 'fa-gas-pump'
                    
                    jerryCanPoint = CreateInteractionPoint(
                        vector3(tankPosition.x, tankPosition.y, tankPosition.z + zPos),
                        message,
                        function()
                            if fuel < 95 then
                                local ammo = GetAmmoInPedWeapon(ped, 883325847)
                                if ammo > 0 then
                                    if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                                        LoadAnimDict("timetable@gardener@filling_can")
                                        TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                                    elseif can and DoesEntityExist(veh) then
                                        SetPedAmmo(ped, 883325847, ammo - 3)
                                        vehicleFueling = veh
                                        usingCan = true
                                    end
                                else
                                    vehicleFueling = false
                                    usingCan = false
                                    if IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                                        ClearPedTasks(ped)
                                        TriggerServerEvent("dsco_fuel:removeJerryCan")
                                    end
                                end
                            end
                        end,
                        { icon = icon, dist = distance }
                    )
                else
                    if jerryCanPoint then
                        RemoveInteractionPoint(jerryCanPoint)
                        jerryCanPoint = nil
                    end
                end
            else
                if jerryCanPoint then
                    RemoveInteractionPoint(jerryCanPoint)
                    jerryCanPoint = nil
                end
            end
        else
            wait = 1000
            if jerryCanPoint then
                RemoveInteractionPoint(jerryCanPoint)
                jerryCanPoint = nil
            end
        end
    end
end)

-- Create blips for each gas station location.
CreateThread(function()
    for _, coords in pairs(config.blipLocations) do
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 361)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Pompe à essence")
        EndTextCommandSetBlipName(blip)
    end
end)

-- vehicle fuel consumption.
CreateThread(function()
    while true do
        Wait(15000)
        local pedVeh = GetVehiclePedIsIn(ped)
        local seat = GetPedInVehicleSeat(pedVeh, -1)
        if pedVeh ~= 0 and seat ~= 0 then
            local vehClass = GetVehicleClass(pedVeh)
            if not DecorExistOn(pedVeh, FUEL_DECOR) then
                SetFuel(pedVeh, math.random(200, 800) / 10)
            end
            local fuel = GetFuel(pedVeh)
            if GetIsVehicleEngineRunning(pedVeh) then
                if fuel < 5.0 then
                    DisableControlAction(0, 71)
                    SetVehicleEngineOn(pedVeh, false, true, true)
                end
                SetFuel(pedVeh, fuel - ((GetVehicleCurrentRpm(pedVeh) * config.vehicleClasses[vehClass]) / 5.1)) -- Diviseur ajusté
            end
        end
    end
end)


-- spawn pumps on the map.
CreateThread(function()
    for _, pumps in pairs(config.addPumps) do
        CreateObject(GetHashKey(pumps.hash), pumps.x, pumps.y, pumps.z - 1.0, true, true, true)
    end
end)

-- Register the fuel decor
CreateThread(function()
    DecorRegister(FUEL_DECOR, 1)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        ClearAllInteractionPoints()
    end
end)

exports("GetFuel", GetFuel)
exports("SetFuel", SetFuel)
