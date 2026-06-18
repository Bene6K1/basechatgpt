local isPhoneOpen = false
local trapPhoneObj = nil
local isPhoneDataSent = false
local addPhoneConversationTranslate = false


RegisterNetEvent("nv_drugs:openPhone", function(data)
    if ESX.PlayerData.dead then
        ClosePhone()
        return
    end

    if isPhoneOpen then
        ClosePhone()
        return
    end

    local ped = PlayerPedId()


    LibPlayAnim(ped, "cellphone@", "cellphone_text_read_base", 49)


    if not trapPhoneObj then
        local coords = GetEntityCoords(ped)
        trapPhoneObj = CreateObject(GetHashKey("prop_phone_ing"), coords.x, coords.y, coords.z, true, true, false)
        AttachEntityToEntity(trapPhoneObj, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true)
    end

    SetNuiFocus(true, true)

    local drugsTable = {}
    if Config.DrugsSetup then
        for _, d in pairs(Config.DrugsSetup) do
            drugsTable[d.item] = d
        end
    end

    local message = {
        action = "togglePhoneNUI",
        showNUI = true,
        playerExperience = {
            respect = data.respect or 0,
            respectLimit = Config.Phone.RespectLimit,
            saleSkill = data.sale_skill or 0,
            salesLimit = Config.Phone.SkillLimit
        },
        settings = data.settings or {},
        mole = {},
        config = Config.Wholesale,
        drugs = drugsTable
    }


    message.settings.sellingMode = exports['nv_drugs']:IsWholesale()


    if not addPhoneConversationTranslate then
        message.translations = Config.Translations
        addPhoneConversationTranslate = true
    end

    SendNUIMessage(message)
    isPhoneOpen = true
end)

function ClosePhone()
    local ped = PlayerPedId()

    if trapPhoneObj then
        DeleteEntity(trapPhoneObj)
        trapPhoneObj = nil
    end

    ClearPedTasks(ped)
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = "togglePhoneNUI",
        showNUI = false
    })

    isPhoneOpen = false
end


RegisterNUICallback('phoneExit', function(data, cb)
    ClosePhone()
    cb('ok')
end)


function LibPlayAnim(ped, dict, anim, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, flag, 0, false, false, false)
end


-- Phone is now only accessible via the usable item 'black_phone'
-- F10 keybind has been removed

local activeMission = nil

RegisterNUICallback('toggleSelling', function(data, cb)
    local status = data.status
    exports['nv_drugs']:SetWholesale(status)
    cb('ok')
end)

RegisterNUICallback('notifyNewMessage', function(data, cb)
    ESX.ShowNotification("~b~Message : ~s~Vous avez reçu une offre GoFast.")
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
    cb('ok')
end)

RegisterNUICallback('wholesaleNegotiatePrice', function(data, cb)
    local itemName = data.itemName
    local quantity = data.quantity or 1
    local price = tonumber(data.inputValue)

    if not itemName or not Config.Retail.Drugs[itemName] then
        cb({result = "cancel"})
        return
    end

    local drugData = Config.Retail.Drugs[itemName]

    local unitPrice = drugData.price.wholesale or 50


    local maxAcceptable = (drugData.price.retail or 100) * quantity
    local fairPrice = unitPrice * quantity

    if price <= maxAcceptable then
        cb({result = "success"})
    else

        if price <= maxAcceptable * 1.3 then
            cb({result = "negotiation"})
        else
            cb({result = "cancelPrice"})
        end
    end
end)

RegisterNUICallback('phoneStartTradeMission', function(data, cb)
    local quantity = data.quantity
    local conversationId = data.conversationId
    local itemName = data.itemName
    local price = data.price


    local locations = Config.Wholesale.Locations
    local randomIndex = math.random(1, #locations)
    local location = locations[randomIndex]


    StartWholesaleMission(location, quantity, itemName, price)


    cb({x = location.x, y = location.y})
end)

function StartWholesaleMission(location, quantity, itemName, price)
    if activeMission then
        RemoveBlip(activeMission.blip)
        if activeMission.ped then DeleteEntity(activeMission.ped) end
    end


    activeMission = {
        coords = location,
        itemName = itemName,
        quantity = quantity or 1,
        price = price,
        blip = nil,
        ped = nil
    }


    local blip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(blip, 501)
    SetBlipColour(blip, 2)
    SetBlipRoute(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Livraison (GoFast)")
    EndTextCommandSetBlipName(blip)

    activeMission.blip = blip

    ESX.ShowNotification("Rends-toi au point de livraison GPS.")


    CreateThread(function()
        while activeMission do
            local playerPed = PlayerPedId()
            local pCoords = GetEntityCoords(playerPed)
            local dist = #(pCoords - vector3(activeMission.coords.x, activeMission.coords.y, activeMission.coords.z))


            if dist < 50.0 and not activeMission.ped then
                local model = Config.Wholesale.Peds[math.random(1, #Config.Wholesale.Peds)]
                RequestModel(model)
                while not HasModelLoaded(model) do Wait(10) end

                local ped = CreatePed(4, GetHashKey(model), activeMission.coords.x, activeMission.coords.y, activeMission.coords.z, activeMission.coords.w, false, true)
                SetEntityInvincible(ped, true)
                FreezeEntityPosition(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)

                activeMission.ped = ped


                activeMission.interaction = exports['nv_interact']:addInteractionPoint({
                    coords = vector3(activeMission.coords.x, activeMission.coords.y, activeMission.coords.z + 1.25),
                    message = "Livrer la drogue",
                    key = "E",
                    icon = "📦",
                    dist = 2.5,
                    onPress = function()
                       HandleWholesaleDelivery()
                    end
                })
            end


            if dist > 100.0 and activeMission.ped then
                if activeMission.interaction then
                    exports['nv_interact']:removeInteractionPoint(activeMission.interaction)
                    activeMission.interaction = nil
                end

                DeleteEntity(activeMission.ped)
                activeMission.ped = nil
            end

            Wait(1000)
        end
    end)
end

function HandleWholesaleDelivery()
    if not activeMission or not activeMission.ped then return end
    if activeMission.isBusy then return end
    activeMission.isBusy = true

    local playerPed = PlayerPedId()
    local count = exports.ox_inventory:Search('count', activeMission.itemName)

    if count >= activeMission.quantity then

        ExecuteCommand("me donne la marchandise")
        Wait(1000)


        TaskTurnPedToFaceEntity(activeMission.ped, playerPed, 1000)
        Wait(500)
        TriggerEvent("nv_me:displayEntity", activeMission.ped, "Le client vérifie le sac...")
        Wait(2000)


        local propName = "prop_weed_block_01"
        for _, d in pairs(Config.DrugsSetup) do
             if d.item == activeMission.itemName then propName = d.props break end
        end

        local pCoords = GetEntityCoords(playerPed)
        local propObj = CreateObject(GetHashKey(propName), pCoords.x, pCoords.y, pCoords.z, true, true, true)
        AttachEntityToEntity(propObj, playerPed, GetPedBoneIndex(playerPed, 57005), 0.13, 0.02, -0.05, -85.0, 0.0, 0.0, true, true, false, true, 1, true)


        LibPlayAnim(playerPed, "mp_common", "givetake2_a", 0)
        LibPlayAnim(activeMission.ped, "mp_common", "givetake2_a", 0)
        Wait(1500)

        DeleteObject(propObj)
        ClearPedTasks(playerPed)

        TriggerEvent("nv_me:displayEntity", activeMission.ped, "Client: C'est carré, merci.")
        TriggerServerEvent("nv_drugs:wholesaleSell", activeMission.itemName, activeMission.quantity, activeMission.price)

        ESX.ShowNotification("~g~Tu as livré " .. activeMission.quantity .. " pochons.")


        if activeMission.interaction then
            exports['nv_interact']:removeInteractionPoint(activeMission.interaction)
        end
        if activeMission.blip then RemoveBlip(activeMission.blip) end


        FreezeEntityPosition(activeMission.ped, false)
        TaskWanderStandard(activeMission.ped, 10.0, 10)
        SetEntityAsNoLongerNeeded(activeMission.ped)

        activeMission = nil
    else
        activeMission.isBusy = false


        ExecuteCommand("me cherche dans ses poches mais ne trouve rien...")
        Wait(2000)

        TaskTurnPedToFaceEntity(activeMission.ped, playerPed, 1000)
        Wait(1000)

        TriggerEvent("nv_me:displayEntity", activeMission.ped, "Le visage du client se ferme brutalement...")
        LibPlayAnim(activeMission.ped, "random@arrests", "generic_radio_chatter", 49)
        Wait(2000)

        TriggerEvent("nv_me:displayEntity", activeMission.ped, "Client: C'est une blague ?! T'as rien sur toi !")
        Wait(2000)

        TriggerEvent("nv_me:displayEntity", activeMission.ped, "Le client attrape son arme avec rage !")
        Wait(1000)


        ClearPedTasks(activeMission.ped)
        ESX.ShowNotification("~r~Le client s'énerve !")
        GiveWeaponToPed(activeMission.ped, GetHashKey("WEAPON_PISTOL"), 250, false, true)
        TaskCombatPed(activeMission.ped, playerPed, 0, 16)


        if activeMission.blip then RemoveBlip(activeMission.blip) end
        if activeMission.interaction then
             exports['nv_interact']:removeInteractionPoint(activeMission.interaction)
             activeMission.interaction = nil
        end
        activeMission.blip = nil
        activeMission = nil
    end
end

function EndWholesaleMission()
    if activeMission then
        if activeMission.blip then RemoveBlip(activeMission.blip) end
        if activeMission.interaction then
             exports['nv_interact']:removeInteractionPoint(activeMission.interaction)
        end
        if activeMission.ped then
            DeleteEntity(activeMission.ped)
        end
        activeMission = nil
    end
end

-- F10 keybind removed - Phone is now only accessible via inventory item 'black_phone'
