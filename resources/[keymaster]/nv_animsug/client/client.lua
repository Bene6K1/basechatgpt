CURRENT_SUGGESTION = nil
CURRENT_KEY = nil
CURRENT_PROP = nil
PLAYING_ANIM = false
COOLDOWN = false
HELD_PROP = nil
LAST_MOVEMENT = 0
LAST_COMBAT = 0
GREETED_PEDS = {}
KEYBIND_STYLE_SET = false

RegisterKeyMapping("suggestanim", L("Play suggested animation"), "keyboard", Config.keybinds.play.key)

RegisterCommand("suggestanim", function()
    PlaySuggestedAnim()
end, false)

function StartCooldown()
    if COOLDOWN then
        return
    end
    Citizen.CreateThread(function()
        COOLDOWN = true
        Citizen.Wait(Config.cooldown or 1200)
        COOLDOWN = false
    end)
end

function PlaySuggestedAnim()
    if nil == CURRENT_SUGGESTION or COOLDOWN then
        return
    end

    local playerPed = PlayerPedId()
    StartCooldown()

    if CURRENT_SUGGESTION.useChairSystem then
        if CURRENT_PROP and CURRENT_PROP ~= 0 then
            TriggerEvent("chair:sit", CURRENT_PROP)
            Debug("Utilisation du système Chair avec l'entité:", CURRENT_PROP)
            return
        else
            ExecuteCommand('sit')
            return
        end
    end

    local wasPlaying = PLAYING_ANIM
    if wasPlaying then
        FreezeEntityPosition(playerPed, false)
    end

    local animations = CURRENT_SUGGESTION.animations
    local selectedAnim = animations[math.random(1, #animations)]

    if #animations > 1 then
        while IsEntityPlayingAnim(playerPed, selectedAnim.dict, selectedAnim.anim, 3) do
            selectedAnim = animations[math.random(1, #animations)]
            Citizen.Wait(5)
        end
    else
        if IsEntityPlayingAnim(playerPed, selectedAnim.dict, selectedAnim.anim, 3) then
            return
        end
    end

    if CURRENT_KEY == TYPE_PROP_SPECIFIC then
        PlayPropAnimation(selectedAnim)
    elseif CURRENT_KEY == TYPE_AREA_SPECIFIC then
        PlayAreaAnimation(selectedAnim)
    else
        PlayNormalAnimation(selectedAnim)
    end

    if selectedAnim.tool then
        if HELD_PROP then
            DeleteObject(HELD_PROP)
            HELD_PROP = nil
        end
        HELD_PROP = CreateProp(selectedAnim.tool)
    end

    if selectedAnim.event then
        if "server" == selectedAnim.event.type then
            TriggerServerEvent(selectedAnim.event.event, selectedAnim.event.params)
        else
            TriggerEvent(selectedAnim.event.event, selectedAnim.event.params)
        end
    end

    local actionSettings = CURRENT_KEY and Settings.actions[CURRENT_KEY] or nil
    PLAYING_ANIM = true

    if actionSettings and not actionSettings.cancelable then
        Citizen.Wait(3000)
        PLAYING_ANIM = false
        if HELD_PROP then
            DeleteObject(HELD_PROP)
            HELD_PROP = nil
        end
    end
end

function PlayNormalAnimation(animation)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local currentKey = CURRENT_KEY
    local actionSettings = currentKey and Settings.actions[currentKey] or nil

    if not actionSettings then
        return
    end

    if actionSettings.type == TYPE_INTIMIDATE then
        ClearPedTasks(playerPed)
    end

    if actionSettings.align then
        local targetCoords = GetEntityCoords(playerPed)
        local offsetCoords = vector3(0.0, 0.0, 0.0)
        local rotation = GetEntityRotation(playerPed)

        if actionSettings.align then
            local alignSettings = actionSettings.align
            local rayHit, rayCoords = RayCast(alignSettings.start, alignSettings.finish, 0.2)
            targetCoords = rayCoords
            offsetCoords = GetOffsetFromEntityInWorldCoords(playerPed, animation.offset) - playerCoords
        end

        local finalCoords = targetCoords + offsetCoords

        if GetDistanceBetweenCoords(finalCoords, playerCoords, 1) > 3.0 then
            return
        end

        if actionSettings.freeze then
            FreezeEntityPosition(playerPed, true)
        end

        PlayAnimAdvanced(playerPed, animation.dict, animation.anim, animation.flag, finalCoords, rotation)
    else
        PlayAnim(playerPed, animation.dict, animation.anim, animation.flag)
    end

    if actionSettings.type == TYPE_GREET then
        local rayHit, rayCoords, rayEntity = RayCast(actionSettings.raycast.start, actionSettings.raycast.finish, actionSettings.raycast.size)
        if rayEntity then
            GREETED_PEDS[rayEntity] = GetGameTimer()
        end
    end

    Debug("Now playing", animation.dict, animation.anim)
end

function PlayPropAnimation(animation)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    Debug("Now playing", animation.dict, animation.anim)

    local currentKey = CURRENT_KEY
    local currentSuggestion = CURRENT_SUGGESTION
    local currentProp = CURRENT_PROP
    local actionSettings = currentKey and Settings.actions[currentKey] or nil

    if not currentSuggestion or not actionSettings then
        return
    end

    if currentSuggestion.align then
        local propOffsetCoords = GetOffsetFromEntityInWorldCoords(currentProp, currentSuggestion.offset)
        local animOffsetCoords = GetOffsetFromEntityInWorldCoords(currentProp, animation.offset)
        local propCoords = GetEntityCoords(currentProp)
        animOffsetCoords = animOffsetCoords - propCoords

        local rotation = GetEntityRotation(playerPed)
        rotation = GetEntityRotation(currentProp)
        rotation = vector3(rotation.x, rotation.y, (rotation.z + 180.0) % 360.0)

        local finalCoords = propOffsetCoords + animOffsetCoords

        if GetDistanceBetweenCoords(finalCoords, playerCoords, 1) > 3.0 then
            return
        end

        if currentSuggestion.align then
            FreezeEntityPosition(playerPed, true)
        end

        PlayAnimAdvanced(playerPed, animation.dict, animation.anim, animation.flag, finalCoords, rotation)
    else
        PlayAnim(playerPed, animation.dict, animation.anim, animation.flag)
    end

    if actionSettings.type == TYPE_GREET then
        local rayHit, rayCoords, rayEntity = RayCast(actionSettings.raycast.start, actionSettings.raycast.finish, actionSettings.raycast.size)
        if rayEntity then
            GREETED_PEDS[rayEntity] = GetGameTimer()
        end
    end

    PLAYING_ANIM = true

    if not actionSettings.cancelable then
        Citizen.Wait(3000)
        PLAYING_ANIM = false
        if HELD_PROP then
            DeleteObject(HELD_PROP)
            HELD_PROP = nil
        end
    end
end

function PlayAreaAnimation(animation)
    local playerPed = PlayerPedId()

    PlayAnim(playerPed, animation.dict, animation.anim, animation.flag)
    Debug("Now playing", animation.dict, animation.anim)
end

function SetKeybindHintStyle()
    Citizen.CreateThread(function()
        Citizen.Wait(1000)

        local style = Config.keybinds.style

        SendNUIMessage({
            event = "setStyle",
            fontSize = style.fontSize,
            bgColor = FormatRGBA(style.bgColor),
            textColor = FormatRGBA(style.textColor),
            keybindBgColor = FormatRGBA(style.keybindBgColor),
            keybindTextColor = FormatRGBA(style.keybindTextColor),
            borderRadius = style.borderRadius,
            top = style.top,
            bottom = style.bottom,
            left = style.left,
            right = style.right
        })

        KEYBIND_STYLE_SET = true
    end)
end

RegisterNUICallback("UILoaded", function(data, callback)
    SetKeybindHintStyle()
    callback(true)
end)

function FormatRGBA(color)
    local formatted = "rgba({r}, {g}, {b}, {a})"
    formatted = formatted:gsub("{r}", color[1])
    formatted = formatted:gsub("{g}", color[2])
    formatted = formatted:gsub("{b}", color[3])
    formatted = formatted:gsub("{a}", color[4])
    return formatted
end

function SetCurrentSuggestion(suggestion, key)
    CURRENT_SUGGESTION = suggestion
    CURRENT_KEY = key

    if not Config.keybinds.style.show then
        return
    end

    if nil == suggestion then
        HideKeybindHint()
    else
        if not KEYBIND_STYLE_SET then
            SetKeybindHintStyle()
        end

        local keybind = GetKeyLabel(GetHashKey("suggestanim"))
        ShowKeybindHint(keybind, CURRENT_SUGGESTION.label)
    end
end

Citizen.CreateThread(function()
    while true do
        local waitTime = 500
        local playerPed = PlayerPedId()

        if PLAYING_ANIM and CURRENT_KEY and Settings.actions[CURRENT_KEY].cancelable then
            waitTime = 150

            local shouldFreeze = CURRENT_KEY and Settings.actions[CURRENT_KEY].freeze

            if shouldFreeze then
                if CURRENT_KEY == TYPE_PROP_SPECIFIC then
                    if CURRENT_SUGGESTION.align then
                        FreezeEntityPosition(playerPed, true)
                    end
                else
                    FreezeEntityPosition(playerPed, true)
                end
            end

            if IsPlayerTryingToMove() or IsAnyCancelControlPressed() then
                ClearPedTasks(playerPed, false)
                PLAYING_ANIM = false

                if HELD_PROP then
                    DeleteObject(HELD_PROP)
                    HELD_PROP = nil
                end

                if shouldFreeze then
                    FreezeEntityPosition(playerPed, false)
                end
            end
        end

        local highestImportance = 0
        local bestSuggestion = nil
        local bestKey = nil

        local isSittingViaChair = IsPlayerSittingViaChairSystem()

        local canCheckSuggestions = CanUseSuggestions() and (not PLAYING_ANIM or (CURRENT_KEY and Settings.actions[CURRENT_KEY] and Settings.actions[CURRENT_KEY].cancelable))

        if canCheckSuggestions or isSittingViaChair then
            if not IsPedStill(playerPed) then
                LAST_MOVEMENT = GetGameTimer()
            end

            if IsPedInMeleeCombat(playerPed) then
                LAST_COMBAT = GetGameTimer()
            end

            local propSettings = Settings.actions[TYPE_PROP_SPECIFIC]
            local rayHit, rayCoords, rayEntity = RayCast(propSettings.raycast.start, propSettings.raycast.finish, propSettings.raycast.size)

            for _, propConfig in pairs(Config.propSpecific or {}) do
                local foundProp = false
                
                if isSittingViaChair and propConfig.useChairSystem then
                    local playerCoords = GetEntityCoords(playerPed)
                    for _, modelName in pairs(propConfig.models) do
                        local closestProp = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 2.0, GetHashKey(modelName), false, false, false)
                        if closestProp ~= 0 then
                            rayEntity = closestProp
                            foundProp = true
                            break
                        end
                    end
                end
                
                if not foundProp and rayHit and nil ~= rayEntity then
                    if IsEntityAnObject(rayEntity) then
                        if ContainsModel(propConfig.models, GetEntityModel(rayEntity)) then
                            foundProp = true
                        end
                    end
                end
                
                if foundProp then
                    CURRENT_PROP = rayEntity
                    highestImportance = propSettings.importance
                    bestSuggestion = propConfig
                    bestKey = TYPE_PROP_SPECIFIC
                end
            end

            Citizen.Wait(100)

            local playerCoords = GetEntityCoords(playerPed)
            local areaSettings = Settings.actions[TYPE_AREA_SPECIFIC]

            for _, areaConfig in pairs(Config.areaSpecific or {}) do
                local distance = GetDistanceBetweenCoords(playerCoords, areaConfig.coords, 1)
                if distance <= areaConfig.radius then
                    highestImportance = areaSettings.importance
                    bestSuggestion = areaConfig
                    bestKey = TYPE_AREA_SPECIFIC
                end
            end

            Citizen.Wait(100)

            for actionKey, actionSettings in pairs(Settings.actions) do
                if highestImportance < actionSettings.importance then
                    if CanDoAction(actionSettings, actionKey) then
                        if Config.animations[actionKey] and Config.animations[actionKey].enabled and #Config.animations[actionKey] then
                            highestImportance = actionSettings.importance
                            bestSuggestion = Config.animations[actionKey]
                            bestKey = actionKey
                        end
                    end
                end
            end

            waitTime = 500
        end

        local shouldKeepSuggestion = (PLAYING_ANIM and CURRENT_KEY and Settings.actions[CURRENT_KEY] and Settings.actions[CURRENT_KEY].cancelable) or isSittingViaChair

        if isSittingViaChair then
            if bestSuggestion and bestSuggestion.useChairSystem then
                SetCurrentSuggestion(bestSuggestion, bestKey)
            elseif CURRENT_SUGGESTION and CURRENT_SUGGESTION.useChairSystem then
                local keybind = GetKeyLabel(GetHashKey("suggestanim"))
                ShowKeybindHint(keybind, CURRENT_SUGGESTION.label)
            else
                SetCurrentSuggestion(bestSuggestion, bestKey)
            end
        elseif shouldKeepSuggestion then
            if bestSuggestion then
                SetCurrentSuggestion(bestSuggestion, bestKey)
            end
        else
            SetCurrentSuggestion(bestSuggestion, bestKey)
        end

        Citizen.Wait(waitTime)
    end
end)

function CanDoAction(actionSettings, actionKey)
    return UseCache("canDo_" .. actionKey, function()
        local playerPed = PlayerPedId()

        if actionSettings.type == TYPE_INTIMIDATE then
            return LAST_COMBAT + (actionSettings.minimum * 1000) > GetGameTimer()
        end

        if actionSettings.type == TYPE_TIME then
            if actionSettings.minimum then
                return LAST_MOVEMENT + (actionSettings.minimum * 1000) < GetGameTimer()
            end
        end

        if actionSettings.type == TYPE_INSPECT then
            if not IsPedStill(playerPed) then
                return false
            end

            local rayHit, rayCoords, rayEntity = RayCast(actionSettings.raycast.start, actionSettings.raycast.finish)

            if rayHit and nil ~= rayEntity then
                if IsEntityAVehicle(rayEntity) then
                    return GetVehicleDoorAngleRatio(rayEntity, 4) > 0.5
                end
            end
        end

        if actionSettings.type == TYPE_CHEER_BURNOUT then
            local rayHit, rayCoords, rayEntity = RayCast(actionSettings.raycast.start, actionSettings.raycast.finish, actionSettings.raycast.size)

            if rayHit and nil ~= rayEntity then
                if IsEntityAVehicle(rayEntity) then
                    return IsVehicleInBurnout(rayEntity)
                end
            end
        end

        if actionSettings.type == TYPE_GREET then
            local rayHit, rayCoords, rayEntity = RayCast(actionSettings.raycast.start, actionSettings.raycast.finish, actionSettings.raycast.size)

            if rayHit and nil ~= rayEntity then
                if IsEntityAPed(rayEntity) then
                    return IsPedAPlayer(rayEntity) and not GREETED_PEDS[rayEntity]
                end
            end
        end

        if actionSettings.type == TYPE_CONVERSATION then
            local rayHit, rayCoords, rayEntity = RayCast(actionSettings.raycast.start, actionSettings.raycast.finish, actionSettings.raycast.size)

            if rayHit and nil ~= rayEntity then
                if IsEntityAPed(rayEntity) then
                    return IsPedAPlayer(rayEntity)
                end
            end
        end

        if actionSettings.type == TYPE_SHOW_PAIN then
            return GetEntityHealth(playerPed) <= actionSettings.minimum
        end

        if actionSettings.type == TYPE_RAYCAST then
            if IsPedStill(playerPed) then
                local successCount = 0

                for _, blacklistRaycast in pairs(actionSettings.blacklist or {}) do
                    local blacklistHit, blacklistCoords, blacklistEntity = RayCast(blacklistRaycast.start, blacklistRaycast.finish)
                    if 1 == blacklistHit then
                        return false
                    end
                end

                for _, raycastConfig in pairs(actionSettings.raycasts or {}) do
                    local rayHit, rayCoords, rayEntity = RayCast(raycastConfig.start, raycastConfig.finish)
                    if 1 == rayHit then
                        successCount = successCount + 1
                    end
                end

                if actionSettings.minimum then
                    return successCount >= actionSettings.minimum
                end
            end
        end

        return false
    end, 1000)
end

function RayCast(startOffset, endOffset, radius)
    return UseCache("raycast" .. startOffset.x .. "-" .. startOffset.y .. "-" .. endOffset.x .. "-" .. endOffset.y .. "-" .. (radius or ""), function()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local startCoords = GetOffsetFromEntityInWorldCoords(playerPed, startOffset)
        local endCoords = GetOffsetFromEntityInWorldCoords(playerPed, startOffset + endOffset)

        local shapeTest = StartShapeTestSweptSphere(startCoords, endCoords, radius or 0.1, 4294967295, playerPed, 1)
        local hit, _, hitCoords, _, hitEntity = GetShapeTestResult(shapeTest)

        if Config.debug then
            if 0 == hit then
                DrawLine(startCoords, endCoords, 255, 0, 0, 255)
            else
                DrawLine(startCoords, endCoords, 0, 255, 0, 255)
            end
        end

        return hit, hitCoords, hitEntity
    end, 750)
end


RegisterCommand("test", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local rayHit, rayCoords, rayEntity = RayCast(vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 10.0))
    print(rayHit, rayCoords, rayEntity)
end)