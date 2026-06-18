RegisterNetEvent("sunny:waitingForPlaque")
AddEventHandler("sunny:waitingForPlaque", function()
    Citizen.Wait(8000)
    waitingForPlaque = false
    ClearPedTasks(GetPlayerPed(-1))
end)

LSPD = {
    VehiculeSortie = {},
    playerItem = {},
    FineLister = {},
    playerWeapon = {},
    playerBlackMoney = {},
    RadarPlaced = {},
    Radar = {},
    SaisieActif = {},
    quantity = {},
    LoadoutActif = {},
    VehList = {},
    ZonesCam = {"Place des cubes", "Quartiers", "Pacifique banque"},
    inServicePolice = false,
    MenuLSPD = false,
    sServiceInfos = false,
    GarageLSPD = false,
    Extra = false,
    GestPlainte = false,
    Helico = false,
    GarageShop = false,
    PlainteActif = false,
    VestiaireLSPD = false,
    Camera = false,
    Saisie = false,
    AmmuLSPD = false,
    Index = 1,
    IndexFine = 1,
    Matricule = 1,
    IndexCustom = 1,
    ChangerCam = 1,
    ZonesCamIndex = 1,
    selecQuantity = 1,
    MyMatricule = "Aucun",
    VehiculeInfos = nil,
    ObjetSaisie = {
        [1] = {"weed","weed_pochon","coke","coke_pochon","meth","methpure","opium","opium_pochon","lsd","lsd_pochon","cokeq","cokeq_pochon","weedq1","weddq_pochon","medoc","resine","resine_pochon","ipad","airpods","jouer","tvsamsmung","ordip","iphonex","chrgportable","cgnvidia","montreluxe"},
        [2] = {"WEAPON_DAGGER", "WEAPON_MACHETE", "WEAPON_BOTTLE", "WEAPON_CROWBAR", "WEAPON_HATCHET", "WEAPON_KNUCKLE", "WEAPON_WRENCH", "WEAPON_BATTLEAXE", "WEAPON_POOLCUE", "WEAPON_PISTOL","WEAPON_VINTAGEPISTOL","WEAPON_HEAVYPISTOL","WEAPON_DOUBLEACTION","WEAPON_MICROSMG","WEAPON_MACHINEPISTOL","WEAPON_MINISMG","WEAPON_COMBATPDW","WEAPON_ASSAULTSMG","WEAPON_SAWNOFFSHOTGUN","WEAPON_DBSHOTGUN","WEAPON_BULLPUPSHOTGUN","WEAPON_AUTOSHOTGUN","WEAPON_BULLPUPRIFLE","WEAPON_SPECIALCARBINE","WEAPON_COMPACTRIFLE","WEAPON_GUSENBERG","WEAPON_MOLOTOV","WEAPON_FLARE","WEAPON_ASSAULTRIFLE"},
    }
}

RegisterNetEvent('sunny:client:addPoliceBlip')
AddEventHandler('sunny:client:addPoliceBlip', function(coords, code)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    local color = 2
    if code == '10-2' then
        color = 5
    elseif code == '10-3' then
        color = 17
    elseif code == '10-4' then
        color = 1
    end

    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 1.2)
    SetBlipColour(blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Code " .. code)
    EndTextCommandSetBlipName(blip)

    Citizen.SetTimeout(20000, function()
        RemoveBlip(blip)
    end)
end)

local timerRenfort = true
function Police_openVestiaire()
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
            RageUI.WLine()
            for k,v in pairs(SunnyLSPD.Police.cloakroom) do
                RageUI.Button(v.label, nil, {RightLabel = '>>'}, ESX.PlayerData.job.grade >= v.required_grade, {
                    onSelected = function()
                        local model = GetEntityModel(PlayerPedId())
    
                        if model == `mp_m_freemode_01` then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadClothes', skin, v.Data.homme)
                            end) 
                        elseif model ~= `mp_f_freemode_01` then
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

function radar(value)
    if value == true then
        local playerPed = PlayerPedId()
    else

    end
end

exports('getLSPDSERVICE', function()
    return SunnyLSPD.Police.Service
end)

local CallsTable = {}
function Police_openF6()
    local main = RageUI.CreateMenu('', 'Menu Intéractions')
    local interactMenu = RageUI.CreateSubMenu(main, '', 'Menu Intéractions')
    local billMenu = RageUI.CreateSubMenu(interactMenu, '', 'Menu Amendes')
    local fouilleMenu = RageUI.CreateSubMenu(interactMenu, '', 'Menu Fouille')
    local vehicleMenu = RageUI.CreateSubMenu(main, '', 'Menu Intéractions Véhicule')
    local vehicleInfoWithPlate = RageUI.CreateSubMenu(vehicleMenu, '', 'Menu Intéractions Véhicule')
    local dogMenu = RageUI.CreateSubMenu(main, '', 'Menu K9')
    local code = RageUI.CreateSubMenu(main, '', 'Menu Codes Radio')
    local AppelTakeMenu = RageUI.CreateSubMenu(main, "", "Alerte Drogues")
    local playerAmender = RageUI.CreateSubMenu(interactMenu, '', 'Amendes impayées')
    local drugsAlerte = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    
    local cbVehicle = {}
    local CallsTable = {}
    local CallInfo = {coords = {}, raison = '', id = nil}
    local timerRenfort = true
    local playerAmende = {}

    vehicleInfoWithPlate.Closed = function()
        ClearPedTasks(PlayerPedId())
    end

    ESX.TriggerServerCallback('sunny:appelRetreive:job', function(calls)
        CallsTable = calls
    end)

    RageUI.Visible(main, not RageUI.Visible(main))
    
    while true do
        Wait(1)
        
        RageUI.IsVisible(main, function()
            RageUI.Checkbox('Statut de l\'entreprise', 'Quand cette case est cochée votre ENTREPRISE est notée comme ouverte', Society.List[ESX.PlayerData.job.name].state, {}, {
                onChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                end,
                onUnChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                end
            })
            RageUI.Checkbox('Service LSPD', nil, SunnyLSPD.Police.Service, {}, {
                onChecked = function()
                    SunnyLSPD.Police.Service = true
                    TriggerServerEvent('sunny:LSPD:service')
                end,
                onUnChecked = function()
                    SunnyLSPD.Police.Service = false
                    TriggerServerEvent('sunny:LSPD:service')
                end
            })
    
            if SunnyLSPD.Police.Service then
                RageUI.Button("Montrer son badge", nil, {}, true, {
                    onSelected = function()
                        ShowJobBadge(ESX.PlayerData.job.name)
                    end
                })
                RageUI.Button('Intéractions avec une personne', nil, {}, true, {}, interactMenu)
                RageUI.Button('Intéractions avec un véhicule', nil, {}, true, {}, vehicleMenu)
                RageUI.Button('Ouvrir la MDT', nil, {}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        ExecuteCommand('mdt')
                    end
                })
                RageUI.Button('Intéractions K9', nil, {}, true, {}, dogMenu)
                RageUI.Button('Codes', nil, {}, true, {}, code)
                RageUI.Button("Alertes", nil, {RightLabel = ("%s appels"):format(#CallsTable)}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('sunny:appelRetreive:job', function(calls)
                            CallsTable = calls
                            RageUI.Visible(drugsAlerte, true)
                        end)
                    end
                }, drugsAlerte)
    
                RageUI.Checkbox('Radar', nil, SunnyLSPD.Police.radar, {}, {
                    onChecked = function()
                        SunnyLSPD.Police.radar = true
                        TriggerEvent('police:POLICE_radar')
                        TriggerServerEvent('sunny:police:radar', true)
                    end,
                    onUnChecked = function()
                        SunnyLSPD.Police.radar = false
                        TriggerEvent('police:POLICE_radar')
                        TriggerServerEvent('sunny:police:radar', false)
                    end
                })
    
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
    
        RageUI.IsVisible(drugsAlerte, function()
            if #CallsTable == 0 then
                RageUI.Separator('~r~Aucun appel en cours')
            else
                RageUI.Button('Vider la liste des appels', nil, {RightLabel = "⚠️"}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        TriggerServerEvent('sunny:bande:clearlatable')
                        CallsTable = {}
                    end
                })
        
                RageUI.Line()
        
                for k, v in pairs(CallsTable) do
                    RageUI.Button('#'..k..' '..v.raison, nil, {RightLabel = '>'}, true, {
                        onSelected = function()
                            CallInfo.coords = v.pos 
                            CallInfo.raison = v.raison
                            CallInfo.id = v.id
                        end
                    }, AppelTakeMenu)
                end
            end
        end)
    
        RageUI.IsVisible(AppelTakeMenu, function()
            RageUI.Button('Prendre l\'appel', nil, {}, true, {
                onSelected = function()
                    SetNewWaypoint(CallInfo.coords.x, CallInfo.coords.y)
                end
            })
            RageUI.Button('Supprimer l\'appel', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:appelDelete:job', CallInfo.id)
                    ESX.TriggerServerCallback('sunny:appelRetreive:job', function(calls)
                        CallsTable = calls
                    end)
                end
            })
        end)
    
        RageUI.IsVisible(interactMenu, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            RageUI.Button("Carte d'identité", nil, {}, true, {
                onSelected = function()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('Police:ForcerId', GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })
            RageUI.Button("Permis", nil, {}, true, {
                onSelected = function()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('Police:ForcerDrive', GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            RageUI.Button('Mettre une amende', nil, {}, true, {
                onSelected = function()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        KeyboardUtils.use('Montant', function(data)
                            local data = tonumber(data)
                            if data == nil or data <= 0 then return end

                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_'..ESX.PlayerData.job.name, (ESX.PlayerData.job.label), data)
                        end)
                    else
                        ESX.ShowNotification("Aucun joueur à proximité")
                    end
                end
            })   
            
            RageUI.Button('Vérifier les amendes impayé', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then 
                        ESX.ShowNotification('Personne aux alentours')
                        return 
                    end

                    playerAmende = {}

                    ESX.TriggerServerCallback('sunny:police:amendes', function(cb)
                        if cb and #cb > 0 then
                            playerAmende = cb
                            RageUI.Visible(playerAmender, true)
                        else
                            ESX.ShowNotification("~b~Information~s~: Cette personne n'a pas d'amendes impayées")
                        end
                    end, GetPlayerServerId(closestPlayer))
                end
            })

            RageUI.Button('Fouiller', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                    if ESX.isHandsUp(GetPlayerPed(closestPlayer)) then
                        -- Adaptation pour ox_inventory
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            exports.ox_inventory:openInventory('player', GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification('~r~Aucun joueur à proximité')
                        end
                    else
                        return ESX.ShowNotification('🤚✋La personne doit ~r~lever les mains~s~ pour être fouiller')
                    end
                end
            })
            RageUI.Button('Menotter/Demenotter', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                    TriggerServerEvent('sunny:police:menotter', GetPlayerServerId(closestPlayer))
                end
            })
            RageUI.Button('Escorter', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                    TriggerServerEvent('sunny:police:escoter', GetPlayerServerId(closestPlayer))
                end
            })
            RageUI.Button('Mettre dans le véhicule', nil, {}, true, {
                onSelected = function()
                    if closestDistance == -1 or closestDistance > 3 then
                        return ESX.ShowNotification('Personne aux alentours')
                    end
                    TriggerServerEvent('sunny:police:putinvehicule', GetPlayerServerId(closestPlayer))
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
                                TriggerServerEvent('sunny:police:ppa', GetPlayerServerId(closestPlayer))
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
                    TriggerServerEvent('Police:ForcerPPA', GetPlayerServerId(closestPlayer))
                end
            })
        end)   
    
        RageUI.IsVisible(vehicleMenu, function()
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
        
            if vehicle then
                RageUI.Button('Vérifier la plaque', nil, {}, true, {
                    onSelected = function()
                        local getVeh = ESX.Game.GetVehicleProperties(ESX.Game.GetVehicleInDirection())
                        LSPD.VehiculeInfos = nil
                        ESX.TriggerServerCallback('sunny:getVehiculehInfos', function(Infos)
                            LSPD.VehiculeInfos = Infos
                        end, getVeh.plate, GetDisplayNameFromVehicleModel(getVeh.model))
        
                        waitingForPlaque = true
        
                        if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                            LoadAnimDict("amb@code_human_police_investigate@idle_a")
                            TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0)
                        end
                    end
                }, vehicleInfoWithPlate)
        
                RageUI.Button("Crocheter le véhicule", nil, {}, true, {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        local vehicle = ESX.Game.GetVehicleInDirection()
                
                        if DoesEntityExist(vehicle) then
                            LoadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                            TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, 2000, 1, 0, false, false, false)
                
                            ESX.ShowNotification("~y~Crochetage en cours...")
                            Wait(5000)
                
                            SetVehicleDoorsLocked(vehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                
                            ClearPedTasks(playerPed)
                
                            ESX.ShowNotification("~g~Véhicule déverrouillé avec succès.")
                        else
                            ESX.ShowNotification("~r~Aucun véhicule à proximité.")
                        end
                    end
                })
                


                RageUI.Button('Mettre en fourrière', nil, {}, true, {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        local vehicleToImpound = ESX.Game.GetVehicleInDirection()
        
                        if DoesEntityExist(vehicleToImpound) then
                            ExecuteCommand("e notepad2")
        
                            ESX.ShowNotification("~b~Mise en fourrière du véhicule en cours...")
        
                            Wait(10000)
        
                            ESX.Game.DeleteVehicle(vehicleToImpound)
        
                            ClearPedTasksImmediately(playerPed)
        
                            ESX.ShowNotification("~g~Le véhicule a été mis en fourrière avec succès.")
                        else
                            ESX.ShowNotification("~r~Aucun véhicule trouvé.")
                        end
                    end
                })
            end
        end)
        
        
    
        RageUI.IsVisible(vehicleInfoWithPlate, function()
        if LSPD.VehiculeInfos then
            if LSPD.VehiculeInfos.plate == nil then
                RageUI.Separator("")
                RageUI.Separator("~r~Aucun véhicule à proximité !")
                RageUI.Separator("")
            else
                if waitingForPlaque then
                    TriggerEvent("sunny:waitingForPlaque")                               
                    RageUI.Separator("")
                    RageUI.Separator("~p~Vérification des informations...")
                    RageUI.Separator("")
                end
                local owner = ""
                if not LSPD.VehiculeInfos.owner then owner = "Inconnu" else owner = LSPD.VehiculeInfos.owner end
                if not waitingForPlaque then
                    RageUI.Separator("~p~Propriétaire du véhicule : ~s~"..owner)
                    RageUI.Separator("~p~Model du véhicule : ~s~"..LSPD.VehiculeInfos.model)
                    RageUI.Separator("~p~Plaque d'imatriculation : ~s~"..LSPD.VehiculeInfos.plate)
                end
            end
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
            RageUI.Button('Code 10-10 : Renfort nécessaire - Intervention immédiate', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:codes', '10-10')
                end
            })
        
            RageUI.Button('Code 10-11 : Renfort nécessaire - Contrôle routier', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:codes', '10-11')
                end
            })
        
            RageUI.Button('Code 10-12 : Renfort nécessaire - Support supplémentaire', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:codes', '10-12')
                end
            })
        
            RageUI.Button('Code 10-13 : Renfort nécessaire - Urgence extrême', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:codes', '10-13')
                end
            })
        end)        
    
        if not RageUI.Visible(main) and not RageUI.Visible(interactMenu) and not RageUI.Visible(vehicleMenu) and not RageUI.Visible(fouilleMenu) and not RageUI.Visible(billMenu) and not RageUI.Visible(dogMenu) and not RageUI.Visible(code) and not RageUI.Visible(drugsAlerte) and not RageUI.Visible(AppelTakeMenu) and not RageUI.Visible(vehicleInfoWithPlate) then
            break
        end
    end
end


function Police_OpenaccueilMenu()
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
                    ESX.TriggerServerCallback('sunny:police:plainte:get', function(cb)
                        SunnyLSPD.Police.complaint.archives = cb

                        RageUI.Visible(archives, true)
                    end)
                end
            })
        end)

        RageUI.IsVisible(registerPlaint, function()
            RageUI.Button('Date', nil, {RightLabel = SunnyLSPD.Police.complaint.date or ''},  true, {
                onSelected = function()
                    KeyboardUtils.use('Entrer une date', function(data)
                        if data == nil or data == '' then return end
                        SunnyLSPD.Police.complaint.date = data
                    end)
                end
            })
            RageUI.Button('Nom/Prénom de la personne', nil, {RightLabel = SunnyLSPD.Police.complaint.name or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom/Prénom de la personne', function(data)
                        if data == nil or data == '' then return end
                        SunnyLSPD.Police.complaint.name = data
                    end)
                end
            })
            RageUI.Button('Numéro de téléphone de la personne', nil, {RightLabel = SunnyLSPD.Police.complaint.numberphone or ''}, true , {
                onSelected = function()
                    KeyboardUtils.use('Numéro de téléphonem de la personne', function(data)
                        if data == nil or data == '' then return end
                        SunnyLSPD.Police.complaint.numberphone = data
                    end)
                end
            })
            RageUI.Button('Raison/Description de la plainte', nil, {RightLabel = SunnyLSPD.Police.complaint.reason or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Raison/Description de la plainte', function(data)
                        if data == nil or data == '' then return end
                        SunnyLSPD.Police.complaint.reason = data
                    end)
                end
            })
            RageUI.WLine()
            RageUI.Button('Confirmer', nil, {}, true, {
                onSelected = function()
                    if SunnyLSPD.Police.complaint.date == nil or SunnyLSPD.Police.complaint.name == nil or SunnyLSPD.Police.complaint.numberphone == nil or SunnyLSPD.Police.complaint.reason == nil then return ESX.ShowNotification('Toutes les informations ne sont pas correctement complétés') end

                    TriggerServerEvent('sunny:police:plainte:register', SunnyLSPD.Police.complaint)
                end
            })
        end)

        RageUI.IsVisible(archives, function()
            for k,v in pairs(SunnyLSPD.Police.complaint.archives) do
                RageUI.Button(('%s - %s'):format(v.id, v.name), v.reason, {}, true, {
                    onSelected = function()
                        SunnyLSPD.Police.complaint.archivesSelected = v
                        RageUI.Visible(archivesSelected, true)
                    end
                })
            end
        end)

        RageUI.IsVisible(archivesSelected, function()
            RageUI.Separator(('Archive %s - %s'):format(SunnyLSPD.Police.complaint.archivesSelected.id, SunnyLSPD.Police.complaint.archivesSelected.name))
            RageUI.Separator(('Nom/Prenom %s'):format(SunnyLSPD.Police.complaint.archivesSelected.name))
            RageUI.Button('Raison de la plainte', SunnyLSPD.Police.complaint.archivesSelected.reason, {}, true, {
                onActive = function()
                    RageUI.Info('Informations', {SunnyLSPD.Police.complaint.archivesSelected.reason}, {})
                end,
                onSelected = function()
                    
                end
            })
            RageUI.WLine()
            RageUI.Button('Changer la raison', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouvelle raison', function(data)
                        if data == nil then return end

                        TriggerServerEvent('sunny:police:plainte:editReason', SunnyLSPD.Police.complaint.archivesSelected.id, data)

                        SunnyLSPD.Police.complaint.archivesSelected.reason = data
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
                                TriggerServerEvent('sunny:police:plainte:delete', SunnyLSPD.Police.complaint.archivesSelected.id)
                                RageUI.Visible(archivesSelected, false)
                                RageUI.Visible(archives, false)
                                RageUI.Visible(main, true)
                                ESX.ShowNotification('Archive supprimée avec succès')
                            else
                                ESX.ShowNotification('Action annulée') 
                            end
                        end
                    )
                end
            })
            
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(registerPlaint) and not RageUI.Visible(archives) and not RageUI.Visible(archivesSelected) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end

RegisterNetEvent('sunny:police:putinvehicule', function(targetId)
    local playerPed = GetPlayerPed(GetPlayerFromServerId(targetId))
    local vehicle = ESX.Game.GetClosestVehicle()

    if DoesEntityExist(vehicle) then
        local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)

        for i = maxSeats - 1, 0, -1 do
            if IsVehicleSeatFree(vehicle, i) then
                TaskWarpPedIntoVehicle(playerPed, vehicle, i)
                ESX.ShowNotification('La personne a été mise dans le véhicule')
                return
            end
        end
        ESX.ShowNotification('Il n\'y a pas de place disponible dans ce véhicule')
    else
        ESX.ShowNotification('Aucun véhicule à proximité')
    end
end)

RegisterNetEvent('sunny:police:renforts', function(coords, raison)
    if ESX.PlayerData.job.name ~= 'police' then return end
    if not SunnyLSPD.Police.Service then return end

    if raison == 'petite' then
        print('renfort after petite')
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
        ESX.ShowAdvancedNotification('Centrale LSPD', SunnyConfigServ.GTACOLOR..'Demande de renfort', 'Demande de renfort demandé.\nRéponse : ~g~CODE-2\n~w~Importance : ~g~Légère.', 'CHAR_CALL911', 0)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        color = 2
    elseif raison == 'importante' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
        ESX.ShowAdvancedNotification('Centrale LSPD', SunnyConfigServ.GTACOLOR..'Demande de renfort', 'Demande de renfort demandé.\nRéponse : ~g~CODE-3\n~w~Importance : ~b~Importante.', 'CHAR_CALL911', 0)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        color = 47
    elseif raison == 'omgad' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
        PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
        ESX.ShowAdvancedNotification('Centrale LSPD', SunnyConfigServ.GTACOLOR..'Demande de renfort', 'Demande de renfort demandé.\nRéponse : ~g~CODE-99\n~w~Importance : ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CALL911', 0)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
        color = 1
    end
    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Demande renfort')
    EndTextCommandSetBlipName(blipId)
    Wait(80 * 1000)
    RemoveBlip(blipId)
end)

function Police_OpenWeaponMenu()
    local main = RageUI.CreateMenu('', 'Actions Disponibles')
    local ammunition = RageUI.CreateSubMenu(main, '', 'Munitions')

    RageUI.Visible(main, not RageUI.Visible(main))
    while main do Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Button('Rendre ses armes de service', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:police.removeWeapon', SunnyLSPD.Police.weapons)
                end
            })
            RageUI.Button('Rendre ses munitions', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:police.removeAmmo')
                end
            })
            RageUI.Button('Tout rendre', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:police.removeAll')
                end
            })
            RageUI.WLine()
            for k,v in pairs(SunnyLSPD.Police.weapons) do
                RageUI.Button(v.label, nil, {RightLabel = '>>'}, ESX.PlayerData.job.grade >= v.required_grade, {
                    onSelected = function()
                        TriggerServerEvent('sunny:police:giveweapon', v.name, v.label)
                    end
                })
            end
            RageUI.WLine()
            RageUI.Button('Munitions', nil, {RightLabel = '>>'}, true, {
                onSelected = function()
                    
                end
            }, ammunition)
        end)

        RageUI.IsVisible(ammunition, function()
            for k,v in pairs(SunnyLSPD.Police.ammunition) do
                RageUI.Button(v.label, nil, {RightLabel = '>>'}, ESX.PlayerData.job.grade >= v.required_grade, {
                    onSelected = function()
                        TriggerServerEvent('sunny:police:giveammo', v.name, v.label, v.quantity)
                    end
                })
            end
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(ammunition) then
            main = RMenu:DeleteType('main')
        end
    end
end

RegisterCommand('F6_Police', function()
    if ESX.PlayerData.job.name ~= 'police' then return end

    Police_openF6()
end)
RegisterKeyMapping('F6_Police', 'Menu Intéractions LSPD', 'keyboard', 'F6')

RegisterNetEvent('sunny:police:menotter', function()
    SunnyLSPD.Police.HandCuffed = not SunnyLSPD.Police.HandCuffed
    local playerPed = GetPlayerPed(-1)

    Citizen.CreateThread(function()
        if SunnyLSPD.Police.HandCuffed then
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end

            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

            local officerPed = GetPlayerPed(GetPlayerFromServerId(source))
            TaskPlayAnim(officerPed, 'mp_arresting', 'arrest_a', 8.0, -8, 3000, 0, 0, 0, 0, 0)

            while SunnyLSPD.Police.HandCuffed == true do
                Wait(0)
                SetPedCanBeDraggedOut(GetPlayerPed(-1), false)
                DisableControlAction(27, 75, true)
                DisableControlAction(0, 23, true)
                DisableControlAction(2, 37, true)
                SetEnableHandcuffs(playerPed, true)
                SetPedCanPlayGestureAnims(playerPed, false)
                FreezeEntityPosition(playerPed, true)
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
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end

            local officerPed = GetPlayerPed(GetPlayerFromServerId(source))
            TaskPlayAnim(officerPed, 'mp_arresting', 'b_uncuff', 8.0, -8, 3000, 0, 0, 0, 0, 0)

            Citizen.Wait(3000)

            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
            FreezeEntityPosition(playerPed, false)
            RageUI.setKeyState(21, false)
            RageUI.setKeyState(22, false)
            ExecuteCommand(('walk %s'):format(getWalkStyle()))
        end
    end)
end)

local isEscort = false
local playerSRCEscorte = nil
RegisterNetEvent("sunny:police:escoter", function(player)
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

RegisterNetEvent('sunny:police:playerVehicle', function(veh, value)
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
    -- AddZones('cloakroom', {
    --     Position = SunnyLSPD.Police.Position.cloakroom,
    --     Dist = 10,
    --     Public = false,
    --     Job = {['police'] = true},
    --     Job2 = {},
    --     GradesJob = {},
    --     InVehicleDisable = true,
    --     Blip = {
    --         Active = false,
    --         -- Position = vector3(2329.95, 2569.936, 46.67976),
    --         -- BlipId = 784,
    --         -- Color = 1,
    --         -- Scale = 0.6,
    --         -- Text = '[ILLEGAL] Craft D\'arme'
    --     },
    --     marker = true,
    --     ActionText = 'pour intéragir',
    --     Action = function()
    --         Police_openVestiaire()
    --     end
    -- })
    
    AddZones('weapons_menu', {
        Position = SunnyLSPD.Police.Position.armory,
        Dist = 10,
        Public = false,
        Job = {['police'] = true},
        Job2 = {},
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = true,
            Position = vector3(2329.95, 2569.936, 46.67976),
            BlipId = 784,
            Color = 1,
            Scale = 0.6,
            Text = '[ILLEGAL] Craft D\'arme'
        },
        marker = true,
        ActionText = 'Armurerie LSPD',
        Action = function()
            Police_OpenWeaponMenu()
        end
    })

    AddZones('weapons_menu_gouv', {
        Position = vector3(-1301.275269, -556.947510, 30.566780),
        Dist = 10,
        Public = false,
        Job = {['gouvernement'] = true},
        Job2 = {},
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = false,
            Position = vector3(2329.95, 2569.936, 46.67976),
            BlipId = 784,
            Color = 1,
            Scale = 0.6,
            Text = '[ILLEGAL] Craft D\'arme'
        },
        marker = true,
        ActionText = 'Armurerie gouvernementale',
        Action = function()
            Police_OpenWeaponMenu()
        end
    })
    _PEDS.addPed('craft_weapons', {
        model = 'csb_talcc',
        position = vector3(2329.95, 2569.936, 46.67976),
        heading = 340.12387084961,
        scenario = {
            active = false,
            name = 'WORLD_HUMAN_CLIPBOARD',
            count = 0,
        },
        weapon = {
            active = true,
            weaponName = 'weapon_assaultrifle',
        },
        floatingText = {
            active = true,
            text = 'Nay',
            color = 34,
        },
    })
end)

RegisterNetEvent('sunny:police:sendCode', function()
    if ESX.PlayerData.job.name ~= 'police' then return end
    if not SunnyLSPD.Police.Service then return end
    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
    PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
end)

local last = {}

RegisterNetEvent('sunny:police:callDrugs', function(data)
    if ESX.PlayerData.job.name ~= 'police' then return end
    if not SunnyLSPD.Police.Service then return end
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


