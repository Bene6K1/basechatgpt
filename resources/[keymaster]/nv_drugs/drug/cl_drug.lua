

local ESX = nil

if Config and Config.ESXMode == "old" then
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
else
    ESX = exports.es_extended:getSharedObject()
end


Selldrugs = Selldrugs or {}
Selldrugs.OnSellDrugs = false
Selldrugs.Key = Config.SellDrugKey or 51
Selldrugs.UsedPeds = {}
Selldrugs.OxTargets = {}
Selldrugs.Items = Config.DrugsSetup or {}
Selldrugs.ActiveInteractions = {}


local TerritoryMenuKey = Config.TerritoryMenuKey or 56
local TerritoryMenuColor = Config.TerritoryMenuColor or {r = 0, g = 100, b = 0, a = 180}
local IsMenuOpen = false


function HasItemInInventory(itemName, amount)
    amount = amount or 1

    if Config.Inventory == "tgiann" then
        return exports["tgiann-inventory"]:HasItem(itemName, amount)
    elseif Config.Inventory == "ox" then
        local count = exports.ox_inventory:Search("count", itemName)
        return (count or 0) >= amount
    elseif Config.Inventory == "qs" or Config.Inventory == "codem" then
        return true
    else
        return Selldrugs.Haveitems(itemName, amount)
    end
end


function HasAnySellableDrug()
    for _, item in pairs(Config.DrugsSetup or {}) do
        if HasItemInInventory(item.item, 1) then
            return true
        end
    end
    return false
end


function Selldrugs.Haveitems(itemName, amount)
    amount = amount or 1

    if Config.Inventory == "tgiann" then
        return exports["tgiann-inventory"]:HasItem(itemName, amount)
    elseif Config.Inventory == "ox" then
        local count = exports.ox_inventory:Search("count", itemName)
        return (count or 0) >= amount
    end

    local hasItem = false

    ESX.TriggerServerCallback("cDrugs:getPlayerInventory", function(playerInventory)
        local inventory = playerInventory.inventory

        if inventory then
            for _, slot in pairs(inventory) do
                if slot.name == itemName and slot.count >= amount then
                    hasItem = true
                    break
                end
            end
        end
    end, GetPlayerServerId(PlayerId()))

    Wait(170)
    return hasItem
end


function AddInteractionToPed(ped)
    local netId = NetworkGetNetworkIdFromEntity(ped)

    if Selldrugs.ActiveInteractions[netId] then
        local pedCoords = GetEntityCoords(ped)
        exports['nv_interact']:updateInteractionPoint(Selldrugs.ActiveInteractions[netId], {coords = pedCoords})
        return
    end

    local pedCoords = GetEntityCoords(ped)
    local pointId = exports['nv_interact']:addInteractionPoint({
        coords = pedCoords,
        message = "Vendre de la drogue",
        key = "E",
        icon = "💊",
        dist = 2.5,
        onPress = function()
            Selldrugs.HandleDrugSell(ped, PlayerPedId())
        end
    })

    if pointId then
        Selldrugs.ActiveInteractions[netId] = pointId
    end
end


function RemoveInteractionFromPed(ped)
    local netId = NetworkGetNetworkIdFromEntity(ped)

    if Selldrugs.ActiveInteractions[netId] then
        exports['nv_interact']:removeInteractionPoint(Selldrugs.ActiveInteractions[netId])
        Selldrugs.ActiveInteractions[netId] = nil
    end
end


function ClearAllInteractions()
    for netId, pointId in pairs(Selldrugs.ActiveInteractions) do
        exports['nv_interact']:removeInteractionPoint(pointId)
    end

    Selldrugs.ActiveInteractions = {}
end


if Config.DrugCommand and Config.DrugCommand ~= "" then
    RegisterCommand(Config.DrugCommand, function()
        TriggerEvent("cDrugs:ActivDrugsSell")
    end)
else
    print(_U("no_drug_command_defined"))
end


RegisterNetEvent("cDrugs:ActivDrugsSell")
AddEventHandler("cDrugs:ActivDrugsSell", function()

    Selldrugs.SetSelling(not Selldrugs.OnSellDrugs)
end)

function Selldrugs.SetSelling(status)
    local playerPed = PlayerPedId()

    if status then
        local hasDrugs = false

        for _, item in pairs(Config.DrugsSetup or {}) do
            if HasItemInInventory(item.item, 1) then
                hasDrugs = true
                break
            end
        end

        if not hasDrugs then
            ESX.ShowNotification(_U("no_drugs"))
            return false
        end

        if not Selldrugs.OnSellDrugs then
            ESX.ShowNotification(_U("activated_drug_sale"))
            ESX.ShowNotification("~b~Approchez-vous d'un PNJ et appuyez sur E pour vendre")
            Selldrugs.OnSellDrugs = true
        end
    else
        if Selldrugs.OnSellDrugs then
            ESX.ShowNotification(_U("deactivated_drug_sale"))
            Selldrugs.OnSellDrugs = false
            ClearAllInteractions()
        end
    end
    return true
end

exports('IsSelling', function() return Selldrugs.OnSellDrugs end)
exports('SetSelling', function(status) return Selldrugs.SetSelling(status) end)


Selldrugs.WholesaleMode = false

function Selldrugs.SetWholesale(status)
    local playerPed = PlayerPedId()

    if status then


        if not Selldrugs.WholesaleMode then
            ESX.ShowNotification("~g~Mode GoFast activé. ~s~Attendez les appels.")
            Selldrugs.WholesaleMode = true
        end
    else
        if Selldrugs.WholesaleMode then
            ESX.ShowNotification("~r~Mode GoFast désactivé.")
            Selldrugs.WholesaleMode = false

        end
    end
    return true
end

exports('IsWholesale', function() return Selldrugs.WholesaleMode end)
exports('SetWholesale', function(status) return Selldrugs.SetWholesale(status) end)


function Selldrugs.CanSellToPed(ped)
    if IsPedAPlayer(ped) then return false end
    if IsPedInAnyVehicle(ped, false) then return false end
    if IsEntityDead(ped) then return false end
    if not IsPedHuman(ped) then return false end
    if ped == PlayerPedId() then return false end

    if NetworkGetEntityIsNetworked(ped) then
        local netId = NetworkGetNetworkIdFromEntity(ped)
        if Selldrugs.UsedPeds[netId] then return false end
    else
        if Selldrugs.UsedPeds[ped] then return false end
    end

    return true
end


function RequestAndWaitDict(animDict)
    if not animDict then return end

    if DoesAnimDictExist(animDict) and not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)

        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(100)
        end
    end
end


function RequestAndWaitModel(model)
    if not model then return end

    if IsModelInCdimage(model) and not HasModelLoaded(model) then
        RequestModel(model)

        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end
    end
end


function EnsureEntityIsNetworked(entity)
    if not NetworkGetEntityIsNetworked(entity) and DoesEntityExist(entity) then
        NetworkRegisterEntityAsNetworked(entity)
    end

    return NetworkGetEntityIsNetworked(entity)
end


Citizen.CreateThread(function()
    while true do
        local sleepTime = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if Selldrugs.OnSellDrugs and not IsPedInAnyVehicle(playerPed) then
            sleepTime = 250


            for netId, pointId in pairs(Selldrugs.ActiveInteractions) do
                local entity = NetworkGetEntityFromNetworkId(netId)
                if not DoesEntityExist(entity) then

                    exports['nv_interact']:removeInteractionPoint(pointId)
                    Selldrugs.ActiveInteractions[netId] = nil
                else
                    local pedCoords = GetEntityCoords(entity)
                    local dist = #(playerCoords - pedCoords)

                    if dist > 3.0 or IsEntityDead(entity) or IsPedInAnyVehicle(entity) then

                        exports['nv_interact']:removeInteractionPoint(pointId)
                        Selldrugs.ActiveInteractions[netId] = nil
                    end
                end
            end

            local handle, ped = FindFirstPed()
            local success

            repeat
                if ped and DoesEntityExist(ped) then
                    local pedCoords = GetEntityCoords(ped)
                    local distance = #(playerCoords - pedCoords)

                    if distance <= 5.0 and Selldrugs.CanSellToPed(ped) then
                        sleepTime = 5

                        if distance <= 3.0 then
                            EnsureEntityIsNetworked(ped)
                        end

                        SetBlockingOfNonTemporaryEvents(ped, true)
                        PlayAmbientSpeech2(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                        SetPedCanRagdollFromPlayerImpact(ped, false)

                        if distance <= 2.5 then
                            AddInteractionToPed(ped)
                        end
                    end
                end

                success, ped = FindNextPed(handle)
            until not success

            EndFindPed(handle)
        else
            ClearAllInteractions()
        end

        Wait(sleepTime)
    end
end)


function Selldrugs.HandleDrugSell(targetPed, playerPed)

    if Config.SellInTerritory then
        local inTerritory = IsPlayerInTerritory()

        if not inTerritory then
            ESX.ShowNotification(_U("must_be_in_territory_to_sell"))
            return
        end
    end

    if NetworkGetEntityIsNetworked(targetPed) then
        local netId = NetworkGetNetworkIdFromEntity(targetPed)
        Selldrugs.UsedPeds[netId] = true
        RemoveInteractionFromPed(targetPed)
    else
        Selldrugs.UsedPeds[targetPed] = true
    end

    PlayAmbientSpeech1(targetPed, "GENERIC_HI", "SPEECH_PARAMS_STANDARD")
    PlaceObjectOnGroundProperly(targetPed)
    ClearPedTasksImmediately(targetPed)

    local drugItem, propModel, animDict, minMoney, maxMoney, itemLabel

    for _, item in pairs(Selldrugs.Items) do
        if HasItemInInventory(item.item, 1) then
            drugItem = item.item
            propModel = item.props
            animDict = item.anim
            minMoney = item.minmoney
            maxMoney = item.maxmoney
            itemLabel = item.label
            break
        end
    end

    if not minMoney or not maxMoney then
        ESX.ShowNotification(_U("not_enough_drugs"))
        Selldrugs.OnSellDrugs = false
        return
    end


    Selldrugs.PositionPedForTransaction(targetPed, playerPed)


    RequestAndWaitDict("mp_common")
    RequestAndWaitModel(propModel)
    RequestAndWaitModel("hei_prop_heist_cash_pile")


    SetPedTalk(targetPed)
    PlayAmbientSpeech1(targetPed, "GENERIC_HI", "SPEECH_PARAMS_STANDARD")


    local drugProp = CreateObject(GetHashKey(propModel), 0, 0, 0, true)
    AttachEntityToEntity(drugProp, playerPed, GetPedBoneIndex(playerPed, 57005),
        0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)

    local moneyProp = CreateObject(GetHashKey("hei_prop_heist_cash_pile"), 0, 0, 0, true)
    AttachEntityToEntity(moneyProp, targetPed, GetPedBoneIndex(targetPed, 57005),
        0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)


    TaskPlayAnim(playerPed, "mp_common", "givetake1_a", 8.0, 8.0, -1, 0, 1, false, false, false)
    TaskPlayAnim(targetPed, "mp_common", "givetake1_a", 8.0, 8.0, -1, 0, 1, false, false, false)

    Wait(1000)


    AttachEntityToEntity(moneyProp, playerPed, GetPedBoneIndex(playerPed, 57005),
        0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
    AttachEntityToEntity(drugProp, targetPed, GetPedBoneIndex(targetPed, 57005),
        0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)

    Wait(1000)

    if Config.EnableDrugSound then
        PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
    end


    ClearPedTasks(targetPed)
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    FreezeEntityPosition(targetPed, false)

    if drugProp then DeleteEntity(drugProp) end
    if moneyProp then DeleteEntity(moneyProp) end


    local failChance = math.random(0, 100)
    local failureChance = Config.FailureChance or 12

    if failChance <= failureChance then
        ESX.ShowNotification(_U("person_doesnt_want_drugs"))
        TriggerServerEvent("cDrugs:NotifyPolice", GetEntityCoords(PlayerPedId()))
    elseif minMoney and maxMoney then
        local inTerritory, territoryName = IsPlayerInTerritory()

        ESX.TriggerServerCallback("cDrugs:getPlayerCrew", function(crewName)
            if inTerritory and crewName then
                TriggerServerEvent("cDrugs:SellDrugs", drugItem, itemLabel,
                    math.random(minMoney, maxMoney), 1, territoryName, crewName)
            elseif inTerritory and not crewName then
                TriggerServerEvent("cDrugs:SellDrugs", drugItem, itemLabel,
                    math.random(minMoney, maxMoney), 1, territoryName, nil)
            else
                TriggerServerEvent("cDrugs:SellDrugs", drugItem, itemLabel,
                    math.random(minMoney, maxMoney), 1, nil, nil)
            end
        end)
    else
        ESX.ShowNotification(_U("not_enough_drugs"))
        Selldrugs.OnSellDrugs = false
    end

    Citizen.Wait(500)


    TaskWanderStandard(targetPed, 10.0, 10)
    PlayAmbientSpeech1(targetPed, "GENERIC_THANKS", "SPEECH_PARAMS_STANDARD")
    SetEntityAsMissionEntity(targetPed, true, true)
    SetPedCanRagdollFromPlayerImpact(targetPed, true)


    local despawnTime = Config.PedDespawnTime or 60000

    Citizen.CreateThread(function()
        Citizen.Wait(despawnTime)

        if DoesEntityExist(targetPed) then
            if Config.DrugInteraction and Config.DrugInteraction.Type == "ox_target" then
                RemoveOxTargetFromPed(targetPed)
            end

            DeleteEntity(targetPed)
        end
    end)
end


function Selldrugs.MakeEntityFaceEntity(entity1, entity2)
    local coords1 = GetEntityCoords(entity1, true)
    local coords2 = GetEntityCoords(entity2, true)

    local dx = coords2.x - coords1.x
    local dy = coords2.y - coords1.y
    local heading = GetHeadingFromVector_2d(dx, dy)

    SetEntityHeading(entity1, heading)
end


function Selldrugs.PositionPedForTransaction(targetPed, playerPed)
    local pedCoords = GetEntityCoords(targetPed, true)
    local distance = 1.0
    local pedHeading = GetEntityHeading(targetPed)
    local headingRad = math.rad(pedHeading)

    local x = pedCoords.x + math.sin(-headingRad) * distance
    local y = pedCoords.y + math.cos(-headingRad) * distance


    local foundGround, zPos = GetGroundZFor_3dCoord(x, y, pedCoords.z + 1.0, false)
    local z = foundGround and zPos or (pedCoords.z - 0.95)

    SetEntityCoords(playerPed, x, y, z, false, false, false, true)

    local oppositeHeading = pedHeading + 180.0
    if oppositeHeading >= 360.0 then
        oppositeHeading = oppositeHeading - 360.0
    end

    SetEntityHeading(playerPed, oppositeHeading)

    ClearPedTasksImmediately(targetPed)
    ClearPedTasksImmediately(playerPed)
    FreezeEntityPosition(targetPed, true)
    FreezeEntityPosition(playerPed, true)
end


local cachedTerritories = {}
local isCacheInitialized = false

RegisterNetEvent("nvTerritory:territoriesUpdated", function()
    ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(data)
        cachedTerritories = data or {}
        isCacheInitialized = true
    end)
end)


Citizen.CreateThread(function()
    ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(data)
        cachedTerritories = data or {}
        isCacheInitialized = true
    end)
end)


local function IsPointInPolygon(point, polygon, debugName)
    local x, y = point.x, point.y
    local inside = false
    local numPoints = #polygon
    local j = numPoints

    if debugName == "Aeroport" then
        print(string.format("[POLY DEBUG] Starting check for %s: Point=(%f,%f) PolyPoints=%d", debugName or "?", x, y, numPoints))
    end

    for i = 1, numPoints do
        local xi, yi = polygon[i].x, polygon[i].y
        local xj, yj = polygon[j].x, polygon[j].y

        local intersect = ((yi > y) ~= (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi)

        if debugName == "Aeroport" and i <= 3 then
            print(string.format("[POLY DEBUG] i=%d j=%d: Edge(%f,%f)-(%f,%f) Intersect=%s Inside=%s",
                i, j, xi, yi, xj, yj, tostring(intersect), tostring(inside)))
        end

        if intersect then
            inside = not inside
        end

        j = i
    end

    if debugName == "Aeroport" then
        print(string.format("[POLY DEBUG] Final result for %s: %s", debugName, tostring(inside)))
    end

    return inside
end

function IsPlayerInTerritory()
    local playerCoords = GetEntityCoords(PlayerPedId())

    print("[DEBUG] IsPlayerInTerritory Called. Cache Init: " .. tostring(isCacheInitialized) .. " Count: " .. (cachedTerritories and #cachedTerritories or "nil"))
    print("[DEBUG] Player Coords: " .. tostring(playerCoords))

    if not isCacheInitialized or not cachedTerritories then

        ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(data)
            print("[DEBUG] Territories loaded: " .. (data and #data or 0))
            cachedTerritories = data or {}
            isCacheInitialized = true
        end)
        return false, nil
    end

    local closestName = nil
    local closestDist = 99999.0

    for _, territory in ipairs(cachedTerritories) do

        local center = territory.center or territory.points[1]
        local dist = #(vector3(center.x, center.y, 0) - vector3(playerCoords.x, playerCoords.y, 0))

        if dist < closestDist then
            closestDist = dist
            closestName = territory.name
        end

        if territory and territory.points and IsPointInPolygon(playerCoords, territory.points, territory.name) then
            print("[DEBUG] IN TERRITORY: " .. territory.name)
            return true, territory.name
        end

        if territory.name == "Aéroport" or territory.name == "Aeroport" then
             local inPoly = IsPointInPolygon(playerCoords, territory.points, "Aeroport")

             if territory.points and territory.points[1] then
                 local p1 = territory.points[1]
                 print("[DEBUG] Aeroport Point 1 Type: x=" .. type(p1.x) .. " y=" .. type(p1.y) .. " Val: " .. tostring(p1.x) .. "," .. tostring(p1.y))
             end

             print("[DEBUG] Aeroport Check: " .. tostring(inPoly) .. " User: " .. playerCoords.x .. "," .. playerCoords.y)
        end
    end

    print("[DEBUG] Not in any territory. Closest: " .. (closestName or "None") .. " Dist: " .. closestDist)
    return false, nil
end


function IsPlayerInCrew(callback)
    ESX.TriggerServerCallback("cDrugs:getPlayerCrew", function(crewName)
        if crewName then
            callback(true, crewName)
        else
            callback(false, nil)
        end
    end)
end


local AlertContacts = {
    {
        name = "Ming",
        icon = "CHAR_HAO",
        messages = {
            deal = _U("alert_deal_ming"),
            claim = _U("alert_claim_ming")
        }
    },
    {
        name = "Dante",
        icon = "CHAR_ENGLISH_DAVE",
        messages = {
            deal = _U("alert_deal_dante"),
            claim = _U("alert_claim_dante")
        }
    },
    {
        name = "Flores",
        icon = "CHAR_JIMMY_BOSTON",
        messages = {
            deal = _U("alert_deal_flores"),
            claim = _U("alert_claim_flores")
        }
    },
    {
        name = "Majo",
        icon = "CHAR_JIMMY",
        messages = {
            deal = _U("alert_deal_majo"),
            claim = _U("alert_claim_majo")
        }
    }
}

RegisterNetEvent("cDrugs:SendAlertNotification")
AddEventHandler("cDrugs:SendAlertNotification", function(territoryName, alertType)
    local contact = AlertContacts[math.random(#AlertContacts)]
    local message = ""

    if alertType == "deal" then
        message = _U("someone_selling_drugs", contact.name, contact.messages.deal, territoryName)
    elseif alertType == "independent_deal" then
        message = _U("someone_selling_drugs", contact.name, contact.messages.deal, territoryName)
    elseif alertType == "claim" then
        message = _U("crew_claiming_territory", contact.name, contact.messages.claim, territoryName)
    end

    ESX.ShowAdvancedNotification(contact.name, "", message, contact.icon, 1)
end)


RegisterNetEvent("nvDrugs:AddBlipForPolice")
AddEventHandler("nvDrugs:AddBlipForPolice", function(coords, label)
    local blip = AddBlipForCoord(coords)

    SetBlipSprite(blip, Config.BlipSettings.id)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.BlipSettings.scale)
    SetBlipColour(blip, Config.BlipSettings.color)
    SetBlipColour(blip, Config.BlipSettings.color)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipName)
    EndTextCommandSetBlipName(blip)

    Citizen.CreateThread(function()
        Citizen.Wait(Config.BlipSettings.time)
        RemoveBlip(blip)
    end)
end)


function OpenTerritoryDashboard()

    if Config.WhoCanSee == 'crews' then
        local playerData = ESX.GetPlayerData()
        if not playerData or not playerData.job2 or playerData.job2.name == 'unemployed' or playerData.job2.name == 'aucun' then
            ESX.ShowNotification("~r~Accès refusé: Vous devez appartenir à un groupe illégal.")
            return
        end
    end

    ESX.TriggerServerCallback('cDrugs:getDashboardData', function(data)
        if not data then
            ESX.ShowNotification("~r~Erreur récupération données.")
            return
        end

        local options = {}


        local resetTime = "Inconnu"
        if data.resetDate then


            resetTime = data.resetDate
        end

        table.insert(options, {
            title = 'Prochain Reset',
            description = 'Estimation: ' .. tostring(resetTime),
            icon = 'clock',
            readOnly = true,
            colorScheme = 'blue'
        })

        table.insert(options, {
            title = 'Disponibilité Revendication',
            description = data.nextClaimTime or "Inconnu",
            icon = 'calendar-check',
            readOnly = true,
            colorScheme = 'green'
        })


        local sortedTerritories = {}
        for name, info in pairs(data.territories) do
            table.insert(sortedTerritories, {name = name, info = info})
        end

        table.sort(sortedTerritories, function(a, b)
            return (a.info.score or 0) > (b.info.score or 0)
        end)

        if #sortedTerritories == 0 then
             table.insert(options, {
                title = 'Aucun territoire revendiqué',
                disabled = true
            })
        end

        for _, t in ipairs(sortedTerritories) do
            local owner = t.info.name or "Inconnu"
            local score = t.info.score or 0

            table.insert(options, {
                title = t.name,
                description = string.format("Contrôlé par: %s | Score: %s", owner, score),
                icon = 'location-dot',
                metadata = {
                    {label = 'Leader', value = owner},
                    {label = 'Points', value = score}
                }
            })
        end

        lib.registerContext({
            id = 'territory_dashboard',
            title = 'Tableau des Territoires',
            options = options
        })

        lib.showContext('territory_dashboard')
    end)
end


exports('OpenTerritoryDashboard', OpenTerritoryDashboard)
exports('IsPlayerInTerritory', IsPlayerInTerritory)


RegisterCommand('territorydashboard', function()
    OpenTerritoryDashboard()
end)


RegisterNetEvent("nvDrugs:GetStreetName")
AddEventHandler("nvDrugs:GetStreetName", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(streetHash)

    TriggerServerEvent("nvDrugs:SendStreetNameToServer", streetName, coords)
end)