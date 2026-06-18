--[[
    =============================================
    NEVA - SYSTEME AFK
    Script Client Principal
    =============================================
]]--

local ESX = exports['es_extended']:getSharedObject()

-- =============================================
-- VARIABLES LOCALES
-- =============================================
local isAFK = false
local afkData = nil
local lastPosition = nil
local exitMarker = nil
local overlayActive = false
local leaderboardData = {}
local waitingForLeaderboard = false

-- Stats locales pour l'overlay
local currentStats = {
    duration = 0,
    earnings = 0,
    multiplier = 1.0,
    isVIP = false,
    nextReward = 0
}

-- =============================================
-- FONCTIONS UTILITAIRES
-- =============================================

-- Formater le temps
local function FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60

    if hours > 0 then
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    else
        return string.format("%02d:%02d", minutes, secs)
    end
end

-- Formater l'argent
local function FormatMoney(amount)
    local formatted = tostring(amount)
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return "$" .. formatted
end

-- =============================================
-- ENTREE EN MODE AFK
-- =============================================

local function EnterAFKMode(data)
    isAFK = true
    afkData = data

    local playerPed = PlayerPedId()

    -- Sauvegarder la position actuelle
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    lastPosition = {x = coords.x, y = coords.y, z = coords.z, h = heading}

    -- Teleporter dans la zone AFK
    local afkCoords = Config.AFK.Zone.Coords
    SetEntityCoords(playerPed, afkCoords.x, afkCoords.y, afkCoords.z, false, false, false, false)
    SetEntityHeading(playerPed, afkCoords.w)

    -- Figer le joueur
    FreezeEntityPosition(playerPed, true)
    SetEntityInvincible(playerPed, true)
    SetEntityVisible(playerPed, false, false)

    -- Desactiver les controles
    DisableAllControlActions(0)

    -- Animation si activee
    if Config.AFK.Effects.Animation.Enabled then
        local dict = Config.AFK.Effects.Animation.Dict
        local anim = Config.AFK.Effects.Animation.Name

        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(100)
        end

        if Config.AFK.Effects.Animation.Loop then
            TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, -1, 1, 0, false, false, false)
        else
            TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, -1, 0, 0, false, false, false)
        end
    end

    -- Effet visuel si active
    if Config.AFK.Effects.ScreenEffect.Enabled then
        StartScreenEffect(Config.AFK.Effects.ScreenEffect.Effect, 0, true)
    end

    -- Afficher l'overlay
    if Config.AFK.Overlay.Enabled then
        ShowOverlay(true)
    end

    -- Demander les stats initiales
    TriggerServerEvent('neva:afk:requestStats')

    -- Demander le leaderboard
    if Config.AFK.Leaderboard.ShowInZone then
        TriggerServerEvent('neva:afk:requestLeaderboard')
    end
end

-- =============================================
-- SORTIE DU MODE AFK
-- =============================================

local function LeaveAFKMode()
    if not isAFK then return end

    local playerPed = PlayerPedId()

    -- Arreter l'effet visuel
    if Config.AFK.Effects.ScreenEffect.Enabled then
        StopScreenEffect(Config.AFK.Effects.ScreenEffect.Effect)
    end

    -- Arreter l'animation
    ClearPedTasks(playerPed)

    -- Remettre le joueur visible et mobile
    SetEntityVisible(playerPed, true, false)
    SetEntityInvincible(playerPed, false)
    FreezeEntityPosition(playerPed, false)

    -- Teleporter a la derniere position
    if Config.AFK.Zone.ReturnToLastPosition and lastPosition then
        SetEntityCoords(playerPed, lastPosition.x, lastPosition.y, lastPosition.z, false, false, false, false)
        SetEntityHeading(playerPed, lastPosition.h)
    else
        local defaultCoords = Config.AFK.Zone.DefaultReturnCoords
        SetEntityCoords(playerPed, defaultCoords.x, defaultCoords.y, defaultCoords.z, false, false, false, false)
        SetEntityHeading(playerPed, defaultCoords.w)
    end

    -- Cacher l'overlay
    if Config.AFK.Overlay.Enabled then
        ShowOverlay(false)
    end

    -- Reset des variables
    isAFK = false
    afkData = nil
    lastPosition = nil
    currentStats = {
        duration = 0,
        earnings = 0,
        multiplier = 1.0,
        isVIP = false,
        nextReward = 0
    }
end

-- =============================================
-- OVERLAY NUI
-- =============================================

function ShowOverlay(show)
    overlayActive = show
    SendNUIMessage({
        action = 'toggleOverlay',
        show = show,
        config = {
            position = Config.AFK.Overlay.Position,
            theme = Config.AFK.Overlay.Theme,
            opacity = Config.AFK.Overlay.Opacity,
            showTimer = Config.AFK.Overlay.ShowTimer,
            showEarnings = Config.AFK.Overlay.ShowEarnings,
            showNextReward = Config.AFK.Overlay.ShowNextReward,
            showVIPStatus = Config.AFK.Overlay.ShowVIPStatus,
            showLeaderboard = Config.AFK.Overlay.ShowLeaderboard,
            showExitInfo = Config.AFK.Overlay.ShowExitInfo,
            exitKey = Config.AFK.Controls.ExitKey
        }
    })
end

function UpdateOverlayStats()
    if not overlayActive then return end

    SendNUIMessage({
        action = 'updateStats',
        stats = {
            duration = FormatTime(currentStats.duration),
            earnings = FormatMoney(currentStats.earnings),
            multiplier = string.format("x%.1f", currentStats.multiplier),
            isVIP = currentStats.isVIP,
            nextReward = currentStats.nextReward
        }
    })
end

function UpdateOverlayLeaderboard(data)
    if not overlayActive then return end
    if not data or type(data) ~= 'table' then return end

    local formattedData = {}
    for i, player in ipairs(data) do
        table.insert(formattedData, {
            rank = i,
            name = (player.firstname or 'Inconnu') .. ' ' .. (player.lastname or ''),
            time = FormatTime((player.total_minutes or 0) * 60),
            earnings = FormatMoney(player.total_earnings or 0)
        })
    end

    SendNUIMessage({
        action = 'updateLeaderboard',
        leaderboard = formattedData
    })
end

-- =============================================
-- THREAD PRINCIPAL
-- =============================================

-- Thread pour les controles en mode AFK
CreateThread(function()
    while true do
        Wait(0)

        if isAFK then
            local playerPed = PlayerPedId()

            -- Desactiver tous les controles
            DisableAllControlActions(0)

            -- Garder le joueur fige
            FreezeEntityPosition(playerPed, true)

            -- Verifier la touche de sortie
            if Config.AFK.Controls.ExitOnKeyPress then
                -- Activer uniquement la touche de sortie
                EnableControlAction(0, Config.AFK.Controls.ExitKeyCode, true)

                if IsControlJustPressed(0, Config.AFK.Controls.ExitKeyCode) then
                    TriggerServerEvent('neva:afk:leave')
                end
            end

            -- Dessiner le marker de sortie si active
            if Config.AFK.Controls.ExitOnPoint then
                local exitPoint = Config.AFK.Zone.ExitPoint
                local markerConfig = exitPoint.Marker

                DrawMarker(
                    markerConfig.Type,
                    exitPoint.Coords.x, exitPoint.Coords.y, exitPoint.Coords.z - 1.0,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    markerConfig.Size.x, markerConfig.Size.y, markerConfig.Size.z,
                    markerConfig.Color.r, markerConfig.Color.g, markerConfig.Color.b, markerConfig.Color.a,
                    markerConfig.BobUpAndDown, false, 2, false, nil, nil, false
                )
            end
        else
            Wait(500)
        end
    end
end)

-- Thread pour la mise a jour du timer local
CreateThread(function()
    while true do
        Wait(1000)

        if isAFK and afkData then
            currentStats.duration = currentStats.duration + 1

            if currentStats.nextReward > 0 then
                currentStats.nextReward = currentStats.nextReward - 1
            else
                currentStats.nextReward = Config.AFK.Rewards.Interval
            end

            UpdateOverlayStats()
        end
    end
end)

-- Thread pour rafraichir le leaderboard
CreateThread(function()
    while true do
        Wait(Config.AFK.Leaderboard.RefreshInterval * 1000)

        if isAFK and Config.AFK.Leaderboard.ShowInZone then
            TriggerServerEvent('neva:afk:requestLeaderboard')
        end
    end
end)

-- =============================================
-- EVENTS
-- =============================================

-- Entree en mode AFK reussie
RegisterNetEvent('neva:afk:enterSuccess', function(data)
    EnterAFKMode(data)
end)

-- Sortie du mode AFK reussie
RegisterNetEvent('neva:afk:leaveSuccess', function()
    LeaveAFKMode()
end)

-- Sortie forcee
RegisterNetEvent('neva:afk:forceLeave', function(message)
    LeaveAFKMode()
    ESX.ShowNotification(message)
end)

local function ShowLeaderboardPopup(data)
    if not data or type(data) ~= 'table' or #data == 0 then
        ESX.ShowNotification("~r~Aucune donnee disponible pour le leaderboard")
        waitingForLeaderboard = false
        SetNuiFocus(false, false)
        return
    end

    local formattedData = {}
    for i, player in ipairs(data) do
        local totalMinutes = tonumber(player.total_minutes) or 0
        local hours = math.floor(totalMinutes / 60)
        local mins = totalMinutes % 60
        local timeStr = string.format("%dh %02dm", hours, mins)
        
        local firstName = tostring(player.firstname or 'Inconnu')
        local lastName = tostring(player.lastname or '')
        local fullName = firstName .. ' ' .. lastName
        
        table.insert(formattedData, {
            name = fullName,
            time = timeStr,
            earnings = FormatMoney(tonumber(player.total_earnings) or 0)
        })
    end

    if #formattedData == 0 then
        ESX.ShowNotification("~r~Aucune donnee disponible pour le leaderboard")
        waitingForLeaderboard = false
        SetNuiFocus(false, false)
        return
    end

    SendNUIMessage({
        action = 'showLeaderboardPopup',
        leaderboard = formattedData
    })
    
    Wait(50) -- Petit délai pour s'assurer que le NUI a reçu le message
    SetNuiFocus(true, true)
end

-- Mise a jour des stats
RegisterNetEvent('neva:afk:updateStats', function(stats)
    currentStats = stats
    UpdateOverlayStats()
end)

RegisterNetEvent('neva:afk:receiveLeaderboard', function(data)
    leaderboardData = data or {}
    if data and type(data) == 'table' then
        UpdateOverlayLeaderboard(data)
    end
    
    if waitingForLeaderboard then
        waitingForLeaderboard = false
        if data and type(data) == 'table' and #data > 0 then
            ShowLeaderboardPopup(data)
        else
            ESX.ShowNotification("~r~Aucune donnee disponible pour le leaderboard")
            SetNuiFocus(false, false)
        end
    end
end)

-- Afficher le leaderboard (commande)
RegisterNetEvent('neva:afk:showLeaderboard', function(data)
    if data and #data > 0 then
        ESX.ShowNotification(Config.AFK.Messages.LeaderboardTitle)
        for i, player in ipairs(data) do
            local hours = math.floor(player.total_minutes / 60)
            local mins = player.total_minutes % 60
            local timeStr = string.format("%dh %02dm", hours, mins)
            local name = player.firstname .. ' ' .. player.lastname
            Wait(100)
            ESX.ShowNotification(string.format(Config.AFK.Messages.LeaderboardEntry, i, name, timeStr))
        end
    else
        ESX.ShowNotification("~r~Aucune donnee disponible")
    end
end)

-- =============================================
-- CALLBACKS NUI
-- =============================================

RegisterNUICallback('closeOverlay', function(data, cb)
    if isAFK and Config.AFK.Controls.ExitOnKeyPress then
        TriggerServerEvent('neva:afk:leave')
    end
    cb('ok')
end)

RegisterNUICallback('closeLeaderboard', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'hideLeaderboardPopup'
    })
    cb('ok')
end)

RegisterNUICallback('requestLeaderboard', function(data, cb)
    TriggerServerEvent('neva:afk:requestLeaderboard')
    cb('ok')
end)

-- =============================================
-- COMMANDES CLIENT
-- =============================================

-- Registrer les commandes via chat
RegisterCommand(Config.AFK.Commands.Enter, function()
    if not isAFK then
        TriggerServerEvent('neva:afk:enter')
    else
        ESX.ShowNotification(Config.AFK.Messages.AlreadyAFK)
    end
end, false)

RegisterCommand(Config.AFK.Commands.Leave, function()
    if isAFK then
        TriggerServerEvent('neva:afk:leave')
    else
        ESX.ShowNotification(Config.AFK.Messages.NotAFK)
    end
end, false)

RegisterCommand(Config.AFK.Commands.Leaderboard, function()
    waitingForLeaderboard = true
    TriggerServerEvent('neva:afk:requestLeaderboard')
    
    CreateThread(function()
        Wait(3000)
        if waitingForLeaderboard then
            waitingForLeaderboard = false
            ESX.ShowNotification("~r~Timeout: Impossible de charger le leaderboard")
            SetNuiFocus(false, false)
        end
    end)
end, false)

-- =============================================
-- NETTOYAGE
-- =============================================

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        if isAFK then
            LeaveAFKMode()
        end

        -- Cacher l'overlay
        SendNUIMessage({
            action = 'toggleOverlay',
            show = false
        })
    end
end)

-- =============================================
-- EXPORTS CLIENT
-- =============================================

exports('isAFK', function()
    return isAFK
end)

exports('getAFKStats', function()
    return currentStats
end)
