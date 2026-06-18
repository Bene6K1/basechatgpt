CreateThread(function()
    for k,v in pairs(SunnyConfigServ.Fishing.fishList.FishingLures) do
        ESX.RegisterUsableItem(v.name, function(source)
            TriggerClientEvent('SunnyServ:fishing:lures:activate', source, {k, v.name, v.label})
        end)
    end

    RegisterNetEvent('SunnyServ:fishing:lures:remove', function(lures)
        local source = source
        local player = ESX.GetPlayerFromId(source)

        if not player then return end

        player.removeInventoryItem(lures, 1)
    end)

    RegisterNetEvent('SunnyServ:fishing:fish:give', function(fish, fishLabel, canName)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

        if not xPlayer then return end
        if not xPlayer.canCarryItem(fish, 1) then 
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") 
            return 
        end
          xPlayer.addInventoryItem(fish, 1)
        local xpGain = 50
        
        for zoneName, fishList in pairs(SunnyConfigServ.Fishing.fishList.FishList) do
            for _, fishData in pairs(fishList) do
                if fishData.name == fish then
                    local rarityBonus = math.floor((1 - fishData.rarity) * 200)
                    xpGain = 50 + rarityBonus
                    print(string.format("[FISHING] Poisson: %s, Rareté: %s, XP de base: %d", fishData.label, fishData.rarity, xpGain))
                    break
                end
            end
        end
        
        local isVip = VIP.haveVip(source)
        print(string.format("[FISHING] Joueur %s - VIP: %s", xPlayer.getName(), tostring(isVip)))
        
        if isVip then
            xpGain = xpGain * 2
            print(string.format("[FISHING] Bonus VIP appliqué! XP final: %d", xpGain))
        end

        fishing.players[xPlayer.UniqueID].level = fishing.players[xPlayer.UniqueID].level + xpGain

        for k,v in pairs(SunnyConfigServ.Fishing.fishList.FishingRod) do
            if v.name == canName then
                if v.boutique == false then
                    local currentFishCount = (xPlayer.getInventoryItem(v.name).extra and xPlayer.getInventoryItem(v.name).extra.fish) or 0
                    local newFishCount = currentFishCount + 1
                    
                    xPlayer.updateItemMetadata(v.name, {
                        fish = newFishCount
                    })

                    TriggerClientEvent('SunnyServ:fishing:updateRod', source, newFishCount)

                    if newFishCount >= v.fish then
                        xPlayer.removeInventoryItem(v.name, 1)
                        xPlayer.showNotification('Votre canne à pêche s\'est cassée')
                        TriggerClientEvent('SunnyServ:fishing:client:stop', source)
                    end
                end
                break
            end
        end
        MySQL.Async.execute('UPDATE player_fishing SET level = @level WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = xPlayer.UniqueID,
            ['@level'] = fishing.players[xPlayer.UniqueID].level
        }, function()
            TriggerClientEvent('SunnyServ:fishing:client:updateLevel', source, fishing.players[xPlayer.UniqueID].level)            local currentLevel = math.floor(fishing.players[xPlayer.UniqueID].level / 1000)
            local previousLevel = math.floor((fishing.players[xPlayer.UniqueID].level - xpGain) / 1000)
            
            xPlayer.showNotification(('Vous avez pêché un poisson: ~p~%s~s~'):format(fishLabel))
            
            if isVip then
                xPlayer.showNotification(('+%s XP de pêche ~g~(x2 VIP)~s~. Continue comme ça !'):format(xpGain))
            else
                xPlayer.showNotification(('+%s XP de pêche. Continue comme ça !'):format(xpGain))
            end
            
            if currentLevel > previousLevel then
                xPlayer.showNotification(('🎉 ~g~Félicitations ! Vous êtes maintenant niveau %s !~s~'):format(currentLevel))
                xPlayer.showNotification('~y~Vos temps d\'attente sont maintenant plus courts !~s~')
            end
        end)
    end)
end)