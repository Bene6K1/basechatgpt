local Config <const> = require 'dist.modules.[World].nv_keys.config.main'
local canCarjack = false
local isCarjacking = false
local lastCarjackTime = 0

--- makePedFlee(ped)
--- @param ped number
--- @return nil
--- @description Makes the ped flee
local function makePedFlee(ped)
    ClearPedTasks(ped)
    SetPedFleeAttributes(ped, 0, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedKeepTask(ped, true)
    TaskReactAndFleePed(ped, cache.ped)
    TaskSmartFleePed(ped, cache.ped, 100.0, -1, false, false)
    ResetPedLastVehicle(ped)
end

--- carjackVehicle(driver, vehicle)
--- @param driver number
--- @param vehicle number
--- @return nil
--- @description Carjacks the vehicle
local function carjackVehicle(driver, vehicle)
    if not Config.Carjack.status then
        Debug('info', 'Carjacking is disabled in config')
        return
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    Debug('info', 'Starting carjack attempt on vehicle %s', plate)

    -- Check cooldown
    local currentTime = GetGameTimer()
    if currentTime - lastCarjackTime < Config.Carjack.delay then
        Debug('warning', 'Carjack on cooldown for vehicle %s', plate)
        return
    end

    -- Check if already carjacking
    if isCarjacking then
        Debug('warning', 'Already carjacking, ignoring new attempt')
        return
    end

    Debug('info', 'Beginning carjack process for vehicle %s', plate)
    isCarjacking = true
    lastCarjackTime = currentTime
    local occupants = {}
    for seat = -1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 2 do
        local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
        if pedInSeat ~= 0 and not IsPedAPlayer(pedInSeat) then
            occupants [#occupants + 1] = pedInSeat
        end
    end

    CreateThread(function()
        while isCarjacking do
            TaskVehicleTempAction(occupants[1], vehicle, 6, 1)
            Wait(0)
        end
    end)

    for p = 1, #occupants do
        local occupant = occupants[p]

        CreateThread(function()
            Wait(math.random(100, 600))
            local anim = Config.Animations["holdup"]
            lib.requestAnimDict(anim.dict)
            lib.playAnim(occupant, anim.dict, anim.anim, 8.0, -8.0, -1, 49, 0, false, false, false)
            RemoveAnimDict(anim.dict)
            PlayPain(occupant, 6, 0)
        end)
    end

    CreateThread(function()
        while isCarjacking do
            local distance = #(GetEntityCoords(cache.ped) - GetEntityCoords(driver))
            if (IsPedDeadOrDying(driver, false) or distance > 7.5) and lib.progressActive() then
                lib.cancelProgress()
            end
            Wait(100)
        end
    end)

    if lib.progressCircle({
        duration = Config.Carjack.time,
        label = _T('progress.attempting_carjack'),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then
        if cache.weapon and isCarjacking then
            isCarjacking = false
            local weaponGroup = GetWeapontypeGroup(cache.weapon)
            Debug('info', 'Sending carjack callback with weapon group %s', weaponGroup)
            local success = lib.callback.await(Scriptname .. ':server:carjack', false, VehToNet(vehicle), weaponGroup)
            if success then
                Debug('success', 'Carjack successful for vehicle %s', plate)
                for p = 1, #occupants do
                    local ped = occupants[p]
                    CreateThread(function()
                        TaskLeaveVehicle(ped, vehicle, 256)
                        PlayPain(ped, 6, 0)
                        Wait(1250)
                        PlayPain(ped, math.random(7, 8), 0)
                        makePedFlee(ped)
                    end)
                end
            else
                Debug('warning', 'Carjack failed for vehicle %s', plate)
                Notify.SendNotify(_T('error.failed_carjack'), 'error', 3000)
                makePedFlee(driver)
            end
            TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
            Wait(2000)
        end
    else
        makePedFlee(driver)
    end

    if CleanupAllKeyProps then
        CleanupAllKeyProps()
    end

    isCarjacking = false
end

--- checkCarjackAttempts()
--- @return nil
--- @description Checks if the player can carjack
local function checkCarjackAttempts()
    if canCarjack then return end
    canCarjack = true

    CreateThread(function()
        while cache.weapon and not IsBlacklistedWeapon(cache.weapon) do
            local aiming, target = GetEntityPlayerIsFreeAimingAt(cache.playerId)

            if aiming and DoesEntityExist(target) and IsPedInAnyVehicle(target, false) and not IsEntityDead(target) and not IsPedAPlayer(target) then
                local isScriptEntity = GetEntityScript(target)

                if not isScriptEntity then
                    local targetveh = GetVehiclePedIsIn(target, false)

                    if GetPedInVehicleSeat(targetveh, -1) == target and #(GetEntityCoords(cache.ped) - GetEntityCoords(target)) < 5.0 then
                        carjackVehicle(target, targetveh)
                    end
                end
            end
            Wait(100)
        end
        canCarjack = false
    end)
end


if Config.Carjack.status then
    --- @param newWeapon number
    --- @return nil
    --- @description Called when the player changes the weapon
    lib.onCache('weapon', function(newWeapon)
        if not newWeapon then
            canCarjack = false
            return
        end
        if IsBlacklistedWeapon(newWeapon) then return end
        checkCarjackAttempts()
    end)

    checkCarjackAttempts()
end