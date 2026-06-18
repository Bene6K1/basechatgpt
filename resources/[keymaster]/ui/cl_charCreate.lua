isInCreatorMenu = false

RegisterNetEvent("esx:charCreator:start", function()
end)

RegisterNetEvent("esx:charCreator:finish", function()
end)

--[[RegisterNetEvent("Crea:OP")
AddEventHandler("Crea:OP", function() 
    
    isInCreatorMenu = false
    TriggerEvent('ui:toggleBasicHUD', true)
    SetEntityCoords(GetPlayerPed(-1), 691.727478, 242.360444, 93.393432)
    SetEntityHeading(GetPlayerPed(-1), 238.11022949218)

end)]]--