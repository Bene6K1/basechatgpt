local playersRob = {}

local inRob = {}

ESX.RegisterServerCallback('shopRobbery:canRob', function(source, cb, currentShopRobbery)
    if inRob[currentShopRobbery] then return cb('in_rob') end

    if playersRob[source] then return cb('already_rob_today') end

    cb(true)
end)

RegisterNetEvent('shopRobbery:start', function(rob)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    playersRob[source] = true
    inRob[rob] = true

    TriggerClientEvent('shopRobbery:start', source, rob)
    sendLog(('Le Joueur (%s - %s) viens de commencer un braquage superette'):format(xPlayer.name, xPlayer.UniqueID), {
        author = 'Superette',
        fields = {
            {title = 'Player', subtitle = xPlayer.name},
            {title = 'ID Unique', subtitle = xPlayer.UniqueID},
            {title = 'Identifier', subtitle = xPlayer.identifier},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'start_rob'
    })
end)

RegisterNetEvent('shopRobbery:cancelRobbery', function(rob)
    local source = source

    playersRob[source] = false

    TriggerClientEvent('shopRobbery:exit', source, rob)
end)

RegisterNetEvent('shopRobbery:endRobbery', function(shopId)
    local source = source
    local player = ESX.GetPlayerFromId(source)

    if not player then return end

    player.addAccountMoney('black_money', 7542)

    playersRob[source] = false

    TriggerClientEvent('shopRobbery:exit', source, shopId)
    sendLog(('Le Joueur (%s - %s) viens de récupérer (7542$)'):format(player.name, player.UniqueID), {
        author = 'Superette',
        fields = {
            {title = 'Player', subtitle = player.name},
            {title = 'ID Unique', subtitle = player.UniqueID},
            {title = 'Identifier', subtitle = player.identifier},
            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
        },
        channel = 'end_rob'
    })
end)

RegisterNetEvent('shopRobbery:callPolice', function(street, shopId)
    local players = ESX.GetExtendedPlayers('job', 'police')

    for k,v in pairs(players) do
        TriggerClientEvent('esx:showNotification', v.source, 'Braquage en cours à '..street)

        TriggerClientEvent('police:fastCallCoords', v.source, CONFIG_SHOP_ROBBERY.Shops[shopId].pos.x, CONFIG_SHOP_ROBBERY.Shops[shopId].pos.y, CONFIG_SHOP_ROBBERY.Shops[shopId].pos.z)
    end
end)