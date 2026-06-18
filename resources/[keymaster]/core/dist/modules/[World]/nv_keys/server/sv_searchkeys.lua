local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

lib.callback.register(Scriptname .. ':server:findKeys', function(source, vehNetId)
    local vehicle = NetworkGetEntityFromNetworkId(vehNetId)
    if math.random() <= Config.Hotwire.chance then
        GiveKeys(source, GetVehicleNumberPlateText(vehicle), {
            netId = vehNetId
        })
        return true
    end

    return false
end)