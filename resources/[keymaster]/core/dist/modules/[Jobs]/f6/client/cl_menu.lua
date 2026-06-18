local Jobs = {
    -- Boites de nuit
    {name = "boite_pacific", label = "Pacific Bluffs"},
    {name = "boite_unicorn", label = "Unicorn"},
    {name = "boite_wiwang", label = "WiWang"},

    -- Bars
    {name = "bar_tequila", label = "WiWang"},
    {name = "bar_beachclub", label = "WiWang"},

    -- Restaurants
    {name = "restau_burgershot", label = "Burgershot"},
    {name = "restau_catcafe", label = "CatCafe"},
    {name = "restau_pearls", label = "Pearls"},
    {name = "restau_pops", label = "Pop's Diner"}
}

FARM = {
    Service = {},
    CompanyStatus = {}
}

if not Society then
    Society = { List = {} }
end

for _, job in ipairs(Jobs) do
    FARM.Service[job.name] = false
    FARM.CompanyStatus[job.name] = false
end

RegisterNetEvent('sunny:society:sendList')
AddEventHandler('sunny:society:sendList', function(societyList)
    --print("^6[DEBUG F6] Réception de la liste des sociétés:", json.encode(societyList, {indent = true}))
    Society.List = societyList
end)

RegisterNetEvent('sunny:society:setSocietyState')
AddEventHandler('sunny:society:setSocietyState', function(societyName, state)
    if Society.List[societyName] then
        Society.List[societyName].state = state
    end
end)

function Farm_openF6()
    if not Society or not Society.List then
        ESX.ShowNotification('Système d\'entreprise en cours de chargement...')
        return 
    end
    
    local jobName = ESX.PlayerData.job.name
    
    local main = RageUI.CreateMenu('', 'Menu Intéractions')
    local subMenu = RageUI.CreateSubMenu(main, '', 'Menu Annonces')

    RageUI.Visible(main, not RageUI.Visible(main))
    
    while main do Wait(1)
        
        RageUI.IsVisible(main, function()
            local jobName = ESX.PlayerData.job.name
            local jobLabel = ESX.PlayerData.job.label
            
            if Society.List[jobName] then
                -- print("^2[DEBUG F6] Affichage du checkbox pour:", jobName, "État:", Society.List[jobName].state)
                RageUI.Checkbox('Statut de l\'entreprise', 'Quand cette case est cochée votre ENTREPRISE est notée comme ouverte', Society.List[jobName].state, {}, {
                    onChecked = function()
                        -- print("^2[DEBUG F6] Checkbox coché pour:", jobName)
                        TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                    end,
                    onUnChecked = function()
                        -- print("^2[DEBUG F6] Checkbox décoché pour:", jobName)
                        TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                    end
                })
            else
                --print("^1[DEBUG F6] Pas de société trouvée pour:", jobName)
                --print("^1[DEBUG F6] Sociétés disponibles:", json.encode(Society.List))
            end

            RageUI.Checkbox('Service '..ESX.PlayerData.job.label, nil, FARM.Service[ESX.PlayerData.job.name], {}, {
                onChecked = function()
                    FARM.Service[ESX.PlayerData.job.name] = true
                    TriggerServerEvent('sunny:FARM:service', ESX.PlayerData.job.name)
                end,
                onUnChecked = function()
                    FARM.Service[ESX.PlayerData.job.name] = false
                    TriggerServerEvent('sunny:FARM:service', ESX.PlayerData.job.name)
                end
            })

            if FARM.Service[ESX.PlayerData.job.name] then
                RageUI.Line()

                if string.find(ESX.PlayerData.job.name, "boite_") then
                    RageUI.Button('Menu Annonces', nil, {RightLabel = "→"}, true, {}, subMenu)
                end

                RageUI.Button('Faire une facture', nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance == -1 or distance > 3 then 
                            ESX.ShowNotification('Personne à proximité')
                            return 
                        end
                        
                        KeyboardUtils.use('Montant', function(amount)
                            amount = tonumber(amount)
                            if not amount or amount <= 0 then return end
                            TriggerServerEvent('esx_billing:sendBill', 
                                GetPlayerServerId(player), 
                                ('society_%s'):format(ESX.PlayerData.job.name),
                                ESX.PlayerData.job.label, 
                                amount
                            )
                        end)
                    end
                })

                RageUI.Button('Faire une annonce personnalisée', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Contenu', function(msg)
                            if not msg then return end
                            TriggerServerEvent('business:Announce', ESX.PlayerData.job.name, "custom", msg)
                        end)
                    end
                })
            end
        end)

        RageUI.IsVisible(subMenu, function()
            if string.find(ESX.PlayerData.job.name, "boite_") then
                RageUI.Button('Annoncer l\'ouverture', nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('business:Announce', ESX.PlayerData.job.name, "open")
                    end
                })

                RageUI.Button('Annoncer la fermeture', nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('business:Announce', ESX.PlayerData.job.name, "close")
                    end
                })

                RageUI.Button('Annoncer une soirée', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Message de l\'annonce', function(msg)
                            if msg then
                                TriggerServerEvent('business:Announce', ESX.PlayerData.job.name, "party", msg)
                            end
                        end)
                    end
                })
            end
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(subMenu) then
            main = RMenu:DeleteType('main')
        end
    end
end

CreateThread(function()
    while not ESXLoaded do Wait(500) end
    Wait(2000)
    TriggerServerEvent('sunny:society:requestList')
end)

for _, job in ipairs(Jobs) do
    local cmdName = ('F6_%s'):format(job.name:gsub("_", ""):gsub("^%l", string.upper))
    
    RegisterCommand(cmdName, function()
        -- print("^5[DEBUG F6] Commande F6 déclenchée:", cmdName, "Job actuel:", ESX.PlayerData.job.name)
        if ESX.PlayerData.job.name == job.name then
            if not Society then
                -- print("^1[DEBUG F6] Society non chargé lors de l'ouverture du menu")
                ESX.ShowNotification('Système d\'entreprise en cours de chargement...')
                return
            end
            -- print("^2[DEBUG F6] Ouverture du menu F6 pour job:", job.name)
            Farm_openF6()
        else
            -- print("^1[DEBUG F6] Job ne correspond pas - Attendu:", job.name, "Actuel:", ESX.PlayerData.job.name)
        end
    end)
    
    RegisterKeyMapping(cmdName, ('Menu Intéractions %s'):format(job.label), 'keyboard', 'F6')
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    -- print("^6[DEBUG F6] Joueur chargé - Demande de la liste des sociétés...")
    Wait(3000)
    TriggerServerEvent('sunny:society:requestList')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    -- print("^6[DEBUG F6] Job changé vers:", job.name)
    Wait(1000)
    TriggerServerEvent('sunny:society:requestList')
end)

function FirefighterMenuopenMenu()
    local main = RageUI.CreateMenu('', 'Actions Disponibles')

    local jobName = nil

    if ESX and ESX.PlayerData and ESX.PlayerData.job then
        jobName = ESX.PlayerData.job.name
    end

    if jobName and jobName == 'firefighter' then
        RageUI.Visible(main, not RageUI.Visible(main))
        Citizen.CreateThread(function()
            while RageUI.Visible(main) do
                Wait(1)
                RageUI.IsVisible(main, function()
                    local jobName = ESX.PlayerData.job.name
                    local jobLabel = ESX.PlayerData.job.label

                    RageUI.Checkbox('Statut de l\'entreprise', 'Quand cette case est cochée votre ENTREPRISE est notée comme ouverte', Society.List[ESX.PlayerData.job.name].state, {}, {
                        onChecked = function()
                            TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                        end,
                        onUnChecked = function()
                            TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                        end
                    })

                    RageUI.Button('Faire une annonce personnalisée', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Contenu', function(msg)
                                if not msg then return end
                                TriggerServerEvent('business:Announce', ESX.PlayerData.job.name, "custom", msg)
                            end)
                        end
                    })

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    RageUI.Button('Faire une facture', nil, {}, true, {
                        onSelected = function()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                KeyboardUtils.use('Montant', function(data)
                                    local amount = tonumber(data)
                                    if amount == nil or amount <= 0 then return end

                                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_'..jobName, (jobLabel), data)
                                end)
                            else
                                ESX.ShowNotification("Aucun joueur à proximité")
                            end
                        end
                    })
                end)
            end
        end)
    end
end

RegisterKeyMapping('firefighter_menu', 'Menu Pompier F6', 'keyboard', 'F6')

RegisterCommand('firefighter_menu', function()
    FirefighterMenuopenMenu()
end, false)


