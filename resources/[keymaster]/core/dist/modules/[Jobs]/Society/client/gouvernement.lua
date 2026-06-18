local gouvernement = {
    Position = {
        office = vector3(-568.95983886719, -199.2311706543, 38.213665008545)
    },
    InService = false
}

CreateThread(function()
    while not ESXLoaded do Wait(1) end
    local interval = 2000
    while true do
        Wait(interval)

        interval = 2000

        if ESX.PlayerData.job.name == 'gouvernement' then
            local playerPos = GetEntityCoords(PlayerPedId())
            local officePos = #(playerPos-gouvernement.Position.office)

            if officePos > 10 then goto continue end

            interval = 1

            DrawMarker(25, gouvernement.Position.office.x, gouvernement.Position.office.y, gouvernement.Position.office.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, tonumber(UTILS.ServerColor.r), tonumber(UTILS.ServerColor.g), tonumber(UTILS.ServerColor.b), 255, false, false, 2, false, false, false, false)

            if officePos < 1.5 then
                DrawInstructionBarNotification(gouvernement.Position.office.x, gouvernement.Position.office.y, gouvernement.Position.office.z, ("pour intéragir"):format(UTILS.COLORCODE))
                if IsControlJustPressed(1,51) then
                    gouvernement:openOfficeMenu()
                end
            end

            ::continue::
        end
    end
end)

function gouvernement:openOfficeMenu()
    if not Society then return end
    
    local main = RageUI.CreateMenu('', 'Actions Disponibles')
    local taxesMenu = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local te = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(PlayerPedId(), true)
    
    while main do Wait(1)
        RageUI.IsVisible(main, function()

            if Society.List[ESX.PlayerData.job.name] then
                RageUI.Checkbox('Statut de l\'entreprise', 'Quand cette case est cochée votre ENTREPRISE est notée comme ouverte', Society.List[ESX.PlayerData.job.name].state, {}, {
                    onChecked = function()
                        TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                    end,
                    onUnChecked = function()
                        TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                    end
                })
            end

            RageUI.Button("Montrer son badge", nil, {}, true, {
                onSelected = function()
                ShowJobBadge(ESX.PlayerData.job.name)
                end
                })
                RageUI.Button('Annonce', nil, {}, true, {
                    onSelected = function()
                        local input = ESX.GetTextareaInput("Écrivez votre message")
                        if input == nil then
                            return ESX.ShowNotification("~r~Le message ne peut pas être nul")
                        end
    
                        TriggerServerEvent("sunny:gouv:annonce", input)
                    end
                })
            RageUI.Button('Gérer les taxes des sociétés', nil, {}, true, {
                onSelected = function()
                    
                end
            }, taxesMenu)
            RageUI.Button('Gérer les remises des sociétés publiques', nil, {}, true, {
                onSelected = function()
                    
                end
            }, te)
        end)

        RageUI.IsVisible(te, function()
            local jobs = {
                ['police'] = true,
                ['ambulance'] = true,
                ['bcso'] = true,
                ['gouvernement'] = false,
            }
        
            for k,v in pairs(Society.List) do
                if jobs[v.name] then
                    RageUI.Button(('%s | %s'):format(v.name, v.label), '\n~r~Remises effectuées toutes les heures~s~\n', {RightLabel = ('~y~%s%s~s~'):format(v.tax, '$')}, true, {
                        onActive = function()
                            RageUI.Info('Informations de la société', {'Argent de la société'}, {'~g~'..v.coffre['accounts'].society..'$~s~'})
                        end,
                        onSelected = function()
                            KeyboardUtils.use('Nouvelle taxe', function(data)
                                local data = tonumber(data)
    
                                if not data then return end
    
                                if data > 200000 then return ESX.ShowNotification('Vous ne pouvez pas mettre une taxe supérieur à ~r~200000$~s~') end
    
                                data = data
    
                                    exports['prompt']:createPrompt(
                                        SunnyConfigServ.ServerName,
                                        'Voulez-vous valider la nouvelle taxe ?',
                                        '',
                                        function(response)
                                            if response then -- Oui
                                                TriggerServerEvent('sunny:society:gouvernement:editTax2', v.name, data)
                                            else -- Non
                                                ESX.ShowNotification('Action annulée')
                                            end
                                        end
                                    )
                            end)
                        end
                    })
                end
            end
        end)

        RageUI.IsVisible(taxesMenu, function()
            local jobs = {
                ['police'] = true,
                ['ambulance'] = true,
                ['bcso'] = true,
                ['gouvernement'] = false,
            }
            for k,v in pairs(Society.List) do
                if not jobs[v.name] then
                    RageUI.Button(('%s | %s'):format(v.name, v.label), '\n~r~Taxes prélevées toutes les jours~s~\n', {RightLabel = ('~y~%s%s~s~'):format(v.tax, '%')}, true, {
                        onActive = function()
                            RageUI.Info('Informations de la société', {'Argent de la société'}, {'~g~'..v.coffre['accounts'].society..'$~s~'})
                        end,
                        onSelected = function()
                            KeyboardUtils.use('Nouvelle taxe', function(data)
                                local data = tonumber(data)
    
                                if not data then return end
    
                                if data > 10 then return ESX.ShowNotification('Vous ne pouvez pas mettre une taxe supérieur à ~r~10%~s~') end
    
                                data = data
    
                                    exports['prompt']:createPrompt(
                                        SunnyConfigServ.ServerName,
                                        'Voulez-vous valider la nouvelle taxe ?',
                                        '',
                                        function(response)
                                            if response then -- Oui
                                                TriggerServerEvent('sunny:society:gouvernement:editTax', v.name, data)
                                            else -- Non
                                                ESX.ShowNotification('Action annulée')
                                            end
                                        end
                                    )

                            end)
                        end
                    })
                end
            end
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(taxesMenu) and not RageUI.Visible(te) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(PlayerPedId(), false)
            break
        end
    end
end