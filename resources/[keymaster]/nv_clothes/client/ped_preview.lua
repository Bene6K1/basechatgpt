PedPreview = {
    ped = nil,
    enabled = true,
    updateQueued = false
}

local componentMappings = {
    { componentId = 8, drawable = 'tshirt_1', texture = 'tshirt_2' },
    { componentId = 11, drawable = 'torso_1', texture = 'torso_2' },
    { componentId = 3, drawable = 'arms', texture = 'arms_2' },
    { componentId = 10, drawable = 'decals_1', texture = 'decals_2' },
    { componentId = 4, drawable = 'pants_1', texture = 'pants_2' },
    { componentId = 6, drawable = 'shoes_1', texture = 'shoes_2' },
    { componentId = 1, drawable = 'mask_1', texture = 'mask_2' },
    { componentId = 9, drawable = 'bproof_1', texture = 'bproof_2' },
    { componentId = 7, drawable = 'chain_1', texture = 'chain_2' },
    { componentId = 5, drawable = 'bags_1', texture = 'bags_2' },
}

local propMappings = {
    { propId = 0, drawable = 'helmet_1', texture = 'helmet_2' },
    { propId = 1, drawable = 'glasses_1', texture = 'glasses_2' },
    { propId = 2, drawable = 'ears_1', texture = 'ears_2' },
    { propId = 6, drawable = 'watches_1', texture = 'watches_2' },
    { propId = 7, drawable = 'bracelets_1', texture = 'bracelets_2' },
}

local function setComponentVariation(ped, mapping, skinData)
    local drawable = skinData[mapping.drawable]
    local texture = skinData[mapping.texture]

    if drawable == nil and texture == nil then return end

    local currentDrawable = GetPedDrawableVariation(ped, mapping.componentId)
    local currentTexture = GetPedTextureVariation(ped, mapping.componentId)

    drawable = drawable ~= nil and drawable or currentDrawable
    texture = texture ~= nil and texture or currentTexture

    if drawable ~= nil and texture ~= nil then
        SetPedComponentVariation(ped, mapping.componentId, drawable, texture, 2)
    end
end

local function setPropVariation(ped, mapping, skinData)
    local drawable = skinData[mapping.drawable]
    local texture = skinData[mapping.texture]

    if drawable == nil and texture == nil then return end

    if drawable == nil then
        drawable = GetPedPropIndex(ped, mapping.propId)
    end

    if texture == nil then
        texture = GetPedPropTextureIndex(ped, mapping.propId)
    end

    if drawable == nil or drawable == -1 then
        ClearPedProp(ped, mapping.propId)
    else
        SetPedPropIndex(ped, mapping.propId, drawable, texture or 0, true)
    end
end

function PedPreview.applySkinData(skinData)
    if not PedPreview.ped or not skinData then return end

    for i = 1, #componentMappings do
        setComponentVariation(PedPreview.ped, componentMappings[i], skinData)
    end

    for i = 1, #propMappings do
        setPropVariation(PedPreview.ped, propMappings[i], skinData)
    end
end

function PedPreview.getSex()
    local pedModel = GetEntityModel(PlayerPedId())
    return pedModel == GetHashKey("mp_m_freemode_01") and "male" or "female"
end

function PedPreview.getHeadBlendData(ped)
    local data = {
        Citizen.InvokeNative(
            0x2746BD9D88C5C5D0,
            ped,
            Citizen.PointerValueIntInitialized(0),
            Citizen.PointerValueIntInitialized(0),
            Citizen.PointerValueIntInitialized(0),
            Citizen.PointerValueIntInitialized(0),
            Citizen.PointerValueIntInitialized(0),
            Citizen.PointerValueIntInitialized(0),
            Citizen.PointerValueFloatInitialized(0),
            Citizen.PointerValueFloatInitialized(0),
            Citizen.PointerValueFloatInitialized(0)
        )
    }
    
    return {
        shapeFirst = data[1],
        shapeSecond = data[2],
        shapeThird = data[3],
        skinFirst = data[4],
        skinSecond = data[5],
        skinThird = data[6],
        shapeMix = data[7],
        skinMix = data[8],
        thirdMix = data[9]
    }
end

function PedPreview.update()
    if not PedPreview.ped or not DoesEntityExist(PedPreview.ped) then
        return
    end
    
    local playerPed = PlayerPedId()
    
    local headBlendData = PedPreview.getHeadBlendData(playerPed)
    SetPedHeadBlendData(
        PedPreview.ped,
        headBlendData.shapeFirst,
        headBlendData.shapeSecond,
        headBlendData.shapeThird,
        headBlendData.skinFirst,
        headBlendData.skinSecond,
        headBlendData.skinThird,
        headBlendData.shapeMix,
        headBlendData.skinMix,
        headBlendData.thirdMix,
        false
    )
    
    for i = 0, 19 do
        local feature = GetPedFaceFeature(playerPed, i)
        SetPedFaceFeature(PedPreview.ped, i, feature)
    end
    
    for componentId = 0, 11 do
        local drawable = GetPedDrawableVariation(playerPed, componentId)
        local texture = GetPedTextureVariation(playerPed, componentId)
        local palette = GetPedPaletteVariation(playerPed, componentId)
        
        SetPedComponentVariation(PedPreview.ped, componentId, drawable, texture, palette)
    end
    
    for propId = 0, 7 do
        local propIndex = GetPedPropIndex(playerPed, propId)
        
        if propIndex ~= -1 then
            local propTexture = GetPedPropTextureIndex(playerPed, propId)
            ClearPedProp(PedPreview.ped, propId)
            SetPedPropIndex(PedPreview.ped, propId, propIndex, propTexture, true)
        else
            ClearPedProp(PedPreview.ped, propId)
        end
    end
end

function PedPreview.queueUpdate()
    if PedPreview.updateQueued then return end
    
    PedPreview.updateQueued = true
    
    CreateThread(function()
        Wait(100)
        PedPreview.update()
        PedPreview.updateQueued = false
    end)
end

function PedPreview.toggle(show)
    if not PedPreview.enabled then
        return
    end
    
    if show and PedPreview.ped then
        return
    end
    
    local menuName = "FE_MENU_VERSION_EMPTY_NO_BACKGROUND"
    
    if show then
        local currentMenu = GetCurrentFrontendMenuVersion()
        SetFrontendActive(true)
        
        if currentMenu ~= joaat(menuName) then
            ActivateFrontendMenu(GetHashKey(menuName), false, -1)
            Wait(100)
        end
        
        SetMouseCursorVisible(false)
        
        local playerPed = PlayerPedId()
        PedPreview.ped = ClonePed(playerPed, false, false, false)
        
        local coords = GetEntityCoords(playerPed)
        SetEntityCoords(PedPreview.ped, coords.x, coords.y, coords.z - 1.0)
        
        SetEntityCollision(PedPreview.ped, false, false)
        SetEntityAsMissionEntity(PedPreview.ped, true, true)
        SetBlockingOfNonTemporaryEvents(PedPreview.ped, true)
        SetEntityInvincible(PedPreview.ped, true)
        ReplaceHudColourWithRgba(117, 0, 0, 0, 0)
        FreezeEntityPosition(PedPreview.ped, true)
        SetPedCombatAbility(PedPreview.ped, 0)
        N_0x4668d80430d6c299(PedPreview.ped)
        
        GivePedToPauseMenu(PedPreview.ped, 1)
        SetPauseMenuPedLighting(true)
        SetPauseMenuPedSleepState(1)
        SetMouseCursorVisible(false)
        
        CreateThread(function()
            while PedPreview.ped do
                Wait(1)
                SetMouseCursorVisible(false)
            end
        end)
    else
        if PedPreview.ped then
            SetPauseMenuPedLighting(false)
            SetFrontendActive(false)
            SetPauseMenuPedSleepState(false)
            
            GivePedToPauseMenu(PedPreview.ped, 0)
            
            if DoesEntityExist(PedPreview.ped) then
                DeletePed(PedPreview.ped)
            end
            
            PedPreview.ped = nil
            
            local currentMenu = GetCurrentFrontendMenuVersion()
            if currentMenu == joaat(menuName) then
                ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_EMPTY_NO_BACKGROUND"), true, -1)
            end
            
            ReplaceHudColourWithRgba(117, 0, 0, 0, 200)
        end
    end
end

RegisterCommand("pedfix", function()
    local menuName = "FE_MENU_VERSION_EMPTY_NO_BACKGROUND"
    local currentMenu = GetCurrentFrontendMenuVersion()
    
    if currentMenu ~= joaat(menuName) then
        return
    end
    
    SetPauseMenuPedLighting(false)
    SetFrontendActive(false)
    SetPauseMenuPedSleepState(false)
    ActivateFrontendMenu(GetHashKey(menuName), true, -1)
    ReplaceHudColourWithRgba(117, 0, 0, 0, 200)
end, false)

AddEventHandler("onClientResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() or resourceName == "ox_inventory" then
        Wait(0)
        PedPreview.toggle(false)
    end
end)

AddStateBagChangeHandler("invOpen", nil, function(bagName, key, value, reserved, replicated)
    local player = GetPlayerFromStateBagName(bagName)
    
    if not player or player == 0 then
        return
    end
    
    local playerPed = GetPlayerPed(player)
    if playerPed ~= PlayerPedId() then
        return
    end
    
    PedPreview.toggle(value)
end)

AddEventHandler('skinchanger:modelLoaded', function()
    Wait(500)
    PedPreview.queueUpdate()
end)

AddEventHandler('skinchanger:change', function()
    PedPreview.queueUpdate()
end)

RegisterNetEvent('nv_clothes:updatePedPreview', function()
    PedPreview.queueUpdate()
end)

exports('updatePedPreview', function()
    PedPreview.update()
end)

exports('togglePedPreview', function(enabled)
    PedPreview.enabled = enabled
end)

exports('applyPreviewSkin', function(skinData)
    PedPreview.applySkinData(skinData)
end)

exports('resetPreviewSkin', function()
    PedPreview.update()
end)

CreateThread(function()
    local wasOpen = false
    
    while true do
        Wait(500)
        
        local success, isOpen = pcall(function()
            return exports.ox_inventory:isOpen()
        end)
        
        if success and isOpen ~= nil then
            if isOpen ~= wasOpen then
                PedPreview.toggle(isOpen)
                wasOpen = isOpen
            end
        end
    end
end)

