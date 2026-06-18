local function Gouvernement_openF6()
    local main = RageUI.CreateMenu('', 'Menu Gouvernement')
    local interactMenu = RageUI.CreateSubMenu(main, '', 'Menu Intéractions')
    local fouilleMenu = RageUI.CreateSubMenu(interactMenu, '', 'Menu Fouille')
    local vehicleMenu = RageUI.CreateSubMenu(main, '', 'Menu Véhicule')

    RageUI.Visible(main, not RageUI.Visible(main))

    while main do
        Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Checkbox('Statut de l\'entreprise', nil, EntrepriseState, {}, {
                onChecked = function()
                    EntrepriseState = true
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                end,
                onUnChecked = function()
                    EntrepriseState = false
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                end
            })

            RageUI.Checkbox('Service Gouvernement', nil, ServiceState, {}, {
                onChecked = function()
                    ServiceState = true
                    TriggerServerEvent('sunny:gouvernement:service', true)
                end,
                onUnChecked = function()
                    ServiceState = false
                    TriggerServerEvent('sunny:gouvernement:service', false)
                end
            })

            if ServiceState then
                RageUI.Button("Montrer son badge", nil, {}, true, {
                    onSelected = function()
                        ShowJobBadge('gouvernement')
                    end
                })

                RageUI.Button('Intéractions avec une personne', nil, {}, true, {}, interactMenu)
                RageUI.Button('Intéractions avec un véhicule', nil, {}, true, {}, vehicleMenu)

                RageUI.Button('Demande de renfort', nil, {}, true, {
                    onSelected = function()
                        local coords = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent('sunny:gouvernement:renforts', coords, 'importante')
                    end
                })
            end
        end)

        RageUI.IsVisible(interactMenu, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
            RageUI.Button("Carte d'identité", nil, {}, true, {
                onSelected = function()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(closestPlayer), GetPlayerServerId(PlayerId()))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })

            RageUI.Button('Fouiller', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then 
                        return ESX.ShowNotification('Personne aux alentours')
                    end
                    
                    if ESX.isHandsUp(GetPlayerPed(closestPlayer)) then
                        ESX.TriggerServerCallback('sunny:gouvernement:search', function(data)
                            SearchData = data
                        end, GetPlayerServerId(closestPlayer))
                    else
                        return ESX.ShowNotification('🤚✋La personne doit ~r~lever les mains~s~ pour être fouillée')
                    end
                end
            }, fouilleMenu)

            RageUI.Button('Menotter/Démenotter', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then 
                        return ESX.ShowNotification('Personne aux alentours')
                    end
                    TriggerServerEvent('sunny:gouvernement:menotter', GetPlayerServerId(closestPlayer))
                end
            })

            RageUI.Button('Escorter', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then 
                        return ESX.ShowNotification('Personne aux alentours')
                    end
                    TriggerServerEvent('sunny:gouvernement:escorter', GetPlayerServerId(closestPlayer))
                end
            })
        end)

        RageUI.IsVisible(fouilleMenu, function()
            if SearchData then
                RageUI.Separator('↓ Argent ↓')
                RageUI.Button('Argent liquide', nil, {RightLabel = SearchData.cash..' $'}, true, {})
                RageUI.Button('Argent sale', nil, {RightLabel = SearchData.black_money..' $'}, true, {})
                
                RageUI.Separator('↓ Objets ↓')
                for k,v in pairs(SearchData.inventory) do
                    if v.count > 0 then
                        RageUI.Button(v.label, nil, {RightLabel = v.count}, true, {
                            onSelected = function()
                                local count = KeyboardInput('Combien voulez-vous en prendre ?', '', 2)
                                if count ~= nil then
                                    count = tonumber(count)
                                    if count <= v.count then
                                        TriggerServerEvent('sunny:gouvernement:removeItem', count, v.name, SearchData.id, v.label)
                                    end
                                end
                            end
                        })
                    end
                end
            end
        end)

        RageUI.IsVisible(vehicleMenu, function()
            RageUI.Button('Mettre dans le véhicule', nil, {}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('sunny:gouvernement:putinvehicule', GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification('Aucun joueur à proximité')
                    end
                end
            })

            RageUI.Button('Sortir du véhicule', nil, {}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('sunny:gouvernement:outvehicule', GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification('Aucun joueur à proximité')
                    end
                end
            })
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(interactMenu) and not RageUI.Visible(fouilleMenu) and not RageUI.Visible(vehicleMenu) then
            main = RMenu:DeleteType('main')
        end
    end
end

RegisterCommand('F6_Gouvernement', function()
    if ESX.PlayerData.job.name ~= 'gouvernement' then return end
    Gouvernement_openF6()
end)

RegisterKeyMapping('F6_Gouvernement', 'Menu Intéractions Gouvernement', 'keyboard', 'F6')

RegisterNetEvent('sunny:gouvernement:menotter', function()
    local playerPed = PlayerPedId()
    IsHandcuffed = not IsHandcuffed

    if IsHandcuffed then
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Wait(100)
        end

        TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        SetEnableHandcuffs(playerPed, true)
        DisablePlayerFiring(playerPed, true)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        SetPedCanPlayGestureAnims(playerPed, false)
        FreezeEntityPosition(playerPed, true)
    else
        ClearPedSecondaryTask(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        SetPedCanPlayGestureAnims(playerPed, true)
        FreezeEntityPosition(playerPed, false)
    end
end)

RegisterNetEvent('sunny:gouvernement:renforts', function(coords, type)
    if ESX.PlayerData.job.name ~= 'gouvernement' then return end
    if not ServiceState then return end

    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)

    ESX.ShowAdvancedNotification('GOUVERNEMENT', '~b~Demande de renfort', 'Un agent gouvernemental demande du renfort.\nRépondez rapidement !', 'CHAR_CALL911', 1)

    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, 46)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Renfort Gouvernement")
    EndTextCommandSetBlipName(blipId)
    
    Wait(80 * 1000)
    RemoveBlip(blipId)
end)
