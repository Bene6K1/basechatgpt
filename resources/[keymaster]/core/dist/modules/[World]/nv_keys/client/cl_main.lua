local Config <const> = require 'dist.modules.[World].nv_keys.config.main'
KeysList = {}
LocksmithsPeds = {}
LocksmithsZones = {}
MyVehicle = nil
IsKeysMenuOpen = false
SessionVehicles = {} -- Track vehicles with temporary session access
RegisterNetEvent(Scriptname .. ':client:addSessionVehicle', function(plate)
    if not plate or plate == '' then return end
    SessionVehicles[plate] = true
    Debug('info', 'Added session vehicle: %s', plate)
end)

RegisterNetEvent('nv_keys:client:spawnCarkeyVehicle', function(model, coords, heading)
    local modelHash = joaat(model)
    
    if togglelocksBind then togglelocksBind:disable(true) end
    if toggleengineBind then toggleengineBind:disable(true) end
    
    RequestModel(modelHash)
    local timeout = GetGameTimer() + 10000
    while not HasModelLoaded(modelHash) do
        if GetGameTimer() > timeout then
            Debug('error', 'Model load timeout for %s', model)
            if togglelocksBind then togglelocksBind:disable(false) end
            if toggleengineBind then toggleengineBind:disable(false) end
            return
        end
        Wait(0)
    end

    local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, heading, true, false)
    if vehicle == 0 then
        Debug('error', 'CreateVehicle failed for %s', model)
        if togglelocksBind then togglelocksBind:disable(false) end
        if toggleengineBind then toggleengineBind:disable(false) end
        return
    end

    SetVehicleOnGroundProperly(vehicle)
    SetVehicleEngineOn(vehicle, false, false, false)
    SetModelAsNoLongerNeeded(modelHash)
    
    TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
    
    Wait(500)
    if togglelocksBind then togglelocksBind:disable(false) end
    if toggleengineBind then toggleengineBind:disable(false) end
    
    Debug('success', 'Spawned carkey vehicle: %s', model)
end)

local keysMenuContext = {
    type = 'nvkeys_keys',
    name = 'main',
    handle = nil
}
local windowsDown = false
local togglelocksBind
local toggleengineBind
local lastVehicle = nil
local lastPickedVehicle = nil

--- onEnteringDriverSeat()
--- @return nil
--- @description Called when the player enters the driver seat
local function onEnteringDriverSeat()
    local vehicle = cache.vehicle
    lastVehicle = vehicle

    CleanupAllKeyProps()

    if toggleengineBind then
    toggleengineBind:disable(false)
    end

    CreateThread(function()
        while cache.seat == -1 do
            if IsControlJustPressed(0, 23) and toggleengineBind then
                toggleengineBind:disable(true)
            end
            Wait(0)
        end
    end)

    local plate = GetVehicleNumberPlateText(vehicle)
    local isVehicleAccessible = GetIsVehicleAccessible(vehicle)
    
    if isVehicleAccessible then 
        Debug('info', 'Vehicle %s is accessible, allowing engine', plate)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true, false)
        return
    end

    Debug('warning', 'Vehicle %s is NOT accessible, blocking engine', plate)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehicleEngineOn(vehicle, false, true, true)
    
    Notify.SendNotify('Vous n\'avez pas les clés de ce véhicule. Rendez-vous chez le serrurier.', 'error', 4000)
    
    CreateThread(function()
        while cache.seat == -1 and cache.vehicle == vehicle do
            isVehicleAccessible = GetIsVehicleAccessible(vehicle)
            
            if isVehicleAccessible then
                Debug('success', 'Keys acquired for vehicle %s, enabling engine', plate)
                SetVehicleEngineOn(vehicle, true, true, false)
                break
            end
            
            SetVehicleEngineOn(vehicle, false, true, true)
            DisableControlAction(0, 71, true)
            Wait(0)
        end
    end)
end

--- ToggleEngine(veh)
--- @param veh number
--- @return nil
--- @description Toggles the engine of the vehicle
function ToggleEngine(veh)
    if not veh then
        Debug('error', 'No vehicle provided to ToggleEngine')
        return
    end

    local plate = GetVehicleNumberPlateText(veh)
    Debug('info', 'Attempting to toggle engine for vehicle %s', plate)

    if IsBlacklistedVehicle(veh) then
        Debug('info', 'Vehicle %s is blacklisted, cannot toggle engine', plate)
        return
    end

    if not GetIsVehicleAccessible(veh) then
        Debug('warning', 'Player does not have keys for vehicle %s, cannot toggle engine', plate)
        Notify.SendNotify('Vous n\'avez pas les clés de ce véhicule.', 'error', 3000)
        return
    end

    local EngineOn = GetIsVehicleEngineRunning(veh)
    Debug('info', 'Vehicle %s engine currently: %s', plate, EngineOn and 'ON' or 'OFF')

    if EngineOn then
        SetVehicleEngineOn(veh, false, false, true)
        Debug('success', 'Turned OFF engine for vehicle %s', plate)
    else
        SetVehicleEngineOn(veh, true, true, true)
        Debug('success', 'Turned ON engine for vehicle %s', plate)
    end
end

--- ToggleLocks(vehicle)
--- @param vehicle number
--- @return nil
--- @description Toggles the locks of the vehicle
function ToggleLocks(vehicle)
    if not vehicle or vehicle == 0 then
        Debug('error', 'No vehicle provided to ToggleLocks')
        return
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    Debug('info', 'Attempting to toggle locks for vehicle %s', plate)

    if IsBlacklistedVehicle(vehicle) then
        Debug('info', 'Vehicle %s is blacklisted, cannot toggle locks', plate)
        return
    end

    -- local isOwnedByPlayer = lib.callback.await(Scriptname .. ':server:isPlayerOwnedVehicle', false, plate)
    
    -- if not isOwnedByPlayer then
    --     Debug('info', 'Cannot lock/unlock non-owned vehicle %s', plate)
    --     Notify.SendNotify('Ce véhicule ne vous appartient pas.', 'error', 3000)
    --     return
    -- end

    local hasKey = HasKeys(plate)
    if Config.Metadata and SessionVehicles[plate] then
        hasKey = true
    end

    if not hasKey then
        Debug('warning', 'Player does not have keys for owned vehicle %s', plate)
        Notify.SendNotify('Vous n\'avez pas les clés de ce véhicule.', 'error', 3000)
        return
    end

    local ped = cache.ped
    local lockStatus, inVehicle = GetVehicleDoorLockStatus(vehicle), IsPedInAnyVehicle(ped, false)
    Debug('info', 'Vehicle %s lock status: %s, player in vehicle: %s', plate, lockStatus, inVehicle)

    if not inVehicle or inVehicle == 0 then
        lib.requestAnimDict(Config.Animations["toggle_lock"].dict)
        lib.playAnim(ped, Config.Animations["toggle_lock"].dict, Config.Animations["toggle_lock"].anim, 3.0, 3.0, -1, 49)
        RemoveAnimDict(Config.Animations["toggle_lock"].dict)
    end

    CreateThread(function()
        if not inVehicle or inVehicle == 0 then Wait(Config.Animations["toggle_lock"].time) end

        if IsEntityPlayingAnim(ped, Config.Animations["toggle_lock"].dict, Config.Animations["toggle_lock"].anim, 3) then
            StopAnimTask(ped, Config.Animations["toggle_lock"].dict, Config.Animations["toggle_lock"].anim, 8.0)
        end

        local lockSound = Config.Sounds["toggle_lock"] and Config.Sounds["toggle_lock"].soundfile or 'lock'
        local unlockSound = Config.Sounds["hold_in_hand"] and Config.Sounds["hold_in_hand"].soundfile or 'keys'
        local chosenSound = (lockStatus == 1) and lockSound or unlockSound

        PlaySoundFromEntity(-1, "Remote_Control_Fob", ped, "PI_Menu_Sounds", 1, 0)

        if chosenSound then
        SendNUIMessage({
            action = 'PLAY_SOUND',
                soundfile = chosenSound,
        })
        end
    end)

    NetworkRequestControlOfEntity(vehicle)
    local newState = lockStatus == 1 and 'lock' or 'unlock'
    Debug('success', 'Toggling vehicle %s to %s state', plate, newState)
    TriggerServerEvent(Scriptname .. ':server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), newState)
    
    local message = lockStatus == 1 and 'Véhicule verrouillé' or 'Véhicule déverrouillé'
    Notify.SendNotify(message, 'success', 2000)

    SetVehicleLights(vehicle, 2)
    Wait(250)
    SetVehicleLights(vehicle, 1)
    Wait(200)
    SetVehicleLights(vehicle, 0)
end

local function DestroyKeysMenu()
    if keysMenuContext.handle then
        RageUI.Visible(keysMenuContext.handle, false)
        RMenu:Delete(keysMenuContext.type, keysMenuContext.name)
        keysMenuContext.handle = nil
    end

    if IsKeysMenuOpen then
        IsKeysMenuOpen = false
        StopAnims('hold_in_hand')
    end
end

local function EnsureKeysMenu()
    if not keysMenuContext.handle then
        RMenu.Add(keysMenuContext.type, keysMenuContext.name, RageUI.CreateMenu('', _T('keys_menu.subtitle')))
        keysMenuContext.handle = RMenu:Get(keysMenuContext.type, keysMenuContext.name)
        if keysMenuContext.handle then
            keysMenuContext.handle.Closed = function()
                DestroyKeysMenu()
            end
        end
    end

    return keysMenuContext.handle
end

local function ToggleTrunkDoor(vehicle)
    if not vehicle or not DoesEntityExist(vehicle) then return end
    local trunkDoor = 5
    local angle = GetVehicleDoorAngleRatio(vehicle, trunkDoor)

    if angle and angle > 0.1 then
        SetVehicleDoorShut(vehicle, trunkDoor, false)
    else
        SetVehicleDoorOpen(vehicle, trunkDoor, false, false)
    end
end

local function ToggleVehicleWindows(vehicle)
    if not vehicle or not DoesEntityExist(vehicle) then return end
    windowsDown = not windowsDown

    for i = 0, 3 do
        if windowsDown then
            if IsVehicleWindowIntact(vehicle, i) then
                RollDownWindow(vehicle, i)
            end
        else
            if not IsVehicleWindowIntact(vehicle, i) then
                RollUpWindow(vehicle, i)
            end
        end
    end
end

local function OpenKeysMenu()
    if not MyVehicle or not DoesEntityExist(MyVehicle) then
        Notify.SendNotify(_T('error.no_near_vehicle'), 'error', 3000)
        return
    end

    if IsKeysMenuOpen then return end

    local menuHandle = EnsureKeysMenu()
    if not menuHandle then return end

    IsKeysMenuOpen = true
    RageUI.Visible(menuHandle, true)

    CreateThread(function()
        while IsKeysMenuOpen do
            if not (MyVehicle and DoesEntityExist(MyVehicle)) then
                DestroyKeysMenu()
                break
            end

            RageUI.IsVisible(menuHandle, function()
                local plate = GetVehicleNumberPlateText(MyVehicle) or '????'
                RageUI.Separator(string.format(_T('keys_menu.vehicle_label'), plate))

                RageUI.Button(_T('keys_menu.lock_unlock'), _T('keys_menu.lock_unlock_desc'), {}, true, {
                    onSelected = function()
                        ToggleLocks(MyVehicle)
                    end
                })

                RageUI.Button(_T('keys_menu.engine'), _T('keys_menu.engine_desc'), {}, true, {
                    onSelected = function()
                        ToggleEngine(MyVehicle)
                    end
                })

                RageUI.Button(_T('keys_menu.trunk'), _T('keys_menu.trunk_desc'), {}, true, {
                    onSelected = function()
                        ToggleTrunkDoor(MyVehicle)
                    end
                })

                RageUI.Button(_T('keys_menu.windows'), _T('keys_menu.windows_desc'), {}, true, {
                    onSelected = function()
                        ToggleVehicleWindows(MyVehicle)
                    end
                })

                local canSearchKeys = GetKeySearchEnabled and GetKeySearchEnabled()
                RageUI.Button(_T('keys_menu.search_keys'), _T('keys_menu.search_keys_desc'), {}, canSearchKeys, {
                    onSelected = function()
                        TriggerEvent(Scriptname .. ':client:startKeySearch')
                    end
                })

                RageUI.Button(_T('keys_menu.close'), nil, {}, true, {
                    onSelected = function()
                        DestroyKeysMenu()
                    end
                })
            end)

            Wait(0)
        end
    end)
end

--- CleanupAllKeyProps()
--- @return nil
--- @description Cleans up all key props and stops all animations
function CleanupAllKeyProps()
    StopAnims('toggle_lock')
    StopAnims('hold_in_hand')
    StopAnims('search_keys')
    StopAnims('hotwire_invehicle')
    StopAnims('hotwire_outsidevehicle')
end

exports('CleanupAllKeyProps', CleanupAllKeyProps)

RegisterCommand('cleanupkeyprops', function()
    CleanupAllKeyProps()
end, false)

togglelocksBind = lib.addKeybind({
    name = 'togglelocks',
    description = 'Verrouiller/Déverrouiller',
    defaultKey = Config.Keys['togglelocks'],
    onPressed = function()
        local vehicle = cache.vehicle or lib.getClosestVehicle(GetEntityCoords(cache.ped), Config.LockDistance, true)
        if vehicle and vehicle ~= 0 then
        ToggleLocks(vehicle)
        end
    end
})

toggleengineBind = lib.addKeybind({
    name = 'toggleengine',
    description = 'Démarrer/Éteindre le moteur',
    defaultKey = Config.Keys['engine'],
    onPressed = function()
        local vehicle = cache.vehicle or lib.getClosestVehicle(GetEntityCoords(cache.ped), Config.LockDistance, true)
        if vehicle and vehicle ~= 0 then
        ToggleEngine(vehicle)
        end
    end
})

if Config.LockNPCDrivingCars or Config.LockNPCParkedCars then
    local isEnteringVehicle = false

    CreateThread(function()
        while true do
            Wait(0)

            local ped = cache.ped

            if not IsPedInAnyVehicle(ped, false) and not IsPlayerDead(PlayerId()) then
                local vehicle = GetVehiclePedIsTryingToEnter(ped)
                if Entity(vehicle).state.doorslockstate then goto continue end

                if DoesEntityExist(vehicle) and not isEnteringVehicle then
                    isEnteringVehicle = true


                    if vehicle ~= lastPickedVehicle
                        and not IsCarImmune(vehicle)
                        and not IsBlacklistedVehicle(vehicle)
                        and not HasKeys(GetVehicleNumberPlateText(vehicle))
                    then
                        lastPickedVehicle = vehicle

                        local plate = GetVehicleNumberPlateText(vehicle)
                        local playerOwned = lib.callback.await(Scriptname .. ':server:isPlayerOwnedVehicle', false, plate)
                        local driver = GetPedInVehicleSeat(vehicle, -1)

                        if driver ~= 0 and not IsPedAPlayer(driver) then
                            if Config.LockNPCDrivingCars then
                                SetVehicleDoorsLocked(vehicle, 2)
                                TriggerServerEvent(Scriptname .. ':server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 'lock')
                            end
                        end

                        if driver == 0 then
                            if not playerOwned and Config.LockNPCParkedCars then
                                SetVehicleDoorsLocked(vehicle, 2)
                                TriggerServerEvent(Scriptname .. ':server:setVehLockState', NetworkGetNetworkIdFromEntity(vehicle), 'lock')
                            end
                        end
                    end
                elseif not IsPedInAnyVehicle(ped, true) and isEnteringVehicle then
                    isEnteringVehicle = false
                end
                ::continue::
            end

            Wait(50)
        end
    end)
end

--- @param newSeat number
--- @return nil
--- @description Called when the player changes the seat
lib.onCache('seat', function(newSeat)
    if newSeat ~= -1 then
        if lastVehicle and Config.Metadata and DoesEntityExist(lastVehicle) then
            local plate = GetVehicleNumberPlateText(lastVehicle)
            if plate and SessionVehicles[plate] then
                SessionVehicles[plate] = nil
                Debug('info', 'Removed vehicle %s from session tracking (player exited)', plate)
            end
        end
        CleanupAllKeyProps()
        lastVehicle = nil
        return
    end
    Wait(0)
    onEnteringDriverSeat()
end)

CreateThread(function()
    if (GetResourceState('ox_inventory') == 'started') then
        exports.ox_inventory:displayMetadata({
            plate = 'Plate',
            ssn = 'SSN'
        })
    end
end)

--[[
    ██████╗  ██████╗  ██████╗ ██████╗     ██╗      ██████╗  ██████╗██╗  ██╗    ███████╗████████╗ █████╗ ████████╗███████╗
    ██╔══██╗██╔═══██╗██╔═══██╗██╔══██╗    ██║     ██╔═══██╗██╔════╝██║ ██╔╝    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██╔════╝
    ██║  ██║██║   ██║██║   ██║██████╔╝    ██║     ██║   ██║██║     █████╔╝     ███████╗   ██║   ███████║   ██║   █████╗
    ██║  ██║██║   ██║██║   ██║██╔══██╗    ██║     ██║   ██║██║     ██╔═██╗     ╚════██║   ██║   ██╔══██║   ██║   ██╔══╝
    ██████╔╝╚██████╔╝╚██████╔╝██║  ██║    ███████╗╚██████╔╝╚██████╗██║  ██╗    ███████║   ██║   ██║  ██║   ██║   ███████╗
    ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚══════╝
]]

AddStateBagChangeHandler('doorslockstate', '', function(bagName, key, value)
    local netId = tonumber(bagName:gsub('entity:', ''), 10)

    local entity = lib.waitFor(function()
        if NetworkDoesEntityExistWithNetworkId(netId) then
            return NetworkGetEntityFromNetworkId(netId)
        end
    end, false, 10000)

    if entity == 0 then return end
    SetVehicleDoorsLocked(entity, value)
end)

--[[
    ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
    ███████╗██║     ██████╔╝██║██████╔╝   ██║       █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║       ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
    ███████║╚██████╗██║  ██║██║██║        ██║       ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝       ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
]]

--- @param resourceName string
--- @return nil
--- @description Called when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() and Framework.GetPlayerData() ~= {} then
        if not Config.Metadata then
            GetKeys()
        else
            CreateLocksmith()
        end

        if cache.seat == -1 then
            onEnteringDriverSeat()
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        KeysList = {}
        SessionVehicles = {}
        local isOpen, text = lib.isTextUIOpen()
        if isOpen then
            lib.hideTextUI()
        end

        CleanupAllKeyProps()
        DestroyKeysMenu()
    end
end)

AddEventHandler('gameEventTriggered', function(name, data)
    if name == 'CEventNetworkEntityDamage' then
        local victim = data[1]
        local isDead = data[6] == 1

        if victim == PlayerPedId() and isDead then
            CleanupAllKeyProps()
        end
    end
end)

--- @return nil
--- @description Called when the player loads
RegisterNetEvent(Scriptname .. ':client:OnPlayerLoaded', function()
    SessionVehicles = {}

    if not Config.Metadata then
        GetKeys()
    else
        CreateLocksmith()
    end
end)

--[[
    ██████╗ ███████╗███████╗ █████╗ ██╗   ██╗██╗  ████████╗    ██╗  ██╗███████╗██╗   ██╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
    ██╔══██╗██╔════╝██╔════╝██╔══██╗██║   ██║██║  ╚══██╔══╝    ██║ ██╔╝██╔════╝╚██╗ ██╔╝    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
    ██║  ██║█████╗  █████╗  ███████║██║   ██║██║     ██║       █████╔╝ █████╗   ╚████╔╝     █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
    ██║  ██║██╔══╝  ██╔══╝  ██╔══██║██║   ██║██║     ██║       ██╔═██╗ ██╔══╝    ╚██╔╝      ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
    ██████╔╝███████╗██║     ██║  ██║╚██████╔╝███████╗██║       ██║  ██╗███████╗   ██║       ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
    ╚═════╝ ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝       ╚═╝  ╚═╝╚══════╝   ╚═╝       ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
]]

--- @param plate string
--- @return nil
--- @description Called when the player sets the owner of the vehicle
RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate)
    TriggerServerEvent(Scriptname .. ':server:AcquireVehicleKeys', plate)
end)

--- @param plate string
--- @return nil
--- @description Called when the player removes the keys from the vehicle
RegisterNetEvent(Scriptname .. ':client:RemoveKeys', function(plate)
    KeysList[plate] = nil
end)

--- @param plate string
--- @return nil
--- @description Called when the player adds the keys to the vehicle
RegisterNetEvent(Scriptname .. ':client:AddKeys', function(plate)
    Debug('success', 'Player received keys for vehicle %s', plate)
    KeysList[plate] = true
    local ped = cache.ped

    Notify.SendNotify(_T('info.you_have_received_the_key'), 'info', 3000)
    if not IsPedInAnyVehicle(ped, false) then
        Debug('info', 'Player not in vehicle, keys added to list')
        return
    end

    local vehicle = GetVehiclePedIsIn(ped, false)
    local vehiclePlate = GetVehicleNumberPlateText(vehicle)
    if plate ~= vehiclePlate then
        Debug('info', 'Player in different vehicle (%s), not turning off engine', vehiclePlate)
        return
    end

    Debug('info', 'Player in matching vehicle, turning off engine')
    SetVehicleEngineOn(vehicle, false, false, false)
end)

--[[
     ██████╗ ██╗██╗   ██╗███████╗    ██╗  ██╗███████╗██╗   ██╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
    ██╔════╝ ██║██║   ██║██╔════╝    ██║ ██╔╝██╔════╝╚██╗ ██╔╝    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
    ██║  ███╗██║██║   ██║█████╗      █████╔╝ █████╗   ╚████╔╝     █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║
    ██║   ██║██║╚██╗ ██╔╝██╔══╝      ██╔═██╗ ██╔══╝    ╚██╔╝      ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║
    ╚██████╔╝██║ ╚████╔╝ ███████╗    ██║  ██╗███████╗   ██║       ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║
     ╚═════╝ ╚═╝  ╚═══╝  ╚══════╝    ╚═╝  ╚═╝╚══════╝   ╚═╝       ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝
]]

--- @param targetId number
--- @return nil
--- @description Called when the player gives the keys to another player
RegisterNetEvent(Scriptname .. ':client:giveKeys', function(targetId)
    local ped = cache.ped
    local targetVehicle = lib.getClosestVehicle(GetEntityCoords(ped), Config.LockDistance, true)
    if not targetVehicle then return end

    local vehPlate = GetVehicleNumberPlateText(targetVehicle)
    if not vehPlate then return end

    if not HasKeys(vehPlate) then
        Notify.SendNotify(_T('error.no_keys'), 'error', 3000)
        return
    end

    if targetId and type(targetId) == 'number' then -- Give keys to specific ID
        GiveKeys(targetId, vehPlate)
    elseif IsPedSittingInVehicle(PlayerPedId(), targetVehicle) then -- Give keys to driver
        GiveKeys(GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(targetVehicle, -1))), vehPlate)
    else
        local _playerId, playerPed, _playerCoords = lib.getClosestPlayer(GetEntityCoords(ped), 5.0, false)
        if playerPed then
            GiveKeys(GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerPed)), vehPlate)
        end
    end
end)

--[[
    ██╗  ██╗███████╗██╗   ██╗    ██╗   ██╗██╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
    ██║ ██╔╝██╔════╝╚██╗ ██╔╝    ██║   ██║██║    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
    █████╔╝ █████╗   ╚████╔╝     ██║   ██║██║    █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║
    ██╔═██╗ ██╔══╝    ╚██╔╝      ██║   ██║██║    ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║
    ██║  ██╗███████╗   ██║       ╚██████╔╝██║    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║
    ╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═════╝ ╚═╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝
]]

--- @param plate string
--- @param vehicleOwned boolean
--- @return nil
--- @description Called when the player uses the vehicle key
RegisterNetEvent(Scriptname .. ':client:usedVehicleKey', function(plate, vehicleOwned)
    local vehicles = lib.getNearbyVehicles(GetEntityCoords(cache.ped), Config.LockDistance, true)
    if #vehicles == 0 then
        Notify.SendNotify(_T('error.no_near_vehicle'), 'error', 3000)
        return
    end

    MyVehicle = nil

    for _, data in pairs(vehicles) do
        local vehiclePlate = GetVehicleNumberPlateText(data.vehicle)
        if vehiclePlate == plate then
            MyVehicle = data.vehicle
            break
        end
    end

    if not MyVehicle then
        Notify.SendNotify(_T('error.no_near_vehicle'), 'error', 3000)
        return
    end

    SendNUIMessage({
        action = 'PLAY_SOUND',
        soundfile = Config.Sounds["hold_in_hand"].soundfile,
    })

    lib.requestAnimDict(Config.Animations["hold_in_hand"].dict)
    lib.playAnim(cache.ped, Config.Animations["hold_in_hand"].dict, Config.Animations["hold_in_hand"].anim, 3.0, 3.0, -1, 49)
    RemoveAnimDict(Config.Animations["hold_in_hand"].dict)

    OpenKeysMenu()
end)

--[[
    ██╗      ██████╗  ██████╗██╗  ██╗██████╗ ██╗ ██████╗██╗  ██╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
    ██║     ██╔═══██╗██╔════╝██║ ██╔╝██╔══██╗██║██╔════╝██║ ██╔╝    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
    ██║     ██║   ██║██║     █████╔╝ ██████╔╝██║██║     █████╔╝     █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║
    ██║     ██║   ██║██║     ██╔═██╗ ██╔═══╝ ██║██║     ██╔═██╗     ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║
    ███████╗╚██████╔╝╚██████╗██║  ██╗██║     ██║╚██████╗██║  ██╗    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║
    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝
]]

--- @param isAdvanced boolean
--- @return nil
--- @description Called when the player uses the lockpick
RegisterNetEvent('lockpicks:UseLockpick', function()
    Notify.SendNotify(_T('info.keys_require_locksmith') or 'Les véhicules PNJ ne nécessitent plus de crochetage.', 'info', 4000)
end)

--[[
     █████╗ ██████╗ ███╗   ███╗██╗███╗   ██╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
    ██╔══██╗██╔══██╗████╗ ████║██║████╗  ██║    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
    ███████║██║  ██║██╔████╔██║██║██╔██╗ ██║    █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║
    ██╔══██║██║  ██║██║╚██╔╝██║██║██║╚██╗██║    ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║
    ██║  ██║██████╔╝██║ ╚═╝ ██║██║██║ ╚████║    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║
    ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝
]]

-- ██╗  ██╗ ██████╗ ████████╗██╗    ██╗██╗██████╗ ███████╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
-- ██║  ██║██╔═══██╗╚══██╔══╝██║    ██║██║██╔══██╗██╔════╝    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
-- ███████║██║   ██║   ██║   ██║ █╗ ██║██║██████╔╝█████╗      █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
-- ██╔══██║██║   ██║   ██║   ██║███╗██║██║██╔══██╗██╔══╝      ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
-- ██║  ██║╚██████╔╝   ██║   ╚███╔███╔╝██║██║  ██║███████╗    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
-- ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚══╝╚══╝ ╚═╝╚═╝  ╚═╝╚══════╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝

-- Hotwire mini-game removed
