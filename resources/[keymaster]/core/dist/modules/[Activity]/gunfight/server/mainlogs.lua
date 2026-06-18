
local remooveinventaire = "#"
local giveinventaire = "#"


RegisterServerEvent('wGunFight:LogJoueur')
AddEventHandler('wGunFight:LogJoueur', function(content)
    PerformHttpRequest(remooveinventaire, function(err, text, headers) end, 'POST', json.encode({username = "Menu Admin", embeds = content}), { ['Content-Type'] = 'application/json' })
end) 

RegisterServerEvent('wGunFight:LogJoueur2')
AddEventHandler('wGunFight:LogJoueur2', function(content)
    PerformHttpRequest(giveinventaire, function(err, text, headers) end, 'POST', json.encode({username = "Menu Admin", embeds = content}), { ['Content-Type'] = 'application/json' })
end) 