if not lib then return end

local isUILoaded = false
local preloadData = nil

local function preloadUI()
    if isUILoaded then return end
    
    SendNUIMessage({
        action = 'preload',
        data = {}
    })
    
    isUILoaded = true
end

RegisterNetEvent('esx:playerLoaded', function()
    Wait(2000)
    preloadUI()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    Wait(3000)
    preloadUI()
end)

RegisterNUICallback('uiPreloaded', function(data, cb)
    isUILoaded = true
    cb('ok')
end)

exports('isUILoaded', function()
    return isUILoaded
end)

