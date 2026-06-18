local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

lib.callback.register(Scriptname .. ':server:getVehicleKey', function(source, plate)
    if not source or not plate then return false end
    local playerId = source
    local vehPlate = plate

    local Player = Framework.GetPlayer(playerId)
    if not Player then return false end

    return HasKeys(playerId, plate)
end)

--- @param plate string
--- @return nil
--- @description Sets the keys for the vehicle
RegisterNetEvent(Scriptname .. ':server:SetVehicleKeys', function(plate)
    if not Config.Metadata then return end

    local playerId = source

    local Player = Framework.GetPlayer(playerId)
    if not Player then return end

    local identifier = Framework.GetPlayerIdentifier(playerId)
    if not identifier then return end

    GiveKeys(playerId, plate)
end)
