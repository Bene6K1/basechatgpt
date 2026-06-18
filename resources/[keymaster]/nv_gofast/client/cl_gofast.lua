local Framework = nil
local missionActive = false
local deliveryBlip = nil
local dialogActive = false
local vehicleSpawned = false
local missionVehicle = nil
local deliveryPoint = nil
local npcPed = nil
local npcCombatMode = false
local combatThread = nil
local isNearNPC = false
local isNearDelivery = false
local npcInteractionId = nil
local deliveryInteractionId = nil
local currentMissionItem = nil

CreateThread(function()
    if Config.Framework.Type == "esx" then
        Framework = exports[Config.Framework.ResourceName]:getSharedObject()
    elseif Config.Framework.Type == "qbcore" then
        Framework = exports[Config.Framework.ResourceName]:GetCoreObject()
    else
        Framework = {}
    end
end)
function NormalizeVector(vector)
    local length = math.sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z)
    if length > 0 then
        return vector3(vector.x / length, vector.y / length, vector.z / length)
    end
    return vector3(0.0, 0.0, 0.0)
end

function GetDistanceBetweenCoords(pos1, pos2)
    local vector1 = vector3(pos1.x, pos1.y, pos1.z)
    local vector2 = vector3(pos2.x, pos2.y, pos2.z)
    return #(vector1 - vector2)
end
function SpawnNPC()
    if combatThread then
        TerminateThread(combatThread)
        combatThread = nil
    end
    
    npcCombatMode = false
    
    if npcPed and DoesEntityExist(npcPed) then
        DeleteEntity(npcPed)
    end
    
    local modelHash = GetHashKey(Config.GoFast.NPC.Model)
    RequestModel(modelHash)
    
    while not HasModelLoaded(modelHash) do
        Wait(10)
    end
    
    npcPed = CreatePed(4, modelHash, Config.GoFast.Pos.xyz, Config.GoFast.Pos.w, false, true)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    TaskStartScenarioInPlace(npcPed, Config.GoFast.NPC.Scenario, 0, true)
    SetModelAsNoLongerNeeded(modelHash)
end

function ResetPlayerControls()
    SetNuiFocus(false, false)
    SetPlayerControl(PlayerId(), true, 0)
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    EnableAllControlActions(0)
    dialogActive = false
    
    Citizen.SetTimeout(0, function()
        SetNuiFocus(false, false)
        SetPlayerControl(PlayerId(), true, 0)
    end)
end

function PlayAnimation(ped, animDict, animName, flag)
    if not DoesEntityExist(ped) then
        return
    end
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end
    
    if IsEntityPlayingAnim(ped, animDict, animName, 3) then
        return
    end
    
    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, flag or 0, 0, false, false, false)
end

local animationSets = {
    player = {
        {"mp_common", "givetake1_a", 48},
        {"mp_facial", "facial_nervous", 48},
        {"gestures@m@standing@casual", "gesture_please", 48},
        {"gestures@m@standing@casual", "gesture_what", 48},
        {"gestures@m@standing@casual", "gesture_hand_down", 48},
        {"gestures@m@standing@casual", "gesture_right", 48},
        {"gestures@m@standing@casual", "gesture_explain_wide", 48}
    },
    npc = {
        {"gestures@m@standing@casual", "gesture_hello", 48},
        {"gestures@m@standing@casual", "gesture_bring_it_on", 48},
        {"gestures@m@standing@casual", "gesture_come_here", 48},
        {"gestures@m@standing@casual", "gesture_easy_now", 48},
        {"gestures@m@standing@casual", "gesture_explaining", 48},
        {"gestures@m@standing@casual", "gesture_damn", 48},
        {"gestures@m@standing@casual", "gesture_no_way", 48}
    }
}

function PlayRandomAnimation(ped, isNPC)
    local animSet = isNPC and animationSets.npc or animationSets.player
    local randomAnim = animSet[math.random(#animSet)]
    PlayAnimation(ped, randomAnim[1], randomAnim[2], randomAnim[3])
end

function MakeNPCHostile()
    if not npcPed or not DoesEntityExist(npcPed) then
        return
    end
    
    npcCombatMode = true
    ResetPlayerControls()
    
    ClearPedTasks(npcPed)
    FreezeEntityPosition(npcPed, false)
    SetEntityInvincible(npcPed, false)
    SetBlockingOfNonTemporaryEvents(npcPed, false)
    
    PlayAnimation(npcPed, "reaction@intimidation@1h", "intro", 8)
    Wait(1200)
    
    GiveWeaponToPed(npcPed, GetHashKey(Config.GoFast.NPC.Weapon), 250, false, true)
    SetFacialIdleAnimOverride(npcPed, "mood_angry_1", 0)
    
    Citizen.SetTimeout(500, function()
        if DoesEntityExist(npcPed) and not IsEntityDead(npcPed) then
            TaskCombatPed(npcPed, PlayerPedId(), 0, 16)
            SetPedCombatAttributes(npcPed, 46, true)
            SetPedFleeAttributes(npcPed, 0, false)
        end
    end)
    
    if combatThread then
        TerminateThread(combatThread)
        combatThread = nil
    end
    
    combatThread = CreateThread(function()
        local npcPosition = vector3(Config.GoFast.Pos.x, Config.GoFast.Pos.y, Config.GoFast.Pos.z)
        local playerPed = PlayerPedId()
        
        while npcCombatMode and npcPed and DoesEntityExist(npcPed) do
            Wait(1000)
            
            if IsEntityDead(npcPed) then
                Wait(Config.GoFast.Interaction.RespawnDelay)
                SpawnNPC()
                break
            end
            
            local playerPos = GetEntityCoords(playerPed)
            local npcPos = GetEntityCoords(npcPed)
            local distance = #(playerPos - npcPos)
            
            if distance > Config.GoFast.Interaction.NPCResetDistance then
                SpawnNPC()
                break
            end
            
            if distance < 30.0 then
                if not IsEntityDead(npcPed) and not IsPedInCombat(npcPed, playerPed) then
                    TaskCombatPed(npcPed, playerPed, 0, 16)
                end
            end
        end
    end)
end

function PlayUISound(soundName, volume)
    SoundManager.PlaySound(soundName, volume)
end

RegisterNUICallback("playLibrarySound", function(data, cb)
    if not Config.UI.Sounds.Enabled then
        cb({success = false})
        return
    end
    
    PlayUISound(data.soundName, data.volume)
    cb({success = true})
end)

function GetUIConfig()
    local config = {
        contact = {
            name = "LARRY - GOFAST",
            status = "Discute avec le gérant pour avoir une mission"
        },
        messages = {
            intro = "J'ai besoin de toi pour un job, ça t'intéresse ?",
            interested = "Lourd, t'es un bon ! T'as besoin d'aide ?",
            rules = "Parfait, je vais te donner les détails.",
            understand = "Alors, ça sonne bien pour toi ou pas ?",
            waiting = "Nickel. Bouge pas, la caisse arrive dans pas longtemps.",
            vehicleComing = "Voilà ton joujou. Conduis bien, reste malin, et fais gaffe à ta peau.",
            angry = "Sérieux ? Tu me lâches après tout ça ?! Tu crois que j'ai que ça à foutre ?",
            threat = "Tu vas vite capter c'qu'on fait aux mecs qui me font perdre mon temps..."
        },
        options = {
            intro = {
                {Id = "interested", Text = "Oui", Icon = "fa-solid fa-check"},
                {Id = "decline", Text = "Non", Icon = "fa-solid fa-xmark"}
            },
            interested = {
                {Id = "easy", Text = "Facile", Icon = "fa-solid fa-circle", Color = "#2ecc71"},
                {Id = "medium", Text = "Moyen", Icon = "fa-solid fa-circle", Color = "#f39c12"},
                {Id = "hard", Text = "Difficile", Icon = "fa-solid fa-circle", Color = "#e74c3c"}
            },
            rules = {
                {Id = "understand", Text = "C'est clair", Icon = "fa-solid fa-check"},
                {Id = "refuse", Text = "Nan, pas pour moi", Icon = "fa-solid fa-xmark"}
            },
            understand = {
                {Id = "accept", Text = "Ok, je prends", Icon = "fa-solid fa-handshake"},
                {Id = "refuse", Text = "Je laisse tomber", Icon = "fa-solid fa-ban"}
            }
        },
        animation = {
            showDelay = 500,
            typingSpeed = 50,
            messageDelay = 1000,
            optionsDelay = 500,
            transitionSpeed = 500,
            hostileDuration = 7000,
            angryMessageDelay = 1500,
            threatMessageDelay = 3500
        }
    }
    
    return config
end

RegisterNUICallback("animateCharacter", function(data, cb)
    if not npcPed or not DoesEntityExist(npcPed) then
        cb({success = false})
        return
    end
    
    local action = data.action or ""
    local playerPed = PlayerPedId()
    
    if action == "contact_typing" then
        PlayRandomAnimation(npcPed, true)
    elseif action == "player_typing" then
        PlayRandomAnimation(playerPed, false)
    else
        local dialogAnimations = {
            intro = {
                interested = {dict = "gestures@m@standing@casual", anim = "gesture_hello", flag = 48},
                decline = {dict = "gestures@m@standing@casual", anim = "gesture_shrug_hard", flag = 48}
            },
            interested = {
                continue = {dict = "gestures@m@standing@casual", anim = "gesture_explaining", flag = 48}
            },
            rules = {
                understand = {dict = "gestures@m@standing@casual", anim = "gesture_right_d", flag = 48},
                refuse = {dict = "gestures@m@standing@casual", anim = "gesture_no_way", flag = 48}
            },
            understand = {
                accept = {dict = "mp_common", anim = "givetake1_a", flag = 48},
                refuse = {dict = "gestures@m@standing@casual", anim = "gesture_damn", flag = 48}
            }
        }
        
        local dialogState = data.dialogState
        local selection = data.selection
        local animData = dialogAnimations[dialogState] and dialogAnimations[dialogState][selection]
        
        if animData then
            PlayAnimation(npcPed, animData.dict, animData.anim, animData.flag)
        end
    end
    
    cb({success = true})
end)

RegisterNUICallback("npcHostile", function(data, cb)
    MakeNPCHostile()
    cb({})
end)

RegisterNUICallback("resetFocus", function(data, cb)
    ResetPlayerControls()
    cb({success = true})
end)


function GetLocationName(coords)
    local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    return string.format("%s, %s", 
        GetStreetNameFromHashKey(streetHash),
        GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
    )
end

function GetVehicleDisplayName(modelName)
    return GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(modelName)))
end

function CleanupMission()
    if deliveryBlip then
        RemoveBlip(deliveryBlip)
    end
    deliveryBlip = nil
    missionActive = false
    deliveryPoint = nil
    currentMissionItem = nil
    
    if deliveryInteractionId then
        exports['nv_interact']:removeInteractionPoint(deliveryInteractionId)
        deliveryInteractionId = nil
    end
    isNearDelivery = false
    
    if missionVehicle and DoesEntityExist(missionVehicle) then
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) and GetVehiclePedIsIn(playerPed, false) == missionVehicle then
            TaskLeaveVehicle(playerPed, missionVehicle, 0)
            Wait(1000)
        end
        DeleteEntity(missionVehicle)
    end
    missionVehicle = nil
    vehicleSpawned = false
    
    SendNUIMessage({type = "hideUI"})
end

function StartDialog()
    if dialogActive then
        return
    end
    
    dialogActive = true
    local playerPed = PlayerPedId()
    
    TaskTurnPedToFaceEntity(playerPed, npcPed, -1)
    TaskTurnPedToFaceEntity(npcPed, playerPed, -1)
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "showDialog",
        config = GetUIConfig()
    })
end

RegisterNUICallback("startGoFast", function(data, cb)
    local availableSpawn = nil
    
    for _, spawnPoint in ipairs(Config.GoFast.SpawnPoints) do
        local nearbyVehicles = {}
        
        if Config.Framework.Type == "esx" then
            nearbyVehicles = Framework.Game.GetVehiclesInArea(spawnPoint.xyz, 3.0)
        else
            local allVehicles = GetGamePool("CVehicle")
            for i = 1, #allVehicles do
                local vehiclePos = GetEntityCoords(allVehicles[i])
                local distance = #(spawnPoint.xyz - vehiclePos)
                if distance <= 3.0 then
                    table.insert(nearbyVehicles, allVehicles[i])
                end
            end
        end
        
        if #nearbyVehicles == 0 then
            availableSpawn = spawnPoint
            break
        end
    end
    
    if not availableSpawn then
        SetNuiFocus(false, false)
        dialogActive = false
        SendNUIMessage({type = "hideDialog"})
        
        if Config.Framework.Type == "esx" then
            Framework.ShowNotification("~r~Tous les points de spawn sont occupés. Attendez qu'un point se libère.")
        elseif Config.Framework.Type == "qbcore" then
            Framework.Functions.Notify("Tous les points de spawn sont occupés. Attendez qu'un point se libère.", "error")
        else
            TriggerEvent("nevaaagofast:notification", "Tous les points de spawn sont occupés. Attendez qu'un point se libère.", "error")
        end
        
        cb({success = false})
        return
    end
    
    SetNuiFocus(false, false)
    dialogActive = false
    SendNUIMessage({type = "hideDialog"})
    
    local difficulty = data.difficulty or "medium"
    TriggerServerEvent("nevaaagofast:requestStart", difficulty)
    cb({success = true})
end)

RegisterNUICallback("closeMenu", function(data, cb)
    ResetPlayerControls()
    SendNUIMessage({type = "hideDialog"})
    cb({success = true})
end)

RegisterNetEvent("nevaaagofast:notification")
AddEventHandler("nevaaagofast:notification", function(message, type)
    if Config.Framework.Type == "esx" then
        Framework.ShowNotification(message)
    elseif Config.Framework.Type == "qbcore" then
        Framework.Functions.Notify(message, type)
    else
        SetNotificationTextEntry("STRING")
        AddTextComponentString(message)
        DrawNotification(false, true)
    end
end)

RegisterNetEvent("nevaaagofast:itemCheckResult")
AddEventHandler("nevaaagofast:itemCheckResult", function(hasItem)
    if not missionActive then
        return
    end
    
    if not hasItem then
        if Config.Framework.Type == "esx" then
            Framework.ShowNotification("~r~Vous avez perdu la marchandise! Mission échouée.")
        elseif Config.Framework.Type == "qbcore" then
            Framework.Functions.Notify("Vous avez perdu la marchandise! Mission échouée.", "error")
        else
            TriggerEvent("nevaaagofast:notification", "Vous avez perdu la marchandise! Mission échouée.", "error")
        end
        
        CreateThread(function()
            local startTime = GetGameTimer()
            while GetGameTimer() - startTime < Config.GoFast.Items.MaxTimeWithout * 1000 do
                Wait(5000)
                if currentMissionItem then
                    TriggerServerEvent("nevaaagofast:checkItemServer", currentMissionItem)
                end
                Wait(1000)
                if not missionActive then
                    break
                end
            end
        end)
    end
end)

RegisterNetEvent("nevaaagofast:completionResult")
AddEventHandler("nevaaagofast:completionResult", function(success)
    if success then
        HideHelpMessage()
        missionActive = false
        if deliveryBlip then
            RemoveBlip(deliveryBlip)
        end
        deliveryBlip = nil
        deliveryPoint = nil
    else
        if Config.Framework.Type == "esx" then
            Framework.ShowNotification("~r~Livraison échouée.")
        elseif Config.Framework.Type == "qbcore" then
            Framework.Functions.Notify("Livraison échouée.", "error")
        else
            TriggerEvent("nevaaagofast:notification", "Livraison échouée.", "error")
        end
    end
end)

function CompleteDelivery()
    if not missionActive or not deliveryPoint then
        if Config.Framework.Type == "esx" then
            Framework.ShowNotification("~r~Aucune mission active")
        else
            TriggerEvent("nevaaagofast:notification", "Aucune mission active", "error")
        end
        return
    end
    
    local playerPed = PlayerPedId()
    if not IsPedInAnyVehicle(playerPed, false) then
        if Config.Framework.Type == "esx" then
            Framework.ShowNotification("~r~Vous devez être dans le véhicule pour effectuer la livraison")
        else
            TriggerEvent("nevaaagofast:notification", "Vous devez être dans le véhicule pour effectuer la livraison", "error")
        end
        return
    end
    
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local plateText = GetVehicleNumberPlateText(vehicle)
    
    PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    
    if Config.Framework.Type == "esx" then
        Framework.ShowNotification("~g~Livraison effectuée avec succès~n~~w~Récupération de la rémunération en cours...")
    elseif Config.Framework.Type == "qbcore" then
        Framework.Functions.Notify("Livraison effectuée avec succès", "success")
    else
        TriggerEvent("nevaaagofast:notification", "Livraison effectuée avec succès", "success")
    end
    
    TriggerServerEvent("nevaaagofast:completeDelivery")
    
    Wait(500)
    local playerPed = PlayerPedId()
    if missionVehicle and DoesEntityExist(missionVehicle) then
        if IsPedInAnyVehicle(playerPed, false) and GetVehiclePedIsIn(playerPed, false) == missionVehicle then
            TaskLeaveVehicle(playerPed, missionVehicle, 0)
            Wait(1000)
        end
        DeleteEntity(missionVehicle)
    end
    missionVehicle = nil
    vehicleSpawned = false
    
    CleanupMission()
end

CreateThread(function()
    local modelHash = GetHashKey(Config.GoFast.NPC.Model)
    RequestModel(modelHash)
    
    while not HasModelLoaded(modelHash) do
        Wait(10)
    end
    
    npcPed = CreatePed(4, modelHash, Config.GoFast.Pos.xyz, Config.GoFast.Pos.w, false, true)
    FreezeEntityPosition(npcPed, Config.GoFast.NPC.InitiallyBlocked)
    SetEntityInvincible(npcPed, Config.GoFast.NPC.Invincible)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    TaskStartScenarioInPlace(npcPed, Config.GoFast.NPC.Scenario, 0, true)
    SetModelAsNoLongerNeeded(modelHash)
    
    local npcPosition = vector3(Config.GoFast.Pos.x, Config.GoFast.Pos.y, Config.GoFast.Pos.z)
    local npcInteractionPos = vector3(Config.GoFast.Pos.x, Config.GoFast.Pos.y, Config.GoFast.Pos.z + 1.0)
    
    npcInteractionId = exports['nv_interact']:addInteractionPoint({
        coords = npcInteractionPos,
        dist = Config.GoFast.Interaction.Distance,
        key = 'E',
        message = 'GOFAST',
        icon = 'fa-solid fa-car-side',
        onPress = function()
            if not dialogActive and not npcCombatMode then
                StartDialog()
            end
        end
    })
    
    while true do
        local sleepTime = 1000
        local playerPos = GetEntityCoords(PlayerPedId())
        local distance = #(playerPos - npcPosition)
        
        if npcCombatMode then
            if npcInteractionId then
                exports['nv_interact']:removeInteractionPoint(npcInteractionId)
                npcInteractionId = nil
                isNearNPC = false
            end
        else
            if not npcInteractionId then
                npcInteractionId = exports['nv_interact']:addInteractionPoint({
                    coords = npcInteractionPos,
                    dist = Config.GoFast.Interaction.Distance,
                    key = 'E',
                    message = 'GOFAST',
                    icon = 'fa-solid fa-car-side',
                    onPress = function()
                        if not dialogActive and not npcCombatMode then
                            StartDialog()
                        end
                    end
                })
            end
            
            if distance <= Config.GoFast.Interaction.Distance then
                if not isNearNPC then
                    isNearNPC = true
                end
                sleepTime = 0
            else
                if isNearNPC then
                    isNearNPC = false
                end
                sleepTime = Config.GoFast.Interaction.DetectionInterval
            end
        end
        
        if dialogActive and distance > Config.GoFast.Interaction.NotificationDistance then
            SetNuiFocus(false, false)
            dialogActive = false
            SendNUIMessage({type = "hideDialog"})
            if isNearNPC then
                isNearNPC = false
            end
        end
        
        Wait(sleepTime)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    if npcInteractionId then
        exports['nv_interact']:removeInteractionPoint(npcInteractionId)
        npcInteractionId = nil
    end
    
    if deliveryInteractionId then
        exports['nv_interact']:removeInteractionPoint(deliveryInteractionId)
        deliveryInteractionId = nil
    end
    
    if npcPed and DoesEntityExist(npcPed) then
        DeleteEntity(npcPed)
    end
end)

RegisterNetEvent("nevaaagofast:startMission")
AddEventHandler("nevaaagofast:startMission", function(missionData)
    if missionActive then
        Framework.ShowNotification("~r~Une mission est déjà en cours.")
        return
    end
    
    missionActive = true
    deliveryPoint = missionData.deliveryPoint
    currentMissionItem = missionData.item and missionData.item.name or nil
    
    local vehicleHash = GetHashKey(missionData.vehicle)
    RequestModel(vehicleHash)
    
    while not HasModelLoaded(vehicleHash) do
        Wait(10)
    end
    
    local vehicle = CreateVehicle(vehicleHash, 
        missionData.spawnPoint.x, missionData.spawnPoint.y, missionData.spawnPoint.z, missionData.spawnPoint.w, 
        true, false)
    
    missionVehicle = vehicle
    vehicleSpawned = true
    
    local plateText = Config.GoFast.Vehicles.Customization.RandomPlate and GenerateRandomPlate() or Config.GoFast.Vehicles.Customization.PlatePrefix
    SetVehicleNumberPlateText(vehicle, plateText)
    SetVehicleOnGroundProperly(vehicle)
    SetModelAsNoLongerNeeded(vehicleHash)
    
    local vehicleDisplayName = GetLabelText(GetDisplayNameFromVehicleModel(vehicleHash))
    if vehicleDisplayName == "NULL" then
        vehicleDisplayName = missionData.vehicle
    end
    
    if missionData.notifyPolice then
        CreateThread(function()
            Wait(missionData.notificationDelay)
            local vehicleCoords = GetEntityCoords(vehicle)
            TriggerServerEvent("nevaaagofast:notifyLawEnforcement", {
                model = vehicleDisplayName,
                plate = plateText,
                coords = vehicleCoords
            })
        end)
    end
    
    deliveryBlip = AddBlipForCoord(deliveryPoint.x, deliveryPoint.y, deliveryPoint.z)
    SetBlipSprite(deliveryBlip, Config.GoFast.BlipSettings.Sprite)
    SetBlipColour(deliveryBlip, 1)
    SetBlipScale(deliveryBlip, Config.GoFast.BlipSettings.Scale)
    SetBlipRoute(deliveryBlip, Config.GoFast.BlipSettings.Route)
    SetBlipRouteColour(deliveryBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.GoFast.BlipSettings.Label)
    EndTextCommandSetBlipName(deliveryBlip)
    
    if Config.Framework.Type == "esx" then
        Framework.ShowNotification("Votre véhicule vous attend Suivez le GPS vers le point de livraison")
    else
        Framework.ShowNotification("Votre véhicule vous attend\nSuivez le GPS vers le point de livraison")
    end
end)

CreateThread(function()
    while true do
        local sleepTime = 1000
        
        if missionActive and deliveryPoint then
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)
            local targetPos = vector3(deliveryPoint.x, deliveryPoint.y, deliveryPoint.z)
            local distance = #(playerPos - targetPos)
            
            if distance <= Config.GoFast.Interaction.Distance then
                sleepTime = 0
                if not isNearDelivery then
                    isNearDelivery = true
                    if not deliveryInteractionId then
                        local deliveryInteractionPos = vector3(targetPos.x, targetPos.y, targetPos.z + 1.0)
                        deliveryInteractionId = exports['nv_interact']:addInteractionPoint({
                            coords = deliveryInteractionPos,
                            dist = Config.GoFast.Interaction.Distance,
                            key = 'E',
                            message = 'GOFAST',
                            icon = 'fa-solid fa-box',
                            onPress = function()
                                CompleteDelivery()
                            end
                        })
                    end
                end
            else
                if isNearDelivery then
                    isNearDelivery = false
                    if deliveryInteractionId then
                        exports['nv_interact']:removeInteractionPoint(deliveryInteractionId)
                        deliveryInteractionId = nil
                    end
                end
            end
        else
            if isNearDelivery then
                isNearDelivery = false
                if deliveryInteractionId then
                    exports['nv_interact']:removeInteractionPoint(deliveryInteractionId)
                    deliveryInteractionId = nil
                end
            end
        end
        
        Wait(sleepTime)
    end
end)

function GenerateRandomPlate()
    local patterns = {
        function()
            local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            local numbers = "0123456789"
            local plate = ""
            for i = 1, 3 do
                local idx = math.random(1, #letters)
                plate = plate .. letters:sub(idx, idx)
            end
            for i = 1, 3 do
                local idx = math.random(1, #numbers)
                plate = plate .. numbers:sub(idx, idx)
            end
            return plate
        end,
        
        function()
            local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            local numbers = "0123456789"
            local plate = ""
            for i = 1, 2 do
                local idx = math.random(1, #numbers)
                plate = plate .. numbers:sub(idx, idx)
            end
            for i = 1, 3 do
                local idx = math.random(1, #letters)
                plate = plate .. letters:sub(idx, idx)
            end
            for i = 1, 2 do
                local idx = math.random(1, #numbers)
                plate = plate .. numbers:sub(idx, idx)
            end
            return plate
        end,
        
        function()
            local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            local numbers = "0123456789"
            local plate = ""
            for i = 1, 4 do
                local idx = math.random(1, #letters)
                plate = plate .. letters:sub(idx, idx)
            end
            for i = 1, 3 do
                local idx = math.random(1, #numbers)
                plate = plate .. numbers:sub(idx, idx)
            end
            return plate
        end,
        
        function()
            local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            local plate = ""
            for i = 1, 8 do
                local idx = math.random(1, #chars)
                plate = plate .. chars:sub(idx, idx)
            end
            return plate
        end
    }
    
    local selectedPattern = patterns[math.random(1, #patterns)]
    return selectedPattern()
end

RegisterNetEvent("nevaaagofast:createBlip")
AddEventHandler("nevaaagofast:createBlip", function(vehicleInfo)
    local blip = AddBlipForCoord(vehicleInfo.coords.x, vehicleInfo.coords.y, vehicleInfo.coords.z)
    
    SetBlipSprite(blip, Config.GoFast.LawEnforcement.BlipSettings.Sprite)
    SetBlipColour(blip, Config.GoFast.LawEnforcement.BlipSettings.Color)
    SetBlipScale(blip, Config.GoFast.LawEnforcement.BlipSettings.Scale)
    SetBlipAsShortRange(blip, false)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(string.format("%s - %s", 
        Config.GoFast.LawEnforcement.BlipSettings.Label,
        vehicleInfo.plate or "???"))
    EndTextCommandSetBlipName(blip)
    
    SetBlipFlashes(blip, true)
    
    CreateThread(function()
        Wait(Config.GoFast.LawEnforcement.BlipDuration)
        RemoveBlip(blip)
    end)
end)