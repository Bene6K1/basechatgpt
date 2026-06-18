
AddEventHandler('playerConnecting', function(_, _, deferrals)
    local source = source

    deferrals.defer()
    
    id = {}
    for i = 0, 20 do
        id[i] = GetPlayerIdentifier(source, i)
    end

    deferrals.handover({
        name = GetPlayerName(source),
        id = id
    })
end)