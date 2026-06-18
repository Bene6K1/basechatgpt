local Config <const> = require 'dist.modules.[World].nv_keys.config.main'


lib.callback.register(Scriptname .. ':server:carjack', function(source, netId, weaponTypeGroup)
    local chance = Config.Carjack.chance[weaponTypeGroup]
    local success = math.random() <= chance
    local plate = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(netId))

    Debug('info', 'Player %s attempting carjack with weapon group %s (chance: %.2f)', source, weaponTypeGroup, chance)
    Debug('info', 'Carjack result: %s for vehicle %s', success and 'SUCCESS' or 'FAILED', plate)

    if success then
        local vehicle = NetworkGetEntityFromNetworkId(netId)
            Debug('success', 'Giving keys to player %s for carjacked vehicle %s', source, plate)
        GiveKeys(source, GetVehicleNumberPlateText(vehicle), {
            netId = netId
            })
        SetVehicleDoorsLocked(vehicle, 0)
        Debug('success', 'Unlocked vehicle %s after successful carjack', plate)
        return true
    else
        Debug('warning', 'Carjack failed for player %s on vehicle %s', source, plate)
    end
end)