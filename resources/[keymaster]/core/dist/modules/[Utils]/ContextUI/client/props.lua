local garbageProps = { 1437508529, 666561306, -58485588, 218085040, -1426008804, -206690185, 1143474856, -130812911, 1614656839, 1511880420, 1329570871, -1096777189, -2096124444 }
local fridgeProps = {
    GetHashKey("v_res_fridgemoda"),
    GetHashKey("v_res_fridgemodsml"),
    GetHashKey("prop_fridge_01"),
    GetHashKey("prop_fridge_03"),
    GetHashKey("prop_vend_fridge01"),
}

Citizen.CreateThread(function ()
    exports.ox_target:addModel(distributorProps, {
        {
            label = "Retirer",
            icon = "fa-solid fa-wallet",
            distance = 5.0,
            canInteract = function ()
                return true
            end,
            onSelect = function (data)
                local input = ESX.GetNumberInput("Montant")
                if input == nil then
                    return ESX.ShowNotification("~r~Le montant ne peut pas être nul")
                end

                if input <= 0 then
                    return ESX.ShowNotification("~r~Erreur lors de la transaction")
                end

                TriggerServerEvent('bank:withdraw', input)
            end
        },
        {
            label = "Déposer",
            icon = "fa-solid fa-wallet",
            distance = 5.0,
            canInteract = function ()
                return true
            end,
            onSelect = function (data)
                local input = ESX.GetNumberInput("Montant")
                if input == nil then
                    return ESX.ShowNotification("~r~Le montant ne peut pas être nul")
                end

                if input <= 0 then
                    return ESX.ShowNotification("~r~Erreur lors de la transaction")
                end

                TriggerServerEvent('bank:deposit', input)
            end
        }
    })
    exports.ox_target:addGlobalObject({
        {
            label = "Supprimer l'objet",
            icon = "fa-solid fa-asterisk",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                local entity = data.entity
                if DoesEntityExist(entity) then
                    if IsEntityAttached(entity) then
                        DetachEntity(entity, false, false)
                    end
                    SetEntityAsMissionEntity(entity, true, true)
                    DeleteEntity(entity)
                    if DoesEntityExist(entity) then
                        NetworkRequestControlOfEntity(entity)
                        DeleteEntity(entity)
                    end
                end
            end
        },
        {
            label = "S'allonger sur le lit",
            icon = "fa-solid fa-bed",
            canInteract = function(data)
                local entity = type(data) == "table" and data.entity or data
                
                if not entity or entity == 0 or not DoesEntityExist(entity) then 
                    return false 
                end
                
                local success, model = pcall(function()
                    return GetEntityModel(entity)
                end)
                
                if success and model then
                    return model == -1353949751
                end
                
                return false
            end,
            onSelect = function(data)
                local entity = type(data) == "table" and data.entity or data
                local playerPed = PlayerPedId()
                TaskStartScenarioAtPosition(playerPed, "WORLD_HUMAN_SUNBATHE_BACK", GetEntityCoords(entity), GetEntityHeading(entity), 0, true, false)
                ESX.ShowNotification("Vous êtes allongé sur le lit.")
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0)
                        if IsControlJustPressed(0, 73) then
                            ClearPedTasksImmediately(playerPed)
                            ESX.ShowNotification("Vous vous êtes levé du lit.")
                            break
                        end
                    end
                end)
            end
        }
    })
end)
