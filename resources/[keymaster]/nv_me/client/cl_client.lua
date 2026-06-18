local maxSlots = Config.MaxSlots or 4
local duiSlots = {}
local maxDistance = Config.MaxDistance or 20.0

Config.AnimationTime = 500

function CreateDuiSlot(slotId)
    local screenWidth, screenHeight = GetActiveScreenResolution()
    local duiUrl = "https://cfx-nui-" .. GetCurrentResourceName() .. "/web/index.html"
    
    local dui = CreateDui(duiUrl, screenWidth, screenHeight)
    local duiHandle = GetDuiHandle(dui)
    
    local txdName = "dui_txd_" .. slotId
    local txtName = "dui_txt_" .. slotId
    
    local txd = CreateRuntimeTxd(txdName)
    CreateRuntimeTextureFromDuiHandle(txd, txtName, duiHandle)
    
    RequestStreamedTextureDict(txdName)
    while not HasStreamedTextureDictLoaded(txdName) do
        Wait(0)
    end
    
    duiSlots[slotId] = {
        dui = dui,
        txd = txdName,
        txt = txtName,
        assignedTo = nil,
        expiresAt = 0,
        closingExpiresAt = 0,
        message = "",
        isClosing = false
    }
    
    print(string.format("DUI Slot %d créé avec succès.", slotId))
end

CreateThread(function()
    for i = 1, maxSlots do
        CreateDuiSlot(i)
    end
end)

RegisterNetEvent("displayMe")
AddEventHandler("displayMe", function(playerId, message)
    local currentTime = GetGameTimer()
    local localPed = PlayerPedId()
    local localCoords = GetEntityCoords(localPed)
    
    local targetPlayer = GetPlayerFromServerId(playerId)
    
    if targetPlayer == -1 then
        if Config.Debug then
            print(string.format("[/me] Player %d unknown or not online: %s", playerId, message))
        end
        return
    end
    
    local targetCoords = GetEntityCoords(GetPlayerPed(targetPlayer))
    local distance = #(localCoords - targetCoords)
    
    if distance > Config.MaxDistance then
        if Config.Debug then
            print(string.format("[/me] Player %d is too far away (%f meters): %s, not using a slot.", playerId, distance, message))
        end
        return
    end
    
    local freeSlot = nil
    
    for i = 1, maxSlots do
        local slot = duiSlots[i]
        if not slot.assignedTo or currentTime > slot.expiresAt then
            freeSlot = slot
            break
        end
    end
    
    if not freeSlot then
        if Config.Debug then
            print(string.format("[/me] No free slots available for player %d: %s", playerId, message))
        end
        return
    end
    
    freeSlot.assignedTo = playerId
    freeSlot.expiresAt = currentTime + Config.MessageTime + Config.AnimationTime
    freeSlot.closingExpiresAt = 0
    freeSlot.message = message
    freeSlot.isClosing = false
    
    SendDuiMessage(freeSlot.dui, json.encode({
        type = "open",
        message = message
    }))
end)

RegisterNetEvent("nv_me:displayEntity")
AddEventHandler("nv_me:displayEntity", function(entity, message)
    local currentTime = GetGameTimer()
    if not DoesEntityExist(entity) then return end
    
    -- Check if entity already has a slot
    local targetSlot = nil
    for i = 1, maxSlots do
        if duiSlots[i].assignedEntity == entity then
            targetSlot = duiSlots[i]
            break
        end
    end

    -- If no existing slot, find free one
    if not targetSlot then
        for i = 1, maxSlots do
            local slot = duiSlots[i]
            if (not slot.assignedTo and not slot.assignedEntity) or currentTime > slot.expiresAt then
                targetSlot = slot
                break
            end
        end
    end

    if not targetSlot then return end

    targetSlot.assignedTo = nil
    targetSlot.assignedEntity = entity
    targetSlot.expiresAt = currentTime + Config.MessageTime + Config.AnimationTime
    targetSlot.closingExpiresAt = 0
    targetSlot.message = message
    targetSlot.isClosing = false

    SendDuiMessage(targetSlot.dui, json.encode({
        type = "open",
        message = message
    }))
end)

CreateThread(function()
    DisplayRadar(false)
    
    while true do
        local sleepTime = 1000
        local currentTime = GetGameTimer()
        local localPed = PlayerPedId()
        local localCoords = GetEntityCoords(localPed)
        
        for i = 1, maxSlots do
            local slot = duiSlots[i]
            
            if (slot.assignedTo or slot.assignedEntity) and currentTime < slot.expiresAt then
                local closeTime = slot.expiresAt - Config.AnimationTime
                
                if currentTime >= closeTime and not slot.isClosing then
                    slot.isClosing = true
                    SendDuiMessage(slot.dui, json.encode({
                        type = "close",
                        dui = slot.dui,
                        resource = GetCurrentResourceName()
                    }))
                end
                
                sleepTime = 0
                
                local targetPed = nil
                
                if slot.assignedEntity then
                    if DoesEntityExist(slot.assignedEntity) then
                        targetPed = slot.assignedEntity
                    end
                elseif slot.assignedTo then
                    local targetPlayer = GetPlayerFromServerId(slot.assignedTo)
                    if targetPlayer ~= -1 then
                        targetPed = GetPlayerPed(targetPlayer)
                    end
                end

                if targetPed and DoesEntityExist(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(localCoords - targetCoords)
                    
                    if distance <= maxDistance then
                        if HasEntityClearLosToEntity(localPed, targetPed, 17) then
                            local headBone = GetWorldPositionOfEntityBone(targetPed, GetPedBoneIndex(targetPed, 31086))
                            
                            SetDrawOrigin(headBone.x, headBone.y, headBone.z + 0.3, 0)
                            
                            local fadeRatio = 1.0 - (distance / maxDistance)
                            local opacity = math.max(0.3, fadeRatio)
                            local spriteSize = 0.55 * opacity
                            
                            DrawSprite(slot.txd, slot.txt, 0.0, 0.0, spriteSize, spriteSize, 0.0, 255, 255, 255, 255)
                            
                            ClearDrawOrigin()
                        end
                    end
                end
            end
        end
        
        Wait(sleepTime)
    end
end)

RegisterNUICallback("onCloseAnimationComplete", function(data, cb)
    for i = 1, maxSlots do
        local slot = duiSlots[i]
        if slot.dui == data.dui then
            slot.assignedTo = nil
            slot.message = ""
            slot.isClosing = false
            slot.expiresAt = 0
            slot.closingExpiresAt = 0
            break
        end
    end
    
    cb("ok")
end)

