local retail = false
local nearbyPeds = {}
local pedsCooldown = {}
local interactionPed = nil


RegisterNetEvent("nv_drugs:startRetail", function()
    retail = not retail
    if retail then
        ESX.ShowNotification("Vente de drogue ~g~activée")
        StartRetailLoop()
    else
        ESX.ShowNotification("Vente de drogue ~r~désactivée")
        cleanupTargets()
    end
end)

function StartRetailLoop()
    CreateThread(function()
        while retail do
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)


            local peds = GetGamePool('CPed')
            for _, ped in ipairs(peds) do
                if not nearbyPeds[ped] and not pedsCooldown[ped] and isPedAllowed(ped) then
                    local dist = #(coords - GetEntityCoords(ped))
                    if dist < 50.0 then
                        nearbyPeds[ped] = true


                        exports.ox_target:addLocalEntity(ped, {
                            {
                                name = 'offer_drugs',
                                label = 'Vendre Drogue',
                                icon = 'fa-solid fa-pills',
                                onSelect = function()
                                    PedStartInteraction(ped)
                                end
                            }
                        })
                    end
                end
            end


            for ped, _ in pairs(nearbyPeds) do
                if #(coords - GetEntityCoords(ped)) > 50.0 or not DoesEntityExist(ped) then
                    exports.ox_target:removeLocalEntity(ped, 'offer_drugs')
                    nearbyPeds[ped] = nil
                end
            end

            Wait(2000)
        end
    end)
end

function cleanupTargets()
    for ped, _ in pairs(nearbyPeds) do
        exports.ox_target:removeLocalEntity(ped, 'offer_drugs')
    end
    nearbyPeds = {}
end

function isPedAllowed(ped)
    return IsPedHuman(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true)
end

function PedStartInteraction(ped)
    if interactionPed then return end
    interactionPed = ped

    TaskStandStill(ped, -1)
    TurnPedToEntity(ped, PlayerPedId(), 1000)
    Wait(1000)


    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "toggleNPCSellNUI",
        showNUI = true,
        npcID = "NPC-"..math.random(100,999),
        inventory = Config.Retail.Drugs,
        playerExperience = {respect = 100, saleSkill = 50},
        config = {interestInDrugs = 100, maxQuantity = 5},
        translations = Config.Translations
    })

    playAnim(ped, "missheistdockssetup1ig_5@base", "workers_talking_base_dockworker1", 49)
end


RegisterNUICallback('dialogBack', function(data, cb)
    if data.action == "exit" then
        EndInteraction(false)
    elseif data.action == "sell" then

        TriggerServerEvent("nv_drugs:sellToNPC", data.itemName, data.count, data.inputValue)
        EndInteraction(true, data.itemName)
    end
    cb('ok')
end)

function EndInteraction(success, itemName)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "toggleNPCSellNUI",
        showNUI = false
    })

    if interactionPed then
        ClearPedTasks(interactionPed)
        if success and itemName then
            local drugData = Config.Retail.Drugs[itemName]
            if drugData then

                local animDict = drugData.anim[1] or "mp_common"
                local animName = drugData.anim[2] or "givetake2_a"
                local propModel = drugData.props


                local propObj = nil
                if propModel then
                    local pHash = GetHashKey(propModel)
                    RequestModel(pHash)
                    while not HasModelLoaded(pHash) do Wait(10) end

                    local pedCoords = GetEntityCoords(interactionPed)
                    propObj = CreateObject(pHash, pedCoords.x, pedCoords.y, pedCoords.z, true, true, true)
                    AttachEntityToEntity(propObj, interactionPed, GetPedBoneIndex(interactionPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                end

                playAnim(interactionPed, animDict, animName, 49)
                playAnim(PlayerPedId(), animDict, animName, 49)

                Wait(2000)

                if propObj then DeleteEntity(propObj) end
            else
                playAnim(interactionPed, "mp_common", "givetake2_a", 49)
                Wait(2000)
            end
        end
        TaskWanderStandard(interactionPed, 10.0, 10)


        pedsCooldown[interactionPed] = true
        local p = interactionPed
        exports.ox_target:removeLocalEntity(p, 'offer_drugs')
        nearbyPeds[p] = nil

        SetTimeout(Config.Retail.ClientCooldown, function()
            pedsCooldown[p] = nil
        end)

        interactionPed = nil
    end
end

function playAnim(ped, dict, anim, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, flag, 0, false, false, false)
end

function TurnPedToEntity(ped, target, duration)
    local pos = GetEntityCoords(target)
    TaskTurnPedToFaceCoord(ped, pos.x, pos.y, pos.z, duration)
end
