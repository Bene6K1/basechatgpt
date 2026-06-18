local cameraPositions = {}
cameraPositions.face = {x = 402.92, y = -1000.72, z = -98.45, fov = 10.0}
cameraPositions.body = {x = 402.92, y = -1000.72, z = -99.01, fov = 30.0}
cameraPositions.feet = {x = 402.92, y = -1000.72, z = -99.5, fov = 40.0}

local isCameraTransitioning = false
camSkin = nil
currentCam = nil
cameraHeading = 0.0

function IsCamColliding(startX, startY, startZ, targetPos)
    local hit, _, _, _, entityHit = GetShapeTestResult(
        StartShapeTestCapsule(
            startX, startY, startZ,
            targetPos.x, targetPos.y, targetPos.z,
            0.3,
            1,
            PlayerPedId(),
            7
        )
    )
    return hit ~= 0 and entityHit ~= 0
end

function FindSafeCamPos(pedPos, pedHeading, distance, targetZ)
    local angleStep = 10.0
    
    for angle = 0, 360, angleStep do
        local heading = pedHeading + angle
        local radians = math.rad(heading)
        
        local camX = pedPos.x - (math.sin(radians) * distance)
        local camY = pedPos.y + (math.cos(radians) * distance)
        
        if not IsCamColliding(camX, camY, targetZ, pedPos) then
            return vector3(camX, camY, targetZ)
        end
    end
    
    return nil
end

function CreateSkinCam(cameraType)
    local playerPed = PlayerPedId()
    local pedPos = GetEntityCoords(playerPed)
    local pedHeading = GetEntityHeading(playerPed)
    local cameraDistance = 4.0
    local targetZ
    
    currentCam = cameraType
    
    if cameraType == "face" then
        targetZ = pedPos.z + 0.5
    elseif cameraType == "body" then
        targetZ = pedPos.z
    elseif cameraType == "feet" then
        cameraDistance = cameraDistance - 2.0
        targetZ = pedPos.z - 0.5
    end
    
    local safeCamPos = FindSafeCamPos(pedPos, pedHeading, cameraDistance, targetZ)
    
    if not safeCamPos then
        local fallbackDistance = cameraDistance - 1.5
        safeCamPos = vector3(
            pedPos.x - (math.sin(math.rad(pedHeading)) * fallbackDistance),
            pedPos.y + (math.cos(math.rad(pedHeading)) * fallbackDistance),
            targetZ
        )
    end
    
    local headingToCam = GetHeadingFromVector_2d(pedPos.x - safeCamPos.x, pedPos.y - safeCamPos.y)
    local finalHeading = (headingToCam + 180.0) % 360.0
    
    TaskAchieveHeading(playerPed, finalHeading, 1000)
    
    if camSkin then
        local newCam = CreateCamWithParams(
            "DEFAULT_SCRIPTED_CAMERA",
            safeCamPos.x, safeCamPos.y, safeCamPos.z,
            0.0, 0.0, 0.0,
            cameraPositions[cameraType].fov,
            false,
            0
        )
        
        PointCamAtCoord(newCam, pedPos.x, pedPos.y, targetZ)
        SetCamActiveWithInterp(newCam, camSkin, 2000, true, true)
        camSkin = newCam
    else
        camSkin = CreateCamWithParams(
            "DEFAULT_SCRIPTED_CAMERA",
            safeCamPos.x, safeCamPos.y, safeCamPos.z,
            0.0, 0.0, 0.0,
            cameraPositions[cameraType].fov,
            false,
            0
        )
        
        PointCamAtCoord(camSkin, pedPos.x, pedPos.y, targetZ)
        SetCamActive(camSkin, true)
        RenderScriptCams(true, false, 2000, true, true)
    end
end

function DestroySkinCam()
    if camSkin then
        DestroyCam(camSkin, true)
        cameraHeading = 0.0
        camSkin = nil
        RenderScriptCams(false, false, 0, true, true)
    end
end

RegisterNUICallback("changeCamera", function(data, callback)
    if isCameraTransitioning then
        callback({success = false})
        return
    end
    
    isCameraTransitioning = true
    
    if currentCam ~= data.camera then
        CreateSkinCam(data.camera)
    end
    
    Citizen.CreateThread(function()
        Wait(1000)
        isCameraTransitioning = false
    end)
    
    callback({success = true})
end)

RegisterNUICallback("rotateCamera", function(data, callback)
    if isCameraTransitioning then
        callback({success = false})
        return
    end
    
    isCameraTransitioning = true
    
    local playerPed = PlayerPedId()
    local pedPos = GetEntityCoords(playerPed)
    local currentHeading = GetEntityHeading(playerPed)
    local newHeading = (currentHeading + 180.0) % 360.0
    
    TaskAchieveHeading(playerPed, newHeading, 1000)
    
    Citizen.CreateThread(function()
        Wait(1000)
        isCameraTransitioning = false
    end)
    
    callback({success = true})
end)