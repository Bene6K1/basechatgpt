local onlinePlayers = 0

RegisterNetEvent('SunnyUdatePly')
AddEventHandler('SunnyUdatePly', function(int)
	onlinePlayers = int
end)


AddEventHandler("esx:playerLoaded", function(xPlayer)
    while ESX == nil do Wait(1) end

    AddTextEntry('FE_THDR_GTAO', ('%s%s ~w~Rôleplay~w~ | ID Unique : '..SunnyConfigServ.GTACOLOR .. xPlayer.UniqueID.. ' ~w~| Joueurs : '..SunnyConfigServ.GTACOLOR .. onlinePlayers .. ' ~w~| Pseudo : '..SunnyConfigServ.GTACOLOR .. GetPlayerName(Player.playerId)):format(SunnyConfigServ.GTACOLOR, SunnyConfigServ.ServerName))


    --if xPlayer.identifier == 'license:3b00bf052be99af33a5a68716228b98ed91b9342' or xPlayer.identifier == 'license:73368238ecbb5c69a2768471824aea691c9f16fe' then 
    --    return 
    --end
    SetDiscordAppId(SunnyConfigServ.AppId)
    SetDiscordRichPresenceAsset(SunnyConfigServ.Asset1)
    SetDiscordRichPresenceAssetSmall(SunnyConfigServ.Asset2)
    SetDiscordRichPresenceAssetSmallText(SunnyConfigServ.Text)
    SetRichPresence(("[%s] %s | %s/%s"):format(xPlayer.UniqueID, GetPlayerName(PlayerId()), onlinePlayers, SunnyConfigServ.Slots))
    SetDiscordRichPresenceAction(0, "Discord", (SunnyConfigServ.Discord))
    SetDiscordRichPresenceAction(1, "Se-Connecter", (SunnyConfigServ.CfxConnect))
end)

Citizen.CreateThread(function()
    while true do 
        Wait(45000)

        SetRichPresence(("[%s] %s | %s/%s"):format(Player.UniqueID, GetPlayerName(PlayerId()), onlinePlayers, SunnyConfigServ.Slots))
    end
end)

exports('getPlayersCount', function()
    return onlinePlayers
end)
