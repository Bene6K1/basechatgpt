-- local VehicleDealer = {

-- }

-- ESX.RegisterServerCallback('sunny:vehicle_dealer:sendCategorieList', function(source, cb, job)
--     local vehicle_categorie = {}
--     if job == 'motorcycles' then
--         MySQL.Async.fetchAll('SELECT * FROM moto_categories', {}, function(result)
--             for k,v in pairs(result) do
--                 table.insert(vehicle_categorie, v)
--             end

--             cb(vehicle_categorie)
--         end)
--     elseif job == 'boat' then
--         MySQL.Async.fetchAll('SELECT * FROM boat_categories', {}, function(result)
--             for k,v in pairs(result) do
--                 table.insert(vehicle_categorie, v)
--             end

--             cb(vehicle_categorie)
--         end)
--     elseif job == 'aircraft' then
--         MySQL.Async.fetchAll('SELECT * FROM aircraft_categorie', {}, function(result)
--             for k,v in pairs(result) do
--                 table.insert(vehicle_categorie, v)
--             end

--             cb(vehicle_categorie)
--         end)
--     else
--         MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
--             for k,v in pairs(result) do
--                 table.insert(vehicle_categorie, v)
--             end

--             cb(vehicle_categorie)
--         end)
--     end
-- end)

-- ESX.RegisterServerCallback('sunny:vehicle_dealer:sendVehicleWithCategorie', function(source, cb, categorieName)
--     local vehicles = {}

--     MySQL.Async.fetchAll('SELECT * FROM vehicules WHERE category = @category', {
--         ['@category'] = categorieName
--     }, function(result)
--         for k,v in pairs(result) do
--             table.insert(vehicles, v)
--         end          
        
--         cb(vehicles)
--     end)
-- end)

-- ESX.RegisterServerCallback('sunny:vehicle_dealer:sendBill', function(source, cb, price, price2, target)
--     local source = source
--     local targetPlayer = ESX.GetPlayerFromId(target)

--     TriggerClientEvent('sunny:vehicle_dealer:sendBill', targetPlayer.source, source, price2, price)
-- end)

-- RegisterNetEvent('sunny:vehicle_dealer_paybill', function(vendeur,price,price2)
--     local source = source
--     local seller = ESX.GetPlayerFromId(vendeur)
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.getAccount('bank').money < price2/100*135 then TriggerClientEvent('esx:showNotification', xPlayer.source, '💲 Vous n\'avez pas assez ~g~d\'argent~s~ en banque') return TriggerClientEvent('esx:showNotification', vendeur, '💲 La personne n\'a pas assez de sous en banque') end

--     local society = Society:getSociety(seller.job.name)

--     if not society then return end

--     if society.coffre['accounts'].society < price then return TriggerClientEvent('esx:showNotification', seller.source, 'Il n\'y pas assez de sous sur le compte de la société') end

--     xPlayer.removeAccountMoney('bank', price2/100*135)
--     society.removeSocietyMoney(price)
--     society.addSocietyMoney(price2/100*135)

--     -- TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..seller.job.name, function(account)
--     --     account.removeMoney(price)
--     --     account.addMoney(price2)
--     -- end)

--     TriggerClientEvent('sunny:vehicle_dealer:spawnVehicle', seller.source, source)
-- end)

-- RegisterNetEvent('sunny:vehicle_dealer_refuseBill', function(vendeur)
--     TriggerClientEvent('esx:showNotification', vendeur, 'La personne a ~r~refusé~s~ la facture')
-- end)

-- RegisterNetEvent('sunny:vehicle_dealer:sendVehicleKey', function(player, vehicleData)
--     local source = source
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local targetPlayer = ESX.GetPlayerFromId(player)
    
--     MySQL.Async.execute('INSERT INTO owned_vehicles (owner, label, vehicle, plate, type, state, boutique, garageid) VALUE (@owner, @label, @vehicle, @plate, @type, @state, @boutique, @garageid)', {
--         ['@owner'] = targetPlayer.UniqueID,
--         ['@label'] = vehicleData.label,
--         ['@vehicle'] = json.encode(vehicleData.vehicle),
--         ['@plate'] = vehicleData.plate,
--         ['@type'] = vehicleData.type,
--         ['@state'] = 0,
--         ['@boutique'] = 0,
--         ['@garageid'] = 1
--     }, function()
--         TriggerClientEvent('esx:showNotification', targetPlayer.source, ('Vous avez recus les clés du véhicule avec la plaque [~y~%s~s~]'):format(vehicleData.plate))
--         TriggerClientEvent('esx:showNotification', source, ('~r~%s$~s~ on été retiré du compte de la société'):format(vehicleData.price))

--         Garages:loadWithPlayerUniqueID(targetPlayer.UniqueID)
--     end)
-- end)

-- local catalogueTable = {}

-- ESX.RegisterServerCallback('sunny:vehicle_dealer:catalogue:sendVehicleList', function(source, cb)
--     local source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if not xPlayer then return end

--     catalogueTable[xPlayer.UniqueID] = {}

--     MySQL.Async.fetchAll('SELECT * FROM vehicules', {}, function(result)
--         for k,v in pairs(result) do
--             table.insert(catalogueTable[xPlayer.UniqueID], v)
--         end

--         cb(catalogueTable[xPlayer.UniqueID])
--     end)
-- end)

-- Concess = {
--     inService = {}
-- }

-- RegisterNetEvent('sunny:concess:service', function()
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if not xPlayer then return end
--     if xPlayer.job.name ~= "cardealer" and xPlayer.job.name ~= "airdealer" and xPlayer.job.name ~= "boatdealer" and xPlayer.job.name ~= "motodealer" then return end

--     if not Concess.inService[xPlayer.identifier] then
--         Concess.inService[xPlayer.identifier] = true
--         for id, _ in pairs(Concess.inService) do
--             local targetPlayer = ESX.GetPlayerFromIdentifier(id)
--             if targetPlayer and targetPlayer.job.name == xPlayer.job.name then
--                 TriggerClientEvent('esx:showNotification', targetPlayer.source, ('L\'employé ~y~%s~s~ a pris son service'):format(xPlayer.name))
--             end
--         end
--     else
--         Concess.inService[xPlayer.identifier] = nil
--         for id, _ in pairs(Concess.inService) do
--             local targetPlayer = ESX.GetPlayerFromIdentifier(id)
--             if targetPlayer and targetPlayer.job.name == xPlayer.job.name then
--                 TriggerClientEvent('esx:showNotification', targetPlayer.source, ('L\'employé ~y~%s~s~ a fini son service'):format(xPlayer.name))
--             end
--         end
--     end
-- end)

-- local coordsToSpawn = {
--     ['motorcycles'] = vector4(-866.30859375, -203.33352661133, 37.837188720703, 28.764806747437),
--     ['car'] = vector4(-594.69781494141, -1111.8317871094, 22.178255081177, 267.83044433594),
--     ['boat'] = vector4(-841.11834716797, -1380.8658447266, 0.18391132354736, 111.80742645264),
--     ['aircraft'] = vector4(-1017.146, -2973.552, 13.94877, 58.533008575439)
-- }

-- RegisterNetEvent("sunny:vehicle_dealer:buyVehicle", function(model, __type) 
--     local source = source
--     local xPlayer = ESX.GetPlayerFromId(source)

--     if not xPlayer then return end

--     local vehicle = MySQL.Sync.fetchAll('SELECT * FROM vehicules WHERE model = @model', {
--         ['@model'] = model
--     })

--     if not vehicle[1] then
--         TriggerClientEvent('esx:showNotification', source, 'Ce véhicule n\'existe pas dans le catalogue')
--         return
--     end

--     vehicle[1].price = tonumber(vehicle[1].price)

--     if xPlayer.getAccount('bank').money < vehicle[1].price then
--         TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent en banque')
--         return
--     end

--     xPlayer.removeAccountMoney('bank', vehicle[1].price)

--     GenerateUniquePlate(function(_plate) 
--         local _coords = coordsToSpawn[__type]

--         local _vehicle = CreateVehicle(GetHashKey(model), _coords.x, _coords.y, _coords.z, _coords.w, true, true)
        
--         local attemps = 0

--         while not DoesEntityExist(_vehicle) and attemps < 10 do
--             attemps = attemps + 1
--             Citizen.Wait(100)
--         end

--         if not DoesEntityExist(_vehicle) then
--             TriggerClientEvent('esx:showNotification', source, 'Impossible de créer le véhicule, veuillez contacter un administrateur')
--             return
--         end
        
--         SetVehicleNumberPlateText(_vehicle, _plate)

--         local _type = GetVehicleType(_vehicle)

--         if _type == 'automobile' or _type == 'bike' then 
--             _type = "car"
--         end

--         MySQL.Async.execute('INSERT INTO owned_vehicles (owner, label, vehicle, plate, type, state, boutique, garageid) VALUE (@owner, @label, @vehicle, @plate, @type, @state, @boutique, @garageid)', {
--             ['@owner'] = xPlayer.UniqueID,
--             ['@label'] = vehicle[1].name,
--             ['@vehicle'] = json.encode({}),
--             ['@plate'] = _plate,
--             ['@type'] = _type,
--             ['@state'] = 0,
--             ['@boutique'] = 0,
--             ['@garageid'] = 1
--         }, function()
--             TriggerClientEvent('esx:showNotification', xPlayer.source, ('Vous avez recus les clés du véhicule avec la plaque [~y~%s~s~]'):format(_plate))

--             Garages:loadWithPlayerUniqueID(xPlayer.UniqueID)
--         end)

--     end)
-- end)

-- local function generatePlate()
--     local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
--     local plate = ""
--     for i = 1, 8 do
--         plate = plate .. charset:sub(math.random(1, #charset), math.random(1, #charset))
--     end
--     return plate
-- end

-- function GenerateUniquePlate(callback)
--     local function tryGenerate()
--         local newPlate = generatePlate()

--         newPlate = string.sub(newPlate, 1, 8)

--         exports.oxmysql:execute('SELECT 1 FROM owned_vehicles WHERE plate = ? LIMIT 1', { newPlate }, function(result)
--             if result[1] then
--                 tryGenerate()
--             else
--                 callback(newPlate)
--             end
--         end)
--     end

--     tryGenerate()
-- end