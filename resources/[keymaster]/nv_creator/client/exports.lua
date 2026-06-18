exports("enterSpawn", function()
    if not ESX then
        return
    end
    
    local xPlayer = ESX.GetPlayerData()
    
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin == nil or json.encode(skin) == '[]' then
            initCreator(xPlayer)
        else
        end
    end)
end)

exports("hasFinishEnterSpawn", function()
    return true
end)

exports("forceCreator", function()
    initCreator(nil)
end)

exports("isCreatorActive", function()
    return isInCreator
end)