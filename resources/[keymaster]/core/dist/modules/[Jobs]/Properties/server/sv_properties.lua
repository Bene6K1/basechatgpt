Properties = Properties or {}
Properties.PropertiesList = Properties.PropertiesList or {}
Properties.Loaded = Properties.Loaded or false
Properties.garage = Properties.garage or { count2 = {} }

local function safeJsonDecode(jsonString, default)
    if jsonString == nil or jsonString == '' or jsonString == 'none' then
        return default
    end
    local success, result = pcall(json.decode, jsonString)
    if success then
        return result
    else
        print(("[PropertiesServer] WARNING: Failed to decode JSON string: %s. Error: %s"):format(jsonString, tostring(result)))
        return default
    end
end

function Properties:Load()
    MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(p)
        local tempPropertiesList = {}
        local pcount = 0

        for k,v in pairs(p) do
            local propertyData = {
                id = v.propertiesID,
                owner = v.propertiesOWNER,
                ownerName = v.ownerName,
                name = v.name,
                label = v.label,
                price = v.price,
                enter = safeJsonDecode(v.enter, {x=0.0,y=0.0,z=0.0}),
                exit = safeJsonDecode(v.exit, {x=0.0,y=0.0,z=0.0}),
                street_name = v.street,
                trunkPos = safeJsonDecode(v.trunkPos, {x=0.0,y=0.0,z=0.0}),
                garage = v.garage,
                garagePos = safeJsonDecode(v.garagePos, {x=0.0,y=0.0,z=0.0}),
                garageSpawn = safeJsonDecode(v.garageSpawn, {x=0.0,y=0.0,z=0.0}),
                garageRotation = v.garageRotation,
                garageType = v.garageType,
                players = safeJsonDecode(v.players, {}),
                type = v.type,
                logementType = v.logementType,
                open = false,
                playersIG = {},
                coffreOpen = false,
                interphone = {},
                entrepot = v.entrepot,
                pound = v.pound,
                time = v.time
            }

            local trunkData = safeJsonDecode(v.trunk, nil)
            if trunkData == nil or type(trunkData) ~= 'table' then
                propertyData.trunk = {
                    ['items'] = {},
                    ['weapons'] = {},
                    ['accounts'] = { cash = 0, black_money = 0 },
                    ['code'] = { active = false, blocked = false, code = nil }
                }
            else
                trunkData.items = trunkData.items or {}
                trunkData.weapons = trunkData.weapons or {}
                trunkData.accounts = trunkData.accounts or { cash = 0, black_money = 0 }
                if type(trunkData.accounts.cash) ~= 'number' then trunkData.accounts.cash = 0 end
                if type(trunkData.accounts.black_money) ~= 'number' then trunkData.accounts.black_money = 0 end
                trunkData.code = trunkData.code or { active = false, blocked = false, code = nil }
                if type(trunkData.code.active) == 'nil' then trunkData.code.active = false end
                if type(trunkData.code.blocked) == 'nil' then trunkData.code.blocked = false end
                propertyData.trunk = trunkData
            end
            
            tempPropertiesList[v.propertiesID] = propertyData
            pcount = pcount + 1
        end
        
        Properties.PropertiesList = tempPropertiesList
        Properties.Loaded = true
        -- print(("[PropertiesServer] Properties loaded successfully. Count: %s"):format(pcount))
        
        TriggerClientEvent('sunny:properties:load', -1, Properties.PropertiesList)
    end)
end

function Properties:addPlayer(i,p)
    SetPlayerRoutingBucket(i,p)
end

function Properties:updatePlayers(u,p,v)
    Properties.PropertiesList[p].players[tostring(u)] = v

    local player = ReturnPlayerId(p)

    if player then
        TriggerClientEvent('sunny:properties:updatePlayers', -1, p, Properties.PropertiesList[p].players)
    end
end

function Properties:DbPlayerSync(p)
    MySQL.Async.execute('UPDATE properties SET players = @players WHERE propertiesID = @propertiesID', {
        ['@propertiesID'] = p,
        ['@players'] = json.encode(Properties.PropertiesList[p].players)
    })
end

CreateThread(function()
    Wait(2000)
    Properties:Load()
end)

RegisterNetEvent('sunny:properties:load', function()
    local source = source
    if Properties.Loaded then
        TriggerClientEvent('sunny:properties:load', source, Properties.PropertiesList)
    else
        -- print(("[PropertiesServer] WARNING: Player %s requested properties before initial load was complete. Sending current (possibly empty) list."):format(source))
        TriggerClientEvent('sunny:properties:load', source, Properties.PropertiesList) 
    end
end)

RegisterServerEvent('Achat:Maison')
AddEventHandler('Achat:Maison', function(Infos)
    local _src = source 
    local xPlayer = ESX.GetPlayerFromId(_src)

    if not xPlayer then 
        print(("[PropertiesServer] ERROR: xPlayer not found for source %s in Achat:Maison"):format(_src))
        return 
    end

    if not Infos or not Infos.id or not Infos.price then
        TriggerClientEvent('esx:showNotification', _src, '~r~Erreur: Informations de propriété invalides.')
        print(("[PropertiesServer] ERROR: Invalid Infos for Achat:Maison. Data: %s"):format(json.encode(Infos)))
        return
    end
    
    local IdMaison = Infos.id    
    local PrixMaison = tonumber(Infos.price)

    if not PrixMaison or PrixMaison <= 0 then
        TriggerClientEvent('esx:showNotification', _src, '~r~Erreur: Prix de la maison invalide.')
        return
    end

    local cashCount = exports.ox_inventory:GetItemCount(_src, 'cash')
    if cashCount >= PrixMaison then
        exports.ox_inventory:RemoveItem(_src, 'cash', PrixMaison)
        MySQL.Async.execute('UPDATE properties SET propertiesOWNER = @propertiesOwner, ownerName = @ownerName WHERE propertiesID = @propertiesID', {
            ['@propertiesOwner'] = xPlayer.UniqueID,
            ['@ownerName'] = xPlayer.getName(),
            ['@propertiesID'] = IdMaison
        }, function(affectedRows)
            if affectedRows > 0 then
                TriggerClientEvent('esx:showNotification', _src, 'Vous avez acheté la maison avec succès !')
        
                if Properties.PropertiesList[IdMaison] then
                    Properties.PropertiesList[IdMaison].owner = xPlayer.UniqueID
                    Properties.PropertiesList[IdMaison].ownerName = xPlayer.getName()
                    Properties.PropertiesList[IdMaison].players = {}
                    Properties.PropertiesList[IdMaison].open = false
                    Properties.PropertiesList[IdMaison].coffreOpen = false

                    TriggerClientEvent('sunny:properties:updateProperties', -1, IdMaison, Properties.PropertiesList[IdMaison])
                    Properties:DbPlayerSync(IdMaison)
                else
                    Properties:Load() 
                end
            else
                TriggerClientEvent('esx:showNotification', _src, '~r~Une erreur est survenue lors de l\'achat de la maison (DB).')
                exports.ox_inventory:AddItem(_src, 'cash', PrixMaison)
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', _src, 'Vous n\'avez pas assez d\'argent pour acheter cette maison.')
    end
end)

RegisterNetEvent('sunny:properties:createProperties', function(name, label, price, enter, exit, garage, posGarage, posGarageSpawn, rotGarageSpawn, garageType, typeData, trunkPos, logementType, current_zone, entrepot, pound)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer or not xPlayer.job or not xPlayer.job.name then
        print("[PropertiesServer] ERROR: xPlayer or job not found for createProperties.")
        return
    end

    local society = Society:getSociety(xPlayer.job.name)
    if not society then 
        TriggerClientEvent('esx:showNotification', source, "~r~Erreur: Société non trouvée.")
        return 
    end

    local garageVal = (garage == true or garage == 1) and 1 or 0
    local posGarageVal = garageVal == 1 and json.encode(posGarage) or '[]'
    local posGarageSpawnVal = garageVal == 1 and json.encode(posGarageSpawn) or '[]'
    local rotGarageSpawnVal = garageVal == 1 and rotGarageSpawn or 0.0
    local garageTypeVal = garageVal == 1 and garageType or 'none'

    local entrepotVal = (entrepot == true or entrepot == 1) and 1 or 0
    local poundVal = entrepotVal == 1 and tonumber(pound) or 0

    local propertyPrice = tonumber(price)
    if not propertyPrice or propertyPrice <= 0 then
        TriggerClientEvent('esx:showNotification', source, "~r~Erreur: Prix invalide pour la propriété.")
        return
    end
    
    enter = enter and json.encode(enter) or '{"x":0.0,"y":0.0,"z":0.0}'
    exit = exit and json.encode(exit) or '{"x":0.0,"y":0.0,"z":0.0}'
    trunkPos = trunkPos and json.encode(trunkPos) or '{"x":0.0,"y":0.0,"z":0.0}'


    MySQL.Async.execute('INSERT INTO properties (propertiesOWNER, ownerName, name, label, price, enter, `exit`, garage, garagePos, garageSpawn, garageRotation, garageType, players, type, `trunkPos`, logementType, street, entrepot, pound, trunk) VALUES (@propertiesOWNER, @ownerName, @name, @label, @price, @enter, @exit, @garage, @garagePos, @garageSpawn, @garageRotation, @garageType, @players, @type, @trunkPos, @logementType, @street, @entrepot, @pound, @trunk)', {
        ['@propertiesOWNER'] = 'none', 
        ['@ownerName'] = 'none',
        ['@name'] = name, 
        ['@label'] = label, 
        ['@price'] = propertyPrice, 
        ['@enter'] = enter, 
        ['@exit'] = exit, 
        ['@garage'] = garageVal, 
        ['@garagePos'] = posGarageVal, 
        ['@garageSpawn'] = posGarageSpawnVal, 
        ['@garageRotation'] = rotGarageSpawnVal, 
        ['@garageType'] = garageTypeVal,
        ['@players'] = '{}',
        ['@type'] = typeData,
        ['@trunkPos'] = trunkPos,
        ['@logementType'] = logementType,
        ['@street'] = current_zone or 'N/A',
        ['@entrepot'] = entrepotVal,
        ['@pound'] = poundVal,
        ['@trunk'] = json.encode({
            items = {}, weapons = {}, accounts = {cash = 0, black_money = 0},
            code = {active = false, blocked = false, code = nil}
        })
    }, function(affectedRows)
        if affectedRows > 0 then
            local costToSociety = propertyPrice / 100 * 75
            society.removeSocietyMoney(costToSociety)

            MySQL.Async.fetchAll('SELECT * FROM properties WHERE name = @name AND label = @label ORDER BY propertiesID DESC LIMIT 1', {
                ['@name'] = name,
                ['@label'] = label
            }, function(result)
                if result and result[1] then
                    local newProp = result[1]
                    local newPropData = {
                        id = newProp.propertiesID,
                        owner = 'none',
                        ownerName = 'none',
                        name = newProp.name,
                        label = newProp.label,
                        price = newProp.price,
                        enter = safeJsonDecode(newProp.enter, {x=0.0,y=0.0,z=0.0}),
                        exit = safeJsonDecode(newProp.exit, {x=0.0,y=0.0,z=0.0}),
                        street_name = newProp.street,
                        trunkPos = safeJsonDecode(newProp.trunkPos, {x=0.0,y=0.0,z=0.0}),
                        garage = newProp.garage,
                        garagePos = safeJsonDecode(newProp.garagePos, {x=0.0,y=0.0,z=0.0}),
                        garageSpawn = safeJsonDecode(newProp.garageSpawn, {x=0.0,y=0.0,z=0.0}),
                        garageRotation = newProp.garageRotation,
                        garageType = newProp.garageType,
                        players = safeJsonDecode(newProp.players, {}),
                        type = newProp.type,
                        logementType = newProp.logementType,
                        trunk = safeJsonDecode(newProp.trunk, {items = {}, weapons = {}, accounts = {cash = 0, black_money = 0}, code = {active = false, blocked = false, code = nil}}),
                        entrepot = newProp.entrepot,
                        pound = newProp.pound,
                        open = false, playersIG = {}, coffreOpen = false, interphone = {}
                    }
                    Properties.PropertiesList[newProp.propertiesID] = newPropData
                    TriggerClientEvent('esx:showNotification', source, ('La propriétée %s a été créée avec succès'):format(name))
                    TriggerClientEvent('sunny:properties:add', -1, newProp.propertiesID, newPropData)
                else
                    TriggerClientEvent('esx:showNotification', source, "~r~Erreur lors de la récupération de la propriété créée.")
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Erreur lors de la création de la propriété en base de données.")
        end
    end)
end)

RegisterNetEvent('sunny:properties:addPlayer', function(target, value, pId, playersClientState)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not Properties.PropertiesList[pId] then 
        TriggerClientEvent('esx:showNotification', source, "~r~Cette propriété n'existe plus.")
        return 
    end

    if value == 'me' then
        Properties:addPlayer(source, pId)
        
        local exitCoords = Properties.PropertiesList[pId].exit
        local useDefaultCoords = false
        
        if not exitCoords or not exitCoords.x or not exitCoords.y or not exitCoords.z or
           (exitCoords.x == 0 and exitCoords.y == 0 and exitCoords.z == 0) or
           exitCoords.z < -150 then
            useDefaultCoords = true
            print("[PropertiesServer] WARNING: Invalid exit coordinates for property " .. pId .. ", using default coords.")
        end
        
        if useDefaultCoords then
            local logementType = Properties.PropertiesList[pId].logementType
            local defaultCoords = {x = 0, y = 0, z = 0}
            
            local interiorCoords = {
                ["Motel"] = {x = 151.45, y = -1007.57, z = -98.9999},
                ["Petit appartement"] = {x = 265.307, y = -1002.802, z = -101.008},
                ["Moyen appartement"] = {x = -612.16, y = 59.06, z = 97.2},
                ["Appartement Moderne"] = {x = -785.13, y = 315.79, z = 187.91},
                ["Appartement Moyen"] = {x = -1459.17, y = -520.58, z = 54.929},
                ["Appartement de luxe"] = {x = -680.6088, y = 590.5321, z = 145.39},
                ["Entrepot (grand)"] = {x = 1026.5056, y = -3099.8320, z = -38.9998},
                ["Entrepot (moyen)"] = {x = 1048.5067, y = -3097.0817, z = -38.9999},
                ["Entrepot (petit)"] = {x = 1088.1834, y = -3099.3547, z = -38.9999}
            }
            
            if logementType and interiorCoords[logementType] then
                defaultCoords = interiorCoords[logementType]
            else
                defaultCoords = interiorCoords["Motel"]
            end
            
            Properties.PropertiesList[pId].exit = defaultCoords
            
            -- Mise à jour dans la base de données avec les coordonnées corrigées
            MySQL.Async.execute('UPDATE properties SET `exit` = @exit WHERE propertiesID = @propertiesID', {
                ['@propertiesID'] = pId,
                ['@exit'] = json.encode(defaultCoords)
            }, function()
                print("[PropertiesServer] Exit coordinates corrected and saved to database for property " .. pId)
            end)
            
            exitCoords = defaultCoords
        end
        
        TriggerClientEvent('sunny:properties:teleport', source, exitCoords)

        Properties.PropertiesList[pId].players[tostring(xPlayer.UniqueID)] = true
        
        Properties.PropertiesList[pId].playersIG = Properties.PropertiesList[pId].playersIG or {}
        Properties.PropertiesList[pId].playersIG[source] = { source = source, UniqueID = xPlayer.UniqueID }

        TriggerClientEvent('sunny:properties:changePlayerSate', source, pId, true)
    end
    
    Properties:DbPlayerSync(pId)
    TriggerClientEvent('sunny:properties:updatePlayers', -1, pId, Properties.PropertiesList[pId].players)
end)

RegisterNetEvent('sunny:properties:removePlayer', function(target, value, pId, playersClientState)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not Properties.PropertiesList[pId] then 
        TriggerClientEvent('esx:showNotification', source, "~r~Cette propriété n'existe plus.")
        return 
    end

    if value == 'me' then
        Properties:addPlayer(source, 0)
        TriggerClientEvent('sunny:properties:teleport', source, Properties.PropertiesList[pId].enter)

        Properties.PropertiesList[pId].players[tostring(xPlayer.UniqueID)] = false
        if Properties.PropertiesList[pId].playersIG and Properties.PropertiesList[pId].playersIG[source] then
            Properties.PropertiesList[pId].playersIG[source] = nil
        end
        TriggerClientEvent('sunny:properties:changePlayerSate', source, pId, false)

    elseif value == 'all' then
        if Properties.PropertiesList[pId].playersIG then
            for playerSrc, playerData in pairs(Properties.PropertiesList[pId].playersIG) do
                local targetPlayer = ESX.GetPlayerFromId(playerSrc)
                if targetPlayer then
                    Properties:addPlayer(playerSrc, 0)
                    TriggerClientEvent('sunny:properties:teleport', playerSrc, Properties.PropertiesList[pId].enter)
                    Properties.PropertiesList[pId].players[tostring(targetPlayer.UniqueID)] = false
                    TriggerClientEvent('sunny:properties:changePlayerSate', playerSrc, pId, false)
                end
            end
            Properties.PropertiesList[pId].playersIG = {}
        end
    end

    Properties:DbPlayerSync(pId)
    TriggerClientEvent('sunny:properties:updatePlayers', -1, pId, Properties.PropertiesList[pId].players)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    if xPlayer and xPlayer.UniqueID then
        Properties.garage = Properties.garage or {}
        Properties.garage.count2 = Properties.garage.count2 or {}
        Properties.garage.count2[xPlayer.UniqueID] = 0
    else
        print(("[PropertiesServer] WARNING: xPlayer or UniqueID not found for esx:playerLoaded. Source/PlayerID: %s"):format(tostring(playerId)))
    end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if not xPlayer then return end

    local playerUniqueId = tostring(xPlayer.UniqueID)

    for propId, propData in pairs(Properties.PropertiesList) do
        if propData.players and propData.players[playerUniqueId] then
            propData.players[playerUniqueId] = nil
            Properties:DbPlayerSync(propId)
            TriggerClientEvent('sunny:properties:updatePlayers', -1, propId, propData.players)
        end
        if propData.playersIG and propData.playersIG[playerId] then
            propData.playersIG[playerId] = nil
        end
    end
    if Properties.garage and Properties.garage.count2 and Properties.garage.count2[playerUniqueId] then
        Properties.garage.count2[playerUniqueId] = nil
    end
    -- print(("[PropertiesServer] Cleaned up property data for disconnected player %s (UniqueID: %s)"):format(playerId, playerUniqueId))
end)


RegisterNetEvent('sunny:properties:locked', function(k, statut)
    if Properties.PropertiesList[k] then
        Properties.PropertiesList[k].open = statut
        TriggerClientEvent('sunny:properties:locked', -1, k, statut)
    end
end)

RegisterNetEvent('sunny:properties:lockedCoffre', function(k, statut)
    if Properties.PropertiesList[k] then
        Properties.PropertiesList[k].coffreOpen = statut
        TriggerClientEvent('sunny:properties:lockedCoffre', -1, k, statut)
    end
end)

RegisterNetEvent('sunny:properties:sell', function(propertiesID)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if not Properties.PropertiesList[propertiesID] then
        TriggerClientEvent('esx:showNotification', source, "~r~Cette propriété n'existe pas.")
        return
    end
    
    local propertyToSell = Properties.PropertiesList[propertiesID]
    if propertyToSell.owner ~= xPlayer.UniqueID then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'êtes pas le propriétaire de cette maison.")
        return
    end

    MySQL.Async.execute('UPDATE properties SET propertiesOWNER = @owner, ownerName = @ownerName, players = @players WHERE propertiesID = @propertiesID', {
        ['@propertiesID'] = propertiesID,
        ['@owner'] = 'none',
        ['@ownerName'] = 'none',
        ['@players'] = '{}'
    }, function(affectedRows)
        if affectedRows > 0 then
            if propertyToSell.playersIG then
                for playerSrc, pData in pairs(propertyToSell.playersIG) do
                    Properties:addPlayer(playerSrc, 0)
                    TriggerClientEvent('sunny:properties:teleport', playerSrc, propertyToSell.enter)
                    TriggerClientEvent('sunny:properties:changePlayerSate', playerSrc, propertiesID, false)
                end
            end
            
            propertyToSell.owner = 'none'
            propertyToSell.ownerName = 'none'
            propertyToSell.players = {}
            propertyToSell.playersIG = {}
            propertyToSell.open = false
            propertyToSell.coffreOpen = false

            TriggerClientEvent('esx:showNotification', source, '🏠 Propriété vendue avec succès')
            local refundAmount = tonumber(propertyToSell.price) / 100 * 50
            xPlayer.addAccountMoney('bank', refundAmount)

            TriggerClientEvent('sunny:properties:updateProperties', -1, propertiesID, propertyToSell)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Erreur lors de la vente de la propriété (DB).")
        end
    end)
end)

RegisterNetEvent('sunny:properties:interphone:call', function(propertiesDataClient, time)
    if not propertiesDataClient or not propertiesDataClient.id then return end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    local propertyId = propertiesDataClient.id
    if not Properties.PropertiesList[propertyId] then return end

    local actualPropertyData = Properties.PropertiesList[propertyId]

    actualPropertyData.interphone = actualPropertyData.interphone or {}
    actualPropertyData.interphone[xPlayer.UniqueID] = {
        UniqueID = xPlayer.UniqueID,
        name = xPlayer.name,
        firstname = xPlayer.get('firstName'),
        lastname = xPlayer.get('lastName'),
        playerCoords = GetEntityCoords(GetPlayerPed(source)),
        at = os.date(('%sh%sm%ss'):format('%H', '%M', '%S')),
    }

    local ownerPlayer = nil
    if actualPropertyData.owner ~= 'none' then
        ownerPlayer = ESX.GetPlayerFromUniqueId(actualPropertyData.owner)
    end

    local notifiedSomeone = false
    if actualPropertyData.playersIG then
        for playerSrc, pData in pairs(actualPropertyData.playersIG) do
            local targetPlayer = ESX.GetPlayerFromId(playerSrc)
            if targetPlayer then
                TriggerClientEvent('sunny:properties:interphone:call:requestCall', targetPlayer.source, actualPropertyData)
                notifiedSomeone = true
            end
        end
    end
    
    if ownerPlayer and (not actualPropertyData.playersIG or not actualPropertyData.playersIG[ownerPlayer.source]) then
         TriggerClientEvent('sunny:properties:interphone:call:requestCall', ownerPlayer.source, actualPropertyData)
         notifiedSomeone = true
    end

    if not notifiedSomeone then
        TriggerClientEvent('esx:showNotification', source, "Personne n'est disponible pour répondre.")
    end
end)

RegisterNetEvent('sunny:properties:interphone:call:validateEnter', function(propertiesDataClient, playerData)
    local source = source
    local xPlayerAnswering = ESX.GetPlayerFromId(source)

    if not xPlayerAnswering then return end
    
    local propertyId = propertiesDataClient.id
    local property = Properties.PropertiesList[propertyId]
    if not property then return end

    local isOwner = property.owner == xPlayerAnswering.UniqueID
    local isInside = property.playersIG and property.playersIG[source]
    if not isOwner and not isInside then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'êtes pas autorisé à faire entrer des gens.")
        return
    end

    local playerToEnter = ESX.GetPlayerFromUniqueId(playerData.UniqueID)
    if not playerToEnter then 
        TriggerClientEvent('esx:showNotification', source, "~r~La personne qui a sonné n'est plus connectée.")
        return 
    end

    if property.interphone and property.interphone[playerData.UniqueID] then
        property.interphone[playerData.UniqueID] = nil
        TriggerClientEvent('sunny:properties:updateCallWithPlayerCall', playerToEnter.source, property)
    end

    TriggerClientEvent('sunny:properties:interphone:update', -1, property)

    if #(GetEntityCoords(GetPlayerPed(playerToEnter.source)) - vector3(property.enter.x, property.enter.y, property.enter.z)) > 10.0 then -- Increased range slightly
        TriggerClientEvent('esx:showNotification', source, "~r~La personne est trop éloignée de la porte d'entrée.")
        TriggerClientEvent('esx:showNotification', playerToEnter.source, "~r~Vous êtes trop éloigné de la porte d'entrée.")
        return 
    end

    Properties:addPlayer(playerToEnter.source, propertyId)
    TriggerClientEvent('sunny:properties:teleport', playerToEnter.source, property.exit)

    property.playersIG = property.playersIG or {}
    property.playersIG[playerToEnter.source] = { source = playerToEnter.source, UniqueID = playerToEnter.UniqueID }
    property.players[tostring(playerToEnter.UniqueID)] = true

    Properties:DbPlayerSync(propertyId)
    
    TriggerClientEvent('sunny:properties:changePlayerSate', playerToEnter.source, propertyId, true)
    TriggerClientEvent('sunny:properties:updatePlayers', -1, propertyId, property.players)
end)

RegisterNetEvent('sunny:properties:interphone:call:refuseEnter', function(propertiesDataClient, playerData)
    local source = source
    local xPlayerAnswering = ESX.GetPlayerFromId(source)

    if not xPlayerAnswering then return end

    local propertyId = propertiesDataClient.id
    local property = Properties.PropertiesList[propertyId]
    if not property then return end

    local isOwner = property.owner == xPlayerAnswering.UniqueID
    local isInside = property.playersIG and property.playersIG[source]
    if not isOwner and not isInside then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'êtes pas autorisé.")
        return
    end

    local playerRefused = ESX.GetPlayerFromUniqueId(playerData.UniqueID)
    if not playerRefused then return end

    if property.interphone and property.interphone[playerData.UniqueID] then
        property.interphone[playerData.UniqueID] = nil
        TriggerClientEvent('sunny:properties:updateCallWithPlayerCall', playerRefused.source, property)
    end
    
    TriggerClientEvent('esx:showNotification', playerRefused.source, "~y~On vous a refusé l'entrée.")
    TriggerClientEvent('sunny:properties:interphone:update', -1, property)
end)

local function ReturnPlayerByUniqueId(uniqueId)
    for _, playerId in ipairs(ESX.GetPlayers()) do
        local xP = ESX.GetPlayerFromId(playerId)
        if xP and tostring(xP.UniqueID) == tostring(uniqueId) then
            return xP
        end
    end
    return nil
end

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
    print("[PropertiesServer] ESX Loaded.")
end)

--[[]
CreateThread(function()
    while true do 
        Wait(3600000) -- 1 hour
        MySQL.Async.fetchAll('SELECT * FROM properties WHERE type = @type AND propertiesOWNER <> @none', {
            ['@type'] = 'location',
            ['@none'] = 'none'
        }, function(result)
            if result then
                for k,v in pairs(result) do 
                    if tonumber(v.time) <= 0 then goto continue_rental_loop end

                    local newTime = tonumber(v.time) - 1
                    Properties.PropertiesList[v.propertiesID].time = newTime

                    if newTime > 0 then
                        MySQL.Async.execute('UPDATE properties SET time = @time WHERE propertiesID = @p', {
                            ['@p'] = v.propertiesID,
                            ['@time'] = newTime
                        }, function()
                            TriggerClientEvent('sunny:properties:updateProperties', -1, v.propertiesID, Properties.PropertiesList[v.propertiesID])
                        end)
                    else
                        -- Rental expired
                        local propertyToExpire = Properties.PropertiesList[v.propertiesID]
                        MySQL.Async.execute('UPDATE properties SET time = @time, propertiesOWNER = @o, ownerName = @on, players = @players WHERE propertiesID = @p', {
                            ['@p'] = v.propertiesID,
                            ['@time'] = 0,
                            ['@o'] = 'none',
                            ['@on'] = 'none',
                            ['@players'] = '{}'
                        }, function()
                            if propertyToExpire.playersIG then
                                for playerSrc, pData in pairs(propertyToExpire.playersIG) do
                                    Properties:addPlayer(playerSrc, 0) 
                                    TriggerClientEvent('sunny:properties:teleport', playerSrc, propertyToExpire.enter)
                                    TriggerClientEvent('sunny:properties:changePlayerSate', playerSrc, v.propertiesID, false)
                                end
                            end
                            propertyToExpire.owner = 'none'
                            propertyToExpire.ownerName = 'none'
                            propertyToExpire.players = {}
                            propertyToExpire.playersIG = {}
                            propertyToExpire.open = false
                            propertyToExpire.coffreOpen = false
                            propertyToExpire.time = 0
                            TriggerClientEvent('sunny:properties:updateProperties', -1, v.propertiesID, propertyToExpire)
                            
                            local ownerUser = ESX.GetPlayerFromUniqueId(v.propertiesOWNER)
                            if ownerUser then
                                TriggerClientEvent('esx:showNotification', ownerUser.source, ("Votre location pour %s a expiré."):format(propertyToExpire.label or propertyToExpire.name))
                            end
                        end)
                    end
                    ::continue_rental_loop::
                end
            end
        end)
    end
end)
]]--