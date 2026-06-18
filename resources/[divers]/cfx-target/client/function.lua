ESX = exports["es_extended"]:getSharedObject()
PlayerData = {}
Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    RefreshMoney()
    RefreshMoney2()
    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    RefreshMoney()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
    RefreshMoney2()
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
      ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    for i=1, #ESX.PlayerData.accounts, 1 do
        if ESX.PlayerData.accounts[i].name == account.name then
            ESX.PlayerData.accounts[i] = account
            break
        end
    end
end)

societymoney, societymoney2 = nil, nil

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
        societymoney = ESX.Math.GroupDigits(money)
    end

    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
        societymoney2 = ESX.Math.GroupDigits(money)
    end
end)

function RefreshMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('five_society:getSocietyMoney', function(money)
            societymoney = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job.name)
    end
end
function RefreshMoney2()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('five_society:getSocietyMoney', function(money)
            societymoney2 = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job2.name)
    end
end

Config_me = {
    language = 'fr',
    color = { r = 230, g = 230, b = 230, a = 255 },
    font = 0, 
    time = 5000, 
    scale = 0.5, 
    dist = 250, 
}

local c = Config_me 
local peds = {}
local GetGameTimer = GetGameTimer
function draw3dText(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    local scale = 200 / (GetGameplayCamFov() * dist)
    SetTextColour(c.color.r, c.color.g, c.color.b, c.color.a)
    SetTextScale(0.0, c.scale * scale)
    SetTextFont(c.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end
function displayText(ped, text)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local targetPos = GetEntityCoords(ped)
    local dist = #(playerPos - targetPos)
    local los = HasEntityClearLosToEntity(playerPed, ped, 17)
    if dist <= c.dist and los then
        local exists = peds[ped] ~= nil
        peds[ped] = {
            time = GetGameTimer() + c.time,
            text = text
        }
        if not exists then
            local display = true
            while display do
                Wait(0)
                local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
                draw3dText(pos, peds[ped].text)
                display = GetGameTimer() <= peds[ped].time
            end
            peds[ped] = nil
        end
    end
end

function onShareDisplay(text, target)
    local player = GetPlayerFromServerId(target)
    if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)
        displayText(ped, text)
    end
end

function OnCustom(vehicle)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 14, 0, true)
    SetVehicleNumberPlateTextIndex(vehicle, 5)
    ToggleVehicleMod(vehicle, 18, true)
    SetVehicleColours(vehicle, 0, 0)
    SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
    SetVehicleModColor_2(vehicle, 5, 0)
    SetVehicleExtraColours(vehicle, 111, 111)
    SetVehicleWindowTint(vehicle, 3)
    ToggleVehicleMod(vehicle, 22, true)
    SetVehicleMod(vehicle, 23, 11, false)
    SetVehicleMod(vehicle, 24, 11, false)
    SetVehicleWheelType(vehicle, 120)
    SetVehicleWindowTint(vehicle, 3)
    ToggleVehicleMod(vehicle, 20, true)
    SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
    LowerConvertibleRoof(vehicle, true)
    SetVehicleIsStolen(vehicle, false)
    SetVehicleIsWanted(vehicle, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetCanResprayVehicle(vehicle, true)
    SetPlayersLastVehicle(vehicle)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleTyresCanBurst(vehicle, false)
    SetVehicleWheelsCanBreak(vehicle, false)
    SetVehicleCanBeTargetted(vehicle, false)
    SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
    SetVehicleHasStrongAxles(vehicle, true)
    SetVehicleDirtLevel(vehicle, 0)
    SetVehicleCanBeVisiblyDamaged(vehicle, false)
    IsVehicleDriveable(vehicle, true)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleStrong(vehicle, true)
    RollDownWindow(vehicle, 0)
    RollDownWindow(vehicle, 1)
    SetPedCanBeDraggedOut(PlayerPedId(), false)
    SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
    SetPedRagdollOnCollision(PlayerPedId(), false)
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedDecorations(PlayerPedId())
    SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
end

function GetPlayerIdFromPed(id)
    for i = 0,500 do
        if NetworkIsPlayerActive(i) then
            if GetPlayerPed(i) == id then
                return GetPlayerServerId(i)
            end
        end
    end
end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end