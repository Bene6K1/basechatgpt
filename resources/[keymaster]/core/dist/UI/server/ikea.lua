WorldProps.data = {
    propsSpawned = {

    }
}

local MAX_PROPS_PER_PLAYER = 5

ESX.RegisterServerCallback('sunny:props:checkLimit', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then 
        cb(false)
        return 
    end

    if xPlayer.getGroup() == 'fondateur' then
        cb(true)
        return
    end

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM world_props WHERE JSON_EXTRACT(owner, "$.UniqueID") = @UniqueID', {
        ['@UniqueID'] = xPlayer.UniqueID
    }, function(result)
        cb(result[1].count < MAX_PROPS_PER_PLAYER)
    end)
end)

RegisterNetEvent('sunny:props:place', function(name, label, id, coords, heading)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    MySQL.Async.execute('DELETE FROM players_props WHERE id = @id AND UniqueID = @UniqueID', {
        ['@id'] = id,
        ['@UniqueID'] = xPlayer.UniqueID,
    }, function()
        MySQL.Async.execute('INSERT INTO world_props (name, label, owner, position, heading, iid) VALUES (@name, @label, @owner, @position, @heading, @iid)', {
            ['@name'] = name,
            ['@label'] = label,
            ['@owner'] = json.encode({UniqueID = xPlayer.UniqueID, Name = xPlayer.name, day = os.date("*t").day, hours = os.date("*t").hour, min = os.date("*t").min, month = os.date("*t").month, years = os.date("*t").year, firstName = xPlayer.firstname, lastName = xPlayer.lastname}),
            ['@position'] = json.encode(coords),
            ['@heading'] = json.encode(heading),
            ['@iid'] = id
        }, function()
            MySQL.Async.fetchAll('SELECT * FROM world_props WHERE iid = @iid', {
                ['@iid'] = id
            }, function(result)
                for k,v in pairs(result) do
                    WorldProps.data.propsSpawned[v.id] ={
                        propsName = v.name,
                        propsId = v.id,
                        position = json.decode(v.position),
                        heading = json.decode(v.heading),
                        owner = json.decode(v.owner),
                        label = v.label
                    }
                    TriggerClientEvent('sunny:props:addTable', -1, v.id,  WorldProps.data.propsSpawned[v.id])
                end
            end)
        end)
    end)
end)

RegisterNetEvent('sunny:props:server:loadProps', function()
    local source = source

    MySQL.Async.fetchAll('SELECT * FROM world_props', {}, function(result)
        for k,v in pairs(result) do
            WorldProps.data.propsSpawned[v.id] ={
                propsName = v.name,
                propsId = v.id,
                position = json.decode(v.position),
                heading = json.decode(v.heading),
                owner = json.decode(v.owner),
                label = v.label
            }
            TriggerClientEvent('sunny:props:addTable', source, v.id,  WorldProps.data.propsSpawned[v.id])
        end
    end)
end)

RegisterNetEvent('sunny:props:server:delete', function(data)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if data.owner.UniqueID ~= xPlayer.UniqueID and not (IsPlayerAceAllowed(source, "command.staffmode") and adminManagement.object) then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas la permission de récupérer cet objet')
        return
    end

    MySQL.Async.execute('DELETE FROM world_props WHERE id = @id', {
        ['@id'] = data.propsId
    }, function(rowsChanged)
        if rowsChanged > 0 then
            MySQL.Async.fetchAll('SELECT * FROM players_props WHERE name = @name AND UniqueID = @UniqueID', {
                ['@name'] = data.propsName,
                ['@UniqueID'] = xPlayer.UniqueID
            }, function(result)
                if result[1] then
                    local existingData = json.decode(result[1].data)
                    existingData.count = (existingData.count or 1) + 1
                    
                    MySQL.Async.execute('UPDATE players_props SET data = @data WHERE id = @id', {
                        ['@data'] = json.encode(existingData),
                        ['@id'] = result[1].id
                    }, function()
                        TriggerClientEvent('esx:showNotification', source, 'Vous avez récupéré votre objet')
                        TriggerClientEvent('sunny:props:removeTable', -1, data.propsId)
                        WorldProps.data.propsSpawned[data.propsId] = nil
                        TriggerClientEvent('sunny:refreshInventory', source)
                    end)
                else
                    MySQL.Async.execute('INSERT INTO players_props (UniqueID, data, name) VALUES (@UniqueID, @data, @name)', {
                        ['@UniqueID'] = xPlayer.UniqueID,
                        ['@data'] = json.encode({
                            label = data.label, 
                            name = data.propsName, 
                            owner = xPlayer.UniqueID, 
                            count = 1
                        }),
                        ['@name'] = data.propsName
                    }, function()
                        TriggerClientEvent('esx:showNotification', source, 'Vous avez récupéré votre objet')
                        TriggerClientEvent('sunny:props:removeTable', -1, data.propsId)
                        WorldProps.data.propsSpawned[data.propsId] = nil
                        TriggerClientEvent('sunny:refreshInventory', source)
                    end)
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Une erreur est survenue lors de la récupération de l\'objet')
        end
    end)
end)