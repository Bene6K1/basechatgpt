ESX = nil
local activeRentals = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('kart_rental:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local money = xPlayer.getMoney()
        if money >= Config.KartPrice then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterNetEvent('kart_rental:startRental')
AddEventHandler('kart_rental:startRental', function(price, vehicleNetId)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        if xPlayer.getMoney() >= price then
            xPlayer.removeAccountMoney('money', price)
            
            TriggerEvent("esx_society:depositMoney", Config.SocietyName, price, true)
            
            activeRentals[source] = {
                playerId = source,
                identifier = xPlayer.getIdentifier(),
                startTime = os.time(),
                endTime = os.time() + (Config.RentalDuration * 60),
                vehicleNetId = vehicleNetId
            }
            

        else
            TriggerClientEvent('esx:showNotification', source, 'Erreur: Solde insuffisant')
        end
    end
end)

RegisterNetEvent('kart_rental:endRental')
AddEventHandler('kart_rental:endRental', function()
    local source = source
    if activeRentals[source] then
        if activeRentals[source].vehicleNetId then
            DeleteRentalVehicle(activeRentals[source].vehicleNetId)
        end
        activeRentals[source] = nil
    end
end)

function DeleteRentalVehicle(vehicleNetId)
    if vehicleNetId then
        local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
        if vehicle and DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
        end
    end
end

AddEventHandler('playerDropped', function(reason)
    local source = source
    if activeRentals[source] then
        if activeRentals[source].vehicleNetId then
            DeleteRentalVehicle(activeRentals[source].vehicleNetId)
        end
        activeRentals[source] = nil
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        
        local currentTime = os.time()
        for playerId, rental in pairs(activeRentals) do
            if currentTime >= rental.endTime then
                TriggerClientEvent('kart_rental:forceEndRental', playerId)
                if rental.vehicleNetId then
                    DeleteRentalVehicle(rental.vehicleNetId)
                end
                activeRentals[playerId] = nil
            end
        end
    end
end) 