hasAccount = false

local bankInteractionIds = {}
local atmInteractionIds = {}
local currentATMEntities = {}
local atmThreadRunning = false
local accountEnsurerRunning = false

local ATMModels = {}
local ATM_SCAN_NEAR = 150
local ATM_SCAN_FAR = 900

for _, model in ipairs(Config.ATMs or {}) do
    table.insert(ATMModels, GetHashKey(model))
end

local function NotifyNoAccountATM()
    local locale = Locales[Config.Language] or {}
    local msg = locale['atm_need_account'] or 'Vous devez posséder un compte bancaire pour utiliser un distributeur.'

    if Config.Framework == 'qb' or Config.Framework == 'newqb' then
        if frameworkObject and frameworkObject.Functions and frameworkObject.Functions.Notify then
            frameworkObject.Functions.Notify(msg, 'error')
            return
        end
    else
        if frameworkObject and frameworkObject.ShowNotification then
            frameworkObject.ShowNotification(msg)
            return
        end
        TriggerEvent('esx:showNotification', msg)
    end
end

local function ResetATMInteractions()
    for entity, interactionId in pairs(atmInteractionIds) do
        if interactionId then
            exports['nv_interact']:removeInteractionPoint(interactionId)
        end
        atmInteractionIds[entity] = nil
        currentATMEntities[entity] = nil
    end
end

Config.DrawText3D = function (msg, coords)
    AddTextEntry('esxFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

local function HandleAccountRefresh(triggerEnsure)
    local status = RefreshAccountStatus()
    if triggerEnsure and not status then
        EnsureAccountStatus(6, 2000)
    end
end

if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
    AddEventHandler('esx:onPlayerSpawn', function ()
        HandleAccountRefresh(true)
    end)

    AddEventHandler('esx:playerLoaded', function ()
        HandleAccountRefresh(true)
    end)
else
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        HandleAccountRefresh(true)
    end)
end

RegisterNetEvent('oph3z-bank:UpdateAccountStatus', function(status)
    hasAccount = status and true or false
    UpdateBankInteractions()
    ResetATMInteractions()
end)

function RemoveAllBankInteractions()
    for k, interactionId in pairs(bankInteractionIds) do
        if interactionId then
            exports['nv_interact']:removeInteractionPoint(interactionId)
        end
    end
    bankInteractionIds = {}
end

function UpdateBankInteractions()
    RemoveAllBankInteractions()
    
    for k, v in pairs(Config.BankLocations) do
        local interactionPos = vector3(v.Coords.x, v.Coords.y, v.Coords.z + 0.2)
        local message = hasAccount and (Locales[Config.Language] and Locales[Config.Language]['bank_interact_label'] or "Banque") or (Locales[Config.Language] and Locales[Config.Language]['bank_create_account_label'] or "Créer un compte")
        local icon = hasAccount and "fa-solid fa-university" or "fa-solid fa-user-plus"
        
        bankInteractionIds[k] = exports['nv_interact']:addInteractionPoint({
            coords = interactionPos,
            dist = 2.0,
            key = 'E',
            message = message,
            icon = icon,
            onPress = function()
                if hasAccount then
                    TriggerEvent('oph3z-bank:OpenBank')
                else
                    TriggerServerEvent('oph3z-bank:server:CreateAccount')
                end
            end
        })
    end
end

function RefreshAccountStatus()
    local status = TriggerCallback('oph3z-bank:CheckAccountExistens')
    hasAccount = status and true or false
    UpdateBankInteractions()
    ResetATMInteractions()
    return hasAccount
end

function EnsureAccountStatus(retries, interval)
    if hasAccount or accountEnsurerRunning then
        return hasAccount
    end

    accountEnsurerRunning = true
    local attempts = retries or 5
    local delay = interval or 2000

    CreateThread(function()
        while attempts > 0 and not hasAccount do
            local status = RefreshAccountStatus()
            if status then
                break
            end
            attempts = attempts - 1
            Citizen.Wait(delay)
        end
        accountEnsurerRunning = false
    end)

    return hasAccount
end

function OpenBank()
    RemoveAllBankInteractions()
    UpdateBankInteractions()
    
    if not atmThreadRunning then
        atmThreadRunning = true
        CreateThread(function()
            while true do
                local sleep = ATM_SCAN_FAR
                local Player = PlayerPedId()
                local PlayerCoords = GetEntityCoords(Player)
                local nearbyATMs = {}
                
                for _, modelHash in ipairs(ATMModels) do
                    local ATMEntity = GetClosestObjectOfType(PlayerCoords, 2.0, modelHash, false, false, false)
                    if ATMEntity and ATMEntity ~= 0 then
                        local GetATMCoords = GetEntityCoords(ATMEntity)
                        local DistanceToATM = #(PlayerCoords - GetATMCoords)
                        
                        if DistanceToATM < 2.0 then
                            sleep = math.min(sleep, ATM_SCAN_NEAR)
                            nearbyATMs[ATMEntity] = {
                                coords = GetATMCoords,
                                entity = ATMEntity
                            }
                        end
                    end
                end
                
                for entity, _ in pairs(atmInteractionIds) do
                    if not nearbyATMs[entity] then
                        if atmInteractionIds[entity] then
                            exports['nv_interact']:removeInteractionPoint(atmInteractionIds[entity])
                        end
                        atmInteractionIds[entity] = nil
                        currentATMEntities[entity] = nil
                    end
                end
                
            for entity, atmData in pairs(nearbyATMs) do
                if not atmInteractionIds[entity] then
                    local atmInteractionPos = vector3(atmData.coords.x, atmData.coords.y, atmData.coords.z + 1.0)
                    atmInteractionIds[entity] = exports['nv_interact']:addInteractionPoint({
                            coords = atmInteractionPos,
                            dist = 2.0,
                            key = 'E',
                            message = hasAccount and (Locales[Config.Language] and Locales[Config.Language]['atm_interact_label'] or 'Distributeur') or (Locales[Config.Language] and Locales[Config.Language]['atm_interact_no_account'] or 'Compte requis'),
                            icon = hasAccount and 'fa-solid fa-credit-card' or 'fa-solid fa-user-lock',
                            onPress = function()
                                if not hasAccount then
                                    local refreshed = RefreshAccountStatus()
                                    if not refreshed then
                                        NotifyNoAccountATM()
                                        return
                                    end
                                end
                                TriggerServerEvent('oph3z-bank:OpenATM')
                            end
                        })
                        currentATMEntities[entity] = entity
                    end
                end
                
                Wait(sleep)
            end
        end)
    end
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        RemoveAllBankInteractions()
        
        for entity, interactionId in pairs(atmInteractionIds) do
            if interactionId then
                exports['nv_interact']:removeInteractionPoint(interactionId)
            end
        end
        atmInteractionIds = {}
        currentATMEntities = {}
    end
end)

function DisplayHUD(boolean)
    if Config.HideHUD then
        if boolean then
        else
        end
    end
end