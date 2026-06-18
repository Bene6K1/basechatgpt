RegisterCommand('showInfo', function(source, args, rawCommand)
    local _source = source
    local title = 'Informations Chasse'
    local info = {
        {title = 'Experience', subtitle = ('%s/1000'):format(500)},
        {title = 'Animaux', subtitle = ('%s'):format('\n' .. table.concat({'Lapin', 'Cerf'}, ", "))}
    }
    TriggerClientEvent('ui:drawInfo', _source, title, info)
end, false)

RegisterCommand('hideInfo', function(source, args, rawCommand)
    local _source = source
    TriggerClientEvent('ui:hideInfo', _source)
end, false)

RegisterCommand('HideInfo', function(source, args, rawCommand)
    local _source = source
    TriggerClientEvent('ui:hideInfo', _source)
end, false)
