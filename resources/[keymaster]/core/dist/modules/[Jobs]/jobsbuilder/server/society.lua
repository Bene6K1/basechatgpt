FarmJobs = {
    inService = {}
}

RegisterNetEvent('sunny:FarmJobs:service', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    local jobName = xPlayer.job.name
    local jobLabel = xPlayer.job.label

    local players = ESX.GetExtendedPlayers('job', jobName)

    if not FarmJobs.inService[xPlayer.identifier] then
        local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
        FarmJobs.inService[xPlayer.identifier] = {
            identifier = xPlayer.identifier, 
            service = true,
            name = rpName
        }

        for k,v in pairs(players) do
            TriggerClientEvent('esx:showNotification', v.source, ('L\'employé ~y~%s~s~ a pris son service'):format(rpName))
        end
    else
        local rpName = ('%s %s'):format(xPlayer.firstname or 'Inconnu', xPlayer.lastname or '')
        FarmJobs.inService[xPlayer.identifier] = nil
        
        for k,v in pairs(players) do
            TriggerClientEvent('esx:showNotification', v.source, ('L\'employé ~y~%s~s~ a fini son service'):format(rpName))
        end
    end
end)
