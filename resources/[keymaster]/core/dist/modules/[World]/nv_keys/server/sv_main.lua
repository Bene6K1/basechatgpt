local Config <const> = require 'dist.modules.[World].nv_keys.config.main'
local isReady = false
VehicleList = {}

local itemCooldown = {}

local function isCompanyOwner(owner)
    if not owner or owner == '' then return false end
    if not Config.CompanyVehicles or not Config.CompanyVehicles.ownerPrefixes then return false end
    owner = owner:lower()
    for _, prefix in ipairs(Config.CompanyVehicles.ownerPrefixes) do
        if owner:sub(1, #prefix):lower() == prefix:lower() then
            return true
        end
    end
    return false
end

lib.callback.register(Scriptname .. ':server:isCompanyVehicle', function(source, plate)
    if not Config.CompanyVehicles or not Config.CompanyVehicles.ignoreKeys then return false end
    if not plate or plate == '' then return false end
    local row = MySQL.single.await('SELECT owner FROM owned_vehicles WHERE plate = ?', { plate })
    if not row or not row.owner then return false end
    return isCompanyOwner(row.owner)
end)

CreateThread(function()
    if Config.Metadata then
        Framework.RegisterUsableItem(Config.VehicleKeys.itemName, function(source, item)
            if not source then return end
            local playerId = source
            Debug('info', 'Player %s used vehicle key item', playerId)

            local Player = Framework.GetPlayer(playerId)
            if not Player then
                Debug('error', 'Player %s not found in framework', playerId)
                return
            end

            local identifier = Framework.GetPlayerIdentifier(playerId)
            if not identifier then
                Debug('error', 'Could not get identifier for player %s', playerId)
                return
            end

            local metadata = item.info and item.info or item.metadata
            local plate = metadata.plate
            if not plate then
                Debug('error', 'No plate found in item metadata for player %s', playerId)
                return
            end
            Debug('info', 'Processing key for plate: %s', plate)

            if not itemCooldown[playerId] then
                itemCooldown[playerId] = {
                    counts = {},
                    timers = {},
                    blockedUntil = 0
                }
            end

            local data = itemCooldown[playerId]

            if data.blockedUntil > GetGameTimer() then
                Debug('warning', 'Player %s tried to use key while on cooldown', playerId)
                Notify.SendNotify(playerId, _T('error.item_on_cooldown'), 'error', 3000)
                return
            end

            local count = data.counts[plate] or 0
            count = count + 1
            data.counts[plate] = count

            if not data.timers[plate] then
                data.timers[plate] = {}
            end

            SetTimeout(5000, function()
                if data.counts[plate] and data.counts[plate] > 0 then
                    data.counts[plate] = data.counts[plate] - 1
                    if data.counts[plate] < 0 then
                        data.counts[plate] = 0
                    end
                end
            end)

            if count >= 5 then
                Debug('warning', 'Player %s exceeded key usage limit for plate %s', playerId, plate)
                data.counts[plate] = 0
                data.blockedUntil = GetGameTimer() + 5000
                Notify.SendNotify(playerId, _T('error.too_many_uses'), 'error', 5000)
                return
            end

            local uniqueId = Framework.GetPlayerUniqueID(playerId)
            if not uniqueId then
                Debug('error', 'Could not get UniqueID for player %s', playerId)
                return
            end

            if not IsPlayerOwnedVehicle(uniqueId, plate) then
                    Debug('info', 'Using admin key for plate %s', plate)
                    TriggerClientEvent(Scriptname .. ':client:usedVehicleKey', playerId, plate, false)
                return
            end

            Debug('success', 'Player %s successfully used key for owned vehicle %s', playerId, plate)
            TriggerClientEvent(Scriptname .. ':client:usedVehicleKey', playerId, plate, true)
        end)
    end

    local frameworkName = Framework.GetFrameworkName()
    if frameworkName == 'es_extended' then
        Framework.RegisterUsableItem(Config.Lockpick.normal.itemName, function(source, item)
            if not source then return end
            local playerId = source
            Debug('info', 'Player %s used lockpick item', playerId)

            local Player = Framework.GetPlayer(playerId)
            if not Player then
                Debug('error', 'Player %s not found in framework', playerId)
                return
            end

            TriggerClientEvent('lockpicks:UseLockpick', playerId)
        end)

        Framework.RegisterUsableItem(Config.Lockpick.advanced.itemName, function(source, item)
            if not source then return end
            local playerId = source
            Debug('info', 'Player %s used advanced lockpick item', playerId)

            local Player = Framework.GetPlayer(playerId)
            if not Player then
                Debug('error', 'Player %s not found in framework', playerId)
                return
            end

            TriggerClientEvent('lockpicks:UseLockpick', playerId)
        end)
    end
end)

--- @param source number
--- @return table
--- @description Gets the vehicle keys for the player
lib.callback.register(Scriptname .. ':server:getVehicleKeys', function(source)
    while not isReady do Wait(0) end

    if not source then return {} end
    local playerId = source
    Debug('info', 'Getting vehicle keys for player %s', playerId)

    local Player = Framework.GetPlayer(playerId)
    if not Player then
        Debug('error', 'Player %s not found when getting keys', playerId)
        return {}
    end

    local identifier = Framework.GetPlayerIdentifier(playerId)
    if not identifier then
        Debug('error', 'Could not get identifier for player %s when getting keys', playerId)
        return {}
    end

    local keylist = {}

    for plate, identifiers in pairs(VehicleList) do
        if identifiers[identifier] then
            keylist[plate] = true
            Debug('info', 'Player %s has keys for plate %s', playerId, plate)
        end
    end

    Debug('info', 'Player %s has %d vehicle keys', playerId, #keylist)
    return keylist
end)

--- @param source number
--- @param plate string
--- @return boolean
--- @description Checks if the player owns the vehicle
lib.callback.register(Scriptname .. ':server:checkPlayerOwned', function(source, plate)
    if not source then return false end
    local playerId = source
    Debug('info', 'Checking if player %s owns vehicle %s', playerId, plate)

    local Player = Framework.GetPlayer(playerId)
    if not Player then
        Debug('error', 'Player %s not found when checking ownership', playerId)
        return false
    end

    if VehicleList[plate] then
        Debug('success', 'Player %s owns vehicle %s', playerId, plate)
        return true
    end

    Debug('info', 'Player %s does not own vehicle %s', playerId, plate)
    return false
end)

lib.callback.register(Scriptname .. ':server:getVehicles', function(source)
    if not source then return {} end
    local playerId = source
    Debug('info', 'Getting vehicles for player %s', playerId)

    local Player = Framework.GetPlayer(playerId)
    if not Player then 
        Debug('error', 'Player %s not found when getting vehicles', playerId)
        return {} 
    end

    local uniqueId = Framework.GetPlayerUniqueID(playerId)
    if not uniqueId then
        Debug('error', 'Could not get UniqueID for player %s', playerId)
        return {}
    end

    Debug('info', 'Player %s has UniqueID: %s', playerId, uniqueId)

    local query = 'SELECT plate, vehicle, label FROM owned_vehicles WHERE owner = ?'
    local vehicles = MySQL.query.await(query, { uniqueId })
    
    if not vehicles or #vehicles == 0 then
        Debug('warning', 'No vehicles found for UniqueID %s', uniqueId)
        return {}
    end

    local formattedVehicles = {}
    for _, vehicle in ipairs(vehicles) do
        local vehData = json.decode(vehicle.vehicle)
        local modelName = vehicle.label or vehData.model or 'Véhicule'
        
        if type(modelName) == 'number' then
            modelName = GetDisplayNameFromVehicleModel(modelName) or 'Véhicule'
        end
        
        formattedVehicles[#formattedVehicles + 1] = {
            plate = vehicle.plate,
            vehicle = modelName,
            model = modelName
        }
        Debug('info', 'Found vehicle for UniqueID %s: %s [%s]', uniqueId, modelName, vehicle.plate)
    end

    Debug('success', 'Returning %d vehicles for UniqueID %s', #formattedVehicles, uniqueId)
    return formattedVehicles
end)

lib.callback.register(Scriptname .. ':server:isPlayerOwnedVehicle', function(source, plate)
    if not source then return false end
    local playerId = source
    local Player = Framework.GetPlayer(playerId)
    if not Player then return false end

    local uniqueId = Framework.GetPlayerUniqueID(playerId)
    if not uniqueId then return false end

    local query = 'SELECT owner FROM owned_vehicles WHERE plate = ? AND owner = ?'
    local row = MySQL.single.await(query, { plate, uniqueId })
    local isOwned = row and true or false
    
    Debug('info', 'isPlayerOwnedVehicle check for plate %s by UniqueID %s: %s', plate, uniqueId, isOwned)
    return isOwned
end)

lib.callback.register(Scriptname .. ':server:checkVehicleAccess', function(source, plate)
    if not source then return { accessible = false, isOwned = false, isCompany = false } end
    local playerId = source
    
    local Player = Framework.GetPlayer(playerId)
    if not Player then return { accessible = false, isOwned = false, isCompany = false } end

    local uniqueId = Framework.GetPlayerUniqueID(playerId)
    if not uniqueId then return { accessible = false, isOwned = false, isCompany = false } end

    local vehicleQuery = 'SELECT owner FROM owned_vehicles WHERE plate = ?'
    local vehicleRow = MySQL.single.await(vehicleQuery, { plate })
    
    if not vehicleRow then
        Debug('info', 'Vehicle %s not found in database (NPC vehicle)', plate)
        return { accessible = true, isOwned = false, isCompany = false }
    end

    local owner = vehicleRow.owner
    local isCompany = false
    
    if type(owner) == 'string' then
        for _, prefix in ipairs(Config.CompanyVehicles.ownerPrefixes or {}) do
            if string.sub(owner, 1, #prefix) == prefix then
                isCompany = true
                break
            end
        end
    end

    if isCompany then
        Debug('info', 'Vehicle %s is company vehicle (owner: %s)', plate, owner)
        return { accessible = true, isOwned = false, isCompany = true }
    end

    local isOwned = (tonumber(owner) == tonumber(uniqueId))
    local accessible = not isOwned

    Debug('info', 'checkVehicleAccess for %s: owner=%s, uniqueId=%s, owned=%s, accessible=%s', 
          plate, owner, uniqueId, isOwned, accessible)
    return { accessible = accessible, isOwned = isOwned, isCompany = isCompany }
end)

--- @param resource string
--- @return nil
--- @description Called when the resource starts
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        VehicleList = {}

        local players = GetPlayers()

        if #players > 0 then
            for _, playerId in pairs(players) do
                local newId = tonumber(playerId)
                if not newId then return end

                local vehicleList = Framework.GetOwnedVehicles(newId)
                local identifier = Framework.GetPlayerIdentifier(newId)

                if vehicleList then
                    for _, vehicle in pairs(vehicleList) do
                        VehicleList[vehicle.plate] = {
                            [identifier] = true
                        }
                    end
                end
            end

            isReady = true
        end
    end
end)

--- @param source number
--- @return nil
--- @description Called when the player loads
RegisterNetEvent(Scriptname .. ':server:OnPlayerLoaded', function(source)
    local playerId = source

    local Player = Framework.GetPlayer(playerId)
    if not Player then return end

    local identifier = Framework.GetPlayerIdentifier(playerId)
    if not identifier then return end

    local vehicleList = Framework.GetOwnedVehicles(playerId)
    if not vehicleList then return end

    for _, vehicle in pairs(vehicleList) do
        VehicleList[vehicle.plate] = {
            [identifier] = true
        }
    end

    isReady = true
end)

--- @param vehNetId number
--- @param state number
--- @return nil
--- @description Sets the lock state of the vehicle
RegisterNetEvent(Scriptname .. ':server:setVehLockState', function(vehNetId, state)
    SetLockState(NetworkGetEntityFromNetworkId(vehNetId), state)
end)

--- @param itemName string
--- @return nil
--- @description Breaks the lockpick of the vehicle
RegisterNetEvent(Scriptname .. ':server:breakLockpick', function(itemName)
    local playerId = source

    local Player = Framework.GetPlayer(playerId)
    if not Player then return end

    if not (itemName == 'lockpick' or itemName == 'advancedlockpick') then return end
    exports.ox_inventory:RemoveItem(playerId, itemName, 1)
end)

RegisterNetEvent(Scriptname .. ':server:giveVehicleKeys', function(receiver, plate)
    local playerId = source
    Debug('info', 'Player %s giving keys for plate %s to player %s', playerId, plate, receiver)

    local Player = Framework.GetPlayer(playerId)
    if not Player then
        Debug('error', 'Giver player %s not found', playerId)
        return
    end

    local targetId = receiver

    local Target = Framework.GetPlayer(targetId)
    if not Target then
        Debug('error', 'Target player %s not found', targetId)
        return
    end

    local identifier = Framework.GetPlayerIdentifier(playerId)
    if not identifier then
        Debug('error', 'Could not get identifier for giver player %s', playerId)
        return
    end

    local targetIdentifier = Framework.GetPlayerIdentifier(targetId)
    if not targetIdentifier then
        Debug('error', 'Could not get identifier for target player %s', targetId)
        return
    end

    local uniqueId = Framework.GetPlayerUniqueID(playerId)
    if not uniqueId then
        Debug('error', 'Could not get UniqueID for player %s', playerId)
        return
    end

    if not IsPlayerOwnedVehicle(uniqueId, plate) then
        Debug('warning', 'Player %s does not own vehicle %s, cannot give keys', playerId, plate)
        return
    end

    if not VehicleList[plate] then
        VehicleList[plate] = {}
        VehicleList[plate][identifier] = true
        TriggerClientEvent(Scriptname .. ':client:AddKeys', playerId, plate)
        Debug('info', 'Created new vehicle entry for plate %s', plate)
    end

    VehicleList[plate][targetIdentifier] = true
    Debug('success', 'Successfully gave keys for plate %s to player %s', plate, targetId)
    TriggerClientEvent(Scriptname .. ':client:AddKeys', targetId, plate)
end)

--- @param plate string
--- @return nil
--- @description Acquires the keys for the vehicle
RegisterNetEvent(Scriptname .. ':server:AcquireVehicleKeys', function(plate, netId)
    local playerId = source
    GiveKeys(playerId, plate, {
        netId = netId
    })
end)

--- @param plate string
--- @return nil
--- @description Removes the keys for the vehicle
RegisterNetEvent(Scriptname .. ':server:RemoveKeys', function(plate)
    local playerId = source
    RemoveKeys(playerId, plate)
end)

--- @param receiver number
--- @param plate string
--- @return nil
--- @description Gives the keys to the player
RegisterNetEvent(Scriptname .. ':server:GiveVehicleKeys', function(receiver, plate)
    local playerId = source

    if HasKeys(playerId, plate) then
        if type(receiver) == 'table' then
            for _, r in ipairs(receiver) do
                GiveKeys(receiver[r], plate)
            end
        else
            GiveKeys(receiver, plate)
        end
    end
end)

RegisterNetEvent(Scriptname .. ':server:CreateNewKey', function(plate)
    if not Config.Metadata then return end

    local playerId = source
    Debug('info', 'CreateNewKey called by player %s for plate %s', playerId, plate)

    local Player = Framework.GetPlayer(playerId)
    if not Player then 
        Debug('error', 'Player %s not found', playerId)
        return 
    end

    local uniqueId = Framework.GetPlayerUniqueID(playerId)
    if not uniqueId then 
        Debug('error', 'Could not get UniqueID for player %s', playerId)
        Notify.SendNotify(playerId, 'Erreur système.', 'error', 3000)
        return
    end

    Debug('info', 'Player %s (UniqueID: %s) requesting key for plate %s', playerId, uniqueId, plate)

    if not IsPlayerOwnedVehicle(uniqueId, plate) then
        Debug('warning', 'Player %s does not own vehicle %s', playerId, plate)
        Notify.SendNotify(playerId, 'Ce véhicule ne vous appartient pas.', 'error', 3000)
        return
    end

    local locksmithPrices = Config.LocksmithPrices or { firstKey = 0, duplicateKey = 1500 }
    local alreadyHasKey = HasKeys(playerId, plate)
    local keyPrice = alreadyHasKey and locksmithPrices.duplicateKey or locksmithPrices.firstKey

    Debug('info', 'Key price for plate %s: %s$ (already has key: %s)', plate, keyPrice, alreadyHasKey)

    if keyPrice > 0 then
        local balance = Framework.GetAccountBalance(playerId, 'cash')
        Debug('info', 'Player cash balance: %s$', balance)
        
        if balance < keyPrice then
            Debug('warning', 'Player %s has insufficient funds (%s$ < %s$)', playerId, balance, keyPrice)
            Notify.SendNotify(playerId, string.format('Vous n\'avez pas assez d\'argent liquide. Il vous manque %s$.', keyPrice - balance), 'error', 3500)
            return
        end

        local removed = Framework.RemoveAccountBalance(playerId, 'cash', keyPrice)
        if not removed then
            Debug('error', 'Failed to remove %s$ from player %s', keyPrice, playerId)
            Notify.SendNotify(playerId, 'Erreur lors du paiement.', 'error', 3000)
            return
        end
        
        Debug('success', 'Removed %s$ from player %s', keyPrice, playerId)
    end

    exports.ox_inventory:AddItem(playerId, Config.VehicleKeys.itemName, 1, false, {
        plate = plate,
    })

    local message = alreadyHasKey and 
        string.format('Vous avez acheté un double de clé pour %s$ [%s]', keyPrice, plate) or
        string.format('Première clé pour [%s] offerte.', plate)
    
    Debug('success', 'Key created for player %s, plate %s', playerId, plate)
    Notify.SendNotify(playerId, message, 'success', 3500)
end)

RegisterNetEvent(Scriptname .. ':server:CreateNewLock', function(plate)
    if not Config.Metadata then return end

    local playerId = source

    local Player = Framework.GetPlayer(playerId)
    if not Player then return end

    local uniqueId = Framework.GetPlayerUniqueID(playerId)
    if not uniqueId then return end

    if not IsPlayerOwnedVehicle(uniqueId, plate) then
        Notify.SendNotify(playerId, 'Ce véhicule ne vous appartient pas.', 'error', 3000)
        return
    end

    if Framework.GetAccountBalance(playerId, 'cash') < Config.NewLockPrice then
        Notify.SendNotify(playerId, 'Vous n\'avez pas assez d\'argent pour changer la serrure.', 'error', 3000)
        return
    end

    if not Framework.RemoveAccountBalance(playerId, 'cash', Config.NewLockPrice) then
        Notify.SendNotify(playerId, 'Vous n\'avez pas assez d\'argent pour changer la serrure.', 'error', 3000)
        return
    end

    exports.ox_inventory:AddItem(playerId, Config.VehicleKeys.itemName, 1, false, {
        plate = plate,
    })

    Notify.SendNotify(playerId, string.format('Serrure remplacée pour [%s] (%s$).', plate, Config.NewLockPrice), 'success', 4000)
end)

-- Removed: legacy lockpick/hotwire and admin key commands (system simplified)
