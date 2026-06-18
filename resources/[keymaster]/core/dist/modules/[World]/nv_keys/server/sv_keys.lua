local Config <const> = require 'dist.modules.[World].nv_keys.config.main'
Inventory = Inventory or {}

---comment
---@param src number
---@param item string
---@param metadata table|boolean
---@return boolean
Inventory.HasItem = function(src, item, metadata)
    if type(metadata) == 'table' then
        local items = exports.ox_inventory:Search(src, 'count', item, metadata)
        if type(items) == 'number' then
        return items > 0
        elseif type(items) == 'boolean' then
            return items
        elseif type(items) == 'table' and items.count then
            return items.count > 0
        end
        return false
    else
        local count = exports.ox_inventory:GetItem(src, item, nil, true)
        if type(count) == 'number' then
        return count > 0
        elseif type(count) == 'table' and count.count then
            return count.count > 0
        elseif type(count) == 'boolean' then
            return count
        end
        return false
    end
end

TemporaryKeys = TemporaryKeys or {}
TemporaryPlateToPlayers = TemporaryPlateToPlayers or {}
TemporaryNetToPlate = TemporaryNetToPlate or {}
TemporaryPlateToNetId = TemporaryPlateToNetId or {}


local function addTemporaryKey(playerId, plate, netId)
    TemporaryKeys[playerId] = TemporaryKeys[playerId] or {}
    TemporaryKeys[playerId][plate] = true

    TemporaryPlateToPlayers[plate] = TemporaryPlateToPlayers[plate] or {}
    TemporaryPlateToPlayers[plate][playerId] = true

    if netId and netId ~= 0 then
        TemporaryNetToPlate[netId] = plate
        TemporaryPlateToNetId[plate] = netId
    end
end

local function clearTemporaryKey(playerId, plate)
    if TemporaryKeys[playerId] then
        TemporaryKeys[playerId][plate] = nil
        if not next(TemporaryKeys[playerId]) then
            TemporaryKeys[playerId] = nil
        end
    end

    if TemporaryPlateToPlayers[plate] then
        TemporaryPlateToPlayers[plate][playerId] = nil
        if not next(TemporaryPlateToPlayers[plate]) then
            TemporaryPlateToPlayers[plate] = nil
            local netId = TemporaryPlateToNetId[plate]
            if netId then
                TemporaryNetToPlate[netId] = nil
            end
            TemporaryPlateToNetId[plate] = nil
        end
    end
end

local function removeTemporaryKeysForPlate(plate)
    local players = TemporaryPlateToPlayers[plate]
    if not players then return end

    for playerId in pairs(players) do
        local metadata = {
            plate = plate,
        }
        if Inventory.HasItem(playerId, Config.VehicleKeys.itemName, metadata) then
            exports.ox_inventory:RemoveItem(playerId, Config.VehicleKeys.itemName, 1, false, metadata)
        end
        clearTemporaryKey(playerId, plate)
        TriggerClientEvent(Scriptname .. ':client:RemoveKeys', playerId, plate)
    end
    TemporaryPlateToPlayers[plate] = nil
    local netId = TemporaryPlateToNetId[plate]
    if netId then
        TemporaryNetToPlate[netId] = nil
    end
    TemporaryPlateToNetId[plate] = nil
end

local function removeTemporaryItemsFromPlayer(playerId)
    if not Config.Metadata then return end
    local inventory = exports.ox_inventory:GetInventoryItems(playerId)
    if not inventory then return end
    for _, item in ipairs(inventory) do
        if item and item.name == Config.VehicleKeys.itemName then
            local metadata = item.metadata or item.info
            exports.ox_inventory:RemoveItem(playerId, Config.VehicleKeys.itemName, item.count or 1, item.slot, metadata)
            TriggerClientEvent(Scriptname .. ':client:RemoveKeys', playerId, metadata.plate)
            clearTemporaryKey(playerId, metadata.plate or '')
        end
    end
end

AddEventHandler('entityRemoved', function(entity)
    if not entity or GetEntityType(entity) ~= 2 then
        return
    end

    local netId = NetworkGetNetworkIdFromEntity(entity)
    if not netId or netId == 0 then
        return
    end

    local plate = TemporaryNetToPlate[netId]
    if not plate then return end

    TemporaryNetToPlate[netId] = nil
    removeTemporaryKeysForPlate(plate)
end)

AddEventHandler('playerDropped', function()
    removeTemporaryItemsFromPlayer(source)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if not Framework.GetPlayers then return end
    for _, playerId in ipairs(Framework.GetPlayers()) do
        removeTemporaryItemsFromPlayer(playerId)
    end
end)

function Trim(value)
    return string.gsub(value, '^%s*(.-)%s*$', '%1')
end

function GiveKeys(playerId, plate, opts)
    local Player = Framework.GetPlayer(playerId)
    if not Player then return false end

    local identifier = Framework.GetPlayerIdentifier(playerId)
    if not identifier then return false end
    local uniqueId = Framework.GetPlayerUniqueID(playerId)

    if not plate then
        if GetVehiclePedIsIn(GetPlayerPed(playerId), false) ~= 0 then
            plate = Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(playerId), false)))
        else
            return
        end
    end

    if not Config.Metadata then
        if not VehicleList[plate] then VehicleList[plate] = {} end
        VehicleList[plate][identifier] = true

        TriggerClientEvent(Scriptname .. ':client:AddKeys', playerId, plate)
    else
        local metadata = {
            plate = plate,
        }

        if not Inventory.HasItem(playerId, Config.VehicleKeys.itemName, metadata) then
            exports.ox_inventory:AddItem(playerId, Config.VehicleKeys.itemName, 1, false, metadata)
            addTemporaryKey(playerId, plate, opts and opts.netId or nil)
        end
    end

    if Framework.GetFrameworkName() == 'es_extended' then return end

    local oldKeys = Framework.GetPlayerMetadata(playerId, "vehicleKeys") or {}
    oldKeys[plate] = true
    Framework.SetPlayerMetadata(playerId, "vehicleKeys", oldKeys)
end

exports('GiveKeys', GiveKeys)

function RemoveKeys(playerId, plate)
    local Player = Framework.GetPlayer(playerId)
    if not Player then return false end

    local identifier = Framework.GetPlayerIdentifier(playerId)
    if not identifier then return false end

    if not Config.Metadata then
        if VehicleList[plate] and VehicleList[plate][identifier] then
            VehicleList[plate][identifier] = nil
        end

        TriggerClientEvent(Scriptname .. ':client:RemoveKeys', playerId, plate)
    else
        local metadata = {
                plate = plate,
        }
        if Inventory.HasItem(playerId, Config.VehicleKeys.itemName, metadata) then
            exports.ox_inventory:RemoveItem(playerId, Config.VehicleKeys.itemName, 1, false, metadata)
        end
        clearTemporaryKey(playerId, plate)
    end
end

exports('RemoveKeys', RemoveKeys)

function HasKeys(playerId, plate)
    local Player = Framework.GetPlayer(playerId)
    if not Player then return false end

    local identifier = Framework.GetPlayerIdentifier(playerId)
    if not identifier then return false end

    if Config.Metadata then

        return Inventory.HasItem(playerId, Config.VehicleKeys.itemName, {
            plate = plate,
        })
    else
        if VehicleList[plate] and VehicleList[plate][identifier] then
            return true
        end
    end

    return false
end

exports('HasKeys', HasKeys)

lib.callback.register(Scriptname .. ':server:hasKey', function(source, plate)
    return HasKeys(source, plate)
end)
