


    UTILS = {}
    
    UTILS.ServerColor = {
        r = SunnyConfigServ.R,
        g = SunnyConfigServ.G,
        b = SunnyConfigServ.B,
        o = SunnyConfigServ.A
    }

	UTILS.LOGOURL = SunnyConfigServ.LogoUrl

	UTILS.COLORCODE = SunnyConfigServ.GTACOLOR


RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    TriggerClientEvent('SunnyUdatePly', source, GetNumPlayerIndices())
end)


CreateThread(function()
    while (true) do
        TriggerClientEvent('SunnyUdatePly', -1, GetNumPlayerIndices())

        Wait(10000)
    end
end)