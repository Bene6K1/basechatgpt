--[[
    Job Garage Creator - Client
    Permet de créer des garages avec accès par job/gang + presets de véhicules
    Commande: /jobgarage
]]

JobGarageCreator = {
    garages = {},
    blips = {},
    interactionPoints = {},

    -- État de création
    creating = {
        name = nil,
        label = nil,
        accessType = 'public', -- 'public', 'job', 'gang'
        accessName = nil,
        garageType = 'car', -- 'car', 'boat', 'aircraft'
        accessPoint = nil,
        deletePoint = nil,
        spawnPoints = {},
        vehicles = {},
        permissions = { spawnVehicle = 0, storeVehicle = 0, deleteVehicle = 0 },
        blip = { enabled = false, sprite = 357, color = 0, scale = 0.7 }
    },

    -- Listes pour les menus
    accessTypes = { 'Public', 'Job', 'Gang' },
    garageTypes = { 'Voiture', 'Bateau', 'Avion' },
    jobsList = {}
}

-- Synchroniser les garages depuis le serveur
RegisterNetEvent('jobgarage:sync', function(garages)
    JobGarageCreator.garages = garages
    JobGarageCreator:refreshBlips()
    JobGarageCreator:refreshInteractionPoints()
end)

-- Rafraîchir les blips
function JobGarageCreator:refreshBlips()
    -- Supprimer les anciens blips
    for id, blipData in pairs(self.blips) do
        if blipData.handle then
            RemoveBlip(blipData.handle)
        end
    end
    self.blips = {}

    -- Créer les nouveaux blips
    for id, garage in pairs(self.garages) do
        if garage.enabled and garage.blip and garage.blip.enabled and garage.accessPoint then
            local blip = AddBlipForCoord(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z)
            SetBlipSprite(blip, garage.blip.sprite or 357)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, garage.blip.scale or 0.7)
            SetBlipColour(blip, garage.blip.color or 0)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(garage.label)
            EndTextCommandSetBlipName(blip)

            self.blips[id] = { handle = blip }
        end
    end
end

-- Rafraîchir les points d'interaction
function JobGarageCreator:refreshInteractionPoints()
    -- Les points d'interaction sont gérés dans la boucle principale
end

-- Vérifier si le joueur a accès au garage
function JobGarageCreator:hasAccess(garage)
    if not garage or not garage.enabled then return false end

    if garage.accessType == 'public' then
        return true
    elseif garage.accessType == 'job' then
        return ESX.PlayerData.job and ESX.PlayerData.job.name == garage.accessName
    elseif garage.accessType == 'gang' then
        return ESX.PlayerData.job2 and ESX.PlayerData.job2.name == garage.accessName
    end

    return false
end

-- Ouvrir le menu principal de la commande /jobgarage
function JobGarageCreator:openMenu()
    local main = RageUI.CreateMenu('', 'Gestion Garages Job')
    local createMenu = RageUI.CreateSubMenu(main, '', 'Créer un garage')
    local editMenu = RageUI.CreateSubMenu(main, '', 'Modifier un garage')
    local editGarageMenu = RageUI.CreateSubMenu(editMenu, '', 'Modifier')
    local vehiclesMenu = RageUI.CreateSubMenu(editGarageMenu, '', 'Véhicules')

    local selectedGarageId = nil
    local accessTypeIndex = 1
    local garageTypeIndex = 1
    local jobIndex = 1

    -- Reset création
    self.creating = {
        name = nil,
        label = nil,
        accessType = 'public',
        accessName = nil,
        garageType = 'car',
        accessPoint = nil,
        deletePoint = nil,
        spawnPoints = {},
        vehicles = {},
        permissions = { spawnVehicle = 0, storeVehicle = 0, deleteVehicle = 0 },
        blip = { enabled = false, sprite = 357, color = 0, scale = 0.7 }
    }

    RageUI.Visible(main, not RageUI.Visible(main))

    while main do
        Wait(1)

        RageUI.IsVisible(main, function()
            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)

            RageUI.Button('Créer un garage', nil, {}, true, {
                onSelected = function()
                    -- Charger la liste des jobs
                    ESX.TriggerServerCallback('jobgarage:getJobs', function(jobs)
                        self.jobsList = jobs
                    end)
                end
            }, createMenu)

            RageUI.Button('Modifier un garage', nil, {}, true, {}, editMenu)

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
        end)

        -- Menu Création
        RageUI.IsVisible(createMenu, function()
            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)

            RageUI.Button('Nom du garage', nil, { RightLabel = self.creating.name or '~r~Non défini' }, true, {
                onSelected = function()
                    KeyboardUtils.use('Entrez le nom du garage', function(value)
                        if value and value ~= '' then
                            self.creating.name = value
                        end
                    end)
                end
            })

            RageUI.Button('Label du garage', nil, { RightLabel = self.creating.label or '~r~Non défini' }, true, {
                onSelected = function()
                    KeyboardUtils.use('Entrez le label du garage', function(value)
                        if value and value ~= '' then
                            self.creating.label = value
                        end
                    end)
                end
            })

            RageUI.Line()

            RageUI.List('Type d\'accès', self.accessTypes, accessTypeIndex, nil, {}, true, {
                onListChange = function(index)
                    accessTypeIndex = index
                    if index == 1 then
                        self.creating.accessType = 'public'
                        self.creating.accessName = nil
                    elseif index == 2 then
                        self.creating.accessType = 'job'
                    elseif index == 3 then
                        self.creating.accessType = 'gang'
                    end
                end
            })

            if accessTypeIndex == 2 or accessTypeIndex == 3 then
                local jobNames = {}
                for _, job in pairs(self.jobsList) do
                    table.insert(jobNames, job.label or job.name)
                end

                if #jobNames > 0 then
                    RageUI.List(accessTypeIndex == 2 and 'Job requis' or 'Gang requis', jobNames, jobIndex, nil, {}, true, {
                        onListChange = function(index)
                            jobIndex = index
                            if self.jobsList[index] then
                                self.creating.accessName = self.jobsList[index].name
                            end
                        end
                    })
                else
                    RageUI.Separator('Chargement des jobs...')
                end
            end

            RageUI.List('Type de garage', self.garageTypes, garageTypeIndex, nil, {}, true, {
                onListChange = function(index)
                    garageTypeIndex = index
                    if index == 1 then
                        self.creating.garageType = 'car'
                    elseif index == 2 then
                        self.creating.garageType = 'boat'
                    elseif index == 3 then
                        self.creating.garageType = 'aircraft'
                    end
                end
            })

            RageUI.Line()

            RageUI.Button('Point d\'accès', 'Position où ouvrir le menu', {
                RightLabel = self.creating.accessPoint and '~g~Défini' or '~r~Non défini'
            }, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    self.creating.accessPoint = { x = coords.x, y = coords.y, z = coords.z }
                    ESX.ShowNotification('~g~Point d\'accès défini')
                end
            })

            RageUI.Button('Point de rangement', 'Position pour ranger le véhicule', {
                RightLabel = self.creating.deletePoint and '~g~Défini' or '~r~Non défini'
            }, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    self.creating.deletePoint = { x = coords.x, y = coords.y, z = coords.z }
                    ESX.ShowNotification('~g~Point de rangement défini')
                end
            })

            RageUI.Separator(('Points de spawn: %d'):format(#self.creating.spawnPoints))

            RageUI.Button('Ajouter point de spawn', nil, {}, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    local heading = GetEntityHeading(PlayerPedId())
                    table.insert(self.creating.spawnPoints, { x = coords.x, y = coords.y, z = coords.z, h = heading })
                    ESX.ShowNotification('~g~Point de spawn ajouté')
                end
            })

            RageUI.Button('Retirer dernier point de spawn', nil, {}, #self.creating.spawnPoints > 0, {
                onSelected = function()
                    table.remove(self.creating.spawnPoints)
                    ESX.ShowNotification('~y~Point de spawn retiré')
                end
            })

            -- Afficher les markers des positions
            if self.creating.accessPoint then
                DrawMarker(25, self.creating.accessPoint.x, self.creating.accessPoint.y, self.creating.accessPoint.z - 0.98, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, 0, 255, 0, 255, false, false, 2, false, false, false, false)
            end
            if self.creating.deletePoint then
                DrawMarker(36, self.creating.deletePoint.x, self.creating.deletePoint.y, self.creating.deletePoint.z - 0.30, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, 255, 0, 0, 255, false, false, 2, true, false, false, false)
            end
            for _, sp in pairs(self.creating.spawnPoints) do
                DrawMarker(1, sp.x, sp.y, sp.z, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, 255, 255, 0, 255, false, false, 2, false, false, false, false)
            end

            RageUI.Line()

            local canCreate = self.creating.name and self.creating.label and self.creating.accessPoint and self.creating.deletePoint and #self.creating.spawnPoints > 0
            if accessTypeIndex ~= 1 and not self.creating.accessName then
                canCreate = false
            end

            RageUI.Button('~g~Créer le garage', nil, {}, canCreate, {
                onSelected = function()
                    TriggerServerEvent('jobgarage:create', self.creating)
                    RageUI.CloseAll()
                end
            })

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
        end)

        -- Menu Édition - Liste des garages
        RageUI.IsVisible(editMenu, function()
            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)

            for id, garage in pairs(self.garages) do
                local accessLabel = garage.accessType == 'public' and 'Public' or garage.accessName or 'N/A'
                RageUI.Button(garage.label, ('Type: %s | Accès: %s'):format(garage.garageType, accessLabel), {
                    RightLabel = garage.enabled and '~g~Actif' or '~r~Inactif'
                }, true, {
                    onSelected = function()
                        selectedGarageId = id
                    end
                }, editGarageMenu)
            end

            if next(self.garages) == nil then
                RageUI.Separator('Aucun garage créé')
            end

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
        end)

        -- Menu Édition d'un garage spécifique
        RageUI.IsVisible(editGarageMenu, function()
            if not selectedGarageId or not self.garages[selectedGarageId] then return end
            local garage = self.garages[selectedGarageId]

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
            RageUI.Separator(garage.label)
            RageUI.Line()

            RageUI.Button('Gérer les véhicules', ('Actuellement: %d véhicules'):format(#garage.vehicles), {}, true, {}, vehiclesMenu)

            RageUI.Checkbox('Garage actif', nil, garage.enabled, {}, {
                onChecked = function()
                    garage.enabled = true
                    TriggerServerEvent('jobgarage:edit', selectedGarageId, garage)
                end,
                onUnChecked = function()
                    garage.enabled = false
                    TriggerServerEvent('jobgarage:edit', selectedGarageId, garage)
                end
            })

            RageUI.Checkbox('Blip sur la carte', nil, garage.blip and garage.blip.enabled, {}, {
                onChecked = function()
                    garage.blip = garage.blip or {}
                    garage.blip.enabled = true
                    TriggerServerEvent('jobgarage:edit', selectedGarageId, garage)
                end,
                onUnChecked = function()
                    garage.blip = garage.blip or {}
                    garage.blip.enabled = false
                    TriggerServerEvent('jobgarage:edit', selectedGarageId, garage)
                end
            })

            RageUI.Line()

            RageUI.Button('Modifier point d\'accès', nil, {}, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    garage.accessPoint = { x = coords.x, y = coords.y, z = coords.z }
                    TriggerServerEvent('jobgarage:edit', selectedGarageId, garage)
                    ESX.ShowNotification('~g~Point d\'accès modifié')
                end
            })

            RageUI.Button('Modifier point de rangement', nil, {}, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    garage.deletePoint = { x = coords.x, y = coords.y, z = coords.z }
                    TriggerServerEvent('jobgarage:edit', selectedGarageId, garage)
                    ESX.ShowNotification('~g~Point de rangement modifié')
                end
            })

            RageUI.Button('Ajouter point de spawn', nil, {}, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    local heading = GetEntityHeading(PlayerPedId())
                    table.insert(garage.spawnPoints, { x = coords.x, y = coords.y, z = coords.z, h = heading })
                    TriggerServerEvent('jobgarage:edit', selectedGarageId, garage)
                    ESX.ShowNotification('~g~Point de spawn ajouté')
                end
            })

            RageUI.Line()

            RageUI.Button('~r~Supprimer le garage', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Supprimer le garage',
                        'Êtes-vous sûr de vouloir supprimer ce garage ?',
                        function(response)
                            if response then
                                TriggerServerEvent('jobgarage:delete', selectedGarageId)
                                RageUI.GoBack()
                            end
                        end
                    )
                end
            })

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)

            -- Afficher les markers
            if garage.accessPoint then
                DrawMarker(25, garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z - 0.98, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, 0, 255, 0, 255, false, false, 2, false, false, false, false)
            end
            if garage.deletePoint then
                DrawMarker(36, garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z - 0.30, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, 255, 0, 0, 255, false, false, 2, true, false, false, false)
            end
            for _, sp in pairs(garage.spawnPoints or {}) do
                DrawMarker(1, sp.x, sp.y, sp.z, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, 255, 255, 0, 255, false, false, 2, false, false, false, false)
            end
        end)

        -- Menu Véhicules
        RageUI.IsVisible(vehiclesMenu, function()
            if not selectedGarageId or not self.garages[selectedGarageId] then return end
            local garage = self.garages[selectedGarageId]

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
            RageUI.Separator('Véhicules du garage')
            RageUI.Line()

            RageUI.Button('~g~Ajouter un véhicule', 'Ajouter le véhicule actuel', {}, true, {
                onSelected = function()
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if vehicle == 0 then
                        return ESX.ShowNotification('~r~Vous devez être dans un véhicule')
                    end

                    local model = GetEntityModel(vehicle)
                    local displayName = GetDisplayNameFromVehicleModel(model)

                    KeyboardUtils.use('Label du véhicule', function(label)
                        if label and label ~= '' then
                            local vehicleData = {
                                model = displayName,
                                label = label,
                                livery = GetVehicleLivery(vehicle) or 0,
                                type = garage.garageType
                            }
                            TriggerServerEvent('jobgarage:addVehicle', selectedGarageId, vehicleData)
                        end
                    end)
                end
            })

            RageUI.Line()

            for index, veh in ipairs(garage.vehicles or {}) do
                RageUI.Button(veh.label, ('Model: %s'):format(veh.model), {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Retirer le véhicule',
                            ('Voulez-vous retirer %s du garage ?'):format(veh.label),
                            function(response)
                                if response then
                                    TriggerServerEvent('jobgarage:removeVehicle', selectedGarageId, index)
                                end
                            end
                        )
                    end
                })
            end

            if #(garage.vehicles or {}) == 0 then
                RageUI.Separator('Aucun véhicule')
            end

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(createMenu) and not RageUI.Visible(editMenu) and not RageUI.Visible(editGarageMenu) and not RageUI.Visible(vehiclesMenu) then
            main = RMenu:DeleteType('main')
        end
    end
end

-- Ouvrir le menu du garage (pour les joueurs)
function JobGarageCreator:openGarageMenu(garageId)
    local garage = self.garages[garageId]
    if not garage then return end

    local main = RageUI.CreateMenu('', garage.label)

    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(PlayerPedId(), true)

    while main do
        Wait(1)

        RageUI.IsVisible(main, function()
            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
            RageUI.Separator('Véhicules disponibles')
            RageUI.Line()

            for index, veh in ipairs(garage.vehicles or {}) do
                RageUI.Button(veh.label, ('Model: %s'):format(veh.model), {}, true, {
                    onSelected = function()
                        TriggerServerEvent('jobgarage:spawnVehicle', garageId, index)
                        RageUI.CloseAll()
                    end
                })
            end

            if #(garage.vehicles or {}) == 0 then
                RageUI.Separator('Aucun véhicule disponible')
            end

            RageUI.Line(UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o)
        end)

        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

-- Spawn un véhicule côté client
RegisterNetEvent('jobgarage:spawnVehicleClient', function(vehicleData, spawnPoint, garageType)
    local model = vehicleData.model

    ESX.Game.SpawnVehicle(model, vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z), spawnPoint.h or 0.0, function(vehicle)
        if vehicleData.livery and vehicleData.livery > 0 then
            SetVehicleLivery(vehicle, vehicleData.livery)
        end
        SetVehicleDoorsLocked(vehicle, 1)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        ESX.ShowNotification('~g~Véhicule sorti avec succès')
    end)
end)

-- Boucle principale pour les interactions
CreateThread(function()
    while not ESXLoaded do Wait(1) end
    Wait(3000)

    while true do
        local sleep = 2000
        local playerCoords = GetEntityCoords(PlayerPedId())

        for id, garage in pairs(JobGarageCreator.garages) do
            if garage.enabled and JobGarageCreator:hasAccess(garage) then
                -- Point d'accès
                if garage.accessPoint then
                    local distance = #(playerCoords - vector3(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z))

                    if distance < 30 then
                        sleep = 1
                        DrawMarker(25, garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z - 0.98, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, tonumber(UTILS.ServerColor.r), tonumber(UTILS.ServerColor.g), tonumber(UTILS.ServerColor.b), 255, false, false, 2, false, false, false, false)

                        if distance < 1.5 then
                            if not garage.interactionPoint then
                                garage.interactionPoint = CreateInteractionPoint(
                                    vector3(garage.accessPoint.x, garage.accessPoint.y, garage.accessPoint.z),
                                    "GARAGE " .. (garage.accessType == 'public' and 'PUBLIC' or string.upper(garage.accessName or '')),
                                    function()
                                        JobGarageCreator:openGarageMenu(id)
                                    end,
                                    { icon = 'fa-car', dist = 1.5 }
                                )
                            end
                        else
                            if garage.interactionPoint then
                                RemoveInteractionPoint(garage.interactionPoint)
                                garage.interactionPoint = nil
                            end
                        end
                    else
                        if garage.interactionPoint then
                            RemoveInteractionPoint(garage.interactionPoint)
                            garage.interactionPoint = nil
                        end
                    end
                end

                -- Point de rangement
                if garage.deletePoint then
                    local distance = #(playerCoords - vector3(garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z))

                    if distance < 30 then
                        sleep = 1
                        DrawMarker(36, garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z - 0.30, 0, 0, 0, 0, 0, 0, 0.55, 0.55, 0.55, tonumber(UTILS.ServerColor.r), tonumber(UTILS.ServerColor.g), tonumber(UTILS.ServerColor.b), 255, false, false, 2, true, false, false, false)

                        if distance < 3.0 then
                            if not garage.deleteInteractionPoint then
                                garage.deleteInteractionPoint = CreateInteractionPoint(
                                    vector3(garage.deletePoint.x, garage.deletePoint.y, garage.deletePoint.z + 0.25),
                                    "RANGER VÉHICULE",
                                    function()
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if vehicle ~= 0 then
                                            local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                            TriggerServerEvent('jobgarage:storeVehicle', id, netId)
                                        else
                                            ESX.ShowNotification('~r~Vous devez être dans un véhicule')
                                        end
                                    end,
                                    { icon = 'fa-parking', dist = 3.0 }
                                )
                            end
                        else
                            if garage.deleteInteractionPoint then
                                RemoveInteractionPoint(garage.deleteInteractionPoint)
                                garage.deleteInteractionPoint = nil
                            end
                        end
                    else
                        if garage.deleteInteractionPoint then
                            RemoveInteractionPoint(garage.deleteInteractionPoint)
                            garage.deleteInteractionPoint = nil
                        end
                    end
                end
            end
        end

        Wait(sleep)
    end
end)

-- Commande /jobgarage
RegisterCommand('jobgarage', function()
    if not ESX.IsAdmin(GetPlayerServerId(PlayerId())) then
        ESX.TriggerServerCallback('core:isAdmin', function(isAdmin)
            if isAdmin then
                JobGarageCreator:openMenu()
            else
                ESX.ShowNotification('~r~Vous n\'avez pas la permission')
            end
        end)
    else
        JobGarageCreator:openMenu()
    end
end, false)
