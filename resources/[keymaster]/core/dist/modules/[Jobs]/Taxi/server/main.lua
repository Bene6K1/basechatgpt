taxi = {
    Service = {},
    Appelles = {},
    IsDead = {},

    Employeds = {}
}
RegisterServerEvent('Ouvre:taxi')
AddEventHandler('Ouvre:taxi', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer or not xPlayer.job then return end

    if xPlayer.job.name ~= "taxi" then return end
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Taxi', 'Annonce', 'Le taxi est désormais ~p~Ouvert~s~!', 'CHAR_TAXI', 8)
	end
end)

RegisterServerEvent('Ferme:taxi')
AddEventHandler('Ferme:taxi', function()
	local _source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		if not xPlayer or not xPlayer.job then return end

    if xPlayer.job.name ~= "taxi" then return end
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Taxi', 'Annonce', 'Le taxi est désormais ~r~Fermer~s~!', 'CHAR_TAXI', 8)
	end
end)
RegisterNetEvent("taxi:FinishMission")
AddEventHandler("taxi:FinishMission", function(bonus)
    local source = source
    if not source then return end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    
    if not xPlayer.job or xPlayer.job.name ~= "taxi" then
        return
    end
    
    local society = Society:getSociety(xPlayer.job.name)
    if not society then return end

    local gain = math.random(300,450)
    if not gain or gain <= 0 then return end
    
    xPlayer.addAccountMoney('cash', gain)
    society.addSocietyMoney(gain*2)

    local gainStr = tostring(gain) or "0"
    local societeGainStr = tostring(gain * 2) or "0"
    
    if source and source > 0 then
        TriggerClientEvent('esx:showNotification', source, "Vous avez terminé votre mission.\nGain: ~p~"..gainStr.."~s~€\nGain entreprise: ~p~"..societeGainStr.."~s~€")
    end
end)
RegisterNetEvent('sunny:taxi:service', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer or not xPlayer.job then return end

    if xPlayer.job.name ~= "taxi" then return end
    local xPlayerName = ('%s %s'):format(xPlayer.firstname or "Inconnu", xPlayer.lastname or "")

    taxi.Service[xPlayer.UniqueID] = not taxi.Service[xPlayer.UniqueID]
    
    TriggerClientEvent('sunny:taxi:service', source, taxi.Service[xPlayer.UniqueID])
   
    local taxiEmployees = ESX.GetExtendedPlayers('job', 'taxi')

    if taxi.Service[xPlayer.UniqueID] then
        taxi.Employeds[xPlayer.UniqueID] = {
            name = xPlayerName
        }
        TriggerClientEvent('sunny:taxi:addEmployed', -1, xPlayer.UniqueID, taxi.Employeds[xPlayer.UniqueID])

        for k,v in pairs(taxiEmployees) do
            TriggerClientEvent('esx:showNotification', v.source, ('L\'employé ~y~%s~s~ a pris son service'):format(xPlayerName))
        end

        LogsJobFunc.SendLogsService('taxi', ('*%s* a pris son service taxi'):format(xPlayerName), 'prise')
    else
        taxi.Service[xPlayer.UniqueID] = nil
        TriggerClientEvent('sunny:taxi:removeEmployed', -1, xPlayer.UniqueID)
        
        for k,v in pairs(taxiEmployees) do
            TriggerClientEvent('esx:showNotification', v.source, ('L\'employé ~y~%s~s~ a fini son service'):format(xPlayerName))
        end

        LogsJobFunc.SendLogsService('taxi', ('*%s* a quitter son service taxi'):format(xPlayerName), 'quit')
    end
end)



RegisterNetEvent('sunny:taxi:call', function(playerCoords)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer or not xPlayer.job then return end

    if xPlayer.job.name ~= "taxi" then return end

    if taxi.Appelles[xPlayer.UniqueID] then return end

    local callerRpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
    taxi.Appelles[xPlayer.UniqueID] = {
        name = callerRpName,
        UniqueID = xPlayer.UniqueID,
        position = playerCoords,
        take = false
    }

    local xxxxxxx = ESX.GetExtendedPlayers('job', 'taxi')

    for k,v in pairs(xxxxxxx) do
        TriggerClientEvent('sunny:taxi:addCall', v.source, xPlayer.UniqueID, taxi.Appelles[xPlayer.UniqueID])

        if taxi.Service[v.UniqueID] then
            TriggerClientEvent('esx:showNotification', v.source, '📞 Un nouvel appelle a été recus #'..xPlayer.UniqueID)
        end
    end


end)

RegisterNetEvent('sunny:taxi:takeAppel', function(k)
    	local xPlayer = ESX.GetPlayerFromId(source)
    	if not xPlayer or not xPlayer.job then return end

    if xPlayer.job.name ~= "taxi" then return end

    taxi.Appelles[k].take = true

    local xxxxxxx = ESX.GetExtendedPlayers('job', 'taxi')

    local xPlayerCaller = ESX.GetPlayerFromId(source)
    local callerRpName = "Inconnu"
    if xPlayerCaller then
        callerRpName = ('%s %s'):format(xPlayerCaller.firstname or 'Inconnu', xPlayerCaller.lastname or '')
    end
    
    for i,v in pairs(xxxxxxx) do

       TriggerClientEvent('sunny:taxi:updateCall', v.source, k, taxi.Appelles[k])

        if taxi.Service[v.UniqueID] then
            TriggerClientEvent('esx:showNotification', v.source, ('📞 %s a pris en charge l\'appel #%s'):format(callerRpName, tostring(k) or ""))
        end
    end

    TriggerClientEvent('sunny:taxi:takeMyCall', source, k)

    if not ReturnPlayerId(taxi.Appelles[k].UniqueID) then return end

    TriggerClientEvent('esx:showNotification', ReturnPlayerId(taxi.Appelles[k].UniqueID).id, '🚑 Un médecin est en route !')

end)

RegisterNetEvent('sunny:taxi:closeAppel', function(k)
    	local xPlayer = ESX.GetPlayerFromId(source)
    	if not xPlayer or not xPlayer.job then return end

    if xPlayer.job.name ~= "taxi" then return end
    if taxi.Appelles[k] ~= nil then
        taxi.Appelles[k] = nil
    end

    TriggerClientEvent('sunny:taxi:removeCall', -1, k)

    local callerRpName = "Inconnu"
    if xPlayer then
        callerRpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
    end

    local players = ESX.GetExtendedPlayers('job', 'taxi')

    for idx,v in pairs(players) do
        if taxi.Service[v.UniqueID] then
            TriggerClientEvent('esx:showNotification', v.source, ('📞 %s a terminé l\'appel #%s'):format(callerRpName, tostring(k) or ""))
        end
    end
end)



-- RegisterNetEvent('sunny:taxi:moneyBoss', function(society, amount, action)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

--     if xPlayer.job.name ~= "taxi" then return end

--     local society = Society:getSociety(xPlayer.job.name)

--     if not society then return end
    

--     if action == 'deposit' then
--         if xPlayer.getAccount('bank').money < amount then return TriggerClientEvent('esx:showNotification', source, 'Votre solde bancaire n\'est pas assez élevé') end

--         society.addMoney(amount)
--         xPlayer.removeAccountMoney('bank', amount)

--         TriggerClientEvent('esx:showNotification', source, ('Vous avez déposé ~y~%s$~s~'):format(amount))

--         -- TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
--         --     account.addMoney(amount)
--         --     xPlayer.removeAccountMoney('bank', amount)
    
--         --     TriggerClientEvent('esx:showNotification', source, ('Vous avez déposez ~y~%s$~s~'):format(amount))
--         -- end)
--     elseif action == 'remove' then
--         society.removeSocietyMoney(amount)
--         xPlayer.addAccountMoney('bank', amount)

--         TriggerClientEvent('esx:showNotification', source, ('Vous avez pris ~y~%s$~s~'):format(amount))

--         -- TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
--         --     if account.money < amount then return TriggerClientEvent('esx:showNotification', source, 'Il n\'y a pas assez d\'argent dans le coffre') end
--         --     account.removeMoney(amount)
--         --     xPlayer.addAccountMoney('bank', amount)
    
--         --     TriggerClientEvent('esx:showNotification', source, ('Vous avez pris ~y~%s$~s~'):format(amount))
--         -- end)
--     end
-- end)