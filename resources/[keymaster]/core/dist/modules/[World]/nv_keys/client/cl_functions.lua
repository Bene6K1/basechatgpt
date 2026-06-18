local Config <const> = require 'dist.modules.[World].nv_keys.config.main'
local useNvInteract = Config.Target == 'nv_interact' and GetResourceState('nv_interact') == 'started'
local NvInteract = useNvInteract and exports['nv_interact'] or nil
LocksmithsInteractions = LocksmithsInteractions or {}
local locksmithMenu, locksmithVehicleMenu
local locksmithVehicleList = {}
local locksmithAction = nil
local skipMenuClose = false
local LocksmithBlips = {}

local function IsPromptAvailable()
    return GetResourceState('prompt') == 'started'
end

local function ConfirmPrompt(title, desc, desc2, cb)
    if not IsPromptAvailable() then
        cb(true)
        return
    end

    exports['prompt']:createPrompt(title, desc, desc2 or '', function(response)
        cb(response == true)
    end)
end

local function ResetLocksmithState()
    locksmithVehicleList = {}
    locksmithAction = nil
end

local function CloseLocksmithMenus()
    ResetLocksmithState()
    if locksmithVehicleMenu then
        RageUI.Visible(locksmithVehicleMenu, false)
    end
    if locksmithMenu then
        RageUI.Visible(locksmithMenu, false)
    end
end

local function PlayerHasLocalKey(plate)
    if type(HasKeys) ~= 'function' then
        return false
    end

    local ok, result = pcall(HasKeys, plate)
    if not ok then
        Debug('error', 'HasKeys call failed: %s', result)
        return false
    end
    return result
end

--- IsCarImmune(vehicle)
--- @param vehicle number
--- @return boolean
--- @description Checks if the vehicle is immune
function IsCarImmune(vehicle)
    local carImmune = false

    for _, v in pairs(Config.ImmuneVehicles) do
        if joaat(v) == GetEntityModel(vehicle) then
            carImmune = true
            break
        end
    end
    return carImmune
end

--- IsBlacklistedWeapon(weapon)
--- @param weapon number
--- @return boolean
--- @description Checks if the weapon is blacklisted
function IsBlacklistedWeapon(weapon)
    for _, v in ipairs(Config.NoCarjackWeapons) do
        if joaat(v) == weapon or tostring(v) == tostring(weapon) then
            return true
        end
    end
    return false
end

--- AddBlacklistedWeapon(weapon)
--- @param weapon number
--- @return nil
--- @description Adds a weapon to the blacklisted weapons list
function AddBlacklistedWeapon(weapon)
    if not weapon then return end
    table.insert(Config.NoCarjackWeapons, weapon)
end

exports('AddBlacklistedWeapon', AddBlacklistedWeapon)

--- RemoveBlacklistedWeapon(weapon)
--- @param weapon number
--- @return nil
--- @description Removes a weapon from the blacklisted weapons list
function RemoveBlacklistedWeapon(weapon)
    if not weapon then return end
    for i, v in ipairs(Config.NoCarjackWeapons) do
        if v == weapon or joaat(v) == weapon then
            table.remove(Config.NoCarjackWeapons, i)
            break
        end
    end
end

exports('RemoveBlacklistedWeapon', RemoveBlacklistedWeapon)

--- IsBlacklistedVehicle(vehicle)
--- @param vehicle number
--- @return boolean
--- @description Checks if the vehicle is blacklisted
function IsBlacklistedVehicle(vehicle)
    local vehModel = GetEntityModel(vehicle)
    for _, v in ipairs(Config.NoLockVehicles) do
        if joaat(v) == vehModel then
            return true
        end
    end
    if Entity(vehicle).state.ignoreLocks or (Config.IgnoreBicycles and GetVehicleClass(vehicle) == 13) then
        return true
    end

    return false
end

--- AddNoLockVehicles(model)
--- @param model string
--- @return nil
--- @description Adds a vehicle to the no lock vehicles list
function AddNoLockVehicles(model)
    if not model then return end
    table.insert(Config.NoLockVehicles, model)
end

exports('AddNoLockVehicles', AddNoLockVehicles)

--- RemoveNoLockVehicles(model)
--- @param model string
--- @return nil
--- @description Removes a vehicle from the no lock vehicles list
function RemoveNoLockVehicles(model)
    if not model then return end
    for i, v in ipairs(Config.NoLockVehicles) do
        if v == model then
            table.remove(Config.NoLockVehicles, i)
            break
        end
    end
end

exports('RemoveNoLockVehicles', RemoveNoLockVehicles)

function GetIsVehicleAccessible(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    
    if Config.Metadata and SessionVehicles[plate] then
        Debug('info', 'Vehicle %s accessible via session', plate)
        return true
    end

    if HasKeys(plate) then
        Debug('info', 'Vehicle %s accessible (has keys)', plate)
        return true
    end

    local checkResult = lib.callback.await(Scriptname .. ':server:checkVehicleAccess', false, plate)
    
    if not checkResult then
        Debug('error', 'Failed to check vehicle access for %s', plate)
        return false
    end

    Debug('info', 'Vehicle %s access check: owned=%s, company=%s, accessible=%s', 
          plate, checkResult.isOwned, checkResult.isCompany, checkResult.accessible)

    return checkResult.accessible
end

local function printDispatchDisabled(event)
    if not Config.Debug then return end
    print(('[nv_keys] Dispatch disabled, ignoring %s request.'):format(event))
end

local function GetDispatchAlertData()
    printDispatchDisabled('GetDispatchAlertData')
    return nil
end

function SendCustomDispatchAlert()
    printDispatchDisabled('SendCustomDispatchAlert')
end

function SendPoliceAlertAttempt()
    printDispatchDisabled('SendPoliceAlertAttempt')
end

exports('SendPoliceAlertAttempt', SendPoliceAlertAttempt)
exports('SendCustomDispatchAlert', SendCustomDispatchAlert)
exports('GetDispatchAlertData', GetDispatchAlertData)

--- StopAnims(type)
--- @param type string
--- @return nil
--- @description Stops the animations
function StopAnims(type)
    if type == 'toggle_lock' then
        if IsEntityPlayingAnim(cache.ped, Config.Animations["toggle_lock"].dict, Config.Animations["toggle_lock"].anim, 3) then
            StopAnimTask(cache.ped, Config.Animations["toggle_lock"].dict, Config.Animations["toggle_lock"].anim, 8.0)
        end
    elseif type == 'hold_in_hand' then
        if IsEntityPlayingAnim(cache.ped, Config.Animations["hold_in_hand"].dict, Config.Animations["hold_in_hand"].anim, 3) then
            StopAnimTask(cache.ped, Config.Animations["hold_in_hand"].dict, Config.Animations["hold_in_hand"].anim, 8.0)
        end
    elseif type == 'search_keys' then
        if IsEntityPlayingAnim(cache.ped, Config.Animations["search_keys"].dict, Config.Animations["search_keys"].anim, 3) then
            StopAnimTask(cache.ped, Config.Animations["search_keys"].dict, Config.Animations["search_keys"].anim, 8.0)
        end
    elseif type == 'hotwire_invehicle' then
        if IsEntityPlayingAnim(cache.ped, Config.Animations["hotwire_invehicle"].dict, Config.Animations["hotwire_invehicle"].anim, 3) then
            StopAnimTask(cache.ped, Config.Animations["hotwire_invehicle"].dict, Config.Animations["hotwire_invehicle"].anim, 8.0)
        end
    elseif type == 'hotwire_outsidevehicle' then
        if IsEntityPlayingAnim(cache.ped, Config.Animations["hotwire_outsidevehicle"].dict, Config.Animations["hotwire_outsidevehicle"].anim, 3) then
            StopAnimTask(cache.ped, Config.Animations["hotwire_outsidevehicle"].dict, Config.Animations["hotwire_outsidevehicle"].anim, 8.0)
        end
    end
end

local function GetVehiclesForNewKey()
    Debug('info', 'Requesting vehicles list from server...')
    local vehicles = lib.callback.await(Scriptname .. ':server:getVehicles', false)
    
    if not vehicles then 
        Debug('error', 'Callback returned nil')
        return {}
    end
    
    Debug('info', 'Received %d vehicles from server', #vehicles)
    
    if #vehicles == 0 then 
        Debug('warning', 'No vehicles in list')
        return {}
    end

    local formattedVehicles = {}

    for i, vehicle in ipairs(vehicles) do
        local modelName = vehicle.model or vehicle.vehicle or 'Véhicule'
        local label = string.format('%s [%s]', modelName, vehicle.plate)
        
        formattedVehicles[#formattedVehicles + 1] = {
            plate = vehicle.plate,
            label = label
        }
        Debug('info', '[%d] Formatted: %s', i, label)
    end

    Debug('success', 'Returning %d formatted vehicles', #formattedVehicles)
    return formattedVehicles
end

local function GetVehiclesForNewLock()
    return GetVehiclesForNewKey()
end

local function EnsureLocksmithMenus()
    if locksmithMenu then return end

    locksmithMenu = RageUI.CreateMenu('', _T('context_menu.header'))
    locksmithVehicleMenu = RageUI.CreateSubMenu(locksmithMenu, '', _T('context_menu.select_vehicle'))

    locksmithMenu.Closed = function()
        if skipMenuClose then
            Debug('info', 'Skipping main menu close cleanup (submenu opening)')
            return
        end
        Debug('info', 'Main menu closed, clearing lists')
        ResetLocksmithState()
    end

    locksmithVehicleMenu.Closed = function()
        Debug('info', 'Vehicle submenu closed, clearing vehicle list')
        ResetLocksmithState()
        skipMenuClose = false
    end
end

local function HandleVehicleSelection(plate)
    if not plate or plate == '' then
        Notify.SendNotify('Plaque invalide.', 'error', 3000)
        return
    end

    if locksmithAction == 'new_key' then
        local hasKey = PlayerHasLocalKey(plate)
        local prices = Config.LocksmithPrices or {}
        local price = hasKey and (prices.duplicateKey or 0) or (prices.firstKey or 0)
        local title = hasKey and 'Duplicata de clé' or 'Première clé'
        local desc = price > 0 and ('Paiement de %s$ en liquide requis.'):format(price) or 'Cette clé est gratuite.'

        ConfirmPrompt(title, desc, ('Véhicule [%s]'):format(plate), function(accept)
            if not accept then
                Notify.SendNotify('Action annulée.', 'info', 2500)
                return
            end
            
            Debug('info', 'Player confirmed key purchase for plate: %s', plate)
        TriggerServerEvent(Scriptname .. ':server:CreateNewKey', plate)
            CloseLocksmithMenus()
        end)
    elseif locksmithAction == 'new_lock' then
        if not PlayerHasLocalKey(plate) then
            Notify.SendNotify('Vous devez déjà avoir la clé de ce véhicule.', 'error', 3500)
            return
        end

        local price = Config.NewLockPrice or 0
        ConfirmPrompt('Changer la serrure', ('Cette opération coûte %s$ (cash uniquement).'):format(price), ('Véhicule [%s]'):format(plate), function(accept)
            if not accept then
                Notify.SendNotify('Action annulée.', 'info', 2500)
                return
            end
            TriggerServerEvent(Scriptname .. ':server:CreateNewLock', plate)
            CloseLocksmithMenus()
        end)
    end
end

local function OpenLocksmithMenu()
    if not RageUI then
        print('[nv_keys] RageUI indisponible pour le menu serrurier.')
        return
    end

    EnsureLocksmithMenus()
    RageUI.Visible(locksmithMenu, true)

    CreateThread(function()
        while locksmithMenu and (RageUI.Visible(locksmithMenu) or RageUI.Visible(locksmithVehicleMenu)) do
            RageUI.IsVisible(locksmithMenu, function()
                RageUI.Separator(_T('context_menu.header'))

                local duplicatePrice = (Config.LocksmithPrices and Config.LocksmithPrices.duplicateKey) or 0
                local lockPrice = Config.NewLockPrice or 0
                local firstKeyInfo = duplicatePrice > 0
                    and ('Première clé gratuite, duplicata %s$'):format(duplicatePrice)
                    or 'Clés gratuites et illimitées'

                RageUI.Separator(('~c~%s'):format(firstKeyInfo))
                RageUI.Separator(('~c~Changer la serrure : %s$'):format(lockPrice))

                RageUI.Button(
                    _T('context_menu.create_new_key'),
                    duplicatePrice > 0 and ('Duplicata : %s$, première clé offerte.'):format(duplicatePrice) or 'Clés gratuites.',
                    { RightLabel = duplicatePrice > 0 and ('%s$'):format(duplicatePrice) or 'Gratuit' },
                    true, {
                    onSelected = function()
                        Debug('info', 'Player clicked create_new_key button')
                        local vehicles = GetVehiclesForNewKey()
                        Debug('info', 'GetVehiclesForNewKey returned: %s', vehicles and #vehicles or 'nil')
                        
                        if not vehicles or #vehicles == 0 then
                            Debug('warning', 'No vehicles available, showing error')
                            Notify.SendNotify('Vous n\'avez aucun véhicule enregistré.', 'error', 3000)
                            return
                        end
                        
                        Debug('success', 'Setting locksmithVehicleList with %d vehicles', #vehicles)
                        locksmithVehicleList = vehicles
                        locksmithAction = 'new_key'
                        skipMenuClose = true
                        RageUI.Visible(locksmithVehicleMenu, true)
                        Wait(50)
                        skipMenuClose = false
                    end
                })

                RageUI.Button(
                    _T('context_menu.create_new_lock'),
                    ('Changer la serrure : %s$ (nécessite une clé existante).'):format(lockPrice),
                    { RightLabel = ('%s$'):format(lockPrice) },
                    true, {
                    onSelected = function()
                        local vehicles = GetVehiclesForNewLock()
                        if not vehicles or #vehicles == 0 then
                            Notify.SendNotify(_T('error.no_vehicles'), 'error', 3000)
                            return
                        end
                        locksmithVehicleList = vehicles
                        locksmithAction = 'new_lock'
                        skipMenuClose = true
                        RageUI.Visible(locksmithVehicleMenu, true)
                        Wait(50)
                        skipMenuClose = false
                    end
                })
            end)

            RageUI.IsVisible(locksmithVehicleMenu, function()
                Debug('info', 'Rendering vehicle submenu, list size: %s', locksmithVehicleList and #locksmithVehicleList or 'nil')
                
                if not locksmithVehicleList or #locksmithVehicleList == 0 then
                    RageUI.Separator('Aucun véhicule disponible')
                    Debug('warning', 'Vehicle list is empty in submenu')
                    return
                end

                for i, vehicle in ipairs(locksmithVehicleList) do
                    Debug('info', 'Rendering button [%d]: %s', i, vehicle.label)
                    RageUI.Button(vehicle.label, nil, {}, true, {
                        onSelected = function()
                            Debug('info', 'Player selected vehicle: %s', vehicle.plate)
                            HandleVehicleSelection(vehicle.plate)
                        end
                    })
                end
            end)

            Wait(0)
        end
    end)
end

local function RemoveLocksmithInteractions()
    if not (useNvInteract and NvInteract) then
        LocksmithsInteractions = {}
        return
    end

    for _, interactionId in ipairs(LocksmithsInteractions) do
        NvInteract:removeInteractionPoint(interactionId)
    end
    LocksmithsInteractions = {}
end

--- CreateLocksmith()
--- @return nil
--- @description Creates the locksmith
function CreateLocksmith()
    LocksmithsZones = {}
    RemoveLocksmithInteractions()
    for _, blip in ipairs(LocksmithBlips) do
        RemoveBlip(blip)
    end
    LocksmithBlips = {}
    for _, v in pairs(Config.Locksmiths) do
        if not IsModelValid(v.model) then goto continue end

        if Config.LocksmithBlip and Config.LocksmithBlip.enabled then
            local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, Config.LocksmithBlip.sprite or 134)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.LocksmithBlip.scale or 0.8)
            SetBlipColour(blip, Config.LocksmithBlip.colour or 3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(Config.LocksmithBlip.label or 'Serrurier')
            EndTextCommandSetBlipName(blip)
            LocksmithBlips[#LocksmithBlips + 1] = blip
        end

        lib.requestModel(v.model)
        LocksmithsPeds[#LocksmithsPeds + 1] = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, false)
        FreezeEntityPosition(LocksmithsPeds[#LocksmithsPeds], true)
        SetEntityInvincible(LocksmithsPeds[#LocksmithsPeds], true)
        SetBlockingOfNonTemporaryEvents(LocksmithsPeds[#LocksmithsPeds], true)

        if Config.Target and not useNvInteract then
            Target.AddLocalEntity(LocksmithsPeds[#LocksmithsPeds], {
                {
                    name = 'locksmith',
                    label = _T('context_menu.header'),
                    icon = 'fas fa-lock',
                    onSelect = function()
                        OpenLocksmithMenu()
                    end
                }
            })
        elseif useNvInteract and NvInteract then
            local interactionId = NvInteract:addInteractionPoint({
                coords = vector3(v.coords.x, v.coords.y, v.coords.z + 1.0),
                dist = 2.0,
                key = Config.Keys['locksmith'] and Config.Keys['locksmith'].name or 'E',
                message = _T('context_menu.header'),
                icon = 'fa-solid fa-lock',
                onPress = function()
                    OpenLocksmithMenu()
                end
            })

            if interactionId then
                LocksmithsInteractions[#LocksmithsInteractions + 1] = interactionId
            end
        else
            LocksmithsZones[#LocksmithsZones + 1] = lib.zones.sphere({
                coords = v.coords,
                radius = 1.5,
                debug = false,
                inside = function(self)
                    if IsControlJustPressed(0, Config.Keys['locksmith'].index) then
                        OpenLocksmithMenu()
                    end
                end,
                onEnter = function(self)
                    lib.showTextUI(_T('textui.locksmith', Config.Keys['locksmith'].name))
                end,
                onExit = function(self)
                    lib.hideTextUI()
                end
            })
        end

        ::continue::
    end
end

local function GetWebLocales()
    return NVKeysLocalesNUI or {}
end

local loadedLocales = false
function NuiMessage(action, data)
    if not loadedLocales then
        return
    end

    SendNUIMessage({
        action = action,
        data = data,
    })
end

RegisterNUICallback('SET_LOCALES', function(data, cb)
    loadedLocales = true
    cb('ok')
end)

CreateThread(function()
    while not loadedLocales do
        Wait(100)
        SendNUIMessage({
            action = 'SET_LOCALES',
            locales = GetWebLocales(),
        })
    end
end)

--- @param resource string
--- @return nil
--- @description Called when the resource stops
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, v in pairs(LocksmithsPeds) do
            DeleteEntity(v)
        end
        for _, v in pairs(LocksmithsZones) do
            v:remove()
        end

        LocksmithsPeds = {}
        LocksmithsZones = {}
        RemoveLocksmithInteractions()
        for _, blip in ipairs(LocksmithBlips) do
            RemoveBlip(blip)
        end
        LocksmithBlips = {}
    end
end)