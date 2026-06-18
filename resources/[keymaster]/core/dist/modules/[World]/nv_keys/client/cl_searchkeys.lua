-- Search/hotwire system disabled per new gameplay rules

function GetKeySearchEnabled()
    return false
end

function DisableKeySearch()
end

function EnableKeySearch()
end

RegisterNetEvent(Scriptname .. ':client:startKeySearch', function()
    Notify.SendNotify('Rendez-vous chez le serrurier pour obtenir vos clés.', 'info', 3500)
end)