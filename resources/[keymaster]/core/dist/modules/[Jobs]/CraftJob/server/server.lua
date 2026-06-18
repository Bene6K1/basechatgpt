local craftingPlayers = {}

local jobMapping = {
    ['restau_burgershot'] = 'burgershot',
    ['restau_pops'] = 'pops',
    ['restau_pearls'] = 'pearls',
    ['hornys'] = 'hornys'
}

local function HasJob(xPlayer, jobName)
    local realJob = jobMapping[jobName] or jobName
    
    if xPlayer.job and (xPlayer.job.name == jobName or xPlayer.job.name == realJob) then return true end
    if xPlayer.job2 and (xPlayer.job2.name == jobName or xPlayer.job2.name == realJob) then return true end
    
    return false
end

RegisterNetEvent('craft:craftItem')
AddEventHandler('craft:craftItem', function(job, craftItem, ingredients)
    local source = source
    print("^2[DEBUG CRAFT] craft:craftItem appelé - Source: " .. source .. " - Job: " .. tostring(job) .. " - Item: " .. tostring(craftItem) .. "^0")
    
    if craftingPlayers[source] then
        print("^1[DEBUG CRAFT] craft:craftItem BLOCKÉ - Source: " .. source .. " (déjà en cours)^0")
        return
    end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        print("^1[DEBUG CRAFT] craft:craftItem - xPlayer nil^0")
        return
    end
    
    if craftingPlayers[source] then
        print("^1[DEBUG CRAFT] craft:craftItem BLOCKÉ - Source: " .. source .. " (déjà en cours)^0")
        return
    end
    
    print("^3[DEBUG CRAFT] craft:craftItem - Mise à jour craftingPlayers[" .. source .. "] = true^0")
    craftingPlayers[source] = true
    
    if HasJob(xPlayer, job) then
        local hasAllItems = true
        for _, ingredient in ipairs(ingredients) do
            local itemCount = 0
            if GetResourceState('ox_inventory') == 'started' then
                itemCount = exports.ox_inventory:GetItemCount(source, ingredient.item) or 0
            else
                local item = xPlayer.getInventoryItem(ingredient.item)
                itemCount = item and item.count or 0
            end
            if itemCount < ingredient.count then
                hasAllItems = false
                break
            end
        end

        if hasAllItems then
            print("^2[DEBUG CRAFT] craft:craftItem - Tous les items présents - Création de l'item^0")
            local allRemoved = true
            for _, ingredient in ipairs(ingredients) do
                if GetResourceState('ox_inventory') == 'started' then
                    if not exports.ox_inventory:RemoveItem(source, ingredient.item, ingredient.count) then
                        allRemoved = false
                        break
                    end
                else
                    xPlayer.removeInventoryItem(ingredient.item, ingredient.count)
                end
            end
            
            if allRemoved then
                if GetResourceState('ox_inventory') == 'started' then
                    if exports.ox_inventory:AddItem(source, craftItem, 1) then
                        print("^2[DEBUG CRAFT] craft:craftItem - Envoi notification de succès à " .. source .. "^0")
                        TriggerClientEvent('esx:showNotification', source, 'Vous avez crafté ~g~' .. craftItem)
                    else
                        -- Refund si l'ajout échoue
                        for _, ingredient in ipairs(ingredients) do
                            exports.ox_inventory:AddItem(source, ingredient.item, ingredient.count)
                        end
                        TriggerClientEvent('esx:showNotification', source, '~r~Inventaire plein')
                    end
                else
                    xPlayer.addInventoryItem(craftItem, 1)
                    print("^2[DEBUG CRAFT] craft:craftItem - Envoi notification de succès à " .. source .. "^0")
                    TriggerClientEvent('esx:showNotification', source, 'Vous avez crafté ~g~' .. craftItem)
                end
            else
                -- Refund si la suppression échoue
                for _, ingredient in ipairs(ingredients) do
                    if GetResourceState('ox_inventory') == 'started' then
                        exports.ox_inventory:AddItem(source, ingredient.item, ingredient.count)
                    else
                        xPlayer.addInventoryItem(ingredient.item, ingredient.count)
                    end
                end
                TriggerClientEvent('esx:showNotification', source, '~r~Erreur lors du craft')
            end
            
            -- Log
            local jobNameLog = xPlayer.job.name
            if HasJob(xPlayer, job) and xPlayer.job2 and xPlayer.job2.name == (jobMapping[job] or job) then
                jobNameLog = xPlayer.job2.name
            end
            
            sendLog(("Le Joueur (%s - %s) viens de craft l'item (x1 - %s)"):format(xPlayer.name, xPlayer.UniqueID, jobNameLog, craftItem), {
                author = 'Craft Job',
                fields = {
                    {title = 'Player', subtitle = xPlayer.name},
                    {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                    {title = 'Identifier', subtitle = xPlayer.identifier},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'craft_job'
            })
            
            print("^3[DEBUG CRAFT] craft:craftItem - Réinitialisation craftingPlayers[" .. source .. "] = nil^0")
            craftingPlayers[source] = nil
        else
            print("^1[DEBUG CRAFT] craft:craftItem - Pas tous les items - Envoi notification à " .. source .. "^0")
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas tous les items nécessaires')
            print("^3[DEBUG CRAFT] craft:craftItem - Réinitialisation craftingPlayers[" .. source .. "] = nil^0")
            craftingPlayers[source] = nil
        end
    else
        print("^1[DEBUG CRAFT] craft:craftItem - Job non autorisé - Envoi notification à " .. source .. "^0")
        TriggerClientEvent('esx:showNotification', source, 'Action non autorisée pour votre job')
        print("^3[DEBUG CRAFT] craft:craftItem - Réinitialisation craftingPlayers[" .. source .. "] = nil^0")
        craftingPlayers[source] = nil
    end
end)

RegisterNetEvent('craft:verifitem')
AddEventHandler('craft:verifitem', function(job, craftItem, ingredients)
    local source = source
    print("^2[DEBUG CRAFT] craft:verifitem appelé - Source: " .. source .. " - Job: " .. tostring(job) .. " - Item: " .. tostring(craftItem) .. "^0")
    
    if craftingPlayers[source] then
        print("^1[DEBUG CRAFT] craft:verifitem BLOCKÉ - Source: " .. source .. " (déjà en cours)^0")
        return
    end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        print("^1[DEBUG CRAFT] craft:verifitem BLOCKÉ - Source: " .. source .. " (xPlayer nil)^0")
        return
    end
    
    if HasJob(xPlayer, job) then
        local hasAllItems = true
        for _, ingredient in ipairs(ingredients) do
            local itemCount = 0
            if GetResourceState('ox_inventory') == 'started' then
                itemCount = exports.ox_inventory:GetItemCount(source, ingredient.item) or 0
            else
                local item = xPlayer.getInventoryItem(ingredient.item)
                itemCount = item and item.count or 0
            end
            if itemCount < ingredient.count then
                hasAllItems = false
                break
            end
        end
        if not hasAllItems then
            print("^1[DEBUG CRAFT] craft:verifitem - Pas tous les items - Envoi notification à " .. source .. "^0")
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas tous les items nécessaires')
        else
            print("^2[DEBUG CRAFT] craft:verifitem - Tous les items présents - Envoi craft:startCrafting à " .. source .. "^0")
            TriggerClientEvent('craft:startCrafting', source, job, craftItem, ingredients)
        end
    else
        print("^1[DEBUG CRAFT] craft:verifitem - Job non autorisé - Envoi notification à " .. source .. "^0")
        TriggerClientEvent('esx:showNotification', source, 'Action non autorisée pour votre job')
        print("^3[DEBUG CRAFT] craft:verifitem - Réinitialisation craftingPlayers[" .. source .. "] = nil^0")
        craftingPlayers[source] = nil
    end
end)