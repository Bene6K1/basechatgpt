local breakSpeed = 10.0
local eps = 0.01
local input = vector3(0, 0, 0)
local previousVelocity = vector3(0, 0, 0)
local offset = vector3(0, 0, 1)
local noClippingEntity = nil

local currentSpeed = tonumber(Config.Staff.NoClip.vitessenormalnoclip)
local minSpeed = 0.1
local maxSpeed = tonumber(Config.Staff.NoClip.vitessespeednoclip)
local slowSpeed = tonumber(Config.Staff.NoClip.vitesseslownoclip)
local speedIncrement = 0.1
local lastSpeedUpdate = 0
local lastScrollTime = 0
local displayHelpText = false

RegisterCommand("wnoclip", function(source, args, rawCommand)
    if not adminManagement.Service then return end
        if Config.Staff.HavePermission('Modules', 'noClip') then 
            if adminManagement.NoClip == true then
                ToggleNoClipMode()
                adminManagement.NoClip = false
            else
                ToggleNoClipMode()
                adminManagement.NoClip = true

            end
        end
end)

RegisterKeyMapping('wnoclip', 'Noclip', 'keyboard', Config.Staff.NoClip.touchewnoclip)


function ToggleNoClipMode()
    return NoClip(not adminManagement.NoClip)
end

function NoClip(bool)
    if (adminManagement.NoClip == false) then
        
        noClippingEntity = PlayerPedId();
        
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false);
            if IsPedDrivingVehicle(PlayerPedId(), veh) then
                noClippingEntity = veh;
            end
        end
        
        local isVeh = IsEntityAVehicle(noClippingEntity);
        
        adminManagement.NoClip = bool;
        SetUserRadioControlEnabled(not adminManagement.NoClip);
        
        if (adminManagement.NoClip) then
            SetEntityAlpha(noClippingEntity, 51, 0)
            CreateThread(function()
                    
                    local clipped = noClippingEntity
                    local pPed = PlayerPedId();
                    local isClippedVeh = isVeh;
                    
                    SetInvincible(true, clipped);
                    
                    if not isClippedVeh then
                        ClearPedTasksImmediately(pPed)
                    end
                    
                    while adminManagement.NoClip do
                        Wait(1);
                        
                        FreezeEntityPosition(clipped, true);
                        SetEntityCollision(clipped, false, false);
                        
                        SetEntityVisible(clipped, false, false);
                        SetLocalPlayerVisibleLocally(true);
                        SetEntityAlpha(clipped, 51, false)
                        
                        SetEveryoneIgnorePlayer(pPed, true);
                        SetPoliceIgnorePlayer(pPed, true);
                        
                        local currentTime = GetGameTimer()
                        if currentTime - lastSpeedUpdate > 200 then
                            if IsControlJustReleased(0, 14) then
                                currentSpeed = math.max(minSpeed, currentSpeed - speedIncrement)
                                lastSpeedUpdate = currentTime
                            elseif IsControlJustReleased(0, 15) then
                                currentSpeed = math.min(maxSpeed, currentSpeed + speedIncrement)
                                lastSpeedUpdate = currentTime
                            end
                        end

                        input = vector3(GetControlNormal(0, 30), GetControlNormal(0, 31), (IsControlAlwaysPressed(1, 38) and 1) or ((IsControlAlwaysPressed(1, 44) and -1) or 0))
                        speed = ((IsControlAlwaysPressed(1, 21) and maxSpeed) or (IsControlAlwaysPressed(1, 19) and slowSpeed) or currentSpeed) * ((isClippedVeh and 2.75) or 1)
                        
                        SetEntityRotation(noClippingEntity, GetGameplayCamRot(0), 0, false)
                        local forward, right, up, c = GetEntityMatrix(noClippingEntity);
                        previousVelocity = Lerp(previousVelocity, (((right * input.x * speed) + (up * -input.z * speed) + (forward * -input.y * speed))), Timestep() * breakSpeed);
                        c = c + previousVelocity
                        SetEntityCoords(noClippingEntity, c - offset, true, true, true, false)

                        local currentTime = GetGameTimer()
                        if IsDisabledControlPressed(0, 14) then
                            currentSpeed = math.max(minSpeed, currentSpeed - speedIncrement)
                            lastScrollTime = currentTime
                            displayHelpText = true
                        elseif IsDisabledControlPressed(0, 15) then
                            currentSpeed = math.min(maxSpeed, currentSpeed + speedIncrement)
                            lastScrollTime = currentTime
                            displayHelpText = true
                        end

                        if displayHelpText then
                            BeginTextCommandDisplayHelp('STRING')
                            AddTextComponentSubstringPlayerName(string.format("Vitesse NoClip: %.1f", currentSpeed))
                            EndTextCommandDisplayHelp(0, false, false, -1)

                            if currentTime - lastScrollTime > 1000 then
                                displayHelpText = false
                            end
                        end
                    
                    end
                    Wait(0);
                    
                    FreezeEntityPosition(clipped, false);
                    SetEntityCollision(clipped, true, true);
                    
                    SetEntityVisible(clipped, true, false);
                    SetLocalPlayerVisibleLocally(true);
                    ResetEntityAlpha(clipped);
                    
                    SetEveryoneIgnorePlayer(pPed, false);
                    SetPoliceIgnorePlayer(pPed, false);
                    ResetEntityAlpha(clipped);
                    
                    currentSpeed = tonumber(Config.Staff.NoClip.vitessenormalnoclip)
                    
                    Wait(500);
                    
                    if isClippedVeh then
                        while (not IsVehicleOnAllWheels(clipped)) and not adminManagement.NoClip do
                            Wait(100);
                        end
                        while not adminManagement.NoClip do
                            Wait(100);
                            if IsVehicleOnAllWheels(clipped) then
                                return SetInvincible(false, clipped);
                            end
                        end
                    else
                        if (IsPedFalling(clipped) and math.abs(1 - GetEntityHeightAboveGround(clipped)) > eps) then
                            while (IsPedStopped(clipped) or not IsPedFalling(clipped)) and not adminManagement.NoClip do
                                Wait(100);
                            end
                        end
                        while not adminManagement.NoClip do
                            Wait(100);
                            if (not IsPedFalling(clipped)) and (not IsPedRagdoll(clipped)) then
                                return SetInvincible(false, clipped);
                            end
                        end
                    end
            end)
        else
            ResetEntityAlpha(noClippingEntity)
        end
    end
end

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
    local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))
    
    if len ~= 0 then
        coords = coords / len
    end
    
    return coords
end

function IsControlAlwaysPressed(inputGroup, control) return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control) end
function IsControlAlwaysJustPressed(inputGroup, control) return IsControlJustPressed(inputGroup, control) or IsDisabledControlJustPressed(inputGroup, control) end
function Lerp(a, b, t)
    if a.x ~= nil then
        return vector3(
            a.x + (b.x - a.x) * t,
            a.y + (b.y - a.y) * t,
            a.z + (b.z - a.z) * t
        )
    end
    return a + (b - a) * t
end
function IsPedDrivingVehicle(ped, veh)
    return ped == GetPedInVehicleSeat(veh, -1);
end
function SetInvincible(val, id)
    SetEntityInvincible(id, val)
    return SetPlayerInvincible(id, val)
end

