--[[
    ╔════════════════════════════════════════════════════════════╗
    ║              NEVA HUD - Client Script                       ║
    ║         Server Info + Status (Health, Hunger, Voice)        ║
    ╚════════════════════════════════════════════════════════════╝
]]

ESX = exports["es_extended"]:getSharedObject()

-- ============================================
-- VARIABLES
-- ============================================
local isHudVisible = true
local isRadioActive = false
local isPhoneActive = false

local framework = nil
local QBCore = nil

-- Voice data
local voiceData = {
    mode = 2,
    modes = Config.voice.modes,
    modePercents = Config.voice.ranges,
    activeType = "regular"
}

-- ============================================
-- FRAMEWORK INITIALIZATION
-- ============================================
CreateThread(function()
    if Config.framework.name == 'esx' then
        framework = 'esx'
        print('[nv_hud] ESX framework initialized')
    elseif Config.framework.name == 'qbcore' then
        while QBCore == nil do
            QBCore = exports[Config.framework.resourceNames.qbcore]:GetCoreObject()
            if QBCore == nil then
                print('[nv_hud] Waiting for QBCore...')
                Wait(100)
            end
        end
        framework = 'qbcore'
        print('[nv_hud] QBCore framework initialized')
    else
        framework = 'standalone'
        print('[nv_hud] Running in standalone mode')
    end
end)

-- ============================================
-- SERVER INFO HUD FUNCTIONS
-- ============================================
function updatePlayerId()
    ESX.TriggerServerCallback('nv_hud:getUniqueId', function(uniqueId)
        local playerId = uniqueId or GetPlayerServerId(PlayerId())
        SendNUIMessage({
            type = 'updatePlayerId',
            player_id = playerId
        })
    end)
end

-- Initialize server config
CreateThread(function()
    Wait(2000)

    SendNUIMessage({
        type = 'setConfig',
        serverName = Config.ServerName,
        discordText = Config.DiscordText,
        textRotationInterval = Config.TextRotationInterval
    })

    updatePlayerId()
end)

-- Update player ID on spawn
AddEventHandler('playerSpawned', function()
    Citizen.SetTimeout(1000, function()
        updatePlayerId()
    end)
end)

-- Periodic player ID update
CreateThread(function()
    while true do
        updatePlayerId()
        Wait(Config.UpdateInterval)
    end
end)

-- ============================================
-- STATUS HUD FUNCTIONS
-- ============================================
function GetCurrentVoiceMode()
    return voiceData.mode
end

function GetVoiceRangeLabel()
    return voiceData.modes[GetCurrentVoiceMode()] or 'normal'
end

function GetVoiceRangePercent()
    return voiceData.modePercents[GetCurrentVoiceMode()] or 66
end

function ToggleVisible(state)
    isHudVisible = state
    SendNUIMessage({
        action = 'toggleVisibility',
        visible = state
    })
    return isHudVisible
end

exports('ToggleVisible', ToggleVisible)

function SetHudVisible(state)
    return ToggleVisible(state)
end

exports('SetHudVisible', SetHudVisible)

-- Initialize status config
CreateThread(function()
    Wait(500)
    SendNUIMessage({
        action = 'initConfig',
        config = {
            position = Config.position,
            colors = Config.colors,
            animations = Config.animations,
            circle = Config.circle,
            voiceTypes = Config.voiceTypes
        }
    })
end)

-- ============================================
-- VOICE FUNCTIONS
-- ============================================
function UpdateVoiceHUD(talking, voiceType)
    if voiceType then
        voiceData.activeType = voiceType
    end

    local mode = GetCurrentVoiceMode()
    local rangeLabel = voiceData.modes[mode]
    local rangePercent = voiceData.modePercents[mode]

    SendNUIMessage({
        action = 'voiceUpdate',
        talking = talking,
        range = rangeLabel,
        percent = rangePercent,
        voiceType = voiceData.activeType
    })
end

RegisterNetEvent('pma-voice:setTalkingMode')
AddEventHandler('pma-voice:setTalkingMode', function(mode)
    voiceData.mode = mode
    UpdateVoiceHUD(NetworkIsPlayerTalking(PlayerId()))
end)

RegisterNetEvent('pma-voice:radioActive')
AddEventHandler('pma-voice:radioActive', function(isActive)
    isRadioActive = isActive

    if isActive and NetworkIsPlayerTalking(PlayerId()) then
        UpdateVoiceHUD(true, "radio")
    elseif not isActive and NetworkIsPlayerTalking(PlayerId()) then
        UpdateVoiceHUD(true, "regular")
    end
end)

RegisterNetEvent('gcphone:call_event')
AddEventHandler('gcphone:call_event', function(event)
    if event == 'setupCall' or event == 'acceptCall' then
        isPhoneActive = true
    elseif event == 'endCall' then
        isPhoneActive = false
    end

    if NetworkIsPlayerTalking(PlayerId()) then
        UpdateVoiceHUD(true, isPhoneActive and "phone" or (isRadioActive and "radio" or "regular"))
    end
end)

-- ============================================
-- PTT & VOICE MONITORING
-- ============================================
CreateThread(function()
    local panelShown = false
    local controlTick = 0
    local isPttPressed = false

    local pttOnMessage = {
        action = 'pttState',
        active = true,
        range = GetVoiceRangeLabel(),
        percent = GetVoiceRangePercent(),
        voiceType = "regular"
    }

    local pttOffMessage = {
        action = 'pttState',
        active = false
    }

    while true do
        local wait = 1
        local playerPed = PlayerPedId()

        controlTick = controlTick + 1
        if controlTick >= 10 then
            controlTick = 0
        end

        if isHudVisible then
            local isPressing = IsControlPressed(0, Config.pttKey)

            if isPressing and not isPttPressed then
                isPttPressed = true

                if isRadioActive then
                    pttOnMessage.voiceType = "radio"
                elseif isPhoneActive then
                    pttOnMessage.voiceType = "phone"
                else
                    pttOnMessage.voiceType = "regular"
                end

                pttOnMessage.range = GetVoiceRangeLabel()
                pttOnMessage.percent = GetVoiceRangePercent()
                SendNUIMessage(pttOnMessage)

            elseif not isPressing and isPttPressed then
                isPttPressed = false
                SendNUIMessage(pttOffMessage)
            end
        end

        if panelShown then
            DisableAllControlActions(0)
            EnableControlAction(0, Config.panelKey, true)
            wait = 0
        end

        Wait(0)
    end
end)

-- Voice state monitoring
CreateThread(function()
    local lastState = false

    while true do
        Wait(250)

        if isHudVisible then
            local state = NetworkIsPlayerTalking(PlayerId())
            if state ~= lastState then
                lastState = state

                local voiceType = "regular"
                if isRadioActive then
                    voiceType = "radio"
                elseif isPhoneActive then
                    voiceType = "phone"
                end

                UpdateVoiceHUD(state, voiceType)
            end
        end
    end
end)

-- ============================================
-- PLAYER STATUS (HUNGER, THIRST, ETC)
-- ============================================
function GetPlayerStatus()
    local hunger, thirst, drunk = 100, 100, 0

    if framework == 'esx' then
        local statusEvent = Config.framework.events.esx.status

        TriggerEvent(statusEvent, 'hunger', function(status)
            hunger = status.getPercent()
        end)

        TriggerEvent(statusEvent, 'thirst', function(status)
            thirst = status.getPercent()
        end)

        TriggerEvent(statusEvent, 'drunk', function(status)
            drunk = status.getPercent()
        end)

    elseif framework == 'qbcore' and QBCore then
        local Player = QBCore.Functions.GetPlayerData()
        if Player and Player.metadata then
            local hungerKey = Config.framework.events.qbcore.hunger
            local thirstKey = Config.framework.events.qbcore.thirst
            local drunkKey = Config.framework.events.qbcore.drunk

            hunger = Player.metadata[hungerKey] or 100
            thirst = Player.metadata[thirstKey] or 100
            drunk = Player.metadata[drunkKey] or 0
        end
    end

    return hunger, thirst, drunk
end

CreateThread(function()
    local lastValues = {health = 100, armor = 100, hunger = 100, thirst = 100, drunk = 0}
    local hasChanged = false

    while true do
        if isHudVisible then
            local ped = PlayerPedId()
            local health = GetEntityHealth(ped) - 100
            local armor = GetPedArmour(ped)

            local hunger, thirst, drunk = GetPlayerStatus()

            hasChanged = math.abs(lastValues.health - health) > 1 or
                         math.abs(lastValues.armor - armor) > 1 or
                         math.abs(lastValues.hunger - hunger) > 1 or
                         math.abs(lastValues.thirst - thirst) > 1 or
                         math.abs(lastValues.drunk - drunk) > 1

            if hasChanged then
                lastValues = {
                    health = health,
                    armor = armor,
                    hunger = hunger,
                    thirst = thirst,
                    drunk = drunk
                }

                SendNUIMessage({
                    action = 'update',
                    data = lastValues
                })
            end
        end

        Wait(Config.refreshInterval)
    end
end)

-- ============================================
-- PAUSE MENU DETECTION
-- ============================================
CreateThread(function()
    local isPaused = false

    while true do
        Wait(300)

        local currentPauseState = IsPauseMenuActive()

        if isPaused ~= currentPauseState then
            isPaused = currentPauseState

            if isPaused then
                ToggleVisible(false)
            else
                ToggleVisible(true)
            end
        end
    end
end)

-- ============================================
-- EVENTS & COMMANDS (Unified)
-- ============================================
RegisterNetEvent("hud:hide")
AddEventHandler("hud:hide", function()
    ToggleVisible(false)
end)

RegisterNetEvent("hud:show")
AddEventHandler("hud:show", function()
    ToggleVisible(true)
end)

RegisterNetEvent('eHUP:openMenu')
AddEventHandler('eHUP:openMenu', function()
    ToggleVisible(false)
end)

RegisterNetEvent('eHUP:closeMenu')
AddEventHandler('eHUP:closeMenu', function()
    ToggleVisible(true)
end)

RegisterCommand('hidehud', function()
    ToggleVisible(false)
end, false)

RegisterCommand('showhud', function()
    ToggleVisible(true)
end, false)
