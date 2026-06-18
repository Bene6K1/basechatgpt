local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

--- AreKeysJobShared(currentVehicle)
--- @param currentVehicle number
--- @return boolean
--- @description Checks if the vehicle has keys that are shared with the player's job
function AreKeysJobShared(currentVehicle)
    if not currentVehicle or Config.SharedKeys.status == false then return false end
    local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle))
    local vehPlate = GetVehicleNumberPlateText(currentVehicle)
    local jobData = Framework.GetPlayerJobData()
    for job, v in pairs(Config.SharedKeys.jobs) do
        if job == jobData.jobName then
            if Config.SharedKeys.jobs[job].requireOnduty and not jobData.onDuty then return false end
            for _, vehicle in pairs(v.vehicles) do
                if string.upper(vehicle) == string.upper(vehName) then
                    if not HasKeys(vehPlate) then
                        TriggerServerEvent(Scriptname .. ':server:AcquireVehicleKeys', vehPlate)
                    end
                    return true
                end
            end
        end
    end
    return false
end

--- GiveKeys(id, plate)
--- @param plate string
--- @return nil
--- @description Gives the keys to the player
function GiveKeys(plate)
    TriggerServerEvent(Scriptname .. ':server:AcquireVehicleKeys', plate)
end

exports('GiveKeys', GiveKeys)

--- RemoveKeys(plate)
--- @param plate string
--- @return nil
--- @description Removes the keys from the player
function RemoveKeys(plate)
    TriggerServerEvent(Scriptname .. ':server:RemoveKeys', plate)
end

exports('RemoveKeys', RemoveKeys)

--- GetKeys()
--- @return nil
--- @description Gets the keys list from the server
function GetKeys()
    lib.callback(Scriptname .. ':server:getVehicleKeys', false, function(keysList)
        KeysList = keysList
    end)
end

exports('GetKeys', GetKeys)

--- HasKeys(plate)
--- @param plate string
--- @return boolean
--- @description Checks if the player has keys for the specified plate
function HasKeys(plate)
    if Config.Metadata then
        return lib.callback.await(Scriptname .. ':server:hasKey', false, plate)
    else
        return KeysList[plate]
    end
end

exports('HasKeys', HasKeys)
