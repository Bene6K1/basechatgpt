

RegisterNetEvent("creator:onValidate", function(data, skin)
    local source = source
    local player = ESX.GetPlayerFromId(source)
    if not player then return end
    
    local sexVal = "0"
    if data and (data.gender == "female" or data.gender == 1 or data.gender == "1" or data.gender == "f") then
        sexVal = "1"
    end
    
    MySQL.update('UPDATE users SET firstname = ?, lastname = ?, dateofbirth = ?, height = ?, sex = ?, skin = ? WHERE identifier = ?',
        {
            data.firstName or "Inconnu",
            data.lastName or "Inconnu", 
            data.date or "01/01/2000",
            data.size or 180,
            sexVal,
            skin or "{}",
            player.identifier
        }, function(affectedRows)
            if affectedRows > 0 then
                player.set('firstname', data.firstName or "Inconnu")
                player.set('lastname', data.lastName or "Inconnu")
                player.set('dateofbirth', data.date or "01/01/2000")
                player.set('height', data.size or 180)
                player.set('sex', sexVal)
                
                if skin then
                    local skinData = json.decode(skin)
                    if skinData then
                        player.set('skin', skinData)
                    end
                end
                if Config.StartingMoney then
                    if Config.StartingMoney.cash and Config.StartingMoney.cash > 0 then
                        player.addAccountMoney('cash', Config.StartingMoney.cash)
                    end
                    
                    if Config.StartingMoney.bank and Config.StartingMoney.bank > 0 then
                        player.addAccountMoney('bank', Config.StartingMoney.bank)
                    end
                end
                
                if GetResourceState('nv_clothes') == 'started' and skin then
                    SetTimeout(1000, function()
                        local skinData = json.decode(skin)
                        if skinData then
                            TriggerEvent('nv_clothes:createItemsFromSkin', source, skinData)
                        end
                    end)
                end
                
                TriggerEvent("engine:enterspawn:finish", source)
                TriggerClientEvent("creator:onReset", source)
            else
            end
        end
    )
end)

RegisterNetEvent("addBucket", function()
    local source = source
    Manage:SetPlayerInPlace(source)
end)

RegisterNetEvent("removeBucket", function()
    local source = source
    Manage:ResetPlayerInstance(source)
end)