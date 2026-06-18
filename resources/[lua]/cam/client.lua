-- Variables globales
local camera = nil
local camRotX = 0.0
local camRotY = 0.0
local camRotZ = 0.0
local isAttachedToPed = false
local isStaff = nil
local currentSpeed = Config.Speed.Default
local scaleform = nil
local maxDistancePlayer = Config.MaxDistanceForPlayer
local maxDistanceStaff = Config.MaxDistanceForStaff

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(control)
    N_0xe83a3e3557a56640(control)
end

function setupScaleform(scaleformName)
    local scaleform = RequestScaleformMovie(scaleformName)
    
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end
    
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    
    -- Configuration des boutons de contrôle
    local controls = {
        {slot = 1, bind = Config.Bind.Pivot1, name = Config.MenuName.Pivot1},
        {slot = 2, bind = Config.Bind.Pivot2, name = Config.MenuName.Pivot2},
        {slot = 3, bind = Config.Bind.Down, name = Config.MenuName.Down},
        {slot = 4, bind = Config.Bind.UP, name = Config.MenuName.UP},
        {slot = 5, bind = Config.Bind.Left, name = Config.MenuName.Left},
        {slot = 6, bind = Config.Bind.Right, name = Config.MenuName.Right},
        {slot = 7, bind = Config.Bind.Back, name = Config.MenuName.Back},
        {slot = 8, bind = Config.Bind.Front, name = Config.MenuName.Front}
    }
    
    for _, control in pairs(controls) do
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(control.slot)
        Button(GetControlInstructionalButton(1, control.bind, true))
        ButtonMessage(control.name)
        PopScaleformMovieFunctionVoid()
    end
    
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    
    return scaleform
end

function StartFreeCam(fov)
    ClearFocus()
    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    
    camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", playerCoords, 0, 0, 0, fov * 1.0)
    SetCamActive(camera, true)
    RenderScriptCams(true, false, 0, true, false)
    SetCamAffectsAiming(camera, false)
    
    if isAttachedToPed then
        AttachCamToEntity(camera, playerPed, 0.0, 0.0, 0.0, true)
    end
    
    Citizen.CreateThread(function()
        while camera do
            scaleform = setupScaleform("instructional_buttons")
            Citizen.Wait(1)
            DrawScaleformMovieFullscreen(scaleform)
            
            -- Contrôle de vitesse
            if IsDisabledControlPressed(1, Config.Bind.SpeedBetter) then
                if currentSpeed < Config.Speed.MaxSpeed then
                    currentSpeed = currentSpeed + 0.2
                end
            end
            
            if IsDisabledControlPressed(1, Config.Bind.SpeedSlow) then
                if Config.Speed.MinSpeed < currentSpeed then
                    currentSpeed = currentSpeed - 0.2
                end
            end
            
            if camera then
                ProcessCamControls()
            else
                break
            end
        end
    end)
end

function EndFreeCam()
    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(camera, false)
    
    camRotX = 0.0
    camRotY = 0.0
    camRotZ = 0.0
    camera = nil
end

function CalculateMovementDirection(rotation)
    local frontBack = 0.0
    local leftRight = 0.0
    
    if rotation >= 0.0 and rotation <= 90.0 or rotation <= 0.0 and rotation >= -90.0 then
        leftRight = rotation / 90
        frontBack = 1.0 - math.abs(rotation) / 90
    elseif rotation >= 90.0 and rotation <= 180.0 or rotation <= -90.0 and rotation >= -180.0 then
        if rotation >= 90.0 then
            leftRight = 1.0 - (rotation - 90.0) / 90
        else
            leftRight = -(1.0 + (rotation + 90.0) / 90)
        end
        frontBack = -(math.abs(rotation) - 90.0) / 90
    elseif rotation >= 180.0 and rotation <= 270.0 or rotation <= -180.0 and rotation >= -270.0 then
        if rotation >= 180.0 then
            leftRight = -(rotation - 180.0) / 90
        else
            leftRight = -(rotation + 180.0) / 90
        end
        frontBack = -1.0 + (math.abs(rotation) - 180.0) / 90
    elseif rotation >= 270.0 and rotation <= 360.0 or rotation <= -270.0 and rotation >= -360.0 then
        if rotation >= 270.0 then
            leftRight = -1.0 + (rotation - 270.0) / 90
        else
            leftRight = 1.0 + (rotation + 270.0) / 90
        end
        frontBack = (math.abs(rotation) - 270.0) / 90
    end
    
    return frontBack, leftRight
end

function ProcessCamControls()
    DisableFirstPersonCamThisFrame()
    local playerPed = GetPlayerPed(-1)
    local playerRotation = GetEntityRotation(playerPed, 2)
    local pedRotX, pedRotY, pedRotZ = playerRotation.x, playerRotation.y, playerRotation.z
    
    -- Désactiver les contrôles configurés
    for _, control in pairs(Config.BindDisable) do
        DisableControlAction(0, control, true)
    end
    
    -- Contrôles de la souris
    camRotX = camRotX - GetDisabledControlNormal(1, 2) * 8.0
    camRotZ = camRotZ - GetDisabledControlNormal(1, 1) * 8.0
    
    -- Limites de rotation
    camRotX = math.max(-90.0, math.min(90.0, camRotX))
    camRotY = math.max(-90.0, math.min(90.0, camRotY))
    
    -- Normalisation Z
    if camRotZ > 360.0 then
        camRotZ = camRotZ - 360.0
    elseif camRotZ < -360.0 then
        camRotZ = camRotZ + 360.0
    end
    
    local currentCoords
    if isAttachedToPed then
        local offset = GetOffsetFromEntityGivenWorldCoords(playerPed, GetCamCoord(camera))
        currentCoords = {x = offset.x, y = offset.y, z = offset.z}
    else
        local coords = GetCamCoord(camera)
        currentCoords = {x = coords.x, y = coords.y, z = coords.z}
    end
    
    local newX, newY, newZ = currentCoords.x, currentCoords.y, currentCoords.z
    
    -- Mouvements directionnels
    if IsDisabledControlPressed(1, Config.Bind.Front) then
        local frontBack, leftRight = CalculateMovementDirection(camRotZ)
        newX = newX - currentSpeed * 0.1 * leftRight
        newY = newY + currentSpeed * 0.1 * frontBack
    end
    
    if IsDisabledControlPressed(1, Config.Bind.Back) then
        local frontBack, leftRight = CalculateMovementDirection(camRotZ)
        newX = newX + currentSpeed * 0.1 * leftRight
        newY = newY - currentSpeed * 0.1 * frontBack
    end
    
    if IsDisabledControlPressed(1, Config.Bind.Left) then
        local frontBack, leftRight = CalculateMovementDirection(camRotZ)
        newX = newX - currentSpeed * 0.1 * frontBack
        newY = newY + currentSpeed * 0.1 * leftRight
    end
    
    if IsDisabledControlPressed(1, Config.Bind.Right) then
        local frontBack, leftRight = CalculateMovementDirection(camRotZ)
        newX = newX + currentSpeed * 0.1 * frontBack
        newY = newY - currentSpeed * 0.1 * leftRight
    end
    
    -- Mouvements verticaux
    if IsDisabledControlPressed(1, Config.Bind.UP) then
        newZ = newZ + currentSpeed * 0.1
    end
    
    if IsDisabledControlPressed(1, Config.Bind.Down) then
        newZ = newZ - currentSpeed * 0.1
    end
    
    -- Rotation pivot
    if IsDisabledControlPressed(1, Config.Bind.Pivot2) then
        camRotY = camRotY - currentSpeed * 1.0
        if camRotY < -360.0 then
            camRotY = camRotY + 360.0
        end
    end
    
    if IsDisabledControlPressed(1, Config.Bind.Pivot1) then
        camRotY = camRotY + currentSpeed * 1.0
        if camRotY > 360.0 then
            camRotY = camRotY - 360.0
        end
    end
    
    -- Mise à jour position et focus
    if isAttachedToPed then
        AttachCamToEntity(camera, playerPed, newX, newY, newZ, true)
        SetFocusEntity(playerPed)
        
        local distance = Vdist(0.0, 0.0, 0.0, newX, newY, newZ)
        local maxDistance = isStaff and maxDistanceStaff or maxDistancePlayer
        
        if distance > maxDistance then
            AttachCamToEntity(camera, playerPed, currentCoords.x, currentCoords.y, currentCoords.z, true)
        end
    else
        SetFocusArea(newX, newY, newZ, 0.0, 0.0, 0.0)
        SetCamCoord(camera, newX, newY, newZ)
    end
    
    -- Application de la rotation
    if isAttachedToPed then
        SetCamRot(camera, pedRotX + camRotX, pedRotY + camRotY, pedRotZ + camRotZ, 2)
    else
        SetCamRot(camera, camRotX, camRotY, camRotZ, 2)
    end
end

-- Gestion des permissions
Citizen.CreateThread(function()
    TriggerServerEvent("layoz:receivePermissions")
    while isStaff == nil do
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("layoz:receivePermissions")
AddEventHandler("layoz:receivePermissions", function(hasPermissions)
    isStaff = hasPermissions
end)

-- Variables et commandes
local freeCamActive = false

RegisterKeyMapping(Config.Commande.CommandeName, Config.Commande.Desc, "keyboard", Config.Commande.Bind)

RegisterCommand(Config.Commande.CommandeName, function()
    if Config.AllowPlayerAndStaff then
        if not isStaff then
            isAttachedToPed = true
        else
            if Config.MaxDistanceForStaff ~= false then
                isAttachedToPed = true
            end
        end
        
        if not freeCamActive then
            freeCamActive = true
            StartFreeCam(50)
        else
            freeCamActive = false
            EndFreeCam()
        end
    else
        if isStaff then
            if Config.MaxDistanceForStaff ~= false then
                isAttachedToPed = true
            end
            
            if not freeCamActive then
                freeCamActive = true
                StartFreeCam(50)
            else
                freeCamActive = false
                EndFreeCam()
            end
        end
    end
end)