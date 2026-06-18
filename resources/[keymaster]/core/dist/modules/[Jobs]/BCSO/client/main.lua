local timerRenfort2 = true
local timerCode = true
local bcsoDisableCooldownsForTests = true

local dispatchSettings = (Sunnybcso and Sunnybcso.bcso and Sunnybcso.bcso.dispatch) or {}
local bcsoCodesIndex = {}
if Sunnybcso and Sunnybcso.bcso and Sunnybcso.bcso.codes then
    for idx, code in ipairs(Sunnybcso.bcso.codes) do
        local codeId = code.id or ('code_' .. idx)
        Sunnybcso.bcso.codes[idx].id = codeId
        bcsoCodesIndex[codeId] = code
    end
end

local defaultDispatchSounds = {
    {name = 'Start_Squelch', set = 'CB_RADIO_SFX'},
    {name = 'OOB_Start', set = 'GTAO_FM_Events_Soundset'},
    {name = 'FocusIn', set = 'HintCamSounds'}
}

local dispatchColorMap = {
    white = 0,
    orange = 47,
    red = 1,
    yellow = 5,
    blue = 38,
    purple = 7,
    green = 2
}

local function bcsoIsActionAvailable(timerValue)
    if bcsoDisableCooldownsForTests then return true end
    return timerValue
end

local function bcsoStartRenfortCooldown()
    if bcsoDisableCooldownsForTests then return end
    timerRenfort2 = false
    Citizen.SetTimeout(120000, function()
        timerRenfort2 = true
    end)
end

local function bcsoStartCodeCooldown()
    if bcsoDisableCooldownsForTests then return end
    timerCode = false
    Citizen.SetTimeout(120000, function()
        timerCode = true
    end)
end

local function bcsoGetDispatchSounds()
    if dispatchSettings.sounds and #dispatchSettings.sounds > 0 then
        return dispatchSettings.sounds
    end
    return defaultDispatchSounds
end

local function bcsoPlayDispatchSounds()
    for _, sound in ipairs(bcsoGetDispatchSounds()) do
        if sound.name and sound.set then
            PlaySoundFrontend(-1, sound.name, sound.set, 1)
        end
    end
end

local function bcsoResolveColor(colorName)
    if not colorName then return 0 end
    local key = string.lower(colorName)
    return dispatchColorMap[key] or 0
end

local function bcsoGetBlipSettings(blipType)
    local defaults = {
        codes = {sprite = 161, scale = 1.05, duration = 45000},
        renforts = {sprite = 161, scale = 1.2, duration = 80000}
    }
    if dispatchSettings.blips and dispatchSettings.blips[blipType] then
        return {
            sprite = dispatchSettings.blips[blipType].sprite or defaults[blipType].sprite,
            scale = dispatchSettings.blips[blipType].scale or defaults[blipType].scale,
            duration = dispatchSettings.blips[blipType].duration or defaults[blipType].duration
        }
    end
    return defaults[blipType]
end

local function bcsoCreateAlertBlip(coords, label, colorName, blipType)
    if not coords then return end
    local settings = bcsoGetBlipSettings(blipType or 'codes')
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, settings.sprite)
    SetBlipScale(blip, settings.scale)
    SetBlipColour(blip, bcsoResolveColor(colorName))
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label or 'Code radio')
    EndTextCommandSetBlipName(blip)
    Citizen.SetTimeout(settings.duration, function()
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end)
end

local function bcsoFormatLocation(coords)
    if not coords then return 'Localisation : inconnue' end
    local streetHash, crossingHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = (streetHash ~= 0 and GetStreetNameFromHashKey(streetHash)) or 'Secteur inconnu'
    local crossingName = (crossingHash ~= 0 and GetStreetNameFromHashKey(crossingHash)) or nil
    local zone = GetNameOfZone(coords.x, coords.y, coords.z)
    local zoneLabel = ''
    if zone and zone ~= '' then
        local label = GetLabelText(zone)
        if label and label ~= 'NULL' then
            zoneLabel = label
        end
    end
    local location = crossingName and (('%s / %s'):format(streetName, crossingName)) or streetName
    if zoneLabel ~= '' then
        location = ('%s (%s)'):format(location, zoneLabel)
    end
    return ('Localisation : %s'):format(location)
end

local function bcsoDispatchOfficerLine(sender)
    if sender and sender ~= '' then
        return ('Unité : %s'):format(sender)
    end
    local officerName = GetPlayerName(PlayerId())
    return ('Unité : %s'):format(officerName)
end

local function bcsoBuildDispatchText(message, extraLines, coords, sender)
    local lines = {}
    if message then table.insert(lines, message) end
    if extraLines then
        for _, line in ipairs(extraLines) do
            table.insert(lines, line)
        end
    end
    if coords then
        table.insert(lines, bcsoFormatLocation(coords))
    end
    table.insert(lines, bcsoDispatchOfficerLine(sender))
    return table.concat(lines, '\n')
end

local function bcsoToVector(coords)
    if type(coords) == 'table' and coords.x and coords.y and coords.z then
        return vector3(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0)
    end
    return coords
end

local function bcsoHandleCodeAlert(payload)
    local coords = bcsoToVector(payload.coords)
    local codeData = payload.codeId and bcsoCodesIndex[payload.codeId] or nil
    local notificationTitle = (codeData and codeData.dispatch and codeData.dispatch.title) or (codeData and codeData.buttonName) or 'Code radio'
    local notificationMessage = bcsoBuildDispatchText(
        payload.message or (codeData and codeData.message),
        codeData and codeData.dispatch and codeData.dispatch.extraLines,
        coords,
        payload.sender
    )

    bcsoPlayDispatchSounds()
    if coords then
        bcsoCreateAlertBlip(coords, codeData and codeData.buttonName or notificationTitle, codeData and codeData.dispatch and codeData.dispatch.circleColor or 'white', 'codes')
    end
    ESX.ShowAdvancedNotification('Centrale BCSO', notificationTitle, notificationMessage, 'CHAR_CALL911', 7)
end

local function bcsoHandleRenfortAlert(payload)
    if not payload then return end
    if not dispatchSettings or not dispatchSettings.renforts then return end
    local info = dispatchSettings.renforts[payload.type] or {}
    local coords = bcsoToVector(payload.coords)
    local message = bcsoBuildDispatchText(info.message, info.extraLines, coords, payload.sender)
    bcsoPlayDispatchSounds()
    if coords then
        bcsoCreateAlertBlip(coords, info.title or 'Demande de renfort', info.circleColor or 'orange', 'renforts')
    end
    ESX.ShowAdvancedNotification('Centrale BCSO', info.title or 'Demande de renfort', message, 'CHAR_CALL911', 7)
end
function bcso_openVestiaire()
    local main = RageUI.CreateMenu('', 'Actions Disponibles')

    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(PlayerPedId(), true)
    while main do Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Button('Reprendre sa tenue', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end
            })
            RageUI.Line()
            for k,v in pairs(Sunnybcso.bcso.cloakroom) do
                RageUI.Button(v.label, nil, {RightLabel = '>>'}, ESX.PlayerData.job.grade >= v.required_grade, {
                    onSelected = function()
                        local model = GetEntityModel(PlayerPedId())
    
                        if model == GetHashKey("mp_m_freemode_01") then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadClothes', skin, v.Data.homme)
                            end) 
                        elseif model ~= GetHashKey("mp_f_freemode_01") then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadClothes', skin, v.Data.femme)
                            end) 
                        end
                    end
                })
            end
        end)

        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

RegisterNetEvent('sunny:police:callDrugsnord', function(data)
    if ESX.PlayerData.job.name ~= 'saspn' then return end
    if not Sunnybcso.bcso.Service then return end
    table.insert(callsDrugs, {
        pos = data.pos
    })

    last[data.pos] = nil

    for k,v in pairs(callsDrugs) do
        if v.pos == data.pos then
            last[data.pos] = k
        end
    end

    ESX.ShowNotification(SunnyConfigServ.GTACOLOR..'[CENTRAL]~s~\nNouvelle alerte vente de drogue')

    SetTimeout(60000, function()
        table.remove(callsDrugs, last[data.pos])
    end)
end)

function bcso_openF6()
    local main = RageUI.CreateMenu('', 'Menu Intéractions')
    local interactMenu = RageUI.CreateSubMenu(main, '', 'Menu Intéractions')
    local billMenu = RageUI.CreateSubMenu(interactMenu, '', 'Menu Amendes')
    local fouilleMenu = RageUI.CreateSubMenu(interactMenu, '', 'Menu Fouille')
    local playerAmenderbcso = RageUI.CreateSubMenu(interactMenu, '', 'Actions Disponibles')
    local vehicleMenu = RageUI.CreateSubMenu(main, '', 'Menu Intéractions Véhicule')
    local vehicleInfoWithPlate = RageUI.CreateSubMenu(vehicleMenu, '', 'Menu Intéractions Véhicule')

    local dogMenu  = RageUI.CreateSubMenu(main, '', 'Menu K9')

    local code = RageUI.CreateSubMenu(main, '', 'Menu Codes Radio')

    vehicleInfoWithPlate.Closed = function()
        ClearPedTasks(PlayerPedId())
    end

    RageUI.Visible(main, not RageUI.Visible(main))
    while main do Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Checkbox('Statut de l\'entreprise', 'Quand cette case est cochée votre ENTREPRISE est notée comme ouverte', Society.List[ESX.PlayerData.job.name].state, {}, {
                onChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                end,
                onUnChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                end
            })
            RageUI.Checkbox('Service BCSO', nil, Sunnybcso.bcso.Service, {}, {
                onChecked = function()
                    Sunnybcso.bcso.Service = true
                    TriggerServerEvent('sunny:bcso:service', Sunnybcso.bcso.Service)
                end,
                onUnChecked = function()
                    Sunnybcso.bcso.Service = false
                    TriggerServerEvent('sunny:bcso:service', Sunnybcso.bcso.Service)
                end
            })

            if Sunnybcso.bcso.Service then
                                RageUI.Button("Montrer son badge", nil, {}, true, {
                onSelected = function()
                ShowJobBadge(ESX.PlayerData.job.name)
                end
                })
                RageUI.Button('Intéractions Citoyen', nil, {}, true, {
                    onSelected = function()
                    end
                }, interactMenu)
                RageUI.Button('Intéractions Véhicule', nil, {}, true, {
                    onSelected = function()
                    end
                }, vehicleMenu)
                RageUI.Button('Intéractions K9', nil, {}, true, {
                    onSelected = function()
                        
                    end
                }, dogMenu)
                RageUI.Button('Codes Radio', nil, {}, true, {
                    onSelected = function()
                        
                    end
                }, code)
                RageUI.Line()
                RageUI.Button('Faire une annonce personnaliser', nil, {}, true, {
                    onSelected = function()
                        local jobName = ESX.PlayerData.job.name
                  KeyboardUtils.use('Contenu', function(msg)
                                if msg == nil then return end
                                TriggerServerEvent('monjob:annoncer', msg, jobName)
                            end)
                    end
                })
            end
        end)

        RageUI.IsVisible(interactMenu, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            RageUI.Button("Carte d'identité", nil, {}, true, {
                onSelected = function()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('Bcso:ForcerId', GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })
            RageUI.Button("Permis", nil, {}, true, {
                onSelected = function()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('Bcso:ForcerDrive', GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })
            RageUI.Button('Mettre une amende', nil, {}, true, {
                onSelected = function()
                end
            }, billMenu)
            RageUI.Button('Fouiller', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                    if ESX.isHandsUp(GetPlayerPed(closestPlayer)) then
                        ESX.TriggerServerCallback('sunny:bcso:search', function(cb)
                            if not cb then return ESX.ShowNotification('Une erreur est survenue') end
                            if cb then
                                Sunnybcso.bcso.fouille = cb
    
                                RageUI.Visible(fouilleMenu, true)
                            end
                        end, GetPlayerServerId(closestPlayer))
                    else
                        return ESX.ShowNotification('🤚✋La personne doit ~r~lever les mains~s~ pour être fouiller')
                    end
                end
            })
            RageUI.Button('Vérifier les amendes impayé', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end

                    playerAmende = {}

                    ESX.TriggerServerCallback('sunny:police:amendes', function(cb)
                        playerAmende = cb
                        RageUI.Visible(playerAmenderbcso, true)
                    end, GetPlayerServerId(closestPlayer))
                end
            })
            RageUI.Button('Menotter/Demenotter', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                    TriggerServerEvent('sunny:bcso:menotter', GetPlayerServerId(closestPlayer))
                end
            })
            RageUI.Button('Escorter', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                    TriggerServerEvent('sunny:bcso:escoter', GetPlayerServerId(closestPlayer))
                end
            })
            RageUI.Button('Mettre dans le véhicule', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end

                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetClosestVehicle(playerCoords)

                    local vehCoords = #(playerCoords-GetEntityCoords(vehicle))

                    if vehCoords > 5 then return ESX.ShowNotification('Aucun véhicule aux alentours') end

                    TriggerServerEvent('sunny:bcso:playerVehicle', GetPlayerServerId(closestPlayer), vehicle, 'put')
                end
            })
            RageUI.Button('Sortir du véhicule', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end

                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetClosestVehicle(playerCoords)

                    local vehCoords = #(playerCoords-GetEntityCoords(vehicle))

                    if vehCoords > 5 then return ESX.ShowNotification('Aucun véhicule aux alentours') end

                    TriggerServerEvent('sunny:bcso:playerVehicle', GetPlayerServerId(closestPlayer), vehicle, 'exit')
                end
            })
            RageUI.Button('Donner le PPA', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then
                        ESX.ShowNotification('Personne aux alentours')
                        return
                    end

                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir donner le PPA ? (Coût: 25 000$)',
                        '',
                        function(response)
                            if response then
                                TriggerServerEvent('sunny:bcso:ppa', GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification('Don du PPA annulé')
                            end
                        end
                    )
                end
            })
            RageUI.Button('Vérifier le PPA', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then
                        ESX.ShowNotification('Personne aux alentours')
                        return
                    end
                    TriggerServerEvent('Bcso:ForcerPPA', GetPlayerServerId(closestPlayer))
                end
            })

        end)
        RageUI.IsVisible(playerAmenderbcso, function()
            for k,v in pairs(playerAmende) do
                RageUI.Button(('%s (%s$)'):format(v.label, v.amount), nil, {}, true, {
                    onSelected = function()
                    end
                })
            end
        end)
        RageUI.IsVisible(billMenu, function()
            RageUI.Button('Amende Personnalisé', nil, {}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                    KeyboardUtils.use('Montant de l\'amande', function(data)
                        local data = tonumber(data)
                        if data == nil or data <= 0  then return end

                        TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)

                        SetTimeout(10000, function()
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_bcso', ('Sheriff (bcso)'), data)
                        end)
                    end)
                end
            })
            RageUI.Button('Rechercher', nil, {RightLabel = Sunnybcso.bcso.bill.Search or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Rechercher', function(data)
                        Sunnybcso.bcso.bill.Search = data
                    end)
                end
            })
            if Sunnybcso.bcso.bill.Search then
                RageUI.Button('❌ Arrêter la rechercher', nil, {}, true, {
                    onSelected = function()
                        Sunnybcso.bcso.bill.Search = nil
                    end
                })
            end
            RageUI.Line()
            for k,v in pairs(Sunnybcso.bcso.bill.Data) do
                local buttonName = v.reason
                if Sunnybcso.bcso.bill.Search then
                    if (string.match(string.lower(buttonName), string.lower(Sunnybcso.bcso.bill.Search))) then
                        RageUI.Button(buttonName, nil, {RightLabel = ('~y~%s$~s~'):format(v.price)}, true, {
                            onSelected = function()
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance == -1 or closestDistance > 3 then
                                    ESX.ShowNotification('Personne aux alentours')
                                    return
                                end
                                
                                exports['prompt']:createPrompt(
                                    SunnyConfigServ.ServerName,
                                    ('Voulez-vous facturer %s$ à %s ?'):format(v.price, GetPlayerName(closestPlayer)),
                                    '',
                                    function(response)
                                        if response then
                                            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                    
                                            SetTimeout(10000, function()
                                                ClearPedTasks(PlayerPedId())
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_bcso', 'Sheriff (bcso)', v.price)
                                            end)
                                        else
                                            ESX.ShowNotification('Facturation annulée')
                                        end
                                    end
                                )
                            end
                        })
                        
                    end 
                else
                    RageUI.Button(buttonName, nil, {RightLabel = ('~y~%s$~s~'):format(v.price)}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance == -1 or closestDistance > 3 then
                                ESX.ShowNotification('Personne aux alentours')
                                return
                            end
                            
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName,
                                ('Voulez-vous facturer %s$ à %s ?'):format(v.price, GetPlayerName(closestPlayer)),
                                '',
                                function(response)
                                    if response then
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_bcso', 'Sheriff (bcso)', v.price)
                                    else
                                        ESX.ShowNotification('Facturation annulée')
                                    end
                                end
                            )
                        end
                    })
                    
                end
            end
        end)

        RageUI.IsVisible(vehicleMenu, function()
            RageUI.Button('Rechercher une plaque', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Entrer la plaque', function(data)
                        cbVehicle = {}
                        ESX.TriggerServerCallback('sunny:bcso:vehicle:searchPlate', function(cb)
                            cbVehicle = cb
                            ExecuteCommand('e tablet2')
                            RageUI.Visible(vehicleInfoWithPlate, true)
                        end, data)
                    end)
                end
            })
            RageUI.Button('Placer le véhicule en fourrière', nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
            
                    if not DoesEntityExist(vehicle) then
                        return ESX.ShowNotification('Aucun véhicule aux alentours')
                    end
            
                    local vehCoords = #(playerCoords - GetEntityCoords(vehicle))
                    if vehCoords > 5.0 then
                        return ESX.ShowNotification('Aucun véhicule à proximité')
                    end
            
                    ExecuteCommand('e notepad2')
                    ESX.ShowNotification('Mise en fourrière du véhicule en cours...')
            
                        SetTimeout(10000, function()
                        ClearPedTasks(playerPed) 
            
                        TriggerServerEvent('sunny:Service:delVeh', NetworkGetNetworkIdFromEntity(vehicle))
            
                        if DoesEntityExist(vehicle) then
                            ESX.Game.DeleteVehicle(vehicle)
                            ESX.ShowNotification('Véhicule placé en fourrière avec succès !')
                        else
                            ESX.ShowNotification('Impossible de supprimer le véhicule. Veuillez réessayer.')
                        end
                    end)
                end
            })
            
            RageUI.Button('Crocheter le véhicule', nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local vehicle = ESX.Game.GetClosestVehicle(playerCoords)

                    local vehCoords = #(playerCoords-GetEntityCoords(vehicle))

                    if vehCoords > 5 then return ESX.ShowNotification('Aucun véhicule aux alentours') end

                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

                    SetTimeout(10000, function()
                        SetVehicleDoorsLocked(vehicle, 1)
                    end)
                end
            })
        end)
        
        RageUI.IsVisible(vehicleInfoWithPlate, function()
            RageUI.Separator(('Plaque du véhicule [%s]'):format(cbVehicle.plate))
            RageUI.Separator(('Propriétaire du véhicule (%s)'):format(cbVehicle.owner))
        end)

        RageUI.IsVisible(fouilleMenu, function()
            local permissionsFouille = {['officier3'] = true, ['officierprincipal'] = true, ['sergent1'] = true, ['sergent2'] = true, ['lieutenant'] = true, ['capitaine'] = true, ['boss'] = true}
            RageUI.Button('Argent Propre', nil, {RightLabel = ('~y~%s$~s~'):format(Sunnybcso.bcso.fouille.cash)}, true, {
                onSelected = function()
                    
                end
            })
            RageUI.Button('Argent Sale', nil, {RightLabel = ('~r~%s$~s~'):format(Sunnybcso.bcso.fouille.black_money)}, true, {
                onSelected = function()
                    KeyboardUtils.use('Quantité', function(data)
                        local data = tonumber(data)

                        if data == nil or data <= 0  then return end

                        if Sunnybcso.bcso.fouille.black_money < data then
                            return ESX.ShowNotification('La personne n\'en possède pas assez')
                        end

                        Sunnybcso.bcso.fouille.black_money = Sunnybcso.bcso.fouille.black_money - data

                        TriggerServerEvent('sunny:bcso:removeMoney', data, Sunnybcso.bcso.fouille.id)
                    end)
                end
            })
            RageUI.Line()
            RageUI.Separator('Inventaire')
            for k,v in pairs(Sunnybcso.bcso.fouille.inventory) do
                RageUI.Button(v.label, nil, {RightLabel = ('~y~x%s~s~'):format(v.count)}, true, {
                    onSelected = function()
                        if not permissionsFouille[ESX.PlayerData.job.grade_name] then return ESX.ShowNotification('~r~Vous n\'avez pas les permissions nécessaires~s~') end

                        KeyboardUtils.use('Quantité', function(data)
                            local data = tonumber(data)

                           Sunnybcso.bcso.fouille.inventory[k].count = Sunnybcso.bcso.fouille.inventory[k].count - data

                            if Sunnybcso.bcso.fouille.inventory[k].count <= 0 then
                                Sunnybcso.bcso.fouille.inventory[k] = nil
                            end

                            TriggerServerEvent('sunny:bcso:removeItem', data, v.name, Sunnybcso.bcso.fouille.id, v.label)
                        end)
                    end
                })
            end
            RageUI.Separator('Arme(s)')
            for k,v in pairs(Sunnybcso.bcso.fouille.loadout) do
                RageUI.Button(v.label, nil, {RightLabel = ('Munitions: ~y~x%s~s~'):format(v.ammo)}, not SunnyConfigServ.PermanantWeapon(v.name), {
                    onSelected = function()
                        if not permissionsFouille[ESX.PlayerData.job.grade_name] then
                            ESX.ShowNotification('~r~Vous n\'avez pas les permissions nécessaires~s~')
                            return
                        end
                        
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            ('Voulez-vous retirer l\'arme %s à %s ?'):format(v.label, Sunnybcso.bcso.fouille.id),
                            '',
                            function(response)
                                if response then
                                    TriggerServerEvent('sunny:bcso.removeWeapon', v.name, Sunnybcso.bcso.fouille.id, v.label)
                                    Sunnybcso.bcso.fouille.loadout[k] = nil
                                else
                                    ESX.ShowNotification('Action annulée') 
                                end
                            end
                        )
                    end
                })
                
            end
        end)

        RageUI.IsVisible(dogMenu, function()
            RageUI.Button("Sortir/Rentrer le chien", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    if not DoesEntityExist(bcsoDog) then
                        RequestModel(351016938)
                        while not HasModelLoaded(351016938) do Wait(0) end
                        bcsoDog = CreatePed(4, 351016938, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                        SetEntityAsMissionEntity(bcsoDog, true, true)
                        ESX.ShowNotification('~g~Vous venez de faire apparaître votre chien.')
                    else
                        ESX.ShowNotification('~r~Vous venez de faire disparaître votre chien.')
                        DeleteEntity(bcsoDog)
                    end
                end
            })
        
            RageUI.Button("Demander de s'asseoir", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    if DoesEntityExist(bcsoDog) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(bcsoDog), true) <= 5.0 then
                            if IsEntityPlayingAnim(bcsoDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 3) then
                                ClearPedTasks(bcsoDog)
                            else
                                RequestAnimDict('rcmnigel1c')
                                while not HasAnimDictLoaded('rcmnigel1c') do
                                    Wait(10)
                                end
        
                                TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
        
                                Wait(2000)
        
                                RequestAnimDict("creatures@rottweiler@amb@world_dog_sitting@base")
                                while not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_sitting@base") do
                                    Wait(10)
                                end
        
                                TaskPlayAnim(bcsoDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                            end
                        else
                            ESX.ShowNotification('Vous êtes trop loin du chien.')
                        end
                    else
                        ESX.ShowNotification('Aucun K9 disponible.')
                    end
                end
            })


    RageUI.Button("Grogner/Aboyer", nil, {RightLabel = "→"}, true, {
        onSelected = function()
            if DoesEntityExist(bcsoDog) then
                RequestAnimDict("creatures@rottweiler@amb@world_dog_barking@enter")
                while not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_barking@enter") do
                    Wait(10)
                end

                TaskPlayAnim(bcsoDog, "creatures@rottweiler@amb@world_dog_barking@enter", "enter", 8.0, -8, -1, 1, 0, false, false, false)
                ESX.ShowNotification('~g~Le chien grogne/aboie.')
            else
                ESX.ShowNotification('no_dog')
            end
        end
    })
        
            RageUI.Button("Suivre", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    if DoesEntityExist(bcsoDog) then
                        TaskFollowToOffsetOfEntity(bcsoDog, PlayerPedId(), 0.0, 0.0, 0.0, 1.0, -1, 1.0, true)
                        ESX.ShowNotification('~g~Le chien vous suit maintenant.')
                    else
                        ESX.ShowNotification('Aucun K9 disponible.')
                    end
                end
            })
        
            RageUI.Button("Attaquer", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                    if DoesEntityExist(bcsoDog) then
                        if closestPlayer ~= -1 and closestDistance <= 10.0 then
                            local targetPed = GetPlayerPed(closestPlayer)
                            TaskCombatPed(bcsoDog, targetPed, 0, 16)
                            ESX.ShowNotification('~r~Le chien attaque le joueur à proximité.')
                        else
                            ESX.ShowNotification('~r~Aucun joueur à proximité pour attaquer.')
                        end
                    else
                        ESX.ShowNotification('Aucun K9 disponible.')
                    end
                end
            })
        end)
        

        RageUI.IsVisible(code, function()
            RageUI.Separator('Demande de renforts')
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            RageUI.Button('Petite demande de renforts', nil, {}, bcsoIsActionAvailable(timerRenfort2), {
                onSelected = function()
                    bcsoStartRenfortCooldown()
                    TriggerServerEvent('sunny:bcso:renforts', playerCoords, 'petite')
                end
            })
            RageUI.Button('Moyenne demande de renforts', nil, {}, bcsoIsActionAvailable(timerRenfort2), {
                onSelected = function()
                    bcsoStartRenfortCooldown()
                    TriggerServerEvent('sunny:bcso:renforts', playerCoords, 'importante')
                end
            })
            RageUI.Button('Grande demande de renforts', nil, {}, bcsoIsActionAvailable(timerRenfort2), {
                onSelected = function()
                    bcsoStartRenfortCooldown()
                    TriggerServerEvent('sunny:bcso:renforts', playerCoords, 'omgad')
                end
            })
            RageUI.Separator('Codes')
            for idx,v in ipairs(Sunnybcso.bcso.codes) do
                RageUI.Button(v.buttonName, nil, {}, bcsoIsActionAvailable(timerCode), {
                    onSelected = function()
                        bcsoStartCodeCooldown()
                        local codeId = v.id or ('code_'..idx)
                        local coordsTable = {x = playerCoords.x, y = playerCoords.y, z = playerCoords.z}
                        TriggerServerEvent('sunny:bcso:sendCode', codeId, v.message, coordsTable)
                    end
                })
            end
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(interactMenu) and not RageUI.Visible(billMenu) and not RageUI.Visible(fouilleMenu) and not RageUI.Visible(vehicleMenu) and not RageUI.Visible(vehicleInfoWithPlate) and not RageUI.Visible(dogMenu) and not RageUI.Visible(code) then
            main = RMenu:DeleteType('main')
        end
    end
end

function bcso_OpenAccueilMenu()
    local main = RageUI.CreateMenu('', 'Actions Disponibles')
    local registerPlaint = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local archives = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local archivesSelected = RageUI.CreateSubMenu(archives, '', 'Actions Disponibles')

    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(PlayerPedId(), true)
    while main do Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Button('Enregistrer une plainte', nil, {}, true, {
                onSelected = function()
                    
                end
            }, registerPlaint)
            RageUI.Button('Acceder aux archives', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:bcso:plainte:get', function(cb)
                        Sunnybcso.bcso.complaint.archives = cb

                        RageUI.Visible(archives, true)
                    end)
                end
            })
        end)

        RageUI.IsVisible(registerPlaint, function()
            RageUI.Button('Date', nil, {RightLabel = Sunnybcso.bcso.complaint.date or ''},  true, {
                onSelected = function()
                    KeyboardUtils.use('Entrer une date', function(data)
                        if data == nil or data == '' then return end
                        Sunnybcso.bcso.complaint.date = data
                    end)
                end
            })
            RageUI.Button('Nom/Prénom de la personne', nil, {RightLabel = Sunnybcso.bcso.complaint.name or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom/Prénom de la personne', function(data)
                        if data == nil or data == '' then return end
                        Sunnybcso.bcso.complaint.name = data
                    end)
                end
            })
            RageUI.Button('Numéro de téléphone de la personne', nil, {RightLabel = Sunnybcso.bcso.complaint.numberphone or ''}, true , {
                onSelected = function()
                    KeyboardUtils.use('Numéro de téléphonem de la personne', function(data)
                        if data == nil or data == '' then return end
                        Sunnybcso.bcso.complaint.numberphone = data
                    end)
                end
            })
            RageUI.Button('Raison/Description de la plainte', nil, {RightLabel = Sunnybcso.bcso.complaint.reason or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Raison/Description de la plainte', function(data)
                        if data == nil or data == '' then return end
                        Sunnybcso.bcso.complaint.reason = data
                    end)
                end
            })
            RageUI.Line()
            RageUI.Button('Confirmer', nil, {}, true, {
                onSelected = function()
                    if Sunnybcso.bcso.complaint.date == nil or Sunnybcso.bcso.complaint.name == nil or Sunnybcso.bcso.complaint.numberphone == nil or Sunnybcso.bcso.complaint.reason == nil then return ESX.ShowNotification('Toutes les informations ne sont pas correctement complétés') end

                    TriggerServerEvent('sunny:bcso:plainte:register', Sunnybcso.bcso.complaint)
                end
            })
        end)

        RageUI.IsVisible(archives, function()
            for k,v in pairs(Sunnybcso.bcso.complaint.archives) do
                RageUI.Button(('%s - %s'):format(v.id, v.name), v.reason, {}, true, {
                    onSelected = function()
                        Sunnybcso.bcso.complaint.archivesSelected = v
                        RageUI.Visible(archivesSelected, true)
                    end
                })
            end
        end)

        RageUI.IsVisible(archivesSelected, function()
            RageUI.Separator(('Archive %s - %s'):format(Sunnybcso.bcso.complaint.archivesSelected.id, Sunnybcso.bcso.complaint.archivesSelected.name))
            RageUI.Separator(('Nom/Prenom %s'):format(Sunnybcso.bcso.complaint.archivesSelected.name))
            RageUI.Button('Raison de la plainte', Sunnybcso.bcso.complaint.archivesSelected.reason, {}, true, {
                onActive = function()
                    RageUI.Info('Informations', {Sunnybcso.bcso.complaint.archivesSelected.reason}, {})
                end,
                onSelected = function()
                    
                end
            })
            RageUI.Line()
            RageUI.Button('Changer la raison', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouvelle raison', function(data)
                        if data == nil then return end

                        TriggerServerEvent('sunny:bcso:plainte:editReason', Sunnybcso.bcso.complaint.archivesSelected.id, data)

                        Sunnybcso.bcso.complaint.archivesSelected.reason = data
                    end)
                end
            })
            RageUI.Button('Supprimer l\'archive', nil, {Color = {BackgroundColor = {255,0,0,100}}}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir supprimer cette archive ?',
                        '',
                        function(response)
                            if response then
                                TriggerServerEvent('sunny:bcso:plainte:delete', Sunnybcso.bcso.complaint.archivesSelected.id)

                                RageUI.Visible(archivesSelected, false)
                                RageUI.Visible(archives, false) 
                                RageUI.Visible(main, true)
                            else
                                ESX.ShowNotification('Action annulée')
                            end
                        end
                    )
                end
            })
            
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(registerPlaint) and not RageUI.Visible(playerAmenderbcso) and not RageUI.Visible(archives) and not RageUI.Visible(archivesSelected) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

RegisterNetEvent('sunny:bcso:renforts', function(payload)
    if ESX.PlayerData.job.name ~= 'bcso' and ESX.PlayerData.job.name ~= 'bcsosandy' and ESX.PlayerData.job.name ~= 'saspn' then return end
    if not Sunnybcso.bcso.Service then return end
    if type(payload) ~= 'table' then return end
    bcsoHandleRenfortAlert(payload)
end)

function bcso_OpenWeaponMenu()
    local main = RageUI.CreateMenu('', 'Actions Disponibles', nil, nil, "shopui_title_gunclub", "shopui_title_gunclub")
    local ammoMenu = RageUI.CreateSubMenu(main, '', 'Munitions Disponibles', nil, nil, "shopui_title_gunclub", "shopui_title_gunclub")

    RageUI.Visible(main, not RageUI.Visible(main))
    while main do Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Button('Rendre ses armes de service', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:bcso.removeWeapon', SunnyLSPD.Police.weapons)
                end
            })
            RageUI.Button('Munitions', nil, {RightLabel = '>>'}, true, {}, ammoMenu)
            RageUI.WLine()
            for k,v in pairs(Sunnybcso.bcso.weapons) do
                RageUI.Button(v.label, nil, {RightLabel = '>>'}, ESX.PlayerData.job.grade >= v.required_grade, {
                    onSelected = function()
                        TriggerServerEvent('sunny:bcso:giveweapon', v.name)
                    end
                })
            end
        end)

        RageUI.IsVisible(ammoMenu, function()
            for k,v in pairs(Sunnybcso.bcso.ammunition) do
                RageUI.Button(v.label, nil, {RightLabel = ('Quantité: ~y~x%s~s~'):format(v.quantity)}, ESX.PlayerData.job.grade >= v.required_grade, {
                    onSelected = function()
                        TriggerServerEvent('sunny:bcso:giveammo', v.name, v.label, v.quantity)
                    end
                })
            end
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(ammoMenu) then
            main = RMenu:DeleteType('main')
        end
    end
end

RegisterCommand('F6_bcso', function()
    if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'bcso' or ESX.PlayerData.job.name == 'bcsosandy' or ESX.PlayerData.job.name == 'saspn') then
        bcso_openF6()
    end
end)
RegisterKeyMapping('F6_bcso', 'Menu Intéractions bcso', 'keyboard', 'F6')

RegisterNetEvent('sunny:bcso:menotter', function()

    Sunnybcso.bcso.HandCuffed = not Sunnybcso.bcso.HandCuffed
    local playerPed = GetPlayerPed(-1)

    Citizen.CreateThread(function()

        
        if Sunnybcso.bcso.HandCuffed then

            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end

            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

            while Sunnybcso.bcso.HandCuffed == true do
                Wait(0)
                SetPedCanBeDraggedOut(GetPlayerPed(-1), false)
                DisableControlAction(27, 75, true)
                DisableControlAction(0, 23, true)
                DisableControlAction(2, 37, true)
                SetEnableHandcuffs(playerPed, true)
                SetPedCanPlayGestureAnims(playerPed, false)
                FreezeEntityPosition(playerPed,  true)
                DisableControlAction(0, 75, true)
                DisableControlAction(1, 75, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 37, true)
                DisableControlAction(0, 47, true)
                RageUI.setKeyState(21, true)
	            RageUI.setKeyState(22, true)
            end

        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed,  true)
            FreezeEntityPosition(playerPed, false)
            RageUI.setKeyState(21, false)
            ExecuteCommand(('walk %s'):format(getWalkStyle()))
	        RageUI.setKeyState(22, false)
        end
    end)
end)

local isEscort = false
local playerSRCEscorte = nil
RegisterNetEvent("sunny:bcso:escoter", function(player)
    isEscort = not isEscort
    playerSRCEscorte = tonumber(player)
    if isEscort then
        Citizen.CreateThread(function()
            local pPed = GetPlayerPed(-1)
            while isEscort do
                Wait(1)
                pPed = GetPlayerPed(-1)
                local targetPed = GetPlayerPed(GetPlayerFromServerId(playerSRCEscorte))
    
                if not IsPedSittingInAnyVehicle(targetPed) then
                    AttachEntityToEntity(pPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    isEscort = false
                    DetachEntity(pPed, true, false)
                end
    
                if IsPedDeadOrDying(targetPed, true) then
                    isEscort = false
                    DetachEntity(pPed, true, false)
                end
            end
            DetachEntity(pPed, true, false)
        end)
    end
end)

RegisterNetEvent('sunny:bcso:playerVehicle', function(veh, value)
    local playerPed = PlayerPedId()
    if value == 'put' then
        CreateThread(function()
            local coords = GetEntityCoords(playerPed)

            if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

                local vehicle = ESX.Game.GetClosestVehicle(coords)

                if DoesEntityExist(vehicle) then

                    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
                    local freeSeat = nil

                    for i=maxSeats - 1, 0, -1 do
                        if IsVehicleSeatFree(vehicle,  i) then
                            freeSeat = i
                            break
                        end
                    end

                    if freeSeat ~= nil then
                        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
                    end

                end
            end
        end)
    elseif value == 'exit' then
        CreateThread(function()
            TaskLeaveAnyVehicle(PlayerPedId(), 0.0, 0.0)
        end)
    end
end)

CreateThread(function()
    while not ESXLoaded do Wait(1) end
    -- AddZones('cloakroom_bcso', {
    --     Position = Sunnybcso.bcso.Position.cloakroom,
    --     Dist = 10,
    --     Public = false,
    --     Job = {['saspn'] = true},
    --     Job2 = {['saspn'] = true},
    --     GradesJob = {},
    --     InVehicleDisable = true,
    --     Blip = {
    --         Active = false,
    --     },
    --     marker = true,
    --     ActionText = 'pour intéragir',
    --     Action = function()
    --         bcso_openVestiaire()
    --     end
    -- })
    AddZones('accueil_bcsosandy', {
        Position = Sunnybcso.bcso.Position.accueilsandy,
        Dist = 10,
        Public = false,
        Job = {['bcsosandy'] = true},
        Job2 = {['bcsosandy'] = true},
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = false,
        },
        marker = true,
            ActionText = 'Accueil BCSO (Sandy)',
        Action = function()
            bcso_OpenAccueilMenu()
        end
    })
    AddZones('accueil_bcso', {
        Position = Sunnybcso.bcso.Position.accueil,
        Dist = 10,
        Public = false,
        Job = {['saspn'] = true},
        Job2 = {['saspn'] = true},
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = false,
        },
        marker = true,
        ActionText = 'Accueil BCSO',
        Action = function()
            bcso_OpenAccueilMenu()
        end
    })
    AddZones('weapons_menu_bcsosandy', {
        Position = Sunnybcso.bcso.Position.armorysandy,
        Dist = 10,
        Public = false,
        Job = {['bcsosandy'] = true},
        Job2 = {['bcsosandy'] = true},
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = false,
        },
        marker = true,
        ActionText = 'Armurerie BCSO (Sandy)',
        Action = function()
            bcso_OpenWeaponMenu()
        end
    })
    AddZones('weapons_menu_bcso', {
        Position = Sunnybcso.bcso.Position.armory,
        Dist = 10,
        Public = false,
        Job = {['saspn'] = true},
        Job2 = {['saspn'] = true},
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = false,
        },
        marker = true,
        ActionText = 'Armurerie BCSO',
        Action = function()
            bcso_OpenWeaponMenu()
        end
    })
end)

RegisterNetEvent('sunny:bcso:sendCode', function(payload)
    if ESX.PlayerData.job.name ~= 'bcso' and ESX.PlayerData.job.name ~= 'bcsosandy' and ESX.PlayerData.job.name ~= 'saspn' then
        return
    end
    if not Sunnybcso.bcso.Service then return end

    if type(payload) == 'table' then
        bcsoHandleCodeAlert(payload)
    else
        bcsoPlayDispatchSounds()
    end
end)