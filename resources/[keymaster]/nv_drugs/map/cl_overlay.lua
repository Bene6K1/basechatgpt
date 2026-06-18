


local MinimapOverlay = {}
MinimapOverlay.overlayHandle = 0
MinimapOverlay.createdRuntimeTxd = {}
MinimapOverlay.customOverlayIndices = {}
MinimapOverlay.customOverlayTags = {}


function InitializeOverlay()
    if MinimapOverlay.overlayHandle ~= 0 then
        return MinimapOverlay.overlayHandle
    end

    local handle = AddMinimapOverlay("MINIMAP_LOADER.gfx")

    if handle ~= 0 then

        while not HasMinimapOverlayLoaded(handle) do
            Wait(0)
        end


        SetMinimapOverlayDisplay(handle, 0.0, 0.0, 100.0, 100.0, 100.0)
        MinimapOverlay.overlayHandle = handle
    else
        MinimapOverlay.overlayHandle = 1
    end

    return MinimapOverlay.overlayHandle
end


function LoadTextureDict(txdName)
    if HasStreamedTextureDictLoaded(txdName) then
        return
    end

    RequestStreamedTextureDict(txdName, false)

    while not HasStreamedTextureDictLoaded(txdName) do
        Wait(0)
    end
end


exports("isOverlayReady", function()
    InitializeOverlay()
    return MinimapOverlay.overlayHandle ~= 0
end)


CreateThread(function()
    InitializeOverlay()
end)


exports("clearCustomOverlays", function()
    if MinimapOverlay.overlayHandle == 0 then
        return
    end


    for i = #MinimapOverlay.customOverlayIndices, 1, -1 do
        CallMinimapScaleformFunction(MinimapOverlay.overlayHandle, "REM_OVERLAY")
        ScaleformMovieMethodAddParamInt(MinimapOverlay.customOverlayIndices[i])
        EndScaleformMovieMethod()
    end


    MinimapOverlay.customOverlayIndices = {}
    MinimapOverlay.customOverlayTags = {}
    MinimapOverlay.createdRuntimeTxd = {}
end)


exports("removeCustomOverlayByTag", function(tag)
    if MinimapOverlay.overlayHandle == 0 or not tag then
        return
    end

    local tagStr = tostring(tag)
    local overlayIndex = MinimapOverlay.customOverlayTags[tagStr]

    if not overlayIndex then
        return
    end


    CallMinimapScaleformFunction(MinimapOverlay.overlayHandle, "REM_OVERLAY")
    ScaleformMovieMethodAddParamInt(overlayIndex)
    EndScaleformMovieMethod()


    for tagKey, index in pairs(MinimapOverlay.customOverlayTags) do
        if index > overlayIndex then
            MinimapOverlay.customOverlayTags[tagKey] = index - 1
        end
    end


    for i = 1, #MinimapOverlay.customOverlayIndices do
        if MinimapOverlay.customOverlayIndices[i] == overlayIndex then
            table.remove(MinimapOverlay.customOverlayIndices, i)
            break
        end
    end


    for i = 1, #MinimapOverlay.customOverlayIndices do
        if MinimapOverlay.customOverlayIndices[i] > overlayIndex then
            MinimapOverlay.customOverlayIndices[i] = MinimapOverlay.customOverlayIndices[i] - 1
        end
    end

    MinimapOverlay.customOverlayTags[tagStr] = nil
end)


function WaitForTextureReady(txdName, textureName, duiHandle, runtimeTxd, maxAttempts, delayMs)
    for attempt = 1, maxAttempts do
        CreateRuntimeTextureFromDuiHandle(runtimeTxd, textureName, duiHandle)
        LoadTextureDict(txdName)

        local width, height = table.unpack(GetTextureResolution(txdName, textureName))

        if width and height and width >= 32 and height >= 32 then
            return true, width, height
        end

        Wait(delayMs)
    end

    return false, nil, nil
end


exports("addOverlaySpriteFromDuiHandle", function(duiHandle, txdName, textureName, posX, posY, scaleX, scaleY, alpha, isVisible, rotation, tag)
    InitializeOverlay()

    if not duiHandle then
        return false
    end


    local runtimeTxd = MinimapOverlay.createdRuntimeTxd[txdName]
    if not runtimeTxd then
        runtimeTxd = CreateRuntimeTxd(txdName)
        MinimapOverlay.createdRuntimeTxd[txdName] = runtimeTxd
    end


    local textureReady, textureWidth, textureHeight = WaitForTextureReady(txdName, textureName, duiHandle, runtimeTxd, 80, 200)


    if not textureReady then
        textureReady, textureWidth, textureHeight = WaitForTextureReady(txdName, textureName, duiHandle, runtimeTxd, 3, 800)
    end


    if not textureReady then
        CreateRuntimeTextureFromDuiHandle(runtimeTxd, textureName, duiHandle)
        LoadTextureDict(txdName)
        textureWidth, textureHeight = table.unpack(GetTextureResolution(txdName, textureName))

        if not (textureWidth and textureHeight and textureWidth >= 32 and textureHeight >= 32) then
            return false
        end
    end


    if not (textureWidth and textureWidth ~= 0 and textureHeight and textureHeight ~= 0) then
        return false
    end


    local scalePercentX = (scaleX / textureWidth) * 100.0
    local scalePercentY = (scaleY / textureHeight) * 100.0


    alpha = math.floor(math.abs(alpha or 100))
    isVisible = isVisible ~= false
    rotation = (rotation or 0.0) * 1.0


    if tag ~= nil then
        local tagStr = tostring(tag)
        local existingIndex = MinimapOverlay.customOverlayTags[tagStr]

        if existingIndex ~= nil then
            CallMinimapScaleformFunction(MinimapOverlay.overlayHandle, "REM_OVERLAY")
            ScaleformMovieMethodAddParamInt(existingIndex)
            EndScaleformMovieMethod()


            for otherTag, otherIndex in pairs(MinimapOverlay.customOverlayTags) do
                if otherIndex > existingIndex then
                    MinimapOverlay.customOverlayTags[otherTag] = otherIndex - 1
                end
            end


            for i = 1, #MinimapOverlay.customOverlayIndices do
                if MinimapOverlay.customOverlayIndices[i] == existingIndex then
                    table.remove(MinimapOverlay.customOverlayIndices, i)
                    break
                end
            end


            for i = 1, #MinimapOverlay.customOverlayIndices do
                if MinimapOverlay.customOverlayIndices[i] > existingIndex then
                    MinimapOverlay.customOverlayIndices[i] = MinimapOverlay.customOverlayIndices[i] - 1
                end
            end

            MinimapOverlay.customOverlayTags[tagStr] = nil
        end
    end


    CallMinimapScaleformFunction(MinimapOverlay.overlayHandle, "ADD_SCALED_OVERLAY")
    _ENV["ScaleformMovieMethodAddParamTextureNameString"](txdName)
    _ENV["ScaleformMovieMethodAddParamTextureNameString"](textureName)
    ScaleformMovieMethodAddParamFloat(posX)
    ScaleformMovieMethodAddParamFloat(posY)
    ScaleformMovieMethodAddParamFloat(rotation)
    ScaleformMovieMethodAddParamFloat(scalePercentX)
    ScaleformMovieMethodAddParamFloat(scalePercentY)
    ScaleformMovieMethodAddParamInt(alpha)
    ScaleformMovieMethodAddParamBool(isVisible)
    EndScaleformMovieMethod()


    local newIndex = #MinimapOverlay.customOverlayIndices
    table.insert(MinimapOverlay.customOverlayIndices, newIndex)

    if tag ~= nil then
        MinimapOverlay.customOverlayTags[tostring(tag)] = newIndex
    end

    return true
end)