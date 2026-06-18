local VehicleDealer = {

}

ESX.RegisterServerCallback('sunny:vehicle_dealer:sendCategorieList', function(source, cb, job)
    local vehicle_categorie = {}
    if job == 'motorcycles' then
        MySQL.Async.fetchAll('SELECT * FROM moto_categories', {}, function(result)
            for k,v in pairs(result) do
                table.insert(vehicle_categorie, v)
            end

            cb(vehicle_categorie)
        end)
    elseif job == 'boat' then
        MySQL.Async.fetchAll('SELECT * FROM boat_categories', {}, function(result)
            for k,v in pairs(result) do
                table.insert(vehicle_categorie, v)
            end

            cb(vehicle_categorie)
        end)
    elseif job == 'aircraft' then
        MySQL.Async.fetchAll('SELECT * FROM aircraft_categorie', {}, function(result)
            for k,v in pairs(result) do
                table.insert(vehicle_categorie, v)
            end

            cb(vehicle_categorie)
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
            for k,v in pairs(result) do
                table.insert(vehicle_categorie, v)
            end

            cb(vehicle_categorie)
        end)
    end
end)

ESX.RegisterServerCallback('sunny:vehicle_dealer:sendVehicleWithCategorie', function(source, cb, categorieName)
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM vehicules WHERE category = @category', {
        ['@category'] = categorieName
    }, function(result)
        for k,v in pairs(result) do
            table.insert(vehicles, v)
        end          
        
        cb(vehicles)
    end)
end)

ESX.RegisterServerCallback('sunny:vehicle_dealer:sendBill', function(source, cb, price, price2, target)
    local source = source
    local targetPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent('sunny:vehicle_dealer:sendBill', targetPlayer.source, source, price2, price)
end)

RegisterNetEvent('sunny:vehicle_dealer_paybill', function(vendeur,price,price2)
    local source = source
    local seller = ESX.GetPlayerFromId(vendeur)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getAccount('bank').money < price2/100*135 then TriggerClientEvent('esx:showNotification', xPlayer.source, '💲 Vous n\'avez pas assez ~g~d\'argent~s~ en banque') return TriggerClientEvent('esx:showNotification', vendeur, '💲 La personne n\'a pas assez de sous en banque') end

    local society = Society:getSociety(seller.job.name)

    if not society then return end

    if society.coffre['accounts'].society < price then return TriggerClientEvent('esx:showNotification', seller.source, 'Il n\'y pas assez de sous sur le compte de la société') end

    xPlayer.removeAccountMoney('bank', price2/100*135)
    society.removeSocietyMoney(price)
    society.addSocietyMoney(price2/100*135)

    -- TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..seller.job.name, function(account)
    --     account.removeMoney(price)
    --     account.addMoney(price2)
    -- end)

    TriggerClientEvent('sunny:vehicle_dealer:spawnVehicle', seller.source, source)
end)

RegisterNetEvent('sunny:vehicle_dealer_refuseBill', function(vendeur)
    TriggerClientEvent('esx:showNotification', vendeur, 'La personne a ~r~refusé~s~ la facture')
end)

RegisterNetEvent('sunny:vehicle_dealer:sendVehicleKey', function(player, vehicleData)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(player)
    
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, label, vehicle, plate, type, state, boutique, garageid) VALUE (@owner, @label, @vehicle, @plate, @type, @state, @boutique, @garageid)', {
        ['@owner'] = targetPlayer.UniqueID,
        ['@label'] = vehicleData.label,
        ['@vehicle'] = json.encode(vehicleData.vehicle),
        ['@plate'] = vehicleData.plate,
        ['@type'] = vehicleData.type,
        ['@state'] = 0,
        ['@boutique'] = 0,
        ['@garageid'] = 1
    }, function()
        TriggerClientEvent('esx:showNotification', targetPlayer.source, ('Vous avez recus les clés du véhicule avec la plaque [~y~%s~s~]'):format(vehicleData.plate))
        TriggerClientEvent('esx:showNotification', source, ('~r~%s$~s~ on été retiré du compte de la société'):format(vehicleData.price))

        Garages:loadWithPlayerUniqueID(targetPlayer.UniqueID)
        
        -- Donner les clés directement dans l'inventaire du joueur
        if GetResourceState('ox_inventory') == 'started' then
            -- Ajouter l'item vehiclekeys avec la plaque en metadata
            exports.ox_inventory:AddItem(targetPlayer.source, 'vehiclekeys', 1, {
                plate = vehicleData.plate,
                description = ('Clés du véhicule avec la plaque %s'):format(vehicleData.plate)
            })
        else
            -- Fallback sur le système Bridge si ox_inventory n'est pas disponible
            TriggerClientEvent('sunny:vehicle_dealer:giveKeys', targetPlayer.source, vehicleData.plate)
        end
    end)
end)

local catalogueTable = {}

ESX.RegisterServerCallback('sunny:vehicle_dealer:catalogue:sendVehicleList', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    catalogueTable[xPlayer.UniqueID] = {}

    MySQL.Async.fetchAll('SELECT * FROM vehicules', {}, function(result)
        for k,v in pairs(result) do
            table.insert(catalogueTable[xPlayer.UniqueID], v)
        end

        cb(catalogueTable[xPlayer.UniqueID])
    end)
end)

Concess = {
    inService = {}
}

RegisterNetEvent('sunny:concess:service', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end
    if xPlayer.job.name ~= "cardealer" and xPlayer.job.name ~= "airdealer" and xPlayer.job.name ~= "boatdealer" and xPlayer.job.name ~= "motodealer" then return end

    if not Concess.inService[xPlayer.identifier] then
        local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
        Concess.inService[xPlayer.identifier] = true
        for id, _ in pairs(Concess.inService) do
            local targetPlayer = ESX.GetPlayerFromIdentifier(id)
            if targetPlayer and targetPlayer.job.name == xPlayer.job.name then
                TriggerClientEvent('esx:showNotification', targetPlayer.source, ('L\'employé ~y~%s~s~ a pris son service'):format(rpName))
            end
        end
    else
        local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
        Concess.inService[xPlayer.identifier] = nil
        for id, _ in pairs(Concess.inService) do
            local targetPlayer = ESX.GetPlayerFromIdentifier(id)
            if targetPlayer and targetPlayer.job.name == xPlayer.job.name then
                TriggerClientEvent('esx:showNotification', targetPlayer.source, ('L\'employé ~y~%s~s~ a fini son service'):format(rpName))
            end
        end
    end
end)