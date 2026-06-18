local menuOpen = false
local isProcessing = false

local function openMapDirect()
    if Functions and Functions.OpenMap then
        Functions.OpenMap()
        return
    end

    if menuOpen then
        statePause()
        Wait(70)
    end

    ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_MP_PAUSE"), 0, -1)

    while not IsFrontendReadyForControl() do
        Wait(10)
    end

    Wait(20)
    SetControlNormal(2, 201, 1.0)
end

RegisterNetEvent("ethPauseMenu:updateMoney")
AddEventHandler("ethPauseMenu:updateMoney", function(money)
    SendNUIMessage({
        type = "updateMoney",
        money = money
    })
end)

function statePause()
    if isProcessing then
        return
    end
    
    isProcessing = true
    
    TriggerServerEvent("ethPauseMenu:getMoney")
    SetPauseMenuActive(false)
    
    if menuOpen then
        TriggerScreenblurFadeOut(0)
        menuOpen = false
        SendNUIMessage({type = "close"})
        DisplayRadar(true)
        SetNuiFocus(false, false)
        
        TriggerEvent("hud:show")
        TriggerEvent("eHUP:closeMenu")
    else
        local playerInfo = BuildPauseMenuPlayerInfo()
        SendNUIMessage({
            type = "open",
            id = playerInfo.id,
            cash = playerInfo.cash,
            money = playerInfo.money,
            job = playerInfo.job,
            playerName = playerInfo.playerName,
            discord = Config.Discord,
            media = Config.Media,
        })
        
        DisplayRadar(false)
        TriggerScreenblurFadeIn(0)
        SetNuiFocus(true, true)
        
        TriggerEvent("hud:hide")
        TriggerEvent("eHUP:openMenu")
        
        menuOpen = true
    end
    
    Wait(500)
    isProcessing = false
end

RegisterNetEvent("ethPause:openPause")
AddEventHandler("ethPause:openPause", function()
    statePause()
end)

RegisterNUICallback("closePause", function(data, cb)
    isProcessing = true
    TriggerScreenblurFadeOut(0)
    menuOpen = false
    SendNUIMessage({type = "close"})
    DisplayRadar(true)
    SetNuiFocus(false, false)
    
    TriggerEvent("hud:show")
    TriggerEvent("eHUP:closeMenu")
    
    Wait(500)
    isProcessing = false
    cb("ok")
end)

RegisterCommand("openpausemenu", function()
    if IsPauseMenuActive() then
        return
    end
    
    if not menuOpen then
        statePause()
        Wait(700)
    end
end)

Citizen.CreateThread(function()
    while true do
        SetPauseMenuActive(false)
        Wait(0)
    end
end)

RegisterCommand("openmap", function()
    openMapDirect()
end)

RegisterKeyMapping("openpausemenu", "Menu Pause", "keyboard", "ESCAPE")
RegisterKeyMapping("openmap", "Menu Pause", "keyboard", Config.MapKey or "M")

RegisterNUICallback("map", function(data, cb)
    openMapDirect()
    cb("ok")
end)

RegisterNUICallback("settings", function(data, cb)
    Wait(300)
    ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_LANDING_MENU"), 0, -1)
    statePause()
    cb("ok")
end)

RegisterNUICallback("disconnect", function(data, cb)
    Wait(300)
    statePause()
    TriggerServerEvent("ethPauseMenu:disconnect")
    cb("ok")
end)

RegisterNUICallback("shop", function(data, cb)
    Wait(300)
    statePause()
    ExecuteCommand("shop")
    cb("ok")
end)