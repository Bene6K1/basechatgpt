if Config.Framework == 'esx' then
    ESX = exports.es_extended:getSharedObject()
elseif Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

function showNotification(message)
    if Config.Framework == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Framework == 'qbcore' then
        QBCore.Functions.Notify(message, 'primary')
    end
end

function showHelpNotification(message)
    if Config.Framework == 'esx' then
        ESX.ShowHelpNotification(message)
    else
        BeginTextCommandDisplayHelp("STRING")
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end

function getPedAppearance()
    local playerPed = PlayerPedId()
    if Config.AppearanceRessource == 'illenium-appearance' then
        return exports['illenium-appearance']:getPedAppearance(playerPed)
    elseif Config.AppearanceRessource == 'fivem-appearance' then
        return exports['fivem-appearance']:getPedAppearance(playerPed)
    elseif Config.AppearanceRessource == 'skinchanger' then
        local p = promise.new()
        TriggerEvent('skinchanger:getSkin', function(skin)
            p:resolve(skin)
        end)
        return Citizen.Await(p)
    end
end

function savePedAppearance(appearance)
    local playerPed = PlayerPedId()
    if Config.AppearanceRessource == 'illenium-appearance' then
        exports['illenium-appearance']:setPedAppearance(playerPed, appearance)
    elseif Config.AppearanceRessource == 'fivem-appearance' then
        exports['fivem-appearance']:setPedAppearance(playerPed, appearance)
    elseif Config.AppearanceRessource == 'skinchanger' then
        TriggerEvent('skinchanger:loadSkin', appearance)
    end
    if Config.Inventory == 'core-inventory' then
        exports.core_inventory:addClothingItemFromPedSkinInInventory(PlayerPedId(), false, true, true)
    end
    if Config.Inventory == 'qs-inventory' then
        exports['qs-inventory']:setInClothing(false)
    end
end

RegisterNUICallback('getGender', function(_, cb)
    local ped = PlayerPedId()
    if Config.AppearanceRessource == 'skinchanger' then
        local model = GetEntityModel(ped)
        local gender = (model == GetHashKey('mp_m_freemode_01')) and 'male' or 'female'
        cb({ gender = gender })
        return
    end
    local appearance
    if Config.AppearanceRessource == 'illenium-appearance' then
        appearance = exports['illenium-appearance']:getPedAppearance(ped)
    elseif Config.AppearanceRessource == 'fivem-appearance' then
        appearance = exports['fivem-appearance']:getPedAppearance(ped)
    end
    local gender = appearance.model == 'mp_m_freemode_01' and 'male' or 'female'
    cb({ gender = gender })
end)

loaded = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    loaded = true
end)

RegisterNetEvent('esx:playerLoaded', function()
    loaded = true
end)

RegisterNetEvent('nvCloth:showNotification')
AddEventHandler('nvCloth:showNotification', function(icon, color, message)
    showNotification(message)
end)