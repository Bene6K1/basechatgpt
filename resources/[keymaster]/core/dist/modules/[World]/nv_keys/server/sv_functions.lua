function SetLockState(veh, state)
    if type(state) ~= 'string' or not DoesEntityExist(veh) then
        Debug('error', 'Invalid parameters for SetLockState: state=%s, vehicle exists=%s', tostring(state), DoesEntityExist(veh))
        return
    end
    local plate = GetVehicleNumberPlateText(veh)
    local lockValue = state == 'lock' and 2 or 1
    Debug('info', 'Setting lock state for vehicle %s to %s (value: %d)', plate, state, lockValue)
    Entity(veh).state:set('doorslockstate', lockValue, true)
end

exports('SetLockState', SetLockState)

function GetVehicleSSN(uniqueId, plate, uniqueIdCheck)
    local query
    Debug('info', 'Getting SSN for plate %s (uniqueId: %s, uniqueIdCheck: %s)', plate, uniqueId, uniqueIdCheck)

    if uniqueIdCheck then
            query = "SELECT key_id FROM owned_vehicles WHERE plate = ? AND owner = ?"
        else
            query = "SELECT key_id FROM owned_vehicles WHERE plate = ?"
    end

    local row

    if uniqueIdCheck then
        row = MySQL.single.await(query, { plate, uniqueId })
    else
        row = MySQL.single.await(query, { plate })
    end

    local ssn = row and tonumber(row.key_id) or 0
    Debug('info', 'Retrieved SSN %s for plate %s', ssn, plate)
    return ssn
end

function CreateNewSSN(uniqueId, plate)
    local query = "UPDATE owned_vehicles SET key_id = COALESCE(key_id, 0) + 1 WHERE plate = ? AND owner = ?"
    local affectedRows = MySQL.update.await(query, { plate, uniqueId })
    Debug('info', 'Updated SSN for plate %s (uniqueId: %s), affected rows: %s', plate, uniqueId, affectedRows)
    return affectedRows
end

function IsPlayerOwnedVehicle(uniqueId, plate)
    local query = "SELECT owner FROM owned_vehicles WHERE plate = ? AND owner = ?"
    local row = MySQL.single.await(query, { plate, uniqueId })
    local isOwned = row and true or false
    Debug('info', 'IsPlayerOwnedVehicle check: plate=%s, uniqueId=%s, owned=%s', plate, uniqueId, isOwned)
    return isOwned
end